;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687..8B08: Boulder ;;;
{
;;; $8687: Palette - enemy $DFBF (boulder) ;;;
{
$A6:8687             dw 3800, 49EF, 45CE, 3D8C, 396B, 3529, 2D08, 28C6, 20A5, 1C63, 2506, 1CC4, 1083, 0841, 6EF7, 0000
}


;;; $86A7: Instruction list -  ;;;
{
$A6:86A7             dx 0008,8A59,
                        0008,8A6F,
                        0008,8A85,
                        0008,8A9B,
                        0008,8AB1,
                        0008,8AC7,
                        0008,8ADD,
                        0008,8AF3,
                        80ED,86A7   ; Go to $86A7
}


;;; $86CB: Instruction list -  ;;;
{
$A6:86CB             dx 0008,8A59,
                        0008,8AF3,
                        0008,8ADD,
                        0008,8AC7,
                        0008,8AB1,
                        0008,8A9B,
                        0008,8A85,
                        0008,8A6F,
                        80ED,86CB   ; Go to $86CB
}


;;; $86EF:  ;;;
{
$A6:86EF             dw 0000, 1000, 1800
}


;;; $86F5: Initialisation AI - enemy $DFBF (boulder) ;;;
{
$A6:86F5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:86F8 9E AC 0F    STZ $0FAC,x[$7E:0FAC]
$A6:86FB A9 00 00    LDA #$0000
$A6:86FE 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A6:8701 A9 02 00    LDA #$0002
$A6:8704 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A6:8707 A9 9A 87    LDA #$879A
$A6:870A 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A6:870D BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A6:8710 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A6:8714 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A6:8717 9F 0A 78 7E STA $7E780A,x[$7E:780A]
$A6:871B 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A6:871F BD 80 0F    LDA $0F80,x[$7E:0F80]
$A6:8722 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A6:8726 BD B7 0F    LDA $0FB7,x[$7E:0FB7]
$A6:8729 29 FF 00    AND #$00FF
$A6:872C D0 07       BNE $07    [$8735]
$A6:872E A9 01 00    LDA #$0001
$A6:8731 9F 0E 78 7E STA $7E780E,x[$7E:794E]

$A6:8735 49 FF FF    EOR #$FFFF
$A6:8738 1A          INC A
$A6:8739 18          CLC
$A6:873A 7F 0A 78 7E ADC $7E780A,x[$7E:780A]
$A6:873E 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A6:8741 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A6:8744 29 FF 00    AND #$00FF
$A6:8747 49 FF FF    EOR #$FFFF
$A6:874A 1A          INC A
$A6:874B 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A6:874F BD 92 0F    LDA $0F92,x[$7E:0F92]
$A6:8752 29 FF 00    AND #$00FF
$A6:8755 9F 0C 78 7E STA $7E780C,x[$7E:780C]
$A6:8759 A9 A7 86    LDA #$86A7
$A6:875C 9D 92 0F    STA $0F92,x[$7E:0F92]
$A6:875F BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A6:8762 29 FF 00    AND #$00FF
$A6:8765 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A6:8768 D0 12       BNE $12    [$877C]
$A6:876A BF 00 78 7E LDA $7E7800,x[$7E:7940]
$A6:876E 49 FF FF    EOR #$FFFF
$A6:8771 1A          INC A
$A6:8772 9F 00 78 7E STA $7E7800,x[$7E:7940]
$A6:8776 A9 CB 86    LDA #$86CB
$A6:8779 9D 92 0F    STA $0F92,x[$7E:10D2]

$A6:877C A9 02 00    LDA #$0002
$A6:877F 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A6:8783 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A6:8786 29 FF 00    AND #$00FF
$A6:8789 F0 07       BEQ $07    [$8792]
$A6:878B A9 05 00    LDA #$0005
$A6:878E 9F 02 78 7E STA $7E7802,x

$A6:8792 6B          RTL
}


;;; $8793: Main AI - enemy $DFBF (boulder) ;;;
{
$A6:8793 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8796 FC A8 0F    JSR ($0FA8,x)[$A6:879A]
$A6:8799 6B          RTL
}


;;; $879A:  ;;;
{
$A6:879A AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:879D 22 DD AE A0 JSL $A0AEDD[$A0:AEDD]  ;\
$A6:87A1 30 49       BMI $49    [$87EC]     ;} If [Samus Y position] < [enemy Y position]: return
$A6:87A3 DF 0C 78 7E CMP $7E780C,x[$7E:780C]
$A6:87A7 10 43       BPL $43    [$87EC]
$A6:87A9 BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A6:87AC D0 20       BNE $20    [$87CE]
$A6:87AE 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A6:87B2 30 38       BMI $38    [$87EC]     ;} If [Samus X position] < [enemy X position]: return
$A6:87B4 DF 00 78 7E CMP $7E7800,x[$7E:79C0]
$A6:87B8 10 32       BPL $32    [$87EC]
$A6:87BA A9 ED 87    LDA #$87ED
$A6:87BD 9D A8 0F    STA $0FA8,x[$7E:1168]
$A6:87C0 BF 0E 78 7E LDA $7E780E,x[$7E:79CE]
$A6:87C4 F0 26       BEQ $26    [$87EC]
$A6:87C6 A9 42 89    LDA #$8942
$A6:87C9 9D A8 0F    STA $0FA8,x[$7E:1168]
$A6:87CC 80 1E       BRA $1E    [$87EC]

$A6:87CE 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A6:87D2 10 18       BPL $18    [$87EC]     ;} If [Samus X position] >= [enemy X position]: return
$A6:87D4 DF 00 78 7E CMP $7E7800,x[$7E:7800]
$A6:87D8 30 12       BMI $12    [$87EC]
$A6:87DA A9 ED 87    LDA #$87ED
$A6:87DD 9D A8 0F    STA $0FA8,x[$7E:1028]
$A6:87E0 BF 0E 78 7E LDA $7E780E,x[$7E:788E]
$A6:87E4 F0 06       BEQ $06    [$87EC]
$A6:87E6 A9 42 89    LDA #$8942
$A6:87E9 9D A8 0F    STA $0FA8,x[$7E:1128]

$A6:87EC 60          RTS
}


;;; $87ED:  ;;;
{
$A6:87ED AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:87F0 BD AC 0F    LDA $0FAC,x[$7E:102C]
$A6:87F3 29 00 FF    AND #$FF00
$A6:87F6 EB          XBA
$A6:87F7 0A          ASL A
$A6:87F8 0A          ASL A
$A6:87F9 0A          ASL A
$A6:87FA A8          TAY
$A6:87FB 20 3A 8A    JSR $8A3A  [$A6:8A3A]
$A6:87FE BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A6:8801 DF 0A 78 7E CMP $7E780A,x[$7E:788A]
$A6:8805 30 15       BMI $15    [$881C]
$A6:8807 BF 0A 78 7E LDA $7E780A,x[$7E:788A]
$A6:880B 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A6:880E A9 32 88    LDA #$8832
$A6:8811 9D A8 0F    STA $0FA8,x[$7E:1028]
$A6:8814 A9 00 20    LDA #$2000
$A6:8817 9D AC 0F    STA $0FAC,x[$7E:102C]
$A6:881A 80 15       BRA $15    [$8831]

$A6:881C BD AC 0F    LDA $0FAC,x[$7E:102C]
$A6:881F 18          CLC
$A6:8820 69 00 01    ADC #$0100
$A6:8823 9D AC 0F    STA $0FAC,x[$7E:102C]
$A6:8826 C9 00 50    CMP #$5000
$A6:8829 30 06       BMI $06    [$8831]
$A6:882B A9 00 50    LDA #$5000
$A6:882E 9D AC 0F    STA $0FAC,x

$A6:8831 60          RTS
}


;;; $8832:  ;;;
{
$A6:8832 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8835 BD AC 0F    LDA $0FAC,x[$7E:102C]
$A6:8838 29 00 FF    AND #$FF00
$A6:883B EB          XBA
$A6:883C 0A          ASL A
$A6:883D 0A          ASL A
$A6:883E 0A          ASL A
$A6:883F 1A          INC A
$A6:8840 1A          INC A
$A6:8841 1A          INC A
$A6:8842 1A          INC A
$A6:8843 A8          TAY
$A6:8844 20 3A 8A    JSR $8A3A  [$A6:8A3A]
$A6:8847 BD AC 0F    LDA $0FAC,x[$7E:102C]
$A6:884A 38          SEC
$A6:884B E9 00 01    SBC #$0100
$A6:884E 9D AC 0F    STA $0FAC,x[$7E:102C]
$A6:8851 10 0B       BPL $0B    [$885E]
$A6:8853 9E AC 0F    STZ $0FAC,x[$7E:102C]
$A6:8856 A9 8B 88    LDA #$888B
$A6:8859 9D A8 0F    STA $0FA8,x[$7E:1028]
$A6:885C 80 2C       BRA $2C    [$888A]

$A6:885E BD AA 0F    LDA $0FAA,x[$7E:102A]
$A6:8861 29 00 FF    AND #$FF00
$A6:8864 EB          XBA
$A6:8865 0A          ASL A
$A6:8866 0A          ASL A
$A6:8867 0A          ASL A
$A6:8868 A8          TAY
$A6:8869 BD B0 0F    LDA $0FB0,x[$7E:1030]
$A6:886C F0 04       BEQ $04    [$8872]
$A6:886E C8          INY
$A6:886F C8          INY
$A6:8870 C8          INY
$A6:8871 C8          INY

$A6:8872 20 00 8A    JSR $8A00  [$A6:8A00]
$A6:8875 BD AA 0F    LDA $0FAA,x[$7E:102A]
$A6:8878 18          CLC
$A6:8879 69 20 00    ADC #$0020
$A6:887C 9D AA 0F    STA $0FAA,x[$7E:102A]
$A6:887F C9 00 50    CMP #$5000
$A6:8882 30 06       BMI $06    [$888A]
$A6:8884 A9 00 50    LDA #$5000
$A6:8887 9D AA 0F    STA $0FAA,x

$A6:888A 60          RTS
}


;;; $888B:  ;;;
{
$A6:888B AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:888E BD AC 0F    LDA $0FAC,x[$7E:102C]  ;\
$A6:8891 29 00 FF    AND #$FF00             ;|
$A6:8894 EB          XBA                    ;|
$A6:8895 0A          ASL A                  ;} Y = [enemy $0FAC] / 100h * 8 (quadratic speed table index)
$A6:8896 0A          ASL A                  ;|
$A6:8897 0A          ASL A                  ;|
$A6:8898 A8          TAY                    ;/
$A6:8899 B9 8F 83    LDA $838F,y[$A6:838F]  ;\
$A6:889C 85 12       STA $12    [$7E:0012]  ;|
$A6:889E B9 91 83    LDA $8391,y[$A6:8391]  ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A6:88A1 85 14       STA $14    [$7E:0014]  ;/
$A6:88A3 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A6:88A7 90 62       BCC $62    [$890B]     ; If not collided with block: go to BRANCH_NO_COLLISION
$A6:88A9 A9 42 00    LDA #$0042             ;\
$A6:88AC 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 42h, sound library 2, max queued sounds allowed = 6 (boulder explodes - initial)
$A6:88B0 BD B0 0F    LDA $0FB0,x[$7E:1030]
$A6:88B3 C9 02 00    CMP #$0002
$A6:88B6 D0 26       BNE $26    [$88DE]
$A6:88B8 BD 86 0F    LDA $0F86,x[$7E:1006]
$A6:88BB 09 00 02    ORA #$0200
$A6:88BE 9D 86 0F    STA $0F86,x[$7E:1006]
$A6:88C1 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]
$A6:88C4 85 12       STA $12    [$7E:0012]
$A6:88C6 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A6:88C9 85 14       STA $14    [$7E:0014]
$A6:88CB A9 11 00    LDA #$0011             ; A = 11h (rock particles)
$A6:88CE A0 09 E5    LDY #$E509             ;\
$A6:88D1 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A6:88D5 A9 43 00    LDA #$0043             ;\
$A6:88D8 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 43h, sound library 2, max queued sounds allowed = 6 (boulder explodes - continued)
$A6:88DC 80 63       BRA $63    [$8941]

$A6:88DE A9 32 88    LDA #$8832
$A6:88E1 9D A8 0F    STA $0FA8,x
$A6:88E4 BD AE 0F    LDA $0FAE,x
$A6:88E7 3A          DEC A
$A6:88E8 0A          ASL A
$A6:88E9 A8          TAY
$A6:88EA B9 F1 86    LDA $86F1,y
$A6:88ED 9D AC 0F    STA $0FAC,x
$A6:88F0 DE AE 0F    DEC $0FAE,x
$A6:88F3 10 4C       BPL $4C    [$8941]
$A6:88F5 BD 7E 0F    LDA $0F7E,x
$A6:88F8 9F 06 78 7E STA $7E7806,x
$A6:88FC BD 80 0F    LDA $0F80,x
$A6:88FF 9F 04 78 7E STA $7E7804,x
$A6:8903 A9 42 89    LDA #$8942
$A6:8906 9D A8 0F    STA $0FA8,x
$A6:8909 80 36       BRA $36    [$8941]

; BRANCH_NO_COLLISION
$A6:890B BD AC 0F    LDA $0FAC,x[$7E:102C]
$A6:890E 18          CLC
$A6:890F 69 00 01    ADC #$0100
$A6:8912 9D AC 0F    STA $0FAC,x[$7E:102C]
$A6:8915 BD AA 0F    LDA $0FAA,x[$7E:102A]
$A6:8918 29 00 FF    AND #$FF00
$A6:891B EB          XBA
$A6:891C 0A          ASL A
$A6:891D 0A          ASL A
$A6:891E 0A          ASL A
$A6:891F A8          TAY
$A6:8920 BD B0 0F    LDA $0FB0,x[$7E:1030]
$A6:8923 F0 04       BEQ $04    [$8929]
$A6:8925 C8          INY
$A6:8926 C8          INY
$A6:8927 C8          INY
$A6:8928 C8          INY

$A6:8929 20 00 8A    JSR $8A00  [$A6:8A00]
$A6:892C BD AA 0F    LDA $0FAA,x[$7E:102A]
$A6:892F 18          CLC
$A6:8930 69 20 00    ADC #$0020
$A6:8933 9D AA 0F    STA $0FAA,x[$7E:102A]
$A6:8936 C9 00 50    CMP #$5000
$A6:8939 30 06       BMI $06    [$8941]
$A6:893B A9 00 50    LDA #$5000
$A6:893E 9D AA 0F    STA $0FAA,x

$A6:8941 60          RTS
}


;;; $8942:  ;;;
{
$A6:8942 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8945 BD AA 0F    LDA $0FAA,x[$7E:116A]  ;\
$A6:8948 29 00 FF    AND #$FF00             ;|
$A6:894B EB          XBA                    ;|
$A6:894C 0A          ASL A                  ;} Y = [enemy $0FAA] / 100h * 8 (quadratic speed table index)
$A6:894D 0A          ASL A                  ;|
$A6:894E 0A          ASL A                  ;|
$A6:894F A8          TAY                    ;/
$A6:8950 B9 8F 83    LDA $838F,y[$A6:838F]  ;\
$A6:8953 85 12       STA $12    [$7E:0012]  ;|
$A6:8955 B9 91 83    LDA $8391,y[$A6:8391]  ;|
$A6:8958 18          CLC                    ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]] + [enemy $7E:7802]
$A6:8959 7F 02 78 7E ADC $7E7802,x[$7E:79C2];|
$A6:895D 85 14       STA $14    [$7E:0014]  ;/
$A6:895F 5A          PHY
$A6:8960 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A6:8964 7A          PLY
$A6:8965 BD 7E 0F    LDA $0F7E,x[$7E:113E]  ;\
$A6:8968 38          SEC                    ;|
$A6:8969 FF 02 78 7E SBC $7E7802,x[$7E:79C2];} Enemy Y position -= [enemy $7E:7802]
$A6:896D 9D 7E 0F    STA $0F7E,x[$7E:113E]  ;/
$A6:8970 BD B0 0F    LDA $0FB0,x[$7E:1170]  
$A6:8973 F0 04       BEQ $04    [$8979]
$A6:8975 C8          INY
$A6:8976 C8          INY
$A6:8977 C8          INY
$A6:8978 C8          INY

$A6:8979 B9 8F 83    LDA $838F,y[$A6:838F]  ;\
$A6:897C 85 12       STA $12    [$7E:0012]  ;|
$A6:897E B9 91 83    LDA $8391,y[$A6:8391]  ;} Move enemy right by [$838F + [Y] + 2].[$838F + [Y]]
$A6:8981 85 14       STA $14    [$7E:0014]  ;|
$A6:8983 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A6:8987 90 36       BCC $36    [$89BF]     ; If collided with wall:
$A6:8989 BD 86 0F    LDA $0F86,x[$7E:1146]
$A6:898C 09 00 01    ORA #$0100
$A6:898F 09 00 02    ORA #$0200
$A6:8992 9D 86 0F    STA $0F86,x[$7E:1146]
$A6:8995 A9 FC 89    LDA #$89FC
$A6:8998 9D A8 0F    STA $0FA8,x[$7E:1168]
$A6:899B A9 42 00    LDA #$0042             ;\
$A6:899E 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 42h, sound library 2, max queued sounds allowed = 6 (boulder explodes - initial)
$A6:89A2 BD 7A 0F    LDA $0F7A,x[$7E:113A]
$A6:89A5 85 12       STA $12    [$7E:0012]
$A6:89A7 BD 7E 0F    LDA $0F7E,x[$7E:113E]
$A6:89AA 85 14       STA $14    [$7E:0014]
$A6:89AC A9 11 00    LDA #$0011             ; A = 11h (rock particles)
$A6:89AF A0 09 E5    LDY #$E509             ;\
$A6:89B2 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A6:89B6 A9 43 00    LDA #$0043             ;\
$A6:89B9 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 43h, sound library 2, max queued sounds allowed = 6 (boulder explodes - continued)
$A6:89BD 80 2E       BRA $2E    [$89ED]

$A6:89BF BD AA 0F    LDA $0FAA,x[$7E:116A]
$A6:89C2 18          CLC
$A6:89C3 69 40 00    ADC #$0040
$A6:89C6 9D AA 0F    STA $0FAA,x[$7E:116A]
$A6:89C9 C9 00 40    CMP #$4000
$A6:89CC 30 06       BMI $06    [$89D4]
$A6:89CE A9 00 40    LDA #$4000
$A6:89D1 9D AA 0F    STA $0FAA,x

$A6:89D4 BD 7E 0F    LDA $0F7E,x[$7E:113E]
$A6:89D7 DF 06 78 7E CMP $7E7806,x[$7E:79C6]
$A6:89DB D0 10       BNE $10    [$89ED]
$A6:89DD BD 80 0F    LDA $0F80,x[$7E:1140]
$A6:89E0 DF 04 78 7E CMP $7E7804,x[$7E:79C4]
$A6:89E4 D0 07       BNE $07    [$89ED]
$A6:89E6 A9 00 00    LDA #$0000
$A6:89E9 9F 02 78 7E STA $7E7802,x[$7E:79C2]

$A6:89ED BD 7E 0F    LDA $0F7E,x[$7E:113E]
$A6:89F0 9F 06 78 7E STA $7E7806,x[$7E:79C6]
$A6:89F4 BD 80 0F    LDA $0F80,x[$7E:1140]
$A6:89F7 9F 04 78 7E STA $7E7804,x[$7E:79C4]
$A6:89FB 60          RTS
}


;;; $89FC:  ;;;
{
$A6:89FC AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:89FF 60          RTS
}


;;; $8A00:  ;;;
{
$A6:8A00 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8A03 BD 7C 0F    LDA $0F7C,x[$7E:0FFC]  ;\
$A6:8A06 18          CLC                    ;|
$A6:8A07 79 8F 83    ADC $838F,y[$A6:8393]  ;|
$A6:8A0A 90 03       BCC $03    [$8A0F]     ;|
$A6:8A0C FE 7A 0F    INC $0F7A,x[$7E:0FFA]  ;|
                                            ;} Enemy X position += [$838F + [Y] + 2].[$838F + [Y]]
$A6:8A0F 9D 7C 0F    STA $0F7C,x[$7E:0FFC]  ;|
$A6:8A12 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;|
$A6:8A15 18          CLC                    ;|
$A6:8A16 79 91 83    ADC $8391,y[$A6:8395]  ;|
$A6:8A19 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A6:8A1C 60          RTS
}


;;; $8A1D:  ;;;
{
$A6:8A1D AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8A20 BD 7C 0F    LDA $0F7C,x            ;\
$A6:8A23 18          CLC                    ;|
$A6:8A24 79 89 81    ADC $8189,y            ;|
$A6:8A27 90 03       BCC $03    [$8A2C]     ;|
$A6:8A29 FE 7A 0F    INC $0F7A,x            ;|
                                            ;} Enemy X position += [$8187 + [Y] + 2].[$8187 + [Y]]
$A6:8A2C 9D 7C 0F    STA $0F7C,x            ;|
$A6:8A2F BD 7A 0F    LDA $0F7A,x            ;|
$A6:8A32 18          CLC                    ;|
$A6:8A33 79 87 81    ADC $8187,y            ;|
$A6:8A36 9D 7A 0F    STA $0F7A,x            ;/
$A6:8A39 60          RTS
}


;;; $8A3A:  ;;;
{
$A6:8A3A AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8A3D BD 80 0F    LDA $0F80,x[$7E:1000]  ;\
$A6:8A40 18          CLC                    ;|
$A6:8A41 79 8F 83    ADC $838F,y[$A6:838F]  ;|
$A6:8A44 90 03       BCC $03    [$8A49]     ;|
$A6:8A46 FE 7E 0F    INC $0F7E,x[$7E:0FFE]  ;|
                                            ;} Enemy Y position += [$838F + [Y] + 2].[$838F + [Y]]
$A6:8A49 9D 80 0F    STA $0F80,x[$7E:1000]  ;|
$A6:8A4C BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;|
$A6:8A4F 18          CLC                    ;|
$A6:8A50 79 91 83    ADC $8391,y[$A6:8391]  ;|
$A6:8A53 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A6:8A56 60          RTS
}


;;; $8A57: RTL ;;;
{
$A6:8A57 6B          RTL
}


;;; $8A58: RTL ;;;
{
$A6:8A58 6B          RTL
}


;;; $8A59: Boulder spritemaps ;;;
{
$A6:8A59             dx 0004, 8000,00,2122, 81F0,00,2120, 8000,F0,2102, 81F0,F0,2100
$A6:8A6F             dx 0004, 8000,00,2162, 81F0,00,2160, 8000,F0,2142, 81F0,F0,2140
$A6:8A85             dx 0004, 8000,00,2126, 81F0,00,2124, 8000,F0,2106, 81F0,F0,2104
$A6:8A9B             dx 0004, 8000,00,2166, 81F0,00,2164, 8000,F0,2146, 81F0,F0,2144
$A6:8AB1             dx 0004, 8000,00,212A, 81F0,00,2128, 8000,F0,210A, 81F0,F0,2108
$A6:8AC7             dx 0004, 8000,00,216A, 81F0,00,2168, 8000,F0,214A, 81F0,F0,2148
$A6:8ADD             dx 0004, 8000,00,212E, 81F0,00,212C, 8000,F0,210E, 81F0,F0,210C
$A6:8AF3             dx 0004, 8000,00,216E, 81F0,00,216C, 8000,F0,214E, 81F0,F0,214C
}
}


;;; $8B09..8CFA: Spikey platform ;;;
{
;;; $8B09: Palette - enemy $DFFF/$E03F (spikey platform) ;;;
{
$A6:8B09             dw 3800, 62BA, 49F3, 2D4D, 0C44, 49F3, 356E, 20C9, 1486, 241F, 1C17, 142F, 0C47, 0000, 0000, 0000
}


;;; $8B29: Instruction list -  ;;;
{
$A6:8B29             dx 0001,8CE5,
                        812F        ; Sleep
}


;;; $8B2F: Initialisation AI - enemy $DFFF (spikey platform top) ;;;
{
$A6:8B2F AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8B32 A9 29 8B    LDA #$8B29             ;\
$A6:8B35 9D 92 0F    STA $0F92,x[$7E:14D2]  ;} Enemy instruction list pointer = $8B29
$A6:8B38 A9 B4 8B    LDA #$8BB4             ;\
$A6:8B3B 9D A8 0F    STA $0FA8,x[$7E:14E8]  ;} Enemy function = $8BB4
$A6:8B3E BD B4 0F    LDA $0FB4,x[$7E:14F4]  ;\
$A6:8B41 29 FF 00    AND #$00FF             ;|
$A6:8B44 0A          ASL A                  ;|
$A6:8B45 0A          ASL A                  ;} Enemy $7E:7804 = [enemy parameter 1 low] * 8
$A6:8B46 0A          ASL A                  ;|
$A6:8B47 9F 04 78 7E STA $7E7804,x[$7E:7D44];/
$A6:8B4B AA          TAX                    ;\
$A6:8B4C BD 87 81    LDA $8187,x[$A6:8187]  ;|
$A6:8B4F 85 12       STA $12    [$7E:0012]  ;|
$A6:8B51 BD 89 81    LDA $8189,x[$A6:8189]  ;|
$A6:8B54 85 14       STA $14    [$7E:0014]  ;} Enemy $0FB0 = [$8189 + [enemy $7E:7804]]
$A6:8B56 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Enemy $0FB2 = [$8187 + [enemy $7E:7804]]
$A6:8B59 A5 14       LDA $14    [$7E:0014]  ;|
$A6:8B5B 9D B0 0F    STA $0FB0,x[$7E:14F0]  ;|
$A6:8B5E A5 12       LDA $12    [$7E:0012]  ;|
$A6:8B60 9D B2 0F    STA $0FB2,x[$7E:14F2]  ;/
$A6:8B63 BD B6 0F    LDA $0FB6,x[$7E:14F6]  ;\
$A6:8B66 29 00 FF    AND #$FF00             ;|
$A6:8B69 EB          XBA                    ;|
$A6:8B6A 18          CLC                    ;} Enemy $0FAE = [enemy Y position] + [enemy parameter 2 high]
$A6:8B6B 7D 7E 0F    ADC $0F7E,x[$7E:14BE]  ;|
$A6:8B6E 9D AE 0F    STA $0FAE,x[$7E:14EE]  ;/
$A6:8B71 BD 7E 0F    LDA $0F7E,x[$7E:14BE]  ;\
$A6:8B74 9D AC 0F    STA $0FAC,x[$7E:14EC]  ;} Enemy $0FAC = [enemy Y position]
$A6:8B77 BD B6 0F    LDA $0FB6,x[$7E:14F6]  ;\
$A6:8B7A 29 FF 00    AND #$00FF             ;|
$A6:8B7D 9F 00 78 7E STA $7E7800,x[$7E:7D40];} Enemy $0FAA = enemy $7E:7800 = [enemy parameter 2 low]
$A6:8B81 9D AA 0F    STA $0FAA,x[$7E:14EA]  ;/
$A6:8B84 6B          RTL
}


;;; $8B85: Initialisation AI - enemy $E03F (spikey platform bottom) ;;;
{
$A6:8B85 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8B88 BD 3A 0F    LDA $0F3A,x[$7E:14BA]  ;\
$A6:8B8B 9D 7A 0F    STA $0F7A,x[$7E:14FA]  ;} Enemy X position = [enemy ([X] - 1) X position]
$A6:8B8E BD 3E 0F    LDA $0F3E,x[$7E:14BE]  ;\
$A6:8B91 18          CLC                    ;|
$A6:8B92 69 0C 00    ADC #$000C             ;} Enemy Y position = [enemy ([X] - 1) X position] + Ch
$A6:8B95 9D 7E 0F    STA $0F7E,x[$7E:14FE]  ;/
$A6:8B98 6B          RTL
}


;;; $8B99: Main AI - enemy $E03F (spikey platform bottom) ;;;
{
$A6:8B99 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8B9C BD 3A 0F    LDA $0F3A,x[$7E:123A]  ;\
$A6:8B9F 9D 7A 0F    STA $0F7A,x[$7E:127A]  ;} Enemy X position = [enemy ([X] - 1) X position]
$A6:8BA2 BD 3E 0F    LDA $0F3E,x[$7E:123E]  ;\
$A6:8BA5 18          CLC                    ;|
$A6:8BA6 69 0C 00    ADC #$000C             ;} Enemy Y position = [enemy ([X] - 1) X position] + Ch
$A6:8BA9 9D 7E 0F    STA $0F7E,x[$7E:127E]  ;/
$A6:8BAC 6B          RTL
}


;;; $8BAD: Main AI - enemy $DFFF (spikey platform top) ;;;
{
$A6:8BAD AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8BB0 FC A8 0F    JSR ($0FA8,x)[$A6:8BB4]; Execute [enemy function]
$A6:8BB3 6B          RTL
}


;;; $8BB4: Spikey platform function -  ;;;
{
$A6:8BB4 DA          PHX
$A6:8BB5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8BB8 DE AA 0F    DEC $0FAA,x[$7E:126A]  ; Decrement enemy $0FAA
$A6:8BBB BD AA 0F    LDA $0FAA,x[$7E:126A]  ;\
$A6:8BBE D0 1A       BNE $1A    [$8BDA]     ;} If [enemy $0FAA] != 0: return
$A6:8BC0 BF 00 78 7E LDA $7E7800,x[$7E:7AC0];\
$A6:8BC4 9D AA 0F    STA $0FAA,x[$7E:126A]  ;} Enemy $0FAA = [enemy $7E:7800]
$A6:8BC7 BD B4 0F    LDA $0FB4,x[$7E:1274]  ;\
$A6:8BCA 29 FF 00    AND #$00FF             ;|
$A6:8BCD 0A          ASL A                  ;|
$A6:8BCE 0A          ASL A                  ;} Enemy $7E:7804 = [enemy parameter 1 low] * 8
$A6:8BCF 0A          ASL A                  ;|
$A6:8BD0 9F 04 78 7E STA $7E7804,x[$7E:7AC4];/
$A6:8BD4 A9 DC 8B    LDA #$8BDC             ;\
$A6:8BD7 9D A8 0F    STA $0FA8,x[$7E:1268]  ;} Enemy function = $8BDC

$A6:8BDA FA          PLX
$A6:8BDB 60          RTS
}


;;; $8BDC: Spikey platform function -  ;;;
{
$A6:8BDC DA          PHX
$A6:8BDD AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8BE0 BD 7E 0F    LDA $0F7E,x[$7E:123E]
$A6:8BE3 9F 02 78 7E STA $7E7802,x[$7E:7AC2]
$A6:8BE7 BF 04 78 7E LDA $7E7804,x[$7E:7AC4]
$A6:8BEB AA          TAX
$A6:8BEC BD 87 81    LDA $8187,x[$A6:8287]  ;\
$A6:8BEF 85 14       STA $14    [$7E:0014]  ;|
$A6:8BF1 BD 89 81    LDA $8189,x[$A6:8289]  ;|
$A6:8BF4 85 12       STA $12    [$7E:0012]  ;} Enemy Y position += [$8187 + [X]].[$8187 + [X] + 2]
$A6:8BF6 AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A6:8BF9 22 90 AF A0 JSL $A0AF90[$A0:AF90]  ;/
$A6:8BFD BD 7E 0F    LDA $0F7E,x[$7E:123E]
$A6:8C00 DD AE 0F    CMP $0FAE,x[$7E:126E]
$A6:8C03 30 1A       BMI $1A    [$8C1F]
$A6:8C05 A9 40 00    LDA #$0040
$A6:8C08 9F 06 78 7E STA $7E7806,x[$7E:7AC6]
$A6:8C0C A9 4A 8C    LDA #$8C4A
$A6:8C0F 9D A8 0F    STA $0FA8,x[$7E:1268]
$A6:8C12 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8C15 9D 7E 0F    STA $0F7E,x[$7E:123E]
$A6:8C18 A9 1B 00    LDA #$001B             ;\
$A6:8C1B 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 1Bh, sound library 2, max queued sounds allowed = 6 (spikey platform stops)

$A6:8C1F 22 A1 8C A6 JSL $A68CA1[$A6:8CA1]
$A6:8C23 F0 0F       BEQ $0F    [$8C34]
$A6:8C25 BD 7E 0F    LDA $0F7E,x[$7E:13BE]  ;\
$A6:8C28 38          SEC                    ;|
$A6:8C29 FF 02 78 7E SBC $7E7802,x[$7E:7C42];|
$A6:8C2D 18          CLC                    ;} Extra Samus Y displacement += [enemy Y position] - [enemy $7E:7802]
$A6:8C2E 6D 5C 0B    ADC $0B5C  [$7E:0B5C]  ;|
$A6:8C31 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/

$A6:8C34 BF 04 78 7E LDA $7E7804,x[$7E:7AC4]
$A6:8C38 18          CLC
$A6:8C39 69 08 00    ADC #$0008
$A6:8C3C C9 00 02    CMP #$0200
$A6:8C3F 30 03       BMI $03    [$8C44]
$A6:8C41 A9 00 02    LDA #$0200

$A6:8C44 9F 04 78 7E STA $7E7804,x[$7E:7AC4]
$A6:8C48 FA          PLX
$A6:8C49 60          RTS
}


;;; $8C4A: Spikey platform function -  ;;;
{
$A6:8C4A BF 06 78 7E LDA $7E7806,x[$7E:7AC6]
$A6:8C4E 3A          DEC A
$A6:8C4F 9F 06 78 7E STA $7E7806,x[$7E:7AC6]
$A6:8C53 F0 01       BEQ $01    [$8C56]
$A6:8C55 60          RTS

$A6:8C56 A9 5D 8C    LDA #$8C5D
$A6:8C59 9D A8 0F    STA $0FA8,x[$7E:12E8]
$A6:8C5C 60          RTS
}


;;; $8C5D: Spikey platform function -  ;;;
{
$A6:8C5D DA          PHX
$A6:8C5E AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8C61 BD 7E 0F    LDA $0F7E,x[$7E:12BE]
$A6:8C64 9F 02 78 7E STA $7E7802,x[$7E:7B42]
$A6:8C68 A9 00 80    LDA #$8000             ;\
$A6:8C6B 85 12       STA $12    [$7E:0012]  ;|
$A6:8C6D A9 00 00    LDA #$0000             ;} Enemy Y position -= 0.8000h
$A6:8C70 85 14       STA $14    [$7E:0014]  ;|
$A6:8C72 22 7E AF A0 JSL $A0AF7E[$A0:AF7E]  ;/
$A6:8C76 BD 7E 0F    LDA $0F7E,x[$7E:12BE]
$A6:8C79 DD AC 0F    CMP $0FAC,x[$7E:12EC]
$A6:8C7C 10 0C       BPL $0C    [$8C8A]
$A6:8C7E A9 B4 8B    LDA #$8BB4
$A6:8C81 9D A8 0F    STA $0FA8,x[$7E:13E8]
$A6:8C84 BD AC 0F    LDA $0FAC,x[$7E:13EC]
$A6:8C87 9D 7E 0F    STA $0F7E,x[$7E:13BE]

$A6:8C8A 22 A1 8C A6 JSL $A68CA1[$A6:8CA1]
$A6:8C8E F0 0F       BEQ $0F    [$8C9F]
$A6:8C90 BD 7E 0F    LDA $0F7E,x[$7E:12BE]  ;\
$A6:8C93 38          SEC                    ;|
$A6:8C94 FF 02 78 7E SBC $7E7802,x[$7E:7B42];|
$A6:8C98 18          CLC                    ;} Extra Samus Y displacement += [enemy Y position] - [enemy $7E:7802]
$A6:8C99 6D 5C 0B    ADC $0B5C  [$7E:0B5C]  ;|
$A6:8C9C 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/

$A6:8C9F FA          PLX
$A6:8CA0 60          RTS
}


;;; $8CA1:  ;;;
{
$A6:8CA1 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:8CA4 38          SEC
$A6:8CA5 FD 7A 0F    SBC $0F7A,x[$7E:123A]
$A6:8CA8 10 04       BPL $04    [$8CAE]
$A6:8CAA 49 FF FF    EOR #$FFFF
$A6:8CAD 1A          INC A

$A6:8CAE 38          SEC
$A6:8CAF ED FE 0A    SBC $0AFE  [$7E:0AFE]
$A6:8CB2 90 09       BCC $09    [$8CBD]
$A6:8CB4 DD 82 0F    CMP $0F82,x[$7E:1242]
$A6:8CB7 90 04       BCC $04    [$8CBD]
$A6:8CB9 A9 00 00    LDA #$0000
$A6:8CBC 6B          RTL

$A6:8CBD AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A6:8CC0 18          CLC
$A6:8CC1 69 05 00    ADC #$0005
$A6:8CC4 38          SEC
$A6:8CC5 FD 7E 0F    SBC $0F7E,x[$7E:12BE]
$A6:8CC8 10 11       BPL $11    [$8CDB]
$A6:8CCA 49 FF FF    EOR #$FFFF
$A6:8CCD 1A          INC A
$A6:8CCE 38          SEC
$A6:8CCF ED 00 0B    SBC $0B00  [$7E:0B00]
$A6:8CD2 90 0B       BCC $0B    [$8CDF]
$A6:8CD4 DD 84 0F    CMP $0F84,x[$7E:12C4]
$A6:8CD7 F0 06       BEQ $06    [$8CDF]
$A6:8CD9 90 04       BCC $04    [$8CDF]

$A6:8CDB A9 00 00    LDA #$0000
$A6:8CDE 6B          RTL

$A6:8CDF A9 FF FF    LDA #$FFFF
$A6:8CE2 6B          RTL
}


;;; $8CE3: RTL ;;;
{
$A6:8CE3 6B          RTL
}


;;; $8CE4: RTL ;;;
{
$A6:8CE4 6B          RTL
}


;;; $8CE5: Spikey platform spritemap ;;;
{
$A6:8CE5             dx 0004, 8000,04,2106, 81F0,04,2104, 8000,F4,2102, 81F0,F4,2100
}
}


;;; $8CFB..946F: Fire geyser ;;;
{
;;; $8CFB: Palette - enemy $E07F (fire geyser) ;;;
{
$A6:8CFB             dw 3800, 3E7F, 2DFD, 10FB, 0097, 73FF, 53FF, 37FF, 17FF, 24DF, 189B, 1076, 0C50, 084B, 5EFF, 0880
}


;;; $8D1B: Instruction list -  ;;;
{
$A6:8D1B             dx 8DAF,       ; Play fire geyser sound effect
                        0002,9082,
                        8E13,       ; ???
                        0002,9089,
                        8E2D,       ; ???
                        0002,909F,
                        8E41,       ; ???
                        0002,90BA,
                        8E55,       ; ???
                        0001,90DA,
                        8E69,       ; ???
                        0001,90FF,
                        8E7D,       ; ???
                        0001,9124,
                        8E91,       ; ???
                        0001,9149,
                        8EA5,       ; ???
                        0002,916E,
                        8EB9,       ; ???
                        0002,9198,
                        8ECD,       ; ???
                        0002,91C2,
                        8EE1,       ; ???
                        0002,91F1,
                        8EF5,       ; ???
                        0002,9234,
                        8F09,       ; ???
                        0002,927C,
                        8F1D,       ; ???
                        0002,92C4,
                        8F31,       ; ???
                        0002,9302,
                        8F45,       ; ???
                        0004,934A,
                        8F59,       ; ???
                        0004,938D,
                        8F6D,       ; ???
                        0004,93CB,
                        8F81,       ; ???
                        0004,9404,
                        8F95,       ; ???
                        0004,942E,
                        8FA9,       ; ???
                        0004,944E,
                        8FBD,       ; ???
                        0004,9469,
                        8FD1,       ; ???
                        812F        ; Sleep
}


;;; $8DA9: Instruction list -  ;;;
{
$A6:8DA9             dx 0002,9082,
                        812F        ; Sleep
}


;;; $8DAF: Instruction - play fire geyser sound effect ;;;
{
$A6:8DAF DA          PHX
$A6:8DB0 5A          PHY
$A6:8DB1 A9 61 00    LDA #$0061             ;\
$A6:8DB4 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 61h, sound library 2, max queued sounds allowed = 6 (fire geyser)
$A6:8DB8 7A          PLY
$A6:8DB9 FA          PLX
$A6:8DBA 6B          RTL
}


;;; $8DBB: Y offsets ;;;
{
$A6:8DBB             dw 0005
$A6:8DBD             dw 000A
$A6:8DBF             dw 000F
$A6:8DC1             dw 0014
$A6:8DC3             dw 0019
$A6:8DC5             dw 001E
$A6:8DC7             dw 0023
$A6:8DC9             dw 0028
$A6:8DCB             dw 002D
$A6:8DCD             dw 0032
$A6:8DCF             dw 0037
$A6:8DD1             dw 003C
$A6:8DD3             dw 0041
$A6:8DD5             dw 0046
$A6:8DD7             dw 004B
$A6:8DD9             dw 0050
$A6:8DDB             dw 0055
$A6:8DDD             dw 005A
$A6:8DDF             dw 005F
$A6:8DE1             dw 0064
$A6:8DE3             dw 0069
$A6:8DE5             dw 006E
}


;;; $8DE7: Y radii ;;;
{
$A6:8DE7             dw 0018
$A6:8DE9             dw 0018
$A6:8DEB             dw 0018
$A6:8DED             dw 0018
$A6:8DEF             dw 0018
$A6:8DF1             dw 0018
$A6:8DF3             dw 0018
$A6:8DF5             dw 0018
$A6:8DF7             dw 0018
$A6:8DF9             dw 0018
$A6:8DFB             dw 0018
$A6:8DFD             dw 0018
$A6:8DFF             dw 0018
$A6:8E01             dw 0018
$A6:8E03             dw 0018
$A6:8E05             dw 0018
$A6:8E07             dw 0018
$A6:8E09             dw 0018
$A6:8E0B             dw 0014
$A6:8E0D             dw 0010
$A6:8E0F             dw 000C
$A6:8E11             dw 0008
}


;;; $8E13..8FFB: Fire geyser instructions ;;;
{
;;; $8E13: Instruction ;;;
{
$A6:8E13 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8E16 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8E19 38          SEC
$A6:8E1A ED BB 8D    SBC $8DBB  [$A6:8DBB]
$A6:8E1D 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8E20 AD E7 8D    LDA $8DE7  [$A6:8DE7]
$A6:8E23 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8E26 A9 08 00    LDA #$0008
$A6:8E29 9D C2 0F    STA $0FC2,x[$7E:1282]
$A6:8E2C 6B          RTL
}


;;; $8E2D: Instruction ;;;
{
$A6:8E2D AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8E30 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8E33 38          SEC
$A6:8E34 ED BD 8D    SBC $8DBD  [$A6:8DBD]
$A6:8E37 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8E3A AD E9 8D    LDA $8DE9  [$A6:8DE9]
$A6:8E3D 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8E40 6B          RTL
}


;;; $8E41: Instruction ;;;
{
$A6:8E41 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8E44 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8E47 38          SEC
$A6:8E48 ED BF 8D    SBC $8DBF  [$A6:8DBF]
$A6:8E4B 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8E4E AD EB 8D    LDA $8DEB  [$A6:8DEB]
$A6:8E51 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8E54 6B          RTL
}


;;; $8E55: Instruction ;;;
{
$A6:8E55 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8E58 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8E5B 38          SEC
$A6:8E5C ED C1 8D    SBC $8DC1  [$A6:8DC1]
$A6:8E5F 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8E62 AD ED 8D    LDA $8DED  [$A6:8DED]
$A6:8E65 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8E68 6B          RTL
}


;;; $8E69: Instruction ;;;
{
$A6:8E69 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8E6C BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8E6F 38          SEC
$A6:8E70 ED C3 8D    SBC $8DC3  [$A6:8DC3]
$A6:8E73 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8E76 AD EF 8D    LDA $8DEF  [$A6:8DEF]
$A6:8E79 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8E7C 6B          RTL
}


;;; $8E7D: Instruction ;;;
{
$A6:8E7D AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8E80 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8E83 38          SEC
$A6:8E84 ED C5 8D    SBC $8DC5  [$A6:8DC5]
$A6:8E87 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8E8A AD F1 8D    LDA $8DF1  [$A6:8DF1]
$A6:8E8D 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8E90 6B          RTL
}


;;; $8E91: Instruction ;;;
{
$A6:8E91 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8E94 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8E97 38          SEC
$A6:8E98 ED C7 8D    SBC $8DC7  [$A6:8DC7]
$A6:8E9B 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8E9E AD F3 8D    LDA $8DF3  [$A6:8DF3]
$A6:8EA1 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8EA4 6B          RTL
}


;;; $8EA5: Instruction ;;;
{
$A6:8EA5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8EA8 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8EAB 38          SEC
$A6:8EAC ED C9 8D    SBC $8DC9  [$A6:8DC9]
$A6:8EAF 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8EB2 AD F5 8D    LDA $8DF5  [$A6:8DF5]
$A6:8EB5 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8EB8 6B          RTL
}


;;; $8EB9: Instruction ;;;
{
$A6:8EB9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8EBC BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8EBF 38          SEC
$A6:8EC0 ED CB 8D    SBC $8DCB  [$A6:8DCB]
$A6:8EC3 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8EC6 AD F7 8D    LDA $8DF7  [$A6:8DF7]
$A6:8EC9 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8ECC 6B          RTL
}


;;; $8ECD: Instruction ;;;
{
$A6:8ECD AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8ED0 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8ED3 38          SEC
$A6:8ED4 ED CD 8D    SBC $8DCD  [$A6:8DCD]
$A6:8ED7 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8EDA AD F9 8D    LDA $8DF9  [$A6:8DF9]
$A6:8EDD 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8EE0 6B          RTL
}


;;; $8EE1: Instruction ;;;
{
$A6:8EE1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8EE4 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8EE7 38          SEC
$A6:8EE8 ED CF 8D    SBC $8DCF  [$A6:8DCF]
$A6:8EEB 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8EEE AD FB 8D    LDA $8DFB  [$A6:8DFB]
$A6:8EF1 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8EF4 6B          RTL
}


;;; $8EF5: Instruction ;;;
{
$A6:8EF5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8EF8 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8EFB 38          SEC
$A6:8EFC ED D1 8D    SBC $8DD1  [$A6:8DD1]
$A6:8EFF 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8F02 AD FD 8D    LDA $8DFD  [$A6:8DFD]
$A6:8F05 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8F08 6B          RTL
}


;;; $8F09: Instruction ;;;
{
$A6:8F09 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8F0C BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8F0F 38          SEC
$A6:8F10 ED D3 8D    SBC $8DD3  [$A6:8DD3]
$A6:8F13 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8F16 AD FF 8D    LDA $8DFF  [$A6:8DFF]
$A6:8F19 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8F1C 6B          RTL
}


;;; $8F1D: Instruction ;;;
{
$A6:8F1D AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8F20 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8F23 38          SEC
$A6:8F24 ED D5 8D    SBC $8DD5  [$A6:8DD5]
$A6:8F27 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8F2A AD 01 8E    LDA $8E01  [$A6:8E01]
$A6:8F2D 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8F30 6B          RTL
}


;;; $8F31: Instruction ;;;
{
$A6:8F31 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8F34 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8F37 38          SEC
$A6:8F38 ED D7 8D    SBC $8DD7  [$A6:8DD7]
$A6:8F3B 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8F3E AD 03 8E    LDA $8E03  [$A6:8E03]
$A6:8F41 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8F44 6B          RTL
}


;;; $8F45: Instruction ;;;
{
$A6:8F45 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8F48 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8F4B 38          SEC
$A6:8F4C ED D9 8D    SBC $8DD9  [$A6:8DD9]
$A6:8F4F 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8F52 AD 05 8E    LDA $8E05  [$A6:8E05]
$A6:8F55 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8F58 6B          RTL
}


;;; $8F59: Instruction ;;;
{
$A6:8F59 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8F5C BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8F5F 38          SEC
$A6:8F60 ED DB 8D    SBC $8DDB  [$A6:8DDB]
$A6:8F63 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8F66 AD 07 8E    LDA $8E07  [$A6:8E07]
$A6:8F69 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8F6C 6B          RTL
}


;;; $8F6D: Instruction ;;;
{
$A6:8F6D AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8F70 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8F73 38          SEC
$A6:8F74 ED DD 8D    SBC $8DDD  [$A6:8DDD]
$A6:8F77 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8F7A AD 09 8E    LDA $8E09  [$A6:8E09]
$A6:8F7D 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8F80 6B          RTL
}


;;; $8F81: Instruction ;;;
{
$A6:8F81 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8F84 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8F87 38          SEC
$A6:8F88 ED DF 8D    SBC $8DDF  [$A6:8DDF]
$A6:8F8B 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8F8E AD 0B 8E    LDA $8E0B  [$A6:8E0B]
$A6:8F91 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8F94 6B          RTL
}


;;; $8F95: Instruction ;;;
{
$A6:8F95 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8F98 BD AE 0F    LDA $0FAE,x[$7E:126E]
$A6:8F9B 38          SEC
$A6:8F9C ED E1 8D    SBC $8DE1  [$A6:8DE1]
$A6:8F9F 9D BE 0F    STA $0FBE,x[$7E:127E]
$A6:8FA2 AD 0D 8E    LDA $8E0D  [$A6:8E0D]
$A6:8FA5 9D C4 0F    STA $0FC4,x[$7E:1284]
$A6:8FA8 6B          RTL
}


;;; $8FA9: Instruction ;;;
{
$A6:8FA9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8FAC BD AE 0F    LDA $0FAE,x[$7E:10EE]
$A6:8FAF 38          SEC
$A6:8FB0 ED E3 8D    SBC $8DE3  [$A6:8DE3]
$A6:8FB3 9D BE 0F    STA $0FBE,x[$7E:10FE]
$A6:8FB6 AD 0F 8E    LDA $8E0F  [$A6:8E0F]
$A6:8FB9 9D C4 0F    STA $0FC4,x[$7E:1104]
$A6:8FBC 6B          RTL
}


;;; $8FBD: Instruction ;;;
{
$A6:8FBD AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8FC0 BD AE 0F    LDA $0FAE,x[$7E:10EE]
$A6:8FC3 38          SEC
$A6:8FC4 ED E5 8D    SBC $8DE5  [$A6:8DE5]
$A6:8FC7 9D BE 0F    STA $0FBE,x[$7E:10FE]
$A6:8FCA AD 11 8E    LDA $8E11  [$A6:8E11]
$A6:8FCD 9D C4 0F    STA $0FC4,x[$7E:1104]
$A6:8FD0 6B          RTL
}


;;; $8FD1: Instruction ;;;
{
$A6:8FD1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8FD4 A9 01 00    LDA #$0001
$A6:8FD7 9D AC 0F    STA $0FAC,x[$7E:10EC]
$A6:8FDA A9 00 00    LDA #$0000
$A6:8FDD 9D C2 0F    STA $0FC2,x[$7E:1102]
$A6:8FE0 9D C4 0F    STA $0FC4,x[$7E:1104]
$A6:8FE3 BD AE 0F    LDA $0FAE,x[$7E:10EE]
$A6:8FE6 9D 7E 0F    STA $0F7E,x[$7E:10BE]
$A6:8FE9 BD 86 0F    LDA $0F86,x[$7E:10C6]
$A6:8FEC 09 00 01    ORA #$0100
$A6:8FEF 9D 86 0F    STA $0F86,x[$7E:10C6]
$A6:8FF2 BD C6 0F    LDA $0FC6,x[$7E:1106]
$A6:8FF5 09 00 04    ORA #$0400
$A6:8FF8 9D C6 0F    STA $0FC6,x[$7E:1106]
$A6:8FFB 6B          RTL
}
}


;;; $8FFC: Initialisation AI - enemy $E07F (fire geyser) ;;;
{
$A6:8FFC AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:8FFF A9 A9 8D    LDA #$8DA9
$A6:9002 9D 92 0F    STA $0F92,x[$7E:10D2]
$A6:9005 BD B6 0F    LDA $0FB6,x[$7E:10F6]
$A6:9008 D0 18       BNE $18    [$9022]
$A6:900A A9 1B 8D    LDA #$8D1B
$A6:900D 9D 92 0F    STA $0F92,x[$7E:10D2]
$A6:9010 A9 2F 90    LDA #$902F
$A6:9013 9D A8 0F    STA $0FA8,x[$7E:10E8]
$A6:9016 BD 7E 0F    LDA $0F7E,x[$7E:10BE]
$A6:9019 9D AE 0F    STA $0FAE,x[$7E:10EE]
$A6:901C A9 00 00    LDA #$0000
$A6:901F 9D 82 0F    STA $0F82,x[$7E:10C2]

$A6:9022 6B          RTL
}


;;; $9023: Main AI - enemy $E07F (fire geyser) ;;;
{
$A6:9023 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9026 BD B6 0F    LDA $0FB6,x[$7E:12B6]
$A6:9029 D0 03       BNE $03    [$902E]
$A6:902B FC A8 0F    JSR ($0FA8,x)[$A6:902F]

$A6:902E 6B          RTL
}


;;; $902F:  ;;;
{
$A6:902F AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9032 DE AA 0F    DEC $0FAA,x[$7E:126A]
$A6:9035 10 2A       BPL $2A    [$9061]
$A6:9037 A9 62 90    LDA #$9062
$A6:903A 9D A8 0F    STA $0FA8,x[$7E:1268]
$A6:903D 9E AC 0F    STZ $0FAC,x[$7E:126C]
$A6:9040 A9 01 00    LDA #$0001
$A6:9043 9D 94 0F    STA $0F94,x[$7E:1254]
$A6:9046 9E 90 0F    STZ $0F90,x[$7E:1250]
$A6:9049 A9 1B 8D    LDA #$8D1B
$A6:904C 9D 92 0F    STA $0F92,x[$7E:1252]
$A6:904F BD 86 0F    LDA $0F86,x[$7E:1246]
$A6:9052 29 FF FE    AND #$FEFF
$A6:9055 9D 86 0F    STA $0F86,x[$7E:1246]
$A6:9058 BD C6 0F    LDA $0FC6,x[$7E:1286]
$A6:905B 29 FF FB    AND #$FBFF
$A6:905E 9D C6 0F    STA $0FC6,x[$7E:1286]

$A6:9061 60          RTS
}


;;; $9062:  ;;;
{
$A6:9062 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9065 BD AC 0F    LDA $0FAC,x[$7E:126C]
$A6:9068 F0 15       BEQ $15    [$907F]
$A6:906A BD B4 0F    LDA $0FB4,x[$7E:1174]
$A6:906D 9D AA 0F    STA $0FAA,x[$7E:116A]
$A6:9070 BD 86 0F    LDA $0F86,x[$7E:1146]
$A6:9073 09 00 01    ORA #$0100
$A6:9076 9D 86 0F    STA $0F86,x[$7E:1146]
$A6:9079 A9 2F 90    LDA #$902F
$A6:907C 9D A8 0F    STA $0FA8,x[$7E:1168]

$A6:907F 60          RTS
}


;;; $9080: RTL ;;;
{
$A6:9080 6B          RTL
}


;;; $9081: RTL ;;;
{
$A6:9081 6B          RTL
}


;;; $9082: Fire geyser spritemaps ;;;
{
$A6:9082             dx 0001, 81F9,F9,210E
$A6:9089             dx 0004, 0005,FF,2134, 01F4,FF,6134, 81F9,F8,2102, 81F9,F2,2100
$A6:909F             dx 0005, 0005,FF,2124, 01F4,FF,6124, 81F9,F8,2120, 81F9,F2,2102, 81F9,EC,2100
$A6:90BA             dx 0006, 81EC,F7,6128, 8005,F7,2128, 81F9,F8,2104, 81F9,F0,2120, 81F9,EA,2102, 81F9,E4,2100
$A6:90DA             dx 0007, 81EC,F7,612A, 8005,F7,212A, 81F9,F8,2106, 81F9,F2,2104, 81F9,EA,2120, 81F9,E4,2102, 81F9,DE,2100
$A6:90FF             dx 0007, 0005,FF,2134, 01F4,FF,6134, 81F9,F8,2122, 81F9,F0,2104, 81F9,E8,2120, 81F9,E2,2102, 81F9,DC,2100
$A6:9124             dx 0007, 0005,FF,2124, 01F4,FF,6124, 81F8,F8,E106, 81F9,EE,2104, 81F9,E4,2120, 81F9,DE,2102, 81F9,DA,2100
$A6:9149             dx 0007, 81EC,F7,6128, 8005,F7,2128, 81F8,F8,E122, 81F9,EC,2104, 81F9,E2,2120, 81F9,DC,2102, 81F9,D8,2100
$A6:916E             dx 0008, 81EC,F7,612A, 8005,F7,212A, 81F9,F8,210C, 81F9,F0,2106, 81F9,E4,2104, 81F9,DA,2120, 81F9,D4,2102, 81F9,D0,2100
$A6:9198             dx 0008, 0005,FF,2134, 01F4,FF,6134, 81F9,F4,210C, 81F9,E6,2122, 81F9,DA,2104, 81F9,D0,2120, 81F9,CA,2102, 81F9,C6,2100
$A6:91C2             dx 0009, 0005,FF,2124, 01F4,FF,6124, 81F9,F8,2126, 81F9,EC,210C, 81F8,E0,E106, 81F9,D4,2104, 81F9,CA,2120, 81F9,C4,2102, 81F9,C0,2100
$A6:91F1             dx 000D, 8005,F7,2128, 81EC,F7,6128, 0002,01,2137, 01F8,01,2136, 0002,F7,2127, 01F8,F7,2126, 81F9,F0,2126, 81F9,E4,210C, 81F8,D8,E122, 81F9,CC,2104, 81F9,C2,2120, 81F9,BC,2102, 81F9,B8,2100
$A6:9234             dx 000E, 8005,F7,212C, 81EC,F7,612C, 81F9,F8,212E, 0002,FD,2137, 01F8,FD,2136, 0002,F3,2127, 01F8,F3,2126, 81F9,E8,2126, 81F9,DC,210C, 81F9,D0,2106, 81F9,C4,2104, 81F9,BA,2120, 81F9,B4,2102, 81F9,B0,2100
$A6:927C             dx 000E, 8009,F5,212A, 81E8,F5,612A, 81F9,F8,212E, 0002,F9,2137, 01F8,F9,2136, 0002,EF,2127, 01F8,EF,2126, 81F9,E0,2126, 81F9,D4,210C, 81F9,C8,2122, 81F9,BC,2104, 81F9,B2,2120, 81F9,AC,2102, 81F9,A8,2100
$A6:92C4             dx 000C, 81F9,F4,212E, 0002,F1,2137, 01F8,F1,2136, 0002,E7,2127, 01F8,E7,2126, 81F9,D8,2126, 81F9,CC,210C, 81F9,C0,E106, 81F9,B4,2104, 81F9,AA,2120, 81F9,A4,2102, 81F9,A0,2100
$A6:9302             dx 000E, 0005,FF,2134, 01F4,FF,6134, 81F9,F0,212E, 0002,E9,2137, 01F8,E9,2136, 0002,DF,2127, 01F8,DF,2126, 81F9,D0,2126, 81F9,C4,210C, 81F8,B8,E122, 81F9,AC,2104, 81F9,A2,2120, 81F9,9C,2102, 81F9,98,2100
$A6:934A             dx 000D, 0005,FF,2124, 01F4,FF,6124, 81F9,DE,212E, 0002,D7,2137, 01F8,D7,2136, 0002,CD,2127, 01F8,CD,2126, 81F9,C2,2126, 81F9,B6,210C, 81F9,AC,2106, 81F9,A2,2104, 81F9,9A,2120, 81F9,96,2100
$A6:938D             dx 000C, 81F9,CC,212E, 0002,C9,2137, 01F8,C9,2136, 0002,BF,2127, 01F8,BF,2126, 81F9,B4,2126, 81EC,F7,6128, 8005,F7,2128, 81F9,AA,210C, 81F9,A0,2122, 81F9,98,2104, 81F8,9A,2100
$A6:93CB             dx 000B, 81F9,C0,212E, 0003,BD,2137, 01F9,BD,2136, 0003,B3,2127, 01F9,B3,2126, 81FA,AA,2126, 81EC,F7,612A, 8005,F7,212A, 81FA,A0,210C, 81F9,96,E106, 81F9,98,A100
$A6:9404             dx 0008, 81F9,B6,212E, 0002,B5,2137, 01F8,B5,2136, 0002,AB,2127, 01F8,AB,2126, 81F9,A2,2126, 81F9,9A,210C, 81F9,9C,210E
$A6:942E             dx 0006, 81F9,AA,212E, 0002,AD,2137, 01F8,AD,2136, 0002,A3,2127, 01F8,A3,2126, 81F9,9A,2126
$A6:944E             dx 0005, 81F9,A4,212E, 0002,A5,2137, 01F8,A5,2136, 0002,9B,2127, 01F8,9B,2126
$A6:9469             dx 0001, 81F9,9C,212E
}
}


;;; $9470..998B: Nuclear waffle ;;;
{
;;; $9470: Palette - enemy $E0BF (nuclear waffle) ;;;
{
$A6:9470             dw 3800, 3E7F, 2DFD, 10FB, 0097, 73FF, 53FF, 37FF, 17FF, 24DF, 189B, 1076, 0C50, 084B, 5EFF, 0880
}


;;; $9490: Instruction list -  ;;;
{
$A6:9490             dx 0003,9954,
                        0003,995B,
                        0003,9970,
                        0003,9962,
                        0003,9969,
                        0003,9977,
                        0003,9954,
                        0003,995B,
                        0003,997E,
                        0003,9962,
                        0003,9969,
                        0003,9985,
                        80ED,9490   ; Go to $9490
}


;;; $94C4: Initialisation AI - enemy $E0BF (nuclear waffle) ;;;
{
$A6:94C4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:94C7 A9 90 94    LDA #$9490
$A6:94CA 9D 92 0F    STA $0F92,x[$7E:0F92]
$A6:94CD BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A6:94D0 29 FF 00    AND #$00FF
$A6:94D3 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A6:94D6 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A6:94D9 29 FF 00    AND #$00FF
$A6:94DC 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A6:94DF BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A6:94E2 29 FF 00    AND #$00FF
$A6:94E5 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A6:94E8 BD B7 0F    LDA $0FB7,x[$7E:0FB7]
$A6:94EB 29 FF 00    AND #$00FF
$A6:94EE 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A6:94F1 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A6:94F4 A9 15 96    LDA #$9615
$A6:94F7 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A6:94FA BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A6:94FD 0A          ASL A
$A6:94FE 0A          ASL A
$A6:94FF A8          TAY
$A6:9500 B9 F6 95    LDA $95F6,y[$A6:95FA]
$A6:9503 9F 06 80 7E STA $7E8006,x[$7E:8006]
$A6:9507 9F 02 80 7E STA $7E8002,x[$7E:8002]
$A6:950B B9 F8 95    LDA $95F8,y[$A6:95FC]
$A6:950E 9F 1C 80 7E STA $7E801C,x[$7E:801C]
$A6:9512 B9 FE 95    LDA $95FE,y[$A6:9602]
$A6:9515 9F 16 80 7E STA $7E8016,x[$7E:8016]
$A6:9519 B9 00 96    LDA $9600,y[$A6:9604]
$A6:951C 9F 18 80 7E STA $7E8018,x[$7E:8018]
$A6:9520 B9 06 96    LDA $9606,y[$A6:960A]
$A6:9523 9F 20 80 7E STA $7E8020,x[$7E:8020]
$A6:9527 B9 08 96    LDA $9608,y[$A6:960C]
$A6:952A 9F 1E 80 7E STA $7E801E,x[$7E:801E]
$A6:952E BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A6:9531 0A          ASL A
$A6:9532 0A          ASL A
$A6:9533 0A          ASL A
$A6:9534 A8          TAY
$A6:9535 BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A6:9538 D0 04       BNE $04    [$953E]
$A6:953A C8          INY
$A6:953B C8          INY
$A6:953C C8          INY
$A6:953D C8          INY

$A6:953E B9 87 81    LDA $8187,y[$A6:8207]
$A6:9541 9F 0A 80 7E STA $7E800A,x[$7E:800A]
$A6:9545 B9 89 81    LDA $8189,y[$A6:8209]
$A6:9548 9F 08 80 7E STA $7E8008,x[$7E:8008]
$A6:954C BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A6:954F 9F 0C 80 7E STA $7E800C,x[$7E:800C]
$A6:9553 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A6:9556 9F 0E 80 7E STA $7E800E,x[$7E:800E]
$A6:955A BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A6:955D 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A6:9560 BF 06 80 7E LDA $7E8006,x[$7E:8006];|
$A6:9564 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Enemy $7E:8010 = [enemy $7E:800C] + [enemy $0FAE] * cos([enemy $7E:8006] * pi / 80h) * FFh / 100h
$A6:9568 18          CLC                    ;|
$A6:9569 7F 0C 80 7E ADC $7E800C,x[$7E:800C];|
$A6:956D 9F 10 80 7E STA $7E8010,x[$7E:8010];/
$A6:9571 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  
$A6:9574 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A6:9577 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A6:957A BF 06 80 7E LDA $7E8006,x[$7E:8006];|
$A6:957E 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;} Enemy $7E:8012 = [enemy $7E:800E] + [enemy $0FAE] * cos([enemy $7E:8006] * pi / 80h) * FFh / 100h
$A6:9582 18          CLC                    ;|
$A6:9583 7F 0E 80 7E ADC $7E800E,x[$7E:800E];|
$A6:9587 9F 12 80 7E STA $7E8012,x[$7E:8012];/
$A6:958B 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A6:958E A9 08 00    LDA #$0008
$A6:9591 9F 14 80 7E STA $7E8014,x[$7E:8014]

$A6:9595 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9598 A0 C7 BB    LDY #$BBC7             ;\
$A6:959B 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn nuclear waffle body enemy projectile
$A6:959F BF 14 80 7E LDA $7E8014,x[$7E:8014]
$A6:95A3 38          SEC
$A6:95A4 E9 02 00    SBC #$0002
$A6:95A7 9F 14 80 7E STA $7E8014,x[$7E:8014]
$A6:95AB D0 E8       BNE $E8    [$9595]
$A6:95AD A9 06 00    LDA #$0006
$A6:95B0 9F 14 80 7E STA $7E8014,x[$7E:8014]

$A6:95B4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:95B7 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A6:95BA 85 12       STA $12    [$7E:0012]
$A6:95BC BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A6:95BF 85 14       STA $14    [$7E:0014]
$A6:95C1 A9 2B 00    LDA #$002B
$A6:95C4 85 16       STA $16    [$7E:0016]
$A6:95C6 BD 96 0F    LDA $0F96,x[$7E:0F96]
$A6:95C9 1D 98 0F    ORA $0F98,x[$7E:0F98]
$A6:95CC 9F 28 80 7E STA $7E8028,x[$7E:8028]
$A6:95D0 85 18       STA $18    [$7E:0018]
$A6:95D2 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A6:95D6 DA          PHX
$A6:95D7 BF 14 80 7E LDA $7E8014,x[$7E:8014]
$A6:95DB 18          CLC
$A6:95DC 6D 54 0E    ADC $0E54  [$7E:0E54]
$A6:95DF AA          TAX
$A6:95E0 A5 12       LDA $12    [$7E:0012]
$A6:95E2 9F 20 78 7E STA $7E7820,x[$7E:7826]
$A6:95E6 FA          PLX
$A6:95E7 BF 14 80 7E LDA $7E8014,x[$7E:8014]
$A6:95EB 38          SEC
$A6:95EC E9 02 00    SBC #$0002
$A6:95EF 9F 14 80 7E STA $7E8014,x[$7E:8014]
$A6:95F3 D0 BF       BNE $BF    [$95B4]
$A6:95F5 6B          RTL

$A6:95F6             dw 0190,00F0, 00F0,0190
$A6:95FE             dw FFE8,FFF4, 0018,000C
$A6:9606             dw 0180,0100, 0100,0180
}


;;; $960E: Main AI - enemy $E0BF (nuclear waffle) ;;;
{
$A6:960E AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9611 FC A8 0F    JSR ($0FA8,x)[$A6:9615]
$A6:9614 6B          RTL
}


;;; $9615:  ;;;
{
$A6:9615 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9618 DE AA 0F    DEC $0FAA,x[$7E:0FAA]
$A6:961B 10 64       BPL $64    [$9681]
$A6:961D BD B2 0F    LDA $0FB2,x[$7E:0FB2]
$A6:9620 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A6:9623 BF 06 80 7E LDA $7E8006,x[$7E:8006]
$A6:9627 9F 02 80 7E STA $7E8002,x[$7E:8002]
$A6:962B A9 82 96    LDA #$9682
$A6:962E 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A6:9631 A9 00 00    LDA #$0000
$A6:9634 9F 26 80 7E STA $7E8026,x[$7E:8026]
$A6:9638 9F 10 78 7E STA $7E7810,x[$7E:7810]
$A6:963C 9F 12 78 7E STA $7E7812,x[$7E:7812]
$A6:9640 9F 14 78 7E STA $7E7814,x[$7E:7814]
$A6:9644 9F 16 78 7E STA $7E7816,x[$7E:7816]
$A6:9648 9F 18 78 7E STA $7E7818,x[$7E:7818]
$A6:964C 9F 1A 78 7E STA $7E781A,x[$7E:781A]
$A6:9650 9F 1C 78 7E STA $7E781C,x[$7E:781C]
$A6:9654 9F 1E 78 7E STA $7E781E,x[$7E:781E]
$A6:9658 9F 30 78 7E STA $7E7830,x[$7E:7830]
$A6:965C 9F 32 78 7E STA $7E7832,x[$7E:7832]
$A6:9660 9F 34 78 7E STA $7E7834,x[$7E:7834]
$A6:9664 9F 36 78 7E STA $7E7836,x[$7E:7836]
$A6:9668 9F 38 78 7E STA $7E7838,x[$7E:7838]
$A6:966C 9F 3A 78 7E STA $7E783A,x[$7E:783A]
$A6:9670 9F 3C 78 7E STA $7E783C,x[$7E:783C]
$A6:9674 9F 3E 78 7E STA $7E783E,x[$7E:783E]
$A6:9678 BD 86 0F    LDA $0F86,x[$7E:0F86]
$A6:967B 09 00 08    ORA #$0800
$A6:967E 9D 86 0F    STA $0F86,x[$7E:0F86]

$A6:9681 60          RTS
}


;;; $9682:  ;;;
{
$A6:9682 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9685 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A6:9688 8D 32 0E    STA $0E32  [$7E:0E32]
$A6:968B BF 02 80 7E LDA $7E8002,x[$7E:8002]
$A6:968F 20 E7 98    JSR $98E7  [$A6:98E7]
$A6:9692 85 1E       STA $1E    [$7E:001E]
$A6:9694 48          PHA
$A6:9695 DF 26 80 7E CMP $7E8026,x[$7E:8026]
$A6:9699 F0 3B       BEQ $3B    [$96D6]
$A6:969B AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:969E BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A6:96A1 85 12       STA $12    [$7E:0012]
$A6:96A3 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A6:96A6 85 14       STA $14    [$7E:0014]
$A6:96A8 A9 2E 00    LDA #$002E
$A6:96AB 85 16       STA $16    [$7E:0016]
$A6:96AD BF 28 80 7E LDA $7E8028,x[$7E:8028]
$A6:96B1 85 18       STA $18    [$7E:0018]
$A6:96B3 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A6:96B7 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A6:96BA 85 12       STA $12    [$7E:0012]
$A6:96BC BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A6:96BF 85 14       STA $14    [$7E:0014]
$A6:96C1 A5 1A       LDA $1A    [$7E:001A]
$A6:96C3 18          CLC
$A6:96C4 69 2C 00    ADC #$002C
$A6:96C7 85 16       STA $16    [$7E:0016]
$A6:96C9 BF 28 80 7E LDA $7E8028,x[$7E:8028]
$A6:96CD 85 18       STA $18    [$7E:0018]
$A6:96CF 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A6:96D3 20 3F 99    JSR $993F  [$A6:993F]

$A6:96D6 68          PLA
$A6:96D7 9F 26 80 7E STA $7E8026,x[$7E:8026]
$A6:96DB BF 02 80 7E LDA $7E8002,x[$7E:8002]
$A6:96DF 20 AD 98    JSR $98AD  [$A6:98AD]
$A6:96E2 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;\
$A6:96E6 18          CLC                    ;|
$A6:96E7 7F 0C 80 7E ADC $7E800C,x[$7E:800C];} Enemy X position = [enemy $7E:800C] + [$0E32] * cos([A] * pi / 80h) * FFh / 100h
$A6:96EB 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A6:96EE BF 02 80 7E LDA $7E8002,x[$7E:8002]
$A6:96F2 20 AD 98    JSR $98AD  [$A6:98AD]
$A6:96F5 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;\
$A6:96F9 18          CLC                    ;|
$A6:96FA 7F 0E 80 7E ADC $7E800E,x[$7E:800E];} Enemy Y position = [enemy $7E:800E] + [$0E32] * -sin([A] * pi / 80h) * FFh / 100h
$A6:96FE 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A6:9701 20 21 97    JSR $9721  [$A6:9721]
$A6:9704 20 E9 97    JSR $97E9  [$A6:97E9]
$A6:9707 18          CLC
$A6:9708 BF 00 80 7E LDA $7E8000,x[$7E:8000]
$A6:970C 7F 08 80 7E ADC $7E8008,x[$7E:8008]
$A6:9710 9F 00 80 7E STA $7E8000,x[$7E:8000]
$A6:9714 BF 02 80 7E LDA $7E8002,x[$7E:8002]
$A6:9718 7F 0A 80 7E ADC $7E800A,x[$7E:800A]
$A6:971C 9F 02 80 7E STA $7E8002,x[$7E:8002]
$A6:9720 60          RTS
}


;;; $9721:  ;;;
{
$A6:9721 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9724 A9 08 00    LDA #$0008
$A6:9727 9F 14 80 7E STA $7E8014,x[$7E:8014]
$A6:972B BF 02 80 7E LDA $7E8002,x[$7E:8002]
$A6:972F 18          CLC
$A6:9730 7F 18 80 7E ADC $7E8018,x[$7E:8018]
$A6:9734 85 24       STA $24    [$7E:0024]

$A6:9736 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9739 A5 24       LDA $24    [$7E:0024]
$A6:973B 38          SEC
$A6:973C FF 16 80 7E SBC $7E8016,x[$7E:8016]
$A6:9740 85 24       STA $24    [$7E:0024]
$A6:9742 DA          PHX
$A6:9743 BF 14 80 7E LDA $7E8014,x[$7E:8014]
$A6:9747 18          CLC
$A6:9748 6D 54 0E    ADC $0E54  [$7E:0E54]
$A6:974B AA          TAX
$A6:974C BF 00 78 7E LDA $7E7800,x[$7E:7808]
$A6:9750 A8          TAY
$A6:9751 A5 24       LDA $24    [$7E:0024]
$A6:9753 20 E7 98    JSR $98E7  [$A6:98E7]
$A6:9756 85 1E       STA $1E    [$7E:001E]
$A6:9758 48          PHA
$A6:9759 DF 10 78 7E CMP $7E7810,x[$7E:7818]
$A6:975D F0 3D       BEQ $3D    [$979C]
$A6:975F DA          PHX
$A6:9760 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9763 B9 4B 1A    LDA $1A4B,y[$7E:1A6D]
$A6:9766 85 12       STA $12    [$7E:0012]
$A6:9768 B9 93 1A    LDA $1A93,y[$7E:1AB5]
$A6:976B 85 14       STA $14    [$7E:0014]
$A6:976D A9 2E 00    LDA #$002E
$A6:9770 85 16       STA $16    [$7E:0016]
$A6:9772 BF 28 80 7E LDA $7E8028,x[$7E:8028]
$A6:9776 85 18       STA $18    [$7E:0018]
$A6:9778 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A6:977C B9 4B 1A    LDA $1A4B,y[$7E:1A6D]
$A6:977F 85 12       STA $12    [$7E:0012]
$A6:9781 B9 93 1A    LDA $1A93,y[$7E:1AB5]
$A6:9784 85 14       STA $14    [$7E:0014]
$A6:9786 A5 1A       LDA $1A    [$7E:001A]
$A6:9788 18          CLC
$A6:9789 69 2C 00    ADC #$002C
$A6:978C 85 16       STA $16    [$7E:0016]
$A6:978E BF 28 80 7E LDA $7E8028,x[$7E:8028]
$A6:9792 85 18       STA $18    [$7E:0018]
$A6:9794 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A6:9798 20 3F 99    JSR $993F  [$A6:993F]
$A6:979B FA          PLX

$A6:979C 68          PLA
$A6:979D 9F 10 78 7E STA $7E7810,x[$7E:7818]
$A6:97A1 FA          PLX
$A6:97A2 A5 24       LDA $24    [$7E:0024]
$A6:97A4 20 AD 98    JSR $98AD  [$A6:98AD]
$A6:97A7 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;\
$A6:97AB 18          CLC                    ;|
$A6:97AC 7F 0C 80 7E ADC $7E800C,x[$7E:800C];} Enemy projectile X position = [enemy $7E:800C] + [$0E32] * cos([A] * pi / 80h) * FFh / 100h
$A6:97B0 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$A6:97B3 A5 24       LDA $24    [$7E:0024]
$A6:97B5 20 AD 98    JSR $98AD  [$A6:98AD]
$A6:97B8 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;\
$A6:97BC 18          CLC                    ;|
$A6:97BD 7F 0E 80 7E ADC $7E800E,x[$7E:800E];} Enemy projectile Y position = [enemy $7E:800E] + [$0E32] * -sin([A] * pi / 80h) * FFh / 100h
$A6:97C1 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$A6:97C4 BF 14 80 7E LDA $7E8014,x[$7E:8014]
$A6:97C8 38          SEC
$A6:97C9 E9 02 00    SBC #$0002
$A6:97CC 9F 14 80 7E STA $7E8014,x[$7E:8014]
$A6:97D0 F0 03       BEQ $03    [$97D5]
$A6:97D2 4C 36 97    JMP $9736  [$A6:9736]

$A6:97D5 A5 1C       LDA $1C    [$7E:001C]
$A6:97D7 F0 0F       BEQ $0F    [$97E8]
$A6:97D9 A9 15 96    LDA #$9615
$A6:97DC 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A6:97DF BD 86 0F    LDA $0F86,x[$7E:0F86]
$A6:97E2 29 FF F7    AND #$F7FF
$A6:97E5 9D 86 0F    STA $0F86,x[$7E:0F86]

$A6:97E8 60          RTS
}


;;; $97E9:  ;;;
{
$A6:97E9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:97EC A9 06 00    LDA #$0006
$A6:97EF 9F 14 80 7E STA $7E8014,x[$7E:8014]
$A6:97F3 BF 02 80 7E LDA $7E8002,x[$7E:8002]
$A6:97F7 85 24       STA $24    [$7E:0024]

$A6:97F9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:97FC A5 24       LDA $24    [$7E:0024]
$A6:97FE 38          SEC
$A6:97FF FF 16 80 7E SBC $7E8016,x[$7E:8016]
$A6:9803 85 24       STA $24    [$7E:0024]
$A6:9805 DA          PHX
$A6:9806 BF 14 80 7E LDA $7E8014,x[$7E:8014]
$A6:980A 18          CLC
$A6:980B 6D 54 0E    ADC $0E54  [$7E:0E54]
$A6:980E AA          TAX
$A6:980F BF 20 78 7E LDA $7E7820,x[$7E:7826]
$A6:9813 A8          TAY
$A6:9814 A5 24       LDA $24    [$7E:0024]
$A6:9816 20 E7 98    JSR $98E7  [$A6:98E7]
$A6:9819 85 1E       STA $1E    [$7E:001E]
$A6:981B 48          PHA
$A6:981C DF 30 78 7E CMP $7E7830,x[$7E:7836]
$A6:9820 F0 44       BEQ $44    [$9866]
$A6:9822 DA          PHX
$A6:9823 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9826 BF 28 80 7E LDA $7E8028,x[$7E:8028]
$A6:982A 85 26       STA $26    [$7E:0026]
$A6:982C BB          TYX
$A6:982D BF F8 F0 7E LDA $7EF0F8,x[$7E:F136]
$A6:9831 85 12       STA $12    [$7E:0012]
$A6:9833 BF F8 F1 7E LDA $7EF1F8,x[$7E:F236]
$A6:9837 85 14       STA $14    [$7E:0014]
$A6:9839 A9 2E 00    LDA #$002E
$A6:983C 85 16       STA $16    [$7E:0016]
$A6:983E A5 26       LDA $26    [$7E:0026]
$A6:9840 85 18       STA $18    [$7E:0018]
$A6:9842 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A6:9846 BF F8 F0 7E LDA $7EF0F8,x[$7E:F136]
$A6:984A 85 12       STA $12    [$7E:0012]
$A6:984C BF F8 F1 7E LDA $7EF1F8,x[$7E:F236]
$A6:9850 85 14       STA $14    [$7E:0014]
$A6:9852 A9 2C 00    LDA #$002C
$A6:9855 18          CLC
$A6:9856 65 1A       ADC $1A    [$7E:001A]
$A6:9858 85 16       STA $16    [$7E:0016]
$A6:985A A5 26       LDA $26    [$7E:0026]
$A6:985C 85 18       STA $18    [$7E:0018]
$A6:985E 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A6:9862 20 3F 99    JSR $993F  [$A6:993F]
$A6:9865 FA          PLX

$A6:9866 68          PLA
$A6:9867 9F 30 78 7E STA $7E7830,x[$7E:7836]
$A6:986B FA          PLX
$A6:986C A5 24       LDA $24    [$7E:0024]
$A6:986E 20 AD 98    JSR $98AD  [$A6:98AD]
$A6:9871 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;\
$A6:9875 18          CLC                    ;|
$A6:9876 7F 0C 80 7E ADC $7E800C,x[$7E:800C];} $20 = [enemy $7E:800C] + [$0E32] * cos([A] * pi / 80h) * FFh / 100h
$A6:987A 85 20       STA $20    [$7E:0020]  ;/
$A6:987C A5 24       LDA $24    [$7E:0024]
$A6:987E 20 AD 98    JSR $98AD  [$A6:98AD]
$A6:9881 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;\
$A6:9885 18          CLC                    ;|
$A6:9886 7F 0E 80 7E ADC $7E800E,x[$7E:800E];} $22 = [enemy $7E:800E] + [$0E32] * -sin([A] * pi / 80h) * FFh / 100h
$A6:988A 85 22       STA $22    [$7E:0022]  ;/
$A6:988C DA          PHX
$A6:988D BB          TYX
$A6:988E A5 20       LDA $20    [$7E:0020]
$A6:9890 9F F8 F0 7E STA $7EF0F8,x[$7E:F136]
$A6:9894 A5 22       LDA $22    [$7E:0022]
$A6:9896 9F F8 F1 7E STA $7EF1F8,x[$7E:F236]
$A6:989A FA          PLX
$A6:989B BF 14 80 7E LDA $7E8014,x[$7E:8014]
$A6:989F 38          SEC
$A6:98A0 E9 02 00    SBC #$0002
$A6:98A3 9F 14 80 7E STA $7E8014,x[$7E:8014]
$A6:98A7 F0 03       BEQ $03    [$98AC]
$A6:98A9 4C F9 97    JMP $97F9  [$A6:97F9]

$A6:98AC 60          RTS
}


;;; $98AD:  ;;;
{
$A6:98AD DA          PHX
$A6:98AE 48          PHA
$A6:98AF AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:98B2 64 1C       STZ $1C    [$7E:001C]
$A6:98B4 BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A6:98B7 D0 0F       BNE $0F    [$98C8]
$A6:98B9 68          PLA
$A6:98BA DF 1C 80 7E CMP $7E801C,x
$A6:98BE 30 17       BMI $17    [$98D7]
$A6:98C0 DF 06 80 7E CMP $7E8006,x
$A6:98C4 10 19       BPL $19    [$98DF]
$A6:98C6 80 1D       BRA $1D    [$98E5]

$A6:98C8 68          PLA
$A6:98C9 DF 1C 80 7E CMP $7E801C,x[$7E:801C]
$A6:98CD 10 08       BPL $08    [$98D7]
$A6:98CF DF 06 80 7E CMP $7E8006,x[$7E:8006]
$A6:98D3 30 0A       BMI $0A    [$98DF]
$A6:98D5 80 0E       BRA $0E    [$98E5]

$A6:98D7 E6 1C       INC $1C    [$7E:001C]
$A6:98D9 BF 1C 80 7E LDA $7E801C,x[$7E:801C]
$A6:98DD 80 06       BRA $06    [$98E5]

$A6:98DF BF 06 80 7E LDA $7E8006,x[$7E:8006]
$A6:98E3 80 00       BRA $00    [$98E5]

$A6:98E5 FA          PLX
$A6:98E6 60          RTS
}


;;; $98E7:  ;;;
{
$A6:98E7 DA          PHX
$A6:98E8 48          PHA
$A6:98E9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:98EC BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A6:98EF D0 12       BNE $12    [$9903]
$A6:98F1 68          PLA
$A6:98F2 DF 1E 80 7E CMP $7E801E,x
$A6:98F6 30 27       BMI $27    [$991F]
$A6:98F8 DF 20 80 7E CMP $7E8020,x
$A6:98FC 30 17       BMI $17    [$9915]
$A6:98FE A9 00 00    LDA #$0000
$A6:9901 80 3A       BRA $3A    [$993D]

$A6:9903 68          PLA
$A6:9904 DF 1E 80 7E CMP $7E801E,x[$7E:801E]
$A6:9908 10 29       BPL $29    [$9933]
$A6:990A DF 20 80 7E CMP $7E8020,x[$7E:8020]
$A6:990E 10 19       BPL $19    [$9929]
$A6:9910 A9 00 00    LDA #$0000
$A6:9913 80 28       BRA $28    [$993D]

$A6:9915 A9 01 00    LDA #$0001
$A6:9918 85 1A       STA $1A    [$7E:001A]
$A6:991A A9 01 00    LDA #$0001
$A6:991D 80 1E       BRA $1E    [$993D]

$A6:991F A9 00 00    LDA #$0000
$A6:9922 85 1A       STA $1A    [$7E:001A]
$A6:9924 A9 02 00    LDA #$0002
$A6:9927 80 14       BRA $14    [$993D]

$A6:9929 A9 00 00    LDA #$0000
$A6:992C 85 1A       STA $1A    [$7E:001A]
$A6:992E A9 01 00    LDA #$0001
$A6:9931 80 0A       BRA $0A    [$993D]

$A6:9933 A9 01 00    LDA #$0001
$A6:9936 85 1A       STA $1A    [$7E:001A]
$A6:9938 A9 02 00    LDA #$0002
$A6:993B 80 00       BRA $00    [$993D]

$A6:993D FA          PLX
$A6:993E 60          RTS
}


;;; $993F:  ;;;
{
$A6:993F 5A          PHY
$A6:9940 DA          PHX
$A6:9941 A5 1E       LDA $1E    [$7E:001E]
$A6:9943 C9 02 00    CMP #$0002
$A6:9946 F0 07       BEQ $07    [$994F]
$A6:9948 A9 5E 00    LDA #$005E             ;\
$A6:994B 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 5Eh, sound library 2, max queued sounds allowed = 6 (nuclear waffle part spawns)

$A6:994F FA          PLX
$A6:9950 7A          PLY
$A6:9951 60          RTS
}


;;; $9952: RTL ;;;
{
$A6:9952 6B          RTL
}


;;; $9953: RTL ;;;
{
$A6:9953 6B          RTL
}


;;; $9954: Nuclear waffle spritemaps ;;;
{
$A6:9954             dx 0001, 81F9,F8,230A
$A6:995B             dx 0001, 81F9,F8,2308
$A6:9962             dx 0001, 81F8,F8,E30A
$A6:9969             dx 0001, 81F8,F8,E308
$A6:9970             dx 0001, 81F9,F8,2306
$A6:9977             dx 0001, 81F9,F8,2322
$A6:997E             dx 0001, 81F8,F8,E306
$A6:9985             dx 0001, 81F8,F8,E322
}
}


;;; $998C..A0F4: Fake Kraid ;;;
{
;;; $998C: Palette - enemy $E0FF (fake Kraid) ;;;
{
$A6:998C             dw 3800, 559D, 1816, 100D, 4B9F, 3F37, 36D0, 2E69, 2608, 1DA6, 1125, 08C5, 0003, 094E, 1656, 0000
}


;;; $99AC..9A47: Instruction lists - fake Kraid ;;;
{
;;; $99AC: Instruction list -  ;;;
{
$A6:99AC             dx 9B74,       ; ???
                        0010,9C64,
                        000C,9CB6,
                        0008,9D08,
                        000C,9D5A,
                        9B26,       ; ???
                        80ED,99AC   ; Go to $99AC
}


;;; $99C4: Instruction list -  ;;;
{
$A6:99C4             dx 9B74,       ; ???
                        0010,9C64,
                        9B26,       ; ???
                        000C,9D5A,
                        0008,9D08,
                        000C,9CB6,
                        80ED,99C4   ; Go to $99C4
}


;;; $99DC: Instruction list -  ;;;
{
$A6:99DC             dx 0010,9DAC,
                        9BB2,       ; ???
                        0008,9DFE,
                        9BC4,       ; ???
                        0010,9E50,
                        0008,9DFE,
                        80ED,99AC   ; Go to $99AC
}


;;; $99F4: Instruction list -  ;;;
{
$A6:99F4             dx 7FFF,9DAC,
                        812F        ; Sleep
}


;;; $99FA: Instruction list -  ;;;
{
$A6:99FA             dx 9B74,       ; ???
                        0010,9EA2,
                        000C,9EF4,
                        0008,9F46,
                        000C,9F98,
                        9B26,       ; ???
                        80ED,99FA   ; Go to $99FA
}


;;; $9A12: Instruction list -  ;;;
{
$A6:9A12             dx 9B74,       ; ???
                        0010,9EA2,
                        9B26,       ; ???
                        000C,9F98,
                        0008,9F46,
                        000C,9EF4,
                        80ED,9A12   ; Go to $9A12
}


;;; $9A2A: Instruction list -  ;;;
{
$A6:9A2A             dx 0010,9FEA,
                        9BB2,       ; ???
                        0008,A03C,
                        9C02,       ; ???
                        0010,A08E,
                        0008,A03C,
                        80ED,99FA   ; Go to $99FA
}


;;; $9A42: Instruction list -  ;;;
{
$A6:9A42             dx 7FFF,9FEA,
                        812F        ; Sleep
}
}


;;; $9A48: Fake Kraid constants ;;;
{
$A6:9A48             dw FE00,FB00
$A6:9A4C             dw FC00,FB00
$A6:9A50             dw 0200,FB00
$A6:9A54             dw 0400,FB00
}


;;; $9A58: Initialisation AI - enemy $E0FF (fake Kraid) ;;;
{
$A6:9A58 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9A5B AD E5 05    LDA $05E5  [$7E:05E5]
$A6:9A5E 29 03 00    AND #$0003
$A6:9A61 18          CLC
$A6:9A62 69 02 00    ADC #$0002
$A6:9A65 9D AE 0F    STA $0FAE,x[$7E:106E]
$A6:9A68 9D B0 0F    STA $0FB0,x[$7E:1070]
$A6:9A6B 18          CLC
$A6:9A6C 69 40 00    ADC #$0040
$A6:9A6F 9F 06 78 7E STA $7E7806,x[$7E:78C6]
$A6:9A73 18          CLC
$A6:9A74 69 20 00    ADC #$0020
$A6:9A77 9F 08 78 7E STA $7E7808,x[$7E:78C8]
$A6:9A7B 18          CLC
$A6:9A7C 69 D0 FF    ADC #$FFD0
$A6:9A7F 9F 0A 78 7E STA $7E780A,x[$7E:78CA]
$A6:9A83 A9 00 00    LDA #$0000
$A6:9A86 9F 0E 78 7E STA $7E780E,x[$7E:78CE]
$A6:9A8A BD 86 0F    LDA $0F86,x[$7E:1046]
$A6:9A8D 09 00 20    ORA #$2000
$A6:9A90 9D 86 0F    STA $0F86,x[$7E:1046]
$A6:9A93 A9 01 00    LDA #$0001
$A6:9A96 9D 94 0F    STA $0F94,x[$7E:1054]
$A6:9A99 9E 90 0F    STZ $0F90,x[$7E:1050]
$A6:9A9C A9 FC FF    LDA #$FFFC
$A6:9A9F 9D AA 0F    STA $0FAA,x[$7E:106A]
$A6:9AA2 9D AC 0F    STA $0FAC,x[$7E:106C]
$A6:9AA5 A0 AE 99    LDY #$99AE
$A6:9AA8 BD 7A 0F    LDA $0F7A,x[$7E:103A]
$A6:9AAB 38          SEC
$A6:9AAC ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A6:9AAF 10 0C       BPL $0C    [$9ABD]
$A6:9AB1 A9 04 00    LDA #$0004
$A6:9AB4 9D AA 0F    STA $0FAA,x[$7E:106A]
$A6:9AB7 9D AC 0F    STA $0FAC,x[$7E:106C]
$A6:9ABA A0 FC 99    LDY #$99FC

$A6:9ABD 98          TYA
$A6:9ABE 9D 92 0F    STA $0F92,x[$7E:1052]
$A6:9AC1 6B          RTL
}


;;; $9AC2: Main AI - enemy $E0FF (fake Kraid) ;;;
{
$A6:9AC2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9AC5 BF 0E 78 7E LDA $7E780E,x[$7E:78CE]
$A6:9AC9 A8          TAY
$A6:9ACA 1A          INC A
$A6:9ACB 1A          INC A
$A6:9ACC C9 06 00    CMP #$0006
$A6:9ACF 30 03       BMI $03    [$9AD4]
$A6:9AD1 A9 00 00    LDA #$0000

$A6:9AD4 9F 0E 78 7E STA $7E780E,x[$7E:78CE]
$A6:9AD8 20 DC 9A    JSR $9ADC  [$A6:9ADC]
$A6:9ADB 6B          RTL
}


;;; $9ADC:  ;;;
{
; Typo at $9B18 >_<;
$A6:9ADC DA          PHX
$A6:9ADD 98          TYA
$A6:9ADE 86 12       STX $12    [$7E:0012]
$A6:9AE0 18          CLC
$A6:9AE1 65 12       ADC $12    [$7E:0012]
$A6:9AE3 AA          TAX
$A6:9AE4 BF 06 78 7E LDA $7E7806,x[$7E:78C6]
$A6:9AE8 F0 07       BEQ $07    [$9AF1]
$A6:9AEA 3A          DEC A
$A6:9AEB 9F 06 78 7E STA $7E7806,x[$7E:78C6]
$A6:9AEF FA          PLX
$A6:9AF0 60          RTS

$A6:9AF1 AD E5 05    LDA $05E5  [$7E:05E5]
$A6:9AF4 29 3F 00    AND #$003F
$A6:9AF7 18          CLC
$A6:9AF8 69 10 00    ADC #$0010
$A6:9AFB 9F 06 78 7E STA $7E7806,x[$7E:78CA]
$A6:9AFF 98          TYA
$A6:9B00 FA          PLX
$A6:9B01 9F 0C 78 7E STA $7E780C,x[$7E:78CC]
$A6:9B05 A0 BE 9D    LDY #$9DBE             ; Y = $9DBE (mini Kraid spikes - left)
$A6:9B08 BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A6:9B0B 30 03       BMI $03    [$9B10]     ;} If [enemy $0FAC] & 8000h = 0:
$A6:9B0D A0 CC 9D    LDY #$9DCC             ; Y = $9DCC (mini Kraid spikes - right)

$A6:9B10 22 27 80 86 JSL $868027[$86:8027]  ; Spawn enemy projectile
$A6:9B14 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$A6:9B18 2F FF FF 00 AND $00FFFF[$00:FFFF]  ;} If enemy centre is on screen:
$A6:9B1C D0 07       BNE $07    [$9B25]     ;/
$A6:9B1E A9 3F 00    LDA #$003F             ;\
$A6:9B21 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 3Fh, sound library 2, max queued sounds allowed = 6 (fake Kraid lint)

$A6:9B25 60          RTS
}


;;; $9B26: Instruction ;;;
{
$A6:9B26 5A          PHY
$A6:9B27 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9B2A BD B0 0F    LDA $0FB0,x[$7E:1070]
$A6:9B2D F0 03       BEQ $03    [$9B32]
$A6:9B2F DE B0 0F    DEC $0FB0,x[$7E:1070]

$A6:9B32 DE AE 0F    DEC $0FAE,x[$7E:106E]
$A6:9B35 D0 0F       BNE $0F    [$9B46]
$A6:9B37 AD E5 05    LDA $05E5  [$7E:05E5]
$A6:9B3A 29 03 00    AND #$0003
$A6:9B3D 18          CLC
$A6:9B3E 69 07 00    ADC #$0007
$A6:9B41 9D AE 0F    STA $0FAE,x[$7E:106E]
$A6:9B44 80 0D       BRA $0D    [$9B53]

$A6:9B46 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;\
$A6:9B49 85 14       STA $14    [$7E:0014]  ;|
$A6:9B4B 64 12       STZ $12    [$7E:0012]  ;} Move enemy right by [enemy X velocity]
$A6:9B4D 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A6:9B51 90 0A       BCC $0A    [$9B5D]     ; If not collided with wall: go to BRANCH_NO_COLLISION

$A6:9B53 BD AA 0F    LDA $0FAA,x[$7E:106A]
$A6:9B56 49 FF FF    EOR #$FFFF
$A6:9B59 1A          INC A
$A6:9B5A 9D AA 0F    STA $0FAA,x[$7E:106A]

; BRANCH_NO_COLLISION
$A6:9B5D A9 FC FF    LDA #$FFFC
$A6:9B60 9D AC 0F    STA $0FAC,x[$7E:106C]
$A6:9B63 BD 7A 0F    LDA $0F7A,x[$7E:103A]
$A6:9B66 38          SEC
$A6:9B67 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A6:9B6A 10 06       BPL $06    [$9B72]
$A6:9B6C A9 04 00    LDA #$0004
$A6:9B6F 9D AC 0F    STA $0FAC,x[$7E:106C]

$A6:9B72 7A          PLY
$A6:9B73 6B          RTL
}


;;; $9B74: Instruction ;;;
{
$A6:9B74 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9B77 BD B0 0F    LDA $0FB0,x[$7E:1070]
$A6:9B7A D0 19       BNE $19    [$9B95]
$A6:9B7C AD E5 05    LDA $05E5  [$7E:05E5]
$A6:9B7F 29 03 00    AND #$0003
$A6:9B82 18          CLC
$A6:9B83 69 03 00    ADC #$0003
$A6:9B86 9D B0 0F    STA $0FB0,x[$7E:1070]
$A6:9B89 A0 2A 9A    LDY #$9A2A
$A6:9B8C BD AC 0F    LDA $0FAC,x[$7E:106C]
$A6:9B8F 10 14       BPL $14    [$9BA5]
$A6:9B91 A0 DC 99    LDY #$99DC
$A6:9B94 6B          RTL

$A6:9B95 BD AC 0F    LDA $0FAC,x[$7E:106C]
$A6:9B98 30 0C       BMI $0C    [$9BA6]
$A6:9B9A A0 FC 99    LDY #$99FC
$A6:9B9D BD AA 0F    LDA $0FAA,x[$7E:106A]
$A6:9BA0 10 03       BPL $03    [$9BA5]
$A6:9BA2 A0 14 9A    LDY #$9A14

$A6:9BA5 6B          RTL

$A6:9BA6 A0 AE 99    LDY #$99AE
$A6:9BA9 BD AA 0F    LDA $0FAA,x[$7E:106A]
$A6:9BAC 30 F7       BMI $F7    [$9BA5]
$A6:9BAE A0 C6 99    LDY #$99C6
$A6:9BB1 6B          RTL
}


;;; $9BB2: Instruction ;;;
{
; Another AND instruction typo
$A6:9BB2 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$A6:9BB6 2F FF FF 00 AND $00FFFF[$00:FFFF]  ;} If enemy centre is on screen:
$A6:9BBA D0 07       BNE $07    [$9BC3]     ;/
$A6:9BBC A9 16 00    LDA #$0016             ;\
$A6:9BBF 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 16h, sound library 2, max queued sounds allowed = 6 (fake Kraid cry)

$A6:9BC3 6B          RTL
}


;;; $9BC4: Instruction ;;;
{
$A6:9BC4 5A          PHY
$A6:9BC5 A0 00 00    LDY #$0000
$A6:9BC8 A9 FC FF    LDA #$FFFC
}


;;; $9BCB:  ;;;
{
$A6:9BCB AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9BCE 5A          PHY
$A6:9BCF DA          PHX
$A6:9BD0 9F 04 78 7E STA $7E7804,x[$7E:78C4]
$A6:9BD4 B9 48 9A    LDA $9A48,y[$A6:9A48]
$A6:9BD7 9F 00 78 7E STA $7E7800,x[$7E:78C0]
$A6:9BDB B9 4A 9A    LDA $9A4A,y[$A6:9A4A]
$A6:9BDE 9F 02 78 7E STA $7E7802,x[$7E:78C2]
$A6:9BE2 A0 B0 9D    LDY #$9DB0             ;\
$A6:9BE5 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn mini Kraid spit enemy projectile
$A6:9BE9 FA          PLX
$A6:9BEA 7A          PLY
$A6:9BEB B9 4C 9A    LDA $9A4C,y[$A6:9A4C]
$A6:9BEE 9F 00 78 7E STA $7E7800,x[$7E:78C0]
$A6:9BF2 B9 4E 9A    LDA $9A4E,y[$A6:9A4E]
$A6:9BF5 9F 02 78 7E STA $7E7802,x[$7E:78C2]
$A6:9BF9 A0 B0 9D    LDY #$9DB0             ;\
$A6:9BFC 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn mini Kraid spit enemy projectile
$A6:9C00 7A          PLY
$A6:9C01 6B          RTL
}


;;; $9C02: Instruction ;;;
{
$A6:9C02 5A          PHY
$A6:9C03 A0 08 00    LDY #$0008
$A6:9C06 A9 04 00    LDA #$0004
$A6:9C09 80 C0       BRA $C0    [$9BCB]
}


;;; $9C0B:  ;;;
{
$A6:9C0B AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9C0E BD 7A 0F    LDA $0F7A,x
$A6:9C11 8F 34 F4 7E STA $7EF434[$7E:F434]
$A6:9C15 BD 7E 0F    LDA $0F7E,x
$A6:9C18 8F 36 F4 7E STA $7EF436[$7E:F436]
$A6:9C1C 22 B7 A5 A0 JSL $A0A5B7[$A0:A5B7]  ; Normal enemy power bomb AI - no death check
$A6:9C20 80 2E       BRA $2E    [$9C50]
}


;;; $9C22: Enemy touch - enemy $E0FF (fake Kraid) ;;;
{
$A6:9C22 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9C25 BD 7A 0F    LDA $0F7A,x[$7E:103A]
$A6:9C28 8F 34 F4 7E STA $7EF434[$7E:F434]
$A6:9C2C BD 7E 0F    LDA $0F7E,x[$7E:103E]
$A6:9C2F 8F 36 F4 7E STA $7EF436[$7E:F436]
$A6:9C33 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal enemy touch AI - no death check
$A6:9C37 80 17       BRA $17    [$9C50]
}


;;; $9C39: Power bomb reaction / enemy shot - enemy $E0FF (fake Kraid) ;;;
{
$A6:9C39 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9C3C BD 7A 0F    LDA $0F7A,x[$7E:103A]
$A6:9C3F 8F 34 F4 7E STA $7EF434[$7E:F434]
$A6:9C43 BD 7E 0F    LDA $0F7E,x[$7E:103E]
$A6:9C46 8F 36 F4 7E STA $7EF436[$7E:F436]
$A6:9C4A 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A6:9C4E 80 00       BRA $00    [$9C50]
}


;;; $9C50: Fake Kraid reaction ;;;
{
$A6:9C50 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:9C53 BD 8C 0F    LDA $0F8C,x[$7E:104C]
$A6:9C56 D0 0B       BNE $0B    [$9C63]
$A6:9C58 A9 03 00    LDA #$0003             ; A = 3 (mini-Kraid explosion)
$A6:9C5B 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death
$A6:9C5F 22 EE B8 A0 JSL $A0B8EE[$A0:B8EE]  ; Mini-Kraid death item drop routine

$A6:9C63 6B          RTL
}


;;; $9C64: Fake Kraid spritemaps ;;;
{
$A6:9C64             dx 0010, 01E2,17,2125, 81EA,0F,2116, 81EA,07,2106, 81FB,0F,2163, 8001,0F,2100, 000D,17,2120, 01E8,F2,211E, 0014,15,2130, 81F0,DF,2102, 81F8,DF,2103, 81F8,EF,2123, 81E8,EF,2121, 81F3,0F,2162, 81E3,0F,2160, 81F3,FF,2142, 81E3,FF,2140
$A6:9CB6             dx 0010, 81EA,0F,2119, 81EA,07,2109, 01E4,17,2125, 81FB,0E,2163, 8002,0D,2100, 000D,15,2120, 01E8,F1,211E, 0013,17,2130, 81F0,DE,2102, 81F8,DE,2103, 81F8,EE,2123, 81E8,EE,2121, 81F3,0E,2162, 81E3,0E,2160, 81F3,FE,2142, 81E3,FE,2140
$A6:9D08             dx 0010, 01E1,14,212B, 81E9,0C,211C, 81E9,04,210C, 81FB,0D,2163, 8001,0F,2100, 000D,15,2120, 01E8,F0,211E, 0014,14,2130, 81F0,DD,2102, 81F8,DD,2103, 81F8,ED,2123, 81E8,ED,2121, 81F3,0D,2162, 81E3,0D,2160, 81F3,FD,2142, 81E3,FD,2140
$A6:9D5A             dx 0010, 01DA,17,2154, 81E2,0F,2145, 81EA,07,2136, 81FB,0D,2163, 8002,10,2100, 000D,12,2120, 01E8,F0,211E, 0013,0F,2130, 81F0,DD,2102, 81F8,DD,2103, 81F8,ED,2123, 81E8,ED,2121, 81F3,0D,2162, 81E3,0D,2160, 81F3,FD,2142, 81E3,FD,2140
$A6:9DAC             dx 0010, 01E8,F2,210E, 01E2,17,2125, 81EA,0F,2116, 81EA,07,2106, 81FB,0F,2163, 8002,12,2100, 000F,17,2120, 0016,18,2130, 81F0,DF,2102, 81F8,DF,2103, 81F8,EF,2123, 81E8,EF,2121, 81F3,0F,2162, 81E3,0F,2160, 81F3,FF,2142, 81E3,FF,2140
$A6:9DFE             dx 0010, 81F8,EF,215A, 01E8,F2,210E, 81F8,DF,213A, 81E8,EF,2158, 81F0,DF,2139, 01E2,17,2125, 81EA,0F,2116, 81EA,07,2106, 81FB,0F,2163, 8002,12,2100, 000F,17,2120, 0016,18,2130, 81F3,0F,2162, 81E3,0F,2160, 81F3,FF,2142, 81E3,FF,2140
$A6:9E50             dx 0010, 81F0,DF,213D, 81F8,EF,215E, 81F8,DF,213E, 01E8,F2,210E, 81E8,EF,2158, 01E2,17,2125, 81EA,0F,2116, 81EA,07,2106, 81FB,0F,2163, 8002,12,2100, 000F,17,2120, 0016,18,2130, 81F3,0F,2162, 81E3,0F,2160, 81F3,FF,2142, 81E3,FF,2140
$A6:9EA2             dx 0010, 0016,17,6125, 8006,0F,6116, 8006,07,6106, 81F5,0F,6163, 81EF,0F,6100, 01EB,17,6120, 0010,F2,611E, 01E4,15,6130, 8000,DF,6102, 81F8,DF,6103, 81F8,EF,6123, 8008,EF,6121, 81FD,0F,6162, 800D,0F,6160, 81FD,FF,6142, 800D,FF,6140
$A6:9EF4             dx 0010, 8006,0F,6119, 8006,07,6109, 0014,17,6125, 81F5,0E,6163, 81EE,0D,6100, 01EB,15,6120, 0010,F1,611E, 01E5,17,6130, 8000,DE,6102, 81F8,DE,6103, 81F8,EE,6123, 8008,EE,6121, 81FD,0E,6162, 800D,0E,6160, 81FD,FE,6142, 800D,FE,6140
$A6:9F46             dx 0010, 0017,14,612B, 8007,0C,611C, 8007,04,610C, 81F5,0D,6163, 81EF,0F,6100, 01EB,15,6120, 0010,F0,611E, 01E4,14,6130, 8000,DD,6102, 81F8,DD,6103, 81F8,ED,6123, 8008,ED,6121, 81FD,0D,6162, 800D,0D,6160, 81FD,FD,6142, 800D,FD,6140
$A6:9F98             dx 0010, 001E,17,6154, 800E,0F,6145, 8006,07,6136, 81F5,0D,6163, 81EE,10,6100, 01EB,12,6120, 0010,F0,611E, 01E5,0F,6130, 8000,DD,6102, 81F8,DD,6103, 81F8,ED,6123, 8008,ED,6121, 81FD,0D,6162, 800D,0D,6160, 81FD,FD,6142, 800D,FD,6140
$A6:9FEA             dx 0010, 0010,F2,610E, 0016,17,6125, 8006,0F,6116, 8006,07,6106, 81F5,0F,6163, 81EE,12,6100, 01E9,17,6120, 01E2,18,6130, 8000,DF,6102, 81F8,DF,6103, 81F8,EF,6123, 8008,EF,6121, 81FD,0F,6162, 800D,0F,6160, 81FD,FF,6142, 800D,FF,6140
$A6:A03C             dx 0010, 81F8,EF,615A, 0010,F2,610E, 81F8,DF,613A, 8008,EF,6158, 8000,DF,6139, 0016,17,6125, 8006,0F,6116, 8006,07,6106, 81F5,0F,6163, 81EE,12,6100, 01E9,17,6120, 01E2,18,6130, 81FD,0F,6162, 800D,0F,6160, 81FD,FF,6142, 800D,FF,6140
$A6:A08E             dx 0010, 8000,DF,613D, 81F8,EF,615E, 81F8,DF,613E, 0010,F2,610E, 8008,EF,6158, 0016,17,6125, 8006,0F,6116, 8006,07,6106, 81F5,0F,6163, 81EE,12,6100, 01E9,17,6120, 01E2,18,6130, 81FD,0F,6162, 800D,0F,6160, 81FD,FF,6142, 800D,FF,6140
$A6:A0E0             dx 0001, 01FD,FD,211F
$A6:A0E7             dx 0001, 01FC,FC,210F
$A6:A0EE             dx 0001, 01FC,FC,610F
}
}


;;; $A0F5..EFB0: Ridley ;;;
{
;;; $A0F5: Initialisation AI - enemy $E13F/$E17F (Ridley) ;;;
{
$A6:A0F5 AE 9F 07    LDX $079F  [$7E:079F]
$A6:A0F8 BF 28 D8 7E LDA $7ED828,x[$7E:D82E]
$A6:A0FC 29 01 00    AND #$0001
$A6:A0FF F0 0D       BEQ $0D    [$A10E]
$A6:A101 AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:A104 29 FF FF    AND #$FFFF
$A6:A107 09 00 07    ORA #$0700
$A6:A10A 8D 86 0F    STA $0F86  [$7E:0F86]
$A6:A10D 6B          RTL

$A6:A10E 8B          PHB
$A6:A10F F4 7E 7E    PEA $7E7E
$A6:A112 AB          PLB
$A6:A113 AB          PLB
$A6:A114 A9 00 00    LDA #$0000
$A6:A117 A2 FE 0F    LDX #$0FFE

$A6:A11A 9D 00 20    STA $2000,x[$7E:2FFE]
$A6:A11D CA          DEX
$A6:A11E CA          DEX
$A6:A11F 10 F9       BPL $F9    [$A11A]
$A6:A121 AB          PLB
$A6:A122 22 E2 A7 90 JSL $90A7E2[$90:A7E2]  ; Disable mini-map and mark boss room map tiles as explored
$A6:A126 9C B4 0F    STZ $0FB4  [$7E:0FB4]
$A6:A129 9C B6 0F    STZ $0FB6  [$7E:0FB6]
$A6:A12C A9 38 E5    LDA #$E538
$A6:A12F 20 67 D4    JSR $D467  [$A6:D467]
$A6:A132 A9 00 0E    LDA #$0E00
$A6:A135 8D 96 0F    STA $0F96  [$7E:0F96]
$A6:A138 8F 18 78 7E STA $7E7818[$7E:7818]
$A6:A13C AD 88 0F    LDA $0F88  [$7E:0F88]
$A6:A13F 09 04 00    ORA #$0004
$A6:A142 8D 88 0F    STA $0F88  [$7E:0F88]
$A6:A145 A9 00 00    LDA #$0000
$A6:A148 8F 02 78 7E STA $7E7802[$7E:7802]
$A6:A14C 8F 1A 78 7E STA $7E781A[$7E:781A]
$A6:A150 9C 3E 18    STZ $183E  [$7E:183E]  ; Earthquake type = 0
$A6:A153 9C 40 18    STZ $1840  [$7E:1840]  ; Earthquake timer = 0
$A6:A156 20 D6 D2    JSR $D2D6  [$A6:D2D6]
$A6:A159 20 FD D9    JSR $D9FD  [$A6:D9FD]
$A6:A15C AD 9F 07    LDA $079F  [$7E:079F]
$A6:A15F C9 02 00    CMP #$0002
$A6:A162 F0 03       BEQ $03    [$A167]
$A6:A164 4C EE A1    JMP $A1EE  [$A6:A1EE]

$A6:A167 AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:A16A 09 00 14    ORA #$1400
$A6:A16D 8D 86 0F    STA $0F86  [$7E:0F86]
$A6:A170 A9 60 00    LDA #$0060
$A6:A173 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A6:A176 A9 8A 01    LDA #$018A
$A6:A179 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A6:A17C A9 F3 B2    LDA #$B2F3             ; >_<;
$A6:A17F A9 5B A3    LDA #$A35B
$A6:A182 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A185 9C AA 0F    STZ $0FAA  [$7E:0FAA]
$A6:A188 9C AC 0F    STZ $0FAC  [$7E:0FAC]
$A6:A18B A9 05 00    LDA #$0005
$A6:A18E 8D 9A 0F    STA $0F9A  [$7E:0F9A]
$A6:A191 A9 00 00    LDA #$0000
$A6:A194 8F 02 78 7E STA $7E7802[$7E:7802]
$A6:A198 1A          INC A
$A6:A199 8F 04 78 7E STA $7E7804[$7E:7804]
$A6:A19D A9 40 00    LDA #$0040
$A6:A1A0 8F 00 80 7E STA $7E8000[$7E:8000]
$A6:A1A4 A9 A0 01    LDA #$01A0
$A6:A1A7 8F 02 80 7E STA $7E8002[$7E:8002]
$A6:A1AB A9 40 00    LDA #$0040
$A6:A1AE 8F 04 80 7E STA $7E8004[$7E:8004]
$A6:A1B2 A9 E0 00    LDA #$00E0
$A6:A1B5 8F 06 80 7E STA $7E8006[$7E:8006]
$A6:A1B9 A9 02 00    LDA #$0002
$A6:A1BC 8F 20 78 7E STA $7E7820[$7E:7820]
$A6:A1C0 A9 78 00    LDA #$0078
$A6:A1C3 8F 38 78 7E STA $7E7838[$7E:7838]
$A6:A1C7 A0 CF E1    LDY #$E1CF
$A6:A1CA A2 40 01    LDX #$0140
$A6:A1CD A9 20 00    LDA #$0020
$A6:A1D0 22 F6 D2 A9 JSL $A9D2F6[$A9:D2F6]
$A6:A1D4 A2 E2 00    LDX #$00E2
$A6:A1D7 A2 00 00    LDX #$0000
$A6:A1DA A0 0F 00    LDY #$000F
$A6:A1DD A9 00 00    LDA #$0000

$A6:A1E0 9F E2 C2 7E STA $7EC2E2,x[$7E:C2E2]
$A6:A1E4 9F E2 C3 7E STA $7EC3E2,x[$7E:C3E2]
$A6:A1E8 E8          INX
$A6:A1E9 E8          INX
$A6:A1EA 88          DEY
$A6:A1EB D0 F3       BNE $F3    [$A1E0]
$A6:A1ED 6B          RTL

$A6:A1EE AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:A1F1 09 00 14    ORA #$1400
$A6:A1F4 8D 86 0F    STA $0F86  [$7E:0F86]
$A6:A1F7 A9 BA 00    LDA #$00BA
$A6:A1FA 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A6:A1FD A9 A9 00    LDA #$00A9
$A6:A200 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A6:A203 A9 00 00    LDA #$0000
$A6:A206 8D 3F 09    STA $093F  [$7E:093F]
$A6:A209 8F 20 78 7E STA $7E7820[$7E:7820]
$A6:A20D 8F 04 78 7E STA $7E7804[$7E:7804]
$A6:A211 1A          INC A
$A6:A212 8F 02 20 7E STA $7E2002[$7E:2002]
$A6:A216 A9 0F 00    LDA #$000F
$A6:A219 8F 38 78 7E STA $7E7838[$7E:7838]
$A6:A21D A9 5B A3    LDA #$A35B
$A6:A220 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A223 9C AA 0F    STZ $0FAA  [$7E:0FAA]
$A6:A226 9C AC 0F    STZ $0FAC  [$7E:0FAC]
$A6:A229 A9 E0 FF    LDA #$FFE0
$A6:A22C 8F 00 80 7E STA $7E8000[$7E:8000]
$A6:A230 A9 B0 00    LDA #$00B0
$A6:A233 8F 02 80 7E STA $7E8002[$7E:8002]
$A6:A237 A9 28 00    LDA #$0028
$A6:A23A 8F 04 80 7E STA $7E8004[$7E:8004]
$A6:A23E A9 E0 00    LDA #$00E0
$A6:A241 8F 06 80 7E STA $7E8006[$7E:8006]
$A6:A245 A0 6F E1    LDY #$E16F
$A6:A248 A2 40 01    LDX #$0140
$A6:A24B A9 20 00    LDA #$0020
$A6:A24E 22 F6 D2 A9 JSL $A9D2F6[$A9:D2F6]
$A6:A252 A2 E2 01    LDX #$01E2
$A6:A255 A0 0F 00    LDY #$000F
$A6:A258 A9 00 00    LDA #$0000

$A6:A25B 9F 00 C2 7E STA $7EC200,x[$7E:C3E2]
$A6:A25F E8          INX
$A6:A260 E8          INX
$A6:A261 88          DEY
$A6:A262 D0 F7       BNE $F7    [$A25B]
$A6:A264 A9 31 BF    LDA #$BF31
$A6:A267 8F 06 78 7E STA $7E7806[$7E:7806]
$A6:A26B A9 01 00    LDA #$0001
$A6:A26E 8F 08 78 7E STA $7E7808[$7E:7808]
$A6:A272 A9 9C BE    LDA #$BE9C
$A6:A275 8F 00 88 7E STA $7E8800[$7E:8800]
$A6:A279 A9 05 00    LDA #$0005
$A6:A27C 8F 0E 78 7E STA $7E780E[$7E:780E]
$A6:A280 A9 00 00    LDA #$0000             ;\
$A6:A283 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$A6:A287 6B          RTL
}


;;; $A288: Main AI - enemy $E13F (Ceres Ridley) ;;;
{
$A6:A288 A9 FF 7F    LDA #$7FFF
$A6:A28B 8D 8C 0F    STA $0F8C  [$7E:0F8C]
$A6:A28E F4 93 A2    PEA $A293
$A6:A291 6C A8 0F    JMP ($0FA8)[$A6:A35B]

$A6:A294 AD 3F 09    LDA $093F  [$7E:093F]
$A6:A297 D0 23       BNE $23    [$A2BC]
$A6:A299 AF 04 78 7E LDA $7E7804[$7E:7804]
$A6:A29D F0 3D       BEQ $3D    [$A2DC]
$A6:A29F 20 DA D4    JSR $D4DA  [$A6:D4DA]
$A6:A2A2 20 6B D8    JSR $D86B  [$A6:D86B]
$A6:A2A5 20 7D D9    JSR $D97D  [$A6:D97D]
$A6:A2A8 20 BD A2    JSR $A2BD  [$A6:A2BD]
$A6:A2AB 20 F5 CA    JSR $CAF5  [$A6:CAF5]
$A6:A2AE 20 B5 D4    JSR $D4B5  [$A6:D4B5]
$A6:A2B1 20 0C DA    JSR $DA0C  [$A6:DA0C]
$A6:A2B4 20 2A DB    JSR $DB2A  [$A6:DB2A]
$A6:A2B7 20 D8 DA    JSR $DAD8  [$A6:DAD8]
$A6:A2BA 80 20       BRA $20    [$A2DC]

$A6:A2BC 6B          RTL
}


;;; $A2BD:  ;;;
{
; 1/100 chance of setting 7E:201E to 7-16 (all hex numbers)
$A6:A2BD AD E5 05    LDA $05E5  [$7E:05E5]
$A6:A2C0 C9 00 FF    CMP #$FF00
$A6:A2C3 90 0D       BCC $0D    [$A2D2]
$A6:A2C5 AD E5 05    LDA $05E5  [$7E:05E5]
$A6:A2C8 29 0F 00    AND #$000F
$A6:A2CB 69 07 00    ADC #$0007
$A6:A2CE 8F 1E 20 7E STA $7E201E[$7E:201E]

$A6:A2D2 60          RTS
}


;;; $A2D3: Hurt AI - enemy $E13F (Ceres Ridley) ;;;
{
$A6:A2D3 20 DA D4    JSR $D4DA  [$A6:D4DA]
$A6:A2D6 20 2A DB    JSR $DB2A  [$A6:DB2A]
$A6:A2D9 20 D8 DA    JSR $DAD8  [$A6:DAD8]
}


;;; $A2DC:  ;;;
{
$A6:A2DC 20 93 BE    JSR $BE93  [$A6:BE93]
$A6:A2DF AF 04 78 7E LDA $7E7804[$7E:7804]
$A6:A2E3 F0 0D       BEQ $0D    [$A2F2]
$A6:A2E5 A9 00 A6    LDA #$A600
$A6:A2E8 8D 8D 17    STA $178D  [$7E:178D]
$A6:A2EB A9 F2 A2    LDA #$A2F2
$A6:A2EE 8D 8C 17    STA $178C  [$7E:178C]
$A6:A2F1 6B          RTL
}


;;; $A2F2: Enemy graphics drawn hook - Ceres Ridley - draw Baby Metroid and door ;;;
{
; Enemy 1 is the Ceres door
$A6:A2F2 AD 3F 09    LDA $093F  [$7E:093F]  ;\
$A6:A2F5 D0 03       BNE $03    [$A2FA]     ;} If [Ceres status] = before Ridley escape:
$A6:A2F7 20 1A BF    JSR $BF1A  [$A6:BF1A]  ; Draw Baby Metroid

$A6:A2FA AD EA 0F    LDA $0FEA  [$7E:0FEA]  ;\
$A6:A2FD F0 21       BEQ $21    [$A320]     ;} If [enemy 1 drawn by Ridley flag] = 0: return
$A6:A2FF AD 40 18    LDA $1840  [$7E:1840]  ;\
$A6:A302 29 03 00    AND #$0003             ;|
$A6:A305 AA          TAX                    ;|
$A6:A306 BD 21 A3    LDA $A321,x[$A6:A321]  ;} Spritemap Y position = [$A321 + [earthquake timer] % 4] + [enemy 1 X position]
$A6:A309 18          CLC                    ;|
$A6:A30A 6D BA 0F    ADC $0FBA  [$7E:0FBA]  ;|
$A6:A30D 85 14       STA $14    [$7E:0014]  ;/
$A6:A30F AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A6:A312 85 12       STA $12    [$7E:0012]  ;} Spritemap X position = [enemy 1 Y position]
$A6:A314 A9 00 04    LDA #$0400             ;\
$A6:A317 85 16       STA $16    [$7E:0016]  ;} Spritemap palette bits = 400h (palette 2)
$A6:A319 A0 29 A3    LDY #$A329             ; Spritemap address = $A329 (Ceres Ridley door)
$A6:A31C 22 9F 87 81 JSL $81879F[$81:879F]  ; Add spritemap to OAM

$A6:A320 6B          RTL
}


;;; $A321: Ceres Ridley door X offsets during earthquake ;;;
{
; Actually, this table is being indexed in one byte increments, meaning these values should have been 8-bit.
; Only the lower 8 bits are used in practice, so the resulting actual read values are as if:
;     db 00, 00, FC, FF
$A6:A321             dw 0000, FFFC, FFFF, 0003
}


;;; $A329: Spritemap - Ceres Ridley door ;;;
{
$A6:A329             dx 0008, 0000,18,A0D1, 0000,E0,20D1, 0000,10,A0D3, 0000,E8,20D3, 0000,00,A0F2, 0000,08,A0E2, 0000,F8,20F2, 0000,F0,20E2
}


;;; $A353: RTL ;;;
{
$A6:A353 6B          RTL
}


;;; $A354: Ridley function ;;;
{
; Clear speeds, that's it
$A6:A354 9C AA 0F    STZ $0FAA  [$7E:0FAA]
$A6:A357 9C AC 0F    STZ $0FAC  [$7E:0FAC]
$A6:A35A 60          RTS
}


;;; $A35B: Ridley function ;;;
{
; Startup, 1st run
$A6:A35B AD 97 07    LDA $0797  [$7E:0797]
$A6:A35E D0 28       BNE $28    [$A388]
$A6:A360 A9 77 A3    LDA #$A377
$A6:A363 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A366 A9 00 02    LDA #$0200
$A6:A369 AC 9F 07    LDY $079F  [$7E:079F]
$A6:A36C C0 02 00    CPY #$0002
$A6:A36F D0 03       BNE $03    [$A374]
$A6:A371 A9 AA 00    LDA #$00AA

$A6:A374 8D B2 0F    STA $0FB2  [$7E:0FB2]
}


;;; $A377: Ridley function ;;;
{
; Startup, initial wait
$A6:A377 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A37A 10 0C       BPL $0C    [$A388]
$A6:A37C A9 89 A3    LDA #$A389
$A6:A37F 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A382 9C B0 0F    STZ $0FB0  [$7E:0FB0]
$A6:A385 9C B2 0F    STZ $0FB2  [$7E:0FB2]

$A6:A388 60          RTS
}


;;; $A389: Ridley function ;;;
{
; Startup, eyes appear + wait
$A6:A389 AD B0 0F    LDA $0FB0  [$7E:0FB0]
$A6:A38C 30 3F       BMI $3F    [$A3CD]
$A6:A38E A8          TAY
$A6:A38F EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:A392 AD B2 0F    LDA $0FB2  [$7E:0FB2]
$A6:A395 C9 01 00    CMP #$0001
$A6:A398 90 33       BCC $33    [$A3CD]
$A6:A39A 9C B2 0F    STZ $0FB2  [$7E:0FB2]
$A6:A39D BB          TYX
$A6:A39E BD 69 E2    LDA $E269,x[$A6:E269]
$A6:A3A1 29 FF 00    AND #$00FF
$A6:A3A4 C9 FF 00    CMP #$00FF
$A6:A3A7 F0 25       BEQ $25    [$A3CE]
$A6:A3A9 85 12       STA $12    [$7E:0012]
$A6:A3AB 0A          ASL A
$A6:A3AC 18          CLC
$A6:A3AD 65 12       ADC $12    [$7E:0012]
$A6:A3AF 0A          ASL A
$A6:A3B0 A8          TAY
$A6:A3B1 E8          INX
$A6:A3B2 8E B0 0F    STX $0FB0  [$7E:0FB0]
$A6:A3B5 A2 F8 01    LDX #$01F8
$A6:A3B8 B9 AA E2    LDA $E2AA,y[$A6:E304]
$A6:A3BB 9F 00 C0 7E STA $7EC000,x[$7E:C1F8]
$A6:A3BF B9 AC E2    LDA $E2AC,y[$A6:E306]
$A6:A3C2 9F 02 C0 7E STA $7EC002,x[$7E:C1FA]
$A6:A3C6 B9 AE E2    LDA $E2AE,y[$A6:E308]
$A6:A3C9 9F 04 C0 7E STA $7EC004,x[$7E:C1FC]

$A6:A3CD 60          RTS

$A6:A3CE 9C B0 0F    STZ $0FB0  [$7E:0FB0]
$A6:A3D1 A9 DF A3    LDA #$A3DF
$A6:A3D4 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A3D7 A9 01 00    LDA #$0001
$A6:A3DA 8F 04 78 7E STA $7E7804[$7E:7804]
$A6:A3DE 60          RTS
}


;;; $A3DF: Ridley function ;;;
{
; Startup, main body appears
$A6:A3DF EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:A3E2 AD B2 0F    LDA $0FB2  [$7E:0FB2]
$A6:A3E5 C9 02 00    CMP #$0002
$A6:A3E8 90 39       BCC $39    [$A423]
$A6:A3EA 9C B2 0F    STZ $0FB2  [$7E:0FB2]
$A6:A3ED AC B0 0F    LDY $0FB0  [$7E:0FB0]
$A6:A3F0 A9 22 01    LDA #$0122
$A6:A3F3 85 12       STA $12    [$7E:0012]
$A6:A3F5 A9 E2 01    LDA #$01E2
$A6:A3F8 85 14       STA $14    [$7E:0014]
$A6:A3FA A9 0B 00    LDA #$000B

$A6:A3FD 48          PHA
$A6:A3FE B9 0A E3    LDA $E30A,y[$A6:E30A]
$A6:A401 A6 12       LDX $12    [$7E:0012]
$A6:A403 9F 00 C0 7E STA $7EC000,x[$7E:C122]
$A6:A407 A6 14       LDX $14    [$7E:0014]
$A6:A409 9F 00 C0 7E STA $7EC000,x[$7E:C1E2]
$A6:A40D C8          INY
$A6:A40E C8          INY
$A6:A40F E6 12       INC $12    [$7E:0012]
$A6:A411 E6 12       INC $12    [$7E:0012]
$A6:A413 E6 14       INC $14    [$7E:0014]
$A6:A415 E6 14       INC $14    [$7E:0014]
$A6:A417 68          PLA
$A6:A418 3A          DEC A
$A6:A419 D0 E2       BNE $E2    [$A3FD]
$A6:A41B C0 60 01    CPY #$0160
$A6:A41E B0 04       BCS $04    [$A424]
$A6:A420 8C B0 0F    STY $0FB0  [$7E:0FB0]

$A6:A423 60          RTS

$A6:A424 AD 9F 07    LDA $079F  [$7E:079F]
$A6:A427 C9 02 00    CMP #$0002
$A6:A42A D0 06       BNE $06    [$A432]
$A6:A42C A9 02 00    LDA #$0002
$A6:A42F 8D 9A 0F    STA $0F9A  [$7E:0F9A]

$A6:A432 AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:A435 29 FF FB    AND #$FBFF
$A6:A438 8D 86 0F    STA $0F86  [$7E:0F86]
$A6:A43B A0 00 00    LDY #$0000
$A6:A43E 8C B0 0F    STY $0FB0  [$7E:0FB0]
$A6:A441 A9 55 A4    LDA #$A455
$A6:A444 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A447 A9 04 00    LDA #$0004
$A6:A44A 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:A44D A9 05 00    LDA #$0005             ;\
$A6:A450 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track
$A6:A454 60          RTS
}


;;; $A455: Ridley function ;;;
{
; Startup, Ridley roars
$A6:A455 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A458 10 1D       BPL $1D    [$A477]
$A6:A45A A9 90 E6    LDA #$E690
$A6:A45D 20 67 D4    JSR $D467  [$A6:D467]
$A6:A460 9C B2 0F    STZ $0FB2  [$7E:0FB2]
$A6:A463 A9 78 A4    LDA #$A478
$A6:A466 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A469 AD 9F 07    LDA $079F  [$7E:079F]
$A6:A46C C9 02 00    CMP #$0002
$A6:A46F F0 06       BEQ $06    [$A477]
$A6:A471 A9 FC 00    LDA #$00FC
$A6:A474 8D B2 0F    STA $0FB2  [$7E:0FB2]

$A6:A477 60          RTS
}


;;; $A478: Ridley function ;;;
{
; Startup, color background in Norfair, raise acid, start main AI
$A6:A478 AD 9F 07    LDA $079F  [$7E:079F]
$A6:A47B C9 02 00    CMP #$0002
$A6:A47E D0 2C       BNE $2C    [$A4AC]
$A6:A480 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A483 10 F2       BPL $F2    [$A477]
$A6:A485 A9 02 00    LDA #$0002
$A6:A488 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:A48B AD B0 0F    LDA $0FB0  [$7E:0FB0]
$A6:A48E 1A          INC A
$A6:A48F 8D B0 0F    STA $0FB0  [$7E:0FB0]
$A6:A492 3A          DEC A
$A6:A493 20 D6 A4    JSR $A4D6  [$A6:A4D6]
$A6:A496 90 DF       BCC $DF    [$A477]
$A6:A498 A9 B8 01    LDA #$01B8
$A6:A49B 8D 7A 19    STA $197A  [$7E:197A]
$A6:A49E A9 A0 FF    LDA #$FFA0
$A6:A4A1 8D 7C 19    STA $197C  [$7E:197C]
$A6:A4A4 A9 20 00    LDA #$0020
$A6:A4A7 8D 80 19    STA $1980  [$7E:1980]
$A6:A4AA 80 05       BRA $05    [$A4B1]

$A6:A4AC CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A4AF 10 C6       BPL $C6    [$A477]

$A6:A4B1 9C B0 0F    STZ $0FB0  [$7E:0FB0]
$A6:A4B4 A9 1D E9    LDA #$E91D
$A6:A4B7 20 67 D4    JSR $D467  [$A6:D467]
$A6:A4BA A9 08 00    LDA #$0008
$A6:A4BD 8F 10 78 7E STA $7E7810[$7E:7810]
$A6:A4C1 8F 12 78 7E STA $7E7812[$7E:7812]
$A6:A4C5 20 D9 D3    JSR $D3D9  [$A6:D3D9]
$A6:A4C8 A9 01 00    LDA #$0001
$A6:A4CB 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:A4CF A9 54 A3    LDA #$A354
$A6:A4D2 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A4D5 60          RTS
}


;;; $A4D6:  ;;;
{
; Adjust background colors if necessary
$A6:A4D6 0A          ASL A
$A6:A4D7 AA          TAX
$A6:A4D8 BC EB A4    LDY $A4EB,x[$A6:A4EB]
$A6:A4DB D0 02       BNE $02    [$A4DF]
$A6:A4DD 38          SEC
$A6:A4DE 60          RTS

$A6:A4DF A2 E2 00    LDX #$00E2
$A6:A4E2 A9 0E 00    LDA #$000E
$A6:A4E5 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]
$A6:A4E9 18          CLC
$A6:A4EA 60          RTS

$A6:A4EB             dw A50B, A527, A543, A55F, A57B, A597, A5B3, A5CF, A5EB, A607, A623, A63F, A65B, A677, A693, 0000

$A6:A50B             dw 0001,0001,0001,0000,0000,0000,0000,0001,0000,0000,0000,0000,0000,0842
$A6:A527             dw 0023,0003,0003,0001,0001,0000,0000,0001,0001,0000,0000,0001,0001,1084
$A6:A543             dw 0044,0024,0004,0402,0001,0000,0000,0002,0001,0000,0000,0001,0001,18C6
$A6:A55F             dw 0065,0025,0005,0403,0002,0001,0000,0003,0002,0001,0000,0002,0002,2108
$A6:A57B             dw 0087,0047,0007,0404,0402,0001,0000,0004,0003,0001,0000,0402,0003,294A
$A6:A597             dw 0088,0048,0008,0804,0403,0001,0000,0005,0003,0001,0000,0403,0003,318C
$A6:A5B3             dw 00AA,004A,002A,0805,0403,0001,0000,0406,0004,0001,0000,0403,0004,39CE
$A6:A5CF             dw 00CB,006B,002B,0806,0404,0002,0000,0407,0004,0002,0000,0404,0004,4210
$A6:A5EB             dw 00ED,006D,002D,0C07,0404,0002,0000,0408,0005,0002,0000,0404,0005,4A52
$A6:A607             dw 010E,008E,002E,0C08,0805,0002,0000,0409,0006,0002,0000,0805,0006,5294
$A6:A623             dw 0110,0090,0030,0C08,0805,0003,0000,040A,0006,0003,0000,0805,0006,5AD6
$A6:A63F             dw 0131,0091,0031,1009,0806,0003,0000,040B,0007,0003,0000,0806,0007,6318
$A6:A65B             dw 0153,00B3,0033,100A,0807,0003,0000,040C,0007,0003,0000,0807,0007,6B5A
$A6:A677             dw 0574,04B4,0434,100B,0807,0403,0000,040D,0408,0003,0000,0807,0408,77BD
$A6:A693             dw 0596,04D6,0456,140C,0C08,0404,0000,080E,0409,0004,0000,0C08,0409,7FFF
}


;;; $A6AF: Ridley function ;;;
{
; Startup liftoff, facing left (Ceres)
$A6:A6AF AD AC 0F    LDA $0FAC  [$7E:0FAC]
$A6:A6B2 18          CLC
$A6:A6B3 69 F0 FF    ADC #$FFF0
$A6:A6B6 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:A6B9 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:A6BC C9 70 00    CMP #$0070
$A6:A6BF 30 01       BMI $01    [$A6C2]
$A6:A6C1 60          RTS

$A6:A6C2 A9 C8 A6    LDA #$A6C8
$A6:A6C5 8D A8 0F    STA $0FA8  [$7E:0FA8]
}


;;; $A6C8: Ridley function ;;;
{
; Startup liftoff, facing left and slowing down (Ceres)
$A6:A6C8 AD AC 0F    LDA $0FAC  [$7E:0FAC]
$A6:A6CB 18          CLC
$A6:A6CC 69 14 00    ADC #$0014
$A6:A6CF 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:A6D2 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:A6D5 C9 50 00    CMP #$0050
$A6:A6D8 10 0D       BPL $0D    [$A6E7]
$A6:A6DA A9 E8 A6    LDA #$A6E8
$A6:A6DD 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A6E0 A9 01 00    LDA #$0001
$A6:A6E3 8F 02 78 7E STA $7E7802[$7E:7802]

$A6:A6E7 60          RTS
}


;;; $A6E8: Ridley function ;;;
{
; Ceres main AI?
$A6:A6E8 AF 1A 78 7E LDA $7E781A[$7E:781A]
$A6:A6EC C9 64 00    CMP #$0064
$A6:A6EF B0 18       BCS $18    [$A709]
$A6:A6F1 AD C2 09    LDA $09C2  [$7E:09C2]
$A6:A6F4 C9 1E 00    CMP #$001E
$A6:A6F7 10 20       BPL $20    [$A719]
$A6:A6F9 A9 00 00    LDA #$0000
$A6:A6FC 8F 02 78 7E STA $7E7802[$7E:7802]
$A6:A700 A9 71 A9    LDA #$A971
$A6:A703 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A706 4C 71 A9    JMP $A971  [$A6:A971]

$A6:A709 A9 00 00    LDA #$0000
$A6:A70C 8F 02 78 7E STA $7E7802[$7E:7802]
$A6:A710 A9 9A BD    LDA #$BD9A
$A6:A713 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A716 4C 9A BD    JMP $BD9A  [$A6:BD9A]

$A6:A719 20 63 A7    JSR $A763  [$A6:A763]
$A6:A71C 90 0F       BCC $0F    [$A72D]
$A6:A71E AF 00 78 7E LDA $7E7800[$7E:7800]
$A6:A722 1A          INC A
$A6:A723 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:A727 C9 7C 00    CMP #$007C
$A6:A72A 90 16       BCC $16    [$A742]
$A6:A72C EA          NOP

$A6:A72D AD E5 05    LDA $05E5  [$7E:05E5]
$A6:A730 29 0F 00    AND #$000F
$A6:A733 0A          ASL A
$A6:A734 AA          TAX
$A6:A735 BD 43 A7    LDA $A743,x
$A6:A738 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A73B A9 00 00    LDA #$0000
$A6:A73E 8F 00 78 7E STA $7E7800[$7E:7800]

$A6:A742 60          RTS

$A6:A743             dw A782, A782, A782, A782, A83C, A83C, A83C, A83C, A83C, A782, A88D, A88D, A88D, A88D, A88D, A782
}


;;; $A763:  ;;;
{
; Ceres Ridley attack cooldown; fly towards (C0h, 64h) (return carry set if reached, carry clear otherwise)
$A6:A763 A2 C0 00    LDX #$00C0
$A6:A766 A0 64 00    LDY #$0064
$A6:A769 86 12       STX $12    [$7E:0012]
$A6:A76B 84 14       STY $14    [$7E:0014]
$A6:A76D A2 00 00    LDX #$0000
$A6:A770 A0 00 00    LDY #$0000
$A6:A773 20 2F D6    JSR $D62F  [$A6:D62F]
$A6:A776 A9 08 00    LDA #$0008
$A6:A779 85 16       STA $16    [$7E:0016]
$A6:A77B 85 18       STA $18    [$7E:0018]
$A6:A77D 22 06 EF A9 JSL $A9EF06[$A9:EF06]
$A6:A781 60          RTS
}


;;; $A782: Ridley function ;;;
{
; Ceres Ridley fireballing
$A6:A782 AD AC 0F    LDA $0FAC  [$7E:0FAC]
$A6:A785 10 04       BPL $04    [$A78B]
$A6:A787 49 FF FF    EOR #$FFFF
$A6:A78A 1A          INC A

$A6:A78B C9 80 00    CMP #$0080
$A6:A78E B0 03       BCS $03    [$A793]
$A6:A790 A9 80 00    LDA #$0080

$A6:A793 2C AC 0F    BIT $0FAC  [$7E:0FAC]
$A6:A796 10 04       BPL $04    [$A79C]
$A6:A798 49 FF FF    EOR #$FFFF
$A6:A79B 1A          INC A

$A6:A79C 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:A79F AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:A7A2 85 12       STA $12    [$7E:0012]
$A6:A7A4 A9 58 00    LDA #$0058
$A6:A7A7 85 14       STA $14    [$7E:0014]
$A6:A7A9 A2 00 00    LDX #$0000
$A6:A7AC A0 00 00    LDY #$0000
$A6:A7AF 20 2F D6    JSR $D62F  [$A6:D62F]
$A6:A7B2 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:A7B5 C9 50 00    CMP #$0050
$A6:A7B8 30 2A       BMI $2A    [$A7E4]
$A6:A7BA C9 80 00    CMP #$0080
$A6:A7BD 10 24       BPL $24    [$A7E3]
$A6:A7BF AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:A7C2 8F 2E 78 7E STA $7E782E[$7E:782E]
$A6:A7C6 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:A7C9 8F 30 78 7E STA $7E7830[$7E:7830]
$A6:A7CD A9 3A E7    LDA #$E73A
$A6:A7D0 20 67 D4    JSR $D467  [$A6:D467]
$A6:A7D3 A9 F9 A7    LDA #$A7F9
$A6:A7D6 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A7D9 A9 E0 00    LDA #$00E0
$A6:A7DC 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:A7E0 4C F9 A7    JMP $A7F9  [$A6:A7F9]

$A6:A7E3 60          RTS

$A6:A7E4 AF 00 78 7E LDA $7E7800[$7E:7800]
$A6:A7E8 1A          INC A
$A6:A7E9 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:A7ED C9 30 00    CMP #$0030
$A6:A7F0 90 F1       BCC $F1    [$A7E3]
$A6:A7F2 A9 8D A8    LDA #$A88D
$A6:A7F5 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A7F8 60          RTS
}


;;; $A7F9: Ridley function ;;;
{
$A6:A7F9 AD E5 05    LDA $05E5  [$7E:05E5]
$A6:A7FC 29 07 00    AND #$0007
$A6:A7FF 2C E5 05    BIT $05E5  [$7E:05E5]
$A6:A802 10 04       BPL $04    [$A808]
$A6:A804 49 FF FF    EOR #$FFFF
$A6:A807 1A          INC A

$A6:A808 85 16       STA $16    [$7E:0016]
$A6:A80A AF 2E 78 7E LDA $7E782E[$7E:782E]
$A6:A80E 65 16       ADC $16    [$7E:0016]
$A6:A810 85 12       STA $12    [$7E:0012]
$A6:A812 AF 30 78 7E LDA $7E7830[$7E:7830]
$A6:A816 65 16       ADC $16    [$7E:0016]
$A6:A818 85 14       STA $14    [$7E:0014]
$A6:A81A A2 00 00    LDX #$0000
$A6:A81D A0 00 00    LDY #$0000
$A6:A820 20 2F D6    JSR $D62F  [$A6:D62F]
$A6:A823 AF 00 78 7E LDA $7E7800[$7E:7800]
$A6:A827 3A          DEC A
$A6:A828 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:A82C 10 0D       BPL $0D    [$A83B]
$A6:A82E A9 00 00    LDA #$0000
$A6:A831 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:A835 A9 E8 A6    LDA #$A6E8
$A6:A838 8D A8 0F    STA $0FA8  [$7E:0FA8]

$A6:A83B 60          RTS
}


;;; $A83C: Ridley function ;;;
{
; Ceres Ridley start lunging
$A6:A83C A9 48 E5    LDA #$E548
$A6:A83F 20 67 D4    JSR $D467  [$A6:D467]
$A6:A842 A9 4E A8    LDA #$A84E
$A6:A845 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A848 A9 40 00    LDA #$0040
$A6:A84B 8D B2 0F    STA $0FB2  [$7E:0FB2]
}


;;; $A84E: Ridley function ;;;
{
$A6:A84E AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:A851 85 12       STA $12    [$7E:0012]
$A6:A853 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A6:A856 38          SEC
$A6:A857 E9 44 00    SBC #$0044
$A6:A85A C9 40 00    CMP #$0040
$A6:A85D 10 03       BPL $03    [$A862]
$A6:A85F A9 40 00    LDA #$0040

$A6:A862 85 14       STA $14    [$7E:0014]
$A6:A864 A2 00 00    LDX #$0000
$A6:A867 A0 0D 00    LDY #$000D
$A6:A86A 20 2F D6    JSR $D62F  [$A6:D62F]
$A6:A86D A9 02 00    LDA #$0002
$A6:A870 85 16       STA $16    [$7E:0016]
$A6:A872 85 18       STA $18    [$7E:0018]
$A6:A874 22 06 EF A9 JSL $A9EF06[$A9:EF06]
$A6:A878 90 05       BCC $05    [$A87F]
$A6:A87A CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A87D 10 0D       BPL $0D    [$A88C]

$A6:A87F A9 00 00    LDA #$0000
$A6:A882 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:A886 A9 E8 A6    LDA #$A6E8
$A6:A889 8D A8 0F    STA $0FA8  [$7E:0FA8]

$A6:A88C 60          RTS
}


;;; $A88D: Ridley function ;;;
{
; Ceres Ridley start swoop
$A6:A88D A9 A4 A8    LDA #$A8A4
$A6:A890 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A893 A9 0A 00    LDA #$000A
$A6:A896 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:A899 A9 00 00    LDA #$0000
$A6:A89C 8F 14 78 7E STA $7E7814[$7E:7814]
$A6:A8A0 8F 02 20 7E STA $7E2002[$7E:2002]
}


;;; $A8A4: Ridley function ;;;
{
; Ceres Ridley fly towards (C0h, 50h) to swoop
$A6:A8A4 A2 C0 00    LDX #$00C0
$A6:A8A7 A0 50 00    LDY #$0050
$A6:A8AA 86 12       STX $12    [$7E:0012]
$A6:A8AC 84 14       STY $14    [$7E:0014]
$A6:A8AE A2 00 00    LDX #$0000
$A6:A8B1 A0 01 00    LDY #$0001
$A6:A8B4 20 2F D6    JSR $D62F  [$A6:D62F]
$A6:A8B7 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:A8BA C9 60 00    CMP #$0060
$A6:A8BD 30 01       BMI $01    [$A8C0]
$A6:A8BF 60          RTS

$A6:A8C0 A9 D4 A8    LDA #$A8D4
$A6:A8C3 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A8C6 A9 0A 00    LDA #$000A
$A6:A8C9 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:A8CC A9 00 00    LDA #$0000
$A6:A8CF 8F 14 78 7E STA $7E7814[$7E:7814]
$A6:A8D3 60          RTS
}


;;; $A8D4: Ridley function ;;;
{
; Ceres Ridley swoop
$A6:A8D4 A9 E0 FF    LDA #$FFE0
$A6:A8D7 85 12       STA $12    [$7E:0012]
$A6:A8D9 A9 00 FC    LDA #$FC00
$A6:A8DC 85 14       STA $14    [$7E:0014]
$A6:A8DE A9 00 03    LDA #$0300
$A6:A8E1 85 16       STA $16    [$7E:0016]
$A6:A8E3 20 00 D8    JSR $D800  [$A6:D800]
$A6:A8E6 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A8E9 10 0C       BPL $0C    [$A8F7]
$A6:A8EB A9 F8 A8    LDA #$A8F8
$A6:A8EE 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A8F1 A9 24 00    LDA #$0024
$A6:A8F4 8D B2 0F    STA $0FB2  [$7E:0FB2]

$A6:A8F7 60          RTS
}


;;; $A8F8: Ridley function ;;;
{
$A6:A8F8 A9 00 FE    LDA #$FE00
$A6:A8FB 85 12       STA $12    [$7E:0012]
$A6:A8FD A9 00 C0    LDA #$C000
$A6:A900 85 14       STA $14    [$7E:0014]
$A6:A902 A9 00 03    LDA #$0300
$A6:A905 85 16       STA $16    [$7E:0016]
$A6:A907 20 00 D8    JSR $D800  [$A6:D800]
$A6:A90A CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A90D 10 13       BPL $13    [$A922]
$A6:A90F A9 23 A9    LDA #$A923
$A6:A912 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A915 A9 1C 00    LDA #$001C
$A6:A918 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:A91B A9 01 00    LDA #$0001
$A6:A91E 8F 04 20 7E STA $7E2004[$7E:2004]

$A6:A922 60          RTS
}


;;; $A923: Ridley function ;;;
{
$A6:A923 A9 00 FE    LDA #$FE00
$A6:A926 85 12       STA $12    [$7E:0012]
$A6:A928 A9 00 88    LDA #$8800
$A6:A92B 85 14       STA $14    [$7E:0014]
$A6:A92D A9 00 03    LDA #$0300
$A6:A930 85 16       STA $16    [$7E:0016]
$A6:A932 20 00 D8    JSR $D800  [$A6:D800]
$A6:A935 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A938 10 0C       BPL $0C    [$A946]
$A6:A93A A9 47 A9    LDA #$A947
$A6:A93D 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A940 A9 01 00    LDA #$0001
$A6:A943 8D B2 0F    STA $0FB2  [$7E:0FB2]

$A6:A946 60          RTS
}


;;; $A947: Ridley function ;;;
{
$A6:A947 A9 00 FD    LDA #$FD00
$A6:A94A 85 12       STA $12    [$7E:0012]
$A6:A94C A9 00 88    LDA #$8800
$A6:A94F 85 14       STA $14    [$7E:0014]
$A6:A951 A9 00 03    LDA #$0300
$A6:A954 85 16       STA $16    [$7E:0016]
$A6:A956 20 00 D8    JSR $D800  [$A6:D800]
$A6:A959 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A95C 10 12       BPL $12    [$A970]
$A6:A95E A9 E8 A6    LDA #$A6E8
$A6:A961 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A964 A9 00 00    LDA #$0000
$A6:A967 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:A96B 1A          INC A
$A6:A96C 8F 02 20 7E STA $7E2002[$7E:2002]

$A6:A970 60          RTS
}


;;; $A971: Ridley function ;;;
{
; Ceres Ridley flying away after Samus has low health or after he picks up baby metroid
$A6:A971 A9 40 FF    LDA #$FF40
$A6:A974 8F 00 80 7E STA $7E8000[$7E:8000]
$A6:A978 A9 C0 00    LDA #$00C0
$A6:A97B 85 12       STA $12    [$7E:0012]
$A6:A97D A9 80 FF    LDA #$FF80
$A6:A980 85 14       STA $14    [$7E:0014]
$A6:A982 A2 00 00    LDX #$0000
$A6:A985 A0 01 00    LDY #$0001
$A6:A988 20 2F D6    JSR $D62F  [$A6:D62F]
$A6:A98B AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:A98E C9 80 FF    CMP #$FF80
$A6:A991 30 01       BMI $01    [$A994]
$A6:A993 60          RTS

$A6:A994 A9 A0 A9    LDA #$A9A0
$A6:A997 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A99A A9 40 00    LDA #$0040
$A6:A99D 8D B2 0F    STA $0FB2  [$7E:0FB2]
}


;;; $A9A0: Ridley function ;;;
{
$A6:A9A0 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:A9A3 10 EE       BPL $EE    [$A993]
$A6:A9A5 20 20 AA    JSR $AA20  [$A6:AA20]  ; Spawn walls during Ceres Ridley getaway cutscene
$A6:A9A8 9C AA 0F    STZ $0FAA  [$7E:0FAA]
$A6:A9AB 9C AC 0F    STZ $0FAC  [$7E:0FAC]
$A6:A9AE A9 00 00    LDA #$0000
$A6:A9B1 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:A9B5 A9 11 AA    LDA #$AA11
$A6:A9B8 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:A9BB A0 E3 A9    LDY #$A9E3
$A6:A9BE A2 A2 00    LDX #$00A2
$A6:A9C1 A9 0F 00    LDA #$000F
$A6:A9C4 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]
$A6:A9C8 A0 01 AA    LDY #$AA01
$A6:A9CB A2 42 00    LDX #$0042
$A6:A9CE A9 08 00    LDA #$0008
$A6:A9D1 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]
$A6:A9D5 A0 01 AA    LDY #$AA01
$A6:A9D8 A2 E2 01    LDX #$01E2
$A6:A9DB A9 08 00    LDA #$0008
$A6:A9DE 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]
$A6:A9E2 60          RTS

; BG1/2 palette 5 colours 1..Fh
$A6:A9E3             dw 0421, 0401, 0000, 0000, 0421, 0001, 0000, 0000, 0422, 0002, 0001, 0022, 0021, 0001, 0000

; Sprite palette 7 colours 1..8
$A6:AA01             dw 7E20, 6560, 2060, 1000, 7940, 5D00, 4CA0, 3CA0
}


;;; $AA11: Ridley function ;;;
{
$A6:AA11 A9 4F AA    LDA #$AA4F
$A6:AA14 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:AA17 A9 01 00    LDA #$0001
$A6:AA1A 8D 3F 09    STA $093F  [$7E:093F]
$A6:AA1D 4C 54 AA    JMP $AA54  [$A6:AA54]
}


;;; $AA20: Spawn walls during Ceres Ridley getaway cutscene ;;;
{
$A6:AA20 A2 2F AA    LDX #$AA2F             ;\
$A6:AA23 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn left wall
$A6:AA27 A2 3F AA    LDX #$AA3F             ;\
$A6:AA2A 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn right wall
$A6:AA2E 60          RTS

;                        ______________________________________ Enemy ID
;                       |     _________________________________ X position
;                       |    |     ____________________________ Y position
;                       |    |    |     _______________________ Initialisation parameter
;                       |    |    |    |     __________________ Properties
;                       |    |    |    |    |     _____________ Extra properties
;                       |    |    |    |    |    |     ________ Parameter 1
;                       |    |    |    |    |    |    |     ___ Parameter 2
;                       |    |    |    |    |    |    |    |
$A6:AA2F             dw E23F,0008,007F,0000,2800,0000,0005,0000 ; Ceres door
$A6:AA3F             dw E23F,00F8,007F,0000,2800,0000,0006,0000 ; Ceres door
}


;;; $AA4F: Ridley function ;;;
{
$A6:AA4F 60          RTS
}


;;; $AA50: Ridley function ;;;
{
$A6:AA50 20 9C C1    JSR $C19C  [$A6:C19C]
$A6:AA53 60          RTS
}


;;; $AA54:  ;;;
{
$A6:AA54 E2 20       SEP #$20
$A6:AA56 A9 07       LDA #$07               ;\
$A6:AA58 85 56       STA $56    [$7E:0056]  ;} Fake BG mode = 7
$A6:AA5A C2 20       REP #$20
$A6:AA5C A9 01 00    LDA #$0001
$A6:AA5F 8D 83 07    STA $0783  [$7E:0783]
$A6:AA62 E2 20       SEP #$20               ;\
$A6:AA64 A9 80       LDA #$80               ;|
$A6:AA66 85 5F       STA $5F    [$7E:005F]  ;} Set mode 7 BG map overflowing tiles as transparent, no screen flip
$A6:AA68 C2 20       REP #$20               ;/
$A6:AA6A A9 00 01    LDA #$0100
$A6:AA6D 85 78       STA $78    [$7E:0078]
$A6:AA6F 85 7A       STA $7A    [$7E:007A]
$A6:AA71 85 7C       STA $7C    [$7E:007C]
$A6:AA73 85 7E       STA $7E    [$7E:007E]
$A6:AA75 A9 40 00    LDA #$0040
$A6:AA78 85 80       STA $80    [$7E:0080]
$A6:AA7A 85 82       STA $82    [$7E:0082]
$A6:AA7C A9 00 00    LDA #$0000
$A6:AA7F 8F 24 80 7E STA $7E8024[$7E:8024]
$A6:AA83 8F 26 80 7E STA $7E8026[$7E:8026]
$A6:AA87 A9 01 00    LDA #$0001
$A6:AA8A 8F 14 78 7E STA $7E7814[$7E:7814]
$A6:AA8E A9 80 FF    LDA #$FF80
$A6:AA91 8F 28 80 7E STA $7E8028[$7E:8028]
$A6:AA95 85 B1       STA $B1    [$7E:00B1]
$A6:AA97 A9 20 00    LDA #$0020
$A6:AA9A 8F 2A 80 7E STA $7E802A[$7E:802A]
$A6:AA9E 85 B3       STA $B3    [$7E:00B3]
$A6:AAA0 A9 00 08    LDA #$0800
$A6:AAA3 8F 20 80 7E STA $7E8020[$7E:8020]
$A6:AAA7 A9 00 04    LDA #$0400
$A6:AAAA 8F 22 80 7E STA $7E8022[$7E:8022]
$A6:AAAE 60          RTS
}


;;; $AAAF: Handle Ceres Ridley getaway cutscene ;;;
{
$A6:AAAF 8B          PHB
$A6:AAB0 4B          PHK
$A6:AAB1 AB          PLB
$A6:AAB2 AF 24 80 7E LDA $7E8024[$7E:8024]
$A6:AAB6 D0 03       BNE $03    [$AABB]
$A6:AAB8 20 BD AA    JSR $AABD  [$A6:AABD]

$A6:AABB AB          PLB
$A6:AABC 6B          RTL
}


;;; $AABD:  ;;;
{
$A6:AABD AF 26 80 7E LDA $7E8026[$7E:8026]
$A6:AAC1 AA          TAX
$A6:AAC2 1A          INC A
$A6:AAC3 1A          INC A
$A6:AAC4 8F 26 80 7E STA $7E8026[$7E:8026]
$A6:AAC8 E0 00 00    CPX #$0000
$A6:AACB D0 07       BNE $07    [$AAD4]
$A6:AACD A9 4E 00    LDA #$004E             ;\
$A6:AAD0 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 4Eh, sound library 2, max queued sounds allowed = 6 (Ceres Ridley getaway)

$A6:AAD4 E0 D0 00    CPX #$00D0
$A6:AAD7 D0 10       BNE $10    [$AAE9]
$A6:AAD9 22 19 E1 90 JSL $90E119[$90:E119]
$A6:AADD A9 23 00    LDA #$0023             ;\
$A6:AAE0 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG2 only and enemies, 3 pixel displacement, diagonal
$A6:AAE3 A9 40 00    LDA #$0040             ;\
$A6:AAE6 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 40h

$A6:AAE9 BD 4D AE    LDA $AE4D,x[$A6:AE4D]
$A6:AAEC C9 FF FF    CMP #$FFFF
$A6:AAEF F0 3D       BEQ $3D    [$AB2E]
$A6:AAF1 8F 20 80 7E STA $7E8020[$7E:8020]
$A6:AAF5 AF 2A 80 7E LDA $7E802A[$7E:802A]
$A6:AAF9 18          CLC
$A6:AAFA 7D 2F AF    ADC $AF2F,x[$A6:AF2F]
$A6:AAFD 8F 2A 80 7E STA $7E802A[$7E:802A]
$A6:AB01 85 B3       STA $B3    [$7E:00B3]
$A6:AB03 AF 28 80 7E LDA $7E8028[$7E:8028]
$A6:AB07 38          SEC
$A6:AB08 FD 0F B0    SBC $B00F,x[$A6:B00F]
$A6:AB0B 8F 28 80 7E STA $7E8028[$7E:8028]
$A6:AB0F 85 B1       STA $B1    [$7E:00B1]
$A6:AB11 AF 20 80 7E LDA $7E8020[$7E:8020]
$A6:AB15 20 EF B0    JSR $B0EF  [$A6:B0EF]
$A6:AB18 AF 14 78 7E LDA $7E7814[$7E:7814]
$A6:AB1C 18          CLC
$A6:AB1D 69 30 00    ADC #$0030
$A6:AB20 8F 14 78 7E STA $7E7814[$7E:7814]
$A6:AB24 20 5F AB    JSR $AB5F  [$A6:AB5F]
$A6:AB27 20 BC AC    JSR $ACBC  [$A6:ACBC]
$A6:AB2A 20 27 AD    JSR $AD27  [$A6:AD27]
$A6:AB2D 60          RTS

$A6:AB2E AF 24 80 7E LDA $7E8024[$7E:8024]
$A6:AB32 1A          INC A
$A6:AB33 8F 24 80 7E STA $7E8024[$7E:8024]
$A6:AB37 E2 20       SEP #$20
$A6:AB39 A9 09       LDA #$09
$A6:AB3B 85 56       STA $56    [$7E:0056]
$A6:AB3D C2 20       REP #$20
$A6:AB3F E2 20       SEP #$20
$A6:AB41 64 5F       STZ $5F    [$7E:005F]
$A6:AB43 C2 20       REP #$20
$A6:AB45 64 78       STZ $78    [$7E:0078]
$A6:AB47 64 7A       STZ $7A    [$7E:007A]
$A6:AB49 64 7C       STZ $7C    [$7E:007C]
$A6:AB4B 64 7E       STZ $7E    [$7E:007E]
$A6:AB4D 64 80       STZ $80    [$7E:0080]
$A6:AB4F 64 82       STZ $82    [$7E:0082]
$A6:AB51 64 B1       STZ $B1    [$7E:00B1]
$A6:AB53 64 B3       STZ $B3    [$7E:00B3]
$A6:AB55 A9 4E C0    LDA #$C04E
$A6:AB58 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:AB5B 9C B2 0F    STZ $0FB2  [$7E:0FB2]
$A6:AB5E 60          RTS
}


;;; $AB5F:  ;;;
{
$A6:AB5F AF 14 78 7E LDA $7E7814[$7E:7814]
$A6:AB63 EB          XBA
$A6:AB64 29 FF 00    AND #$00FF
$A6:AB67 85 12       STA $12    [$7E:0012]
$A6:AB69 A9 00 01    LDA #$0100
$A6:AB6C 22 1E AC A6 JSL $A6AC1E[$A6:AC1E]
$A6:AB70 85 18       STA $18    [$7E:0018]
$A6:AB72 24 18       BIT $18    [$7E:0018]
$A6:AB74 10 04       BPL $04    [$AB7A]
$A6:AB76 49 FF FF    EOR #$FFFF
$A6:AB79 1A          INC A

$A6:AB7A 85 26       STA $26    [$7E:0026]
$A6:AB7C AF 20 80 7E LDA $7E8020[$7E:8020]
$A6:AB80 85 28       STA $28    [$7E:0028]
$A6:AB82 20 58 AC    JSR $AC58  [$A6:AC58]
$A6:AB85 A5 2B       LDA $2B    [$7E:002B]
$A6:AB87 24 18       BIT $18    [$7E:0018]
$A6:AB89 10 04       BPL $04    [$AB8F]
$A6:AB8B 49 FF FF    EOR #$FFFF
$A6:AB8E 1A          INC A

$A6:AB8F 85 78       STA $78    [$7E:0078]
$A6:AB91 A9 00 01    LDA #$0100
$A6:AB94 22 0E AC A6 JSL $A6AC0E[$A6:AC0E]
$A6:AB98 85 18       STA $18    [$7E:0018]
$A6:AB9A 24 18       BIT $18    [$7E:0018]
$A6:AB9C 10 04       BPL $04    [$ABA2]
$A6:AB9E 49 FF FF    EOR #$FFFF
$A6:ABA1 1A          INC A

$A6:ABA2 85 26       STA $26    [$7E:0026]
$A6:ABA4 AF 20 80 7E LDA $7E8020[$7E:8020]
$A6:ABA8 85 28       STA $28    [$7E:0028]
$A6:ABAA 20 58 AC    JSR $AC58  [$A6:AC58]
$A6:ABAD A5 2B       LDA $2B    [$7E:002B]
$A6:ABAF 24 18       BIT $18    [$7E:0018]
$A6:ABB1 10 04       BPL $04    [$ABB7]
$A6:ABB3 49 FF FF    EOR #$FFFF
$A6:ABB6 1A          INC A

$A6:ABB7 85 7A       STA $7A    [$7E:007A]
$A6:ABB9 A9 00 01    LDA #$0100
$A6:ABBC 22 0E AC A6 JSL $A6AC0E[$A6:AC0E]
$A6:ABC0 49 FF FF    EOR #$FFFF
$A6:ABC3 1A          INC A
$A6:ABC4 85 18       STA $18    [$7E:0018]
$A6:ABC6 24 18       BIT $18    [$7E:0018]
$A6:ABC8 10 04       BPL $04    [$ABCE]
$A6:ABCA 49 FF FF    EOR #$FFFF
$A6:ABCD 1A          INC A

$A6:ABCE 85 26       STA $26    [$7E:0026]
$A6:ABD0 AF 20 80 7E LDA $7E8020[$7E:8020]
$A6:ABD4 85 28       STA $28    [$7E:0028]
$A6:ABD6 20 58 AC    JSR $AC58  [$A6:AC58]
$A6:ABD9 A5 2B       LDA $2B    [$7E:002B]
$A6:ABDB 24 18       BIT $18    [$7E:0018]
$A6:ABDD 10 04       BPL $04    [$ABE3]
$A6:ABDF 49 FF FF    EOR #$FFFF
$A6:ABE2 1A          INC A

$A6:ABE3 85 7C       STA $7C    [$7E:007C]
$A6:ABE5 A9 00 01    LDA #$0100
$A6:ABE8 22 1E AC A6 JSL $A6AC1E[$A6:AC1E]
$A6:ABEC 85 18       STA $18    [$7E:0018]
$A6:ABEE 24 18       BIT $18    [$7E:0018]
$A6:ABF0 10 04       BPL $04    [$ABF6]
$A6:ABF2 49 FF FF    EOR #$FFFF
$A6:ABF5 1A          INC A

$A6:ABF6 85 26       STA $26    [$7E:0026]
$A6:ABF8 AF 20 80 7E LDA $7E8020[$7E:8020]
$A6:ABFC 85 28       STA $28    [$7E:0028]
$A6:ABFE 20 58 AC    JSR $AC58  [$A6:AC58]
$A6:AC01 A5 2B       LDA $2B    [$7E:002B]
$A6:AC03 24 18       BIT $18    [$7E:0018]
$A6:AC05 10 04       BPL $04    [$AC0B]
$A6:AC07 49 FF FF    EOR #$FFFF
$A6:AC0A 1A          INC A

$A6:AC0B 85 7E       STA $7E    [$7E:007E]
$A6:AC0D 60          RTS
}


;;; $AC0E:  ;;;
{
$A6:AC0E 85 14       STA $14    [$7E:0014]
$A6:AC10 24 14       BIT $14    [$7E:0014]
$A6:AC12 10 04       BPL $04    [$AC18]
$A6:AC14 49 FF FF    EOR #$FFFF
$A6:AC17 1A          INC A

$A6:AC18 85 26       STA $26    [$7E:0026]
$A6:AC1A A5 12       LDA $12    [$7E:0012]
$A6:AC1C 80 12       BRA $12    [$AC30]
}


;;; $AC1E:  ;;;
{
$A6:AC1E 85 14       STA $14    [$7E:0014]
$A6:AC20 24 14       BIT $14    [$7E:0014]
$A6:AC22 10 04       BPL $04    [$AC28]
$A6:AC24 49 FF FF    EOR #$FFFF
$A6:AC27 1A          INC A

$A6:AC28 85 26       STA $26    [$7E:0026]
$A6:AC2A A5 12       LDA $12    [$7E:0012]
$A6:AC2C 18          CLC
$A6:AC2D 69 40 00    ADC #$0040
}


;;; $AC30:  ;;;
{
$A6:AC30 0A          ASL A
$A6:AC31 29 FE 01    AND #$01FE
$A6:AC34 AA          TAX
$A6:AC35 BF 43 B4 A0 LDA $A0B443,x[$A0:B4C3]
$A6:AC39 F0 1C       BEQ $1C    [$AC57]
$A6:AC3B 85 16       STA $16    [$7E:0016]
$A6:AC3D 10 04       BPL $04    [$AC43]
$A6:AC3F 49 FF FF    EOR #$FFFF
$A6:AC42 1A          INC A

$A6:AC43 85 28       STA $28    [$7E:0028]
$A6:AC45 20 58 AC    JSR $AC58  [$A6:AC58]
$A6:AC48 A5 14       LDA $14    [$7E:0014]
$A6:AC4A 45 16       EOR $16    [$7E:0016]
$A6:AC4C 30 03       BMI $03    [$AC51]
$A6:AC4E A5 2B       LDA $2B    [$7E:002B]
$A6:AC50 6B          RTL

$A6:AC51 A5 2B       LDA $2B    [$7E:002B]
$A6:AC53 49 FF FF    EOR #$FFFF
$A6:AC56 1A          INC A

$A6:AC57 6B          RTL
}


;;; $AC58:  ;;;
{
$A6:AC58 DA          PHX
$A6:AC59 5A          PHY
$A6:AC5A 48          PHA
$A6:AC5B 08          PHP
$A6:AC5C C2 20       REP #$20
$A6:AC5E E2 10       SEP #$10
$A6:AC60 A6 26       LDX $26    [$7E:0026]
$A6:AC62 8E 02 42    STX $4202  [$7E:4202]
$A6:AC65 A6 28       LDX $28    [$7E:0028]
$A6:AC67 8E 03 42    STX $4203  [$7E:4203]
$A6:AC6A EA          NOP
$A6:AC6B EA          NOP
$A6:AC6C EA          NOP
$A6:AC6D AD 16 42    LDA $4216  [$7E:4216]
$A6:AC70 85 2A       STA $2A    [$7E:002A]
$A6:AC72 A6 27       LDX $27    [$7E:0027]
$A6:AC74 8E 02 42    STX $4202  [$7E:4202]
$A6:AC77 A6 29       LDX $29    [$7E:0029]
$A6:AC79 8E 03 42    STX $4203  [$7E:4203]
$A6:AC7C EA          NOP
$A6:AC7D EA          NOP
$A6:AC7E EA          NOP
$A6:AC7F AE 16 42    LDX $4216  [$7E:4216]
$A6:AC82 86 2C       STX $2C    [$7E:002C]
$A6:AC84 AC 17 42    LDY $4217  [$7E:4217]
$A6:AC87 A6 27       LDX $27    [$7E:0027]
$A6:AC89 8E 02 42    STX $4202  [$7E:4202]
$A6:AC8C A6 28       LDX $28    [$7E:0028]
$A6:AC8E 8E 03 42    STX $4203  [$7E:4203]
$A6:AC91 EA          NOP
$A6:AC92 EA          NOP
$A6:AC93 A5 2B       LDA $2B    [$7E:002B]
$A6:AC95 18          CLC
$A6:AC96 6D 16 42    ADC $4216  [$7E:4216]
$A6:AC99 85 2B       STA $2B    [$7E:002B]
$A6:AC9B 90 01       BCC $01    [$AC9E]
$A6:AC9D C8          INY

$A6:AC9E A6 26       LDX $26    [$7E:0026]
$A6:ACA0 8E 02 42    STX $4202  [$7E:4202]
$A6:ACA3 A6 29       LDX $29    [$7E:0029]
$A6:ACA5 8E 03 42    STX $4203  [$7E:4203]
$A6:ACA8 EA          NOP
$A6:ACA9 EA          NOP
$A6:ACAA A5 2B       LDA $2B    [$7E:002B]
$A6:ACAC 18          CLC
$A6:ACAD 6D 16 42    ADC $4216  [$7E:4216]
$A6:ACB0 85 2B       STA $2B    [$7E:002B]
$A6:ACB2 90 01       BCC $01    [$ACB5]
$A6:ACB4 C8          INY

$A6:ACB5 84 2D       STY $2D    [$7E:002D]
$A6:ACB7 28          PLP
$A6:ACB8 68          PLA
$A6:ACB9 7A          PLY
$A6:ACBA FA          PLX
$A6:ACBB 60          RTS
}


;;; $ACBC:  ;;;
{
$A6:ACBC AD B6 05    LDA $05B6  [$7E:05B6]
$A6:ACBF 29 03 00    AND #$0003
$A6:ACC2 D0 15       BNE $15    [$ACD9]
$A6:ACC4 AF 2C 80 7E LDA $7E802C[$7E:802C]
$A6:ACC8 1A          INC A
$A6:ACC9 29 03 00    AND #$0003
$A6:ACCC 8F 2C 80 7E STA $7E802C[$7E:802C]
$A6:ACD0 0A          ASL A
$A6:ACD1 A8          TAY
$A6:ACD2 BE DA AC    LDX $ACDA,y[$A6:ACDC]
$A6:ACD5 22 4F 8B 80 JSL $808B4F[$80:8B4F]

$A6:ACD9 60          RTS

$A6:ACDA             dw ACE2, ACF5, AD08, ACF5

;                        ______________________ Control. 80h = write to VRAM tilemap
;                       |   ___________________ Source address
;                       |  |       ____________ Size
;                       |  |      |     _______ Destination address (VRAM)
;                       |  |      |    |     __ VRAM address increment mode
;                       |  |      |    |    |
$A6:ACE2             dx 80,A6AD1B,0002,0504,00,
                        80,A6AD1D,0002,0584,00,
                        00
                        
$A6:ACF5             dx 80,A6AD1F,0002,0504,00,
                        80,A6AD21,0002,0584,00,
                        00
                        
$A6:AD08             dx 80,A6AD23,0002,0504,00,
                        80,A6AD25,0002,0584,00,
                        00
                        

$A6:AD1B             db 59,5A
$A6:AD1D             db 69,6A
$A6:AD1F             db 8A,8B
$A6:AD21             db 8C,8D
$A6:AD23             db 8E,8F
$A6:AD25             db 9D,9E
}


;;; $AD27:  ;;;
{
$A6:AD27 AD B6 05    LDA $05B6  [$7E:05B6]
$A6:AD2A 29 07 00    AND #$0007
$A6:AD2D D0 15       BNE $15    [$AD44]
$A6:AD2F AF 2E 80 7E LDA $7E802E[$7E:802E]
$A6:AD33 1A          INC A
$A6:AD34 29 01 00    AND #$0001
$A6:AD37 8F 2E 80 7E STA $7E802E[$7E:802E]
$A6:AD3B 0A          ASL A
$A6:AD3C A8          TAY
$A6:AD3D BE 45 AD    LDX $AD45,y[$A6:AD47]
$A6:AD40 22 4F 8B 80 JSL $808B4F[$80:8B4F]

$A6:AD44 60          RTS

$A6:AD45             dw AD49, AD80

;                        ______________________ Control. 80h = write to VRAM tilemap
;                       |   ___________________ Source address
;                       |  |       ____________ Size
;                       |  |      |     _______ Destination address (VRAM)
;                       |  |      |    |     __ VRAM address increment mode
;                       |  |      |    |    |
$A6:AD49             dx 80,A6ADB7,0004,000B,00,
                        80,A6ADBF,000E,0080,00,
                        80,A6ADDB,000E,0100,00,
                        80,A6ADF7,000C,0181,00,
                        80,A6AE0F,000F,0201,00,
                        80,A6AE2D,0010,0280,00,
                        00

$A6:AD80             dx 80,A6ADBB,0004,000B,00,
                        80,A6ADCD,000E,0080,00,
                        80,A6ADE9,000E,0100,00,
                        80,A6AE03,000C,0181,00,
                        80,A6AE1E,000F,0201,00,
                        80,A6AE3D,0010,0280,00,
                        00

$A6:ADB7             db 00, 01, 02, 03
$A6:ADBB             db FF, FF, FF, FF
$A6:ADBF             db 04, 05, 06, 07, 08, 09, FF, FF, 0A, 0B, 0C, 0D, 0E, 0F
$A6:ADCD             db FF, FF, FF, FF, FF, FF, FF, FF, FF, FF, FF, FF, FF, FF
$A6:ADDB             db 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 1A, 1B, 1C, A8
$A6:ADE9             db FF, FF, FF, FF, FF, FF, 20, 17, AA, FF, FF, FF, FF, FF
$A6:ADF7             db 21, 22, 23, 24, 25, 26, 27, 28, 29, 2A, 2B, 2C
$A6:AE03             db FF, FF, FF, FF, FF, 26, 27, 28, FF, FF, FF, FF
$A6:AE0F             db FF, FF, 1D, 1E, 1F, 30, 31, 32, 33, 34, FF, FF, FF, FF, FF
$A6:AE1E             db 91, 92, 93, 94, 95, 30, 31, 32, 96, 97, 98, 99, 9A, 98, 9C
$A6:AE2D             db FF, FF, FF, FF, 2E, 2F, 40, 41, 42, 43, 44, FF, FF, FF, FF, FF
$A6:AE3D             db 90, 9F, A0, A1, A2, A3, 40, 41, 42, A4, A5, A6, A7, 7D, 83, 2D
}


;;; $AE4D:  ;;;
{
$A6:AE4D             dw 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800,
                        0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800, 0800,
                        07F0, 07E0, 07D0, 07C0, 07B0, 07A0, 0790, 0780, 0770, 0760, 0750, 0740, 0730, 0720, 0710, 0700,
                        06E0, 06C0, 06A0, 0680, 0660, 0640, 0620, 0600, 05E0, 05C0, 05A0, 0580, 0560, 0540, 0520, 0500,
                        04E0, 04C0, 04A0, 0480, 0460, 0440, 0430, 0400, 03E0, 03C0, 03A0, 0380, 0360, 0340, 0320, 0300,
                        02E0, 02C0, 02A0, 0280, 0260, 0240, 0230, 0200, 01E0, 01C0, 01A0, 0180, 0160, 0140, 0120, 0100,
                        00F0, 00E0, 00D0, 00C0, 00B0, 00A0, 0090, 0080, 0070, 0060, 0050, 0040, 0030, 0020, 0020, 0020,
                        FFFF
}


;;; $AF2F: Ceres Ridley getaway Y velocity table ;;;
{
$A6:AF2F             dw FFFA, FFFA, FFFA, FFFA, FFFA, FFFA, FFFA, FFFA, FFFA, FFFA, FFFA, FFFA, FFFC, FFFC, FFFC, FFFC,
                        FFFC, FFFC, FFFC, FFFC, FFFC, FFFC, FFFE, FFFE, FFFE, FFFE, FFFE, FFFE, FFFE, FFFF, FFFF, FFFF,
                        FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, 0000, 0000, 0000,
                        0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000,
                        0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000,
                        0001, 0001, 0001, 0001, 0001, 0001, 0001, 0001, 0002, 0002, 0002, 0002, 0002, 0002, 0002, 0002,
                        0003, 0004, 0006, 0008, 000A, 000C, 000E, 0010, 0014, 0018, 002C, 0030, 0080, 0100, 0100, 0100
}


;;; $B00F: Ceres Ridley getaway X velocity table ;;;
{
$A6:B00F             dw FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF,
                        FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF,
                        FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF,
                        FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF,
                        FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF, FFFF,
                        0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0001, 0001, 0001, 0001, 0001, 0001, 0001, 0001,
                        0002, 0002, 0003, 0003, 0004, 0004, 0005, 0005, 0008, 000C, 0010, 0014, 0020, 0020, 0020, 0020
}


;;; $B0EF:  ;;;
{
$A6:B0EF EB          XBA
$A6:B0F0 29 FF 00    AND #$00FF
$A6:B0F3 0A          ASL A
$A6:B0F4 0A          ASL A
$A6:B0F5 0A          ASL A
$A6:B0F6 0A          ASL A
$A6:B0F7 0A          ASL A
$A6:B0F8 69 07 B1    ADC #$B107
$A6:B0FB A8          TAY
$A6:B0FC A2 A2 00    LDX #$00A2
$A6:B0FF A9 0F 00    LDA #$000F
$A6:B102 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]
$A6:B106 60          RTS

; BG1/2 palette 5 colours 1..Fh
$A6:B107             dw 56BA,41B2,1447,0403,4E15,3570,24CB,1868,5E5F,183F,1014,031F,01DA,00F5,0C63,0000
$A6:B127             dw 4E78,3D90,1026,0402,45F3,314F,20AA,1447,561D,143D,0C12,02DD,01B8,00D3,0842,0000
$A6:B147             dw 4A56,356F,1026,0002,41B2,2D2D,1CA9,1447,51FA,141A,0C11,029A,0196,00D2,0842,0000
$A6:B167             dw 4214,314E,1025,0002,3D90,290C,1C88,1046,49D8,1018,0C10,0278,0174,00B0,0842,0000
$A6:B187             dw 3DF3,2D2D,0C25,0002,396F,250B,1888,1045,41B6,1016,0C0E,0236,0153,00AF,0842,0000
$A6:B1A7             dw 39D1,290C,0C24,0002,314E,20EA,1887,1045,3D94,1014,080D,0214,0131,008E,0842,0000
$A6:B1C7             dw 318F,24EA,0C24,0001,2D2C,1CC9,1466,0C24,3552,0C12,080C,01D2,010F,008C,0421,0000
$A6:B1E7             dw 252C,1CC8,0823,0001,20E9,18A7,1045,0823,290E,080E,0409,016E,00CC,0069,0421,0000
$A6:B207             dw 1CE8,1486,0402,0001,18A7,1065,0C43,0822,1CCA,080A,0406,010A,0088,0047,0421,0000
}


;;; $B227: Main AI - enemy $E17F (Ridley) ;;;
{
$A6:B227 AF 08 80 7E LDA $7E8008[$7E:8008]
$A6:B22B 38          SEC
$A6:B22C E9 04 00    SBC #$0004
$A6:B22F 10 03       BPL $03    [$B234]
$A6:B231 A9 00 00    LDA #$0000

$A6:B234 8F 08 80 7E STA $7E8008[$7E:8008]
$A6:B238 20 B4 BC    JSR $BCB4  [$A6:BCB4]
$A6:B23B 20 2C BD    JSR $BD2C  [$A6:BD2C]
$A6:B23E F4 43 B2    PEA $B243
$A6:B241 6C A8 0F    JMP ($0FA8)[$A6:A35B]

$A6:B244 AF 04 78 7E LDA $7E7804[$7E:7804]
$A6:B248 F0 21       BEQ $21    [$B26B]
$A6:B24A 20 DA D4    JSR $D4DA  [$A6:D4DA]
$A6:B24D 20 6B D8    JSR $D86B  [$A6:D86B]
$A6:B250 20 7D D9    JSR $D97D  [$A6:D97D]
$A6:B253 20 F5 CA    JSR $CAF5  [$A6:CAF5]
$A6:B256 20 88 E0    JSR $E088  [$A6:E088]
$A6:B259 20 2A DB    JSR $DB2A  [$A6:DB2A]
$A6:B25C 20 D8 DA    JSR $DAD8  [$A6:DAD8]
$A6:B25F 20 0C DA    JSR $DA0C  [$A6:DA0C]
$A6:B262 AF 36 78 7E LDA $7E7836[$7E:7836]
$A6:B266 F0 03       BEQ $03    [$B26B]
$A6:B268 20 E1 B9    JSR $B9E1  [$A6:B9E1]

$A6:B26B 20 74 D4    JSR $D474  [$A6:D474]
$A6:B26E 6B          RTL
}


;;; $B26F:  ;;;
{
$A6:B26F AF 3C 78 7E LDA $7E783C[$7E:783C]
$A6:B273 0F 36 78 7E ORA $7E7836[$7E:7836]
$A6:B277 D0 0B       BNE $0B    [$B284]
$A6:B279 A2 04 00    LDX #$0004
$A6:B27C A0 04 00    LDY #$0004
$A6:B27F 20 65 B8    JSR $B865  [$A6:B865]
$A6:B282 B0 01       BCS $01    [$B285]

$A6:B284 60          RTS

$A6:B285 4C 68 BC    JMP $BC68  [$A6:BC68]
}


;;; $B288:  ;;;
{
$A6:B288             dw 0008
}


;;; $B28A: Time is frozen AI - enemy $E17F (Ridley) ;;;
{
; The only time is frozen AI in the game!
$A6:B28A A9 00 00    LDA #$0000
$A6:B28D 8F 08 80 7E STA $7E8008[$7E:8008]
$A6:B291 A9 01 00    LDA #$0001
$A6:B294 8D A4 0F    STA $0FA4  [$7E:0FA4]
}


;;; $B297: Hurt AI - enemy $E17F (Ridley) ;;;
{
$A6:B297 AD A4 0F    LDA $0FA4  [$7E:0FA4]
$A6:B29A 29 01 00    AND #$0001
$A6:B29D D0 1B       BNE $1B    [$B2BA]
$A6:B29F 20 B4 BC    JSR $BCB4  [$A6:BCB4]
$A6:B2A2 20 2C BD    JSR $BD2C  [$A6:BD2C]
$A6:B2A5 F4 AA B2    PEA $B2AA
$A6:B2A8 6C A8 0F    JMP ($0FA8)[$A6:A478]

$A6:B2AB AF 04 78 7E LDA $7E7804[$7E:7804]
$A6:B2AF F0 38       BEQ $38    [$B2E9]
$A6:B2B1 20 6B D8    JSR $D86B  [$A6:D86B]
$A6:B2B4 20 7D D9    JSR $D97D  [$A6:D97D]
$A6:B2B7 20 F5 CA    JSR $CAF5  [$A6:CAF5]

$A6:B2BA 20 88 E0    JSR $E088  [$A6:E088]
$A6:B2BD 20 DA D4    JSR $D4DA  [$A6:D4DA]
$A6:B2C0 20 2A DB    JSR $DB2A  [$A6:DB2A]
$A6:B2C3 20 D8 DA    JSR $DAD8  [$A6:DAD8]
$A6:B2C6 20 74 D4    JSR $D474  [$A6:D474]
$A6:B2C9 20 0C DA    JSR $DA0C  [$A6:DA0C]
$A6:B2CC AF 08 80 7E LDA $7E8008[$7E:8008]
$A6:B2D0 18          CLC
$A6:B2D1 69 01 00    ADC #$0001
$A6:B2D4 CD 88 B2    CMP $B288  [$A6:B288]
$A6:B2D7 30 03       BMI $03    [$B2DC]
$A6:B2D9 AD 88 B2    LDA $B288  [$A6:B288]

$A6:B2DC 8F 08 80 7E STA $7E8008[$7E:8008]
$A6:B2E0 AF 08 80 7E LDA $7E8008[$7E:8008]
$A6:B2E4 CD 88 B2    CMP $B288  [$A6:B288]
$A6:B2E7 30 09       BMI $09    [$B2F2]

$A6:B2E9 AF 36 78 7E LDA $7E7836[$7E:7836]
$A6:B2ED F0 03       BEQ $03    [$B2F2]
$A6:B2EF 20 E1 B9    JSR $B9E1  [$A6:B9E1]

$A6:B2F2 6B          RTL
}


;;; $B2F3: Ridley function ;;;
{
; Startup liftoff, facing right
$A6:B2F3 A2 40 00    LDX #$0040
$A6:B2F6 A0 00 01    LDY #$0100
$A6:B2F9 86 12       STX $12    [$7E:0012]
$A6:B2FB 84 14       STY $14    [$7E:0014]
$A6:B2FD A2 00 00    LDX #$0000
$A6:B300 A0 0E 00    LDY #$000E
$A6:B303 20 23 D5    JSR $D523  [$A6:D523]
$A6:B306 A9 08 00    LDA #$0008
$A6:B309 85 16       STA $16    [$7E:0016]
$A6:B30B 85 18       STA $18    [$7E:0018]
$A6:B30D 22 06 EF A9 JSL $A9EF06[$A9:EF06]
$A6:B311 90 01       BCC $01    [$B314]
$A6:B313 60          RTS

$A6:B314 A9 01 00    LDA #$0001
$A6:B317 8F 02 78 7E STA $7E7802[$7E:7802]
$A6:B31B A9 21 B3    LDA #$B321
$A6:B31E 8D A8 0F    STA $0FA8  [$7E:0FA8]
}


;;; $B321: Ridley function ;;;
{
; Get new AI script (main battle engine)
$A6:B321 20 35 B3    JSR $B335  [$A6:B335]
$A6:B324 22 11 81 80 JSL $808111[$80:8111]
$A6:B328 29 07 00    AND #$0007
$A6:B32B 0A          ASL A
$A6:B32C A8          TAY
$A6:B32D B1 12       LDA ($12),y[$A6:B3C8]
$A6:B32F 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B332 6C A8 0F    JMP ($0FA8)[$A6:B6A7]
}


;;; $B335:  ;;;
{
; Get new AI script
$A6:B335 AD 1F 0A    LDA $0A1F  [$7E:0A1F]
$A6:B338 29 FF 00    AND #$00FF
$A6:B33B C9 03 00    CMP #$0003
$A6:B33E D0 06       BNE $06    [$B346]
$A6:B340 A9 CC B3    LDA #$B3CC
$A6:B343 85 12       STA $12    [$7E:0012]
$A6:B345 60          RTS

$A6:B346 AD 8C 0F    LDA $0F8C  [$7E:0F8C]
$A6:B349 D0 0F       BNE $0F    [$B35A]
$A6:B34B A9 DC B3    LDA #$B3DC
$A6:B34E 85 12       STA $12    [$7E:0012]
$A6:B350 AF 0A 80 7E LDA $7E800A[$7E:800A]
$A6:B354 1A          INC A
$A6:B355 8F 0A 80 7E STA $7E800A[$7E:800A]
$A6:B359 60          RTS

$A6:B35A C9 40 38    CMP #$3840
$A6:B35D 10 06       BPL $06    [$B365]
$A6:B35F A0 8C B3    LDY #$B38C
$A6:B362 84 12       STY $12    [$7E:0012]
$A6:B364 60          RTS

$A6:B365 20 20 BD    JSR $BD20  [$A6:BD20]
$A6:B368 90 06       BCC $06    [$B370]
$A6:B36A A0 BC B3    LDY #$B3BC
$A6:B36D 84 12       STY $12    [$7E:0012]
$A6:B36F 60          RTS

$A6:B370 20 F1 BC    JSR $BCF1  [$A6:BCF1]
$A6:B373 90 06       BCC $06    [$B37B]
$A6:B375 A0 AC B3    LDY #$B3AC
$A6:B378 84 12       STY $12    [$7E:0012]
$A6:B37A 60          RTS
}


;;; $B37B:  ;;;
{
$A6:B37B A0 8C B3    LDY #$B38C
$A6:B37E AD 8C 0F    LDA $0F8C  [$7E:0F8C]
$A6:B381 C9 28 23    CMP #$2328
$A6:B384 10 03       BPL $03    [$B389]
$A6:B386 A0 9C B3    LDY #$B39C

$A6:B389 84 12       STY $12    [$7E:0012]
$A6:B38B 60          RTS
}


;;; $B38C:  ;;;
{
$A6:B38C             dw B6A7,B6A7,B6A7,B6A7,B441,B441,B441,B441
$A6:B39C             dw B441,B441,B441,B441,B6A7,B6A7,B6A7,B6A7
$A6:B3AC             dw BAB7,BAB7,BAB7,BAB7,BAB7,BAB7,B6A7,B6A7
$A6:B3BC             dw B6A7,B6A7,B6A7,B6A7,B6A7,B6A7,B6A7,B6A7
$A6:B3CC             dw B5C4,B5C4,B5C4,B5C4,B5C4,B5C4,B5C4,B5C4
$A6:B3DC             dw BAB7,BAB7,BAB7,BAB7,BAB7,BAB7,BAB7,BAB7
}


;;; $B3EC: Ridley function ;;;
{
; Initailize movement to center
$A6:B3EC A9 F8 B3    LDA #$B3F8
$A6:B3EF 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B3F2 A9 80 00    LDA #$0080
$A6:B3F5 8D B2 0F    STA $0FB2  [$7E:0FB2]
}


;;; $B3F8: Ridley function ;;;
{
; Move to center side
$A6:B3F8 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:B3FB 30 2A       BMI $2A    [$B427]
$A6:B3FD A2 C0 00    LDX #$00C0
$A6:B400 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B404 F0 03       BEQ $03    [$B409]
$A6:B406 A2 60 00    LDX #$0060

$A6:B409 86 12       STX $12    [$7E:0012]
$A6:B40B A0 00 01    LDY #$0100
$A6:B40E 84 14       STY $14    [$7E:0014]
$A6:B410 20 2E B4    JSR $B42E  [$A6:B42E]
$A6:B413 A2 00 00    LDX #$0000
$A6:B416 20 23 D5    JSR $D523  [$A6:D523]
$A6:B419 A9 08 00    LDA #$0008
$A6:B41C 85 16       STA $16    [$7E:0016]
$A6:B41E 85 18       STA $18    [$7E:0018]
$A6:B420 22 06 EF A9 JSL $A9EF06[$A9:EF06]
$A6:B424 90 01       BCC $01    [$B427]
$A6:B426 60          RTS

$A6:B427 A9 21 B3    LDA #$B321
$A6:B42A 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B42D 60          RTS
}


;;; $B42E:  ;;;
{
; Y = 4, 8, A, or C, depending on general speed byte
$A6:B42E AF 24 78 7E LDA $7E7824[$7E:7824]
$A6:B432 0A          ASL A
$A6:B433 A8          TAY
$A6:B434 B9 39 B4    LDA $B439,y[$A6:B439]
$A6:B437 A8          TAY
$A6:B438 60          RTS

$A6:B439             dw 0004, 0008, 000A, 000C
}


;;; $B441: Ridley function ;;;
{
; Chose to do a U swoop
$A6:B441 A9 55 B4    LDA #$B455
$A6:B444 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B447 A9 0A 00    LDA #$000A
$A6:B44A 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B44E A9 00 00    LDA #$0000
$A6:B451 8F 14 78 7E STA $7E7814[$7E:7814]
}


;;; $B455: Ridley function ;;;
{
; Fly to U swoop start
$A6:B455 A2 C0 00    LDX #$00C0
$A6:B458 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B45C F0 03       BEQ $03    [$B461]
$A6:B45E A2 40 00    LDX #$0040

$A6:B461 86 12       STX $12    [$7E:0012]
$A6:B463 A0 80 00    LDY #$0080
$A6:B466 84 14       STY $14    [$7E:0014]
$A6:B468 A2 00 00    LDX #$0000
$A6:B46B A0 01 00    LDY #$0001
$A6:B46E 20 23 D5    JSR $D523  [$A6:D523]
$A6:B471 A9 08 00    LDA #$0008
$A6:B474 85 16       STA $16    [$7E:0016]
$A6:B476 85 18       STA $18    [$7E:0018]
$A6:B478 22 06 EF A9 JSL $A9EF06[$A9:EF06]
$A6:B47C B0 14       BCS $14    [$B492]
$A6:B47E A9 93 B4    LDA #$B493
$A6:B481 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B484 A9 20 00    LDA #$0020
$A6:B487 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B48B A9 00 00    LDA #$0000
$A6:B48E 8F 14 78 7E STA $7E7814[$7E:7814]

$A6:B492 60          RTS
}


;;; $B493: Ridley function ;;;
{
; U swoop, first dive
$A6:B493 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B497 D0 0C       BNE $0C    [$B4A5]
$A6:B499 A9 E0 FF    LDA #$FFE0
$A6:B49C 85 12       STA $12    [$7E:0012]
$A6:B49E A9 00 FE    LDA #$FE00
$A6:B4A1 85 14       STA $14    [$7E:0014]
$A6:B4A3 80 0A       BRA $0A    [$B4AF]

$A6:B4A5 A9 20 00    LDA #$0020
$A6:B4A8 85 12       STA $12    [$7E:0012]
$A6:B4AA A9 00 02    LDA #$0200
$A6:B4AD 85 14       STA $14    [$7E:0014]

$A6:B4AF A9 80 04    LDA #$0480
$A6:B4B2 85 16       STA $16    [$7E:0016]
$A6:B4B4 20 00 D8    JSR $D800  [$A6:D800]
$A6:B4B7 AF 00 78 7E LDA $7E7800[$7E:7800]
$A6:B4BB F0 06       BEQ $06    [$B4C3]
$A6:B4BD 3A          DEC A
$A6:B4BE 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B4C2 60          RTS

$A6:B4C3 A9 D1 B4    LDA #$B4D1
$A6:B4C6 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B4C9 A9 14 00    LDA #$0014
$A6:B4CC 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B4D0 60          RTS
}


;;; $B4D1: Ridley function ;;;
{
; U swoop, dive to half point
$A6:B4D1 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B4D5 D0 0C       BNE $0C    [$B4E3]
$A6:B4D7 A9 C0 FE    LDA #$FEC0
$A6:B4DA 85 12       STA $12    [$7E:0012]
$A6:B4DC A9 00 C0    LDA #$C000
$A6:B4DF 85 14       STA $14    [$7E:0014]
$A6:B4E1 80 0A       BRA $0A    [$B4ED]

$A6:B4E3 A9 40 01    LDA #$0140
$A6:B4E6 85 12       STA $12    [$7E:0012]
$A6:B4E8 A9 00 40    LDA #$4000
$A6:B4EB 85 14       STA $14    [$7E:0014]

$A6:B4ED A9 00 05    LDA #$0500
$A6:B4F0 85 16       STA $16    [$7E:0016]
$A6:B4F2 20 00 D8    JSR $D800  [$A6:D800]
$A6:B4F5 AF 00 78 7E LDA $7E7800[$7E:7800]
$A6:B4F9 F0 06       BEQ $06    [$B501]
$A6:B4FB 3A          DEC A
$A6:B4FC 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B500 60          RTS

$A6:B501 A9 16 B5    LDA #$B516
$A6:B504 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B507 A9 10 00    LDA #$0010
$A6:B50A 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B50E A9 01 00    LDA #$0001
$A6:B511 8F 04 20 7E STA $7E2004[$7E:2004]
$A6:B515 60          RTS
}


;;; $B516: Ridley function ;;;
{
; U swoop, climb after half point
$A6:B516 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B51A D0 0C       BNE $0C    [$B528]
$A6:B51C A9 00 FE    LDA #$FE00
$A6:B51F 85 12       STA $12    [$7E:0012]
$A6:B521 A9 00 88    LDA #$8800
$A6:B524 85 14       STA $14    [$7E:0014]
$A6:B526 80 0A       BRA $0A    [$B532]

$A6:B528 A9 00 02    LDA #$0200
$A6:B52B 85 12       STA $12    [$7E:0012]
$A6:B52D A9 00 78    LDA #$7800
$A6:B530 85 14       STA $14    [$7E:0014]

$A6:B532 A9 00 03    LDA #$0300
$A6:B535 85 16       STA $16    [$7E:0016]
$A6:B537 20 00 D8    JSR $D800  [$A6:D800]
$A6:B53A AF 00 78 7E LDA $7E7800[$7E:7800]
$A6:B53E F0 06       BEQ $06    [$B546]
$A6:B540 3A          DEC A
$A6:B541 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B545 60          RTS

$A6:B546 A9 54 B5    LDA #$B554
$A6:B549 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B54C A9 20 00    LDA #$0020
$A6:B54F 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B553 60          RTS
}


;;; $B554: Ridley function ;;;
{
; U Swoop, still climbing
$A6:B554 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B558 D0 0C       BNE $0C    [$B566]
$A6:B55A A9 00 FC    LDA #$FC00
$A6:B55D 85 12       STA $12    [$7E:0012]
$A6:B55F A9 00 88    LDA #$8800
$A6:B562 85 14       STA $14    [$7E:0014]
$A6:B564 80 0A       BRA $0A    [$B570]

$A6:B566 A9 00 04    LDA #$0400
$A6:B569 85 12       STA $12    [$7E:0012]
$A6:B56B A9 00 78    LDA #$7800
$A6:B56E 85 14       STA $14    [$7E:0014]

$A6:B570 A9 00 03    LDA #$0300
$A6:B573 85 16       STA $16    [$7E:0016]
$A6:B575 20 00 D8    JSR $D800  [$A6:D800]
$A6:B578 AF 00 78 7E LDA $7E7800[$7E:7800]
$A6:B57C F0 06       BEQ $06    [$B584]
$A6:B57E 3A          DEC A
$A6:B57F 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B583 60          RTS

$A6:B584 A9 94 B5    LDA #$B594
$A6:B587 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B58A A9 20 00    LDA #$0020
$A6:B58D 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B591 4C 55 D9    JMP $D955  [$A6:D955]
}


;;; $B594: Ridley function ;;;
{
; U Swoop End (Chooses BAB7 for next script if Samus is not spinjumping, else B321)
$A6:B594 64 12       STZ $12    [$7E:0012]
$A6:B596 A9 00 80    LDA #$8000
$A6:B599 85 14       STA $14    [$7E:0014]
$A6:B59B A9 C0 01    LDA #$01C0
$A6:B59E 85 16       STA $16    [$7E:0016]
$A6:B5A0 20 00 D8    JSR $D800  [$A6:D800]
$A6:B5A3 AF 00 78 7E LDA $7E7800[$7E:7800]
$A6:B5A7 F0 06       BEQ $06    [$B5AF]
$A6:B5A9 3A          DEC A
$A6:B5AA 8F 00 78 7E STA $7E7800[$7E:7800]
$A6:B5AE 60          RTS

$A6:B5AF 20 F1 BC    JSR $BCF1  [$A6:BCF1]
$A6:B5B2 A0 21 B3    LDY #$B321
$A6:B5B5 90 03       BCC $03    [$B5BA]
$A6:B5B7 A0 B7 BA    LDY #$BAB7

$A6:B5BA 8C A8 0F    STY $0FA8  [$7E:0FA8]
$A6:B5BD 60          RTS
}


;;; $B5BE:  ;;;
{
$A6:B5BE             dw FFE0, 0000, 0020
}


;;; $B5C4: Ridley function ;;;
{
; Consider tailbouncing
$A6:B5C4 A9 0B 00    LDA #$000B
$A6:B5C7 8F 1E 20 7E STA $7E201E[$7E:201E]
$A6:B5CB A9 80 01    LDA #$0180
$A6:B5CE 8F 12 20 7E STA $7E2012[$7E:2012]
$A6:B5D2 A9 E5 B5    LDA #$B5E5
$A6:B5D5 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B5D8 AD E5 05    LDA $05E5  [$7E:05E5]
$A6:B5DB 29 1F 00    AND #$001F
$A6:B5DE 18          CLC
$A6:B5DF 69 20 00    ADC #$0020
$A6:B5E2 8D B2 0F    STA $0FB2  [$7E:0FB2]
}


;;; $B5E5: Ridley function ;;;
{
; Considering tailbouncing
$A6:B5E5 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B5E9 0A          ASL A
$A6:B5EA A8          TAY
$A6:B5EB B9 0D B6    LDA $B60D,y
$A6:B5EE 85 12       STA $12    [$7E:0012]
$A6:B5F0 20 41 B6    JSR $B641  [$A6:B641]
$A6:B5F3 90 03       BCC $03    [$B5F8]
$A6:B5F5 4C 8B B6    JMP $B68B  [$A6:B68B]

$A6:B5F8 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:B5FB 10 0F       BPL $0F    [$B60C]
$A6:B5FD A9 13 B6    LDA #$B613
$A6:B600 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B603 A9 80 00    LDA #$0080
$A6:B606 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:B609 4C 55 D9    JMP $D955  [$A6:D955]

$A6:B60C 60          RTS

$A6:B60D             dw 00C0, 0080, 0040
}


;;; $B613: Ridley function ;;;
{
; Hover since Samus is spinjumping
$A6:B613 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B617 0A          ASL A
$A6:B618 A8          TAY
$A6:B619 B9 3B B6    LDA $B63B,y
$A6:B61C 85 12       STA $12    [$7E:0012]
$A6:B61E 20 41 B6    JSR $B641  [$A6:B641]
$A6:B621 90 03       BCC $03    [$B626]
$A6:B623 4C 8B B6    JMP $B68B  [$A6:B68B]

$A6:B626 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:B629 10 0F       BPL $0F    [$B63A]
$A6:B62B A9 E5 B5    LDA #$B5E5
$A6:B62E 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B631 A9 80 00    LDA #$0080
$A6:B634 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:B637 4C 55 D9    JMP $D955  [$A6:D955]

$A6:B63A 60          RTS

$A6:B63B             dw 0040, 0080, 00C0
}


;;; $B641:  ;;;
{
; Fly towards $12 (X position) / Samus's Y position
; If Samus is not spin jumping, SEC before RTS. Else CLC and randomly fireball if allowed.
$A6:B641 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A6:B644 C9 60 01    CMP #$0160
$A6:B647 30 03       BMI $03    [$B64C]
$A6:B649 A9 60 01    LDA #$0160

$A6:B64C 85 14       STA $14    [$7E:0014]
$A6:B64E A2 00 00    LDX #$0000
$A6:B651 20 2E B4    JSR $B42E  [$A6:B42E]
$A6:B654 20 23 D5    JSR $D523  [$A6:D523]
$A6:B657 A9 01 00    LDA #$0001
$A6:B65A 8F 04 20 7E STA $7E2004[$7E:2004]
$A6:B65E AD 1F 0A    LDA $0A1F  [$7E:0A1F]
$A6:B661 29 FF 00    AND #$00FF
$A6:B664 C9 03 00    CMP #$0003
$A6:B667 D0 20       BNE $20    [$B689]
$A6:B669 AD E5 05    LDA $05E5  [$7E:05E5]
$A6:B66C 29 FF 00    AND #$00FF
$A6:B66F C9 80 00    CMP #$0080
$A6:B672 90 13       BCC $13    [$B687]
$A6:B674 AF 1E 78 7E LDA $7E781E[$7E:781E]
$A6:B678 D0 0D       BNE $0D    [$B687]
$A6:B67A AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B67E 3A          DEC A
$A6:B67F F0 06       BEQ $06    [$B687]
$A6:B681 A9 3A E7    LDA #$E73A
$A6:B684 20 67 D4    JSR $D467  [$A6:D467]

$A6:B687 18          CLC
$A6:B688 60          RTS

$A6:B689 38          SEC
$A6:B68A 60          RTS
}


;;; $B68B:  ;;;
{
$A6:B68B A9 F0 00    LDA #$00F0
$A6:B68E 8F 12 20 7E STA $7E2012[$7E:2012]
$A6:B692 A9 10 00    LDA #$0010
$A6:B695 8F 1E 20 7E STA $7E201E[$7E:201E]
$A6:B699 A9 01 00    LDA #$0001
$A6:B69C 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:B6A0 A9 A7 B6    LDA #$B6A7
$A6:B6A3 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B6A6 60          RTS
}


;;; $B6A7: Ridley function ;;;
{
; Fly to start Tailbouncing
$A6:B6A7 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:B6AA C9 20 01    CMP #$0120
$A6:B6AD 30 1F       BMI $1F    [$B6CE]
$A6:B6AF AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B6B3 0A          ASL A
$A6:B6B4 A8          TAY
$A6:B6B5 B9 C8 B6    LDA $B6C8,y[$A6:B6CC]
$A6:B6B8 85 12       STA $12    [$7E:0012]
$A6:B6BA A9 20 01    LDA #$0120
$A6:B6BD 85 14       STA $14    [$7E:0014]
$A6:B6BF A2 00 00    LDX #$0000
$A6:B6C2 A0 00 00    LDY #$0000
$A6:B6C5 4C 23 D5    JMP $D523  [$A6:D523]

$A6:B6C8             dw 00B0, 0080, 0060

$A6:B6CE 20 55 D9    JSR $D955  [$A6:D955]
$A6:B6D1 A9 DD B6    LDA #$B6DD
$A6:B6D4 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B6D7 A9 20 00    LDA #$0020
$A6:B6DA 8D B2 0F    STA $0FB2  [$7E:0FB2]
}


;;; $B6DD: Ridley function ;;;
{
; Start tailbouncing
$A6:B6DD AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:B6E0 85 12       STA $12    [$7E:0012]
$A6:B6E2 A9 20 01    LDA #$0120
$A6:B6E5 85 14       STA $14    [$7E:0014]
$A6:B6E7 A2 00 00    LDX #$0000
$A6:B6EA A0 00 00    LDY #$0000
$A6:B6ED 20 23 D5    JSR $D523  [$A6:D523]
$A6:B6F0 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:B6F3 10 18       BPL $18    [$B70D]
$A6:B6F5 20 33 CB    JSR $CB33  [$A6:CB33]
$A6:B6F8 20 0F B9    JSR $B90F  [$A6:B90F]
$A6:B6FB A9 0E B7    LDA #$B70E
$A6:B6FE 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B701 AD E5 05    LDA $05E5  [$7E:05E5]
$A6:B704 29 3F 00    AND #$003F
$A6:B707 69 80 00    ADC #$0080
$A6:B70A 8D B2 0F    STA $0FB2  [$7E:0FB2]

$A6:B70D 60          RTS
}


;;; $B70E: Ridley function ;;;
{
; Main tailbouncing
$A6:B70E 20 59 B8    JSR $B859  [$A6:B859]
$A6:B711 90 07       BCC $07    [$B71A]
$A6:B713 20 4D B8    JSR $B84D  [$A6:B84D]
$A6:B716 4C 89 B8    JMP $B889  [$A6:B889]

$A6:B719 60          RTS

$A6:B71A AD AC 0F    LDA $0FAC  [$7E:0FAC]
$A6:B71D 18          CLC
$A6:B71E 6F 0C 20 7E ADC $7E200C[$7E:200C]
$A6:B722 C9 00 06    CMP #$0600
$A6:B725 30 03       BMI $03    [$B72A]
$A6:B727 A9 00 06    LDA #$0600

$A6:B72A 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:B72D 20 E7 B7    JSR $B7E7  [$A6:B7E7]
$A6:B730 90 E7       BCC $E7    [$B719]
$A6:B732 AF A4 20 7E LDA $7E20A4[$7E:20A4]
$A6:B736 85 12       STA $12    [$7E:0012]
$A6:B738 AF A6 20 7E LDA $7E20A6[$7E:20A6]
$A6:B73C 18          CLC
$A6:B73D 69 0C 00    ADC #$000C
$A6:B740 85 14       STA $14    [$7E:0014]
$A6:B742 A9 09 00    LDA #$0009             ; A = 9 (small dust cloud)
$A6:B745 A0 09 E5    LDY #$E509             ;\
$A6:B748 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A6:B74C A9 76 00    LDA #$0076             ;\
$A6:B74F 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 76h, sound library 2, max queued sounds allowed = 6 (quake)
$A6:B753 A9 0D 00    LDA #$000D             ;\
$A6:B756 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 and BG2, 2 pixel displacement, vertical
$A6:B759 A9 04 00    LDA #$0004             ;\
$A6:B75C 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 4
$A6:B75F 20 A9 B8    JSR $B8A9  [$A6:B8A9]
$A6:B762 20 0F B9    JSR $B90F  [$A6:B90F]
$A6:B765 A2 7C D3    LDX #$D37C
$A6:B768 A0 26 20    LDY #$2026
$A6:B76B 20 B4 D3    JSR $D3B4  [$A6:D3B4]
$A6:B76E A9 00 0C    LDA #$0C00
$A6:B771 8F 28 20 7E STA $7E2028[$7E:2028]
$A6:B775 8F 3C 20 7E STA $7E203C[$7E:203C]
$A6:B779 8F 50 20 7E STA $7E2050[$7E:2050]
$A6:B77D 8F 64 20 7E STA $7E2064[$7E:2064]
$A6:B781 8F 78 20 7E STA $7E2078[$7E:2078]
$A6:B785 8F 8C 20 7E STA $7E208C[$7E:208C]
$A6:B789 8F A0 20 7E STA $7E20A0[$7E:20A0]
$A6:B78D A9 04 00    LDA #$0004
$A6:B790 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:B794 AF 0C 80 7E LDA $7E800C[$7E:800C]
$A6:B798 1A          INC A
$A6:B799 C9 02 00    CMP #$0002
$A6:B79C 30 10       BMI $10    [$B7AE]
$A6:B79E AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B7A2 3A          DEC A
$A6:B7A3 F0 06       BEQ $06    [$B7AB]
$A6:B7A5 A9 3A E7    LDA #$E73A
$A6:B7A8 20 67 D4    JSR $D467  [$A6:D467]

$A6:B7AB A9 00 00    LDA #$0000

$A6:B7AE 8F 0C 80 7E STA $7E800C[$7E:800C]
$A6:B7B2 A9 B9 B7    LDA #$B7B9
$A6:B7B5 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B7B8 60          RTS
}


;;; $B7B9: Ridley function ;;;
{
; Tailbouncing, hit ground
$A6:B7B9 20 20 BD    JSR $BD20  [$A6:BD20]
$A6:B7BC 90 1F       BCC $1F    [$B7DD]
$A6:B7BE CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:B7C1 30 1A       BMI $1A    [$B7DD]
$A6:B7C3 AD AC 0F    LDA $0FAC  [$7E:0FAC]
$A6:B7C6 18          CLC
$A6:B7C7 6F 0E 20 7E ADC $7E200E[$7E:200E]
$A6:B7CB 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:B7CE 30 0C       BMI $0C    [$B7DC]
$A6:B7D0 A9 00 00    LDA #$0000
$A6:B7D3 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:B7D6 A9 0E B7    LDA #$B70E
$A6:B7D9 8D A8 0F    STA $0FA8  [$7E:0FA8]

$A6:B7DC 60          RTS

$A6:B7DD 20 4D B8    JSR $B84D  [$A6:B84D]
$A6:B7E0 A9 21 B3    LDA #$B321
$A6:B7E3 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B7E6 60          RTS
}


;;; $B7E7:  ;;;
{
$A6:B7E7 AF A4 20 7E LDA $7E20A4[$7E:20A4]
$A6:B7EB AA          TAX
$A6:B7EC AF A6 20 7E LDA $7E20A6[$7E:20A6]
$A6:B7F0 18          CLC
$A6:B7F1 69 10 00    ADC #$0010
$A6:B7F4 A8          TAY
$A6:B7F5 22 F9 D4 A6 JSL $A6D4F9[$A6:D4F9]
$A6:B7F9 B0 51       BCS $51    [$B84C]
$A6:B7FB AF 90 20 7E LDA $7E2090[$7E:2090]
$A6:B7FF AA          TAX
$A6:B800 AF 92 20 7E LDA $7E2092[$7E:2092]
$A6:B804 18          CLC
$A6:B805 69 12 00    ADC #$0012
$A6:B808 A8          TAY
$A6:B809 22 F9 D4 A6 JSL $A6D4F9[$A6:D4F9]
$A6:B80D B0 3D       BCS $3D    [$B84C]
$A6:B80F AF 7C 20 7E LDA $7E207C[$7E:207C]
$A6:B813 AA          TAX
$A6:B814 AF 7E 20 7E LDA $7E207E[$7E:207E]
$A6:B818 18          CLC
$A6:B819 69 12 00    ADC #$0012
$A6:B81C A8          TAY
$A6:B81D 22 F9 D4 A6 JSL $A6D4F9[$A6:D4F9]
$A6:B821 B0 29       BCS $29    [$B84C]
$A6:B823 AF 68 20 7E LDA $7E2068[$7E:2068]
$A6:B827 AA          TAX
$A6:B828 AF 6A 20 7E LDA $7E206A[$7E:206A]
$A6:B82C 18          CLC
$A6:B82D 69 12 00    ADC #$0012
$A6:B830 A8          TAY
$A6:B831 22 F9 D4 A6 JSL $A6D4F9[$A6:D4F9]
$A6:B835 B0 15       BCS $15    [$B84C]
$A6:B837 AF 54 20 7E LDA $7E2054[$7E:2054]
$A6:B83B AA          TAX
$A6:B83C AF 56 20 7E LDA $7E2056[$7E:2056]
$A6:B840 18          CLC
$A6:B841 69 12 00    ADC #$0012
$A6:B844 A8          TAY
$A6:B845 22 F9 D4 A6 JSL $A6D4F9[$A6:D4F9]
$A6:B849 B0 01       BCS $01    [$B84C]
$A6:B84B EA          NOP

$A6:B84C 60          RTS
}


;;; $B84D:  ;;;
{
$A6:B84D A9 01 00    LDA #$0001
$A6:B850 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:B854 8F 14 20 7E STA $7E2014[$7E:2014]
$A6:B858 60          RTS
}


;;; $B859:  ;;;
{
; Attempt to grab Samus
$A6:B859 20 F1 BC    JSR $BCF1  [$A6:BCF1]
$A6:B85C B0 01       BCS $01    [$B85F]
$A6:B85E 60          RTS

$A6:B85F A2 04 00    LDX #$0004
$A6:B862 A0 04 00    LDY #$0004
$A6:B865 86 16       STX $16    [$7E:0016]
$A6:B867 84 18       STY $18    [$7E:0018]
$A6:B869 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:B86D 0A          ASL A
$A6:B86E A8          TAY
$A6:B86F B9 D5 B9    LDA $B9D5,y[$A6:B9D9]
$A6:B872 18          CLC
$A6:B873 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:B876 85 12       STA $12    [$7E:0012]
$A6:B878 AF 3A 78 7E LDA $7E783A[$7E:783A]
$A6:B87C A8          TAY
$A6:B87D B9 DB B9    LDA $B9DB,y[$A6:B9DB]
$A6:B880 18          CLC
$A6:B881 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:B884 85 14       STA $14    [$7E:0014]
$A6:B886 4C 29 DF    JMP $DF29  [$A6:DF29]
}


;;; $B889:  ;;;
{
$A6:B889 AD AC 0F    LDA $0FAC  [$7E:0FAC]
$A6:B88C 30 04       BMI $04    [$B892]
$A6:B88E 49 FF FF    EOR #$FFFF
$A6:B891 1A          INC A

$A6:B892 C9 00 FE    CMP #$FE00
$A6:B895 30 03       BMI $03    [$B89A]
$A6:B897 A9 00 FE    LDA #$FE00

$A6:B89A 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:B89D 20 4D B8    JSR $B84D  [$A6:B84D]
$A6:B8A0 A9 8F BB    LDA #$BB8F
$A6:B8A3 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:B8A6 4C 8F BB    JMP $BB8F  [$A6:BB8F]
}


;;; $B8A9:  ;;;
{
$A6:B8A9 AD AA 0F    LDA $0FAA  [$7E:0FAA]
$A6:B8AC D0 0F       BNE $0F    [$B8BD]
$A6:B8AE A9 C0 00    LDA #$00C0
$A6:B8B1 2C 79 0F    BIT $0F79  [$7E:0F79]
$A6:B8B4 10 04       BPL $04    [$B8BA]
$A6:B8B6 49 FF FF    EOR #$FFFF
$A6:B8B9 1A          INC A

$A6:B8BA 8D AA 0F    STA $0FAA  [$7E:0FAA]

$A6:B8BD AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:B8C0 38          SEC
$A6:B8C1 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A6:B8C4 4D AA 0F    EOR $0FAA  [$7E:0FAA]
$A6:B8C7 30 22       BMI $22    [$B8EB]
$A6:B8C9 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:B8CC CF 04 80 7E CMP $7E8004[$7E:8004]
$A6:B8D0 30 31       BMI $31    [$B903]
$A6:B8D2 CF 06 80 7E CMP $7E8006[$7E:8006]
$A6:B8D6 10 31       BPL $31    [$B909]
$A6:B8D8 AD E5 05    LDA $05E5  [$7E:05E5]
$A6:B8DB C9 55 05    CMP #$0555
$A6:B8DE 90 0A       BCC $0A    [$B8EA]

$A6:B8E0 AD AA 0F    LDA $0FAA  [$7E:0FAA]
$A6:B8E3 49 FF FF    EOR #$FFFF
$A6:B8E6 1A          INC A
$A6:B8E7 8D AA 0F    STA $0FAA  [$7E:0FAA]

$A6:B8EA 60          RTS

$A6:B8EB AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:B8EE CF 04 80 7E CMP $7E8004[$7E:8004]
$A6:B8F2 30 0F       BMI $0F    [$B903]
$A6:B8F4 CF 06 80 7E CMP $7E8006[$7E:8006]
$A6:B8F8 10 0F       BPL $0F    [$B909]
$A6:B8FA AD E5 05    LDA $05E5  [$7E:05E5]
$A6:B8FD C9 55 05    CMP #$0555
$A6:B900 90 DE       BCC $DE    [$B8E0]
$A6:B902 60          RTS

$A6:B903 AD AA 0F    LDA $0FAA  [$7E:0FAA]
$A6:B906 30 D8       BMI $D8    [$B8E0]
$A6:B908 60          RTS

$A6:B909 AD AA 0F    LDA $0FAA  [$7E:0FAA]
$A6:B90C 10 D2       BPL $D2    [$B8E0]
$A6:B90E 60          RTS
}


;;; $B90F:  ;;;
{
; Set speeds for tailbouncing (depends on random and speed)
$A6:B90F AD E5 05    LDA $05E5  [$7E:05E5]
$A6:B912 29 03 00    AND #$0003
$A6:B915 0A          ASL A
$A6:B916 A8          TAY
$A6:B917 B9 65 B9    LDA $B965,y[$A6:B96B]
$A6:B91A 85 12       STA $12    [$7E:0012]
$A6:B91C B9 6D B9    LDA $B96D,y[$A6:B973]
$A6:B91F 85 14       STA $14    [$7E:0014]
$A6:B921 AF 24 78 7E LDA $7E7824[$7E:7824]
$A6:B925 18          CLC
$A6:B926 69 02 00    ADC #$0002
$A6:B929 0A          ASL A
$A6:B92A A8          TAY
$A6:B92B B9 4D B9    LDA $B94D,y[$A6:B951]
$A6:B92E 8F 0E 20 7E STA $7E200E[$7E:200E]
$A6:B932 B9 59 B9    LDA $B959,y[$A6:B95D]
$A6:B935 8F 0C 20 7E STA $7E200C[$7E:200C]
$A6:B939 B1 14       LDA ($14),y[$A6:B9CD]
$A6:B93B 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:B93E B1 12       LDA ($12),y[$A6:B99D]
$A6:B940 AE AA 0F    LDX $0FAA  [$7E:0FAA]
$A6:B943 10 04       BPL $04    [$B949]
$A6:B945 49 FF FF    EOR #$FFFF
$A6:B948 1A          INC A

$A6:B949 8D AA 0F    STA $0FAA  [$7E:0FAA]
$A6:B94C 60          RTS

$A6:B94D             dw 000A, 0010, 0020, 0030, 0040, 0050
$A6:B959             dw 0010, 0020, 0040, 0080, 0400, 0500

$A6:B965             dw B975, B981, B98D, B999
$A6:B96D             dw B9A5, B9B1, B9BD, B9C9

$A6:B975             dw 0058,0070,00A0,00A8,00B0,00B8
$A6:B981             dw 0078,0090,00C0,00C8,00D0,00D8
$A6:B98D             dw 0098,00B0,00E0,00E8,00F0,00F8
$A6:B999             dw 00B8,00D0,0100,0108,0110,0118

$A6:B9A5             dw FE60,FDE0,FCE0,FC20,FA80,F980
$A6:B9B1             dw FE00,FD80,FC80,FBC0,FA60,F960
$A6:B9BD             dw FDE0,FD60,FC60,FB80,FA40,F940
$A6:B9C9             dw FDC0,FD40,FC40,FB60,FA20,F920
}


;;; $B9D5:  ;;;
{
$A6:B9D5             dw 000C, 0000, FFF4
$A6:B9DB             dw 0023, 002E, 0038
}


;;; $B9E1:  ;;;
{
; If holding Samus, move Samus to within Ridley's claws
$A6:B9E1 AF 28 78 7E LDA $7E7828[$7E:7828]
$A6:B9E5 F0 1F       BEQ $1F    [$BA06]
$A6:B9E7 85 12       STA $12    [$7E:0012]
$A6:B9E9 10 04       BPL $04    [$B9EF]
$A6:B9EB 49 FF FF    EOR #$FFFF
$A6:B9EE 1A          INC A

$A6:B9EF 38          SEC
$A6:B9F0 E9 04 00    SBC #$0004
$A6:B9F3 10 05       BPL $05    [$B9FA]
$A6:B9F5 A9 00 00    LDA #$0000
$A6:B9F8 80 08       BRA $08    [$BA02]

$A6:B9FA 24 12       BIT $12    [$7E:0012]
$A6:B9FC 10 04       BPL $04    [$BA02]
$A6:B9FE 49 FF FF    EOR #$FFFF
$A6:BA01 1A          INC A

$A6:BA02 8F 28 78 7E STA $7E7828[$7E:7828]

$A6:BA06 AF 2A 78 7E LDA $7E782A[$7E:782A]
$A6:BA0A F0 1F       BEQ $1F    [$BA2B]
$A6:BA0C 85 12       STA $12    [$7E:0012]
$A6:BA0E 10 04       BPL $04    [$BA14]
$A6:BA10 49 FF FF    EOR #$FFFF
$A6:BA13 1A          INC A

$A6:BA14 38          SEC
$A6:BA15 E9 04 00    SBC #$0004
$A6:BA18 10 05       BPL $05    [$BA1F]
$A6:BA1A A9 00 00    LDA #$0000
$A6:BA1D 80 08       BRA $08    [$BA27]

$A6:BA1F 24 12       BIT $12    [$7E:0012]
$A6:BA21 10 04       BPL $04    [$BA27]
$A6:BA23 49 FF FF    EOR #$FFFF
$A6:BA26 1A          INC A

$A6:BA27 8F 2A 78 7E STA $7E782A[$7E:782A]

$A6:BA2B AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:BA2F 0A          ASL A
$A6:BA30 A8          TAY
$A6:BA31 B9 D5 B9    LDA $B9D5,y[$A6:B9D5]
$A6:BA34 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:BA37 18          CLC
$A6:BA38 6F 28 78 7E ADC $7E7828[$7E:7828]
$A6:BA3C 8D F6 0A    STA $0AF6  [$7E:0AF6]
$A6:BA3F AF 3A 78 7E LDA $7E783A[$7E:783A]
$A6:BA43 A8          TAY
$A6:BA44 B9 DB B9    LDA $B9DB,y[$A6:B9DB]
$A6:BA47 18          CLC
$A6:BA48 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:BA4B 18          CLC
$A6:BA4C 6F 2A 78 7E ADC $7E782A[$7E:782A]
$A6:BA50 8D FA 0A    STA $0AFA  [$7E:0AFA]
$A6:BA53 60          RTS
}


;;; $BA54:  ;;;
{
; Set displacement for Ridley grabbing Samus
$A6:BA54 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:BA58 0A          ASL A
$A6:BA59 A8          TAY
$A6:BA5A B9 D5 B9    LDA $B9D5,y[$A6:B9D5]
$A6:BA5D 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:BA60 38          SEC
$A6:BA61 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A6:BA64 49 FF FF    EOR #$FFFF
$A6:BA67 1A          INC A
$A6:BA68 8F 28 78 7E STA $7E7828[$7E:7828]
$A6:BA6C AF 3A 78 7E LDA $7E783A[$7E:783A]
$A6:BA70 A8          TAY
$A6:BA71 B9 DB B9    LDA $B9DB,y[$A6:B9DB]
$A6:BA74 18          CLC
$A6:BA75 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:BA78 38          SEC
$A6:BA79 ED FA 0A    SBC $0AFA  [$7E:0AFA]
$A6:BA7C 49 FF FF    EOR #$FFFF
$A6:BA7F 1A          INC A
$A6:BA80 8F 2A 78 7E STA $7E782A[$7E:782A]
$A6:BA84 60          RTS
}


;;; $BA85:  ;;;
{
$A6:BA85 AF 0A 80 7E LDA $7E800A[$7E:800A]
$A6:BA89 C9 0A 00    CMP #$000A
$A6:BA8C 30 0D       BMI $0D    [$BA9B]
$A6:BA8E 22 B7 DF A6 JSL $A6DFB7[$A6:DFB7]
$A6:BA92 A9 3E C5    LDA #$C53E
$A6:BA95 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BA98 4C 3E C5    JMP $C53E  [$A6:C53E]

$A6:BA9B AD EE 0C    LDA $0CEE  [$7E:0CEE]
$A6:BA9E F0 09       BEQ $09    [$BAA9]
$A6:BAA0 A9 4E BD    LDA #$BD4E
$A6:BAA3 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BAA6 4C 4E BD    JMP $BD4E  [$A6:BD4E]

$A6:BAA9 A9 EC B3    LDA #$B3EC
$A6:BAAC 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BAAF A9 01 00    LDA #$0001
$A6:BAB2 8F 04 20 7E STA $7E2004[$7E:2004]
$A6:BAB6 60          RTS
}


;;; $BAB7: Ridley function ;;;
{
; Check to do Deathswoop/Powerbomb dodge/Move-to-Center, or attempt to ram/grab Samus
; Deathswoop/Powerbomb dodge/Move if:
;     Samus is spinjumping, Ridley has collided with a wall, Samus is behind or above Ridley
$A6:BAB7 20 F1 BC    JSR $BCF1  [$A6:BCF1]
$A6:BABA 90 C9       BCC $C9    [$BA85]
$A6:BABC AF 3E 78 7E LDA $7E783E[$7E:783E]
$A6:BAC0 D0 C3       BNE $C3    [$BA85]
$A6:BAC2 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:BAC6 0A          ASL A
$A6:BAC7 A8          TAY
$A6:BAC8 B9 48 BB    LDA $BB48,y[$A6:BB4C]
$A6:BACB 85 12       STA $12    [$7E:0012]
$A6:BACD AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:BAD0 38          SEC
$A6:BAD1 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A6:BAD4 85 14       STA $14    [$7E:0014]
$A6:BAD6 45 12       EOR $12    [$7E:0012]
$A6:BAD8 10 0D       BPL $0D    [$BAE7]
$A6:BADA A5 14       LDA $14    [$7E:0014]
$A6:BADC 10 04       BPL $04    [$BAE2]
$A6:BADE 49 FF FF    EOR #$FFFF
$A6:BAE1 1A          INC A

$A6:BAE2 C9 20 00    CMP #$0020
$A6:BAE5 10 9E       BPL $9E    [$BA85]

$A6:BAE7 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:BAEA 18          CLC
$A6:BAEB 69 23 00    ADC #$0023
$A6:BAEE 38          SEC
$A6:BAEF ED FA 0A    SBC $0AFA  [$7E:0AFA]
$A6:BAF2 10 91       BPL $91    [$BA85]
$A6:BAF4 A2 F0 FF    LDX #$FFF0
$A6:BAF7 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:BAFB F0 03       BEQ $03    [$BB00]
$A6:BAFD A2 10 00    LDX #$0010

$A6:BB00 8A          TXA
$A6:BB01 18          CLC
$A6:BB02 6D F6 0A    ADC $0AF6  [$7E:0AF6]
$A6:BB05 85 12       STA $12    [$7E:0012]
$A6:BB07 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A6:BB0A 18          CLC
$A6:BB0B 69 FC FF    ADC #$FFFC
$A6:BB0E 85 14       STA $14    [$7E:0014]
$A6:BB10 A2 00 00    LDX #$0000
$A6:BB13 AF 24 78 7E LDA $7E7824[$7E:7824]
$A6:BB17 0A          ASL A
$A6:BB18 A8          TAY
$A6:BB19 B9 4E BB    LDA $BB4E,y[$A6:BB4E]
$A6:BB1C A8          TAY
$A6:BB1D 20 23 D5    JSR $D523  [$A6:D523]
$A6:BB20 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:BB24 0A          ASL A
$A6:BB25 A8          TAY
$A6:BB26 B9 D5 B9    LDA $B9D5,y[$A6:B9D9]
$A6:BB29 18          CLC
$A6:BB2A 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:BB2D 85 12       STA $12    [$7E:0012]
$A6:BB2F A9 23 00    LDA #$0023
$A6:BB32 18          CLC
$A6:BB33 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:BB36 85 14       STA $14    [$7E:0014]
$A6:BB38 A9 08 00    LDA #$0008
$A6:BB3B 85 16       STA $16    [$7E:0016]
$A6:BB3D A9 0C 00    LDA #$000C
$A6:BB40 85 18       STA $18    [$7E:0018]
$A6:BB42 20 29 DF    JSR $DF29  [$A6:DF29]
$A6:BB45 B0 0F       BCS $0F    [$BB56]
$A6:BB47 60          RTS

$A6:BB48             dw 0000, 0000, 8000

$A6:BB4E             dw 0001, 0003, 0007, 000A

$A6:BB56 AD AC 0F    LDA $0FAC  [$7E:0FAC]
$A6:BB59 49 FF FF    EOR #$FFFF
$A6:BB5C 1A          INC A
$A6:BB5D 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:BB60 AD 8C 0F    LDA $0F8C  [$7E:0F8C]
$A6:BB63 F0 14       BEQ $14    [$BB79]
$A6:BB65 AD EE 0C    LDA $0CEE  [$7E:0CEE]  ; >_<;
$A6:BB68 AD EE 0C    LDA $0CEE  [$7E:0CEE]
$A6:BB6B F0 22       BEQ $22    [$BB8F]
$A6:BB6D 20 68 BC    JSR $BC68  [$A6:BC68]
$A6:BB70 A9 4E BD    LDA #$BD4E
$A6:BB73 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BB76 4C 4E BD    JMP $BD4E  [$A6:BD4E]

$A6:BB79 AF 36 78 7E LDA $7E7836[$7E:7836]
$A6:BB7D D0 03       BNE $03    [$BB82]
$A6:BB7F 20 68 BC    JSR $BC68  [$A6:BC68]

$A6:BB82 22 B7 DF A6 JSL $A6DFB7[$A6:DFB7]
$A6:BB86 A9 38 C5    LDA #$C538
$A6:BB89 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BB8C 4C 38 C5    JMP $C538  [$A6:C538]
}


;;; $BB8F: Ridley function ;;;
{
; Ridley in position to grab Samus, no powerbombs
$A6:BB8F AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:BB93 0A          ASL A
$A6:BB94 A8          TAY
$A6:BB95 B9 EB BB    LDA $BBEB,y[$A6:BBEB]
$A6:BB98 8F 2E 78 7E STA $7E782E[$7E:782E]
$A6:BB9C AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:BB9F 18          CLC
$A6:BBA0 69 C0 FF    ADC #$FFC0
$A6:BBA3 C9 00 01    CMP #$0100
$A6:BBA6 10 03       BPL $03    [$BBAB]
$A6:BBA8 A9 00 01    LDA #$0100

$A6:BBAB 8F 30 78 7E STA $7E7830[$7E:7830]
$A6:BBAF AF 36 78 7E LDA $7E7836[$7E:7836]
$A6:BBB3 D0 03       BNE $03    [$BBB8]
$A6:BBB5 20 68 BC    JSR $BC68  [$A6:BC68]

$A6:BBB8 A9 C4 BB    LDA #$BBC4
$A6:BBBB 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BBBE A9 20 00    LDA #$0020
$A6:BBC1 8D B2 0F    STA $0FB2  [$7E:0FB2]
}


;;; $BBC4: Ridley function ;;;
{
; Ridley is holding Samus, move towards target position then go to next script
$A6:BBC4 AF 2E 78 7E LDA $7E782E[$7E:782E]
$A6:BBC8 85 12       STA $12    [$7E:0012]
$A6:BBCA AF 30 78 7E LDA $7E7830[$7E:7830]
$A6:BBCE 85 14       STA $14    [$7E:0014]
$A6:BBD0 A2 00 00    LDX #$0000
$A6:BBD3 A0 00 00    LDY #$0000
$A6:BBD6 20 23 D5    JSR $D523  [$A6:D523]
$A6:BBD9 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:BBDC 10 0C       BPL $0C    [$BBEA]
$A6:BBDE A9 F1 BB    LDA #$BBF1
$A6:BBE1 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BBE4 A9 20 00    LDA #$0020
$A6:BBE7 8D B2 0F    STA $0FB2  [$7E:0FB2]

$A6:BBEA 60          RTS

$A6:BBEB             dw 0040, 0000, 00D0
}


;;; $BBF1: Ridley function ;;;
{
; Drop Samus
$A6:BBF1 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:BBF4 30 14       BMI $14    [$BC0A]
$A6:BBF6 AF 2E 78 7E LDA $7E782E[$7E:782E]
$A6:BBFA 85 12       STA $12    [$7E:0012]
$A6:BBFC A9 00 01    LDA #$0100
$A6:BBFF 85 14       STA $14    [$7E:0014]
$A6:BC01 A2 00 00    LDX #$0000
$A6:BC04 A0 00 00    LDY #$0000
$A6:BC07 4C 23 D5    JMP $D523  [$A6:D523]

$A6:BC0A A9 08 00    LDA #$0008
$A6:BC0D 8F 1E 20 7E STA $7E201E[$7E:201E]
$A6:BC11 A9 F0 00    LDA #$00F0
$A6:BC14 8F 12 20 7E STA $7E2012[$7E:2012]
$A6:BC18 20 84 BC    JSR $BC84  [$A6:BC84]
$A6:BC1B A9 2E BC    LDA #$BC2E
$A6:BC1E 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BC21 A9 40 00    LDA #$0040
$A6:BC24 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:BC27 60          RTS

; Unused
$A6:BC28             dw 00B0, 0000, 0050
}


;;; $BC2E: Ridley function ;;;
{
; Short time after dropping Samus, before returning to B321
$A6:BC2E CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:BC31 30 1A       BMI $1A    [$BC4D]
$A6:BC33 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:BC37 0A          ASL A
$A6:BC38 A8          TAY
$A6:BC39 B9 62 BC    LDA $BC62,y[$A6:BC62]
$A6:BC3C 85 12       STA $12    [$7E:0012]
$A6:BC3E A9 E0 00    LDA #$00E0
$A6:BC41 85 14       STA $14    [$7E:0014]
$A6:BC43 A2 00 00    LDX #$0000
$A6:BC46 A0 00 00    LDY #$0000
$A6:BC49 20 23 D5    JSR $D523  [$A6:D523]
$A6:BC4C 60          RTS

$A6:BC4D A9 10 00    LDA #$0010
$A6:BC50 8F 1E 20 7E STA $7E201E[$7E:201E]
$A6:BC54 A9 F0 00    LDA #$00F0
$A6:BC57 8F 12 20 7E STA $7E2012[$7E:2012]
$A6:BC5B A9 21 B3    LDA #$B321
$A6:BC5E 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BC61 60          RTS

$A6:BC62             dw 00B0, 0000, 0050
}


;;; $BC68:  ;;;
{
; Grab Samus
$A6:BC68 20 54 BA    JSR $BA54  [$A6:BA54]
$A6:BC6B AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:BC6E 09 00 04    ORA #$0400
$A6:BC71 8D 86 0F    STA $0F86  [$7E:0F86]
$A6:BC74 A9 01 00    LDA #$0001
$A6:BC77 8F 36 78 7E STA $7E7836[$7E:7836]
$A6:BC7B 3A          DEC A                  ;\
$A6:BC7C 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus
$A6:BC80 38          SEC
$A6:BC81 4C 8B DA    JMP $DA8B  [$A6:DA8B]
}


;;; $BC84:  ;;;
{
; Release Samus
$A6:BC84 A9 01 00    LDA #$0001
$A6:BC87 8F 04 20 7E STA $7E2004[$7E:2004]
$A6:BC8B 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:BC8F AF 02 78 7E LDA $7E7802[$7E:7802]
$A6:BC93 30 0F       BMI $0F    [$BCA4]
$A6:BC95 20 F1 BC    JSR $BCF1  [$A6:BCF1]
$A6:BC98 A9 06 00    LDA #$0006
$A6:BC9B 70 03       BVS $03    [$BCA0]
$A6:BC9D A9 0A 00    LDA #$000A

$A6:BCA0 8F 3C 78 7E STA $7E783C[$7E:783C]

$A6:BCA4 A9 00 00    LDA #$0000
$A6:BCA7 8F 36 78 7E STA $7E7836[$7E:7836]
$A6:BCAB 1A          INC A                  ;\
$A6:BCAC 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$A6:BCB0 18          CLC
$A6:BCB1 4C 8B DA    JMP $DA8B  [$A6:DA8B]
}


;;; $BCB4:  ;;;
{
; Handles Enemy/Samus interaction bit
$A6:BCB4 AF 02 78 7E LDA $7E7802[$7E:7802]
$A6:BCB8 30 36       BMI $36    [$BCF0]
$A6:BCBA F0 18       BEQ $18    [$BCD4]
$A6:BCBC 20 7A DE    JSR $DE7A  [$A6:DE7A]
$A6:BCBF 90 0A       BCC $0A    [$BCCB]
$A6:BCC1 AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:BCC4 09 00 04    ORA #$0400
$A6:BCC7 8D 86 0F    STA $0F86  [$7E:0F86]
$A6:BCCA 60          RTS

$A6:BCCB AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:BCCE 29 FF FB    AND #$FBFF
$A6:BCD1 8D 86 0F    STA $0F86  [$7E:0F86]

$A6:BCD4 AF 3C 78 7E LDA $7E783C[$7E:783C]
$A6:BCD8 F0 16       BEQ $16    [$BCF0]
$A6:BCDA 3A          DEC A
$A6:BCDB 8F 3C 78 7E STA $7E783C[$7E:783C]
$A6:BCDF D0 0F       BNE $0F    [$BCF0]
$A6:BCE1 AF 02 78 7E LDA $7E7802[$7E:7802]
$A6:BCE5 30 09       BMI $09    [$BCF0]
$A6:BCE7 AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:BCEA 29 FF FB    AND #$FBFF
$A6:BCED 8D 86 0F    STA $0F86  [$7E:0F86]

$A6:BCF0 60          RTS
}


;;; $BCF1:  ;;;
{
; CLC if spin jump, grappling, or spin back from hurt
$A6:BCF1 AD 1F 0A    LDA $0A1F  [$7E:0A1F]
$A6:BCF4 29 FF 00    AND #$00FF
$A6:BCF7 DA          PHX
$A6:BCF8 AA          TAX
$A6:BCF9 3C 03 BD    BIT $BD03,x[$A6:BD05]
$A6:BCFC 30 03       BMI $03    [$BD01]
$A6:BCFE FA          PLX
$A6:BCFF 18          CLC
$A6:BD00 60          RTS

$A6:BD01 FA          PLX
$A6:BD02 38          SEC
$A6:BD03 60          RTS

$A6:BD04             db 80, ; 0: Standing
                        80, ; 1: Running
                        80, ; 2: Normal jumping
                        00, ; 3: Spin jumping
                        FF, ; 4: Morph ball - on ground
                        80, ; 5: Crouching
                        80, ; 6: Falling
                        FF, ; 7: Unused
                        FF, ; 8: Morph ball - falling
                        FF, ; 9: Unused
                        80, ; Ah: Knockback / crystal flash ending
                        00, ; Bh: Unused
                        00, ; Ch: Unused
                        80, ; Dh: Unused
                        80, ; Eh: Turning around - on ground
                        80, ; Fh: Crouching/standing/morphing/unmorphing transition
                        80, ; 10h: Moonwalking
                        FF, ; 11h: Spring ball - on ground
                        FF, ; 12h: Spring ball - in air
                        FF, ; 13h: Spring ball - falling
                        80, ; 14h: Wall jumping
                        80, ; 15h: Ran into a wall
                        00, ; 16h: Grappling
                        80, ; 17h: Turning around - jumping
                        80, ; 18h: Turning around - falling
                        00, ; 19h: Damage boost
                        00, ; 1Ah: Grabbed by Draygon
                        80  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $BD20:  ;;;
{
; Check if Y is below #$0160 (tail bounce Y position threshold?)
$A6:BD20 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A6:BD23 C9 60 01    CMP #$0160
$A6:BD26 10 02       BPL $02    [$BD2A]
$A6:BD28 18          CLC
$A6:BD29 60          RTS

$A6:BD2A 38          SEC
$A6:BD2B 60          RTS
}


;;; $BD2C:  ;;;
{
; Power Bomb Check/Reaction
$A6:BD2C AF 02 78 7E LDA $7E7802[$7E:7802]
$A6:BD30 30 1B       BMI $1B    [$BD4D]
$A6:BD32 F0 19       BEQ $19    [$BD4D]
$A6:BD34 C9 02 00    CMP #$0002
$A6:BD37 F0 14       BEQ $14    [$BD4D]
$A6:BD39 AD EE 0C    LDA $0CEE  [$7E:0CEE]
$A6:BD3C F0 0F       BEQ $0F    [$BD4D]
$A6:BD3E AF 36 78 7E LDA $7E7836[$7E:7836]
$A6:BD42 D0 09       BNE $09    [$BD4D]
$A6:BD44 20 4D B8    JSR $B84D  [$A6:B84D]
$A6:BD47 A0 B7 BA    LDY #$BAB7
$A6:BD4A 8C A8 0F    STY $0FA8  [$7E:0FA8]

$A6:BD4D 60          RTS
}


;;; $BD4E: Ridley function ;;;
{
; Ridley is dodging a power bomb (may be holding Samus)
$A6:BD4E AD EE 0C    LDA $0CEE  [$7E:0CEE]
$A6:BD51 F0 30       BEQ $30    [$BD83]
$A6:BD53 A9 02 00    LDA #$0002
$A6:BD56 8F 02 78 7E STA $7E7802[$7E:7802]
$A6:BD5A A0 50 00    LDY #$0050
$A6:BD5D AD E2 0C    LDA $0CE2  [$7E:0CE2]
$A6:BD60 C9 80 00    CMP #$0080
$A6:BD63 10 03       BPL $03    [$BD68]
$A6:BD65 A0 C0 00    LDY #$00C0

$A6:BD68 84 12       STY $12    [$7E:0012]
$A6:BD6A A0 C0 00    LDY #$00C0
$A6:BD6D AD E4 0C    LDA $0CE4  [$7E:0CE4]
$A6:BD70 C9 00 01    CMP #$0100
$A6:BD73 10 03       BPL $03    [$BD78]
$A6:BD75 A0 80 01    LDY #$0180

$A6:BD78 84 14       STY $14    [$7E:0014]
$A6:BD7A A2 00 00    LDX #$0000
$A6:BD7D 20 2E B4    JSR $B42E  [$A6:B42E]
$A6:BD80 4C 23 D5    JMP $D523  [$A6:D523]

$A6:BD83 A9 01 00    LDA #$0001
$A6:BD86 8F 02 78 7E STA $7E7802[$7E:7802]
$A6:BD8A A0 21 B3    LDY #$B321
$A6:BD8D AF 36 78 7E LDA $7E7836[$7E:7836]
$A6:BD91 F0 03       BEQ $03    [$BD96]
$A6:BD93 A0 8F BB    LDY #$BB8F

$A6:BD96 8C A8 0F    STY $0FA8  [$7E:0FA8]
$A6:BD99 60          RTS
}


;;; $BD9A: Ridley function ;;;
{
; Ceres Ridley initialise baby metroid drop
$A6:BD9A A9 C0 00    LDA #$00C0
$A6:BD9D 85 12       STA $12    [$7E:0012]
$A6:BD9F A9 80 00    LDA #$0080
$A6:BDA2 85 14       STA $14    [$7E:0014]
$A6:BDA4 A2 00 00    LDX #$0000
$A6:BDA7 A0 01 00    LDY #$0001
$A6:BDAA 20 2F D6    JSR $D62F  [$A6:D62F]
$A6:BDAD AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:BDB0 C9 C0 00    CMP #$00C0
$A6:BDB3 30 06       BMI $06    [$BDBB]
$A6:BDB5 A9 BC BD    LDA #$BDBC
$A6:BDB8 8D A8 0F    STA $0FA8  [$7E:0FA8]

$A6:BDBB 60          RTS
}


;;; $BDBC: Ridley function ;;;
{
; Ceres Ridley baby metroid drop
$A6:BDBC A9 40 FF    LDA #$FF40
$A6:BDBF 8F 00 80 7E STA $7E8000[$7E:8000]
$A6:BDC3 A9 C0 00    LDA #$00C0
$A6:BDC6 85 12       STA $12    [$7E:0012]
$A6:BDC8 A9 80 FF    LDA #$FF80
$A6:BDCB 85 14       STA $14    [$7E:0014]
$A6:BDCD A2 00 00    LDX #$0000
$A6:BDD0 A0 01 00    LDY #$0001
$A6:BDD3 20 2F D6    JSR $D62F  [$A6:D62F]
$A6:BDD6 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:BDD9 C9 20 00    CMP #$0020
$A6:BDDC 10 63       BPL $63    [$BE41]
$A6:BDDE A9 CA BE    LDA #$BECA
$A6:BDE1 8F 00 88 7E STA $7E8800[$7E:8800]
$A6:BDE5 A9 F2 BD    LDA #$BDF2
$A6:BDE8 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BDEB A9 15 00    LDA #$0015
$A6:BDEE 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:BDF1 60          RTS
}


;;; $BDF2: Ridley function ;;;
{
; Ceres Ridley pickup baby metroid delay
$A6:BDF2 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:BDF5 10 4A       BPL $4A    [$BE41]
$A6:BDF7 A9 58 E6    LDA #$E658
$A6:BDFA 20 67 D4    JSR $D467  [$A6:D467]
$A6:BDFD A9 03 BE    LDA #$BE03
$A6:BE00 8D A8 0F    STA $0FA8  [$7E:0FA8]
}


;;; $BE03: Ridley function ;;;
{
; Ceres Ridley baby metroid pickup
$A6:BE03 AF 04 88 7E LDA $7E8804[$7E:8804]
$A6:BE07 18          CLC
$A6:BE08 69 F6 FF    ADC #$FFF6
$A6:BE0B 85 12       STA $12    [$7E:0012]
$A6:BE0D AF 08 88 7E LDA $7E8808[$7E:8808]
$A6:BE11 18          CLC
$A6:BE12 69 C8 FF    ADC #$FFC8
$A6:BE15 85 14       STA $14    [$7E:0014]
$A6:BE17 A2 00 00    LDX #$0000
$A6:BE1A A0 0C 00    LDY #$000C
$A6:BE1D 20 23 D5    JSR $D523  [$A6:D523]
$A6:BE20 A9 0E 00    LDA #$000E
$A6:BE23 18          CLC
$A6:BE24 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:BE27 85 12       STA $12    [$7E:0012]
$A6:BE29 A9 42 00    LDA #$0042
$A6:BE2C 18          CLC
$A6:BE2D 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:BE30 85 14       STA $14    [$7E:0014]
$A6:BE32 A9 04 00    LDA #$0004
$A6:BE35 85 16       STA $16    [$7E:0016]
$A6:BE37 A9 04 00    LDA #$0004
$A6:BE3A 85 18       STA $18    [$7E:0018]
$A6:BE3C 20 61 BE    JSR $BE61  [$A6:BE61]
$A6:BE3F B0 01       BCS $01    [$BE42]
$A6:BE41 60          RTS

$A6:BE42 A9 01 00    LDA #$0001
$A6:BE45 8F 36 78 7E STA $7E7836[$7E:7836]
$A6:BE49 38          SEC
$A6:BE4A 20 8B DA    JSR $DA8B  [$A6:DA8B]
$A6:BE4D A9 00 FE    LDA #$FE00
$A6:BE50 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:BE53 A9 B3 BE    LDA #$BEB3
$A6:BE56 8F 00 88 7E STA $7E8800[$7E:8800]
$A6:BE5A A9 71 A9    LDA #$A971
$A6:BE5D 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:BE60 60          RTS
}


;;; $BE61:  ;;;
{
$A6:BE61 AF 04 88 7E LDA $7E8804[$7E:8804]
$A6:BE65 38          SEC
$A6:BE66 E5 12       SBC $12    [$7E:0012]
$A6:BE68 10 04       BPL $04    [$BE6E]
$A6:BE6A 49 FF FF    EOR #$FFFF
$A6:BE6D 1A          INC A

$A6:BE6E 38          SEC
$A6:BE6F E9 04 00    SBC #$0004
$A6:BE72 90 04       BCC $04    [$BE78]
$A6:BE74 C5 16       CMP $16    [$7E:0016]
$A6:BE76 B0 17       BCS $17    [$BE8F]

$A6:BE78 AF 08 88 7E LDA $7E8808[$7E:8808]
$A6:BE7C 38          SEC
$A6:BE7D E5 14       SBC $14    [$7E:0014]
$A6:BE7F 10 04       BPL $04    [$BE85]
$A6:BE81 49 FF FF    EOR #$FFFF
$A6:BE84 1A          INC A

$A6:BE85 38          SEC
$A6:BE86 E9 04 00    SBC #$0004
$A6:BE89 90 06       BCC $06    [$BE91]
$A6:BE8B C5 18       CMP $18    [$7E:0018]
$A6:BE8D 90 02       BCC $02    [$BE91]

$A6:BE8F 18          CLC
$A6:BE90 60          RTS

$A6:BE91 38          SEC
$A6:BE92 60          RTS
}


;;; $BE93:  ;;;
{
$A6:BE93 AF 00 88 7E LDA $7E8800[$7E:8800]
$A6:BE97 85 12       STA $12    [$7E:0012]
$A6:BE99 6C 12 00    JMP ($0012)[$A6:BE9C]
}


;;; $BE9C:  ;;;
{
$A6:BE9C A9 F0 FF    LDA #$FFF0
$A6:BE9F 18          CLC
$A6:BEA0 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:BEA3 8F 04 88 7E STA $7E8804[$7E:8804]
$A6:BEA7 A9 16 00    LDA #$0016
$A6:BEAA 18          CLC
$A6:BEAB 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:BEAE 8F 08 88 7E STA $7E8808[$7E:8808]
$A6:BEB2 60          RTS
}


;;; $BEB3:  ;;;
{
$A6:BEB3 A9 0E 00    LDA #$000E
$A6:BEB6 18          CLC
$A6:BEB7 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:BEBA 8F 04 88 7E STA $7E8804[$7E:8804]
$A6:BEBE A9 42 00    LDA #$0042
$A6:BEC1 18          CLC
$A6:BEC2 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:BEC5 8F 08 88 7E STA $7E8808[$7E:8808]
$A6:BEC9 60          RTS
}


;;; $BECA:  ;;;
{
; Initialise baby metroid falling to ground
$A6:BECA A9 00 00    LDA #$0000
$A6:BECD 8F 0A 88 7E STA $7E880A[$7E:880A]
$A6:BED1 8F 0C 88 7E STA $7E880C[$7E:880C]
$A6:BED5 A9 DC BE    LDA #$BEDC
$A6:BED8 8F 00 88 7E STA $7E8800[$7E:8800]
}


;;; $BEDC:  ;;;
{
; Baby metroid falls to ground
$A6:BEDC AF 0C 88 7E LDA $7E880C[$7E:880C]
$A6:BEE0 18          CLC
$A6:BEE1 69 08 00    ADC #$0008
$A6:BEE4 8F 0C 88 7E STA $7E880C[$7E:880C]
$A6:BEE8 E2 20       SEP #$20
$A6:BEEA 18          CLC
$A6:BEEB 6F 07 88 7E ADC $7E8807[$7E:8807]
$A6:BEEF 8F 07 88 7E STA $7E8807[$7E:8807]
$A6:BEF3 C2 20       REP #$20
$A6:BEF5 29 00 FF    AND #$FF00
$A6:BEF8 EB          XBA
$A6:BEF9 10 03       BPL $03    [$BEFE]
$A6:BEFB 09 00 FF    ORA #$FF00

$A6:BEFE 6F 08 88 7E ADC $7E8808[$7E:8808]
$A6:BF02 8F 08 88 7E STA $7E8808[$7E:8808]
$A6:BF06 C9 C0 00    CMP #$00C0
$A6:BF09 30 0E       BMI $0E    [$BF19]
$A6:BF0B A9 C0 00    LDA #$00C0
$A6:BF0E 8F 08 88 7E STA $7E8808[$7E:8808]
$A6:BF12 A9 19 BF    LDA #$BF19
$A6:BF15 8F 00 88 7E STA $7E8800[$7E:8800]

$A6:BF19 60          RTS
}


;;; $BF1A: Draw baby metroid ;;;
{
$A6:BF1A A9 06 78    LDA #$7806
$A6:BF1D 20 CB DB    JSR $DBCB  [$A6:DBCB]
$A6:BF20 AF 04 88 7E LDA $7E8804[$7E:8804]
$A6:BF24 85 12       STA $12    [$7E:0012]
$A6:BF26 AF 08 88 7E LDA $7E8808[$7E:8808]
$A6:BF2A 85 14       STA $14    [$7E:0014]
$A6:BF2C 64 16       STZ $16    [$7E:0016]
$A6:BF2E 4C 13 DC    JMP $DC13  [$A6:DC13]
}


;;; $BF31: Baby metroid instruction list ;;;
{
$A6:BF31             dw BFF2,BF59,  ; ???
                        000A,BFFD,
                        000A,C018,
                        000A,C033,
                        000A,C018,
                        BFF2,BF59,  ; ???
                        000A,BFFD,
                        000A,C018,
                        000A,C033,
                        000A,C018
$A6:BF59             dw BFC9,BF31,  ; ???
                        BFE1,E20F,  ; ???
                        0006,BFFD,
                        BFE1,E22D,  ; ???
                        0005,C018,
                        BFE1,E24B,  ; ???
                        0004,C033,
                        BFE1,E22D,  ; ???
                        0003,C018,
                        BFE1,E20F,  ; ???
                        0002,BFFD,
                        BFE1,E22D,  ; ???
                        0003,C018,
                        BFE1,E24B,  ; ???
                        0004,C033,
                        BFE1,E22D,  ; ???
                        0005,C018,
                        BFE1,E20F,  ; ???
                        0006,BFFD,
                        BFE1,E22D,  ; ???
                        0007,C018,
                        BFE1,E24B,  ; ???
                        0008,C033,
                        BFE1,E22D,  ; ???
                        0009,C018,
                        BFE1,E1F1,  ; ???
                        BFF2,BF59,  ; ???
                        BFF8,BF31   ; Go to $BF31
}


;;; $BFC9: Baby metroid instruction ;;;
{
$A6:BFC9 AF 0C 88 7E LDA $7E880C[$7E:880C]
$A6:BFCD D0 08       BNE $08    [$BFD7]
$A6:BFCF AD E5 05    LDA $05E5  [$7E:05E5]
$A6:BFD2 29 01 00    AND #$0001
$A6:BFD5 D0 21       BNE $21    [$BFF8]

$A6:BFD7 A9 24 00    LDA #$0024             ;\
$A6:BFDA 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 24h, sound library 3, max queued sounds allowed = 6 (baby metroid cry - Ceres)
}


;;; $BFDE: X += 2 ;;;
{
$A6:BFDE E8          INX
$A6:BFDF E8          INX
$A6:BFE0 60          RTS
}


;;; $BFE1: Baby metroid instruction ;;;
{
$A6:BFE1 BC 00 00    LDY $0000,x[$A6:BF5F]
$A6:BFE4 DA          PHX
$A6:BFE5 A2 62 01    LDX #$0162
$A6:BFE8 A9 0F 00    LDA #$000F
$A6:BFEB 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]
$A6:BFEF FA          PLX
$A6:BFF0 80 EC       BRA $EC    [$BFDE]
}


;;; $BFF2: Baby metroid instruction ;;;
{
$A6:BFF2 AF 0C 88 7E LDA $7E880C[$7E:880C]
$A6:BFF6 F0 E6       BEQ $E6    [$BFDE]
}


;;; $BFF8: Baby metroid instruction - go to [[X]] ;;;
{
$A6:BFF8 BD 00 00    LDA $0000,x[$A6:BFC7]
$A6:BFFB AA          TAX
$A6:BFFC 60          RTS
}


;;; $BFFD: Baby metroid spritemaps ;;;
{
$A6:BFFD             dx 0005, 0000,08,F50D, 01F8,08,B50D, 0000,F0,750D, 01F8,F0,350D, 81F8,F8,3742
$A6:C018             dx 0005, 0000,08,F50D, 01F8,08,B50D, 0000,F0,750D, 01F8,F0,350D, 81F8,F8,374C
$A6:C033             dx 0005, 0000,08,F50D, 01F8,08,B50D, 0000,F0,750D, 01F8,F0,350D, 81F8,F8,374E
}


;;; $C04E: Ridley function ;;;
{
$A6:C04E AE B2 0F    LDX $0FB2  [$7E:0FB2]
$A6:C051 7C 54 C0    JMP ($C054,x)[$A6:C062]

$A6:C054             dw C062, C08E, C09F, C0BB, C0F5, C104, C117
}


;;; $C062:  ;;;
{
$A6:C062 AF 02 C0 7E LDA $7EC002[$7E:C002]
$A6:C066 8F C2 C0 7E STA $7EC0C2[$7E:C0C2]
$A6:C06A AF 06 C0 7E LDA $7EC006[$7E:C006]
$A6:C06E 8F C6 C0 7E STA $7EC0C6[$7E:C0C6]
$A6:C072 AF 22 C0 7E LDA $7EC022[$7E:C022]
$A6:C076 8F A2 C0 7E STA $7EC0A2[$7E:C0A2]
$A6:C07A AF 26 C0 7E LDA $7EC026[$7E:C026]
$A6:C07E 8F A6 C0 7E STA $7EC0A6[$7E:C0A6]
$A6:C082 A2 CB C4    LDX #$C4CB
$A6:C085 8E B0 0F    STX $0FB0  [$7E:0FB0]
$A6:C088 EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C08B EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C08E 20 6E C2    JSR $C26E  [$A6:C26E]
$A6:C091 90 27       BCC $27    [$C0BA]
$A6:C093 A2 FE C4    LDX #$C4FE
$A6:C096 8E B0 0F    STX $0FB0  [$7E:0FB0]
$A6:C099 EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C09C EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C09F 20 6E C2    JSR $C26E  [$A6:C26E]
$A6:C0A2 90 16       BCC $16    [$C0BA]
$A6:C0A4 EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C0A7 EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C0AA 20 36 C1    JSR $C136  [$A6:C136]
$A6:C0AD A9 80 00    LDA #$0080
$A6:C0B0 8D B0 0F    STA $0FB0  [$7E:0FB0]
$A6:C0B3 A9 07 00    LDA #$0007             ;\
$A6:C0B6 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 2 music track

$A6:C0BA 60          RTS
}


;;; $C0BB: Set up Ceres escape timer ;;;
{
$A6:C0BB 20 9C C1    JSR $C19C  [$A6:C19C]
$A6:C0BE CE B0 0F    DEC $0FB0  [$7E:0FB0]
$A6:C0C1 D0 31       BNE $31    [$C0F4]
$A6:C0C3 A9 50 C4    LDA #$C450
$A6:C0C6 8F 36 80 7E STA $7E8036[$7E:8036]
$A6:C0CA A9 00 00    LDA #$0000
$A6:C0CD 8F 38 80 7E STA $7E8038[$7E:8038]
$A6:C0D1 8F 3A 80 7E STA $7E803A[$7E:803A]
$A6:C0D5 8F 3C 80 7E STA $7E803C[$7E:803C]
$A6:C0D9 8F 3E 80 7E STA $7E803E[$7E:803E]
$A6:C0DD A9 20 00    LDA #$0020
$A6:C0E0 8D B0 0F    STA $0FB0  [$7E:0FB0]
$A6:C0E3 AD E2 09    LDA $09E2  [$7E:09E2]
$A6:C0E6 D0 06       BNE $06    [$C0EE]
$A6:C0E8 EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C0EB EE B2 0F    INC $0FB2  [$7E:0FB2]

$A6:C0EE EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C0F1 EE B2 0F    INC $0FB2  [$7E:0FB2]

$A6:C0F4 60          RTS
}


;;; $C0F5:  ;;;
{
$A6:C0F5 CE B0 0F    DEC $0FB0  [$7E:0FB0]
$A6:C0F8 D0 0A       BNE $0A    [$C104]
$A6:C0FA EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C0FD EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C100 22 83 C3 A6 JSL $A6C383[$A6:C383]
}


;;; $C104:  ;;;
{
$A6:C104 20 9C C1    JSR $C19C  [$A6:C19C]
$A6:C107 A9 82 35    LDA #$3582
$A6:C10A 22 A7 C2 A6 JSL $A6C2A7[$A6:C2A7]
$A6:C10E 90 06       BCC $06    [$C116]
$A6:C110 EE B2 0F    INC $0FB2  [$7E:0FB2]
$A6:C113 EE B2 0F    INC $0FB2  [$7E:0FB2]

$A6:C116 60          RTS
}


;;; $C117:  ;;;
{
$A6:C117 20 9C C1    JSR $C19C  [$A6:C19C]
$A6:C11A 20 54 A3    JSR $A354  [$A6:A354]
$A6:C11D 9C B2 0F    STZ $0FB2  [$7E:0FB2]
$A6:C120 A9 50 AA    LDA #$AA50
$A6:C123 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:C126 A9 01 00    LDA #$0001
$A6:C129 8D 43 09    STA $0943  [$7E:0943]
$A6:C12C 1A          INC A
$A6:C12D 8D 3F 09    STA $093F  [$7E:093F]
$A6:C130 3A          DEC A
$A6:C131 22 A6 81 80 JSL $8081A6[$80:81A6]
$A6:C135 60          RTS
}


;;; $C136:  ;;;
{
; Display 'EMERGENCY' text
$A6:C136 A2 5D C1    LDX #$C15D
$A6:C139 AC 30 03    LDY $0330  [$7E:0330]
$A6:C13C BD 00 00    LDA $0000,x[$A6:C15D]
$A6:C13F 99 D0 00    STA $00D0,y[$7E:00D7]
$A6:C142 BD 03 00    LDA $0003,x[$A6:C160]
$A6:C145 99 D3 00    STA $00D3,y[$7E:00DA]
$A6:C148 BD 02 00    LDA $0002,x[$A6:C15F]
$A6:C14B 99 D2 00    STA $00D2,y[$7E:00D9]
$A6:C14E BD 05 00    LDA $0005,x[$A6:C162]
$A6:C151 99 D5 00    STA $00D5,y[$7E:00DC]
$A6:C154 98          TYA
$A6:C155 18          CLC
$A6:C156 69 07 00    ADC #$0007
$A6:C159 8D 30 03    STA $0330  [$7E:0330]
$A6:C15C 60          RTS

$A6:C15D             dx 0012,A6C164,50CB

$A6:C164             dw 3986, 398E, 3986, 3993, 3988, 3986, 398F, 3984, 399A
}


;;; $C176:  ;;;
{
$A6:C176 A2 16 00    LDX #$0016
$A6:C179 AF 32 80 7E LDA $7E8032[$7E:8032]
$A6:C17D 1A          INC A
$A6:C17E C9 20 00    CMP #$0020
$A6:C181 30 03       BMI $03    [$C186]
$A6:C183 A9 E1 FF    LDA #$FFE1

$A6:C186 8F 32 80 7E STA $7E8032[$7E:8032]
$A6:C18A AF 32 80 7E LDA $7E8032[$7E:8032]
$A6:C18E 10 04       BPL $04    [$C194]
$A6:C190 49 FF FF    EOR #$FFFF
$A6:C193 1A          INC A

$A6:C194 29 1F 00    AND #$001F
$A6:C197 9F 00 C0 7E STA $7EC000,x
$A6:C19B 60          RTS
}


;;; $C19C:  ;;;
{
$A6:C19C AF 00 C4 7E LDA $7EC400[$7E:C400]
$A6:C1A0 0D 97 07    ORA $0797  [$7E:0797]
$A6:C1A3 F0 01       BEQ $01    [$C1A6]

$A6:C1A5 60          RTS

$A6:C1A6 AD B6 05    LDA $05B6  [$7E:05B6]
$A6:C1A9 29 03 00    AND #$0003
$A6:C1AC D0 F7       BNE $F7    [$C1A5]
$A6:C1AE AF 30 80 7E LDA $7E8030[$7E:8030]
$A6:C1B2 1A          INC A
$A6:C1B3 C9 10 00    CMP #$0010
$A6:C1B6 90 03       BCC $03    [$C1BB]
$A6:C1B8 A9 00 00    LDA #$0000

$A6:C1BB 8F 30 80 7E STA $7E8030[$7E:8030]
$A6:C1BF 0A          ASL A
$A6:C1C0 6F 30 80 7E ADC $7E8030[$7E:8030]
$A6:C1C4 0A          ASL A
$A6:C1C5 A8          TAY
$A6:C1C6 A2 C2 00    LDX #$00C2
$A6:C1C9 B9 DF C1    LDA $C1DF,y[$A6:C1E5]
$A6:C1CC 9F 00 C0 7E STA $7EC000,x[$7E:C0C2]
$A6:C1D0 B9 E1 C1    LDA $C1E1,y[$A6:C1E7]
$A6:C1D3 9F 02 C0 7E STA $7EC002,x[$7E:C0C4]
$A6:C1D7 B9 E3 C1    LDA $C1E3,y[$A6:C1E9]
$A6:C1DA 9F 04 C0 7E STA $7EC004,x[$7E:C0C6]
$A6:C1DE 60          RTS

; BG1/2 palette 6 colours 1..3
$A6:C1DF             dw 02DF,01D7,00AC,
                        06BE,05B7,04AC,
                        0A9E,09B7,08AD,
                        0E7D,0D97,0CAE,
                        125D,1197,10AF,
                        1A3C,1977,18B0,
                        1E1C,1D77,1CB0,
                        21FB,2157,20B1,
                        25DB,2557,24D2,
                        21FB,2157,20B1,
                        1E1C,1D77,1CB0,
                        1A3C,1977,18B0,
                        125D,1197,10AF,
                        0E7D,0D97,0CAE,
                        0A9E,09B7,08AD,
                        06BE,05B7,04AC
}


;;; $C23F: Set up Zebes escape typewriter ;;;
{
$A6:C23F AF FA C0 7E LDA $7EC0FA[$7E:C0FA]  ;\
$A6:C243 8F 3A C1 7E STA $7EC13A[$7E:C13A]  ;|
$A6:C247 AF FC C0 7E LDA $7EC0FC[$7E:C0FC]  ;} Sprite palette 1 colour Dh..Eh = [BG1/2 palette 7 colour Dh..Eh]
$A6:C24B 8F 3C C1 7E STA $7EC13C[$7E:C13C]  ;/
$A6:C24F A9 9C C4    LDA #$C49C             ;\
$A6:C252 8F 36 80 7E STA $7E8036[$7E:8036]  ;} Typewriter instruction list pointer = $C49C (typewriter text - Zebes escape timer)
$A6:C256 A9 00 00    LDA #$0000             ;\
$A6:C259 8F 38 80 7E STA $7E8038[$7E:8038]  ;} Typewriter VRAM tilemap address = 0
$A6:C25D 8F 3A 80 7E STA $7E803A[$7E:803A]  ; Typewriter instruction timer = 0
$A6:C261 8F 3C 80 7E STA $7E803C[$7E:803C]  ; Typewriter instruction timer reset value = 0
$A6:C265 8F 3E 80 7E STA $7E803E[$7E:803E]  ; Typewriter stroke timer = 0
$A6:C269 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$A6:C26B 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$A6:C26D 6B          RTL
}


;;; $C26E: Process escape timer tile transfers ;;;
{
$A6:C26E AE B0 0F    LDX $0FB0  [$7E:0FB0]  ; X = [$0FB0]
$A6:C271 AC 30 03    LDY $0330  [$7E:0330]  ; Y = [VRAM write table stack pointer]
$A6:C274 BD 00 00    LDA $0000,x[$A6:C4CB]  ;\
$A6:C277 F0 2C       BEQ $2C    [$C2A5]     ;} If [[X]] != 0:
$A6:C279 99 D0 00    STA $00D0,y[$7E:00D0]  ;\
$A6:C27C BD 03 00    LDA $0003,x[$A6:C4CE]  ;|
$A6:C27F 99 D3 00    STA $00D3,y[$7E:00D3]  ;|
$A6:C282 BD 02 00    LDA $0002,x[$A6:C4CD]  ;|
$A6:C285 99 D2 00    STA $00D2,y[$7E:00D2]  ;|
$A6:C288 BD 05 00    LDA $0005,x[$A6:C4D0]  ;} Queue transfer of [[X]] bytes from [[X] + 2] to VRAM [[X] + 5]
$A6:C28B 99 D5 00    STA $00D5,y[$7E:00D5]  ;|
$A6:C28E 98          TYA                    ;\
$A6:C28F 18          CLC                    ;|
$A6:C290 69 07 00    ADC #$0007             ;} VRAM write table stack pointer += 7
$A6:C293 8D 30 03    STA $0330  [$7E:0330]  ;/
$A6:C296 8A          TXA                    ;\
$A6:C297 69 07 00    ADC #$0007             ;} $0FB0 += 7
$A6:C29A 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;/
$A6:C29D AA          TAX                    ;\
$A6:C29E BD 00 00    LDA $0000,x[$A6:C4D2]  ;} If [[X]] != 0:
$A6:C2A1 F0 02       BEQ $02    [$C2A5]     ;/
$A6:C2A3 18          CLC                    ;\
$A6:C2A4 60          RTS                    ;} Return carry clear

$A6:C2A5 38          SEC                    ;\
$A6:C2A6 60          RTS                    ;} Return carry set
}


;;; $C2A7: Handle typewriter text (external) ;;;
{
$A6:C2A7 85 12       STA $12    [$7E:0012]  ; $12 = [A]
$A6:C2A9 8B          PHB
$A6:C2AA 4B          PHK                    ;\
$A6:C2AB AB          PLB                    ;} DB = $A6
$A6:C2AC 20 B1 C2    JSR $C2B1  [$A6:C2B1]  ; Handle typewriter text
$A6:C2AF AB          PLB
$A6:C2B0 6B          RTL
}


;;; $C2B1: Handle typewriter text ;;;
{
;; Returns:
;;     Carry: Set if finished, clear otherwise

; Incrementally writes text like "TIME BOMB SET EVACUATE IMMEDIATELY",
$A6:C2B1 AF 3A 80 7E LDA $7E803A[$7E:803A]
$A6:C2B5 F0 06       BEQ $06    [$C2BD]
$A6:C2B7 3A          DEC A
$A6:C2B8 8F 3A 80 7E STA $7E803A[$7E:803A]
$A6:C2BC 60          RTS

$A6:C2BD AF 3C 80 7E LDA $7E803C[$7E:803C]
$A6:C2C1 8F 3A 80 7E STA $7E803A[$7E:803A]
$A6:C2C5 AF 36 80 7E LDA $7E8036[$7E:8036]
$A6:C2C9 AA          TAX

; LOOP
$A6:C2CA BD 00 00    LDA $0000,x[$A6:C450]
$A6:C2CD D0 02       BNE $02    [$C2D1]
$A6:C2CF 38          SEC
$A6:C2D0 60          RTS

$A6:C2D1 C9 01 00    CMP #$0001
$A6:C2D4 D0 0E       BNE $0E    [$C2E4]
$A6:C2D6 E8          INX
$A6:C2D7 E8          INX
$A6:C2D8 BD 00 00    LDA $0000,x[$A6:C452]
$A6:C2DB 8F 3C 80 7E STA $7E803C[$7E:803C]
$A6:C2DF E8          INX
$A6:C2E0 E8          INX
$A6:C2E1 4C CA C2    JMP $C2CA  [$A6:C2CA]

$A6:C2E4 C9 0D 00    CMP #$000D
$A6:C2E7 D0 0E       BNE $0E    [$C2F7]
$A6:C2E9 E8          INX
$A6:C2EA E8          INX
$A6:C2EB BD 00 00    LDA $0000,x[$A6:C456]
$A6:C2EE 8F 38 80 7E STA $7E8038[$7E:8038]
$A6:C2F2 E8          INX
$A6:C2F3 E8          INX
$A6:C2F4 4C CA C2    JMP $C2CA  [$A6:C2CA]

$A6:C2F7 29 FF 00    AND #$00FF
$A6:C2FA C9 20 00    CMP #$0020
$A6:C2FD D0 11       BNE $11    [$C310]
$A6:C2FF AF 38 80 7E LDA $7E8038[$7E:8038]
$A6:C303 1A          INC A
$A6:C304 8F 38 80 7E STA $7E8038[$7E:8038]
$A6:C308 E8          INX
$A6:C309 8A          TXA
$A6:C30A 8F 36 80 7E STA $7E8036[$7E:8036]
$A6:C30E 18          CLC
$A6:C30F 60          RTS

$A6:C310 C9 21 00    CMP #$0021
$A6:C313 D0 03       BNE $03    [$C318]
$A6:C315 A9 5B 00    LDA #$005B

$A6:C318 48          PHA
$A6:C319 8A          TXA
$A6:C31A 1A          INC A
$A6:C31B 8F 36 80 7E STA $7E8036[$7E:8036]
$A6:C31F AC 30 03    LDY $0330  [$7E:0330]
$A6:C322 A9 02 00    LDA #$0002
$A6:C325 99 D0 00    STA $00D0,y[$7E:00D0]
$A6:C328 A9 00 7E    LDA #$7E00
$A6:C32B 99 D3 00    STA $00D3,y[$7E:00D3]
$A6:C32E 68          PLA
$A6:C32F 38          SEC
$A6:C330 E9 41 00    SBC #$0041
$A6:C333 18          CLC
$A6:C334 65 12       ADC $12    [$7E:0012]
$A6:C336 8F 34 80 7E STA $7E8034[$7E:8034]
$A6:C33A A9 34 80    LDA #$8034
$A6:C33D 99 D2 00    STA $00D2,y[$7E:00D2]
$A6:C340 AF 38 80 7E LDA $7E8038[$7E:8038]
$A6:C344 99 D5 00    STA $00D5,y[$7E:00D5]
$A6:C347 1A          INC A
$A6:C348 8F 38 80 7E STA $7E8038[$7E:8038]
$A6:C34C 98          TYA
$A6:C34D 18          CLC
$A6:C34E 69 07 00    ADC #$0007
$A6:C351 8D 30 03    STA $0330  [$7E:0330]
$A6:C354 AF 3E 80 7E LDA $7E803E[$7E:803E]
$A6:C358 1A          INC A
$A6:C359 8F 3E 80 7E STA $7E803E[$7E:803E]
$A6:C35D C9 02 00    CMP #$0002
$A6:C360 30 1F       BMI $1F    [$C381]
$A6:C362 A9 00 00    LDA #$0000
$A6:C365 8F 3E 80 7E STA $7E803E[$7E:803E]
$A6:C369 AD 9F 07    LDA $079F  [$7E:079F]
$A6:C36C C9 06 00    CMP #$0006
$A6:C36F D0 09       BNE $09    [$C37A]
$A6:C371 A9 45 00    LDA #$0045             ;\
$A6:C374 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 45h, sound library 2, max queued sounds allowed = 3 (typewriter stroke - Ceres self destruct sequence)
$A6:C378 80 07       BRA $07    [$C381]

$A6:C37A A9 0D 00    LDA #$000D             ;\
$A6:C37D 22 39 91 80 JSL $809139[$80:9139]  ;} Queue sound Dh, sound library 3, max queued sounds allowed = 3 (typewriter stroke - intro)

$A6:C381 18          CLC
$A6:C382 60          RTS
}


;;; $C383:  ;;;
{
$A6:C383 A2 B8 C3    LDX #$C3B8             ; X = $C3B8
$A6:C386 8B          PHB
$A6:C387 4B          PHK                    ;\
$A6:C388 AB          PLB                    ;} DB = $A6
$A6:C389 AC 30 03    LDY $0330  [$7E:0330]  ; Y = [VRAM write table stack pointer]

; LOOP
$A6:C38C BD 00 00    LDA $0000,x            ;\
$A6:C38F F0 22       BEQ $22    [$C3B3]     ;} If [[X]] != 0:
$A6:C391 99 D0 00    STA $00D0,y            ;\
$A6:C394 BD 03 00    LDA $0003,x            ;|
$A6:C397 99 D3 00    STA $00D3,y            ;|
$A6:C39A BD 02 00    LDA $0002,x            ;|
$A6:C39D 99 D2 00    STA $00D2,y            ;|
$A6:C3A0 BD 05 00    LDA $0005,x            ;} Queue transfer of [[X]] bytes from [[X] + 2] to VRAM [[X] + 5]
$A6:C3A3 99 D5 00    STA $00D5,y            ;|
$A6:C3A6 98          TYA                    ;\
$A6:C3A7 18          CLC                    ;|
$A6:C3A8 69 07 00    ADC #$0007             ;} Y += 7
$A6:C3AB A8          TAY                    ;/
$A6:C3AC 8A          TXA                    ;\
$A6:C3AD 69 07 00    ADC #$0007             ;} X += 7
$A6:C3B0 AA          TAX                    ;/
$A6:C3B1 80 D9       BRA $D9    [$C38C]     ; Go to LOOP

$A6:C3B3 8C 30 03    STY $0330  [$7E:0330]  ; VRAM write table stack pointer = [Y]
$A6:C3B6 AB          PLB
$A6:C3B7 6B          RTL
}


;;; $C3B8: Tilemap transfer entries ;;;
{
;                        _______________ Size. Zero terminator
;                       |     __________ Source address
;                       |    |       ___ VRAM address
;                       |    |      |
$A6:C3B8             dx 0018,A6C3F4,528A,
                        0018,A6C40C,52AA,
                        0016,A6C424,52CA,
                        0016,A6C43A,52EA,
                        0000

$A6:C3D6             dx 0018,A6C3F4,4A8A,
                        0018,A6C40C,4AAA,
                        0016,A6C424,4ACA,
                        0016,A6C43A,4AEA,
                        0000
}


;;; $C3F4: Tilemaps ;;;
{
$A6:C3F4             dw 3DA0, 3DA1, 3DA2, 3DA3, 3DA4, 3DA5, 3DA6, 3DA7, 3DAF, 3DA8, 3DAF, 3DA9
$A6:C40C             dw 3DB0, 3DB1, 3DB2, 3DB3, 3DB4, 3DB5, 3DB6, 3DB7, 3DBF, 3DB8, 3DBF, 3DB9
$A6:C424             dw 3DA9, 3DAA, 3DAB, 3DAC, 3DAD, 3DAE, 3DAF, 3D9C, 3D9D, 3D9E, 3D9F
$A6:C43A             dw 3DB9, 3DBA, 3DBB, 3DBC, 3DBD, 3DBE, 3DBF, 3DC0, 3DC1, 3DC2, 3DC3
}


;;; $C450: Typewriter text - Ceres escape timer ;;;
{
$A6:C450             dx 0001,0002, ; Timer reset value = 2
                        000D,5105, ; VRAM tilemap address = $5105 (BG1 tile (5, 8))
                        53, 45, 4C, 46, 20, 44, 45, 53, 54, 52, 55, 43, 54, 20, 53, 45, 51, 55, 45, 4E, 43, 45, ; 'SELF DESTRUCT SEQUENCE'
                        000D,5145, ; VRAM tilemap address = $5145 (BG1 tile (5, Ah))
                        41, 43, 54, 49, 56, 41, 54, 45, 44, 20, 45, 56, 41, 43, 55, 41, 54, 45, ; 'ACTIVATED EVACUATE'
                        000D,5185, ; VRAM tilemap address = $5185 (BG1 tile (5, Ch))
                        43, 4F, 4C, 4F, 4E, 59, 20, 49, 4D, 4D, 45, 44, 49, 41, 54, 45, 4C, 59, ; 'COLONY IMMEDIATELY'
                        0000
}


;;; $C49C: Typewriter text - Zebes escape timer ;;;
{
$A6:C49C             dx 0001,0002, ; Timer reset value = 2
                        000D,4905, ; VRAM tilemap address = $4905 (BG2 tile (5, 8))
                        54, 49, 4D, 45, 20, 42, 4F, 4D, 42, 20, 53, 45, 54, 21, ; 'TIME BOMB SET!'
                        000D,4945, ; VRAM tilemap address = $4945 (BG2 tile (5, Ah))
                        45, 53, 43, 41, 50, 45, 20, 49, 4D, 4D, 45, 44, 49, 41, 54, 45, 4C, 59, 21, ; 'ESCAPE IMMEDIATELY!'
                        0000
}


;;; $C4CB: Zebes escape timer sprite tile transfer entries ;;;
{
; Loaded by Mother Brain in $A9:B258

;                        _______________ Size. Zero terminator
;                       |     __________ Source address
;                       |    |       ___ VRAM address
;                       |    |      |
$A6:C4CB             dx 0200,B0C000,7E00, ; Escape timer numbers
                        0120,B0C200,7F00,
                        0200,B7DA00,7820, ; Escape timer text
                        0200,B7DC00,7920,
                        0200,B7DE00,7A20,
                        0200,B7E000,7B20,
                        0100,B7E200,7C20,
                        0000
}


;;; $C4FE: Ceres escape timer BG1/2 tile transfer entries ;;;
{
;                        _______________ Size. Zero terminator
;                       |     __________ Source address
;                       |    |       ___ VRAM address
;                       |    |      |
$A6:C4FE             dx 0200,B7DA00,1820, ; Escape timer text
                        0200,B7DC00,1920,
                        0200,B7DE00,1A20,
                        0200,B7E000,1B20,
                        0100,B7E200,1C20,
                        0200,B0BA00,0D00, ; Ceres door tiles
                        0200,B0BC00,0E00,
                        0200,B0BE00,0F00,
                        0000
}


;;; $C538: Ridley function ;;;
{
; Move Ridley towards 80,148
$A6:C538 20 01 C6    JSR $C601  [$A6:C601]
$A6:C53B 90 01       BCC $01    [$C53E]
$A6:C53D 60          RTS
}


;;; $C53E: Ridley function ;;;
{
; Final roar
$A6:C53E A9 C8 E6    LDA #$E6C8
$A6:C541 20 67 D4    JSR $D467  [$A6:D467]
$A6:C544 A9 51 C5    LDA #$C551
$A6:C547 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:C54A A9 20 00    LDA #$0020
$A6:C54D 8D B2 0F    STA $0FB2  [$7E:0FB2]

$A6:C550 60          RTS
}


;;; $C551: Ridley function ;;;
{
; Move to death spot, wait, then lower acid
$A6:C551 20 01 C6    JSR $C601  [$A6:C601]
$A6:C554 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:C557 10 F7       BPL $F7    [$C550]
$A6:C559 9C AA 0F    STZ $0FAA  [$7E:0FAA]
$A6:C55C 9C AC 0F    STZ $0FAC  [$7E:0FAC]
$A6:C55F A9 10 02    LDA #$0210
$A6:C562 8D 7A 19    STA $197A  [$7E:197A]
$A6:C565 A9 40 00    LDA #$0040
$A6:C568 8D 7C 19    STA $197C  [$7E:197C]
$A6:C56B A9 01 00    LDA #$0001
$A6:C56E 8D 80 19    STA $1980  [$7E:1980]
$A6:C571 A9 00 00    LDA #$0000
$A6:C574 8F 0E 80 7E STA $7E800E[$7E:800E]
$A6:C578 8F 10 80 7E STA $7E8010[$7E:8010]
$A6:C57C A9 88 C5    LDA #$C588
$A6:C57F 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:C582 A9 A0 00    LDA #$00A0
$A6:C585 8D B2 0F    STA $0FB2  [$7E:0FB2]
}


;;; $C588: Ridley function ;;;
{
; Explosions for death. After a while, drop Samus if needed
$A6:C588 20 23 C6    JSR $C623  [$A6:C623]
$A6:C58B CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:C58E 10 C0       BPL $C0    [$C550]
$A6:C590 AF 36 78 7E LDA $7E7836[$7E:7836]
$A6:C594 F0 03       BEQ $03    [$C599]
$A6:C596 20 84 BC    JSR $BC84  [$A6:BC84]

$A6:C599 A9 A8 C5    LDA #$C5A8
$A6:C59C 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:C59F 9C AA 0F    STZ $0FAA  [$7E:0FAA]
$A6:C5A2 9C AC 0F    STZ $0FAC  [$7E:0FAC]
$A6:C5A5 4C 32 C9    JMP $C932  [$A6:C932]
}


;;; $C5A8: Ridley function ;;;
{
; Disable Ridley
$A6:C5A8 20 23 C6    JSR $C623  [$A6:C623]
$A6:C5AB A9 00 00    LDA #$0000
$A6:C5AE 8F 04 78 7E STA $7E7804[$7E:7804]
$A6:C5B2 AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:C5B5 09 00 01    ORA #$0100
$A6:C5B8 8D 86 0F    STA $0F86  [$7E:0F86]
$A6:C5BB A9 C8 C5    LDA #$C5C8
$A6:C5BE 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:C5C1 A9 20 00    LDA #$0020
$A6:C5C4 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:C5C7 60          RTS
}


;;; $C5C8: Ridley function ;;;
{
; Wait 20 frames
$A6:C5C8 CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:C5CB 10 83       BPL $83    [$C550]
$A6:C5CD A9 DA C5    LDA #$C5DA
$A6:C5D0 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:C5D3 A9 00 01    LDA #$0100
$A6:C5D6 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A6:C5D9 60          RTS
}


;;; $C5DA: Ridley function ;;;
{
; Wait 100 frames, then drop items, change music, and set boss bit
$A6:C5DA CE B2 0F    DEC $0FB2  [$7E:0FB2]
$A6:C5DD 10 21       BPL $21    [$C600]
$A6:C5DF A9 01 00    LDA #$0001
$A6:C5E2 22 A6 81 80 JSL $8081A6[$80:81A6]
$A6:C5E6 22 A5 B9 A0 JSL $A0B9A5[$A0:B9A5]  ; Ridley death item drop routine
$A6:C5EA A9 03 00    LDA #$0003             ;\
$A6:C5ED 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue elevator music track
$A6:C5F1 AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:C5F4 09 00 02    ORA #$0200
$A6:C5F7 8D 86 0F    STA $0F86  [$7E:0F86]
$A6:C5FA A9 00 C6    LDA #$C600
$A6:C5FD 8D A8 0F    STA $0FA8  [$7E:0FA8]

$A6:C600 60          RTS
}


;;; $C601:  ;;;
{
; Move to death spot, CLC when near it
$A6:C601 A2 80 00    LDX #$0080
$A6:C604 86 12       STX $12    [$7E:0012]
$A6:C606 A0 48 01    LDY #$0148
$A6:C609 84 14       STY $14    [$7E:0014]
$A6:C60B A2 00 00    LDX #$0000
$A6:C60E A0 00 00    LDY #$0000
$A6:C611 A9 10 00    LDA #$0010
$A6:C614 20 26 D5    JSR $D526  [$A6:D526]
$A6:C617 A9 04 00    LDA #$0004
$A6:C61A 85 16       STA $16    [$7E:0016]
$A6:C61C 85 18       STA $18    [$7E:0018]
$A6:C61E 22 06 EF A9 JSL $A9EF06[$A9:EF06]
$A6:C622 60          RTS
}


;;; $C623:  ;;;
{
; Keep playing explosions
$A6:C623 AF 0E 80 7E LDA $7E800E[$7E:800E]
$A6:C627 3A          DEC A
$A6:C628 30 05       BMI $05    [$C62F]
$A6:C62A 8F 0E 80 7E STA $7E800E[$7E:800E]
$A6:C62E 60          RTS

$A6:C62F A9 04 00    LDA #$0004
$A6:C632 8F 0E 80 7E STA $7E800E[$7E:800E]
$A6:C636 AF 10 80 7E LDA $7E8010[$7E:8010]
$A6:C63A 1A          INC A
$A6:C63B C9 0A 00    CMP #$000A
$A6:C63E 30 03       BMI $03    [$C643]
$A6:C640 A9 00 00    LDA #$0000

$A6:C643 8F 10 80 7E STA $7E8010[$7E:8010]
$A6:C647 0A          ASL A
$A6:C648 0A          ASL A
$A6:C649 A8          TAY
$A6:C64A B9 6E C6    LDA $C66E,y[$A6:C672]
$A6:C64D 18          CLC
$A6:C64E 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:C651 85 12       STA $12    [$7E:0012]
$A6:C653 B9 70 C6    LDA $C670,y[$A6:C674]
$A6:C656 18          CLC
$A6:C657 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:C65A 85 14       STA $14    [$7E:0014]
$A6:C65C A9 03 00    LDA #$0003             ; A = 3 (small explosion)
$A6:C65F A0 09 E5    LDY #$E509             ;\
$A6:C662 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A6:C666 A9 24 00    LDA #$0024             ;\
$A6:C669 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 24h, sound library 2, max queued sounds allowed = 3 (small explosion)
$A6:C66D 60          RTS

$A6:C66E             dw FFE8,FFE8, FFEC,0014, 0010,FFE2, 001E,FFFD, 000E,FFF3, FFFE,0012, FFFE,FFE0, FFE1,0008, FFFC,FFF6, 0013,0013
}


;;; $C696: Initialisation AI - enemy $E1BF (Ridley's explosion) ;;;
{
$A6:C696 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C699 A9 01 00    LDA #$0001
$A6:C69C 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A6:C69F 9E 90 0F    STZ $0F90,x[$7E:0FD0]
$A6:C6A2 9E 98 0F    STZ $0F98,x[$7E:0FD8]
$A6:C6A5 A9 00 0E    LDA #$0E00
$A6:C6A8 9D 96 0F    STA $0F96,x[$7E:0FD6]
$A6:C6AB BC B4 0F    LDY $0FB4,x[$7E:0FF4]
$A6:C6AE B9 CE C6    LDA $C6CE,y[$A6:C6DA]
$A6:C6B1 9D B2 0F    STA $0FB2,x[$7E:0FF2]
$A6:C6B4 22 11 81 80 JSL $808111[$80:8111]
$A6:C6B8 29 30 01    AND #$0130
$A6:C6BB 2C E5 05    BIT $05E5  [$7E:05E5]
$A6:C6BE 10 04       BPL $04    [$C6C4]
$A6:C6C0 49 FF FF    EOR #$FFFF
$A6:C6C3 1A          INC A

$A6:C6C4 9D AA 0F    STA $0FAA,x[$7E:0FEA]
$A6:C6C7 9E AC 0F    STZ $0FAC,x[$7E:0FEC]
$A6:C6CA BB          TYX
$A6:C6CB 7C E6 C6    JMP ($C6E6,x)[$A6:C78E]

$A6:C6CE             dw 0048, 0050, 0058, 0060, 0068, 0070, 0078, 0028, 0030, 0038, 0080, 0040

$A6:C6E6             dw C6FE, C716, C72E, C746, C75E, C776, C78E, C7DA, C80C, C83E, C870, C8A2
}


;;; $C6FE:  ;;;
{
$A6:C6FE AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C701 AF 2C 20 7E LDA $7E202C[$7E:202C]
$A6:C705 9D 7A 0F    STA $0F7A,x[$7E:113A]
$A6:C708 AF 2E 20 7E LDA $7E202E[$7E:202E]
$A6:C70C 9D 7E 0F    STA $0F7E,x[$7E:113E]
$A6:C70F A9 47 CA    LDA #$CA47
$A6:C712 9D 92 0F    STA $0F92,x[$7E:1152]
$A6:C715 6B          RTL
}


;;; $C716:  ;;;
{
$A6:C716 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C719 AF 40 20 7E LDA $7E2040[$7E:2040]
$A6:C71D 9D 7A 0F    STA $0F7A,x[$7E:10FA]
$A6:C720 AF 42 20 7E LDA $7E2042[$7E:2042]
$A6:C724 9D 7E 0F    STA $0F7E,x[$7E:10FE]
$A6:C727 A9 47 CA    LDA #$CA47
$A6:C72A 9D 92 0F    STA $0F92,x[$7E:1112]
$A6:C72D 6B          RTL
}


;;; $C72E:  ;;;
{
$A6:C72E AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C731 AF 54 20 7E LDA $7E2054[$7E:2054]
$A6:C735 9D 7A 0F    STA $0F7A,x[$7E:10BA]
$A6:C738 AF 56 20 7E LDA $7E2056[$7E:2056]
$A6:C73C 9D 7E 0F    STA $0F7E,x[$7E:10BE]
$A6:C73F A9 4D CA    LDA #$CA4D
$A6:C742 9D 92 0F    STA $0F92,x[$7E:10D2]
$A6:C745 6B          RTL
}


;;; $C746:  ;;;
{
$A6:C746 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C749 AF 68 20 7E LDA $7E2068[$7E:2068]
$A6:C74D 9D 7A 0F    STA $0F7A,x[$7E:107A]
$A6:C750 AF 6A 20 7E LDA $7E206A[$7E:206A]
$A6:C754 9D 7E 0F    STA $0F7E,x[$7E:107E]
$A6:C757 A9 4D CA    LDA #$CA4D
$A6:C75A 9D 92 0F    STA $0F92,x[$7E:1092]
$A6:C75D 6B          RTL
}


;;; $C75E:  ;;;
{
$A6:C75E AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C761 AF 7C 20 7E LDA $7E207C[$7E:207C]
$A6:C765 9D 7A 0F    STA $0F7A,x[$7E:103A]
$A6:C768 AF 7E 20 7E LDA $7E207E[$7E:207E]
$A6:C76C 9D 7E 0F    STA $0F7E,x[$7E:103E]
$A6:C76F A9 53 CA    LDA #$CA53
$A6:C772 9D 92 0F    STA $0F92,x[$7E:1052]
$A6:C775 6B          RTL
}


;;; $C776:  ;;;
{
$A6:C776 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C779 AF 90 20 7E LDA $7E2090[$7E:2090]
$A6:C77D 9D 7A 0F    STA $0F7A,x[$7E:0FFA]
$A6:C780 AF 92 20 7E LDA $7E2092[$7E:2092]
$A6:C784 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A6:C787 A9 53 CA    LDA #$CA53
$A6:C78A 9D 92 0F    STA $0F92,x[$7E:1012]
$A6:C78D 6B          RTL
}


;;; $C78E:  ;;;
{
$A6:C78E AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C791 AF A4 20 7E LDA $7E20A4[$7E:20A4]
$A6:C795 9D 7A 0F    STA $0F7A,x[$7E:0FBA]
$A6:C798 AF A6 20 7E LDA $7E20A6[$7E:20A6]
$A6:C79C 9D 7E 0F    STA $0F7E,x[$7E:0FBE]
$A6:C79F AF A2 20 7E LDA $7E20A2[$7E:20A2]
$A6:C7A3 18          CLC
$A6:C7A4 6F 8E 20 7E ADC $7E208E[$7E:208E]
$A6:C7A8 18          CLC
$A6:C7A9 69 08 00    ADC #$0008
$A6:C7AC 29 F0 00    AND #$00F0
$A6:C7AF 4A          LSR A
$A6:C7B0 4A          LSR A
$A6:C7B1 4A          LSR A
$A6:C7B2 A8          TAY
$A6:C7B3 B9 BA C7    LDA $C7BA,y[$A6:C7BC]
$A6:C7B6 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A6:C7B9 6B          RTL

$A6:C7BA             dw CA95, CA9B, CAA1, CAA7, CAAD, CAB3, CAB9, CABF, CAC5, CACB, CAD1, CAD7, CADD, CAE3, CAE9, CAEF
}


;;; $C7DA:  ;;;
{
$A6:C7DA A0 00 00    LDY #$0000
$A6:C7DD AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:C7E1 F0 03       BEQ $03    [$C7E6]
$A6:C7E3 A0 02 00    LDY #$0002

$A6:C7E6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C7E9 B9 04 C8    LDA $C804,y[$A6:C806]
$A6:C7EC 18          CLC
$A6:C7ED 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:C7F0 9D 7A 0F    STA $0F7A,x[$7E:117A]
$A6:C7F3 A9 00 00    LDA #$0000
$A6:C7F6 18          CLC
$A6:C7F7 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:C7FA 9D 7E 0F    STA $0F7E,x[$7E:117E]
$A6:C7FD B9 08 C8    LDA $C808,y[$A6:C80A]
$A6:C800 9D 92 0F    STA $0F92,x[$7E:1192]
$A6:C803 6B          RTL

$A6:C804             dw 0000, 0000
$A6:C808             dw CA59, CA5F
}


;;; $C80C:  ;;;
{
$A6:C80C A0 00 00    LDY #$0000
$A6:C80F AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:C813 F0 03       BEQ $03    [$C818]
$A6:C815 A0 02 00    LDY #$0002

$A6:C818 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C81B B9 36 C8    LDA $C836,y[$A6:C838]
$A6:C81E 18          CLC
$A6:C81F 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:C822 9D 7A 0F    STA $0F7A,x[$7E:11BA]
$A6:C825 A9 16 00    LDA #$0016
$A6:C828 18          CLC
$A6:C829 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:C82C 9D 7E 0F    STA $0F7E,x[$7E:11BE]
$A6:C82F B9 3A C8    LDA $C83A,y[$A6:C83C]
$A6:C832 9D 92 0F    STA $0F92,x[$7E:11D2]
$A6:C835 6B          RTL

$A6:C836             dw 000F, FFF1
$A6:C83A             dw CA65, CA6B
}


;;; $C83E:  ;;;
{
$A6:C83E A0 00 00    LDY #$0000
$A6:C841 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:C845 F0 03       BEQ $03    [$C84A]
$A6:C847 A0 02 00    LDY #$0002

$A6:C84A AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C84D B9 68 C8    LDA $C868,y[$A6:C86A]
$A6:C850 18          CLC
$A6:C851 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:C854 9D 7A 0F    STA $0F7A,x[$7E:123A]
$A6:C857 A9 E8 FF    LDA #$FFE8
$A6:C85A 18          CLC
$A6:C85B 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:C85E 9D 7E 0F    STA $0F7E,x[$7E:123E]
$A6:C861 B9 6C C8    LDA $C86C,y[$A6:C86E]
$A6:C864 9D 92 0F    STA $0F92,x[$7E:1252]
$A6:C867 6B          RTL

$A6:C868             dw FFFD, 0003
$A6:C86C             dw CA71, CA77
}


;;; $C870:  ;;;
{
$A6:C870 A0 00 00    LDY #$0000
$A6:C873 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:C877 F0 03       BEQ $03    [$C87C]
$A6:C879 A0 02 00    LDY #$0002

$A6:C87C AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C87F B9 9A C8    LDA $C89A,y[$A6:C89C]
$A6:C882 18          CLC
$A6:C883 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:C886 9D 7A 0F    STA $0F7A,x[$7E:11FA]
$A6:C889 A9 00 00    LDA #$0000
$A6:C88C 18          CLC
$A6:C88D 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:C890 9D 7E 0F    STA $0F7E,x[$7E:11FE]
$A6:C893 B9 9E C8    LDA $C89E,y[$A6:C8A0]
$A6:C896 9D 92 0F    STA $0F92,x[$7E:1212]
$A6:C899 6B          RTL

$A6:C89A             dw 0010, FFF0
$A6:C89E             dw CA7D, CA83
}


;;; $C8A2:  ;;;
{
$A6:C8A2 A0 00 00    LDY #$0000
$A6:C8A5 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:C8A9 F0 03       BEQ $03    [$C8AE]
$A6:C8AB A0 02 00    LDY #$0002

$A6:C8AE AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C8B1 B9 CC C8    LDA $C8CC,y[$A6:C8CE]
$A6:C8B4 18          CLC
$A6:C8B5 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:C8B8 9D 7A 0F    STA $0F7A,x[$7E:127A]
$A6:C8BB A9 07 00    LDA #$0007
$A6:C8BE 18          CLC
$A6:C8BF 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:C8C2 9D 7E 0F    STA $0F7E,x[$7E:127E]
$A6:C8C5 B9 D0 C8    LDA $C8D0,y[$A6:C8D2]
$A6:C8C8 9D 92 0F    STA $0F92,x[$7E:1292]
$A6:C8CB 6B          RTL

$A6:C8CC             dw 0008, FFF8
$A6:C8D0             dw CA89, CA8F
}


;;; $C8D4: Main AI - enemy $E1BF (Ridley's explosion) ;;;
{
$A6:C8D4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:C8D7 20 13 C9    JSR $C913  [$A6:C913]
$A6:C8DA BD AA 0F    LDA $0FAA,x[$7E:0FEA]
$A6:C8DD 10 04       BPL $04    [$C8E3]
$A6:C8DF 49 FF FF    EOR #$FFFF
$A6:C8E2 1A          INC A

$A6:C8E3 18          CLC
$A6:C8E4 69 FC FF    ADC #$FFFC
$A6:C8E7 10 03       BPL $03    [$C8EC]
$A6:C8E9 A9 00 00    LDA #$0000

$A6:C8EC 3C AA 0F    BIT $0FAA,x[$7E:0FEA]
$A6:C8EF 10 04       BPL $04    [$C8F5]
$A6:C8F1 49 FF FF    EOR #$FFFF
$A6:C8F4 1A          INC A

$A6:C8F5 9D AA 0F    STA $0FAA,x[$7E:0FEA]
$A6:C8F8 BD AC 0F    LDA $0FAC,x[$7E:0FEC]
$A6:C8FB 18          CLC
$A6:C8FC 69 04 00    ADC #$0004
$A6:C8FF 9D AC 0F    STA $0FAC,x[$7E:0FEC]
$A6:C902 22 EF C3 A9 JSL $A9C3EF[$A9:C3EF]
$A6:C906 DE B2 0F    DEC $0FB2,x[$7E:0FF2]
$A6:C909 10 07       BPL $07    [$C912]
$A6:C90B A9 00 00    LDA #$0000             ; A = 0 (small explosion)
$A6:C90E 5C AF A3 A0 JML $A0A3AF[$A0:A3AF]  ; Go to enemy death

$A6:C912 6B          RTL
}


;;; $C913:  ;;;
{
$A6:C913 BD A4 0F    LDA $0FA4,x[$7E:0FE4]
$A6:C916 29 01 00    AND #$0001
$A6:C919 9D A4 0F    STA $0FA4,x[$7E:0FE4]
$A6:C91C F0 0A       BEQ $0A    [$C928]
$A6:C91E BD 86 0F    LDA $0F86,x[$7E:0FC6]
$A6:C921 09 00 01    ORA #$0100
$A6:C924 9D 86 0F    STA $0F86,x[$7E:0FC6]
$A6:C927 60          RTS

$A6:C928 BD 86 0F    LDA $0F86,x[$7E:0FC6]
$A6:C92B 29 FF FE    AND #$FEFF
$A6:C92E 9D 86 0F    STA $0F86,x[$7E:0FC6]
$A6:C931 60          RTS
}


;;; $C932: Spawn Ridley's explosion enemies ;;;
{
$A6:C932 A2 E7 C9    LDX #$C9E7             ;\
$A6:C935 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 0
$A6:C939 A2 D7 C9    LDX #$C9D7             ;\
$A6:C93C 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 1
$A6:C940 A2 C7 C9    LDX #$C9C7             ;\
$A6:C943 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 2
$A6:C947 A2 B7 C9    LDX #$C9B7             ;\
$A6:C94A 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 3
$A6:C94E A2 A7 C9    LDX #$C9A7             ;\
$A6:C951 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 4
$A6:C955 A2 97 C9    LDX #$C997             ;\
$A6:C958 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 5
$A6:C95C A2 87 C9    LDX #$C987             ;\
$A6:C95F 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 6
$A6:C963 A2 F7 C9    LDX #$C9F7             ;\
$A6:C966 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 7
$A6:C96A A2 07 CA    LDX #$CA07             ;\
$A6:C96D 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 8
$A6:C971 A2 27 CA    LDX #$CA27             ;\
$A6:C974 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion 9
$A6:C978 A2 17 CA    LDX #$CA17             ;\
$A6:C97B 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion Ah
$A6:C97F A2 37 CA    LDX #$CA37             ;\
$A6:C982 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Ridley's explosion Bh
$A6:C986 60          RTS

;                        ______________________________________ Enemy ID
;                       |     _________________________________ X position
;                       |    |     ____________________________ Y position
;                       |    |    |     _______________________ Initialisation parameter
;                       |    |    |    |     __________________ Properties
;                       |    |    |    |    |     _____________ Extra properties
;                       |    |    |    |    |    |     ________ Parameter 1
;                       |    |    |    |    |    |    |     ___ Parameter 2
;                       |    |    |    |    |    |    |    |
$A6:C987             dw E1BF,0000,0000,0000,2C00,0000,0000,0000 ; Ridley's explosion
$A6:C997             dw E1BF,0000,0000,0000,2C00,0000,0002,0000 ; Ridley's explosion
$A6:C9A7             dw E1BF,0000,0000,0000,2C00,0000,0004,0000 ; Ridley's explosion
$A6:C9B7             dw E1BF,0000,0000,0000,2C00,0000,0006,0000 ; Ridley's explosion
$A6:C9C7             dw E1BF,0000,0000,0000,2C00,0000,0008,0000 ; Ridley's explosion
$A6:C9D7             dw E1BF,0000,0000,0000,2C00,0000,000A,0000 ; Ridley's explosion
$A6:C9E7             dw E1BF,0000,0000,0000,2C00,0000,000C,0000 ; Ridley's explosion
$A6:C9F7             dw E1BF,0000,0000,0000,2C00,0000,000E,0000 ; Ridley's explosion
$A6:CA07             dw E1BF,0000,0000,0000,2C00,0000,0010,0000 ; Ridley's explosion
$A6:CA17             dw E1BF,0000,0000,0000,2C00,0000,0012,0000 ; Ridley's explosion
$A6:CA27             dw E1BF,0000,0000,0000,2C00,0000,0014,0000 ; Ridley's explosion
$A6:CA37             dw E1BF,0000,0000,0000,2C00,0000,0016,0000 ; Ridley's explosion
}


;;; $CA47..CAF4: Instruction lists ;;;
{
;;; $CA47: Instruction list -  ;;;
{
$A6:CA47             dx 0001,DC90,
                        812F        ; Sleep
}


;;; $CA4D: Instruction list -  ;;;
{
$A6:CA4D             dx 0001,DC97,
                        812F        ; Sleep
}


;;; $CA53: Instruction list -  ;;;
{
$A6:CA53             dx 0001,DC9E,
                        812F        ; Sleep
}


;;; $CA59: Instruction list -  ;;;
{
$A6:CA59             dx 0001,DD4A,
                        812F        ; Sleep
}


;;; $CA5F: Instruction list -  ;;;
{
$A6:CA5F             dx 0001,DDE2,
                        812F        ; Sleep
}


;;; $CA65: Instruction list -  ;;;
{
$A6:CA65             dx 0001,ED29,
                        812F        ; Sleep
}


;;; $CA6B: Instruction list -  ;;;
{
$A6:CA6B             dx 0001,EF25,
                        812F        ; Sleep
}


;;; $CA71: Instruction list -  ;;;
{
$A6:CA71             dx 0001,ECDC,
                        812F        ; Sleep
}


;;; $CA77: Instruction list -  ;;;
{
$A6:CA77             dx 0001,EED8,
                        812F        ; Sleep
}


;;; $CA7D: Instruction list -  ;;;
{
$A6:CA7D             dx 0001,ED95,
                        812F        ; Sleep
}


;;; $CA83: Instruction list -  ;;;
{
$A6:CA83             dx 0001,EF91,
                        812F        ; Sleep
}


;;; $CA89: Instruction list -  ;;;
{
$A6:CA89             dx 0001,ED8E,
                        812F        ; Sleep
}


;;; $CA8F: Instruction list -  ;;;
{
$A6:CA8F             dx 0001,EF8A,
                        812F        ; Sleep
}


;;; $CA95: Instruction list -  ;;;
{
$A6:CA95             dx 0001,DD2E,
                        812F        ; Sleep
}


;;; $CA9B: Instruction list -  ;;;
{
$A6:CA9B             dx 0001,DD27,
                        812F        ; Sleep
}


;;; $CAA1: Instruction list -  ;;;
{
$A6:CAA1             dx 0001,DD20,
                        812F        ; Sleep
}


;;; $CAA7: Instruction list -  ;;;
{
$A6:CAA7             dx 0001,DD19,
                        812F        ; Sleep
}


;;; $CAAD: Instruction list -  ;;;
{
$A6:CAAD             dx 0001,DD12,
                        812F        ; Sleep
}


;;; $CAB3: Instruction list -  ;;;
{
$A6:CAB3             dx 0001,DD0B,
                        812F        ; Sleep
}


;;; $CAB9: Instruction list -  ;;;
{
$A6:CAB9             dx 0001,DD04,
                        812F        ; Sleep
}


;;; $CABF: Instruction list -  ;;;
{
$A6:CABF             dx 0001,DCFD,
                        812F        ; Sleep
}


;;; $CAC5: Instruction list -  ;;;
{
$A6:CAC5             dx 0001,DCF6,
                        812F        ; Sleep
}


;;; $CACB: Instruction list -  ;;;
{
$A6:CACB             dx 0001,DCEF,
                        812F        ; Sleep
}


;;; $CAD1: Instruction list -  ;;;
{
$A6:CAD1             dx 0001,DCE8,
                        812F        ; Sleep
}


;;; $CAD7: Instruction list -  ;;;
{
$A6:CAD7             dx 0001,DCE1,
                        812F        ; Sleep
}


;;; $CADD: Instruction list -  ;;;
{
$A6:CADD             dx 0001,DCDA,
                        812F        ; Sleep
}


;;; $CAE3: Instruction list -  ;;;
{
$A6:CAE3             dx 0001,DD43,
                        812F        ; Sleep
}


;;; $CAE9: Instruction list -  ;;;
{
$A6:CAE9             dx 0001,DD3C,
                        812F        ; Sleep
}


;;; $CAEF: Instruction list -  ;;;
{
$A6:CAEF             dx 0001,DD35,
                        812F        ; Sleep
}
}


;;; $CAF5:  ;;;
{
; Run Tail AI: Sound, control AI, X/Y positions, tail extension, hurt Samus
$A6:CAF5 20 AA D2    JSR $D2AA  [$A6:D2AA]
$A6:CAF8 AF 00 20 7E LDA $7E2000[$7E:2000]
$A6:CAFC 0A          ASL A
$A6:CAFD AA          TAX
$A6:CAFE FC 21 CB    JSR ($CB21,x)[$A6:CB20]
$A6:CB01 8B          PHB
$A6:CB02 F4 7E 7E    PEA $7E7E
$A6:CB05 AB          PLB
$A6:CB06 AB          PLB
$A6:CB07 20 BA CE    JSR $CEBA  [$A6:CEBA]
$A6:CB0A 20 5A CF    JSR $CF5A  [$A6:CF5A]
$A6:CB0D AB          PLB
$A6:CB0E AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:CB11 29 00 04    AND #$0400
$A6:CB14 0D A8 18    ORA $18A8  [$7E:18A8]
$A6:CB17 0F 36 78 7E ORA $7E7836[$7E:7836]
$A6:CB1B D0 03       BNE $03    [$CB20]
$A6:CB1D 4C D9 DF    JMP $DFD9  [$A6:DFD9]

$A6:CB20 60          RTS

$A6:CB21             dw CB20, CBC0, CB33, CB45, CBC7, CBCE, CB4E, CB60, CBD5
}


;;; $CB33:  ;;;
{
$A6:CB33 A9 08 00    LDA #$0008
$A6:CB36 8F 14 20 7E STA $7E2014[$7E:2014]
$A6:CB3A 20 72 CB    JSR $CB72  [$A6:CB72]
$A6:CB3D A9 03 00    LDA #$0003
$A6:CB40 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:CB44 60          RTS
}


;;; $CB45:  ;;;
{
$A6:CB45 A9 08 00    LDA #$0008
$A6:CB48 8F 14 20 7E STA $7E2014[$7E:2014]
$A6:CB4C 80 24       BRA $24    [$CB72]
}


;;; $CB4E:  ;;;
{
$A6:CB4E A9 03 00    LDA #$0003
$A6:CB51 8F 14 20 7E STA $7E2014[$7E:2014]
$A6:CB55 20 72 CB    JSR $CB72  [$A6:CB72]
$A6:CB58 A9 06 00    LDA #$0006
$A6:CB5B 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:CB5F 60          RTS
}


;;; $CB60:  ;;;
{
$A6:CB60 A9 02 00    LDA #$0002
$A6:CB63 8F 14 20 7E STA $7E2014[$7E:2014]
$A6:CB67 20 72 CB    JSR $CB72  [$A6:CB72]
$A6:CB6A A9 07 00    LDA #$0007
$A6:CB6D 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:CB71 60          RTS
}


;;; $CB72:  ;;;
{
$A6:CB72 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:CB76 D0 10       BNE $10    [$CB88]
$A6:CB78 A9 00 40    LDA #$4000
$A6:CB7B 8F 1C 20 7E STA $7E201C[$7E:201C]
$A6:CB7F A9 FF FF    LDA #$FFFF
$A6:CB82 8F 1A 20 7E STA $7E201A[$7E:201A]
$A6:CB86 80 0E       BRA $0E    [$CB96]

$A6:CB88 A9 00 40    LDA #$4000
$A6:CB8B 8F 1A 20 7E STA $7E201A[$7E:201A]
$A6:CB8F A9 FF FF    LDA #$FFFF
$A6:CB92 8F 1C 20 7E STA $7E201C[$7E:201C]

$A6:CB96 20 C7 CB    JSR $CBC7  [$A6:CBC7]
$A6:CB99 AF 20 20 7E LDA $7E2020[$7E:2020]
$A6:CB9D 0F 34 20 7E ORA $7E2034[$7E:2034]
$A6:CBA1 0F 48 20 7E ORA $7E2048[$7E:2048]
$A6:CBA5 0F 5C 20 7E ORA $7E205C[$7E:205C]
$A6:CBA9 0F 70 20 7E ORA $7E2070[$7E:2070]
$A6:CBAD 0F 84 20 7E ORA $7E2084[$7E:2084]
$A6:CBB1 0F 98 20 7E ORA $7E2098[$7E:2098]
$A6:CBB5 F0 01       BEQ $01    [$CBB8]
$A6:CBB7 60          RTS

$A6:CBB8 A9 04 00    LDA #$0004
$A6:CBBB 8F 00 20 7E STA $7E2000[$7E:2000]
$A6:CBBF 60          RTS
}


;;; $CBC0:  ;;;
{
$A6:CBC0 A9 39 CC    LDA #$CC39
$A6:CBC3 85 12       STA $12    [$7E:0012]
$A6:CBC5 80 15       BRA $15    [$CBDC]
}


;;; $CBC7:  ;;;
{
$A6:CBC7 A9 24 CD    LDA #$CD24
$A6:CBCA 85 12       STA $12    [$7E:0012]
$A6:CBCC 80 0E       BRA $0E    [$CBDC]
}


;;; $CBCE:  ;;;
{
$A6:CBCE A9 AA CD    LDA #$CDAA
$A6:CBD1 85 12       STA $12    [$7E:0012]
$A6:CBD3 80 07       BRA $07    [$CBDC]
}


;;; $CBD5:  ;;;
{
$A6:CBD5 A9 BD CC    LDA #$CCBD
$A6:CBD8 85 12       STA $12    [$7E:0012]
$A6:CBDA 80 00       BRA $00    [$CBDC]
}


;;; $CBDC:  ;;;
{
$A6:CBDC 8B          PHB
$A6:CBDD F4 7E 7E    PEA $7E7E
$A6:CBE0 AB          PLB
$A6:CBE1 AB          PLB
$A6:CBE2 F4 E7 CB    PEA $CBE7
$A6:CBE5 6C 12 00    JMP ($0012)[$A6:CC39]

$A6:CBE8 A9 07 00    LDA #$0007
$A6:CBEB A2 00 00    LDX #$0000

$A6:CBEE 48          PHA
$A6:CBEF 20 9F D0    JSR $D09F  [$A6:D09F]
$A6:CBF2 8A          TXA
$A6:CBF3 18          CLC
$A6:CBF4 69 14 00    ADC #$0014
$A6:CBF7 AA          TAX
$A6:CBF8 68          PLA
$A6:CBF9 3A          DEC A
$A6:CBFA D0 F2       BNE $F2    [$CBEE]
$A6:CBFC AB          PLB
$A6:CBFD 60          RTS
}


;;; $CBFE:  ;;;
{
; Set min and max tail angles based on direction
$A6:CBFE AD 20 78    LDA $7820  [$7E:7820]
$A6:CC01 0A          ASL A
$A6:CC02 AA          TAX
$A6:CC03 BF 12 CC A6 LDA $A6CC12,x[$A6:CC12]
$A6:CC07 8D 16 20    STA $2016  [$7E:2016]
$A6:CC0A BF 18 CC A6 LDA $A6CC18,x[$A6:CC18]
$A6:CC0E 8D 18 20    STA $2018  [$7E:2018]
$A6:CC11 60          RTS

$A6:CC12             dw 3FF0, 3FF0, 3FC0
$A6:CC18             dw 4040, 4040, 4010
}


;;; $CC1E:  ;;;
{
; SEC if all tail parts are rotating, else CLC
$A6:CC1E AD 20 20    LDA $2020  [$7E:2020]
$A6:CC21 2D 34 20    AND $2034  [$7E:2034]
$A6:CC24 2D 48 20    AND $2048  [$7E:2048]
$A6:CC27 2D 5C 20    AND $205C  [$7E:205C]
$A6:CC2A 2D 70 20    AND $2070  [$7E:2070]
$A6:CC2D 2D 84 20    AND $2084  [$7E:2084]
$A6:CC30 2D 98 20    AND $2098  [$7E:2098]
$A6:CC33 F0 02       BEQ $02    [$CC37]
$A6:CC35 38          SEC
$A6:CC36 60          RTS

$A6:CC37 18          CLC
$A6:CC38 60          RTS
}


;;; $CC39:  ;;;
{
; Fling tail at Samus
; Setup max angles (CBFE), then if tail is 'prepped' (all tail parts rotating, target angle not set yet, $2004 (trigger?) is set), target an angle
; Target angle is first projectile near tail tip, in a 8x8 tile square centered on tail tip, or Samus. Max rotational speed, 8
; If no tail parts are currently moving, start the first one moving
$A6:CC39 20 FE CB    JSR $CBFE  [$A6:CBFE]
$A6:CC3C 20 1E CC    JSR $CC1E  [$A6:CC1E]
$A6:CC3F 90 03       BCC $03    [$CC44]
$A6:CC41 20 7D CC    JSR $CC7D  [$A6:CC7D]

$A6:CC44 AD 20 20    LDA $2020  [$7E:2020]
$A6:CC47 0D 34 20    ORA $2034  [$7E:2034]
$A6:CC4A 0D 48 20    ORA $2048  [$7E:2048]
$A6:CC4D 0D 5C 20    ORA $205C  [$7E:205C]
$A6:CC50 0D 70 20    ORA $2070  [$7E:2070]
$A6:CC53 0D 84 20    ORA $2084  [$7E:2084]
$A6:CC56 0D 98 20    ORA $2098  [$7E:2098]
$A6:CC59 F0 01       BEQ $01    [$CC5C]
$A6:CC5B 60          RTS

$A6:CC5C A9 00 80    LDA #$8000
$A6:CC5F 8D 20 20    STA $2020  [$7E:2020]
$A6:CC62 A9 FF FF    LDA #$FFFF
$A6:CC65 8D 1A 20    STA $201A  [$7E:201A]
$A6:CC68 8D 1C 20    STA $201C  [$7E:201C]
$A6:CC6B A9 02 00    LDA #$0002
$A6:CC6E AC F6 0A    LDY $0AF6  [$7E:0AF6]
$A6:CC71 C0 70 00    CPY #$0070
$A6:CC74 B0 03       BCS $03    [$CC79]
$A6:CC76 A9 01 00    LDA #$0001

$A6:CC79 8D 14 20    STA $2014  [$7E:2014]
$A6:CC7C 60          RTS
}


;;; $CC7D:  ;;;
{
$A6:CC7D AD 04 20    LDA $2004  [$7E:2004]
$A6:CC80 F0 08       BEQ $08    [$CC8A]
$A6:CC82 AD 1C 20    LDA $201C  [$7E:201C]
$A6:CC85 2D 1A 20    AND $201A  [$7E:201A]
$A6:CC88 30 27       BMI $27    [$CCB1]

$A6:CC8A AD 02 20    LDA $2002  [$7E:2002]
$A6:CC8D F0 2A       BEQ $2A    [$CCB9]
$A6:CC8F AD E5 05    LDA $05E5  [$7E:05E5]
$A6:CC92 29 FF 00    AND #$00FF
$A6:CC95 C9 F0 00    CMP #$00F0
$A6:CC98 B0 17       BCS $17    [$CCB1]
$A6:CC9A AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:CC9D 38          SEC
$A6:CC9E ED 7A 0F    SBC $0F7A  [$7E:0F7A]
$A6:CCA1 10 04       BPL $04    [$CCA7]
$A6:CCA3 49 FF FF    EOR #$FFFF
$A6:CCA6 1A          INC A

$A6:CCA7 C9 80 00    CMP #$0080
$A6:CCAA B0 0D       BCS $0D    [$CCB9]
$A6:CCAC A9 00 00    LDA #$0000
$A6:CCAF 80 04       BRA $04    [$CCB5]

$A6:CCB1 AD 04 20    LDA $2004  [$7E:2004]
$A6:CCB4 3A          DEC A

$A6:CCB5 20 9D D1    JSR $D19D  [$A6:D19D]
$A6:CCB8 68          PLA

$A6:CCB9 9C 04 20    STZ $2004  [$7E:2004]
$A6:CCBC 60          RTS
}


;;; $CCBD:  ;;;
{
; Swing tail in circles
$A6:CCBD 20 FE CB    JSR $CBFE  [$A6:CBFE]
$A6:CCC0 20 1E CC    JSR $CC1E  [$A6:CC1E]
$A6:CCC3 90 03       BCC $03    [$CCC8]
$A6:CCC5 20 0C CD    JSR $CD0C  [$A6:CD0C]

$A6:CCC8 AF 20 20 7E LDA $7E2020[$7E:2020]
$A6:CCCC 0F 34 20 7E ORA $7E2034[$7E:2034]
$A6:CCD0 0F 48 20 7E ORA $7E2048[$7E:2048]
$A6:CCD4 0F 5C 20 7E ORA $7E205C[$7E:205C]
$A6:CCD8 0F 70 20 7E ORA $7E2070[$7E:2070]
$A6:CCDC 0F 84 20 7E ORA $7E2084[$7E:2084]
$A6:CCE0 0F 98 20 7E ORA $7E2098[$7E:2098]
$A6:CCE4 F0 01       BEQ $01    [$CCE7]
$A6:CCE6 60          RTS

$A6:CCE7 A9 00 80    LDA #$8000
$A6:CCEA 8F 20 20 7E STA $7E2020[$7E:2020]
$A6:CCEE A9 FF FF    LDA #$FFFF
$A6:CCF1 8F 1A 20 7E STA $7E201A[$7E:201A]
$A6:CCF5 8F 1C 20 7E STA $7E201C[$7E:201C]
$A6:CCF9 A9 02 00    LDA #$0002
$A6:CCFC AC F6 0A    LDY $0AF6  [$7E:0AF6]
$A6:CCFF C0 70 00    CPY #$0070
$A6:CD02 B0 03       BCS $03    [$CD07]
$A6:CD04 A9 01 00    LDA #$0001

$A6:CD07 8F 14 20 7E STA $7E2014[$7E:2014]
$A6:CD0B 60          RTS
}


;;; $CD0C:  ;;;
{
$A6:CD0C AD 04 20    LDA $2004  [$7E:2004]
$A6:CD0F F0 12       BEQ $12    [$CD23]
$A6:CD11 AD 1C 20    LDA $201C  [$7E:201C]
$A6:CD14 2D 1A 20    AND $201A  [$7E:201A]
$A6:CD17 10 0A       BPL $0A    [$CD23]
$A6:CD19 A9 01 00    LDA #$0001
$A6:CD1C 20 9D D1    JSR $D19D  [$A6:D19D]
$A6:CD1F 68          PLA
$A6:CD20 9C 04 20    STZ $2004  [$7E:2004]

$A6:CD23 60          RTS
}


;;; $CD24:  ;;;
{
; Tail bouncing
$A6:CD24 20 FE CB    JSR $CBFE  [$A6:CBFE]
$A6:CD27 20 1E CC    JSR $CC1E  [$A6:CC1E]
$A6:CD2A 90 33       BCC $33    [$CD5F]
$A6:CD2C AD E5 05    LDA $05E5  [$7E:05E5]
$A6:CD2F 29 FF 00    AND #$00FF
$A6:CD32 C9 F0 00    CMP #$00F0
$A6:CD35 B0 13       BCS $13    [$CD4A]
$A6:CD37 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:CD3A 38          SEC
$A6:CD3B EF 7A 0F 00 SBC $000F7A[$7E:0F7A]
$A6:CD3F 10 04       BPL $04    [$CD45]
$A6:CD41 49 FF FF    EOR #$FFFF
$A6:CD44 1A          INC A

$A6:CD45 C9 80 00    CMP #$0080
$A6:CD48 B0 15       BCS $15    [$CD5F]

$A6:CD4A AD 1C 20    LDA $201C  [$7E:201C]
$A6:CD4D 2D 1A 20    AND $201A  [$7E:201A]
$A6:CD50 10 0D       BPL $0D    [$CD5F]
$A6:CD52 A9 00 3F    LDA #$3F00
$A6:CD55 8D 1A 20    STA $201A  [$7E:201A]
$A6:CD58 A9 08 00    LDA #$0008
$A6:CD5B 8D 14 20    STA $2014  [$7E:2014]
$A6:CD5E 60          RTS

$A6:CD5F AD 20 20    LDA $2020  [$7E:2020]
$A6:CD62 0D 34 20    ORA $2034  [$7E:2034]
$A6:CD65 0D 48 20    ORA $2048  [$7E:2048]
$A6:CD68 0D 5C 20    ORA $205C  [$7E:205C]
$A6:CD6B 0D 70 20    ORA $2070  [$7E:2070]
$A6:CD6E 0D 84 20    ORA $2084  [$7E:2084]
$A6:CD71 0D 98 20    ORA $2098  [$7E:2098]
$A6:CD74 F0 01       BEQ $01    [$CD77]
$A6:CD76 60          RTS

$A6:CD77 2C AC 0F    BIT $0FAC  [$7E:0FAC]
$A6:CD7A 30 06       BMI $06    [$CD82]
$A6:CD7C A9 05 00    LDA #$0005
$A6:CD7F 8D 00 20    STA $2000  [$7E:2000]

$A6:CD82 A9 FF FF    LDA #$FFFF
$A6:CD85 8D 1A 20    STA $201A  [$7E:201A]
$A6:CD88 8D 1C 20    STA $201C  [$7E:201C]
$A6:CD8B AD 10 20    LDA $2010  [$7E:2010]
$A6:CD8E D0 04       BNE $04    [$CD94]

$A6:CD90 8D 14 20    STA $2014  [$7E:2014]
$A6:CD93 60          RTS

$A6:CD94 3A          DEC A
$A6:CD95 8D 10 20    STA $2010  [$7E:2010]
$A6:CD98 D0 F6       BNE $F6    [$CD90]
$A6:CD9A A9 00 80    LDA #$8000
$A6:CD9D 8D 20 20    STA $2020  [$7E:2020]
$A6:CDA0 20 65 CE    JSR $CE65  [$A6:CE65]
$A6:CDA3 A9 08 00    LDA #$0008
$A6:CDA6 8D 14 20    STA $2014  [$7E:2014]
$A6:CDA9 60          RTS
}


;;; $CDAA:  ;;;
{
; Extend tail. Happens only while tail bouncing, moving downwards, and no tail parts currently rotating
$A6:CDAA 20 FE CB    JSR $CBFE  [$A6:CBFE]
$A6:CDAD 20 1E CC    JSR $CC1E  [$A6:CC1E]
$A6:CDB0 90 33       BCC $33    [$CDE5]
$A6:CDB2 AD E5 05    LDA $05E5  [$7E:05E5]
$A6:CDB5 29 FF 00    AND #$00FF
$A6:CDB8 C9 F0 00    CMP #$00F0
$A6:CDBB B0 13       BCS $13    [$CDD0]
$A6:CDBD AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:CDC0 38          SEC
$A6:CDC1 EF 7A 0F 00 SBC $000F7A[$7E:0F7A]
$A6:CDC5 10 04       BPL $04    [$CDCB]
$A6:CDC7 49 FF FF    EOR #$FFFF
$A6:CDCA 1A          INC A

$A6:CDCB C9 80 00    CMP #$0080
$A6:CDCE B0 15       BCS $15    [$CDE5]

$A6:CDD0 AD 1C 20    LDA $201C  [$7E:201C]
$A6:CDD3 2D 1A 20    AND $201A  [$7E:201A]
$A6:CDD6 10 0D       BPL $0D    [$CDE5]
$A6:CDD8 A9 00 3F    LDA #$3F00
$A6:CDDB 8D 1A 20    STA $201A  [$7E:201A]
$A6:CDDE A9 08 00    LDA #$0008
$A6:CDE1 8D 14 20    STA $2014  [$7E:2014]
$A6:CDE4 60          RTS

$A6:CDE5 AD 20 20    LDA $2020  [$7E:2020]
$A6:CDE8 0D 34 20    ORA $2034  [$7E:2034]
$A6:CDEB 0D 48 20    ORA $2048  [$7E:2048]
$A6:CDEE 0D 5C 20    ORA $205C  [$7E:205C]
$A6:CDF1 0D 70 20    ORA $2070  [$7E:2070]
$A6:CDF4 0D 84 20    ORA $2084  [$7E:2084]
$A6:CDF7 0D 98 20    ORA $2098  [$7E:2098]
$A6:CDFA F0 01       BEQ $01    [$CDFD]
$A6:CDFC 60          RTS

$A6:CDFD 2C AC 0F    BIT $0FAC  [$7E:0FAC]
$A6:CE00 30 3C       BMI $3C    [$CE3E]
$A6:CE02 A9 06 00    LDA #$0006
$A6:CE05 8D 00 20    STA $2000  [$7E:2000]
$A6:CE08 A9 00 0A    LDA #$0A00
$A6:CE0B 8D 28 20    STA $2028  [$7E:2028]
$A6:CE0E 8D 3C 20    STA $203C  [$7E:203C]
$A6:CE11 8D 50 20    STA $2050  [$7E:2050]
$A6:CE14 8D 64 20    STA $2064  [$7E:2064]
$A6:CE17 8D 78 20    STA $2078  [$7E:2078]
$A6:CE1A 8D 8C 20    STA $208C  [$7E:208C]
$A6:CE1D 8D A0 20    STA $20A0  [$7E:20A0]
$A6:CE20 A9 00 40    LDA #$4000
$A6:CE23 8D 2A 20    STA $202A  [$7E:202A]
$A6:CE26 8D 3E 20    STA $203E  [$7E:203E]
$A6:CE29 8D 52 20    STA $2052  [$7E:2052]
$A6:CE2C 8D 66 20    STA $2066  [$7E:2066]
$A6:CE2F 8D 7A 20    STA $207A  [$7E:207A]
$A6:CE32 8D 8E 20    STA $208E  [$7E:208E]
$A6:CE35 8D A2 20    STA $20A2  [$7E:20A2]
$A6:CE38 A9 00 80    LDA #$8000
$A6:CE3B 8D 20 20    STA $2020  [$7E:2020]

$A6:CE3E A9 FF FF    LDA #$FFFF
$A6:CE41 8D 1A 20    STA $201A  [$7E:201A]
$A6:CE44 8D 1C 20    STA $201C  [$7E:201C]
$A6:CE47 AD 10 20    LDA $2010  [$7E:2010]
$A6:CE4A D0 03       BNE $03    [$CE4F]
$A6:CE4C 4C 61 CE    JMP $CE61  [$A6:CE61]

$A6:CE4F 3A          DEC A
$A6:CE50 8D 10 20    STA $2010  [$7E:2010]
$A6:CE53 D0 0C       BNE $0C    [$CE61]
$A6:CE55 A9 00 80    LDA #$8000
$A6:CE58 8D 20 20    STA $2020  [$7E:2020]
$A6:CE5B 20 65 CE    JSR $CE65  [$A6:CE65]
$A6:CE5E A9 08 00    LDA #$0008

$A6:CE61 8D 14 20    STA $2014  [$7E:2014]
$A6:CE64 60          RTS
}


;;; $CE65:  ;;;
{
; Set angles to 40XX, XX is previous angle (fifth part is actually first part's 40XX)
$A6:CE65 AD 2A 20    LDA $202A  [$7E:202A]
$A6:CE68 29 FF 00    AND #$00FF
$A6:CE6B 09 00 40    ORA #$4000
$A6:CE6E 8D 2A 20    STA $202A  [$7E:202A]
$A6:CE71 AD 3E 20    LDA $203E  [$7E:203E]
$A6:CE74 29 FF 00    AND #$00FF
$A6:CE77 09 00 40    ORA #$4000
$A6:CE7A 8D 3E 20    STA $203E  [$7E:203E]
$A6:CE7D AD 52 20    LDA $2052  [$7E:2052]
$A6:CE80 29 FF 00    AND #$00FF
$A6:CE83 09 00 40    ORA #$4000
$A6:CE86 8D 52 20    STA $2052  [$7E:2052]
$A6:CE89 AD 66 20    LDA $2066  [$7E:2066]
$A6:CE8C 29 FF 00    AND #$00FF
$A6:CE8F 09 00 40    ORA #$4000
$A6:CE92 8D 66 20    STA $2066  [$7E:2066]
$A6:CE95 AD 2A 20    LDA $202A  [$7E:202A]
$A6:CE98 29 FF 04    AND #$04FF
$A6:CE9B 09 00 40    ORA #$4000
$A6:CE9E 8D 7A 20    STA $207A  [$7E:207A]
$A6:CEA1 AD 8E 20    LDA $208E  [$7E:208E]
$A6:CEA4 29 FF 00    AND #$00FF
$A6:CEA7 09 00 40    ORA #$4000
$A6:CEAA 8D 8E 20    STA $208E  [$7E:208E]
$A6:CEAD AD A2 20    LDA $20A2  [$7E:20A2]
$A6:CEB0 29 FF 00    AND #$00FF
$A6:CEB3 09 00 40    ORA #$4000
$A6:CEB6 8D A2 20    STA $20A2  [$7E:20A2]
$A6:CEB9 60          RTS
}


;;; $CEBA:  ;;;
{
; Update tail positions
$A6:CEBA AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:CEBD 18          CLC
$A6:CEBE 6D 32 20    ADC $2032  [$7E:2032]
$A6:CEC1 18          CLC
$A6:CEC2 69 10 00    ADC #$0010
$A6:CEC5 8D 2E 20    STA $202E  [$7E:202E]
$A6:CEC8 18          CLC
$A6:CEC9 6D 46 20    ADC $2046  [$7E:2046]
$A6:CECC 8D 42 20    STA $2042  [$7E:2042]
$A6:CECF 18          CLC
$A6:CED0 6D 5A 20    ADC $205A  [$7E:205A]
$A6:CED3 8D 56 20    STA $2056  [$7E:2056]
$A6:CED6 18          CLC
$A6:CED7 6D 6E 20    ADC $206E  [$7E:206E]
$A6:CEDA 8D 6A 20    STA $206A  [$7E:206A]
$A6:CEDD 18          CLC
$A6:CEDE 6D 82 20    ADC $2082  [$7E:2082]
$A6:CEE1 8D 7E 20    STA $207E  [$7E:207E]
$A6:CEE4 18          CLC
$A6:CEE5 6D 96 20    ADC $2096  [$7E:2096]
$A6:CEE8 8D 92 20    STA $2092  [$7E:2092]
$A6:CEEB 18          CLC
$A6:CEEC 6D AA 20    ADC $20AA  [$7E:20AA]
$A6:CEEF 8D A6 20    STA $20A6  [$7E:20A6]
$A6:CEF2 AD 20 78    LDA $7820  [$7E:7820]
$A6:CEF5 3A          DEC A
$A6:CEF6 F0 0A       BEQ $0A    [$CF02]
$A6:CEF8 1A          INC A
$A6:CEF9 0A          ASL A
$A6:CEFA AA          TAX
$A6:CEFB BF 54 CF A6 LDA $A6CF54,x[$A6:CF54]
$A6:CEFF 6D 30 20    ADC $2030  [$7E:2030]

$A6:CF02 18          CLC
$A6:CF03 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:CF06 8D 2C 20    STA $202C  [$7E:202C]
$A6:CF09 AD 20 78    LDA $7820  [$7E:7820]
$A6:CF0C 3A          DEC A
$A6:CF0D D0 17       BNE $17    [$CF26]
$A6:CF0F AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:CF12 8D 40 20    STA $2040  [$7E:2040]
$A6:CF15 8D 54 20    STA $2054  [$7E:2054]
$A6:CF18 8D 68 20    STA $2068  [$7E:2068]
$A6:CF1B 8D 7C 20    STA $207C  [$7E:207C]
$A6:CF1E 8D 90 20    STA $2090  [$7E:2090]
$A6:CF21 8D A4 20    STA $20A4  [$7E:20A4]
$A6:CF24 80 2D       BRA $2D    [$CF53]

$A6:CF26 AD 2C 20    LDA $202C  [$7E:202C]
$A6:CF29 18          CLC
$A6:CF2A 6D 44 20    ADC $2044  [$7E:2044]
$A6:CF2D 8D 40 20    STA $2040  [$7E:2040]
$A6:CF30 18          CLC
$A6:CF31 6D 58 20    ADC $2058  [$7E:2058]
$A6:CF34 8D 54 20    STA $2054  [$7E:2054]
$A6:CF37 18          CLC
$A6:CF38 6D 6C 20    ADC $206C  [$7E:206C]
$A6:CF3B 8D 68 20    STA $2068  [$7E:2068]
$A6:CF3E 18          CLC
$A6:CF3F 6D 80 20    ADC $2080  [$7E:2080]
$A6:CF42 8D 7C 20    STA $207C  [$7E:207C]
$A6:CF45 18          CLC
$A6:CF46 6D 94 20    ADC $2094  [$7E:2094]
$A6:CF49 8D 90 20    STA $2090  [$7E:2090]
$A6:CF4C 18          CLC
$A6:CF4D 6D A8 20    ADC $20A8  [$7E:20A8]
$A6:CF50 8D A4 20    STA $20A4  [$7E:20A4]

$A6:CF53 60          RTS

$A6:CF54             dw 0020, 0000, FFE0
}


;;; $CF5A:  ;;;
{
; Tail extending
$A6:CF5A AD 3C 20    LDA $203C  [$7E:203C]
$A6:CF5D F0 1F       BEQ $1F    [$CF7E]
$A6:CF5F CD 3A 20    CMP $203A  [$7E:203A]
$A6:CF62 10 06       BPL $06    [$CF6A]
$A6:CF64 A9 00 00    LDA #$0000
$A6:CF67 8D 3C 20    STA $203C  [$7E:203C]

$A6:CF6A AD 3A 20    LDA $203A  [$7E:203A]
$A6:CF6D 18          CLC
$A6:CF6E 6D 12 20    ADC $2012  [$7E:2012]
$A6:CF71 C9 00 18    CMP #$1800
$A6:CF74 30 03       BMI $03    [$CF79]
$A6:CF76 A9 00 18    LDA #$1800

$A6:CF79 8D 3A 20    STA $203A  [$7E:203A]
$A6:CF7C 80 12       BRA $12    [$CF90]

$A6:CF7E A9 00 08    LDA #$0800
$A6:CF81 CD 3A 20    CMP $203A  [$7E:203A]
$A6:CF84 10 0A       BPL $0A    [$CF90]
$A6:CF86 AD 3A 20    LDA $203A  [$7E:203A]
$A6:CF89 38          SEC
$A6:CF8A E9 80 00    SBC #$0080
$A6:CF8D 8D 3A 20    STA $203A  [$7E:203A]

$A6:CF90 AD 50 20    LDA $2050  [$7E:2050]
$A6:CF93 F0 1F       BEQ $1F    [$CFB4]
$A6:CF95 CD 4E 20    CMP $204E  [$7E:204E]
$A6:CF98 10 06       BPL $06    [$CFA0]
$A6:CF9A A9 00 00    LDA #$0000
$A6:CF9D 8D 50 20    STA $2050  [$7E:2050]

$A6:CFA0 AD 4E 20    LDA $204E  [$7E:204E]
$A6:CFA3 18          CLC
$A6:CFA4 6D 12 20    ADC $2012  [$7E:2012]
$A6:CFA7 C9 00 18    CMP #$1800
$A6:CFAA 30 03       BMI $03    [$CFAF]
$A6:CFAC A9 00 18    LDA #$1800

$A6:CFAF 8D 4E 20    STA $204E  [$7E:204E]
$A6:CFB2 80 12       BRA $12    [$CFC6]

$A6:CFB4 A9 00 08    LDA #$0800
$A6:CFB7 CD 4E 20    CMP $204E  [$7E:204E]
$A6:CFBA 10 0A       BPL $0A    [$CFC6]
$A6:CFBC AD 4E 20    LDA $204E  [$7E:204E]
$A6:CFBF 38          SEC
$A6:CFC0 E9 80 00    SBC #$0080
$A6:CFC3 8D 4E 20    STA $204E  [$7E:204E]

$A6:CFC6 AD 64 20    LDA $2064  [$7E:2064]
$A6:CFC9 F0 1F       BEQ $1F    [$CFEA]
$A6:CFCB CD 62 20    CMP $2062  [$7E:2062]
$A6:CFCE 10 06       BPL $06    [$CFD6]
$A6:CFD0 A9 00 00    LDA #$0000
$A6:CFD3 8D 64 20    STA $2064  [$7E:2064]

$A6:CFD6 AD 62 20    LDA $2062  [$7E:2062]
$A6:CFD9 18          CLC
$A6:CFDA 6D 12 20    ADC $2012  [$7E:2012]
$A6:CFDD C9 00 16    CMP #$1600
$A6:CFE0 30 03       BMI $03    [$CFE5]
$A6:CFE2 A9 00 16    LDA #$1600

$A6:CFE5 8D 62 20    STA $2062  [$7E:2062]
$A6:CFE8 80 12       BRA $12    [$CFFC]

$A6:CFEA A9 00 08    LDA #$0800
$A6:CFED CD 62 20    CMP $2062  [$7E:2062]
$A6:CFF0 10 0A       BPL $0A    [$CFFC]
$A6:CFF2 AD 62 20    LDA $2062  [$7E:2062]
$A6:CFF5 38          SEC
$A6:CFF6 E9 80 00    SBC #$0080
$A6:CFF9 8D 62 20    STA $2062  [$7E:2062]

$A6:CFFC AD 78 20    LDA $2078  [$7E:2078]
$A6:CFFF F0 1F       BEQ $1F    [$D020]
$A6:D001 CD 76 20    CMP $2076  [$7E:2076]
$A6:D004 10 06       BPL $06    [$D00C]
$A6:D006 A9 00 00    LDA #$0000
$A6:D009 8D 78 20    STA $2078  [$7E:2078]

$A6:D00C AD 76 20    LDA $2076  [$7E:2076]
$A6:D00F 18          CLC
$A6:D010 6D 12 20    ADC $2012  [$7E:2012]
$A6:D013 C9 00 16    CMP #$1600
$A6:D016 30 03       BMI $03    [$D01B]
$A6:D018 A9 00 16    LDA #$1600

$A6:D01B 8D 76 20    STA $2076  [$7E:2076]
$A6:D01E 80 12       BRA $12    [$D032]

$A6:D020 A9 00 08    LDA #$0800
$A6:D023 CD 76 20    CMP $2076  [$7E:2076]
$A6:D026 10 0A       BPL $0A    [$D032]
$A6:D028 AD 76 20    LDA $2076  [$7E:2076]
$A6:D02B 38          SEC
$A6:D02C E9 80 00    SBC #$0080
$A6:D02F 8D 76 20    STA $2076  [$7E:2076]

$A6:D032 AD 8C 20    LDA $208C  [$7E:208C]
$A6:D035 F0 1F       BEQ $1F    [$D056]
$A6:D037 CD 8A 20    CMP $208A  [$7E:208A]
$A6:D03A 10 06       BPL $06    [$D042]
$A6:D03C A9 00 00    LDA #$0000
$A6:D03F 8D 8C 20    STA $208C  [$7E:208C]

$A6:D042 AD 8A 20    LDA $208A  [$7E:208A]
$A6:D045 18          CLC
$A6:D046 6D 12 20    ADC $2012  [$7E:2012]
$A6:D049 C9 00 12    CMP #$1200
$A6:D04C 30 03       BMI $03    [$D051]
$A6:D04E A9 00 12    LDA #$1200

$A6:D051 8D 8A 20    STA $208A  [$7E:208A]
$A6:D054 80 12       BRA $12    [$D068]

$A6:D056 A9 00 08    LDA #$0800
$A6:D059 CD 8A 20    CMP $208A  [$7E:208A]
$A6:D05C 10 0A       BPL $0A    [$D068]
$A6:D05E AD 8A 20    LDA $208A  [$7E:208A]
$A6:D061 38          SEC
$A6:D062 E9 80 00    SBC #$0080
$A6:D065 8D 8A 20    STA $208A  [$7E:208A]

$A6:D068 AD A0 20    LDA $20A0  [$7E:20A0]
$A6:D06B F0 1F       BEQ $1F    [$D08C]
$A6:D06D CD 9E 20    CMP $209E  [$7E:209E]
$A6:D070 10 06       BPL $06    [$D078]
$A6:D072 A9 00 00    LDA #$0000
$A6:D075 8D A0 20    STA $20A0  [$7E:20A0]

$A6:D078 AD 9E 20    LDA $209E  [$7E:209E]
$A6:D07B 18          CLC
$A6:D07C 6D 12 20    ADC $2012  [$7E:2012]
$A6:D07F C9 00 05    CMP #$0500
$A6:D082 30 03       BMI $03    [$D087]
$A6:D084 A9 00 05    LDA #$0500

$A6:D087 8D 9E 20    STA $209E  [$7E:209E]
$A6:D08A 80 12       BRA $12    [$D09E]

$A6:D08C A9 00 05    LDA #$0500
$A6:D08F CD 9E 20    CMP $209E  [$7E:209E]
$A6:D092 10 0A       BPL $0A    [$D09E]
$A6:D094 AD 9E 20    LDA $209E  [$7E:209E]
$A6:D097 38          SEC
$A6:D098 E9 80 00    SBC #$0080
$A6:D09B 8D 9E 20    STA $209E  [$7E:209E]

$A6:D09E 60          RTS
}


;;; $D09F:  ;;;
{
$A6:D09F BD 20 20    LDA $2020,x[$7E:2020]
$A6:D0A2 30 21       BMI $21    [$D0C5]
$A6:D0A4 BD 2A 20    LDA $202A,x[$7E:202A]
$A6:D0A7 4C 6D D1    JMP $D16D  [$A6:D16D]

$A6:D0AA 9E 20 20    STZ $2020,x[$7E:2020]
$A6:D0AD 9E 22 20    STZ $2022,x[$7E:2022]
$A6:D0B0 BD 24 20    LDA $2024,x[$7E:2024]
$A6:D0B3 49 00 80    EOR #$8000
$A6:D0B6 9D 24 20    STA $2024,x[$7E:2024]
$A6:D0B9 60          RTS

$A6:D0BA BD 22 20    LDA $2022,x[$7E:2022]
$A6:D0BD 18          CLC
$A6:D0BE 6D 14 20    ADC $2014  [$7E:2014]
$A6:D0C1 9D 22 20    STA $2022,x[$7E:2022]
$A6:D0C4 60          RTS

$A6:D0C5 BD 22 20    LDA $2022,x[$7E:2022]
$A6:D0C8 CD 1E 20    CMP $201E  [$7E:201E]
$A6:D0CB 90 ED       BCC $ED    [$D0BA]
$A6:D0CD C9 FF FF    CMP #$FFFF
$A6:D0D0 F0 12       BEQ $12    [$D0E4]
$A6:D0D2 A9 FF FF    LDA #$FFFF
$A6:D0D5 9D 22 20    STA $2022,x[$7E:2022]
$A6:D0D8 A9 00 80    LDA #$8000
$A6:D0DB 9D 34 20    STA $2034,x[$7E:2034]
$A6:D0DE BD 24 20    LDA $2024,x[$7E:2024]
$A6:D0E1 9D 38 20    STA $2038,x[$7E:2038]

$A6:D0E4 BD 24 20    LDA $2024,x[$7E:2024]
$A6:D0E7 30 3F       BMI $3F    [$D128]
$A6:D0E9 AD 1C 20    LDA $201C  [$7E:201C]
$A6:D0EC 30 23       BMI $23    [$D111]
$A6:D0EE A9 00 0C    LDA #$0C00
$A6:D0F1 9D 28 20    STA $2028,x[$7E:208C]
$A6:D0F4 BD 2A 20    LDA $202A,x[$7E:208E]
$A6:D0F7 18          CLC
$A6:D0F8 6D 14 20    ADC $2014  [$7E:2014]
$A6:D0FB CD 1C 20    CMP $201C  [$7E:201C]
$A6:D0FE 30 6A       BMI $6A    [$D16A]
$A6:D100 8A          TXA
$A6:D101 F0 05       BEQ $05    [$D108]
$A6:D103 BD 0C 20    LDA $200C,x[$7E:2070]
$A6:D106 D0 15       BNE $15    [$D11D]

$A6:D108 AD 1C 20    LDA $201C  [$7E:201C]
$A6:D10B 9D 2A 20    STA $202A,x[$7E:202A]
$A6:D10E 4C AA D0    JMP $D0AA  [$A6:D0AA]

$A6:D111 BD 2A 20    LDA $202A,x[$7E:202A]
$A6:D114 18          CLC
$A6:D115 6D 14 20    ADC $2014  [$7E:2014]
$A6:D118 CD 18 20    CMP $2018  [$7E:2018]
$A6:D11B 30 4D       BMI $4D    [$D16A]

$A6:D11D A9 00 80    LDA #$8000
$A6:D120 9D 24 20    STA $2024,x[$7E:2024]
$A6:D123 AD 18 20    LDA $2018  [$7E:2018]
$A6:D126 80 42       BRA $42    [$D16A]

$A6:D128 AD 1A 20    LDA $201A  [$7E:201A]
$A6:D12B 30 24       BMI $24    [$D151]
$A6:D12D A9 00 0C    LDA #$0C00
$A6:D130 9D 28 20    STA $2028,x[$7E:2064]
$A6:D133 BD 2A 20    LDA $202A,x[$7E:2066]
$A6:D136 38          SEC
$A6:D137 ED 14 20    SBC $2014  [$7E:2014]
$A6:D13A 3A          DEC A
$A6:D13B CD 1A 20    CMP $201A  [$7E:201A]
$A6:D13E 10 29       BPL $29    [$D169]
$A6:D140 8A          TXA
$A6:D141 F0 05       BEQ $05    [$D148]
$A6:D143 BD 0C 20    LDA $200C,x[$7E:2048]
$A6:D146 D0 16       BNE $16    [$D15E]

$A6:D148 AD 1A 20    LDA $201A  [$7E:201A]
$A6:D14B 9D 2A 20    STA $202A,x[$7E:202A]
$A6:D14E 4C AA D0    JMP $D0AA  [$A6:D0AA]

$A6:D151 BD 2A 20    LDA $202A,x[$7E:202A]
$A6:D154 38          SEC
$A6:D155 ED 14 20    SBC $2014  [$7E:2014]
$A6:D158 3A          DEC A
$A6:D159 CD 16 20    CMP $2016  [$7E:2016]
$A6:D15C 10 0B       BPL $0B    [$D169]

$A6:D15E A9 00 00    LDA #$0000
$A6:D161 9D 24 20    STA $2024,x[$7E:2024]
$A6:D164 AD 16 20    LDA $2016  [$7E:2016]
$A6:D167 80 01       BRA $01    [$D16A]

$A6:D169 1A          INC A

$A6:D16A 9D 2A 20    STA $202A,x[$7E:202A]

$A6:D16D 29 FF 00    AND #$00FF
$A6:D170 85 12       STA $12    [$7E:0012]
$A6:D172 8A          TXA
$A6:D173 F0 0B       BEQ $0B    [$D180]
$A6:D175 A5 12       LDA $12    [$7E:0012]
$A6:D177 18          CLC
$A6:D178 7D 16 20    ADC $2016,x[$7E:202A]
$A6:D17B 29 FF 00    AND #$00FF
$A6:D17E 85 12       STA $12    [$7E:0012]

$A6:D180 BD 26 20    LDA $2026,x[$7E:2026]
$A6:D183 EB          XBA
$A6:D184 29 FF 00    AND #$00FF
$A6:D187 22 60 C4 A9 JSL $A9C460[$A9:C460]
$A6:D18B 9D 30 20    STA $2030,x[$7E:2030]
$A6:D18E BD 26 20    LDA $2026,x[$7E:2026]
$A6:D191 EB          XBA
$A6:D192 29 FF 00    AND #$00FF
$A6:D195 22 65 C4 A9 JSL $A9C465[$A9:C465]
$A6:D199 9D 32 20    STA $2032,x[$7E:2032]
$A6:D19C 60          RTS
}


;;; $D19D:  ;;;
{
; Target an angle (towards a missile or Samus) for tail.
; Note: Actual angle is actually twice the angle chosen, since each tail segment doubles it
; Also, tail circles 2*A amount of times first
$A6:D19D 29 FF 00    AND #$00FF
$A6:D1A0 EB          XBA
$A6:D1A1 8D 0A 20    STA $200A  [$7E:200A]
$A6:D1A4 AD 20 78    LDA $7820  [$7E:7820]
$A6:D1A7 3A          DEC A
$A6:D1A8 F0 1B       BEQ $1B    [$D1C5]
$A6:D1AA AD 02 78    LDA $7802  [$7E:7802]
$A6:D1AD F0 16       BEQ $16    [$D1C5]
$A6:D1AF 20 42 D2    JSR $D242  [$A6:D242]
$A6:D1B2 90 12       BCC $12    [$D1C6]
$A6:D1B4 A5 12       LDA $12    [$7E:0012]
$A6:D1B6 ED 2C 20    SBC $202C  [$7E:202C]
$A6:D1B9 85 12       STA $12    [$7E:0012]
$A6:D1BB A5 14       LDA $14    [$7E:0014]
$A6:D1BD 38          SEC
$A6:D1BE ED 2E 20    SBC $202E  [$7E:202E]
$A6:D1C1 85 14       STA $14    [$7E:0014]
$A6:D1C3 80 17       BRA $17    [$D1DC]

$A6:D1C5 60          RTS

$A6:D1C6 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:D1C9 38          SEC
$A6:D1CA ED 2C 20    SBC $202C  [$7E:202C]
$A6:D1CD 85 12       STA $12    [$7E:0012]
$A6:D1CF AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A6:D1D2 18          CLC
$A6:D1D3 69 18 00    ADC #$0018
$A6:D1D6 38          SEC
$A6:D1D7 ED 2E 20    SBC $202E  [$7E:202E]
$A6:D1DA 85 14       STA $14    [$7E:0014]

$A6:D1DC 8B          PHB
$A6:D1DD 4B          PHK
$A6:D1DE AB          PLB
$A6:D1DF 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ; A = angle of ([$12], [$14]) offset
$A6:D1E3 AB          PLB
$A6:D1E4 38          SEC
$A6:D1E5 E9 80 00    SBC #$0080
$A6:D1E8 49 FF FF    EOR #$FFFF
$A6:D1EB 1A          INC A
$A6:D1EC 29 FF 00    AND #$00FF
$A6:D1EF 85 12       STA $12    [$7E:0012]
$A6:D1F1 AD 20 78    LDA $7820  [$7E:7820]
$A6:D1F4 D0 26       BNE $26    [$D21C]
$A6:D1F6 A5 12       LDA $12    [$7E:0012]
$A6:D1F8 C9 18 00    CMP #$0018
$A6:D1FB 90 08       BCC $08    [$D205]
$A6:D1FD C9 E8 00    CMP #$00E8
$A6:D200 B0 03       BCS $03    [$D205]
$A6:D202 A9 E8 00    LDA #$00E8

$A6:D205 18          CLC
$A6:D206 69 00 3F    ADC #$3F00
$A6:D209 38          SEC
$A6:D20A ED 0A 20    SBC $200A  [$7E:200A]
$A6:D20D CD 2A 20    CMP $202A  [$7E:202A]
$A6:D210 B0 09       BCS $09    [$D21B]
$A6:D212 8D 1A 20    STA $201A  [$7E:201A]
$A6:D215 A9 08 00    LDA #$0008
$A6:D218 8D 14 20    STA $2014  [$7E:2014]

$A6:D21B 60          RTS

$A6:D21C A5 12       LDA $12    [$7E:0012]
$A6:D21E C9 18 00    CMP #$0018
$A6:D221 90 08       BCC $08    [$D22B]
$A6:D223 C9 E8 00    CMP #$00E8
$A6:D226 B0 03       BCS $03    [$D22B]
$A6:D228 A9 18 00    LDA #$0018

$A6:D22B 18          CLC
$A6:D22C 69 00 40    ADC #$4000
$A6:D22F 18          CLC
$A6:D230 6D 0A 20    ADC $200A  [$7E:200A]
$A6:D233 CD 2A 20    CMP $202A  [$7E:202A]
$A6:D236 90 09       BCC $09    [$D241]
$A6:D238 8D 1C 20    STA $201C  [$7E:201C]
$A6:D23B A9 08 00    LDA #$0008
$A6:D23E 8D 14 20    STA $2014  [$7E:2014]

$A6:D241 60          RTS
}


;;; $D242:  ;;;
{
; Target a missile/super missile if available
$A6:D242 AD A4 20    LDA $20A4  [$7E:20A4]
$A6:D245 85 12       STA $12    [$7E:0012]
$A6:D247 AD A6 20    LDA $20A6  [$7E:20A6]
$A6:D24A 85 14       STA $14    [$7E:0014]
$A6:D24C A9 40 00    LDA #$0040
$A6:D24F 85 16       STA $16    [$7E:0016]
$A6:D251 85 18       STA $18    [$7E:0018]
$A6:D253 AD CE 0C    LDA $0CCE  [$7E:0CCE]
$A6:D256 D0 02       BNE $02    [$D25A]
$A6:D258 18          CLC
$A6:D259 60          RTS

$A6:D25A A0 00 00    LDY #$0000

$A6:D25D B9 19 0C    LDA $0C19,y[$7E:0C19]
$A6:D260 29 0F 00    AND #$000F
$A6:D263 3A          DEC A
$A6:D264 F0 03       BEQ $03    [$D269]
$A6:D266 3A          DEC A
$A6:D267 D0 2C       BNE $2C    [$D295]

$A6:D269 B9 64 0B    LDA $0B64,y[$7E:0B66]
$A6:D26C 38          SEC
$A6:D26D E5 12       SBC $12    [$7E:0012]
$A6:D26F 10 04       BPL $04    [$D275]
$A6:D271 49 FF FF    EOR #$FFFF
$A6:D274 1A          INC A

$A6:D275 38          SEC
$A6:D276 F9 B4 0B    SBC $0BB4,y[$7E:0BB6]
$A6:D279 90 04       BCC $04    [$D27F]
$A6:D27B C5 16       CMP $16    [$7E:0016]
$A6:D27D B0 16       BCS $16    [$D295]
$A6:D27F B9 78 0B    LDA $0B78,y
$A6:D282 38          SEC
$A6:D283 E5 14       SBC $14    [$7E:0014]
$A6:D285 10 04       BPL $04    [$D28B]
$A6:D287 49 FF FF    EOR #$FFFF
$A6:D28A 1A          INC A

$A6:D28B 38          SEC
$A6:D28C F9 C8 0B    SBC $0BC8,y
$A6:D28F 90 0D       BCC $0D    [$D29E]
$A6:D291 C5 18       CMP $18    [$7E:0018]
$A6:D293 90 09       BCC $09    [$D29E]

$A6:D295 C8          INY
$A6:D296 C8          INY
$A6:D297 C0 0A 00    CPY #$000A
$A6:D29A 30 C1       BMI $C1    [$D25D]
$A6:D29C 18          CLC
$A6:D29D 60          RTS

$A6:D29E B9 64 0B    LDA $0B64,y
$A6:D2A1 85 12       STA $12    [$7E:0012]
$A6:D2A3 B9 78 0B    LDA $0B78,y
$A6:D2A6 85 14       STA $14    [$7E:0014]
$A6:D2A8 38          SEC
$A6:D2A9 60          RTS
}


;;; $D2AA:  ;;;
{
; Play swishing sound if tail is moving quickly
$A6:D2AA AF 14 20 7E LDA $7E2014[$7E:2014]
$A6:D2AE C9 08 00    CMP #$0008
$A6:D2B1 30 1B       BMI $1B    [$D2CE]
$A6:D2B3 AF 1C 78 7E LDA $7E781C[$7E:781C]
$A6:D2B7 1A          INC A
$A6:D2B8 8F 1C 78 7E STA $7E781C[$7E:781C]
$A6:D2BC C9 10 00    CMP #$0010
$A6:D2BF 30 14       BMI $14    [$D2D5]
$A6:D2C1 AF 1E 78 7E LDA $7E781E[$7E:781E]
$A6:D2C5 D0 07       BNE $07    [$D2CE]
$A6:D2C7 A9 21 00    LDA #$0021             ;\
$A6:D2CA 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 21h, sound library 3, max queued sounds allowed = 6 (Ridley whips its tail)

$A6:D2CE A9 00 00    LDA #$0000
$A6:D2D1 8F 1C 78 7E STA $7E781C[$7E:781C]

$A6:D2D5 60          RTS
}


;;; $D2D6:  ;;;
{
; Initializes a ton of variables from 7E:2012 to 7E:20A7. I'm *guessing* they're for his tail
$A6:D2D6 A9 01 00    LDA #$0001
$A6:D2D9 8F 14 20 7E STA $7E2014[$7E:2014]
$A6:D2DD A9 F0 3F    LDA #$3FF0
$A6:D2E0 8F 16 20 7E STA $7E2016[$7E:2016]
$A6:D2E4 A9 40 40    LDA #$4040
$A6:D2E7 8F 18 20 7E STA $7E2018[$7E:2018]
$A6:D2EB A9 FF FF    LDA #$FFFF
$A6:D2EE 8F 1A 20 7E STA $7E201A[$7E:201A]
$A6:D2F2 8F 1C 20 7E STA $7E201C[$7E:201C]
$A6:D2F6 A9 F0 00    LDA #$00F0
$A6:D2F9 8F 12 20 7E STA $7E2012[$7E:2012]
$A6:D2FD A9 10 00    LDA #$0010
$A6:D300 8F 1E 20 7E STA $7E201E[$7E:201E]
$A6:D304 1A          INC A
$A6:D305 8F 22 20 7E STA $7E2022[$7E:2022]
$A6:D309 8F 36 20 7E STA $7E2036[$7E:2036]
$A6:D30D 8F 4A 20 7E STA $7E204A[$7E:204A]
$A6:D311 8F 5E 20 7E STA $7E205E[$7E:205E]
$A6:D315 8F 72 20 7E STA $7E2072[$7E:2072]
$A6:D319 8F 86 20 7E STA $7E2086[$7E:2086]
$A6:D31D 8F 9A 20 7E STA $7E209A[$7E:209A]
$A6:D321 A2 6E D3    LDX #$D36E
$A6:D324 A0 24 20    LDY #$2024
$A6:D327 20 B4 D3    JSR $D3B4  [$A6:D3B4]
$A6:D32A A2 7C D3    LDX #$D37C
$A6:D32D A0 26 20    LDY #$2026
$A6:D330 20 B4 D3    JSR $D3B4  [$A6:D3B4]
$A6:D333 A2 8A D3    LDX #$D38A
$A6:D336 A0 2A 20    LDY #$202A
$A6:D339 20 B4 D3    JSR $D3B4  [$A6:D3B4]
$A6:D33C A2 98 D3    LDX #$D398
$A6:D33F A0 2C 20    LDY #$202C
$A6:D342 20 B4 D3    JSR $D3B4  [$A6:D3B4]
$A6:D345 A2 A6 D3    LDX #$D3A6
$A6:D348 A0 2E 20    LDY #$202E
$A6:D34B 20 B4 D3    JSR $D3B4  [$A6:D3B4]
$A6:D34E A9 00 00    LDA #$0000
$A6:D351 8F 20 20 7E STA $7E2020[$7E:2020]
$A6:D355 8F 34 20 7E STA $7E2034[$7E:2034]
$A6:D359 8F 48 20 7E STA $7E2048[$7E:2048]
$A6:D35D 8F 5C 20 7E STA $7E205C[$7E:205C]
$A6:D361 8F 70 20 7E STA $7E2070[$7E:2070]
$A6:D365 8F 84 20 7E STA $7E2084[$7E:2084]
$A6:D369 8F 98 20 7E STA $7E2098[$7E:2098]
$A6:D36D 60          RTS

$A6:D36E             dw 8000,8000,8000,8000,8000,8000,8000
$A6:D37C             dw 0200,0800,0800,0800,0800,0800,0500
$A6:D38A             dw 4000,4010,4020,4030,4040,4050,4060
$A6:D398             dw 0000,0003,0007,0007,0003,FFFD,FFFC
$A6:D3A6             dw 0002,0007,0003,FFFD,FFF9,FFF9,FFFF
}


;;; $D3B4:  ;;;
{
; Copy 7 entries from (X) to 7E:(Y), 7E:(Y+14), 7E:(Y+28), 7E:(Y+3C), etc.
$A6:D3B4 A9 7E 00    LDA #$007E
$A6:D3B7 85 14       STA $14    [$7E:0014]
$A6:D3B9 84 12       STY $12    [$7E:0012]
$A6:D3BB A0 00 00    LDY #$0000
$A6:D3BE A9 07 00    LDA #$0007

$A6:D3C1 48          PHA
$A6:D3C2 BD 00 00    LDA $0000,x[$A6:D36E]
$A6:D3C5 97 12       STA [$12],y[$7E:2024]
$A6:D3C7 E8          INX
$A6:D3C8 E8          INX
$A6:D3C9 98          TYA
$A6:D3CA 18          CLC
$A6:D3CB 69 14 00    ADC #$0014
$A6:D3CE A8          TAY
$A6:D3CF 68          PLA
$A6:D3D0 3A          DEC A
$A6:D3D1 D0 EE       BNE $EE    [$D3C1]
$A6:D3D3 60          RTS
}


;;; $D3D4:  ;;;
{
$A6:D3D4 A9 00 00    LDA #$0000
$A6:D3D7 80 03       BRA $03    [$D3DC]
}


;;; $D3D9:  ;;;
{
; Set all tail parts to moving
$A6:D3D9 A9 00 80    LDA #$8000
}


;;; $D3DC:  ;;;
{
$A6:D3DC 8F 20 20 7E STA $7E2020[$7E:2020]
$A6:D3E0 8F 34 20 7E STA $7E2034[$7E:2034]
$A6:D3E4 8F 48 20 7E STA $7E2048[$7E:2048]
$A6:D3E8 8F 5C 20 7E STA $7E205C[$7E:205C]
$A6:D3EC 8F 70 20 7E STA $7E2070[$7E:2070]
$A6:D3F0 8F 84 20 7E STA $7E2084[$7E:2084]
$A6:D3F4 8F 98 20 7E STA $7E2098[$7E:2098]
$A6:D3F8 60          RTS
}


;;; $D3F9:  ;;;
{
$A6:D3F9 DA          PHX
$A6:D3FA 5A          PHY
$A6:D3FB A2 7C D3    LDX #$D37C
$A6:D3FE A0 26 20    LDY #$2026
$A6:D401 20 B4 D3    JSR $D3B4  [$A6:D3B4]
$A6:D404 A0 07 00    LDY #$0007
$A6:D407 A2 00 00    LDX #$0000

$A6:D40A BF 2A 20 7E LDA $7E202A,x[$7E:202A]
$A6:D40E 49 FF FF    EOR #$FFFF
$A6:D411 1A          INC A
$A6:D412 18          CLC
$A6:D413 69 00 80    ADC #$8000
$A6:D416 9F 2A 20 7E STA $7E202A,x[$7E:202A]
$A6:D41A BF 24 20 7E LDA $7E2024,x[$7E:2024]
$A6:D41E 09 00 80    ORA #$8000
$A6:D421 9F 24 20 7E STA $7E2024,x[$7E:2024]
$A6:D425 8A          TXA
$A6:D426 18          CLC
$A6:D427 69 14 00    ADC #$0014
$A6:D42A AA          TAX
$A6:D42B 88          DEY
$A6:D42C D0 DC       BNE $DC    [$D40A]
$A6:D42E 7A          PLY
$A6:D42F FA          PLX
$A6:D430 60          RTS
}


;;; $D431:  ;;;
{
$A6:D431 AF 20 20 7E LDA $7E2020[$7E:2020]
$A6:D435 2F 34 20 7E AND $7E2034[$7E:2034]
$A6:D439 2F 48 20 7E AND $7E2048[$7E:2048]
$A6:D43D 2F 5C 20 7E AND $7E205C[$7E:205C]
$A6:D441 2F 70 20 7E AND $7E2070[$7E:2070]
$A6:D445 2F 84 20 7E AND $7E2084[$7E:2084]
$A6:D449 2F 98 20 7E AND $7E2098[$7E:2098]
$A6:D44D D0 02       BNE $02    [$D451]
$A6:D44F 18          CLC
$A6:D450 60          RTS

$A6:D451 38          SEC
$A6:D452 60          RTS
}


;;; $D453: Deal suit-adjusted enemy damage to Samus ;;;
{
$A6:D453 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A6:D456 BD 78 0F    LDA $0F78,x            ;|
$A6:D459 AA          TAX                    ;} A = [$A0:0008 + [enemy ID]] (enemy damage)
$A6:D45A BF 06 00 A0 LDA $A00006,x          ;/
$A6:D45E 22 5E A4 A0 JSL $A0A45E[$A0:A45E]  ;\
$A6:D462 22 51 DF 91 JSL $91DF51[$91:DF51]  ;} Deal [A] suit-adjusted damage to Samus
$A6:D466 6B          RTL
}


;;; $D467: Set Ridley instruction list ;;;
{
$A6:D467 8D 92 0F    STA $0F92  [$7E:0F92]
$A6:D46A A9 01 00    LDA #$0001
$A6:D46D 8D 94 0F    STA $0F94  [$7E:0F94]
$A6:D470 9C 90 0F    STZ $0F90  [$7E:0F90]
$A6:D473 60          RTS
}


;;; $D474:  ;;;
{
; Determine and set Ridley's speed and color pallete
$A6:D474 A9 00 00    LDA #$0000
$A6:D477 AC 8C 0F    LDY $0F8C  [$7E:0F8C]
$A6:D47A C0 28 23    CPY #$2328
$A6:D47D B0 0D       BCS $0D    [$D48C]
$A6:D47F 1A          INC A
$A6:D480 C0 18 15    CPY #$1518
$A6:D483 B0 07       BCS $07    [$D48C]
$A6:D485 1A          INC A
$A6:D486 C0 08 07    CPY #$0708
$A6:D489 B0 01       BCS $01    [$D48C]
$A6:D48B 1A          INC A

$A6:D48C 8F 24 78 7E STA $7E7824[$7E:7824]
$A6:D490 3A          DEC A
$A6:D491 85 12       STA $12    [$7E:0012]
$A6:D493 30 1F       BMI $1F    [$D4B4]
}


;;; $D495:  ;;;
{
$A6:D495 AF 00 C4 7E LDA $7EC400[$7E:C400]
$A6:D499 D0 19       BNE $19    [$D4B4]
$A6:D49B A5 12       LDA $12    [$7E:0012]
$A6:D49D 0A          ASL A
$A6:D49E 0A          ASL A
$A6:D49F 0A          ASL A
$A6:D4A0 38          SEC
$A6:D4A1 E5 12       SBC $12    [$7E:0012]
$A6:D4A3 0A          ASL A
$A6:D4A4 0A          ASL A
$A6:D4A5 18          CLC
$A6:D4A6 69 6A E4    ADC #$E46A
$A6:D4A9 A8          TAY
$A6:D4AA A2 E2 01    LDX #$01E2
$A6:D4AD A9 0E 00    LDA #$000E
$A6:D4B0 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]

$A6:D4B4 60          RTS
}


;;; $D4B5:  ;;;
{
; Determine and set Ridley's color pallete
$A6:D4B5 AF 02 78 7E LDA $7E7802[$7E:7802]
$A6:D4B9 F0 F9       BEQ $F9    [$D4B4]
$A6:D4BB AF 1A 78 7E LDA $7E781A[$7E:781A]
$A6:D4BF C9 32 00    CMP #$0032
$A6:D4C2 90 F0       BCC $F0    [$D4B4]
$A6:D4C4 A0 00 00    LDY #$0000
$A6:D4C7 C9 46 00    CMP #$0046
$A6:D4CA 90 09       BCC $09    [$D4D5]
$A6:D4CC A0 01 00    LDY #$0001
$A6:D4CF C9 5A 00    CMP #$005A
$A6:D4D2 A0 02 00    LDY #$0002

$A6:D4D5 84 12       STY $12    [$7E:0012]
$A6:D4D7 4C 95 D4    JMP $D495  [$A6:D495]
}


;;; $D4DA:  ;;;
{
; Make wings/tail flash when hit
$A6:D4DA DA          PHX
$A6:D4DB A2 00 0E    LDX #$0E00
$A6:D4DE AD 9C 0F    LDA $0F9C  [$7E:0F9C]
$A6:D4E1 F0 0F       BEQ $0F    [$D4F2]
$A6:D4E3 3A          DEC A
$A6:D4E4 F0 0C       BEQ $0C    [$D4F2]
$A6:D4E6 AD 44 0E    LDA $0E44  [$7E:0E44]
$A6:D4E9 1A          INC A
$A6:D4EA 29 02 00    AND #$0002
$A6:D4ED F0 03       BEQ $03    [$D4F2]
$A6:D4EF A2 00 00    LDX #$0000

$A6:D4F2 8A          TXA
$A6:D4F3 8F 18 78 7E STA $7E7818[$7E:7818]
$A6:D4F7 FA          PLX
$A6:D4F8 60          RTS
}


;;; $D4F9: Check for collision with non-air block ;;;
{
;; Parameters:
;;     X: X position
;;     Y: Y position
;; Returns:
;;     Carry: Set if collision, clear otherwise
$A6:D4F9 98          TYA
$A6:D4FA 4A          LSR A
$A6:D4FB 4A          LSR A
$A6:D4FC 4A          LSR A
$A6:D4FD 4A          LSR A
$A6:D4FE E2 20       SEP #$20
$A6:D500 8D 02 42    STA $4202  [$7E:4202]
$A6:D503 AD A5 07    LDA $07A5  [$7E:07A5]
$A6:D506 8D 03 42    STA $4203  [$7E:4203]
$A6:D509 C2 20       REP #$20
$A6:D50B 8A          TXA
$A6:D50C 4A          LSR A
$A6:D50D 4A          LSR A
$A6:D50E 4A          LSR A
$A6:D50F 4A          LSR A
$A6:D510 18          CLC
$A6:D511 6D 16 42    ADC $4216  [$7E:4216]
$A6:D514 0A          ASL A
$A6:D515 AA          TAX
$A6:D516 BF 02 00 7F LDA $7F0002,x[$7F:0102]
$A6:D51A 29 00 F0    AND #$F000
$A6:D51D D0 02       BNE $02    [$D521]
$A6:D51F 18          CLC
$A6:D520 6B          RTL

$A6:D521 38          SEC
$A6:D522 6B          RTL
}


;;; $D523:  ;;;
{
; Accelerates Ridley towards the desired X/Y ($12/$14).
; No deceleration boost ($1A), Y is index value to find acceleration divisor ($18), X is enemy's index
$A6:D523 A9 00 00    LDA #$0000
}


;;; $D526:  ;;;
{
; Accelerates Ridley towards the desired X/Y ($12/$14).
; A is deceleration boost, Y is index value to find acceleration divisor ($18), X is enemy's index
$A6:D526 85 1A       STA $1A    [$7E:001A]
$A6:D528 B9 1F D6    LDA $D61F,y[$A6:D62D]
$A6:D52B 29 FF 00    AND #$00FF
$A6:D52E 85 18       STA $18    [$7E:0018]
$A6:D530 20 A9 D5    JSR $D5A9  [$A6:D5A9]
$A6:D533 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A6:D536 38          SEC
$A6:D537 E5 14       SBC $14    [$7E:0014]
$A6:D539 F0 39       BEQ $39    [$D574]
$A6:D53B 10 38       BPL $38    [$D575]
$A6:D53D 49 FF FF    EOR #$FFFF
$A6:D540 1A          INC A
$A6:D541 8D 04 42    STA $4204  [$7E:4204]
$A6:D544 E2 20       SEP #$20
$A6:D546 A5 18       LDA $18    [$7E:0018]
$A6:D548 8D 06 42    STA $4206  [$7E:4206]
$A6:D54B C2 20       REP #$20
$A6:D54D EB          XBA
$A6:D54E EB          XBA
$A6:D54F EA          NOP
$A6:D550 EA          NOP
$A6:D551 AD 14 42    LDA $4214  [$7E:4214]
$A6:D554 D0 01       BNE $01    [$D557]
$A6:D556 1A          INC A

$A6:D557 85 16       STA $16    [$7E:0016]
$A6:D559 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A6:D55C 10 09       BPL $09    [$D567]
$A6:D55E 18          CLC
$A6:D55F 65 1A       ADC $1A    [$7E:001A]
$A6:D561 18          CLC
$A6:D562 69 08 00    ADC #$0008
$A6:D565 65 16       ADC $16    [$7E:0016]

$A6:D567 65 16       ADC $16    [$7E:0016]
$A6:D569 C9 00 05    CMP #$0500
$A6:D56C 30 03       BMI $03    [$D571]
$A6:D56E A9 00 05    LDA #$0500

$A6:D571 9D AC 0F    STA $0FAC,x[$7E:0FAC]

$A6:D574 60          RTS

$A6:D575 8D 04 42    STA $4204  [$7E:4204]
$A6:D578 E2 20       SEP #$20
$A6:D57A A5 18       LDA $18    [$7E:0018]
$A6:D57C 8D 06 42    STA $4206  [$7E:4206]
$A6:D57F C2 20       REP #$20
$A6:D581 EB          XBA
$A6:D582 EB          XBA
$A6:D583 EA          NOP
$A6:D584 EA          NOP
$A6:D585 AD 14 42    LDA $4214  [$7E:4214]
$A6:D588 D0 01       BNE $01    [$D58B]
$A6:D58A 1A          INC A

$A6:D58B 85 16       STA $16    [$7E:0016]
$A6:D58D BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A6:D590 30 09       BMI $09    [$D59B]
$A6:D592 38          SEC
$A6:D593 E5 1A       SBC $1A    [$7E:001A]
$A6:D595 38          SEC
$A6:D596 E9 08 00    SBC #$0008
$A6:D599 E5 16       SBC $16    [$7E:0016]

$A6:D59B E5 16       SBC $16    [$7E:0016]
$A6:D59D C9 00 FB    CMP #$FB00
$A6:D5A0 10 03       BPL $03    [$D5A5]
$A6:D5A2 A9 00 FB    LDA #$FB00

$A6:D5A5 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A6:D5A8 60          RTS
}


;;; $D5A9:  ;;;
{
; Accelerates Ridley towards the desired X position ($12).
; Deceleration boost in $1A, acceleration divisor in $18, X is enemy's index
$A6:D5A9 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A6:D5AC 38          SEC
$A6:D5AD E5 12       SBC $12    [$7E:0012]
$A6:D5AF F0 39       BEQ $39    [$D5EA]
$A6:D5B1 10 38       BPL $38    [$D5EB]
$A6:D5B3 49 FF FF    EOR #$FFFF
$A6:D5B6 1A          INC A
$A6:D5B7 8D 04 42    STA $4204  [$7E:4204]
$A6:D5BA E2 20       SEP #$20
$A6:D5BC A5 18       LDA $18    [$7E:0018]
$A6:D5BE 8D 06 42    STA $4206  [$7E:4206]
$A6:D5C1 C2 20       REP #$20
$A6:D5C3 EB          XBA
$A6:D5C4 EB          XBA
$A6:D5C5 EA          NOP
$A6:D5C6 EA          NOP
$A6:D5C7 AD 14 42    LDA $4214  [$7E:4214]
$A6:D5CA D0 01       BNE $01    [$D5CD]
$A6:D5CC 1A          INC A

$A6:D5CD 85 16       STA $16    [$7E:0016]
$A6:D5CF BD AA 0F    LDA $0FAA,x[$7E:0FAA]
$A6:D5D2 10 09       BPL $09    [$D5DD]
$A6:D5D4 18          CLC
$A6:D5D5 65 1A       ADC $1A    [$7E:001A]
$A6:D5D7 18          CLC
$A6:D5D8 69 08 00    ADC #$0008
$A6:D5DB 65 16       ADC $16    [$7E:0016]

$A6:D5DD 65 16       ADC $16    [$7E:0016]
$A6:D5DF C9 00 05    CMP #$0500
$A6:D5E2 30 03       BMI $03    [$D5E7]
$A6:D5E4 A9 00 05    LDA #$0500

$A6:D5E7 9D AA 0F    STA $0FAA,x[$7E:0FAA]

$A6:D5EA 60          RTS

$A6:D5EB 8D 04 42    STA $4204  [$7E:4204]
$A6:D5EE E2 20       SEP #$20
$A6:D5F0 A5 18       LDA $18    [$7E:0018]
$A6:D5F2 8D 06 42    STA $4206  [$7E:4206]
$A6:D5F5 C2 20       REP #$20
$A6:D5F7 EB          XBA
$A6:D5F8 EB          XBA
$A6:D5F9 EA          NOP
$A6:D5FA EA          NOP
$A6:D5FB AD 14 42    LDA $4214  [$7E:4214]
$A6:D5FE D0 01       BNE $01    [$D601]
$A6:D600 1A          INC A

$A6:D601 85 16       STA $16    [$7E:0016]
$A6:D603 BD AA 0F    LDA $0FAA,x[$7E:0FAA]
$A6:D606 30 09       BMI $09    [$D611]
$A6:D608 38          SEC
$A6:D609 E5 1A       SBC $1A    [$7E:001A]
$A6:D60B 38          SEC
$A6:D60C E9 08 00    SBC #$0008
$A6:D60F E5 16       SBC $16    [$7E:0016]

$A6:D611 E5 16       SBC $16    [$7E:0016]
$A6:D613 C9 00 FB    CMP #$FB00
$A6:D616 10 03       BPL $03    [$D61B]
$A6:D618 A9 00 FB    LDA #$FB00

$A6:D61B 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A6:D61E 60          RTS
}


;;; $D61F:  ;;;
{
$A6:D61F             db 10, 0F, 0E, 0D, 0C, 0B, 0A, 09, 08, 07, 06, 05, 04, 03, 02, 01
}


;;; $D62F:  ;;;
{
$A6:D62F B9 12 D7    LDA $D712,y[$A6:D712]
$A6:D632 29 FF 00    AND #$00FF
$A6:D635 85 18       STA $18    [$7E:0018]
$A6:D637 20 A6 D6    JSR $D6A6  [$A6:D6A6]
$A6:D63A BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A6:D63D 38          SEC
$A6:D63E E5 14       SBC $14    [$7E:0014]
$A6:D640 F0 34       BEQ $34    [$D676]
$A6:D642 10 33       BPL $33    [$D677]
$A6:D644 49 FF FF    EOR #$FFFF
$A6:D647 1A          INC A
$A6:D648 8D 04 42    STA $4204  [$7E:4204]
$A6:D64B E2 20       SEP #$20
$A6:D64D A5 18       LDA $18    [$7E:0018]
$A6:D64F 8D 06 42    STA $4206  [$7E:4206]
$A6:D652 C2 20       REP #$20
$A6:D654 EB          XBA
$A6:D655 EB          XBA
$A6:D656 EA          NOP
$A6:D657 EA          NOP
$A6:D658 AD 14 42    LDA $4214  [$7E:4214]
$A6:D65B D0 01       BNE $01    [$D65E]
$A6:D65D 1A          INC A

$A6:D65E 85 16       STA $16    [$7E:0016]
$A6:D660 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A6:D663 10 04       BPL $04    [$D669]
$A6:D665 65 16       ADC $16    [$7E:0016]
$A6:D667 65 16       ADC $16    [$7E:0016]

$A6:D669 65 16       ADC $16    [$7E:0016]
$A6:D66B C9 00 05    CMP #$0500
$A6:D66E 30 03       BMI $03    [$D673]
$A6:D670 A9 00 05    LDA #$0500

$A6:D673 9D AC 0F    STA $0FAC,x[$7E:0FAC]

$A6:D676 60          RTS

$A6:D677 8D 04 42    STA $4204  [$7E:4204]
$A6:D67A E2 20       SEP #$20
$A6:D67C A5 18       LDA $18    [$7E:0018]
$A6:D67E 8D 06 42    STA $4206  [$7E:4206]
$A6:D681 C2 20       REP #$20
$A6:D683 EB          XBA
$A6:D684 EB          XBA
$A6:D685 EA          NOP
$A6:D686 EA          NOP
$A6:D687 AD 14 42    LDA $4214  [$7E:4214]
$A6:D68A D0 01       BNE $01    [$D68D]
$A6:D68C 1A          INC A

$A6:D68D 85 16       STA $16    [$7E:0016]
$A6:D68F BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A6:D692 30 04       BMI $04    [$D698]
$A6:D694 E5 16       SBC $16    [$7E:0016]
$A6:D696 E5 16       SBC $16    [$7E:0016]

$A6:D698 E5 16       SBC $16    [$7E:0016]
$A6:D69A C9 00 FB    CMP #$FB00
$A6:D69D 10 03       BPL $03    [$D6A2]
$A6:D69F A9 00 FB    LDA #$FB00

$A6:D6A2 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A6:D6A5 60          RTS
}


;;; $D6A6:  ;;;
{
$A6:D6A6 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A6:D6A9 38          SEC
$A6:D6AA E5 12       SBC $12    [$7E:0012]
$A6:D6AC F0 34       BEQ $34    [$D6E2]
$A6:D6AE 10 33       BPL $33    [$D6E3]
$A6:D6B0 49 FF FF    EOR #$FFFF
$A6:D6B3 1A          INC A
$A6:D6B4 8D 04 42    STA $4204  [$7E:4204]
$A6:D6B7 E2 20       SEP #$20
$A6:D6B9 A5 18       LDA $18    [$7E:0018]
$A6:D6BB 8D 06 42    STA $4206  [$7E:4206]
$A6:D6BE C2 20       REP #$20
$A6:D6C0 EB          XBA
$A6:D6C1 EB          XBA
$A6:D6C2 EA          NOP
$A6:D6C3 EA          NOP
$A6:D6C4 AD 14 42    LDA $4214  [$7E:4214]
$A6:D6C7 D0 01       BNE $01    [$D6CA]
$A6:D6C9 1A          INC A

$A6:D6CA 85 16       STA $16    [$7E:0016]
$A6:D6CC BD AA 0F    LDA $0FAA,x[$7E:0FAA]
$A6:D6CF 10 04       BPL $04    [$D6D5]
$A6:D6D1 65 16       ADC $16    [$7E:0016]
$A6:D6D3 65 16       ADC $16    [$7E:0016]

$A6:D6D5 65 16       ADC $16    [$7E:0016]
$A6:D6D7 C9 00 05    CMP #$0500
$A6:D6DA 30 03       BMI $03    [$D6DF]
$A6:D6DC A9 00 05    LDA #$0500

$A6:D6DF 9D AA 0F    STA $0FAA,x[$7E:0FAA]

$A6:D6E2 60          RTS

$A6:D6E3 8D 04 42    STA $4204  [$7E:4204]
$A6:D6E6 E2 20       SEP #$20
$A6:D6E8 A5 18       LDA $18    [$7E:0018]
$A6:D6EA 8D 06 42    STA $4206  [$7E:4206]
$A6:D6ED C2 20       REP #$20
$A6:D6EF EB          XBA
$A6:D6F0 EB          XBA
$A6:D6F1 EA          NOP
$A6:D6F2 EA          NOP
$A6:D6F3 AD 14 42    LDA $4214  [$7E:4214]
$A6:D6F6 D0 01       BNE $01    [$D6F9]
$A6:D6F8 1A          INC A

$A6:D6F9 85 16       STA $16    [$7E:0016]
$A6:D6FB BD AA 0F    LDA $0FAA,x[$7E:0FAA]
$A6:D6FE 30 04       BMI $04    [$D704]
$A6:D700 E5 16       SBC $16    [$7E:0016]
$A6:D702 E5 16       SBC $16    [$7E:0016]

$A6:D704 E5 16       SBC $16    [$7E:0016]
$A6:D706 C9 00 FB    CMP #$FB00
$A6:D709 10 03       BPL $03    [$D70E]
$A6:D70B A9 00 FB    LDA #$FB00

$A6:D70E 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A6:D711 60          RTS
}


;;; $D712:  ;;;
{
$A6:D712             db 10, 0F, 0E, 0D, 0C, 0B, 0A, 09, 08, 07, 06, 05, 04, 03, 02, 01
}


;;; $D722:  ;;;
{
$A6:D722 A9 00 02    LDA #$0200
$A6:D725 85 16       STA $16    [$7E:0016]
$A6:D727 64 1C       STZ $1C    [$7E:001C]
$A6:D729 20 98 D7    JSR $D798  [$A6:D798]
$A6:D72C 20 34 D7    JSR $D734  [$A6:D734]
$A6:D72F 46 1C       LSR $1C    [$7E:001C]
$A6:D731 46 1C       LSR $1C    [$7E:001C]
$A6:D733 60          RTS
}


;;; $D734:  ;;;
{
$A6:D734 BD 7E 0F    LDA $0F7E,x
$A6:D737 38          SEC
$A6:D738 E5 14       SBC $14    [$7E:0014]
$A6:D73A 10 2D       BPL $2D    [$D769]
$A6:D73C BD AC 0F    LDA $0FAC,x
$A6:D73F 18          CLC
$A6:D740 65 16       ADC $16    [$7E:0016]
$A6:D742 C9 00 05    CMP #$0500
$A6:D745 30 03       BMI $03    [$D74A]
$A6:D747 A9 00 05    LDA #$0500

$A6:D74A 9D AC 0F    STA $0FAC,x
$A6:D74D 29 00 FF    AND #$FF00
$A6:D750 EB          XBA
$A6:D751 10 03       BPL $03    [$D756]
$A6:D753 09 00 FF    ORA #$FF00

$A6:D756 18          CLC
$A6:D757 7D 7E 0F    ADC $0F7E,x
$A6:D75A C5 14       CMP $14    [$7E:0014]
$A6:D75C 30 0A       BMI $0A    [$D768]
$A6:D75E 9E AC 0F    STZ $0FAC,x
$A6:D761 A5 14       LDA $14    [$7E:0014]
$A6:D763 9D 7E 0F    STA $0F7E,x
$A6:D766 E6 1C       INC $1C    [$7E:001C]

$A6:D768 60          RTS

$A6:D769 BD AC 0F    LDA $0FAC,x
$A6:D76C 38          SEC
$A6:D76D E5 16       SBC $16    [$7E:0016]
$A6:D76F C9 00 FB    CMP #$FB00
$A6:D772 10 03       BPL $03    [$D777]
$A6:D774 A9 00 FB    LDA #$FB00

$A6:D777 9D AC 0F    STA $0FAC,x
$A6:D77A 29 00 FF    AND #$FF00
$A6:D77D EB          XBA
$A6:D77E 10 03       BPL $03    [$D783]
$A6:D780 09 00 FF    ORA #$FF00

$A6:D783 18          CLC
$A6:D784 7D 7E 0F    ADC $0F7E,x
$A6:D787 C5 14       CMP $14    [$7E:0014]
$A6:D789 F0 02       BEQ $02    [$D78D]
$A6:D78B 10 0A       BPL $0A    [$D797]

$A6:D78D 9E AC 0F    STZ $0FAC,x
$A6:D790 A5 14       LDA $14    [$7E:0014]
$A6:D792 9D 7E 0F    STA $0F7E,x
$A6:D795 E6 1C       INC $1C    [$7E:001C]

$A6:D797 60          RTS
}


;;; $D798:  ;;;
{
$A6:D798 BD 7A 0F    LDA $0F7A,x
$A6:D79B 38          SEC
$A6:D79C E5 12       SBC $12    [$7E:0012]
$A6:D79E 10 31       BPL $31    [$D7D1]
$A6:D7A0 49 FF FF    EOR #$FFFF
$A6:D7A3 1A          INC A
$A6:D7A4 BD AA 0F    LDA $0FAA,x
$A6:D7A7 18          CLC
$A6:D7A8 65 16       ADC $16    [$7E:0016]
$A6:D7AA C9 00 05    CMP #$0500
$A6:D7AD 30 03       BMI $03    [$D7B2]
$A6:D7AF A9 00 05    LDA #$0500

$A6:D7B2 9D AA 0F    STA $0FAA,x
$A6:D7B5 29 00 FF    AND #$FF00
$A6:D7B8 EB          XBA
$A6:D7B9 10 03       BPL $03    [$D7BE]
$A6:D7BB 09 00 FF    ORA #$FF00

$A6:D7BE 18          CLC
$A6:D7BF 7D 7A 0F    ADC $0F7A,x
$A6:D7C2 C5 12       CMP $12    [$7E:0012]
$A6:D7C4 30 0A       BMI $0A    [$D7D0]
$A6:D7C6 9E AA 0F    STZ $0FAA,x
$A6:D7C9 A5 12       LDA $12    [$7E:0012]
$A6:D7CB 9D 7A 0F    STA $0F7A,x
$A6:D7CE E6 1C       INC $1C    [$7E:001C]

$A6:D7D0 60          RTS

$A6:D7D1 BD AA 0F    LDA $0FAA,x
$A6:D7D4 38          SEC
$A6:D7D5 E5 16       SBC $16    [$7E:0016]
$A6:D7D7 C9 00 FB    CMP #$FB00
$A6:D7DA 10 03       BPL $03    [$D7DF]
$A6:D7DC A9 00 FB    LDA #$FB00

$A6:D7DF 9D AA 0F    STA $0FAA,x
$A6:D7E2 29 00 FF    AND #$FF00
$A6:D7E5 EB          XBA
$A6:D7E6 10 03       BPL $03    [$D7EB]
$A6:D7E8 09 00 FF    ORA #$FF00

$A6:D7EB 18          CLC
$A6:D7EC 7D 7A 0F    ADC $0F7A,x
$A6:D7EF C5 12       CMP $12    [$7E:0012]
$A6:D7F1 F0 02       BEQ $02    [$D7F5]
$A6:D7F3 10 0A       BPL $0A    [$D7FF]

$A6:D7F5 9E AA 0F    STZ $0FAA,x
$A6:D7F8 A5 12       LDA $12    [$7E:0012]
$A6:D7FA 9D 7A 0F    STA $0F7A,x
$A6:D7FD E6 1C       INC $1C    [$7E:001C]

$A6:D7FF 60          RTS
}


;;; $D800:  ;;;
{
; Update Ridley's U Swoop speed and U Swoop angle, and calculate current X and Y speed
$A6:D800 A5 16       LDA $16    [$7E:0016]
$A6:D802 CF 16 78 7E CMP $7E7816[$7E:7816]
$A6:D806 F0 28       BEQ $28    [$D830]
$A6:D808 10 14       BPL $14    [$D81E]
$A6:D80A AF 16 78 7E LDA $7E7816[$7E:7816]
$A6:D80E 38          SEC
$A6:D80F E9 20 00    SBC #$0020
$A6:D812 C5 16       CMP $16    [$7E:0016]
$A6:D814 10 02       BPL $02    [$D818]
$A6:D816 A5 16       LDA $16    [$7E:0016]

$A6:D818 8F 16 78 7E STA $7E7816[$7E:7816]
$A6:D81C 80 12       BRA $12    [$D830]

$A6:D81E AF 16 78 7E LDA $7E7816[$7E:7816]
$A6:D822 18          CLC
$A6:D823 69 20 00    ADC #$0020
$A6:D826 C5 16       CMP $16    [$7E:0016]
$A6:D828 30 02       BMI $02    [$D82C]
$A6:D82A A5 16       LDA $16    [$7E:0016]

$A6:D82C 8F 16 78 7E STA $7E7816[$7E:7816]

$A6:D830 A5 12       LDA $12    [$7E:0012]
$A6:D832 30 0B       BMI $0B    [$D83F]
$A6:D834 18          CLC
$A6:D835 6F 14 78 7E ADC $7E7814[$7E:7814]
$A6:D839 C5 14       CMP $14    [$7E:0014]
$A6:D83B 30 0D       BMI $0D    [$D84A]
$A6:D83D 80 09       BRA $09    [$D848]

$A6:D83F 18          CLC
$A6:D840 6F 14 78 7E ADC $7E7814[$7E:7814]
$A6:D844 C5 14       CMP $14    [$7E:0014]
$A6:D846 10 02       BPL $02    [$D84A]

$A6:D848 A5 14       LDA $14    [$7E:0014]

$A6:D84A 8F 14 78 7E STA $7E7814[$7E:7814]
$A6:D84E EB          XBA
$A6:D84F 29 FF 00    AND #$00FF
$A6:D852 85 12       STA $12    [$7E:0012]
$A6:D854 AF 16 78 7E LDA $7E7816[$7E:7816]
$A6:D858 22 6C C2 86 JSL $86C26C[$86:C26C]
$A6:D85C 8D AA 0F    STA $0FAA  [$7E:0FAA]
$A6:D85F AF 16 78 7E LDA $7E7816[$7E:7816]
$A6:D863 22 72 C2 86 JSL $86C272[$86:C272]
$A6:D867 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:D86A 60          RTS
}


;;; $D86B:  ;;;
{
; Handles movement and main body wall collisions
$A6:D86B A9 00 00    LDA #$0000
$A6:D86E 8F 3E 78 7E STA $7E783E[$7E:783E]
$A6:D872 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:D875 BD AA 0F    LDA $0FAA,x[$7E:0FAA]
$A6:D878 E2 20       SEP #$20
$A6:D87A 18          CLC
$A6:D87B 7D 7D 0F    ADC $0F7D,x[$7E:0F7D]
$A6:D87E 9D 7D 0F    STA $0F7D,x[$7E:0F7D]
$A6:D881 C2 20       REP #$20
$A6:D883 29 00 FF    AND #$FF00
$A6:D886 EB          XBA
$A6:D887 10 03       BPL $03    [$D88C]
$A6:D889 09 00 FF    ORA #$FF00

$A6:D88C 7D 7A 0F    ADC $0F7A,x[$7E:0F7A]
$A6:D88F CF 04 80 7E CMP $7E8004[$7E:8004]
$A6:D893 10 16       BPL $16    [$D8AB]
$A6:D895 20 14 D9    JSR $D914  [$A6:D914]
$A6:D898 AF 04 80 7E LDA $7E8004[$7E:8004]
$A6:D89C 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$A6:D89F 9E AA 0F    STZ $0FAA,x[$7E:0FAA]
$A6:D8A2 A9 01 00    LDA #$0001
$A6:D8A5 8F 3E 78 7E STA $7E783E[$7E:783E]
$A6:D8A9 80 17       BRA $17    [$D8C2]

$A6:D8AB CF 06 80 7E CMP $7E8006[$7E:8006]
$A6:D8AF 30 0E       BMI $0E    [$D8BF]
$A6:D8B1 9E AA 0F    STZ $0FAA,x[$7E:0FAA]
$A6:D8B4 A9 02 00    LDA #$0002
$A6:D8B7 8F 3E 78 7E STA $7E783E[$7E:783E]
$A6:D8BB AF 06 80 7E LDA $7E8006[$7E:8006]

$A6:D8BF 9D 7A 0F    STA $0F7A,x[$7E:0F7A]

$A6:D8C2 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A6:D8C5 E2 20       SEP #$20
$A6:D8C7 18          CLC
$A6:D8C8 7D 81 0F    ADC $0F81,x[$7E:0F81]
$A6:D8CB 9D 81 0F    STA $0F81,x[$7E:0F81]
$A6:D8CE C2 20       REP #$20
$A6:D8D0 29 00 FF    AND #$FF00
$A6:D8D3 EB          XBA
$A6:D8D4 10 03       BPL $03    [$D8D9]
$A6:D8D6 09 00 FF    ORA #$FF00

$A6:D8D9 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]
$A6:D8DC CF 00 80 7E CMP $7E8000[$7E:8000]
$A6:D8E0 10 16       BPL $16    [$D8F8]
$A6:D8E2 AF 00 80 7E LDA $7E8000[$7E:8000]
$A6:D8E6 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A6:D8E9 9E AC 0F    STZ $0FAC,x[$7E:0FAC]
$A6:D8EC AF 3E 78 7E LDA $7E783E[$7E:783E]  ; >_<;
$A6:D8F0 A9 04 00    LDA #$0004
$A6:D8F3 8F 3E 78 7E STA $7E783E[$7E:783E]
$A6:D8F7 60          RTS

$A6:D8F8 CF 02 80 7E CMP $7E8002[$7E:8002]
$A6:D8FC 30 12       BMI $12    [$D910]
$A6:D8FE 9E AC 0F    STZ $0FAC,x
$A6:D901 AF 3E 78 7E LDA $7E783E[$7E:783E]
$A6:D905 A9 08 00    LDA #$0008
$A6:D908 8F 3E 78 7E STA $7E783E[$7E:783E]
$A6:D90C AF 02 80 7E LDA $7E8002[$7E:8002]

$A6:D910 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A6:D913 60          RTS
}


;;; $D914:  ;;;
{
; Cause room shaking, only happens in Ceres. Has unreachable code for Norfair room shaking
$A6:D914 AD 9F 07    LDA $079F  [$7E:079F]
$A6:D917 C9 02 00    CMP #$0002
$A6:D91A F0 38       BEQ $38    [$D954]
$A6:D91C BD AA 0F    LDA $0FAA,x
$A6:D91F 10 04       BPL $04    [$D925]
$A6:D921 49 FF FF    EOR #$FFFF
$A6:D924 1A          INC A

$A6:D925 85 12       STA $12    [$7E:0012]
$A6:D927 BD AC 0F    LDA $0FAC,x
$A6:D92A 10 04       BPL $04    [$D930]
$A6:D92C 49 FF FF    EOR #$FFFF
$A6:D92F 1A          INC A

$A6:D930 C5 12       CMP $12    [$7E:0012]
$A6:D932 B0 02       BCS $02    [$D936]
$A6:D934 A5 12       LDA $12    [$7E:0012]

$A6:D936 C9 80 02    CMP #$0280
$A6:D939 90 19       BCC $19    [$D954]
$A6:D93B AD 9F 07    LDA $079F  [$7E:079F]
$A6:D93E C9 02 00    CMP #$0002
$A6:D941 F0 05       BEQ $05    [$D948]
$A6:D943 A9 21 00    LDA #$0021             ; Earthquake type = BG2 only and enemies, 3 pixel displacement, horizontal
$A6:D946 80 03       BRA $03    [$D94B]

$A6:D948 A9 18 00    LDA #$0018             ; Earthquake type = BG1, BG2 and enemies, 3 pixel displacement, horizontal

$A6:D94B 8D 3E 18    STA $183E  [$7E:183E]
$A6:D94E A9 0C 00    LDA #$000C             ;\
$A6:D951 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = Ch

$A6:D954 60          RTS
}


;;; $D955:  ;;;
{
; Turn around if facing away from the center of the room (facing a wall)
$A6:D955 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:D959 F0 0D       BEQ $0D    [$D968]
$A6:D95B 3A          DEC A
$A6:D95C F0 1E       BEQ $1E    [$D97C]
$A6:D95E AD 79 0F    LDA $0F79  [$7E:0F79]
$A6:D961 10 19       BPL $19    [$D97C]
$A6:D963 A9 06 E7    LDA #$E706
$A6:D966 80 08       BRA $08    [$D970]

$A6:D968 AD 79 0F    LDA $0F79  [$7E:0F79]
$A6:D96B 30 0F       BMI $0F    [$D97C]
$A6:D96D A9 F0 E6    LDA #$E6F0

$A6:D970 8D 92 0F    STA $0F92  [$7E:0F92]
$A6:D973 A9 02 00    LDA #$0002
$A6:D976 8D 94 0F    STA $0F94  [$7E:0F94]
$A6:D979 9C 90 0F    STZ $0F90  [$7E:0F90]

$A6:D97C 60          RTS
}


;;; $D97D:  ;;;
{
; Handle wing flapping
$A6:D97D 20 A8 D9    JSR $D9A8  [$A6:D9A8]
$A6:D980 AF 12 78 7E LDA $7E7812[$7E:7812]
$A6:D984 38          SEC
$A6:D985 EF 10 78 7E SBC $7E7810[$7E:7810]
$A6:D989 8F 12 78 7E STA $7E7812[$7E:7812]
$A6:D98D 10 18       BPL $18    [$D9A7]
$A6:D98F A9 20 00    LDA #$0020
$A6:D992 8F 12 78 7E STA $7E7812[$7E:7812]
$A6:D996 AF 0E 78 7E LDA $7E780E[$7E:780E]
$A6:D99A 1A          INC A
$A6:D99B C9 0A 00    CMP #$000A
$A6:D99E 90 03       BCC $03    [$D9A3]
$A6:D9A0 A9 00 00    LDA #$0000

$A6:D9A3 8F 0E 78 7E STA $7E780E[$7E:780E]

$A6:D9A7 60          RTS
}


;;; $D9A8:  ;;;
{
; Calculate wing flap speed
$A6:D9A8 AD AA 0F    LDA $0FAA  [$7E:0FAA]
$A6:D9AB 10 04       BPL $04    [$D9B1]
$A6:D9AD 49 FF FF    EOR #$FFFF
$A6:D9B0 1A          INC A

$A6:D9B1 85 12       STA $12    [$7E:0012]
$A6:D9B3 AD AC 0F    LDA $0FAC  [$7E:0FAC]
$A6:D9B6 10 04       BPL $04    [$D9BC]
$A6:D9B8 49 FF FF    EOR #$FFFF
$A6:D9BB 1A          INC A

$A6:D9BC 18          CLC
$A6:D9BD 65 12       ADC $12    [$7E:0012]
$A6:D9BF D0 05       BNE $05    [$D9C6]
$A6:D9C1 8F 10 78 7E STA $7E7810[$7E:7810]
$A6:D9C5 60          RTS

$A6:D9C6 38          SEC
$A6:D9C7 E5 12       SBC $12    [$7E:0012]
$A6:D9C9 C5 12       CMP $12    [$7E:0012]
$A6:D9CB 10 02       BPL $02    [$D9CF]
$A6:D9CD A5 12       LDA $12    [$7E:0012]

$A6:D9CF 0A          ASL A
$A6:D9D0 0A          ASL A
$A6:D9D1 29 00 0F    AND #$0F00
$A6:D9D4 EB          XBA
$A6:D9D5 0A          ASL A
$A6:D9D6 C9 0E 00    CMP #$000E
$A6:D9D9 90 03       BCC $03    [$D9DE]
$A6:D9DB A9 0E 00    LDA #$000E

$A6:D9DE AA          TAX
$A6:D9DF BD ED D9    LDA $D9ED,x[$A6:D9F7]
$A6:D9E2 2C AC 0F    BIT $0FAC  [$7E:0FAC]
$A6:D9E5 30 01       BMI $01    [$D9E8]
$A6:D9E7 4A          LSR A

$A6:D9E8 8F 10 78 7E STA $7E7810[$7E:7810]
$A6:D9EC 60          RTS

$A6:D9ED             dw 000C, 000E, 0010, 0012, 001C, 0020, 0028, 0030
}


;;; $D9FD:  ;;;
{
$A6:D9FD A9 71 DA    LDA #$DA71
$A6:DA00 8F 0A 78 7E STA $7E780A[$7E:780A]
$A6:DA04 A9 01 00    LDA #$0001
$A6:DA07 8F 0C 78 7E STA $7E780C[$7E:780C]

$A6:DA0B 60          RTS
}


;;; $DA0C:  ;;;
{
; Animate Ridley's ribs
$A6:DA0C AF 0C 78 7E LDA $7E780C[$7E:780C]
$A6:DA10 3A          DEC A
$A6:DA11 8F 0C 78 7E STA $7E780C[$7E:780C]
$A6:DA15 D0 F4       BNE $F4    [$DA0B]
$A6:DA17 AF 0A 78 7E LDA $7E780A[$7E:780A]

$A6:DA1B AA          TAX
$A6:DA1C BD 00 00    LDA $0000,x[$A6:DA71]
$A6:DA1F 10 06       BPL $06    [$DA27]
$A6:DA21 8F 0A 78 7E STA $7E780A[$7E:780A]
$A6:DA25 80 F4       BRA $F4    [$DA1B]

$A6:DA27 8F 0C 78 7E STA $7E780C[$7E:780C]
$A6:DA2B AC 30 03    LDY $0330  [$7E:0330]
$A6:DA2E A9 00 B0    LDA #$B000
$A6:DA31 99 D3 00    STA $00D3,y[$7E:00D3]
$A6:DA34 99 DA 00    STA $00DA,y[$7E:00DA]
$A6:DA37 BD 02 00    LDA $0002,x[$A6:DA73]
$A6:DA3A 99 D2 00    STA $00D2,y[$7E:00D2]
$A6:DA3D BD 04 00    LDA $0004,x[$A6:DA75]
$A6:DA40 99 D9 00    STA $00D9,y[$7E:00D9]
$A6:DA43 A9 20 72    LDA #$7220
$A6:DA46 99 D5 00    STA $00D5,y[$7E:00D5]
$A6:DA49 A9 20 73    LDA #$7320
$A6:DA4C 99 DC 00    STA $00DC,y[$7E:00DC]
$A6:DA4F A9 40 00    LDA #$0040
$A6:DA52 99 D0 00    STA $00D0,y[$7E:00D0]
$A6:DA55 99 D7 00    STA $00D7,y[$7E:00D7]
$A6:DA58 98          TYA
$A6:DA59 18          CLC
$A6:DA5A 69 0E 00    ADC #$000E
$A6:DA5D A8          TAY
$A6:DA5E 8C 30 03    STY $0330  [$7E:0330]
$A6:DA61 A9 00 00    LDA #$0000
$A6:DA64 99 D0 00    STA $00D0,y[$7E:00DE]
$A6:DA67 8A          TXA
$A6:DA68 18          CLC
$A6:DA69 69 06 00    ADC #$0006
$A6:DA6C 8F 0A 78 7E STA $7E780A[$7E:780A]
$A6:DA70 60          RTS

$A6:DA71             dw 0014,9840,9A40,
                        0014,B800,B900,
                        0014,B840,B940,
                        0014,B800,B900

$A6:DA89             dw DA71
}


;;; $DA8B:  ;;;
{
$A6:DA8B A2 D0 DA    LDX #$DAD0
$A6:DA8E 90 03       BCC $03    [$DA93]
$A6:DA90 A2 D4 DA    LDX #$DAD4

$A6:DA93 AC 30 03    LDY $0330  [$7E:0330]
$A6:DA96 A9 00 B0    LDA #$B000
$A6:DA99 99 D3 00    STA $00D3,y[$7E:00D3]
$A6:DA9C 99 DA 00    STA $00DA,y[$7E:00DA]
$A6:DA9F BD 00 00    LDA $0000,x[$A6:DAD4]
$A6:DAA2 99 D2 00    STA $00D2,y[$7E:00D2]
$A6:DAA5 BD 02 00    LDA $0002,x[$A6:DAD6]
$A6:DAA8 99 D9 00    STA $00D9,y[$7E:00D9]
$A6:DAAB A9 C0 7A    LDA #$7AC0
$A6:DAAE 99 D5 00    STA $00D5,y[$7E:00D5]
$A6:DAB1 A9 C0 7B    LDA #$7BC0
$A6:DAB4 99 DC 00    STA $00DC,y[$7E:00DC]
$A6:DAB7 A9 80 00    LDA #$0080
$A6:DABA 99 D0 00    STA $00D0,y[$7E:00D0]
$A6:DABD 99 D7 00    STA $00D7,y[$7E:00D7]
$A6:DAC0 98          TYA
$A6:DAC1 18          CLC
$A6:DAC2 69 0E 00    ADC #$000E
$A6:DAC5 A8          TAY
$A6:DAC6 8C 30 03    STY $0330  [$7E:0330]
$A6:DAC9 A9 00 00    LDA #$0000
$A6:DACC 99 D0 00    STA $00D0,y[$7E:00DE]
$A6:DACF 60          RTS

$A6:DAD0             dw A980,AB80
$A6:DAD4             dw B880,B980
}


;;; $DAD8:  ;;;
{
; Drawing routine for Ridley's wings
$A6:DAD8 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:DADC F0 06       BEQ $06    [$DAE4]
$A6:DADE 3A          DEC A
$A6:DADF F0 20       BEQ $20    [$DB01]
$A6:DAE1 A9 0A 00    LDA #$000A

$A6:DAE4 18          CLC
$A6:DAE5 6F 0E 78 7E ADC $7E780E[$7E:780E]
$A6:DAE9 0A          ASL A
$A6:DAEA AA          TAX
$A6:DAEB BC 02 DB    LDY $DB02,x[$A6:DB0C]
$A6:DAEE AF 18 78 7E LDA $7E7818[$7E:7818]
$A6:DAF2 85 16       STA $16    [$7E:0016]
$A6:DAF4 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:DAF7 85 12       STA $12    [$7E:0012]
$A6:DAF9 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:DAFC 85 14       STA $14    [$7E:0014]
$A6:DAFE 4C 13 DC    JMP $DC13  [$A6:DC13]

$A6:DB01 60          RTS

$A6:DB02             dw DD4A, DD6A, DD85, DD96, DDA7, DDC2, DDA7, DD96, DD85, DD6A, DDE2, DE02, DE1D, DE2E, DE3F, DE5A,
                        DE3F, DE2E, DE1D, DE02
}


;;; $DB2A:  ;;;
{
; Draw tail
$A6:DB2A AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:DB2D 29 00 01    AND #$0100
$A6:DB30 F0 01       BEQ $01    [$DB33]
$A6:DB32 60          RTS

$A6:DB33 AF A4 20 7E LDA $7E20A4[$7E:20A4]
$A6:DB37 85 12       STA $12    [$7E:0012]
$A6:DB39 AF A6 20 7E LDA $7E20A6[$7E:20A6]
$A6:DB3D 85 14       STA $14    [$7E:0014]
$A6:DB3F AF A2 20 7E LDA $7E20A2[$7E:20A2]
$A6:DB43 18          CLC
$A6:DB44 6F 8E 20 7E ADC $7E208E[$7E:208E]
$A6:DB48 18          CLC
$A6:DB49 69 08 00    ADC #$0008
$A6:DB4C 29 F0 00    AND #$00F0
$A6:DB4F 4A          LSR A
$A6:DB50 4A          LSR A
$A6:DB51 4A          LSR A
$A6:DB52 AA          TAX
$A6:DB53 BC BA DC    LDY $DCBA,x[$A6:DCD0]
$A6:DB56 20 C2 DB    JSR $DBC2  [$A6:DBC2]
$A6:DB59 AF 92 20 7E LDA $7E2092[$7E:2092]
$A6:DB5D 85 14       STA $14    [$7E:0014]
$A6:DB5F AF 90 20 7E LDA $7E2090[$7E:2090]
$A6:DB63 85 12       STA $12    [$7E:0012]
$A6:DB65 A0 9E DC    LDY #$DC9E
$A6:DB68 20 C2 DB    JSR $DBC2  [$A6:DBC2]
$A6:DB6B AF 7C 20 7E LDA $7E207C[$7E:207C]
$A6:DB6F 85 12       STA $12    [$7E:0012]
$A6:DB71 AF 7E 20 7E LDA $7E207E[$7E:207E]
$A6:DB75 85 14       STA $14    [$7E:0014]
$A6:DB77 A0 9E DC    LDY #$DC9E
$A6:DB7A 20 C2 DB    JSR $DBC2  [$A6:DBC2]
$A6:DB7D AF 68 20 7E LDA $7E2068[$7E:2068]
$A6:DB81 85 12       STA $12    [$7E:0012]
$A6:DB83 AF 6A 20 7E LDA $7E206A[$7E:206A]
$A6:DB87 85 14       STA $14    [$7E:0014]
$A6:DB89 A0 97 DC    LDY #$DC97
$A6:DB8C 20 C2 DB    JSR $DBC2  [$A6:DBC2]
$A6:DB8F AF 54 20 7E LDA $7E2054[$7E:2054]
$A6:DB93 85 12       STA $12    [$7E:0012]
$A6:DB95 AF 56 20 7E LDA $7E2056[$7E:2056]
$A6:DB99 85 14       STA $14    [$7E:0014]
$A6:DB9B A0 97 DC    LDY #$DC97
$A6:DB9E 20 C2 DB    JSR $DBC2  [$A6:DBC2]
$A6:DBA1 AF 40 20 7E LDA $7E2040[$7E:2040]
$A6:DBA5 85 12       STA $12    [$7E:0012]
$A6:DBA7 AF 42 20 7E LDA $7E2042[$7E:2042]
$A6:DBAB 85 14       STA $14    [$7E:0014]
$A6:DBAD A0 90 DC    LDY #$DC90
$A6:DBB0 20 C2 DB    JSR $DBC2  [$A6:DBC2]
$A6:DBB3 AF 2C 20 7E LDA $7E202C[$7E:202C]
$A6:DBB7 85 12       STA $12    [$7E:0012]
$A6:DBB9 AF 2E 20 7E LDA $7E202E[$7E:202E]
$A6:DBBD 85 14       STA $14    [$7E:0014]
$A6:DBBF A0 90 DC    LDY #$DC90
}


;;; $DBC2:  ;;;
{
; General use draw, 7E7818 has pallete (wing/tail), Y is pointer to sprite data
$A6:DBC2 AF 18 78 7E LDA $7E7818[$7E:7818]
$A6:DBC6 85 16       STA $16    [$7E:0016]
$A6:DBC8 4C 13 DC    JMP $DC13  [$A6:DC13]
}


;;; $DBCB:  ;;;
{
; Calculate graphic to use.
; JSR to with an address (in ram) of a pointer followed by a counter,
; data at pointer (to rom) should be a counter (frame duration) followed by a graphic pointer,
; OR a pointer to code.
$A6:DBCB 85 00       STA $00    [$7E:0000]
$A6:DBCD 1A          INC A
$A6:DBCE 1A          INC A
$A6:DBCF 85 03       STA $03    [$7E:0003]
$A6:DBD1 E2 20       SEP #$20
$A6:DBD3 A9 7E       LDA #$7E
$A6:DBD5 85 02       STA $02    [$7E:0002]
$A6:DBD7 85 05       STA $05    [$7E:0005]
$A6:DBD9 C2 20       REP #$20
$A6:DBDB A7 00       LDA [$00]  [$7E:7806]
$A6:DBDD 30 02       BMI $02    [$DBE1]
$A6:DBDF 68          PLA
$A6:DBE0 60          RTS

$A6:DBE1 AA          TAX
$A6:DBE2 BD 00 00    LDA $0000,x[$A6:BF31]
$A6:DBE5 30 0D       BMI $0D    [$DBF4]
$A6:DBE7 C7 03       CMP [$03]  [$7E:7808]
$A6:DBE9 D0 1F       BNE $1F    [$DC0A]
$A6:DBEB E8          INX
$A6:DBEC E8          INX
$A6:DBED E8          INX
$A6:DBEE E8          INX

$A6:DBEF BD 00 00    LDA $0000,x[$A6:BF35]
$A6:DBF2 10 0A       BPL $0A    [$DBFE]

$A6:DBF4 85 06       STA $06    [$7E:0006]
$A6:DBF6 E8          INX
$A6:DBF7 E8          INX
$A6:DBF8 F4 EE DB    PEA $DBEE
$A6:DBFB 6C 06 00    JMP ($0006)[$A6:BFF2]

$A6:DBFE A9 01 00    LDA #$0001
$A6:DC01 87 03       STA [$03]  [$7E:7808]
$A6:DC03 8A          TXA
$A6:DC04 87 00       STA [$00]  [$7E:7806]
$A6:DC06 BC 02 00    LDY $0002,x[$A6:BF37]
$A6:DC09 60          RTS

$A6:DC0A A7 03       LDA [$03]  [$7E:7808]
$A6:DC0C 1A          INC A
$A6:DC0D 87 03       STA [$03]  [$7E:7808]
$A6:DC0F BC 02 00    LDY $0002,x[$A6:BF37]
$A6:DC12 60          RTS
}


;;; $DC13:  ;;;
{
; General use draw, $16 has pallete, Y is pointer to sprite data.
$A6:DC13 B9 00 00    LDA $0000,y[$A6:BFFD]
$A6:DC16 C8          INY
$A6:DC17 C8          INY
$A6:DC18 85 18       STA $18    [$7E:0018]
$A6:DC1A AE 90 05    LDX $0590  [$7E:0590]
$A6:DC1D 18          CLC

$A6:DC1E B9 01 00    LDA $0001,y[$A6:C000]
$A6:DC21 29 00 FF    AND #$FF00
$A6:DC24 10 03       BPL $03    [$DC29]
$A6:DC26 09 FF 00    ORA #$00FF

$A6:DC29 EB          XBA
$A6:DC2A 18          CLC
$A6:DC2B 65 14       ADC $14    [$7E:0014]
$A6:DC2D 38          SEC
$A6:DC2E ED 15 09    SBC $0915  [$7E:0915]
$A6:DC31 30 4F       BMI $4F    [$DC82]
$A6:DC33 C9 E0 00    CMP #$00E0
$A6:DC36 10 4A       BPL $4A    [$DC82]
$A6:DC38 85 1A       STA $1A    [$7E:001A]
$A6:DC3A B9 00 00    LDA $0000,y[$A6:BFFF]
$A6:DC3D 65 12       ADC $12    [$7E:0012]
$A6:DC3F 38          SEC
$A6:DC40 ED 11 09    SBC $0911  [$7E:0911]
$A6:DC43 9D 70 03    STA $0370,x[$7E:0370]
$A6:DC46 29 00 01    AND #$0100
$A6:DC49 F0 0E       BEQ $0E    [$DC59]
$A6:DC4B BF 9F 85 81 LDA $81859F,x[$81:859F]
$A6:DC4F 85 1C       STA $1C    [$7E:001C]
$A6:DC51 B2 1C       LDA ($1C)  [$7E:0570]
$A6:DC53 1F 9F 83 81 ORA $81839F,x[$81:839F]
$A6:DC57 92 1C       STA ($1C)  [$7E:0570]

$A6:DC59 B9 00 00    LDA $0000,y[$A6:BFFF]
$A6:DC5C 10 0E       BPL $0E    [$DC6C]
$A6:DC5E BF 9F 85 81 LDA $81859F,x[$81:85AF]
$A6:DC62 85 1C       STA $1C    [$7E:001C]
$A6:DC64 B2 1C       LDA ($1C)  [$7E:0570]
$A6:DC66 1F A1 83 81 ORA $8183A1,x[$81:83B1]
$A6:DC6A 92 1C       STA ($1C)  [$7E:0570]

$A6:DC6C A5 1A       LDA $1A    [$7E:001A]
$A6:DC6E 9D 71 03    STA $0371,x[$7E:0371]
$A6:DC71 B9 03 00    LDA $0003,y[$A6:C002]
$A6:DC74 05 16       ORA $16    [$7E:0016]
$A6:DC76 9D 72 03    STA $0372,x[$7E:0372]
$A6:DC79 8A          TXA
$A6:DC7A 18          CLC
$A6:DC7B 69 04 00    ADC #$0004
$A6:DC7E 29 FF 01    AND #$01FF
$A6:DC81 AA          TAX

$A6:DC82 98          TYA
$A6:DC83 18          CLC
$A6:DC84 69 05 00    ADC #$0005
$A6:DC87 A8          TAY
$A6:DC88 C6 18       DEC $18    [$7E:0018]
$A6:DC8A D0 92       BNE $92    [$DC1E]
$A6:DC8C 8E 90 05    STX $0590  [$7E:0590]
$A6:DC8F 60          RTS
}


;;; $DC90: Spritemaps ;;;
{
$A6:DC90             dx 0001, C3F8,F8,31E0
$A6:DC97             dx 0001, C3F8,F8,31E2
$A6:DC9E             dx 0001, C3F8,F8,31E4
$A6:DCA5             dx 0001, C3F8,F8,71E0
$A6:DCAC             dx 0001, C3F8,F8,71E2
$A6:DCB3             dx 0001, C3F8,F8,71E4
}


;;; $DCBA: Spritemap pointers ;;;
{
$A6:DCBA             dw DD2E, DD27, DD20, DD19, DD12, DD0B, DD04, DCFD, DCF6, DCEF, DCE8, DCE1, DCDA, DD43, DD3C, DD35
}


;;; $DCDA: Spritemaps ;;;
{
$A6:DCDA             dx 0001, C3F0,F8,31E6
$A6:DCE1             dx 0001, C3F0,F4,31E8
$A6:DCE8             dx 0001, C3F2,F3,31EA
$A6:DCEF             dx 0001, C3F4,F0,31EC
$A6:DCF6             dx 0001, C3F8,F0,31EE
$A6:DCFD             dx 0001, C3FC,F0,71EC
$A6:DD04             dx 0001, C3FE,F3,71EA
$A6:DD0B             dx 0001, C200,F4,71E8
$A6:DD12             dx 0001, C200,F8,71E6
$A6:DD19             dx 0001, C200,FC,F1E8
$A6:DD20             dx 0001, C3FE,FE,F1EA
$A6:DD27             dx 0001, C3FC,00,F1EC
$A6:DD2E             dx 0001, C3F9,00,F1EE
$A6:DD35             dx 0001, C3F4,FF,B1EC
$A6:DD3C             dx 0001, C3F2,FE,B1EA
$A6:DD43             dx 0001, C3F0,FC,B1E8

$A6:DD4A             dx 0006, 002C,D7,3108, 000C,EF,3128, C21C,DF,3116, C20C,DF,3114, C21C,D7,3106, C20C,D7,3104
$A6:DD6A             dx 0005, 002C,E4,311D, C21C,E4,311B, C20C,E4,3119, C21C,DC,310B, C20C,DC,3109
$A6:DD85             dx 0003, 002C,F0,3148, C21C,E8,3136, C20C,E8,3134
$A6:DD96             dx 0003, 002C,E8,B148, C21C,E8,B136, C20C,E8,B134
$A6:DDA7             dx 0005, 002C,F2,B11D, C21C,EA,B11B, C20C,EA,B119, C21C,F2,B10B, C20C,F2,B109
$A6:DDC2             dx 0006, 002C,FF,B108, 000C,E7,B128, C21C,EF,B116, C20C,EF,B114, C21C,F7,B106, C20C,F7,B104
$A6:DDE2             dx 0006, 01CC,D7,7108, 01EC,EF,7128, C3D4,DF,7116, C3E4,DF,7114, C3D4,D7,7106, C3E4,D7,7104
$A6:DE02             dx 0005, 01CC,E4,711D, C3D4,E4,711B, C3E4,E4,7119, C3D4,DC,710B, C3E4,DC,7109
$A6:DE1D             dx 0003, 01CC,F0,7148, C3D4,E8,7136, C3E4,E8,7134
$A6:DE2E             dx 0003, 01CC,E8,F148, C3D4,E8,F136, C3E4,E8,F134
$A6:DE3F             dx 0005, 01CC,F2,F11D, C3D4,EA,F11B, C3E4,EA,F119, C3D4,F2,F10B, C3E4,F2,F109
$A6:DE5A             dx 0006, 01CC,FF,F108, 01EC,E7,F128, C3D4,EF,F116, C3E4,EF,F114, C3D4,F7,F106, C3E4,F7,F104
}


;;; $DE7A:  ;;;
{
; Checks if Ridley is on screen
$A6:DE7A AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A6:DE7D 30 25       BMI $25    [$DEA4]
$A6:DE7F 18          CLC
$A6:DE80 69 20 00    ADC #$0020
$A6:DE83 38          SEC
$A6:DE84 ED 15 09    SBC $0915  [$7E:0915]
$A6:DE87 30 1B       BMI $1B    [$DEA4]
$A6:DE89 C9 20 01    CMP #$0120
$A6:DE8C 10 16       BPL $16    [$DEA4]
$A6:DE8E AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A6:DE91 30 11       BMI $11    [$DEA4]
$A6:DE93 18          CLC
$A6:DE94 69 20 00    ADC #$0020
$A6:DE97 38          SEC
$A6:DE98 ED 11 09    SBC $0911  [$7E:0911]
$A6:DE9B 30 07       BMI $07    [$DEA4]
$A6:DE9D C9 40 01    CMP #$0140
$A6:DEA0 10 02       BPL $02    [$DEA4]
$A6:DEA2 18          CLC
$A6:DEA3 60          RTS

$A6:DEA4 38          SEC
$A6:DEA5 60          RTS
}


;;; $DEA6:  ;;;
{
; Check Tail/Projectile collisions
$A6:DEA6 AD CE 0C    LDA $0CCE  [$7E:0CCE]
$A6:DEA9 D0 02       BNE $02    [$DEAD]
$A6:DEAB 18          CLC
$A6:DEAC 60          RTS

$A6:DEAD A0 00 00    LDY #$0000

$A6:DEB0 B9 18 0C    LDA $0C18,y[$7E:0C18]
$A6:DEB3 10 35       BPL $35    [$DEEA]
$A6:DEB5 EB          XBA
$A6:DEB6 29 0F 00    AND #$000F
$A6:DEB9 C9 03 00    CMP #$0003
$A6:DEBC 10 2C       BPL $2C    [$DEEA]
$A6:DEBE B9 64 0B    LDA $0B64,y[$7E:0B64]
$A6:DEC1 38          SEC
$A6:DEC2 E5 12       SBC $12    [$7E:0012]
$A6:DEC4 10 04       BPL $04    [$DECA]
$A6:DEC6 49 FF FF    EOR #$FFFF
$A6:DEC9 1A          INC A

$A6:DECA 38          SEC
$A6:DECB F9 B4 0B    SBC $0BB4,y[$7E:0BB4]
$A6:DECE 90 04       BCC $04    [$DED4]
$A6:DED0 C5 16       CMP $16    [$7E:0016]
$A6:DED2 B0 16       BCS $16    [$DEEA]

$A6:DED4 B9 78 0B    LDA $0B78,y[$7E:0B78]
$A6:DED7 38          SEC
$A6:DED8 E5 14       SBC $14    [$7E:0014]
$A6:DEDA 10 04       BPL $04    [$DEE0]
$A6:DEDC 49 FF FF    EOR #$FFFF
$A6:DEDF 1A          INC A

$A6:DEE0 38          SEC
$A6:DEE1 F9 C8 0B    SBC $0BC8,y[$7E:0BC8]
$A6:DEE4 90 0D       BCC $0D    [$DEF3]
$A6:DEE6 C5 18       CMP $18    [$7E:0018]
$A6:DEE8 90 09       BCC $09    [$DEF3]

$A6:DEEA C8          INY
$A6:DEEB C8          INY
$A6:DEEC C0 0A 00    CPY #$000A
$A6:DEEF 30 BF       BMI $BF    [$DEB0]
$A6:DEF1 18          CLC
$A6:DEF2 60          RTS

$A6:DEF3 A5 12       LDA $12    [$7E:0012]
$A6:DEF5 99 64 0B    STA $0B64,y[$7E:0B64]
$A6:DEF8 A5 14       LDA $14    [$7E:0014]
$A6:DEFA 99 78 0B    STA $0B78,y[$7E:0B78]
$A6:DEFD B9 04 0C    LDA $0C04,y[$7E:0C04]
$A6:DF00 09 10 00    ORA #$0010
$A6:DF03 99 04 0C    STA $0C04,y[$7E:0C04]
$A6:DF06 38          SEC
$A6:DF07 60          RTS
}


;;; $DF08:  ;;;
{
$A6:DF08 B9 04 0C    LDA $0C04,y
$A6:DF0B 29 0F 00    AND #$000F
$A6:DF0E C9 07 00    CMP #$0007
$A6:DF11 D0 05       BNE $05    [$DF18]
$A6:DF13 A9 01 00    LDA #$0001
$A6:DF16 80 0D       BRA $0D    [$DF25]

$A6:DF18 C9 02 00    CMP #$0002
$A6:DF1B D0 05       BNE $05    [$DF22]
$A6:DF1D A9 08 00    LDA #$0008
$A6:DF20 80 03       BRA $03    [$DF25]

$A6:DF22 A9 05 00    LDA #$0005

$A6:DF25 99 04 0C    STA $0C04,y
$A6:DF28 60          RTS
}


;;; $DF29:  ;;;
{
; Efficient collision detection for Samus and $12/$14 (size of $12/$14 is $16/$18). SEC if collision
$A6:DF29 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:DF2C 38          SEC
$A6:DF2D E5 12       SBC $12    [$7E:0012]
$A6:DF2F 10 04       BPL $04    [$DF35]
$A6:DF31 49 FF FF    EOR #$FFFF
$A6:DF34 1A          INC A

$A6:DF35 38          SEC
$A6:DF36 ED FE 0A    SBC $0AFE  [$7E:0AFE]
$A6:DF39 90 04       BCC $04    [$DF3F]
$A6:DF3B C5 16       CMP $16    [$7E:0016]
$A6:DF3D B0 16       BCS $16    [$DF55]

$A6:DF3F AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A6:DF42 38          SEC
$A6:DF43 E5 14       SBC $14    [$7E:0014]
$A6:DF45 10 04       BPL $04    [$DF4B]
$A6:DF47 49 FF FF    EOR #$FFFF
$A6:DF4A 1A          INC A

$A6:DF4B 38          SEC
$A6:DF4C ED 00 0B    SBC $0B00  [$7E:0B00]
$A6:DF4F 90 06       BCC $06    [$DF57]
$A6:DF51 C5 18       CMP $18    [$7E:0018]
$A6:DF53 90 02       BCC $02    [$DF57]

$A6:DF55 18          CLC
$A6:DF56 60          RTS

$A6:DF57 38          SEC
$A6:DF58 60          RTS
$A6:DF59 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal enemy touch AI - no death check
$A6:DF5D 4C B6 DF    JMP $DFB6  [$A6:DFB6]
}


;;; $DF60:  ;;;
{
$A6:DF60 20 66 DF    JSR $DF66  [$A6:DF66]
$A6:DF63 4C B6 DF    JMP $DFB6  [$A6:DFB6]
$A6:DF66 22 53 D4 A6 JSL $A6D453[$A6:D453]
$A6:DF6A A9 60 00    LDA #$0060
$A6:DF6D 8D A8 18    STA $18A8  [$7E:18A8]
$A6:DF70 A9 05 00    LDA #$0005
$A6:DF73 8D AA 18    STA $18AA  [$7E:18AA]
$A6:DF76 A0 00 00    LDY #$0000
$A6:DF79 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:DF7C AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:DF7F 38          SEC
$A6:DF80 FD 7A 0F    SBC $0F7A,x
$A6:DF83 30 01       BMI $01    [$DF86]
$A6:DF85 C8          INY

$A6:DF86 8C 54 0A    STY $0A54  [$7E:0A54]
$A6:DF89 60          RTS
}


;;; $DF8A: Enemy shot - enemy $E13F/$E17F (Ridley) ;;;
{
$A6:DF8A AD 9F 07    LDA $079F  [$7E:079F]
$A6:DF8D C9 02 00    CMP #$0002
$A6:DF90 F0 1A       BEQ $1A    [$DFAC]
$A6:DF92 A0 0D 00    LDY #$000D
$A6:DF95 AD 9C 0F    LDA $0F9C  [$7E:0F9C]
$A6:DF98 F0 04       BEQ $04    [$DF9E]
$A6:DF9A 4A          LSR A
$A6:DF9B 90 01       BCC $01    [$DF9E]
$A6:DF9D C8          INY

$A6:DF9E 8C 9C 0F    STY $0F9C  [$7E:0F9C]
$A6:DFA1 AF 1A 78 7E LDA $7E781A[$7E:781A]
$A6:DFA5 1A          INC A
$A6:DFA6 8F 1A 78 7E STA $7E781A[$7E:781A]
$A6:DFAA 80 0A       BRA $0A    [$DFB6]

$A6:DFAC 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A6:DFB0 80 04       BRA $04    [$DFB6]
}


;;; $DFB2: Power bomb reaction - enemy $E13F/$E17F (Ridley) ;;;
{
$A6:DFB2 22 B7 A5 A0 JSL $A0A5B7[$A0:A5B7]  ; Normal enemy power bomb AI - no death check
}


;;; $DFB6: Ridley reaction ;;;
{
$A6:DFB6 6B          RTL
}


;;; $DFB7:  ;;;
{
; Set 7802 to dead, disable Samus/Ridley interaction, next AI script is C538
$A6:DFB7 AD 8C 0F    LDA $0F8C  [$7E:0F8C]
$A6:DFBA D0 1C       BNE $1C    [$DFD8]
$A6:DFBC AF 02 78 7E LDA $7E7802[$7E:7802]
$A6:DFC0 30 16       BMI $16    [$DFD8]
$A6:DFC2 A9 FF FF    LDA #$FFFF
$A6:DFC5 8F 02 78 7E STA $7E7802[$7E:7802]
$A6:DFC9 AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:DFCC 09 00 04    ORA #$0400
$A6:DFCF 8D 86 0F    STA $0F86  [$7E:0F86]
$A6:DFD2 A9 38 C5    LDA #$C538
$A6:DFD5 8D A8 0F    STA $0FA8  [$7E:0FA8]

$A6:DFD8 6B          RTL
}


;;; $DFD9:  ;;;
{
; Tail/Samus interaction
$A6:DFD9 A9 0E 00    LDA #$000E
$A6:DFDC 85 16       STA $16    [$7E:0016]
$A6:DFDE 85 18       STA $18    [$7E:0018]
$A6:DFE0 AF A4 20 7E LDA $7E20A4[$7E:20A4]
$A6:DFE4 85 12       STA $12    [$7E:0012]
$A6:DFE6 AF A6 20 7E LDA $7E20A6[$7E:20A6]
$A6:DFEA 85 14       STA $14    [$7E:0014]
$A6:DFEC 20 29 DF    JSR $DF29  [$A6:DF29]
$A6:DFEF 90 29       BCC $29    [$E01A]
$A6:DFF1 AF 38 78 7E LDA $7E7838[$7E:7838]  ;\
$A6:DFF5 22 5E A4 A0 JSL $A0A45E[$A0:A45E]  ;} Deal [$7E:7838] suit-adjusted damage to Samus
$A6:DFF9 22 51 DF 91 JSL $91DF51[$91:DF51]  ;/
$A6:DFFD A9 60 00    LDA #$0060
$A6:E000 8D A8 18    STA $18A8  [$7E:18A8]
$A6:E003 A9 05 00    LDA #$0005
$A6:E006 8D AA 18    STA $18AA  [$7E:18AA]
$A6:E009 A0 00 00    LDY #$0000
$A6:E00C AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:E00F 38          SEC
$A6:E010 EF A4 20 7E SBC $7E20A4[$7E:20A4]
$A6:E014 30 01       BMI $01    [$E017]
$A6:E016 C8          INY

$A6:E017 8C 54 0A    STY $0A54  [$7E:0A54]

$A6:E01A 60          RTS
}


;;; $E01B:  ;;;
{
$A6:E01B AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:E01E AD 64 0B    LDA $0B64  [$7E:0B64]  ;\
$A6:E021 38          SEC                    ;|
$A6:E022 FD 7A 0F    SBC $0F7A,x            ;|
$A6:E025 85 12       STA $12    [$7E:0012]  ;|
$A6:E027 AD 78 0B    LDA $0B78  [$7E:0B78]  ;} A = angle from enemy to projectile 0
$A6:E02A 38          SEC                    ;|
$A6:E02B FD 7E 0F    SBC $0F7E,x            ;|
$A6:E02E 85 14       STA $14    [$7E:0014]  ;|
$A6:E030 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A6:E034 38          SEC
$A6:E035 E9 80 00    SBC #$0080
$A6:E038 49 FF FF    EOR #$FFFF
$A6:E03B 1A          INC A
$A6:E03C 18          CLC
$A6:E03D 69 80 00    ADC #$0080
$A6:E040 29 FF 00    AND #$00FF
$A6:E043 85 12       STA $12    [$7E:0012]
$A6:E045 AD A6 18    LDA $18A6  [$7E:18A6]
$A6:E048 0A          ASL A
$A6:E049 AA          TAX
$A6:E04A BD 2C 0C    LDA $0C2C,x
$A6:E04D 0A          ASL A
$A6:E04E 0A          ASL A
$A6:E04F C9 00 03    CMP #$0300
$A6:E052 90 03       BCC $03    [$E057]
$A6:E054 A9 00 03    LDA #$0300

$A6:E057 48          PHA
$A6:E058 22 6C C2 86 JSL $86C26C[$86:C26C]
$A6:E05C 85 12       STA $12    [$7E:0012]
$A6:E05E AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:E061 5D AA 0F    EOR $0FAA,x
$A6:E064 10 09       BPL $09    [$E06F]
$A6:E066 A5 12       LDA $12    [$7E:0012]
$A6:E068 18          CLC
$A6:E069 7D AA 0F    ADC $0FAA,x
$A6:E06C 9D AA 0F    STA $0FAA,x

$A6:E06F 68          PLA
$A6:E070 22 72 C2 86 JSL $86C272[$86:C272]
$A6:E074 85 12       STA $12    [$7E:0012]
$A6:E076 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:E079 5D AC 0F    EOR $0FAC,x
$A6:E07C 10 09       BPL $09    [$E087]
$A6:E07E A5 12       LDA $12    [$7E:0012]
$A6:E080 18          CLC
$A6:E081 7D AC 0F    ADC $0FAC,x
$A6:E084 9D AC 0F    STA $0FAC,x

$A6:E087 60          RTS
}


;;; $E088:  ;;;
{
; Tail tip kills projectiles
$A6:E088 AD 86 0F    LDA $0F86  [$7E:0F86]
$A6:E08B 29 00 04    AND #$0400
$A6:E08E F0 01       BEQ $01    [$E091]
$A6:E090 60          RTS

$A6:E091 A9 0E 00    LDA #$000E
$A6:E094 85 16       STA $16    [$7E:0016]
$A6:E096 85 18       STA $18    [$7E:0018]
$A6:E098 AF A4 20 7E LDA $7E20A4[$7E:20A4]
$A6:E09C 85 12       STA $12    [$7E:0012]
$A6:E09E AF A6 20 7E LDA $7E20A6[$7E:20A6]
$A6:E0A2 85 14       STA $14    [$7E:0014]
$A6:E0A4 20 A6 DE    JSR $DEA6  [$A6:DEA6]
$A6:E0A7 B0 7D       BCS $7D    [$E126]
$A6:E0A9 A9 0A 00    LDA #$000A
$A6:E0AC 85 16       STA $16    [$7E:0016]
$A6:E0AE 85 18       STA $18    [$7E:0018]
$A6:E0B0 AF 90 20 7E LDA $7E2090[$7E:2090]
$A6:E0B4 85 12       STA $12    [$7E:0012]
$A6:E0B6 AF 92 20 7E LDA $7E2092[$7E:2092]
$A6:E0BA 85 14       STA $14    [$7E:0014]
$A6:E0BC 20 A6 DE    JSR $DEA6  [$A6:DEA6]
$A6:E0BF B0 65       BCS $65    [$E126]
$A6:E0C1 60          RTS
}


;;; $E0C2:  ;;;
{
$A6:E0C2 AF 7C 20 7E LDA $7E207C[$7E:207C]
$A6:E0C6 85 12       STA $12    [$7E:0012]
$A6:E0C8 AF 7E 20 7E LDA $7E207E[$7E:207E]
$A6:E0CC 85 14       STA $14    [$7E:0014]
$A6:E0CE 20 A6 DE    JSR $DEA6  [$A6:DEA6]
$A6:E0D1 B0 53       BCS $53    [$E126]
$A6:E0D3 A9 0B 00    LDA #$000B
$A6:E0D6 85 16       STA $16    [$7E:0016]
$A6:E0D8 85 18       STA $18    [$7E:0018]
$A6:E0DA AF 68 20 7E LDA $7E2068[$7E:2068]
$A6:E0DE 85 12       STA $12    [$7E:0012]
$A6:E0E0 AF 6A 20 7E LDA $7E206A[$7E:206A]
$A6:E0E4 85 14       STA $14    [$7E:0014]
$A6:E0E6 20 A6 DE    JSR $DEA6  [$A6:DEA6]
$A6:E0E9 B0 3B       BCS $3B    [$E126]
$A6:E0EB AF 54 20 7E LDA $7E2054[$7E:2054]
$A6:E0EF 85 12       STA $12    [$7E:0012]
$A6:E0F1 AF 56 20 7E LDA $7E2056[$7E:2056]
$A6:E0F5 85 14       STA $14    [$7E:0014]
$A6:E0F7 20 A6 DE    JSR $DEA6  [$A6:DEA6]
$A6:E0FA B0 2A       BCS $2A    [$E126]
$A6:E0FC A9 0D 00    LDA #$000D
$A6:E0FF 85 16       STA $16    [$7E:0016]
$A6:E101 85 18       STA $18    [$7E:0018]
$A6:E103 AF 40 20 7E LDA $7E2040[$7E:2040]
$A6:E107 85 12       STA $12    [$7E:0012]
$A6:E109 AF 42 20 7E LDA $7E2042[$7E:2042]
$A6:E10D 85 14       STA $14    [$7E:0014]
$A6:E10F 20 A6 DE    JSR $DEA6  [$A6:DEA6]
$A6:E112 B0 12       BCS $12    [$E126]
$A6:E114 AF 2C 20 7E LDA $7E202C[$7E:202C]
$A6:E118 85 12       STA $12    [$7E:0012]
$A6:E11A AF 2E 20 7E LDA $7E202E[$7E:202E]
$A6:E11E 85 14       STA $14    [$7E:0014]
$A6:E120 20 A6 DE    JSR $DEA6  [$A6:DEA6]
$A6:E123 B0 01       BCS $01    [$E126]
$A6:E125 60          RTS
}


;;; $E126:  ;;;
{
$A6:E126 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$A6:E129 85 12       STA $12    [$7E:0012]  ;} $12 = [projectile X position]
$A6:E12B B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$A6:E12E 85 14       STA $14    [$7E:0014]  ;} $14 = [projectile Y position]
$A6:E130 B9 19 0C    LDA $0C19,y[$7E:0C19]
$A6:E133 29 0F 00    AND #$000F
$A6:E136 A0 0C 00    LDY #$000C             ; A = Ch (smoke)
$A6:E139 3A          DEC A                  ;\
$A6:E13A D0 0A       BNE $0A    [$E146]     ;} If projectile is missile:
$A6:E13C A9 3D 00    LDA #$003D             ;\
$A6:E13F 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Dh, sound library 1, max queued sounds allowed = 6 (dud shot)
$A6:E143 A0 06 00    LDY #$0006             ; A = 6 (dud shot)

$A6:E146 98          TYA
$A6:E147 A0 09 E5    LDY #$E509             ;\
$A6:E14A 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A6:E14E 60          RTS
}


;;; $E14F: Palette - enemy $E13F/$E17F (Ridley) ;;;
{
$A6:E14F             dw 0000, 56BA, 41B2, 1447, 0403, 4E15, 3570, 24CB, 1868, 5E5F, 183F, 1014, 031F, 01DA, 00F5, 0C63
}


;;; $E16F: Palettes ;;;
{
$A6:E16F             dw 0000, 7E20, 6560, 2060, 1000, 7940, 5D00, 4CA0, 3CA0, 43FF, 0113, 000F, 175C, 0299, 01D6, 57E0
$A6:E18F             dw 0000, 6BF5, 06E1, 0641, 05A1, 5E5F, 183F, 1014, 080A, 0404, 4F9F, 3ED8, 2E12, 6F70, 7FFF, 5EE0
}


;;; $E1AF: Palette - enemy $E1BF (Ridley's explosion) ;;;
{
$A6:E1AF             dw 3800, 56BA, 41B2, 1447, 0403, 4E15, 3570, 24CB, 1868, 5E5F, 183F, 1014, 031F, 01DA, 00F5, 0C63
}


;;; $E1CF: Palettes ;;;
{
; Enemy $E1FF (Ceres steam) palette points to $E23F, right in the middle of this section...
$A6:E1CF             dw 3800, 6B5A, 5652, 28E7, 1863, 62B5, 4A10, 396B, 3129, 43FF, 0113, 000F, 175C, 0299, 01D6, 3BE0
$A6:E1EF             dw 3800, 6BF5, 06E1, 0641, 05A1, 5E5F, 183F, 1014, 080A, 0404, 4F9F, 3ED8, 2E12, 6F70, 7FFF, 5EE0

$A6:E20F             dw 6BF5, 06E1, 0641, 05A1, 5E5F, 183F, 1014, 080A, 0404, 4F9F, 3ED8, 2E12, 6F70, 7FFF, 5EE0
$A6:E22D             dw 77F8, 1344, 12A4, 1204, 6ABF, 249F, 1C77, 146D, 1067, 5BFF, 4B38, 3A72, 7BD3, 7FFF, 6B43
$A6:E24B             dw 7FFB, 1FA7, 1F07, 1E67, 771F, 30FF, 28DA, 20D0, 1CCA, 67FF, 579B, 46D5, 7BD6, 7FFF, 77A6
}


;;; $E269:  ;;;
{
$A6:E269             db 0F, 0E, 0D, 0C, 0B, 0A, 09, 08, 07, 06, 05, 04, 03, 02, 01, 00,
                        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
                        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
                        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
                        FF
}


;;; $E2AA:  ;;;
{
$A6:E2AA             dw 031F,01DA,00F5,
                        02DD,01B8,00D3,
                        029A,0196,00D2,
                        0278,0174,00B0,
                        0236,0153,00AF,
                        0214,0131,008E,
                        01D2,010F,008C,
                        0190,00ED,006B,
                        016E,00CC,0069,
                        012C,00AA,0048,
                        010A,0088,0047,
                        00C8,0067,0025,
                        0086,0045,0024,
                        0064,0023,0022,
                        0022,0021,0001,
                        0000,0000,0000
}


;;; $E30A:  ;;;
{
$A6:E30A             dw 0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0421,0401,0000,0000,0421,0001,0000,0000,0422,0002,0001,
                        0843,0822,0001,0000,0842,0422,0401,0001,0C44,0004,0002,
                        1085,0C43,0401,0000,0C64,0843,0422,0401,1066,0406,0004,
                        14A7,1064,0401,0000,1485,0C64,0823,0402,1888,0408,0405,
                        1CE8,1486,0402,0001,18A7,1065,0C43,0822,1CCA,080A,0406,
                        210A,18A7,0802,0001,1CC8,1486,0C44,0823,24EC,080C,0408,
                        252C,1CC8,0823,0001,20E9,18A7,1045,0823,290E,080E,0409,
                        2D6D,20E9,0823,0001,290B,1CA8,1065,0C24,3130,0C10,080A,
                        318F,24EA,0C24,0001,2D2C,1CC9,1466,0C24,3552,0C12,080C,
                        39D1,290C,0C24,0002,314E,20EA,1887,1045,3D94,1014,080D,
                        3DF3,2D2D,0C25,0002,396F,250B,1888,1045,41B6,1016,0C0E,
                        4214,314E,1025,0002,3D90,290C,1C88,1046,49D8,1018,0C10,
                        4A56,356F,1026,0002,41B2,2D2D,1CA9,1447,51FA,141A,0C11,
                        4E78,3D90,1026,0402,45F3,314F,20AA,1447,561D,143D,0C12,
                        56BA,41B2,1447,0403,4E15,3570,24CB,1868,5E5F,183F,1014
}


;;; $E46A:  ;;;
{
$A6:E46A             dw 4E7A,3D73,1449,0405,45D6,3151,20AD,184A,561F,183F,1015,02BF,019A,00D6,
                        4A5A,3973,142A,0407,45B6,3132,20AE,184B,51FF,183F,1015,029F,019A,00D6,
                        4A3B,3954,142B,0808,41B7,2D33,20AF,184C,4DDF,183F,1016,067F,057B,04B7
}


;;; $E4BE: Instruction ;;;
{
$A6:E4BE A9 59 00    LDA #$0059
$A6:E4C1 8F 1E 78 7E STA $7E781E[$7E:781E]
$A6:E4C5 22 CB 90 80 JSL $8090CB[$80:90CB]  ; Queue sound 59h, sound library 2, max queued sounds allowed = 6 (Ridley's roar)
$A6:E4C9 6B          RTL
}


;;; $E4CA: Instruction ;;;
{
$A6:E4CA A9 00 00    LDA #$0000
$A6:E4CD 8F 1E 78 7E STA $7E781E[$7E:781E]
$A6:E4D1 6B          RTL
}


;;; $E4D2: Instruction ;;;
{
; If in Norfair or Samus is below 30 health, go to next instruction. Else go to argument, and set main AI script timer to 8
$A6:E4D2 AD 9F 07    LDA $079F  [$7E:079F]
$A6:E4D5 C9 02 00    CMP #$0002
$A6:E4D8 F0 3A       BEQ $3A    [$E514]
$A6:E4DA AD C2 09    LDA $09C2  [$7E:09C2]
$A6:E4DD C9 1E 00    CMP #$001E
$A6:E4E0 10 32       BPL $32    [$E514]
$A6:E4E2 A9 08 00    LDA #$0008
$A6:E4E5 8F 00 78 7E STA $7E7800[$7E:7800]
}


;;; $E4E9: Instruction - go to [[Y]] ;;;
{
$A6:E4E9 B9 00 00    LDA $0000,y[$A6:E53A]
$A6:E4EC A8          TAY
$A6:E4ED 6B          RTL
}


;;; $E4EE: Instruction ;;;
{
$A6:E4EE AF 36 78 7E LDA $7E7836[$7E:7836]
$A6:E4F2 D0 F5       BNE $F5    [$E4E9]
$A6:E4F4 C8          INY
$A6:E4F5 C8          INY
$A6:E4F6 80 F1       BRA $F1    [$E4E9]
}


;;; $E4F8: Instruction ;;;
{
$A6:E4F8 AF 36 78 7E LDA $7E7836[$7E:7836]
$A6:E4FC F0 EB       BEQ $EB    [$E4E9]
$A6:E4FE C8          INY
$A6:E4FF C8          INY
$A6:E500 6B          RTL
}


;;; $E501: Instruction ;;;
{
$A6:E501 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A6:E504 8D 10 0B    STA $0B10  [$7E:0B10]
$A6:E507 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A6:E50A 8D 14 0B    STA $0B14  [$7E:0B14]
$A6:E50D B9 00 00    LDA $0000,y
$A6:E510 8F 3A 78 7E STA $7E783A[$7E:783A]
}


;;; $E514: Y += 2 ;;;
{
$A6:E514 C8          INY
$A6:E515 C8          INY
$A6:E516 6B          RTL
}


;;; $E517: Instruction ;;;
{
; Move on to next command if Ridley is facing left, else go to argument.
$A6:E517 AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:E51B F0 F7       BEQ $F7    [$E514]
$A6:E51D 80 CA       BRA $CA    [$E4E9]
}


;;; $E51F: Instruction ;;;
{
; Add the following bytes to Ridley's X / Y position
$A6:E51F B9 00 00    LDA $0000,y[$A6:E927]
$A6:E522 18          CLC
$A6:E523 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A6:E526 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A6:E529 B9 02 00    LDA $0002,y[$A6:E929]
$A6:E52C 18          CLC
$A6:E52D 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A6:E530 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A6:E533 C8          INY
$A6:E534 C8          INY
$A6:E535 C8          INY
$A6:E536 C8          INY
$A6:E537 6B          RTL
}


;;; $E538..E71B: Instruction lists ;;;
{
;;; $E538: Instruction list -  ;;;
{
; Initialization (draws and avoids crashing)
$A6:E538             dx E517,E542,  ; ???
                        000C,E983,
                        812F        ; Sleep
}


;;; $E542: Instruction list -  ;;;
{
$A6:E542             dx 000C,E9A5,
                        812F        ; Sleep
}


;;; $E548: Instruction list -  ;;;
{
$A6:E548             dx E517,E576,  ; ???
                        E501,0000,  ; ???
                        0004,E983,
                        E501,0002,  ; ???
                        0006,EA4F,
                        E501,0004,  ; ???
                        0050,EA71,
                        E501,0002,  ; ???
                        0006,EA4F,
                        E501,0000,  ; ???
                        0004,E983,
                        812F        ; Sleep
}


;;; $E576: Instruction list -  ;;;
{
$A6:E576             dx E501,0000,  ; ???
                        0004,E9A5,
                        E501,0002,  ; ???
                        0006,EA93,
                        E501,0004,  ; ???
                        0050,EAB5,
                        E501,0002,  ; ???
                        0006,EA93,
                        E501,0000,  ; ???
                        0004,E9A5,
                        812F        ; Sleep
}


;;; $E5A0: Instruction list -  ;;;
{
$A6:E5A0             dx E517,E5FE,  ; ???
                        E501,0000,  ; ???
                        0002,E983,
                        E4F8,E5B2,  ; ???
                        812F        ; Sleep
}


;;; $E5B2: Instruction list -  ;;;
{
$A6:E5B2             dx E501,0002,      ; ???
                        0003,EA4F,
                        E4F8,E5C8,      ; ???
                        0001,EA4F,
                        E4EE,E5BE,E5F4, ; ???
                        E501,0004,      ; ???
                        0004,EA71,
                        E4F8,E5DE,      ; ???
                        0001,EA71,
                        E4EE,E5D4,E5DE, ; ???
                        E501,0002,      ; ???
                        0003,EA4F,
                        E4F8,E5F4,      ; ???
                        0001,EA4F,
                        E4EE,E5EA,E5F4, ; ???
                        E501,0000,      ; ???
                        0002,E983,
                        812F            ; Sleep
}


;;; $E5FE: Instruction list -  ;;;
{
$A6:E5FE             dx E501,0000,  ; ???
                        0002,E9A5,
                        E4F8,E60C,  ; ???
                        812F        ; Sleep
}


;;; $E60C: Instruction list -  ;;;
{
$A6:E60C             dx E501,0002,      ; ???
                        0003,EA93,
                        E4F8,E622,      ; ???
                        0001,EA93,
                        E4EE,E618,E64E, ; ???
                        E501,0004,      ; ???
                        0004,EAB5,
                        E4F8,E638,      ; ???
                        0001,EA71,
                        E4EE,E62E,E638, ; ???
                        E501,0002,      ; ???
                        0003,EA93,
                        E4F8,E64E,      ; ???
                        0001,EA4F,
                        E4EE,E644,E64E, ; ???
                        E501,0000,      ; ???
                        0002,E9A5,
                        812F            ; Sleep
}


;;; $E658: Instruction list -  ;;;
{
$A6:E658             dx E517,E676,  ; ???
                        E501,0000,  ; ???
                        0004,E983,
                        E501,0002,  ; ???
                        0006,EA4F,
                        E501,0004,  ; ???
                        0001,EA71,
                        812F        ; Sleep
}


;;; $E676: Instruction list -  ;;;
{
$A6:E676             dx E501,0000,  ; ???
                        0004,E9A5,
                        E501,0002,  ; ???
                        0006,EA93,
                        E501,0004,  ; ???
                        0001,EAB5,
                        812F        ; Sleep
}


;;; $E690: Instruction list -  ;;;
{
; Opening roar and close mouth
$A6:E690             dx E517,E6AE,  ; ???
                        0006,E983,
                        E4BE,       ; ???
                        0008,E9C7,
                        0060,E9E9,
                        0008,E9C7,
                        E4CA,       ; ???
                        0001,E983,
                        812F        ; Sleep
}


;;; $E6AE: Instruction list -  ;;;
{
$A6:E6AE             dx 0006,E9A5,
                        E4BE,       ; ???
                        0008,EA0B,
                        0060,EA2D,
                        0008,EA0B,
                        E4CA,       ; ???
                        0001,E9A5,
                        812F        ; Sleep
}


;;; $E6C8: Instruction list -  ;;;
{
; Death roar
$A6:E6C8             dx E517,E6DE,  ; ???
                        0006,E983,
                        E4BE,       ; ???
                        0008,E9C7,
                        0010,E9E9,
                        E4CA,       ; ???
                        812F        ; Sleep
}


;;; $E6DE: Instruction list -  ;;;
{
$A6:E6DE             dx 0006,E9A5,
                        E4BE,       ; ???
                        0008,EA0B,
                        0010,EA2D,
                        E4CA,       ; ???
                        812F        ; Sleep
}


;;; $E6F0: Instruction list -  ;;;
{
; Turn from left to right
$A6:E6F0             dx E727,       ; ???
                        0001,E983,
                        0008,EAD7,
                        E72F,       ; ???
                        0001,EAD7,
                        0001,E9A5,
                        812F        ; Sleep
}


;;; $E706: Instruction list -  ;;;
{
; Turn from right to left
$A6:E706             dx E727,       ; ???
                        0001,E9A5,
                        0008,EAD7,
                        E71C,       ; ???
                        0001,EAD7,
                        0001,E983,
                        812F        ; Sleep
}
}


;;; $E71C: Instruction ;;;
{
; Set 7E:7820 to 0 (Ridley is facing left) and JSR to D3F9 (Updates a bunch of tail values.
; Includes JSR $D3B4: Copy 7 entries from (X) to 7E:(Y), 7E:(Y+14), 7E:(Y+28), 7E:(Y+3C), etc.)
$A6:E71C A9 00 00    LDA #$0000
$A6:E71F 8F 20 78 7E STA $7E7820[$7E:7820]
$A6:E723 20 F9 D3    JSR $D3F9  [$A6:D3F9]
$A6:E726 6B          RTL
}


;;; $E727: Instruction ;;;
{
; Set 7E:7820 to 1 (Ridley is facing forward / turning)
$A6:E727 A9 01 00    LDA #$0001
$A6:E72A 8F 20 78 7E STA $7E7820[$7E:7820]
$A6:E72E 6B          RTL
}


;;; $E72F: Instruction ;;;
{
; Set 7E:7820 to 2 (Ridley is facing right) and JSR to D3F9 (Updates a bunch of tail values.
; Includes JSR $D3B4: Copy 7 entries from (X) to 7E:(Y), 7E:(Y+14), 7E:(Y+28), 7E:(Y+3C), etc.)
$A6:E72F A9 02 00    LDA #$0002
$A6:E732 8F 20 78 7E STA $7E7820[$7E:7820]
$A6:E736 20 F9 D3    JSR $D3F9  [$A6:D3F9]
$A6:E739 6B          RTL
}


;;; $E73A: Instruction list -  ;;;
{
; Fireballing
$A6:E73A             dx E517,E7B4,  ; ???
                        E4D2,E7AC,  ; ???
                        0008,E983,
                        E4BE,       ; ???
                        0008,E9C7,
                        0002,E9E9,
                        E84D,       ; ???
                        E904,       ; ???
                        0005,E9E9,
                        E84D,       ; ???
                        E909,       ; ???
                        0005,E9E9,
                        E84D,       ; ???
                        E909,       ; ???
                        0005,E9E9,
                        E84D,       ; ???
                        E909,       ; ???
                        0030,E9E9,
                        0008,E9C7,
                        E4D2,E7AC,  ; ???
                        0020,E983,
                        E84D,       ; ???
                        E4BE,       ; ???
                        0008,E9C7,
                        0002,E9E9,
                        E84D,       ; ???
                        E904,       ; ???
                        0005,E9E9,
                        E84D,       ; ???
                        E909,       ; ???
                        0005,E9E9,
                        E84D,       ; ???
                        E909,       ; ???
                        0005,E9E9,
                        E84D,       ; ???
                        E909,       ; ???
                        0030,E9E9,
                        0008,E9C7,
                        E4CA,       ; ???
                        0001,E983,
                        812F        ; Sleep
}


;;; $E7B4: Instruction list -  ;;;
{
$A6:E7B4             dx E4D2,E820,  ; ???
                        0008,E9A5,
                        E4BE,       ; ???
                        0008,EA0B,
                        0002,EA2D,
                        E84D,       ; ???
                        E904,       ; ???
                        0005,EA2D,
                        E84D,       ; ???
                        E909,       ; ???
                        0005,EA2D,
                        E84D,       ; ???
                        E909,       ; ???
                        0005,EA2D,
                        E84D,       ; ???
                        E909,       ; ???
                        0030,EA2D,
                        0008,EA0B,
                        E4D2,E820,  ; ???
                        0020,E9A5,
                        E4BE,       ; ???
                        0008,EA0B,
                        0002,EA2D,
                        E84D,       ; ???
                        E904,       ; ???
                        0005,EA2D,
                        E84D,       ; ???
                        E909,       ; ???
                        0005,EA2D,
                        E84D,       ; ???
                        E909,       ; ???
                        0005,EA2D,
                        E84D,       ; ???
                        E909,       ; ???
                        0030,EA2D,
                        0008,EA0B,
                        E4CA,       ; ???
                        0001,E9A5,
                        812F        ; Sleep
}


;;; $E828: Unused ;;;
{
$A6:E828 A9 00 00    LDA #$0000
$A6:E82B 22 40 E8 A6 JSL $A6E840[$A6:E840]
$A6:E82F A9 01 00    LDA #$0001
$A6:E832 22 40 E8 A6 JSL $A6E840[$A6:E840]
$A6:E836 A9 02 00    LDA #$0002
$A6:E839 22 40 E8 A6 JSL $A6E840[$A6:E840]
$A6:E83D A9 03 00    LDA #$0003
}


;;; $E840:  ;;;
{
$A6:E840 8D B4 0F    STA $0FB4  [$7E:0FB4]
$A6:E843 5A          PHY
$A6:E844 A0 34 96    LDY #$9634             ;\
$A6:E847 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn enemy projectile $9634
$A6:E84B 7A          PLY
$A6:E84C 6B          RTL
}


;;; $E84D: Instruction ;;;
{
; Calculate fireball angle and X/Y speeds
$A6:E84D DA          PHX
$A6:E84E 5A          PHY
$A6:E84F AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:E853 D0 4C       BNE $4C    [$E8A1]
$A6:E855 A9 E7 FF    LDA #$FFE7             ;\
$A6:E858 18          CLC                    ;|
$A6:E859 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;|
$A6:E85C 85 12       STA $12    [$7E:0012]  ;|
$A6:E85E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$A6:E861 38          SEC                    ;|
$A6:E862 E5 12       SBC $12    [$7E:0012]  ;|
$A6:E864 85 12       STA $12    [$7E:0012]  ;|
$A6:E866 A9 D5 FF    LDA #$FFD5             ;} A = angle from enemy position - (19h, 2Bh) to Samus
$A6:E869 18          CLC                    ;|
$A6:E86A 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;|
$A6:E86D 85 14       STA $14    [$7E:0014]  ;|
$A6:E86F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A6:E872 38          SEC                    ;|
$A6:E873 E5 14       SBC $14    [$7E:0014]  ;|
$A6:E875 85 14       STA $14    [$7E:0014]  ;|
$A6:E877 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A6:E87B 38          SEC
$A6:E87C E9 80 00    SBC #$0080
$A6:E87F 49 FF FF    EOR #$FFFF
$A6:E882 1A          INC A
$A6:E883 29 FF 00    AND #$00FF
$A6:E886 C9 B0 00    CMP #$00B0
$A6:E889 B0 0A       BCS $0A    [$E895]
$A6:E88B C9 40 00    CMP #$0040
$A6:E88E 90 0A       BCC $0A    [$E89A]
$A6:E890 A9 B0 00    LDA #$00B0
$A6:E893 80 08       BRA $08    [$E89D]

$A6:E895 C9 EB 00    CMP #$00EB
$A6:E898 90 03       BCC $03    [$E89D]

$A6:E89A A9 EB 00    LDA #$00EB

$A6:E89D 85 12       STA $12    [$7E:0012]
$A6:E89F 80 4A       BRA $4A    [$E8EB]

$A6:E8A1 A9 19 00    LDA #$0019             ;\
$A6:E8A4 18          CLC                    ;|
$A6:E8A5 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;|
$A6:E8A8 85 12       STA $12    [$7E:0012]  ;|
$A6:E8AA AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$A6:E8AD 38          SEC                    ;|
$A6:E8AE E5 12       SBC $12    [$7E:0012]  ;|
$A6:E8B0 85 12       STA $12    [$7E:0012]  ;|
$A6:E8B2 A9 D5 FF    LDA #$FFD5             ;} A = angle from enemy position + (19h, -2Bh) to Samus
$A6:E8B5 18          CLC                    ;|
$A6:E8B6 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;|
$A6:E8B9 85 14       STA $14    [$7E:0014]  ;|
$A6:E8BB AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A6:E8BE 38          SEC                    ;|
$A6:E8BF E5 14       SBC $14    [$7E:0014]  ;|
$A6:E8C1 85 14       STA $14    [$7E:0014]  ;|
$A6:E8C3 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A6:E8C7 38          SEC
$A6:E8C8 E9 80 00    SBC #$0080
$A6:E8CB 49 FF FF    EOR #$FFFF
$A6:E8CE 1A          INC A
$A6:E8CF 29 FF 00    AND #$00FF
$A6:E8D2 C9 50 00    CMP #$0050
$A6:E8D5 90 0A       BCC $0A    [$E8E1]
$A6:E8D7 C9 C0 00    CMP #$00C0
$A6:E8DA B0 0A       BCS $0A    [$E8E6]
$A6:E8DC A9 50 00    LDA #$0050
$A6:E8DF 80 08       BRA $08    [$E8E9]

$A6:E8E1 C9 15 00    CMP #$0015
$A6:E8E4 B0 03       BCS $03    [$E8E9]

$A6:E8E6 A9 15 00    LDA #$0015

$A6:E8E9 85 12       STA $12    [$7E:0012]

$A6:E8EB A9 00 05    LDA #$0500
$A6:E8EE 22 6C C2 86 JSL $86C26C[$86:C26C]
$A6:E8F2 8F 32 78 7E STA $7E7832[$7E:7832]
$A6:E8F6 A9 00 05    LDA #$0500
$A6:E8F9 22 72 C2 86 JSL $86C272[$86:C272]
$A6:E8FD 8F 34 78 7E STA $7E7834[$7E:7834]
$A6:E901 7A          PLY
$A6:E902 FA          PLX
$A6:E903 6B          RTL
}


;;; $E904: Instruction ;;;
{
; Fires lead fireball
$A6:E904 A9 00 00    LDA #$0000
$A6:E907 80 03       BRA $03    [$E90C]
}


;;; $E909: Instruction ;;;
{
; Fires following fireball
$A6:E909 A9 0E 00    LDA #$000E
}


;;; $E90C:  ;;;
{
$A6:E90C 8D 95 19    STA $1995  [$7E:1995]
$A6:E90F AF 20 78 7E LDA $7E7820[$7E:7820]
$A6:E913 5A          PHY
$A6:E914 A0 42 96    LDY #$9642             ;\
$A6:E917 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Ridley's fireball enemy projectile
$A6:E91B 7A          PLY
$A6:E91C 6B          RTL
}


;;; $E91D: Instruction list -  ;;;
{
; Fly up and start main AI, I guess
$A6:E91D             dx E517,E945,      ; ???
                        0003,E983,
                        E51F,0001,FFF4, ; ???
                        0004,EA4F,
                        E51F,FFFC,FFF8, ; ???
                        0005,EA71,
                        E969,           ; ???
                        0011,EA4F,
                        0011,E983,
                        812F            ; Sleep
}


;;; $E945: Instruction list -  ;;;
{
$A6:E945             dx 0003,E9A5,
                        E51F,FFFF,FFF4, ; ???
                        0004,EA93,
                        E51F,0004,FFF8, ; ???
                        0005,EAB5,
                        E976,           ; ???
                        0011,EA93,
                        0011,E9A5,
                        812F            ; Sleep
}


;;; $E969: Instruction ;;;
{
; Set Ridley's main AI to A6AF, and vertical speed to FEA0. (Ceres)
$A6:E969 A9 AF A6    LDA #$A6AF
$A6:E96C 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:E96F A9 A0 FE    LDA #$FEA0
$A6:E972 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:E975 6B          RTL
}


;;; $E976: Instruction ;;;
{
; Set Ridley's main AI to B2F3, and vertical speed to FEA0. (Norfair)
$A6:E976 A9 F3 B2    LDA #$B2F3
$A6:E979 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A6:E97C A9 A0 FE    LDA #$FEA0
$A6:E97F 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:E982 6B          RTL
}


;;; $E983: Ridley extended spritemaps ;;;
{
; Ridley facing left
$A6:E983             dx 0004, 000F,0016,ED29,EB2F, FFF8,0007,ED8E,EB59, 0010,0000,ED95,EB67, FFFD,FFE8,EC5B,EAE1

; Ridley facing right
$A6:E9A5             dx 0004, FFF1,0016,EF25,EBF9, 0008,0007,EF8A,EC23, FFF0,0000,EF91,EC31, 0003,FFE8,EE57,EBAB

; Ridley facing left, mouth half open
$A6:E9C7             dx 0004, 000F,0016,ED29,EB2F, FFF8,0007,ED8E,EB59, 0010,0000,ED95,EB67, FFFD,FFE8,EC99,EAFB

; Ridley facing left, mouth open
$A6:E9E9             dx 0004, 000F,0016,ED29,EB2F, FFF8,0007,ED8E,EB59, 0010,0000,ED95,EB67, FFFD,FFE8,ECDC,EB15

; Ridley facing right, mouth half open
$A6:EA0B             dx 0004, FFF1,0016,EF25,EBF9, 0008,0007,EF8A,EC23, FFF0,0000,EF91,EC31, 0003,FFE8,EE95,EBC5

; Ridley facing right, mouth open
$A6:EA2D             dx 0004, FFF1,0016,EF25,EBF9, 0008,0007,EF8A,EC23, FFF0,0000,EF91,EC31, 0003,FFE8,EED8,EBDF

; Ridley facing left, legs half extended
$A6:EA4F             dx 0004, 000F,0016,ED4E,EB3D, FFF8,0007,ED8E,EB59, 0010,0000,ED95,EB67, FFFD,FFE8,EC5B,EAE1

; Ridley facing left, legs extended
$A6:EA71             dx 0004, 000F,0016,ED6E,EB4B, FFF8,0007,ED8E,EB59, 0010,0000,ED95,EB67, FFFD,FFE8,EC5B,EAE1

; Ridley facing right, legs half extended
$A6:EA93             dx 0004, FFF1,0016,EF4A,EC07, 0008,0007,EF8A,EC23, FFF0,0000,EF91,EC31, 0003,FFE8,EE57,EBAB

; Ridley facing right, legs extended
$A6:EAB5             dx 0004, FFF1,0016,EF6A,EC15, 0008,0007,EF8A,EC23, FFF0,0000,EF91,EC31, 0003,FFE8,EE57,EBAB

; Ridley facing forward
$A6:EAD7             dx 0001, 0000,FFFA,EDB5,EB91
}


;;; $EAE1: Ridley hitboxes ;;;
{
$A6:EAE1             dx 0002, FFF4,FFE6,000B,000D,DF59,DF8A, FFE8,0003,FFF3,0015,DF59,DF8A
$A6:EAFB             dx 0002, FFD7,FFED,FFEB,FFF7,DF59,DF8A, FFEC,FFE3,000B,0005,DF59,DF8A
$A6:EB15             dx 0002, FFDB,FFD8,FFF2,FFE1,DF59,DF8A, FFE7,FFE1,0009,0006,DF59,DF8A
$A6:EB2F             dx 0001, FFF1,FFF6,0007,0002,DF59,DF8A
$A6:EB3D             dx 0001, FFEF,FFF7,0006,000F,DF59,DF8A
$A6:EB4B             dx 0001, FFF2,FFFF,000A,0017,DF59,DF8A
$A6:EB59             dx 0001, FFF1,FFFE,FFFF,0008,DF59,DF8A
$A6:EB67             dx 0001, FFF0,FFEC,000C,0015,DF59,DF8A
$A6:EB75             dx 0001, FFF0,FFEC,000C,0015,DF59,DF8A
$A6:EB83             dx 0001, FFF0,FFEC,000C,0015,DF59,DF8A
$A6:EB91             dx 0002, FFF0,FFE0,0010,0022,DF59,DF8A, FFF8,FFD3,0008,FFDF,DF59,DF8A
$A6:EBAB             dx 0002, FFF4,FFE7,000B,000D,DF59,DF8A, 000C,0005,0018,0014,DF59,DF8A
$A6:EBC5             dx 0002, FFF3,FFE3,0014,0005,DF59,DF8A, 0015,FFEE,0027,FFF8,DF59,DF8A
$A6:EBDF             dx 0002, FFF6,FFE1,0019,0008,DF59,DF8A, 000D,FFD6,0023,FFE0,DF59,DF8A
$A6:EBF9             dx 0001, FFF6,FFF6,0011,0002,DF59,DF8A
$A6:EC07             dx 0001, FFF7,FFF8,0011,000F,DF59,DF8A
$A6:EC15             dx 0001, FFF5,FFF8,000E,0017,DF59,DF8A
$A6:EC23             dx 0001, 0001,FFFE,000E,0009,DF59,DF8A
$A6:EC31             dx 0001, FFF3,FFEA,000E,0015,DF59,DF8A
$A6:EC3F             dx 0001, FFF3,FFEA,000E,0015,DF59,DF8A
$A6:EC4D             dx 0001, FFF3,FFEA,000E,0015,DF59,DF8A
}


;;; $EC5B: Ridley spritemaps ;;;
{
$A6:EC5B             dx 000C, 01E4,12,3154, 0004,0A,3159, 0004,02,3149, 01FC,0A,317B, 01F4,0A,317A, 01FC,02,316B, 01F4,02,316A, 81E4,02,3168, 81FC,F2,3166, 81EC,F2,3164, 8004,E2,3162, 81F4,E2,3160
$A6:EC99             dx 000D, 0006,F0,314A, 01F6,08,31BB, 01F6,00,313D, 0006,F8,315A, 81FE,00,3188, 81F6,F0,3186, 01EE,00,3156, 01E6,00,3155, 81E6,F0,3184, 8006,E0,3182, 81F6,E0,3180, 81E6,E0,316E, 81D6,E8,316C
$A6:ECDC             dx 000F, 01E0,05,3158, 0000,DD,314B, 01E8,05,3138, 01F8,05,313A, 01F0,05,3139, 0008,05,313C, 0000,05,313B, 01D8,D5,3157, 8000,F5,31A5, 81F8,F5,31A4, 81E8,F5,31A2, 8000,E5,31A0, 81F0,E5,318E, 81F0,D5,318C, 81E0,D5,318A
$A6:ED29             dx 0007, 81FA,FF,31AE, 81EA,FF,31AC, 0008,F8,31BA, 0000,F8,31B9, 0008,F0,31AA, 0000,F0,31A9, 81F0,F0,31A7
$A6:ED4E             dx 0006, 01F9,04,31AB, 01F1,04,315B, 81F9,0B,31AE, 81E9,0B,31AC, 81FE,F4,31C2, 81EE,F4,31C0
$A6:ED6E             dx 0006, 01EF,08,31BB, 81F7,08,31CE, 81FD,13,31AE, 81ED,13,31AC, 81FE,F8,31C6, 81EE,F8,31C4
$A6:ED8E             dx 0001, 81F0,FC,3140
$A6:ED95             dx 0006, 81E8,03,31CC, 81F0,F8,3120, 8000,F8,3122, 81FE,06,3122, 8000,E8,3102, 81F0,E8,3100
$A6:EDB5             dx 0020, 0000,20,70FB, 0010,20,70EA, 0010,18,70FA, 0008,20,70EB, 0008,D8,70F0, 0010,00,70E0, 0010,F8,70FD, 0010,F0,70ED, 0000,D8,70F1, 0000,D0,70E1, 0010,E8,70FC, 0010,E0,70EC, 8000,10,70E8, 8000,00,70E6, 8000,F0,70E4, 8000,E0,70E2, 01F8,20,30FB, 01E8,20,30EA, 01E8,18,30FA, 01F0,20,30EB, 01F0,D8,30F0, 01E8,00,30E0, 01E8,F8,30FD, 01E8,F0,30ED, 01F8,D8,30F1, 01F8,D0,30E1, 01E8,E8,30FC, 01E8,E0,30EC, 81F0,10,30E8, 81F0,00,30E6, 81F0,F0,30E4, 81F0,E0,30E2
$A6:EE57             dx 000C, 0014,12,7154, 01F4,0A,7159, 01F4,02,7149, 01FC,0A,717B, 0004,0A,717A, 01FC,02,716B, 0004,02,716A, 800C,02,7168, 81F4,F2,7166, 8004,F2,7164, 81EC,E2,7162, 81FC,E2,7160
$A6:EE95             dx 000D, 01F2,F0,714A, 0002,08,71BB, 0002,00,713D, 01F2,F8,715A, 81F2,00,7188, 81FA,F0,7186, 000A,00,7156, 0012,00,7155, 800A,F0,7184, 81EA,E0,7182, 81FA,E0,7180, 800A,E0,716E, 801A,E8,716C
$A6:EED8             dx 000F, 0018,05,7158, 01F8,DD,714B, 0010,05,7138, 0000,05,713A, 0008,05,7139, 01F0,05,713C, 01F8,05,713B, 0020,D5,7157, 81F0,F5,71A5, 81F8,F5,71A4, 8008,F5,71A2, 81F0,E5,71A0, 8000,E5,718E, 8000,D5,718C, 8010,D5,718A
$A6:EF25             dx 0007, 81F6,FF,71AE, 8006,FF,71AC, 01F0,F8,71BA, 01F8,F8,71B9, 01F0,F0,71AA, 01F8,F0,71A9, 8000,F0,71A7
$A6:EF4A             dx 0006, 01FF,04,71AB, 0007,04,715B, 81F7,0B,71AE, 8007,0B,71AC, 81F2,F4,71C2, 8002,F4,71C0
$A6:EF6A             dx 0006, 0009,08,71BB, 81F9,08,71CE, 81F3,13,71AE, 8003,13,71AC, 81F2,F8,71C6, 8002,F8,71C4
$A6:EF8A             dx 0001, 8000,FC,7140
$A6:EF91             dx 0006, 8008,03,71CC, 8000,F8,7120, 81F0,F8,7122, 81F2,06,7122, 81F0,E8,7102, 8000,E8,7100
}
}


;;; $EFB1..F4EB: Ceres steam ;;;
{
;;; $EFB1: Initialisation AI - enemy $E1FF (Ceres steam) ;;;
{
$A6:EFB1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:EFB4 9E 98 0F    STZ $0F98,x[$7E:1018]  ; Enemy VRAM tiles index = 0
$A6:EFB7 BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A6:EFBA 09 00 20    ORA #$2000             ;} Set enemy to process instruction
$A6:EFBD 9D 86 0F    STA $0F86,x[$7E:1006]  ;/
$A6:EFC0 BD 88 0F    LDA $0F88,x[$7E:1008]  ;\
$A6:EFC3 09 04 00    ORA #$0004             ;} Enable enemy extended spritemap format
$A6:EFC6 9D 88 0F    STA $0F88,x[$7E:1008]  ;/
$A6:EFC9 A9 01 00    LDA #$0001             ;\
$A6:EFCC 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$A6:EFCF 9E 90 0F    STZ $0F90,x[$7E:1010]  ; Enemy timer = 0
$A6:EFD2 A9 00 0A    LDA #$0A00             ;\
$A6:EFD5 9D 96 0F    STA $0F96,x[$7E:1016]  ;} Enemy palette index = A00h (palette 5)
$A6:EFD8 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A6:EFDC 29 1F 00    AND #$001F             ;\
$A6:EFDF 1A          INC A                  ;} Enemy activation timer = 1 + [random number] % 20h
$A6:EFE0 9D AE 0F    STA $0FAE,x[$7E:102E]  ;/
$A6:EFE3 BD B4 0F    LDA $0FB4,x[$7E:1034]  ;\
$A6:EFE6 0A          ASL A                  ;} Y = [enemy parameter 1] * 2
$A6:EFE7 A8          TAY                    ;/
$A6:EFE8 B9 F5 EF    LDA $EFF5,y[$A6:EFF5]  ;\
$A6:EFEB 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = [$EFF5 + [Y]]
$A6:EFEE B9 01 F0    LDA $F001,y[$A6:F001]  ;\
$A6:EFF1 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = [$F001 + [Y]]
$A6:EFF4 6B          RTL

; Indexed by [enemy parameter 1] * 2
$A6:EFF5             dw F04D, F081, F0B5, F0E9, F081, F0E9 ; Instruction list pointers
$A6:F001             dw EFF4, EFF4, EFF4, EFF4, F019, F019 ; Initial function pointers
}


;;; $F00D: Main AI - enemy $E1FF (Ceres steam) ;;;
{
$A6:F00D AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:F010 A9 FF 7F    LDA #$7FFF             ;\
$A6:F013 9D 8C 0F    STA $0F8C,x[$7E:108C]  ;} Enemy health = 7FFFh
$A6:F016 7C A8 0F    JMP ($0FA8,x)[$A6:EFF4]; Go to [enemy function]
}


;;; $F019: Ceres steam function - calculate graphical offset in rotating elevator room ;;;
{
$A6:F019 BD 7A 0F    LDA $0F7A,x[$7E:11FA]  ;\
$A6:F01C 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$A6:F01E BD 7E 0F    LDA $0F7E,x[$7E:11FE]  ;\
$A6:F021 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$A6:F023 22 66 8B 8B JSL $8B8B66[$8B:8B66]  ; Calculate position of Ceres steam in rotating elevator room
$A6:F027 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:F02A A5 12       LDA $12    [$7E:0012]  ;\
$A6:F02C 38          SEC                    ;|
$A6:F02D FD 7A 0F    SBC $0F7A,x[$7E:11FA]  ;} Enemy graphical X offset = [$12] - [enemy X position]
$A6:F030 9F 10 70 7E STA $7E7010,x[$7E:7290];/
$A6:F034 A5 14       LDA $14    [$7E:0014]  ;\
$A6:F036 38          SEC                    ;|
$A6:F037 FD 7E 0F    SBC $0F7E,x[$7E:11FE]  ;} Enemy graphical Y offset = [$14] - [enemy Y position]
$A6:F03A 9F 12 70 7E STA $7E7012,x[$7E:7292];/
$A6:F03E 6B          RTL
}


;;; $F03F: Enemy touch - enemy $E1FF (Ceres steam) ;;;
{
$A6:F03F AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:F042 A9 FF 7F    LDA #$7FFF             ;\
$A6:F045 9D 8C 0F    STA $0F8C,x[$7E:108C]  ;} Enemy health = 7FFFh
$A6:F048 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI
$A6:F04C 6B          RTL
}


;;; $F04D: Instruction list - Ceres steam - up ;;;
{
$A6:F04D             dw F11D,           ; Hide enemy
                        0001,F142,
                        F127,F04D,F061  ; Decrement activation timer and go to $F04D if non-zero, otherwise show enemy and go to $F061
$A6:F059             dw F11D,           ; Hide enemy
                        0040,F142,
                        F135            ; Show enemy
$A6:F061             dw 0003,F142,
                        0003,F14C,
                        0003,F156,
                        0003,F160,
                        0003,F16A,
                        0003,F174,
                        0003,F17E,
                        80ED,F059       ; Go to $F059
}


;;; $F081: Instruction list - Ceres steam - left ;;;
{
$A6:F081             dw F11D,           ; Hide enemy
                        0001,F188,
                        F127,F081,F095  ; Decrement activation timer and go to $F081 if non-zero, otherwise show enemy and go to $F095
$A6:F08D             dw F11D,           ; Hide enemy
                        0040,F188,
                        F135            ; Show enemy
$A6:F095             dw 0003,F188,
                        0003,F192,
                        0003,F19C,
                        0003,F1A6,
                        0003,F1B0,
                        0003,F1BA,
                        0003,F1C4,
                        80ED,F08D       ; Go to $F08D
}


;;; $F0B5: Instruction list - Ceres steam - down ;;;
{
$A6:F0B5             dw F11D,           ; Hide enemy
                        0001,F1CE,
                        F127,F0B5,F0C9  ; Decrement activation timer and go to $F0B5 if non-zero, otherwise show enemy and go to $F0C9
$A6:F0C1             dw F11D,           ; Hide enemy
                        0040,F1CE,
                        F135            ; Show enemy
$A6:F0C9             dw 0003,F1CE,
                        0003,F1D8,
                        0003,F1E2,
                        0003,F1EC,
                        0003,F1F6,
                        0003,F200,
                        0003,F20A,
                        80ED,F0C1       ; Go to $F0C1
}


;;; $F0E9: Instruction list - Ceres steam - right ;;;
{
$A6:F0E9             dw F11D,           ; Hide enemy
                        0001,F214,
                        F127,F0E9,F0FD  ; Decrement activation timer and go to $F0E9 if non-zero, otherwise show enemy and go to $F0FD
$A6:F0F5             dw F11D,           ; Hide enemy
                        0040,F214,
                        F135            ; Show enemy
$A6:F0FD             dw 0003,F214,
                        0003,F21E,
                        0003,F228,
                        0003,F232,
                        0003,F23C,
                        0003,F246,
                        0003,F250,
                        80ED,F0F5       ; Go to $F0F5
}


;;; $F11D: Instruction - hide enemy ;;;
{
$A6:F11D BD 86 0F    LDA $0F86,x[$7E:1086]  ;\
$A6:F120 09 00 05    ORA #$0500             ;} Set enemy to be intangible and invisible
$A6:F123 9D 86 0F    STA $0F86,x[$7E:1086]  ;/
$A6:F126 6B          RTL
}


;;; $F127: Instruction - decrement activation timer and go to [[Y]] if non-zero, otherwise show enemy and go to [[Y] + 2] ;;;
{
$A6:F127 DE AE 0F    DEC $0FAE,x[$7E:10AE]  ; Decrement enemy activation timer
$A6:F12A F0 05       BEQ $05    [$F131]     ; If [enemy activation timer] != 0:
$A6:F12C B9 00 00    LDA $0000,y[$A6:F055]  ;\
$A6:F12F A8          TAY                    ;} Y = [[Y]]
$A6:F130 6B          RTL                    ; Return

$A6:F131 B9 02 00    LDA $0002,y[$A6:F057]  ;\
$A6:F134 A8          TAY                    ;} Y = [[Y] + 2]
}


;;; $F135: Instruction - show enemy ;;;
{
$A6:F135 BD 86 0F    LDA $0F86,x[$7E:1106]  ;\
$A6:F138 29 FF FB    AND #$FBFF             ;|
$A6:F13B 29 FF FE    AND #$FEFF             ;} Set enemy to tangible and visible
$A6:F13E 9D 86 0F    STA $0F86,x[$7E:1106]  ;/
$A6:F141 6B          RTL
}


;;; $F142: Ceres steam extended spritemaps ;;;
{
; Top byte of extended spritemap size is ignored...

; Up
$A6:F142             dx 1001, 0000,0000,F374,F25C
$A6:F14C             dx 1001, 0000,0000,F37B,F26A
$A6:F156             dx 1001, 0000,0000,F387,F278
$A6:F160             dx 1001, 0000,0000,F398,F286
$A6:F16A             dx 1001, 0000,0000,F3AE,F294
$A6:F174             dx 1001, 0000,0000,F3BF,F25A
$A6:F17E             dx 1001, 0000,0000,F3CB,F25A

; Left
$A6:F188             dx 1001, 0000,0000,F3D2,F2A2
$A6:F192             dx 1001, 0000,0000,F3D9,F2B0
$A6:F19C             dx 1001, 0000,0000,F3E5,F2BE
$A6:F1A6             dx 1001, 0000,0000,F3F6,F2CC
$A6:F1B0             dx 1001, 0000,0000,F40C,F2DA
$A6:F1BA             dx 1001, 0000,0000,F41D,F25A
$A6:F1C4             dx 1001, 0000,0000,F429,F25A

; Down
$A6:F1CE             dx 1001, 0000,0000,F430,F2E8
$A6:F1D8             dx 1001, 0000,0000,F437,F2F6
$A6:F1E2             dx 1001, 0000,0000,F443,F304
$A6:F1EC             dx 1001, 0000,0000,F454,F312
$A6:F1F6             dx 1001, 0000,0000,F46A,F320
$A6:F200             dx 1001, 0000,0000,F47B,F25A
$A6:F20A             dx 1001, 0000,0000,F487,F25A

; Right
$A6:F214             dx 1001, 0000,0000,F48E,F32E
$A6:F21E             dx 1001, 0000,0000,F495,F33C
$A6:F228             dx 1001, 0000,0000,F4A1,F34A
$A6:F232             dx 1001, 0000,0000,F4B2,F358
$A6:F23C             dx 1001, 0000,0000,F4C8,F366
$A6:F246             dx 1001, 0000,0000,F4D9,F25A
$A6:F250             dx 1001, 0000,0000,F4E5,F25A
}


;;; $F25A: Ceres steam hitboxes ;;;
{
$A6:F25A             dx 0000

; Up
$A6:F25C             dx 0001, FFF8,FFF0,0007,FFFF,F03F,804C
$A6:F26A             dx 0001, FFF8,FFE9,0007,FFFE,F03F,804C
$A6:F278             dx 0001, FFF8,FFE0,0007,FFF8,F03F,804C
$A6:F286             dx 0001, FFF8,FFD8,0007,FFF0,F03F,804C
$A6:F294             dx 0001, FFF8,FFD8,0006,FFE8,F03F,804C

; Left
$A6:F2A2             dx 0001, FFF0,FFF8,FFFF,0007,F03F,804C
$A6:F2B0             dx 0001, FFE8,FFF8,FFFE,0007,F03F,804C
$A6:F2BE             dx 0001, FFE0,FFF9,FFF7,0007,F03F,804C
$A6:F2CC             dx 0001, FFD8,FFF7,FFEF,0005,F03F,804C
$A6:F2DA             dx 0001, FFD8,FFF5,FFE6,0002,F03F,804C

; Down
$A6:F2E8             dx 0001, FFF8,0000,0007,000E,F03F,804C
$A6:F2F6             dx 0001, FFF8,0000,0007,0017,F03F,804C
$A6:F304             dx 0001, FFF8,0008,0007,001F,F03F,804C
$A6:F312             dx 0001, FFF8,000F,0007,0027,F03F,804C
$A6:F320             dx 0001, FFF8,0017,0006,0026,F03F,804C

; Right
$A6:F32E             dx 0001, 0000,FFF8,000F,0007,F03F,804C
$A6:F33C             dx 0001, 0001,FFF8,0017,0007,F03F,804C
$A6:F34A             dx 0001, 0009,FFF8,001F,0007,F03F,804C
$A6:F358             dx 0001, 0012,FFF7,0026,0005,F03F,804C
$A6:F366             dx 0001, 0019,FFF5,0028,0003,F03F,804C
}


;;; $F374: Ceres steam spritemaps ;;;
{
; Up
$A6:F374             dx 0001, 81F8,F0,207C
$A6:F37B             dx 0002, 81F8,E8,207C, 81F8,F0,207E
$A6:F387             dx 0003, 81F8,E0,207C, 81F8,E8,207E, 81F8,F0,209A
$A6:F398             dx 0004, 81F8,D7,207C, 81F8,E0,207E, 81F8,E8,209A, 81F8,F0,209C
$A6:F3AE             dx 0003, 81F8,D6,207E, 81F8,E0,209A, 81F8,E8,209C
$A6:F3BF             dx 0002, 81F8,D5,209A, 81F8,E0,209C
$A6:F3CB             dx 0001, 81F8,D3,209C

; Left
$A6:F3D2             dx 0001, 81F0,F8,207C
$A6:F3D9             dx 0002, 81E8,F8,207C, 81F0,F8,207E
$A6:F3E5             dx 0003, 81E0,F8,207C, 81E8,F8,207E, 81F0,F8,209A
$A6:F3F6             dx 0004, 81D8,F6,207C, 81E0,F8,207E, 81E8,F8,209A, 81F0,F8,209C
$A6:F40C             dx 0003, 81D7,F4,207E, 81E0,F6,209A, 81E8,F8,209C
$A6:F41D             dx 0002, 81D6,F2,209A, 81E0,F4,209C
$A6:F429             dx 0001, 81D5,F0,209C

; Down
$A6:F430             dx 0001, 81F8,00,A07C
$A6:F437             dx 0002, 81F8,08,A07C, 81F8,00,A07E
$A6:F443             dx 0003, 81F8,10,A07C, 81F8,08,A07E, 81F8,00,A09A
$A6:F454             dx 0004, 81F8,18,A07C, 81F8,10,A07E, 81F8,08,A09A, 81F8,00,A09C
$A6:F46A             dx 0003, 81F8,18,A07E, 81F8,10,A09A, 81F8,08,A09C
$A6:F47B             dx 0002, 81F8,18,A09A, 81F8,10,A09C
$A6:F487             dx 0001, 81F8,18,A09C

; Right
$A6:F48E             dx 0001, 8000,F8,607C
$A6:F495             dx 0002, 8008,F8,607C, 8000,F8,607E
$A6:F4A1             dx 0003, 8010,F8,607C, 8008,F8,607E, 8000,F8,609A
$A6:F4B2             dx 0004, 8018,F6,607C, 8010,F8,607E, 8008,F8,609A, 8000,F8,609C
$A6:F4C8             dx 0003, 8019,F4,607E, 8010,F6,609A, 8008,F8,609C
$A6:F4D9             dx 0002, 801A,F2,609A, 8010,F4,609C
$A6:F4E5             dx 0001, 801B,F0,609C
}
}


;;; $F4EC..FB71: Ceres door ;;;
{
;;; $F4EC: Ceres door palettes ;;;
{
; Before escape sequence
$A6:F4EC             dw 0000, 7E20, 6560, 2060, 1000, 7940, 5D00, 4CA0, 3CA0, 43FF, 0113, 000F, 175C, 0299, 01D6, 57E0

; During escape sequence
$A6:F50C             dw 3800, 6B5A, 5652, 28E7, 1863, 62B5, 4A10, 396B, 3129, 43FF, 0113, 000F, 175C, 0299, 01D6, 3BE0
}


;;; $F52C: Ceres door instruction list pointers ;;;
{
; Indexed by [enemy parameter 1]
$A6:F52C             dw F56C, F5BE, F610, F53A, F61A, F62A, F634
}


;;; $F53A..F63D: Instruction lists - Ceres door ;;;
{
;;; $F53A: Instruction list - parameter 1 = 3 (Ridley's room facing right) ;;;
{
$A6:F53A             dw F68B,        ; Set enemy as intangible
                        F6A6,        ; Set enemy as invisible
                        0002,FAA7,
                        F695,        ; Set enemy as tangible
                        F6B3,        ; Set enemy as visible
                        0002,FAA7,
                        0002,FA87,
                        0002,FA67,
                        0002,FA3D,
                        F69F,        ; Set drawn by Ridley flag
                        0001,FA13,
                        F6A6,        ; Set enemy as invisible
$A6:F55E             dw 0002,FA13,
                        F66A,F55E,   ; Go to $F55E if area boss is alive
                        F6B0,        ; Set enemy as visible, clear drawn by Ridley flag
                        80ED,F598    ; Go to $F598 (Ceres door facing right - closed)
}


;;; $F56C: Instruction list - parameter 1 = 0 (normal facing right) ;;;
{
$A6:F56C             dw F68B,        ; Set enemy as intangible
                        F6A6,        ; Set enemy as invisible
                        0002,FA13,
                        F63E,F598    ; Go to $F598 (Ceres door facing right - closed) if Samus is not within 30h pixels
}


;;; $F578: Instruction list - Ceres door facing right - open ;;;
{
$A6:F578             dw 0002,FAA7,
                        F63E,F584,   ; Go to $F584 if Samus is not within 30h pixels
                        80ED,F578    ; Go to $F578
$A6:F584             dw F695,        ; Set enemy as tangible
                        F6B3,        ; Set enemy as visible
                        0005,FAA7,
                        0005,FA87,
                        0005,FA67,
                        0005,FA3D
}


;;; $F598: Instruction list - Ceres door facing right - closed ;;;
{
$A6:F598             dw F695,        ; Set enemy as tangible
                        F6B3         ; Set enemy as visible
$A6:F59C             dw 0002,FA13,
                        F63E,F59C,   ; Go to $F59C if Samus is not within 30h pixels
                        F6BD,        ; Queue sound 2Ch, sound library 3, max queued sounds allowed = 6 (Ceres door opening)
                        0005,FA3D,
                        0005,FA67,
                        0005,FA87,
                        0005,FAA7,
                        F68B,        ; Set enemy as intangible
                        F6A6,        ; Set enemy as invisible
                        80ED,F578    ; Go to $F578 (Ceres door facing right - open)
}


;;; $F5BE: Instruction list - parameter 1 = 1 (normal facing left) ;;;
{
$A6:F5BE             dw F68B,        ; Set enemy as intangible
                        F6A6,        ; Set enemy as invisible
                        0002,FA13,
                        F63E,F5EA    ; Go to $F5EA if Samus is not within 30h pixels
$A6:F5CA             dw 0002,F95F,
                        F63E,F5D6,   ; Go to $F5D6 if Samus is not within 30h pixels
                        80ED,F5CA    ; Go to $F5CA
$A6:F5D6             dw F695,        ; Set enemy as tangible
                        F6B3,        ; Set enemy as visible
                        0005,F9F3,
                        0005,F9D3,
                        0005,F9B3,
                        0005,F989
$A6:F5EA             dw F695,        ; Set enemy as tangible
                        F6B3         ; Set enemy as visible
$A6:F5EE             dw 0002,F95F,
                        F63E,F5EE,   ; Go to $F5EE if Samus is not within 30h pixels
                        F6BD,        ; Queue sound 2Ch, sound library 3, max queued sounds allowed = 6 (Ceres door opening)
                        0005,F989,
                        0005,F9B3,
                        0005,F9D3,
                        0005,F9F3,
                        F68B,        ; Set enemy as intangible
                        F6A6,        ; Set enemy as invisible
                        80ED,F5CA    ; Go to $F5CA
}


;;; $F610: Instruction list - parameter 1 = 2 (rotating elevator room pre-explosion door overlay) ;;;
{
$A6:F610             dw F68B         ; Set enemy as intangible
$A6:F612             dw 0001,F921,
                        80ED,F612    ; Go to $F612
}


;;; $F61A: Instruction list - parameter 1 = 4 (rotating elevator room invisible wall) ;;;
{
$A6:F61A             dw F678,F5BE,   ; Go to $F5BE if Ceres Ridley has not escaped
                        F695,        ; Set enemy as tangible
                        F6A6,        ; Set enemy as invisible
$A6:F622             dw 0001,F95F,
                        80ED,F622    ; Go to $F622
}


;;; $F62A: Instruction list - parameter 1 = 5 (Ridley escape mode 7 left wall) ;;;
{
$A6:F62A             dw F68B         ; Set enemy as intangible
$A6:F62C             dw 0001,FACE,
                        80ED,F62C    ; Go to $F62C
}


;;; $F634: Instruction list - parameter 1 = 6 (Ridley escape mode 7 right wall) ;;;
{
$A6:F634             dw F68B         ; Set enemy as intangible
$A6:F636             dw 0001,FB2F,
                        80ED,F636    ; Go to $F636
}
}


;;; $F63E..C4: Instructions ;;;
{
;;; $F63E: Instruction - go to [[Y]] if Samus is not within 30h pixels ;;;
{
; Measure with taxicab distance
$A6:F63E BD 7A 0F    LDA $0F7A,x[$7E:0FBA]
$A6:F641 38          SEC
$A6:F642 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A6:F645 10 04       BPL $04    [$F64B]
$A6:F647 49 FF FF    EOR #$FFFF
$A6:F64A 1A          INC A

$A6:F64B C9 30 00    CMP #$0030
$A6:F64E B0 15       BCS $15    [$F665]
$A6:F650 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]
$A6:F653 38          SEC
$A6:F654 ED FA 0A    SBC $0AFA  [$7E:0AFA]
$A6:F657 10 04       BPL $04    [$F65D]
$A6:F659 49 FF FF    EOR #$FFFF
$A6:F65C 1A          INC A

$A6:F65D C9 30 00    CMP #$0030
$A6:F660 B0 03       BCS $03    [$F665]

$A6:F662 C8          INY
$A6:F663 C8          INY
$A6:F664 6B          RTL

$A6:F665 B9 00 00    LDA $0000,y[$A6:F5C8]
$A6:F668 A8          TAY
$A6:F669 6B          RTL
}


;;; $F66A: Instruction - go to [[Y]] if area boss is alive ;;;
{
$A6:F66A DA          PHX
$A6:F66B AE 9F 07    LDX $079F  [$7E:079F]  ;\
$A6:F66E BF 28 D8 7E LDA $7ED828,x[$7E:D82E];|
$A6:F672 FA          PLX                    ;} If area boss not dead: go to parameter
$A6:F673 4A          LSR A                  ;|
$A6:F674 90 EF       BCC $EF    [$F665]     ;/
$A6:F676 80 EA       BRA $EA    [$F662]     ; Else (area boss dead): go to next instruction
}


;;; $F678: Instruction - go to [[Y]] if Ceres Ridley has not escaped ;;;
{
$A6:F678 AD 3F 09    LDA $093F  [$7E:093F]
$A6:F67B F0 E8       BEQ $E8    [$F665]
$A6:F67D 80 E3       BRA $E3    [$F662]
}


;;; $F67F: Set Ceres elevator room to rotate if Ridley has escaped ;;;
{
$A6:F67F AD 3F 09    LDA $093F  [$7E:093F]  ;\
$A6:F682 F0 06       BEQ $06    [$F68A]     ;} If Ceres Ridley escaped:
$A6:F684 A9 00 80    LDA #$8000             ;\
$A6:F687 8D 3F 09    STA $093F  [$7E:093F]  ;} Set elevator room to rotate

$A6:F68A 6B          RTL
}


;;; $F68B: Instruction - set enemy as intangible ;;;
{
$A6:F68B BD 86 0F    LDA $0F86,x[$7E:0F86]
$A6:F68E 09 00 04    ORA #$0400
$A6:F691 9D 86 0F    STA $0F86,x[$7E:0F86]
$A6:F694 6B          RTL
}


;;; $F695: Instruction - set enemy as tangible ;;;
{
$A6:F695 BD 86 0F    LDA $0F86,x[$7E:0FC6]
$A6:F698 29 FF FB    AND #$FBFF
$A6:F69B 9D 86 0F    STA $0F86,x[$7E:0FC6]
$A6:F69E 6B          RTL
}


;;; $F69F: Instruction - set drawn by Ridley flag ;;;
{
$A6:F69F A9 01 00    LDA #$0001
$A6:F6A2 9D AA 0F    STA $0FAA,x[$7E:0FEA]
$A6:F6A5 6B          RTL
}


;;; $F6A6: Instruction - set enemy as invisible ;;;
{
$A6:F6A6 BD 86 0F    LDA $0F86,x[$7E:0FC6]
$A6:F6A9 09 00 01    ORA #$0100
$A6:F6AC 9D 86 0F    STA $0F86,x[$7E:0FC6]
$A6:F6AF 6B          RTL
}


;;; $F6B0: Instruction - set enemy as visible, clear drawn by Ridley flag ;;;
{
$A6:F6B0 9E AA 0F    STZ $0FAA,x[$7E:0FEA]
}


;;; $F6B3: Instruction - set enemy as visible ;;;
{
$A6:F6B3 BD 86 0F    LDA $0F86,x[$7E:0FC6]
$A6:F6B6 29 FF FE    AND #$FEFF
$A6:F6B9 9D 86 0F    STA $0F86,x[$7E:0FC6]
$A6:F6BC 6B          RTL
}


;;; $F6BD: Instruction - queue sound 2Ch, sound library 3, max queued sounds allowed = 6 ;;;
{
$A6:F6BD A9 2C 00    LDA #$002C             ;\
$A6:F6C0 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2Ch, sound library 3, max queued sounds allowed = 6 (Ceres door opening)
$A6:F6C4 6B          RTL
}
}


;;; $F6C5: Initialisation AI - enemy $E23F (Ceres door) ;;;
{
$A6:F6C5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:F6C8 A9 C7 FA    LDA #$FAC7             ;\
$A6:F6CB 9D 8E 0F    STA $0F8E,x[$7E:0F8E]  ;} Enemy spritemap pointer = $FAC7
$A6:F6CE A9 01 00    LDA #$0001             ;\
$A6:F6D1 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A6:F6D4 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A6:F6D7 9E 98 0F    STZ $0F98,x[$7E:0F98]  ; Enemy VRAM tiles index = 0
$A6:F6DA A9 00 04    LDA #$0400             ;\
$A6:F6DD 9D 96 0F    STA $0F96,x[$7E:0F96]  ;} Enemy palette index = 400h (palette 2)
$A6:F6E0 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A6:F6E3 0A          ASL A                  ;} Y = [enemy parameter 1] * 2
$A6:F6E4 A8          TAY                    ;/
$A6:F6E5 B9 2B F7    LDA $F72B,y[$A6:F72F]  ;\
$A6:F6E8 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = [$F72B + [Y]]
$A6:F6EB B9 2C F5    LDA $F52C,y[$A6:F530]  ;\
$A6:F6EE 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Instruction pointer = [$F52C + [Y]]
$A6:F6F1 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy drawn by Ridley flag = 0
$A6:F6F4 20 39 F7    JSR $F739  [$A6:F739]  ; Load rotating elevator room pre-explosion door overlay tiles if needed
$A6:F6F7 AD 3F 09    LDA $093F  [$7E:093F]  ;\
$A6:F6FA D0 1B       BNE $1B    [$F717]     ;} If not before Ridley escape: go to BRANCH_ESCAPE_SEQUENCE
$A6:F6FC BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A6:F6FF C9 03 00    CMP #$0003             ;} If [enemy parameter 1] = 3 (Ridley's room facing right):
$A6:F702 D0 0E       BNE $0E    [$F712]     ;/
$A6:F704 A0 EE F4    LDY #$F4EE             ;\
$A6:F707 A2 42 01    LDX #$0142             ;|
$A6:F70A A9 0F 00    LDA #$000F             ;} Target sprite palette 2 colours 1..Fh = [$A6:F4EE..F50B]
$A6:F70D 22 F6 D2 A9 JSL $A9D2F6[$A9:D2F6]  ;/
$A6:F711 6B          RTL                    ; Return

$A6:F712 A0 EE F4    LDY #$F4EE             ; Y = $F4EE
$A6:F715 80 03       BRA $03    [$F71A]     ; Go to BRANCH_MERGE

; BRANCH_ESCAPE_SEQUENCE
$A6:F717 A0 0E F5    LDY #$F50E             ; Y = $F50E

; BRANCH_MERGE
$A6:F71A A9 00 0E    LDA #$0E00             ;\
$A6:F71D 9D 96 0F    STA $0F96,x[$7E:0F96]  ;} Enemy palette index = E00h (palette 7)
$A6:F720 A2 E2 01    LDX #$01E2             ;\
$A6:F723 A9 0F 00    LDA #$000F             ;} Target sprite palette 7 colours 1..Fh = 1Eh bytes from [Y]
$A6:F726 22 F6 D2 A9 JSL $A9D2F6[$A9:D2F6]  ;/
$A6:F72A 6B          RTL

; Function pointers, indexed by [enemy parameter 1]
$A6:F72B             dw F76B, ; 0: Normal facing right
                        F76B, ; 1: Normal facing left
                        F7BD, ; 2: Rotating elevator room pre-explosion door overlay
                        F770, ; 3: Ridley's room (facing right)
                        F76B, ; 4: Rotating elevator room invisible wall
                        F7A5, ; 5: Ridley escape mode 7 left wall
                        F7A5  ; 6: Ridley escape mode 7 right wall
}


;;; $F739: Load rotating elevator room pre-explosion door overlay tiles if needed ;;;
{
$A6:F739 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A6:F73C C9 02 00    CMP #$0002             ;} If [enemy parameter 1] != 2 (rotating elevator room pre-explosion door overlay): return
$A6:F73F D0 23       BNE $23    [$F764]     ;/
$A6:F741 AC 30 03    LDY $0330  [$7E:0330]  ;\
$A6:F744 A9 00 04    LDA #$0400             ;|
$A6:F747 99 D0 00    STA $00D0,y[$7E:00D0]  ;|
$A6:F74A A9 00 B0    LDA #$B000             ;|
$A6:F74D 99 D3 00    STA $00D3,y[$7E:00D3]  ;|
$A6:F750 A9 00 C4    LDA #$C400             ;|
$A6:F753 99 D2 00    STA $00D2,y[$7E:00D2]  ;} Queue transfer of $B0:C400..C7FF to VRAM $7000..71FF
$A6:F756 A9 00 70    LDA #$7000             ;|
$A6:F759 99 D5 00    STA $00D5,y[$7E:00D5]  ;|
$A6:F75C 98          TYA                    ;|
$A6:F75D 18          CLC                    ;|
$A6:F75E 69 07 00    ADC #$0007             ;|
$A6:F761 8D 30 03    STA $0330  [$7E:0330]  ;/

$A6:F764 60          RTS
}


;;; $F765: Main AI - enemy $E23F (Ceres door) ;;;
{
$A6:F765 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:F768 7C A8 0F    JMP ($0FA8,x)[$A6:F7BD]; Go to [enemy function]
}


;;; $F76B: Ceres door function - handle earthquake during escape ;;;
{
$A6:F76B A0 14 00    LDY #$0014             ; Y = 14h (BG1, BG2 and enemies, 1 pixel displacement, diagonal)
$A6:F76E 80 03       BRA $03    [$F773]     ; Go to handle Ceres door earthquake
}


;;; $F770: Ceres door function - handle earthquake during escape in Ridley's room ;;;
{
$A6:F770 A0 1D 00    LDY #$001D             ; Y = 1Dh (BG2 only and enemies, 1 pixel displacement, diagonal)
}


;;; $F773: Handle Ceres door earthquake during escape ;;;
{
;; Parameters:
;;     Y: Earthquake type. Must have 1 pixel displacement
$A6:F773 AD 3F 09    LDA $093F  [$7E:093F]  ;\
$A6:F776 C9 02 00    CMP #$0002             ;} If [Ceres status] < 2 (before escape sequence): return
$A6:F779 90 29       BCC $29    [$F7A4]     ;/
$A6:F77B AD 40 18    LDA $1840  [$7E:1840]  ;\
$A6:F77E D0 24       BNE $24    [$F7A4]     ;} If [earthquake timer] != 0: return
$A6:F780 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A6:F783 29 FF 0F    AND #$0FFF             ;|
$A6:F786 C9 80 00    CMP #$0080             ;} If [random number] % 1000h >= 80h:
$A6:F789 90 0B       BCC $0B    [$F796]     ;/
$A6:F78B A9 02 00    LDA #$0002             ;\
$A6:F78E 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 2
$A6:F791 98          TYA                    ;\
$A6:F792 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = [Y]
$A6:F795 6B          RTL                    ; Return

$A6:F796 A9 04 00    LDA #$0004             ;\
$A6:F799 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 4
$A6:F79C 98          TYA                    ;\
$A6:F79D 18          CLC                    ;|
$A6:F79E 69 06 00    ADC #$0006             ;} Earthquake type = [Y] + 6 (adjust from 1 pixel displacement to 3 pixel displacement)
$A6:F7A1 8D 3E 18    STA $183E  [$7E:183E]  ;/

$A6:F7A4 6B          RTL
}


;;; $F7A5: Ceres door function - Ridley escape mode 7 wall ;;;
{
$A6:F7A5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:F7A8 22 A6 F6 A6 JSL $A6F6A6[$A6:F6A6]  ; Set enemy as invisible
$A6:F7AC AD 3F 09    LDA $093F  [$7E:093F]  ;\
$A6:F7AF 4A          LSR A                  ;} If [Ceres status] = 1 (during Ridley escape cutscene):
$A6:F7B0 90 0A       BCC $0A    [$F7BC]     ;/
$A6:F7B2 A9 00 0E    LDA #$0E00             ;\
$A6:F7B5 9D 96 0F    STA $0F96,x[$7E:1016]  ;} Enemy palette index = E00h (palette 7)
$A6:F7B8 22 B3 F6 A6 JSL $A6F6B3[$A6:F6B3]  ; Set enemy as visible

$A6:F7BC 6B          RTL
}


;;; $F7BD: Ceres door function - rotating elevator room - default ;;;
{
$A6:F7BD 22 50 F8 A6 JSL $A6F850[$A6:F850]  ; Handle Ceres elevator animations
$A6:F7C1 AD 3F 09    LDA $093F  [$7E:093F]  ;\
$A6:F7C4 C9 02 00    CMP #$0002             ;} If [Ceres status] < 2 (before escape sequence): return
$A6:F7C7 90 12       BCC $12    [$F7DB]     ;/
$A6:F7C9 A9 DC F7    LDA #$F7DC             ;\
$A6:F7CC 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F7DC (rumbling and explosions)
$A6:F7CF A9 30 00    LDA #$0030             ;\
$A6:F7D2 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy rumbling timer = 30h
$A6:F7D5 9C B0 0F    STZ $0FB0  [$7E:0FB0]  ; Ceres door rumble timer = 0
$A6:F7D8 9C B2 0F    STZ $0FB2  [$7E:0FB2]  ; Ceres door rumble index = 0

$A6:F7DB 6B          RTL
}


;;; $F7DC: Ceres door function - rotating elevator room - rumbling and explosions ;;;
{
$A6:F7DC DE AE 0F    DEC $0FAE,x[$7E:0FAE]  ; Decrement enemy rumbling timer
$A6:F7DF 10 12       BPL $12    [$F7F3]     ; If [enemy rumbling timer] < 0:
$A6:F7E1 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A6:F7E4 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A6:F7E7 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A6:F7EA A9 50 F8    LDA #$F850             ;\
$A6:F7ED 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F850 (handle Ceres elevator animations)
$A6:F7F0 4C 7F F6    JMP $F67F  [$A6:F67F]  ; Go to set Ceres elevator room to rotate if Ridley has escaped

$A6:F7F3 CE B0 0F    DEC $0FB0  [$7E:0FB0]  ; Decrement Ceres door rumble timer
$A6:F7F6 10 47       BPL $47    [$F83F]     ; If [Ceres door rumble timer] >= 0: return
$A6:F7F8 A9 04 00    LDA #$0004             ;\
$A6:F7FB 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} Ceres door rumble timer = 4
$A6:F7FE CE B2 0F    DEC $0FB2  [$7E:0FB2]  ;\
$A6:F801 10 06       BPL $06    [$F809]     ;|
$A6:F803 A9 03 00    LDA #$0003             ;} Ceres door rumble index = ([Ceres door rumble index] - 1) % 4
$A6:F806 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;/

$A6:F809 AD B2 0F    LDA $0FB2  [$7E:0FB2]  ;\
$A6:F80C 0A          ASL A                  ;|
$A6:F80D 0A          ASL A                  ;} Y = [Ceres door rumble index] * 4
$A6:F80E A8          TAY                    ;/
$A6:F80F B9 40 F8    LDA $F840,y[$A6:F84C]  ;\
$A6:F812 18          CLC                    ;|
$A6:F813 7D 7A 0F    ADC $0F7A,x[$7E:0F7A]  ;} $12 = [enemy X position] + [$F840 + [Y]]
$A6:F816 85 12       STA $12    [$7E:0012]  ;/
$A6:F818 B9 42 F8    LDA $F842,y[$A6:F84E]  ;\
$A6:F81B 18          CLC                    ;|
$A6:F81C 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]  ;} $14 = [enemy Y position] + [$F840 + [Y] + 2]
$A6:F81F 85 14       STA $14    [$7E:0014]  ;/
$A6:F821 A0 03 00    LDY #$0003             ; A = 3 (small explosion)
$A6:F824 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A6:F828 C9 00 40    CMP #$4000             ;\
$A6:F82B B0 03       BCS $03    [$F830]     ;} If [random number] < 4000h:
$A6:F82D A0 0C 00    LDY #$000C             ; A = Ch (smoke)

$A6:F830 98          TYA
$A6:F831 A0 09 E5    LDY #$E509             ;\
$A6:F834 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A6:F838 A9 25 00    LDA #$0025             ;\
$A6:F83B 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 25h, sound library 2, max queued sounds allowed = 6 (big explosion)

$A6:F83F 6B          RTL

; Rumble offsets
;                        ________ X offset
;                       |     ___ Y offset
;                       |    |
$A6:F840             dw FFFC,FFF8,
                        0000,0004, 
                        FFFE,0016, 
                        0002,000C
}


;;; $F850: Ceres door function - rotating elevator room - handle Ceres elevator animations ;;;
{
$A6:F850 DA          PHX
$A6:F851 20 F1 F8    JSR $F8F1  [$A6:F8F1]  ; Animate Ceres elevator platform
$A6:F854 AF 00 C4 7E LDA $7EC400[$7E:C400]  ;\
$A6:F858 D0 15       BNE $15    [$F86F]     ;} If [palette change numerator] != 0: return
$A6:F85A AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A6:F85D 29 38 00    AND #$0038             ;|
$A6:F860 0A          ASL A                  ;} Y = $F871 + [frame counter] / 8 % 8 * 10h
$A6:F861 69 71 F8    ADC #$F871             ;|
$A6:F864 A8          TAY                    ;/
$A6:F865 A2 52 00    LDX #$0052             ;\
$A6:F868 A9 06 00    LDA #$0006             ;} BG1/2 palette 2 colours 9..Eh = Ch bytes from [Y]
$A6:F86B 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/

$A6:F86F FA          PLX
$A6:F870 6B          RTL

; Elevator beacon palette animation
$A6:F871             dw 5BFF,15B8,14B4,17DF,02FC,0239, 0000,0000,
                        47FF,0113,000F,175C,0299,01D6, 0000,0000,
                        335A,006E,000A,02B7,01F4,0131, 0000,0000,
                        1EB5,0009,0005,0212,014E,008C, 0000,0000,
                        1EB5,0009,0005,0212,014E,008C, 0000,0000,
                        335A,006E,000A,02B7,01F4,0131, 0000,0000,
                        47FF,0113,000F,175C,0299,01D6, 0000,0000,
                        5BFF,15B8,14B4,17DF,02FC,0239, 0000,0000
}


;;; $F8F1: Animate Ceres elevator platform ;;;
{
$A6:F8F1 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A6:F8F4 29 02 00    AND #$0002             ;|
$A6:F8F7 A8          TAY                    ;} X = [$F900 + [frame counter] / 2 % 2 * 2]
$A6:F8F8 BE 00 F9    LDX $F900,y[$A6:F900]  ;/
$A6:F8FB 22 4F 8B 80 JSL $808B4F[$80:8B4F]  ; Queue mode 7 transfers
$A6:F8FF 60          RTS

$A6:F900             dw F904, F90E

;                        ______________________ Control. 80h = write to VRAM tilemap. 0 = terminator
;                       |   ___________________ Source address
;                       |  |       ____________ Size
;                       |  |      |     _______ Destination address (VRAM)
;                       |  |      |    |     __ VRAM address increment mode
;                       |  |      |    |    |
$A6:F904             dx 80,A6F918,0004,060E,00, 00 ; Light
$A6:F90E             dx 80,A6F91C,0004,060E,00, 00 ; Dark

$A6:F918             db 68, 69, 69, 78 ; Light
$A6:F91C             db 8D, 8E, 8E, 79 ; Dark
}


;;; $F920: RTL. Enemy touch / enemy shot - enemy $E23F (Ceres door) ;;;
{
$A6:F920 6B          RTL
}


;;; $F921: Ceres door spritemaps ;;;
{
; Rotating elevator room pre-explosion door overlay
$A6:F921             dx 000C, 81F8,18,E0E0, 81F8,08,60E4, 81F8,F8,60E4, 81F8,E8,60E0, C208,28,210A, C3F8,28,2108, C208,18,A104, C208,08,A106, C208,F8,2106, C208,E8,2104, C208,D8,2102, C3F8,D8,2100

; Facing left - closed
$A6:F95F             dx 0008, 01F8,18,E0D1, 01F8,10,E0D3, 01F8,E0,60D1, 01F8,E8,60D3, 01F8,00,E0F2, 01F8,08,E0E2, 01F8,F8,60F2, 01F8,F0,60E2

; Facing left - opening frame 1
$A6:F989             dx 0008, 01F8,10,E0F3, 01F8,18,E0E3, 01F8,E8,60F3, 01F8,E0,60E3, 01FA,00,E0F2, 01FA,08,E0E2, 01FA,F8,60F2, 01FA,F0,60E2

; Facing left - opening frame 2
$A6:F9B3             dx 0006, 01F8,18,E0D0, 01F8,E0,60D0, 01FC,00,E0F2, 01FC,08,E0E2, 01FC,F8,60F2, 01FC,F0,60E2

; Facing left - opening frame 3
$A6:F9D3             dx 0006, 01F8,E0,60D2, 01F8,18,E0D2, 01FE,00,E0F2, 01FE,08,E0E2, 01FE,F8,60F2, 01FE,F0,60E2

; Facing left - open
$A6:F9F3             dx 0006, 01FA,18,E0D2, 01FA,E0,60D2, 01FF,00,E0F2, 01FF,08,E0E2, 01FF,F8,60F2, 01FF,F0,60E2

; Facing right - closed
$A6:FA13             dx 0008, 0000,18,A0D1, 0000,E0,20D1, 0000,10,A0D3, 0000,E8,20D3, 0000,00,A0F2, 0000,08,A0E2, 0000,F8,20F2, 0000,F0,20E2

; Facing right - opening frame 1
$A6:FA3D             dx 0008, 0000,10,A0F3, 0000,18,A0E3, 0000,E8,20F3, 0000,E0,20E3, 01FE,00,A0F2, 01FE,08,A0E2, 01FE,F8,20F2, 01FE,F0,20E2

; Facing right - opening frame 2
$A6:FA67             dx 0006, 0000,18,A0D0, 0000,E0,20D0, 01FC,00,A0F2, 01FC,08,A0E2, 01FC,F8,20F2, 01FC,F0,20E2

; Facing right - opening frame 3
$A6:FA87             dx 0006, 0000,18,A0D2, 0000,E0,20D2, 01FA,00,A0F2, 01FA,08,A0E2, 01FA,F8,20F2, 01FA,F0,20E2

; Facing right - open
$A6:FAA7             dx 0006, 01FE,18,A0D2, 01FE,E0,20D2, 01F9,00,A0F2, 01F9,08,A0E2, 01F9,F8,20F2, 01F9,F0,20E2

; Placeholder
$A6:FAC7             dx 0001, 0008,08,2020

; Ridley escape mode 7 left wall
$A6:FACE             dx 0013, C3F8,40,04E6, C3F8,20,04E8, C3F8,D0,84E8, C218,20,04EE, C3F8,80,04E6, C3F8,A0,04E6, C3F8,B0,04E6, C3F8,90,04E6, C3F8,C0,04E6, C218,40,04EE, C218,30,04EE, C208,40,04EE, C208,30,04EE, C208,20,04EE, C3F8,30,04E6, C3F8,00,84E4, C3F8,10,84E0, C3F8,F0,04E4, C3F8,E0,04E0

; Ridley escape mode 7 right wall
$A6:FB2F             dx 000D, C3F8,80,04E6, C3F8,90,04E6, C3F8,A0,04E6, C3F8,B0,04E6, C3F8,C0,04E6, C3F8,D0,04E6, C3F8,E0,04E6, C3F8,F0,04E6, C3F8,00,04E6, C3F8,10,04E6, C3F8,20,04E6, C3F8,40,84E8, C3F8,30,04E6
}
}


;;; $FB72..FEBB: Zebetites ;;;
{
;;; $FB72: Initialisation AI - enemy $E27F (zebetites) ;;;
{
; Also enemy unknown - enemy $E23F (Ceres door)
$A6:FB72 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:FB75 BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A6:FB78 09 00 A0    ORA #$A000             ;} Set enemy hitbox solid to Samus and process instructions
$A6:FB7B 9D 86 0F    STA $0F86,x[$7E:1006]  ;/
$A6:FB7E A9 01 00    LDA #$0001             ;\
$A6:FB81 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$A6:FB84 9E 90 0F    STZ $0F90,x[$7E:1010]  ; Enemy timer = 0
$A6:FB87 A9 00 04    LDA #$0400             ;\
$A6:FB8A 9D 96 0F    STA $0F96,x[$7E:1016]  ;} Enemy palette index = 400h (palette 2)
$A6:FB8D A9 80 00    LDA #$0080             ;\
$A6:FB90 9D 98 0F    STA $0F98,x[$7E:1018]  ;} Enemy VRAM tiles index = 80h
$A6:FB93 9E AC 0F    STZ $0FAC,x[$7E:102C]  ; Enemy $0FAC = 0
$A6:FB96 A0 41 FC    LDY #$FC41             ; Enemy function = $FC41
$A6:FB99 BD B4 0F    LDA $0FB4,x[$7E:1034]  ;\
$A6:FB9C F0 03       BEQ $03    [$FBA1]     ;} If [enemy parameter 1] != 0:
$A6:FB9E A0 5B FC    LDY #$FC5B             ; Enemy function = $FC5B

$A6:FBA1 98          TYA
$A6:FBA2 9D A8 0F    STA $0FA8,x[$7E:1028]
$A6:FBA5 64 12       STZ $12    [$7E:0012]  ;\
$A6:FBA7 A9 05 00    LDA #$0005             ;|
$A6:FBAA 22 33 82 80 JSL $808233[$80:8233]  ;|
$A6:FBAE 26 12       ROL $12    [$7E:0012]  ;|
$A6:FBB0 A9 04 00    LDA #$0004             ;|
$A6:FBB3 22 33 82 80 JSL $808233[$80:8233]  ;|
$A6:FBB7 26 12       ROL $12    [$7E:0012]  ;} Enemy $0FAE = bitflags for each Zebetite being destroyed
$A6:FBB9 A9 03 00    LDA #$0003             ;|
$A6:FBBC 22 33 82 80 JSL $808233[$80:8233]  ;|
$A6:FBC0 26 12       ROL $12    [$7E:0012]  ;|
$A6:FBC2 A5 12       LDA $12    [$7E:0012]  ;|
$A6:FBC4 9D AE 0F    STA $0FAE,x[$7E:102E]  ;/
$A6:FBC7 C9 04 00    CMP #$0004             ;\
$A6:FBCA 30 0A       BMI $0A    [$FBD6]     ;} If zebetite 3 destroyed:
$A6:FBCC BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A6:FBCF 09 00 02    ORA #$0200             ;} Set enemy to delete
$A6:FBD2 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A6:FBD5 6B          RTL                    ; Return

$A6:FBD6 0A          ASL A                  ;\
$A6:FBD7 A8          TAY                    ;} Y = [enemy $0FAE] * 2
$A6:FBD8 B9 03 FC    LDA $FC03,y[$A6:FC03]  ;\
$A6:FBDB 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy $0FB2 = [$FC03 + [Y]]
$A6:FBDE B9 0B FC    LDA $FC0B,y[$A6:FC0B]  ;\
$A6:FBE1 9D 84 0F    STA $0F84,x[$7E:1004]  ;} Enemy Y radius = [$FC0B + [Y]]
$A6:FBE4 B9 13 FC    LDA $FC13,y[$A6:FC13]  ;\
$A6:FBE7 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = [$FC13 + [Y]]
$A6:FBEA B9 1B FC    LDA $FC1B,y[$A6:FC1B]  ;\
$A6:FBED 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;} Enemy X position = [$FC1B + [Y]]
$A6:FBF0 BD B4 0F    LDA $0FB4,x[$7E:1034]  ;\
$A6:FBF3 F0 07       BEQ $07    [$FBFC]     ;} If [enemy parameter 1] != 0:
$A6:FBF5 B9 2B FC    LDA $FC2B,y[$A6:FC2D]  ;\
$A6:FBF8 9D 7E 0F    STA $0F7E,x[$7E:10FE]  ;} Enemy Y position = [$FC2B + [Y]]
$A6:FBFB 6B          RTL                    ; Return

$A6:FBFC B9 23 FC    LDA $FC23,y[$A6:FC23]  ;\
$A6:FBFF 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;} Enemy Y position = [$FC23 + [Y]]
$A6:FC02 6B          RTL

; Zebetites destroyed:  None 1    2    1+2
$A6:FC03             dw 0000,8000,0000,8000 ; $0FB2
$A6:FC0B             dw 0018,0008,0018,0008 ; Height
$A6:FC13             dw FDCC,FDEA,FDCC,FDEA ; Instruction list pointer
$A6:FC1B             dw 0338,0278,01B8,00F8 ; X position
$A6:FC23             dw 006F,0047,006F,0047 ; Y position - [enemy parameter 1] = 0
$A6:FC2B             dw 006F,0097,006F,0097 ; Y position - [enemy parameter 1] != 0
}


;;; $FC33: Main AI - enemy $E27F (zebetites) ;;;
{
$A6:FC33 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:FC36 AD 40 18    LDA $1840  [$7E:1840]  ;\
$A6:FC39 D0 03       BNE $03    [$FC3E]     ;} If [earthquake timer] = 0:
$A6:FC3B 9E A2 0F    STZ $0FA2,x[$7E:1022]  ; Enemy $0FA2 = 0

$A6:FC3E 7C A8 0F    JMP ($0FA8,x)[$A6:FC41]; Execute [enemy function]
}


;;; $FC41:  ;;;
{
$A6:FC41 BD B2 0F    LDA $0FB2,x[$7E:1032]
$A6:FC44 10 0F       BPL $0F    [$FC55]
$A6:FC46 20 F1 FC    JSR $FCF1  [$A6:FCF1]
$A6:FC49 AD 54 0E    LDA $0E54  [$7E:0E54]
$A6:FC4C 9D B6 0F    STA $0FB6,x[$7E:1136]
$A6:FC4F A8          TAY
$A6:FC50 8A          TXA
$A6:FC51 BB          TYX
$A6:FC52 9D B6 0F    STA $0FB6,x[$7E:1036]

$A6:FC55 A9 5B FC    LDA #$FC5B
$A6:FC58 9D A8 0F    STA $0FA8,x[$7E:1028]
$A6:FC5B AD 95 07    LDA $0795  [$7E:0795]
$A6:FC5E F0 01       BEQ $01    [$FC61]
$A6:FC60 6B          RTL

$A6:FC61 A9 67 FC    LDA #$FC67
$A6:FC64 9D A8 0F    STA $0FA8,x[$7E:1028]
$A6:FC67 20 5E FD    JSR $FD5E  [$A6:FD5E]
$A6:FC6A 20 09 FD    JSR $FD09  [$A6:FD09]
$A6:FC6D AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:FC70 BD 8C 0F    LDA $0F8C,x[$7E:100C]
$A6:FC73 F0 10       BEQ $10    [$FC85]
$A6:FC75 18          CLC
$A6:FC76 69 01 00    ADC #$0001
$A6:FC79 C9 E8 03    CMP #$03E8
$A6:FC7C 30 03       BMI $03    [$FC81]
$A6:FC7E A9 E8 03    LDA #$03E8

$A6:FC81 9D 8C 0F    STA $0F8C,x[$7E:100C]
$A6:FC84 6B          RTL

$A6:FC85 BD B4 0F    LDA $0FB4,x[$7E:1034]
$A6:FC88 F0 07       BEQ $07    [$FC91]

$A6:FC8A A9 00 00    LDA #$0000             ; A = 0 (small explosion)
$A6:FC8D 5C AF A3 A0 JML $A0A3AF[$A0:A3AF]  ; Go to enemy death

$A6:FC91 20 AA FC    JSR $FCAA  [$A6:FCAA]
$A6:FC94 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:FC97 BD AE 0F    LDA $0FAE,x[$7E:102E]
$A6:FC9A C9 04 00    CMP #$0004
$A6:FC9D 10 EB       BPL $EB    [$FC8A]
$A6:FC9F A9 00 00    LDA #$0000             ; A = 0 (small explosion)
$A6:FCA2 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death
$A6:FCA6 20 D9 FC    JSR $FCD9  [$A6:FCD9]
$A6:FCA9 6B          RTL
}


;;; $FCAA:  ;;;
{
$A6:FCAA AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:FCAD BD AE 0F    LDA $0FAE,x[$7E:102E]
$A6:FCB0 1A          INC A
$A6:FCB1 9D AE 0F    STA $0FAE,x[$7E:102E]
$A6:FCB4 85 12       STA $12    [$7E:0012]
$A6:FCB6 A0 03 00    LDY #$0003
$A6:FCB9 66 12       ROR $12    [$7E:0012]
$A6:FCBB 20 CB FC    JSR $FCCB  [$A6:FCCB]
$A6:FCBE A0 04 00    LDY #$0004
$A6:FCC1 66 12       ROR $12    [$7E:0012]
$A6:FCC3 20 CB FC    JSR $FCCB  [$A6:FCCB]
$A6:FCC6 A0 05 00    LDY #$0005
$A6:FCC9 66 12       ROR $12    [$7E:0012]
}


;;; $FCCB:  ;;;
{
$A6:FCCB 90 06       BCC $06    [$FCD3]
$A6:FCCD 98          TYA
$A6:FCCE 22 FA 81 80 JSL $8081FA[$80:81FA]
$A6:FCD2 60          RTS

$A6:FCD3 98          TYA
$A6:FCD4 22 12 82 80 JSL $808212[$80:8212]
$A6:FCD8 60          RTS
}


;;; $FCD9: Spawn top zebetite ;;;
{
$A6:FCD9 A2 E1 FC    LDX #$FCE1             ;\
$A6:FCDC 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn top zebetite
$A6:FCE0 60          RTS

;                        ___________________________________________ Enemy ID
;                       |      _____________________________________ X position
;                       |     |      _______________________________ Y position
;                       |     |     |      _________________________ Initialisation parameter (orientation in SMILE)
;                       |     |     |     |      ___________________ Properties (special in SMILE)
;                       |     |     |     |     |      _____________ Extra properties (special graphics bitset in SMILE)
;                       |     |     |     |     |     |      _______ General purpose parameter (speed in SMILE)
;                       |     |     |     |     |     |     |      _ General purpose parameter (speed2 in SMILE)
;                       |     |     |     |     |     |     |     |
$A6:FCE1             dw E27F, 0000, 0000, 0000, 2000, 0000, 0000, 0000 ; Zebetites
}


;;; $FCF1: Spawn bottom zebetite ;;;
{
$A6:FCF1 A2 F9 FC    LDX #$FCF9             ;\
$A6:FCF4 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn bottom zebetite
$A6:FCF8 60          RTS

;                        ___________________________________________ Enemy ID
;                       |      _____________________________________ X position
;                       |     |      _______________________________ Y position
;                       |     |     |      _________________________ Initialisation parameter (orientation in SMILE)
;                       |     |     |     |      ___________________ Properties (special in SMILE)
;                       |     |     |     |     |      _____________ Extra properties (special graphics bitset in SMILE)
;                       |     |     |     |     |     |      _______ General purpose parameter (speed in SMILE)
;                       |     |     |     |     |     |     |      _ General purpose parameter (speed2 in SMILE)
;                       |     |     |     |     |     |     |     |
$A6:FCF9             dw E27F, 0000, 0000, 0000, 2000, 0000, 0002, 0000 ; Zebetites
}


;;; $FD09:  ;;;
{
$A6:FD09 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:FD0C A0 00 00    LDY #$0000
$A6:FD0F BD 8C 0F    LDA $0F8C,x[$7E:100C]
$A6:FD12 C9 20 03    CMP #$0320
$A6:FD15 10 1B       BPL $1B    [$FD32]
$A6:FD17 A0 02 00    LDY #$0002
$A6:FD1A C9 58 02    CMP #$0258
$A6:FD1D 10 13       BPL $13    [$FD32]
$A6:FD1F A0 04 00    LDY #$0004
$A6:FD22 C9 90 01    CMP #$0190
$A6:FD25 10 0B       BPL $0B    [$FD32]
$A6:FD27 A0 06 00    LDY #$0006
$A6:FD2A C9 C8 00    CMP #$00C8
$A6:FD2D 10 03       BPL $03    [$FD32]
$A6:FD2F A0 08 00    LDY #$0008

$A6:FD32 B9 4A FD    LDA $FD4A,y[$A6:FD4A]
$A6:FD35 3C B2 0F    BIT $0FB2,x[$7E:1032]
$A6:FD38 10 03       BPL $03    [$FD3D]
$A6:FD3A B9 54 FD    LDA $FD54,y[$A6:FD54]

$A6:FD3D 9D 92 0F    STA $0F92,x[$7E:1012]
$A6:FD40 A9 01 00    LDA #$0001
$A6:FD43 9D 94 0F    STA $0F94,x[$7E:1014]
$A6:FD46 9E 90 0F    STZ $0F90,x[$7E:1010]
$A6:FD49 60          RTS

$A6:FD4A             dw FDCC, FDD2, FDD8, FDDE, FDE4
$A6:FD54             dw FDEA, FDF0, FDF6, FDFC, FE02
}


;;; $FD5E:  ;;;
{
$A6:FD5E AF 00 C4 7E LDA $7EC400[$7E:C400]
$A6:FD62 D0 22       BNE $22    [$FD86]
$A6:FD64 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:FD67 BD B4 0F    LDA $0FB4,x[$7E:1034]
$A6:FD6A D0 1A       BNE $1A    [$FD86]
$A6:FD6C AD AC 0F    LDA $0FAC  [$7E:0FAC]
$A6:FD6F 1A          INC A
$A6:FD70 29 07 00    AND #$0007
$A6:FD73 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A6:FD76 0A          ASL A
$A6:FD77 0A          ASL A
$A6:FD78 69 87 FD    ADC #$FD87
$A6:FD7B A8          TAY
$A6:FD7C A2 58 01    LDX #$0158             ;\
$A6:FD7F A9 02 00    LDA #$0002             ;} Sprite palette 2 colours Ch..Dh = 4 bytes from $A6:[Y]
$A6:FD82 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/

$A6:FD86 60          RTS

$A6:FD87             dw 005F,0037,
                        003F,0019,
                        003F,001B,
                        001F,001D,
                        001F,001F,
                        001F,001D,
                        003F,001B,
                        003F,0019
}


;;; $FDA7: Enemy touch - enemy $E27F (zebetites) ;;;
{
$A6:FDA7 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal enemy touch AI - no death check
$A6:FDAB 6B          RTL
}


;;; $FDAC: Enemy shot - enemy $E27F (zebetites) ;;;
{
$A6:FDAC 48          PHA                    ;\
$A6:FDAD A9 09 00    LDA #$0009             ;|
$A6:FDB0 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 9, sound library 3, max queued sounds allowed = 6 (shot zebetite)
$A6:FDB4 68          PLA                    ;/
$A6:FDB5 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A6:FDB9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A6:FDBC BC B6 0F    LDY $0FB6,x[$7E:1036]
$A6:FDBF BD 8C 0F    LDA $0F8C,x[$7E:100C]
$A6:FDC2 99 8C 0F    STA $0F8C,y[$7E:0F8C]
$A6:FDC5 BD 9C 0F    LDA $0F9C,x[$7E:101C]
$A6:FDC8 99 9C 0F    STA $0F9C,y[$7E:0F9C]
$A6:FDCB 6B          RTL
}


;;; $FDCC..FE07: Instruction lists - zebetites ;;;
{
;;; $FDCC: Instruction list - big zebetite - HP >= 800 ;;;
{
$A6:FDCC             dx 0001,FE08,
                        812F        ; Sleep
}


;;; $FDD2: Instruction list - big zebetite - HP < 800 ;;;
{
$A6:FDD2             dx 0001,FE19,
                        812F        ; Sleep
}


;;; $FDD8: Instruction list - big zebetite - HP < 600 ;;;
{
$A6:FDD8             dx 0001,FE2A,
                        812F        ; Sleep
}


;;; $FDDE: Instruction list - big zebetite - HP < 400 ;;;
{
$A6:FDDE             dx 0001,FE4A,
                        812F        ; Sleep
}


;;; $FDE4: Instruction list - big zebetite - HP < 200 ;;;
{
$A6:FDE4             dx 0001,FE6A,
                        812F        ; Sleep
}


;;; $FDEA: Instruction list - small zebetite pair - HP >= 800 ;;;
{
$A6:FDEA             dx 0001,FE8A,
                        812F        ; Sleep
}


;;; $FDF0: Instruction list - small zebetite pair - HP < 800 ;;;
{
$A6:FDF0             dx 0001,FE91,
                        812F        ; Sleep
}


;;; $FDF6: Instruction list - small zebetite pair - HP < 600 ;;;
{
$A6:FDF6             dx 0001,FE98,
                        812F        ; Sleep
}


;;; $FDFC: Instruction list - small zebetite pair - HP < 400 ;;;
{
$A6:FDFC             dx 0001,FEA4,
                        812F        ; Sleep
}


;;; $FE02: Instruction list - small zebetite pair - HP < 200 ;;;
{
$A6:FE02             dx 0001,FEB0,
                        812F        ; Sleep
}
}


;;; $FE08: Spritemaps - zebetites ;;;
{
; Big zebetite - HP >= 800
$A6:FE08             dx 0003, C3F8,08,310C, C3F8,F8,310C, C3F8,E8,310C

; Big zebetite - HP < 800
$A6:FE19             dx 0003, C3F8,08,310E, C3F8,F8,310E, C3F8,E8,310E

; Big zebetite - HP < 600
$A6:FE2A             dx 0006, 01FC,10,3121, 01FC,08,3120, 01FC,00,3121, 01FC,F8,3120, 01FC,F0,3121, 01FC,E8,3120

; Big zebetite - HP < 400
$A6:FE4A             dx 0006, 01FC,10,3123, 01FC,08,3122, 01FC,00,3123, 01FC,F8,3122, 01FC,F0,3123, 01FC,E8,3122

; Big zebetite - HP < 200
$A6:FE6A             dx 0006, 01FC,10,3125, 01FC,00,3125, 01FC,08,3124, 01FC,F8,3124, 01FC,F0,3125, 01FC,E8,3124

; Small zebetite pair - HP >= 800
$A6:FE8A             dx 0001, C3F8,F8,310C

; Small zebetite pair - HP < 800
$A6:FE91             dx 0001, C3F8,F8,310E

; Small zebetite pair - HP < 600
$A6:FE98             dx 0002, 01FC,00,3121, 01FC,F8,3120

; Small zebetite pair - HP < 400
$A6:FEA4             dx 0002, 01FC,00,3123, 01FC,F8,3122

; Small zebetite pair - HP < 200
$A6:FEB0             dx 0002, 01FC,00,3125, 01FC,F8,3124
}
}


;;; $FEBC: Free space ;;;
{
$A6:FEBC             fillto $A78000, $FF        ; Free space
}
