; FX format
;                        __________________________________________ 0: Door pointer
;                       |     _____________________________________ 2: Base Y position
;                       |    |     ________________________________ 4: Target Y position
;                       |    |    |     ___________________________ 6: Y velocity
;                       |    |    |    |     ______________________ 8: Timer
;                       |    |    |    |    |   ___________________ 9: Type (foreground layer 3)
;                       |    |    |    |    |  |   ________________ Ah: Default layer blending configuration (FX A)
;                       |    |    |    |    |  |  |   _____________ Bh: FX layer 3 layer blending configuration (FX B)
;                       |    |    |    |    |  |  |  |   __________ Ch: FX liquid options (FX C)
;                       |    |    |    |    |  |  |  |  |   _______ Dh: Palette FX bitset
;                       |    |    |    |    |  |  |  |  |  |   ____ Eh: Animated tiles bitset
;                       |    |    |    |    |  |  |  |  |  |  |   _ Fh: Palette blend
;                       |    |    |    |    |  |  |  |  |  |  |  |
;                       dddd,bbbb,tttt,vvvv,tt,ff,AA,BB,CC,pp,aa,bb

; Door header format
;                        _____________________________ 0: Destination room header pointer (bank $8F)
;                       |     ________________________ 2: Elevator properties
;                       |    |   _____________________ 3: Direction
;                       |    |  |   __________________ 4: X position low byte
;                       |    |  |  |   _______________ 5: Y position low byte
;                       |    |  |  |  |   ____________ 6: X position high byte
;                       |    |  |  |  |  |   _________ 7: Y position high byte
;                       |    |  |  |  |  |  |   ______ 8: Distance from door to spawn Samus
;                       |    |  |  |  |  |  |  |     _ Ah: Custom door ASM to execute (bank $8F)
;                       |    |  |  |  |  |  |  |    |
;                       rrrr ee oo xx yy XX YY dddd aaaa

;;; $8000: FX ;;;
{
; Room $91F8, state $9261: FX
$83:8000             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,06,00,00

; Room $92FD, state $9348: FX
$83:8010             dx 0000,04E8,0010,FF98,00,00,02,02,00,42,00,00

; Room $96BA, state $9705: FX
$83:8020             dx 0000,08E8,0010,FF98,28,04,02,1E,01,38,00,00

; Room $9804, state $984F: FX
$83:8030             dx 0000,00F0,00B8,FFF0,30,04,02,1E,00,00,00,00

; Room $9879, state $98C4: FX
$83:8040             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $92FD, state $932E: FX
$83:8050             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $96BA, state $96EB: FX
$83:8060             dx AB34,0908,0000,FF80,20,02,02,1E,0B,1F,01,02, 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $975C, state $9787: FX
$83:8080             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $97B5, state $97E0: FX
$83:8090             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $9A44, state $9A70: FX
$83:80A0             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $9A90, state $9ABC: FX
$83:80B0             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $91F8, state $9213: FX
; Room $91F8, state $922D: FX
$83:80C0             dx 0000,FFFF,FFFF,0000,00,0A,02,0E,00,01,00,22

; Room $91F8, state $9247: FX
$83:80D0             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $92B3, state $92C5: FX
; Room $92B3, state $92DF: FX
$83:80E0             dx 0000,00C8,FFFF,0000,00,04,02,1E,42,00,00,00

; Room $92FD, state $9314: FX
$83:80F0             dx 0000,FFFF,FFFF,0000,00,00,28,02,00,00,00,62

; Room $93AA, state $93B7: FX
$83:8100             dx 0000,00C0,FFFF,0000,00,04,02,1E,42,00,02,48

; Room $93D5, state $93E2: FX
$83:8110             dx FFFF

; Room $93FE, state $940B: FX
$83:8112             dx 0000,04F0,FFFF,0000,00,06,02,18,01,00,06,48

; Room $9461, state $946E: FX
$83:8122             dx 0000,00B0,FFFF,0000,00,06,02,18,83,00,00,48

; Room $948C, state $9499: FX
$83:8132             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $94CC, state $94D9: FX
$83:8142             dx FFFF

; Room $94FD, state $950A: FX
$83:8144             dx 0000,04F0,FFFF,0000,00,06,02,18,01,00,04,48

; Room $9552, state $955F: FX
$83:8154             dx FFFF

; Room $957D, state $958A: FX
$83:8156             dx 0000,01B0,FFFF,0000,00,06,02,18,03,00,00,48

; Room $95A8, state $95B5: FX
$83:8166             dx FFFF

; Room $95D4, state $95E1: FX
$83:8168             dx FFFF

; Room $95FF, state $960C: FX
$83:816A             dx 0000,00B0,FFFF,0000,00,06,02,18,01,00,06,48

; Room $962A, state $9637: FX
$83:817A             dx FFFF

; Room $965B, state $9668: FX
$83:817C             dx 0000,00C8,FFFF,0000,00,04,02,1E,42,00,02,00

; Room $968F, state $969C: FX
$83:818C             dx FFFF

; Room $96BA, state $96D1: FX
$83:818E             dx 0000,FFFF,FFFF,0000,00,0C,02,30,00,00,00,62

; Room $975C, state $976D: FX
$83:819E             dx 0000,FFFF,FFFF,0000,00,0C,02,30,00,00,00,62

; Room $97B5, state $97C6: FX
$83:81AE             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,00,00,00

; Room $9804, state $981B: FX
; Room $9804, state $9835: FX
$83:81BE             dx FFFF

; Room $9879, state $9890: FX
; Room $9879, state $98AA: FX
$83:81C0             dx FFFF

; Room $98E2, state $98EF: FX
; Room $990D, state $991A: FX
; Room $9938, state $9945: FX
; Room $9969, state $9976: FX
; Room $9994, state $99A1: FX
; Room $99BD, state $99CA: FX
$83:81C2             dx FFFF

; Room $99F9, state $9A06: FX
$83:81C4             dx 0000,07E0,FFFF,0000,00,04,02,1E,40,00,02,48

; Room $9A44, state $9A56: FX
$83:81D4             dx 0000,FFFF,FFFF,0000,00,00,28,02,00,00,00,62

; Room $9A90, state $9AA2: FX
$83:81E4             dx 0000,FFFF,FFFF,0000,00,00,28,02,00,00,00,62

; Room $9E9F, state $9ECB: FX
; Room $9F11, state $9F3D: FX
; Room $9F64, state $9F90: FX
$83:81F4             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $9AD9, state $9AE6: FX
$83:8204             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,00,00

; Room $9B5B, state $9B68: FX
$83:8214             dx 0000,FFFF,FFFF,0000,00,08,02,0A,00,00,00,00

; Room $9B9D, state $9BAA: FX
$83:8224             dx FFFF

; Room $9BC8, state $9BD5: FX
$83:8226             dx FFFF

; Room $9C07, state $9C14: FX
$83:8228             dx FFFF

; Room $9C35, state $9C42: FX
$83:822A             dx FFFF

; Room $9C5E, state $9C6B: FX
$83:822C             dx 0000,FFFF,FFFF,0000,00,24,02,02,00,00,00,00

; Room $9C89, state $9C96: FX
$83:823C             dx FFFF

; Room $9CB3, state $9CC0: FX
$83:823E             dx 0000,FFFF,FFFF,0000,00,08,02,0A,00,00,00,00

; Room $9D19, state $9D26: FX
$83:824E             dx 0000,FFFF,FFFF,0000,00,08,02,0A,00,00,01,00

; Room $9D9C, state $9DA9: FX
$83:825E             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,00,00

; Room $9DC7, state $9DD9: FX
; Room $9DC7, state $9DF3: FX
$83:826E             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,08,00,00

; Room $9E11, state $9E1E: FX
$83:827E             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,02,00

; Room $9E52, state $9E5F: FX
$83:828E             dx FFFF

; Room $9E9F, state $9EB1: FX
$83:8290             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,00,00,00

; Room $9F11, state $9F23: FX
$83:82A0             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,00,00,00

; Room $9F64, state $9F76: FX
$83:82B0             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,00,00,00

; Room $9FBA, state $9FC7: FX
$83:82C0             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,02,00

; Room $9FE5, state $9FF2: FX
$83:82D0             dx FFFF

; Room $A011, state $A01E: FX
$83:82D2             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,00,00

; Room $A051, state $A05E: FX
$83:82E2             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,00,00

; Room $A07B, state $A088: FX
$83:82F2             dx FFFF

; Room $A0A4, state $A0B1: FX
$83:82F4             dx 0000,FFFF,FFFF,0000,00,08,02,0A,00,00,00,00

; Room $A0D2, state $A0DF: FX
$83:8304             dx 0000,00A8,FFFF,0000,00,06,02,18,03,00,00,48

; Room $A107, state $A114: FX
$83:8314             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $A130, state $A13D: FX
$83:8324             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,03,00

; Room $A15B, state $A168: FX
$83:8334             dx FFFF

; Room $A184, state $A191: FX
$83:8336             dx FFFF

; Room $A1AD, state $A1BA: FX
$83:8338             dx 0000,00B0,FFFF,0000,00,06,02,18,83,00,02,48

; Room $A1D8, state $A1E5: FX
$83:8348             dx FFFF

; Room $A201, state $A20E: FX
$83:834A             dx FFFF

; Room $A22A, state $A237: FX
$83:834C             dx FFFF

; Room $A253, state $A260: FX
$83:834E             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,06,03,00

; Room $A293, state $A2A0: FX
$83:835E             dx 0000,FFFF,FFFF,0000,00,24,02,02,00,00,02,00

; Room $A2CE, state $A2DB: FX
$83:836E             dx FFFF

; Room $A2F7, state $A304: FX
$83:8370             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,02,04,00

; Room $A322, state $A32F: FX
$83:8380             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,06,00,00

; Room $A37C, state $A389: FX
$83:8390             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,04,00

; Room $A3AE, state $A3BB: FX
$83:83A0             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,04,00

; Room $A3DD, state $A3EA: FX
$83:83B0             dx 0000,00BE,FFFF,0000,00,06,02,18,03,00,00,48

; Room $A408, state $A415: FX
$83:83C0             dx 0000,01BE,FFFF,0000,00,06,02,18,03,00,01,48

; Room $A447, state $A454: FX
$83:83D0             dx FFFF

; Room $A471, state $A47E: FX
; Room $A4B1, state $A4BE: FX
; Room $A4DA, state $A4E7: FX
$83:83D2             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,04,00,00

; Room $A521, state $A533: FX
; Room $A521, state $A54D: FX
$83:83E2             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,02,00

; Room $A56B, state $A578: FX
$83:83F2             dx FFFF

; Room $A59F, state $A5B1: FX
; Room $A59F, state $A5CB: FX
$83:83F4             dx FFFF

; Room $A5ED, state $A5FA: FX
$83:83F6             dx 0000,FFFF,FFFF,0000,00,0C,02,30,00,80,00,62

; Room $A618, state $A625: FX
$83:8406             dx FFFF

; Room $A641, state $A64E: FX
$83:8408             dx FFFF

; Room $A66A, state $A677: FX
$83:840A             dx 0000,00B0,01FF,0000,00,26,02,18,01,00,00,48

; Room $A6A1, state $A6AE: FX
$83:841A             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,00,00,00

; Room $A6E2, state $A6EF: FX
$83:842A             dx FFFF

; Room $A70B, state $A718: FX
$83:842C             dx FFFF

; Room $A734, state $A741: FX
$83:842E             dx FFFF

; Room $A75D, state $A76A: FX
$83:8430             dx 0000,00B8,FFFF,0000,00,02,02,1E,0B,1F,02,02

; Room $A788, state $A795: FX
$83:8440             dx 0000,01B1,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $A7B3, state $A7C0: FX
$83:8450             dx 0000,01D0,FFFF,0000,00,02,02,1E,0B,1F,03,02

; Room $A7DE, state $A7EB: FX
$83:8460             dx 0000,FFFF,FFFF,0000,00,02,02,1E,00,00,00,02

; Room $A815, state $A822: FX
$83:8470             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $A865, state $A872: FX
$83:8480             dx 0000,00B2,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $A890, state $A89D: FX
$83:8490             dx 0000,FFFF,FFFF,0000,00,02,02,1E,00,00,00,02

; Room $A8B9, state $A8C6: FX
$83:84A0             dx 0000,02B8,FFFF,0000,00,02,02,1E,03,1F,03,02

; Room $A8F8, state $A905: FX
$83:84B0             dx 0000,FFFF,FFFF,0000,00,02,02,1E,03,1F,00,02

; Room $A923, state $A930: FX
$83:84C0             dx 0000,FFFF,FFFF,0000,00,02,02,1E,0B,1F,02,02

; Room $A98D, state $A99F: FX
; Room $A98D, state $A9B9: FX
$83:84D0             dx 0000,00C6,FFFF,0000,00,04,02,1E,81,00,01,02

; Room $A9E5, state $A9F2: FX
$83:84E0             dx 0000,FFFF,FFFF,0000,00,02,02,1E,01,00,00,02

; Room $AA0E, state $AA1B: FX
$83:84F0             dx 0000,01B8,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $AA41, state $AA4E: FX
$83:8500             dx 0000,FFFF,FFFF,0000,00,02,02,1E,01,00,00,02

; Room $AA82, state $AA8F: FX
$83:8510             dx 0000,FFFF,FFFF,0000,00,00,02,02,03,00,00,02

; Room $AAB5, state $AAC2: FX
$83:8520             dx 0000,FFFF,FFFF,0000,00,02,02,1E,01,00,00,02

; Room $AADE, state $AAEB: FX
$83:8530             dx 0000,FFFF,FFFF,0000,00,02,02,1E,03,1F,00,02

; Room $AB07, state $AB14: FX
$83:8540             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $AB3B, state $AB48: FX
$83:8550             dx 0000,00C8,FFFF,0000,00,04,02,1E,41,00,02,00

; Room $AB64, state $AB71: FX
$83:8560             dx 0000,00B8,FFFF,0000,00,06,02,18,83,00,00,48

; Room $AB8F, state $AB9C: FX
$83:8570             dx 0000,02B4,FFFF,0000,00,04,02,1E,80,00,00,00

; Room $ABD2, state $ABDF: FX
$83:8580             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $AC00, state $AC0D: FX
$83:8590             dx 0000,00C0,FFFF,0000,00,06,02,18,83,00,00,48

; Room $AC2B, state $AC38: FX
$83:85A0             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,03,00

; Room $AC5A, state $AC67: FX
$83:85B0             dx 0000,00C7,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $AC83, state $AC90: FX
$83:85C0             dx 0000,00C6,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $ACB3, state $ACC0: FX
$83:85D0             dx 0000,FFFF,FFFF,0000,00,02,02,1E,03,00,02,02

; Room $ACF0, state $ACFD: FX
$83:85E0             dx 95BE,01DA,00B0,0000,F0,02,02,1E,0B,1F,02,02, 0000,01DA,FFFF,0000,00,02,02,1E,0B,1F,02,02

; Room $AD1B, state $AD28: FX
$83:8600             dx 0000,00DA,0000,0000,20,02,02,1E,0B,1F,00,02

; Room $AD5E, state $AD6B: FX
$83:8610             dx 0000,FFFF,FFFF,0000,00,02,02,1E,03,1F,02,02

; Room $ADAD, state $ADBA: FX
$83:8620             dx 0000,FFFF,FFFF,0000,00,02,02,1E,03,1F,02,02

; Room $ADDE, state $ADEB: FX
$83:8630             dx 0000,FFFF,FFFF,0000,00,02,02,1E,01,00,00,02

; Room $AE07, state $AE14: FX
$83:8640             dx 0000,00C0,FFFF,0000,00,02,02,1E,03,1F,02,02

; Room $AE32, state $AE3F: FX
$83:8650             dx 9672,02E0,0260,FFF6,40,02,02,1E,0B,1F,00,02, 0000,0268,FFFF,0000,00,02,02,1E,01,00,00,02

; Room $AE74, state $AE81: FX
$83:8670             dx 0000,02D4,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $AEB4, state $AEC1: FX
$83:8680             dx 0000,00BE,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $AEDF, state $AEEC: FX
$83:8690             dx 0000,FFFF,FFFF,0000,00,02,02,1E,03,1F,03,02

; Room $AF14, state $AF21: FX
$83:86A0             dx 0000,00D0,FFFF,0000,00,02,02,1E,0B,1F,03,02

; Room $AF3F, state $AF4C: FX
$83:86B0             dx 0000,FFFF,FFFF,0000,00,02,02,1E,03,1F,00,02

; Room $AF72, state $AF7F: FX
$83:86C0             dx 0000,01C0,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $AFA3, state $AFB0: FX
$83:86D0             dx 929A,0108,00C0,FFE0,40,02,02,1E,0B,1F,00,02, 0000,00C8,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $AFCE, state $AFDB: FX
$83:86F0             dx 0000,00C5,FFFF,0000,00,02,02,1E,0B,1F,00,02

; Room $AFFB, state $B008: FX
$83:8700             dx 0000,00C6,FFFF,0000,00,02,02,1E,03,1F,02,02

; Room $B026, state $B033: FX
$83:8710             dx 0000,FFFF,FFFF,0000,00,02,02,1E,01,00,00,02

; Room $B051, state $B05E: FX
$83:8720             dx 0000,FFFF,FFFF,0000,00,02,02,1E,03,1F,00,02

; Room $B07A, state $B087: FX
$83:8730             dx 0000,01B4,FFFF,0000,00,02,02,1E,03,1F,00,02

; Room $B0B4, state $B0C1: FX
$83:8740             dx 0000,FFFF,FFFF,0000,00,02,02,1E,01,00,00,02

; Room $B0DD, state $B0EA: FX
$83:8750             dx 0000,FFFF,FFFF,0000,00,02,02,1E,01,00,00,02

; Room $B106, state $B113: FX
$83:8760             dx FFFF

; Room $B139, state $B146: FX
$83:8762             dx FFFF

; Room $B167, state $B174: FX
$83:8764             dx FFFF

; Room $B192, state $B19F: FX
$83:8766             dx FFFF

; Room $B1BB, state $B1C8: FX
$83:8768             dx FFFF

; Room $B1E5, state $B1F2: FX
$83:876A             dx 9876,02D2,FFFF,0000,00,04,02,1E,82,1F,00,00, 0000,00C8,02D2,0000,00,04,02,1E,02,1F,00,00

; Room $B236, state $B243: FX
$83:878A             dx 0000,02C1,FFFF,0000,00,04,02,1E,82,1F,00,00

; Room $B283, state $B295: FX
; Room $B283, state $B2AF: FX
$83:879A             dx 0000,02C6,FFFF,0000,00,04,02,1E,82,1F,00,00

; Room $B2DA, state $B2E7: FX
$83:87AA             dx 0000,00B8,FFFF,0000,00,04,02,1E,82,1F,00,00

; Room $B305, state $B312: FX
$83:87BA             dx FFFF

; Room $B32E, state $B340: FX
; Room $B32E, state $B35A: FX
$83:87BC             dx 0000,0210,01D0,0000,00,04,02,1E,82,1F,00,00

; Room $B37A, state $B387: FX
$83:87CC             dx 0000,00D0,FFFF,0000,00,04,02,1E,82,1F,00,00

; Room $B3A5, state $B3B2: FX
$83:87DC             dx 0000,FFFF,FFFF,0000,00,04,02,1E,02,1F,00,00

; Room $B3E1, state $B3EE: FX
$83:87EC             dx 0000,FFFF,FFFF,0000,00,04,02,1E,02,1F,00,00

; Room $B40A, state $B417: FX
$83:87FC             dx 0000,FFFF,FFFF,0000,00,04,02,1E,02,1F,00,00

; Room $B457, state $B464: FX
$83:880C             dx 0000,00E8,0010,FFE0,50,04,02,1E,82,1F,00,00

; Room $B482, state $B48F: FX
$83:881C             dx 0000,00CD,FFFF,0000,00,04,02,1E,82,1F,00,00

; Room $B4AD, state $B4BA: FX
$83:882C             dx 0000,FFFF,FFFF,0000,20,04,02,1E,02,1F,02,00

; Room $B4E5, state $B4F2: FX
$83:883C             dx 99F6,00D0,FFFF,0000,00,04,02,1E,82,1F,00,00, 0000,04E8,00D0,FF80,60,04,02,1E,82,1F,02,00

; Room $B510, state $B51D: FX
$83:885C             dx 0000,FFFF,FFFF,0000,00,04,02,1E,02,1F,02,00

; Room $B55A, state $B567: FX
$83:886C             dx 0000,00B3,FFFF,0000,00,04,02,1E,82,1F,00,00

; Room $B585, state $B592: FX
$83:887C             dx 0000,FFFF,FFFF,0000,00,04,02,1E,02,1F,00,00

; Room $B5D5, state $B5E2: FX
$83:888C             dx 0000,02C0,FFFF,0000,00,04,02,1E,02,1F,03,00

; Room $B62B, state $B638: FX
$83:889C             dx 0000,FFFF,FFFF,0000,00,04,02,1E,02,1F,00,00

; Room $B656, state $B663: FX
$83:88AC             dx 0000,02D0,FFFF,0000,00,04,02,1E,42,1F,00,00

; Room $B698, state $B6A5: FX
$83:88BC             dx 0000,00DD,FFFF,0000,00,04,02,1E,82,1F,00,00

; Room $B6C1, state $B6CE: FX
$83:88CC             dx 0000,02DD,FFFF,0000,00,04,02,1E,82,1F,00,00

; Room $B6EE, state $B6FB: FX
$83:88DC             dx 0000,FFFF,FFFF,0000,00,24,02,02,00,00,02,00

; Room $B741, state $B74E: FX
$83:88EC             dx 0000,FFFF,FFFF,0000,00,02,02,1E,01,00,00,02
}


;;; $88FC: Door ;;;
{
; Room $94CC, door list index 2: Door
; Room $962A, door list index 2: Door
; Room $97B5, door list index 2: Door
; Room $9938, door list index 2: Door
; Room $9AD9, door list index 9: Door
; Room $9E9F, door list index 3: Door
; Room $A322, door list index 5: Door
; Room $A66A, door list index 2: Door
; Room $A6A1, door list index 3: Door
; Room $A7DE, door list index 5: Door
; Room $AF3F, door list index 2: Door
; Room $B236, door list index 3: Door
$83:88FC             dw 0000

; Room $91F8, Zebes landing cutscene
; Crateria load station 12h
$83:88FE             dx 91F8,00,03,00,00,04,00,8000,0000

; Demo set 3, demos 0,2,4
$83:890A             dx 91F8,00,03,00,00,04,02,8000,0000

; Room $91F8, door list index 0: Door
$83:8916             dx 92FD,00,05,4E,06,04,00,8000,0000

; Room $91F8, door list index 1: Door
$83:8922             dx 95D4,00,00,00,00,00,00,8000,0000

; Room $91F8, door list index 2: Door
$83:892E             dx 92B3,00,05,4E,06,04,00,8000,0000

; Room $91F8, door list index 3: Door
$83:893A             dx 93AA,00,04,01,06,00,00,8000,0000

; Room $92B3, door list index 0: Door
$83:8946             dx 91F8,00,04,01,26,00,02,8000,B997

; Room $92B3, door list index 1: Door
$83:8952             dx 965B,00,05,5E,06,05,00,8000,0000

; Room $92FD, door list index 0: Door
$83:895E             dx 990D,00,05,5E,06,05,00,8000,0000

; Room $92FD, door list index 1: Door
; Crateria load station 0/10h
$83:896A             dx 91F8,00,04,01,46,00,04,8000,0000

; Room $92FD, door list index 2: Door
$83:8976             dx 98E2,00,04,01,06,00,00,8000,0000

; Room $92FD, door list index 3: Door
$83:8982             dx 9879,00,04,01,06,00,00,8000,0000

; Room $92FD, door list index 4: Door
$83:898E             dx 96BA,00,06,16,02,01,00,8000,0000

; Room $92FD, door list index 5: Door
; Crateria load station 1
$83:899A             dx 93D5,00,05,0E,06,00,00,8000,0000

; Room $92FD, door list index 6: Door
$83:89A6             dx 9A44,00,05,1E,06,01,00,8000,0000

; Room $93AA, door list index 0: Door
$83:89B2             dx 91F8,00,05,8E,16,08,01,8000,0000

; Room $93D5, door list index 0: Door
$83:89BE             dx 92FD,00,04,11,26,01,02,8000,B981

; Room $93FE, door list index 0: Door
$83:89CA             dx 95FF,00,05,1E,06,01,00,8000,0000

; Room $93FE, door list index 1: Door
$83:89D6             dx CA08,50,04,01,06,00,00,8000,B971

; Room $93FE, door list index 2: Door
$83:89E2             dx 9461,00,04,01,06,00,00,8000,0000

; Room $93FE, door list index 3: Door
$83:89EE             dx CA52,40,04,01,06,00,00,8000,0000

; Room $93FE, door list index 4: Door
$83:89FA             dx C98E,40,04,21,06,02,00,8000,B9B3

; Room $93FE, door list index 5: Door
$83:8A06             dx CE40,40,04,01,06,00,00,8000,0000

; Room $9461, door list index 0: Door
$83:8A12             dx 93FE,00,05,2E,26,02,02,8000,0000

; Room $9461, door list index 1: Door
$83:8A1E             dx 968F,00,04,01,06,00,00,8000,0000

; Room $948C, door list index 0: Door
$83:8A2A             dx 95D4,00,01,00,00,00,00,8000,0000

; Room $948C, door list index 1: Door
$83:8A36             dx 95FF,00,04,01,06,00,00,8000,0000

; Room $948C, door list index 2: Door
; Crateria load station 9
$83:8A42             dx 962A,00,06,06,02,00,00,8000,0000

; Room $94CC, door list index 0: Door
$83:8A4E             dx 95A8,00,07,06,0D,00,00,01C0,0000

; Room $94CC, door list index 1: Door
$83:8A5A             dx D30B,D0,02,00,00,00,00,0000,0000

; Room $94FD, door list index 0: Door
$83:8A66             dx CBD5,40,05,0E,16,00,01,8000,0000

; Room $94FD, door list index 1: Door
$83:8A72             dx 9552,00,04,01,06,00,00,8000,0000

; Room $9552, door list index 0: Door
; Crateria load station 11h
$83:8A7E             dx 94FD,00,05,6E,46,06,04,8000,0000

; Room $9552, door list index 1: Door
$83:8A8A             dx 957D,00,06,36,02,03,00,8000,0000

; Room $957D, door list index 0: Door
$83:8A96             dx 9552,00,07,06,3D,00,03,01C0,0000

; Room $95A8, door list index 0: Door
$83:8AA2             dx 957D,00,04,01,16,00,01,8000,0000

; Room $957D, door list index 1: Door
$83:8AAE             dx 95A8,00,05,0E,06,00,00,8000,0000

; Room $95A8, door list index 1: Door
; Crateria load station 8
$83:8ABA             dx 94CC,00,06,06,02,00,00,8000,0000

; Room $95D4, door list index 0: Door
$83:8AC6             dx 91F8,00,05,8E,46,08,04,8000,0000

; Room $95D4, door list index 1: Door
$83:8AD2             dx 948C,00,04,01,06,00,00,8000,0000

; Room $95FF, door list index 0: Door
$83:8ADE             dx 948C,00,05,2E,06,02,00,8000,0000

; Room $95FF, door list index 1: Door
$83:8AEA             dx 93FE,00,04,01,46,00,04,8000,0000

; Room $962A, door list index 0: Door
$83:8AF6             dx 948C,00,07,16,2D,01,02,01C0,B9F1

; Room $962A, door list index 1: Door
$83:8B02             dx A322,E0,02,00,00,00,00,0000,BA21

; Room $965B, door list index 0: Door
$83:8B0E             dx 92B3,00,04,01,06,00,00,8000,0000

; Room $965B, door list index 1: Door
$83:8B1A             dx 99BD,00,05,0E,06,00,00,8000,BA2C

; Room $968F, door list index 0: Door
$83:8B26             dx 9461,00,05,1E,06,01,00,8000,0000

; Room $968F, door list index 1: Door
$83:8B32             dx C98E,40,04,01,16,00,01,00A0,B9CA

; Room $96BA, door list index 0: Door
$83:8B3E             dx 92FD,00,07,16,4D,01,04,01C0,B981

; Room $96BA, door list index 1: Door
$83:8B4A             dx 99F9,00,04,01,06,00,00,8000,0000

; Room $96BA, door list index 2: Door
$83:8B56             dx 99F9,00,04,01,76,00,07,8000,0000

; Room $96BA, door list index 3: Door
$83:8B62             dx 975C,00,04,01,06,00,00,8000,0000

; Room $96BA, door list index 4: Door
$83:8B6E             dx DEDE,00,05,2E,16,02,01,8000,0000

; Room $975C, door list index 0: Door
$83:8B7A             dx 96BA,00,05,1E,86,01,08,8000,0000

; Room $975C, door list index 1: Door
; Crateria load station Ah
$83:8B86             dx 97B5,00,04,01,06,00,00,8000,0000

; Room $97B5, door list index 0: Door
$83:8B92             dx 975C,00,05,2E,06,02,00,8000,0000

; Room $97B5, door list index 1: Door
$83:8B9E             dx 9E9F,F0,02,00,00,05,00,0000,0000

; Room $9804, door list index 0: Door
$83:8BAA             dx 9879,00,05,2E,06,02,00,8000,0000

; Room $9879, door list index 0: Door
$83:8BB6             dx 92FD,00,05,3E,26,03,02,8000,B9A2

; Room $9879, door list index 1: Door
$83:8BC2             dx 9804,00,04,01,06,00,00,8000,0000

; Room $98E2, door list index 0: Door
$83:8BCE             dx 92FD,00,05,1E,36,01,03,8000,B981

; Room $98E2, door list index 1: Door
$83:8BDA             dx 9994,00,04,01,06,00,00,8000,0000

; Room $990D, door list index 0: Door
$83:8BE6             dx 99BD,00,05,0E,46,00,04,8000,0000

; Room $990D, door list index 1: Door
$83:8BF2             dx 92FD,00,04,01,06,00,00,8000,B98C

; Room $9938, door list index 0: Door
$83:8BFE             dx 9969,00,04,01,06,00,00,8000,0000

; Room $9938, door list index 1: Door
$83:8C0A             dx 9AD9,C0,02,00,00,00,00,0000,BD25

; Room $9969, door list index 0: Door
$83:8C16             dx 99BD,00,04,01,66,00,06,8000,0000

; Room $9969, door list index 1: Door
; Crateria load station Bh
$83:8C22             dx 9938,00,05,0E,06,00,00,8000,0000

; Room $9994, door list index 0: Door
$83:8C2E             dx 98E2,00,05,2E,06,02,00,8000,0000

; Room $99BD, door list index 0: Door
$83:8C3A             dx 990D,00,04,01,26,00,02,8000,0000

; Room $99BD, door list index 1: Door
$83:8C46             dx 9969,00,05,3E,06,03,00,8000,0000

; Room $99BD, door list index 2: Door
$83:8C52             dx A5ED,00,04,01,06,00,00,8000,0000

; Room $99BD, door list index 3: Door
$83:8C5E             dx 965B,00,04,01,06,00,00,8000,BA16

; Room $99F9, door list index 0: Door
$83:8C6A             dx 96BA,00,05,2E,06,02,00,8000,BA00

; Room $99F9, door list index 1: Door
$83:8C76             dx 96BA,00,05,2E,76,02,07,8000,BA0B

; Room $9A44, door list index 0: Door
$83:8C82             dx 9A90,00,05,0E,06,00,00,8000,0000

; Room $9A44, door list index 1: Door
$83:8C8E             dx 92FD,00,04,11,36,01,03,8000,B981

; Room $9A90, door list index 0: Door
$83:8C9A             dx 9A44,00,04,01,06,00,00,8000,0000

; Room $9AD9, door list index 0: Door
$83:8CA6             dx 9938,D0,03,00,00,00,00,0000,BE36

; Room $9AD9, door list index 1: Door
$83:8CB2             dx 9B9D,00,05,2E,06,02,00,8000,0000

; Room $9AD9, door list index 2: Door
$83:8CBE             dx 9FE5,00,05,0E,06,00,00,8000,0000

; Room $9AD9, door list index 3: Door
$83:8CCA             dx 9C5E,00,05,2E,06,02,00,8000,0000

; Room $9AD9, door list index 4: Door
$83:8CD6             dx 9BC8,00,04,01,16,00,01,8000,0000

; Room $9AD9, door list index 5: Door
$83:8CE2             dx 9CB3,00,04,01,06,00,00,8000,BD6C

; Room $9AD9, door list index 6: Door
$83:8CEE             dx 9AD9,00,04,01,76,01,07,8000,BD25

; Room $9AD9, door list index 7: Door
$83:8CFA             dx A011,00,05,4E,16,04,01,8000,BD16

; Room $9AD9, door list index 8: Door
$83:8D06             dx 9AD9,00,05,0E,76,00,07,8000,BD07

; Room $9AD9, door list index A: Door
; Brinstar load station 1
$83:8D12             dx A201,00,05,0E,06,00,00,8000,0000

; Room $9B5B, door list index 0: Door
$83:8D1E             dx A0A4,00,05,2E,06,02,00,8000,0000

; Room $9B5B, door list index 1: Door
$83:8D2A             dx 9DC7,00,05,0E,06,00,00,8000,0000

; Room $9B9D, door list index 0: Door
$83:8D36             dx 9C35,00,05,0E,06,00,00,8000,0000

; Room $9B9D, door list index 1: Door
; Brinstar load station 8 / 10h
$83:8D42             dx 9AD9,00,04,01,46,00,04,8000,0000

; Room $9BC8, door list index 0: Door
$83:8D4E             dx 9AD9,00,05,0E,46,00,04,8000,0000

; Room $9BC8, door list index 1: Door
$83:8D5A             dx 9C07,00,04,01,06,00,00,8000,0000

; Room $9C07, door list index 0: Door
$83:8D66             dx 9BC8,00,05,2E,16,02,01,8000,0000

; Room $9C35, door list index 0: Door
$83:8D72             dx 9B9D,00,04,01,06,00,00,8000,0000

; Room $9C5E, door list index 0: Door
$83:8D7E             dx 9C89,00,05,0E,06,00,00,8000,0000

; Room $9C5E, door list index 1: Door
$83:8D8A             dx 9AD9,00,04,01,66,00,06,8000,0000

; Room $9C89, door list index 0: Door
$83:8D96             dx 9C5E,00,04,01,16,00,01,8000,0000

; Room $9CB3, door list index 0: Door
$83:8DA2             dx 9AD9,00,05,0E,66,00,06,8000,0000

; Room $9CB3, door list index 1: Door
$83:8DAE             dx 9D19,00,04,21,26,02,02,8000,0000

; Room $9CB3, door list index 2: Door
$83:8DBA             dx A07B,00,05,0E,06,00,00,8000,0000

; Room $9D19, door list index 0: Door
$83:8DC6             dx 9D9C,00,04,01,06,00,00,8000,0000

; Room $9D19, door list index 1: Door
$83:8DD2             dx 9CB3,00,05,6E,06,06,00,8000,0000

; Room $9D19, door list index 2: Door
$83:8DDE             dx 9E11,00,05,1E,16,01,01,8000,BD30

; Room $9D19, door list index 3: Door
$83:8DEA             dx 9E52,00,04,01,06,00,00,8000,0000

; Room $9D19, door list index 4: Door
; Brinstar load station 0
$83:8DF6             dx A184,00,05,0E,06,00,00,8000,0000

; Room $9D19, door list index 5: Door
$83:8E02             dx 9E11,00,01,1E,06,01,00,8000,0000

; Room $9D19, door list index 6: Door
$83:8E0E             dx A0D2,00,05,6E,06,06,00,8000,0000

; Room $9D19, door list index 7: Door
$83:8E1A             dx A130,00,04,01,16,00,01,8000,0000

; Room $9D19, door list index 8: Door
$83:8E26             dx A0A4,00,04,01,06,00,00,8000,0000

; Room $9D9C, door list index 0: Door
$83:8E32             dx 9D19,00,05,3E,06,03,00,8000,0000

; Room $9D9C, door list index 1: Door
$83:8E3E             dx 9DC7,00,07,06,2E,00,02,8000,0000

; Room $9DC7, door list index 0: Door
$83:8E4A             dx 9B5B,00,04,01,06,00,00,8000,BDC0

; Room $9DC7, door list index 1: Door
$83:8E56             dx 9D9C,00,06,36,03,03,00,8000,0000

; Room $9E11, door list index 0: Door
; Brinstar load station 12h
$83:8E62             dx 9D19,00,00,00,00,02,03,8000,0000

; Room $9E11, door list index 1: Door
$83:8E6E             dx 9D19,00,04,21,46,02,04,8000,0000

; Room $9E52, door list index 0: Door
$83:8E7A             dx 9D19,00,05,3E,66,03,06,8000,0000

; Room $9E52, door list index 1: Door
; Brinstar load station 9
$83:8E86             dx 9E9F,00,04,01,26,00,02,8000,0000

; Room $9E52, door list index 2: Door
$83:8E92             dx 9FBA,00,04,01,06,00,00,8000,0000

; Room $9E9F, door list index 0: Door
$83:8E9E             dx 9E52,00,05,1E,06,01,00,8000,0000

; Room $9E9F, door list index 1: Door
$83:8EAA             dx 9F11,00,04,01,06,00,00,8000,0000

; Room $9E9F, door list index 2: Door
$83:8EB6             dx 97B5,E0,03,00,00,00,00,0000,0000

; Room $9F11, door list index 0: Door
$83:8EC2             dx 9E9F,00,05,7E,26,07,02,8000,0000

; Room $9F11, door list index 1: Door
$83:8ECE             dx 9F64,00,04,01,26,00,02,8000,0000

; Room $9F11, door list index 2: Door
$83:8EDA             dx A107,00,05,0E,06,00,00,8000,0000

; Room $9F64, door list index 0: Door
$83:8EE6             dx 9F11,00,05,0E,06,00,00,8000,0000

; Room $9F64, door list index 1: Door
$83:8EF2             dx A1AD,00,05,1E,06,01,00,8000,0000

; Room $9FBA, door list index 0: Door
$83:8EFE             dx 9E52,00,05,7E,36,07,03,8000,0000

; Room $9FBA, door list index 1: Door
$83:8F0A             dx A253,00,04,01,46,00,04,8000,0000

; Room $9FE5, door list index 0: Door
$83:8F16             dx 9AD9,00,04,01,A6,00,0A,8000,BD07

; Room $9FE5, door list index 1: Door
$83:8F22             dx A011,00,05,1E,06,01,00,8000,0000

; Room $A011, door list index 0: Door
$83:8F2E             dx 9FE5,00,04,01,06,00,00,8000,0000

; Room $A011, door list index 1: Door
$83:8F3A             dx A051,00,05,0E,06,00,00,8000,0000

; Room $A011, door list index 2: Door
$83:8F46             dx 9AD9,00,04,21,B6,02,0B,8000,BD25

; Room $A011, door list index 3: Door
; Brinstar load station 2
$83:8F52             dx A22A,00,05,0E,06,00,00,8000,0000

; Room $A051, door list index 0: Door
$83:8F5E             dx A011,00,04,01,06,00,00,8000,0000

; Room $A07B, door list index 0: Door
$83:8F6A             dx 9CB3,00,04,01,66,00,06,8000,BD50

; Room $A0A4, door list index 0: Door
$83:8F76             dx 9B5B,00,04,01,86,00,08,8000,0000

; Room $A0A4, door list index 1: Door
$83:8F82             dx 9D19,00,05,4E,56,04,05,8000,BD5B

; Room $A0D2, door list index 0: Door
$83:8F8E             dx 9D19,00,04,01,96,00,09,8000,BD77

; Room $A0D2, door list index 1: Door
; Unused
$83:8F9A             dx A641,00,06,16,03,01,00,8000,0000

; Room $A107, door list index 0: Door
$83:8FA6             dx 9F11,00,04,01,16,00,01,8000,BE25

; Room $A130, door list index 0: Door
$83:8FB2             dx 9D19,00,05,3E,46,03,04,8000,0000

; Room $A130, door list index 1: Door
$83:8FBE             dx A15B,00,04,01,06,00,00,8000,0000

; Room $A15B, door list index 0: Door
$83:8FCA             dx A130,00,05,1E,16,01,01,8000,0000

; Room $A184, door list index 0: Door
$83:8FD6             dx 9D19,00,04,11,06,01,00,8000,BE00

; Room $A1AD, door list index 0: Door
$83:8FE2             dx 9F64,00,04,21,06,02,00,8000,BD8A

; Room $A1AD, door list index 1: Door
$83:8FEE             dx A1D8,00,05,0E,06,00,00,8000,0000

; Room $A1D8, door list index 0: Door
$83:8FFA             dx A1AD,00,04,01,06,00,00,8000,0000

; Room $A201, door list index 0: Door
$83:9006             dx 9AD9,00,04,01,56,00,05,8000,0000

; Room $A22A, door list index 0: Door
$83:9012             dx A011,00,04,01,16,00,01,8000,BD16

; Room $A253, door list index 0: Door
$83:901E             dx A2F7,00,04,01,06,00,00,8000,0000

; Room $A253, door list index 1: Door
$83:902A             dx 9FBA,00,05,5E,06,05,00,8000,0000

; Room $A253, door list index 2: Door
$83:9036             dx A293,00,05,7E,06,07,00,8000,0000

; Room $A253, door list index 3: Door
$83:9042             dx A3DD,00,04,01,06,00,00,8000,0000

; Room $A253, door list index 4: Door
$83:904E             dx A618,00,05,0E,06,00,00,8000,0000

; Room $A293, door list index 0: Door
$83:905A             dx A2CE,00,05,1E,06,01,00,8000,0000

; Room $A293, door list index 1: Door
$83:9066             dx A253,00,04,01,66,00,06,8000,0000

; Room $A2CE, door list index 0: Door
$83:9072             dx A293,00,04,01,06,00,00,8000,0000

; Room $A2F7, door list index 0: Door
$83:907E             dx A253,00,05,0E,06,00,00,8000,0000

; Room $A2F7, door list index 1: Door
; Brinstar load station Ah
$83:908A             dx A322,00,04,01,56,00,05,8000,BE1A

; Room $A322, door list index 0: Door
$83:9096             dx A3AE,00,05,2E,06,02,00,8000,0000

; Room $A322, door list index 1: Door
$83:90A2             dx A37C,00,05,1E,06,01,00,8000,0000

; Room $A322, door list index 2: Door
$83:90AE             dx A2F7,00,05,2E,06,02,00,8000,0000

; Room $A322, door list index 3: Door
$83:90BA             dx 962A,F0,03,00,00,00,00,0000,0000

; Room $A322, door list index 4: Door
$83:90C6             dx D104,40,04,01,06,00,00,8000,BDAF

; Room $A322, door list index 6: Door
; Brinstar load station 4
$83:90D2             dx A734,00,04,01,06,00,00,8000,0000

; Room $A37C, door list index 0: Door
$83:90DE             dx A322,00,04,01,36,00,03,8000,0000

; Room $A3AE, door list index 0: Door
$83:90EA             dx A322,00,04,01,76,00,07,8000,BE0B

; Room $A3DD, door list index 0: Door
$83:90F6             dx A253,00,05,0E,96,00,09,8000,BDA0

; Room $A3DD, door list index 1: Door
$83:9102             dx A408,00,04,01,16,00,01,8000,0000

; Room $A408, door list index 0: Door
$83:910E             dx A3DD,00,05,1E,06,01,00,8000,0000

; Room $A408, door list index 1: Door
$83:911A             dx CF54,40,04,01,06,00,00,8000,0000

; Room $A408, door list index 2: Door
$83:9126             dx A447,00,04,01,06,00,00,8000,0000

; Room $A447, door list index 0: Door
$83:9132             dx A408,00,05,1E,06,01,00,8000,BDF1

; Room $A471, door list index 0: Door
$83:913E             dx A6A1,00,05,2E,06,02,00,8000,BD3F

; Room $A471, door list index 1: Door
$83:914A             dx A4B1,00,05,0E,06,00,00,8000,0000

; Room $A471, door list index 2: Door
$83:9156             dx A4DA,00,07,06,0C,00,00,0240,0000

; Room $A4B1, door list index 0: Door
$83:9162             dx A471,00,04,01,16,00,01,8000,0000

; Room $A4DA, door list index 0: Door
$83:916E             dx A471,00,06,16,13,01,01,01C0,0000

; Room $A4DA, door list index 1: Door
$83:917A             dx A521,00,04,01,06,00,00,8000,0000

; Room $A4DA, door list index 2: Door
; Brinstar load station 3
$83:9186             dx A70B,00,04,01,06,00,00,8000,0000

; Room $A521, door list index 0: Door
$83:9192             dx A4DA,00,05,1E,16,01,01,8000,0000

; Room $A521, door list index 1: Door
$83:919E             dx A56B,00,04,01,16,00,01,8000,0000

; Room $A56B, door list index 0: Door
$83:91AA             dx A521,00,05,5E,06,05,00,8000,0000

; Room $A56B, door list index 1: Door
$83:91B6             dx A59F,00,04,01,16,00,01,8000,0000

; Room $A56B, door list index 2: Door
$83:91C2             dx A641,00,04,01,06,00,00,8000,0000

; Room $A59F, door list index 0: Door
; Brinstar load station 11h
$83:91CE             dx A56B,00,05,1E,16,01,01,8000,0000

; Room $A59F, door list index 1: Door
$83:91DA             dx A6E2,00,04,01,06,00,00,8000,0000

; Room $A5ED, door list index 0: Door
$83:91E6             dx 99BD,00,05,0E,66,00,06,8000,0000

; Room $A5ED, door list index 1: Door
; Crateria load station Ch
$83:91F2             dx A66A,00,04,01,06,00,00,8000,0000

; Room $A618, door list index 0: Door
$83:91FE             dx A253,00,04,01,96,00,09,8000,BDA0

; Room $A641, door list index 0: Door
$83:920A             dx A56B,00,05,0E,06,00,00,8000,BD95

; Room $A66A, door list index 0: Door
$83:9216             dx A5ED,00,05,4E,06,04,00,8000,0000

; Room $A66A, door list index 1: Door
$83:9222             dx DAAE,D0,02,00,00,00,00,0000,0000

; Room $A6A1, door list index 0: Door
$83:922E             dx CF80,40,05,0E,16,00,01,8000,BDD1

; Room $A6A1, door list index 1: Door
$83:923A             dx A471,00,04,01,06,00,00,8000,0000

; Room $A6A1, door list index 2: Door
$83:9246             dx A7DE,C0,02,00,00,00,00,0000,0000

; Room $A6E2, door list index 0: Door
$83:9252             dx A59F,00,05,1E,16,01,01,8000,0000

; Room $A70B, door list index 0: Door
$83:925E             dx A4DA,00,05,3E,06,03,00,8000,BDE2

; Room $A734, door list index 0: Door
$83:926A             dx A322,00,05,0E,46,00,04,8000,0000

; Room $A75D, door list index 0: Door
$83:9276             dx A815,00,04,31,26,03,02,8000,0000

; Room $A75D, door list index 1: Door
$83:9282             dx A8B9,00,05,0E,26,00,02,8000,0000

; Room $A788, door list index 0: Door
$83:928E             dx A7B3,00,05,2E,06,02,00,8000,0000

; Room $A788, door list index 1: Door
$83:929A             dx AFA3,00,04,01,06,00,00,8000,0000

; Room $A7B3, door list index 0: Door
; Norfair load station 8
$83:92A6             dx A7DE,00,05,0E,36,00,03,8000,0000

; Room $A7B3, door list index 1: Door
$83:92B2             dx A788,00,04,01,06,00,00,8000,0000

; Room $A7DE, door list index 0: Door
$83:92BE             dx A815,00,05,6E,26,06,02,8000,0000

; Room $A7DE, door list index 1: Door
$83:92CA             dx A7B3,00,04,01,06,00,00,8000,0000

; Room $A7DE, door list index 2: Door
$83:92D6             dx AA41,00,05,1E,06,01,00,8000,0000

; Room $A7DE, door list index 3: Door
$83:92E2             dx AA0E,00,04,01,06,00,00,8000,0000

; Room $A7DE, door list index 4: Door
$83:92EE             dx A6A1,D0,03,00,00,00,00,0000,0000

; Room $A7DE, door list index 6: Door
$83:92FA             dx B167,00,04,01,06,00,00,8000,0000

; Room $A7DE, door list index 7: Door
$83:9306             dx B0B4,00,05,0E,06,00,00,8000,0000

; Room $A815, door list index 0: Door
$83:9312             dx A865,00,05,1E,06,01,00,8000,0000

; Room $A815, door list index 1: Door
$83:931E             dx A75D,00,05,1E,06,01,00,8000,0000

; Room $A815, door list index 2: Door
; Norfair load station 10h
$83:932A             dx A7DE,00,04,01,36,00,03,8000,0000

; Room $A815, door list index 3: Door
$83:9336             dx A8F8,00,05,0E,06,00,00,8000,0000

; Room $A865, door list index 0: Door
$83:9342             dx A8B9,00,05,0E,06,00,00,8000,0000

; Room $A865, door list index 1: Door
$83:934E             dx A815,00,04,31,06,03,00,8000,BFFA

; Room $A890, door list index 0: Door
$83:935A             dx A8B9,00,05,1E,16,01,01,8000,C03A

; Room $A8B9, door list index 0: Door
$83:9366             dx A75D,00,04,01,06,00,00,8000,0000

; Room $A8B9, door list index 1: Door
$83:9372             dx A865,00,04,01,06,00,00,8000,0000

; Room $A8B9, door list index 2: Door
$83:937E             dx A890,00,04,01,06,00,00,8000,0000

; Room $A8F8, door list index 0: Door
$83:938A             dx A815,00,04,01,36,00,03,8000,C0EF

; Room $A8F8, door list index 1: Door
$83:9396             dx A923,00,04,01,06,00,00,8000,0000

; Room $A923, door list index 0: Door
$83:93A2             dx A8F8,00,05,0E,36,00,03,8000,0000

; Room $A923, door list index 1: Door
$83:93AE             dx AA0E,00,05,3E,16,03,01,8000,0000

; Room $A923, door list index 2: Door
; Norfair load station 3
$83:93BA             dx B192,00,04,01,06,00,00,8000,0000

; Room $A923, door list index 3: Door
$83:93C6             dx AFCE,00,04,01,06,00,00,8000,0000

; Room $A923, door list index 4: Door
$83:93D2             dx A98D,00,06,36,02,03,00,8000,0000

; Room $A98D, door list index 0: Door
$83:93DE             dx AA82,00,05,1E,06,01,00,8000,0000

; Room $A98D, door list index 1: Door
; Norfair load station 11h
$83:93EA             dx A923,00,07,C6,2D,0C,02,01C0,0000

; Room $A9E5, door list index 0: Door
$83:93F6             dx AA41,00,04,01,16,00,01,8000,C016

; Room $AA0E, door list index 0: Door
$83:9402             dx A7DE,00,05,0E,66,00,06,8000,0000

; Room $AA0E, door list index 1: Door
$83:940E             dx A923,00,04,C1,06,0C,00,8000,0000

; Room $AA41, door list index 0: Door
$83:941A             dx A7DE,00,04,01,56,00,05,8000,0000

; Room $AA41, door list index 1: Door
$83:9426             dx A9E5,00,05,0E,06,00,00,8000,0000

; Room $AA82, door list index 0: Door
$83:9432             dx A98D,00,04,01,06,00,00,8000,BFDA

; Room $AA82, door list index 1: Door
$83:943E             dx AADE,00,05,0E,06,00,00,8000,0000

; Room $AA82, door list index 2: Door
$83:944A             dx AB07,00,06,06,02,00,00,8000,0000

; Room $AA82, door list index 3: Door
; Norfair load station 0
$83:9456             dx AAB5,00,04,01,06,00,00,8000,0000

; Room $AAB5, door list index 0: Door
$83:9462             dx AA82,00,05,1E,16,01,01,8000,0000

; Room $AADE, door list index 0: Door
; Norfair load station 13h
$83:946E             dx AA82,00,04,01,06,00,00,8000,0000

; Room $AB07, door list index 0: Door
$83:947A             dx AA82,00,07,06,1D,00,01,01C0,0000

; Room $AB07, door list index 1: Door
$83:9486             dx AB64,00,05,2E,06,02,00,8000,0000

; Room $AB07, door list index 2: Door
$83:9492             dx AB3B,00,04,01,06,00,00,8000,0000

; Room $AB07, door list index 3: Door
$83:949E             dx AB8F,00,06,66,22,06,02,0140,0000

; Room $AB3B, door list index 0: Door
$83:94AA             dx AB07,00,05,0E,36,00,03,8000,0000

; Room $AB64, door list index 0: Door
$83:94B6             dx ABD2,00,05,0E,06,00,00,8000,0000

; Room $AB64, door list index 1: Door
$83:94C2             dx AB07,00,04,01,06,00,00,8000,0000

; Room $AB8F, door list index 0: Door
$83:94CE             dx AB07,00,07,06,4D,00,04,01C0,0000

; Room $AB8F, door list index 1: Door
$83:94DA             dx AC2B,00,05,0E,26,00,02,8000,0000

; Room $ABD2, door list index 0: Door
$83:94E6             dx AC00,00,05,1E,06,01,00,8000,0000

; Room $ABD2, door list index 1: Door
$83:94F2             dx AB64,00,04,01,06,00,00,8000,0000

; Room $AC00, door list index 0: Door
$83:94FE             dx AC2B,00,05,0E,06,00,00,8000,0000

; Room $AC00, door list index 1: Door
$83:950A             dx ABD2,00,04,01,26,00,02,8000,0000

; Room $AC2B, door list index 0: Door
$83:9516             dx AB8F,00,04,01,16,00,01,8000,0000

; Room $AC2B, door list index 1: Door
$83:9522             dx AC00,00,04,01,06,00,00,8000,0000

; Room $AC5A, door list index 0: Door
$83:952E             dx AC83,00,04,01,06,00,00,8000,C0D3

; Room $AC83, door list index 0: Door
$83:953A             dx ACB3,00,04,01,06,00,00,8000,0000

; Room $AC83, door list index 1: Door
$83:9546             dx AC5A,00,05,1E,06,01,00,8000,0000

; Room $ACB3, door list index 0: Door
$83:9552             dx AC83,00,05,1E,06,01,00,8000,0000

; Room $ACB3, door list index 1: Door
$83:955E             dx AFA3,00,05,4E,06,04,00,8000,0000

; Room $ACB3, door list index 2: Door
$83:956A             dx AF72,00,05,1E,06,01,00,8000,0000

; Room $ACB3, door list index 3: Door
$83:9576             dx AEDF,00,06,06,02,00,00,8000,C0DE

; Room $ACB3, door list index 4: Door
$83:9582             dx AD5E,00,04,01,06,00,00,8000,0000

; Room $ACB3, door list index 5: Door
$83:958E             dx B07A,00,04,01,16,00,01,8000,0000

; Room $ACB3, door list index 6: Door
; Norfair load station 1
$83:959A             dx B0DD,00,05,0E,06,00,00,8000,0000

; Room $ACF0, door list index 0: Door
$83:95A6             dx B07A,00,05,0E,06,00,00,8000,BFE9

; Room $ACF0, door list index 1: Door
$83:95B2             dx AD1B,00,04,01,06,00,00,8000,0000

; Room $AD1B, door list index 0: Door
$83:95BE             dx ACF0,00,05,BE,16,0B,01,8000,0000

; Room $AD5E, door list index 0: Door
$83:95CA             dx ACB3,00,05,1E,16,01,01,8000,0000

; Room $AD5E, door list index 1: Door
$83:95D6             dx ADAD,00,04,01,06,00,00,8000,0000

; Room $AD5E, door list index 2: Door
$83:95E2             dx ADAD,00,04,01,16,00,01,8000,0000

; Room $AD5E, door list index 3: Door
$83:95EE             dx AE07,00,04,01,06,00,00,8000,0000

; Room $AD5E, door list index 4: Door
$83:95FA             dx B656,00,04,11,06,01,00,8000,0000

; Room $ADAD, door list index 0: Door
$83:9606             dx AD5E,00,05,0E,16,00,01,8000,0000

; Room $ADAD, door list index 1: Door
$83:9612             dx AD5E,00,05,0E,26,00,02,8000,0000

; Room $ADAD, door list index 2: Door
$83:961E             dx ADDE,00,04,01,06,00,00,8000,0000

; Room $ADDE, door list index 0: Door
$83:962A             dx ADAD,00,05,3E,06,03,00,8000,0000

; Room $AE07, door list index 0: Door
$83:9636             dx AD5E,00,05,0E,36,00,03,8000,0000

; Room $AE07, door list index 1: Door
$83:9642             dx AE32,00,04,21,06,02,00,8000,0000

; Room $AE32, door list index 0: Door
$83:964E             dx AE07,00,05,3E,06,03,00,8000,0000

; Room $AE32, door list index 1: Door
$83:965A             dx AE74,00,05,1E,06,01,00,8000,0000

; Room $AE74, door list index 0: Door
$83:9666             dx AEB4,00,05,2E,06,02,00,8000,0000

; Room $AE74, door list index 1: Door
$83:9672             dx AE32,00,04,01,26,00,02,8000,C025

; Room $AE74, door list index 2: Door
$83:967E             dx AF14,00,05,3E,06,03,00,8000,0000

; Room $AE74, door list index 3: Door
$83:968A             dx AFFB,00,05,3E,06,03,00,8000,0000

; Room $AEB4, door list index 0: Door
$83:9696             dx AEDF,00,05,0E,26,00,02,8000,0000

; Room $AEB4, door list index 1: Door
$83:96A2             dx AE74,00,04,11,06,01,00,8000,0000

; Room $AEDF, door list index 0: Door
$83:96AE             dx ACB3,00,07,06,3D,00,03,01C0,0000

; Room $AEDF, door list index 1: Door
$83:96BA             dx AEB4,00,04,01,06,00,00,8000,0000

; Room $AEDF, door list index 2: Door
$83:96C6             dx B051,00,04,01,06,00,00,8000,0000

; Room $AF14, door list index 0: Door
$83:96D2             dx AE74,00,04,11,26,01,02,8000,0000

; Room $AF14, door list index 1: Door
; Norfair load station 9
$83:96DE             dx AF3F,00,05,0E,06,00,00,8000,0000

; Room $AF3F, door list index 0: Door
$83:96EA             dx AF14,00,04,01,06,00,00,8000,0000

; Room $AF3F, door list index 1: Door
$83:96F6             dx B236,A0,02,00,00,04,00,0000,0000

; Room $AF3F, door list index 3: Door
; Norfair load station 4
$83:9702             dx B1BB,00,05,0E,06,00,00,8000,0000

; Room $AF72, door list index 0: Door
$83:970E             dx B106,00,05,7E,06,07,00,8000,0000

; Room $AF72, door list index 1: Door
$83:971A             dx ACB3,00,04,01,36,00,03,8000,0000

; Room $AF72, door list index 2: Door
$83:9726             dx B139,00,05,0E,06,00,00,8000,0000

; Room $AFA3, door list index 0: Door
$83:9732             dx A788,00,05,2E,16,02,01,8000,0000

; Room $AFA3, door list index 1: Door
$83:973E             dx ACB3,00,04,01,26,00,02,8000,0000

; Room $AFCE, door list index 0: Door
$83:974A             dx A923,00,05,CE,26,0C,02,8000,0000

; Room $AFCE, door list index 1: Door
$83:9756             dx B026,00,04,01,06,00,00,8000,0000

; Room $AFCE, door list index 2: Door
$83:9762             dx B139,00,07,06,2D,00,02,0200,0000

; Room $AFFB, door list index 0: Door
$83:976E             dx B026,00,05,0E,06,00,00,8000,0000

; Room $AFFB, door list index 1: Door
$83:977A             dx AE74,00,04,01,16,00,01,8000,C0FA

; Room $B026, door list index 0: Door
$83:9786             dx AFCE,00,05,3E,06,03,00,8000,0000

; Room $B026, door list index 1: Door
$83:9792             dx AFFB,00,04,01,06,00,00,8000,0000

; Room $B051, door list index 0: Door
$83:979E             dx AEDF,00,05,0E,16,00,01,8000,0000

; Room $B07A, door list index 0: Door
$83:97AA             dx ACB3,00,05,1E,06,01,00,8000,0000

; Room $B07A, door list index 1: Door
$83:97B6             dx ACF0,00,04,01,06,00,00,8000,0000

; Room $B0B4, door list index 0: Door
$83:97C2             dx A7DE,00,04,01,46,00,04,8000,0000

; Room $B0DD, door list index 0: Door
$83:97CE             dx ACB3,00,04,01,16,00,01,8000,0000

; Room $B106, door list index 0: Door
; Norfair load station 2
$83:97DA             dx B167,00,05,0E,06,00,00,8000,0000

; Room $B106, door list index 1: Door
$83:97E6             dx AF72,00,04,01,06,00,00,8000,0000

; Room $B139, door list index 0: Door
$83:97F2             dx AF72,00,04,01,16,00,01,8000,0000

; Room $B139, door list index 1: Door
$83:97FE             dx AFCE,00,06,36,02,03,00,0140,0000

; Room $B167, door list index 0: Door
$83:980A             dx B106,00,04,01,06,00,00,8000,0000

; Room $B167, door list index 1: Door
$83:9816             dx A7DE,00,05,0E,56,00,05,8000,0000

; Room $B192, door list index 0: Door
$83:9822             dx A923,00,05,AE,16,0C,01,8000,0000

; Room $B1BB, door list index 0: Door
$83:982E             dx AF3F,00,04,01,06,00,00,8000,0000

; Room $B1E5, door list index 0: Door
; Norfair load station 16h
$83:983A             dx B283,00,04,01,06,00,00,8000,C089

; Room $B1E5, door list index 1: Door
; Norfair load station Ah / 14h
$83:9846             dx B236,00,04,01,26,00,02,8000,0000

; Room $B236, door list index 0: Door
$83:9852             dx B1E5,00,05,1E,06,01,00,8000,0000

; Room $B236, door list index 1: Door
$83:985E             dx B3A5,00,04,01,16,00,01,8000,0000

; Room $B236, door list index 2: Door
$83:986A             dx AF3F,B0,03,00,00,00,00,0000,0000

; Room $B283, door list index 0: Door
$83:9876             dx B1E5,00,05,2E,26,02,02,8000,BF9E

; Room $B283, door list index 1: Door
$83:9882             dx B6C1,00,04,01,26,00,02,8000,0000

; Room $B2DA, door list index 0: Door
$83:988E             dx B6C1,00,05,0E,06,00,00,8000,0000

; Room $B2DA, door list index 1: Door
$83:989A             dx B3A5,00,04,01,26,00,02,8000,C056

; Room $B305, door list index 0: Door
; Norfair load station 15h
$83:98A6             dx B6C1,00,05,0E,16,00,01,8000,0000

; Room $B32E, door list index 0: Door
$83:98B2             dx B698,00,05,0E,06,00,00,8000,0000

; Room $B32E, door list index 1: Door
$83:98BE             dx B37A,00,04,01,06,00,00,8000,0000

; Room $B37A, door list index 0: Door
$83:98CA             dx B32E,00,05,0E,06,00,00,8000,0000

; Room $B37A, door list index 1: Door
$83:98D6             dx B482,00,04,01,06,00,00,8000,0000

; Room $B3A5, door list index 0: Door
$83:98E2             dx B236,00,05,7E,26,07,02,8000,0000

; Room $B3A5, door list index 1: Door
$83:98EE             dx B40A,00,04,01,36,00,03,8000,0000

; Room $B3A5, door list index 2: Door
$83:98FA             dx B236,00,05,7E,26,07,02,8000,0000

; Room $B3A5, door list index 3: Door
$83:9906             dx B2DA,00,05,3E,06,03,00,8000,0000

; Room $B3A5, door list index 4: Door
$83:9912             dx B457,00,04,01,06,00,00,8000,0000

; Room $B3E1, door list index 0: Door
$83:991E             dx B3A5,00,05,0E,06,00,00,8000,0000

; Room $B40A, door list index 0: Door
$83:992A             dx B3A5,00,05,0E,06,00,00,8000,0000

; Room $B40A, door list index 1: Door
$83:9936             dx B4AD,00,04,01,06,00,00,8000,C0A2

; Room $B457, door list index 0: Door
$83:9942             dx B3A5,00,05,0E,26,00,02,8000,C056

; Room $B457, door list index 1: Door
$83:994E             dx B4AD,00,04,01,56,00,05,8000,0000

; Room $B482, door list index 0: Door
; Norfair load station 12h
$83:995A             dx B37A,00,05,2E,06,02,00,8000,0000

; Room $B482, door list index 1: Door
$83:9966             dx B62B,00,04,01,06,00,00,8000,0000

; Room $B4AD, door list index 0: Door
$83:9972             dx B40A,00,05,3E,06,03,00,8000,C10B

; Room $B4AD, door list index 1: Door
$83:997E             dx B4E5,00,04,01,16,00,01,8000,0000

; Room $B4AD, door list index 2: Door
$83:998A             dx B457,00,05,3E,06,03,00,8000,0000

; Room $B4E5, door list index 0: Door
$83:9996             dx B4AD,00,05,0E,16,00,01,8000,0000

; Room $B4E5, door list index 1: Door
$83:99A2             dx B585,00,04,01,06,00,00,8000,C067

; Room $B510, door list index 0: Door
$83:99AE             dx B656,00,05,3E,26,03,02,8000,0000

; Room $B510, door list index 1: Door
$83:99BA             dx B6EE,00,04,01,06,00,00,8000,C0AD

; Room $B510, door list index 2: Door
$83:99C6             dx B55A,00,06,06,02,00,00,8000,0000

; Room $B55A, door list index 0: Door
$83:99D2             dx B6EE,00,05,1E,06,01,00,8000,C078

; Room $B55A, door list index 1: Door
$83:99DE             dx B510,00,07,46,0D,04,00,01C0,BFBB

; Room $B585, door list index 0: Door
$83:99EA             dx B5D5,00,06,56,02,05,00,8000,0000

; Room $B585, door list index 1: Door
$83:99F6             dx B4E5,00,05,3E,06,03,00,8000,0000

; Room $B585, door list index 2: Door
$83:9A02             dx B6EE,00,04,11,36,01,03,8000,0000

; Room $B585, door list index 3: Door
; Norfair load station 5
$83:9A0E             dx B741,00,04,01,06,00,00,8000,0000

; Room $B5D5, door list index 0: Door
$83:9A1A             dx B62B,00,05,2E,06,02,00,8000,0000

; Room $B5D5, door list index 1: Door
$83:9A26             dx B585,00,07,26,4D,02,04,0200,0000

; Room $B62B, door list index 0: Door
$83:9A32             dx B482,00,05,2E,06,02,00,8000,0000

; Room $B62B, door list index 1: Door
$83:9A3E             dx B5D5,00,04,11,26,01,02,8000,C04B

; Room $B656, door list index 0: Door
$83:9A4A             dx AD5E,00,05,5E,06,05,00,8000,0000

; Room $B656, door list index 1: Door
$83:9A56             dx B510,00,04,01,06,00,00,8000,0000

; Room $B698, door list index 0: Door
$83:9A62             dx B32E,00,04,01,16,00,01,8000,0000

; Room $B6C1, door list index 0: Door
$83:9A6E             dx B2DA,00,04,01,06,00,00,8000,0000

; Room $B6C1, door list index 1: Door
$83:9A7A             dx B305,00,04,01,06,00,00,8000,0000

; Room $B6C1, door list index 2: Door
$83:9A86             dx B283,00,05,1E,16,01,01,8000,0000

; Room $B6EE, door list index 0: Door
$83:9A92             dx B510,00,05,1E,16,01,01,8000,0000

; Room $B6EE, door list index 1: Door
$83:9A9E             dx B55A,00,04,01,06,00,00,8000,0000

; Room $B6EE, door list index 2: Door
$83:9AAA             dx B585,00,05,0E,06,00,00,8000,C0C2

; Room $B741, door list index 0: Door
$83:9AB6             dx B585,00,05,0E,36,00,03,8000,0000
}


;;; $9AC2: FX ;;;
{
; Room $C98E, state $C9BA: FX
$83:9AC2             dx 0000,01B0,FFFF,0000,00,00,02,02,00,01,0B,00

; Room $CA08, state $CA34: FX
$83:9AD2             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,00,00

; Room $CA52, state $CA7E: FX
$83:9AE2             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,10,00

; Room $CAAE, state $CADA: FX
$83:9AF2             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,18,00

; Room $CAF6, state $CB22: FX
$83:9B02             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,06,00

; Room $CB8B, state $CBB7: FX
$83:9B12             dx 0000,00A8,FFFF,0000,00,06,02,18,03,01,0A,48

; Room $CBD5, state $CC01: FX
$83:9B22             dx 0000,02A8,FFFF,0000,00,06,02,18,03,01,02,48

; Room $CC27, state $CC53: FX
$83:9B32             dx 0000,00B0,FFFF,0000,00,06,02,18,83,01,06,48

; Room $CC6F, state $CC9B: FX
$83:9B42             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,00,00

; Room $CCCB, state $CCF7: FX
$83:9B52             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CD13, state $CD3F: FX
$83:9B62             dx FFFF

; Room $CD5C, state $CD88: FX
$83:9B64             dx 0000,00A8,FFFF,0000,00,06,02,18,03,00,00,48

; Room $CDA8, state $CDD4: FX
$83:9B74             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,00,00

; Room $CDF1, state $CE1D: FX
$83:9B84             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,09,00

; Room $CE40, state $CE6C: FX
; Room $CE8A, state $CEB6: FX
$83:9B94             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,01,00,00

; Room $C98E, state $C9A0: FX
$83:9BA4             dx 0000,FFFF,FFFF,0000,00,00,28,02,00,00,00,00

; Room $CA08, state $CA1A: FX
$83:9BB4             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CA52, state $CA64: FX
$83:9BC4             dx 0000,FFFF,FFFF,0000,00,00,08,02,00,00,00,00

; Room $CAAE, state $CAC0: FX
$83:9BD4             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CAF6, state $CB08: FX
$83:9BE4             dx 0000,FFFF,FFFF,0000,00,00,08,02,00,00,00,00

; Room $CB8B, state $CB9D: FX
$83:9BF4             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CBD5, state $CBE7: FX
$83:9C04             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CC27, state $CC39: FX
$83:9C14             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CC6F, state $CC81: FX
$83:9C24             dx 0000,FFFF,FFFF,0000,00,00,28,02,00,00,00,00

; Room $CCCB, state $CCDD: FX
$83:9C34             dx 0000,FFFF,FFFF,0000,00,00,08,02,00,00,00,00

; Room $CD13, state $CD25: FX
$83:9C44             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CD5C, state $CD6E: FX
$83:9C54             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CDA8, state $CDBA: FX
$83:9C64             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CDF1, state $CE03: FX
; Room $CE40, state $CE52: FX
; Room $CE8A, state $CE9C: FX
$83:9C74             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $CED2, state $CEDF: FX
$83:9C84             dx 0000,0010,FFFF,0000,00,06,02,14,82,00,00,E2

; Room $CEFB, state $CF0D: FX
; Room $CEFB, state $CF27: FX
$83:9C94             dx 0000,0010,FFFF,0000,00,06,02,14,84,00,00,E2

; Room $CF54, state $CF61: FX
$83:9CA4             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,00,00,00

; Room $CF80, state $CF8D: FX
$83:9CB4             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,00,00,00

; Room $CFC9, state $CFD6: FX
$83:9CC4             dx 0000,0010,FFFF,0000,00,06,02,14,83,00,00,E2

; Room $D017, state $D024: FX
$83:9CD4             dx 0000,0010,FFFF,0000,00,06,02,14,83,00,00,E2

; Room $D055, state $D062: FX
$83:9CE4             dx 0000,02BA,FFFF,0000,00,06,02,14,80,00,00,E2

; Room $D08A, state $D097: FX
$83:9CF4             dx 0000,0010,FFFF,0000,00,06,02,14,80,00,00,E2

; Room $D0B9, state $D0C6: FX
$83:9D04             dx 0000,0010,FFFF,0000,00,06,02,14,83,00,00,E2

; Room $D104, state $D111: FX
$83:9D14             dx 0000,0180,FFFF,0000,00,06,02,14,81,00,00,E2

; Room $D13B, state $D148: FX
$83:9D24             dx 0000,01B5,FFFF,0000,00,06,02,14,83,00,00,42

; Room $D16D, state $D17A: FX
$83:9D34             dx 0000,01B5,FFFF,0000,00,06,02,14,83,00,00,42

; Room $D1A3, state $D1B0: FX
$83:9D44             dx 0000,0010,FFFF,0000,00,06,02,14,81,00,00,E2

; Room $D1DD, state $D1EA: FX
$83:9D54             dx 0000,01B5,FFFF,0000,00,06,02,14,83,00,00,42

; Room $D21C, state $D229: FX
$83:9D64             dx 0000,0010,FFFF,0000,00,06,02,14,80,00,00,E2

; Room $D252, state $D25F: FX
$83:9D74             dx 0000,0010,FFFF,0000,00,06,02,14,80,00,00,E2

; Room $D27E, state $D28B: FX
$83:9D84             dx 0000,FFFF,FFFF,0000,00,00,28,02,00,00,00,42

; Room $D2AA, state $D2B7: FX
$83:9D94             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,00,00,42

; Room $D2D9, state $D2E6: FX
$83:9DA4             dx 0000,00B5,FFFF,0000,00,06,02,14,83,00,00,42

; Room $D30B, state $D318: FX
$83:9DB4             dx 0000,05B5,FFFF,0000,00,06,02,14,83,00,02,42

; Room $D340, state $D34D: FX
$83:9DC4             dx 0000,03B4,FFFF,0000,00,06,02,14,83,00,00,42

; Room $D387, state $D394: FX
$83:9DD4             dx 0000,FFFF,FFFF,0000,00,00,28,02,00,00,00,42

; Room $D3B6, state $D3C3: FX
$83:9DE4             dx 0000,0010,FFFF,0000,00,06,02,14,82,00,00,E2

; Room $D3DF, state $D3EC: FX
$83:9DF4             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,42

; Room $D408, state $D415: FX
$83:9E04             dx A5AC,0080,FFFF,0000,00,06,02,14,85,00,00,E8, A678,0080,FFFF,0000,00,06,02,14,85,00,00,E8, 0000,0080,FFFF,0000,00,06,02,14,81,00,00,E8

; Room $D433, state $D440: FX
$83:9E34             dx 0000,00B5,FFFF,0000,00,06,02,14,83,01,00,42

; Room $D461, state $D46E: FX
$83:9E44             dx 0000,0010,FFFF,0000,00,06,02,14,82,01,0C,E8

; Room $D48E, state $D49B: FX
$83:9E54             dx 0000,0010,FFFF,0000,00,06,02,14,82,01,00,E8

; Room $D4C2, state $D4CF: FX
$83:9E64             dx 0000,0010,FFFF,0000,00,06,02,14,82,01,0C,E8

; Room $D4EF, state $D4FC: FX
$83:9E74             dx 0000,00D6,FFFF,0000,00,06,02,14,03,01,0C,EE

; Room $D51E, state $D52B: FX
$83:9E84             dx 0000,00D6,FFFF,0000,00,06,02,14,03,01,0C,EE

; Room $D54D, state $D55A: FX
; Room $D57A, state $D587: FX
$83:9E94             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,02,00,00

; Room $D5A7, state $D5B4: FX
$83:9EA4             dx 0000,0010,FFFF,0000,00,06,02,14,83,01,00,EE

; Room $D5EC, state $D5F9: FX
$83:9EB4             dx 0000,0049,FFFF,0000,00,06,02,14,83,01,0C,42

; Room $D617, state $D624: FX
$83:9EC4             dx 0000,0010,FFFF,0000,00,06,02,14,83,00,00,EE

; Room $D646, state $D653: FX
$83:9ED4             dx 0000,02B0,FFFF,0000,00,06,02,14,82,01,00,E8

; Room $D69A, state $D6A7: FX
$83:9EE4             dx 0000,00B0,FFFF,0000,00,06,02,14,82,01,00,E8

; Room $D6D0, state $D6DD: FX
$83:9EF4             dx 0000,00B0,FFFF,0000,00,06,02,14,82,01,00,E8

; Room $D6FD, state $D70A: FX
$83:9F04             dx 0000,0048,FFFF,0000,00,06,02,14,03,01,0C,EE

; Room $D72A, state $D737: FX
$83:9F14             dx 0000,0117,FFFF,0000,00,06,02,16,01,05,02,EE

; Room $D765, state $D772: FX
$83:9F24             dx 0000,0010,FFFF,0000,00,06,02,14,82,02,00,42

; Room $D78F, state $D7A1: FX
; Room $D78F, state $D7BB: FX
$83:9F34             dx 0000,00BF,FFFF,0000,00,06,02,14,83,00,00,EE

; Room $D7E4, state $D7F1: FX
$83:9F44             dx 0000,0010,FFFF,0000,00,06,02,14,83,01,00,EE

; Room $D81A, state $D827: FX
$83:9F54             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,EE

; Room $D845, state $D852: FX
$83:9F64             dx 0000,0000,FFFF,0000,00,06,02,14,03,00,00,EE

; Room $D86E, state $D87B: FX
; Room $D898, state $D8A5: FX
$83:9F74             dx 0000,FFFF,FFFF,0000,00,00,2A,02,00,02,00,00

; Room $D8C5, state $D8D7: FX
; Room $D8C5, state $D8F1: FX
$83:9F84             dx 0000,00B0,FFFF,0000,00,06,02,14,82,00,00,E8

; Room $D913, state $D920: FX
$83:9F94             dx 0000,0135,FFFF,0000,00,06,02,16,03,04,02,EE

; Room $D95E, state $D970: FX
; Room $D95E, state $D98A: FX
$83:9FA4             dx 0000,0010,FFFF,0000,00,06,02,14,83,02,00,EE

; Room $D9AA, state $D9B7: FX
$83:9FB4             dx 0000,0010,FFFF,0000,00,06,02,14,83,00,00,EE

; Room $D9D4, state $D9E1: FX
$83:9FC4             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,EE

; Room $D9FE, state $DA0B: FX
$83:9FD4             dx 0000,00B9,FFFF,0000,00,06,02,14,83,00,00,EE

; Room $DA2B, state $DA38: FX
$83:9FE4             dx 0000,0135,FFFF,0000,00,06,02,16,01,04,02,EE

; Room $DA60, state $DA72: FX
; Room $DA60, state $DA8C: FX
$83:9FF4             dx 0000,0010,FFFF,0000,00,06,02,14,81,00,00,42

; Room $DAAE, state $DABB: FX
$83:A004             dx 0000,03BC,FFFF,0000,00,04,02,1E,01,02,00,02

; Room $DAE1, state $DAF3: FX
; Room $DAE1, state $DB0D: FX
$83:A014             dx 0000,00D0,FFFF,0000,10,04,02,1E,01,02,00,02

; Room $DB31, state $DB43: FX
; Room $DB31, state $DB5D: FX
$83:A024             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,02,00,00

; Room $DB7D, state $DB8F: FX
; Room $DB7D, state $DBA9: FX
$83:A034             dx 0000,00D0,FFFF,0000,10,04,02,1E,01,02,00,02

; Room $DBCD, state $DBDF: FX
; Room $DBCD, state $DBF9: FX
$83:A044             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,02,00,00

; Room $DC19, state $DC2B: FX
; Room $DC19, state $DC45: FX
$83:A054             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,02,00,00

; Room $DC65, state $DC77: FX
; Room $DC65, state $DC91: FX
$83:A064             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,02,00,00

; Room $DCB1, state $DCC3: FX
; Room $DCB1, state $DCDD: FX
$83:A074             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,02,00,00

; Room $DCFF, state $DD0C: FX
$83:A084             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,02,00,00

; Room $DD2E, state $DD3B: FX
$83:A094             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $DD58, state $DD6E: FX
; Room $DD58, state $DD88: FX
$83:A0A4             dx 0000,00E8,FFFF,0000,10,04,02,1E,01,02,00,02

; FX. Set by Mother Brain
$83:A0B4             dx 0000,00E8,00B8,FFF0,10,04,02,1E,01,02,00,02

; FX. Set by Mother Brain
$83:A0C4             dx 0000,00B8,00E8,0030,10,04,02,1E,01,02,00,02

; Room $DDC4, state $DDD1: FX
$83:A0D4             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,02,00,00

; Room $DDF3, state $DE00: FX
$83:A0E4             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,02,00,00

; Room $DE23, state $DE30: FX
$83:A0F4             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,00,00,00

; Room $DE4D, state $DE5A: FX
$83:A104             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,78,00,00

; Room $DE7A, state $DE87: FX
$83:A114             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,70,00,00

; Room $DEA7, state $DEB4: FX
$83:A124             dx 0000,FFFF,FFFF,0000,00,00,02,02,00,70,00,00

; Room $DEDE, state $DEEB: FX
$83:A134             dx 0000,05E0,0010,0000,40,04,02,1E,01,70,02,00

; Room $DF1B, state $DF28: FX
$83:A144             dx FFFF

; Room $DF45, state $DF57: FX
; Room $DF45, state $DF71: FX
$83:A146             dx 0000,FFFF,FFFF,0000,00,2A,02,02,00,00,00,00

; Room $DF8D, state $DF9F: FX
$83:A156             dx FFFF

; Room $DFD7, state $DFE9: FX
$83:A158             dx FFFF

; Room $E021, state $E033: FX
$83:A15A             dx FFFF

; Room $E06B, state $E07D: FX
$83:A15C             dx FFFF

; Room $E0B5, state $E0C7: FX
$83:A15E             dx 0000,FFFF,FFFF,0000,00,28,02,02,00,00,00,00

; Unused. FX. Clone of $A146
$83:A16E             dx 0000,FFFF,FFFF,0000,00,2A,02,02,00,00,00,00

; Room $DF8D, state $DFB9: FX
$83:A17E             dx FFFF

; Room $DFD7, state $E003: FX
$83:A180             dx FFFF

; Room $E021, state $E04D: FX
$83:A182             dx FFFF

; Room $E06B, state $E097: FX
$83:A184             dx FFFF

; Room $E0B5, state $E0E1: FX
$83:A186             dx FFFF

; Room $DD58, state $DDA2: FX
; Room $E82C, state $E839: FX
$83:A188             dx FFFF
}


;;; $A18A: Door ;;;
{
; Room $D30B, door list index 3: Door
; Room $DAAE, door list index 2: Door
$83:A18A             dw 0000

; Room $C98E, door list index 0: Door
$83:A18C             dx 93FE,40,05,7E,16,07,01,8000,0000

; Room $C98E, door list index 1: Door
$83:A198             dx 968F,40,05,0E,06,00,00,8000,0000

; Room $C98E, door list index 2: Door
$83:A1A4             dx CE40,00,05,0E,06,00,00,8000,0000

; Room $CA08, door list index 0: Door
$83:A1B0             dx 93FE,40,05,7E,46,07,04,8000,0000

; Room $CA08, door list index 1: Door
$83:A1BC             dx CAF6,00,04,41,36,04,03,8000,0000

; Room $CA52, door list index 0: Door
$83:A1C8             dx CAF6,00,06,46,02,04,00,8000,0000

; Room $CA52, door list index 1: Door
$83:A1D4             dx CAAE,00,04,01,06,00,00,8000,0000

; Room $CA52, door list index 2: Door
$83:A1E0             dx 93FE,40,05,7E,06,07,00,8000,0000

; Room $CAAE, door list index 0: Door
$83:A1EC             dx CA52,00,05,6E,06,06,00,8000,0000

; Room $CAF6, door list index 0: Door
; Wrecked Ship load station 10h
$83:A1F8             dx CA08,00,05,3E,06,03,00,8000,E1D8

; Room $CAF6, door list index 1: Door
$83:A204             dx CD5C,00,04,01,06,00,00,8000,0000

; Room $CAF6, door list index 2: Door
$83:A210             dx CDA8,00,05,0E,06,00,00,8000,0000

; Room $CAF6, door list index 3: Door
$83:A21C             dx CC6F,00,06,26,02,02,00,8000,0000

; Room $CAF6, door list index 4: Door
$83:A228             dx CA52,00,07,46,0E,04,00,01C0,0000

; Room $CAF6, door list index 5: Door
$83:A234             dx CDF1,00,04,01,06,00,00,8000,0000

; Room $CAF6, door list index 6: Door
; Wrecked Ship load station 0
$83:A240             dx CE8A,00,04,01,06,00,00,8000,0000

; Room $CB8B, door list index 0: Door
$83:A24C             dx CD5C,00,05,1E,06,01,00,8000,E1E8

; Room $CB8B, door list index 1: Door
$83:A258             dx CBD5,00,04,01,26,00,02,8000,0000

; Room $CBD5, door list index 0: Door
$83:A264             dx 94FD,40,04,01,46,00,04,8000,0000

; Room $CBD5, door list index 1: Door
$83:A270             dx CB8B,00,05,1E,06,01,00,8000,0000

; Room $CBD5, door list index 2: Door
$83:A27C             dx CC27,00,05,2E,06,02,00,8000,0000

; Room $CC27, door list index 0: Door
$83:A288             dx CBD5,00,04,01,06,00,00,8000,E1F3

; Room $CC6F, door list index 0: Door
$83:A294             dx CAF6,00,07,46,7D,04,07,01C0,E21A

; Room $CC6F, door list index 1: Door
$83:A2A0             dx CCCB,00,05,0E,06,00,00,8000,0000

; Room $CC6F, door list index 2: Door
$83:A2AC             dx CD13,00,04,01,06,00,00,8000,0000

; Room $CCCB, door list index 0: Door
; Wrecked Ship load station 11h
$83:A2B8             dx CC6F,00,04,01,06,00,00,8000,0000

; Room $CD13, door list index 0: Door
$83:A2C4             dx CC6F,00,05,4E,06,04,00,8000,E1FE

; Room $CD5C, door list index 0: Door
$83:A2D0             dx CAF6,00,05,4E,46,04,04,8000,0000

; Room $CD5C, door list index 1: Door
$83:A2DC             dx CB8B,00,04,01,06,00,00,8000,0000

; Room $CDA8, door list index 0: Door
$83:A2E8             dx CAF6,00,04,41,66,04,06,8000,0000

; Room $CDF1, door list index 0: Door
$83:A2F4             dx CAF6,00,05,5E,66,05,06,8000,E20F

; Room $CE40, door list index 0: Door
$83:A300             dx 93FE,40,05,5E,36,05,03,8000,0000

; Room $CE40, door list index 1: Door
$83:A30C             dx C98E,00,04,11,26,01,02,8000,E229

; Room $CE8A, door list index 0: Door
$83:A318             dx CAF6,00,05,4E,36,04,03,8000,0000

; Room $CED2, door list index 0: Door
$83:A324             dx CEFB,00,05,0E,26,00,02,8000,0000

; Room $CEFB, door list index 0: Door
$83:A330             dx CFC9,00,07,16,7D,01,07,0200,0000

; Room $CEFB, door list index 1: Door
$83:A33C             dx CF54,00,05,0E,06,00,00,8000,0000

; Room $CEFB, door list index 2: Door
$83:A348             dx CF80,00,04,01,16,00,01,8000,E345

; Room $CEFB, door list index 3: Door
; Maridia load station 0
$83:A354             dx CED2,00,04,01,06,00,00,8000,0000

; Room $CF54, door list index 0: Door
$83:A360             dx CEFB,00,00,00,00,00,01,8000,E378

; Room $CF54, door list index 1: Door
$83:A36C             dx A408,40,05,1E,16,01,01,8000,0000

; Room $CF80, door list index 0: Door
$83:A378             dx CEFB,00,01,00,00,00,01,8000,E378

; Room $CF80, door list index 1: Door
; Brinstar load station Bh
$83:A384             dx A6A1,40,04,01,06,00,00,8000,0000

; Room $CF80, door list index 2: Door
$83:A390             dx D21C,00,04,01,16,00,01,8000,E356

; Room $CFC9, door list index 0: Door
$83:A39C             dx CEFB,00,06,06,02,00,00,0170,0000

; Room $CFC9, door list index 1: Door
$83:A3A8             dx D08A,00,04,01,06,00,00,8000,0000

; Room $CFC9, door list index 2: Door
$83:A3B4             dx D017,00,04,01,26,00,02,8000,0000

; Room $CFC9, door list index 3: Door
$83:A3C0             dx D0B9,00,04,01,06,00,00,8000,0000

; Room $CFC9, door list index 4: Door
$83:A3CC             dx D0B9,00,00,00,00,01,02,8000,0000

; Room $D017, door list index 0: Door
$83:A3D8             dx CFC9,00,05,2E,66,02,06,8000,0000

; Room $D017, door list index 1: Door
$83:A3E4             dx D055,00,04,01,36,00,03,8000,0000

; Room $D017, door list index 2: Door
$83:A3F0             dx D0B9,00,07,16,3D,01,03,01C0,0000

; Room $D017, door list index 3: Door
$83:A3FC             dx D0B9,00,07,46,3D,04,03,01C0,0000

; Room $D055, door list index 0: Door
$83:A408             dx D017,00,05,3E,26,03,02,8000,0000

; Room $D08A, door list index 0: Door
$83:A414             dx CFC9,00,05,1E,76,01,07,8000,0000

; Room $D08A, door list index 1: Door
$83:A420             dx D21C,00,00,00,00,00,00,8000,0000

; Room $D0B9, door list index 0: Door
$83:A42C             dx D104,00,07,26,1D,02,01,01C0,0000

; Room $D0B9, door list index 1: Door
$83:A438             dx CFC9,00,05,1E,06,01,00,8000,0000

; Room $D0B9, door list index 2: Door
$83:A444             dx D017,00,06,06,02,00,00,8000,0000

; Room $D0B9, door list index 3: Door
$83:A450             dx D017,00,06,36,02,03,00,8000,0000

; Room $D0B9, door list index 4: Door
$83:A45C             dx CFC9,00,01,00,00,02,02,8000,0000

; Room $D0B9, door list index 5: Door
$83:A468             dx D1A3,00,04,01,26,00,02,8000,0000

; Room $D104, door list index 0: Door
$83:A474             dx D0B9,00,06,26,02,02,00,8000,0000

; Room $D104, door list index 1: Door
$83:A480             dx A322,40,05,2E,36,02,03,8000,E367

; Room $D13B, door list index 0: Door
$83:A48C             dx D16D,00,04,01,06,00,00,0140,0000

; Room $D16D, door list index 0: Door
$83:A498             dx D13B,00,05,1E,06,01,00,8000,0000

; Room $D16D, door list index 1: Door
; Maridia load station 10h
$83:A4A4             dx D1DD,00,04,01,16,00,01,8000,0000

; Room $D1A3, door list index 0: Door
$83:A4B0             dx D0B9,00,05,5E,06,05,00,8000,0000

; Room $D1A3, door list index 1: Door
$83:A4BC             dx D1DD,00,07,06,2D,00,02,01C0,0000

; Room $D1A3, door list index 2: Door
$83:A4C8             dx D5A7,00,04,01,16,00,01,8000,0000

; Room $D1DD, door list index 0: Door
$83:A4D4             dx D16D,00,05,3E,16,03,01,8000,0000

; Room $D1DD, door list index 1: Door
$83:A4E0             dx D1A3,00,06,06,02,00,00,8000,0000

; Room $D1DD, door list index 2: Door
$83:A4EC             dx D340,00,00,00,00,00,02,8000,0000

; Room $D21C, door list index 0: Door
$83:A4F8             dx D08A,00,05,3E,06,03,00,8000,0000

; Room $D21C, door list index 1: Door
$83:A504             dx D252,00,04,01,06,00,00,8000,0000

; Room $D21C, door list index 2: Door
$83:A510             dx CF80,00,05,3E,06,03,00,8000,0000

; Room $D21C, door list index 3: Door
$83:A51C             dx D3B6,00,04,01,06,00,00,8000,0000

; Room $D252, door list index 0: Door
$83:A528             dx D21C,00,01,00,00,00,00,8000,0000

; Room $D252, door list index 1: Door
$83:A534             dx D461,00,04,01,06,00,00,8000,0000

; Room $D27E, door list index 0: Door
$83:A540             dx D387,00,05,0E,06,00,00,8000,0000

; Room $D27E, door list index 1: Door
$83:A54C             dx D2AA,00,04,01,06,00,00,8000,0000

; Room $D2AA, door list index 0: Door
$83:A558             dx D27E,00,05,0E,06,00,00,8000,0000

; Room $D2D9, door list index 0: Door
$83:A564             dx D433,00,05,0E,06,00,00,8000,0000

; Room $D2D9, door list index 1: Door
; Maridia load station 8
$83:A570             dx D30B,00,04,01,56,00,05,8000,0000

; Room $D30B, door list index 0: Door
$83:A57C             dx D2D9,00,05,6E,06,06,00,8000,0000

; Room $D30B, door list index 1: Door
; Maridia load station 1
$83:A588             dx D3DF,00,04,01,06,00,00,8000,0000

; Room $D30B, door list index 2: Door
$83:A594             dx 94CC,D0,03,00,00,00,00,0000,0000

; Room $D340, door list index 0: Door
$83:A5A0             dx D5EC,00,04,01,06,00,00,8000,0000

; Room $D340, door list index 1: Door
$83:A5AC             dx D408,00,02,00,00,00,00,8000,E291

; Room $D340, door list index 2: Door
$83:A5B8             dx D387,00,04,01,36,00,03,8000,0000

; Room $D340, door list index 3: Door
$83:A5C4             dx D433,00,04,01,06,00,00,8000,0000

; Room $D387, door list index 0: Door
$83:A5D0             dx D340,00,05,2E,16,02,01,8000,0000

; Room $D387, door list index 1: Door
$83:A5DC             dx D27E,00,04,01,06,00,00,8000,0000

; Room $D3B6, door list index 0: Door
$83:A5E8             dx D21C,00,05,0E,16,00,01,8000,E356

; Room $D3DF, door list index 0: Door
$83:A5F4             dx D30B,00,05,0E,46,00,04,8000,0000

; Room $D408, door list index 0: Door
$83:A600             dx D48E,00,06,06,02,00,00,8000,E309

; Room $D408, door list index 1: Door
$83:A60C             dx D340,00,07,06,2D,00,02,0200,E301

; Room $D433, door list index 0: Door
$83:A618             dx D2D9,00,04,01,06,00,00,8000,0000

; Room $D433, door list index 1: Door
$83:A624             dx D86E,00,02,00,00,00,00,8000,0000

; Room $D433, door list index 2: Door
$83:A630             dx D340,00,05,3E,36,03,03,8000,0000

; Room $D461, door list index 0: Door
$83:A63C             dx D252,00,05,0E,06,00,00,8000,0000

; Room $D461, door list index 1: Door
; Maridia load station 13h
$83:A648             dx D48E,00,04,01,16,00,01,8000,0000

; Unused. Room $D461, door list index 2: Door
$83:A654             dx D4EF,00,03,00,00,00,01,8000,0000

; Room $D48E, door list index 0: Door
$83:A660             dx D461,00,05,3E,06,03,00,8000,0000

; Room $D48E, door list index 1: Door
$83:A66C             dx D4C2,00,04,01,06,00,00,8000,0000

; Room $D48E, door list index 2: Door
$83:A678             dx D408,00,03,00,00,00,09,8000,E26C

; Room $D4C2, door list index 0: Door
$83:A684             dx D48E,00,05,0E,16,00,01,8000,0000

; Room $D4C2, door list index 1: Door
$83:A690             dx D646,00,04,01,36,00,03,8000,E3A3

; Unused. Room $D4C2, door list index 2: Door
$83:A69C             dx D51E,00,03,00,00,01,01,8000,0000

; Room $D4EF, door list index 0: Door
$83:A6A8             dx D54D,00,03,00,00,00,01,8000,0000

; Room $D4EF, door list index 1: Door
$83:A6B4             dx D461,00,02,00,00,02,00,8000,0000

; Room $D51E, door list index 0: Door
$83:A6C0             dx D57A,00,03,00,00,00,01,8000,0000

; Room $D51E, door list index 1: Door
$83:A6CC             dx D4C2,00,02,00,00,01,00,8000,0000

; Room $D54D, door list index 0: Door
$83:A6D8             dx D5A7,00,03,00,00,01,02,8000,0000

; Room $D54D, door list index 1: Door
$83:A6E4             dx D4EF,00,02,00,00,01,00,8000,0000

; Room $D57A, door list index 0: Door
$83:A6F0             dx D5A7,00,03,00,00,03,02,8000,0000

; Room $D57A, door list index 1: Door
$83:A6FC             dx D51E,00,02,00,00,00,00,8000,0000

; Room $D5A7, door list index 0: Door
$83:A708             dx D1A3,00,05,1E,36,01,03,8000,E398

; Room $D5A7, door list index 1: Door
$83:A714             dx D54D,00,02,00,00,00,00,8000,0000

; Room $D5A7, door list index 2: Door
$83:A720             dx D57A,00,02,00,00,00,00,8000,0000

; Room $D5A7, door list index 3: Door
; Maridia load station 12h
$83:A72C             dx D617,00,07,06,0D,00,00,01C0,0000

; Room $D5A7, door list index 4: Door
$83:A738             dx D6FD,00,04,01,06,00,00,8000,0000

; Room $D5A7, door list index 5: Door
; Maridia load station 2
$83:A744             dx D765,00,05,0E,06,00,00,8000,0000

; Room $D5EC, door list index 0: Door
$83:A750             dx D340,00,05,3E,56,03,05,8000,0000

; Room $D5EC, door list index 1: Door
$83:A75C             dx D9FE,00,04,01,16,00,01,8000,0000

; Room $D617, door list index 0: Door
$83:A768             dx D5A7,00,06,06,02,00,00,8000,0000

; Room $D617, door list index 1: Door
$83:A774             dx D95E,00,04,01,06,00,00,8000,0000

; Room $D646, door list index 0: Door
$83:A780             dx D4C2,00,05,2E,06,02,00,8000,0000

; Room $D646, door list index 1: Door
$83:A78C             dx D69A,00,04,01,26,00,02,8000,0000

; Room $D646, door list index 2: Door
$83:A798             dx D8C5,00,04,01,06,00,00,8000,0000

; Room $D646, door list index 3: Door
$83:A7A4             dx D646,00,05,0E,36,00,03,8000,E3B9

; Room $D69A, door list index 0: Door
$83:A7B0             dx D646,00,05,0E,36,00,03,8000,E3A3

; Room $D69A, door list index 1: Door
$83:A7BC             dx D8C5,00,04,01,06,00,00,8000,0000

; Room $D6D0, door list index 0: Door
$83:A7C8             dx D8C5,00,05,3E,06,03,00,8000,0000

; Room $D6FD, door list index 0: Door
$83:A7D4             dx D5A7,00,05,5E,16,05,01,8000,0000

; Room $D72A, door list index 0: Door
$83:A7E0             dx D913,00,01,00,00,00,00,8000,0000

; Room $D72A, door list index 1: Door
; Maridia load station 3
$83:A7EC             dx D81A,00,04,01,06,00,00,8000,0000

; Room $D72A, door list index 2: Door
$83:A7F8             dx D78F,00,04,01,06,00,00,8000,0000

; Unused
$83:A804             dx D913,00,01,00,00,00,02,8000,0000

; Unused. Clone of $A8F4
$83:A810             dx D845,00,04,01,06,00,00,8000,0000

; Maridia load station 11h
$83:A81C             dx D78F,00,04,01,06,00,00,8000,0000

; Room $D765, door list index 0: Door
$83:A828             dx D5A7,00,04,01,26,00,02,8000,0000

; Room $D78F, door list index 0: Door
$83:A834             dx D72A,00,05,6E,16,06,01,8000,0000

; Room $D78F, door list index 1: Door
$83:A840             dx DA60,00,05,1E,06,01,00,8000,0000

; Room $D7E4, door list index 0: Door
$83:A84C             dx D95E,00,05,1E,06,01,00,8000,E38D

; Room $D7E4, door list index 1: Door
$83:A858             dx D898,00,02,00,00,01,00,8000,0000

; Room $D7E4, door list index 2: Door
$83:A864             dx D898,00,02,00,00,00,00,8000,0000

; Room $D7E4, door list index 3: Door
$83:A870             dx D913,00,04,01,26,00,02,8000,0000

; Room $D81A, door list index 0: Door
$83:A87C             dx D9D4,00,04,01,06,00,00,8000,0000

; Room $D81A, door list index 1: Door
$83:A888             dx D72A,00,05,6E,06,06,00,8000,0000

; Room $D845, door list index 0: Door
$83:A894             dx D913,00,05,4E,26,04,02,8000,E318

; Room $D86E, door list index 0: Door
$83:A8A0             dx D5EC,00,02,00,00,00,00,8000,0000

; Room $D898, door list index 0: Door
$83:A8AC             dx D6FD,00,02,00,00,02,00,8000,0000

; Room $D898, door list index 1: Door
$83:A8B8             dx D6FD,00,02,00,00,03,00,8000,0000

; Room $D8C5, door list index 0: Door
$83:A8C4             dx D69A,00,05,0E,16,00,01,8000,E3C8

; Room $D8C5, door list index 1: Door
$83:A8D0             dx D6D0,00,04,01,06,00,00,8000,0000

; Room $D913, door list index 0: Door
$83:A8DC             dx D7E4,00,05,6E,06,06,00,8000,0000

; Room $D913, door list index 1: Door
$83:A8E8             dx D72A,00,04,01,06,00,00,8000,0000

; Room $D913, door list index 2: Door
$83:A8F4             dx D845,00,04,01,06,00,00,8000,0000

; Room $D913, door list index 3: Door
$83:A900             dx DA2B,00,05,4E,16,04,01,8000,0000

; Room $D95E, door list index 0: Door
$83:A90C             dx D617,00,05,3E,06,03,00,8000,0000

; Room $D95E, door list index 1: Door
$83:A918             dx D7E4,00,04,01,06,00,00,8000,0000

; Room $D9AA, door list index 0: Door
$83:A924             dx DA60,00,04,01,16,00,01,8000,0000

; Room $D9D4, door list index 0: Door
$83:A930             dx D81A,00,05,0E,06,00,00,8000,0000

; Room $D9FE, door list index 0: Door
$83:A93C             dx D5EC,00,05,0E,06,00,00,8000,0000

; Room $D9FE, door list index 1: Door
$83:A948             dx DA2B,00,04,01,06,00,00,8000,0000

; Room $DA2B, door list index 0: Door
$83:A954             dx D9FE,00,05,0E,06,00,00,8000,0000

; Room $DA2B, door list index 1: Door
$83:A960             dx D913,00,04,01,16,00,01,8000,0000

; Room $DA60, door list index 0: Door
$83:A96C             dx D78F,00,04,01,26,00,02,8000,E3D9

; Room $DA60, door list index 1: Door
$83:A978             dx D9AA,00,05,0E,06,00,00,8000,0000

; Room $DAAE, door list index 0: Door
$83:A984             dx DAE1,00,05,5E,06,05,00,8000,0000

; Room $DAAE, door list index 1: Door
$83:A990             dx A66A,D0,03,00,00,00,01,0000,E4C0

; Room $DAAE, door list index 3: Door
; Tourian load station 1
$83:A99C             dx DF1B,00,04,01,06,00,00,8000,0000

; Room $DAE1, door list index 0: Door
; Tourian load station 8
$83:A9A8             dx DAAE,00,04,01,36,00,03,8000,0000

; Room $DAE1, door list index 1: Door
$83:A9B4             dx DB31,00,05,0E,06,00,00,8000,0000

; Room $DB31, door list index 0: Door
$83:A9C0             dx DAE1,00,04,01,06,00,00,8000,0000

; Room $DB31, door list index 1: Door
$83:A9CC             dx DB7D,00,04,01,06,00,00,8000,0000

; Room $DB7D, door list index 0: Door
$83:A9D8             dx DB31,00,05,0E,16,00,01,8000,0000

; Room $DB7D, door list index 1: Door
$83:A9E4             dx DBCD,00,04,01,06,00,00,8000,0000

; Room $DBCD, door list index 0: Door
$83:A9F0             dx DB7D,00,05,5E,06,05,00,8000,0000

; Room $DBCD, door list index 1: Door
$83:A9FC             dx DC19,00,06,16,03,01,00,8000,0000

; Room $DC19, door list index 0: Door
$83:AA08             dx DBCD,00,07,06,1E,00,01,01C0,0000

; Room $DC19, door list index 1: Door
$83:AA14             dx DC65,00,05,1E,06,01,00,8000,0000

; Room $DC65, door list index 0: Door
$83:AA20             dx DC19,00,04,01,06,00,00,8000,0000

; Room $DC65, door list index 1: Door
$83:AA2C             dx DCB1,00,05,3E,06,03,00,8000,0000

; Room $DCB1, door list index 0: Door
; Tourian load station 11h
$83:AA38             dx DC65,00,04,01,06,00,00,8000,0000

; Room $DCB1, door list index 1: Door
$83:AA44             dx DCFF,00,01,00,00,00,00,8000,0000

; Room $DCFF, door list index 0: Door
$83:AA50             dx DCB1,00,00,00,00,00,00,8000,0000

; Room $DCFF, door list index 1: Door
$83:AA5C             dx DDC4,00,04,01,06,00,00,8000,0000

; Room $DCFF, door list index 2: Door
$83:AA68             dx DD2E,00,05,0E,06,00,00,8000,0000

; Room $DD2E, door list index 0: Door
$83:AA74             dx DCFF,00,04,01,16,00,01,8000,0000

; Room $DD58, door list index 0: Door
$83:AA80             dx DDF3,00,04,01,26,00,02,8000,0000

; Room $DD58, door list index 1: Door
$83:AA8C             dx DE4D,00,09,1F,06,01,00,8000,0000

; Room $DDC4, door list index 0: Door
$83:AA98             dx DCFF,00,05,0E,16,00,01,8000,0000

; Room $DDC4, door list index 1: Door
; Tourian load station 10h
$83:AAA4             dx DDF3,00,04,01,06,00,00,8000,0000

; Room $DDF3, door list index 0: Door
$83:AAB0             dx DDC4,00,05,3E,06,03,00,8000,0000

; Room $DDF3, door list index 1: Door
; Tourian load station 0
$83:AABC             dx DE23,00,05,0E,06,00,00,8000,0000

; Room $DDF3, door list index 2: Door
$83:AAC8             dx DD58,00,05,3E,06,03,00,8000,0000

; Room $DE23, door list index 0: Door
$83:AAD4             dx DDF3,00,04,01,16,00,01,8000,0000

; Room $DE4D, door list index 0: Door
$83:AAE0             dx DD58,00,04,01,06,00,00,8000,0000

; Room $DE4D, door list index 1: Door
$83:AAEC             dx DE7A,00,06,06,03,00,00,8000,0000

; Room $DE7A, door list index 0: Door
$83:AAF8             dx DE4D,00,07,06,0C,00,00,0200,0000

; Room $DE7A, door list index 1: Door
$83:AB04             dx DEA7,00,04,01,16,00,01,8000,0000

; Room $DEA7, door list index 0: Door
$83:AB10             dx DE7A,00,05,0E,16,00,01,8000,0000

; Room $DEA7, door list index 1: Door
$83:AB1C             dx DEDE,00,04,01,36,00,03,8000,0000

; Room $DEDE, door list index 0: Door
$83:AB28             dx DEA7,00,05,5E,06,05,00,8000,0000

; Room $DEDE, door list index 1: Door
$83:AB34             dx 96BA,40,04,01,86,00,08,8000,E4CF

; Room $DF1B, door list index 0: Door
$83:AB40             dx DAAE,00,05,0E,36,00,03,8000,0000

; Room $DF45, door list index 0: Door
$83:AB4C             dx DF8D,00,00,00,00,00,00,8000,E513

; Room $DF8D, door list index 0: Door
; Ceres load station
$83:AB58             dx DF45,00,01,00,00,00,02,8000,E4E0

; Room $DF8D, door list index 1: Door
$83:AB64             dx DFD7,00,00,00,00,00,00,8000,0000

; Room $DFD7, door list index 0: Door
$83:AB70             dx DF8D,00,01,00,00,01,00,8000,0000

; Room $DFD7, door list index 1: Door
$83:AB7C             dx E021,00,00,00,00,00,00,8000,0000

; Room $E021, door list index 0: Door
$83:AB88             dx DFD7,00,01,00,00,00,01,8000,0000

; Room $E021, door list index 1: Door
$83:AB94             dx E06B,00,00,00,00,00,00,8000,0000

; Room $E06B, door list index 0: Door
$83:ABA0             dx E021,00,01,00,00,01,00,8000,0000

; Room $E06B, door list index 1: Door
$83:ABAC             dx E0B5,00,00,00,00,00,00,8000,0000

; Room $E0B5, door list index 0: Door
$83:ABB8             dx E06B,00,01,00,00,01,00,8000,0000

; Unused. Room $E82C, door list index 0: Door
; Debug load station
$83:ABC4             dx E82C,05,00,00,01,00,00,01,0000

; Unused. Room $E82C, door list index 1: Door
$83:ABCF             dx E82C,05,00,00,01,01,00,01,0000

; Unused. Room $E82C, door list index 2: Door
$83:ABDA             dx E82C,04,00,00,00,00,00,01,0000

; Unused. Room $E82C, door list index 3: Door
$83:ABE5             dx E82C,04,00,00,00,01,00,01,0000
}


;;; $ABF0: FX type tilemap pointers ;;;
{
; This table is too short, it's missing the entries for 28h/2Ah/2Ch (Ceres Ridley/elevator / haze)
; This is fine, because those rooms disabled layer 3 anyway, but it does mean garbage is loaded to VRAM from pointers in the following table

; In bank $8A
$83:ABF0             dw 0000, ; 0: None
                        8000, ; 2: Lava
                        8840, ; 4: Acid
                        9080, ; 6: Water
                        98C0, ; 8: Spores
                        A100, ; Ah: Rain
                        A940, ; Ch: Fog
                        0000, 
                        0000, 
                        0000, 
                        0000, 
                        0000, 
                        0000, 
                        0000, 
                        0000, 
                        0000, 
                        0000, ; 20h: Scrolling sky
                        0000, ; 22h: Unused
                        0000, ; 24h: Fireflea
                        9080  ; 26h: Tourian entrance statue
}


;;; $AC18: FX type function pointers ;;;
{
; In bank $88
$83:AC18             dw B278, ; 0: None
                        B279, ; 2: Lava
                        B2A1, ; 4: Acid
                        C3FF, ; 6: Water
                        DA11, ; 8: Spores
                        D950, ; Ah: Rain
                        DB08, ; Ch: Fog
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        A7D8, ; 20h: Scrolling sky
                        A61B, ; 22h: Unused
                        B07C, ; 24h: Fireflea
                        DB8A, ; 26h: Tourian entrance statue
                        D8DE, ; 28h: Ceres Ridley
                        D928, ; 2Ah: Ceres elevator
                        DDC7  ; 2Ch: Haze
}


;;; $AC46: Area specific palette FX object list pointers ;;;
{
$83:AC46             dw AC66, AC86, ACA6, ACC6, ACE6, AD06, AD26, AD46
}


;;; $AC56: Area specific animated tiles object list pointers ;;;
{
$83:AC56             dw AC76, AC96, ACB6, ACD6, ACF6, AD16, AD36, AD56
}


;;; $AC66: Area specific palette FX and animated tiles object lists ;;;
{
; Crateria palette FX object list
$83:AC66             dw F765, FFE5, FFE9, FFD9, FFDD, FFE1, FFED, F781

; Crateria animated tiles object list
$83:AC76             dw 8257, 8251, 825D, 8263, 824B, 824B, 824B, 824B

; Brinstar palette FX object list
$83:AC86             dw F775, F77D, F781, F779, F745, F745, F745, F745

; Brinstar animated tiles object list
$83:AC96             dw 8257, 8251, 8281, 824B, 824B, 824B, 824B, 824B

; Norfair palette FX object list
$83:ACA6             dw F761, F785, F789, F78D, F791, F745, F745, F745

; Norfair animated tiles object list
$83:ACB6             dw 8257, 8251, 824B, 824B, 824B, 824B, 824B, 824B

; Wrecked Ship palette FX object list
$83:ACC6             dw F76D, F745, F745, F745, F745, F745, F745, F745

; Wrecked Ship animated tiles object list
$83:ACD6             dw 8257, 8251, 8275, 827B, 826F, 824B, 824B, 824B

; Maridia palette FX object list
$83:ACE6             dw F795, F799, F79D, F745, F745, F745, F745, F745

; Maridia animated tiles object list
$83:ACF6             dw 8257, 8251, 8287, 828D, 824B, 824B, 824B, 824B

; Tourian palette FX object list
$83:AD06             dw F761, F7A1, F7A5, FFC9, FFCD, FFD1, FFD5, F745

; Tourian animated tiles object list
$83:AD16             dw 8257, 8251, 824B, 824B, 824B, 824B, 824B, 824B

; Ceres palette FX object list
$83:AD26             dw F745, F745, F745, F745, F745, F745, F745, F745

; Ceres animated tiles object list
$83:AD36             dw 8257, 8251, 824B, 824B, 824B, 824B, 824B, 824B

; Debug palette FX object list
$83:AD46             dw F745, F745, F745, F745, F745, F745, F745, F745

; Debug animated tiles object list
$83:AD56             dw 8257, 8251, 824B, 824B, 824B, 824B, 824B, 824B
}


;;; $AD66: Free space ;;;
{
$83:AD66             fillto $848000, $FF
}
