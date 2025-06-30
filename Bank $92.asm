;;; $8000: Set Samus tiles definitions for current animation ;;;
{
; $D94E is a table of pointers to animation definition lists
; The table is indexed by Samus pose, the animation definition list is indexed by Samus animation frame
; Animation definitions are 4 bytes
; First byte indexes the top half tiles definitions pointer table ($D91E) for a pointer to a list of DMA entries that is indexed by the second byte
; Third byte indexes the bottom half tiles definitions pointer table ($D938) for a pointer to a list of DMA entries that is indexed by the fourth byte

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
$92:8016 BD 4E D9    LDA $D94E,x[$92:D952]  ;} X = [$D94E + [Samus pose] * 2] + [Samus animation frame] * 4 (animation definition pointer)
$92:8019 18          CLC                    ;|
$92:801A 65 12       ADC $12    [$7E:0012]  ;|
$92:801C AA          TAX                    ;/
$92:801D BD 00 00    LDA $0000,x[$92:DB6C]  ;\
$92:8020 29 FF 00    AND #$00FF             ;|
$92:8023 85 16       STA $16    [$7E:0016]  ;|
$92:8025 0A          ASL A                  ;|
$92:8026 A8          TAY                    ;|
$92:8027 E8          INX                    ;|
$92:8028 BD 00 00    LDA $0000,x[$92:DB6D]  ;|
$92:802B 29 FF 00    AND #$00FF             ;|
$92:802E 8D 24 0B    STA $0B24  [$7E:0B24]  ;|
$92:8031 0A          ASL A                  ;} Samus top half tiles definition = [$D91E + [[X]] * 2] + [[X] + 1] * 7
$92:8032 0A          ASL A                  ;|
$92:8033 0A          ASL A                  ;|
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
$92:805E C9 FF 00    CMP #$00FF             ;} If [[X]] = FFh (this never happens): return
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

; 0. Unused
$92:808D             dw 90ED, 90F4

; 2. Top half - 0: Facing forward - power suit
$92:8091             dw 9A6F, 0000, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C,
                        A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C,
                        A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C,
                        A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C,
                        A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C,
                        A1C7, A12C, A214, A12C, A23E, A12C, A272, A12C, A2AB, A12C, A23E, A12C, A272, A12C, A2AB, A12C

; 62h. Bottom half - 0: Facing forward - power suit
$92:8151             dw AE44, 0000, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E,
                        B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E,
                        B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E,
                        B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E,
                        B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E,
                        B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E, B24E

; C2h. Top half - 9Bh: Facing forward - varia/gravity suit
$92:8211             dw 9976, 0000, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C,
                        A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C,
                        A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C,
                        A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C,
                        A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C, A13A, A12C, A169, A12C, A18E, A12C,
                        A1C7, A12C, A214, A12C, A23E, A12C, A272, A12C, A2AB, A12C, A23E, A12C, A272, A12C, A2AB, A12C

; 122h. Bottom half - 9Bh: Facing forward - varia/gravity suit
$92:82D1             dw AE6E, 0000, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E,
                        B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E,
                        B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E,
                        B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E,
                        B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E,
                        B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E, B26E

; 182h. Debug Samus tile viewer - Samus top half
$92:8391             dw 917A

; 183h. Debug Samus tile viewer - Samus bottom half
$92:8393             dw 91CC

; 184h. Debug Samus tile viewer - beam
$92:8395             dw 921E

; 185h. Debug Samus tile viewer - grapple beam
$92:8397             dw 9248

; 186h. Bubbles. Indexed by [atmospheric graphic animation frame]
$92:8399             dw D7D3, D7DF, D7F0, D801, D812, D823, D834, D845, D851

; 18Fh. Diving splash. Indexed by [atmospheric graphic animation frame]
$92:83AB             dw D858, D869, D87A, D895, D8B0, D8D5, D8F0, D906, D912

; 198h. Unused
$92:83BD             dw 9657, 9657

; 19Ah
; Top half - 1: Facing right - normal
; Top half - 47h: Unused (only frame 0 used)
; Top half - 89h: Facing right - ran into a wall (only frame 0 used)
; Top half - A8h: Facing right - grappling (only frame 0 used)
$92:83C1             dw A072, A088, A09E, A088, 0000, A072, A088, A0F6, A088

; 1A3h
; Top half - 2: Facing left  - normal
; Top half - 48h: Unused (only frame 0 used)
; Top half - 8Ah: Facing left  - ran into a wall (only frame 0 used)
; Top half - A9h: Facing left  - grappling (only frame 0 used)
$92:83D3             dw A0B4, A0CA, A0E0, A0CA, 0000, A0B4, A0CA, A111, A0CA

; 1ACh. Unused
$92:83E5             dw 9657

; 1ADh. Top half - 3: Facing right - aiming up
$92:83E7             dw 97B1, 97FF

; 1AFh. Top half - 4: Facing left  - aiming up
$92:83EB             dw 97C7, 981A

; 1B1h
; Top half - 5: Facing right - aiming up-right (only frame 0 used)
; Top half - 57h: Facing right - normal jump transition - aiming up-right (only frame 0 used)
; Top half - CFh: Facing right - ran into a wall - aiming up-right (only frame 0 used)
; Top half - E2h: Facing right - landing from normal jump - aiming up-right
; Top half - F3h: Facing right - crouching transition - aiming up-right (only frame 0 used)
; Top half - F9h: Facing right - standing transition - aiming up-right (only frame 0 used)
$92:83EF             dw 97B1, 97B1

; 1B3h
; Top half - 6: Facing left  - aiming up-left (only frame 0 used)
; Top half - 58h: Facing left  - normal jump transition - aiming up-left (only frame 0 used)
; Top half - D0h: Facing left  - ran into a wall - aiming up-left (only frame 0 used)
; Top half - E3h: Facing left  - landing from normal jump - aiming up-left
; Top half - F4h: Facing left  - crouching transition - aiming up-left (only frame 0 used)
; Top half - FAh: Facing left  - standing transition - aiming up-left (only frame 0 used)
$92:83F3             dw 97C7, 97C7

; 1B5h
; Top half - 7: Facing right - aiming down-right (only frame 0 used)
; Top half - 59h: Facing right - normal jump transition - aiming down-right (only frame 0 used)
; Top half - AAh: Facing right - grappling - aiming down-right (only frame 0 used)
; Top half - D1h: Facing right - ran into a wall - aiming down-right (only frame 0 used)
; Top half - E4h: Facing right - landing from normal jump - aiming down-right
; Top half - F5h: Facing right - crouching transition - aiming down-right (only frame 0 used)
; Top half - FBh: Facing right - standing transition - aiming down-right (only frame 0 used)
$92:83F7             dw 9745, 9745

; 1B7h
; Top half - 8: Facing left  - aiming down-left (only frame 0 used)
; Top half - 5Ah: Facing left  - normal jump transition - aiming down-left (only frame 0 used)
; Top half - ABh: Facing left  - grappling - aiming down-left (only frame 0 used)
; Top half - D2h: Facing left  - ran into a wall - aiming down-left (only frame 0 used)
; Top half - E5h: Facing left  - landing from normal jump - aiming down-left
; Top half - F6h: Facing left  - crouching transition - aiming down-left (only frame 0 used)
; Top half - FCh: Facing left  - standing transition - aiming down-left (only frame 0 used)
$92:83FB             dw 9760, 9760

; 1B9h. Top half - A4h: Facing right - landing from normal jump
$92:83FF             dw 9B6F, 9BAE

; 1BBh. Top half - A5h: Facing left  - landing from normal jump
$92:8403             dw 9B80, 9BBF

; 1BDh. Top half - A6h: Facing right - landing from spin jump
$92:8407             dw 9BAE, 9B6F, 9BAE

; 1C0h. Top half - A7h: Facing left  - landing from spin jump
$92:840D             dw 9BBF, 9B80, 9BBF

; 1C3h
; Top half - D5h: Facing right - x-ray - standing
; Top half - D9h: Facing right - x-ray - crouching
$92:8413             dw 9C26, 9C0B, 977B, 9C41, 9C5C

; 1C8h
; Top half - D6h: Facing left  - x-ray - standing
; Top half - DAh: Facing left  - x-ray - crouching
$92:841D             dw 9C92, 9C77, 9796, 9CAD, 9CC8

; 1CDh
; Top half - 55h: Facing right - normal jump transition - aiming up (only frame 0 used)
; Top half - E0h: Facing right - landing from normal jump - aiming up
; Top half - F1h: Facing right - crouching transition - aiming up (only frame 0 used)
; Top half - F7h: Facing right - standing transition - aiming up (only frame 0 used)
$92:8427             dw 97FF, 97FF

; 1CFh
; Top half - 56h: Facing left  - normal jump transition - aiming up (only frame 0 used)
; Top half - E1h: Facing left  - landing from normal jump - aiming up
; Top half - F2h: Facing left  - crouching transition - aiming up (only frame 0 used)
; Top half - F8h: Facing left  - standing transition - aiming up (only frame 0 used)
$92:842B             dw 981A, 981A

; 1D1h. Top half - E6h: Facing right - landing from normal jump - firing
$92:842F             dw 977B, 977B

; 1D3h. Top half - E7h: Facing left  - landing from normal jump - firing
$92:8433             dw 9796, 9796

; 1D5h. Top half - 49h: Facing left  - moonwalk
$92:8437             dw 9796, 9E48, 9E48, 9796, 9E48, 9E48

; 1DBh. Top half - 4Ah: Facing right - moonwalk
$92:8443             dw 977B, 9E2D, 9E2D, 977B, 9E2D, 9E2D

; 1E1h. Top half - 75h: Facing left  - moonwalk - aiming up-left
$92:844F             dw 9872, 9CFE, 9CFE, 9872, 9CFE, 9CFE

; 1E7h. Top half - 76h: Facing right - moonwalk - aiming up-right
$92:845B             dw 9857, 9CE3, 9CE3, 9857, 9CE3, 9CE3

; 1EDh. Top half - 77h: Facing left  - moonwalk - aiming down-left
$92:8467             dw 9725, 9BEB, 9BEB, 9725, 9BEB, 9BEB

; 1F3h. Top half - 78h: Facing right - moonwalk - aiming down-right
$92:8473             dw 9705, 9BCB, 9BCB, 9705, 9BCB, 9BCB

; 1F9h. Top half - 9: Moving right - not aiming
$92:847F             dw 9657, 9A3F, 966F, 9680, 9663, 9657, 9A4B, 969D, 9835, 9691

; 203h. Top half - Ah: Moving left  - not aiming
$92:8493             dw 96AE, 9A57, 96C6, 96D7, 96BA, 96AE, 9A63, 96F4, 9846, 96E8

; 20Dh. Top half - Bh: Moving right - gun extended
$92:84A7             dw A2D0, A440, A2F2, A308, A2E1, A2D0, A323, A334, A400, A323

; 217h. Top half - Ch: Moving left  - gun extended
$92:84BB             dw A34A, A451, A3A0, A380, A365, A34A, A3C0, A41B, A3DB, A3C0

; 221h. Top half - Dh: Moving right - aiming up (unused)
$92:84CF             dw 97FF, 97FF, 9CAD, 9E9E, 9CAD, 97FF, 97FF, 9CAD, 9E9E, 9CAD

; 22Bh. Top half - Eh: Moving left  - aiming up (unused)
$92:84E3             dw 981A, 981A, 9CC8, 9EB9, 9CC8, 981A, 981A, 9CC8, 9EB9, 9CC8

; 235h. Top half - Fh: Moving right - aiming up-right
$92:84F7             dw 9857, 9857, 9CE3, 9DB2, 9CE3, 9857, 9857, 9CE3, 9DB2, 9CE3

; 23Fh. Top half - 10h: Moving left  - aiming up-left
$92:850B             dw 9872, 9872, 9CFE, 9DCD, 9CFE, 9872, 9872, 9CFE, 9DCD, 9CFE

; 249h. Top half - 11h: Moving right - aiming down-right
$92:851F             dw 9705, 9705, 9BCB, 9DED, 9BCB, 9705, 9705, 9BCB, 9DED, 9BCB

; 253h. Top half - 12h: Moving left  - aiming down-left
$92:8533             dw 9725, 9725, 9BEB, 9E0D, 9BEB, 9725, 9725, 9BEB, 9E0D, 9BEB

; 25Dh. Top half - 45h: Unused
$92:8547             dw 97EE, 97EE, 9C92, 9E83, 9C92, 97EE, 97EE, 9C92, 9E83, 9C92

; 267h. Top half - 46h: Unused
$92:855B             dw 97DD, 97DD, 9C77, 9E63, 9C77, 97DD, 97DD, 9C77, 9E63, 9C77

; 271h
; Top half - 17h: Facing right - normal jump - aiming down
; Top half - AEh: Unused. Facing right - grappling - in air - aiming down
$92:856F             dw 9705, 9B17

; 273h
; Top half - 18h: Facing left  - normal jump - aiming down
; Top half - AFh: Unused. Facing left  - grappling - in air - aiming down
$92:8573             dw 9725, 9B2D

; 275h
; Top half - 13h: Facing right - normal jump - not aiming - not moving - gun extended
; Top half - ACh: Unused. Facing right - grappling - in air
$92:8577             dw 977B, 977B

; 277h
; Top half - 14h: Facing left  - normal jump - not aiming - not moving - gun extended
; Top half - ADh: Unused. Facing left  - grappling - in air
$92:857B             dw 9796, 9796

; 279h. Top half - 15h: Facing right - normal jump - aiming up
$92:857F             dw 97B1, 97FF

; 27Bh. Top half - 16h: Facing left  - normal jump - aiming up
$92:8583             dw 97C7, 981A

; 27Dh. Top half - 69h: Facing right - normal jump - aiming up-right
$92:8587             dw 9857, 9857

; 27Fh. Top half - 6Ah: Facing left  - normal jump - aiming up-left
$92:858B             dw 9872, 9872

; 281h
; Top half - 6Bh: Facing right - normal jump - aiming down-right
; Top half - B0h: Unused. Facing right - grappling - in air - aiming down-right
$92:858F             dw 9705, 9705

; 283h
; Top half - 6Ch: Facing left  - normal jump - aiming down-left
; Top half - B1h: Unused. Facing left  - grappling - in air - aiming down-left
$92:8593             dw 9725, 9725

; 285h. Top half - 51h: Facing right - normal jump - not aiming - moving forward
$92:8597             dw 977B, 977B

; 287h. Top half - 52h: Facing left  - normal jump - not aiming - moving forward
$92:859B             dw 9796, 9796

; 289h. Top half - 4Bh: Facing right - normal jump transition
$92:859F             dw 9B6F

; 28Ah. Top half - 4Ch: Facing left  - normal jump transition
$92:85A1             dw 9B80

; 28Bh
; Top half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; Top half - C7h: Facing right - vertical shinespark windup
$92:85A3             dw 9691, 969D, 9691, 9657, 9663, 97DD

; 291h
; Top half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended
; Top half - C8h: Facing left  - vertical shinespark windup
$92:85AF             dw 96E8, 96F4, 96E8, 96AE, 96BA, 97EE

; 297h. Top half - 4Fh: Facing left  - damage boost
$92:85BB             dw 9BBF, 9BBF, BB94, BB88, BB72, BB66, BB50, BB44, BB2E, 9EB9

; 2A1h. Top half - 50h: Facing right - damage boost
$92:85CF             dw 9BAE, 9BAE, BDD9, BDCD, BDB7, BDAB, BD95, BD89, BD73, 9E83

; 2ABh. Top half - 63h: Unused
$92:85E3             dw 9A93, 9A1F

; 2ADh. Top half - 64h: Unused
$92:85E7             dw 9AAE, 99FF

; 2AFh. Top half - 65h: Unused
$92:85EB             dw 9A7B, BD67, BD73, BD89, BD95, BDAB, BDB7, BDCD, BDD9

; 2B8h. Top half - 66h: Unused
$92:85FD             dw 9A87, BB22, BB2E, BB44, BB50, BB66, BB72, BB88, BB94

; 2C1h. Top half - 83h: Facing right - wall jump
$92:860F             dw 9A7B, 9BAE, 0000, BD67, BD73, BD89, BD95, BDAB, BDB7, BDCD, BDD9, 0000, 0000, BEBF, BEBF, BEBF,
                        BEBF, BEBF, BEBF, BEBF, BEBF, 0000, 0000, BDEF, BDEF, BDEF, BEBF, BEBF, BEBF, BE23, BE23, BE23,
                        BEBF, BEBF, BEBF, BE5C, BE5C, BE5C, BEBF, BEBF, BEBF, BE95, BE95, BE95, BEBF, BEBF, BEBF

; 2F0h. Top half - 84h: Facing left  - wall jump
$92:866D             dw 9A87, 9BBF, 0000, BB22, BB2E, BB44, BB50, BB66, BB72, BB88, BB94, 0000, 0000, BC7A, BC7A, BC7A,
                        BC7A, BC7A, BC7A, BC7A, BC7A, 0000, 0000, BBAA, BBAA, BBAA, BC7A, BC7A, BC7A, BBDE, BBDE, BBDE,
                        BC7A, BC7A, BC7A, BC17, BC17, BC17, BC7A, BC7A, BC7A, BC50, BC50, BC50, BC7A, BC7A, BC7A

; 31Fh. Top half - 53h: Facing right - knockback
$92:86CB             dw 98AD, 98AD

; 321h. Top half - 54h: Facing left  - knockback
$92:86CF             dw 9892, 9892

; 323h. Unused
$92:86D3             dw 9892, 98AD, 9928, 9928, 9976, 9912, 9912, 996F, 9998, 99CE, 9982, 99AE

; 32Fh. Top half - B8h: Facing left  - grapple wall jump pose
$92:86EB             dw 9A1F

; 330h. Top half - B9h: Facing right - grapple wall jump pose
$92:86ED             dw 99FF

; 331h. Unused
$92:86EF             dw 9B2D, 9B17

; 333h. Top half - B2h: Facing clockwise     - grapple swinging
$92:86F3             dw A96B, A955, A944, A933, A922, A911, A900, A8EA, A8D4, A584, A573, A562, A551, A540, A52F, A519,
                        A503, A4ED, A4DC, A4CB, A4BA, A4A9, A498, A482, A46C, A9EC, A9DB, A9CA, A9B9, A9A8, A997, A981,
                        A96B, A955, A944, A933, A922, A911, A900, A8EA, A8D4, A584, A573, A562, A551, A540, A52F, A519,
                        A503, A4ED, A4DC, A4CB, A4BA, A4A9, A498, A482, A46C, A9EC, A9DB, A9CA, A9B9, A9A8, A997, A981,
                        A503, A503

; 375h. Top half - B3h: Facing anticlockwise - grapple swinging
$92:8777             dw AB8B, ABB5, ABDF, AC0E, AC42, AC76, ACAA, ACDE, A5B0, A5DA, A604, A638, A66C, A69B, A6CA, A6F9,
                        A723, A74D, A777, A7A6, A7DA, A80E, A842, A876, AA18, AA42, AA6C, AAA0, AAD4, AB03, AB32, AB61,
                        AB8B, ABB5, ABDF, AC0E, AC42, AC76, ACAA, ACDE, A5B0, A5DA, A604, A638, A66C, A69B, A6CA, A6F9,
                        A723, A74D, A777, A7A6, A7DA, A80E, A842, A876, AA18, AA42, AA6C, AAA0, AAD4, AB03, AB32, AB61,
                        A723, A723

; 3B7h. Top half - 29h: Facing right - falling
$92:87FB             dw 9BAE, 9E63, 9E83, 0000, 0000, 9E63, 9BAE

; 3BEh. Top half - 2Ah: Facing left  - falling
$92:8809             dw 9BBF, 9E9E, 9EB9, 0000, 0000, 9E9E, 9BBF

; 3C5h. Top half - 67h: Facing right - falling - gun extended
$92:8817             dw 977B, 977B, 977B, 0000, 0000, 977B, 977B

; 3CCh. Top half - 68h: Facing left  - falling - gun extended
$92:8825             dw 9796, 9796, 9796, 0000, 0000, 9796, 9796

; 3D3h. Top half - 2Bh: Facing right - falling - aiming up
$92:8833             dw 97B1, 97FF, 97FF

; 3D6h. Top half - 2Ch: Facing left  - falling - aiming up
$92:8839             dw 97C7, 981A, 981A

; 3D9h. Top half - 2Dh: Facing right - falling - aiming down
$92:883F             dw 9705, 9B17

; 3DBh. Top half - 2Eh: Facing left  - falling - aiming down
$92:8843             dw 9725, 9B2D

; 3DDh. Top half - 6Dh: Facing right - falling - aiming up-right
$92:8847             dw 9857, 9857, 9857

; 3E0h. Top half - 6Eh: Facing left  - falling - aiming up-left
$92:884D             dw 9872, 9872, 9872

; 3E3h. Top half - 6Fh: Facing right - falling - aiming down-right
$92:8853             dw 9705, 9705, 9705

; 3E6h. Top half - 70h: Facing left  - falling - aiming down-left
$92:8859             dw 9725, 9725, 9725

; 3E9h. Top half - 71h: Facing right - crouching - aiming up-right
$92:885F             dw 97B1

; 3EAh. Top half - 72h: Facing left  - crouching - aiming up-left
$92:8861             dw 97C7

; 3EBh
; Top half - 73h: Facing right - crouching - aiming down-right
; Top half - B6h: Facing right - grappling - crouching - aiming down-right
$92:8863             dw 9745

; 3ECh
; Top half - 74h: Facing left  - crouching - aiming down-left
; Top half - B7h: Facing left  - grappling - crouching - aiming down-left
$92:8865             dw 9760

; 3EDh. Top half - 85h: Facing right - crouching - aiming up
$92:8867             dw 97B1, 97FF

; 3EFh. Top half - 86h: Facing left  - crouching - aiming up
$92:886B             dw 97C7, 981A

; 3F1h
; Top half - 27h: Facing right - crouching
; Top half - B4h: Facing right - grappling - crouching (only frame 0 used)
$92:886F             dw A072, A088, A09E, A088, 0000, A072, A088, A0F6, A088

; 3FAh
; Top half - 28h: Facing left  - crouching
; Top half - B5h: Facing left  - grappling - crouching (only frame 0 used)
$92:8881             dw A0B4, A0CA, A0E0, A0CA, 0000, A0B4, A0CA, A111, A0CA

; 403h
; Top half - 35h: Facing right - crouching transition
; Top half - 3Bh: Facing right - standing transition
$92:8893             dw 977B

; 404h
; Top half - 36h: Facing left  - crouching transition
; Top half - 3Ch: Facing left  - standing transition
$92:8895             dw 9796

; 405h. Top half - 37h: Facing right - morphing transition
$92:8897             dw BCDD, BCCC

; 407h. Top half - 38h: Facing left  - morphing transition
$92:889B             dw BCB1, BCA0

; 409h. Top half - 3Dh: Facing right - unmorphing transition
$92:889F             dw BCCC, BCDD

; 40Bh. Top half - 3Eh: Facing left  - unmorphing transition
$92:88A3             dw BCA0, BCB1

; 40Dh. Top half - DBh: Unused
$92:88A7             dw 977B, BCDD, BCCC

; 410h. Top half - DCh: Unused
$92:88AD             dw 9796, BCB1, BCA0

; 413h. Top half - DDh: Unused
$92:88B3             dw BCCC, BCDD, 977B

; 416h. Top half - DEh: Unused
$92:88B9             dw BCA0, BCB1, 9796

; 419h
; Top half - 25h: Facing right - turning - standing
; Top half - 2Fh: Facing right - turning - jumping
; Top half - 43h: Facing right - turning - crouching
; Top half - 87h: Facing right - turning - falling
; Top half - BFh: Facing right - moonwalking - turn/jump left
; Top half - C6h: Unused
$92:88BF             dw 9998, 99E9, 9982

; 41Ch
; Top half - 26h: Facing left  - turning - standing
; Top half - 30h: Facing left  - turning - jumping
; Top half - 44h: Facing left  - turning - crouching
; Top half - 88h: Facing left  - turning - falling
; Top half - C0h: Facing left  - moonwalking - turn/jump right
$92:88C5             dw 9982, 99E9, 9998

; 41Fh
; Top half - 8Bh: Facing right - turning - standing - aiming up
; Top half - 8Fh: Facing right - turning - in air - aiming up
; Top half - 93h: Facing right - turning - falling - aiming up
; Top half - 97h: Facing right - turning - crouching - aiming up
; Top half - 9Ch: Facing right - turning - standing - aiming up-right
; Top half - 9Eh: Facing right - turning - in air - aiming up-right
; Top half - A0h: Facing right - turning - falling - aiming up-right
; Top half - A2h: Facing right - turning - crouching - aiming up-right
; Top half - C1h: Facing right - moonwalking - turn/jump left  - aiming up-right
$92:88CB             dw 99CE, 993E, 99AE

; 422h
; Top half - 8Ch: Facing left  - turning - standing - aiming up
; Top half - 90h: Facing left  - turning - in air - aiming up
; Top half - 94h: Facing left  - turning - falling - aiming up
; Top half - 98h: Facing left  - turning - crouching - aiming up
; Top half - 9Dh: Facing left  - turning - standing - aiming up-left
; Top half - 9Fh: Facing left  - turning - in air - aiming up-left
; Top half - A1h: Facing left  - turning - falling - aiming up-left
; Top half - A3h: Facing left  - turning - crouching - aiming up-left
; Top half - C2h: Facing left  - moonwalking - turn/jump right - aiming up-left
$92:88D1             dw 99AE, 993E, 99CE

; 425h
; Top half - 8Dh: Facing right - turning - standing - aiming down-right
; Top half - 91h: Facing right - turning - in air - aiming down/down-right
; Top half - 95h: Facing right - turning - falling - aiming down/down-right
; Top half - 99h: Facing right - turning - crouching - aiming down/down-right
; Top half - C3h: Facing right - moonwalking - turn/jump left  - aiming down-right
$92:88D7             dw 9AF7, 9954, 9AD7

; 428h
; Top half - 8Eh: Facing left  - turning - standing - aiming down-left
; Top half - 92h: Facing left  - turning - in air - aiming down/down-left
; Top half - 96h: Facing left  - turning - falling - aiming down/down-left
; Top half - 9Ah: Facing left  - turning - crouching - aiming down/down-left
; Top half - C4h: Facing left  - moonwalking - turn/jump right - aiming down-left
$92:88DD             dw 9AD7, 9954, 9AF7

; 42Bh. Top half - ECh: Facing right - grabbed by Draygon - not moving - not aiming
$92:88E3             dw 9BAE

; 42Ch. Top half - EDh: Facing right - grabbed by Draygon - not moving - aiming up-right
$92:88E5             dw 9857

; 42Dh. Top half - EEh: Facing right - grabbed by Draygon - firing
$92:88E7             dw 977B

; 42Eh. Top half - EFh: Facing right - grabbed by Draygon - not moving - aiming down-right
$92:88E9             dw 9705

; 42Fh. Top half - BAh: Facing left  - grabbed by Draygon - not moving - not aiming
$92:88EB             dw 9BBF

; 430h. Top half - BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left
$92:88ED             dw 9872

; 431h. Top half - BCh: Facing left  - grabbed by Draygon - firing
$92:88EF             dw 9796

; 432h. Top half - BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left
$92:88F1             dw 9725

; 433h. Top half - F0h: Facing right - grabbed by Draygon - moving
$92:88F3             dw 9663, 966F, 9657, 9691, 969D, 9657

; 439h. Top half - BEh: Facing left  - grabbed by Draygon - moving
$92:88FF             dw 96BA, 96C6, 96AE, 96E8, 96F4, 96AE

; 43Fh. Top half - C9h: Facing right - shinespark - horizontal
$92:890B             dw 9A93

; 440h. Top half - CAh: Facing left  - shinespark - horizontal
$92:890D             dw 9AAE

; 441h. Top half - CDh: Facing right - shinespark - diagonal
$92:890F             dw 9A93

; 442h. Top half - CEh: Facing left  - shinespark - diagonal
$92:8911             dw 9AAE

; 443h. Top half - D3h: Facing right - crystal flash
$92:8913             dw BCCC, BCDD, C207, BCDD, 0000, 0000, C207, C22C, C251, C22C, 0000, 0000, BCDD, BCDD, 977B

; 452h. Top half - D4h: Facing left  - crystal flash
$92:8931             dw BCA0, BCB1, C198, BCB1, 0000, 0000, C198, C1BD, C1E2, C1BD, 0000, 0000, BCB1, BCB1, 9796

; 461h. Top half - D7h: Facing right - crystal flash ending
$92:894F             dw BAB3, BCCC, BCDD, 977B, 98AD, 98AD

; 467h. Top half - D8h: Facing left  - crystal flash ending
$92:895B             dw BB16, BCA0, BCB1, 9796, 9892, 9892

; 46Dh. Top half - E8h: Facing right - Samus drained - crouching/falling
$92:8967             dw BAB3, BCCC, BCDD, 98AD, 98AD, 98AD, 98AD, 98AD, 9F34, 9F59, 9F7E, 9F59, 0000, 0000, 977B

; 47Ch. Top half - E9h: Facing left  - Samus drained - crouching/falling
$92:8985             dw BCA0, BCB1, 9892, 9892, 9892, 9892, 9892, 9EF4, 9ED4, 9EF4, 9F14, 9EF4, 0000, 0000, 9EF4, 9FC3,
                        9BA2, 0000, 0000, 9EF4, 9FC3, 9BA2, 9FC3, 9EF4, 0000, 0000, 9ED4, 0000, 0000, 9ED4

; 49Ah. Unused
$92:89C1             dw 0000, 0000

; 49Ch. Top half - EAh: Facing right - Samus drained - standing
$92:89C5             dw A003, A028, A04D, A028, 0000, 977B

; 4A2h. Top half - EBh: Facing left  - Samus drained - standing
$92:89D1             dw 9FA3, 9FC3, 9FE3, 9FC3, 0000, 9796

; 4A8h. Unused
$92:89DD             dw AD3C, AD3C

; 4AAh
; Bottom half - 1: Facing right - normal
; Bottom half - 47h: Unused (only frame 0 used)
; Bottom half - 89h: Facing right - ran into a wall (only frame 0 used)
; Bottom half - A8h: Facing right - grappling (only frame 0 used)
$92:89E1             dw ADBB, AE98, AEA9, AE98, 0000, ADBB, AE98, AEA9, AE98

; 4B3h
; Bottom half - 2: Facing left  - normal
; Bottom half - 48h: Unused (only frame 0 used)
; Bottom half - 8Ah: Facing left  - ran into a wall (only frame 0 used)
; Bottom half - A9h: Facing left  - grappling (only frame 0 used)
$92:89F3             dw B340, AEBA, AFA1, AEBA, 0000, B340, AEBA, AFA1, AEBA

; 4BCh. Unused
$92:8A05             dw ADBB, ADBB, B340, B340

; 4C0h
; Bottom half - 3: Facing right - aiming up
; Bottom half - 5: Facing right - aiming up-right (only frame 0 used)
; Bottom half - 7: Facing right - aiming down-right (only frame 0 used)
; Bottom half - AAh: Facing right - grappling - aiming down-right (only frame 0 used)
; Bottom half - CFh: Facing right - ran into a wall - aiming up-right (only frame 0 used)
; Bottom half - D1h: Facing right - ran into a wall - aiming down-right (only frame 0 used)
$92:8A0D             dw B295, B295

; 4C2h
; Bottom half - 4: Facing left  - aiming up
; Bottom half - 6: Facing left  - aiming up-left (only frame 0 used)
; Bottom half - 8: Facing left  - aiming down-left (only frame 0 used)
; Bottom half - ABh: Facing left  - grappling - aiming down-left (only frame 0 used)
; Bottom half - D0h: Facing left  - ran into a wall - aiming up-left (only frame 0 used)
; Bottom half - D2h: Facing left  - ran into a wall - aiming down-left (only frame 0 used)
$92:8A11             dw B2AB, B2AB

; 4C4h. Unused
$92:8A15             dw AD3C

; 4C5h
; Bottom half - A4h: Facing right - landing from normal jump
; Bottom half - E0h: Facing right - landing from normal jump - aiming up
; Bottom half - E2h: Facing right - landing from normal jump - aiming up-right
; Bottom half - E4h: Facing right - landing from normal jump - aiming down-right
; Bottom half - E6h: Facing right - landing from normal jump - firing
$92:8A17             dw B021, ADBB

; 4C7h
; Bottom half - A5h: Facing left  - landing from normal jump
; Bottom half - E1h: Facing left  - landing from normal jump - aiming up
; Bottom half - E3h: Facing left  - landing from normal jump - aiming up-left
; Bottom half - E5h: Facing left  - landing from normal jump - aiming down-left
; Bottom half - E7h: Facing left  - landing from normal jump - firing
$92:8A1B             dw B037, B340

; 4C9h. Bottom half - A6h: Facing right - landing from spin jump
$92:8A1F             dw B1C8, B021, ADBB

; 4CCh. Bottom half - A7h: Facing left  - landing from spin jump
$92:8A25             dw B1E3, B037, B340

; 4CFh. Bottom half - D5h: Facing right - x-ray - standing
$92:8A2B             dw ADBB, ADBB, ADBB, ADBB, ADBB

; 4D4h. Bottom half - D6h: Facing left  - x-ray - standing
$92:8A35             dw B340, B340, B340, B340, B340

; 4D9h. Bottom half - D9h: Facing right - x-ray - crouching
$92:8A3F             dw B351, B351, B351, B351, B351

; 4DEh. Bottom half - DAh: Facing left  - x-ray - crouching
$92:8A49             dw ADCC, ADCC, ADCC, ADCC, ADCC

; 4E3h
; Bottom half - 9: Moving right - not aiming
; Bottom half - Bh: Moving right - gun extended
; Bottom half - Dh: Moving right - aiming up (unused)
; Bottom half - Fh: Moving right - aiming up-right
; Bottom half - 11h: Moving right - aiming down-right
; Bottom half - 45h: Unused
$92:8A53             dw AD3C, ADD8, AD48, ADEE, AD63, AD79, AE0E, AD85, AE24, ADA5

; 4EDh
; Bottom half - Ah: Moving left  - not aiming
; Bottom half - Ch: Moving left  - gun extended
; Bottom half - Eh: Moving left  - aiming up (unused)
; Bottom half - 10h: Moving left  - aiming up-left
; Bottom half - 12h: Moving left  - aiming down-left
; Bottom half - 46h: Unused
$92:8A67             dw B2C1, B35D, B2CD, B373, B2E8, B2FE, B393, B30A, B3A9, B32A

; 4F7h
; Bottom half - 49h: Facing left  - moonwalk
; Bottom half - 75h: Facing left  - moonwalk - aiming up-left
; Bottom half - 77h: Facing left  - moonwalk - aiming down-left
$92:8A7B             dw B3ED, B403, B184, B3C9, B40F, B195

; 4FDh
; Bottom half - 4Ah: Facing right - moonwalk
; Bottom half - 76h: Facing right - moonwalk - aiming up-right
; Bottom half - 78h: Facing right - moonwalk - aiming down-right
$92:8A87             dw AFF3, B009, B1A6, AFCA, B015, B1B7

; 503h
; Bottom half - 17h: Facing right - normal jump - aiming down
; Bottom half - AEh: Unused. Facing right - grappling - in air - aiming down
$92:8A93             dw B08D, B104

; 505h
; Bottom half - 18h: Facing left  - normal jump - aiming down
; Bottom half - AFh: Unused. Facing left  - grappling - in air - aiming down
$92:8A97             dw B09E, B124

; 507h
; Bottom half - 13h: Facing right - normal jump - not aiming - not moving - gun extended
; Bottom half - ACh: Unused. Facing right - grappling - in air
$92:8A9B             dw B08D, B1C8

; 509h
; Bottom half - 14h: Facing left  - normal jump - not aiming - not moving - gun extended
; Bottom half - ADh: Unused. Facing left  - grappling - in air
$92:8A9F             dw B09E, B1E3

; 50Bh. Bottom half - 15h: Facing right - normal jump - aiming up
$92:8AA3             dw B08D, AEF7

; 50Dh. Bottom half - 16h: Facing left  - normal jump - aiming up
$92:8AA7             dw B09E, AF08

; 50Fh. Bottom half - 51h: Facing right - normal jump - not aiming - moving forward
$92:8AAB             dw B08D, B1C8

; 511h. Bottom half - 52h: Facing left  - normal jump - not aiming - moving forward
$92:8AAF             dw B09E, B1E3

; 513h. Bottom half - 69h: Facing right - normal jump - aiming up-right
$92:8AB3             dw B08D, AEF7

; 515h. Bottom half - 6Ah: Facing left  - normal jump - aiming up-left
$92:8AB7             dw B09E, AF08

; 517h
; Bottom half - 6Bh: Facing right - normal jump - aiming down-right
; Bottom half - B0h: Unused. Facing right - grappling - in air - aiming down-right
$92:8ABB             dw B08D, B1C8

; 519h
; Bottom half - 6Ch: Facing left  - normal jump - aiming down-left
; Bottom half - B1h: Unused. Facing left  - grappling - in air - aiming down-left
$92:8ABF             dw B09E, B1E3

; 51Bh
; Bottom half - 4Bh: Facing right - normal jump transition
; Bottom half - 55h: Facing right - normal jump transition - aiming up
; Bottom half - 57h: Facing right - normal jump transition - aiming up-right
; Bottom half - 59h: Facing right - normal jump transition - aiming down-right
$92:8AC3             dw B021

; 51Ch
; Bottom half - 4Ch: Facing left  - normal jump transition
; Bottom half - 56h: Facing left  - normal jump transition - aiming up
; Bottom half - 58h: Facing left  - normal jump transition - aiming up-left
; Bottom half - 5Ah: Facing left  - normal jump transition - aiming down-left
$92:8AC5             dw B037

; 51Dh
; Bottom half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; Bottom half - C7h: Facing right - vertical shinespark windup
$92:8AC7             dw AD79, B0C7, B04D, B04D, B08D, B0AF

; 523h
; Bottom half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended
; Bottom half - C8h: Facing left  - vertical shinespark windup
$92:8AD3             dw B2FE, B0E2, B06D, B06D, B09E, B0BB

; 529h. Bottom half - 4Fh: Facing left  - damage boost (frames 2..8 are unused)
$92:8ADF             dw AECB, B09E, 0000, 0000, 0000, 0000, 0000, 0000, 0000, B1E3

; 533h. Bottom half - 50h: Facing right - damage boost (frames 2..8 are unused)
$92:8AF3             dw AEE1, B08D, 0000, 0000, 0000, 0000, 0000, 0000, 0000, B1C8

; 53Dh. Bottom half - 63h: Unused
$92:8B07             dw B184, AF69

; 53Fh. Bottom half - 64h: Unused
$92:8B0B             dw B195, AF5D

; 541h. Bottom half - 65h: Unused
$92:8B0F             dw B144

; 542h. Unused
$92:8B11             dw BB22, BB2E, BB44, BB50, BB66, BB72, BB88, BB94

; 54Ah. Bottom half - 66h: Unused
$92:8B21             dw B169

; 54Bh. Unused
$92:8B23             dw BD67, BD73, BD89, BD95, BDAB, BDB7, BDCD, BDD9

; 553h. Bottom half - 83h: Facing right - wall jump (frames 3..Ch are unused)
$92:8B33             dw B144, B1C8, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, C458, C46E, C4A2,
                        C4B8, C4EC, C502, C536, C54C, 0000, 0000, C458, C46E, C4A2, C4B8, C4EC, C502, C536, C54C, C458,
                        C46E, C4A2, C4B8, C4EC, C502, C536, C54C, C458, C46E, C4A2, C4B8, C4EC, C502, C536, C54C

; 582h. Bottom half - 84h: Facing left  - wall jump (frames 3..Ch are unused)
$92:8B91             dw B169, B1E3, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, C330, C346, C37A,
                        C390, C3C4, C3DA, C40E, C424, 0000, 0000, C330, C346, C37A, C390, C3C4, C3DA, C40E, C424, C330,
                        C346, C37A, C390, C3C4, C3DA, C40E, C424, C330, C346, C37A, C390, C3C4, C3DA, C40E, C424

; 5B1h. Bottom half - 53h: Facing right - knockback
$92:8BEF             dw B0AF, B1FE

; 5B3h. Bottom half - 54h: Facing left  - knockback
$92:8BF3             dw B0BB, B214

; 5B5h. Bottom half - B8h: Facing left  - grapple wall jump pose
$92:8BF7             dw AF69

; 5B6h. Bottom half - B9h: Facing right - grapple wall jump pose
$92:8BF9             dw AF5D

; 5B7h. Bottom half - B2h: Facing clockwise     - grapple swinging
$92:8BFB             dw B63F, B624, B60E, B5FD, B5FD, B5DD, B5DD, B5CC, B5CC, B5CC, B4E6, B4E6, B4D0, B4D0, B4BA, B4A9,
                        B48E, B473, B45D, B44C, B44C, B42C, B42C, B41B, B41B, B41B, B697, B697, B681, B681, B66B, B65A,
                        B72B, B715, B709, B6FD, B6FD, B6E7, B6E7, B6DB, B6DB, B6DB, B5B4, B5B4, B59E, B59E, B592, B586,
                        B57A, B564, B558, B54C, B54C, B536, B536, B52A, B52A, B52A, B74F, B74F, B743, B743, B737, B72B,
                        B512, B51E

; 5F9h. Bottom half - B3h: Facing anticlockwise - grapple swinging
$92:8C7F             dw B98B, B9A6, B9B7, B9CD, B9CD, B9E3, B9E3, B767, B767, B767, B778, B778, B798, B798, B7A9, B7BF,
                        B7DA, B7F5, B806, B81C, B81C, B832, B832, B918, B918, B918, B929, B929, B949, B949, B95A, B970,
                        BA77, BA83, BA8F, BA9B, BA9B, BAA7, BAA7, B876, B876, B876, B882, B882, B898, B898, B8A4, B8B0,
                        B8C6, B8D2, B8DE, B8EA, B8EA, B900, B900, BA27, BA27, BA27, BA33, BA33, BA49, BA49, BA55, BA61,
                        B85E, B86A

; 63Bh
; Bottom half - 29h: Facing right - falling
; Bottom half - 67h: Facing right - falling - gun extended
$92:8D03             dw B08D, B0AF, B0AF, 0000, 0000, B08D, B1C8

; 642h
; Bottom half - 2Ah: Facing left  - falling
; Bottom half - 68h: Facing left  - falling - gun extended
$92:8D11             dw B09E, B0BB, B0BB, 0000, 0000, B09E, B1E3

; 649h. Bottom half - 2Dh: Facing right - falling - aiming down
$92:8D1F             dw B08D, B104

; 64Bh. Bottom half - 2Eh: Facing left  - falling - aiming down
$92:8D23             dw B09E, B124

; 64Dh. Bottom half - 2Bh: Facing right - falling - aiming up
$92:8D27             dw B08D, B0AF, B1C8

; 650h. Bottom half - 2Ch: Facing left  - falling - aiming up
$92:8D2D             dw B09E, B0BB, B1E3

; 653h. Bottom half - 6Dh: Facing right - falling - aiming up-right
$92:8D33             dw B08D, B0AF, B1C8

; 656h. Bottom half - 6Eh: Facing left  - falling - aiming up-left
$92:8D39             dw B09E, B0BB, B1E3

; 659h. Bottom half - 6Fh: Facing right - falling - aiming down-right
$92:8D3F             dw B08D, B0AF, B1C8

; 65Ch. Bottom half - 70h: Facing left  - falling - aiming down-left
$92:8D45             dw B09E, B0BB, B1E3

; 65Fh
; Bottom half - 27h: Facing right - crouching
; Bottom half - B4h: Facing right - grappling - crouching (only frame 0 used)
$92:8D4B             dw B351, B351, B351, B351, 0000, B351, B351, B351, B351

; 668h
; Bottom half - 28h: Facing left  - crouching
; Bottom half - B5h: Facing left  - grappling - crouching (only frame 0 used)
$92:8D5D             dw ADCC, ADCC, ADCC, ADCC, 0000, ADCC, ADCC, ADCC, ADCC

; 671h. Bottom half - 71h: Facing right - crouching - aiming up-right
$92:8D6F             dw B351

; 672h. Bottom half - 72h: Facing left  - crouching - aiming up-left
$92:8D71             dw ADCC

; 673h
; Bottom half - 73h: Facing right - crouching - aiming down-right
; Bottom half - B6h: Facing right - grappling - crouching - aiming down-right
$92:8D73             dw B351

; 674h
; Bottom half - 74h: Facing left  - crouching - aiming down-left
; Bottom half - B7h: Facing left  - grappling - crouching - aiming down-left
$92:8D75             dw ADCC

; 675h. Bottom half - 85h: Facing right - crouching - aiming up
$92:8D77             dw B351, B351

; 677h. Bottom half - 86h: Facing left  - crouching - aiming up
$92:8D7B             dw ADCC, ADCC

; 679h
; Bottom half - 35h: Facing right - crouching transition
; Bottom half - 3Bh: Facing right - standing transition
; Bottom half - F1h: Facing right - crouching transition - aiming up
; Bottom half - F3h: Facing right - crouching transition - aiming up-right
; Bottom half - F5h: Facing right - crouching transition - aiming down-right
; Bottom half - F7h: Facing right - standing transition - aiming up
; Bottom half - F9h: Facing right - standing transition - aiming up-right
; Bottom half - FBh: Facing right - standing transition - aiming down-right
$92:8D7F             dw B021

; 67Ah
; Bottom half - 36h: Facing left  - crouching transition
; Bottom half - 3Ch: Facing left  - standing transition
; Bottom half - F2h: Facing left  - crouching transition - aiming up
; Bottom half - F4h: Facing left  - crouching transition - aiming up-left
; Bottom half - F6h: Facing left  - crouching transition - aiming down-left
; Bottom half - F8h: Facing left  - standing transition - aiming up
; Bottom half - FAh: Facing left  - standing transition - aiming up-left
; Bottom half - FCh: Facing left  - standing transition - aiming down-left
$92:8D81             dw B037

; 67Bh. Unused
$92:8D83             dw 0000, 0000

; 67Dh. Bottom half - DBh: Unused
$92:8D87             dw B021

; 67Eh. Unused
$92:8D89             dw 0000, 0000

; 680h. Bottom half - DCh: Unused
$92:8D8D             dw B021

; 681h. Bottom half - DDh: Unused (only frame 2 is used)
$92:8D8F             dw 0000, 0000, B021

; 684h. Bottom half - DEh: Unused (only frame 2 is used)
$92:8D95             dw 0000, 0000, B021

; 687h
; Bottom half - 25h: Facing right - turning - standing
; Bottom half - 8Bh: Facing right - turning - standing - aiming up
; Bottom half - 8Dh: Facing right - turning - standing - aiming down-right
; Bottom half - 9Ch: Facing right - turning - standing - aiming up-right
; Bottom half - BFh: Facing right - moonwalking - turn/jump left
; Bottom half - C1h: Facing right - moonwalking - turn/jump left  - aiming up-right
; Bottom half - C3h: Facing right - moonwalking - turn/jump left  - aiming down-right
; Bottom half - C6h: Unused
$92:8D9B             dw AF2A, AFE0, AF19

; 68Ah
; Bottom half - 26h: Facing left  - turning - standing
; Bottom half - 8Ch: Facing left  - turning - standing - aiming up
; Bottom half - 8Eh: Facing left  - turning - standing - aiming down-left
; Bottom half - 9Dh: Facing left  - turning - standing - aiming up-left
; Bottom half - C0h: Facing left  - moonwalking - turn/jump right
; Bottom half - C2h: Facing left  - moonwalking - turn/jump right - aiming up-left
; Bottom half - C4h: Facing left  - moonwalking - turn/jump right - aiming down-left
$92:8DA1             dw AF19, AFE0, AF2A

; 68Dh
; Bottom half - 2Fh: Facing right - turning - jumping
; Bottom half - 43h: Facing right - turning - crouching
; Bottom half - 87h: Facing right - turning - falling
; Bottom half - 8Fh: Facing right - turning - in air - aiming up
; Bottom half - 91h: Facing right - turning - in air - aiming down/down-right
; Bottom half - 93h: Facing right - turning - falling - aiming up
; Bottom half - 95h: Facing right - turning - falling - aiming down/down-right
; Bottom half - 97h: Facing right - turning - crouching - aiming up
; Bottom half - 99h: Facing right - turning - crouching - aiming down/down-right
; Bottom half - 9Eh: Facing right - turning - in air - aiming up-right
; Bottom half - A0h: Facing right - turning - falling - aiming up-right
; Bottom half - A2h: Facing right - turning - crouching - aiming up-right
$92:8DA7             dw AF4C, AFEC, AF3B

; 690h
; Bottom half - 30h: Facing left  - turning - jumping
; Bottom half - 44h: Facing left  - turning - crouching
; Bottom half - 90h: Facing left  - turning - in air - aiming up
; Bottom half - 92h: Facing left  - turning - in air - aiming down/down-left
; Bottom half - 98h: Facing left  - turning - crouching - aiming up
; Bottom half - 9Ah: Facing left  - turning - crouching - aiming down/down-left
; Bottom half - 9Fh: Facing left  - turning - in air - aiming up-left
; Bottom half - A3h: Facing left  - turning - crouching - aiming up-left
$92:8DAD             dw AF3B, AFEC, AF4C

; 693h. Unused
$92:8DB3             dw AF4C, AFEC, AF3B

; 696h
; Bottom half - 88h: Facing left  - turning - falling
; Bottom half - 94h: Facing left  - turning - falling - aiming up
; Bottom half - 96h: Facing left  - turning - falling - aiming down/down-left
; Bottom half - A1h: Facing left  - turning - falling - aiming up-left
$92:8DB9             dw AF3B, AFEC, AF4C

; 699h
; Bottom half - ECh: Facing right - grabbed by Draygon - not moving - not aiming
; Bottom half - EDh: Facing right - grabbed by Draygon - not moving - aiming up-right
; Bottom half - EEh: Facing right - grabbed by Draygon - firing
; Bottom half - EFh: Facing right - grabbed by Draygon - not moving - aiming down-right
$92:8DBF             dw B1FE

; 69Ah
; Bottom half - BAh: Facing left  - grabbed by Draygon - not moving - not aiming
; Bottom half - BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left
; Bottom half - BCh: Facing left  - grabbed by Draygon - firing
; Bottom half - BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left
$92:8DC1             dw B214

; 69Bh. Bottom half - F0h: Facing right - grabbed by Draygon - moving
$92:8DC3             dw B0AF, B1FE, B1C8, B0AF, B0C7, B04D

; 6A1h. Bottom half - BEh: Facing left  - grabbed by Draygon - moving
$92:8DCF             dw B0BB, B214, B1E3, B0BB, B0E2, B06D

; 6A7h. Bottom half - C9h: Facing right - shinespark - horizontal
$92:8DDB             dw AF75

; 6A8h. Bottom half - CAh: Facing left  - shinespark - horizontal
$92:8DDD             dw AF8B

; 6A9h. Bottom half - CDh: Facing right - shinespark - diagonal
$92:8DDF             dw AF75

; 6AAh. Bottom half - CEh: Facing left  - shinespark - diagonal
$92:8DE1             dw AF8B

; 6ABh. Bottom half - D3h: Facing right - crystal flash
$92:8DE3             dw C276, C28C, C2DE, C2DE, 0000, 0000, C2DE, C2DE, C2DE, C2DE, 0000, 0000, C28C, C276, B021

; 6BAh. Bottom half - D4h: Facing left  - crystal flash
$92:8E01             dw C276, C28C, C2DE, C2DE, 0000, 0000, C2DE, C2DE, C2DE, C2DE, 0000, 0000, C28C, C276, B037

; 6C9h. Bottom half - D7h: Facing right - crystal flash ending (frames 0..2 are unused)
$92:8E1F             dw 0000, 0000, 0000, B021, B0AF, B1FE

; 6CFh. Bottom half - D8h: Facing left  - crystal flash ending (frames 0..2 are unused)
$92:8E2B             dw 0000, 0000, 0000, B037, B0BB, B214

; 6D5h. Bottom half - E8h: Facing right - Samus drained - crouching/falling (frames 0..1 are unused)
$92:8E37             dw 0000, 0000, 0000, B0AF, B0AF, B0AF, B0AF, B0AF, B242, B242, B242, B242, 0000, 0000, B021

; 6E4h. Bottom half - E9h: Facing left  - Samus drained - crouching/falling (frames 0..1 are unused)
$92:8E55             dw 0000, 0000, B0BB, B0BB, B0BB, B0BB, B0BB, B037, B236, B236, B236, B236, 0000, 0000, B1E3, B037,
                        B2AB, 0000, 0000, B1E3, B037, B2AB, B037, B1E3, 0000, 0000, B236, 0000, 0000, B236

; 702h. Unused
$92:8E91             dw 0000, 0000

; 704h. Bottom half - EAh: Facing right - Samus drained - standing
$92:8E95             dw B242, B242, B242, B242, 0000, B021

; 70Ah. Bottom half - EBh: Facing left  - Samus drained - standing
$92:8EA1             dw B236, B236, B236, B236, 0000, B037

; 710h
; Top half - 1Dh: Facing right - morph ball - no springball - on ground
; Top half - 31h: Facing right - morph ball - no springball - in air
; Top half - 32h: Facing left  - morph ball - no springball - in air
; Top half - 3Fh: Unused (only frame 0 used)
; Top half - 40h: Unused (only frame 0 used)
$92:8EAD             dw BAB3, BAE3, BABF, BAFE, BACB, BB0A, BAD7, BB16, 0000, BC88

; 71Ah
; Top half - 41h: Facing left  - morph ball - no springball - on ground
; Top half - C5h: Unused
; Top half - DFh: Unused
; Bottom half - C5h: Unused
; Bottom half - DFh: Unused
$92:8EC1             dw BB16, BAD7, BB0A, BACB, BAFE, BABF, BAE3, BAB3, 0000, BC88

; 724h. Top half - 1Eh: Moving right - morph ball - no springball - on ground
$92:8ED5             dw BAB3, BAE3, BABF, BAFE, BACB, BB0A, BAD7, BB16, 0000, BC88

; 72Eh. Top half - 1Fh: Moving left  - morph ball - no springball - on ground
$92:8EE9             dw BB16, BAD7, BB0A, BACB, BAFE, BABF, BAE3, BAB3, 0000, BC88

; 738h
; Top half - 79h: Facing right - morph ball - spring ball - on ground
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground
; Top half - 7Dh: Facing right - morph ball - spring ball - falling
; Top half - 7Fh: Facing right - morph ball - spring ball - in air
$92:8EFD             dw BAB3, BAE3, BABF, BAFE, BACB, BB0A, BAD7, BB16, 0000, BC88

; 742h
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling
; Top half - 80h: Facing left  - morph ball - spring ball - in air
$92:8F11             dw BB16, BAD7, BB0A, BACB, BAFE, BABF, BAE3, BAB3, 0000, BC88

; 74Ch. Top half - 19h: Facing right - spin jump
$92:8F25             dw 9BAE, BD67, BD73, BD89, BD95, BDAB, BDB7, BDCD, BDD9, 0000, 0000, 9B43

; 758h. Bottom half - 19h: Facing right - spin jump (frames 1..Ah are unused)
$92:8F3D             dw B1C8, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, AFB2

; 764h. Top half - 1Ah: Facing left  - spin jump
$92:8F55             dw 9BBF, BB22, BB2E, BB44, BB50, BB66, BB72, BB88, BB94, 0000, 0000, 9B59

; 770h. Bottom half - 1Ah: Facing left  - spin jump (frames 1..Ah are unused)
$92:8F6D             dw B1E3, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, AFBE

; 77Ch. Top half - 1Bh: Facing right - space jump
$92:8F85             dw 9BAE, BEBF, BEBF, BEBF, BEBF, BEBF, BEBF, BEBF, BEBF, 0000, 0000, 9B43

; 788h. Bottom half - 1Bh: Facing right - space jump
$92:8F9D             dw B1C8, C458, C46E, C4A2, C4B8, C4EC, C502, C536, C54C, 0000, 0000, AFB2

; 794h. Top half - 1Ch: Facing left  - space jump
$92:8FB5             dw 9BBF, BC7A, BC7A, BC7A, BC7A, BC7A, BC7A, BC7A, BC7A, 0000, 0000, 9B59

; 7A0h. Bottom half - 1Ch: Facing left  - space jump
$92:8FCD             dw B1E3, C330, C346, C37A, C390, C3C4, C3DA, C40E, C424, 0000, 0000, AFBE

; 7ACh. Top half - 81h: Facing right - screw attack
$92:8FE5             dw 9BAE, BDEF, BDEF, BDEF, BEBF, BEBF, BEBF, BE23, BE23, BE23, BEBF, BEBF, BEBF, BE5C, BE5C, BE5C,
                        BEBF, BEBF, BEBF, BE95, BE95, BE95, BEBF, BEBF, BEBF, 0000, 0000, 9B43

; 7C8h. Bottom half - 81h: Facing right - screw attack
$92:901D             dw B1C8, C458, C46E, C4A2, C4B8, C4EC, C502, C536, C54C, C458, C46E, C4A2, C4B8, C4EC, C502, C536,
                        C54C, C458, C46E, C4A2, C4B8, C4EC, C502, C536, C54C, 0000, 0000, AFB2

; 7E4h. Top half - 82h: Facing left  - screw attack
$92:9055             dw 9BBF, BBAA, BBAA, BBAA, BC7A, BC7A, BC7A, BBDE, BBDE, BBDE, BC7A, BC7A, BC7A, BC17, BC17, BC17,
                        BC7A, BC7A, BC7A, BC50, BC50, BC50, BC7A, BC7A, BC7A, 0000, 0000, 9B59

; 800h. Bottom half - 82h: Facing left  - screw attack
$92:908D             dw B1E3, C330, C346, C37A, C390, C3C4, C3DA, C40E, C424, C330, C346, C37A, C390, C3C4, C3DA, C40E,
                        C424, C330, C346, C37A, C390, C3C4, C3DA, C40E, C424, 0000, 0000, AFBE

; 81Ch. Samus suit exploding - facing right. Indexed by [death animation index]
$92:90C5             dw C8B7, C8E6, C956, C9DA, CA54, CAD3, CB52, CB7C, CBB5

; 825h. Samus suit exploding - facing left. Indexed by [death animation index]
$92:90D7             dw C580, C5AF, C61F, C6A3, C71D, C79C, C81B, C845, C87E

; 82Eh. Top half - CBh: Facing right - shinespark - vertical
$92:90E9             dw C162

; 82Fh. Top half - CCh: Facing left  - shinespark - vertical
$92:90EB             dw C17D
}


;;; $90ED: Samus spritemaps - debug ;;;
{
; See $81:8A5F for spritemap format

; Unused. Samus spritemap table index 0
$92:90ED             dx 0001, 01FC,FC,315A

; Unused. Samus spritemap table index 1
$92:90F4             dx 0019, 0039,E8,3136, 0031,E8,3144, 0029,E8,3131, 0021,E8,3134, 0019,E8,3133, 0010,08,314B, 0008,08,313D, 0000,08,313E, 01F8,08,3138, 01F0,08,3143, 01E8,08,313F, 01E0,08,313E, 0010,F8,314A, 0008,F8,313D, 0000,F8,313E, 01F8,F8,3138, 01F0,F8,3143, 01E8,F8,313F, 01E0,F8,313E, 0008,E8,313B, 0000,E8,3130, 01F8,E8,3144, 01F0,E8,3142, 01E8,E8,3138, 01E0,E8,3145

; Unused
$92:9173             dx 0001, 0000,00,3A5F

; Debug Samus tile viewer - Samus top half
$92:917A             dx 0010, 0018,00,3817, 0010,00,3816, 0008,00,3815, 0000,00,3814, 01F8,00,3813, 01F0,00,3812, 01E8,00,3811, 01E0,00,3810, 0018,F8,3807, 0010,F8,3806, 0008,F8,3805, 0000,F8,3804, 01F8,F8,3803, 01F0,F8,3802, 01E8,F8,3801, 01E0,F8,3800

; Debug Samus tile viewer - Samus bottom half
$92:91CC             dx 0010, 0018,00,381F, 0010,00,381E, 0008,00,381D, 0000,00,381C, 01F8,00,381B, 01F0,00,381A, 01E8,00,3819, 01E0,00,3818, 0018,F8,380F, 0010,F8,380E, 0008,F8,380D, 0000,F8,380C, 01F8,F8,380B, 01F0,F8,380A, 01E8,F8,3809, 01E0,F8,3808

; Debug Samus tile viewer - beam
$92:921E             dx 0008, 0018,00,3C37, 0010,00,3C36, 0008,00,3C35, 0000,00,3C34, 01F8,00,3C33, 01F0,00,3C32, 01E8,00,3C31, 01E0,00,3C30

; Debug Samus tile viewer - grapple beam
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
                        04ED,04E3,04ED,0507,0509,050B,050D,0503,0505,0758,0770,0788,07A0,0710,0724,072E,
                        074C,074C,074C,074C,074C,0687,068A,065F,0668,063B,0642,064D,0650,0649,064B,068D,
                        0690,0710,0710,074C,074C,0679,067A,0405,0407,074C,074C,0679,067A,0409,040B,0710,
                        0710,071A,074C,068D,0690,04E3,04ED,04AA,04B3,04F7,04FD,051B,051C,051D,0523,0529,
                        0533,050F,0511,05B1,05B3,051B,051C,051B,051C,051B,051C,05B5,05B6,05B7,05B7,05B7,
                        05B7,05B7,05F9,053D,053F,0541,054A,063B,0642,0513,0515,0517,0519,0653,0656,0659,
                        065C,0671,0672,0673,0674,04F7,04FD,04F7,04FD,0738,0742,0738,0742,0738,0742,0738,
                        0742,07C8,0800,0553,0582,0675,0677,068D,0696,04AA,04B3,0687,068A,0687,068A,068D,
                        0690,068D,0690,068D,0696,068D,0696,068D,0690,068D,0690,0122,0687,068A,068D,0690,
                        068D,0696,068D,0690,04C5,04C7,04C9,04CC,04AA,04B3,04C0,04C2,0507,0509,0503,0505,
                        0517,0519,05B7,05F9,065F,0668,0673,0674,05B5,05B6,069A,069A,069A,069A,06A1,0687,
                        068A,0687,068A,0687,068A,071A,0687,051D,0523,06A7,06A8,082E,082F,06A9,06AA,04C0,
                        04C2,04C0,04C2,06AB,06BA,04CF,04D4,06C9,06CF,04D9,04DE,067D,0680,0681,0684,071A,
                        04C5,04C7,04C5,04C7,04C5,04C7,04C5,04C7,06D5,06E4,0704,070A,0699,0699,0699,0699,
                        069B,0679,067A,0679,067A,0679,067A,0679,067A,0679,067A,0679,067A
}


;;; $9657: Samus spritemaps ;;;
{
; See $81:8A5F for spritemap format

; Top half - 9: Moving right - not aiming - frame 0
; Top half - 9: Moving right - not aiming - frame 5
; Top half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 3
; Top half - C7h: Facing right - vertical shinespark windup - frame 3
; Top half - F0h: Facing right - grabbed by Draygon - moving - frame 2
; Top half - F0h: Facing right - grabbed by Draygon - moving - frame 5
$92:9657             dx 0002, C3FB,F8,2800, C3FB,F0,2802

; Top half - 9: Moving right - not aiming - frame 4
; Top half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 4
; Top half - C7h: Facing right - vertical shinespark windup - frame 4
; Top half - F0h: Facing right - grabbed by Draygon - moving - frame 0
$92:9663             dx 0002, C3FB,F7,2800, C3FB,EF,2802

; Top half - 9: Moving right - not aiming - frame 2
; Top half - F0h: Facing right - grabbed by Draygon - moving - frame 1
$92:966F             dx 0003, C3FF,F7,2800, 0007,EF,2804, C3F7,EF,2802

; Top half - 9: Moving right - not aiming - frame 3
$92:9680             dx 0003, 0008,EE,2804, C200,F6,2800, C3F8,EE,2802

; Top half - 9: Moving right - not aiming - frame 9
; Top half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 0
; Top half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 2
; Top half - C7h: Facing right - vertical shinespark windup - frame 0
; Top half - C7h: Facing right - vertical shinespark windup - frame 2
; Top half - F0h: Facing right - grabbed by Draygon - moving - frame 3
$92:9691             dx 0002, C3F9,F7,2800, C3F9,EF,2802

; Top half - 9: Moving right - not aiming - frame 7
; Top half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 1
; Top half - C7h: Facing right - vertical shinespark windup - frame 1
; Top half - F0h: Facing right - grabbed by Draygon - moving - frame 4
$92:969D             dx 0003, C3FE,EF,2800, C3F6,F7,2802, C3F6,EF,2804

; Top half - Ah: Moving left  - not aiming - frame 0
; Top half - Ah: Moving left  - not aiming - frame 5
; Top half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 3
; Top half - BEh: Facing left  - grabbed by Draygon - moving - frame 2
; Top half - BEh: Facing left  - grabbed by Draygon - moving - frame 5
; Top half - C8h: Facing left  - vertical shinespark windup - frame 3
$92:96AE             dx 0002, C3F5,F8,2800, C3F5,F0,2802

; Top half - Ah: Moving left  - not aiming - frame 4
; Top half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 4
; Top half - BEh: Facing left  - grabbed by Draygon - moving - frame 0
; Top half - C8h: Facing left  - vertical shinespark windup - frame 4
$92:96BA             dx 0002, C3F5,F7,2800, C3F5,EF,2802

; Top half - Ah: Moving left  - not aiming - frame 2
; Top half - BEh: Facing left  - grabbed by Draygon - moving - frame 1
$92:96C6             dx 0003, C3F1,F7,2800, C3F9,EF,2802, C3F1,EF,2804

; Top half - Ah: Moving left  - not aiming - frame 3
$92:96D7             dx 0003, C3F0,F6,2800, C3F0,EE,2802, C3F8,EE,2804

; Top half - Ah: Moving left  - not aiming - frame 9
; Top half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 0
; Top half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 2
; Top half - BEh: Facing left  - grabbed by Draygon - moving - frame 3
; Top half - C8h: Facing left  - vertical shinespark windup - frame 0
; Top half - C8h: Facing left  - vertical shinespark windup - frame 2
$92:96E8             dx 0002, C3F7,F7,2800, C3F7,EF,2802

; Top half - Ah: Moving left  - not aiming - frame 7
; Top half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 1
; Top half - BEh: Facing left  - grabbed by Draygon - moving - frame 4
; Top half - C8h: Facing left  - vertical shinespark windup - frame 1
$92:96F4             dx 0003, C3FA,F7,2800, 0002,EF,2804, C3F2,EF,2802

; Top half - 11h: Moving right - aiming down-right - frame 0
; Top half - 11h: Moving right - aiming down-right - frame 1
; Top half - 11h: Moving right - aiming down-right - frame 5
; Top half - 11h: Moving right - aiming down-right - frame 6
; Top half - 17h: Facing right - normal jump - aiming down - frame 0
; Top half - 2Dh: Facing right - falling - aiming down - frame 0
; Top half - 6Bh: Facing right - normal jump - aiming down-right - frame 0
; Top half - 6Bh: Facing right - normal jump - aiming down-right - frame 1
; Top half - 6Fh: Facing right - falling - aiming down-right - frame 0
; Top half - 6Fh: Facing right - falling - aiming down-right - frame 1
; Top half - 6Fh: Facing right - falling - aiming down-right - frame 2
; Top half - 78h: Facing right - moonwalk - aiming down-right - frame 0
; Top half - 78h: Facing right - moonwalk - aiming down-right - frame 3
; Top half - AEh: Unused. Facing right - grappling - in air - aiming down - frame 0
; Top half - B0h: Unused. Facing right - grappling - in air - aiming down-right - frame 0
; Top half - B0h: Unused. Facing right - grappling - in air - aiming down-right - frame 1
; Top half - EFh: Facing right - grabbed by Draygon - not moving - aiming down-right - frame 0
$92:9705             dx 0006, 01FD,FB,2802, 0005,F3,2803, 01FD,F3,2804, 000B,01,2805, 0007,FD,2806, C3FA,F0,2800

; Top half - 12h: Moving left  - aiming down-left - frame 0
; Top half - 12h: Moving left  - aiming down-left - frame 1
; Top half - 12h: Moving left  - aiming down-left - frame 5
; Top half - 12h: Moving left  - aiming down-left - frame 6
; Top half - 18h: Facing left  - normal jump - aiming down - frame 0
; Top half - 2Eh: Facing left  - falling - aiming down - frame 0
; Top half - 6Ch: Facing left  - normal jump - aiming down-left - frame 0
; Top half - 6Ch: Facing left  - normal jump - aiming down-left - frame 1
; Top half - 70h: Facing left  - falling - aiming down-left - frame 0
; Top half - 70h: Facing left  - falling - aiming down-left - frame 1
; Top half - 70h: Facing left  - falling - aiming down-left - frame 2
; Top half - 77h: Facing left  - moonwalk - aiming down-left - frame 0
; Top half - 77h: Facing left  - moonwalk - aiming down-left - frame 3
; Top half - AFh: Unused. Facing left  - grappling - in air - aiming down - frame 0
; Top half - B1h: Unused. Facing left  - grappling - in air - aiming down-left - frame 0
; Top half - B1h: Unused. Facing left  - grappling - in air - aiming down-left - frame 1
; Top half - BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left - frame 0
$92:9725             dx 0006, 01ED,01,6802, 01F1,FD,6803, 01FC,FB,2804, 01F4,F3,2805, 01FC,F3,2806, C3F6,F0,2800

; Top half - 7: Facing right - aiming down-right - frame 0
; Top half - 59h: Facing right - normal jump transition - aiming down-right - frame 0
; Top half - 73h: Facing right - crouching - aiming down-right - frame 0
; Top half - AAh: Facing right - grappling - aiming down-right - frame 0
; Top half - B6h: Facing right - grappling - crouching - aiming down-right - frame 0
; Top half - D1h: Facing right - ran into a wall - aiming down-right - frame 0
; Top half - E4h: Facing right - landing from normal jump - aiming down-right - frame 0
; Top half - E4h: Facing right - landing from normal jump - aiming down-right - frame 1
; Top half - F5h: Facing right - crouching transition - aiming down-right - frame 0
; Top half - FBh: Facing right - standing transition - aiming down-right - frame 0
$92:9745             dx 0005, 0006,01,2804, C3FE,F1,2800, C3F6,F1,2802, 000D,03,2805, 0009,FF,2806

; Top half - 8: Facing left  - aiming down-left - frame 0
; Top half - 5Ah: Facing left  - normal jump transition - aiming down-left - frame 0
; Top half - 74h: Facing left  - crouching - aiming down-left - frame 0
; Top half - ABh: Facing left  - grappling - aiming down-left - frame 0
; Top half - B7h: Facing left  - grappling - crouching - aiming down-left - frame 0
; Top half - D2h: Facing left  - ran into a wall - aiming down-left - frame 0
; Top half - E5h: Facing left  - landing from normal jump - aiming down-left - frame 0
; Top half - E5h: Facing left  - landing from normal jump - aiming down-left - frame 1
; Top half - F6h: Facing left  - crouching transition - aiming down-left - frame 0
; Top half - FCh: Facing left  - standing transition - aiming down-left - frame 0
$92:9760             dx 0005, 01EF,FF,6804, 01F0,01,2805, C3F0,F1,2800, 01EB,03,6806, C3F8,F1,2802

; Top half - 13h: Facing right - normal jump - not aiming - not moving - gun extended - frame 0
; Top half - 13h: Facing right - normal jump - not aiming - not moving - gun extended - frame 1
; Top half - 35h: Facing right - crouching transition - frame 0
; Top half - 3Bh: Facing right - standing transition - frame 0
; Top half - 4Ah: Facing right - moonwalk - frame 0
; Top half - 4Ah: Facing right - moonwalk - frame 3
; Top half - 51h: Facing right - normal jump - not aiming - moving forward - frame 0
; Top half - 51h: Facing right - normal jump - not aiming - moving forward - frame 1
; Top half - 67h: Facing right - falling - gun extended - frame 0
; Top half - 67h: Facing right - falling - gun extended - frame 1
; Top half - 67h: Facing right - falling - gun extended - frame 2
; Top half - 67h: Facing right - falling - gun extended - frame 5
; Top half - 67h: Facing right - falling - gun extended - frame 6
; Top half - ACh: Unused. Facing right - grappling - in air - frame 0
; Top half - ACh: Unused. Facing right - grappling - in air - frame 1
; Top half - D3h: Facing right - crystal flash - frame Eh
; Top half - D5h: Facing right - x-ray - standing - frame 2
; Top half - D7h: Facing right - crystal flash ending - frame 3
; Top half - D9h: Facing right - x-ray - crouching - frame 2
; Top half - DBh: Unused - frame 0
; Top half - DDh: Unused - frame 2
; Top half - E6h: Facing right - landing from normal jump - firing - frame 0
; Top half - E6h: Facing right - landing from normal jump - firing - frame 1
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame Eh
; Top half - EAh: Facing right - Samus drained - standing - frame 5
; Top half - EEh: Facing right - grabbed by Draygon - firing - frame 0
$92:977B             dx 0005, 0001,00,2802, 01F9,00,2803, C3F9,F0,2800, 000A,FD,2804, 0002,FD,2805

; Top half - 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frame 0
; Top half - 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frame 1
; Top half - 36h: Facing left  - crouching transition - frame 0
; Top half - 3Ch: Facing left  - standing transition - frame 0
; Top half - 49h: Facing left  - moonwalk - frame 0
; Top half - 49h: Facing left  - moonwalk - frame 3
; Top half - 52h: Facing left  - normal jump - not aiming - moving forward - frame 0
; Top half - 52h: Facing left  - normal jump - not aiming - moving forward - frame 1
; Top half - 68h: Facing left  - falling - gun extended - frame 0
; Top half - 68h: Facing left  - falling - gun extended - frame 1
; Top half - 68h: Facing left  - falling - gun extended - frame 2
; Top half - 68h: Facing left  - falling - gun extended - frame 5
; Top half - 68h: Facing left  - falling - gun extended - frame 6
; Top half - ADh: Unused. Facing left  - grappling - in air - frame 0
; Top half - ADh: Unused. Facing left  - grappling - in air - frame 1
; Top half - BCh: Facing left  - grabbed by Draygon - firing - frame 0
; Top half - D4h: Facing left  - crystal flash - frame Eh
; Top half - D6h: Facing left  - x-ray - standing - frame 2
; Top half - D8h: Facing left  - crystal flash ending - frame 3
; Top half - DAh: Facing left  - x-ray - crouching - frame 2
; Top half - DCh: Unused - frame 0
; Top half - DEh: Unused - frame 2
; Top half - E7h: Facing left  - landing from normal jump - firing - frame 0
; Top half - E7h: Facing left  - landing from normal jump - firing - frame 1
; Top half - EBh: Facing left  - Samus drained - standing - frame 5
$92:9796             dx 0005, 01FF,00,2802, 01F7,00,2803, C3F7,F0,2800, 01EE,FD,6804, 01F6,FD,6805

; Top half - 3: Facing right - aiming up - frame 0
; Top half - 5: Facing right - aiming up-right - frame 0
; Top half - 15h: Facing right - normal jump - aiming up - frame 0
; Top half - 2Bh: Facing right - falling - aiming up - frame 0
; Top half - 57h: Facing right - normal jump transition - aiming up-right - frame 0
; Top half - 71h: Facing right - crouching - aiming up-right - frame 0
; Top half - 85h: Facing right - crouching - aiming up - frame 0
; Top half - CFh: Facing right - ran into a wall - aiming up-right - frame 0
; Top half - E2h: Facing right - landing from normal jump - aiming up-right - frame 0
; Top half - E2h: Facing right - landing from normal jump - aiming up-right - frame 1
; Top half - F3h: Facing right - crouching transition - aiming up-right - frame 0
; Top half - F9h: Facing right - standing transition - aiming up-right - frame 0
$92:97B1             dx 0004, 000A,EE,6804, C3FF,F1,2800, 000E,EA,6805, C3F7,F1,2802

; Top half - 4: Facing left  - aiming up - frame 0
; Top half - 6: Facing left  - aiming up-left - frame 0
; Top half - 16h: Facing left  - normal jump - aiming up - frame 0
; Top half - 2Ch: Facing left  - falling - aiming up - frame 0
; Top half - 58h: Facing left  - normal jump transition - aiming up-left - frame 0
; Top half - 72h: Facing left  - crouching - aiming up-left - frame 0
; Top half - 86h: Facing left  - crouching - aiming up - frame 0
; Top half - D0h: Facing left  - ran into a wall - aiming up-left - frame 0
; Top half - E3h: Facing left  - landing from normal jump - aiming up-left - frame 0
; Top half - E3h: Facing left  - landing from normal jump - aiming up-left - frame 1
; Top half - F4h: Facing left  - crouching transition - aiming up-left - frame 0
; Top half - FAh: Facing left  - standing transition - aiming up-left - frame 0
$92:97C7             dx 0004, 01EA,E9,2804, C3F1,F1,2800, 01EE,ED,2805, C3F9,F1,2802

; Top half - 46h: Unused - frame 0
; Top half - 46h: Unused - frame 1
; Top half - 46h: Unused - frame 5
; Top half - 46h: Unused - frame 6
; Top half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 5
; Top half - C7h: Facing right - vertical shinespark windup - frame 5
$92:97DD             dx 0003, C3FF,F8,2800, 0007,F0,2804, C3F7,F0,2802

; Top half - 45h: Unused - frame 0
; Top half - 45h: Unused - frame 1
; Top half - 45h: Unused - frame 5
; Top half - 45h: Unused - frame 6
; Top half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 5
; Top half - C8h: Facing left  - vertical shinespark windup - frame 5
$92:97EE             dx 0003, C3F1,F8,2800, C3F9,F0,2802, C3F1,F0,2804

; Top half - 3: Facing right - aiming up - frame 1
; Top half - Dh: Moving right - aiming up (unused) - frame 0
; Top half - Dh: Moving right - aiming up (unused) - frame 1
; Top half - Dh: Moving right - aiming up (unused) - frame 5
; Top half - Dh: Moving right - aiming up (unused) - frame 6
; Top half - 15h: Facing right - normal jump - aiming up - frame 1
; Top half - 2Bh: Facing right - falling - aiming up - frame 1
; Top half - 2Bh: Facing right - falling - aiming up - frame 2
; Top half - 55h: Facing right - normal jump transition - aiming up - frame 0
; Top half - 85h: Facing right - crouching - aiming up - frame 1
; Top half - E0h: Facing right - landing from normal jump - aiming up - frame 0
; Top half - E0h: Facing right - landing from normal jump - aiming up - frame 1
; Top half - F1h: Facing right - crouching transition - aiming up - frame 0
; Top half - F7h: Facing right - standing transition - aiming up - frame 0
$92:97FF             dx 0005, 01F9,F9,2802, 01F9,F1,2803, 01FE,E1,2804, 01FE,E9,2805, C3F9,F1,2800

; Top half - 4: Facing left  - aiming up - frame 1
; Top half - Eh: Moving left  - aiming up (unused) - frame 0
; Top half - Eh: Moving left  - aiming up (unused) - frame 1
; Top half - Eh: Moving left  - aiming up (unused) - frame 5
; Top half - Eh: Moving left  - aiming up (unused) - frame 6
; Top half - 16h: Facing left  - normal jump - aiming up - frame 1
; Top half - 2Ch: Facing left  - falling - aiming up - frame 1
; Top half - 2Ch: Facing left  - falling - aiming up - frame 2
; Top half - 56h: Facing left  - normal jump transition - aiming up - frame 0
; Top half - 86h: Facing left  - crouching - aiming up - frame 1
; Top half - E1h: Facing left  - landing from normal jump - aiming up - frame 0
; Top half - E1h: Facing left  - landing from normal jump - aiming up - frame 1
; Top half - F2h: Facing left  - crouching transition - aiming up - frame 0
; Top half - F8h: Facing left  - standing transition - aiming up - frame 0
$92:981A             dx 0005, 01FF,F9,2802, 01FF,F1,2803, 01FA,E1,6804, C3F7,F1,2800, 01FA,E9,6805

; Top half - 9: Moving right - not aiming - frame 8
$92:9835             dx 0003, C3FF,EE,2800, 01F7,FE,2804, C3F7,EE,2802

; Top half - Ah: Moving left  - not aiming - frame 8
$92:9846             dx 0003, C3F1,EE,2800, 0001,FE,2804, C3F9,EE,2802

; Top half - Fh: Moving right - aiming up-right - frame 0
; Top half - Fh: Moving right - aiming up-right - frame 1
; Top half - Fh: Moving right - aiming up-right - frame 5
; Top half - Fh: Moving right - aiming up-right - frame 6
; Top half - 69h: Facing right - normal jump - aiming up-right - frame 0
; Top half - 69h: Facing right - normal jump - aiming up-right - frame 1
; Top half - 6Dh: Facing right - falling - aiming up-right - frame 0
; Top half - 6Dh: Facing right - falling - aiming up-right - frame 1
; Top half - 6Dh: Facing right - falling - aiming up-right - frame 2
; Top half - 76h: Facing right - moonwalk - aiming up-right - frame 0
; Top half - 76h: Facing right - moonwalk - aiming up-right - frame 3
; Top half - EDh: Facing right - grabbed by Draygon - not moving - aiming up-right - frame 0
$92:9857             dx 0005, 000C,EA,6802, 01FD,F8,2803, 01FD,F0,2804, 0008,EE,6805, C3FB,F0,2800

; Top half - 10h: Moving left  - aiming up-left - frame 0
; Top half - 10h: Moving left  - aiming up-left - frame 1
; Top half - 10h: Moving left  - aiming up-left - frame 5
; Top half - 10h: Moving left  - aiming up-left - frame 6
; Top half - 6Ah: Facing left  - normal jump - aiming up-left - frame 0
; Top half - 6Ah: Facing left  - normal jump - aiming up-left - frame 1
; Top half - 6Eh: Facing left  - falling - aiming up-left - frame 0
; Top half - 6Eh: Facing left  - falling - aiming up-left - frame 1
; Top half - 6Eh: Facing left  - falling - aiming up-left - frame 2
; Top half - 75h: Facing left  - moonwalk - aiming up-left - frame 0
; Top half - 75h: Facing left  - moonwalk - aiming up-left - frame 3
; Top half - BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left - frame 0
$92:9872             dx 0006, 01FB,FB,2802, 01FB,F3,2803, 01F3,F3,2804, 01EC,EA,2805, 01F0,EE,2806, C3F5,F0,2800

; Top half - 54h: Facing left  - knockback - frame 0
; Top half - 54h: Facing left  - knockback - frame 1
; Top half - D8h: Facing left  - crystal flash ending - frame 4
; Top half - D8h: Facing left  - crystal flash ending - frame 5
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 2
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 3
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 4
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 5
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 6
$92:9892             dx 0005, 01F7,F1,6806, 01F3,F5,6807, C3F3,F0,2800, C3FB,E8,2802, C3FB,F0,2804

; Top half - 53h: Facing right - knockback - frame 0
; Top half - 53h: Facing right - knockback - frame 1
; Top half - D7h: Facing right - crystal flash ending - frame 4
; Top half - D7h: Facing right - crystal flash ending - frame 5
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 3
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 4
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 5
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 6
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 7
$92:98AD             dx 0005, 0004,F4,6806, 0000,F8,6807, C3F5,E8,6800, C3FD,F0,6802, C3F5,F0,6804

; Top half - 8Bh: Facing right - turning - standing - aiming up - frame 1
; Top half - 8Ch: Facing left  - turning - standing - aiming up - frame 1
; Top half - 8Fh: Facing right - turning - in air - aiming up - frame 1
; Top half - 90h: Facing left  - turning - in air - aiming up - frame 1
; Top half - 93h: Facing right - turning - falling - aiming up - frame 1
; Top half - 94h: Facing left  - turning - falling - aiming up - frame 1
; Top half - 97h: Facing right - turning - crouching - aiming up - frame 1
; Top half - 98h: Facing left  - turning - crouching - aiming up - frame 1
; Top half - 9Ch: Facing right - turning - standing - aiming up-right - frame 1
; Top half - 9Dh: Facing left  - turning - standing - aiming up-left - frame 1
; Top half - 9Eh: Facing right - turning - in air - aiming up-right - frame 1
; Top half - 9Fh: Facing left  - turning - in air - aiming up-left - frame 1
; Top half - A0h: Facing right - turning - falling - aiming up-right - frame 1
; Top half - A1h: Facing left  - turning - falling - aiming up-left - frame 1
; Top half - A2h: Facing right - turning - crouching - aiming up-right - frame 1
; Top half - A3h: Facing left  - turning - crouching - aiming up-left - frame 1
; Top half - C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 1
; Top half - C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 1
$92:993E             dx 0004, 01F4,E8,2806, C3FC,E8,2800, C3FC,F0,2802, C3F4,F0,2804

; Top half - 8Dh: Facing right - turning - standing - aiming down-right - frame 1
; Top half - 8Eh: Facing left  - turning - standing - aiming down-left - frame 1
; Top half - 91h: Facing right - turning - in air - aiming down/down-right - frame 1
; Top half - 92h: Facing left  - turning - in air - aiming down/down-left - frame 1
; Top half - 95h: Facing right - turning - falling - aiming down/down-right - frame 1
; Top half - 96h: Facing left  - turning - falling - aiming down/down-left - frame 1
; Top half - 99h: Facing right - turning - crouching - aiming down/down-right - frame 1
; Top half - 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 1
; Top half - C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 1
; Top half - C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 1
$92:9954             dx 0005, 01F4,00,2806, 0004,F8,2807, C3FC,E8,2800, C3F4,E8,2802, C3F4,F0,2804

; Top half - 9Bh: Facing forward - varia/gravity suit - frame 0
$92:9976             dx 0002, C3FF,F0,6800, C3F0,F0,2800

; Top half - 25h: Facing right - turning - standing - frame 2
; Top half - 26h: Facing left  - turning - standing - frame 0
; Top half - 2Fh: Facing right - turning - jumping - frame 2
; Top half - 30h: Facing left  - turning - jumping - frame 0
; Top half - 43h: Facing right - turning - crouching - frame 2
; Top half - 44h: Facing left  - turning - crouching - frame 0
; Top half - 87h: Facing right - turning - falling - frame 2
; Top half - 88h: Facing left  - turning - falling - frame 0
; Top half - BFh: Facing right - moonwalking - turn/jump left - frame 2
; Top half - C0h: Facing left  - moonwalking - turn/jump right - frame 0
; Top half - C6h: Unused - frame 2
$92:9982             dx 0004, 0004,E8,2804, 01FC,E8,2805, C3FC,F0,2800, C3F4,F0,2802

; Top half - 25h: Facing right - turning - standing - frame 0
; Top half - 26h: Facing left  - turning - standing - frame 2
; Top half - 2Fh: Facing right - turning - jumping - frame 0
; Top half - 30h: Facing left  - turning - jumping - frame 2
; Top half - 43h: Facing right - turning - crouching - frame 0
; Top half - 44h: Facing left  - turning - crouching - frame 2
; Top half - 87h: Facing right - turning - falling - frame 0
; Top half - 88h: Facing left  - turning - falling - frame 2
; Top half - BFh: Facing right - moonwalking - turn/jump left - frame 0
; Top half - C0h: Facing left  - moonwalking - turn/jump right - frame 2
; Top half - C6h: Unused - frame 0
$92:9998             dx 0004, 01F5,E8,6804, 01FD,E8,6805, C3F2,F0,2800, C3FA,F0,2802

; Top half - 8Bh: Facing right - turning - standing - aiming up - frame 2
; Top half - 8Ch: Facing left  - turning - standing - aiming up - frame 0
; Top half - 8Fh: Facing right - turning - in air - aiming up - frame 2
; Top half - 90h: Facing left  - turning - in air - aiming up - frame 0
; Top half - 93h: Facing right - turning - falling - aiming up - frame 2
; Top half - 94h: Facing left  - turning - falling - aiming up - frame 0
; Top half - 97h: Facing right - turning - crouching - aiming up - frame 2
; Top half - 98h: Facing left  - turning - crouching - aiming up - frame 0
; Top half - 9Ch: Facing right - turning - standing - aiming up-right - frame 2
; Top half - 9Dh: Facing left  - turning - standing - aiming up-left - frame 0
; Top half - 9Eh: Facing right - turning - in air - aiming up-right - frame 2
; Top half - 9Fh: Facing left  - turning - in air - aiming up-left - frame 0
; Top half - A0h: Facing right - turning - falling - aiming up-right - frame 2
; Top half - A1h: Facing left  - turning - falling - aiming up-left - frame 0
; Top half - A2h: Facing right - turning - crouching - aiming up-right - frame 2
; Top half - A3h: Facing left  - turning - crouching - aiming up-left - frame 0
; Top half - C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 2
; Top half - C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 0
$92:99AE             dx 0006, 01F3,E8,2802, 0003,E8,2803, 01FB,E8,2804, 0003,F8,2805, 0003,F0,2806, C3F3,F0,2800

; Top half - 8Bh: Facing right - turning - standing - aiming up - frame 0
; Top half - 8Ch: Facing left  - turning - standing - aiming up - frame 2
; Top half - 8Fh: Facing right - turning - in air - aiming up - frame 0
; Top half - 90h: Facing left  - turning - in air - aiming up - frame 2
; Top half - 93h: Facing right - turning - falling - aiming up - frame 0
; Top half - 94h: Facing left  - turning - falling - aiming up - frame 2
; Top half - 97h: Facing right - turning - crouching - aiming up - frame 0
; Top half - 98h: Facing left  - turning - crouching - aiming up - frame 2
; Top half - 9Ch: Facing right - turning - standing - aiming up-right - frame 0
; Top half - 9Dh: Facing left  - turning - standing - aiming up-left - frame 2
; Top half - 9Eh: Facing right - turning - in air - aiming up-right - frame 0
; Top half - 9Fh: Facing left  - turning - in air - aiming up-left - frame 2
; Top half - A0h: Facing right - turning - falling - aiming up-right - frame 0
; Top half - A1h: Facing left  - turning - falling - aiming up-left - frame 2
; Top half - A2h: Facing right - turning - crouching - aiming up-right - frame 0
; Top half - A3h: Facing left  - turning - crouching - aiming up-left - frame 2
; Top half - C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 0
; Top half - C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 2
$92:99CE             dx 0005, 0004,E8,2802, 01FC,E8,2803, 01F4,F8,2804, 01F4,F0,2805, C3FC,F0,2800

; Top half - 25h: Facing right - turning - standing - frame 1
; Top half - 26h: Facing left  - turning - standing - frame 1
; Top half - 2Fh: Facing right - turning - jumping - frame 1
; Top half - 30h: Facing left  - turning - jumping - frame 1
; Top half - 43h: Facing right - turning - crouching - frame 1
; Top half - 44h: Facing left  - turning - crouching - frame 1
; Top half - 87h: Facing right - turning - falling - frame 1
; Top half - 88h: Facing left  - turning - falling - frame 1
; Top half - BFh: Facing right - moonwalking - turn/jump left - frame 1
; Top half - C0h: Facing left  - moonwalking - turn/jump right - frame 1
; Top half - C6h: Unused - frame 1
$92:99E9             dx 0004, 0004,E8,2806, C3F4,E8,2800, C3F4,F0,2802, C3FC,F0,2804

; Top half - 64h: Unused - frame 1
; Top half - B9h: Facing right - grapple wall jump pose - frame 0
$92:99FF             dx 0006, 01E2,F4,6804, 01EA,F4,6805, C3EC,F0,2800, 0004,08,2806, 0004,00,2807, C3FC,F0,2802

; Top half - 63h: Unused - frame 1
; Top half - B8h: Facing left  - grapple wall jump pose - frame 0
$92:9A1F             dx 0006, 0015,F4,2804, 000D,F4,2805, 01F4,08,2806, 01F4,00,2807, C204,F0,2800, C3F4,F0,2802

; Top half - 9: Moving right - not aiming - frame 1
$92:9A3F             dx 0002, C3FA,F8,2800, C3FA,F0,2802

; Top half - 9: Moving right - not aiming - frame 6
$92:9A4B             dx 0002, C3F8,F8,2800, C3F8,F0,2802

; Top half - Ah: Moving left  - not aiming - frame 1
$92:9A57             dx 0002, C3F6,F8,2800, C3F6,F0,2802

; Top half - Ah: Moving left  - not aiming - frame 6
$92:9A63             dx 0002, C3F8,F8,2800, C3F8,F0,2802

; Top half - 0: Facing forward - power suit - frame 0
$92:9A6F             dx 0002, C3FC,F0,2800, C3F4,F0,2802

; Top half - 65h: Unused - frame 0
; Top half - 83h: Facing right - wall jump - frame 0
$92:9A7B             dx 0002, C3FC,F0,2800, C204,F0,2802

; Top half - 66h: Unused - frame 0
; Top half - 84h: Facing left  - wall jump - frame 0
$92:9A87             dx 0002, C3F4,F0,6800, C3EC,F0,6802

; Top half - 63h: Unused - frame 0
; Top half - C9h: Facing right - shinespark - horizontal - frame 0
; Top half - CDh: Facing right - shinespark - diagonal - frame 0
$92:9A93             dx 0005, 01ED,F8,6806, 01F1,F4,6807, C200,F8,6800, C3F0,F0,6802, C200,F0,6804

; Top half - 64h: Unused - frame 0
; Top half - CAh: Facing left  - shinespark - horizontal - frame 0
; Top half - CEh: Facing left  - shinespark - diagonal - frame 0
$92:9AAE             dx 0005, 01F6,FC,6806, 01F2,00,6807, C3F0,F8,2800, C200,F0,2802, C3F0,F0,2804

; Top half - 8Dh: Facing right - turning - standing - aiming down-right - frame 2
; Top half - 8Eh: Facing left  - turning - standing - aiming down-left - frame 0
; Top half - 91h: Facing right - turning - in air - aiming down/down-right - frame 2
; Top half - 92h: Facing left  - turning - in air - aiming down/down-left - frame 0
; Top half - 95h: Facing right - turning - falling - aiming down/down-right - frame 2
; Top half - 96h: Facing left  - turning - falling - aiming down/down-left - frame 0
; Top half - 99h: Facing right - turning - crouching - aiming down/down-right - frame 2
; Top half - 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 0
; Top half - C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 2
; Top half - C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 0
$92:9AD7             dx 0006, 01F8,00,2802, 0004,E8,2803, 01FC,E8,2804, 0004,F8,2805, 0004,F0,2806, C3F4,F0,2800

; Top half - 8Dh: Facing right - turning - standing - aiming down-right - frame 0
; Top half - 8Eh: Facing left  - turning - standing - aiming down-left - frame 2
; Top half - 91h: Facing right - turning - in air - aiming down/down-right - frame 0
; Top half - 92h: Facing left  - turning - in air - aiming down/down-left - frame 2
; Top half - 95h: Facing right - turning - falling - aiming down/down-right - frame 0
; Top half - 96h: Facing left  - turning - falling - aiming down/down-left - frame 2
; Top half - 99h: Facing right - turning - crouching - aiming down/down-right - frame 0
; Top half - 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 2
; Top half - C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 0
; Top half - C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 2
$92:9AF7             dx 0006, 01F7,00,2802, 01F6,E8,6803, 01FE,E8,6804, 01F3,F8,2805, 01F3,F0,2806, C3FB,F0,2800

; Top half - 17h: Facing right - normal jump - aiming down - frame 1
; Top half - 2Dh: Facing right - falling - aiming down - frame 1
; Top half - AEh: Unused. Facing right - grappling - in air - aiming down - frame 1
$92:9B17             dx 0004, 01FF,05,E804, 01FF,0D,E805, C3F8,F0,2800, C3F8,F8,2802

; Top half - 18h: Facing left  - normal jump - aiming down - frame 1
; Top half - 2Eh: Facing left  - falling - aiming down - frame 1
; Top half - AFh: Unused. Facing left  - grappling - in air - aiming down - frame 1
$92:9B2D             dx 0004, 01F8,05,A804, 01F8,0D,A805, C3F8,F0,2800, C3F8,F8,2802

; Top half - 19h: Facing right - spin jump - frame Bh
; Top half - 1Bh: Facing right - space jump - frame Bh
; Top half - 81h: Facing right - screw attack - frame 1Bh
$92:9B43             dx 0004, C3F4,F0,2800, 000C,08,2804, 000C,00,2805, C204,F0,2802

; Top half - 1Ah: Facing left  - spin jump - frame Bh
; Top half - 1Ch: Facing left  - space jump - frame Bh
; Top half - 82h: Facing left  - screw attack - frame 1Bh
$92:9B59             dx 0004, C3FC,F0,2800, 01EC,08,2804, 01EC,00,2805, C3EC,F0,2802

; Top half - 4Bh: Facing right - normal jump transition - frame 0
; Top half - A4h: Facing right - landing from normal jump - frame 0
; Top half - A6h: Facing right - landing from spin jump - frame 1
$92:9B6F             dx 0003, 0001,FE,2802, 01F9,FE,2803, C3F7,F0,2800

; Top half - 4Ch: Facing left  - normal jump transition - frame 0
; Top half - A5h: Facing left  - landing from normal jump - frame 0
; Top half - A7h: Facing left  - landing from spin jump - frame 1
$92:9B80             dx 0002, C3F9,F8,2800, C3F9,F0,2802

; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 10h
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 15h
$92:9BA2             dx 0002, C3F9,F8,2800, C3F9,F0,2802

; Top half - 19h: Facing right - spin jump - frame 0
; Top half - 1Bh: Facing right - space jump - frame 0
; Top half - 29h: Facing right - falling - frame 0
; Top half - 29h: Facing right - falling - frame 6
; Top half - 50h: Facing right - damage boost - frame 0
; Top half - 50h: Facing right - damage boost - frame 1
; Top half - 81h: Facing right - screw attack - frame 0
; Top half - 83h: Facing right - wall jump - frame 1
; Top half - A4h: Facing right - landing from normal jump - frame 1
; Top half - A6h: Facing right - landing from spin jump - frame 0
; Top half - A6h: Facing right - landing from spin jump - frame 2
; Top half - ECh: Facing right - grabbed by Draygon - not moving - not aiming - frame 0
$92:9BAE             dx 0003, 01FB,00,2802, 01F7,FC,2803, C3F7,F0,2800

; Top half - 1Ah: Facing left  - spin jump - frame 0
; Top half - 1Ch: Facing left  - space jump - frame 0
; Top half - 2Ah: Facing left  - falling - frame 0
; Top half - 2Ah: Facing left  - falling - frame 6
; Top half - 4Fh: Facing left  - damage boost - frame 0
; Top half - 4Fh: Facing left  - damage boost - frame 1
; Top half - 82h: Facing left  - screw attack - frame 0
; Top half - 84h: Facing left  - wall jump - frame 1
; Top half - A5h: Facing left  - landing from normal jump - frame 1
; Top half - A7h: Facing left  - landing from spin jump - frame 0
; Top half - A7h: Facing left  - landing from spin jump - frame 2
; Top half - BAh: Facing left  - grabbed by Draygon - not moving - not aiming - frame 0
$92:9BBF             dx 0002, C3F9,F8,2800, C3F9,F0,2802

; Top half - 11h: Moving right - aiming down-right - frame 2
; Top half - 11h: Moving right - aiming down-right - frame 4
; Top half - 11h: Moving right - aiming down-right - frame 7
; Top half - 11h: Moving right - aiming down-right - frame 9
; Top half - 78h: Facing right - moonwalk - aiming down-right - frame 1
; Top half - 78h: Facing right - moonwalk - aiming down-right - frame 2
; Top half - 78h: Facing right - moonwalk - aiming down-right - frame 4
; Top half - 78h: Facing right - moonwalk - aiming down-right - frame 5
$92:9BCB             dx 0006, 01FD,F9,2802, 0005,F1,2803, 01FD,F1,2804, 000B,00,2805, 0007,FC,2806, C3FA,EF,2800

; Top half - 12h: Moving left  - aiming down-left - frame 2
; Top half - 12h: Moving left  - aiming down-left - frame 4
; Top half - 12h: Moving left  - aiming down-left - frame 7
; Top half - 12h: Moving left  - aiming down-left - frame 9
; Top half - 77h: Facing left  - moonwalk - aiming down-left - frame 1
; Top half - 77h: Facing left  - moonwalk - aiming down-left - frame 2
; Top half - 77h: Facing left  - moonwalk - aiming down-left - frame 4
; Top half - 77h: Facing left  - moonwalk - aiming down-left - frame 5
$92:9BEB             dx 0006, 01F1,FC,6802, 01ED,00,6803, 01FC,F9,2804, 01F4,F1,2805, 01FC,F1,2806, C3F6,EF,2800

; Top half - D5h: Facing right - x-ray - standing - frame 1
; Top half - D9h: Facing right - x-ray - crouching - frame 1
$92:9C0B             dx 0005, 01F9,F0,6802, 0001,F0,6803, C3F9,F8,2800, 000A,FD,2804, 0002,FD,2805

; Top half - D5h: Facing right - x-ray - standing - frame 0
; Top half - D9h: Facing right - x-ray - crouching - frame 0
$92:9C26             dx 0005, 01F9,F0,6802, 0001,F0,6803, C3F9,F8,2800, 000A,FD,2804, 0002,FD,2805

; Top half - D5h: Facing right - x-ray - standing - frame 3
; Top half - D9h: Facing right - x-ray - crouching - frame 3
$92:9C41             dx 0005, 01F9,F0,6802, 0001,F0,6803, C3F9,F8,2800, 000A,FD,2804, 0002,FD,2805

; Top half - D5h: Facing right - x-ray - standing - frame 4
; Top half - D9h: Facing right - x-ray - crouching - frame 4
$92:9C5C             dx 0005, 01F9,F0,6802, 0001,F0,6803, C3F9,F8,2800, 000A,FD,2804, 0002,FD,2805

; Top half - 46h: Unused - frame 2
; Top half - 46h: Unused - frame 4
; Top half - 46h: Unused - frame 7
; Top half - 46h: Unused - frame 9
; Top half - D6h: Facing left  - x-ray - standing - frame 1
; Top half - DAh: Facing left  - x-ray - crouching - frame 1
$92:9C77             dx 0005, 01F7,F0,2802, 01FF,F0,2803, C3F7,F8,2800, 01EE,FD,6804, 01F6,FD,6805

; Top half - 45h: Unused - frame 2
; Top half - 45h: Unused - frame 4
; Top half - 45h: Unused - frame 7
; Top half - 45h: Unused - frame 9
; Top half - D6h: Facing left  - x-ray - standing - frame 0
; Top half - DAh: Facing left  - x-ray - crouching - frame 0
$92:9C92             dx 0005, 01F7,F0,2802, 01FF,F0,2803, C3F7,F8,2800, 01EE,FD,6804, 01F6,FD,6805

; Top half - Dh: Moving right - aiming up (unused) - frame 2
; Top half - Dh: Moving right - aiming up (unused) - frame 4
; Top half - Dh: Moving right - aiming up (unused) - frame 7
; Top half - Dh: Moving right - aiming up (unused) - frame 9
; Top half - D6h: Facing left  - x-ray - standing - frame 3
; Top half - DAh: Facing left  - x-ray - crouching - frame 3
$92:9CAD             dx 0005, 01FF,F0,2802, 01F7,F0,2803, C3F7,F8,2800, 01EE,FD,6804, 01F6,FD,6805

; Top half - Eh: Moving left  - aiming up (unused) - frame 2
; Top half - Eh: Moving left  - aiming up (unused) - frame 4
; Top half - Eh: Moving left  - aiming up (unused) - frame 7
; Top half - Eh: Moving left  - aiming up (unused) - frame 9
; Top half - D6h: Facing left  - x-ray - standing - frame 4
; Top half - DAh: Facing left  - x-ray - crouching - frame 4
$92:9CC8             dx 0005, 01FF,F0,2802, 01F7,F0,2803, C3F7,F8,2800, 01EE,FD,6804, 01F6,FD,6805

; Top half - Fh: Moving right - aiming up-right - frame 2
; Top half - Fh: Moving right - aiming up-right - frame 4
; Top half - Fh: Moving right - aiming up-right - frame 7
; Top half - Fh: Moving right - aiming up-right - frame 9
; Top half - 76h: Facing right - moonwalk - aiming up-right - frame 1
; Top half - 76h: Facing right - moonwalk - aiming up-right - frame 2
; Top half - 76h: Facing right - moonwalk - aiming up-right - frame 4
; Top half - 76h: Facing right - moonwalk - aiming up-right - frame 5
$92:9CE3             dx 0005, 000C,E9,6802, 01FD,F6,2803, 01FD,EE,2804, 0008,ED,6805, C3FB,EF,2800

; Top half - 10h: Moving left  - aiming up-left - frame 2
; Top half - 10h: Moving left  - aiming up-left - frame 4
; Top half - 10h: Moving left  - aiming up-left - frame 7
; Top half - 10h: Moving left  - aiming up-left - frame 9
; Top half - 75h: Facing left  - moonwalk - aiming up-left - frame 1
; Top half - 75h: Facing left  - moonwalk - aiming up-left - frame 2
; Top half - 75h: Facing left  - moonwalk - aiming up-left - frame 4
; Top half - 75h: Facing left  - moonwalk - aiming up-left - frame 5
$92:9CFE             dx 0006, 01FB,F9,2802, 01FB,F1,2803, 01F3,F1,2804, 01EC,E9,2805, 01F0,ED,2806, C3F5,EF,2800

; Top half - Fh: Moving right - aiming up-right - frame 3
; Top half - Fh: Moving right - aiming up-right - frame 8
$92:9DB2             dx 0005, 000C,E8,6802, 01FD,F6,2803, 01FD,EE,2804, 0008,EC,6805, C3FB,EE,2800

; Top half - 10h: Moving left  - aiming up-left - frame 3
; Top half - 10h: Moving left  - aiming up-left - frame 8
$92:9DCD             dx 0006, 01FB,F9,2802, 01FB,F1,2803, 01F3,F1,2804, 01EC,E8,2805, 01F0,EC,2806, C3F5,EE,2800

; Top half - 11h: Moving right - aiming down-right - frame 3
; Top half - 11h: Moving right - aiming down-right - frame 8
$92:9DED             dx 0006, 01FD,F9,2802, 0005,F1,2803, 01FD,F1,2804, 000B,FF,2805, 0007,FB,2806, C3FA,EE,2800

; Top half - 12h: Moving left  - aiming down-left - frame 3
; Top half - 12h: Moving left  - aiming down-left - frame 8
$92:9E0D             dx 0006, 01F1,FB,6802, 01FC,F9,2803, 01F4,F1,2804, 01FC,F1,2805, 01ED,FF,6806, C3F6,EE,2800

; Top half - 4Ah: Facing right - moonwalk - frame 1
; Top half - 4Ah: Facing right - moonwalk - frame 2
; Top half - 4Ah: Facing right - moonwalk - frame 4
; Top half - 4Ah: Facing right - moonwalk - frame 5
$92:9E2D             dx 0005, 0001,FF,2802, 01F9,FF,2803, C3F9,EF,2800, 000A,FC,2804, 0002,FC,2805

; Top half - 49h: Facing left  - moonwalk - frame 1
; Top half - 49h: Facing left  - moonwalk - frame 2
; Top half - 49h: Facing left  - moonwalk - frame 4
; Top half - 49h: Facing left  - moonwalk - frame 5
$92:9E48             dx 0005, 01FF,FF,2802, 01F7,FF,2803, C3F7,EF,2800, 01EE,FC,6804, 01F6,FC,6805

; Top half - 29h: Facing right - falling - frame 1
; Top half - 29h: Facing right - falling - frame 5
; Top half - 46h: Unused - frame 3
; Top half - 46h: Unused - frame 8
$92:9E63             dx 0006, 0005,F7,2802, 01FD,F7,2803, 01F9,F5,2804, 01F9,F7,6805, 01F9,EF,6806, C3FA,F0,6800

; Top half - 29h: Facing right - falling - frame 2
; Top half - 45h: Unused - frame 3
; Top half - 45h: Unused - frame 8
; Top half - 50h: Facing right - damage boost - frame 9
$92:9E83             dx 0005, 0005,EF,2802, 01FD,EF,2803, 01F9,F6,6804, 01F9,EE,6805, C3FA,F0,6800

; Top half - Dh: Moving right - aiming up (unused) - frame 3
; Top half - Dh: Moving right - aiming up (unused) - frame 8
; Top half - 2Ah: Facing left  - falling - frame 1
; Top half - 2Ah: Facing left  - falling - frame 5
$92:9E9E             dx 0005, 01FD,F6,2802, 01F5,F6,2803, 01FE,F7,2804, 01FE,EF,2805, C3F6,F0,2800

; Top half - Eh: Moving left  - aiming up (unused) - frame 3
; Top half - Eh: Moving left  - aiming up (unused) - frame 8
; Top half - 2Ah: Facing left  - falling - frame 2
; Top half - 4Fh: Facing left  - damage boost - frame 9
$92:9EB9             dx 0005, 01F9,F0,2802, 01F1,F0,2803, 01FE,F6,2804, 01FE,EE,2805, C3F6,F0,2800

; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 1Ah
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 1Dh
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 8
$92:9ED4             dx 0006, 01FE,F4,2802, 01F6,F4,2803, 01F2,02,2804, 01FA,02,2805, 01FA,FA,2806, C3F6,F2,2800

; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 13h
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 17h
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 7
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 9
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame Bh
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame Eh
$92:9EF4             dx 0006, 01FD,F5,2802, 01F5,F5,2803, 01F3,03,2804, 01FB,03,2805, 01FB,FB,2806, C3F6,F3,2800

; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame Ah
$92:9F14             dx 0006, 01FC,F6,2802, 01F4,F6,2803, 01F4,04,2804, 01FC,04,2805, 01FC,FC,2806, C3F6,F4,2800

; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 8
$92:9F34             dx 0007, 0000,00,2802, 0004,04,2803, 01FE,02,6804, 01FA,F4,6805, 0002,F4,6806, 01FE,FA,6807, C3FA,F2,6800

; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 9
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame Bh
$92:9F59             dx 0007, 01FF,01,2802, 0003,05,2803, 01FB,F5,6804, 0003,F5,6805, 01FD,03,6806, 01FD,FB,6807, C3FA,F3,6800

; Top half - E8h: Facing right - Samus drained - crouching/falling - frame Ah
$92:9F7E             dx 0007, 01FE,02,2802, 0002,06,2803, 01FC,F6,6804, 0004,F6,6805, 01FC,04,6806, 01FC,FC,6807, C3FA,F4,6800

; Top half - EBh: Facing left  - Samus drained - standing - frame 0
$92:9FA3             dx 0006, 01FE,F4,2802, 01F6,F4,2803, 01F2,02,2804, 01FA,02,2805, 01FA,FA,2806, C3F6,F2,2800

; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 14h
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 16h
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame Fh
; Top half - EBh: Facing left  - Samus drained - standing - frame 1
; Top half - EBh: Facing left  - Samus drained - standing - frame 3
$92:9FC3             dx 0006, 01FD,F5,2802, 01F5,F5,2803, 01F3,03,2804, 01FB,03,2805, 01FB,FB,2806, C3F6,F3,2800

; Top half - EBh: Facing left  - Samus drained - standing - frame 2
$92:9FE3             dx 0006, 01FC,F6,2802, 01F4,F6,2803, 01F4,04,2804, 01FC,04,2805, 01FC,FC,2806, C3F6,F4,2800

; Top half - EAh: Facing right - Samus drained - standing - frame 0
$92:A003             dx 0007, 0000,00,2802, 0004,04,2803, 01FA,F4,6804, 0002,F4,6805, 01FE,02,6806, 01FE,FA,6807, C3FA,F2,6800

; Top half - EAh: Facing right - Samus drained - standing - frame 1
; Top half - EAh: Facing right - Samus drained - standing - frame 3
$92:A028             dx 0007, 01FF,01,2802, 0003,05,2803, 01FB,F5,6804, 0003,F5,6805, 01FD,03,6806, 01FD,FB,6807, C3FA,F3,6800

; Top half - EAh: Facing right - Samus drained - standing - frame 2
$92:A04D             dx 0007, 01FE,02,2802, 0002,06,2803, 01FC,F6,6804, 0004,F6,6805, 01FC,04,6806, 01FC,FC,6807, C3FA,F4,6800

; Top half - 1: Facing right - normal - frame 0
; Top half - 1: Facing right - normal - frame 5
; Top half - 27h: Facing right - crouching - frame 0
; Top half - 27h: Facing right - crouching - frame 5
; Top half - 47h: Unused - frame 0
; Top half - 89h: Facing right - ran into a wall - frame 0
; Top half - A8h: Facing right - grappling - frame 0
; Top half - B4h: Facing right - grappling - crouching - frame 0
$92:A072             dx 0004, C3F9,F8,2800, C3F9,F0,2802, 000A,FD,2804, 0002,FD,2805

; Top half - 1: Facing right - normal - frame 1
; Top half - 1: Facing right - normal - frame 3
; Top half - 1: Facing right - normal - frame 6
; Top half - 1: Facing right - normal - frame 8
; Top half - 27h: Facing right - crouching - frame 1
; Top half - 27h: Facing right - crouching - frame 3
; Top half - 27h: Facing right - crouching - frame 6
; Top half - 27h: Facing right - crouching - frame 8
$92:A088             dx 0004, C3F9,F8,2800, C3F9,F0,2802, 000A,FD,2804, 0002,FD,2805

; Top half - 1: Facing right - normal - frame 2
; Top half - 27h: Facing right - crouching - frame 2
$92:A09E             dx 0004, C3F9,F8,2800, C3F9,F0,2802, 000A,FD,2804, 0002,FD,2805

; Top half - 2: Facing left  - normal - frame 0
; Top half - 2: Facing left  - normal - frame 5
; Top half - 28h: Facing left  - crouching - frame 0
; Top half - 28h: Facing left  - crouching - frame 5
; Top half - 48h: Unused - frame 0
; Top half - 8Ah: Facing left  - ran into a wall - frame 0
; Top half - A9h: Facing left  - grappling - frame 0
; Top half - B5h: Facing left  - grappling - crouching - frame 0
$92:A0B4             dx 0004, C3F7,F8,2800, C3F7,F0,2802, 01EE,FD,6804, 01F6,FD,6805

; Top half - 2: Facing left  - normal - frame 1
; Top half - 2: Facing left  - normal - frame 3
; Top half - 2: Facing left  - normal - frame 6
; Top half - 2: Facing left  - normal - frame 8
; Top half - 28h: Facing left  - crouching - frame 1
; Top half - 28h: Facing left  - crouching - frame 3
; Top half - 28h: Facing left  - crouching - frame 6
; Top half - 28h: Facing left  - crouching - frame 8
$92:A0CA             dx 0004, C3F7,F8,2800, C3F7,F0,2802, 01EE,FD,6804, 01F6,FD,6805

; Top half - 2: Facing left  - normal - frame 2
; Top half - 28h: Facing left  - crouching - frame 2
$92:A0E0             dx 0004, C3F7,F8,2800, C3F7,F0,2802, 01EE,FD,6804, 01F6,FD,6805

; Top half - 1: Facing right - normal - frame 7
; Top half - 27h: Facing right - crouching - frame 7
$92:A0F6             dx 0005, 0001,00,2802, 01F9,00,2803, C3F9,F0,2800, 000A,FD,2804, 0002,FD,2805

; Top half - 2: Facing left  - normal - frame 7
; Top half - 28h: Facing left  - crouching - frame 7
$92:A111             dx 0005, 01FF,00,2802, 01F7,00,2803, C3F7,F0,2800, 01EE,FD,6804, 01F6,FD,6805

; Top half - 0: Facing forward - power suit - frame 11h
; Top half - 0: Facing forward - power suit - frame 13h
; Top half - 0: Facing forward - power suit - frame 15h
; Top half - 0: Facing forward - power suit - frame 17h
; Top half - 0: Facing forward - power suit - frame 19h
; Top half - 0: Facing forward - power suit - frame 1Bh
; Top half - 0: Facing forward - power suit - frame 1Dh
; Top half - 0: Facing forward - power suit - frame 1Fh
; Top half - 0: Facing forward - power suit - frame 21h
; Top half - 0: Facing forward - power suit - frame 23h
; Top half - 0: Facing forward - power suit - frame 25h
; Top half - 0: Facing forward - power suit - frame 27h
; Top half - 0: Facing forward - power suit - frame 29h
; Top half - 0: Facing forward - power suit - frame 2Bh
; Top half - 0: Facing forward - power suit - frame 2Dh
; Top half - 0: Facing forward - power suit - frame 2Fh
; Top half - 0: Facing forward - power suit - frame 3
; Top half - 0: Facing forward - power suit - frame 31h
; Top half - 0: Facing forward - power suit - frame 33h
; Top half - 0: Facing forward - power suit - frame 35h
; Top half - 0: Facing forward - power suit - frame 37h
; Top half - 0: Facing forward - power suit - frame 39h
; Top half - 0: Facing forward - power suit - frame 3Bh
; Top half - 0: Facing forward - power suit - frame 3Dh
; Top half - 0: Facing forward - power suit - frame 3Fh
; Top half - 0: Facing forward - power suit - frame 41h
; Top half - 0: Facing forward - power suit - frame 43h
; Top half - 0: Facing forward - power suit - frame 45h
; Top half - 0: Facing forward - power suit - frame 47h
; Top half - 0: Facing forward - power suit - frame 49h
; Top half - 0: Facing forward - power suit - frame 4Bh
; Top half - 0: Facing forward - power suit - frame 4Dh
; Top half - 0: Facing forward - power suit - frame 4Fh
; Top half - 0: Facing forward - power suit - frame 5
; Top half - 0: Facing forward - power suit - frame 51h
; Top half - 0: Facing forward - power suit - frame 53h
; Top half - 0: Facing forward - power suit - frame 55h
; Top half - 0: Facing forward - power suit - frame 57h
; Top half - 0: Facing forward - power suit - frame 59h
; Top half - 0: Facing forward - power suit - frame 5Bh
; Top half - 0: Facing forward - power suit - frame 5Dh
; Top half - 0: Facing forward - power suit - frame 5Fh
; Top half - 0: Facing forward - power suit - frame 7
; Top half - 0: Facing forward - power suit - frame 9
; Top half - 0: Facing forward - power suit - frame Bh
; Top half - 0: Facing forward - power suit - frame Dh
; Top half - 0: Facing forward - power suit - frame Fh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 11h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 13h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 15h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 17h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 19h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 1Bh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 1Dh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 1Fh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 21h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 23h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 25h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 27h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 29h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 2Bh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 2Dh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 2Fh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 3
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 31h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 33h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 35h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 37h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 39h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 3Bh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 3Dh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 3Fh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 41h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 43h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 45h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 47h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 49h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 4Bh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 4Dh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 4Fh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 5
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 51h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 53h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 55h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 57h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 59h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 5Bh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 5Dh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 5Fh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 7
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 9
; Top half - 9Bh: Facing forward - varia/gravity suit - frame Bh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame Dh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame Fh
$92:A12C             dx 0001, 01F8,F8,3000

; Top half - 0: Facing forward - power suit - frame 14h
; Top half - 0: Facing forward - power suit - frame 1Ah
; Top half - 0: Facing forward - power suit - frame 2
; Top half - 0: Facing forward - power suit - frame 20h
; Top half - 0: Facing forward - power suit - frame 26h
; Top half - 0: Facing forward - power suit - frame 2Ch
; Top half - 0: Facing forward - power suit - frame 32h
; Top half - 0: Facing forward - power suit - frame 38h
; Top half - 0: Facing forward - power suit - frame 3Eh
; Top half - 0: Facing forward - power suit - frame 44h
; Top half - 0: Facing forward - power suit - frame 4Ah
; Top half - 0: Facing forward - power suit - frame 8
; Top half - 0: Facing forward - power suit - frame Eh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 14h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 1Ah
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 2
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 20h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 26h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 2Ch
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 32h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 38h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 3Eh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 44h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 4Ah
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 8
; Top half - 9Bh: Facing forward - varia/gravity suit - frame Eh
$92:A13A             dx 0009, 0004,10,3800, 0004,08,3801, 01FC,08,3802, 01FC,00,3803, 01FC,F8,3804, 0004,F0,3805, 01FC,F0,3806, 01F4,F0,3807, 01F4,E8,3810

; Top half - 0: Facing forward - power suit - frame 10h
; Top half - 0: Facing forward - power suit - frame 16h
; Top half - 0: Facing forward - power suit - frame 1Ch
; Top half - 0: Facing forward - power suit - frame 22h
; Top half - 0: Facing forward - power suit - frame 28h
; Top half - 0: Facing forward - power suit - frame 2Eh
; Top half - 0: Facing forward - power suit - frame 34h
; Top half - 0: Facing forward - power suit - frame 3Ah
; Top half - 0: Facing forward - power suit - frame 4
; Top half - 0: Facing forward - power suit - frame 40h
; Top half - 0: Facing forward - power suit - frame 46h
; Top half - 0: Facing forward - power suit - frame 4Ch
; Top half - 0: Facing forward - power suit - frame Ah
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 10h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 16h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 1Ch
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 22h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 28h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 2Eh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 34h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 3Ah
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 4
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 40h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 46h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 4Ch
; Top half - 9Bh: Facing forward - varia/gravity suit - frame Ah
$92:A169             dx 0007, 0004,00,3800, 01FC,00,3801, 01F4,00,3802, 0004,F8,3803, 01FC,F8,3804, 01F4,F8,3805, 01F4,F0,3806

; Top half - 0: Facing forward - power suit - frame 12h
; Top half - 0: Facing forward - power suit - frame 18h
; Top half - 0: Facing forward - power suit - frame 1Eh
; Top half - 0: Facing forward - power suit - frame 24h
; Top half - 0: Facing forward - power suit - frame 2Ah
; Top half - 0: Facing forward - power suit - frame 30h
; Top half - 0: Facing forward - power suit - frame 36h
; Top half - 0: Facing forward - power suit - frame 3Ch
; Top half - 0: Facing forward - power suit - frame 42h
; Top half - 0: Facing forward - power suit - frame 48h
; Top half - 0: Facing forward - power suit - frame 4Eh
; Top half - 0: Facing forward - power suit - frame 6
; Top half - 0: Facing forward - power suit - frame Ch
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 12h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 18h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 1Eh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 24h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 2Ah
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 30h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 36h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 3Ch
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 42h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 48h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 4Eh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 6
; Top half - 9Bh: Facing forward - varia/gravity suit - frame Ch
$92:A18E             dx 000B, 01FC,10,3800, 01F4,10,3801, 01FC,08,3802, 01F4,08,3803, 0004,00,3804, 01FC,00,3805, 0004,F8,3806, 01FC,F8,3807, 01FC,F0,3810, 0004,E8,3811, 01FC,E8,3812

; Top half - 0: Facing forward - power suit - frame 50h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 50h
$92:A1C7             dx 000F, 01FC,10,3800, 01F4,10,3801, 01FC,08,3802, 01F4,08,3803, 0004,00,3804, 01FC,00,3805, 01F4,00,3806, 0004,F8,3807, 01FC,F8,3810, 01F4,F8,3811, 0004,F0,3812, 01FC,F0,3813, 01F4,F0,3814, 0004,E8,3815, 01FC,E8,3816

; Top half - 0: Facing forward - power suit - frame 52h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 52h
$92:A214             dx 0008, 01FC,10,3800, 01FC,08,3801, 01FC,00,3802, 0004,F8,3803, 01F4,F8,3804, 0004,F0,3805, 01F4,F0,3806, 0004,E8,3807

; Top half - 0: Facing forward - power suit - frame 54h
; Top half - 0: Facing forward - power suit - frame 5Ah
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 54h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 5Ah
$92:A23E             dx 000A, 01FC,10,3800, 0004,08,3801, 01FC,08,3802, 0004,00,3803, 01FC,00,3804, 0004,F0,3805, 01FC,F0,3806, 01F4,F0,3807, 0004,E8,3810, 01FC,E8,3811

; Top half - 0: Facing forward - power suit - frame 56h
; Top half - 0: Facing forward - power suit - frame 5Ch
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 56h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 5Ch
$92:A272             dx 000B, 01F4,10,3800, 0004,08,3801, 01FC,08,3802, 01F4,08,3803, 0004,00,3804, 01FC,00,3805, 01F4,00,3806, 01F4,F0,3807, 0004,E8,3810, 01FC,E8,3811, 01F4,E8,3812

; Top half - 0: Facing forward - power suit - frame 58h
; Top half - 0: Facing forward - power suit - frame 5Eh
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 58h
; Top half - 9Bh: Facing forward - varia/gravity suit - frame 5Eh
$92:A2AB             dx 0007, 0004,08,3800, 01F4,08,3801, 01F4,00,3802, 0004,F8,3803, 0004,E8,3804, 01FC,E8,3805, 01F4,E8,3806

; Top half - Bh: Moving right - gun extended - frame 0
; Top half - Bh: Moving right - gun extended - frame 5
$92:A2D0             dx 0003, 0011,FA,2802, 0009,FA,2803, C3FA,F0,2800

; Top half - Bh: Moving right - gun extended - frame 4
$92:A2E1             dx 0003, 0011,F9,2802, 0009,F9,2803, C3FA,EF,2800

; Top half - Bh: Moving right - gun extended - frame 2
$92:A2F2             dx 0004, 0011,F9,2802, 0009,F9,2803, 0007,F7,2804, C3F7,EF,2800

; Top half - Bh: Moving right - gun extended - frame 3
$92:A308             dx 0005, 0011,F8,2802, 0009,F8,2803, 0005,EE,2804, 0005,F6,2805, C3F5,EE,2800

; Top half - Bh: Moving right - gun extended - frame 6
; Top half - Bh: Moving right - gun extended - frame 9
$92:A323             dx 0003, 0011,F9,2802, 0009,F9,2803, C3FA,EF,2800

; Top half - Bh: Moving right - gun extended - frame 7
$92:A334             dx 0004, 0011,F9,2802, 0009,F9,2803, 000A,F7,2804, C3FA,EF,2800

; Top half - Ch: Moving left  - gun extended - frame 0
; Top half - Ch: Moving left  - gun extended - frame 5
$92:A34A             dx 0005, 01EF,FA,6802, 01E7,FA,6803, 01FE,00,2804, 01F6,00,2805, C3F6,F0,2800

; Top half - Ch: Moving left  - gun extended - frame 4
$92:A365             dx 0005, 01EF,F9,6802, 01E7,F9,6803, 01FE,FF,2804, 01F6,FF,2805, C3F6,EF,2800

; Top half - Ch: Moving left  - gun extended - frame 3
$92:A380             dx 0006, 01EE,F7,2802, 01FE,FF,2803, 01F6,FF,2804, C3F6,EF,2800, 01EF,F9,6805, 01E7,F9,6806

; Top half - Ch: Moving left  - gun extended - frame 2
$92:A3A0             dx 0006, 01EE,F6,2802, 01EF,F8,6803, 01E7,F8,6804, 01FE,FE,2805, 01F6,FE,2806, C3F6,EE,2800

; Top half - Ch: Moving left  - gun extended - frame 6
; Top half - Ch: Moving left  - gun extended - frame 9
$92:A3C0             dx 0005, 01EF,F9,6802, 01E7,F9,6803, 01FE,FF,2804, 01F6,FF,2805, C3F6,EF,2800

; Top half - Ch: Moving left  - gun extended - frame 8
$92:A3DB             dx 0007, 01EF,F9,6802, 01E7,F9,6803, 0006,FF,2804, 01FE,FF,2805, 01F6,F7,2806, 01F6,EF,2807, C3FE,EF,2800

; Top half - Bh: Moving right - gun extended - frame 8
$92:A400             dx 0005, 0011,F8,2802, 0009,F8,2803, 000A,F6,2804, 000A,EE,2805, C3FA,EE,2800

; Top half - Ch: Moving left  - gun extended - frame 7
$92:A41B             dx 0007, 01EF,F8,6802, 01E7,F8,6803, 0006,FE,2804, 01FE,FE,2805, 01F6,F6,2806, 01F6,EE,2807, C3FE,EE,2800

; Top half - Bh: Moving right - gun extended - frame 1
$92:A440             dx 0003, 0011,FA,2802, 0009,FA,2803, C3FA,F0,2800

; Top half - Ch: Moving left  - gun extended - frame 1
$92:A451             dx 0005, 01EF,FA,6802, 01E7,FA,6803, 01FE,00,2804, 01F6,00,2805, C3F6,F0,2800

; Top half - B2h: Facing clockwise     - grapple swinging - frame 18h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 38h
$92:A46C             dx 0004, 001C,FD,2804, 0014,FD,2805, C205,F6,2800, C200,F8,2802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 17h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 37h
$92:A482             dx 0004, 001B,F7,2804, 0013,F7,2805, C204,F4,2800, C3FF,F6,2802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 16h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 36h
$92:A498             dx 0003, C210,F1,2800, C204,F3,2802, C3FF,F5,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 15h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 35h
$92:A4A9             dx 0003, C202,EF,2800, C20E,ED,2802, C3FF,F2,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 14h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 34h
$92:A4BA             dx 0003, C20C,E5,2800, C202,EF,2802, C3FF,F2,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 13h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 33h
$92:A4CB             dx 0003, C209,E5,2800, C201,EF,2802, C3FF,F2,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 12h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 32h
$92:A4DC             dx 0003, C207,E3,2800, C201,ED,2802, C3FE,F1,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 11h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 31h
$92:A4ED             dx 0004, 0004,E6,2804, 0004,DE,2805, C3FD,EC,2800, C3FB,F0,2802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 10h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 30h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 40h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 41h
$92:A503             dx 0004, 01FD,E5,2804, 01FD,DD,2805, C3F6,EC,2800, C3F8,F0,2802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 2Fh
; Top half - B2h: Facing clockwise     - grapple swinging - frame Fh
$92:A519             dx 0004, 01F8,E6,6804, 01F8,DE,6805, C3F3,EC,2800, C3F7,F0,2802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 2Eh
; Top half - B2h: Facing clockwise     - grapple swinging - frame Eh
$92:A52F             dx 0003, C3EE,E2,6800, C3F3,ED,2802, C3F5,F1,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 2Dh
; Top half - B2h: Facing clockwise     - grapple swinging - frame Dh
$92:A540             dx 0003, C3E8,E4,6800, C3F0,EF,2802, C3F2,F2,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 2Ch
; Top half - B2h: Facing clockwise     - grapple swinging - frame Ch
$92:A551             dx 0003, C3E3,E5,6800, C3EE,EF,2802, C3F2,F2,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 2Bh
; Top half - B2h: Facing clockwise     - grapple swinging - frame Bh
$92:A562             dx 0003, C3E0,E9,6800, C3EB,F2,2802, C3F1,F3,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 2Ah
; Top half - B2h: Facing clockwise     - grapple swinging - frame Ah
$92:A573             dx 0003, C3E0,EF,6800, C3EB,F4,2802, C3F1,F3,2804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 29h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 9
$92:A584             dx 0004, 01DD,F7,6804, 01E5,F7,6805, C3EB,F9,2800, C3F0,F7,2802

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 28h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 8
$92:A5B0             dx 0008, 0001,FB,2804, 0001,F3,2805, C3F1,F3,2800, C3F0,F8,6802, 01DC,FC,6806, 01E4,FC,6807, 01EB,02,2814, 01EB,FA,2815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 29h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 9
$92:A5DA             dx 0008, 01DC,F8,6804, 01E4,F8,6805, 0001,FA,2806, 0001,F2,2807, C3F1,F2,2800, C3F0,F7,6802, 01EB,00,2814, 01EB,F8,2815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 2Ah
; Top half - B3h: Facing anticlockwise - grapple swinging - frame Ah
$92:A604             dx 000A, 0005,FA,2804, 0005,F2,2805, C3F5,F2,2800, C3F1,F5,6802, 01E0,F8,6806, 01E8,F8,6807, 01E0,F0,6814, 01E8,F0,6815, 01EB,FD,2816, 01EB,F5,2817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 2Bh
; Top half - B3h: Facing anticlockwise - grapple swinging - frame Bh
$92:A638             dx 000A, 0005,F9,2804, 0005,F1,2805, C3F5,F1,2800, C3F1,F4,6802, 01E0,F5,6806, 01E8,F5,6807, 01E0,ED,6814, 01E8,ED,6815, 01EB,FB,2816, 01EB,F3,2817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 2Ch
; Top half - B3h: Facing anticlockwise - grapple swinging - frame Ch
$92:A66C             dx 0009, 01FD,FE,2804, C3F5,EE,2800, C3F0,F2,6802, 01E2,EC,6805, 01EA,EC,6806, 01E2,E4,6807, 01EA,E4,6814, 01F4,EE,2815, 01EC,EE,2816

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 2Dh
; Top half - B3h: Facing anticlockwise - grapple swinging - frame Dh
$92:A69B             dx 0009, 01FE,FE,2804, C3F6,EE,2800, C3F2,F1,6802, 01F6,ED,2805, 01EE,ED,2806, 01ED,EB,6807, 01E5,EB,6814, 01E5,E3,6815, 01ED,E3,6816

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 2Eh
; Top half - B3h: Facing anticlockwise - grapple swinging - frame Eh
$92:A6CA             dx 0009, 01E9,E9,6804, 01FE,FE,2805, C3F6,EE,2800, C3F2,F1,6802, 01F1,E9,6806, 01E9,E1,6807, 01F1,E1,6814, 01F6,EC,2815, 01EE,EC,2816

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 2Fh
; Top half - B3h: Facing anticlockwise - grapple swinging - frame Fh
$92:A6F9             dx 0008, 0000,02,2804, 01F8,02,2805, C3F8,F2,2800, C3F6,F0,6802, 01F8,EB,2806, 01F0,EB,2807, 01F5,E5,6814, 01F5,DD,6815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 10h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 30h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 40h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 41h
$92:A723             dx 0008, 01FF,03,2804, 01F7,03,2805, C3F7,F3,2800, C3F9,F1,6802, 01FC,E4,2806, 01FC,DC,2807, 01FD,EB,2814, 01F5,EB,2815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 11h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 31h
$92:A74D             dx 0008, 01FF,01,2804, 01F7,01,2805, C3F7,F1,2800, C3FA,F0,6802, 0002,E5,2806, 0002,DD,2807, 0003,EB,2814, 01FB,EB,2815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 12h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 32h
$92:A777             dx 0009, 000B,E8,2804, 01F1,FC,2805, C3F9,F4,2800, C3FB,F0,6802, 0003,E8,2806, 000B,E0,2807, 0003,E0,2814, 0005,EB,2815, 01FD,EB,2816

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 13h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 33h
$92:A7A6             dx 000A, 0010,EA,2804, 0008,EA,2805, 0010,E2,2806, 0008,E2,2807, 01F1,FD,2814, 01F1,F5,2815, C3F9,F5,2800, C3FD,F2,6802, 0008,ED,2816, 0000,ED,2817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 14h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 34h
$92:A7DA             dx 000A, 01F1,FD,2804, 01F1,F5,2805, C3F9,F5,2800, C3FD,F2,6802, 0013,EC,2806, 000B,EC,2807, 0013,E4,2814, 000B,E4,2815, 0009,EE,2816, 0001,EE,2817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 15h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 35h
$92:A80E             dx 000A, 01F4,FC,2804, 01F4,F4,2805, C3FC,F4,2800, C3FE,F4,6802, 0016,F3,2806, 000E,F3,2807, 0016,EB,2814, 000E,EB,2815, 000A,F6,2816, 000A,EE,2817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 16h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 36h
$92:A842             dx 000A, 01F4,FC,2804, 01F4,F4,2805, C3FC,F4,2800, C3FE,F4,6802, 0017,F7,2806, 000F,F7,2807, 0017,EF,2814, 000F,EF,2815, 000B,F8,2816, 000B,F0,2817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 17h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 37h
$92:A876             dx 0009, C3FE,F3,2800, 01F6,FB,2804, 01F6,F3,2805, 01F6,EB,2806, C3FF,F7,6802, 000E,FA,2807, 000E,F9,A814, 001C,F7,2815, 0014,F7,2816

; Top half - B2h: Facing clockwise     - grapple swinging - frame 28h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 8
$92:A8D4             dx 0004, 01DC,FB,E804, 01E4,FB,E805, C3EB,FA,E800, C3F0,F8,E802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 27h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 7
$92:A8EA             dx 0004, 01DD,01,E804, 01E5,01,E805, C3EC,FC,E800, C3F1,FA,E802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 26h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 6
$92:A900             dx 0003, C3E0,FF,E800, C3EC,FD,E802, C3F1,FB,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 25h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 5
$92:A911             dx 0003, C3EE,01,E800, C3E2,03,E802, C3F1,FE,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 24h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 4
$92:A922             dx 0003, C3E4,0B,E800, C3EE,01,E802, C3F1,FE,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 23h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 3
$92:A933             dx 0003, C3E7,0B,E800, C3EF,01,E802, C3F1,FE,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 2
; Top half - B2h: Facing clockwise     - grapple swinging - frame 22h
$92:A944             dx 0003, C3E9,0D,E800, C3EF,03,E802, C3F2,FF,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 1
; Top half - B2h: Facing clockwise     - grapple swinging - frame 21h
$92:A955             dx 0004, 01F4,12,E804, 01F4,1A,E805, C3F3,04,E800, C3F5,00,E802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 0
; Top half - B2h: Facing clockwise     - grapple swinging - frame 20h
$92:A96B             dx 0004, 01FB,13,E804, 01FB,1B,E805, C3FA,04,E800, C3F8,00,E802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 1Fh
; Top half - B2h: Facing clockwise     - grapple swinging - frame 3Fh
$92:A981             dx 0004, 0000,12,A804, 0000,1A,A805, C3FD,04,E800, C3F9,00,E802

; Top half - B2h: Facing clockwise     - grapple swinging - frame 1Eh
; Top half - B2h: Facing clockwise     - grapple swinging - frame 3Eh
$92:A997             dx 0003, C202,0E,A800, C3FD,03,E802, C3FB,FF,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 1Dh
; Top half - B2h: Facing clockwise     - grapple swinging - frame 3Dh
$92:A9A8             dx 0003, C208,0C,A800, C200,01,E802, C3FE,FE,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 1Ch
; Top half - B2h: Facing clockwise     - grapple swinging - frame 3Ch
$92:A9B9             dx 0003, C20D,0B,A800, C202,01,E802, C3FE,FE,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 1Bh
; Top half - B2h: Facing clockwise     - grapple swinging - frame 3Bh
$92:A9CA             dx 0003, C210,07,A800, C205,FE,E802, C3FF,FD,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 1Ah
; Top half - B2h: Facing clockwise     - grapple swinging - frame 3Ah
$92:A9DB             dx 0003, C210,01,A800, C205,FC,E802, C3FF,FD,E804

; Top half - B2h: Facing clockwise     - grapple swinging - frame 19h
; Top half - B2h: Facing clockwise     - grapple swinging - frame 39h
$92:A9EC             dx 0004, 001B,01,A804, 0013,01,A805, C205,F7,E800, C200,F9,E802

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 18h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 38h
$92:AA18             dx 0008, 01F7,FD,E804, 01F7,05,E805, C3FF,FD,E800, C200,F8,A802, 001C,FC,A806, 0014,FC,A807, 000D,F6,E814, 000D,FE,E815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 19h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 39h
$92:AA42             dx 0008, 001C,00,A804, 0014,00,A805, 01F7,FE,E806, 01F7,06,E807, C3FF,FE,E800, C200,F9,A802, 000D,F8,E814, 000D,00,E815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 1Ah
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 3Ah
$92:AA6C             dx 000A, 01F3,FE,E804, 01F3,06,E805, C3FB,FE,E800, C3FF,FB,A802, 0018,00,A806, 0010,00,A807, 0018,08,A814, 0010,08,A815, 000D,FB,E816, 000D,03,E817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 1Bh
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 3Bh
$92:AAA0             dx 000A, 01F3,FF,E804, 01F3,07,E805, C3FB,FF,E800, C3FF,FC,A802, 0018,03,A806, 0010,03,A807, 0018,0B,A814, 0010,0B,A815, 000D,FD,E816, 000D,05,E817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 1Ch
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 3Ch
$92:AAD4             dx 0009, 01FB,FA,E804, C3FB,02,E800, C200,FE,A802, 0016,0C,A805, 000E,0C,A806, 0016,14,A807, 000E,14,A814, 0004,0A,E815, 000C,0A,E816

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 1Dh
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 3Dh
$92:AB03             dx 0009, 01FA,FA,E804, C3FA,02,E800, C3FE,FF,A802, 0002,0B,E805, 000A,0B,E806, 000B,0D,A807, 0013,0D,A814, 0013,15,A815, 000B,15,A816

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 1Eh
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 3Eh
$92:AB32             dx 0009, 000F,0F,A804, 01FA,FA,E805, C3FA,02,E800, C3FE,FF,A802, 0007,0F,A806, 000F,17,A807, 0007,17,A814, 0002,0C,E815, 000A,0C,E816

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 1Fh
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 3Fh
$92:AB61             dx 0008, 01F8,F6,E804, 0000,F6,E805, C3F8,FE,E800, C3FA,00,A802, 0000,0D,E806, 0008,0D,E807, 0003,13,A814, 0003,1B,A815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 0
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 20h
$92:AB8B             dx 0008, 01F9,F5,E804, 0001,F5,E805, C3F9,FD,E800, C3F7,FF,A802, 01FC,14,E806, 01FC,1C,E807, 01FB,0D,E814, 0003,0D,E815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 1
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 21h
$92:ABB5             dx 0008, 01F9,F7,E804, 0001,F7,E805, C3F9,FF,E800, C3F6,00,A802, 01F6,13,E806, 01F6,1B,E807, 01F5,0D,E814, 01FD,0D,E815

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 2
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 22h
$92:ABDF             dx 0009, 01ED,10,E804, 0007,FC,E805, C3F7,FC,E800, C3F5,00,A802, 01F5,10,E806, 01ED,18,E807, 01F5,18,E814, 01F3,0D,E815, 01FB,0D,E816

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 23h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 3
$92:AC0E             dx 000A, 01E8,0E,E804, 01F0,0E,E805, 01E8,16,E806, 01F0,16,E807, 0007,FB,E814, 0007,03,E815, C3F7,FB,E800, C3F3,FE,A802, 01F0,0B,E816, 01F8,0B,E817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 24h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 4
$92:AC42             dx 000A, 0007,FB,E804, 0007,03,E805, C3F7,FB,E800, C3F3,FE,A802, 01E5,0C,E806, 01ED,0C,E807, 01E5,14,E814, 01ED,14,E815, 01EF,0A,E816, 01F7,0A,E817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 25h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 5
$92:AC76             dx 000A, 0004,FC,E804, 0004,04,E805, C3F4,FC,E800, C3F2,FC,A802, 01E2,05,E806, 01EA,05,E807, 01E2,0D,E814, 01EA,0D,E815, 01EE,02,E816, 01EE,0A,E817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 26h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 6
$92:ACAA             dx 000A, 0004,FC,E804, 0004,04,E805, C3F4,FC,E800, C3F2,FC,A802, 01E1,01,E806, 01E9,01,E807, 01E1,09,E814, 01E9,09,E815, 01ED,00,E816, 01ED,08,E817

; Top half - B3h: Facing anticlockwise - grapple swinging - frame 27h
; Top half - B3h: Facing anticlockwise - grapple swinging - frame 7
$92:ACDE             dx 0009, C3F2,FD,E800, 0002,FD,E804, 0002,05,E805, 0002,0D,E806, C3F1,F9,A802, 01EA,FE,E807, 01EA,FF,6814, 01DC,01,E815, 01E4,01,E816

; Bottom half - 9: Moving right - not aiming - frame 0
; Bottom half - Bh: Moving right - gun extended - frame 0
; Bottom half - Dh: Moving right - aiming up (unused) - frame 0
; Bottom half - Fh: Moving right - aiming up-right - frame 0
; Bottom half - 11h: Moving right - aiming down-right - frame 0
; Bottom half - 45h: Unused - frame 0
$92:AD3C             dx 0002, C3F8,10,2808, C3F8,00,280A

; Bottom half - 9: Moving right - not aiming - frame 2
; Bottom half - Bh: Moving right - gun extended - frame 2
; Bottom half - Dh: Moving right - aiming up (unused) - frame 2
; Bottom half - Fh: Moving right - aiming up-right - frame 2
; Bottom half - 11h: Moving right - aiming down-right - frame 2
; Bottom half - 45h: Unused - frame 2
$92:AD48             dx 0005, C3F3,07,2808, C3FB,FF,280A, 01EB,0F,280C, 01F3,17,280D, 0003,0F,280E

; Bottom half - 9: Moving right - not aiming - frame 4
; Bottom half - Bh: Moving right - gun extended - frame 4
; Bottom half - Dh: Moving right - aiming up (unused) - frame 4
; Bottom half - Fh: Moving right - aiming up-right - frame 4
; Bottom half - 11h: Moving right - aiming down-right - frame 4
; Bottom half - 45h: Unused - frame 4
$92:AD63             dx 0004, C3F0,FF,2808, C200,0F,280A, C3F8,FF,280C, 0008,07,280E

; Bottom half - 9: Moving right - not aiming - frame 5
; Bottom half - Bh: Moving right - gun extended - frame 5
; Bottom half - Dh: Moving right - aiming up (unused) - frame 5
; Bottom half - Fh: Moving right - aiming up-right - frame 5
; Bottom half - 11h: Moving right - aiming down-right - frame 5
; Bottom half - 45h: Unused - frame 5
; Bottom half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 0
; Bottom half - C7h: Facing right - vertical shinespark windup - frame 0
$92:AD79             dx 0002, C3F7,10,2808, C3F7,00,280A

; Bottom half - 9: Moving right - not aiming - frame 7
; Bottom half - Bh: Moving right - gun extended - frame 7
; Bottom half - Dh: Moving right - aiming up (unused) - frame 7
; Bottom half - Fh: Moving right - aiming up-right - frame 7
; Bottom half - 11h: Moving right - aiming down-right - frame 7
; Bottom half - 45h: Unused - frame 7
$92:AD85             dx 0006, C3F3,07,2808, C3FB,FF,280A, 01F3,FF,280C, 01EB,0F,280D, 01F3,17,280E, 0003,0F,280F

; Bottom half - 9: Moving right - not aiming - frame 9
; Bottom half - Bh: Moving right - gun extended - frame 9
; Bottom half - Dh: Moving right - aiming up (unused) - frame 9
; Bottom half - Fh: Moving right - aiming up-right - frame 9
; Bottom half - 11h: Moving right - aiming down-right - frame 9
; Bottom half - 45h: Unused - frame 9
$92:ADA5             dx 0004, C3EF,FF,2808, C3FF,0F,280A, C3F7,FF,280C, 01F7,0F,280E

; Bottom half - 1: Facing right - normal - frame 0
; Bottom half - 1: Facing right - normal - frame 5
; Bottom half - 47h: Unused - frame 0
; Bottom half - 89h: Facing right - ran into a wall - frame 0
; Bottom half - A4h: Facing right - landing from normal jump - frame 1
; Bottom half - A6h: Facing right - landing from spin jump - frame 2
; Bottom half - A8h: Facing right - grappling - frame 0
; Bottom half - D5h: Facing right - x-ray - standing - frame 0
; Bottom half - D5h: Facing right - x-ray - standing - frame 1
; Bottom half - D5h: Facing right - x-ray - standing - frame 2
; Bottom half - D5h: Facing right - x-ray - standing - frame 3
; Bottom half - D5h: Facing right - x-ray - standing - frame 4
; Bottom half - E0h: Facing right - landing from normal jump - aiming up - frame 1
; Bottom half - E2h: Facing right - landing from normal jump - aiming up-right - frame 1
; Bottom half - E4h: Facing right - landing from normal jump - aiming down-right - frame 1
; Bottom half - E6h: Facing right - landing from normal jump - firing - frame 1
$92:ADBB             dx 0003, C3F1,10,2808, C3F9,10,280A, C3F9,00,280C

; Bottom half - 28h: Facing left  - crouching - frame 0
; Bottom half - 28h: Facing left  - crouching - frame 1
; Bottom half - 28h: Facing left  - crouching - frame 2
; Bottom half - 28h: Facing left  - crouching - frame 3
; Bottom half - 28h: Facing left  - crouching - frame 5
; Bottom half - 28h: Facing left  - crouching - frame 6
; Bottom half - 28h: Facing left  - crouching - frame 7
; Bottom half - 28h: Facing left  - crouching - frame 8
; Bottom half - 72h: Facing left  - crouching - aiming up-left - frame 0
; Bottom half - 74h: Facing left  - crouching - aiming down-left - frame 0
; Bottom half - 86h: Facing left  - crouching - aiming up - frame 0
; Bottom half - 86h: Facing left  - crouching - aiming up - frame 1
; Bottom half - B5h: Facing left  - grappling - crouching - frame 0
; Bottom half - B7h: Facing left  - grappling - crouching - aiming down-left - frame 0
; Bottom half - DAh: Facing left  - x-ray - crouching - frame 0
; Bottom half - DAh: Facing left  - x-ray - crouching - frame 1
; Bottom half - DAh: Facing left  - x-ray - crouching - frame 2
; Bottom half - DAh: Facing left  - x-ray - crouching - frame 3
; Bottom half - DAh: Facing left  - x-ray - crouching - frame 4
$92:ADCC             dx 0002, C3EF,00,2808, C3F7,00,280A

; Bottom half - 9: Moving right - not aiming - frame 1
; Bottom half - Bh: Moving right - gun extended - frame 1
; Bottom half - Dh: Moving right - aiming up (unused) - frame 1
; Bottom half - Fh: Moving right - aiming up-right - frame 1
; Bottom half - 11h: Moving right - aiming down-right - frame 1
; Bottom half - 45h: Unused - frame 1
$92:ADD8             dx 0004, C3FB,00,2808, C3F3,10,280A, 01F3,08,280C, 0003,10,280D

; Bottom half - 9: Moving right - not aiming - frame 3
; Bottom half - Bh: Moving right - gun extended - frame 3
; Bottom half - Dh: Moving right - aiming up (unused) - frame 3
; Bottom half - Fh: Moving right - aiming up-right - frame 3
; Bottom half - 11h: Moving right - aiming down-right - frame 3
; Bottom half - 45h: Unused - frame 3
$92:ADEE             dx 0006, C3FF,06,2808, C3F7,FE,280A, 000F,0F,280C, 01EF,0E,280D, 01EF,06,280E, 0007,16,280F

; Bottom half - 9: Moving right - not aiming - frame 6
; Bottom half - Bh: Moving right - gun extended - frame 6
; Bottom half - Dh: Moving right - aiming up (unused) - frame 6
; Bottom half - Fh: Moving right - aiming up-right - frame 6
; Bottom half - 11h: Moving right - aiming down-right - frame 6
; Bottom half - 45h: Unused - frame 6
$92:AE0E             dx 0004, 01FB,18,280C, C3FB,00,2808, C3F3,08,280A, 01F3,18,280D

; Bottom half - 9: Moving right - not aiming - frame 8
; Bottom half - Bh: Moving right - gun extended - frame 8
; Bottom half - Dh: Moving right - aiming up (unused) - frame 8
; Bottom half - Fh: Moving right - aiming up-right - frame 8
; Bottom half - 11h: Moving right - aiming down-right - frame 8
; Bottom half - 45h: Unused - frame 8
$92:AE24             dx 0006, C3FE,06,2808, C3F6,FE,280A, 000E,0F,280C, 0006,16,280D, 01EE,0E,280E, 01EE,06,280F

; Bottom half - 0: Facing forward - power suit - frame 0
$92:AE44             dx 0008, 01F0,08,280C, 01F0,00,280D, 01F4,18,280E, 01F4,10,280F, 01F4,08,281C, 01F4,00,281D, C3FC,10,2808, C3FC,00,280A

; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 0
$92:AE6E             dx 0008, 01F0,08,280C, 01F0,00,280D, 01F4,18,280E, 01F4,10,280F, 01F4,08,281C, 01F4,00,281D, C3FC,10,2808, C3FC,00,280A

; Bottom half - 1: Facing right - normal - frame 1
; Bottom half - 1: Facing right - normal - frame 3
; Bottom half - 1: Facing right - normal - frame 6
; Bottom half - 1: Facing right - normal - frame 8
$92:AE98             dx 0003, C3F1,10,2808, C3F9,10,280A, C3F9,00,280C

; Bottom half - 1: Facing right - normal - frame 2
; Bottom half - 1: Facing right - normal - frame 7
$92:AEA9             dx 0003, C3F1,10,2808, C3F9,10,280A, C3F9,00,280C

; Bottom half - 2: Facing left  - normal - frame 1
; Bottom half - 2: Facing left  - normal - frame 3
; Bottom half - 2: Facing left  - normal - frame 6
; Bottom half - 2: Facing left  - normal - frame 8
$92:AEBA             dx 0003, C3FF,10,6808, C3F7,10,680A, C3F7,00,680C

; Bottom half - 4Fh: Facing left  - damage boost - frame 0
$92:AECB             dx 0004, 01FB,0F,280A, 01F3,0F,280B, 01EB,0F,280C, C3F3,FF,2808

; Bottom half - 50h: Facing right - damage boost - frame 0
$92:AEE1             dx 0004, 01FD,0F,780A, 0005,0F,680B, 000D,0F,680C, C3FD,FF,6808

; Bottom half - 15h: Facing right - normal jump - aiming up - frame 1
; Bottom half - 69h: Facing right - normal jump - aiming up-right - frame 1
$92:AEF7             dx 0003, C3FE,08,2808, C3F6,00,280A, 0006,00,280C

; Bottom half - 16h: Facing left  - normal jump - aiming up - frame 1
; Bottom half - 6Ah: Facing left  - normal jump - aiming up-left - frame 1
$92:AF08             dx 0003, C3F2,08,6808, C3FA,00,680A, 01F2,00,680C

; Bottom half - 25h: Facing right - turning - standing - frame 2
; Bottom half - 26h: Facing left  - turning - standing - frame 0
; Bottom half - 8Bh: Facing right - turning - standing - aiming up - frame 2
; Bottom half - 8Ch: Facing left  - turning - standing - aiming up - frame 0
; Bottom half - 8Dh: Facing right - turning - standing - aiming down-right - frame 2
; Bottom half - 8Eh: Facing left  - turning - standing - aiming down-left - frame 0
; Bottom half - 9Ch: Facing right - turning - standing - aiming up-right - frame 2
; Bottom half - 9Dh: Facing left  - turning - standing - aiming up-left - frame 0
; Bottom half - BFh: Facing right - moonwalking - turn/jump left - frame 2
; Bottom half - C0h: Facing left  - moonwalking - turn/jump right - frame 0
; Bottom half - C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 2
; Bottom half - C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 0
; Bottom half - C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 2
; Bottom half - C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 0
; Bottom half - C6h: Unused - frame 2
$92:AF19             dx 0003, 01F6,10,680C, C3FE,10,6808, C3F6,00,680A

; Bottom half - 25h: Facing right - turning - standing - frame 0
; Bottom half - 26h: Facing left  - turning - standing - frame 2
; Bottom half - 8Bh: Facing right - turning - standing - aiming up - frame 0
; Bottom half - 8Ch: Facing left  - turning - standing - aiming up - frame 2
; Bottom half - 8Dh: Facing right - turning - standing - aiming down-right - frame 0
; Bottom half - 8Eh: Facing left  - turning - standing - aiming down-left - frame 2
; Bottom half - 9Ch: Facing right - turning - standing - aiming up-right - frame 0
; Bottom half - 9Dh: Facing left  - turning - standing - aiming up-left - frame 2
; Bottom half - BFh: Facing right - moonwalking - turn/jump left - frame 0
; Bottom half - C0h: Facing left  - moonwalking - turn/jump right - frame 2
; Bottom half - C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 0
; Bottom half - C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 2
; Bottom half - C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 0
; Bottom half - C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 2
; Bottom half - C6h: Unused - frame 0
$92:AF2A             dx 0003, 0002,10,280C, C3F2,10,2808, C3FA,00,280A

; Bottom half - 2Fh: Facing right - turning - jumping - frame 2
; Bottom half - 30h: Facing left  - turning - jumping - frame 0
; Bottom half - 43h: Facing right - turning - crouching - frame 2
; Bottom half - 44h: Facing left  - turning - crouching - frame 0
; Bottom half - 87h: Facing right - turning - falling - frame 2
; Bottom half - 88h: Facing left  - turning - falling - frame 0
; Bottom half - 8Fh: Facing right - turning - in air - aiming up - frame 2
; Bottom half - 90h: Facing left  - turning - in air - aiming up - frame 0
; Bottom half - 91h: Facing right - turning - in air - aiming down/down-right - frame 2
; Bottom half - 92h: Facing left  - turning - in air - aiming down/down-left - frame 0
; Bottom half - 93h: Facing right - turning - falling - aiming up - frame 2
; Bottom half - 94h: Facing left  - turning - falling - aiming up - frame 0
; Bottom half - 95h: Facing right - turning - falling - aiming down/down-right - frame 2
; Bottom half - 96h: Facing left  - turning - falling - aiming down/down-left - frame 0
; Bottom half - 97h: Facing right - turning - crouching - aiming up - frame 2
; Bottom half - 98h: Facing left  - turning - crouching - aiming up - frame 0
; Bottom half - 99h: Facing right - turning - crouching - aiming down/down-right - frame 2
; Bottom half - 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 0
; Bottom half - 9Eh: Facing right - turning - in air - aiming up-right - frame 2
; Bottom half - 9Fh: Facing left  - turning - in air - aiming up-left - frame 0
; Bottom half - A0h: Facing right - turning - falling - aiming up-right - frame 2
; Bottom half - A1h: Facing left  - turning - falling - aiming up-left - frame 0
; Bottom half - A2h: Facing right - turning - crouching - aiming up-right - frame 2
; Bottom half - A3h: Facing left  - turning - crouching - aiming up-left - frame 0
$92:AF3B             dx 0003, 01F1,08,280A, 01F1,00,280B, C3F9,00,2808

; Bottom half - 2Fh: Facing right - turning - jumping - frame 0
; Bottom half - 30h: Facing left  - turning - jumping - frame 2
; Bottom half - 43h: Facing right - turning - crouching - frame 0
; Bottom half - 44h: Facing left  - turning - crouching - frame 2
; Bottom half - 87h: Facing right - turning - falling - frame 0
; Bottom half - 88h: Facing left  - turning - falling - frame 2
; Bottom half - 8Fh: Facing right - turning - in air - aiming up - frame 0
; Bottom half - 90h: Facing left  - turning - in air - aiming up - frame 2
; Bottom half - 91h: Facing right - turning - in air - aiming down/down-right - frame 0
; Bottom half - 92h: Facing left  - turning - in air - aiming down/down-left - frame 2
; Bottom half - 93h: Facing right - turning - falling - aiming up - frame 0
; Bottom half - 94h: Facing left  - turning - falling - aiming up - frame 2
; Bottom half - 95h: Facing right - turning - falling - aiming down/down-right - frame 0
; Bottom half - 96h: Facing left  - turning - falling - aiming down/down-left - frame 2
; Bottom half - 97h: Facing right - turning - crouching - aiming up - frame 0
; Bottom half - 98h: Facing left  - turning - crouching - aiming up - frame 2
; Bottom half - 99h: Facing right - turning - crouching - aiming down/down-right - frame 0
; Bottom half - 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 2
; Bottom half - 9Eh: Facing right - turning - in air - aiming up-right - frame 0
; Bottom half - 9Fh: Facing left  - turning - in air - aiming up-left - frame 2
; Bottom half - A0h: Facing right - turning - falling - aiming up-right - frame 0
; Bottom half - A1h: Facing left  - turning - falling - aiming up-left - frame 2
; Bottom half - A2h: Facing right - turning - crouching - aiming up-right - frame 0
; Bottom half - A3h: Facing left  - turning - crouching - aiming up-left - frame 2
$92:AF4C             dx 0003, 0007,08,680A, 0007,00,680B, C3F7,00,6808

; Bottom half - 64h: Unused - frame 1
; Bottom half - B9h: Facing right - grapple wall jump pose - frame 0
$92:AF5D             dx 0002, C3EC,00,2808, C3F4,00,280A

; Bottom half - 63h: Unused - frame 1
; Bottom half - B8h: Facing left  - grapple wall jump pose - frame 0
$92:AF69             dx 0002, C204,00,2808, C3FC,00,280A

; Bottom half - C9h: Facing right - shinespark - horizontal - frame 0
; Bottom half - CDh: Facing right - shinespark - diagonal - frame 0
$92:AF75             dx 0004, 01E8,10,680C, 01E8,08,680D, C3F0,00,6808, C200,00,680A

; Bottom half - CAh: Facing left  - shinespark - horizontal - frame 0
; Bottom half - CEh: Facing left  - shinespark - diagonal - frame 0
$92:AF8B             dx 0004, 0010,10,280C, 0010,08,280D, C200,00,2808, C3F0,00,280A

; Bottom half - 2: Facing left  - normal - frame 2
; Bottom half - 2: Facing left  - normal - frame 7
$92:AFA1             dx 0003, C3FF,10,6808, C3F7,10,680A, C3F7,00,680C

; Bottom half - 19h: Facing right - spin jump - frame Bh
; Bottom half - 1Bh: Facing right - space jump - frame Bh
; Bottom half - 81h: Facing right - screw attack - frame 1Bh
$92:AFB2             dx 0002, C3F4,00,2808, C3FC,00,280A

; Bottom half - 1Ah: Facing left  - spin jump - frame Bh
; Bottom half - 1Ch: Facing left  - space jump - frame Bh
; Bottom half - 82h: Facing left  - screw attack - frame 1Bh
$92:AFBE             dx 0002, C3FC,00,2808, C3F4,00,280A

; Bottom half - 4Ah: Facing right - moonwalk - frame 3
; Bottom half - 76h: Facing right - moonwalk - aiming up-right - frame 3
; Bottom half - 78h: Facing right - moonwalk - aiming down-right - frame 3
$92:AFCA             dx 0004, 01F0,18,680C, 01F0,10,680D, C3F8,10,6808, C3F8,00,680A

; Bottom half - 25h: Facing right - turning - standing - frame 1
; Bottom half - 26h: Facing left  - turning - standing - frame 1
; Bottom half - 8Bh: Facing right - turning - standing - aiming up - frame 1
; Bottom half - 8Ch: Facing left  - turning - standing - aiming up - frame 1
; Bottom half - 8Dh: Facing right - turning - standing - aiming down-right - frame 1
; Bottom half - 8Eh: Facing left  - turning - standing - aiming down-left - frame 1
; Bottom half - 9Ch: Facing right - turning - standing - aiming up-right - frame 1
; Bottom half - 9Dh: Facing left  - turning - standing - aiming up-left - frame 1
; Bottom half - BFh: Facing right - moonwalking - turn/jump left - frame 1
; Bottom half - C0h: Facing left  - moonwalking - turn/jump right - frame 1
; Bottom half - C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 1
; Bottom half - C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 1
; Bottom half - C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 1
; Bottom half - C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 1
; Bottom half - C6h: Unused - frame 1
$92:AFE0             dx 0002, C3F8,00,2808, C3F8,10,280A

; Bottom half - 2Fh: Facing right - turning - jumping - frame 1
; Bottom half - 30h: Facing left  - turning - jumping - frame 1
; Bottom half - 43h: Facing right - turning - crouching - frame 1
; Bottom half - 44h: Facing left  - turning - crouching - frame 1
; Bottom half - 87h: Facing right - turning - falling - frame 1
; Bottom half - 88h: Facing left  - turning - falling - frame 1
; Bottom half - 8Fh: Facing right - turning - in air - aiming up - frame 1
; Bottom half - 90h: Facing left  - turning - in air - aiming up - frame 1
; Bottom half - 91h: Facing right - turning - in air - aiming down/down-right - frame 1
; Bottom half - 92h: Facing left  - turning - in air - aiming down/down-left - frame 1
; Bottom half - 93h: Facing right - turning - falling - aiming up - frame 1
; Bottom half - 94h: Facing left  - turning - falling - aiming up - frame 1
; Bottom half - 95h: Facing right - turning - falling - aiming down/down-right - frame 1
; Bottom half - 96h: Facing left  - turning - falling - aiming down/down-left - frame 1
; Bottom half - 97h: Facing right - turning - crouching - aiming up - frame 1
; Bottom half - 98h: Facing left  - turning - crouching - aiming up - frame 1
; Bottom half - 99h: Facing right - turning - crouching - aiming down/down-right - frame 1
; Bottom half - 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 1
; Bottom half - 9Eh: Facing right - turning - in air - aiming up-right - frame 1
; Bottom half - 9Fh: Facing left  - turning - in air - aiming up-left - frame 1
; Bottom half - A0h: Facing right - turning - falling - aiming up-right - frame 1
; Bottom half - A1h: Facing left  - turning - falling - aiming up-left - frame 1
; Bottom half - A2h: Facing right - turning - crouching - aiming up-right - frame 1
; Bottom half - A3h: Facing left  - turning - crouching - aiming up-left - frame 1
$92:AFEC             dx 0001, C3F9,00,2808

; Bottom half - 4Ah: Facing right - moonwalk - frame 0
; Bottom half - 76h: Facing right - moonwalk - aiming up-right - frame 0
; Bottom half - 78h: Facing right - moonwalk - aiming down-right - frame 0
$92:AFF3             dx 0004, 01F2,18,280C, 01F2,10,280D, C3FA,10,2808, C3FA,00,280A

; Bottom half - 4Ah: Facing right - moonwalk - frame 1
; Bottom half - 76h: Facing right - moonwalk - aiming up-right - frame 1
; Bottom half - 78h: Facing right - moonwalk - aiming down-right - frame 1
$92:B009             dx 0002, C3FA,0F,6808, C3FA,FF,680A

; Bottom half - 4Ah: Facing right - moonwalk - frame 4
; Bottom half - 76h: Facing right - moonwalk - aiming up-right - frame 4
; Bottom half - 78h: Facing right - moonwalk - aiming down-right - frame 4
$92:B015             dx 0002, C3FA,0F,6808, C3FA,FF,680A

; Bottom half - 35h: Facing right - crouching transition - frame 0
; Bottom half - 3Bh: Facing right - standing transition - frame 0
; Bottom half - 4Bh: Facing right - normal jump transition - frame 0
; Bottom half - 55h: Facing right - normal jump transition - aiming up - frame 0
; Bottom half - 57h: Facing right - normal jump transition - aiming up-right - frame 0
; Bottom half - 59h: Facing right - normal jump transition - aiming down-right - frame 0
; Bottom half - A4h: Facing right - landing from normal jump - frame 0
; Bottom half - A6h: Facing right - landing from spin jump - frame 1
; Bottom half - D3h: Facing right - crystal flash - frame Eh
; Bottom half - D7h: Facing right - crystal flash ending - frame 3
; Bottom half - DBh: Unused - frame 0
; Bottom half - DCh: Unused - frame 0
; Bottom half - DDh: Unused - frame 2
; Bottom half - DEh: Unused - frame 2
; Bottom half - E0h: Facing right - landing from normal jump - aiming up - frame 0
; Bottom half - E2h: Facing right - landing from normal jump - aiming up-right - frame 0
; Bottom half - E4h: Facing right - landing from normal jump - aiming down-right - frame 0
; Bottom half - E6h: Facing right - landing from normal jump - firing - frame 0
; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame Eh
; Bottom half - EAh: Facing right - Samus drained - standing - frame 5
; Bottom half - F1h: Facing right - crouching transition - aiming up - frame 0
; Bottom half - F3h: Facing right - crouching transition - aiming up-right - frame 0
; Bottom half - F5h: Facing right - crouching transition - aiming down-right - frame 0
; Bottom half - F7h: Facing right - standing transition - aiming up - frame 0
; Bottom half - F9h: Facing right - standing transition - aiming up-right - frame 0
; Bottom half - FBh: Facing right - standing transition - aiming down-right - frame 0
$92:B021             dx 0004, 01F2,15,280C, 01F2,0D,280D, C3FA,0D,2808, C3FA,FD,280A

; Bottom half - 36h: Facing left  - crouching transition - frame 0
; Bottom half - 3Ch: Facing left  - standing transition - frame 0
; Bottom half - 4Ch: Facing left  - normal jump transition - frame 0
; Bottom half - 56h: Facing left  - normal jump transition - aiming up - frame 0
; Bottom half - 58h: Facing left  - normal jump transition - aiming up-left - frame 0
; Bottom half - 5Ah: Facing left  - normal jump transition - aiming down-left - frame 0
; Bottom half - A5h: Facing left  - landing from normal jump - frame 0
; Bottom half - A7h: Facing left  - landing from spin jump - frame 1
; Bottom half - D4h: Facing left  - crystal flash - frame Eh
; Bottom half - D8h: Facing left  - crystal flash ending - frame 3
; Bottom half - E1h: Facing left  - landing from normal jump - aiming up - frame 0
; Bottom half - E3h: Facing left  - landing from normal jump - aiming up-left - frame 0
; Bottom half - E5h: Facing left  - landing from normal jump - aiming down-left - frame 0
; Bottom half - E7h: Facing left  - landing from normal jump - firing - frame 0
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 14h
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 16h
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 7
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame Fh
; Bottom half - EBh: Facing left  - Samus drained - standing - frame 5
; Bottom half - F2h: Facing left  - crouching transition - aiming up - frame 0
; Bottom half - F4h: Facing left  - crouching transition - aiming up-left - frame 0
; Bottom half - F6h: Facing left  - crouching transition - aiming down-left - frame 0
; Bottom half - F8h: Facing left  - standing transition - aiming up - frame 0
; Bottom half - FAh: Facing left  - standing transition - aiming up-left - frame 0
; Bottom half - FCh: Facing left  - standing transition - aiming down-left - frame 0
$92:B037             dx 0004, 0006,15,680C, 0006,0D,680D, C3F6,0D,6808, C3F6,FD,680A

; Bottom half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 2
; Bottom half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 3
; Bottom half - C7h: Facing right - vertical shinespark windup - frame 2
; Bottom half - C7h: Facing right - vertical shinespark windup - frame 3
; Bottom half - F0h: Facing right - grabbed by Draygon - moving - frame 5
$92:B04D             dx 0006, 0008,10,280A, 0008,08,280B, 0000,10,280C, 01F8,10,280D, 0008,00,280E, C3F8,00,2808

; Bottom half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 2
; Bottom half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 3
; Bottom half - BEh: Facing left  - grabbed by Draygon - moving - frame 5
; Bottom half - C8h: Facing left  - vertical shinespark windup - frame 2
; Bottom half - C8h: Facing left  - vertical shinespark windup - frame 3
$92:B06D             dx 0006, 01F0,10,680A, 01F0,08,680B, 01F8,10,680C, 0000,10,680D, 01F0,00,680E, C3F8,00,6808

; Bottom half - 13h: Facing right - normal jump - not aiming - not moving - gun extended - frame 0
; Bottom half - 15h: Facing right - normal jump - aiming up - frame 0
; Bottom half - 17h: Facing right - normal jump - aiming down - frame 0
; Bottom half - 29h: Facing right - falling - frame 0
; Bottom half - 29h: Facing right - falling - frame 5
; Bottom half - 2Bh: Facing right - falling - aiming up - frame 0
; Bottom half - 2Dh: Facing right - falling - aiming down - frame 0
; Bottom half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 4
; Bottom half - 50h: Facing right - damage boost - frame 1
; Bottom half - 51h: Facing right - normal jump - not aiming - moving forward - frame 0
; Bottom half - 67h: Facing right - falling - gun extended - frame 0
; Bottom half - 67h: Facing right - falling - gun extended - frame 5
; Bottom half - 69h: Facing right - normal jump - aiming up-right - frame 0
; Bottom half - 6Bh: Facing right - normal jump - aiming down-right - frame 0
; Bottom half - 6Dh: Facing right - falling - aiming up-right - frame 0
; Bottom half - 6Fh: Facing right - falling - aiming down-right - frame 0
; Bottom half - ACh: Unused. Facing right - grappling - in air - frame 0
; Bottom half - AEh: Unused. Facing right - grappling - in air - aiming down - frame 0
; Bottom half - B0h: Unused. Facing right - grappling - in air - aiming down-right - frame 0
; Bottom half - C7h: Facing right - vertical shinespark windup - frame 4
$92:B08D             dx 0003, 0009,02,680C, C3F9,08,6808, C3F9,00,680A

; Bottom half - 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frame 0
; Bottom half - 16h: Facing left  - normal jump - aiming up - frame 0
; Bottom half - 18h: Facing left  - normal jump - aiming down - frame 0
; Bottom half - 2Ah: Facing left  - falling - frame 0
; Bottom half - 2Ah: Facing left  - falling - frame 5
; Bottom half - 2Ch: Facing left  - falling - aiming up - frame 0
; Bottom half - 2Eh: Facing left  - falling - aiming down - frame 0
; Bottom half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 4
; Bottom half - 4Fh: Facing left  - damage boost - frame 1
; Bottom half - 52h: Facing left  - normal jump - not aiming - moving forward - frame 0
; Bottom half - 68h: Facing left  - falling - gun extended - frame 0
; Bottom half - 68h: Facing left  - falling - gun extended - frame 5
; Bottom half - 6Ah: Facing left  - normal jump - aiming up-left - frame 0
; Bottom half - 6Ch: Facing left  - normal jump - aiming down-left - frame 0
; Bottom half - 6Eh: Facing left  - falling - aiming up-left - frame 0
; Bottom half - 70h: Facing left  - falling - aiming down-left - frame 0
; Bottom half - ADh: Unused. Facing left  - grappling - in air - frame 0
; Bottom half - AFh: Unused. Facing left  - grappling - in air - aiming down - frame 0
; Bottom half - B1h: Unused. Facing left  - grappling - in air - aiming down-left - frame 0
; Bottom half - C8h: Facing left  - vertical shinespark windup - frame 4
$92:B09E             dx 0003, 01EF,02,280C, C3F7,08,2808, C3F7,00,280A

; Bottom half - 29h: Facing right - falling - frame 1
; Bottom half - 29h: Facing right - falling - frame 2
; Bottom half - 2Bh: Facing right - falling - aiming up - frame 1
; Bottom half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 5
; Bottom half - 53h: Facing right - knockback - frame 0
; Bottom half - 67h: Facing right - falling - gun extended - frame 1
; Bottom half - 67h: Facing right - falling - gun extended - frame 2
; Bottom half - 6Dh: Facing right - falling - aiming up-right - frame 1
; Bottom half - 6Fh: Facing right - falling - aiming down-right - frame 1
; Bottom half - C7h: Facing right - vertical shinespark windup - frame 5
; Bottom half - D7h: Facing right - crystal flash ending - frame 4
; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame 3
; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame 4
; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame 5
; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame 6
; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame 7
; Bottom half - F0h: Facing right - grabbed by Draygon - moving - frame 0
; Bottom half - F0h: Facing right - grabbed by Draygon - moving - frame 3
$92:B0AF             dx 0002, C3FC,10,6808, C3FC,00,680A

; Bottom half - 2Ah: Facing left  - falling - frame 1
; Bottom half - 2Ah: Facing left  - falling - frame 2
; Bottom half - 2Ch: Facing left  - falling - aiming up - frame 1
; Bottom half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 5
; Bottom half - 54h: Facing left  - knockback - frame 0
; Bottom half - 68h: Facing left  - falling - gun extended - frame 1
; Bottom half - 68h: Facing left  - falling - gun extended - frame 2
; Bottom half - 6Eh: Facing left  - falling - aiming up-left - frame 1
; Bottom half - 70h: Facing left  - falling - aiming down-left - frame 1
; Bottom half - BEh: Facing left  - grabbed by Draygon - moving - frame 0
; Bottom half - BEh: Facing left  - grabbed by Draygon - moving - frame 3
; Bottom half - C8h: Facing left  - vertical shinespark windup - frame 5
; Bottom half - D8h: Facing left  - crystal flash ending - frame 4
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 2
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 3
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 4
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 5
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 6
$92:B0BB             dx 0002, C3F4,10,2808, C3F4,00,280A

; Bottom half - 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 1
; Bottom half - C7h: Facing right - vertical shinespark windup - frame 1
; Bottom half - F0h: Facing right - grabbed by Draygon - moving - frame 4
$92:B0C7             dx 0005, 0004,0F,280A, 01F4,10,280B, 01FC,17,280C, 01FC,0F,280D, C3FC,FF,2808

; Bottom half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 1
; Bottom half - BEh: Facing left  - grabbed by Draygon - moving - frame 4
; Bottom half - C8h: Facing left  - vertical shinespark windup - frame 1
$92:B0E2             dx 0005, 01F4,0F,680A, 0004,10,680B, 01FC,17,680C, 01FC,0F,680D, C3F4,FF,6808

; Bottom half - 17h: Facing right - normal jump - aiming down - frame 1
; Bottom half - 2Dh: Facing right - falling - aiming down - frame 1
; Bottom half - AEh: Unused. Facing right - grappling - in air - aiming down - frame 1
$92:B104             dx 0006, 01FA,10,680A, 0002,10,680B, 01F2,10,680C, 01F2,08,680D, 01F2,00,680E, C3FA,00,6808

; Bottom half - 18h: Facing left  - normal jump - aiming down - frame 1
; Bottom half - 2Eh: Facing left  - falling - aiming down - frame 1
; Bottom half - AFh: Unused. Facing left  - grappling - in air - aiming down - frame 1
$92:B124             dx 0006, 01FE,10,280A, 01F6,10,280B, 0006,10,280C, 0006,08,280D, 0006,00,280E, C3F6,00,2808

; Bottom half - 65h: Unused - frame 0
; Bottom half - 83h: Facing right - wall jump - frame 0
$92:B144             dx 0007, 000C,01,280A, 0004,02,280B, 01FC,10,280C, 01F4,10,280D, 01F4,08,280E, 000C,00,280F, C3FC,00,2808

; Bottom half - 66h: Unused - frame 0
; Bottom half - 84h: Facing left  - wall jump - frame 0
$92:B169             dx 0005, 01FC,10,680A, 0004,10,680B, 0004,08,680C, 01EC,00,680D, C3F4,00,6808

; Bottom half - 49h: Facing left  - moonwalk - frame 2
; Bottom half - 63h: Unused - frame 0
; Bottom half - 75h: Facing left  - moonwalk - aiming up-left - frame 2
; Bottom half - 77h: Facing left  - moonwalk - aiming down-left - frame 2
$92:B184             dx 0003, C3F8,0F,2808, 0008,0F,280C, C3F8,FF,280A

; Bottom half - 49h: Facing left  - moonwalk - frame 5
; Bottom half - 64h: Unused - frame 0
; Bottom half - 75h: Facing left  - moonwalk - aiming up-left - frame 5
; Bottom half - 77h: Facing left  - moonwalk - aiming down-left - frame 5
$92:B195             dx 0003, C3F8,0F,2808, 0008,0F,280C, C3F8,FF,280A

; Bottom half - 4Ah: Facing right - moonwalk - frame 2
; Bottom half - 76h: Facing right - moonwalk - aiming up-right - frame 2
; Bottom half - 78h: Facing right - moonwalk - aiming down-right - frame 2
$92:B1A6             dx 0003, C3F8,0F,6808, 01F0,0F,680C, C3F8,FF,680A

; Bottom half - 4Ah: Facing right - moonwalk - frame 5
; Bottom half - 76h: Facing right - moonwalk - aiming up-right - frame 5
; Bottom half - 78h: Facing right - moonwalk - aiming down-right - frame 5
$92:B1B7             dx 0003, C3F8,0F,6808, 01F0,0F,680C, C3F8,FF,680A

; Bottom half - 13h: Facing right - normal jump - not aiming - not moving - gun extended - frame 1
; Bottom half - 19h: Facing right - spin jump - frame 0
; Bottom half - 1Bh: Facing right - space jump - frame 0
; Bottom half - 29h: Facing right - falling - frame 6
; Bottom half - 2Bh: Facing right - falling - aiming up - frame 2
; Bottom half - 50h: Facing right - damage boost - frame 9
; Bottom half - 51h: Facing right - normal jump - not aiming - moving forward - frame 1
; Bottom half - 67h: Facing right - falling - gun extended - frame 6
; Bottom half - 6Bh: Facing right - normal jump - aiming down-right - frame 1
; Bottom half - 6Dh: Facing right - falling - aiming up-right - frame 2
; Bottom half - 6Fh: Facing right - falling - aiming down-right - frame 2
; Bottom half - 81h: Facing right - screw attack - frame 0
; Bottom half - 83h: Facing right - wall jump - frame 1
; Bottom half - A6h: Facing right - landing from spin jump - frame 0
; Bottom half - ACh: Unused. Facing right - grappling - in air - frame 1
; Bottom half - B0h: Unused. Facing right - grappling - in air - aiming down-right - frame 1
; Bottom half - F0h: Facing right - grabbed by Draygon - moving - frame 2
$92:B1C8             dx 0005, 01F6,10,680C, 01F6,08,680D, 01F6,00,680E, C3FE,08,6808, C3FE,00,680A

; Bottom half - 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frame 1
; Bottom half - 1Ah: Facing left  - spin jump - frame 0
; Bottom half - 1Ch: Facing left  - space jump - frame 0
; Bottom half - 2Ah: Facing left  - falling - frame 6
; Bottom half - 2Ch: Facing left  - falling - aiming up - frame 2
; Bottom half - 4Fh: Facing left  - damage boost - frame 9
; Bottom half - 52h: Facing left  - normal jump - not aiming - moving forward - frame 1
; Bottom half - 68h: Facing left  - falling - gun extended - frame 6
; Bottom half - 6Ch: Facing left  - normal jump - aiming down-left - frame 1
; Bottom half - 6Eh: Facing left  - falling - aiming up-left - frame 2
; Bottom half - 70h: Facing left  - falling - aiming down-left - frame 2
; Bottom half - 82h: Facing left  - screw attack - frame 0
; Bottom half - 84h: Facing left  - wall jump - frame 1
; Bottom half - A7h: Facing left  - landing from spin jump - frame 0
; Bottom half - ADh: Unused. Facing left  - grappling - in air - frame 1
; Bottom half - B1h: Unused. Facing left  - grappling - in air - aiming down-left - frame 1
; Bottom half - BEh: Facing left  - grabbed by Draygon - moving - frame 2
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 13h
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 17h
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame Eh
$92:B1E3             dx 0005, 0002,10,280C, 0002,08,280D, 0002,00,280E, C3F2,08,2808, C3F2,00,280A

; Bottom half - 53h: Facing right - knockback - frame 1
; Bottom half - D7h: Facing right - crystal flash ending - frame 5
; Bottom half - ECh: Facing right - grabbed by Draygon - not moving - not aiming - frame 0
; Bottom half - EDh: Facing right - grabbed by Draygon - not moving - aiming up-right - frame 0
; Bottom half - EEh: Facing right - grabbed by Draygon - firing - frame 0
; Bottom half - EFh: Facing right - grabbed by Draygon - not moving - aiming down-right - frame 0
; Bottom half - F0h: Facing right - grabbed by Draygon - moving - frame 1
$92:B1FE             dx 0004, C3FD,08,6808, 01F8,18,680C, 01F5,10,680D, C3FD,00,680A

; Bottom half - 54h: Facing left  - knockback - frame 1
; Bottom half - BAh: Facing left  - grabbed by Draygon - not moving - not aiming - frame 0
; Bottom half - BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left - frame 0
; Bottom half - BCh: Facing left  - grabbed by Draygon - firing - frame 0
; Bottom half - BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left - frame 0
; Bottom half - BEh: Facing left  - grabbed by Draygon - moving - frame 1
; Bottom half - D8h: Facing left  - crystal flash ending - frame 5
$92:B214             dx 0004, C3F3,08,2808, 0000,18,280C, 0003,10,280D, C3F3,00,280A

; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 1Ah
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 1Dh
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 8
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 9
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame Ah
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame Bh
; Bottom half - EBh: Facing left  - Samus drained - standing - frame 0
; Bottom half - EBh: Facing left  - Samus drained - standing - frame 1
; Bottom half - EBh: Facing left  - Samus drained - standing - frame 2
; Bottom half - EBh: Facing left  - Samus drained - standing - frame 3
$92:B236             dx 0002, 0004,08,280A, C3F4,00,2808

; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame 8
; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame 9
; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame Ah
; Bottom half - E8h: Facing right - Samus drained - crouching/falling - frame Bh
; Bottom half - EAh: Facing right - Samus drained - standing - frame 0
; Bottom half - EAh: Facing right - Samus drained - standing - frame 1
; Bottom half - EAh: Facing right - Samus drained - standing - frame 2
; Bottom half - EAh: Facing right - Samus drained - standing - frame 3
$92:B242             dx 0002, 01F4,08,680A, C3FC,00,6808

; Bottom half - 0: Facing forward - power suit - frame 10h
; Bottom half - 0: Facing forward - power suit - frame 11h
; Bottom half - 0: Facing forward - power suit - frame 12h
; Bottom half - 0: Facing forward - power suit - frame 13h
; Bottom half - 0: Facing forward - power suit - frame 14h
; Bottom half - 0: Facing forward - power suit - frame 15h
; Bottom half - 0: Facing forward - power suit - frame 16h
; Bottom half - 0: Facing forward - power suit - frame 17h
; Bottom half - 0: Facing forward - power suit - frame 18h
; Bottom half - 0: Facing forward - power suit - frame 19h
; Bottom half - 0: Facing forward - power suit - frame 1Ah
; Bottom half - 0: Facing forward - power suit - frame 1Bh
; Bottom half - 0: Facing forward - power suit - frame 1Ch
; Bottom half - 0: Facing forward - power suit - frame 1Dh
; Bottom half - 0: Facing forward - power suit - frame 1Eh
; Bottom half - 0: Facing forward - power suit - frame 1Fh
; Bottom half - 0: Facing forward - power suit - frame 2
; Bottom half - 0: Facing forward - power suit - frame 20h
; Bottom half - 0: Facing forward - power suit - frame 21h
; Bottom half - 0: Facing forward - power suit - frame 22h
; Bottom half - 0: Facing forward - power suit - frame 23h
; Bottom half - 0: Facing forward - power suit - frame 24h
; Bottom half - 0: Facing forward - power suit - frame 25h
; Bottom half - 0: Facing forward - power suit - frame 26h
; Bottom half - 0: Facing forward - power suit - frame 27h
; Bottom half - 0: Facing forward - power suit - frame 28h
; Bottom half - 0: Facing forward - power suit - frame 29h
; Bottom half - 0: Facing forward - power suit - frame 2Ah
; Bottom half - 0: Facing forward - power suit - frame 2Bh
; Bottom half - 0: Facing forward - power suit - frame 2Ch
; Bottom half - 0: Facing forward - power suit - frame 2Dh
; Bottom half - 0: Facing forward - power suit - frame 2Eh
; Bottom half - 0: Facing forward - power suit - frame 2Fh
; Bottom half - 0: Facing forward - power suit - frame 3
; Bottom half - 0: Facing forward - power suit - frame 30h
; Bottom half - 0: Facing forward - power suit - frame 31h
; Bottom half - 0: Facing forward - power suit - frame 32h
; Bottom half - 0: Facing forward - power suit - frame 33h
; Bottom half - 0: Facing forward - power suit - frame 34h
; Bottom half - 0: Facing forward - power suit - frame 35h
; Bottom half - 0: Facing forward - power suit - frame 36h
; Bottom half - 0: Facing forward - power suit - frame 37h
; Bottom half - 0: Facing forward - power suit - frame 38h
; Bottom half - 0: Facing forward - power suit - frame 39h
; Bottom half - 0: Facing forward - power suit - frame 3Ah
; Bottom half - 0: Facing forward - power suit - frame 3Bh
; Bottom half - 0: Facing forward - power suit - frame 3Ch
; Bottom half - 0: Facing forward - power suit - frame 3Dh
; Bottom half - 0: Facing forward - power suit - frame 3Eh
; Bottom half - 0: Facing forward - power suit - frame 3Fh
; Bottom half - 0: Facing forward - power suit - frame 4
; Bottom half - 0: Facing forward - power suit - frame 40h
; Bottom half - 0: Facing forward - power suit - frame 41h
; Bottom half - 0: Facing forward - power suit - frame 42h
; Bottom half - 0: Facing forward - power suit - frame 43h
; Bottom half - 0: Facing forward - power suit - frame 44h
; Bottom half - 0: Facing forward - power suit - frame 45h
; Bottom half - 0: Facing forward - power suit - frame 46h
; Bottom half - 0: Facing forward - power suit - frame 47h
; Bottom half - 0: Facing forward - power suit - frame 48h
; Bottom half - 0: Facing forward - power suit - frame 49h
; Bottom half - 0: Facing forward - power suit - frame 4Ah
; Bottom half - 0: Facing forward - power suit - frame 4Bh
; Bottom half - 0: Facing forward - power suit - frame 4Ch
; Bottom half - 0: Facing forward - power suit - frame 4Dh
; Bottom half - 0: Facing forward - power suit - frame 4Eh
; Bottom half - 0: Facing forward - power suit - frame 4Fh
; Bottom half - 0: Facing forward - power suit - frame 5
; Bottom half - 0: Facing forward - power suit - frame 50h
; Bottom half - 0: Facing forward - power suit - frame 51h
; Bottom half - 0: Facing forward - power suit - frame 52h
; Bottom half - 0: Facing forward - power suit - frame 53h
; Bottom half - 0: Facing forward - power suit - frame 54h
; Bottom half - 0: Facing forward - power suit - frame 55h
; Bottom half - 0: Facing forward - power suit - frame 56h
; Bottom half - 0: Facing forward - power suit - frame 57h
; Bottom half - 0: Facing forward - power suit - frame 58h
; Bottom half - 0: Facing forward - power suit - frame 59h
; Bottom half - 0: Facing forward - power suit - frame 5Ah
; Bottom half - 0: Facing forward - power suit - frame 5Bh
; Bottom half - 0: Facing forward - power suit - frame 5Ch
; Bottom half - 0: Facing forward - power suit - frame 5Dh
; Bottom half - 0: Facing forward - power suit - frame 5Eh
; Bottom half - 0: Facing forward - power suit - frame 5Fh
; Bottom half - 0: Facing forward - power suit - frame 6
; Bottom half - 0: Facing forward - power suit - frame 7
; Bottom half - 0: Facing forward - power suit - frame 8
; Bottom half - 0: Facing forward - power suit - frame 9
; Bottom half - 0: Facing forward - power suit - frame Ah
; Bottom half - 0: Facing forward - power suit - frame Bh
; Bottom half - 0: Facing forward - power suit - frame Ch
; Bottom half - 0: Facing forward - power suit - frame Dh
; Bottom half - 0: Facing forward - power suit - frame Eh
; Bottom half - 0: Facing forward - power suit - frame Fh
$92:B24E             dx 0006, C3F1,08,7808, C200,08,3808, C3F0,F8,380A, C200,F8,380C, C3F1,E8,780E, C200,E8,380E

; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 10h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 11h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 12h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 13h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 14h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 15h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 16h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 17h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 18h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 19h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 1Ah
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 1Bh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 1Ch
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 1Dh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 1Eh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 1Fh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 2
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 20h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 21h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 22h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 23h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 24h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 25h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 26h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 27h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 28h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 29h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 2Ah
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 2Bh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 2Ch
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 2Dh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 2Eh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 2Fh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 3
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 30h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 31h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 32h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 33h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 34h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 35h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 36h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 37h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 38h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 39h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 3Ah
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 3Bh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 3Ch
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 3Dh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 3Eh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 3Fh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 4
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 40h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 41h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 42h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 43h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 44h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 45h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 46h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 47h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 48h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 49h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 4Ah
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 4Bh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 4Ch
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 4Dh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 4Eh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 4Fh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 5
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 50h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 51h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 52h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 53h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 54h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 55h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 56h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 57h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 58h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 59h
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 5Ah
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 5Bh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 5Ch
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 5Dh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 5Eh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 5Fh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 6
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 7
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 8
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame 9
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame Ah
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame Bh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame Ch
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame Dh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame Eh
; Bottom half - 9Bh: Facing forward - varia/gravity suit - frame Fh
$92:B26E             dx 0006, C3F1,08,7808, C3F1,E8,780A, C3F0,F8,380C, C200,08,3808, C200,F8,380E, C200,E8,380A

; Bottom half - 3: Facing right - aiming up - frame 0
; Bottom half - 3: Facing right - aiming up - frame 1
; Bottom half - 5: Facing right - aiming up-right - frame 0
; Bottom half - 7: Facing right - aiming down-right - frame 0
; Bottom half - AAh: Facing right - grappling - aiming down-right - frame 0
; Bottom half - CFh: Facing right - ran into a wall - aiming up-right - frame 0
; Bottom half - D1h: Facing right - ran into a wall - aiming down-right - frame 0
$92:B295             dx 0004, 01F1,18,280C, 01F1,10,280D, C3F9,10,2808, C3F9,00,280A

; Bottom half - 4: Facing left  - aiming up - frame 0
; Bottom half - 4: Facing left  - aiming up - frame 1
; Bottom half - 6: Facing left  - aiming up-left - frame 0
; Bottom half - 8: Facing left  - aiming down-left - frame 0
; Bottom half - ABh: Facing left  - grappling - aiming down-left - frame 0
; Bottom half - D0h: Facing left  - ran into a wall - aiming up-left - frame 0
; Bottom half - D2h: Facing left  - ran into a wall - aiming down-left - frame 0
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 10h
; Bottom half - E9h: Facing left  - Samus drained - crouching/falling - frame 15h
$92:B2AB             dx 0004, 0007,18,680C, 0007,10,680D, C3F7,10,6808, C3F7,00,680A

; Bottom half - Ah: Moving left  - not aiming - frame 0
; Bottom half - Ch: Moving left  - gun extended - frame 0
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 0
; Bottom half - 10h: Moving left  - aiming up-left - frame 0
; Bottom half - 12h: Moving left  - aiming down-left - frame 0
; Bottom half - 46h: Unused - frame 0
$92:B2C1             dx 0002, C3F8,10,6808, C3F8,00,680A

; Bottom half - Ah: Moving left  - not aiming - frame 2
; Bottom half - Ch: Moving left  - gun extended - frame 2
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 2
; Bottom half - 10h: Moving left  - aiming up-left - frame 2
; Bottom half - 12h: Moving left  - aiming down-left - frame 2
; Bottom half - 46h: Unused - frame 2
$92:B2CD             dx 0005, C3FD,07,6808, C3F5,FF,680A, 000D,0F,680C, 0005,17,680D, 01F5,0F,680E

; Bottom half - Ah: Moving left  - not aiming - frame 4
; Bottom half - Ch: Moving left  - gun extended - frame 4
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 4
; Bottom half - 10h: Moving left  - aiming up-left - frame 4
; Bottom half - 12h: Moving left  - aiming down-left - frame 4
; Bottom half - 46h: Unused - frame 4
$92:B2E8             dx 0004, C200,FF,6808, C3F0,0F,680A, C3F8,FF,680C, 01F0,07,680E

; Bottom half - Ah: Moving left  - not aiming - frame 5
; Bottom half - Ch: Moving left  - gun extended - frame 5
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 5
; Bottom half - 10h: Moving left  - aiming up-left - frame 5
; Bottom half - 12h: Moving left  - aiming down-left - frame 5
; Bottom half - 46h: Unused - frame 5
; Bottom half - 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 0
; Bottom half - C8h: Facing left  - vertical shinespark windup - frame 0
$92:B2FE             dx 0002, C3F9,10,6808, C3F9,00,680A

; Bottom half - Ah: Moving left  - not aiming - frame 7
; Bottom half - Ch: Moving left  - gun extended - frame 7
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 7
; Bottom half - 10h: Moving left  - aiming up-left - frame 7
; Bottom half - 12h: Moving left  - aiming down-left - frame 7
; Bottom half - 46h: Unused - frame 7
$92:B30A             dx 0006, C3FD,07,6808, C3F5,FF,680A, 0005,FF,680C, 000D,0F,680D, 0005,17,680E, 01F5,0F,680F

; Bottom half - Ah: Moving left  - not aiming - frame 9
; Bottom half - Ch: Moving left  - gun extended - frame 9
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 9
; Bottom half - 10h: Moving left  - aiming up-left - frame 9
; Bottom half - 12h: Moving left  - aiming down-left - frame 9
; Bottom half - 46h: Unused - frame 9
$92:B32A             dx 0004, C201,FF,6808, C3F1,0F,680A, C3F9,FF,680C, 0001,0F,680E

; Bottom half - 2: Facing left  - normal - frame 0
; Bottom half - 2: Facing left  - normal - frame 5
; Bottom half - 48h: Unused - frame 0
; Bottom half - 8Ah: Facing left  - ran into a wall - frame 0
; Bottom half - A5h: Facing left  - landing from normal jump - frame 1
; Bottom half - A7h: Facing left  - landing from spin jump - frame 2
; Bottom half - A9h: Facing left  - grappling - frame 0
; Bottom half - D6h: Facing left  - x-ray - standing - frame 0
; Bottom half - D6h: Facing left  - x-ray - standing - frame 1
; Bottom half - D6h: Facing left  - x-ray - standing - frame 2
; Bottom half - D6h: Facing left  - x-ray - standing - frame 3
; Bottom half - D6h: Facing left  - x-ray - standing - frame 4
; Bottom half - E1h: Facing left  - landing from normal jump - aiming up - frame 1
; Bottom half - E3h: Facing left  - landing from normal jump - aiming up-left - frame 1
; Bottom half - E5h: Facing left  - landing from normal jump - aiming down-left - frame 1
; Bottom half - E7h: Facing left  - landing from normal jump - firing - frame 1
$92:B340             dx 0003, C3FF,10,6808, C3F7,10,680A, C3F7,00,680C

; Bottom half - 27h: Facing right - crouching - frame 0
; Bottom half - 27h: Facing right - crouching - frame 1
; Bottom half - 27h: Facing right - crouching - frame 2
; Bottom half - 27h: Facing right - crouching - frame 3
; Bottom half - 27h: Facing right - crouching - frame 5
; Bottom half - 27h: Facing right - crouching - frame 6
; Bottom half - 27h: Facing right - crouching - frame 7
; Bottom half - 27h: Facing right - crouching - frame 8
; Bottom half - 71h: Facing right - crouching - aiming up-right - frame 0
; Bottom half - 73h: Facing right - crouching - aiming down-right - frame 0
; Bottom half - 85h: Facing right - crouching - aiming up - frame 0
; Bottom half - 85h: Facing right - crouching - aiming up - frame 1
; Bottom half - B4h: Facing right - grappling - crouching - frame 0
; Bottom half - B6h: Facing right - grappling - crouching - aiming down-right - frame 0
; Bottom half - D9h: Facing right - x-ray - crouching - frame 0
; Bottom half - D9h: Facing right - x-ray - crouching - frame 1
; Bottom half - D9h: Facing right - x-ray - crouching - frame 2
; Bottom half - D9h: Facing right - x-ray - crouching - frame 3
; Bottom half - D9h: Facing right - x-ray - crouching - frame 4
$92:B351             dx 0002, C201,00,6808, C3F9,00,680A

; Bottom half - Ah: Moving left  - not aiming - frame 1
; Bottom half - Ch: Moving left  - gun extended - frame 1
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 1
; Bottom half - 10h: Moving left  - aiming up-left - frame 1
; Bottom half - 12h: Moving left  - aiming down-left - frame 1
; Bottom half - 46h: Unused - frame 1
$92:B35D             dx 0004, C3F5,00,6808, C3FD,10,680A, 0005,08,680C, 01F5,10,680D

; Bottom half - Ah: Moving left  - not aiming - frame 3
; Bottom half - Ch: Moving left  - gun extended - frame 3
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 3
; Bottom half - 10h: Moving left  - aiming up-left - frame 3
; Bottom half - 12h: Moving left  - aiming down-left - frame 3
; Bottom half - 46h: Unused - frame 3
$92:B373             dx 0006, C3F1,06,6808, C3F9,FE,680A, 01E9,0F,680C, 0009,0E,680D, 0009,06,680E, 01F1,16,680F

; Bottom half - Ah: Moving left  - not aiming - frame 6
; Bottom half - Ch: Moving left  - gun extended - frame 6
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 6
; Bottom half - 10h: Moving left  - aiming up-left - frame 6
; Bottom half - 12h: Moving left  - aiming down-left - frame 6
; Bottom half - 46h: Unused - frame 6
$92:B393             dx 0004, 01FD,18,680C, C3F5,00,6808, C3FD,08,680A, 0005,18,680D

; Bottom half - Ah: Moving left  - not aiming - frame 8
; Bottom half - Ch: Moving left  - gun extended - frame 8
; Bottom half - Eh: Moving left  - aiming up (unused) - frame 8
; Bottom half - 10h: Moving left  - aiming up-left - frame 8
; Bottom half - 12h: Moving left  - aiming down-left - frame 8
; Bottom half - 46h: Unused - frame 8
$92:B3A9             dx 0006, C3F2,06,6808, C3FA,FE,680A, 01EA,0F,680C, 01F2,16,680D, 000A,0E,680E, 000A,06,680F

; Bottom half - 49h: Facing left  - moonwalk - frame 3
; Bottom half - 75h: Facing left  - moonwalk - aiming up-left - frame 3
; Bottom half - 77h: Facing left  - moonwalk - aiming down-left - frame 3
$92:B3C9             dx 0004, 0008,18,280C, 0008,10,280D, C3F8,10,2808, C3F8,00,280A

; Bottom half - 49h: Facing left  - moonwalk - frame 0
; Bottom half - 75h: Facing left  - moonwalk - aiming up-left - frame 0
; Bottom half - 77h: Facing left  - moonwalk - aiming down-left - frame 0
$92:B3ED             dx 0004, 0006,18,680C, 0006,10,680D, C3F6,10,6808, C3F6,00,680A

; Bottom half - 49h: Facing left  - moonwalk - frame 1
; Bottom half - 75h: Facing left  - moonwalk - aiming up-left - frame 1
; Bottom half - 77h: Facing left  - moonwalk - aiming down-left - frame 1
$92:B403             dx 0002, C3F6,0F,2808, C3F6,FF,280A

; Bottom half - 49h: Facing left  - moonwalk - frame 4
; Bottom half - 75h: Facing left  - moonwalk - aiming up-left - frame 4
; Bottom half - 77h: Facing left  - moonwalk - aiming down-left - frame 4
$92:B40F             dx 0002, C3F6,0F,2808, C3F6,FF,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 17h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 18h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 19h
$92:B41B             dx 0003, 01E8,04,280A, 01E8,FC,280B, C3F0,FC,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 15h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 16h
$92:B42C             dx 0006, 01E9,0D,280A, 01E9,05,280B, 01E9,FD,280C, 01F9,0D,280D, 01F1,0D,280E, C3F1,FD,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 13h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 14h
$92:B44C             dx 0003, C3E9,07,2808, 01E9,FF,280C, C3F1,FF,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 12h
$92:B45D             dx 0004, 01F8,10,280A, 01F0,10,280B, 01F0,08,280C, C3F8,00,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 11h
$92:B473             dx 0005, 0003,10,280A, 01FB,10,280B, 01F3,10,280C, 01F3,08,280D, C3FB,00,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 10h
$92:B48E             dx 0005, 01F5,08,280A, 0005,10,280B, 01FD,10,280C, 01F5,10,280D, C3FD,00,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame Fh
$92:B4A9             dx 0003, 0005,10,280A, 01FD,10,280B, C3FD,00,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame Eh
$92:B4BA             dx 0004, 000F,0F,280A, 0007,0F,280B, 01FF,FF,280C, C207,FF,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame Ch
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame Dh
$92:B4D0             dx 0004, 0007,0B,280A, 000F,0B,280B, 000F,03,280C, C3FF,FB,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame Ah
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame Bh
$92:B4E6             dx 0005, 0008,08,280A, 0010,F8,280B, 0010,08,280C, 0010,00,280D, C200,F8,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 40h
$92:B512             dx 0002, C3F8,10,2808, C3F8,00,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 41h
$92:B51E             dx 0002, C3F8,10,2808, C3F8,00,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 37h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 38h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 39h
$92:B52A             dx 0002, C3F0,F9,2808, C3E0,F9,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 35h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 36h
$92:B536             dx 0004, 01E1,0F,280A, 01E1,07,280B, 01F9,FF,280C, C3E9,FF,2808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 33h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 34h
$92:B54C             dx 0002, C3E9,07,2808, C3F1,FF,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 32h
$92:B558             dx 0002, C3EB,0F,2808, C3F3,FF,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 31h
$92:B564             dx 0004, 01F3,07,280A, C3F3,0F,2808, 01FB,07,280B, 01FB,FF,280C

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 30h
$92:B57A             dx 0002, C3F9,10,2808, C3F9,00,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 2Fh
$92:B586             dx 0002, C3FD,0E,2808, C3FD,FE,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 2Eh
$92:B592             dx 0002, C207,0F,2808, C3FF,FF,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 2Ch
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 2Dh
$92:B59E             dx 0004, 0018,10,280C, 0018,08,280D, C208,08,2808, C200,00,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 2Ah
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 2Bh
$92:B5B4             dx 0002, C20F,04,2808, C3FF,FC,280A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 7
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 8
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 9
$92:B5CC             dx 0003, 0010,F4,E80A, 0010,FC,E80B, C200,F4,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 5
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 6
$92:B5DD             dx 0006, 000F,EB,E80A, 000F,F3,E80B, 000F,FB,E80C, 01FF,EB,E80D, 0007,EB,E80E, C3FF,F3,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 3
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 4
$92:B5FD             dx 0003, C207,E9,E808, 000F,F9,E80C, C3FF,F1,E80A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 2
$92:B60E             dx 0004, 0000,E8,E80A, 0008,E8,E80B, 0008,F0,E80C, C3F8,F0,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 1
$92:B624             dx 0005, 01F5,E8,E80A, 01FD,E8,E80B, 0005,E8,E80C, 0005,F0,E80D, C3F5,F0,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 0
$92:B63F             dx 0005, 0003,F0,E80A, 01F3,E8,E80B, 01FB,E8,E80C, 0003,E8,E80D, C3F3,F0,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 1Fh
$92:B65A             dx 0003, 01F3,E8,E80A, 01FB,E8,E80B, C3F3,F0,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 1Eh
$92:B66B             dx 0004, 01E9,E9,E80A, 01F1,E9,E80B, 01F9,F9,E80C, C3E9,F1,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 1Ch
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 1Dh
$92:B681             dx 0004, 01F1,ED,E80A, 01E9,ED,E80B, 01E9,F5,E80C, C3F1,F5,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 1Ah
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 1Bh
$92:B697             dx 0005, 01F0,F0,E80A, 01E8,00,E80B, 01E8,F0,E80C, 01E8,F8,E80D, C3F0,F8,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 27h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 28h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 29h
$92:B6DB             dx 0002, C200,F7,E808, C210,F7,E80A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 25h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 26h
$92:B6E7             dx 0004, 0017,E9,E80A, 0017,F1,E80B, 01FF,F9,E80C, C207,F1,E808

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 23h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 24h
$92:B6FD             dx 0002, C207,E9,E808, C3FF,F1,E80A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 22h
$92:B709             dx 0002, C205,E1,E808, C3FD,F1,E80A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 21h
$92:B715             dx 0004, 0005,F1,E80A, C3FD,E1,E808, 01FD,F1,E80B, 01FD,F9,E80C

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 20h
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 3Fh
$92:B72B             dx 0002, C3F7,E0,E808, C3F7,F0,E80A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 3Eh
$92:B737             dx 0002, C3F3,E2,E808, C3F3,F2,E80A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 3Ch
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 3Dh
$92:B743             dx 0002, C3E9,E1,E808, C3F1,F1,E80A

; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 3Ah
; Bottom half - B2h: Facing clockwise     - grapple swinging - frame 3Bh
$92:B74F             dx 0002, C3E1,EC,E808, C3F1,F4,E80A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 7
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 8
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 9
$92:B767             dx 0003, 0010,04,680A, 0010,FC,680B, C200,FC,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame Ah
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame Bh
$92:B778             dx 0006, 000F,0D,680A, 000F,05,680B, 000F,FD,680C, 01FF,0D,680D, 0007,0D,680E, C3FF,FD,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame Ch
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame Dh
$92:B798             dx 0003, C207,07,6808, 000F,FF,680C, C3FF,FF,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame Eh
$92:B7A9             dx 0004, 0000,10,680A, 0008,10,680B, 0008,08,680C, C3F8,00,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame Fh
$92:B7BF             dx 0005, 01F5,10,680A, 01FD,10,680B, 0005,10,680C, 0005,08,680D, C3F5,00,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 10h
$92:B7DA             dx 0005, 0003,08,680A, 01F3,10,680B, 01FB,10,680C, 0003,10,680D, C3F3,00,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 11h
$92:B7F5             dx 0003, 01F3,10,680A, 01FB,10,680B, C3F3,00,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 12h
$92:B806             dx 0004, 01E9,0F,680A, 01F1,0F,680B, 01F9,FF,680C, C3E9,FF,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 13h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 14h
$92:B81C             dx 0004, 01F1,0B,680A, 01E9,0B,680B, 01E9,03,680C, C3F1,FB,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 15h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 16h
$92:B832             dx 0005, 01F0,08,680A, 01E8,F8,680B, 01E8,08,680C, 01E8,00,680D, C3F0,F8,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 40h
$92:B85E             dx 0002, C3F8,10,6808, C3F8,00,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 41h
$92:B86A             dx 0002, C3F8,10,6808, C3F8,00,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 27h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 28h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 29h
$92:B876             dx 0002, C200,F9,6808, C210,F9,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 2Ah
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 2Bh
$92:B882             dx 0004, 0017,0F,680A, 0017,07,680B, 01FF,FF,680C, C207,FF,6808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 2Ch
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 2Dh
$92:B898             dx 0002, C207,07,6808, C3FF,FF,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 2Eh
$92:B8A4             dx 0002, C205,0F,6808, C3FD,FF,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 2Fh
$92:B8B0             dx 0004, 0005,07,680A, C3FD,0F,6808, 01FD,07,680B, 01FD,FF,680C

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 30h
$92:B8C6             dx 0002, C3F7,10,6808, C3F7,00,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 31h
$92:B8D2             dx 0002, C3F3,0E,6808, C3F3,FE,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 32h
$92:B8DE             dx 0002, C3E9,0F,6808, C3F1,FF,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 33h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 34h
$92:B8EA             dx 0004, 01E0,10,680C, 01E0,08,680D, C3E8,08,6808, C3F0,00,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 35h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 36h
$92:B900             dx 0002, C3E1,04,6808, C3F1,FC,680A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 17h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 18h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 19h
$92:B918             dx 0003, 01E8,F4,A80A, 01E8,FC,A80B, C3F0,F4,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 1Ah
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 1Bh
$92:B929             dx 0006, 01E9,EB,A80A, 01E9,F3,A80B, 01E9,FB,A80C, 01F9,EB,A80D, 01F1,EB,A80E, C3F1,F3,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 1Ch
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 1Dh
$92:B949             dx 0003, C3E9,E9,A808, 01E9,F9,A80C, C3F1,F1,A80A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 1Eh
$92:B95A             dx 0004, 01F8,E8,A80A, 01F0,E8,A80B, 01F0,F0,A80C, C3F8,F0,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 1Fh
$92:B970             dx 0005, 0003,E8,A80A, 01FB,E8,A80B, 01F3,E8,A80C, 01F3,F0,A80D, C3FB,F0,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 0
$92:B98B             dx 0005, 01F5,F0,A80A, 0005,E8,A80B, 01FD,E8,A80C, 01F5,E8,A80D, C3FD,F0,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 1
$92:B9A6             dx 0003, 0005,E8,A80A, 01FD,E8,A80B, C3FD,F0,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 2
$92:B9B7             dx 0004, 000F,E9,A80A, 0007,E9,A80B, 01FF,F9,A80C, C207,F1,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 3
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 4
$92:B9CD             dx 0004, 0007,ED,A80A, 000F,ED,A80B, 000F,F5,A80C, C3FF,F5,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 5
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 6
$92:B9E3             dx 0005, 0008,F0,A80A, 0010,00,A80B, 0010,F0,A80C, 0010,F8,A80D, C200,F8,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 37h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 38h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 39h
$92:BA27             dx 0002, C3F0,F7,A808, C3E0,F7,A80A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 3Ah
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 3Bh
$92:BA33             dx 0004, 01E1,E9,A80A, 01E1,F1,A80B, 01F9,F9,A80C, C3E9,F1,A808

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 3Ch
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 3Dh
$92:BA49             dx 0002, C3E9,E9,A808, C3F1,F1,A80A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 3Eh
$92:BA55             dx 0002, C3EB,E1,A808, C3F3,F1,A80A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 3Fh
$92:BA61             dx 0004, 01F3,F1,A80A, C3F3,E1,A808, 01FB,F1,A80B, 01FB,F9,A80C

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 20h
$92:BA77             dx 0002, C3F9,E0,A808, C3F9,F0,A80A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 21h
$92:BA83             dx 0002, C3FD,E2,A808, C3FD,F2,A80A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 22h
$92:BA8F             dx 0002, C207,E1,A808, C3FF,F1,A80A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 23h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 24h
$92:BA9B             dx 0002, C20F,EC,A808, C3FF,F4,A80A

; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 25h
; Bottom half - B3h: Facing anticlockwise - grapple swinging - frame 26h
$92:BAA7             dx 0002, C200,F8,6808, C210,F8,680A

; Bottom half - C5h: Unused - frame 7
; Bottom half - DFh: Unused - frame 7
; Top half - 1Dh: Facing right - morph ball - no springball - on ground - frame 0
; Top half - 1Eh: Moving right - morph ball - no springball - on ground - frame 0
; Top half - 1Fh: Moving left  - morph ball - no springball - on ground - frame 7
; Top half - 31h: Facing right - morph ball - no springball - in air - frame 0
; Top half - 32h: Facing left  - morph ball - no springball - in air - frame 0
; Top half - 3Fh: Unused - frame 0
; Top half - 40h: Unused - frame 0
; Top half - 41h: Facing left  - morph ball - no springball - on ground - frame 7
; Top half - 79h: Facing right - morph ball - spring ball - on ground - frame 0
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground - frame 7
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground - frame 0
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground - frame 7
; Top half - 7Dh: Facing right - morph ball - spring ball - falling - frame 0
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling - frame 7
; Top half - 7Fh: Facing right - morph ball - spring ball - in air - frame 0
; Top half - 80h: Facing left  - morph ball - spring ball - in air - frame 7
; Top half - C5h: Unused - frame 7
; Top half - D7h: Facing right - crystal flash ending - frame 0
; Top half - DFh: Unused - frame 7
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 0
$92:BAB3             dx 0002, 01F8,F8,2802, C3F8,F8,2800

; Bottom half - C5h: Unused - frame 5
; Bottom half - DFh: Unused - frame 5
; Top half - 1Dh: Facing right - morph ball - no springball - on ground - frame 2
; Top half - 1Eh: Moving right - morph ball - no springball - on ground - frame 2
; Top half - 1Fh: Moving left  - morph ball - no springball - on ground - frame 5
; Top half - 31h: Facing right - morph ball - no springball - in air - frame 2
; Top half - 32h: Facing left  - morph ball - no springball - in air - frame 2
; Top half - 41h: Facing left  - morph ball - no springball - on ground - frame 5
; Top half - 79h: Facing right - morph ball - spring ball - on ground - frame 2
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground - frame 5
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground - frame 2
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground - frame 5
; Top half - 7Dh: Facing right - morph ball - spring ball - falling - frame 2
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling - frame 5
; Top half - 7Fh: Facing right - morph ball - spring ball - in air - frame 2
; Top half - 80h: Facing left  - morph ball - spring ball - in air - frame 5
; Top half - C5h: Unused - frame 5
; Top half - DFh: Unused - frame 5
$92:BABF             dx 0002, 01F8,F8,2802, C3F8,F8,6800

; Bottom half - C5h: Unused - frame 3
; Bottom half - DFh: Unused - frame 3
; Top half - 1Dh: Facing right - morph ball - no springball - on ground - frame 4
; Top half - 1Eh: Moving right - morph ball - no springball - on ground - frame 4
; Top half - 1Fh: Moving left  - morph ball - no springball - on ground - frame 3
; Top half - 31h: Facing right - morph ball - no springball - in air - frame 4
; Top half - 32h: Facing left  - morph ball - no springball - in air - frame 4
; Top half - 41h: Facing left  - morph ball - no springball - on ground - frame 3
; Top half - 79h: Facing right - morph ball - spring ball - on ground - frame 4
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground - frame 3
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground - frame 4
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground - frame 3
; Top half - 7Dh: Facing right - morph ball - spring ball - falling - frame 4
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling - frame 3
; Top half - 7Fh: Facing right - morph ball - spring ball - in air - frame 4
; Top half - 80h: Facing left  - morph ball - spring ball - in air - frame 3
; Top half - C5h: Unused - frame 3
; Top half - DFh: Unused - frame 3
$92:BACB             dx 0002, 01F8,F8,2802, C3F8,F8,E800

; Bottom half - C5h: Unused - frame 1
; Bottom half - DFh: Unused - frame 1
; Top half - 1Dh: Facing right - morph ball - no springball - on ground - frame 6
; Top half - 1Eh: Moving right - morph ball - no springball - on ground - frame 6
; Top half - 1Fh: Moving left  - morph ball - no springball - on ground - frame 1
; Top half - 31h: Facing right - morph ball - no springball - in air - frame 6
; Top half - 32h: Facing left  - morph ball - no springball - in air - frame 6
; Top half - 41h: Facing left  - morph ball - no springball - on ground - frame 1
; Top half - 79h: Facing right - morph ball - spring ball - on ground - frame 6
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground - frame 1
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground - frame 6
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground - frame 1
; Top half - 7Dh: Facing right - morph ball - spring ball - falling - frame 6
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling - frame 1
; Top half - 7Fh: Facing right - morph ball - spring ball - in air - frame 6
; Top half - 80h: Facing left  - morph ball - spring ball - in air - frame 1
; Top half - C5h: Unused - frame 1
; Top half - DFh: Unused - frame 1
$92:BAD7             dx 0002, 01F8,F8,2802, C3F8,F8,A800

; Bottom half - C5h: Unused - frame 6
; Bottom half - DFh: Unused - frame 6
; Top half - 1Dh: Facing right - morph ball - no springball - on ground - frame 1
; Top half - 1Eh: Moving right - morph ball - no springball - on ground - frame 1
; Top half - 1Fh: Moving left  - morph ball - no springball - on ground - frame 6
; Top half - 31h: Facing right - morph ball - no springball - in air - frame 1
; Top half - 32h: Facing left  - morph ball - no springball - in air - frame 1
; Top half - 41h: Facing left  - morph ball - no springball - on ground - frame 6
; Top half - 79h: Facing right - morph ball - spring ball - on ground - frame 1
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground - frame 6
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground - frame 1
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground - frame 6
; Top half - 7Dh: Facing right - morph ball - spring ball - falling - frame 1
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling - frame 6
; Top half - 7Fh: Facing right - morph ball - spring ball - in air - frame 1
; Top half - 80h: Facing left  - morph ball - spring ball - in air - frame 6
; Top half - C5h: Unused - frame 6
; Top half - DFh: Unused - frame 6
$92:BAE3             dx 0005, 01F8,F8,2800, 0000,FF,2801, 01F8,FF,2802, 0000,F7,2803, 01F8,F7,2804

; Bottom half - C5h: Unused - frame 4
; Bottom half - DFh: Unused - frame 4
; Top half - 1Dh: Facing right - morph ball - no springball - on ground - frame 3
; Top half - 1Eh: Moving right - morph ball - no springball - on ground - frame 3
; Top half - 1Fh: Moving left  - morph ball - no springball - on ground - frame 4
; Top half - 31h: Facing right - morph ball - no springball - in air - frame 3
; Top half - 32h: Facing left  - morph ball - no springball - in air - frame 3
; Top half - 41h: Facing left  - morph ball - no springball - on ground - frame 4
; Top half - 79h: Facing right - morph ball - spring ball - on ground - frame 3
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground - frame 4
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground - frame 3
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground - frame 4
; Top half - 7Dh: Facing right - morph ball - spring ball - falling - frame 3
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling - frame 4
; Top half - 7Fh: Facing right - morph ball - spring ball - in air - frame 3
; Top half - 80h: Facing left  - morph ball - spring ball - in air - frame 4
; Top half - C5h: Unused - frame 4
; Top half - DFh: Unused - frame 4
$92:BAFE             dx 0002, 01F8,F8,2802, C3F8,F9,2800

; Bottom half - C5h: Unused - frame 2
; Bottom half - DFh: Unused - frame 2
; Top half - 1Dh: Facing right - morph ball - no springball - on ground - frame 5
; Top half - 1Eh: Moving right - morph ball - no springball - on ground - frame 5
; Top half - 1Fh: Moving left  - morph ball - no springball - on ground - frame 2
; Top half - 31h: Facing right - morph ball - no springball - in air - frame 5
; Top half - 32h: Facing left  - morph ball - no springball - in air - frame 5
; Top half - 41h: Facing left  - morph ball - no springball - on ground - frame 2
; Top half - 79h: Facing right - morph ball - spring ball - on ground - frame 5
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground - frame 2
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground - frame 5
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground - frame 2
; Top half - 7Dh: Facing right - morph ball - spring ball - falling - frame 5
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling - frame 2
; Top half - 7Fh: Facing right - morph ball - spring ball - in air - frame 5
; Top half - 80h: Facing left  - morph ball - spring ball - in air - frame 2
; Top half - C5h: Unused - frame 2
; Top half - DFh: Unused - frame 2
$92:BB0A             dx 0002, 01F8,F8,2802, C3F8,F7,A800

; Bottom half - C5h: Unused - frame 0
; Bottom half - DFh: Unused - frame 0
; Top half - 1Dh: Facing right - morph ball - no springball - on ground - frame 7
; Top half - 1Eh: Moving right - morph ball - no springball - on ground - frame 7
; Top half - 1Fh: Moving left  - morph ball - no springball - on ground - frame 0
; Top half - 31h: Facing right - morph ball - no springball - in air - frame 7
; Top half - 32h: Facing left  - morph ball - no springball - in air - frame 7
; Top half - 41h: Facing left  - morph ball - no springball - on ground - frame 0
; Top half - 79h: Facing right - morph ball - spring ball - on ground - frame 7
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground - frame 0
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground - frame 7
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground - frame 0
; Top half - 7Dh: Facing right - morph ball - spring ball - falling - frame 7
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling - frame 0
; Top half - 7Fh: Facing right - morph ball - spring ball - in air - frame 7
; Top half - 80h: Facing left  - morph ball - spring ball - in air - frame 0
; Top half - C5h: Unused - frame 0
; Top half - D8h: Facing left  - crystal flash ending - frame 0
; Top half - DFh: Unused - frame 0
$92:BB16             dx 0002, 01F8,F8,2802, C3F8,F9,6800

; Top half - 1Ah: Facing left  - spin jump - frame 1
; Top half - 66h: Unused - frame 1
; Top half - 84h: Facing left  - wall jump - frame 3
$92:BB22             dx 0002, C3F8,00,2800, C3F8,F0,2802

; Top half - 1Ah: Facing left  - spin jump - frame 2
; Top half - 4Fh: Facing left  - damage boost - frame 8
; Top half - 66h: Unused - frame 2
; Top half - 84h: Facing left  - wall jump - frame 4
$92:BB2E             dx 0004, C200,F1,2800, C3F0,01,2802, C200,01,2804, C3F0,F1,2806

; Top half - 1Ah: Facing left  - spin jump - frame 3
; Top half - 4Fh: Facing left  - damage boost - frame 7
; Top half - 66h: Unused - frame 3
; Top half - 84h: Facing left  - wall jump - frame 5
$92:BB44             dx 0002, C200,F8,2800, C3F0,F8,2802

; Top half - 1Ah: Facing left  - spin jump - frame 4
; Top half - 4Fh: Facing left  - damage boost - frame 6
; Top half - 66h: Unused - frame 4
; Top half - 84h: Facing left  - wall jump - frame 6
$92:BB50             dx 0004, C201,01,E800, C3F1,F1,E802, C3F1,01,E804, C201,F1,E806

; Top half - 1Ah: Facing left  - spin jump - frame 5
; Top half - 4Fh: Facing left  - damage boost - frame 5
; Top half - 66h: Unused - frame 5
; Top half - 84h: Facing left  - wall jump - frame 7
$92:BB66             dx 0002, C3F8,F0,E800, C3F8,00,E802

; Top half - 1Ah: Facing left  - spin jump - frame 6
; Top half - 4Fh: Facing left  - damage boost - frame 4
; Top half - 66h: Unused - frame 6
; Top half - 84h: Facing left  - wall jump - frame 8
$92:BB72             dx 0004, C3F1,FF,E800, C201,EF,E802, C201,FF,E804, C3F1,EF,E806

; Top half - 1Ah: Facing left  - spin jump - frame 7
; Top half - 4Fh: Facing left  - damage boost - frame 3
; Top half - 66h: Unused - frame 7
; Top half - 84h: Facing left  - wall jump - frame 9
$92:BB88             dx 0002, C3F0,F8,E800, C200,F8,E802

; Top half - 1Ah: Facing left  - spin jump - frame 8
; Top half - 4Fh: Facing left  - damage boost - frame 2
; Top half - 66h: Unused - frame 8
; Top half - 84h: Facing left  - wall jump - frame Ah
$92:BB94             dx 0004, C3EF,EE,2800, C3FF,FE,2802, C3EF,FE,2804, C3FF,EE,2806

; Top half - 82h: Facing left  - screw attack - frame 1
; Top half - 82h: Facing left  - screw attack - frame 2
; Top half - 82h: Facing left  - screw attack - frame 3
; Top half - 84h: Facing left  - wall jump - frame 17h
; Top half - 84h: Facing left  - wall jump - frame 18h
; Top half - 84h: Facing left  - wall jump - frame 19h
$92:BBAA             dx 000A, 01F8,0A,2800, 01F0,0A,2801, 000A,00,2802, 01EE,00,2803, 000A,F6,2804, 01EE,F8,2805, 000A,EE,2806, 0000,EE,2807, 01F8,EE,2810, 01EE,F0,2811

; Top half - 82h: Facing left  - screw attack - frame 7
; Top half - 82h: Facing left  - screw attack - frame 8
; Top half - 82h: Facing left  - screw attack - frame 9
; Top half - 84h: Facing left  - wall jump - frame 1Dh
; Top half - 84h: Facing left  - wall jump - frame 1Eh
; Top half - 84h: Facing left  - wall jump - frame 1Fh
$92:BBDE             dx 000B, 0000,08,2800, 01F8,08,2801, 01F0,08,2802, 0008,00,2803, 01F0,00,2804, 0008,F8,2805, 01F0,F6,2806, 0008,F0,2807, 0000,F0,2810, 01F8,EE,2811, 01F0,EE,2812

; Top half - 82h: Facing left  - screw attack - frame Dh
; Top half - 82h: Facing left  - screw attack - frame Eh
; Top half - 82h: Facing left  - screw attack - frame Fh
; Top half - 84h: Facing left  - wall jump - frame 23h
; Top half - 84h: Facing left  - wall jump - frame 24h
; Top half - 84h: Facing left  - wall jump - frame 25h
$92:BC17             dx 000B, 000A,08,2800, 0002,08,2801, 01F8,08,2802, 01F0,08,2803, 000A,00,2804, 01EE,00,2805, 000A,F6,2806, 01EE,F8,2807, 000A,EE,2810, 01F8,EE,2811, 01F0,EE,2812

; Top half - 82h: Facing left  - screw attack - frame 13h
; Top half - 82h: Facing left  - screw attack - frame 14h
; Top half - 82h: Facing left  - screw attack - frame 15h
; Top half - 84h: Facing left  - wall jump - frame 29h
; Top half - 84h: Facing left  - wall jump - frame 2Ah
; Top half - 84h: Facing left  - wall jump - frame 2Bh
$92:BC50             dx 0008, 0008,08,2800, 0000,08,2801, 01F8,08,2802, 01F0,08,2803, 0008,00,2804, 0008,F0,2805, 0000,F0,2806, 01F0,F0,2807

; Top half - 1Ch: Facing left  - space jump - frame 1
; Top half - 1Ch: Facing left  - space jump - frame 2
; Top half - 1Ch: Facing left  - space jump - frame 3
; Top half - 1Ch: Facing left  - space jump - frame 4
; Top half - 1Ch: Facing left  - space jump - frame 5
; Top half - 1Ch: Facing left  - space jump - frame 6
; Top half - 1Ch: Facing left  - space jump - frame 7
; Top half - 1Ch: Facing left  - space jump - frame 8
; Top half - 82h: Facing left  - screw attack - frame 10h
; Top half - 82h: Facing left  - screw attack - frame 11h
; Top half - 82h: Facing left  - screw attack - frame 12h
; Top half - 82h: Facing left  - screw attack - frame 16h
; Top half - 82h: Facing left  - screw attack - frame 17h
; Top half - 82h: Facing left  - screw attack - frame 18h
; Top half - 82h: Facing left  - screw attack - frame 4
; Top half - 82h: Facing left  - screw attack - frame 5
; Top half - 82h: Facing left  - screw attack - frame 6
; Top half - 82h: Facing left  - screw attack - frame Ah
; Top half - 82h: Facing left  - screw attack - frame Bh
; Top half - 82h: Facing left  - screw attack - frame Ch
; Top half - 84h: Facing left  - wall jump - frame 10h
; Top half - 84h: Facing left  - wall jump - frame 11h
; Top half - 84h: Facing left  - wall jump - frame 12h
; Top half - 84h: Facing left  - wall jump - frame 13h
; Top half - 84h: Facing left  - wall jump - frame 14h
; Top half - 84h: Facing left  - wall jump - frame 1Ah
; Top half - 84h: Facing left  - wall jump - frame 1Bh
; Top half - 84h: Facing left  - wall jump - frame 1Ch
; Top half - 84h: Facing left  - wall jump - frame 20h
; Top half - 84h: Facing left  - wall jump - frame 21h
; Top half - 84h: Facing left  - wall jump - frame 22h
; Top half - 84h: Facing left  - wall jump - frame 26h
; Top half - 84h: Facing left  - wall jump - frame 27h
; Top half - 84h: Facing left  - wall jump - frame 28h
; Top half - 84h: Facing left  - wall jump - frame 2Ch
; Top half - 84h: Facing left  - wall jump - frame 2Dh
; Top half - 84h: Facing left  - wall jump - frame 2Eh
; Top half - 84h: Facing left  - wall jump - frame Dh
; Top half - 84h: Facing left  - wall jump - frame Eh
; Top half - 84h: Facing left  - wall jump - frame Fh
$92:BC7A             dx 0001, 01F8,F8,1000

; Bottom half - C5h: Unused - frame 9
; Bottom half - DFh: Unused - frame 9
; Top half - 1Dh: Facing right - morph ball - no springball - on ground - frame 9
; Top half - 1Eh: Moving right - morph ball - no springball - on ground - frame 9
; Top half - 1Fh: Moving left  - morph ball - no springball - on ground - frame 9
; Top half - 31h: Facing right - morph ball - no springball - in air - frame 9
; Top half - 32h: Facing left  - morph ball - no springball - in air - frame 9
; Top half - 41h: Facing left  - morph ball - no springball - on ground - frame 9
; Top half - 79h: Facing right - morph ball - spring ball - on ground - frame 9
; Top half - 7Ah: Facing left  - morph ball - spring ball - on ground - frame 9
; Top half - 7Bh: Moving right - morph ball - spring ball - on ground - frame 9
; Top half - 7Ch: Moving left  - morph ball - spring ball - on ground - frame 9
; Top half - 7Dh: Facing right - morph ball - spring ball - falling - frame 9
; Top half - 7Eh: Facing left  - morph ball - spring ball - falling - frame 9
; Top half - 7Fh: Facing right - morph ball - spring ball - in air - frame 9
; Top half - 80h: Facing left  - morph ball - spring ball - in air - frame 9
; Top half - C5h: Unused - frame 9
; Top half - DFh: Unused - frame 9
$92:BC88             dx 0002, 0007,FC,2802, C3F7,F9,2800

; Top half - 38h: Facing left  - morphing transition - frame 1
; Top half - 3Eh: Facing left  - unmorphing transition - frame 0
; Top half - D4h: Facing left  - crystal flash - frame 0
; Top half - D8h: Facing left  - crystal flash ending - frame 1
; Top half - DCh: Unused - frame 2
; Top half - DEh: Unused - frame 0
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 0
$92:BCA0             dx 0003, 0000,05,2802, 01F8,05,2803, C3F8,F5,2800

; Top half - 38h: Facing left  - morphing transition - frame 0
; Top half - 3Eh: Facing left  - unmorphing transition - frame 1
; Top half - D4h: Facing left  - crystal flash - frame 1
; Top half - D4h: Facing left  - crystal flash - frame 3
; Top half - D4h: Facing left  - crystal flash - frame Ch
; Top half - D4h: Facing left  - crystal flash - frame Dh
; Top half - D8h: Facing left  - crystal flash ending - frame 2
; Top half - DCh: Unused - frame 1
; Top half - DEh: Unused - frame 1
; Top half - E9h: Facing left  - Samus drained - crouching/falling - frame 1
$92:BCB1             dx 0005, 0000,0A,2802, 01F8,0A,2803, 0000,02,2804, 01F8,02,2805, C3F8,F2,2800

; Top half - 37h: Facing right - morphing transition - frame 1
; Top half - 3Dh: Facing right - unmorphing transition - frame 0
; Top half - D3h: Facing right - crystal flash - frame 0
; Top half - D7h: Facing right - crystal flash ending - frame 1
; Top half - DBh: Unused - frame 2
; Top half - DDh: Unused - frame 0
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 1
$92:BCCC             dx 0003, 01F8,05,6802, 0000,05,6803, C3F8,F5,6800

; Top half - 37h: Facing right - morphing transition - frame 0
; Top half - 3Dh: Facing right - unmorphing transition - frame 1
; Top half - D3h: Facing right - crystal flash - frame 1
; Top half - D3h: Facing right - crystal flash - frame 3
; Top half - D3h: Facing right - crystal flash - frame Ch
; Top half - D3h: Facing right - crystal flash - frame Dh
; Top half - D7h: Facing right - crystal flash ending - frame 2
; Top half - DBh: Unused - frame 1
; Top half - DDh: Unused - frame 1
; Top half - E8h: Facing right - Samus drained - crouching/falling - frame 2
$92:BCDD             dx 0005, 01F8,0A,6802, 0000,0A,6803, 01F8,02,6804, 0000,02,6805, C3F8,F2,6800

; Top half - 19h: Facing right - spin jump - frame 1
; Top half - 65h: Unused - frame 1
; Top half - 83h: Facing right - wall jump - frame 3
$92:BD67             dx 0002, C3F8,00,6800, C3F8,F0,6802

; Top half - 19h: Facing right - spin jump - frame 2
; Top half - 50h: Facing right - damage boost - frame 8
; Top half - 65h: Unused - frame 2
; Top half - 83h: Facing right - wall jump - frame 4
$92:BD73             dx 0004, C3F0,F1,6800, C200,01,6802, C3F0,01,6804, C200,F1,6806

; Top half - 19h: Facing right - spin jump - frame 3
; Top half - 50h: Facing right - damage boost - frame 7
; Top half - 65h: Unused - frame 3
; Top half - 83h: Facing right - wall jump - frame 5
$92:BD89             dx 0002, C3F0,F8,6800, C200,F8,6802

; Top half - 19h: Facing right - spin jump - frame 4
; Top half - 50h: Facing right - damage boost - frame 6
; Top half - 65h: Unused - frame 4
; Top half - 83h: Facing right - wall jump - frame 6
$92:BD95             dx 0004, C3EF,01,A800, C3FF,F1,A802, C3FF,01,A804, C3EF,F1,A806

; Top half - 19h: Facing right - spin jump - frame 5
; Top half - 50h: Facing right - damage boost - frame 5
; Top half - 65h: Unused - frame 5
; Top half - 83h: Facing right - wall jump - frame 7
$92:BDAB             dx 0002, C3F8,F0,A800, C3F8,00,A802

; Top half - 19h: Facing right - spin jump - frame 6
; Top half - 50h: Facing right - damage boost - frame 4
; Top half - 65h: Unused - frame 6
; Top half - 83h: Facing right - wall jump - frame 8
$92:BDB7             dx 0004, C3FF,FF,A800, C3EF,EF,A802, C3EF,FF,A804, C3FF,EF,A806

; Top half - 19h: Facing right - spin jump - frame 7
; Top half - 50h: Facing right - damage boost - frame 3
; Top half - 65h: Unused - frame 7
; Top half - 83h: Facing right - wall jump - frame 9
$92:BDCD             dx 0002, C200,F8,A800, C3F0,F8,A802

; Top half - 19h: Facing right - spin jump - frame 8
; Top half - 50h: Facing right - damage boost - frame 2
; Top half - 65h: Unused - frame 8
; Top half - 83h: Facing right - wall jump - frame Ah
$92:BDD9             dx 0004, C201,EE,6800, C3F1,FE,6802, C201,FE,6804, C3F1,EE,6806

; Top half - 81h: Facing right - screw attack - frame 1
; Top half - 81h: Facing right - screw attack - frame 2
; Top half - 81h: Facing right - screw attack - frame 3
; Top half - 83h: Facing right - wall jump - frame 17h
; Top half - 83h: Facing right - wall jump - frame 18h
; Top half - 83h: Facing right - wall jump - frame 19h
$92:BDEF             dx 000A, 0000,0A,6800, 0008,0A,6801, 01EE,00,6802, 000A,00,6803, 01EE,F6,6804, 000A,F8,6805, 01EE,EE,6806, 01F8,EE,6807, 0000,EE,6810, 000A,F0,6811

; Top half - 81h: Facing right - screw attack - frame 7
; Top half - 81h: Facing right - screw attack - frame 8
; Top half - 81h: Facing right - screw attack - frame 9
; Top half - 83h: Facing right - wall jump - frame 1Dh
; Top half - 83h: Facing right - wall jump - frame 1Eh
; Top half - 83h: Facing right - wall jump - frame 1Fh
$92:BE23             dx 000B, 01F8,08,6800, 0000,08,6801, 0008,08,6802, 01F0,00,6803, 0008,00,6804, 01F0,F8,6805, 0008,F6,6806, 01F0,F0,6807, 01F8,F0,6810, 0000,EE,6811, 0008,EE,6812

; Top half - 81h: Facing right - screw attack - frame Dh
; Top half - 81h: Facing right - screw attack - frame Eh
; Top half - 81h: Facing right - screw attack - frame Fh
; Top half - 83h: Facing right - wall jump - frame 23h
; Top half - 83h: Facing right - wall jump - frame 24h
; Top half - 83h: Facing right - wall jump - frame 25h
$92:BE5C             dx 000B, 01EE,08,6800, 01F6,08,6801, 0000,08,6802, 0008,08,6803, 01EE,00,6804, 000A,00,6805, 01EE,F6,6806, 000A,F8,6807, 01EE,EE,6810, 0000,EE,6811, 0008,EE,6812

; Top half - 81h: Facing right - screw attack - frame 13h
; Top half - 81h: Facing right - screw attack - frame 14h
; Top half - 81h: Facing right - screw attack - frame 15h
; Top half - 83h: Facing right - wall jump - frame 29h
; Top half - 83h: Facing right - wall jump - frame 2Ah
; Top half - 83h: Facing right - wall jump - frame 2Bh
$92:BE95             dx 0008, 01F0,08,6800, 01F8,08,6801, 0000,08,6802, 0008,08,6803, 01F0,00,6804, 01F0,F0,6805, 01F8,F0,6806, 0008,F0,6807

; Top half - 1Bh: Facing right - space jump - frame 1
; Top half - 1Bh: Facing right - space jump - frame 2
; Top half - 1Bh: Facing right - space jump - frame 3
; Top half - 1Bh: Facing right - space jump - frame 4
; Top half - 1Bh: Facing right - space jump - frame 5
; Top half - 1Bh: Facing right - space jump - frame 6
; Top half - 1Bh: Facing right - space jump - frame 7
; Top half - 1Bh: Facing right - space jump - frame 8
; Top half - 81h: Facing right - screw attack - frame 10h
; Top half - 81h: Facing right - screw attack - frame 11h
; Top half - 81h: Facing right - screw attack - frame 12h
; Top half - 81h: Facing right - screw attack - frame 16h
; Top half - 81h: Facing right - screw attack - frame 17h
; Top half - 81h: Facing right - screw attack - frame 18h
; Top half - 81h: Facing right - screw attack - frame 4
; Top half - 81h: Facing right - screw attack - frame 5
; Top half - 81h: Facing right - screw attack - frame 6
; Top half - 81h: Facing right - screw attack - frame Ah
; Top half - 81h: Facing right - screw attack - frame Bh
; Top half - 81h: Facing right - screw attack - frame Ch
; Top half - 83h: Facing right - wall jump - frame 10h
; Top half - 83h: Facing right - wall jump - frame 11h
; Top half - 83h: Facing right - wall jump - frame 12h
; Top half - 83h: Facing right - wall jump - frame 13h
; Top half - 83h: Facing right - wall jump - frame 14h
; Top half - 83h: Facing right - wall jump - frame 1Ah
; Top half - 83h: Facing right - wall jump - frame 1Bh
; Top half - 83h: Facing right - wall jump - frame 1Ch
; Top half - 83h: Facing right - wall jump - frame 20h
; Top half - 83h: Facing right - wall jump - frame 21h
; Top half - 83h: Facing right - wall jump - frame 22h
; Top half - 83h: Facing right - wall jump - frame 26h
; Top half - 83h: Facing right - wall jump - frame 27h
; Top half - 83h: Facing right - wall jump - frame 28h
; Top half - 83h: Facing right - wall jump - frame 2Ch
; Top half - 83h: Facing right - wall jump - frame 2Dh
; Top half - 83h: Facing right - wall jump - frame 2Eh
; Top half - 83h: Facing right - wall jump - frame Dh
; Top half - 83h: Facing right - wall jump - frame Eh
; Top half - 83h: Facing right - wall jump - frame Fh
$92:BEBF             dx 0001, 01F8,F8,3000

; Top half - CBh: Facing right - shinespark - vertical - frame 0
$92:C162             dx 0005, 0000,F8,2806, 01F8,F8,2807, C3F8,08,6800, C3F8,F8,6802, C3F8,E8,2804

; Top half - CCh: Facing left  - shinespark - vertical - frame 0
$92:C17D             dx 0005, 0000,F8,2806, 01F8,F8,2807, C3F8,08,2800, C3F8,F8,2802, C3F8,E8,2804

; Top half - D4h: Facing left  - crystal flash - frame 2
; Top half - D4h: Facing left  - crystal flash - frame 6
$92:C198             dx 0007, C3F8,EC,2C00, 0000,0C,2C02, 01F8,0C,2C03, 0000,04,2C04, 01F8,04,2C05, 0000,FC,2C06, 01F8,FC,2C07

; Top half - D4h: Facing left  - crystal flash - frame 7
; Top half - D4h: Facing left  - crystal flash - frame 9
$92:C1BD             dx 0007, C3F8,EB,2C00, 0000,0B,2C02, 01F8,0B,2C03, 0000,03,2C04, 01F8,03,2C05, 0000,FB,2C06, 01F8,FB,2C07

; Top half - D4h: Facing left  - crystal flash - frame 8
$92:C1E2             dx 0007, C3F8,EA,2C00, 0000,0A,2C02, 01F8,0A,2C03, 0000,02,2C04, 01F8,02,2C05, 0000,FA,2C06, 01F8,FA,2C07

; Top half - D3h: Facing right - crystal flash - frame 2
; Top half - D3h: Facing right - crystal flash - frame 6
$92:C207             dx 0007, C3F8,EC,6C00, 01F8,0C,6C02, 0000,0C,6C03, 01F8,04,6C04, 0000,04,6C05, 01F8,FC,6C06, 0000,FC,6C07

; Top half - D3h: Facing right - crystal flash - frame 7
; Top half - D3h: Facing right - crystal flash - frame 9
$92:C22C             dx 0007, C3F8,EB,6C00, 01F8,0B,6C02, 0000,0B,6C03, 01F8,03,6C04, 0000,03,6C05, 01F8,FB,6C06, 0000,FB,6C07

; Top half - D3h: Facing right - crystal flash - frame 8
$92:C251             dx 0007, C3F8,EA,6C00, 01F8,0A,6C02, 0000,0A,6C03, 01F8,02,6C04, 0000,02,6C05, 01F8,FA,6C06, 0000,FA,6C07

; Bottom half - D3h: Facing right - crystal flash - frame 0
; Bottom half - D3h: Facing right - crystal flash - frame Dh
; Bottom half - D4h: Facing left  - crystal flash - frame 0
; Bottom half - D4h: Facing left  - crystal flash - frame Dh
$92:C276             dx 0004, C200,00,FC08, C3F0,00,BC08, C200,F0,7C08, C3F0,F0,3C08

; Bottom half - D3h: Facing right - crystal flash - frame 1
; Bottom half - D3h: Facing right - crystal flash - frame Ch
; Bottom half - D4h: Facing left  - crystal flash - frame 1
; Bottom half - D4h: Facing left  - crystal flash - frame Ch
$92:C28C             dx 0010, C200,00,FC08, C210,00,FC0A, C200,10,FC0C, C210,10,FC0E, C3F0,00,BC08, C3E0,00,BC0A, C3F0,10,BC0C, C3E0,10,BC0E, C200,F0,7C08, C210,F0,7C0A, C200,E0,7C0C, C210,E0,7C0E, C3E0,E0,3C0E, C3E0,F0,3C0A, C3F0,E0,3C0C, C3F0,F0,3C08

; Bottom half - D3h: Facing right - crystal flash - frame 2
; Bottom half - D3h: Facing right - crystal flash - frame 3
; Bottom half - D3h: Facing right - crystal flash - frame 6
; Bottom half - D3h: Facing right - crystal flash - frame 7
; Bottom half - D3h: Facing right - crystal flash - frame 8
; Bottom half - D3h: Facing right - crystal flash - frame 9
; Bottom half - D4h: Facing left  - crystal flash - frame 2
; Bottom half - D4h: Facing left  - crystal flash - frame 3
; Bottom half - D4h: Facing left  - crystal flash - frame 6
; Bottom half - D4h: Facing left  - crystal flash - frame 7
; Bottom half - D4h: Facing left  - crystal flash - frame 8
; Bottom half - D4h: Facing left  - crystal flash - frame 9
$92:C2DE             dx 0010, C200,00,FC08, C210,00,FC0A, C200,10,FC0C, C210,10,FC0E, C3F0,00,BC08, C3E0,00,BC0A, C3F0,10,BC0C, C3E0,10,BC0E, C200,F0,7C08, C210,F0,7C0A, C200,E0,7C0C, C210,E0,7C0E, C3F0,F0,3C08, C3E0,F0,3C0A, C3F0,E0,3C0C, C3E0,E0,3C0E

; Bottom half - 1Ch: Facing left  - space jump - frame 1
; Bottom half - 82h: Facing left  - screw attack - frame 1
; Bottom half - 82h: Facing left  - screw attack - frame 11h
; Bottom half - 82h: Facing left  - screw attack - frame 9
; Bottom half - 84h: Facing left  - wall jump - frame 17h
; Bottom half - 84h: Facing left  - wall jump - frame 1Fh
; Bottom half - 84h: Facing left  - wall jump - frame 27h
; Bottom half - 84h: Facing left  - wall jump - frame Dh
$92:C330             dx 0004, C200,F0,2808, C3F0,00,280A, C3F8,00,280C, C3F8,F0,280E

; Bottom half - 1Ch: Facing left  - space jump - frame 2
; Bottom half - 82h: Facing left  - screw attack - frame 12h
; Bottom half - 82h: Facing left  - screw attack - frame 2
; Bottom half - 82h: Facing left  - screw attack - frame Ah
; Bottom half - 84h: Facing left  - wall jump - frame 18h
; Bottom half - 84h: Facing left  - wall jump - frame 20h
; Bottom half - 84h: Facing left  - wall jump - frame 28h
; Bottom half - 84h: Facing left  - wall jump - frame Eh
$92:C346             dx 000A, C201,04,2808, C3F1,F4,280A, 01F9,0C,280C, 01F1,EC,280D, 0001,EC,280E, 01F9,EC,280F, 0009,FC,281C, 0001,FC,281D, 0001,F4,281E, 01F9,04,281F

; Bottom half - 1Ch: Facing left  - space jump - frame 3
; Bottom half - 82h: Facing left  - screw attack - frame 13h
; Bottom half - 82h: Facing left  - screw attack - frame 3
; Bottom half - 82h: Facing left  - screw attack - frame Bh
; Bottom half - 84h: Facing left  - wall jump - frame 19h
; Bottom half - 84h: Facing left  - wall jump - frame 21h
; Bottom half - 84h: Facing left  - wall jump - frame 29h
; Bottom half - 84h: Facing left  - wall jump - frame Fh
$92:C37A             dx 0004, C200,00,2808, C3F0,F0,280A, C3F0,F8,280C, C200,F8,280E

; Bottom half - 1Ch: Facing left  - space jump - frame 4
; Bottom half - 82h: Facing left  - screw attack - frame 14h
; Bottom half - 82h: Facing left  - screw attack - frame 4
; Bottom half - 82h: Facing left  - screw attack - frame Ch
; Bottom half - 84h: Facing left  - wall jump - frame 10h
; Bottom half - 84h: Facing left  - wall jump - frame 1Ah
; Bottom half - 84h: Facing left  - wall jump - frame 22h
; Bottom half - 84h: Facing left  - wall jump - frame 2Ah
$92:C390             dx 000A, 01FC,F0,E80C, 01F4,F8,E80D, 01FC,F8,E80E, 0004,00,E80F, 000C,00,E81C, 01EC,F8,E81D, 01EC,00,E81E, 01EC,08,E81F, C3F4,00,E808, C204,F0,E80A

; Bottom half - 1Ch: Facing left  - space jump - frame 5
; Bottom half - 82h: Facing left  - screw attack - frame 15h
; Bottom half - 82h: Facing left  - screw attack - frame 5
; Bottom half - 82h: Facing left  - screw attack - frame Dh
; Bottom half - 84h: Facing left  - wall jump - frame 11h
; Bottom half - 84h: Facing left  - wall jump - frame 1Bh
; Bottom half - 84h: Facing left  - wall jump - frame 23h
; Bottom half - 84h: Facing left  - wall jump - frame 2Bh
$92:C3C4             dx 0004, C3F0,00,E808, C200,F0,E80A, C3F8,F0,E80C, C3F8,00,E80E

; Bottom half - 1Ch: Facing left  - space jump - frame 6
; Bottom half - 82h: Facing left  - screw attack - frame 16h
; Bottom half - 82h: Facing left  - screw attack - frame 6
; Bottom half - 82h: Facing left  - screw attack - frame Eh
; Bottom half - 84h: Facing left  - wall jump - frame 12h
; Bottom half - 84h: Facing left  - wall jump - frame 1Ch
; Bottom half - 84h: Facing left  - wall jump - frame 24h
; Bottom half - 84h: Facing left  - wall jump - frame 2Ch
$92:C3DA             dx 000A, 01F0,FC,E80C, 01F8,FC,E80D, 01F8,04,E80E, 0008,0C,E80F, 0000,EC,E81C, 0000,F4,E81D, 01F8,0C,E81E, 0000,0C,E81F, C3F0,EC,E808, C200,FC,E80A

; Bottom half - 1Ch: Facing left  - space jump - frame 7
; Bottom half - 82h: Facing left  - screw attack - frame 17h
; Bottom half - 82h: Facing left  - screw attack - frame 7
; Bottom half - 82h: Facing left  - screw attack - frame Fh
; Bottom half - 84h: Facing left  - wall jump - frame 13h
; Bottom half - 84h: Facing left  - wall jump - frame 1Dh
; Bottom half - 84h: Facing left  - wall jump - frame 25h
; Bottom half - 84h: Facing left  - wall jump - frame 2Dh
$92:C40E             dx 0004, C3F0,F0,E808, C200,00,E80A, C200,F8,E80C, C3F0,F8,E80E

; Bottom half - 1Ch: Facing left  - space jump - frame 8
; Bottom half - 82h: Facing left  - screw attack - frame 10h
; Bottom half - 82h: Facing left  - screw attack - frame 18h
; Bottom half - 82h: Facing left  - screw attack - frame 8
; Bottom half - 84h: Facing left  - wall jump - frame 14h
; Bottom half - 84h: Facing left  - wall jump - frame 1Eh
; Bottom half - 84h: Facing left  - wall jump - frame 26h
; Bottom half - 84h: Facing left  - wall jump - frame 2Eh
$92:C424             dx 000A, 01FC,00,280C, 01FC,08,280D, 0004,00,280E, 01F4,F8,280F, 01EC,F8,281C, 000C,00,281D, 000C,F8,281E, 000C,F0,281F, C3FC,F0,2808, C3EC,00,280A

; Bottom half - 1Bh: Facing right - space jump - frame 1
; Bottom half - 81h: Facing right - screw attack - frame 1
; Bottom half - 81h: Facing right - screw attack - frame 11h
; Bottom half - 81h: Facing right - screw attack - frame 9
; Bottom half - 83h: Facing right - wall jump - frame 17h
; Bottom half - 83h: Facing right - wall jump - frame 1Fh
; Bottom half - 83h: Facing right - wall jump - frame 27h
; Bottom half - 83h: Facing right - wall jump - frame Dh
$92:C458             dx 0004, C3F0,F0,6808, C200,00,680A, C3F8,00,680C, C3F8,F0,680E

; Bottom half - 1Bh: Facing right - space jump - frame 2
; Bottom half - 81h: Facing right - screw attack - frame 12h
; Bottom half - 81h: Facing right - screw attack - frame 2
; Bottom half - 81h: Facing right - screw attack - frame Ah
; Bottom half - 83h: Facing right - wall jump - frame 18h
; Bottom half - 83h: Facing right - wall jump - frame 20h
; Bottom half - 83h: Facing right - wall jump - frame 28h
; Bottom half - 83h: Facing right - wall jump - frame Eh
$92:C46E             dx 000A, C3EF,04,6808, C3FF,F4,680A, 01FF,0C,680C, 0007,EC,680D, 01F7,EC,680E, 01FF,EC,680F, 01EF,FC,681C, 01F7,FC,681D, 01F7,F4,681E, 01FF,04,681F

; Bottom half - 1Bh: Facing right - space jump - frame 3
; Bottom half - 81h: Facing right - screw attack - frame 13h
; Bottom half - 81h: Facing right - screw attack - frame 3
; Bottom half - 81h: Facing right - screw attack - frame Bh
; Bottom half - 83h: Facing right - wall jump - frame 19h
; Bottom half - 83h: Facing right - wall jump - frame 21h
; Bottom half - 83h: Facing right - wall jump - frame 29h
; Bottom half - 83h: Facing right - wall jump - frame Fh
$92:C4A2             dx 0004, C3F0,00,6808, C200,F0,680A, C200,F8,680C, C3F0,F8,680E

; Bottom half - 1Bh: Facing right - space jump - frame 4
; Bottom half - 81h: Facing right - screw attack - frame 14h
; Bottom half - 81h: Facing right - screw attack - frame 4
; Bottom half - 81h: Facing right - screw attack - frame Ch
; Bottom half - 83h: Facing right - wall jump - frame 10h
; Bottom half - 83h: Facing right - wall jump - frame 1Ah
; Bottom half - 83h: Facing right - wall jump - frame 22h
; Bottom half - 83h: Facing right - wall jump - frame 2Ah
$92:C4B8             dx 000A, 01FC,F0,A80C, 0004,F8,A80D, 01FC,F8,A80E, 01F4,00,A80F, 01EC,00,A81C, 000C,F8,A81D, 000C,00,A81E, 000C,08,A81F, C3FC,00,A808, C3EC,F0,A80A

; Bottom half - 1Bh: Facing right - space jump - frame 5
; Bottom half - 81h: Facing right - screw attack - frame 15h
; Bottom half - 81h: Facing right - screw attack - frame 5
; Bottom half - 81h: Facing right - screw attack - frame Dh
; Bottom half - 83h: Facing right - wall jump - frame 11h
; Bottom half - 83h: Facing right - wall jump - frame 1Bh
; Bottom half - 83h: Facing right - wall jump - frame 23h
; Bottom half - 83h: Facing right - wall jump - frame 2Bh
$92:C4EC             dx 0004, C200,00,A808, C3F0,F0,A80A, C3F8,F0,A80C, C3F8,00,A80E

; Bottom half - 1Bh: Facing right - space jump - frame 6
; Bottom half - 81h: Facing right - screw attack - frame 16h
; Bottom half - 81h: Facing right - screw attack - frame 6
; Bottom half - 81h: Facing right - screw attack - frame Eh
; Bottom half - 83h: Facing right - wall jump - frame 12h
; Bottom half - 83h: Facing right - wall jump - frame 1Ch
; Bottom half - 83h: Facing right - wall jump - frame 24h
; Bottom half - 83h: Facing right - wall jump - frame 2Ch
$92:C502             dx 000A, 0008,FC,A80C, 0000,FC,A80D, 0000,04,A80E, 01F0,0C,A80F, 01F8,EC,A81C, 01F8,F4,A81D, 0000,0C,A81E, 01F8,0C,A81F, C200,EC,A808, C3F0,FC,A80A

; Bottom half - 1Bh: Facing right - space jump - frame 7
; Bottom half - 81h: Facing right - screw attack - frame 17h
; Bottom half - 81h: Facing right - screw attack - frame 7
; Bottom half - 81h: Facing right - screw attack - frame Fh
; Bottom half - 83h: Facing right - wall jump - frame 13h
; Bottom half - 83h: Facing right - wall jump - frame 1Dh
; Bottom half - 83h: Facing right - wall jump - frame 25h
; Bottom half - 83h: Facing right - wall jump - frame 2Dh
$92:C536             dx 0004, C200,F0,A808, C3F0,00,A80A, C3F0,F8,A80C, C200,F8,A80E

; Bottom half - 1Bh: Facing right - space jump - frame 8
; Bottom half - 81h: Facing right - screw attack - frame 10h
; Bottom half - 81h: Facing right - screw attack - frame 18h
; Bottom half - 81h: Facing right - screw attack - frame 8
; Bottom half - 83h: Facing right - wall jump - frame 14h
; Bottom half - 83h: Facing right - wall jump - frame 1Eh
; Bottom half - 83h: Facing right - wall jump - frame 26h
; Bottom half - 83h: Facing right - wall jump - frame 2Eh
$92:C54C             dx 000A, 01FC,00,680C, 01FC,08,680D, 01F4,00,680E, 0004,F8,680F, 000C,F8,681C, 01EC,00,681D, 01EC,F8,681E, 01EC,F0,681F, C3F4,F0,6808, C204,00,680A

; Samus suit exploding - facing left - frame 0
$92:C580             dx 0009, 0000,10,2841, 01F8,10,2840, 0008,10,2842, 0008,08,2832, 0008,00,2822, 0008,F8,2812, 0008,F0,2802, C3F8,00,2820, C3F8,F0,2800

; Samus suit exploding - facing left - frame 1
$92:C5AF             dx 0016, 01FD,F0,281F, 0003,F6,280F, 01FB,F9,280F, 01F7,F7,285F, 0007,0B,284E, 01FF,0F,285F, 01F7,F2,287F, 01F9,EF,286C, 01F9,EC,282F, 01FD,E9,281F, 0006,F2,2808, 01F9,05,2858, 0002,FD,2838, 0001,06,284B, 01F8,0A,2E43, 01F8,02,2E33, 01F8,FA,2E23, 01F8,F2,2E13, 01F8,EA,2E03, C200,0A,2E44, C200,FA,2E24, C200,EA,2E04

; Samus suit exploding - facing left - frame 2
$92:C61F             dx 001A, 0003,E7,281F, 0001,11,284F, 01FF,0A,284E, 01F9,07,2883, 0000,04,2883, 0006,F0,2883, 000C,EB,2808, 0007,07,6858, 01F7,FF,284B, 01F3,F6,2838, 01F3,EE,287F, 01F6,E9,286C, 01FB,E7,282F, 01F8,F1,283F, 01F5,07,2893, 01F8,0E,2873, 0006,0F,2883, 0009,01,284F, 0008,F8,285F, 0008,10,2E68, 0000,10,2E67, 0008,F0,2E28, 0008,E8,2E18, C3F8,E0,2E06, C3F8,00,2E46, C3F8,F0,2E26

; Samus suit exploding - facing left - frame 3
$92:C6A3             dx 0018, 000B,DD,283F, 0001,17,284F, 01F7,E0,282F, 01F1,E1,286C, 000F,E6,281F, 01EE,FA,286F, 01ED,F2,284E, 01EE,07,2893, 01F1,10,2873, 000D,10,2883, 000C,02,286F, 0010,FB,284F, 000A,F1,285F, 01ED,E8,287F, 01F3,ED,283F, 0008,FA,2E3B, 0008,F2,2E2B, 0008,12,2E6B, 0000,12,2E6A, 0008,EA,2E1B, 0008,E2,2E0B, C3F8,02,2E49, C3F8,F2,2E29, C3F8,E2,2E09

; Samus suit exploding - facing left - frame 4
$92:C71D             dx 0019, 000C,D8,283F, 0003,1E,284F, 01F3,DA,282F, 01E9,DE,286C, 0011,15,2883, 0014,04,286F, 0015,F2,285F, 0012,E1,281F, 01E5,FE,286F, 01E3,EA,287F, 0018,FC,284F, 01F0,14,2873, 01E8,0C,2893, 01E8,F4,284E, 01F0,EC,283F, 0000,14,2E6D, 0008,14,2E6E, 0008,0C,2E5E, 0008,FC,2E3E, 0008,F4,2E2E, 0008,EC,2E1E, 0008,E4,2E0E, C3F8,04,2E4C, C3F8,F4,2E2C, C3F8,E4,2E0C

; Samus suit exploding - facing left - frame 5
$92:C79C             dx 0019, 01DD,E1,287F, 01E0,DC,287F, 0003,25,2873, 01EA,D3,282F, 001D,FB,2873, 01DF,FF,6883, 0019,08,286F, 01E2,12,2893, 01EF,19,2873, 0013,19,2883, 0018,F0,285F, 01D9,ED,287F, 01E4,F4,284E, 0018,DC,281F, 01E8,EC,683F, 0000,14,2E74, 0000,0C,2E64, 01F8,0C,2E63, 0008,FC,2E82, 0008,EC,2E62, 0008,E4,2E52, 0000,E4,2E51, 01F8,E4,2E50, C3F8,FC,2E80, C3F8,EC,2E60

; Samus suit exploding - facing left - frame 6
$92:C81B             dx 0008, 000E,F4,2E9C, 000E,EC,2E8C, 01FE,14,2E99, C3F6,04,2E78, 01F6,FC,2E94, 01F6,F4,2E84, C3FE,F4,2E85, C3FE,E4,2E65

; Samus suit exploding - facing left - frame 7
$92:C845             dx 000B, 01F6,F4,2E98, 0006,FC,2E96, 01FE,FC,2E95, 0006,E4,2E7B, 01FE,E4,2E7A, 000E,F4,2E9C, 000E,EC,2E8C, C3FE,EC,2E8A, 01FE,14,2E99, C3F6,04,2E78, 01F6,FC,2E94

; Samus suit exploding - facing left - frame 8
$92:C87E             dx 000B, 01FE,FC,2E95, 0006,FC,2E96, 01F6,F4,2E7C, 0006,E4,2E7E, 01FE,E4,2E7D, 000E,F4,2E9F, 000E,EC,2E8F, C3FE,EC,2E8D, 01FE,14,2E99, C3F6,04,2E78, 01F6,FC,2E94

; Samus suit exploding - facing right - frame 0
$92:C8B7             dx 0009, 01F8,10,6841, 0000,10,6840, 01F0,10,6842, 01F0,08,6832, 01F0,00,6822, 01F0,F8,6812, 01F0,F0,6802, C3F8,00,6820, C3F8,F0,6800

; Samus suit exploding - facing right - frame 1
$92:C8E6             dx 0016, 01FB,F0,681F, 01F5,F6,680F, 01FD,F9,680F, 0001,F7,685F, 01F1,0B,684E, 01F9,0F,685F, 0001,F2,687F, 01FF,EF,686C, 01FF,EC,682F, 01FB,E9,681F, 01F2,F2,6808, 01FF,05,6858, 01F6,FD,6838, 01F7,06,684B, 0000,0A,6E43, 0000,02,6E33, 0000,FA,6E23, 0000,F2,6E13, 0000,EA,6E03, C3F0,0A,6E44, C3F0,FA,6E24, C3F0,EA,6E04

; Samus suit exploding - facing right - frame 2
$92:C956             dx 001A, 01F5,E7,681F, 01F7,11,684F, 01F9,0A,684E, 01FF,07,6883, 01F8,04,6883, 01F2,F0,6883, 01EC,EB,6808, 01F1,07,2858, 0001,FF,684B, 0005,F6,6838, 0005,EE,687F, 0002,E9,686C, 01FD,E7,682F, 0000,F1,683F, 0003,07,6893, 0000,0E,6873, 01F2,0F,6883, 01EF,01,684F, 01F0,F8,685F, 01F0,10,6E68, 01F8,10,6E67, 01F0,F0,6E28, 01F0,E8,6E18, C3F8,E0,6E06, C3F8,00,6E46, C3F8,F0,6E26

; Samus suit exploding - facing right - frame 3
$92:C9DA             dx 0018, 01ED,DD,683F, 01F7,17,684F, 0001,E0,682F, 0007,E1,686C, 01E9,E6,681F, 000A,FA,686F, 000B,F2,684E, 000A,07,6893, 0007,10,6873, 01EB,10,6883, 01EC,02,686F, 01E8,FB,684F, 01EE,F1,685F, 000B,E8,687F, 0005,ED,683F, 01F0,FA,6E3B, 01F0,F2,6E2B, 01F0,12,6E6B, 01F8,12,6E6A, 01F0,EA,6E1B, 01F0,E2,6E0B, C3F8,02,6E49, C3F8,F2,6E29, C3F8,E2,6E09

; Samus suit exploding - facing right - frame 4
$92:CA54             dx 0019, 01EC,D8,683F, 01F5,1E,684F, 0005,DA,682F, 000F,DE,686C, 01E7,15,6883, 01E4,04,686F, 01E3,F2,685F, 01E6,E1,681F, 0013,FE,686F, 0015,EA,687F, 01E0,FC,684F, 0008,14,6873, 0010,0C,6893, 0010,F4,684E, 0008,EC,683F, 01F8,14,6E6D, 01F0,14,6E6E, 01F0,0C,6E5E, 01F0,FC,6E3E, 01F0,F4,6E2E, 01F0,EC,6E1E, 01F0,E4,6E0E, C3F8,04,6E4C, C3F8,F4,6E2C, C3F8,E4,6E0C

; Samus suit exploding - facing right - frame 5
$92:CAD3             dx 0019, 001B,E1,687F, 0018,DC,687F, 01F5,25,6873, 000E,D3,682F, 01DB,FB,6873, 0019,FF,2883, 01DF,08,686F, 0016,12,6893, 0009,19,6873, 01E5,19,6883, 01E0,F0,685F, 001F,ED,687F, 0014,F4,684E, 01E0,DC,681F, 0010,EC,283F, 01F8,14,6E74, 01F8,0C,6E64, 0000,0C,6E63, 01F0,FC,6E82, 01F0,EC,6E62, 01F0,E4,6E52, 01F8,E4,6E51, 0000,E4,6E50, C3F8,FC,6E80, C3F8,EC,6E60

; Samus suit exploding - facing right - frame 6
$92:CB52             dx 0008, 01EA,F4,6E9C, 01EA,EC,6E8C, 01FA,14,6E99, C3FA,04,6E78, 0002,FC,6E94, 0002,F4,6E84, C3F2,F4,6E85, C3F2,E4,6E65

; Samus suit exploding - facing right - frame 7
$92:CB7C             dx 000B, 0002,F4,6E98, 01F2,FC,6E96, 01FA,FC,6E95, 01F2,E4,6E7B, 01FA,E4,6E7A, 01EA,F4,6E9C, 01EA,EC,6E8C, C3F2,EC,6E8A, 01FA,14,6E99, C3FA,04,6E78, 0002,FC,6E94

; Samus suit exploding - facing right - frame 8
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


;;; $CBEE: Samus top tiles - set 0 (general) ;;;
{
; Actually used by:
;     9: Moving right - not aiming - frame 0
;     9: Moving right - not aiming - frame 5
;     4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 3
;     C7h: Facing right - vertical shinespark windup - frame 3
;     F0h: Facing right - grabbed by Draygon - moving - frame 2
;     F0h: Facing right - grabbed by Draygon - moving - frame 5

; Meaninglessly used by:
{
;     0: Facing forward - power suit - frame 1
;     1: Facing right - normal - frame 4
;     2: Facing left  - normal - frame 4
;     19h: Facing right - spin jump - frames 9..Ah
;     1Ah: Facing left  - spin jump - frames 9..Ah
;     1Bh: Facing right - space jump - frames 9..Ah
;     1Ch: Facing left  - space jump - frames 9..Ah
;     1Dh: Facing right - morph ball - no springball - on ground - frame 8
;     1Eh: Moving right - morph ball - no springball - on ground - frame 8
;     1Fh: Moving left  - morph ball - no springball - on ground - frame 8
;     20h: Unused - frames 9..Ah
;     21h: Unused - frames 9..Ah
;     22h: Unused - frames 9..Ah
;     23h: Unused - frames 9..Ah
;     24h: Unused - frames 9..Ah
;     27h: Facing right - crouching - frame 4
;     28h: Facing left  - crouching - frame 4
;     29h: Facing right - falling - frames 3..4
;     2Ah: Facing left  - falling - frames 3..4
;     31h: Facing right - morph ball - no springball - in air - frame 8
;     32h: Facing left  - morph ball - no springball - in air - frame 8
;     33h: Unused - frames 9..Ah
;     34h: Unused - frames 9..Ah
;     39h: Unused - frames 9..Ah
;     3Ah: Unused - frames 9..Ah
;     3Fh: Unused - frame 8
;     40h: Unused - frame 8
;     41h: Facing left  - morph ball - no springball - on ground - frame 8
;     42h: Unused - frames 9..Ah
;     47h: Unused - frame 4
;     48h: Unused - frame 4
;     67h: Facing right - falling - gun extended - frames 3..4
;     68h: Facing left  - falling - gun extended - frames 3..4
;     79h: Facing right - morph ball - spring ball - on ground - frame 8
;     7Ah: Facing left  - morph ball - spring ball - on ground - frame 8
;     7Bh: Moving right - morph ball - spring ball - on ground - frame 8
;     7Ch: Moving left  - morph ball - spring ball - on ground - frame 8
;     7Dh: Facing right - morph ball - spring ball - falling - frame 8
;     7Eh: Facing left  - morph ball - spring ball - falling - frame 8
;     7Fh: Facing right - morph ball - spring ball - in air - frame 8
;     80h: Facing left  - morph ball - spring ball - in air - frame 8
;     81h: Facing right - screw attack - frames 19h..1Ah
;     82h: Facing left  - screw attack - frames 19h..1Ah
;     83h: Facing right - wall jump - frame 2
;     83h: Facing right - wall jump - frames Bh..Ch
;     83h: Facing right - wall jump - frames 15h..16h
;     84h: Facing left  - wall jump - frame 2
;     84h: Facing left  - wall jump - frames Bh..Ch
;     84h: Facing left  - wall jump - frames 15h..16h
;     89h: Facing right - ran into a wall - frame 4
;     8Ah: Facing left  - ran into a wall - frame 4
;     9Bh: Facing forward - varia/gravity suit - frame 1
;     A8h: Facing right - grappling - frame 4
;     A9h: Facing left  - grappling - frame 4
;     B4h: Facing right - grappling - crouching - frame 4
;     B5h: Facing left  - grappling - crouching - frame 4
;     C5h: Unused - frame 8
;     D3h: Facing right - crystal flash - frames 4..5
;     D3h: Facing right - crystal flash - frames Ah..Bh
;     D4h: Facing left  - crystal flash - frames 4..5
;     D4h: Facing left  - crystal flash - frames Ah..Bh
;     DFh: Unused - frame 8
;     E8h: Facing right - Samus drained - crouching/falling - frames Ch..Dh
;     E9h: Facing left  - Samus drained - crouching/falling - frames Ch..Dh
;     E9h: Facing left  - Samus drained - crouching/falling - frames 11h..12h
;     E9h: Facing left  - Samus drained - crouching/falling - frames 18h..19h
;     E9h: Facing left  - Samus drained - crouching/falling - frames 1Bh..1Ch
;     E9h: Facing left  - Samus drained - crouching/falling - frames 1Eh..1Fh
;     EAh: Facing right - Samus drained - standing - frame 4
;     EBh: Facing left  - Samus drained - standing - frame 4
}
$92:CBEE             dx 9E8000, 0080, 0080

; 9: Moving right - not aiming - frame 4
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 4
; C7h: Facing right - vertical shinespark windup - frame 4
; F0h: Facing right - grabbed by Draygon - moving - frame 0
$92:CBF5             dx 9E8100, 0080, 0080

; 9: Moving right - not aiming - frame 2
; F0h: Facing right - grabbed by Draygon - moving - frame 1
$92:CBFC             dx 9E8200, 00A0, 0080

; 9: Moving right - not aiming - frame 3
$92:CC03             dx 9E8320, 00A0, 0080

; 9: Moving right - not aiming - frame 9
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 0
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 2
; C7h: Facing right - vertical shinespark windup - frame 0
; C7h: Facing right - vertical shinespark windup - frame 2
; F0h: Facing right - grabbed by Draygon - moving - frame 3
$92:CC0A             dx 9E8440, 0080, 0080

; 9: Moving right - not aiming - frame 7
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 1
; C7h: Facing right - vertical shinespark windup - frame 1
; F0h: Facing right - grabbed by Draygon - moving - frame 4
$92:CC11             dx 9E8540, 00C0, 00C0

; Ah: Moving left  - not aiming - frame 0
; Ah: Moving left  - not aiming - frame 5
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 3
; BEh: Facing left  - grabbed by Draygon - moving - frame 2
; BEh: Facing left  - grabbed by Draygon - moving - frame 5
; C8h: Facing left  - vertical shinespark windup - frame 3
$92:CC18             dx 9E86C0, 0080, 0080

; Ah: Moving left  - not aiming - frame 4
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 4
; BEh: Facing left  - grabbed by Draygon - moving - frame 0
; C8h: Facing left  - vertical shinespark windup - frame 4
$92:CC1F             dx 9E87C0, 0080, 0080

; Ah: Moving left  - not aiming - frame 2
; BEh: Facing left  - grabbed by Draygon - moving - frame 1
$92:CC26             dx 9E88C0, 00C0, 00C0

; Ah: Moving left  - not aiming - frame 3
$92:CC2D             dx 9E8A40, 00C0, 00C0

; Ah: Moving left  - not aiming - frame 9
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 0
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 2
; BEh: Facing left  - grabbed by Draygon - moving - frame 3
; C8h: Facing left  - vertical shinespark windup - frame 0
; C8h: Facing left  - vertical shinespark windup - frame 2
$92:CC34             dx 9E8BC0, 0080, 0080

; Ah: Moving left  - not aiming - frame 7
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 1
; BEh: Facing left  - grabbed by Draygon - moving - frame 4
; C8h: Facing left  - vertical shinespark windup - frame 1
$92:CC3B             dx 9E8CC0, 00A0, 0080

; 11h: Moving right - aiming down-right - frames 0..1
; 11h: Moving right - aiming down-right - frames 5..6
; 17h: Facing right - normal jump - aiming down - frame 0
; 2Dh: Facing right - falling - aiming down - frame 0
; 6Bh: Facing right - normal jump - aiming down-right - frames 0..1
; 6Fh: Facing right - falling - aiming down-right - frames 0..2
; 78h: Facing right - moonwalk - aiming down-right - frame 0
; 78h: Facing right - moonwalk - aiming down-right - frame 3
; AEh: Unused. Facing right - grappling - in air - aiming down - frame 0
; B0h: Unused. Facing right - grappling - in air - aiming down-right - frames 0..1
; EFh: Facing right - grabbed by Draygon - not moving - aiming down-right - frame 0
$92:CC42             dx 9E8DE0, 00E0, 0040

; 12h: Moving left  - aiming down-left - frames 0..1
; 12h: Moving left  - aiming down-left - frames 5..6
; 18h: Facing left  - normal jump - aiming down - frame 0
; 2Eh: Facing left  - falling - aiming down - frame 0
; 6Ch: Facing left  - normal jump - aiming down-left - frames 0..1
; 70h: Facing left  - falling - aiming down-left - frames 0..2
; 77h: Facing left  - moonwalk - aiming down-left - frame 0
; 77h: Facing left  - moonwalk - aiming down-left - frame 3
; AFh: Unused. Facing left  - grappling - in air - aiming down - frame 0
; B1h: Unused. Facing left  - grappling - in air - aiming down-left - frames 0..1
; BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left - frame 0
$92:CC49             dx 9E8F00, 00E0, 0040

; 7: Facing right - aiming down-right - frame 0
; 59h: Facing right - normal jump transition - aiming down-right - frame 0
; 73h: Facing right - crouching - aiming down-right - frame 0
; AAh: Facing right - grappling - aiming down-right - frame 0
; B6h: Facing right - grappling - crouching - aiming down-right - frame 0
; D1h: Facing right - ran into a wall - aiming down-right - frame 0
; E4h: Facing right - landing from normal jump - aiming down-right - frames 0..1
; F5h: Facing right - crouching transition - aiming down-right - frame 0
; FBh: Facing right - standing transition - aiming down-right - frame 0
$92:CC50             dx 9E9020, 00E0, 0080

; 8: Facing left  - aiming down-left - frame 0
; 5Ah: Facing left  - normal jump transition - aiming down-left - frame 0
; 74h: Facing left  - crouching - aiming down-left - frame 0
; ABh: Facing left  - grappling - aiming down-left - frame 0
; B7h: Facing left  - grappling - crouching - aiming down-left - frame 0
; D2h: Facing left  - ran into a wall - aiming down-left - frame 0
; E5h: Facing left  - landing from normal jump - aiming down-left - frames 0..1
; F6h: Facing left  - crouching transition - aiming down-left - frame 0
; FCh: Facing left  - standing transition - aiming down-left - frame 0
$92:CC57             dx 9E9180, 00E0, 0080

; 13h: Facing right - normal jump - not aiming - not moving - gun extended - frames 0..1
; 35h: Facing right - crouching transition - frame 0
; 3Bh: Facing right - standing transition - frame 0
; 4Ah: Facing right - moonwalk - frame 0
; 4Ah: Facing right - moonwalk - frame 3
; 51h: Facing right - normal jump - not aiming - moving forward - frames 0..1
; 67h: Facing right - falling - gun extended - frames 0..2
; 67h: Facing right - falling - gun extended - frames 5..6
; ACh: Unused. Facing right - grappling - in air - frames 0..1
; D3h: Facing right - crystal flash - frame Eh
; D5h: Facing right - x-ray - standing - frame 2
; D7h: Facing right - crystal flash ending - frame 3
; D9h: Facing right - x-ray - crouching - frame 2
; DBh: Unused - frame 0
; DDh: Unused - frame 2
; E6h: Facing right - landing from normal jump - firing - frames 0..1
; E8h: Facing right - Samus drained - crouching/falling - frame Eh
; EAh: Facing right - Samus drained - standing - frame 5
; EEh: Facing right - grabbed by Draygon - firing - frame 0
$92:CC5E             dx 9E92E0, 00C0, 0040

; 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frames 0..1
; 36h: Facing left  - crouching transition - frame 0
; 3Ch: Facing left  - standing transition - frame 0
; 49h: Facing left  - moonwalk - frame 0
; 49h: Facing left  - moonwalk - frame 3
; 52h: Facing left  - normal jump - not aiming - moving forward - frames 0..1
; 68h: Facing left  - falling - gun extended - frames 0..2
; 68h: Facing left  - falling - gun extended - frames 5..6
; ADh: Unused. Facing left  - grappling - in air - frames 0..1
; BCh: Facing left  - grabbed by Draygon - firing - frame 0
; D4h: Facing left  - crystal flash - frame Eh
; D6h: Facing left  - x-ray - standing - frame 2
; D8h: Facing left  - crystal flash ending - frame 3
; DAh: Facing left  - x-ray - crouching - frame 2
; DCh: Unused - frame 0
; DEh: Unused - frame 2
; E7h: Facing left  - landing from normal jump - firing - frames 0..1
; EBh: Facing left  - Samus drained - standing - frame 5
$92:CC65             dx 9E93E0, 00C0, 0040

; 3: Facing right - aiming up - frame 0
; 5: Facing right - aiming up-right - frame 0
; 15h: Facing right - normal jump - aiming up - frame 0
; 2Bh: Facing right - falling - aiming up - frame 0
; 57h: Facing right - normal jump transition - aiming up-right - frame 0
; 71h: Facing right - crouching - aiming up-right - frame 0
; 85h: Facing right - crouching - aiming up - frame 0
; CFh: Facing right - ran into a wall - aiming up-right - frame 0
; E2h: Facing right - landing from normal jump - aiming up-right - frames 0..1
; F3h: Facing right - crouching transition - aiming up-right - frame 0
; F9h: Facing right - standing transition - aiming up-right - frame 0
$92:CC6C             dx 9E94E0, 00C0, 0080

; 4: Facing left  - aiming up - frame 0
; 6: Facing left  - aiming up-left - frame 0
; 16h: Facing left  - normal jump - aiming up - frame 0
; 2Ch: Facing left  - falling - aiming up - frame 0
; 58h: Facing left  - normal jump transition - aiming up-left - frame 0
; 72h: Facing left  - crouching - aiming up-left - frame 0
; 86h: Facing left  - crouching - aiming up - frame 0
; D0h: Facing left  - ran into a wall - aiming up-left - frame 0
; E3h: Facing left  - landing from normal jump - aiming up-left - frames 0..1
; F4h: Facing left  - crouching transition - aiming up-left - frame 0
; FAh: Facing left  - standing transition - aiming up-left - frame 0
$92:CC73             dx 9E9620, 00C0, 0080

; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 5
; C7h: Facing right - vertical shinespark windup - frame 5
$92:CC7A             dx 9E9760, 00A0, 0080

; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 5
; C8h: Facing left  - vertical shinespark windup - frame 5
$92:CC81             dx 9E9880, 00C0, 00C0

; 3: Facing right - aiming up - frame 1
; Dh: Moving right - aiming up (unused) - frames 0..1
; Dh: Moving right - aiming up (unused) - frames 5..6
; 15h: Facing right - normal jump - aiming up - frame 1
; 2Bh: Facing right - falling - aiming up - frames 1..2
; 55h: Facing right - normal jump transition - aiming up - frame 0
; 85h: Facing right - crouching - aiming up - frame 1
; E0h: Facing right - landing from normal jump - aiming up - frames 0..1
; F1h: Facing right - crouching transition - aiming up - frame 0
; F7h: Facing right - standing transition - aiming up - frame 0
$92:CC88             dx 9E9A00, 00C0, 0040

; 4: Facing left  - aiming up - frame 1
; Eh: Moving left  - aiming up (unused) - frames 0..1
; Eh: Moving left  - aiming up (unused) - frames 5..6
; 16h: Facing left  - normal jump - aiming up - frame 1
; 2Ch: Facing left  - falling - aiming up - frames 1..2
; 56h: Facing left  - normal jump transition - aiming up - frame 0
; 86h: Facing left  - crouching - aiming up - frame 1
; E1h: Facing left  - landing from normal jump - aiming up - frames 0..1
; F2h: Facing left  - crouching transition - aiming up - frame 0
; F8h: Facing left  - standing transition - aiming up - frame 0
$92:CC8F             dx 9E9B00, 00C0, 0040

; 9: Moving right - not aiming - frame 8
$92:CC96             dx 9E9C00, 00A0, 0080

; Ah: Moving left  - not aiming - frame 8
$92:CC9D             dx 9E9D20, 00A0, 0080

; Fh: Moving right - aiming up-right - frames 0..1
; Fh: Moving right - aiming up-right - frames 5..6
; 69h: Facing right - normal jump - aiming up-right - frames 0..1
; 6Dh: Facing right - falling - aiming up-right - frames 0..2
; 76h: Facing right - moonwalk - aiming up-right - frame 0
; 76h: Facing right - moonwalk - aiming up-right - frame 3
; EDh: Facing right - grabbed by Draygon - not moving - aiming up-right - frame 0
$92:CCA4             dx 9E9E40, 00C0, 0040

; 10h: Moving left  - aiming up-left - frames 0..1
; 10h: Moving left  - aiming up-left - frames 5..6
; 6Ah: Facing left  - normal jump - aiming up-left - frames 0..1
; 6Eh: Facing left  - falling - aiming up-left - frames 0..2
; 75h: Facing left  - moonwalk - aiming up-left - frame 0
; 75h: Facing left  - moonwalk - aiming up-left - frame 3
; BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left - frame 0
$92:CCAB             dx 9E9F40, 00E0, 0040

; 54h: Facing left  - knockback - frames 0..1
; D8h: Facing left  - crystal flash ending - frames 4..5
; E9h: Facing left  - Samus drained - crouching/falling - frames 2..6
$92:CCB2             dx 9EA060, 0100, 00C0

; 53h: Facing right - knockback - frames 0..1
; D7h: Facing right - crystal flash ending - frames 4..5
; E8h: Facing right - Samus drained - crouching/falling - frames 3..7
$92:CCB9             dx 9EA220, 0100, 00C0

; Unused
$92:CCC0             dx 9EA3E0, 0100, 0040

; Unused
$92:CCC7             dx 9EA520, 0100, 0040
}


;;; $CCCE: Samus top tiles - set 1 (general) ;;;
{
; Unused
$92:CCCE             dx 9EA660, 00C0, 0080

; Unused
$92:CCD5             dx 9EA7A0, 00C0, 0080

; 8Bh: Facing right - turning - standing - aiming up - frame 1
; 8Ch: Facing left  - turning - standing - aiming up - frame 1
; 8Fh: Facing right - turning - in air - aiming up - frame 1
; 90h: Facing left  - turning - in air - aiming up - frame 1
; 93h: Facing right - turning - falling - aiming up - frame 1
; 94h: Facing left  - turning - falling - aiming up - frame 1
; 97h: Facing right - turning - crouching - aiming up - frame 1
; 98h: Facing left  - turning - crouching - aiming up - frame 1
; 9Ch: Facing right - turning - standing - aiming up-right - frame 1
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 1
; 9Eh: Facing right - turning - in air - aiming up-right - frame 1
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 1
; A0h: Facing right - turning - falling - aiming up-right - frame 1
; A1h: Facing left  - turning - falling - aiming up-left - frame 1
; A2h: Facing right - turning - crouching - aiming up-right - frame 1
; A3h: Facing left  - turning - crouching - aiming up-left - frame 1
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 1
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 1
$92:CCDC             dx 9EA8E0, 00E0, 00C0

; 8Dh: Facing right - turning - standing - aiming down-right - frame 1
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 1
; 91h: Facing right - turning - in air - aiming down/down-right - frame 1
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 1
; 95h: Facing right - turning - falling - aiming down/down-right - frame 1
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 1
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 1
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 1
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 1
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 1
$92:CCE3             dx 9EAA80, 0100, 00C0

; Unused
$92:CCEA             dx 9EAC40, 0020, 0000

; 9Bh: Facing forward - varia/gravity suit - frame 0
$92:CCF1             dx 9EAC60, 0040, 0040

; 25h: Facing right - turning - standing - frame 2
; 26h: Facing left  - turning - standing - frame 0
; 2Fh: Facing right - turning - jumping - frame 2
; 30h: Facing left  - turning - jumping - frame 0
; 43h: Facing right - turning - crouching - frame 2
; 44h: Facing left  - turning - crouching - frame 0
; 87h: Facing right - turning - falling - frame 2
; 88h: Facing left  - turning - falling - frame 0
; BFh: Facing right - moonwalking - turn/jump left - frame 2
; C0h: Facing left  - moonwalking - turn/jump right - frame 0
; C6h: Unused - frame 2
$92:CCF8             dx 9EACE0, 00C0, 0080

; 25h: Facing right - turning - standing - frame 0
; 26h: Facing left  - turning - standing - frame 2
; 2Fh: Facing right - turning - jumping - frame 0
; 30h: Facing left  - turning - jumping - frame 2
; 43h: Facing right - turning - crouching - frame 0
; 44h: Facing left  - turning - crouching - frame 2
; 87h: Facing right - turning - falling - frame 0
; 88h: Facing left  - turning - falling - frame 2
; BFh: Facing right - moonwalking - turn/jump left - frame 0
; C0h: Facing left  - moonwalking - turn/jump right - frame 2
; C6h: Unused - frame 0
$92:CCFF             dx 9EAE20, 00C0, 0080

; 8Bh: Facing right - turning - standing - aiming up - frame 2
; 8Ch: Facing left  - turning - standing - aiming up - frame 0
; 8Fh: Facing right - turning - in air - aiming up - frame 2
; 90h: Facing left  - turning - in air - aiming up - frame 0
; 93h: Facing right - turning - falling - aiming up - frame 2
; 94h: Facing left  - turning - falling - aiming up - frame 0
; 97h: Facing right - turning - crouching - aiming up - frame 2
; 98h: Facing left  - turning - crouching - aiming up - frame 0
; 9Ch: Facing right - turning - standing - aiming up-right - frame 2
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 0
; 9Eh: Facing right - turning - in air - aiming up-right - frame 2
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 0
; A0h: Facing right - turning - falling - aiming up-right - frame 2
; A1h: Facing left  - turning - falling - aiming up-left - frame 0
; A2h: Facing right - turning - crouching - aiming up-right - frame 2
; A3h: Facing left  - turning - crouching - aiming up-left - frame 0
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 2
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 0
$92:CD06             dx 9EAF60, 00E0, 0040

; 8Bh: Facing right - turning - standing - aiming up - frame 0
; 8Ch: Facing left  - turning - standing - aiming up - frame 2
; 8Fh: Facing right - turning - in air - aiming up - frame 0
; 90h: Facing left  - turning - in air - aiming up - frame 2
; 93h: Facing right - turning - falling - aiming up - frame 0
; 94h: Facing left  - turning - falling - aiming up - frame 2
; 97h: Facing right - turning - crouching - aiming up - frame 0
; 98h: Facing left  - turning - crouching - aiming up - frame 2
; 9Ch: Facing right - turning - standing - aiming up-right - frame 0
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 2
; 9Eh: Facing right - turning - in air - aiming up-right - frame 0
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 2
; A0h: Facing right - turning - falling - aiming up-right - frame 0
; A1h: Facing left  - turning - falling - aiming up-left - frame 2
; A2h: Facing right - turning - crouching - aiming up-right - frame 0
; A3h: Facing left  - turning - crouching - aiming up-left - frame 2
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 0
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 2
$92:CD0D             dx 9EB080, 00C0, 0040

; 25h: Facing right - turning - standing - frame 1
; 26h: Facing left  - turning - standing - frame 1
; 2Fh: Facing right - turning - jumping - frame 1
; 30h: Facing left  - turning - jumping - frame 1
; 43h: Facing right - turning - crouching - frame 1
; 44h: Facing left  - turning - crouching - frame 1
; 87h: Facing right - turning - falling - frame 1
; 88h: Facing left  - turning - falling - frame 1
; BFh: Facing right - moonwalking - turn/jump left - frame 1
; C0h: Facing left  - moonwalking - turn/jump right - frame 1
; C6h: Unused - frame 1
$92:CD14             dx 9EB180, 00E0, 00C0

; 5Ch: Unused - frame 0
; 64h: Unused. Related to movement type Dh - frame 1
; B9h: Facing right - grapple wall jump pose - frame 0
$92:CD1B             dx 9EB320, 0100, 0080

; 45h: Unused - frame 0
; 46h: Unused - frame 0
; 5Bh: Unused - frame 0
; 63h: Unused. Related to movement type Dh - frame 1
; B8h: Facing left  - grapple wall jump pose - frame 0
$92:CD22             dx 9EB4A0, 0100, 0080

; 9: Moving right - not aiming - frame 1
$92:CD29             dx 9EB620, 0080, 0080

; 9: Moving right - not aiming - frame 6
$92:CD30             dx 9EB720, 0080, 0080

; Ah: Moving left  - not aiming - frame 1
$92:CD37             dx 9EB820, 0080, 0080

; Ah: Moving left  - not aiming - frame 6
$92:CD3E             dx 9EB920, 0080, 0080

; 0: Facing forward - power suit - frame 0
$92:CD45             dx 9EBA20, 0080, 0080

; 65h: Unused. Related to movement type Dh - frame 0
; 83h: Facing right - wall jump - frame 0
$92:CD4C             dx 9EBB20, 0080, 0080

; 66h: Unused. Related to movement type Dh - frame 0
; 84h: Facing left  - wall jump - frame 0
$92:CD53             dx 9EBC20, 0080, 0080

; 63h: Unused. Related to movement type Dh - frame 0
; C9h: Facing right - shinespark - horizontal - frame 0
; CDh: Facing right - shinespark - diagonal - frame 0
$92:CD5A             dx 9EBD20, 0100, 00C0

; 64h: Unused. Related to movement type Dh - frame 0
; CAh: Facing left  - shinespark - horizontal - frame 0
; CEh: Facing left  - shinespark - diagonal - frame 0
$92:CD61             dx 9EBEE0, 0100, 00C0

; Unused
$92:CD68             dx 9EC0A0, 0020, 0000

; Unused
$92:CD6F             dx 9EC0C0, 0020, 0000

; 8Dh: Facing right - turning - standing - aiming down-right - frame 2
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 0
; 91h: Facing right - turning - in air - aiming down/down-right - frame 2
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 0
; 95h: Facing right - turning - falling - aiming down/down-right - frame 2
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 0
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 2
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 0
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 2
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 0
$92:CD76             dx 9EC0E0, 00E0, 0040

; 8Dh: Facing right - turning - standing - aiming down-right - frame 0
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 2
; 91h: Facing right - turning - in air - aiming down/down-right - frame 0
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 2
; 95h: Facing right - turning - falling - aiming down/down-right - frame 0
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 2
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 0
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 2
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 0
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 2
$92:CD7D             dx 9EC200, 00E0, 0040

; 17h: Facing right - normal jump - aiming down - frame 1
; 2Dh: Facing right - falling - aiming down - frame 1
; AEh: Unused. Facing right - grappling - in air - aiming down - frame 1
$92:CD84             dx 9EC320, 00C0, 0080

; 18h: Facing left  - normal jump - aiming down - frame 1
; 2Eh: Facing left  - falling - aiming down - frame 1
; AFh: Unused. Facing left  - grappling - in air - aiming down - frame 1
$92:CD8B             dx 9EC460, 00C0, 0080

; 19h: Facing right - spin jump - frame Bh
; 1Bh: Facing right - space jump - frame Bh
; 20h: Unused - frame Bh
; 21h: Unused - frame Bh
; 22h: Unused - frame Bh
; 23h: Unused - frame Bh
; 24h: Unused - frame Bh
; 33h: Unused - frame Bh
; 34h: Unused - frame Bh
; 39h: Unused - frame Bh
; 3Ah: Unused - frame Bh
; 42h: Unused - frame Bh
; 81h: Facing right - screw attack - frame 1Bh
$92:CD92             dx 9EC5A0, 00C0, 0080

; 1Ah: Facing left  - spin jump - frame Bh
; 1Ch: Facing left  - space jump - frame Bh
; 82h: Facing left  - screw attack - frame 1Bh
$92:CD99             dx 9EC6E0, 00C0, 0080
}


;;; $CDA0: Samus top tiles - set 2 (general) ;;;
{
; 4Bh: Facing right - normal jump transition - frame 0
; A4h: Facing right - landing from normal jump - frame 0
; A6h: Facing right - landing from spin jump - frame 1
$92:CDA0             dx 9EC820, 0080, 0040

; 4Ch: Facing left  - normal jump transition - frame 0
; A5h: Facing left  - landing from normal jump - frame 0
; A7h: Facing left  - landing from spin jump - frame 1
$92:CDA7             dx 9EC8E0, 0080, 0080

; Unused
$92:CDAE             dx 9EC9E0, 00C0, 0080

; E9h: Facing left  - Samus drained - crouching/falling - frame 10h
; E9h: Facing left  - Samus drained - crouching/falling - frame 15h
$92:CDB5             dx 9ECB20, 0080, 0080

; 19h: Facing right - spin jump - frame 0
; 1Bh: Facing right - space jump - frame 0
; 20h: Unused - frame 0
; 21h: Unused - frame 0
; 22h: Unused - frame 0
; 23h: Unused - frame 0
; 24h: Unused - frame 0
; 29h: Facing right - falling - frame 0
; 29h: Facing right - falling - frame 6
; 33h: Unused - frame 0
; 34h: Unused - frame 0
; 39h: Unused - frame 0
; 3Ah: Unused - frame 0
; 42h: Unused - frame 0
; 50h: Facing right - damage boost - frames 0..1
; 81h: Facing right - screw attack - frame 0
; 83h: Facing right - wall jump - frame 1
; A4h: Facing right - landing from normal jump - frame 1
; A6h: Facing right - landing from spin jump - frame 0
; A6h: Facing right - landing from spin jump - frame 2
; ECh: Facing right - grabbed by Draygon - not moving - not aiming - frame 0
$92:CDBC             dx 9ECC20, 0080, 0040

; 1Ah: Facing left  - spin jump - frame 0
; 1Ch: Facing left  - space jump - frame 0
; 2Ah: Facing left  - falling - frame 0
; 2Ah: Facing left  - falling - frame 6
; 4Fh: Facing left  - damage boost - frames 0..1
; 82h: Facing left  - screw attack - frame 0
; 84h: Facing left  - wall jump - frame 1
; A5h: Facing left  - landing from normal jump - frame 1
; A7h: Facing left  - landing from spin jump - frame 0
; A7h: Facing left  - landing from spin jump - frame 2
; BAh: Facing left  - grabbed by Draygon - not moving - not aiming - frame 0
$92:CDC3             dx 9ECCE0, 0080, 0080

; 11h: Moving right - aiming down-right - frame 2
; 11h: Moving right - aiming down-right - frame 4
; 11h: Moving right - aiming down-right - frame 7
; 11h: Moving right - aiming down-right - frame 9
; 78h: Facing right - moonwalk - aiming down-right - frames 1..2
; 78h: Facing right - moonwalk - aiming down-right - frames 4..5
$92:CDCA             dx 9ECDE0, 00E0, 0040

; 12h: Moving left  - aiming down-left - frame 2
; 12h: Moving left  - aiming down-left - frame 4
; 12h: Moving left  - aiming down-left - frame 7
; 12h: Moving left  - aiming down-left - frame 9
; 77h: Facing left  - moonwalk - aiming down-left - frames 1..2
; 77h: Facing left  - moonwalk - aiming down-left - frames 4..5
$92:CDD1             dx 9ECF00, 00E0, 0040

; D5h: Facing right - x-ray - standing - frame 1
; D9h: Facing right - x-ray - crouching - frame 1
$92:CDD8             dx 9ED020, 00C0, 0040

; D5h: Facing right - x-ray - standing - frame 0
; D9h: Facing right - x-ray - crouching - frame 0
$92:CDDF             dx 9ED120, 00C0, 0040

; D5h: Facing right - x-ray - standing - frame 3
; D9h: Facing right - x-ray - crouching - frame 3
$92:CDE6             dx 9ED220, 00C0, 0040

; D5h: Facing right - x-ray - standing - frame 4
; D9h: Facing right - x-ray - crouching - frame 4
$92:CDED             dx 9ED320, 00C0, 0040

; D6h: Facing left  - x-ray - standing - frame 1
; DAh: Facing left  - x-ray - crouching - frame 1
$92:CDF4             dx 9ED420, 00C0, 0040

; D6h: Facing left  - x-ray - standing - frame 0
; DAh: Facing left  - x-ray - crouching - frame 0
$92:CDFB             dx 9ED520, 00C0, 0040

; Dh: Moving right - aiming up (unused) - frame 2
; Dh: Moving right - aiming up (unused) - frame 4
; Dh: Moving right - aiming up (unused) - frame 7
; Dh: Moving right - aiming up (unused) - frame 9
; D6h: Facing left  - x-ray - standing - frame 3
; DAh: Facing left  - x-ray - crouching - frame 3
$92:CE02             dx 9ED620, 00C0, 0040

; Eh: Moving left  - aiming up (unused) - frame 2
; Eh: Moving left  - aiming up (unused) - frame 4
; Eh: Moving left  - aiming up (unused) - frame 7
; Eh: Moving left  - aiming up (unused) - frame 9
; D6h: Facing left  - x-ray - standing - frame 4
; DAh: Facing left  - x-ray - crouching - frame 4
$92:CE09             dx 9ED720, 00C0, 0040

; Fh: Moving right - aiming up-right - frame 2
; Fh: Moving right - aiming up-right - frame 4
; Fh: Moving right - aiming up-right - frame 7
; Fh: Moving right - aiming up-right - frame 9
; 76h: Facing right - moonwalk - aiming up-right - frames 1..2
; 76h: Facing right - moonwalk - aiming up-right - frames 4..5
$92:CE10             dx 9ED820, 00C0, 0040

; 10h: Moving left  - aiming up-left - frame 2
; 10h: Moving left  - aiming up-left - frame 4
; 10h: Moving left  - aiming up-left - frame 7
; 10h: Moving left  - aiming up-left - frame 9
; 75h: Facing left  - moonwalk - aiming up-left - frames 1..2
; 75h: Facing left  - moonwalk - aiming up-left - frames 4..5
$92:CE17             dx 9ED920, 00E0, 0040

; Unused
$92:CE1E             dx 9EDA40, 0100, 0040

; Unused
$92:CE25             dx 9EDB80, 0100, 0040

; Unused
$92:CE2C             dx 9EDCC0, 0100, 0040

; Unused
$92:CE33             dx 9EDE00, 0100, 0040

; Fh: Moving right - aiming up-right - frame 3
; Fh: Moving right - aiming up-right - frame 8
$92:CE3A             dx 9EDF40, 00C0, 0040

; 10h: Moving left  - aiming up-left - frame 3
; 10h: Moving left  - aiming up-left - frame 8
$92:CE41             dx 9EE040, 00E0, 0040

; 11h: Moving right - aiming down-right - frame 3
; 11h: Moving right - aiming down-right - frame 8
$92:CE48             dx 9EE160, 00E0, 0040

; 12h: Moving left  - aiming down-left - frame 3
; 12h: Moving left  - aiming down-left - frame 8
$92:CE4F             dx 9EE280, 00E0, 0040

; 4Ah: Facing right - moonwalk - frames 1..2
; 4Ah: Facing right - moonwalk - frames 4..5
$92:CE56             dx 9EE3A0, 00C0, 0040

; 49h: Facing left  - moonwalk - frames 1..2
; 49h: Facing left  - moonwalk - frames 4..5
$92:CE5D             dx 9EE4A0, 00C0, 0040

; 29h: Facing right - falling - frame 1
; 29h: Facing right - falling - frame 5
$92:CE64             dx 9EE5A0, 00E0, 0040

; 29h: Facing right - falling - frame 2
; 50h: Facing right - damage boost - frame 9
$92:CE6B             dx 9EE6C0, 00C0, 0040

; Dh: Moving right - aiming up (unused) - frame 3
; Dh: Moving right - aiming up (unused) - frame 8
; 2Ah: Facing left  - falling - frame 1
; 2Ah: Facing left  - falling - frame 5
$92:CE72             dx 9EE7C0, 00C0, 0040

; Eh: Moving left  - aiming up (unused) - frame 3
; Eh: Moving left  - aiming up (unused) - frame 8
; 2Ah: Facing left  - falling - frame 2
; 4Fh: Facing left  - damage boost - frame 9
$92:CE79             dx 9EE8C0, 00C0, 0040
}


;;; $CE80: Samus top tiles - set 3 (facing clockwise - grappling - in air - upside up) ;;;
{
; 5Dh: Unused - frame 18h
; 5Dh: Unused - frame 38h
; 5Eh: Unused - frame 18h
; 5Eh: Unused - frame 38h
; 5Fh: Unused - frame 18h
; 5Fh: Unused - frame 38h
; 60h: Unused - frame 18h
; 60h: Unused - frame 38h
; 61h: Unused - frame 18h
; 61h: Unused - frame 38h
; B2h: Facing clockwise     - grapple - in air - frame 18h
; B2h: Facing clockwise     - grapple - in air - frame 38h
$92:CE80             dx 9C9B00, 00C0, 0080

; 5Dh: Unused - frame 17h
; 5Dh: Unused - frame 37h
; 5Eh: Unused - frame 17h
; 5Eh: Unused - frame 37h
; 5Fh: Unused - frame 17h
; 5Fh: Unused - frame 37h
; 60h: Unused - frame 17h
; 60h: Unused - frame 37h
; 61h: Unused - frame 17h
; 61h: Unused - frame 37h
; B2h: Facing clockwise     - grapple - in air - frame 17h
; B2h: Facing clockwise     - grapple - in air - frame 37h
$92:CE87             dx 9C9C40, 00C0, 0080

; 5Dh: Unused - frame 16h
; 5Dh: Unused - frame 36h
; 5Eh: Unused - frame 16h
; 5Eh: Unused - frame 36h
; 5Fh: Unused - frame 16h
; 5Fh: Unused - frame 36h
; 60h: Unused - frame 16h
; 60h: Unused - frame 36h
; 61h: Unused - frame 16h
; 61h: Unused - frame 36h
; B2h: Facing clockwise     - grapple - in air - frame 16h
; B2h: Facing clockwise     - grapple - in air - frame 36h
$92:CE8E             dx 9C9D80, 00C0, 00C0

; 5Dh: Unused - frame 15h
; 5Dh: Unused - frame 35h
; 5Eh: Unused - frame 15h
; 5Eh: Unused - frame 35h
; 5Fh: Unused - frame 15h
; 5Fh: Unused - frame 35h
; 60h: Unused - frame 15h
; 60h: Unused - frame 35h
; 61h: Unused - frame 15h
; 61h: Unused - frame 35h
; B2h: Facing clockwise     - grapple - in air - frame 15h
; B2h: Facing clockwise     - grapple - in air - frame 35h
$92:CE95             dx 9C9F00, 00C0, 00C0

; 5Dh: Unused - frame 14h
; 5Dh: Unused - frame 34h
; 5Eh: Unused - frame 14h
; 5Eh: Unused - frame 34h
; 5Fh: Unused - frame 14h
; 5Fh: Unused - frame 34h
; 60h: Unused - frame 14h
; 60h: Unused - frame 34h
; 61h: Unused - frame 14h
; 61h: Unused - frame 34h
; B2h: Facing clockwise     - grapple - in air - frame 14h
; B2h: Facing clockwise     - grapple - in air - frame 34h
$92:CE9C             dx 9CA080, 00C0, 00C0

; 5Dh: Unused - frame 13h
; 5Dh: Unused - frame 33h
; 5Eh: Unused - frame 13h
; 5Eh: Unused - frame 33h
; 5Fh: Unused - frame 13h
; 5Fh: Unused - frame 33h
; 60h: Unused - frame 13h
; 60h: Unused - frame 33h
; 61h: Unused - frame 13h
; 61h: Unused - frame 33h
; B2h: Facing clockwise     - grapple - in air - frame 13h
; B2h: Facing clockwise     - grapple - in air - frame 33h
$92:CEA3             dx 9CA200, 00C0, 00C0

; 5Dh: Unused - frame 12h
; 5Dh: Unused - frame 32h
; 5Eh: Unused - frame 12h
; 5Eh: Unused - frame 32h
; 5Fh: Unused - frame 12h
; 5Fh: Unused - frame 32h
; 60h: Unused - frame 12h
; 60h: Unused - frame 32h
; 61h: Unused - frame 12h
; 61h: Unused - frame 32h
; B2h: Facing clockwise     - grapple - in air - frame 12h
; B2h: Facing clockwise     - grapple - in air - frame 32h
$92:CEAA             dx 9CA380, 00C0, 00C0

; 5Dh: Unused - frame 11h
; 5Dh: Unused - frame 31h
; 5Eh: Unused - frame 11h
; 5Eh: Unused - frame 31h
; 5Fh: Unused - frame 11h
; 5Fh: Unused - frame 31h
; 60h: Unused - frame 11h
; 60h: Unused - frame 31h
; 61h: Unused - frame 11h
; 61h: Unused - frame 31h
; B2h: Facing clockwise     - grapple - in air - frame 11h
; B2h: Facing clockwise     - grapple - in air - frame 31h
$92:CEB1             dx 9CA500, 00C0, 0080

; 5Dh: Unused - frame 10h
; 5Dh: Unused - frame 30h
; 5Dh: Unused - frames 40h..41h
; 5Eh: Unused - frame 10h
; 5Eh: Unused - frame 30h
; 5Eh: Unused - frames 40h..41h
; 5Fh: Unused - frame 10h
; 5Fh: Unused - frame 30h
; 5Fh: Unused - frames 40h..41h
; 60h: Unused - frame 10h
; 60h: Unused - frame 30h
; 60h: Unused - frames 40h..41h
; 61h: Unused - frame 10h
; 61h: Unused - frame 30h
; 61h: Unused - frames 40h..41h
; B2h: Facing clockwise     - grapple - in air - frame 10h
; B2h: Facing clockwise     - grapple - in air - frame 30h
; B2h: Facing clockwise     - grapple - in air - frames 40h..41h
$92:CEB8             dx 9CA640, 00C0, 0080

; 5Dh: Unused - frame Fh
; 5Dh: Unused - frame 2Fh
; 5Eh: Unused - frame Fh
; 5Eh: Unused - frame 2Fh
; 5Fh: Unused - frame Fh
; 5Fh: Unused - frame 2Fh
; 60h: Unused - frame Fh
; 60h: Unused - frame 2Fh
; 61h: Unused - frame Fh
; 61h: Unused - frame 2Fh
; B2h: Facing clockwise     - grapple - in air - frame Fh
; B2h: Facing clockwise     - grapple - in air - frame 2Fh
$92:CEBF             dx 9CA780, 00C0, 0080

; 5Dh: Unused - frame Eh
; 5Dh: Unused - frame 2Eh
; 5Eh: Unused - frame Eh
; 5Eh: Unused - frame 2Eh
; 5Fh: Unused - frame Eh
; 5Fh: Unused - frame 2Eh
; 60h: Unused - frame Eh
; 60h: Unused - frame 2Eh
; 61h: Unused - frame Eh
; 61h: Unused - frame 2Eh
; B2h: Facing clockwise     - grapple - in air - frame Eh
; B2h: Facing clockwise     - grapple - in air - frame 2Eh
$92:CEC6             dx 9CA8C0, 00C0, 00C0

; 5Dh: Unused - frame Dh
; 5Dh: Unused - frame 2Dh
; 5Eh: Unused - frame Dh
; 5Eh: Unused - frame 2Dh
; 5Fh: Unused - frame Dh
; 5Fh: Unused - frame 2Dh
; 60h: Unused - frame Dh
; 60h: Unused - frame 2Dh
; 61h: Unused - frame Dh
; 61h: Unused - frame 2Dh
; B2h: Facing clockwise     - grapple - in air - frame Dh
; B2h: Facing clockwise     - grapple - in air - frame 2Dh
$92:CECD             dx 9CAA40, 00C0, 00C0

; 5Dh: Unused - frame Ch
; 5Dh: Unused - frame 2Ch
; 5Eh: Unused - frame Ch
; 5Eh: Unused - frame 2Ch
; 5Fh: Unused - frame Ch
; 5Fh: Unused - frame 2Ch
; 60h: Unused - frame Ch
; 60h: Unused - frame 2Ch
; 61h: Unused - frame Ch
; 61h: Unused - frame 2Ch
; B2h: Facing clockwise     - grapple - in air - frame Ch
; B2h: Facing clockwise     - grapple - in air - frame 2Ch
$92:CED4             dx 9CABC0, 00C0, 00C0

; 5Dh: Unused - frame Bh
; 5Dh: Unused - frame 2Bh
; 5Eh: Unused - frame Bh
; 5Eh: Unused - frame 2Bh
; 5Fh: Unused - frame Bh
; 5Fh: Unused - frame 2Bh
; 60h: Unused - frame Bh
; 60h: Unused - frame 2Bh
; 61h: Unused - frame Bh
; 61h: Unused - frame 2Bh
; B2h: Facing clockwise     - grapple - in air - frame Bh
; B2h: Facing clockwise     - grapple - in air - frame 2Bh
$92:CEDB             dx 9CAD40, 00C0, 00C0

; 5Dh: Unused - frame Ah
; 5Dh: Unused - frame 2Ah
; 5Eh: Unused - frame Ah
; 5Eh: Unused - frame 2Ah
; 5Fh: Unused - frame Ah
; 5Fh: Unused - frame 2Ah
; 60h: Unused - frame Ah
; 60h: Unused - frame 2Ah
; 61h: Unused - frame Ah
; 61h: Unused - frame 2Ah
; B2h: Facing clockwise     - grapple - in air - frame Ah
; B2h: Facing clockwise     - grapple - in air - frame 2Ah
$92:CEE2             dx 9CAEC0, 00C0, 00C0

; 5Dh: Unused - frame 9
; 5Dh: Unused - frame 29h
; 5Eh: Unused - frame 9
; 5Eh: Unused - frame 29h
; 5Fh: Unused - frame 9
; 5Fh: Unused - frame 29h
; 60h: Unused - frame 9
; 60h: Unused - frame 29h
; 61h: Unused - frame 9
; 61h: Unused - frame 29h
; B2h: Facing clockwise     - grapple - in air - frame 9
; B2h: Facing clockwise     - grapple - in air - frame 29h
$92:CEE9             dx 9CB040, 00C0, 0080

; Unused
$92:CEF0             dx 9CB180, 00C0, 0080
}


;;; $CEF7: Samus top tiles - set 4 (facing anticlockwise - grappling - in air - upside up) ;;;
{
; 62h: Unused - frame 8
; 62h: Unused - frame 28h
; B3h: Facing anticlockwise - grapple - in air - frame 8
; B3h: Facing anticlockwise - grapple - in air - frame 28h
$92:CEF7             dx 9CB2C0, 0100, 00C0

; 62h: Unused - frame 9
; 62h: Unused - frame 29h
; B3h: Facing anticlockwise - grapple - in air - frame 9
; B3h: Facing anticlockwise - grapple - in air - frame 29h
$92:CEFE             dx 9CB480, 0100, 00C0

; 62h: Unused - frame Ah
; 62h: Unused - frame 2Ah
; B3h: Facing anticlockwise - grapple - in air - frame Ah
; B3h: Facing anticlockwise - grapple - in air - frame 2Ah
$92:CF05             dx 9CB640, 0100, 0100

; 62h: Unused - frame Bh
; 62h: Unused - frame 2Bh
; B3h: Facing anticlockwise - grapple - in air - frame Bh
; B3h: Facing anticlockwise - grapple - in air - frame 2Bh
$92:CF0C             dx 9CB840, 0100, 0100

; 62h: Unused - frame Ch
; 62h: Unused - frame 2Ch
; B3h: Facing anticlockwise - grapple - in air - frame Ch
; B3h: Facing anticlockwise - grapple - in air - frame 2Ch
$92:CF13             dx 9CBA40, 0100, 00E0

; 62h: Unused - frame Dh
; 62h: Unused - frame 2Dh
; B3h: Facing anticlockwise - grapple - in air - frame Dh
; B3h: Facing anticlockwise - grapple - in air - frame 2Dh
$92:CF1A             dx 9CBC20, 0100, 00E0

; 62h: Unused - frame Eh
; 62h: Unused - frame 2Eh
; B3h: Facing anticlockwise - grapple - in air - frame Eh
; B3h: Facing anticlockwise - grapple - in air - frame 2Eh
$92:CF21             dx 9CBE00, 0100, 00E0

; 62h: Unused - frame Fh
; 62h: Unused - frame 2Fh
; B3h: Facing anticlockwise - grapple - in air - frame Fh
; B3h: Facing anticlockwise - grapple - in air - frame 2Fh
$92:CF28             dx 9CBFE0, 0100, 00C0

; 62h: Unused - frame 10h
; 62h: Unused - frame 30h
; 62h: Unused - frames 40h..41h
; B3h: Facing anticlockwise - grapple - in air - frame 10h
; B3h: Facing anticlockwise - grapple - in air - frame 30h
; B3h: Facing anticlockwise - grapple - in air - frames 40h..41h
$92:CF2F             dx 9CC1A0, 0100, 00C0

; 62h: Unused - frame 11h
; 62h: Unused - frame 31h
; B3h: Facing anticlockwise - grapple - in air - frame 11h
; B3h: Facing anticlockwise - grapple - in air - frame 31h
$92:CF36             dx 9CC360, 0100, 00C0

; 62h: Unused - frame 12h
; 62h: Unused - frame 32h
; B3h: Facing anticlockwise - grapple - in air - frame 12h
; B3h: Facing anticlockwise - grapple - in air - frame 32h
$92:CF3D             dx 9CC520, 0100, 00E0

; 62h: Unused - frame 13h
; 62h: Unused - frame 33h
; B3h: Facing anticlockwise - grapple - in air - frame 13h
; B3h: Facing anticlockwise - grapple - in air - frame 33h
$92:CF44             dx 9CC700, 0100, 0100

; 62h: Unused - frame 14h
; 62h: Unused - frame 34h
; B3h: Facing anticlockwise - grapple - in air - frame 14h
; B3h: Facing anticlockwise - grapple - in air - frame 34h
$92:CF4B             dx 9CC900, 0100, 0100

; 62h: Unused - frame 15h
; 62h: Unused - frame 35h
; B3h: Facing anticlockwise - grapple - in air - frame 15h
; B3h: Facing anticlockwise - grapple - in air - frame 35h
$92:CF52             dx 9CCB00, 0100, 0100

; 62h: Unused - frame 16h
; 62h: Unused - frame 36h
; B3h: Facing anticlockwise - grapple - in air - frame 16h
; B3h: Facing anticlockwise - grapple - in air - frame 36h
$92:CF59             dx 9CCD00, 0100, 0100

; 62h: Unused - frame 17h
; 62h: Unused - frame 37h
; B3h: Facing anticlockwise - grapple - in air - frame 17h
; B3h: Facing anticlockwise - grapple - in air - frame 37h
$92:CF60             dx 9CCF00, 0100, 00E0

; Unused
$92:CF67             dx 9CD0E0, 0100, 00E0
}


;;; $CF6E: Samus top tiles - set 5 (facing clockwise - grappling - in air - upside down) ;;;
{
; 5Dh: Unused - frame 8
; 5Dh: Unused - frame 28h
; 5Eh: Unused - frame 8
; 5Eh: Unused - frame 28h
; 5Fh: Unused - frame 8
; 5Fh: Unused - frame 28h
; 60h: Unused - frame 8
; 60h: Unused - frame 28h
; 61h: Unused - frame 8
; 61h: Unused - frame 28h
; B2h: Facing clockwise     - grapple - in air - frame 8
; B2h: Facing clockwise     - grapple - in air - frame 28h
$92:CF6E             dx 9DC980, 00C0, 0080

; 5Dh: Unused - frame 7
; 5Dh: Unused - frame 27h
; 5Eh: Unused - frame 7
; 5Eh: Unused - frame 27h
; 5Fh: Unused - frame 7
; 5Fh: Unused - frame 27h
; 60h: Unused - frame 7
; 60h: Unused - frame 27h
; 61h: Unused - frame 7
; 61h: Unused - frame 27h
; B2h: Facing clockwise     - grapple - in air - frame 7
; B2h: Facing clockwise     - grapple - in air - frame 27h
$92:CF75             dx 9DCAC0, 00C0, 0080

; 5Dh: Unused - frame 6
; 5Dh: Unused - frame 26h
; 5Eh: Unused - frame 6
; 5Eh: Unused - frame 26h
; 5Fh: Unused - frame 6
; 5Fh: Unused - frame 26h
; 60h: Unused - frame 6
; 60h: Unused - frame 26h
; 61h: Unused - frame 6
; 61h: Unused - frame 26h
; B2h: Facing clockwise     - grapple - in air - frame 6
; B2h: Facing clockwise     - grapple - in air - frame 26h
$92:CF7C             dx 9DCC00, 00C0, 00C0

; 5Dh: Unused - frame 5
; 5Dh: Unused - frame 25h
; 5Eh: Unused - frame 5
; 5Eh: Unused - frame 25h
; 5Fh: Unused - frame 5
; 5Fh: Unused - frame 25h
; 60h: Unused - frame 5
; 60h: Unused - frame 25h
; 61h: Unused - frame 5
; 61h: Unused - frame 25h
; B2h: Facing clockwise     - grapple - in air - frame 5
; B2h: Facing clockwise     - grapple - in air - frame 25h
$92:CF83             dx 9DCD80, 00C0, 00C0

; 5Dh: Unused - frame 4
; 5Dh: Unused - frame 24h
; 5Eh: Unused - frame 4
; 5Eh: Unused - frame 24h
; 5Fh: Unused - frame 4
; 5Fh: Unused - frame 24h
; 60h: Unused - frame 4
; 60h: Unused - frame 24h
; 61h: Unused - frame 4
; 61h: Unused - frame 24h
; B2h: Facing clockwise     - grapple - in air - frame 4
; B2h: Facing clockwise     - grapple - in air - frame 24h
$92:CF8A             dx 9DCF00, 00C0, 00C0

; 5Dh: Unused - frame 3
; 5Dh: Unused - frame 23h
; 5Eh: Unused - frame 3
; 5Eh: Unused - frame 23h
; 5Fh: Unused - frame 3
; 5Fh: Unused - frame 23h
; 60h: Unused - frame 3
; 60h: Unused - frame 23h
; 61h: Unused - frame 3
; 61h: Unused - frame 23h
; B2h: Facing clockwise     - grapple - in air - frame 3
; B2h: Facing clockwise     - grapple - in air - frame 23h
$92:CF91             dx 9DD080, 00C0, 00C0

; 5Dh: Unused - frame 2
; 5Dh: Unused - frame 22h
; 5Eh: Unused - frame 2
; 5Eh: Unused - frame 22h
; 5Fh: Unused - frame 2
; 5Fh: Unused - frame 22h
; 60h: Unused - frame 2
; 60h: Unused - frame 22h
; 61h: Unused - frame 2
; 61h: Unused - frame 22h
; B2h: Facing clockwise     - grapple - in air - frame 2
; B2h: Facing clockwise     - grapple - in air - frame 22h
$92:CF98             dx 9DD200, 00C0, 00C0

; 5Dh: Unused - frame 1
; 5Dh: Unused - frame 21h
; 5Eh: Unused - frame 1
; 5Eh: Unused - frame 21h
; 5Fh: Unused - frame 1
; 5Fh: Unused - frame 21h
; 60h: Unused - frame 1
; 60h: Unused - frame 21h
; 61h: Unused - frame 1
; 61h: Unused - frame 21h
; B2h: Facing clockwise     - grapple - in air - frame 1
; B2h: Facing clockwise     - grapple - in air - frame 21h
$92:CF9F             dx 9DD380, 00C0, 0080

; 5Dh: Unused - frame 0
; 5Dh: Unused - frame 20h
; 5Eh: Unused - frame 0
; 5Eh: Unused - frame 20h
; 5Fh: Unused - frame 0
; 5Fh: Unused - frame 20h
; 60h: Unused - frame 0
; 60h: Unused - frame 20h
; 61h: Unused - frame 0
; 61h: Unused - frame 20h
; B2h: Facing clockwise     - grapple - in air - frame 0
; B2h: Facing clockwise     - grapple - in air - frame 20h
$92:CFA6             dx 9DD4C0, 00C0, 0080

; 5Dh: Unused - frame 1Fh
; 5Dh: Unused - frame 3Fh
; 5Eh: Unused - frame 1Fh
; 5Eh: Unused - frame 3Fh
; 5Fh: Unused - frame 1Fh
; 5Fh: Unused - frame 3Fh
; 60h: Unused - frame 1Fh
; 60h: Unused - frame 3Fh
; 61h: Unused - frame 1Fh
; 61h: Unused - frame 3Fh
; B2h: Facing clockwise     - grapple - in air - frame 1Fh
; B2h: Facing clockwise     - grapple - in air - frame 3Fh
$92:CFAD             dx 9DD600, 00C0, 0080

; 5Dh: Unused - frame 1Eh
; 5Dh: Unused - frame 3Eh
; 5Eh: Unused - frame 1Eh
; 5Eh: Unused - frame 3Eh
; 5Fh: Unused - frame 1Eh
; 5Fh: Unused - frame 3Eh
; 60h: Unused - frame 1Eh
; 60h: Unused - frame 3Eh
; 61h: Unused - frame 1Eh
; 61h: Unused - frame 3Eh
; B2h: Facing clockwise     - grapple - in air - frame 1Eh
; B2h: Facing clockwise     - grapple - in air - frame 3Eh
$92:CFB4             dx 9DD740, 00C0, 00C0

; 5Dh: Unused - frame 1Dh
; 5Dh: Unused - frame 3Dh
; 5Eh: Unused - frame 1Dh
; 5Eh: Unused - frame 3Dh
; 5Fh: Unused - frame 1Dh
; 5Fh: Unused - frame 3Dh
; 60h: Unused - frame 1Dh
; 60h: Unused - frame 3Dh
; 61h: Unused - frame 1Dh
; 61h: Unused - frame 3Dh
; B2h: Facing clockwise     - grapple - in air - frame 1Dh
; B2h: Facing clockwise     - grapple - in air - frame 3Dh
$92:CFBB             dx 9DD8C0, 00C0, 00C0

; 5Dh: Unused - frame 1Ch
; 5Dh: Unused - frame 3Ch
; 5Eh: Unused - frame 1Ch
; 5Eh: Unused - frame 3Ch
; 5Fh: Unused - frame 1Ch
; 5Fh: Unused - frame 3Ch
; 60h: Unused - frame 1Ch
; 60h: Unused - frame 3Ch
; 61h: Unused - frame 1Ch
; 61h: Unused - frame 3Ch
; B2h: Facing clockwise     - grapple - in air - frame 1Ch
; B2h: Facing clockwise     - grapple - in air - frame 3Ch
$92:CFC2             dx 9DDA40, 00C0, 00C0

; 5Dh: Unused - frame 1Bh
; 5Dh: Unused - frame 3Bh
; 5Eh: Unused - frame 1Bh
; 5Eh: Unused - frame 3Bh
; 5Fh: Unused - frame 1Bh
; 5Fh: Unused - frame 3Bh
; 60h: Unused - frame 1Bh
; 60h: Unused - frame 3Bh
; 61h: Unused - frame 1Bh
; 61h: Unused - frame 3Bh
; B2h: Facing clockwise     - grapple - in air - frame 1Bh
; B2h: Facing clockwise     - grapple - in air - frame 3Bh
$92:CFC9             dx 9DDBC0, 00C0, 00C0

; 5Dh: Unused - frame 1Ah
; 5Dh: Unused - frame 3Ah
; 5Eh: Unused - frame 1Ah
; 5Eh: Unused - frame 3Ah
; 5Fh: Unused - frame 1Ah
; 5Fh: Unused - frame 3Ah
; 60h: Unused - frame 1Ah
; 60h: Unused - frame 3Ah
; 61h: Unused - frame 1Ah
; 61h: Unused - frame 3Ah
; B2h: Facing clockwise     - grapple - in air - frame 1Ah
; B2h: Facing clockwise     - grapple - in air - frame 3Ah
$92:CFD0             dx 9DDD40, 00C0, 00C0

; 5Dh: Unused - frame 19h
; 5Dh: Unused - frame 39h
; 5Eh: Unused - frame 19h
; 5Eh: Unused - frame 39h
; 5Fh: Unused - frame 19h
; 5Fh: Unused - frame 39h
; 60h: Unused - frame 19h
; 60h: Unused - frame 39h
; 61h: Unused - frame 19h
; 61h: Unused - frame 39h
; B2h: Facing clockwise     - grapple - in air - frame 19h
; B2h: Facing clockwise     - grapple - in air - frame 39h
$92:CFD7             dx 9DDEC0, 00C0, 0080

; Unused
$92:CFDE             dx 9DE000, 00C0, 0080
}


;;; $CFE5: Samus top tiles - set 6 (facing anticlockwise - grappling - in air - upside down) ;;;
{
; 62h: Unused - frame 18h
; 62h: Unused - frame 38h
; B3h: Facing anticlockwise - grapple - in air - frame 18h
; B3h: Facing anticlockwise - grapple - in air - frame 38h
$92:CFE5             dx 9DE140, 0100, 00C0

; 62h: Unused - frame 19h
; 62h: Unused - frame 39h
; B3h: Facing anticlockwise - grapple - in air - frame 19h
; B3h: Facing anticlockwise - grapple - in air - frame 39h
$92:CFEC             dx 9DE300, 0100, 00C0

; 62h: Unused - frame 1Ah
; 62h: Unused - frame 3Ah
; B3h: Facing anticlockwise - grapple - in air - frame 1Ah
; B3h: Facing anticlockwise - grapple - in air - frame 3Ah
$92:CFF3             dx 9DE4C0, 0100, 0100

; 62h: Unused - frame 1Bh
; 62h: Unused - frame 3Bh
; B3h: Facing anticlockwise - grapple - in air - frame 1Bh
; B3h: Facing anticlockwise - grapple - in air - frame 3Bh
$92:CFFA             dx 9DE6C0, 0100, 0100

; 62h: Unused - frame 1Ch
; 62h: Unused - frame 3Ch
; B3h: Facing anticlockwise - grapple - in air - frame 1Ch
; B3h: Facing anticlockwise - grapple - in air - frame 3Ch
$92:D001             dx 9DE8C0, 0100, 00E0

; 62h: Unused - frame 1Dh
; 62h: Unused - frame 3Dh
; B3h: Facing anticlockwise - grapple - in air - frame 1Dh
; B3h: Facing anticlockwise - grapple - in air - frame 3Dh
$92:D008             dx 9DEAA0, 0100, 00E0

; 62h: Unused - frame 1Eh
; 62h: Unused - frame 3Eh
; B3h: Facing anticlockwise - grapple - in air - frame 1Eh
; B3h: Facing anticlockwise - grapple - in air - frame 3Eh
$92:D00F             dx 9DEC80, 0100, 00E0

; 62h: Unused - frame 1Fh
; 62h: Unused - frame 3Fh
; B3h: Facing anticlockwise - grapple - in air - frame 1Fh
; B3h: Facing anticlockwise - grapple - in air - frame 3Fh
$92:D016             dx 9DEE60, 0100, 00C0

; 62h: Unused - frame 0
; 62h: Unused - frame 20h
; B3h: Facing anticlockwise - grapple - in air - frame 0
; B3h: Facing anticlockwise - grapple - in air - frame 20h
$92:D01D             dx 9DF020, 0100, 00C0

; 62h: Unused - frame 1
; 62h: Unused - frame 21h
; B3h: Facing anticlockwise - grapple - in air - frame 1
; B3h: Facing anticlockwise - grapple - in air - frame 21h
$92:D024             dx 9DF1E0, 0100, 00C0

; 62h: Unused - frame 2
; 62h: Unused - frame 22h
; B3h: Facing anticlockwise - grapple - in air - frame 2
; B3h: Facing anticlockwise - grapple - in air - frame 22h
$92:D02B             dx 9DF3A0, 0100, 00E0

; 62h: Unused - frame 3
; 62h: Unused - frame 23h
; B3h: Facing anticlockwise - grapple - in air - frame 3
; B3h: Facing anticlockwise - grapple - in air - frame 23h
$92:D032             dx 9DF580, 0100, 0100

; 62h: Unused - frame 4
; 62h: Unused - frame 24h
; B3h: Facing anticlockwise - grapple - in air - frame 4
; B3h: Facing anticlockwise - grapple - in air - frame 24h
$92:D039             dx 9FED80, 0100, 0100

; 62h: Unused - frame 5
; 62h: Unused - frame 25h
; B3h: Facing anticlockwise - grapple - in air - frame 5
; B3h: Facing anticlockwise - grapple - in air - frame 25h
$92:D040             dx 9FEF80, 0100, 0100

; 62h: Unused - frame 6
; 62h: Unused - frame 26h
; B3h: Facing anticlockwise - grapple - in air - frame 6
; B3h: Facing anticlockwise - grapple - in air - frame 26h
$92:D047             dx 9FF180, 0100, 0100

; 62h: Unused - frame 7
; 62h: Unused - frame 27h
; B3h: Facing anticlockwise - grapple - in air - frame 7
; B3h: Facing anticlockwise - grapple - in air - frame 27h
$92:D04E             dx 9FF380, 0100, 00E0

; Unused
$92:D055             dx 9FF560, 0100, 00E0
}


;;; $D05C: Samus top tiles - set 7 (standing, crouching, drained) ;;;
{
; E9h: Facing left  - Samus drained - crouching/falling - frame 8
; E9h: Facing left  - Samus drained - crouching/falling - frame 1Ah
; E9h: Facing left  - Samus drained - crouching/falling - frame 1Dh
$92:D05C             dx 9CD2C0, 00E0, 0040

; E9h: Facing left  - Samus drained - crouching/falling - frame 7
; E9h: Facing left  - Samus drained - crouching/falling - frame 9
; E9h: Facing left  - Samus drained - crouching/falling - frame Bh
; E9h: Facing left  - Samus drained - crouching/falling - frame Eh
; E9h: Facing left  - Samus drained - crouching/falling - frame 13h
; E9h: Facing left  - Samus drained - crouching/falling - frame 17h
$92:D063             dx 9CD3E0, 00E0, 0040

; E9h: Facing left  - Samus drained - crouching/falling - frame Ah
$92:D06A             dx 9CD500, 00E0, 0040

; E8h: Facing right - Samus drained - crouching/falling - frame 8
$92:D071             dx 9CD620, 0100, 0040

; E8h: Facing right - Samus drained - crouching/falling - frame 9
; E8h: Facing right - Samus drained - crouching/falling - frame Bh
$92:D078             dx 9CD760, 0100, 0040

; E8h: Facing right - Samus drained - crouching/falling - frame Ah
$92:D07F             dx 9CD8A0, 0100, 0040

; EBh: Facing left  - Samus drained - standing - frame 0
$92:D086             dx 9CD9E0, 00E0, 0040

; E9h: Facing left  - Samus drained - crouching/falling - frame Fh
; E9h: Facing left  - Samus drained - crouching/falling - frame 14h
; E9h: Facing left  - Samus drained - crouching/falling - frame 16h
; EBh: Facing left  - Samus drained - standing - frame 1
; EBh: Facing left  - Samus drained - standing - frame 3
$92:D08D             dx 9CDB00, 00E0, 0040

; EBh: Facing left  - Samus drained - standing - frame 2
$92:D094             dx 9CDC20, 00E0, 0040

; EAh: Facing right - Samus drained - standing - frame 0
$92:D09B             dx 9CDD40, 0100, 0040

; EAh: Facing right - Samus drained - standing - frame 1
; EAh: Facing right - Samus drained - standing - frame 3
$92:D0A2             dx 9CDE80, 0100, 0040

; EAh: Facing right - Samus drained - standing - frame 2
$92:D0A9             dx 9CDFC0, 0100, 0040

; 1: Facing right - normal - frame 0
; 1: Facing right - normal - frame 5
; 27h: Facing right - crouching - frame 0
; 27h: Facing right - crouching - frame 5
; 47h: Unused - frame 0
; 47h: Unused - frame 5
; 89h: Facing right - ran into a wall - frame 0
; 89h: Facing right - ran into a wall - frame 5
; A8h: Facing right - grappling - frame 0
; A8h: Facing right - grappling - frame 5
; B4h: Facing right - grappling - crouching - frame 0
; B4h: Facing right - grappling - crouching - frame 5
$92:D0B0             dx 9CE100, 00C0, 0080

; 1: Facing right - normal - frame 1
; 1: Facing right - normal - frame 3
; 1: Facing right - normal - frame 6
; 1: Facing right - normal - frame 8
; 27h: Facing right - crouching - frame 1
; 27h: Facing right - crouching - frame 3
; 27h: Facing right - crouching - frame 6
; 27h: Facing right - crouching - frame 8
; 47h: Unused - frame 1
; 47h: Unused - frame 3
; 47h: Unused - frame 6
; 47h: Unused - frame 8
; 89h: Facing right - ran into a wall - frame 1
; 89h: Facing right - ran into a wall - frame 3
; 89h: Facing right - ran into a wall - frame 6
; 89h: Facing right - ran into a wall - frame 8
; A8h: Facing right - grappling - frame 1
; A8h: Facing right - grappling - frame 3
; A8h: Facing right - grappling - frame 6
; A8h: Facing right - grappling - frame 8
; B4h: Facing right - grappling - crouching - frame 1
; B4h: Facing right - grappling - crouching - frame 3
; B4h: Facing right - grappling - crouching - frame 6
; B4h: Facing right - grappling - crouching - frame 8
$92:D0B7             dx 9CE240, 00C0, 0080

; 1: Facing right - normal - frame 2
; 27h: Facing right - crouching - frame 2
; 47h: Unused - frame 2
; 89h: Facing right - ran into a wall - frame 2
; A8h: Facing right - grappling - frame 2
; B4h: Facing right - grappling - crouching - frame 2
$92:D0BE             dx 9CE380, 00C0, 0080

; 2: Facing left  - normal - frame 0
; 2: Facing left  - normal - frame 5
; 28h: Facing left  - crouching - frame 0
; 28h: Facing left  - crouching - frame 5
; 48h: Unused - frame 0
; 48h: Unused - frame 5
; 8Ah: Facing left  - ran into a wall - frame 0
; 8Ah: Facing left  - ran into a wall - frame 5
; A9h: Facing left  - grappling - frame 0
; A9h: Facing left  - grappling - frame 5
; B5h: Facing left  - grappling - crouching - frame 0
; B5h: Facing left  - grappling - crouching - frame 5
$92:D0C5             dx 9CE4C0, 00C0, 0080

; 2: Facing left  - normal - frame 1
; 2: Facing left  - normal - frame 3
; 2: Facing left  - normal - frame 6
; 2: Facing left  - normal - frame 8
; 28h: Facing left  - crouching - frame 1
; 28h: Facing left  - crouching - frame 3
; 28h: Facing left  - crouching - frame 6
; 28h: Facing left  - crouching - frame 8
; 48h: Unused - frame 1
; 48h: Unused - frame 3
; 48h: Unused - frame 6
; 48h: Unused - frame 8
; 8Ah: Facing left  - ran into a wall - frame 1
; 8Ah: Facing left  - ran into a wall - frame 3
; 8Ah: Facing left  - ran into a wall - frame 6
; 8Ah: Facing left  - ran into a wall - frame 8
; A9h: Facing left  - grappling - frame 1
; A9h: Facing left  - grappling - frame 3
; A9h: Facing left  - grappling - frame 6
; A9h: Facing left  - grappling - frame 8
; B5h: Facing left  - grappling - crouching - frame 1
; B5h: Facing left  - grappling - crouching - frame 3
; B5h: Facing left  - grappling - crouching - frame 6
; B5h: Facing left  - grappling - crouching - frame 8
$92:D0CC             dx 9CE600, 00C0, 0080

; 2: Facing left  - normal - frame 2
; 28h: Facing left  - crouching - frame 2
; 48h: Unused - frame 2
; 8Ah: Facing left  - ran into a wall - frame 2
; A9h: Facing left  - grappling - frame 2
; B5h: Facing left  - grappling - crouching - frame 2
$92:D0D3             dx 9CE740, 00C0, 0080

; 1: Facing right - normal - frame 7
; 27h: Facing right - crouching - frame 7
; 47h: Unused - frame 7
; 89h: Facing right - ran into a wall - frame 7
; A8h: Facing right - grappling - frame 7
; B4h: Facing right - grappling - crouching - frame 7
$92:D0DA             dx 9CE880, 00C0, 0040

; 2: Facing left  - normal - frame 7
; 28h: Facing left  - crouching - frame 7
; 48h: Unused - frame 7
; 8Ah: Facing left  - ran into a wall - frame 7
; A9h: Facing left  - grappling - frame 7
; B5h: Facing left  - grappling - crouching - frame 7
$92:D0E1             dx 9CE980, 00C0, 0040
}


;;; $D0E8: Samus top tiles - set 8 (Samus appearance electricity) ;;;
{
; 0: Facing forward - power suit - frame 3
; 0: Facing forward - power suit - frame 5
; 0: Facing forward - power suit - frame 7
; 0: Facing forward - power suit - frame 9
; 0: Facing forward - power suit - frame Bh
; 0: Facing forward - power suit - frame Dh
; 0: Facing forward - power suit - frame Fh
; 0: Facing forward - power suit - frame 11h
; 0: Facing forward - power suit - frame 13h
; 0: Facing forward - power suit - frame 15h
; 0: Facing forward - power suit - frame 17h
; 0: Facing forward - power suit - frame 19h
; 0: Facing forward - power suit - frame 1Bh
; 0: Facing forward - power suit - frame 1Dh
; 0: Facing forward - power suit - frame 1Fh
; 0: Facing forward - power suit - frame 21h
; 0: Facing forward - power suit - frame 23h
; 0: Facing forward - power suit - frame 25h
; 0: Facing forward - power suit - frame 27h
; 0: Facing forward - power suit - frame 29h
; 0: Facing forward - power suit - frame 2Bh
; 0: Facing forward - power suit - frame 2Dh
; 0: Facing forward - power suit - frame 2Fh
; 0: Facing forward - power suit - frame 31h
; 0: Facing forward - power suit - frame 33h
; 0: Facing forward - power suit - frame 35h
; 0: Facing forward - power suit - frame 37h
; 0: Facing forward - power suit - frame 39h
; 0: Facing forward - power suit - frame 3Bh
; 0: Facing forward - power suit - frame 3Dh
; 0: Facing forward - power suit - frame 3Fh
; 0: Facing forward - power suit - frame 41h
; 0: Facing forward - power suit - frame 43h
; 0: Facing forward - power suit - frame 45h
; 0: Facing forward - power suit - frame 47h
; 0: Facing forward - power suit - frame 49h
; 0: Facing forward - power suit - frame 4Bh
; 0: Facing forward - power suit - frame 4Dh
; 0: Facing forward - power suit - frame 4Fh
; 0: Facing forward - power suit - frame 51h
; 0: Facing forward - power suit - frame 53h
; 0: Facing forward - power suit - frame 55h
; 0: Facing forward - power suit - frame 57h
; 0: Facing forward - power suit - frame 59h
; 0: Facing forward - power suit - frame 5Bh
; 0: Facing forward - power suit - frame 5Dh
; 0: Facing forward - power suit - frame 5Fh
; 9Bh: Facing forward - varia/gravity suit - frame 3
; 9Bh: Facing forward - varia/gravity suit - frame 5
; 9Bh: Facing forward - varia/gravity suit - frame 7
; 9Bh: Facing forward - varia/gravity suit - frame 9
; 9Bh: Facing forward - varia/gravity suit - frame Bh
; 9Bh: Facing forward - varia/gravity suit - frame Dh
; 9Bh: Facing forward - varia/gravity suit - frame Fh
; 9Bh: Facing forward - varia/gravity suit - frame 11h
; 9Bh: Facing forward - varia/gravity suit - frame 13h
; 9Bh: Facing forward - varia/gravity suit - frame 15h
; 9Bh: Facing forward - varia/gravity suit - frame 17h
; 9Bh: Facing forward - varia/gravity suit - frame 19h
; 9Bh: Facing forward - varia/gravity suit - frame 1Bh
; 9Bh: Facing forward - varia/gravity suit - frame 1Dh
; 9Bh: Facing forward - varia/gravity suit - frame 1Fh
; 9Bh: Facing forward - varia/gravity suit - frame 21h
; 9Bh: Facing forward - varia/gravity suit - frame 23h
; 9Bh: Facing forward - varia/gravity suit - frame 25h
; 9Bh: Facing forward - varia/gravity suit - frame 27h
; 9Bh: Facing forward - varia/gravity suit - frame 29h
; 9Bh: Facing forward - varia/gravity suit - frame 2Bh
; 9Bh: Facing forward - varia/gravity suit - frame 2Dh
; 9Bh: Facing forward - varia/gravity suit - frame 2Fh
; 9Bh: Facing forward - varia/gravity suit - frame 31h
; 9Bh: Facing forward - varia/gravity suit - frame 33h
; 9Bh: Facing forward - varia/gravity suit - frame 35h
; 9Bh: Facing forward - varia/gravity suit - frame 37h
; 9Bh: Facing forward - varia/gravity suit - frame 39h
; 9Bh: Facing forward - varia/gravity suit - frame 3Bh
; 9Bh: Facing forward - varia/gravity suit - frame 3Dh
; 9Bh: Facing forward - varia/gravity suit - frame 3Fh
; 9Bh: Facing forward - varia/gravity suit - frame 41h
; 9Bh: Facing forward - varia/gravity suit - frame 43h
; 9Bh: Facing forward - varia/gravity suit - frame 45h
; 9Bh: Facing forward - varia/gravity suit - frame 47h
; 9Bh: Facing forward - varia/gravity suit - frame 49h
; 9Bh: Facing forward - varia/gravity suit - frame 4Bh
; 9Bh: Facing forward - varia/gravity suit - frame 4Dh
; 9Bh: Facing forward - varia/gravity suit - frame 4Fh
; 9Bh: Facing forward - varia/gravity suit - frame 51h
; 9Bh: Facing forward - varia/gravity suit - frame 53h
; 9Bh: Facing forward - varia/gravity suit - frame 55h
; 9Bh: Facing forward - varia/gravity suit - frame 57h
; 9Bh: Facing forward - varia/gravity suit - frame 59h
; 9Bh: Facing forward - varia/gravity suit - frame 5Bh
; 9Bh: Facing forward - varia/gravity suit - frame 5Dh
; 9Bh: Facing forward - varia/gravity suit - frame 5Fh
$92:D0E8             dx 9BE000, 0020, 0000

; Unused
$92:D0EF             dx 9BE020, 0020, 0000

; 0: Facing forward - power suit - frame 2
; 0: Facing forward - power suit - frame 8
; 0: Facing forward - power suit - frame Eh
; 0: Facing forward - power suit - frame 14h
; 0: Facing forward - power suit - frame 1Ah
; 0: Facing forward - power suit - frame 20h
; 0: Facing forward - power suit - frame 26h
; 0: Facing forward - power suit - frame 2Ch
; 0: Facing forward - power suit - frame 32h
; 0: Facing forward - power suit - frame 38h
; 0: Facing forward - power suit - frame 3Eh
; 0: Facing forward - power suit - frame 44h
; 0: Facing forward - power suit - frame 4Ah
; 9Bh: Facing forward - varia/gravity suit - frame 2
; 9Bh: Facing forward - varia/gravity suit - frame 8
; 9Bh: Facing forward - varia/gravity suit - frame Eh
; 9Bh: Facing forward - varia/gravity suit - frame 14h
; 9Bh: Facing forward - varia/gravity suit - frame 1Ah
; 9Bh: Facing forward - varia/gravity suit - frame 20h
; 9Bh: Facing forward - varia/gravity suit - frame 26h
; 9Bh: Facing forward - varia/gravity suit - frame 2Ch
; 9Bh: Facing forward - varia/gravity suit - frame 32h
; 9Bh: Facing forward - varia/gravity suit - frame 38h
; 9Bh: Facing forward - varia/gravity suit - frame 3Eh
; 9Bh: Facing forward - varia/gravity suit - frame 44h
; 9Bh: Facing forward - varia/gravity suit - frame 4Ah
$92:D0F6             dx 9BE040, 0100, 0020

; 0: Facing forward - power suit - frame 4
; 0: Facing forward - power suit - frame Ah
; 0: Facing forward - power suit - frame 10h
; 0: Facing forward - power suit - frame 16h
; 0: Facing forward - power suit - frame 1Ch
; 0: Facing forward - power suit - frame 22h
; 0: Facing forward - power suit - frame 28h
; 0: Facing forward - power suit - frame 2Eh
; 0: Facing forward - power suit - frame 34h
; 0: Facing forward - power suit - frame 3Ah
; 0: Facing forward - power suit - frame 40h
; 0: Facing forward - power suit - frame 46h
; 0: Facing forward - power suit - frame 4Ch
; 9Bh: Facing forward - varia/gravity suit - frame 4
; 9Bh: Facing forward - varia/gravity suit - frame Ah
; 9Bh: Facing forward - varia/gravity suit - frame 10h
; 9Bh: Facing forward - varia/gravity suit - frame 16h
; 9Bh: Facing forward - varia/gravity suit - frame 1Ch
; 9Bh: Facing forward - varia/gravity suit - frame 22h
; 9Bh: Facing forward - varia/gravity suit - frame 28h
; 9Bh: Facing forward - varia/gravity suit - frame 2Eh
; 9Bh: Facing forward - varia/gravity suit - frame 34h
; 9Bh: Facing forward - varia/gravity suit - frame 3Ah
; 9Bh: Facing forward - varia/gravity suit - frame 40h
; 9Bh: Facing forward - varia/gravity suit - frame 46h
; 9Bh: Facing forward - varia/gravity suit - frame 4Ch
$92:D0FD             dx 9BE160, 00E0, 0000

; 0: Facing forward - power suit - frame 6
; 0: Facing forward - power suit - frame Ch
; 0: Facing forward - power suit - frame 12h
; 0: Facing forward - power suit - frame 18h
; 0: Facing forward - power suit - frame 1Eh
; 0: Facing forward - power suit - frame 24h
; 0: Facing forward - power suit - frame 2Ah
; 0: Facing forward - power suit - frame 30h
; 0: Facing forward - power suit - frame 36h
; 0: Facing forward - power suit - frame 3Ch
; 0: Facing forward - power suit - frame 42h
; 0: Facing forward - power suit - frame 48h
; 0: Facing forward - power suit - frame 4Eh
; 9Bh: Facing forward - varia/gravity suit - frame 6
; 9Bh: Facing forward - varia/gravity suit - frame Ch
; 9Bh: Facing forward - varia/gravity suit - frame 12h
; 9Bh: Facing forward - varia/gravity suit - frame 18h
; 9Bh: Facing forward - varia/gravity suit - frame 1Eh
; 9Bh: Facing forward - varia/gravity suit - frame 24h
; 9Bh: Facing forward - varia/gravity suit - frame 2Ah
; 9Bh: Facing forward - varia/gravity suit - frame 30h
; 9Bh: Facing forward - varia/gravity suit - frame 36h
; 9Bh: Facing forward - varia/gravity suit - frame 3Ch
; 9Bh: Facing forward - varia/gravity suit - frame 42h
; 9Bh: Facing forward - varia/gravity suit - frame 48h
; 9Bh: Facing forward - varia/gravity suit - frame 4Eh
$92:D104             dx 9BE240, 0100, 0060

; 0: Facing forward - power suit - frame 50h
; 9Bh: Facing forward - varia/gravity suit - frame 50h
$92:D10B             dx 9BE3A0, 0100, 00E0

; 0: Facing forward - power suit - frame 52h
; 9Bh: Facing forward - varia/gravity suit - frame 52h
$92:D112             dx 9BE580, 0100, 0000

; 0: Facing forward - power suit - frame 54h
; 0: Facing forward - power suit - frame 5Ah
; 9Bh: Facing forward - varia/gravity suit - frame 54h
; 9Bh: Facing forward - varia/gravity suit - frame 5Ah
$92:D119             dx 9BE680, 0100, 0040

; 0: Facing forward - power suit - frame 56h
; 0: Facing forward - power suit - frame 5Ch
; 9Bh: Facing forward - varia/gravity suit - frame 56h
; 9Bh: Facing forward - varia/gravity suit - frame 5Ch
$92:D120             dx 9BE7C0, 0100, 0060

; 0: Facing forward - power suit - frame 58h
; 0: Facing forward - power suit - frame 5Eh
; 9Bh: Facing forward - varia/gravity suit - frame 58h
; 9Bh: Facing forward - varia/gravity suit - frame 5Eh
$92:D127             dx 9BE920, 00E0, 0000
}


;;; $D12E: Samus top tiles - set 9 (moving - gun extended) ;;;
{
; Bh: Moving right - gun extended - frame 0
; Bh: Moving right - gun extended - frame 5
$92:D12E             dx 9BEE20, 0080, 0040

; Bh: Moving right - gun extended - frame 4
$92:D135             dx 9BEEE0, 0080, 0040

; Bh: Moving right - gun extended - frame 2
$92:D13C             dx 9BEFA0, 00A0, 0040

; Bh: Moving right - gun extended - frame 3
$92:D143             dx 9BF080, 00C0, 0040

; Bh: Moving right - gun extended - frame 6
; Bh: Moving right - gun extended - frame 9
$92:D14A             dx 9BF180, 0080, 0040

; Bh: Moving right - gun extended - frame 7
$92:D151             dx 9BF240, 00A0, 0040

; Ch: Moving left  - gun extended - frame 0
; Ch: Moving left  - gun extended - frame 5
$92:D158             dx 9BF320, 00C0, 0040

; Ch: Moving left  - gun extended - frame 4
$92:D15F             dx 9BF420, 00C0, 0040

; Ch: Moving left  - gun extended - frame 3
$92:D166             dx 9BF520, 00E0, 0040

; Ch: Moving left  - gun extended - frame 2
$92:D16D             dx 9BF640, 00E0, 0040

; Ch: Moving left  - gun extended - frame 6
; Ch: Moving left  - gun extended - frame 9
$92:D174             dx 9BF760, 00C0, 0040

; Ch: Moving left  - gun extended - frame 8
$92:D17B             dx 9BF860, 0100, 0040

; Bh: Moving right - gun extended - frame 8
$92:D182             dx 9BF9A0, 00C0, 0040

; Ch: Moving left  - gun extended - frame 7
$92:D189             dx 9BFAA0, 0100, 0040

; Bh: Moving right - gun extended - frame 1
$92:D190             dx 9BFBE0, 0080, 0040

; Ch: Moving left  - gun extended - frame 1
$92:D197             dx 9BFCA0, 00C0, 0040
}


;;; $D19E: Samus bottom tiles - set 0 (general) ;;;
{
; Actually used by:
;     9: Moving right - not aiming - frame 0
;     Ah: Moving left  - not aiming - frame 0
;     Bh: Moving right - gun extended - frame 0
;     Ch: Moving left  - gun extended - frame 0
;     Dh: Moving right - aiming up (unused) - frame 0
;     Eh: Moving left  - aiming up (unused) - frame 0
;     Fh: Moving right - aiming up-right - frame 0
;     10h: Moving left  - aiming up-left - frame 0
;     11h: Moving right - aiming down-right - frame 0
;     12h: Moving left  - aiming down-left - frame 0

; Meaninglessly used by:
{
;     0: Facing forward - power suit - frame 1
;     1: Facing right - normal - frame 4
;     2: Facing left  - normal - frame 4
;     19h: Facing right - spin jump - frames 1..Ah
;     1Ah: Facing left  - spin jump - frames 1..Ah
;     1Bh: Facing right - space jump - frames 9..Ah
;     1Ch: Facing left  - space jump - frames 9..Ah
;     1Dh: Facing right - morph ball - no springball - on ground - frames 0..9
;     1Eh: Moving right - morph ball - no springball - on ground - frames 0..9
;     1Fh: Moving left  - morph ball - no springball - on ground - frames 0..9
;     20h: Unused - frames 1..Ah
;     21h: Unused - frames 1..Ah
;     22h: Unused - frames 1..Ah
;     23h: Unused - frames 1..Ah
;     24h: Unused - frames 1..Ah
;     27h: Facing right - crouching - frame 4
;     28h: Facing left  - crouching - frame 4
;     29h: Facing right - falling - frames 3..4
;     2Ah: Facing left  - falling - frames 3..4
;     31h: Facing right - morph ball - no springball - in air - frames 0..9
;     32h: Facing left  - morph ball - no springball - in air - frames 0..9
;     33h: Unused - frames 1..Ah
;     34h: Unused - frames 1..Ah
;     37h: Facing right - morphing transition - frames 0..1
;     38h: Facing left  - morphing transition - frames 0..1
;     39h: Unused - frames 1..Ah
;     3Ah: Unused - frames 1..Ah
;     3Dh: Facing right - unmorphing transition - frames 0..1
;     3Eh: Facing left  - unmorphing transition - frames 0..1
;     3Fh: Unused - frames 0..9
;     40h: Unused - frames 0..9
;     41h: Facing left  - morph ball - no springball - on ground - frames 0..9
;     42h: Unused - frames 1..Ah
;     47h: Unused - frame 4
;     48h: Unused - frame 4
;     4Fh: Facing left  - damage boost - frames 2..8
;     50h: Facing right - damage boost - frames 2..8
;     65h: Unused. Related to movement type Dh - frames 1..8
;     66h: Unused. Related to movement type Dh - frames 1..8
;     67h: Facing right - falling - gun extended - frames 3..4
;     68h: Facing left  - falling - gun extended - frames 3..4
;     79h: Facing right - morph ball - spring ball - on ground - frames 0..9
;     7Ah: Facing left  - morph ball - spring ball - on ground - frames 0..9
;     7Bh: Moving right - morph ball - spring ball - on ground - frames 0..9
;     7Ch: Moving left  - morph ball - spring ball - on ground - frames 0..9
;     7Dh: Facing right - morph ball - spring ball - falling - frames 0..9
;     7Eh: Facing left  - morph ball - spring ball - falling - frames 0..9
;     7Fh: Facing right - morph ball - spring ball - in air - frames 0..9
;     80h: Facing left  - morph ball - spring ball - in air - frames 0..9
;     81h: Facing right - screw attack - frames 19h..1Ah
;     82h: Facing left  - screw attack - frames 19h..1Ah
;     83h: Facing right - wall jump - frames 2..Ch
;     83h: Facing right - wall jump - frames 15h..16h
;     84h: Facing left  - wall jump - frames 2..Ch
;     84h: Facing left  - wall jump - frames 15h..16h
;     89h: Facing right - ran into a wall - frame 4
;     8Ah: Facing left  - ran into a wall - frame 4
;     9Bh: Facing forward - varia/gravity suit - frame 1
;     A8h: Facing right - grappling - frame 4
;     A9h: Facing left  - grappling - frame 4
;     B4h: Facing right - grappling - crouching - frame 4
;     B5h: Facing left  - grappling - crouching - frame 4
;     C5h: Unused - frames 0..9
;     CBh: Facing right - shinespark - vertical - frame 0
;     CCh: Facing left  - shinespark - vertical - frame 0
;     D3h: Facing right - crystal flash - frames 4..5
;     D3h: Facing right - crystal flash - frames Ah..Bh
;     D4h: Facing left  - crystal flash - frames 4..5
;     D4h: Facing left  - crystal flash - frames Ah..Bh
;     DBh: Unused - frames 1..2
;     DCh: Unused - frames 1..2
;     DDh: Unused - frames 0..1
;     DEh: Unused - frames 0..1
;     DFh: Unused - frames 0..9
;     E8h: Facing right - Samus drained - crouching/falling - frames Ch..Dh
;     E9h: Facing left  - Samus drained - crouching/falling - frames Ch..Dh
;     E9h: Facing left  - Samus drained - crouching/falling - frames 11h..12h
;     E9h: Facing left  - Samus drained - crouching/falling - frames 18h..19h
;     E9h: Facing left  - Samus drained - crouching/falling - frames 1Bh..1Ch
;     E9h: Facing left  - Samus drained - crouching/falling - frames 1Eh..1Fh
;     EAh: Facing right - Samus drained - standing - frame 4
;     EBh: Facing left  - Samus drained - standing - frame 4
}
$92:D19E             dx 9D8000, 0080, 0080

; 9: Moving right - not aiming - frame 2
; Ah: Moving left  - not aiming - frame 2
; Bh: Moving right - gun extended - frame 2
; Ch: Moving left  - gun extended - frame 2
; Dh: Moving right - aiming up (unused) - frame 2
; Eh: Moving left  - aiming up (unused) - frame 2
; Fh: Moving right - aiming up-right - frame 2
; 10h: Moving left  - aiming up-left - frame 2
; 11h: Moving right - aiming down-right - frame 2
; 12h: Moving left  - aiming down-left - frame 2
$92:D1A5             dx 9D8100, 00E0, 0080

; 9: Moving right - not aiming - frame 4
; Ah: Moving left  - not aiming - frame 4
; Bh: Moving right - gun extended - frame 4
; Ch: Moving left  - gun extended - frame 4
; Dh: Moving right - aiming up (unused) - frame 4
; Eh: Moving left  - aiming up (unused) - frame 4
; Fh: Moving right - aiming up-right - frame 4
; 10h: Moving left  - aiming up-left - frame 4
; 11h: Moving right - aiming down-right - frame 4
; 12h: Moving left  - aiming down-left - frame 4
$92:D1AC             dx 9D8260, 00E0, 00C0

; 9: Moving right - not aiming - frame 5
; Ah: Moving left  - not aiming - frame 5
; Bh: Moving right - gun extended - frame 5
; Ch: Moving left  - gun extended - frame 5
; Dh: Moving right - aiming up (unused) - frame 5
; Eh: Moving left  - aiming up (unused) - frame 5
; Fh: Moving right - aiming up-right - frame 5
; 10h: Moving left  - aiming up-left - frame 5
; 11h: Moving right - aiming down-right - frame 5
; 12h: Moving left  - aiming down-left - frame 5
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 0
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 0
; C7h: Facing right - vertical shinespark windup - frame 0
; C8h: Facing left  - vertical shinespark windup - frame 0
$92:D1B3             dx 9D8400, 0080, 0080

; 9: Moving right - not aiming - frame 7
; Ah: Moving left  - not aiming - frame 7
; Bh: Moving right - gun extended - frame 7
; Ch: Moving left  - gun extended - frame 7
; Dh: Moving right - aiming up (unused) - frame 7
; Eh: Moving left  - aiming up (unused) - frame 7
; Fh: Moving right - aiming up-right - frame 7
; 10h: Moving left  - aiming up-left - frame 7
; 11h: Moving right - aiming down-right - frame 7
; 12h: Moving left  - aiming down-left - frame 7
$92:D1BA             dx 9D8500, 0100, 0080

; 9: Moving right - not aiming - frame 9
; Ah: Moving left  - not aiming - frame 9
; Bh: Moving right - gun extended - frame 9
; Ch: Moving left  - gun extended - frame 9
; Dh: Moving right - aiming up (unused) - frame 9
; Eh: Moving left  - aiming up (unused) - frame 9
; Fh: Moving right - aiming up-right - frame 9
; 10h: Moving left  - aiming up-left - frame 9
; 11h: Moving right - aiming down-right - frame 9
; 12h: Moving left  - aiming down-left - frame 9
$92:D1C1             dx 9D8680, 00E0, 00C0

; 1: Facing right - normal - frame 0
; 1: Facing right - normal - frame 5
; 2: Facing left  - normal - frame 0
; 2: Facing left  - normal - frame 5
; 47h: Unused - frame 0
; 47h: Unused - frame 5
; 48h: Unused - frame 0
; 48h: Unused - frame 5
; 89h: Facing right - ran into a wall - frame 0
; 89h: Facing right - ran into a wall - frame 5
; 8Ah: Facing left  - ran into a wall - frame 0
; 8Ah: Facing left  - ran into a wall - frame 5
; A4h: Facing right - landing from normal jump - frame 1
; A5h: Facing left  - landing from normal jump - frame 1
; A6h: Facing right - landing from spin jump - frame 2
; A7h: Facing left  - landing from spin jump - frame 2
; A8h: Facing right - grappling - frame 0
; A8h: Facing right - grappling - frame 5
; A9h: Facing left  - grappling - frame 0
; A9h: Facing left  - grappling - frame 5
; D5h: Facing right - x-ray - standing - frames 0..4
; D6h: Facing left  - x-ray - standing - frames 0..4
; E0h: Facing right - landing from normal jump - aiming up - frame 1
; E1h: Facing left  - landing from normal jump - aiming up - frame 1
; E2h: Facing right - landing from normal jump - aiming up-right - frame 1
; E3h: Facing left  - landing from normal jump - aiming up-left - frame 1
; E4h: Facing right - landing from normal jump - aiming down-right - frame 1
; E5h: Facing left  - landing from normal jump - aiming down-left - frame 1
; E6h: Facing right - landing from normal jump - firing - frame 1
; E7h: Facing left  - landing from normal jump - firing - frame 1
$92:D1C8             dx 9D8820, 00C0, 00C0

; 27h: Facing right - crouching - frames 0..3
; 27h: Facing right - crouching - frames 5..8
; 28h: Facing left  - crouching - frames 0..3
; 28h: Facing left  - crouching - frames 5..8
; 71h: Facing right - crouching - aiming up-right - frame 0
; 72h: Facing left  - crouching - aiming up-left - frame 0
; 73h: Facing right - crouching - aiming down-right - frame 0
; 74h: Facing left  - crouching - aiming down-left - frame 0
; 85h: Facing right - crouching - aiming up - frames 0..1
; 86h: Facing left  - crouching - aiming up - frames 0..1
; B4h: Facing right - grappling - crouching - frames 0..3
; B4h: Facing right - grappling - crouching - frames 5..8
; B5h: Facing left  - grappling - crouching - frames 0..3
; B5h: Facing left  - grappling - crouching - frames 5..8
; B6h: Facing right - grappling - crouching - aiming down-right - frame 0
; B7h: Facing left  - grappling - crouching - aiming down-left - frame 0
; D9h: Facing right - x-ray - crouching - frames 0..4
; DAh: Facing left  - x-ray - crouching - frames 0..4
$92:D1CF             dx 9D89A0, 0080, 0080

; 9: Moving right - not aiming - frame 1
; Ah: Moving left  - not aiming - frame 1
; Bh: Moving right - gun extended - frame 1
; Ch: Moving left  - gun extended - frame 1
; Dh: Moving right - aiming up (unused) - frame 1
; Eh: Moving left  - aiming up (unused) - frame 1
; Fh: Moving right - aiming up-right - frame 1
; 10h: Moving left  - aiming up-left - frame 1
; 11h: Moving right - aiming down-right - frame 1
; 12h: Moving left  - aiming down-left - frame 1
$92:D1D6             dx 9D8AA0, 00C0, 0080

; 9: Moving right - not aiming - frame 3
; Ah: Moving left  - not aiming - frame 3
; Bh: Moving right - gun extended - frame 3
; Ch: Moving left  - gun extended - frame 3
; Dh: Moving right - aiming up (unused) - frame 3
; Eh: Moving left  - aiming up (unused) - frame 3
; Fh: Moving right - aiming up-right - frame 3
; 10h: Moving left  - aiming up-left - frame 3
; 11h: Moving right - aiming down-right - frame 3
; 12h: Moving left  - aiming down-left - frame 3
$92:D1DD             dx 9D8BE0, 0100, 0080

; 9: Moving right - not aiming - frame 6
; Ah: Moving left  - not aiming - frame 6
; Bh: Moving right - gun extended - frame 6
; Ch: Moving left  - gun extended - frame 6
; Dh: Moving right - aiming up (unused) - frame 6
; Eh: Moving left  - aiming up (unused) - frame 6
; Fh: Moving right - aiming up-right - frame 6
; 10h: Moving left  - aiming up-left - frame 6
; 11h: Moving right - aiming down-right - frame 6
; 12h: Moving left  - aiming down-left - frame 6
$92:D1E4             dx 9D8D60, 00C0, 0080

; 9: Moving right - not aiming - frame 8
; Ah: Moving left  - not aiming - frame 8
; Bh: Moving right - gun extended - frame 8
; Ch: Moving left  - gun extended - frame 8
; Dh: Moving right - aiming up (unused) - frame 8
; Eh: Moving left  - aiming up (unused) - frame 8
; Fh: Moving right - aiming up-right - frame 8
; 10h: Moving left  - aiming up-left - frame 8
; 11h: Moving right - aiming down-right - frame 8
; 12h: Moving left  - aiming down-left - frame 8
$92:D1EB             dx 9D8EA0, 0100, 0080

; 0: Facing forward - power suit - frame 0
$92:D1F2             dx 9D9020, 0100, 00C0

; 9Bh: Facing forward - varia/gravity suit - frame 0
$92:D1F9             dx 9D91E0, 0100, 00C0

; 1: Facing right - normal - frame 1
; 1: Facing right - normal - frame 3
; 1: Facing right - normal - frame 6
; 1: Facing right - normal - frame 8
; 47h: Unused - frame 1
; 47h: Unused - frame 3
; 47h: Unused - frame 6
; 47h: Unused - frame 8
; 89h: Facing right - ran into a wall - frame 1
; 89h: Facing right - ran into a wall - frame 3
; 89h: Facing right - ran into a wall - frame 6
; 89h: Facing right - ran into a wall - frame 8
; A8h: Facing right - grappling - frame 1
; A8h: Facing right - grappling - frame 3
; A8h: Facing right - grappling - frame 6
; A8h: Facing right - grappling - frame 8
$92:D200             dx 9D93A0, 00C0, 00C0

; 1: Facing right - normal - frame 2
; 1: Facing right - normal - frame 7
; 47h: Unused - frame 2
; 47h: Unused - frame 7
; 89h: Facing right - ran into a wall - frame 2
; 89h: Facing right - ran into a wall - frame 7
; A8h: Facing right - grappling - frame 2
; A8h: Facing right - grappling - frame 7
$92:D207             dx 9D9520, 00C0, 00C0

; 2: Facing left  - normal - frame 1
; 2: Facing left  - normal - frame 3
; 2: Facing left  - normal - frame 6
; 2: Facing left  - normal - frame 8
; 48h: Unused - frame 1
; 48h: Unused - frame 3
; 48h: Unused - frame 6
; 48h: Unused - frame 8
; 8Ah: Facing left  - ran into a wall - frame 1
; 8Ah: Facing left  - ran into a wall - frame 3
; 8Ah: Facing left  - ran into a wall - frame 6
; 8Ah: Facing left  - ran into a wall - frame 8
; A9h: Facing left  - grappling - frame 1
; A9h: Facing left  - grappling - frame 3
; A9h: Facing left  - grappling - frame 6
; A9h: Facing left  - grappling - frame 8
$92:D20E             dx 9D96A0, 00C0, 00C0

; 4Fh: Facing left  - damage boost - frame 0
$92:D215             dx 9D9820, 00A0, 0040

; 50h: Facing right - damage boost - frame 0
$92:D21C             dx 9D9900, 00A0, 0040

; 15h: Facing right - normal jump - aiming up - frame 1
; 69h: Facing right - normal jump - aiming up-right - frame 1
$92:D223             dx 9D99E0, 00A0, 0080

; 16h: Facing left  - normal jump - aiming up - frame 1
; 6Ah: Facing left  - normal jump - aiming up-left - frame 1
$92:D22A             dx 9D9B00, 00A0, 0080

; 25h: Facing right - turning - standing - frame 2
; 26h: Facing left  - turning - standing - frame 0
; 8Bh: Facing right - turning - standing - aiming up - frame 2
; 8Ch: Facing left  - turning - standing - aiming up - frame 0
; 8Dh: Facing right - turning - standing - aiming down-right - frame 2
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 0
; 9Ch: Facing right - turning - standing - aiming up-right - frame 2
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 0
; BFh: Facing right - moonwalking - turn/jump left - frame 2
; C0h: Facing left  - moonwalking - turn/jump right - frame 0
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 2
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 0
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 2
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 0
; C6h: Unused - frame 2
$92:D231             dx 9D9C20, 00A0, 0080

; 25h: Facing right - turning - standing - frame 0
; 26h: Facing left  - turning - standing - frame 2
; 8Bh: Facing right - turning - standing - aiming up - frame 0
; 8Ch: Facing left  - turning - standing - aiming up - frame 2
; 8Dh: Facing right - turning - standing - aiming down-right - frame 0
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 2
; 9Ch: Facing right - turning - standing - aiming up-right - frame 0
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 2
; BFh: Facing right - moonwalking - turn/jump left - frame 0
; C0h: Facing left  - moonwalking - turn/jump right - frame 2
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 0
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 2
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 0
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 2
; C6h: Unused - frame 0
$92:D238             dx 9D9D40, 00A0, 0080

; 2Fh: Facing right - turning - jumping - frame 2
; 30h: Facing left  - turning - jumping - frame 0
; 43h: Facing right - turning - crouching - frame 2
; 44h: Facing left  - turning - crouching - frame 0
; 87h: Facing right - turning - falling - frame 2
; 88h: Facing left  - turning - falling - frame 0
; 8Fh: Facing right - turning - in air - aiming up - frame 2
; 90h: Facing left  - turning - in air - aiming up - frame 0
; 91h: Facing right - turning - in air - aiming down/down-right - frame 2
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 0
; 93h: Facing right - turning - falling - aiming up - frame 2
; 94h: Facing left  - turning - falling - aiming up - frame 0
; 95h: Facing right - turning - falling - aiming down/down-right - frame 2
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 0
; 97h: Facing right - turning - crouching - aiming up - frame 2
; 98h: Facing left  - turning - crouching - aiming up - frame 0
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 2
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 0
; 9Eh: Facing right - turning - in air - aiming up-right - frame 2
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 0
; A0h: Facing right - turning - falling - aiming up-right - frame 2
; A1h: Facing left  - turning - falling - aiming up-left - frame 0
; A2h: Facing right - turning - crouching - aiming up-right - frame 2
; A3h: Facing left  - turning - crouching - aiming up-left - frame 0
$92:D23F             dx 9D9E60, 0080, 0040

; 2Fh: Facing right - turning - jumping - frame 0
; 30h: Facing left  - turning - jumping - frame 2
; 43h: Facing right - turning - crouching - frame 0
; 44h: Facing left  - turning - crouching - frame 2
; 87h: Facing right - turning - falling - frame 0
; 88h: Facing left  - turning - falling - frame 2
; 8Fh: Facing right - turning - in air - aiming up - frame 0
; 90h: Facing left  - turning - in air - aiming up - frame 2
; 91h: Facing right - turning - in air - aiming down/down-right - frame 0
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 2
; 93h: Facing right - turning - falling - aiming up - frame 0
; 94h: Facing left  - turning - falling - aiming up - frame 2
; 95h: Facing right - turning - falling - aiming down/down-right - frame 0
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 2
; 97h: Facing right - turning - crouching - aiming up - frame 0
; 98h: Facing left  - turning - crouching - aiming up - frame 2
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 0
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 2
; 9Eh: Facing right - turning - in air - aiming up-right - frame 0
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 2
; A0h: Facing right - turning - falling - aiming up-right - frame 0
; A1h: Facing left  - turning - falling - aiming up-left - frame 2
; A2h: Facing right - turning - crouching - aiming up-right - frame 0
; A3h: Facing left  - turning - crouching - aiming up-left - frame 2
$92:D246             dx 9D9F20, 0080, 0040

; 5Ch: Unused - frame 0
; 64h: Unused. Related to movement type Dh - frame 1
; B9h: Facing right - grapple wall jump pose - frame 0
$92:D24D             dx 9D9FE0, 0080, 0080

; 45h: Unused - frame 0
; 46h: Unused - frame 0
; 5Bh: Unused - frame 0
; 63h: Unused. Related to movement type Dh - frame 1
; B8h: Facing left  - grapple wall jump pose - frame 0
$92:D254             dx 9DA0E0, 0080, 0080

; C9h: Facing right - shinespark - horizontal - frame 0
; CDh: Facing right - shinespark - diagonal - frame 0
$92:D25B             dx 9DA1E0, 00C0, 0080

; CAh: Facing left  - shinespark - horizontal - frame 0
; CEh: Facing left  - shinespark - diagonal - frame 0
$92:D262             dx 9DA320, 00C0, 0080

; 2: Facing left  - normal - frame 2
; 2: Facing left  - normal - frame 7
; 48h: Unused - frame 2
; 48h: Unused - frame 7
; 8Ah: Facing left  - ran into a wall - frame 2
; 8Ah: Facing left  - ran into a wall - frame 7
; A9h: Facing left  - grappling - frame 2
; A9h: Facing left  - grappling - frame 7
$92:D269             dx 9DA460, 00C0, 00C0

; 19h: Facing right - spin jump - frame Bh
; 1Bh: Facing right - space jump - frame Bh
; 20h: Unused - frame Bh
; 21h: Unused - frame Bh
; 22h: Unused - frame Bh
; 23h: Unused - frame Bh
; 24h: Unused - frame Bh
; 33h: Unused - frame Bh
; 34h: Unused - frame Bh
; 39h: Unused - frame Bh
; 3Ah: Unused - frame Bh
; 42h: Unused - frame Bh
; 81h: Facing right - screw attack - frame 1Bh
$92:D270             dx 9DA5E0, 0080, 0080

; 1Ah: Facing left  - spin jump - frame Bh
; 1Ch: Facing left  - space jump - frame Bh
; 82h: Facing left  - screw attack - frame 1Bh
$92:D277             dx 9DA6E0, 0080, 0080
}


;;; $D27E: Samus bottom tiles - set 1 (general) ;;;
{
; 49h: Facing left  - moonwalk - frame 3
; 4Ah: Facing right - moonwalk - frame 3
; 75h: Facing left  - moonwalk - aiming up-left - frame 3
; 76h: Facing right - moonwalk - aiming up-right - frame 3
; 77h: Facing left  - moonwalk - aiming down-left - frame 3
; 78h: Facing right - moonwalk - aiming down-right - frame 3
$92:D27E             dx 9DA7E0, 00C0, 0080

; 25h: Facing right - turning - standing - frame 1
; 26h: Facing left  - turning - standing - frame 1
; 8Bh: Facing right - turning - standing - aiming up - frame 1
; 8Ch: Facing left  - turning - standing - aiming up - frame 1
; 8Dh: Facing right - turning - standing - aiming down-right - frame 1
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 1
; 9Ch: Facing right - turning - standing - aiming up-right - frame 1
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 1
; BFh: Facing right - moonwalking - turn/jump left - frame 1
; C0h: Facing left  - moonwalking - turn/jump right - frame 1
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 1
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 1
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 1
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 1
; C6h: Unused - frame 1
$92:D285             dx 9DA920, 0080, 0080

; 2Fh: Facing right - turning - jumping - frame 1
; 30h: Facing left  - turning - jumping - frame 1
; 43h: Facing right - turning - crouching - frame 1
; 44h: Facing left  - turning - crouching - frame 1
; 87h: Facing right - turning - falling - frame 1
; 88h: Facing left  - turning - falling - frame 1
; 8Fh: Facing right - turning - in air - aiming up - frame 1
; 90h: Facing left  - turning - in air - aiming up - frame 1
; 91h: Facing right - turning - in air - aiming down/down-right - frame 1
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 1
; 93h: Facing right - turning - falling - aiming up - frame 1
; 94h: Facing left  - turning - falling - aiming up - frame 1
; 95h: Facing right - turning - falling - aiming down/down-right - frame 1
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 1
; 97h: Facing right - turning - crouching - aiming up - frame 1
; 98h: Facing left  - turning - crouching - aiming up - frame 1
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 1
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 1
; 9Eh: Facing right - turning - in air - aiming up-right - frame 1
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 1
; A0h: Facing right - turning - falling - aiming up-right - frame 1
; A1h: Facing left  - turning - falling - aiming up-left - frame 1
; A2h: Facing right - turning - crouching - aiming up-right - frame 1
; A3h: Facing left  - turning - crouching - aiming up-left - frame 1
$92:D28C             dx 9DAA20, 0040, 0040

; 49h: Facing left  - moonwalk - frame 0
; 4Ah: Facing right - moonwalk - frame 0
; 75h: Facing left  - moonwalk - aiming up-left - frame 0
; 76h: Facing right - moonwalk - aiming up-right - frame 0
; 77h: Facing left  - moonwalk - aiming down-left - frame 0
; 78h: Facing right - moonwalk - aiming down-right - frame 0
$92:D293             dx 9DAAA0, 00C0, 0080

; 49h: Facing left  - moonwalk - frame 1
; 4Ah: Facing right - moonwalk - frame 1
; 75h: Facing left  - moonwalk - aiming up-left - frame 1
; 76h: Facing right - moonwalk - aiming up-right - frame 1
; 77h: Facing left  - moonwalk - aiming down-left - frame 1
; 78h: Facing right - moonwalk - aiming down-right - frame 1
$92:D29A             dx 9DABE0, 0080, 0080

; 49h: Facing left  - moonwalk - frame 4
; 4Ah: Facing right - moonwalk - frame 4
; 75h: Facing left  - moonwalk - aiming up-left - frame 4
; 76h: Facing right - moonwalk - aiming up-right - frame 4
; 77h: Facing left  - moonwalk - aiming down-left - frame 4
; 78h: Facing right - moonwalk - aiming down-right - frame 4
$92:D2A1             dx 9DACE0, 0080, 0080

; 35h: Facing right - crouching transition - frame 0
; 3Bh: Facing right - standing transition - frame 0
; 4Bh: Facing right - normal jump transition - frame 0
; 55h: Facing right - normal jump transition - aiming up - frame 0
; 57h: Facing right - normal jump transition - aiming up-right - frame 0
; 59h: Facing right - normal jump transition - aiming down-right - frame 0
; A4h: Facing right - landing from normal jump - frame 0
; A6h: Facing right - landing from spin jump - frame 1
; D3h: Facing right - crystal flash - frame Eh
; D7h: Facing right - crystal flash ending - frames 0..3
; D8h: Facing left  - crystal flash ending - frames 0..2
; DBh: Unused - frame 0
; DCh: Unused - frame 0
; DDh: Unused - frame 2
; DEh: Unused - frame 2
; E0h: Facing right - landing from normal jump - aiming up - frame 0
; E2h: Facing right - landing from normal jump - aiming up-right - frame 0
; E4h: Facing right - landing from normal jump - aiming down-right - frame 0
; E6h: Facing right - landing from normal jump - firing - frame 0
; E8h: Facing right - Samus drained - crouching/falling - frames 0..2
; E8h: Facing right - Samus drained - crouching/falling - frame Eh
; E9h: Facing left  - Samus drained - crouching/falling - frames 0..1
; EAh: Facing right - Samus drained - standing - frame 5
; F1h: Facing right - crouching transition - aiming up - frame 0
; F3h: Facing right - crouching transition - aiming up-right - frame 0
; F5h: Facing right - crouching transition - aiming down-right - frame 0
; F7h: Facing right - standing transition - aiming up - frame 0
; F9h: Facing right - standing transition - aiming up-right - frame 0
; FBh: Facing right - standing transition - aiming down-right - frame 0
$92:D2A8             dx 9DADE0, 00C0, 0080

; 36h: Facing left  - crouching transition - frame 0
; 3Ch: Facing left  - standing transition - frame 0
; 4Ch: Facing left  - normal jump transition - frame 0
; 56h: Facing left  - normal jump transition - aiming up - frame 0
; 58h: Facing left  - normal jump transition - aiming up-left - frame 0
; 5Ah: Facing left  - normal jump transition - aiming down-left - frame 0
; A5h: Facing left  - landing from normal jump - frame 0
; A7h: Facing left  - landing from spin jump - frame 1
; D4h: Facing left  - crystal flash - frame Eh
; D8h: Facing left  - crystal flash ending - frame 3
; E1h: Facing left  - landing from normal jump - aiming up - frame 0
; E3h: Facing left  - landing from normal jump - aiming up-left - frame 0
; E5h: Facing left  - landing from normal jump - aiming down-left - frame 0
; E7h: Facing left  - landing from normal jump - firing - frame 0
; E9h: Facing left  - Samus drained - crouching/falling - frame 7
; E9h: Facing left  - Samus drained - crouching/falling - frame Fh
; E9h: Facing left  - Samus drained - crouching/falling - frame 14h
; E9h: Facing left  - Samus drained - crouching/falling - frame 16h
; EBh: Facing left  - Samus drained - standing - frame 5
; F2h: Facing left  - crouching transition - aiming up - frame 0
; F4h: Facing left  - crouching transition - aiming up-left - frame 0
; F6h: Facing left  - crouching transition - aiming down-left - frame 0
; F8h: Facing left  - standing transition - aiming up - frame 0
; FAh: Facing left  - standing transition - aiming up-left - frame 0
; FCh: Facing left  - standing transition - aiming down-left - frame 0
$92:D2AF             dx 9DAF20, 00C0, 0080

; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frames 2..3
; C7h: Facing right - vertical shinespark windup - frames 2..3
; F0h: Facing right - grabbed by Draygon - moving - frame 5
$92:D2B6             dx 9DB060, 00E0, 0040

; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frames 2..3
; BEh: Facing left  - grabbed by Draygon - moving - frame 5
; C8h: Facing left  - vertical shinespark windup - frames 2..3
$92:D2BD             dx 9DB180, 00E0, 0040

; 13h: Facing right - normal jump - not aiming - not moving - gun extended - frame 0
; 15h: Facing right - normal jump - aiming up - frame 0
; 17h: Facing right - normal jump - aiming down - frame 0
; 29h: Facing right - falling - frame 0
; 29h: Facing right - falling - frame 5
; 2Bh: Facing right - falling - aiming up - frame 0
; 2Dh: Facing right - falling - aiming down - frame 0
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 4
; 50h: Facing right - damage boost - frame 1
; 51h: Facing right - normal jump - not aiming - moving forward - frame 0
; 67h: Facing right - falling - gun extended - frame 0
; 67h: Facing right - falling - gun extended - frame 5
; 69h: Facing right - normal jump - aiming up-right - frame 0
; 6Bh: Facing right - normal jump - aiming down-right - frame 0
; 6Dh: Facing right - falling - aiming up-right - frame 0
; 6Fh: Facing right - falling - aiming down-right - frame 0
; ACh: Unused. Facing right - grappling - in air - frame 0
; AEh: Unused. Facing right - grappling - in air - aiming down - frame 0
; B0h: Unused. Facing right - grappling - in air - aiming down-right - frame 0
; C7h: Facing right - vertical shinespark windup - frame 4
$92:D2C4             dx 9DB2A0, 00A0, 0080

; 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frame 0
; 16h: Facing left  - normal jump - aiming up - frame 0
; 18h: Facing left  - normal jump - aiming down - frame 0
; 2Ah: Facing left  - falling - frame 0
; 2Ah: Facing left  - falling - frame 5
; 2Ch: Facing left  - falling - aiming up - frame 0
; 2Eh: Facing left  - falling - aiming down - frame 0
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 4
; 4Fh: Facing left  - damage boost - frame 1
; 52h: Facing left  - normal jump - not aiming - moving forward - frame 0
; 68h: Facing left  - falling - gun extended - frame 0
; 68h: Facing left  - falling - gun extended - frame 5
; 6Ah: Facing left  - normal jump - aiming up-left - frame 0
; 6Ch: Facing left  - normal jump - aiming down-left - frame 0
; 6Eh: Facing left  - falling - aiming up-left - frame 0
; 70h: Facing left  - falling - aiming down-left - frame 0
; ADh: Unused. Facing left  - grappling - in air - frame 0
; AFh: Unused. Facing left  - grappling - in air - aiming down - frame 0
; B1h: Unused. Facing left  - grappling - in air - aiming down-left - frame 0
; C8h: Facing left  - vertical shinespark windup - frame 4
$92:D2CB             dx 9DB3C0, 00A0, 0080

; 29h: Facing right - falling - frames 1..2
; 2Bh: Facing right - falling - aiming up - frame 1
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 5
; 53h: Facing right - knockback - frame 0
; 67h: Facing right - falling - gun extended - frames 1..2
; 6Dh: Facing right - falling - aiming up-right - frame 1
; 6Fh: Facing right - falling - aiming down-right - frame 1
; C7h: Facing right - vertical shinespark windup - frame 5
; D7h: Facing right - crystal flash ending - frame 4
; E8h: Facing right - Samus drained - crouching/falling - frames 3..7
; F0h: Facing right - grabbed by Draygon - moving - frame 0
; F0h: Facing right - grabbed by Draygon - moving - frame 3
$92:D2D2             dx 9DB4E0, 0080, 0080

; 2Ah: Facing left  - falling - frames 1..2
; 2Ch: Facing left  - falling - aiming up - frame 1
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 5
; 54h: Facing left  - knockback - frame 0
; 68h: Facing left  - falling - gun extended - frames 1..2
; 6Eh: Facing left  - falling - aiming up-left - frame 1
; 70h: Facing left  - falling - aiming down-left - frame 1
; BEh: Facing left  - grabbed by Draygon - moving - frame 0
; BEh: Facing left  - grabbed by Draygon - moving - frame 3
; C8h: Facing left  - vertical shinespark windup - frame 5
; D8h: Facing left  - crystal flash ending - frame 4
; E9h: Facing left  - Samus drained - crouching/falling - frames 2..6
$92:D2D9             dx 9DB5E0, 0080, 0080

; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 1
; C7h: Facing right - vertical shinespark windup - frame 1
; F0h: Facing right - grabbed by Draygon - moving - frame 4
$92:D2E0             dx 9DB6E0, 00C0, 0040

; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 1
; BEh: Facing left  - grabbed by Draygon - moving - frame 4
; C8h: Facing left  - vertical shinespark windup - frame 1
$92:D2E7             dx 9DB7E0, 00C0, 0040

; Unused
$92:D2EE             dx 9DB8E0, 0020, 0000

; 17h: Facing right - normal jump - aiming down - frame 1
; 2Dh: Facing right - falling - aiming down - frame 1
; AEh: Unused. Facing right - grappling - in air - aiming down - frame 1
$92:D2F5             dx 9DB900, 00E0, 0040

; 18h: Facing left  - normal jump - aiming down - frame 1
; 2Eh: Facing left  - falling - aiming down - frame 1
; AFh: Unused. Facing left  - grappling - in air - aiming down - frame 1
$92:D2FC             dx 9DBA20, 00E0, 0040

; 65h: Unused. Related to movement type Dh - frame 0
; 83h: Facing right - wall jump - frame 0
$92:D303             dx 9DBB40, 0100, 0040

; 66h: Unused. Related to movement type Dh - frame 0
; 84h: Facing left  - wall jump - frame 0
$92:D30A             dx 9DBC80, 00C0, 0040

; 49h: Facing left  - moonwalk - frame 2
; 63h: Unused. Related to movement type Dh - frame 0
$92:D311             dx 9DBD80, 00A0, 0080

; 49h: Facing left  - moonwalk - frame 5
; 64h: Unused. Related to movement type Dh - frame 0
$92:D318             dx 9DBEA0, 00A0, 0080

; 4Ah: Facing right - moonwalk - frame 2
; 75h: Facing left  - moonwalk - aiming up-left - frame 2
; 76h: Facing right - moonwalk - aiming up-right - frame 2
; 77h: Facing left  - moonwalk - aiming down-left - frame 2
; 78h: Facing right - moonwalk - aiming down-right - frame 2
$92:D31F             dx 9DBFC0, 00A0, 0080

; 4Ah: Facing right - moonwalk - frame 5
; 75h: Facing left  - moonwalk - aiming up-left - frame 5
; 76h: Facing right - moonwalk - aiming up-right - frame 5
; 77h: Facing left  - moonwalk - aiming down-left - frame 5
; 78h: Facing right - moonwalk - aiming down-right - frame 5
$92:D326             dx 9DC0E0, 00A0, 0080

; 13h: Facing right - normal jump - not aiming - not moving - gun extended - frame 1
; 19h: Facing right - spin jump - frame 0
; 1Bh: Facing right - space jump - frame 0
; 20h: Unused - frame 0
; 21h: Unused - frame 0
; 22h: Unused - frame 0
; 23h: Unused - frame 0
; 24h: Unused - frame 0
; 29h: Facing right - falling - frame 6
; 2Bh: Facing right - falling - aiming up - frame 2
; 33h: Unused - frame 0
; 34h: Unused - frame 0
; 39h: Unused - frame 0
; 3Ah: Unused - frame 0
; 42h: Unused - frame 0
; 50h: Facing right - damage boost - frame 9
; 51h: Facing right - normal jump - not aiming - moving forward - frame 1
; 67h: Facing right - falling - gun extended - frame 6
; 6Bh: Facing right - normal jump - aiming down-right - frame 1
; 6Dh: Facing right - falling - aiming up-right - frame 2
; 6Fh: Facing right - falling - aiming down-right - frame 2
; 81h: Facing right - screw attack - frame 0
; 83h: Facing right - wall jump - frame 1
; A6h: Facing right - landing from spin jump - frame 0
; ACh: Unused. Facing right - grappling - in air - frame 1
; B0h: Unused. Facing right - grappling - in air - aiming down-right - frame 1
; F0h: Facing right - grabbed by Draygon - moving - frame 2
$92:D32D             dx 9DC200, 00E0, 0080

; 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frame 1
; 1Ah: Facing left  - spin jump - frame 0
; 1Ch: Facing left  - space jump - frame 0
; 2Ah: Facing left  - falling - frame 6
; 2Ch: Facing left  - falling - aiming up - frame 2
; 4Fh: Facing left  - damage boost - frame 9
; 52h: Facing left  - normal jump - not aiming - moving forward - frame 1
; 68h: Facing left  - falling - gun extended - frame 6
; 6Ch: Facing left  - normal jump - aiming down-left - frame 1
; 6Eh: Facing left  - falling - aiming up-left - frame 2
; 70h: Facing left  - falling - aiming down-left - frame 2
; 82h: Facing left  - screw attack - frame 0
; 84h: Facing left  - wall jump - frame 1
; A7h: Facing left  - landing from spin jump - frame 0
; ADh: Unused. Facing left  - grappling - in air - frame 1
; B1h: Unused. Facing left  - grappling - in air - aiming down-left - frame 1
; BEh: Facing left  - grabbed by Draygon - moving - frame 2
; E9h: Facing left  - Samus drained - crouching/falling - frame Eh
; E9h: Facing left  - Samus drained - crouching/falling - frame 13h
; E9h: Facing left  - Samus drained - crouching/falling - frame 17h
$92:D334             dx 9DC360, 00E0, 0080

; 53h: Facing right - knockback - frame 1
; D7h: Facing right - crystal flash ending - frame 5
; ECh: Facing right - grabbed by Draygon - not moving - not aiming - frame 0
; EDh: Facing right - grabbed by Draygon - not moving - aiming up-right - frame 0
; EEh: Facing right - grabbed by Draygon - firing - frame 0
; EFh: Facing right - grabbed by Draygon - not moving - aiming down-right - frame 0
; F0h: Facing right - grabbed by Draygon - moving - frame 1
$92:D33B             dx 9DC4C0, 00C0, 0080

; 54h: Facing left  - knockback - frame 1
; BAh: Facing left  - grabbed by Draygon - not moving - not aiming - frame 0
; BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left - frame 0
; BCh: Facing left  - grabbed by Draygon - firing - frame 0
; BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left - frame 0
; BEh: Facing left  - grabbed by Draygon - moving - frame 1
; D8h: Facing left  - crystal flash ending - frame 5
$92:D342             dx 9DC600, 00C0, 0080

; Unused
$92:D349             dx 9DC740, 0080, 0080

; E9h: Facing left  - Samus drained - crouching/falling - frames 8..Bh
; E9h: Facing left  - Samus drained - crouching/falling - frame 1Ah
; E9h: Facing left  - Samus drained - crouching/falling - frame 1Dh
; EBh: Facing left  - Samus drained - standing - frames 0..3
$92:D350             dx 9DC840, 0060, 0040

; E8h: Facing right - Samus drained - crouching/falling - frames 8..Bh
; EAh: Facing right - Samus drained - standing - frames 0..3
$92:D357             dx 9DC8E0, 0060, 0040
}


;;; $D35E: Samus bottom tiles - set 2 (facing clockwise - grappling - in air - upside up) ;;;
{
; 5Dh: Unused - frames 17h..19h
; 5Eh: Unused - frames 17h..19h
; 5Fh: Unused - frames 17h..19h
; 60h: Unused - frames 17h..19h
; 61h: Unused - frames 17h..19h
; B2h: Facing clockwise     - grapple - in air - frames 17h..19h
$92:D35E             dx 9F8000, 0080, 0040

; 5Dh: Unused - frames 15h..16h
; 5Eh: Unused - frames 15h..16h
; 5Fh: Unused - frames 15h..16h
; 60h: Unused - frames 15h..16h
; 61h: Unused - frames 15h..16h
; B2h: Facing clockwise     - grapple - in air - frames 15h..16h
$92:D365             dx 9F80C0, 00E0, 0040

; 5Dh: Unused - frames 13h..14h
; 5Eh: Unused - frames 13h..14h
; 5Fh: Unused - frames 13h..14h
; 60h: Unused - frames 13h..14h
; 61h: Unused - frames 13h..14h
; B2h: Facing clockwise     - grapple - in air - frames 13h..14h
$92:D36C             dx 9F81E0, 00A0, 0080

; 5Dh: Unused - frame 12h
; 5Eh: Unused - frame 12h
; 5Fh: Unused - frame 12h
; 60h: Unused - frame 12h
; 61h: Unused - frame 12h
; B2h: Facing clockwise     - grapple - in air - frame 12h
$92:D373             dx 9F8300, 00A0, 0040

; 5Dh: Unused - frame 11h
; 5Eh: Unused - frame 11h
; 5Fh: Unused - frame 11h
; 60h: Unused - frame 11h
; 61h: Unused - frame 11h
; B2h: Facing clockwise     - grapple - in air - frame 11h
$92:D37A             dx 9F83E0, 00C0, 0040

; 5Dh: Unused - frame 10h
; 5Eh: Unused - frame 10h
; 5Fh: Unused - frame 10h
; 60h: Unused - frame 10h
; 61h: Unused - frame 10h
; B2h: Facing clockwise     - grapple - in air - frame 10h
$92:D381             dx 9F84E0, 00C0, 0040

; 5Dh: Unused - frame Fh
; 5Eh: Unused - frame Fh
; 5Fh: Unused - frame Fh
; 60h: Unused - frame Fh
; 61h: Unused - frame Fh
; B2h: Facing clockwise     - grapple - in air - frame Fh
$92:D388             dx 9F85E0, 0080, 0040

; 5Dh: Unused - frame Eh
; 5Eh: Unused - frame Eh
; 5Fh: Unused - frame Eh
; 60h: Unused - frame Eh
; 61h: Unused - frame Eh
; B2h: Facing clockwise     - grapple - in air - frame Eh
$92:D38F             dx 9F86A0, 00A0, 0040

; 5Dh: Unused - frames Ch..Dh
; 5Eh: Unused - frames Ch..Dh
; 5Fh: Unused - frames Ch..Dh
; 60h: Unused - frames Ch..Dh
; 61h: Unused - frames Ch..Dh
; B2h: Facing clockwise     - grapple - in air - frames Ch..Dh
$92:D396             dx 9F8780, 00A0, 0040

; 5Dh: Unused - frames Ah..Bh
; 5Eh: Unused - frames Ah..Bh
; 5Fh: Unused - frames Ah..Bh
; 60h: Unused - frames Ah..Bh
; 61h: Unused - frames Ah..Bh
; B2h: Facing clockwise     - grapple - in air - frames Ah..Bh
$92:D39D             dx 9F8860, 00C0, 0040

; Unused
$92:D3A4             dx 9F8960, 00A0, 0080

; 5Dh: Unused - frame 40h
; 5Eh: Unused - frame 40h
; 5Fh: Unused - frame 40h
; 60h: Unused - frame 40h
; 61h: Unused - frame 40h
; B2h: Facing clockwise     - grapple - in air - frame 40h
$92:D3AB             dx 9F8A80, 0080, 0080

; 5Dh: Unused - frame 41h
; 5Eh: Unused - frame 41h
; 5Fh: Unused - frame 41h
; 60h: Unused - frame 41h
; 61h: Unused - frame 41h
; B2h: Facing clockwise     - grapple - in air - frame 41h
$92:D3B2             dx 9F8B80, 0080, 0080

; 5Dh: Unused - frames 37h..39h
; 5Eh: Unused - frames 37h..39h
; 5Fh: Unused - frames 37h..39h
; 60h: Unused - frames 37h..39h
; 61h: Unused - frames 37h..39h
; B2h: Facing clockwise     - grapple - in air - frames 37h..39h
$92:D3B9             dx 9F8C80, 0080, 0080

; 5Dh: Unused - frames 35h..36h
; 5Eh: Unused - frames 35h..36h
; 5Fh: Unused - frames 35h..36h
; 60h: Unused - frames 35h..36h
; 61h: Unused - frames 35h..36h
; B2h: Facing clockwise     - grapple - in air - frames 35h..36h
$92:D3C0             dx 9F8D80, 00A0, 0040

; 5Dh: Unused - frames 33h..34h
; 5Eh: Unused - frames 33h..34h
; 5Fh: Unused - frames 33h..34h
; 60h: Unused - frames 33h..34h
; 61h: Unused - frames 33h..34h
; B2h: Facing clockwise     - grapple - in air - frames 33h..34h
$92:D3C7             dx 9F8E60, 0080, 0080

; 5Dh: Unused - frame 32h
; 5Eh: Unused - frame 32h
; 5Fh: Unused - frame 32h
; 60h: Unused - frame 32h
; 61h: Unused - frame 32h
; B2h: Facing clockwise     - grapple - in air - frame 32h
$92:D3CE             dx 9F8F60, 0080, 0080

; 5Dh: Unused - frame 31h
; 5Eh: Unused - frame 31h
; 5Fh: Unused - frame 31h
; 60h: Unused - frame 31h
; 61h: Unused - frame 31h
; B2h: Facing clockwise     - grapple - in air - frame 31h
$92:D3D5             dx 9F9060, 00A0, 0040

; 5Dh: Unused - frame 30h
; 5Eh: Unused - frame 30h
; 5Fh: Unused - frame 30h
; 60h: Unused - frame 30h
; 61h: Unused - frame 30h
; B2h: Facing clockwise     - grapple - in air - frame 30h
$92:D3DC             dx 9F9140, 0080, 0080

; 5Dh: Unused - frame 2Fh
; 5Eh: Unused - frame 2Fh
; 5Fh: Unused - frame 2Fh
; 60h: Unused - frame 2Fh
; 61h: Unused - frame 2Fh
; B2h: Facing clockwise     - grapple - in air - frame 2Fh
$92:D3E3             dx 9F9240, 0080, 0080

; 5Dh: Unused - frame 2Eh
; 5Eh: Unused - frame 2Eh
; 5Fh: Unused - frame 2Eh
; 60h: Unused - frame 2Eh
; 61h: Unused - frame 2Eh
; B2h: Facing clockwise     - grapple - in air - frame 2Eh
$92:D3EA             dx 9F9340, 0080, 0080

; 5Dh: Unused - frames 2Ch..2Dh
; 5Eh: Unused - frames 2Ch..2Dh
; 5Fh: Unused - frames 2Ch..2Dh
; 60h: Unused - frames 2Ch..2Dh
; 61h: Unused - frames 2Ch..2Dh
; B2h: Facing clockwise     - grapple - in air - frames 2Ch..2Dh
$92:D3F1             dx 9F9440, 00C0, 0080

; 5Dh: Unused - frames 2Ah..2Bh
; 5Eh: Unused - frames 2Ah..2Bh
; 5Fh: Unused - frames 2Ah..2Bh
; 60h: Unused - frames 2Ah..2Bh
; 61h: Unused - frames 2Ah..2Bh
; B2h: Facing clockwise     - grapple - in air - frames 2Ah..2Bh
$92:D3F8             dx 9F9580, 0080, 0080

; Unused
$92:D3FF             dx 9F9680, 0080, 0080
}


;;; $D406: Samus bottom tiles - set 4 (facing clockwise - grappling - in air - upside down) ;;;
{
; 5Dh: Unused - frames 7..9
; 5Eh: Unused - frames 7..9
; 5Fh: Unused - frames 7..9
; 60h: Unused - frames 7..9
; 61h: Unused - frames 7..9
; B2h: Facing clockwise     - grapple - in air - frames 7..9
$92:D406             dx 9F9780, 0080, 0040

; 5Dh: Unused - frames 5..6
; 5Eh: Unused - frames 5..6
; 5Fh: Unused - frames 5..6
; 60h: Unused - frames 5..6
; 61h: Unused - frames 5..6
; B2h: Facing clockwise     - grapple - in air - frames 5..6
$92:D40D             dx 9F9840, 00E0, 0040

; 5Dh: Unused - frames 3..4
; 5Eh: Unused - frames 3..4
; 5Fh: Unused - frames 3..4
; 60h: Unused - frames 3..4
; 61h: Unused - frames 3..4
; B2h: Facing clockwise     - grapple - in air - frames 3..4
$92:D414             dx 9F9960, 00A0, 0080

; 5Dh: Unused - frame 2
; 5Eh: Unused - frame 2
; 5Fh: Unused - frame 2
; 60h: Unused - frame 2
; 61h: Unused - frame 2
; B2h: Facing clockwise     - grapple - in air - frame 2
$92:D41B             dx 9F9A80, 00A0, 0040

; 5Dh: Unused - frame 1
; 5Eh: Unused - frame 1
; 5Fh: Unused - frame 1
; 60h: Unused - frame 1
; 61h: Unused - frame 1
; B2h: Facing clockwise     - grapple - in air - frame 1
$92:D422             dx 9F9B60, 00C0, 0040

; 5Dh: Unused - frame 0
; 5Eh: Unused - frame 0
; 5Fh: Unused - frame 0
; 60h: Unused - frame 0
; 61h: Unused - frame 0
; B2h: Facing clockwise     - grapple - in air - frame 0
$92:D429             dx 9F9C60, 00C0, 0040

; 5Dh: Unused - frame 1Fh
; 5Eh: Unused - frame 1Fh
; 5Fh: Unused - frame 1Fh
; 60h: Unused - frame 1Fh
; 61h: Unused - frame 1Fh
; B2h: Facing clockwise     - grapple - in air - frame 1Fh
$92:D430             dx 9F9D60, 0080, 0040

; 5Dh: Unused - frame 1Eh
; 5Eh: Unused - frame 1Eh
; 5Fh: Unused - frame 1Eh
; 60h: Unused - frame 1Eh
; 61h: Unused - frame 1Eh
; B2h: Facing clockwise     - grapple - in air - frame 1Eh
$92:D437             dx 9F9E20, 00A0, 0040

; 5Dh: Unused - frames 1Ch..1Dh
; 5Eh: Unused - frames 1Ch..1Dh
; 5Fh: Unused - frames 1Ch..1Dh
; 60h: Unused - frames 1Ch..1Dh
; 61h: Unused - frames 1Ch..1Dh
; B2h: Facing clockwise     - grapple - in air - frames 1Ch..1Dh
$92:D43E             dx 9F9F00, 00A0, 0040

; 5Dh: Unused - frames 1Ah..1Bh
; 5Eh: Unused - frames 1Ah..1Bh
; 5Fh: Unused - frames 1Ah..1Bh
; 60h: Unused - frames 1Ah..1Bh
; 61h: Unused - frames 1Ah..1Bh
; B2h: Facing clockwise     - grapple - in air - frames 1Ah..1Bh
$92:D445             dx 9F9FE0, 00C0, 0040

; Unused
$92:D44C             dx 9FA0E0, 00A0, 0080

; Unused
$92:D453             dx 9FA200, 0080, 0080

; Unused
$92:D45A             dx 9FA300, 0080, 0080

; 5Dh: Unused - frames 27h..29h
; 5Eh: Unused - frames 27h..29h
; 5Fh: Unused - frames 27h..29h
; 60h: Unused - frames 27h..29h
; 61h: Unused - frames 27h..29h
; B2h: Facing clockwise     - grapple - in air - frames 27h..29h
$92:D461             dx 9FA400, 0080, 0080

; 5Dh: Unused - frames 25h..26h
; 5Eh: Unused - frames 25h..26h
; 5Fh: Unused - frames 25h..26h
; 60h: Unused - frames 25h..26h
; 61h: Unused - frames 25h..26h
; B2h: Facing clockwise     - grapple - in air - frames 25h..26h
$92:D468             dx 9FA500, 00A0, 0040

; 5Dh: Unused - frames 23h..24h
; 5Eh: Unused - frames 23h..24h
; 5Fh: Unused - frames 23h..24h
; 60h: Unused - frames 23h..24h
; 61h: Unused - frames 23h..24h
; B2h: Facing clockwise     - grapple - in air - frames 23h..24h
$92:D46F             dx 9FA5E0, 0080, 0080

; 5Dh: Unused - frame 22h
; 5Eh: Unused - frame 22h
; 5Fh: Unused - frame 22h
; 60h: Unused - frame 22h
; 61h: Unused - frame 22h
; B2h: Facing clockwise     - grapple - in air - frame 22h
$92:D476             dx 9FA6E0, 0080, 0080

; 5Dh: Unused - frame 21h
; 5Eh: Unused - frame 21h
; 5Fh: Unused - frame 21h
; 60h: Unused - frame 21h
; 61h: Unused - frame 21h
; B2h: Facing clockwise     - grapple - in air - frame 21h
$92:D47D             dx 9FA7E0, 00A0, 0040

; 5Dh: Unused - frame 20h
; 5Dh: Unused - frame 3Fh
; 5Eh: Unused - frame 20h
; 5Eh: Unused - frame 3Fh
; 5Fh: Unused - frame 20h
; 5Fh: Unused - frame 3Fh
; 60h: Unused - frame 20h
; 60h: Unused - frame 3Fh
; 61h: Unused - frame 20h
; 61h: Unused - frame 3Fh
; B2h: Facing clockwise     - grapple - in air - frame 20h
; B2h: Facing clockwise     - grapple - in air - frame 3Fh
$92:D484             dx 9FA8C0, 0080, 0080

; 5Dh: Unused - frame 3Eh
; 5Eh: Unused - frame 3Eh
; 5Fh: Unused - frame 3Eh
; 60h: Unused - frame 3Eh
; 61h: Unused - frame 3Eh
; B2h: Facing clockwise     - grapple - in air - frame 3Eh
$92:D48B             dx 9FA9C0, 0080, 0080

; 5Dh: Unused - frames 3Ch..3Dh
; 5Eh: Unused - frames 3Ch..3Dh
; 5Fh: Unused - frames 3Ch..3Dh
; 60h: Unused - frames 3Ch..3Dh
; 61h: Unused - frames 3Ch..3Dh
; B2h: Facing clockwise     - grapple - in air - frames 3Ch..3Dh
$92:D492             dx 9FAAC0, 0080, 0080

; 5Dh: Unused - frames 3Ah..3Bh
; 5Eh: Unused - frames 3Ah..3Bh
; 5Fh: Unused - frames 3Ah..3Bh
; 60h: Unused - frames 3Ah..3Bh
; 61h: Unused - frames 3Ah..3Bh
; B2h: Facing clockwise     - grapple - in air - frames 3Ah..3Bh
$92:D499             dx 9FABC0, 0080, 0080

; Unused
$92:D4A0             dx 9FACC0, 0080, 0080
}


;;; $D4A7: Samus bottom tiles - set 5 (facing anticlockwise - grappling - in air - upside up) ;;;
{
; 62h: Unused - frames 7..9
; B3h: Facing anticlockwise - grapple - in air - frames 7..9
$92:D4A7             dx 9FADC0, 0080, 0040

; 62h: Unused - frames Ah..Bh
; B3h: Facing anticlockwise - grapple - in air - frames Ah..Bh
$92:D4AE             dx 9FAE80, 00E0, 0040

; 62h: Unused - frames Ch..Dh
; B3h: Facing anticlockwise - grapple - in air - frames Ch..Dh
$92:D4B5             dx 9FAFA0, 00A0, 0080

; 62h: Unused - frame Eh
; B3h: Facing anticlockwise - grapple - in air - frame Eh
$92:D4BC             dx 9FB0C0, 00A0, 0040

; 62h: Unused - frame Fh
; B3h: Facing anticlockwise - grapple - in air - frame Fh
$92:D4C3             dx 9FB1A0, 00C0, 0040

; 62h: Unused - frame 10h
; B3h: Facing anticlockwise - grapple - in air - frame 10h
$92:D4CA             dx 9FB2A0, 00C0, 0040

; 62h: Unused - frame 11h
; B3h: Facing anticlockwise - grapple - in air - frame 11h
$92:D4D1             dx 9FB3A0, 0080, 0040

; 62h: Unused - frame 12h
; B3h: Facing anticlockwise - grapple - in air - frame 12h
$92:D4D8             dx 9FB460, 00A0, 0040

; 62h: Unused - frames 13h..14h
; B3h: Facing anticlockwise - grapple - in air - frames 13h..14h
$92:D4DF             dx 9FB540, 00A0, 0040

; 62h: Unused - frames 15h..16h
; B3h: Facing anticlockwise - grapple - in air - frames 15h..16h
$92:D4E6             dx 9FB620, 00C0, 0040

; Unused
$92:D4ED             dx 9FB720, 00A0, 0080

; 62h: Unused - frame 40h
; B3h: Facing anticlockwise - grapple - in air - frame 40h
$92:D4F4             dx 9FB840, 0080, 0080

; 62h: Unused - frame 41h
; B3h: Facing anticlockwise - grapple - in air - frame 41h
$92:D4FB             dx 9FB940, 0080, 0080

; 62h: Unused - frames 27h..29h
; B3h: Facing anticlockwise - grapple - in air - frames 27h..29h
$92:D502             dx 9FBA40, 0080, 0080

; 62h: Unused - frames 2Ah..2Bh
; B3h: Facing anticlockwise - grapple - in air - frames 2Ah..2Bh
$92:D509             dx 9FBB40, 00A0, 0040

; 62h: Unused - frames 2Ch..2Dh
; B3h: Facing anticlockwise - grapple - in air - frames 2Ch..2Dh
$92:D510             dx 9FBC20, 0080, 0080

; 62h: Unused - frame 2Eh
; B3h: Facing anticlockwise - grapple - in air - frame 2Eh
$92:D517             dx 9FBD20, 0080, 0080

; 62h: Unused - frame 2Fh
; B3h: Facing anticlockwise - grapple - in air - frame 2Fh
$92:D51E             dx 9FBE20, 00A0, 0040

; 62h: Unused - frame 30h
; B3h: Facing anticlockwise - grapple - in air - frame 30h
$92:D525             dx 9FBF00, 0080, 0080

; 62h: Unused - frame 31h
; B3h: Facing anticlockwise - grapple - in air - frame 31h
$92:D52C             dx 9FC000, 0080, 0080

; 62h: Unused - frame 32h
; B3h: Facing anticlockwise - grapple - in air - frame 32h
$92:D533             dx 9FC100, 0080, 0080

; 62h: Unused - frames 33h..34h
; B3h: Facing anticlockwise - grapple - in air - frames 33h..34h
$92:D53A             dx 9FC200, 00C0, 0080

; 62h: Unused - frames 35h..36h
; B3h: Facing anticlockwise - grapple - in air - frames 35h..36h
$92:D541             dx 9FC340, 0080, 0080

; Unused
$92:D548             dx 9FC440, 0080, 0080
}


;;; $D54F: Samus bottom tiles - set 6 (facing anticlockwise - grappling - in air - upside down) ;;;
{
; 62h: Unused - frames 17h..19h
; B3h: Facing anticlockwise - grapple - in air - frames 17h..19h
$92:D54F             dx 9FC540, 0080, 0040

; 62h: Unused - frames 1Ah..1Bh
; B3h: Facing anticlockwise - grapple - in air - frames 1Ah..1Bh
$92:D556             dx 9FC600, 00E0, 0040

; 62h: Unused - frames 1Ch..1Dh
; B3h: Facing anticlockwise - grapple - in air - frames 1Ch..1Dh
$92:D55D             dx 9FC720, 00A0, 0080

; 62h: Unused - frame 1Eh
; B3h: Facing anticlockwise - grapple - in air - frame 1Eh
$92:D564             dx 9FC840, 00A0, 0040

; 62h: Unused - frame 1Fh
; B3h: Facing anticlockwise - grapple - in air - frame 1Fh
$92:D56B             dx 9FC920, 00C0, 0040

; 62h: Unused - frame 0
; B3h: Facing anticlockwise - grapple - in air - frame 0
$92:D572             dx 9FCA20, 00C0, 0040

; 62h: Unused - frame 1
; B3h: Facing anticlockwise - grapple - in air - frame 1
$92:D579             dx 9FCB20, 0080, 0040

; 62h: Unused - frame 2
; B3h: Facing anticlockwise - grapple - in air - frame 2
$92:D580             dx 9FCBE0, 00A0, 0040

; 62h: Unused - frames 3..4
; B3h: Facing anticlockwise - grapple - in air - frames 3..4
$92:D587             dx 9FCCC0, 00A0, 0040

; 62h: Unused - frames 5..6
; B3h: Facing anticlockwise - grapple - in air - frames 5..6
$92:D58E             dx 9FCDA0, 00C0, 0040

; Unused
$92:D595             dx 9FCEA0, 00A0, 0080

; Unused
$92:D59C             dx 9FCFC0, 0080, 0080

; Unused
$92:D5A3             dx 9FD0C0, 0080, 0080

; 62h: Unused - frames 37h..39h
; B3h: Facing anticlockwise - grapple - in air - frames 37h..39h
$92:D5AA             dx 9FD1C0, 0080, 0080

; 62h: Unused - frames 3Ah..3Bh
; B3h: Facing anticlockwise - grapple - in air - frames 3Ah..3Bh
$92:D5B1             dx 9FD2C0, 00A0, 0040

; 62h: Unused - frames 3Ch..3Dh
; B3h: Facing anticlockwise - grapple - in air - frames 3Ch..3Dh
$92:D5B8             dx 9FD3A0, 0080, 0080

; 62h: Unused - frame 3Eh
; B3h: Facing anticlockwise - grapple - in air - frame 3Eh
$92:D5BF             dx 9FD4A0, 0080, 0080

; 62h: Unused - frame 3Fh
; B3h: Facing anticlockwise - grapple - in air - frame 3Fh
$92:D5C6             dx 9FD5A0, 00A0, 0040

; 62h: Unused - frame 20h
; B3h: Facing anticlockwise - grapple - in air - frame 20h
$92:D5CD             dx 9FD680, 0080, 0080

; 62h: Unused - frame 21h
; B3h: Facing anticlockwise - grapple - in air - frame 21h
$92:D5D4             dx 9FD780, 0080, 0080

; 62h: Unused - frame 22h
; B3h: Facing anticlockwise - grapple - in air - frame 22h
$92:D5DB             dx 9FD880, 0080, 0080

; 62h: Unused - frames 23h..24h
; B3h: Facing anticlockwise - grapple - in air - frames 23h..24h
$92:D5E2             dx 9FD980, 0080, 0080

; 62h: Unused - frames 25h..26h
; B3h: Facing anticlockwise - grapple - in air - frames 25h..26h
$92:D5E9             dx 9FDA80, 0080, 0080
}


;;; $D5F0: Samus bottom tiles - set 8 (facing forward) ;;;
{
; 0: Facing forward - power suit - frames 2..5Fh
$92:D5F0             dx 9BEA00, 0100, 0100

; 9Bh: Facing forward - varia/gravity suit - frames 2..5Fh
$92:D5F7             dx 9BEC00, 0100, 0100

; Unused
$92:D5FE             dx 9BEE00, 0020, 0000
}


;;; $D605: Samus bottom tiles - set Ah (general) ;;;
{
; 3: Facing right - aiming up - frames 0..1
; 5: Facing right - aiming up-right - frame 0
; 7: Facing right - aiming down-right - frame 0
; AAh: Facing right - grappling - aiming down-right - frame 0
; CFh: Facing right - ran into a wall - aiming up-right - frame 0
; D1h: Facing right - ran into a wall - aiming down-right - frame 0
$92:D605             dx 9FEB00, 00C0, 0080

; 4: Facing left  - aiming up - frames 0..1
; 6: Facing left  - aiming up-left - frame 0
; 8: Facing left  - aiming down-left - frame 0
; ABh: Facing left  - grappling - aiming down-left - frame 0
; D0h: Facing left  - ran into a wall - aiming up-left - frame 0
; D2h: Facing left  - ran into a wall - aiming down-left - frame 0
; E9h: Facing left  - Samus drained - crouching/falling - frame 10h
; E9h: Facing left  - Samus drained - crouching/falling - frame 15h
$92:D60C             dx 9FEC40, 00C0, 0080
}


;;; $D613: Samus top tiles - set Ah (morph ball, spin jump, screw attack sparks) ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 0
; 1Eh: Moving right - morph ball - no springball - on ground - frame 0
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 7
; 31h: Facing right - morph ball - no springball - in air - frame 0
; 32h: Facing left  - morph ball - no springball - in air - frame 0
; 3Fh: Unused - frame 0
; 40h: Unused - frame 0
; 41h: Facing left  - morph ball - no springball - on ground - frame 7
; 79h: Facing right - morph ball - spring ball - on ground - frame 0
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 7
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 0
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 7
; 7Dh: Facing right - morph ball - spring ball - falling - frame 0
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 7
; 7Fh: Facing right - morph ball - spring ball - in air - frame 0
; 80h: Facing left  - morph ball - spring ball - in air - frame 7
; C5h: Unused - frame 7
; D7h: Facing right - crystal flash ending - frame 0
; DFh: Unused - frame 7
; E8h: Facing right - Samus drained - crouching/falling - frame 0
$92:D613             dx 9C8000, 0060, 0040

; 1Dh: Facing right - morph ball - no springball - on ground - frame 2
; 1Eh: Moving right - morph ball - no springball - on ground - frame 2
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 5
; 31h: Facing right - morph ball - no springball - in air - frame 2
; 32h: Facing left  - morph ball - no springball - in air - frame 2
; 3Fh: Unused - frame 2
; 40h: Unused - frame 2
; 41h: Facing left  - morph ball - no springball - on ground - frame 5
; 79h: Facing right - morph ball - spring ball - on ground - frame 2
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 5
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 2
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 5
; 7Dh: Facing right - morph ball - spring ball - falling - frame 2
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 5
; 7Fh: Facing right - morph ball - spring ball - in air - frame 2
; 80h: Facing left  - morph ball - spring ball - in air - frame 5
; C5h: Unused - frame 5
; DFh: Unused - frame 5
$92:D61A             dx 9C80A0, 0060, 0040

; 1Dh: Facing right - morph ball - no springball - on ground - frame 4
; 1Eh: Moving right - morph ball - no springball - on ground - frame 4
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 3
; 31h: Facing right - morph ball - no springball - in air - frame 4
; 32h: Facing left  - morph ball - no springball - in air - frame 4
; 3Fh: Unused - frame 4
; 40h: Unused - frame 4
; 41h: Facing left  - morph ball - no springball - on ground - frame 3
; 79h: Facing right - morph ball - spring ball - on ground - frame 4
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 3
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 4
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 3
; 7Dh: Facing right - morph ball - spring ball - falling - frame 4
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 3
; 7Fh: Facing right - morph ball - spring ball - in air - frame 4
; 80h: Facing left  - morph ball - spring ball - in air - frame 3
; C5h: Unused - frame 3
; DFh: Unused - frame 3
$92:D621             dx 9C8140, 0060, 0040

; 1Dh: Facing right - morph ball - no springball - on ground - frame 6
; 1Eh: Moving right - morph ball - no springball - on ground - frame 6
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 1
; 31h: Facing right - morph ball - no springball - in air - frame 6
; 32h: Facing left  - morph ball - no springball - in air - frame 6
; 3Fh: Unused - frame 6
; 40h: Unused - frame 6
; 41h: Facing left  - morph ball - no springball - on ground - frame 1
; 79h: Facing right - morph ball - spring ball - on ground - frame 6
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 1
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 6
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 1
; 7Dh: Facing right - morph ball - spring ball - falling - frame 6
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 1
; 7Fh: Facing right - morph ball - spring ball - in air - frame 6
; 80h: Facing left  - morph ball - spring ball - in air - frame 1
; C5h: Unused - frame 1
; DFh: Unused - frame 1
$92:D628             dx 9C81E0, 0060, 0040

; 1Dh: Facing right - morph ball - no springball - on ground - frame 1
; 1Eh: Moving right - morph ball - no springball - on ground - frame 1
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 6
; 31h: Facing right - morph ball - no springball - in air - frame 1
; 32h: Facing left  - morph ball - no springball - in air - frame 1
; 3Fh: Unused - frame 1
; 40h: Unused - frame 1
; 41h: Facing left  - morph ball - no springball - on ground - frame 6
; 79h: Facing right - morph ball - spring ball - on ground - frame 1
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 6
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 1
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 6
; 7Dh: Facing right - morph ball - spring ball - falling - frame 1
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 6
; 7Fh: Facing right - morph ball - spring ball - in air - frame 1
; 80h: Facing left  - morph ball - spring ball - in air - frame 6
; C5h: Unused - frame 6
; DFh: Unused - frame 6
$92:D62F             dx 9C8280, 00A0, 0000

; 1Dh: Facing right - morph ball - no springball - on ground - frame 3
; 1Eh: Moving right - morph ball - no springball - on ground - frame 3
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 4
; 31h: Facing right - morph ball - no springball - in air - frame 3
; 32h: Facing left  - morph ball - no springball - in air - frame 3
; 3Fh: Unused - frame 3
; 40h: Unused - frame 3
; 41h: Facing left  - morph ball - no springball - on ground - frame 4
; 79h: Facing right - morph ball - spring ball - on ground - frame 3
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 4
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 3
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 4
; 7Dh: Facing right - morph ball - spring ball - falling - frame 3
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 4
; 7Fh: Facing right - morph ball - spring ball - in air - frame 3
; 80h: Facing left  - morph ball - spring ball - in air - frame 4
; C5h: Unused - frame 4
; DFh: Unused - frame 4
$92:D636             dx 9C8320, 0060, 0040

; 1Dh: Facing right - morph ball - no springball - on ground - frame 5
; 1Eh: Moving right - morph ball - no springball - on ground - frame 5
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 2
; 31h: Facing right - morph ball - no springball - in air - frame 5
; 32h: Facing left  - morph ball - no springball - in air - frame 5
; 3Fh: Unused - frame 5
; 40h: Unused - frame 5
; 41h: Facing left  - morph ball - no springball - on ground - frame 2
; 79h: Facing right - morph ball - spring ball - on ground - frame 5
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 2
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 5
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 2
; 7Dh: Facing right - morph ball - spring ball - falling - frame 5
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 2
; 7Fh: Facing right - morph ball - spring ball - in air - frame 5
; 80h: Facing left  - morph ball - spring ball - in air - frame 2
; C5h: Unused - frame 2
; DFh: Unused - frame 2
$92:D63D             dx 9C83C0, 0060, 0040

; 1Dh: Facing right - morph ball - no springball - on ground - frame 7
; 1Eh: Moving right - morph ball - no springball - on ground - frame 7
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 0
; 31h: Facing right - morph ball - no springball - in air - frame 7
; 32h: Facing left  - morph ball - no springball - in air - frame 7
; 3Fh: Unused - frame 7
; 40h: Unused - frame 7
; 41h: Facing left  - morph ball - no springball - on ground - frame 0
; 79h: Facing right - morph ball - spring ball - on ground - frame 7
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 0
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 7
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 0
; 7Dh: Facing right - morph ball - spring ball - falling - frame 7
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 0
; 7Fh: Facing right - morph ball - spring ball - in air - frame 7
; 80h: Facing left  - morph ball - spring ball - in air - frame 0
; C5h: Unused - frame 0
; DFh: Unused - frame 0
$92:D644             dx 9C8460, 0060, 0040

; 19h: Facing right - spin jump - frame 1
; 1Ah: Facing left  - spin jump - frame 1
; 20h: Unused - frame 1
; 21h: Unused - frame 1
; 22h: Unused - frame 1
; 23h: Unused - frame 1
; 24h: Unused - frame 1
; 33h: Unused - frame 1
; 34h: Unused - frame 1
; 39h: Unused - frame 1
; 3Ah: Unused - frame 1
; 42h: Unused - frame 1
; 83h: Facing right - wall jump - frame 3
; 84h: Facing left  - wall jump - frame 3
$92:D64B             dx 9C8500, 0080, 0080

; 19h: Facing right - spin jump - frame 2
; 1Ah: Facing left  - spin jump - frame 2
; 20h: Unused - frame 2
; 21h: Unused - frame 2
; 22h: Unused - frame 2
; 23h: Unused - frame 2
; 24h: Unused - frame 2
; 33h: Unused - frame 2
; 34h: Unused - frame 2
; 39h: Unused - frame 2
; 3Ah: Unused - frame 2
; 42h: Unused - frame 2
; 4Fh: Facing left  - damage boost - frame 8
; 50h: Facing right - damage boost - frame 8
; 83h: Facing right - wall jump - frame 4
; 84h: Facing left  - wall jump - frame 4
$92:D652             dx 9C8600, 0100, 0100

; 19h: Facing right - spin jump - frame 3
; 1Ah: Facing left  - spin jump - frame 3
; 20h: Unused - frame 3
; 21h: Unused - frame 3
; 22h: Unused - frame 3
; 23h: Unused - frame 3
; 24h: Unused - frame 3
; 33h: Unused - frame 3
; 34h: Unused - frame 3
; 39h: Unused - frame 3
; 3Ah: Unused - frame 3
; 42h: Unused - frame 3
; 4Fh: Facing left  - damage boost - frame 7
; 50h: Facing right - damage boost - frame 7
; 83h: Facing right - wall jump - frame 5
; 84h: Facing left  - wall jump - frame 5
$92:D659             dx 9C8800, 0080, 0080

; 19h: Facing right - spin jump - frame 4
; 1Ah: Facing left  - spin jump - frame 4
; 20h: Unused - frame 4
; 21h: Unused - frame 4
; 22h: Unused - frame 4
; 23h: Unused - frame 4
; 24h: Unused - frame 4
; 33h: Unused - frame 4
; 34h: Unused - frame 4
; 39h: Unused - frame 4
; 3Ah: Unused - frame 4
; 42h: Unused - frame 4
; 4Fh: Facing left  - damage boost - frame 6
; 50h: Facing right - damage boost - frame 6
; 83h: Facing right - wall jump - frame 6
; 84h: Facing left  - wall jump - frame 6
$92:D660             dx 9C8900, 0100, 0100

; 19h: Facing right - spin jump - frame 5
; 1Ah: Facing left  - spin jump - frame 5
; 20h: Unused - frame 5
; 21h: Unused - frame 5
; 22h: Unused - frame 5
; 23h: Unused - frame 5
; 24h: Unused - frame 5
; 33h: Unused - frame 5
; 34h: Unused - frame 5
; 39h: Unused - frame 5
; 3Ah: Unused - frame 5
; 42h: Unused - frame 5
; 4Fh: Facing left  - damage boost - frame 5
; 50h: Facing right - damage boost - frame 5
; 83h: Facing right - wall jump - frame 7
; 84h: Facing left  - wall jump - frame 7
$92:D667             dx 9C8B00, 0080, 0080

; 19h: Facing right - spin jump - frame 6
; 1Ah: Facing left  - spin jump - frame 6
; 20h: Unused - frame 6
; 21h: Unused - frame 6
; 22h: Unused - frame 6
; 23h: Unused - frame 6
; 24h: Unused - frame 6
; 33h: Unused - frame 6
; 34h: Unused - frame 6
; 39h: Unused - frame 6
; 3Ah: Unused - frame 6
; 42h: Unused - frame 6
; 4Fh: Facing left  - damage boost - frame 4
; 50h: Facing right - damage boost - frame 4
; 83h: Facing right - wall jump - frame 8
; 84h: Facing left  - wall jump - frame 8
$92:D66E             dx 9C8C00, 0100, 0100

; 19h: Facing right - spin jump - frame 7
; 1Ah: Facing left  - spin jump - frame 7
; 20h: Unused - frame 7
; 21h: Unused - frame 7
; 22h: Unused - frame 7
; 23h: Unused - frame 7
; 24h: Unused - frame 7
; 33h: Unused - frame 7
; 34h: Unused - frame 7
; 39h: Unused - frame 7
; 3Ah: Unused - frame 7
; 42h: Unused - frame 7
; 4Fh: Facing left  - damage boost - frame 3
; 50h: Facing right - damage boost - frame 3
; 83h: Facing right - wall jump - frame 9
; 84h: Facing left  - wall jump - frame 9
$92:D675             dx 9C8E00, 0080, 0080

; 19h: Facing right - spin jump - frame 8
; 1Ah: Facing left  - spin jump - frame 8
; 20h: Unused - frame 8
; 21h: Unused - frame 8
; 22h: Unused - frame 8
; 23h: Unused - frame 8
; 24h: Unused - frame 8
; 33h: Unused - frame 8
; 34h: Unused - frame 8
; 39h: Unused - frame 8
; 3Ah: Unused - frame 8
; 42h: Unused - frame 8
; 4Fh: Facing left  - damage boost - frame 2
; 50h: Facing right - damage boost - frame 2
; 83h: Facing right - wall jump - frame Ah
; 84h: Facing left  - wall jump - frame Ah
$92:D67C             dx 9C8F00, 0100, 0100

; 65h: Unused. Related to movement type Dh - frame 1
; 66h: Unused. Related to movement type Dh - frame 1
; 81h: Facing right - screw attack - frames 1..3
; 82h: Facing left  - screw attack - frames 1..3
; 83h: Facing right - wall jump - frames 17h..19h
; 84h: Facing left  - wall jump - frames 17h..19h
$92:D683             dx 9C9100, 0100, 0040

; 65h: Unused. Related to movement type Dh - frame 2
; 66h: Unused. Related to movement type Dh - frame 2
; 81h: Facing right - screw attack - frames 7..9
; 82h: Facing left  - screw attack - frames 7..9
; 83h: Facing right - wall jump - frames 1Dh..1Fh
; 84h: Facing left  - wall jump - frames 1Dh..1Fh
$92:D68A             dx 9C9240, 0100, 0060

; 65h: Unused. Related to movement type Dh - frame 3
; 66h: Unused. Related to movement type Dh - frame 3
; 81h: Facing right - screw attack - frames Dh..Fh
; 82h: Facing left  - screw attack - frames Dh..Fh
; 83h: Facing right - wall jump - frames 23h..25h
; 84h: Facing left  - wall jump - frames 23h..25h
$92:D691             dx 9C93A0, 0100, 0060

; 65h: Unused. Related to movement type Dh - frame 4
; 66h: Unused. Related to movement type Dh - frame 4
; 81h: Facing right - screw attack - frames 13h..15h
; 82h: Facing left  - screw attack - frames 13h..15h
; 83h: Facing right - wall jump - frames 29h..2Bh
; 84h: Facing left  - wall jump - frames 29h..2Bh
$92:D698             dx 9C9500, 0100, 0000

; 1Bh: Facing right - space jump - frames 1..8
; 1Ch: Facing left  - space jump - frames 1..8
; 65h: Unused. Related to movement type Dh - frame 5
; 66h: Unused. Related to movement type Dh - frame 5
; 81h: Facing right - screw attack - frames 4..6
; 81h: Facing right - screw attack - frames Ah..Ch
; 81h: Facing right - screw attack - frames 10h..12h
; 81h: Facing right - screw attack - frames 16h..18h
; 82h: Facing left  - screw attack - frames 4..6
; 82h: Facing left  - screw attack - frames Ah..Ch
; 82h: Facing left  - screw attack - frames 10h..12h
; 82h: Facing left  - screw attack - frames 16h..18h
; 83h: Facing right - wall jump - frames Dh..14h
; 83h: Facing right - wall jump - frames 1Ah..1Ch
; 83h: Facing right - wall jump - frames 20h..22h
; 83h: Facing right - wall jump - frames 26h..28h
; 83h: Facing right - wall jump - frames 2Ch..2Eh
; 84h: Facing left  - wall jump - frames Dh..14h
; 84h: Facing left  - wall jump - frames 1Ah..1Ch
; 84h: Facing left  - wall jump - frames 20h..22h
; 84h: Facing left  - wall jump - frames 26h..28h
; 84h: Facing left  - wall jump - frames 2Ch..2Eh
$92:D69F             dx 9C9600, 0020, 0000
}


;;; $D6A6: Samus top tiles - set Bh (morphing transition, unused morph ball bounce) ;;;
{
; Unused
$92:D6A6             dx 9C9620, 0020, 0000

; 1Dh: Facing right - morph ball - no springball - on ground - frame 9
; 1Eh: Moving right - morph ball - no springball - on ground - frame 9
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 9
; 31h: Facing right - morph ball - no springball - in air - frame 9
; 32h: Facing left  - morph ball - no springball - in air - frame 9
; 3Fh: Unused - frame 9
; 40h: Unused - frame 9
; 41h: Facing left  - morph ball - no springball - on ground - frame 9
; 79h: Facing right - morph ball - spring ball - on ground - frame 9
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 9
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 9
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 9
; 7Dh: Facing right - morph ball - spring ball - falling - frame 9
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 9
; 7Fh: Facing right - morph ball - spring ball - in air - frame 9
; 80h: Facing left  - morph ball - spring ball - in air - frame 9
; C5h: Unused - frame 9
; DFh: Unused - frame 9
$92:D6AD             dx 9C9640, 0060, 0040

; Unused
$92:D6B4             dx 9C96E0, 0060, 0040

; 38h: Facing left  - morphing transition - frame 1
; 3Eh: Facing left  - unmorphing transition - frame 0
; D4h: Facing left  - crystal flash - frame 0
; D8h: Facing left  - crystal flash ending - frame 1
; DCh: Unused - frame 2
; DEh: Unused - frame 0
; E9h: Facing left  - Samus drained - crouching/falling - frame 0
$92:D6BB             dx 9C9780, 0080, 0040

; 38h: Facing left  - morphing transition - frame 0
; 3Eh: Facing left  - unmorphing transition - frame 1
; D4h: Facing left  - crystal flash - frame 1
; D4h: Facing left  - crystal flash - frame 3
; D4h: Facing left  - crystal flash - frames Ch..Dh
; D8h: Facing left  - crystal flash ending - frame 2
; DCh: Unused - frame 1
; DEh: Unused - frame 1
; E9h: Facing left  - Samus drained - crouching/falling - frame 1
$92:D6C2             dx 9C9840, 00C0, 0040

; 37h: Facing right - morphing transition - frame 1
; 3Dh: Facing right - unmorphing transition - frame 0
; D3h: Facing right - crystal flash - frame 0
; D7h: Facing right - crystal flash ending - frame 1
; DBh: Unused - frame 2
; DDh: Unused - frame 0
; E8h: Facing right - Samus drained - crouching/falling - frame 1
$92:D6C9             dx 9C9940, 0080, 0040

; 37h: Facing right - morphing transition - frame 0
; 3Dh: Facing right - unmorphing transition - frame 1
; D3h: Facing right - crystal flash - frame 1
; D3h: Facing right - crystal flash - frame 3
; D3h: Facing right - crystal flash - frames Ch..Dh
; D7h: Facing right - crystal flash ending - frame 2
; DBh: Unused - frame 1
; DDh: Unused - frame 1
; E8h: Facing right - Samus drained - crouching/falling - frame 2
$92:D6D0             dx 9C9A00, 00C0, 0040
}


;;; $D6D7: Samus bottom tiles - set 3 (unused) ;;;
{
; Unused
$92:D6D7             dx 9EE9C0, 0040, 0040

; Unused
$92:D6DE             dx 9EEA40, 0080, 0080

; Unused
$92:D6E5             dx 9EEB40, 0040, 0040

; Unused
$92:D6EC             dx 9EEBC0, 0080, 0080

; Unused
$92:D6F3             dx 9EECC0, 0040, 0040

; Unused
$92:D6FA             dx 9EED40, 0080, 0080

; Unused
$92:D701             dx 9EEE40, 0040, 0040

; Unused
$92:D708             dx 9EEEC0, 0080, 0080

; Unused
$92:D70F             dx 9EEFC0, 0040, 0040

; Unused
$92:D716             dx 9EF040, 0080, 0080

; Unused
$92:D71D             dx 9EF140, 0040, 0040

; Unused
$92:D724             dx 9EF1C0, 0080, 0080

; Unused
$92:D72B             dx 9EF2C0, 0040, 0040

; Unused
$92:D732             dx 9EF340, 0080, 0080

; Unused
$92:D739             dx 9EF440, 0040, 0040

; Unused
$92:D740             dx 9EF4C0, 0080, 0080

; Unused
$92:D747             dx 9EF5C0, 0080, 0080
}


;;; $D74E: Samus top tiles - set Ch (crystal flash, vertical shinespark) ;;;
{
; CBh: Facing right - shinespark - vertical - frame 0
$92:D74E             dx 9FDB80, 0100, 00C0

; CCh: Facing left  - shinespark - vertical - frame 0
$92:D755             dx 9FDD40, 0100, 00C0

; D4h: Facing left  - crystal flash - frame 2
; D4h: Facing left  - crystal flash - frame 6
$92:D75C             dx 9FDF00, 0100, 0040

; D4h: Facing left  - crystal flash - frame 7
; D4h: Facing left  - crystal flash - frame 9
$92:D763             dx 9FE040, 0100, 0040

; D4h: Facing left  - crystal flash - frame 8
$92:D76A             dx 9FE180, 0100, 0040

; D3h: Facing right - crystal flash - frame 2
; D3h: Facing right - crystal flash - frame 6
$92:D771             dx 9FE2C0, 0100, 0040

; D3h: Facing right - crystal flash - frame 7
; D3h: Facing right - crystal flash - frame 9
$92:D778             dx 9FE400, 0100, 0040

; D3h: Facing right - crystal flash - frame 8
$92:D77F             dx 9FE540, 0100, 0040
}


;;; $D786: Samus bottom tiles - set 7 (crystal flash bubble) ;;;
{
; D3h: Facing right - crystal flash - frame 0
; D3h: Facing right - crystal flash - frame Dh
; D4h: Facing left  - crystal flash - frame 0
; D4h: Facing left  - crystal flash - frame Dh
$92:D786             dx 9FE680, 0040, 0040

; D3h: Facing right - crystal flash - frame 1
; D3h: Facing right - crystal flash - frame Ch
; D4h: Facing left  - crystal flash - frame 1
; D4h: Facing left  - crystal flash - frame Ch
$92:D78D             dx 9FE700, 0100, 0100

; D3h: Facing right - crystal flash - frames 2..3
; D3h: Facing right - crystal flash - frames 6..9
; D4h: Facing left  - crystal flash - frames 2..3
; D4h: Facing left  - crystal flash - frames 6..9
$92:D794             dx 9FE900, 0100, 0100
}


;;; $D79B: Samus bottom tiles - set 9 (space jump) ;;;
{
; 1Bh: Facing right - space jump - frame 1
; 1Ch: Facing left  - space jump - frame 1
; 81h: Facing right - screw attack - frame 1
; 81h: Facing right - screw attack - frame 9
; 81h: Facing right - screw attack - frame 11h
; 82h: Facing left  - screw attack - frame 1
; 82h: Facing left  - screw attack - frame 9
; 82h: Facing left  - screw attack - frame 11h
; 83h: Facing right - wall jump - frame Dh
; 83h: Facing right - wall jump - frame 17h
; 83h: Facing right - wall jump - frame 1Fh
; 83h: Facing right - wall jump - frame 27h
; 84h: Facing left  - wall jump - frame Dh
; 84h: Facing left  - wall jump - frame 17h
; 84h: Facing left  - wall jump - frame 1Fh
; 84h: Facing left  - wall jump - frame 27h
$92:D79B             dx 9CEA80, 0100, 0100

; 1Bh: Facing right - space jump - frame 2
; 1Ch: Facing left  - space jump - frame 2
; 81h: Facing right - screw attack - frame 2
; 81h: Facing right - screw attack - frame Ah
; 81h: Facing right - screw attack - frame 12h
; 82h: Facing left  - screw attack - frame 2
; 82h: Facing left  - screw attack - frame Ah
; 82h: Facing left  - screw attack - frame 12h
; 83h: Facing right - wall jump - frame Eh
; 83h: Facing right - wall jump - frame 18h
; 83h: Facing right - wall jump - frame 20h
; 83h: Facing right - wall jump - frame 28h
; 84h: Facing left  - wall jump - frame Eh
; 84h: Facing left  - wall jump - frame 18h
; 84h: Facing left  - wall jump - frame 20h
; 84h: Facing left  - wall jump - frame 28h
$92:D7A2             dx 9CEC80, 0100, 0100

; 1Bh: Facing right - space jump - frame 3
; 1Ch: Facing left  - space jump - frame 3
; 81h: Facing right - screw attack - frame 3
; 81h: Facing right - screw attack - frame Bh
; 81h: Facing right - screw attack - frame 13h
; 82h: Facing left  - screw attack - frame 3
; 82h: Facing left  - screw attack - frame Bh
; 82h: Facing left  - screw attack - frame 13h
; 83h: Facing right - wall jump - frame Fh
; 83h: Facing right - wall jump - frame 19h
; 83h: Facing right - wall jump - frame 21h
; 83h: Facing right - wall jump - frame 29h
; 84h: Facing left  - wall jump - frame Fh
; 84h: Facing left  - wall jump - frame 19h
; 84h: Facing left  - wall jump - frame 21h
; 84h: Facing left  - wall jump - frame 29h
$92:D7A9             dx 9CEE80, 0100, 0100

; 1Bh: Facing right - space jump - frame 4
; 1Ch: Facing left  - space jump - frame 4
; 81h: Facing right - screw attack - frame 4
; 81h: Facing right - screw attack - frame Ch
; 81h: Facing right - screw attack - frame 14h
; 82h: Facing left  - screw attack - frame 4
; 82h: Facing left  - screw attack - frame Ch
; 82h: Facing left  - screw attack - frame 14h
; 83h: Facing right - wall jump - frame 10h
; 83h: Facing right - wall jump - frame 1Ah
; 83h: Facing right - wall jump - frame 22h
; 83h: Facing right - wall jump - frame 2Ah
; 84h: Facing left  - wall jump - frame 10h
; 84h: Facing left  - wall jump - frame 1Ah
; 84h: Facing left  - wall jump - frame 22h
; 84h: Facing left  - wall jump - frame 2Ah
$92:D7B0             dx 9CF080, 0100, 0100

; 1Bh: Facing right - space jump - frame 5
; 1Ch: Facing left  - space jump - frame 5
; 81h: Facing right - screw attack - frame 5
; 81h: Facing right - screw attack - frame Dh
; 81h: Facing right - screw attack - frame 15h
; 82h: Facing left  - screw attack - frame 5
; 82h: Facing left  - screw attack - frame Dh
; 82h: Facing left  - screw attack - frame 15h
; 83h: Facing right - wall jump - frame 11h
; 83h: Facing right - wall jump - frame 1Bh
; 83h: Facing right - wall jump - frame 23h
; 83h: Facing right - wall jump - frame 2Bh
; 84h: Facing left  - wall jump - frame 11h
; 84h: Facing left  - wall jump - frame 1Bh
; 84h: Facing left  - wall jump - frame 23h
; 84h: Facing left  - wall jump - frame 2Bh
$92:D7B7             dx 9CF280, 0100, 0100

; 1Bh: Facing right - space jump - frame 6
; 1Ch: Facing left  - space jump - frame 6
; 81h: Facing right - screw attack - frame 6
; 81h: Facing right - screw attack - frame Eh
; 81h: Facing right - screw attack - frame 16h
; 82h: Facing left  - screw attack - frame 6
; 82h: Facing left  - screw attack - frame Eh
; 82h: Facing left  - screw attack - frame 16h
; 83h: Facing right - wall jump - frame 12h
; 83h: Facing right - wall jump - frame 1Ch
; 83h: Facing right - wall jump - frame 24h
; 83h: Facing right - wall jump - frame 2Ch
; 84h: Facing left  - wall jump - frame 12h
; 84h: Facing left  - wall jump - frame 1Ch
; 84h: Facing left  - wall jump - frame 24h
; 84h: Facing left  - wall jump - frame 2Ch
$92:D7BE             dx 9CF480, 0100, 0100

; 1Bh: Facing right - space jump - frame 7
; 1Ch: Facing left  - space jump - frame 7
; 81h: Facing right - screw attack - frame 7
; 81h: Facing right - screw attack - frame Fh
; 81h: Facing right - screw attack - frame 17h
; 82h: Facing left  - screw attack - frame 7
; 82h: Facing left  - screw attack - frame Fh
; 82h: Facing left  - screw attack - frame 17h
; 83h: Facing right - wall jump - frame 13h
; 83h: Facing right - wall jump - frame 1Dh
; 83h: Facing right - wall jump - frame 25h
; 83h: Facing right - wall jump - frame 2Dh
; 84h: Facing left  - wall jump - frame 13h
; 84h: Facing left  - wall jump - frame 1Dh
; 84h: Facing left  - wall jump - frame 25h
; 84h: Facing left  - wall jump - frame 2Dh
$92:D7C5             dx 9CF680, 0100, 0100

; 1Bh: Facing right - space jump - frame 8
; 1Ch: Facing left  - space jump - frame 8
; 81h: Facing right - screw attack - frame 8
; 81h: Facing right - screw attack - frame 10h
; 81h: Facing right - screw attack - frame 18h
; 82h: Facing left  - screw attack - frame 8
; 82h: Facing left  - screw attack - frame 10h
; 82h: Facing left  - screw attack - frame 18h
; 83h: Facing right - wall jump - frame 14h
; 83h: Facing right - wall jump - frame 1Eh
; 83h: Facing right - wall jump - frame 26h
; 83h: Facing right - wall jump - frame 2Eh
; 84h: Facing left  - wall jump - frame 14h
; 84h: Facing left  - wall jump - frame 1Eh
; 84h: Facing left  - wall jump - frame 26h
; 84h: Facing left  - wall jump - frame 2Eh
$92:D7CC             dx 9CF880, 0100, 0100
}
}


;;; $D7D3: Samus spritemaps - atmospheric graphics ;;;
{
; See $81:8A5F for spritemap format

; Bubbles - frame 0
$92:D7D3             dx 0002, 01FC,FE,3A25, 01FD,FC,3A43

; Bubbles - frame 1
$92:D7DF             dx 0003, 01FF,FA,3A43, 01FB,F8,BA25, 01FC,FD,3A25

; Bubbles - frame 2
$92:D7F0             dx 0003, 01FA,F6,3A43, 0000,F8,3A25, 01FD,FB,3A25

; Bubbles - frame 3
$92:D801             dx 0003, 0000,F7,3A43, 01FC,FA,3A43, 01FA,F3,3A43

; Bubbles - frame 4
$92:D812             dx 0003, 0000,F3,3A40, 01FA,F1,3A40, 01FC,F8,3A43

; Bubbles - frame 5
$92:D823             dx 0003, 0001,F1,3A40, 01FC,F6,3A40, 01FA,EF,3A40

; Bubbles - frame 6
$92:D834             dx 0003, 0001,EF,7A40, 01FC,F4,3A40, 01F9,EC,3A40

; Bubbles - frame 7
$92:D845             dx 0002, 0002,EC,7A40, 01FC,F0,3A40

; Bubbles - frame 8
$92:D851             dx 0001, 01FC,EC,BA40

; Diving splash - frame 0
$92:D858             dx 0003, C3F8,00,3A9A, 0004,F8,3A5E, 01F4,F8,3A5E

; Diving splash - frame 1
$92:D869             dx 0003, C3F8,04,7A9A, 0002,F8,3ABA, 01F6,F8,3ABA

; Diving splash - frame 2
$92:D87A             dx 0005, C3F8,04,BA9A, 0000,F4,3ABA, 01F8,F3,3ABA, 0000,F8,3ACA, 01F8,F8,3ACA

; Diving splash - frame 3
$92:D895             dx 0005, C3F8,03,3A9C, 0000,F8,3ACA, 0000,F0,3ABA, 01F8,F8,3ACA, 01F8,F0,3ABA

; Diving splash - frame 4
$92:D8B0             dx 0007, C3F8,01,BA9C, 0000,F2,3ABA, 01F8,F1,3ABA, 0000,EB,3AC7, 01F8,EC,3AC7, 0000,F8,3ACA, 01F8,F8,3ACA

; Diving splash - frame 5
$92:D8D5             dx 0005, C3F8,00,7A9C, 0000,EE,3AC7, 01F8,F0,3AC7, 0001,F9,3ABA, 01F7,F8,3ABA

; Diving splash - frame 6
$92:D8F0             dx 0004, 01F8,F2,3AC7, 0000,F2,3AC7, 0002,F8,3A5E, 01F6,F9,3A5E

; Diving splash - frame 7
$92:D906             dx 0002, 0000,F6,3AC7, 01F8,F6,3AC7

; Diving splash - frame 8
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
$92:ED2D D0 0C       BNE $0C    [$ED3B]     ;} If [Samus appears fanfare timer] = 0:
$92:ED2F A9 01 00    LDA #$0001             ;\
$92:ED32 A0 0E 00    LDY #$000E             ;} Queue Samus fanfare music track, 14 frame delay
$92:ED35 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/
$92:ED39 80 0E       BRA $0E    [$ED49]

$92:ED3B C9 05 00    CMP #$0005             ;\ Else ([Samus appears fanfare timer] != 0):
$92:ED3E D0 09       BNE $09    [$ED49]     ;} If [Samus appears fanfare timer] = 5:
$92:ED40 A9 68 01    LDA #$0168             ;\
$92:ED43 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$92:ED47 80 00       BRA $00    [$ED49]

$92:ED49 AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$92:ED4C 1A          INC A                  ;|
$92:ED4D C9 68 01    CMP #$0168             ;} If [Samus appears fanfare timer] + 1 < 360:
$92:ED50 10 05       BPL $05    [$ED57]     ;/
$92:ED52 8D EC 0D    STA $0DEC  [$7E:0DEC]  ; Increment Samus appears fanfare timer
$92:ED55 80 1F       BRA $1F    [$ED76]     ; Return carry clear

$92:ED57 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$92:ED5A 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$92:ED5D AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$92:ED60 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$92:ED63 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$92:ED66 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$92:ED69 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$92:ED6C 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$92:ED6F 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; Samus appears fanfare timer = 0
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
$92:EDD3 6D E4 0D    ADC $0DE4  [$7E:0DE4]  ;} $12 = 81Ch + [death animation index]
$92:EDD6 85 12       STA $12    [$7E:0012]  ;/
$92:EDD8 80 09       BRA $09    [$EDE3]

$92:EDDA A9 25 08    LDA #$0825             ;\ Else (Samus is facing left):
$92:EDDD 18          CLC                    ;|
$92:EDDE 6D E4 0D    ADC $0DE4  [$7E:0DE4]  ;} $12 = 825h + [death animation index]
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


;;; $EDF4: Free space ;;;
{
$92:EDF4             fillto $938000, $FF
}
