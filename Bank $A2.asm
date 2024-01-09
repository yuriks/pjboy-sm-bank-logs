;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687..8911: Bouncing gooball ;;;
{
;;; $8687: Palette - enemy $CEBF (bouncing gooball) ;;;
{
$A2:8687             dw 3800, 4BBE, 06B9, 00EA, 0065, 173A, 0276, 01F2, 014D, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $86A7..DE: Instruction lists - bouncing gooball ;;;
{
;;; $86A7: Instruction list -  ;;;
{
$A2:86A7             dx 817D,       ; Disable off-screen processing
                        88C5        ; Nothing
$A2:86AB             dx 000A,88DA,
                        000A,88E1,
                        000A,88E8,
                        000A,88E1,
                        80ED,86AB   ; Go to $86AB
}


;;; $86BF: Instruction list -  ;;;
{
$A2:86BF             dx 8173,       ; Enable off-screen processing
                        88C6        ; ???
$A2:86C3             dx 0005,88EF,
                        0005,88F6,
                        0005,88FD,
                        0005,8904,
                        0005,88FD,
                        0005,88F6,
                        80ED,86C3   ; Go to $86C3
}
}


;;; $86DF:  ;;;
{
$A2:86DF             dw 0001, 0002, 0004, 0008, 000A, 000D, 0010, 0014
}


;;; $86EF:  ;;;
{
$A2:86EF             dw 3000, 4000, 5000, 6000, 7000, 8000, 9000, A000, B000
}


;;; $8701:  ;;;
{
$A2:8701             db 00, 01, 03, 06, 0A, 0F, 15, 1C, 24, 2D, 37, 42, 4E, 5B, 69, 78, 88, 99, AB, BE, D2, E7, FD
}


;;; $8718:  ;;;
{
$A2:8718             dw 8801, 8850
}


;;; $871C: Initialisation AI - enemy $CEBF (bouncing gooball) ;;;
{
$A2:871C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:871F A9 4D 80    LDA #$804D
$A2:8722 9D 8E 0F    STA $0F8E,x[$7E:0F8E]
$A2:8725 20 9F 88    JSR $889F  [$A2:889F]
$A2:8728 A9 01 00    LDA #$0001
$A2:872B 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:872F BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:8732 29 FF 00    AND #$00FF
$A2:8735 0A          ASL A
$A2:8736 A8          TAY
$A2:8737 B9 DF 86    LDA $86DF,y[$A2:86E5]
$A2:873A 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:873D BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A2:8740 29 FF 00    AND #$00FF
$A2:8743 0A          ASL A
$A2:8744 A8          TAY
$A2:8745 B9 EF 86    LDA $86EF,y[$A2:86EF]
$A2:8748 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:874B 9E AE 0F    STZ $0FAE,x[$7E:0FAE]
$A2:874E 9E B0 0F    STZ $0FB0,x[$7E:0FB0]
$A2:8751 9E B2 0F    STZ $0FB2,x[$7E:0FB2]
$A2:8754 6B          RTL
}


;;; $8755:  ;;;
{
$A2:8755 08          PHP

$A2:8756 BC B0 0F    LDY $0FB0,x[$7E:0FB0]
$A2:8759 E2 20       SEP #$20
$A2:875B B9 01 87    LDA $8701,y[$A2:8701]
$A2:875E C0 17 00    CPY #$0017
$A2:8761 30 02       BMI $02    [$8765]
$A2:8763 A9 FF       LDA #$FF

$A2:8765 8D 02 42    STA $4202  [$7E:4202]
$A2:8768 BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A2:876B 8D 03 42    STA $4203  [$7E:4203]
$A2:876E EA          NOP
$A2:876F EA          NOP
$A2:8770 EA          NOP
$A2:8771 C2 20       REP #$20
$A2:8773 AD 16 42    LDA $4216  [$7E:4216]
$A2:8776 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A2:8779 18          CLC
$A2:877A 7D AE 0F    ADC $0FAE,x[$7E:0FAE]
$A2:877D 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:8780 FE B0 0F    INC $0FB0,x[$7E:0FB0]
$A2:8783 DD AC 0F    CMP $0FAC,x[$7E:0FAC]
$A2:8786 30 CE       BMI $CE    [$8756]
$A2:8788 BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A2:878B 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:878F A9 01 00    LDA #$0001
$A2:8792 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:8796 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A2:879A 28          PLP
$A2:879B 60          RTS
}


;;; $879C: Main AI - enemy $CEBF (bouncing gooball) ;;;
{
$A2:879C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:879F BF 0A 78 7E LDA $7E780A,x[$7E:780A]
$A2:87A3 D0 0B       BNE $0B    [$87B0]
$A2:87A5 20 55 87    JSR $8755  [$A2:8755]
$A2:87A8 A9 01 00    LDA #$0001
$A2:87AB 9F 0A 78 7E STA $7E780A,x[$7E:780A]
$A2:87AF 6B          RTL

$A2:87B0 BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A2:87B3 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A2:87B7 20 94 88    JSR $8894  [$A2:8894]
$A2:87BA D0 18       BNE $18    [$87D4]
$A2:87BC BF 04 78 7E LDA $7E7804,x[$7E:7804]
$A2:87C0 F0 2B       BEQ $2B    [$87ED]
$A2:87C2 BF 08 78 7E LDA $7E7808,x[$7E:7808]
$A2:87C6 D0 38       BNE $38    [$8800]
$A2:87C8 A9 01 00    LDA #$0001
$A2:87CB 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A2:87CF 20 9F 88    JSR $889F  [$A2:889F]
$A2:87D2 80 2C       BRA $2C    [$8800]

$A2:87D4 A9 00 00    LDA #$0000
$A2:87D7 9F 04 78 7E STA $7E7804,x[$7E:7844]
$A2:87DB 9F 08 78 7E STA $7E7808,x[$7E:7848]
$A2:87DF BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A2:87E2 D0 09       BNE $09    [$87ED]
$A2:87E4 A9 01 00    LDA #$0001
$A2:87E7 9D B2 0F    STA $0FB2,x[$7E:0FF2]
$A2:87EA 20 B2 88    JSR $88B2  [$A2:88B2]

$A2:87ED AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:87F0 BF 06 78 7E LDA $7E7806,x[$7E:7846]
$A2:87F4 9D A8 0F    STA $0FA8,x[$7E:0FE8]
$A2:87F7 BF 02 78 7E LDA $7E7802,x[$7E:7842]
$A2:87FB 0A          ASL A
$A2:87FC AA          TAX
$A2:87FD FC 18 87    JSR ($8718,x)[$A2:8850]

$A2:8800 6B          RTL
}


;;; $8801:  ;;;
{
$A2:8801 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8804 FE B0 0F    INC $0FB0,x[$7E:0FF0]
$A2:8807 BC B0 0F    LDY $0FB0,x[$7E:0FF0]
$A2:880A E2 20       SEP #$20
$A2:880C B9 01 87    LDA $8701,y[$A2:8701]
$A2:880F C0 17 00    CPY #$0017
$A2:8812 30 02       BMI $02    [$8816]
$A2:8814 A9 FF       LDA #$FF

$A2:8816 8D 02 42    STA $4202  [$7E:4202]
$A2:8819 BD A8 0F    LDA $0FA8,x[$7E:0FE8]
$A2:881C 8D 03 42    STA $4203  [$7E:4203]
$A2:881F EA          NOP
$A2:8820 EA          NOP
$A2:8821 EA          NOP
$A2:8822 C2 20       REP #$20
$A2:8824 AD 16 42    LDA $4216  [$7E:4216]
$A2:8827 9D AA 0F    STA $0FAA,x[$7E:0FEA]
$A2:882A EB          XBA
$A2:882B 29 FF 00    AND #$00FF
$A2:882E 18          CLC
$A2:882F 7D 7E 0F    ADC $0F7E,x[$7E:0FBE]
$A2:8832 9D 7E 0F    STA $0F7E,x[$7E:0FBE]
$A2:8835 BD B0 0F    LDA $0FB0,x[$7E:0FF0]
$A2:8838 DF 00 78 7E CMP $7E7800,x[$7E:7840]
$A2:883C 30 11       BMI $11    [$884F]
$A2:883E A9 01 00    LDA #$0001
$A2:8841 9F 02 78 7E STA $7E7802,x[$7E:7842]
$A2:8845 A9 01 00    LDA #$0001
$A2:8848 9F 04 78 7E STA $7E7804,x[$7E:7844]
$A2:884C 9E B2 0F    STZ $0FB2,x[$7E:0FF2]

$A2:884F 60          RTS
}


;;; $8850:  ;;;
{
$A2:8850 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8853 BC B0 0F    LDY $0FB0,x[$7E:0FF0]
$A2:8856 E2 20       SEP #$20
$A2:8858 B9 01 87    LDA $8701,y[$A2:8716]
$A2:885B C0 17 00    CPY #$0017
$A2:885E 30 02       BMI $02    [$8862]
$A2:8860 A9 FF       LDA #$FF

$A2:8862 8D 02 42    STA $4202  [$7E:4202]
$A2:8865 BD A8 0F    LDA $0FA8,x[$7E:0FE8]
$A2:8868 8D 03 42    STA $4203  [$7E:4203]
$A2:886B EA          NOP
$A2:886C EA          NOP
$A2:886D EA          NOP
$A2:886E C2 20       REP #$20
$A2:8870 AD 16 42    LDA $4216  [$7E:4216]
$A2:8873 9D AA 0F    STA $0FAA,x[$7E:0FEA]
$A2:8876 EB          XBA
$A2:8877 29 FF 00    AND #$00FF
$A2:887A 49 FF FF    EOR #$FFFF
$A2:887D 1A          INC A
$A2:887E 18          CLC
$A2:887F 7D 7E 0F    ADC $0F7E,x[$7E:0FBE]
$A2:8882 9D 7E 0F    STA $0F7E,x[$7E:0FBE]
$A2:8885 DE B0 0F    DEC $0FB0,x[$7E:0FF0]
$A2:8888 30 02       BMI $02    [$888C]
$A2:888A 80 07       BRA $07    [$8893]

$A2:888C A9 00 00    LDA #$0000
$A2:888F 9F 02 78 7E STA $7E7802,x[$7E:7842]

$A2:8893 60          RTS
}


;;; $8894:  ;;;
{
$A2:8894 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8897 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A2:889A 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:889E 60          RTS
}


;;; $889F:  ;;;
{
$A2:889F AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:88A2 A9 A7 86    LDA #$86A7
$A2:88A5 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:88A8 A9 01 00    LDA #$0001
$A2:88AB 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:88AE 9E 90 0F    STZ $0F90,x[$7E:0F90]
$A2:88B1 60          RTS
}


;;; $88B2:  ;;;
{
$A2:88B2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:88B5 A9 BF 86    LDA #$86BF
$A2:88B8 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A2:88BB A9 01 00    LDA #$0001
$A2:88BE 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A2:88C1 9E 90 0F    STZ $0F90,x[$7E:0FD0]
$A2:88C4 60          RTS
}


;;; $88C5: Instruction - nothing ;;;
{
$A2:88C5 6B          RTL
}


;;; $88C6: Instruction -  ;;;
{
$A2:88C6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:88C9 A9 00 00    LDA #$0000
$A2:88CC 9F 04 78 7E STA $7E7804,x[$7E:7844]
$A2:88D0 A9 0E 00    LDA #$000E             ;\
$A2:88D3 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound Eh, sound library 2, max queued sounds allowed = 6 (splashed out of water)
$A2:88D7 6B          RTL
}


;;; $88D8: RTL ;;;
{
$A2:88D8 6B          RTL
}


;;; $88D9: RTL ;;;
{
$A2:88D9 6B          RTL
}


;;; $88DA: Spritemaps - bouncing gooball ;;;
{
$A2:88DA             dx 0001, C3F8,F8,2100
$A2:88E1             dx 0001, C3F8,F8,2102
$A2:88E8             dx 0001, C3F8,F8,2104
$A2:88EF             dx 0001, C3F8,F8,2106
$A2:88F6             dx 0001, C3F8,F8,2108
$A2:88FD             dx 0001, C3F8,F8,210A
$A2:8904             dx 0001, C3F8,F8,210C
$A2:890B             dx 0001, C3F8,F8,210E
}
}


;;; $8912..8B5F: Mini-Crocomire ;;;
{
;;; $8912: Palette - enemy $CEFF (mini-Crocomire) ;;;
{
$A2:8912             dw 3800, 3DB3, 292E, 1486, 1840, 3D92, 38CA, 1C61, 24A7, 24A7, 2063, 1840, 0800, 0000, 0000, 0000
}


;;; $8932..7D: Instruction lists - mini-Crocomire ;;;
{
;;; $8932: Instruction list -  ;;;
{
$A2:8932             dw 8990        ; ???
$A2:8934             dw 0008,8ACA,
                        0010,8AD6,
                        0008,8AE7,
                        0008,8AF3,
                        80ED,8934   ; Go to $8934
}


;;; $8948: Instruction list -  ;;;
{
$A2:8948             dw 0010,8AE7,
                        897E,0000,  ; ???
                        0010,8AFF,
                        80ED,8932   ; Go to $8932
}


;;; $8958: Instruction list -  ;;;
{
$A2:8958             dw 899D        ; ???
$A2:895A             dw 0008,8B15,
                        0010,8B21,
                        0008,8B32,
                        0008,8B3E,
                        80ED,895A   ; Go to $895A
}


;;; $896E: Instruction list -  ;;;
{
$A2:896E             dw 0010,8B32,
                        897E,0001,  ; ???
                        0010,8B4A,
                        80ED,8958   ; Go to $8958
}
}


;;; $897E: Instruction ;;;
{
$A2:897E 5A          PHY
$A2:897F B9 00 00    LDA $0000,y
$A2:8982 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8985 A0 F2 DB    LDY #$DBF2             ;\
$A2:8988 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn enemy projectile $DBF2
$A2:898C 7A          PLY
$A2:898D C8          INY
$A2:898E C8          INY
$A2:898F 6B          RTL
}


;;; $8990: Instruction ;;;
{
$A2:8990 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8993 A9 43 8A    LDA #$8A43
$A2:8996 9D B2 0F    STA $0FB2,x
$A2:8999 9E B0 0F    STZ $0FB0,x
$A2:899C 6B          RTL
}


;;; $899D: Instruction ;;;
{
$A2:899D AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:89A0 A9 5C 8A    LDA #$8A5C
$A2:89A3 9D B2 0F    STA $0FB2,x
$A2:89A6 A9 01 00    LDA #$0001
$A2:89A9 9D B0 0F    STA $0FB0,x
$A2:89AC 6B          RTL
}


;;; $89AD: Initialisation AI - enemy $CEFF (mini-Crocomire) ;;;
{
$A2:89AD AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:89B0 A9 4D 80    LDA #$804D
$A2:89B3 9D 8E 0F    STA $0F8E,x
$A2:89B6 BD B6 0F    LDA $0FB6,x
$A2:89B9 0A          ASL A
$A2:89BA 0A          ASL A
$A2:89BB 0A          ASL A
$A2:89BC A8          TAY
$A2:89BD B9 87 81    LDA $8187,y
$A2:89C0 9D AA 0F    STA $0FAA,x
$A2:89C3 B9 89 81    LDA $8189,y
$A2:89C6 9D A8 0F    STA $0FA8,x
$A2:89C9 B9 8B 81    LDA $818B,y
$A2:89CC 9D AE 0F    STA $0FAE,x
$A2:89CF B9 8D 81    LDA $818D,y
$A2:89D2 9D AC 0F    STA $0FAC,x
$A2:89D5 20 F7 89    JSR $89F7  [$A2:89F7]
$A2:89D8 A9 43 8A    LDA #$8A43
$A2:89DB 9D B2 0F    STA $0FB2,x
$A2:89DE BD B4 0F    LDA $0FB4,x
$A2:89E1 9D B0 0F    STA $0FB0,x
$A2:89E4 F0 09       BEQ $09    [$89EF]
$A2:89E6 20 1D 8A    JSR $8A1D  [$A2:8A1D]
$A2:89E9 A9 5C 8A    LDA #$8A5C
$A2:89EC 9D B2 0F    STA $0FB2,x

$A2:89EF 6B          RTL
}


;;; $89F0: Main AI - enemy $CEFF (mini-Crocomire) ;;;
{
$A2:89F0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:89F3 FC B2 0F    JSR ($0FB2,x)
$A2:89F6 6B          RTL
}


;;; $89F7:  ;;;
{
$A2:89F7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:89FA A9 01 00    LDA #$0001
$A2:89FD 9D 94 0F    STA $0F94,x
$A2:8A00 9E 90 0F    STZ $0F90,x
$A2:8A03 A9 32 89    LDA #$8932
$A2:8A06 9D 92 0F    STA $0F92,x
$A2:8A09 60          RTS
}


;;; $8A0A:  ;;;
{
$A2:8A0A AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8A0D A9 01 00    LDA #$0001
$A2:8A10 9D 94 0F    STA $0F94,x
$A2:8A13 9E 90 0F    STZ $0F90,x
$A2:8A16 A9 48 89    LDA #$8948
$A2:8A19 9D 92 0F    STA $0F92,x
$A2:8A1C 60          RTS
}


;;; $8A1D:  ;;;
{
$A2:8A1D AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8A20 A9 01 00    LDA #$0001
$A2:8A23 9D 94 0F    STA $0F94,x
$A2:8A26 9E 90 0F    STZ $0F90,x
$A2:8A29 A9 58 89    LDA #$8958
$A2:8A2C 9D 92 0F    STA $0F92,x
$A2:8A2F 60          RTS
}


;;; $8A30:  ;;;
{
$A2:8A30 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8A33 A9 01 00    LDA #$0001
$A2:8A36 9D 94 0F    STA $0F94,x
$A2:8A39 9E 90 0F    STZ $0F90,x
$A2:8A3C A9 6E 89    LDA #$896E
$A2:8A3F 9D 92 0F    STA $0F92,x
$A2:8A42 60          RTS
}


;;; $8A43:  ;;;
{
$A2:8A43 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8A46 BD AE 0F    LDA $0FAE,x
$A2:8A49 85 14       STA $14    [$7E:0014]
$A2:8A4B BD AC 0F    LDA $0FAC,x
$A2:8A4E 85 12       STA $12    [$7E:0012]
$A2:8A50 20 76 8A    JSR $8A76  [$A2:8A76]
$A2:8A53 20 A7 8A    JSR $8AA7  [$A2:8AA7]
$A2:8A56 90 03       BCC $03    [$8A5B]
$A2:8A58 20 0A 8A    JSR $8A0A  [$A2:8A0A]

$A2:8A5B 60          RTS
}


;;; $8A5C:  ;;;
{
$A2:8A5C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8A5F BD AA 0F    LDA $0FAA,x
$A2:8A62 85 14       STA $14    [$7E:0014]
$A2:8A64 BD A8 0F    LDA $0FA8,x
$A2:8A67 85 12       STA $12    [$7E:0012]
$A2:8A69 20 76 8A    JSR $8A76  [$A2:8A76]
$A2:8A6C 20 A7 8A    JSR $8AA7  [$A2:8AA7]
$A2:8A6F 90 03       BCC $03    [$8A74]
$A2:8A71 20 30 8A    JSR $8A30  [$A2:8A30]

$A2:8A74 60          RTS
}


;;; $8A75: RTS ;;;
{
$A2:8A75 60          RTS
}


;;; $8A76:  ;;;
{
$A2:8A76 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8A79 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [$14].[$12]
$A2:8A7D 90 05       BCC $05    [$8A84]     ; If collided with wall:
$A2:8A7F 20 95 8A    JSR $8A95  [$A2:8A95]
$A2:8A82 80 10       BRA $10    [$8A94]

$A2:8A84 A9 02 00    LDA #$0002
$A2:8A87 85 14       STA $14    [$7E:0014]
$A2:8A89 64 12       STZ $12    [$7E:0012]
$A2:8A8B 22 76 BC A0 JSL $A0BC76[$A0:BC76]
$A2:8A8F B0 03       BCS $03    [$8A94]
$A2:8A91 20 95 8A    JSR $8A95  [$A2:8A95]

$A2:8A94 60          RTS
}


;;; $8A95:  ;;;
{
$A2:8A95 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8A98 20 F7 89    JSR $89F7  [$A2:89F7]
$A2:8A9B BD B0 0F    LDA $0FB0,x
$A2:8A9E 49 01 00    EOR #$0001
$A2:8AA1 F0 03       BEQ $03    [$8AA6]
$A2:8AA3 20 1D 8A    JSR $8A1D  [$A2:8A1D]

$A2:8AA6 60          RTS
}


;;; $8AA7:  ;;;
{
$A2:8AA7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8AAA 22 11 81 80 JSL $808111[$80:8111]
$A2:8AAE AD E5 05    LDA $05E5  [$7E:05E5]
$A2:8AB1 18          CLC
$A2:8AB2 7D A4 0F    ADC $0FA4,x
$A2:8AB5 29 FF 00    AND #$00FF
$A2:8AB8 C9 02 00    CMP #$0002
$A2:8ABB 10 09       BPL $09    [$8AC6]
$A2:8ABD A9 75 8A    LDA #$8A75
$A2:8AC0 9D B2 0F    STA $0FB2,x
$A2:8AC3 38          SEC
$A2:8AC4 80 01       BRA $01    [$8AC7]

$A2:8AC6 18          CLC

$A2:8AC7 60          RTS
}


;;; $8AC8: RTL ;;;
{
$A2:8AC8 6B          RTL
}


;;; $8AC9: RTL ;;;
{
$A2:8AC9 6B          RTL
}


;;; $8ACA: Spritemaps - mini-Crocomire ;;;
{
$A2:8ACA             dx 0002, C3FE,F8,2101, C3F6,F8,2100
$A2:8AD6             dx 0003, 01FE,F0,210F, C3FE,F8,2104, C3F6,F8,2103
$A2:8AE7             dx 0002, C3F6,F8,2106, C3FE,F8,2101
$A2:8AF3             dx 0002, C3FE,F8,2101, C3F6,F8,2108
$A2:8AFF             dx 0004, 01FE,F0,210E, 01F6,F0,210D, C3FE,F8,210B, C3F6,F8,210A
$A2:8B15             dx 0002, C3F2,F8,6101, C3FA,F8,6100
$A2:8B21             dx 0003, 01FA,F0,610F, C3F2,F8,6104, C3FA,F8,6103
$A2:8B32             dx 0002, C3FA,F8,6106, C3F2,F8,6101
$A2:8B3E             dx 0002, C3F2,F8,6101, C3FA,F8,6108
$A2:8B4A             dx 0004, 01FA,F0,610E, 0002,F0,610D, C3F2,F8,610B, C3FA,F8,610A
}
}


;;; $8B60..998C: Maridia beyblade turtle ;;;
{
;;; $8B60: Palette - enemy $CF3F/$CF7F (Maridia beyblade turtle) ;;;
{
$A2:8B60             dw 3800, 4B9C, 3694, 08E7, 0884, 42F7, 2A52, 19AD, 1129, 7FFF, 033B, 0216, 0113, 7FFF, 03FF, 000D
}


;;; $8B80..8D4F: Instruction lists - Maridia beyblade turtle ;;;
{
;;; $8B80: Instruction list -  ;;;
{
$A2:8B80             dx 9381,       ; ???
                        000A,94D9,
                        000A,94E0,
                        9381,       ; ???
                        000A,94E7,
                        000A,94EE,
                        9381,       ; ???
                        000A,94D9,
                        000A,94E0,
                        9381,       ; ???
                        000A,94E7,
                        000A,94EE,
                        9381,       ; ???
                        000A,94D9,
                        000A,94E0,
                        9381,       ; ???
                        000A,9501,
                        000A,950D,
                        9381,       ; ???
                        000A,94D9,
                        000A,94F5,
                        9381,       ; ???
                        000A,9501,
                        000A,950D,
                        9412        ; ???
$A2:8BD2             dx 0001,9519,
                        94D1,       ; ???
                        0004,9519,
                        0005,9520,
                        0005,9527,
                        0005,952E,
                        94C7,       ; ???
                        80ED,8BD2   ; Go to $8BD2
}


;;; $8BEE: Instruction list -  ;;;
{
$A2:8BEE             dx 0010,95E5,
                        0010,961E,
                        0010,9657,
                        0010,9690,
                        80ED,8BEE   ; Go to $8BEE
}


;;; $8C02: Instruction list -  ;;;
{
$A2:8C02             dx 0001,9535,
                        94D1,       ; ???
                        0004,9535,
                        0005,96E9,
                        0005,96C9,
                        0005,96E9,
                        80ED,8C02   ; Go to $8C02
}


;;; $8C1C: Instruction list -  ;;;
{
$A2:8C1C             dx 0020,95E5,
                        0005,959D,
                        0005,9555,
                        9451,       ; ???
                        7FFF,9535,
                        812F        ; Sleep
}


;;; $8C30: Instruction list -  ;;;
{
$A2:8C30             dx 0005,94F5,
                        0005,9501,
                        0040,9519,
                        9485,       ; ???
                        7FFF,9519,
                        812F        ; Sleep
}


;;; $8C44: Instruction list -  ;;;
{
$A2:8C44             dx 7FFF,9535,
                        812F        ; Sleep
}


;;; $8C4A: Instruction list -  ;;;
{
$A2:8C4A             dx 0010,9535,
                        0005,9555,
                        0005,959D,
                        0060,95E5,
                        9447,       ; ???
                        7FFF,95E5,
                        812F        ; Sleep
}


;;; $8C62: Instruction list -  ;;;
{
$A2:8C62             dx 0005,9501,
                        002F,94F5,
                        94A1,       ; ???
                        002F,94F5,
                        812F        ; Sleep
}


;;; $8C72: Instruction list -  ;;;
{
$A2:8C72             dx 9381,       ; ???
                        000A,9733,
                        000A,973A,
                        9381,       ; ???
                        000A,9741,
                        000A,9748,
                        9381,       ; ???
                        000A,9733,
                        000A,973A,
                        9381,       ; ???
                        000A,9741,
                        000A,9748,
                        9381,       ; ???
                        000A,9733,
                        000A,973A,
                        9381,       ; ???
                        000A,975B,
                        000A,9767,
                        9381,       ; ???
                        000A,9733,
                        000A,974F,
                        9381,       ; ???
                        000A,975B,
                        000A,9767,
                        9412,       ; ???
                        0005,9773,
                        0005,977A,
                        0005,9781,
                        0005,9788,
                        80ED,8CC4   ; Go to $8CC4
}


;;; $8CD8: Instruction list -  ;;;
{
$A2:8CD8             dx 0010,983F,
                        0010,9878,
                        0010,98B1,
                        0010,98EA,
                        80ED,8CD8   ; Go to $8CD8
}


;;; $8CEC: Instruction list -  ;;;
{
$A2:8CEC             dx 0005,978F,
                        0005,9943,
                        0005,9923,
                        0005,9943,
                        80ED,8CEC   ; Go to $8CEC
}


;;; $8D00: Instruction list -  ;;;
{
$A2:8D00             dx 0001,983F,
                        0005,97F7,
                        0005,97AF,
                        946B,       ; ???
                        7FFF,978F,
                        812F        ; Sleep
}


;;; $8D14: Instruction list -  ;;;
{
$A2:8D14             dx 0005,974F,
                        0005,975B,
                        0040,9773,
                        9485,       ; ???
                        7FFF,9773,
                        812F        ; Sleep
}


;;; $8D28: Instruction list -  ;;;
{
$A2:8D28             dx 0010,978F,
                        0005,97AF,
                        0005,97F7,
                        0060,983F,
                        9447,       ; ???
                        7FFF,983F,
                        812F        ; Sleep
}


;;; $8D40: Instruction list -  ;;;
{
$A2:8D40             dx 0005,9501,
                        002F,94F5,
                        94A1,       ; ???
                        002F,94F5,
                        812F        ; Sleep
}
}


;;; $8D50: Maridia beyblade turtle constants ;;;
{
$A2:8D50             dw 0030
$A2:8D52             dw 0001
$A2:8D54             dw 0020

$A2:8D56             dw F000,FFFF, 1000,0000

$A2:8D5E             dw 0003
$A2:8D60             dw 01E8
$A2:8D62             dw 0007
$A2:8D64             dw 001E
$A2:8D66             dw 0004
$A2:8D68             dw FFFD ; Unused
$A2:8D6A             dw 0003 ; Unused
}


;;; $8D6C: Initialisation AI - enemy $CF3F (Maridia beyblade turtle) ;;;
{
$A2:8D6C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8D6F BD 86 0F    LDA $0F86,x[$7E:0F86]
$A2:8D72 09 00 20    ORA #$2000
$A2:8D75 9D 86 0F    STA $0F86,x[$7E:0F86]
$A2:8D78 A9 4D 80    LDA #$804D
$A2:8D7B 9D 8E 0F    STA $0F8E,x[$7E:0F8E]
$A2:8D7E A9 01 00    LDA #$0001
$A2:8D81 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:8D84 9E 90 0F    STZ $0F90,x[$7E:0F90]
$A2:8D87 9E 84 0F    STZ $0F84,x[$7E:0F84]
$A2:8D8A A9 44 8C    LDA #$8C44
$A2:8D8D 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:8D90 A9 D8 8D    LDA #$8DD8
$A2:8D93 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:8D96 AD 52 8D    LDA $8D52  [$A2:8D52]
$A2:8D99 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:8D9C 6B          RTL
}


;;; $8D9D: Initialisation AI - enemy $CF7F (mini Maridia beyblade turtle) ;;;
{
$A2:8D9D AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8DA0 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]
$A2:8DA3 9D AC 0F    STA $0FAC,x[$7E:0FEC]
$A2:8DA6 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]
$A2:8DA9 38          SEC
$A2:8DAA FD 84 0F    SBC $0F84,x[$7E:0FC4]
$A2:8DAD 9D AE 0F    STA $0FAE,x[$7E:0FEE]
$A2:8DB0 A9 42 91    LDA #$9142
$A2:8DB3 9D A8 0F    STA $0FA8,x[$7E:0FE8]
$A2:8DB6 A9 01 00    LDA #$0001
$A2:8DB9 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A2:8DBC 9E 90 0F    STZ $0F90,x[$7E:0FD0]
$A2:8DBF A0 80 8B    LDY #$8B80
$A2:8DC2 BD B4 0F    LDA $0FB4,x[$7E:0FF4]
$A2:8DC5 9D B0 0F    STA $0FB0,x[$7E:0FF0]
$A2:8DC8 30 03       BMI $03    [$8DCD]
$A2:8DCA A0 72 8C    LDY #$8C72

$A2:8DCD 98          TYA
$A2:8DCE 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A2:8DD1 6B          RTL
}


;;; $8DD2: Main AI - enemy $CF3F (Maridia beyblade turtle) ;;;
{
$A2:8DD2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8DD5 7C A8 0F    JMP ($0FA8,x)[$A2:8DD8]
}


;;; $8DD8:  ;;;
{
$A2:8DD8 BD 96 0F    LDA $0F96,x[$7E:0F96]
$A2:8DDB 9D D6 0F    STA $0FD6,x[$7E:0FD6]
$A2:8DDE 9D 16 10    STA $1016,x[$7E:1016]
$A2:8DE1 9D 56 10    STA $1056,x[$7E:1056]
$A2:8DE4 9D 96 10    STA $1096,x[$7E:1096]
$A2:8DE7 BD 98 0F    LDA $0F98,x[$7E:0F98]
$A2:8DEA 9D D8 0F    STA $0FD8,x[$7E:0FD8]
$A2:8DED 9D 18 10    STA $1018,x[$7E:1018]
$A2:8DF0 9D 58 10    STA $1058,x[$7E:1058]
$A2:8DF3 9D 98 10    STA $1098,x[$7E:1098]
$A2:8DF6 8A          TXA
$A2:8DF7 9D EA 0F    STA $0FEA,x[$7E:0FEA]
$A2:8DFA 9D 2A 10    STA $102A,x[$7E:102A]
$A2:8DFD 9D 6A 10    STA $106A,x[$7E:106A]
$A2:8E00 9D AA 10    STA $10AA,x[$7E:10AA]
$A2:8E03 A9 0A 8E    LDA #$8E0A
$A2:8E06 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:8E09 6B          RTL
}


;;; $8E0A:  ;;;
{
$A2:8E0A BD B2 0F    LDA $0FB2,x[$7E:0FB2]
$A2:8E0D D0 10       BNE $10    [$8E1F]
$A2:8E0F A9 E0 8E    LDA #$8EE0
$A2:8E12 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:8E15 BD 86 0F    LDA $0F86,x[$7E:0F86]
$A2:8E18 29 FF FB    AND #$FBFF
$A2:8E1B 9D 86 0F    STA $0F86,x[$7E:0F86]
$A2:8E1E 6B          RTL

$A2:8E1F 9E 84 0F    STZ $0F84,x[$7E:0F84]
$A2:8E22 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:8E25 38          SEC
$A2:8E26 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A2:8E29 08          PHP
$A2:8E2A 10 04       BPL $04    [$8E30]
$A2:8E2C 49 FF FF    EOR #$FFFF
$A2:8E2F 1A          INC A

$A2:8E30 C9 18 00    CMP #$0018
$A2:8E33 10 49       BPL $49    [$8E7E]
$A2:8E35 28          PLP
$A2:8E36 10 04       BPL $04    [$8E3C]
$A2:8E38 18          CLC
$A2:8E39 69 18 00    ADC #$0018

$A2:8E3C 0A          ASL A
$A2:8E3D AA          TAX
$A2:8E3E BD 80 8E    LDA $8E80,x[$A2:8EAC]
$A2:8E41 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:8E44 49 FF FF    EOR #$FFFF
$A2:8E47 1A          INC A
$A2:8E48 9D 84 0F    STA $0F84,x[$7E:0F84]
$A2:8E4B BD 86 0F    LDA $0F86,x[$7E:0F86]
$A2:8E4E 09 00 80    ORA #$8000
$A2:8E51 9D 86 0F    STA $0F86,x[$7E:0F86]
$A2:8E54 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:8E58 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A2:8E5B F0 20       BEQ $20    [$8E7D]     ;/
$A2:8E5D BD 7E 0F    LDA $0F7E,x
$A2:8E60 38          SEC
$A2:8E61 FD 84 0F    SBC $0F84,x
$A2:8E64 85 12       STA $12    [$7E:0012]
$A2:8E66 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A2:8E69 18          CLC
$A2:8E6A 6D 00 0B    ADC $0B00  [$7E:0B00]
$A2:8E6D 38          SEC
$A2:8E6E E5 12       SBC $12    [$7E:0012]
$A2:8E70 30 0B       BMI $0B    [$8E7D]
$A2:8E72 49 FF FF    EOR #$FFFF             ;\
$A2:8E75 1A          INC A                  ;|
$A2:8E76 18          CLC                    ;} Extra Samus Y displacement -= [A]
$A2:8E77 6D 5C 0B    ADC $0B5C  [$7E:0B5C]  ;|
$A2:8E7A 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/

$A2:8E7D 6B          RTL

$A2:8E7E 28          PLP
$A2:8E7F 6B          RTL
}


;;; $8E80:  ;;;
{
$A2:8E80             dw FFF0, FFF0, FFF0, FFF0, FFF1, FFF1, FFF1, FFF1, FFF1, FFF2, FFF3, FFF3, FFF4, FFF5, FFF6, FFF7,
                        FFF8, FFF9, FFFA, FFFB, FFFC, FFFC, 0000, 0000, FFF0, FFF0, FFF0, FFF1, FFF1, FFF1, FFF2, FFF3,
                        FFF4, FFF5, FFF6, FFF7, FFF8, FFF9, FFFA, FFFB, FFFC, FFFD, FFFD, FFFE, 0000, 0000, 0000, 0000
}


;;; $8EE0:  ;;;
{
$A2:8EE0 20 15 93    JSR $9315  [$A2:9315]
$A2:8EE3 AD B5 05    LDA $05B5  [$7E:05B5]
$A2:8EE6 29 01 00    AND #$0001
$A2:8EE9 D0 53       BNE $53    [$8F3E]
$A2:8EEB DA          PHX                    ;\
$A2:8EEC 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;|
$A2:8EF0 FA          PLX                    ;} If enemy is touching Samus from below:
$A2:8EF1 29 FF FF    AND #$FFFF             ;|
$A2:8EF4 F0 0A       BEQ $0A    [$8F00]     ;/
$A2:8EF6 AD 58 0B    LDA $0B58  [$7E:0B58]  ;\
$A2:8EF9 38          SEC                    ;|
$A2:8EFA E9 01 00    SBC #$0001             ;} Extra Samus X displacement -= 1
$A2:8EFD 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A2:8F00 DE 7E 0F    DEC $0F7E,x[$7E:0F7E]
$A2:8F03 64 12       STZ $12    [$7E:0012]
$A2:8F05 A9 10 00    LDA #$0010
$A2:8F08 9D 84 0F    STA $0F84,x[$7E:0F84]
$A2:8F0B BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A2:8F0E 89 01 00    BIT #$0001
$A2:8F11 D0 05       BNE $05    [$8F18]
$A2:8F13 FE 7A 0F    INC $0F7A,x[$7E:0F7A]
$A2:8F16 80 03       BRA $03    [$8F1B]

$A2:8F18 DE 7A 0F    DEC $0F7A,x[$7E:0F7A]

$A2:8F1B A9 01 00    LDA #$0001             ;\
$A2:8F1E 85 14       STA $14    [$7E:0014]  ;} Move enemy right by 1.0
$A2:8F20 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:8F24 B0 18       BCS $18    [$8F3E]     ; If collided with wall: return
$A2:8F26 A9 4A 8C    LDA #$8C4A
$A2:8F29 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:8F2C A9 01 00    LDA #$0001
$A2:8F2F 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:8F32 AD 54 8D    LDA $8D54  [$A2:8D54]
$A2:8F35 9D 06 00    STA $0006,x[$7E:0006]
$A2:8F38 A9 09 8E    LDA #$8E09
$A2:8F3B 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:8F3E 6B          RTL
}


;;; $8F3F:  ;;;
{
$A2:8F3F A0 1C 8C    LDY #$8C1C
$A2:8F42 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:8F45 38          SEC
$A2:8F46 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A2:8F49 10 03       BPL $03    [$8F4E]
$A2:8F4B A0 00 8D    LDY #$8D00

$A2:8F4E 98          TYA
$A2:8F4F 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:8F52 A9 01 00    LDA #$0001
$A2:8F55 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:8F58 A9 09 8E    LDA #$8E09
$A2:8F5B 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:8F5E 6B          RTL
}


;;; $8F5F:  ;;;
{
$A2:8F5F DA          PHX                    ;\
$A2:8F60 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;|
$A2:8F64 FA          PLX                    ;} If enemy is not touching Samus from below: return
$A2:8F65 29 FF FF    AND #$FFFF             ;|
$A2:8F68 F0 22       BEQ $22    [$8F8C]     ;/
$A2:8F6A A9 83 90    LDA #$9083
$A2:8F6D 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:8F70 AD 56 0B    LDA $0B56  [$7E:0B56]  ;\
$A2:8F73 38          SEC                    ;|
$A2:8F74 FF 06 78 7E SBC $7E7806,x[$7E:7806];} Extra Samus X subdisplacement -= [enemy $7E:7806]
$A2:8F78 8D 56 0B    STA $0B56  [$7E:0B56]  ;/
$A2:8F7B AD 58 0B    LDA $0B58  [$7E:0B58]  ;\
$A2:8F7E FD B0 0F    SBC $0FB0,x[$7E:0FB0]  ;|
$A2:8F81 C9 F0 FF    CMP #$FFF0             ;|
$A2:8F84 10 03       BPL $03    [$8F89]     ;} Extra Samus X displacement = max(-10h, [extra Samus X displacement] - [enemy $0FB0])
$A2:8F86 A9 F0 FF    LDA #$FFF0             ;|
                                            ;|
$A2:8F89 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A2:8F8C 60          RTS
}


;;; $8F8D:  ;;;
{
$A2:8F8D 20 15 93    JSR $9315  [$A2:9315]
$A2:8F90 A9 FF FF    LDA #$FFFF             ;\
$A2:8F93 85 14       STA $14    [$7E:0014]  ;|
$A2:8F95 64 12       STZ $12    [$7E:0012]  ;} Move enemy up by 1.0
$A2:8F97 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:8F9B B0 4D       BCS $4D    [$8FEA]     ; If collided with block: return
$A2:8F9D DA          PHX                    ;\
$A2:8F9E 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;|
$A2:8FA2 FA          PLX                    ;} If enemy is touching Samus from below:
$A2:8FA3 29 FF FF    AND #$FFFF             ;|
$A2:8FA6 F0 0A       BEQ $0A    [$8FB2]     ;/
$A2:8FA8 AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;\
$A2:8FAB 38          SEC                    ;|
$A2:8FAC E9 01 00    SBC #$0001             ;} Extra Samus Y displacement -= 1
$A2:8FAF 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/

$A2:8FB2 BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A2:8FB6 3A          DEC A
$A2:8FB7 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:8FBB D0 2D       BNE $2D    [$8FEA]
$A2:8FBD A0 00 00    LDY #$0000
$A2:8FC0 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:8FC3 38          SEC
$A2:8FC4 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A2:8FC7 10 03       BPL $03    [$8FCC]
$A2:8FC9 A0 04 00    LDY #$0004

$A2:8FCC B9 56 8D    LDA $8D56,y[$A2:8D5A]
$A2:8FCF 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:8FD3 B9 58 8D    LDA $8D58,y[$A2:8D5C]
$A2:8FD6 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:8FDA A9 00 00    LDA #$0000
$A2:8FDD 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:8FE0 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A2:8FE4 A9 EB 8F    LDA #$8FEB
$A2:8FE7 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:8FEA 6B          RTL
}


;;; $8FEB:  ;;;
{
; Looks like buggy fixed point negations at $903C..6E

$A2:8FEB 20 15 93    JSR $9315  [$A2:9315]
$A2:8FEE BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A2:8FF1 85 14       STA $14    [$7E:0014]  ;|
$A2:8FF3 BF 06 78 7E LDA $7E7806,x[$7E:7806];} Move enemy right by [enemy X velocity].[enemy X subvelocity]
$A2:8FF7 85 12       STA $12    [$7E:0012]  ;|
$A2:8FF9 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:8FFD B0 3D       BCS $3D    [$903C]     ; If collided with wall: go to BRANCH_HIT_WALL
$A2:8FFF 20 5F 8F    JSR $8F5F  [$A2:8F5F]
$A2:9002 BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A2:9006 18          CLC
$A2:9007 7F 02 78 7E ADC $7E7802,x[$7E:7802]
$A2:900B 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A2:900F BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A2:9012 7F 04 78 7E ADC $7E7804,x[$7E:7804]
$A2:9016 48          PHA
$A2:9017 10 04       BPL $04    [$901D]
$A2:9019 49 FF FF    EOR #$FFFF
$A2:901C 1A          INC A

$A2:901D CD 5E 8D    CMP $8D5E  [$A2:8D5E]
$A2:9020 30 15       BMI $15    [$9037]
$A2:9022 68          PLA
$A2:9023 AC 5E 8D    LDY $8D5E  [$A2:8D5E]
$A2:9026 BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A2:9029 89 00 80    BIT #$8000
$A2:902C F0 08       BEQ $08    [$9036]
$A2:902E AD 5E 8D    LDA $8D5E  [$A2:8D5E]
$A2:9031 49 FF FF    EOR #$FFFF
$A2:9034 1A          INC A
$A2:9035 A8          TAY

$A2:9036 5A          PHY

$A2:9037 68          PLA
$A2:9038 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:903B 6B          RTL

; BRANCH_HIT_WALL
$A2:903C BF 06 78 7E LDA $7E7806,x[$7E:7806];\
$A2:9040 49 FF FF    EOR #$FFFF             ;|
$A2:9043 1A          INC A                  ;} Negate [enemy $7E:7806]
$A2:9044 9F 06 78 7E STA $7E7806,x[$7E:7806];/
$A2:9048 BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A2:904B 69 00 00    ADC #$0000             ;|
$A2:904E 49 FF FF    EOR #$FFFF             ;} Enemy $0FB0 = 1 - [enemy $0FB0]
$A2:9051 1A          INC A                  ;|
$A2:9052 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;/
$A2:9055 BF 02 78 7E LDA $7E7802,x[$7E:7802];\
$A2:9059 49 FF FF    EOR #$FFFF             ;|
$A2:905C 1A          INC A                  ;} Negate [enemy $7E:7802]
$A2:905D 9F 02 78 7E STA $7E7802,x[$7E:7802];/
$A2:9061 BF 04 78 7E LDA $7E7804,x[$7E:7804];\
$A2:9065 69 00 00    ADC #$0000             ;|
$A2:9068 49 FF FF    EOR #$FFFF             ;} Enemy $7E:7804 = carry - [enemy $7E:7804]
$A2:906B 9F 04 78 7E STA $7E7804,x[$7E:7804];/
$A2:906F A9 00 00    LDA #$0000             ;\
$A2:9072 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 1 pixel displacement, horizontal
$A2:9075 A9 10 00    LDA #$0010             ;\
$A2:9078 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 10h
$A2:907B A9 1B 00    LDA #$001B             ;\
$A2:907E 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 1Bh, sound library 2, max queued sounds allowed = 6 (Maridia beyblade turtle hits wall)
$A2:9082 6B          RTL
}


;;; $9083:  ;;;
{
$A2:9083 20 15 93    JSR $9315  [$A2:9315]
$A2:9086 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A2:9089 CD 60 8D    CMP $8D60  [$A2:8D60]
$A2:908C 30 20       BMI $20    [$90AE]
$A2:908E DA          PHX                    ;\
$A2:908F 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;|
$A2:9093 FA          PLX                    ;} If enemy is not touching Samus from below: go to BRANCH_NOT_TOUCHING_SAMUS
$A2:9094 29 FF FF    AND #$FFFF             ;|
$A2:9097 F0 2E       BEQ $2E    [$90C7]     ;/
$A2:9099 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A2:909C 38          SEC
$A2:909D ED 62 8D    SBC $8D62  [$A2:8D62]
$A2:90A0 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A2:90A3 AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;\
$A2:90A6 38          SEC                    ;|
$A2:90A7 ED 62 8D    SBC $8D62  [$A2:8D62]  ;} Extra Samus Y displacement -= 7
$A2:90AA 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/
$A2:90AD 6B          RTL

$A2:90AE AD 64 8D    LDA $8D64  [$A2:8D64]
$A2:90B1 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:90B5 A9 CC 90    LDA #$90CC

$A2:90B8 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:90BB A9 00 00    LDA #$0000
$A2:90BE 9F 0E 78 7E STA $7E780E,x[$7E:780E]
$A2:90C2 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A2:90C6 6B          RTL

; BRANCH_NOT_TOUCHING_SAMUS
$A2:90C7 A9 E1 90    LDA #$90E1
$A2:90CA 80 EC       BRA $EC    [$90B8]
}


;;; $90CC:  ;;;
{
$A2:90CC 20 15 93    JSR $9315  [$A2:9315]
$A2:90CF BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A2:90D3 3A          DEC A
$A2:90D4 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:90D8 D0 06       BNE $06    [$90E0]
$A2:90DA A9 E1 90    LDA #$90E1
$A2:90DD 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:90E0 6B          RTL
}


;;; $90E1:  ;;;
{
$A2:90E1 20 15 93    JSR $9315  [$A2:9315]
$A2:90E4 AF 08 78 7E LDA $7E7808[$7E:7808]
$A2:90E8 CD 66 8D    CMP $8D66  [$A2:8D66]
$A2:90EB 10 17       BPL $17    [$9104]
$A2:90ED BF 0E 78 7E LDA $7E780E,x[$7E:780E]
$A2:90F1 18          CLC
$A2:90F2 69 00 20    ADC #$2000
$A2:90F5 9F 0E 78 7E STA $7E780E,x[$7E:780E]
$A2:90F9 BF 08 78 7E LDA $7E7808,x[$7E:7808]
$A2:90FD 69 00 00    ADC #$0000
$A2:9100 9F 08 78 7E STA $7E7808,x[$7E:7808]

$A2:9104 64 12       STZ $12    [$7E:0012]  ;\
$A2:9106 BF 08 78 7E LDA $7E7808,x[$7E:7808];|
$A2:910A 85 14       STA $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity]
$A2:910C 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:9110 90 1B       BCC $1B    [$912D]     ; If not collided with block: return
$A2:9112 A0 4A 8C    LDY #$8C4A
$A2:9115 BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A2:9118 30 03       BMI $03    [$911D]
$A2:911A A0 28 8D    LDY #$8D28

$A2:911D 98          TYA
$A2:911E 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:9121 A9 01 00    LDA #$0001
$A2:9124 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:9127 A9 09 8E    LDA #$8E09
$A2:912A 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:912D 6B          RTL
}


;;; $912E: Main AI - enemy $CF7F (mini Maridia beyblade turtle) ;;;
{
$A2:912E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9131 BD AA 0F    LDA $0FAA,x[$7E:0FEA]
$A2:9134 AA          TAX
$A2:9135 A9 00 00    LDA #$0000
$A2:9138 9F 0C 78 7E STA $7E780C,x[$7E:780C]
$A2:913C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:913F 7C A8 0F    JMP ($0FA8,x)[$A2:9142]
}


;;; $9142:  ;;;
{
$A2:9142 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:9146 29 FF FF    AND #$FFFF             ;} If enemy is not touching Samus from below: return
$A2:9149 F0 22       BEQ $22    [$916D]     ;/
$A2:914B A9 6E 91    LDA #$916E
$A2:914E 9D A8 0F    STA $0FA8,x[$7E:10A8]
$A2:9151 A9 04 00    LDA #$0004
$A2:9154 9F 0A 78 7E STA $7E780A,x[$7E:790A]
$A2:9158 A0 30 8C    LDY #$8C30
$A2:915B BD B0 0F    LDA $0FB0,x[$7E:10B0]
$A2:915E 30 03       BMI $03    [$9163]
$A2:9160 A0 14 8D    LDY #$8D14

$A2:9163 98          TYA
$A2:9164 9D 92 0F    STA $0F92,x[$7E:1092]
$A2:9167 A9 01 00    LDA #$0001
$A2:916A 9D 94 0F    STA $0F94,x[$7E:1094]

$A2:916D 6B          RTL
}


;;; $916E:  ;;;
{
$A2:916E 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:9172 29 FF FF    AND #$FFFF             ;} If enemy is not touching Samus from below: go to BRANCH_NOT_TOUCHING_SAMUS
$A2:9175 F0 08       BEQ $08    [$917F]     ;/
$A2:9177 A9 04 00    LDA #$0004
$A2:917A 9F 0A 78 7E STA $7E780A,x[$7E:790A]

$A2:917E 6B          RTL

; BRANCH_NOT_TOUCHING_SAMUS
$A2:917F BF 0A 78 7E LDA $7E780A,x[$7E:790A]
$A2:9183 3A          DEC A
$A2:9184 9F 0A 78 7E STA $7E780A,x[$7E:790A]
$A2:9188 D0 F4       BNE $F4    [$917E]
$A2:918A A9 98 91    LDA #$9198
$A2:918D 9D A8 0F    STA $0FA8,x[$7E:10A8]
$A2:9190 A9 3C 00    LDA #$003C
$A2:9193 9F 00 78 7E STA $7E7800,x[$7E:7900]
$A2:9197 6B          RTL
}


;;; $9198:  ;;;
{
$A2:9198 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:919C 29 FF FF    AND #$FFFF             ;} If enemy is not touching Samus from below: go to BRANCH_NOT_TOUCHING_SAMUS
$A2:919F F0 2F       BEQ $2F    [$91D0]     ;/
$A2:91A1 A9 F8 91    LDA #$91F8
$A2:91A4 9D A8 0F    STA $0FA8,x
$A2:91A7 A9 D2 8B    LDA #$8BD2
$A2:91AA 9D 92 0F    STA $0F92,x
$A2:91AD A9 01 00    LDA #$0001
$A2:91B0 9D 94 0F    STA $0F94,x
$A2:91B3 A9 01 00    LDA #$0001
$A2:91B6 9F 08 78 7E STA $7E7808,x
$A2:91BA AD 1E 0A    LDA $0A1E  [$7E:0A1E]
$A2:91BD 29 0F 00    AND #$000F
$A2:91C0 AC 68 8D    LDY $8D68  [$A2:8D68]
$A2:91C3 C9 08 00    CMP #$0008
$A2:91C6 D0 03       BNE $03    [$91CB]
$A2:91C8 AC 6A 8D    LDY $8D6A  [$A2:8D6A]

$A2:91CB 98          TYA
$A2:91CC 9D B0 0F    STA $0FB0,x
$A2:91CF 6B          RTL

; BRANCH_NOT_TOUCHING_SAMUS
$A2:91D0 BF 00 78 7E LDA $7E7800,x[$7E:7900]
$A2:91D4 3A          DEC A
$A2:91D5 9F 00 78 7E STA $7E7800,x[$7E:7900]
$A2:91D9 F0 01       BEQ $01    [$91DC]
$A2:91DB 6B          RTL

$A2:91DC A0 80 8B    LDY #$8B80
$A2:91DF BD B0 0F    LDA $0FB0,x[$7E:10B0]
$A2:91E2 30 03       BMI $03    [$91E7]
$A2:91E4 A0 72 8C    LDY #$8C72

$A2:91E7 98          TYA
$A2:91E8 9D 92 0F    STA $0F92,x[$7E:1092]
$A2:91EB A9 01 00    LDA #$0001
$A2:91EE 9D 94 0F    STA $0F94,x[$7E:1094]
$A2:91F1 A9 42 91    LDA #$9142
$A2:91F4 9D A8 0F    STA $0FA8,x[$7E:10A8]
$A2:91F7 6B          RTL
}


;;; $91F8:  ;;;
{
$A2:91F8 64 12       STZ $12    [$7E:0012]  ;\
$A2:91FA BD B0 0F    LDA $0FB0,x            ;|
$A2:91FD 85 14       STA $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity]
$A2:91FF 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:9203 B0 0D       BCS $0D    [$9212]     ; If not collided with wall:
$A2:9205 64 12       STZ $12    [$7E:0012]  ;\
$A2:9207 BF 08 78 7E LDA $7E7808,x          ;|
$A2:920B 85 14       STA $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity]
$A2:920D 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:9211 6B          RTL

$A2:9212 BD B0 0F    LDA $0FB0,x
$A2:9215 49 FF FF    EOR #$FFFF
$A2:9218 1A          INC A
$A2:9219 9D B0 0F    STA $0FB0,x
$A2:921C 6B          RTL
}


;;; $921D:  ;;;
{
$A2:921D A0 80 8B    LDY #$8B80
$A2:9220 BD B0 0F    LDA $0FB0,x
$A2:9223 30 03       BMI $03    [$9228]
$A2:9225 A0 72 8C    LDY #$8C72

$A2:9228 98          TYA
$A2:9229 9D 92 0F    STA $0F92,x
$A2:922C A9 01 00    LDA #$0001
$A2:922F 9D 94 0F    STA $0F94,x
$A2:9232 A9 42 91    LDA #$9142
$A2:9235 9D A8 0F    STA $0FA8,x
$A2:9238 6B          RTL
}


;;; $9239:  ;;;
{
$A2:9239 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:923D 29 FF FF    AND #$FFFF             ;} If enemy is not touching Samus from below: go to $91F8
$A2:9240 F0 B6       BEQ $B6    [$91F8]     ;/
$A2:9242 A0 80 8B    LDY #$8B80
$A2:9245 BD B0 0F    LDA $0FB0,x
$A2:9248 30 03       BMI $03    [$924D]
$A2:924A A0 72 8C    LDY #$8C72

$A2:924D 98          TYA
$A2:924E 9D 92 0F    STA $0F92,x
$A2:9251 A9 01 00    LDA #$0001
$A2:9254 9D 94 0F    STA $0F94,x
$A2:9257 A9 42 91    LDA #$9142
$A2:925A 9D A8 0F    STA $0FA8,x
$A2:925D 6B          RTL
}


;;; $925E:  ;;;
{
$A2:925E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9261 BD 84 0F    LDA $0F84,x
$A2:9264 48          PHA
$A2:9265 BD AA 0F    LDA $0FAA,x
$A2:9268 AA          TAX
$A2:9269 68          PLA
$A2:926A 9F 0C 78 7E STA $7E780C,x
$A2:926E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9271 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:9275 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below: return
$A2:9278 D0 06       BNE $06    [$9280]     ;/
$A2:927A A9 42 91    LDA #$9142
$A2:927D 9D A8 0F    STA $0FA8,x

$A2:9280 6B          RTL
}


;;; $9281: Enemy touch - enemy $CF3F (Maridia beyblade turtle) ;;;
{
$A2:9281 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9284 BD 86 0F    LDA $0F86,x
$A2:9287 89 00 80    BIT #$8000
$A2:928A D0 11       BNE $11    [$929D]
$A2:928C 22 23 80 A2 JSL $A28023[$A2:8023]
$A2:9290 A9 E1 90    LDA #$90E1
$A2:9293 9D A8 0F    STA $0FA8,x
$A2:9296 A9 02 00    LDA #$0002
$A2:9299 9F 08 78 7E STA $7E7808,x

$A2:929D 6B          RTL
}


;;; $929E: RTL ;;;
{
$A2:929E 6B          RTL
}


;;; $929F: Enemy touch - enemy $CF7F (mini Maridia beyblade turtle) ;;;
{
$A2:929F AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:92A2 BD A8 0F    LDA $0FA8,x
$A2:92A5 C9 5E 92    CMP #$925E
$A2:92A8 D0 01       BNE $01    [$92AB]
$A2:92AA 6B          RTL

$A2:92AB BD B0 0F    LDA $0FB0,x
$A2:92AE 30 0B       BMI $0B    [$92BB]
$A2:92B0 A9 80 8B    LDA #$8B80
$A2:92B3 9D 92 0F    STA $0F92,x
$A2:92B6 A9 FF FF    LDA #$FFFF
$A2:92B9 80 09       BRA $09    [$92C4]

$A2:92BB A9 72 8C    LDA #$8C72
$A2:92BE 9D 92 0F    STA $0F92,x
$A2:92C1 A9 01 00    LDA #$0001

$A2:92C4 9D B0 0F    STA $0FB0,x
$A2:92C7 A9 01 00    LDA #$0001
$A2:92CA 9D 94 0F    STA $0F94,x
$A2:92CD BD 7A 0F    LDA $0F7A,x
$A2:92D0 CD F6 0A    CMP $0AF6  [$7E:0AF6]
$A2:92D3 10 0C       BPL $0C    [$92E1]
$A2:92D5 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:92D8 38          SEC
$A2:92D9 ED FE 0A    SBC $0AFE  [$7E:0AFE]
$A2:92DC FD 82 0F    SBC $0F82,x
$A2:92DF 80 0A       BRA $0A    [$92EB]

$A2:92E1 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:92E4 18          CLC
$A2:92E5 6D FE 0A    ADC $0AFE  [$7E:0AFE]
$A2:92E8 7D 82 0F    ADC $0F82,x

$A2:92EB 9D 7A 0F    STA $0F7A,x
$A2:92EE A9 42 91    LDA #$9142
$A2:92F1 9D A8 0F    STA $0FA8,x
$A2:92F4 64 12       STZ $12    [$7E:0012]  ;\
$A2:92F6 BD B0 0F    LDA $0FB0,x            ;|
$A2:92F9 85 14       STA $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity]
$A2:92FB 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
}


;;; $92FF:  ;;;
{
$A2:92FF AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9302 BD AA 0F    LDA $0FAA,x[$7E:10AA]
$A2:9305 AA          TAX
$A2:9306 BD B2 0F    LDA $0FB2,x[$7E:0FB2]
$A2:9309 F0 03       BEQ $03    [$930E]
$A2:930B DE B2 0F    DEC $0FB2,x[$7E:0FB2]

$A2:930E 6B          RTL
}


;;; $930F: Enemy shot - enemy $CF7F (mini Maridia beyblade turtle) ;;;
{
$A2:930F 22 3D A6 A0 JSL $A0A63D[$A0:A63D]
$A2:9313 80 EA       BRA $EA    [$92FF]
}


;;; $9315:  ;;;
{
$A2:9315 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A2:9318 38          SEC
$A2:9319 ED 82 0F    SBC $0F82  [$7E:0F82]
$A2:931C 38          SEC
$A2:931D E9 08 00    SBC #$0008
$A2:9320 85 12       STA $12    [$7E:0012]
$A2:9322 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A2:9325 18          CLC
$A2:9326 6D 82 0F    ADC $0F82  [$7E:0F82]
$A2:9329 18          CLC
$A2:932A 69 08 00    ADC #$0008
$A2:932D 85 14       STA $14    [$7E:0014]
$A2:932F AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A2:9332 38          SEC
$A2:9333 ED 84 0F    SBC $0F84  [$7E:0F84]
$A2:9336 18          CLC
$A2:9337 69 04 00    ADC #$0004
$A2:933A 85 16       STA $16    [$7E:0016]
$A2:933C AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A2:933F 18          CLC
$A2:9340 6D 84 0F    ADC $0F84  [$7E:0F84]
$A2:9343 38          SEC
$A2:9344 E9 04 00    SBC #$0004
$A2:9347 85 18       STA $18    [$7E:0018]
$A2:9349 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:934C 38          SEC
$A2:934D ED FE 0A    SBC $0AFE  [$7E:0AFE]
$A2:9350 3A          DEC A
$A2:9351 C5 14       CMP $14    [$7E:0014]
$A2:9353 10 2B       BPL $2B    [$9380]
$A2:9355 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:9358 18          CLC
$A2:9359 6D FE 0A    ADC $0AFE  [$7E:0AFE]
$A2:935C C5 12       CMP $12    [$7E:0012]
$A2:935E 30 20       BMI $20    [$9380]
$A2:9360 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A2:9363 38          SEC
$A2:9364 ED 00 0B    SBC $0B00  [$7E:0B00]
$A2:9367 1A          INC A
$A2:9368 C5 18       CMP $18    [$7E:0018]
$A2:936A 10 14       BPL $14    [$9380]
$A2:936C AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A2:936F 18          CLC
$A2:9370 6D 00 0B    ADC $0B00  [$7E:0B00]
$A2:9373 C5 16       CMP $16    [$7E:0016]
$A2:9375 30 09       BMI $09    [$9380]
$A2:9377 AD A8 18    LDA $18A8  [$7E:18A8]
$A2:937A D0 04       BNE $04    [$9380]
$A2:937C 22 77 A4 A0 JSL $A0A477[$A0:A477]

$A2:9380 60          RTS
}


;;; $9381:  ;;;
{
$A2:9381 DA          PHX
$A2:9382 5A          PHY
$A2:9383 A9 00 00    LDA #$0000
$A2:9386 85 30       STA $30    [$7E:0030]
$A2:9388 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:938B 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:938F 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A2:9392 F0 0F       BEQ $0F    [$93A3]     ;/
$A2:9394 BD B0 0F    LDA $0FB0,x            ;\
$A2:9397 18          CLC                    ;|
$A2:9398 6D 58 0B    ADC $0B58  [$7E:0B58]  ;} Extra Samus X displacement += [enemy $0FB0]
$A2:939B 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A2:939E A9 01 00    LDA #$0001
$A2:93A1 85 30       STA $30    [$7E:0030]

$A2:93A3 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]
$A2:93A6 85 32       STA $32    [$7E:0032]
$A2:93A8 BD AE 0F    LDA $0FAE,x[$7E:0FEE]
$A2:93AB 9D 7E 0F    STA $0F7E,x[$7E:0FBE]
$A2:93AE 64 12       STZ $12    [$7E:0012]  ;\
$A2:93B0 BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;|
$A2:93B3 85 14       STA $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity]
$A2:93B5 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:93B9 BD AA 0F    LDA $0FAA,x[$7E:0FEA]
$A2:93BC AA          TAX
$A2:93BD BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A2:93C0 C9 0A 8E    CMP #$8E0A
$A2:93C3 D0 44       BNE $44    [$9409]
$A2:93C5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:93C8 DA          PHX
$A2:93C9 BD AA 0F    LDA $0FAA,x[$7E:0FEA]
$A2:93CC AA          TAX
$A2:93CD BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:93D0 FA          PLX
$A2:93D1 38          SEC
$A2:93D2 FD 7A 0F    SBC $0F7A,x[$7E:0FBA]
$A2:93D5 08          PHP
$A2:93D6 10 04       BPL $04    [$93DC]
$A2:93D8 49 FF FF    EOR #$FFFF
$A2:93DB 1A          INC A

$A2:93DC C9 18 00    CMP #$0018
$A2:93DF 10 2B       BPL $2B    [$940C]
$A2:93E1 28          PLP
$A2:93E2 10 04       BPL $04    [$93E8]
$A2:93E4 18          CLC
$A2:93E5 69 18 00    ADC #$0018

$A2:93E8 0A          ASL A
$A2:93E9 AA          TAX
$A2:93EA BD 80 8E    LDA $8E80,x[$A2:8E82]

$A2:93ED 85 14       STA $14    [$7E:0014]
$A2:93EF 64 12       STZ $12    [$7E:0012]  ;\
$A2:93F1 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Move enemy down by [$14]
$A2:93F4 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:93F8 A5 30       LDA $30    [$7E:0030]
$A2:93FA F0 0D       BEQ $0D    [$9409]
$A2:93FC BD 7E 0F    LDA $0F7E,x            ;\
$A2:93FF 38          SEC                    ;|
$A2:9400 E5 32       SBC $32    [$7E:0032]  ;|
$A2:9402 18          CLC                    ;} Extra Samus Y displacement += [enemy Y position] - [$32]
$A2:9403 6D 5C 0B    ADC $0B5C  [$7E:0B5C]  ;|
$A2:9406 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/

$A2:9409 7A          PLY
$A2:940A FA          PLX
$A2:940B 6B          RTL

$A2:940C 28          PLP
$A2:940D A9 01 00    LDA #$0001
$A2:9410 80 DB       BRA $DB    [$93ED]
}


;;; $9412:  ;;;
{
$A2:9412 DA          PHX
$A2:9413 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9416 BD AC 0F    LDA $0FAC,x[$7E:0FEC]
$A2:9419 38          SEC
$A2:941A FD 7A 0F    SBC $0F7A,x[$7E:0FBA]
$A2:941D 08          PHP
$A2:941E 10 04       BPL $04    [$9424]
$A2:9420 49 FF FF    EOR #$FFFF
$A2:9423 1A          INC A

$A2:9424 CD 50 8D    CMP $8D50  [$A2:8D50]
$A2:9427 30 1B       BMI $1B    [$9444]
$A2:9429 28          PLP
$A2:942A 30 05       BMI $05    [$9431]
$A2:942C A9 01 00    LDA #$0001
$A2:942F 80 03       BRA $03    [$9434]

$A2:9431 A9 FF FF    LDA #$FFFF

$A2:9434 9D B0 0F    STA $0FB0,x[$7E:0FF0]

$A2:9437 A0 72 8C    LDY #$8C72
$A2:943A BD B0 0F    LDA $0FB0,x[$7E:0FF0]
$A2:943D 10 03       BPL $03    [$9442]
$A2:943F A0 80 8B    LDY #$8B80

$A2:9442 FA          PLX
$A2:9443 6B          RTL

$A2:9444 28          PLP
$A2:9445 80 F0       BRA $F0    [$9437]
}


;;; $9447:  ;;;
{
$A2:9447 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:944A A9 3F 8F    LDA #$8F3F
$A2:944D 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:9450 6B          RTL
}


;;; $9451:  ;;;
{
$A2:9451 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9454 A9 8D 8F    LDA #$8F8D
$A2:9457 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:945A A9 FF FF    LDA #$FFFF
$A2:945D 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:9460 A9 10 00    LDA #$0010
$A2:9463 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:9467 A0 02 8C    LDY #$8C02
$A2:946A 6B          RTL
}


;;; $946B:  ;;;
{
$A2:946B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:946E A9 8D 8F    LDA #$8F8D
$A2:9471 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:9474 A9 01 00    LDA #$0001
$A2:9477 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:947A A9 10 00    LDA #$0010
$A2:947D 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:9481 A0 02 8C    LDY #$8C02
$A2:9484 6B          RTL
}


;;; $9485:  ;;;
{
$A2:9485 5A          PHY
$A2:9486 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9489 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:948D 29 FF FF    AND #$FFFF             ;} If enemy is not touching Samus from below: return
$A2:9490 F0 0D       BEQ $0D    [$949F]     ;/
$A2:9492 7A          PLY
$A2:9493 A0 62 8C    LDY #$8C62
$A2:9496 BD B0 0F    LDA $0FB0,x
$A2:9499 30 03       BMI $03    [$949E]
$A2:949B A0 40 8D    LDY #$8D40

$A2:949E 6B          RTL

$A2:949F 7A          PLY
$A2:94A0 6B          RTL
}


;;; $94A1:  ;;;
{
$A2:94A1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:94A4 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:94A8 29 FF FF    AND #$FFFF             ;} If enemy is not touching Samus from below: go to BRANCH_NOT_TOUCHING_SAMUS
$A2:94AB F0 12       BEQ $12    [$94BF]     ;/
$A2:94AD A9 5E 92    LDA #$925E
$A2:94B0 9D A8 0F    STA $0FA8,x

$A2:94B3 A0 80 8B    LDY #$8B80
$A2:94B6 BD B0 0F    LDA $0FB0,x
$A2:94B9 30 03       BMI $03    [$94BE]
$A2:94BB A0 72 8C    LDY #$8C72

$A2:94BE 6B          RTL

; BRANCH_NOT_TOUCHING_SAMUS
$A2:94BF A9 42 91    LDA #$9142
$A2:94C2 9D A8 0F    STA $0FA8,x
$A2:94C5 80 EC       BRA $EC    [$94B3]
}


;;; $94C7: Instruction ;;;
{
$A2:94C7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:94CA A9 39 92    LDA #$9239
$A2:94CD 9D A8 0F    STA $0FA8,x
$A2:94D0 6B          RTL
}


;;; $94D1:  ;;;
{
$A2:94D1 A9 3A 00    LDA #$003A             ;\
$A2:94D4 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 3Ah, sound library 2, max queued sounds allowed = 6 (Maridia beyblade turtle spinning)
$A2:94D8 6B          RTL
}


;;; $94D9: Spritemaps - Maridia beyblade turtle ;;;
{
$A2:94D9             dx 0001, C3F8,F8,2104
$A2:94E0             dx 0001, C3F8,F8,2106
$A2:94E7             dx 0001, C3F8,F8,2108
$A2:94EE             dx 0001, C3F8,F8,210A
$A2:94F5             dx 0002, 01F8,FF,214D, C3F8,F8,2106
$A2:9501             dx 0002, 01F8,00,214E, C3F8,F8,2108
$A2:950D             dx 0002, 01F8,FF,214F, C3F8,F8,210A
$A2:9519             dx 0001, C3F8,F8,2102
$A2:9520             dx 0001, C3F8,F8,2100
$A2:9527             dx 0001, C3F8,F8,6102
$A2:952E             dx 0001, C3F8,F8,6100
$A2:9535             dx 0006, C208,00,212A, C3F8,00,2128, C3E8,00,2126, C208,F0,2124, C3F8,F0,2122, C3E8,F0,2120
$A2:9555             dx 000E, 0008,08,214B, 0000,08,214A, 01F8,08,2149, 01F0,08,2148, 01E8,08,2157, 01E8,00,2147, 0010,00,212B, 0008,00,212A, 0000,00,2129, 01F8,00,2128, 01F0,00,2127, C208,F0,2124, C3F8,F0,2122, C3E8,F0,2120
$A2:959D             dx 000E, 0008,08,215B, 0000,08,215A, 01F8,08,2159, 01F0,08,2158, 01E8,08,2156, 01E8,00,2146, 0010,00,212B, 0008,00,212A, 0000,00,2129, 01F8,00,2128, 01F0,00,2127, C208,F0,2124, C3F8,F0,2122, C3E8,F0,2120
$A2:95E5             dx 000B, C201,01,2144, C3F3,00,2142, C3E8,01,2140, C208,FB,212A, C20C,01,212E, C3DD,FA,212C, C3F8,FB,2128, C3E8,FB,2126, C208,EB,2124, C3F8,EB,2122, C3E8,EB,2120
$A2:961E             dx 000B, C201,00,2142, C3EF,01,2140, C3EA,00,2142, C208,FA,212A, C20B,01,212E, C3DD,FB,212C, C3F8,FA,2128, C3E8,FA,2126, C208,EA,2124, C3F8,EA,2122, C3E8,EA,2120
$A2:9657             dx 000B, C3FF,01,2140, C3F3,00,2142, C3EA,01,2144, C208,F9,212A, C20C,01,212E, C3DD,FC,212C, C3F8,F9,2128, C3E8,F9,2126, C208,E9,2124, C3F8,E9,2122, C3E8,E9,2120
$A2:9690             dx 000B, C201,00,2142, C3F3,01,2144, C3EA,00,2142, C208,FA,212A, C20D,01,212E, C3DD,FB,212C, C3F8,FA,2128, C3E8,FA,2126, C208,EA,2124, C3F8,EA,2122, C3E8,EA,2120
$A2:96C9             dx 0006, C3E8,00,612A, C3F8,00,6128, C208,00,6126, C3E8,F0,6124, C3F8,F0,6122, C208,F0,6120
$A2:96E9             dx 0004, C200,00,610E, C200,F0,610C, C3F0,00,210E, C3F0,F0,210C
$A2:96FF             dx 000A, 0000,08,615F, 0000,00,615E, 01F8,08,215F, 01F8,00,215E, C206,00,6140, C3EA,00,2140, C200,FA,610E, C3F0,FA,210E, C200,EA,610C, C3F0,EA,210C
$A2:9733             dx 0001, C3F8,F8,6104
$A2:973A             dx 0001, C3F8,F8,6106
$A2:9741             dx 0001, C3F8,F8,6108
$A2:9748             dx 0001, C3F8,F8,610A
$A2:974F             dx 0002, 0000,FF,614D, C3F8,F8,6106
$A2:975B             dx 0002, 0000,00,614E, C3F8,F8,6108
$A2:9767             dx 0002, 0000,FF,614F, C3F8,F8,610A
$A2:9773             dx 0001, C3F8,F8,6102
$A2:977A             dx 0001, C3F8,F8,6100
$A2:9781             dx 0001, C3F8,F8,2102
$A2:9788             dx 0001, C3F8,F8,2100
$A2:978F             dx 0006, C3E8,00,612A, C3F8,00,6128, C208,00,6126, C3E8,F0,6124, C3F8,F0,6122, C208,F0,6120
$A2:97AF             dx 000E, 01F0,08,614B, 01F8,08,614A, 0000,08,6149, 0008,08,6148, 0010,08,6157, 0010,00,6147, 01E8,00,612B, 01F0,00,612A, 01F8,00,6129, 0000,00,6128, 0008,00,6127, C3E8,F0,6124, C3F8,F0,6122, C208,F0,6120
$A2:97F7             dx 000E, 01F0,08,615B, 01F8,08,615A, 0000,08,6159, 0008,08,6158, 0010,08,6156, 0010,00,6146, 01E8,00,612B, 01F0,00,612A, 01F8,00,6129, 0000,00,6128, 0008,00,6127, C3E8,F0,6124, C3F8,F0,6122, C208,F0,6120
$A2:983F             dx 000B, C3EF,01,6144, C3FD,00,6142, C208,01,6140, C3E8,FB,612A, C3E4,01,612E, C213,FA,612C, C3F8,FB,6128, C208,FB,6126, C3E8,EB,6124, C3F8,EB,6122, C208,EB,6120
$A2:9878             dx 000B, C3EF,00,6142, C201,01,6140, C206,00,6142, C3E8,FA,612A, C3E5,01,612E, C213,FB,612C, C3F8,FA,6128, C208,FA,6126, C3E8,EA,6124, C3F8,EA,6122, C208,EA,6120
$A2:98B1             dx 000B, C3F1,01,6140, C3FD,00,6142, C206,01,6144, C3E8,F9,612A, C3E4,01,612E, C213,FC,612C, C3F8,F9,6128, C208,F9,6126, C3E8,E9,6124, C3F8,E9,6122, C208,E9,6120
$A2:98EA             dx 000B, C3EF,00,6142, C3FD,01,6144, C206,00,6142, C3E8,FA,612A, C3E3,01,612E, C213,FB,612C, C3F8,FA,6128, C208,FA,6126, C3E8,EA,6124, C3F8,EA,6122, C208,EA,6120
$A2:9923             dx 0006, C208,00,212A, C3F8,00,2128, C3E8,00,2126, C208,F0,2124, C3F8,F0,2122, C3E8,F0,2120
$A2:9943             dx 0004, C3F0,00,210E, C3F0,F0,210C, C200,00,610E, C200,F0,610C
$A2:9959             dx 000A, 01F8,08,215F, 01F8,00,215E, 0000,08,615F, 0000,00,615E, C3EA,00,2140, C206,00,6140, C3F0,FA,210E, C200,FA,610E, C3F0,EA,210C, C200,EA,610C
}
}


;;; $998D..9E69: Thin hopping blobs ;;;
{
;;; $998D: Palette - enemy $CFBF (thin hopping blobs) ;;;
{
$A2:998D             dw 3800, 4B9C, 2610, 0CC6, 0C63, 42F7, 2A52, 19AD, 0D29, 5617, 3D72, 1C48, 0C05, 033B, 0216, 0113
}


;;; $99AD..9A06: Instruction lists - thin hopping blobs ;;;
{
;;; $99AD: Instruction list - grounded/dropping - fast ;;;
{
$A2:99AD             dx 0005,9DF6,
                        0005,9E02,
                        0005,9E0E,
                        0005,9E02,
                        80ED,99AD   ; Go to $99AD
}


;;; $99C1: Instruction list - grounded/dropping - medium ;;;
{
$A2:99C1             dx 0008,9DF6,
                        0008,9E02,
                        0008,9E0E,
                        0008,9E02,
                        80ED,99C1   ; Go to $99C1
}


;;; $99D5: Instruction list - grounded/dropping - slow ;;;
{
$A2:99D5             dx 000A,9DF6,
                        000A,9E02,
                        000A,9E0E,
                        000A,9E02,
                        80ED,99D5   ; Go to $99D5
}


;;; $99E9: Instruction list - hopping right frame 0 / hopping left frame 4 ;;;
{
$A2:99E9             dx 0001,9E5E,
                        812F        ; Sleep
}


;;; $99EF: Instruction list - hopping right frame 1 / hopping left frame 3 ;;;
{
$A2:99EF             dx 0001,9E4D,
                        812F        ; Sleep
}


;;; $99F5: Instruction list - hopping frame 2 ;;;
{
$A2:99F5             dx 0001,9E37,
                        812F        ; Sleep
}


;;; $99FB: Instruction list - hopping right frame 3 / hopping left frame 1 ;;;
{
$A2:99FB             dx 0001,9E26,
                        812F        ; Sleep
}


;;; $9A01: Instruction list - hopping right frame 4 / hopping left frame 0 ;;;
{
$A2:9A01             dx 0001,9E1A,
                        812F        ; Sleep
}
}


;;; $9A07: Hop table ;;;
{
;                        __________________ 0: Jump height
;                       |     _____________ 2: X speed. Unit of 1/100h px/frame
;                       |    |     ________ 4: Y speed table index delta. Also used for dropping speed, unit of 1/100h px/frame
;                       |    |    |     ___ 6: Airborne function
;                       |    |    |    |
$A2:9A07             dw 0010,0100,0200,9D0B, ; 0: Normal - small hop
                        0020,0100,0200,9D2B, ; 1: Normal - big hop
                        0020,0200,0300,9D4B, ; 2: Unused. Normal - long hop
                        0080,0140,0200,9D6B, ; 3: Giant hop
                        0000,0000,0100,9D98, ; 4: Dropping
                        0010,0100,01C0,9DCD, ; 5: Dropped - small hop
                        0015,0100,01C0,9DCD  ; 6: Dropped - big hop
}


;;; $9A3F: Initialisation AI - enemy $CFBF (thin hopping blobs) ;;;
{
$A2:9A3F AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9A42 A9 4D 80    LDA #$804D             ;\
$A2:9A45 9D 8E 0F    STA $0F8E,x[$7E:10CE]  ;} Enemy spritemap pointer = $804D
$A2:9A48 9E A8 0F    STZ $0FA8,x[$7E:10E8]  ; Enemy $0FA8 = 0 (never used)
$A2:9A4B A9 AD 99    LDA #$99AD             ;\
$A2:9A4E 20 6C 9A    JSR $9A6C  [$A2:9A6C]  ;} Set enemy instruction list to $99AD (grounded/dropping - fast)
$A2:9A51 A9 00 00    LDA #$0000             ;\
$A2:9A54 9F 00 78 7E STA $7E7800,x[$7E:7940];} Enemy hop type = 0
$A2:9A58 A9 65 9B    LDA #$9B65             ;\
$A2:9A5B 9D AE 0F    STA $0FAE,x[$7E:10EE]  ;} Enemy function = $9B65
$A2:9A5E BD B4 0F    LDA $0FB4,x[$7E:10F4]  ;\
$A2:9A61 9D AC 0F    STA $0FAC,x[$7E:10EC]  ;} Enemy hop cooldown timer = [enemy parameter 1]
$A2:9A64 A9 00 00    LDA #$0000             ;\
$A2:9A67 9F 08 78 7E STA $7E7808,x[$7E:7948];} Enemy invert direction flag = 0
$A2:9A6B 6B          RTL
}


;;; $9A6C: Set enemy instruction list ;;;
{
$A2:9A6C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9A6F 9D 92 0F    STA $0F92,x[$7E:10D2]
$A2:9A72 A9 01 00    LDA #$0001
$A2:9A75 9D 94 0F    STA $0F94,x[$7E:10D4]
$A2:9A78 9E 90 0F    STZ $0F90,x[$7E:10D0]
$A2:9A7B 60          RTS
}


;;; $9A7C: RTS ;;;
{
$A2:9A7C 60          RTS
}


;;; $9A7D: Main AI - enemy $CFBF (thin hopping blobs) ;;;
{
$A2:9A7D AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9A80 FC AE 0F    JSR ($0FAE,x)[$A2:9B65]
$A2:9A83 6B          RTL
}


;;; $9A84: Initiate hop ;;;
{
$A2:9A84 BF 00 78 7E LDA $7E7800,x[$7E:7980];\
$A2:9A88 C9 03 00    CMP #$0003             ;} If [enemy hop type] < 3:
$A2:9A8B 10 07       BPL $07    [$9A94]     ;/
$A2:9A8D 20 9B 9A    JSR $9A9B  [$A2:9A9B]  ; Check if Samus is in proximity
$A2:9A90 BF 00 78 7E LDA $7E7800,x[$7E:7980]

$A2:9A94 20 AA 9A    JSR $9AAA  [$A2:9AAA]  ; Choose hop type
$A2:9A97 20 1A 9B    JSR $9B1A  [$A2:9B1A]  ; Calculate fall time
$A2:9A9A 60          RTS
}


;;; $9A9B: Check if Samus is in proximity ;;;
{
$A2:9A9B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9A9E BD B6 0F    LDA $0FB6,x[$7E:1136]  ;\
$A2:9AA1 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;} Enemy hop type = (1 if Samus within [enemy parameter 2] pixel columns of enemy, else 0)
$A2:9AA5 9F 00 78 7E STA $7E7800,x[$7E:7980];/
$A2:9AA9 60          RTS
}


;;; $9AAA: Choose hop type ;;;
{
$A2:9AAA AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9AAD A9 01 00    LDA #$0001             ;\
$A2:9AB0 9F 04 78 7E STA $7E7804,x[$7E:7984];} Enemy direction = left
$A2:9AB4 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A2:9AB8 30 07       BMI $07    [$9AC1]     ;} If [Samus X position] >= [enemy X position]:
$A2:9ABA A9 00 00    LDA #$0000             ;\
$A2:9ABD 9F 04 78 7E STA $7E7804,x[$7E:7984];} Enemy direction = right

$A2:9AC1 BF 08 78 7E LDA $7E7808,x[$7E:7988];\
$A2:9AC5 F0 08       BEQ $08    [$9ACF]     ;} If enemy direction is inverted:
$A2:9AC7 BF 0A 78 7E LDA $7E780A,x[$7E:784A];\
$A2:9ACB 9F 04 78 7E STA $7E7804,x[$7E:7844];} Enemy direction = [enemy inverted direction]

$A2:9ACF A9 00 00    LDA #$0000             ;\
$A2:9AD2 9F 08 78 7E STA $7E7808,x[$7E:7988];} Enemy invert direction flag = 0
$A2:9AD6 20 06 9B    JSR $9B06  [$A2:9B06]  ; $1C = random number in 0..7
$A2:9AD9 BF 00 78 7E LDA $7E7800,x[$7E:7980]; A = [enemy hop type]
$A2:9ADD C9 03 00    CMP #$0003             ;\
$A2:9AE0 10 16       BPL $16    [$9AF8]     ;} If [enemy hop type] >= 3: go to BRANCH_9AF8
$A2:9AE2 C9 00 00    CMP #$0000             ;\
$A2:9AE5 D0 07       BNE $07    [$9AEE]     ;} If [enemy hop type] = 0:
$A2:9AE7 A5 1C       LDA $1C    [$7E:001C]  ;\
$A2:9AE9 29 01 00    AND #$0001             ;} $1C %= 2
$A2:9AEC 85 1C       STA $1C    [$7E:001C]  ;/

$A2:9AEE A5 1C       LDA $1C    [$7E:001C]  ;\
$A2:9AF0 C9 02 00    CMP #$0002             ;|
$A2:9AF3 30 03       BMI $03    [$9AF8]     ;} A = min(2, [$1C]) (pointless)
$A2:9AF5 A9 02 00    LDA #$0002             ;/

; BRANCH_9AF8
$A2:9AF8 0A          ASL A                  ;\
$A2:9AF9 0A          ASL A                  ;|
$A2:9AFA 0A          ASL A                  ;} Enemy hop table index = [A] * 8
$A2:9AFB 9D B2 0F    STA $0FB2,x[$7E:1132]  ;/
$A2:9AFE A8          TAY                    ;\
$A2:9AFF B9 0D 9A    LDA $9A0D,y[$A2:9A0D]  ;} Enemy airborne function = [$9A07 + [enemy hop table index] + 6]
$A2:9B02 9D B0 0F    STA $0FB0,x[$7E:1130]  ;/
$A2:9B05 60          RTS
}


;;; $9B06: $1C = random number in 0..7 ;;;
{
$A2:9B06 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9B09 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A2:9B0D AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A2:9B10 18          CLC                    ;|
$A2:9B11 7D A4 0F    ADC $0FA4,x[$7E:1124]  ;} $1C = ([random number] + [enemy frame counter]) % 8
$A2:9B14 29 07 00    AND #$0007             ;|
$A2:9B17 85 1C       STA $1C    [$7E:001C]  ;/
$A2:9B19 60          RTS
}


;;; $9B1A: Calculate initial hop speed ;;;
{
; Calculates how long it will take for enemy to fall [$9A07 + [enemy hop table index]] pixels I think
; Need to figure out how the [$9A07 + [enemy hop table index] + 2] scalar affects calculations
$A2:9B1A AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9B1D BC B2 0F    LDY $0FB2,x[$7E:1132]  ; Y = [enemy hop table index]
$A2:9B20 64 16       STZ $16    [$7E:0016]  ; $16 = 0 (Y speed table index)
$A2:9B22 64 18       STZ $18    [$7E:0018]  ; $18 = 0 (Y distance accumulator)

; LOOP
$A2:9B24 A5 16       LDA $16    [$7E:0016]  ;\
$A2:9B26 18          CLC                    ;|
$A2:9B27 79 09 9A    ADC $9A09,y[$A2:9A09]  ;} $16 += [$9A07 + [enemy hop table index] + 2]
$A2:9B2A 85 16       STA $16    [$7E:0016]  ;/
$A2:9B2C 29 00 FF    AND #$FF00             ;\
$A2:9B2F EB          XBA                    ;|
$A2:9B30 0A          ASL A                  ;|
$A2:9B31 0A          ASL A                  ;} Y = [$16] / 100h * 8 (quadratic speed table index)
$A2:9B32 0A          ASL A                  ;|
$A2:9B33 A8          TAY                    ;/
$A2:9B34 A5 18       LDA $18    [$7E:0018]  ;\
$A2:9B36 18          CLC                    ;|
$A2:9B37 79 90 83    ADC $8390,y[$A2:8398]  ;} $18 += floor([$838F + [Y] + 2].[$838F + [Y]] * 100h)
$A2:9B3A 85 18       STA $18    [$7E:0018]  ;/
$A2:9B3C BC B2 0F    LDY $0FB2,x[$7E:1132]  ; Y = [enemy hop table index]
$A2:9B3F B9 07 9A    LDA $9A07,y[$A2:9A07]  ;\
$A2:9B42 EB          XBA                    ;|
$A2:9B43 C5 18       CMP $18    [$7E:0018]  ;} If [$18] <= [$9A07 + [enemy hop table index]] * 100h: go to LOOP
$A2:9B45 10 DD       BPL $DD    [$9B24]     ;/
$A2:9B47 A5 16       LDA $16    [$7E:0016]  ;\
$A2:9B49 9D AA 0F    STA $0FAA,x[$7E:112A]  ;} Enemy Y speed table index = [$16]
$A2:9B4C A9 00 00    LDA #$0000             ;\
$A2:9B4F 9F 06 78 7E STA $7E7806,x[$7E:7986];} Enemy falling flag = 0
$A2:9B53 A5 16       LDA $16    [$7E:0016]  ;\
$A2:9B55 4A          LSR A                  ;} Enemy $7E:780E = [$16] * 1/2
$A2:9B56 9F 0E 78 7E STA $7E780E,x[$7E:798E];/
$A2:9B5A 4A          LSR A                  ;\
$A2:9B5B 18          CLC                    ;|
$A2:9B5C 7F 0E 78 7E ADC $7E780E,x[$7E:798E];} Enemy $7E:780C = [$16] * 3/4
$A2:9B60 9F 0C 78 7E STA $7E780C,x[$7E:798C];/
$A2:9B64 60          RTS
}


;;; $9B65: Thin hopping blob function - grounded ;;;
{
$A2:9B65 DE AC 0F    DEC $0FAC,x[$7E:112C]  ; Decrement enemy hop cooldown timer
$A2:9B68 10 16       BPL $16    [$9B80]     ; If [enemy hop cooldown timer] >= 0: return
$A2:9B6A A9 81 9B    LDA #$9B81             ;\
$A2:9B6D 9D AE 0F    STA $0FAE,x[$7E:112E]  ;} Enemy function = $9B81 (airborne)
$A2:9B70 BD B4 0F    LDA $0FB4,x[$7E:1134]  ;\
$A2:9B73 9D AC 0F    STA $0FAC,x[$7E:112C]  ;} Enemy hop cooldown timer = [enemy parameter 1]
$A2:9B76 A9 01 00    LDA #$0001             ;\
$A2:9B79 9F 02 78 7E STA $7E7802,x[$7E:7982];} Enemy hopping animation flag = 1
$A2:9B7D 20 84 9A    JSR $9A84  [$A2:9A84]  ; Initiate hop

$A2:9B80 60          RTS
}


;;; $9B81: Thin hopping blob function - airborne ;;;
{
$A2:9B81 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9B84 FC B0 0F    JSR ($0FB0,x)[$A2:9D0B]; Execute [enemy airborne function]
$A2:9B87 60          RTS
}


;;; $9B88: Thin hopping blob movement ;;;
{
$A2:9B88 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9B8B BD AA 0F    LDA $0FAA,x[$7E:112A]  ;\
$A2:9B8E C9 00 40    CMP #$4000             ;|
$A2:9B91 30 03       BMI $03    [$9B96]     ;|
$A2:9B93 A9 00 40    LDA #$4000             ;|
                                            ;|
$A2:9B96 29 00 FF    AND #$FF00             ;} Y = min(40h, [enemy Y speed table index] / 100h) * 8 (quadratic speed table index)
$A2:9B99 EB          XBA                    ;|
$A2:9B9A 0A          ASL A                  ;|
$A2:9B9B 0A          ASL A                  ;|
$A2:9B9C 0A          ASL A                  ;|
$A2:9B9D A8          TAY                    ;/
$A2:9B9E BF 06 78 7E LDA $7E7806,x[$7E:7986];\
$A2:9BA2 F0 04       BEQ $04    [$9BA8]     ;} If enemy is falling:
$A2:9BA4 88          DEY                    ;\
$A2:9BA5 88          DEY                    ;|
$A2:9BA6 88          DEY                    ;} Y -= 4 (negate speed)
$A2:9BA7 88          DEY                    ;/

$A2:9BA8 B9 93 83    LDA $8393,y[$A2:847B]  ;\
$A2:9BAB 85 12       STA $12    [$7E:0012]  ;|
$A2:9BAD B9 95 83    LDA $8395,y[$A2:847D]  ;} $14.$12 = [$838F + [Y] + 6].[$838F + [Y] + 4]
$A2:9BB0 85 14       STA $14    [$7E:0014]  ;/
$A2:9BB2 18          CLC
$A2:9BB3 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A2:9BB7 90 3C       BCC $3C    [$9BF5]     ; If not collided with block: go to BRANCH_NO_COLLISION
$A2:9BB9 BF 06 78 7E LDA $7E7806,x[$7E:7986];\
$A2:9BBD D0 27       BNE $27    [$9BE6]     ;} If enemy is not falling:
$A2:9BBF A5 01       LDA $01    [$7E:0001]  ;\
$A2:9BC1 9F 08 78 7E STA $7E7808,x[$7E:7848];} Enemy inverted direction flag = [$01] <-- typo, should be LDA #$0001
$A2:9BC5 BF 04 78 7E LDA $7E7804,x[$7E:7844];\
$A2:9BC9 49 01 00    EOR #$0001             ;} Enemy inverted direction = [enemy direction] ^ 1
$A2:9BCC 9F 0A 78 7E STA $7E780A,x[$7E:784A];/
$A2:9BD0 A9 04 00    LDA #$0004             ;\
$A2:9BD3 9F 00 78 7E STA $7E7800,x[$7E:7840];} Enemy hop type = dropping
$A2:9BD7 A9 98 9D    LDA #$9D98             ;\
$A2:9BDA 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;} Enemy airborne function = $9D98 (dropping)
$A2:9BDD A9 00 00    LDA #$0000             ;\
$A2:9BE0 9F 02 78 7E STA $7E7802,x[$7E:7842];} Enemy hopping animation flag = 0
$A2:9BE4 80 0D       BRA $0D    [$9BF3]

$A2:9BE6 A9 65 9B    LDA #$9B65             ;\ Else (enemy is falling):
$A2:9BE9 9D AE 0F    STA $0FAE,x[$7E:112E]  ;} Enemy function = $9B65 (grounded)
$A2:9BEC A9 00 00    LDA #$0000             ;\
$A2:9BEF 9F 02 78 7E STA $7E7802,x[$7E:7982];} Enemy hopping animation flag = 0

$A2:9BF3 80 7B       BRA $7B    [$9C70]     ; Return

; BRANCH_NO_COLLISION
$A2:9BF5 BC B2 0F    LDY $0FB2,x[$7E:1132]  ; Y = [enemy hop table index]
$A2:9BF8 BF 06 78 7E LDA $7E7806,x[$7E:7986];\
$A2:9BFC D0 0F       BNE $0F    [$9C0D]     ;} If enemy is not falling:
$A2:9BFE 20 71 9C    JSR $9C71  [$A2:9C71]  ; Set rising instruction list
$A2:9C01 BD AA 0F    LDA $0FAA,x[$7E:112A]  ;\
$A2:9C04 38          SEC                    ;|
$A2:9C05 F9 0B 9A    SBC $9A0B,y[$A2:9A0B]  ;} Enemy Y speed table index -= [$9A07 + [Y] + 4]
$A2:9C08 9D AA 0F    STA $0FAA,x[$7E:112A]  ;/
$A2:9C0B 80 0D       BRA $0D    [$9C1A]

                                            ; Else (enemy is falling):
$A2:9C0D 20 BE 9C    JSR $9CBE  [$A2:9CBE]  ; Set falling instruction list
$A2:9C10 BD AA 0F    LDA $0FAA,x[$7E:112A]  ;\
$A2:9C13 18          CLC                    ;|
$A2:9C14 79 0B 9A    ADC $9A0B,y[$A2:9A0B]  ;} Enemy Y speed table index += [$9A07 + [Y] + 4]
$A2:9C17 9D AA 0F    STA $0FAA,x[$7E:112A]  ;/

$A2:9C1A 10 0A       BPL $0A    [$9C26]     ; If [enemy Y speed table index] < 0:
$A2:9C1C A9 01 00    LDA #$0001             ;\
$A2:9C1F 9F 06 78 7E STA $7E7806,x[$7E:7986];} Enemy falling flag = 1
$A2:9C23 9E AA 0F    STZ $0FAA,x[$7E:112A]  ; Enemy Y speed table index = 0

$A2:9C26 BC B2 0F    LDY $0FB2,x[$7E:1132]
$A2:9C29 B9 09 9A    LDA $9A09,y[$A2:9A09]  ;\
$A2:9C2C 29 00 FF    AND #$FF00             ;|
$A2:9C2F EB          XBA                    ;} $14 = [$9A07 + [Y] + 2] / 100h
$A2:9C30 85 14       STA $14    [$7E:0014]  ;/
$A2:9C32 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$A2:9C34 BF 04 78 7E LDA $7E7804,x[$7E:7984];\
$A2:9C38 F0 08       BEQ $08    [$9C42]     ;} If [enemy direction] != right:
$A2:9C3A A5 14       LDA $14    [$7E:0014]  ;\
$A2:9C3C 49 FF FF    EOR #$FFFF             ;|
$A2:9C3F 1A          INC A                  ;} Negate $14
$A2:9C40 85 14       STA $14    [$7E:0014]  ;/

$A2:9C42 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [$14]
$A2:9C46 90 28       BCC $28    [$9C70]     ; If collided with wall:
$A2:9C48 A9 01 00    LDA #$0001             ;\
$A2:9C4B 9F 08 78 7E STA $7E7808,x[$7E:7A08];} Enemy invert direction flag = 1
$A2:9C4F BF 04 78 7E LDA $7E7804,x[$7E:7A04];\
$A2:9C53 49 01 00    EOR #$0001             ;} Enemy inverted direction = [enemy direction] ^ 1
$A2:9C56 9F 0A 78 7E STA $7E780A,x[$7E:7A0A];/
$A2:9C5A A9 00 00    LDA #$0000             ;\
$A2:9C5D 9F 02 78 7E STA $7E7802,x[$7E:7A02];} Enemy hopping animation flag = 0
$A2:9C61 A9 04 00    LDA #$0004             ;\
$A2:9C64 9F 00 78 7E STA $7E7800,x[$7E:7A00];} Enemy hop type = dropping
$A2:9C68 A9 98 9D    LDA #$9D98             ;\
$A2:9C6B 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;} Enemy airborne function = $9D98 (dropping)
$A2:9C6E 80 00       BRA $00    [$9C70]

$A2:9C70 60          RTS
}


;;; $9C71: Set rising instruction list ;;;
{
$A2:9C71 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9C74 BF 04 78 7E LDA $7E7804,x[$7E:7984];\
$A2:9C78 D0 20       BNE $20    [$9C9A]     ;} If [enemy direction] != right: go to BRANCH_LEFT
$A2:9C7A BD AA 0F    LDA $0FAA,x[$7E:112A]  ;\
$A2:9C7D DF 0C 78 7E CMP $7E780C,x[$7E:798C];} If [enemy Y speed table index] >= [enemy initial Y speed table index * 3/4]: go to BRANCH_RIGHT_FRAME_0
$A2:9C81 10 08       BPL $08    [$9C8B]     ;/
$A2:9C83 DF 0E 78 7E CMP $7E780E,x[$7E:798E];\
$A2:9C87 10 07       BPL $07    [$9C90]     ;} If [enemy Y speed table index] >= [enemy initial Y speed table index * 1/4]: go to BRANCH_RIGHT_FRAME_1
$A2:9C89 80 0A       BRA $0A    [$9C95]     ; Go to BRANCH_RIGHT_FRAME_2

; BRANCH_RIGHT_FRAME_0
$A2:9C8B A9 E9 99    LDA #$99E9             ; A = $99E9
$A2:9C8E 80 2A       BRA $2A    [$9CBA]     ; Go to BRANCH_RETURN

; BRANCH_RIGHT_FRAME_1
$A2:9C90 A9 EF 99    LDA #$99EF             ; A = $99EF
$A2:9C93 80 25       BRA $25    [$9CBA]     ; Go to BRANCH_RETURN

; BRANCH_RIGHT_FRAME_2
$A2:9C95 A9 F5 99    LDA #$99F5             ; A = $99F5
$A2:9C98 80 20       BRA $20    [$9CBA]     ; Go to BRANCH_RETURN

; BRANCH_LEFT
$A2:9C9A BD AA 0F    LDA $0FAA,x[$7E:11EA]  ;\
$A2:9C9D DF 0C 78 7E CMP $7E780C,x[$7E:7A4C];} If [enemy Y speed table index] >= [enemy initial Y speed table index * 3/4]: go to BRANCH_LEFT_FRAME_0
$A2:9CA1 10 08       BPL $08    [$9CAB]     ;/
$A2:9CA3 DF 0E 78 7E CMP $7E780E,x[$7E:7A4E];\
$A2:9CA7 10 07       BPL $07    [$9CB0]     ;} If [enemy Y speed table index] >= [enemy initial Y speed table index * 1/4]: go to BRANCH_LEFT_FRAME_1
$A2:9CA9 80 0A       BRA $0A    [$9CB5]     ; Go to BRANCH_LEFT_FRAME_2

; BRANCH_LEFT_FRAME_0
$A2:9CAB A9 01 9A    LDA #$9A01             ; A = $9A01
$A2:9CAE 80 0A       BRA $0A    [$9CBA]     ; Go to BRANCH_RETURN

; BRANCH_LEFT_FRAME_1
$A2:9CB0 A9 FB 99    LDA #$99FB             ; A = $99FB
$A2:9CB3 80 05       BRA $05    [$9CBA]     ; Go to BRANCH_RETURN

; BRANCH_LEFT_FRAME_2
$A2:9CB5 A9 F5 99    LDA #$99F5             ; A = $99F5
$A2:9CB8 80 00       BRA $00    [$9CBA]

; BRANCH_RETURN
$A2:9CBA 20 6C 9A    JSR $9A6C  [$A2:9A6C]  ; Set enemy instruction list to [A]
$A2:9CBD 60          RTS
}


;;; $9CBE: Set falling instruction list ;;;
{
$A2:9CBE AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9CC1 BF 04 78 7E LDA $7E7804,x[$7E:7984];\
$A2:9CC5 D0 20       BNE $20    [$9CE7]     ;} If [enemy direction] != right: go to BRANCH_LEFT
$A2:9CC7 BD AA 0F    LDA $0FAA,x[$7E:112A]  ;\
$A2:9CCA DF 0E 78 7E CMP $7E780E,x[$7E:798E];} If [enemy Y speed table index] < [enemy initial Y speed table index * 1/4]: go to BRANCH_RIGHT_FRAME_2
$A2:9CCE 30 08       BMI $08    [$9CD8]     ;/
$A2:9CD0 DF 0C 78 7E CMP $7E780C,x[$7E:798C];\
$A2:9CD4 30 07       BMI $07    [$9CDD]     ;} If [enemy Y speed table index] < [enemy initial Y speed table index * 3/4]: go to BRANCH_RIGHT_FRAME_3
$A2:9CD6 80 0A       BRA $0A    [$9CE2]     ; Go to BRANCH_RIGHT_FRAME_4

; BRANCH_RIGHT_FRAME_2
$A2:9CD8 A9 F5 99    LDA #$99F5             ; A = $99F5
$A2:9CDB 80 2A       BRA $2A    [$9D07]     ; Go to BRANCH_RETURN

; BRANCH_RIGHT_FRAME_3
$A2:9CDD A9 FB 99    LDA #$99FB             ; A = $99FB
$A2:9CE0 80 25       BRA $25    [$9D07]     ; Go to BRANCH_RETURN

; BRANCH_RIGHT_FRAME_4
$A2:9CE2 A9 01 9A    LDA #$9A01             ; A = $9A01
$A2:9CE5 80 20       BRA $20    [$9D07]     ; Go to BRANCH_RETURN

; BRANCH_LEFT
$A2:9CE7 BD AA 0F    LDA $0FAA,x[$7E:11AA]  ;\
$A2:9CEA DF 0E 78 7E CMP $7E780E,x[$7E:7A0E];} If [enemy Y speed table index] < [enemy initial Y speed table index * 1/4]: go to BRANCH_LEFT_FRAME_2
$A2:9CEE 30 08       BMI $08    [$9CF8]     ;/
$A2:9CF0 DF 0C 78 7E CMP $7E780C,x[$7E:7A0C];\
$A2:9CF4 30 07       BMI $07    [$9CFD]     ;} If [enemy Y speed table index] < [enemy initial Y speed table index * 3/4]: go to BRANCH_LEFT_FRAME_3
$A2:9CF6 80 0A       BRA $0A    [$9D02]     ; Go to BRANCH_LEFT_FRAME_4

; BRANCH_LEFT_FRAME_2
$A2:9CF8 A9 F5 99    LDA #$99F5             ; A = $99F5
$A2:9CFB 80 0A       BRA $0A    [$9D07]     ; Go to BRANCH_RETURN

; BRANCH_LEFT_FRAME_3
$A2:9CFD A9 EF 99    LDA #$99EF             ; A = $99EF
$A2:9D00 80 05       BRA $05    [$9D07]     ; Go to BRANCH_RETURN

; BRANCH_LEFT_FRAME_4
$A2:9D02 A9 E9 99    LDA #$99E9             ; A = $99E9
$A2:9D05 80 00       BRA $00    [$9D07]

; BRANCH_RETURN
$A2:9D07 20 6C 9A    JSR $9A6C  [$A2:9A6C]  ; Set enemy instruction list to [A]
$A2:9D0A 60          RTS
}


;;; $9D0B: Thin hopping blob airborne function - normal - short hop ;;;
{
$A2:9D0B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9D0E 20 88 9B    JSR $9B88  [$A2:9B88]  ; Thin hopping blob movement
$A2:9D11 BF 08 78 7E LDA $7E7808,x[$7E:7988];\
$A2:9D15 D0 06       BNE $06    [$9D1D]     ;} If enemy direction not inverted:
$A2:9D17 BF 02 78 7E LDA $7E7802,x[$7E:7982];\
$A2:9D1B D0 0D       BNE $0D    [$9D2A]     ;} If enemy hopping animation active: return

$A2:9D1D A9 00 00    LDA #$0000             ;\
$A2:9D20 9F 02 78 7E STA $7E7802,x[$7E:7A02];} Enemy hopping animation flag = 0
$A2:9D24 A9 D5 99    LDA #$99D5             ;\
$A2:9D27 20 6C 9A    JSR $9A6C  [$A2:9A6C]  ;} Set enemy instruction list to $99D5 (grounded/dropping - slow)

$A2:9D2A 60          RTS
}


;;; $9D2B: Thin hopping blob airborne function - normal - big hop ;;;
{
$A2:9D2B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9D2E 20 88 9B    JSR $9B88  [$A2:9B88]  ; Thin hopping blob movement
$A2:9D31 BF 08 78 7E LDA $7E7808,x[$7E:7948];\
$A2:9D35 D0 06       BNE $06    [$9D3D]     ;} If enemy direction not inverted:
$A2:9D37 BF 02 78 7E LDA $7E7802,x[$7E:7942];\
$A2:9D3B D0 0D       BNE $0D    [$9D4A]     ;} If enemy hopping animation active: return
                                            
$A2:9D3D A9 00 00    LDA #$0000             ;\
$A2:9D40 9F 02 78 7E STA $7E7802,x[$7E:7982];} Enemy hopping animation flag = 0
$A2:9D44 A9 C1 99    LDA #$99C1             ;\
$A2:9D47 20 6C 9A    JSR $9A6C  [$A2:9A6C]  ;} Set enemy instruction list to $99C1 (grounded/dropping - medium)

$A2:9D4A 60          RTS
}


;;; $9D4B: Thin hopping blob airborne function - normal - long hop ;;;
{
$A2:9D4B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9D4E 20 88 9B    JSR $9B88  [$A2:9B88]  ; Thin hopping blob movement
$A2:9D51 BF 08 78 7E LDA $7E7808,x[$7E:7908];\
$A2:9D55 D0 06       BNE $06    [$9D5D]     ;} If enemy direction not inverted:
$A2:9D57 BF 02 78 7E LDA $7E7802,x[$7E:7902];\
$A2:9D5B D0 0D       BNE $0D    [$9D6A]     ;} If enemy hopping animation active: return
                                            
$A2:9D5D A9 00 00    LDA #$0000             ;\
$A2:9D60 9F 02 78 7E STA $7E7802,x[$7E:7902];} Enemy hopping animation flag = 0
$A2:9D64 A9 AD 99    LDA #$99AD             ;\
$A2:9D67 20 6C 9A    JSR $9A6C  [$A2:9A6C]  ;} Set enemy instruction list to $99AD (grounded/dropping - fast)

$A2:9D6A 60          RTS
}


;;; $9D6B: Thin hopping blob airborne function - giant hop ;;;
{
$A2:9D6B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9D6E 20 88 9B    JSR $9B88  [$A2:9B88]  ; Thin hopping blob movement
$A2:9D71 BF 08 78 7E LDA $7E7808,x          ;\
$A2:9D75 D0 13       BNE $13    [$9D8A]     ;} If enemy direction not inverted:
$A2:9D77 BF 02 78 7E LDA $7E7802,x          ;\
$A2:9D7B D0 1A       BNE $1A    [$9D97]     ;} If enemy hopping animation active: return
$A2:9D7D A9 00 00    LDA #$0000             ;\
$A2:9D80 9F 00 78 7E STA $7E7800,x          ;} Enemy hop type = 0 (normal)
$A2:9D84 A9 65 9B    LDA #$9B65             ;\
$A2:9D87 9D AE 0F    STA $0FAE,x            ;} Enemy function = $9B65 (grounded)

$A2:9D8A A9 00 00    LDA #$0000             ;\
$A2:9D8D 9F 02 78 7E STA $7E7802,x          ;} Enemy hopping animation flag = 0
$A2:9D91 A9 D5 99    LDA #$99D5             ;\
$A2:9D94 20 6C 9A    JSR $9A6C  [$A2:9A6C]  ;} Set enemy instruction list to $99D5 (grounded/dropping - slow)

$A2:9D97 60          RTS
}


;;; $9D98: Thin hopping blob airborne function - dropping ;;;
{
$A2:9D98 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9D9B BC B2 0F    LDY $0FB2,x[$7E:11B2]  ;\
$A2:9D9E B9 0B 9A    LDA $9A0B,y[$A2:9A13]  ;|
$A2:9DA1 29 00 FF    AND #$FF00             ;|
$A2:9DA4 EB          XBA                    ;|
$A2:9DA5 85 14       STA $14    [$7E:0014]  ;} $14.$12 = [$9A07 + [enemy hop table index] + 4] / 100h
$A2:9DA7 B9 0B 9A    LDA $9A0B,y[$A2:9A13]  ;|
$A2:9DAA 29 FF 00    AND #$00FF             ;|
$A2:9DAD EB          XBA                    ;|
$A2:9DAE 85 12       STA $12    [$7E:0012]  ;/
$A2:9DB0 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A2:9DB4 90 16       BCC $16    [$9DCC]     ; If collided with block:
$A2:9DB6 20 06 9B    JSR $9B06  [$A2:9B06]  ; $1C = random number in 0..7
$A2:9DB9 A5 1C       LDA $1C    [$7E:001C]  ;\
$A2:9DBB 29 01 00    AND #$0001             ;|
$A2:9DBE 18          CLC                    ;} Enemy hop type = 5 + [$1C] % 2 (dropped)
$A2:9DBF 69 05 00    ADC #$0005             ;|
$A2:9DC2 9F 00 78 7E STA $7E7800,x[$7E:7900];/
$A2:9DC6 A9 65 9B    LDA #$9B65             ;\
$A2:9DC9 9D AE 0F    STA $0FAE,x[$7E:10AE]  ;} Enemy function = $9B65 (grounded)

$A2:9DCC 60          RTS
}


;;; $9DCD: Thin hopping blob airborne function - dropped ;;;
{
$A2:9DCD AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9DD0 20 88 9B    JSR $9B88  [$A2:9B88]  ; Thin hopping blob movement
$A2:9DD3 BF 02 78 7E LDA $7E7802,x[$7E:7842];\
$A2:9DD7 D0 1A       BNE $1A    [$9DF3]     ;} If enemy hopping animation active: return
$A2:9DD9 A9 00 00    LDA #$0000             ;\
$A2:9DDC 9F 02 78 7E STA $7E7802,x[$7E:7842];} Enemy hopping animation flag = 0
$A2:9DE0 A9 03 00    LDA #$0003             ;\
$A2:9DE3 9F 00 78 7E STA $7E7800,x[$7E:7840];} Enemy hop type = 3 (giant hop)
$A2:9DE7 A9 65 9B    LDA #$9B65             ;\
$A2:9DEA 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;} Enemy function = $9B65 (grounded)
$A2:9DED A9 D5 99    LDA #$99D5             ;\
$A2:9DF0 20 6C 9A    JSR $9A6C  [$A2:9A6C]  ;} Set enemy instruction list to $99D5 (grounded/dropping - slow)

$A2:9DF3 60          RTS
}


;;; $9DF4: RTL ;;;
{
$A2:9DF4 6B          RTL
}


;;; $9DF5: RTL ;;;
{
$A2:9DF5 6B          RTL
}


;;; $9DF6: Spritemaps - thin hopping blobs ;;;
{
$A2:9DF6             dx 0002, 0000,FC,6100, 01F8,FC,2100
$A2:9E02             dx 0002, 0000,FC,6101, 01F8,FC,2101
$A2:9E0E             dx 0002, 0000,FC,6102, 01F8,FC,2102
$A2:9E1A             dx 0002, 0000,FC,2108, 01F8,FC,2107
$A2:9E26             dx 0003, 0004,FC,210B, 01FC,FC,210A, 01F4,FC,2109
$A2:9E37             dx 0004, 0008,FC,210F, 0000,FC,210E, 01F8,FC,210D, 01F0,FC,210C
$A2:9E4D             dx 0003, 01F4,FC,610B, 01FC,FC,610A, 0004,FC,6109
$A2:9E5E             dx 0002, 01F8,FC,6108, 0000,FC,6107
}
}


;;; $9E6A..A38A: Spike shooting plant ;;;
{
;;; $9E6A: Palette - enemy $CFFF (spike shooting plant) ;;;
{
$A2:9E6A             dw 3800, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 57FF, 42F7, 2610, 158C, 017F, 0016, 300A
}


;;; $9E8A..9F29: Instruction list - spike shooting plant ;;;
{
;;; $9E8A: Instruction list -  ;;;
{
$A2:9E8A             dx A095,       ; ???
                        0008,A0BB,
                        0008,A0DB,
                        0008,A0FB,
                        0008,A11B,
                        0008,A13B,
                        0008,A15B,
                        0008,A17B,
                        0008,A19B,
                        80ED,9E8A   ; Go to $9E8A
}


;;; $9EB0: Instruction list -  ;;;
{
$A2:9EB0             dx 0015,A0BB,
                        0005,A1BB,
                        0015,A1EF,
                        0005,A1BB,
                        9F2A,       ; ???
                        A0A7,0000,  ; ???
                        A0A7,000C,  ; ???
                        A0A7,0002,  ; ???
                        A0A7,000E,  ; ???
                        A0A7,0004,  ; ???
                        80ED,9E8A   ; Go to $9E8A
}


;;; $9EDA: Instruction list -  ;;;
{
$A2:9EDA             dx A095,       ; ???
                        0008,A223,
                        0008,A243,
                        0008,A263,
                        0008,A283,
                        0008,A2A3,
                        0008,A2C3,
                        0008,A2E3,
                        0008,A303,
                        80ED,9EDC   ; Go to $9EDC
}


;;; $9F00: Instruction list -  ;;;
{
$A2:9F00             dx 0015,A223,
                        0005,A323,
                        0015,A357,
                        0005,A323,
                        9F2A,       ; ???
                        A0A7,0006,  ; ???
                        A0A7,0010,  ; ???
                        A0A7,0008,  ; ???
                        A0A7,0012,  ; ???
                        A0A7,000A,  ; ???
                        80ED,9EDA   ; Go to $9EDA
}
}


;;; $9F2A: Instruction ;;;
{
$A2:9F2A DA          PHX
$A2:9F2B 5A          PHY
$A2:9F2C A9 34 00    LDA #$0034             ;\
$A2:9F2F 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 34h, sound library 2, max queued sounds allowed = 6 (spike shooting plant spikes)
$A2:9F33 7A          PLY
$A2:9F34 FA          PLX
$A2:9F35 6B          RTL
}


;;; $9F36: Spike shooting plant X radius of travel ;;;
{
; Indexed by Speed2 low
$A2:9F36             dw 0010, 0040, 0050, 0060, 0070, 0080
}


;;; $9F42: Spike shooting plant function pointers ;;;
{
; Indexed by Speed low
$A2:9F42             dw 9FBA, 9FEC, A01B
}


;;; $9F48: Initialisation AI - enemy $CFFF (spike shooting plant) ;;;
{
$A2:9F48 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9F4B A9 4D 80    LDA #$804D
$A2:9F4E 9D 8E 0F    STA $0F8E,x[$7E:0F8E]
$A2:9F51 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A2:9F54 29 FF 00    AND #$00FF
$A2:9F57 F0 05       BEQ $05    [$9F5E]
$A2:9F59 20 49 A0    JSR $A049  [$A2:A049]
$A2:9F5C 80 03       BRA $03    [$9F61]

$A2:9F5E 20 6F A0    JSR $A06F  [$A2:A06F]

$A2:9F61 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:9F64 29 FF 00    AND #$00FF
$A2:9F67 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:9F6A 0A          ASL A
$A2:9F6B A8          TAY
$A2:9F6C B9 42 9F    LDA $9F42,y[$A2:9F42]
$A2:9F6F 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:9F72 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A2:9F75 29 FF 00    AND #$00FF
$A2:9F78 0A          ASL A
$A2:9F79 A8          TAY
$A2:9F7A BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:9F7D 18          CLC
$A2:9F7E 79 36 9F    ADC $9F36,y[$A2:9F38]
$A2:9F81 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:9F85 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:9F88 38          SEC
$A2:9F89 F9 36 9F    SBC $9F36,y[$A2:9F38]
$A2:9F8C 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:9F90 BD B7 0F    LDA $0FB7,x[$7E:0FB7]
$A2:9F93 29 FF 00    AND #$00FF
$A2:9F96 0A          ASL A
$A2:9F97 0A          ASL A
$A2:9F98 0A          ASL A
$A2:9F99 A8          TAY
$A2:9F9A B9 87 81    LDA $8187,y[$A2:819F]
$A2:9F9D 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A2:9FA0 B9 89 81    LDA $8189,y[$A2:81A1]
$A2:9FA3 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:9FA6 B9 8B 81    LDA $818B,y[$A2:81A3]
$A2:9FA9 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:9FAC B9 8D 81    LDA $818D,y[$A2:81A5]
$A2:9FAF 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:9FB2 6B          RTL
}


;;; $9FB3: Main AI - enemy $CFFF (spike shooting plant) ;;;
{
$A2:9FB3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9FB6 FC B2 0F    JSR ($0FB2,x)[$A2:9FBA]
$A2:9FB9 6B          RTL
}


;;; $9FBA:  ;;;
{
$A2:9FBA AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9FBD BD 7C 0F    LDA $0F7C,x[$7E:0F7C]
$A2:9FC0 18          CLC
$A2:9FC1 7D AC 0F    ADC $0FAC,x[$7E:0FAC]
$A2:9FC4 90 03       BCC $03    [$9FC9]
$A2:9FC6 FE 7A 0F    INC $0F7A,x[$7E:0F7A]

$A2:9FC9 9D 7C 0F    STA $0F7C,x[$7E:0F7C]
$A2:9FCC BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:9FCF 18          CLC
$A2:9FD0 7D AE 0F    ADC $0FAE,x[$7E:0FAE]
$A2:9FD3 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$A2:9FD6 DF 00 78 7E CMP $7E7800,x[$7E:7800]
$A2:9FDA 10 0C       BPL $0C    [$9FE8]
$A2:9FDC A9 EC 9F    LDA #$9FEC
$A2:9FDF 9D B2 0F    STA $0FB2,x[$7E:10F2]
$A2:9FE2 A9 01 00    LDA #$0001
$A2:9FE5 9D B0 0F    STA $0FB0,x[$7E:10F0]

$A2:9FE8 20 1C A0    JSR $A01C  [$A2:A01C]
$A2:9FEB 60          RTS
}


;;; $9FEC:  ;;;
{
$A2:9FEC AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:9FEF BD 7C 0F    LDA $0F7C,x[$7E:0FFC]
$A2:9FF2 18          CLC
$A2:9FF3 7D A8 0F    ADC $0FA8,x[$7E:1028]
$A2:9FF6 90 03       BCC $03    [$9FFB]
$A2:9FF8 FE 7A 0F    INC $0F7A,x[$7E:0FFA]

$A2:9FFB 9D 7C 0F    STA $0F7C,x[$7E:0FFC]
$A2:9FFE BD 7A 0F    LDA $0F7A,x[$7E:0FFA]
$A2:A001 18          CLC
$A2:A002 7D AA 0F    ADC $0FAA,x[$7E:102A]
$A2:A005 9D 7A 0F    STA $0F7A,x[$7E:0FFA]
$A2:A008 DF 02 78 7E CMP $7E7802,x[$7E:7882]
$A2:A00C 30 09       BMI $09    [$A017]
$A2:A00E A9 BA 9F    LDA #$9FBA
$A2:A011 9D B2 0F    STA $0FB2,x[$7E:10F2]
$A2:A014 9E B0 0F    STZ $0FB0,x[$7E:10F0]

$A2:A017 20 1C A0    JSR $A01C  [$A2:A01C]
$A2:A01A 60          RTS
}


;;; $A01B: RTS ;;;
{
$A2:A01B 60          RTS
}


;;; $A01C:  ;;;
{
$A2:A01C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A01F 22 11 81 80 JSL $808111[$80:8111]
$A2:A023 AD E5 05    LDA $05E5  [$7E:05E5]
$A2:A026 18          CLC
$A2:A027 7D A4 0F    ADC $0FA4,x[$7E:0FA4]
$A2:A02A 29 FF 00    AND #$00FF
$A2:A02D C9 03 00    CMP #$0003
$A2:A030 10 16       BPL $16    [$A048]
$A2:A032 A9 1B A0    LDA #$A01B
$A2:A035 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:A038 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A2:A03B 29 FF 00    AND #$00FF
$A2:A03E F0 05       BEQ $05    [$A045]
$A2:A040 20 5C A0    JSR $A05C  [$A2:A05C]
$A2:A043 80 03       BRA $03    [$A048]

$A2:A045 20 82 A0    JSR $A082  [$A2:A082]

$A2:A048 60          RTS
}


;;; $A049:  ;;;
{
$A2:A049 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A04C A9 8A 9E    LDA #$9E8A
$A2:A04F 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:A052 A9 01 00    LDA #$0001
$A2:A055 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:A058 9E 90 0F    STZ $0F90,x[$7E:0F90]
$A2:A05B 60          RTS
}


;;; $A05C:  ;;;
{
$A2:A05C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A05F A9 B0 9E    LDA #$9EB0
$A2:A062 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:A065 A9 01 00    LDA #$0001
$A2:A068 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:A06B 9E 90 0F    STZ $0F90,x[$7E:0F90]
$A2:A06E 60          RTS
}


;;; $A06F:  ;;;
{
$A2:A06F AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A072 A9 DA 9E    LDA #$9EDA
$A2:A075 9D 92 0F    STA $0F92,x[$7E:1092]
$A2:A078 A9 01 00    LDA #$0001
$A2:A07B 9D 94 0F    STA $0F94,x[$7E:1094]
$A2:A07E 9E 90 0F    STZ $0F90,x[$7E:1090]
$A2:A081 60          RTS
}


;;; $A082:  ;;;
{
$A2:A082 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A085 A9 00 9F    LDA #$9F00
$A2:A088 9D 92 0F    STA $0F92,x[$7E:1052]
$A2:A08B A9 01 00    LDA #$0001
$A2:A08E 9D 94 0F    STA $0F94,x[$7E:1054]
$A2:A091 9E 90 0F    STZ $0F90,x[$7E:1050]
$A2:A094 60          RTS
}


;;; $A095: Instruction ;;;
{
$A2:A095 A9 BA 9F    LDA #$9FBA
$A2:A098 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:A09B BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A2:A09E F0 06       BEQ $06    [$A0A6]
$A2:A0A0 A9 EC 9F    LDA #$9FEC
$A2:A0A3 9D B2 0F    STA $0FB2,x[$7E:1032]

$A2:A0A6 6B          RTL
}


;;; $A0A7: Instruction ;;;
{
$A2:A0A7 5A          PHY
$A2:A0A8 B9 00 00    LDA $0000,y[$A2:9EC4]
$A2:A0AB AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A0AE A0 FE DA    LDY #$DAFE             ;\
$A2:A0B1 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn spike shooting plant spikes enemy projectile
$A2:A0B5 7A          PLY
$A2:A0B6 C8          INY
$A2:A0B7 C8          INY
$A2:A0B8 6B          RTL
}


;;; $A0B9: RTL ;;;
{
$A2:A0B9 6B          RTL
}


;;; $A0BA: RTL ;;;
{
$A2:A0BA 6B          RTL
}


;;; $A0BB: Spritemaps - spike shooting plant ;;;
{
$A2:A0BB             dx 0006, 0000,04,610C, 0004,04,610B, 01F8,04,210C, 01F4,04,210B, 01FC,EF,211C, C3F8,F7,2100
$A2:A0DB             dx 0006, 01F8,04,210C, 01F4,05,210C, 0000,04,610C, 0004,04,610B, 01FC,F0,211C, C3F8,F8,2100
$A2:A0FB             dx 0006, 01FA,05,210D, 01F4,04,210C, 0000,04,610C, 0004,04,610B, 01FC,F0,211C, C3F8,F8,2100
$A2:A11B             dx 0006, 0000,05,610B, 01FA,04,210D, 01F4,04,210C, 0004,04,610B, 01FC,F1,211C, C3F8,F9,2100
$A2:A13B             dx 0006, 0000,04,610B, 0004,05,610C, 01FA,04,210D, 01F4,04,210C, 01FC,F1,211C, C3F8,F9,2100
$A2:A15B             dx 0006, 0000,05,610C, 0004,04,610C, 01FA,04,210D, 01F4,04,210C, 01FC,F0,211C, C3F8,F8,2100
$A2:A17B             dx 0006, 0000,04,610C, 0004,04,610C, 01F8,05,210C, 01F4,04,210C, 01FC,F0,211C, C3F8,F8,2100
$A2:A19B             dx 0006, 0000,04,610C, 0004,04,610C, 01F8,04,210C, 01F4,05,210B, 01FC,EF,211C, C3F8,F7,2100
$A2:A1BB             dx 000A, 01FC,ED,211C, 0000,04,610C, 0004,04,610B, 01F8,04,210C, 01F4,04,210B, 0004,02,210A, 01FC,02,2109, 01F4,02,2108, C3FC,F2,2103, C3F4,F2,2102
$A2:A1EF             dx 000A, 01FC,E9,211C, 0000,04,610C, 0004,04,610B, 01F8,04,210C, 01F4,04,210B, 0004,00,211A, 01FC,00,2119, 01F4,00,2118, C3FC,F0,2106, C3F4,F0,2105
$A2:A223             dx 0006, 0000,F4,E10C, 0004,F4,E10B, 01F8,F4,A10C, 01F4,F4,A10B, 01FC,09,A11C, C3F8,F9,A100
$A2:A243             dx 0006, 01F8,F4,A10C, 01F4,F3,A10C, 0000,F4,E10C, 0004,F4,E10B, 01FC,08,A11C, C3F8,F8,A100
$A2:A263             dx 0006, 01FA,F3,A10D, 01F4,F4,A10C, 0000,F4,E10C, 0004,F4,E10B, 01FC,08,A11C, C3F8,F8,A100
$A2:A283             dx 0006, 0000,F3,E10B, 01FA,F4,A10D, 01F4,F4,A10C, 0004,F4,E10B, 01FC,07,A11C, C3F8,F7,A100
$A2:A2A3             dx 0006, 0000,F4,E10B, 0004,F3,E10C, 01FA,F4,A10D, 01F4,F4,A10C, 01FC,07,A11C, C3F8,F7,A100
$A2:A2C3             dx 0006, 0000,F3,E10C, 0004,F4,E10C, 01FA,F4,A10D, 01F4,F4,A10C, 01FC,08,A11C, C3F8,F8,A100
$A2:A2E3             dx 0006, 0000,F4,E10C, 0004,F4,E10C, 01F8,F3,A10C, 01F4,F4,A10C, 01FC,08,A11C, C3F8,F8,A100
$A2:A303             dx 0006, 0000,F4,E10C, 0004,F4,E10C, 01F8,F4,A10C, 01F4,F3,A10B, 01FC,09,A11C, C3F8,F9,A100
$A2:A323             dx 000A, 01FC,0B,A11C, 0000,F4,E10C, 0004,F4,E10B, 01F8,F4,A10C, 01F4,F4,A10B, 0004,F6,A10A, 01FC,F6,A109, 01F4,F6,A108, C3FC,FE,A103, C3F4,FE,A102
$A2:A357             dx 000A, 01FC,0F,A11C, 0000,F4,E10C, 0004,F4,E10B, 01F8,F4,A10C, 01F4,F4,A10B, 0004,F8,A11A, 01FC,F8,A119, 01F4,F8,A118, C3FC,00,A106, C3F4,00,A105
}
}


;;; $A38B..A59D: Maridia spikey shell ;;;
{
;;; $A38B: Palette - enemy $D03F (Maridia spikey shell) ;;;
{
$A2:A38B             dw 3800, 4B9C, 2610, 0CC6, 0C63, 42F7, 2A52, 19AD, 0D29, 5E59, 3D72, 2CEE, 1447, 033B, 0216, 0113
}


;;; $A3AB: Instruction list - Maridia spikey shell - [enemy parameter 1] & 1 = 0 ;;;
{
$A2:A3AB             dw A56D        ; Enemy function index = 0
$A2:A3AD             dw 0008,A589,
                        0008,A590,
                        0008,A597,
                        80ED,A3AD   ; Go to $A3AD
}


;;; $A3BD: Instruction list - Maridia spikey shell - [enemy parameter 1] & 1 = 1 ;;;
{
$A2:A3BD             dw A571        ; Enemy function index = 1
$A2:A3BF             dw 0008,A597,
                        0008,A590,
                        0008,A589,
                        80ED,A3BF   ; Go to $A3BF
}


;;; $A3CF: Maridia spikey shell constants ;;;
{
; Initialisation AI pointers
$A2:A3CF             dw A48A, A49D

; Functions pointers
$A2:A3D3             dw A4B0, A4D9, A502, A517, A53E

; X distance ranges
$A2:A3DD             dw 0010, 0020, 0030, 0040, 0050, 0060, 0070, 0080

; Underground timers
$A2:A3ED             dw 0020, 0040, 0060, 0080, 00A0, 00C0
}


;;; $A3F9: Initialisation AI - enemy $D03F (Maridia spikey shell) ;;;
{
$A2:A3F9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A3FC A9 4D 80    LDA #$804D
$A2:A3FF 9D 8E 0F    STA $0F8E,x[$7E:114E]
$A2:A402 BD B4 0F    LDA $0FB4,x[$7E:1174]
$A2:A405 29 FF 00    AND #$00FF
$A2:A408 9D B0 0F    STA $0FB0,x[$7E:1170]
$A2:A40B 29 01 00    AND #$0001
$A2:A40E 0A          ASL A
$A2:A40F AA          TAX
$A2:A410 FC CF A3    JSR ($A3CF,x)[$A2:A48A]
$A2:A413 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A416 BD B6 0F    LDA $0FB6,x[$7E:1176]
$A2:A419 29 FF 00    AND #$00FF
$A2:A41C 0A          ASL A
$A2:A41D 0A          ASL A
$A2:A41E 0A          ASL A
$A2:A41F A8          TAY
$A2:A420 B9 87 81    LDA $8187,y[$A2:81A7]
$A2:A423 9D AA 0F    STA $0FAA,x[$7E:116A]
$A2:A426 B9 89 81    LDA $8189,y[$A2:81A9]
$A2:A429 9D A8 0F    STA $0FA8,x[$7E:1168]
$A2:A42C B9 8B 81    LDA $818B,y[$A2:81AB]
$A2:A42F 9D AE 0F    STA $0FAE,x[$7E:116E]
$A2:A432 B9 8D 81    LDA $818D,y[$A2:81AD]
$A2:A435 9D AC 0F    STA $0FAC,x[$7E:116C]
$A2:A438 BD B7 0F    LDA $0FB7,x[$7E:1177]
$A2:A43B 29 FF 00    AND #$00FF
$A2:A43E 0A          ASL A
$A2:A43F A8          TAY
$A2:A440 BD 7A 0F    LDA $0F7A,x[$7E:113A]
$A2:A443 18          CLC
$A2:A444 79 DD A3    ADC $A3DD,y[$A2:A3DF]
$A2:A447 9F 04 78 7E STA $7E7804,x[$7E:79C4]
$A2:A44B BD 7A 0F    LDA $0F7A,x[$7E:113A]
$A2:A44E 38          SEC
$A2:A44F F9 DD A3    SBC $A3DD,y[$A2:A3DF]
$A2:A452 9F 02 78 7E STA $7E7802,x[$7E:79C2]
$A2:A456 BD B5 0F    LDA $0FB5,x[$7E:1175]
$A2:A459 29 FF 00    AND #$00FF
$A2:A45C 0A          ASL A
$A2:A45D A8          TAY
$A2:A45E B9 ED A3    LDA $A3ED,y[$A2:A3F3]
$A2:A461 9F 00 78 7E STA $7E7800,x[$7E:79C0]
$A2:A465 9E B2 0F    STZ $0FB2,x[$7E:1172]
$A2:A468 BD B0 0F    LDA $0FB0,x[$7E:1170]
$A2:A46B C9 02 00    CMP #$0002
$A2:A46E D0 0D       BNE $0D    [$A47D]
$A2:A470 A9 10 00    LDA #$0010
$A2:A473 9D B2 0F    STA $0FB2,x
$A2:A476 18          CLC
$A2:A477 7D 7E 0F    ADC $0F7E,x
$A2:A47A 9D 7E 0F    STA $0F7E,x

$A2:A47D 6B          RTL
}


;;; $A47E: Main AI - enemy $D03F (Maridia spikey shell) ;;;
{
$A2:A47E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A481 BD B0 0F    LDA $0FB0,x[$7E:1170]
$A2:A484 0A          ASL A
$A2:A485 AA          TAX
$A2:A486 FC D3 A3    JSR ($A3D3,x)[$A2:A4B0]
$A2:A489 6B          RTL
}


;;; $A48A: Set Maridia spikey shell initial instruction list pointer - [enemy parameter 1] & 1 = 0 ;;;
{
$A2:A48A AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A48D A9 AB A3    LDA #$A3AB
$A2:A490 9D 92 0F    STA $0F92,x[$7E:1152]
$A2:A493 A9 01 00    LDA #$0001
$A2:A496 9D 94 0F    STA $0F94,x[$7E:1154]
$A2:A499 9E 90 0F    STZ $0F90,x[$7E:1150]
$A2:A49C 60          RTS
}


;;; $A49D: Set Maridia spikey shell initial instruction list pointer - [enemy parameter 1] & 1 = 1 ;;;
{
$A2:A49D AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A4A0 A9 BD A3    LDA #$A3BD
$A2:A4A3 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A2:A4A6 A9 01 00    LDA #$0001
$A2:A4A9 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A2:A4AC 9E 90 0F    STZ $0F90,x[$7E:0FD0]
$A2:A4AF 60          RTS
}


;;; $A4B0: Maridia spikey shell function - [enemy function index] = 0 ;;;
{
$A2:A4B0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A4B3 BD 7C 0F    LDA $0F7C,x[$7E:113C]
$A2:A4B6 18          CLC
$A2:A4B7 7D AC 0F    ADC $0FAC,x[$7E:116C]
$A2:A4BA 90 03       BCC $03    [$A4BF]
$A2:A4BC FE 7A 0F    INC $0F7A,x[$7E:113A]

$A2:A4BF 9D 7C 0F    STA $0F7C,x[$7E:113C]
$A2:A4C2 BD 7A 0F    LDA $0F7A,x[$7E:113A]
$A2:A4C5 18          CLC
$A2:A4C6 7D AE 0F    ADC $0FAE,x[$7E:116E]
$A2:A4C9 9D 7A 0F    STA $0F7A,x[$7E:113A]
$A2:A4CC DF 02 78 7E CMP $7E7802,x[$7E:79C2]
$A2:A4D0 10 03       BPL $03    [$A4D5]
$A2:A4D2 DE B0 0F    DEC $0FB0,x[$7E:0FF0]

$A2:A4D5 20 53 A5    JSR $A553  [$A2:A553]
$A2:A4D8 60          RTS
}


;;; $A4D9: Maridia spikey shell function - [enemy function index] = 1 ;;;
{
$A2:A4D9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A4DC BD 7C 0F    LDA $0F7C,x[$7E:0FBC]
$A2:A4DF 18          CLC
$A2:A4E0 7D A8 0F    ADC $0FA8,x[$7E:0FE8]
$A2:A4E3 90 03       BCC $03    [$A4E8]
$A2:A4E5 FE 7A 0F    INC $0F7A,x[$7E:0FBA]

$A2:A4E8 9D 7C 0F    STA $0F7C,x[$7E:0FBC]
$A2:A4EB BD 7A 0F    LDA $0F7A,x[$7E:0FBA]
$A2:A4EE 18          CLC
$A2:A4EF 7D AA 0F    ADC $0FAA,x[$7E:0FEA]
$A2:A4F2 9D 7A 0F    STA $0F7A,x[$7E:0FBA]
$A2:A4F5 DF 04 78 7E CMP $7E7804,x[$7E:7844]
$A2:A4F9 30 03       BMI $03    [$A4FE]
$A2:A4FB 9E B0 0F    STZ $0FB0,x[$7E:0FB0]

$A2:A4FE 20 53 A5    JSR $A553  [$A2:A553]
$A2:A501 60          RTS
}


;;; $A502: Maridia spikey shell function - [enemy function index] = 2 ;;;
{
$A2:A502 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A505 BF 00 78 7E LDA $7E7800,x[$7E:79C0]
$A2:A509 3A          DEC A
$A2:A50A 9F 00 78 7E STA $7E7800,x[$7E:79C0]
$A2:A50E D0 06       BNE $06    [$A516]
$A2:A510 A9 04 00    LDA #$0004
$A2:A513 9D B0 0F    STA $0FB0,x[$7E:0FF0]

$A2:A516 60          RTS
}


;;; $A517: Maridia spikey shell function - [enemy function index] = 3 ;;;
{
$A2:A517 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A51A FE 7E 0F    INC $0F7E,x[$7E:113E]
$A2:A51D FE B2 0F    INC $0FB2,x[$7E:1172]
$A2:A520 BD B2 0F    LDA $0FB2,x[$7E:1172]
$A2:A523 C9 10 00    CMP #$0010
$A2:A526 30 15       BMI $15    [$A53D]
$A2:A528 A9 02 00    LDA #$0002
$A2:A52B 9D B0 0F    STA $0FB0,x[$7E:1170]
$A2:A52E BD B5 0F    LDA $0FB5,x[$7E:1175]
$A2:A531 29 FF 00    AND #$00FF
$A2:A534 0A          ASL A
$A2:A535 A8          TAY
$A2:A536 B9 ED A3    LDA $A3ED,y[$A2:A3F3]
$A2:A539 9F 00 78 7E STA $7E7800,x[$7E:79C0]

$A2:A53D 60          RTS
}


;;; $A53E: Maridia spikey shell function - [enemy function index] = 4 ;;;
{
$A2:A53E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A541 DE 7E 0F    DEC $0F7E,x[$7E:0FBE]
$A2:A544 DE B2 0F    DEC $0FB2,x[$7E:0FF2]
$A2:A547 D0 09       BNE $09    [$A552]
$A2:A549 AD E6 05    LDA $05E6  [$7E:05E6]
$A2:A54C 29 01 00    AND #$0001
$A2:A54F 9D B0 0F    STA $0FB0,x[$7E:0FF0]

$A2:A552 60          RTS
}


;;; $A553:  ;;;
{
$A2:A553 22 11 81 80 JSL $808111[$80:8111]
$A2:A557 AD E5 05    LDA $05E5  [$7E:05E5]
$A2:A55A 18          CLC
$A2:A55B 7D A4 0F    ADC $0FA4,x[$7E:1164]
$A2:A55E 29 FF 00    AND #$00FF
$A2:A561 C9 06 00    CMP #$0006
$A2:A564 10 06       BPL $06    [$A56C]
$A2:A566 A9 03 00    LDA #$0003
$A2:A569 9D B0 0F    STA $0FB0,x[$7E:1170]

$A2:A56C 60          RTS
}


;;; $A56D: Instruction - enemy function index = 0 ;;;
{
$A2:A56D 9E B0 0F    STZ $0FB0,x[$7E:1170]
$A2:A570 6B          RTL
}


;;; $A571: Instruction - enemy function index = 1 ;;;
{
$A2:A571 A9 01 00    LDA #$0001
$A2:A574 9D B0 0F    STA $0FB0,x[$7E:0FF0]
$A2:A577 6B          RTL
}


;;; $A578: RTL ;;;
{
$A2:A578 6B          RTL
}


;;; $A579: Enemy shot - enemy $D03F (Maridia spikey shell) ;;;
{
$A2:A579 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A57C BD B0 0F    LDA $0FB0,x[$7E:0FF0]
$A2:A57F C9 01 00    CMP #$0001
$A2:A582 10 04       BPL $04    [$A588]
$A2:A584 22 2D 80 A2 JSL $A2802D[$A2:802D]

$A2:A588 6B          RTL
}


;;; $A589: Spritemaps - Maridia spikey shell ;;;
{
$A2:A589             dx 0001, C3F8,F8,2100
$A2:A590             dx 0001, C3F8,F8,2102
$A2:A597             dx 0001, C3F8,F8,2104
}
}


;;; $A59E..AFF2: Gunship ;;;
{
;;; $A59E: Palette - enemy $D07F/$D0BF (gunship) ;;;
{
$A2:A59E             dw 3800, 0295, 0190, 0403, 0001, 0211, 014D, 00C9, 0024, 3BE0, 2680, 1580, 24C6, 1442, 0000, 0000
}


;;; $A5BE: Instruction list - gunship entrance pad - opening ;;;
{
$A2:A5BE             dx 0028,AFDD,
                        0008,AFC7,
                        0008,AE89,
                        0008,AE9F,
                        0018,AEB5,
                        0008,AECB,
                        0007,AEF5,
                        0006,AF1F,
                        0005,AF49,
                        0004,AF73
$A2:A5E6             dx 0004,AF9D,
                        80ED,A5E6   ; Go to $A5E6
}


;;; $A5EE: Instruction list - gunship entrance pad - closing ;;;
{
$A2:A5EE             dx 0004,AF73,
                        0005,AF49,
                        0006,AF1F,
                        0007,AEF5,
                        0008,AECB,
                        0018,AEB5,
                        0008,AE9F,
                        0008,AFC7
}


;;; $A60E: Instruction list - gunship entrance pad - closed ;;;
{
$A2:A60E             dx 0008,AFDD,
                        80ED,A60E   ; Go to $A60E
}


;;; $A616: Instruction list - gunship top ;;;
{
$A2:A616             dx 0001,AD81,
                        812F        ; Sleep
}


;;; $A61C: Instruction list - gunship bottom ;;;
{
$A2:A61C             dx 0001,ADDD,
                        812F        ; Sleep
}


;;; $A622: Gunship brakes movement data ;;;
{
; Y velocities, indexed by enemy $0FB0 in $A8D0
$A2:A622             dw 0001, 0001, 0001, 0001, 0001, 0001,
                        0000, 0000, 0000, 0000, 0000,
                        FFFF, FFFF, FFFF, FFFF, FFFF, FFFF
}


;;; $A644: Initialisation AI - enemy $D07F (gunship top) ;;;
{
$A2:A644 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A647 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A2:A64A 09 00 24    ORA #$2400             ;} Set enemy as intangible and to process instructions
$A2:A64D 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A2:A650 A9 01 00    LDA #$0001             ;\
$A2:A653 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A2:A656 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A2:A659 A9 16 A6    LDA #$A616             ;\
$A2:A65C 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $A616
$A2:A65F A9 00 0E    LDA #$0E00             ;\
$A2:A662 9D 96 0F    STA $0F96,x[$7E:0F96]  ;} Enemy palette index = E00h (palette 7)
$A2:A665 AD 98 09    LDA $0998  [$7E:0998]  ;\
$A2:A668 C9 28 00    CMP #$0028             ;} If [game state] = 28h (transition to demo): go to BRANCH_DEMO_TRANSITION
$A2:A66B F0 30       BEQ $30    [$A69D]     ;/

; BRANCH_LANDING_ON_ZEBES
$A2:A66D AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$A2:A671 C9 22 00    CMP #$0022             ;} If landing on Zebes:
$A2:A674 D0 12       BNE $12    [$A688]     ;/
$A2:A676 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:A679 38          SEC                    ;|
$A2:A67A E9 11 00    SBC #$0011             ;} Enemy Y position = [Samus Y position] - 11h
$A2:A67D 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:A680 A9 0C A8    LDA #$A80C             ;\
$A2:A683 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $A80C
$A2:A686 80 39       BRA $39    [$A6C1]     ; Go to BRANCH_MERGE

$A2:A688 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:A68B 38          SEC                    ;|
$A2:A68C E9 19 00    SBC #$0019             ;} Enemy Y position -= 19h
$A2:A68F 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:A692 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ; Enemy fixed Y position = [enemy Y position]
$A2:A695 A9 BD A9    LDA #$A9BD             ;\
$A2:A698 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $A9BD
$A2:A69B 80 24       BRA $24    [$A6C1]     ; Go to BRANCH_MERGE

; BRANCH_DEMO_TRANSITION
$A2:A69D AD 55 1F    LDA $1F55  [$7E:1F55]  ;\
$A2:A6A0 D0 CB       BNE $CB    [$A66D]     ;} If [demo set] != 0: go to BRANCH_LANDING_ON_ZEBES
$A2:A6A2 A9 72 04    LDA #$0472             ;\
$A2:A6A5 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;} Samus Y position = 472h
$A2:A6A8 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:A6AB 38          SEC                    ;|
$A2:A6AC E9 19 00    SBC #$0019             ;} Enemy Y position -= 19h
$A2:A6AF 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:A6B2 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ; Enemy fixed Y position = [enemy Y position]
$A2:A6B5 A9 60 AB    LDA #$AB60             ;\
$A2:A6B8 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AB60
$A2:A6BB A9 90 00    LDA #$0090             ;\
$A2:A6BE 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Enemy function timer = 90h

; BRANCH_MERGE
$A2:A6C1 A0 C0 E1    LDY #$E1C0             ;\
$A2:A6C4 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn gunship glow palette FX object
$A2:A6C8 A9 01 00    LDA #$0001             ;\
$A2:A6CB 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy hover timer = 1
$A2:A6CE 9C AC 0F    STZ $0FAC  [$7E:0FAC]  ; Enemy 0 hover index = 0
$A2:A6D1 6B          RTL
}


;;; $A6D2: Initialisation AI - enemy $D0BF (gunship bottom / entrance pad) ;;;
{
; Enemy parameter 2 = 0: gunship bottom
; Enemy parameter 2 != 0: gunship entrance pad
$A2:A6D2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A6D5 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A2:A6D8 09 00 24    ORA #$2400             ;} Set enemy as intangible and to process instructions
$A2:A6DB 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A2:A6DE A9 01 00    LDA #$0001             ;\
$A2:A6E1 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A2:A6E4 9E 90 0F    STZ $0F90,x[$7E:0FD0]  ; Enemy timer = 0
$A2:A6E7 BD B6 0F    LDA $0FB6,x[$7E:0FF6]  ;\
$A2:A6EA F0 08       BEQ $08    [$A6F4]     ;} If [enemy parameter 2] != 0:
$A2:A6EC A9 0E A6    LDA #$A60E             ;\
$A2:A6EF 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = $A60E
$A2:A6F2 80 06       BRA $06    [$A6FA]

$A2:A6F4 A9 1C A6    LDA #$A61C             ;\ Else ([enemy parameter 2] = 0):
$A2:A6F7 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $A61C

$A2:A6FA BD 58 0F    LDA $0F58,x[$7E:0F98]  ;\
$A2:A6FD 9D 98 0F    STA $0F98,x[$7E:0FD8]  ;} Enemy VRAM tiles index = [enemy ([X] - 1) VRAM tiles index]
$A2:A700 A9 00 0E    LDA #$0E00             ;\
$A2:A703 9D 96 0F    STA $0F96,x[$7E:0FD6]  ;} Enemy palette index = E00h (palette 7)
$A2:A706 BD B6 0F    LDA $0FB6,x[$7E:0FF6]  ;\
$A2:A709 D0 27       BNE $27    [$A732]     ;} If [enemy parameter 2] != 0: go to BRANCH_ENTRANCE_PAD
$A2:A70B AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$A2:A70F C9 22 00    CMP #$0022             ;} If landing on Zebes:
$A2:A712 D0 0C       BNE $0C    [$A720]     ;/
$A2:A714 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:A717 18          CLC                    ;|
$A2:A718 69 17 00    ADC #$0017             ;} Enemy Y position = [Samus Y position] + 17h
$A2:A71B 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A2:A71E 80 32       BRA $32    [$A752]     ; Go to BRANCH_MERGE

$A2:A720 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A2:A723 18          CLC                    ;|
$A2:A724 69 0F 00    ADC #$000F             ;} Enemy Y position += Fh
$A2:A727 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A2:A72A A9 47 00    LDA #$0047             ;\
$A2:A72D 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;} Enemy hover sound effect timer = 47h
$A2:A730 80 20       BRA $20    [$A752]     ; Go to BRANCH_MERGE

; BRANCH_ENTRANCE_PAD
$A2:A732 BD FE 0E    LDA $0EFE,x[$7E:0F7E]  ;\
$A2:A735 3A          DEC A                  ;} Enemy Y position = [enemy ([X] - 2) Y position] - 1
$A2:A736 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A2:A739 AD 98 09    LDA $0998  [$7E:0998]  ;\
$A2:A73C C9 28 00    CMP #$0028             ;} If [game state] = 28h (transition to demo):
$A2:A73F D0 11       BNE $11    [$A752]     ;/
$A2:A741 AD 55 1F    LDA $1F55  [$7E:1F55]  ;\
$A2:A744 D0 0C       BNE $0C    [$A752]     ;} If [demo set] = 0:
$A2:A746 A9 01 00    LDA #$0001             ;\
$A2:A749 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$A2:A74C A9 BE A5    LDA #$A5BE             ;\
$A2:A74F 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = $A5BE

; BRANCH_MERGE
$A2:A752 A9 D7 A7    LDA #$A7D7             ;\
$A2:A755 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy $0FB2 = $A7D7 (RTL)
$A2:A758 6B          RTL
}


;;; $A759: Main AI - enemy $D07F (gunship top) ;;;
{
$A2:A759 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:A75C DE EE 0F    DEC $0FEE,x[$7E:0FEE]  ;\
$A2:A75F F0 02       BEQ $02    [$A763]     ;} If [enemy ([X] + 1) hover sound effect timer] > 0: go to BRANCH_NO_SOUND
$A2:A761 10 0D       BPL $0D    [$A770]     ;/

$A2:A763 A9 4D 00    LDA #$004D             ;\
$A2:A766 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 4Dh, sound library 2, max queued sounds allowed = 6 (gunship hover)
$A2:A76A A9 46 00    LDA #$0046             ;\
$A2:A76D 9D EE 0F    STA $0FEE,x[$7E:0FEE]  ;} Enemy ([X] + 1) hover sound effect timer = 46h

; BRANCH_NO_SOUND
$A2:A770 BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$A2:A773 C9 42 A9    CMP #$A942             ;|
$A2:A776 30 08       BMI $08    [$A780]     ;} If $A942 <= [enemy function] < $AC1B:
$A2:A778 C9 1B AC    CMP #$AC1B             ;|
$A2:A77B 10 03       BPL $03    [$A780]     ;/
$A2:A77D 20 84 A7    JSR $A784  [$A2:A784]  ; Process gunship hover

$A2:A780 7C B2 0F    JMP ($0FB2,x)[$A2:A80C]; Go to [enemy function]
}


;;; $A783: RTL ;;;
{
$A2:A783 6B          RTL
}


;;; $A784: Process gunship hover ;;;
{
$A2:A784 DE AE 0F    DEC $0FAE,x[$7E:0FAE]  ; Decrement enemy hover timer
$A2:A787 F0 02       BEQ $02    [$A78B]     ;\
$A2:A789 10 43       BPL $43    [$A7CE]     ;} If [enemy enemy hover timer] > 0: return

$A2:A78B BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A2:A78E 0A          ASL A                  ;} Y = [enemy hover index] * 2
$A2:A78F A8          TAY                    ;/
$A2:A790 B9 CF A7    LDA $A7CF,y[$A2:A7CF]  ;\
$A2:A793 29 FF 00    AND #$00FF             ;} Enemy enemy hover timer = [$A7CF + [Y]]
$A2:A796 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;/
$A2:A799 B9 D0 A7    LDA $A7D0,y[$A2:A7D0]  ;\
$A2:A79C 29 FF 00    AND #$00FF             ;|
$A2:A79F 89 80 00    BIT #$0080             ;|
$A2:A7A2 F0 03       BEQ $03    [$A7A7]     ;} $12 = ±[$A7CF + [Y] + 1]
$A2:A7A4 09 00 FF    ORA #$FF00             ;|
                                            ;|
$A2:A7A7 85 12       STA $12    [$7E:0012]  ;/
$A2:A7A9 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:A7AC 18          CLC                    ;|
$A2:A7AD 65 12       ADC $12    [$7E:0012]  ;} Enemy Y position += [$12]
$A2:A7AF 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:A7B2 BD BE 0F    LDA $0FBE,x[$7E:0FBE]  ;\
$A2:A7B5 18          CLC                    ;|
$A2:A7B6 65 12       ADC $12    [$7E:0012]  ;} Enemy ([X] + 1) Y position += [$12]
$A2:A7B8 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;/
$A2:A7BB BD FE 0F    LDA $0FFE,x[$7E:0FFE]  ;\
$A2:A7BE 18          CLC                    ;|
$A2:A7BF 65 12       ADC $12    [$7E:0012]  ;} Enemy ([X] + 2) Y position += [$12]
$A2:A7C1 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;/
$A2:A7C4 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A2:A7C7 1A          INC A                  ;|
$A2:A7C8 29 03 00    AND #$0003             ;} Enemy hover index = ([enemy hover index] + 1) % 4
$A2:A7CB 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;/

$A2:A7CE 60          RTS

;                        _____ Timer
;                       |   __ Y velocity
;                       |  |
$A2:A7CF             db 10,01,
                        10,FF,
                        10,FF,
                        10,01
}


;;; $A7D7: RTL ;;;
{
$A2:A7D7 6B          RTL
}


;;; $A7D8: Unused. Gunship function - rise to Y position 80h and the descend ;;;
{
; Probably a little debug function for testing the landing sequence
$A2:A7D8 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:A7DB 38          SEC                    ;|
$A2:A7DC E9 08 00    SBC #$0008             ;} Samus Y position -= 8
$A2:A7DF 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:A7E2 BD FE 0F    LDA $0FFE,x            ;\
$A2:A7E5 38          SEC                    ;|
$A2:A7E6 E9 08 00    SBC #$0008             ;} Enemy ([X] + 2) Y position -= 8
$A2:A7E9 9D FE 0F    STA $0FFE,x            ;/
$A2:A7EC BD BE 0F    LDA $0FBE,x            ;\
$A2:A7EF 38          SEC                    ;|
$A2:A7F0 E9 08 00    SBC #$0008             ;} Enemy ([X] + 1) Y position -= 8
$A2:A7F3 9D BE 0F    STA $0FBE,x            ;/
$A2:A7F6 BD 7E 0F    LDA $0F7E,x            ;\
$A2:A7F9 38          SEC                    ;|
$A2:A7FA E9 08 00    SBC #$0008             ;} Enemy Y position -= 8
$A2:A7FD 9D 7E 0F    STA $0F7E,x            ;/
$A2:A800 C9 80 00    CMP #$0080             ;\
$A2:A803 10 06       BPL $06    [$A80B]     ;} If [enemy Y position] >= 80h: return
$A2:A805 A9 0C A8    LDA #$A80C             ;\
$A2:A808 9D B2 0F    STA $0FB2,x            ;} Enemy function = $A80C

$A2:A80B 6B          RTL
}


;;; $A80C: Gunship function - landing on Zebes - descending ;;;
{
$A2:A80C BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:A80F C9 00 03    CMP #$0300             ;} If [enemy Y position] < 300h:
$A2:A812 10 4D       BPL $4D    [$A861]     ;/
$A2:A814 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$A2:A817 18          CLC                    ;|
$A2:A818 69 00 80    ADC #$8000             ;|
$A2:A81B 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus Y position += 4.8000h
$A2:A81E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A2:A821 69 04 00    ADC #$0004             ;|
$A2:A824 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:A827 BD 00 10    LDA $1000,x[$7E:1000]  ;\
$A2:A82A 18          CLC                    ;|
$A2:A82B 69 00 80    ADC #$8000             ;|
$A2:A82E 9D 00 10    STA $1000,x[$7E:1000]  ;} Enemy ([[X] + 2) Y position += 4.8000h
$A2:A831 BD FE 0F    LDA $0FFE,x[$7E:0FFE]  ;|
$A2:A834 69 04 00    ADC #$0004             ;|
$A2:A837 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;/
$A2:A83A BD C0 0F    LDA $0FC0,x[$7E:0FC0]  ;\
$A2:A83D 18          CLC                    ;|
$A2:A83E 69 00 80    ADC #$8000             ;|
$A2:A841 9D C0 0F    STA $0FC0,x[$7E:0FC0]  ;} Enemy ([[X] + 1) Y position += 4.8000h
$A2:A844 BD BE 0F    LDA $0FBE,x[$7E:0FBE]  ;|
$A2:A847 69 04 00    ADC #$0004             ;|
$A2:A84A 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;/
$A2:A84D BD 80 0F    LDA $0F80,x[$7E:0F80]  ;\
$A2:A850 18          CLC                    ;|
$A2:A851 69 00 80    ADC #$8000             ;|
$A2:A854 9D 80 0F    STA $0F80,x[$7E:0F80]  ;} Enemy Y position += 4.8000h
$A2:A857 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A2:A85A 69 04 00    ADC #$0004             ;|
$A2:A85D 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:A860 6B          RTL

$A2:A861 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$A2:A864 18          CLC                    ;|
$A2:A865 69 00 80    ADC #$8000             ;|
$A2:A868 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus Y position += 2.8000h
$A2:A86B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A2:A86E 69 02 00    ADC #$0002             ;|
$A2:A871 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:A874 BD 00 10    LDA $1000,x[$7E:1000]  ;\
$A2:A877 18          CLC                    ;|
$A2:A878 69 00 80    ADC #$8000             ;|
$A2:A87B 9D 00 10    STA $1000,x[$7E:1000]  ;} Enemy ([[X] + 2) Y position += 2.8000h
$A2:A87E BD FE 0F    LDA $0FFE,x[$7E:0FFE]  ;|
$A2:A881 69 02 00    ADC #$0002             ;|
$A2:A884 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;/
$A2:A887 BD C0 0F    LDA $0FC0,x[$7E:0FC0]  ;\
$A2:A88A 18          CLC                    ;|
$A2:A88B 69 00 80    ADC #$8000             ;|
$A2:A88E 9D C0 0F    STA $0FC0,x[$7E:0FC0]  ;} Enemy ([[X] + 1) Y position += 2.8000h
$A2:A891 BD BE 0F    LDA $0FBE,x[$7E:0FBE]  ;|
$A2:A894 69 02 00    ADC #$0002             ;|
$A2:A897 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;/
$A2:A89A BD 80 0F    LDA $0F80,x[$7E:0F80]  ;\
$A2:A89D 18          CLC                    ;|
$A2:A89E 69 00 80    ADC #$8000             ;|
$A2:A8A1 9D 80 0F    STA $0F80,x[$7E:0F80]  ;} Enemy Y position += 2.8000h
$A2:A8A4 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A2:A8A7 69 02 00    ADC #$0002             ;|
$A2:A8AA 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:A8AD C9 5F 04    CMP #$045F             ;\
$A2:A8B0 30 1D       BMI $1D    [$A8CF]     ;} If [enemy Y position] >= 45Fh:
$A2:A8B2 A9 5F 04    LDA #$045F             ;\
$A2:A8B5 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy Y position = 45Fh
$A2:A8B8 18          CLC                    ;\
$A2:A8B9 69 28 00    ADC #$0028             ;} Enemy ([X] + 1) Y position = 45Fh + 28h
$A2:A8BC 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;/
$A2:A8BF BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:A8C2 3A          DEC A                  ;} Enemy ([X] + 2) Y position = 45Fh - 1
$A2:A8C3 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;/
$A2:A8C6 A9 D0 A8    LDA #$A8D0             ;\
$A2:A8C9 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $A8D0
$A2:A8CC 9E B0 0F    STZ $0FB0,x[$7E:0FB0]  ; Enemy brakes timer = 0

$A2:A8CF 6B          RTL
}


;;; $A8D0: Gunship function - landing on Zebes - apply brakes ;;;
{
; The increment at $A921 is kinda random,
; causes a slight visual discrepancy when entering the ship immediately after landing
$A2:A8D0 BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A2:A8D3 0A          ASL A                  ;} Y = [enemy brakes timer] * 2
$A2:A8D4 A8          TAY                    ;/
$A2:A8D5 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:A8D8 18          CLC                    ;|
$A2:A8D9 79 22 A6    ADC $A622,y[$A2:A622]  ;} Samus Y position += [$A622 + [Y]]
$A2:A8DC 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:A8DF BD FE 0F    LDA $0FFE,x[$7E:0FFE]  ;\
$A2:A8E2 18          CLC                    ;|
$A2:A8E3 79 22 A6    ADC $A622,y[$A2:A622]  ;} Enemy ([X] + 2) Y position += [$A622 + [Y]]
$A2:A8E6 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;/
$A2:A8E9 BD BE 0F    LDA $0FBE,x[$7E:0FBE]  ;\
$A2:A8EC 18          CLC                    ;|
$A2:A8ED 79 22 A6    ADC $A622,y[$A2:A622]  ;} Enemy ([X] + 1) Y position += [$A622 + [Y]]
$A2:A8F0 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;/
$A2:A8F3 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:A8F6 18          CLC                    ;|
$A2:A8F7 79 22 A6    ADC $A622,y[$A2:A622]  ;} Enemy Y position += [$A622 + [Y]]
$A2:A8FA 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:A8FD BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A2:A900 1A          INC A                  ;} Increment brakes timer
$A2:A901 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;/
$A2:A904 C9 11 00    CMP #$0011             ;\
$A2:A907 30 38       BMI $38    [$A941]     ;} If [enemy brakes timer] >= 11h: return
$A2:A909 A9 42 A9    LDA #$A942             ;\
$A2:A90C 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $A942
$A2:A90F BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:A912 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy fixed Y position = [enemy Y position]
$A2:A915 A9 01 00    LDA #$0001             ;\
$A2:A918 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy hover timer = 1
$A2:A91B 9C AC 0F    STZ $0FAC  [$7E:0FAC]  ; Enemy 0 hover index = 0
$A2:A91E BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A2:A921 1A          INC A                  ;} Samus X position = [enemy X position] + 1
$A2:A922 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$A2:A925 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$A2:A928 A9 01 00    LDA #$0001             ;\
$A2:A92B 9D 14 10    STA $1014,x[$7E:1014]  ;} Enemy ([X] + 2) instruction timer = 1
$A2:A92E A9 BE A5    LDA #$A5BE             ;\
$A2:A931 9D 12 10    STA $1012,x[$7E:1012]  ;} Enemy ([X] + 2) instruction list pointer = $A5BE
$A2:A934 A9 90 00    LDA #$0090             ;\
$A2:A937 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Enemy 0 function timer = 90h
$A2:A93A A9 14 00    LDA #$0014             ;\
$A2:A93D 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 14h, sound library 3, max queued sounds allowed = 6 (gunship elevator activated)

$A2:A941 6B          RTL
}


;;; $A942: Gunship function - landing on Zebes - wait for gunship entrance to open ;;;
{
$A2:A942 CE A8 0F    DEC $0FA8  [$7E:0FA8]  ; Decrement enemy 0 function timer
$A2:A945 F0 02       BEQ $02    [$A949]     ;\
$A2:A947 10 06       BPL $06    [$A94F]     ;} If [enemy 0 function timer] > 0: return

$A2:A949 A9 50 A9    LDA #$A950             ;\
$A2:A94C 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $A950

$A2:A94F 6B          RTL
}


;;; $A950: Gunship function - landing on Zebes - eject Samus ;;;
{
$A2:A950 BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A2:A953 38          SEC                    ;|
$A2:A954 E9 1E 00    SBC #$001E             ;} $12 = [enemy fixed Y position] - 1Eh
$A2:A957 85 12       STA $12    [$7E:0012]  ;/
$A2:A959 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:A95C 38          SEC                    ;|
$A2:A95D E9 01 00    SBC #$0001             ;} Decrement Samus Y position
$A2:A960 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:A963 C5 12       CMP $12    [$7E:0012]  ;\
$A2:A965 10 1F       BPL $1F    [$A986]     ;} If [Samus Y position] >= [$12]: return
$A2:A967 A9 87 A9    LDA #$A987             ;\
$A2:A96A 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $A987
$A2:A96D A9 01 00    LDA #$0001             ;\
$A2:A970 9D 14 10    STA $1014,x[$7E:1014]  ;} Enemy ([X] + 2) instruction timer = 1
$A2:A973 A9 EE A5    LDA #$A5EE             ;\
$A2:A976 9D 12 10    STA $1012,x[$7E:1012]  ;} Enemy ([X] + 2) instruction list pointer = $A5EE
$A2:A979 A9 90 00    LDA #$0090             ;\
$A2:A97C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Enemy 0 function timer = 90h
$A2:A97F A9 15 00    LDA #$0015             ;\
$A2:A982 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 15h, sound library 3, max queued sounds allowed = 6 (gunship elevator deactivated)

$A2:A986 6B          RTL
}


;;; $A987: Gunship function - landing on Zebes - wait for gunship entrance to close, then unlock Samus and save ;;;
{
$A2:A987 CE A8 0F    DEC $0FA8  [$7E:0FA8]  ; Decrement enemy 0 function timer
$A2:A98A F0 02       BEQ $02    [$A98E]     ;\
$A2:A98C 10 2E       BPL $2E    [$A9BC]     ;} If [enemy 0 function timer] > 0: return

$A2:A98E A9 BD A9    LDA #$A9BD             ;\
$A2:A991 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $A9BD
$A2:A994 A9 95 E6    LDA #$E695             ;\
$A2:A997 8D 42 0A    STA $0A42  [$7E:0A42]  ;} $0A42 = $E695 (normal)
$A2:A99A A9 25 E7    LDA #$E725             ;\
$A2:A99D 8D 44 0A    STA $0A44  [$7E:0A44]  ;} $0A44 = $E725 (normal)
$A2:A9A0 A9 05 00    LDA #$0005             ;\
$A2:A9A3 8F 14 D9 7E STA $7ED914[$7E:D914]  ;} Loading game state = main (prevents landing sequence from happening again)
$A2:A9A7 AF F8 D8 7E LDA $7ED8F8[$7E:D8F8]  ;\
$A2:A9AB 09 01 00    ORA #$0001             ;} Set Crateria save station 0
$A2:A9AE 8F F8 D8 7E STA $7ED8F8[$7E:D8F8]  ;/
$A2:A9B2 9C 8B 07    STZ $078B  [$7E:078B]  ; Load station index = 0
$A2:A9B5 AD 52 09    LDA $0952  [$7E:0952]  ;\
$A2:A9B8 22 00 80 81 JSL $818000[$81:8000]  ;} Save current save slot to SRAM

$A2:A9BC 6B          RTL
}


;;; $A9BD: Gunship function - handle letting Samus enter ;;;
{
$A2:A9BD AD 98 09    LDA $0998  [$7E:0998]  ;\
$A2:A9C0 C9 08 00    CMP #$0008             ;} If [game state] != main gameplay: return
$A2:A9C3 D0 43       BNE $43    [$AA08]     ;/
$A2:A9C5 AD 42 0A    LDA $0A42  [$7E:0A42]  ;\
$A2:A9C8 C9 95 E6    CMP #$E695             ;} If [$0A42] != $E695 (normal): return
$A2:A9CB D0 3B       BNE $3B    [$AA08]     ;/
$A2:A9CD BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A2:A9D0 38          SEC                    ;|
$A2:A9D1 E9 08 00    SBC #$0008             ;|
$A2:A9D4 CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;|
$A2:A9D7 10 2F       BPL $2F    [$AA08]     ;|
$A2:A9D9 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;} If not [enemy X position] - 8 < [Samus X position] <= [enemy X position] + 8: return
$A2:A9DC 18          CLC                    ;|
$A2:A9DD 69 08 00    ADC #$0008             ;|
$A2:A9E0 CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;|
$A2:A9E3 30 23       BMI $23    [$AA08]     ;/
$A2:A9E5 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:A9E8 38          SEC                    ;|
$A2:A9E9 E9 40 00    SBC #$0040             ;|
$A2:A9EC CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;|
$A2:A9EF 10 17       BPL $17    [$AA08]     ;} If not [enemy Y position] - 40h < [Samus Y position] <= [enemy Y position]: return
$A2:A9F1 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A2:A9F4 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;|
$A2:A9F7 30 0F       BMI $0F    [$AA08]     ;/
$A2:A9F9 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$A2:A9FC 29 FF 00    AND #$00FF             ;} If [Samus movement type] != standing: return
$A2:A9FF D0 07       BNE $07    [$AA08]     ;/
$A2:AA01 A5 8F       LDA $8F    [$7E:008F]  ;\
$A2:AA03 89 00 04    BIT #$0400             ;} If newly pressed down: go to BRANCH_ENTER_GUNSHIP
$A2:AA06 D0 01       BNE $01    [$AA09]     ;/

$A2:AA08 6B          RTL

; BRANCH_ENTER_GUNSHIP
$A2:AA09 A9 4F AA    LDA #$AA4F             ;\
$A2:AA0C 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AA4F
$A2:AA0F AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A2:AA12 C9 80 04    CMP #$0480             ;} If [Samus X position] != 480h: (random check)
$A2:AA15 F0 09       BEQ $09    [$AA20]     ;/
$A2:AA17 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A2:AA1A 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;} Samus X position = [enemy X position]
$A2:AA1D 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]

$A2:AA20 22 F6 E3 91 JSL $91E3F6[$91:E3F6]  ; Make Samus face forward
$A2:AA24 A9 1A 00    LDA #$001A             ; A = 1Ah
$A2:AA27 22 84 F0 90 JSL $90F084[$90:F084]  ; Execute $90:F084
$A2:AA2B 9C 18 0E    STZ $0E18  [$7E:0E18]  ; Elevator status = inactive
$A2:AA2E BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:AA31 3A          DEC A                  ;} Enemy ([X] + 2) Y position = [enemy Y position]
$A2:AA32 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;/
$A2:AA35 A9 01 00    LDA #$0001             ;\
$A2:AA38 9D 14 10    STA $1014,x[$7E:1014]  ;} Enemy ([X] + 2) instruction timer = 1
$A2:AA3B A9 BE A5    LDA #$A5BE             ;\
$A2:AA3E 9D 12 10    STA $1012,x[$7E:1012]  ;} Enemy ([X] + 2) instruction list pointer = $A5BE
$A2:AA41 A9 90 00    LDA #$0090             ;\
$A2:AA44 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Enemy 0 function timer = 90h
$A2:AA47 A9 14 00    LDA #$0014             ;\
$A2:AA4A 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 14h, sound library 3, max queued sounds allowed = 6 (gunship elevator activated)
$A2:AA4E 6B          RTL
}


;;; $AA4F: Gunship function - wait for entrance pad to open ;;;
{
$A2:AA4F CE A8 0F    DEC $0FA8  [$7E:0FA8]  ; Decrement enemy 0 function timer
$A2:AA52 F0 02       BEQ $02    [$AA56]     ;\
$A2:AA54 10 06       BPL $06    [$AA5C]     ;} If [enemy 0 function timer] > 0: return

$A2:AA56 A9 5D AA    LDA #$AA5D             ;\
$A2:AA59 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AA5D

$A2:AA5C 6B          RTL
}


;;; $AA5D: Gunship function - lower Samus ;;;
{
$A2:AA5D BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A2:AA60 18          CLC                    ;|
$A2:AA61 69 12 00    ADC #$0012             ;} $12 = [enemy fixed Y position] + 12h
$A2:AA64 85 12       STA $12    [$7E:0012]  ;/
$A2:AA66 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AA69 18          CLC                    ;|
$A2:AA6A 69 02 00    ADC #$0002             ;} Samus Y position += 2
$A2:AA6D 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:AA70 C5 12       CMP $12    [$7E:0012]  ;\
$A2:AA72 30 1F       BMI $1F    [$AA93]     ;} If [Samus Y position] < [$12]: return
$A2:AA74 A9 94 AA    LDA #$AA94             ;\
$A2:AA77 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AA94
$A2:AA7A A9 01 00    LDA #$0001             ;\
$A2:AA7D 9D 14 10    STA $1014,x[$7E:1014]  ;} Enemy ([X] + 2) instruction timer = 1
$A2:AA80 A9 EE A5    LDA #$A5EE             ;\
$A2:AA83 9D 12 10    STA $1012,x[$7E:1012]  ;} Enemy ([X] + 2) instruction list pointer = $A5EE
$A2:AA86 A9 90 00    LDA #$0090             ;\
$A2:AA89 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Enemy 0 function timer = 90h
$A2:AA8C A9 15 00    LDA #$0015             ;\
$A2:AA8F 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 15h, sound library 3, max queued sounds allowed = 6 (gunship elevator deactivated)

$A2:AA93 6B          RTL
}


;;; $AA94: Gunship function - wait for entrance pad to close ;;;
{
$A2:AA94 CE A8 0F    DEC $0FA8  [$7E:0FA8]  ; Decrement enemy 0 function timer
$A2:AA97 F0 02       BEQ $02    [$AA9B]     ;\
$A2:AA99 10 06       BPL $06    [$AAA1]     ;} If [enemy 0 function timer] > 0: return

$A2:AA9B A9 A2 AA    LDA #$AAA2             ;\
$A2:AA9E 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AAA2

$A2:AAA1 6B          RTL
}


;;; $AAA2: Gunship function - go to liftoff or restore Samus health / ammo ;;;
{
; The unconditional branch at $AAEF was most likely added to disable the liftoff debug feature
$A2:AAA2 A9 0E 00    LDA #$000E             ;\
$A2:AAA5 22 33 82 80 JSL $808233[$80:8233]  ;} If Zebes timebomb not set:
$A2:AAA9 B0 4D       BCS $4D    [$AAF8]     ;/
$A2:AAAB A9 02 00    LDA #$0002             ;\
$A2:AAAE 22 12 DF 91 JSL $91DF12[$91:DF12]  ;} Restore 2 health to Samus
$A2:AAB2 A9 02 00    LDA #$0002             ;\
$A2:AAB5 22 80 DF 91 JSL $91DF80[$91:DF80]  ;} Restore 2 missiles to Samus
$A2:AAB9 A9 02 00    LDA #$0002             ;\
$A2:AABC 22 D3 DF 91 JSL $91DFD3[$91:DFD3]  ;} Restore 2 super missiles to Samus
$A2:AAC0 A9 02 00    LDA #$0002             ;\
$A2:AAC3 22 F0 DF 91 JSL $91DFF0[$91:DFF0]  ;} Restore 2 power bombs to Samus
$A2:AAC7 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$A2:AACA CD D4 09    CMP $09D4  [$7E:09D4]  ;} If [Samus reserve health] < [Samus max reserve health]: return
$A2:AACD 30 4F       BMI $4F    [$AB1E]     ;/
$A2:AACF AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$A2:AAD2 CD C4 09    CMP $09C4  [$7E:09C4]  ;} If [Samus health] < [Samus max health]: return
$A2:AAD5 30 47       BMI $47    [$AB1E]     ;/
$A2:AAD7 AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$A2:AADA CD C8 09    CMP $09C8  [$7E:09C8]  ;} If [Samus missiles] < [Samus max missiles]: return
$A2:AADD 30 3F       BMI $3F    [$AB1E]     ;/
$A2:AADF AD CA 09    LDA $09CA  [$7E:09CA]  ;\
$A2:AAE2 CD CC 09    CMP $09CC  [$7E:09CC]  ;} If [Samus super missiles] < [Samus max super missiles]: return
$A2:AAE5 30 37       BMI $37    [$AB1E]     ;/
$A2:AAE7 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$A2:AAEA CD D0 09    CMP $09D0  [$7E:09D0]  ;} If [Samus power bombs] < [Samus max power bombs]: return
$A2:AAED 30 2F       BMI $2F    [$AB1E]     ;/
$A2:AAEF 80 27       BRA $27    [$AB18]     ; Go to BRANCH_CONTINUE
$A2:AAF1 A5 8D       LDA $8D    [$7E:008D]  ;\
$A2:AAF3 89 00 80    BIT #$8000             ;} If controller 2 not pressing B: go to BRANCH_CONTINUE
$A2:AAF6 F0 20       BEQ $20    [$AB18]     ;/

$A2:AAF8 A9 C7 AB    LDA #$ABC7             ;\
$A2:AAFB 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $ABC7
$A2:AAFE 9E F2 0F    STZ $0FF2,x[$7E:0FF2]  ; Enemy ([X] + 1) $0FB2 = 0
$A2:AB01 9E F0 0F    STZ $0FF0,x[$7E:0FF0]  ; Enemy ([X] + 1) $0FB0 = 0
$A2:AB04 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; $0DEC = 0
$A2:AB07 9C EE 0D    STZ $0DEE  [$7E:0DEE]  ; $0DEE = 0
$A2:AB0A 9C F0 0D    STZ $0DF0  [$7E:0DF0]  ; $0DF0 = 0
$A2:AB0D 9C F2 0D    STZ $0DF2  [$7E:0DF2]  ; $0DF2 = 0
$A2:AB10 A9 0A 00    LDA #$000A             ; A = Ah
$A2:AB13 22 84 F0 90 JSL $90F084[$90:F084]  ; Execute $90:F084 (stop drawing Samus)
$A2:AB17 6B          RTL

; BRANCH_CONTINUE
$A2:AB18 A9 1F AB    LDA #$AB1F             ;\
$A2:AB1B 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AB1F

$A2:AB1E 6B          RTL
}


;;; $AB1F: Gunship function - handle save confirmation ;;;
{
$A2:AB1F A9 1C 00    LDA #$001C             ;\
$A2:AB22 22 80 80 85 JSL $858080[$85:8080]  ;} Display save confirmation message box
$A2:AB26 C9 02 00    CMP #$0002             ;\
$A2:AB29 F0 15       BEQ $15    [$AB40]     ;} If [save confirmation selection] != no:
$A2:AB2B AF F8 D8 7E LDA $7ED8F8[$7E:D8F8]  ;\
$A2:AB2F 09 01 00    ORA #$0001             ;} Set Crateria save station 0
$A2:AB32 8F F8 D8 7E STA $7ED8F8[$7E:D8F8]  ;/
$A2:AB36 9C 8B 07    STZ $078B  [$7E:078B]  ; Load station index = 0
$A2:AB39 AD 52 09    LDA $0952  [$7E:0952]  ;\
$A2:AB3C 22 00 80 81 JSL $818000[$81:8000]  ;} Save current save slot to SRAM

$A2:AB40 A9 60 AB    LDA #$AB60             ;\
$A2:AB43 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AB60
$A2:AB46 A9 01 00    LDA #$0001             ;\
$A2:AB49 9D 14 10    STA $1014,x[$7E:1014]  ;} Enemy ([X] + 2) instruction timer = 1
$A2:AB4C A9 BE A5    LDA #$A5BE             ;\
$A2:AB4F 9D 12 10    STA $1012,x[$7E:1012]  ;} Enemy ([X] + 2) instruction list pointer = $A5BE
$A2:AB52 A9 90 00    LDA #$0090             ;\
$A2:AB55 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Enemy 0 function timer = 90h
$A2:AB58 A9 14 00    LDA #$0014             ;\
$A2:AB5B 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 14h, sound library 3, max queued sounds allowed = 6 (gunship elevator activated)
$A2:AB5F 6B          RTL
}


;;; $AB60: Gunship function - wait for entrance pad to open ;;;
{
; Set by initialisation AI if demo set 0 is playing
$A2:AB60 CE A8 0F    DEC $0FA8  [$7E:0FA8]  ; Decrement enemy function timer
$A2:AB63 F0 02       BEQ $02    [$AB67]     ;\
$A2:AB65 10 06       BPL $06    [$AB6D]     ;} If [enemy function timer] > 0: return

$A2:AB67 A9 6E AB    LDA #$AB6E             ;\
$A2:AB6A 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AB6E

$A2:AB6D 6B          RTL
}


;;; $AB6E: Gunship function - eject Samus ;;;
{
$A2:AB6E BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A2:AB71 38          SEC                    ;|
$A2:AB72 E9 1E 00    SBC #$001E             ;} $12 = [enemy fixed Y position] - 1Eh
$A2:AB75 85 12       STA $12    [$7E:0012]  ;/
$A2:AB77 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AB7A 38          SEC                    ;|
$A2:AB7B E9 02 00    SBC #$0002             ;} Samus Y position -= 2
$A2:AB7E 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:AB81 C5 12       CMP $12    [$7E:0012]  ;\
$A2:AB83 10 1F       BPL $1F    [$ABA4]     ;} If [Samus Y position] >= [$12]: return
$A2:AB85 A9 A5 AB    LDA #$ABA5             ;\
$A2:AB88 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $ABA5
$A2:AB8B A9 01 00    LDA #$0001             ;\
$A2:AB8E 9D 14 10    STA $1014,x[$7E:1014]  ;} Enemy ([X] + 2) instruction timer = 1
$A2:AB91 A9 EE A5    LDA #$A5EE             ;\
$A2:AB94 9D 12 10    STA $1012,x[$7E:1012]  ;} Enemy ([X] + 2) instruction list pointer = $A5EE
$A2:AB97 A9 90 00    LDA #$0090             ;\
$A2:AB9A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Enemy 0 function timer = 90h
$A2:AB9D A9 15 00    LDA #$0015             ;\
$A2:ABA0 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 15h, sound library 3, max queued sounds allowed = 6 (gunship elevator deactivated)

$A2:ABA4 6B          RTL
}


;;; $ABA5: Gunship function - wait for entrance pad to close ;;;
{
$A2:ABA5 CE A8 0F    DEC $0FA8  [$7E:0FA8]  ; Decrement enemy function timer
$A2:ABA8 F0 02       BEQ $02    [$ABAC]     ;\
$A2:ABAA 10 1A       BPL $1A    [$ABC6]     ;} If [enemy function timer] > 0: return

$A2:ABAC A9 BD A9    LDA #$A9BD             ;\
$A2:ABAF 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $A9BD
$A2:ABB2 AD 98 09    LDA $0998  [$7E:0998]  ;\
$A2:ABB5 C9 28 00    CMP #$0028             ;} If in demo: return
$A2:ABB8 10 0C       BPL $0C    [$ABC6]     ;/
$A2:ABBA A9 95 E6    LDA #$E695             ;\
$A2:ABBD 8D 42 0A    STA $0A42  [$7E:0A42]  ;} $0A42 = $E695 (normal)
$A2:ABC0 A9 25 E7    LDA #$E725             ;\
$A2:ABC3 8D 44 0A    STA $0A44  [$7E:0A44]  ;} $0A44 = $E725 (normal)

$A2:ABC6 6B          RTL
}


;;; $ABC7: Gunship function - liftoff - load dust cloud tiles ;;;
{
$A2:ABC7 AC EC 0D    LDY $0DEC  [$7E:0DEC]  ;\
$A2:ABCA DA          PHX                    ;|
$A2:ABCB AE 30 03    LDX $0330  [$7E:0330]  ;|
$A2:ABCE A9 00 04    LDA #$0400             ;|
$A2:ABD1 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A2:ABD3 E8          INX                    ;|
$A2:ABD4 E8          INX                    ;|
$A2:ABD5 B9 07 AC    LDA $AC07,y[$A2:AC07]  ;|
$A2:ABD8 95 D0       STA $D0,x  [$7E:00D2]  ;|
$A2:ABDA E8          INX                    ;|
$A2:ABDB E8          INX                    ;|
$A2:ABDC E2 20       SEP #$20               ;} Queue DMA of 400 bytes from $94:0000 + [$AC07 + [$0DEC]] to VRAM [$AC11 + [$0DEC]]
$A2:ABDE A9 94       LDA #$94               ;|
$A2:ABE0 95 D0       STA $D0,x  [$7E:00D4]  ;|
$A2:ABE2 C2 20       REP #$20               ;|
$A2:ABE4 E8          INX                    ;|
$A2:ABE5 B9 11 AC    LDA $AC11,y[$A2:AC11]  ;|
$A2:ABE8 95 D0       STA $D0,x  [$7E:00D5]  ;|
$A2:ABEA E8          INX                    ;|
$A2:ABEB E8          INX                    ;|
$A2:ABEC 8E 30 03    STX $0330  [$7E:0330]  ;|
$A2:ABEF FA          PLX                    ;/
$A2:ABF0 AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$A2:ABF3 1A          INC A                  ;|
$A2:ABF4 1A          INC A                  ;} $0DEC += 2
$A2:ABF5 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;/
$A2:ABF8 C9 0A 00    CMP #$000A             ;\
$A2:ABFB 30 09       BMI $09    [$AC06]     ;} If [$0DEC] < Ah: return
$A2:ABFD A9 1B AC    LDA #$AC1B             ;\
$A2:AC00 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AC1B
$A2:AC03 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; $0DEC = 0

$A2:AC06 6B          RTL

$A2:AC07             dw C800, CC00, D000, D400, D800 ; Source addresses (bank $94)
$A2:AC11             dw 7600, 7800, 7A00, 7C00, 7E00 ; Destination VRAM addresses
}


;;; $AC1B: Gunship function - liftoff - fire up engines and spawn dust clouds ;;;
{
$A2:AC1B BD F0 0F    LDA $0FF0,x[$7E:0FF0]  ;\
$A2:AC1E C9 40 00    CMP #$0040             ;} If [enemy ([X] + 1) $0FB0] >= 40h: go to BRANCH_RUMBLE_INTENSIFIES
$A2:AC21 10 23       BPL $23    [$AC46]     ;/
$A2:AC23 89 01 00    BIT #$0001             ;\
$A2:AC26 F0 0F       BEQ $0F    [$AC37]     ;} If [enemy ([X] + 1) $0FB0] & 1 != 0:
$A2:AC28 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AC2B 18          CLC                    ;|
$A2:AC2C 69 01 00    ADC #$0001             ;} Samus Y position += 1
$A2:AC2F 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:AC32 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$A2:AC35 80 30       BRA $30    [$AC67]     ; Go to BRANCH_MERGE

$A2:AC37 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AC3A 38          SEC                    ;|
$A2:AC3B E9 01 00    SBC #$0001             ;} Samus Y position -= 1
$A2:AC3E 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:AC41 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$A2:AC44 80 21       BRA $21    [$AC67]     ; Go to BRANCH_MERGE

; BRANCH_RUMBLE_INTENSIFIES
$A2:AC46 89 01 00    BIT #$0001             ;\
$A2:AC49 F0 0F       BEQ $0F    [$AC5A]     ;} If [enemy ([X] + 1) $0FB0] & 1 != 0:
$A2:AC4B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AC4E 18          CLC                    ;|
$A2:AC4F 69 02 00    ADC #$0002             ;} Samus Y position += 2
$A2:AC52 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:AC55 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$A2:AC58 80 0D       BRA $0D    [$AC67]     ; Go to BRANCH_MERGE

$A2:AC5A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AC5D 38          SEC                    ;|
$A2:AC5E E9 02 00    SBC #$0002             ;} Samus Y position -= 2
$A2:AC61 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:AC64 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]

; BRANCH_MERGE
$A2:AC67 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AC6A 38          SEC                    ;|
$A2:AC6B E9 11 00    SBC #$0011             ;} Enemy Y position = [Samus Y position] - 11h
$A2:AC6E 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:AC71 3A          DEC A                  ;\
$A2:AC72 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;} Enemy ([X] + 2) Y position = [enemy Y position] - 1
$A2:AC75 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AC78 18          CLC                    ;|
$A2:AC79 69 17 00    ADC #$0017             ;} Enemy ([X] + 1) Y position = [Samus Y position] + 17h
$A2:AC7C 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;/
$A2:AC7F BD F0 0F    LDA $0FF0,x[$7E:0FF0]  ;\
$A2:AC82 1A          INC A                  ;} Increment enemy ([X] + 1) $0FB0
$A2:AC83 9D F0 0F    STA $0FF0,x[$7E:0FF0]  ;/
$A2:AC86 C9 80 00    CMP #$0080             ;\
$A2:AC89 30 0A       BMI $0A    [$AC95]     ;} If [enemy ([X] + 1) $0FB0] >= 80h:
$A2:AC8B A9 D7 AC    LDA #$ACD7             ;\
$A2:AC8E 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $ACD7
$A2:AC91 9C A8 0F    STZ $0FA8  [$7E:0FA8]  ; Enemy 0 function timer = 0
$A2:AC94 6B          RTL

$A2:AC95 C9 40 00    CMP #$0040             ;\
$A2:AC98 D0 3C       BNE $3C    [$ACD6]     ;} If [enemy ([X] + 1) $0FB0] != 40h: return
$A2:AC9A A9 00 00    LDA #$0000             ;\
$A2:AC9D A0 79 A3    LDY #$A379             ;} Spawn gunship liftoff dust clouds enemy projectile with parameter 0 using room graphics
$A2:ACA0 22 97 80 86 JSL $868097[$86:8097]  ;/
$A2:ACA4 A9 02 00    LDA #$0002             ;\
$A2:ACA7 A0 79 A3    LDY #$A379             ;} Spawn gunship liftoff dust clouds enemy projectile with parameter 2 using room graphics
$A2:ACAA 22 97 80 86 JSL $868097[$86:8097]  ;/
$A2:ACAE A9 04 00    LDA #$0004             ;\
$A2:ACB1 A0 79 A3    LDY #$A379             ;} Spawn gunship liftoff dust clouds enemy projectile with parameter 4 using room graphics
$A2:ACB4 22 97 80 86 JSL $868097[$86:8097]  ;/
$A2:ACB8 A9 06 00    LDA #$0006             ;\
$A2:ACBB A0 79 A3    LDY #$A379             ;} Spawn gunship liftoff dust clouds enemy projectile with parameter 6 using room graphics
$A2:ACBE 22 97 80 86 JSL $868097[$86:8097]  ;/
$A2:ACC2 A9 08 00    LDA #$0008             ;\
$A2:ACC5 A0 79 A3    LDY #$A379             ;} Spawn gunship liftoff dust clouds enemy projectile with parameter 8 using room graphics
$A2:ACC8 22 97 80 86 JSL $868097[$86:8097]  ;/
$A2:ACCC A9 0A 00    LDA #$000A             ;\
$A2:ACCF A0 79 A3    LDY #$A379             ;} Spawn gunship liftoff dust clouds enemy projectile with parameter Ah using room graphics
$A2:ACD2 22 97 80 86 JSL $868097[$86:8097]  ;/

$A2:ACD6 6B          RTL
}


;;; $ACD7: Gunship function - liftoff - steady rise ;;;
{
$A2:ACD7 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:ACDA 38          SEC                    ;|
$A2:ACDB E9 02 00    SBC #$0002             ;} Samus Y position -= 2
$A2:ACDE 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:ACE1 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:ACE4 38          SEC                    ;|
$A2:ACE5 E9 11 00    SBC #$0011             ;} Enemy Y position = [Samus Y position] - 11h
$A2:ACE8 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:ACEB 3A          DEC A                  ;\
$A2:ACEC 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;} Enemy ([X] + 2) Y position = [enemy Y position] - 1
$A2:ACEF AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:ACF2 18          CLC                    ;|
$A2:ACF3 69 17 00    ADC #$0017             ;} Enemy ([X] + 1) Y position = [Samus Y position] + 17h
$A2:ACF6 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;/
$A2:ACF9 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:ACFC C9 80 03    CMP #$0380             ;} If [enemy Y position] >= 380h: return
$A2:ACFF 10 0C       BPL $0C    [$AD0D]     ;/
$A2:AD01 A9 0E AD    LDA #$AD0E             ;\
$A2:AD04 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AD0E
$A2:AD07 A9 00 02    LDA #$0200             ;\
$A2:AD0A 9D F2 0F    STA $0FF2,x[$7E:0FF2]  ;} Enemy ([X] + 1) $0FB2 = 200h

$A2:AD0D 6B          RTL
}


;;; $AD0E: Gunship function - liftoff - accelerating / set game state ;;;
{
$A2:AD0E 22 2D AD A2 JSL $A2AD2D[$A2:AD2D]  ; Liftoff - accelerating
$A2:AD12 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:AD15 C9 00 01    CMP #$0100             ;} If [enemy Y position] >= 100h: return
$A2:AD18 10 12       BPL $12    [$AD2C]     ;/
$A2:AD1A A9 2D AD    LDA #$AD2D             ;\
$A2:AD1D 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $AD2D
$A2:AD20 A9 26 00    LDA #$0026             ;\
$A2:AD23 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 26h (Samus escaped from Zebes)
$A2:AD26 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$A2:AD29 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0

$A2:AD2C 6B          RTL
}


;;; $AD2D: Gunship function - liftoff - accelerating ;;;
{
$A2:AD2D BD F2 0F    LDA $0FF2,x[$7E:0FF2]  ;\
$A2:AD30 18          CLC                    ;|
$A2:AD31 69 40 00    ADC #$0040             ;} Enemy ([X] + 1) $0FB2 += 40h
$A2:AD34 9D F2 0F    STA $0FF2,x[$7E:0FF2]  ;/
$A2:AD37 29 00 FF    AND #$FF00             ;\
$A2:AD3A C9 00 0A    CMP #$0A00             ;} If [enemy ([X] + 1) $0FB2] >= A00h:
$A2:AD3D 30 06       BMI $06    [$AD45]     ;/
$A2:AD3F A9 00 09    LDA #$0900             ;\
$A2:AD42 9D F2 0F    STA $0FF2,x[$7E:0FF2]  ;} Enemy ([X] + 1) $0FB2 = 900h

$A2:AD45 BD F2 0F    LDA $0FF2,x[$7E:0FF2]  ;\
$A2:AD48 EB          XBA                    ;|
$A2:AD49 48          PHA                    ;|
$A2:AD4A 29 00 FF    AND #$FF00             ;|
$A2:AD4D 85 14       STA $14    [$7E:0014]  ;|
$A2:AD4F 68          PLA                    ;|
$A2:AD50 29 FF 00    AND #$00FF             ;|
$A2:AD53 85 12       STA $12    [$7E:0012]  ;} Samus Y position -= [enemy ([X] + 1) $0FB2] / 100h
$A2:AD55 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;|
$A2:AD58 38          SEC                    ;|
$A2:AD59 E5 14       SBC $14    [$7E:0014]  ;|
$A2:AD5B 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;|
$A2:AD5E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A2:AD61 E5 12       SBC $12    [$7E:0012]  ;|
$A2:AD63 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A2:AD66 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AD69 38          SEC                    ;|
$A2:AD6A E9 11 00    SBC #$0011             ;} Enemy Y position = [Samus Y position] - 11h
$A2:AD6D 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:AD70 3A          DEC A                  ;\
$A2:AD71 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;} Enemy ([X] + 2) Y position = [enemy Y position] - 1
$A2:AD74 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:AD77 18          CLC                    ;|
$A2:AD78 69 17 00    ADC #$0017             ;} Enemy ([X] + 1) Y position = [Samus Y position] + 17h
$A2:AD7B 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;/
$A2:AD7E 6B          RTL
}


;;; $AD7F: RTL ;;;
{
$A2:AD7F 6B          RTL
}


;;; $AD80: RTL ;;;
{
$A2:AD80 6B          RTL
}


;;; $AD81: Spritemaps - gunship ;;;
{
$A2:AD81             dx 0012, C201,FE,7F20, C211,FE,7F0E, C221,FE,7F0C, C231,FE,7F0A, C241,FE,7F08, C201,EE,7F06, C211,EE,7F04, C221,EE,7F02, C231,EE,7F00, C3F1,FE,3F20, C3E1,FE,3F0E, C3D1,FE,3F0C, C3C1,FE,3F0A, C3B1,FE,3F08, C3F1,EE,3F06, C3E1,EE,3F04, C3D1,EE,3F02, C3C1,EE,3F00
$A2:ADDD             dx 0022, C201,06,7F62, C211,06,7F60, C221,06,7F4E, C231,06,7F4C, C241,06,7F4A, C201,F6,7F48, C211,F6,7F46, C221,F6,7F44, C231,F6,7F42, C241,F6,7F40, C251,F6,7F2E, C201,E6,7F2C, C211,E6,7F2A, C221,E6,7F28, C231,E6,7F26, C241,E6,7F24, C251,E6,7F22, C3F1,06,3F62, C3E1,06,3F60, C3D1,06,3F4E, C3C1,06,3F4C, C3B1,06,3F4A, C3F1,F6,3F48, C3E1,F6,3F46, C3D1,F6,3F44, C3C1,F6,3F42, C3B1,F6,3F40, C3A1,F6,3F2E, C3F1,E6,3F2C, C3E1,E6,3F2A, C3D1,E6,3F28, C3C1,E6,3F26, C3B1,E6,3F24, C3A1,E6,3F22
$A2:AE89             dx 0004, 0000,F6,7F65, 0008,F6,7F64, 01F8,F6,3F65, 01F0,F6,3F64
$A2:AE9F             dx 0004, 0000,F4,7F65, 0008,F4,7F64, 01F8,F4,3F65, 01F0,F4,3F64
$A2:AEB5             dx 0004, 0000,F2,7F65, 0008,F3,7F64, 01F8,F2,3F65, 01F0,F3,3F64
$A2:AECB             dx 0008, 01F6,F2,3F65, 01EE,F3,3F64, 0002,F2,7F65, 000A,F3,7F64, 0000,F5,7F67, 0008,F5,7F66, 01F8,F5,3F67, 01F0,F5,3F66
$A2:AEF5             dx 0008, 0004,F2,7F65, 000C,F4,7F64, 01F4,F2,3F65, 01EC,F4,3F64, 0000,F4,7F67, 0008,F4,7F66, 01F8,F4,3F67, 01F0,F4,3F66
$A2:AF1F             dx 0008, 0006,F2,7F65, 000E,F4,7F64, 01F2,F2,3F65, 01EA,F4,3F64, 0000,F3,7F67, 0008,F3,7F66, 01F8,F3,3F67, 01F0,F3,3F66
$A2:AF49             dx 0008, 0008,F2,7F65, 0010,F4,7F64, 01F0,F2,3F65, 01E8,F4,3F64, 0000,F3,7F67, 0008,F3,7F66, 01F8,F3,3F67, 01F0,F3,3F66
$A2:AF73             dx 0008, 000A,F3,7F65, 0012,F6,7F64, 01EE,F3,3F65, 01E6,F6,3F64, 0000,F3,7F67, 0008,F3,7F66, 01F8,F3,3F67, 01F0,F3,3F66
$A2:AF9D             dx 0008, 000C,F3,7F65, 0014,F6,7F64, 01EC,F3,3F65, 01E4,F6,3F64, 0000,F3,7F67, 0008,F3,7F66, 01F8,F3,3F67, 01F0,F3,3F66
$A2:AFC7             dx 0004, 0000,F7,7F65, 0008,F7,7F64, 01F8,F7,3F65, 01F0,F7,3F64
$A2:AFDD             dx 0004, 0000,F8,7F65, 0008,F8,7F64, 01F8,F8,3F65, 01F0,F8,3F64
}
}


;;; $AFF3..B2BB: Flies ;;;
{
;;; $AFF3: Palette - enemy $D0FF (pre-Bomb Torizo fly) ;;;
{
$A2:AFF3             dw 3800, 72FA, 55B0, 2845, 1801, 6210, 496B, 38C6, 2C63, 2FEF, 030D, 0209, 0145, 183F, 1014, 080A
}


;;; $B013: Instruction list - flies ;;;
{
$A2:B013             dw 0002,B1E8,
                        0002,B1EF,
                        0002,B1F6,
                        0002,B1FD,
                        80ED,B013   ; Go to $B013
}


;;; $B027: Unused. Old movement data? ;;;
{
$A2:B027             dw 0002, FFFC, FFFE, 0004, 0002, FFFE, 0002, 0004, 0002, FFFE, FFFE, 0002, FFFC, FFFE, 0002, 0002,
                        FFFE, FFFE, 0004, 0002, FFFC, FFFE, 0002, FFFE, FFFC, FFFE, 0002, 0002, FFFE, 0004, 0002, FFFE,
                        FFFE, 0002
}


;;; $B06B: Initialisation AI - enemy $D0FF/$D13F/$D17F (flies) ;;;
{
$A2:B06B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B06E 9E B0 0F    STZ $0FB0,x[$7E:0FB0]  ; Enemy angle = 0
$A2:B071 A9 4E B1    LDA #$B14E             ;\
$A2:B074 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $B14E
$A2:B077 A9 13 B0    LDA #$B013             ;\
$A2:B07A 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $B013
$A2:B07D A9 4D 80    LDA #$804D             ;\
$A2:B080 9D 8E 0F    STA $0F8E,x[$7E:0F8E]  ;} Enemy spritemap pointer = $804D
$A2:B083 A9 01 00    LDA #$0001             ;\
$A2:B086 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A2:B089 A9 4D 80    LDA #$804D
$A2:B08C 9D 8E 0F    STA $0F8E,x[$7E:0F8E]
$A2:B08F 6B          RTL
}


;;; $B090: Move fly according to angle ;;;
{
$A2:B090 9B          TXY
$A2:B091 BE B0 0F    LDX $0FB0,y[$7E:0FF0]  ;\
$A2:B094 BF 42 B4 A0 LDA $A0B442,x[$A0:B442];|
$A2:B098 29 00 FF    AND #$FF00             ;|
$A2:B09B 18          CLC                    ;|
$A2:B09C 79 7C 0F    ADC $0F7C,y[$7E:0FBC]  ;|
$A2:B09F 99 7C 0F    STA $0F7C,y[$7E:0FBC]  ;|
$A2:B0A2 BF 43 B4 A0 LDA $A0B443,x[$A0:B443];|
$A2:B0A6 EB          XBA                    ;|
$A2:B0A7 10 05       BPL $05    [$B0AE]     ;} Enemy X position += sin([enemy $0FB0] / 2 * pi / 80h)
$A2:B0A9 09 00 FF    ORA #$FF00             ;|
$A2:B0AC 80 03       BRA $03    [$B0B1]     ;|
                                            ;|
$A2:B0AE 29 FF 00    AND #$00FF             ;|
                                            ;|
$A2:B0B1 79 7A 0F    ADC $0F7A,y[$7E:0FBA]  ;|
$A2:B0B4 99 7A 0F    STA $0F7A,y[$7E:0FBA]  ;/
$A2:B0B7 BF C2 B3 A0 LDA $A0B3C2,x[$A0:B3C2];\
$A2:B0BB 29 00 FF    AND #$FF00             ;|
$A2:B0BE 18          CLC                    ;|
$A2:B0BF 79 80 0F    ADC $0F80,y[$7E:0FC0]  ;|
$A2:B0C2 99 80 0F    STA $0F80,y[$7E:0FC0]  ;|
$A2:B0C5 BF C3 B3 A0 LDA $A0B3C3,x[$A0:B3C3];|
$A2:B0C9 EB          XBA                    ;|
$A2:B0CA 10 05       BPL $05    [$B0D1]     ;} Enemy Y position += -cos([enemy $0FB0] / 2 * pi / 80h)
$A2:B0CC 09 00 FF    ORA #$FF00             ;|
$A2:B0CF 80 03       BRA $03    [$B0D4]     ;|
                                            ;|
$A2:B0D1 29 FF 00    AND #$00FF             ;|
                                            ;|
$A2:B0D4 79 7E 0F    ADC $0F7E,y[$7E:0FBE]  ;|
$A2:B0D7 99 7E 0F    STA $0F7E,y[$7E:0FBE]  ;/
$A2:B0DA BB          TYX
$A2:B0DB 60          RTS
}


;;; $B0DC: Move fly according to velocities ;;;
{
;; Returns:
;;     A: Enemy Y position
$A2:B0DC BD A9 0F    LDA $0FA9,x[$7E:0FE9]  ;\
$A2:B0DF 29 00 FF    AND #$FF00             ;|
$A2:B0E2 18          CLC                    ;|
$A2:B0E3 7D 7C 0F    ADC $0F7C,x[$7E:0FBC]  ;|
$A2:B0E6 9D 7C 0F    STA $0F7C,x[$7E:0FBC]  ;|
$A2:B0E9 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;|
$A2:B0EC EB          XBA                    ;|
$A2:B0ED 10 05       BPL $05    [$B0F4]     ;} Enemy X position += ±[enemy X velocity] / 100h
$A2:B0EF 09 00 FF    ORA #$FF00             ;|
$A2:B0F2 80 03       BRA $03    [$B0F7]     ;|
                                            ;|
$A2:B0F4 29 FF 00    AND #$00FF             ;|
                                            ;|
$A2:B0F7 7D 7A 0F    ADC $0F7A,x[$7E:0FBA]  ;|
$A2:B0FA 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$A2:B0FD BD AB 0F    LDA $0FAB,x[$7E:0FEB]  ;\
$A2:B100 29 00 FF    AND #$FF00             ;|
$A2:B103 18          CLC                    ;|
$A2:B104 7D 80 0F    ADC $0F80,x[$7E:0FC0]  ;|
$A2:B107 9D 80 0F    STA $0F80,x[$7E:0FC0]  ;|
$A2:B10A BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;|
$A2:B10D EB          XBA                    ;|
$A2:B10E 10 05       BPL $05    [$B115]     ;} Enemy Y position += ±[enemy Y velocity] / 100h
$A2:B110 09 00 FF    ORA #$FF00             ;|
$A2:B113 80 03       BRA $03    [$B118]     ;|
                                            ;|
$A2:B115 29 FF 00    AND #$00FF             ;|
                                            ;|
$A2:B118 7D 7E 0F    ADC $0F7E,x[$7E:0FBE]  ;|
$A2:B11B 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A2:B11E 60          RTS
}


;;; $B11F: Main AI - enemy $D0FF/$D13F/$D17F (flies) ;;;
{
$A2:B11F 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A2:B123 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A2:B126 7C B2 0F    JMP ($0FB2,x)[$A2:B14E];} Go to [enemy function]
}


;;; $B129: Set fly to attack Samus ;;;
{
; Sets up X/Y velocity to direct fly towards midpoint between Samus and enemy
$A2:B129 22 66 C0 A0 JSL $A0C066[$A0:C066]  ; A = angle of Samus from enemy
$A2:B12D 0A          ASL A
$A2:B12E 9B          TXY
$A2:B12F AA          TAX
$A2:B130 BF 43 B4 A0 LDA $A0B443,x[$A0:B58D];\
$A2:B134 0A          ASL A                  ;} Enemy X velocity = 2 * sin([A] * pi / 80h) * 100h
$A2:B135 99 AA 0F    STA $0FAA,y[$7E:0FEA]  ;/
$A2:B138 BF C3 B3 A0 LDA $A0B3C3,x[$A0:B50D];\
$A2:B13C 0A          ASL A                  ;|
$A2:B13D 0A          ASL A                  ;} Enemy Y velocity = 4 * -cos([A] * pi / 80h) * 100h
$A2:B13E 99 AC 0F    STA $0FAC,y[$7E:0FEC]  ;/
$A2:B141 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A2:B144 99 AE 0F    STA $0FAE,y[$7E:0FEE]  ;} Enemy target Y position = [Samus Y position]
$A2:B147 A9 AA B1    LDA #$B1AA             ;\
$A2:B14A 99 B2 0F    STA $0FB2,y[$7E:0FF2]  ;} Enemy function = $B1AA
$A2:B14D 6B          RTL
}


;;; $B14E: Fly function - idle movement - clockwise circle ;;;
{
$A2:B14E BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;\
$A2:B151 F0 06       BEQ $06    [$B159]     ;} If [enemy retreat timer] != 0:
$A2:B153 3A          DEC A                  ;\
$A2:B154 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Decrement enemy retreat timer
$A2:B157 80 09       BRA $09    [$B162]

$A2:B159 A9 70 00    LDA #$0070             ;\ Else ([enemy retreat timer] = 0):
$A2:B15C 22 9B BB A0 JSL $A0BB9B[$A0:BB9B]  ;} If X distance between enemy and Samus is less than 70h: go to set fly to attack Samus
$A2:B160 90 C7       BCC $C7    [$B129]     ;/

$A2:B162 20 90 B0    JSR $B090  [$A2:B090]  ; Move fly according to angle
$A2:B165 BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;\
$A2:B168 18          CLC                    ;|
$A2:B169 69 20 00    ADC #$0020             ;} Enemy angle = ([enemy angle] + 20h) % 200h
$A2:B16C 29 FF 01    AND #$01FF             ;|
$A2:B16F 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;/
$A2:B172 F0 01       BEQ $01    [$B175]     ; If [enemy angle] != 0:
$A2:B174 6B          RTL                    ; Return

$A2:B175 A9 7C B1    LDA #$B17C             ;\
$A2:B178 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $B17C
$A2:B17B 6B          RTL
}


;;; $B17C: Fly function - idle movement - anti-clockwise circle ;;;
{
$A2:B17C BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;\
$A2:B17F F0 06       BEQ $06    [$B187]     ;} If [enemy retreat timer] != 0:
$A2:B181 3A          DEC A                  ;\
$A2:B182 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Decrement enemy retreat timer
$A2:B185 80 09       BRA $09    [$B190]

$A2:B187 A9 70 00    LDA #$0070             ;\ Else ([enemy retreat timer] = 0):
$A2:B18A 22 9B BB A0 JSL $A0BB9B[$A0:BB9B]  ;} If X distance between enemy and Samus is less than 70h: Set fly to attack Samus
$A2:B18E 90 99       BCC $99    [$B129]     ;/

$A2:B190 20 90 B0    JSR $B090  [$A2:B090]  ; Move fly according to angle
$A2:B193 BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;\
$A2:B196 38          SEC                    ;|
$A2:B197 E9 20 00    SBC #$0020             ;} Enemy angle = ([enemy angle] - 20h) % 200h
$A2:B19A 29 FF 01    AND #$01FF             ;|
$A2:B19D 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;/
$A2:B1A0 F0 01       BEQ $01    [$B1A3]     ; If [enemy angle] != 0:
$A2:B1A2 6B          RTL                    ; Return

$A2:B1A3 A9 4E B1    LDA #$B14E             ;\
$A2:B1A6 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $B14E
$A2:B1A9 6B          RTL
}


;;; $B1AA: Fly function - attack Samus ;;;
{
$A2:B1AA 20 DC B0    JSR $B0DC  [$A2:B0DC]  ; Move fly according to velocities
$A2:B1AD FE A8 0F    INC $0FA8,x[$7E:0FE8]  ; Increment enemy retreat timer
$A2:B1B0 3C AC 0F    BIT $0FAC,x[$7E:0FEC]  ;\
$A2:B1B3 10 06       BPL $06    [$B1BB]     ;} If [enemy X velocity] < 0:
$A2:B1B5 DD AE 0F    CMP $0FAE,x[$7E:116E]  ;\
$A2:B1B8 90 07       BCC $07    [$B1C1]     ;} If [enemy Y position] >= [enemy target Y position]:
$A2:B1BA 6B          RTL                    ; Return

$A2:B1BB DD AE 0F    CMP $0FAE,x[$7E:0FEE]  ;\ Else ([enemy Y velocity] >= 0):
$A2:B1BE B0 01       BCS $01    [$B1C1]     ;} If [enemy Y position] < [enemy target Y position]:
$A2:B1C0 6B          RTL                    ; Return

$A2:B1C1 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A2:B1C4 49 FF FF    EOR #$FFFF             ;|
$A2:B1C7 1A          INC A                  ;} Negate enemy Y velocity
$A2:B1C8 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;/
$A2:B1CB A9 D2 B1    LDA #$B1D2             ;\
$A2:B1CE 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $B1D2
$A2:B1D1 6B          RTL
}


;;; $B1D2: Fly function - retreat ;;;
{
$A2:B1D2 20 DC B0    JSR $B0DC  [$A2:B0DC]  ; Move fly according to velocities
$A2:B1D5 DE A8 0F    DEC $0FA8,x[$7E:0FA8]  ; Decrement enemy retreat timer
$A2:B1D8 30 01       BMI $01    [$B1DB]     ; If [enemy retreat timer] >= 0:
$A2:B1DA 6B          RTL                    ; Return

$A2:B1DB A9 18 00    LDA #$0018             ;\
$A2:B1DE 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy retreat timer = 18h
$A2:B1E1 A9 4E B1    LDA #$B14E             ;\
$A2:B1E4 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $B14E
$A2:B1E7 6B          RTL
}


;;; $B1E8: Spritemaps - flies ;;;
{
$A2:B1E8             dx 0001, C3F8,F8,2100
$A2:B1EF             dx 0001, C3F8,F8,2102
$A2:B1F6             dx 0001, C3F8,F8,2104
$A2:B1FD             dx 0001, C3F8,F8,2106
}


;;; $B204: Unused. Fly spritemap pointers ;;;
{
$A2:B204             dw B1E8, B1EF, B1F6, B1FD
}


;;; $B20C: Palette - enemy $D13F (under ice beam fly) ;;;
{
$A2:B20C             dw 3800, 039F, 01BF, 000F, 0005, 021F, 015B, 00BA, 0011, 4F72, 36AD, 1DC8, 0925, 7E1F, 5415, 280A
}


;;; $B22C: Unused ;;;
{
$A2:B22C             dw B22E
$A2:B22E             dw 0000, 000E, 0001, 000B, 0002, 000A, 0003, 0009, FFFE
}


;;; $B240: Unused. Under ice beam fly spritemaps ;;;
{
$A2:B240             dx 0001, C3F8,F4,2100
$A2:B247             dx 0001, C3F8,F4,2102
$A2:B24E             dx 0001, C3F8,F4,2104
$A2:B255             dx 0001, C3F8,F4,2106
}


;;; $B25C: Unused. Spritemap pointers - under ice beam fly ;;;
{
$A2:B25C             dw B240, B247, B24E, B255
}


;;; $B264: Palette - enemy $D17F (pre-spring ball fly) ;;;
{
$A2:B264             dw 3800, 72FA, 55B0, 2845, 1801, 6210, 496B, 38C6, 2C63, 2F5A, 2294, 01AD, 0108, 7FFF, 56B5, 294A
}


;;; $B284: Unused ;;;
{
$A2:B284             dw B286
$A2:B286             dw 0000, 000E, 0001, 000B, 0002, 000A, 0003, 0009, FFFE
}


;;; $B298: Unused. Pre-spring ball fly spritemaps ;;;
{
$A2:B298             dx 0001,C3F8,F8,2100
$A2:B29F             dx 0001,C3F8,F8,2102
$A2:B2A6             dx 0001,C3F8,F8,2104
$A2:B2AD             dx 0001,C3F8,F8,2106
}


;;; $B2B4: Unused. Spritemap pointers - enemy $D17F (pre-spring ball fly) ;;;
{
$A2:B2B4             dw B298, B29F, B2A6, B2AD
}
}


;;; $B2BC..B519: Norfair erratic fireball ;;;
{
;;; $B2BC: Palette - enemy $D1BF (Norfair erratic fireball) ;;;
{
$A2:B2BC             dw 3800, 02FF, 01BF, 000F, 0008, 01BF, 011B, 0015, 0011, 241F, 1C17, 142F, 0C47, 03E0, 02A0, 0140
}


;;; $B2DC..B3DF: Instruction lists - Norfair erratic fireball ;;;
{
;;; $B2DC: Instruction list -  ;;;
{
$A2:B2DC             dx 000A,B4AA,
                        000A,B4B1,
                        000A,B4B8,
                        000A,B4BF,
                        000A,B4C6,
                        000A,B4CD,
                        000A,B4D4,
                        000A,B4DB,
                        000A,B4D4,
                        000A,B4CD,
                        000A,B4C6,
                        000A,B4BF,
                        000A,B4B8,
                        000A,B4B1,
                        80ED,B2DC   ; Go to $B2DC
}


;;; $B318: Instruction list -  ;;;
{
$A2:B318             dx 0002,B4E2,
                        0001,804D,
                        0002,B4E2,
                        0001,804D,
                        0002,B4E9,
                        0001,804D,
                        0002,B4E9,
                        0001,804D,
                        0002,B4F0,
                        0001,804D,
                        0002,B4F0,
                        0001,804D,
                        0002,B4F7,
                        0001,804D,
                        0002,B4F7,
                        0001,804D,
                        0002,B4F0,
                        0001,804D,
                        0002,B4F0,
                        0001,804D,
                        0002,B4E9,
                        0001,804D,
                        0002,B4E9,
                        0001,804D,
                        80ED,B318   ; Go to $B318
}


;;; $B37C: Instruction list -  ;;;
{
$A2:B37C             dx 0002,B4FE,
                        0001,804D,
                        0002,B4FE,
                        0001,804D,
                        0002,B505,
                        0001,804D,
                        0002,B505,
                        0001,804D,
                        0002,B50C,
                        0001,804D,
                        0002,B50C,
                        0001,804D,
                        0002,B513,
                        0001,804D,
                        0002,B513,
                        0001,804D,
                        0002,B50C,
                        0001,804D,
                        0002,B50C,
                        0001,804D,
                        0002,B505,
                        0001,804D,
                        0002,B505,
                        0001,804D,
                        80ED,B37C   ; Go to $B37C
}
}


;;; $B3E0: Initialisation AI - enemy $D1BF (Norfair erratic fireball) ;;;
{
$A2:B3E0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B3E3 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:B3E6 85 12       STA $12    [$7E:0012]
$A2:B3E8 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A2:B3EB 29 FF 00    AND #$00FF
$A2:B3EE 85 14       STA $14    [$7E:0014]
$A2:B3F0 22 43 B6 A0 JSL $A0B643[$A0:B643]
$A2:B3F4 A5 16       LDA $16    [$7E:0016]
$A2:B3F6 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:B3F9 A5 18       LDA $18    [$7E:0018]
$A2:B3FB 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:B3FE A5 1A       LDA $1A    [$7E:001A]
$A2:B400 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:B403 A5 1C       LDA $1C    [$7E:001C]
$A2:B405 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:B408 A9 DC B2    LDA #$B2DC
$A2:B40B 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:B40E 6B          RTL
}


;;; $B40F: Main AI - enemy $D1BF (Norfair erratic fireball) ;;;
{
; Note the two fixed point negation operations at $B443 and $B47D are off by 1.0 when the low word is zero
$A2:B40F AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B412 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:B415 85 12       STA $12    [$7E:0012]
$A2:B417 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A2:B41A 29 FF 00    AND #$00FF
$A2:B41D 85 14       STA $14    [$7E:0014]
$A2:B41F 22 43 B6 A0 JSL $A0B643[$A0:B643]
$A2:B423 A5 16       LDA $16    [$7E:0016]
$A2:B425 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:B428 A5 18       LDA $18    [$7E:0018]
$A2:B42A 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:B42D A5 1A       LDA $1A    [$7E:001A]
$A2:B42F 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:B432 A5 1C       LDA $1C    [$7E:001C]
$A2:B434 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:B437 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:B43A 18          CLC
$A2:B43B 69 40 00    ADC #$0040
$A2:B43E 89 80 00    BIT #$0080
$A2:B441 D0 13       BNE $13    [$B456]
$A2:B443 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A2:B446 49 FF FF    EOR #$FFFF             ;} Enemy X velocity = -1 - [enemy X velocity]
$A2:B449 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;/
$A2:B44C BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A2:B44F 49 FF FF    EOR #$FFFF             ;|
$A2:B452 1A          INC A                  ;} Negate enemy X subvelocity
$A2:B453 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;/

$A2:B456 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A2:B459 85 14       STA $14    [$7E:0014]  ;|
$A2:B45B BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;} Move enemy right by [enemy X velocity]
$A2:B45E 85 12       STA $12    [$7E:0012]  ;|
$A2:B460 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:B464 90 0B       BCC $0B    [$B471]     ; If collided with wall:
$A2:B466 BD B4 0F    LDA $0FB4,x[$7E:1034]
$A2:B469 49 40 00    EOR #$0040
$A2:B46C 9D B4 0F    STA $0FB4,x[$7E:1034]
$A2:B46F 80 38       BRA $38    [$B4A9]

$A2:B471 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:B474 18          CLC
$A2:B475 69 80 00    ADC #$0080
$A2:B478 89 80 00    BIT #$0080
$A2:B47B D0 13       BNE $13    [$B490]
$A2:B47D BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A2:B480 49 FF FF    EOR #$FFFF             ;} Enemy Y velocity = -1 - [enemy Y velocity]
$A2:B483 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;/
$A2:B486 BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$A2:B489 49 FF FF    EOR #$FFFF             ;|
$A2:B48C 1A          INC A                  ;} Negate enemy Y subvelocity
$A2:B48D 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;/

$A2:B490 BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A2:B493 85 14       STA $14    [$7E:0014]  ;|
$A2:B495 BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;} Move enemy down by [enemy Y velocity]
$A2:B498 85 12       STA $12    [$7E:0012]  ;|
$A2:B49A 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:B49E 90 09       BCC $09    [$B4A9]     ; If collided with block:
$A2:B4A0 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:B4A3 49 C0 00    EOR #$00C0
$A2:B4A6 9D B4 0F    STA $0FB4,x[$7E:0FB4]

$A2:B4A9 6B          RTL
}


;;; $B4AA: Spritemaps - Norfair erratic fireball ;;;
{
$A2:B4AA             dx 0001, 81F8,F8,2100
$A2:B4B1             dx 0001, 81F8,F8,2102
$A2:B4B8             dx 0001, 81F8,F8,2104
$A2:B4BF             dx 0001, 81F8,F8,2106
$A2:B4C6             dx 0001, 81F8,F8,2108
$A2:B4CD             dx 0001, 81F8,F8,210A
$A2:B4D4             dx 0001, 81F8,F8,210C
$A2:B4DB             dx 0001, 81F8,F8,210E
$A2:B4E2             dx 0001, 81F8,F8,2120
$A2:B4E9             dx 0001, 81F8,F8,2122
$A2:B4F0             dx 0001, 81F8,F8,2124
$A2:B4F7             dx 0001, 81F8,F8,2126
$A2:B4FE             dx 0001, 81F8,F8,2128
$A2:B505             dx 0001, 81F8,F8,212A
$A2:B50C             dx 0001, 81F8,F8,212C
$A2:B513             dx 0001, 81F8,F8,212E
}
}


;;; $B51A..B601: Lavaquake rocks ;;;
{
;;; $B51A: Instruction list - lavaquake rocks ;;;
{
$A2:B51A             dx 0001,B5FB,
                        812F        ; Sleep
}


;;; $B520:  ;;;
{
$A2:B520             dw 0010, 0018, 0020, 0028, 0030, 0038, 0040, 0048
$A2:B530             dw 001C, 001D, 001E, 001F, 0020, 0021, 0022, 0023, 0024, 0025, 0026, 0027, 0028, 0029, 002A, 002B
$A2:B550             dw 0060, 0070, 0080, 0090, 00A0, 00B0, 00C0, 00D0, FFA0, FF90, FF80, FF70, FF60, FF50, FF40, FF30
}


;;; $B570: Initialisation AI - enemy $D1FF (lavaquake rocks) ;;;
{
$A2:B570 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B573 A9 1A B5    LDA #$B51A
$A2:B576 9D 92 0F    STA $0F92,x[$7E:1112]
$A2:B579 A9 01 00    LDA #$0001
$A2:B57C 9D 94 0F    STA $0F94,x[$7E:1114]
$A2:B57F 9E 90 0F    STZ $0F90,x[$7E:1110]
$A2:B582 A9 96 B5    LDA #$B596
$A2:B585 9D A8 0F    STA $0FA8,x[$7E:1128]
$A2:B588 A9 11 00    LDA #$0011             ;\
$A2:B58B 8D E5 05    STA $05E5  [$7E:05E5]  ;} Random number = 11h
$A2:B58E 6B          RTL
}


;;; $B58F: Main AI - enemy $D1FF (lavaquake rocks) ;;;
{
$A2:B58F AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B592 FC A8 0F    JSR ($0FA8,x)[$A2:B596]
$A2:B595 6B          RTL
}


;;; $B596:  ;;;
{
$A2:B596 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B599 A9 40 00    LDA #$0040
$A2:B59C 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:B5A0 F0 0F       BEQ $0F    [$B5B1]
$A2:B5A2 A9 40 00    LDA #$0040
$A2:B5A5 22 ED AE A0 JSL $A0AEED[$A0:AEED]
$A2:B5A9 F0 06       BEQ $06    [$B5B1]
$A2:B5AB A9 B2 B5    LDA #$B5B2
$A2:B5AE 9D A8 0F    STA $0FA8,x[$7E:11E8]

$A2:B5B1 60          RTS
}


;;; $B5B2:  ;;;
{
$A2:B5B2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B5B5 22 11 81 80 JSL $808111[$80:8111]
$A2:B5B9 29 1E 00    AND #$001E
$A2:B5BC A8          TAY
$A2:B5BD B9 50 B5    LDA $B550,y[$A2:B56A]
$A2:B5C0 8D 95 19    STA $1995  [$7E:1995]
$A2:B5C3 22 11 81 80 JSL $808111[$80:8111]
$A2:B5C7 29 1E 00    AND #$001E
$A2:B5CA A8          TAY
$A2:B5CB B9 30 B5    LDA $B530,y[$A2:B548]
$A2:B5CE A0 5A BD    LDY #$BD5A             ;\
$A2:B5D1 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Norfair lavaquake rocks enemy projectile
$A2:B5D5 A9 EA B5    LDA #$B5EA
$A2:B5D8 9D A8 0F    STA $0FA8,x[$7E:11E8]
$A2:B5DB 22 11 81 80 JSL $808111[$80:8111]
$A2:B5DF 29 0E 00    AND #$000E
$A2:B5E2 A8          TAY
$A2:B5E3 B9 20 B5    LDA $B520,y[$A2:B528]
$A2:B5E6 9D AA 0F    STA $0FAA,x[$7E:11EA]
$A2:B5E9 60          RTS
}


;;; $B5EA:  ;;;
{
$A2:B5EA AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B5ED DE AA 0F    DEC $0FAA,x[$7E:11EA]
$A2:B5F0 10 06       BPL $06    [$B5F8]
$A2:B5F2 A9 96 B5    LDA #$B596
$A2:B5F5 9D A8 0F    STA $0FA8,x[$7E:11E8]

$A2:B5F8 60          RTS
}


;;; $B5F9: RTL ;;;
{
$A2:B5F9 6B          RTL
}


;;; $B5FA: RTL ;;;
{
$A2:B5FA 6B          RTL
}


;;; $B5FB: Spritemap - lavaquake rocks ;;;
{
$A2:B5FB             dx 0001, 01FC,FC,210A
}
}


;;; $B602..BA5A: Rinka ;;;
{
;;; $B602: Initialisation AI - enemy $D23F (rinka) ;;;
{
$A2:B602 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B605 BD B4 0F    LDA $0FB4,x[$7E:10B4]  ;\
$A2:B608 F0 20       BEQ $20    [$B62A]     ;} If [enemy parameter 1] != 0 (Mother Brain's room):
$A2:B60A 20 9B B6    JSR $B69B  [$A2:B69B]  ; Spawn Mother Brain's room rinka
$A2:B60D AF 3A 78 7E LDA $7E783A[$7E:783A]  ; >_<;
$A2:B611 BD 86 0F    LDA $0F86,x[$7E:1046]  ;\
$A2:B614 09 00 2C    ORA #$2C00             ;|
$A2:B617 29 FF BF    AND #$BFFF             ;} Set enemy to not respawn if killed, process instructions, process whilst off-screen, and as tangible
$A2:B61A 9D 86 0F    STA $0F86,x[$7E:1046]  ;/
$A2:B61D 80 17       BRA $17    [$B636]
$A2:B61F BD 86 0F    LDA $0F86,x
$A2:B622 09 00 2C    ORA #$2C00
$A2:B625 9D 86 0F    STA $0F86,x
$A2:B628 80 0C       BRA $0C    [$B636]

$A2:B62A BD 86 0F    LDA $0F86,x[$7E:1086]  ;\ Else ([enemy parameter 1] = 0):
$A2:B62D 09 00 64    ORA #$6400             ;|
$A2:B630 29 FF F7    AND #$F7FF             ;} Set enemy to respawn if killed, process instructions, to not process whilst off-screen, and as tangible
$A2:B633 9D 86 0F    STA $0F86,x[$7E:1086]  ;/

$A2:B636 A9 00 04    LDA #$0400             ;\
$A2:B639 9D 96 0F    STA $0F96,x[$7E:1096]  ;} Enemy palette index = 400h (palette 2)
$A2:B63C 80 16       BRA $16    [$B654]     ; Go to reset rinka
}


;;; $B63E: Respawn rinka ;;;
{
$A2:B63E BD B4 0F    LDA $0FB4,x[$7E:1134]  ;\
$A2:B641 F0 03       BEQ $03    [$B646]     ;} If [enemy parameter 1] != 0 (Mother Brain's room):
$A2:B643 20 9B B6    JSR $B69B  [$A2:B69B]  ; Spawn Mother Brain's room rinka

$A2:B646 BF 20 70 7E LDA $7E7020,x[$7E:71A0];\
$A2:B64A 9D 7A 0F    STA $0F7A,x[$7E:10FA]  ;} Enemy X position = [enemy spawn X position]
$A2:B64D BF 22 70 7E LDA $7E7022,x[$7E:71A2];\
$A2:B651 9D 7E 0F    STA $0F7E,x[$7E:10FE]  ;} Enemy Y position = [enemy spawn Y position]
}


;;; $B654: Reset rinka ;;;
{
$A2:B654 A9 52 B8    LDA #$B852             ;\
$A2:B657 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Enemy function = $B852
$A2:B65A A9 1A 00    LDA #$001A             ;\
$A2:B65D 9D B2 0F    STA $0FB2,x[$7E:10B2]  ;} Enemy function timer = 1Ah
$A2:B660 9E AA 0F    STZ $0FAA,x[$7E:10AA]  ; Enemy X velocity = 0
$A2:B663 9E AC 0F    STZ $0FAC,x[$7E:10AC]  ; Enemy Y velocity = 0
$A2:B666 BD B4 0F    LDA $0FB4,x[$7E:10B4]  ;\
$A2:B669 D0 10       BNE $10    [$B67B]     ;} If [enemy parameter 1] = 0 (not Mother Brain's room):
$A2:B66B A9 E0 B9    LDA #$B9E0             ;\
$A2:B66E 9D 92 0F    STA $0F92,x[$7E:1092]  ;} Enemy instruction list pointer = $B9E0
$A2:B671 A9 01 00    LDA #$0001             ;\
$A2:B674 9D 94 0F    STA $0F94,x[$7E:1094]  ;} Enemy instruction timer = 1
$A2:B677 9E 90 0F    STZ $0F90,x[$7E:1090]  ; Enemy timer = 0
$A2:B67A 6B          RTL                    ; Return

$A2:B67B AF 3A 78 7E LDA $7E783A[$7E:783A]  ;\
$A2:B67F F0 0A       BEQ $0A    [$B68B]     ;} If turrets and rinkas are flagged for deletion:
$A2:B681 BD 86 0F    LDA $0F86,x            ;\
$A2:B684 09 00 02    ORA #$0200             ;} Flag enemy for deletion
$A2:B687 9D 86 0F    STA $0F86,x            ;/
$A2:B68A 6B          RTL                    ; Return

$A2:B68B A9 0C BA    LDA #$BA0C             ;\
$A2:B68E 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $BA0C
$A2:B691 A9 01 00    LDA #$0001             ;\
$A2:B694 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Enemy instruction timer = 1
$A2:B697 9E 90 0F    STZ $0F90,x[$7E:1050]  ; Enemy timer = 0
$A2:B69A 6B          RTL
}


;;; $B69B: Spawn Mother Brain's room rinka ;;;
{
; Spawn a rinka to one of the predefined spawn points in the room that's currently available
; The spawn point is selected as follows:
;     If it's on screen, the spawn point the rinka was previously spawned from
;     Otherwise, any on screen spawn point
;     Otherwise, any spawn point
$A2:B69B BF 20 70 7E LDA $7E7020,x[$7E:70E0];\
$A2:B69F 85 12       STA $12    [$7E:0012]  ;|
$A2:B6A1 BF 22 70 7E LDA $7E7022,x[$7E:70E2];|
$A2:B6A5 85 14       STA $14    [$7E:0014]  ;} If enemy spawn position is on screen:
$A2:B6A7 22 FF B8 A2 JSL $A2B8FF[$A2:B8FF]  ;|
$A2:B6AB B0 1D       BCS $1D    [$B6CA]     ;/
$A2:B6AD 20 9D B7    JSR $B79D  [$A2:B79D]  ; Get availability index of enemy spawn position
$A2:B6B0 A8          TAY                    ; Y = [A]
$A2:B6B1 DA          PHX                    ;\
$A2:B6B2 AA          TAX                    ;|
$A2:B6B3 BF FE 87 7E LDA $7E87FE,x[$7E:8804];|
$A2:B6B7 4A          LSR A                  ;} If [$7E:8800 + [Y] - 2] & 1 = 0 (available):
$A2:B6B8 FA          PLX                    ;|
$A2:B6B9 B0 0F       BCS $0F    [$B6CA]     ;/
$A2:B6BB 98          TYA                    ;\
$A2:B6BC 9D AE 0F    STA $0FAE,x[$7E:106E]  ;} Enemy spawn point availability table index = [Y]
$A2:B6BF DA          PHX                    ;\
$A2:B6C0 AA          TAX                    ;|
$A2:B6C1 A9 FF FF    LDA #$FFFF             ;} $7E:8800 + [Y] - 2 = FFFFh (unavailable)
$A2:B6C4 9F FE 87 7E STA $7E87FE,x[$7E:8806];|
$A2:B6C8 FA          PLX                    ;/
$A2:B6C9 60          RTS                    ; Return

$A2:B6CA A0 00 00    LDY #$0000             ; Y = 0

; LOOP_ON_SCREEN
$A2:B6CD B9 5B B7    LDA $B75B,y[$A2:B75B]  ;\
$A2:B6D0 85 12       STA $12    [$7E:0012]  ;|
$A2:B6D2 B9 5D B7    LDA $B75D,y[$A2:B75D]  ;|
$A2:B6D5 85 14       STA $14    [$7E:0014]  ;} If ([$B75B + [Y]], [$B75B + [Y] + 2]) is on screen:
$A2:B6D7 22 FF B8 A2 JSL $A2B8FF[$A2:B8FF]  ;|
$A2:B6DB B0 0C       BCS $0C    [$B6E9]     ;/
$A2:B6DD DA          PHX                    ;\
$A2:B6DE BE 5F B7    LDX $B75F,y[$A2:B75F]  ;|
$A2:B6E1 BF FE 87 7E LDA $7E87FE,x[$7E:8800];|
$A2:B6E5 4A          LSR A                  ;} If [$7E:8800 + [$B75B + [Y] + 4] - 2] & 1 = 0 (available): go to BRANCH_FOUND
$A2:B6E6 FA          PLX                    ;|
$A2:B6E7 90 0F       BCC $0F    [$B6F8]     ;/

$A2:B6E9 C8          INY                    ;\
$A2:B6EA C8          INY                    ;|
$A2:B6EB C8          INY                    ;|
$A2:B6EC C8          INY                    ;} Y += 6
$A2:B6ED C8          INY                    ;|
$A2:B6EE C8          INY                    ;/
$A2:B6EF C0 42 00    CPY #$0042             ;\
$A2:B6F2 30 D9       BMI $D9    [$B6CD]     ;} If [Y] < 42h: go to LOOP_ON_SCREEN
$A2:B6F4 4C 1B B7    JMP $B71B  [$A2:B71B]  ; Go to BRANCH_NOT_FOUND
$A2:B6F7 60          RTS                    ; >_<;

; BRANCH_FOUND
$A2:B6F8 A5 12       LDA $12    [$7E:0012]  ;\
$A2:B6FA 9F 20 70 7E STA $7E7020,x[$7E:70E0];} Enemy X position = enemy spawn X position = [$B75B + [Y]]
$A2:B6FE 9D 7A 0F    STA $0F7A,x[$7E:103A]  ;/
$A2:B701 A5 14       LDA $14    [$7E:0014]  ;\
$A2:B703 9F 22 70 7E STA $7E7022,x[$7E:70E2];} Enemy Y position = enemy spawn Y position = [$B75B + [Y] + 2]
$A2:B707 9D 7E 0F    STA $0F7E,x[$7E:103E]  ;/
$A2:B70A DA          PHX                    ;\
$A2:B70B BE 5F B7    LDX $B75F,y[$A2:B75F]  ;|
$A2:B70E A9 FF FF    LDA #$FFFF             ;|
$A2:B711 9F FE 87 7E STA $7E87FE,x[$7E:8800];} $7E:8800 + [$B75B + [Y] + 4] - 2 = FFFFh (unavailable)
$A2:B715 8A          TXA                    ;|
$A2:B716 FA          PLX                    ;/
$A2:B717 9D AE 0F    STA $0FAE,x[$7E:106E]  ; Enemy spawn point availability table index = [$B75B + [Y] + 4]
$A2:B71A 60          RTS                    ; Return

; BRANCH_NOT_FOUND
$A2:B71B A0 00 00    LDY #$0000             ; Y = 0

; LOOP_ANY
$A2:B71E DA          PHX                    ;\
$A2:B71F BE 5F B7    LDX $B75F,y[$A2:B75F]  ;|
$A2:B722 BF FE 87 7E LDA $7E87FE,x[$7E:8800];|
$A2:B726 FA          PLX                    ;} If [$7E:8800 + [$B75B + [Y] + 4] - 2] & 1 != 0 (unavailable):
$A2:B727 4A          LSR A                  ;|
$A2:B728 90 0C       BCC $0C    [$B736]     ;/
$A2:B72A C8          INY                    ;\
$A2:B72B C8          INY                    ;|
$A2:B72C C8          INY                    ;|
$A2:B72D C8          INY                    ;} Y += 6
$A2:B72E C8          INY                    ;|
$A2:B72F C8          INY                    ;/
$A2:B730 C0 42 00    CPY #$0042             ;\
$A2:B733 30 E9       BMI $E9    [$B71E]     ;} If [Y] < 42h: go to LOOP_ANY
$A2:B735 60          RTS                    ; Return

$A2:B736 B9 5B B7    LDA $B75B,y[$A2:B767]  ;\
$A2:B739 9F 20 70 7E STA $7E7020,x[$7E:7160];} Enemy X position = enemy spawn X position = [$B75B + [Y]]
$A2:B73D 9D 7A 0F    STA $0F7A,x[$7E:10BA]  ;/
$A2:B740 B9 5D B7    LDA $B75D,y[$A2:B769]  ;\
$A2:B743 9F 22 70 7E STA $7E7022,x[$7E:7162];} Enemy Y position = enemy spawn Y position = [$B75B + [Y] + 2]
$A2:B747 9D 7E 0F    STA $0F7E,x[$7E:10BE]  ;/
$A2:B74A B9 5F B7    LDA $B75F,y[$A2:B76B]  ;\
$A2:B74D 9D AE 0F    STA $0FAE,x[$7E:10EE]  ;} Enemy spawn point availability table index = [$B75B + [Y] + 4]
$A2:B750 DA          PHX                    ;\
$A2:B751 AA          TAX                    ;|
$A2:B752 A9 FF FF    LDA #$FFFF             ;} $7E:8800 + [$B75B + [Y] + 4] - 2 = FFFFh (unavailable)
$A2:B755 9F FE 87 7E STA $7E87FE,x[$7E:8804];|
$A2:B759 FA          PLX                    ;/
$A2:B75A 60          RTS
}


;;; $B75B: Mother Brain's room rinka spawn data ;;;
{
;                        _____________ X position
;                       |     ________ Y position
;                       |    |     ___ Index into spawn point availability table + 2
;                       |    |    |
$A2:B75B             dw 03E7,0026,0002,
                        03E7,00A6,0004,
                        0337,0036,0006,
                        0337,00A6,0008,
                        0277,001C,000A,
                        0277,00B6,000C,
                        01B7,0036,000E,
                        01B7,00A6,0010,
                        00F7,001C,0012,
                        00F7,00B6,0014,
                        0080,00A8,0016
}


;;; $B79D: Get availability index of enemy spawn position ;;;
{
$A2:B79D A0 00 00    LDY #$0000             ; Y = 0

; LOOP
$A2:B7A0 B9 5B B7    LDA $B75B,y[$A2:B75B]  ;\
$A2:B7A3 DF 20 70 7E CMP $7E7020,x[$7E:7160];} If [$B75B + [Y]] = [enemy spawn X position]:
$A2:B7A7 D0 09       BNE $09    [$B7B2]     ;/
$A2:B7A9 B9 5D B7    LDA $B75D,y[$A2:B769]  ;\
$A2:B7AC DF 22 70 7E CMP $7E7022,x[$7E:7162];} If [$B75B + [Y] + 2] = [enemy spawn Y position]: go to BRANCH_FOUND
$A2:B7B0 F0 0E       BEQ $0E    [$B7C0]     ;/

$A2:B7B2 98          TYA                    ;\
$A2:B7B3 18          CLC                    ;|
$A2:B7B4 69 06 00    ADC #$0006             ;} Y += 6
$A2:B7B7 A8          TAY                    ;/
$A2:B7B8 C9 42 00    CMP #$0042             ;\
$A2:B7BB 30 E3       BMI $E3    [$B7A0]     ;} If [Y] < 42h: go to LOOP
$A2:B7BD A0 00 00    LDY #$0000             ; Y = 0

; BRANCH_FOUND
$A2:B7C0 B9 5F B7    LDA $B75F,y[$A2:B76B]  ; A = [$B75B + [Y] + 4]
$A2:B7C3 60          RTS
}


;;; $B7C4: Main AI - enemy $D23F (rinka) ;;;
{
$A2:B7C4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:B7C7 BD B4 0F    LDA $0FB4,x[$7E:1134]  ;\
$A2:B7CA F0 10       BEQ $10    [$B7DC]     ;} If [enemy parameter 1] != 0 (Mother Brain's room):
$A2:B7CC AF 3A 78 7E LDA $7E783A[$7E:783A]  ;\
$A2:B7D0 F0 0A       BEQ $0A    [$B7DC]     ;} If turrets and rinkas are flagged for deletion:
$A2:B7D2 20 80 B8    JSR $B880  [$A2:B880]  ; Decrement rinka counter
$A2:B7D5 20 BB B8    JSR $B8BB  [$A2:B8BB]  ; Mark rinka spawn point available
$A2:B7D8 5C 10 A4 A0 JMP $A0A410[$A0:A410]  ; Rinka's death animation

$A2:B7DC 7C A8 0F    JMP ($0FA8,x)[$A2:B852]; Go to [enemy function]
}


;;; $B7DF: Rinka function - fire ;;;
{
$A2:B7DF DE B2 0F    DEC $0FB2,x[$7E:1132]  ; Decrement enemy function timer
$A2:B7E2 10 5F       BPL $5F    [$B843]     ; If [enemy function timer] >= 0: return
$A2:B7E4 A9 5B B8    LDA #$B85B             ;\
$A2:B7E7 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Enemy function = $B85B
$A2:B7EA BD B4 0F    LDA $0FB4,x[$7E:1134]  ;\
$A2:B7ED F0 0B       BEQ $0B    [$B7FA]     ;} If [enemy parameter 1] != 0 (Mother Brain's room):
$A2:B7EF BD 86 0F    LDA $0F86,x[$7E:1046]  ;\
$A2:B7F2 29 FF FB    AND #$FBFF             ;} Set enemy as tangible
$A2:B7F5 9D 86 0F    STA $0F86,x[$7E:1046]  ;/
$A2:B7F8 80 0C       BRA $0C    [$B806]

$A2:B7FA BD 86 0F    LDA $0F86,x[$7E:1106]  ;\ Else (not Mother Brain's room):
$A2:B7FD 09 00 08    ORA #$0800             ;|
$A2:B800 29 FF FB    AND #$FBFF             ;} Set to process whilst off-screen and enemy as tangible
$A2:B803 9D 86 0F    STA $0F86,x[$7E:1106]  ;/

$A2:B806 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A2:B809 38          SEC                    ;|
$A2:B80A FD 7A 0F    SBC $0F7A,x[$7E:10FA]  ;|
$A2:B80D 85 12       STA $12    [$7E:0012]  ;|
$A2:B80F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} A = angle from enemy to Samus
$A2:B812 38          SEC                    ;|
$A2:B813 FD 7E 0F    SBC $0F7E,x[$7E:10FE]  ;|
$A2:B816 85 14       STA $14    [$7E:0014]  ;|
$A2:B818 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A2:B81C 38          SEC                    ;\
$A2:B81D E9 80 00    SBC #$0080             ;|
$A2:B820 49 FF FF    EOR #$FFFF             ;|
$A2:B823 1A          INC A                  ;} $12 = (80h - [A]) % 100h (invert the sign of the sin, leaving the sign of cos unaffected)
$A2:B824 29 FF 00    AND #$00FF             ;|
$A2:B827 85 12       STA $12    [$7E:0012]  ;/
$A2:B829 A9 20 01    LDA #$0120             ;\
$A2:B82C 22 6C C2 86 JSL $86C26C[$86:C26C]  ;|
$A2:B830 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Enemy X velocity = 120h * sin([$12] * pi / 80h)
$A2:B833 9D AA 0F    STA $0FAA,x[$7E:112A]  ;/
$A2:B836 A9 20 01    LDA #$0120             ;\
$A2:B839 22 72 C2 86 JSL $86C272[$86:C272]  ;|
$A2:B83D AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Enemy Y velocity = 120h * cos([$12] * pi / 80h)
$A2:B840 9D AC 0F    STA $0FAC,x[$7E:112C]  ;/

$A2:B843 6B          RTL
}


;;; $B844: Rinka function - killed ;;;
{
$A2:B844 DE B2 0F    DEC $0FB2,x[$7E:10F2]  ; Decrement enemy function timer
$A2:B847 10 FA       BPL $FA    [$B843]     ; If [enemy function timer] >= 0: return
$A2:B849 A9 0A 00    LDA #$000A             ;\
$A2:B84C 9D 8C 0F    STA $0F8C,x[$7E:10CC]  ;} Enemy health = Ah
$A2:B84F 4C 3E B6    JMP $B63E  [$A2:B63E]  ; Go to respawn rinka
}


;;; $B852: Rinka function - waiting to fire ;;;
{
$A2:B852 22 D3 B8 A2 JSL $A2B8D3[$A2:B8D3]  ;\
$A2:B856 90 EB       BCC $EB    [$B843]     ;} If enemy is on screen: return
$A2:B858 4C 65 B8    JMP $B865  [$A2:B865]  ; Go to delete and respawn rinkas
}


;;; $B85B: Rinka function - moving ;;;
{
$A2:B85B 22 EF C3 A9 JSL $A9C3EF[$A9:C3EF]  ; Move enemy according to enemy velocity
$A2:B85F 22 D3 B8 A2 JSL $A2B8D3[$A2:B8D3]  ;\
$A2:B863 90 DE       BCC $DE    [$B843]     ;} If enemy is on screen: return
}


;;; $B865: Delete and respawn rinka ;;;
{
$A2:B865 BD B4 0F    LDA $0FB4,x[$7E:1134]  ;\
$A2:B868 F0 10       BEQ $10    [$B87A]     ;} If [enemy parameter 1] != 0 (Mother Brain's room):
$A2:B86A 20 BB B8    JSR $B8BB  [$A2:B8BB]  ; Mark rinka spawn point available
$A2:B86D AF 3A 78 7E LDA $7E783A[$7E:783A]  ;\
$A2:B871 F0 07       BEQ $07    [$B87A]     ;} If turrets and rinkas are flagged for deletion:
$A2:B873 20 80 B8    JSR $B880  [$A2:B880]  ; Decrement rinka counter
$A2:B876 5C 2B 92 A0 JML $A0922B[$A0:922B]  ; Go to delete enemy and any connected enemies

$A2:B87A 20 80 B8    JSR $B880  [$A2:B880]  ; Decrement rinka counter
$A2:B87D 4C 3E B6    JMP $B63E  [$A2:B63E]  ; Go to respawn rinka
}


;;; $B880: Decrement rinka counter ;;;
{
$A2:B880 BD B4 0F    LDA $0FB4,x[$7E:1134]  ;\
$A2:B883 F0 16       BEQ $16    [$B89B]     ;} If [enemy parameter 1] != 0 (Mother Brain's room):
$A2:B885 BD 86 0F    LDA $0F86,x[$7E:1046]  ;\
$A2:B888 29 00 01    AND #$0100             ;} If enemy is visible:
$A2:B88B D0 0E       BNE $0E    [$B89B]     ;/
$A2:B88D AF 3C 78 7E LDA $7E783C[$7E:783C]  ;\
$A2:B891 3A          DEC A                  ;|
$A2:B892 10 03       BPL $03    [$B897]     ;|
$A2:B894 A9 00 00    LDA #$0000             ;} Rinka counter = max(0, [rinka counter] - 1)
                                            ;|
$A2:B897 8F 3C 78 7E STA $7E783C[$7E:783C]  ;/

$A2:B89B 60          RTS
}


;;; $B89C: Unused ;;;
{
$A2:B89C AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A2:B89F 29 03 00    AND #$0003             ;|
$A2:B8A2 DD B4 0F    CMP $0FB4,x            ;} If [number of times main enemy routine has been executed] % 4 = [enemy parameter 1]:
$A2:B8A5 D0 0A       BNE $0A    [$B8B1]     ;/
$A2:B8A7 BD 86 0F    LDA $0F86,x            ;\
$A2:B8AA 29 FF FB    AND #$FBFF             ;} Set enemy as tangible
$A2:B8AD 9D 86 0F    STA $0F86,x            ;/
$A2:B8B0 60          RTS                    ; Return

$A2:B8B1 BD 86 0F    LDA $0F86,x            ;\
$A2:B8B4 09 00 04    ORA #$0400             ;} Set enemy as intangible
$A2:B8B7 9D 86 0F    STA $0F86,x            ;/
$A2:B8BA 60          RTS
}


;;; $B8BB: Mark rinka spawn point available ;;;
{
$A2:B8BB BD B4 0F    LDA $0FB4,x[$7E:10F4]  ;\
$A2:B8BE F0 12       BEQ $12    [$B8D2]     ;} If [enemy parameter 1] != 0 (Mother Brain's room):
$A2:B8C0 BD AE 0F    LDA $0FAE,x[$7E:106E]  ;\
$A2:B8C3 F0 0D       BEQ $0D    [$B8D2]     ;} If [enemy spawn point availability table index] != 0:
$A2:B8C5 DA          PHX                    ;\
$A2:B8C6 AA          TAX                    ;|
$A2:B8C7 A9 00 00    LDA #$0000             ;} $7E:8800 + [enemy spawn point availability table index] - 2 = 0
$A2:B8CA 9F FE 87 7E STA $7E87FE,x[$7E:8800];|
$A2:B8CE FA          PLX                    ;/
$A2:B8CF 9D AE 0F    STA $0FAE,x[$7E:106E]  ; Enemy spawn point availability table index = 0

$A2:B8D2 60          RTS
}


;;; $B8D3: Check if rinka is on screen ;;;
{
;; Returns:
;;     Carry: Clear if rinka is on screen, set otherwise
$A2:B8D3 BD 7E 0F    LDA $0F7E,x[$7E:10FE]  ;\
$A2:B8D6 30 25       BMI $25    [$B8FD]     ;} If [enemy Y position] >= 0:
$A2:B8D8 18          CLC                    ;\
$A2:B8D9 69 10 00    ADC #$0010             ;|
$A2:B8DC 38          SEC                    ;|
$A2:B8DD ED 15 09    SBC $0915  [$7E:0915]  ;} If -10h <= [enemy Y position] - [layer 1 Y position] < F0h:
$A2:B8E0 30 1B       BMI $1B    [$B8FD]     ;|
$A2:B8E2 C9 00 01    CMP #$0100             ;|
$A2:B8E5 10 16       BPL $16    [$B8FD]     ;/
$A2:B8E7 BD 7A 0F    LDA $0F7A,x[$7E:10FA]  ;\
$A2:B8EA 30 11       BMI $11    [$B8FD]     ;} If [enemy X position] >= 0:
$A2:B8EC 18          CLC                    ;\
$A2:B8ED 69 10 00    ADC #$0010             ;|
$A2:B8F0 38          SEC                    ;|
$A2:B8F1 ED 11 09    SBC $0911  [$7E:0911]  ;} If -10h <= [enemy X position] - [layer 1 X position] < 110h:
$A2:B8F4 30 07       BMI $07    [$B8FD]     ;|
$A2:B8F6 C9 20 01    CMP #$0120             ;|
$A2:B8F9 10 02       BPL $02    [$B8FD]     ;/
$A2:B8FB 18          CLC                    ;\
$A2:B8FC 6B          RTL                    ;} Return carry clear

$A2:B8FD 38          SEC                    ;\
$A2:B8FE 6B          RTL                    ;} Return carry set
}


;;; $B8FF: Check if position is on screen ;;;
{
;; Parameters:
;;     $12: X position
;;     $14: Y position
;; Returns:
;;     Carry: Clear if position is on screen, set otherwise
$A2:B8FF A5 14       LDA $14    [$7E:0014]  ;\
$A2:B901 30 24       BMI $24    [$B927]     ;} If [Y position] >= 0:
$A2:B903 18          CLC                    ;\
$A2:B904 69 00 00    ADC #$0000             ;} >_<;
$A2:B907 38          SEC                    ;\
$A2:B908 ED 15 09    SBC $0915  [$7E:0915]  ;|
$A2:B90B 30 1A       BMI $1A    [$B927]     ;} If 0 <= [Y position] - [layer 1 Y position] < E0h:
$A2:B90D C9 E0 00    CMP #$00E0             ;|
$A2:B910 10 15       BPL $15    [$B927]     ;/
$A2:B912 A5 12       LDA $12    [$7E:0012]  ;\
$A2:B914 30 11       BMI $11    [$B927]     ;} If [X position] >= 0:
$A2:B916 18          CLC                    ;\
$A2:B917 69 00 00    ADC #$0000             ;} >_<;
$A2:B91A 38          SEC                    ;\
$A2:B91B ED 11 09    SBC $0911  [$7E:0911]  ;|
$A2:B91E 30 07       BMI $07    [$B927]     ;} If 0 <= [X position] - [layer 1 X position] < 100h:
$A2:B920 C9 00 01    CMP #$0100             ;|
$A2:B923 10 02       BPL $02    [$B927]     ;/
$A2:B925 18          CLC                    ;\
$A2:B926 6B          RTL                    ;} Return carry clear

$A2:B927 38          SEC                    ;\
$A2:B928 6B          RTL                    ;} Return carry set
}


;;; $B929: Frozen AI - enemy $D23F (rinka) ;;;
{
$A2:B929 22 D3 B8 A2 JSL $A2B8D3[$A2:B8D3]  ;\
$A2:B92D 90 03       BCC $03    [$B932]     ;} If rinka is off-screen:
$A2:B92F 9E 9E 0F    STZ $0F9E,x[$7E:10DE]  ; Enemy frozen timer = 0

$A2:B932 22 7E 95 A0 JSL $A0957E[$A0:957E]  ; Normal enemy frozen AI
$A2:B936 AF 3A 78 7E LDA $7E783A[$7E:783A]  ;\
$A2:B93A D0 01       BNE $01    [$B93D]     ;} If turrets and rinkas are not flagged for deletion:
$A2:B93C 6B          RTL                    ; Return

$A2:B93D 20 80 B8    JSR $B880  [$A2:B880]  ; Decrement rinka counter
$A2:B940 20 BB B8    JSR $B8BB  [$A2:B8BB]  ; Mark rinka spawn point available
$A2:B943 5C 10 A4 A0 JML $A0A410[$A0:A410]  ; Go to rinka's death animation
}


;;; $B947: Enemy touch - enemy $D23F (rinka) ;;;
{
$A2:B947 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal enemy touch AI - no death check
$A2:B94B 80 13       BRA $13    [$B960]     ; Go to rinka shared contact reaction
}


;;; $B94D: Enemy shot - enemy $D23F (rinka) ;;;
{
$A2:B94D 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A2:B951 80 0D       BRA $0D    [$B960]     ; Go to rinka shared contact reaction
}


;;; $B953: Power bomb reaction - enemy $D23F (rinka) ;;;
{
$A2:B953 BD 86 0F    LDA $0F86,x[$7E:10C6]  ;\
$A2:B956 29 00 01    AND #$0100             ;} If enemy is invisible:
$A2:B959 F0 01       BEQ $01    [$B95C]     ;/
$A2:B95B 6B          RTL                    ; Return

$A2:B95C 22 B7 A5 A0 JSL $A0A5B7[$A0:A5B7]  ; Normal enemy power bomb AI - no death check
}


;;; $B960: Rinka shared contact reaction ;;;
{
$A2:B960 BD 8C 0F    LDA $0F8C,x[$7E:10CC]  ;\
$A2:B963 F0 01       BEQ $01    [$B966]     ;} If [enemy health] != 0:
$A2:B965 6B          RTL                    ; Return

$A2:B966 20 80 B8    JSR $B880  [$A2:B880]  ; Decrement rinka counter
$A2:B969 20 BB B8    JSR $B8BB  [$A2:B8BB]  ; Mark rinka spawn point available
$A2:B96C BD B4 0F    LDA $0FB4,x[$7E:10F4]  ;\
$A2:B96F D0 07       BNE $07    [$B978]     ;} If [enemy parameter 1] = 0 (not Mother Brain's room):
$A2:B971 A9 00 00    LDA #$0000             ; A = 0
$A2:B974 5C 10 A4 A0 JMP $A0A410[$A0:A410]  ; Go to rinka death

$A2:B978 BD 86 0F    LDA $0F86,x[$7E:10C6]  ;\
$A2:B97B 09 00 05    ORA #$0500             ;} Set enemy as intangible and invisible
$A2:B97E 9D 86 0F    STA $0F86,x[$7E:10C6]  ;/
$A2:B981 BD 7A 0F    LDA $0F7A,x[$7E:10BA]  ;\
$A2:B984 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$A2:B986 BD 7E 0F    LDA $0F7E,x[$7E:10BE]  ;\
$A2:B989 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$A2:B98B A0 09 E5    LDY #$E509
$A2:B98E A9 03 00    LDA #$0003             ; A = 3 (small explosion)
$A2:B991 22 97 80 86 JSL $868097[$86:8097]  ; Spawn dust cloud / explosion enemy projectile
$A2:B995 A9 44 B8    LDA #$B844             ;\
$A2:B998 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy function = $B844
$A2:B99B A9 01 00    LDA #$0001             ;\
$A2:B99E 9D B2 0F    STA $0FB2,x[$7E:10F2]  ;} Enemy $0FB2 = 1
$A2:B9A1 6B          RTL
}


;;; $B9A2: Unused. Instruction - go to [[Y]] if [rinka counter] >= 3 ;;;
{
$A2:B9A2 AF 3C 78 7E LDA $7E783C[$7E:783C]
$A2:B9A6 C9 03 00    CMP #$0003
$A2:B9A9 10 03       BPL $03    [$B9AE]
$A2:B9AB C8          INY
$A2:B9AC C8          INY
$A2:B9AD 6B          RTL

$A2:B9AE B9 00 00    LDA $0000,y
$A2:B9B1 A8          TAY
$A2:B9B2 6B          RTL
}


;;; $B9B3: Instruction - set enemy as intangible and invisible ;;;
{
$A2:B9B3 BD 86 0F    LDA $0F86,x[$7E:1106]
$A2:B9B6 09 00 05    ORA #$0500
$A2:B9B9 9D 86 0F    STA $0F86,x[$7E:1106]
$A2:B9BC 6B          RTL
}


;;; $B9BD: Instruction - set enemy as intangible, invisible and active off-screen ;;;
{
$A2:B9BD BD 86 0F    LDA $0F86,x[$7E:1046]
$A2:B9C0 09 00 0D    ORA #$0D00
$A2:B9C3 9D 86 0F    STA $0F86,x[$7E:1046]
$A2:B9C6 6B          RTL
}


;;; $B9C7: Instruction - fire rinka ;;;
{
$A2:B9C7 BD 86 0F    LDA $0F86,x[$7E:1106]  ;\
$A2:B9CA 29 FF FA    AND #$FAFF             ;} Set enemy as tangible and visible
$A2:B9CD 9D 86 0F    STA $0F86,x[$7E:1106]  ;/
$A2:B9D0 A9 DF B7    LDA #$B7DF             ;\
$A2:B9D3 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Enemy function = $B7DF
$A2:B9D6 AF 3C 78 7E LDA $7E783C[$7E:783C]  ;\
$A2:B9DA 1A          INC A                  ;} Increment rinka counter
$A2:B9DB 8F 3C 78 7E STA $7E783C[$7E:783C]  ;/
$A2:B9DF 6B          RTL
}


;;; $B9E0: Instruction list - not Mother Brain's room ;;;
{
$A2:B9E0             dw B9B3,       ; Set enemy as intangible and invisible
                        0040,BA38,
                        B9C7        ; Fire rinka
$A2:B9E8             dw 0010,BA38,
                        0008,BA3F,
                        0007,BA46,
                        0006,BA4D,
                        0005,BA54,
                        0006,BA4D,
                        0007,BA46,
                        0008,BA3F,
                        80ED,B9E8   ; Go to $B9E8
}


;;; $BA0C: Instruction list - Mother Brain's room ;;;
{
$A2:BA0C             dw B9BD,       ; Set enemy as intangible, invisible and active off-screen
                        0040,BA38,
                        B9C7        ; Fire rinka
$A2:BA14             dw 0010,BA38,
                        0008,BA3F,
                        0007,BA46,
                        0006,BA4D,
                        0005,BA54,
                        0006,BA4D,
                        0007,BA46,
                        0008,BA3F,
                        80ED,BA14   ; Go to $BA14
}


;;; $BA38: Spritemaps - rinka ;;;
{
$A2:BA38             dx 0001, C3F8,F8,3100
$A2:BA3F             dx 0001, C3F8,F8,3102
$A2:BA46             dx 0001, C3F8,F8,3104
$A2:BA4D             dx 0001, C3F8,F8,3106
$A2:BA54             dx 0001, C3F8,F8,3108
}
}


;;; $BA5B: Palette - enemy $D1FF/$D23F (lavaquake rocks / rinka) ;;;
{
$A2:BA5B             dw 3800, 5739, 4273, 2DAD, 14C6, 19DA, 1174, 0D0F, 08AA, 0FDE, 02DF, 019F, 005F, 0037, 6FDF, 0006
}


;;; $BA7B..BE1B: Rio ;;;
{
;;; $BA7B: Palette - enemy $D27F (rio) ;;;
{
$A2:BA7B             dw 3800, 2FFF, 1AF7, 014A, 0063, 275A, 0EB5, 0210, 01CE, 03E0, 02E0, 0200, 0100, 7F00, 6DE0, 54E0
}


;;; $BA9B..BBCC: Instruction lists - rio ;;;
{
;;; $BA9B: Instruction list -  ;;;
{
$A2:BA9B             dx 0004,BD6C,
                        0004,BD82,
                        0004,BD6C,
                        0004,BD82,
                        0004,BD6C,
                        0004,BD82,
                        0004,BD6C,
                        0004,BD82,
                        0004,BD98,
                        0004,BDAE,
                        0004,BD98,
                        0004,BDAE,
                        80ED,BA9B   ; Go to $BA9B
}


;;; $BACF: Instruction list -  ;;;
{
$A2:BACF             dx 0003,BD98,
                        0003,BDAE,
                        0003,BDC4,
                        0003,BDDA,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        0003,BDF0,
                        0003,BE06,
                        80ED,BACF   ; Go to $BACF
}


;;; $BB4B: Instruction list -  ;;;
{
$A2:BB4B             dx 0004,BD6C,
                        0004,BD82,
                        0004,BD6C,
                        0004,BD82,
                        0004,BD6C,
                        0004,BD82,
                        0004,BD6C,
                        0004,BD82,
                        0004,BD98,
                        0004,BDAE,
                        0004,BD98,
                        0004,BDAE,
                        80ED,BB4B   ; Go to $BB4B
}


;;; $BB7F: Instruction list -  ;;;
{
$A2:BB7F             dx 0003,BD98,
                        0003,BDAE,
                        0003,BDC4,
                        0003,BDDA,
                        0003,BDF0,
                        BBC3,       ; ???
                        812F        ; Sleep
}


;;; $BB97: Instruction list -  ;;;
{
$A2:BB97             dx 0003,BE06,
                        0003,BDF0,
                        80ED,BB97   ; Go to $BB97
}


;;; $BBA3: Instruction list -  ;;;
{
$A2:BBA3             dx 0003,BDF0,
                        0003,BDDA,
                        0003,BDC4,
                        0003,BDAE,
                        0003,BD98,
                        BBC3,       ; ???
                        812F        ; Sleep
}
}


;;; $BBBB: Rio constants ;;;
{
$A2:BBBB             dw 0580
$A2:BBBD             dw 0600 ; Unused
$A2:BBBF             dw 0180
$A2:BBC1             dw 0200 ; Unused
}


;;; $BBC3: Instruction ;;;
{
$A2:BBC3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:BBC6 A9 01 00    LDA #$0001
$A2:BBC9 9D B0 0F    STA $0FB0,x[$7E:10B0]
$A2:BBCC 6B          RTL
}


;;; $BBCD: Initialisation AI - enemy $D27F (rio) ;;;
{
$A2:BBCD AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:BBD0 9E B0 0F    STZ $0FB0,x[$7E:10B0]
$A2:BBD3 9E B2 0F    STZ $0FB2,x[$7E:10B2]
$A2:BBD6 A9 4B BB    LDA #$BB4B
$A2:BBD9 9D 92 0F    STA $0F92,x[$7E:1092]
$A2:BBDC A9 ED BB    LDA #$BBED
$A2:BBDF 9D AA 0F    STA $0FAA,x[$7E:10AA]
$A2:BBE2 6B          RTL
}


;;; $BBE3: Main AI - enemy $D27F (rio) ;;;
{
$A2:BBE3 22 11 81 80 JSL $808111[$80:8111]
$A2:BBE7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:BBEA 7C AA 0F    JMP ($0FAA,x)[$A2:BBED]
}


;;; $BBED:  ;;;
{
$A2:BBED A9 A0 00    LDA #$00A0
$A2:BBF0 22 9B BB A0 JSL $A0BB9B[$A0:BB9B]
$A2:BBF4 90 01       BCC $01    [$BBF7]
$A2:BBF6 6B          RTL

$A2:BBF7 AD BB BB    LDA $BBBB  [$A2:BBBB]
$A2:BBFA 9D AC 0F    STA $0FAC,x[$7E:10AC]
$A2:BBFD AD BF BB    LDA $BBBF  [$A2:BBBF]
$A2:BC00 9D AE 0F    STA $0FAE,x[$7E:10AE]
$A2:BC03 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:BC06 DD 7A 0F    CMP $0F7A,x[$7E:107A]
$A2:BC09 10 0A       BPL $0A    [$BC15]
$A2:BC0B BD AE 0F    LDA $0FAE,x[$7E:10AE]
$A2:BC0E 49 FF FF    EOR #$FFFF
$A2:BC11 1A          INC A
$A2:BC12 9D AE 0F    STA $0FAE,x[$7E:10AE]

$A2:BC15 A9 7F BB    LDA #$BB7F
$A2:BC18 20 54 BD    JSR $BD54  [$A2:BD54]
$A2:BC1B A9 48 BC    LDA #$BC48
$A2:BC1E 9D AA 0F    STA $0FAA,x[$7E:10AA]
$A2:BC21 22 70 AD A0 JSL $A0AD70[$A0:AD70]
$A2:BC25 29 FF FF    AND #$FFFF
$A2:BC28 D0 07       BNE $07    [$BC31]
$A2:BC2A A9 65 00    LDA #$0065             ;\
$A2:BC2D 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 65h, sound library 2, max queued sounds allowed = 6 (rio cry)

$A2:BC31 6B          RTL
}


;;; $BC32:  ;;;
{
$A2:BC32 BD B0 0F    LDA $0FB0,x[$7E:10B0]
$A2:BC35 D0 01       BNE $01    [$BC38]
$A2:BC37 6B          RTL

$A2:BC38 9E B0 0F    STZ $0FB0,x[$7E:10B0]
$A2:BC3B A9 53 BB    LDA #$BB53
$A2:BC3E 20 54 BD    JSR $BD54  [$A2:BD54]
$A2:BC41 A9 ED BB    LDA #$BBED
$A2:BC44 9D AA 0F    STA $0FAA,x[$7E:10AA]
$A2:BC47 6B          RTL
}


;;; $BC48:  ;;;
{
$A2:BC48 64 12       STZ $12    [$7E:0012]  ;\
$A2:BC4A 64 14       STZ $14    [$7E:0014]  ;|
$A2:BC4C BD AE 0F    LDA $0FAE,x[$7E:10AE]  ;|
$A2:BC4F 10 02       BPL $02    [$BC53]     ;|
$A2:BC51 C6 14       DEC $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity] / 100h
                                            ;|
$A2:BC53 85 13       STA $13    [$7E:0013]  ;|
$A2:BC55 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:BC59 B0 41       BCS $41    [$BC9C]     ; If collided with wall: go to BRANCH_COLLIDED_HORIZONTALLY
$A2:BC5B 64 12       STZ $12    [$7E:0012]  ;\
$A2:BC5D 64 14       STZ $14    [$7E:0014]  ;|
$A2:BC5F BD AC 0F    LDA $0FAC,x[$7E:10AC]  ;|
$A2:BC62 10 02       BPL $02    [$BC66]     ;|
$A2:BC64 C6 14       DEC $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity] / 100h
                                            ;|
$A2:BC66 85 13       STA $13    [$7E:0013]  ;|
$A2:BC68 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:BC6C B0 38       BCS $38    [$BCA6]     ; If collided with block: go to BRANCH_COLLIDED_VERTICALLY
$A2:BC6E BD AC 0F    LDA $0FAC,x[$7E:10AC]
$A2:BC71 38          SEC
$A2:BC72 E9 18 00    SBC #$0018
$A2:BC75 9D AC 0F    STA $0FAC,x[$7E:10AC]
$A2:BC78 30 0F       BMI $0F    [$BC89]
$A2:BC7A BD B0 0F    LDA $0FB0,x[$7E:10B0]
$A2:BC7D F0 09       BEQ $09    [$BC88]
$A2:BC7F 9E B0 0F    STZ $0FB0,x[$7E:10B0]
$A2:BC82 A9 97 BB    LDA #$BB97
$A2:BC85 20 54 BD    JSR $BD54  [$A2:BD54]

$A2:BC88 6B          RTL

$A2:BC89 BD AE 0F    LDA $0FAE,x
$A2:BC8C 9D A8 0F    STA $0FA8,x
$A2:BC8F 9E AE 0F    STZ $0FAE,x
$A2:BC92 9E AC 0F    STZ $0FAC,x
$A2:BC95 A9 FF BC    LDA #$BCFF
$A2:BC98 9D AA 0F    STA $0FAA,x
$A2:BC9B 6B          RTL

; BRANCH_COLLIDED_HORIZONTALLY
$A2:BC9C BD AE 0F    LDA $0FAE,x[$7E:10AE]
$A2:BC9F 49 FF FF    EOR #$FFFF
$A2:BCA2 1A          INC A
$A2:BCA3 9D AE 0F    STA $0FAE,x[$7E:10AE]

; BRANCH_COLLIDED_VERTICALLY
$A2:BCA6 BD AC 0F    LDA $0FAC,x[$7E:10AC]
$A2:BCA9 49 FF FF    EOR #$FFFF
$A2:BCAC 1A          INC A
$A2:BCAD 9D AC 0F    STA $0FAC,x[$7E:10AC]
$A2:BCB0 A9 B7 BC    LDA #$BCB7
$A2:BCB3 9D AA 0F    STA $0FAA,x[$7E:10AA]
$A2:BCB6 6B          RTL
}


;;; $BCB7:  ;;;
{
$A2:BCB7 64 12       STZ $12    [$7E:0012]  ;\
$A2:BCB9 64 14       STZ $14    [$7E:0014]  ;|
$A2:BCBB BD AE 0F    LDA $0FAE,x[$7E:10AE]  ;|
$A2:BCBE 10 02       BPL $02    [$BCC2]     ;|
$A2:BCC0 C6 14       DEC $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity] / 100h
                                            ;|
$A2:BCC2 85 13       STA $13    [$7E:0013]  ;|
$A2:BCC4 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:BCC8 90 0A       BCC $0A    [$BCD4]     ; If collided with wall:
$A2:BCCA BD AE 0F    LDA $0FAE,x[$7E:106E]
$A2:BCCD 49 FF FF    EOR #$FFFF
$A2:BCD0 1A          INC A
$A2:BCD1 9D AE 0F    STA $0FAE,x[$7E:106E]

$A2:BCD4 64 12       STZ $12    [$7E:0012]  ;\
$A2:BCD6 64 14       STZ $14    [$7E:0014]  ;|
$A2:BCD8 BD AC 0F    LDA $0FAC,x[$7E:10AC]  ;|
$A2:BCDB 10 02       BPL $02    [$BCDF]     ;|
$A2:BCDD C6 14       DEC $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity] / 100h
                                            ;|
$A2:BCDF 85 13       STA $13    [$7E:0013]  ;|
$A2:BCE1 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:BCE5 B0 0B       BCS $0B    [$BCF2]     ; If collided with block:
$A2:BCE7 BD AC 0F    LDA $0FAC,x[$7E:10AC]
$A2:BCEA 38          SEC
$A2:BCEB E9 18 00    SBC #$0018
$A2:BCEE 9D AC 0F    STA $0FAC,x[$7E:10AC]
$A2:BCF1 6B          RTL

$A2:BCF2 A9 A3 BB    LDA #$BBA3
$A2:BCF5 20 54 BD    JSR $BD54  [$A2:BD54]
$A2:BCF8 A9 32 BC    LDA #$BC32
$A2:BCFB 9D AA 0F    STA $0FAA,x[$7E:10AA]
$A2:BCFE 6B          RTL
}


;;; $BCFF:  ;;;
{
$A2:BCFF BD 7E 0F    LDA $0F7E,x
$A2:BD02 38          SEC
$A2:BD03 ED FA 0A    SBC $0AFA  [$7E:0AFA]
$A2:BD06 10 39       BPL $39    [$BD41]
$A2:BD08 22 66 C0 A0 JSL $A0C066[$A0:C066]
$A2:BD0C 9B          TXY
$A2:BD0D 0A          ASL A
$A2:BD0E AA          TAX
$A2:BD0F BF 43 B4 A0 LDA $A0B443,x
$A2:BD13 99 AE 0F    STA $0FAE,y
$A2:BD16 BF C3 B3 A0 LDA $A0B3C3,x
$A2:BD1A 99 AC 0F    STA $0FAC,y
$A2:BD1D BB          TYX
$A2:BD1E 64 12       STZ $12    [$7E:0012]  ;\
$A2:BD20 64 14       STZ $14    [$7E:0014]  ;|
$A2:BD22 BD AE 0F    LDA $0FAE,x            ;|
$A2:BD25 10 02       BPL $02    [$BD29]     ;|
$A2:BD27 C6 14       DEC $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity] / 100h
                                            ;|
$A2:BD29 85 13       STA $13    [$7E:0013]  ;|
$A2:BD2B 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:BD2F 64 12       STZ $12    [$7E:0012]  ;\
$A2:BD31 64 14       STZ $14    [$7E:0014]  ;|
$A2:BD33 BD AC 0F    LDA $0FAC,x            ;|
$A2:BD36 10 02       BPL $02    [$BD3A]     ;|
$A2:BD38 C6 14       DEC $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity] / 100h
                                            ;|
$A2:BD3A 85 13       STA $13    [$7E:0013]  ;|
$A2:BD3C 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:BD40 6B          RTL

$A2:BD41 BD A8 0F    LDA $0FA8,x
$A2:BD44 9D AE 0F    STA $0FAE,x
$A2:BD47 A9 FF FF    LDA #$FFFF
$A2:BD4A 9D AC 0F    STA $0FAC,x
$A2:BD4D A9 B7 BC    LDA #$BCB7
$A2:BD50 9D AA 0F    STA $0FAA,x
$A2:BD53 6B          RTL
}


;;; $BD54:  ;;;
{
$A2:BD54 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:BD57 DD B2 0F    CMP $0FB2,x[$7E:10B2]
$A2:BD5A F0 0F       BEQ $0F    [$BD6B]
$A2:BD5C 9D B2 0F    STA $0FB2,x[$7E:10B2]
$A2:BD5F 9D 92 0F    STA $0F92,x[$7E:1092]
$A2:BD62 A9 01 00    LDA #$0001
$A2:BD65 9D 94 0F    STA $0F94,x[$7E:1094]
$A2:BD68 9E 90 0F    STZ $0F90,x[$7E:1090]

$A2:BD6B 60          RTS
}


;;; $BD6C: Spritemaps - rio ;;;
{
$A2:BD6C             dx 0004, 81FF,F0,6100, 81FF,00,6102, 81F0,00,2102, 81F0,F0,2100
$A2:BD82             dx 0004, 81F0,00,2102, 81FF,00,6102, 81FF,F8,E104, 81F0,F8,A104
$A2:BD98             dx 0004, 81FF,00,6106, 81F0,00,2106, 81FF,F0,6100, 81F0,F0,2100
$A2:BDAE             dx 0004, 81FF,00,6106, 81F0,00,2106, 81FF,F8,E104, 81F0,F8,A104
$A2:BDC4             dx 0004, 81FF,00,6108, 81F0,00,2108, 81FF,F0,6100, 81F0,F0,2100
$A2:BDDA             dx 0004, 81FF,00,6108, 81F0,00,2108, 81FF,F8,E104, 81F0,F8,A104
$A2:BDF0             dx 0004, 81FF,00,610A, 81F0,00,210A, 81FF,F0,6100, 81F0,F0,2100
$A2:BE06             dx 0004, 81FF,00,610A, 81F0,00,210A, 81FF,F8,E104, 81F0,F8,A104
}
}


;;; $BE1C..C0D0: Norfair lava-jumping enemy ;;;
{
;;; $BE1C: Palette - enemy $D2BF (Norfair lava-jumping enemy) ;;;
{
$A2:BE1C             dw 3800, 021D, 0015, 0008, 0003, 00BD, 0013, 000E, 000B, 7FFF, 039C, 0237, 00D1, 03A0, 02C0, 05E0
}


;;; $BE3C: Instruction list -  ;;;
{
$A2:BE3C             dx 0001,C02C,
                        812F        ; Sleep
}


;;; $BE42: Instruction list -  ;;;
{
$A2:BE42             dx 0001,C02C,
                        0005,C042,
                        0009,C058,
                        0007,C064,
                        0003,C070,
                        000A,C086,
                        0001,C09C,
                        BE8E,       ; ???
                        812F        ; Sleep
}


;;; $BE62: Instruction list -  ;;;
{
$A2:BE62             dx 0001,C0AD,
                        0001,804D,
                        8123,0001,  ; Timer = 0001h
                        0001,C0C5,
                        0001,804D,
                        0001,C0B9,
                        0001,804D,
                        8110,BE6E,  ; Decrement timer and go to $BE6E if non-zero
                        80ED,BE62   ; Go to $BE62
}


;;; $BE86:  ;;;
{
$A2:BE86             dw F7FF, F8FE, F9BF, FAFF
}


;;; $BE8E: Instruction ;;;
{
$A2:BE8E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:BE91 A9 01 00    LDA #$0001
$A2:BE94 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:BE98 6B          RTL
}


;;; $BE99: Initialisation AI - enemy $D2BF (Norfair lava-jumping enemy) ;;;
{
$A2:BE99 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:BE9C A9 00 00    LDA #$0000
$A2:BE9F 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:BEA3 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:BEA7 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:BEAA 30 19       BMI $19    [$BEC5]
$A2:BEAC BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:BEAF 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:BEB2 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A2:BEB5 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:BEB8 A9 3C BE    LDA #$BE3C
$A2:BEBB 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:BEBE A9 1A BF    LDA #$BF1A
$A2:BEC1 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:BEC4 6B          RTL

$A2:BEC5 A9 62 BE    LDA #$BE62
$A2:BEC8 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A2:BECB A9 DC BE    LDA #$BEDC
$A2:BECE 9D B2 0F    STA $0FB2,x[$7E:0FF2]
$A2:BED1 6B          RTL
}


;;; $BED2: Main AI - enemy $D2BF (Norfair lava-jumping enemy) ;;;
{
$A2:BED2 22 11 81 80 JSL $808111[$80:8111]
$A2:BED6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:BED9 7C B2 0F    JMP ($0FB2,x)[$A2:BF1A]
}


;;; $BEDC:  ;;;
{
$A2:BEDC BD 4C 0F    LDA $0F4C,x[$7E:0F8C]
$A2:BEDF D0 0A       BNE $0A    [$BEEB]
$A2:BEE1 BD 86 0F    LDA $0F86,x
$A2:BEE4 09 00 02    ORA #$0200
$A2:BEE7 9D 86 0F    STA $0F86,x
$A2:BEEA 6B          RTL

$A2:BEEB BD 5E 0F    LDA $0F5E,x[$7E:0F9E]
$A2:BEEE 9D 9E 0F    STA $0F9E,x[$7E:0FDE]
$A2:BEF1 F0 02       BEQ $02    [$BEF5]
$A2:BEF3 80 05       BRA $05    [$BEFA]

$A2:BEF5 3C 6C 0F    BIT $0F6C,x[$7E:0FAC]
$A2:BEF8 30 0A       BMI $0A    [$BF04]

$A2:BEFA BD 86 0F    LDA $0F86,x[$7E:0FC6]
$A2:BEFD 09 00 01    ORA #$0100
$A2:BF00 9D 86 0F    STA $0F86,x[$7E:0FC6]
$A2:BF03 6B          RTL

$A2:BF04 BD 86 0F    LDA $0F86,x[$7E:0FC6]
$A2:BF07 29 FF FE    AND #$FEFF
$A2:BF0A 9D 86 0F    STA $0F86,x[$7E:0FC6]
$A2:BF0D BD 3E 0F    LDA $0F3E,x[$7E:0F7E]
$A2:BF10 9D 7E 0F    STA $0F7E,x[$7E:0FBE]
$A2:BF13 BD 3E 0F    LDA $0F3E,x[$7E:0F7E]
$A2:BF16 9D 7E 0F    STA $0F7E,x[$7E:0FBE]
$A2:BF19 6B          RTL
}


;;; $BF1A:  ;;;
{
$A2:BF1A AD E6 05    LDA $05E6  [$7E:05E6]
$A2:BF1D 29 06 00    AND #$0006
$A2:BF20 A8          TAY
$A2:BF21 B9 86 BE    LDA $BE86,y[$A2:BE88]
$A2:BF24 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:BF27 A9 3E BF    LDA #$BF3E
$A2:BF2A 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:BF2D BD 86 0F    LDA $0F86,x[$7E:0F86]
$A2:BF30 09 00 08    ORA #$0800
$A2:BF33 9D 86 0F    STA $0F86,x[$7E:0F86]
$A2:BF36 A9 0D 00    LDA #$000D             ;\
$A2:BF39 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound Dh, sound library 2, max queued sounds allowed = 6 (splashed into water)
$A2:BF3D 6B          RTL
}


;;; $BF3E:  ;;;
{
$A2:BF3E BD AB 0F    LDA $0FAB,x[$7E:0FAB]
$A2:BF41 29 00 FF    AND #$FF00
$A2:BF44 18          CLC
$A2:BF45 7D 80 0F    ADC $0F80,x[$7E:0F80]
$A2:BF48 9D 80 0F    STA $0F80,x[$7E:0F80]
$A2:BF4B BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A2:BF4E EB          XBA
$A2:BF4F 10 05       BPL $05    [$BF56]
$A2:BF51 09 00 FF    ORA #$FF00
$A2:BF54 80 03       BRA $03    [$BF59]

$A2:BF56 29 FF 00    AND #$00FF

$A2:BF59 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]
$A2:BF5C 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A2:BF5F BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A2:BF62 18          CLC
$A2:BF63 69 38 00    ADC #$0038
$A2:BF66 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:BF69 C9 00 FC    CMP #$FC00
$A2:BF6C B0 01       BCS $01    [$BF6F]
$A2:BF6E 6B          RTL

$A2:BF6F A9 42 BE    LDA #$BE42
$A2:BF72 20 12 C0    JSR $C012  [$A2:C012]
$A2:BF75 A9 7C BF    LDA #$BF7C
$A2:BF78 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:BF7B 6B          RTL
}


;;; $BF7C:  ;;;
{
$A2:BF7C BD AB 0F    LDA $0FAB,x[$7E:0FAB]
$A2:BF7F 29 00 FF    AND #$FF00
$A2:BF82 18          CLC
$A2:BF83 7D 80 0F    ADC $0F80,x[$7E:0F80]
$A2:BF86 9D 80 0F    STA $0F80,x[$7E:0F80]
$A2:BF89 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A2:BF8C EB          XBA
$A2:BF8D 10 05       BPL $05    [$BF94]
$A2:BF8F 09 00 FF    ORA #$FF00
$A2:BF92 80 03       BRA $03    [$BF97]

$A2:BF94 29 FF 00    AND #$00FF

$A2:BF97 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]
$A2:BF9A 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A2:BF9D BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A2:BFA0 18          CLC
$A2:BFA1 69 38 00    ADC #$0038
$A2:BFA4 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:BFA7 BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A2:BFAB D0 01       BNE $01    [$BFAE]
$A2:BFAD 6B          RTL

$A2:BFAE A9 00 00    LDA #$0000
$A2:BFB1 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:BFB5 A9 BC BF    LDA #$BFBC
$A2:BFB8 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:BFBB 6B          RTL
}


;;; $BFBC:  ;;;
{
$A2:BFBC BD AB 0F    LDA $0FAB,x[$7E:0FAB]
$A2:BFBF 29 00 FF    AND #$FF00
$A2:BFC2 18          CLC
$A2:BFC3 7D 80 0F    ADC $0F80,x[$7E:0F80]
$A2:BFC6 9D 80 0F    STA $0F80,x[$7E:0F80]
$A2:BFC9 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A2:BFCC EB          XBA
$A2:BFCD 10 05       BPL $05    [$BFD4]
$A2:BFCF 09 00 FF    ORA #$FF00
$A2:BFD2 80 03       BRA $03    [$BFD7]

$A2:BFD4 29 FF 00    AND #$00FF

$A2:BFD7 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]
$A2:BFDA 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A2:BFDD 29 F0 00    AND #$00F0
$A2:BFE0 C9 F0 00    CMP #$00F0
$A2:BFE3 F0 0B       BEQ $0B    [$BFF0]
$A2:BFE5 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A2:BFE8 18          CLC
$A2:BFE9 69 38 00    ADC #$0038
$A2:BFEC 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:BFEF 6B          RTL

$A2:BFF0 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A2:BFF3 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$A2:BFF6 BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A2:BFF9 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A2:BFFC A9 3C BE    LDA #$BE3C
$A2:BFFF 20 12 C0    JSR $C012  [$A2:C012]
$A2:C002 A9 1A BF    LDA #$BF1A
$A2:C005 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:C008 BD 86 0F    LDA $0F86,x[$7E:0F86]
$A2:C00B 29 FF F7    AND #$F7FF
$A2:C00E 9D 86 0F    STA $0F86,x[$7E:0F86]
$A2:C011 6B          RTL
}


;;; $C012:  ;;;
{
$A2:C012 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C015 DF 02 78 7E CMP $7E7802,x[$7E:7802]
$A2:C019 F0 10       BEQ $10    [$C02B]
$A2:C01B 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:C01F 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:C022 A9 01 00    LDA #$0001
$A2:C025 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:C028 9E 90 0F    STZ $0F90,x[$7E:0F90]

$A2:C02B 60          RTS
}


;;; $C02C: Spritemaps - Norfair lava-jumping enemy ;;;
{
$A2:C02C             dx 0004, 81FF,F3,6100, 81FF,03,6102, 81F0,03,2102, 81F0,F3,2100
$A2:C042             dx 0004, 0007,03,610C, 01F0,03,210C, 81FF,F3,6104, 81F0,F3,2104
$A2:C058             dx 0002, 8000,F4,6106, 81F0,F4,2106
$A2:C064             dx 0002, 8000,F8,E106, 81F0,F8,A106
$A2:C070             dx 0004, 0007,EF,E10C, 01F0,EF,A10C, 81FF,F7,E104, 81F0,F7,A104
$A2:C086             dx 0004, 81FF,FC,E100, 81FF,EC,E102, 81F0,EC,A102, 81F0,FC,A100
$A2:C09C             dx 0003, 81FF,FC,610A, 81F0,FC,210A, 81F8,EC,2108
$A2:C0AD             dx 0002, 0000,04,611C, 01F9,04,211C
$A2:C0B9             dx 0002, 01FC,0C,211D, 01FC,04,210D
$A2:C0C5             dx 0002, 01FC,0C,211E, 01FC,04,210E
}
}


;;; $C0D1..C5F9: Norfair rio ;;;
{
;;; $C0D1: Palette - enemy $D2FF (Norfair rio) ;;;
{
$A2:C0D1             dw 3800, 4E7F, 3975, 0C0A, 0006, 45D8, 2D33, 1C8E, 102B, 5347, 5624, 5962, 5CA0, 1BBD, 0DFD, 009D
}


;;; $C0F1: Instruction list - main - idle ;;;
{
$A2:C0F1             dx C1DF,       ; ???
                        000D,C442,
                        0012,C427,
                        000D,C442,
                        0012,C45D,
                        80ED,C0F1   ; Go to $C0F1
}


;;; $C107: Instruction list - main - swoop - start descending ;;;
{
$A2:C107             dx C1D4,       ; ???
                        0001,C427,
                        C200,       ; ???
                        0001,C508,
                        C20B,       ; ???
                        0001,C523,
                        C216,       ; ???
                        0001,C534,
                        C221,       ; ???
                        0001,C54F,
                        C22C,       ; ???
                        0001,C56A,
                        C1C9,       ; ???
                        812F        ; Sleep
}


;;; $C12F: Instruction list - main - swoop - descending ;;;
{
$A2:C12F             dx C1F5,       ; ???
                        0006,C4B7,
                        0005,C4D2,
                        0008,C4ED,
                        0006,C4D2,
                        80ED,C12F   ; Go to $C12F
}


;;; $C145: Instruction list - main - swoop - start ascending ;;;
{
$A2:C145             dx C22C,       ; ???
                        0001,C56A,
                        C221,       ; ???
                        0001,C54F,
                        C216,       ; ???
                        0001,C534,
                        C20B,       ; ???
                        0001,C523,
                        C200,       ; ???
                        0001,C508,
                        C1D4,       ; ???
                        0001,C427,
                        C1DF,       ; ???
                        0001,C442,
                        C1EA,       ; ???
                        0001,C45D,
                        C1C9,       ; ???
                        812F        ; Sleep
}


;;; $C179: Instruction list - main - swoop - ascending ;;;
{
$A2:C179             dx C237,       ; ???
                        0006,C585,
                        0005,C5A0,
                        0008,C5BB,
                        0006,C5A0,
                        80ED,C179   ; Go to $C179
}


;;; $C18F: Instruction list - flames - ascending ;;;
{
$A2:C18F             dx 0006,C493,
                        0005,C49F,
                        0008,C4AB,
                        0006,C49F,
                        80ED,C18F   ; Go to $C18F
}


;;; $C1A3: Instruction list - flames - descending ;;;
{
$A2:C1A3             dx 0006,C5D6,
                        0005,C5E2,
                        0008,C5EE,
                        0006,C5E2,
                        80ED,C1A3   ; Go to $C1A3
}


;;; $C1B7: Norfair rio constants ;;;
{
; Unused?
$A2:C1B7             dw 0000, 000E, 000C, 000E, 0010

; Swoop Y speeds
$A2:C1C1             dw 0700, 05C0

; Swoop X speed
$A2:C1C5             dw 0100

; Unused. Probably leftover swoop X speed
$A2:C1C7             dw 0100
}


;;; $C1C9: Instruction - set enemy finished swoop start animation flag ;;;
{
$A2:C1C9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C1CC A9 01 00    LDA #$0001
$A2:C1CF 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:C1D3 6B          RTL
}


;;; $C1D4: Instruction - flames Y offset = 8 ;;;
{
$A2:C1D4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C1D7 A9 08 00    LDA #$0008
$A2:C1DA 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C1DE 6B          RTL
}


;;; $C1DF: Instruction - flames Y offset = 8 ;;;
{
$A2:C1DF AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C1E2 A9 08 00    LDA #$0008
$A2:C1E5 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C1E9 6B          RTL
}


;;; $C1EA: Instruction - flames Y offset = Ch ;;;
{
$A2:C1EA AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C1ED A9 0C 00    LDA #$000C
$A2:C1F0 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C1F4 6B          RTL
}


;;; $C1F5: Instruction - flames Y offset = -Ch ;;;
{
$A2:C1F5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C1F8 A9 F4 FF    LDA #$FFF4
$A2:C1FB 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C1FF 6B          RTL
}


;;; $C200: Instruction - flames Y offset = 4 ;;;
{
$A2:C200 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C203 A9 04 00    LDA #$0004
$A2:C206 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C20A 6B          RTL
}


;;; $C20B: Instruction - flames Y offset = 0 ;;;
{
$A2:C20B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C20E A9 00 00    LDA #$0000
$A2:C211 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C215 6B          RTL
}


;;; $C216: Instruction - flames Y offset = -4 ;;;
{
$A2:C216 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C219 A9 FC FF    LDA #$FFFC
$A2:C21C 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C220 6B          RTL
}


;;; $C221: Instruction - flames Y offset = -Ch ;;;
{
$A2:C221 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C224 A9 F4 FF    LDA #$FFF4
$A2:C227 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C22B 6B          RTL
}


;;; $C22C: Instruction - flames Y offset = -10h ;;;
{
$A2:C22C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C22F A9 F0 FF    LDA #$FFF0
$A2:C232 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C236 6B          RTL
}


;;; $C237: Instruction - flames Y offset = Ch ;;;
{
$A2:C237 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C23A A9 0C 00    LDA #$000C
$A2:C23D 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:C241 6B          RTL
}


;;; $C242: Initialisation AI - enemy $D2FF (Norfair rio) ;;;
{
$A2:C242 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C245 A9 00 00    LDA #$0000             ;\
$A2:C248 9F 02 78 7E STA $7E7802,x[$7E:7802];} Enemy finished swoop start animation flag = 0
$A2:C24C 9F 04 78 7E STA $7E7804,x[$7E:7804]; Enemy flames offset = 0
$A2:C250 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A2:C253 30 11       BMI $11    [$C266]     ;} If [enemy parameter 1] & 8000h = 0 (main part):
$A2:C255 A9 F1 C0    LDA #$C0F1             ;\
$A2:C258 9F 00 78 7E STA $7E7800,x[$7E:7800];} Enemy instruction list pointer = enemy instruction list = $C0F1 (main - idle)
$A2:C25C 9D 92 0F    STA $0F92,x[$7E:0F92]  ;/
$A2:C25F A9 E7 C2    LDA #$C2E7             ;\
$A2:C262 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $C2E7 (idle)
$A2:C265 6B          RTL                    ; Return

$A2:C266 A9 8F C1    LDA #$C18F             ;\
$A2:C269 9F 00 78 7E STA $7E7800,x[$7E:7840];} Enemy instruction list pointer = enemy instruction list = $C18F (flames - ascending)
$A2:C26D 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;/
$A2:C270 A9 81 C2    LDA #$C281             ;\
$A2:C273 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $C281 (flames)
$A2:C276 6B          RTL
}


;;; $C277: Main AI - enemy $D2FF (Norfair rio) ;;;
{
$A2:C277 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A2:C27B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C27E 7C B2 0F    JMP ($0FB2,x)[$A2:C2E7]; Go to [enemy function]
}


;;; $C281: Norfair rio function - flames ;;;
{
$A2:C281 BD 4C 0F    LDA $0F4C,x[$7E:0F8C]  ;\
$A2:C284 D0 0A       BNE $0A    [$C290]     ;} If [enemy ([X] - 1) health] = 0:
$A2:C286 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A2:C289 09 00 02    ORA #$0200             ;} Mark enemy for deletion
$A2:C28C 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A2:C28F 6B          RTL                    ; Return

$A2:C290 BD 5E 0F    LDA $0F5E,x[$7E:0F9E]  ;\
$A2:C293 9D 9E 0F    STA $0F9E,x[$7E:0FDE]  ;} Enemy frozen timer = [enemy ([X] - 1) frozen timer]
$A2:C296 F0 03       BEQ $03    [$C29B]     ; If [enemy frozen timer] != 0:
$A2:C298 80 13       BRA $13    [$C2AD]     ; Go to BRANCH_FROZEN
$A2:C29A 6B          RTL                    ; >_<;

$A2:C29B BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A2:C29E 29 FF FE    AND #$FEFF             ;} Set enemy to be visible
$A2:C2A1 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A2:C2A4 BF C0 77 7E LDA $7E77C0,x[$7E:7800];\
$A2:C2A8 C9 F1 C0    CMP #$C0F1             ;} If [enemy ([X] - 1) instruction list] != $C0F1 (idle): go to BRANCH_SWOOPING
$A2:C2AB D0 0A       BNE $0A    [$C2B7]     ;/

; BRANCH_FROZEN
$A2:C2AD BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A2:C2B0 09 00 01    ORA #$0100             ;} Set enemy to be invisible
$A2:C2B3 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A2:C2B6 6B          RTL                    ; Return

; BRANCH_SWOOPING
$A2:C2B7 A9 8F C1    LDA #$C18F             ;\
$A2:C2BA 85 12       STA $12    [$7E:0012]  ;} $12 = $C18F (ascending)
$A2:C2BC BF C4 77 7E LDA $7E77C4,x[$7E:7804];\
$A2:C2C0 10 05       BPL $05    [$C2C7]     ;} If [enemy ([X] - 1) flames Y offset] < 0:
$A2:C2C2 A9 A3 C1    LDA #$C1A3             ;\
$A2:C2C5 85 12       STA $12    [$7E:0012]  ;} $12 = $C1A3 (descending)

$A2:C2C7 A5 12       LDA $12    [$7E:0012]  ;\
$A2:C2C9 20 0D C4    JSR $C40D  [$A2:C40D]  ;| Set enemy instruction list to [$12]
$A2:C2CC BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A2:C2CF 29 FF FE    AND #$FEFF             ;} Set enemy to be visible
$A2:C2D2 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A2:C2D5 BD 3A 0F    LDA $0F3A,x[$7E:0F7A]  ;\
$A2:C2D8 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [enemy ([X] - 1) X position]
$A2:C2DB BD 3E 0F    LDA $0F3E,x[$7E:0F7E]  ;\
$A2:C2DE 18          CLC                    ;|
$A2:C2DF 7F C4 77 7E ADC $7E77C4,x[$7E:7804];} Enemy Y position = [enemy ([X] - 1) Y position] + [enemy ([X] - 1) flames Y offset]
$A2:C2E3 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A2:C2E6 6B          RTL
}


;;; $C2E7: Norfair rio function - idle ;;;
{
$A2:C2E7 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A2:C2EA 29 01 01    AND #$0101             ;} If [random number] & 101h != 0:
$A2:C2ED F0 09       BEQ $09    [$C2F8]     ;/
$A2:C2EF A9 C0 00    LDA #$00C0             ;\
$A2:C2F2 22 9B BB A0 JSL $A0BB9B[$A0:BB9B]  ;} If X distance between enemy and Samus is less than C0h: go to BRANCH_SWOOP
$A2:C2F6 90 14       BCC $14    [$C30C]     ;/

$A2:C2F8 BF 02 78 7E LDA $7E7802,x[$7E:7882];\
$A2:C2FC F0 0D       BEQ $0D    [$C30B]     ;} If finished swoop start animation:
$A2:C2FE A9 00 00    LDA #$0000             ;\
$A2:C301 9F 02 78 7E STA $7E7802,x          ;} Enemy finished swoop start animation flag = 0
$A2:C305 A9 F1 C0    LDA #$C0F1             ;\
$A2:C308 20 0D C4    JSR $C40D  [$A2:C40D]  ;} Set enemy instruction list to $C0F1 (idle)

$A2:C30B 6B          RTL                    ; Return

; BRANCH_SWOOP
$A2:C30C AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A2:C30F 4A          LSR A                  ;|
$A2:C310 29 02 00    AND #$0002             ;|
$A2:C313 A8          TAY                    ;} Enemy Y velocity = [$C1C1 + ([random number] >> 1 & 2)]
$A2:C314 B9 C1 C1    LDA $C1C1,y[$A2:C1C1]  ;|
$A2:C317 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;/
$A2:C31A AD C5 C1    LDA $C1C5  [$A2:C1C5]  ;\
$A2:C31D 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy X velocity = 100h
$A2:C320 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A2:C323 DD 7A 0F    CMP $0F7A,x[$7E:0F7A]  ;} If [Samus X position] < [enemy X position]:
$A2:C326 10 0A       BPL $0A    [$C332]     ;/
$A2:C328 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A2:C32B 49 FF FF    EOR #$FFFF             ;|
$A2:C32E 1A          INC A                  ;} Negate enemy X velocity
$A2:C32F 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
                                            
$A2:C332 A9 07 C1    LDA #$C107             ;\
$A2:C335 20 0D C4    JSR $C40D  [$A2:C40D]  ;} Set enemy instruction list to $C107 (swoop - start descending)
$A2:C338 A9 3F C3    LDA #$C33F             ;\
$A2:C33B 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $C33F (start swoop)
$A2:C33E 6B          RTL
}


;;; $C33F: Norfair rio function - start swoop ;;;
{
$A2:C33F BF 02 78 7E LDA $7E7802,x[$7E:7802];\
$A2:C343 D0 01       BNE $01    [$C346]     ;} If not finished swoop start animation:
$A2:C345 6B          RTL                    ; Return
                                            
$A2:C346 A9 00 00    LDA #$0000             ;\
$A2:C349 9F 02 78 7E STA $7E7802,x[$7E:7802];} Enemy finished swoop start animation flag = 0
$A2:C34D A9 2F C1    LDA #$C12F             ;\
$A2:C350 20 0D C4    JSR $C40D  [$A2:C40D]  ;} Set enemy instruction list to $C12F (swoop - descending)
$A2:C353 A9 61 C3    LDA #$C361             ;\
$A2:C356 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $C361 (swoop - descending)
$A2:C359 A9 65 00    LDA #$0065             ;\
$A2:C35C 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 65h, sound library 2, max queued sounds allowed = 6 (rio cry)
$A2:C360 6B          RTL
}


;;; $C361: Norfair rio function - swoop - descending ;;;
{
$A2:C361 64 12       STZ $12    [$7E:0012]  ;\
$A2:C363 64 14       STZ $14    [$7E:0014]  ;|
$A2:C365 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;|
$A2:C368 10 02       BPL $02    [$C36C]     ;|
$A2:C36A C6 14       DEC $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity] / 100h
                                            ;|
$A2:C36C 85 13       STA $13    [$7E:0013]  ;|
$A2:C36E 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:C372 90 0A       BCC $0A    [$C37E]     ; If collided with wall:
$A2:C374 BD AA 0F    LDA $0FAA,x[$7E:102A]  ;\
$A2:C377 49 FF FF    EOR #$FFFF             ;|
$A2:C37A 1A          INC A                  ;} Negate enemy X velocity
$A2:C37B 9D AA 0F    STA $0FAA,x[$7E:102A]  ;/

$A2:C37E 64 12       STZ $12    [$7E:0012]  ;\
$A2:C380 64 14       STZ $14    [$7E:0014]  ;|
$A2:C382 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;|
$A2:C385 10 02       BPL $02    [$C389]     ;|
$A2:C387 C6 14       DEC $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity] / 100h
                                            ;|
$A2:C389 85 13       STA $13    [$7E:0013]  ;|
$A2:C38B 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:C38F B0 0D       BCS $0D    [$C39E]     ; If not collided with block:
$A2:C391 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$A2:C394 38          SEC                    ;|
$A2:C395 E9 20 00    SBC #$0020             ;} Enemy Y velocity -= 20h
$A2:C398 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;/
$A2:C39B 30 01       BMI $01    [$C39E]     ; If [enemy Y velocity] >= 0:
$A2:C39D 6B          RTL                    ; Return

$A2:C39E A9 FF FF    LDA #$FFFF             ;\
$A2:C3A1 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy Y velocity = -1
$A2:C3A4 A9 45 C1    LDA #$C145             ;\
$A2:C3A7 20 0D C4    JSR $C40D  [$A2:C40D]  ;} Set enemy instruction list to $C145 (swoop - start ascending)
$A2:C3AA A9 B1 C3    LDA #$C3B1             ;\
$A2:C3AD 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $C3B1 (swoop - ascending)
$A2:C3B0 6B          RTL
}


;;; $C3B1: Norfair rio function - swoop - ascending ;;;
{
$A2:C3B1 64 12       STZ $12    [$7E:0012]  ;\
$A2:C3B3 64 14       STZ $14    [$7E:0014]  ;|
$A2:C3B5 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;|
$A2:C3B8 10 02       BPL $02    [$C3BC]     ;|
$A2:C3BA C6 14       DEC $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity] / 100h
                                            ;|
$A2:C3BC 85 13       STA $13    [$7E:0013]  ;|
$A2:C3BE 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:C3C2 90 0A       BCC $0A    [$C3CE]     ; If collided with wall:
$A2:C3C4 BD AA 0F    LDA $0FAA,x[$7E:102A]  ;\
$A2:C3C7 49 FF FF    EOR #$FFFF             ;|
$A2:C3CA 1A          INC A                  ;} Negate enemy X velocity
$A2:C3CB 9D AA 0F    STA $0FAA,x[$7E:102A]  ;/

$A2:C3CE 64 12       STZ $12    [$7E:0012]  ;\
$A2:C3D0 64 14       STZ $14    [$7E:0014]  ;|
$A2:C3D2 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;|
$A2:C3D5 10 02       BPL $02    [$C3D9]     ;|
$A2:C3D7 C6 14       DEC $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity] / 100h
                                            ;|
$A2:C3D9 85 13       STA $13    [$7E:0013]  ;|
$A2:C3DB 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:C3DF B0 1E       BCS $1E    [$C3FF]     ; If collided with block: go to BRANCH_COLLIDED_VERTICALLY
$A2:C3E1 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$A2:C3E4 38          SEC                    ;|
$A2:C3E5 E9 20 00    SBC #$0020             ;} Enemy Y velocity -= 20h
$A2:C3E8 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;/
$A2:C3EB BF 02 78 7E LDA $7E7802,x[$7E:7802];\
$A2:C3EF F0 0D       BEQ $0D    [$C3FE]     ;} If finished swoop start animation:
$A2:C3F1 A9 00 00    LDA #$0000             ;\
$A2:C3F4 9F 02 78 7E STA $7E7802,x[$7E:7802];} Enemy finished swoop start animation flag = 0
$A2:C3F8 A9 79 C1    LDA #$C179             ;\
$A2:C3FB 20 0D C4    JSR $C40D  [$A2:C40D]  ;} Set enemy instruction list to $C179 (swoop - ascending)

$A2:C3FE 6B          RTL                    ; Return

; BRANCH_COLLIDED_VERTICALLY
$A2:C3FF A9 06 C4    LDA #$C406             ;\
$A2:C402 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function = $C406 (finish swoop)
$A2:C405 6B          RTL
}


;;; $C406: Norfair rio function - finish swoop ;;;
{
$A2:C406 A9 E7 C2    LDA #$C2E7             ;\
$A2:C409 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function = $C2E7 (idle)
$A2:C40C 6B          RTL
}


;;; $C40D: Set Norfair rio instruction list ;;;
{
$A2:C40D AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C410 DF 00 78 7E CMP $7E7800,x[$7E:7800];\
$A2:C414 F0 10       BEQ $10    [$C426]     ;} If [A] = [enemy instruction list]: return
$A2:C416 9F 00 78 7E STA $7E7800,x[$7E:7800]; Enemy instruction list = [A]
$A2:C41A 9D 92 0F    STA $0F92,x[$7E:0F92]  ; Enemy instruction list pointer = [A]
$A2:C41D A9 01 00    LDA #$0001             ;\
$A2:C420 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A2:C423 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0

$A2:C426 60          RTS
}


;;; $C427: Norfair rio spritemaps ;;;
{
$A2:C427             dx 0005, 81F8,F6,2100, 81FE,02,610C, 81F1,02,210C, 8006,F5,6106, 81E9,F5,2106
$A2:C442             dx 0005, 81F8,F6,2102, 81FE,04,610C, 81F1,04,210C, 8006,F6,6108, 81E9,F6,2108
$A2:C45D             dx 0005, 8006,F7,610A, 81E9,F7,210A, 81FE,06,610C, 81F1,06,210C, 81F8,F6,2104
$A2:C478             dx 0005, 81FE,04,610C, 81F1,04,210C, 8006,F6,610A, 81E9,F6,210A, 81F8,F6,2102
$A2:C493             dx 0002, 0002,FC,210E, 01F6,FC,210E
$A2:C49F             dx 0002, 0002,FC,210F, 01F6,FC,210F
$A2:C4AB             dx 0002, 0002,FC,211E, 01F6,FC,211E
$A2:C4B7             dx 0005, 81F8,F8,2100, 81FE,EA,E10C, 81F1,EA,A10C, 8006,F8,610A, 81E9,F8,210A
$A2:C4D2             dx 0005, 81F8,F8,2100, 81FE,EA,E10C, 81F1,EA,A10C, 8006,F8,610A, 81E9,F8,210A
$A2:C4ED             dx 0005, 81F8,F8,2100, 81FE,EA,E10C, 81F1,EA,A10C, 8006,F8,610A, 81E9,F8,210A
$A2:C508             dx 0005, 81F8,F6,2100, 81FE,FF,610C, 81F1,FF,210C, 8006,F6,6106, 81E9,F6,2106
$A2:C523             dx 0003, 8005,F7,610A, 81EA,F7,210A, 81F8,F6,2100
$A2:C534             dx 0005, 81F8,F6,2100, 8005,F8,610A, 81FE,ED,E10C, 81F1,ED,A10C, 81EA,F8,210A
$A2:C54F             dx 0005, 81F8,F6,2100, 81FE,EA,E10C, 81F1,EA,A10C, 8005,F8,610A, 81EA,F8,210A
$A2:C56A             dx 0005, 81F8,F6,2100, 81FE,E8,E10C, 81F1,E8,A10C, 8005,F8,610A, 81EA,F8,210A
$A2:C585             dx 0005, 81FE,06,610C, 81F1,06,210C, 8006,F7,6108, 81E9,F7,2108, 81F8,F6,2104
$A2:C5A0             dx 0005, 81FE,06,610C, 81F1,06,210C, 8006,F7,6108, 81E9,F7,2108, 81F8,F6,2104
$A2:C5BB             dx 0005, 81FE,06,610C, 81F1,06,210C, 8006,F7,6108, 81E9,F7,2108, 81F8,F6,2104
$A2:C5D6             dx 0002, 0002,FC,A10E, 01F6,FC,A10E
$A2:C5E2             dx 0002, 0002,FC,A10F, 01F6,FC,A10F
$A2:C5EE             dx 0002, 0002,FC,A11E, 01F6,FC,A11E
}
}


;;; $C5FA..CA2A: Lower Norfair rio ;;;
{
;;; $C5FA: Palette - enemy $D33F (Lower Norfair rio) ;;;
{
$A2:C5FA             dw 3800, 72FA, 55B0, 2845, 1801, 6210, 496B, 38C6, 2C63, 7D7F, 54D5, 384D, 2007, 021F, 1014, 080A
}


;;; $C61A: Instruction list -  ;;;
{
$A2:C61A             dx C6DD,       ; ???
                        000B,C8BD,
                        000B,C8D3,
                        000B,C8E9,
                        000B,C8D3,
                        80ED,C61C   ; Go to $C61C
}


;;; $C630: Instruction list -  ;;;
{
$A2:C630             dx C6DD,       ; ???
                        0003,C8E9,
                        0003,C8FF,
                        0003,C915,
                        0003,C92B,
                        0002,C941,
                        0001,C957,
                        0002,C96D,
                        0003,C983,
                        0003,C999,
                        C6D2,       ; ???
                        812F        ; Sleep
}


;;; $C65A: Instruction list -  ;;;
{
$A2:C65A             dx C6DD,       ; ???
                        0001,C999,
                        812F        ; Sleep
}


;;; $C662: Instruction list -  ;;;
{
$A2:C662             dx C6DD,       ; ???
                        0003,C999,
                        0003,C983,
                        0003,C9AF,
                        C6D2,       ; ???
                        812F        ; Sleep
}


;;; $C674: Instruction list -  ;;;
{
$A2:C674             dx C6E8,       ; ???
                        0002,C9F1,
                        0002,C9C5,
                        0002,C9DB,
                        80ED,C676   ; Go to $C676
}


;;; $C686: Instruction list -  ;;;
{
$A2:C686             dx C6E8,       ; ???
                        0003,C9AF,
                        0003,C983,
                        0002,C96D,
                        0001,C957,
                        0002,C941,
                        0003,C92B,
                        0001,C915,
                        0001,C8FF,
                        0001,C8E9,
                        C6D2,       ; ???
                        812F        ; Sleep
}


;;; $C6B0: Instruction list -  ;;;
{
$A2:C6B0             dx 0006,CA07,
                        0004,CA13,
                        0003,CA1F,
                        80ED,C6B0   ; Go to $C6B0
}


;;; $C6C0: Lower Norfair rio constants ;;;
{
; Unused?
$A2:C6C0             dw 0000, 0009, 000A, 000B, 000A

$A2:C6CA             dw 0700

; Unused?
$A2:C6CC             dw 0700

$A2:C6CE             dw 0100

; Unused?
$A2:C6D0             dw 0100
}


;;; $C6D2: Instruction ;;;
{
$A2:C6D2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C6D5 A9 01 00    LDA #$0001
$A2:C6D8 9F 02 78 7E STA $7E7802,x[$7E:7982]
$A2:C6DC 6B          RTL
}


;;; $C6DD: Instruction ;;;
{
$A2:C6DD AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C6E0 A9 00 00    LDA #$0000
$A2:C6E3 9F 04 78 7E STA $7E7804,x[$7E:7984]
$A2:C6E7 6B          RTL
}


;;; $C6E8: Instruction ;;;
{
$A2:C6E8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C6EB A9 01 00    LDA #$0001
$A2:C6EE 9F 04 78 7E STA $7E7804,x[$7E:7984]
$A2:C6F2 6B          RTL
}


;;; $C6F3: Initialisation AI - enemy $D33F (Lower Norfair rio) ;;;
{
$A2:C6F3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C6F6 A9 00 00    LDA #$0000
$A2:C6F9 9F 02 78 7E STA $7E7802,x[$7E:7902]
$A2:C6FD BD B4 0F    LDA $0FB4,x[$7E:10B4]
$A2:C700 10 11       BPL $11    [$C713]
$A2:C702 A9 2E C7    LDA #$C72E
$A2:C705 9D B2 0F    STA $0FB2,x[$7E:10F2]
$A2:C708 A9 B0 C6    LDA #$C6B0
$A2:C70B 9F 00 78 7E STA $7E7800,x[$7E:7940]
$A2:C70F 9D 92 0F    STA $0F92,x[$7E:10D2]
$A2:C712 6B          RTL

$A2:C713 A9 71 C7    LDA #$C771
$A2:C716 9D B2 0F    STA $0FB2,x[$7E:10B2]
$A2:C719 A9 1A C6    LDA #$C61A
$A2:C71C 9F 00 78 7E STA $7E7800,x[$7E:7900]
$A2:C720 9D 92 0F    STA $0F92,x[$7E:1092]
$A2:C723 6B          RTL
}


;;; $C724: Main AI - enemy $D33F (Lower Norfair rio) ;;;
{
$A2:C724 22 11 81 80 JSL $808111[$80:8111]
$A2:C728 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C72B 7C B2 0F    JMP ($0FB2,x)[$A2:C771]
}


;;; $C72E:  ;;;
{
$A2:C72E BD 4C 0F    LDA $0F4C,x[$7E:110C]
$A2:C731 D0 0A       BNE $0A    [$C73D]
$A2:C733 BD 86 0F    LDA $0F86,x[$7E:11C6]
$A2:C736 09 00 02    ORA #$0200
$A2:C739 9D 86 0F    STA $0F86,x[$7E:11C6]
$A2:C73C 6B          RTL

$A2:C73D BD 5E 0F    LDA $0F5E,x[$7E:111E]
$A2:C740 9D 9E 0F    STA $0F9E,x[$7E:115E]
$A2:C743 F0 02       BEQ $02    [$C747]
$A2:C745 80 06       BRA $06    [$C74D]

$A2:C747 BF C4 77 7E LDA $7E77C4,x[$7E:7984]
$A2:C74B D0 0A       BNE $0A    [$C757]

$A2:C74D BD 86 0F    LDA $0F86,x[$7E:1146]
$A2:C750 09 00 01    ORA #$0100
$A2:C753 9D 86 0F    STA $0F86,x[$7E:1146]
$A2:C756 6B          RTL

$A2:C757 BD 86 0F    LDA $0F86,x[$7E:1146]
$A2:C75A 29 FF FE    AND #$FEFF
$A2:C75D 9D 86 0F    STA $0F86,x[$7E:1146]
$A2:C760 BD 3A 0F    LDA $0F3A,x[$7E:10FA]
$A2:C763 9D 7A 0F    STA $0F7A,x[$7E:113A]
$A2:C766 BD 3E 0F    LDA $0F3E,x[$7E:10FE]
$A2:C769 18          CLC
$A2:C76A 69 0C 00    ADC #$000C
$A2:C76D 9D 7E 0F    STA $0F7E,x[$7E:113E]
$A2:C770 6B          RTL
}


;;; $C771:  ;;;
{
$A2:C771 AD E5 05    LDA $05E5  [$7E:05E5]
$A2:C774 29 01 01    AND #$0101
$A2:C777 F0 09       BEQ $09    [$C782]
$A2:C779 A9 70 00    LDA #$0070
$A2:C77C 22 9B BB A0 JSL $A0BB9B[$A0:BB9B]
$A2:C780 90 0E       BCC $0E    [$C790]

$A2:C782 A9 00 00    LDA #$0000
$A2:C785 9F 02 78 7E STA $7E7802,x[$7E:7982]
$A2:C789 A9 1A C6    LDA #$C61A
$A2:C78C 20 A3 C8    JSR $C8A3  [$A2:C8A3]
$A2:C78F 6B          RTL

$A2:C790 AD CA C6    LDA $C6CA  [$A2:C6CA]
$A2:C793 9D AC 0F    STA $0FAC,x[$7E:112C]
$A2:C796 AD CE C6    LDA $C6CE  [$A2:C6CE]
$A2:C799 9D AE 0F    STA $0FAE,x[$7E:112E]
$A2:C79C AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:C79F DD 7A 0F    CMP $0F7A,x[$7E:10FA]
$A2:C7A2 10 0A       BPL $0A    [$C7AE]
$A2:C7A4 BD AE 0F    LDA $0FAE,x[$7E:112E]
$A2:C7A7 49 FF FF    EOR #$FFFF
$A2:C7AA 1A          INC A
$A2:C7AB 9D AE 0F    STA $0FAE,x[$7E:112E]

$A2:C7AE A9 30 C6    LDA #$C630
$A2:C7B1 20 A3 C8    JSR $C8A3  [$A2:C8A3]
$A2:C7B4 A9 BB C7    LDA #$C7BB
$A2:C7B7 9D B2 0F    STA $0FB2,x[$7E:1132]
$A2:C7BA 6B          RTL
}


;;; $C7BB:  ;;;
{
$A2:C7BB BF 02 78 7E LDA $7E7802,x[$7E:7982]
$A2:C7BF D0 01       BNE $01    [$C7C2]
$A2:C7C1 6B          RTL

$A2:C7C2 A9 00 00    LDA #$0000
$A2:C7C5 9F 02 78 7E STA $7E7802,x[$7E:7982]
$A2:C7C9 A9 5A C6    LDA #$C65A
$A2:C7CC 20 A3 C8    JSR $C8A3  [$A2:C8A3]
$A2:C7CF A9 D6 C7    LDA #$C7D6
$A2:C7D2 9D B2 0F    STA $0FB2,x[$7E:1132]
$A2:C7D5 6B          RTL
}


;;; $C7D6:  ;;;
{
$A2:C7D6 64 12       STZ $12    [$7E:0012]  ;\
$A2:C7D8 64 14       STZ $14    [$7E:0014]  ;|
$A2:C7DA BD AE 0F    LDA $0FAE,x[$7E:112E]  ;|
$A2:C7DD 10 02       BPL $02    [$C7E1]     ;|
$A2:C7DF C6 14       DEC $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity] / 100h
                                            ;|
$A2:C7E1 85 13       STA $13    [$7E:0013]  ;|
$A2:C7E3 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:C7E7 90 0A       BCC $0A    [$C7F3]     ; If collided with wall:
$A2:C7E9 BD AE 0F    LDA $0FAE,x[$7E:102E]
$A2:C7EC 49 FF FF    EOR #$FFFF
$A2:C7EF 1A          INC A
$A2:C7F0 9D AE 0F    STA $0FAE,x[$7E:102E]

$A2:C7F3 64 12       STZ $12    [$7E:0012]  ;\
$A2:C7F5 64 14       STZ $14    [$7E:0014]  ;|
$A2:C7F7 BD AC 0F    LDA $0FAC,x[$7E:112C]  ;|
$A2:C7FA 10 02       BPL $02    [$C7FE]     ;|
$A2:C7FC C6 14       DEC $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity] / 100h
                                            ;|
$A2:C7FE 85 13       STA $13    [$7E:0013]  ;|
$A2:C800 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:C804 B0 0D       BCS $0D    [$C813]     ; If not collided with block:
$A2:C806 BD AC 0F    LDA $0FAC,x[$7E:112C]
$A2:C809 38          SEC
$A2:C80A E9 20 00    SBC #$0020
$A2:C80D 9D AC 0F    STA $0FAC,x[$7E:112C]
$A2:C810 30 01       BMI $01    [$C813]
$A2:C812 6B          RTL

$A2:C813 A9 FF FF    LDA #$FFFF
$A2:C816 9D AC 0F    STA $0FAC,x[$7E:112C]
$A2:C819 A9 62 C6    LDA #$C662
$A2:C81C 20 A3 C8    JSR $C8A3  [$A2:C8A3]
$A2:C81F A9 2D C8    LDA #$C82D
$A2:C822 9D B2 0F    STA $0FB2,x[$7E:1132]
$A2:C825 A9 64 00    LDA #$0064             ;\
$A2:C828 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 64h, sound library 2, max queued sounds allowed = 6 (Lower Norfair rio cry)
$A2:C82C 6B          RTL
}


;;; $C82D:  ;;;
{
$A2:C82D 64 12       STZ $12    [$7E:0012]  ;\
$A2:C82F 64 14       STZ $14    [$7E:0014]  ;|
$A2:C831 BD AE 0F    LDA $0FAE,x[$7E:112E]  ;|
$A2:C834 10 02       BPL $02    [$C838]     ;|
$A2:C836 C6 14       DEC $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity] / 100h
                                            ;|
$A2:C838 85 13       STA $13    [$7E:0013]  ;|
$A2:C83A 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:C83E 90 0A       BCC $0A    [$C84A]     ; If collided with wall:
$A2:C840 BD AE 0F    LDA $0FAE,x[$7E:102E]
$A2:C843 49 FF FF    EOR #$FFFF
$A2:C846 1A          INC A
$A2:C847 9D AE 0F    STA $0FAE,x[$7E:102E]

$A2:C84A 64 12       STZ $12    [$7E:0012]  ;\
$A2:C84C 64 14       STZ $14    [$7E:0014]  ;|
$A2:C84E BD AC 0F    LDA $0FAC,x[$7E:112C]  ;|
$A2:C851 10 02       BPL $02    [$C855]     ;|
$A2:C853 C6 14       DEC $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity] / 100h
                                            ;|
$A2:C855 85 13       STA $13    [$7E:0013]  ;|
$A2:C857 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:C85B B0 1E       BCS $1E    [$C87B]     ; If collided with block: go to BRANCH_COLLIDED_VERTICALLY
$A2:C85D BD AC 0F    LDA $0FAC,x[$7E:112C]
$A2:C860 38          SEC
$A2:C861 E9 20 00    SBC #$0020
$A2:C864 9D AC 0F    STA $0FAC,x[$7E:112C]
$A2:C867 BF 02 78 7E LDA $7E7802,x[$7E:7982]
$A2:C86B F0 0D       BEQ $0D    [$C87A]
$A2:C86D A9 00 00    LDA #$0000
$A2:C870 9F 02 78 7E STA $7E7802,x[$7E:7982]
$A2:C874 A9 74 C6    LDA #$C674
$A2:C877 20 A3 C8    JSR $C8A3  [$A2:C8A3]

$A2:C87A 6B          RTL

; BRANCH_COLLIDED_VERTICALLY
$A2:C87B A9 86 C6    LDA #$C686
$A2:C87E 20 A3 C8    JSR $C8A3  [$A2:C8A3]
$A2:C881 A9 88 C8    LDA #$C888
$A2:C884 9D B2 0F    STA $0FB2,x[$7E:1132]
$A2:C887 6B          RTL
}


;;; $C888:  ;;;
{
$A2:C888 BF 02 78 7E LDA $7E7802,x[$7E:7982]
$A2:C88C D0 01       BNE $01    [$C88F]
$A2:C88E 6B          RTL

$A2:C88F A9 00 00    LDA #$0000
$A2:C892 9F 02 78 7E STA $7E7802,x[$7E:7982]
$A2:C896 A9 86 C6    LDA #$C686
$A2:C899 20 A3 C8    JSR $C8A3  [$A2:C8A3]
$A2:C89C A9 71 C7    LDA #$C771
$A2:C89F 9D B2 0F    STA $0FB2,x[$7E:1132]
$A2:C8A2 6B          RTL
}


;;; $C8A3:  ;;;
{
$A2:C8A3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:C8A6 DF 00 78 7E CMP $7E7800,x[$7E:7980]
$A2:C8AA F0 10       BEQ $10    [$C8BC]
$A2:C8AC 9F 00 78 7E STA $7E7800,x[$7E:7980]
$A2:C8B0 9D 92 0F    STA $0F92,x[$7E:1112]
$A2:C8B3 A9 01 00    LDA #$0001
$A2:C8B6 9D 94 0F    STA $0F94,x[$7E:1114]
$A2:C8B9 9E 90 0F    STZ $0F90,x[$7E:1110]

$A2:C8BC 60          RTS
}


;;; $C8BD: Lower Norfair rio spritemaps ;;;
{
$A2:C8BD             dx 0004, 81F8,04,2126, 8008,F4,6100, 81F8,F4,210A, 81E8,F4,2100
$A2:C8D3             dx 0004, 8008,F5,6100, 81E8,F5,2100, 81F8,F5,210A, 81F8,05,2128
$A2:C8E9             dx 0004, 81F8,06,2128, 8008,F6,6100, 81F8,F6,210A, 81E8,F6,2100
$A2:C8FF             dx 0004, 81F8,06,2128, 81F8,F6,210C, 8008,F6,6100, 81E8,F6,2100
$A2:C915             dx 0004, 81F8,06,2128, 81F8,F6,210E, 8008,F6,6100, 81E8,F6,2100
$A2:C92B             dx 0004, 81F8,06,2128, 81F8,F6,2120, 8008,F6,6100, 81E8,F6,2100
$A2:C941             dx 0004, 81F8,06,2128, 8008,F6,6102, 81E8,F6,2102, 81F8,F6,2120
$A2:C957             dx 0004, 81F8,06,2128, 8008,F6,6104, 81E8,F6,2104, 81F8,F6,2120
$A2:C96D             dx 0004, 81F8,06,2128, 8008,F6,6106, 81E8,F6,2106, 81F8,F6,2120
$A2:C983             dx 0004, 81F8,06,2128, 8008,F6,6108, 81E8,F6,2108, 81F8,F6,2120
$A2:C999             dx 0004, 81F8,06,2128, 8008,F6,6108, 81E8,F6,2108, 81F8,F6,2124
$A2:C9AF             dx 0004, 81F8,06,2128, 8008,F6,6108, 81E8,F6,2108, 81F8,F6,2122
$A2:C9C5             dx 0004, 81F8,06,2128, 8008,F6,6108, 81E8,F6,2108, 81F8,F6,2122
$A2:C9DB             dx 0004, 81F8,06,2128, 8008,F6,6108, 81E8,F6,2108, 81F8,F6,2122
$A2:C9F1             dx 0004, 81F8,06,2128, 8008,F6,6108, 81E8,F6,2108, 81F8,F6,2122
$A2:CA07             dx 0002, 0004,FC,612A, 01F4,FC,212A
$A2:CA13             dx 0002, 0004,FC,612B, 01F4,FC,212B
$A2:CA1F             dx 0002, 0004,FC,612C, 01F4,FC,212C
}
}


;;; $CA2B..D80B: Maridia large indestructible snail ;;;
{
;;; $CA2B: Palette - enemy $D37F (Maridia large indestructible snail) ;;;
{
$A2:CA2B             dw 3800, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 21B9, 1533, 0CCE, 0448, 03E0, 02A0, 0140
}


;;; $CA4B: Instruction list - yyyy ;;;
{
$A2:CA4B             dx 0001,CB87,
                        812F        ; Sleep
}


;;; $CA51: Instruction list - yyyy ;;;
{
$A2:CA51             dx 0010,CB87,
                        0010,CB91,
                        CB6B,       ; Play splashed out of water sound effect
                        0010,CB9B,
                        0002,CBA5,
                        0003,CBAF,
                        0004,CBB9,
                        0002,CBC3,
                        0003,CBCD,
                        0001,CBC3,
                        0003,CBB9,
                        0002,CBAF,
                        0001,CBA5,
                        0012,CB9B,
                        CCB3,       ; Enemy $7E:7804 = 1
                        812F        ; Sleep
}


;;; $CA8B: Instruction list - yyyy ;;;
{
$A2:CA8B             dx 0007,CB9B,
                        CCBE,       ; Enemy $7E:7806 = 1
                        0007,CBD7,
                        CCC9,       ; Enemy $7E:7806 = 0
                        0007,CBE1,
                        0007,CBEB,
                        0007,CBF5,
                        0007,CBFF,
                        0007,CC09,
                        0007,CC13,
                        80ED,CA8B   ; Go to $CA8B
}


;;; $CAB3: Instruction list - yyyy ;;;
{
$A2:CAB3             dx 0007,CC13,
                        0007,CC09,
                        0007,CBFF,
                        0007,CBF5,
                        0007,CBEB,
                        0007,CBE1,
                        0007,CBD7,
                        CCBE,       ; Enemy $7E:7806 = 1
                        0007,CB9B,
                        CCC9,       ; Enemy $7E:7806 = 0
                        80ED,CAB3   ; Go to $CAB3
}


;;; $CADB: Instruction list - yyyy ;;;
{
$A2:CADB             dx 0001,CC1D,
                        812F        ; Sleep
}


;;; $CAE1: Instruction list - yyyy ;;;
{
$A2:CAE1             dx 0010,CC1D,
                        0010,CC27,
                        0010,CC31,
                        CB6B,       ; Play splashed out of water sound effect
                        0002,CC3B,
                        0003,CC45,
                        0004,CC4F,
                        0002,CC59,
                        0003,CC63,
                        0001,CC59,
                        0003,CC4F,
                        0002,CC45,
                        0001,CC3B,
                        0012,CC31,
                        CCB3,       ; Enemy $7E:7804 = 1
                        812F        ; Sleep
}


;;; $CB1B: Instruction list - yyyy ;;;
{
$A2:CB1B             dx 0007,CC31,
                        CCBE,       ; Enemy $7E:7806 = 1
                        0007,CC6D,
                        CCC9,       ; Enemy $7E:7806 = 0
                        0007,CC77,
                        0007,CC81,
                        0007,CC8B,
                        0007,CC95,
                        0007,CC9F,
                        0007,CCA9,
                        80ED,CB1B   ; Go to $CB1B
}


;;; $CB43: Instruction list - yyyy ;;;
{
$A2:CB43             dx 0007,CCA9,
                        0007,CC9F,
                        0007,CC95,
                        0007,CC8B,
                        0007,CC81,
                        0007,CC77,
                        0007,CC6D,
                        CCBE,       ; Enemy $7E:7806 = 1
                        0007,CC31,
                        CCC9,       ; Enemy $7E:7806 = 0
                        80ED,CB43   ; Go to $CB43
}


;;; $CB6B: Instruction - play splashed out of water sound effect ;;;
{
$A2:CB6B DA          PHX
$A2:CB6C 5A          PHY
$A2:CB6D A9 0E 00    LDA #$000E             ;\
$A2:CB70 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound Eh, sound library 2, max queued sounds allowed = 6 (splashed out of water)
$A2:CB74 7A          PLY
$A2:CB75 FA          PLX
$A2:CB76 6B          RTL
}


;;; $CB77: Instruction list pointers ;;;
{
$A2:CB77             dw CADB, CA4B, CB1B, CA8B, CAE1, CA51, CB43, CAB3
}


;;; $CB87: Maridia large indestructible snail extended spritemaps ;;;
{
$A2:CB87             dx 0001, 0000,0000,D3C0,D034
$A2:CB91             dx 0001, 0000,0000,D3E0,D04E
$A2:CB9B             dx 0001, 0000,0000,D400,D05C
$A2:CBA5             dx 0001, 0000,0000,D425,D076
$A2:CBAF             dx 0001, 0000,0000,D454,D090
$A2:CBB9             dx 0001, 0000,0000,D483,D0AA
$A2:CBC3             dx 0001, 0000,0000,D4B7,D0C4
$A2:CBCD             dx 0001, 0000,0000,D4EB,D0DE
$A2:CBD7             dx 0001, 0000,0000,D51F,D0F8
$A2:CBE1             dx 0001, 0000,0000,D535,D11E
$A2:CBEB             dx 0001, 0000,0000,D55A,D138
$A2:CBF5             dx 0001, 0000,0000,D570,D15E
$A2:CBFF             dx 0001, 0000,0000,D595,D178
$A2:CC09             dx 0001, 0000,0000,D5AB,D19E
$A2:CC13             dx 0001, 0000,0000,D5D0,D1B8
$A2:CC1D             dx 0001, 0000,0000,D5E6,D1DE
$A2:CC27             dx 0001, 0000,0000,D606,D1F8
$A2:CC31             dx 0001, 0000,0000,D626,D206
$A2:CC3B             dx 0001, 0000,0000,D64B,D220
$A2:CC45             dx 0001, 0000,0000,D67A,D23A
$A2:CC4F             dx 0001, 0000,0000,D6A9,D254
$A2:CC59             dx 0001, 0000,0000,D6DD,D26E
$A2:CC63             dx 0001, 0000,0000,D711,D288
$A2:CC6D             dx 0001, 0000,0000,D745,D2A2
$A2:CC77             dx 0001, 0000,0000,D75B,D2C8
$A2:CC81             dx 0001, 0000,0000,D780,D2E2
$A2:CC8B             dx 0001, 0000,0000,D796,D308
$A2:CC95             dx 0001, 0000,0000,D7BB,D322
$A2:CC9F             dx 0001, 0000,0000,D7D1,D348
$A2:CCA9             dx 0001, 0000,0000,D7F6,D362
}


;;; $CCB3: Instruction - enemy $7E:7804 = 1 ;;;
{
$A2:CCB3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:CCB6 A9 01 00    LDA #$0001
$A2:CCB9 9F 04 78 7E STA $7E7804,x
$A2:CCBD 6B          RTL
}


;;; $CCBE: Instruction - enemy $7E:7806 = 1 ;;;
{
$A2:CCBE AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:CCC1 A9 01 00    LDA #$0001
$A2:CCC4 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A2:CCC8 6B          RTL
}


;;; $CCC9: Instruction - enemy $7E:7806 = 0 ;;;
{
$A2:CCC9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:CCCC A9 00 00    LDA #$0000
$A2:CCCF 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A2:CCD3 6B          RTL
}


;;; $CCD4: Initialisation AI - enemy $D37F (Maridia large indestructible snail) ;;;
{
$A2:CCD4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:CCD7 A9 00 00    LDA #$0000
$A2:CCDA 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A2:CCDD 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:CCE0 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:CCE4 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:CCE8 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:CCEC 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A2:CCF0 9F 14 78 7E STA $7E7814,x[$7E:7814]
$A2:CCF4 A9 03 00    LDA #$0003
$A2:CCF7 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:CCFA A9 80 00    LDA #$0080
$A2:CCFD 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:CD00 A9 4B CA    LDA #$CA4B
$A2:CD03 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:CD06 A9 E6 CD    LDA #$CDE6
$A2:CD09 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:CD0C A9 66 CF    LDA #$CF66
$A2:CD0F 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:CD12 6B          RTL
}


;;; $CD13: Main AI - enemy $D37F (Maridia large indestructible snail) ;;;
{
$A2:CD13 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:CD16 20 23 CD    JSR $CD23  [$A2:CD23]
$A2:CD19 FC A8 0F    JSR ($0FA8,x)[$A2:CDE6]
$A2:CD1C 20 35 CD    JSR $CD35  [$A2:CD35]
$A2:CD1F 20 77 CD    JSR $CD77  [$A2:CD77]
$A2:CD22 6B          RTL
}


;;; $CD23:  ;;;
{
$A2:CD23 20 FF CF    JSR $CFFF  [$A2:CFFF]
$A2:CD26 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:CD29 9F 0C 78 7E STA $7E780C,x[$7E:780C]
$A2:CD2D BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A2:CD30 9F 10 78 7E STA $7E7810,x[$7E:7810]
$A2:CD34 60          RTS
}


;;; $CD35:  ;;;
{
$A2:CD35 A9 00 00    LDA #$0000
$A2:CD38 9F 16 78 7E STA $7E7816,x[$7E:7816]
$A2:CD3C 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:CD40 F0 0B       BEQ $0B    [$CD4D]     ;} If enemy is touching Samus from below:
$A2:CD42 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A2:CD45 38          SEC                    ;|
$A2:CD46 FF 10 78 7E SBC $7E7810,x[$7E:7810];} Extra Samus Y displacement = [enemy Y position] - [enemy $7E:7810]
$A2:CD4A 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/

$A2:CD4D BF 08 78 7E LDA $7E7808,x[$7E:7808]
$A2:CD51 F0 23       BEQ $23    [$CD76]
$A2:CD53 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:CD56 38          SEC
$A2:CD57 FF 0C 78 7E SBC $7E780C,x[$7E:780C]
$A2:CD5B 85 12       STA $12    [$7E:0012]
$A2:CD5D 30 08       BMI $08    [$CD67]
$A2:CD5F BF 0A 78 7E LDA $7E780A,x[$7E:780A]
$A2:CD63 D0 11       BNE $11    [$CD76]
$A2:CD65 80 06       BRA $06    [$CD6D]

$A2:CD67 BF 0A 78 7E LDA $7E780A,x[$7E:780A]
$A2:CD6B F0 09       BEQ $09    [$CD76]

$A2:CD6D AD 58 0B    LDA $0B58  [$7E:0B58]  ;\
$A2:CD70 18          CLC                    ;|
$A2:CD71 65 12       ADC $12    [$7E:0012]  ;} Extra Samus X displacement += [$12]
$A2:CD73 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A2:CD76 60          RTS
}


;;; $CD77:  ;;;
{
$A2:CD77 BF 08 78 7E LDA $7E7808,x[$7E:7808]
$A2:CD7B F0 68       BEQ $68    [$CDE5]
$A2:CD7D BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:CD80 38          SEC
$A2:CD81 FF 0C 78 7E SBC $7E780C,x[$7E:780C]
$A2:CD85 F0 30       BEQ $30    [$CDB7]
$A2:CD87 30 17       BMI $17    [$CDA0]
$A2:CD89 A5 8B       LDA $8B    [$7E:008B]  ;\
$A2:CD8B 29 00 02    AND #$0200             ;} If not pressing left: return
$A2:CD8E F0 55       BEQ $55    [$CDE5]     ;/
$A2:CD90 A9 01 00    LDA #$0001
$A2:CD93 9F 16 78 7E STA $7E7816,x
$A2:CD97 BF 0C 78 7E LDA $7E780C,x
$A2:CD9B 9D 7A 0F    STA $0F7A,x
$A2:CD9E 80 45       BRA $45    [$CDE5]

$A2:CDA0 A5 8B       LDA $8B    [$7E:008B]  ;\
$A2:CDA2 29 00 01    AND #$0100             ;} If not pressing right: return
$A2:CDA5 F0 3E       BEQ $3E    [$CDE5]     ;/
$A2:CDA7 A9 01 00    LDA #$0001
$A2:CDAA 9F 16 78 7E STA $7E7816,x[$7E:7816]
$A2:CDAE BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A2:CDB2 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$A2:CDB5 80 2E       BRA $2E    [$CDE5]

$A2:CDB7 BF 0A 78 7E LDA $7E780A,x[$7E:780A]
$A2:CDBB F0 0E       BEQ $0E    [$CDCB]
$A2:CDBD BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A2:CDC0 F0 23       BEQ $23    [$CDE5]
$A2:CDC2 A5 8B       LDA $8B    [$7E:008B]  ;\
$A2:CDC4 29 00 01    AND #$0100             ;} If not pressing right: return
$A2:CDC7 F0 1C       BEQ $1C    [$CDE5]     ;/
$A2:CDC9 80 0C       BRA $0C    [$CDD7]

$A2:CDCB BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A2:CDCE D0 15       BNE $15    [$CDE5]
$A2:CDD0 A5 8B       LDA $8B    [$7E:008B]  ;\
$A2:CDD2 29 00 02    AND #$0200             ;} If not pressing left: return
$A2:CDD5 F0 0E       BEQ $0E    [$CDE5]     ;/

$A2:CDD7 A9 01 00    LDA #$0001
$A2:CDDA 9F 16 78 7E STA $7E7816,x[$7E:7816]
$A2:CDDE BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A2:CDE2 9D 7A 0F    STA $0F7A,x[$7E:0F7A]

$A2:CDE5 60          RTS
}


;;; $CDE6:  ;;;
{
$A2:CDE6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:CDE9 BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A2:CDEC F0 05       BEQ $05    [$CDF3]
$A2:CDEE FC B2 0F    JSR ($0FB2,x)[$A2:CF66]
$A2:CDF1 80 37       BRA $37    [$CE2A]

$A2:CDF3 A9 00 00    LDA #$0000
$A2:CDF6 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:CDFA 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]
$A2:CDFE 10 0A       BPL $0A    [$CE0A]
$A2:CE00 A9 01 00    LDA #$0001
$A2:CE03 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:CE06 9F 00 78 7E STA $7E7800,x[$7E:7800]

$A2:CE0A 20 DF CF    JSR $CFDF  [$A2:CFDF]
$A2:CE0D A9 18 00    LDA #$0018
$A2:CE10 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:CE14 F0 14       BEQ $14    [$CE2A]
$A2:CE16 BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A2:CE1A 09 02 00    ORA #$0002
$A2:CE1D 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:CE21 20 DF CF    JSR $CFDF  [$A2:CFDF]
$A2:CE24 A9 2B CE    LDA #$CE2B
$A2:CE27 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:CE2A 60          RTS
}


;;; $CE2B:  ;;;
{
$A2:CE2B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:CE2E BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A2:CE31 F0 05       BEQ $05    [$CE38]
$A2:CE33 FC B2 0F    JSR ($0FB2,x)[$A2:CF66]
$A2:CE36 80 1C       BRA $1C    [$CE54]

$A2:CE38 64 12       STZ $12    [$7E:0012]  ;\
$A2:CE3A A9 01 00    LDA #$0001             ;|
$A2:CE3D 85 14       STA $14    [$7E:0014]  ;} Move enemy down by 1.0
$A2:CE3F 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A2:CE43 B0 0F       BCS $0F    [$CE54]     ; If not collided with block:
$A2:CE45 9E AA 0F    STZ $0FAA,x[$7E:102A]
$A2:CE48 A9 66 CF    LDA #$CF66
$A2:CE4B 9D B2 0F    STA $0FB2,x[$7E:1032]
$A2:CE4E A9 03 00    LDA #$0003
$A2:CE51 9D B0 0F    STA $0FB0,x[$7E:1030]

$A2:CE54 BF 16 78 7E LDA $7E7816,x[$7E:7816]
$A2:CE58 F0 03       BEQ $03    [$CE5D]
$A2:CE5A 4C 3F CF    JMP $CF3F  [$A2:CF3F]

$A2:CE5D 64 24       STZ $24    [$7E:0024]
$A2:CE5F DE AC 0F    DEC $0FAC,x[$7E:0FAC]
$A2:CE62 10 51       BPL $51    [$CEB5]
$A2:CE64 9E AC 0F    STZ $0FAC,x[$7E:0FAC]
$A2:CE67 A9 20 00    LDA #$0020
$A2:CE6A 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:CE6E F0 45       BEQ $45    [$CEB5]
$A2:CE70 BF 06 78 7E LDA $7E7806,x
$A2:CE74 F0 3F       BEQ $3F    [$CEB5]
$A2:CE76 BD B0 0F    LDA $0FB0,x
$A2:CE79 D0 3A       BNE $3A    [$CEB5]
$A2:CE7B A9 00 00    LDA #$0000
$A2:CE7E 9F 00 78 7E STA $7E7800,x
$A2:CE82 9D AE 0F    STA $0FAE,x
$A2:CE85 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]
$A2:CE89 10 0A       BPL $0A    [$CE95]
$A2:CE8B A9 01 00    LDA #$0001
$A2:CE8E 9F 00 78 7E STA $7E7800,x
$A2:CE92 9D AE 0F    STA $0FAE,x

$A2:CE95 A9 80 00    LDA #$0080
$A2:CE98 9D AC 0F    STA $0FAC,x
$A2:CE9B BF 00 78 7E LDA $7E7800,x
$A2:CE9F 29 01 00    AND #$0001
$A2:CEA2 09 04 00    ORA #$0004
$A2:CEA5 9F 00 78 7E STA $7E7800,x
$A2:CEA9 20 DF CF    JSR $CFDF  [$A2:CFDF]
$A2:CEAC A9 40 CF    LDA #$CF40
$A2:CEAF 9D A8 0F    STA $0FA8,x
$A2:CEB2 4C 3F CF    JMP $CF3F  [$A2:CF3F]

$A2:CEB5 A9 80 00    LDA #$0080
$A2:CEB8 A8          TAY
$A2:CEB9 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A2:CEBC F0 04       BEQ $04    [$CEC2]
$A2:CEBE C8          INY
$A2:CEBF C8          INY
$A2:CEC0 C8          INY
$A2:CEC1 C8          INY

$A2:CEC2 B9 89 81    LDA $8189,y[$A2:820D]
$A2:CEC5 85 12       STA $12    [$7E:0012]
$A2:CEC7 B9 87 81    LDA $8187,y[$A2:820B]
$A2:CECA 85 14       STA $14    [$7E:0014]
$A2:CECC BF 08 78 7E LDA $7E7808,x[$7E:7808]
$A2:CED0 F0 20       BEQ $20    [$CEF2]
$A2:CED2 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A2:CED5 DF 0A 78 7E CMP $7E780A,x[$7E:780A]
$A2:CED9 D0 17       BNE $17    [$CEF2]
$A2:CEDB BD AE 0F    LDA $0FAE,x
$A2:CEDE F0 0A       BEQ $0A    [$CEEA]
$A2:CEE0 A5 14       LDA $14    [$7E:0014]
$A2:CEE2 38          SEC
$A2:CEE3 E9 10 00    SBC #$0010
$A2:CEE6 85 14       STA $14    [$7E:0014]
$A2:CEE8 80 08       BRA $08    [$CEF2]

$A2:CEEA A5 14       LDA $14    [$7E:0014]
$A2:CEEC 18          CLC
$A2:CEED 69 10 00    ADC #$0010
$A2:CEF0 85 14       STA $14    [$7E:0014]

$A2:CEF2 22 9D C6 A0 JSL $A0C69D[$A0:C69D]  ; Move enemy right by [$14].[$12], treat slopes as walls
$A2:CEF6 90 02       BCC $02    [$CEFA]     ; If collided with wall:
$A2:CEF8 E6 24       INC $24    [$7E:0024]

$A2:CEFA BF 08 78 7E LDA $7E7808,x[$7E:7808]
$A2:CEFE F0 24       BEQ $24    [$CF24]
$A2:CF00 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A2:CF03 DF 0A 78 7E CMP $7E780A,x[$7E:780A]
$A2:CF07 D0 1B       BNE $1B    [$CF24]
$A2:CF09 BD AE 0F    LDA $0FAE,x
$A2:CF0C F0 0C       BEQ $0C    [$CF1A]
$A2:CF0E BD 7A 0F    LDA $0F7A,x
$A2:CF11 18          CLC
$A2:CF12 69 10 00    ADC #$0010
$A2:CF15 9D 7A 0F    STA $0F7A,x
$A2:CF18 80 0A       BRA $0A    [$CF24]

$A2:CF1A BD 7A 0F    LDA $0F7A,x
$A2:CF1D 38          SEC
$A2:CF1E E9 10 00    SBC #$0010
$A2:CF21 9D 7A 0F    STA $0F7A,x

$A2:CF24 A5 24       LDA $24    [$7E:0024]
$A2:CF26 F0 17       BEQ $17    [$CF3F]
$A2:CF28 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A2:CF2B 49 01 00    EOR #$0001
$A2:CF2E 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:CF31 BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A2:CF35 49 04 00    EOR #$0004
$A2:CF38 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:CF3C 20 DF CF    JSR $CFDF  [$A2:CFDF]

$A2:CF3F 60          RTS
}


;;; $CF40:  ;;;
{
$A2:CF40 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:CF43 BF 04 78 7E LDA $7E7804,x
$A2:CF47 F0 1C       BEQ $1C    [$CF65]
$A2:CF49 A9 00 00    LDA #$0000
$A2:CF4C 9F 04 78 7E STA $7E7804,x
$A2:CF50 BF 00 78 7E LDA $7E7800,x
$A2:CF54 38          SEC
$A2:CF55 E9 02 00    SBC #$0002
$A2:CF58 9F 00 78 7E STA $7E7800,x
$A2:CF5C 20 DF CF    JSR $CFDF  [$A2:CFDF]
$A2:CF5F A9 2B CE    LDA #$CE2B
$A2:CF62 9D A8 0F    STA $0FA8,x

$A2:CF65 60          RTS
}


;;; $CF66:  ;;;
{
$A2:CF66 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A2:CF69 18          CLC                    ;|
$A2:CF6A 69 80 01    ADC #$0180             ;|
$A2:CF6D C9 00 40    CMP #$4000             ;|
$A2:CF70 30 03       BMI $03    [$CF75]     ;} Enemy $0FAA = min(4000h, [enemy $0FAA] + 180h)
$A2:CF72 A9 00 40    LDA #$4000             ;|
                                            ;|
$A2:CF75 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A2:CF78 29 00 FF    AND #$FF00             ;\
$A2:CF7B EB          XBA                    ;|
$A2:CF7C 0A          ASL A                  ;|
$A2:CF7D 0A          ASL A                  ;} Y = [enemy $0FAA] / 100h * 8 (quadratic speed table index)
$A2:CF7E 0A          ASL A                  ;|
$A2:CF7F A8          TAY                    ;/
$A2:CF80 B9 8F 83    LDA $838F,y[$A2:8397]  ;\
$A2:CF83 85 12       STA $12    [$7E:0012]  ;|
$A2:CF85 B9 91 83    LDA $8391,y[$A2:8399]  ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A2:CF88 85 14       STA $14    [$7E:0014]  ;/
$A2:CF8A 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A2:CF8E 90 18       BCC $18    [$CFA8]     ; If not collided with block: return
$A2:CF90 DE B0 0F    DEC $0FB0,x[$7E:0FB0]
$A2:CF93 BD AA 0F    LDA $0FAA,x[$7E:0FAA]
$A2:CF96 38          SEC
$A2:CF97 E9 00 10    SBC #$1000
$A2:CF9A 10 03       BPL $03    [$CF9F]
$A2:CF9C 9E B0 0F    STZ $0FB0,x[$7E:0FB0]

$A2:CF9F 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A2:CFA2 A9 A9 CF    LDA #$CFA9
$A2:CFA5 9D B2 0F    STA $0FB2,x[$7E:0FB2]

$A2:CFA8 60          RTS
}


;;; $CFA9:  ;;;
{
$A2:CFA9 BD AA 0F    LDA $0FAA,x[$7E:102A]
$A2:CFAC 38          SEC
$A2:CFAD E9 80 01    SBC #$0180
$A2:CFB0 9D AA 0F    STA $0FAA,x[$7E:102A]
$A2:CFB3 10 0B       BPL $0B    [$CFC0]
$A2:CFB5 9E AA 0F    STZ $0FAA,x[$7E:102A]
$A2:CFB8 A9 66 CF    LDA #$CF66
$A2:CFBB 9D B2 0F    STA $0FB2,x[$7E:1032]
$A2:CFBE 80 16       BRA $16    [$CFD6]

$A2:CFC0 29 00 FF    AND #$FF00             ;\
$A2:CFC3 EB          XBA                    ;|
$A2:CFC4 0A          ASL A                  ;|
$A2:CFC5 0A          ASL A                  ;} Y = [enemy $0FAA] / 100h * 8 (quadratic speed table index)
$A2:CFC6 0A          ASL A                  ;|
$A2:CFC7 A8          TAY                    ;/
$A2:CFC8 B9 93 83    LDA $8393,y[$A2:84CB]  ;\
$A2:CFCB 85 12       STA $12    [$7E:0012]  ;|
$A2:CFCD B9 95 83    LDA $8395,y[$A2:84CD]  ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A2:CFD0 85 14       STA $14    [$7E:0014]  ;/
$A2:CFD2 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]

$A2:CFD6 60          RTS
}


;;; $CFD7: Unused ;;;
{
$A2:CFD7 A9 63 00    LDA #$0063             ;\
$A2:CFDA 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 63h, sound library 2, max queued sounds allowed = 6 (Mother Brain's ketchup beam)
$A2:CFDE 60          RTS
}


;;; $CFDF:  ;;;
{
$A2:CFDF BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A2:CFE3 DF 02 78 7E CMP $7E7802,x[$7E:7802]
$A2:CFE7 F0 15       BEQ $15    [$CFFE]
$A2:CFE9 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:CFED 0A          ASL A
$A2:CFEE A8          TAY
$A2:CFEF B9 77 CB    LDA $CB77,y[$A2:CB79]
$A2:CFF2 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:CFF5 A9 01 00    LDA #$0001
$A2:CFF8 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:CFFB 9E 90 0F    STZ $0F90,x[$7E:0F90]

$A2:CFFE 60          RTS
}


;;; $CFFF:  ;;;
{
$A2:CFFF AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:D002 A9 00 00    LDA #$0000
$A2:D005 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A2:D009 9F 0A 78 7E STA $7E780A,x[$7E:780A]
$A2:D00D A9 20 00    LDA #$0020
$A2:D010 22 ED AE A0 JSL $A0AEED[$A0:AEED]
$A2:D014 F0 1D       BEQ $1D    [$D033]
$A2:D016 A9 18 00    LDA #$0018
$A2:D019 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:D01D F0 14       BEQ $14    [$D033]
$A2:D01F A9 01 00    LDA #$0001
$A2:D022 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A2:D026 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]
$A2:D02A 10 07       BPL $07    [$D033]
$A2:D02C A9 01 00    LDA #$0001
$A2:D02F 9F 0A 78 7E STA $7E780A,x[$7E:780A]

$A2:D033 60          RTS
}


;;; $D034: Maridia large indestructible snail hitboxes ;;;
{
$A2:D034             dx 0002, FFF0,FFEF,FFF8,0010,D38C,D3B4, FFF8,FFEF,000E,0010,D38C,804C
$A2:D04E             dx 0001, FFF0,FFEF,000E,0010,D38C,804C
$A2:D05C             dx 0002, FFFF,FFEF,000E,0010,D38C,804C, FFEF,FFEF,0000,0010,D38C,D3B4
$A2:D076             dx 0002, FFEC,FFF8,0000,0008,D388,D3B4, 0000,FFEF,000D,0010,D388,804C
$A2:D090             dx 0002, FFEA,FFF8,0000,0007,D388,D3B4, 0000,FFEF,000E,0010,D388,804C
$A2:D0AA             dx 0002, FFE7,FFF7,0000,0008,D388,D3B4, 0000,FFEE,000E,0010,D388,804C
$A2:D0C4             dx 0002, FFE8,FFF8,0000,0009,D388,D3B4, 0000,FFEE,000F,0010,D388,804C
$A2:D0DE             dx 0002, FFE5,FFF8,0000,0008,D388,D3B4, 0000,FFEE,000F,0010,D388,804C
$A2:D0F8             dx 0003, FFF0,0000,0000,0010,D38C,D3B4, FFF0,FFF0,0000,0000,D38C,804C, 0000,FFF0,000E,0010,D38C,804C
$A2:D11E             dx 0002, FFF1,FFEF,000F,0000,D38C,804C, FFF1,0000,000F,0010,D38C,D3B4
$A2:D138             dx 0003, FFF1,FFEF,0000,0010,D38C,804C, 0000,FFEF,000F,0000,D38C,804C, 0000,0000,000F,0010,D38C,D3B4
$A2:D15E             dx 0002, FFF0,FFEF,0000,0010,D38C,804C, 0000,FFEF,000F,0010,D38C,D3B4
$A2:D178             dx 0003, FFF1,FFEF,0000,0010,D38C,804C, 0000,FFEF,000F,0000,D38C,D3B4, 0000,0000,000F,0010,D38C,804C
$A2:D19E             dx 0002, FFF0,FFEE,000F,0000,D38C,D3B4, FFF0,0000,000F,0010,D38C,804C
$A2:D1B8             dx 0003, FFF0,0000,0000,0010,D38C,804C, FFF0,FFEF,0000,0000,D38C,D3B4, 0000,FFEF,000E,0010,D38C,804C
$A2:D1DE             dx 0002, FFF0,FFEF,0008,0010,D38C,804C, 0008,FFEF,0010,0010,D38C,D3B4
$A2:D1F8             dx 0001, FFF0,FFEF,0010,0010,D38C,804C
$A2:D206             dx 0002, FFF0,FFEF,0000,0010,D38C,804C, 0000,FFEF,0010,0010,D38C,D3B4
$A2:D220             dx 0002, FFF0,FFEF,0000,0010,D388,804C, 0000,FFF8,0014,0008,D388,D3B4
$A2:D23A             dx 0002, FFF0,FFEF,FFFF,0010,D388,804C, 0000,FFF8,0016,0008,D388,D3B4
$A2:D254             dx 0002, FFF0,FFEE,0000,0010,D388,804C, 0000,FFF8,0018,0008,D388,D3B4
$A2:D26E             dx 0002, FFF1,FFEF,0000,0010,D388,804C, 0000,FFF8,0018,0008,D388,D3B4
$A2:D288             dx 0002, FFF0,FFEF,0000,0010,D388,804C, 0000,FFF8,0019,0008,D388,D3B4
$A2:D2A2             dx 0003, FFF1,FFF0,0000,0010,D38C,804C, 0000,FFF0,0010,0000,D38C,804C, 0000,0000,0010,0010,D38C,D3B4
$A2:D2C8             dx 0002, FFF1,FFEF,000F,0000,D38C,804C, FFF1,0000,000F,0010,D38C,D3B4
$A2:D2E2             dx 0003, FFF0,0000,0000,0011,D38C,D3B4, FFF0,FFEF,0000,0000,D38C,804C, 0000,FFEF,000E,0011,D38C,804C
$A2:D308             dx 0002, FFF0,FFEF,0000,0010,D38C,D3B4, 0000,FFEF,000E,0010,D38C,804C
$A2:D322             dx 0003, FFF0,FFEF,0000,0000,D38C,D3B4, FFF0,0000,0000,0010,D38C,804C, 0000,FFEF,000E,0010,D38C,804C
$A2:D348             dx 0002, FFF0,FFEF,000F,0000,D38C,D3B4, FFF0,0000,000F,0010,D38C,804C
$A2:D362             dx 0003, FFF1,FFEF,0000,0010,D38C,804C, 0000,FFEF,0010,0000,D38C,D3B4, 0000,0000,0010,0010,D38C,804C
}


;;; $D388:  ;;;
{
$A2:D388 22 23 80 A2 JSL $A28023[$A2:8023]
}


;;; $D38C: Enemy touch - enemy $D37F (Maridia large indestructible snail) ;;;
{
$A2:D38C 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:D390 D0 21       BNE $21    [$D3B3]     ;} If enemy is touching Samus from below: return
$A2:D392 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:D395 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:D398 38          SEC
$A2:D399 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]
$A2:D39C 30 0B       BMI $0B    [$D3A9]
$A2:D39E AD 58 0B    LDA $0B58  [$7E:0B58]  ;\
$A2:D3A1 18          CLC                    ;|
$A2:D3A2 69 04 00    ADC #$0004             ;} Extra Samus X displacement += 4
$A2:D3A5 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A2:D3A8 6B          RTL

$A2:D3A9 AD 58 0B    LDA $0B58  [$7E:0B58]  ;\
$A2:D3AC 18          CLC                    ;|
$A2:D3AD 69 FC FF    ADC #$FFFC             ;} Extra Samus X displacement -= 4
$A2:D3B0 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A2:D3B3 6B          RTL
}


;;; $D3B4: Enemy shot - enemy $D37F (Maridia large indestructible snail) ;;;
{
$A2:D3B4 22 3D A6 A0 JSL $A0A63D[$A0:A63D]
$A2:D3B8 A9 57 00    LDA #$0057             ;\
$A2:D3BB 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot Maridia large indestructible snail)
$A2:D3BF 6B          RTL
}


;;; $D3C0: Maridia large indestructible snail spritemaps ;;;
{
$A2:D3C0             dx 0006, 01F0,00,211E, 01F0,F8,210E, 8000,00,2122, 81F0,00,2120, 8000,F0,2102, 81F0,F0,2100
$A2:D3E0             dx 0006, 01F0,00,211F, 01F0,F8,210F, 8000,00,2122, 81F0,00,2120, 8000,F0,2102, 81F0,F0,2100
$A2:D400             dx 0007, 81F0,F8,2110, 01F8,08,2131, 01F0,08,2130, 01F8,F0,2101, 01F0,F0,2100, 8000,00,2122, 8000,F0,2102
$A2:D425             dx 0009, 01EA,FF,212E, 01F0,00,212F, 81F0,F8,2110, 01F8,F0,2101, 01F0,F0,2100, 01F8,08,2131, 01F0,08,2130, 8000,00,2122, 8000,F0,2102
$A2:D454             dx 0009, 01F8,08,2131, 01F0,08,2130, 01F8,F0,2101, 01F0,F0,2100, 01E8,FE,212E, 01F0,00,212F, 81F0,F8,2110, 8000,00,2122, 8000,F0,2102
$A2:D483             dx 000A, 01F0,00,212F, 01E3,FE,213E, 01E9,FF,213F, 01F8,08,2131, 01F0,08,2130, 01F8,F0,2101, 01F0,F0,2100, 81F0,F8,2110, 8000,00,2122, 8000,F0,2102
$A2:D4B7             dx 000A, 01F0,00,212F, 01E2,00,213E, 01E9,00,213F, 01F8,08,2131, 01F0,08,2130, 01F8,F0,2101, 01F0,F0,2100, 81F0,F8,2110, 8000,00,2122, 8000,F0,2102
$A2:D4EB             dx 000A, 01F0,00,212F, 01E0,FF,213E, 01E8,FF,213F, 01F8,08,2131, 01F0,08,2130, 01F8,F0,2101, 01F0,F0,2100, 81F0,F8,2110, 8000,00,2122, 8000,F0,2102
$A2:D51F             dx 0004, 8000,F0,2104, 8000,00,2128, 81F0,00,2126, 81F0,F0,2106
$A2:D535             dx 0007, 0008,08,211B, 0008,00,210B, 01F0,08,2118, 01F0,00,2108, 81F8,00,2109, 81F0,F0,E122, 8000,F0,2102
$A2:D55A             dx 0004, 81F0,F0,E124, 8000,F0,210C, 8000,00,212C, 81F0,00,212A
$A2:D570             dx 0007, 0008,F0,E130, 0000,F0,E131, 0000,08,E101, 0008,08,E100, 8000,F8,E110, 81F0,F0,E122, 81F0,00,E102
$A2:D595             dx 0004, 81F0,00,E104, 81F0,F0,E128, 8000,F0,E126, 8000,00,E106
$A2:D5AB             dx 0007, 01F0,F8,E10B, 01F0,F0,E11B, 0008,F8,E108, 0008,F0,E118, 81F8,F0,E109, 8000,00,2122, 81F0,00,E102
$A2:D5D0             dx 0004, 8000,00,2124, 81F0,00,E10C, 81F0,F0,E12C, 8000,F0,E12A
$A2:D5E6             dx 0006, 0008,00,611E, 0008,F8,610E, 81F0,00,6122, 8000,00,6120, 81F0,F0,6102, 8000,F0,6100
$A2:D606             dx 0006, 0008,00,611F, 0008,F8,610F, 81F0,00,6122, 8000,00,6120, 81F0,F0,6102, 8000,F0,6100
$A2:D626             dx 0007, 8000,F8,6110, 0000,08,6131, 0008,08,6130, 0000,F0,6101, 0008,F0,6100, 81F0,00,6122, 81F0,F0,6102
$A2:D64B             dx 0009, 000E,FF,612E, 0008,00,612F, 8000,F8,6110, 0000,F0,6101, 0008,F0,6100, 0000,08,6131, 0008,08,6130, 81F0,00,6122, 81F0,F0,6102
$A2:D67A             dx 0009, 0000,08,6131, 0008,08,6130, 0000,F0,6101, 0008,F0,6100, 0010,FE,612E, 0008,00,612F, 8000,F8,6110, 81F0,00,6122, 81F0,F0,6102
$A2:D6A9             dx 000A, 0008,00,612F, 0015,FE,613E, 000F,FF,613F, 0000,08,6131, 0008,08,6130, 0000,F0,6101, 0008,F0,6100, 8000,F8,6110, 81F0,00,6122, 81F0,F0,6102
$A2:D6DD             dx 000A, 0008,00,612F, 0016,00,613E, 000F,00,613F, 0000,08,6131, 0008,08,6130, 0000,F0,6101, 0008,F0,6100, 8000,F8,6110, 81F0,00,6122, 81F0,F0,6102
$A2:D711             dx 000A, 0008,00,612F, 0018,FF,613E, 0010,FF,613F, 0000,08,6131, 0008,08,6130, 0000,F0,6101, 0008,F0,6100, 8000,F8,6110, 81F0,00,6122, 81F0,F0,6102
$A2:D745             dx 0004, 81F0,F0,6104, 81F0,00,6128, 8000,00,6126, 8000,F0,6106
$A2:D75B             dx 0007, 01F0,08,611B, 01F0,00,610B, 0008,08,6118, 0008,00,6108, 81F8,00,6109, 8000,F0,A122, 81F0,F0,6102
$A2:D780             dx 0004, 8000,F0,A124, 81F0,F0,610C, 81F0,00,612C, 8000,00,612A
$A2:D796             dx 0007, 01F0,F0,A130, 01F8,F0,A131, 01F8,08,A101, 01F0,08,A100, 81F0,F8,A110, 8000,F0,A122, 8000,00,A102
$A2:D7BB             dx 0004, 8000,00,A104, 8000,F0,A128, 81F0,F0,A126, 81F0,00,A106
$A2:D7D1             dx 0007, 0008,F8,A10B, 0008,F0,A11B, 01F0,F8,A108, 01F0,F0,A118, 81F8,F0,A109, 81F0,00,6122, 8000,00,A102
$A2:D7F6             dx 0004, 81F0,00,6124, 8000,00,A10C, 8000,F0,A12C, 81F0,F0,A12A
}
}


;;; $D80C..E17A: High-rising slow-falling enemy ;;;
{
;;; $D80C: Palette - enemy $D3BF (high-rising slow-falling enemy) ;;;
{
$A2:D80C             dw 3800, 4B9C, 2610, 0CC6, 0C63, 42F7, 2A52, 19AD, 0D29, 5E59, 3D72, 2CEE, 1447, 033B, 0216, 0113
}


;;; $D82C: Instruction list -  ;;;
{
$A2:D82C             dx 817D,       ; Disable off-screen processing
                        0001,E146,
                        812F        ; Sleep
}


;;; $D834: Instruction list -  ;;;
{
$A2:D834             dx 8173,       ; Enable off-screen processing
                        0008,E15C,
                        0001,E168,
                        812F        ; Sleep
}


;;; $D840: Instruction list -  ;;;
{
$A2:D840             dx 8173,       ; Enable off-screen processing
                        0008,E15C,
                        0001,E16F,
                        812F        ; Sleep
}


;;; $D84C:  ;;;
{
$A2:D84C             dw 0000, 0000, 0001, 0001, 0002, 0001, 0003, 0002, 0004, 0002, 0005, 0002, 0006, 0003, 0007, 0003,
                        0008, 0003, 0009, 0003, 000A, 0003, 000B, 0003, 000C, 0003, 000C, 0003, 000D, 0003, 000D, 0003,
                        000D, 0003, 000E, 0003, 000E, 0003, 000E, 0003, 000F, 0003, 000F, 0003, 0010, 0003, 0010, 0003,
                        0010, 0003, 0010, 0003, 0011, 0003, 0011, 0003, 0010, 0005, 000F, 0006, 000E, 0008, 000C, 0009,
                        000B, 000A, 000A, 000C, 0008, 000D, 0007, 000E, 0006, 000E, 0004, 000F, 0003, 0010, 0002, 0010,
                        0001, 0011, 0000, 0011, FFFF, 0011, FFFE, 0012, FFFC, 0012, FFFC, 0012, FFFB, 0012, FFFA, 0012,
                        FFF9, 0012, FFF8, 0012, FFF7, 0012, FFF7, 0012, FFF7, 0012, FFF6, 0012, FFF6, 0012, FFF5, 0012,
                        FFF5, 0012, FFF4, 0012, FFF4, 0012, FFF4, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF4, 0014,
                        FFF5, 0016, FFF6, 0017, FFF7, 0019, FFF9, 001A, FFFA, 001B, FFFB, 001C, FFFD, 001D, FFFE, 001E,
                        FFFF, 001F, 8000, 8000

$A2:D974             dw 001E

$A2:D976             dw 0000, 0000, 0003, 0000, 0005, 0001, 0007, 0001, 0009, 0002, 000B, 0002, 000D, 0002, 000E, 0002,
                        0010, 0003, 0012, 0003, 0013, 0003, 0015, 0003, 0016, 0003, 0017, 0003, 0018, 0003, 0019, 0003,
                        0019, 0003, 001A, 0003, 001B, 0003, 001C, 0003, 001D, 0003, 001E, 0003, 001E, 0003, 001F, 0003,
                        001F, 0003, 0020, 0003, 0020, 0003, 0020, 0003, 001E, 0004, 001C, 0006, 001A, 0007, 0017, 0008,
                        0015, 000A, 0013, 000B, 0010, 000C, 000E, 000C, 000B, 000D, 0009, 000E, 0007, 000E, 0005, 000F,
                        0002, 000F, 0000, 0010, FFFE, 0010, FFFC, 0010, FFFA, 0010, FFF9, 0011, FFF7, 0011, FFF5, 0011,
                        FFF4, 0011, FFF2, 0011, FFF1, 0011, FFF0, 0011, FFF0, 0011, FFEF, 0011, FFEE, 0011, FFED, 0011,
                        FFEC, 0011, FFEB, 0011, FFEA, 0011, FFEA, 0011, FFE9, 0011, FFE8, 0011, FFE8, 0011, FFEA, 0013,
                        FFEC, 0014, FFEE, 0016, FFF0, 0017, FFF2, 0018, FFF5, 0019, FFF7, 001A, FFFA, 001B, FFFC, 001C,
                        FFFE, 001D, 8000, 8000

$A2:DA9E             dw 001C

$A2:DAA0             dw 0000, 0000, 0003, 0001, 0006, 0001, 0009, 0002, 000C, 0002, 000F, 0003, 0011, 0003, 0014, 0003,
                        0016, 0003, 0018, 0003, 001A, 0003, 001C, 0004, 001E, 0004, 0020, 0004, 0022, 0004, 0023, 0004,
                        0024, 0004, 0025, 0004, 0026, 0004, 0028, 0004, 0029, 0004, 002A, 0004, 002A, 0004, 002B, 0004,
                        002C, 0003, 002D, 0003, 002D, 0003, 002D, 0003, 002A, 0005, 0027, 0007, 0024, 0009, 0021, 000A,
                        001E, 000B, 001A, 000D, 0017, 000E, 0014, 000F, 0010, 000F, 000D, 0010, 000A, 0011, 0006, 0011,
                        0003, 0012, 0000, 0012, FFFD, 0013, FFFB, 0013, FFF8, 0013, FFF6, 0013, FFF3, 0013, FFF1, 0014,
                        FFEF, 0014, FFED, 0014, FFEB, 0014, FFE9, 0014, FFE8, 0014, FFE7, 0014, FFE5, 0014, FFE4, 0014,
                        FFE3, 0014, FFE2, 0014, FFE1, 0013, FFE0, 0013, FFDF, 0013, FFDE, 0013, FFDE, 0013, FFE1, 0015,
                        FFE4, 0017, FFE7, 0018, FFEA, 001A, FFEE, 001B, FFF1, 001C, FFF4, 001D, FFF8, 001E, FFFB, 001F,
                        FFFE, 0020, 8000, 8000

$A2:DBC8             dw 0020

$A2:DBCA             dw 0000, 0000, 0001, 0001, 0002, 0001, 0003, 0002, 0004, 0002, 0005, 0002, 0006, 0003, 0007, 0003,
                        0008, 0003, 0009, 0003, 000A, 0003, 000B, 0003, 000C, 0003, 000C, 0003, 000D, 0003, 000D, 0003,
                        000D, 0003, 000E, 0003, 000E, 0003, 000E, 0003, 000F, 0003, 000F, 0003, 0010, 0003, 0010, 0003,
                        0010, 0003, 0010, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003,
                        0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0010, 0005, 000F, 0006,
                        000E, 0008, 000C, 0009, 000B, 000A, 000A, 000C, 0008, 000D, 0007, 000E, 0006, 000E, 0004, 000F,
                        0003, 0010, 0002, 0010, 0001, 0011, 0000, 0011, FFFF, 0011, FFFE, 0012, FFFC, 0012, FFFC, 0012,
                        FFFB, 0012, FFFA, 0012, FFF9, 0012, FFF8, 0012, FFF7, 0012, FFF7, 0012, FFF7, 0012, FFF6, 0012,
                        FFF6, 0012, FFF5, 0012, FFF5, 0012, FFF4, 0012, FFF4, 0012, FFF4, 0012, FFF3, 0012, FFF3, 0012,
                        FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012,
                        FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF4, 0014, FFF5, 0016, FFF6, 0017, FFF7, 0019, FFF9, 001A,
                        FFFA, 001B, FFFB, 001C, FFFD, 001D, FFFE, 001E, FFFF, 001F, 8000, 8000

$A2:DD42             dw 001E

$A2:DD44             dw 0000, 0000, 0001, 0001, 0002, 0001, 0003, 0002, 0004, 0002, 0005, 0002, 0006, 0003, 0007, 0003,
                        0008, 0003, 0009, 0003, 000A, 0003, 000B, 0003, 000C, 0003, 000C, 0003, 000D, 0003, 000D, 0003,
                        000D, 0003, 000E, 0003, 000E, 0003, 000E, 0003, 000F, 0003, 000F, 0003, 0010, 0003, 0010, 0003,
                        0010, 0003, 0010, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003,
                        0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003,
                        0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003,
                        0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003, 0011, 0003,
                        0011, 0003, 0011, 0003, 0010, 0005, 000F, 0006, 000E, 0008, 000C, 0009, 000B, 000A, 000A, 000C,
                        0008, 000D, 0007, 000E, 0006, 000E, 0004, 000F, 0003, 0010, 0002, 0010, 0001, 0011, 0000, 0011,
                        FFFF, 0011, FFFE, 0012, FFFC, 0012, FFFC, 0012, FFFB, 0012, FFFA, 0012, FFF9, 0012, FFF8, 0012,
                        FFF7, 0012, FFF7, 0012, FFF7, 0012, FFF6, 0012, FFF6, 0012, FFF5, 0012, FFF5, 0012, FFF4, 0012,
                        FFF4, 0012, FFF4, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012,
                        FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012,
                        FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012,
                        FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF3, 0012,
                        FFF3, 0012, FFF3, 0012, FFF3, 0012, FFF4, 0014, FFF5, 0016, FFF6, 0017, FFF7, 0019, FFF9, 001A,
                        FFFA, 001B, FFFB, 001C, FFFD, 001D, FFFE, 001E, FFFF, 001F, 8000, 8000

$A2:DF5C             dw 001E
}


;;; $DF5E:  ;;;
{
$A2:DF5E             dw D84C, D976, DAA0, DBCA, DD44, DF5E
$A2:DF6A             dw D974, DA9E, DBC8, DD42, DF5C, DF5E
}


;;; $DF76: Initialisation AI - enemy $D3BF (high-rising slow-falling enemy) ;;;
{
$A2:DF76 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:DF79 A9 2C D8    LDA #$D82C
$A2:DF7C 20 1E E0    JSR $E01E  [$A2:E01E]
$A2:DF7F A9 35 E0    LDA #$E035
$A2:DF82 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:DF85 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A2:DF88 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:DF8C BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A2:DF8F 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:DF93 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A2:DF96 29 FF 00    AND #$00FF
$A2:DF99 0A          ASL A
$A2:DF9A A8          TAY
$A2:DF9B B9 5E DF    LDA $DF5E,y[$A2:DF62]
$A2:DF9E 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:DFA1 B9 6A DF    LDA $DF6A,y[$A2:DF6E]
$A2:DFA4 A8          TAY
$A2:DFA5 B9 00 00    LDA $0000,y[$A2:DBC8]
$A2:DFA8 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:DFAB 20 CE DF    JSR $DFCE  [$A2:DFCE]
$A2:DFAE 20 E9 DF    JSR $DFE9  [$A2:DFE9]
$A2:DFB1 A5 18       LDA $18    [$7E:0018]  ; >_<;
$A2:DFB3 BF 02 78 7E LDA $7E7802,x[$7E:7802]
$A2:DFB7 38          SEC
$A2:DFB8 E5 12       SBC $12    [$7E:0012]
$A2:DFBA 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A2:DFBE BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A2:DFC2 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:DFC6 BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A2:DFCA 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A2:DFCD 6B          RTL
}


;;; $DFCE:  ;;;
{
$A2:DFCE 08          PHP
$A2:DFCF E2 20       SEP #$20
$A2:DFD1 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:DFD4 8D 02 42    STA $4202  [$7E:4202]
$A2:DFD7 BD B2 0F    LDA $0FB2,x[$7E:0FB2]
$A2:DFDA 8D 03 42    STA $4203  [$7E:4203]
$A2:DFDD EA          NOP
$A2:DFDE EA          NOP
$A2:DFDF EA          NOP
$A2:DFE0 C2 20       REP #$20
$A2:DFE2 AD 16 42    LDA $4216  [$7E:4216]
$A2:DFE5 85 12       STA $12    [$7E:0012]
$A2:DFE7 28          PLP
$A2:DFE8 60          RTS
}


;;; $DFE9:  ;;;
{
; Calculate how many frames of falling are required to reach Y offset [$12]

$A2:DFE9 64 14       STZ $14    [$7E:0014]  ;\
$A2:DFEB 64 16       STZ $16    [$7E:0016]  ;} $16.$14 = 0.0
$A2:DFED 64 18       STZ $18    [$7E:0018]  ; $18 = 0

; LOOP
$A2:DFEF A5 18       LDA $18    [$7E:0018]  ;\
$A2:DFF1 18          CLC                    ;|
$A2:DFF2 69 00 02    ADC #$0200             ;} $18 += 200h
$A2:DFF5 85 18       STA $18    [$7E:0018]  ;/
$A2:DFF7 29 00 FF    AND #$FF00             ;\
$A2:DFFA EB          XBA                    ;|
$A2:DFFB 0A          ASL A                  ;|
$A2:DFFC 0A          ASL A                  ;} Y = [$18] / 100h * 8 (quadratic speed table index)
$A2:DFFD 0A          ASL A                  ;|
$A2:DFFE A8          TAY                    ;/
$A2:DFFF A5 14       LDA $14    [$7E:0014]  ;\
$A2:E001 18          CLC                    ;|
$A2:E002 79 8F 83    ADC $838F,y[$A2:839F]  ;|
$A2:E005 90 02       BCC $02    [$E009]     ;|
$A2:E007 E6 16       INC $16    [$7E:0016]  ;|
                                            ;} $16.$14 += [$838F + [Y] + 2].[$838F + [Y]]
$A2:E009 85 14       STA $14    [$7E:0014]  ;|
$A2:E00B A5 16       LDA $16    [$7E:0016]  ;|
$A2:E00D 18          CLC                    ;|
$A2:E00E 79 91 83    ADC $8391,y[$A2:83A1]  ;|
$A2:E011 85 16       STA $16    [$7E:0016]  ;/
$A2:E013 C5 12       CMP $12    [$7E:0012]  ;\
$A2:E015 30 D8       BMI $D8    [$DFEF]     ;} If [$16] < [$12]: go to LOOP
$A2:E017 A5 18       LDA $18    [$7E:0018]  ;\
$A2:E019 9F 0C 78 7E STA $7E780C,x[$7E:780C];} Enemy $7E:780C = [$18]
$A2:E01D 60          RTS
}


;;; $E01E:  ;;;
{
$A2:E01E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E021 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:E024 A9 01 00    LDA #$0001
$A2:E027 9D 94 0F    STA $0F94,x[$7E:0F94]
$A2:E02A 9E 90 0F    STZ $0F90,x[$7E:0F90]
$A2:E02D 60          RTS
}


;;; $E02E: Main AI - enemy $D3BF (high-rising slow-falling enemy) ;;;
{
$A2:E02E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E031 FC A8 0F    JSR ($0FA8,x)[$A2:E035]
$A2:E034 6B          RTL
}


;;; $E035:  ;;;
{
$A2:E035 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E038 A9 50 00    LDA #$0050
$A2:E03B 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:E03F F0 0D       BEQ $0D    [$E04E]
$A2:E041 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A2:E044 9F 0E 78 7E STA $7E780E,x[$7E:780E]
$A2:E048 A9 4F E0    LDA #$E04F
$A2:E04B 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:E04E 60          RTS
}


;;; $E04F:  ;;;
{
$A2:E04F AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E052 BF 0E 78 7E LDA $7E780E,x[$7E:780E]
$A2:E056 3A          DEC A
$A2:E057 9F 0E 78 7E STA $7E780E,x[$7E:780E]
$A2:E05B 10 0C       BPL $0C    [$E069]
$A2:E05D A9 34 D8    LDA #$D834
$A2:E060 20 1E E0    JSR $E01E  [$A2:E01E]
$A2:E063 A9 6A E0    LDA #$E06A
$A2:E066 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:E069 60          RTS
}


;;; $E06A:  ;;;
{
$A2:E06A AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E06D BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A2:E070 29 00 FF    AND #$FF00             ;|
$A2:E073 EB          XBA                    ;|
$A2:E074 0A          ASL A                  ;} Y = [enemy $0FAA] / 100h * 8 (quadratic speed table index)
$A2:E075 0A          ASL A                  ;|
$A2:E076 0A          ASL A                  ;|
$A2:E077 A8          TAY                    ;/
$A2:E078 BD 80 0F    LDA $0F80,x[$7E:0F80]  ;\
$A2:E07B 18          CLC                    ;|
$A2:E07C 79 93 83    ADC $8393,y[$A2:85E3]  ;|
$A2:E07F 90 03       BCC $03    [$E084]     ;|
$A2:E081 FE 7E 0F    INC $0F7E,x[$7E:0F7E]  ;|
                                            ;} Enemy Y position += [$838F + [Y] + 6].[$838F + [Y] + 4]
$A2:E084 9D 80 0F    STA $0F80,x[$7E:0F80]  ;|
$A2:E087 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A2:E08A 18          CLC                    ;|
$A2:E08B 79 95 83    ADC $8395,y[$A2:85E5]  ;|
$A2:E08E 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A2:E091 BD AA 0F    LDA $0FAA,x[$7E:0FAA]
$A2:E094 38          SEC
$A2:E095 E9 00 02    SBC #$0200
$A2:E098 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A2:E09B 10 2F       BPL $2F    [$E0CC]
$A2:E09D BF 04 78 7E LDA $7E7804,x[$7E:7804]
$A2:E0A1 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$A2:E0A4 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A2:E0A8 BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A2:E0AC 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A2:E0AF 9F 0A 78 7E STA $7E780A,x[$7E:780A]
$A2:E0B3 9E AC 0F    STZ $0FAC,x[$7E:0FAC]
$A2:E0B6 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:E0B9 29 FF 00    AND #$00FF
$A2:E0BC 3A          DEC A
$A2:E0BD 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:E0C0 A9 40 D8    LDA #$D840
$A2:E0C3 20 1E E0    JSR $E01E  [$A2:E01E]
$A2:E0C6 A9 CD E0    LDA #$E0CD
$A2:E0C9 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:E0CC 60          RTS
}


;;; $E0CD:  ;;;
{
$A2:E0CD AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E0D0 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A2:E0D3 29 00 FF    AND #$FF00
$A2:E0D6 EB          XBA
$A2:E0D7 0A          ASL A
$A2:E0D8 0A          ASL A
$A2:E0D9 18          CLC
$A2:E0DA 7D B0 0F    ADC $0FB0,x[$7E:0FB0]
$A2:E0DD A8          TAY
$A2:E0DE B9 00 00    LDA $0000,y[$A2:DAA0]
$A2:E0E1 C9 00 80    CMP #$8000
$A2:E0E4 D0 3D       BNE $3D    [$E123]
$A2:E0E6 BF 0A 78 7E LDA $7E780A,x[$7E:788A]
$A2:E0EA 18          CLC
$A2:E0EB 7D B2 0F    ADC $0FB2,x[$7E:1032]
$A2:E0EE 9F 0A 78 7E STA $7E780A,x[$7E:788A]
$A2:E0F2 9E AC 0F    STZ $0FAC,x[$7E:102C]
$A2:E0F5 DE AE 0F    DEC $0FAE,x[$7E:102E]
$A2:E0F8 10 49       BPL $49    [$E143]
$A2:E0FA BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A2:E0FE 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A2:E101 BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A2:E105 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$A2:E108 9E 7C 0F    STZ $0F7C,x[$7E:0F7C]
$A2:E10B BF 02 78 7E LDA $7E7802,x[$7E:7802]
$A2:E10F 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A2:E112 9E 80 0F    STZ $0F80,x[$7E:0F80]
$A2:E115 A9 2C D8    LDA #$D82C
$A2:E118 20 1E E0    JSR $E01E  [$A2:E01E]
$A2:E11B A9 35 E0    LDA #$E035
$A2:E11E 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:E121 80 20       BRA $20    [$E143]

$A2:E123 BF 08 78 7E LDA $7E7808,x[$7E:7808]
$A2:E127 18          CLC
$A2:E128 79 00 00    ADC $0000,y[$A2:DAA0]
$A2:E12B 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$A2:E12E BF 0A 78 7E LDA $7E780A,x[$7E:780A]
$A2:E132 18          CLC
$A2:E133 79 02 00    ADC $0002,y[$A2:DAA2]
$A2:E136 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A2:E139 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A2:E13C 18          CLC
$A2:E13D 69 00 01    ADC #$0100
$A2:E140 9D AC 0F    STA $0FAC,x[$7E:0FAC]

$A2:E143 60          RTS
}


;;; $E144: RTL ;;;
{
$A2:E144 6B          RTL
}


;;; $E145: RTL ;;;
{
$A2:E145 6B          RTL
}


;;; $E146: High-rising slow-falling enemy spritemaps ;;;
{
$A2:E146             dx 0004, 01F0,FC,6107, 01F8,FC,6106, 0008,FC,2107, 0000,FC,2106
$A2:E15C             dx 0002, C3F0,F8,6102, C200,F8,2102
$A2:E168             dx 0001, C3F8,F8,2100
$A2:E16F             dx 0002, C3F0,F8,6104, C200,F8,2104
}
}


;;; $E17B..E2BF: Gripper ;;;
{
;;; $E17B: Palette - enemy $D3FF (gripper) ;;;
{
$A2:E17B             dw 3800, 4B9C, 3694, 0929, 0042, 3B18, 2A52, 19AD, 116B, 7F5A, 7EC0, 6DE0, 54E0, 001D, 0014, 000A
}


;;; $E19B: Instruction list -  ;;;
{
$A2:E19B             dx 0008,E3C5,
                        0007,E3DB,
                        0008,E3C5,
                        0007,E3EC,
                        80ED,E19B   ; Go to $E19B
}


;;; $E1AF: Instruction list -  ;;;
{
$A2:E1AF             dx 0008,E402,
                        0007,E418,
                        0008,E402,
                        0007,E429,
                        80ED,E1AF   ; Go to $E1AF
}


;;; $E1C3: Instruction list -  ;;;
{
$A2:E1C3             dx 0010,E43F,
                        80ED,E1C3   ; Go to $E1C3
}


;;; $E1CB: Instruction list -  ;;;
{
$A2:E1CB             dx 0010,E44B,
                        80ED,E1CB   ; Go to $E1CB
}


;;; $E1D3: Initialisation AI - enemy $D3FF (gripper) ;;;
{
$A2:E1D3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E1D6 BD 92 0F    LDA $0F92,x[$7E:1152]
$A2:E1D9 29 FF 00    AND #$00FF
$A2:E1DC 0A          ASL A
$A2:E1DD 0A          ASL A
$A2:E1DE 0A          ASL A
$A2:E1DF 9D B0 0F    STA $0FB0,x[$7E:1170]
$A2:E1E2 A8          TAY
$A2:E1E3 BD 92 0F    LDA $0F92,x[$7E:1152]
$A2:E1E6 89 FF FE    BIT #$FEFF
$A2:E1E9 F0 0E       BEQ $0E    [$E1F9]
$A2:E1EB B9 87 81    LDA $8187,y[$A2:8207]
$A2:E1EE 9D AE 0F    STA $0FAE,x[$7E:116E]
$A2:E1F1 B9 89 81    LDA $8189,y[$A2:8209]
$A2:E1F4 9D AC 0F    STA $0FAC,x[$7E:116C]
$A2:E1F7 80 0C       BRA $0C    [$E205]

$A2:E1F9 B9 8B 81    LDA $818B,y
$A2:E1FC 9D AE 0F    STA $0FAE,x
$A2:E1FF B9 8D 81    LDA $818D,y
$A2:E202 9D AC 0F    STA $0FAC,x

$A2:E205 A0 9B E1    LDY #$E19B
$A2:E208 BD AE 0F    LDA $0FAE,x[$7E:116E]
$A2:E20B 30 03       BMI $03    [$E210]
$A2:E20D A0 AF E1    LDY #$E1AF

$A2:E210 98          TYA
$A2:E211 9D 92 0F    STA $0F92,x[$7E:1152]
$A2:E214 BD B4 0F    LDA $0FB4,x[$7E:1174]
$A2:E217 9D A8 0F    STA $0FA8,x[$7E:1168]
$A2:E21A BD B6 0F    LDA $0FB6,x[$7E:1176]
$A2:E21D 9D AA 0F    STA $0FAA,x[$7E:116A]
$A2:E220 6B          RTL
}


;;; $E221: Main AI - enemy $D3FF (gripper) ;;;
{
$A2:E221 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E224 BD AC 0F    LDA $0FAC,x[$7E:116C]  ;\
$A2:E227 85 12       STA $12    [$7E:0012]  ;|
$A2:E229 BD AE 0F    LDA $0FAE,x[$7E:116E]  ;} Move enemy right by [enemy X velocity]
$A2:E22C 85 14       STA $14    [$7E:0014]  ;|
$A2:E22E 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:E232 B0 0B       BCS $0B    [$E23F]     ; If not collided with wall:
$A2:E234 20 79 E2    JSR $E279  [$A2:E279]
$A2:E237 B0 06       BCS $06    [$E23F]
$A2:E239 20 8A E2    JSR $E28A  [$A2:E28A]
$A2:E23C B0 01       BCS $01    [$E23F]
$A2:E23E 6B          RTL

$A2:E23F AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E242 BD B0 0F    LDA $0FB0,x[$7E:1170]
$A2:E245 A8          TAY
$A2:E246 BD AE 0F    LDA $0FAE,x[$7E:116E]
$A2:E249 10 11       BPL $11    [$E25C]
$A2:E24B B9 87 81    LDA $8187,y[$A2:8207]
$A2:E24E 9D AE 0F    STA $0FAE,x[$7E:10EE]
$A2:E251 B9 89 81    LDA $8189,y[$A2:8209]
$A2:E254 9D AC 0F    STA $0FAC,x[$7E:10EC]
$A2:E257 A0 AF E1    LDY #$E1AF
$A2:E25A 80 0F       BRA $0F    [$E26B]

$A2:E25C B9 8B 81    LDA $818B,y[$A2:820B]
$A2:E25F 9D AE 0F    STA $0FAE,x[$7E:116E]
$A2:E262 B9 8D 81    LDA $818D,y[$A2:820D]
$A2:E265 9D AC 0F    STA $0FAC,x[$7E:116C]
$A2:E268 A0 9B E1    LDY #$E19B

$A2:E26B 98          TYA
$A2:E26C 9D 92 0F    STA $0F92,x[$7E:1152]
$A2:E26F A9 01 00    LDA #$0001
$A2:E272 9D 94 0F    STA $0F94,x[$7E:1154]
$A2:E275 9E 90 0F    STZ $0F90,x[$7E:1150]
$A2:E278 6B          RTL
}


;;; $E279:  ;;;
{
$A2:E279 BD AE 0F    LDA $0FAE,x[$7E:116E]
$A2:E27C 10 0A       BPL $0A    [$E288]
$A2:E27E BD 7A 0F    LDA $0F7A,x[$7E:113A]
$A2:E281 DD A8 0F    CMP $0FA8,x[$7E:1168]
$A2:E284 10 02       BPL $02    [$E288]
$A2:E286 38          SEC
$A2:E287 60          RTS

$A2:E288 18          CLC
$A2:E289 60          RTS
}


;;; $E28A:  ;;;
{
$A2:E28A BD AE 0F    LDA $0FAE,x[$7E:116E]
$A2:E28D 30 0A       BMI $0A    [$E299]
$A2:E28F BD 7A 0F    LDA $0F7A,x[$7E:113A]
$A2:E292 DD AA 0F    CMP $0FAA,x[$7E:116A]
$A2:E295 30 02       BMI $02    [$E299]
$A2:E297 38          SEC
$A2:E298 60          RTS

$A2:E299 18          CLC
$A2:E29A 60          RTS
}


;;; $E29B: Unused ;;;
{
$A2:E29B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E29E 22 41 80 A2 JSL $A28041[$A2:8041]  ; Normal enemy frozen AI
$A2:E2A2 6B          RTL
}


;;; $E2A3: RTL ;;;
{
$A2:E2A3 6B          RTL
}


;;; $E2A4: Unused. Enemy shot ;;;
{
; Clone of $E3A9
$A2:E2A4 22 3D A6 A0 JSL $A0A63D[$A0:A63D]
$A2:E2A8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E2AB BD 9E 0F    LDA $0F9E,x
$A2:E2AE F0 0F       BEQ $0F    [$E2BF]
$A2:E2B0 A0 3F E4    LDY #$E43F
$A2:E2B3 BD AE 0F    LDA $0FAE,x
$A2:E2B6 30 03       BMI $03    [$E2BB]
$A2:E2B8 A0 4B E4    LDY #$E44B

$A2:E2BB 98          TYA
$A2:E2BC 9D 8E 0F    STA $0F8E,x

$A2:E2BF 6B          RTL
}
}


;;; $E2C0..E3A8: Jet powered ripper ;;;
{
;;; $E2C0: Palette - enemy $D43F (jet powered ripper) ;;;
{
$A2:E2C0             dw 3800, 021D, 0015, 0008, 0003, 00BD, 0013, 000E, 000B, 17BE, 1A9F, 0C53, 084B, 7EC0, 6DE0, 54E0
}


;;; $E2E0: Instruction list -  ;;;
{
$A2:E2E0             dx 0008,E3C5,
                        0007,E3DB,
                        0008,E3C5,
                        0007,E3EC,
                        80ED,E2E0   ; Go to $E2E0
}


;;; $E2F4: Instruction list -  ;;;
{
$A2:E2F4             dx 0008,E402,
                        0007,E418,
                        0008,E402,
                        0007,E429,
                        80ED,E2F4   ; Go to $E2F4
}


;;; $E308: Instruction list -  ;;;
{
$A2:E308             dx 0010,E43F,
                        80ED,E308   ; Go to $E308
}


;;; $E310: Instruction list -  ;;;
{
$A2:E310             dx 0010,E44B,
                        80ED,E310   ; Go to $E310
}


;;; $E318: Initialisation AI - enemy $D43F (jet powered ripper) ;;;
{
$A2:E318 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E31B A0 E0 E2    LDY #$E2E0
$A2:E31E BD B6 0F    LDA $0FB6,x[$7E:1076]
$A2:E321 F0 03       BEQ $03    [$E326]
$A2:E323 A0 F4 E2    LDY #$E2F4

$A2:E326 98          TYA
$A2:E327 9D 92 0F    STA $0F92,x[$7E:1052]
$A2:E32A BD B4 0F    LDA $0FB4,x[$7E:1074]
$A2:E32D 0A          ASL A
$A2:E32E 0A          ASL A
$A2:E32F 0A          ASL A
$A2:E330 9D B0 0F    STA $0FB0,x[$7E:1070]
$A2:E333 A8          TAY
$A2:E334 BD B6 0F    LDA $0FB6,x[$7E:1076]
$A2:E337 F0 0D       BEQ $0D    [$E346]
$A2:E339 B9 87 81    LDA $8187,y[$A2:8247]
$A2:E33C 9D AE 0F    STA $0FAE,x[$7E:106E]
$A2:E33F B9 89 81    LDA $8189,y[$A2:8249]
$A2:E342 9D AC 0F    STA $0FAC,x[$7E:106C]
$A2:E345 6B          RTL

$A2:E346 B9 8B 81    LDA $818B,y[$A2:824B]
$A2:E349 9D AE 0F    STA $0FAE,x[$7E:106E]
$A2:E34C B9 8D 81    LDA $818D,y[$A2:824D]
$A2:E34F 9D AC 0F    STA $0FAC,x[$7E:106C]
$A2:E352 6B          RTL
}


;;; $E353: Main AI - enemy $D43F (jet powered ripper) ;;;
{
$A2:E353 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E356 BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A2:E359 85 12       STA $12    [$7E:0012]  ;|
$A2:E35B BD AE 0F    LDA $0FAE,x[$7E:106E]  ;} Move enemy right by [enemy X velocity]
$A2:E35E 85 14       STA $14    [$7E:0014]  ;|
$A2:E360 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:E364 90 39       BCC $39    [$E39F]     ; If not collided with block: return
$A2:E366 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E369 BD B0 0F    LDA $0FB0,x[$7E:1070]
$A2:E36C A8          TAY
$A2:E36D BD AE 0F    LDA $0FAE,x[$7E:106E]
$A2:E370 10 11       BPL $11    [$E383]
$A2:E372 B9 87 81    LDA $8187,y[$A2:8247]
$A2:E375 9D AE 0F    STA $0FAE,x[$7E:106E]
$A2:E378 B9 89 81    LDA $8189,y[$A2:8249]
$A2:E37B 9D AC 0F    STA $0FAC,x[$7E:106C]
$A2:E37E A0 F4 E2    LDY #$E2F4
$A2:E381 80 0F       BRA $0F    [$E392]

$A2:E383 B9 8B 81    LDA $818B,y[$A2:824B]
$A2:E386 9D AE 0F    STA $0FAE,x[$7E:106E]
$A2:E389 B9 8D 81    LDA $818D,y[$A2:824D]
$A2:E38C 9D AC 0F    STA $0FAC,x[$7E:106C]
$A2:E38F A0 E0 E2    LDY #$E2E0

$A2:E392 98          TYA
$A2:E393 9D 92 0F    STA $0F92,x[$7E:1052]
$A2:E396 A9 01 00    LDA #$0001
$A2:E399 9D 94 0F    STA $0F94,x[$7E:1054]
$A2:E39C 9E 90 0F    STZ $0F90,x[$7E:1050]

$A2:E39F 6B          RTL
}


;;; $E3A0: Unused ;;;
{
$A2:E3A0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E3A3 22 41 80 A2 JSL $A28041[$A2:8041]  ; Normal enemy frozen AI
$A2:E3A7 6B          RTL
}


;;; $E3A8: RTL ;;;
{
$A2:E3A8 6B          RTL
}
}


;;; $E3A9: Enemy shot - enemy $D3FF/$D43F (gripper / jet powered ripper) ;;;
{
$A2:E3A9 22 3D A6 A0 JSL $A0A63D[$A0:A63D]
$A2:E3AD AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E3B0 BD 9E 0F    LDA $0F9E,x[$7E:105E]
$A2:E3B3 F0 0F       BEQ $0F    [$E3C4]
$A2:E3B5 A0 3F E4    LDY #$E43F
$A2:E3B8 BD AE 0F    LDA $0FAE,x[$7E:106E]
$A2:E3BB 30 03       BMI $03    [$E3C0]
$A2:E3BD A0 4B E4    LDY #$E44B

$A2:E3C0 98          TYA
$A2:E3C1 9D 8E 0F    STA $0F8E,x[$7E:104E]

$A2:E3C4 6B          RTL
}


;;; $E3C5: Gripper / jet power ripper spritemaps ;;;
{
$A2:E3C5             dx 0004, 0014,FF,2119, 000C,FF,2118, 01F4,FD,2114, 81FC,F8,2105
$A2:E3DB             dx 0003, 000C,FF,211A, 01F4,FD,2107, 81FC,F8,2105
$A2:E3EC             dx 0004, 0014,FF,2109, 000C,FF,2108, 01F4,FD,2117, 81FC,F8,2105
$A2:E402             dx 0004, 01E4,FF,6119, 01EC,FF,6118, 0004,FD,6114, 81F4,F8,6105
$A2:E418             dx 0003, 01EC,FF,611A, 0004,FD,6107, 81F4,F8,6105
$A2:E429             dx 0004, 01EC,FF,6108, 01E4,FF,6109, 0004,FD,6117, 81F4,F8,6105
$A2:E43F             dx 0002, 01F4,FD,2114, 81FC,F8,2105
$A2:E44B             dx 0002, 0004,FD,6114, 81F4,F8,6105
}


;;; $E457..E57A: Ripper ;;;
{
;;; $E457: Palette - enemy $D47F (ripper) ;;;
{
$A2:E457             dw 3800, 2F1F, 0932, 006A, 0003, 221C, 19B6, 1551, 10EC, 17BE, 189F, 0C53, 084B, 3BE0, 2680, 1580
}


;;; $E477: Instruction list -  ;;;
{
$A2:E477             dx 0008,E54B,
                        0007,E557,
                        0008,E54B,
                        0007,E563,
                        80ED,E477   ; Go to $E477
}


;;; $E48B: Instruction list -  ;;;
{
$A2:E48B             dx 0008,E527,
                        0007,E533,
                        0008,E527,
                        0007,E53F,
                        80ED,E48B   ; Go to $E48B
}


;;; $E49F: Initialisation AI - enemy $D47F (ripper) ;;;
{
$A2:E49F AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E4A2 A0 77 E4    LDY #$E477
$A2:E4A5 BD B6 0F    LDA $0FB6,x[$7E:1176]
$A2:E4A8 D0 03       BNE $03    [$E4AD]
$A2:E4AA A0 8B E4    LDY #$E48B

$A2:E4AD 98          TYA
$A2:E4AE 9D 92 0F    STA $0F92,x[$7E:1152]
$A2:E4B1 BD B4 0F    LDA $0FB4,x[$7E:1174]
$A2:E4B4 0A          ASL A
$A2:E4B5 0A          ASL A
$A2:E4B6 0A          ASL A
$A2:E4B7 9D B0 0F    STA $0FB0,x[$7E:1170]
$A2:E4BA A8          TAY
$A2:E4BB BD B6 0F    LDA $0FB6,x[$7E:1176]
$A2:E4BE F0 0D       BEQ $0D    [$E4CD]
$A2:E4C0 B9 87 81    LDA $8187,y[$A2:8207]
$A2:E4C3 9D AE 0F    STA $0FAE,x[$7E:0FEE]
$A2:E4C6 B9 89 81    LDA $8189,y[$A2:8209]
$A2:E4C9 9D AC 0F    STA $0FAC,x[$7E:0FEC]
$A2:E4CC 6B          RTL

$A2:E4CD B9 8B 81    LDA $818B,y[$A2:820B]
$A2:E4D0 9D AE 0F    STA $0FAE,x[$7E:116E]
$A2:E4D3 B9 8D 81    LDA $818D,y[$A2:820D]
$A2:E4D6 9D AC 0F    STA $0FAC,x[$7E:116C]
$A2:E4D9 6B          RTL
}


;;; $E4DA: Main AI - enemy $D47F (ripper) ;;;
{
$A2:E4DA AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E4DD BD AC 0F    LDA $0FAC,x[$7E:116C]  ;\
$A2:E4E0 85 12       STA $12    [$7E:0012]  ;|
$A2:E4E2 BD AE 0F    LDA $0FAE,x[$7E:116E]  ;} Move enemy right by [enemy X velocity]
$A2:E4E5 85 14       STA $14    [$7E:0014]  ;|
$A2:E4E7 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A2:E4EB 90 39       BCC $39    [$E526]     ; If not collided with wall: return
$A2:E4ED AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E4F0 BD B0 0F    LDA $0FB0,x[$7E:1170]
$A2:E4F3 A8          TAY
$A2:E4F4 BD AE 0F    LDA $0FAE,x[$7E:116E]
$A2:E4F7 10 11       BPL $11    [$E50A]
$A2:E4F9 B9 87 81    LDA $8187,y[$A2:8207]
$A2:E4FC 9D AE 0F    STA $0FAE,x[$7E:116E]
$A2:E4FF B9 89 81    LDA $8189,y[$A2:8209]
$A2:E502 9D AC 0F    STA $0FAC,x[$7E:116C]
$A2:E505 A0 77 E4    LDY #$E477
$A2:E508 80 0F       BRA $0F    [$E519]

$A2:E50A B9 8B 81    LDA $818B,y[$A2:820B]
$A2:E50D 9D AE 0F    STA $0FAE,x[$7E:116E]
$A2:E510 B9 8D 81    LDA $818D,y[$A2:820D]
$A2:E513 9D AC 0F    STA $0FAC,x[$7E:116C]
$A2:E516 A0 8B E4    LDY #$E48B

$A2:E519 98          TYA
$A2:E51A 9D 92 0F    STA $0F92,x[$7E:1152]
$A2:E51D A9 01 00    LDA #$0001
$A2:E520 9D 94 0F    STA $0F94,x[$7E:1154]
$A2:E523 9E 90 0F    STZ $0F90,x[$7E:1150]

$A2:E526 6B          RTL
}


;;; $E527: Ripper spritemaps ;;;
{
$A2:E527             dx 0002, 01F4,FD,3110, C3FC,F8,3101
$A2:E533             dx 0002, 01F4,FD,3113, C3FC,F8,3101
$A2:E53F             dx 0002, 01F4,FD,3103, C3FC,F8,3101
$A2:E54B             dx 0002, 0004,FD,7110, C3F4,F8,7101
$A2:E557             dx 0002, 0004,FD,7103, C3F4,F8,7101
$A2:E563             dx 0002, 0004,FD,7113, C3F4,F8,7101
}


;;; $E56F: Spritemap pointers - enemy $D47F (ripper) ;;;
{
$A2:E56F             dw E527, E533, E53F, E54B, E557, E563
}
}


;;; $E57B..E977: Lava seahorse ;;;
{
;;; $E57B: Palette - enemy $D4BF (lava seahorse) ;;;
{
$A2:E57B             dw 3800, 02FF, 01BF, 000F, 0008, 01BF, 011B, 00BA, 0011, 5A5C, 41B4, 290D, 1065, 03FF, 0237, 00D1
}


;;; $E59B: Instruction list -  ;;;
{
$A2:E59B             dx 0001,E80C,
                        812F        ; Sleep
}


;;; $E5A1: Instruction list -  ;;;
{
$A2:E5A1             dx 0005,E8B4,
                        0005,E8BB,
                        80ED,E5A1   ; Go to $E5A1
}


;;; $E5AD: Instruction list -  ;;;
{
$A2:E5AD             dx 0001,E8C2,
                        812F        ; Sleep
}


;;; $E5B3: Instruction list -  ;;;
{
$A2:E5B3             dx 0005,E96A,
                        0005,E971,
                        80ED,E5B3   ; Go to $E5B3
}


;;; $E5BF: Instruction list -  ;;;
{
$A2:E5BF             dx 0020,E836,
                        0003,E860,
                        0007,E88A,
                        0003,E860,
                        0001,E836,
                        E5FB,       ; ???
                        812F        ; Sleep
}


;;; $E5D7: Instruction list -  ;;;
{
$A2:E5D7             dx 0020,E8EC,
                        0003,E916,
                        0007,E940,
                        0003,E916,
                        0001,E8EC,
                        E5FB,       ; ???
                        812F        ; Sleep
}


;;; $E5EF: Instruction list pointers ;;;
{
$A2:E5EF             dw E59B, E5AD, E5A1, E5B3, E5BF, E5D7
}


;;; $E5FB: Instruction ;;;
{
$A2:E5FB AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E5FE A9 01 00    LDA #$0001
$A2:E601 9F 04 78 7E STA $7E7804,x[$7E:7A44]
$A2:E605 6B          RTL
}


;;; $E606: Initialisation AI - enemy $D4BF (lava seahorse) ;;;
{
$A2:E606 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E609 A9 00 00    LDA #$0000
$A2:E60C 9F 04 78 7E STA $7E7804,x[$7E:79C4]
$A2:E610 BD B4 0F    LDA $0FB4,x[$7E:1174]
$A2:E613 F0 21       BEQ $21    [$E636]
$A2:E615 A9 02 00    LDA #$0002
$A2:E618 9F 00 78 7E STA $7E7800,x[$7E:7A00]
$A2:E61C 9F 02 78 7E STA $7E7802,x[$7E:7A02]
$A2:E620 A9 A1 E5    LDA #$E5A1
$A2:E623 9D 92 0F    STA $0F92,x[$7E:1192]
$A2:E626 BD 86 0F    LDA $0F86,x[$7E:1186]
$A2:E629 09 00 04    ORA #$0400
$A2:E62C 9D 86 0F    STA $0F86,x[$7E:1186]
$A2:E62F A9 81 E7    LDA #$E781
$A2:E632 9D B2 0F    STA $0FB2,x[$7E:11B2]
$A2:E635 6B          RTL

$A2:E636 A9 00 00    LDA #$0000
$A2:E639 9F 00 78 7E STA $7E7800,x[$7E:79C0]
$A2:E63D 9F 02 78 7E STA $7E7802,x[$7E:79C2]
$A2:E641 A9 9B E5    LDA #$E59B
$A2:E644 9D 92 0F    STA $0F92,x[$7E:1152]
$A2:E647 A9 54 E6    LDA #$E654
$A2:E64A 9D B2 0F    STA $0FB2,x[$7E:1172]
$A2:E64D 6B          RTL
}


;;; $E64E: Main AI - enemy $D4BF (lava seahorse) ;;;
{
$A2:E64E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E651 7C B2 0F    JMP ($0FB2,x)[$A2:E654]
}


;;; $E654:  ;;;
{
$A2:E654 DE AE 0F    DEC $0FAE,x[$7E:116E]
$A2:E657 30 01       BMI $01    [$E65A]
$A2:E659 6B          RTL

$A2:E65A A9 30 00    LDA #$0030
$A2:E65D 9D AE 0F    STA $0FAE,x[$7E:116E]
$A2:E660 A9 AD E6    LDA #$E6AD
$A2:E663 9D B2 0F    STA $0FB2,x[$7E:1172]
$A2:E666 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]
$A2:E66A A8          TAY
$A2:E66B 3E A8 0F    ROL $0FA8,x[$7E:1168]
$A2:E66E 2A          ROL A
$A2:E66F 7E A8 0F    ROR $0FA8,x[$7E:1168]
$A2:E672 98          TYA
$A2:E673 E2 20       SEP #$20
$A2:E675 3C A9 0F    BIT $0FA9,x[$7E:1169]
$A2:E678 30 16       BMI $16    [$E690]
$A2:E67A BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A2:E67E 09 01       ORA #$01
$A2:E680 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:E684 BF 40 78 7E LDA $7E7840,x[$7E:7840]
$A2:E688 09 01       ORA #$01
$A2:E68A 9F 40 78 7E STA $7E7840,x[$7E:7840]
$A2:E68E 80 14       BRA $14    [$E6A4]

$A2:E690 BF 00 78 7E LDA $7E7800,x[$7E:79C0]
$A2:E694 29 FE       AND #$FE
$A2:E696 9F 00 78 7E STA $7E7800,x[$7E:79C0]
$A2:E69A BF 40 78 7E LDA $7E7840,x[$7E:7A00]
$A2:E69E 29 FE       AND #$FE
$A2:E6A0 9F 40 78 7E STA $7E7840,x[$7E:7A00]

$A2:E6A4 C2 20       REP #$20
$A2:E6A6 20 82 E7    JSR $E782  [$A2:E782]
$A2:E6A9 20 A5 E7    JSR $E7A5  [$A2:E7A5]
$A2:E6AC 6B          RTL
}


;;; $E6AD:  ;;;
{
$A2:E6AD DE AE 0F    DEC $0FAE,x[$7E:116E]
$A2:E6B0 10 18       BPL $18    [$E6CA]
$A2:E6B2 BF 00 78 7E LDA $7E7800,x[$7E:79C0]
$A2:E6B6 18          CLC
$A2:E6B7 69 04 00    ADC #$0004
$A2:E6BA 9F 00 78 7E STA $7E7800,x[$7E:79C0]
$A2:E6BE A9 03 00    LDA #$0003
$A2:E6C1 9D AE 0F    STA $0FAE,x[$7E:116E]
$A2:E6C4 A9 F1 E6    LDA #$E6F1
$A2:E6C7 9D B2 0F    STA $0FB2,x[$7E:1172]

$A2:E6CA BD 80 0F    LDA $0F80,x[$7E:1140]
$A2:E6CD 38          SEC
$A2:E6CE E9 00 00    SBC #$0000
$A2:E6D1 9D 80 0F    STA $0F80,x[$7E:1140]
$A2:E6D4 BD 7E 0F    LDA $0F7E,x[$7E:113E]
$A2:E6D7 E9 01 00    SBC #$0001
$A2:E6DA 9D 7E 0F    STA $0F7E,x[$7E:113E]
$A2:E6DD BD C0 0F    LDA $0FC0,x[$7E:1180]
$A2:E6E0 38          SEC
$A2:E6E1 E9 00 00    SBC #$0000
$A2:E6E4 9D C0 0F    STA $0FC0,x[$7E:1180]
$A2:E6E7 BD BE 0F    LDA $0FBE,x[$7E:117E]
$A2:E6EA E9 01 00    SBC #$0001
$A2:E6ED 9D BE 0F    STA $0FBE,x[$7E:117E]
$A2:E6F0 6B          RTL
}


;;; $E6F1:  ;;;
{
$A2:E6F1 20 82 E7    JSR $E782  [$A2:E782]
$A2:E6F4 BF 04 78 7E LDA $7E7804,x[$7E:79C4]
$A2:E6F8 F0 39       BEQ $39    [$E733]
$A2:E6FA A9 00 00    LDA #$0000
$A2:E6FD 9F 04 78 7E STA $7E7804,x[$7E:7A44]
$A2:E701 A9 FF FF    LDA #$FFFF
$A2:E704 9F 02 78 7E STA $7E7802,x[$7E:7A42]
$A2:E708 A0 CB B5    LDY #$B5CB             ;\
$A2:E70B 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn lava seahorse fireball enemy projectile
$A2:E70F A9 61 00    LDA #$0061             ;\
$A2:E712 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 61h, sound library 2, max queued sounds allowed = 6 (lava seahorse)
$A2:E716 DE AE 0F    DEC $0FAE,x[$7E:11EE]
$A2:E719 D0 18       BNE $18    [$E733]
$A2:E71B BF 00 78 7E LDA $7E7800,x[$7E:7A40]
$A2:E71F 38          SEC
$A2:E720 E9 04 00    SBC #$0004
$A2:E723 9F 00 78 7E STA $7E7800,x[$7E:7A40]
$A2:E727 A9 60 00    LDA #$0060
$A2:E72A 9D AE 0F    STA $0FAE,x[$7E:11EE]
$A2:E72D A9 34 E7    LDA #$E734
$A2:E730 9D B2 0F    STA $0FB2,x[$7E:11F2]

$A2:E733 6B          RTL
}


;;; $E734:  ;;;
{
$A2:E734 DE AE 0F    DEC $0FAE,x[$7E:11EE]
$A2:E737 D0 0F       BNE $0F    [$E748]
$A2:E739 A9 30 00    LDA #$0030
$A2:E73C 9D AE 0F    STA $0FAE,x[$7E:102E]
$A2:E73F A9 49 E7    LDA #$E749
$A2:E742 9D B2 0F    STA $0FB2,x[$7E:1032]
$A2:E745 20 82 E7    JSR $E782  [$A2:E782]

$A2:E748 6B          RTL
}


;;; $E749:  ;;;
{
$A2:E749 DE AE 0F    DEC $0FAE,x[$7E:102E]
$A2:E74C 10 0C       BPL $0C    [$E75A]
$A2:E74E A9 80 00    LDA #$0080
$A2:E751 9D AE 0F    STA $0FAE,x[$7E:102E]
$A2:E754 A9 54 E6    LDA #$E654
$A2:E757 9D B2 0F    STA $0FB2,x[$7E:1032]

$A2:E75A BD 80 0F    LDA $0F80,x[$7E:1000]
$A2:E75D 18          CLC
$A2:E75E 69 00 00    ADC #$0000
$A2:E761 9D 80 0F    STA $0F80,x[$7E:1000]
$A2:E764 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A2:E767 69 01 00    ADC #$0001
$A2:E76A 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:E76D BD C0 0F    LDA $0FC0,x[$7E:1040]
$A2:E770 18          CLC
$A2:E771 69 00 00    ADC #$0000
$A2:E774 9D C0 0F    STA $0FC0,x[$7E:1040]
$A2:E777 BD BE 0F    LDA $0FBE,x[$7E:103E]
$A2:E77A 69 01 00    ADC #$0001
$A2:E77D 9D BE 0F    STA $0FBE,x[$7E:103E]
$A2:E780 6B          RTL
}


;;; $E781: RTL ;;;
{
$A2:E781 6B          RTL
}


;;; $E782:  ;;;
{
$A2:E782 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E785 BF 00 78 7E LDA $7E7800,x[$7E:79C0]
$A2:E789 DF 02 78 7E CMP $7E7802,x[$7E:79C2]
$A2:E78D F0 15       BEQ $15    [$E7A4]
$A2:E78F 9F 02 78 7E STA $7E7802,x[$7E:79C2]
$A2:E793 0A          ASL A
$A2:E794 A8          TAY
$A2:E795 B9 EF E5    LDA $E5EF,y[$A2:E5F7]
$A2:E798 9D 92 0F    STA $0F92,x[$7E:1152]
$A2:E79B A9 01 00    LDA #$0001
$A2:E79E 9D 94 0F    STA $0F94,x[$7E:1154]
$A2:E7A1 9E 90 0F    STZ $0F90,x[$7E:1150]

$A2:E7A4 60          RTS
}


;;; $E7A5:  ;;;
{
$A2:E7A5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E7A8 BF 40 78 7E LDA $7E7840,x[$7E:7A00]
$A2:E7AC DF 42 78 7E CMP $7E7842,x[$7E:7A02]
$A2:E7B0 F0 15       BEQ $15    [$E7C7]
$A2:E7B2 9F 42 78 7E STA $7E7842,x[$7E:7842]
$A2:E7B6 0A          ASL A
$A2:E7B7 A8          TAY
$A2:E7B8 B9 EF E5    LDA $E5EF,y[$A2:E5F5]
$A2:E7BB 9D D2 0F    STA $0FD2,x[$7E:0FD2]
$A2:E7BE A9 01 00    LDA #$0001
$A2:E7C1 9D D4 0F    STA $0FD4,x[$7E:0FD4]
$A2:E7C4 9E D0 0F    STZ $0FD0,x[$7E:0FD0]

$A2:E7C7 60          RTS
}


;;; $E7C8: Enemy touch - enemy $D4BF (lava seahorse) ;;;
{
$A2:E7C8 22 23 80 A2 JSL $A28023[$A2:8023]
$A2:E7CC 80 0C       BRA $0C    [$E7DA]
}


;;; $E7CE: Enemy shot - enemy $D4BF (lava seahorse) ;;;
{
$A2:E7CE 22 2D 80 A2 JSL $A2802D[$A2:802D]
$A2:E7D2 80 06       BRA $06    [$E7DA]
}


;;; $E7D4: Power bomb reaction - enemy $D4BF (lava seahorse) ;;;
{
$A2:E7D4 22 37 80 A2 JSL $A28037[$A2:8037]
$A2:E7D8 80 00       BRA $00    [$E7DA]
}


;;; $E7DA:  ;;;
{
$A2:E7DA AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E7DD BD 8C 0F    LDA $0F8C,x[$7E:114C]
$A2:E7E0 D0 0B       BNE $0B    [$E7ED]
$A2:E7E2 BD C6 0F    LDA $0FC6,x[$7E:1286]
$A2:E7E5 09 00 02    ORA #$0200
$A2:E7E8 9D C6 0F    STA $0FC6,x[$7E:1286]
$A2:E7EB 80 1E       BRA $1E    [$E80B]

$A2:E7ED BD A2 0F    LDA $0FA2,x[$7E:1162]
$A2:E7F0 9D E2 0F    STA $0FE2,x[$7E:11A2]
$A2:E7F3 BD A0 0F    LDA $0FA0,x[$7E:1160]
$A2:E7F6 9D E0 0F    STA $0FE0,x[$7E:11A0]
$A2:E7F9 BD 9C 0F    LDA $0F9C,x[$7E:115C]
$A2:E7FC 9D DC 0F    STA $0FDC,x[$7E:119C]
$A2:E7FF BD 9E 0F    LDA $0F9E,x[$7E:115E]
$A2:E802 9D DE 0F    STA $0FDE,x[$7E:119E]
$A2:E805 BD 8A 0F    LDA $0F8A,x[$7E:114A]
$A2:E808 9D CA 0F    STA $0FCA,x[$7E:118A]

$A2:E80B 6B          RTL
}


;;; $E80C: Lava seahorse spritemaps ;;;
{
$A2:E80C             dx 0008, 0008,04,211C, 0008,FC,210C, 01F0,EC,2110, 0000,04,211D, 01F8,04,210D, 81F9,0C,210E, 81F8,F4,210A, 81F8,E4,2101
$A2:E836             dx 0008, 01F0,E4,2100, 81F8,E4,2103, 0008,04,211C, 0008,FC,210C, 0000,04,211D, 01F8,04,210D, 81F9,0C,210E, 81F8,F4,210A
$A2:E860             dx 0008, 01F0,E5,2105, 81F8,E4,2106, 0008,04,211C, 0008,FC,210C, 0000,04,211D, 01F8,04,210D, 81F9,0C,210E, 81F8,F4,210A
$A2:E88A             dx 0008, 01F0,E5,2115, 81F8,E4,2108, 0008,04,211C, 0008,FC,210C, 0000,04,211D, 01F8,04,210D, 81F9,0C,210E, 81F8,F4,210A
$A2:E8B4             dx 0001, 0004,F4,2120
$A2:E8BB             dx 0001, 0004,F4,2121
$A2:E8C2             dx 0008, 01F0,04,611C, 01F0,FC,610C, 0008,EC,6110, 01F8,04,611D, 0000,04,610D, 81F7,0C,610E, 81F8,F4,610A, 81F8,E4,6101
$A2:E8EC             dx 0008, 0008,E4,6100, 81F8,E4,6103, 01F0,04,611C, 01F0,FC,610C, 01F8,04,611D, 0000,04,610D, 81F7,0C,610E, 81F8,F4,610A
$A2:E916             dx 0008, 0008,E5,6105, 81F8,E4,6106, 01F0,04,611C, 01F0,FC,610C, 01F8,04,611D, 0000,04,610D, 81F7,0C,610E, 81F8,F4,610A
$A2:E940             dx 0008, 0008,E5,6115, 81F8,E4,6108, 01F0,04,611C, 01F0,FC,610C, 01F8,04,611D, 0000,04,610D, 81F7,0C,610E, 81F8,F4,610A
$A2:E96A             dx 0001, 01F4,F4,6120
$A2:E971             dx 0001, 01F4,F4,6121
}
}


;;; $E978..F497: Shutters ;;;
{
;;; $E978: Palette - enemy $D4FF/$D53F/$D57F/$D5BF (shutters) ;;;
{
$A2:E978             dw 3800, 4D1F, 38B6, 246E, 1448, 47FF, 2EFA, 1616, 0132, 6F39, 5A73, 41AD, 2D08, 1863, 7FFF, 0041
}


;;; $E998: Instruction list -  ;;;
{
$A2:E998             dx 0001,ED44,
                        812F        ; Sleep
}


;;; $E99E: Instruction list -  ;;;
{
$A2:E99E             dx 0001,ED57,
                        812F        ; Sleep
}


;;; $E9A4: Instruction list -  ;;;
{
$A2:E9A4             dx 0001,ED74,
                        812F        ; Sleep
}


;;; $E9AA: Instruction list -  ;;;
{
$A2:E9AA             dx 0001,ED9B,
                        812F        ; Sleep
}


;;; $E9B0: Instruction list -  ;;;
{
$A2:E9B0             dx 0004,ED9B,
                        0004,ED85,
                        0004,ED74,
                        0004,ED63,
                        0004,ED57,
                        0004,ED4B,
                        0004,ED44,
                        0004,ED38,
                        80ED,E9B0   ; Go to $E9B0
}


;;; $E9D4: Instruction list -  ;;;
{
$A2:E9D4             dx 0001,EDB1,
                        812F        ; Sleep
}


;;; $E9DA: Initialisation AI - enemy $D4FF (timed shutter) ;;;
{
$A2:E9DA AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:E9DD BD 88 0F    LDA $0F88,x[$7E:1008]
$A2:E9E0 0A          ASL A
$A2:E9E1 18          CLC
$A2:E9E2 7D 92 0F    ADC $0F92,x[$7E:1012]
$A2:E9E5 0A          ASL A
$A2:E9E6 A8          TAY
$A2:E9E7 B9 4E EA    LDA $EA4E,y[$A2:EA50]
$A2:E9EA 9D A8 0F    STA $0FA8,x[$7E:1028]
$A2:E9ED BD 88 0F    LDA $0F88,x[$7E:1008]
$A2:E9F0 F0 1D       BEQ $1D    [$EA0F]
$A2:E9F2 BD 7E 0F    LDA $0F7E,x
$A2:E9F5 9D AA 0F    STA $0FAA,x
$A2:E9F8 38          SEC
$A2:E9F9 E9 08 00    SBC #$0008
$A2:E9FC 9D AC 0F    STA $0FAC,x
$A2:E9FF 38          SEC
$A2:EA00 E9 08 00    SBC #$0008
$A2:EA03 9D AE 0F    STA $0FAE,x
$A2:EA06 38          SEC
$A2:EA07 E9 08 00    SBC #$0008
$A2:EA0A 9D B0 0F    STA $0FB0,x
$A2:EA0D 80 1B       BRA $1B    [$EA2A]

$A2:EA0F BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A2:EA12 9D AA 0F    STA $0FAA,x[$7E:102A]
$A2:EA15 18          CLC
$A2:EA16 69 08 00    ADC #$0008
$A2:EA19 9D AC 0F    STA $0FAC,x[$7E:102C]
$A2:EA1C 18          CLC
$A2:EA1D 69 08 00    ADC #$0008
$A2:EA20 9D AE 0F    STA $0FAE,x[$7E:102E]
$A2:EA23 18          CLC
$A2:EA24 69 08 00    ADC #$0008
$A2:EA27 9D B0 0F    STA $0FB0,x[$7E:1030]

$A2:EA2A 9E 88 0F    STZ $0F88,x[$7E:1008]
$A2:EA2D 9E B2 0F    STZ $0FB2,x[$7E:1032]
$A2:EA30 A9 98 E9    LDA #$E998
$A2:EA33 9D 92 0F    STA $0F92,x[$7E:1012]
$A2:EA36 BD B6 0F    LDA $0FB6,x[$7E:1036]
$A2:EA39 29 FF 00    AND #$00FF
$A2:EA3C 0A          ASL A
$A2:EA3D 0A          ASL A
$A2:EA3E A8          TAY
$A2:EA3F B9 56 EA    LDA $EA56,y[$A2:EA96]
$A2:EA42 9F 00 78 7E STA $7E7800,x[$7E:7880]
$A2:EA46 B9 58 EA    LDA $EA58,y[$A2:EA98]
$A2:EA49 9F 02 78 7E STA $7E7802,x[$7E:7882]
$A2:EA4D 6B          RTL

$A2:EA4E             dw EAFD, EAE7, EABD, EAD1
}


;;; $EA56:  ;;;
{
$A2:EA56             dw 0000,1000, 0000,2000, 0000,3000, 0000,4000, 0000,5000, 0000,6000, 0000,7000, 0000,8000,
                        0000,9000, 0000,A000, 0000,B000, 0000,C000, 0000,D000, 0000,E000, 0000,F000, 0001,0000,
                        0001,1000, 0001,2000, 0001,3000, 0001,4000, 0001,5000, 0001,6000, 0001,7000, 0001,8000
}


;;; $EAB6: Main AI - enemy $D4FF (timed shutter) ;;;
{
$A2:EAB6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EAB9 FC A8 0F    JSR ($0FA8,x)[$A2:EAE7]
$A2:EABC 6B          RTL
}


;;; $EABD:  ;;;
{
$A2:EABD BD B4 0F    LDA $0FB4,x
$A2:EAC0 F0 05       BEQ $05    [$EAC7]
$A2:EAC2 3A          DEC A
$A2:EAC3 9D B4 0F    STA $0FB4,x
$A2:EAC6 60          RTS

$A2:EAC7 20 5A EF    JSR $EF5A  [$A2:EF5A]
$A2:EACA A9 13 EC    LDA #$EC13
$A2:EACD 9D A8 0F    STA $0FA8,x
$A2:EAD0 60          RTS
}


;;; $EAD1:  ;;;
{
$A2:EAD1 BD B4 0F    LDA $0FB4,x
$A2:EAD4 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:EAD8 29 FF FF    AND #$FFFF
$A2:EADB F0 09       BEQ $09    [$EAE6]
$A2:EADD 20 5A EF    JSR $EF5A  [$A2:EF5A]
$A2:EAE0 A9 13 EC    LDA #$EC13
$A2:EAE3 9D A8 0F    STA $0FA8,x

$A2:EAE6 60          RTS
}


;;; $EAE7:  ;;;
{
$A2:EAE7 BD B4 0F    LDA $0FB4,x[$7E:1034]
$A2:EAEA 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:EAEE 29 FF FF    AND #$FFFF
$A2:EAF1 F0 09       BEQ $09    [$EAFC]
$A2:EAF3 20 5A EF    JSR $EF5A  [$A2:EF5A]
$A2:EAF6 A9 11 EB    LDA #$EB11
$A2:EAF9 9D A8 0F    STA $0FA8,x[$7E:1028]

$A2:EAFC 60          RTS
}


;;; $EAFD:  ;;;
{
$A2:EAFD BD B4 0F    LDA $0FB4,x
$A2:EB00 F0 05       BEQ $05    [$EB07]
$A2:EB02 3A          DEC A
$A2:EB03 9D B4 0F    STA $0FB4,x
$A2:EB06 60          RTS

$A2:EB07 20 5A EF    JSR $EF5A  [$A2:EF5A]
$A2:EB0A A9 11 EB    LDA #$EB11
$A2:EB0D 9D A8 0F    STA $0FA8,x
$A2:EB10 60          RTS
}


;;; $EB11:  ;;;
{
$A2:EB11 BD B2 0F    LDA $0FB2,x[$7E:1032]
$A2:EB14 0A          ASL A
$A2:EB15 AA          TAX
$A2:EB16 FC 1A EB    JSR ($EB1A,x)[$A2:EB25]
$A2:EB19 60          RTS

$A2:EB1A             dw EB25, EB66, EBA7, EBE8, EB24
}


;;; $EB24: RTS ;;;
{
$A2:EB24 60          RTS
}


;;; $EB25:  ;;;
{
$A2:EB25 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EB28 BD 80 0F    LDA $0F80,x[$7E:1000]
$A2:EB2B 18          CLC
$A2:EB2C 7F 02 78 7E ADC $7E7802,x[$7E:7882]
$A2:EB30 9D 80 0F    STA $0F80,x[$7E:1000]
$A2:EB33 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A2:EB36 7F 00 78 7E ADC $7E7800,x[$7E:7880]
$A2:EB3A 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:EB3D BD AA 0F    LDA $0FAA,x[$7E:102A]
$A2:EB40 18          CLC
$A2:EB41 69 10 00    ADC #$0010
$A2:EB44 DD 7E 0F    CMP $0F7E,x[$7E:0FFE]
$A2:EB47 10 1C       BPL $1C    [$EB65]
$A2:EB49 38          SEC
$A2:EB4A E9 07 00    SBC #$0007
$A2:EB4D 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:EB50 FE B2 0F    INC $0FB2,x[$7E:1032]
$A2:EB53 A9 01 00    LDA #$0001
$A2:EB56 9D 94 0F    STA $0F94,x[$7E:1014]
$A2:EB59 A9 9E E9    LDA #$E99E
$A2:EB5C 9D 92 0F    STA $0F92,x[$7E:1012]
$A2:EB5F A9 10 00    LDA #$0010
$A2:EB62 9D 84 0F    STA $0F84,x[$7E:1004]

$A2:EB65 60          RTS
}


;;; $EB66:  ;;;
{
$A2:EB66 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EB69 BD 80 0F    LDA $0F80,x[$7E:1000]
$A2:EB6C 18          CLC
$A2:EB6D 7F 02 78 7E ADC $7E7802,x[$7E:7882]
$A2:EB71 9D 80 0F    STA $0F80,x[$7E:1000]
$A2:EB74 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A2:EB77 7F 00 78 7E ADC $7E7800,x[$7E:7880]
$A2:EB7B 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:EB7E BD AC 0F    LDA $0FAC,x[$7E:102C]
$A2:EB81 18          CLC
$A2:EB82 69 10 00    ADC #$0010
$A2:EB85 DD 7E 0F    CMP $0F7E,x[$7E:0FFE]
$A2:EB88 10 1C       BPL $1C    [$EBA6]
$A2:EB8A 38          SEC
$A2:EB8B E9 07 00    SBC #$0007
$A2:EB8E 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:EB91 FE B2 0F    INC $0FB2,x[$7E:1032]
$A2:EB94 A9 01 00    LDA #$0001
$A2:EB97 9D 94 0F    STA $0F94,x[$7E:1014]
$A2:EB9A A9 A4 E9    LDA #$E9A4
$A2:EB9D 9D 92 0F    STA $0F92,x[$7E:1012]
$A2:EBA0 A9 18 00    LDA #$0018
$A2:EBA3 9D 84 0F    STA $0F84,x[$7E:1004]

$A2:EBA6 60          RTS
}


;;; $EBA7:  ;;;
{
$A2:EBA7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EBAA BD 80 0F    LDA $0F80,x[$7E:1000]
$A2:EBAD 18          CLC
$A2:EBAE 7F 02 78 7E ADC $7E7802,x[$7E:7882]
$A2:EBB2 9D 80 0F    STA $0F80,x[$7E:1000]
$A2:EBB5 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A2:EBB8 7F 00 78 7E ADC $7E7800,x[$7E:7880]
$A2:EBBC 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:EBBF BD AE 0F    LDA $0FAE,x[$7E:102E]
$A2:EBC2 18          CLC
$A2:EBC3 69 10 00    ADC #$0010
$A2:EBC6 DD 7E 0F    CMP $0F7E,x[$7E:0FFE]
$A2:EBC9 10 1C       BPL $1C    [$EBE7]
$A2:EBCB 38          SEC
$A2:EBCC E9 07 00    SBC #$0007
$A2:EBCF 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:EBD2 FE B2 0F    INC $0FB2,x[$7E:1032]
$A2:EBD5 A9 01 00    LDA #$0001
$A2:EBD8 9D 94 0F    STA $0F94,x[$7E:1014]
$A2:EBDB A9 AA E9    LDA #$E9AA
$A2:EBDE 9D 92 0F    STA $0F92,x[$7E:1012]
$A2:EBE1 A9 20 00    LDA #$0020
$A2:EBE4 9D 84 0F    STA $0F84,x[$7E:1004]

$A2:EBE7 60          RTS
}


;;; $EBE8:  ;;;
{
$A2:EBE8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EBEB BD 80 0F    LDA $0F80,x[$7E:1000]
$A2:EBEE 18          CLC
$A2:EBEF 7F 02 78 7E ADC $7E7802,x[$7E:7882]
$A2:EBF3 9D 80 0F    STA $0F80,x[$7E:1000]
$A2:EBF6 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A2:EBF9 7F 00 78 7E ADC $7E7800,x[$7E:7880]
$A2:EBFD 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:EC00 BD B0 0F    LDA $0FB0,x[$7E:1030]
$A2:EC03 18          CLC
$A2:EC04 69 10 00    ADC #$0010
$A2:EC07 DD 7E 0F    CMP $0F7E,x[$7E:0FFE]
$A2:EC0A 10 06       BPL $06    [$EC12]
$A2:EC0C 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:EC0F FE B2 0F    INC $0FB2,x[$7E:1032]

$A2:EC12 60          RTS
}


;;; $EC13:  ;;;
{
$A2:EC13 BD 7E 0F    LDA $0F7E,x
$A2:EC16 9F 00 88 7E STA $7E8800,x
$A2:EC1A BD B2 0F    LDA $0FB2,x
$A2:EC1D 0A          ASL A
$A2:EC1E AA          TAX
$A2:EC1F FC 3A EC    JSR ($EC3A,x)
$A2:EC22 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:EC26 F0 11       BEQ $11    [$EC39]     ;} If enemy is touching Samus from below:
$A2:EC28 BD 7E 0F    LDA $0F7E,x
$A2:EC2B 38          SEC
$A2:EC2C FF 00 88 7E SBC $7E8800,x
$A2:EC30 10 07       BPL $07    [$EC39]
$A2:EC32 18          CLC                    ;\
$A2:EC33 6D 5C 0B    ADC $0B5C  [$7E:0B5C]  ;} Extra Samus Y displacement += [A]
$A2:EC36 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/

$A2:EC39 60          RTS

$A2:EC3A             dw EC45, EC86, ECC7, ED08, EC44
}


;;; $EC44: RTS ;;;
{
$A2:EC44 60          RTS
}


;;; $EC45:  ;;;
{
$A2:EC45 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EC48 BD 80 0F    LDA $0F80,x
$A2:EC4B 38          SEC
$A2:EC4C FF 02 78 7E SBC $7E7802,x
$A2:EC50 9D 80 0F    STA $0F80,x
$A2:EC53 BD 7E 0F    LDA $0F7E,x
$A2:EC56 FF 00 78 7E SBC $7E7800,x
$A2:EC5A 9D 7E 0F    STA $0F7E,x
$A2:EC5D BD AA 0F    LDA $0FAA,x
$A2:EC60 38          SEC
$A2:EC61 E9 10 00    SBC #$0010
$A2:EC64 DD 7E 0F    CMP $0F7E,x
$A2:EC67 30 1C       BMI $1C    [$EC85]
$A2:EC69 18          CLC
$A2:EC6A 69 07 00    ADC #$0007
$A2:EC6D 9D 7E 0F    STA $0F7E,x
$A2:EC70 FE B2 0F    INC $0FB2,x
$A2:EC73 A9 01 00    LDA #$0001
$A2:EC76 9D 94 0F    STA $0F94,x
$A2:EC79 A9 9E E9    LDA #$E99E
$A2:EC7C 9D 92 0F    STA $0F92,x
$A2:EC7F A9 10 00    LDA #$0010
$A2:EC82 9D 84 0F    STA $0F84,x

$A2:EC85 60          RTS
}


;;; $EC86:  ;;;
{
$A2:EC86 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EC89 BD 80 0F    LDA $0F80,x
$A2:EC8C 38          SEC
$A2:EC8D FF 02 78 7E SBC $7E7802,x
$A2:EC91 9D 80 0F    STA $0F80,x
$A2:EC94 BD 7E 0F    LDA $0F7E,x
$A2:EC97 FF 00 78 7E SBC $7E7800,x
$A2:EC9B 9D 7E 0F    STA $0F7E,x
$A2:EC9E BD AC 0F    LDA $0FAC,x
$A2:ECA1 38          SEC
$A2:ECA2 E9 10 00    SBC #$0010
$A2:ECA5 DD 7E 0F    CMP $0F7E,x
$A2:ECA8 30 1C       BMI $1C    [$ECC6]
$A2:ECAA 18          CLC
$A2:ECAB 69 07 00    ADC #$0007
$A2:ECAE 9D 7E 0F    STA $0F7E,x
$A2:ECB1 FE B2 0F    INC $0FB2,x
$A2:ECB4 A9 01 00    LDA #$0001
$A2:ECB7 9D 94 0F    STA $0F94,x
$A2:ECBA A9 A4 E9    LDA #$E9A4
$A2:ECBD 9D 92 0F    STA $0F92,x
$A2:ECC0 A9 18 00    LDA #$0018
$A2:ECC3 9D 84 0F    STA $0F84,x

$A2:ECC6 60          RTS
}


;;; $ECC7:  ;;;
{
$A2:ECC7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:ECCA BD 80 0F    LDA $0F80,x
$A2:ECCD 38          SEC
$A2:ECCE FF 02 78 7E SBC $7E7802,x
$A2:ECD2 9D 80 0F    STA $0F80,x
$A2:ECD5 BD 7E 0F    LDA $0F7E,x
$A2:ECD8 FF 00 78 7E SBC $7E7800,x
$A2:ECDC 9D 7E 0F    STA $0F7E,x
$A2:ECDF BD AE 0F    LDA $0FAE,x
$A2:ECE2 38          SEC
$A2:ECE3 E9 10 00    SBC #$0010
$A2:ECE6 DD 7E 0F    CMP $0F7E,x
$A2:ECE9 30 1C       BMI $1C    [$ED07]
$A2:ECEB 18          CLC
$A2:ECEC 69 07 00    ADC #$0007
$A2:ECEF 9D 7E 0F    STA $0F7E,x
$A2:ECF2 FE B2 0F    INC $0FB2,x
$A2:ECF5 A9 01 00    LDA #$0001
$A2:ECF8 9D 94 0F    STA $0F94,x
$A2:ECFB A9 AA E9    LDA #$E9AA
$A2:ECFE 9D 92 0F    STA $0F92,x
$A2:ED01 A9 20 00    LDA #$0020
$A2:ED04 9D 84 0F    STA $0F84,x

$A2:ED07 60          RTS
}


;;; $ED08:  ;;;
{
$A2:ED08 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:ED0B BD 80 0F    LDA $0F80,x
$A2:ED0E 38          SEC
$A2:ED0F FF 02 78 7E SBC $7E7802,x
$A2:ED13 9D 80 0F    STA $0F80,x
$A2:ED16 BD 7E 0F    LDA $0F7E,x
$A2:ED19 FF 00 78 7E SBC $7E7800,x
$A2:ED1D 9D 7E 0F    STA $0F7E,x
$A2:ED20 BD B0 0F    LDA $0FB0,x
$A2:ED23 38          SEC
$A2:ED24 E9 10 00    SBC #$0010
$A2:ED27 DD 7E 0F    CMP $0F7E,x
$A2:ED2A 30 06       BMI $06    [$ED32]
$A2:ED2C 9D 7E 0F    STA $0F7E,x
$A2:ED2F FE B2 0F    INC $0FB2,x

$A2:ED32 60          RTS
}


;;; $ED33:  ;;;
{
$A2:ED33 A9 05 00    LDA #$0005
$A2:ED36 6B          RTL
}


;;; $ED37: RTL ;;;
{
$A2:ED37 6B          RTL
}


;;; $ED38: Shutters spritemaps ;;;
{
$A2:ED38             dx 0002, 0000,FC,2101, 01F8,FC,2100
$A2:ED44             dx 0001, C3F8,F8,2100
$A2:ED4B             dx 0002, C3F8,FC,2100, C3F8,F4,2100
$A2:ED57             dx 0002, C3F8,00,2100, C3F8,F0,2100
$A2:ED63             dx 0003, C3F8,F8,2100, C3F8,04,2100, C3F8,EC,2100
$A2:ED74             dx 0003, C3F8,08,2100, C3F8,F8,2100, C3F8,E8,2100
$A2:ED85             dx 0004, C3F8,0C,2100, C3F8,00,2100, C3F8,F0,2100, C3F8,E4,2100
$A2:ED9B             dx 0004, C3F8,10,2100, C3F8,00,2100, C3F8,F0,2100, C3F8,E0,2100
$A2:EDB1             dx 0004, 81E0,F8,2102, 8010,F8,2102, 8000,F8,2102, 81F0,F8,2102
}


;;; $EDC7: Palette - enemy $D5FF (rising and falling platform) ;;;
{
$A2:EDC7             dw 3800, 7F5A, 3BE0, 2680, 0920, 4F5A, 36B5, 2610, 1DCE, 5294, 39CE, 2108, 1084, 033B, 0216, 0113
}


;;; $EDE7: Instruction list -  ;;;
{
$A2:EDE7             dx 000A,F468,
                        000A,F474,
                        000A,F480,
                        000A,F48C,
                        80ED,EDE7   ; Go to $EDE7
}


;;; $EDFB:  ;;;
{
$A2:EDFB             dw EF15, EF28, EF39, EF40, EF40
}


;;; $EE05: Initialisation AI - enemy $D5FF (rising and falling platform) ;;;
{
$A2:EE05 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EE08 20 1F EE    JSR $EE1F  [$A2:EE1F]
$A2:EE0B A9 E7 ED    LDA #$EDE7
$A2:EE0E 9D 92 0F    STA $0F92,x[$7E:1012]
$A2:EE11 6B          RTL
}


;;; $EE12: Initialisation AI - enemy $D53F/$D5BF (shootable shutter / destroyable timed shutter) ;;;
{
$A2:EE12 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EE15 20 1F EE    JSR $EE1F  [$A2:EE1F]
$A2:EE18 A9 AA E9    LDA #$E9AA
$A2:EE1B 9D 92 0F    STA $0F92,x[$7E:0F92]
$A2:EE1E 6B          RTL
}


;;; $EE1F:  ;;;
{
$A2:EE1F BD 92 0F    LDA $0F92,x[$7E:0F92]
$A2:EE22 29 FF 00    AND #$00FF
$A2:EE25 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A2:EE29 0A          ASL A
$A2:EE2A 0A          ASL A
$A2:EE2B 0A          ASL A
$A2:EE2C A8          TAY
$A2:EE2D B9 87 81    LDA $8187,y[$A2:81C7]
$A2:EE30 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A2:EE33 B9 89 81    LDA $8189,y[$A2:81C9]
$A2:EE36 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A2:EE39 B9 8B 81    LDA $818B,y[$A2:81CB]
$A2:EE3C 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A2:EE3F B9 8D 81    LDA $818D,y[$A2:81CD]
$A2:EE42 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A2:EE45 BD 93 0F    LDA $0F93,x[$7E:0F93]
$A2:EE48 29 FF 00    AND #$00FF
$A2:EE4B 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A2:EE4F 9F 00 80 7E STA $7E8000,x[$7E:8000]
$A2:EE53 BD 88 0F    LDA $0F88,x[$7E:0F88]
$A2:EE56 29 FF 00    AND #$00FF
$A2:EE59 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A2:EE5D 0A          ASL A
$A2:EE5E 0A          ASL A
$A2:EE5F 0A          ASL A
$A2:EE60 0A          ASL A
$A2:EE61 9F 10 78 7E STA $7E7810,x[$7E:7810]
$A2:EE65 BD 89 0F    LDA $0F89,x[$7E:0F89]
$A2:EE68 29 FF 00    AND #$00FF
$A2:EE6B 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A2:EE6F 0A          ASL A
$A2:EE70 0A          ASL A
$A2:EE71 0A          ASL A
$A2:EE72 0A          ASL A
$A2:EE73 9F 12 78 7E STA $7E7812,x[$7E:7812]
$A2:EE77 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A2:EE7A 29 FF 00    AND #$00FF
$A2:EE7D 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A2:EE81 0A          ASL A
$A2:EE82 9F 0E 78 7E STA $7E780E,x[$7E:780E]
$A2:EE86 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A2:EE89 29 FF 00    AND #$00FF
$A2:EE8C 9F 0A 78 7E STA $7E780A,x[$7E:780A]
$A2:EE90 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A2:EE93 9F 0C 78 7E STA $7E780C,x[$7E:780C]
$A2:EE97 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A2:EE9A BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A2:EE9D 9F 1E 78 7E STA $7E781E,x[$7E:781E]
$A2:EEA1 18          CLC
$A2:EEA2 7F 0A 78 7E ADC $7E780A,x[$7E:780A]
$A2:EEA6 9F 20 78 7E STA $7E7820,x[$7E:7820]
$A2:EEAA BF 02 78 7E LDA $7E7802,x[$7E:7802]
$A2:EEAE D0 10       BNE $10    [$EEC0]
$A2:EEB0 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A2:EEB3 9F 20 78 7E STA $7E7820,x[$7E:7820]
$A2:EEB7 38          SEC
$A2:EEB8 FF 0A 78 7E SBC $7E780A,x[$7E:780A]
$A2:EEBC 9F 1E 78 7E STA $7E781E,x[$7E:781E]

$A2:EEC0 A9 09 EF    LDA #$EF09
$A2:EEC3 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:EEC6 A9 00 00    LDA #$0000
$A2:EEC9 9D 88 0F    STA $0F88,x[$7E:0F88]
$A2:EECC 9F 14 78 7E STA $7E7814,x[$7E:7814]
$A2:EED0 60          RTS
}


;;; $EED1: Main AI - enemy $D53F/$D5BF/$D5FF (shootable shutter / destroyable timed shutter / rising and falling platform) ;;;
{
$A2:EED1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EED4 FC A8 0F    JSR ($0FA8,x)[$A2:EF09]
$A2:EED7 BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A2:EEDA C9 68 EF    CMP #$EF68
$A2:EEDD D0 02       BNE $02    [$EEE1]
$A2:EEDF 80 27       BRA $27    [$EF08]

$A2:EEE1 BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A2:EEE4 C9 D4 EF    CMP #$EFD4
$A2:EEE7 F0 1F       BEQ $1F    [$EF08]
$A2:EEE9 AD 2C 18    LDA $182C  [$7E:182C]
$A2:EEEC 2D 2E 18    AND $182E  [$7E:182E]
$A2:EEEF 2D 30 18    AND $1830  [$7E:1830]
$A2:EEF2 2D 32 18    AND $1832  [$7E:1832]
$A2:EEF5 C9 FF FF    CMP #$FFFF
$A2:EEF8 F0 0E       BEQ $0E    [$EF08]
$A2:EEFA CD 54 0E    CMP $0E54  [$7E:0E54]
$A2:EEFD D0 09       BNE $09    [$EF08]
$A2:EEFF AD 6E 0A    LDA $0A6E  [$7E:0A6E]
$A2:EF02 F0 04       BEQ $04    [$EF08]
$A2:EF04 22 B6 F0 A2 JSL $A2F0B6[$A2:F0B6]

$A2:EF08 6B          RTL
}


;;; $EF09:  ;;;
{
$A2:EF09 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EF0C BF 0E 78 7E LDA $7E780E,x[$7E:780E]
$A2:EF10 AA          TAX
$A2:EF11 FC FB ED    JSR ($EDFB,x)[$A2:EF40]
$A2:EF14 60          RTS
}


;;; $EF15:  ;;;
{
$A2:EF15 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EF18 DE AA 0F    DEC $0FAA,x[$7E:116A]
$A2:EF1B D0 0A       BNE $0A    [$EF27]
$A2:EF1D BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A2:EF21 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A2:EF24 20 44 EF    JSR $EF44  [$A2:EF44]

$A2:EF27 60          RTS
}


;;; $EF28:  ;;;
{
$A2:EF28 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EF2B BF 0C 78 7E LDA $7E780C,x[$7E:788C]
$A2:EF2F 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:EF33 F0 03       BEQ $03    [$EF38]
$A2:EF35 20 44 EF    JSR $EF44  [$A2:EF44]

$A2:EF38 60          RTS
}


;;; $EF39:  ;;;
{
$A2:EF39 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EF3C 20 44 EF    JSR $EF44  [$A2:EF44]
$A2:EF3F 60          RTS
}


;;; $EF40:  ;;;
{
$A2:EF40 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EF43 60          RTS
}


;;; $EF44:  ;;;
{
$A2:EF44 A9 68 EF    LDA #$EF68
$A2:EF47 9D A8 0F    STA $0FA8,x[$7E:1028]
$A2:EF4A BF 02 78 7E LDA $7E7802,x[$7E:7882]
$A2:EF4E F0 06       BEQ $06    [$EF56]
$A2:EF50 A9 D4 EF    LDA #$EFD4
$A2:EF53 9D A8 0F    STA $0FA8,x[$7E:1028]

$A2:EF56 20 5A EF    JSR $EF5A  [$A2:EF5A]
$A2:EF59 60          RTS
}


;;; $EF5A:  ;;;
{
$A2:EF5A 22 70 AD A0 JSL $A0AD70[$A0:AD70]
$A2:EF5E D0 07       BNE $07    [$EF67]
$A2:EF60 A9 0E 00    LDA #$000E             ;\
$A2:EF63 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound Eh, sound library 3, max queued sounds allowed = 6 (gate opening/closing)

$A2:EF67 60          RTS
}


;;; $EF68:  ;;;
{
$A2:EF68 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EF6B BD 7E 0F    LDA $0F7E,x[$7E:103E]
$A2:EF6E 9F 1C 78 7E STA $7E781C,x[$7E:78DC]
$A2:EF72 A9 00 00    LDA #$0000
$A2:EF75 9F 14 78 7E STA $7E7814,x[$7E:78D4]
$A2:EF79 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:EF7D F0 07       BEQ $07    [$EF86]     ;} If enemy is touching Samus from below:
$A2:EF7F A9 01 00    LDA #$0001
$A2:EF82 9F 14 78 7E STA $7E7814,x[$7E:78D4]

$A2:EF86 BD 80 0F    LDA $0F80,x[$7E:1040]
$A2:EF89 18          CLC
$A2:EF8A 7D B0 0F    ADC $0FB0,x[$7E:1070]
$A2:EF8D 90 03       BCC $03    [$EF92]
$A2:EF8F FE 7E 0F    INC $0F7E,x[$7E:103E]

$A2:EF92 9D 80 0F    STA $0F80,x[$7E:1040]
$A2:EF95 BD 7E 0F    LDA $0F7E,x[$7E:103E]
$A2:EF98 18          CLC
$A2:EF99 7D B2 0F    ADC $0FB2,x[$7E:1072]
$A2:EF9C 9D 7E 0F    STA $0F7E,x[$7E:103E]
$A2:EF9F BF 14 78 7E LDA $7E7814,x[$7E:78D4]
$A2:EFA3 F0 0B       BEQ $0B    [$EFB0]
$A2:EFA5 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$A2:EFA8 38          SEC                    ;|
$A2:EFA9 FF 1C 78 7E SBC $7E781C,x[$7E:78DC];} Extra Samus Y displacement = [enemy Y position] - [enemy $7E:781C]
$A2:EFAD 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/

$A2:EFB0 BF 1E 78 7E LDA $7E781E,x[$7E:78DE]
$A2:EFB4 DD 7E 0F    CMP $0F7E,x[$7E:103E]
$A2:EFB7 30 1A       BMI $1A    [$EFD3]
$A2:EFB9 BF 10 78 7E LDA $7E7810,x[$7E:78D0]
$A2:EFBD C9 F0 0F    CMP #$0FF0
$A2:EFC0 F0 0B       BEQ $0B    [$EFCD]
$A2:EFC2 9D AA 0F    STA $0FAA,x[$7E:106A]
$A2:EFC5 A9 40 F0    LDA #$F040
$A2:EFC8 9D A8 0F    STA $0FA8,x[$7E:1068]
$A2:EFCB 80 06       BRA $06    [$EFD3]

$A2:EFCD A9 99 F0    LDA #$F099
$A2:EFD0 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:EFD3 60          RTS
}


;;; $EFD4:  ;;;
{
$A2:EFD4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:EFD7 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A2:EFDA 9F 1C 78 7E STA $7E781C,x[$7E:789C]
$A2:EFDE A9 00 00    LDA #$0000
$A2:EFE1 9F 14 78 7E STA $7E7814,x[$7E:7894]
$A2:EFE5 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A2:EFE9 F0 07       BEQ $07    [$EFF2]     ;} If enemy is touching Samus from below:
$A2:EFEB A9 01 00    LDA #$0001
$A2:EFEE 9F 14 78 7E STA $7E7814,x[$7E:7894]

$A2:EFF2 BD 80 0F    LDA $0F80,x[$7E:1000]
$A2:EFF5 18          CLC
$A2:EFF6 7D AC 0F    ADC $0FAC,x[$7E:102C]
$A2:EFF9 90 03       BCC $03    [$EFFE]
$A2:EFFB FE 7E 0F    INC $0F7E,x[$7E:0FFE]

$A2:EFFE 9D 80 0F    STA $0F80,x[$7E:1000]
$A2:F001 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A2:F004 18          CLC
$A2:F005 7D AE 0F    ADC $0FAE,x[$7E:102E]
$A2:F008 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A2:F00B BF 14 78 7E LDA $7E7814,x[$7E:7894]
$A2:F00F F0 0B       BEQ $0B    [$F01C]
$A2:F011 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A2:F014 38          SEC                    ;|
$A2:F015 FF 1C 78 7E SBC $7E781C,x[$7E:789C];} Extra Samus Y displacement = [enemy Y position] - [enemy $7E:781C]
$A2:F019 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/

$A2:F01C BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A2:F01F DF 20 78 7E CMP $7E7820,x[$7E:78A0]
$A2:F023 30 1A       BMI $1A    [$F03F]
$A2:F025 BF 12 78 7E LDA $7E7812,x[$7E:7892]
$A2:F029 C9 F0 0F    CMP #$0FF0
$A2:F02C F0 0B       BEQ $0B    [$F039]
$A2:F02E 9D AA 0F    STA $0FAA,x[$7E:102A]
$A2:F031 A9 72 F0    LDA #$F072
$A2:F034 9D A8 0F    STA $0FA8,x[$7E:1028]
$A2:F037 80 06       BRA $06    [$F03F]

$A2:F039 A9 99 F0    LDA #$F099
$A2:F03C 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:F03F 60          RTS
}


;;; $F040:  ;;;
{
$A2:F040 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F043 DE AA 0F    DEC $0FAA,x[$7E:106A]
$A2:F046 10 29       BPL $29    [$F071]
$A2:F048 A9 D4 EF    LDA #$EFD4
$A2:F04B 9D A8 0F    STA $0FA8,x[$7E:1068]
$A2:F04E BF 08 78 7E LDA $7E7808,x[$7E:78C8]
$A2:F052 C9 01 00    CMP #$0001
$A2:F055 D0 0C       BNE $0C    [$F063]
$A2:F057 BF 02 78 7E LDA $7E7802,x[$7E:78C2]
$A2:F05B F0 06       BEQ $06    [$F063]
$A2:F05D A9 28 EF    LDA #$EF28
$A2:F060 9D A8 0F    STA $0FA8,x[$7E:1028]

$A2:F063 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F066 BD 78 0F    LDA $0F78,x[$7E:1038]
$A2:F069 C9 3F D8    CMP #$D83F
$A2:F06C F0 03       BEQ $03    [$F071]
$A2:F06E 20 5A EF    JSR $EF5A  [$A2:EF5A]

$A2:F071 60          RTS
$A2:F072 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F075 DE AA 0F    DEC $0FAA,x[$7E:102A]
$A2:F078 10 1E       BPL $1E    [$F098]
$A2:F07A 20 5A EF    JSR $EF5A  [$A2:EF5A]
$A2:F07D A9 68 EF    LDA #$EF68
$A2:F080 9D A8 0F    STA $0FA8,x[$7E:1028]
$A2:F083 BF 08 78 7E LDA $7E7808,x[$7E:7888]
$A2:F087 C9 01 00    CMP #$0001
$A2:F08A D0 0C       BNE $0C    [$F098]
$A2:F08C BF 02 78 7E LDA $7E7802,x[$7E:7882]
$A2:F090 D0 06       BNE $06    [$F098]
$A2:F092 A9 28 EF    LDA #$EF28
$A2:F095 9D A8 0F    STA $0FA8,x[$7E:1068]

$A2:F098 60          RTS
}


;;; $F099:  ;;;
{
$A2:F099 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F09C 60          RTS
}


;;; $F09D: Enemy touch - enemy $D53F/$D5BF/$D5FF (shootable shutter / destroyable timed shutter / rising and falling platform) ;;;
{
$A2:F09D 22 B6 F0 A2 JSL $A2F0B6[$A2:F0B6]
$A2:F0A1 6B          RTL
}


;;; $F0A2: Enemy shot - enemy $D53F/$D5FF (shootable shutter / rising and falling platform) ;;;
{
$A2:F0A2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F0A5 22 B6 F0 A2 JSL $A2F0B6[$A2:F0B6]
$A2:F0A9 6B          RTL
}


;;; $F0AA: Enemy shot - enemy $B5BF (destroyable timed shutter) ;;;
{
$A2:F0AA AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F0AD 22 3D A6 A0 JSL $A0A63D[$A0:A63D]
$A2:F0B1 22 B6 F0 A2 JSL $A2F0B6[$A2:F0B6]
$A2:F0B5 6B          RTL
}


;;; $F0B6: Power bomb reaction - enemy $D53F/$D5BF/$D5FF (shootable shutter / destroyable timed shutter / rising and falling platform) ;;;
{
$A2:F0B6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F0B9 BF 0E 78 7E LDA $7E780E,x[$7E:788E]
$A2:F0BD C9 06 00    CMP #$0006
$A2:F0C0 30 41       BMI $41    [$F103]
$A2:F0C2 C9 08 00    CMP #$0008
$A2:F0C5 F0 0D       BEQ $0D    [$F0D4]
$A2:F0C7 BF 18 78 7E LDA $7E7818,x[$7E:78D8]
$A2:F0CB D0 39       BNE $39    [$F106]
$A2:F0CD A9 01 00    LDA #$0001
$A2:F0D0 9F 18 78 7E STA $7E7818,x[$7E:78D8]

$A2:F0D4 BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A2:F0D7 C9 68 EF    CMP #$EF68
$A2:F0DA D0 02       BNE $02    [$F0DE]
$A2:F0DC 80 28       BRA $28    [$F106]

$A2:F0DE BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A2:F0E1 C9 D4 EF    CMP #$EFD4
$A2:F0E4 F0 20       BEQ $20    [$F106]
$A2:F0E6 A9 68 EF    LDA #$EF68
$A2:F0E9 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A2:F0EC BF 00 80 7E LDA $7E8000,x[$7E:8000]
$A2:F0F0 F0 06       BEQ $06    [$F0F8]
$A2:F0F2 A9 D4 EF    LDA #$EFD4
$A2:F0F5 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A2:F0F8 BF 00 80 7E LDA $7E8000,x[$7E:8000]
$A2:F0FC 49 01 00    EOR #$0001
$A2:F0FF 9F 00 80 7E STA $7E8000,x[$7E:8000]

$A2:F103 20 5A EF    JSR $EF5A  [$A2:EF5A]

$A2:F106 6B          RTL
}


;;; $F107:  ;;;
{
$A2:F107             dw F230, F243, F254, F25B, F25B
}


;;; $F111: Initialisation AI - enemy $D57F (horizontal shootable shutter) ;;;
{
$A2:F111 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F114 20 1E F1    JSR $F11E  [$A2:F11E]
$A2:F117 A9 D4 E9    LDA #$E9D4
$A2:F11A 9D 92 0F    STA $0F92,x
$A2:F11D 6B          RTL
}


;;; $F11E:  ;;;
{
$A2:F11E BD 92 0F    LDA $0F92,x
$A2:F121 29 FF 00    AND #$00FF
$A2:F124 9F 00 78 7E STA $7E7800,x
$A2:F128 0A          ASL A
$A2:F129 0A          ASL A
$A2:F12A 0A          ASL A
$A2:F12B A8          TAY
$A2:F12C B9 87 81    LDA $8187,y
$A2:F12F 9D AE 0F    STA $0FAE,x
$A2:F132 B9 89 81    LDA $8189,y
$A2:F135 9D AC 0F    STA $0FAC,x
$A2:F138 B9 8B 81    LDA $818B,y
$A2:F13B 9D B2 0F    STA $0FB2,x
$A2:F13E B9 8D 81    LDA $818D,y
$A2:F141 9D B0 0F    STA $0FB0,x
$A2:F144 BD 93 0F    LDA $0F93,x
$A2:F147 29 FF 00    AND #$00FF
$A2:F14A 9F 02 78 7E STA $7E7802,x
$A2:F14E 49 01 00    EOR #$0001
$A2:F151 9F 00 80 7E STA $7E8000,x
$A2:F155 BD 88 0F    LDA $0F88,x
$A2:F158 29 FF 00    AND #$00FF
$A2:F15B 9F 04 78 7E STA $7E7804,x
$A2:F15F 0A          ASL A
$A2:F160 0A          ASL A
$A2:F161 0A          ASL A
$A2:F162 0A          ASL A
$A2:F163 9F 10 78 7E STA $7E7810,x
$A2:F167 BD 89 0F    LDA $0F89,x
$A2:F16A 29 FF 00    AND #$00FF
$A2:F16D 9F 06 78 7E STA $7E7806,x
$A2:F171 0A          ASL A
$A2:F172 0A          ASL A
$A2:F173 0A          ASL A
$A2:F174 0A          ASL A
$A2:F175 9F 12 78 7E STA $7E7812,x
$A2:F179 BD B4 0F    LDA $0FB4,x
$A2:F17C 29 FF 00    AND #$00FF
$A2:F17F 9F 08 78 7E STA $7E7808,x
$A2:F183 0A          ASL A
$A2:F184 9F 0E 78 7E STA $7E780E,x
$A2:F188 BD B5 0F    LDA $0FB5,x
$A2:F18B 29 FF 00    AND #$00FF
$A2:F18E 9F 0A 78 7E STA $7E780A,x
$A2:F192 BD B6 0F    LDA $0FB6,x
$A2:F195 9F 0C 78 7E STA $7E780C,x
$A2:F199 9D AA 0F    STA $0FAA,x
$A2:F19C BD 7A 0F    LDA $0F7A,x
$A2:F19F 9F 22 78 7E STA $7E7822,x
$A2:F1A3 18          CLC
$A2:F1A4 7F 0A 78 7E ADC $7E780A,x
$A2:F1A8 9F 24 78 7E STA $7E7824,x
$A2:F1AC BF 02 78 7E LDA $7E7802,x
$A2:F1B0 D0 10       BNE $10    [$F1C2]
$A2:F1B2 BD 7A 0F    LDA $0F7A,x
$A2:F1B5 9F 24 78 7E STA $7E7824,x
$A2:F1B9 38          SEC
$A2:F1BA FF 0A 78 7E SBC $7E780A,x
$A2:F1BE 9F 22 78 7E STA $7E7822,x

$A2:F1C2 A9 24 F2    LDA #$F224
$A2:F1C5 9D A8 0F    STA $0FA8,x
$A2:F1C8 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:F1CB 9F 2A 78 7E STA $7E782A,x
$A2:F1CF A9 00 00    LDA #$0000
$A2:F1D2 9D 88 0F    STA $0F88,x
$A2:F1D5 9F 14 78 7E STA $7E7814,x
$A2:F1D9 9F 16 78 7E STA $7E7816,x
$A2:F1DD 60          RTS
}


;;; $F1DE: Main AI - enemy $D57F (horizontal shootable shutter) ;;;
{
$A2:F1DE AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F1E1 FC A8 0F    JSR ($0FA8,x)
$A2:F1E4 BD A8 0F    LDA $0FA8,x
$A2:F1E7 C9 72 F2    CMP #$F272
$A2:F1EA D0 02       BNE $02    [$F1EE]
$A2:F1EC 80 27       BRA $27    [$F215]

$A2:F1EE BD A8 0F    LDA $0FA8,x
$A2:F1F1 C9 E4 F2    CMP #$F2E4
$A2:F1F4 F0 1F       BEQ $1F    [$F215]
$A2:F1F6 AD 2C 18    LDA $182C  [$7E:182C]
$A2:F1F9 2D 2E 18    AND $182E  [$7E:182E]
$A2:F1FC 2D 30 18    AND $1830  [$7E:1830]
$A2:F1FF 2D 32 18    AND $1832  [$7E:1832]
$A2:F202 C9 FF FF    CMP #$FFFF
$A2:F205 F0 0E       BEQ $0E    [$F215]
$A2:F207 CD 54 0E    CMP $0E54  [$7E:0E54]
$A2:F20A D0 09       BNE $09    [$F215]
$A2:F20C AD 6E 0A    LDA $0A6E  [$7E:0A6E]
$A2:F20F F0 04       BEQ $04    [$F215]
$A2:F211 22 1A F4 A2 JSL $A2F41A[$A2:F41A]

$A2:F215 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:F218 9F 2A 78 7E STA $7E782A,x
$A2:F21C AD F8 0A    LDA $0AF8  [$7E:0AF8]
$A2:F21F 9F 2C 78 7E STA $7E782C,x
$A2:F223 6B          RTL
}


;;; $F224:  ;;;
{
$A2:F224 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F227 BF 0E 78 7E LDA $7E780E,x
$A2:F22B AA          TAX
$A2:F22C FC 07 F1    JSR ($F107,x)
$A2:F22F 60          RTS
}


;;; $F230:  ;;;
{
$A2:F230 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F233 DE AA 0F    DEC $0FAA,x
$A2:F236 D0 0A       BNE $0A    [$F242]
$A2:F238 BF 0C 78 7E LDA $7E780C,x
$A2:F23C 9D AA 0F    STA $0FAA,x
$A2:F23F 20 5F F2    JSR $F25F  [$A2:F25F]

$A2:F242 60          RTS
}


;;; $F243:  ;;;
{
$A2:F243 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F246 BF 0C 78 7E LDA $7E780C,x
$A2:F24A 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A2:F24E F0 03       BEQ $03    [$F253]
$A2:F250 20 5F F2    JSR $F25F  [$A2:F25F]

$A2:F253 60          RTS
}


;;; $F254:  ;;;
{
$A2:F254 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F257 20 5F F2    JSR $F25F  [$A2:F25F]
$A2:F25A 60          RTS
}


;;; $F25B:  ;;;
{
$A2:F25B AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F25E 60          RTS
}


;;; $F25F:  ;;;
{
$A2:F25F A9 72 F2    LDA #$F272
$A2:F262 9D A8 0F    STA $0FA8,x
$A2:F265 BF 02 78 7E LDA $7E7802,x
$A2:F269 F0 06       BEQ $06    [$F271]
$A2:F26B A9 E4 F2    LDA #$F2E4
$A2:F26E 9D A8 0F    STA $0FA8,x

$A2:F271 60          RTS
}


;;; $F272:  ;;;
{
$A2:F272 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F275 BD 7A 0F    LDA $0F7A,x
$A2:F278 9F 1A 78 7E STA $7E781A,x
$A2:F27C A9 00 00    LDA #$0000
$A2:F27F 9F 26 78 7E STA $7E7826,x
$A2:F283 22 67 AC A0 JSL $A0AC67[$A0:AC67]
$A2:F287 F0 0F       BEQ $0F    [$F298]
$A2:F289 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:F28C DD 7A 0F    CMP $0F7A,x
$A2:F28F 10 07       BPL $07    [$F298]
$A2:F291 A9 01 00    LDA #$0001
$A2:F294 9F 26 78 7E STA $7E7826,x

$A2:F298 18          CLC
$A2:F299 BD 7C 0F    LDA $0F7C,x
$A2:F29C 7D B0 0F    ADC $0FB0,x
$A2:F29F 9D 7C 0F    STA $0F7C,x
$A2:F2A2 BD 7A 0F    LDA $0F7A,x
$A2:F2A5 7D B2 0F    ADC $0FB2,x
$A2:F2A8 9D 7A 0F    STA $0F7A,x
$A2:F2AB BF 26 78 7E LDA $7E7826,x
$A2:F2AF F0 0F       BEQ $0F    [$F2C0]
$A2:F2B1 BD B0 0F    LDA $0FB0,x            ;\
$A2:F2B4 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A2:F2B7 BD B2 0F    LDA $0FB2,x            ;} Extra Samus X displacement = [enemy $0FB2].[enemy $0FB0]
$A2:F2BA 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A2:F2BD 20 56 F3    JSR $F356  [$A2:F356]

$A2:F2C0 BF 22 78 7E LDA $7E7822,x
$A2:F2C4 DD 7A 0F    CMP $0F7A,x[$7E:0F82]
$A2:F2C7 30 1A       BMI $1A    [$F2E3]
$A2:F2C9 BF 10 78 7E LDA $7E7810,x
$A2:F2CD C9 F0 0F    CMP #$0FF0
$A2:F2D0 F0 0B       BEQ $0B    [$F2DD]
$A2:F2D2 9D AA 0F    STA $0FAA,x
$A2:F2D5 A9 8C F3    LDA #$F38C
$A2:F2D8 9D A8 0F    STA $0FA8,x
$A2:F2DB 80 06       BRA $06    [$F2E3]

$A2:F2DD A9 D4 F3    LDA #$F3D4
$A2:F2E0 9D A8 0F    STA $0FA8,x

$A2:F2E3 60          RTS
}


;;; $F2E4:  ;;;
{
$A2:F2E4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F2E7 BD 7A 0F    LDA $0F7A,x
$A2:F2EA 9F 1A 78 7E STA $7E781A,x
$A2:F2EE A9 00 00    LDA #$0000
$A2:F2F1 9F 26 78 7E STA $7E7826,x
$A2:F2F5 22 67 AC A0 JSL $A0AC67[$A0:AC67]
$A2:F2F9 F0 0F       BEQ $0F    [$F30A]
$A2:F2FB AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:F2FE DD 7A 0F    CMP $0F7A,x
$A2:F301 30 07       BMI $07    [$F30A]
$A2:F303 A9 01 00    LDA #$0001
$A2:F306 9F 26 78 7E STA $7E7826,x

$A2:F30A 18          CLC
$A2:F30B BD 7C 0F    LDA $0F7C,x
$A2:F30E 7D AC 0F    ADC $0FAC,x
$A2:F311 9D 7C 0F    STA $0F7C,x
$A2:F314 BD 7A 0F    LDA $0F7A,x
$A2:F317 7D AE 0F    ADC $0FAE,x
$A2:F31A 9D 7A 0F    STA $0F7A,x
$A2:F31D BF 26 78 7E LDA $7E7826,x
$A2:F321 F0 0F       BEQ $0F    [$F332]
$A2:F323 BD AC 0F    LDA $0FAC,x            ;\
$A2:F326 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A2:F329 BD AE 0F    LDA $0FAE,x            ;} Extra Samus X displacement = [enemy $0FAE].[enemy $0FAC]
$A2:F32C 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A2:F32F 20 71 F3    JSR $F371  [$A2:F371]

$A2:F332 BD 7A 0F    LDA $0F7A,x
$A2:F335 DF 24 78 7E CMP $7E7824,x
$A2:F339 30 1A       BMI $1A    [$F355]
$A2:F33B BF 12 78 7E LDA $7E7812,x
$A2:F33F C9 F0 0F    CMP #$0FF0
$A2:F342 F0 0B       BEQ $0B    [$F34F]
$A2:F344 9D AA 0F    STA $0FAA,x
$A2:F347 A9 B0 F3    LDA #$F3B0
$A2:F34A 9D A8 0F    STA $0FA8,x
$A2:F34D 80 06       BRA $06    [$F355]

$A2:F34F A9 D4 F3    LDA #$F3D4
$A2:F352 9D A8 0F    STA $0FA8,x

$A2:F355 60          RTS
}


;;; $F356:  ;;;
{
$A2:F356 BF 26 78 7E LDA $7E7826,x
$A2:F35A F0 14       BEQ $14    [$F370]
$A2:F35C A5 8B       LDA $8B    [$7E:008B]  ;\
$A2:F35E 29 00 01    AND #$0100             ;} If not pressing right: return
$A2:F361 F0 0D       BEQ $0D    [$F370]     ;/
$A2:F363 AD 58 0B    LDA $0B58  [$7E:0B58]  ;\
$A2:F366 18          CLC                    ;|
$A2:F367 69 FC FF    ADC #$FFFC             ;} Extra Samus X displacement -= 4
$A2:F36A 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A2:F36D 9C 5A 0B    STZ $0B5A  [$7E:0B5A]

$A2:F370 60          RTS
}


;;; $F371:  ;;;
{
$A2:F371 BF 26 78 7E LDA $7E7826,x
$A2:F375 F0 14       BEQ $14    [$F38B]
$A2:F377 A5 8B       LDA $8B    [$7E:008B]  ;\
$A2:F379 29 00 02    AND #$0200             ;} If not pressing left: return
$A2:F37C F0 0D       BEQ $0D    [$F38B]     ;/
$A2:F37E AD 58 0B    LDA $0B58  [$7E:0B58]  ;\
$A2:F381 18          CLC                    ;|
$A2:F382 69 04 00    ADC #$0004             ;} Extra Samus X displacement += 4
$A2:F385 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A2:F388 9C 5A 0B    STZ $0B5A  [$7E:0B5A]

$A2:F38B 60          RTS
}


;;; $F38C:  ;;;
{
$A2:F38C AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F38F DE AA 0F    DEC $0FAA,x
$A2:F392 10 1B       BPL $1B    [$F3AF]
$A2:F394 A9 E4 F2    LDA #$F2E4
$A2:F397 9D A8 0F    STA $0FA8,x
$A2:F39A BF 08 78 7E LDA $7E7808,x
$A2:F39E C9 01 00    CMP #$0001
$A2:F3A1 D0 0C       BNE $0C    [$F3AF]
$A2:F3A3 BF 02 78 7E LDA $7E7802,x
$A2:F3A7 F0 06       BEQ $06    [$F3AF]
$A2:F3A9 A9 43 F2    LDA #$F243
$A2:F3AC 9D A8 0F    STA $0FA8,x

$A2:F3AF 60          RTS
}


;;; $F3B0:  ;;;
{
$A2:F3B0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F3B3 DE AA 0F    DEC $0FAA,x
$A2:F3B6 10 1B       BPL $1B    [$F3D3]
$A2:F3B8 A9 72 F2    LDA #$F272
$A2:F3BB 9D A8 0F    STA $0FA8,x
$A2:F3BE BF 08 78 7E LDA $7E7808,x
$A2:F3C2 C9 01 00    CMP #$0001
$A2:F3C5 D0 0C       BNE $0C    [$F3D3]
$A2:F3C7 BF 02 78 7E LDA $7E7802,x
$A2:F3CB D0 06       BNE $06    [$F3D3]
$A2:F3CD A9 43 F2    LDA #$F243
$A2:F3D0 9D A8 0F    STA $0FA8,x

$A2:F3D3 60          RTS
}


;;; $F3D4:  ;;;
{
$A2:F3D4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F3D7 60          RTS
}


;;; $F3D8: Enemy touch - enemy $D57F (horizontal shootable shutter) ;;;
{
$A2:F3D8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F3DB BD A8 0F    LDA $0FA8,x
$A2:F3DE C9 D4 F3    CMP #$F3D4
$A2:F3E1 D0 2A       BNE $2A    [$F40D]
$A2:F3E3 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A2:F3E6 DD 7A 0F    CMP $0F7A,x
$A2:F3E9 10 12       BPL $12    [$F3FD]
$A2:F3EB A5 8B       LDA $8B    [$7E:008B]  ;\
$A2:F3ED 29 00 01    AND #$0100             ;} If not pressing right: return
$A2:F3F0 F0 1B       BEQ $1B    [$F40D]     ;/
$A2:F3F2 A9 FC FF    LDA #$FFFC             ;\
$A2:F3F5 8D 58 0B    STA $0B58  [$7E:0B58]  ;} Extra Samus X displacement = -4
$A2:F3F8 9C 5A 0B    STZ $0B5A  [$7E:0B5A]
$A2:F3FB 80 10       BRA $10    [$F40D]

$A2:F3FD A5 8B       LDA $8B    [$7E:008B]  ;\
$A2:F3FF 29 00 02    AND #$0200             ;} If not pressing left: return
$A2:F402 F0 09       BEQ $09    [$F40D]     ;/
$A2:F404 A9 04 00    LDA #$0004             ;\
$A2:F407 8D 58 0B    STA $0B58  [$7E:0B58]  ;} Extra Samus X displacement = 4
$A2:F40A 9C 5A 0B    STZ $0B5A  [$7E:0B5A]

$A2:F40D 6B          RTL
}


;;; $F40E: Enemy shot - enemy $D57F (horizontal shootable shutter) ;;;
{
$A2:F40E AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F411 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]
$A2:F415 22 1A F4 A2 JSL $A2F41A[$A2:F41A]
$A2:F419 6B          RTL
}


;;; $F41A: Power bomb reaction - enemy $D57F (horizontal shootable shutter) ;;;
{
$A2:F41A AE 54 0E    LDX $0E54  [$7E:0E54]
$A2:F41D BF 0E 78 7E LDA $7E780E,x
$A2:F421 C9 06 00    CMP #$0006
$A2:F424 30 41       BMI $41    [$F467]
$A2:F426 C9 08 00    CMP #$0008
$A2:F429 F0 0D       BEQ $0D    [$F438]
$A2:F42B BF 18 78 7E LDA $7E7818,x
$A2:F42F D0 36       BNE $36    [$F467]
$A2:F431 A9 01 00    LDA #$0001
$A2:F434 9F 18 78 7E STA $7E7818,x

$A2:F438 BD A8 0F    LDA $0FA8,x
$A2:F43B C9 72 F2    CMP #$F272
$A2:F43E D0 02       BNE $02    [$F442]
$A2:F440 80 25       BRA $25    [$F467]

$A2:F442 BD A8 0F    LDA $0FA8,x
$A2:F445 C9 E4 F2    CMP #$F2E4
$A2:F448 F0 1D       BEQ $1D    [$F467]
$A2:F44A BF 00 80 7E LDA $7E8000,x
$A2:F44E 49 01 00    EOR #$0001
$A2:F451 9F 00 80 7E STA $7E8000,x
$A2:F455 A9 72 F2    LDA #$F272
$A2:F458 9D A8 0F    STA $0FA8,x
$A2:F45B BF 00 80 7E LDA $7E8000,x
$A2:F45F F0 06       BEQ $06    [$F467]
$A2:F461 A9 E4 F2    LDA #$F2E4
$A2:F464 9D A8 0F    STA $0FA8,x

$A2:F467 6B          RTL
}


;;; $F468: Shutters spritemaps ;;;
{
$A2:F468             dx 0002, 8000,F8,6100, 81F0,F8,2100
$A2:F474             dx 0002, 8000,F8,6102, 81F0,F8,2102
$A2:F480             dx 0002, 8000,F8,6104, 81F0,F8,2104
$A2:F48C             dx 0002, 8000,F8,6106, 81F0,F8,2106
}
}


;;; $F498: Free space ;;;
{
$A2:F498             fillto $A38000, $FF
}
