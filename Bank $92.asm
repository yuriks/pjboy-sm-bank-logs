;;; $8000: Set Samus tiles definitions for current animation ;;;
{
$92:8000 08          PHP
$92:8001 8B          PHB
$92:8002 4B          PHK                    ;\
$92:8003 AB          PLB                    ;} DB = $92
$92:8004 C2 30       REP #$30
$92:8006 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$92:8009 0A          ASL A                  ;|
$92:800A 0A          ASL A                  ;} $12 = [Samus animation frame] * 4
$92:800B 85 12       STA $12    [$7E:0012]  ;/
$92:800D 1A          INC A                  ;\
$92:800E 1A          INC A                  ;} $14 = [Samus animation frame] * 4 + 2
$92:800F 85 14       STA $14    [$7E:0014]  ;/
$92:8011 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$92:8014 0A          ASL A                  ;|
$92:8015 AA          TAX                    ;|
$92:8016 BD 4E D9    LDA $D94E,x[$92:D952]  ;} X = [$D94E + [Samus pose] * 2] + [Samus animation frame] * 4
$92:8019 18          CLC                    ;|
$92:801A 65 12       ADC $12    [$7E:0012]  ;|
$92:801C AA          TAX                    ;/
$92:801D BD 00 00    LDA $0000,x[$92:DB6C]  ;\
$92:8020 29 FF 00    AND #$00FF             ;} $16 = [[X]]
$92:8023 85 16       STA $16    [$7E:0016]  ;/
$92:8025 0A          ASL A                  ;\
$92:8026 A8          TAY                    ;|
$92:8027 E8          INX                    ;|
$92:8028 BD 00 00    LDA $0000,x[$92:DB6D]  ;|
$92:802B 29 FF 00    AND #$00FF             ;|
$92:802E 8D 24 0B    STA $0B24  [$7E:0B24]  ;|
$92:8031 0A          ASL A                  ;|
$92:8032 0A          ASL A                  ;|
$92:8033 0A          ASL A                  ;} Samus top half tiles definition = [$D91E + [[X]] * 2] + [[X] + 1] * 7
$92:8034 38          SEC                    ;|
$92:8035 ED 24 0B    SBC $0B24  [$7E:0B24]  ;|
$92:8038 85 12       STA $12    [$7E:0012]  ;|
$92:803A B9 1E D9    LDA $D91E,y[$92:D92C]  ;|
$92:803D 18          CLC                    ;|
$92:803E 65 12       ADC $12    [$7E:0012]  ;|
$92:8040 8D 1F 07    STA $071F  [$7E:071F]  ;/
$92:8043 E2 20       SEP #$20               ;\
$92:8045 A9 01       LDA #$01               ;|
$92:8047 8D 1D 07    STA $071D  [$7E:071D]  ;} Flag transfer for Samus top half tiles to VRAM
$92:804A C2 20       REP #$20               ;/
$92:804C AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$92:804F 0A          ASL A                  ;|
$92:8050 AA          TAX                    ;|
$92:8051 BD 4E D9    LDA $D94E,x[$92:D952]  ;} X = [$D94E + [Samus pose] * 2] + [Samus animation frame] * 4 + 2
$92:8054 18          CLC                    ;|
$92:8055 65 14       ADC $14    [$7E:0014]  ;|
$92:8057 AA          TAX                    ;/
$92:8058 BD 00 00    LDA $0000,x[$92:DB6E]  ;\
$92:805B 29 FF 00    AND #$00FF             ;|
$92:805E C9 FF 00    CMP #$00FF             ;} If [[X]] = FFh: return
$92:8061 F0 27       BEQ $27    [$808A]     ;/
$92:8063 0A          ASL A                  ;\
$92:8064 A8          TAY                    ;|
$92:8065 E8          INX                    ;|
$92:8066 BD 00 00    LDA $0000,x[$92:DB6F]  ;|
$92:8069 29 FF 00    AND #$00FF             ;|
$92:806C 8D 26 0B    STA $0B26  [$7E:0B26]  ;|
$92:806F 0A          ASL A                  ;|
$92:8070 0A          ASL A                  ;|
$92:8071 0A          ASL A                  ;} Samus bottom half tiles definition = [$D938 + [[X]] * 2] + [[X] + 1] * 7
$92:8072 38          SEC                    ;|
$92:8073 ED 26 0B    SBC $0B26  [$7E:0B26]  ;|
$92:8076 85 14       STA $14    [$7E:0014]  ;|
$92:8078 B9 38 D9    LDA $D938,y[$92:D938]  ;|
$92:807B 18          CLC                    ;|
$92:807C 65 14       ADC $14    [$7E:0014]  ;|
$92:807E 8D 21 07    STA $0721  [$7E:0721]  ;/
$92:8081 E2 20       SEP #$20               ;\
$92:8083 A9 01       LDA #$01               ;|
$92:8085 8D 1E 07    STA $071E  [$7E:071E]  ;} Flag transfer for Samus bottom half tiles to VRAM
$92:8088 C2 20       REP #$20               ;/

$92:808A AB          PLB
$92:808B 28          PLP
$92:808C 6B          RTL
}


;;; $808D: Samus spritemap table ;;;
{
; Indexed by [$92:9263/945D + [Samus pose] * 2] + [Samus animation frame]
$92:808D             dW 90ED ; 0000
                        90F4 ; 0001

; Top half - 00: Facing forward - power suit
                        9A6F ; 0002
                        0000 ; 0003
                        A13A ; 0004
                        A12C ; 0005
                        A169 ; 0006
                        A12C ; 0007
                        A18E ; 0008
                        A12C ; 0009
                        A13A ; 000A
                        A12C ; 000B
                        A169 ; 000C
                        A12C ; 000D
                        A18E ; 000E
                        A12C ; 000F
                        A13A ; 0010
                        A12C ; 0011
                        A169 ; 0012
                        A12C ; 0013
                        A18E ; 0014
                        A12C ; 0015
                        A13A ; 0016
                        A12C ; 0017
                        A169 ; 0018
                        A12C ; 0019
                        A18E ; 001A
                        A12C ; 001B
                        A13A ; 001C
                        A12C ; 001D
                        A169 ; 001E
                        A12C ; 001F
                        A18E ; 0020
                        A12C ; 0021
                        A13A ; 0022
                        A12C ; 0023
                        A169 ; 0024
                        A12C ; 0025
                        A18E ; 0026
                        A12C ; 0027
                        A13A ; 0028
                        A12C ; 0029
                        A169 ; 002A
                        A12C ; 002B
                        A18E ; 002C
                        A12C ; 002D
                        A13A ; 002E
                        A12C ; 002F
                        A169 ; 0030
                        A12C ; 0031
                        A18E ; 0032
                        A12C ; 0033
                        A13A ; 0034
                        A12C ; 0035
                        A169 ; 0036
                        A12C ; 0037
                        A18E ; 0038
                        A12C ; 0039
                        A13A ; 003A
                        A12C ; 003B
                        A169 ; 003C
                        A12C ; 003D
                        A18E ; 003E
                        A12C ; 003F
                        A13A ; 0040
                        A12C ; 0041
                        A169 ; 0042
                        A12C ; 0043
                        A18E ; 0044
                        A12C ; 0045
                        A13A ; 0046
                        A12C ; 0047
                        A169 ; 0048
                        A12C ; 0049
                        A18E ; 004A
                        A12C ; 004B
                        A13A ; 004C
                        A12C ; 004D
                        A169 ; 004E
                        A12C ; 004F
                        A18E ; 0050
                        A12C ; 0051
                        A1C7 ; 0052
                        A12C ; 0053
                        A214 ; 0054
                        A12C ; 0055
                        A23E ; 0056
                        A12C ; 0057
                        A272 ; 0058
                        A12C ; 0059
                        A2AB ; 005A
                        A12C ; 005B
                        A23E ; 005C
                        A12C ; 005D
                        A272 ; 005E
                        A12C ; 005F
                        A2AB ; 0060
                        A12C ; 0061

; Bottom half - 00: Facing forward - power suit
                        AE44 ; 0062
                        0000 ; 0063
                        B24E ; 0064
                        B24E ; 0065
                        B24E ; 0066
                        B24E ; 0067
                        B24E ; 0068
                        B24E ; 0069
                        B24E ; 006A
                        B24E ; 006B
                        B24E ; 006C
                        B24E ; 006D
                        B24E ; 006E
                        B24E ; 006F
                        B24E ; 0070
                        B24E ; 0071
                        B24E ; 0072
                        B24E ; 0073
                        B24E ; 0074
                        B24E ; 0075
                        B24E ; 0076
                        B24E ; 0077
                        B24E ; 0078
                        B24E ; 0079
                        B24E ; 007A
                        B24E ; 007B
                        B24E ; 007C
                        B24E ; 007D
                        B24E ; 007E
                        B24E ; 007F
                        B24E ; 0080
                        B24E ; 0081
                        B24E ; 0082
                        B24E ; 0083
                        B24E ; 0084
                        B24E ; 0085
                        B24E ; 0086
                        B24E ; 0087
                        B24E ; 0088
                        B24E ; 0089
                        B24E ; 008A
                        B24E ; 008B
                        B24E ; 008C
                        B24E ; 008D
                        B24E ; 008E
                        B24E ; 008F
                        B24E ; 0090
                        B24E ; 0091
                        B24E ; 0092
                        B24E ; 0093
                        B24E ; 0094
                        B24E ; 0095
                        B24E ; 0096
                        B24E ; 0097
                        B24E ; 0098
                        B24E ; 0099
                        B24E ; 009A
                        B24E ; 009B
                        B24E ; 009C
                        B24E ; 009D
                        B24E ; 009E
                        B24E ; 009F
                        B24E ; 00A0
                        B24E ; 00A1
                        B24E ; 00A2
                        B24E ; 00A3
                        B24E ; 00A4
                        B24E ; 00A5
                        B24E ; 00A6
                        B24E ; 00A7
                        B24E ; 00A8
                        B24E ; 00A9
                        B24E ; 00AA
                        B24E ; 00AB
                        B24E ; 00AC
                        B24E ; 00AD
                        B24E ; 00AE
                        B24E ; 00AF
                        B24E ; 00B0
                        B24E ; 00B1
                        B24E ; 00B2
                        B24E ; 00B3
                        B24E ; 00B4
                        B24E ; 00B5
                        B24E ; 00B6
                        B24E ; 00B7
                        B24E ; 00B8
                        B24E ; 00B9
                        B24E ; 00BA
                        B24E ; 00BB
                        B24E ; 00BC
                        B24E ; 00BD
                        B24E ; 00BE
                        B24E ; 00BF
                        B24E ; 00C0
                        B24E ; 00C1

; Top half - 9B: Facing forward - varia/gravity suit
                        9976 ; 00C2
                        0000 ; 00C3
                        A13A ; 00C4
                        A12C ; 00C5
                        A169 ; 00C6
                        A12C ; 00C7
                        A18E ; 00C8
                        A12C ; 00C9
                        A13A ; 00CA
                        A12C ; 00CB
                        A169 ; 00CC
                        A12C ; 00CD
                        A18E ; 00CE
                        A12C ; 00CF
                        A13A ; 00D0
                        A12C ; 00D1
                        A169 ; 00D2
                        A12C ; 00D3
                        A18E ; 00D4
                        A12C ; 00D5
                        A13A ; 00D6
                        A12C ; 00D7
                        A169 ; 00D8
                        A12C ; 00D9
                        A18E ; 00DA
                        A12C ; 00DB
                        A13A ; 00DC
                        A12C ; 00DD
                        A169 ; 00DE
                        A12C ; 00DF
                        A18E ; 00E0
                        A12C ; 00E1
                        A13A ; 00E2
                        A12C ; 00E3
                        A169 ; 00E4
                        A12C ; 00E5
                        A18E ; 00E6
                        A12C ; 00E7
                        A13A ; 00E8
                        A12C ; 00E9
                        A169 ; 00EA
                        A12C ; 00EB
                        A18E ; 00EC
                        A12C ; 00ED
                        A13A ; 00EE
                        A12C ; 00EF
                        A169 ; 00F0
                        A12C ; 00F1
                        A18E ; 00F2
                        A12C ; 00F3
                        A13A ; 00F4
                        A12C ; 00F5
                        A169 ; 00F6
                        A12C ; 00F7
                        A18E ; 00F8
                        A12C ; 00F9
                        A13A ; 00FA
                        A12C ; 00FB
                        A169 ; 00FC
                        A12C ; 00FD
                        A18E ; 00FE
                        A12C ; 00FF
                        A13A ; 0100
                        A12C ; 0101
                        A169 ; 0102
                        A12C ; 0103
                        A18E ; 0104
                        A12C ; 0105
                        A13A ; 0106
                        A12C ; 0107
                        A169 ; 0108
                        A12C ; 0109
                        A18E ; 010A
                        A12C ; 010B
                        A13A ; 010C
                        A12C ; 010D
                        A169 ; 010E
                        A12C ; 010F
                        A18E ; 0110
                        A12C ; 0111
                        A1C7 ; 0112
                        A12C ; 0113
                        A214 ; 0114
                        A12C ; 0115
                        A23E ; 0116
                        A12C ; 0117
                        A272 ; 0118
                        A12C ; 0119
                        A2AB ; 011A
                        A12C ; 011B
                        A23E ; 011C
                        A12C ; 011D
                        A272 ; 011E
                        A12C ; 011F
                        A2AB ; 0120
                        A12C ; 0121

; Bottom half - 9B: Facing forward - varia/gravity suit
                        AE6E ; 0122
                        0000 ; 0123
                        B26E ; 0124
                        B26E ; 0125
                        B26E ; 0126
                        B26E ; 0127
                        B26E ; 0128
                        B26E ; 0129
                        B26E ; 012A
                        B26E ; 012B
                        B26E ; 012C
                        B26E ; 012D
                        B26E ; 012E
                        B26E ; 012F
                        B26E ; 0130
                        B26E ; 0131
                        B26E ; 0132
                        B26E ; 0133
                        B26E ; 0134
                        B26E ; 0135
                        B26E ; 0136
                        B26E ; 0137
                        B26E ; 0138
                        B26E ; 0139
                        B26E ; 013A
                        B26E ; 013B
                        B26E ; 013C
                        B26E ; 013D
                        B26E ; 013E
                        B26E ; 013F
                        B26E ; 0140
                        B26E ; 0141
                        B26E ; 0142
                        B26E ; 0143
                        B26E ; 0144
                        B26E ; 0145
                        B26E ; 0146
                        B26E ; 0147
                        B26E ; 0148
                        B26E ; 0149
                        B26E ; 014A
                        B26E ; 014B
                        B26E ; 014C
                        B26E ; 014D
                        B26E ; 014E
                        B26E ; 014F
                        B26E ; 0150
                        B26E ; 0151
                        B26E ; 0152
                        B26E ; 0153
                        B26E ; 0154
                        B26E ; 0155
                        B26E ; 0156
                        B26E ; 0157
                        B26E ; 0158
                        B26E ; 0159
                        B26E ; 015A
                        B26E ; 015B
                        B26E ; 015C
                        B26E ; 015D
                        B26E ; 015E
                        B26E ; 015F
                        B26E ; 0160
                        B26E ; 0161
                        B26E ; 0162
                        B26E ; 0163
                        B26E ; 0164
                        B26E ; 0165
                        B26E ; 0166
                        B26E ; 0167
                        B26E ; 0168
                        B26E ; 0169
                        B26E ; 016A
                        B26E ; 016B
                        B26E ; 016C
                        B26E ; 016D
                        B26E ; 016E
                        B26E ; 016F
                        B26E ; 0170
                        B26E ; 0171
                        B26E ; 0172
                        B26E ; 0173
                        B26E ; 0174
                        B26E ; 0175
                        B26E ; 0176
                        B26E ; 0177
                        B26E ; 0178
                        B26E ; 0179
                        B26E ; 017A
                        B26E ; 017B
                        B26E ; 017C
                        B26E ; 017D
                        B26E ; 017E
                        B26E ; 017F
                        B26E ; 0180
                        B26E ; 0181

; Samus tile viewer - Samus top half
                        917A ; 0182
; Samus tile viewer - Samus bottom half
                        91CC ; 0183
; Samus tile viewer - beam
                        921E ; 0184
; Samus tile viewer - grapple beam
                        9248 ; 0185

                        D7D3 ; 0186
                        D7DF ; 0187
                        D7F0 ; 0188
                        D801 ; 0189
                        D812 ; 018A
                        D823 ; 018B
                        D834 ; 018C
                        D845 ; 018D
                        D851 ; 018E
                        D858 ; 018F
                        D869 ; 0190
                        D87A ; 0191
                        D895 ; 0192
                        D8B0 ; 0193
                        D8D5 ; 0194
                        D8F0 ; 0195
                        D906 ; 0196
                        D912 ; 0197
                        9657 ; 0198
                        9657 ; 0199

; Top half - 01: Facing right - normal
; Top half - 47: Unused
; Top half - 89: Facing right - ran into a wall
; Top half - A8: Unused
                        A072 ; 019A
                        A088 ; 019B
                        A09E ; 019C
                        A088 ; 019D
                        0000 ; 019E
                        A072 ; 019F
                        A088 ; 01A0
                        A0F6 ; 01A1
                        A088 ; 01A2

; Top half - 02: Facing left  - normal
; Top half - 48: Unused
; Top half - 8A: Facing left  - ran into a wall
; Top half - A9: Unused
                        A0B4 ; 01A3
                        A0CA ; 01A4
                        A0E0 ; 01A5
                        A0CA ; 01A6
                        0000 ; 01A7
                        A0B4 ; 01A8
                        A0CA ; 01A9
                        A111 ; 01AA
                        A0CA ; 01AB
                        9657 ; 01AC

; Top half - 03: Facing right - aiming up
                        97B1 ; 01AD
                        97FF ; 01AE

; Top half - 04: Facing left  - aiming up
                        97C7 ; 01AF
                        981A ; 01B0

; Top half - 05: Facing right - aiming up-right
; Top half - 57: Facing right - normal jump transition - aiming up-right
; Top half - CF: Facing right - ran into a wall - aiming up-right
; Top half - E2: Facing right - landing from normal jump - aiming up-right
; Top half - F3: Facing right - crouching transition - aiming up-right
; Top half - F9: Facing right - standing transition - aiming up-right
                        97B1 ; 01B1
                        97B1 ; 01B2

; Top half - 06: Facing left  - aiming up-left
; Top half - 58: Facing left  - normal jump transition - aiming up-left
; Top half - D0: Facing left  - ran into a wall - aiming up-left
; Top half - E3: Facing left  - landing from normal jump - aiming up-left
; Top half - F4: Facing left  - crouching transition - aiming up-left
; Top half - FA: Facing left  - standing transition - aiming up-left
                        97C7 ; 01B3
                        97C7 ; 01B4

; Top half - 07: Facing right - aiming down-right
; Top half - 59: Facing right - normal jump transition - aiming down-right
; Top half - AA: Unused
; Top half - D1: Facing right - ran into a wall - aiming down-right
; Top half - E4: Facing right - landing from normal jump - aiming down-right
; Top half - F5: Facing right - crouching transition - aiming down-right
; Top half - FB: Facing right - standing transition - aiming down-right
                        9745 ; 01B5
                        9745 ; 01B6

; Top half - 08: Facing left  - aiming down-left
; Top half - 5A: Facing left  - normal jump transition - aiming down-left
; Top half - AB: Unused
; Top half - D2: Facing left  - ran into a wall - aiming down-left
; Top half - E5: Facing left  - landing from normal jump - aiming down-left
; Top half - F6: Facing left  - crouching transition - aiming down-left
; Top half - FC: Facing left  - standing transition - aiming down-left
                        9760 ; 01B7
                        9760 ; 01B8

; Top half - A4: Facing right - landing from normal jump
                        9B6F ; 01B9
                        9BAE ; 01BA

; Top half - A5: Facing left  - landing from normal jump
                        9B80 ; 01BB
                        9BBF ; 01BC

; Top half - A6: Facing right - landing from spin jump
                        9BAE ; 01BD
                        9B6F ; 01BE
                        9BAE ; 01BF

; Top half - A7: Facing left  - landing from spin jump
                        9BBF ; 01C0
                        9B80 ; 01C1
                        9BBF ; 01C2

; Top half - D5: Facing right - x-ray - standing
; Top half - D9: Facing right - x-ray - crouching
                        9C26 ; 01C3
                        9C0B ; 01C4
                        977B ; 01C5
                        9C41 ; 01C6
                        9C5C ; 01C7

; Top half - D6: Facing left  - x-ray - standing
; Top half - DA: Facing left  - x-ray - crouching
                        9C92 ; 01C8
                        9C77 ; 01C9
                        9796 ; 01CA
                        9CAD ; 01CB
                        9CC8 ; 01CC

; Top half - 55: Facing right - normal jump transition - aiming up
; Top half - E0: Facing right - landing from normal jump - aiming up
; Top half - F1: Facing right - crouching transition - aiming up
; Top half - F7: Facing right - standing transition - aiming up
                        97FF ; 01CD
                        97FF ; 01CE

; Top half - 56: Facing left  - normal jump transition - aiming up
; Top half - E1: Facing left  - landing from normal jump - aiming up
; Top half - F2: Facing left  - crouching transition - aiming up
; Top half - F8: Facing left  - standing transition - aiming up
                        981A ; 01CF
                        981A ; 01D0

; Top half - E6: Facing right - landing from normal jump - firing
                        977B ; 01D1
                        977B ; 01D2

; Top half - E7: Facing left  - landing from normal jump - firing
                        9796 ; 01D3
                        9796 ; 01D4

; Top half - 49: Facing left  - moonwalk
                        9796 ; 01D5
                        9E48 ; 01D6
                        9E48 ; 01D7
                        9796 ; 01D8
                        9E48 ; 01D9
                        9E48 ; 01DA

; Top half - 4A: Facing right - moonwalk
                        977B ; 01DB
                        9E2D ; 01DC
                        9E2D ; 01DD
                        977B ; 01DE
                        9E2D ; 01DF
                        9E2D ; 01E0

; Top half - 75: Facing left  - moonwalk - aiming up-left
                        9872 ; 01E1
                        9CFE ; 01E2
                        9CFE ; 01E3
                        9872 ; 01E4
                        9CFE ; 01E5
                        9CFE ; 01E6

; Top half - 76: Facing right - moonwalk - aiming up-right
                        9857 ; 01E7
                        9CE3 ; 01E8
                        9CE3 ; 01E9
                        9857 ; 01EA
                        9CE3 ; 01EB
                        9CE3 ; 01EC

; Top half - 77: Facing left  - moonwalk - aiming down-left
                        9725 ; 01ED
                        9BEB ; 01EE
                        9BEB ; 01EF
                        9725 ; 01F0
                        9BEB ; 01F1
                        9BEB ; 01F2

; Top half - 78: Facing right - moonwalk - aiming down-right
                        9705 ; 01F3
                        9BCB ; 01F4
                        9BCB ; 01F5
                        9705 ; 01F6
                        9BCB ; 01F7
                        9BCB ; 01F8

; Top half - 09: Moving right - not aiming
                        9657 ; 01F9
                        9A3F ; 01FA
                        966F ; 01FB
                        9680 ; 01FC
                        9663 ; 01FD
                        9657 ; 01FE
                        9A4B ; 01FF
                        969D ; 0200
                        9835 ; 0201
                        9691 ; 0202

; Top half - 0A: Moving left  - not aiming
                        96AE ; 0203
                        9A57 ; 0204
                        96C6 ; 0205
                        96D7 ; 0206
                        96BA ; 0207
                        96AE ; 0208
                        9A63 ; 0209
                        96F4 ; 020A
                        9846 ; 020B
                        96E8 ; 020C

; Top half - 0B: Moving right - gun extended
                        A2D0 ; 020D
                        A440 ; 020E
                        A2F2 ; 020F
                        A308 ; 0210
                        A2E1 ; 0211
                        A2D0 ; 0212
                        A323 ; 0213
                        A334 ; 0214
                        A400 ; 0215
                        A323 ; 0216

; Top half - 0C: Moving left  - gun extended
                        A34A ; 0217
                        A451 ; 0218
                        A3A0 ; 0219
                        A380 ; 021A
                        A365 ; 021B
                        A34A ; 021C
                        A3C0 ; 021D
                        A41B ; 021E
                        A3DB ; 021F
                        A3C0 ; 0220

; Top half - 0D: Moving right - aiming up (unused)
                        97FF ; 0221
                        97FF ; 0222
                        9CAD ; 0223
                        9E9E ; 0224
                        9CAD ; 0225
                        97FF ; 0226
                        97FF ; 0227
                        9CAD ; 0228
                        9E9E ; 0229
                        9CAD ; 022A

; Top half - 0E: Moving left  - aiming up (unused)
                        981A ; 022B
                        981A ; 022C
                        9CC8 ; 022D
                        9EB9 ; 022E
                        9CC8 ; 022F
                        981A ; 0230
                        981A ; 0231
                        9CC8 ; 0232
                        9EB9 ; 0233
                        9CC8 ; 0234

; Top half - 0F: Moving right - aiming up-right
                        9857 ; 0235
                        9857 ; 0236
                        9CE3 ; 0237
                        9DB2 ; 0238
                        9CE3 ; 0239
                        9857 ; 023A
                        9857 ; 023B
                        9CE3 ; 023C
                        9DB2 ; 023D
                        9CE3 ; 023E

; Top half - 10: Moving left  - aiming up-left
                        9872 ; 023F
                        9872 ; 0240
                        9CFE ; 0241
                        9DCD ; 0242
                        9CFE ; 0243
                        9872 ; 0244
                        9872 ; 0245
                        9CFE ; 0246
                        9DCD ; 0247
                        9CFE ; 0248

; Top half - 11: Moving right - aiming down-right
                        9705 ; 0249
                        9705 ; 024A
                        9BCB ; 024B
                        9DED ; 024C
                        9BCB ; 024D
                        9705 ; 024E
                        9705 ; 024F
                        9BCB ; 0250
                        9DED ; 0251
                        9BCB ; 0252

; Top half - 12: Moving left  - aiming down-left
                        9725 ; 0253
                        9725 ; 0254
                        9BEB ; 0255
                        9E0D ; 0256
                        9BEB ; 0257
                        9725 ; 0258
                        9725 ; 0259
                        9BEB ; 025A
                        9E0D ; 025B
                        9BEB ; 025C

; Top half - 45: Unused
                        97EE ; 025D
                        97EE ; 025E
                        9C92 ; 025F
                        9E83 ; 0260
                        9C92 ; 0261
                        97EE ; 0262
                        97EE ; 0263
                        9C92 ; 0264
                        9E83 ; 0265
                        9C92 ; 0266

; Top half - 46: Unused
                        97DD ; 0267
                        97DD ; 0268
                        9C77 ; 0269
                        9E63 ; 026A
                        9C77 ; 026B
                        97DD ; 026C
                        97DD ; 026D
                        9C77 ; 026E
                        9E63 ; 026F
                        9C77 ; 0270

; Top half - 17: Facing right - normal jump - aiming down
; Top half - AE: Unused
                        9705 ; 0271
                        9B17 ; 0272

; Top half - 18: Facing left  - normal jump - aiming down
; Top half - AF: Unused
                        9725 ; 0273
                        9B2D ; 0274

; Top half - 13: Facing right - normal jump - not aiming - not moving - gun extended
; Top half - AC: Unused
                        977B ; 0275
                        977B ; 0276

; Top half - 14: Facing left  - normal jump - not aiming - not moving - gun extended
; Top half - AD: Unused
                        9796 ; 0277
                        9796 ; 0278

; Top half - 15: Facing right - normal jump - aiming up
                        97B1 ; 0279
                        97FF ; 027A

; Top half - 16: Facing left  - normal jump - aiming up
                        97C7 ; 027B
                        981A ; 027C

; Top half - 69: Facing right - normal jump - aiming up-right
                        9857 ; 027D
                        9857 ; 027E

; Top half - 6A: Facing left  - normal jump - aiming up-left
                        9872 ; 027F
                        9872 ; 0280

; Top half - 6B: Facing right - normal jump - aiming down-right
; Top half - B0: Unused
                        9705 ; 0281
                        9705 ; 0282

; Top half - 6C: Facing left  - normal jump - aiming down-left
; Top half - B1: Unused
                        9725 ; 0283
                        9725 ; 0284

; Top half - 51: Facing right - normal jump - not aiming - moving forward
                        977B ; 0285
                        977B ; 0286

; Top half - 52: Facing left  - normal jump - not aiming - moving forward
                        9796 ; 0287
                        9796 ; 0288

; Top half - 4B: Facing right - normal jump transition
                        9B6F ; 0289

; Top half - 4C: Facing left  - normal jump transition
                        9B80 ; 028A

; Top half - 4D: Facing right - normal jump - not aiming - not moving - gun not extended
; Top half - C7: Facing right - vertical shinespark windup
                        9691 ; 028B
                        969D ; 028C
                        9691 ; 028D
                        9657 ; 028E
                        9663 ; 028F
                        97DD ; 0290

; Top half - 4E: Facing left  - normal jump - not aiming - not moving - gun not extended
; Top half - C8: Facing left  - vertical shinespark windup
                        96E8 ; 0291
                        96F4 ; 0292
                        96E8 ; 0293
                        96AE ; 0294
                        96BA ; 0295
                        97EE ; 0296

; Top half - 4F: Facing left  - damage boost
                        9BBF ; 0297
                        9BBF ; 0298
                        BB94 ; 0299
                        BB88 ; 029A
                        BB72 ; 029B
                        BB66 ; 029C
                        BB50 ; 029D
                        BB44 ; 029E
                        BB2E ; 029F
                        9EB9 ; 02A0

; Top half - 50: Facing right - damage boost
                        9BAE ; 02A1
                        9BAE ; 02A2
                        BDD9 ; 02A3
                        BDCD ; 02A4
                        BDB7 ; 02A5
                        BDAB ; 02A6
                        BD95 ; 02A7
                        BD89 ; 02A8
                        BD73 ; 02A9
                        9E83 ; 02AA

; Top half - 63: Unused
                        9A93 ; 02AB
                        9A1F ; 02AC

; Top half - 64: Unused
                        9AAE ; 02AD
                        99FF ; 02AE

; Top half - 65: Unused
                        9A7B ; 02AF
                        BD67 ; 02B0
                        BD73 ; 02B1
                        BD89 ; 02B2
                        BD95 ; 02B3
                        BDAB ; 02B4
                        BDB7 ; 02B5
                        BDCD ; 02B6
                        BDD9 ; 02B7

; Top half - 66: Unused
                        9A87 ; 02B8
                        BB22 ; 02B9
                        BB2E ; 02BA
                        BB44 ; 02BB
                        BB50 ; 02BC
                        BB66 ; 02BD
                        BB72 ; 02BE
                        BB88 ; 02BF
                        BB94 ; 02C0

; Top half - 83: Facing right - wall jump
                        9A7B ; 02C1
                        9BAE ; 02C2
                        0000 ; 02C3
                        BD67 ; 02C4
                        BD73 ; 02C5
                        BD89 ; 02C6
                        BD95 ; 02C7
                        BDAB ; 02C8
                        BDB7 ; 02C9
                        BDCD ; 02CA
                        BDD9 ; 02CB
                        0000 ; 02CC
                        0000 ; 02CD
                        BEBF ; 02CE
                        BEBF ; 02CF
                        BEBF ; 02D0
                        BEBF ; 02D1
                        BEBF ; 02D2
                        BEBF ; 02D3
                        BEBF ; 02D4
                        BEBF ; 02D5
                        0000 ; 02D6
                        0000 ; 02D7
                        BDEF ; 02D8
                        BDEF ; 02D9
                        BDEF ; 02DA
                        BEBF ; 02DB
                        BEBF ; 02DC
                        BEBF ; 02DD
                        BE23 ; 02DE
                        BE23 ; 02DF
                        BE23 ; 02E0
                        BEBF ; 02E1
                        BEBF ; 02E2
                        BEBF ; 02E3
                        BE5C ; 02E4
                        BE5C ; 02E5
                        BE5C ; 02E6
                        BEBF ; 02E7
                        BEBF ; 02E8
                        BEBF ; 02E9
                        BE95 ; 02EA
                        BE95 ; 02EB
                        BE95 ; 02EC
                        BEBF ; 02ED
                        BEBF ; 02EE
                        BEBF ; 02EF

; Top half - 84: Facing left  - wall jump
                        9A87 ; 02F0
                        9BBF ; 02F1
                        0000 ; 02F2
                        BB22 ; 02F3
                        BB2E ; 02F4
                        BB44 ; 02F5
                        BB50 ; 02F6
                        BB66 ; 02F7
                        BB72 ; 02F8
                        BB88 ; 02F9
                        BB94 ; 02FA
                        0000 ; 02FB
                        0000 ; 02FC
                        BC7A ; 02FD
                        BC7A ; 02FE
                        BC7A ; 02FF
                        BC7A ; 0300
                        BC7A ; 0301
                        BC7A ; 0302
                        BC7A ; 0303
                        BC7A ; 0304
                        0000 ; 0305
                        0000 ; 0306
                        BBAA ; 0307
                        BBAA ; 0308
                        BBAA ; 0309
                        BC7A ; 030A
                        BC7A ; 030B
                        BC7A ; 030C
                        BBDE ; 030D
                        BBDE ; 030E
                        BBDE ; 030F
                        BC7A ; 0310
                        BC7A ; 0311
                        BC7A ; 0312
                        BC17 ; 0313
                        BC17 ; 0314
                        BC17 ; 0315
                        BC7A ; 0316
                        BC7A ; 0317
                        BC7A ; 0318
                        BC50 ; 0319
                        BC50 ; 031A
                        BC50 ; 031B
                        BC7A ; 031C
                        BC7A ; 031D
                        BC7A ; 031E

; Top half - 53: Facing right - knockback
                        98AD ; 031F
                        98AD ; 0320

; Top half - 54: Facing left  - knockback
                        9892 ; 0321
                        9892 ; 0322
                        9892 ; 0323
                        98AD ; 0324
                        9928 ; 0325
                        9928 ; 0326
                        9976 ; 0327
                        9912 ; 0328
                        9912 ; 0329
                        996F ; 032A
                        9998 ; 032B
                        99CE ; 032C
                        9982 ; 032D
                        99AE ; 032E

; Top half - 5B: Unused
; Top half - B8: Facing left  - grapple wall jump pose
                        9A1F ; 032F

; Top half - 5C: Unused
; Top half - B9: Facing right - grapple wall jump pose
                        99FF ; 0330

; Top half - 5D: Unused
; Top half - 5E: Unused
; Top half - 5F: Unused
                        9B2D ; 0331

; Top half - 60: Unused
                        9B17 ; 0332

; Top half - 61: Unused
; Top half - B2: Facing clockwise     - grapple
                        A96B ; 0333
                        A955 ; 0334
                        A944 ; 0335
                        A933 ; 0336
                        A922 ; 0337
                        A911 ; 0338
                        A900 ; 0339
                        A8EA ; 033A
                        A8D4 ; 033B
                        A584 ; 033C
                        A573 ; 033D
                        A562 ; 033E
                        A551 ; 033F
                        A540 ; 0340
                        A52F ; 0341
                        A519 ; 0342
                        A503 ; 0343
                        A4ED ; 0344
                        A4DC ; 0345
                        A4CB ; 0346
                        A4BA ; 0347
                        A4A9 ; 0348
                        A498 ; 0349
                        A482 ; 034A
                        A46C ; 034B
                        A9EC ; 034C
                        A9DB ; 034D
                        A9CA ; 034E
                        A9B9 ; 034F
                        A9A8 ; 0350
                        A997 ; 0351
                        A981 ; 0352
                        A96B ; 0353
                        A955 ; 0354
                        A944 ; 0355
                        A933 ; 0356
                        A922 ; 0357
                        A911 ; 0358
                        A900 ; 0359
                        A8EA ; 035A
                        A8D4 ; 035B
                        A584 ; 035C
                        A573 ; 035D
                        A562 ; 035E
                        A551 ; 035F
                        A540 ; 0360
                        A52F ; 0361
                        A519 ; 0362
                        A503 ; 0363
                        A4ED ; 0364
                        A4DC ; 0365
                        A4CB ; 0366
                        A4BA ; 0367
                        A4A9 ; 0368
                        A498 ; 0369
                        A482 ; 036A
                        A46C ; 036B
                        A9EC ; 036C
                        A9DB ; 036D
                        A9CA ; 036E
                        A9B9 ; 036F
                        A9A8 ; 0370
                        A997 ; 0371
                        A981 ; 0372
                        A503 ; 0373
                        A503 ; 0374

; Top half - 62: Unused
; Top half - B3: Facing anticlockwise - grapple
                        AB8B ; 0375
                        ABB5 ; 0376
                        ABDF ; 0377
                        AC0E ; 0378
                        AC42 ; 0379
                        AC76 ; 037A
                        ACAA ; 037B
                        ACDE ; 037C
                        A5B0 ; 037D
                        A5DA ; 037E
                        A604 ; 037F
                        A638 ; 0380
                        A66C ; 0381
                        A69B ; 0382
                        A6CA ; 0383
                        A6F9 ; 0384
                        A723 ; 0385
                        A74D ; 0386
                        A777 ; 0387
                        A7A6 ; 0388
                        A7DA ; 0389
                        A80E ; 038A
                        A842 ; 038B
                        A876 ; 038C
                        AA18 ; 038D
                        AA42 ; 038E
                        AA6C ; 038F
                        AAA0 ; 0390
                        AAD4 ; 0391
                        AB03 ; 0392
                        AB32 ; 0393
                        AB61 ; 0394
                        AB8B ; 0395
                        ABB5 ; 0396
                        ABDF ; 0397
                        AC0E ; 0398
                        AC42 ; 0399
                        AC76 ; 039A
                        ACAA ; 039B
                        ACDE ; 039C
                        A5B0 ; 039D
                        A5DA ; 039E
                        A604 ; 039F
                        A638 ; 03A0
                        A66C ; 03A1
                        A69B ; 03A2
                        A6CA ; 03A3
                        A6F9 ; 03A4
                        A723 ; 03A5
                        A74D ; 03A6
                        A777 ; 03A7
                        A7A6 ; 03A8
                        A7DA ; 03A9
                        A80E ; 03AA
                        A842 ; 03AB
                        A876 ; 03AC
                        AA18 ; 03AD
                        AA42 ; 03AE
                        AA6C ; 03AF
                        AAA0 ; 03B0
                        AAD4 ; 03B1
                        AB03 ; 03B2
                        AB32 ; 03B3
                        AB61 ; 03B4
                        A723 ; 03B5
                        A723 ; 03B6

; Top half - 29: Facing right - falling
                        9BAE ; 03B7
                        9E63 ; 03B8
                        9E83 ; 03B9
                        0000 ; 03BA
                        0000 ; 03BB
                        9E63 ; 03BC
                        9BAE ; 03BD

; Top half - 2A: Facing left  - falling
                        9BBF ; 03BE
                        9E9E ; 03BF
                        9EB9 ; 03C0
                        0000 ; 03C1
                        0000 ; 03C2
                        9E9E ; 03C3
                        9BBF ; 03C4

; Top half - 67: Facing right - falling - gun extended
                        977B ; 03C5
                        977B ; 03C6
                        977B ; 03C7
                        0000 ; 03C8
                        0000 ; 03C9
                        977B ; 03CA
                        977B ; 03CB

; Top half - 68: Facing left  - falling - gun extended
                        9796 ; 03CC
                        9796 ; 03CD
                        9796 ; 03CE
                        0000 ; 03CF
                        0000 ; 03D0
                        9796 ; 03D1
                        9796 ; 03D2

; Top half - 2B: Facing right - falling - aiming up
                        97B1 ; 03D3
                        97FF ; 03D4
                        97FF ; 03D5

; Top half - 2C: Facing left  - falling - aiming up
                        97C7 ; 03D6
                        981A ; 03D7
                        981A ; 03D8

; Top half - 2D: Facing right - falling - aiming down
                        9705 ; 03D9
                        9B17 ; 03DA

; Top half - 2E: Facing left  - falling - aiming down
                        9725 ; 03DB
                        9B2D ; 03DC

; Top half - 6D: Facing right - falling - aiming up-right
                        9857 ; 03DD
                        9857 ; 03DE
                        9857 ; 03DF

; Top half - 6E: Facing left  - falling - aiming up-left
                        9872 ; 03E0
                        9872 ; 03E1
                        9872 ; 03E2

; Top half - 6F: Facing right - falling - aiming down-right
                        9705 ; 03E3
                        9705 ; 03E4
                        9705 ; 03E5

; Top half - 70: Facing left  - falling - aiming down-left
                        9725 ; 03E6
                        9725 ; 03E7
                        9725 ; 03E8

; Top half - 71: Facing right - crouching - aiming up-right
                        97B1 ; 03E9

; Top half - 72: Facing left  - crouching - aiming up-left
                        97C7 ; 03EA

; Top half - 73: Facing right - crouching - aiming down-right
; Top half - B6: Unused
                        9745 ; 03EB

; Top half - 74: Facing left  - crouching - aiming down-left
; Top half - B7: Unused
                        9760 ; 03EC

; Top half - 85: Facing right - crouching - aiming up
                        97B1 ; 03ED
                        97FF ; 03EE

; Top half - 86: Facing left  - crouching - aiming up
                        97C7 ; 03EF
                        981A ; 03F0

; Top half - 27: Facing right - crouching
; Top half - B4: Unused
                        A072 ; 03F1
                        A088 ; 03F2
                        A09E ; 03F3
                        A088 ; 03F4
                        0000 ; 03F5
                        A072 ; 03F6
                        A088 ; 03F7
                        A0F6 ; 03F8
                        A088 ; 03F9

; Top half - 28: Facing left  - crouching
; Top half - B5: Unused
                        A0B4 ; 03FA
                        A0CA ; 03FB
                        A0E0 ; 03FC
                        A0CA ; 03FD
                        0000 ; 03FE
                        A0B4 ; 03FF
                        A0CA ; 0400
                        A111 ; 0401
                        A0CA ; 0402

; Top half - 35: Facing right - crouching transition
; Top half - 3B: Facing right - standing transition
                        977B ; 0403

; Top half - 36: Facing left  - crouching transition
; Top half - 3C: Facing left  - standing transition
                        9796 ; 0404

; Bottom half - 37: Facing right - morphing transition
; Top half - 37: Facing right - morphing transition
                        BCDD ; 0405
                        BCCC ; 0406

; Bottom half - 38: Facing left  - morphing transition
; Top half - 38: Facing left  - morphing transition
                        BCB1 ; 0407
                        BCA0 ; 0408

; Bottom half - 3D: Facing right - unmorphing transition
; Top half - 3D: Facing right - unmorphing transition
                        BCCC ; 0409
                        BCDD ; 040A

; Bottom half - 3E: Facing left  - unmorphing transition
; Top half - 3E: Facing left  - unmorphing transition
                        BCA0 ; 040B
                        BCB1 ; 040C

; Top half - DB: Unused
                        977B ; 040D
                        BCDD ; 040E
                        BCCC ; 040F

; Top half - DC: Unused
                        9796 ; 0410
                        BCB1 ; 0411
                        BCA0 ; 0412

; Top half - DD: Unused
                        BCCC ; 0413
                        BCDD ; 0414
                        977B ; 0415

; Top half - DE: Unused
                        BCA0 ; 0416
                        BCB1 ; 0417
                        9796 ; 0418

; Top half - 25: Facing right - turning - standing
; Top half - 2F: Facing right - turning - jumping
; Top half - 43: Facing right - turning - crouching
; Top half - 87: Facing right - turning - falling
; Top half - BF: Facing right - moonwalking - turn/jump left
; Top half - C6: Unused
                        9998 ; 0419
                        99E9 ; 041A
                        9982 ; 041B

; Top half - 26: Facing left  - turning - standing
; Top half - 30: Facing left  - turning - jumping
; Top half - 44: Facing left  - turning - crouching
; Top half - 88: Facing left  - turning - falling
; Top half - C0: Facing left  - moonwalking - turn/jump right
                        9982 ; 041C
                        99E9 ; 041D
                        9998 ; 041E

; Top half - 8B: Facing right - turning - standing - aiming up
; Top half - 8F: Facing right - turning - in air - aiming up
; Top half - 93: Facing right - turning - falling - aiming up
; Top half - 97: Facing right - turning - crouching - aiming up
; Top half - 9C: Facing right - turning - standing - aiming up-right
; Top half - 9E: Facing right - turning - in air - aiming up-right
; Top half - A0: Facing right - turning - falling - aiming up-right
; Top half - A2: Facing right - turning - crouching - aiming up-right
; Top half - C1: Facing right - moonwalking - turn/jump left  - aiming up-right
                        99CE ; 041F
                        993E ; 0420
                        99AE ; 0421

; Top half - 8C: Facing left  - turning - standing - aiming up
; Top half - 90: Facing left  - turning - in air - aiming up
; Top half - 94: Facing left  - turning - falling - aiming up
; Top half - 98: Facing left  - turning - crouching - aiming up
; Top half - 9D: Facing left  - turning - standing - aiming up-left
; Top half - 9F: Facing left  - turning - in air - aiming up-left
; Top half - A1: Facing left  - turning - falling - aiming up-left
; Top half - A3: Facing left  - turning - crouching - aiming up-left
; Top half - C2: Facing left  - moonwalking - turn/jump right - aiming up-left
                        99AE ; 0422
                        993E ; 0423
                        99CE ; 0424

; Top half - 8D: Facing right - turning - standing - aiming down-right
; Top half - 91: Facing right - turning - in air - aiming down/down-right
; Top half - 95: Facing right - turning - falling - aiming down/down-right
; Top half - 99: Facing right - turning - crouching - aiming down/down-right
; Top half - C3: Facing right - moonwalking - turn/jump left  - aiming down-right
                        9AF7 ; 0425
                        9954 ; 0426
                        9AD7 ; 0427

; Top half - 8E: Facing left  - turning - standing - aiming down-left
; Top half - 92: Facing left  - turning - in air - aiming down/down-left
; Top half - 96: Facing left  - turning - falling - aiming down/down-left
; Top half - 9A: Facing left  - turning - crouching - aiming down/down-left
; Top half - C4: Facing left  - moonwalking - turn/jump right - aiming down-left
                        9AD7 ; 0428
                        9954 ; 0429
                        9AF7 ; 042A

; Top half - EC: Facing right - grabbed by Draygon - not moving - not aiming
                        9BAE ; 042B

; Top half - ED: Facing right - grabbed by Draygon - not moving - aiming up-right
                        9857 ; 042C

; Top half - EE: Facing right - grabbed by Draygon - firing
                        977B ; 042D

; Top half - EF: Facing right - grabbed by Draygon - not moving - aiming down-right
                        9705 ; 042E

; Top half - BA: Facing left  - grabbed by Draygon - not moving - not aiming
                        9BBF ; 042F

; Top half - BB: Facing left  - grabbed by Draygon - not moving - aiming up-left
                        9872 ; 0430

; Top half - BC: Facing left  - grabbed by Draygon - firing
                        9796 ; 0431

; Top half - BD: Facing left  - grabbed by Draygon - not moving - aiming down-left
                        9725 ; 0432

; Top half - F0: Facing right - grabbed by Draygon - moving
                        9663 ; 0433
                        966F ; 0434
                        9657 ; 0435
                        9691 ; 0436
                        969D ; 0437
                        9657 ; 0438

; Top half - BE: Facing left  - grabbed by Draygon - moving
                        96BA ; 0439
                        96C6 ; 043A
                        96AE ; 043B
                        96E8 ; 043C
                        96F4 ; 043D
                        96AE ; 043E

; Top half - C9: Facing right - shinespark - horizontal
                        9A93 ; 043F

; Top half - CA: Facing left  - shinespark - horizontal
                        9AAE ; 0440

; Top half - CD: Facing right - shinespark - diagonal
                        9A93 ; 0441

; Top half - CE: Facing left  - shinespark - diagonal
                        9AAE ; 0442

; Top half - D3: Facing right - crystal flash
                        BCCC ; 0443
                        BCDD ; 0444
                        C207 ; 0445
                        BCDD ; 0446
                        0000 ; 0447
                        0000 ; 0448
                        C207 ; 0449
                        C22C ; 044A
                        C251 ; 044B
                        C22C ; 044C
                        0000 ; 044D
                        0000 ; 044E
                        BCDD ; 044F
                        BCDD ; 0450
                        977B ; 0451

; Top half - D4: Facing left  - crystal flash
                        BCA0 ; 0452
                        BCB1 ; 0453
                        C198 ; 0454
                        BCB1 ; 0455
                        0000 ; 0456
                        0000 ; 0457
                        C198 ; 0458
                        C1BD ; 0459
                        C1E2 ; 045A
                        C1BD ; 045B
                        0000 ; 045C
                        0000 ; 045D
                        BCB1 ; 045E
                        BCB1 ; 045F
                        9796 ; 0460

; Top half - D7: Facing right - crystal flash ending
                        BAB3 ; 0461
                        BCCC ; 0462
                        BCDD ; 0463
                        977B ; 0464
                        98AD ; 0465
                        98AD ; 0466

; Top half - D8: Facing left  - crystal flash ending
                        BB16 ; 0467
                        BCA0 ; 0468
                        BCB1 ; 0469
                        9796 ; 046A
                        9892 ; 046B
                        9892 ; 046C

; Top half - E8: Facing right - Samus drained - crouching
                        BAB3 ; 046D
                        BCCC ; 046E
                        BCDD ; 046F
                        98AD ; 0470
                        98AD ; 0471
                        98AD ; 0472
                        98AD ; 0473
                        98AD ; 0474
                        9F34 ; 0475
                        9F59 ; 0476
                        9F7E ; 0477
                        9F59 ; 0478
                        0000 ; 0479
                        0000 ; 047A
                        977B ; 047B

; Top half - E9: Facing left  - Samus drained - crouching
                        BCA0 ; 047C
                        BCB1 ; 047D
                        9892 ; 047E
                        9892 ; 047F
                        9892 ; 0480
                        9892 ; 0481
                        9892 ; 0482
                        9EF4 ; 0483
                        9ED4 ; 0484
                        9EF4 ; 0485
                        9F14 ; 0486
                        9EF4 ; 0487
                        0000 ; 0488
                        0000 ; 0489
                        9EF4 ; 048A
                        9FC3 ; 048B
                        9BA2 ; 048C
                        0000 ; 048D
                        0000 ; 048E
                        9EF4 ; 048F
                        9FC3 ; 0490
                        9BA2 ; 0491
                        9FC3 ; 0492
                        9EF4 ; 0493
                        0000 ; 0494
                        0000 ; 0495
                        9ED4 ; 0496
                        0000 ; 0497
                        0000 ; 0498
                        9ED4 ; 0499
                        0000 ; 049A
                        0000 ; 049B

; Top half - EA: Facing right - Samus drained - standing
                        A003 ; 049C
                        A028 ; 049D
                        A04D ; 049E
                        A028 ; 049F
                        0000 ; 04A0
                        977B ; 04A1

; Top half - EB: Facing left  - Samus drained - standing
                        9FA3 ; 04A2
                        9FC3 ; 04A3
                        9FE3 ; 04A4
                        9FC3 ; 04A5
                        0000 ; 04A6
                        9796 ; 04A7
                        AD3C ; 04A8
                        AD3C ; 04A9

; Bottom half - 01: Facing right - normal
; Bottom half - 47: Unused
; Bottom half - 89: Facing right - ran into a wall
; Bottom half - A8: Unused
                        ADBB ; 04AA
                        AE98 ; 04AB
                        AEA9 ; 04AC
                        AE98 ; 04AD
                        0000 ; 04AE
                        ADBB ; 04AF
                        AE98 ; 04B0
                        AEA9 ; 04B1
                        AE98 ; 04B2

; Bottom half - 02: Facing left  - normal
; Bottom half - 48: Unused
; Bottom half - 8A: Facing left  - ran into a wall
; Bottom half - A9: Unused
                        B340 ; 04B3
                        AEBA ; 04B4
                        AFA1 ; 04B5
                        AEBA ; 04B6
                        0000 ; 04B7
                        B340 ; 04B8
                        AEBA ; 04B9
                        AFA1 ; 04BA
                        AEBA ; 04BB
                        ADBB ; 04BC
                        ADBB ; 04BD
                        B340 ; 04BE
                        B340 ; 04BF

; Bottom half - 03: Facing right - aiming up
; Bottom half - 05: Facing right - aiming up-right
; Bottom half - 07: Facing right - aiming down-right
; Bottom half - AA: Unused
; Bottom half - CF: Facing right - ran into a wall - aiming up-right
; Bottom half - D1: Facing right - ran into a wall - aiming down-right
                        B295 ; 04C0
                        B295 ; 04C1

; Bottom half - 04: Facing left  - aiming up
; Bottom half - 06: Facing left  - aiming up-left
; Bottom half - 08: Facing left  - aiming down-left
; Bottom half - AB: Unused
; Bottom half - D0: Facing left  - ran into a wall - aiming up-left
; Bottom half - D2: Facing left  - ran into a wall - aiming down-left
                        B2AB ; 04C2
                        B2AB ; 04C3
                        AD3C ; 04C4

; Bottom half - A4: Facing right - landing from normal jump
; Bottom half - E0: Facing right - landing from normal jump - aiming up
; Bottom half - E2: Facing right - landing from normal jump - aiming up-right
; Bottom half - E4: Facing right - landing from normal jump - aiming down-right
; Bottom half - E6: Facing right - landing from normal jump - firing
                        B021 ; 04C5
                        ADBB ; 04C6

; Bottom half - A5: Facing left  - landing from normal jump
; Bottom half - E1: Facing left  - landing from normal jump - aiming up
; Bottom half - E3: Facing left  - landing from normal jump - aiming up-left
; Bottom half - E5: Facing left  - landing from normal jump - aiming down-left
; Bottom half - E7: Facing left  - landing from normal jump - firing
                        B037 ; 04C7
                        B340 ; 04C8

; Bottom half - A6: Facing right - landing from spin jump
                        B1C8 ; 04C9
                        B021 ; 04CA
                        ADBB ; 04CB

; Bottom half - A7: Facing left  - landing from spin jump
                        B1E3 ; 04CC
                        B037 ; 04CD
                        B340 ; 04CE

; Bottom half - D5: Facing right - x-ray - standing
                        ADBB ; 04CF
                        ADBB ; 04D0
                        ADBB ; 04D1
                        ADBB ; 04D2
                        ADBB ; 04D3

; Bottom half - D6: Facing left  - x-ray - standing
                        B340 ; 04D4
                        B340 ; 04D5
                        B340 ; 04D6
                        B340 ; 04D7
                        B340 ; 04D8

; Bottom half - D9: Facing right - x-ray - crouching
                        B351 ; 04D9
                        B351 ; 04DA
                        B351 ; 04DB
                        B351 ; 04DC
                        B351 ; 04DD

; Bottom half - DA: Facing left  - x-ray - crouching
                        ADCC ; 04DE
                        ADCC ; 04DF
                        ADCC ; 04E0
                        ADCC ; 04E1
                        ADCC ; 04E2

; Bottom half - 09: Moving right - not aiming
; Bottom half - 0B: Moving right - gun extended
; Bottom half - 0D: Moving right - aiming up (unused)
; Bottom half - 0F: Moving right - aiming up-right
; Bottom half - 11: Moving right - aiming down-right
; Bottom half - 45: Unused
                        AD3C ; 04E3
                        ADD8 ; 04E4
                        AD48 ; 04E5
                        ADEE ; 04E6
                        AD63 ; 04E7
                        AD79 ; 04E8
                        AE0E ; 04E9
                        AD85 ; 04EA
                        AE24 ; 04EB
                        ADA5 ; 04EC

; Bottom half - 0A: Moving left  - not aiming
; Bottom half - 0C: Moving left  - gun extended
; Bottom half - 0E: Moving left  - aiming up (unused)
; Bottom half - 10: Moving left  - aiming up-left
; Bottom half - 12: Moving left  - aiming down-left
; Bottom half - 46: Unused
                        B2C1 ; 04ED
                        B35D ; 04EE
                        B2CD ; 04EF
                        B373 ; 04F0
                        B2E8 ; 04F1
                        B2FE ; 04F2
                        B393 ; 04F3
                        B30A ; 04F4
                        B3A9 ; 04F5
                        B32A ; 04F6

; Bottom half - 49: Facing left  - moonwalk
; Bottom half - 75: Facing left  - moonwalk - aiming up-left
; Bottom half - 77: Facing left  - moonwalk - aiming down-left
                        B3ED ; 04F7
                        B403 ; 04F8
                        B184 ; 04F9
                        B3C9 ; 04FA
                        B40F ; 04FB
                        B195 ; 04FC

; Bottom half - 4A: Facing right - moonwalk
; Bottom half - 76: Facing right - moonwalk - aiming up-right
; Bottom half - 78: Facing right - moonwalk - aiming down-right
                        AFF3 ; 04FD
                        B009 ; 04FE
                        B1A6 ; 04FF
                        AFCA ; 0500
                        B015 ; 0501
                        B1B7 ; 0502

; Bottom half - 17: Facing right - normal jump - aiming down
; Bottom half - AE: Unused
                        B08D ; 0503
                        B104 ; 0504

; Bottom half - 18: Facing left  - normal jump - aiming down
; Bottom half - AF: Unused
                        B09E ; 0505
                        B124 ; 0506

; Bottom half - 13: Facing right - normal jump - not aiming - not moving - gun extended
; Bottom half - AC: Unused
                        B08D ; 0507
                        B1C8 ; 0508

; Bottom half - 14: Facing left  - normal jump - not aiming - not moving - gun extended
; Bottom half - AD: Unused
                        B09E ; 0509
                        B1E3 ; 050A

; Bottom half - 15: Facing right - normal jump - aiming up
                        B08D ; 050B
                        AEF7 ; 050C

; Bottom half - 16: Facing left  - normal jump - aiming up
                        B09E ; 050D
                        AF08 ; 050E

; Bottom half - 51: Facing right - normal jump - not aiming - moving forward
                        B08D ; 050F
                        B1C8 ; 0510

; Bottom half - 52: Facing left  - normal jump - not aiming - moving forward
                        B09E ; 0511
                        B1E3 ; 0512

; Bottom half - 69: Facing right - normal jump - aiming up-right
                        B08D ; 0513
                        AEF7 ; 0514

; Bottom half - 6A: Facing left  - normal jump - aiming up-left
                        B09E ; 0515
                        AF08 ; 0516

; Bottom half - 6B: Facing right - normal jump - aiming down-right
; Bottom half - B0: Unused
                        B08D ; 0517
                        B1C8 ; 0518

; Bottom half - 6C: Facing left  - normal jump - aiming down-left
; Bottom half - B1: Unused
                        B09E ; 0519
                        B1E3 ; 051A

; Bottom half - 4B: Facing right - normal jump transition
; Bottom half - 55: Facing right - normal jump transition - aiming up
; Bottom half - 57: Facing right - normal jump transition - aiming up-right
; Bottom half - 59: Facing right - normal jump transition - aiming down-right
                        B021 ; 051B

; Bottom half - 4C: Facing left  - normal jump transition
; Bottom half - 56: Facing left  - normal jump transition - aiming up
; Bottom half - 58: Facing left  - normal jump transition - aiming up-left
; Bottom half - 5A: Facing left  - normal jump transition - aiming down-left
                        B037 ; 051C

; Bottom half - 4D: Facing right - normal jump - not aiming - not moving - gun not extended
; Bottom half - C7: Facing right - vertical shinespark windup
                        AD79 ; 051D
                        B0C7 ; 051E
                        B04D ; 051F
                        B04D ; 0520
                        B08D ; 0521
                        B0AF ; 0522

; Bottom half - 4E: Facing left  - normal jump - not aiming - not moving - gun not extended
; Bottom half - C8: Facing left  - vertical shinespark windup
                        B2FE ; 0523
                        B0E2 ; 0524
                        B06D ; 0525
                        B06D ; 0526
                        B09E ; 0527
                        B0BB ; 0528

; Bottom half - 4F: Facing left  - damage boost
                        AECB ; 0529
                        B09E ; 052A
                        0000 ; 052B
                        0000 ; 052C
                        0000 ; 052D
                        0000 ; 052E
                        0000 ; 052F
                        0000 ; 0530
                        0000 ; 0531
                        B1E3 ; 0532

; Bottom half - 50: Facing right - damage boost
                        AEE1 ; 0533
                        B08D ; 0534
                        0000 ; 0535
                        0000 ; 0536
                        0000 ; 0537
                        0000 ; 0538
                        0000 ; 0539
                        0000 ; 053A
                        0000 ; 053B
                        B1C8 ; 053C

; Bottom half - 63: Unused
                        B184 ; 053D
                        AF69 ; 053E

; Bottom half - 64: Unused
                        B195 ; 053F
                        AF5D ; 0540

; Bottom half - 65: Unused
                        B144 ; 0541
                        BB22 ; 0542
                        BB2E ; 0543
                        BB44 ; 0544
                        BB50 ; 0545
                        BB66 ; 0546
                        BB72 ; 0547
                        BB88 ; 0548
                        BB94 ; 0549

; Bottom half - 66: Unused
                        B169 ; 054A
                        BD67 ; 054B
                        BD73 ; 054C
                        BD89 ; 054D
                        BD95 ; 054E
                        BDAB ; 054F
                        BDB7 ; 0550
                        BDCD ; 0551
                        BDD9 ; 0552

; Bottom half - 83: Facing right - wall jump
                        B144 ; 0553
                        B1C8 ; 0554
                        0000 ; 0555
                        0000 ; 0556
                        0000 ; 0557
                        0000 ; 0558
                        0000 ; 0559
                        0000 ; 055A
                        0000 ; 055B
                        0000 ; 055C
                        0000 ; 055D
                        0000 ; 055E
                        0000 ; 055F
                        C458 ; 0560
                        C46E ; 0561
                        C4A2 ; 0562
                        C4B8 ; 0563
                        C4EC ; 0564
                        C502 ; 0565
                        C536 ; 0566
                        C54C ; 0567
                        0000 ; 0568
                        0000 ; 0569
                        C458 ; 056A
                        C46E ; 056B
                        C4A2 ; 056C
                        C4B8 ; 056D
                        C4EC ; 056E
                        C502 ; 056F
                        C536 ; 0570
                        C54C ; 0571
                        C458 ; 0572
                        C46E ; 0573
                        C4A2 ; 0574
                        C4B8 ; 0575
                        C4EC ; 0576
                        C502 ; 0577
                        C536 ; 0578
                        C54C ; 0579
                        C458 ; 057A
                        C46E ; 057B
                        C4A2 ; 057C
                        C4B8 ; 057D
                        C4EC ; 057E
                        C502 ; 057F
                        C536 ; 0580
                        C54C ; 0581

; Bottom half - 84: Facing left  - wall jump
                        B169 ; 0582
                        B1E3 ; 0583
                        0000 ; 0584
                        0000 ; 0585
                        0000 ; 0586
                        0000 ; 0587
                        0000 ; 0588
                        0000 ; 0589
                        0000 ; 058A
                        0000 ; 058B
                        0000 ; 058C
                        0000 ; 058D
                        0000 ; 058E
                        C330 ; 058F
                        C346 ; 0590
                        C37A ; 0591
                        C390 ; 0592
                        C3C4 ; 0593
                        C3DA ; 0594
                        C40E ; 0595
                        C424 ; 0596
                        0000 ; 0597
                        0000 ; 0598
                        C330 ; 0599
                        C346 ; 059A
                        C37A ; 059B
                        C390 ; 059C
                        C3C4 ; 059D
                        C3DA ; 059E
                        C40E ; 059F
                        C424 ; 05A0
                        C330 ; 05A1
                        C346 ; 05A2
                        C37A ; 05A3
                        C390 ; 05A4
                        C3C4 ; 05A5
                        C3DA ; 05A6
                        C40E ; 05A7
                        C424 ; 05A8
                        C330 ; 05A9
                        C346 ; 05AA
                        C37A ; 05AB
                        C390 ; 05AC
                        C3C4 ; 05AD
                        C3DA ; 05AE
                        C40E ; 05AF
                        C424 ; 05B0

; Bottom half - 53: Facing right - knockback
                        B0AF ; 05B1
                        B1FE ; 05B2

; Bottom half - 54: Facing left  - knockback
                        B0BB ; 05B3
                        B214 ; 05B4

; Bottom half - 5B: Unused
; Bottom half - B8: Facing left  - grapple wall jump pose
                        AF69 ; 05B5

; Bottom half - 5C: Unused
; Bottom half - B9: Facing right - grapple wall jump pose
                        AF5D ; 05B6

; Bottom half - 5D: Unused
; Bottom half - 5E: Unused
; Bottom half - 5F: Unused
; Bottom half - 60: Unused
; Bottom half - 61: Unused
; Bottom half - B2: Facing clockwise     - grapple
                        B63F ; 05B7
                        B624 ; 05B8
                        B60E ; 05B9
                        B5FD ; 05BA
                        B5FD ; 05BB
                        B5DD ; 05BC
                        B5DD ; 05BD
                        B5CC ; 05BE
                        B5CC ; 05BF
                        B5CC ; 05C0
                        B4E6 ; 05C1
                        B4E6 ; 05C2
                        B4D0 ; 05C3
                        B4D0 ; 05C4
                        B4BA ; 05C5
                        B4A9 ; 05C6
                        B48E ; 05C7
                        B473 ; 05C8
                        B45D ; 05C9
                        B44C ; 05CA
                        B44C ; 05CB
                        B42C ; 05CC
                        B42C ; 05CD
                        B41B ; 05CE
                        B41B ; 05CF
                        B41B ; 05D0
                        B697 ; 05D1
                        B697 ; 05D2
                        B681 ; 05D3
                        B681 ; 05D4
                        B66B ; 05D5
                        B65A ; 05D6
                        B72B ; 05D7
                        B715 ; 05D8
                        B709 ; 05D9
                        B6FD ; 05DA
                        B6FD ; 05DB
                        B6E7 ; 05DC
                        B6E7 ; 05DD
                        B6DB ; 05DE
                        B6DB ; 05DF
                        B6DB ; 05E0
                        B5B4 ; 05E1
                        B5B4 ; 05E2
                        B59E ; 05E3
                        B59E ; 05E4
                        B592 ; 05E5
                        B586 ; 05E6
                        B57A ; 05E7
                        B564 ; 05E8
                        B558 ; 05E9
                        B54C ; 05EA
                        B54C ; 05EB
                        B536 ; 05EC
                        B536 ; 05ED
                        B52A ; 05EE
                        B52A ; 05EF
                        B52A ; 05F0
                        B74F ; 05F1
                        B74F ; 05F2
                        B743 ; 05F3
                        B743 ; 05F4
                        B737 ; 05F5
                        B72B ; 05F6
                        B512 ; 05F7
                        B51E ; 05F8

; Bottom half - 62: Unused
; Bottom half - B3: Facing anticlockwise - grapple
                        B98B ; 05F9
                        B9A6 ; 05FA
                        B9B7 ; 05FB
                        B9CD ; 05FC
                        B9CD ; 05FD
                        B9E3 ; 05FE
                        B9E3 ; 05FF
                        B767 ; 0600
                        B767 ; 0601
                        B767 ; 0602
                        B778 ; 0603
                        B778 ; 0604
                        B798 ; 0605
                        B798 ; 0606
                        B7A9 ; 0607
                        B7BF ; 0608
                        B7DA ; 0609
                        B7F5 ; 060A
                        B806 ; 060B
                        B81C ; 060C
                        B81C ; 060D
                        B832 ; 060E
                        B832 ; 060F
                        B918 ; 0610
                        B918 ; 0611
                        B918 ; 0612
                        B929 ; 0613
                        B929 ; 0614
                        B949 ; 0615
                        B949 ; 0616
                        B95A ; 0617
                        B970 ; 0618
                        BA77 ; 0619
                        BA83 ; 061A
                        BA8F ; 061B
                        BA9B ; 061C
                        BA9B ; 061D
                        BAA7 ; 061E
                        BAA7 ; 061F
                        B876 ; 0620
                        B876 ; 0621
                        B876 ; 0622
                        B882 ; 0623
                        B882 ; 0624
                        B898 ; 0625
                        B898 ; 0626
                        B8A4 ; 0627
                        B8B0 ; 0628
                        B8C6 ; 0629
                        B8D2 ; 062A
                        B8DE ; 062B
                        B8EA ; 062C
                        B8EA ; 062D
                        B900 ; 062E
                        B900 ; 062F
                        BA27 ; 0630
                        BA27 ; 0631
                        BA27 ; 0632
                        BA33 ; 0633
                        BA33 ; 0634
                        BA49 ; 0635
                        BA49 ; 0636
                        BA55 ; 0637
                        BA61 ; 0638
                        B85E ; 0639
                        B86A ; 063A

; Bottom half - 29: Facing right - falling
; Bottom half - 67: Facing right - falling - gun extended
                        B08D ; 063B
                        B0AF ; 063C
                        B0AF ; 063D
                        0000 ; 063E
                        0000 ; 063F
                        B08D ; 0640
                        B1C8 ; 0641

; Bottom half - 2A: Facing left  - falling
; Bottom half - 68: Facing left  - falling - gun extended
                        B09E ; 0642
                        B0BB ; 0643
                        B0BB ; 0644
                        0000 ; 0645
                        0000 ; 0646
                        B09E ; 0647
                        B1E3 ; 0648

; Bottom half - 2D: Facing right - falling - aiming down
                        B08D ; 0649
                        B104 ; 064A

; Bottom half - 2E: Facing left  - falling - aiming down
                        B09E ; 064B
                        B124 ; 064C

; Bottom half - 2B: Facing right - falling - aiming up
                        B08D ; 064D
                        B0AF ; 064E
                        B1C8 ; 064F

; Bottom half - 2C: Facing left  - falling - aiming up
                        B09E ; 0650
                        B0BB ; 0651
                        B1E3 ; 0652

; Bottom half - 6D: Facing right - falling - aiming up-right
                        B08D ; 0653
                        B0AF ; 0654
                        B1C8 ; 0655

; Bottom half - 6E: Facing left  - falling - aiming up-left
                        B09E ; 0656
                        B0BB ; 0657
                        B1E3 ; 0658

; Bottom half - 6F: Facing right - falling - aiming down-right
                        B08D ; 0659
                        B0AF ; 065A
                        B1C8 ; 065B

; Bottom half - 70: Facing left  - falling - aiming down-left
                        B09E ; 065C
                        B0BB ; 065D
                        B1E3 ; 065E

; Bottom half - 27: Facing right - crouching
; Bottom half - B4: Unused
                        B351 ; 065F
                        B351 ; 0660
                        B351 ; 0661
                        B351 ; 0662
                        0000 ; 0663
                        B351 ; 0664
                        B351 ; 0665
                        B351 ; 0666
                        B351 ; 0667

; Bottom half - 28: Facing left  - crouching
; Bottom half - B5: Unused
                        ADCC ; 0668
                        ADCC ; 0669
                        ADCC ; 066A
                        ADCC ; 066B
                        0000 ; 066C
                        ADCC ; 066D
                        ADCC ; 066E
                        ADCC ; 066F
                        ADCC ; 0670

; Bottom half - 71: Facing right - crouching - aiming up-right
                        B351 ; 0671

; Bottom half - 72: Facing left  - crouching - aiming up-left
                        ADCC ; 0672

; Bottom half - 73: Facing right - crouching - aiming down-right
; Bottom half - B6: Unused
                        B351 ; 0673

; Bottom half - 74: Facing left  - crouching - aiming down-left
; Bottom half - B7: Unused
                        ADCC ; 0674

; Bottom half - 85: Facing right - crouching - aiming up
                        B351 ; 0675
                        B351 ; 0676

; Bottom half - 86: Facing left  - crouching - aiming up
                        ADCC ; 0677
                        ADCC ; 0678

; Bottom half - 35: Facing right - crouching transition
; Bottom half - 3B: Facing right - standing transition
; Bottom half - F1: Facing right - crouching transition - aiming up
; Bottom half - F3: Facing right - crouching transition - aiming up-right
; Bottom half - F5: Facing right - crouching transition - aiming down-right
; Bottom half - F7: Facing right - standing transition - aiming up
; Bottom half - F9: Facing right - standing transition - aiming up-right
; Bottom half - FB: Facing right - standing transition - aiming down-right
                        B021 ; 0679

; Bottom half - 36: Facing left  - crouching transition
; Bottom half - 3C: Facing left  - standing transition
; Bottom half - F2: Facing left  - crouching transition - aiming up
; Bottom half - F4: Facing left  - crouching transition - aiming up-left
; Bottom half - F6: Facing left  - crouching transition - aiming down-left
; Bottom half - F8: Facing left  - standing transition - aiming up
; Bottom half - FA: Facing left  - standing transition - aiming up-left
; Bottom half - FC: Facing left  - standing transition - aiming down-left
                        B037 ; 067A
                        0000 ; 067B
                        0000 ; 067C

; Bottom half - DB: Unused
                        B021 ; 067D
                        0000 ; 067E
                        0000 ; 067F

; Bottom half - DC: Unused
                        B021 ; 0680

; Bottom half - DD: Unused
                        0000 ; 0681
                        0000 ; 0682
                        B021 ; 0683

; Bottom half - DE: Unused
                        0000 ; 0684
                        0000 ; 0685
                        B021 ; 0686

; Bottom half - 25: Facing right - turning - standing
; Bottom half - 8B: Facing right - turning - standing - aiming up
; Bottom half - 8D: Facing right - turning - standing - aiming down-right
; Bottom half - 9C: Facing right - turning - standing - aiming up-right
; Bottom half - BF: Facing right - moonwalking - turn/jump left
; Bottom half - C1: Facing right - moonwalking - turn/jump left  - aiming up-right
; Bottom half - C3: Facing right - moonwalking - turn/jump left  - aiming down-right
; Bottom half - C6: Unused
                        AF2A ; 0687
                        AFE0 ; 0688
                        AF19 ; 0689

; Bottom half - 26: Facing left  - turning - standing
; Bottom half - 8C: Facing left  - turning - standing - aiming up
; Bottom half - 8E: Facing left  - turning - standing - aiming down-left
; Bottom half - 9D: Facing left  - turning - standing - aiming up-left
; Bottom half - C0: Facing left  - moonwalking - turn/jump right
; Bottom half - C2: Facing left  - moonwalking - turn/jump right - aiming up-left
; Bottom half - C4: Facing left  - moonwalking - turn/jump right - aiming down-left
                        AF19 ; 068A
                        AFE0 ; 068B
                        AF2A ; 068C

; Bottom half - 2F: Facing right - turning - jumping
; Bottom half - 43: Facing right - turning - crouching
; Bottom half - 87: Facing right - turning - falling
; Bottom half - 8F: Facing right - turning - in air - aiming up
; Bottom half - 91: Facing right - turning - in air - aiming down/down-right
; Bottom half - 93: Facing right - turning - falling - aiming up
; Bottom half - 95: Facing right - turning - falling - aiming down/down-right
; Bottom half - 97: Facing right - turning - crouching - aiming up
; Bottom half - 99: Facing right - turning - crouching - aiming down/down-right
; Bottom half - 9E: Facing right - turning - in air - aiming up-right
; Bottom half - A0: Facing right - turning - falling - aiming up-right
; Bottom half - A2: Facing right - turning - crouching - aiming up-right
                        AF4C ; 068D
                        AFEC ; 068E
                        AF3B ; 068F

; Bottom half - 30: Facing left  - turning - jumping
; Bottom half - 44: Facing left  - turning - crouching
; Bottom half - 90: Facing left  - turning - in air - aiming up
; Bottom half - 92: Facing left  - turning - in air - aiming down/down-left
; Bottom half - 98: Facing left  - turning - crouching - aiming up
; Bottom half - 9A: Facing left  - turning - crouching - aiming down/down-left
; Bottom half - 9F: Facing left  - turning - in air - aiming up-left
; Bottom half - A3: Facing left  - turning - crouching - aiming up-left
                        AF3B ; 0690
                        AFEC ; 0691
                        AF4C ; 0692
                        AF4C ; 0693
                        AFEC ; 0694
                        AF3B ; 0695

; Bottom half - 88: Facing left  - turning - falling
; Bottom half - 94: Facing left  - turning - falling - aiming up
; Bottom half - 96: Facing left  - turning - falling - aiming down/down-left
; Bottom half - A1: Facing left  - turning - falling - aiming up-left
                        AF3B ; 0696
                        AFEC ; 0697
                        AF4C ; 0698

; Bottom half - EC: Facing right - grabbed by Draygon - not moving - not aiming
; Bottom half - ED: Facing right - grabbed by Draygon - not moving - aiming up-right
; Bottom half - EE: Facing right - grabbed by Draygon - firing
; Bottom half - EF: Facing right - grabbed by Draygon - not moving - aiming down-right
                        B1FE ; 0699

; Bottom half - BA: Facing left  - grabbed by Draygon - not moving - not aiming
; Bottom half - BB: Facing left  - grabbed by Draygon - not moving - aiming up-left
; Bottom half - BC: Facing left  - grabbed by Draygon - firing
; Bottom half - BD: Facing left  - grabbed by Draygon - not moving - aiming down-left
                        B214 ; 069A

; Bottom half - F0: Facing right - grabbed by Draygon - moving
                        B0AF ; 069B
                        B1FE ; 069C
                        B1C8 ; 069D
                        B0AF ; 069E
                        B0C7 ; 069F
                        B04D ; 06A0

; Bottom half - BE: Facing left  - grabbed by Draygon - moving
                        B0BB ; 06A1
                        B214 ; 06A2
                        B1E3 ; 06A3
                        B0BB ; 06A4
                        B0E2 ; 06A5
                        B06D ; 06A6

; Bottom half - C9: Facing right - shinespark - horizontal
                        AF75 ; 06A7

; Bottom half - CA: Facing left  - shinespark - horizontal
                        AF8B ; 06A8

; Bottom half - CD: Facing right - shinespark - diagonal
                        AF75 ; 06A9

; Bottom half - CE: Facing left  - shinespark - diagonal
                        AF8B ; 06AA

; Bottom half - D3: Facing right - crystal flash
                        C276 ; 06AB
                        C28C ; 06AC
                        C2DE ; 06AD
                        C2DE ; 06AE
                        0000 ; 06AF
                        0000 ; 06B0
                        C2DE ; 06B1
                        C2DE ; 06B2
                        C2DE ; 06B3
                        C2DE ; 06B4
                        0000 ; 06B5
                        0000 ; 06B6
                        C28C ; 06B7
                        C276 ; 06B8
                        B021 ; 06B9

; Bottom half - D4: Facing left  - crystal flash
                        C276 ; 06BA
                        C28C ; 06BB
                        C2DE ; 06BC
                        C2DE ; 06BD
                        0000 ; 06BE
                        0000 ; 06BF
                        C2DE ; 06C0
                        C2DE ; 06C1
                        C2DE ; 06C2
                        C2DE ; 06C3
                        0000 ; 06C4
                        0000 ; 06C5
                        C28C ; 06C6
                        C276 ; 06C7
                        B037 ; 06C8

; Bottom half - D7: Facing right - crystal flash ending
                        0000 ; 06C9
                        0000 ; 06CA
                        0000 ; 06CB
                        B021 ; 06CC
                        B0AF ; 06CD
                        B1FE ; 06CE

; Bottom half - D8: Facing left  - crystal flash ending
                        0000 ; 06CF
                        0000 ; 06D0
                        0000 ; 06D1
                        B037 ; 06D2
                        B0BB ; 06D3
                        B214 ; 06D4

; Bottom half - E8: Facing right - Samus drained - crouching
                        0000 ; 06D5
                        0000 ; 06D6
                        0000 ; 06D7
                        B0AF ; 06D8
                        B0AF ; 06D9
                        B0AF ; 06DA
                        B0AF ; 06DB
                        B0AF ; 06DC
                        B242 ; 06DD
                        B242 ; 06DE
                        B242 ; 06DF
                        B242 ; 06E0
                        0000 ; 06E1
                        0000 ; 06E2
                        B021 ; 06E3

; Bottom half - E9: Facing left  - Samus drained - crouching
                        0000 ; 06E4
                        0000 ; 06E5
                        B0BB ; 06E6
                        B0BB ; 06E7
                        B0BB ; 06E8
                        B0BB ; 06E9
                        B0BB ; 06EA
                        B037 ; 06EB
                        B236 ; 06EC
                        B236 ; 06ED
                        B236 ; 06EE
                        B236 ; 06EF
                        0000 ; 06F0
                        0000 ; 06F1
                        B1E3 ; 06F2
                        B037 ; 06F3
                        B2AB ; 06F4
                        0000 ; 06F5
                        0000 ; 06F6
                        B1E3 ; 06F7
                        B037 ; 06F8
                        B2AB ; 06F9
                        B037 ; 06FA
                        B1E3 ; 06FB
                        0000 ; 06FC
                        0000 ; 06FD
                        B236 ; 06FE
                        0000 ; 06FF
                        0000 ; 0700
                        B236 ; 0701
                        0000 ; 0702
                        0000 ; 0703

; Bottom half - EA: Facing right - Samus drained - standing
                        B242 ; 0704
                        B242 ; 0705
                        B242 ; 0706
                        B242 ; 0707
                        0000 ; 0708
                        B021 ; 0709

; Bottom half - EB: Facing left  - Samus drained - standing
                        B236 ; 070A
                        B236 ; 070B
                        B236 ; 070C
                        B236 ; 070D
                        0000 ; 070E
                        B037 ; 070F

; Bottom half - 1D: Facing right - morph ball - no springball - on ground
; Bottom half - 31: Facing right - morph ball - no springball - in air
; Bottom half - 32: Facing left  - morph ball - no springball - in air
; Bottom half - 3F: Unused
; Bottom half - 40: Unused
; Top half - 1D: Facing right - morph ball - no springball - on ground
; Top half - 31: Facing right - morph ball - no springball - in air
; Top half - 32: Facing left  - morph ball - no springball - in air
; Top half - 3F: Unused
; Top half - 40: Unused
                        BAB3 ; 0710
                        BAE3 ; 0711
                        BABF ; 0712
                        BAFE ; 0713
                        BACB ; 0714
                        BB0A ; 0715
                        BAD7 ; 0716
                        BB16 ; 0717
                        0000 ; 0718
                        BC88 ; 0719

; Bottom half - 41: Facing left  - morph ball - no springball - on ground
; Bottom half - C5: Unused
; Bottom half - DF: Unused
; Top half - 41: Facing left  - morph ball - no springball - on ground
; Top half - C5: Unused
; Top half - DF: Unused
                        BB16 ; 071A
                        BAD7 ; 071B
                        BB0A ; 071C
                        BACB ; 071D
                        BAFE ; 071E
                        BABF ; 071F
                        BAE3 ; 0720
                        BAB3 ; 0721
                        0000 ; 0722
                        BC88 ; 0723

; Bottom half - 1E: Moving right - morph ball - no springball - on ground
; Top half - 1E: Moving right - morph ball - no springball - on ground
                        BAB3 ; 0724
                        BAE3 ; 0725
                        BABF ; 0726
                        BAFE ; 0727
                        BACB ; 0728
                        BB0A ; 0729
                        BAD7 ; 072A
                        BB16 ; 072B
                        0000 ; 072C
                        BC88 ; 072D

; Bottom half - 1F: Moving left  - morph ball - no springball - on ground
; Top half - 1F: Moving left  - morph ball - no springball - on ground
                        BB16 ; 072E
                        BAD7 ; 072F
                        BB0A ; 0730
                        BACB ; 0731
                        BAFE ; 0732
                        BABF ; 0733
                        BAE3 ; 0734
                        BAB3 ; 0735
                        0000 ; 0736
                        BC88 ; 0737

; Bottom half - 79: Facing right - morph ball - spring ball - on ground
; Bottom half - 7B: Moving right - morph ball - spring ball - on ground
; Bottom half - 7D: Facing right - morph ball - spring ball - falling
; Bottom half - 7F: Facing right - morph ball - spring ball - in air
; Top half - 79: Facing right - morph ball - spring ball - on ground
; Top half - 7B: Moving right - morph ball - spring ball - on ground
; Top half - 7D: Facing right - morph ball - spring ball - falling
; Top half - 7F: Facing right - morph ball - spring ball - in air
                        BAB3 ; 0738
                        BAE3 ; 0739
                        BABF ; 073A
                        BAFE ; 073B
                        BACB ; 073C
                        BB0A ; 073D
                        BAD7 ; 073E
                        BB16 ; 073F
                        0000 ; 0740
                        BC88 ; 0741

; Bottom half - 7A: Facing left  - morph ball - spring ball - on ground
; Bottom half - 7C: Moving left  - morph ball - spring ball - on ground
; Bottom half - 7E: Facing left  - morph ball - spring ball - falling
; Bottom half - 80: Facing left  - morph ball - spring ball - in air
; Top half - 7A: Facing left  - morph ball - spring ball - on ground
; Top half - 7C: Moving left  - morph ball - spring ball - on ground
; Top half - 7E: Facing left  - morph ball - spring ball - falling
; Top half - 80: Facing left  - morph ball - spring ball - in air
                        BB16 ; 0742
                        BAD7 ; 0743
                        BB0A ; 0744
                        BACB ; 0745
                        BAFE ; 0746
                        BABF ; 0747
                        BAE3 ; 0748
                        BAB3 ; 0749
                        0000 ; 074A
                        BC88 ; 074B

; Bottom half - 20: Unused
; Bottom half - 21: Unused
; Bottom half - 22: Unused
; Bottom half - 23: Unused
; Bottom half - 24: Unused
; Bottom half - 33: Unused
; Bottom half - 34: Unused
; Bottom half - 39: Unused
; Bottom half - 3A: Unused
; Bottom half - 42: Unused
; Top half - 19: Facing right - spin jump
; Top half - 20: Unused
; Top half - 21: Unused
; Top half - 22: Unused
; Top half - 23: Unused
; Top half - 24: Unused
; Top half - 33: Unused
; Top half - 34: Unused
; Top half - 39: Unused
; Top half - 3A: Unused
; Top half - 42: Unused
                        9BAE ; 074C
                        BD67 ; 074D
                        BD73 ; 074E
                        BD89 ; 074F
                        BD95 ; 0750
                        BDAB ; 0751
                        BDB7 ; 0752
                        BDCD ; 0753
                        BDD9 ; 0754
                        0000 ; 0755
                        0000 ; 0756
                        9B43 ; 0757

; Bottom half - 19: Facing right - spin jump
                        B1C8 ; 0758
                        0000 ; 0759
                        0000 ; 075A
                        0000 ; 075B
                        0000 ; 075C
                        0000 ; 075D
                        0000 ; 075E
                        0000 ; 075F
                        0000 ; 0760
                        0000 ; 0761
                        0000 ; 0762
                        AFB2 ; 0763

; Top half - 1A: Facing left  - spin jump
                        9BBF ; 0764
                        BB22 ; 0765
                        BB2E ; 0766
                        BB44 ; 0767
                        BB50 ; 0768
                        BB66 ; 0769
                        BB72 ; 076A
                        BB88 ; 076B
                        BB94 ; 076C
                        0000 ; 076D
                        0000 ; 076E
                        9B59 ; 076F

; Bottom half - 1A: Facing left  - spin jump
                        B1E3 ; 0770
                        0000 ; 0771
                        0000 ; 0772
                        0000 ; 0773
                        0000 ; 0774
                        0000 ; 0775
                        0000 ; 0776
                        0000 ; 0777
                        0000 ; 0778
                        0000 ; 0779
                        0000 ; 077A
                        AFBE ; 077B

; Top half - 1B: Facing right - space jump
                        9BAE ; 077C
                        BEBF ; 077D
                        BEBF ; 077E
                        BEBF ; 077F
                        BEBF ; 0780
                        BEBF ; 0781
                        BEBF ; 0782
                        BEBF ; 0783
                        BEBF ; 0784
                        0000 ; 0785
                        0000 ; 0786
                        9B43 ; 0787

; Bottom half - 1B: Facing right - space jump
                        B1C8 ; 0788
                        C458 ; 0789
                        C46E ; 078A
                        C4A2 ; 078B
                        C4B8 ; 078C
                        C4EC ; 078D
                        C502 ; 078E
                        C536 ; 078F
                        C54C ; 0790
                        0000 ; 0791
                        0000 ; 0792
                        AFB2 ; 0793

; Top half - 1C: Facing left  - space jump
                        9BBF ; 0794
                        BC7A ; 0795
                        BC7A ; 0796
                        BC7A ; 0797
                        BC7A ; 0798
                        BC7A ; 0799
                        BC7A ; 079A
                        BC7A ; 079B
                        BC7A ; 079C
                        0000 ; 079D
                        0000 ; 079E
                        9B59 ; 079F

; Bottom half - 1C: Facing left  - space jump
                        B1E3 ; 07A0
                        C330 ; 07A1
                        C346 ; 07A2
                        C37A ; 07A3
                        C390 ; 07A4
                        C3C4 ; 07A5
                        C3DA ; 07A6
                        C40E ; 07A7
                        C424 ; 07A8
                        0000 ; 07A9
                        0000 ; 07AA
                        AFBE ; 07AB

; Top half - 81: Facing right - screw attack
                        9BAE ; 07AC
                        BDEF ; 07AD
                        BDEF ; 07AE
                        BDEF ; 07AF
                        BEBF ; 07B0
                        BEBF ; 07B1
                        BEBF ; 07B2
                        BE23 ; 07B3
                        BE23 ; 07B4
                        BE23 ; 07B5
                        BEBF ; 07B6
                        BEBF ; 07B7
                        BEBF ; 07B8
                        BE5C ; 07B9
                        BE5C ; 07BA
                        BE5C ; 07BB
                        BEBF ; 07BC
                        BEBF ; 07BD
                        BEBF ; 07BE
                        BE95 ; 07BF
                        BE95 ; 07C0
                        BE95 ; 07C1
                        BEBF ; 07C2
                        BEBF ; 07C3
                        BEBF ; 07C4
                        0000 ; 07C5
                        0000 ; 07C6
                        9B43 ; 07C7

; Bottom half - 81: Facing right - screw attack
                        B1C8 ; 07C8
                        C458 ; 07C9
                        C46E ; 07CA
                        C4A2 ; 07CB
                        C4B8 ; 07CC
                        C4EC ; 07CD
                        C502 ; 07CE
                        C536 ; 07CF
                        C54C ; 07D0
                        C458 ; 07D1
                        C46E ; 07D2
                        C4A2 ; 07D3
                        C4B8 ; 07D4
                        C4EC ; 07D5
                        C502 ; 07D6
                        C536 ; 07D7
                        C54C ; 07D8
                        C458 ; 07D9
                        C46E ; 07DA
                        C4A2 ; 07DB
                        C4B8 ; 07DC
                        C4EC ; 07DD
                        C502 ; 07DE
                        C536 ; 07DF
                        C54C ; 07E0
                        0000 ; 07E1
                        0000 ; 07E2
                        AFB2 ; 07E3

; Top half - 82: Facing left  - screw attack
                        9BBF ; 07E4
                        BBAA ; 07E5
                        BBAA ; 07E6
                        BBAA ; 07E7
                        BC7A ; 07E8
                        BC7A ; 07E9
                        BC7A ; 07EA
                        BBDE ; 07EB
                        BBDE ; 07EC
                        BBDE ; 07ED
                        BC7A ; 07EE
                        BC7A ; 07EF
                        BC7A ; 07F0
                        BC17 ; 07F1
                        BC17 ; 07F2
                        BC17 ; 07F3
                        BC7A ; 07F4
                        BC7A ; 07F5
                        BC7A ; 07F6
                        BC50 ; 07F7
                        BC50 ; 07F8
                        BC50 ; 07F9
                        BC7A ; 07FA
                        BC7A ; 07FB
                        BC7A ; 07FC
                        0000 ; 07FD
                        0000 ; 07FE
                        9B59 ; 07FF

; Bottom half - 82: Facing left  - screw attack
                        B1E3 ; 0800
                        C330 ; 0801
                        C346 ; 0802
                        C37A ; 0803
                        C390 ; 0804
                        C3C4 ; 0805
                        C3DA ; 0806
                        C40E ; 0807
                        C424 ; 0808
                        C330 ; 0809
                        C346 ; 080A
                        C37A ; 080B
                        C390 ; 080C
                        C3C4 ; 080D
                        C3DA ; 080E
                        C40E ; 080F
                        C424 ; 0810
                        C330 ; 0811
                        C346 ; 0812
                        C37A ; 0813
                        C390 ; 0814
                        C3C4 ; 0815
                        C3DA ; 0816
                        C40E ; 0817
                        C424 ; 0818
                        0000 ; 0819
                        0000 ; 081A
                        AFBE ; 081B

; Samus' suit exploding - facing right
                        C8B7 ; 081C
                        C8E6 ; 081D
                        C956 ; 081E
                        C9DA ; 081F
                        CA54 ; 0820
                        CAD3 ; 0821
                        CB52 ; 0822
                        CB7C ; 0823
                        CBB5 ; 0824

; Samus' suit exploding - facing right
                        C580 ; 0825
                        C5AF ; 0826
                        C61F ; 0827
                        C6A3 ; 0828
                        C71D ; 0829
                        C79C ; 082A
                        C81B ; 082B
                        C845 ; 082C
                        C87E ; 082D

; Bottom half - CB: Facing right - shinespark - vertical
; Top half - CB: Facing right - shinespark - vertical
                        C162 ; 082E

; Bottom half - CC: Facing left  - shinespark - vertical
; Top half - CC: Facing left  - shinespark - vertical
                        C17D ; 082F
}


;;; $90ED: Samus spritemaps ;;;
{
$92:90ED             dx 0001, 01FC,FC,315A
$92:90F4             dx 0019, 0039,E8,3136, 0031,E8,3144, 0029,E8,3131, 0021,E8,3134, 0019,E8,3133, 0010,08,314B, 0008,08,313D, 0000,08,313E, 01F8,08,3138, 01F0,08,3143, 01E8,08,313F, 01E0,08,313E, 0010,F8,314A, 0008,F8,313D, 0000,F8,313E, 01F8,F8,3138, 01F0,F8,3143, 01E8,F8,313F, 01E0,F8,313E, 0008,E8,313B, 0000,E8,3130, 01F8,E8,3144, 01F0,E8,3142, 01E8,E8,3138, 01E0,E8,3145
$92:9173             dx 0001, 0000,00,3A5F
$92:917A             dx 0010, 0018,00,3817, 0010,00,3816, 0008,00,3815, 0000,00,3814, 01F8,00,3813, 01F0,00,3812, 01E8,00,3811, 01E0,00,3810, 0018,F8,3807, 0010,F8,3806, 0008,F8,3805, 0000,F8,3804, 01F8,F8,3803, 01F0,F8,3802, 01E8,F8,3801, 01E0,F8,3800
$92:91CC             dx 0010, 0018,00,381F, 0010,00,381E, 0008,00,381D, 0000,00,381C, 01F8,00,381B, 01F0,00,381A, 01E8,00,3819, 01E0,00,3818, 0018,F8,380F, 0010,F8,380E, 0008,F8,380D, 0000,F8,380C, 01F8,F8,380B, 01F0,F8,380A, 01E8,F8,3809, 01E0,F8,3808
$92:921E             dx 0008, 0018,00,3C37, 0010,00,3C36, 0008,00,3C35, 0000,00,3C34, 01F8,00,3C33, 01F0,00,3C32, 01E8,00,3C31, 01E0,00,3C30
$92:9248             dx 0005, 0000,00,3A24, 01F8,00,3A23, 01F0,00,3A22, 01E8,00,3A21, 01E0,00,3A20
}


;;; $9263: Samus spritemap table indices - top half ;;;
{
; Indexed by [Samus pose], base indices into Samus spritemap table ($808D)
$92:9263             dw 0002,019A,01A3,01AD,01AF,01B1,01B3,01B5,01B7,01F9,0203,020D,0217,0221,022B,0235,
                        023F,0249,0253,0275,0277,0279,027B,0271,0273,074C,0764,077C,0794,0710,0724,072E,
                        074C,074C,074C,074C,074C,0419,041C,03F1,03FA,03B7,03BE,03D3,03D6,03D9,03DB,0419,
                        041C,0710,0710,074C,074C,0403,0404,0405,0407,074C,074C,0403,0404,0409,040B,0710,
                        0710,071A,074C,0419,041C,025D,0267,019A,01A3,01D5,01DB,0289,028A,028B,0291,0297,
                        02A1,0285,0287,031F,0321,01CD,01CF,01B1,01B3,01B5,01B7,032F,0330,0331,0331,0331,
                        0332,0333,0375,02AB,02AD,02AF,02B8,03C5,03CC,027D,027F,0281,0283,03DD,03E0,03E3,
                        03E6,03E9,03EA,03EB,03EC,01E1,01E7,01ED,01F3,0738,0742,0738,0742,0738,0742,0738,
                        0742,07AC,07E4,02C1,02F0,03ED,03EF,0419,041C,019A,01A3,041F,0422,0425,0428,041F,
                        0422,0425,0428,041F,0422,0425,0428,041F,0422,0425,0428,00C2,041F,0422,041F,0422,
                        041F,0422,041F,0422,01B9,01BB,01BD,01C0,019A,01A3,01B5,01B7,0275,0277,0271,0273,
                        0281,0283,0333,0375,03F1,03FA,03EB,03EC,032F,0330,042F,0430,0431,0432,0439,0419,
                        041C,041F,0422,0425,0428,071A,0419,028B,0291,043F,0440,082E,082F,0441,0442,01B1,
                        01B3,01B5,01B7,0443,0452,01C3,01C8,0461,0467,01C3,01C8,040D,0410,0413,0416,071A,
                        01CD,01CF,01B1,01B3,01B5,01B7,01D1,01D3,046D,047C,049C,04A2,042B,042C,042D,042E,
                        0433,01CD,01CF,01B1,01B3,01B5,01B7,01CD,01CF,01B1,01B3,01B5,01B7
}


;;; $945D: Samus spritemap table indices - bottom half ;;;
{
; Indexed by [Samus pose], base indices into Samus spritemap table ($808D)
$92:945D             dw 0062,04AA,04B3,04C0,04C2,04C0,04C2,04C0,04C2,04E3,04ED,04E3,04ED,04E3,04ED,04E3,
$92:947D             dw 04ED,04E3,04ED,0507,0509,050B,050D,0503,0505,0758,0770,0788,07A0,0710,0724,072E,
$92:949D             dw 074C,074C,074C,074C,074C,0687,068A,065F,0668,063B,0642,064D,0650,0649,064B,068D,
$92:94BD             dw 0690,0710,0710,074C,074C,0679,067A,0405,0407,074C,074C,0679,067A,0409,040B,0710,
$92:94DD             dw 0710,071A,074C,068D,0690,04E3,04ED,04AA,04B3,04F7,04FD,051B,051C,051D,0523,0529,
$92:94FD             dw 0533,050F,0511,05B1,05B3,051B,051C,051B,051C,051B,051C,05B5,05B6,05B7,05B7,05B7,
$92:951D             dw 05B7,05B7,05F9,053D,053F,0541,054A,063B,0642,0513,0515,0517,0519,0653,0656,0659,
$92:953D             dw 065C,0671,0672,0673,0674,04F7,04FD,04F7,04FD,0738,0742,0738,0742,0738,0742,0738,
$92:955D             dw 0742,07C8,0800,0553,0582,0675,0677,068D,0696,04AA,04B3,0687,068A,0687,068A,068D,
$92:957D             dw 0690,068D,0690,068D,0696,068D,0696,068D,0690,068D,0690,0122,0687,068A,068D,0690,
$92:959D             dw 068D,0696,068D,0690,04C5,04C7,04C9,04CC,04AA,04B3,04C0,04C2,0507,0509,0503,0505,
$92:95BD             dw 0517,0519,05B7,05F9,065F,0668,0673,0674,05B5,05B6,069A,069A,069A,069A,06A1,0687,
$92:95DD             dw 068A,0687,068A,0687,068A,071A,0687,051D,0523,06A7,06A8,082E,082F,06A9,06AA,04C0,
$92:95FD             dw 04C2,04C0,04C2,06AB,06BA,04CF,04D4,06C9,06CF,04D9,04DE,067D,0680,0681,0684,071A,
$92:961D             dw 04C5,04C7,04C5,04C7,04C5,04C7,04C5,04C7,06D5,06E4,0704,070A,0699,0699,0699,0699,
$92:963D             dw 069B,0679,067A,0679,067A,0679,067A,0679,067A,0679,067A,0679,067A
}


;;; $9657: Samus spritemaps ;;;
{
$92:9657             dx 0002, C3FB,F8,2800, C3FB,F0,2802
$92:9663             dx 0002, C3FB,F7,2800, C3FB,EF,2802
$92:966F             dx 0003, C3FF,F7,2800, 0007,EF,2804, C3F7,EF,2802
$92:9680             dx 0003, 0008,EE,2804, C200,F6,2800, C3F8,EE,2802
$92:9691             dx 0002, C3F9,F7,2800, C3F9,EF,2802
$92:969D             dx 0003, C3FE,EF,2800, C3F6,F7,2802, C3F6,EF,2804
$92:96AE             dx 0002, C3F5,F8,2800, C3F5,F0,2802
$92:96BA             dx 0002, C3F5,F7,2800, C3F5,EF,2802
$92:96C6             dx 0003, C3F1,F7,2800, C3F9,EF,2802, C3F1,EF,2804
$92:96D7             dx 0003, C3F0,F6,2800, C3F0,EE,2802, C3F8,EE,2804
$92:96E8             dx 0002, C3F7,F7,2800, C3F7,EF,2802
$92:96F4             dx 0003, C3FA,F7,2800, 0002,EF,2804, C3F2,EF,2802
$92:9705             dx 0006, 01FD,FB,2802, 0005,F3,2803, 01FD,F3,2804, 000B,01,2805, 0007,FD,2806, C3FA,F0,2800
$92:9725             dx 0006, 01ED,01,6802, 01F1,FD,6803, 01FC,FB,2804, 01F4,F3,2805, 01FC,F3,2806, C3F6,F0,2800
$92:9745             dx 0005, 0006,01,2804, C3FE,F1,2800, C3F6,F1,2802, 000D,03,2805, 0009,FF,2806
$92:9760             dx 0005, 01EF,FF,6804, 01F0,01,2805, C3F0,F1,2800, 01EB,03,6806, C3F8,F1,2802
$92:977B             dx 0005, 0001,00,2802, 01F9,00,2803, C3F9,F0,2800, 000A,FD,2804, 0002,FD,2805
$92:9796             dx 0005, 01FF,00,2802, 01F7,00,2803, C3F7,F0,2800, 01EE,FD,6804, 01F6,FD,6805
$92:97B1             dx 0004, 000A,EE,6804, C3FF,F1,2800, 000E,EA,6805, C3F7,F1,2802
$92:97C7             dx 0004, 01EA,E9,2804, C3F1,F1,2800, 01EE,ED,2805, C3F9,F1,2802
$92:97DD             dx 0003, C3FF,F8,2800, 0007,F0,2804, C3F7,F0,2802
$92:97EE             dx 0003, C3F1,F8,2800, C3F9,F0,2802, C3F1,F0,2804
$92:97FF             dx 0005, 01F9,F9,2802, 01F9,F1,2803, 01FE,E1,2804, 01FE,E9,2805, C3F9,F1,2800
$92:981A             dx 0005, 01FF,F9,2802, 01FF,F1,2803, 01FA,E1,6804, C3F7,F1,2800, 01FA,E9,6805
$92:9835             dx 0003, C3FF,EE,2800, 01F7,FE,2804, C3F7,EE,2802
$92:9846             dx 0003, C3F1,EE,2800, 0001,FE,2804, C3F9,EE,2802
$92:9857             dx 0005, 000C,EA,6802, 01FD,F8,2803, 01FD,F0,2804, 0008,EE,6805, C3FB,F0,2800
$92:9872             dx 0006, 01FB,FB,2802, 01FB,F3,2803, 01F3,F3,2804, 01EC,EA,2805, 01F0,EE,2806, C3F5,F0,2800
$92:9892             dx 0005, 01F7,F1,6806, 01F3,F5,6807, C3F3,F0,2800, C3FB,E8,2802, C3FB,F0,2804
$92:98AD             dx 0005, 0004,F4,6806, 0000,F8,6807, C3F5,E8,6800, C3FD,F0,6802, C3F5,F0,6804
$92:98C8             dx 0007, 01F5,F3,2802, 01FD,F3,2803, 01E7,FB,6804, C3F6,F0,2800, 01EF,FB,6805, 01FE,00,2806, 01F6,00,2807
$92:98ED             dx 0007, 01FD,FB,2802, 0004,F3,2803, 01FC,F3,2804, 0011,FB,2805, 0002,00,2806, C3FA,F0,2800, 0009,FB,2807
$92:9912             dx 0004, C3F9,F8,2800, C3F9,F0,2802, 000A,FE,2804, 0002,FE,2805
$92:9928             dx 0004, C3F7,F8,2800, C3F7,F0,2802, 01EE,FE,6804, 01F6,FE,6805
$92:993E             dx 0004, 01F4,E8,2806, C3FC,E8,2800, C3FC,F0,2802, C3F4,F0,2804
$92:9954             dx 0005, 01F4,00,2806, 0004,F8,2807, C3FC,E8,2800, C3F4,E8,2802, C3F4,F0,2804
$92:996F             dx 0001, 01F8,F8,2C00
$92:9976             dx 0002, C3FF,F0,6800, C3F0,F0,2800
$92:9982             dx 0004, 0004,E8,2804, 01FC,E8,2805, C3FC,F0,2800, C3F4,F0,2802
$92:9998             dx 0004, 01F5,E8,6804, 01FD,E8,6805, C3F2,F0,2800, C3FA,F0,2802
$92:99AE             dx 0006, 01F3,E8,2802, 0003,E8,2803, 01FB,E8,2804, 0003,F8,2805, 0003,F0,2806, C3F3,F0,2800
$92:99CE             dx 0005, 0004,E8,2802, 01FC,E8,2803, 01F4,F8,2804, 01F4,F0,2805, C3FC,F0,2800
$92:99E9             dx 0004, 0004,E8,2806, C3F4,E8,2800, C3F4,F0,2802, C3FC,F0,2804
$92:99FF             dx 0006, 01E2,F4,6804, 01EA,F4,6805, C3EC,F0,2800, 0004,08,2806, 0004,00,2807, C3FC,F0,2802
$92:9A1F             dx 0006, 0015,F4,2804, 000D,F4,2805, 01F4,08,2806, 01F4,00,2807, C204,F0,2800, C3F4,F0,2802
$92:9A3F             dx 0002, C3FA,F8,2800, C3FA,F0,2802
$92:9A4B             dx 0002, C3F8,F8,2800, C3F8,F0,2802
$92:9A57             dx 0002, C3F6,F8,2800, C3F6,F0,2802
$92:9A63             dx 0002, C3F8,F8,2800, C3F8,F0,2802
$92:9A6F             dx 0002, C3FC,F0,2800, C3F4,F0,2802
$92:9A7B             dx 0002, C3FC,F0,2800, C204,F0,2802
$92:9A87             dx 0002, C3F4,F0,6800, C3EC,F0,6802
$92:9A93             dx 0005, 01ED,F8,6806, 01F1,F4,6807, C200,F8,6800, C3F0,F0,6802, C200,F0,6804
$92:9AAE             dx 0005, 01F6,FC,6806, 01F2,00,6807, C3F0,F8,2800, C200,F0,2802, C3F0,F0,2804
$92:9AC9             dx 0001, 01F8,F8,3800
$92:9AD0             dx 0001, 01F8,F8,3800
$92:9AD7             dx 0006, 01F8,00,2802, 0004,E8,2803, 01FC,E8,2804, 0004,F8,2805, 0004,F0,2806, C3F4,F0,2800
$92:9AF7             dx 0006, 01F7,00,2802, 01F6,E8,6803, 01FE,E8,6804, 01F3,F8,2805, 01F3,F0,2806, C3FB,F0,2800
$92:9B17             dx 0004, 01FF,05,E804, 01FF,0D,E805, C3F8,F0,2800, C3F8,F8,2802
$92:9B2D             dx 0004, 01F8,05,A804, 01F8,0D,A805, C3F8,F0,2800, C3F8,F8,2802
$92:9B43             dx 0004, C3F4,F0,2800, 000C,08,2804, 000C,00,2805, C204,F0,2802
$92:9B59             dx 0004, C3FC,F0,2800, 01EC,08,2804, 01EC,00,2805, C3EC,F0,2802
$92:9B6F             dx 0003, 0001,FE,2802, 01F9,FE,2803, C3F7,F0,2800
$92:9B80             dx 0002, C3F9,F8,2800, C3F9,F0,2802
$92:9B8C             dx 0004, 01FE,03,2804, 01FA,FF,2805, C3F7,F8,2800, C3F7,F0,2802
$92:9BA2             dx 0002, C3F9,F8,2800, C3F9,F0,2802
$92:9BAE             dx 0003, 01FB,00,2802, 01F7,FC,2803, C3F7,F0,2800
$92:9BBF             dx 0002, C3F9,F8,2800, C3F9,F0,2802
$92:9BCB             dx 0006, 01FD,F9,2802, 0005,F1,2803, 01FD,F1,2804, 000B,00,2805, 0007,FC,2806, C3FA,EF,2800
$92:9BEB             dx 0006, 01F1,FC,6802, 01ED,00,6803, 01FC,F9,2804, 01F4,F1,2805, 01FC,F1,2806, C3F6,EF,2800
$92:9C0B             dx 0005, 01F9,F0,6802, 0001,F0,6803, C3F9,F8,2800, 000A,FD,2804, 0002,FD,2805
$92:9C26             dx 0005, 01F9,F0,6802, 0001,F0,6803, C3F9,F8,2800, 000A,FD,2804, 0002,FD,2805
$92:9C41             dx 0005, 01F9,F0,6802, 0001,F0,6803, C3F9,F8,2800, 000A,FD,2804, 0002,FD,2805
$92:9C5C             dx 0005, 01F9,F0,6802, 0001,F0,6803, C3F9,F8,2800, 000A,FD,2804, 0002,FD,2805
$92:9C77             dx 0005, 01F7,F0,2802, 01FF,F0,2803, C3F7,F8,2800, 01EE,FD,6804, 01F6,FD,6805
$92:9C92             dx 0005, 01F7,F0,2802, 01FF,F0,2803, C3F7,F8,2800, 01EE,FD,6804, 01F6,FD,6805
$92:9CAD             dx 0005, 01FF,F0,2802, 01F7,F0,2803, C3F7,F8,2800, 01EE,FD,6804, 01F6,FD,6805
$92:9CC8             dx 0005, 01FF,F0,2802, 01F7,F0,2803, C3F7,F8,2800, 01EE,FD,6804, 01F6,FD,6805
$92:9CE3             dx 0005, 000C,E9,6802, 01FD,F6,2803, 01FD,EE,2804, 0008,ED,6805, C3FB,EF,2800
$92:9CFE             dx 0006, 01FB,F9,2802, 01FB,F1,2803, 01F3,F1,2804, 01EC,E9,2805, 01F0,ED,2806, C3F5,EF,2800
$92:9D1E             dx 0007, 01F5,F1,2802, 01FD,F1,2803, 01E7,FA,6804, C3F6,EF,2800, 01EF,FA,6805, 01FE,FF,2806, 01F6,FF,2807
$92:9D43             dx 0007, 01FC,F9,2802, 0004,F1,2803, 01FC,F1,2804, 0011,FA,2805, 0002,FF,2806, C3FA,EF,2800, 0009,FA,2807
$92:9D68             dx 0007, 01F5,F1,2802, 01FD,F1,2803, 01E7,F9,6804, C3F6,EE,2800, 01EF,F9,6805, 01FE,FE,2806, 01F6,FE,2807
$92:9D8D             dx 0007, 01FC,F9,2802, 0004,F1,2803, 01FC,F1,2804, 0011,F9,2805, 0002,FE,2806, C3FA,EE,2800, 0009,F9,2807
$92:9DB2             dx 0005, 000C,E8,6802, 01FD,F6,2803, 01FD,EE,2804, 0008,EC,6805, C3FB,EE,2800
$92:9DCD             dx 0006, 01FB,F9,2802, 01FB,F1,2803, 01F3,F1,2804, 01EC,E8,2805, 01F0,EC,2806, C3F5,EE,2800
$92:9DED             dx 0006, 01FD,F9,2802, 0005,F1,2803, 01FD,F1,2804, 000B,FF,2805, 0007,FB,2806, C3FA,EE,2800
$92:9E0D             dx 0006, 01F1,FB,6802, 01FC,F9,2803, 01F4,F1,2804, 01FC,F1,2805, 01ED,FF,6806, C3F6,EE,2800
$92:9E2D             dx 0005, 0001,FF,2802, 01F9,FF,2803, C3F9,EF,2800, 000A,FC,2804, 0002,FC,2805
$92:9E48             dx 0005, 01FF,FF,2802, 01F7,FF,2803, C3F7,EF,2800, 01EE,FC,6804, 01F6,FC,6805
$92:9E63             dx 0006, 0005,F7,2802, 01FD,F7,2803, 01F9,F5,2804, 01F9,F7,6805, 01F9,EF,6806, C3FA,F0,6800
$92:9E83             dx 0005, 0005,EF,2802, 01FD,EF,2803, 01F9,F6,6804, 01F9,EE,6805, C3FA,F0,6800
$92:9E9E             dx 0005, 01FD,F6,2802, 01F5,F6,2803, 01FE,F7,2804, 01FE,EF,2805, C3F6,F0,2800
$92:9EB9             dx 0005, 01F9,F0,2802, 01F1,F0,2803, 01FE,F6,2804, 01FE,EE,2805, C3F6,F0,2800
$92:9ED4             dx 0006, 01FE,F4,2802, 01F6,F4,2803, 01F2,02,2804, 01FA,02,2805, 01FA,FA,2806, C3F6,F2,2800
$92:9EF4             dx 0006, 01FD,F5,2802, 01F5,F5,2803, 01F3,03,2804, 01FB,03,2805, 01FB,FB,2806, C3F6,F3,2800
$92:9F14             dx 0006, 01FC,F6,2802, 01F4,F6,2803, 01F4,04,2804, 01FC,04,2805, 01FC,FC,2806, C3F6,F4,2800
$92:9F34             dx 0007, 0000,00,2802, 0004,04,2803, 01FE,02,6804, 01FA,F4,6805, 0002,F4,6806, 01FE,FA,6807, C3FA,F2,6800
$92:9F59             dx 0007, 01FF,01,2802, 0003,05,2803, 01FB,F5,6804, 0003,F5,6805, 01FD,03,6806, 01FD,FB,6807, C3FA,F3,6800
$92:9F7E             dx 0007, 01FE,02,2802, 0002,06,2803, 01FC,F6,6804, 0004,F6,6805, 01FC,04,6806, 01FC,FC,6807, C3FA,F4,6800
$92:9FA3             dx 0006, 01FE,F4,2802, 01F6,F4,2803, 01F2,02,2804, 01FA,02,2805, 01FA,FA,2806, C3F6,F2,2800
$92:9FC3             dx 0006, 01FD,F5,2802, 01F5,F5,2803, 01F3,03,2804, 01FB,03,2805, 01FB,FB,2806, C3F6,F3,2800
$92:9FE3             dx 0006, 01FC,F6,2802, 01F4,F6,2803, 01F4,04,2804, 01FC,04,2805, 01FC,FC,2806, C3F6,F4,2800
$92:A003             dx 0007, 0000,00,2802, 0004,04,2803, 01FA,F4,6804, 0002,F4,6805, 01FE,02,6806, 01FE,FA,6807, C3FA,F2,6800
$92:A028             dx 0007, 01FF,01,2802, 0003,05,2803, 01FB,F5,6804, 0003,F5,6805, 01FD,03,6806, 01FD,FB,6807, C3FA,F3,6800
$92:A04D             dx 0007, 01FE,02,2802, 0002,06,2803, 01FC,F6,6804, 0004,F6,6805, 01FC,04,6806, 01FC,FC,6807, C3FA,F4,6800
$92:A072             dx 0004, C3F9,F8,2800, C3F9,F0,2802, 000A,FD,2804, 0002,FD,2805
$92:A088             dx 0004, C3F9,F8,2800, C3F9,F0,2802, 000A,FD,2804, 0002,FD,2805
$92:A09E             dx 0004, C3F9,F8,2800, C3F9,F0,2802, 000A,FD,2804, 0002,FD,2805
$92:A0B4             dx 0004, C3F7,F8,2800, C3F7,F0,2802, 01EE,FD,6804, 01F6,FD,6805
$92:A0CA             dx 0004, C3F7,F8,2800, C3F7,F0,2802, 01EE,FD,6804, 01F6,FD,6805
$92:A0E0             dx 0004, C3F7,F8,2800, C3F7,F0,2802, 01EE,FD,6804, 01F6,FD,6805
$92:A0F6             dx 0005, 0001,00,2802, 01F9,00,2803, C3F9,F0,2800, 000A,FD,2804, 0002,FD,2805
$92:A111             dx 0005, 01FF,00,2802, 01F7,00,2803, C3F7,F0,2800, 01EE,FD,6804, 01F6,FD,6805
$92:A12C             dx 0001, 01F8,F8,3000
$92:A133             dx 0001, 01F8,F8,3800
$92:A13A             dx 0009, 0004,10,3800, 0004,08,3801, 01FC,08,3802, 01FC,00,3803, 01FC,F8,3804, 0004,F0,3805, 01FC,F0,3806, 01F4,F0,3807, 01F4,E8,3810
$92:A169             dx 0007, 0004,00,3800, 01FC,00,3801, 01F4,00,3802, 0004,F8,3803, 01FC,F8,3804, 01F4,F8,3805, 01F4,F0,3806
$92:A18E             dx 000B, 01FC,10,3800, 01F4,10,3801, 01FC,08,3802, 01F4,08,3803, 0004,00,3804, 01FC,00,3805, 0004,F8,3806, 01FC,F8,3807, 01FC,F0,3810, 0004,E8,3811, 01FC,E8,3812
$92:A1C7             dx 000F, 01FC,10,3800, 01F4,10,3801, 01FC,08,3802, 01F4,08,3803, 0004,00,3804, 01FC,00,3805, 01F4,00,3806, 0004,F8,3807, 01FC,F8,3810, 01F4,F8,3811, 0004,F0,3812, 01FC,F0,3813, 01F4,F0,3814, 0004,E8,3815, 01FC,E8,3816
$92:A214             dx 0008, 01FC,10,3800, 01FC,08,3801, 01FC,00,3802, 0004,F8,3803, 01F4,F8,3804, 0004,F0,3805, 01F4,F0,3806, 0004,E8,3807
$92:A23E             dx 000A, 01FC,10,3800, 0004,08,3801, 01FC,08,3802, 0004,00,3803, 01FC,00,3804, 0004,F0,3805, 01FC,F0,3806, 01F4,F0,3807, 0004,E8,3810, 01FC,E8,3811
$92:A272             dx 000B, 01F4,10,3800, 0004,08,3801, 01FC,08,3802, 01F4,08,3803, 0004,00,3804, 01FC,00,3805, 01F4,00,3806, 01F4,F0,3807, 0004,E8,3810, 01FC,E8,3811, 01F4,E8,3812
$92:A2AB             dx 0007, 0004,08,3800, 01F4,08,3801, 01F4,00,3802, 0004,F8,3803, 0004,E8,3804, 01FC,E8,3805, 01F4,E8,3806
$92:A2D0             dx 0003, 0011,FA,2802, 0009,FA,2803, C3FA,F0,2800
$92:A2E1             dx 0003, 0011,F9,2802, 0009,F9,2803, C3FA,EF,2800
$92:A2F2             dx 0004, 0011,F9,2802, 0009,F9,2803, 0007,F7,2804, C3F7,EF,2800
$92:A308             dx 0005, 0011,F8,2802, 0009,F8,2803, 0005,EE,2804, 0005,F6,2805, C3F5,EE,2800
$92:A323             dx 0003, 0011,F9,2802, 0009,F9,2803, C3FA,EF,2800
$92:A334             dx 0004, 0011,F9,2802, 0009,F9,2803, 000A,F7,2804, C3FA,EF,2800
$92:A34A             dx 0005, 01EF,FA,6802, 01E7,FA,6803, 01FE,00,2804, 01F6,00,2805, C3F6,F0,2800
$92:A365             dx 0005, 01EF,F9,6802, 01E7,F9,6803, 01FE,FF,2804, 01F6,FF,2805, C3F6,EF,2800
$92:A380             dx 0006, 01EE,F7,2802, 01FE,FF,2803, 01F6,FF,2804, C3F6,EF,2800, 01EF,F9,6805, 01E7,F9,6806
$92:A3A0             dx 0006, 01EE,F6,2802, 01EF,F8,6803, 01E7,F8,6804, 01FE,FE,2805, 01F6,FE,2806, C3F6,EE,2800
$92:A3C0             dx 0005, 01EF,F9,6802, 01E7,F9,6803, 01FE,FF,2804, 01F6,FF,2805, C3F6,EF,2800
$92:A3DB             dx 0007, 01EF,F9,6802, 01E7,F9,6803, 0006,FF,2804, 01FE,FF,2805, 01F6,F7,2806, 01F6,EF,2807, C3FE,EF,2800
$92:A400             dx 0005, 0011,F8,2802, 0009,F8,2803, 000A,F6,2804, 000A,EE,2805, C3FA,EE,2800
$92:A41B             dx 0007, 01EF,F8,6802, 01E7,F8,6803, 0006,FE,2804, 01FE,FE,2805, 01F6,F6,2806, 01F6,EE,2807, C3FE,EE,2800
$92:A440             dx 0003, 0011,FA,2802, 0009,FA,2803, C3FA,F0,2800
$92:A451             dx 0005, 01EF,FA,6802, 01E7,FA,6803, 01FE,00,2804, 01F6,00,2805, C3F6,F0,2800
$92:A46C             dx 0004, 001C,FD,2804, 0014,FD,2805, C205,F6,2800, C200,F8,2802
$92:A482             dx 0004, 001B,F7,2804, 0013,F7,2805, C204,F4,2800, C3FF,F6,2802
$92:A498             dx 0003, C210,F1,2800, C204,F3,2802, C3FF,F5,2804
$92:A4A9             dx 0003, C202,EF,2800, C20E,ED,2802, C3FF,F2,2804
$92:A4BA             dx 0003, C20C,E5,2800, C202,EF,2802, C3FF,F2,2804
$92:A4CB             dx 0003, C209,E5,2800, C201,EF,2802, C3FF,F2,2804
$92:A4DC             dx 0003, C207,E3,2800, C201,ED,2802, C3FE,F1,2804
$92:A4ED             dx 0004, 0004,E6,2804, 0004,DE,2805, C3FD,EC,2800, C3FB,F0,2802
$92:A503             dx 0004, 01FD,E5,2804, 01FD,DD,2805, C3F6,EC,2800, C3F8,F0,2802
$92:A519             dx 0004, 01F8,E6,6804, 01F8,DE,6805, C3F3,EC,2800, C3F7,F0,2802
$92:A52F             dx 0003, C3EE,E2,6800, C3F3,ED,2802, C3F5,F1,2804
$92:A540             dx 0003, C3E8,E4,6800, C3F0,EF,2802, C3F2,F2,2804
$92:A551             dx 0003, C3E3,E5,6800, C3EE,EF,2802, C3F2,F2,2804
$92:A562             dx 0003, C3E0,E9,6800, C3EB,F2,2802, C3F1,F3,2804
$92:A573             dx 0003, C3E0,EF,6800, C3EB,F4,2802, C3F1,F3,2804
$92:A584             dx 0004, 01DD,F7,6804, 01E5,F7,6805, C3EB,F9,2800, C3F0,F7,2802
$92:A59A             dx 0004, 01DC,FC,6804, 01E4,FC,6805, C3EB,F9,2800, C3F0,F8,2802
$92:A5B0             dx 0008, 0001,FB,2804, 0001,F3,2805, C3F1,F3,2800, C3F0,F8,6802, 01DC,FC,6806, 01E4,FC,6807, 01EB,02,2814, 01EB,FA,2815
$92:A5DA             dx 0008, 01DC,F8,6804, 01E4,F8,6805, 0001,FA,2806, 0001,F2,2807, C3F1,F2,2800, C3F0,F7,6802, 01EB,00,2814, 01EB,F8,2815
$92:A604             dx 000A, 0005,FA,2804, 0005,F2,2805, C3F5,F2,2800, C3F1,F5,6802, 01E0,F8,6806, 01E8,F8,6807, 01E0,F0,6814, 01E8,F0,6815, 01EB,FD,2816, 01EB,F5,2817
$92:A638             dx 000A, 0005,F9,2804, 0005,F1,2805, C3F5,F1,2800, C3F1,F4,6802, 01E0,F5,6806, 01E8,F5,6807, 01E0,ED,6814, 01E8,ED,6815, 01EB,FB,2816, 01EB,F3,2817
$92:A66C             dx 0009, 01FD,FE,2804, C3F5,EE,2800, C3F0,F2,6802, 01E2,EC,6805, 01EA,EC,6806, 01E2,E4,6807, 01EA,E4,6814, 01F4,EE,2815, 01EC,EE,2816
$92:A69B             dx 0009, 01FE,FE,2804, C3F6,EE,2800, C3F2,F1,6802, 01F6,ED,2805, 01EE,ED,2806, 01ED,EB,6807, 01E5,EB,6814, 01E5,E3,6815, 01ED,E3,6816
$92:A6CA             dx 0009, 01E9,E9,6804, 01FE,FE,2805, C3F6,EE,2800, C3F2,F1,6802, 01F1,E9,6806, 01E9,E1,6807, 01F1,E1,6814, 01F6,EC,2815, 01EE,EC,2816
$92:A6F9             dx 0008, 0000,02,2804, 01F8,02,2805, C3F8,F2,2800, C3F6,F0,6802, 01F8,EB,2806, 01F0,EB,2807, 01F5,E5,6814, 01F5,DD,6815
$92:A723             dx 0008, 01FF,03,2804, 01F7,03,2805, C3F7,F3,2800, C3F9,F1,6802, 01FC,E4,2806, 01FC,DC,2807, 01FD,EB,2814, 01F5,EB,2815
$92:A74D             dx 0008, 01FF,01,2804, 01F7,01,2805, C3F7,F1,2800, C3FA,F0,6802, 0002,E5,2806, 0002,DD,2807, 0003,EB,2814, 01FB,EB,2815
$92:A777             dx 0009, 000B,E8,2804, 01F1,FC,2805, C3F9,F4,2800, C3FB,F0,6802, 0003,E8,2806, 000B,E0,2807, 0003,E0,2814, 0005,EB,2815, 01FD,EB,2816
$92:A7A6             dx 000A, 0010,EA,2804, 0008,EA,2805, 0010,E2,2806, 0008,E2,2807, 01F1,FD,2814, 01F1,F5,2815, C3F9,F5,2800, C3FD,F2,6802, 0008,ED,2816, 0000,ED,2817
$92:A7DA             dx 000A, 01F1,FD,2804, 01F1,F5,2805, C3F9,F5,2800, C3FD,F2,6802, 0013,EC,2806, 000B,EC,2807, 0013,E4,2814, 000B,E4,2815, 0009,EE,2816, 0001,EE,2817
$92:A80E             dx 000A, 01F4,FC,2804, 01F4,F4,2805, C3FC,F4,2800, C3FE,F4,6802, 0016,F3,2806, 000E,F3,2807, 0016,EB,2814, 000E,EB,2815, 000A,F6,2816, 000A,EE,2817
$92:A842             dx 000A, 01F4,FC,2804, 01F4,F4,2805, C3FC,F4,2800, C3FE,F4,6802, 0017,F7,2806, 000F,F7,2807, 0017,EF,2814, 000F,EF,2815, 000B,F8,2816, 000B,F0,2817
$92:A876             dx 0009, C3FE,F3,2800, 01F6,FB,2804, 01F6,F3,2805, 01F6,EB,2806, C3FF,F7,6802, 000E,FA,2807, 000E,F9,A814, 001C,F7,2815, 0014,F7,2816
$92:A8A5             dx 0009, C3FE,F4,2800, 01F6,FC,2804, 01F6,F4,2805, 01F6,EC,2806, C3FF,F8,6802, 001C,FC,2807, 0014,FC,2814, 000E,FD,2815, 000E,F5,2816
$92:A8D4             dx 0004, 01DC,FB,E804, 01E4,FB,E805, C3EB,FA,E800, C3F0,F8,E802
$92:A8EA             dx 0004, 01DD,01,E804, 01E5,01,E805, C3EC,FC,E800, C3F1,FA,E802
$92:A900             dx 0003, C3E0,FF,E800, C3EC,FD,E802, C3F1,FB,E804
$92:A911             dx 0003, C3EE,01,E800, C3E2,03,E802, C3F1,FE,E804
$92:A922             dx 0003, C3E4,0B,E800, C3EE,01,E802, C3F1,FE,E804
$92:A933             dx 0003, C3E7,0B,E800, C3EF,01,E802, C3F1,FE,E804
$92:A944             dx 0003, C3E9,0D,E800, C3EF,03,E802, C3F2,FF,E804
$92:A955             dx 0004, 01F4,12,E804, 01F4,1A,E805, C3F3,04,E800, C3F5,00,E802
$92:A96B             dx 0004, 01FB,13,E804, 01FB,1B,E805, C3FA,04,E800, C3F8,00,E802
$92:A981             dx 0004, 0000,12,A804, 0000,1A,A805, C3FD,04,E800, C3F9,00,E802
$92:A997             dx 0003, C202,0E,A800, C3FD,03,E802, C3FB,FF,E804
$92:A9A8             dx 0003, C208,0C,A800, C200,01,E802, C3FE,FE,E804
$92:A9B9             dx 0003, C20D,0B,A800, C202,01,E802, C3FE,FE,E804
$92:A9CA             dx 0003, C210,07,A800, C205,FE,E802, C3FF,FD,E804
$92:A9DB             dx 0003, C210,01,A800, C205,FC,E802, C3FF,FD,E804
$92:A9EC             dx 0004, 001B,01,A804, 0013,01,A805, C205,F7,E800, C200,F9,E802
$92:AA02             dx 0004, 001C,FC,A804, 0014,FC,A805, C205,F7,E800, C200,F8,E802
$92:AA18             dx 0008, 01F7,FD,E804, 01F7,05,E805, C3FF,FD,E800, C200,F8,A802, 001C,FC,A806, 0014,FC,A807, 000D,F6,E814, 000D,FE,E815
$92:AA42             dx 0008, 001C,00,A804, 0014,00,A805, 01F7,FE,E806, 01F7,06,E807, C3FF,FE,E800, C200,F9,A802, 000D,F8,E814, 000D,00,E815
$92:AA6C             dx 000A, 01F3,FE,E804, 01F3,06,E805, C3FB,FE,E800, C3FF,FB,A802, 0018,00,A806, 0010,00,A807, 0018,08,A814, 0010,08,A815, 000D,FB,E816, 000D,03,E817
$92:AAA0             dx 000A, 01F3,FF,E804, 01F3,07,E805, C3FB,FF,E800, C3FF,FC,A802, 0018,03,A806, 0010,03,A807, 0018,0B,A814, 0010,0B,A815, 000D,FD,E816, 000D,05,E817
$92:AAD4             dx 0009, 01FB,FA,E804, C3FB,02,E800, C200,FE,A802, 0016,0C,A805, 000E,0C,A806, 0016,14,A807, 000E,14,A814, 0004,0A,E815, 000C,0A,E816
$92:AB03             dx 0009, 01FA,FA,E804, C3FA,02,E800, C3FE,FF,A802, 0002,0B,E805, 000A,0B,E806, 000B,0D,A807, 0013,0D,A814, 0013,15,A815, 000B,15,A816
$92:AB32             dx 0009, 000F,0F,A804, 01FA,FA,E805, C3FA,02,E800, C3FE,FF,A802, 0007,0F,A806, 000F,17,A807, 0007,17,A814, 0002,0C,E815, 000A,0C,E816
$92:AB61             dx 0008, 01F8,F6,E804, 0000,F6,E805, C3F8,FE,E800, C3FA,00,A802, 0000,0D,E806, 0008,0D,E807, 0003,13,A814, 0003,1B,A815
$92:AB8B             dx 0008, 01F9,F5,E804, 0001,F5,E805, C3F9,FD,E800, C3F7,FF,A802, 01FC,14,E806, 01FC,1C,E807, 01FB,0D,E814, 0003,0D,E815
$92:ABB5             dx 0008, 01F9,F7,E804, 0001,F7,E805, C3F9,FF,E800, C3F6,00,A802, 01F6,13,E806, 01F6,1B,E807, 01F5,0D,E814, 01FD,0D,E815
$92:ABDF             dx 0009, 01ED,10,E804, 0007,FC,E805, C3F7,FC,E800, C3F5,00,A802, 01F5,10,E806, 01ED,18,E807, 01F5,18,E814, 01F3,0D,E815, 01FB,0D,E816
$92:AC0E             dx 000A, 01E8,0E,E804, 01F0,0E,E805, 01E8,16,E806, 01F0,16,E807, 0007,FB,E814, 0007,03,E815, C3F7,FB,E800, C3F3,FE,A802, 01F0,0B,E816, 01F8,0B,E817
$92:AC42             dx 000A, 0007,FB,E804, 0007,03,E805, C3F7,FB,E800, C3F3,FE,A802, 01E5,0C,E806, 01ED,0C,E807, 01E5,14,E814, 01ED,14,E815, 01EF,0A,E816, 01F7,0A,E817
$92:AC76             dx 000A, 0004,FC,E804, 0004,04,E805, C3F4,FC,E800, C3F2,FC,A802, 01E2,05,E806, 01EA,05,E807, 01E2,0D,E814, 01EA,0D,E815, 01EE,02,E816, 01EE,0A,E817
$92:ACAA             dx 000A, 0004,FC,E804, 0004,04,E805, C3F4,FC,E800, C3F2,FC,A802, 01E1,01,E806, 01E9,01,E807, 01E1,09,E814, 01E9,09,E815, 01ED,00,E816, 01ED,08,E817
$92:ACDE             dx 0009, C3F2,FD,E800, 0002,FD,E804, 0002,05,E805, 0002,0D,E806, C3F1,F9,A802, 01EA,FE,E807, 01EA,FF,6814, 01DC,01,E815, 01E4,01,E816
$92:AD0D             dx 0009, C3F2,FC,E800, 0002,FC,E804, 0002,04,E805, 0002,0C,E806, C3F1,F8,A802, 01DC,FC,E807, 01E4,FC,E814, 01EA,FB,E815, 01EA,03,E816
$92:AD3C             dx 0002, C3F8,10,2808, C3F8,00,280A
$92:AD48             dx 0005, C3F3,07,2808, C3FB,FF,280A, 01EB,0F,280C, 01F3,17,280D, 0003,0F,280E
$92:AD63             dx 0004, C3F0,FF,2808, C200,0F,280A, C3F8,FF,280C, 0008,07,280E
$92:AD79             dx 0002, C3F7,10,2808, C3F7,00,280A
$92:AD85             dx 0006, C3F3,07,2808, C3FB,FF,280A, 01F3,FF,280C, 01EB,0F,280D, 01F3,17,280E, 0003,0F,280F
$92:ADA5             dx 0004, C3EF,FF,2808, C3FF,0F,280A, C3F7,FF,280C, 01F7,0F,280E
$92:ADBB             dx 0003, C3F1,10,2808, C3F9,10,280A, C3F9,00,280C
$92:ADCC             dx 0002, C3EF,00,2808, C3F7,00,280A
$92:ADD8             dx 0004, C3FB,00,2808, C3F3,10,280A, 01F3,08,280C, 0003,10,280D
$92:ADEE             dx 0006, C3FF,06,2808, C3F7,FE,280A, 000F,0F,280C, 01EF,0E,280D, 01EF,06,280E, 0007,16,280F
$92:AE0E             dx 0004, 01FB,18,280C, C3FB,00,2808, C3F3,08,280A, 01F3,18,280D
$92:AE24             dx 0006, C3FE,06,2808, C3F6,FE,280A, 000E,0F,280C, 0006,16,280D, 01EE,0E,280E, 01EE,06,280F
$92:AE44             dx 0008, 01F0,08,280C, 01F0,00,280D, 01F4,18,280E, 01F4,10,280F, 01F4,08,281C, 01F4,00,281D, C3FC,10,2808, C3FC,00,280A
$92:AE6E             dx 0008, 01F0,08,280C, 01F0,00,280D, 01F4,18,280E, 01F4,10,280F, 01F4,08,281C, 01F4,00,281D, C3FC,10,2808, C3FC,00,280A
$92:AE98             dx 0003, C3F1,10,2808, C3F9,10,280A, C3F9,00,280C
$92:AEA9             dx 0003, C3F1,10,2808, C3F9,10,280A, C3F9,00,280C
$92:AEBA             dx 0003, C3FF,10,6808, C3F7,10,680A, C3F7,00,680C
$92:AECB             dx 0004, 01FB,0F,280A, 01F3,0F,280B, 01EB,0F,280C, C3F3,FF,2808
$92:AEE1             dx 0004, 01FD,0F,780A, 0005,0F,680B, 000D,0F,680C, C3FD,FF,6808
$92:AEF7             dx 0003, C3FE,08,2808, C3F6,00,280A, 0006,00,280C
$92:AF08             dx 0003, C3F2,08,6808, C3FA,00,680A, 01F2,00,680C
$92:AF19             dx 0003, 01F6,10,680C, C3FE,10,6808, C3F6,00,680A
$92:AF2A             dx 0003, 0002,10,280C, C3F2,10,2808, C3FA,00,280A
$92:AF3B             dx 0003, 01F1,08,280A, 01F1,00,280B, C3F9,00,2808
$92:AF4C             dx 0003, 0007,08,680A, 0007,00,680B, C3F7,00,6808
$92:AF5D             dx 0002, C3EC,00,2808, C3F4,00,280A
$92:AF69             dx 0002, C204,00,2808, C3FC,00,280A
$92:AF75             dx 0004, 01E8,10,680C, 01E8,08,680D, C3F0,00,6808, C200,00,680A
$92:AF8B             dx 0004, 0010,10,280C, 0010,08,280D, C200,00,2808, C3F0,00,280A
$92:AFA1             dx 0003, C3FF,10,6808, C3F7,10,680A, C3F7,00,680C
$92:AFB2             dx 0002, C3F4,00,2808, C3FC,00,280A
$92:AFBE             dx 0002, C3FC,00,2808, C3F4,00,280A
$92:AFCA             dx 0004, 01F0,18,680C, 01F0,10,680D, C3F8,10,6808, C3F8,00,680A
$92:AFE0             dx 0002, C3F8,00,2808, C3F8,10,280A
$92:AFEC             dx 0001, C3F9,00,2808
$92:AFF3             dx 0004, 01F2,18,280C, 01F2,10,280D, C3FA,10,2808, C3FA,00,280A
$92:B009             dx 0002, C3FA,0F,6808, C3FA,FF,680A
$92:B015             dx 0002, C3FA,0F,6808, C3FA,FF,680A
$92:B021             dx 0004, 01F2,15,280C, 01F2,0D,280D, C3FA,0D,2808, C3FA,FD,280A
$92:B037             dx 0004, 0006,15,680C, 0006,0D,680D, C3F6,0D,6808, C3F6,FD,680A
$92:B04D             dx 0006, 0008,10,280A, 0008,08,280B, 0000,10,280C, 01F8,10,280D, 0008,00,280E, C3F8,00,2808
$92:B06D             dx 0006, 01F0,10,680A, 01F0,08,680B, 01F8,10,680C, 0000,10,680D, 01F0,00,680E, C3F8,00,6808
$92:B08D             dx 0003, 0009,02,680C, C3F9,08,6808, C3F9,00,680A
$92:B09E             dx 0003, 01EF,02,280C, C3F7,08,2808, C3F7,00,280A
$92:B0AF             dx 0002, C3FC,10,6808, C3FC,00,680A
$92:B0BB             dx 0002, C3F4,10,2808, C3F4,00,280A
$92:B0C7             dx 0005, 0004,0F,280A, 01F4,10,280B, 01FC,17,280C, 01FC,0F,280D, C3FC,FF,2808
$92:B0E2             dx 0005, 01F4,0F,680A, 0004,10,680B, 01FC,17,680C, 01FC,0F,680D, C3F4,FF,6808
$92:B0FD             dx 0001, 01F8,F8,2C08
$92:B104             dx 0006, 01FA,10,680A, 0002,10,680B, 01F2,10,680C, 01F2,08,680D, 01F2,00,680E, C3FA,00,6808
$92:B124             dx 0006, 01FE,10,280A, 01F6,10,280B, 0006,10,280C, 0006,08,280D, 0006,00,280E, C3F6,00,2808
$92:B144             dx 0007, 000C,01,280A, 0004,02,280B, 01FC,10,280C, 01F4,10,280D, 01F4,08,280E, 000C,00,280F, C3FC,00,2808
$92:B169             dx 0005, 01FC,10,680A, 0004,10,680B, 0004,08,680C, 01EC,00,680D, C3F4,00,6808
$92:B184             dx 0003, C3F8,0F,2808, 0008,0F,280C, C3F8,FF,280A
$92:B195             dx 0003, C3F8,0F,2808, 0008,0F,280C, C3F8,FF,280A
$92:B1A6             dx 0003, C3F8,0F,6808, 01F0,0F,680C, C3F8,FF,680A
$92:B1B7             dx 0003, C3F8,0F,6808, 01F0,0F,680C, C3F8,FF,680A
$92:B1C8             dx 0005, 01F6,10,680C, 01F6,08,680D, 01F6,00,680E, C3FE,08,6808, C3FE,00,680A
$92:B1E3             dx 0005, 0002,10,280C, 0002,08,280D, 0002,00,280E, C3F2,08,2808, C3F2,00,280A
$92:B1FE             dx 0004, C3FD,08,6808, 01F8,18,680C, 01F5,10,680D, C3FD,00,680A
$92:B214             dx 0004, C3F3,08,2808, 0000,18,280C, 0003,10,280D, C3F3,00,280A
$92:B22A             dx 0002, C3FA,10,6808, C3FA,00,680A
$92:B236             dx 0002, 0004,08,280A, C3F4,00,2808
$92:B242             dx 0002, 01F4,08,680A, C3FC,00,6808
$92:B24E             dx 0006, C3F1,08,7808, C200,08,3808, C3F0,F8,380A, C200,F8,380C, C3F1,E8,780E, C200,E8,380E
$92:B26E             dx 0006, C3F1,08,7808, C3F1,E8,780A, C3F0,F8,380C, C200,08,3808, C200,F8,380E, C200,E8,380A
$92:B28E             dx 0001, 01F8,F8,3008
$92:B295             dx 0004, 01F1,18,280C, 01F1,10,280D, C3F9,10,2808, C3F9,00,280A
$92:B2AB             dx 0004, 0007,18,680C, 0007,10,680D, C3F7,10,6808, C3F7,00,680A
$92:B2C1             dx 0002, C3F8,10,6808, C3F8,00,680A
$92:B2CD             dx 0005, C3FD,07,6808, C3F5,FF,680A, 000D,0F,680C, 0005,17,680D, 01F5,0F,680E
$92:B2E8             dx 0004, C200,FF,6808, C3F0,0F,680A, C3F8,FF,680C, 01F0,07,680E
$92:B2FE             dx 0002, C3F9,10,6808, C3F9,00,680A
$92:B30A             dx 0006, C3FD,07,6808, C3F5,FF,680A, 0005,FF,680C, 000D,0F,680D, 0005,17,680E, 01F5,0F,680F
$92:B32A             dx 0004, C201,FF,6808, C3F1,0F,680A, C3F9,FF,680C, 0001,0F,680E
$92:B340             dx 0003, C3FF,10,6808, C3F7,10,680A, C3F7,00,680C
$92:B351             dx 0002, C201,00,6808, C3F9,00,680A
$92:B35D             dx 0004, C3F5,00,6808, C3FD,10,680A, 0005,08,680C, 01F5,10,680D
$92:B373             dx 0006, C3F1,06,6808, C3F9,FE,680A, 01E9,0F,680C, 0009,0E,680D, 0009,06,680E, 01F1,16,680F
$92:B393             dx 0004, 01FD,18,680C, C3F5,00,6808, C3FD,08,680A, 0005,18,680D
$92:B3A9             dx 0006, C3F2,06,6808, C3FA,FE,680A, 01EA,0F,680C, 01F2,16,680D, 000A,0E,680E, 000A,06,680F
$92:B3C9             dx 0004, 0008,18,280C, 0008,10,280D, C3F8,10,2808, C3F8,00,280A
$92:B3DF             dx 0001, 01F8,F8,3C08
$92:B3E6             dx 0001, 01F8,F8,3C08
$92:B3ED             dx 0004, 0006,18,680C, 0006,10,680D, C3F6,10,6808, C3F6,00,680A
$92:B403             dx 0002, C3F6,0F,2808, C3F6,FF,280A
$92:B40F             dx 0002, C3F6,0F,2808, C3F6,FF,280A
$92:B41B             dx 0003, 01E8,04,280A, 01E8,FC,280B, C3F0,FC,2808
$92:B42C             dx 0006, 01E9,0D,280A, 01E9,05,280B, 01E9,FD,280C, 01F9,0D,280D, 01F1,0D,280E, C3F1,FD,2808
$92:B44C             dx 0003, C3E9,07,2808, 01E9,FF,280C, C3F1,FF,280A
$92:B45D             dx 0004, 01F8,10,280A, 01F0,10,280B, 01F0,08,280C, C3F8,00,2808
$92:B473             dx 0005, 0003,10,280A, 01FB,10,280B, 01F3,10,280C, 01F3,08,280D, C3FB,00,2808
$92:B48E             dx 0005, 01F5,08,280A, 0005,10,280B, 01FD,10,280C, 01F5,10,280D, C3FD,00,2808
$92:B4A9             dx 0003, 0005,10,280A, 01FD,10,280B, C3FD,00,2808
$92:B4BA             dx 0004, 000F,0F,280A, 0007,0F,280B, 01FF,FF,280C, C207,FF,2808
$92:B4D0             dx 0004, 0007,0B,280A, 000F,0B,280B, 000F,03,280C, C3FF,FB,2808
$92:B4E6             dx 0005, 0008,08,280A, 0010,F8,280B, 0010,08,280C, 0010,00,280D, C200,F8,2808
$92:B501             dx 0003, 0010,08,200C, C210,F8,2808, C200,F8,280A
$92:B512             dx 0002, C3F8,10,2808, C3F8,00,280A
$92:B51E             dx 0002, C3F8,10,2808, C3F8,00,280A
$92:B52A             dx 0002, C3F0,F9,2808, C3E0,F9,280A
$92:B536             dx 0004, 01E1,0F,280A, 01E1,07,280B, 01F9,FF,280C, C3E9,FF,2808
$92:B54C             dx 0002, C3E9,07,2808, C3F1,FF,280A
$92:B558             dx 0002, C3EB,0F,2808, C3F3,FF,280A
$92:B564             dx 0004, 01F3,07,280A, C3F3,0F,2808, 01FB,07,280B, 01FB,FF,280C
$92:B57A             dx 0002, C3F9,10,2808, C3F9,00,280A
$92:B586             dx 0002, C3FD,0E,2808, C3FD,FE,280A
$92:B592             dx 0002, C207,0F,2808, C3FF,FF,280A
$92:B59E             dx 0004, 0018,10,280C, 0018,08,280D, C208,08,2808, C200,00,280A
$92:B5B4             dx 0002, C20F,04,2808, C3FF,FC,280A
$92:B5C0             dx 0002, C200,F8,E808, C210,F8,E80A
$92:B5CC             dx 0003, 0010,F4,E80A, 0010,FC,E80B, C200,F4,E808
$92:B5DD             dx 0006, 000F,EB,E80A, 000F,F3,E80B, 000F,FB,E80C, 01FF,EB,E80D, 0007,EB,E80E, C3FF,F3,E808
$92:B5FD             dx 0003, C207,E9,E808, 000F,F9,E80C, C3FF,F1,E80A
$92:B60E             dx 0004, 0000,E8,E80A, 0008,E8,E80B, 0008,F0,E80C, C3F8,F0,E808
$92:B624             dx 0005, 01F5,E8,E80A, 01FD,E8,E80B, 0005,E8,E80C, 0005,F0,E80D, C3F5,F0,E808
$92:B63F             dx 0005, 0003,F0,E80A, 01F3,E8,E80B, 01FB,E8,E80C, 0003,E8,E80D, C3F3,F0,E808
$92:B65A             dx 0003, 01F3,E8,E80A, 01FB,E8,E80B, C3F3,F0,E808
$92:B66B             dx 0004, 01E9,E9,E80A, 01F1,E9,E80B, 01F9,F9,E80C, C3E9,F1,E808
$92:B681             dx 0004, 01F1,ED,E80A, 01E9,ED,E80B, 01E9,F5,E80C, C3F1,F5,E808
$92:B697             dx 0005, 01F0,F0,E80A, 01E8,00,E80B, 01E8,F0,E80C, 01E8,F8,E80D, C3F0,F8,E808
$92:B6B2             dx 0003, 01E8,F0,E80C, C3E0,F8,E808, C3F0,F8,E80A
$92:B6C3             dx 0002, C3F8,E0,E808, C3F8,F0,E80A
$92:B6CF             dx 0002, C3F8,E0,E808, C3F8,F0,E80A
$92:B6DB             dx 0002, C200,F7,E808, C210,F7,E80A
$92:B6E7             dx 0004, 0017,E9,E80A, 0017,F1,E80B, 01FF,F9,E80C, C207,F1,E808
$92:B6FD             dx 0002, C207,E9,E808, C3FF,F1,E80A
$92:B709             dx 0002, C205,E1,E808, C3FD,F1,E80A
$92:B715             dx 0004, 0005,F1,E80A, C3FD,E1,E808, 01FD,F1,E80B, 01FD,F9,E80C
$92:B72B             dx 0002, C3F7,E0,E808, C3F7,F0,E80A
$92:B737             dx 0002, C3F3,E2,E808, C3F3,F2,E80A
$92:B743             dx 0002, C3E9,E1,E808, C3F1,F1,E80A
$92:B74F             dx 0002, C3E1,EC,E808, C3F1,F4,E80A
$92:B75B             dx 0002, C3F0,F8,2808, C3E0,F8,280A
$92:B767             dx 0003, 0010,04,680A, 0010,FC,680B, C200,FC,6808
$92:B778             dx 0006, 000F,0D,680A, 000F,05,680B, 000F,FD,680C, 01FF,0D,680D, 0007,0D,680E, C3FF,FD,6808
$92:B798             dx 0003, C207,07,6808, 000F,FF,680C, C3FF,FF,680A
$92:B7A9             dx 0004, 0000,10,680A, 0008,10,680B, 0008,08,680C, C3F8,00,6808
$92:B7BF             dx 0005, 01F5,10,680A, 01FD,10,680B, 0005,10,680C, 0005,08,680D, C3F5,00,6808
$92:B7DA             dx 0005, 0003,08,680A, 01F3,10,680B, 01FB,10,680C, 0003,10,680D, C3F3,00,6808
$92:B7F5             dx 0003, 01F3,10,680A, 01FB,10,680B, C3F3,00,6808
$92:B806             dx 0004, 01E9,0F,680A, 01F1,0F,680B, 01F9,FF,680C, C3E9,FF,6808
$92:B81C             dx 0004, 01F1,0B,680A, 01E9,0B,680B, 01E9,03,680C, C3F1,FB,6808
$92:B832             dx 0005, 01F0,08,680A, 01E8,F8,680B, 01E8,08,680C, 01E8,00,680D, C3F0,F8,6808
$92:B84D             dx 0003, 01E8,08,600C, C3E0,F8,6808, C3F0,F8,680A
$92:B85E             dx 0002, C3F8,10,6808, C3F8,00,680A
$92:B86A             dx 0002, C3F8,10,6808, C3F8,00,680A
$92:B876             dx 0002, C200,F9,6808, C210,F9,680A
$92:B882             dx 0004, 0017,0F,680A, 0017,07,680B, 01FF,FF,680C, C207,FF,6808
$92:B898             dx 0002, C207,07,6808, C3FF,FF,680A
$92:B8A4             dx 0002, C205,0F,6808, C3FD,FF,680A
$92:B8B0             dx 0004, 0005,07,680A, C3FD,0F,6808, 01FD,07,680B, 01FD,FF,680C
$92:B8C6             dx 0002, C3F7,10,6808, C3F7,00,680A
$92:B8D2             dx 0002, C3F3,0E,6808, C3F3,FE,680A
$92:B8DE             dx 0002, C3E9,0F,6808, C3F1,FF,680A
$92:B8EA             dx 0004, 01E0,10,680C, 01E0,08,680D, C3E8,08,6808, C3F0,00,680A
$92:B900             dx 0002, C3E1,04,6808, C3F1,FC,680A
$92:B90C             dx 0002, C3F0,F8,A808, C3E0,F8,A80A
$92:B918             dx 0003, 01E8,F4,A80A, 01E8,FC,A80B, C3F0,F4,A808
$92:B929             dx 0006, 01E9,EB,A80A, 01E9,F3,A80B, 01E9,FB,A80C, 01F9,EB,A80D, 01F1,EB,A80E, C3F1,F3,A808
$92:B949             dx 0003, C3E9,E9,A808, 01E9,F9,A80C, C3F1,F1,A80A
$92:B95A             dx 0004, 01F8,E8,A80A, 01F0,E8,A80B, 01F0,F0,A80C, C3F8,F0,A808
$92:B970             dx 0005, 0003,E8,A80A, 01FB,E8,A80B, 01F3,E8,A80C, 01F3,F0,A80D, C3FB,F0,A808
$92:B98B             dx 0005, 01F5,F0,A80A, 0005,E8,A80B, 01FD,E8,A80C, 01F5,E8,A80D, C3FD,F0,A808
$92:B9A6             dx 0003, 0005,E8,A80A, 01FD,E8,A80B, C3FD,F0,A808
$92:B9B7             dx 0004, 000F,E9,A80A, 0007,E9,A80B, 01FF,F9,A80C, C207,F1,A808
$92:B9CD             dx 0004, 0007,ED,A80A, 000F,ED,A80B, 000F,F5,A80C, C3FF,F5,A808
$92:B9E3             dx 0005, 0008,F0,A80A, 0010,00,A80B, 0010,F0,A80C, 0010,F8,A80D, C200,F8,A808
$92:B9FE             dx 0003, 0010,F0,A80C, C210,F8,A808, C200,F8,A80A
$92:BA0F             dx 0002, C3F8,E0,A808, C3F8,F0,A80A
$92:BA1B             dx 0002, C3F8,E0,A808, C3F8,F0,A80A
$92:BA27             dx 0002, C3F0,F7,A808, C3E0,F7,A80A
$92:BA33             dx 0004, 01E1,E9,A80A, 01E1,F1,A80B, 01F9,F9,A80C, C3E9,F1,A808
$92:BA49             dx 0002, C3E9,E9,A808, C3F1,F1,A80A
$92:BA55             dx 0002, C3EB,E1,A808, C3F3,F1,A80A
$92:BA61             dx 0004, 01F3,F1,A80A, C3F3,E1,A808, 01FB,F1,A80B, 01FB,F9,A80C
$92:BA77             dx 0002, C3F9,E0,A808, C3F9,F0,A80A
$92:BA83             dx 0002, C3FD,E2,A808, C3FD,F2,A80A
$92:BA8F             dx 0002, C207,E1,A808, C3FF,F1,A80A
$92:BA9B             dx 0002, C20F,EC,A808, C3FF,F4,A80A
$92:BAA7             dx 0002, C200,F8,6808, C210,F8,680A
$92:BAB3             dx 0002, 01F8,F8,2802, C3F8,F8,2800
$92:BABF             dx 0002, 01F8,F8,2802, C3F8,F8,6800
$92:BACB             dx 0002, 01F8,F8,2802, C3F8,F8,E800
$92:BAD7             dx 0002, 01F8,F8,2802, C3F8,F8,A800
$92:BAE3             dx 0005, 01F8,F8,2800, 0000,FF,2801, 01F8,FF,2802, 0000,F7,2803, 01F8,F7,2804
$92:BAFE             dx 0002, 01F8,F8,2802, C3F8,F9,2800
$92:BB0A             dx 0002, 01F8,F8,2802, C3F8,F7,A800
$92:BB16             dx 0002, 01F8,F8,2802, C3F8,F9,6800
$92:BB22             dx 0002, C3F8,00,2800, C3F8,F0,2802
$92:BB2E             dx 0004, C200,F1,2800, C3F0,01,2802, C200,01,2804, C3F0,F1,2806
$92:BB44             dx 0002, C200,F8,2800, C3F0,F8,2802
$92:BB50             dx 0004, C201,01,E800, C3F1,F1,E802, C3F1,01,E804, C201,F1,E806
$92:BB66             dx 0002, C3F8,F0,E800, C3F8,00,E802
$92:BB72             dx 0004, C3F1,FF,E800, C201,EF,E802, C201,FF,E804, C3F1,EF,E806
$92:BB88             dx 0002, C3F0,F8,E800, C200,F8,E802
$92:BB94             dx 0004, C3EF,EE,2800, C3FF,FE,2802, C3EF,FE,2804, C3FF,EE,2806
$92:BBAA             dx 000A, 01F8,0A,2800, 01F0,0A,2801, 000A,00,2802, 01EE,00,2803, 000A,F6,2804, 01EE,F8,2805, 000A,EE,2806, 0000,EE,2807, 01F8,EE,2810, 01EE,F0,2811
$92:BBDE             dx 000B, 0000,08,2800, 01F8,08,2801, 01F0,08,2802, 0008,00,2803, 01F0,00,2804, 0008,F8,2805, 01F0,F6,2806, 0008,F0,2807, 0000,F0,2810, 01F8,EE,2811, 01F0,EE,2812
$92:BC17             dx 000B, 000A,08,2800, 0002,08,2801, 01F8,08,2802, 01F0,08,2803, 000A,00,2804, 01EE,00,2805, 000A,F6,2806, 01EE,F8,2807, 000A,EE,2810, 01F8,EE,2811, 01F0,EE,2812
$92:BC50             dx 0008, 0008,08,2800, 0000,08,2801, 01F8,08,2802, 01F0,08,2803, 0008,00,2804, 0008,F0,2805, 0000,F0,2806, 01F0,F0,2807
$92:BC7A             dx 0001, 01F8,F8,1000
$92:BC81             dx 0001, 01F8,F8,3800
$92:BC88             dx 0002, 0007,FC,2802, C3F7,F9,2800
$92:BC94             dx 0002, 01FD,07,2802, C3F8,F7,2800
$92:BCA0             dx 0003, 0000,05,2802, 01F8,05,2803, C3F8,F5,2800
$92:BCB1             dx 0005, 0000,0A,2802, 01F8,0A,2803, 0000,02,2804, 01F8,02,2805, C3F8,F2,2800
$92:BCCC             dx 0003, 01F8,05,6802, 0000,05,6803, C3F8,F5,6800
$92:BCDD             dx 0005, 01F8,0A,6802, 0000,0A,6803, 01F8,02,6804, 0000,02,6805, C3F8,F2,6800
$92:BCF8             dx 0002, 01F8,F8,6802, C3F8,F8,6800
$92:BD04             dx 0002, 01F8,F8,6802, C3F8,F8,2800
$92:BD10             dx 0002, 01F8,F8,6802, C3F8,F8,A800
$92:BD1C             dx 0002, 01F8,F8,6802, C3F8,F8,E800
$92:BD28             dx 0005, 01F8,F8,6800, 01F8,FF,6801, 0000,FF,6802, 01F8,F7,6803, 0000,F7,6804
$92:BD43             dx 0002, 01F8,F8,6802, C3F8,F9,6800
$92:BD4F             dx 0002, 01F8,F8,6802, C3F8,F7,E800
$92:BD5B             dx 0002, 01F8,F8,6802, C3F8,F9,2800
$92:BD67             dx 0002, C3F8,00,6800, C3F8,F0,6802
$92:BD73             dx 0004, C3F0,F1,6800, C200,01,6802, C3F0,01,6804, C200,F1,6806
$92:BD89             dx 0002, C3F0,F8,6800, C200,F8,6802
$92:BD95             dx 0004, C3EF,01,A800, C3FF,F1,A802, C3FF,01,A804, C3EF,F1,A806
$92:BDAB             dx 0002, C3F8,F0,A800, C3F8,00,A802
$92:BDB7             dx 0004, C3FF,FF,A800, C3EF,EF,A802, C3EF,FF,A804, C3FF,EF,A806
$92:BDCD             dx 0002, C200,F8,A800, C3F0,F8,A802
$92:BDD9             dx 0004, C201,EE,6800, C3F1,FE,6802, C201,FE,6804, C3F1,EE,6806
$92:BDEF             dx 000A, 0000,0A,6800, 0008,0A,6801, 01EE,00,6802, 000A,00,6803, 01EE,F6,6804, 000A,F8,6805, 01EE,EE,6806, 01F8,EE,6807, 0000,EE,6810, 000A,F0,6811
$92:BE23             dx 000B, 01F8,08,6800, 0000,08,6801, 0008,08,6802, 01F0,00,6803, 0008,00,6804, 01F0,F8,6805, 0008,F6,6806, 01F0,F0,6807, 01F8,F0,6810, 0000,EE,6811, 0008,EE,6812
$92:BE5C             dx 000B, 01EE,08,6800, 01F6,08,6801, 0000,08,6802, 0008,08,6803, 01EE,00,6804, 000A,00,6805, 01EE,F6,6806, 000A,F8,6807, 01EE,EE,6810, 0000,EE,6811, 0008,EE,6812
$92:BE95             dx 0008, 01F0,08,6800, 01F8,08,6801, 0000,08,6802, 0008,08,6803, 01F0,00,6804, 01F0,F0,6805, 01F8,F0,6806, 0008,F0,6807
$92:BEBF             dx 0001, 01F8,F8,3000
$92:BEC6             dx 0002, C200,00,E808, C3F0,F0,2808
$92:BED2             dx 0004, C3F0,F0,2808, C200,F0,680A, C200,00,E808, C3F0,00,A80A
$92:BEE8             dx 0002, C3F0,00,E808, C200,F0,2808
$92:BEF4             dx 0004, C200,00,6808, C3F0,F0,A808, C3F0,00,A80A, C200,F0,680A
$92:BF0A             dx 0002, C200,00,E808, C3F0,F0,2808
$92:BF16             dx 0004, C200,F0,6808, C3F0,00,A808, C3F0,F0,280A, C200,00,E80A
$92:BF2C             dx 0002, C3F0,00,E808, C200,F0,2808
$92:BF38             dx 0004, C3F0,00,A808, C200,F0,6808, C200,00,680A, C3F0,F0,A80A
$92:BF4E             dx 0004, C200,00,E808, C3F0,F0,2808, C3F0,00,A808, C200,F0,6808
$92:BF64             dx 0004, C3F0,00,A808, C200,F0,6808, C200,00,E80A, C3F0,F0,280A
$92:BF7A             dx 0004, C3F0,00,A808, C200,F0,6808, C200,00,E808, C3F0,F0,2808
$92:BF90             dx 0004, C200,00,E808, C3F0,F0,2808, C200,F0,680A, C3F0,00,A80A
$92:BFA6             dx 0004, C200,00,E808, C3F0,F0,2808, C200,F0,6808, C3F0,00,A808
$92:BFBC             dx 0004, C200,F0,6808, C3F0,00,A808, C200,00,E80A, C3F0,F0,280A
$92:BFD2             dx 0004, C3F0,00,A808, C200,F0,6808, C3F0,F0,2808, C200,00,E808
$92:BFE8             dx 0004, C200,00,E808, C3F0,F0,2808, C200,F0,680A, C3F0,00,A80A
$92:BFFE             dx 0004, C3F0,F0,2808, C200,00,E808, C3F0,00,A80A, C200,F0,680A
$92:C014             dx 0002, C3F0,00,A808, C200,F0,6808
$92:C020             dx 0004, C200,F0,6808, C3F0,F0,280A, C3F0,00,A808, C200,00,E80A
$92:C036             dx 0002, C200,00,A808, C3F0,F0,6808
$92:C042             dx 0004, C3F0,00,2808, C200,F0,E808, C200,00,E80A, C3F0,F0,280A
$92:C058             dx 0002, C3F0,00,A808, C200,F0,6808
$92:C064             dx 0004, C3F0,F0,2808, C200,00,E808, C200,F0,680A, C3F0,00,A80A
$92:C07A             dx 0002, C200,00,A808, C3F0,F0,6808
$92:C086             dx 0004, C200,00,E808, C3F0,F0,2808, C3F0,00,280A, C200,F0,E80A
$92:C09C             dx 0004, C3F0,00,A808, C200,F0,6808, C200,00,E808, C3F0,F0,2808
$92:C0B2             dx 0004, C200,00,E808, C3F0,F0,2808, C3F0,00,A80A, C200,F0,680A
$92:C0C8             dx 0004, C200,00,E808, C3F0,F0,2808, C3F0,00,A808, C200,F0,6808
$92:C0DE             dx 0004, C3F0,00,A808, C200,F0,6808, C3F0,F0,280A, C200,00,E80A
$92:C0F4             dx 0004, C3F0,00,A808, C200,F0,6808, C3F0,F0,2808, C200,00,E808
$92:C10A             dx 0004, C3F0,F0,2808, C200,00,E808, C3F0,00,A80A, C200,F0,680A
$92:C120             dx 0004, C200,00,E808, C3F0,F0,2808, C200,F0,6808, C3F0,00,A808
$92:C136             dx 0004, C3F0,00,A808, C200,F0,6808, C3F0,F0,280A, C200,00,E80A
$92:C14C             dx 0004, C3F0,F0,2808, C200,00,E808, C3F0,00,A80A, C200,F0,680A
$92:C162             dx 0005, 0000,F8,2806, 01F8,F8,2807, C3F8,08,6800, C3F8,F8,6802, C3F8,E8,2804
$92:C17D             dx 0005, 0000,F8,2806, 01F8,F8,2807, C3F8,08,2800, C3F8,F8,2802, C3F8,E8,2804
$92:C198             dx 0007, C3F8,EC,2C00, 0000,0C,2C02, 01F8,0C,2C03, 0000,04,2C04, 01F8,04,2C05, 0000,FC,2C06, 01F8,FC,2C07
$92:C1BD             dx 0007, C3F8,EB,2C00, 0000,0B,2C02, 01F8,0B,2C03, 0000,03,2C04, 01F8,03,2C05, 0000,FB,2C06, 01F8,FB,2C07
$92:C1E2             dx 0007, C3F8,EA,2C00, 0000,0A,2C02, 01F8,0A,2C03, 0000,02,2C04, 01F8,02,2C05, 0000,FA,2C06, 01F8,FA,2C07
$92:C207             dx 0007, C3F8,EC,6C00, 01F8,0C,6C02, 0000,0C,6C03, 01F8,04,6C04, 0000,04,6C05, 01F8,FC,6C06, 0000,FC,6C07
$92:C22C             dx 0007, C3F8,EB,6C00, 01F8,0B,6C02, 0000,0B,6C03, 01F8,03,6C04, 0000,03,6C05, 01F8,FB,6C06, 0000,FB,6C07
$92:C251             dx 0007, C3F8,EA,6C00, 01F8,0A,6C02, 0000,0A,6C03, 01F8,02,6C04, 0000,02,6C05, 01F8,FA,6C06, 0000,FA,6C07
$92:C276             dx 0004, C200,00,FC08, C3F0,00,BC08, C200,F0,7C08, C3F0,F0,3C08
$92:C28C             dx 0010, C200,00,FC08, C210,00,FC0A, C200,10,FC0C, C210,10,FC0E, C3F0,00,BC08, C3E0,00,BC0A, C3F0,10,BC0C, C3E0,10,BC0E, C200,F0,7C08, C210,F0,7C0A, C200,E0,7C0C, C210,E0,7C0E, C3E0,E0,3C0E, C3E0,F0,3C0A, C3F0,E0,3C0C, C3F0,F0,3C08
$92:C2DE             dx 0010, C200,00,FC08, C210,00,FC0A, C200,10,FC0C, C210,10,FC0E, C3F0,00,BC08, C3E0,00,BC0A, C3F0,10,BC0C, C3E0,10,BC0E, C200,F0,7C08, C210,F0,7C0A, C200,E0,7C0C, C210,E0,7C0E, C3F0,F0,3C08, C3E0,F0,3C0A, C3F0,E0,3C0C, C3E0,E0,3C0E
$92:C330             dx 0004, C200,F0,2808, C3F0,00,280A, C3F8,00,280C, C3F8,F0,280E
$92:C346             dx 000A, C201,04,2808, C3F1,F4,280A, 01F9,0C,280C, 01F1,EC,280D, 0001,EC,280E, 01F9,EC,280F, 0009,FC,281C, 0001,FC,281D, 0001,F4,281E, 01F9,04,281F
$92:C37A             dx 0004, C200,00,2808, C3F0,F0,280A, C3F0,F8,280C, C200,F8,280E
$92:C390             dx 000A, 01FC,F0,E80C, 01F4,F8,E80D, 01FC,F8,E80E, 0004,00,E80F, 000C,00,E81C, 01EC,F8,E81D, 01EC,00,E81E, 01EC,08,E81F, C3F4,00,E808, C204,F0,E80A
$92:C3C4             dx 0004, C3F0,00,E808, C200,F0,E80A, C3F8,F0,E80C, C3F8,00,E80E
$92:C3DA             dx 000A, 01F0,FC,E80C, 01F8,FC,E80D, 01F8,04,E80E, 0008,0C,E80F, 0000,EC,E81C, 0000,F4,E81D, 01F8,0C,E81E, 0000,0C,E81F, C3F0,EC,E808, C200,FC,E80A
$92:C40E             dx 0004, C3F0,F0,E808, C200,00,E80A, C200,F8,E80C, C3F0,F8,E80E
$92:C424             dx 000A, 01FC,00,280C, 01FC,08,280D, 0004,00,280E, 01F4,F8,280F, 01EC,F8,281C, 000C,00,281D, 000C,F8,281E, 000C,F0,281F, C3FC,F0,2808, C3EC,00,280A
$92:C458             dx 0004, C3F0,F0,6808, C200,00,680A, C3F8,00,680C, C3F8,F0,680E
$92:C46E             dx 000A, C3EF,04,6808, C3FF,F4,680A, 01FF,0C,680C, 0007,EC,680D, 01F7,EC,680E, 01FF,EC,680F, 01EF,FC,681C, 01F7,FC,681D, 01F7,F4,681E, 01FF,04,681F
$92:C4A2             dx 0004, C3F0,00,6808, C200,F0,680A, C200,F8,680C, C3F0,F8,680E
$92:C4B8             dx 000A, 01FC,F0,A80C, 0004,F8,A80D, 01FC,F8,A80E, 01F4,00,A80F, 01EC,00,A81C, 000C,F8,A81D, 000C,00,A81E, 000C,08,A81F, C3FC,00,A808, C3EC,F0,A80A
$92:C4EC             dx 0004, C200,00,A808, C3F0,F0,A80A, C3F8,F0,A80C, C3F8,00,A80E
$92:C502             dx 000A, 0008,FC,A80C, 0000,FC,A80D, 0000,04,A80E, 01F0,0C,A80F, 01F8,EC,A81C, 01F8,F4,A81D, 0000,0C,A81E, 01F8,0C,A81F, C200,EC,A808, C3F0,FC,A80A
$92:C536             dx 0004, C200,F0,A808, C3F0,00,A80A, C3F0,F8,A80C, C200,F8,A80E
$92:C54C             dx 000A, 01FC,00,680C, 01FC,08,680D, 01F4,00,680E, 0004,F8,680F, 000C,F8,681C, 01EC,00,681D, 01EC,F8,681E, 01EC,F0,681F, C3F4,F0,6808, C204,00,680A
$92:C580             dx 0009, 0000,10,2841, 01F8,10,2840, 0008,10,2842, 0008,08,2832, 0008,00,2822, 0008,F8,2812, 0008,F0,2802, C3F8,00,2820, C3F8,F0,2800
$92:C5AF             dx 0016, 01FD,F0,281F, 0003,F6,280F, 01FB,F9,280F, 01F7,F7,285F, 0007,0B,284E, 01FF,0F,285F, 01F7,F2,287F, 01F9,EF,286C, 01F9,EC,282F, 01FD,E9,281F, 0006,F2,2808, 01F9,05,2858, 0002,FD,2838, 0001,06,284B, 01F8,0A,2E43, 01F8,02,2E33, 01F8,FA,2E23, 01F8,F2,2E13, 01F8,EA,2E03, C200,0A,2E44, C200,FA,2E24, C200,EA,2E04
$92:C61F             dx 001A, 0003,E7,281F, 0001,11,284F, 01FF,0A,284E, 01F9,07,2883, 0000,04,2883, 0006,F0,2883, 000C,EB,2808, 0007,07,6858, 01F7,FF,284B, 01F3,F6,2838, 01F3,EE,287F, 01F6,E9,286C, 01FB,E7,282F, 01F8,F1,283F, 01F5,07,2893, 01F8,0E,2873, 0006,0F,2883, 0009,01,284F, 0008,F8,285F, 0008,10,2E68, 0000,10,2E67, 0008,F0,2E28, 0008,E8,2E18, C3F8,E0,2E06, C3F8,00,2E46, C3F8,F0,2E26
$92:C6A3             dx 0018, 000B,DD,283F, 0001,17,284F, 01F7,E0,282F, 01F1,E1,286C, 000F,E6,281F, 01EE,FA,286F, 01ED,F2,284E, 01EE,07,2893, 01F1,10,2873, 000D,10,2883, 000C,02,286F, 0010,FB,284F, 000A,F1,285F, 01ED,E8,287F, 01F3,ED,283F, 0008,FA,2E3B, 0008,F2,2E2B, 0008,12,2E6B, 0000,12,2E6A, 0008,EA,2E1B, 0008,E2,2E0B, C3F8,02,2E49, C3F8,F2,2E29, C3F8,E2,2E09
$92:C71D             dx 0019, 000C,D8,283F, 0003,1E,284F, 01F3,DA,282F, 01E9,DE,286C, 0011,15,2883, 0014,04,286F, 0015,F2,285F, 0012,E1,281F, 01E5,FE,286F, 01E3,EA,287F, 0018,FC,284F, 01F0,14,2873, 01E8,0C,2893, 01E8,F4,284E, 01F0,EC,283F, 0000,14,2E6D, 0008,14,2E6E, 0008,0C,2E5E, 0008,FC,2E3E, 0008,F4,2E2E, 0008,EC,2E1E, 0008,E4,2E0E, C3F8,04,2E4C, C3F8,F4,2E2C, C3F8,E4,2E0C
$92:C79C             dx 0019, 01DD,E1,287F, 01E0,DC,287F, 0003,25,2873, 01EA,D3,282F, 001D,FB,2873, 01DF,FF,6883, 0019,08,286F, 01E2,12,2893, 01EF,19,2873, 0013,19,2883, 0018,F0,285F, 01D9,ED,287F, 01E4,F4,284E, 0018,DC,281F, 01E8,EC,683F, 0000,14,2E74, 0000,0C,2E64, 01F8,0C,2E63, 0008,FC,2E82, 0008,EC,2E62, 0008,E4,2E52, 0000,E4,2E51, 01F8,E4,2E50, C3F8,FC,2E80, C3F8,EC,2E60
$92:C81B             dx 0008, 000E,F4,2E9C, 000E,EC,2E8C, 01FE,14,2E99, C3F6,04,2E78, 01F6,FC,2E94, 01F6,F4,2E84, C3FE,F4,2E85, C3FE,E4,2E65
$92:C845             dx 000B, 01F6,F4,2E98, 0006,FC,2E96, 01FE,FC,2E95, 0006,E4,2E7B, 01FE,E4,2E7A, 000E,F4,2E9C, 000E,EC,2E8C, C3FE,EC,2E8A, 01FE,14,2E99, C3F6,04,2E78, 01F6,FC,2E94
$92:C87E             dx 000B, 01FE,FC,2E95, 0006,FC,2E96, 01F6,F4,2E7C, 0006,E4,2E7E, 01FE,E4,2E7D, 000E,F4,2E9F, 000E,EC,2E8F, C3FE,EC,2E8D, 01FE,14,2E99, C3F6,04,2E78, 01F6,FC,2E94
$92:C8B7             dx 0009, 01F8,10,6841, 0000,10,6840, 01F0,10,6842, 01F0,08,6832, 01F0,00,6822, 01F0,F8,6812, 01F0,F0,6802, C3F8,00,6820, C3F8,F0,6800
$92:C8E6             dx 0016, 01FB,F0,681F, 01F5,F6,680F, 01FD,F9,680F, 0001,F7,685F, 01F1,0B,684E, 01F9,0F,685F, 0001,F2,687F, 01FF,EF,686C, 01FF,EC,682F, 01FB,E9,681F, 01F2,F2,6808, 01FF,05,6858, 01F6,FD,6838, 01F7,06,684B, 0000,0A,6E43, 0000,02,6E33, 0000,FA,6E23, 0000,F2,6E13, 0000,EA,6E03, C3F0,0A,6E44, C3F0,FA,6E24, C3F0,EA,6E04
$92:C956             dx 001A, 01F5,E7,681F, 01F7,11,684F, 01F9,0A,684E, 01FF,07,6883, 01F8,04,6883, 01F2,F0,6883, 01EC,EB,6808, 01F1,07,2858, 0001,FF,684B, 0005,F6,6838, 0005,EE,687F, 0002,E9,686C, 01FD,E7,682F, 0000,F1,683F, 0003,07,6893, 0000,0E,6873, 01F2,0F,6883, 01EF,01,684F, 01F0,F8,685F, 01F0,10,6E68, 01F8,10,6E67, 01F0,F0,6E28, 01F0,E8,6E18, C3F8,E0,6E06, C3F8,00,6E46, C3F8,F0,6E26
$92:C9DA             dx 0018, 01ED,DD,683F, 01F7,17,684F, 0001,E0,682F, 0007,E1,686C, 01E9,E6,681F, 000A,FA,686F, 000B,F2,684E, 000A,07,6893, 0007,10,6873, 01EB,10,6883, 01EC,02,686F, 01E8,FB,684F, 01EE,F1,685F, 000B,E8,687F, 0005,ED,683F, 01F0,FA,6E3B, 01F0,F2,6E2B, 01F0,12,6E6B, 01F8,12,6E6A, 01F0,EA,6E1B, 01F0,E2,6E0B, C3F8,02,6E49, C3F8,F2,6E29, C3F8,E2,6E09
$92:CA54             dx 0019, 01EC,D8,683F, 01F5,1E,684F, 0005,DA,682F, 000F,DE,686C, 01E7,15,6883, 01E4,04,686F, 01E3,F2,685F, 01E6,E1,681F, 0013,FE,686F, 0015,EA,687F, 01E0,FC,684F, 0008,14,6873, 0010,0C,6893, 0010,F4,684E, 0008,EC,683F, 01F8,14,6E6D, 01F0,14,6E6E, 01F0,0C,6E5E, 01F0,FC,6E3E, 01F0,F4,6E2E, 01F0,EC,6E1E, 01F0,E4,6E0E, C3F8,04,6E4C, C3F8,F4,6E2C, C3F8,E4,6E0C
$92:CAD3             dx 0019, 001B,E1,687F, 0018,DC,687F, 01F5,25,6873, 000E,D3,682F, 01DB,FB,6873, 0019,FF,2883, 01DF,08,686F, 0016,12,6893, 0009,19,6873, 01E5,19,6883, 01E0,F0,685F, 001F,ED,687F, 0014,F4,684E, 01E0,DC,681F, 0010,EC,283F, 01F8,14,6E74, 01F8,0C,6E64, 0000,0C,6E63, 01F0,FC,6E82, 01F0,EC,6E62, 01F0,E4,6E52, 01F8,E4,6E51, 0000,E4,6E50, C3F8,FC,6E80, C3F8,EC,6E60
$92:CB52             dx 0008, 01EA,F4,6E9C, 01EA,EC,6E8C, 01FA,14,6E99, C3FA,04,6E78, 0002,FC,6E94, 0002,F4,6E84, C3F2,F4,6E85, C3F2,E4,6E65
$92:CB7C             dx 000B, 0002,F4,6E98, 01F2,FC,6E96, 01FA,FC,6E95, 01F2,E4,6E7B, 01FA,E4,6E7A, 01EA,F4,6E9C, 01EA,EC,6E8C, C3F2,EC,6E8A, 01FA,14,6E99, C3FA,04,6E78, 0002,FC,6E94
$92:CBB5             dx 000B, 01FA,FC,6E95, 01F2,FC,6E96, 0002,F4,6E7C, 01F2,E4,6E7E, 01FA,E4,6E7D, 01EA,F4,6E9F, 01EA,EC,6E8F, C3F2,EC,6E8D, 01FA,14,6E99, C3FA,04,6E78, 0002,FC,6E94
}


;;; $CBEE..D7D2: Samus tiles animation - tiles definitions ;;;
{
; Samus tiles definition format:
;     aaaaaa nnnn NNNN
; where:
;     a: Source address
;     n: Part 1 size, n = 0 means 10000h bytes are transferred
;     N: Part 2 size, N = 0 means no bytes are transferred


;;; $CBEE: Samus top tiles - 0 ;;;
{
; 0: Facing forward - power suit
; 1: Facing right - normal
; 2: Facing left - normal
; 9: Moving right - not aiming
; 19h: Facing right - spin jump
; 1Ah: Facing left - spin jump
; 1Bh: Facing right - space jump
; 1Ch: Facing left - space jump
; 1Dh: Facing right - morph ball - no springball - on ground
; 1Eh: Moving right - morph ball - no springball - on ground
; 1Fh: Moving left - morph ball - no springball - on ground
; 20h: Unused
; 21h: Unused
; 22h: Unused
; 23h: Unused
; 24h: Unused
; 27h: Facing right - crouching
; 28h: Facing left - crouching
; 29h: Facing right - falling
; 2Ah: Facing left - falling
; 31h: Facing right - morph ball - no springball - in air
; 32h: Facing left - morph ball - no springball - in air
; 33h: Unused
; 34h: Unused
; 39h: Unused
; 3Ah: Unused
; 3Fh: Unused
; 40h: Unused
; 41h: Facing left - morph ball - no springball - on ground
; 42h: Unused
; 47h: Unused
; 48h: Unused
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; 67h: Facing right - falling - gun extended
; 68h: Facing left - falling - gun extended
; 79h: Facing right - morph ball - spring ball - on ground
; 7Ah: Facing left - morph ball - spring ball - on ground
; 7Bh: Moving right - morph ball - spring ball - on ground
; 7Ch: Moving left - morph ball - spring ball - on ground
; 7Dh: Facing right - morph ball - spring ball - falling
; 7Eh: Facing left - morph ball - spring ball - falling
; 7Fh: Facing right - morph ball - spring ball - in air
; 80h: Facing left - morph ball - spring ball - in air
; 81h: Facing right - screw attack
; 82h: Facing left - screw attack
; 83h: Facing right - wall jump
; 84h: Facing left - wall jump
; 89h: Facing right - ran into a wall
; 8Ah: Facing left - ran into a wall
; 9Bh: Facing forward - varia/gravity suit
; A8h: Unused
; A9h: Unused
; B4h: Unused
; B5h: Unused
; C5h: Unused
; C7h: Facing right - vertical shinespark windup
; D3h: Facing right - crystal flash
; D4h: Facing left - crystal flash
; DFh: Unused
; E8h: Facing right - Samus drained - crouching
; E9h: Facing left - Samus drained - crouching
; EAh: Facing right - Samus drained - standing
; EBh: Facing left - Samus drained - standing
; F0h: Facing right - grabbed by Draygon - moving
$92:CBEE             dx 9E8000,0080,0080

; 9: Moving right - not aiming
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; C7h: Facing right - vertical shinespark windup
; F0h: Facing right - grabbed by Draygon - moving
$92:CBF5             dx 9E8100,0080,0080

; 9: Moving right - not aiming
; F0h: Facing right - grabbed by Draygon - moving
$92:CBFC             dx 9E8200,00A0,0080

; 9: Moving right - not aiming
$92:CC03             dx 9E8320,00A0,0080

; 9: Moving right - not aiming
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; C7h: Facing right - vertical shinespark windup
; F0h: Facing right - grabbed by Draygon - moving
$92:CC0A             dx 9E8440,0080,0080
$92:CC11             dx 9E8540,00C0,00C0

; Ah: Moving left - not aiming
; 4Eh: Facing left - normal jump - not aiming - not moving - gun not extended
; BEh: Facing left - grabbed by Draygon - moving
; C8h: Facing left - vertical shinespark windup
$92:CC18             dx 9E86C0,0080,0080
$92:CC1F             dx 9E87C0,0080,0080

; Ah: Moving left - not aiming
; BEh: Facing left - grabbed by Draygon - moving
$92:CC26             dx 9E88C0,00C0,00C0

; Ah: Moving left - not aiming
$92:CC2D             dx 9E8A40,00C0,00C0

; Ah: Moving left - not aiming
; 4Eh: Facing left - normal jump - not aiming - not moving - gun not extended
; BEh: Facing left - grabbed by Draygon - moving
; C8h: Facing left - vertical shinespark windup
$92:CC34             dx 9E8BC0,0080,0080
$92:CC3B             dx 9E8CC0,00A0,0080

; 11h: Moving right - aiming down-right
; 17h: Facing right - normal jump - aiming down
; 2Dh: Facing right - falling - aiming down
; 6Bh: Facing right - normal jump - aiming down-right
; 6Fh: Facing right - falling - aiming down-right
; 78h: Facing right - moonwalk - aiming down-right
; AEh: Unused
; B0h: Unused
; EFh: Facing right - grabbed by Draygon - not moving - aiming down-right
$92:CC42             dx 9E8DE0,00E0,0040

; 12h: Moving left - aiming down-left
; 18h: Facing left - normal jump - aiming down
; 2Eh: Facing left - falling - aiming down
; 6Ch: Facing left - normal jump - aiming down-left
; 70h: Facing left - falling - aiming down-left
; 77h: Facing left - moonwalk - aiming down-left
; AFh: Unused
; B1h: Unused
; BDh: Facing left - grabbed by Draygon - not moving - aiming down-left
$92:CC49             dx 9E8F00,00E0,0040

; 7: Facing right - aiming down-right
; 59h: Facing right - normal jump transition - aiming down-right
; 73h: Facing right - crouching - aiming down-right
; AAh: Unused
; B6h: Unused
; D1h: Facing right - ran into a wall - aiming down-right
; E4h: Facing right - landing from normal jump - aiming down-right
; F5h: Facing right - crouching transition - aiming down-right
; FBh: Facing right - standing transition - aiming down-right
$92:CC50             dx 9E9020,00E0,0080

; 8: Facing left - aiming down-left
; 5Ah: Facing left - normal jump transition - aiming down-left
; 74h: Facing left - crouching - aiming down-left
; ABh: Unused
; B7h: Unused
; D2h: Facing left - ran into a wall - aiming down-left
; E5h: Facing left - landing from normal jump - aiming down-left
; F6h: Facing left - crouching transition - aiming down-left
; FCh: Facing left - standing transition - aiming down-left
$92:CC57             dx 9E9180,00E0,0080

; 13h: Facing right - normal jump - not aiming - not moving - gun extended
; 35h: Facing right - crouching transition
; 3Bh: Facing right - standing transition
; 4Ah: Facing right - moonwalk
; 51h: Facing right - normal jump - not aiming - moving forward
; 67h: Facing right - falling - gun extended
; ACh: Unused
; D3h: Facing right - crystal flash
; D5h: Facing right - x-ray - standing
; D7h: Facing right - crystal flash ending
; D9h: Facing right - x-ray - crouching
; DBh: Unused
; DDh: Unused
; E6h: Facing right - landing from normal jump - firing
; E8h: Facing right - Samus drained - crouching
; EAh: Facing right - Samus drained - standing
; EEh: Facing right - grabbed by Draygon - firing
$92:CC5E             dx 9E92E0,00C0,0040

; 14h: Facing left - normal jump - not aiming - not moving - gun extended
; 36h: Facing left - crouching transition
; 3Ch: Facing left - standing transition
; 49h: Facing left - moonwalk
; 52h: Facing left - normal jump - not aiming - moving forward
; 68h: Facing left - falling - gun extended
; ADh: Unused
; BCh: Facing left - grabbed by Draygon - firing
; D4h: Facing left - crystal flash
; D6h: Facing left - x-ray - standing
; D8h: Facing left - crystal flash ending
; DAh: Facing left - x-ray - crouching
; DCh: Unused
; DEh: Unused
; E7h: Facing left - landing from normal jump - firing
; EBh: Facing left - Samus drained - standing
$92:CC65             dx 9E93E0,00C0,0040

; 3: Facing right - aiming up
; 5: Facing right - aiming up-right
; 15h: Facing right - normal jump - aiming up
; 2Bh: Facing right - falling - aiming up
; 57h: Facing right - normal jump transition - aiming up-right
; 71h: Facing right - crouching - aiming up-right
; 85h: Facing right - crouching - aiming up
; CFh: Facing right - ran into a wall - aiming up-right
; E2h: Facing right - landing from normal jump - aiming up-right
; F3h: Facing right - crouching transition - aiming up-right
; F9h: Facing right - standing transition - aiming up-right
$92:CC6C             dx 9E94E0,00C0,0080

; 4: Facing left - aiming up
; 6: Facing left - aiming up-left
; 16h: Facing left - normal jump - aiming up
; 2Ch: Facing left - falling - aiming up
; 58h: Facing left - normal jump transition - aiming up-left
; 72h: Facing left - crouching - aiming up-left
; 86h: Facing left - crouching - aiming up
; D0h: Facing left - ran into a wall - aiming up-left
; E3h: Facing left - landing from normal jump - aiming up-left
; F4h: Facing left - crouching transition - aiming up-left
; FAh: Facing left - standing transition - aiming up-left
$92:CC73             dx 9E9620,00C0,0080

; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; C7h: Facing right - vertical shinespark windup
$92:CC7A             dx 9E9760,00A0,0080

; 4Eh: Facing left - normal jump - not aiming - not moving - gun not extended
; C8h: Facing left - vertical shinespark windup
$92:CC81             dx 9E9880,00C0,00C0

; 3: Facing right - aiming up
; Dh: Moving right - aiming up (unused)
; 15h: Facing right - normal jump - aiming up
; 2Bh: Facing right - falling - aiming up
; 55h: Facing right - normal jump transition - aiming up
; 85h: Facing right - crouching - aiming up
; E0h: Facing right - landing from normal jump - aiming up
; F1h: Facing right - crouching transition - aiming up
; F7h: Facing right - standing transition - aiming up
$92:CC88             dx 9E9A00,00C0,0040

; 4: Facing left - aiming up
; Eh: Moving left - aiming up (unused)
; 16h: Facing left - normal jump - aiming up
; 2Ch: Facing left - falling - aiming up
; 56h: Facing left - normal jump transition - aiming up
; 86h: Facing left - crouching - aiming up
; E1h: Facing left - landing from normal jump - aiming up
; F2h: Facing left - crouching transition - aiming up
; F8h: Facing left - standing transition - aiming up
$92:CC8F             dx 9E9B00,00C0,0040

; 9: Moving right - not aiming
$92:CC96             dx 9E9C00,00A0,0080

; Ah: Moving left - not aiming
$92:CC9D             dx 9E9D20,00A0,0080

; Fh: Moving right - aiming up-right
; 69h: Facing right - normal jump - aiming up-right
; 6Dh: Facing right - falling - aiming up-right
; 76h: Facing right - moonwalk - aiming up-right
; EDh: Facing right - grabbed by Draygon - not moving - aiming up-right
$92:CCA4             dx 9E9E40,00C0,0040

; 10h: Moving left - aiming up-left
; 6Ah: Facing left - normal jump - aiming up-left
; 6Eh: Facing left - falling - aiming up-left
; 75h: Facing left - moonwalk - aiming up-left
; BBh: Facing left - grabbed by Draygon - not moving - aiming up-left
$92:CCAB             dx 9E9F40,00E0,0040

; 54h: Facing left - knockback
; D8h: Facing left - crystal flash ending
; E9h: Facing left - Samus drained - crouching
$92:CCB2             dx 9EA060,0100,00C0

; 53h: Facing right - knockback
; D7h: Facing right - crystal flash ending
; E8h: Facing right - Samus drained - crouching
$92:CCB9             dx 9EA220,0100,00C0

; Unused
$92:CCC0             dx 9EA3E0,0100,0040

; Unused
$92:CCC7             dx 9EA520,0100,0040
}


;;; $CCCE: Samus top tiles - 1 ;;;
{
; Unused
$92:CCCE             dx 9EA660,00C0,0080

; Unused
$92:CCD5             dx 9EA7A0,00C0,0080

; 8Bh: Facing right - turning - standing - aiming up
; 8Ch: Facing left - turning - standing - aiming up
; 8Fh: Facing right - turning - in air - aiming up
; 90h: Facing left - turning - in air - aiming up
; 93h: Facing right - turning - falling - aiming up
; 94h: Facing left - turning - falling - aiming up
; 97h: Facing right - turning - crouching - aiming up
; 98h: Facing left - turning - crouching - aiming up
; 9Ch: Facing right - turning - standing - aiming up-right
; 9Dh: Facing left - turning - standing - aiming up-left
; 9Eh: Facing right - turning - in air - aiming up-right
; 9Fh: Facing left - turning - in air - aiming up-left
; A0h: Facing right - turning - falling - aiming up-right
; A1h: Facing left - turning - falling - aiming up-left
; A2h: Facing right - turning - crouching - aiming up-right
; A3h: Facing left - turning - crouching - aiming up-left
; C1h: Facing right - moonwalking - turn/jump left - aiming up-right
; C2h: Facing left - moonwalking - turn/jump right - aiming up-left
$92:CCDC             dx 9EA8E0,00E0,00C0

; 8Dh: Facing right - turning - standing - aiming down-right
; 8Eh: Facing left - turning - standing - aiming down-left
; 91h: Facing right - turning - in air - aiming down/down-right
; 92h: Facing left - turning - in air - aiming down/down-left
; 95h: Facing right - turning - falling - aiming down/down-right
; 96h: Facing left - turning - falling - aiming down/down-left
; 99h: Facing right - turning - crouching - aiming down/down-right
; 9Ah: Facing left - turning - crouching - aiming down/down-left
; C3h: Facing right - moonwalking - turn/jump left - aiming down-right
; C4h: Facing left - moonwalking - turn/jump right - aiming down-left
$92:CCE3             dx 9EAA80,0100,00C0

; Unused
$92:CCEA             dx 9EAC40,0020,0000

; 9Bh: Facing forward - varia/gravity suit
$92:CCF1             dx 9EAC60,0040,0040

; 25h: Facing right - turning - standing
; 26h: Facing left - turning - standing
; 2Fh: Facing right - turning - jumping
; 30h: Facing left - turning - jumping
; 43h: Facing right - turning - crouching
; 44h: Facing left - turning - crouching
; 87h: Facing right - turning - falling
; 88h: Facing left - turning - falling
; BFh: Facing right - moonwalking - turn/jump left
; C0h: Facing left - moonwalking - turn/jump right
; C6h: Unused
$92:CCF8             dx 9EACE0,00C0,0080
$92:CCFF             dx 9EAE20,00C0,0080

; 8Bh: Facing right - turning - standing - aiming up
; 8Ch: Facing left - turning - standing - aiming up
; 8Fh: Facing right - turning - in air - aiming up
; 90h: Facing left - turning - in air - aiming up
; 93h: Facing right - turning - falling - aiming up
; 94h: Facing left - turning - falling - aiming up
; 97h: Facing right - turning - crouching - aiming up
; 98h: Facing left - turning - crouching - aiming up
; 9Ch: Facing right - turning - standing - aiming up-right
; 9Dh: Facing left - turning - standing - aiming up-left
; 9Eh: Facing right - turning - in air - aiming up-right
; 9Fh: Facing left - turning - in air - aiming up-left
; A0h: Facing right - turning - falling - aiming up-right
; A1h: Facing left - turning - falling - aiming up-left
; A2h: Facing right - turning - crouching - aiming up-right
; A3h: Facing left - turning - crouching - aiming up-left
; C1h: Facing right - moonwalking - turn/jump left - aiming up-right
; C2h: Facing left - moonwalking - turn/jump right - aiming up-left
$92:CD06             dx 9EAF60,00E0,0040
$92:CD0D             dx 9EB080,00C0,0040

; 25h: Facing right - turning - standing
; 26h: Facing left - turning - standing
; 2Fh: Facing right - turning - jumping
; 30h: Facing left - turning - jumping
; 43h: Facing right - turning - crouching
; 44h: Facing left - turning - crouching
; 87h: Facing right - turning - falling
; 88h: Facing left - turning - falling
; BFh: Facing right - moonwalking - turn/jump left
; C0h: Facing left - moonwalking - turn/jump right
; C6h: Unused
$92:CD14             dx 9EB180,00E0,00C0

; 5Ch: Unused
; 64h: Unused
; B9h: Facing right - grapple wall jump pose
$92:CD1B             dx 9EB320,0100,0080

; 45h: Unused
; 46h: Unused
; 5Bh: Unused
; 63h: Unused
; B8h: Facing left - grapple wall jump pose
$92:CD22             dx 9EB4A0,0100,0080

; 9: Moving right - not aiming
$92:CD29             dx 9EB620,0080,0080
$92:CD30             dx 9EB720,0080,0080

; Ah: Moving left - not aiming
$92:CD37             dx 9EB820,0080,0080
$92:CD3E             dx 9EB920,0080,0080

; 0: Facing forward - power suit
$92:CD45             dx 9EBA20,0080,0080

; 65h: Unused
; 83h: Facing right - wall jump
$92:CD4C             dx 9EBB20,0080,0080

; 66h: Unused
; 84h: Facing left - wall jump
$92:CD53             dx 9EBC20,0080,0080

; 63h: Unused
; C9h: Facing right - shinespark - horizontal
; CDh: Facing right - shinespark - diagonal
$92:CD5A             dx 9EBD20,0100,00C0

; 64h: Unused
; CAh: Facing left - shinespark - horizontal
; CEh: Facing left - shinespark - diagonal
$92:CD61             dx 9EBEE0,0100,00C0

; Unused
$92:CD68             dx 9EC0A0,0020,0000

; Unused
$92:CD6F             dx 9EC0C0,0020,0000

; 8Dh: Facing right - turning - standing - aiming down-right
; 8Eh: Facing left - turning - standing - aiming down-left
; 91h: Facing right - turning - in air - aiming down/down-right
; 92h: Facing left - turning - in air - aiming down/down-left
; 95h: Facing right - turning - falling - aiming down/down-right
; 96h: Facing left - turning - falling - aiming down/down-left
; 99h: Facing right - turning - crouching - aiming down/down-right
; 9Ah: Facing left - turning - crouching - aiming down/down-left
; C3h: Facing right - moonwalking - turn/jump left - aiming down-right
; C4h: Facing left - moonwalking - turn/jump right - aiming down-left
$92:CD76             dx 9EC0E0,00E0,0040
$92:CD7D             dx 9EC200,00E0,0040

; 17h: Facing right - normal jump - aiming down
; 2Dh: Facing right - falling - aiming down
; AEh: Unused
$92:CD84             dx 9EC320,00C0,0080

; 18h: Facing left - normal jump - aiming down
; 2Eh: Facing left - falling - aiming down
; AFh: Unused
$92:CD8B             dx 9EC460,00C0,0080

; 19h: Facing right - spin jump
; 1Bh: Facing right - space jump
; 20h: Unused
; 21h: Unused
; 22h: Unused
; 23h: Unused
; 24h: Unused
; 33h: Unused
; 34h: Unused
; 39h: Unused
; 3Ah: Unused
; 42h: Unused
; 81h: Facing right - screw attack
$92:CD92             dx 9EC5A0,00C0,0080

; 1Ah: Facing left - spin jump
; 1Ch: Facing left - space jump
; 82h: Facing left - screw attack
$92:CD99             dx 9EC6E0,00C0,0080
}


;;; $CDA0: Samus top tiles - 2 ;;;
{
; 4Bh: Facing right - normal jump transition
; A4h: Facing right - landing from normal jump
; A6h: Facing right - landing from spin jump
$92:CDA0             dx 9EC820,0080,0040

; 4Ch: Facing left - normal jump transition
; A5h: Facing left - landing from normal jump
; A7h: Facing left - landing from spin jump
$92:CDA7             dx 9EC8E0,0080,0080

; Unused
$92:CDAE             dx 9EC9E0,00C0,0080

; E9h: Facing left - Samus drained - crouching
$92:CDB5             dx 9ECB20,0080,0080

; 19h: Facing right - spin jump
; 1Bh: Facing right - space jump
; 20h: Unused
; 21h: Unused
; 22h: Unused
; 23h: Unused
; 24h: Unused
; 29h: Facing right - falling
; 33h: Unused
; 34h: Unused
; 39h: Unused
; 3Ah: Unused
; 42h: Unused
; 50h: Facing right - damage boost
; 81h: Facing right - screw attack
; 83h: Facing right - wall jump
; A4h: Facing right - landing from normal jump
; A6h: Facing right - landing from spin jump
; ECh: Facing right - grabbed by Draygon - not moving - not aiming
$92:CDBC             dx 9ECC20,0080,0040

; 1Ah: Facing left - spin jump
; 1Ch: Facing left - space jump
; 2Ah: Facing left - falling
; 4Fh: Facing left - damage boost
; 82h: Facing left - screw attack
; 84h: Facing left - wall jump
; A5h: Facing left - landing from normal jump
; A7h: Facing left - landing from spin jump
; BAh: Facing left - grabbed by Draygon - not moving - not aiming
$92:CDC3             dx 9ECCE0,0080,0080

; 11h: Moving right - aiming down-right
; 78h: Facing right - moonwalk - aiming down-right
$92:CDCA             dx 9ECDE0,00E0,0040

; 12h: Moving left - aiming down-left
; 77h: Facing left - moonwalk - aiming down-left
$92:CDD1             dx 9ECF00,00E0,0040

; D5h: Facing right - x-ray - standing
; D9h: Facing right - x-ray - crouching
$92:CDD8             dx 9ED020,00C0,0040
$92:CDDF             dx 9ED120,00C0,0040
$92:CDE6             dx 9ED220,00C0,0040
$92:CDED             dx 9ED320,00C0,0040

; D6h: Facing left - x-ray - standing
; DAh: Facing left - x-ray - crouching
$92:CDF4             dx 9ED420,00C0,0040
$92:CDFB             dx 9ED520,00C0,0040

; Dh: Moving right - aiming up (unused)
; D6h: Facing left - x-ray - standing
; DAh: Facing left - x-ray - crouching
$92:CE02             dx 9ED620,00C0,0040

; Eh: Moving left - aiming up (unused)
; D6h: Facing left - x-ray - standing
; DAh: Facing left - x-ray - crouching
$92:CE09             dx 9ED720,00C0,0040

; Fh: Moving right - aiming up-right
; 76h: Facing right - moonwalk - aiming up-right
$92:CE10             dx 9ED820,00C0,0040

; 10h: Moving left - aiming up-left
; 75h: Facing left - moonwalk - aiming up-left
$92:CE17             dx 9ED920,00E0,0040

; Unused
$92:CE1E             dx 9EDA40,0100,0040
$92:CE25             dx 9EDB80,0100,0040
$92:CE2C             dx 9EDCC0,0100,0040
$92:CE33             dx 9EDE00,0100,0040

; Fh: Moving right - aiming up-right
$92:CE3A             dx 9EDF40,00C0,0040

; 10h: Moving left - aiming up-left
$92:CE41             dx 9EE040,00E0,0040

; 11h: Moving right - aiming down-right
$92:CE48             dx 9EE160,00E0,0040

; 12h: Moving left - aiming down-left
$92:CE4F             dx 9EE280,00E0,0040

; 4Ah: Facing right - moonwalk
$92:CE56             dx 9EE3A0,00C0,0040

; 49h: Facing left - moonwalk
$92:CE5D             dx 9EE4A0,00C0,0040

; 29h: Facing right - falling
$92:CE64             dx 9EE5A0,00E0,0040

; 29h: Facing right - falling
; 50h: Facing right - damage boost
$92:CE6B             dx 9EE6C0,00C0,0040

; Dh: Moving right - aiming up (unused)
; 2Ah: Facing left - falling
$92:CE72             dx 9EE7C0,00C0,0040

; Eh: Moving left - aiming up (unused)
; 2Ah: Facing left - falling
; 4Fh: Facing left - damage boost
$92:CE79             dx 9EE8C0,00C0,0040
}


;;; $CE80: Samus top tiles - 3 ;;;
{
; 5Dh: Unused
; 5Eh: Unused
; 5Fh: Unused
; 60h: Unused
; 61h: Unused
; B2h: Facing clockwise - grapple
$92:CE80             dx 9C9B00,00C0,0080
$92:CE87             dx 9C9C40,00C0,0080
$92:CE8E             dx 9C9D80,00C0,00C0
$92:CE95             dx 9C9F00,00C0,00C0
$92:CE9C             dx 9CA080,00C0,00C0
$92:CEA3             dx 9CA200,00C0,00C0
$92:CEAA             dx 9CA380,00C0,00C0
$92:CEB1             dx 9CA500,00C0,0080
$92:CEB8             dx 9CA640,00C0,0080
$92:CEBF             dx 9CA780,00C0,0080
$92:CEC6             dx 9CA8C0,00C0,00C0
$92:CECD             dx 9CAA40,00C0,00C0
$92:CED4             dx 9CABC0,00C0,00C0
$92:CEDB             dx 9CAD40,00C0,00C0
$92:CEE2             dx 9CAEC0,00C0,00C0
$92:CEE9             dx 9CB040,00C0,0080

; Unused
$92:CEF0             dx 9CB180,00C0,0080
}


;;; $CEF7: Samus top tiles - 4 ;;;
{
; 62h: Unused
; B3h: Facing anticlockwise - grapple
$92:CEF7             dx 9CB2C0,0100,00C0
$92:CEFE             dx 9CB480,0100,00C0
$92:CF05             dx 9CB640,0100,0100
$92:CF0C             dx 9CB840,0100,0100
$92:CF13             dx 9CBA40,0100,00E0
$92:CF1A             dx 9CBC20,0100,00E0
$92:CF21             dx 9CBE00,0100,00E0
$92:CF28             dx 9CBFE0,0100,00C0
$92:CF2F             dx 9CC1A0,0100,00C0
$92:CF36             dx 9CC360,0100,00C0
$92:CF3D             dx 9CC520,0100,00E0
$92:CF44             dx 9CC700,0100,0100
$92:CF4B             dx 9CC900,0100,0100
$92:CF52             dx 9CCB00,0100,0100
$92:CF59             dx 9CCD00,0100,0100
$92:CF60             dx 9CCF00,0100,00E0

; Unused
$92:CF67             dx 9CD0E0,0100,00E0
}


;;; $CF6E: Samus top tiles - 5 ;;;
{
; 5Dh: Unused
; 5Eh: Unused
; 5Fh: Unused
; 60h: Unused
; 61h: Unused
; B2h: Facing clockwise - grapple
$92:CF6E             dx 9DC980,00C0,0080
$92:CF75             dx 9DCAC0,00C0,0080
$92:CF7C             dx 9DCC00,00C0,00C0
$92:CF83             dx 9DCD80,00C0,00C0
$92:CF8A             dx 9DCF00,00C0,00C0
$92:CF91             dx 9DD080,00C0,00C0
$92:CF98             dx 9DD200,00C0,00C0
$92:CF9F             dx 9DD380,00C0,0080
$92:CFA6             dx 9DD4C0,00C0,0080
$92:CFAD             dx 9DD600,00C0,0080
$92:CFB4             dx 9DD740,00C0,00C0
$92:CFBB             dx 9DD8C0,00C0,00C0
$92:CFC2             dx 9DDA40,00C0,00C0
$92:CFC9             dx 9DDBC0,00C0,00C0
$92:CFD0             dx 9DDD40,00C0,00C0
$92:CFD7             dx 9DDEC0,00C0,0080

; Unused
$92:CFDE             dx 9DE000,00C0,0080
}


;;; $CFE5: Samus top tiles - 6 ;;;
{
; 62h: Unused
; B3h: Facing anticlockwise - grapple
$92:CFE5             dx 9DE140,0100,00C0
$92:CFEC             dx 9DE300,0100,00C0
$92:CFF3             dx 9DE4C0,0100,0100
$92:CFFA             dx 9DE6C0,0100,0100
$92:D001             dx 9DE8C0,0100,00E0
$92:D008             dx 9DEAA0,0100,00E0
$92:D00F             dx 9DEC80,0100,00E0
$92:D016             dx 9DEE60,0100,00C0
$92:D01D             dx 9DF020,0100,00C0
$92:D024             dx 9DF1E0,0100,00C0
$92:D02B             dx 9DF3A0,0100,00E0
$92:D032             dx 9DF580,0100,0100
$92:D039             dx 9FED80,0100,0100
$92:D040             dx 9FEF80,0100,0100
$92:D047             dx 9FF180,0100,0100
$92:D04E             dx 9FF380,0100,00E0

; Unused
$92:D055             dx 9FF560,0100,00E0
}


;;; $D05C: Samus top tiles - 7 ;;;
{
; E9h: Facing left - Samus drained - crouching
$92:D05C             dx 9CD2C0,00E0,0040
$92:D063             dx 9CD3E0,00E0,0040
$92:D06A             dx 9CD500,00E0,0040

; E8h: Facing right - Samus drained - crouching
$92:D071             dx 9CD620,0100,0040
$92:D078             dx 9CD760,0100,0040
$92:D07F             dx 9CD8A0,0100,0040

; EBh: Facing left - Samus drained - standing
$92:D086             dx 9CD9E0,00E0,0040

; E9h: Facing left - Samus drained - crouching
; EBh: Facing left - Samus drained - standing
$92:D08D             dx 9CDB00,00E0,0040

; EBh: Facing left - Samus drained - standing
$92:D094             dx 9CDC20,00E0,0040

; EAh: Facing right - Samus drained - standing
$92:D09B             dx 9CDD40,0100,0040
$92:D0A2             dx 9CDE80,0100,0040
$92:D0A9             dx 9CDFC0,0100,0040

; 1: Facing right - normal
; 27h: Facing right - crouching
; 47h: Unused
; 89h: Facing right - ran into a wall
; A8h: Unused
; B4h: Unused
$92:D0B0             dx 9CE100,00C0,0080
$92:D0B7             dx 9CE240,00C0,0080
$92:D0BE             dx 9CE380,00C0,0080

; 2: Facing left - normal
; 28h: Facing left - crouching
; 48h: Unused
; 8Ah: Facing left - ran into a wall
; A9h: Unused
; B5h: Unused
$92:D0C5             dx 9CE4C0,00C0,0080
$92:D0CC             dx 9CE600,00C0,0080
$92:D0D3             dx 9CE740,00C0,0080

; 1: Facing right - normal
; 27h: Facing right - crouching
; 47h: Unused
; 89h: Facing right - ran into a wall
; A8h: Unused
; B4h: Unused
$92:D0DA             dx 9CE880,00C0,0040

; 28h: Facing left - crouching
; 2: Facing left - normal
; 48h: Unused
; 8Ah: Facing left - ran into a wall
; A9h: Unused
; B5h: Unused
$92:D0E1             dx 9CE980,00C0,0040
}


;;; $D0E8: Samus top tiles - 8 ;;;
{
; 0: Facing forward - power suit
; 9Bh: Facing forward - varia/gravity suit
$92:D0E8             dx 9BE000,0020,0000

; Unused
$92:D0EF             dx 9BE020,0020,0000

; 0: Facing forward - power suit
; 9Bh: Facing forward - varia/gravity suit
$92:D0F6             dx 9BE040,0100,0020
$92:D0FD             dx 9BE160,00E0,0000
$92:D104             dx 9BE240,0100,0060
$92:D10B             dx 9BE3A0,0100,00E0
$92:D112             dx 9BE580,0100,0000
$92:D119             dx 9BE680,0100,0040
$92:D120             dx 9BE7C0,0100,0060
$92:D127             dx 9BE920,00E0,0000
}


;;; $D12E: Samus top tiles - 9 ;;;
{
; Bh: Moving right - gun extended
$92:D12E             dx 9BEE20,0080,0040
$92:D135             dx 9BEEE0,0080,0040
$92:D13C             dx 9BEFA0,00A0,0040
$92:D143             dx 9BF080,00C0,0040
$92:D14A             dx 9BF180,0080,0040
$92:D151             dx 9BF240,00A0,0040

; Ch: Moving left - gun extended
$92:D158             dx 9BF320,00C0,0040
$92:D15F             dx 9BF420,00C0,0040
$92:D166             dx 9BF520,00E0,0040
$92:D16D             dx 9BF640,00E0,0040
$92:D174             dx 9BF760,00C0,0040
$92:D17B             dx 9BF860,0100,0040

; Bh: Moving right - gun extended
$92:D182             dx 9BF9A0,00C0,0040

; Ch: Moving left - gun extended
$92:D189             dx 9BFAA0,0100,0040

; Bh: Moving right - gun extended
$92:D190             dx 9BFBE0,0080,0040

; Ch: Moving left - gun extended
$92:D197             dx 9BFCA0,00C0,0040
}


;;; $D19E: Samus bottom tiles - 0 ;;;
{
; 1Ah: Facing left - spin jump
; 1Ch: Facing left - space jump
; 82h: Facing left - screw attack
$92:D19E             dx 9D8000,0080,0080

; 19h: Facing right - spin jump
; 1Bh: Facing right - space jump
; 20h: Unused
; 21h: Unused
; 22h: Unused
; 23h: Unused
; 24h: Unused
; 33h: Unused
; 34h: Unused
; 39h: Unused
; 3Ah: Unused
; 42h: Unused
; 81h: Facing right - screw attack
$92:D1A5             dx 9D8100,00E0,0080

; 2: Facing left - normal
; 48h: Unused
; 8Ah: Facing left - ran into a wall
; A9h: Unused
$92:D1AC             dx 9D8260,00E0,00C0

; CAh: Facing left - shinespark - horizontal
; CEh: Facing left - shinespark - diagonal
$92:D1B3             dx 9D8400,0080,0080

; C9h: Facing right - shinespark - horizontal
; CDh: Facing right - shinespark - diagonal
$92:D1BA             dx 9D8500,0100,0080

; 45h: Unused
; 46h: Unused
; 5Bh: Unused
; 63h: Unused
; B8h: Facing left - grapple wall jump pose
$92:D1C1             dx 9D8680,00E0,00C0

; 5Ch: Unused
; 64h: Unused
; B9h: Facing right - grapple wall jump pose
$92:D1C8             dx 9D8820,00C0,00C0

; 2Fh: Facing right - turning - jumping
; 30h: Facing left - turning - jumping
; 43h: Facing right - turning - crouching
; 44h: Facing left - turning - crouching
; 87h: Facing right - turning - falling
; 88h: Facing left - turning - falling
; 8Fh: Facing right - turning - in air - aiming up
; 90h: Facing left - turning - in air - aiming up
; 91h: Facing right - turning - in air - aiming down/down-right
; 92h: Facing left - turning - in air - aiming down/down-left
; 93h: Facing right - turning - falling - aiming up
; 94h: Facing left - turning - falling - aiming up
; 95h: Facing right - turning - falling - aiming down/down-right
; 96h: Facing left - turning - falling - aiming down/down-left
; 97h: Facing right - turning - crouching - aiming up
; 98h: Facing left - turning - crouching - aiming up
; 99h: Facing right - turning - crouching - aiming down/down-right
; 9Ah: Facing left - turning - crouching - aiming down/down-left
; 9Eh: Facing right - turning - in air - aiming up-right
; 9Fh: Facing left - turning - in air - aiming up-left
; A0h: Facing right - turning - falling - aiming up-right
; A1h: Facing left - turning - falling - aiming up-left
; A2h: Facing right - turning - crouching - aiming up-right
; A3h: Facing left - turning - crouching - aiming up-left
$92:D1CF             dx 9D89A0,0080,0080
$92:D1D6             dx 9D8AA0,00C0,0080

; 25h: Facing right - turning - standing
; 26h: Facing left - turning - standing
; 8Bh: Facing right - turning - standing - aiming up
; 8Ch: Facing left - turning - standing - aiming up
; 8Dh: Facing right - turning - standing - aiming down-right
; 8Eh: Facing left - turning - standing - aiming down-left
; 9Ch: Facing right - turning - standing - aiming up-right
; 9Dh: Facing left - turning - standing - aiming up-left
; BFh: Facing right - moonwalking - turn/jump left
; C0h: Facing left - moonwalking - turn/jump right
; C1h: Facing right - moonwalking - turn/jump left - aiming up-right
; C2h: Facing left - moonwalking - turn/jump right - aiming up-left
; C3h: Facing right - moonwalking - turn/jump left - aiming down-right
; C4h: Facing left - moonwalking - turn/jump right - aiming down-left
; C6h: Unused
$92:D1DD             dx 9D8BE0,0100,0080
$92:D1E4             dx 9D8D60,00C0,0080

; 16h: Facing left - normal jump - aiming up
; 6Ah: Facing left - normal jump - aiming up-left
$92:D1EB             dx 9D8EA0,0100,0080

; 15h: Facing right - normal jump - aiming up
; 69h: Facing right - normal jump - aiming up-right
$92:D1F2             dx 9D9020,0100,00C0

; 50h: Facing right - damage boost
$92:D1F9             dx 9D91E0,0100,00C0

; 4Fh: Facing left - damage boost
$92:D200             dx 9D93A0,00C0,00C0

; 2: Facing left - normal
; 48h: Unused
; 8Ah: Facing left - ran into a wall
; A9h: Unused
$92:D207             dx 9D9520,00C0,00C0

; 1: Facing right - normal
; 47h: Unused
; 89h: Facing right - ran into a wall
; A8h: Unused
$92:D20E             dx 9D96A0,00C0,00C0
$92:D215             dx 9D9820,00A0,0040

; 9Bh: Facing forward - varia/gravity suit
$92:D21C             dx 9D9900,00A0,0040

; 0: Facing forward - power suit
$92:D223             dx 9D99E0,00A0,0080

; 9: Moving right - not aiming
; Ah: Moving left - not aiming
; Bh: Moving right - gun extended
; Ch: Moving left - gun extended
; Dh: Moving right - aiming up (unused)
; Eh: Moving left - aiming up (unused)
; Fh: Moving right - aiming up-right
; 10h: Moving left - aiming up-left
; 11h: Moving right - aiming down-right
; 12h: Moving left - aiming down-left
$92:D22A             dx 9D9B00,00A0,0080
$92:D231             dx 9D9C20,00A0,0080
$92:D238             dx 9D9D40,00A0,0080
$92:D23F             dx 9D9E60,0080,0040

; 27h: Facing right - crouching
; 28h: Facing left - crouching
; 71h: Facing right - crouching - aiming up-right
; 72h: Facing left - crouching - aiming up-left
; 73h: Facing right - crouching - aiming down-right
; 74h: Facing left - crouching - aiming down-left
; 85h: Facing right - crouching - aiming up
; 86h: Facing left - crouching - aiming up
; B4h: Unused
; B5h: Unused
; B6h: Unused
; B7h: Unused
; D9h: Facing right - x-ray - crouching
; DAh: Facing left - x-ray - crouching
$92:D246             dx 9D9F20,0080,0040

; 1: Facing right - normal
; 2: Facing left - normal
; 47h: Unused
; 48h: Unused
; 89h: Facing right - ran into a wall
; 8Ah: Facing left - ran into a wall
; A4h: Facing right - landing from normal jump
; A5h: Facing left - landing from normal jump
; A6h: Facing right - landing from spin jump
; A7h: Facing left - landing from spin jump
; A8h: Unused
; A9h: Unused
; D5h: Facing right - x-ray - standing
; D6h: Facing left - x-ray - standing
; E0h: Facing right - landing from normal jump - aiming up
; E1h: Facing left - landing from normal jump - aiming up
; E2h: Facing right - landing from normal jump - aiming up-right
; E3h: Facing left - landing from normal jump - aiming up-left
; E4h: Facing right - landing from normal jump - aiming down-right
; E5h: Facing left - landing from normal jump - aiming down-left
; E6h: Facing right - landing from normal jump - firing
; E7h: Facing left - landing from normal jump - firing
$92:D24D             dx 9D9FE0,0080,0080

; 9: Moving right - not aiming
; Ah: Moving left - not aiming
; Bh: Moving right - gun extended
; Ch: Moving left - gun extended
; Dh: Moving right - aiming up (unused)
; Eh: Moving left - aiming up (unused)
; Fh: Moving right - aiming up-right
; 10h: Moving left - aiming up-left
; 11h: Moving right - aiming down-right
; 12h: Moving left - aiming down-left
$92:D254             dx 9DA0E0,0080,0080
$92:D25B             dx 9DA1E0,00C0,0080

; 9: Moving right - not aiming
; Ah: Moving left - not aiming
; Bh: Moving right - gun extended
; Ch: Moving left - gun extended
; Dh: Moving right - aiming up (unused)
; Eh: Moving left - aiming up (unused)
; Fh: Moving right - aiming up-right
; 10h: Moving left - aiming up-left
; 11h: Moving right - aiming down-right
; 12h: Moving left - aiming down-left
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; 4Eh: Facing left - normal jump - not aiming - not moving - gun not extended
; C7h: Facing right - vertical shinespark windup
; C8h: Facing left - vertical shinespark windup
$92:D262             dx 9DA320,00C0,0080

; 9: Moving right - not aiming
; Ah: Moving left - not aiming
; Bh: Moving right - gun extended
; Ch: Moving left - gun extended
; Dh: Moving right - aiming up (unused)
; Eh: Moving left - aiming up (unused)
; Fh: Moving right - aiming up-right
; 10h: Moving left - aiming up-left
; 11h: Moving right - aiming down-right
; 12h: Moving left - aiming down-left
$92:D269             dx 9DA460,00C0,00C0
$92:D270             dx 9DA5E0,0080,0080

; 0: Facing forward - power suit
; 1: Facing right - normal
; 2: Facing left - normal
; 9: Moving right - not aiming
; Ah: Moving left - not aiming
; Bh: Moving right - gun extended
; Ch: Moving left - gun extended
; Dh: Moving right - aiming up (unused)
; Eh: Moving left - aiming up (unused)
; Fh: Moving right - aiming up-right
; 10h: Moving left - aiming up-left
; 11h: Moving right - aiming down-right
; 12h: Moving left - aiming down-left
; 19h: Facing right - spin jump
; 1Ah: Facing left - spin jump
; 1Bh: Facing right - space jump
; 1Ch: Facing left - space jump
; 1Dh: Facing right - morph ball - no springball - on ground
; 1Eh: Moving right - morph ball - no springball - on ground
; 1Fh: Moving left - morph ball - no springball - on ground
; 20h: Unused
; 21h: Unused
; 22h: Unused
; 23h: Unused
; 24h: Unused
; 27h: Facing right - crouching
; 28h: Facing left - crouching
; 29h: Facing right - falling
; 2Ah: Facing left - falling
; 31h: Facing right - morph ball - no springball - in air
; 32h: Facing left - morph ball - no springball - in air
; 33h: Unused
; 34h: Unused
; 37h: Facing right - morphing transition
; 38h: Facing left - morphing transition
; 39h: Unused
; 3Ah: Unused
; 3Dh: Facing right - unmorphing transition
; 3Eh: Facing left - unmorphing transition
; 3Fh: Unused
; 40h: Unused
; 41h: Facing left - morph ball - no springball - on ground
; 42h: Unused
; 47h: Unused
; 48h: Unused
; 4Fh: Facing left - damage boost
; 50h: Facing right - damage boost
; 65h: Unused
; 66h: Unused
; 67h: Facing right - falling - gun extended
; 68h: Facing left - falling - gun extended
; 79h: Facing right - morph ball - spring ball - on ground
; 7Ah: Facing left - morph ball - spring ball - on ground
; 7Bh: Moving right - morph ball - spring ball - on ground
; 7Ch: Moving left - morph ball - spring ball - on ground
; 7Dh: Facing right - morph ball - spring ball - falling
; 7Eh: Facing left - morph ball - spring ball - falling
; 7Fh: Facing right - morph ball - spring ball - in air
; 80h: Facing left - morph ball - spring ball - in air
; 81h: Facing right - screw attack
; 82h: Facing left - screw attack
; 83h: Facing right - wall jump
; 84h: Facing left - wall jump
; 89h: Facing right - ran into a wall
; 8Ah: Facing left - ran into a wall
; 9Bh: Facing forward - varia/gravity suit
; A8h: Unused
; A9h: Unused
; B4h: Unused
; B5h: Unused
; C5h: Unused
; CBh: Facing right - shinespark - vertical
; CCh: Facing left - shinespark - vertical
; D3h: Facing right - crystal flash
; D4h: Facing left - crystal flash
; DBh: Unused
; DCh: Unused
; DDh: Unused
; DEh: Unused
; DFh: Unused
; E8h: Facing right - Samus drained - crouching
; E9h: Facing left - Samus drained - crouching
; EAh: Facing right - Samus drained - standing
; EBh: Facing left - Samus drained - standing
$92:D277             dx 9DA6E0,0080,0080
}


;;; $D27E: Samus bottom tiles - 1 ;;;
{
; 49h: Facing left - moonwalk
; 4Ah: Facing right - moonwalk
; 75h: Facing left - moonwalk - aiming up-left
; 76h: Facing right - moonwalk - aiming up-right
; 77h: Facing left - moonwalk - aiming down-left
; 78h: Facing right - moonwalk - aiming down-right
$92:D27E             dx 9DA7E0,00C0,0080

; 25h: Facing right - turning - standing
; 26h: Facing left - turning - standing
; 8Bh: Facing right - turning - standing - aiming up
; 8Ch: Facing left - turning - standing - aiming up
; 8Dh: Facing right - turning - standing - aiming down-right
; 8Eh: Facing left - turning - standing - aiming down-left
; 9Ch: Facing right - turning - standing - aiming up-right
; 9Dh: Facing left - turning - standing - aiming up-left
; BFh: Facing right - moonwalking - turn/jump left
; C0h: Facing left - moonwalking - turn/jump right
; C1h: Facing right - moonwalking - turn/jump left - aiming up-right
; C2h: Facing left - moonwalking - turn/jump right - aiming up-left
; C3h: Facing right - moonwalking - turn/jump left - aiming down-right
; C4h: Facing left - moonwalking - turn/jump right - aiming down-left
; C6h: Unused
$92:D285             dx 9DA920,0080,0080

; 2Fh: Facing right - turning - jumping
; 30h: Facing left - turning - jumping
; 43h: Facing right - turning - crouching
; 44h: Facing left - turning - crouching
; 87h: Facing right - turning - falling
; 88h: Facing left - turning - falling
; 8Fh: Facing right - turning - in air - aiming up
; 90h: Facing left - turning - in air - aiming up
; 91h: Facing right - turning - in air - aiming down/down-right
; 92h: Facing left - turning - in air - aiming down/down-left
; 93h: Facing right - turning - falling - aiming up
; 94h: Facing left - turning - falling - aiming up
; 95h: Facing right - turning - falling - aiming down/down-right
; 96h: Facing left - turning - falling - aiming down/down-left
; 97h: Facing right - turning - crouching - aiming up
; 98h: Facing left - turning - crouching - aiming up
; 99h: Facing right - turning - crouching - aiming down/down-right
; 9Ah: Facing left - turning - crouching - aiming down/down-left
; 9Eh: Facing right - turning - in air - aiming up-right
; 9Fh: Facing left - turning - in air - aiming up-left
; A0h: Facing right - turning - falling - aiming up-right
; A1h: Facing left - turning - falling - aiming up-left
; A2h: Facing right - turning - crouching - aiming up-right
; A3h: Facing left - turning - crouching - aiming up-left
$92:D28C             dx 9DAA20,0040,0040

; 49h: Facing left - moonwalk
; 4Ah: Facing right - moonwalk
; 75h: Facing left - moonwalk - aiming up-left
; 76h: Facing right - moonwalk - aiming up-right
; 77h: Facing left - moonwalk - aiming down-left
; 78h: Facing right - moonwalk - aiming down-right
$92:D293             dx 9DAAA0,00C0,0080
$92:D29A             dx 9DABE0,0080,0080
$92:D2A1             dx 9DACE0,0080,0080

; 35h: Facing right - crouching transition
; 3Bh: Facing right - standing transition
; 4Bh: Facing right - normal jump transition
; 55h: Facing right - normal jump transition - aiming up
; 57h: Facing right - normal jump transition - aiming up-right
; 59h: Facing right - normal jump transition - aiming down-right
; A4h: Facing right - landing from normal jump
; A6h: Facing right - landing from spin jump
; D3h: Facing right - crystal flash
; D7h: Facing right - crystal flash ending
; D8h: Facing left - crystal flash ending
; DBh: Unused
; DCh: Unused
; DDh: Unused
; DEh: Unused
; E0h: Facing right - landing from normal jump - aiming up
; E2h: Facing right - landing from normal jump - aiming up-right
; E4h: Facing right - landing from normal jump - aiming down-right
; E6h: Facing right - landing from normal jump - firing
; E8h: Facing right - Samus drained - crouching
; E9h: Facing left - Samus drained - crouching
; EAh: Facing right - Samus drained - standing
; F1h: Facing right - crouching transition - aiming up
; F3h: Facing right - crouching transition - aiming up-right
; F5h: Facing right - crouching transition - aiming down-right
; F7h: Facing right - standing transition - aiming up
; F9h: Facing right - standing transition - aiming up-right
; FBh: Facing right - standing transition - aiming down-right
$92:D2A8             dx 9DADE0,00C0,0080

; 36h: Facing left - crouching transition
; 3Ch: Facing left - standing transition
; 4Ch: Facing left - normal jump transition
; 56h: Facing left - normal jump transition - aiming up
; 58h: Facing left - normal jump transition - aiming up-left
; 5Ah: Facing left - normal jump transition - aiming down-left
; A5h: Facing left - landing from normal jump
; A7h: Facing left - landing from spin jump
; D4h: Facing left - crystal flash
; D8h: Facing left - crystal flash ending
; E1h: Facing left - landing from normal jump - aiming up
; E3h: Facing left - landing from normal jump - aiming up-left
; E5h: Facing left - landing from normal jump - aiming down-left
; E7h: Facing left - landing from normal jump - firing
; E9h: Facing left - Samus drained - crouching
; EBh: Facing left - Samus drained - standing
; F2h: Facing left - crouching transition - aiming up
; F4h: Facing left - crouching transition - aiming up-left
; F6h: Facing left - crouching transition - aiming down-left
; F8h: Facing left - standing transition - aiming up
; FAh: Facing left - standing transition - aiming up-left
; FCh: Facing left - standing transition - aiming down-left
$92:D2AF             dx 9DAF20,00C0,0080

; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; C7h: Facing right - vertical shinespark windup
; F0h: Facing right - grabbed by Draygon - moving
$92:D2B6             dx 9DB060,00E0,0040

; 4Eh: Facing left - normal jump - not aiming - not moving - gun not extended
; C8h: Facing left - vertical shinespark windup
; BEh: Facing left - grabbed by Draygon - moving
$92:D2BD             dx 9DB180,00E0,0040

; 13h: Facing right - normal jump - not aiming - not moving - gun extended
; 15h: Facing right - normal jump - aiming up
; 17h: Facing right - normal jump - aiming down
; 29h: Facing right - falling
; 2Bh: Facing right - falling - aiming up
; 2Dh: Facing right - falling - aiming down
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; 50h: Facing right - damage boost
; 51h: Facing right - normal jump - not aiming - moving forward
; 67h: Facing right - falling - gun extended
; 69h: Facing right - normal jump - aiming up-right
; 6Bh: Facing right - normal jump - aiming down-right
; 6Dh: Facing right - falling - aiming up-right
; 6Fh: Facing right - falling - aiming down-right
; ACh: Unused
; AEh: Unused
; B0h: Unused
; C7h: Facing right - vertical shinespark windup
$92:D2C4             dx 9DB2A0,00A0,0080

; 14h: Facing left - normal jump - not aiming - not moving - gun extended
; 16h: Facing left - normal jump - aiming up
; 18h: Facing left - normal jump - aiming down
; 2Ah: Facing left - falling
; 2Ch: Facing left - falling - aiming up
; 2Eh: Facing left - falling - aiming down
; 4Eh: Facing left - normal jump - not aiming - not moving - gun not extended
; 4Fh: Facing left - damage boost
; 52h: Facing left - normal jump - not aiming - moving forward
; 68h: Facing left - falling - gun extended
; 6Ah: Facing left - normal jump - aiming up-left
; 6Ch: Facing left - normal jump - aiming down-left
; 6Eh: Facing left - falling - aiming up-left
; 70h: Facing left - falling - aiming down-left
; ADh: Unused
; AFh: Unused
; B1h: Unused
; C8h: Facing left - vertical shinespark windup
$92:D2CB             dx 9DB3C0,00A0,0080

; 29h: Facing right - falling
; 2Bh: Facing right - falling - aiming up
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; 53h: Facing right - knockback
; 67h: Facing right - falling - gun extended
; 6Dh: Facing right - falling - aiming up-right
; 6Fh: Facing right - falling - aiming down-right
; C7h: Facing right - vertical shinespark windup
; D7h: Facing right - crystal flash ending
; E8h: Facing right - Samus drained - crouching
; F0h: Facing right - grabbed by Draygon - moving
$92:D2D2             dx 9DB4E0,0080,0080

; 2Ah: Facing left - falling
; 2Ch: Facing left - falling - aiming up
; 4Eh: Facing left - normal jump - not aiming - not moving - gun not extended
; 54h: Facing left - knockback
; 68h: Facing left - falling - gun extended
; 6Eh: Facing left - falling - aiming up-left
; 70h: Facing left - falling - aiming down-left
; BEh: Facing left - grabbed by Draygon - moving
; C8h: Facing left - vertical shinespark windup
; D8h: Facing left - crystal flash ending
; E9h: Facing left - Samus drained - crouching
$92:D2D9             dx 9DB5E0,0080,0080

; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; C7h: Facing right - vertical shinespark windup
; F0h: Facing right - grabbed by Draygon - moving
$92:D2E0             dx 9DB6E0,00C0,0040

; 4Eh: Facing left - normal jump - not aiming - not moving - gun not extended
; BEh: Facing left - grabbed by Draygon - moving
; C8h: Facing left - vertical shinespark windup
$92:D2E7             dx 9DB7E0,00C0,0040

; Unused
$92:D2EE             dx 9DB8E0,0020,0000

; 17h: Facing right - normal jump - aiming down
; 2Dh: Facing right - falling - aiming down
; AEh: Unused
$92:D2F5             dx 9DB900,00E0,0040

; 18h: Facing left - normal jump - aiming down
; 2Eh: Facing left - falling - aiming down
; AFh: Unused
$92:D2FC             dx 9DBA20,00E0,0040

; 65h: Unused
; 83h: Facing right - wall jump
$92:D303             dx 9DBB40,0100,0040

; 66h: Unused
; 84h: Facing left - wall jump
$92:D30A             dx 9DBC80,00C0,0040

; 49h: Facing left - moonwalk
; 63h: Unused
$92:D311             dx 9DBD80,00A0,0080

; 49h: Facing left - moonwalk
; 64h: Unused
$92:D318             dx 9DBEA0,00A0,0080

; 4Ah: Facing right - moonwalk
; 75h: Facing left - moonwalk - aiming up-left
; 76h: Facing right - moonwalk - aiming up-right
; 77h: Facing left - moonwalk - aiming down-left
; 78h: Facing right - moonwalk - aiming down-right
$92:D31F             dx 9DBFC0,00A0,0080
$92:D326             dx 9DC0E0,00A0,0080

; 13h: Facing right - normal jump - not aiming - not moving - gun extended
; 19h: Facing right - spin jump
; 1Bh: Facing right - space jump
; 20h: Unused
; 21h: Unused
; 22h: Unused
; 23h: Unused
; 24h: Unused
; 29h: Facing right - falling
; 2Bh: Facing right - falling - aiming up
; 33h: Unused
; 34h: Unused
; 39h: Unused
; 3Ah: Unused
; 42h: Unused
; 50h: Facing right - damage boost
; 51h: Facing right - normal jump - not aiming - moving forward
; 67h: Facing right - falling - gun extended
; 6Bh: Facing right - normal jump - aiming down-right
; 6Dh: Facing right - falling - aiming up-right
; 6Fh: Facing right - falling - aiming down-right
; 81h: Facing right - screw attack
; 83h: Facing right - wall jump
; A6h: Facing right - landing from spin jump
; ACh: Unused
; B0h: Unused
; F0h: Facing right - grabbed by Draygon - moving
$92:D32D             dx 9DC200,00E0,0080

; 14h: Facing left - normal jump - not aiming - not moving - gun extended
; 1Ah: Facing left - spin jump
; 1Ch: Facing left - space jump
; 2Ah: Facing left - falling
; 2Ch: Facing left - falling - aiming up
; 4Fh: Facing left - damage boost
; 52h: Facing left - normal jump - not aiming - moving forward
; 68h: Facing left - falling - gun extended
; 6Ch: Facing left - normal jump - aiming down-left
; 6Eh: Facing left - falling - aiming up-left
; 70h: Facing left - falling - aiming down-left
; 82h: Facing left - screw attack
; 84h: Facing left - wall jump
; A7h: Facing left - landing from spin jump
; ADh: Unused
; B1h: Unused
; BEh: Facing left - grabbed by Draygon - moving
; E9h: Facing left - Samus drained - crouching
$92:D334             dx 9DC360,00E0,0080

; 53h: Facing right - knockback
; D7h: Facing right - crystal flash ending
; ECh: Facing right - grabbed by Draygon - not moving - not aiming
; EDh: Facing right - grabbed by Draygon - not moving - aiming up-right
; EEh: Facing right - grabbed by Draygon - firing
; EFh: Facing right - grabbed by Draygon - not moving - aiming down-right
; F0h: Facing right - grabbed by Draygon - moving
$92:D33B             dx 9DC4C0,00C0,0080

; 54h: Facing left - knockback
; BAh: Facing left - grabbed by Draygon - not moving - not aiming
; BBh: Facing left - grabbed by Draygon - not moving - aiming up-left
; BCh: Facing left - grabbed by Draygon - firing
; BDh: Facing left - grabbed by Draygon - not moving - aiming down-left
; BEh: Facing left - grabbed by Draygon - moving
; D8h: Facing left - crystal flash ending
$92:D342             dx 9DC600,00C0,0080

; Unused
$92:D349             dx 9DC740,0080,0080

; E9h: Facing left - Samus drained - crouching
; EBh: Facing left - Samus drained - standing
$92:D350             dx 9DC840,0060,0040

; E8h: Facing right - Samus drained - crouching
; EAh: Facing right - Samus drained - standing
$92:D357             dx 9DC8E0,0060,0040
}


;;; $D35E: Samus bottom tiles - 2 ;;;
{
; 5Dh: Unused
; 5Eh: Unused
; 5Fh: Unused
; 60h: Unused
; 61h: Unused
; B2h: Facing clockwise - grapple
$92:D35E             dx 9F8000,0080,0040
$92:D365             dx 9F80C0,00E0,0040
$92:D36C             dx 9F81E0,00A0,0080
$92:D373             dx 9F8300,00A0,0040
$92:D37A             dx 9F83E0,00C0,0040
$92:D381             dx 9F84E0,00C0,0040
$92:D388             dx 9F85E0,0080,0040
$92:D38F             dx 9F86A0,00A0,0040
$92:D396             dx 9F8780,00A0,0040
$92:D39D             dx 9F8860,00C0,0040

; Unused
$92:D3A4             dx 9F8960,00A0,0080

; 5Dh: Unused
; 5Eh: Unused
; 5Fh: Unused
; 60h: Unused
; 61h: Unused
; B2h: Facing clockwise - grapple
$92:D3AB             dx 9F8A80,0080,0080
$92:D3B2             dx 9F8B80,0080,0080
$92:D3B9             dx 9F8C80,0080,0080
$92:D3C0             dx 9F8D80,00A0,0040
$92:D3C7             dx 9F8E60,0080,0080
$92:D3CE             dx 9F8F60,0080,0080
$92:D3D5             dx 9F9060,00A0,0040
$92:D3DC             dx 9F9140,0080,0080
$92:D3E3             dx 9F9240,0080,0080
$92:D3EA             dx 9F9340,0080,0080
$92:D3F1             dx 9F9440,00C0,0080
$92:D3F8             dx 9F9580,0080,0080

; Unused
$92:D3FF             dx 9F9680,0080,0080
}


;;; $D406: Samus bottom tiles - 4 ;;;
{
; 5Dh: Unused
; 5Eh: Unused
; 5Fh: Unused
; 60h: Unused
; 61h: Unused
; B2h: Facing clockwise - grapple
$92:D406             dx 9F9780,0080,0040
$92:D40D             dx 9F9840,00E0,0040
$92:D414             dx 9F9960,00A0,0080
$92:D41B             dx 9F9A80,00A0,0040
$92:D422             dx 9F9B60,00C0,0040
$92:D429             dx 9F9C60,00C0,0040
$92:D430             dx 9F9D60,0080,0040
$92:D437             dx 9F9E20,00A0,0040
$92:D43E             dx 9F9F00,00A0,0040
$92:D445             dx 9F9FE0,00C0,0040

; Unused
$92:D44C             dx 9FA0E0,00A0,0080
$92:D453             dx 9FA200,0080,0080
$92:D45A             dx 9FA300,0080,0080

; 5Dh: Unused
; 5Eh: Unused
; 5Fh: Unused
; 60h: Unused
; 61h: Unused
; B2h: Facing clockwise - grapple
$92:D461             dx 9FA400,0080,0080
$92:D468             dx 9FA500,00A0,0040
$92:D46F             dx 9FA5E0,0080,0080
$92:D476             dx 9FA6E0,0080,0080
$92:D47D             dx 9FA7E0,00A0,0040
$92:D484             dx 9FA8C0,0080,0080
$92:D48B             dx 9FA9C0,0080,0080
$92:D492             dx 9FAAC0,0080,0080
$92:D499             dx 9FABC0,0080,0080

; Unused
$92:D4A0             dx 9FACC0,0080,0080
}


;;; $D4A7: Samus bottom tiles - 5 ;;;
{
; 62h: Unused
; B3h: Facing anticlockwise - grapple
$92:D4A7             dx 9FADC0,0080,0040
$92:D4AE             dx 9FAE80,00E0,0040
$92:D4B5             dx 9FAFA0,00A0,0080
$92:D4BC             dx 9FB0C0,00A0,0040
$92:D4C3             dx 9FB1A0,00C0,0040
$92:D4CA             dx 9FB2A0,00C0,0040
$92:D4D1             dx 9FB3A0,0080,0040
$92:D4D8             dx 9FB460,00A0,0040
$92:D4DF             dx 9FB540,00A0,0040
$92:D4E6             dx 9FB620,00C0,0040

; Unused
$92:D4ED             dx 9FB720,00A0,0080

; 62h: Unused
; B3h: Facing anticlockwise - grapple
$92:D4F4             dx 9FB840,0080,0080
$92:D4FB             dx 9FB940,0080,0080
$92:D502             dx 9FBA40,0080,0080
$92:D509             dx 9FBB40,00A0,0040
$92:D510             dx 9FBC20,0080,0080
$92:D517             dx 9FBD20,0080,0080
$92:D51E             dx 9FBE20,00A0,0040
$92:D525             dx 9FBF00,0080,0080
$92:D52C             dx 9FC000,0080,0080
$92:D533             dx 9FC100,0080,0080
$92:D53A             dx 9FC200,00C0,0080
$92:D541             dx 9FC340,0080,0080

; Unused
$92:D548             dx 9FC440,0080,0080
}


;;; $D54F: Samus bottom tiles - 6 ;;;
{
; 62h: Unused
; B3h: Facing anticlockwise - grapple
$92:D54F             dx 9FC540,0080,0040
$92:D556             dx 9FC600,00E0,0040
$92:D55D             dx 9FC720,00A0,0080
$92:D564             dx 9FC840,00A0,0040
$92:D56B             dx 9FC920,00C0,0040
$92:D572             dx 9FCA20,00C0,0040
$92:D579             dx 9FCB20,0080,0040
$92:D580             dx 9FCBE0,00A0,0040
$92:D587             dx 9FCCC0,00A0,0040
$92:D58E             dx 9FCDA0,00C0,0040

; Unused
$92:D595             dx 9FCEA0,00A0,0080
$92:D59C             dx 9FCFC0,0080,0080
$92:D5A3             dx 9FD0C0,0080,0080

; 62h: Unused
; B3h: Facing anticlockwise - grapple
$92:D5AA             dx 9FD1C0,0080,0080
$92:D5B1             dx 9FD2C0,00A0,0040
$92:D5B8             dx 9FD3A0,0080,0080
$92:D5BF             dx 9FD4A0,0080,0080
$92:D5C6             dx 9FD5A0,00A0,0040
$92:D5CD             dx 9FD680,0080,0080
$92:D5D4             dx 9FD780,0080,0080
$92:D5DB             dx 9FD880,0080,0080
$92:D5E2             dx 9FD980,0080,0080
$92:D5E9             dx 9FDA80,0080,0080
}


;;; $D5F0: Samus bottom tiles - 8 ;;;
{
; 0: Facing forward - power suit
$92:D5F0             dx 9BEA00,0100,0100

; 9Bh: Facing forward - varia/gravity suit
$92:D5F7             dx 9BEC00,0100,0100

; Unused
$92:D5FE             dx 9BEE00,0020,0000
}


;;; $D605: Samus bottom tiles - Ah ;;;
{
; 3: Facing right - aiming up
; 5: Facing right - aiming up-right
; 7: Facing right - aiming down-right
; AAh: Unused
; CFh: Facing right - ran into a wall - aiming up-right
; D1h: Facing right - ran into a wall - aiming down-right
$92:D605             dx 9FEB00,00C0,0080

; 4: Facing left - aiming up
; 6: Facing left - aiming up-left
; 8: Facing left - aiming down-left
; ABh: Unused
; D0h: Facing left - ran into a wall - aiming up-left
; D2h: Facing left - ran into a wall - aiming down-left
; E9h: Facing left - Samus drained - crouching
$92:D60C             dx 9FEC40,00C0,0080
}


;;; $D613: Samus top tiles - Ah ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground
; 1Eh: Moving right - morph ball - no springball - on ground
; 1Fh: Moving left - morph ball - no springball - on ground
; 31h: Facing right - morph ball - no springball - in air
; 32h: Facing left - morph ball - no springball - in air
; 3Fh: Unused
; 40h: Unused
; 41h: Facing left - morph ball - no springball - on ground
; 79h: Facing right - morph ball - spring ball - on ground
; 7Ah: Facing left - morph ball - spring ball - on ground
; 7Bh: Moving right - morph ball - spring ball - on ground
; 7Ch: Moving left - morph ball - spring ball - on ground
; 7Dh: Facing right - morph ball - spring ball - falling
; 7Eh: Facing left - morph ball - spring ball - falling
; 7Fh: Facing right - morph ball - spring ball - in air
; 80h: Facing left - morph ball - spring ball - in air
; C5h: Unused
; D7h: Facing right - crystal flash ending
; DFh: Unused
; E8h: Facing right - Samus drained - crouching
$92:D613             dx 9C8000,0060,0040
$92:D61A             dx 9C80A0,0060,0040
$92:D621             dx 9C8140,0060,0040
$92:D628             dx 9C81E0,0060,0040
$92:D62F             dx 9C8280,00A0,0000
$92:D636             dx 9C8320,0060,0040
$92:D63D             dx 9C83C0,0060,0040
$92:D644             dx 9C8460,0060,0040

; 19h: Facing right - spin jump
; 1Ah: Facing left - spin jump
; 20h: Unused
; 21h: Unused
; 22h: Unused
; 23h: Unused
; 24h: Unused
; 33h: Unused
; 34h: Unused
; 39h: Unused
; 3Ah: Unused
; 42h: Unused
; 83h: Facing right - wall jump
; 84h: Facing left - wall jump
$92:D64B             dx 9C8500,0080,0080

; 19h: Facing right - spin jump
; 1Ah: Facing left - spin jump
; 20h: Unused
; 21h: Unused
; 22h: Unused
; 23h: Unused
; 24h: Unused
; 33h: Unused
; 34h: Unused
; 39h: Unused
; 3Ah: Unused
; 42h: Unused
; 4Fh: Facing left - damage boost
; 50h: Facing right - damage boost
; 83h: Facing right - wall jump
; 84h: Facing left - wall jump
$92:D652             dx 9C8600,0100,0100
$92:D659             dx 9C8800,0080,0080
$92:D660             dx 9C8900,0100,0100
$92:D667             dx 9C8B00,0080,0080
$92:D66E             dx 9C8C00,0100,0100
$92:D675             dx 9C8E00,0080,0080
$92:D67C             dx 9C8F00,0100,0100

; 65h: Unused
; 66h: Unused
; 81h: Facing right - screw attack
; 82h: Facing left - screw attack
; 83h: Facing right - wall jump
; 84h: Facing left - wall jump
$92:D683             dx 9C9100,0100,0040
$92:D68A             dx 9C9240,0100,0060
$92:D691             dx 9C93A0,0100,0060
$92:D698             dx 9C9500,0100,0000

; 1Bh: Facing right - space jump
; 1Ch: Facing left - space jump
; 65h: Unused
; 66h: Unused
; 81h: Facing right - screw attack
; 82h: Facing left - screw attack
; 83h: Facing right - wall jump
; 84h: Facing left - wall jump
$92:D69F             dx 9C9600,0020,0000
}


;;; $D6A6: Samus top tiles - Bh ;;;
{
; 65h: Unused
; 66h: Unused
$92:D6A6             dx 9C9620,0020,0000

; 1Dh: Facing right - morph ball - no springball - on ground
; 1Eh: Moving right - morph ball - no springball - on ground
; 1Fh: Moving left - morph ball - no springball - on ground
; 31h: Facing right - morph ball - no springball - in air
; 32h: Facing left - morph ball - no springball - in air
; 3Fh: Unused
; 40h: Unused
; 41h: Facing left - morph ball - no springball - on ground
; 65h: Unused
; 66h: Unused
; 79h: Facing right - morph ball - spring ball - on ground
; 7Ah: Facing left - morph ball - spring ball - on ground
; 7Bh: Moving right - morph ball - spring ball - on ground
; 7Ch: Moving left - morph ball - spring ball - on ground
; 7Dh: Facing right - morph ball - spring ball - falling
; 7Eh: Facing left - morph ball - spring ball - falling
; 7Fh: Facing right - morph ball - spring ball - in air
; 80h: Facing left - morph ball - spring ball - in air
; C5h: Unused
; DFh: Unused
$92:D6AD             dx 9C9640,0060,0040

; 65h: Unused
; 66h: Unused
$92:D6B4             dx 9C96E0,0060,0040

; 38h: Facing left - morphing transition
; 3Eh: Facing left - unmorphing transition
; D4h: Facing left - crystal flash
; D8h: Facing left - crystal flash ending
; DCh: Unused
; DEh: Unused
; E9h: Facing left - Samus drained - crouching
$92:D6BB             dx 9C9780,0080,0040
$92:D6C2             dx 9C9840,00C0,0040

; 37h: Facing right - morphing transition
; 3Dh: Facing right - unmorphing transition
; D3h: Facing right - crystal flash
; D7h: Facing right - crystal flash ending
; DBh: Unused
; DDh: Unused
; E8h: Facing right - Samus drained - crouching
$92:D6C9             dx 9C9940,0080,0040
$92:D6D0             dx 9C9A00,00C0,0040
}


;;; $D6D7: Samus bottom tiles - 3 ;;;
{
; Unused
$92:D6D7             dx 9EE9C0,0040,0040
$92:D6DE             dx 9EEA40,0080,0080
$92:D6E5             dx 9EEB40,0040,0040

; D8h: Facing left - crystal flash ending
$92:D6EC             dx 9EEBC0,0080,0080

; Unused
$92:D6F3             dx 9EECC0,0040,0040
$92:D6FA             dx 9EED40,0080,0080
$92:D701             dx 9EEE40,0040,0040
$92:D708             dx 9EEEC0,0080,0080
$92:D70F             dx 9EEFC0,0040,0040
$92:D716             dx 9EF040,0080,0080
$92:D71D             dx 9EF140,0040,0040
$92:D724             dx 9EF1C0,0080,0080
$92:D72B             dx 9EF2C0,0040,0040
$92:D732             dx 9EF340,0080,0080
$92:D739             dx 9EF440,0040,0040
$92:D740             dx 9EF4C0,0080,0080
$92:D747             dx 9EF5C0,0080,0080
}


;;; $D74E: Samus top tiles - Ch ;;;
{
; CBh: Facing right - shinespark - vertical
$92:D74E             dx 9FDB80,0100,00C0

; CCh: Facing left - shinespark - vertical
$92:D755             dx 9FDD40,0100,00C0

; D4h: Facing left - crystal flash
$92:D75C             dx 9FDF00,0100,0040
$92:D763             dx 9FE040,0100,0040
$92:D76A             dx 9FE180,0100,0040

; D3h: Facing right - crystal flash
$92:D771             dx 9FE2C0,0100,0040
$92:D778             dx 9FE400,0100,0040
$92:D77F             dx 9FE540,0100,0040
}


;;; $D786: Samus bottom tiles - 7 ;;;
{
; D3h: Facing right - crystal flash
; D4h: Facing left - crystal flash
$92:D786             dx 9FE680,0040,0040
$92:D78D             dx 9FE700,0100,0100
$92:D794             dx 9FE900,0100,0100
}


;;; $D79B: Samus bottom tiles - 9 ;;;
{
; 1Bh: Facing right - space jump
; 1Ch: Facing left - space jump
; 81h: Facing right - screw attack
; 82h: Facing left - screw attack
; 83h: Facing right - wall jump
; 84h: Facing left - wall jump
$92:D79B             dx 9CEA80,0100,0100
$92:D7A2             dx 9CEC80,0100,0100
$92:D7A9             dx 9CEE80,0100,0100
$92:D7B0             dx 9CF080,0100,0100
$92:D7B7             dx 9CF280,0100,0100
$92:D7BE             dx 9CF480,0100,0100
$92:D7C5             dx 9CF680,0100,0100
$92:D7CC             dx 9CF880,0100,0100
}
}


;;; $D7D3: Samus spritemaps ;;;
{
$92:D7D3             dx 0002, 01FC,FE,3A25, 01FD,FC,3A43
$92:D7DF             dx 0003, 01FF,FA,3A43, 01FB,F8,BA25, 01FC,FD,3A25
$92:D7F0             dx 0003, 01FA,F6,3A43, 0000,F8,3A25, 01FD,FB,3A25
$92:D801             dx 0003, 0000,F7,3A43, 01FC,FA,3A43, 01FA,F3,3A43
$92:D812             dx 0003, 0000,F3,3A40, 01FA,F1,3A40, 01FC,F8,3A43
$92:D823             dx 0003, 0001,F1,3A40, 01FC,F6,3A40, 01FA,EF,3A40
$92:D834             dx 0003, 0001,EF,7A40, 01FC,F4,3A40, 01F9,EC,3A40
$92:D845             dx 0002, 0002,EC,7A40, 01FC,F0,3A40
$92:D851             dx 0001, 01FC,EC,BA40
$92:D858             dx 0003, C3F8,00,3A9A, 0004,F8,3A5E, 01F4,F8,3A5E
$92:D869             dx 0003, C3F8,04,7A9A, 0002,F8,3ABA, 01F6,F8,3ABA
$92:D87A             dx 0005, C3F8,04,BA9A, 0000,F4,3ABA, 01F8,F3,3ABA, 0000,F8,3ACA, 01F8,F8,3ACA
$92:D895             dx 0005, C3F8,03,3A9C, 0000,F8,3ACA, 0000,F0,3ABA, 01F8,F8,3ACA, 01F8,F0,3ABA
$92:D8B0             dx 0007, C3F8,01,BA9C, 0000,F2,3ABA, 01F8,F1,3ABA, 0000,EB,3AC7, 01F8,EC,3AC7, 0000,F8,3ACA, 01F8,F8,3ACA
$92:D8D5             dx 0005, C3F8,00,7A9C, 0000,EE,3AC7, 01F8,F0,3AC7, 0001,F9,3ABA, 01F7,F8,3ABA
$92:D8F0             dx 0004, 01F8,F2,3AC7, 0000,F2,3AC7, 0002,F8,3A5E, 01F6,F9,3A5E
$92:D906             dx 0002, 0000,F6,3AC7, 01F8,F6,3AC7
$92:D912             dx 0002, 0000,FC,3AC7, 01F8,FA,3AC7
}


;;; $D91E: Samus top half tiles animation - tiles definition pointers ;;;
{
; Indexed by first byte of animation definition
; Pointers to lists of DMA entries, sub-indexed by second byte of animation definition
$92:D91E             dw CBEE, CCCE, CDA0, CE80, CEF7, CF6E, CFE5, D05C, D0E8, D12E, D613, D6A6, D74E
}


;;; $D938: Samus bottom half tiles animation - tiles definition pointers ;;;
{
; Indexed by third byte of animation definition
; Pointers to lists of DMA entries, sub-indexed by fourth byte of animation definition
$92:D938             dw D19E, D27E, D35E, D6D7, D406, D4A7, D54F, D786, D5F0, D79B, D605
}


;;; $D94E: Samus tiles animation - animation definition pointers ;;;
{
; Indexed by [Samus pose]
$92:D94E             dw EA24, DB48, DB6C, E018, E020, E028, E02C, E030, E034, DC48, DC70, DC98, DCC0, DF28, DF50, DF78,
                        DFA0, DFC8, DFF0, DD28, DD30, DD38, DD40, DD18, DD20, E5F8, E628, E658, E688, E508, E558, E580,
                        E5F8, E5F8, E5F8, E5F8, E5F8, E798, E7A4, DE18, DE3C, DE60, DE7C, DE98, DEA4, DEB0, DEB8, E7E0,
                        E7EC, E508, E508, E5F8, E5F8, E4B0, E4B4, E4B8, E4C0, E5F8, E5F8, E4B0, E4B4, E4C8, E4D0, E508,
                        E508, E530, E5F8, E7E0, E7EC, E048, E048, DB48, DB6C, DCE8, DD00, DD78, DD7C, DD98, DDB0, DDC8,
                        DDF0, DD48, DD50, E038, E040, DD80, DD84, DD88, DD8C, DD90, DD94, E048, E04C, E050, E050, E050,
                        E050, E050, E158, E260, E268, E270, E294, DEC0, DEDC, DD58, DD60, DD68, DD70, DEF8, DF04, DF10,
                        DF1C, E430, E434, E438, E43C, E450, E468, E480, E498, E5A8, E5D0, E5A8, E5D0, E5A8, E5D0, E5A8,
                        E5D0, E6B8, E728, E2B8, E374, E440, E448, E7E0, E7EC, DB48, DB6C, E7B0, E7BC, E7C8, E7D4, E7F8,
                        E804, E810, E81C, E7F8, E804, E810, E81C, E7F8, E804, E810, E81C, EBA4, E7B0, E7BC, E7F8, E804,
                        E7F8, E804, E7F8, E804, DB90, DB98, DBA0, DBAC, DB48, DB6C, E030, E034, DD28, DD30, DD18, DD20,
                        DD68, DD70, E050, E158, DE18, DE3C, E438, E43C, E048, E04C, E838, E83C, E840, E844, E860, E798,
                        E7A4, E7B0, E7BC, E7C8, E7D4, E530, E798, DD98, DDB0, E880, E884, E878, E87C, E888, E88C, E028,
                        E02C, E030, E034, E890, E8CC, DBF8, DC0C, E908, E920, DC20, DC34, E4D8, E4E4, E4F0, E4FC, E530,
                        DBB8, DBC0, DBC8, DBD0, DBD8, DBE0, DBE8, DBF0, E938, E974, E9F4, EA0C, E828, E82C, E830, E834,
                        E848, DD80, DD84, DD88, DD8C, DD90, DD94, DD80, DD84, DD88, DD8C, DD90, DD94
}


;;; $DB48: Samus tiles animation - animation definitions ;;;
{
; Animation definitions are indexed by [Samus animation frame]
; First byte indexes the top half tiles definitions pointer table ($D91E) for a pointer to a list of DMA entries that is indexed by the second byte
; Third byte indexes the bottom half tiles definitions pointer table ($D938) for a pointer to a list of DMA entries that is indexed by the fourth byte

; 01: Facing right - normal
; 47: Unused
; 89: Facing right - ran into a wall
; A8: Unused
$92:DB48             db 07,0C,00,06, 07,0D,00,0E, 07,0E,00,0F, 07,0D,00,0E, 00,00,00,00, 07,0C,00,06, 07,0D,00,0E, 07,12,00,0F, 07,0D,00,0E

; 02: Facing left  - normal
; 48: Unused
; 8A: Facing left  - ran into a wall
; A9: Unused
$92:DB6C             db 07,0F,00,06, 07,10,00,10, 07,11,00,1D, 07,10,00,10, 00,00,00,00, 07,0F,00,06, 07,10,00,10, 07,13,00,1D, 07,10,00,10

; A4: Facing right - landing from normal jump
$92:DB90             db 02,00,01,06, 02,04,00,06

; A5: Facing left  - landing from normal jump
$92:DB98             db 02,01,01,07, 02,05,00,06

; A6: Facing right - landing from spin jump
$92:DBA0             db 02,04,01,19, 02,00,01,06, 02,04,00,06

; A7: Facing left  - landing from spin jump
$92:DBAC             db 02,05,01,1A, 02,01,01,07, 02,05,00,06

; E0: Facing right - landing from normal jump - aiming up
$92:DBB8             db 00,16,01,06, 00,16,00,06

; E1: Facing left  - landing from normal jump - aiming up
$92:DBC0             db 00,17,01,07, 00,17,00,06

; E2: Facing right - landing from normal jump - aiming up-right
$92:DBC8             db 00,12,01,06, 00,12,00,06

; E3: Facing left  - landing from normal jump - aiming up-left
$92:DBD0             db 00,13,01,07, 00,13,00,06

; E4: Facing right - landing from normal jump - aiming down-right
$92:DBD8             db 00,0E,01,06, 00,0E,00,06

; E5: Facing left  - landing from normal jump - aiming down-left
$92:DBE0             db 00,0F,01,07, 00,0F,00,06

; E6: Facing right - landing from normal jump - firing
$92:DBE8             db 00,10,01,06, 00,10,00,06

; E7: Facing left  - landing from normal jump - firing
$92:DBF0             db 00,11,01,07, 00,11,00,06

; D5: Facing right - x-ray - standing
$92:DBF8             db 02,09,00,06, 02,08,00,06, 00,10,00,06, 02,0A,00,06, 02,0B,00,06

; D6: Facing left  - x-ray - standing
$92:DC0C             db 02,0D,00,06, 02,0C,00,06, 00,11,00,06, 02,0E,00,06, 02,0F,00,06

; D9: Facing right - x-ray - crouching
$92:DC20             db 02,09,00,07, 02,08,00,07, 00,10,00,07, 02,0A,00,07, 02,0B,00,07

; DA: Facing left  - x-ray - crouching
$92:DC34             db 02,0D,00,07, 02,0C,00,07, 00,11,00,07, 02,0E,00,07, 02,0F,00,07

; 09: Moving right - not aiming
$92:DC48             db 00,00,00,00, 01,0D,00,08, 00,02,00,01, 00,03,00,09, 00,01,00,02, 00,00,00,03, 01,0E,00,0A, 00,05,00,04, 00,18,00,0B, 00,04,00,05

; 0A: Moving left  - not aiming
$92:DC70             db 00,06,00,00, 01,0F,00,08, 00,08,00,01, 00,09,00,09, 00,07,00,02, 00,06,00,03, 01,10,00,0A, 00,0B,00,04, 00,19,00,0B, 00,0A,00,05

; 0B: Moving right - gun extended
$92:DC98             db 09,00,00,00, 09,0E,00,08, 09,02,00,01, 09,03,00,09, 09,01,00,02, 09,00,00,03, 09,04,00,0A, 09,05,00,04, 09,0C,00,0B, 09,04,00,05

; 0C: Moving left  - gun extended
$92:DCC0             db 09,06,00,00, 09,0F,00,08, 09,09,00,01, 09,08,00,09, 09,07,00,02, 09,06,00,03, 09,0A,00,0A, 09,0D,00,04, 09,0B,00,0B, 09,0A,00,05

; 49: Facing left  - moonwalk
$92:DCE8             db 00,11,01,03, 02,1B,01,04, 02,1B,01,15, 00,11,01,00, 02,1B,01,05, 02,1B,01,16

; 4A: Facing right - moonwalk
$92:DD00             db 00,10,01,03, 02,1A,01,04, 02,1A,01,17, 00,10,01,00, 02,1A,01,05, 02,1A,01,18

; 17: Facing right - normal jump - aiming down
; AE: Unused
$92:DD18             db 00,0C,01,0A, 01,1A,01,11

; 18: Facing left  - normal jump - aiming down
; AF: Unused
$92:DD20             db 00,0D,01,0B, 01,1B,01,12

; 13: Facing right - normal jump - not aiming - not moving - gun extended
; AC: Unused
$92:DD28             db 00,10,01,0A, 00,10,01,19

; 14: Facing left  - normal jump - not aiming - not moving - gun extended
; AD: Unused
$92:DD30             db 00,11,01,0B, 00,11,01,1A

; 15: Facing right - normal jump - aiming up
$92:DD38             db 00,12,01,0A, 00,16,00,13

; 16: Facing left  - normal jump - aiming up
$92:DD40             db 00,13,01,0B, 00,17,00,14

; 51: Facing right - normal jump - not aiming - moving forward
$92:DD48             db 00,10,01,0A, 00,10,01,19

; 52: Facing left  - normal jump - not aiming - moving forward
$92:DD50             db 00,11,01,0B, 00,11,01,1A

; 69: Facing right - normal jump - aiming up-right
$92:DD58             db 00,1A,01,0A, 00,1A,00,13

; 6A: Facing left  - normal jump - aiming up-left
$92:DD60             db 00,1B,01,0B, 00,1B,00,14

; 6B: Facing right - normal jump - aiming down-right
; B0: Unused
$92:DD68             db 00,0C,01,0A, 00,0C,01,19

; 6C: Facing left  - normal jump - aiming down-left
; B1: Unused
$92:DD70             db 00,0D,01,0B, 00,0D,01,1A

; 4B: Facing right - normal jump transition
$92:DD78             db 02,00,01,06

; 4C: Facing left  - normal jump transition
$92:DD7C             db 02,01,01,07

; 55: Facing right - normal jump transition - aiming up
; F1: Facing right - crouching transition - aiming up
; F7: Facing right - standing transition - aiming up
$92:DD80             db 00,16,01,06

; 56: Facing left  - normal jump transition - aiming up
; F2: Facing left  - crouching transition - aiming up
; F8: Facing left  - standing transition - aiming up
$92:DD84             db 00,17,01,07

; 57: Facing right - normal jump transition - aiming up-right
; F3: Facing right - crouching transition - aiming up-right
; F9: Facing right - standing transition - aiming up-right
$92:DD88             db 00,12,01,06

; 58: Facing left  - normal jump transition - aiming up-left
; F4: Facing left  - crouching transition - aiming up-left
; FA: Facing left  - standing transition - aiming up-left
$92:DD8C             db 00,13,01,07

; 59: Facing right - normal jump transition - aiming down-right
; F5: Facing right - crouching transition - aiming down-right
; FB: Facing right - standing transition - aiming down-right
$92:DD90             db 00,0E,01,06

; 5A: Facing left  - normal jump transition - aiming down-left
; F6: Facing left  - crouching transition - aiming down-left
; FC: Facing left  - standing transition - aiming down-left
$92:DD94             db 00,0F,01,07

; 4D: Facing right - normal jump - not aiming - not moving - gun not extended
; C7: Facing right - vertical shinespark windup
$92:DD98             db 00,04,00,03, 00,05,01,0E, 00,04,01,08, 00,00,01,08, 00,01,01,0A, 00,14,01,0C

; 4E: Facing left  - normal jump - not aiming - not moving - gun not extended
; C8: Facing left  - vertical shinespark windup
$92:DDB0             db 00,0A,00,03, 00,0B,01,0F, 00,0A,01,09, 00,06,01,09, 00,07,01,0B, 00,15,01,0D

; 4F: Facing left  - damage boost
$92:DDC8             db 02,05,00,11, 02,05,01,0B, 0A,0F,00,00, 0A,0E,00,00, 0A,0D,00,00, 0A,0C,00,00, 0A,0B,00,00, 0A,0A,00,00, 0A,09,00,00, 02,1F,01,1A

; 50: Facing right - damage boost
$92:DDF0             db 02,04,00,12, 02,04,01,0A, 0A,0F,00,00, 0A,0E,00,00, 0A,0D,00,00, 0A,0C,00,00, 0A,0B,00,00, 0A,0A,00,00, 0A,09,00,00, 02,1D,01,19

; 27: Facing right - crouching
; B4: Unused
$92:DE18             db 07,0C,00,07, 07,0D,00,07, 07,0E,00,07, 07,0D,00,07, 00,00,00,00, 07,0C,00,07, 07,0D,00,07, 07,12,00,07, 07,0D,00,07

; 28: Facing left  - crouching
; B5: Unused
$92:DE3C             db 07,0F,00,07, 07,10,00,07, 07,11,00,07, 07,10,00,07, 00,00,00,00, 07,0F,00,07, 07,10,00,07, 07,13,00,07, 07,10,00,07

; 29: Facing right - falling
$92:DE60             db 02,04,01,0A, 02,1C,01,0C, 02,1D,01,0C, 00,00,00,00, 00,00,00,00, 02,1C,01,0A, 02,04,01,19

; 2A: Facing left  - falling
$92:DE7C             db 02,05,01,0B, 02,1E,01,0D, 02,1F,01,0D, 00,00,00,00, 00,00,00,00, 02,1E,01,0B, 02,05,01,1A

; 2B: Facing right - falling - aiming up
$92:DE98             db 00,12,01,0A, 00,16,01,0C, 00,16,01,19

; 2C: Facing left  - falling - aiming up
$92:DEA4             db 00,13,01,0B, 00,17,01,0D, 00,17,01,1A

; 2D: Facing right - falling - aiming down
$92:DEB0             db 00,0C,01,0A, 01,1A,01,11

; 2E: Facing left  - falling - aiming down
$92:DEB8             db 00,0D,01,0B, 01,1B,01,12

; 67: Facing right - falling - gun extended
$92:DEC0             db 00,10,01,0A, 00,10,01,0C, 00,10,01,0C, 00,00,00,00, 00,00,00,00, 00,10,01,0A, 00,10,01,19

; 68: Facing left  - falling - gun extended
$92:DEDC             db 00,11,01,0B, 00,11,01,0D, 00,11,01,0D, 00,00,00,00, 00,00,00,00, 00,11,01,0B, 00,11,01,1A

; 6D: Facing right - falling - aiming up-right
$92:DEF8             db 00,1A,01,0A, 00,1A,01,0C, 00,1A,01,19

; 6E: Facing left  - falling - aiming up-left
$92:DF04             db 00,1B,01,0B, 00,1B,01,0D, 00,1B,01,1A

; 6F: Facing right - falling - aiming down-right
$92:DF10             db 00,0C,01,0A, 00,0C,01,0C, 00,0C,01,19

; 70: Facing left  - falling - aiming down-left
$92:DF1C             db 00,0D,01,0B, 00,0D,01,0D, 00,0D,01,1A

; 0D: Moving right - aiming up (unused)
$92:DF28             db 00,16,00,00, 00,16,00,08, 02,0E,00,01, 02,1E,00,09, 02,0E,00,02, 00,16,00,03, 00,16,00,0A, 02,0E,00,04, 02,1E,00,0B, 02,0E,00,05

; 0E: Moving left  - aiming up (unused)
$92:DF50             db 00,17,00,00, 00,17,00,08, 02,0F,00,01, 02,1F,00,09, 02,0F,00,02, 00,17,00,03, 00,17,00,0A, 02,0F,00,04, 02,1F,00,0B, 02,0F,00,05

; 0F: Moving right - aiming up-right
$92:DF78             db 00,1A,00,00, 00,1A,00,08, 02,10,00,01, 02,16,00,09, 02,10,00,02, 00,1A,00,03, 00,1A,00,0A, 02,10,00,04, 02,16,00,0B, 02,10,00,05

; 10: Moving left  - aiming up-left
$92:DFA0             db 00,1B,00,00, 00,1B,00,08, 02,11,00,01, 02,17,00,09, 02,11,00,02, 00,1B,00,03, 00,1B,00,0A, 02,11,00,04, 02,17,00,0B, 02,11,00,05

; 11: Moving right - aiming down-right
$92:DFC8             db 00,0C,00,00, 00,0C,00,08, 02,06,00,01, 02,18,00,09, 02,06,00,02, 00,0C,00,03, 00,0C,00,0A, 02,06,00,04, 02,18,00,0B, 02,06,00,05

; 12: Moving left  - aiming down-left
$92:DFF0             db 00,0D,00,00, 00,0D,00,08, 02,07,00,01, 02,19,00,09, 02,07,00,02, 00,0D,00,03, 00,0D,00,0A, 02,07,00,04, 02,19,00,0B, 02,07,00,05

; 03: Facing right - aiming up
$92:E018             db 00,12,0A,00, 00,16,0A,00

; 04: Facing left  - aiming up
$92:E020             db 00,13,0A,01, 00,17,0A,01

; 05: Facing right - aiming up-right
; CF: Facing right - ran into a wall - aiming up-right
$92:E028             db 00,12,0A,00

; 06: Facing left  - aiming up-left
; D0: Facing left  - ran into a wall - aiming up-left
$92:E02C             db 00,13,0A,01

; 07: Facing right - aiming down-right
; AA: Unused
; D1: Facing right - ran into a wall - aiming down-right
$92:E030             db 00,0E,0A,00

; 08: Facing left  - aiming down-left
; AB: Unused
; D2: Facing left  - ran into a wall - aiming down-left
$92:E034             db 00,0F,0A,01

; 53: Facing right - knockback
$92:E038             db 00,1D,01,0C, 00,1D,01,1B

; 54: Facing left  - knockback
$92:E040             db 00,1C,01,0D, 00,1C,01,1C

; 45: Unused
; 46: Unused
; 5B: Unused
; B8: Facing left  - grapple wall jump pose
$92:E048             db 01,0C,00,1A

; 5C: Unused
; B9: Facing right - grapple wall jump pose
$92:E04C             db 01,0B,00,19

; 5D: Unused
; 5E: Unused
; 5F: Unused
; 60: Unused
; 61: Unused
; B2: Facing clockwise     - grapple
$92:E050             db 05,08,04,05, 05,07,04,04, 05,06,04,03, 05,05,04,02, 05,04,04,02, 05,03,04,01, 05,02,04,01, 05,01,04,00, 05,00,04,00, 03,0F,04,00, 03,0E,02,09, 03,0D,02,09, 03,0C,02,08, 03,0B,02,08, 03,0A,02,07, 03,09,02,06, 03,08,02,05, 03,07,02,04, 03,06,02,03, 03,05,02,02, 03,04,02,02, 03,03,02,01, 03,02,02,01, 03,01,02,00, 03,00,02,00, 05,0F,02,00, 05,0E,04,09, 05,0D,04,09, 05,0C,04,08, 05,0B,04,08, 05,0A,04,07, 05,09,04,06, 05,08,04,12, 05,07,04,11, 05,06,04,10, 05,05,04,0F, 05,04,04,0F, 05,03,04,0E, 05,02,04,0E, 05,01,04,0D, 05,00,04,0D, 03,0F,04,0D, 03,0E,02,16, 03,0D,02,16, 03,0C,02,15, 03,0B,02,15, 03,0A,02,14, 03,09,02,13, 03,08,02,12, 03,07,02,11, 03,06,02,10, 03,05,02,0F, 03,04,02,0F, 03,03,02,0E, 03,02,02,0E, 03,01,02,0D, 03,00,02,0D, 05,0F,02,0D, 05,0E,04,15, 05,0D,04,15, 05,0C,04,14, 05,0B,04,14, 05,0A,04,13, 05,09,04,12, 03,08,02,0B, 03,08,02,0C

; 62: Unused
; B3: Facing anticlockwise - grapple
$92:E158             db 06,08,06,05, 06,09,06,06, 06,0A,06,07, 06,0B,06,08, 06,0C,06,08, 06,0D,06,09, 06,0E,06,09, 06,0F,05,00, 04,00,05,00, 04,01,05,00, 04,02,05,01, 04,03,05,01, 04,04,05,02, 04,05,05,02, 04,06,05,03, 04,07,05,04, 04,08,05,05, 04,09,05,06, 04,0A,05,07, 04,0B,05,08, 04,0C,05,08, 04,0D,05,09, 04,0E,05,09, 04,0F,06,00, 06,00,06,00, 06,01,06,00, 06,02,06,01, 06,03,06,01, 06,04,06,02, 06,05,06,02, 06,06,06,03, 06,07,06,04, 06,08,06,12, 06,09,06,13, 06,0A,06,14, 06,0B,06,15, 06,0C,06,15, 06,0D,06,16, 06,0E,06,16, 06,0F,05,0D, 04,00,05,0D, 04,01,05,0D, 04,02,05,0E, 04,03,05,0E, 04,04,05,0F, 04,05,05,0F, 04,06,05,10, 04,07,05,11, 04,08,05,12, 04,09,05,13, 04,0A,05,14, 04,0B,05,15, 04,0C,05,15, 04,0D,05,16, 04,0E,05,16, 04,0F,06,0D, 06,00,06,0D, 06,01,06,0D, 06,02,06,0E, 06,03,06,0E, 06,04,06,0F, 06,05,06,0F, 06,06,06,10, 06,07,06,11, 04,08,05,0B, 04,08,05,0C

; 63: Unused
$92:E260             db 01,14,01,15, 01,0C,00,1A

; 64: Unused
$92:E268             db 01,15,01,16, 01,0B,00,19

; 65: Unused
$92:E270             db 01,12,01,13, 0A,10,00,00, 0A,11,00,00, 0A,12,00,00, 0A,13,00,00, 0A,14,00,00, 0A,15,00,00, 0A,16,00,00, 0A,17,00,00

; 66: Unused
$92:E294             db 01,13,01,14, 0A,10,00,00, 0A,11,00,00, 0A,12,00,00, 0A,13,00,00, 0A,14,00,00, 0A,15,00,00, 0A,16,00,00, 0A,17,00,00

; 83: Facing right - wall jump
$92:E2B8             db 01,12,01,13, 02,04,01,19, 00,00,00,00, 0A,08,00,00, 0A,09,00,00, 0A,0A,00,00, 0A,0B,00,00, 0A,0C,00,00, 0A,0D,00,00, 0A,0E,00,00, 0A,0F,00,00, 00,00,00,00, 00,00,00,00, 0A,14,09,00, 0A,14,09,01, 0A,14,09,02, 0A,14,09,03, 0A,14,09,04, 0A,14,09,05, 0A,14,09,06, 0A,14,09,07, 00,00,00,00, 00,00,00,00, 0A,10,09,00, 0A,10,09,01, 0A,10,09,02, 0A,14,09,03, 0A,14,09,04, 0A,14,09,05, 0A,11,09,06, 0A,11,09,07, 0A,11,09,00, 0A,14,09,01, 0A,14,09,02, 0A,14,09,03, 0A,12,09,04, 0A,12,09,05, 0A,12,09,06, 0A,14,09,07, 0A,14,09,00, 0A,14,09,01, 0A,13,09,02, 0A,13,09,03, 0A,13,09,04, 0A,14,09,05, 0A,14,09,06, 0A,14,09,07

; 84: Facing left  - wall jump
$92:E374             db 01,13,01,14, 02,05,01,1A, 00,00,00,00, 0A,08,00,00, 0A,09,00,00, 0A,0A,00,00, 0A,0B,00,00, 0A,0C,00,00, 0A,0D,00,00, 0A,0E,00,00, 0A,0F,00,00, 00,00,00,00, 00,00,00,00, 0A,14,09,00, 0A,14,09,01, 0A,14,09,02, 0A,14,09,03, 0A,14,09,04, 0A,14,09,05, 0A,14,09,06, 0A,14,09,07, 00,00,00,00, 00,00,00,00, 0A,10,09,00, 0A,10,09,01, 0A,10,09,02, 0A,14,09,03, 0A,14,09,04, 0A,14,09,05, 0A,11,09,06, 0A,11,09,07, 0A,11,09,00, 0A,14,09,01, 0A,14,09,02, 0A,14,09,03, 0A,12,09,04, 0A,12,09,05, 0A,12,09,06, 0A,14,09,07, 0A,14,09,00, 0A,14,09,01, 0A,13,09,02, 0A,13,09,03, 0A,13,09,04, 0A,14,09,05, 0A,14,09,06, 0A,14,09,07

; 71: Facing right - crouching - aiming up-right
$92:E430             db 00,12,00,07

; 72: Facing left  - crouching - aiming up-left
$92:E434             db 00,13,00,07

; 73: Facing right - crouching - aiming down-right
; B6: Unused
$92:E438             db 00,0E,00,07

; 74: Facing left  - crouching - aiming down-left
; B7: Unused
$92:E43C             db 00,0F,00,07

; 85: Facing right - crouching - aiming up
$92:E440             db 00,12,00,07, 00,16,00,07

; 86: Facing left  - crouching - aiming up
$92:E448             db 00,13,00,07, 00,17,00,07

; 75: Facing left  - moonwalk - aiming up-left
$92:E450             db 00,1B,01,03, 02,11,01,04, 02,11,01,17, 00,1B,01,00, 02,11,01,05, 02,11,01,18

; 76: Facing right - moonwalk - aiming up-right
$92:E468             db 00,1A,01,03, 02,10,01,04, 02,10,01,17, 00,1A,01,00, 02,10,01,05, 02,10,01,18

; 77: Facing left  - moonwalk - aiming down-left
$92:E480             db 00,0D,01,03, 02,07,01,04, 02,07,01,17, 00,0D,01,00, 02,07,01,05, 02,07,01,18

; 78: Facing right - moonwalk - aiming down-right
$92:E498             db 00,0C,01,03, 02,06,01,04, 02,06,01,17, 00,0C,01,00, 02,06,01,05, 02,06,01,18

; 35: Facing right - crouching transition
; 3B: Facing right - standing transition
$92:E4B0             db 00,10,01,06

; 36: Facing left  - crouching transition
; 3C: Facing left  - standing transition
$92:E4B4             db 00,11,01,07

; 37: Facing right - morphing transition
$92:E4B8             db 0B,06,00,00, 0B,05,00,00

; 38: Facing left  - morphing transition
$92:E4C0             db 0B,04,00,00, 0B,03,00,00

; 3D: Facing right - unmorphing transition
$92:E4C8             db 0B,05,00,00, 0B,06,00,00

; 3E: Facing left  - unmorphing transition
$92:E4D0             db 0B,03,00,00, 0B,04,00,00

; DB: Unused
$92:E4D8             db 00,10,01,06, 0B,06,00,00, 0B,05,00,00

; DC: Unused
$92:E4E4             db 00,11,01,06, 0B,04,00,00, 0B,03,00,00

; DD: Unused
$92:E4F0             db 0B,05,00,00, 0B,06,00,00, 00,10,01,06

; DE: Unused
$92:E4FC             db 0B,03,00,00, 0B,04,00,00, 00,11,01,06

; 1D: Facing right - morph ball - no springball - on ground
; 31: Facing right - morph ball - no springball - in air
; 32: Facing left  - morph ball - no springball - in air
; 3F: Unused
; 40: Unused
$92:E508             db 0A,00,00,00, 0A,04,00,00, 0A,01,00,00, 0A,05,00,00, 0A,02,00,00, 0A,06,00,00, 0A,03,00,00, 0A,07,00,00, 00,00,00,00, 0B,01,00,00

; 41: Facing left  - morph ball - no springball - on ground
; C5: Unused
; DF: Unused
$92:E530             db 0A,07,00,00, 0A,03,00,00, 0A,06,00,00, 0A,02,00,00, 0A,05,00,00, 0A,01,00,00, 0A,04,00,00, 0A,00,00,00, 00,00,00,00, 0B,01,00,00

; 1E: Moving right - morph ball - no springball - on ground
$92:E558             db 0A,00,00,00, 0A,04,00,00, 0A,01,00,00, 0A,05,00,00, 0A,02,00,00, 0A,06,00,00, 0A,03,00,00, 0A,07,00,00, 00,00,00,00, 0B,01,00,00

; 1F: Moving left  - morph ball - no springball - on ground
$92:E580             db 0A,07,00,00, 0A,03,00,00, 0A,06,00,00, 0A,02,00,00, 0A,05,00,00, 0A,01,00,00, 0A,04,00,00, 0A,00,00,00, 00,00,00,00, 0B,01,00,00

; 79: Facing right - morph ball - spring ball - on ground
; 7B: Moving right - morph ball - spring ball - on ground
; 7D: Facing right - morph ball - spring ball - falling
; 7F: Facing right - morph ball - spring ball - in air
$92:E5A8             db 0A,00,00,00, 0A,04,00,00, 0A,01,00,00, 0A,05,00,00, 0A,02,00,00, 0A,06,00,00, 0A,03,00,00, 0A,07,00,00, 00,00,00,00, 0B,01,00,00

; 7A: Facing left  - morph ball - spring ball - on ground
; 7C: Moving left  - morph ball - spring ball - on ground
; 7E: Facing left  - morph ball - spring ball - falling
; 80: Facing left  - morph ball - spring ball - in air
$92:E5D0             db 0A,07,00,00, 0A,03,00,00, 0A,06,00,00, 0A,02,00,00, 0A,05,00,00, 0A,01,00,00, 0A,04,00,00, 0A,00,00,00, 00,00,00,00, 0B,01,00,00

; 19: Facing right - spin jump
; 20: Unused
; 21: Unused
; 22: Unused
; 23: Unused
; 24: Unused
; 33: Unused
; 34: Unused
; 39: Unused
; 3A: Unused
; 42: Unused
$92:E5F8             db 02,04,01,19, 0A,08,00,00, 0A,09,00,00, 0A,0A,00,00, 0A,0B,00,00, 0A,0C,00,00, 0A,0D,00,00, 0A,0E,00,00, 0A,0F,00,00, 00,00,00,00, 00,00,00,00, 01,1C,00,1E

; 1A: Facing left  - spin jump
$92:E628             db 02,05,01,1A, 0A,08,00,00, 0A,09,00,00, 0A,0A,00,00, 0A,0B,00,00, 0A,0C,00,00, 0A,0D,00,00, 0A,0E,00,00, 0A,0F,00,00, 00,00,00,00, 00,00,00,00, 01,1D,00,1F

; 1B: Facing right - space jump
$92:E658             db 02,04,01,19, 0A,14,09,00, 0A,14,09,01, 0A,14,09,02, 0A,14,09,03, 0A,14,09,04, 0A,14,09,05, 0A,14,09,06, 0A,14,09,07, 00,00,00,00, 00,00,00,00, 01,1C,00,1E

; 1C: Facing left  - space jump
$92:E688             db 02,05,01,1A, 0A,14,09,00, 0A,14,09,01, 0A,14,09,02, 0A,14,09,03, 0A,14,09,04, 0A,14,09,05, 0A,14,09,06, 0A,14,09,07, 00,00,00,00, 00,00,00,00, 01,1D,00,1F

; 81: Facing right - screw attack
$92:E6B8             db 02,04,01,19, 0A,10,09,00, 0A,10,09,01, 0A,10,09,02, 0A,14,09,03, 0A,14,09,04, 0A,14,09,05, 0A,11,09,06, 0A,11,09,07, 0A,11,09,00, 0A,14,09,01, 0A,14,09,02, 0A,14,09,03, 0A,12,09,04, 0A,12,09,05, 0A,12,09,06, 0A,14,09,07, 0A,14,09,00, 0A,14,09,01, 0A,13,09,02, 0A,13,09,03, 0A,13,09,04, 0A,14,09,05, 0A,14,09,06, 0A,14,09,07, 00,00,00,00, 00,00,00,00, 01,1C,00,1E

; 82: Facing left  - screw attack
$92:E728             db 02,05,01,1A, 0A,10,09,00, 0A,10,09,01, 0A,10,09,02, 0A,14,09,03, 0A,14,09,04, 0A,14,09,05, 0A,11,09,06, 0A,11,09,07, 0A,11,09,00, 0A,14,09,01, 0A,14,09,02, 0A,14,09,03, 0A,12,09,04, 0A,12,09,05, 0A,12,09,06, 0A,14,09,07, 0A,14,09,00, 0A,14,09,01, 0A,13,09,02, 0A,13,09,03, 0A,13,09,04, 0A,14,09,05, 0A,14,09,06, 0A,14,09,07, 00,00,00,00, 00,00,00,00, 01,1D,00,1F

; 25: Facing right - turning - standing
; BF: Facing right - moonwalking - turn/jump left
; C6: Unused
$92:E798             db 01,07,00,16, 01,0A,01,01, 01,06,00,15

; 26: Facing left  - turning - standing
; C0: Facing left  - moonwalking - turn/jump right
$92:E7A4             db 01,06,00,15, 01,0A,01,01, 01,07,00,16

; 8B: Facing right - turning - standing - aiming up
; 9C: Facing right - turning - standing - aiming up-right
; C1: Facing right - moonwalking - turn/jump left  - aiming up-right
$92:E7B0             db 01,09,00,16, 01,02,01,01, 01,08,00,15

; 8C: Facing left  - turning - standing - aiming up
; 9D: Facing left  - turning - standing - aiming up-left
; C2: Facing left  - moonwalking - turn/jump right - aiming up-left
$92:E7BC             db 01,08,00,15, 01,02,01,01, 01,09,00,16

; 8D: Facing right - turning - standing - aiming down-right
; C3: Facing right - moonwalking - turn/jump left  - aiming down-right
$92:E7C8             db 01,19,00,16, 01,03,01,01, 01,18,00,15

; 8E: Facing left  - turning - standing - aiming down-left
; C4: Facing left  - moonwalking - turn/jump right - aiming down-left
$92:E7D4             db 01,18,00,15, 01,03,01,01, 01,19,00,16

; 2F: Facing right - turning - jumping
; 43: Facing right - turning - crouching
; 87: Facing right - turning - falling
$92:E7E0             db 01,07,00,18, 01,0A,01,02, 01,06,00,17

; 30: Facing left  - turning - jumping
; 44: Facing left  - turning - crouching
; 88: Facing left  - turning - falling
$92:E7EC             db 01,06,00,17, 01,0A,01,02, 01,07,00,18

; 8F: Facing right - turning - in air - aiming up
; 93: Facing right - turning - falling - aiming up
; 97: Facing right - turning - crouching - aiming up
; 9E: Facing right - turning - in air - aiming up-right
; A0: Facing right - turning - falling - aiming up-right
; A2: Facing right - turning - crouching - aiming up-right
$92:E7F8             db 01,09,00,18, 01,02,01,02, 01,08,00,17

; 90: Facing left  - turning - in air - aiming up
; 94: Facing left  - turning - falling - aiming up
; 98: Facing left  - turning - crouching - aiming up
; 9F: Facing left  - turning - in air - aiming up-left
; A1: Facing left  - turning - falling - aiming up-left
; A3: Facing left  - turning - crouching - aiming up-left
$92:E804             db 01,08,00,17, 01,02,01,02, 01,09,00,18

; 91: Facing right - turning - in air - aiming down/down-right
; 95: Facing right - turning - falling - aiming down/down-right
; 99: Facing right - turning - crouching - aiming down/down-right
$92:E810             db 01,19,00,18, 01,03,01,02, 01,18,00,17

; 92: Facing left  - turning - in air - aiming down/down-left
; 96: Facing left  - turning - falling - aiming down/down-left
; 9A: Facing left  - turning - crouching - aiming down/down-left
$92:E81C             db 01,18,00,17, 01,03,01,02, 01,19,00,18

; EC: Facing right - grabbed by Draygon - not moving - not aiming
$92:E828             db 02,04,01,1B

; ED: Facing right - grabbed by Draygon - not moving - aiming up-right
$92:E82C             db 00,1A,01,1B

; EE: Facing right - grabbed by Draygon - firing
$92:E830             db 00,10,01,1B

; EF: Facing right - grabbed by Draygon - not moving - aiming down-right
$92:E834             db 00,0C,01,1B

; BA: Facing left  - grabbed by Draygon - not moving - not aiming
$92:E838             db 02,05,01,1C

; BB: Facing left  - grabbed by Draygon - not moving - aiming up-left
$92:E83C             db 00,1B,01,1C

; BC: Facing left  - grabbed by Draygon - firing
$92:E840             db 00,11,01,1C

; BD: Facing left  - grabbed by Draygon - not moving - aiming down-left
$92:E844             db 00,0D,01,1C

; F0: Facing right - grabbed by Draygon - moving
$92:E848             db 00,01,01,0C, 00,02,01,1B, 00,00,01,19, 00,04,01,0C, 00,05,01,0E, 00,00,01,08

; BE: Facing left  - grabbed by Draygon - moving
$92:E860             db 00,07,01,0D, 00,08,01,1C, 00,06,01,1A, 00,0A,01,0D, 00,0B,01,0F, 00,06,01,09

; CB: Facing right - shinespark - vertical
$92:E878             db 0C,00,00,00

; CC: Facing left  - shinespark - vertical
$92:E87C             db 0C,01,00,00

; C9: Facing right - shinespark - horizontal
$92:E880             db 01,14,00,1B

; CA: Facing left  - shinespark - horizontal
$92:E884             db 01,15,00,1C

; CD: Facing right - shinespark - diagonal
$92:E888             db 01,14,00,1B

; CE: Facing left  - shinespark - diagonal
$92:E88C             db 01,15,00,1C

; D3: Facing right - crystal flash
$92:E890             db 0B,05,07,00, 0B,06,07,01, 0C,05,07,02, 0B,06,07,02, 00,00,00,00, 00,00,00,00, 0C,05,07,02, 0C,06,07,02, 0C,07,07,02, 0C,06,07,02, 00,00,00,00, 00,00,00,00, 0B,06,07,01, 0B,06,07,00, 00,10,01,06

; D4: Facing left  - crystal flash
$92:E8CC             db 0B,03,07,00, 0B,04,07,01, 0C,02,07,02, 0B,04,07,02, 00,00,00,00, 00,00,00,00, 0C,02,07,02, 0C,03,07,02, 0C,04,07,02, 0C,03,07,02, 00,00,00,00, 00,00,00,00, 0B,04,07,01, 0B,04,07,00, 00,11,01,07

; D7: Facing right - crystal flash ending
$92:E908             db 0A,00,01,06, 0B,05,01,06, 0B,06,01,06, 00,10,01,06, 00,1D,01,0C, 00,1D,01,1B

; D8: Facing left  - crystal flash ending
$92:E920             db 0A,1F,01,06, 0B,03,01,06, 0B,04,01,06, 00,11,01,07, 00,1C,01,0D, 00,1C,01,1C

; E8: Facing right - Samus drained - crouching
$92:E938             db 0A,00,01,06, 0B,05,01,06, 0B,06,01,06, 00,1D,01,0C, 00,1D,01,0C, 00,1D,01,0C, 00,1D,01,0C, 00,1D,01,0C, 07,03,01,1F, 07,04,01,1F, 07,05,01,1F, 07,04,01,1F, 00,00,00,00, 00,00,00,00, 00,10,01,06

; E9: Facing left  - Samus drained - crouching
$92:E974             db 0B,03,01,06, 0B,04,01,06, 00,1C,01,0D, 00,1C,01,0D, 00,1C,01,0D, 00,1C,01,0D, 00,1C,01,0D, 07,01,01,07, 07,00,01,1E, 07,01,01,1E, 07,02,01,1E, 07,01,01,1E, 00,00,00,00, 00,00,00,00, 07,01,01,1A, 07,07,01,07, 02,03,0A,01, 00,00,00,00, 00,00,00,00, 07,01,01,1A, 07,07,01,07, 02,03,0A,01, 07,07,01,07, 07,01,01,1A, 00,00,00,00, 00,00,00,00, 07,00,01,1E, 00,00,00,00, 00,00,00,00, 07,00,01,1E, 00,00,00,00, 00,00,00,00

; EA: Facing right - Samus drained - standing
$92:E9F4             db 07,09,01,1F, 07,0A,01,1F, 07,0B,01,1F, 07,0A,01,1F, 00,00,00,00, 00,10,01,06

; EB: Facing left  - Samus drained - standing
$92:EA0C             db 07,06,01,1E, 07,07,01,1E, 07,08,01,1E, 07,07,01,1E, 00,00,00,00, 00,11,01,07

; 00: Facing forward - power suit
$92:EA24             db 01,11,00,0C, 00,00,00,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,02,08,00, 08,00,08,00, 08,03,08,00, 08,00,08,00, 08,04,08,00, 08,00,08,00, 08,05,08,00, 08,00,08,00, 08,06,08,00, 08,00,08,00, 08,07,08,00, 08,00,08,00, 08,08,08,00, 08,00,08,00, 08,09,08,00, 08,00,08,00, 08,07,08,00, 08,00,08,00, 08,08,08,00, 08,00,08,00, 08,09,08,00, 08,00,08,00

; 9B: Facing forward - varia/gravity suit
$92:EBA4             db 01,05,00,0D, 00,00,00,00, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,02,08,01, 08,00,08,01, 08,03,08,01, 08,00,08,01, 08,04,08,01, 08,00,08,01, 08,05,08,01, 08,00,08,01, 08,06,08,01, 08,00,08,01, 08,07,08,01, 08,00,08,01, 08,08,08,01, 08,00,08,01, 08,09,08,01, 08,00,08,01, 08,07,08,01, 08,00,08,01, 08,08,08,01, 08,00,08,01, 08,09,08,01, 08,00,08,01
}


;;; $ED24: Play Samus fanfare ;;;
{
;; Returns:
;;     Carry: set if finished fanfare, else clear
$92:ED24 08          PHP
$92:ED25 8B          PHB
$92:ED26 4B          PHK                    ;\
$92:ED27 AB          PLB                    ;} DB = $92
$92:ED28 C2 30       REP #$30
$92:ED2A AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$92:ED2D D0 0C       BNE $0C    [$ED3B]     ;} If [$0DEC] = 0:
$92:ED2F A9 01 00    LDA #$0001             ;\
$92:ED32 A0 0E 00    LDY #$000E             ;} Queue Samus fanfare music track, 14 frame delay
$92:ED35 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/
$92:ED39 80 0E       BRA $0E    [$ED49]

$92:ED3B C9 05 00    CMP #$0005             ;\ Else ([$0DEC] != 0):
$92:ED3E D0 09       BNE $09    [$ED49]     ;} If [$0DEC] = 5:
$92:ED40 A9 68 01    LDA #$0168             ;\
$92:ED43 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$92:ED47 80 00       BRA $00    [$ED49]

$92:ED49 AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$92:ED4C 1A          INC A                  ;|
$92:ED4D C9 68 01    CMP #$0168             ;} If [$0DEC] + 1 < 360:
$92:ED50 10 05       BPL $05    [$ED57]     ;/
$92:ED52 8D EC 0D    STA $0DEC  [$7E:0DEC]  ; Increment $0DEC
$92:ED55 80 1F       BRA $1F    [$ED76]     ; Return carry clear

$92:ED57 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$92:ED5A 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$92:ED5D AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$92:ED60 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$92:ED63 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$92:ED66 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$92:ED69 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$92:ED6C 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$92:ED6F 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; $0DEC = 0
$92:ED72 AB          PLB
$92:ED73 28          PLP
$92:ED74 38          SEC                    ;\
$92:ED75 6B          RTL                    ;} Return carry set

$92:ED76 AB          PLB
$92:ED77 28          PLP
$92:ED78 18          CLC
$92:ED79 6B          RTL
}


;;; $ED7A: Debug. Samus tile viewer ;;;
{
$92:ED7A 08          PHP
$92:ED7B 8B          PHB
$92:ED7C 4B          PHK                    ;\
$92:ED7D AB          PLB                    ;} DB = $92
$92:ED7E C2 30       REP #$30
$92:ED80 A9 82 01    LDA #$0182             ;\
$92:ED83 A2 40 00    LDX #$0040             ;|
$92:ED86 A0 40 00    LDY #$0040             ;} Add Samus spritemap 182h (Samus top half tiles) to OAM at position (40h, 40h)
$92:ED89 22 AE 89 81 JSL $8189AE[$81:89AE]  ;/
$92:ED8D A9 82 01    LDA #$0182             ;\
$92:ED90 1A          INC A                  ;|
$92:ED91 A2 C0 00    LDX #$00C0             ;} Add Samus spritemap 183h (Samus bottom half tiles) to OAM at position (C0h, 40h)
$92:ED94 A0 40 00    LDY #$0040             ;|
$92:ED97 22 AE 89 81 JSL $8189AE[$81:89AE]  ;/
$92:ED9B A9 82 01    LDA #$0182             ;\
$92:ED9E 1A          INC A                  ;|
$92:ED9F 1A          INC A                  ;|
$92:EDA0 A2 80 00    LDX #$0080             ;} Add Samus spritemap 184h (beam tiles) to OAM at position (80h, 60h)
$92:EDA3 A0 60 00    LDY #$0060             ;|
$92:EDA6 22 AE 89 81 JSL $8189AE[$81:89AE]  ;/
$92:EDAA A9 82 01    LDA #$0182             ;\
$92:EDAD 18          CLC                    ;|
$92:EDAE 69 03 00    ADC #$0003             ;|
$92:EDB1 A2 80 00    LDX #$0080             ;} Add Samus spritemap 185h (grapple beam tiles) to OAM at position (80h, 50h)
$92:EDB4 A0 50 00    LDY #$0050             ;|
$92:EDB7 22 AE 89 81 JSL $8189AE[$81:89AE]  ;/
$92:EDBB AB          PLB
$92:EDBC 28          PLP
$92:EDBD 6B          RTL
}


;;; $EDBE: Draw Samus' suit exploding ;;;
{
$92:EDBE 08          PHP
$92:EDBF 8B          PHB
$92:EDC0 4B          PHK                    ;\
$92:EDC1 AB          PLB                    ;} DB = $92
$92:EDC2 C2 30       REP #$30
$92:EDC4 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$92:EDC7 29 FF 00    AND #$00FF             ;|
$92:EDCA C9 04 00    CMP #$0004             ;} If Samus is facing right:
$92:EDCD F0 0B       BEQ $0B    [$EDDA]     ;/
$92:EDCF A9 1C 08    LDA #$081C             ;\
$92:EDD2 18          CLC                    ;|
$92:EDD3 6D E4 0D    ADC $0DE4  [$7E:0DE4]  ;} $12 = 81Ch + [$0DE4]
$92:EDD6 85 12       STA $12    [$7E:0012]  ;/
$92:EDD8 80 09       BRA $09    [$EDE3]

$92:EDDA A9 25 08    LDA #$0825             ;\ Else (Samus is facing left):
$92:EDDD 18          CLC                    ;|
$92:EDDE 6D E4 0D    ADC $0DE4  [$7E:0DE4]  ;} $12 = 825h + [$0DE4]
$92:EDE1 85 12       STA $12    [$7E:0012]  ;/

$92:EDE3 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$92:EDE6 AA          TAX                    ;|
$92:EDE7 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$92:EDEA A8          TAY                    ;} Add Samus spritemap [$12] to OAM at Samus' position
$92:EDEB A5 12       LDA $12    [$7E:0012]  ;|
$92:EDED 22 AE 89 81 JSL $8189AE[$81:89AE]  ;/
$92:EDF1 AB          PLB
$92:EDF2 28          PLP
$92:EDF3 6B          RTL
}


;;; $EDF3: Free space ;;;
{
$92:EDF3             fillto $938000, $FF
}
