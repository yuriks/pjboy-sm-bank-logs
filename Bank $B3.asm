;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687..878A: Unused spinning turtle eye ;;;
{
;;; $8687: Palette - enemy $F153 (unused spinning turtle eye) ;;;
{
$B3:8687             dw 3800, 4FE9, 4266, 3D85, 20A3, 52FC, 41F7, 30D2, 240E, 325F, 31DB, 3156, 30D2, 302C, 7FBD, 0C05
}


;;; $86A7: Instruction list - initial ;;;
{
$B3:86A7             dx 000A,8714,
                        000A,871B,
                        000A,8722,
                        000A,8729,
                        000A,8730,
                        000A,8737,
                        000A,873E,
                        000A,8745,
                        80ED,86A7   ; Go to $86A7
}


;;; $86CB: Instruction list ;;;
{
$B3:86CB             dx 0008,874C,
                        0008,8753,
                        0008,875A,
                        80ED,86CB   ; Go to $86CB
}


;;; $86DB: Instruction list ;;;
{
$B3:86DB             dx 0008,8761,
                        0008,8768,
                        0008,876F,
                        80ED,86DB   ; Go to $86DB
}


;;; $86EB: Instruction list ;;;
{
$B3:86EB             dx 0008,8776,
                        0008,877D,
                        0008,8784,
                        80ED,86EB   ; Go to $86EB
}


;;; $86FB: Initialisation AI - enemy $F153 (unused spinning turtle eye) ;;;
{
$B3:86FB AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:86FE BD 86 0F    LDA $0F86,x            ;\
$B3:8701 09 00 20    ORA #$2000             ;} Set enemy to process instructions
$B3:8704 9D 86 0F    STA $0F86,x            ;/
$B3:8707 A9 A7 86    LDA #$86A7             ;\
$B3:870A 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $86A7
$B3:870D 6B          RTL
}


;;; $870E: Main AI - enemy $F153 (unused spinning turtle eye) ;;;
{
$B3:870E AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8711 6B          RTL
}


;;; $8712: RTL ;;;
{
$B3:8712 6B          RTL
}


;;; $8713: RTL ;;;
{
$B3:8713 6B          RTL
}


;;; $8714: Unused spinning turtle eye spritemaps ;;;
{
$B3:8714             dx 0001, 01F8,F8,3300
$B3:871B             dx 0001, 01F8,F8,3301
$B3:8722             dx 0001, 01F8,F8,3302
$B3:8729             dx 0001, 01F8,F8,3303
$B3:8730             dx 0001, 01F8,F8,F300
$B3:8737             dx 0001, 01F8,F8,F301
$B3:873E             dx 0001, 01F8,F8,F302
$B3:8745             dx 0001, 01F8,F8,F303

$B3:874C             dx 0001, 01F8,F8,3304
$B3:8753             dx 0001, 01F8,F8,3305
$B3:875A             dx 0001, 01F8,F8,3306

$B3:8761             dx 0001, 01F8,F8,3307
$B3:8768             dx 0001, 01F8,F8,3308
$B3:876F             dx 0001, 01F8,F8,3309

$B3:8776             dx 0001, 01F8,F8,330A
$B3:877D             dx 0001, 01F8,F8,330B
$B3:8784             dx 0001, 01F8,F8,330C
}
}


;;; $878B..8AC0: Brinstar red/green pipe bug ;;;
{
;;; $878B: Palette - enemy $F193 (Brinstar red pipe bug) ;;;
{
$B3:878B             dw 3800, 021D, 0015, 0008, 0003, 00BD, 0013, 000E, 000B, 7F5A, 7EC0, 6DE0, 54E0, 03E0, 02A0, 0140
}


;;; $87AB: Instruction list - facing left - rising ;;;
{
$B3:87AB             dx 0002,89B7,
                        0002,89BE,
                        0002,89C5,
                        0002,89CC,
                        0002,89D3,
                        0002,89CC,
                        0002,89C5,
                        0002,89BE,
                        80ED,87AB   ; Go to $87AB
}


;;; $87CF: Instruction list - facing left - shooting ;;;
{
$B3:87CF             dx 0001,89B7,
                        0001,89BE,
                        0001,89CC,
                        0001,89D3,
                        0001,89CC,
                        0001,89BE,
                        80ED,87CF   ; Go to $87CF
}


;;; $87EB: Instruction list - facing right - rising ;;;
{
$B3:87EB             dx 0002,89DA,
                        0002,89E1,
                        0002,89E8,
                        0002,89EF,
                        0002,89F6,
                        0002,89EF,
                        0002,89E8,
                        0002,89E1,
                        80ED,87EB   ; Go to $87EB
}


;;; $880F: Instruction list - facing right - shooting ;;;
{
$B3:880F             dx 0001,89DA,
                        0001,89E1,
                        0001,89EF,
                        0001,89F6,
                        0001,89EF,
                        0001,89E1,
                        80ED,880F   ; Go to $880F
}


;;; $882B: Instruction list pointers - red pipe bug ;;;
{
$B3:882B             dw 87AB, 87CF, 87EB, 880F
}


;;; $8833: Instruction list pointers - green pipe bug ;;;
{
$B3:8833             dw 8A1D, 8A31, 8A45, 8A59
}


;;; $883B: Initialisation AI - enemy $F193/$F1D3 (Brinstar red/green pipe bug) ;;;
{
$B3:883B AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:883E BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;\
$B3:8841 9D AA 0F    STA $0FAA,x[$7E:11EA]  ;} Enemy spawn X position = [enemy X position]
$B3:8844 BD 7E 0F    LDA $0F7E,x[$7E:11BE]  ;\
$B3:8847 9D AC 0F    STA $0FAC,x[$7E:11EC]  ;} Enemy spawn Y position = [enemy Y position]
$B3:884A 38          SEC                    ;\
$B3:884B E9 10 00    SBC #$0010             ;} Enemy target Y position = [enemy Y position] - 10h
$B3:884E 9F 00 78 7E STA $7E7800,x[$7E:7A40];/
$B3:8852 A9 80 88    LDA #$8880             ;\
$B3:8855 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;} Enemy function pointer = $8880
$B3:8858 A9 30 00    LDA #$0030             ;\
$B3:885B 9D AE 0F    STA $0FAE,x[$7E:11EE]  ;} Enemy spawn delay timer = 30h <-- this doesn't need to be initialised here
$B3:885E A9 00 00    LDA #$0000             ;\
$B3:8861 9D B0 0F    STA $0FB0,x[$7E:11F0]  ;} Enemy instruction list table index = 0
$B3:8864 9F 02 78 7E STA $7E7802,x[$7E:7A42]; Enemy previous instruction list table index = 0
$B3:8868 A9 AB 87    LDA #$87AB             ;\
$B3:886B 9D 92 0F    STA $0F92,x[$7E:11D2]  ;} Enemy instruction list pointer = $87AB
$B3:886E BD B4 0F    LDA $0FB4,x[$7E:11F4]  ;\
$B3:8871 F0 06       BEQ $06    [$8879]     ;} If [enemy parameter 1] != 0 (green bug):
$B3:8873 A9 1D 8A    LDA #$8A1D             ;\
$B3:8876 9D 92 0F    STA $0F92,x[$7E:1092]  ;} Enemy instruction list pointer = $8A1D

$B3:8879 6B          RTL
}


;;; $887A: Main AI - enemy $F193/$F1D3 (Brinstar red/green pipe bug) ;;;
{
$B3:887A AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:887D 7C B2 0F    JMP ($0FB2,x)[$B3:8880]
}


;;; $8880: Brinstar red/green pipe bug function - wait until on screen ;;;
{
$B3:8880 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8883 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$B3:8887 D0 06       BNE $06    [$888F]     ;} If enemy centre is on screen:
$B3:8889 A9 90 88    LDA #$8890             ;\
$B3:888C 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;} Enemy function = $8890

$B3:888F 6B          RTL
}


;;; $8890: Brinstar red/green pipe bug function - wait for Samus to get near ;;;
{
$B3:8890 22 DD AE A0 JSL $A0AEDD[$A0:AEDD]  ;\
$B3:8894 10 23       BPL $23    [$88B9]     ;|
$B3:8896 C9 A0 FF    CMP #$FFA0             ;} If not 0 < [enemy Y position] - [Samus Y position] <= 60h: return
$B3:8899 30 1E       BMI $1E    [$88B9]     ;/
$B3:889B 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$B3:889F A8          TAY                    ;|
$B3:88A0 3E A8 0F    ROL $0FA8,x[$7E:11E8]  ;} Enemy direction = [Samus X position] - [enemy X position] & 8000h
$B3:88A3 2A          ROL A                  ;|
$B3:88A4 7E A8 0F    ROR $0FA8,x[$7E:11E8]  ;/
$B3:88A7 BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;\
$B3:88AA 38          SEC                    ;|
$B3:88AB ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$B3:88AE 10 04       BPL $04    [$88B4]     ;|
$B3:88B0 49 FF FF    EOR #$FFFF             ;} If |[enemy X position] - [Samus X position]| >= 40h:
$B3:88B3 1A          INC A                  ;|
                                            ;|
$B3:88B4 C9 40 00    CMP #$0040             ;|
$B3:88B7 90 01       BCC $01    [$88BA]     ;/
$B3:88B9 6B          RTL                    ; Return

$B3:88BA A9 E3 88    LDA #$88E3             ;\
$B3:88BD 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;} Enemy function pointer = $88E3
$B3:88C0 BD 86 0F    LDA $0F86,x[$7E:11C6]  ;\
$B3:88C3 29 FF FE    AND #$FEFF             ;} Set enemy as visible
$B3:88C6 9D 86 0F    STA $0F86,x[$7E:11C6]  ;/
$B3:88C9 A9 00 00    LDA #$0000             ;\
$B3:88CC 9D 90 0F    STA $0F90,x[$7E:11D0]  ;} Enemy timer = 0
$B3:88CF 3C A8 0F    BIT $0FA8,x[$7E:11E8]  ;\
$B3:88D2 30 05       BMI $05    [$88D9]     ;} If [enemy direction] = right:
$B3:88D4 A9 02 00    LDA #$0002             ; Enemy instruction list table index = 2
$B3:88D7 80 03       BRA $03    [$88DC]
                                            ; Else ([enemy direction] = left):
$B3:88D9 A9 00 00    LDA #$0000             ; Enemy instruction list table index = 0

$B3:88DC 9D B0 0F    STA $0FB0,x[$7E:11F0]
$B3:88DF 20 8B 89    JSR $898B  [$B3:898B]  ; Set Brinstar red/green pipe bug instruction list
$B3:88E2 6B          RTL
}


;;; $88E3: Brinstar red/green pipe bug function - rising ;;;
{
$B3:88E3 A9 FF FF    LDA #$FFFF             ;\
$B3:88E6 18          CLC                    ;|
$B3:88E7 7D 80 0F    ADC $0F80,x[$7E:11C0]  ;|
$B3:88EA 9D 80 0F    STA $0F80,x[$7E:11C0]  ;} Enemy Y position -= 1.0001h
$B3:88ED A9 FE FF    LDA #$FFFE             ;|
$B3:88F0 7D 7E 0F    ADC $0F7E,x[$7E:11BE]  ;|
$B3:88F3 9D 7E 0F    STA $0F7E,x[$7E:11BE]  ;/
$B3:88F6 BF 00 78 7E LDA $7E7800,x[$7E:7A40];\
$B3:88FA DD 7E 0F    CMP $0F7E,x[$7E:11BE]  ;} If [enemy Y position] > [enemy target Y position]: return
$B3:88FD 30 1C       BMI $1C    [$891B]     ;/
$B3:88FF BD 7E 0F    LDA $0F7E,x[$7E:11BE]  ;\
$B3:8902 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;} If [enemy Y position] >= [Samus Y position]:
$B3:8905 90 02       BCC $02    [$8909]     ;/
$B3:8907 80 12       BRA $12    [$891B]     ; Return

$B3:8909 BD B0 0F    LDA $0FB0,x[$7E:11F0]  ;\
$B3:890C 09 01 00    ORA #$0001             ;} Enemy instruction list table index |= 1
$B3:890F 9D B0 0F    STA $0FB0,x[$7E:11F0]  ;/
$B3:8912 20 8B 89    JSR $898B  [$B3:898B]  ; Set Brinstar red/green pipe bug instruction list
$B3:8915 A9 1C 89    LDA #$891C             ;\
$B3:8918 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;} Enemy function = $891C

$B3:891B 6B          RTL
}


;;; $891C: Brinstar red/green pipe bug function - shooting ;;;
{
$B3:891C 3C A8 0F    BIT $0FA8,x[$7E:11E8]  ;\
$B3:891F 10 15       BPL $15    [$8936]     ;} If [enemy direction] = left:
$B3:8921 BD 7C 0F    LDA $0F7C,x[$7E:11BC]
$B3:8924 38          SEC
$B3:8925 E9 00 00    SBC #$0000
$B3:8928 9D 7C 0F    STA $0F7C,x[$7E:11BC]
$B3:892B BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;\
$B3:892E E9 02 00    SBC #$0002             ;} Enemy X position -= 2
$B3:8931 9D 7A 0F    STA $0F7A,x[$7E:11BA]  ;/
$B3:8934 80 13       BRA $13    [$8949]

$B3:8936 A9 00 00    LDA #$0000             ; Else ([enemy direction] = right):
$B3:8939 18          CLC
$B3:893A 7D 7C 0F    ADC $0F7C,x[$7E:11BC]
$B3:893D 9D 7C 0F    STA $0F7C,x[$7E:11BC]
$B3:8940 A9 02 00    LDA #$0002             ;\
$B3:8943 7D 7A 0F    ADC $0F7A,x[$7E:11BA]  ;} Enemy X position += 2
$B3:8946 9D 7A 0F    STA $0F7A,x[$7E:11BA]  ;/

$B3:8949 22 8E C1 A0 JSL $A0C18E[$A0:C18E]  ;\
$B3:894D B0 01       BCS $01    [$8950]     ;} If enemy is horizontally on-screen:
$B3:894F 6B          RTL                    ; Return

$B3:8950 BD AA 0F    LDA $0FAA,x[$7E:11EA]  ;\
$B3:8953 9D 7A 0F    STA $0F7A,x[$7E:11BA]  ;} Enemy X position = [enemy spawn X position]
$B3:8956 9E 7C 0F    STZ $0F7C,x[$7E:11BC]  ; Enemy X subposition = 0
$B3:8959 BD AC 0F    LDA $0FAC,x[$7E:11EC]  ;\
$B3:895C 9D 7E 0F    STA $0F7E,x[$7E:11BE]  ;} Enemy Y position = [enemy spawn Y position]
$B3:895F 9D 80 0F    STA $0F80,x[$7E:11C0]  ; Enemy Y subposition = [enemy Y position] (>_<;)
$B3:8962 9E B0 0F    STZ $0FB0,x[$7E:11F0]  ; Enemy instruction list table index = 0
$B3:8965 20 8B 89    JSR $898B  [$B3:898B]  ; Set Brinstar red/green pipe bug instruction list
$B3:8968 BD 86 0F    LDA $0F86,x[$7E:11C6]  ;\
$B3:896B 09 00 01    ORA #$0100             ;} Set enemy as invisible
$B3:896E 9D 86 0F    STA $0F86,x[$7E:11C6]  ;/
$B3:8971 A9 30 00    LDA #$0030             ;\
$B3:8974 9D AE 0F    STA $0FAE,x[$7E:11EE]  ;} Enemy spawn delay timer = 30h
$B3:8977 A9 7E 89    LDA #$897E             ;\
$B3:897A 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;} Enemy function = $897E
$B3:897D 6B          RTL
}


;;; $897E: Brinstar red/green pipe bug function - spawn delay ;;;
{
$B3:897E DE AE 0F    DEC $0FAE,x[$7E:11EE]  ; Decrement enemy spawn delay timer
$B3:8981 F0 01       BEQ $01    [$8984]     ; If [enemy spawn delay timer] != 0:
$B3:8983 6B          RTL                    ; Return

$B3:8984 A9 90 88    LDA #$8890             ;\
$B3:8987 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;} Enemy function = $8890
$B3:898A 6B          RTL
}


;;; $898B: Set Brinstar red/green pipe bug instruction list ;;;
{
$B3:898B AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:898E BD B0 0F    LDA $0FB0,x[$7E:11F0]  ;\
$B3:8991 DF 02 78 7E CMP $7E7802,x[$7E:7A42];} If [enemy previous instruction list table index] = [enemy instruction list table index]: return
$B3:8995 F0 1F       BEQ $1F    [$89B6]     ;/
$B3:8997 9F 02 78 7E STA $7E7802,x[$7E:7A42]; Enemy previous instruction list table index = [enemy instruction list table index]
$B3:899B 0A          ASL A                  ;\
$B3:899C A8          TAY                    ;} Y = [enemy instruction list table index] * 2
$B3:899D BD B4 0F    LDA $0FB4,x[$7E:11F4]  ;\
$B3:89A0 D0 05       BNE $05    [$89A7]     ;} If [enemy parameter 1] = 0 (red bug):
$B3:89A2 B9 2B 88    LDA $882B,y[$B3:882F]  ; Enemy instruction list pointer = [$882B + [Y]]
$B3:89A5 80 03       BRA $03    [$89AA]
                                            ; Else ([enemy parameter 1] != 0 (green bug)):
$B3:89A7 B9 33 88    LDA $8833,y[$B3:8835]  ; Enemy instruction list pointer = [$8833 + [Y]]

$B3:89AA 9D 92 0F    STA $0F92,x[$7E:11D2]
$B3:89AD A9 01 00    LDA #$0001             ;\
$B3:89B0 9D 94 0F    STA $0F94,x[$7E:11D4]  ;} Enemy instruction timer = 1
$B3:89B3 9E 90 0F    STZ $0F90,x[$7E:11D0]  ; Enemy timer = 0

$B3:89B6 60          RTS
}


;;; $89B7: Spritemaps ;;;
{
$B3:89B7             dx 0001, 81F8,F8,2100
$B3:89BE             dx 0001, 81F8,F8,2102
$B3:89C5             dx 0001, 81F8,F8,2104
$B3:89CC             dx 0001, 81F8,F8,2106
$B3:89D3             dx 0001, 81F8,F8,2108
$B3:89DA             dx 0001, 81F8,F8,6100
$B3:89E1             dx 0001, 81F8,F8,6102
$B3:89E8             dx 0001, 81F8,F8,6104
$B3:89EF             dx 0001, 81F8,F8,6106
$B3:89F6             dx 0001, 81F8,F8,6108
}


;;; $89FD: Palette - enemy $F1D3 (Brinstar green pipe bug) ;;;
{
$B3:89FD             dw 3800, 3F95, 2E8B, 0120, 0060, 3AEE, 2249, 11A4, 0962, 39BB, 30F5, 2C6E, 2827, 7F93, 6ECE, 6229
}


;;; $8A1D: Instruction list - facing left - rising ;;;
{
$B3:8A1D             dx 0002,8A82,
                        0001,8A89,
                        0002,8A90,
                        0001,8A89,
                        80ED,8A1D   ; Go to $8A1D
}


;;; $8A31: Instruction list - facing left - shooting ;;;
{
$B3:8A31             dx 0003,8A6D,
                        0003,8A74,
                        0003,8A7B,
                        0003,8A74,
                        80ED,8A31   ; Go to $8A31
}


;;; $8A45: Instruction list - facing right - rising ;;;
{
$B3:8A45             dx 0002,8AAC,
                        0001,8AB3,
                        0002,8ABA,
                        0001,8AB3,
                        80ED,8A45   ; Go to $8A45
}


;;; $8A59: Instruction list - facing right - shooting ;;;
{
$B3:8A59             dx 0003,8A97,
                        0003,8A9E,
                        0003,8AA5,
                        0003,8A9E,
                        80ED,8A59   ; Go to $8A59
}


;;; $8A6D: Spritemaps ;;;
{
$B3:8A6D             dx 0001, 81F8,F8,2100
$B3:8A74             dx 0001, 81F8,F8,2102
$B3:8A7B             dx 0001, 81F8,F8,2104
$B3:8A82             dx 0001, 81F8,F8,2106
$B3:8A89             dx 0001, 81F8,F8,2108
$B3:8A90             dx 0001, 81F8,F8,210A
$B3:8A97             dx 0001, 81F8,F8,6100
$B3:8A9E             dx 0001, 81F8,F8,6102
$B3:8AA5             dx 0001, 81F8,F8,6104
$B3:8AAC             dx 0001, 81F8,F8,6106
$B3:8AB3             dx 0001, 81F8,F8,6108
$B3:8ABA             dx 0001, 81F8,F8,610A
}
}


;;; $8AC1..8EDB: Norfair pipe bug ;;;
{
;;; $8AC1: Palette - enemy $F213 (Norfair pipe bug) ;;;
{
$B3:8AC1             dw 3800, 021D, 0015, 0008, 0003, 015F, 0076, 0050, 000B, 7FFF, 56E0, 3180, 18C0, 43FF, 42DC, 4176
}


;;; $8AE1: Instruction list - facing left - rising ;;;
{
$B3:8AE1             dx 0002,8E96,
                        0002,8E9D,
                        0002,8EA4,
                        0002,8EAB,
                        0002,8EB2,
                        0002,8EAB,
                        0002,8EA4,
                        0002,8E9D,
                        80ED,8AE1   ; Go to $8AE1
}


;;; $8B05: Instruction list - facing left - shooting ;;;
{
$B3:8B05             dx 0001,8E96,
                        0001,8E9D,
                        0001,8EAB,
                        0001,8EB2,
                        0001,8EAB,
                        0001,8E9D,
                        80ED,8B05   ; Go to $8B05
}


;;; $8B21: Instruction list - facing right - rising ;;;
{
$B3:8B21             dx 0002,8EB9,
                        0002,8EC0,
                        0002,8EC7,
                        0002,8ECE,
                        0002,8ED5,
                        0002,8ECE,
                        0002,8EC7,
                        0002,8EC0,
                        80ED,8B21   ; Go to $8B21
}


;;; $8B45: Instruction list - facing right - shooting ;;;
{
$B3:8B45             dx 0001,8EB9,
                        0001,8EC0,
                        0001,8ECE,
                        0001,8ED5,
                        0001,8ECE,
                        0001,8EC0,
                        80ED,8B45   ; Go to $8B45
}


;;; $8B61: Initialisation AI - enemy $F213 (Norfair pipe bug) ;;;
{
$B3:8B61 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8B64 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B3:8B67 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy spawn X position = [enemy X position]
$B3:8B6A BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:8B6D 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy spawn Y position = [enemy Y position]
$B3:8B70 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:8B73 09 00 01    ORA #$0100             ;} Set enemy as invisible
$B3:8B76 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$B3:8B79 BD B7 0F    LDA $0FB7,x[$7E:0FB7]  ;\
$B3:8B7C 29 FF 00    AND #$00FF             ;|
$B3:8B7F 0A          ASL A                  ;|
$B3:8B80 0A          ASL A                  ;} Enemy X speed table index = [enemy parameter 2 high] * 8
$B3:8B81 0A          ASL A                  ;|
$B3:8B82 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$B3:8B85 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ; Enemy shoot delay timer = 0
$B3:8B88 A9 01 00    LDA #$0001             ;\
$B3:8B8B 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$B3:8B8E 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$B3:8B91 A9 E1 8A    LDA #$8AE1             ;\
$B3:8B94 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $8AE1
$B3:8B97 A9 CD 8B    LDA #$8BCD             ;\
$B3:8B9A 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $8BCD
$B3:8B9D 6B          RTL
}


;;; $8B9E: Main AI - enemy $F213 (Norfair pipe bug) ;;;
{
$B3:8B9E AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8BA1 FC A8 0F    JSR ($0FA8,x)[$B3:8BCD]; Execute [enemy function]
$B3:8BA4 20 A8 8B    JSR $8BA8  [$B3:8BA8]  ; Reset enemy if off-screen
$B3:8BA7 6B          RTL
}


;;; $8BA8: Reset enemy if off-screen ;;;
{
$B3:8BA8 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8BAB 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$B3:8BAF F0 1B       BEQ $1B    [$8BCC]     ;} If enemy centre is off-screen:
$B3:8BB1 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:8BB4 09 00 01    ORA #$0100             ;} Set enemy as invisible
$B3:8BB7 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$B3:8BBA A9 CD 8B    LDA #$8BCD             ;\
$B3:8BBD 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $8BCD
$B3:8BC0 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$B3:8BC3 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy X position = [enemy spawn X position]
$B3:8BC6 BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$B3:8BC9 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy Y position = [enemy spawn Y position]

$B3:8BCC 60          RTS
}


;;; $8BCD: Norfair pipe bug function - wait until everyone's ready ;;;
{
$B3:8BCD AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8BD0 BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$B3:8BD3 29 FF 00    AND #$00FF             ;} If [enemy parameter 2 low] != 0:
$B3:8BD6 F0 26       BEQ $26    [$8BFE]     ;/
$B3:8BD8 BD E8 0F    LDA $0FE8,x[$7E:0FE8]  ;\
$B3:8BDB C9 CD 8B    CMP #$8BCD             ;} If [enemy ([X] + 1) function = $8BCD:
$B3:8BDE D0 1E       BNE $1E    [$8BFE]     ;/
$B3:8BE0 BD 28 10    LDA $1028,x[$7E:1028]  ;\
$B3:8BE3 C9 CD 8B    CMP #$8BCD             ;} If [enemy ([X] + 2) function = $8BCD:
$B3:8BE6 D0 16       BNE $16    [$8BFE]     ;/
$B3:8BE8 BD 68 10    LDA $1068,x[$7E:1068]  ;\
$B3:8BEB C9 CD 8B    CMP #$8BCD             ;} If [enemy ([X] + 3) function = $8BCD:
$B3:8BEE D0 0E       BNE $0E    [$8BFE]     ;/
$B3:8BF0 BD A8 10    LDA $10A8,x[$7E:10A8]  ;\
$B3:8BF3 C9 CD 8B    CMP #$8BCD             ;} If [enemy ([X] + 4) function = $8BCD:
$B3:8BF6 D0 06       BNE $06    [$8BFE]     ;/
$B3:8BF8 A9 FF 8B    LDA #$8BFF             ;\
$B3:8BFB 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function pointer = $8BFF

$B3:8BFE 60          RTS
}


;;; $8BFF: Norfair pipe bug function - wait for Samus to get near ;;;
{
$B3:8BFF AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8C02 BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$B3:8C05 29 FF 00    AND #$00FF             ;|
$B3:8C08 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;} If Samus is not within [enemy parameter 2 low] pixel columns of enemy: return
$B3:8C0C F0 43       BEQ $43    [$8C51]     ;/
$B3:8C0E BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:8C11 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;} If [enemy Y position] < [Samus Y position]: return
$B3:8C14 30 3B       BMI $3B    [$8C51]     ;/
$B3:8C16 FE AC 0F    INC $0FAC,x[$7E:0FAC]  ; Increment enemy shoot delay timer
$B3:8C19 A9 01 00    LDA #$0001             ;\
$B3:8C1C 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$B3:8C1F 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$B3:8C22 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$B3:8C26 10 14       BPL $14    [$8C3C]     ;} If [Samus X position] < [enemy X position]:
$B3:8C28 A9 E1 8A    LDA #$8AE1             ;\
$B3:8C2B 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $8AE1
$B3:8C2E 9D D2 0F    STA $0FD2,x[$7E:1012]  ; Enemy ([X] + 1) instruction list pointer = $8AE1
$B3:8C31 9D 12 10    STA $1012,x[$7E:1052]  ; Enemy ([X] + 2) instruction list pointer = $8AE1
$B3:8C34 9D 52 10    STA $1052,x[$7E:1092]  ; Enemy ([X] + 3) instruction list pointer = $8AE1
$B3:8C37 9D 92 10    STA $1092,x[$7E:10D2]  ; Enemy ([X] + 4) instruction list pointer = $8AE1
$B3:8C3A 80 12       BRA $12    [$8C4E]

$B3:8C3C A9 21 8B    LDA #$8B21             ;\ ([Samus X position] >= [enemy X position]):
$B3:8C3F 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $8B21
$B3:8C42 9D D2 0F    STA $0FD2,x[$7E:0FD2]  ; Enemy ([X] + 1) instruction list pointer = $8B21
$B3:8C45 9D 12 10    STA $1012,x[$7E:1012]  ; Enemy ([X] + 2) instruction list pointer = $8B21
$B3:8C48 9D 52 10    STA $1052,x[$7E:1052]  ; Enemy ([X] + 3) instruction list pointer = $8B21
$B3:8C4B 9D 92 10    STA $1092,x[$7E:1092]  ; Enemy ([X] + 4) instruction list pointer = $8B21

$B3:8C4E 20 52 8C    JSR $8C52  [$B3:8C52]  ; Set up Norfair pipe bug formation

$B3:8C51 60          RTS
}


;;; $8C52: Set up Norfair pipe bug formation ;;;
{
$B3:8C52 A9 A6 8C    LDA #$8CA6             ;\
$B3:8C55 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $8CA6
$B3:8C58 9D E8 0F    STA $0FE8,x[$7E:0FE8]  ; Enemy ([X] + 1) function = $8CA6
$B3:8C5B 9D 28 10    STA $1028,x[$7E:1028]  ; Enemy ([X] + 2) function = $8CA6
$B3:8C5E 9D 68 10    STA $1068,x[$7E:1068]  ; Enemy ([X] + 3) function = $8CA6
$B3:8C61 9D A8 10    STA $10A8,x[$7E:10A8]  ; Enemy ([X] + 4) function = $8CA6
$B3:8C64 A9 68 00    LDA #$0068             ;\
$B3:8C67 9F 04 78 7E STA $7E7804,x[$7E:7804];} Enemy shoot delay = 68h
$B3:8C6B A9 60 00    LDA #$0060             ;\
$B3:8C6E 9F 44 78 7E STA $7E7844,x[$7E:7844];} Enemy ([X] + 1) shoot delay = 60h
$B3:8C72 A9 58 00    LDA #$0058             ;\
$B3:8C75 9F 84 78 7E STA $7E7884,x[$7E:7884];} Enemy ([X] + 2) shoot delay = 58h
$B3:8C79 A9 70 00    LDA #$0070             ;\
$B3:8C7C 9F C4 78 7E STA $7E78C4,x[$7E:78C4];} Enemy ([X] + 3) shoot delay = 70h
$B3:8C80 A9 78 00    LDA #$0078             ;\
$B3:8C83 9F 04 79 7E STA $7E7904,x[$7E:7904];} Enemy ([X] + 4) shoot delay = 78h
$B3:8C87 A9 FF 8C    LDA #$8CFF             ;\
$B3:8C8A 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy formation function pointer = $8CFF
$B3:8C8D A9 0C 8D    LDA #$8D0C             ;\
$B3:8C90 9D F2 0F    STA $0FF2,x[$7E:0FF2]  ;} Enemy ([X] + 1) formation function pointer = $8D0C
$B3:8C93 A9 4E 8D    LDA #$8D4E             ;\
$B3:8C96 9D 32 10    STA $1032,x[$7E:1032]  ;} Enemy ([X] + 2) formation function pointer = $8D4E
$B3:8C99 A9 90 8D    LDA #$8D90             ;\
$B3:8C9C 9D 72 10    STA $1072,x[$7E:1072]  ;} Enemy ([X] + 3) formation function pointer = $8D90
$B3:8C9F A9 D2 8D    LDA #$8DD2             ;\
$B3:8CA2 9D B2 10    STA $10B2,x[$7E:10B2]  ;} Enemy ([X] + 4) formation function pointer = $8DD2
$B3:8CA5 60          RTS
}


;;; $8CA6: Norfair pipe bug function - rising ;;;
{
$B3:8CA6 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8CA9 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$B3:8CAC 29 FF FE    AND #$FEFF             ;} Set enemy as visible
$B3:8CAF 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$B3:8CB2 A9 80 00    LDA #$0080             ;\
$B3:8CB5 A8          TAY                    ;} Y = 80h (linear speed table index)
$B3:8CB6 BD 80 0F    LDA $0F80,x[$7E:0FC0]  ;\
$B3:8CB9 18          CLC                    ;|
$B3:8CBA 79 8D 81    ADC $818D,y[$B3:820D]  ;|
$B3:8CBD 90 03       BCC $03    [$8CC2]     ;|
$B3:8CBF FE 7E 0F    INC $0F7E,x            ;|
                                            ;} Enemy Y position += [$8187 + [Y] + 4].[$8187 + [Y] + 6] (negated speed)
$B3:8CC2 9D 80 0F    STA $0F80,x[$7E:0FC0]  ;|
$B3:8CC5 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;|
$B3:8CC8 18          CLC                    ;|
$B3:8CC9 79 8B 81    ADC $818B,y[$B3:820B]  ;|
$B3:8CCC 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$B3:8CCF CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;\
$B3:8CD2 10 2A       BPL $2A    [$8CFE]     ;} If [enemy Y position] >= [Samus Y position]: return
$B3:8CD4 BD B2 0F    LDA $0FB2,x[$7E:1032]  ;\
$B3:8CD7 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function pointer = [enemy formation function pointer]
$B3:8CDA BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$B3:8CDD 9F 02 78 7E STA $7E7802,x[$7E:7882];} Enemy formation centre Y position = [enemy Y position]
$B3:8CE1 A9 01 00    LDA #$0001             ;\
$B3:8CE4 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$B3:8CE7 9E 90 0F    STZ $0F90,x[$7E:1010]  ; Enemy timer = 0
$B3:8CEA 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$B3:8CEE 10 08       BPL $08    [$8CF8]     ;} If [Samus X position] < [enemy X position]:
$B3:8CF0 A9 E1 8A    LDA #$8AE1             ;\
$B3:8CF3 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = $8AE1
$B3:8CF6 80 06       BRA $06    [$8CFE]

$B3:8CF8 A9 21 8B    LDA #$8B21             ;\ Else ([Samus X position] >= [enemy X position]):
$B3:8CFB 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $8B21

$B3:8CFE 60          RTS
}


;;; $8CFF: Norfair pipe bug function - move to formation - centre ;;;
{
$B3:8CFF AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8D02 FE AC 0F    INC $0FAC,x[$7E:0FEC]  ; Increment enemy shoot delay timer
$B3:8D05 A9 5A 8E    LDA #$8E5A             ;\
$B3:8D08 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function pointer = $8E5A
$B3:8D0B 60          RTS
}


;;; $8D0C: Norfair pipe bug function - move to formation - upper middle ;;;
{
$B3:8D0C AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8D0F FE AC 0F    INC $0FAC,x[$7E:102C]  ; Increment enemy shoot delay timer
$B3:8D12 A9 80 00    LDA #$0080             ;\
$B3:8D15 A8          TAY                    ;} Y = 80h (linear speed table index)
$B3:8D16 BD 80 0F    LDA $0F80,x[$7E:1000]  ;\
$B3:8D19 18          CLC                    ;|
$B3:8D1A 79 8D 81    ADC $818D,y[$B3:820D]  ;|
$B3:8D1D 90 03       BCC $03    [$8D22]     ;|
$B3:8D1F FE 7E 0F    INC $0F7E,x            ;|
                                            ;} Enemy Y position += [$8187 + [Y] + 4].[$8187 + [Y] + 6] (negated speed)
$B3:8D22 9D 80 0F    STA $0F80,x[$7E:1000]  ;|
$B3:8D25 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;|
$B3:8D28 18          CLC                    ;|
$B3:8D29 79 8B 81    ADC $818B,y[$B3:820B]  ;|
$B3:8D2C 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$B3:8D2F 18          CLC                    ;\
$B3:8D30 69 10 00    ADC #$0010             ;|
$B3:8D33 DF 02 78 7E CMP $7E7802,x[$7E:7882];} If [enemy Y position] < [enemy formation centre Y position] - 10h:
$B3:8D37 10 14       BPL $14    [$8D4D]     ;/
$B3:8D39 BF 02 78 7E LDA $7E7802,x[$7E:7882];\
$B3:8D3D 38          SEC                    ;|
$B3:8D3E E9 10 00    SBC #$0010             ;} Enemy Y position = [enemy formation centre Y position] - 10h
$B3:8D41 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$B3:8D44 9E 80 0F    STZ $0F80,x[$7E:1000]  ; Enemy Y subposition = 0
$B3:8D47 A9 5A 8E    LDA #$8E5A             ;\
$B3:8D4A 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function pointer = $8E5A

$B3:8D4D 60          RTS
}


;;; $8D4E: Norfair pipe bug function - move to formation - top ;;;
{
$B3:8D4E AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8D51 FE AC 0F    INC $0FAC,x[$7E:106C]  ; Increment enemy shoot delay timer
$B3:8D54 A9 80 00    LDA #$0080             ;\
$B3:8D57 A8          TAY                    ;} Y = 80h (linear speed table index)
$B3:8D58 BD 80 0F    LDA $0F80,x[$7E:1040]  ;\
$B3:8D5B 18          CLC                    ;|
$B3:8D5C 79 8D 81    ADC $818D,y[$B3:820D]  ;|
$B3:8D5F 90 03       BCC $03    [$8D64]     ;|
$B3:8D61 FE 7E 0F    INC $0F7E,x            ;|
                                            ;} Enemy Y position += [$8187 + [Y] + 4].[$8187 + [Y] + 6] (negated speed)
$B3:8D64 9D 80 0F    STA $0F80,x[$7E:1040]  ;|
$B3:8D67 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;|
$B3:8D6A 18          CLC                    ;|
$B3:8D6B 79 8B 81    ADC $818B,y[$B3:820B]  ;|
$B3:8D6E 9D 7E 0F    STA $0F7E,x[$7E:103E]  ;/
$B3:8D71 18          CLC                    ;\
$B3:8D72 69 20 00    ADC #$0020             ;|
$B3:8D75 DF 02 78 7E CMP $7E7802,x[$7E:78C2];} If [enemy Y position] < [enemy formation centre Y position] - 20h:
$B3:8D79 10 14       BPL $14    [$8D8F]     ;/
$B3:8D7B BF 02 78 7E LDA $7E7802,x[$7E:78C2];\
$B3:8D7F 38          SEC                    ;|
$B3:8D80 E9 20 00    SBC #$0020             ;} Enemy Y position = [enemy formation centre Y position] - 20h
$B3:8D83 9D 7E 0F    STA $0F7E,x[$7E:103E]  ;/
$B3:8D86 9E 80 0F    STZ $0F80,x[$7E:1040]  ; Enemy Y subposition = 0
$B3:8D89 A9 5A 8E    LDA #$8E5A             ;\
$B3:8D8C 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function pointer = $8E5A

$B3:8D8F 60          RTS
}


;;; $8D90: Norfair pipe bug function - move to formation - lower middle ;;;
{
$B3:8D90 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8D93 FE AC 0F    INC $0FAC,x[$7E:10AC]  ; Increment enemy shoot delay timer
$B3:8D96 A9 80 00    LDA #$0080             ;\
$B3:8D99 A8          TAY                    ;} Y = 80h (linear speed table index)
$B3:8D9A BD 80 0F    LDA $0F80,x[$7E:1080]  ;\
$B3:8D9D 18          CLC                    ;|
$B3:8D9E 79 89 81    ADC $8189,y[$B3:8209]  ;|
$B3:8DA1 90 03       BCC $03    [$8DA6]     ;|
$B3:8DA3 FE 7E 0F    INC $0F7E,x            ;|
                                            ;} Enemy Y position += [$8187 + [Y]].[$8187 + [Y] + 2] (speed)
$B3:8DA6 9D 80 0F    STA $0F80,x[$7E:1080]  ;|
$B3:8DA9 BD 7E 0F    LDA $0F7E,x[$7E:107E]  ;|
$B3:8DAC 18          CLC                    ;|
$B3:8DAD 79 87 81    ADC $8187,y[$B3:8207]  ;|
$B3:8DB0 9D 7E 0F    STA $0F7E,x[$7E:107E]  ;/
$B3:8DB3 38          SEC                    ;\
$B3:8DB4 E9 10 00    SBC #$0010             ;|
$B3:8DB7 DF 02 78 7E CMP $7E7802,x[$7E:7902];} If [enemy Y position] >= [enemy formation centre Y position] + 10h:
$B3:8DBB 30 14       BMI $14    [$8DD1]     ;/
$B3:8DBD BF 02 78 7E LDA $7E7802,x[$7E:7902];\
$B3:8DC1 18          CLC                    ;|
$B3:8DC2 69 10 00    ADC #$0010             ;} Enemy Y position = [enemy formation centre Y position] + 10h
$B3:8DC5 9D 7E 0F    STA $0F7E,x[$7E:107E]  ;/
$B3:8DC8 9E 80 0F    STZ $0F80,x[$7E:1080]  ; Enemy Y subposition = 0
$B3:8DCB A9 5A 8E    LDA #$8E5A             ;\
$B3:8DCE 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Enemy function pointer = $8E5A

$B3:8DD1 60          RTS
}


;;; $8DD2: Norfair pipe bug function - move to formation - bottom ;;;
{
$B3:8DD2 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8DD5 FE AC 0F    INC $0FAC,x[$7E:10EC]  ; Increment enemy shoot delay timer
$B3:8DD8 A9 80 00    LDA #$0080             ;\
$B3:8DDB A8          TAY                    ;} Y = 80h (linear speed table index)
$B3:8DDC BD 80 0F    LDA $0F80,x[$7E:10C0]  ;\
$B3:8DDF 18          CLC                    ;|
$B3:8DE0 79 89 81    ADC $8189,y[$B3:8209]  ;|
$B3:8DE3 90 03       BCC $03    [$8DE8]     ;|
$B3:8DE5 FE 7E 0F    INC $0F7E,x            ;|
                                            ;} Enemy Y position += [$8187 + [Y]].[$8187 + [Y] + 2] (speed)
$B3:8DE8 9D 80 0F    STA $0F80,x[$7E:10C0]  ;|
$B3:8DEB BD 7E 0F    LDA $0F7E,x[$7E:10BE]  ;|
$B3:8DEE 18          CLC                    ;|
$B3:8DEF 79 87 81    ADC $8187,y[$B3:8207]  ;|
$B3:8DF2 9D 7E 0F    STA $0F7E,x[$7E:10BE]  ;/
$B3:8DF5 38          SEC                    ;\
$B3:8DF6 E9 20 00    SBC #$0020             ;|
$B3:8DF9 DF 02 78 7E CMP $7E7802,x[$7E:7942];} If [enemy Y position] >= [enemy formation centre Y position] + 20h:
$B3:8DFD 30 14       BMI $14    [$8E13]     ;/
$B3:8DFF BF 02 78 7E LDA $7E7802,x[$7E:7942];\
$B3:8E03 18          CLC                    ;|
$B3:8E04 69 20 00    ADC #$0020             ;} Enemy Y position = [enemy formation centre Y position] + 20h
$B3:8E07 9D 7E 0F    STA $0F7E,x[$7E:10BE]  ;/
$B3:8E0A 9E 80 0F    STZ $0F80,x[$7E:10C0]  ; Enemy Y subposition = 0
$B3:8E0D A9 5A 8E    LDA #$8E5A             ;\
$B3:8E10 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy function pointer = $8E5A

$B3:8E13 60          RTS
}


;;; $8E14: Norfair pipe bug function - shooting left ;;;
{
$B3:8E14 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8E17 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;\
$B3:8E1A A8          TAY                    ;} Y = [enemy X speed table index] (linear speed table index)
$B3:8E1B BD 7C 0F    LDA $0F7C,x[$7E:103C]  ;\
$B3:8E1E 18          CLC                    ;|
$B3:8E1F 79 8D 81    ADC $818D,y[$B3:838D]  ;|
$B3:8E22 90 03       BCC $03    [$8E27]     ;|
$B3:8E24 FE 7A 0F    INC $0F7A,x            ;|
                                            ;} Enemy X position += [$8187 + [Y] + 4].[$8187 + [Y] + 6] (negated speed)
$B3:8E27 9D 7C 0F    STA $0F7C,x[$7E:103C]  ;|
$B3:8E2A BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;|
$B3:8E2D 18          CLC                    ;|
$B3:8E2E 79 8B 81    ADC $818B,y[$B3:838B]  ;|
$B3:8E31 9D 7A 0F    STA $0F7A,x[$7E:103A]  ;/
$B3:8E34 60          RTS
}


;;; $8E35: Norfair pipe bug function - shooting right ;;;
{
$B3:8E35 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8E38 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;\
$B3:8E3B A8          TAY                    ;} Y = [enemy X speed table index] (linear speed table index)
$B3:8E3C BD 7C 0F    LDA $0F7C,x[$7E:103C]  ;\
$B3:8E3F 18          CLC                    ;|
$B3:8E40 79 89 81    ADC $8189,y[$B3:8309]  ;|
$B3:8E43 90 03       BCC $03    [$8E48]     ;|
$B3:8E45 FE 7A 0F    INC $0F7A,x            ;|
                                            ;} Enemy X position += [$8187 + [Y]].[$8187 + [Y] + 2] (speed)
$B3:8E48 9D 7C 0F    STA $0F7C,x[$7E:103C]  ;|
$B3:8E4B BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;|
$B3:8E4E 18          CLC                    ;|
$B3:8E4F 79 87 81    ADC $8187,y[$B3:8307]  ;|
$B3:8E52 9D 7A 0F    STA $0F7A,x[$7E:103A]  ;/
$B3:8E55 60          RTS
}


;;; $8E56: Unused. RTS ;;;
{
$B3:8E56 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8E59 60          RTS
}


;;; $8E5A: Norfair pipe bug function - shoot delay ;;;
{
$B3:8E5A AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8E5D FE AC 0F    INC $0FAC,x[$7E:0FEC]  ; Increment enemy shoot delay timer
$B3:8E60 BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$B3:8E63 DF 04 78 7E CMP $7E7804,x[$7E:7844];} If [enemy shoot delay timer] >= [enemy $7E:7804]:
$B3:8E67 30 2A       BMI $2A    [$8E93]     ;/
$B3:8E69 9E AC 0F    STZ $0FAC,x[$7E:106C]  ; Enemy shoot delay timer = 0
$B3:8E6C A9 01 00    LDA #$0001             ;\
$B3:8E6F 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Enemy instruction timer = 1
$B3:8E72 9E 90 0F    STZ $0F90,x[$7E:1050]  ; Enemy timer = 0
$B3:8E75 A9 14 8E    LDA #$8E14             ;\
$B3:8E78 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $8E14
$B3:8E7B A9 05 8B    LDA #$8B05             ;\
$B3:8E7E 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $8B05
$B3:8E81 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$B3:8E85 30 0C       BMI $0C    [$8E93]     ;} If [Samus X position] >= [enemy X position]:
$B3:8E87 A9 35 8E    LDA #$8E35             ;\
$B3:8E8A 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $8E35
$B3:8E8D A9 45 8B    LDA #$8B45             ;\
$B3:8E90 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $8B45

$B3:8E93 60          RTS
}


;;; $8E94: RTL ;;;
{
$B3:8E94 6B          RTL
}


;;; $8E95: RTL ;;;
{
$B3:8E95 6B          RTL
}


;;; $8E96: Spritemaps ;;;
{
$B3:8E96             dx 0001, 81F8,F8,2100
$B3:8E9D             dx 0001, 81F8,F8,2102
$B3:8EA4             dx 0001, 81F8,F8,2104
$B3:8EAB             dx 0001, 81F8,F8,2106
$B3:8EB2             dx 0001, 81F8,F8,2108
$B3:8EB9             dx 0001, 81F8,F8,6100
$B3:8EC0             dx 0001, 81F8,F8,6102
$B3:8EC7             dx 0001, 81F8,F8,6104
$B3:8ECE             dx 0001, 81F8,F8,6106
$B3:8ED5             dx 0001, 81F8,F8,6108
}
}


;;; $8EDC..9318: Brinstar yellow pipe bug ;;;
{
;;; $8EDC: Palette - enemy $F253 (Brinstar yellow pipe bug) ;;;
{
$B3:8EDC             dw 3800, 57FF, 42F7, 158C, 00A5, 4F5A, 36B5, 2610, 1DCE, 3FE0, 2EE0, 2200, 1100, 7E5B, 552F, 2887
}


;;; $8EFC: Instruction list - facing left - rising ;;;
{
$B3:8EFC             dx 0004,92AD,
                        0004,92B4,
                        0004,92BB,
                        0004,92B4,
                        80ED,8EFC   ; Go to $8EFC
}


;;; $8F10: Instruction list - facing left - shooting ;;;
{
$B3:8F10             dx 0001,92C2,
                        0001,92C9,
                        0001,92D0,
                        0001,92C9,
                        80ED,8F10   ; Go to $8F10
}


;;; $8F24: Instruction list - facing right - rising ;;;
{
$B3:8F24             dx 0004,92D7,
                        0004,92DE,
                        0004,92E5,
                        0004,92DE,
                        80ED,8F24   ; Go to $8F24
}


;;; $8F38: Instruction list - facing right - shooting ;;;
{
$B3:8F38             dx 0001,92EC,
                        0001,92F3,
                        0001,92FA,
                        0001,92F3,
                        80ED,8F38   ; Go to $8F38
}


;;; $8F4C: Initialisation AI - enemy $F253 (Brinstar yellow pipe bug) ;;;
{
$B3:8F4C AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8F4F BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$B3:8F52 9F 0E 78 7E STA $7E780E,x[$7E:78CE];} Enemy spawn X position = [enemy X position]
$B3:8F56 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$B3:8F59 9F 10 78 7E STA $7E7810,x[$7E:78D0];} Enemy spawn Y position = [enemy Y position]
$B3:8F5D 9E 7C 0F    STZ $0F7C,x[$7E:103C]  ; Enemy X subposition = 0
$B3:8F60 9E 80 0F    STZ $0F80,x[$7E:1040]  ; Enemy Y subposition = 0
$B3:8F63 A9 01 00    LDA #$0001             ;\
$B3:8F66 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Enemy instruction timer = 1
$B3:8F69 9E 90 0F    STZ $0F90,x[$7E:1050]  ; Enemy timer = 0
$B3:8F6C A9 FC 8E    LDA #$8EFC             ;\
$B3:8F6F 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $8EFC (facing left - rising)
$B3:8F72 BD B4 0F    LDA $0FB4,x[$7E:1074]  ;\
$B3:8F75 D0 06       BNE $06    [$8F7D]     ;} If [enemy parameter 1] = 0 (rightwards):
$B3:8F77 A9 24 8F    LDA #$8F24             ;\
$B3:8F7A 9D 92 0F    STA $0F92,x[$7E:1092]  ;} Enemy instruction list pointer = $8F24 (facing right - rising)

$B3:8F7D BD B6 0F    LDA $0FB6,x[$7E:1076]  ;\
$B3:8F80 0A          ASL A                  ;|
$B3:8F81 0A          ASL A                  ;} Y = [enemy parameter 2] * 8 (linear speed table index)
$B3:8F82 0A          ASL A                  ;|
$B3:8F83 A8          TAY                    ;/
$B3:8F84 B9 87 81    LDA $8187,y[$B3:82A7]  ;\
$B3:8F87 9F 02 78 7E STA $7E7802,x[$7E:78C2];|
$B3:8F8B B9 89 81    LDA $8189,y[$B3:82A9]  ;} Enemy right velocity = [$8187 + [Y]].[$8187 + [Y] + 2]
$B3:8F8E 9F 00 78 7E STA $7E7800,x[$7E:78C0];/
$B3:8F92 B9 8B 81    LDA $818B,y[$B3:82AB]  ;\
$B3:8F95 9F 06 78 7E STA $7E7806,x[$7E:78C6];|
$B3:8F99 B9 8D 81    LDA $818D,y[$B3:82AD]  ;} Enemy left velocity = [$8187 + [Y] + 4].[$8187 + [Y] + 6]
$B3:8F9C 9F 04 78 7E STA $7E7804,x[$7E:78C4];/
$B3:8FA0 A9 B5 8F    LDA #$8FB5             ;\
$B3:8FA3 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $8FB5 (wait for Samus to get near)
$B3:8FA6 A9 00 00    LDA #$0000             ;\
$B3:8FA9 9F 0C 78 7E STA $7E780C,x[$7E:78CC];} Enemy dip disable flag = 0
$B3:8FAD 6B          RTL
}


;;; $8FAE: Main AI - enemy $F253 (Brinstar yellow pipe bug) ;;;
{
$B3:8FAE AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8FB1 FC A8 0F    JSR ($0FA8,x)[$B3:8FB5]
$B3:8FB4 6B          RTL
}


;;; $8FB5: Brinstar yellow pipe bug function - wait for Samus to get near ;;;
{
$B3:8FB5 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:8FB8 BD B4 0F    LDA $0FB4,x[$7E:1074]  ;\
$B3:8FBB D0 0D       BNE $0D    [$8FCA]     ;} If [enemy parameter 1] = 0 (rightwards):
$B3:8FBD 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$B3:8FC1 30 31       BMI $31    [$8FF4]     ;|
$B3:8FC3 C9 C0 00    CMP #$00C0             ;} If not 0 <= [Samus X position] - [enemy X position] < C0h: return
$B3:8FC6 10 2C       BPL $2C    [$8FF4]     ;/
$B3:8FC8 80 0B       BRA $0B    [$8FD5]

                                            ; Else ([enemy parameter 1] != 0 (leftwards)):
$B3:8FCA 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$B3:8FCE 10 24       BPL $24    [$8FF4]     ;|
$B3:8FD0 C9 40 FF    CMP #$FF40             ;} If not -C0h <= [Samus X position] - [enemy X position] < 0: return
$B3:8FD3 30 1F       BMI $1F    [$8FF4]     ;/

$B3:8FD5 A9 30 00    LDA #$0030             ;\
$B3:8FD8 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;} If Samus is within 30h pixel rows of enemy:
$B3:8FDC F0 16       BEQ $16    [$8FF4]     ;/
$B3:8FDE BD 86 0F    LDA $0F86,x[$7E:1046]  ;\
$B3:8FE1 29 FF FE    AND #$FEFF             ;} Set enemy as visible
$B3:8FE4 9D 86 0F    STA $0F86,x[$7E:1046]  ;/
$B3:8FE7 A9 18 00    LDA #$0018             ;\
$B3:8FEA 9F 00 80 7E STA $7E8000,x[$7E:80C0];} Enemy shoot delay timer = 18h
$B3:8FEE A9 F5 8F    LDA #$8FF5             ;\
$B3:8FF1 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $8FF5 (shoot delay)

$B3:8FF4 60          RTS
}


;;; $8FF5: Brinstar yellow pipe bug function - shoot delay ;;;
{
$B3:8FF5 BF 00 80 7E LDA $7E8000,x[$7E:80C0];\
$B3:8FF9 3A          DEC A                  ;} Decrement enemy shoot delay timer
$B3:8FFA 9F 00 80 7E STA $7E8000,x[$7E:80C0];/
$B3:8FFE F0 01       BEQ $01    [$9001]     ; If [enemy shoot delay timer] != 0:
$B3:9000 60          RTS                    ; Return

$B3:9001 A9 01 00    LDA #$0001             ;\
$B3:9004 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Enemy instruction timer = 1
$B3:9007 9E 90 0F    STZ $0F90,x[$7E:1050]  ; Enemy timer = 0
$B3:900A A9 FC 8E    LDA #$8EFC             ;\
$B3:900D 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $8EFC (facing left - rising)
$B3:9010 A9 28 90    LDA #$9028             ;\
$B3:9013 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $9028 (shooting left)
$B3:9016 BD B4 0F    LDA $0FB4,x[$7E:1074]  ;\
$B3:9019 D0 0C       BNE $0C    [$9027]     ;} If [enemy parameter 1] = 0 (rightwards):
$B3:901B A9 24 8F    LDA #$8F24             ;\
$B3:901E 9D 92 0F    STA $0F92,x[$7E:1092]  ;} Enemy instruction list pointer = $8F24 (facing right - rising)
$B3:9021 A9 BD 90    LDA #$90BD             ;\
$B3:9024 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Enemy function = $90BD (shooting right)

$B3:9027 60          RTS
}


;;; $9028: Brinstar yellow pipe bug function - shooting left ;;;
{
$B3:9028 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:902B 20 A1 90    JSR $90A1  [$B3:90A1]  ; Move Brinstar yellow pipe bug left
$B3:902E 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$B3:9032 F0 2C       BEQ $2C    [$9060]     ;} If enemy centre is not on screen:
$B3:9034 BF 0E 78 7E LDA $7E780E,x          ;\
$B3:9038 9D 7A 0F    STA $0F7A,x            ;} Enemy X position = [enemy spawn X position]
$B3:903B BF 10 78 7E LDA $7E7810,x          ;\
$B3:903F 9D 7E 0F    STA $0F7E,x            ;} Enemy Y position = [enemy spawn Y position]
$B3:9042 9E 7C 0F    STZ $0F7C,x            ; Enemy X subposition = 0
$B3:9045 9E 80 0F    STZ $0F80,x            ; Enemy Y subposition = 0
$B3:9048 A9 B5 8F    LDA #$8FB5             ;\
$B3:904B 9D A8 0F    STA $0FA8,x            ;} Enemy function = $8FB5 (wait for Samus to get near)
$B3:904E A9 00 00    LDA #$0000             ;\
$B3:9051 9F 0C 78 7E STA $7E780C,x          ;} Enemy dip disable flag = 0
$B3:9055 BD 86 0F    LDA $0F86,x            ;\
$B3:9058 09 00 01    ORA #$0100             ;} Set enemy as invisible
$B3:905B 9D 86 0F    STA $0F86,x            ;/
$B3:905E 80 40       BRA $40    [$90A0]     ; Return

$B3:9060 BF 0C 78 7E LDA $7E780C,x[$7E:78CC];\
$B3:9064 D0 3A       BNE $3A    [$90A0]     ;} If [enemy dip disable flag] = 0:
$B3:9066 BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$B3:9069 38          SEC                    ;|
$B3:906A ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} If [enemy X position] < [Samus X position] + 30h:
$B3:906D C9 30 00    CMP #$0030             ;|
$B3:9070 10 2E       BPL $2E    [$90A0]     ;/
$B3:9072 A9 5A 91    LDA #$915A             ;\
$B3:9075 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $915A (dipping left)
$B3:9078 9E AC 0F    STZ $0FAC,x[$7E:106C]  ; Enemy X subposition = 0
$B3:907B 9E AE 0F    STZ $0FAE,x[$7E:106E]  ; Enemy Y subposition = 0
$B3:907E A9 28 00    LDA #$0028             ;\
$B3:9081 9D B0 0F    STA $0FB0,x[$7E:1070]  ;} Enemy Y speed table index = 28h
$B3:9084 A9 01 00    LDA #$0001             ;\
$B3:9087 9D B2 0F    STA $0FB2,x[$7E:1072]  ;} Enemy dip direction = down
$B3:908A BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$B3:908D 9F 08 78 7E STA $7E7808,x[$7E:78C8];} Enemy $7E:7808 = [enemy X position] (unused)
$B3:9091 A9 01 00    LDA #$0001             ;\
$B3:9094 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Enemy instruction timer = 1
$B3:9097 9E 90 0F    STZ $0F90,x[$7E:1050]  ; Enemy timer = 0
$B3:909A A9 10 8F    LDA #$8F10             ;\
$B3:909D 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $8F10 (facing left - shooting)

$B3:90A0 60          RTS
}


;;; $90A1: Move Brinstar yellow pipe bug left ;;;
{
$B3:90A1 BD 7C 0F    LDA $0F7C,x[$7E:103C]  ;\
$B3:90A4 18          CLC                    ;|
$B3:90A5 7F 04 78 7E ADC $7E7804,x[$7E:78C4];|
$B3:90A9 90 03       BCC $03    [$90AE]     ;|
$B3:90AB FE 7A 0F    INC $0F7A,x[$7E:103A]  ;|
                                            ;} Enemy X position += [enemy left velocity]
$B3:90AE 9D 7C 0F    STA $0F7C,x[$7E:103C]  ;|
$B3:90B1 BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;|
$B3:90B4 18          CLC                    ;|
$B3:90B5 7F 06 78 7E ADC $7E7806,x[$7E:78C6];|
$B3:90B9 9D 7A 0F    STA $0F7A,x[$7E:103A]  ;/
$B3:90BC 60          RTS
}


;;; $90BD: Brinstar yellow pipe bug function - shooting right ;;;
{
$B3:90BD AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:90C0 20 3A 91    JSR $913A  [$B3:913A]  ; Move Brinstar yellow pipe bug right
$B3:90C3 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$B3:90C7 F0 2C       BEQ $2C    [$90F5]     ;} If enemy centre is not on screen:
$B3:90C9 BF 0E 78 7E LDA $7E780E,x[$7E:790E];\
$B3:90CD 9D 7A 0F    STA $0F7A,x[$7E:107A]  ;} Enemy X position = [enemy spawn X position]
$B3:90D0 BF 10 78 7E LDA $7E7810,x[$7E:7910];\
$B3:90D4 9D 7E 0F    STA $0F7E,x[$7E:107E]  ;} Enemy Y position = [enemy spawn Y position]
$B3:90D7 9E 7C 0F    STZ $0F7C,x[$7E:107C]  ; Enemy X subposition = 0
$B3:90DA 9E 80 0F    STZ $0F80,x[$7E:1080]  ; Enemy Y subposition = 0
$B3:90DD A9 B5 8F    LDA #$8FB5             ;\
$B3:90E0 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Enemy function = $8FB5 (wait for Samus to get near)
$B3:90E3 A9 00 00    LDA #$0000             ;\
$B3:90E6 9F 0C 78 7E STA $7E780C,x[$7E:790C];} Enemy dip disable flag = 0
$B3:90EA BD 86 0F    LDA $0F86,x[$7E:1086]  ;\
$B3:90ED 09 00 01    ORA #$0100             ;} Set enemy as invisible
$B3:90F0 9D 86 0F    STA $0F86,x[$7E:1086]  ;/
$B3:90F3 80 44       BRA $44    [$9139]     ; Return

$B3:90F5 BF 0C 78 7E LDA $7E780C,x[$7E:7A4C];\
$B3:90F9 D0 3E       BNE $3E    [$9139]     ;} If [enemy dip disable flag] = 0:
$B3:90FB BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;\
$B3:90FE 38          SEC                    ;|
$B3:90FF ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$B3:9102 49 FF FF    EOR #$FFFF             ;} If [Samus X position] < [enemy X position] + 30h:
$B3:9105 1A          INC A                  ;|
$B3:9106 C9 30 00    CMP #$0030             ;|
$B3:9109 10 2E       BPL $2E    [$9139]     ;/
$B3:910B A9 D8 91    LDA #$91D8             ;\
$B3:910E 9D A8 0F    STA $0FA8,x[$7E:11E8]  ;} Enemy function = $91D8
$B3:9111 9E AC 0F    STZ $0FAC,x[$7E:11EC]  ; Enemy X subposition = 0
$B3:9114 9E AE 0F    STZ $0FAE,x[$7E:11EE]  ; Enemy Y subposition = 0
$B3:9117 A9 28 00    LDA #$0028             ;\
$B3:911A 9D B0 0F    STA $0FB0,x[$7E:11F0]  ;} Enemy Y speed table index = 28h
$B3:911D A9 01 00    LDA #$0001             ;\
$B3:9120 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;} Enemy dip direction = down
$B3:9123 BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;\
$B3:9126 9F 08 78 7E STA $7E7808,x[$7E:7A48];} Enemy $7E:7808 = [enemy X position] (unused)
$B3:912A A9 01 00    LDA #$0001             ;\
$B3:912D 9D 94 0F    STA $0F94,x[$7E:11D4]  ;} Enemy instruction timer = 1
$B3:9130 9E 90 0F    STZ $0F90,x[$7E:11D0]  ; Enemy timer = 0
$B3:9133 A9 38 8F    LDA #$8F38             ;\
$B3:9136 9D 92 0F    STA $0F92,x[$7E:11D2]  ;} Enemy instruction list pointer = $8F38

$B3:9139 60          RTS
}


;;; $913A: Move Brinstar yellow pipe bug right ;;;
{
$B3:913A BD AA 0F    LDA $0FAA,x[$7E:10AA]  ;\
$B3:913D A8          TAY                    ;} Y = [enemy $0FAA] (unused)
$B3:913E BD 7C 0F    LDA $0F7C,x[$7E:107C]  ;\
$B3:9141 18          CLC                    ;|
$B3:9142 7F 00 78 7E ADC $7E7800,x[$7E:7900];|
$B3:9146 90 03       BCC $03    [$914B]     ;|
$B3:9148 FE 7A 0F    INC $0F7A,x            ;|
                                            ;} Enemy X position += [enemy right velocity]
$B3:914B 9D 7C 0F    STA $0F7C,x[$7E:107C]  ;|
$B3:914E BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;|
$B3:9151 18          CLC                    ;|
$B3:9152 7F 02 78 7E ADC $7E7802,x[$7E:7902];|
$B3:9156 9D 7A 0F    STA $0F7A,x[$7E:107A]  ;/
$B3:9159 60          RTS
}


;;; $915A: Brinstar yellow pipe bug function - dipping left ;;;
{
$B3:915A AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:915D 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$B3:9161 F0 3C       BEQ $3C    [$919F]     ;} If enemy centre is not on screen:
$B3:9163 BF 0E 78 7E LDA $7E780E,x[$7E:78CE];\
$B3:9167 9D 7A 0F    STA $0F7A,x[$7E:103A]  ;} Enemy X position = [enemy spawn X position]
$B3:916A BF 10 78 7E LDA $7E7810,x[$7E:78D0];\
$B3:916E 9D 7E 0F    STA $0F7E,x[$7E:103E]  ;} Enemy Y position = [enemy spawn Y position]
$B3:9171 9E 7C 0F    STZ $0F7C,x[$7E:103C]  ; Enemy X subposition = 0
$B3:9174 9E 80 0F    STZ $0F80,x[$7E:1040]  ; Enemy Y subposition = 0
$B3:9177 A9 B5 8F    LDA #$8FB5             ;\
$B3:917A 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $8FB5 (wait for Samus to get near)
$B3:917D A9 00 00    LDA #$0000             ;\
$B3:9180 9F 0C 78 7E STA $7E780C,x[$7E:78CC];} Enemy dip disable flag = 0
$B3:9184 A9 01 00    LDA #$0001             ;\
$B3:9187 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Enemy instruction timer = 1
$B3:918A 9E 90 0F    STZ $0F90,x[$7E:1050]  ; Enemy timer = 0
$B3:918D A9 FC 8E    LDA #$8EFC             ;\
$B3:9190 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $8EFC (facing left - rising)
$B3:9193 BD 86 0F    LDA $0F86,x[$7E:1046]  ;\
$B3:9196 09 00 01    ORA #$0100             ;} Set enemy as invisible
$B3:9199 9D 86 0F    STA $0F86,x[$7E:1046]  ;/
$B3:919C 4C D7 91    JMP $91D7  [$B3:91D7]  ; Return

$B3:919F 20 A1 90    JSR $90A1  [$B3:90A1]  ; Move Brinstar yellow pipe bug left
$B3:91A2 BD B2 0F    LDA $0FB2,x[$7E:1072]  ;\
$B3:91A5 D0 2D       BNE $2D    [$91D4]     ;} If [enemy dip direction] = up:
$B3:91A7 20 56 92    JSR $9256  [$B3:9256]  ; Move Brinstar yellow pipe bug up
$B3:91AA BD 7E 0F    LDA $0F7E,x[$7E:10BE]  ;\
$B3:91AD DF 10 78 7E CMP $7E7810,x[$7E:7950];} If [enemy Y position] >= [enemy spawn Y position]: return
$B3:91B1 10 24       BPL $24    [$91D7]     ;/
$B3:91B3 A9 01 00    LDA #$0001             ;\
$B3:91B6 9F 0C 78 7E STA $7E780C,x          ;} Enemy dip disable flag = 1
$B3:91BA 9D B2 0F    STA $0FB2,x            ; Enemy dip direction = down
$B3:91BD A9 28 90    LDA #$9028             ;\
$B3:91C0 9D A8 0F    STA $0FA8,x            ;} Enemy function = $9028 (shooting left)
$B3:91C3 A9 01 00    LDA #$0001             ;\
$B3:91C6 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$B3:91C9 9E 90 0F    STZ $0F90,x            ; Enemy timer = 0
$B3:91CC A9 FC 8E    LDA #$8EFC             ;\
$B3:91CF 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $8EFC (facing left - rising)
$B3:91D2 80 03       BRA $03    [$91D7]

                                            ; Else ([enemy dip direction] = down):
$B3:91D4 20 7A 92    JSR $927A  [$B3:927A]  ; Move Brinstar yellow pipe bug down

$B3:91D7 60          RTS
}


;;; $91D8: Brinstar yellow pipe bug function - dipping right ;;;
{
$B3:91D8 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:91DB 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$B3:91DF F0 3C       BEQ $3C    [$921D]     ;} If enemy centre is not on screen:
$B3:91E1 BF 0E 78 7E LDA $7E780E,x[$7E:7A4E];\
$B3:91E5 9D 7A 0F    STA $0F7A,x[$7E:11BA]  ;} Enemy X position = [enemy spawn X position]
$B3:91E8 BF 10 78 7E LDA $7E7810,x[$7E:7A50];\
$B3:91EC 9D 7E 0F    STA $0F7E,x[$7E:11BE]  ;} Enemy Y position = [enemy spawn Y position]
$B3:91EF 9E 7C 0F    STZ $0F7C,x[$7E:11BC]  ; Enemy X subposition = 0
$B3:91F2 9E 80 0F    STZ $0F80,x[$7E:11C0]  ; Enemy Y subposition = 0
$B3:91F5 A9 B5 8F    LDA #$8FB5             ;\
$B3:91F8 9D A8 0F    STA $0FA8,x[$7E:11E8]  ;} Enemy function = $8FB5 (wait for Samus to get near)
$B3:91FB A9 00 00    LDA #$0000             ;\
$B3:91FE 9F 0C 78 7E STA $7E780C,x[$7E:7A4C];} Enemy dip disable flag = 0
$B3:9202 A9 01 00    LDA #$0001             ;\
$B3:9205 9D 94 0F    STA $0F94,x[$7E:11D4]  ;} Enemy instruction timer = 1
$B3:9208 9E 90 0F    STZ $0F90,x[$7E:11D0]  ; Enemy timer = 0
$B3:920B A9 24 8F    LDA #$8F24             ;\
$B3:920E 9D 92 0F    STA $0F92,x[$7E:11D2]  ;} Enemy instruction list pointer = $8F24 (facing right - rising)
$B3:9211 BD 86 0F    LDA $0F86,x[$7E:11C6]  ;\
$B3:9214 09 00 01    ORA #$0100             ;} Set enemy as invisible
$B3:9217 9D 86 0F    STA $0F86,x[$7E:11C6]  ;/
$B3:921A 4C 55 92    JMP $9255  [$B3:9255]  ; Return

$B3:921D 20 3A 91    JSR $913A  [$B3:913A]  ; Move Brinstar yellow pipe bug right
$B3:9220 BD B2 0F    LDA $0FB2,x[$7E:11F2]  ;\
$B3:9223 D0 2D       BNE $2D    [$9252]     ;} If [enemy dip direction] = up:
$B3:9225 20 56 92    JSR $9256  [$B3:9256]  ; Move Brinstar yellow pipe bug up
$B3:9228 BF 10 78 7E LDA $7E7810,x          ;\
$B3:922C DD 7E 0F    CMP $0F7E,x            ;} If [enemy Y position] > [enemy spawn Y position]: return
$B3:922F 30 24       BMI $24    [$9255]     ;/
$B3:9231 A9 01 00    LDA #$0001             ;\
$B3:9234 9F 0C 78 7E STA $7E780C,x          ;} Enemy dip disable flag = 1
$B3:9238 9D B2 0F    STA $0FB2,x            ; Enemy dip direction = down
$B3:923B A9 01 00    LDA #$0001             ;\
$B3:923E 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$B3:9241 9E 90 0F    STZ $0F90,x            ; Enemy timer = 0
$B3:9244 A9 24 8F    LDA #$8F24             ;\
$B3:9247 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $8F24 (facing right - rising)
$B3:924A A9 BD 90    LDA #$90BD             ;\
$B3:924D 9D A8 0F    STA $0FA8,x            ;} Enemy function = $90BD (shooting right)
$B3:9250 80 03       BRA $03    [$9255]     ; Return

                                            ; Else ([enemy dip direction] = down):
$B3:9252 20 7A 92    JSR $927A  [$B3:927A]  ; Move Brinstar yellow pipe bug down

$B3:9255 60          RTS
}


;;; $9256: Move Brinstar yellow pipe bug up ;;;
{
$B3:9256 FE B0 0F    INC $0FB0,x[$7E:10F0]  ; Increment enemy Y speed table index
$B3:9259 BD B0 0F    LDA $0FB0,x[$7E:10F0]  ;\
$B3:925C 0A          ASL A                  ;|
$B3:925D 0A          ASL A                  ;} Y = [enemy Y speed table index] / 100h * 8 (quadratic speed table index)
$B3:925E 0A          ASL A                  ;|
$B3:925F A8          TAY                    ;/
$B3:9260 BD 80 0F    LDA $0F80,x[$7E:10C0]  ;\
$B3:9263 18          CLC                    ;|
$B3:9264 79 93 83    ADC $8393,y[$B3:839B]  ;|
$B3:9267 90 03       BCC $03    [$926C]     ;|
$B3:9269 FE 7E 0F    INC $0F7E,x[$7E:10BE]  ;|
                                            ;} Enemy Y position += [$838F + [Y] + 6].[$838F + [Y] + 4]
$B3:926C 9D 80 0F    STA $0F80,x[$7E:10C0]  ;|
$B3:926F BD 7E 0F    LDA $0F7E,x[$7E:10BE]  ;|
$B3:9272 18          CLC                    ;|
$B3:9273 79 95 83    ADC $8395,y[$B3:839D]  ;|
$B3:9276 9D 7E 0F    STA $0F7E,x[$7E:10BE]  ;/
$B3:9279 60          RTS
}


;;; $927A: Move Brinstar yellow pipe bug down ;;;
{
$B3:927A DE B0 0F    DEC $0FB0,x[$7E:1070]  ; Decrement enemy Y speed table index
$B3:927D 10 0B       BPL $0B    [$928A]     ; If [enemy Y speed table index] < 0:
$B3:927F A9 00 00    LDA #$0000             ;\
$B3:9282 9D B0 0F    STA $0FB0,x[$7E:10F0]  ;} Enemy Y speed table index = 0
$B3:9285 9D B2 0F    STA $0FB2,x[$7E:10F2]  ; Enemy dip direction = up
$B3:9288 80 20       BRA $20    [$92AA]     ; Return

$B3:928A BD B0 0F    LDA $0FB0,x[$7E:1070]  ;\
$B3:928D 0A          ASL A                  ;|
$B3:928E 0A          ASL A                  ;} Y = [enemy Y speed table index] * 8 (quadratic speed table index)
$B3:928F 0A          ASL A                  ;|
$B3:9290 A8          TAY                    ;/
$B3:9291 BD 80 0F    LDA $0F80,x[$7E:1040]  ;\
$B3:9294 18          CLC                    ;|
$B3:9295 79 8F 83    ADC $838F,y[$B3:84C7]  ;|
$B3:9298 90 03       BCC $03    [$929D]     ;|
$B3:929A FE 7E 0F    INC $0F7E,x[$7E:103E]  ;|
                                            ;} Enemy Y position += [$838F + [Y] + 2].[$838F + [Y]]
$B3:929D 9D 80 0F    STA $0F80,x[$7E:1040]  ;|
$B3:92A0 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;|
$B3:92A3 18          CLC                    ;|
$B3:92A4 79 91 83    ADC $8391,y[$B3:84C9]  ;|
$B3:92A7 9D 7E 0F    STA $0F7E,x[$7E:103E]  ;/

$B3:92AA 60          RTS
}


;;; $92AB: RTL ;;;
{
$B3:92AB 6B          RTL
}


;;; $92AC: RTL ;;;
{
$B3:92AC 6B          RTL
}


;;; $92AD: Spritemaps ;;;
{
$B3:92AD             dx 0001, C3F8,F8,2100
$B3:92B4             dx 0001, C3F8,F8,2102
$B3:92BB             dx 0001, C3F8,F8,2104
$B3:92C2             dx 0001, C3F8,F8,2106
$B3:92C9             dx 0001, C3F8,F8,2108
$B3:92D0             dx 0001, C3F8,F8,210A
$B3:92D7             dx 0001, C3F8,F8,6100
$B3:92DE             dx 0001, C3F8,F8,6102
$B3:92E5             dx 0001, C3F8,F8,6104
$B3:92EC             dx 0001, C3F8,F8,6106
$B3:92F3             dx 0001, C3F8,F8,6108
$B3:92FA             dx 0001, C3F8,F8,610A
}


;;; $9301: Spritemap pointers ;;;
{
$B3:9301             dw 92AD, 92B4, 92BB, 92C2, 92C9, 92D0, 92D7, 92DE, 92E5, 92EC, 92F3, 92FA
}
}


;;; $9319..E524: Botwoon ;;;
{
;;; $9319: Palette - enemy $F293 (Botwoon) ;;;
{
$B3:9319             dw 0000, 27E9, 1A66, 1585, 0CA3, 3F9C, 2E97, 1D72, 108E, 0A5F, 09DB, 0956, 08D2, 082C, 7FBD, 0C05
}


;;; $9339..946A: Instruction lists - Botwoon ;;;
{
;;; $9339: Unused. Instruction list - mouth closed - aiming up (facing left) ;;;
{
$B3:9339             dx 94C7,       ; Enemy radius = 8 x 10h
                        0001,E31D,
                        812F        ; Sleep
}


;;; $9341: Instruction list - mouth closed - aiming up-left ;;;
{
$B3:9341             dx 94D7,       ; Enemy radius = Ch x Ch
                        0001,E329,
                        812F        ; Sleep
}


;;; $9349: Instruction list - mouth closed - aiming left ;;;
{
$B3:9349             dx 94E7,       ; Enemy radius = 10h x 8
                        0001,E335,
                        812F        ; Sleep
}


;;; $9351: Instruction list - mouth closed - aiming down-left ;;;
{
$B3:9351             dx 94F7,       ; Enemy radius = Ch x Ch
                        0001,E341,
                        812F        ; Sleep
}


;;; $9359: Unused. Instruction list - mouth closed - aiming down (facing left) ;;;
{
$B3:9359             dx 9507,       ; Enemy radius = 8 x 10h
                        0001,E34D,
                        812F        ; Sleep
}


;;; $9361: Instruction list - mouth closed - aiming down (facing right) ;;;
{
$B3:9361             dx 9517,       ; Enemy radius = 8 x 10h
                        0001,E359,
                        812F        ; Sleep
}


;;; $9369: Instruction list - mouth closed - aiming down-right ;;;
{
$B3:9369             dx 9527,       ; Enemy radius = Ch x Ch
                        0001,E365,
                        812F        ; Sleep
}


;;; $9371: Instruction list - mouth closed - aiming right ;;;
{
$B3:9371             dx 9537,       ; Enemy radius = 10h x 8
                        0001,E371,
                        812F        ; Sleep
}


;;; $9379: Instruction list - mouth closed - aiming up-right ;;;
{
$B3:9379             dx 9547,       ; Enemy radius = Ch x Ch
                        0001,E37D,
                        812F        ; Sleep
}


;;; $9381: Instruction list - mouth closed - aiming up (facing right) ;;;
{
$B3:9381             dx 9557,       ; Enemy radius = 8 x 10h
                        0001,E389,
                        812F        ; Sleep
}


;;; $9389: Instruction list - hide ;;;
{
$B3:9389             dx 0001,804D,
                        812F        ; Sleep
}


;;; $938F: Unused. Instruction list - spit - aiming up (facing left) ;;;
{
$B3:938F             dx 0020,E31D,
                        94C7,       ; Enemy radius = 8 x 10h
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0010,E395,
                        812F        ; Sleep
}


;;; $939F: Instruction list - spit - aiming up-left ;;;
{
$B3:939F             dx 0020,E329,
                        94D7,       ; Enemy radius = Ch x Ch
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0010,E3A1,
                        812F        ; Sleep
}


;;; $93AF: Instruction list - spit - aiming left ;;;
{
$B3:93AF             dx 0020,E335,
                        94E7,       ; Enemy radius = 10h x 8
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0019,E3B2,
                        812F        ; Sleep
}


;;; $93BF: Instruction list - spit - aiming down-left ;;;
{
$B3:93BF             dx 0020,E341,
                        94F7,       ; Enemy radius = Ch x Ch
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0010,E3BE,
                        812F        ; Sleep
}


;;; $93CF: Unused. Instruction list - spit - aiming down (facing left) ;;;
{
$B3:93CF             dx 0020,E34D,
                        9507,       ; Enemy radius = 8 x 10h
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0010,E3CF,
                        812F        ; Sleep
}


;;; $93DF: Instruction list - spit - aiming down (facing right) ;;;
{
$B3:93DF             dx 0020,E359,
                        9517,       ; Enemy radius = 8 x 10h
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0010,E3DB,
                        812F        ; Sleep
}


;;; $93EF: Instruction list - spit - aiming down-right ;;;
{
$B3:93EF             dx 0020,E365,
                        9527,       ; Enemy radius = Ch x Ch
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0010,E3E7,
                        812F        ; Sleep
}


;;; $93FF: Instruction list - spit - aiming right ;;;
{
$B3:93FF             dx 0020,E371,
                        9537,       ; Enemy radius = 10h x 8
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0010,E3F8,
                        812F        ; Sleep
}


;;; $940F: Instruction list - spit - aiming up-right ;;;
{
$B3:940F             dx 0020,E37D,
                        9547,       ; Enemy radius = Ch x Ch
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0010,E404,
                        812F        ; Sleep
}


;;; $941F: Instruction list - spit - aiming up (facing right) ;;;
{
$B3:941F             dx 0020,E389,
                        9557,       ; Enemy radius = 8 x 10h
                        9572,       ; Queue Botwoon spit sound effect
                        9567,       ; Set Botwoon spitting flag
                        0010,E415,
                        812F        ; Sleep
}


;;; $942F: Unused. Instruction list - hidden - aiming up (facing left) ;;;
{
$B3:942F             dx 0001,E421,
                        812F        ; Sleep
}


;;; $9435: Instruction list - hidden - aiming up-left ;;;
{
$B3:9435             dx 0001,E42D,
                        812F        ; Sleep
}


;;; $943B: Instruction list - hidden - aiming left ;;;
{
$B3:943B             dx 0001,E439,
                        812F        ; Sleep
}


;;; $9441: Instruction list - hidden - aiming down-left ;;;
{
$B3:9441             dx 0001,E445,
                        812F        ; Sleep
}


;;; $9447: Unused. Instruction list - hidden - aiming down (facing left) ;;;
{
$B3:9447             dx 0001,E451,
                        812F        ; Sleep
}


;;; $944D: Instruction list - hidden - aiming down (facing right) ;;;
{
$B3:944D             dx 0001,E45D,
                        812F        ; Sleep
}


;;; $9453: Instruction list - hidden - aiming down-right ;;;
{
$B3:9453             dx 0001,E469,
                        812F        ; Sleep
}


;;; $9459: Instruction list - hidden - aiming right ;;;
{
$B3:9459             dx 0001,E475,
                        812F        ; Sleep
}


;;; $945F: Instruction list - hidden - aiming up-right ;;;
{
$B3:945F             dx 0001,E481,
                        812F        ; Sleep
}


;;; $9465: Instruction list - hidden - aiming up (facing right) ;;;
{
$B3:9465             dx 0001,E48D,
                        812F        ; Sleep
}
}


;;; $946B: Botwoon instruction list pointers ;;;
{
$B3:946B             dw 9381, ; Mouth closed - aiming up (facing right)
                        9379, ; Mouth closed - aiming up-right
                        9371, ; Mouth closed - aiming right
                        9369, ; Mouth closed - aiming down-right
                        9361, ; Mouth closed - aiming down (facing right)
                        9351, ; Mouth closed - aiming down-left
                        9349, ; Mouth closed - aiming left
                        9341, ; Mouth closed - aiming up-left
                        9389, ; Hidden
                        9389, ; Hidden
                        9389, ; Hidden
                        9389, ; Hidden
                        9389, ; Hidden
                        9389, ; Hidden
                        9389, ; Hidden
                        9389, ; Hidden
                        941F, ; Spit - aiming up (facing right)
                        940F, ; Spit - aiming up-right
                        93FF, ; Spit - aiming right
                        93EF, ; Spit - aiming down-right
                        93DF, ; Spit - aiming down (facing right)
                        93BF, ; Spit - aiming down-left
                        93AF, ; Spit - aiming left
                        939F  ; Spit - aiming up-left
}


;;; $949B: Botwoon hole hitboxes ;;;
{
;                        __________________ Left boundary
;                       |     _____________ Right boundary
;                       |    |     ________ Top boundary
;                       |    |    |     ___ Bottom boundary
;                       |    |    |    |
$B3:949B             dw 003C,0044,006C,0074, ; Left
                        007C,0084,00AC,00B4, ; Bottom
                        009C,00A4,005C,0064, ; Top
                        00DC,00E4,008C,0094  ; Right
}


;;; $94BB: Botwoon speed table ;;;
{
; Indexed by $7E:803E. Used for both Botwoon movement and spit projectile movement

;                        ________ Speed
;                       |     ___ Body travel time. Number of frames required to reach the current position of the next body part. 30h / speed
;                       |    |
$B3:94BB             dw 0002,0018, ; Health >= 50%
                        0003,0010, ; 25% <= health < 50%
                        0004,000C  ; Health < 25%
}


;;; $94C7..9579: Botwoon instructions ;;;
{
;;; $94C7: Instruction - enemy radius = 8 x 10h ;;;
{
$B3:94C7 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:94CA A9 08 00    LDA #$0008
$B3:94CD 9D 82 0F    STA $0F82,x
$B3:94D0 A9 10 00    LDA #$0010
$B3:94D3 9D 84 0F    STA $0F84,x
$B3:94D6 6B          RTL
}


;;; $94D7: Instruction - enemy radius = Ch x Ch ;;;
{
$B3:94D7 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:94DA A9 0C 00    LDA #$000C
$B3:94DD 9D 82 0F    STA $0F82,x[$7E:0F82]
$B3:94E0 A9 0C 00    LDA #$000C
$B3:94E3 9D 84 0F    STA $0F84,x[$7E:0F84]
$B3:94E6 6B          RTL
}


;;; $94E7: Instruction - enemy radius = 10h x 8 ;;;
{
$B3:94E7 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:94EA A9 10 00    LDA #$0010
$B3:94ED 9D 82 0F    STA $0F82,x[$7E:0F82]
$B3:94F0 A9 08 00    LDA #$0008
$B3:94F3 9D 84 0F    STA $0F84,x[$7E:0F84]
$B3:94F6 6B          RTL
}


;;; $94F7: Instruction - enemy radius = Ch x Ch ;;;
{
$B3:94F7 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:94FA A9 0C 00    LDA #$000C
$B3:94FD 9D 82 0F    STA $0F82,x[$7E:0F82]
$B3:9500 A9 0C 00    LDA #$000C
$B3:9503 9D 84 0F    STA $0F84,x[$7E:0F84]
$B3:9506 6B          RTL
}


;;; $9507: Instruction - enemy radius = 8 x 10h ;;;
{
$B3:9507 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:950A A9 08 00    LDA #$0008
$B3:950D 9D 82 0F    STA $0F82,x
$B3:9510 A9 10 00    LDA #$0010
$B3:9513 9D 84 0F    STA $0F84,x
$B3:9516 6B          RTL
}


;;; $9517: Instruction - enemy radius = 8 x 10h ;;;
{
$B3:9517 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:951A A9 08 00    LDA #$0008
$B3:951D 9D 82 0F    STA $0F82,x[$7E:0F82]
$B3:9520 A9 10 00    LDA #$0010
$B3:9523 9D 84 0F    STA $0F84,x[$7E:0F84]
$B3:9526 6B          RTL
}


;;; $9527: Instruction - enemy radius = Ch x Ch ;;;
{
$B3:9527 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:952A A9 0C 00    LDA #$000C
$B3:952D 9D 82 0F    STA $0F82,x[$7E:0F82]
$B3:9530 A9 0C 00    LDA #$000C
$B3:9533 9D 84 0F    STA $0F84,x[$7E:0F84]
$B3:9536 6B          RTL
}


;;; $9537: Instruction - enemy radius = 10h x 8 ;;;
{
$B3:9537 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:953A A9 10 00    LDA #$0010
$B3:953D 9D 82 0F    STA $0F82,x[$7E:0F82]
$B3:9540 A9 08 00    LDA #$0008
$B3:9543 9D 84 0F    STA $0F84,x[$7E:0F84]
$B3:9546 6B          RTL
}


;;; $9547: Instruction - enemy radius = Ch x Ch ;;;
{
$B3:9547 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:954A A9 0C 00    LDA #$000C
$B3:954D 9D 82 0F    STA $0F82,x[$7E:0F82]
$B3:9550 A9 0C 00    LDA #$000C
$B3:9553 9D 84 0F    STA $0F84,x[$7E:0F84]
$B3:9556 6B          RTL
}


;;; $9557: Instruction - enemy radius = 8 x 10h ;;;
{
$B3:9557 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:955A A9 08 00    LDA #$0008
$B3:955D 9D 82 0F    STA $0F82,x[$7E:0F82]
$B3:9560 A9 10 00    LDA #$0010
$B3:9563 9D 84 0F    STA $0F84,x[$7E:0F84]
$B3:9566 6B          RTL
}


;;; $9567: Instruction - set Botwoon spitting flag ;;;
{
$B3:9567 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:956A A9 01 00    LDA #$0001
$B3:956D 9F 34 88 7E STA $7E8834,x[$7E:8834]
$B3:9571 6B          RTL
}


;;; $9572: Instruction - queue Botwoon spit sound effect ;;;
{
$B3:9572 A9 7C 00    LDA #$007C             ;\
$B3:9575 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 7Ch, sound library 2, max queued sounds allowed = 6 (Botwoon spit)
$B3:9579 6B          RTL
}
}


;;; $957A: RTL ;;;
{
$B3:957A 6B          RTL
}


;;; $957B: Queue small explosion sound effect ;;;
{
$B3:957B A9 24 00    LDA #$0024             ;\
$B3:957E 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
$B3:9582 6B          RTL
}


;;; $9583: Initialisation AI - enemy $F293 (Botwoon) ;;;
{
$B3:9583 AF 2C D8 7E LDA $7ED82C[$7E:D82C]  ;\
$B3:9587 29 02 00    AND #$0002             ;} If Botwoon is dead:
$B3:958A F0 24       BEQ $24    [$95B0]     ;/
$B3:958C AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:958F 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$B3:9593             dx 0F,04,B797          ;} Spawn PLM to clear Botwoon's wall
$B3:9597 A9 01 01    LDA #$0101             ;\
$B3:959A 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;} Scroll 0..1 = blue
$B3:959E A9 89 93    LDA #$9389             ;\
$B3:95A1 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $9389 (hide)
$B3:95A4 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:95A7 09 00 02    ORA #$0200             ;} Mark enemy for deletion
$B3:95AA 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$B3:95AD 4C 67 96    JMP $9667  [$B3:9667]  ; Return

$B3:95B0 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$B3:95B3 A9 18 00    LDA #$0018             ;} Enemy body projectile index = 18h
$B3:95B6 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;/

; LOOP
$B3:95B9 A0 A0 EB    LDY #$EBA0             ;\
$B3:95BC 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Botwoon's body enemy projectile
$B3:95C0 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$B3:95C3 DE A8 0F    DEC $0FA8,x[$7E:0FA8]  ;} Decrement enemy body projectile index
$B3:95C6 DE A8 0F    DEC $0FA8,x[$7E:0FA8]  ;/
$B3:95C9 10 EE       BPL $EE    [$95B9]     ; If [enemy body projectile index] >= 0: go to LOOP
$B3:95CB A9 89 93    LDA #$9389             ;\
$B3:95CE 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $9389 (hide)
$B3:95D1 9F 36 80 7E STA $7E8036,x[$7E:8036]; Enemy instruction list = $9389 (hide)
$B3:95D5 A9 78 98    LDA #$9878             ;\
$B3:95D8 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $9878 (initial)
$B3:95DB A9 B7 9B    LDA #$9BB7             ;\
$B3:95DE 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy movement function = $9BB7 (move directly toward target hole)
$B3:95E1 A9 C0 9D    LDA #$9DC0             ;\
$B3:95E4 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy head function = $9DC0 (moving around)
$B3:95E7 A9 00 01    LDA #$0100             ;\
$B3:95EA 9F 00 80 7E STA $7E8000,x[$7E:8000];} Enemy initialisation timer = 100h
$B3:95EE AD BB 94    LDA $94BB  [$B3:94BB]  ;\
$B3:95F1 9F 30 80 7E STA $7E8030,x[$7E:8030];} Enemy speed = 2
$B3:95F5 AD BD 94    LDA $94BD  [$B3:94BD]  ;\
$B3:95F8 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy body travel time = 18h
$B3:95FB A9 01 00    LDA #$0001             ;\
$B3:95FE 9F 26 80 7E STA $7E8026,x[$7E:8026];} Enemy previous head hidden flag = enemy head hidden flag = 1
$B3:9602 9F 28 80 7E STA $7E8028,x[$7E:8028];
$B3:9606 9F 32 88 7E STA $7E8832,x[$7E:8832]; Enemy initial leave hole action flag = 1
$B3:960A A9 FF FF    LDA #$FFFF             ;\
$B3:960D 9F 2C 80 7E STA $7E802C,x[$7E:802C];} Enemy target position history index = FFFFh
$B3:9611 A9 00 00    LDA #$0000             ;\
$B3:9614 9F 2E 80 7E STA $7E802E,x[$7E:802E];} Enemy target hole index = 0
$B3:9618 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:961B 09 00 04    ORA #$0400             ;} Set enemy as intangible
$B3:961E 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$B3:9621 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ;\
$B3:9624 9F 36 88 7E STA $7E8836,x[$7E:8836];} Enemy max health = [enemy health] (unused)
$B3:9628 4A          LSR A                  ;\
$B3:9629 9F 38 88 7E STA $7E8838,x[$7E:8838];} Enemy max health * 1/2 = [enemy health] / 2
$B3:962D 4A          LSR A                  ;\
$B3:962E 9F 3A 88 7E STA $7E883A,x[$7E:883A];} Enemy max health * 1/4 = [enemy health] / 4
$B3:9632 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B3:9635 9F 20 88 7E STA $7E8820,x[$7E:8820];} Enemy X position 1 frame ago = [enemy X position]
$B3:9639 9F 24 88 7E STA $7E8824,x[$7E:8824]; Enemy X position 2 frames ago = [enemy X position]
$B3:963D 9F 28 88 7E STA $7E8828,x[$7E:8828]; Enemy X position 3 frames ago = [enemy X position]
$B3:9641 9F 2C 88 7E STA $7E882C,x[$7E:882C]; Enemy X position 4 frames ago = [enemy X position]
$B3:9645 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:9648 9F 22 88 7E STA $7E8822,x[$7E:8822];} Enemy Y position 1 frame ago = [enemy Y position]
$B3:964C 9F 26 88 7E STA $7E8826,x[$7E:8826]; Enemy Y position 2 frames ago = [enemy Y position]
$B3:9650 9F 2A 88 7E STA $7E882A,x[$7E:882A]; Enemy Y position 3 frames ago = [enemy Y position]
$B3:9654 9F 2E 88 7E STA $7E882E,x[$7E:882E]; Enemy Y position 4 frames ago = [enemy Y position]
$B3:9658 BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$B3:965B 4A          LSR A                  ;|
$B3:965C 4A          LSR A                  ;|
$B3:965D 4A          LSR A                  ;|
$B3:965E 4A          LSR A                  ;} Enemy palette data offset = [enemy palette index] / 10h + 100h (palette data offset)
$B3:965F 18          CLC                    ;|
$B3:9660 69 00 01    ADC #$0100             ;|
$B3:9663 9F 1C 88 7E STA $7E881C,x[$7E:881C];/

$B3:9667 6B          RTL
}


;;; $9668: Main AI - enemy $F293 (Botwoon) ;;;
{
$B3:9668 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:966B 20 C6 96    JSR $96C6  [$B3:96C6]  ; Botwoon death check
$B3:966E FC AE 0F    JSR ($0FAE,x)[$B3:9878]; Execute [enemy function]
$B3:9671 20 2B 98    JSR $982B  [$B3:982B]  ; Botwoon health-based palette handling
$B3:9674 6B          RTL
}


;;; $9675:  ;;;
{
$B3:9675             dw FFFF, 00FF, 01FF
}


;;; $967B: Unused ;;;
{
$B3:967B BF 3E 80 7E LDA $7E803E,x          ;\
$B3:967F 0A          ASL A                  ;|
$B3:9680 A8          TAY                    ;} $12 = [$9675 + [enemy speed table index] * 2]
$B3:9681 B9 75 96    LDA $9675,y            ;|
$B3:9684 85 12       STA $12    [$7E:0012]  ;/
$B3:9686 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B3:968A 25 12       AND $12    [$7E:0012]  ;\
$B3:968C D0 07       BNE $07    [$9695]     ;} If [random number] & [$12] = 0:
$B3:968E A9 01 00    LDA #$0001             ;\
$B3:9691 9F 1C 80 7E STA $7E801C,x          ;} Enemy $7E:801C = 1

$B3:9695 60          RTS
}


;;; $9696: Unused ;;;
{
$B3:9696 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9699 BF 1E 80 7E LDA $7E801E,x
$B3:969D D0 1F       BNE $1F    [$96BE]
$B3:969F BF 1C 80 7E LDA $7E801C,x
$B3:96A3 F0 19       BEQ $19    [$96BE]
$B3:96A5 BF 26 80 7E LDA $7E8026,x
$B3:96A9 D0 13       BNE $13    [$96BE]
$B3:96AB BF 02 80 7E LDA $7E8002,x
$B3:96AF D0 0D       BNE $0D    [$96BE]
$B3:96B1 A9 7D 9E    LDA #$9E7D
$B3:96B4 9D B2 0F    STA $0FB2,x
$B3:96B7 A9 18 00    LDA #$0018
$B3:96BA 9F 02 80 7E STA $7E8002,x

$B3:96BE A9 00 00    LDA #$0000
$B3:96C1 9F 1C 80 7E STA $7E801C,x
$B3:96C5 60          RTS
}


;;; $96C6: Botwoon death check ;;;
{
$B3:96C6 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:96C9 BF 1E 80 7E LDA $7E801E,x[$7E:801E];\
$B3:96CD F0 25       BEQ $25    [$96F4]     ;} If [enemy death flag] = 0: return
$B3:96CF BF 3C 80 7E LDA $7E803C,x[$7E:803C];\
$B3:96D3 F0 1F       BEQ $1F    [$96F4]     ;} If [enemy tail showing flag] = 0: return
$B3:96D5 A9 01 00    LDA #$0001             ;\
$B3:96D8 9F 20 80 7E STA $7E8020,x[$7E:8020];} Enemy body death flag = 1
$B3:96DC A9 46 9A    LDA #$9A46             ;\
$B3:96DF 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $9A46 (death sequence)
$B3:96E2 A9 F0 00    LDA #$00F0             ;\
$B3:96E5 9F 04 80 7E STA $7E8004,x[$7E:8004];} Enemy pre-death counter = F0h
$B3:96E9 A9 00 00    LDA #$0000             ;\
$B3:96EC 9F 1E 80 7E STA $7E801E,x[$7E:801E];} Enemy death flag = 0
$B3:96F0 9F 3C 80 7E STA $7E803C,x[$7E:803C]; Enemy tail showing flag = 0

$B3:96F4 60          RTS
}


;;; $96F5: Set Botwoon as intangible ;;;
{
$B3:96F5 AD 86 0F    LDA $0F86  [$7E:0F86]
$B3:96F8 09 00 04    ORA #$0400
$B3:96FB 8D 86 0F    STA $0F86  [$7E:0F86]
$B3:96FE 60          RTS
}


;;; $96FF: Unused. Set Botwoon body enemy projectiles as intangible ;;;
{
$B3:96FF A0 22 00    LDY #$0022             ; Y = 22h (enemy projectile index)

; LOOP
$B3:9702 BB          TYX
$B3:9703 B9 D7 1B    LDA $1BD7,y            ;\
$B3:9706 09 00 20    ORA #$2000             ;} Disable enemy projectile collisions with Samus
$B3:9709 99 D7 1B    STA $1BD7,y            ;/
$B3:970C A9 02 00    LDA #$0002             ;\
$B3:970F 9F 80 F3 7E STA $7EF380,x          ;} Disable enemy projectile interaction with projectiles
$B3:9713 88          DEY                    ;\
$B3:9714 88          DEY                    ;} Y -= 2 (next enemy projectile)
$B3:9715 C0 0A 00    CPY #$000A             ;\
$B3:9718 10 E8       BPL $E8    [$9702]     ;} If [Y] >= Ah: go to LOOP
$B3:971A 60          RTS
}


;;; $971B: Botwoon health-based palettes ;;;
{
$B3:971B             dw 0000, 27E9, 1A66, 1585, 0CA3, 3F9C, 2E97, 1D72, 108E, 0A5F, 09DB, 0956, 08D2, 082C, 7FBD, 0C05,
                        2003, 27EB, 1A88, 15A7, 0CC4, 3B5C, 2E58, 1D53, 106F, 0E3F, 0DBB, 0D36, 0CD2, 0C2C, 77BD, 0C06,
                        2003, 23ED, 168A, 11C8, 08E5, 3AFD, 2A38, 1D34, 1071, 0DFF, 0D9B, 0D36, 0CB3, 0C2D, 6FDE, 0807,
                        0000, 23EF, 16AC, 11EA, 0906, 36BD, 29F9, 1D15, 1052, 11DF, 117B, 1116, 10B3, 102D, 67DE, 0808,
                        0000, 23F2, 12CF, 11EC, 0908, 327D, 25B9, 18D6, 1453, 11BF, 115C, 10F7, 1093, 102E, 5FDE, 0408,
                        0000, 23F4, 12F1, 120E, 0929, 2E3D, 257A, 18B7, 1434, 159F, 153C, 14D7, 1493, 142E, 57DE, 0409,
                        0000, 1FF6, 0EF3, 0E2F, 054A, 2DDE, 215A, 1898, 1436, 155F, 151C, 14D7, 1474, 142F, 4FFF, 000A,
                        0000, 1FF8, 0F15, 0E51, 056B, 299E, 211B, 1879, 1417, 193F, 18FC, 18B7, 1874, 182F, 47FF, 000B
}


;;; $981B: Botwoon health thresholds for palette change ;;;
{
; 3000, 2625, 2250, 1875, 1500, 1125, 750, 375
$B3:981B             dw 0BB8, 0A41, 08CA, 0753, 05DC, 0465, 02EE, 0177
}


;;; $982B: Botwoon health-based palette handling ;;;
{
$B3:982B AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:982E BF 1E 88 7E LDA $7E881E,x[$7E:881E];\
$B3:9832 C9 10 00    CMP #$0010             ;} If [enemy health-based palette index] = 10h: return
$B3:9835 F0 40       BEQ $40    [$9877]     ;/
$B3:9837 A8          TAY                    ;\
$B3:9838 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ;|
$B3:983B D9 1B 98    CMP $981B,y[$B3:981B]  ;} If [enemy health] >= [$981B + [enemy health-based palette index]]: return
$B3:983E 10 37       BPL $37    [$9877]     ;/
$B3:9840 BF 1E 88 7E LDA $7E881E,x[$7E:881E];\
$B3:9844 0A          ASL A                  ;|
$B3:9845 0A          ASL A                  ;|
$B3:9846 0A          ASL A                  ;} $12 = [enemy health-based palette index] * 10h
$B3:9847 0A          ASL A                  ;|
$B3:9848 85 12       STA $12    [$7E:0012]  ;/
$B3:984A BF 1C 88 7E LDA $7E881C,x[$7E:881C];\
$B3:984E 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy palette data offset] (should be 1E0h)

; LOOP
$B3:9850 A4 12       LDY $12    [$7E:0012]  ;\
$B3:9852 A6 14       LDX $14    [$7E:0014]  ;|
$B3:9854 B9 1B 97    LDA $971B,y[$B3:971B]  ;} $7E:C000 + [$14] = [$971B + [$12]]
$B3:9857 9F 00 C0 7E STA $7EC000,x[$7E:C1E0];/
$B3:985B E6 12       INC $12    [$7E:0012]  ;\
$B3:985D E6 12       INC $12    [$7E:0012]  ;} $12 += 2
$B3:985F E6 14       INC $14    [$7E:0014]  ;\
$B3:9861 E6 14       INC $14    [$7E:0014]  ;} $14 += 2
$B3:9863 A5 14       LDA $14    [$7E:0014]  ;\
$B3:9865 C9 00 02    CMP #$0200             ;} If [$14] != 200h: go to LOOP
$B3:9868 D0 E6       BNE $E6    [$9850]     ;/
$B3:986A AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$B3:986D BF 1E 88 7E LDA $7E881E,x[$7E:881E];|
$B3:9871 1A          INC A                  ;} Enemy health-based palette index += 2
$B3:9872 1A          INC A                  ;|
$B3:9873 9F 1E 88 7E STA $7E881E,x[$7E:881E];/

$B3:9877 60          RTS
}


;;; $9878: Botwoon function - initial ;;;
{
$B3:9878 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$B3:987B BF 00 80 7E LDA $7E8000,x[$7E:8000];|
$B3:987F 3A          DEC A                  ;} Decrement enemy initialisation timer
$B3:9880 9F 00 80 7E STA $7E8000,x[$7E:8000];/
$B3:9884 D0 06       BNE $06    [$988C]     ; If [enemy initialisation timer] = 0:
$B3:9886 A9 9D 98    LDA #$989D             ;\
$B3:9889 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $989D (go through hole)

$B3:988C 60          RTS
}


;;; $988D: Botwoon leave hole action jump table ;;;
{
$B3:988D             dw 98EC, 98EC, 98EC, 9913, 9913, 9913, 9913, 9913
}


;;; $989D: Botwoon function - go through hole ;;;
{
$B3:989D AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$B3:98A0 BF 38 80 7E LDA $7E8038,x[$7E:8038];} If [enemy going through hole flag] = 0: go to BRANCH_MOVE_AROUND
$B3:98A4 F0 30       BEQ $30    [$98D6]     ;/
$B3:98A6 A9 00 00    LDA #$0000             ;\
$B3:98A9 9F 38 80 7E STA $7E8038,x[$7E:8038];} Enemy going through hole flag = 0
$B3:98AD 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$B3:98AF BF 26 80 7E LDA $7E8026,x[$7E:8026];\
$B3:98B3 D0 15       BNE $15    [$98CA]     ;} If [enemy head hidden flag] = 0:
$B3:98B5 BF 32 88 7E LDA $7E8832,x[$7E:8832];\
$B3:98B9 D0 0F       BNE $0F    [$98CA]     ;} If [enemy initial leave hole action flag] = 0:
$B3:98BB BF 3E 80 7E LDA $7E803E,x[$7E:803E];\
$B3:98BF D0 09       BNE $09    [$98CA]     ;} If [enemy speed table index] = 0:
$B3:98C1 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B3:98C5 29 0E 00    AND #$000E             ;\
$B3:98C8 85 12       STA $12    [$7E:0012]  ;} $12 = [random number] & Eh

$B3:98CA A9 00 00    LDA #$0000             ;\
$B3:98CD 9F 32 88 7E STA $7E8832,x[$7E:8832];} Enemy initial leave hole action flag = 0
$B3:98D1 A6 12       LDX $12    [$7E:0012]  ;\
$B3:98D3 7C 8D 98    JMP ($988D,x)[$B3:98EC];} Go to [$988D + [$12]]

; BRANCH_MOVE_AROUND
$B3:98D6 FC B0 0F    JSR ($0FB0,x)[$B3:9BB7]; Execute [enemy movement function]
$B3:98D9 20 7B 9C    JSR $9C7B  [$B3:9C7B]  ; Update Botwoon position history
$B3:98DC 20 90 9C    JSR $9C90  [$B3:9C90]  ; Update Botwoon body projectile positions
$B3:98DF FC B2 0F    JSR ($0FB2,x)[$B3:9DC0]; Execute [enemy head function]
$B3:98E2 20 4D 9D    JSR $9D4D  [$B3:9D4D]  ; Set Botwoon body instruction list table indices
$B3:98E5 20 3C 9D    JSR $9D3C  [$B3:9D3C]  ; Update Botwoon position history index
$B3:98E8 20 93 9F    JSR $9F93  [$B3:9F93]  ; Botwoon / hole collision detection
$B3:98EB 60          RTS
}


;;; $98EC: Set up Botwoon moving around ;;;
{
$B3:98EC AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:98EF A9 A4 99    LDA #$99A4             ;\
$B3:98F2 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $99A4 (moving around)
$B3:98F5 A9 50 E2    LDA #$E250             ;\
$B3:98F8 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy movement function = $E250 (start moving Botwoon according to movement data)
$B3:98FB A9 00 00    LDA #$0000             ;\
$B3:98FE 9F 02 80 7E STA $7E8002,x[$7E:8002];} Enemy spit timer = 0
$B3:9902 A9 C0 9D    LDA #$9DC0             ;\
$B3:9905 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy head function = $9DC0 (moving around)
$B3:9908 A9 00 00    LDA #$0000             ;\
$B3:990B 9F 16 88 7E STA $7E8816,x[$7E:8816];} Enemy $7E:8816 = 0 (unused)
$B3:990F 20 33 99    JSR $9933  [$B3:9933]  ; Choose Botwoon movement path
$B3:9912 60          RTS
}


;;; $9913: Set up Botwoon spitting ;;;
{
$B3:9913 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9916 A9 E4 99    LDA #$99E4             ;\
$B3:9919 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $99E4 (spitting)
$B3:991C A9 7D 9E    LDA #$9E7D             ;\
$B3:991F 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy head function = $9E7D (spitting)
$B3:9922 A9 30 00    LDA #$0030             ;\
$B3:9925 9F 02 80 7E STA $7E8002,x[$7E:8002];} Enemy spit timer = 30h
$B3:9929 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:992C 29 FF FB    AND #$FBFF             ;} Set enemy as tangible
$B3:992F 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$B3:9932 60          RTS
}


;;; $9933: Choose Botwoon movement path ;;;
{
$B3:9933 20 5D 99    JSR $995D  [$B3:995D]  ; Set Botwoon speed
$B3:9936 64 12       STZ $12    [$7E:0012]  ; $12 = 0 (visible)
$B3:9938 BF 26 80 7E LDA $7E8026,x[$7E:8026];\
$B3:993C F0 05       BEQ $05    [$9943]     ;} If [enemy head hidden flag] != 0:
$B3:993E A9 80 00    LDA #$0080             ;\
$B3:9941 85 12       STA $12    [$7E:0012]  ;} $12 = 80h (hidden)

$B3:9943 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B3:9947 29 18 00    AND #$0018             ;\
$B3:994A 85 14       STA $14    [$7E:0014]  ;} $14 = [random number] & 18h (path destination)
$B3:994C BF 2E 80 7E LDA $7E802E,x[$7E:802E];\
$B3:9950 0A          ASL A                  ;|
$B3:9951 0A          ASL A                  ;|
$B3:9952 18          CLC                    ;|
$B3:9953 65 12       ADC $12    [$7E:0012]  ;} Enemy $7E:8800 = [$12] + [enemy target hole index] * 4 + [$14]
$B3:9955 18          CLC                    ;|
$B3:9956 65 14       ADC $14    [$7E:0014]  ;|
$B3:9958 9F 00 88 7E STA $7E8800,x[$7E:8800];/
$B3:995C 60          RTS
}


;;; $995D: Set Botwoon speed ;;;
{
$B3:995D BF 26 80 7E LDA $7E8026,x[$7E:8026];\
$B3:9961 D0 40       BNE $40    [$99A3]     ;} If [enemy head hidden flag] != 0: return
$B3:9963 A9 00 00    LDA #$0000             ;\
$B3:9966 9F 3E 80 7E STA $7E803E,x[$7E:803E];} Enemy speed table index = 0
$B3:996A BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ;\
$B3:996D F0 34       BEQ $34    [$99A3]     ;} If [enemy health] <= 0: return
$B3:996F 30 32       BMI $32    [$99A3]     ;/
$B3:9971 DF 38 88 7E CMP $7E8838,x[$7E:8838];\
$B3:9975 10 2C       BPL $2C    [$99A3]     ;} If [enemy health] >= [max health * 1/2]: return
$B3:9977 DF 3A 88 7E CMP $7E883A,x[$7E:883A];\
$B3:997B 10 02       BPL $02    [$997F]     ;} If [enemy health] >= [max health * 1/4]: go to BRANCH_HALF_HEALTH
$B3:997D 80 09       BRA $09    [$9988]     ; Go to BRANCH_QUARTER_HEALTH

; BRANCH_HALF_HEALTH
$B3:997F A9 01 00    LDA #$0001             ;\
$B3:9982 9F 3E 80 7E STA $7E803E,x          ;} Enemy speed table index = 1
$B3:9986 80 07       BRA $07    [$998F]     ; Go to BRANCH_MERGE

; BRANCH_QUARTER_HEALTH
$B3:9988 A9 02 00    LDA #$0002             ;\
$B3:998B 9F 3E 80 7E STA $7E803E,x[$7E:803E];} Enemy speed table index = 2

; BRANCH_MERGE
$B3:998F BF 3E 80 7E LDA $7E803E,x[$7E:803E];\
$B3:9993 0A          ASL A                  ;|
$B3:9994 0A          ASL A                  ;} Y = [enemy speed table index] * 4
$B3:9995 A8          TAY                    ;/
$B3:9996 B9 BB 94    LDA $94BB,y[$B3:94C3]  ;\
$B3:9999 9F 30 80 7E STA $7E8030,x[$7E:8030];} Enemy speed = [$94BB + [Y]]
$B3:999D B9 BD 94    LDA $94BD,y[$B3:94C5]  ;\
$B3:99A0 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy body travel time = [$94BB + [Y] + 2]

$B3:99A3 60          RTS
}


;;; $99A4: Botwoon function - moving around ;;;
{
$B3:99A4 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:99A7 BF 38 80 7E LDA $7E8038,x[$7E:8038];\
$B3:99AB F0 0A       BEQ $0A    [$99B7]     ;} If [enemy going through hole flag] != 0:
$B3:99AD A9 00 00    LDA #$0000             ;\
$B3:99B0 9F 38 80 7E STA $7E8038,x[$7E:8038];} Enemy going through hole flag = 0
$B3:99B4 4C CA 99    JMP $99CA  [$B3:99CA]

                                            ; Else ([enemy going through hole flag] = 0):
$B3:99B7 FC B0 0F    JSR ($0FB0,x)[$B3:E250]; Execute [enemy movement function]
$B3:99BA 20 7B 9C    JSR $9C7B  [$B3:9C7B]  ; Update Botwoon position history
$B3:99BD 20 90 9C    JSR $9C90  [$B3:9C90]  ; Update Botwoon body projectile positions
$B3:99C0 FC B2 0F    JSR ($0FB2,x)[$B3:9DC0]; Execute [enemy head function]
$B3:99C3 20 4D 9D    JSR $9D4D  [$B3:9D4D]  ; Set Botwoon body instruction list table indices
$B3:99C6 20 3C 9D    JSR $9D3C  [$B3:9D3C]  ; Update Botwoon position history index
$B3:99C9 60          RTS                    ; Return

$B3:99CA A9 9D 98    LDA #$989D             ;\
$B3:99CD 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $989D (go through hole)
$B3:99D0 A9 B7 9B    LDA #$9BB7             ;\
$B3:99D3 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy movement function = $9BB7 (move directly toward target hole)
$B3:99D6 BF 26 80 7E LDA $7E8026,x[$7E:8026];\
$B3:99DA F0 07       BEQ $07    [$99E3]     ;} If [enemy head hidden flag] != 0:
$B3:99DC A9 00 00    LDA #$0000             ;\
$B3:99DF 9F 2A 80 7E STA $7E802A,x[$7E:802A];} Enemy hole collision disabled flag = 0

$B3:99E3 60          RTS
}


;;; $99E4: Botwoon function - spitting ;;;
{
$B3:99E4 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:99E7 BF 02 80 7E LDA $7E8002,x[$7E:8002];\
$B3:99EB D0 0A       BNE $0A    [$99F7]     ;} If [enemy spit timer] = 0:
$B3:99ED A9 00 00    LDA #$0000             ;\
$B3:99F0 9F 38 80 7E STA $7E8038,x[$7E:8038];} Enemy going through hole flag = 0
$B3:99F4 4C 02 9A    JMP $9A02  [$B3:9A02]

$B3:99F7 A9 00 00    LDA #$0000             ;\ Else ([enemy spit timer] != 0):
$B3:99FA 9F 1C 80 7E STA $7E801C,x[$7E:801C];} Enemy $7E:801C = 0
$B3:99FE FC B2 0F    JSR ($0FB2,x)[$B3:9E7D]; Execute [enemy head function]
$B3:9A01 60          RTS                    ; Return

$B3:9A02 A9 A4 99    LDA #$99A4             ;\
$B3:9A05 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $99A4 (moving around)
$B3:9A08 A9 50 E2    LDA #$E250             ;\
$B3:9A0B 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy movement function = $E250 (start moving Botwoon according to movement data)
$B3:9A0E A9 C0 9D    LDA #$9DC0             ;\
$B3:9A11 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy head function = $9DC0 (moving around)
$B3:9A14 BF 1E 80 7E LDA $7E801E,x[$7E:801E];\
$B3:9A18 D0 21       BNE $21    [$9A3B]     ;} If [enemy death flag] = 0:
$B3:9A1A 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B3:9A1E 29 01 00    AND #$0001             ;\
$B3:9A21 9F 26 80 7E STA $7E8026,x[$7E:8026];} Enemy previous head hidden flag = enemy head hidden flag = [random number] % 2
$B3:9A25 9F 28 80 7E STA $7E8028,x[$7E:8028];/
$B3:9A29 F0 10       BEQ $10    [$9A3B]     ; If [enemy head hidden flag] != 0:
$B3:9A2B A9 00 00    LDA #$0000             ;\
$B3:9A2E 9F 2A 80 7E STA $7E802A,x[$7E:802A];} Enemy hole collision disabled flag = 0
$B3:9A32 A9 FF FF    LDA #$FFFF             ;\
$B3:9A35 9F 2C 80 7E STA $7E802C,x[$7E:802C];} Enemy target position history index = FFFFh
$B3:9A39 80 07       BRA $07    [$9A42]     ; Go to BRANCH_MERGE

$B3:9A3B A9 00 00    LDA #$0000             ;\
$B3:9A3E 9F 16 88 7E STA $7E8816,x[$7E:8816];} Enemy $7E:8816 = 0 (unused)

; BRANCH_MERGE
$B3:9A42 20 33 99    JSR $9933  [$B3:9933]  ; Choose Botwoon movement path
$B3:9A45 60          RTS
}


;;; $9A46: Botwoon function - death sequence - pre-death delay ;;;
{
$B3:9A46 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9A49 BF 04 80 7E LDA $7E8004,x[$7E:8004];\
$B3:9A4D 1A          INC A                  ;} Increment enemy pre-death counter
$B3:9A4E 9F 04 80 7E STA $7E8004,x[$7E:8004];/
$B3:9A52 C9 00 01    CMP #$0100             ;\
$B3:9A55 30 06       BMI $06    [$9A5D]     ;} If [enemy pre-death counter] >= 100h:
$B3:9A57 A9 5E 9A    LDA #$9A5E             ;\
$B3:9A5A 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $9A5E

$B3:9A5D 60          RTS
}


;;; $9A5E: Botwoon function - death sequence - falling to ground ;;;
{
$B3:9A5E AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9A61 BF 10 80 7E LDA $7E8010,x[$7E:8010];\
$B3:9A65 29 00 FF    AND #$FF00             ;|
$B3:9A68 EB          XBA                    ;|
$B3:9A69 0A          ASL A                  ;} Y = [enemy falling Y speed table index] / 100h * 8
$B3:9A6A 0A          ASL A                  ;|
$B3:9A6B 0A          ASL A                  ;|
$B3:9A6C A8          TAY                    ;/
$B3:9A6D BD 80 0F    LDA $0F80,x[$7E:0F80]  ;\
$B3:9A70 18          CLC                    ;|
$B3:9A71 79 8F 83    ADC $838F,y[$B3:838F]  ;|
$B3:9A74 90 03       BCC $03    [$9A79]     ;} Enemy Y position += [$838F + [Y]] / 10000h
$B3:9A76 FE 7E 0F    INC $0F7E,x[$7E:0F7E]  ;|
                                            ;|
$B3:9A79 9D 80 0F    STA $0F80,x[$7E:0F80]  ;/
$B3:9A7C BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:9A7F 18          CLC                    ;|
$B3:9A80 79 91 83    ADC $8391,y[$B3:8391]  ;} Enemy Y position += [$838F + [Y] + 2]
$B3:9A83 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$B3:9A86 C9 C8 00    CMP #$00C8             ;\
$B3:9A89 30 32       BMI $32    [$9ABD]     ;} If [enemy Y position] >= C8h:
$B3:9A8B A9 C8 00    LDA #$00C8             ;\
$B3:9A8E 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy Y position = C8h
$B3:9A91 A9 CA 9A    LDA #$9ACA             ;\
$B3:9A94 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $9ACA
$B3:9A97 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B3:9A9A 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$B3:9A9C BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:9A9F 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$B3:9AA1 A9 1D 00    LDA #$001D             ; A = 1Dh (big explosion)
$B3:9AA4 A0 09 E5    LDY #$E509             ;\
$B3:9AA7 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$B3:9AAB 22 7B 95 B3 JSL $B3957B[$B3:957B]  ; Queue small explosion sound effect
$B3:9AAF BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:9AB2 09 00 04    ORA #$0400             ;|
$B3:9AB5 09 00 01    ORA #$0100             ;} Set enemy as invisible and intangible
$B3:9AB8 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$B3:9ABB 80 0C       BRA $0C    [$9AC9]

$B3:9ABD BF 10 80 7E LDA $7E8010,x[$7E:8010];\ Else ([enemy Y position] < C8h):
$B3:9AC1 18          CLC                    ;|
$B3:9AC2 69 C0 00    ADC #$00C0             ;} Enemy falling Y speed table index += C0h
$B3:9AC5 9F 10 80 7E STA $7E8010,x[$7E:8010];/

$B3:9AC9 60          RTS
}


;;; $9ACA: Botwoon function - death sequence - wait for body to fall to ground ;;;
{
$B3:9ACA AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9ACD BF 3E 88 7E LDA $7E883E,x[$7E:883E];\
$B3:9AD1 F0 09       BEQ $09    [$9ADC]     ;} If [enemy body death flag] != 0:
$B3:9AD3 A9 F9 9A    LDA #$9AF9             ;\
$B3:9AD6 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function = $9AF9
$B3:9AD9 20 DD 9A    JSR $9ADD  [$B3:9ADD]  ; Spawn Botwoon item drops and start crumbling wall

$B3:9ADC 60          RTS
}


;;; $9ADD: Spawn Botwoon item drops and start crumbling wall ;;;
{
$B3:9ADD 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$B3:9AE1             dx 0F, 04, B79B        ;} Spawn PLM to crumble Botwoon's wall
$B3:9AE5 22 3E BA A0 JSL $A0BA3E[$A0:BA3E]  ; Botwoon death item drop routine
$B3:9AE9 A9 00 00    LDA #$0000             ;\
$B3:9AEC 9F 06 80 7E STA $7E8006,x[$7E:8006];} Enemy death counter = 0
$B3:9AF0 9F 08 80 7E STA $7E8008,x[$7E:8008]; Enemy large wall explosion timer = 0
$B3:9AF4 9F 0A 80 7E STA $7E800A,x[$7E:800A]; Enemy wall smoke timer = 0
$B3:9AF8 60          RTS
}


;;; $9AF9: Botwoon function - death sequence - crumbling wall ;;;
{
$B3:9AF9 BF 06 80 7E LDA $7E8006,x[$7E:8006];\
$B3:9AFD C9 C0 00    CMP #$00C0             ;} If [enemy death counter] >= C0h: go to BRANCH_END
$B3:9B00 10 08       BPL $08    [$9B0A]     ;/
$B3:9B02 C9 40 00    CMP #$0040             ;\
$B3:9B05 10 1B       BPL $1B    [$9B22]     ;} If [enemy death counter] >= 40h: go to BRANCH_WALL
$B3:9B07 4C AD 9B    JMP $9BAD  [$B3:9BAD]  ; Go to BRANCH_RETURN

; BRANCH_END
$B3:9B0A BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:9B0D 09 00 02    ORA #$0200             ;} Mark enemy for deletion
$B3:9B10 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$B3:9B13 A9 02 00    LDA #$0002             ;\
$B3:9B16 22 A6 81 80 JSL $8081A6[$80:81A6]  ;} Set area mini-boss as dead
$B3:9B1A A9 03 00    LDA #$0003             ;\
$B3:9B1D 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue elevator music track
$B3:9B21 60          RTS                    ; Return

; BRANCH_WALL
$B3:9B22 BF 08 80 7E LDA $7E8008,x[$7E:8008];\
$B3:9B26 3A          DEC A                  ;} Decrement enemy large wall explosion timer
$B3:9B27 9F 08 80 7E STA $7E8008,x[$7E:8008];/
$B3:9B2B 10 38       BPL $38    [$9B65]     ; If [enemy large wall explosion timer] < 0:
$B3:9B2D A9 0C 00    LDA #$000C             ;\
$B3:9B30 9F 08 80 7E STA $7E8008,x[$7E:8008];} Enemy large wall explosion timer = Ch
$B3:9B34 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B3:9B38 29 1F 00    AND #$001F             ;\
$B3:9B3B 18          CLC                    ;|
$B3:9B3C 69 E8 00    ADC #$00E8             ;} $12 = E8h + [random number] % 20h (X position)
$B3:9B3F 85 12       STA $12    [$7E:0012]  ;/
$B3:9B41 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B3:9B45 29 1F 00    AND #$001F             ;\
$B3:9B48 38          SEC                    ;|
$B3:9B49 E9 08 00    SBC #$0008             ;|
$B3:9B4C 18          CLC                    ;} $14 = [enemy death counter] - 8 + [random number] % 20h (Y position)
$B3:9B4D 7F 06 80 7E ADC $7E8006,x[$7E:8006];|
$B3:9B51 85 14       STA $14    [$7E:0014]  ;/
$B3:9B53 A9 1D 00    LDA #$001D             ;\
$B3:9B56 85 16       STA $16    [$7E:0016]  ;} $16 = 1Dh (big explosion)
$B3:9B58 A9 00 0A    LDA #$0A00             ;\
$B3:9B5B 85 18       STA $18    [$7E:0018]  ;} $18 = A00h (palette 5)
$B3:9B5D 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ; Create sprite object
$B3:9B61 22 7B 95 B3 JSL $B3957B[$B3:957B]  ; Queue small explosion sound effect

$B3:9B65 BF 0A 80 7E LDA $7E800A,x[$7E:800A];\
$B3:9B69 3A          DEC A                  ;} Decrement enemy wall smoke timer
$B3:9B6A 9F 0A 80 7E STA $7E800A,x[$7E:800A];/
$B3:9B6E 10 3D       BPL $3D    [$9BAD]     ; If [enemy wall smoke timer] >= 0: go to BRANCH_RETURN
$B3:9B70 A9 04 00    LDA #$0004             ;\
$B3:9B73 9F 0A 80 7E STA $7E800A,x[$7E:800A];} Enemy wall smoke timer = 4
$B3:9B77 A9 02 00    LDA #$0002             ;\
$B3:9B7A 85 24       STA $24    [$7E:0024]  ;} $24 = 2 (loop counter)

; LOOP
$B3:9B7C 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B3:9B80 29 3F 00    AND #$003F             ;\
$B3:9B83 18          CLC                    ;|
$B3:9B84 69 E0 00    ADC #$00E0             ;} $12 = E0h + [random number] % 40h (X position)
$B3:9B87 85 12       STA $12    [$7E:0012]  ;/
$B3:9B89 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B3:9B8D 29 1F 00    AND #$001F             ;\
$B3:9B90 38          SEC                    ;|
$B3:9B91 E9 08 00    SBC #$0008             ;|
$B3:9B94 18          CLC                    ;} $14 = [enemy death counter] - 8 + [random number] % 20h (Y position)
$B3:9B95 7F 06 80 7E ADC $7E8006,x[$7E:8006];|
$B3:9B99 85 14       STA $14    [$7E:0014]  ;/
$B3:9B9B A9 09 00    LDA #$0009             ;\
$B3:9B9E 85 16       STA $16    [$7E:0016]  ;} $16 = 9 (small dust cloud)
$B3:9BA0 A9 00 0A    LDA #$0A00             ;\
$B3:9BA3 85 18       STA $18    [$7E:0018]  ;} $18 = A00h (palette 5)
$B3:9BA5 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ; Create sprite object
$B3:9BA9 C6 24       DEC $24    [$7E:0024]  ; Decrement $24
$B3:9BAB D0 CF       BNE $CF    [$9B7C]     ; If [$24] != 0: go to LOOP

; BRANCH_RETURN
$B3:9BAD BF 06 80 7E LDA $7E8006,x[$7E:8006];\
$B3:9BB1 1A          INC A                  ;} Increment enemy death counter
$B3:9BB2 9F 06 80 7E STA $7E8006,x[$7E:8006];/
$B3:9BB6 60          RTS
}


;;; $9BB7: Botwoon movement function - move directly toward target hole ;;;
{
$B3:9BB7 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9BBA 20 F8 9B    JSR $9BF8  [$B3:9BF8]  ;\
$B3:9BBD 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;} Enemy $7E:8032 = angle to target hole (never read)
$B3:9BC1 9F 32 80 7E STA $7E8032,x[$7E:8032];/
$B3:9BC5 38          SEC                    ;\
$B3:9BC6 E9 40 00    SBC #$0040             ;|
$B3:9BC9 49 FF FF    EOR #$FFFF             ;|
$B3:9BCC 1A          INC A                  ;|
$B3:9BCD 18          CLC                    ;} Enemy target hole angle = (40h - [A]) % 100h (angle using the common maths convention)
$B3:9BCE 69 00 01    ADC #$0100             ;|
$B3:9BD1 29 FF 00    AND #$00FF             ;|
$B3:9BD4 9F 34 80 7E STA $7E8034,x[$7E:8034];/
$B3:9BD8 BF 26 80 7E LDA $7E8026,x[$7E:8026];\
$B3:9BDC DF 28 80 7E CMP $7E8028,x[$7E:8028];} If [enemy previous head hidden flag] != [enemy head hidden flag]:
$B3:9BE0 F0 12       BEQ $12    [$9BF4]     ;/
$B3:9BE2 BF 26 80 7E LDA $7E8026,x[$7E:8026];\
$B3:9BE6 9F 28 80 7E STA $7E8028,x[$7E:8028];} Enemy previous head hidden flag = [enemy head hidden flag]
$B3:9BEA A9 01 00    LDA #$0001             ;\
$B3:9BED 9F 38 80 7E STA $7E8038,x[$7E:8038];} Enemy going through hole flag = 1
$B3:9BF1 4C F7 9B    JMP $9BF7  [$B3:9BF7]  ; Return

$B3:9BF4 20 48 9C    JSR $9C48  [$B3:9C48]  ; Move Botwoon according to speed and angle to target hole

$B3:9BF7 60          RTS
}


;;; $9BF8: Calculate X/Y offsets to target hole ;;;
{
;; Returns:
;;     $12: X offset
;;     $14: Y offset
$B3:9BF8 BF 2E 80 7E LDA $7E802E,x[$7E:802E];\
$B3:9BFC A8          TAY                    ;} Y = [enemy target hole index]
$B3:9BFD B9 9B 94    LDA $949B,y[$B3:949B]  ;\
$B3:9C00 18          CLC                    ;|
$B3:9C01 69 04 00    ADC #$0004             ;|
$B3:9C04 38          SEC                    ;} $12 = [$949B + [Y]] + 4 - [enemy X position]
$B3:9C05 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$B3:9C08 85 12       STA $12    [$7E:0012]  ;/
$B3:9C0A C9 00 01    CMP #$0100             ;\
$B3:9C0D 10 07       BPL $07    [$9C16]     ;} If [$12] >= 100h: go to BRANCH_X_CLAMP_HIGH
$B3:9C0F C9 00 FF    CMP #$FF00             ;\
$B3:9C12 30 09       BMI $09    [$9C1D]     ;} If [$12] < -100h: go to BRANCH_X_CLAMP_LOW
$B3:9C14 80 0C       BRA $0C    [$9C22]     ; Go to BRANCH_X_MERGE

; BRANCH_X_CLAMP_HIGH
$B3:9C16 A9 FF 00    LDA #$00FF             ;\
$B3:9C19 85 12       STA $12    [$7E:0012]  ;} $12 = FFh
$B3:9C1B 80 05       BRA $05    [$9C22]     ; Go to BRANCH_X_MERGE

; BRANCH_X_CLAMP_LOW
$B3:9C1D A9 01 FF    LDA #$FF01             ;\
$B3:9C20 85 12       STA $12    [$7E:0012]  ;} $12 = -FFh

; BRANCH_X_MERGE
$B3:9C22 B9 9F 94    LDA $949F,y[$B3:949F]  ;\
$B3:9C25 18          CLC                    ;|
$B3:9C26 69 04 00    ADC #$0004             ;|
$B3:9C29 38          SEC                    ;} $14 = [$949B + [Y] + 4] + 4 - [enemy Y position]
$B3:9C2A FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;|
$B3:9C2D 85 14       STA $14    [$7E:0014]  ;/
$B3:9C2F C9 00 01    CMP #$0100             ;\
$B3:9C32 10 07       BPL $07    [$9C3B]     ;} If [$14] >= 100h: go to BRANCH_Y_CLAMP_HIGH
$B3:9C34 C9 00 FF    CMP #$FF00             ;\
$B3:9C37 30 09       BMI $09    [$9C42]     ;} If [$14] < -100h: go to BRANCH_Y_CLAMP_LOW
$B3:9C39 80 0C       BRA $0C    [$9C47]     ; Return

; BRANCH_Y_CLAMP_HIGH
$B3:9C3B A9 FF 00    LDA #$00FF             ;\
$B3:9C3E 85 14       STA $14    [$7E:0014]  ;} $14 = FFh
$B3:9C40 80 05       BRA $05    [$9C47]     ; Return

; BRANCH_Y_CLAMP_LOW
$B3:9C42 A9 01 FF    LDA #$FF01             ;\
$B3:9C45 85 14       STA $14    [$7E:0014]  ;} $14 = -FFh

$B3:9C47 60          RTS
}


;;; $9C48: Move Botwoon according to speed and angle to target hole ;;;
{
$B3:9C48 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9C4B BF 34 80 7E LDA $7E8034,x[$7E:8034];\
$B3:9C4F 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy target hole angle]
$B3:9C51 BF 30 80 7E LDA $7E8030,x[$7E:8030];\
$B3:9C55 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy speed]
$B3:9C57 22 43 B6 A0 JSL $A0B643[$A0:B643]  ; ($16.$18, $1A.$1C) = ([$14] * |cos([$12] * pi / 80h)|, [$14] * |sin([$12] * pi / 80h)|)
$B3:9C5B BF 34 80 7E LDA $7E8034,x[$7E:8034];\
$B3:9C5F 8D 20 0E    STA $0E20  [$7E:0E20]  ;} $0E20 = [enemy target hole angle]
$B3:9C62 A5 16       LDA $16    [$7E:0016]  ;\
$B3:9C64 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B3:9C67 A5 18       LDA $18    [$7E:0018]  ;} $0E24.$0E26 = [$16].[$18] (X speed)
$B3:9C69 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$B3:9C6C A5 1A       LDA $1A    [$7E:001A]  ;\
$B3:9C6E 8D 28 0E    STA $0E28  [$7E:0E28]  ;|
$B3:9C71 A5 1C       LDA $1C    [$7E:001C]  ;} $0E28.$0E2A = [$1A].[$1C] (Y speed)
$B3:9C73 8D 2A 0E    STA $0E2A  [$7E:0E2A]  ;/
$B3:9C76 22 91 B6 A0 JSL $A0B691[$A0:B691]  ; Move enemy according to angle and X/Y speeds
$B3:9C7A 60          RTS
}


;;; $9C7B: Update Botwoon position history ;;;
{
$B3:9C7B AC 54 0E    LDY $0E54  [$7E:0E54]  ;\
$B3:9C7E BE AA 0F    LDX $0FAA,y[$7E:0FAA]  ;|
$B3:9C81 B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ;} $7E:9000 + [enemy position history index] = [enemy X position]
$B3:9C84 9F 00 90 7E STA $7E9000,x[$7E:9000];/
$B3:9C88 B9 7E 0F    LDA $0F7E,y[$7E:0F7E]  ;\
$B3:9C8B 9F 02 90 7E STA $7E9002,x[$7E:9002];} $7E:9000 + [enemy position history index] + 2 = [enemy Y position]
$B3:9C8F 60          RTS
}


;;; $9C90: Update Botwoon body projectile positions ;;;
{
$B3:9C90 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9C93 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$B3:9C96 38          SEC                    ;|
$B3:9C97 FD AC 0F    SBC $0FAC,x[$7E:0FAC]  ;} $12 = [enemy position history index] - [enemy body travel time] & 3FFh (position history index)
$B3:9C9A 29 FF 03    AND #$03FF             ;|
$B3:9C9D 85 12       STA $12    [$7E:0012]  ;/
$B3:9C9F A9 18 00    LDA #$0018             ;\
$B3:9CA2 85 14       STA $14    [$7E:0014]  ;} $14 = 18h (body projectile index)

; LOOP
$B3:9CA4 A6 14       LDX $14    [$7E:0014]  ;\
$B3:9CA6 BF 00 78 7E LDA $7E7800,x[$7E:7818];} Y = [$7E:7800 + [$14]] (enemy projectile index)
$B3:9CAA A8          TAY                    ;/
$B3:9CAB AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9CAE BF 2C 80 7E LDA $7E802C,x[$7E:802C];\
$B3:9CB2 C5 12       CMP $12    [$7E:0012]  ;} If [enemy target position history index] != [$12]: go to BRANCH_TOGGLE_VISIBILITY_END
$B3:9CB4 D0 5E       BNE $5E    [$9D14]     ;/
$B3:9CB6 A6 14       LDX $14    [$7E:0014]  ;\
$B3:9CB8 BF 20 78 7E LDA $7E7820,x[$7E:7838];|
$B3:9CBC 49 01 00    EOR #$0001             ;} $7E:7820 + [$14] ^= 1 (toggle body hidden flag)
$B3:9CBF 9F 20 78 7E STA $7E7820,x[$7E:7838];/
$B3:9CC3 F0 15       BEQ $15    [$9CDA]     ; If [$7E:7820 + [$14]] != 0 (body hidden):
$B3:9CC5 B9 D7 1B    LDA $1BD7,y[$7E:1BF9]  ;\
$B3:9CC8 09 00 20    ORA #$2000             ;} Disable enemy projectile collision with Samus
$B3:9CCB 99 D7 1B    STA $1BD7,y[$7E:1BF9]  ;/
$B3:9CCE DA          PHX                    ;\
$B3:9CCF BB          TYX                    ;|
$B3:9CD0 A9 02 00    LDA #$0002             ;} Disable enemy projectile interaction with projectiles
$B3:9CD3 9F 80 F3 7E STA $7EF380,x[$7E:F3A2];|
$B3:9CD7 FA          PLX                    ;/
$B3:9CD8 80 13       BRA $13    [$9CED]

$B3:9CDA B9 D7 1B    LDA $1BD7,y[$7E:1BF9]  ;\ Else ([$7E:7820 + [$14]] = 0 (body not hidden)):
$B3:9CDD 29 FF DF    AND #$DFFF             ;} Enable enemy projectile collision with Samus
$B3:9CE0 99 D7 1B    STA $1BD7,y[$7E:1BF9]  ;/
$B3:9CE3 DA          PHX                    ;\
$B3:9CE4 BB          TYX                    ;|
$B3:9CE5 A9 01 00    LDA #$0001             ;} Enable enemy projectile buggy dud shot
$B3:9CE8 9F 80 F3 7E STA $7EF380,x[$7E:F3A2];|
$B3:9CEC FA          PLX                    ;/

$B3:9CED E0 00 00    CPX #$0000             ;\
$B3:9CF0 D0 22       BNE $22    [$9D14]     ;} If [$14] = 0 (tail enemy projectile):
$B3:9CF2 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9CF5 A9 00 00    LDA #$0000             ;\
$B3:9CF8 9F 2A 80 7E STA $7E802A,x[$7E:802A];} Enemy hole collision disabled flag = 0
$B3:9CFC 9F 3C 80 7E STA $7E803C,x[$7E:803C]; Enemy tail showing flag = 0
$B3:9D00 A9 FF FF    LDA #$FFFF             ;\
$B3:9D03 9F 2C 80 7E STA $7E802C,x[$7E:802C];} Enemy target position history index = FFFFh
$B3:9D07 BF 26 80 7E LDA $7E8026,x[$7E:8026];\
$B3:9D0B D0 07       BNE $07    [$9D14]     ;} If [enemy head hidden flag] = 0:
$B3:9D0D A9 01 00    LDA #$0001             ;\
$B3:9D10 9F 3C 80 7E STA $7E803C,x[$7E:803C];} Enemy tail showing flag = 1

; BRANCH_TOGGLE_VISIBILITY_END
$B3:9D14 A6 12       LDX $12    [$7E:0012]  ;\
$B3:9D16 BF 00 90 7E LDA $7E9000,x[$7E:93E8];} Enemy projectile X position = [$7E:9000 + [$12]] (X position [$12] / 2 frames ago)
$B3:9D1A 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$B3:9D1D BF 02 90 7E LDA $7E9002,x[$7E:93EA];\
$B3:9D21 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [$7E:9000 + [$12] + 2] (Y position [$12] / 2 frames ago)
$B3:9D24 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9D27 A5 12       LDA $12    [$7E:0012]  ;\
$B3:9D29 38          SEC                    ;|
$B3:9D2A FD AC 0F    SBC $0FAC,x[$7E:0FAC]  ;} $12 = [$12] - [enemy body travel time] & 3FFh
$B3:9D2D 29 FF 03    AND #$03FF             ;|
$B3:9D30 85 12       STA $12    [$7E:0012]  ;/
$B3:9D32 C6 14       DEC $14    [$7E:0014]  ;\
$B3:9D34 C6 14       DEC $14    [$7E:0014]  ;} $14 -= 2
$B3:9D36 30 03       BMI $03    [$9D3B]     ; If [$14] >= 0:
$B3:9D38 4C A4 9C    JMP $9CA4  [$B3:9CA4]  ; Go to LOOP

$B3:9D3B 60          RTS
}


;;; $9D3C: Update Botwoon position history index ;;;
{
$B3:9D3C AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9D3F BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$B3:9D42 18          CLC                    ;|
$B3:9D43 69 04 00    ADC #$0004             ;} Enemy position history index = [enemy position history index] + 4 & 3FFh
$B3:9D46 29 FF 03    AND #$03FF             ;|
$B3:9D49 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$B3:9D4C 60          RTS
}


;;; $9D4D: Set Botwoon body instruction list table indices ;;;
{
$B3:9D4D AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9D50 A9 18 00    LDA #$0018             ;\
$B3:9D53 85 16       STA $16    [$7E:0016]  ;} $16 = 18h (body projectile index)

; LOOP
$B3:9D55 64 18       STZ $18    [$7E:0018]  ; $18 = 0
$B3:9D57 A6 16       LDX $16    [$7E:0016]  ;\
$B3:9D59 BF 00 78 7E LDA $7E7800,x[$7E:7818];} Y = [$7E:7800 + [$16]] (enemy projectile index)
$B3:9D5D A8          TAY                    ;/
$B3:9D5E BF 20 78 7E LDA $7E7820,x[$7E:7838];\
$B3:9D62 F0 05       BEQ $05    [$9D69]     ;} If [$7E:7820 + [$16]] != 0 (hidden):
$B3:9D64 A9 00 01    LDA #$0100             ;\
$B3:9D67 85 18       STA $18    [$7E:0018]  ;} $18 = 100h

$B3:9D69 A5 16       LDA $16    [$7E:0016]  ;\
$B3:9D6B C9 18 00    CMP #$0018             ;} If [$16] = 18h: go to BRANCH_FIRST
$B3:9D6E F0 21       BEQ $21    [$9D91]     ;/
$B3:9D70 C9 00 00    CMP #$0000             ;\
$B3:9D73 D0 08       BNE $08    [$9D7D]     ;} If [$16] = 0:
$B3:9D75 A5 18       LDA $18    [$7E:0018]  ;\
$B3:9D77 18          CLC                    ;|
$B3:9D78 69 00 02    ADC #$0200             ;} $18 += 200h
$B3:9D7B 85 18       STA $18    [$7E:0018]  ;/

$B3:9D7D B9 4D 1A    LDA $1A4D,y[$7E:1A6D]  ;\
$B3:9D80 38          SEC                    ;|
$B3:9D81 F9 4B 1A    SBC $1A4B,y[$7E:1A6B]  ;} $12 = [enemy projectile ([Y] + 1) X position] - [enemy projectile X position]
$B3:9D84 85 12       STA $12    [$7E:0012]  ;/
$B3:9D86 B9 95 1A    LDA $1A95,y[$7E:1AB5]  ;\
$B3:9D89 38          SEC                    ;|
$B3:9D8A F9 93 1A    SBC $1A93,y[$7E:1AB3]  ;} $14 = [enemy projectile ([Y] + 1) Y position] - [enemy projectile Y position]
$B3:9D8D 85 14       STA $14    [$7E:0014]  ;/
$B3:9D8F 80 15       BRA $15    [$9DA6]     ; Go to BRANCH_MERGE

; BRANCH_FIRST
$B3:9D91 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9D94 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B3:9D97 38          SEC                    ;|
$B3:9D98 F9 4B 1A    SBC $1A4B,y[$7E:1A6D]  ;} $12 = [enemy X position] - [enemy projectile X position]
$B3:9D9B 85 12       STA $12    [$7E:0012]  ;/
$B3:9D9D BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:9DA0 38          SEC                    ;|
$B3:9DA1 F9 93 1A    SBC $1A93,y[$7E:1AB5]  ;} $14 = [enemy Y position] - [enemy projectile Y position]
$B3:9DA4 85 14       STA $14    [$7E:0014]  ;/

; BRANCH_MERGE
$B3:9DA6 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ; Calculate angle of ([$12], [$14]) offset
$B3:9DAA 18          CLC                    ;\
$B3:9DAB 65 18       ADC $18    [$7E:0018]  ;|
$B3:9DAD 4A          LSR A                  ;|
$B3:9DAE 4A          LSR A                  ;|
$B3:9DAF 4A          LSR A                  ;} Enemy projectile instruction list table index = ([$18] + [A]) / 20h * 2
$B3:9DB0 4A          LSR A                  ;|
$B3:9DB1 4A          LSR A                  ;|
$B3:9DB2 0A          ASL A                  ;|
$B3:9DB3 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;/
$B3:9DB6 C6 16       DEC $16    [$7E:0016]  ;\
$B3:9DB8 C6 16       DEC $16    [$7E:0016]  ;} $16 -= 2
$B3:9DBA 30 03       BMI $03    [$9DBF]     ; If [$16] >= 0:
$B3:9DBC 4C 55 9D    JMP $9D55  [$B3:9D55]  ; Go to LOOP

$B3:9DBF 60          RTS
}


;;; $9DC0: Botwoon head function - moving around ;;;
{
$B3:9DC0 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9DC3 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B3:9DC6 38          SEC                    ;|
$B3:9DC7 FF 2C 88 7E SBC $7E882C,x[$7E:882C];} $12 = [enemy X position] - [enemy X position 4 frames ago]
$B3:9DCB 85 12       STA $12    [$7E:0012]  ;/
$B3:9DCD BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:9DD0 38          SEC                    ;|
$B3:9DD1 FF 2E 88 7E SBC $7E882E,x[$7E:882E];} $14 = [enemy Y position] - [enemy Y position 4 frames ago]
$B3:9DD5 85 14       STA $14    [$7E:0014]  ;/
$B3:9DD7 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;\
$B3:9DDB 85 16       STA $16    [$7E:0016]  ;} $16 = angle from enemy 4 frames ago to enemy
$B3:9DDD A5 12       LDA $12    [$7E:0012]  ;\
$B3:9DDF D0 07       BNE $07    [$9DE8]     ;} If [$12] = 0:
$B3:9DE1 A5 14       LDA $14    [$7E:0014]  ;\
$B3:9DE3 D0 03       BNE $03    [$9DE8]     ;} If [$14] = 0:
$B3:9DE5 4C 38 9E    JMP $9E38  [$B3:9E38]  ; Go to BRANCH_9E38

$B3:9DE8 BF 26 80 7E LDA $7E8026,x[$7E:8026];\
$B3:9DEC F0 19       BEQ $19    [$9E07]     ;} If [enemy head hidden flag] != 0:
$B3:9DEE A9 07 00    LDA #$0007             ;\
$B3:9DF1 9D 9A 0F    STA $0F9A,x[$7E:0F9A]  ;} Enemy layer = 7
$B3:9DF4 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:9DF7 09 00 04    ORA #$0400             ;} Set enemy as intangible
$B3:9DFA 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$B3:9DFD A5 16       LDA $16    [$7E:0016]  ;\
$B3:9DFF 18          CLC                    ;|
$B3:9E00 69 00 01    ADC #$0100             ;} $16 += 100h
$B3:9E03 85 16       STA $16    [$7E:0016]  ;/
$B3:9E05 80 0F       BRA $0F    [$9E16]

$B3:9E07 A9 02 00    LDA #$0002             ;\
$B3:9E0A 9D 9A 0F    STA $0F9A,x[$7E:0F9A]  ;} Enemy layer = 2
$B3:9E0D BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:9E10 29 FF FB    AND #$FBFF             ;} Set enemy as tangible
$B3:9E13 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/

$B3:9E16 A5 16       LDA $16    [$7E:0016]  ;\
$B3:9E18 4A          LSR A                  ;|
$B3:9E19 4A          LSR A                  ;|
$B3:9E1A 4A          LSR A                  ;|
$B3:9E1B 4A          LSR A                  ;} A = [$946B + [$16] / 20h * 2]
$B3:9E1C 4A          LSR A                  ;|
$B3:9E1D 0A          ASL A                  ;|
$B3:9E1E A8          TAY                    ;|
$B3:9E1F B9 6B 94    LDA $946B,y[$B3:9487]  ;/
$B3:9E22 DF 36 80 7E CMP $7E8036,x[$7E:8036];\
$B3:9E26 F0 10       BEQ $10    [$9E38]     ;} If [enemy instruction list] != [A]:
$B3:9E28 9D 92 0F    STA $0F92,x[$7E:0F92]  ; Enemy instruction list pointer = [A]
$B3:9E2B 9F 36 80 7E STA $7E8036,x[$7E:8036]; Enemy instruction list = [A]
$B3:9E2F A9 01 00    LDA #$0001             ;\
$B3:9E32 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$B3:9E35 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0

; BRANCH_9E38
$B3:9E38 BF 28 88 7E LDA $7E8828,x[$7E:8828];\
$B3:9E3C 9F 2C 88 7E STA $7E882C,x[$7E:882C];} Enemy X position 4 frames ago = [enemy X position 3 frames ago]
$B3:9E40 BF 2A 88 7E LDA $7E882A,x[$7E:882A];\
$B3:9E44 9F 2E 88 7E STA $7E882E,x[$7E:882E];} Enemy Y position 4 frames ago = [enemy Y position 3 frames ago]
$B3:9E48 BF 24 88 7E LDA $7E8824,x[$7E:8824];\
$B3:9E4C 9F 28 88 7E STA $7E8828,x[$7E:8828];} Enemy X position 3 frames ago = [enemy X position 2 frames ago]
$B3:9E50 BF 26 88 7E LDA $7E8826,x[$7E:8826];\
$B3:9E54 9F 2A 88 7E STA $7E882A,x[$7E:882A];} Enemy Y position 3 frames ago = [enemy Y position 2 frames ago]
$B3:9E58 BF 20 88 7E LDA $7E8820,x[$7E:8820];\
$B3:9E5C 9F 24 88 7E STA $7E8824,x[$7E:8824];} Enemy X position 2 frames ago = [enemy X position 1 frame ago]
$B3:9E60 BF 22 88 7E LDA $7E8822,x[$7E:8822];\
$B3:9E64 9F 26 88 7E STA $7E8826,x[$7E:8826];} Enemy Y position 2 frames ago = [enemy Y position 1 frame ago]
$B3:9E68 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B3:9E6B 9F 20 88 7E STA $7E8820,x[$7E:8820];} Enemy X position 1 frame ago = [enemy X position]
$B3:9E6F BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:9E72 9F 22 88 7E STA $7E8822,x[$7E:8822];} Enemy Y position 1 frame ago = [enemy Y position]
$B3:9E76 60          RTS
}


;;; $9E77: Botwoon spit speeds ;;;
{
$B3:9E77             dw 0002, 0003, 0004
}


;;; $9E7D: Botwoon head function - spitting - set angle and show ;;;
{
$B3:9E7D AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9E80 A9 02 00    LDA #$0002             ;\
$B3:9E83 9D 9A 0F    STA $0F9A,x[$7E:0F9A]  ;} Enemy layer = 2
$B3:9E86 22 66 C0 A0 JSL $A0C066[$A0:C066]  ; A = angle of Samus from enemy
$B3:9E8A 9F 3A 80 7E STA $7E803A,x[$7E:803A]; Enemy spit angle = [A]
$B3:9E8E 18          CLC                    ;\
$B3:9E8F 69 10 00    ADC #$0010             ;|
$B3:9E92 29 FF 00    AND #$00FF             ;|
$B3:9E95 4A          LSR A                  ;|
$B3:9E96 4A          LSR A                  ;|
$B3:9E97 4A          LSR A                  ;} A = [$946B + [A] / 20h * 2]
$B3:9E98 4A          LSR A                  ;|
$B3:9E99 4A          LSR A                  ;|
$B3:9E9A 0A          ASL A                  ;|
$B3:9E9B A8          TAY                    ;|
$B3:9E9C B9 8B 94    LDA $948B,y[$B3:9497]  ;/
$B3:9E9F 9D 92 0F    STA $0F92,x[$7E:0F92]  ; Enemy instruction list pointer = [A]
$B3:9EA2 9F 36 80 7E STA $7E8036,x[$7E:8036]; Enemy instruction list = [A]
$B3:9EA6 A9 01 00    LDA #$0001             ;\
$B3:9EA9 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$B3:9EAC 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$B3:9EAF BF 3A 80 7E LDA $7E803A,x[$7E:803A];\
$B3:9EB3 38          SEC                    ;|
$B3:9EB4 E9 40 00    SBC #$0040             ;|
$B3:9EB7 29 FF 00    AND #$00FF             ;|
$B3:9EBA 49 FF FF    EOR #$FFFF             ;|
$B3:9EBD 1A          INC A                  ;} Enemy spit angle = (40h - [enemy spit angle]) % 100h (angle using the common maths convention)
$B3:9EBE 18          CLC                    ;|
$B3:9EBF 69 00 01    ADC #$0100             ;|
$B3:9EC2 29 FF 00    AND #$00FF             ;|
$B3:9EC5 9F 3A 80 7E STA $7E803A,x[$7E:803A];/
$B3:9EC9 A9 E0 9E    LDA #$9EE0             ;\
$B3:9ECC 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy head function = $9EE0 (spawn 5 spit projectiles)
$B3:9ECF BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$B3:9ED2 C9 E4 99    CMP #$99E4             ;} If [enemy function] != $99E4 (spitting):
$B3:9ED5 F0 06       BEQ $06    [$9EDD]     ;/
$B3:9ED7 A9 34 9F    LDA #$9F34             ;\
$B3:9EDA 9D B2 0F    STA $0FB2,x            ;} Enemy head function = $9F34 (spawn 3 spit projectiles)

$B3:9EDD 7C B2 0F    JMP ($0FB2,x)[$B3:9EE0]; Go to [enemy head function]
}


;;; $9EE0: Botwoon head function - spitting - spawn 5 spit projectiles ;;;
{
$B3:9EE0 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9EE3 BF 34 88 7E LDA $7E8834,x[$7E:8834];\
$B3:9EE7 D0 01       BNE $01    [$9EEA]     ;} If [enemy spitting flag] = 0:
$B3:9EE9 60          RTS                    ; Return

$B3:9EEA BF 3A 80 7E LDA $7E803A,x[$7E:803A];\
$B3:9EEE 38          SEC                    ;|
$B3:9EEF E9 20 00    SBC #$0020             ;} $060B = ([enemy spit angle] - 20h) % 100h (spit projectile angle)
$B3:9EF2 29 FF 00    AND #$00FF             ;|
$B3:9EF5 8D 0B 06    STA $060B  [$7E:060B]  ;/
$B3:9EF8 A9 05 00    LDA #$0005             ;\
$B3:9EFB 8D 0D 06    STA $060D  [$7E:060D]  ;} $060D = 5 (loop counter)
$B3:9EFE BF 3E 80 7E LDA $7E803E,x[$7E:803E];\
$B3:9F02 0A          ASL A                  ;|
$B3:9F03 A8          TAY                    ;} $0E32 = [$9E77 + [enemy speed table index] * 2] (spit projectile speed)
$B3:9F04 B9 77 9E    LDA $9E77,y[$B3:9E77]  ;|
$B3:9F07 8D 32 0E    STA $0E32  [$7E:0E32]  ;/

; LOOP
$B3:9F0A A0 48 EC    LDY #$EC48             ;\
$B3:9F0D AD 32 0E    LDA $0E32  [$7E:0E32]  ;} Spawn Botwoon's spit enemy projectile with parameter [$0E32]
$B3:9F10 22 27 80 86 JSL $868027[$86:8027]  ;/
$B3:9F14 AD 0B 06    LDA $060B  [$7E:060B]  ;\
$B3:9F17 18          CLC                    ;|
$B3:9F18 69 10 00    ADC #$0010             ;} $060B = ([$060B] + 10h) % 100h
$B3:9F1B 29 FF 00    AND #$00FF             ;|
$B3:9F1E 8D 0B 06    STA $060B  [$7E:060B]  ;/
$B3:9F21 CE 0D 06    DEC $060D  [$7E:060D]  ; Decrement $060D
$B3:9F24 D0 E4       BNE $E4    [$9F0A]     ; If [$060D] != 0: go to LOOP
$B3:9F26 A9 00 00    LDA #$0000             ;\
$B3:9F29 9F 34 88 7E STA $7E8834,x[$7E:8834];} Enemy spitting flag = 0
$B3:9F2D A9 7A 9F    LDA #$9F7A             ;\
$B3:9F30 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy head function = $9F7A (cooldown)
$B3:9F33 60          RTS
}


;;; $9F34: Botwoon head function - spitting - spawn 3 spit projectiles ;;;
{
$B3:9F34 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9F37 BF 3A 80 7E LDA $7E803A,x          ;\
$B3:9F3B 38          SEC                    ;|
$B3:9F3C E9 10 00    SBC #$0010             ;} $060B = ([enemy spit angle] - 10h) % 100h (spit projectile angle)
$B3:9F3F 29 FF 00    AND #$00FF             ;|
$B3:9F42 8D 0B 06    STA $060B  [$7E:060B]  ;/
$B3:9F45 A9 03 00    LDA #$0003             ;\
$B3:9F48 8D 0D 06    STA $060D  [$7E:060D]  ;} $060D = 3 (loop counter)
$B3:9F4B BF 3E 80 7E LDA $7E803E,x          ;\
$B3:9F4F 0A          ASL A                  ;|
$B3:9F50 A8          TAY                    ;} $0E32 = [$9E77 + [enemy speed table index] * 2] (spit projectile speed)
$B3:9F51 B9 77 9E    LDA $9E77,y            ;|
$B3:9F54 8D 32 0E    STA $0E32  [$7E:0E32]  ;/

; LOOP
$B3:9F57 A0 48 EC    LDY #$EC48             ;\
$B3:9F5A AD 32 0E    LDA $0E32  [$7E:0E32]  ;} Spawn Botwoon's spit enemy projectile
$B3:9F5D 22 27 80 86 JSL $868027[$86:8027]  ;/
$B3:9F61 AD 0B 06    LDA $060B  [$7E:060B]  ;\
$B3:9F64 18          CLC                    ;|
$B3:9F65 69 10 00    ADC #$0010             ;} $060B = ([$060B] + 10h) % 100h
$B3:9F68 29 FF 00    AND #$00FF             ;|
$B3:9F6B 8D 0B 06    STA $060B  [$7E:060B]  ;/
$B3:9F6E CE 0D 06    DEC $060D  [$7E:060D]  ; Decrement $060D
$B3:9F71 D0 E4       BNE $E4    [$9F57]     ; If [$060D] != 0: go to LOOP
$B3:9F73 A9 7A 9F    LDA #$9F7A             ;\
$B3:9F76 9D B2 0F    STA $0FB2,x            ;} Enemy head function = $9F7A (cooldown)
$B3:9F79 60          RTS
}


;;; $9F7A: Botwoon head function - spitting - cooldown ;;;
{
$B3:9F7A BF 02 80 7E LDA $7E8002,x[$7E:8002];\
$B3:9F7E 3A          DEC A                  ;} Decrement enemy spit timer
$B3:9F7F 9F 02 80 7E STA $7E8002,x[$7E:8002];/
$B3:9F83 10 0D       BPL $0D    [$9F92]     ; If [enemy spit timer] < 0:
$B3:9F85 A9 00 00    LDA #$0000             ;\
$B3:9F88 9F 02 80 7E STA $7E8002,x          ;} Enemy spit timer = 0
$B3:9F8C A9 C0 9D    LDA #$9DC0             ;\
$B3:9F8F 9D B2 0F    STA $0FB2,x            ;} Enemy head function = $9DC0 (moving around)

$B3:9F92 60          RTS
}


;;; $9F93: Botwoon / hole collision detection ;;;
{
$B3:9F93 BF 2A 80 7E LDA $7E802A,x[$7E:802A];\
$B3:9F97 F0 03       BEQ $03    [$9F9C]     ;} If [enemy hole collision disabled flag] != 0:
$B3:9F99 4C FE 9F    JMP $9FFE  [$B3:9FFE]  ; Return

$B3:9F9C A9 18 00    LDA #$0018             ;\
$B3:9F9F 85 12       STA $12    [$7E:0012]  ;} $12 = 18h (hole index)

; LOOP
$B3:9FA1 A4 12       LDY $12    [$7E:0012]
$B3:9FA3 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:9FA6 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B3:9FA9 D9 9B 94    CMP $949B,y[$B3:94B3]  ;|
$B3:9FAC 30 3C       BMI $3C    [$9FEA]     ;|
$B3:9FAE BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;} If [$949B + [$12]] <= [enemy X position] < [$949B + [$12] + 2] (in hole X range):
$B3:9FB1 D9 9D 94    CMP $949D,y[$B3:94A5]  ;|
$B3:9FB4 10 34       BPL $34    [$9FEA]     ;/
$B3:9FB6 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:9FB9 D9 9F 94    CMP $949F,y[$B3:94A7]  ;|
$B3:9FBC 30 2C       BMI $2C    [$9FEA]     ;|
$B3:9FBE BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;} If [$949B + [$12] + 4] <= [enemy Y position] < [$949B + [$12] + 6] (in hole Y range):
$B3:9FC1 D9 A1 94    CMP $94A1,y[$B3:94A1]  ;|
$B3:9FC4 10 24       BPL $24    [$9FEA]     ;/
$B3:9FC6 A9 01 00    LDA #$0001             ;\
$B3:9FC9 9F 2A 80 7E STA $7E802A,x[$7E:802A];} Enemy hole collision disabled flag = 1
$B3:9FCD BF 26 80 7E LDA $7E8026,x[$7E:8026];\
$B3:9FD1 49 01 00    EOR #$0001             ;} Toggle enemy head hidden flag
$B3:9FD4 9F 26 80 7E STA $7E8026,x[$7E:8026];/
$B3:9FD8 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$B3:9FDB 9F 2C 80 7E STA $7E802C,x[$7E:802C];} Enemy target position history index = [enemy position history index]
$B3:9FDF BF 0C 80 7E LDA $7E800C,x[$7E:800C];\
$B3:9FE3 3A          DEC A                  ;} Decrement enemy $7E:800C (never read)
$B3:9FE4 9F 0C 80 7E STA $7E800C,x[$7E:800C];/
$B3:9FE8 80 14       BRA $14    [$9FFE]     ; Return

$B3:9FEA A9 00 00    LDA #$0000             ;\
$B3:9FED 9F 2A 80 7E STA $7E802A,x[$7E:802A];} Enemy hole collision disabled flag = 0
$B3:9FF1 A5 12       LDA $12    [$7E:0012]  ;\
$B3:9FF3 38          SEC                    ;|
$B3:9FF4 E9 08 00    SBC #$0008             ;} $12 -= 8
$B3:9FF7 85 12       STA $12    [$7E:0012]  ;/
$B3:9FF9 30 03       BMI $03    [$9FFE]     ; If [$12] >= 0:
$B3:9FFB 4C A1 9F    JMP $9FA1  [$B3:9FA1]  ; Go to LOOP

$B3:9FFE 60          RTS
}


;;; $9FFF: Enemy touch - enemy $F293 (Botwoon) ;;;
{
$B3:9FFF 22 28 80 B3 JSL $B38028[$B3:8028]  ; Normal touch AI, but skips death animation
$B3:A003 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$B3:A006 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ;} If [enemy health] != 0: return
$B3:A009 D0 0A       BNE $0A    [$A015]     ;/
$B3:A00B A9 01 00    LDA #$0001             ;\
$B3:A00E 9F 1E 80 7E STA $7E801E,x          ;} Enemy death flag = 1
$B3:A012 20 F5 96    JSR $96F5  [$B3:96F5]  ; Set Botwoon as intangible

$B3:A015 6B          RTL
}


;;; $A016: Enemy shot - enemy $F293 (Botwoon) ;;;
{
$B3:A016 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$B3:A019 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ;} Enemy previous health = [enemy health]
$B3:A01C 9F 18 88 7E STA $7E8818,x[$7E:8818];/
$B3:A020 22 32 80 B3 JSL $B38032[$B3:8032]  ; Normal enemy shot AI, but skips hit-projectile and death animation
$B3:A024 BF 18 88 7E LDA $7E8818,x[$7E:8818];\
$B3:A028 DD 8C 0F    CMP $0F8C,x[$7E:0F8C]  ;} If [enemy previous health] != [enemy health]:
$B3:A02B F0 04       BEQ $04    [$A031]     ;/
$B3:A02D 22 7A 95 B3 JSL $B3957A[$B3:957A]  ; RTL

$B3:A031 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ;\
$B3:A034 D0 0A       BNE $0A    [$A040]     ;} If [enemy health] != 0: return
$B3:A036 A9 01 00    LDA #$0001             ;\
$B3:A039 9F 1E 80 7E STA $7E801E,x[$7E:801E];} Enemy death flag = 1
$B3:A03D 20 F5 96    JSR $96F5  [$B3:96F5]  ; Set Botwoon as intangible

$B3:A040 6B          RTL
}


;;; $A041: Power bomb reaction - enemy $F293 (Botwoon) ;;;
{
$B3:A041 22 3C 80 B3 JSL $B3803C[$B3:803C]  ; Normal enemy power bomb AI, but skips death animation
$B3:A045 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$B3:A048 BD 8C 0F    LDA $0F8C,x            ;} If [enemy health] != 0: return
$B3:A04B D0 0A       BNE $0A    [$A057]     ;/
$B3:A04D A9 01 00    LDA #$0001             ;\
$B3:A050 9F 1E 80 7E STA $7E801E,x          ;} Enemy death flag = 1
$B3:A054 20 F5 96    JSR $96F5  [$B3:96F5]  ; Set Botwoon as intangible

$B3:A057 6B          RTL
}


;;; $A058: Botwoon movement data ;;;
{
; This would be used as a terminator if the $A05A path was traversed backwards
$B3:A058             db 80,00

; Visible - left -> bottom
$B3:A05A             db 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 80,00

; Visible - left -> top
$B3:A32A             db 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 80,F0, 00,00, 00,00, 80,00

; Visible - left -> right
$B3:A6BC             db 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,01, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,01, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 01,FF, 01,FF, 01,FF, 00,FF, 01,00, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,01, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,01, 00,01, FF,00, 00,01, FF,01, FF,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,FF, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 01,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 80,00

; Visible - left -> left
$B3:AA24             db 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,01, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 00,01, 01,00, 00,01, 01,01, 01,01, 00,01, 01,00, 00,01, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 01,01, 01,01, 01,01, 01,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,FF, 01,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 00,01, 01,00, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,01, FF,01, 00,01, FF,00, FF,01, FF,00, 00,01, FF,00, FF,01, FF,00, FF,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, FF,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 80,00

; Visible - bottom -> left
$B3:ADFE             db 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,01, FF,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, 80,00

; Visible - bottom -> top
$B3:B16A             db 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,01, 00,01, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,01, 00,01, 80,00

; Visible - bottom -> right
$B3:B556             db 01,00, 00,FF, 01,00, 00,FF, 01,FF, 01,FF, 01,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,01, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 80,00

; Visible - bottom -> bottom
$B3:B956             db FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, FF,FF, FF,00, FF,FF, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,FF, FF,FF, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,FF, FF,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,01, 00,01, 01,00, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, FF,01, 00,01, FF,01, 00,01, FF,00, 00,01, FF,01, FF,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, FF,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,01, FF,00, 00,01, FF,00, FF,01, FF,00, 00,01, FF,00, 80,00

; Visible - top -> left
$B3:BC86             db 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,01, 00,01, 00,01, FF,01, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 01,01, 00,01, 01,01, 00,01, 01,01, 00,01, 01,01, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,01, FF,01, FF,00, 00,01, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF, FF,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, 00,01, FF,00, FF,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,01, 00,01, FF,00, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,01, 01,01, 01,01, 01,00, 00,01, 01,00, 01,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,FF, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF, FF,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, 80,00

; Visible - top -> bottom
$B3:C086             db 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 80,00

; Visible - top -> right
$B3:C290             db 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,00, 01,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 80,00

; Visible - top -> top
$B3:C690             db 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,FF, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 80,00

; Visible - right -> left
$B3:C9CC             db FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 80,00

; Visible - right -> bottom
$B3:CDCC             db FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 80,00

; Visible - right -> top
$B3:D140             db FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 01,FF, 01,00, 00,FF, 01,00, 01,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, FF,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, FF,00, 00,FF, 80,00

; Visible - right -> right
$B3:D4A2             db FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,01, FF,00, FF,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,01, FF,00, 00,01, FF,00, 00,01, FF,01, FF,01, 00,01, FF,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01, 01,00, 00,01, 01,01, 01,01, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,01, FF,01, FF,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, 00,FF, FF,00, FF,FF, FF,FF, FF,FF, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 01,FF, 01,FF, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,FF, 01,00, 00,FF, 01,00, 01,FF, 01,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 80,00

; Hidden - left <-> bottom
$B3:D880             db 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 80,00

; Hidden - left <-> top
$B3:DA02             db 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,01, 01,00, 01,00, 00,01, 01,00, 80,00

; Hidden - left <-> right
$B3:DB9C             db 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 80,00

; Hidden - bottom <-> top
$B3:DD42             db 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,FF, 01,FF, 01,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 01,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 80,00

; Hidden - bottom <-> right
$B3:DE7E             db 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 80,00

; Hidden - top <-> right
$B3:DFE0             db 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 80,00
}


;;; $E150: Botwoon movement table ;;;
{
;                        __________________ Movement data pointer
;                       |     _____________ Direction. 0 = forwards, FFFFh = backwards
;                       |    |     ________ Destination hole. 0 = left, 8 = bottom, 10h = top, 18h = right
;                       |    |    |
$B3:E150             dw A05A,0000,0008,0000, ; Visible - left -> bottom
                        A32A,0000,0010,0000, ; Visible - left -> top
                        A6BC,0000,0018,0000, ; Visible - left -> right
                        AA24,0000,0000,0000, ; Visible - left -> left
                        ADFE,0000,0000,0000, ; Visible - bottom -> left
                        B16A,0000,0010,0000, ; Visible - bottom -> top
                        B556,0000,0018,0000, ; Visible - bottom -> right
                        B956,0000,0008,0000, ; Visible - bottom -> bottom
                        BC86,0000,0000,0000, ; Visible - top -> left
                        C086,0000,0008,0000, ; Visible - top -> bottom
                        C290,0000,0018,0000, ; Visible - top -> right
                        C690,0000,0010,0000, ; Visible - top -> top
                        C9CC,0000,0000,0000, ; Visible - right -> left
                        CDCC,0000,0008,0000, ; Visible - right -> bottom
                        D140,0000,0010,0000, ; Visible - right -> top
                        D4A2,0000,0018,0000, ; Visible - right -> right
                        D880,0000,0008,0000, ; Hidden - left -> bottom
                        DA02,0000,0010,0000, ; Hidden - left -> top
                        DB9C,0000,0018,0000, ; Hidden - left -> right
                        DB9C,0000,0018,0000, ; Hidden - left -> right
                        DA00,FFFF,0000,0000, ; Hidden - bottom -> left
                        DD42,0000,0010,0000, ; Hidden - bottom -> top
                        DE7E,0000,0018,0000, ; Hidden - bottom -> right
                        DE7E,0000,0018,0000, ; Hidden - bottom -> right
                        DB9A,FFFF,0000,0000, ; Hidden - top -> left
                        DE7C,FFFF,0008,0000, ; Hidden - top -> bottom
                        DFE0,0000,0018,0000, ; Hidden - top -> right
                        DFE0,0000,0018,0000, ; Hidden - top -> right
                        DD40,FFFF,0000,0000, ; Hidden - right -> left
                        DFDE,FFFF,0008,0000, ; Hidden - right -> bottom
                        E14E,FFFF,0010,0000, ; Hidden - right -> top
                        E14E,FFFF,0010,0000  ; Hidden - right -> top
}


;;; $E250: Botwoon movement function - start moving Botwoon according to movement data ;;;
{
; Note the fixed point negation operation at $E2EB is off by 1.0 when the low word is zero
$B3:E250 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:E253 A9 8C E2    LDA #$E28C             ;\
$B3:E256 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy movement function = $E28C (move Botwoon according to movement data)
$B3:E259 A9 00 00    LDA #$0000             ;\
$B3:E25C 9F 38 80 7E STA $7E8038,x[$7E:8038];} Enemy going through hole flag = 0
$B3:E260 BF 00 88 7E LDA $7E8800,x[$7E:8800];\
$B3:E264 18          CLC                    ;|
$B3:E265 69 50 E1    ADC #$E150             ;} Y = $E150 + [enemy movement table index]
$B3:E268 A8          TAY                    ;/
$B3:E269 B9 00 00    LDA $0000,y[$B3:E150]  ;\
$B3:E26C 9F 04 88 7E STA $7E8804,x[$7E:8804];} Enemy movement data pointer = [[Y]]
$B3:E270 B9 04 00    LDA $0004,y[$B3:E154]  ;\
$B3:E273 9F 2E 80 7E STA $7E802E,x[$7E:802E];} Enemy target hole index = [[Y] + 4]
$B3:E277 B9 02 00    LDA $0002,y[$B3:E152]  ;\
$B3:E27A 9F 08 88 7E STA $7E8808,x[$7E:8808];} Enemy movement direction = [[Y] + 2]
$B3:E27E 10 0C       BPL $0C    [$E28C]     ; If [enemy movement direction] < 0:
$B3:E280 BF 04 88 7E LDA $7E8804,x[$7E:8804];\
$B3:E284 38          SEC                    ;|
$B3:E285 E9 04 00    SBC #$0004             ;} Enemy movement data pointer -= 4
$B3:E288 9F 04 88 7E STA $7E8804,x[$7E:8804];/
}


;;; $E28C: Botwoon movement function - move Botwoon according to movement data ;;;
{
$B3:E28C AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:E28F 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$B3:E291 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$B3:E293 BF 30 80 7E LDA $7E8030,x[$7E:8030];\
$B3:E297 85 18       STA $18    [$7E:0018]  ;} $18 = [enemy speed]
$B3:E299 A9 02 00    LDA #$0002             ;\
$B3:E29C 85 16       STA $16    [$7E:0016]  ;} $16 = 2 (forwards movement data pointer delta)
$B3:E29E BF 08 88 7E LDA $7E8808,x[$7E:8808];\
$B3:E2A2 10 05       BPL $05    [$E2A9]     ;} If [enemy movement direction] < 0:
$B3:E2A4 A9 FE FF    LDA #$FFFE             ;\
$B3:E2A7 85 16       STA $16    [$7E:0016]  ;} $16 = -2 (backwards movement data pointer delta)

; LOOP
$B3:E2A9 BF 04 88 7E LDA $7E8804,x[$7E:8804];\
$B3:E2AD A8          TAY                    ;} Y = [enemy movement data pointer]
$B3:E2AE B9 00 00    LDA $0000,y[$B3:A05A]  ;\
$B3:E2B1 29 FF 00    AND #$00FF             ;} A = ±[[Y]]
$B3:E2B4 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;/
$B3:E2B8 C9 80 FF    CMP #$FF80             ;\
$B3:E2BB F0 51       BEQ $51    [$E30E]     ;} If [A] = -80h: go to BRANCH_END
$B3:E2BD 18          CLC                    ;\
$B3:E2BE 65 12       ADC $12    [$7E:0012]  ;} $12 += [A]
$B3:E2C0 85 12       STA $12    [$7E:0012]  ;/
$B3:E2C2 B9 01 00    LDA $0001,y[$B3:A05B]  ;\
$B3:E2C5 29 FF 00    AND #$00FF             ;} A = ±[[Y] + 1]
$B3:E2C8 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;/
$B3:E2CC C9 80 FF    CMP #$FF80             ;\
$B3:E2CF F0 3D       BEQ $3D    [$E30E]     ;} If [A] = -80h: go to BRANCH_END
$B3:E2D1 18          CLC                    ;\
$B3:E2D2 65 14       ADC $14    [$7E:0014]  ;} $14 += [A]
$B3:E2D4 85 14       STA $14    [$7E:0014]  ;/
$B3:E2D6 BF 04 88 7E LDA $7E8804,x[$7E:8804];\
$B3:E2DA 18          CLC                    ;|
$B3:E2DB 65 16       ADC $16    [$7E:0016]  ;} Enemy movement data pointer += [$16]
$B3:E2DD 9F 04 88 7E STA $7E8804,x[$7E:8804];/
$B3:E2E1 C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$B3:E2E3 D0 C4       BNE $C4    [$E2A9]     ; If [$18] != 0: go to LOOP
$B3:E2E5 BF 08 88 7E LDA $7E8808,x[$7E:8808];\
$B3:E2E9 10 10       BPL $10    [$E2FB]     ;} If [enemy movement direction] < 0:
$B3:E2EB A5 12       LDA $12    [$7E:0012]  ;\
$B3:E2ED 49 FF FF    EOR #$FFFF             ;|
$B3:E2F0 1A          INC A                  ;} Negate $12
$B3:E2F1 85 12       STA $12    [$7E:0012]  ;/
$B3:E2F3 A5 14       LDA $14    [$7E:0014]  ;\
$B3:E2F5 49 FF FF    EOR #$FFFF             ;|
$B3:E2F8 1A          INC A                  ;} Negate $14
$B3:E2F9 85 14       STA $14    [$7E:0014]  ;/

$B3:E2FB BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B3:E2FE 18          CLC                    ;|
$B3:E2FF 65 12       ADC $12    [$7E:0012]  ;} Enemy X position += [$12]
$B3:E301 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$B3:E304 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B3:E307 18          CLC                    ;|
$B3:E308 65 14       ADC $14    [$7E:0014]  ;} Enemy Y position += [$14]
$B3:E30A 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$B3:E30D 60          RTS                    ; Return

; BRANCH_END
$B3:E30E A9 00 00    LDA #$0000             ;\
$B3:E311 9F 02 88 7E STA $7E8802,x[$7E:8802];} Enemy $7E:8802 = 0 (unused)
$B3:E315 A9 01 00    LDA #$0001             ;\
$B3:E318 9F 38 80 7E STA $7E8038,x[$7E:8038];} Enemy going through hole flag = 1
$B3:E31C 60          RTS
}


;;; $E31D: Spritemaps - Botwoon ;;;
{
; Mouth closed - priority = 2
$B3:E31D             dx 0002, 81F8,F7,2122, 81F8,E7,2120 ; Aiming up, facing left
$B3:E329             dx 0002, 81F8,F6,2106, 81F0,EE,2104 ; Aiming up-left
$B3:E335             dx 0002, 81FC,F8,2102, 81EC,F8,2100 ; Aiming left
$B3:E341             dx 0002, 81F8,F9,210A, 81F0,01,2108 ; Aiming down-left
$B3:E34D             dx 0002, 81F8,09,210E, 81F8,F9,210C ; Aiming down, facing left
$B3:E359             dx 0002, 81F8,09,610E, 81F8,F9,610C ; Aiming down, facing right
$B3:E365             dx 0002, 8000,01,6108, 81F8,F9,610A ; Aiming down-right
$B3:E371             dx 0002, 81F4,F8,6102, 8004,F8,6100 ; Aiming right
$B3:E37D             dx 0002, 8000,EE,6104, 81F8,F6,6106 ; Aiming up-right
$B3:E389             dx 0002, 81F8,F7,6122, 81F8,E7,6120 ; Aiming up, facing right

; Mouth open - priority = 2
$B3:E395             dx 0002, 81F8,F8,2126, 81F8,E8,2124
$B3:E3A1             dx 0003, 01F0,00,21A6, 81F8,F8,2186, 81F0,F0,2184
$B3:E3B2             dx 0002, 81FC,F8,2182, 81EC,F8,2180
$B3:E3BE             dx 0003, 0000,09,21A7, 81F8,F9,218A, 81F0,01,2188
$B3:E3CF             dx 0002, 81F8,09,218E, 81F8,F9,218C
$B3:E3DB             dx 0002, 81F8,09,618E, 81F8,F9,618C
$B3:E3E7             dx 0003, 01F8,09,61A7, 81F8,F9,618A, 8000,01,6188
$B3:E3F8             dx 0002, 81F4,F8,6182, 8004,F8,6180
$B3:E404             dx 0003, 0008,00,61A6, 81F8,F8,6186, 8000,F0,6184
$B3:E415             dx 0002, 81F8,F8,6126, 81F8,E8,6124

; Mouth closed - priority = 0
$B3:E421             dx 0002, 81F8,F7,0122, 81F8,E7,0120
$B3:E42D             dx 0002, 81F8,F6,0106, 81F0,EE,0104
$B3:E439             dx 0002, 81FC,F8,0102, 81EC,F8,0100
$B3:E445             dx 0002, 81F8,F9,010A, 81F0,01,0108
$B3:E451             dx 0002, 81F8,09,010E, 81F8,F9,010C
$B3:E45D             dx 0002, 81F8,09,410E, 81F8,F9,410C
$B3:E469             dx 0002, 8000,01,4108, 81F8,F9,410A
$B3:E475             dx 0002, 81F4,F8,4102, 8004,F8,4100
$B3:E481             dx 0002, 8000,EE,4104, 81F8,F6,4106
$B3:E48D             dx 0002, 81F8,F7,4122, 81F8,E7,4120

; Unused. Mouth open - priority = 0
$B3:E499             dx 0002, 81F8,F8,0126, 81F8,E8,0124
$B3:E4A5             dx 0003, 01F0,00,01A6, 81F8,F8,0186, 81F0,F0,0184
$B3:E4B6             dx 0002, 81FC,F8,0182, 81EC,F8,0180
$B3:E4C2             dx 0003, 0000,09,01A7, 81F8,F9,018A, 81F0,01,0188
$B3:E4D3             dx 0002, 81F8,09,018E, 81F8,F9,018C
$B3:E4DF             dx 0002, 81F8,09,418E, 81F8,F9,418C
$B3:E4EB             dx 0003, 01F8,09,41A7, 81F8,F9,418A, 8000,01,4188
$B3:E4FC             dx 0002, 81F4,F8,4182, 8004,F8,4180
$B3:E508             dx 0003, 0008,00,41A6, 81F8,F8,4186, 8000,F0,4184
$B3:E519             dx 0002, 81F8,F8,4126, 81F8,E8,4124
}
}


;;; $E525..E943: Escape etecoon ;;;
{
;;; $E525: Palette - enemy $F2D3 (escape etecoon) ;;;
{
$B3:E525             dw 3800, 5F97, 56F2, 2987, 00A0, 6355, 4AB0, 3A0B, 31C9, 57FF, 42F7, 2610, 158C, 03FF, 0279, 0029
}


;;; $E545: Instruction - go to [[Y]] if [acid Y position] < CEh ;;;
{
$B3:E545 AD 62 19    LDA $1962  [$7E:1962]
$B3:E548 C9 CE 00    CMP #$00CE
$B3:E54B B0 05       BCS $05    [$E552]
$B3:E54D B9 00 00    LDA $0000,y
$B3:E550 A8          TAY
$B3:E551 6B          RTL

$B3:E552 C8          INY
$B3:E553 C8          INY
$B3:E554 6B          RTL
}


;;; $E555: RTS ;;;
{
$B3:E555 60          RTS
}


;;; $E556: Instruction list - running left - low tide ;;;
{
$B3:E556             dw E545,E56E   ; Go to $E56E if [acid Y position] < CEh
$B3:E55A             dw 0005,E736,
                        0005,E747,
                        0005,E753,
                        0005,E747,
                        80ED,E55A   ; Go to $E55A
}


;;; $E56E: Instruction list - running left - high tide ;;;
{
$B3:E56E             dw 0003,E736,
                        0003,E747,
                        0003,E753,
                        0003,E747,
                        80ED,E56E   ; Go to $E56E
}


;;; $E582: Instruction list - running right - low tide ;;;
{
$B3:E582             dw E545,E59A   ; Go to $E59A if [acid Y position] < CEh
$B3:E586             dw 0006,E75F,
                        0006,E770,
                        0006,E77C,
                        0006,E770,
                        80ED,E586   ; Go to $E586
}


;;; $E59A: Instruction list - running right - high tide ;;;
{
$B3:E59A             dw 0003,E75F,
                        0003,E770,
                        0003,E77C,
                        0003,E770,
                        80ED,E59A   ; Go to $E59A
}


;;; $E5AE: Instruction list - running for escape ;;;
{
$B3:E5AE             dw 806B,E65C   ; Enemy function = $E65C
$B3:E5B2             dw 0003,E75F,
                        0003,E770,
                        0003,E77C,
                        0003,E770,
                        80ED,E5B2   ; Go to $E5B2
}


;;; $E5C6: Instruction list - stationary ;;;
{
$B3:E5C6             dw 0040,E8B0,
                        0008,E8D5,
                        0040,E91F,
                        0008,E8FA,
                        80ED,E5C6   ; Go to $E5C6
}


;;; $E5DA: Instruction list - express gratitude then escape ;;;
{
$B3:E5DA             dw 8074,       ; Enemy function = RTS
                        8123,0008   ; Timer = 8
$B3:E5E0             dw 0008,E736,
                        E610,FFFD,  ; Enemy X position -= 3
                        0008,E747,
                        E610,FFFD,  ; Enemy X position -= 3
                        0008,E753,
                        E610,FFFD,  ; Enemy X position -= 3
                        0008,E747,
                        E610,FFFD,  ; Enemy X position -= 3
                        8110,E5E0,  ; Decrement timer and go to $E5E0 if non-zero
                        0040,E8B0,
                        0008,E8D5,
                        80ED,E5AE   ; Go to $E5AE
}


;;; $E610: Instruction - enemy X position += [[Y]] ;;;
{
$B3:E610 BD 7A 0F    LDA $0F7A,x[$7E:103A]
$B3:E613 18          CLC
$B3:E614 79 00 00    ADC $0000,y[$B3:E5E6]
$B3:E617 9D 7A 0F    STA $0F7A,x[$7E:103A]
$B3:E61A C8          INY
$B3:E61B C8          INY
$B3:E61C 6B          RTL
}


;;; $E61D: Unused. Instruction list ;;;
{
$B3:E61D             dw 0001,E788,
                        812F        ; Sleep
}


;;; $E623: Unused. Instruction list ;;;
{
$B3:E623             dw 000C,E7AD,
                        000C,E7D2,
                        0006,E7F7,
                        000C,E7D2,
                        000C,E7AD,
                        812F        ; Sleep
}


;;; $E639: Unused. Instruction list ;;;
{
$B3:E639             dw 0001,E81C,
                        812F        ; Sleep
}


;;; $E63F: Unused. Instruction list ;;;
{
$B3:E63F             dw 000C,E841,
                        000C,E866,
                        0006,E88B,
                        000C,E866,
                        000C,E841,
                        812F        ; Sleep
}


;;; $E655: Main AI - enemy $F2D3 (escape etecoon) ;;;
{
$B3:E655 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:E658 FC B2 0F    JSR ($0FB2,x)[$B3:E680]
$B3:E65B 6B          RTL
}


;;; $E65C: Escape etecoon function - running for escape ;;;
{
$B3:E65C BD 7C 0F    LDA $0F7C,x[$7E:0FFC]  ;\
$B3:E65F 18          CLC                    ;|
$B3:E660 69 00 80    ADC #$8000             ;|
$B3:E663 9D 7C 0F    STA $0F7C,x[$7E:0FFC]  ;} Enemy X position += 3.8000h
$B3:E666 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;|
$B3:E669 69 03 00    ADC #$0003             ;|
$B3:E66C 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$B3:E66F 60          RTS
}


;;; $E670: Escape etecoon function - stationary (waiting to express gratitude) ;;;
{
$B3:E670 A9 0F 00    LDA #$000F             ;\
$B3:E673 22 33 82 80 JSL $808233[$80:8233]  ;} If critters escaped:
$B3:E677 90 06       BCC $06    [$E67F]     ;/
$B3:E679 A9 DA E5    LDA #$E5DA             ;\
$B3:E67C 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $E5DA

$B3:E67F 60          RTS
}


;;; $E680: Escape etecoon function - running around aimlessly ;;;
{
$B3:E680 64 12       STZ $12    [$7E:0012]  ;\
$B3:E682 64 14       STZ $14    [$7E:0014]  ;|
$B3:E684 BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;|
$B3:E687 10 02       BPL $02    [$E68B]     ;} $14.$12 = [enemy X velocity] / 100h
$B3:E689 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$B3:E68B 85 13       STA $13    [$7E:0013]  ;/
$B3:E68D 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [$14].[$12]
$B3:E691 90 2C       BCC $2C    [$E6BF]     ; If not collided with wall: go to BRANCH_NO_COLLISION
$B3:E693 A9 01 00    LDA #$0001             ;\
$B3:E696 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$B3:E699 BD A8 0F    LDA $0FA8,x[$7E:1028]  ;\
$B3:E69C 49 FF FF    EOR #$FFFF             ;|
$B3:E69F 1A          INC A                  ;} Negate enemy X velocity
$B3:E6A0 9D A8 0F    STA $0FA8,x[$7E:1028]  ;/
$B3:E6A3 10 05       BPL $05    [$E6AA]     ; If [enemy X velocity] < 0:
$B3:E6A5 A9 56 E5    LDA #$E556             ; Enemy instruction list pointer = $E556
$B3:E6A8 80 03       BRA $03    [$E6AD]

                                            ; Else ([enemy X velocity] >= 0):
$B3:E6AA A9 82 E5    LDA #$E582             ; Enemy instruction list pointer = $E582

$B3:E6AD 9D 92 0F    STA $0F92,x[$7E:1012]
$B3:E6B0 A9 0F 00    LDA #$000F             ;\
$B3:E6B3 22 33 82 80 JSL $808233[$80:8233]  ;} If critters escaped:
$B3:E6B7 90 06       BCC $06    [$E6BF]     ;/
$B3:E6B9 A9 AE E5    LDA #$E5AE             ;\
$B3:E6BC 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = $E5AE

; BRANCH_NO_COLLISION
$B3:E6BF 64 12       STZ $12    [$7E:0012]  ;\
$B3:E6C1 A9 01 00    LDA #$0001             ;|
$B3:E6C4 85 14       STA $14    [$7E:0014]  ;} Move enemy down by 1.0
$B3:E6C6 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$B3:E6CA 60          RTS
}


;;; $E6CB: Initialisation AI - enemy $F2D3 (escape etecoon) ;;;
{
$B3:E6CB AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:E6CE A9 0F 00    LDA #$000F             ;\
$B3:E6D1 22 33 82 80 JSL $808233[$80:8233]  ;} If critters escaped:
$B3:E6D5 90 0A       BCC $0A    [$E6E1]     ;/
$B3:E6D7 BD 86 0F    LDA $0F86,x            ;\
$B3:E6DA 09 00 02    ORA #$0200             ;} Flag enemy for deletion
$B3:E6DD 9D 86 0F    STA $0F86,x            ;/
$B3:E6E0 6B          RTL                    ; Return

$B3:E6E1 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$B3:E6E4 09 00 A4    ORA #$A400             ;} Set enemy to process instructions and be intangible
$B3:E6E7 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$B3:E6EA A9 01 00    LDA #$0001             ;\
$B3:E6ED 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$B3:E6F0 9E 90 0F    STZ $0F90,x[$7E:0FD0]  ; Enemy timer = 0
$B3:E6F3 9E 96 0F    STZ $0F96,x[$7E:0FD6]  ; Enemy palette index = 0
$B3:E6F6 BC B4 0F    LDY $0FB4,x[$7E:0FF4]  ; Y = [enemy parameter 1]
$B3:E6F9 B9 18 E7    LDA $E718,y[$B3:E718]  ;\
$B3:E6FC 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [$E718 + [Y]]
$B3:E6FF B9 1E E7    LDA $E71E,y[$B3:E71E]  ;\
$B3:E702 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = [$E71E + [Y]]
$B3:E705 B9 24 E7    LDA $E724,y[$B3:E724]  ;\
$B3:E708 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = [$E724 + [Y]]
$B3:E70B B9 2A E7    LDA $E72A,y[$B3:E72A]  ;\
$B3:E70E 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = [$E72A + [Y]]
$B3:E711 B9 30 E7    LDA $E730,y[$B3:E730]  ;\
$B3:E714 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy X velocity = [$E730 + [Y]]
$B3:E717 6B          RTL

; Indexed by [enemy parameter 1]
$B3:E718             dw 0080, 00A0, 00E8 ; X position
$B3:E71E             dw 00C8, 00C8, 00C8 ; Y position
$B3:E724             dw E680, E680, E670 ; Function
$B3:E72A             dw E556, E582, E5C6 ; Instruction list pointer
$B3:E730             dw FE00, 0280, 0000 ; X velocity
}


;;; $E736: Escape etecoon spritemaps ;;;
{
$B3:E736             dx 0003, 01F2,FF,3329, C3F5,EF,3300, C3FA,F7,3302
$B3:E747             dx 0002, C3F5,F0,3300, C3FA,F8,3304
$B3:E753             dx 0002, C3F5,F1,3300, C3FA,F9,3306
$B3:E75F             dx 0003, 0006,FF,7329, C3FB,EF,7300, C3F6,F7,7302
$B3:E770             dx 0002, C3FB,F0,7300, C3F6,F8,7304
$B3:E77C             dx 0002, C3FB,F1,7300, C3F6,F9,7306
$B3:E788             dx 0007, 0001,FE,7322, 01F8,FE,3322, C3F8,F2,730C, 01F9,01,3324, 0000,01,7324, 01F9,FA,3320, 0000,FA,7320
$B3:E7AD             dx 0007, 01F7,FC,3322, 0002,FC,7322, C3F8,F1,730C, 01F9,01,3323, 0000,01,7323, 01F9,FA,3320, 0000,FA,7320
$B3:E7D2             dx 0007, 01F9,01,3323, 0000,01,7323, C3F8,EF,730C, 01F9,F9,3320, 0000,F9,7320, 01F5,F9,3321, 0004,F9,7321
$B3:E7F7             dx 0007, 01F9,01,3323, 0000,01,7323, C3F8,EF,730C, 01F9,F9,3320, 0000,F9,7320, 01F5,F7,3321, 0004,F7,7321
$B3:E81C             dx 0007, 01F7,FE,3322, 0000,FE,7322, C3F8,F2,330C, 01FF,01,7324, 01F8,01,3324, 01FF,FA,7320, 01F8,FA,3320
$B3:E841             dx 0007, 0001,FC,7322, 01F6,FC,3322, C3F8,F1,330C, 01FF,01,7323, 01F8,01,3323, 01FF,FA,7320, 01F8,FA,3320
$B3:E866             dx 0007, 01FF,01,7323, 01F8,01,3323, C3F8,EF,330C, 01FF,F9,7320, 01F8,F9,3320, 0003,F9,7321, 01F4,F9,3321
$B3:E88B             dx 0007, 01FF,01,7323, 01F8,01,3323, C3F8,EF,330C, 01FF,F9,7320, 01F8,F9,3320, 0003,F7,7321, 01F4,F7,3321
$B3:E8B0             dx 0007, C3F8,ED,3300, 0002,F9,7322, 01F7,F9,3322, 01F9,FF,3324, 0000,FF,7324, 01F9,F7,3320, 0000,F7,7320
$B3:E8D5             dx 0007, 0002,F9,7322, 01F7,F9,3322, C3F8,ED,730C, 01F9,FF,3324, 0000,FF,7324, 01F9,F7,3320, 0000,F7,7320
$B3:E8FA             dx 0007, 01F6,F9,3322, 0001,F9,7322, C3F8,ED,330C, 01FF,FF,7324, 01F8,FF,3324, 01FF,F7,7320, 01F8,F7,3320
$B3:E91F             dx 0007, C3F8,ED,3300, 01F6,F9,3322, 0001,F9,7322, 01FF,FF,7324, 01F8,FF,3324, 01FF,F7,7320, 01F8,F7,3320
}
}


;;; $E944..ED76: Escape dachora ;;;
{
;;; $E944: Palette - enemy $F313 (escape dachora) ;;;
{
$B3:E944             dw 3800, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 57FF, 42F7, 2610, 158C, 7C1F, 6018, 300A
}


;;; $E964: Instruction list - running around aimlessly - low tide ;;;
{
$B3:E964             dw 8123,0005   ; Timer = 5
$B3:E968             dw 0003,EB1B,
                        EAC9,       ; Enemy X position -= 6
                        0003,EB4A,
                        EAC9,       ; Enemy X position -= 6
                        0003,EB79,
                        EAC9,       ; Enemy X position -= 6
                        0003,EBB2,
                        EAC9,       ; Enemy X position -= 6
                        0003,EBE1,
                        EAC9,       ; Enemy X position -= 6
                        0003,EC10,
                        EAC9,       ; Enemy X position -= 6
                        EAA8,E9FC,  ; Go to $E9FC if [acid Y position] < CEh
                        EAB8,EA34,  ; Go to $EA34 if critters escaped
                        8110,E968,  ; Decrement timer and go to $E968 if non-zero
                        8123,0005   ; Timer = 5
$B3:E99C             dw 0003,EC49,
                        EAD7,       ; Enemy X position += 6
                        0003,EC78,
                        EAD7,       ; Enemy X position += 6
                        0003,ECA7,
                        EAD7,       ; Enemy X position += 6
                        0003,ECE0,
                        EAD7,       ; Enemy X position += 6
                        0003,ED0F,
                        EAD7,       ; Enemy X position += 6
                        0003,ED3E,
                        EAD7,       ; Enemy X position += 6
                        EAA8,EA2C,  ; Go to $EA2C if [acid Y position] < CEh
                        EAB8,EA38,  ; Go to $EA38 if critters escaped
                        8110,E99C,  ; Decrement timer and go to $E99C if non-zero
                        80ED,E964   ; Go to $E964
}


;;; $E9D0: Instruction list - running around aimlessly - high tide ;;;
{
$B3:E9D0             dw 8123,0005   ; Timer = 5
$B3:E9D4             dw 0002,EB1B,
                        EAC9,       ; Enemy X position -= 6
                        0002,EB4A,
                        EAC9,       ; Enemy X position -= 6
                        0002,EB79,
                        EAC9,       ; Enemy X position -= 6
                        0002,EBB2,
                        EAC9,       ; Enemy X position -= 6
                        0002,EBE1,
                        EAC9,       ; Enemy X position -= 6
                        0002,EC10,
                        EAC9,       ; Enemy X position -= 6
                        EAB8,EA34   ; Go to $EA34 if critters escaped
$B3:E9FC             dw 8110,E9D4,  ; Decrement timer and go to $E9D4 if non-zero
                        8123,0005   ; Timer = 5
$B3:EA04             dw 0002,EC49,
                        EAD7,       ; Enemy X position += 6
                        0002,EC78,
                        EAD7,       ; Enemy X position += 6
                        0002,ECA7,
                        EAD7,       ; Enemy X position += 6
                        0002,ECE0,
                        EAD7,       ; Enemy X position += 6
                        0002,ED0F,
                        EAD7,       ; Enemy X position += 6
                        0002,ED3E,
                        EAD7,       ; Enemy X position += 6
                        EAB8,EA38   ; Go to $EA38 if critters escaped
$B3:EA2C             dw 8110,EA04,  ; Decrement timer and go to $EA04 if non-zero
                        80ED,E9D0   ; Go to $E9D0
}


;;; $EA34: Instruction list - running for escape ;;;
{
$B3:EA34             dw 001E,EB1B 
$B3:EA38             dw 005A,EC49,
                        EAD7,       ; Enemy X position += 6
                        0005,EC78,
                        EAD7,       ; Enemy X position += 6
                        0005,ECA7,
                        EAD7,       ; Enemy X position += 6
                        0004,ECE0,
                        EAD7,       ; Enemy X position += 6
                        0004,ED0F,
                        EAD7,       ; Enemy X position += 6
                        0004,ED3E,
                        EAD7,       ; Enemy X position += 6
                        0003,EC49,
                        EAD7,       ; Enemy X position += 6
                        0003,EC78,
                        EAD7,       ; Enemy X position += 6
                        0003,ECA7,
                        EAD7,       ; Enemy X position += 6
                        0002,ECE0,
                        EAD7,       ; Enemy X position += 6
                        0002,ED0F,
                        EAD7,       ; Enemy X position += 6
                        0002,ED3E,
                        EAD7        ; Enemy X position += 6
$B3:EA80             dw 0001,EC49,
                        EAD7,       ; Enemy X position += 6
                        0001,EC78,
                        EAD7,       ; Enemy X position += 6
                        0001,ECA7,
                        EAD7,       ; Enemy X position += 6
                        0001,ECE0,
                        EAD7,       ; Enemy X position += 6
                        0001,ED0F,
                        EAD7,       ; Enemy X position += 6
                        0001,ED3E,
                        EAD7,       ; Enemy X position += 6
                        80ED,EA80   ; Go to $EA80
}


;;; $EAA8: Instruction - go to [[Y]] if [acid Y position] < CEh ;;;
{
$B3:EAA8 AD 62 19    LDA $1962  [$7E:1962]
$B3:EAAB C9 CE 00    CMP #$00CE
$B3:EAAE B0 05       BCS $05    [$EAB5]
$B3:EAB0 B9 00 00    LDA $0000,y
$B3:EAB3 A8          TAY
$B3:EAB4 6B          RTL

$B3:EAB5 C8          INY
$B3:EAB6 C8          INY
$B3:EAB7 6B          RTL
}


;;; $EAB8: Instruction - go to [[Y]] if critters escaped ;;;
{
$B3:EAB8 A9 0F 00    LDA #$000F
$B3:EABB 22 33 82 80 JSL $808233[$80:8233]
$B3:EABF 90 05       BCC $05    [$EAC6]
$B3:EAC1 B9 00 00    LDA $0000,y[$B3:E9C6]
$B3:EAC4 A8          TAY
$B3:EAC5 6B          RTL

$B3:EAC6 C8          INY
$B3:EAC7 C8          INY
$B3:EAC8 6B          RTL
}


;;; $EAC9: Instruction - enemy X position -= 6 ;;;
{
$B3:EAC9 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:EACC BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$B3:EACF 38          SEC
$B3:EAD0 E9 06 00    SBC #$0006
$B3:EAD3 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$B3:EAD6 6B          RTL
}


;;; $EAD7: Instruction - enemy X position += 6 ;;;
{
$B3:EAD7 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:EADA BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$B3:EADD 18          CLC
$B3:EADE 69 06 00    ADC #$0006
$B3:EAE1 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$B3:EAE4 6B          RTL
}


;;; $EAE5: Initialisation AI - enemy $F313 (escape dachora) ;;;
{
$B3:EAE5 AE 54 0E    LDX $0E54  [$7E:0E54]
$B3:EAE8 A9 0F 00    LDA #$000F             ;\
$B3:EAEB 22 33 82 80 JSL $808233[$80:8233]  ;} If critters escaped:
$B3:EAEF 90 0A       BCC $0A    [$EAFB]     ;/
$B3:EAF1 BD 86 0F    LDA $0F86,x            ;\
$B3:EAF4 09 00 02    ORA #$0200             ;} Flag enemy for deletion
$B3:EAF7 9D 86 0F    STA $0F86,x            ;/
$B3:EAFA 6B          RTL                    ; Return

$B3:EAFB BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$B3:EAFE 09 00 20    ORA #$2000             ;} Set enemy to process instructions
$B3:EB01 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$B3:EB04 A9 4D 80    LDA #$804D             ;\
$B3:EB07 9D 8E 0F    STA $0F8E,x[$7E:0F8E]  ;} Enemy spritemap pointer = $804D
$B3:EB0A A9 01 00    LDA #$0001             ;\
$B3:EB0D 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$B3:EB10 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$B3:EB13 A9 64 E9    LDA #$E964             ;\
$B3:EB16 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $E964 (running around aimlessly - low tide)
$B3:EB19 6B          RTL
}


;;; $EB1A: RTL. Main AI - enemy $F313 (escape dachora) ;;;
{
$B3:EB1A 6B          RTL
}


;;; $EB1B: Escape dachora spritemaps ;;;
{
$B3:EB1B             dx 0009, 01F0,F2,3310, C3F8,EA,3301, 0002,F7,331E, 01FA,F7,330E, 01F2,03,331F, 01F2,FB,330F, 01F2,0F,3322, C3FA,07,3313, C3FA,FF,3303
$B3:EB4A             dx 0009, 01EF,F3,3310, C3F7,EB,3301, 0002,F8,335F, 01FA,F8,335E, 01F2,04,331F, 01F2,FC,330F, C3FA,08,3316, 01F2,08,3315, C3FA,00,3306
$B3:EB79             dx 000B, 01EE,F1,3310, C3F6,E9,3301, 01EA,0E,332D, 0002,F6,331E, 01FA,F6,330E, 01F2,FA,330F, C3FA,FE,3309, C3F2,FE,3308, 000A,0E,332B, 000A,06,331B, C3F2,06,3318
$B3:EBB2             dx 0009, 01F0,F2,3310, C3F8,EA,3301, 0002,F7,335F, 01FA,F7,335E, 01F2,0F,3352, 01F2,03,331F, 01F2,FB,330F, C3FA,07,3343, C3FA,FF,3333
$B3:EBE1             dx 0009, 01EF,F3,3310, C3F7,EB,3301, 01F4,10,3352, 01F2,04,331F, 01F2,FC,330F, 0002,F8,331E, 01FA,F8,330E, C3FA,08,3346, C3FA,00,3336
$B3:EC10             dx 000B, 01EE,F1,3310, C3F6,E9,3301, 0002,F6,335F, 01FA,F6,335E, 01EA,0E,335A, 01F2,FA,330F, C3FA,FE,3339, C3F2,06,3348, 000A,06,334B, 000A,0E,335B, C3F2,FE,3338
$B3:EC49             dx 0009, 0008,F2,7310, C3F8,EA,7301, 01F6,F7,731E, 01FE,F7,730E, 0006,03,731F, 0006,FB,730F, 0006,0F,7322, C3F6,07,7313, C3F6,FF,7303
$B3:EC78             dx 0009, 0009,F3,7310, C3F9,EB,7301, 01F6,F8,735F, 01FE,F8,735E, 0006,04,731F, 0006,FC,730F, C3F6,08,7316, 0006,08,7315, C3F6,00,7306
$B3:ECA7             dx 000B, 000A,F1,7310, C3FA,E9,7301, 000E,0E,732D, 01F6,F6,731E, 01FE,F6,730E, 0006,FA,730F, C3F6,FE,7309, C3FE,FE,7308, 01EE,0E,732B, 01EE,06,731B, C3FE,06,7318
$B3:ECE0             dx 0009, 0008,F2,7310, C3F8,EA,7301, 01F6,F7,735F, 01FE,F7,735E, 0006,0F,7352, 0006,03,731F, 0006,FB,730F, C3F6,07,7343, C3F6,FF,7333
$B3:ED0F             dx 0009, 0009,F3,7310, C3F9,EB,7301, 0004,10,7352, 0006,04,731F, 0006,FC,730F, 01F6,F8,731E, 01FE,F8,730E, C3F6,08,7346, C3F6,00,7336
$B3:ED3E             dx 000B, 000A,F1,7310, C3FA,E9,7301, 01F6,F6,735F, 01FE,F6,735E, 000E,0E,735A, 0006,FA,730F, C3F6,FE,7339, C3FE,06,7348, 01EE,06,734B, 01EE,0E,735B, C3FE,FE,7338
}
}


;;; $ED77: Free space ;;;
{
$B3:ED77             fillto $B48000, $FF
}
