;;; $8000..8287: Layer blending ;;;
{
; General comments
{
; Summary of `[$1986] != 0` branch
; |_[$1986]_____|_Main screen layers__|_Subscreen layers____|_Colour math_|_Colour math layers___________|_Y_|_Misc.________________________________
; | 2/Eh/20h    | BG1/BG2/    sprites |         BG3         | Additive    | BG1/BG2    /sprites/backdrop | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 4           | BG1    /    sprites |         BG3         | Additive    | BG1/BG2    /sprites/backdrop | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 6           | BG1/BG2/    sprites |         BG3/sprites | Additive    | BG1/BG2/BG3        /backdrop | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 8           | BG1/BG2/    sprites |         BG3/sprites | Additive    |     BG2            /backdrop | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | Ah          | BG1/BG2/    sprites |         BG3         | Additive    |     BG2    /sprites/backdrop | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | Ch          | BG1/BG2/    sprites |         BG3         | Subtractive |     BG2            /backdrop | 0 | Disable colour math subscreen layers,  disable window masking, enable all layers in window area
; | 10h/12h     | BG1/BG2/    sprites |         BG3         | Additive    | BG1/BG2    /sprites/backdrop | 0 | Enable  colour math subscreen layers,  enable BG3 / colour math window 1 inclusive mask, disable BG3 in window area subscreen
; | 14h/22h     | BG1/BG2/    sprites |         BG3         | Subtractive |     BG2    /sprites/backdrop | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 16h         | BG1    /    sprites |     BG2/BG3         | Subtractive | BG1        /sprites/backdrop | 4 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 18h/1Eh/30h |         BG3         | BG1/BG2    /sprites | Additive    |         BG3        /backdrop | 2 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 1Ah         | BG1    /BG3/sprites |     BG2             | Additive    | BG1    /BG3/sprites/backdrop | 4 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 1Ch         | BG1    /BG3/sprites |     BG2             | Halved      | BG1    /BG3/sprites          | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 24h         | BG1/BG2/    sprites |         BG3         | Additive    | BG1/BG2    /sprites/backdrop | 0 | Restrict colour math to inside window, disable BG1/BG2 window 1/2 masking, enable BG3/colour math window 1 inclusive mask, disable BG1/BG2/sprites in window area main screen, disable BG3 in window area subscreen
; | 26h         | BG1/BG2/    sprites |         BG3         | Halved      | BG1/BG2/BG3/sprites/backdrop | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 28h         | BG1/BG2/    sprites |         BG3         | Subtractive |     BG2    /sprites/backdrop | 0 | Disable colour math subscreen layers,  disable window masking, enable all layers in window area, if [$1987] & 80h = 0: colour math subscreen backdrop colour = (5, 0, 0) (red)
; | 2Ah         | BG1/BG2/    sprites |         BG3         | Subtractive |     BG2    /sprites/backdrop | 0 | Disable colour math subscreen layers,  disable window masking, enable all layers in window area, if [$1987] & 80h = 0: colour math subscreen backdrop colour = (6, 2, 0) (orange)
; | 2Ch         | BG1/BG2/    sprites |         BG3         | Additive    | BG1/BG2    /sprites/backdrop | 0 | Disable colour math subscreen layers,  disable window masking, enable all layers in window area
; | 2Eh         | BG1/BG2/    sprites |         BG3         | Subtractive | BG1/BG2    /sprites/backdrop | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 32h         | BG1/BG2/    sprites |         BG3         | Subtractive |     BG2    /sprites/backdrop | 0 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area
; | 34h         | BG1/BG2/    sprites |         BG3         | Additive    | BG1/BG2    /sprites/backdrop | 6 | Enable  colour math subscreen layers,  disable window masking, enable all layers in window area

; Attempted explanation of each value:
{
;     Normal: BG1/BG2/sprites are drawn with BG3 added on top
;     2/Eh/20h: Normal

;     4: Normal, but BG2 is disabled
;         Used by Phantoon intro

;     6: Normal, but sprites aren't affected by BG3 and sprites are added to BG1/BG2 (instead of hidden)
;         Unused

;     8: Normal, but BG1/sprites aren't affected by BG3 and sprites are added to BG2 (instead of hidden)
;         Used in some power off Wrecked Ship rooms

;     Ah: Normal, but BG1 isn't affected by BG3
;         Used with FX type = spores

;     Ch: Normal, but BG3 is disabled and colour math is subtractive
;         Used with FX type = fireflea

;     10h/12h: Normal, but BG3 is disabled inside window 1
;         Used by morph ball eye and varia/gravity suit pickup

;     14h/22h: Normal, but BG1 isn't affected by BG3 and colour math is subtractive
;         Sometimes use with FX type = water

;     16h: BG1/sprites are drawn after the result of drawing BG2/BG3 is subtracted and Y = 4
;         Sometimes use with FX type = water

;     18h/1Eh/30h: BG3 is drawn with the result of drawing BG1/BG2/sprites added on top and Y = 2
;         Used with FX type = lava / acid / fog / Tourian entrance statue, sometimes use with FX type = water
;         This is equivalent to normal, right? Apparently bypasses sprite colour math limitation(?)

;     1Ah: Normal, but BG2 and BG3 have reversed roles and Y = 4
;         Used by Phantoon when semi-transparent

;     1Ch: Normal, but BG2 and BG3 have reversed roles, colour addition is halved and backdrop is disabled
;         Unused

;     24h: BG1/BG2/sprites are drawn the backdrop is added on top inside window 1
;         Used by Mother Brain

;     26h: Normal, but colour addition is halved
;         Unused

;     28h: Normal, but BG3 is disabled, colour math is subtractive, and the backdrop subtracts red if there is no power bomb explosion
;         Used in some default state Crateria rooms, some power off Wrecked Ship rooms, pre plasma beam rooms

;     2Ah: Normal, but BG3 is disabled, colour math is subtractive, and the backdrop subtracts orange if there is no power bomb explosion
;         Used in blue Brinstar rooms, Kraid's lair entrance, n00b tube side rooms, plasma beam room, some sand falls rooms

;     2Ch: Normal, but BG3 is disabled
;         Used by FX type = haze and torizos

;     2Eh: Normal, but colour math is subtractive
;         Unused

;     32h: Normal, but BG1 isn't affected by BG3 and colour math is subtractive
;         Unused

;     34h: Normal, but Y = 6
;         Used by Mother Brain phase 2
}

; The Y values, power bomb configuration:
{
;     Normal: BG1/BG2/sprites are drawn with BG3 drawn on top, BG3 is disabled inside window 2
;     Y = 0/2: Normal
;     Y = 4: BG1/sprites are drawn with the result of drawing BG2/BG3 added on top, BG2/BG3 is disabled inside window 2
;     Y = 6: Normal, but BG2 isn't affected by BG3
}

; $1986: Layer blending configuration
{
;     Set to [FX A] at the start of the HDMA object handler. See "FX per room.asm"
;     Set to [FX B] by:
;         $B3B0 ; HDMA object $C3E1, FX layer 3 lava and acid
;         $C48E ; HDMA object $D847 / $D856, FX layer 3 water / Tourian entrance statue
;         $D9A1 ; HDMA object $D96C, FX layer 3 rain
;         $DA47 ; HDMA object $DA2D, FX layer 3 spores
;         $DB36 ; HDMA object $DB19, FX layer 3 fog

;     Set to 4/1Ah by $E449, Phantoon
;     Set to Ch by $B0BC, HDMA object $B0AC, FX layer 3 fireflea
;     Set to 10h by $E917, $E9E6, $EA3C, $EACB, HDMA object $E8EC, morph ball eye
;     Set to 12h by:
;         $E026, HDMA object $D5A2, varia suit pickup
;         $E05C, HDMA object $D67A, gravity suit pickup
;     Set to 24h by $E767, $E7BC, HDMA object $E751, Mother Brain
;     Set to 2Ch by:
;         $DE18/96, HDMA object $DEEB, FX layer 3 haze
;         $DD43, HDMA object $DD4A, torizos
}

; The following is a list of what FX B values are used with each FX type (only FX B is used with FX layer 3)
{
;     FX type = fireflea/both Ceres:     FX B = 2
;     FX type = spores:                  FX B = Ah
;     FX type = rain:                    FX B = Eh
;     FX type = water:                   FX B = 14h/16h/18h
;     FX type = lava/acid:               FX B = 1Eh
;     FX type = fog:                     FX B = 30h
;     FX type = Tourian entrance statue: FX B = 18h
}
}


;;; $8000: Layer blending handler ;;;
{
$88:8000 08          PHP
$88:8001 E2 30       SEP #$30
$88:8003 A0 00       LDY #$00               ; Layer blending power bomb configuration = 0
$88:8005 AE 86 19    LDX $1986  [$7E:1986]  ;\
$88:8008 F0 06       BEQ $06    [$8010]     ;} If [layer blending configuration] != 0:
$88:800A 20 75 80    JSR $8075  [$88:8075]  ; Initialise layer blending
$88:800D FC 3E 80    JSR ($803E,x)[$88:8074]; Execute [$803E + [layer blending configuration]] (may change Y)

$88:8010 2C 87 19    BIT $1987  [$7E:1987]  ;\
$88:8013 10 05       BPL $05    [$801A]     ;} If [layer blending window 2 configuration] & 80h:
$88:8015 20 FE 81    JSR $81FE  [$88:81FE]  ; Handle layer blending power bomb (uses Y)
$88:8018 80 22       BRA $22    [$803C]     ; Return

$88:801A 2C 87 19    BIT $1987  [$7E:1987]  ;\
$88:801D 50 05       BVC $05    [$8024]     ;} If [layer blending window 2 configuration] & 40h:
$88:801F 20 7B 81    JSR $817B  [$88:817B]  ; Handle layer blending x-ray - can show blocks
$88:8022 80 18       BRA $18    [$803C]     ; Return

$88:8024 AD 87 19    LDA $1987  [$7E:1987]  ;\
$88:8027 89 20       BIT #$20               ;} If [layer blending window 2 configuration] & 20h:
$88:8029 F0 05       BEQ $05    [$8030]     ;/
$88:802B 20 A4 81    JSR $81A4  [$88:81A4]  ; Handle layer blending x-ray - can't show blocks
$88:802E 80 0C       BRA $0C    [$803C]     ; Return

$88:8030 AD 87 19    LDA $1987  [$7E:1987]  ;\
$88:8033 89 10       BIT #$10               ;} If [layer blending window 2 configuration] & 10h:
$88:8035 F0 05       BEQ $05    [$803C]     ;/
$88:8037 20 DB 81    JSR $81DB  [$88:81DB]  ; Handle layer blending x-ray - fireflea room
$88:803A 80 00       BRA $00    [$803C]     ; >_<

$88:803C 28          PLP
$88:803D 60          RTS

$88:803E             dw 8074, 8074, 8090, 8099, 80A2, 80AB, 80B0, 80B7, 80B8, 80B8, 80C5, 80CA, 80F5, 80D9, 80E8, 80F5,
                        810C, 80C5, 8156, 810D, 8112, 812A, 8142, 8145, 80F5, 814A, 8153
}


;;; $8074: RTS. Layer blending configuration 0/2 ;;;
{
$88:8074 60          RTS
}


;;; $8075: Initialise layer blending ;;;
{
$88:8075 64 60       STZ $60    [$7E:0060]  ;\
$88:8077 64 61       STZ $61    [$7E:0061]  ;} Disable window masking
$88:8079 64 62       STZ $62    [$7E:0062]  ;/
$88:807B A9 13       LDA #$13               ;\
$88:807D 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$88:807F A9 04       LDA #$04               ;\
$88:8081 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3
$88:8083 64 6C       STZ $6C    [$7E:006C]  ;\
$88:8085 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area
$88:8087 A9 02       LDA #$02               ;\
$88:8089 85 6E       STA $6E    [$7E:006E]  ;} Enable colour math subscreen layers
$88:808B A9 33       LDA #$33               ;\
$88:808D 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG1/BG2/sprites/backdrop
$88:808F 60          RTS
}


;;; $8090: Layer blending configuration 4 ;;;
{
; Used by Phantoon
$88:8090 A9 11       LDA #$11               ;\
$88:8092 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$88:8094 A9 04       LDA #$04               ;\
$88:8096 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3
$88:8098 60          RTS
}


;;; $8099: Unused. Layer blending configuration 6 ;;;
{
$88:8099 A9 14       LDA #$14               ;\
$88:809B 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3/sprites
$88:809D A9 27       LDA #$27               ;\
$88:809F 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG1/BG2/BG3/backdrop
$88:80A1 60          RTS
}


;;; $80A2: Layer blending configuration 8 ;;;
{
; Used in:
;     Room CA52, state $CA64 ; Wrecked Ship attic, power off
;     Room CAF6, state $CB08 ; Wrecked Ship mainstreet, power off
;     Room CCCB, state $CCDD ; Wrecked Ship map station, power off
$88:80A2 A9 14       LDA #$14               ;\
$88:80A4 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3/sprites
$88:80A6 A9 22       LDA #$22               ;\
$88:80A8 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG2/backdrop
$88:80AA 60          RTS
}


;;; $80AB: Layer blending configuration Ah ;;;
{
; Used with spores
$88:80AB A9 32       LDA #$32               ;\
$88:80AD 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG2/sprites/backdrop
$88:80AF 60          RTS
}


;;; $80B0: Layer blending configuration Ch ;;;
{
; Used with FX type = fireflea
$88:80B0 64 6E       STZ $6E    [$7E:006E]  ; Disable colour math subscreen layers
$88:80B2 A9 A2       LDA #$A2               ;\
$88:80B4 85 71       STA $71    [$7E:0071]  ;} Enable subtractive colour math on BG2/backdrop
$88:80B6 60          RTS
}


;;; $80B7: RTS. Layer blending configuration Eh ;;;
{
; Used with FX type = rain
$88:80B7 60          RTS
}


;;; $80B8: Layer blending configuration 10h/12h ;;;
{
; 10h is used by morph ball eye
; 12h is used by varia/gravity suit pickup
$88:80B8 A9 02       LDA #$02               ;\
$88:80BA 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 1 inclusive mask
$88:80BC A9 20       LDA #$20               ;\
$88:80BE 85 62       STA $62    [$7E:0062]  ;} Enable colour math window 1 inclusive mask
$88:80C0 A9 04       LDA #$04               ;\
$88:80C2 85 6D       STA $6D    [$7E:006D]  ;} Disable BG3 in window area subscreen
$88:80C4 60          RTS
}


;;; $80C5: Layer blending configuration 14h/22h ;;;
{
; 14h is sometimes used with FX type = water
$88:80C5 A9 B3       LDA #$B3               ;\
$88:80C7 85 71       STA $71    [$7E:0071]  ;} Enable subtractive colour math on BG2/sprites/backdrop
$88:80C9 60          RTS
}


;;; $80CA: Layer blending configuration 16h ;;;
{
; Sometimes used with FX type = water
$88:80CA A0 04       LDY #$04               ; Y = 4
$88:80CC A9 11       LDA #$11               ;\
$88:80CE 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$88:80D0 A9 06       LDA #$06               ;\
$88:80D2 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG2/BG3
$88:80D4 A9 B1       LDA #$B1               ;\
$88:80D6 85 71       STA $71    [$7E:0071]  ;} Enable subtractive colour math on BG1/sprites/backdrop
$88:80D8 60          RTS
}


;;; $80D9: Layer blending configuration 1Ah ;;;
{
; Used by Phantoon
$88:80D9 A0 04       LDY #$04               ; Y = 4
$88:80DB A9 15       LDA #$15               ;\
$88:80DD 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG3/sprites
$88:80DF A9 02       LDA #$02               ;\
$88:80E1 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG2
$88:80E3 A9 35       LDA #$35               ;\
$88:80E5 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG1/BG3/sprites/backdrop
$88:80E7 60          RTS
}


;;; $80E8: Layer blending configuration 1Ch ;;;
{
$88:80E8 A9 15       LDA #$15               ;\
$88:80EA 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG3/sprites
$88:80EC A9 02       LDA #$02               ;\
$88:80EE 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG2
$88:80F0 A9 55       LDA #$55               ;\
$88:80F2 85 71       STA $71    [$7E:0071]  ;} Enable halved colour math on BG1/BG3/sprites
$88:80F4 60          RTS
}


;;; $80F5: Layer blending configuration 18h/1Eh/30h ;;;
{
; 18h is sometimes used with FX type = water
; 18h might be used with FX type = tourian entrance statue?
; 1Eh is used with FX type = lava/acid
; 30h is used with FX type = fog
$88:80F5 A0 02       LDY #$02               ; Y = 2
$88:80F7 A5 84       LDA $84    [$7E:0084]  ;\
$88:80F9 29 30       AND #$30               ;|
$88:80FB 49 30       EOR #$30               ;} If IRQ mode != v-count/h-count: return
$88:80FD D0 0C       BNE $0C    [$810B]     ;/
$88:80FF A9 24       LDA #$24               ;\
$88:8101 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG3/backdrop
$88:8103 A9 13       LDA #$13               ;\
$88:8105 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG1/BG2/sprites
$88:8107 A9 04       LDA #$04               ;\
$88:8109 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG3

$88:810B 60          RTS
}


;;; $810C: RTS. Layer blending configuration 20h ;;;
{
$88:810C 60          RTS
}


;;; $810D: Layer blending configuration 26h ;;;
{
$88:810D A9 77       LDA #$77               ;\
$88:810F 85 71       STA $71    [$7E:0071]  ;} Enable halved colour math on BG1/BG2/BG3/sprites/backdrop
$88:8111 60          RTS
}


;;; $8112: Layer blending configuration 28h ;;;
{
; Used in:
;     Room 92FD, state $9314 ; Crateria mainstreet, default state
;     Room 9A44, state $9A56 ; Crateria bomb block hall, default state
;     Room 9A90, state $9AA2 ; Crateria chozo missile, default state
;     Room C98E, state $C9A0 ; Wrecked Ship spike floor hall, power off
;     Room CC6F, state $CC81 ; Pre Phantoon hall, power off
;     Room D27E ; Plasma beam puyo room
;     Room D387 ; Pre plasma beam shaft
$88:8112 64 6E       STZ $6E    [$7E:006E]  ; Disable colour math subscreen layers
$88:8114 A9 B3       LDA #$B3               ;\
$88:8116 85 71       STA $71    [$7E:0071]  ;} Enable subtractive colour math on BG2/sprites/backdrop
$88:8118 2C 87 19    BIT $1987  [$7E:1987]  ;\
$88:811B 30 0C       BMI $0C    [$8129]     ;} If power bomb explosion active: return
$88:811D A9 25       LDA #$25               ;\
$88:811F 85 74       STA $74    [$7E:0074]  ;|
$88:8121 A9 40       LDA #$40               ;|
$88:8123 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (5, 0, 0) (red)
$88:8125 A9 80       LDA #$80               ;|
$88:8127 85 76       STA $76    [$7E:0076]  ;/

$88:8129 60          RTS
}


;;; $812A: Layer blending configuration 2Ah ;;;
{
; Used in:
;     Room 97B5, state $97C6 ; Crateria -> Blue Brinstar elevator, default state
;     Room 9E9F, state $9EB1 ; Morph ball room, default state
;     Room 9F11, state $9F23 ; Old Kraid entrance, default state
;     Room 9F64, state $9F76 ; Blue Brinstar ceiling e-tank hall, default state
;     Room A6A1 ; Kraid's lair entrance
;     Room CF54 ; n00b tube west
;     Room CF80 ; n00b tube east
;     Room D2AA ; Plasma beam room
;     Room D54D ; Pre Maridia reserve tank room sand fall room
;     Room D57A ; Pre PB #66 room sand fall room
;     Room D86E ; Sandy Maridia sand falls room
;     Room D898 ; Sand falls
$88:812A 64 6E       STZ $6E    [$7E:006E]  ; Disable colour math subscreen layers
$88:812C A9 B3       LDA #$B3               ;\
$88:812E 85 71       STA $71    [$7E:0071]  ;} Enable subtractive colour math on BG2/sprites/backdrop
$88:8130 2C 87 19    BIT $1987  [$7E:1987]  ;\
$88:8133 30 0C       BMI $0C    [$8141]     ;} If power bomb explosion active: return
$88:8135 A9 26       LDA #$26               ;\
$88:8137 85 74       STA $74    [$7E:0074]  ;|
$88:8139 A9 42       LDA #$42               ;|
$88:813B 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (6, 2, 0) (orange)
$88:813D A9 80       LDA #$80               ;|
$88:813F 85 76       STA $76    [$7E:0076]  ;/

$88:8141 60          RTS
}


;;; $8142: Layer blending configuration 2Ch ;;;
{
; Use by FX type = haze and torizos
$88:8142 64 6E       STZ $6E    [$7E:006E]  ; Disable colour math subscreen layers
$88:8144 60          RTS
}


;;; $8145: Layer blending configuration 2Eh ;;;
{
$88:8145 A9 B3       LDA #$B3               ;\
$88:8147 85 71       STA $71    [$7E:0071]  ;} Enable subtractive colour math on BG1/BG2/sprites/backdrop
$88:8149 60          RTS
}


;;; $814A: Layer blending configuration 32h ;;;
{
$88:814A A9 44       LDA #$44               ;\
$88:814C 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3 (and sets an unused bit)
$88:814E A9 B2       LDA #$B2               ;\
$88:8150 85 71       STA $71    [$7E:0071]  ;} Enable subtractive colour math on BG2/sprites/backdrop
$88:8152 60          RTS
}


;;; $8153: Layer blending configuration 34h ;;;
{
$88:8153 A0 06       LDY #$06               ; Y = 6
$88:8155 60          RTS
}


;;; $8156: Layer blending configuration 24h ;;;
{
; Used by Mother Brain
$88:8156 A9 00       LDA #$00               ;\
$88:8158 85 60       STA $60    [$7E:0060]  ;} Disable BG1/BG2 window 1/2 masking
$88:815A A9 02       LDA #$02               ;\
$88:815C 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 1 inclusive mask
$88:815E A9 20       LDA #$20               ;\
$88:8160 85 62       STA $62    [$7E:0062]  ;} Enable colour math window 1 inclusive mask
$88:8162 A9 13       LDA #$13               ;\
$88:8164 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$88:8166 A9 04       LDA #$04               ;\
$88:8168 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3
$88:816A A9 13       LDA #$13               ;\
$88:816C 85 6C       STA $6C    [$7E:006C]  ;} Disable BG1/BG2/sprites in window area main screen
$88:816E A9 04       LDA #$04               ;\
$88:8170 85 6D       STA $6D    [$7E:006D]  ;} Disable BG3 in window area subscreen
$88:8172 A9 10       LDA #$10               ;\
$88:8174 85 6E       STA $6E    [$7E:006E]  ;} Disable subscreen layers and restrict colour math to inside window
$88:8176 A9 33       LDA #$33               ;\
$88:8178 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG1/BG2/sprites/backdrop
$88:817A 60          RTS
}


;;; $817B: Handle layer blending x-ray - can show blocks ;;;
{
$88:817B A9 C8       LDA #$C8               ;\
$88:817D 85 60       STA $60    [$7E:0060]  ;} Enable BG1 window 2 inclusive mask and BG2 window 2 exclusive mask
$88:817F A9 08       LDA #$08               ;\
$88:8181 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 2 inclusive mask
$88:8183 A9 80       LDA #$80               ;\
$88:8185 85 62       STA $62    [$7E:0062]  ;} Enable colour math window 2 inclusive mask
$88:8187 A9 13       LDA #$13               ;\
$88:8189 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$88:818B A9 04       LDA #$04               ;\
$88:818D 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3
$88:818F A9 03       LDA #$03               ;\
$88:8191 85 6C       STA $6C    [$7E:006C]  ;} Disable BG1/BG2 in window area main screen
$88:8193 A9 04       LDA #$04               ;\
$88:8195 85 6D       STA $6D    [$7E:006D]  ;} Disable BG3 in window area subscreen
$88:8197 A9 22       LDA #$22               ;\
$88:8199 85 6E       STA $6E    [$7E:006E]  ;} Enable subscreen layers and restrict colour math to outside window
$88:819B A5 71       LDA $71    [$7E:0071]  ;\
$88:819D 29 80       AND #$80               ;|
$88:819F 09 73       ORA #$73               ;} Enable halved colour math on BG1/BG2/sprites/backdrop
$88:81A1 85 71       STA $71    [$7E:0071]  ;/
$88:81A3 60          RTS
}


;;; $81A4: Handle layer blending x-ray - can't show blocks ;;;
{
$88:81A4 64 60       STZ $60    [$7E:0060]  ; Disable BG1/2 window masks
$88:81A6 A9 08       LDA #$08               ;\
$88:81A8 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 2 inclusive mask
$88:81AA A9 80       LDA #$80               ;\
$88:81AC 85 62       STA $62    [$7E:0062]  ;} Enable colour math window 2 inclusive mask
$88:81AE A9 13       LDA #$13               ;\
$88:81B0 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$88:81B2 A9 04       LDA #$04               ;\
$88:81B4 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3
$88:81B6 A9 03       LDA #$03               ;\
$88:81B8 85 6C       STA $6C    [$7E:006C]  ;} Disable BG1/BG2 in window area main screen
$88:81BA A9 04       LDA #$04               ;\
$88:81BC 85 6D       STA $6D    [$7E:006D]  ;} Disable BG3 in window area subscreen
$88:81BE A9 22       LDA #$22               ;\
$88:81C0 85 6E       STA $6E    [$7E:006E]  ;} Enable subscreen layers and restrict colour math to outside window
$88:81C2 A5 71       LDA $71    [$7E:0071]  ;\
$88:81C4 29 80       AND #$80               ;|
$88:81C6 09 61       ORA #$61               ;} Enable halved colour math on BG1/backdrop
$88:81C8 85 71       STA $71    [$7E:0071]  ;/
$88:81CA C2 20       REP #$20               ;\
$88:81CC AD 9B 07    LDA $079B  [$7E:079B]  ;|
$88:81CF C9 FB CE    CMP #$CEFB             ;} If [room pointer] = $CEFB (n00b tube):
$88:81D2 E2 20       SEP #$20               ;|
$88:81D4 D0 04       BNE $04    [$81DA]     ;/
$88:81D6 A9 11       LDA #$11               ;\
$88:81D8 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites

$88:81DA 60          RTS
}


;;; $81DB: Handle layer blending x-ray - fireflea room ;;;
{
$88:81DB 64 60       STZ $60    [$7E:0060]  ; Disable BG1/2 window masks
$88:81DD A9 08       LDA #$08               ;\
$88:81DF 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 2 inclusive mask
$88:81E1 A9 80       LDA #$80               ;\
$88:81E3 85 62       STA $62    [$7E:0062]  ;} Enable colour math window 2 inclusive mask
$88:81E5 A9 13       LDA #$13               ;\
$88:81E7 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$88:81E9 A9 04       LDA #$04               ; >_<;
$88:81EB 64 6B       STZ $6B    [$7E:006B]  ; Disable all subscreen layers
$88:81ED A9 03       LDA #$03               ;\
$88:81EF 85 6C       STA $6C    [$7E:006C]  ;} Disable BG1/BG2 in window area main screen
$88:81F1 A9 04       LDA #$04               ;\
$88:81F3 85 6D       STA $6D    [$7E:006D]  ;} Disable BG3 in window area subscreen
$88:81F5 A9 20       LDA #$20               ;\
$88:81F7 85 6E       STA $6E    [$7E:006E]  ;} Disable subscreen layers and restrict colour math to outside window
$88:81F9 A9 B3       LDA #$B3               ;\
$88:81FB 85 71       STA $71    [$7E:0071]  ;} Enable subtractive colour math on BG1/BG2/sprites/backdrop
$88:81FD 60          RTS
}


;;; $81FE: Handle layer blending power bomb ;;;
{
$88:81FE C2 30       REP #$30               ;\
$88:8200 AD 9B 07    LDA $079B  [$7E:079B]  ;|
$88:8203 C9 6A A6    CMP #$A66A             ;} If room is Tourian entrance:
$88:8206 E2 30       SEP #$30               ;|
$88:8208 D0 02       BNE $02    [$820C]     ;/
$88:820A A0 06       LDY #$06               ; Y = 6

$88:820C BB          TYX                    ;\
$88:820D FC 11 82    JSR ($8211,x)[$88:8219];} Execute [$8211 + [Y]]
$88:8210 60          RTS

$88:8211             dw 8219, 8219, 823E, 8263
}


;;; $8219: Handle layer blending power bomb configuration 0/2 ;;;
{
$88:8219 A9 00       LDA #$00               ;\
$88:821B 85 60       STA $60    [$7E:0060]  ;} Disable BG1/BG2 window 1/2 masking
$88:821D A9 08       LDA #$08               ;\
$88:821F 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 2 inclusive mask
$88:8221 A9 80       LDA #$80               ;\
$88:8223 85 62       STA $62    [$7E:0062]  ;} Enable colour math window 2 inclusive mask
$88:8225 A9 02       LDA #$02               ;\
$88:8227 85 6E       STA $6E    [$7E:006E]  ;} Enable colour math subscreen layers
$88:8229 A9 37       LDA #$37               ;\
$88:822B 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG1/BG2/BG3/sprites/backdrop
$88:822D A9 00       LDA #$00               ;\
$88:822F 85 6C       STA $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$88:8231 A9 04       LDA #$04               ;\
$88:8233 85 6D       STA $6D    [$7E:006D]  ;} Disable BG3 in window area subscreen
$88:8235 A9 13       LDA #$13               ;\
$88:8237 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$88:8239 A9 04       LDA #$04               ;\
$88:823B 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3
$88:823D 60          RTS
}


;;; $823E: Handle layer blending power bomb configuration 4 ;;;
{
$88:823E A9 80       LDA #$80               ;\
$88:8240 85 60       STA $60    [$7E:0060]  ;} Enable BG2 window 2 inclusive mask
$88:8242 A9 08       LDA #$08               ;\
$88:8244 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 2 inclusive mask
$88:8246 A9 80       LDA #$80               ;\
$88:8248 85 62       STA $62    [$7E:0062]  ;} Enable colour math window 2 inclusive mask
$88:824A A9 02       LDA #$02               ;\
$88:824C 85 6E       STA $6E    [$7E:006E]  ;} Enable colour math subscreen layers
$88:824E A9 37       LDA #$37               ;\
$88:8250 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG1/BG2/BG3/sprites/backdrop
$88:8252 A9 00       LDA #$00               ;\
$88:8254 85 6C       STA $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$88:8256 A9 06       LDA #$06               ;\
$88:8258 85 6D       STA $6D    [$7E:006D]  ;} Disable BG2/BG3 in window area subscreen
$88:825A A9 11       LDA #$11               ;\
$88:825C 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$88:825E A9 06       LDA #$06               ;\
$88:8260 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG2/BG3
$88:8262 60          RTS
}


;;; $8263: Handle layer blending power bomb configuration 6 ;;;
{
; Compared with config 0/2, this one disables colour math on BG2/BG3
$88:8263 A9 00       LDA #$00               ;\
$88:8265 85 60       STA $60    [$7E:0060]  ;} Disable BG1/BG2 window 1/2 masking
$88:8267 A9 08       LDA #$08               ;\
$88:8269 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 2 inclusive mask
$88:826B A9 80       LDA #$80               ;\
$88:826D 85 62       STA $62    [$7E:0062]  ;} Enable colour math window 2 inclusive mask
$88:826F A9 02       LDA #$02               ;\
$88:8271 85 6E       STA $6E    [$7E:006E]  ;} Enable colour math subscreen layers
$88:8273 A9 31       LDA #$31               ;\
$88:8275 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG1/sprites/backdrop
$88:8277 A9 00       LDA #$00               ;\
$88:8279 85 6C       STA $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$88:827B A9 04       LDA #$04               ;\
$88:827D 85 6D       STA $6D    [$7E:006D]  ;} Disable BG3 in window area subscreen
$88:827F A9 13       LDA #$13               ;\
$88:8281 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$88:8283 A9 04       LDA #$04               ;\
$88:8285 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3
$88:8287 60          RTS
}
}


;;; $8288: Enable HDMA objects ;;;
{
$88:8288 08          PHP
$88:8289 C2 20       REP #$20
$88:828B A9 00 80    LDA #$8000
$88:828E 0C B0 18    TSB $18B0  [$7E:18B0]
$88:8291 28          PLP
$88:8292 6B          RTL
}


;;; $8293: Disable HDMA objects ;;;
{
; Power bombs still work
$88:8293 08          PHP
$88:8294 C2 20       REP #$20
$88:8296 A9 00 80    LDA #$8000
$88:8299 1C B0 18    TRB $18B0  [$7E:18B0]
$88:829C 28          PLP
$88:829D 6B          RTL
}


;;; $829E: Wait until the end of a v-blank and clear (H)DMA enable flags ;;;
{
$88:829E 08          PHP
$88:829F E2 20       SEP #$20
$88:82A1 22 C5 82 80 JSL $8082C5[$80:82C5]  ; Wait until the end of a v-blank
$88:82A5 9C 0B 42    STZ $420B              ;\
$88:82A8 9C 0C 42    STZ $420C              ;} Clear (H)DMA enable flags
$88:82AB 28          PLP
}


;;; $82AC: Delete HDMA objects ;;;
{
$88:82AC 08          PHP
$88:82AD E2 20       SEP #$20               ;\
$88:82AF 64 85       STZ $85    [$7E:0085]  ;} Clear HDMA channels to enable
$88:82B1 C2 30       REP #$30               ;/
$88:82B3 DA          PHX                    ;\
$88:82B4 A2 0A 00    LDX #$000A             ;|
                                            ;|
$88:82B7 9E B4 18    STZ $18B4,x[$7E:18BE]  ;|
$88:82BA CA          DEX                    ;} Delete HDMA objects
$88:82BB CA          DEX                    ;|
$88:82BC 10 F9       BPL $F9    [$82B7]     ;|
$88:82BE FA          PLX                    ;/
$88:82BF 28          PLP
$88:82C0 6B          RTL
}


;;; $82C1: Initialise special effects for new room ;;;
{
; This initial bit regarding earthquake sound effects is strictly for rising acid/lava rooms
$88:82C1 08          PHP
$88:82C2 C2 20       REP #$20
$88:82C4 9C 07 06    STZ $0607  [$7E:0607]  ; Earthquake sound effect index = 0
$88:82C7 9C 09 06    STZ $0609  [$7E:0609]  ; Earthquake sound effect timer = 0 (enable)
$88:82CA AD 9B 07    LDA $079B  [$7E:079B]  ;\
$88:82CD C9 04 98    CMP #$9804             ;} If [room pointer] = $9804 (Bomb Torizo): go to BRANCH_NO_EARTHQUAKE_SFX
$88:82D0 F0 1B       BEQ $1B    [$82ED]     ;/
$88:82D2 C9 BA 96    CMP #$96BA             ;\
$88:82D5 F0 16       BEQ $16    [$82ED]     ;} If [room pointer] = $96BA (old Tourian escape shaft): go to BRANCH_NO_EARTHQUAKE_SFX
$88:82D7 C9 2E B3    CMP #$B32E             ;\
$88:82DA F0 11       BEQ $11    [$82ED]     ;} If [room pointer] = $B32E (Ridley): go to BRANCH_NO_EARTHQUAKE_SFX
$88:82DC C9 57 B4    CMP #$B457             ;\
$88:82DF F0 0C       BEQ $0C    [$82ED]     ;} If [room pointer] = $B457 (Lower Norfair breakable pillars hall): go to BRANCH_NO_EARTHQUAKE_SFX
$88:82E1 C9 58 DD    CMP #$DD58             ;\
$88:82E4 F0 07       BEQ $07    [$82ED]     ;} If [room pointer] = $DD58 (Mother Brain): go to BRANCH_NO_EARTHQUAKE_SFX
$88:82E6 C9 DE DE    CMP #$DEDE             ;\
$88:82E9 F0 02       BEQ $02    [$82ED]     ;} If [room pointer] = $DEDE (escape room 4): go to BRANCH_NO_EARTHQUAKE_SFX
$88:82EB 80 06       BRA $06    [$82F3]     ; Go to BRANCH_EARTHQUAKE_SFX

; BRANCH_NO_EARTHQUAKE_SFX
$88:82ED A9 FF FF    LDA #$FFFF             ;\
$88:82F0 8D 09 06    STA $0609  [$7E:0609]  ;} Earthquake sound effect timer = FFFFh (disable)

; BRANCH_EARTHQUAKE_SFX
$88:82F3 9C F7 05    STZ $05F7  [$7E:05F7]  ; Enable mini-map
$88:82F6 E2 30       SEP #$30
$88:82F8 A2 20       LDX #$20               ;\
                                            ;|
$88:82FA 9E 00 43    STZ $4300,x            ;|
$88:82FD A9 13       LDA #$13               ;|
$88:82FF 9D 01 43    STA $4301,x            ;|
$88:8302 9E 02 43    STZ $4302,x            ;|
$88:8305 9E 03 43    STZ $4303,x            ;|
$88:8308 9E 04 43    STZ $4304,x            ;|
$88:830B 9E 05 43    STZ $4305,x            ;|
$88:830E 9E 06 43    STZ $4306,x            ;} Clear (H)DMA registers. Sets PPU addresses to $2113 (BG4 X scroll) for no particular reason
$88:8311 9E 08 43    STZ $4308,x            ;|
$88:8314 9E 09 43    STZ $4309,x            ;|
$88:8317 8A          TXA                    ;|
$88:8318 18          CLC                    ;|
$88:8319 69 10       ADC #$10               ;|
$88:831B AA          TAX                    ;|
$88:831C E0 80       CPX #$80               ;|
$88:831E D0 DA       BNE $DA    [$82FA]     ;/
$88:8320 C2 30       REP #$30
$88:8322 A9 FF FF    LDA #$FFFF
$88:8325 9C 5C 19    STZ $195C  [$7E:195C]  ; FX Y subposition = 0
$88:8328 8D 5E 19    STA $195E  [$7E:195E]  ; FX Y position = FFFFh (disabled)
$88:832B 9C 60 19    STZ $1960  [$7E:1960]  ; Lava/acid Y subposition = 0
$88:832E 8D 62 19    STA $1962  [$7E:1962]  ; Lava/acid Y position = FFFFh (disabled)
$88:8331 A9 00 00    LDA #$0000             ;\
$88:8334 8F D8 CA 7E STA $7ECAD8[$7E:CAD8]  ;} HUD BG3 X position = 0
$88:8338 8F DA CA 7E STA $7ECADA[$7E:CADA]  ; HUD BG3 Y position = 0
$88:833C 8F DC CA 7E STA $7ECADC[$7E:CADC]  ; BG3 X position = 0
$88:8340 8F DE CA 7E STA $7ECADE[$7E:CADE]  ; BG3 Y position = 0
$88:8344 9C 83 07    STZ $0783  [$7E:0783]  ; Mode 7 flag = 0
$88:8347 9C 41 09    STZ $0941  [$7E:0941]  ; Camera distance index = normal
$88:834A 9C 6F 1E    STZ $1E6F  [$7E:1E6F]  ; Tourian entrance statue animation state = 0
$88:834D 9C 6D 1E    STZ $1E6D  [$7E:1E6D]  ; Tourian entrance statue finished processing flag = 0
$88:8350 9C 40 18    STZ $1840  [$7E:1840]  ; Earthquake timer = 0
$88:8353 9C 88 19    STZ $1988  [$7E:1988]  ; Phantoon semi-transparency flag = 0
$88:8356 9C 92 05    STZ $0592  [$7E:0592]  ; Power bomb explosion status = 0
$88:8359 9C EE 0C    STZ $0CEE  [$7E:0CEE]  ; Power bomb flag = 0
$88:835C 9C EA 0C    STZ $0CEA  [$7E:0CEA]  ; Power bomb radius = 0
$88:835F 9C 64 19    STZ $1964  [$7E:1964]  ; FX tilemap address = 0
$88:8362 9C 6E 19    STZ $196E  [$7E:196E]  ; FX type = none
$88:8365 A9 00 80    LDA #$8000             ;\
$88:8368 8D 76 19    STA $1976  [$7E:1976]  ;} FX base Y position = 0.8000h
$88:836B 9C 78 19    STZ $1978  [$7E:1978]  ;/
$88:836E 9C 7A 19    STZ $197A  [$7E:197A]  ; FX target Y position = 0
$88:8371 9C 7C 19    STZ $197C  [$7E:197C]  ; FX Y velocity = 0
$88:8374 9C 7E 19    STZ $197E  [$7E:197E]  ; FX liquid options = 0
$88:8377 9C 80 19    STZ $1980  [$7E:1980]  ; FX timer = 0
$88:837A 9C 74 19    STZ $1974  [$7E:1974]  ; Tide phase = 0
$88:837D 9C 70 19    STZ $1970  [$7E:1970]  ;\
$88:8380 9C 72 19    STZ $1972  [$7E:1972]  ;} FX Y offset = 0.0
$88:8383 A9 02 00    LDA #$0002             ;\
$88:8386 8D 82 19    STA $1982  [$7E:1982]  ;} Default layer blending configuration = 2 (normal)
$88:8389 64 B9       STZ $B9    [$7E:00B9]  ; BG3 X scroll = 0
$88:838B 64 BB       STZ $BB    [$7E:00BB]  ; BG3 Y scroll = 0
$88:838D 9C 17 09    STZ $0917  [$7E:0917]  ; Layer 2 X position = 0
$88:8390 9C 19 09    STZ $0919  [$7E:0919]  ; Layer 2 Y position = 0
$88:8393 64 A9       STZ $A9    [$7E:00A9]  ; Room loading interrupt command = 0
$88:8395 A9 00 88    LDA #$8800             ;\
$88:8398 8D 02 06    STA $0602  [$7E:0602]  ;|
$88:839B 8D 05 06    STA $0605  [$7E:0605]  ;|
$88:839E A9 E1 83    LDA #$83E1             ;} Pause hook = unpause hook = $88:83E1 (RTL)
$88:83A1 8D 01 06    STA $0601  [$7E:0601]  ;|
$88:83A4 8D 04 06    STA $0604  [$7E:0604]  ;/
$88:83A7 E2 20       SEP #$20               ;\
$88:83A9 A9 F0       LDA #$F0               ;|
$88:83AB 8D 81 21    STA $2181              ;|
$88:83AE A9 FF       LDA #$FF               ;} WRAM address = $7F:FFF0 (for no particular reason)
$88:83B0 8D 82 21    STA $2182              ;|
$88:83B3 A9 01       LDA #$01               ;|
$88:83B5 8D 83 21    STA $2183              ;/
$88:83B8 64 85       STZ $85    [$7E:0085]  ; HDMA channels to enable = 0
$88:83BA A9 20       LDA #$20               ;\
$88:83BC 85 74       STA $74    [$7E:0074]  ;|
$88:83BE A9 40       LDA #$40               ;|
$88:83C0 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$88:83C2 A9 80       LDA #$80               ;|
$88:83C4 85 76       STA $76    [$7E:0076]  ;/
$88:83C6 64 57       STZ $57    [$7E:0057]  ; Disable mosaic
$88:83C8 A9 13       LDA #$13               ;\
$88:83CA 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$88:83CC 64 6F       STZ $6F    [$7E:006F]  ; Colour math control register A = 0
$88:83CE 64 72       STZ $72    [$7E:0072]  ; Colour math control register B = 0
$88:83D0 64 5D       STZ $5D    [$7E:005D]  ; BG1/BG2 tiles base address = $0000
$88:83D2 A9 04       LDA #$04               ;\
$88:83D4 85 5E       STA $5E    [$7E:005E]  ;} BG3 tiles base address = $4000
$88:83D6 A9 49       LDA #$49               ;\
$88:83D8 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4800, size = 64x32
$88:83DA A9 5A       LDA #$5A               ;\
$88:83DC 85 5A       STA $5A    [$7E:005A]  ;} BG3 tilemap base address = $5800, size = 32x64
$88:83DE 85 5B       STA $5B    [$7E:005B]  ;/
$88:83E0 28          PLP

$88:83E1 6B          RTL
}


;;; $83E2: Unused. Spawn HDMA object to slot 0 - HDMA object channel = 4, HDMA object channel index = 20h ;;;
{
$88:83E2 08          PHP
$88:83E3 8B          PHB
$88:83E4 C2 20       REP #$20
$88:83E6 A9 00 04    LDA #$0400
$88:83E9 85 12       STA $12    [$7E:0012]
$88:83EB A9 20 00    LDA #$0020
$88:83EE 85 14       STA $14    [$7E:0014]
$88:83F0 A2 00 00    LDX #$0000
$88:83F3 4C 1B 84    JMP $841B  [$88:841B]
}


;;; $83F6: Unused. Spawn HDMA object to slot 8 - HDMA object channel = 40h, HDMA object channel index = 60h ;;;
{
$88:83F6 08          PHP
$88:83F7 8B          PHB
$88:83F8 C2 20       REP #$20
$88:83FA A9 00 40    LDA #$4000
$88:83FD 85 12       STA $12    [$7E:0012]
$88:83FF A9 60 00    LDA #$0060
$88:8402 85 14       STA $14    [$7E:0014]
$88:8404 A2 08 00    LDX #$0008
$88:8407 4C 1B 84    JMP $841B  [$88:841B]
}


;;; $840A: Spawn HDMA object to slot Ah - HDMA object channel = 80h, HDMA object channel index = 70h ;;;
{
; Called by:
;     $D865: Spawn BG3 scroll HDMA object
$88:840A 08          PHP
$88:840B 8B          PHB
$88:840C C2 20       REP #$20
$88:840E A9 00 80    LDA #$8000
$88:8411 85 12       STA $12    [$7E:0012]
$88:8413 A9 70 00    LDA #$0070
$88:8416 85 14       STA $14    [$7E:0014]
$88:8418 A2 0A 00    LDX #$000A
}


;;; $841B: Spawn HDMA object to slot [X] (hardcoded parameters) ;;;
{
;; Parameters:
;;     [[S] + 1] + 3: HDMA control
;;     [[S] + 1] + 4: HDMA target
;;     [[S] + 1] + 5: HDMA object instruction list pointer

; Must have DB and P pushed
$88:841B E2 20       SEP #$20
$88:841D A3 05       LDA $05,s  [$7E:1FF5]  ;\
$88:841F 48          PHA                    ;} DB = caller bank
$88:8420 AB          PLB                    ;/
$88:8421 EB          XBA                    ;\
$88:8422 A9 00       LDA #$00               ;|
$88:8424 C2 30       REP #$30               ;} $19 = [DB]
$88:8426 85 18       STA $18    [$7E:0018]  ;/
$88:8428 A3 03       LDA $03,s  [$7E:1FF3]  ;\
$88:842A A8          TAY                    ;} Y = (return address) + 1
$88:842B C8          INY                    ;/
$88:842C 18          CLC                    ;\
$88:842D 69 04 00    ADC #$0004             ;} Adjust return address
$88:8430 83 03       STA $03,s  [$7E:1FF3]  ;/
$88:8432 4C 77 84    JMP $8477  [$88:8477]  ; Spawn HDMA object to slot [X]
}


;;; $8435: Spawn HDMA object ;;;
{
;; Parameters:
;;     [[S] + 1] + 1: HDMA control
;;         v = ri000ttt
;;         r: Read data
;;         i: Indirect HDMA table
;;         t: Transfer type
;;             0: 8-bit
;;             1: 16-bit / two 8-bit units
;;             2: 16-bit for write-twice registers / two 8-bit units to same register
;;             3: Two 16-bit units for two write-twice registers
;;             4: Two 16-bit units / four 8-bit units
;;     [[S] + 1] + 2: HDMA target. Common targets:
;;         $0D: BG1 X scroll (16-bit, write-twice)
;;         $0E: BG1 Y scroll (16-bit, write-twice)
;;         $0F: BG2 X scroll (16-bit, write-twice)
;;         $10: BG2 Y scroll (16-bit, write-twice)
;;         $11: BG3 X scroll (16-bit, write-twice)
;;         $12: BG3 Y scroll (16-bit, write-twice)
;;         $26: Window 1 left position (8-bit)
;;         $27: Window 1 right position (8-bit)
;;         $28: Window 2 left position (8-bit)
;;         $29: Window 2 right position (8-bit)
;;         $32: Colour math subscreen backdrop colour (8-bit, sometimes used with write-twice)
;;     [[S] + 1] + 3: HDMA object instruction list pointer

;; Returns:
;;     Carry: Clear if HDMA object was spawned. Set if HDMA array full
;;     A: HDMA object index (80h if HDMA array full)

$88:8435 08          PHP
$88:8436 8B          PHB
$88:8437 E2 20       SEP #$20
$88:8439 A3 05       LDA $05,s  [$7E:1FEB]  ;\
$88:843B 48          PHA                    ;} DB = caller bank
$88:843C AB          PLB                    ;/
$88:843D EB          XBA                    ;\
$88:843E A9 00       LDA #$00               ;|
$88:8440 C2 30       REP #$30               ;} $19 = [DB]
$88:8442 85 18       STA $18    [$7E:0018]  ;/
$88:8444 A3 03       LDA $03,s  [$7E:1FE9]  ;\
$88:8446 A8          TAY                    ;} Y = (return address) + 1
$88:8447 C8          INY                    ;/
$88:8448 18          CLC                    ;\
$88:8449 69 04 00    ADC #$0004             ;} Adjust return address
$88:844C 83 03       STA $03,s  [$7E:1FE9]  ;/
$88:844E A9 00 04    LDA #$0400             ;\
$88:8451 85 12       STA $12    [$7E:0012]  ;} $13 = 4 (HDMA channel)
$88:8453 A9 20 00    LDA #$0020             ;\
$88:8456 85 14       STA $14    [$7E:0014]  ;} $14 = 20h (HDMA index)
$88:8458 A2 00 00    LDX #$0000             ; X = 0 (HDMA object index)

; LOOP
$88:845B BD B4 18    LDA $18B4,x[$7E:18B4]  ;\
$88:845E F0 17       BEQ $17    [$8477]     ;} If [HDMA object channel] = 0: go to spawn HDMA object to slot [X]
$88:8460 06 12       ASL $12    [$7E:0012]  ; $13 <<= 1
$88:8462 B0 0F       BCS $0F    [$8473]     ; If $13 MSb was clear:
$88:8464 A5 14       LDA $14    [$7E:0014]  ;\
$88:8466 18          CLC                    ;|
$88:8467 69 10 00    ADC #$0010             ;} $14 += 10h
$88:846A 85 14       STA $14    [$7E:0014]  ;/
$88:846C E8          INX                    ;\
$88:846D E8          INX                    ;} X += 2 (next HDMA object)
$88:846E E0 0C 00    CPX #$000C             ;\
$88:8471 D0 E8       BNE $E8    [$845B]     ;} If [X] != Ch: go to LOOP

$88:8473 AB          PLB
$88:8474 28          PLP
$88:8475 38          SEC                    ;\
$88:8476 6B          RTL                    ;} Return carry set
}


;;; $8477: Spawn HDMA object to slot [X] (variable parameters) ;;;
{
;; Parameters:
;;     X: HDMA object index
;;     Y: Return address + 1
;;     [Y] + 0: HDMA control
;;     [Y] + 1: HDMA target
;;     [Y] + 2: HDMA object instruction list pointer
;;     $13: HDMA object channel
;;     $14: HDMA object channel index
;;     $19: HDMA object bank
;; Returns:
;;     Carry: Clear
;;     A: HDMA object index

; Must have DB and P pushed
$88:8477 A9 B8 84    LDA #$84B8             ;\
$88:847A 9D F0 18    STA $18F0,x[$7E:18F0]  ;|
$88:847D A9 88 00    LDA #$0088             ;} HDMA object pre-instruction = RTL
$88:8480 9D FC 18    STA $18FC,x[$7E:18FC]  ;/
$88:8483 B9 02 00    LDA $0002,y[$88:EB65]  ;\
$88:8486 9D CC 18    STA $18CC,x[$7E:18CC]  ;} HDMA object instruction list pointer = [(return address) + 3]
$88:8489 A9 01 00    LDA #$0001             ;\
$88:848C 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1
$88:848F 9E 08 19    STZ $1908,x[$7E:1908]  ; HDMA object timer = 0
$88:8492 9E 14 19    STZ $1914,x[$7E:1914]  ; HDMA object $1914 = 0
$88:8495 9E 20 19    STZ $1920,x[$7E:1920]  ; HDMA object $1920 = 0
$88:8498 9E 2C 19    STZ $192C,x[$7E:192C]  ; HDMA object $192C = 0
$88:849B 9E 38 19    STZ $1938,x[$7E:1938]  ; HDMA object $1938 = 0
$88:849E A5 12       LDA $12    [$7E:0012]  ;\
$88:84A0 EB          XBA                    ;} HDMA object channel = [$13]
$88:84A1 9D B4 18    STA $18B4,x[$7E:18B4]  ;/
$88:84A4 A5 14       LDA $14    [$7E:0014]  ;\
$88:84A6 05 18       ORA $18    [$7E:0018]  ;} HDMA object channel index = [$14], HDMA object bank = [$19]
$88:84A8 9D C0 18    STA $18C0,x[$7E:18C0]  ;/
$88:84AB DA          PHX
$88:84AC A6 14       LDX $14    [$7E:0014]  ;\
$88:84AE B9 00 00    LDA $0000,y[$88:EB63]  ;} HDMA control / target = [(return address) + 1] / [(return address) + 2]
$88:84B1 9D 00 43    STA $4300,x            ;/
$88:84B4 68          PLA                    ; A = (HDMA object index)
$88:84B5 AB          PLB
$88:84B6 28          PLP
$88:84B7 18          CLC                    ;\
$88:84B8 6B          RTL                    ;} Return carry clear
}


;;; $84B9: HDMA object handler (also handle music queue) ;;;
{
; Also spawns power bombs that were set as pending due to Samus dying(?) or auto reserve tanks activating
; Also calls the layer blending handler
; Seriously, why is the music queue handler called here... >_<;
$88:84B9 08          PHP
$88:84BA 8B          PHB
$88:84BB C2 30       REP #$30
$88:84BD 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$88:84C1 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:84C4 D0 1B       BNE $1B    [$84E1]     ;} If time is not frozen:
$88:84C6 2C 92 05    BIT $0592  [$7E:0592]  ;\
$88:84C9 50 16       BVC $16    [$84E1]     ;} If [power bomb explosion status] = pending:
$88:84CB A9 00 80    LDA #$8000             ;\
$88:84CE 8D 92 05    STA $0592  [$7E:0592]  ;} Set power bomb exploding flag
$88:84D1 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:84D5             dx 40, 28, 8ACE        ;} Spawn indirect HDMA object for window 2 left position with instruction list $8ACE
$88:84D9 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:84DD             dx 40, 29, 8B80        ;} Spawn indirect HDMA object for window 2 right position with instruction list $8B80

$88:84E1 4B          PHK                    ;\
$88:84E2 AB          PLB                    ;} DB = $88
$88:84E3 C2 30       REP #$30
$88:84E5 AD 82 19    LDA $1982  [$7E:1982]  ;\
$88:84E8 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = [default layer blending configuration]
$88:84EB 2C B0 18    BIT $18B0  [$7E:18B0]  ;\
$88:84EE 10 29       BPL $29    [$8519]     ;} If HDMA objects disabled: return
$88:84F0 E2 30       SEP #$30
$88:84F2 A2 00       LDX #$00               ; X = 0 (HDMA object index)
$88:84F4 86 85       STX $85    [$7E:0085]  ; HDMA channels to enable = 0
$88:84F6 8E B3 18    STX $18B3  [$7E:18B3]  ; Clear upper byte of $18B2 for convenience

; LOOP
$88:84F9 8E B2 18    STX $18B2  [$7E:18B2]  ; HDMA object index = [X]
$88:84FC BD B4 18    LDA $18B4,x[$7E:18B4]  ;\
$88:84FF F0 0A       BEQ $0A    [$850B]     ;} If [HDMA object channel] != 0:
$88:8501 05 85       ORA $85    [$7E:0085]  ;\
$88:8503 85 85       STA $85    [$7E:0085]  ;} HDMA channels to enable |= [HDMA object channel]
$88:8505 20 1C 85    JSR $851C  [$88:851C]  ; HDMA object instruction handler
$88:8508 AE B2 18    LDX $18B2  [$7E:18B2]

$88:850B E8          INX                    ;\
$88:850C E8          INX                    ;} X += 2
$88:850D E0 0C       CPX #$0C               ;\
$88:850F D0 E8       BNE $E8    [$84F9]     ;} If [X] != Ch: go to LOOP
$88:8511 20 00 80    JSR $8000  [$88:8000]  ; Layer blending handler
$88:8514 AB          PLB
$88:8515 28          PLP
$88:8516 6B          RTL                    ; Return

; Nothing points here, devs might have misplaced their destination label for the HDMA objects disabled branch ($84EE)
$88:8517 64 85       STZ $85    [$7E:0085]  ; HDMA channels to enable = 0

$88:8519 AB          PLB
$88:851A 28          PLP
$88:851B 6B          RTL
}


;;; $851C: HDMA object instruction handler ;;;
{
;; Parameter:
;;     X: HDMA object index

; Some instructions (e.g. sleep) pop the return address pushed to the stack by $854F to return out of *this* routine
; (marked "terminate processing HDMA object")
$88:851C C2 20       REP #$20
$88:851E BD F0 18    LDA $18F0,x[$7E:18F0]  ;\
$88:8521 85 12       STA $12    [$7E:0012]  ;|
$88:8523 BD FC 18    LDA $18FC,x[$7E:18FC]  ;|
$88:8526 85 14       STA $14    [$7E:0014]  ;} Execute [HDMA object pre-instruction]
$88:8528 4B          PHK                    ;|
$88:8529 F4 2E 85    PEA $852E              ;|
$88:852C DC 12 00    JML [$0012][$88:84B8]  ;/

$88:852F E2 10       SEP #$10
$88:8531 C2 20       REP #$20
$88:8533 AE B2 18    LDX $18B2  [$7E:18B2]  ; X = [HDMA object index]
$88:8536 DE E4 18    DEC $18E4,x[$7E:18E4]  ; Decrement HDMA object instruction timer
$88:8539 D0 2B       BNE $2B    [$8566]     ; If [HDMA object instruction timer] != 0: return
$88:853B BC C1 18    LDY $18C1,x[$7E:18C1]  ;\
$88:853E 5A          PHY                    ;} DB = [HDMA object bank]
$88:853F AB          PLB                    ;/
$88:8540 BD CC 18    LDA $18CC,x[$7E:18CC]  ;\
$88:8543 C2 10       REP #$10               ;} Y = [HDMA object instruction list pointer]
$88:8545 A8          TAY                    ;/

; LOOP
$88:8546 B9 00 00    LDA $0000,y[$88:EB73]  ;\
$88:8549 10 0A       BPL $0A    [$8555]     ;} If [[Y]] & 8000h != 0:
$88:854B 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]]
$88:854D C8          INY                    ;\
$88:854E C8          INY                    ;} Y += 2
$88:854F F4 45 85    PEA $8545              ;\
$88:8552 6C 12 00    JMP ($0012)[$88:8655]  ;} Execute [$12] and go to LOOP

                                            ; Else ([[Y]] & 8000h = 0):
$88:8555 9D E4 18    STA $18E4,x[$7E:18E4]  ; HDMA object instruction timer = [[Y]]
$88:8558 98          TYA                    ;\
$88:8559 18          CLC                    ;|
$88:855A 69 04 00    ADC #$0004             ;} HDMA object instruction list pointer = [Y] + 4
$88:855D 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:8560 B9 02 00    LDA $0002,y[$88:EB7F]  ;\
$88:8563 9D D8 18    STA $18D8,x[$7E:18D8]  ;} HDMA object table pointer = [[Y] + 2]

$88:8566 E2 30       SEP #$30
$88:8568 60          RTS
}


;;; $8569..868B: Instructions ;;;
{
;;; $8569: Instruction - delete ;;;
{
$88:8569 9E B4 18    STZ $18B4,x[$7E:18B4]  ; Delete HDMA object
$88:856C 68          PLA                    ; Terminate processing HDMA object
$88:856D E2 30       SEP #$30
$88:856F 60          RTS
}


;;; $8570: Instruction - pre-instruction = [[Y]] ;;;
{
$88:8570 B9 00 00    LDA $0000,y[$88:EB7A]
$88:8573 9D F0 18    STA $18F0,x[$7E:18F0]
$88:8576 E2 20       SEP #$20
$88:8578 B9 02 00    LDA $0002,y[$88:EB7C]
$88:857B 9D FC 18    STA $18FC,x[$7E:18FC]
$88:857E C2 20       REP #$20
$88:8580 C8          INY
$88:8581 C8          INY
$88:8582 C8          INY
$88:8583 60          RTS
}


;;; $8584: Unused. Instruction - clear pre-instruction ;;;
{
$88:8584 A9 8A 85    LDA #$858A
$88:8587 9D F0 18    STA $18F0,x

$88:858A 60          RTS
}


;;; $858B: Unused. Instruction - call function [[Y]] ;;;
{
$88:858B B9 00 00    LDA $0000,y
$88:858E 85 12       STA $12    [$7E:0012]
$88:8590 DA          PHX
$88:8591 5A          PHY
$88:8592 F4 97 85    PEA $8597
$88:8595 6C 12 00    JMP ($0012)

$88:8598 7A          PLY
$88:8599 FA          PLX
$88:859A C8          INY
$88:859B C8          INY
$88:859C 60          RTS
}


;;; $859D: Unused. Instruction - call function [[Y]] with A = [[Y] + 2] ;;;
{
$88:859D B9 00 00    LDA $0000,y
$88:85A0 85 12       STA $12    [$7E:0012]
$88:85A2 B9 02 00    LDA $0002,y
$88:85A5 DA          PHX
$88:85A6 5A          PHY
$88:85A7 F4 AC 85    PEA $85AC
$88:85AA 6C 12 00    JMP ($0012)

$88:85AD 7A          PLY
$88:85AE FA          PLX
$88:85AF C8          INY
$88:85B0 C8          INY
$88:85B1 C8          INY
$88:85B2 C8          INY
$88:85B3 60          RTS
}


;;; $85B4: Instruction - call external function [[Y]] ;;;
{
$88:85B4 B9 00 00    LDA $0000,y[$88:8AD6]
$88:85B7 85 12       STA $12    [$7E:0012]
$88:85B9 B9 01 00    LDA $0001,y[$88:8AD7]
$88:85BC 85 13       STA $13    [$7E:0013]
$88:85BE DA          PHX
$88:85BF 5A          PHY
$88:85C0 22 CA 85 88 JSL $8885CA[$88:85CA]
$88:85C4 7A          PLY
$88:85C5 FA          PLX
$88:85C6 C8          INY
$88:85C7 C8          INY
$88:85C8 C8          INY
$88:85C9 60          RTS

$88:85CA DC 12 00    JML [$0012][$88:8B14]
}


;;; $85CD: Unused. Instruction - call external function [[Y]] with A = [[Y] + 3] ;;;
{
$88:85CD B9 00 00    LDA $0000,y
$88:85D0 85 12       STA $12    [$7E:0012]
$88:85D2 B9 01 00    LDA $0001,y
$88:85D5 85 13       STA $13    [$7E:0013]
$88:85D7 B9 03 00    LDA $0003,y
$88:85DA DA          PHX
$88:85DB 5A          PHY
$88:85DC 22 E9 85 88 JSL $8885E9[$88:85E9]
$88:85E0 7A          PLY
$88:85E1 FA          PLX
$88:85E2 98          TYA
$88:85E3 18          CLC
$88:85E4 69 05 00    ADC #$0005
$88:85E7 A8          TAY
$88:85E8 60          RTS

$88:85E9 DC 12 00    JML [$0012]
}


;;; $85EC: Instruction - go to [[Y]] ;;;
{
$88:85EC B9 00 00    LDA $0000,y[$88:B0BA]
$88:85EF A8          TAY
$88:85F0 60          RTS
}


;;; $85F1: Unused. Instruction - go to [Y] + ±[[Y]] ;;;
{
$88:85F1 84 12       STY $12    [$7E:0012]
$88:85F3 88          DEY
$88:85F4 B9 00 00    LDA $0000,y
$88:85F7 EB          XBA
$88:85F8 30 05       BMI $05    [$85FF]
$88:85FA 29 FF 00    AND #$00FF
$88:85FD 80 03       BRA $03    [$8602]

$88:85FF 09 00 FF    ORA #$FF00

$88:8602 18          CLC
$88:8603 65 12       ADC $12    [$7E:0012]
$88:8605 A8          TAY
$88:8606 60          RTS
}


;;; $8607: Unused. Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
$88:8607 DE 08 19    DEC $1908,x
$88:860A D0 E0       BNE $E0    [$85EC]
$88:860C C8          INY
$88:860D C8          INY
$88:860E 60          RTS
}


;;; $860F: Unused. Instruction - decrement timer and go to [Y] + ±[[Y]] if non-zero ;;;
{
$88:860F DE 08 19    DEC $1908,x
$88:8612 D0 DD       BNE $DD    [$85F1]
$88:8614 C8          INY
$88:8615 60          RTS
}


;;; $8616: Unused. Instruction - timer = [[Y]] ;;;
{
$88:8616 E2 20       SEP #$20
$88:8618 B9 00 00    LDA $0000,y
$88:861B 9D 08 19    STA $1908,x
$88:861E C2 20       REP #$20
$88:8620 C8          INY
$88:8621 60          RTS
}


;;; $8622: Unused. Instruction - HDMA control = [[Y]] ;;;
{
$88:8622 DA          PHX
$88:8623 BD C0 18    LDA $18C0,x
$88:8626 29 FF 00    AND #$00FF
$88:8629 AA          TAX
$88:862A E2 20       SEP #$20
$88:862C B9 00 00    LDA $0000,y
$88:862F 9D 00 43    STA $4300,x
$88:8632 C2 20       REP #$20
$88:8634 FA          PLX
$88:8635 C8          INY
$88:8636 60          RTS
}


;;; $8637: Unused. Instruction - HDMA target = [[Y]] ;;;
{
$88:8637 DA          PHX
$88:8638 BD C0 18    LDA $18C0,x
$88:863B 29 FF 00    AND #$00FF
$88:863E AA          TAX
$88:863F E2 20       SEP #$20
$88:8641 B9 00 00    LDA $0000,y
$88:8644 9D 01 43    STA $4301,x
$88:8647 C2 20       REP #$20
$88:8649 FA          PLX
$88:864A C8          INY
$88:864B 60          RTS
}


;;; $864C: Unused. Instruction - HDMA table pointer = [[Y]] ;;;
{
$88:864C B9 00 00    LDA $0000,y
$88:864F 9D D8 18    STA $18D8,x
$88:8652 C8          INY
$88:8653 C8          INY
$88:8654 60          RTS
}


;;; $8655: Instruction - HDMA table bank = [[Y]] ;;;
{
$88:8655 DA          PHX
$88:8656 BD C0 18    LDA $18C0,x[$7E:18C0]
$88:8659 29 FF 00    AND #$00FF
$88:865C AA          TAX
$88:865D E2 20       SEP #$20
$88:865F B9 00 00    LDA $0000,y[$88:EB75]
$88:8662 9D 04 43    STA $4304,x          
$88:8665 C2 20       REP #$20
$88:8667 FA          PLX
$88:8668 C8          INY
$88:8669 60          RTS
}


;;; $866A: Instruction - indirect HDMA data bank = [[Y]] ;;;
{
$88:866A DA          PHX
$88:866B BD C0 18    LDA $18C0,x[$7E:18C0]
$88:866E 29 FF 00    AND #$00FF
$88:8671 AA          TAX
$88:8672 E2 20       SEP #$20
$88:8674 B9 00 00    LDA $0000,y[$88:DED8]
$88:8677 9D 07 43    STA $4307,x          
$88:867A C2 20       REP #$20
$88:867C FA          PLX
$88:867D C8          INY
$88:867E 60          RTS
}


;;; $867F: Unused. Instruction - skip next instruction ;;;
{
$88:867F C8          INY
$88:8680 C8          INY
$88:8681 60          RTS
}


;;; $8682: Instruction - sleep ;;;
{
$88:8682 88          DEY                    ;\
$88:8683 88          DEY                    ;|
$88:8684 98          TYA                    ;} HDMA object instruction list pointer = [Y] - 2
$88:8685 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:8688 68          PLA                    ; Terminate processing HDMA object
$88:8689 E2 30       SEP #$30
$88:868B 60          RTS
}
}


;;; $868C: Raise/lower FX ;;;
{
;; Returns:
;;     Carry: set if reached target position, clear otherwise
$88:868C AD 7A 19    LDA $197A  [$7E:197A]  ;\
$88:868F 30 5C       BMI $5C    [$86ED]     ;} If [FX target Y position] < 0: return carry set
$88:8691 64 16       STZ $16    [$7E:0016]  ; $16 = 0
$88:8693 64 18       STZ $18    [$7E:0018]  ; $18 = 0
$88:8695 AD 7C 19    LDA $197C  [$7E:197C]  ;\
$88:8698 10 29       BPL $29    [$86C3]     ;} If [FX Y velocity] >= 0: go to BRANCH_LOWER
$88:869A C6 18       DEC $18    [$7E:0018]
$88:869C 85 17       STA $17    [$7E:0017]
$88:869E AD 76 19    LDA $1976  [$7E:1976]  ;\
$88:86A1 18          CLC                    ;|
$88:86A2 65 16       ADC $16    [$7E:0016]  ;} FX base Y subposition += [FX Y subvelocity]
$88:86A4 8D 76 19    STA $1976  [$7E:1976]  ;/
$88:86A7 AD 78 19    LDA $1978  [$7E:1978]  ;\
$88:86AA 65 18       ADC $18    [$7E:0018]  ;|
$88:86AC 10 03       BPL $03    [$86B1]     ;|
$88:86AE A9 00 00    LDA #$0000             ;} FX base Y position = max(0, [FX base Y position] + [FX Y velocity])
                                            ;|
$88:86B1 8D 78 19    STA $1978  [$7E:1978]  ;/
$88:86B4 AD 7A 19    LDA $197A  [$7E:197A]  ;\
$88:86B7 CD 78 19    CMP $1978  [$7E:1978]  ;} If [FX base Y position] > [FX target Y position]: return carry clear
$88:86BA 90 06       BCC $06    [$86C2]     ;/
$88:86BC 8D 78 19    STA $1978  [$7E:1978]  ; FX base Y position = [FX target Y position]
$88:86BF 9C 76 19    STZ $1976  [$7E:1976]  ; FX base Y subposition = 0

$88:86C2 60          RTS                    ; Return carry set

; BRANCH_LOWER
$88:86C3 85 17       STA $17    [$7E:0017]
$88:86C5 AD 76 19    LDA $1976  [$7E:1976]  ;\
$88:86C8 18          CLC                    ;|
$88:86C9 65 16       ADC $16    [$7E:0016]  ;} FX base Y subposition += [FX Y subvelocity]
$88:86CB 8D 76 19    STA $1976  [$7E:1976]  ;/
$88:86CE AD 78 19    LDA $1978  [$7E:1978]  ;\
$88:86D1 65 18       ADC $18    [$7E:0018]  ;|
$88:86D3 10 03       BPL $03    [$86D8]     ;|
$88:86D5 A9 FF FF    LDA #$FFFF             ;} FX base Y position = max(-1, [FX base Y position] + [FX Y velocity])
                                            ;|
$88:86D8 8D 78 19    STA $1978  [$7E:1978]  ;/
$88:86DB AD 7A 19    LDA $197A  [$7E:197A]  ;\
$88:86DE CD 78 19    CMP $1978  [$7E:1978]  ;} If [FX target Y position] >= [FX base Y position]: return carry clear
$88:86E1 B0 08       BCS $08    [$86EB]     ;/
$88:86E3 8D 78 19    STA $1978  [$7E:1978]  ; FX base Y position = [FX target Y position]
$88:86E6 9C 76 19    STZ $1976  [$7E:1976]  ; FX base Y subposition = 0
$88:86E9 38          SEC                    ;\
$88:86EA 60          RTS                    ;} Return carry set

$88:86EB 18          CLC
$88:86EC 60          RTS

$88:86ED 38          SEC
$88:86EE 60          RTS
}


;;; $86EF..8AA3: X-ray ;;;
{
;;; $86EF: Pre-instruction - x-ray - main ;;;
{
$88:86EF 08          PHP
$88:86F0 C2 30       REP #$30
$88:86F2 A2 00 10    LDX #$1000             ; X = 1000h
$88:86F5 AD 6E 19    LDA $196E  [$7E:196E]  ;\
$88:86F8 C9 24 00    CMP #$0024             ;} If [FX type] != fireflea:
$88:86FB F0 1B       BEQ $1B    [$8718]     ;/
$88:86FD A2 00 20    LDX #$2000             ; X = 2000h
$88:8700 22 43 D1 91 JSL $91D143[$91:D143]  ;\
$88:8704 F0 12       BEQ $12    [$8718]     ;} If x-ray can show blocks:
$88:8706 A2 00 40    LDX #$4000             ; X = 4000h
$88:8709 A9 27 00    LDA #$0027             ;\
$88:870C 85 74       STA $74    [$7E:0074]  ;|
$88:870E A9 47 00    LDA #$0047             ;|
$88:8711 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (7, 7, 7) (grey)
$88:8713 A9 87 00    LDA #$0087             ;|
$88:8716 85 76       STA $76    [$7E:0076]  ;/

$88:8718 8A          TXA                    ;\
$88:8719 0C 86 19    TSB $1986  [$7E:1986]  ;} Layer blending window 2 configuration |= [X] >> 8
$88:871C AD 7A 0A    LDA $0A7A  [$7E:0A7A]  ;\
$88:871F 0A          ASL A                  ;|
$88:8720 AA          TAX                    ;} Execute [$8726 + [x-ray state] * 2]
$88:8721 FC 26 87    JSR ($8726,x)[$88:8732];/
$88:8724 28          PLP
$88:8725 6B          RTL

$88:8726             dw 8732, 8754, 87AB, 8934, 89BA, 8A08
}


;;; $8732: Handle x-ray scope - x-ray state = 0 (no beam) ;;;
{
$88:8732 08          PHP
$88:8733 C2 30       REP #$30
$88:8735 A5 8B       LDA $8B    [$7E:008B]  ;\
$88:8737 2C B6 09    BIT $09B6  [$7E:09B6]  ;} If not holding run:
$88:873A D0 08       BNE $08    [$8744]     ;/
$88:873C A9 03 00    LDA #$0003             ;\
$88:873F 8D 7A 0A    STA $0A7A  [$7E:0A7A]  ;} X-ray state = 3
$88:8742 80 0D       BRA $0D    [$8751]     ; Return

$88:8744 20 96 88    JSR $8896  [$88:8896]  ; Calculate x-ray HDMA data table
$88:8747 AD 7A 0A    LDA $0A7A  [$7E:0A7A]  ;\
$88:874A 1A          INC A                  ;} X-ray state = 1
$88:874B 8D 7A 0A    STA $0A7A  [$7E:0A7A]  ;/
$88:874E 20 53 87    JSR $8753  [$88:8753]  ; NOP

$88:8751 28          PLP
$88:8752 60          RTS
}


;;; $8753: RTS ;;;
{
$88:8753 60          RTS
}


;;; $8754: Handle x-ray scope - x-ray state = 1 (beam is widening) ;;;
{
$88:8754 08          PHP
$88:8755 C2 30       REP #$30
$88:8757 A5 8B       LDA $8B    [$7E:008B]  ;\
$88:8759 2C B6 09    BIT $09B6  [$7E:09B6]  ;} If not holding run:
$88:875C D0 08       BNE $08    [$8766]     ;/
$88:875E A9 03 00    LDA #$0003             ;\
$88:8761 8D 7A 0A    STA $0A7A  [$7E:0A7A]  ;} X-ray state = 3
$88:8764 80 43       BRA $43    [$87A9]     ; Return

$88:8766 20 53 87    JSR $8753  [$88:8753]  ; NOP
$88:8769 C2 20       REP #$20
$88:876B AD 7E 0A    LDA $0A7E  [$7E:0A7E]  ;\
$88:876E 18          CLC                    ;|
$88:876F 69 00 08    ADC #$0800             ;|
$88:8772 8D 7E 0A    STA $0A7E  [$7E:0A7E]  ;} X-ray angular width delta += 0.0800h
$88:8775 AD 7C 0A    LDA $0A7C  [$7E:0A7C]  ;|
$88:8778 69 00 00    ADC #$0000             ;|
$88:877B 8D 7C 0A    STA $0A7C  [$7E:0A7C]  ;/
$88:877E AD 86 0A    LDA $0A86  [$7E:0A86]  ;\
$88:8781 18          CLC                    ;|
$88:8782 6D 7E 0A    ADC $0A7E  [$7E:0A7E]  ;|
$88:8785 8D 86 0A    STA $0A86  [$7E:0A86]  ;} X-ray angular width += [x-ray angular width delta]
$88:8788 AD 84 0A    LDA $0A84  [$7E:0A84]  ;|
$88:878B 6D 7C 0A    ADC $0A7C  [$7E:0A7C]  ;|
$88:878E 8D 84 0A    STA $0A84  [$7E:0A84]  ;/
$88:8791 C9 0B 00    CMP #$000B             ;\
$88:8794 30 10       BMI $10    [$87A6]     ;} If [x-ray angular width] >= Bh:
$88:8796 9C 86 0A    STZ $0A86  [$7E:0A86]  ;\
$88:8799 A9 0A 00    LDA #$000A             ;} X-ray angular width = A.0000h
$88:879C 8D 84 0A    STA $0A84  [$7E:0A84]  ;/
$88:879F AD 7A 0A    LDA $0A7A  [$7E:0A7A]  ;\
$88:87A2 1A          INC A                  ;} X-ray state = 2
$88:87A3 8D 7A 0A    STA $0A7A  [$7E:0A7A]  ;/

$88:87A6 20 96 88    JSR $8896  [$88:8896]  ; Calculate x-ray HDMA data table

$88:87A9 28          PLP
$88:87AA 60          RTS
}


;;; $87AB: Handle x-ray scope - x-ray state = 2 (full beam) ;;;
{
$88:87AB 08          PHP
$88:87AC C2 30       REP #$30
$88:87AE A5 8B       LDA $8B    [$7E:008B]  ;\
$88:87B0 2C B6 09    BIT $09B6  [$7E:09B6]  ;} If holding run:
$88:87B3 F0 0B       BEQ $0B    [$87C0]     ;/
$88:87B5 20 C5 87    JSR $87C5  [$88:87C5]  ; Handle moving x-ray up/down
$88:87B8 20 96 88    JSR $8896  [$88:8896]  ; Calculate x-ray HDMA data table
$88:87BB 20 53 87    JSR $8753  [$88:8753]  ; NOP
$88:87BE 28          PLP
$88:87BF 60          RTS                    ; Return

$88:87C0 EE 7A 0A    INC $0A7A  [$7E:0A7A]  ; X-ray state = 3
$88:87C3 28          PLP
$88:87C4 60          RTS
}


;;; $87C5: Handle moving x-ray up/down ;;;
{
$88:87C5 08          PHP
$88:87C6 C2 30       REP #$30
$88:87C8 A5 8B       LDA $8B    [$7E:008B]  ;\
$88:87CA 2C AA 09    BIT $09AA  [$7E:09AA]  ;} If holding up: go to BRANCH_UP
$88:87CD D0 07       BNE $07    [$87D6]     ;/
$88:87CF 2C AC 09    BIT $09AC  [$7E:09AC]  ;\
$88:87D2 D0 07       BNE $07    [$87DB]     ;} If holding down: go to BRANCH_DOWN
$88:87D4 80 08       BRA $08    [$87DE]     ; Return

; BRANCH_UP
$88:87D6 20 E0 87    JSR $87E0  [$88:87E0]  ; Move x-ray up
$88:87D9 80 03       BRA $03    [$87DE]

; BRANCH_DOWN
$88:87DB 20 35 88    JSR $8835  [$88:8835]  ; Move x-ray down

$88:87DE 28          PLP
$88:87DF 60          RTS
}


;;; $87E0: Move x-ray up ;;;
{
$88:87E0 08          PHP
$88:87E1 C2 30       REP #$30
$88:87E3 AD 82 0A    LDA $0A82  [$7E:0A82]  ;\
$88:87E6 C9 80 00    CMP #$0080             ;} If [x-ray angle] >= 80h: go to FACING_LEFT
$88:87E9 10 1F       BPL $1F    [$880A]     ;/
$88:87EB 38          SEC                    ;\
$88:87EC ED 84 0A    SBC $0A84  [$7E:0A84]  ;} If [x-ray angle] = [x-ray angular width]: return
$88:87EF F0 42       BEQ $42    [$8833]     ;/
$88:87F1 30 0F       BMI $0F    [$8802]     ; If [x-ray angle] > [x-ray angular width]:
$88:87F3 AD 82 0A    LDA $0A82  [$7E:0A82]  ;\
$88:87F6 38          SEC                    ;|
$88:87F7 E9 01 00    SBC #$0001             ;} X-ray angle -= 1
$88:87FA 8D 82 0A    STA $0A82  [$7E:0A82]  ;/
$88:87FD ED 84 0A    SBC $0A84  [$7E:0A84]  ;\
$88:8800 10 31       BPL $31    [$8833]     ;} If [x-ray angle] >= [x-ray angular width]: return

$88:8802 AD 84 0A    LDA $0A84  [$7E:0A84]  ;\
$88:8805 8D 82 0A    STA $0A82  [$7E:0A82]  ;} X-ray angle = [x-ray angular width]
$88:8808 80 29       BRA $29    [$8833]

; FACING_LEFT
$88:880A 18          CLC                    ;\
$88:880B 6D 84 0A    ADC $0A84  [$7E:0A84]  ;|
$88:880E C9 00 01    CMP #$0100             ;} If [x-ray angle] + [x-ray angular width] = 100h: return
$88:8811 F0 20       BEQ $20    [$8833]     ;/
$88:8813 10 14       BPL $14    [$8829]     ; If [x-ray angle] + [x-ray angular width] < 100h:
$88:8815 AD 82 0A    LDA $0A82  [$7E:0A82]  ;\
$88:8818 18          CLC                    ;|
$88:8819 69 01 00    ADC #$0001             ;} X-ray angle += 1
$88:881C 8D 82 0A    STA $0A82  [$7E:0A82]  ;/
$88:881F 6D 84 0A    ADC $0A84  [$7E:0A84]  ;\
$88:8822 C9 00 01    CMP #$0100             ;|
$88:8825 F0 0C       BEQ $0C    [$8833]     ;} If [x-ray angle] + [x-ray angular width] <= 100h: return
$88:8827 30 0A       BMI $0A    [$8833]     ;/

$88:8829 A9 00 01    LDA #$0100             ;\
$88:882C 38          SEC                    ;|
$88:882D ED 84 0A    SBC $0A84  [$7E:0A84]  ;} X-ray angle = 100h - [x-ray angular width]
$88:8830 8D 82 0A    STA $0A82  [$7E:0A82]  ;/

$88:8833 28          PLP
$88:8834 60          RTS
}


;;; $8835: Move x-ray down ;;;
{
$88:8835 08          PHP
$88:8836 C2 30       REP #$30
$88:8838 AD 82 0A    LDA $0A82  [$7E:0A82]  ;\
$88:883B C9 80 00    CMP #$0080             ;} If [x-ray angle] >= 80h: go to FACING_LEFT
$88:883E 10 2B       BPL $2B    [$886B]     ;/
$88:8840 18          CLC                    ;\
$88:8841 6D 84 0A    ADC $0A84  [$7E:0A84]  ;|
$88:8844 C9 80 00    CMP #$0080             ;} If [x-ray angle] + [x-ray angular width] = 80h: return
$88:8847 F0 4B       BEQ $4B    [$8894]     ;/
$88:8849 10 14       BPL $14    [$885F]     ; If [x-ray angle] + [x-ray angular width] < 80h:
$88:884B AD 82 0A    LDA $0A82  [$7E:0A82]  ;\
$88:884E 18          CLC                    ;|
$88:884F 69 01 00    ADC #$0001             ;} X-ray angle += 1
$88:8852 8D 82 0A    STA $0A82  [$7E:0A82]  ;/
$88:8855 6D 84 0A    ADC $0A84  [$7E:0A84]  ;\
$88:8858 C9 80 00    CMP #$0080             ;|
$88:885B F0 37       BEQ $37    [$8894]     ;} If [x-ray angle] + [x-ray angular width] <= 80h: return
$88:885D 30 35       BMI $35    [$8894]     ;/

$88:885F A9 80 00    LDA #$0080             ;\
$88:8862 38          SEC                    ;|
$88:8863 ED 84 0A    SBC $0A84  [$7E:0A84]  ;} X-ray angle = 80h - [x-ray angular width]
$88:8866 8D 82 0A    STA $0A82  [$7E:0A82]  ;/
$88:8869 80 29       BRA $29    [$8894]

; FACING_LEFT
$88:886B 38          SEC                    ;\
$88:886C ED 84 0A    SBC $0A84  [$7E:0A84]  ;|
$88:886F C9 80 00    CMP #$0080             ;} If [x-ray angle] - [x-ray angular width] = 80h: return
$88:8872 F0 20       BEQ $20    [$8894]     ;/
$88:8874 30 14       BMI $14    [$888A]     ; If [x-ray angle] - [x-ray angular width] > 80h:
$88:8876 AD 82 0A    LDA $0A82  [$7E:0A82]  ;\
$88:8879 38          SEC                    ;|
$88:887A E9 01 00    SBC #$0001             ;} X-ray angle -= 1
$88:887D 8D 82 0A    STA $0A82  [$7E:0A82]  ;/
$88:8880 ED 84 0A    SBC $0A84  [$7E:0A84]  ;\
$88:8883 C9 80 00    CMP #$0080             ;|
$88:8886 F0 0C       BEQ $0C    [$8894]     ;} If [x-ray angle] - [x-ray angular width] >= 80h: return
$88:8888 10 0A       BPL $0A    [$8894]     ;/

$88:888A A9 80 00    LDA #$0080             ;\
$88:888D 18          CLC                    ;|
$88:888E 6D 84 0A    ADC $0A84  [$7E:0A84]  ;} X-ray angle = 80h + [x-ray angular width]
$88:8891 8D 82 0A    STA $0A82  [$7E:0A82]  ;/

$88:8894 28          PLP
$88:8895 60          RTS
}


;;; $8896: Calculate x-ray HDMA data table ;;;
{
$88:8896 08          PHP
$88:8897 C2 30       REP #$30
$88:8899 A9 00 7E    LDA #$7E00             ;\
$88:889C 85 01       STA $01    [$7E:0001]  ;|
$88:889E A9 00 98    LDA #$9800             ;} $00 = $7E:9800 (x-ray HDMA data table)
$88:88A1 85 00       STA $00    [$7E:0000]  ;/
$88:88A3 AD 82 0A    LDA $0A82  [$7E:0A82]  ;\
$88:88A6 85 12       STA $12    [$7E:0012]  ;} $12 = [x-ray angle]
$88:88A8 AD 84 0A    LDA $0A84  [$7E:0A84]  ;\
$88:88AB 85 14       STA $14    [$7E:0014]  ;} $14 = [x-ray angular width]
$88:88AD AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$88:88B0 29 FF 00    AND #$00FF             ;|
$88:88B3 C9 04 00    CMP #$0004             ;} If Samus is facing right:
$88:88B6 F0 0E       BEQ $0E    [$88C6]     ;/
$88:88B8 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$88:88BB 38          SEC                    ;|
$88:88BC ED 11 09    SBC $0911  [$7E:0911]  ;|
$88:88BF 18          CLC                    ;} X = [Samus X position] - [layer 1 X position] + 3
$88:88C0 69 03 00    ADC #$0003             ;|
$88:88C3 AA          TAX                    ;/
$88:88C4 80 0B       BRA $0B    [$88D1]

$88:88C6 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\ Else (Samus is facing left):
$88:88C9 38          SEC                    ;|
$88:88CA ED 11 09    SBC $0911  [$7E:0911]  ;} X = [Samus X position] - [layer 1 X position] - 3
$88:88CD E9 03 00    SBC #$0003             ;|
$88:88D0 AA          TAX                    ;/

$88:88D1 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$88:88D4 29 FF 00    AND #$00FF             ;|
$88:88D7 C9 05 00    CMP #$0005             ;} If [Samus movement type] != crouching:
$88:88DA F0 0D       BEQ $0D    [$88E9]     ;/
$88:88DC AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$88:88DF 38          SEC                    ;|
$88:88E0 ED 15 09    SBC $0915  [$7E:0915]  ;} Y = [Samus Y position] - [layer 1 Y position] - 10h
$88:88E3 E9 10 00    SBC #$0010             ;|
$88:88E6 A8          TAY                    ;/
$88:88E7 80 0B       BRA $0B    [$88F4]

$88:88E9 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\ Else ([Samus movement type] = crouching):
$88:88EC 38          SEC                    ;|
$88:88ED ED 15 09    SBC $0915  [$7E:0915]  ;} Y = [Samus Y position] - [layer 1 Y position] - Ch
$88:88F0 E9 0C 00    SBC #$000C             ;|
$88:88F3 A8          TAY                    ;/

$88:88F4 E0 00 00    CPX #$0000             ;\
$88:88F7 30 12       BMI $12    [$890B]     ;} If [X] < 0: go to BRANCH_LEFT_OF_SCREEN
$88:88F9 E0 00 01    CPX #$0100             ;\
$88:88FC 30 1A       BMI $1A    [$8918]     ;} If [X] < 100h: go to BRANCH_ON_SCREEN
$88:88FE AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$88:8901 29 FF 00    AND #$00FF             ;|
$88:8904 C9 08 00    CMP #$0008             ;} If Samus is facing right: go to BRANCH_OFF_SCREEN
$88:8907 F0 1B       BEQ $1B    [$8924]     ;/
$88:8909 80 13       BRA $13    [$891E]     ; Go to BRANCH_ON_SCREEN_FROM_OFF_SCREEN

; BRANCH_LEFT_OF_SCREEN
$88:890B AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$88:890E 29 FF 00    AND #$00FF             ;|
$88:8911 C9 04 00    CMP #$0004             ;} If Samus is facing left: go to BRANCH_OFF_SCREEN
$88:8914 F0 0E       BEQ $0E    [$8924]     ;/
$88:8916 80 06       BRA $06    [$891E]     ; Go to BRANCH_ON_SCREEN_FROM_OFF_SCREEN

; BRANCH_ON_SCREEN
$88:8918 22 4B C5 91 JSL $91C54B[$91:C54B]  ; Calculate x-ray HDMA data table - x-ray origin is on screen
$88:891C 28          PLP
$88:891D 60          RTS                    ; Return

; BRANCH_ON_SCREEN_FROM_OFF_SCREEN
$88:891E 22 11 BE 91 JSL $91BE11[$91:BE11]  ; Calculate x-ray HDMA data table - x-ray origin is off screen
$88:8922 28          PLP
$88:8923 60          RTS                    ; Return

; BRANCH_OFF_SCREEN
$88:8924 A2 FE 01    LDX #$01FE             ;\
$88:8927 A9 FF 00    LDA #$00FF             ;|
                                            ;|
$88:892A 9F 00 98 7E STA $7E9800,x          ;} $7E:9800..99FF = FFh,00h
$88:892E CA          DEX                    ;|
$88:892F CA          DEX                    ;|
$88:8930 10 F8       BPL $F8    [$892A]     ;/
$88:8932 28          PLP
$88:8933 60          RTS
}


;;; $8934: Handle x-ray scope - x-ray state = 3 (deactivate beam - restore BG2 - first half) ;;;
{
$88:8934 08          PHP
$88:8935 C2 30       REP #$30
$88:8937 A9 01 00    LDA #$0001             ;\
$88:893A 8D 88 0A    STA $0A88  [$7E:0A88]  ;|
$88:893D A9 00 98    LDA #$9800             ;|
$88:8940 8D 89 0A    STA $0A89  [$7E:0A89]  ;|
$88:8943 9C 8B 0A    STZ $0A8B  [$7E:0A8B]  ;} $0A88..91 = 1,$9800, 0,0...
$88:8946 9C 8C 0A    STZ $0A8C  [$7E:0A8C]  ;|
$88:8949 9C 8E 0A    STZ $0A8E  [$7E:0A8E]  ;|
$88:894C 9C 90 0A    STZ $0A90  [$7E:0A90]  ;/
$88:894F A9 FF 00    LDA #$00FF             ;\
$88:8952 8F 00 98 7E STA $7E9800[$7E:9800]  ;} $7E:9800 = FFh,0
$88:8956 A2 00 10    LDX #$1000             ; X = 1000h
$88:8959 AD 6E 19    LDA $196E  [$7E:196E]  ;\
$88:895C C9 24 00    CMP #$0024             ;} If [FX type] != fireflea:
$88:895F F0 0C       BEQ $0C    [$896D]     ;/
$88:8961 A2 00 20    LDX #$2000             ; X = 2000h
$88:8964 22 43 D1 91 JSL $91D143[$91:D143]  ;\
$88:8968 F0 03       BEQ $03    [$896D]     ;} If x-ray can show blocks:
$88:896A A2 00 40    LDX #$4000             ; X = 4000h

$88:896D 8A          TXA                    ;\
$88:896E 0C 86 19    TSB $1986  [$7E:1986]  ;} Layer blending window 2 configuration |= [X] >> 8
$88:8971 A9 00 00    LDA #$0000             ;\
$88:8974 8F 00 C0 7E STA $7EC000[$7E:C000]  ;} BG1/2 palette 0 colour 0 = 0
$88:8978 AE B2 18    LDX $18B2  [$7E:18B2]  ; X = [HDMA object index]
$88:897B BD 14 19    LDA $1914,x[$7E:1918]  ;\
$88:897E 85 B5       STA $B5    [$7E:00B5]  ;} Restore BG2 X scroll
$88:8980 BD 20 19    LDA $1920,x[$7E:1924]  ;\
$88:8983 85 B7       STA $B7    [$7E:00B7]  ;} Restore BG2 Y scroll
$88:8985 E2 20       SEP #$20               ;\
$88:8987 BD 2C 19    LDA $192C,x[$7E:1930]  ;|
$88:898A 85 59       STA $59    [$7E:0059]  ;} Restore BG2 address/size
$88:898C C2 20       REP #$20               ;/
$88:898E AE 30 03    LDX $0330  [$7E:0330]  ;\
$88:8991 E0 F0 00    CPX #$00F0             ;} If [VRAM write table stack pointer] >= F0h: return
$88:8994 10 22       BPL $22    [$89B8]     ;/
$88:8996 A9 00 08    LDA #$0800             ;\
$88:8999 95 D0       STA $D0,x  [$7E:00D0]  ;|
$88:899B A9 00 50    LDA #$5000             ;|
$88:899E 95 D2       STA $D2,x  [$7E:00D2]  ;|
$88:89A0 A9 7E 00    LDA #$007E             ;|
$88:89A3 95 D4       STA $D4,x  [$7E:00D4]  ;|
$88:89A5 A5 59       LDA $59    [$7E:0059]  ;|
$88:89A7 29 FC 00    AND #$00FC             ;} Queue transfer of 800h bytes from $7E:5000 to VRAM BG2 tilemap base
$88:89AA EB          XBA                    ;|
$88:89AB 95 D5       STA $D5,x  [$7E:00D5]  ;|
$88:89AD 8A          TXA                    ;|
$88:89AE 18          CLC                    ;|
$88:89AF 69 07 00    ADC #$0007             ;|
$88:89B2 8D 30 03    STA $0330  [$7E:0330]  ;/
$88:89B5 EE 7A 0A    INC $0A7A  [$7E:0A7A]  ; X-ray state = 4

$88:89B8 28          PLP
$88:89B9 60          RTS
}


;;; $89BA: Handle x-ray scope - x-ray state = 4 (deactivate beam - restore BG2 - second half) ;;;
{
$88:89BA 08          PHP
$88:89BB C2 30       REP #$30
$88:89BD A2 00 10    LDX #$1000             ; X = 1000h
$88:89C0 AD 6E 19    LDA $196E  [$7E:196E]  ;\
$88:89C3 C9 24 00    CMP #$0024             ;} If [FX type] != fireflea:
$88:89C6 F0 0C       BEQ $0C    [$89D4]     ;/
$88:89C8 A2 00 20    LDX #$2000             ; X = 2000h
$88:89CB 22 43 D1 91 JSL $91D143[$91:D143]  ;\
$88:89CF F0 03       BEQ $03    [$89D4]     ;} If x-ray can show blocks:
$88:89D1 A2 00 40    LDX #$4000             ; X = 4000h

$88:89D4 8A          TXA                    ;\
$88:89D5 0C 86 19    TSB $1986  [$7E:1986]  ;} Layer blending window 2 configuration |= [X] >> 8
$88:89D8 AE 30 03    LDX $0330  [$7E:0330]  ;\
$88:89DB E0 F0 00    CPX #$00F0             ;} If [VRAM write table stack pointer] >= F0h: return
$88:89DE 10 26       BPL $26    [$8A06]     ;/
$88:89E0 A9 00 08    LDA #$0800             ;\
$88:89E3 95 D0       STA $D0,x  [$7E:00D0]  ;|
$88:89E5 A9 00 58    LDA #$5800             ;|
$88:89E8 95 D2       STA $D2,x  [$7E:00D2]  ;|
$88:89EA A9 7E 00    LDA #$007E             ;|
$88:89ED 95 D4       STA $D4,x  [$7E:00D4]  ;|
$88:89EF A5 59       LDA $59    [$7E:0059]  ;|
$88:89F1 29 FC 00    AND #$00FC             ;|
$88:89F4 EB          XBA                    ;} Queue transfer of 800h bytes from $7E:5800 to VRAM BG2 tilemap base + 400h
$88:89F5 18          CLC                    ;|
$88:89F6 69 00 04    ADC #$0400             ;|
$88:89F9 95 D5       STA $D5,x  [$7E:00D5]  ;|
$88:89FB 8A          TXA                    ;|
$88:89FC 18          CLC                    ;|
$88:89FD 69 07 00    ADC #$0007             ;|
$88:8A00 8D 30 03    STA $0330  [$7E:0330]  ;/
$88:8A03 EE 7A 0A    INC $0A7A  [$7E:0A7A]  ; X-ray state = 5

$88:8A06 28          PLP
$88:8A07 60          RTS
}


;;; $8A08: Handle x-ray scope - x-ray state = 5 (deactivate beam - finish) ;;;
{
$88:8A08 08          PHP
$88:8A09 C2 30       REP #$30
$88:8A0B A2 00 10    LDX #$1000             ; X = 1000h
$88:8A0E AD 6E 19    LDA $196E  [$7E:196E]  ;\
$88:8A11 C9 24 00    CMP #$0024             ;} If [FX type] != fireflea:
$88:8A14 F0 0C       BEQ $0C    [$8A22]     ;/
$88:8A16 A2 00 20    LDX #$2000             ; X = 2000h
$88:8A19 22 43 D1 91 JSL $91D143[$91:D143]  ;\
$88:8A1D F0 03       BEQ $03    [$8A22]     ;} If x-ray can show blocks:
$88:8A1F A2 00 40    LDX #$4000             ; X = 4000h

$88:8A22 8A          TXA                    ;\
$88:8A23 0C 86 19    TSB $1986  [$7E:1986]  ;} Layer blending window 2 configuration |= [X] >> 8
$88:8A26 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:8A29 D0 02       BNE $02    [$8A2D]     ;} If time is not frozen:
$88:8A2B 28          PLP                    ;\
$88:8A2C 60          RTS                    ;} Return

$88:8A2D 9C 78 0A    STZ $0A78  [$7E:0A78]  ; Unfreeze time
$88:8A30 9C 7A 0A    STZ $0A7A  [$7E:0A7A]  ; X-ray state = 0
$88:8A33 9C 7C 0A    STZ $0A7C  [$7E:0A7C]  ; X-ray angular width delta = 0
$88:8A36 9C 7E 0A    STZ $0A7E  [$7E:0A7E]  ; X-ray angular subwidth delta = 0
$88:8A39 9C 82 0A    STZ $0A82  [$7E:0A82]  ; X-ray angle = 0
$88:8A3C 9C 84 0A    STZ $0A84  [$7E:0A84]  ; X-ray angular width = 0
$88:8A3F 9C 86 0A    STZ $0A86  [$7E:0A86]  ; X-ray angular subwidth = 0
$88:8A42 A9 01 00    LDA #$0001             ;\
$88:8A45 8D 88 0A    STA $0A88  [$7E:0A88]  ;|
$88:8A48 A9 00 98    LDA #$9800             ;|
$88:8A4B 8D 89 0A    STA $0A89  [$7E:0A89]  ;|
$88:8A4E 9C 8B 0A    STZ $0A8B  [$7E:0A8B]  ;} $0A88..91 = 1,$9800, 0,0... (x-ray indirect HDMA table)
$88:8A51 9C 8C 0A    STZ $0A8C  [$7E:0A8C]  ;|
$88:8A54 9C 8E 0A    STZ $0A8E  [$7E:0A8E]  ;|
$88:8A57 9C 90 0A    STZ $0A90  [$7E:0A90]  ;/
$88:8A5A 22 AD E2 91 JSL $91E2AD[$91:E2AD]  ; Set non x-ray Samus pose
$88:8A5E AE B2 18    LDX $18B2  [$7E:18B2]  ;\
$88:8A61 9E B4 18    STZ $18B4,x[$7E:18B8]  ;} Delete HDMA object
$88:8A64 A9 0A 00    LDA #$000A             ;\
$88:8A67 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound Ah, sound library 1, max queued sounds allowed = 6 (x-ray end)
$88:8A6B E2 20       SEP #$20
$88:8A6D AD 6E 19    LDA $196E  [$7E:196E]  ;\
$88:8A70 C9 24       CMP #$24               ;} If [FX type] != fireflea:
$88:8A72 F0 0C       BEQ $0C    [$8A80]     ;/
$88:8A74 A9 80       LDA #$80               ;\
$88:8A76 85 76       STA $76    [$7E:0076]  ;|
$88:8A78 A9 40       LDA #$40               ;|
$88:8A7A 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$88:8A7C A9 20       LDA #$20               ;|
$88:8A7E 85 74       STA $74    [$7E:0074]  ;/

$88:8A80 A9 7E       LDA #$7E               ;\
$88:8A82 85 02       STA $02    [$7E:0002]  ;|
$88:8A84 C2 20       REP #$20               ;|
$88:8A86 A9 00 98    LDA #$9800             ;|
$88:8A89 85 00       STA $00    [$7E:0000]  ;|
$88:8A8B A0 FE 01    LDY #$01FE             ;|
$88:8A8E A9 FF 00    LDA #$00FF             ;} $7E:9800..99FF = FFh,00h (x-ray HDMA data table for window 2)
                                            ;|
$88:8A91 97 00       STA [$00],y[$7E:99FE]  ;|
$88:8A93 88          DEY                    ;|
$88:8A94 88          DEY                    ;|
$88:8A95 10 FA       BPL $FA    [$8A91]     ;/
$88:8A97 AD 04 0A    LDA $0A04  [$7E:0A04]  ;\
$88:8A9A F0 06       BEQ $06    [$8AA2]     ;} If [auto-cancel HUD item index] != 0:
$88:8A9C 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing
$88:8A9F 9C 04 0A    STZ $0A04  [$7E:0A04]  ; Auto-cancel HUD item index = 0

$88:8AA2 28          PLP
$88:8AA3 60          RTS
}
}


;;; $8AA4..A61A: Power bomb ;;;
{
;;; $8AA4: Spawn power bomb explosion ;;;
{
$88:8AA4 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:8AA7 D0 1E       BNE $1E    [$8AC7]     ;} If time not frozen:
$88:8AA9 A9 01 00    LDA #$0001             ;\
$88:8AAC 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 1, sound library 1, max queued sounds allowed = 15 (power bomb explosion)
$88:8AB0 A9 00 80    LDA #$8000             ;\
$88:8AB3 8D 92 05    STA $0592  [$7E:0592]  ;} Power bomb explosion status = power bomb is exploding
$88:8AB6 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:8ABA             dx 40, 28, 8ACE        ;} Spawn indirect HDMA object for window 2 left position with instruction list $8ACE
$88:8ABE 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:8AC2             dx 40, 29, 8B80        ;} Spawn indirect HDMA object for window 2 right position with instruction list $8B80
$88:8AC6 6B          RTL                    ; Return

$88:8AC7 A9 00 40    LDA #$4000             ;\
$88:8ACA 8D 92 05    STA $0592  [$7E:0592]  ;} Power bomb explosion status = power bomb explosion is pending
$88:8ACD 6B          RTL
}


;;; $8ACE: Instruction list - power bomb explosion window 2 left position ;;;
{
$88:8ACE             dx 8655,89,     ; HDMA table bank = $89
                        866A,7E,     ; Indirect HDMA data bank = $7E
                        85B4,888B14, ; Power bomb explosion - stage 1 setup (pre-explosion - white)
                        8570,8890DF, ; Pre-instruction = power bomb explosion - stage 1 - pre-explosion - white
                        8682,        ; Sleep
                        85B4,888B32, ; Power bomb explosion - stage 2 setup (pre-explosion - yellow)
                        8570,8891A8, ; Pre-instruction = power bomb explosion - stage 2 - pre-explosion - yellow
                        8682,        ; Sleep
                        85B4,888B39, ; Power bomb explosion - stage 3 setup (explosion - yellow)
                        8570,888DE9, ; Pre-instruction = power bomb explosion - stage 3 - explosion - yellow
                        8682,        ; Sleep
                        85B4,888B47, ; Power bomb explosion - stage 4 setup (explosion - white)
                        8570,888EB2, ; Pre-instruction = power bomb explosion - stage 4 - explosion - white
                        8682,        ; Sleep
                        8570,888B98, ; Pre-instruction = power bomb explosion - stage 5 - after-glow
                        8682,        ; Sleep
                        85B4,888B4E, ; Power bomb explosion - clean up and try crystal flash
                        8682,        ; Sleep
                        8569
}


;;; $8B14: Power bomb explosion - stage 1 setup (pre-explosion - white) ;;;
{
$88:8B14 E2 20       SEP #$20
$88:8B16 A9 FF       LDA #$FF               ;\
$88:8B18 8F 06 C6 7E STA $7EC606[$7E:C606]  ;} Off-screen power bomb explosion left HDMA data entry = FFh
$88:8B1C A9 00       LDA #$00               ;\
$88:8B1E 8F 07 C6 7E STA $7EC607[$7E:C607]  ;} Off-screen power bomb explosion right HDMA data entry = 0
$88:8B22 C2 20       REP #$20
$88:8B24 A9 00 04    LDA #$0400             ;\
$88:8B27 8D EC 0C    STA $0CEC  [$7E:0CEC]  ;} Power bomb pre-explosion radius = 400h
$88:8B2A AF DB 90 88 LDA $8890DB[$88:90DB]  ;\
$88:8B2E 8D F0 0C    STA $0CF0  [$7E:0CF0]  ;} Power bomb explosion radius speed = 3000h
$88:8B31 6B          RTL
}


;;; $8B32: Power bomb explosion - stage 2 setup (pre-explosion - yellow) ;;;
{
$88:8B32 A9 06 9F    LDA #$9F06             ;\
$88:8B35 8D F2 0C    STA $0CF2  [$7E:0CF2]  ;} Pre-scaled power bomb explosion shape definition pointer = $9F06
$88:8B38 6B          RTL
}


;;; $8B39: Power bomb explosion - stage 3 setup (explosion - yellow) ;;;
{
$88:8B39 A9 00 04    LDA #$0400             ;\
$88:8B3C 8D EA 0C    STA $0CEA  [$7E:0CEA]  ;} Power bomb explosion radius = 400h
$88:8B3F AF E5 8D 88 LDA $888DE5[$88:8DE5]  ;\
$88:8B43 8D F0 0C    STA $0CF0  [$7E:0CF0]  ;} Power bomb explosion radius speed = 0
$88:8B46 6B          RTL
}


;;; $8B47: Power bomb explosion - stage 4 setup (explosion - white) ;;;
{
$88:8B47 A9 46 92    LDA #$9246             ;\
$88:8B4A 8D F2 0C    STA $0CF2  [$7E:0CF2]  ;} Pre-scaled power bomb explosion shape definition pointer = $9246
$88:8B4D 6B          RTL
}


;;; $8B4E: Power bomb explosion - clean up and try crystal flash ;;;
{
$88:8B4E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$88:8B51 CD E2 0C    CMP $0CE2  [$7E:0CE2]  ;|
$88:8B54 D0 10       BNE $10    [$8B66]     ;|
$88:8B56 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} If (Samus position) = (power bomb explosion position):
$88:8B59 CD E4 0C    CMP $0CE4  [$7E:0CE4]  ;|
$88:8B5C D0 08       BNE $08    [$8B66]     ;/
$88:8B5E DA          PHX
$88:8B5F 22 A2 D5 90 JSL $90D5A2[$90:D5A2]  ; Crystal flash
$88:8B63 FA          PLX
$88:8B64 90 03       BCC $03    [$8B69]     ; If crystal flash succeeded: go to BRANCH_CRYSTAL_FLASHING

$88:8B66 9C EE 0C    STZ $0CEE  [$7E:0CEE]  ; Power bomb flag = 0

; BRANCH_CRYSTAL_FLASHING
$88:8B69 9C 92 05    STZ $0592  [$7E:0592]  ; Clear power bomb explosion status
$88:8B6C 9E B4 18    STZ $18B4,x[$7E:18B4]  ;\
$88:8B6F 9E B6 18    STZ $18B6,x[$7E:18B6]  ;} Delete HDMA objects [X] and [X] + 2
$88:8B72 9C EC 0C    STZ $0CEC  [$7E:0CEC]  ; Power bomb pre-explosion radius = 0
$88:8B75 9C EA 0C    STZ $0CEA  [$7E:0CEA]  ; Power bomb explosion radius = 0
$88:8B78 A9 1E 00    LDA #$001E             ;\
$88:8B7B 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - resume sounds after power bomb explosion
$88:8B7F 6B          RTL
}


;;; $8B80: Instruction list - power bomb explosion window 2 right position ;;;
{
$88:8B80             dx 8655,89,     ; HDMA table bank = $89
                        866A,7E,     ; Indirect HDMA data bank = $7E
                        8570,888B8F, ; Pre-instruction = set layer blending window 2 configuration
                        8682,        ; Sleep
                        8569         ; Delete
}


;;; $8B8F: Pre-instruction - power bomb explosion - set layer blending window 2 configuration ;;;
{
; Used by $8B80: Power bomb explosion - right
$88:8B8F A9 00 80    LDA #$8000             ;\
$88:8B92 0C 86 19    TSB $1986  [$7E:1986]  ;} Layer blending window 2 configuration |= power bomb explosion active
$88:8B95 6B          RTL
}


;;; $8B96: Power bomb stage 5 HDMA object timer ;;;
{
$88:8B96             dw 0003
}


;;; $8B98: Pre-instruction - power bomb explosion - stage 5 - after-glow ;;;
{
$88:8B98 AD 92 05    LDA $0592  [$7E:0592]  ;\
$88:8B9B 30 01       BMI $01    [$8B9E]     ;} If power bomb is not exploding:
$88:8B9D 6B          RTL                    ; Return

$88:8B9E DE 08 19    DEC $1908,x[$7E:1908]  ; Decrement HDMA object timer
$88:8BA1 10 37       BPL $37    [$8BDA]     ; If [HDMA object timer] >= 0: return
$88:8BA3 E2 20       SEP #$20
$88:8BA5 DE 38 19    DEC $1938,x[$7E:1938]  ; Decrement HDMA object after-glow animation frame
$88:8BA8 F0 31       BEQ $31    [$8BDB]     ; If [HDMA object after-glow animation frame] = 0: go to BRANCH_WAKE
$88:8BAA AD 74 00    LDA $0074  [$7E:0074]  ;\
$88:8BAD 29 1F       AND #$1F               ;} If (red component of colour math subscreen backdrop colour) != 0:
$88:8BAF F0 06       BEQ $06    [$8BB7]     ;/
$88:8BB1 3A          DEC A                  ;\
$88:8BB2 09 20       ORA #$20               ;} Decrement (red component of colour math subscreen backdrop colour)
$88:8BB4 8D 74 00    STA $0074  [$7E:0074]  ;/

$88:8BB7 AD 75 00    LDA $0075  [$7E:0075]  ;\
$88:8BBA 29 1F       AND #$1F               ;} If (green component of colour math subscreen backdrop colour) != 0:
$88:8BBC F0 06       BEQ $06    [$8BC4]     ;/
$88:8BBE 3A          DEC A                  ;\
$88:8BBF 09 40       ORA #$40               ;} Decrement (green component of colour math subscreen backdrop colour)
$88:8BC1 8D 75 00    STA $0075  [$7E:0075]  ;/

$88:8BC4 AD 76 00    LDA $0076  [$7E:0076]  ;\
$88:8BC7 29 1F       AND #$1F               ;} If (blue component of colour math subscreen backdrop colour) != 0:
$88:8BC9 F0 06       BEQ $06    [$8BD1]     ;/
$88:8BCB 3A          DEC A                  ;\
$88:8BCC 09 80       ORA #$80               ;} Decrement (blue component of colour math subscreen backdrop colour)
$88:8BCE 8D 76 00    STA $0076  [$7E:0076]  ;/

$88:8BD1 AF 96 8B 88 LDA $888B96[$88:8B96]  ;\
$88:8BD5 9D 08 19    STA $1908,x[$7E:1908]  ;} HDMA object timer = 3
$88:8BD8 C2 20       REP #$20

$88:8BDA 6B          RTL                    ; Return

; BRANCH_WAKE
$88:8BDB C2 20       REP #$20
$88:8BDD A9 01 00    LDA #$0001             ;\
$88:8BE0 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1
$88:8BE3 FE CC 18    INC $18CC,x[$7E:18CC]  ;\
$88:8BE6 FE CC 18    INC $18CC,x[$7E:18CC]  ;} HDMA object instruction list pointer += 2
$88:8BE9 6B          RTL
}


;;; $8BEA: Calculate power bomb explosion HDMA data tables - pre-scaled - power bomb is left of screen ;;;
{
;; Parameters:
;;     X: 0. Power bomb explosion HDMA data table index
;;     Y: Pre-scaled power bomb explosion shape definition pointer

; Called by:
;     $8EB2: Pre-instruction - power bomb explosion - stage 4 - explosion - white
;     $91A8: Pre-instruction - power bomb explosion - stage 2 - pre-explosion - yellow

; LOOP
$88:8BEA AD E6 0C    LDA $0CE6  [$7E:0CE6]  ;\
$88:8BED 18          CLC                    ;|
$88:8BEE 79 00 00    ADC $0000,y[$88:9E46]  ;} If (X position of power bomb on screen) + [[Y]] < 0:
$88:8BF1 B0 0D       BCS $0D    [$8C00]     ;/
$88:8BF3 A9 00       LDA #$00               ;\
$88:8BF5 9F 06 C5 7E STA $7EC506,x[$7E:C5C5];} Power bomb explosion window 2 right HDMA data table entry = 0
$88:8BF9 1A          INC A                  ;\
$88:8BFA 9F 06 C4 7E STA $7EC406,x[$7E:C4C5];} Power bomb explosion window 2 left HDMA data table entry = 1
$88:8BFE 80 0A       BRA $0A    [$8C0A]
                                            ; Else ((X position of power bomb on screen) + [[Y]] >= 0):
$88:8C00 9F 06 C5 7E STA $7EC506,x[$7E:C506]; Power bomb explosion window 2 right HDMA data table entry = (X position of power bomb on screen) + [[Y]]
$88:8C04 A9 00       LDA #$00               ;\
$88:8C06 9F 06 C4 7E STA $7EC406,x[$7E:C406];} Power bomb explosion window 2 left HDMA data table entry = 0

$88:8C0A C8          INY                    ; Increment Y (next shape definition)
$88:8C0B E8          INX                    ; Increment X (next data table entry)
$88:8C0C E0 C0 00    CPX #$00C0             ;\
$88:8C0F D0 D9       BNE $D9    [$8BEA]     ;} If [X] != C0h: go to LOOP
$88:8C11 60          RTS
}


;;; $8C12: Calculate power bomb explosion HDMA data tables - pre-scaled - power bomb is on screen ;;;
{
;; Parameters:
;;     X: 0. Power bomb explosion HDMA data table index
;;     Y: Pre-scaled power bomb explosion shape definition pointer

; Called by:
;     $8EB2: Pre-instruction - power bomb explosion - stage 4 - explosion - white
;     $91A8: Pre-instruction - power bomb explosion - stage 2 - pre-explosion - yellow

; LOOP
$88:8C12 B9 00 00    LDA $0000,y[$88:9F06]  ;\
$88:8C15 F0 22       BEQ $22    [$8C39]     ;} If [[Y]] = 0: return
$88:8C17 18          CLC                    ;\
$88:8C18 6D E6 0C    ADC $0CE6  [$7E:0CE6]  ;|
$88:8C1B 90 02       BCC $02    [$8C1F]     ;|
$88:8C1D A9 FF       LDA #$FF               ;} Power bomb explosion window 2 right HDMA data table entry = min(FFh, (power bomb X position on screen) + [[Y]])
                                            ;|
$88:8C1F 9F 06 C5 7E STA $7EC506,x[$7E:C506];/
$88:8C23 AD E6 0C    LDA $0CE6  [$7E:0CE6]  ;\
$88:8C26 38          SEC                    ;|
$88:8C27 F9 00 00    SBC $0000,y[$88:9F06]  ;|
$88:8C2A B0 02       BCS $02    [$8C2E]     ;} Power bomb explosion window 2 left HDMA data table entry = max(0, (power bomb X position on screen) - [[Y]])
$88:8C2C A9 00       LDA #$00               ;|
                                            ;|
$88:8C2E 9F 06 C4 7E STA $7EC406,x[$7E:C406];/
$88:8C32 C8          INY                    ; Increment Y (next shape definition)
$88:8C33 E8          INX                    ; Increment X (next data table entry)
$88:8C34 E0 C0 00    CPX #$00C0             ;\
$88:8C37 D0 D9       BNE $D9    [$8C12]     ;} If [X] != C0h: go to LOOP

$88:8C39 60          RTS
}


;;; $8C3A: Calculate power bomb explosion HDMA data tables - pre-scaled - power bomb is right of screen ;;;
{
;; Parameters:
;;     X: 0. Power bomb explosion HDMA data table index
;;     Y: Pre-scaled power bomb explosion shape definition pointer

; Called by:
;     $8EB2: Pre-instruction - power bomb explosion - stage 4 - explosion - white
;     $91A8: Pre-instruction - power bomb explosion - stage 2 - pre-explosion - yellow

; LOOP
$88:8C3A AD E6 0C    LDA $0CE6  [$7E:0CE6]  ;\
$88:8C3D 38          SEC                    ;|
$88:8C3E F9 00 00    SBC $0000,y[$88:9D86]  ;} If (X position of power bomb on screen) - [[Y]] >= 100h:
$88:8C41 90 0D       BCC $0D    [$8C50]     ;/
$88:8C43 A9 FF       LDA #$FF               ;\
$88:8C45 9F 06 C4 7E STA $7EC406,x[$7E:C4C3];} Power bomb explosion window 2 left HDMA data table entry + [X] = FFh
$88:8C49 3A          DEC A                  ;\
$88:8C4A 9F 06 C5 7E STA $7EC506,x[$7E:C5C3];} Power bomb explosion window 2 right HDMA data table entry = FEh
$88:8C4E 80 0A       BRA $0A    [$8C5A]
                                            ; Else ((X position of power bomb on screen) - [[Y]] < 100h):
$88:8C50 9F 06 C4 7E STA $7EC406,x[$7E:C406]; Power bomb explosion window 2 left HDMA data table entry = (X position of power bomb on screen) - [[Y]]
$88:8C54 A9 FF       LDA #$FF               ;\
$88:8C56 9F 06 C5 7E STA $7EC506,x[$7E:C506];} Power bomb explosion window 2 right HDMA data table entry = FFh

$88:8C5A C8          INY                    ; Increment Y (next shape definition)
$88:8C5B E8          INX                    ; Increment X (next data table entry)
$88:8C5C E0 C0 00    CPX #$00C0             ;\
$88:8C5F D0 D9       BNE $D9    [$8C3A]     ;} If [X] != C0h: go to LOOP
$88:8C61 60          RTS
}


;;; $8C62: Calculate power bomb explosion HDMA object table pointers ;;;
{
; Called by:
;     $8DE9: Pre-instruction - power bomb explosion - stage 3 - explosion - yellow
;     $8EB2: Pre-instruction - power bomb explosion - stage 4 - explosion - white

; For on-screen power bomb explosions,
; the calculation 2FFh - [A] at $8C90 is equivalent to 1FFh + (Y position of screen on power bomb)
; (1FFh is enough space for a full screen of no-explosion, followed by a screen containing the upper half of the explosion,
; 2FFh is the table size)

$88:8C62 AD 92 05    LDA $0592  [$7E:0592]  ;\
$88:8C65 30 01       BMI $01    [$8C68]     ;} If power bomb is not exploding:
$88:8C67 6B          RTL                    ; Return

$88:8C68 AD E2 0C    LDA $0CE2  [$7E:0CE2]  ;\
$88:8C6B 38          SEC                    ;|
$88:8C6C ED 11 09    SBC $0911  [$7E:0911]  ;|
$88:8C6F 18          CLC                    ;|
$88:8C70 69 00 01    ADC #$0100             ;} If not -100h <= [power bomb explosion X position] - [layer 1 X position] < 200h: go to BRANCH_OFFSCREEN
$88:8C73 C9 00 03    CMP #$0300             ;|
$88:8C76 90 02       BCC $02    [$8C7A]     ;|
$88:8C78 80 13       BRA $13    [$8C8D]     ;/

$88:8C7A 8D E6 0C    STA $0CE6  [$7E:0CE6]  ; $0CE6 = 100h + [power bomb explosion X position] - [layer 1 X position]
$88:8C7D AD E4 0C    LDA $0CE4  [$7E:0CE4]  ;\
$88:8C80 38          SEC                    ;|
$88:8C81 ED 15 09    SBC $0915  [$7E:0915]  ;} A = 100h + [power bomb explosion Y position] - [layer 1 Y position]
$88:8C84 18          CLC                    ;|
$88:8C85 69 00 01    ADC #$0100             ;/
$88:8C88 C9 00 03    CMP #$0300             ;\
$88:8C8B 90 03       BCC $03    [$8C90]     ;} If -100h <= [power bomb explosion Y position] - [layer 1 Y position] < 200h: go to BRANCH_ON_SCREEN

; BRANCH_OFF_SCREEN
$88:8C8D A9 00 00    LDA #$0000             ; A = 0

; BRANCH_ON_SCREEN
$88:8C90 49 FF 03    EOR #$03FF             ;\
$88:8C93 38          SEC                    ;|
$88:8C94 E9 00 01    SBC #$0100             ;} Power bomb explosion HDMA table index = 2FFh - [A]
$88:8C97 8D E8 0C    STA $0CE8  [$7E:0CE8]  ;/
$88:8C9A AD EA 0C    LDA $0CEA  [$7E:0CEA]  ;\
$88:8C9D 29 00 FF    AND #$FF00             ;} If [power bomb explosion radius] / 100h < 1:
$88:8CA0 D0 03       BNE $03    [$8CA5]     ;/
$88:8CA2 9C E8 0C    STZ $0CE8  [$7E:0CE8]  ; Power bomb explosion HDMA table index = 0

$88:8CA5 BD C0 18    LDA $18C0,x[$7E:18C0]  ;\
$88:8CA8 29 FF 00    AND #$00FF             ;} >_<;
$88:8CAB A8          TAY                    ;/
$88:8CAC AD E8 0C    LDA $0CE8  [$7E:0CE8]  ;\
$88:8CAF 0A          ASL A                  ;|
$88:8CB0 18          CLC                    ;|
$88:8CB1 6D E8 0C    ADC $0CE8  [$7E:0CE8]  ;} Power bomb explosion window 2 left HDMA object table pointer = $9800 + [power bomb explosion HDMA table index] * 3
$88:8CB4 85 16       STA $16    [$7E:0016]  ;|
$88:8CB6 69 00 98    ADC #$9800             ;|
$88:8CB9 9D D8 18    STA $18D8,x[$7E:18D8]  ;/
$88:8CBC A5 16       LDA $16    [$7E:0016]  ;\
$88:8CBE 18          CLC                    ;|
$88:8CBF 69 01 A1    ADC #$A101             ;} Power bomb explosion window 2 right HDMA object table pointer = $A101 + [power bomb explosion HDMA table index] * 3
$88:8CC2 9D DA 18    STA $18DA,x[$7E:18DA]  ;/
$88:8CC5 6B          RTL
}


;;; $8CC6: Calculate power bomb explosion HDMA data tables - scaled - power bomb is left of screen ;;;
{
;; Parameters:
;;     X: Power bomb (pre-)explosion Y radius in pixels / power bomb explosion HDMA data table end index
;;     Y: 60h. Unscaled power bomb explosion shape definition table index + 60h
;;     $4202: Power bomb (pre-)explosion X radius in pixels
;; Returns:
;;     X: Power bomb explosion HDMA data table index of last padding entry

; Called by:
;     $8DE9: Pre-instruction - power bomb explosion - stage 3 - explosion - yellow
;     $90DF: Pre-instruction - power bomb explosion - stage 1 - pre-explosion - white

; LOOP_SHAPE_DEFINITION_TABLE
$88:8CC6 B9 26 A2    LDA $A226,y            ;\
$88:8CC9 8D 03 42    STA $4203              ;|
$88:8CCC EA          NOP                    ;|
$88:8CCD EA          NOP                    ;} $14 = [$4202] * [$A286 + [Y] - 60h] / 100h (shape top offset, shape definition top offset scaled by explosion X radius)
$88:8CCE EA          NOP                    ;|
$88:8CCF AD 17 42    LDA $4217              ;|
$88:8CD2 85 14       STA $14    [$7E:0014]  ;/
$88:8CD4 B9 06 A2    LDA $A206,y            ;\
$88:8CD7 8D 03 42    STA $4203              ;} Calculate [$4202] * [$A266 + [Y] - 60h] / 100h (shape width, shape definition width scaled by explosion X radius)
$88:8CDA EA          NOP                    ;/
$88:8CDB AD E6 0C    LDA $0CE6  [$7E:0CE6]  ;\
$88:8CDE 18          CLC                    ;|
$88:8CDF 6D 17 42    ADC $4217              ;} If (X position of power bomb on screen) + (shape width) < 0:
$88:8CE2 B0 07       BCS $07    [$8CEB]     ;/
$88:8CE4 A9 00       LDA #$00               ;\
$88:8CE6 EB          XBA                    ;} A high = 0
$88:8CE7 A9 FF       LDA #$FF               ; A low = FFh
$88:8CE9 80 03       BRA $03    [$8CEE]
                                            ; Else ((X position of power bomb on screen) + (shape width) >= 0):
$88:8CEB EB          XBA                    ; A high = (X position of power bomb on screen) + (shape width)
$88:8CEC A9 00       LDA #$00               ; A low = 0

; LOOP_DATA_TABLE
$88:8CEE 9F 06 C4 7E STA $7EC406,x          ; Power bomb explosion window 2 left HDMA data table entry = [A low]
$88:8CF2 EB          XBA                    ;\
$88:8CF3 9F 06 C5 7E STA $7EC506,x          ;} Power bomb explosion window 2 right HDMA data table entry = [A high]
$88:8CF7 EB          XBA                    ;/
$88:8CF8 E4 14       CPX $14    [$7E:0014]  ;\
$88:8CFA F0 04       BEQ $04    [$8D00]     ;} If [X] != (shape top offset):
$88:8CFC CA          DEX                    ; Decrement X (previous data table entry)
$88:8CFD 4C EE 8C    JMP $8CEE  [$88:8CEE]  ; Go to LOOP_DATA_TABLE

$88:8D00 C8          INY                    ; Increment Y (next shape definition)
$88:8D01 10 C3       BPL $C3    [$8CC6]     ; If [Y] < 80h: go to LOOP_SHAPE_DEFINITION_TABLE
$88:8D03 60          RTS
}


;;; $8D04: Calculate power bomb explosion HDMA data tables - scaled - power bomb is on screen ;;;
{
;; Parameters:
;;     X: Power bomb (pre-)explosion Y radius in pixels / power bomb explosion HDMA data table end index
;;     Y: 60h. Unscaled power bomb explosion shape definition table index + 60h
;;     $4202: Power bomb (pre-)explosion X radius in pixels
;; Returns:
;;     X: Power bomb explosion HDMA data table index of last padding entry

; Called by:
;     $8DE9: Pre-instruction - power bomb explosion - stage 3 - explosion - yellow
;     $90DF: Pre-instruction - power bomb explosion - stage 1 - pre-explosion - white

; LOOP_SHAPE_DEFINITION_TABLE
$88:8D04 B9 26 A2    LDA $A226,y[$88:A286]  ;\
$88:8D07 8D 03 42    STA $4203              ;|
$88:8D0A EA          NOP                    ;|
$88:8D0B EA          NOP                    ;} $14 = [$4202] * [$A286 + [Y] - 60h] / 100h (shape top offset, shape definition top offset scaled by explosion X radius)
$88:8D0C EA          NOP                    ;|
$88:8D0D AD 17 42    LDA $4217              ;|
$88:8D10 85 14       STA $14    [$7E:0014]  ;/
$88:8D12 B9 06 A2    LDA $A206,y[$88:A266]  ;\
$88:8D15 8D 03 42    STA $4203              ;} Calculate [$4202] * [$A266 + [Y] - 60h] / 100h (shape width, shape definition width scaled by explosion X radius)
$88:8D18 EA          NOP                    ;/
$88:8D19 AD E6 0C    LDA $0CE6  [$7E:0CE6]  ;\
$88:8D1C 18          CLC                    ;|
$88:8D1D 6D 17 42    ADC $4217              ;|
$88:8D20 90 02       BCC $02    [$8D24]     ;} A high = min(FFh, (power bomb X position on screen) + (shape width))
$88:8D22 A9 FF       LDA #$FF               ;|
                                            ;|
$88:8D24 EB          XBA                    ;/
$88:8D25 AD E6 0C    LDA $0CE6  [$7E:0CE6]  ;\
$88:8D28 38          SEC                    ;|
$88:8D29 ED 17 42    SBC $4217              ;} A low = max(0, (power bomb X position on screen) - (shape width))
$88:8D2C B0 02       BCS $02    [$8D30]     ;|
$88:8D2E A9 00       LDA #$00               ;/

; LOOP_DATA_TABLE
$88:8D30 9F 06 C4 7E STA $7EC406,x[$7E:C408]; Power bomb explosion window 2 left HDMA data table entry = [A low]
$88:8D34 EB          XBA                    ;\
$88:8D35 9F 06 C5 7E STA $7EC506,x[$7E:C508];} Power bomb explosion window 2 right HDMA data table entry = [A high]
$88:8D39 EB          XBA                    ;/
$88:8D3A E4 14       CPX $14    [$7E:0014]  ;\
$88:8D3C F0 04       BEQ $04    [$8D42]     ;} If [X] != [$14]:
$88:8D3E CA          DEX                    ; Decrement X
$88:8D3F 4C 30 8D    JMP $8D30  [$88:8D30]  ; Go to LOOP_DATA_TABLE

$88:8D42 C8          INY                    ; Increment Y
$88:8D43 10 BF       BPL $BF    [$8D04]     ; If [Y] < 80h: go to LOOP_SHAPE_DEFINITION_TABLE
$88:8D45 60          RTS
}


;;; $8D46: Calculate power bomb explosion HDMA data tables - scaled - power bomb is right of screen ;;;
{
;; Parameters:
;;     X: Power bomb (pre-)explosion Y radius in pixels / power bomb explosion HDMA data table index of last entry
;;     Y: 60h. Unscaled power bomb explosion shape definition table index + 60h
;;     $4202: Power bomb (pre-)explosion X radius in pixels
;; Returns:
;;     X: Power bomb explosion HDMA data table index of last padding entry

; Called by:
;     $8DE9: Pre-instruction - power bomb explosion - stage 3 - explosion - yellow
;     $90DF: Pre-instruction - power bomb explosion - stage 1 - pre-explosion - white

; LOOP_SHAPE_DEFINITION_TABLE
$88:8D46 B9 26 A2    LDA $A226,y[$88:A286]  ;\
$88:8D49 8D 03 42    STA $4203              ;|
$88:8D4C EA          NOP                    ;|
$88:8D4D EA          NOP                    ;} $14 = [$4202] * [$A286 + [Y] - 60h] / 100h (shape top offset, shape definition top offset scaled by explosion X radius)
$88:8D4E EA          NOP                    ;|
$88:8D4F AD 17 42    LDA $4217              ;|
$88:8D52 85 14       STA $14    [$7E:0014]  ;/
$88:8D54 B9 06 A2    LDA $A206,y[$88:A266]  ;\
$88:8D57 8D 03 42    STA $4203              ;} Calculate [$4202] * [$A266 + [Y] - 60h] / 100h (shape width, shape definition width scaled by explosion X radius)
$88:8D5A EA          NOP                    ;/
$88:8D5B AD E6 0C    LDA $0CE6  [$7E:0CE6]  ;\
$88:8D5E 38          SEC                    ;|
$88:8D5F ED 17 42    SBC $4217              ;} If (X position of power bomb on screen) - (shape width) >= 100h:
$88:8D62 90 07       BCC $07    [$8D6B]     ;/
$88:8D64 A9 FF       LDA #$FF               ;\
$88:8D66 EB          XBA                    ;} A low = FFh
$88:8D67 A9 00       LDA #$00               ; A high = 0
$88:8D69 80 03       BRA $03    [$8D6E]
                                            ; Else ((X position of power bomb on screen) - (shape width) < 100h):
$88:8D6B EB          XBA                    ; A low = (X position of power bomb on screen) - (shape width)
$88:8D6C A9 FF       LDA #$FF               ; A high = FFh

$88:8D6E EB          XBA

; LOOP_DATA_TABLE
$88:8D6F 9F 06 C4 7E STA $7EC406,x[$7E:C409]; Power bomb explosion window 2 left HDMA data table entry = [A low]
$88:8D73 EB          XBA                    ;\
$88:8D74 9F 06 C5 7E STA $7EC506,x[$7E:C509];} Power bomb explosion window 2 right HDMA data table entry = [A high]
$88:8D78 EB          XBA                    ;/
$88:8D79 E4 14       CPX $14    [$7E:0014]  ;\
$88:8D7B F0 04       BEQ $04    [$8D81]     ;} If [X] != (shape top offset):
$88:8D7D CA          DEX                    ; Decrement X (previous data table entry)
$88:8D7E 4C 6F 8D    JMP $8D6F  [$88:8D6F]  ; Go to LOOP_DATA_TABLE

$88:8D81 C8          INY                    ; Increment Y (next shape definition)
$88:8D82 10 C2       BPL $C2    [$8D46]     ; If [Y] >= 0: go to LOOP_SHAPE_DEFINITION_TABLE
$88:8D84 60          RTS
}


;;; $8D85: Power bomb explosion colours ;;;
{
; Indexed by [power bomb explosion radius] / 800h
; Red, green, blue. Range 0..1Fh

; Yellow section
$88:8D85             db 0E,0E,0A,
                        0F,0F,09,
                        10,10,08,
                        11,11,07,
                        12,12,06,
                        13,13,05,
                        14,14,04,
                        15,15,03,
                        16,16,02,
                        17,17,01,
                        18,18,00,
                        19,19,00,
                        1A,1A,00,
                        1A,1A,00,

; White section
                        1A,1A,1A,
                        1A,1A,1A,
                        1B,1B,1B,
                        1B,1B,1B,
                        1C,1C,1C,
                        1B,1B,1B,
                        1A,1A,1A,
                        1A,18,18,
                        1A,17,17,
                        19,16,16,
                        18,15,15,
                        17,15,15,
                        16,14,14,
                        15,13,13,
                        12,10,10,
                        12,0E,0E,
                        12,0D,0D,
                        12,0D,0D
}


;;; $8DE5: Power bomb explosion initial radius speed ;;;
{
$88:8DE5             dw 0000
}


;;; $8DE7: Power bomb explosion radius acceleration ;;;
{
$88:8DE7             dw 0030
}


;;; $8DE9: Pre-instruction - power bomb explosion - stage 3 - explosion - yellow ;;;
{
$88:8DE9 AD 92 05    LDA $0592  [$7E:0592]  ;\
$88:8DEC 30 01       BMI $01    [$8DEF]     ;} If power bomb is not exploding:
$88:8DEE 6B          RTL                    ; Return

$88:8DEF 08          PHP
$88:8DF0 8B          PHB
$88:8DF1 C2 30       REP #$30
$88:8DF3 DA          PHX
$88:8DF4 5A          PHY
$88:8DF5 22 62 8C 88 JSL $888C62[$88:8C62]  ; Calculate power bomb explosion HDMA object table pointers
$88:8DF9 F4 00 88    PEA $8800              ;\
$88:8DFC AB          PLB                    ;} DB = $88
$88:8DFD AB          PLB                    ;/
$88:8DFE E2 30       SEP #$30
$88:8E00 A9 00       LDA #$00               ;\
$88:8E02 EB          XBA                    ;} Clear A high
$88:8E03 A0 60       LDY #$60               ; Y = 60h
$88:8E05 AD EB 0C    LDA $0CEB  [$7E:0CEB]  ;\
$88:8E08 8D 02 42    STA $4202              ;|
$88:8E0B AD 86 A2    LDA $A286  [$88:A286]  ;|
$88:8E0E 8D 03 42    STA $4203              ;|
$88:8E11 EA          NOP                    ;} $12 = [power bomb explosion radius] * BFh / 10000h (power bomb explosion Y radius in pixels)
$88:8E12 EA          NOP                    ;|
$88:8E13 EA          NOP                    ;|
$88:8E14 AD 17 42    LDA $4217              ;|
$88:8E17 85 12       STA $12    [$7E:0012]  ;/
$88:8E19 AA          TAX                    ; X = (power bomb explosion Y radius in pixels)
$88:8E1A F4 2F 8E    PEA $8E2F              ; Push RETURN - 1
$88:8E1D AD E7 0C    LDA $0CE7  [$7E:0CE7]  ;\
$88:8E20 29 FF       AND #$FF               ;} If (X position of power bomb on screen) < 0: go to BRANCH_OFFSCREEN_LEFT
$88:8E22 F0 09       BEQ $09    [$8E2D]     ;/
$88:8E24 3A          DEC A                  ;\
$88:8E25 F0 03       BEQ $03    [$8E2A]     ;} If (X position of power bomb on screen) < 100h: go to BRANCH_ONSCREEN
$88:8E27 4C 46 8D    JMP $8D46  [$88:8D46]  ; Calculate power bomb explosion HDMA data tables - scaled - power bomb is right of screen

; BRANCH_ONSCREEN
$88:8E2A 4C 04 8D    JMP $8D04  [$88:8D04]  ; Calculate power bomb explosion HDMA data tables - scaled - power bomb is on screen

; BRANCH_OFFSCREEN_LEFT
$88:8E2D 4C C6 8C    JMP $8CC6  [$88:8CC6]  ; Calculate power bomb explosion HDMA data tables - scaled - power bomb is left of screen

; RETURN
; LOOP_PAD_DATA_TABLE_BEGIN
$88:8E30 9F 06 C4 7E STA $7EC406,x[$7E:C406]; Power bomb explosion window 2 left HDMA data table entry = [A low]
$88:8E34 EB          XBA                    ;\
$88:8E35 9F 06 C5 7E STA $7EC506,x[$7E:C506];} Power bomb explosion window 2 right HDMA data table entry = [A high]
$88:8E39 EB          XBA                    ;/
$88:8E3A CA          DEX                    ; Decrement X (previous data table entry)
$88:8E3B 10 F3       BPL $F3    [$8E30]     ; If [X] >= 0: go to LOOP_PAD_DATA_TABLE_BEGIN
$88:8E3D A6 12       LDX $12    [$7E:0012]  ;\
$88:8E3F E8          INX                    ;} X = (power bomb explosion Y radius in pixels) + 1
$88:8E40 E0 C0       CPX #$C0               ;\
$88:8E42 F0 11       BEQ $11    [$8E55]     ;} If [X] = C0h: go to BRANCH_FINISHED_TABLE
$88:8E44 A9 FF       LDA #$FF               ; A = FFh

; LOOP_PAD_DATA_TABLE_END
$88:8E46 9F 06 C4 7E STA $7EC406,x[$7E:C409]; Power bomb explosion window 2 left HDMA data table entry = FFh
$88:8E4A 1A          INC A                  ;\
$88:8E4B 9F 06 C5 7E STA $7EC506,x[$7E:C509];} Power bomb explosion window 2 right HDMA data table entry = 0
$88:8E4F 3A          DEC A                  ;/
$88:8E50 E8          INX                    ; Increment X (next data table entry)
$88:8E51 E0 C0       CPX #$C0               ;\
$88:8E53 D0 F1       BNE $F1    [$8E46]     ;} If [X] != C0h: go to LOOP_PAD_DATA_TABLE_END

; BRANCH_FINISHED_TABLE
$88:8E55 AD EB 0C    LDA $0CEB  [$7E:0CEB]  ;\
$88:8E58 4A          LSR A                  ;|
$88:8E59 4A          LSR A                  ;|
$88:8E5A 4A          LSR A                  ;|
$88:8E5B 29 1F       AND #$1F               ;|
$88:8E5D 85 12       STA $12    [$7E:0012]  ;} X = [power bomb explosion radius] / 800h * 3
$88:8E5F 0A          ASL A                  ;|
$88:8E60 18          CLC                    ;|
$88:8E61 65 12       ADC $12    [$7E:0012]  ;|
$88:8E63 AA          TAX                    ;/
$88:8E64 BF 85 8D 88 LDA $888D85,x[$88:8D85];\
$88:8E68 09 20       ORA #$20               ;|
$88:8E6A 8D 74 00    STA $0074  [$7E:0074]  ;|
$88:8E6D BF 86 8D 88 LDA $888D86,x[$88:8D86];|
$88:8E71 09 40       ORA #$40               ;} Colour math subscreen backdrop colour = ([$8D85 + [X]], [$8D85 + [X] + 1], [$8D85 + [X] + 2])
$88:8E73 8D 75 00    STA $0075  [$7E:0075]  ;|
$88:8E76 BF 87 8D 88 LDA $888D87,x[$88:8D87];|
$88:8E7A 09 80       ORA #$80               ;|
$88:8E7C 8D 76 00    STA $0076  [$7E:0076]  ;/
$88:8E7F C2 30       REP #$30
$88:8E81 7A          PLY
$88:8E82 FA          PLX
$88:8E83 AD EA 0C    LDA $0CEA  [$7E:0CEA]  ;\
$88:8E86 18          CLC                    ;|
$88:8E87 6D F0 0C    ADC $0CF0  [$7E:0CF0]  ;} Power bomb explosion radius += [power bomb explosion radius speed]
$88:8E8A 8D EA 0C    STA $0CEA  [$7E:0CEA]  ;/
$88:8E8D C9 00 86    CMP #$8600             ;\
$88:8E90 90 12       BCC $12    [$8EA4]     ;} If [power bomb explosion radius] >= 8600h:
$88:8E92 A9 01 00    LDA #$0001             ;\
$88:8E95 9D E4 18    STA $18E4,x[$7E:18E4]  ;|
$88:8E98 FE CC 18    INC $18CC,x[$7E:18CC]  ;} Wake HDMA object
$88:8E9B FE CC 18    INC $18CC,x[$7E:18CC]  ;|
$88:8E9E 9E 08 19    STZ $1908,x[$7E:1908]  ;/
$88:8EA1 4C AF 8E    JMP $8EAF  [$88:8EAF]  ; Return

$88:8EA4 AD F0 0C    LDA $0CF0  [$7E:0CF0]  ;\
$88:8EA7 18          CLC                    ;|
$88:8EA8 6F E7 8D 88 ADC $888DE7[$88:8DE7]  ;} Power bomb explosion radius speed += 30h
$88:8EAC 8D F0 0C    STA $0CF0  [$7E:0CF0]  ;/

$88:8EAF AB          PLB
$88:8EB0 28          PLP
$88:8EB1 6B          RTL
}


;;; $8EB2: Pre-instruction - power bomb explosion - stage 4 - explosion - white ;;;
{
$88:8EB2 AD 92 05    LDA $0592  [$7E:0592]  ;\
$88:8EB5 30 01       BMI $01    [$8EB8]     ;} If power bomb is not exploding:
$88:8EB7 6B          RTL                    ; Return

$88:8EB8 08          PHP
$88:8EB9 8B          PHB
$88:8EBA C2 30       REP #$30
$88:8EBC DA          PHX
$88:8EBD 5A          PHY
$88:8EBE 22 62 8C 88 JSL $888C62[$88:8C62]  ; Calculate power bomb explosion HDMA object table pointers
$88:8EC2 F4 00 88    PEA $8800              ;\
$88:8EC5 AB          PLB                    ;} DB = $88
$88:8EC6 AB          PLB                    ;/
$88:8EC7 AC F2 0C    LDY $0CF2  [$7E:0CF2]  ; Y = [pre-scaled power bomb explosion shape definition pointer]
$88:8ECA A2 00 00    LDX #$0000             ; X = 0 (power bomb explosion HDMA data table index)
$88:8ECD E2 20       SEP #$20
$88:8ECF F4 E4 8E    PEA $8EE4              ; Push RETURN - 1
$88:8ED2 AD E7 0C    LDA $0CE7  [$7E:0CE7]  ;\
$88:8ED5 29 FF       AND #$FF               ;} If (X position of power bomb on screen) < 0: go to BRANCH_OFFSCREEN_LEFT
$88:8ED7 F0 09       BEQ $09    [$8EE2]     ;/
$88:8ED9 3A          DEC A                  ;\
$88:8EDA F0 03       BEQ $03    [$8EDF]     ;} If (X position of power bomb on screen) < 100h: go to BRANCH_ONSCREEN
$88:8EDC 4C 3A 8C    JMP $8C3A  [$88:8C3A]  ; Calculate power bomb explosion HDMA data tables - pre-scaled - power bomb is right of screen

; BRANCH_ONSCREEN
$88:8EDF 4C 12 8C    JMP $8C12  [$88:8C12]  ; Calculate power bomb explosion HDMA data tables - pre-scaled - power bomb is on screen

; BRANCH_OFFSCREEN_LEFT
$88:8EE2 4C EA 8B    JMP $8BEA  [$88:8BEA]  ; Calculate power bomb explosion HDMA data tables - pre-scaled - power bomb is left of screen

; RETURN
$88:8EE5 E2 30       SEP #$30
$88:8EE7 A9 00       LDA #$00               ;\
$88:8EE9 EB          XBA                    ;} Clear A high
$88:8EEA AD EB 0C    LDA $0CEB  [$7E:0CEB]  ;\
$88:8EED 4A          LSR A                  ;|
$88:8EEE 4A          LSR A                  ;|
$88:8EEF 4A          LSR A                  ;|
$88:8EF0 29 1F       AND #$1F               ;|
$88:8EF2 85 12       STA $12    [$7E:0012]  ;} X = [power bomb explosion radius] / 800h * 3
$88:8EF4 0A          ASL A                  ;|
$88:8EF5 18          CLC                    ;|
$88:8EF6 65 12       ADC $12    [$7E:0012]  ;|
$88:8EF8 AA          TAX                    ;/
$88:8EF9 BF 85 8D 88 LDA $888D85,x[$88:8DB5];\
$88:8EFD 09 20       ORA #$20               ;|
$88:8EFF 8D 74 00    STA $0074  [$7E:0074]  ;|
$88:8F02 BF 86 8D 88 LDA $888D86,x[$88:8DB6];|
$88:8F06 09 40       ORA #$40               ;} Colour math subscreen backdrop colour = ([$8D85 + [X]], [$8D85 + [X] + 1], [$8D85 + [X] + 2])
$88:8F08 8D 75 00    STA $0075  [$7E:0075]  ;|
$88:8F0B BF 87 8D 88 LDA $888D87,x[$88:8DB7];|
$88:8F0F 09 80       ORA #$80               ;|
$88:8F11 8D 76 00    STA $0076  [$7E:0076]  ;/
$88:8F14 C2 30       REP #$30
$88:8F16 7A          PLY
$88:8F17 FA          PLX
$88:8F18 AD F2 0C    LDA $0CF2  [$7E:0CF2]  ;\
$88:8F1B 18          CLC                    ;|
$88:8F1C 69 C0 00    ADC #$00C0             ;} Pre-scaled power bomb explosion shape definition pointer += C0h
$88:8F1F 8D F2 0C    STA $0CF2  [$7E:0CF2]  ;/
$88:8F22 C9 06 9F    CMP #$9F06             ;\
$88:8F25 D0 15       BNE $15    [$8F3C]     ;} If [pre-scaled power bomb explosion shape definition pointer] = $9F06:
$88:8F27 A9 01 00    LDA #$0001             ;\
$88:8F2A 9D E4 18    STA $18E4,x[$7E:18E4]  ;|
$88:8F2D FE CC 18    INC $18CC,x[$7E:18CC]  ;} Wake HDMA object
$88:8F30 FE CC 18    INC $18CC,x[$7E:18CC]  ;|
$88:8F33 9E 08 19    STZ $1908,x[$7E:1908]  ;/
$88:8F36 A9 20 00    LDA #$0020             ;\
$88:8F39 9D 38 19    STA $1938,x[$7E:1938]  ;} HDMA object after-glow animation frame = 20h

$88:8F3C AD EA 0C    LDA $0CEA  [$7E:0CEA]  ;\
$88:8F3F 18          CLC                    ;|
$88:8F40 6D F0 0C    ADC $0CF0  [$7E:0CF0]  ;} If [power bomb explosion radius] + [power bomb explosion radius speed] < 10000h:
$88:8F43 B0 0E       BCS $0E    [$8F53]     ;/
$88:8F45 8D EA 0C    STA $0CEA  [$7E:0CEA]  ; Power bomb explosion radius += [power bomb explosion radius speed]
$88:8F48 AD F0 0C    LDA $0CF0  [$7E:0CF0]  ;\
$88:8F4B 18          CLC                    ;|
$88:8F4C 6F E7 8D 88 ADC $888DE7[$88:8DE7]  ;} Power bomb explosion radius speed += 30h
$88:8F50 8D F0 0C    STA $0CF0  [$7E:0CF0]  ;/

$88:8F53 AB          PLB
$88:8F54 28          PLP
$88:8F55 6B          RTL
}


;;; $8F56: Calculate power bomb pre-explosion HDMA object table pointers ;;;
{
; Called by:
;     $90DF: Pre-instruction - power bomb explosion - stage 1 - pre-explosion - white
;     $91A8: Pre-instruction - power bomb explosion - stage 2 - pre-explosion - yellow

; For on-screen power bomb explosions,
; the calculation 2FFh - [A] at $8C90 is equivalent to 1FFh + (Y position of screen on power bomb)
; (1FFh is enough space for a full screen of no-explosion, followed by a screen containing the upper half of the explosion,
; 2FFh is the table size)

$88:8F56 AD 92 05    LDA $0592  [$7E:0592]  ;\
$88:8F59 30 01       BMI $01    [$8F5C]     ;} If power bomb is not exploding:
$88:8F5B 6B          RTL                    ; Return

$88:8F5C AD E2 0C    LDA $0CE2  [$7E:0CE2]  ;\
$88:8F5F 38          SEC                    ;|
$88:8F60 ED 11 09    SBC $0911  [$7E:0911]  ;|
$88:8F63 18          CLC                    ;|
$88:8F64 69 00 01    ADC #$0100             ;} If not -100h <= [power bomb explosion X position] - [layer 1 X position] < 200h: go to BRANCH_OFFSCREEN
$88:8F67 C9 00 03    CMP #$0300             ;|
$88:8F6A 90 02       BCC $02    [$8F6E]     ;|
$88:8F6C 80 13       BRA $13    [$8F81]     ;/

$88:8F6E 8D E6 0C    STA $0CE6  [$7E:0CE6]  ; $0CE6 = 100h + [power bomb explosion X position] - [layer 1 X position]
$88:8F71 AD E4 0C    LDA $0CE4  [$7E:0CE4]  ;\
$88:8F74 38          SEC                    ;|
$88:8F75 ED 15 09    SBC $0915  [$7E:0915]  ;} A = 100h + [power bomb explosion Y position] - [layer 1 Y position]
$88:8F78 18          CLC                    ;|
$88:8F79 69 00 01    ADC #$0100             ;/
$88:8F7C C9 00 03    CMP #$0300             ;\
$88:8F7F 90 03       BCC $03    [$8F84]     ;} If -100h <= [power bomb explosion Y position] - [layer 1 Y position] < 200h: go to BRANCH_ON_SCREEN

; BRANCH_OFFSCREEN
$88:8F81 A9 00 00    LDA #$0000             ; A = 0

; BRANCH_ON_SCREEN
$88:8F84 49 FF 03    EOR #$03FF             ;\
$88:8F87 38          SEC                    ;|
$88:8F88 E9 00 01    SBC #$0100             ;} Power bomb explosion HDMA table index = 2FFh - [A]
$88:8F8B 8D E8 0C    STA $0CE8  [$7E:0CE8]  ;/
$88:8F8E AD EC 0C    LDA $0CEC  [$7E:0CEC]  ;\
$88:8F91 29 00 FF    AND #$FF00             ;} If [power bomb explosion radius] / 100h < 1:
$88:8F94 D0 03       BNE $03    [$8F99]     ;/
$88:8F96 9C E8 0C    STZ $0CE8  [$7E:0CE8]  ; Power bomb explosion HDMA table index = 0

$88:8F99 BD C0 18    LDA $18C0,x[$7E:18C0]  ;\
$88:8F9C 29 FF 00    AND #$00FF             ;} >_<;
$88:8F9F A8          TAY                    ;/
$88:8FA0 AD E8 0C    LDA $0CE8  [$7E:0CE8]  ;\
$88:8FA3 0A          ASL A                  ;|
$88:8FA4 18          CLC                    ;|
$88:8FA5 6D E8 0C    ADC $0CE8  [$7E:0CE8]  ;} Power bomb explosion window 2 left HDMA object table pointer = $9800 + [power bomb explosion HDMA table index] * 3
$88:8FA8 85 16       STA $16    [$7E:0016]  ;|
$88:8FAA 69 00 98    ADC #$9800             ;|
$88:8FAD 9D D8 18    STA $18D8,x[$7E:18D8]  ;/
$88:8FB0 A5 16       LDA $16    [$7E:0016]  ;\
$88:8FB2 18          CLC                    ;|
$88:8FB3 69 01 A1    ADC #$A101             ;} Power bomb explosion window 2 right HDMA object table pointer = $A101 + [power bomb explosion HDMA table index] * 3
$88:8FB6 9D DA 18    STA $18DA,x[$7E:18DA]  ;/
$88:8FB9 6B          RTL
}


;;; $8FBA: Unused. Calculate power bomb related HDMA data tables - scaled - power bomb is left of screen ;;;
{
; Clone of $8CC6

$88:8FBA B9 26 A2    LDA $A226,y
$88:8FBD 8D 03 42    STA $4203            
$88:8FC0 EA          NOP
$88:8FC1 EA          NOP
$88:8FC2 EA          NOP
$88:8FC3 AD 17 42    LDA $4217            
$88:8FC6 85 14       STA $14    [$7E:0014]
$88:8FC8 B9 06 A2    LDA $A206,y
$88:8FCB 8D 03 42    STA $4203            
$88:8FCE EA          NOP
$88:8FCF AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:8FD2 18          CLC
$88:8FD3 6D 17 42    ADC $4217            
$88:8FD6 B0 07       BCS $07    [$8FDF]
$88:8FD8 A9 00       LDA #$00
$88:8FDA EB          XBA
$88:8FDB A9 FF       LDA #$FF
$88:8FDD 80 03       BRA $03    [$8FE2]

$88:8FDF EB          XBA
$88:8FE0 A9 00       LDA #$00

$88:8FE2 9F 06 C4 7E STA $7EC406,x
$88:8FE6 EB          XBA
$88:8FE7 9F 06 C5 7E STA $7EC506,x
$88:8FEB EB          XBA
$88:8FEC E4 14       CPX $14    [$7E:0014]
$88:8FEE F0 04       BEQ $04    [$8FF4]
$88:8FF0 CA          DEX
$88:8FF1 4C E2 8F    JMP $8FE2  [$88:8FE2]

$88:8FF4 C8          INY
$88:8FF5 10 C3       BPL $C3    [$8FBA]
$88:8FF7 60          RTS
}


;;; $8FF8: Unused. Calculate power bomb related HDMA data tables - scaled - power bomb is on screen ;;;
{
; Clone of $8D04

$88:8FF8 B9 26 A2    LDA $A226,y
$88:8FFB 8D 03 42    STA $4203            
$88:8FFE EA          NOP
$88:8FFF EA          NOP
$88:9000 EA          NOP
$88:9001 AD 17 42    LDA $4217            
$88:9004 85 14       STA $14    [$7E:0014]
$88:9006 B9 06 A2    LDA $A206,y
$88:9009 8D 03 42    STA $4203            
$88:900C EA          NOP
$88:900D AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:9010 18          CLC
$88:9011 6D 17 42    ADC $4217            
$88:9014 90 02       BCC $02    [$9018]
$88:9016 A9 FF       LDA #$FF

$88:9018 EB          XBA
$88:9019 AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:901C 38          SEC
$88:901D ED 17 42    SBC $4217            
$88:9020 B0 02       BCS $02    [$9024]
$88:9022 A9 00       LDA #$00

$88:9024 9F 06 C4 7E STA $7EC406,x
$88:9028 EB          XBA
$88:9029 9F 06 C5 7E STA $7EC506,x
$88:902D EB          XBA
$88:902E E4 14       CPX $14    [$7E:0014]
$88:9030 F0 04       BEQ $04    [$9036]
$88:9032 CA          DEX
$88:9033 4C 24 90    JMP $9024  [$88:9024]

$88:9036 C8          INY
$88:9037 10 BF       BPL $BF    [$8FF8]
$88:9039 60          RTS
}


;;; $903A: Unused. Calculate power bomb related HDMA data tables - scaled - power bomb is right of screen ;;;
{
; Clone of $8D46

$88:903A B9 26 A2    LDA $A226,y
$88:903D 8D 03 42    STA $4203            
$88:9040 EA          NOP
$88:9041 EA          NOP
$88:9042 EA          NOP
$88:9043 AD 17 42    LDA $4217            
$88:9046 85 14       STA $14    [$7E:0014]
$88:9048 B9 06 A2    LDA $A206,y
$88:904B 8D 03 42    STA $4203            
$88:904E EA          NOP
$88:904F AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:9052 38          SEC
$88:9053 ED 17 42    SBC $4217            
$88:9056 90 07       BCC $07    [$905F]
$88:9058 A9 FF       LDA #$FF
$88:905A EB          XBA
$88:905B A9 00       LDA #$00
$88:905D 80 03       BRA $03    [$9062]

$88:905F EB          XBA
$88:9060 A9 FF       LDA #$FF

$88:9062 EB          XBA

$88:9063 9F 06 C4 7E STA $7EC406,x
$88:9067 EB          XBA
$88:9068 9F 06 C5 7E STA $7EC506,x
$88:906C EB          XBA
$88:906D E4 14       CPX $14    [$7E:0014]
$88:906F F0 04       BEQ $04    [$9075]
$88:9071 CA          DEX
$88:9072 4C 63 90    JMP $9063  [$88:9063]

$88:9075 C8          INY
$88:9076 10 C2       BPL $C2    [$903A]
$88:9078 60          RTS
}


;;; $9079: Power bomb pre-explosion colours ;;;
{
; Indexed by [power bomb pre-explosion radius] / 800h
; Red, green, blue. Range 0..1Fh

; White section
$88:9079             db 10,10,10,
                        04,04,04,
                        06,06,06,
                        08,08,08,
                        0A,0A,0A,
                        0C,0C,0C,
                        0E,0E,0A,

; Yellow section
                        10,10,08,
                        12,12,08,
                        14,14,08,
                        16,16,08,
                        18,18,08,
                        1A,1A,0A,
                        18,18,08,
                        16,16,06,
                        14,14,04
}


;;; $90A9: Unused. Power bomb explosion related colours ;;;
{
; These might have been used for the after-glow in earlier development
$88:90A9             db 13,13,0F,
                        11,11,0E,
                        0F,0F,0D,
                        0D,0D,0C,
                        0B,0B,0B,
                        0A,0A,0A,
                        09,09,09,
                        08,08,08,
                        07,07,07,
                        06,06,06,
                        05,05,05,
                        04,04,04,
                        03,03,03,
                        02,02,02,
                        01,01,01,
                        00,00,00
}


;;; $90D9: Unused ;;;
{
; There's no (non-pre) explosion parallel to this constant (as there is for initial speed and acceleration),
; so I can't even speculate what this might have been for
$88:90D9             dw 0001
}


;;; $90DB: Power bomb pre-explosion initial radius speed ;;;
{
$88:90DB             dw 3000
}


;;; $90DD: Power bomb pre-explosion radius acceleration ;;;
{
$88:90DD             dw 0080
}


;;; $90DF: Pre-instruction - power bomb explosion - stage 1 - pre-explosion - white ;;;
{
$88:90DF AD 92 05    LDA $0592  [$7E:0592]  ;\
$88:90E2 30 01       BMI $01    [$90E5]     ;} If power bomb is not exploding:
$88:90E4 6B          RTL                    ; Return

$88:90E5 08          PHP
$88:90E6 8B          PHB
$88:90E7 C2 30       REP #$30
$88:90E9 DA          PHX
$88:90EA 5A          PHY
$88:90EB 22 56 8F 88 JSL $888F56[$88:8F56]  ; Calculate power bomb pre-explosion HDMA object table pointers
$88:90EF F4 00 88    PEA $8800              ;\
$88:90F2 AB          PLB                    ;} DB = $88
$88:90F3 AB          PLB                    ;/
$88:90F4 E2 30       SEP #$30
$88:90F6 A9 00       LDA #$00               ;\
$88:90F8 EB          XBA                    ;} Clear A high
$88:90F9 A0 60       LDY #$60               ; Y = 60h
$88:90FB AD ED 0C    LDA $0CED  [$7E:0CED]  ;\
$88:90FE 8D 02 42    STA $4202              ;|
$88:9101 AD 86 A2    LDA $A286  [$88:A286]  ;|
$88:9104 8D 03 42    STA $4203              ;|
$88:9107 EA          NOP                    ;} $12 = [power bomb pre-explosion radius] * BFh / 10000h (power bomb pre-explosion Y radius in pixels)
$88:9108 EA          NOP                    ;|
$88:9109 EA          NOP                    ;|
$88:910A AD 17 42    LDA $4217              ;|
$88:910D 85 12       STA $12    [$7E:0012]  ;/
$88:910F AA          TAX                    ; X = power bomb pre-explosion Y radius in pixels
$88:9110 F4 25 91    PEA $9125              ; Push RETURN - 1
$88:9113 AD E7 0C    LDA $0CE7  [$7E:0CE7]  ;\
$88:9116 29 FF       AND #$FF               ;} If (X position of power bomb on screen) < 0: go to BRANCH_OFFSCREEN_LEFT
$88:9118 F0 09       BEQ $09    [$9123]     ;/
$88:911A 3A          DEC A                  ;\
$88:911B F0 03       BEQ $03    [$9120]     ;} If (X position of power bomb on screen) < 100h: go to BRANCH_ONSCREEN
$88:911D 4C 46 8D    JMP $8D46  [$88:8D46]  ; Calculate power bomb explosion HDMA data tables - scaled - power bomb is right of screen

; BRANCH_ONSCREEN
$88:9120 4C 04 8D    JMP $8D04  [$88:8D04]  ; Calculate power bomb explosion HDMA data tables - scaled - power bomb is on screen

; BRANCH_OFFSCREEN_LEFT
$88:9123 4C C6 8C    JMP $8CC6  [$88:8CC6]  ; Calculate power bomb explosion HDMA data tables - scaled - power bomb is left of screen

; RETURN
; LOOP_PAD_DATA_TABLE_BEGIN
$88:9126 9F 06 C4 7E STA $7EC406,x[$7E:C406]; Power bomb explosion window 2 left HDMA data table entry = [A low]
$88:912A EB          XBA                    ;\
$88:912B 9F 06 C5 7E STA $7EC506,x[$7E:C506];} Power bomb explosion window 2 right HDMA data table entry = [A high]
$88:912F EB          XBA                    ;/
$88:9130 CA          DEX                    ; Decrement X (previous data table entry)
$88:9131 10 F3       BPL $F3    [$9126]     ; If [X] >= 0: go to LOOP_PAD_DATA_TABLE_BEGIN
$88:9133 A6 12       LDX $12    [$7E:0012]  ;\
$88:9135 E8          INX                    ;} X = power bomb pre-explosion Y radius in pixels + 1
$88:9136 E0 C0       CPX #$C0               ;\
$88:9138 F0 11       BEQ $11    [$914B]     ;} If [X] = C0h: go to BRANCH_FINISHED_TABLE
$88:913A A9 FF       LDA #$FF               ; A = FFh

; LOOP_PAD_DATA_TABLE_END
$88:913C 9F 06 C4 7E STA $7EC406,x[$7E:C409]; Power bomb explosion window 2 left HDMA data table entry = FFh
$88:9140 1A          INC A                  ;\
$88:9141 9F 06 C5 7E STA $7EC506,x[$7E:C509];} Power bomb explosion window 2 right HDMA data table entry = 0
$88:9145 3A          DEC A                  ;/
$88:9146 E8          INX                    ; Increment X (next data table entry)
$88:9147 E0 C0       CPX #$C0               ;\
$88:9149 D0 F1       BNE $F1    [$913C]     ;} If [X] != C0h: go to LOOP_PAD_DATA_TABLE_END

; BRANCH_FINISHED_TABLE
$88:914B AD ED 0C    LDA $0CED  [$7E:0CED]  ;\
$88:914E 4A          LSR A                  ;|
$88:914F 4A          LSR A                  ;|
$88:9150 4A          LSR A                  ;|
$88:9151 29 0F       AND #$0F               ;|
$88:9153 85 12       STA $12    [$7E:0012]  ;} X = [power bomb pre-explosion radius] / 800h * 3
$88:9155 0A          ASL A                  ;|
$88:9156 18          CLC                    ;|
$88:9157 65 12       ADC $12    [$7E:0012]  ;|
$88:9159 AA          TAX                    ;/
$88:915A BF 79 90 88 LDA $889079,x[$88:9079];\
$88:915E 09 20       ORA #$20               ;|
$88:9160 8D 74 00    STA $0074  [$7E:0074]  ;|
$88:9163 BF 7A 90 88 LDA $88907A,x[$88:907A];|
$88:9167 09 40       ORA #$40               ;} Colour math subscreen backdrop colour = ([$9079 + [X]], [$9079 + [X] + 1], [$9079 + [X] + 2])
$88:9169 8D 75 00    STA $0075  [$7E:0075]  ;|
$88:916C BF 7B 90 88 LDA $88907B,x[$88:907B];|
$88:9170 09 80       ORA #$80               ;|
$88:9172 8D 76 00    STA $0076  [$7E:0076]  ;/
$88:9175 C2 30       REP #$30
$88:9177 7A          PLY
$88:9178 FA          PLX
$88:9179 AD EC 0C    LDA $0CEC  [$7E:0CEC]  ;\
$88:917C 18          CLC                    ;|
$88:917D 6D F0 0C    ADC $0CF0  [$7E:0CF0]  ;} Power bomb pre-explosion radius += [power bomb explosion radius speed]
$88:9180 8D EC 0C    STA $0CEC  [$7E:0CEC]  ;/
$88:9183 C9 00 92    CMP #$9200             ;\
$88:9186 90 12       BCC $12    [$919A]     ;} If [power bomb pre-explosion radius] >= 9200h:
$88:9188 A9 01 00    LDA #$0001             ;\
$88:918B 9D E4 18    STA $18E4,x[$7E:18E4]  ;|
$88:918E FE CC 18    INC $18CC,x[$7E:18CC]  ;} Wake HDMA object
$88:9191 FE CC 18    INC $18CC,x[$7E:18CC]  ;|
$88:9194 9E 08 19    STZ $1908,x[$7E:1908]  ;/
$88:9197 4C A5 91    JMP $91A5  [$88:91A5]  ; Return

$88:919A AD F0 0C    LDA $0CF0  [$7E:0CF0]  ;\
$88:919D 38          SEC                    ;|
$88:919E EF DD 90 88 SBC $8890DD[$88:90DD]  ;} Power bomb explosion radius speed += 80h
$88:91A2 8D F0 0C    STA $0CF0  [$7E:0CF0]  ;/

$88:91A5 AB          PLB
$88:91A6 28          PLP
$88:91A7 6B          RTL
}


;;; $91A8: Pre-instruction - power bomb explosion - stage 2 - pre-explosion - yellow ;;;
{
$88:91A8 AD 92 05    LDA $0592  [$7E:0592]  ;\
$88:91AB 30 01       BMI $01    [$91AE]     ;} If power bomb is not exploding:
$88:91AD 6B          RTL                    ; Return

$88:91AE 08          PHP
$88:91AF 8B          PHB
$88:91B0 C2 30       REP #$30
$88:91B2 DA          PHX
$88:91B3 5A          PHY
$88:91B4 22 56 8F 88 JSL $888F56[$88:8F56]  ; Calculate power bomb pre-explosion HDMA object table pointers
$88:91B8 F4 00 88    PEA $8800              ;\
$88:91BB AB          PLB                    ;} DB = $88
$88:91BC AB          PLB                    ;/
$88:91BD AC F2 0C    LDY $0CF2  [$7E:0CF2]  ; Y = [pre-scaled power bomb explosion shape definition pointer]
$88:91C0 A2 00 00    LDX #$0000             ; X = 0 (power bomb explosion HDMA data table index)
$88:91C3 E2 20       SEP #$20
$88:91C5 F4 DA 91    PEA $91DA              ; Push RETURN - 1
$88:91C8 AD E7 0C    LDA $0CE7  [$7E:0CE7]  ;\
$88:91CB 29 FF       AND #$FF               ;} If (X position of power bomb on screen) < 0: go to BRANCH_OFFSCREEN_LEFT
$88:91CD F0 09       BEQ $09    [$91D8]     ;/
$88:91CF 3A          DEC A                  ;\
$88:91D0 F0 03       BEQ $03    [$91D5]     ;} If (X position of power bomb on screen) < 100h: go to BRANCH_ONSCREEN
$88:91D2 4C 3A 8C    JMP $8C3A  [$88:8C3A]  ; Calculate power bomb explosion HDMA data tables - pre-scaled - power bomb is right of screen

; BRANCH_ONSCREEN
$88:91D5 4C 12 8C    JMP $8C12  [$88:8C12]  ; Calculate power bomb explosion HDMA data tables - pre-scaled - power bomb is on screen

; BRANCH_OFFSCREEN_LEFT
$88:91D8 4C EA 8B    JMP $8BEA  [$88:8BEA]  ; Calculate power bomb explosion HDMA data tables - pre-scaled - power bomb is left of screen

; RETURN
$88:91DB E2 30       SEP #$30
$88:91DD A9 00       LDA #$00               ;\
$88:91DF EB          XBA                    ;} Clear A high
$88:91E0 AD ED 0C    LDA $0CED  [$7E:0CED]  ;\
$88:91E3 4A          LSR A                  ;|
$88:91E4 4A          LSR A                  ;|
$88:91E5 4A          LSR A                  ;|
$88:91E6 29 0F       AND #$0F               ;|
$88:91E8 85 12       STA $12    [$7E:0012]  ;} X = [power bomb pre-explosion radius] / 800h % 10h * 3
$88:91EA 0A          ASL A                  ;|
$88:91EB 18          CLC                    ;|
$88:91EC 65 12       ADC $12    [$7E:0012]  ;|
$88:91EE AA          TAX                    ;/
$88:91EF BF 79 90 88 LDA $889079,x[$88:907F];\
$88:91F3 09 20       ORA #$20               ;|
$88:91F5 8D 74 00    STA $0074  [$7E:0074]  ;|
$88:91F8 BF 7A 90 88 LDA $88907A,x[$88:9080];|
$88:91FC 09 40       ORA #$40               ;} Colour math subscreen backdrop colour = ([$9079 + [X]], [$9079 + [X] + 1], [$9079 + [X] + 2])
$88:91FE 8D 75 00    STA $0075  [$7E:0075]  ;|
$88:9201 BF 7B 90 88 LDA $88907B,x[$88:9081];|
$88:9205 09 80       ORA #$80               ;|
$88:9207 8D 76 00    STA $0076  [$7E:0076]  ;/
$88:920A C2 30       REP #$30
$88:920C 7A          PLY
$88:920D FA          PLX
$88:920E AD F2 0C    LDA $0CF2  [$7E:0CF2]  ;\
$88:9211 18          CLC                    ;|
$88:9212 69 C0 00    ADC #$00C0             ;} Pre-scaled power bomb explosion shape definition pointer += C0h
$88:9215 8D F2 0C    STA $0CF2  [$7E:0CF2]  ;/
$88:9218 C9 06 A2    CMP #$A206             ;\
$88:921B D0 0F       BNE $0F    [$922C]     ;} If [pre-scaled power bomb explosion shape definition pointer] = $A206:
$88:921D A9 01 00    LDA #$0001             ;\
$88:9220 9D E4 18    STA $18E4,x[$7E:18E4]  ;|
$88:9223 FE CC 18    INC $18CC,x[$7E:18CC]  ;} Wake HDMA object
$88:9226 FE CC 18    INC $18CC,x[$7E:18CC]  ;|
$88:9229 9E 08 19    STZ $1908,x[$7E:1908]  ;/

$88:922C AD EC 0C    LDA $0CEC  [$7E:0CEC]  ;\
$88:922F 18          CLC                    ;|
$88:9230 6D F0 0C    ADC $0CF0  [$7E:0CF0]  ;} If [power bomb pre-explosion radius] + [power bomb explosion radius speed] < 10000h
$88:9233 B0 0E       BCS $0E    [$9243]     ;/
$88:9235 8D EC 0C    STA $0CEC  [$7E:0CEC]  ; Power bomb pre-explosion radius += [power bomb explosion radius speed]
$88:9238 AD F0 0C    LDA $0CF0  [$7E:0CF0]  ;\
$88:923B 38          SEC                    ;|
$88:923C EF DD 90 88 SBC $8890DD[$88:90DD]  ;} Power bomb explosion radius speed += 80h
$88:9240 8D F0 0C    STA $0CF0  [$7E:0CF0]  ;/

$88:9243 AB          PLB
$88:9244 28          PLP
$88:9245 6B          RTL
}


;;; $9246: Power bomb explosion shape definitions tables - pre-scaled ;;;
{
; Defines the shape of (the bottom) half of a power bomb explosion
; Each byte defines the width of the power bomb explosion for that pixel-row, C0h pixel-rows total
; One line per frame of explosion
$88:9246             db 7F,7F,7F,7F,7F,7F,7F,7F,7F,7F,7F,7F,7F,7E,7E,7E,7E,7D,7D,7D,7D,7D,7C,7C,7B,7B,7B,7A,7A,7A,79,79,78,78,77,77,76,76,75,75,74,74,73,72,71,71,70,6F,6E,6E,6D,6C,6B,6A,69,69,68,67,66,65,63,62,61,60,5F,5E,5D,5C,5A,59,57,56,54,53,51,4F,4E,4C,4A,49,47,45,43,40,3E,3B,39,36,33,30,2C,28,25,1F,1A,12,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        86,86,86,86,86,86,86,86,86,85,85,85,85,85,85,85,84,84,84,84,84,83,83,83,82,82,82,81,81,81,80,80,80,7F,7F,7E,7E,7D,7C,7C,7B,7B,7A,7A,79,78,77,77,76,76,75,74,73,72,71,70,6F,6F,6E,6D,6C,6B,6A,68,67,66,65,64,63,62,61,5F,5E,5D,5B,5A,58,56,55,53,52,50,4E,4C,4A,48,46,45,42,40,3D,3B,37,34,31,2D,29,27,21,1B,13,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        8D,8D,8D,8D,8D,8D,8D,8D,8D,8D,8C,8C,8C,8C,8C,8C,8C,8B,8B,8B,8B,8B,8A,8A,8A,89,89,89,89,88,87,87,87,86,86,85,85,84,84,84,83,82,82,81,80,80,80,7F,7E,7D,7C,7C,7B,7A,7A,78,78,77,76,75,75,74,73,72,71,70,6F,6D,6C,6B,6A,69,68,67,66,64,62,62,60,5E,5D,5A,5A,58,57,54,52,51,4F,4D,4A,48,47,44,42,3F,3C,3A,36,33,2F,2B,29,22,1D,14,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        95,95,95,95,95,95,95,95,95,95,94,94,94,94,94,94,94,93,93,93,93,93,93,92,92,91,91,91,90,90,90,90,8F,8E,8E,8E,8D,8D,8D,8C,8C,8B,8A,8A,89,89,88,87,87,86,86,85,85,83,83,82,81,80,80,7F,7E,7D,7C,7B,7B,7A,79,78,76,76,74,73,72,71,70,6F,6E,6C,6B,6A,68,67,66,65,63,61,60,5E,5C,5B,59,57,55,53,51,4F,4E,4B,48,47,43,41,3E,3C,38,34,32,2D,28,22,1F,15,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        9C,9C,9C,9C,9C,9C,9C,9C,9C,9C,9C,9B,9B,9B,9B,9B,9B,9B,9A,9A,9A,99,99,99,99,99,98,98,98,97,97,97,96,96,95,95,95,95,94,93,93,92,92,91,91,90,90,8F,8E,8E,8E,8D,8D,8B,8B,8A,89,89,88,87,86,85,85,84,83,82,81,80,80,7E,7D,7D,7B,7A,79,78,77,76,75,73,72,71,70,6F,6D,6C,6A,6A,67,66,64,63,60,60,5D,5C,5A,57,57,54,52,50,4D,4C,48,46,44,41,3C,3A,36,34,2F,2A,26,20,16,0F,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        A4,A4,A4,A4,A4,A4,A4,A4,A4,A4,A4,A3,A3,A3,A3,A3,A3,A3,A3,A2,A2,A2,A1,A1,A1,A1,A1,A1,A0,A0,9F,9F,9F,9E,9E,9D,9D,9D,9D,9C,9B,9B,9A,9A,9A,99,98,98,97,96,96,95,95,94,94,93,92,92,91,91,8F,8F,8E,8D,8C,8B,8B,8A,89,87,87,86,86,84,84,82,82,80,7E,7E,7D,7C,7B,79,78,77,76,75,73,72,70,6F,6E,6C,6B,69,68,65,63,62,60,5E,5C,5B,58,57,54,51,4F,4C,4A,48,46,42,3F,3B,39,34,2F,2C,26,22,17,10,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        AC,AC,AC,AC,AC,AC,AC,AC,AC,AC,AC,AC,AB,AB,AB,AB,AB,AA,AA,AA,AA,AA,AA,A9,A9,A9,A8,A8,A8,A8,A8,A7,A6,A6,A6,A6,A5,A5,A4,A4,A4,A4,A3,A2,A2,A1,A1,A0,A0,A0,9F,9E,9E,9D,9C,9C,9C,9B,9A,99,99,98,98,96,96,95,94,93,92,91,91,8F,8F,8E,8D,8D,8B,8B,89,89,87,86,85,84,83,82,81,7F,7E,7D,7C,7A,78,78,76,75,73,72,70,6E,6E,6B,6A,68,67,64,63,60,5F,5D,5B,58,56,53,52,4E,4D,49,47,42,40,3C,3A,34,32,2E,27,23,19,11,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        B4,B4,B4,B4,B4,B4,B4,B4,B4,B4,B4,B4,B4,B3,B3,B3,B3,B2,B2,B2,B2,B2,B2,B2,B1,B1,B1,B0,B0,B0,B0,B0,AF,AF,AE,AE,AE,AD,AD,AC,AC,AC,AB,AB,AB,AA,A9,A8,A8,A8,A8,A7,A6,A6,A5,A5,A4,A4,A3,A2,A2,A1,A0,9F,9F,9F,9D,9C,9C,9B,9A,99,99,98,97,95,95,95,93,93,91,90,90,8E,8E,8B,8B,89,89,88,87,85,84,83,82,80,7F,7D,7D,7B,7A,78,76,76,73,72,70,6F,6D,6A,69,67,65,64,61,5F,5C,5A,59,56,54,51,4F,4D,48,45,41,3E,39,37,34,2C,29,1F,1A,12,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        BC,BC,BC,BC,BC,BC,BC,BC,BC,BC,BC,BC,BC,BB,BB,BB,BB,BB,BA,BA,BA,BA,BA,BA,BA,B9,B9,B9,B9,B8,B8,B8,B7,B7,B7,B6,B6,B6,B5,B5,B4,B4,B4,B4,B3,B3,B2,B1,B1,B0,B0,AF,AF,AE,AE,AD,AD,AC,AC,AB,AB,AA,A9,A9,A8,A7,A6,A6,A5,A4,A3,A3,A2,A1,A0,A0,9F,9D,9D,9B,9B,9B,99,98,98,96,95,95,92,92,91,8F,8F,8E,8D,8B,8A,89,88,86,85,84,82,81,80,7E,7C,7C,79,78,77,74,73,70,6F,6E,6B,69,68,65,63,62,5E,5D,5B,57,55,52,50,4E,49,46,44,3F,3B,39,32,2E,2B,21,1B,13,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C4,C4,C4,C4,C4,C3,C3,C3,C3,C2,C2,C2,C2,C2,C2,C2,C1,C1,C1,C0,C0,BF,BF,BF,BF,BF,BE,BD,BD,BC,BC,BC,BB,BB,BB,BA,BA,B9,B8,B8,B8,B7,B7,B6,B5,B4,B4,B4,B3,B3,B2,B1,B1,B0,AF,AE,AE,AE,AC,AB,AA,AA,A9,A8,A7,A7,A6,A5,A3,A3,A3,A2,A0,A0,9F,9D,9D,9C,9B,99,98,97,96,95,94,93,91,90,8F,8E,8C,8B,89,88,87,86,84,82,81,7E,7E,7D,7A,79,77,76,73,71,70,6D,6B,6A,68,65,63,62,5E,5C,59,58,54,51,4F,4A,47,44,3E,3C,39,35,2D,28,22,14,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        CD,CD,CD,CD,CD,CD,CD,CD,CD,CD,CD,CD,CD,CD,CC,CC,CC,CC,CC,CC,CB,CB,CB,CB,CA,CA,CA,C9,C9,C9,C9,C9,C9,C9,C8,C8,C8,C7,C6,C6,C6,C6,C5,C5,C5,C4,C4,C4,C3,C3,C2,C1,C1,C1,C0,C0,BF,BF,BE,BD,BD,BD,BC,BB,BA,BA,B9,B9,B9,B8,B7,B6,B5,B5,B5,B3,B2,B1,B1,B0,AF,AE,AE,AD,AC,AB,AA,A9,A8,A8,A7,A5,A4,A4,A3,A1,A0,9F,9E,9C,9C,9B,9A,99,97,96,95,94,92,91,90,8F,8C,8C,8B,89,87,86,83,83,7F,7F,7E,7C,79,77,76,75,72,6F,6F,6C,69,67,66,63,5F,5D,5C,5A,57,52,4F,4D,4A,45,41,3E,3B,32,2F,2A,24,14,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        D6,D6,D6,D6,D6,D6,D6,D6,D6,D6,D6,D6,D6,D6,D6,D5,D5,D5,D5,D5,D5,D4,D4,D4,D4,D3,D3,D3,D2,D2,D2,D2,D1,D1,D1,D1,D1,D1,D0,D0,CF,CF,CF,CE,CE,CD,CD,CC,CC,CC,CC,CC,CB,CA,CA,C9,C8,C8,C7,C7,C7,C7,C6,C5,C4,C4,C3,C2,C2,C2,C1,C1,C0,BF,BE,BD,BC,BC,BC,BA,B9,B9,B8,B7,B6,B6,B5,B4,B3,B2,B1,B1,B0,AF,AE,AD,AC,AB,AA,A9,A7,A6,A5,A4,A3,A2,A1,A0,9E,9D,9D,9B,9A,98,98,96,94,92,92,91,8F,8D,8C,89,88,88,84,83,82,80,7E,7D,7A,78,77,74,73,70,6E,6B,6A,68,63,61,60,5E,5B,56,53,50,4E,4A,48,41,3E,39,34,31,25,1F,15,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        DF,DF,DF,DF,DF,DF,DF,DF,DF,DF,DF,DF,DF,DF,DF,DE,DE,DE,DE,DE,DE,DE,DD,DD,DD,DD,DC,DC,DC,DB,DB,DB,DB,DB,DA,DA,DA,D9,D9,D9,D9,D9,D8,D8,D8,D7,D7,D6,D6,D5,D5,D5,D4,D4,D3,D3,D2,D2,D1,D1,D1,D0,D0,CF,CE,CD,CD,CC,CC,CB,CB,CB,CA,C9,C9,C8,C7,C6,C5,C4,C4,C4,C3,C2,C1,C0,BF,BE,BD,BD,BD,BC,BA,B9,B8,B8,B7,B6,B6,B4,B3,B2,B1,B0,AF,AE,AC,AB,AA,A9,A8,A8,A7,A4,A3,A2,A1,A1,9F,9E,9B,9A,99,98,97,95,93,92,8F,8E,8D,8B,8A,89,85,84,82,80,7F,7D,7C,78,76,75,72,70,6F,6C,68,65,64,62,5F,5C,5A,54,51,4D,4B,46,44,40,37,33,2E,27,20,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        E8,E8,E8,E8,E8,E8,E8,E8,E8,E8,E8,E8,E8,E8,E8,E8,E7,E7,E7,E7,E7,E7,E6,E6,E6,E6,E6,E5,E5,E5,E5,E4,E4,E4,E4,E3,E3,E3,E3,E2,E2,E1,E1,E0,E0,E0,E0,DF,DF,DE,DE,DE,DE,DE,DD,DD,DC,DC,DB,DB,DA,D9,D9,D8,D8,D7,D7,D6,D5,D5,D4,D4,D3,D3,D3,D2,D1,D1,D0,CF,CE,CE,CC,CC,CB,CA,CA,C9,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0,C0,C0,BF,BE,BC,BB,BA,B9,B8,B7,B6,B5,B4,B3,B1,B0,AF,AE,AD,AC,AB,AA,A9,A8,A5,A4,A2,A2,A1,9F,9E,9D,9B,99,97,95,94,93,90,8F,8E,8D,8B,89,85,84,82,81,7E,7D,7A,79,77,74,70,6F,6C,69,68,65,63,60,5D,5A,57,51,4E,49,46,43,3E,39,35,30,28,17,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        F2,F2,F2,F2,F2,F2,F2,F2,F2,F2,F2,F2,F2,F2,F2,F2,F2,F1,F1,F1,F1,F1,F1,F0,F0,F0,F0,F0,EF,EF,EF,EF,EE,EE,EE,EE,EE,ED,ED,ED,EC,EC,EC,EB,EB,EA,EA,EA,EA,E9,E9,E8,E8,E7,E7,E7,E7,E6,E5,E5,E4,E4,E3,E2,E2,E2,E1,E1,E0,E0,E0,DF,DF,DE,DE,DC,DC,DC,DB,DA,DA,D9,D8,D7,D7,D6,D5,D5,D4,D3,D2,D1,D1,D0,CE,CD,CD,CD,CC,CB,CA,C9,C8,C8,C7,C6,C5,C4,C3,C2,C1,C0,BF,BC,BB,BA,BA,B9,B8,B7,B6,B5,B3,B2,B1,B0,AF,AE,AC,AB,A9,A8,A6,A5,A4,A2,A0,9F,9E,9B,9A,99,96,95,95,93,91,8F,8D,8B,87,86,83,82,80,7F,7C,79,78,75,73,70,6E,6D,6A,67,64,61,5D,58,54,51,4C,4A,46,41,3B,38,32,2A,23,18,00,00,00,00,00,00,00,00,00,00,
                        FB,FB,FB,FB,FB,FB,FB,FB,FB,FB,FB,FB,FB,FB,FB,FB,FB,FA,FA,FA,FA,FA,FA,FA,F9,F9,F9,F9,F9,F8,F8,F8,F8,F7,F7,F7,F7,F7,F6,F6,F6,F6,F5,F5,F5,F4,F4,F3,F3,F3,F3,F2,F2,F1,F1,F0,F0,F0,F0,EF,EF,EE,EE,ED,EC,EB,EB,EB,EA,EA,E9,E9,E8,E7,E7,E6,E6,E5,E4,E4,E4,E3,E2,E2,E1,E0,DF,DF,DE,DD,DD,DC,DB,DA,D9,D9,D8,D7,D6,D5,D5,D4,D3,D2,D1,D0,CF,CF,CE,CD,CC,CB,CA,C9,C8,C7,C6,C5,C3,C2,C1,C0,BF,BE,BD,BD,BC,B9,B8,B7,B6,B5,B3,B2,B0,AF,AE,AC,AB,AA,A8,A6,A5,A4,A1,A0,9F,9C,9B,9A,98,96,94,92,90,8F,8C,8B,88,87,84,83,80,7E,7D,7A,78,75,72,71,6E,6B,68,65,61,5E,5B,57,54,4F,4C,48,43,3E,3A,34,2C,24,19,00,00,00,
                        FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FD,FD,FD,FD,FD,FD,FD,FC,FC,FC,FC,FC,FB,FB,FB,FB,FA,FA,FA,FA,FA,F9,F9,F9,F9,F8,F8,F8,F7,F7,F6,F6,F6,F6,F5,F5,F4,F4,F3,F3,F3,F3,F2,F2,F1,F1,F0,F0,EF,EE,EE,EE,ED,ED,EC,EC,EB,EA,EA,E9,E9,E8,E7,E7,E7,E6,E5,E5,E4,E3,E2,E2,E1,E0,E0,DF,DE,DD,DC,DC,DB,DA,D9,D8,D8,D7,D6,D5,D4,D3,D2,D2,D1,D0,CF,CE,CD,CC,CB,CA,C9,C8,C6,C5,C4,C3,C2,C1,C0,BF,BE,BC,BB,BA,B9,B8,B7,B5,B4,B2,B1,B0,AE,AD,AC,AA,A8,A7,A6,A3,A2,A1,9E,9D,9C,9A,98,96,94,92,91,8E,8D,8A,89,86,85,82,7F,7E,7B,79,76,73,72,6F,6C,69,66,62,5F,5C,58,55,50,4D,49,44,3E,3A,34,2C,24,19,00
}


;;; $9F06: Power bomb pre-explosion shape definition tables - pre-scaled ;;;
{
; Defines the shape of (the bottom) half of a power bomb explosion
; Each byte defines the width of the power bomb explosion for that pixel-row, C0h pixel-rows total
; One line per frame of explosion
$88:9F06             db 91,91,91,91,91,91,91,91,91,91,90,90,90,90,90,90,90,8F,8F,8F,8F,8F,8E,8E,8E,8E,8D,8C,8C,8C,8C,8B,8B,8B,8A,8A,89,89,88,88,87,87,86,86,85,84,84,83,83,82,81,80,80,7F,7E,7E,7C,7C,7B,7A,79,78,78,77,76,75,74,73,71,70,6F,6E,6D,6C,6B,6A,68,67,66,64,63,61,60,5F,5C,5A,5A,58,56,53,53,50,4E,4C,4A,48,45,42,41,3E,3A,36,35,31,2C,27,23,1E,15,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        C0,C0,C0,C0,C0,C0,C0,C0,C0,C0,C0,C0,C0,BF,BF,BF,BF,BF,BF,BE,BE,BE,BD,BD,BD,BD,BD,BD,BD,BC,BC,BC,BB,BB,BA,BA,BA,BA,BA,B9,B8,B8,B7,B7,B7,B7,B6,B6,B5,B5,B4,B4,B4,B3,B2,B2,B1,B1,B0,AF,AE,AE,AE,AD,AD,AB,AB,AB,A9,A9,A8,A7,A6,A6,A5,A4,A3,A2,A2,A1,9F,9F,9F,9D,9C,9C,9A,99,99,97,96,95,93,93,92,90,8F,8E,8D,8C,8B,8A,88,86,86,83,83,82,7F,7E,7D,7A,7A,77,76,74,73,70,6E,6E,6B,68,68,65,62,60,5D,5B,59,56,54,52,4D,4A,48,43,40,3D,37,34,2F,27,21,1B,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        EE,EE,EE,EE,EE,EE,EE,EE,EE,EE,EE,EE,EE,EE,EE,EE,ED,ED,ED,ED,ED,ED,ED,EC,EC,EC,EC,EC,EB,EB,EB,EA,EA,EA,EA,EA,E9,E9,E9,E9,E8,E8,E8,E7,E6,E6,E6,E6,E5,E5,E4,E4,E3,E3,E3,E3,E2,E1,E1,E0,E0,E0,DF,DF,DF,DE,DE,DD,DD,DC,DB,DA,DA,D9,D8,D8,D8,D7,D6,D6,D5,D4,D3,D3,D2,D2,D1,D0,CF,CE,CE,CD,CC,CB,CA,CA,C9,C8,C7,C5,C4,C4,C4,C3,C2,C1,C0,BF,BE,BD,BC,BB,B9,B7,B6,B6,B5,B4,B3,B2,B0,AF,AE,AD,AC,AB,A9,A7,A6,A5,A3,A2,A1,9F,9D,9C,9B,99,98,97,94,92,90,8E,8C,8B,89,88,85,84,81,80,7E,7D,7A,76,73,71,6F,6C,6B,68,65,62,60,5C,59,56,53,4B,48,45,40,3A,37,31,2A,22,18,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FE,FD,FD,FD,FD,FD,FD,FD,FC,FC,FC,FC,FC,FB,FB,FB,FB,FA,FA,FA,FA,FA,F9,F9,F9,F9,F8,F8,F8,F7,F7,F6,F6,F6,F6,F5,F5,F4,F4,F3,F3,F3,F3,F2,F2,F1,F1,F0,F0,EF,EE,EE,EE,ED,ED,EC,EC,EB,EA,EA,E9,E9,E8,E7,E7,E7,E6,E5,E5,E4,E3,E2,E2,E1,E0,E0,DF,DE,DD,DC,DC,DB,DA,D9,D8,D8,D7,D6,D5,D4,D3,D2,D2,D1,D0,CF,CE,CD,CC,CB,CA,C9,C8,C6,C5,C4,C3,C2,C1,C0,BF,BE,BC,BB,BA,B9,B8,B7,B5,B4,B2,B1,B0,AE,AD,AC,AA,A8,A7,A6,A3,A2,A1,9E,9D,9C,9A,98,96,94,92,91,8E,8D,8A,89,86,85,82,7F,7E,7B,79,76,73,72,6F,6C,69,66,62,5F,5C,58,55,50,4D,49,44,3E,3A,34,2C,24,19,00
}


;;; $A206: Free space ;;;
{
; I believe this padding exists purely because of the "optimisation" done in the
; "calculate power bomb explosion HDMA data tables - stage 1/3" routines ($8CC6/$8D04/$8D46)
; where Y starts at 60h so that it can be checked against 80h via inspecting the negative flag.
$88:A206             db FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF
}


;;; $A266: Power bomb explosion shape definition table - unscaled ;;;
{
; This table gives the shape of (the bottom) half of a power bomb explosion with X radius = 100h (Y radius C0h),
; starting from the bottom and ending at the centre

; Width
$88:A266             db 00, 0C, 19, 25, 31, 3E, 4A, 56, 61, 6D, 78, 83, 8E, 98, A2, AB, B5, BD, C5, CD, D4, DB, E1, E7, EC, F1, F4, F8, FB, FD, FE, FF

; Top offset (previous entry used as bottom offset)
$88:A286             db BF, BF, BE, BD, BA, B8, B6, B2, AF, AB, A6, A2, 9C, 96, 90, 8A, 84, 7D, 75, 6E, 66, 5E, 56, 4D, 45, 3C, 33, 2A, 20, 17, 0D, 04
}


;;; $A2A6: Spawn crystal flash HDMA objects ;;;
{
; These HDMAs aren't really needed
$88:A2A6 A9 00 80    LDA #$8000             ;\
$88:A2A9 8D 92 05    STA $0592  [$7E:0592]  ;} Set power bomb exploding flag
$88:A2AC 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:A2B0             dx 40,28,A2BD          ;} Spawn indirect HDMA object for window 2 left position with instruction list $A2BD
$88:A2B4 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:A2B8             dx 40,29,A32A          ;} Spawn indirect HDMA object for window 2 right position with instruction list $A32A
$88:A2BC 6B          RTL
}


;;; $A2BD: Instruction list - crystal flash window 2 left position ;;;
{
$88:A2BD             dx 8655,89,    ; HDMA table bank = $89
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        85B4,88A2E4,; Crystal flash - setup - part 1
                        85B4,88A309,; Crystal flash - setup - part 2
                        8570,88A552,; Pre-instruction = crystal flash - stage 1 - explosion
                        8682,       ; Sleep
                        8570,88A35D,; Pre-instruction = crystal flash - stage 2 - after-glow
                        8682,       ; Sleep
                        85B4,88A317,; Crystal flash - clean up
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $A2E4: Crystal flash - setup (1/2) ;;;
{
$88:A2E4 E2 20       SEP #$20
$88:A2E6 A9 FF       LDA #$FF               ;\
$88:A2E8 8F 06 C6 7E STA $7EC606[$7E:C606]  ;} Off-screen power bomb explosion left HDMA data entry = FFh
$88:A2EC A9 00       LDA #$00               ;\
$88:A2EE 8F 07 C6 7E STA $7EC607[$7E:C607]  ;} Off-screen power bomb explosion right HDMA data entry = 0
$88:A2F2 C2 20       REP #$20
$88:A2F4 A9 00 04    LDA #$0400             ;\
$88:A2F7 8D EC 0C    STA $0CEC  [$7E:0CEC]  ;} Power bomb pre-explosion flash radius = 400h
$88:A2FA AF DB 90 88 LDA $8890DB[$88:90DB]  ;\
$88:A2FE 8D F0 0C    STA $0CF0  [$7E:0CF0]  ;} Power bomb (pre-)explosion radius speed = 3000h
$88:A301 A9 01 00    LDA #$0001             ;\
$88:A304 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 1, sound library 1, max queued sounds allowed = 6 (power bomb explosion)
$88:A308 6B          RTL
}


;;; $A309: Crystal flash - setup (2/2) ;;;
{
$88:A309 A9 00 04    LDA #$0400             ;\
$88:A30C 8D EA 0C    STA $0CEA  [$7E:0CEA]  ;} Power bomb explosion radius = 400h
$88:A30F AF E5 8D 88 LDA $888DE5[$88:8DE5]  ;\
$88:A313 8D F0 0C    STA $0CF0  [$7E:0CF0]  ;} Power bomb (pre-)explosion radius speed = 0
$88:A316 6B          RTL
}


;;; $A317: Crystal flash - clean up ;;;
{
$88:A317 9C EE 0C    STZ $0CEE  [$7E:0CEE]  ; Power bomb flag = 0
$88:A31A 9C 92 05    STZ $0592  [$7E:0592]  ; Clear power bomb explosion status
$88:A31D 9E B4 18    STZ $18B4,x[$7E:18B6]  ;\
$88:A320 9E B6 18    STZ $18B6,x[$7E:18B8]  ;} Delete HDMA objects [X] and [X] + 2
$88:A323 9C EC 0C    STZ $0CEC  [$7E:0CEC]  ; Power bomb pre-explosion radius = 0
$88:A326 9C EA 0C    STZ $0CEA  [$7E:0CEA]  ; Power bomb explosion radius = 0
$88:A329 6B          RTL
}


;;; $A32A: Instruction list - crystal flash window 2 right position ;;;
{
$88:A32A             dx 8655,89,    ; HDMA table bank = $89
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,88A339,; Pre-instruction = custom layer blending window 2 configuration
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $A339: Pre-instruction - crystal flash - custom layer blending window 2 configuration ;;;
{
; Setting these variables doesn't achieve anything, as the layer blending is handled entirely by a subsystem using $1986/87
$88:A339 E2 20       SEP #$20
$88:A33B 9C 60 00    STZ $0060  [$7E:0060]  ; Disable BG1/BG2 window 1/2 masking
$88:A33E A9 08       LDA #$08               ;\
$88:A340 8D 61 00    STA $0061  [$7E:0061]  ;} Enable BG3 window 2 inclusive mask
$88:A343 A9 80       LDA #$80               ;\
$88:A345 8D 62 00    STA $0062  [$7E:0062]  ;} Enable colour math window 2 inclusive mask
$88:A348 A9 02       LDA #$02               ;\
$88:A34A 8D 6E 00    STA $006E  [$7E:006E]  ;} Enable colour math subscreen layers
$88:A34D A9 33       LDA #$33               ;\
$88:A34F 8D 71 00    STA $0071  [$7E:0071]  ;} Enable colour math on BG1/BG2/sprites/backdrop
$88:A352 9C 6C 00    STZ $006C  [$7E:006C]  ; Enable all layers in window area main screen
$88:A355 A9 04       LDA #$04               ;\
$88:A357 8D 6D 00    STA $006D  [$7E:006D]  ;} Disable BG3 in window area subscreen
$88:A35A C2 20       REP #$20
$88:A35C 6B          RTL
}


;;; $A35D: Pre-instruction - crystal flash - stage 2 - after-glow ;;;
{
; The same as power bomb explosion stage 5 ($8B98) except for using colour components as a wake criterion ($A36A..76) instead of [HDMA object $1938]
; This is actually a bug, as the colour components are always non-zero in rooms that use a backdrop colour (FX 28h/2Ah), meaning this object never dies
; If you lay a power bomb afterwards, this does override the backdrop colour to zero and causes this object to clean itself up,
; but that screws up the power bomb due to the global power bomb state (see $A317)
$88:A35D AD 92 05    LDA $0592  [$7E:0592]  ;\
$88:A360 30 01       BMI $01    [$A363]     ;} If power bomb is not exploding:
$88:A362 6B          RTL                    ; Return

$88:A363 DE 08 19    DEC $1908,x[$7E:190A]  ; Decrement HDMA object timer
$88:A366 10 3F       BPL $3F    [$A3A7]     ; If [HDMA object timer] >= 0: return
$88:A368 E2 20       SEP #$20
$88:A36A AD 74 00    LDA $0074  [$7E:0074]  ;\
$88:A36D 0D 75 00    ORA $0075  [$7E:0075]  ;|
$88:A370 0D 76 00    ORA $0076  [$7E:0076]  ;} If colour math subscreen backdrop colour = 0: go to BRANCH_WAKE
$88:A373 29 1F       AND #$1F               ;|
$88:A375 F0 31       BEQ $31    [$A3A8]     ;/
$88:A377 AD 74 00    LDA $0074  [$7E:0074]  ;\
$88:A37A 29 1F       AND #$1F               ;} If (red component of colour math subscreen backdrop colour) != 0:
$88:A37C F0 06       BEQ $06    [$A384]     ;/
$88:A37E 3A          DEC A                  ;\
$88:A37F 09 20       ORA #$20               ;} Decrement (red component of colour math subscreen backdrop colour)
$88:A381 8D 74 00    STA $0074  [$7E:0074]  ;/

$88:A384 AD 75 00    LDA $0075  [$7E:0075]  ;\
$88:A387 29 1F       AND #$1F               ;} If (green component of colour math subscreen backdrop colour) != 0:
$88:A389 F0 06       BEQ $06    [$A391]     ;/
$88:A38B 3A          DEC A                  ;\
$88:A38C 09 40       ORA #$40               ;} Decrement (green component of colour math subscreen backdrop colour)
$88:A38E 8D 75 00    STA $0075  [$7E:0075]  ;/

$88:A391 AD 76 00    LDA $0076  [$7E:0076]  ;\
$88:A394 29 1F       AND #$1F               ;} If (blue component of colour math subscreen backdrop colour) != 0:
$88:A396 F0 06       BEQ $06    [$A39E]     ;/
$88:A398 3A          DEC A                  ;\
$88:A399 09 80       ORA #$80               ;} Decrement (blue component of colour math subscreen backdrop colour)
$88:A39B 8D 76 00    STA $0076  [$7E:0076]  ;/

$88:A39E AF 96 8B 88 LDA $888B96[$88:8B96]  ;\
$88:A3A2 9D 08 19    STA $1908,x[$7E:190A]  ;} HDMA object timer = 3
$88:A3A5 C2 20       REP #$20

$88:A3A7 6B          RTL                    ; Return

; BRANCH_WAKE
$88:A3A8 C2 20       REP #$20
$88:A3AA A9 01 00    LDA #$0001             ;\
$88:A3AD 9D E4 18    STA $18E4,x[$7E:18E6]  ;|
$88:A3B0 FE CC 18    INC $18CC,x[$7E:18CE]  ;} Wake HDMA object
$88:A3B3 FE CC 18    INC $18CC,x[$7E:18CE]  ;/
$88:A3B6 6B          RTL
}


;;; $A3B7: Unused. Calculate crystal flash HDMA data tables - pre-scaled - power bomb is left of screen ;;;
{
; Clone of $8BEA

$88:A3B7 AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:A3BA 18          CLC
$88:A3BB 79 00 00    ADC $0000,y
$88:A3BE B0 0D       BCS $0D    [$A3CD]
$88:A3C0 A9 00       LDA #$00
$88:A3C2 9F 06 C5 7E STA $7EC506,x
$88:A3C6 1A          INC A
$88:A3C7 9F 06 C4 7E STA $7EC406,x
$88:A3CB 80 0A       BRA $0A    [$A3D7]

$88:A3CD 9F 06 C5 7E STA $7EC506,x
$88:A3D1 A9 00       LDA #$00
$88:A3D3 9F 06 C4 7E STA $7EC406,x

$88:A3D7 C8          INY
$88:A3D8 E8          INX
$88:A3D9 E0 C0 00    CPX #$00C0
$88:A3DC D0 D9       BNE $D9    [$A3B7]
$88:A3DE 60          RTS
}


;;; $A3DF: Unused. Calculate crystal flash HDMA data tables - pre-scaled - power bomb is on screen ;;;
{
; Clone of $8C12

$88:A3DF B9 00 00    LDA $0000,y
$88:A3E2 F0 22       BEQ $22    [$A406]
$88:A3E4 18          CLC
$88:A3E5 6D E6 0C    ADC $0CE6  [$7E:0CE6]
$88:A3E8 90 02       BCC $02    [$A3EC]
$88:A3EA A9 FF       LDA #$FF

$88:A3EC 9F 06 C5 7E STA $7EC506,x
$88:A3F0 AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:A3F3 38          SEC
$88:A3F4 F9 00 00    SBC $0000,y
$88:A3F7 B0 02       BCS $02    [$A3FB]
$88:A3F9 A9 00       LDA #$00

$88:A3FB 9F 06 C4 7E STA $7EC406,x
$88:A3FF C8          INY
$88:A400 E8          INX
$88:A401 E0 C0 00    CPX #$00C0
$88:A404 D0 D9       BNE $D9    [$A3DF]

$88:A406 60          RTS
}


;;; $A407: Unused. Calculate crystal flash HDMA data tables - pre-scaled - power bomb is right of screen ;;;
{
; Clone of $8C3A

$88:A407 AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:A40A 38          SEC
$88:A40B F9 00 00    SBC $0000,y
$88:A40E 90 0D       BCC $0D    [$A41D]
$88:A410 A9 FF       LDA #$FF
$88:A412 9F 06 C4 7E STA $7EC406,x
$88:A416 3A          DEC A
$88:A417 9F 06 C5 7E STA $7EC506,x
$88:A41B 80 0A       BRA $0A    [$A427]

$88:A41D 9F 06 C4 7E STA $7EC406,x
$88:A421 A9 FF       LDA #$FF
$88:A423 9F 06 C5 7E STA $7EC506,x

$88:A427 C8          INY
$88:A428 E8          INX
$88:A429 E0 C0 00    CPX #$00C0
$88:A42C D0 D9       BNE $D9    [$A407]
$88:A42E 60          RTS
}


;;; $A42F: Calculate crystal flash HDMA object table pointers ;;;
{
; Clone of $8C62

$88:A42F AD 92 05    LDA $0592  [$7E:0592]
$88:A432 30 01       BMI $01    [$A435]
$88:A434 6B          RTL

$88:A435 AD E2 0C    LDA $0CE2  [$7E:0CE2]
$88:A438 38          SEC
$88:A439 ED 11 09    SBC $0911  [$7E:0911]
$88:A43C 18          CLC
$88:A43D 69 00 01    ADC #$0100
$88:A440 C9 00 03    CMP #$0300
$88:A443 90 02       BCC $02    [$A447]
$88:A445 80 13       BRA $13    [$A45A]

$88:A447 8D E6 0C    STA $0CE6  [$7E:0CE6]
$88:A44A AD E4 0C    LDA $0CE4  [$7E:0CE4]
$88:A44D 38          SEC
$88:A44E ED 15 09    SBC $0915  [$7E:0915]
$88:A451 18          CLC
$88:A452 69 00 01    ADC #$0100
$88:A455 C9 00 03    CMP #$0300
$88:A458 90 03       BCC $03    [$A45D]

$88:A45A A9 00 00    LDA #$0000

$88:A45D 49 FF 03    EOR #$03FF
$88:A460 38          SEC
$88:A461 E9 00 01    SBC #$0100
$88:A464 8D E8 0C    STA $0CE8  [$7E:0CE8]
$88:A467 AD EA 0C    LDA $0CEA  [$7E:0CEA]
$88:A46A 29 00 FF    AND #$FF00
$88:A46D D0 03       BNE $03    [$A472]
$88:A46F 9C E8 0C    STZ $0CE8  [$7E:0CE8]

$88:A472 BD C0 18    LDA $18C0,x[$7E:18C2]
$88:A475 29 FF 00    AND #$00FF
$88:A478 A8          TAY
$88:A479 AD E8 0C    LDA $0CE8  [$7E:0CE8]
$88:A47C 0A          ASL A
$88:A47D 18          CLC
$88:A47E 6D E8 0C    ADC $0CE8  [$7E:0CE8]
$88:A481 85 16       STA $16    [$7E:0016]
$88:A483 69 00 98    ADC #$9800
$88:A486 9D D8 18    STA $18D8,x[$7E:18DA]
$88:A489 A5 16       LDA $16    [$7E:0016]
$88:A48B 18          CLC
$88:A48C 69 01 A1    ADC #$A101
$88:A48F 9D DA 18    STA $18DA,x[$7E:18DC]
$88:A492 6B          RTL
}


;;; $A493: Calculate crystal flash HDMA data tables - scaled - power bomb is left of screen ;;;
{
; Clone of $8CC6

$88:A493 B9 26 A2    LDA $A226,y
$88:A496 8D 03 42    STA $4203            
$88:A499 EA          NOP
$88:A49A EA          NOP
$88:A49B EA          NOP
$88:A49C AD 17 42    LDA $4217            
$88:A49F 85 14       STA $14    [$7E:0014]
$88:A4A1 B9 06 A2    LDA $A206,y
$88:A4A4 8D 03 42    STA $4203            
$88:A4A7 EA          NOP
$88:A4A8 AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:A4AB 18          CLC
$88:A4AC 6D 17 42    ADC $4217            
$88:A4AF B0 07       BCS $07    [$A4B8]
$88:A4B1 A9 00       LDA #$00
$88:A4B3 EB          XBA
$88:A4B4 A9 FF       LDA #$FF
$88:A4B6 80 03       BRA $03    [$A4BB]

$88:A4B8 EB          XBA
$88:A4B9 A9 00       LDA #$00

$88:A4BB 9F 06 C4 7E STA $7EC406,x
$88:A4BF EB          XBA
$88:A4C0 9F 06 C5 7E STA $7EC506,x
$88:A4C4 EB          XBA
$88:A4C5 E4 14       CPX $14    [$7E:0014]
$88:A4C7 F0 04       BEQ $04    [$A4CD]
$88:A4C9 CA          DEX
$88:A4CA 4C BB A4    JMP $A4BB  [$88:A4BB]

$88:A4CD C8          INY
$88:A4CE 10 C3       BPL $C3    [$A493]
$88:A4D0 60          RTS
}


;;; $A4D1: Calculate crystal flash HDMA data tables - scaled - power bomb is on screen ;;;
{
; Clone of $8D04

$88:A4D1 B9 26 A2    LDA $A226,y[$88:A286]
$88:A4D4 8D 03 42    STA $4203            
$88:A4D7 EA          NOP
$88:A4D8 EA          NOP
$88:A4D9 EA          NOP
$88:A4DA AD 17 42    LDA $4217            
$88:A4DD 85 14       STA $14    [$7E:0014]
$88:A4DF B9 06 A2    LDA $A206,y[$88:A266]
$88:A4E2 8D 03 42    STA $4203            
$88:A4E5 EA          NOP
$88:A4E6 AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:A4E9 18          CLC
$88:A4EA 6D 17 42    ADC $4217            
$88:A4ED 90 02       BCC $02    [$A4F1]
$88:A4EF A9 FF       LDA #$FF

$88:A4F1 EB          XBA
$88:A4F2 AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:A4F5 38          SEC
$88:A4F6 ED 17 42    SBC $4217            
$88:A4F9 B0 02       BCS $02    [$A4FD]
$88:A4FB A9 00       LDA #$00

$88:A4FD 9F 06 C4 7E STA $7EC406,x[$7E:C408]
$88:A501 EB          XBA
$88:A502 9F 06 C5 7E STA $7EC506,x[$7E:C508]
$88:A506 EB          XBA
$88:A507 E4 14       CPX $14    [$7E:0014]
$88:A509 F0 04       BEQ $04    [$A50F]
$88:A50B CA          DEX
$88:A50C 4C FD A4    JMP $A4FD  [$88:A4FD]

$88:A50F C8          INY
$88:A510 10 BF       BPL $BF    [$A4D1]
$88:A512 60          RTS
}


;;; $A513: Calculate crystal flash HDMA data tables - scaled - power bomb is right of screen ;;;
{
; Clone of $8D46

$88:A513 B9 26 A2    LDA $A226,y
$88:A516 8D 03 42    STA $4203            
$88:A519 EA          NOP
$88:A51A EA          NOP
$88:A51B EA          NOP
$88:A51C AD 17 42    LDA $4217            
$88:A51F 85 14       STA $14    [$7E:0014]
$88:A521 B9 06 A2    LDA $A206,y
$88:A524 8D 03 42    STA $4203            
$88:A527 EA          NOP
$88:A528 AD E6 0C    LDA $0CE6  [$7E:0CE6]
$88:A52B 38          SEC
$88:A52C ED 17 42    SBC $4217            
$88:A52F 90 07       BCC $07    [$A538]
$88:A531 A9 FF       LDA #$FF
$88:A533 EB          XBA
$88:A534 A9 00       LDA #$00
$88:A536 80 03       BRA $03    [$A53B]

$88:A538 EB          XBA
$88:A539 A9 FF       LDA #$FF

$88:A53B EB          XBA

$88:A53C 9F 06 C4 7E STA $7EC406,x
$88:A540 EB          XBA
$88:A541 9F 06 C5 7E STA $7EC506,x
$88:A545 EB          XBA
$88:A546 E4 14       CPX $14    [$7E:0014]
$88:A548 F0 04       BEQ $04    [$A54E]
$88:A54A CA          DEX
$88:A54B 4C 3C A5    JMP $A53C  [$88:A53C]

$88:A54E C8          INY
$88:A54F 10 C2       BPL $C2    [$A513]
$88:A551 60          RTS
}


;;; $A552: Pre-instruction - crystal flash - stage 1 - explosion ;;;
{
; Identical to power bomb explosion stage 3 ($8DE9) except for the max radius (at $A5F6, resp. $8E8D)
$88:A552 AD 92 05    LDA $0592  [$7E:0592]  ;\
$88:A555 30 01       BMI $01    [$A558]     ;} If power bomb is not exploding:
$88:A557 6B          RTL                    ; Return

$88:A558 08          PHP
$88:A559 8B          PHB
$88:A55A C2 30       REP #$30
$88:A55C DA          PHX
$88:A55D 5A          PHY
$88:A55E 22 2F A4 88 JSL $88A42F[$88:A42F]  ; Calculate crystal flash HDMA object table pointers
$88:A562 F4 00 88    PEA $8800              ;\
$88:A565 AB          PLB                    ;} DB = $88
$88:A566 AB          PLB                    ;/
$88:A567 E2 30       SEP #$30
$88:A569 A9 00       LDA #$00               ;\
$88:A56B EB          XBA                    ;} Clear A high
$88:A56C A0 60       LDY #$60               ; Y = 60h
$88:A56E AD EB 0C    LDA $0CEB  [$7E:0CEB]  ;\
$88:A571 8D 02 42    STA $4202              ;|
$88:A574 AD 86 A2    LDA $A286  [$88:A286]  ;|
$88:A577 8D 03 42    STA $4203              ;|
$88:A57A EA          NOP                    ;} $12 = [power bomb explosion radius] * BFh / 10000h (power bomb explosion Y radius in pixels)
$88:A57B EA          NOP                    ;|
$88:A57C EA          NOP                    ;|
$88:A57D AD 17 42    LDA $4217              ;|
$88:A580 85 12       STA $12    [$7E:0012]  ;/
$88:A582 AA          TAX                    ; X = (power bomb explosion Y radius in pixels)
$88:A583 F4 98 A5    PEA $A598              ; Push RETURN - 1
$88:A586 AD E7 0C    LDA $0CE7  [$7E:0CE7]  ;\
$88:A589 29 FF       AND #$FF               ;} If (X position of power bomb on screen) < 0: go to BRANCH_OFFSCREEN_LEFT
$88:A58B F0 09       BEQ $09    [$A596]     ;/
$88:A58D 3A          DEC A                  ;\
$88:A58E F0 03       BEQ $03    [$A593]     ;} If (X position of power bomb on screen) < 100h: go to BRANCH_ONSCREEN
$88:A590 4C 13 A5    JMP $A513  [$88:A513]  ; Calculate crystal flash HDMA data tables - power bomb is right of screen

; BRANCH_ONSCREEN
$88:A593 4C D1 A4    JMP $A4D1  [$88:A4D1]  ; Calculate crystal flash HDMA data tables - power bomb is on screen

; BRANCH_OFFSCREEN_LEFT
$88:A596 4C 93 A4    JMP $A493  [$88:A493]  ; Calculate crystal flash HDMA data tables - power bomb is left of screen

; RETURN
; LOOP_PAD_DATA_TABLE_BEGIN
$88:A599 9F 06 C4 7E STA $7EC406,x[$7E:C406]; Power bomb explosion window 2 left HDMA data table entry = [A low]
$88:A59D EB          XBA                    ;\
$88:A59E 9F 06 C5 7E STA $7EC506,x[$7E:C506];} Power bomb explosion window 2 right HDMA data table entry = [A high]
$88:A5A2 EB          XBA                    ;/
$88:A5A3 CA          DEX                    ; Decrement X (previous data table entry)
$88:A5A4 10 F3       BPL $F3    [$A599]     ; If [X] >= 0: go to LOOP_PAD_DATA_TABLE_BEGIN
$88:A5A6 A6 12       LDX $12    [$7E:0012]  ;\
$88:A5A8 E8          INX                    ;} X = (power bomb explosion Y radius in pixels) + 1
$88:A5A9 E0 C0       CPX #$C0               ;\
$88:A5AB F0 11       BEQ $11    [$A5BE]     ;} If [X] = C0h: go to BRANCH_FINISHED_TABLE
$88:A5AD A9 FF       LDA #$FF               ; A = FFh

; LOOP_PAD_DATA_TABLE_END
$88:A5AF 9F 06 C4 7E STA $7EC406,x[$7E:C409]; Power bomb explosion window 2 left HDMA data table entry = FFh
$88:A5B3 1A          INC A                  ;\
$88:A5B4 9F 06 C5 7E STA $7EC506,x[$7E:C509];} Power bomb explosion window 2 right HDMA data table entry = 0
$88:A5B8 3A          DEC A                  ;/
$88:A5B9 E8          INX                    ; Increment X (next data table entry)
$88:A5BA E0 C0       CPX #$C0               ;\
$88:A5BC D0 F1       BNE $F1    [$A5AF]     ;} If [X] != C0h: go to LOOP_PAD_DATA_TABLE_END

; BRANCH_FINISHED_TABLE
$88:A5BE AD EB 0C    LDA $0CEB  [$7E:0CEB]  ;\
$88:A5C1 4A          LSR A                  ;|
$88:A5C2 4A          LSR A                  ;|
$88:A5C3 4A          LSR A                  ;|
$88:A5C4 29 1F       AND #$1F               ;|
$88:A5C6 85 12       STA $12    [$7E:0012]  ;} X = [power bomb explosion radius] / 800h * 3
$88:A5C8 0A          ASL A                  ;|
$88:A5C9 18          CLC                    ;|
$88:A5CA 65 12       ADC $12    [$7E:0012]  ;|
$88:A5CC AA          TAX                    ;/
$88:A5CD BF 85 8D 88 LDA $888D85,x[$88:8D85];\
$88:A5D1 09 20       ORA #$20               ;|
$88:A5D3 8D 74 00    STA $0074  [$7E:0074]  ;|
$88:A5D6 BF 86 8D 88 LDA $888D86,x[$88:8D86];|
$88:A5DA 09 40       ORA #$40               ;} Colour math subscreen backdrop colour = ([$8D85 + [X]], [$8D85 + [X] + 1], [$8D85 + [X] + 2])
$88:A5DC 8D 75 00    STA $0075  [$7E:0075]  ;|
$88:A5DF BF 87 8D 88 LDA $888D87,x[$88:8D87];|
$88:A5E3 09 80       ORA #$80               ;|
$88:A5E5 8D 76 00    STA $0076  [$7E:0076]  ;/
$88:A5E8 C2 30       REP #$30
$88:A5EA 7A          PLY
$88:A5EB FA          PLX
$88:A5EC AD EA 0C    LDA $0CEA  [$7E:0CEA]  ;\
$88:A5EF 18          CLC                    ;|
$88:A5F0 6D F0 0C    ADC $0CF0  [$7E:0CF0]  ;} Power bomb explosion radius += [power bomb explosion radius speed]
$88:A5F3 8D EA 0C    STA $0CEA  [$7E:0CEA]  ;/
$88:A5F6 C9 00 20    CMP #$2000             ;\
$88:A5F9 90 12       BCC $12    [$A60D]     ;} If [power bomb explosion radius] >= 2000h:
$88:A5FB A9 01 00    LDA #$0001             ;\
$88:A5FE 9D E4 18    STA $18E4,x[$7E:18E6]  ;|
$88:A601 FE CC 18    INC $18CC,x[$7E:18CE]  ;} Wake HDMA object
$88:A604 FE CC 18    INC $18CC,x[$7E:18CE]  ;|
$88:A607 9E 08 19    STZ $1908,x[$7E:190A]  ;/
$88:A60A 4C 18 A6    JMP $A618  [$88:A618]  ; Return

$88:A60D AD F0 0C    LDA $0CF0  [$7E:0CF0]  ;\
$88:A610 18          CLC                    ;|
$88:A611 6F E7 8D 88 ADC $888DE7[$88:8DE7]  ;} Power bomb explosion radius speed += 30h
$88:A615 8D F0 0C    STA $0CF0  [$7E:0CF0]  ;/

$88:A618 AB          PLB
$88:A619 28          PLP
$88:A61A 6B          RTL
}
}


;;; $A61B..B057: FX type 20h/22h: scrolling sky / unused ;;;
{
;;; $A61B: FX type 22h: unused ;;;
{
; Seems like it might have been an early version of the WS entrance scrolling sky + water
; Trying to use this FX in that room has tragic results though, and the code in its present form is a mess / broken
$88:A61B 08          PHP
$88:A61C C2 30       REP #$30
$88:A61E A9 E0 04    LDA #$04E0             ;\
$88:A621 8D 5E 19    STA $195E  [$7E:195E]  ;} FX Y position = 4E0h
$88:A624 A9 06 00    LDA #$0006             ;\
$88:A627 8D 6E 19    STA $196E  [$7E:196E]  ;} FX type = water
$88:A62A 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:A62E             dx 02, 12, AD63        ;} Spawn HDMA object for BG3 Y scroll with instruction list $AD63
$88:A632 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:A636             dx 42, 11, AD4E        ;} Spawn indirect HDMA object for BG3 X scroll with instruction list $AD4E
$88:A63A 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:A63E             dx 42, 0D, AD39        ;} Spawn indirect HDMA object for BG1 X scroll with instruction list $AD39
$88:A642 28          PLP
}


;;; $A643: Pre-instruction - FX type 22h BG3 Y scroll ;;;
{
$88:A643 C2 30       REP #$30
$88:A645 20 C4 A8    JSR $A8C4  [$88:A8C4]  ; Damage Samus if she is in the top row
$88:A648 A9 E8 A8    LDA #$A8E8             ;\
$88:A64B 85 00       STA $00    [$7E:0000]  ;|
$88:A64D A9 EA A8    LDA #$A8EA             ;|
$88:A650 85 03       STA $03    [$7E:0003]  ;|
$88:A652 A9 EC A8    LDA #$A8EC             ;|
$88:A655 85 06       STA $06    [$7E:0006]  ;} Calculate FX type 22h BG3 Y scroll HDMA table
$88:A657 A9 EE A8    LDA #$A8EE             ;|
$88:A65A 85 09       STA $09    [$7E:0009]  ;|
$88:A65C A9 4E 00    LDA #$004E             ;|
$88:A65F 85 18       STA $18    [$7E:0018]  ;|
$88:A661 20 1C A8    JSR $A81C  [$88:A81C]  ;/
$88:A664 A9 00 00    LDA #$0000             ;\
$88:A667 9F 00 9C 7E STA $7E9C00,x          ;} $7E:9C00 + [X] = 0,0
$88:A66B 6B          RTL
}


;;; $A66C: Instruction - HDMA object phase increase timer = 1 ;;;
{
$88:A66C A9 01 00    LDA #$0001             ;\
$88:A66F 9D 20 19    STA $1920,x            ;} HDMA object $1920 = 1
$88:A672 60          RTS
}


;;; $A673: Pre-instruction - FX type 22h BG3 X scroll ;;;
{
; $7E:9E02..??: FX type 22h BG3 X scroll indirect HDMA table
; $7E:9F02..??: FX type 22h BG1 X scroll indirect HDMA table
; $7E:9E80..??: FX type 22h BG3 X scroll HDMA data table

$88:A673 08          PHP
$88:A674 C2 30       REP #$30
$88:A676 8B          PHB
$88:A677 DA          PHX
$88:A678 5A          PHY
$88:A679 AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:A67C C9 00 04    CMP #$0400             ;} If [layer 1 Y position] >= 400h: go to BRANCH_WAVY
$88:A67F 10 2B       BPL $2B    [$A6AC]     ;/
$88:A681 AD B5 05    LDA $05B5  [$7E:05B5]  ;\
$88:A684 29 01 00    AND #$0001             ;} If [8-bit frame counter] % 2 = 0:
$88:A687 D0 0B       BNE $0B    [$A694]     ;/
$88:A689 AD 96 05    LDA $0596  [$7E:0596]  ;\
$88:A68C 1A          INC A                  ;|
$88:A68D 1A          INC A                  ;} $0596 = ([$0596] + 2) % 20h
$88:A68E 29 1E 00    AND #$001E             ;|
$88:A691 8D 96 05    STA $0596  [$7E:0596]  ;/

$88:A694 AC 96 05    LDY $0596  [$7E:0596]  ;\
$88:A697 A2 00 00    LDX #$0000             ;|
                                            ;|
$88:A69A B9 38 A9    LDA $A938,y            ;|
$88:A69D 9F 80 9E 7E STA $7E9E80,x          ;|
$88:A6A1 E8          INX                    ;} Copy 20h - [$0596] bytes from [$A938 + [$0596]] to $7E:9E80
$88:A6A2 E8          INX                    ;|
$88:A6A3 C8          INY                    ;|
$88:A6A4 C8          INY                    ;|
$88:A6A5 C0 20 00    CPY #$0020             ;|
$88:A6A8 30 F0       BMI $F0    [$A69A]     ;/
$88:A6AA 80 32       BRA $32    [$A6DE]     ; Go to BRANCH_MERGE

; BRANCH_WAVY
$88:A6AC DE 20 19    DEC $1920,x            ; Decrement HDMA object phase increase timer
$88:A6AF D0 11       BNE $11    [$A6C2]     ; If [HDMA object phase increase timer] = 0:
$88:A6B1 A9 06 00    LDA #$0006             ;\
$88:A6B4 9D 20 19    STA $1920,x            ;} HDMA object phase increase timer = 6
$88:A6B7 BD 14 19    LDA $1914,x            ;\
$88:A6BA 1A          INC A                  ;|
$88:A6BB 1A          INC A                  ;} HDMA object wave phase = ([HDMA object wave phase] + 2) % 20h
$88:A6BC 29 1F 00    AND #$001F             ;|
$88:A6BF 9D 14 19    STA $1914,x            ;/

$88:A6C2 BD 14 19    LDA $1914,x            ;\
$88:A6C5 AA          TAX                    ;} X = [HDMA object wave phase] (HDMA data table end index)
$88:A6C6 A0 1E 00    LDY #$001E             ; Y = 1Eh (wave displacement table index)

; LOOP_WAVY
$88:A6C9 A5 B1       LDA $B1    [$7E:00B1]  ;\
$88:A6CB 18          CLC                    ;|
$88:A6CC 79 6E C4    ADC $C46E,y            ;} $7E:9E80 + [X] = [BG1 X scroll] + [$C46E + [Y]]
$88:A6CF 9F 80 9E 7E STA $7E9E80,x          ;/
$88:A6D3 8A          TXA                    ;\
$88:A6D4 3A          DEC A                  ;|
$88:A6D5 3A          DEC A                  ;} X = ([X] - 2) % 20h (previous HDMA data table entry)
$88:A6D6 29 1F 00    AND #$001F             ;|
$88:A6D9 AA          TAX                    ;/
$88:A6DA 88          DEY                    ;\
$88:A6DB 88          DEY                    ;} Y -= 2 (previous wave displacement table entry)
$88:A6DC 10 EB       BPL $EB    [$A6C9]     ; If [Y] >= 0: go to LOOP_WAVY

; BRANCH_MERGE
$88:A6DE A9 00 00    LDA #$0000             ;\
$88:A6E1 8F 00 9E 7E STA $7E9E00[$7E:9E00]  ;} $7E:9E00 = $7E:9F00 = 0
$88:A6E5 8F 00 9F 7E STA $7E9F00[$7E:9F00]  ;/
$88:A6E9 A9 1F 00    LDA #$001F             ;\
$88:A6EC 8F 02 9E 7E STA $7E9E02[$7E:9E02]  ;|
$88:A6F0 8F 02 9F 7E STA $7E9F02[$7E:9F02]  ;|
$88:A6F4 85 12       STA $12    [$7E:0012]  ;} $7E:9E02 = $7E:9F02 = 1Fh,$9E00
$88:A6F6 A9 00 9E    LDA #$9E00             ;} $12 = 1Fh (Y position on screen)
$88:A6F9 8F 03 9E 7E STA $7E9E03[$7E:9E03]  ;|
$88:A6FD 8F 03 9F 7E STA $7E9F03[$7E:9F03]  ;/
$88:A701 AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:A704 C9 00 04    CMP #$0400             ;} If [layer 1 Y position] >= 400h:
$88:A707 30 0F       BMI $0F    [$A718]     ;/
$88:A709 A9 B1 00    LDA #$00B1             ;\
$88:A70C 85 14       STA $14    [$7E:0014]  ;} $14 = BG1 X scroll
$88:A70E 64 16       STZ $16    [$7E:0016]  ; $16 = 0 (single HDMA data entry)
$88:A710 A2 05 01    LDX #$0105             ; X = 100h + 5 (BG1 X scroll indirect HDMA table index)
$88:A713 20 86 A7    JSR $A786  [$88:A786]  ; Calculate FX type 22h indirect HDMA table
$88:A716 80 07       BRA $07    [$A71F]

$88:A718 A9 00 00    LDA #$0000             ;\ Else ([layer 1 Y position] < 400h):
$88:A71B 8F 02 9F 7E STA $7E9F02[$7E:9F02]  ;} $7E:9F02 = 0,0

$88:A71F A2 05 00    LDX #$0005             ; X = 5 (BG3 X scroll indirect HDMA table index)
$88:A722 A9 80 9E    LDA #$9E80             ;\
$88:A725 85 14       STA $14    [$7E:0014]  ;} $14 = $9E80 (BG3 X scroll HDMA data table)
$88:A727 A9 80 00    LDA #$0080             ;\
$88:A72A 85 16       STA $16    [$7E:0016]  ;} $16 = 80h (multi-entry HDMA data table)
$88:A72C 20 86 A7    JSR $A786  [$88:A786]  ; Calculate FX type 22h indirect HDMA table
$88:A72F A9 E0 00    LDA #$00E0             ;\
$88:A732 38          SEC                    ;|
$88:A733 E5 12       SBC $12    [$7E:0012]  ;} Y = E0h - [$12] (number of scanlines remaining on screen)
$88:A735 A8          TAY                    ;/

; LOOP_PAD
$88:A736 98          TYA                    ;\
$88:A737 38          SEC                    ;|
$88:A738 E9 10 00    SBC #$0010             ;} If [Y] >= 10h:
$88:A73B 30 1C       BMI $1C    [$A759]     ;/
$88:A73D A8          TAY                    ; Y -= 10h
$88:A73E A9 90 00    LDA #$0090             ;\
$88:A741 9F 00 9E 7E STA $7E9E00,x          ;|
$88:A745 9F 00 9F 7E STA $7E9F00,x          ;|
$88:A749 A9 80 9E    LDA #$9E80             ;} $7E:9E00 + [X] = $7E:9F00 + [X] = 90h,$9E80
$88:A74C 9F 01 9E 7E STA $7E9E01,x          ;|
$88:A750 9F 01 9F 7E STA $7E9F01,x          ;/
$88:A754 E8          INX                    ;\
$88:A755 E8          INX                    ;} X += 3 (next HDMA table entry)
$88:A756 E8          INX                    ;/
$88:A757 80 DD       BRA $DD    [$A736]     ; Go to LOOP_PAD

$88:A759 98          TYA                    ; A = [Y]
$88:A75A C9 00 00    CMP #$0000             ;\
$88:A75D F0 04       BEQ $04    [$A763]     ;} If [A] != 0:
$88:A75F 18          CLC                    ;\
$88:A760 69 80 00    ADC #$0080             ;} A += 80h

$88:A763 9F 00 9E 7E STA $7E9E00,x          ;\
$88:A767 9F 00 9F 7E STA $7E9F00,x          ;|
$88:A76B A9 80 9E    LDA #$9E80             ;} $7E:9E00 + [X] = $7E:9F00 + [X] = [A],$9E80
$88:A76E 9F 01 9E 7E STA $7E9E01,x          ;|
$88:A772 9F 01 9F 7E STA $7E9F01,x          ;/
$88:A776 A9 00 00    LDA #$0000             ;\
$88:A779 9F 03 9E 7E STA $7E9E03,x          ;} $7E:9E00 + [X] + 3 = $7E:9F00 + [X] + 3 = 0,0
$88:A77D 9F 03 9F 7E STA $7E9F03,x          ;/
$88:A781 7A          PLY
$88:A782 FA          PLX
$88:A783 AB          PLB
$88:A784 28          PLP
$88:A785 6B          RTL
}


;;; $A786: Calculate FX type 22h indirect HDMA table ;;;
{
;; Parameters:
;;     X: HDMA table index. If 5, writes to BG3 X scroll HDMA table. If 105h, writes to BG1 X scroll HDMA table
;;     $12: Y position on screen
;;     $14: HDMA data pointer
;;     $16: HDMA consecutive data flag. If 0, $14 points to one value used for many scanlines. If 80h, $14 points to consecutive values used for consecutive scanlines
;; Returns:
;;     X: HDMA table index
;;     $12: Y position on screen

; If [$16] = 0:
;     Set all scanlines to use HDMA data entry [$14] until (at most) layer 1 Y position 4DFh
; If [$16] = 80h:
;     If layer 1 Y position 4DFh is within 80h pixels of the HUD:
;         Set up to 7Fh scanlines to use HDMA data table [$14] until layer 1 Y position 4DFh
;     Else:
;         Set 10h scanline strips to use HDMA data table [$14] until the bottom of the screen

; (In the following calculations, 1Fh is the HUD height)

$88:A786 A9 C0 04    LDA #$04C0             ;\
$88:A789 38          SEC                    ;|
$88:A78A ED 15 09    SBC $0915  [$7E:0915]  ;} $18 = 4DFh - ([layer 1 Y position] + 1Fh)
$88:A78D 85 18       STA $18    [$7E:0018]  ;/
$88:A78F 30 46       BMI $46    [$A7D7]     ;\
$88:A791 F0 44       BEQ $44    [$A7D7]     ;} If [layer 1 Y position] + 1Fh >= 4DFh: return
$88:A793 C9 80 00    CMP #$0080             ;\
$88:A796 30 2C       BMI $2C    [$A7C4]     ;} If 4DFh - ([layer 1 Y position] + 1Fh) < 80h: go to BRANCH_ONLY_ONE_ENTRY_NEEDED
$88:A798 85 12       STA $12    [$7E:0012]
$88:A79A C9 C1 00    CMP #$00C1             ;\
$88:A79D 30 03       BMI $03    [$A7A2]     ;|
$88:A79F A9 C1 00    LDA #$00C1             ;} $12 = min(E0h - 1Fh, 4DFh - ([layer 1 Y position] + 1Fh))
                                            ;|
$88:A7A2 85 12       STA $12    [$7E:0012]  ;/
$88:A7A4 85 18       STA $18    [$7E:0018]  ; $18 = [$12] (remaining scanline counter)

; LOOP
$88:A7A6 38          SEC                    ;\
$88:A7A7 E9 10 00    SBC #$0010             ;} If [$18] < 10h: go to BRANCH_DONE
$88:A7AA 30 1A       BMI $1A    [$A7C6]     ;/
$88:A7AC 85 18       STA $18    [$7E:0018]  ; $18 -= 10h
$88:A7AE A9 10 00    LDA #$0010             ;\
$88:A7B1 05 16       ORA $16    [$7E:0016]  ;|
$88:A7B3 9F 00 9E 7E STA $7E9E00,x          ;} $7E:9E00 + [X] = 10h | [$16], [$14]
$88:A7B7 A5 14       LDA $14    [$7E:0014]  ;|
$88:A7B9 9F 01 9E 7E STA $7E9E01,x          ;/
$88:A7BD A5 18       LDA $18    [$7E:0018]
$88:A7BF E8          INX                    ;\
$88:A7C0 E8          INX                    ;} X += 3 (next HDMA table entry)
$88:A7C1 E8          INX                    ;/
$88:A7C2 80 E2       BRA $E2    [$A7A6]     ; Go to LOOP

; BRANCH_ONLY_ONE_ENTRY_NEEDED
$88:A7C4 85 12       STA $12    [$7E:0012]  ; $12 = 4DFh - ([layer 1 Y position] + 1Fh)

; BRANCH_DONE
$88:A7C6 A5 18       LDA $18    [$7E:0018]  ;\
$88:A7C8 05 16       ORA $16    [$7E:0016]  ;|
$88:A7CA 9F 00 9E 7E STA $7E9E00,x          ;} $7E:9E00 + [X] = [$18] | [$16], [$14]
$88:A7CE A5 14       LDA $14    [$7E:0014]  ;|
$88:A7D0 9F 01 9E 7E STA $7E9E01,x          ;/
$88:A7D4 E8          INX                    ;\
$88:A7D5 E8          INX                    ;} X += 3 (next HDMA table entry)
$88:A7D6 E8          INX                    ;/

$88:A7D7 60          RTS
}


;;; $A7D8: FX type 20h: scrolling sky / room setup ASM: scrolling sky land ;;;
{
$88:A7D8 08          PHP
$88:A7D9 E2 30       SEP #$30
$88:A7DB AD 1B 09    LDA $091B  [$7E:091B]  ;\
$88:A7DE 09 01       ORA #$01               ;|
$88:A7E0 8D 1B 09    STA $091B  [$7E:091B]  ;|
$88:A7E3 AD 1C 09    LDA $091C  [$7E:091C]  ;} Use library background
$88:A7E6 09 01       ORA #$01               ;|
$88:A7E8 8D 1C 09    STA $091C  [$7E:091C]  ;/
$88:A7EB 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:A7EF             dx  42, 0F, AD76       ;} Spawn indirect HDMA object for BG2 X scroll with instruction list $AD76
$88:A7F3 C2 30       REP #$30
$88:A7F5 A9 E0 00    LDA #$00E0             ;\
$88:A7F8 8D 9A 05    STA $059A  [$7E:059A]  ;} $059A = E0h
$88:A7FB 9C 9C 05    STZ $059C  [$7E:059C]  ; $059C = 0
$88:A7FE 28          PLP
$88:A7FF 6B          RTL
}


;;; $A800: Room setup ASM: scrolling sky ocean ;;;
{
$88:A800 08          PHP
$88:A801 E2 30       SEP #$30
$88:A803 A9 4A       LDA #$4A               ;\
$88:A805 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4800, size = 32x64
$88:A807 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:A80B             dx  42, 0F, AD89       ;} Spawn indirect HDMA object for BG2 X scroll with instruction list $AD89
$88:A80F C2 30       REP #$30
$88:A811 A9 E0 00    LDA #$00E0             ;\
$88:A814 8D 9A 05    STA $059A  [$7E:059A]  ;} $059A = E0h
$88:A817 9C 9C 05    STZ $059C  [$7E:059C]  ; $059C = 0
$88:A81A 28          PLP
$88:A81B 6B          RTL
}


;;; $A81C: Calculate FX type 22h BG3 Y scroll HDMA table ;;;
{
;; Parameters:
;;     $00: $A8E8. Base address of section top positions
;;     $03: $A8EA. Base address of strip heights
;;     $06: $A8EC. Base address of BG3 tilemap Y positions
;;     $09: $A8EE. Base address of section bottom positions
;;     $18: 4Eh. Table size (13 entries of 6 bytes)
;; Returns:
;;     X: HDMA table index

$88:A81C 8B          PHB
$88:A81D 4B          PHK                    ;\
$88:A81E AB          PLB                    ;} DB = $88
$88:A81F A9 20 00    LDA #$0020             ;\
$88:A822 8D 98 05    STA $0598  [$7E:0598]  ;} $0598 = 20h (Y position on screen)
$88:A825 3A          DEC A                  ;\
$88:A826 8F 00 9C 7E STA $7E9C00[$7E:9C00]  ;|
$88:A82A A9 00 00    LDA #$0000             ;} $7E:9C00 = 1Fh,0000h (HDMA table HUD scanlines)
$88:A82D 8F 01 9C 7E STA $7E9C01[$7E:9C01]  ;/
$88:A831 A2 03 00    LDX #$0003             ; X = 3 (HDMA table index)
$88:A834 AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:A837 18          CLC                    ;|
$88:A838 6D 98 05    ADC $0598  [$7E:0598]  ;} $12 = [layer 1 Y position] + (Y position on screen) (Y position)
$88:A83B 85 12       STA $12    [$7E:0012]  ;/
$88:A83D A0 00 00    LDY #$0000             ; Y = 0

; LOOP_FIRST_STRIP
$88:A840 D1 00       CMP ($00),y            ;\
$88:A842 30 04       BMI $04    [$A848]     ;|
$88:A844 D1 09       CMP ($09),y            ;} If [$A8E8 + [Y]] <= (Y position) < [$A8E8 + [Y] + 6]: go to BRANCH_FOUND_FIRST_STRIP
$88:A846 30 0C       BMI $0C    [$A854]     ;/

$88:A848 C8          INY                    ;\
$88:A849 C8          INY                    ;|
$88:A84A C8          INY                    ;|
$88:A84B C8          INY                    ;} Y += 6
$88:A84C C8          INY                    ;|
$88:A84D C8          INY                    ;/
$88:A84E C4 18       CPY $18    [$7E:0018]  ;\
$88:A850 30 EE       BMI $EE    [$A840]     ;} If [Y] < 4Eh: go to LOOP_FIRST_STRIP
$88:A852 AB          PLB
$88:A853 60          RTS                    ; Return

; BRANCH_FOUND_FIRST_STRIP
$88:A854 A5 12       LDA $12    [$7E:0012]  ;\
$88:A856 C9 E0 04    CMP #$04E0             ;} If (Y position) >= 4E0h:
$88:A859 30 05       BMI $05    [$A860]     ;/
$88:A85B 29 1F 00    AND #$001F             ; A = (Y position) % 20h
$88:A85E 80 03       BRA $03    [$A863]
                                            ; Else ((Y position) < 4E0h):
$88:A860 29 0F 00    AND #$000F             ; A = (Y position) % 10h

$88:A863 85 16       STA $16    [$7E:0016]  ; $16 = [A] (offset into the strip)
$88:A865 B1 03       LDA ($03),y            ;\
$88:A867 38          SEC                    ;|
$88:A868 E5 16       SBC $16    [$7E:0016]  ;} $7E:9C00 + [X] = [$A8E8 + [Y] + 2] - (offset into the strip)
$88:A86A 9F 00 9C 7E STA $7E9C00,x          ;/
$88:A86E B1 06       LDA ($06),y            ;\
$88:A870 18          CLC                    ;|
$88:A871 65 16       ADC $16    [$7E:0016]  ;|
$88:A873 38          SEC                    ;} $7E:9C00 + [X] + 1 = [$A8E8 + [Y] + 4] + (offset into the strip) - (Y position on screen)
$88:A874 ED 98 05    SBC $0598  [$7E:0598]  ;|
$88:A877 9F 01 9C 7E STA $7E9C01,x          ;/
$88:A87B 80 26       BRA $26    [$A8A3]     ; Go to BRANCH_NEXT

; LOOP_HDMA_TABLE
$88:A87D A5 12       LDA $12    [$7E:0012]

; LOOP_STRIP
$88:A87F D1 00       CMP ($00),y            ;\
$88:A881 30 04       BMI $04    [$A887]     ;|
$88:A883 D1 09       CMP ($09),y            ;} If [$A8E8 + [Y]] <= (Y position) < [$A8E8 + [Y] + 6]: go to BRANCH_FOUND_STRIP
$88:A885 30 0C       BMI $0C    [$A893]     ;/

$88:A887 C8          INY                    ;\
$88:A888 C8          INY                    ;|
$88:A889 C8          INY                    ;|
$88:A88A C8          INY                    ;} Y += 6
$88:A88B C8          INY                    ;|
$88:A88C C8          INY                    ;/
$88:A88D C4 18       CPY $18    [$7E:0018]  ;\
$88:A88F 30 EE       BMI $EE    [$A87F]     ;} If [Y] < 4Eh: go to LOOP_STRIP
$88:A891 AB          PLB
$88:A892 60          RTS                    ; Return

; BRANCH_FOUND_STRIP
$88:A893 B1 03       LDA ($03),y            ;\
$88:A895 9F 00 9C 7E STA $7E9C00,x          ;} $7E:9C00 + [X] = [$A8E8 + [Y] + 2]
$88:A899 B1 06       LDA ($06),y            ;\
$88:A89B 38          SEC                    ;|
$88:A89C ED 98 05    SBC $0598  [$7E:0598]  ;} $7E:9C00 + [X] + 1 = [$A8E8 + [Y] + 4] - (Y position on screen)
$88:A89F 9F 01 9C 7E STA $7E9C01,x          ;/

; BRANCH_NEXT
$88:A8A3 BF 00 9C 7E LDA $7E9C00,x          ;\
$88:A8A7 29 FF 00    AND #$00FF             ;} $14 = [$7E:9C00 + [X]]
$88:A8AA 85 14       STA $14    [$7E:0014]  ;/
$88:A8AC 18          CLC                    ;\
$88:A8AD 65 12       ADC $12    [$7E:0012]  ;} (Y position) += [$14]
$88:A8AF 85 12       STA $12    [$7E:0012]  ;/
$88:A8B1 E8          INX                    ;\
$88:A8B2 E8          INX                    ;} X += 3 (next HDMA table index)
$88:A8B3 E8          INX                    ;/
$88:A8B4 A5 14       LDA $14    [$7E:0014]  ;\
$88:A8B6 18          CLC                    ;|
$88:A8B7 6D 98 05    ADC $0598  [$7E:0598]  ;} (Y position on screen) += [$14]
$88:A8BA 8D 98 05    STA $0598  [$7E:0598]  ;/
$88:A8BD C9 E0 00    CMP #$00E0             ;\
$88:A8C0 30 BB       BMI $BB    [$A87D]     ;} If (Y position on screen) < E0h: go to LOOP_HDMA_TABLE
$88:A8C2 AB          PLB
$88:A8C3 60          RTS
}


;;; $A8C4: Damage Samus if she is in the top row ;;;
{
$88:A8C4 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$88:A8C7 38          SEC                    ;|
$88:A8C8 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$88:A8CB 30 06       BMI $06    [$A8D3]     ;} If (Samus top boundary) > 10h:
$88:A8CD C9 11 00    CMP #$0011             ;|
$88:A8D0 30 01       BMI $01    [$A8D3]     ;/
$88:A8D2 60          RTS                    ; Return

$88:A8D3 A9 08 00    LDA #$0008             ;\
$88:A8D6 8D 50 0A    STA $0A50  [$7E:0A50]  ;} Deal 8 damage to Samus
$88:A8D9 60          RTS
}


;;; $A8DA: Unused table ;;;
{
; Looks like the format of the $A8E8 table

$88:A8DA             dw 0000,0010,0020,
                        0020,0010,0030,
                        0040
}


;;; $A8E8: FX type 22h repeating BG3 strips table ;;;
{
; This table defines sections of repeating strips of BG3

;                        _____________ Section top position
;                       |     ________ Strip height
;                       |    |     ___ BG3 tilemap Y position
;                       |    |    |
$88:A8E8             dw 0000,0010,0020,
                        0030,0010,0030,
                        0040,0010,0040,
                        0300,0010,0050,
                        0310,0010,0060,
                        0330,0010,0070,
                        0340,0010,0080,
                        03A0,0010,0090,
                        03B0,0010,00A0,
                        03D0,0010,00B0,
                        03E0,0010,00C0,
                        04E0,0020,00D0,
                        0500,0020,00F0,
                        0600
}


;;; $A938: FX type 22h BG3 X scroll HDMA data ;;;
{
; Looks like only the first line is used (see $88:A673)
$88:A938             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:A958             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:A978             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:A998             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:A9B8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:A9D8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:A9F8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AA18             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AA38             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AA58             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AA78             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AA98             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AAB8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AAD8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AAF8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AB18             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AB38             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AB58             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AB78             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AB98             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:ABB8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:ABD8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:ABF8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AC18             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AC38             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AC58             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AC78             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AC98             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:ACB8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:ACD8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:ACF8             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
$88:AD18             dw 0000,0001,0002,0003,0003,0002,0001,0000,0000,FFFF,FFFE,FFFD,FFFD,FFFE,FFFF,0000
}


;;; $AD38: RTL. Pre-instruction - FX type 22h BG1 X scroll ;;;
{
$88:AD38 6B          RTL
}


;;; $AD39: Instruction list - FX type 22h BG1 X scroll ;;;
{
$88:AD39             dx 8655,7E,    ; HDMA table bank = $7E
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        A66C,       ; HDMA object $1920 = 1
                        8570,88AD38,; Pre-instruction = RTL
$88:AD46             dx 7000,9F02,
                        85EC,AD46   ; Go to $AD46
}


;;; $AD4E: Instruction list - FX type 22h BG3 X scroll ;;;
{
$88:AD4E             dx 8655,7E,    ; HDMA table bank = $7E
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        A66C,       ; HDMA object phase increase timer = 1
                        8570,88A673 ; Pre-instruction = $88:A673
$88:AD5B             dx 7000,9E02,
                        85EC,AD5B   ; Go to $AD5B
}


;;; $AD63: Instruction list - FX type 22h BG3 Y scroll ;;;
{
$88:AD63             dx 8655,7E,    ; HDMA table bank = $7E
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,88A643,; Pre-instruction = $88:A643
$88:AD6E             dx 7000,9C00,
                        85EC,AD6E   ; Go to $AD6E
}


;;; $AD76: Instruction list - scrolling sky land BG2 X scroll ;;;
{
$88:AD76             dx 8655,7E,    ; HDMA table bank = $7E
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,88ADB2 ; Pre-instruction = $88:ADB2
$88:AD81             dx 7000,9F00,
                        85EC,AD81   ; Go to $AD81
}


;;; $AD89: Instruction list - scrolling sky ocean BG2 X scroll ;;;
{
$88:AD89             dx 8655,7E,    ; HDMA table bank = $7E
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,88ADBA ; Pre-instruction = $88:ADBA
$88:AD94             dx 7000,9F00,
                        85EC,AD94   ; Go to $AD94
}


;;; $AD9C: Scrolling sky land chunk pointers ;;;
{
$88:AD9C             dw B180, B980, C180, C980, D180
}


;;; $ADA6: Scrolling sky ocean chunk pointers ;;;
{
$88:ADA6             dw B180, B980, C180, C980, D980, E180
}


;;; $ADB2: Pre-instruction - scrolling sky land BG2 X scroll ;;;
{
$88:ADB2 C2 30       REP #$30
$88:ADB4 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:ADB7 F0 09       BEQ $09    [$ADC2]     ;} If time is not frozen: go to handle scrolling sky BG2 X scroll HDMA tables
$88:ADB9 6B          RTL
}


;;; $ADBA: Pre-instruction - scrolling sky ocean BG2 X scroll ;;;
{
$88:ADBA C2 30       REP #$30
$88:ADBC AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:ADBF F0 01       BEQ $01    [$ADC2]     ;} If time is not frozen: go to handle scrolling sky BG2 X scroll HDMA tables
$88:ADC1 6B          RTL
}


;;; $ADC2: Handle scrolling sky BG2 X scroll HDMA tables ;;;
{
; The $059E HDMA data entry pointer used at $AE05 I low-key suspect should be $059C,
; which is explicitly set to zero in room setup ASM and otherwise unused,
; unlike $059E which is never set (but is also otherwise unused)
$88:ADC2 E2 30       SEP #$30
$88:ADC4 A9 4A       LDA #$4A               ;\
$88:ADC6 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4800, size = 32x64
$88:ADC8 C2 30       REP #$30
$88:ADCA A0 00 00    LDY #$0000             ; Y = 0 (scrolling sky scroll table index)

; LOOP_DATA_TABLE
$88:ADCD B9 C7 AE    LDA $AEC7,y[$88:AEC7]  ;\
$88:ADD0 AA          TAX                    ;} X = [$AEC1 + [Y] + 6] (HDMA data table index)
$88:ADD1 B9 C3 AE    LDA $AEC3,y[$88:AEC3]  ;\
$88:ADD4 18          CLC                    ;|
$88:ADD5 7F 00 00 7E ADC $7E0000,x[$7E:9F80];} $7E:0000 + [X] += [$AEC1 + [Y] + 2] (scroll subspeed)
$88:ADD9 9F 00 00 7E STA $7E0000,x[$7E:9F80];/
$88:ADDD B9 C5 AE    LDA $AEC5,y[$88:AEC5]  ;\
$88:ADE0 7F 02 00 7E ADC $7E0002,x[$7E:9F82];} $7E:0000 + [X] + 2 += [$AEC1 + [Y] + 4] (scroll speed)
$88:ADE4 9F 02 00 7E STA $7E0002,x[$7E:9F82];/
$88:ADE8 98          TYA                    ;\
$88:ADE9 18          CLC                    ;|
$88:ADEA 69 08 00    ADC #$0008             ;} Y += 8 (next scrolling sky scroll table entry)
$88:ADED A8          TAY                    ;|
$88:ADEE C9 B8 00    CMP #$00B8             ;/
$88:ADF1 30 DA       BMI $DA    [$ADCD]     ; If [Y] < B8h: go to LOOP_DATA_TABLE
$88:ADF3 A9 00 00    LDA #$0000             ;\
$88:ADF6 8F D8 9F 7E STA $7E9FD8[$7E:9FD8]  ;} $7E:9FD8 = 0 (last data table subspeed entry)
$88:ADFA 8F DA 9F 7E STA $7E9FDA[$7E:9FDA]  ; $7E:9FDA = 0 (last data table speed entry)
$88:ADFE A9 1F 00    LDA #$001F             ;\
$88:AE01 8F 00 9F 7E STA $7E9F00[$7E:9F00]  ;|
$88:AE05 A9 9E 05    LDA #$059E             ;} $7E:9F00 = 1Fh,$059E (first indirect HDMA table entry)
$88:AE08 8F 01 9F 7E STA $7E9F01[$7E:9F01]  ;/
$88:AE0C AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:AE0F 18          CLC                    ;|
$88:AE10 69 20 00    ADC #$0020             ;} $12 = [layer 1 Y position] + 20h (first line after HUD, used as current line)
$88:AE13 85 12       STA $12    [$7E:0012]  ;/
$88:AE15 18          CLC                    ;\
$88:AE16 69 C0 00    ADC #$00C0             ;} $14 = [layer 1 Y position] + E0h (last line)
$88:AE19 85 14       STA $14    [$7E:0014]  ;/
$88:AE1B A0 00 00    LDY #$0000             ; Y = 0 (scrolling sky scrolling table index)
$88:AE1E A2 03 00    LDX #$0003             ; X = 3 (indirect HDMA table index)

; LOOP_INDIRECT_TABLE
$88:AE21 A5 12       LDA $12    [$7E:0012]  ;\
$88:AE23 D9 C1 AE    CMP $AEC1,y[$88:AEC1]  ;} If (current line) >= [$AEC1 + [Y]]:
$88:AE26 30 05       BMI $05    [$AE2D]     ;/
$88:AE28 D9 C9 AE    CMP $AEC9,y[$88:AEC9]  ;\
$88:AE2B 30 44       BMI $44    [$AE71]     ;} If (current line) < [$AEC1 + [Y] + 8]: go to BRANCH_SCROLLING_SECTION

$88:AE2D 98          TYA                    ;\
$88:AE2E 18          CLC                    ;|
$88:AE2F 69 08 00    ADC #$0008             ;} Y += 8 (next scrolling sky scroll table entry)
$88:AE32 A8          TAY                    ;/
$88:AE33 C9 B8 00    CMP #$00B8             ;\
$88:AE36 30 E9       BMI $E9    [$AE21]     ;} If [Y] < B8h: go to LOOP_INDIRECT_TABLE
$88:AE38 A9 FF 05    LDA #$05FF             ;\
$88:AE3B 38          SEC                    ;} A = 5FFh - (current line)
$88:AE3C E5 12       SBC $12    [$7E:0012]  ;/

; LOOP_NON_SCROLLING_SECTION
$88:AE3E 85 18       STA $18    [$7E:0018]  ; $18 = [A] (scrolling section height)
$88:AE40 C9 80 00    CMP #$0080             ;\
$88:AE43 30 19       BMI $19    [$AE5E]     ;} If scrolling section height >= 80h:
$88:AE45 A9 7F 00    LDA #$007F             ;\
$88:AE48 9F 00 9F 7E STA $7E9F00,x[$7E:9F15];|
$88:AE4C A9 B5 00    LDA #$00B5             ;} $7E:9F00 + [X] = 7Fh,(BG2 X scroll)
$88:AE4F 9F 01 9F 7E STA $7E9F01,x[$7E:9F16];/
$88:AE53 E8          INX                    ;\
$88:AE54 E8          INX                    ;} X += 3
$88:AE55 E8          INX                    ;/
$88:AE56 A5 18       LDA $18    [$7E:0018]  ;\
$88:AE58 38          SEC                    ;} A -= 7Fh
$88:AE59 E9 7F 00    SBC #$007F             ;/
$88:AE5C 80 E0       BRA $E0    [$AE3E]     ; Go to LOOP_NON_SCROLLING_SECTION

$88:AE5E 9F 00 9F 7E STA $7E9F00,x[$7E:9F1B];\
$88:AE62 A9 B5 00    LDA #$00B5             ;|
$88:AE65 9F 01 9F 7E STA $7E9F01,x[$7E:9F1C];} $7E:9F00 + [X] = [$18],(BG2 X scroll), 00h
$88:AE69 A9 00 00    LDA #$0000             ;|
$88:AE6C 9F 03 9F 7E STA $7E9F03,x[$7E:9F1E];/
$88:AE70 6B          RTL                    ; Return

; BRANCH_SCROLLING_SECTION
$88:AE71 B9 C9 AE    LDA $AEC9,y[$88:AED1]  ;\
$88:AE74 38          SEC                    ;|
$88:AE75 E5 12       SBC $12    [$7E:0012]  ;} A = $18 = [$AEC1 + [Y] + 8] - (current line) (scrolling section height)
$88:AE77 85 18       STA $18    [$7E:0018]  ;/
$88:AE79 C9 80 00    CMP #$0080             ;\
$88:AE7C 30 19       BMI $19    [$AE97]     ;} If scrolling section height >= 80h:
$88:AE7E A9 7F 00    LDA #$007F             ;\
$88:AE81 9F 00 9F 7E STA $7E9F00,x[$7E:9F06];|
$88:AE85 B9 C7 AE    LDA $AEC7,y[$88:AED7]  ;|
$88:AE88 1A          INC A                  ;} $7E:9F00 + [X] = 7Fh,[$AEC1 + [Y] + 6] + 2
$88:AE89 1A          INC A                  ;|
$88:AE8A 9F 01 9F 7E STA $7E9F01,x[$7E:9F07];/
$88:AE8E E8          INX                    ;\
$88:AE8F E8          INX                    ;} X += 3
$88:AE90 E8          INX                    ;/
$88:AE91 A5 18       LDA $18    [$7E:0018]  ;\
$88:AE93 38          SEC                    ;} A = scrolling section height - 7Fh
$88:AE94 E9 7F 00    SBC #$007F             ;/

$88:AE97 9F 00 9F 7E STA $7E9F00,x[$7E:9F03];\
$88:AE9B B9 C7 AE    LDA $AEC7,y[$88:AECF]  ;|
$88:AE9E 18          CLC                    ;} $7E:9F00 + [X] = [A],[$AEC1 + [Y] + 6] + 2
$88:AE9F 69 02 00    ADC #$0002             ;|
$88:AEA2 9F 01 9F 7E STA $7E9F01,x[$7E:9F04];/
$88:AEA6 A5 18       LDA $18    [$7E:0018]  ;\
$88:AEA8 18          CLC                    ;|
$88:AEA9 65 12       ADC $12    [$7E:0012]  ;} Current line += scrolling section height
$88:AEAB 85 12       STA $12    [$7E:0012]  ;/
$88:AEAD E8          INX                    ;\
$88:AEAE E8          INX                    ;} X += 3
$88:AEAF E8          INX                    ;/
$88:AEB0 A5 12       LDA $12    [$7E:0012]  ;\
$88:AEB2 C5 14       CMP $14    [$7E:0014]  ;} If (current line) < (last line):
$88:AEB4 10 03       BPL $03    [$AEB9]     ;/
$88:AEB6 4C 21 AE    JMP $AE21  [$88:AE21]  ; Go to LOOP_INDIRECT_TABLE

$88:AEB9 A9 00 00    LDA #$0000             ;\
$88:AEBC 9F 03 9F 7E STA $7E9F03,x[$7E:9F15];} $7E:9F00 + [X] + 3 = 0 (terminate HDMA table)
$88:AEC0 6B          RTL

; Scrolling sky scroll table
;                        ________________ Top position of scrolling section
;                       |     ___________ Scroll subspeed
;                       |    |     ______ Scroll speed
;                       |    |    |     _ Pointer to HDMA data table entry
;                       |    |    |    |
$88:AEC1             dw 0000,8000,0000,9F80,
                        0010,C000,0000,9F84,
                        0038,8000,0000,9F88,
                        00D0,C000,0000,9F8C,
                        00E0,8000,0000,9F90,
                        0120,C000,0000,9F94,
                        01A0,8000,0000,9F98,
                        01D8,C000,0000,9F9C,
                        0238,8000,0000,9FA0,
                        0268,C000,0000,9FA4,
                        02A0,8000,0000,9FA8,
                        02E0,C000,0000,9FA0,
                        0300,8000,0000,9FB0,
                        0320,C000,0000,9FB4,
                        0350,8000,0000,9FB8,
                        0378,C000,0000,9FBC,
                        03C8,8000,0000,9FC0,
                        0440,7000,0000,9FC4,
                        0460,C000,0000,9FC8,
                        0480,8000,0000,9FCC,
                        0490,0000,0000,9FD0,
                        04A8,0000,0000,9FD4,
                        04B8,0000,0000,9FD8,
                        0500

; Unused continuation
$88:AF7B             dw 0500,0000,0000,9FDC,
                        0578,0000,0000,9FE0,
                        05F0
}


;;; $AF8D: Room main ASM - scrolling sky land ;;;
{
$88:AF8D A9 9C AD    LDA #$AD9C             ;\
$88:AF90 85 00       STA $00    [$7E:0000]  ;|
$88:AF92 A9 88 00    LDA #$0088             ;} $00 = $88:AD9C
$88:AF95 85 02       STA $02    [$7E:0002]  ;/
$88:AF97 80 0A       BRA $0A    [$AFA3]     ; Go to room main ASM - scrolling sky
}


;;; $AF99: Room main ASM - scrolling sky ocean ;;;
{
$88:AF99 A9 A6 AD    LDA #$ADA6             ;\
$88:AF9C 85 00       STA $00    [$7E:0000]  ;|
$88:AF9E A9 88 00    LDA #$0088             ;} $00 = $88:ADA6
$88:AFA1 85 02       STA $02    [$7E:0002]  ;/
}


;;; $AFA3: Room main ASM - scrolling sky ;;;
{
;; Parameters:
;;     $00: Address of scrolling sky chunk pointers

; The scrolling sky tilemap is divided into 800h byte chunks, the entire scrolling sky background is 7 scrolls high and it loaded from $8A:B180..E97F.
; The landing site scrolling sky uses the first 5 scrolls only;
; the ocean part of the background is actually stored starting from $8A:D980, which is the 6th scroll into the tilemap.
; So what happens for the ocean rooms is the 5th scroll is skipped and first 4 scrolls and the last 2 scrolls are spliced together.

; This routine handles the updating of the scrolling sky tilemap (inc. the splicing, which is done indirectly via the table of chunk pointers pointed to by $00).
; It does this by adding four entries to the VRAM write table, one for each 20h tile row (40h bytes or 20h words), every frame.
; The updated rows are the first two rows below the screen (entry 2 and 3) and the last two rows behind the HUD (entry 0 and 1).

; Notes on the calculations:
;     The VRAM write table entry size is (number of tiles in a row) * (size of a tilemap tile) = 20h * 2 = 40h bytes
;     The VRAM write table entry source address is calculated in two parts from the layer 1 Y position:
;         A mask is applied to the layer 1 Y position (the 7F8h), this is to clear the least significant 3 bits, which rounds the position down to the nearest tile.
;         (The fact that the upper bits are lost is irrelevant, as the land version is 5 scrolls max height and the ocean version is 6 scrolls max height).
;         The upper byte gives which row of scrolls the BG is in, which is used as an index to the provided table (in $00) as the base address of the scrolling sky 'chunk' to be loaded.
;         The lower byte (after rounding) gives the position of the row *within* the current scroll,
;         divide by 8 to get which row of tiles the BG is in, and multiply by 40h bytes (size of a tile row) to get the index *into the tilemap chunk*
;         (equivalently, multiply by 40h/8 = 8).
;     The VRAM write table entry destination address is similar to the lower byte of the source address.
;         The VRAM tilemap is 40h tiles high, or 200h pixels, so the mask (1F8h) is rounding down to the nearest tile as before, and also reducing modulo 200h pixels.
;         Divide by 8 to get which row of tiles the BG is in, and multiply by 20h words (size of a tile row) to get the index *into VRAM*
;         (equivalently, multiply by 20h/8 = 4)

$88:AFA3 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:AFA6 F0 08       BEQ $08    [$AFB0]     ;} If time is frozen:
$88:AFA8 A9 00 00    LDA #$0000             ;\
$88:AFAB 8F 00 9F 7E STA $7E9F00[$7E:9F00]  ;} Scrolling sky BG2 X scroll indirect HDMA table = 0
$88:AFAF 6B          RTL                    ; Return

$88:AFB0 C2 30       REP #$30
$88:AFB2 AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:AFB5 85 B7       STA $B7    [$7E:00B7]  ;} BG2 Y scroll = [layer 1 Y position]
$88:AFB7 AE 30 03    LDX $0330  [$7E:0330]  ; X = [VRAM write table stack pointer]
$88:AFBA A9 40 00    LDA #$0040             ;\
$88:AFBD 95 D0       STA $D0,x  [$7E:00D7]  ;} VRAM write table entry 0 size + [X] = 40h
$88:AFBF 95 D7       STA $D7,x  [$7E:00DE]  ; VRAM write table entry 1 size + [X] = 40h
$88:AFC1 95 DE       STA $DE,x  [$7E:00E5]  ; VRAM write table entry 2 size + [X] = 40h
$88:AFC3 95 E5       STA $E5,x  [$7E:00EC]  ; VRAM write table entry 3 size + [X] = 40h
$88:AFC5 AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:AFC8 29 F8 07    AND #$07F8             ;|
$88:AFCB 38          SEC                    ;} A = ([layer 1 Y position] & 7F8h) - 10h
$88:AFCC E9 10 00    SBC #$0010             ;/
$88:AFCF 48          PHA                    ;\
$88:AFD0 29 00 FF    AND #$FF00             ;|
$88:AFD3 EB          XBA                    ;|
$88:AFD4 0A          ASL A                  ;|
$88:AFD5 A8          TAY                    ;|
$88:AFD6 68          PLA                    ;|
$88:AFD7 29 FF 00    AND #$00FF             ;} VRAM write table entry 0 source address + [X] = [A low] * 8 + [[$00] + [A high] * 2]
$88:AFDA 0A          ASL A                  ;|
$88:AFDB 0A          ASL A                  ;|
$88:AFDC 0A          ASL A                  ;|
$88:AFDD 18          CLC                    ;|
$88:AFDE 77 00       ADC [$00],y[$88:AF9A]  ;|
$88:AFE0 95 D2       STA $D2,x  [$7E:00D9]  ;/
$88:AFE2 18          CLC                    ;\
$88:AFE3 69 40 00    ADC #$0040             ;} VRAM write table entry 1 source address + [X] = [VRAM write table entry 0 source address + [X]] + 40h
$88:AFE6 95 D9       STA $D9,x  [$7E:00E0]  ;/
$88:AFE8 AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:AFEB 29 F8 07    AND #$07F8             ;|
$88:AFEE 18          CLC                    ;} A = ([layer 1 Y position] & 7F8h) + F0h
$88:AFEF 69 F0 00    ADC #$00F0             ;/
$88:AFF2 48          PHA                    ;\
$88:AFF3 29 00 FF    AND #$FF00             ;|
$88:AFF6 EB          XBA                    ;|
$88:AFF7 0A          ASL A                  ;|
$88:AFF8 A8          TAY                    ;|
$88:AFF9 68          PLA                    ;|
$88:AFFA 29 FF 00    AND #$00FF             ;} VRAM write table entry 2 source address + [X] = [A low] * 8 + [[$00] + [A high] * 2]
$88:AFFD 0A          ASL A                  ;|
$88:AFFE 0A          ASL A                  ;|
$88:AFFF 0A          ASL A                  ;|
$88:B000 18          CLC                    ;|
$88:B001 77 00       ADC [$00],y[$88:AD9C]  ;|
$88:B003 95 E0       STA $E0,x  [$7E:00E7]  ;/
$88:B005 18          CLC                    ;\
$88:B006 69 40 00    ADC #$0040             ;} VRAM write table entry 3 source address + [X] = [VRAM write table entry 2 source address + [X]] + 40h
$88:B009 95 E7       STA $E7,x  [$7E:00EE]  ;/
$88:B00B E2 20       SEP #$20
$88:B00D A9 8A       LDA #$8A               ;\
$88:B00F 95 D4       STA $D4,x  [$7E:00DB]  ;} VRAM write table entry 0 source bank + [X] = $8A
$88:B011 95 DB       STA $DB,x  [$7E:00E2]  ; VRAM write table entry 1 source bank + [X] = $8A
$88:B013 95 E2       STA $E2,x  [$7E:00E9]  ; VRAM write table entry 2 source bank + [X] = $8A
$88:B015 95 E9       STA $E9,x  [$7E:00F0]  ; VRAM write table entry 3 source bank + [X] = $8A
$88:B017 C2 20       REP #$20
$88:B019 A5 59       LDA $59    [$7E:0059]  ;\
$88:B01B 29 FC 00    AND #$00FC             ;|
$88:B01E EB          XBA                    ;} $12 = BG2 tilemap base address
$88:B01F 85 12       STA $12    [$7E:0012]  ;/
$88:B021 AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:B024 38          SEC                    ;|
$88:B025 E9 10 00    SBC #$0010             ;|
$88:B028 29 F8 01    AND #$01F8             ;|
$88:B02B 0A          ASL A                  ;} VRAM write table entry 0 destination + [X] = BG2 tilemap base address + ([layer 1 Y position] - 10h & 1F8h) * 4
$88:B02C 0A          ASL A                  ;|
$88:B02D 18          CLC                    ;|
$88:B02E 65 12       ADC $12    [$7E:0012]  ;|
$88:B030 95 D5       STA $D5,x  [$7E:00DC]  ;/
$88:B032 18          CLC                    ;\
$88:B033 69 20 00    ADC #$0020             ;} VRAM write table entry 1 destination + [X] = [VRAM write table entry 0 destination + [X]] + 20h
$88:B036 95 DC       STA $DC,x  [$7E:00E3]  ;/
$88:B038 AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:B03B 18          CLC                    ;|
$88:B03C 69 F0 00    ADC #$00F0             ;|
$88:B03F 29 F8 01    AND #$01F8             ;|
$88:B042 0A          ASL A                  ;} VRAM write table entry 0 destination + [X] = BG2 tilemap base address + ([layer 1 Y position] + F0h & 1F8h) * 4
$88:B043 0A          ASL A                  ;|
$88:B044 18          CLC                    ;|
$88:B045 65 12       ADC $12    [$7E:0012]  ;|
$88:B047 95 E3       STA $E3,x  [$7E:00EA]  ;/
$88:B049 18          CLC                    ;\
$88:B04A 69 20 00    ADC #$0020             ;} VRAM write table entry 3 destination + [X] = [VRAM write table entry 2 destination + [X]] + 20h
$88:B04D 95 EA       STA $EA,x  [$7E:00F1]  ;/
$88:B04F 8A          TXA                    ;\
$88:B050 18          CLC                    ;|
$88:B051 69 1C 00    ADC #$001C             ;} VRAM write table stack pointer += 1Ch
$88:B054 8D 30 03    STA $0330  [$7E:0330]  ;/
$88:B057 6B          RTL
}
}


;;; $B058..B11D: FX type 24h: fireflea ;;;
{
;;; $B058: Fireflea flashing shades ;;;
{
; Indexed by [fireflea flashing index] * 2
$88:B058             dw 0000, 0100, 0200, 0300, 0400, 0500, 0600, 0500, 0400, 0300, 0200, 0100
}


;;; $B070: Fireflea darkness shades ;;;
{
; Indexed by [fireflea darkness level]
$88:B070             dw 0000, 0600, 0C00, 1200, 1800, 1900
}


;;; $B07C: FX type 24h: fireflea ;;;
{
; This spawns an HDMA object purely for the pre-instruction, which modifies the colour math backdrop colour
; The HDMA doesn't actually do anything
$88:B07C 08          PHP
$88:B07D C2 30       REP #$30
$88:B07F A9 06 00    LDA #$0006             ;\
$88:B082 8D 78 17    STA $1778  [$7E:1778]  ;} Fireflea flashing timer = 6
$88:B085 9C 7A 17    STZ $177A  [$7E:177A]  ; Fireflea flashing index = 0
$88:B088 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:B08C             dx 42, 11, B0AC        ;} Spawn indirect HDMA object for BG3 X scroll with instruction list $B0AC
$88:B090 A9 00 00    LDA #$0000             ;\
$88:B093 8F 00 9E 7E STA $7E9E00[$7E:9E00]  ;} $7E:9E00 = 0,0 (dummy HDMA table)
$88:B097 9C 7C 17    STZ $177C  [$7E:177C]  ; $177C = 0
$88:B09A 9C 7E 17    STZ $177E  [$7E:177E]  ; Fireflea darkness level = 0
$88:B09D A9 18 00    LDA #$0018             ;\
$88:B0A0 8D 80 17    STA $1780  [$7E:1780]  ;} $1780 = 18h
$88:B0A3 AF 58 B0 88 LDA $88B058[$88:B058]  ;\
$88:B0A7 8D 82 17    STA $1782  [$7E:1782]  ;} $1782 = 0
$88:B0AA 28          PLP
$88:B0AB 6B          RTL
}


;;; $B0AC: Instruction list - fireflea BG3 X scroll ;;;
{
$88:B0AC             dx 8655,7E,    ; HDMA table bank = $7E
                        8570,88B0BC ; Pre-instruction = $88:B0BC
$88:B0B4             dx 0001,9E00,
                        85EC,B0B4   ; Go to $B0B4
}


;;; $B0BC: Pre-instruction - fireflea BG3 X scroll ;;;
{
$88:B0BC 08          PHP
$88:B0BD C2 30       REP #$30
$88:B0BF AD 86 19    LDA $1986  [$7E:1986]  ;\
$88:B0C2 29 00 FF    AND #$FF00             ;|
$88:B0C5 09 0C 00    ORA #$000C             ;} Layer blending configuration = Ch (normal, but BG3 is disabled and colour math is subtractive)
$88:B0C8 8D 86 19    STA $1986  [$7E:1986]  ;/
$88:B0CB AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:B0CE D0 4C       BNE $4C    [$B11C]     ;} If time is frozen: return
$88:B0D0 CE 78 17    DEC $1778  [$7E:1778]  ; Decrement fireflea flashing timer
$88:B0D3 D0 22       BNE $22    [$B0F7]     ; If [fireflea flashing timer] != 0: go to BRANCH_NON_ZERO
$88:B0D5 A9 06 00    LDA #$0006             ;\
$88:B0D8 8D 78 17    STA $1778  [$7E:1778]  ;} Fireflea flashing timer = 6
$88:B0DB AD 7E 17    LDA $177E  [$7E:177E]  ;\
$88:B0DE C9 0A 00    CMP #$000A             ;} If [fireflea darkness level] >= Ah:
$88:B0E1 30 05       BMI $05    [$B0E8]     ;/
$88:B0E3 A9 06 00    LDA #$0006             ; Fireflea flashing index = 6
$88:B0E6 80 0C       BRA $0C    [$B0F4]

$88:B0E8 AD 7A 17    LDA $177A  [$7E:177A]  ;\ Else ([fireflea darkness level] < Ah):
$88:B0EB 1A          INC A                  ;} Increment fireflea flashing index
$88:B0EC C9 0C 00    CMP #$000C             ;\
$88:B0EF 90 03       BCC $03    [$B0F4]     ;} If [fireflea flashing index] >= Ch:
$88:B0F1 A9 00 00    LDA #$0000             ; Fireflea flashing index = 0

$88:B0F4 8D 7A 17    STA $177A  [$7E:177A]

; BRANCH_NON_ZERO
$88:B0F7 C2 30       REP #$30
$88:B0F9 AD 7A 17    LDA $177A  [$7E:177A]  ;\
$88:B0FC 0A          ASL A                  ;|
$88:B0FD AA          TAX                    ;|
$88:B0FE BF 58 B0 88 LDA $88B058,x[$88:B058];|
$88:B102 AE 7E 17    LDX $177E  [$7E:177E]  ;} X = ([$B070 + [fireflea darkness level]] + [$B058 + [fireflea flashing index] * 2]) / 100h
$88:B105 18          CLC                    ;|
$88:B106 7F 70 B0 88 ADC $88B070,x[$88:B070];|
$88:B10A EB          XBA                    ;|
$88:B10B AA          TAX                    ;/
$88:B10C E2 30       SEP #$30               ;\
$88:B10E 09 80       ORA #$80               ;|
$88:B110 85 75       STA $75    [$7E:0075]  ;|
$88:B112 8A          TXA                    ;|
$88:B113 09 40       ORA #$40               ;} Colour math subscreen backdrop colour = ([X], [X], [X])
$88:B115 85 76       STA $76    [$7E:0076]  ;|
$88:B117 8A          TXA                    ;|
$88:B118 09 20       ORA #$20               ;|
$88:B11A 85 74       STA $74    [$7E:0074]  ;/

$88:B11C 28          PLP
$88:B11D 6B          RTL
}
}


;;; $B11E..B21C: Unused expanding and contracting effect ;;;
{
;;; $B11E: Unused. Spawn expanding and contracting effect HDMA object ;;;
{
; Causes an expanding and contracting effect, see "expanding message box.asm"
; The RAM used here is the same as used for the message box animation,
; usage looks similar too (HDMA table of $85:8363, $05A2..A7 of $85:82B8),
; so this is not unlikely an early version of the message box animation
$88:B11E 08          PHP
$88:B11F C2 30       REP #$30
$88:B121 9C A0 05    STZ $05A0  [$7E:05A0]  ; Contracting flag = 0 (expanding)
$88:B124 9C 9A 05    STZ $059A  [$7E:059A]  ; HDMA table update counter = 0
$88:B127 A9 80 00    LDA #$0080             ;\
$88:B12A 8D A4 05    STA $05A4  [$7E:05A4]  ;} HDMA table update destination top base position = 80h
$88:B12D 8D A6 05    STA $05A6  [$7E:05A6]  ; HDMA table update source top base position = 80h
$88:B130 A9 7F 00    LDA #$007F             ;\
$88:B133 8D A8 05    STA $05A8  [$7E:05A8]  ;} HDMA table update destination bottom base position = 7Fh
$88:B136 8D AA 05    STA $05AA  [$7E:05AA]  ; HDMA table update source bottom base position = 7Fh
$88:B139 A9 00 20    LDA #$2000             ;\
$88:B13C 8D A2 05    STA $05A2  [$7E:05A2]  ;} Expansion factor = 2000h
$88:B13F A9 FF 00    LDA #$00FF             ;\
$88:B142 8F 00 9E 7E STA $7E9E00[$7E:9E00]  ;|
$88:B146 A9 00 9C    LDA #$9C00             ;|
$88:B149 8F 01 9E 7E STA $7E9E01[$7E:9E01]  ;|
$88:B14D A9 E1 00    LDA #$00E1             ;|
$88:B150 8F 03 9E 7E STA $7E9E03[$7E:9E03]  ;} $7E:9E00..07 = FFh,$9C00, E1h,$9CFE, 0 (indirect HDMA table)
$88:B154 A9 FE 9C    LDA #$9CFE             ;|
$88:B157 8F 04 9E 7E STA $7E9E04[$7E:9E04]  ;|
$88:B15B A9 00 00    LDA #$0000             ;|
$88:B15E 8F 06 9E 7E STA $7E9E06[$7E:9E06]  ;/
$88:B162 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:B166             dx 42, 10, B16C        ;} Spawn indirect HDMA object for BG2 Y scroll with instruction list $B16C
$88:B16A 28          PLP
$88:B16B 6B          RTL
}


;;; $B16C: Instruction list - expanding and contracting effect BG2 Y scroll ;;;
{
$88:B16C             dx 8655,7E,    ; HDMA table bank = $7E
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,88B17F,; Pre-instruction = $88:B17F
$88:B177             dx 7777,9E00,
                        85EC,B177,  ; Go to $B177
}


;;; $B17F: Pre-instruction - expanding and contracting effect BG2 Y scroll ;;;
{
; y_low_0  = [$05A4]
; y_high_0 = [$05A8]
; expansion_factor = [$05A2] ; scale factor = 1 + expansion_factor / 8000h
; y_source_low_0  = [$05A6]
; y_source_high_0 = [$05AA]
; for (i = 0; i < 20h; ++i)
; {
;     y_low  = y_low_0  + i
;     y_high = y_high_0 - i
;     delta = i - (expansion_factor * i + 8000h) / 10000h
;     y_source_low  = y_source_low_0  + delta
;     y_source_high = y_source_high_0 - delta
;     $7E:9C00 + y_low  * 2 = y_source_low  - y_low
;     $7E:9C00 + y_high * 2 = y_source_high - y_high
; }

; $05A4 += 20h
; $05A8 -= 20h
; $05A6 += 20h - expansion_factor / 800h
; $05AA -= 20h - expansion_factor / 800h

; "expanding contracting test.lua" seems to agree with this maths

$88:B17F 08          PHP
$88:B180 C2 30       REP #$30
$88:B182 EE 9A 05    INC $059A  [$7E:059A]  ; Increment HDMA table update counter
$88:B185 AD 9A 05    LDA $059A  [$7E:059A]  ;\
$88:B188 C9 04 00    CMP #$0004             ;} If [HDMA table update counter] < 4: go to BRANCH_B1D3
$88:B18B 30 46       BMI $46    [$B1D3]     ;/
$88:B18D 9C 9A 05    STZ $059A  [$7E:059A]  ; HDMA table update counter = 0
$88:B190 AD A0 05    LDA $05A0  [$7E:05A0]  ;\
$88:B193 F0 1A       BEQ $1A    [$B1AF]     ;} If contracting:
$88:B195 AD A2 05    LDA $05A2  [$7E:05A2]  ;\
$88:B198 38          SEC                    ;|
$88:B199 E9 00 04    SBC #$0400             ;} Expansion factor -= 400h
$88:B19C 8D A2 05    STA $05A2  [$7E:05A2]  ;/
$88:B19F C9 00 20    CMP #$2000             ;\
$88:B1A2 10 1D       BPL $1D    [$B1C1]     ;} If [expansion factor] < 2000h:
$88:B1A4 A9 00 20    LDA #$2000             ;\
$88:B1A7 8D A2 05    STA $05A2  [$7E:05A2]  ;} Expansion factor = 2000h
$88:B1AA 9C A0 05    STZ $05A0  [$7E:05A0]  ; Contracting flag = 0
$88:B1AD 80 12       BRA $12    [$B1C1]

$88:B1AF AD A2 05    LDA $05A2  [$7E:05A2]  ;\ Else (expanding):
$88:B1B2 18          CLC                    ;|
$88:B1B3 69 00 04    ADC #$0400             ;} Expansion factor += 400h
$88:B1B6 8D A2 05    STA $05A2  [$7E:05A2]  ;/
$88:B1B9 C9 00 80    CMP #$8000             ;\
$88:B1BC 30 03       BMI $03    [$B1C1]     ;} If [expansion factor] >= 8000h:
$88:B1BE EE A0 05    INC $05A0  [$7E:05A0]  ; Contracting flag = 1

$88:B1C1 A9 80 00    LDA #$0080             ;\
$88:B1C4 8D A4 05    STA $05A4  [$7E:05A4]  ;} $05A4 = 80h (y_low)
$88:B1C7 8D A6 05    STA $05A6  [$7E:05A6]  ; $05A6 = 80h (y_source_low)
$88:B1CA A9 7F 00    LDA #$007F             ;\
$88:B1CD 8D A8 05    STA $05A8  [$7E:05A8]  ;} $05A8 = 7Fh (y_high)
$88:B1D0 8D AA 05    STA $05AA  [$7E:05AA]  ; $05AA = 7Fh (y_source_high)

; BRANCH_B1D3
$88:B1D3 AD A4 05    LDA $05A4  [$7E:05A4]  ;\
$88:B1D6 0A          ASL A                  ;} X = [$05A4] * 2 (y_low  * 2)
$88:B1D7 AA          TAX                    ;/
$88:B1D8 AD A8 05    LDA $05A8  [$7E:05A8]  ;\
$88:B1DB 0A          ASL A                  ;} Y = [$05A8] * 2 (y_high * 2)
$88:B1DC A8          TAY                    ;/
$88:B1DD 64 12       STZ $12    [$7E:0012]  ; $12 = 0 (borrow accumulator)
$88:B1DF A9 20 00    LDA #$0020             ;\
$88:B1E2 85 14       STA $14    [$7E:0014]  ;} $14 = 20h (loop counter)

; LOOP
$88:B1E4 AD A6 05    LDA $05A6  [$7E:05A6]  ;\
$88:B1E7 38          SEC                    ;|
$88:B1E8 ED A4 05    SBC $05A4  [$7E:05A4]  ;} $7E:9C00 + [X] = [$05A6] - [$05A4] (y_source_low  - y_low)
$88:B1EB 9F 00 9C 7E STA $7E9C00,x          ;/
$88:B1EF DA          PHX                    ;\
$88:B1F0 BB          TYX                    ;|
$88:B1F1 AD AA 05    LDA $05AA  [$7E:05AA]  ;|
$88:B1F4 38          SEC                    ;} $7E:9C00 + [Y] = [$05AA] - [$05A8] (y_source_high - y_high)
$88:B1F5 ED A8 05    SBC $05A8  [$7E:05A8]  ;|
$88:B1F8 9F 00 9C 7E STA $7E9C00,x          ;|
$88:B1FC FA          PLX                    ;/
$88:B1FD A5 12       LDA $12    [$7E:0012]  ;\
$88:B1FF 18          CLC                    ;|
$88:B200 6D A2 05    ADC $05A2  [$7E:05A2]  ;} $12 += [expansion factor]
$88:B203 85 12       STA $12    [$7E:0012]  ;/
$88:B205 70 06       BVS $06    [$B20D]     ; If not 8000h <= [$12] < 8000h + [expansion factor]:
$88:B207 EE A6 05    INC $05A6  [$7E:05A6]  ; Increment $05A6 (y_source_low)
$88:B20A CE AA 05    DEC $05AA  [$7E:05AA]  ; Decrement $05AA (y_source_high)

$88:B20D EE A4 05    INC $05A4  [$7E:05A4]  ; Increment $05A4 (y_low)
$88:B210 CE A8 05    DEC $05A8  [$7E:05A8]  ; Decrement $05A8 (y_high)
$88:B213 88          DEY                    ;\
$88:B214 88          DEY                    ;} Y -= 2
$88:B215 E8          INX                    ;\
$88:B216 E8          INX                    ;} X += 2
$88:B217 C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$88:B219 D0 C9       BNE $C9    [$B1E4]     ; If [$14] != 0: go to LOOP
$88:B21B 28          PLP
$88:B21C 6B          RTL
}
}


;;; $B21D: Handle earthquake sound effect ;;;
{
; For lavaquake and Tourian entrance reveal
$88:B21D DA          PHX
$88:B21E 5A          PHY
$88:B21F 08          PHP
$88:B220 C2 30       REP #$30
$88:B222 AD 09 06    LDA $0609  [$7E:0609]  ;\
$88:B225 30 2B       BMI $2B    [$B252]     ;} If [earthquake sound effect timer] < 0: return
$88:B227 3A          DEC A                  ;\
$88:B228 8D 09 06    STA $0609  [$7E:0609]  ;} Decrement earthquake sound effect timer
$88:B22B 10 25       BPL $25    [$B252]     ; If [earthquake sound effect timer] >= 0: return
$88:B22D AE 07 06    LDX $0607  [$7E:0607]  ; X = [earthquake sound effect index]
$88:B230 BD 56 B2    LDA $B256,x[$88:B256]  ;\
$88:B233 10 06       BPL $06    [$B23B]     ;} If [$B256 + [X]] & 8000h != 0:
$88:B235 A2 00 00    LDX #$0000             ; X = 0
$88:B238 BD 56 B2    LDA $B256,x[$88:B256]

$88:B23B 22 CB 90 80 JSL $8090CB[$80:90CB]  ; Queue sound 46h, sound library 2, max queued sounds allowed = 6 (lavaquake)
$88:B23F AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$88:B242 29 03 00    AND #$0003             ;|
$88:B245 7D 58 B2    ADC $B258,x[$88:B258]  ;} Earthquake sound effect timer = [$B256 + [X] + 2] + [random number] % 4
$88:B248 8D 09 06    STA $0609  [$7E:0609]  ;/
$88:B24B E8          INX                    ;\
$88:B24C E8          INX                    ;|
$88:B24D E8          INX                    ;} Earthquake sound effect index = [X] + 4
$88:B24E E8          INX                    ;|
$88:B24F 8E 07 06    STX $0607  [$7E:0607]  ;/

$88:B252 28          PLP
$88:B253 7A          PLY
$88:B254 FA          PLX
$88:B255 60          RTS

;                        ________ Sound index (sound library 2)
;                       |     ___ Base timer
;                       |    |
$88:B256             dw 0046,0001,
                        0046,0003,
                        0046,0002,
                        0046,0001,
                        0046,0001,
                        0046,0002,
                        0046,0002,
                        0046,0001,
                        8000
}


;;; $B278: RTL. FX type: none ;;;
{
$88:B278 6B          RTL
}


;;; $B279..D864: Liquids ;;;
{
;;; $B279: FX type 2: lava ;;;
{
$88:B279 A9 43 B3    LDA #$B343             ;\
$88:B27C 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $B343 (normal)
$88:B27F AD 78 19    LDA $1978  [$7E:1978]  ;\
$88:B282 8D 62 19    STA $1962  [$7E:1962]  ;} Lava/acid Y position = [FX base Y position]
$88:B285 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:B289             dx 42, 12, C3E1        ;} Spawn indirect HDMA object for BG3 Y scroll with instruction list $C3E1
$88:B28D 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:B291             dx 42, 10, C3F0        ;} Spawn indirect HDMA object for BG2 Y scroll with instruction list $C3F0
$88:B295 22 65 D8 88 JSL $88D865[$88:D865]  ; Spawn BG3 scroll HDMA object
$88:B299 A0 AB 82    LDY #$82AB             ;\
$88:B29C 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn lava animated tiles object
$88:B2A0 6B          RTL
}


;;; $B2A1: FX type 4: acid ;;;
{
$88:B2A1 A9 43 B3    LDA #$B343             ;\
$88:B2A4 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $B343 (normal)
$88:B2A7 AD 78 19    LDA $1978  [$7E:1978]  ;\
$88:B2AA 8D 62 19    STA $1962  [$7E:1962]  ;} Lava/acid Y position = [FX base Y position]
$88:B2AD 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:B2B1             dx 42, 12, C3E1        ;} Spawn indirect HDMA object for BG3 Y scroll with instruction list $C3E1
$88:B2B5 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:B2B9             dx 42, 10, C3F0        ;} Spawn indirect HDMA object for BG2 Y scroll with instruction list $C3F0
$88:B2BD 22 65 D8 88 JSL $88D865[$88:D865]  ; Spawn BG3 scroll HDMA object
$88:B2C1 A0 C9 82    LDY #$82C9             ;\
$88:B2C4 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn acid animated tiles object
$88:B2C8 6B          RTL
}


;;; $B2C9: Handle tide ;;;
{
$88:B2C9 2C 7D 19    BIT $197D  [$7E:197D]  ;\
$88:B2CC 30 03       BMI $03    [$B2D1]     ;} If [FX liquid options] & 80h != 0: go to BRANCH_SMALL_TIDE
$88:B2CE 70 38       BVS $38    [$B308]     ; If [FX liquid options] & 40h != 0: go to BRANCH_BIG_TIDE
$88:B2D0 60          RTS                    ; Return

; BRANCH_SMALL_TIDE
$88:B2D1 9C 70 19    STZ $1970  [$7E:1970]  ;\
$88:B2D4 9C 72 19    STZ $1972  [$7E:1972]  ;|
$88:B2D7 AD 75 19    LDA $1975  [$7E:1975]  ;|
$88:B2DA 29 FF 00    AND #$00FF             ;|
$88:B2DD 0A          ASL A                  ;|
$88:B2DE AA          TAX                    ;|
$88:B2DF BF C3 B3 A0 LDA $A0B3C3,x[$A0:B3C3];|
$88:B2E3 0A          ASL A                  ;} FX Y offset = 8 * -cos([tide phase] / 100h * pi / 80h)
$88:B2E4 0A          ASL A                  ;|
$88:B2E5 0A          ASL A                  ;|
$88:B2E6 10 03       BPL $03    [$B2EB]     ;|
$88:B2E8 CE 72 19    DEC $1972  [$7E:1972]  ;|
                                            ;|
$88:B2EB 8D 71 19    STA $1971  [$7E:1971]  ;/
$88:B2EE BF C3 B3 A0 LDA $A0B3C3,x[$A0:B3C3];\
$88:B2F2 10 09       BPL $09    [$B2FD]     ;} If -40h < [tide phase] / 100h < 40h (tide above midpoint):
$88:B2F4 AD 74 19    LDA $1974  [$7E:1974]  ;\
$88:B2F7 18          CLC                    ;} Tide phase += C0h
$88:B2F8 69 C0 00    ADC #$00C0             ;/
$88:B2FB 80 07       BRA $07    [$B304]

$88:B2FD AD 74 19    LDA $1974  [$7E:1974]  ;\ Else (not -40h < [tide phase] / 100h < 40h (tide below midpoint)):
$88:B300 18          CLC                    ;} Tide phase += 120h
$88:B301 69 20 01    ADC #$0120             ;/

$88:B304 8D 74 19    STA $1974  [$7E:1974]
$88:B307 60          RTS                    ; Return

; BRANCH_BIG_TIDE
$88:B308 9C 70 19    STZ $1970  [$7E:1970]  ;\
$88:B30B 9C 72 19    STZ $1972  [$7E:1972]  ;|
$88:B30E AD 75 19    LDA $1975  [$7E:1975]  ;|
$88:B311 29 FF 00    AND #$00FF             ;|
$88:B314 0A          ASL A                  ;|
$88:B315 AA          TAX                    ;|
$88:B316 BF C3 B3 A0 LDA $A0B3C3,x[$A0:B3C3];|
$88:B31A 0A          ASL A                  ;|
$88:B31B 0A          ASL A                  ;} FX Y offset = 20h * -cos([tide phase] / 100h * pi / 80h)
$88:B31C 0A          ASL A                  ;|
$88:B31D 0A          ASL A                  ;|
$88:B31E 0A          ASL A                  ;|
$88:B31F 10 03       BPL $03    [$B324]     ;|
$88:B321 CE 72 19    DEC $1972  [$7E:1972]  ;|
                                            ;|
$88:B324 8D 71 19    STA $1971  [$7E:1971]  ;/
$88:B327 BF C3 B3 A0 LDA $A0B3C3,x[$A0:B3C3];\
$88:B32B 10 09       BPL $09    [$B336]     ;} If -40h < [tide phase] / 100h < 40h (tide above midpoint):
$88:B32D AD 74 19    LDA $1974  [$7E:1974]  ;\
$88:B330 18          CLC                    ;} Tide phase += 80h
$88:B331 69 80 00    ADC #$0080             ;/
$88:B334 80 07       BRA $07    [$B33D]

$88:B336 AD 74 19    LDA $1974  [$7E:1974]  ;\ Else (not -40h < [tide phase] / 100h < 40h (tide below midpoint)):
$88:B339 18          CLC                    ;} Tide phase += E0h
$88:B33A 69 E0 00    ADC #$00E0             ;/

$88:B33D 8D 74 19    STA $1974  [$7E:1974]
$88:B340 60          RTS
}


;;; $B341: RTS ;;;
{
$88:B341 60          RTS
}


;;; $B342: RTS ;;;
{
$88:B342 60          RTS
}


;;; $B343..C3FE: Lava/acid ;;;
{
;;; $B343: FX rising function - lava/acid - normal ;;;
{
$88:B343 AD 7C 19    LDA $197C  [$7E:197C]  ;\
$88:B346 F0 1E       BEQ $1E    [$B366]     ;} If [FX Y velocity] = 0: return
$88:B348 30 0B       BMI $0B    [$B355]     ; If [FX Y velocity] < 0: go to BRANCH_NEGATIVE
$88:B34A AD 7A 19    LDA $197A  [$7E:197A]  ;\
$88:B34D CD 78 19    CMP $1978  [$7E:1978]  ;|
$88:B350 F0 02       BEQ $02    [$B354]     ;} If [FX target Y position] > [FX base Y position]: go to BRANCH_DO_RISE
$88:B352 B0 0C       BCS $0C    [$B360]     ;/

$88:B354 60          RTS                    ; Return

; BRANCH_NEGATIVE
$88:B355 AD 7A 19    LDA $197A  [$7E:197A]  ;\
$88:B358 CD 78 19    CMP $1978  [$7E:1978]  ;|
$88:B35B F0 02       BEQ $02    [$B35F]     ;} If [FX target Y position] < [FX base Y position]: go to BRANCH_DO_RISE
$88:B35D 90 01       BCC $01    [$B360]     ;/

$88:B35F 60          RTS                    ; Return

; BRANCH_DO_RISE
$88:B360 A9 67 B3    LDA #$B367             ;\
$88:B363 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $B367

$88:B366 60          RTS
}


;;; $B367: FX rising function - lava/acid - wait to rise ;;;
{
$88:B367 20 1D B2    JSR $B21D  [$88:B21D]  ; Handle earthquake sound effect
$88:B36A A9 15 00    LDA #$0015             ;\
$88:B36D 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1, BG2 and enemies, 2 pixel displacement, horizontal
$88:B370 A9 20 00    LDA #$0020             ;\
$88:B373 0C 40 18    TSB $1840  [$7E:1840]  ;} Earthquake timer = 20h+
$88:B376 CE 80 19    DEC $1980  [$7E:1980]  ; Decrement FX timer
$88:B379 D0 06       BNE $06    [$B381]     ; If [FX timer] != 0: return
$88:B37B A9 82 B3    LDA #$B382             ;\
$88:B37E 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $B382

$88:B381 60          RTS
}


;;; $B382: FX rising function - lava/acid - rising ;;;
{
$88:B382 20 1D B2    JSR $B21D  [$88:B21D]  ; Handle earthquake sound effect
$88:B385 A9 15 00    LDA #$0015             ;\
$88:B388 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1, BG2 and enemies, 2 pixel displacement, horizontal
$88:B38B A9 20 00    LDA #$0020             ;\
$88:B38E 0C 40 18    TSB $1840  [$7E:1840]  ;} Earthquake timer = 20h+
$88:B391 20 8C 86    JSR $868C  [$88:868C]  ; Raise/lower FX
$88:B394 B0 01       BCS $01    [$B397]     ; If not reached target:
$88:B396 60          RTS                    ; Return

$88:B397 9C 7C 19    STZ $197C  [$7E:197C]  ; FX Y velocity = 0
$88:B39A A9 43 B3    LDA #$B343             ;\
$88:B39D 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $B343 (normal)
$88:B3A0 60          RTS
}


;;; $B3A1: Lava sound effects ;;;
{
; Sound library 2. Chosen randomly from the following
$88:B3A1             db 12, 13, 14, 12, 13, 14, 12, 13
}


;;; $B3A9: Instruction - lava sound timer = 70h ;;;
{
$88:B3A9 A9 70 00    LDA #$0070
$88:B3AC 9D 2C 19    STA $192C,x[$7E:192C]
$88:B3AF 60          RTS
}


;;; $B3B0: Pre-instruction - lava/acid BG3 Y scroll ;;;
{
; For on-screen lava/acid,
; the calculation 200h - [A] at $B477 is equivalent to 100h + (Y position of screen on lava/acid)
; (100h is the offset of lava/acid in the BG3 tilemap)

; As far as I can tell, the HDMA done here is completely pointless and a big waste of time and space
; I suspect that lava/acid was a copy+paste job from water FX, and this BG3 HDMA is a leftover by-product
; The HDMA set up here writes the zero BG3 Y scroll on every scanline up until 8 pixels above the FX tilemap starts,
; and then writes the calculated [$7E:9C02] BG3 Y scroll for the remaining scanlines
; But there's (more than) a full screen of transparent padding before the FX tilemap, so this is completely unnecessary
; It would be sufficient to set $7E:CADC instead of $7E:9C02 at $B41A to set the BG3 Y position via *the* BG3 scroll HDMA object

$88:B3B0 8B          PHB
$88:B3B1 AD 84 19    LDA $1984  [$7E:1984]  ;\
$88:B3B4 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = [FX layer 3 layer blending configuration]
$88:B3B7 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:B3BA F0 02       BEQ $02    [$B3BE]     ;} If time is frozen:
$88:B3BC AB          PLB                    ;\
$88:B3BD 6B          RTL                    ;} Return

$88:B3BE C2 30       REP #$30
$88:B3C0 F4 C5 B3    PEA $B3C5              ;\
$88:B3C3 6C 6C 19    JMP ($196C)[$88:B343]  ;} Execute [FX rising function]

$88:B3C6 20 C9 B2    JSR $B2C9  [$88:B2C9]  ; Handle tide
$88:B3C9 E2 10       SEP #$10
$88:B3CB AD 76 19    LDA $1976  [$7E:1976]  ;\
$88:B3CE 18          CLC                    ;|
$88:B3CF 6D 70 19    ADC $1970  [$7E:1970]  ;|
$88:B3D2 8D 60 19    STA $1960  [$7E:1960]  ;} Lava/acid Y position = [FX base Y position] + [FX Y offset]
$88:B3D5 AD 78 19    LDA $1978  [$7E:1978]  ;|
$88:B3D8 6D 72 19    ADC $1972  [$7E:1972]  ;|
$88:B3DB 8D 62 19    STA $1962  [$7E:1962]  ;/
$88:B3DE A5 B1       LDA $B1    [$7E:00B1]  ;\
$88:B3E0 8F DC CA 7E STA $7ECADC[$7E:CADC]  ;} BG3 X position = [BG1 X scroll]
$88:B3E4 A9 00 00    LDA #$0000             ;\
$88:B3E7 8F 00 9C 7E STA $7E9C00[$7E:9C00]  ;} $7E:9C00 = 0
$88:B3EB A9 00 00    LDA #$0000             ;\
$88:B3EE 8F DE CA 7E STA $7ECADE[$7E:CADE]  ;} BG3 Y position = 0
$88:B3F2 AD 62 19    LDA $1962  [$7E:1962]  ;\
$88:B3F5 30 18       BMI $18    [$B40F]     ;} If [lava/acid Y position] < 0: go to BRANCH_OFF_SCREEN
$88:B3F7 38          SEC                    ;\
$88:B3F8 ED 15 09    SBC $0915  [$7E:0915]  ;|
$88:B3FB F0 02       BEQ $02    [$B3FF]     ;} If [lava/acid Y position] - [layer 1 Y position] <= 0:
$88:B3FD 10 0B       BPL $0B    [$B40A]     ;/
$88:B3FF 49 1F 00    EOR #$001F             ;\
$88:B402 29 1F 00    AND #$001F             ;} A = 100h + (Y position of screen on lava/acid) % 20h
$88:B405 09 00 01    ORA #$0100             ;/
$88:B408 80 10       BRA $10    [$B41A]     ; Go to BRANCH_MERGE

$88:B40A C9 00 01    CMP #$0100             ;\
$88:B40D 90 05       BCC $05    [$B414]     ;} If [lava/acid Y position] - [layer 1 Y position] < 100h: go to BRANCH_ON_SCREEN

; BRANCH_OFF_SCREEN
$88:B40F A9 00 00    LDA #$0000             ; A = 0
$88:B412 80 06       BRA $06    [$B41A]     ; Go to BRANCH_MERGE

; BRANCH_ON_SCREEN
$88:B414 49 FF 00    EOR #$00FF             ;\
$88:B417 29 FF 00    AND #$00FF             ;} A = 100h + (Y position of screen on lava/acid) - 1

; BRANCH_MERGE
$88:B41A 8F 02 9C 7E STA $7E9C02[$7E:9C02]  ; $7E:9C02 = [A]
$88:B41E AE B2 18    LDX $18B2  [$7E:18B2]
$88:B421 AD 6E 19    LDA $196E  [$7E:196E]  ;\
$88:B424 C9 02 00    CMP #$0002             ;} If [FX type] = lava:
$88:B427 D0 21       BNE $21    [$B44A]     ;/
$88:B429 AD 62 19    LDA $1962  [$7E:1962]  ;\
$88:B42C 30 1C       BMI $1C    [$B44A]     ;} If [lava/acid Y position] >= 0:
$88:B42E DE 2C 19    DEC $192C,x[$7E:192C]  ; Decrement HDMA object lava sound timer
$88:B431 D0 17       BNE $17    [$B44A]     ; If [HDMA object lava sound timer] = 0:
$88:B433 A9 70 00    LDA #$0070             ;\
$88:B436 9D 2C 19    STA $192C,x[$7E:192C]  ;} HDMA object lava sound timer = 70h
$88:B439 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$88:B43C 29 07 00    AND #$0007             ;|
$88:B43F A8          TAY                    ;} Queue sound [$B3A1 + [random number] % 8], sound library 2, max queued sounds allowed = 6
$88:B440 B9 A1 B3    LDA $B3A1,y[$88:B3A4]  ;|
$88:B443 29 FF 00    AND #$00FF             ;|
$88:B446 22 CB 90 80 JSL $8090CB[$80:90CB]  ;/

$88:B44A AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$88:B44D EB          XBA                    ;} Exchange bytes of random number
$88:B44E 8D E5 05    STA $05E5  [$7E:05E5]  ;/
$88:B451 AE B2 18    LDX $18B2  [$7E:18B2]
$88:B454 BD C0 18    LDA $18C0,x[$7E:18C0]  ;\
$88:B457 29 FF 00    AND #$00FF             ;} >_<;
$88:B45A A8          TAY                    ;/
$88:B45B AD 62 19    LDA $1962  [$7E:1962]  ;\
$88:B45E 30 14       BMI $14    [$B474]     ;} If [lava/acid Y position] < 0: go to BRANCH_NEGATIVE
$88:B460 38          SEC                    ;\
$88:B461 ED 15 09    SBC $0915  [$7E:0915]  ;|
$88:B464 18          CLC                    ;} A = 100h + [lava/acid Y position] - [layer 1 Y position]
$88:B465 69 00 01    ADC #$0100             ;/
$88:B468 10 05       BPL $05    [$B46F]     ; If [lava/acid Y position] - [layer 1 Y position] < -100h:
$88:B46A A9 FF 00    LDA #$00FF             ; A = FFh
$88:B46D 80 08       BRA $08    [$B477]     ; Go to BRANCH_MERGE_2

$88:B46F C9 00 02    CMP #$0200             ;\
$88:B472 90 03       BCC $03    [$B477]     ;} If [lava/acid Y position] - [layer 1 Y position] < 100h: go to BRANCH_MERGE_2

; BRANCH_NEGATIVE
$88:B474 A9 FF 01    LDA #$01FF             ; A = 1FFh

; BRANCH_MERGE_2
$88:B477 49 FF 01    EOR #$01FF             ;\
$88:B47A 1A          INC A                  ;|
$88:B47B 29 FF 03    AND #$03FF             ;|
$88:B47E 85 12       STA $12    [$7E:0012]  ;|
$88:B480 A5 12       LDA $12    [$7E:0012]  ;|
$88:B482 0A          ASL A                  ;} HDMA object table pointer = $B62A + (200h - [A]) * 3
$88:B483 18          CLC                    ;|
$88:B484 65 12       ADC $12    [$7E:0012]  ;|
$88:B486 69 2A B6    ADC #$B62A             ;|
$88:B489 9D D8 18    STA $18D8,x[$7E:18D8]  ;/
$88:B48C AB          PLB
$88:B48D 6B          RTL
}


;;; $B48E: Unused ;;;
{
; Wave displacement table. Same as the data at $B60A
$88:B48E             dw 0000,0001,0001,0000,0000,FFFF,FFFF,0000,
                        0000,0001,0001,0000,0000,FFFF,FFFF,0000,
                        0000,0001,0001,0000,0000,FFFF,FFFF,0000,
                        0000,0001,0001,0000,0000,FFFF,FFFF,0000
}


;;; $B4CE: Instruction - HDMA object phase decrease timer = 1 ;;;
{
$88:B4CE A9 01 00    LDA #$0001
$88:B4D1 9D 20 19    STA $1920,x[$7E:1922]
$88:B4D4 60          RTS
}


;;; $B4D5: Pre-instruction - lava/acid BG2 Y scroll ;;;
{
$88:B4D5 8B          PHB
$88:B4D6 A5 B7       LDA $B7    [$7E:00B7]  ;\
$88:B4D8 8F 44 9C 7E STA $7E9C44[$7E:9C44]  ;} $7E:9C44 = [BG2 Y scroll]
$88:B4DC AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:B4DF D0 08       BNE $08    [$B4E9]     ;} If time is not frozen:
$88:B4E1 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$88:B4E4 89 06 00    BIT #$0006             ;} If layer 2 is vertically/horizontally wavy: go to BRANCH_WAVY
$88:B4E7 D0 08       BNE $08    [$B4F1]     ;/

$88:B4E9 AE B2 18    LDX $18B2  [$7E:18B2]
$88:B4EC 20 1D B5    JSR $B51D  [$88:B51D]  ; Set up lava/acid BG2 Y scroll data table - not wavy
$88:B4EF 80 13       BRA $13    [$B504]     ; Go to BRANCH_MERGE

; BRANCH_WAVY
$88:B4F1 89 02 00    BIT #$0002             ;\
$88:B4F4 D0 08       BNE $08    [$B4FE]     ;} If layer 2 is horizontally wavy:
$88:B4F6 AE B2 18    LDX $18B2  [$7E:18B2]
$88:B4F9 20 3B B5    JSR $B53B  [$88:B53B]  ; Set up lava/acid BG2 Y scroll data table - horizontally wavy
$88:B4FC 80 06       BRA $06    [$B504]     ; Go to BRANCH_MERGE

$88:B4FE AE B2 18    LDX $18B2  [$7E:18B2]  ; Else (layer 2 is vertically wavy):
$88:B501 20 A9 B5    JSR $B5A9  [$88:B5A9]  ; Set up lava/acid BG2 Y scroll data table - vertically wavy

; BRANCH_MERGE
$88:B504 AE B2 18    LDX $18B2  [$7E:18B2]
$88:B507 A5 B7       LDA $B7    [$7E:00B7]  ;\
$88:B509 29 0F 00    AND #$000F             ;|
$88:B50C 85 12       STA $12    [$7E:0012]  ;|
$88:B50E A5 12       LDA $12    [$7E:0012]  ;|
$88:B510 0A          ASL A                  ;|
$88:B511 18          CLC                    ;} HDMA object table pointer = $C0B1 + [BG2 Y scroll] % 10h * 3
$88:B512 65 12       ADC $12    [$7E:0012]  ;|
$88:B514 18          CLC                    ;|
$88:B515 69 B1 C0    ADC #$C0B1             ;|
$88:B518 9D D8 18    STA $18D8,x[$7E:18DA]  ;/
$88:B51B AB          PLB
$88:B51C 6B          RTL
}


;;; $B51D: Set up lava/acid BG2 Y scroll data table - not wavy ;;;
{
$88:B51D E2 20       SEP #$20               ;\
$88:B51F BC C0 18    LDY $18C0,x[$7E:18C2]  ;|
$88:B522 A9 10       LDA #$10               ;} HDMA target = BG2 Y scroll ($2110)
$88:B524 99 01 43    STA $4301,y            ;|
$88:B527 C2 20       REP #$20               ;/
$88:B529 DA          PHX                    ;\
$88:B52A A2 1E       LDX #$1E               ;|
$88:B52C A5 B7       LDA $B7    [$7E:00B7]  ;|
$88:B52E 29 FF 01    AND #$01FF             ;|
                                            ;|
$88:B531 9F 46 9C 7E STA $7E9C46,x[$7E:9C64];} $7E:9C46..65 = [BG2 Y scroll]
$88:B535 CA          DEX                    ;|
$88:B536 CA          DEX                    ;|
$88:B537 10 F8       BPL $F8    [$B531]     ;|
$88:B539 FA          PLX                    ;/
$88:B53A 60          RTS
}


;;; $B53B: Set up lava/acid BG2 Y scroll data table - horizontally wavy ;;;
{
; OK so this is suddenly now BG2 *X* scroll here, but this effect is never used in vanilla, so I'm not changing the name
$88:B53B E2 20       SEP #$20               ;\
$88:B53D BC C0 18    LDY $18C0,x            ;|
$88:B540 A9 0F       LDA #$0F               ;} HDMA target = BG2 X scroll ($210F)
$88:B542 99 01 43    STA $4301,y            ;|
$88:B545 C2 20       REP #$20               ;/
$88:B547 DE 20 19    DEC $1920,x            ; Decrement HDMA object phase decrease timer
$88:B54A D0 11       BNE $11    [$B55D]     ; If [HDMA object phase decrease timer] = 0:
$88:B54C A9 06 00    LDA #$0006             ;\
$88:B54F 9D 20 19    STA $1920,x            ;} HDMA object phase decrease timer = 6
$88:B552 BD 14 19    LDA $1914,x            ;\
$88:B555 3A          DEC A                  ;|
$88:B556 3A          DEC A                  ;} HDMA object wave phase = ([HDMA object wave phase] - 2) % 20h
$88:B557 29 1E 00    AND #$001E             ;|
$88:B55A 9D 14 19    STA $1914,x            ;/

$88:B55D DA          PHX
$88:B55E BC 14 19    LDY $1914,x            ; Y = [HDMA object wave phase] (wave displacement table index)
$88:B561 A2 1E       LDX #$1E               ; X = 1Eh (HDMA data table end index)
$88:B563 A9 0F 00    LDA #$000F             ;\
$88:B566 85 12       STA $12    [$7E:0012]  ;} $12 = Fh (loop counter)

; LOOP
$88:B568 A5 B5       LDA $B5    [$7E:00B5]  ;\
$88:B56A 18          CLC                    ;|
$88:B56B 79 89 B5    ADC $B589,y            ;} Lava/acid BG2 Y scroll HDMA data table entry = [BG2 X scroll] + [$B589 + [Y]]
$88:B56E 29 FF 01    AND #$01FF             ;|
$88:B571 9F 46 9C 7E STA $7E9C46,x          ;/
$88:B575 98          TYA                    ;\
$88:B576 3A          DEC A                  ;|
$88:B577 3A          DEC A                  ;} X = ([X] - 2) % 20h (previous HDMA data table entry)
$88:B578 29 1E 00    AND #$001E             ;|
$88:B57B A8          TAY                    ;/
$88:B57C 8A          TXA                    ;\
$88:B57D 3A          DEC A                  ;|
$88:B57E 3A          DEC A                  ;} Y = ([Y] - 2) % 20h (previous wave displacement table entry)
$88:B57F 29 1E 00    AND #$001E             ;|
$88:B582 AA          TAX                    ;/
$88:B583 C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$88:B585 10 E1       BPL $E1    [$B568]     ; If [$12] >= 0: go to LOOP
$88:B587 FA          PLX
$88:B588 60          RTS

; Wave displacement table
$88:B589             dw 0000,0000,0001,0001,0001,0001,0000,0000,
                        FFFF,FFFF,FFFF,FFFF,0000,0000,0000,0000
}


;;; $B5A9: Set up lava/acid BG2 Y scroll data table - vertically wavy ;;;
{
$88:B5A9 E2 20       SEP #$20               ;\
$88:B5AB BC C0 18    LDY $18C0,x[$7E:18C2]  ;|
$88:B5AE A9 10       LDA #$10               ;} HDMA target = BG2 Y scroll ($2110)
$88:B5B0 99 01 43    STA $4301,y            ;|
$88:B5B3 C2 20       REP #$20               ;/
$88:B5B5 DE 20 19    DEC $1920,x[$7E:1922]  ; Decrement HDMA object phase decrease timer
$88:B5B8 D0 11       BNE $11    [$B5CB]     ; If [HDMA object phase decrease timer] = 0:
$88:B5BA A9 04 00    LDA #$0004             ;\
$88:B5BD 9D 20 19    STA $1920,x[$7E:1922]  ;} HDMA object phase decrease timer = 4
$88:B5C0 BD 14 19    LDA $1914,x[$7E:1916]  ;\
$88:B5C3 3A          DEC A                  ;|
$88:B5C4 3A          DEC A                  ;} HDMA object wave phase = ([HDMA object wave phase] - 2) % 20h
$88:B5C5 29 1E 00    AND #$001E             ;|
$88:B5C8 9D 14 19    STA $1914,x[$7E:1916]  ;/

$88:B5CB DA          PHX
$88:B5CC A5 B7       LDA $B7    [$7E:00B7]  ;\
$88:B5CE 29 0F 00    AND #$000F             ;|
$88:B5D1 0A          ASL A                  ;|
$88:B5D2 48          PHA                    ;|
$88:B5D3 18          CLC                    ;} Y = ([BG2 Y scroll] % 10h * 2 + [HDMA object wave phase]) % 20h (wave displacement table index)
$88:B5D4 7D 14 19    ADC $1914,x[$7E:1916]  ;|
$88:B5D7 29 1E 00    AND #$001E             ;|
$88:B5DA A8          TAY                    ;/
$88:B5DB 68          PLA                    ;\
$88:B5DC 18          CLC                    ;|
$88:B5DD 69 1E 00    ADC #$001E             ;} X = ([BG2 Y scroll] % 10h * 2 + 1Eh) % 20h (HDMA data table end index)
$88:B5E0 29 1E 00    AND #$001E             ;|
$88:B5E3 AA          TAX                    ;/
$88:B5E4 A9 0F 00    LDA #$000F             ;\
$88:B5E7 85 12       STA $12    [$7E:0012]  ;} $12 = Fh (loop counter)

; LOOP
$88:B5E9 A5 B7       LDA $B7    [$7E:00B7]  ;\
$88:B5EB 18          CLC                    ;|
$88:B5EC 79 0A B6    ADC $B60A,y[$88:B628]  ;} Lava/acid BG2 Y scroll HDMA data table entry = [BG2 Y scroll] + [$B60A + [Y]]
$88:B5EF 29 FF 01    AND #$01FF             ;|
$88:B5F2 9F 46 9C 7E STA $7E9C46,x[$7E:9C64];/
$88:B5F6 8A          TXA                    ;\
$88:B5F7 3A          DEC A                  ;|
$88:B5F8 3A          DEC A                  ;} X = ([X] - 2) % 20h (previous HDMA data table entry)
$88:B5F9 29 1E 00    AND #$001E             ;|
$88:B5FC AA          TAX                    ;/
$88:B5FD 98          TYA                    ;\
$88:B5FE 3A          DEC A                  ;|
$88:B5FF 3A          DEC A                  ;} Y = ([Y] - 2) % 20h (previous wave displacement table entry)
$88:B600 29 1E 00    AND #$001E             ;|
$88:B603 A8          TAY                    ;/
$88:B604 C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$88:B606 10 E1       BPL $E1    [$B5E9]     ; If [$12] >= 0: go to LOOP
$88:B608 FA          PLX
$88:B609 60          RTS

; Wave displacement table
$88:B60A             dw 0000,0001,0001,0000,0000,FFFF,FFFF,0000,
                        0000,0001,0001,0000,0000,FFFF,FFFF,0000
}


;;; $B62A: Indirect HDMA table - lava/acid BG3 Y scroll ;;;
{
; 81h,$9C00 x F0h
; 81h,$9C02 x 190h
; 60h,$9C02 x 2
; 0

; Disregarding the unnecessary nature of the lava/acid BG3 Y scroll HDMA (see $B3B0), this table is needlessly large
; There's no reason to have more than E0h scanlines of $9C02 (even less if the HUD is accounted for)

$88:B62A             dx 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,

                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,
                        81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02, 81,9C02,

                        60,9C02, 60,9C02,
                        00
}


;;; $BDB1: Unused. Indirect HDMA table ;;;
{
; $7E:9C44 is set to [BG2 Y scroll] by the lava/acid BG2 Y scroll pre-instruction,
; it's possible that this was the upper half of the following table, and this allowed for the wavy effect to be limited to,
; say, in the acid/lava or just above it
$88:BDB1             dx 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44
}


;;; $C0B1: Indirect HDMA table - lava/acid BG2 Y scroll ;;;
{
$88:C0B1             dx 81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64,
                        81,9C46, 81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64
}


;;; $C3E1: Instruction list - lava/acid BG3 Y scroll ;;;
{
$88:C3E1             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        B3A9,       ; Lava sound timer = 70h
                        8570,88B3B0,; Pre-instruction = $88:B3B0
                        8682        ; Sleep
}


;;; $C3F0: Instruction list - lava/acid BG2 Y scroll ;;;
{
$88:C3F0             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        B4CE,       ; HDMA object phase decrease timer = 1
                        8570,88B4D5,; Pre-instruction = $88:B4D5
                        8682        ; Sleep
}
}


;;; $C3FF..D864: Water ;;;
{
;;; $C3FF: FX type 6: water ;;;
{
$88:C3FF A9 28 C4    LDA #$C428             ;\
$88:C402 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $C428
$88:C405 AD 78 19    LDA $1978  [$7E:1978]  ;\
$88:C408 8D 5E 19    STA $195E  [$7E:195E]  ;} FX Y position = [FX base Y position]
$88:C40B 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:C40F             dx 42, 11, D856        ;} Spawn indirect HDMA object for BG3 X scroll with instruction list $D856
$88:C413 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$88:C416 29 02 00    AND #$0002             ;} If layer 2 is wavy:
$88:C419 F0 08       BEQ $08    [$C423]     ;/
$88:C41B 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:C41F             dx 42, 0F, D847        ;} Spawn indirect HDMA object for BG2 X scroll with instruction list $D847

$88:C423 22 65 D8 88 JSL $88D865[$88:D865]  ; Spawn BG3 scroll HDMA object
$88:C427 6B          RTL
}


;;; $C428: FX rising function - water - normal ;;;
{
$88:C428 AD 7C 19    LDA $197C  [$7E:197C]  ;\
$88:C42B F0 1E       BEQ $1E    [$C44B]     ;} If [FX Y velocity] = 0: return
$88:C42D 30 0B       BMI $0B    [$C43A]     ; If [FX Y velocity] < 0: go to BRANCH_NEGATIVE
$88:C42F AD 7A 19    LDA $197A  [$7E:197A]  ;\
$88:C432 CD 78 19    CMP $1978  [$7E:1978]  ;|
$88:C435 F0 02       BEQ $02    [$C439]     ;} If [FX target Y position] > [FX base Y position]: go to BRANCH_DO_RISE
$88:C437 B0 0C       BCS $0C    [$C445]     ;/

$88:C439 60          RTS                    ; Return

; BRANCH_NEGATIVE
$88:C43A AD 7A 19    LDA $197A  [$7E:197A]  ;\
$88:C43D CD 78 19    CMP $1978  [$7E:1978]  ;|
$88:C440 F0 02       BEQ $02    [$C444]     ;} If [FX target Y position] < [FX base Y position]: go to BRANCH_DO_RISE
$88:C442 90 01       BCC $01    [$C445]     ;/

$88:C444 60          RTS                    ; Return

; BRANCH_DO_RISE
$88:C445 A9 4C C4    LDA #$C44C             ;\
$88:C448 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $C44C

$88:C44B 60          RTS
}


;;; $C44C: FX rising function - water - wait to rise ;;;
{
$88:C44C CE 80 19    DEC $1980  [$7E:1980]  ; Decrement FX timer
$88:C44F D0 06       BNE $06    [$C457]     ; If [FX timer] != 0: return
$88:C451 A9 58 C4    LDA #$C458             ;\
$88:C454 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $C458

$88:C457 60          RTS
}


;;; $C458: FX rising function - water - rising ;;;
{
$88:C458 20 8C 86    JSR $868C  [$88:868C]  ; Raise/lower FX
$88:C45B 90 09       BCC $09    [$C466]     ; If not reached target: return
$88:C45D A9 28 C4    LDA #$C428             ;\
$88:C460 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $C428 (normal)
$88:C463 9C 7C 19    STZ $197C  [$7E:197C]  ; FX Y velocity = 0

$88:C466 60          RTS
}


;;; $C467: Instruction - HDMA object phase increase timer = 1 ;;;
{
$88:C467 A9 01 00    LDA #$0001
$88:C46A 9D 20 19    STA $1920,x[$7E:1920]
$88:C46D 60          RTS
}


;;; $C46E: Wave displacement table - water ;;;
{
$88:C46E             dw 0000,0001,0001,0000,0000,FFFF,FFFF,0000,
                        0000,0001,0001,0000,0000,FFFF,FFFF,0000
}


;;; $C48E: Pre-instruction - water BG3 X scroll ;;;
{
; For on-screen water,
; the calculation 200h - [A] at $C569 is equivalent to 100h + (Y position of screen on FX)
; (100h is the offset of water in the BG3 tilemap)

$88:C48E 8B          PHB
$88:C48F AD 84 19    LDA $1984  [$7E:1984]  ;\
$88:C492 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = [FX layer 3 layer blending configuration]
$88:C495 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:C498 F0 02       BEQ $02    [$C49C]     ;} If time is frozen:
$88:C49A AB          PLB                    ;\
$88:C49B 6B          RTL                    ;} Return

$88:C49C DA          PHX
$88:C49D 5A          PHY
$88:C49E C2 30       REP #$30
$88:C4A0 F4 A5 C4    PEA $C4A5              ;\
$88:C4A3 6C 6C 19    JMP ($196C)[$88:C428]  ;} Execute [FX rising function]

$88:C4A6 20 C9 B2    JSR $B2C9  [$88:B2C9]  ; Handle tide
$88:C4A9 E2 10       SEP #$10
$88:C4AB AD 76 19    LDA $1976  [$7E:1976]  ;\
$88:C4AE 18          CLC                    ;|
$88:C4AF 6D 70 19    ADC $1970  [$7E:1970]  ;|
$88:C4B2 8D 5C 19    STA $195C  [$7E:195C]  ;} FX Y position = [FX base Y position] + [FX Y offset]
$88:C4B5 AD 78 19    LDA $1978  [$7E:1978]  ;|
$88:C4B8 6D 72 19    ADC $1972  [$7E:1972]  ;|
$88:C4BB 8D 5E 19    STA $195E  [$7E:195E]  ;/
$88:C4BE AD 5E 19    LDA $195E  [$7E:195E]  ;\
$88:C4C1 30 18       BMI $18    [$C4DB]     ;} If [FX Y position] < 0: go to BRANCH_NEGATIVE
$88:C4C3 38          SEC                    ;\
$88:C4C4 ED 15 09    SBC $0915  [$7E:0915]  ;|
$88:C4C7 F0 02       BEQ $02    [$C4CB]     ;} If [FX Y position] - [layer 1 Y position] > 0: go to BRANCH_NOT_ABOVE_SCREEN
$88:C4C9 10 0B       BPL $0B    [$C4D6]     ;/

$88:C4CB 49 1F 00    EOR #$001F             ;\
$88:C4CE 29 1F 00    AND #$001F             ;} A = 100h + (Y position of screen on FX) % 20h
$88:C4D1 09 00 01    ORA #$0100             ;/
$88:C4D4 80 10       BRA $10    [$C4E6]     ; Go to BRANCH_MERGE

; BRANCH_NOT_ABOVE_SCREEN
$88:C4D6 C9 00 01    CMP #$0100             ;\
$88:C4D9 90 05       BCC $05    [$C4E0]     ;} If [FX Y position] - [layer 1 Y position] < 100h: go to BRANCH_ON_SCREEN

; BRANCH_NEGATIVE
$88:C4DB A9 00 00    LDA #$0000             ; A = 0
$88:C4DE 80 06       BRA $06    [$C4E6]     ; Go to BRANCH_MERGE

; BRANCH_ON_SCREEN
$88:C4E0 49 FF 00    EOR #$00FF             ;\
$88:C4E3 29 FF 00    AND #$00FF             ;} A = 100h + (Y position of screen on FX) - 1

; BRANCH_MERGE
$88:C4E6 8F DE CA 7E STA $7ECADE[$7E:CADE]  ; BG3 Y position = [A]
$88:C4EA AE B2 18    LDX $18B2  [$7E:18B2]
$88:C4ED BD 2C 19    LDA $192C,x[$7E:192C]  ;\
$88:C4F0 EB          XBA                    ;|
$88:C4F1 10 05       BPL $05    [$C4F8]     ;|
$88:C4F3 09 00 FF    ORA #$FF00             ;|
$88:C4F6 80 03       BRA $03    [$C4FB]     ;|
                                            ;} $14 = [layer 1 X position] + ±[HDMA object BG3 X offset] / 100h
$88:C4F8 29 FF 00    AND #$00FF             ;|
                                            ;|
$88:C4FB 18          CLC                    ;|
$88:C4FC 6D 11 09    ADC $0911  [$7E:0911]  ;|
$88:C4FF 85 14       STA $14    [$7E:0014]  ;/
$88:C501 DE 20 19    DEC $1920,x[$7E:1920]  ; Decrement HDMA object phase increase timer
$88:C504 D0 11       BNE $11    [$C517]     ; If [HDMA object phase increase timer] = 0:
$88:C506 A9 0A 00    LDA #$000A             ;\
$88:C509 9D 20 19    STA $1920,x[$7E:1920]  ;} HDMA object phase increase timer = Ah
$88:C50C BD 14 19    LDA $1914,x[$7E:1914]  ;\
$88:C50F 1A          INC A                  ;|
$88:C510 1A          INC A                  ;} HDMA object wave phase = ([HDMA object wave phase] + 2) % 20h
$88:C511 29 1E 00    AND #$001E             ;|
$88:C514 9D 14 19    STA $1914,x[$7E:1914]  ;/

$88:C517 BD 14 19    LDA $1914,x[$7E:1914]  ;\
$88:C51A AA          TAX                    ;} X = [HDMA object wave phase] (HDMA data table end index)
$88:C51B A0 1E       LDY #$1E               ; Y = 1Eh (wave displacement table index)

; LOOP
$88:C51D A5 14       LDA $14    [$7E:0014]  ;\
$88:C51F 18          CLC                    ;|
$88:C520 79 6E C4    ADC $C46E,y[$88:C48C]  ;} Water BG3 X scroll HDMA data table entry = [$14] + [$C46E + [Y]]
$88:C523 9F 04 9C 7E STA $7E9C04,x[$7E:9C06];/
$88:C527 CA          DEX                    ;\
$88:C528 CA          DEX                    ;|
$88:C529 8A          TXA                    ;} X = ([X] - 2) % 20h (previous HDMA data table entry)
$88:C52A 29 1E 00    AND #$001E             ;|
$88:C52D AA          TAX                    ;/
$88:C52E 88          DEY                    ;\
$88:C52F 88          DEY                    ;} Y -= 2 (previous wave displacement table entry)
$88:C530 10 EB       BPL $EB    [$C51D]     ; If [Y] >= 0: go to LOOP
$88:C532 AE B2 18    LDX $18B2  [$7E:18B2]
$88:C535 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$88:C538 29 01 00    AND #$0001             ;} If liquid flows:
$88:C53B F0 0A       BEQ $0A    [$C547]     ;/
$88:C53D BD 2C 19    LDA $192C,x[$7E:192C]  ;\
$88:C540 18          CLC                    ;|
$88:C541 69 40 00    ADC #$0040             ;} HDMA object BG3 X offset += 40h
$88:C544 9D 2C 19    STA $192C,x[$7E:192C]  ;/

$88:C547 AE B2 18    LDX $18B2  [$7E:18B2]
$88:C54A AD 5E 19    LDA $195E  [$7E:195E]  ;\
$88:C54D 30 17       BMI $17    [$C566]     ;} If [FX Y position] < 0: go to BRANCH_NEGATIVE_2
$88:C54F 38          SEC                    ;\
$88:C550 ED 15 09    SBC $0915  [$7E:0915]  ;|
$88:C553 18          CLC                    ;} A = 100h + [FX Y position] - [layer 1 Y position]
$88:C554 69 00 01    ADC #$0100             ;/
$88:C557 10 08       BPL $08    [$C561]     ; If [FX Y position] - [layer 1 Y position] < -100h:
$88:C559 29 0F 00    AND #$000F             ;\
$88:C55C 09 00 01    ORA #$0100             ;} A = 100h + ([FX Y position] - [layer 1 Y position]) % 10h
$88:C55F 80 08       BRA $08    [$C569]     ; Go to BRANCH_MERGE_2

$88:C561 C9 00 02    CMP #$0200             ;\
$88:C564 90 03       BCC $03    [$C569]     ;} If [FX Y position] - [layer 1 Y position] < 100h: go to BRANCH_MERGE_2

; BRANCH_NEGATIVE_2
$88:C566 A9 FF 01    LDA #$01FF             ; A = 1FFh

; BRANCH_MERGE_2
$88:C569 49 FF 01    EOR #$01FF             ;\
$88:C56C 1A          INC A                  ;|
$88:C56D 29 FF 03    AND #$03FF             ;|
$88:C570 85 12       STA $12    [$7E:0012]  ;|
$88:C572 A5 12       LDA $12    [$7E:0012]  ;|
$88:C574 0A          ASL A                  ;} HDMA object table pointer = $C645 + (200h - [A]) * 3
$88:C575 18          CLC                    ;|
$88:C576 65 12       ADC $12    [$7E:0012]  ;|
$88:C578 69 45 C6    ADC #$C645             ;|
$88:C57B 9D D8 18    STA $18D8,x[$7E:18D8]  ;/
$88:C57E 7A          PLY
$88:C57F FA          PLX
$88:C580 AB          PLB
$88:C581 6B          RTL
}


;;; $C582: Instruction - HDMA object phase increase timer = 1 ;;;
{
; Clone of $C467
$88:C582 A9 01 00    LDA #$0001
$88:C585 9D 20 19    STA $1920,x[$7E:1922]
$88:C588 60          RTS
}


;;; $C589: Pre-instruction - water BG2 X scroll ;;;
{
; For on-screen water,
; the calculation 1FFh - [A] at $C5CE is equivalent to FFh + (Y position of screen on FX)
; (100h is the offset of water in the BG3 tilemap, and I think FFh is an off-by-one error)

$88:C589 8B          PHB
$88:C58A A5 B5       LDA $B5    [$7E:00B5]  ;\
$88:C58C 8F 44 9C 7E STA $7E9C44[$7E:9C44]  ;} $7E:9C44 = [BG2 X scroll]
$88:C590 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:C593 D0 0B       BNE $0B    [$C5A0]     ;} If time is not frozen:
$88:C595 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$88:C598 29 02 00    AND #$0002             ;} If layer 2 is wavy: go to BRANCH_WAVY
$88:C59B D0 08       BNE $08    [$C5A5]     ;/
$88:C59D 9E B4 18    STZ $18B4,x            ; Delete HDMA object

$88:C5A0 20 36 C6    JSR $C636  [$88:C636]  ; Set up water BG2 X scroll data table - not wavy
$88:C5A3 80 03       BRA $03    [$C5A8]     ; Go to BRANCH_MERGE

; BRANCH_WAVY
$88:C5A5 20 E4 C5    JSR $C5E4  [$88:C5E4]  ; Set up water BG2 X scroll data table - wavy

; BRANCH_MERGE
$88:C5A8 BD C0 18    LDA $18C0,x[$7E:18C2]  ;\
$88:C5AB 29 FF 00    AND #$00FF             ;} >_<;
$88:C5AE A8          TAY                    ;/
$88:C5AF AD 5E 19    LDA $195E  [$7E:195E]  ;\
$88:C5B2 30 17       BMI $17    [$C5CB]     ;} If [FX Y position] < 0: go to BRANCH_NEGATIVE
$88:C5B4 38          SEC                    ;\
$88:C5B5 ED 15 09    SBC $0915  [$7E:0915]  ;|
$88:C5B8 18          CLC                    ;} A = 100h + [FX Y position] - [layer 1 Y position]
$88:C5B9 69 00 01    ADC #$0100             ;/
$88:C5BC 10 08       BPL $08    [$C5C6]     ; If [FX Y position] - [layer 1 Y position] < -100h:
$88:C5BE 29 0F 00    AND #$000F             ;\
$88:C5C1 09 00 01    ORA #$0100             ;} A = 100h + ([FX Y position] - [layer 1 Y position]) % 10h
$88:C5C4 80 08       BRA $08    [$C5CE]     ; Go to BRANCH_MERGE_2

$88:C5C6 C9 00 02    CMP #$0200             ;\
$88:C5C9 90 03       BCC $03    [$C5CE]     ;} If [FX Y position] - [layer 1 Y position] < 100h: go to BRANCH_MERGE_2

; BRANCH_NEGATIVE
$88:C5CB A9 FF 01    LDA #$01FF             ; A = 1FFh

; BRANCH_MERGE_2
$88:C5CE 49 FF 01    EOR #$01FF             ;\
$88:C5D1 29 FF 03    AND #$03FF             ;|
$88:C5D4 85 12       STA $12    [$7E:0012]  ;|
$88:C5D6 A5 12       LDA $12    [$7E:0012]  ;|
$88:C5D8 0A          ASL A                  ;} HDMA object table pointer = $CF46 + (1FFh - [A]) * 3
$88:C5D9 18          CLC                    ;|
$88:C5DA 65 12       ADC $12    [$7E:0012]  ;|
$88:C5DC 69 46 CF    ADC #$CF46             ;|
$88:C5DF 9D D8 18    STA $18D8,x[$7E:18DA]  ;/
$88:C5E2 AB          PLB
$88:C5E3 6B          RTL
}


;;; $C5E4: Set up water BG2 X scroll data table - wavy ;;;
{
$88:C5E4 DE 20 19    DEC $1920,x[$7E:1922]  ; Decrement HDMA object phase increase timer
$88:C5E7 D0 11       BNE $11    [$C5FA]     ; If [HDMA object phase increase timer] = 0:
$88:C5E9 A9 06 00    LDA #$0006             ;\
$88:C5EC 9D 20 19    STA $1920,x[$7E:1922]  ;} HDMA object phase increase timer = 6
$88:C5EF BD 14 19    LDA $1914,x[$7E:1916]  ;\
$88:C5F2 1A          INC A                  ;|
$88:C5F3 1A          INC A                  ;} HDMA object wave phase = ([HDMA object wave phase] + 2) % 20h
$88:C5F4 29 1E 00    AND #$001E             ;|
$88:C5F7 9D 14 19    STA $1914,x[$7E:1916]  ;/

$88:C5FA DA          PHX
$88:C5FB A5 B7       LDA $B7    [$7E:00B7]  ;\
$88:C5FD 29 0F 00    AND #$000F             ;|
$88:C600 0A          ASL A                  ;|
$88:C601 48          PHA                    ;|
$88:C602 18          CLC                    ;} Y = ([BG2 Y scroll] % 10h * 2 + [HDMA object wave phase]) % 20h (wave displacement table index)
$88:C603 7D 14 19    ADC $1914,x[$7E:1916]  ;|
$88:C606 29 1E 00    AND #$001E             ;|
$88:C609 A8          TAY                    ;/
$88:C60A 68          PLA                    ;\
$88:C60B 18          CLC                    ;|
$88:C60C 69 1E 00    ADC #$001E             ;} X = ([BG2 Y scroll] % 10h * 2 + 1Eh) % 20h (HDMA data table end index)
$88:C60F 29 1E 00    AND #$001E             ;|
$88:C612 AA          TAX                    ;/
$88:C613 A9 0F 00    LDA #$000F             ;\
$88:C616 85 12       STA $12    [$7E:0012]  ;} $12 = Fh (loop counter)

; LOOP
$88:C618 A5 B5       LDA $B5    [$7E:00B5]  ;\
$88:C61A 18          CLC                    ;|
$88:C61B 79 6E C4    ADC $C46E,y[$88:C470]  ;} Water BG2 X scroll HDMA data table entry = [BG2 X scroll] + [$C46E + [Y]]
$88:C61E 9F 48 9C 7E STA $7E9C48,x[$7E:9C66];/
$88:C622 CA          DEX                    ;\
$88:C623 CA          DEX                    ;|
$88:C624 8A          TXA                    ;} X = ([X] - 2) % 20h (previous HDMA data table entry)
$88:C625 29 1E 00    AND #$001E             ;|
$88:C628 AA          TAX                    ;/
$88:C629 88          DEY                    ;\
$88:C62A 88          DEY                    ;|
$88:C62B 98          TYA                    ;} Y = ([Y] - 2) % 20h (previous wave displacement table entry)
$88:C62C 29 1E 00    AND #$001E             ;|
$88:C62F A8          TAY                    ;/
$88:C630 C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$88:C632 10 E4       BPL $E4    [$C618]     ; If [$12] >= 0: go to LOOP
$88:C634 FA          PLX
$88:C635 60          RTS
}


;;; $C636: Set up water BG2 X scroll data table - not wavy ;;;
{
$88:C636 DA          PHX                    ;\
$88:C637 A2 1E       LDX #$1E               ;|
$88:C639 A5 B5       LDA $B5    [$7E:00B5]  ;|
                                            ;|
$88:C63B 9F 48 9C 7E STA $7E9C48,x[$7E:9C66];} $7E:9C48..67 = [BG2 X scroll]
$88:C63F CA          DEX                    ;|
$88:C640 CA          DEX                    ;|
$88:C641 10 F8       BPL $F8    [$C63B]     ;|
$88:C643 FA          PLX                    ;/
$88:C644 60          RTS
}


;;; $C645: Indirect HDMA table - water BG3 X scroll ;;;
{
$88:C645             dx 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00,
                        81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00, 81,9C00

$88:C945             dx 81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        81,9C04, 81,9C06, 81,9C08, 81,9C0A, 81,9C0C, 81,9C0E, 81,9C10, 81,9C12, 81,9C14, 81,9C16, 81,9C18, 81,9C1A, 81,9C1C, 81,9C1E, 81,9C20, 81,9C22,
                        00
}


;;; $CF46: Indirect HDMA table - water BG2 X scroll ;;;
{
$88:CF46             dx 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,
                        81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44, 81,9C44,

                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        81,9C48, 81,9C4A, 81,9C4C, 81,9C4E, 81,9C50, 81,9C52, 81,9C54, 81,9C56, 81,9C58, 81,9C5A, 81,9C5C, 81,9C5E, 81,9C60, 81,9C62, 81,9C64, 81,9C66,
                        00
}


;;; $D847: Instruction list - water BG2 X scroll ;;;
{
$88:D847             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        C582,       ; HDMA object phase increase timer = 1
                        8570,88C589,; Pre-instruction = $88:C589
                        8682        ; Sleep
}


;;; $D856: Instruction list - water BG3 X scroll ;;;
{
$88:D856             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        C467,       ; HDMA object phase increase timer = 1
                        8570,88C48E,; Pre-instruction = $88:C48E
                        8682        ; Sleep
}
}
}


;;; $D865..DD: BG3 scroll HDMA object ;;;
{
;;; $D865: Spawn BG3 scroll HDMA object ;;;
{
; Applies an HDMA that sets BG3 scrolls to [$7E:CAD8]/[$7E:CADA] every line of the HUD and [$7E:CADC]/[$7E:CADE] after the last line of the HUD
; Spawned by:
;     Lava, acid, water, rain, spores, Tourian entrance statue
;     Draygon's body initialisation
;     Door transition after scrolling finishes and before the screen fades in
$88:D865 22 0A 84 88 JSL $88840A[$88:840A]  ;\
$88:D869             dx 43, 11, D8D0        ;} Spawn indirect HDMA object for BG3 scroll with instruction list $D8D0
$88:D86D 6B          RTL
}


;;; $D86E: RTL ;;;
{
$88:D86E 6B          RTL
}


;;; $D86F: Indirect HDMA table - BG3 scroll ;;;
{
$88:D86F             dx 81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CAD8,
                        81,CADC,
                        00
}


;;; $D8D0: Instruction list - BG3 scroll ;;;
{
$88:D8D0             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E     ; Indirect HDMA data bank = $7E
$88:D8D6             dx 7FFF,D86F,
                        85EC,D8D6   ; Go to $D8D6
}
}


;;; $D8DE..D927: FX type 28h: Ceres Ridley ;;;
{
;;; $D8DE: FX type 28h: Ceres Ridley ;;;
{
$88:D8DE 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:D8E2             dx 40, 05, D906        ;} Spawn indirect HDMA object for mode and BG tile size with instruction list $D906
$88:D8E6 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:D8EA             dx 00, 2C, D91D        ;} Spawn HDMA object for main screen layers with instruction list $D91D
$88:D8EE 6B          RTL
}


;;; $D8EF: RTL ;;;
{
$88:D8EF 6B          RTL
}


;;; $D8F0: Indirect HDMA table - Ceres Ridley mode and BG tile size ;;;
{
$88:D8F0             dx 1F,07EB,
                        60,07EC,
                        50,07EC,
                        10,07EB,
                        00
}


;;; $D8FD: HDMA table - Ceres Ridley main screen layers ;;;
{
$88:D8FD             db 1F,04, ;         BG3
                        60,13, ; BG1/BG2/    sprites
                        50,13, ; BG1/BG2/    sprites
                        10,12, ;     BG2/    sprites
                        00
}


;;; $D906: Instruction list - Ceres Ridley mode and BG tile size ;;;
{
$88:D906             dx 8655,88,    ; HDMA table bank = $88
                        866A,00,    ; Indirect HDMA data bank = $00
                        D916        ; Video mode for HUD and floor = 1
$88:D90E             dx 7FFF,D8F0,
                        85EC,D90E   ; Go to $D90E
}


;;; $D916: Instruction - video mode for HUD and floor = 1 ;;;
{
$88:D916 A9 09 00    LDA #$0009
$88:D919 8D EB 07    STA $07EB  [$7E:07EB]
$88:D91C 60          RTS
}


;;; $D91D: Instruction list - Ceres Ridley main screen layers ;;;
{
$88:D91D             dx 8655,88     ; HDMA table bank = $88
$88:D920             dx 7FFF,D8FD,
                        85EC,D920   ; Go to $D920
}
}


;;; $D928..4F: FX type 2Ah: Ceres elevator ;;;
{
;;; $D928: FX type 2Ah: Ceres elevator ;;;
{
$88:D928 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:D92C             dx 40, 05, D939        ;} Spawn indirect HDMA object for mode and BG tile size with instruction list $D939
$88:D930 6B          RTL
}


;;; $D931: RTL ;;;
{
$88:D931 6B          RTL
}


;;; $D932: Indirect HDMA table - Ceres elevator mode and BG tile size ;;;
{
$88:D932             dx 1F,07EB,
                        70,07EC,
                        00
}


;;; $D939: Instruction list - Ceres elevator mode and BG tile size ;;;
{
$88:D939             dx 8655,88,    ; HDMA table bank = $88
                        866A,00,    ; Indirect HDMA data bank = $00
                        D949,       ; Video mode for HUD = 1
$88:D941             dx 7FFF,D932,
                        85EC,D941   ; Go to $D941
}


;;; $D949: Instruction - video mode for HUD = 1 ;;;
{
$88:D949 A9 09 00    LDA #$0009
$88:D94C 8D EB 07    STA $07EB  [$7E:07EB]
$88:D94F 60          RTS
}
}


;;; $D950..DA10: FX type Ah: rain ;;;
{
;;; $D950: FX type Ah: rain ;;;
{
$88:D950 E2 20       SEP #$20
$88:D952 A9 5C       LDA #$5C               ;\
$88:D954 85 5B       STA $5B    [$7E:005B]  ;} BG3 tilemap base address = $5C00, size = 32x32
$88:D956 C2 20       REP #$20
$88:D958 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:D95C             dx 43, 11, D96C        ;} Spawn indirect HDMA object for BG3 scroll with instruction list $D96C
$88:D960 22 65 D8 88 JSL $88D865[$88:D865]  ; Spawn BG3 scroll HDMA object
$88:D964 A0 E7 82    LDY #$82E7             ;\
$88:D967 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn rain animated tiles object
$88:D96B 6B          RTL
}


;;; $D96C: Instruction list - rain BG3 scroll ;;;
{
$88:D96C             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        D981,       ; HDMA object BG3 X velocity = randomly ±400h/±600h
                        8570,88D9A1 ; Pre-instruction = $88:D9A1
$88:D979             dx 7FFF,D86F,  ; <-- this is the BG3 scroll HDMA object HDMA table
                        85EC,D979   ; Go to $D979
}


;;; $D981: Instruction - HDMA object BG3 X velocity = randomly ±400h/±600h ;;;
{
$88:D981 DA          PHX                    ;\
$88:D982 AD E5 05    LDA $05E5  [$7E:05E5]  ;|
$88:D985 4A          LSR A                  ;|
$88:D986 29 06 00    AND #$0006             ;|
$88:D989 AA          TAX                    ;} HDMA object BG3 X velocity = [$D992 + [random number] / 4 % 4 * 2]
$88:D98A BD 92 D9    LDA $D992,x[$88:D994]  ;|
$88:D98D FA          PLX                    ;|
$88:D98E 9D 38 19    STA $1938,x[$7E:193A]  ;/
$88:D991 60          RTS

; BG3 X velocities. Unit 1/100h px/frame
$88:D992             dw FA00, 0600, FC00, 0400
}


;;; $D99A: Unused. Indirect HDMA table ;;;
{
; Looks like a more space-efficient version of $88:D86F
$88:D99A             dx 1F,CAD8,
                        81,CADC,
                        00
}


;;; $D9A1: Pre-instruction - rain BG3 scroll ;;;
{
$88:D9A1 8B          PHB
$88:D9A2 A0 5C       LDY #$5C               ;\
$88:D9A4 84 5B       STY $5B    [$7E:005B]  ;} BG3 tilemap base address = $5C00, size = 32x32
$88:D9A6 AD 84 19    LDA $1984  [$7E:1984]  ;\
$88:D9A9 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = [FX layer 3 layer blending configuration]
$88:D9AC AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:D9AF F0 02       BEQ $02    [$D9B3]     ;} If time is frozen:
$88:D9B1 AB          PLB
$88:D9B2 6B          RTL                    ; Return

$88:D9B3 BD 44 19    LDA $1944,x[$7E:1946]  ;\
$88:D9B6 38          SEC                    ;|
$88:D9B7 ED 15 09    SBC $0915  [$7E:0915]  ;|
$88:D9BA 85 12       STA $12    [$7E:0012]  ;|
$88:D9BC BD 14 19    LDA $1914,x[$7E:1916]  ;|
$88:D9BF EB          XBA                    ;|
$88:D9C0 10 05       BPL $05    [$D9C7]     ;|
$88:D9C2 09 00 FF    ORA #$FF00             ;} BG3 Y position = [HDMA object previous layer 1 Y position] - [layer 1 Y position] + [HDMA object BG3 Y offset] / 100h
$88:D9C5 80 03       BRA $03    [$D9CA]     ;|
                                            ;|
$88:D9C7 29 FF 00    AND #$00FF             ;|
                                            ;|
$88:D9CA 18          CLC                    ;|
$88:D9CB 65 12       ADC $12    [$7E:0012]  ;|
$88:D9CD 8F DE CA 7E STA $7ECADE[$7E:CADE]  ;/
$88:D9D1 BD 14 19    LDA $1914,x[$7E:1916]  ;\
$88:D9D4 18          CLC                    ;|
$88:D9D5 69 00 FA    ADC #$FA00             ;} HDMA object BG3 Y offset -= 600h
$88:D9D8 9D 14 19    STA $1914,x[$7E:1916]  ;/
$88:D9DB AD 15 09    LDA $0915  [$7E:0915]  ;\
$88:D9DE 9D 44 19    STA $1944,x[$7E:1946]  ;} HDMA object previous layer 1 Y position = [layer 1 Y position]
$88:D9E1 BD 50 19    LDA $1950,x[$7E:1952]  ;\
$88:D9E4 38          SEC                    ;|
$88:D9E5 ED 11 09    SBC $0911  [$7E:0911]  ;|
$88:D9E8 85 12       STA $12    [$7E:0012]  ;|
$88:D9EA BD 20 19    LDA $1920,x[$7E:1922]  ;|
$88:D9ED EB          XBA                    ;|
$88:D9EE 10 05       BPL $05    [$D9F5]     ;|
$88:D9F0 09 00 FF    ORA #$FF00             ;} BG3 X position = [HDMA object previous layer 1 X position] - [layer 1 X position] + [HDMA object BG3 X offset] / 100h
$88:D9F3 80 03       BRA $03    [$D9F8]     ;|
                                            ;|
$88:D9F5 29 FF 00    AND #$00FF             ;|
                                            ;|
$88:D9F8 18          CLC                    ;|
$88:D9F9 65 12       ADC $12    [$7E:0012]  ;|
$88:D9FB 8F DC CA 7E STA $7ECADC[$7E:CADC]  ;/
$88:D9FF BD 20 19    LDA $1920,x[$7E:1922]  ;\
$88:DA02 18          CLC                    ;|
$88:DA03 7D 38 19    ADC $1938,x[$7E:193A]  ;} HDMA object BG3 X offset += [HDMA object BG3 X velocity]
$88:DA06 9D 20 19    STA $1920,x[$7E:1922]  ;/
$88:DA09 AD 11 09    LDA $0911  [$7E:0911]  ;\
$88:DA0C 9D 50 19    STA $1950,x[$7E:1952]  ;} HDMA object previous layer 1 X position = [layer 1 X position]
$88:DA0F AB          PLB
$88:DA10 6B          RTL
}
}


;;; $DA11..DB07: FX type 8: spores ;;;
{
;;; $DA11: FX type 8: spores ;;;
{
$88:DA11 E2 20       SEP #$20
$88:DA13 A9 5C       LDA #$5C               ;\
$88:DA15 85 5B       STA $5B    [$7E:005B]  ;} BG3 tilemap base address = $5C00, size = 32x32
$88:DA17 C2 20       REP #$20
$88:DA19 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DA1D             dx 42, 11, DA2D        ;} Spawn indirect HDMA object for BG3 X scroll with instruction list $DA2D
$88:DA21 22 65 D8 88 JSL $88D865[$88:D865]  ; Spawn BG3 scroll HDMA object
$88:DA25 A0 FD 82    LDY #$82FD             ;\
$88:DA28 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn spores animated tiles object
$88:DA2C 6B          RTL
}


;;; $DA2D: Instruction list - spores BG3 X scroll ;;;
{
$88:DA2D             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,88DA47 ; Pre-instruction = $88:DA47
$88:DA38             dx 7FFF,D86F,  ; <-- this is the BG3 scroll HDMA object HDMA table
                        85EC,DA38   ; Go to $DA38
}


;;; $DA40: Unused. Indirect HDMA table ;;;
{
; Looks like a more space-efficient version of $88:D86F
$88:DA40             dx 1F,CAD8,
                        81,CADC,
                        00
}


;;; $DA47: Pre-instruction - spores BG3 X scroll ;;;
{
$88:DA47 8B          PHB
$88:DA48 A0 5C       LDY #$5C               ;\
$88:DA4A 84 5B       STY $5B    [$7E:005B]  ;} BG3 tilemap base address = $5C00, size = 32x32
$88:DA4C AD 84 19    LDA $1984  [$7E:1984]  ;\
$88:DA4F 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = [FX layer 3 layer blending configuration]
$88:DA52 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:DA55 F0 02       BEQ $02    [$DA59]     ;} If time is frozen:
$88:DA57 AB          PLB
$88:DA58 6B          RTL                    ; Return

$88:DA59 BD 2C 19    LDA $192C,x[$7E:192C]  ;\
$88:DA5C EB          XBA                    ;|
$88:DA5D 10 05       BPL $05    [$DA64]     ;|
$88:DA5F 09 00 FF    ORA #$FF00             ;|
$88:DA62 80 03       BRA $03    [$DA67]     ;|
                                            ;} BG3 Y position = [layer 1 Y position] + ±[HDMA object BG3 Y offset] / 100h
$88:DA64 29 FF 00    AND #$00FF             ;|
                                            ;|
$88:DA67 18          CLC                    ;|
$88:DA68 6D 15 09    ADC $0915  [$7E:0915]  ;|
$88:DA6B 8F DE CA 7E STA $7ECADE[$7E:CADE]  ;/
$88:DA6F BD 2C 19    LDA $192C,x[$7E:192C]  ;\
$88:DA72 18          CLC                    ;|
$88:DA73 69 C0 FF    ADC #$FFC0             ;} HDMA object BG3 Y offset -= 40h
$88:DA76 9D 2C 19    STA $192C,x[$7E:192C]  ;/
$88:DA79 85 14       STA $14    [$7E:0014]
$88:DA7B BD 38 19    LDA $1938,x[$7E:1938]  ;\
$88:DA7E EB          XBA                    ;|
$88:DA7F 10 05       BPL $05    [$DA86]     ;|
$88:DA81 09 00 FF    ORA #$FF00             ;|
$88:DA84 80 03       BRA $03    [$DA89]     ;|
                                            ;} BG3 X position = [layer 1 X position] + ±[HDMA object BG3 X offset] / 100h
$88:DA86 29 FF 00    AND #$00FF             ;|
                                            ;|
$88:DA89 18          CLC                    ;|
$88:DA8A 6D 11 09    ADC $0911  [$7E:0911]  ;|
$88:DA8D 8F DC CA 7E STA $7ECADC[$7E:CADC]  ;/
$88:DA91 85 12       STA $12    [$7E:0012]
$88:DA93 BD 38 19    LDA $1938,x[$7E:1938]  ;\
$88:DA96 18          CLC                    ;|
$88:DA97 69 00 00    ADC #$0000             ;} >_<;
$88:DA9A 9D 38 19    STA $1938,x[$7E:1938]  ;/
$88:DA9D AB          PLB
$88:DA9E 6B          RTL
}


;;; $DA9F: Unused. Handle spores waviness ;;;
{
;; Parameters:
;;     $12: X position of screen on Samus??
;;     $14: Y position of screen on FX?

; The above routine $DA47 does store values to $12 and $14 that it doesn't use itself,
; however those values don't look right for the usage here, and this routine doesn't PLB before returning,
; which the above routine would need. So I don't think this is an unused section of that routine

$88:DA9F DE 20 19    DEC $1920,x            ; Decrement HDMA object phase increase timer
$88:DAA2 D0 11       BNE $11    [$DAB5]     ; If [HDMA object phase increase timer] = 0:
$88:DAA4 A9 0A 00    LDA #$000A             ;\
$88:DAA7 9D 20 19    STA $1920,x            ;} HDMA object phase increase timer = Ah
$88:DAAA BD 14 19    LDA $1914,x            ;\
$88:DAAD 1A          INC A                  ;|
$88:DAAE 1A          INC A                  ;} HDMA object wave phase = ([HDMA object wave phase] + 2) % 20h
$88:DAAF 29 1F 00    AND #$001F             ;|
$88:DAB2 9D 14 19    STA $1914,x            ;/

$88:DAB5 BD 14 19    LDA $1914,x            ;\
$88:DAB8 AA          TAX                    ;} X = [HDMA object wave phase] (HDMA data table end index)
$88:DAB9 A0 1E       LDY #$1E               ; Y = 1Eh (wave displacement table index)

; LOOP
$88:DABB A5 12       LDA $12    [$7E:0012]  ;\
$88:DABD 18          CLC                    ;|
$88:DABE 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;} Spores BG3 X scroll HDMA data table entry = [Samus X position] + [$12] + [$DAE8 + [Y]]
$88:DAC1 79 E8 DA    ADC $DAE8,y            ;|
$88:DAC4 9F 04 9C 7E STA $7E9C04,x          ;/
$88:DAC8 8A          TXA                    ;\
$88:DAC9 3A          DEC A                  ;|
$88:DACA 3A          DEC A                  ;} X = ([X] - 2) % 20h (previous HDMA data table entry)
$88:DACB 29 1F 00    AND #$001F             ;|
$88:DACE AA          TAX                    ;/
$88:DACF 88          DEY                    ;\
$88:DAD0 88          DEY                    ;} Y -= 2 (previous wave displacement table entry)
$88:DAD1 10 E8       BPL $E8    [$DABB]     ; If [Y] >= 0: go to LOOP
$88:DAD3 AE B2 18    LDX $18B2  [$7E:18B2]  ; X = [HDMA object index]
$88:DAD6 A9 F0 FF    LDA #$FFF0             ;\
$88:DAD9 14 14       TRB $14    [$7E:0014]  ;} $14 -= [$14] % 10h
$88:DADB A5 14       LDA $14    [$7E:0014]  ;\
$88:DADD 0A          ASL A                  ;|
$88:DADE 18          CLC                    ;|
$88:DADF 65 14       ADC $14    [$7E:0014]  ;} HDMA object table pointer = $C945 + [$14] * 3
$88:DAE1 69 45 C9    ADC #$C945             ;|
$88:DAE4 9D D8 18    STA $18D8,x            ;/
$88:DAE7 6B          RTL

; Wave displacement table. Same as the $C46E table
$88:DAE8             dw 0000,0001,0001,0000,0000,FFFF,FFFF,0000,
                        0000,0001,0001,0000,0000,FFFF,FFFF,0000
}
}


;;; $DB08..89: FX type Ch: fog ;;;
{
;;; $DB08: FX type Ch: fog ;;;
{
$88:DB08 E2 20       SEP #$20
$88:DB0A A9 5C       LDA #$5C               ;\
$88:DB0C 85 5B       STA $5B    [$7E:005B]  ;} BG3 tilemap base address = $5C00, size = 32x32
$88:DB0E C2 20       REP #$20
$88:DB10 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DB14             dx 43, 11, DB19        ;} Spawn indirect HDMA object for BG3 scroll with instruction list $DB19
$88:DB18 6B          RTL
}


;;; $DB19: Instruction list - fog BG3 scroll ;;;
{
$88:DB19             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        DB2E,       ; NOP
                        8570,88DB36 ; Pre-instruction = $88:DB36
$88:DB26             dx 7FFF,D86F,  ; <-- this is the BG3 scroll HDMA object HDMA table
                        85EC,DB26,  ; Go to $DB26
}


;;; $DB2E: RTS ;;;
{
$88:DB2E 60          RTS
}


;;; $DB2F: Unused. Indirect HDMA table ;;;
{
; Looks like a more space-efficient version of $88:D86F
$88:DB2F             dx 1F,CAD8,
                        81,CADC,
                        00
}


;;; $DB36: Pre-instruction - fog BG3 scroll ;;;
{
$88:DB36 8B          PHB
$88:DB37 A0 5C       LDY #$5C               ;\
$88:DB39 84 5B       STY $5B    [$7E:005B]  ;} Gameplay BG3 tilemap base address = $5C00, size = 32x32
$88:DB3B AD 84 19    LDA $1984  [$7E:1984]  ;\
$88:DB3E 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = [FX layer 3 layer blending configuration]
$88:DB41 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:DB44 F0 02       BEQ $02    [$DB48]     ;} If time is frozen:
$88:DB46 AB          PLB
$88:DB47 6B          RTL                    ; Return

$88:DB48 BD 14 19    LDA $1914,x[$7E:1914]  ;\
$88:DB4B EB          XBA                    ;|
$88:DB4C 10 05       BPL $05    [$DB53]     ;|
$88:DB4E 09 00 FF    ORA #$FF00             ;|
$88:DB51 80 03       BRA $03    [$DB56]     ;|
                                            ;} BG3 Y position = [layer 1 Y position] + ±[HDMA object BG3 Y offset] / 100h
$88:DB53 29 FF 00    AND #$00FF             ;|
                                            ;|
$88:DB56 18          CLC                    ;|
$88:DB57 6D 15 09    ADC $0915  [$7E:0915]  ;|
$88:DB5A 8F DE CA 7E STA $7ECADE[$7E:CADE]  ;/
$88:DB5E BD 14 19    LDA $1914,x[$7E:1914]  ;\
$88:DB61 18          CLC                    ;|
$88:DB62 69 C0 FF    ADC #$FFC0             ;} HDMA object BG3 Y offset -= 40h
$88:DB65 9D 14 19    STA $1914,x[$7E:1914]  ;/
$88:DB68 BD 20 19    LDA $1920,x[$7E:1920]  ;\
$88:DB6B EB          XBA                    ;|
$88:DB6C 10 05       BPL $05    [$DB73]     ;|
$88:DB6E 09 00 FF    ORA #$FF00             ;|
$88:DB71 80 03       BRA $03    [$DB76]     ;|
                                            ;} BG3 X position = [layer 1 X position] + ±[HDMA object BG3 X offset] / 100h
$88:DB73 29 FF 00    AND #$00FF             ;|
                                            ;|
$88:DB76 18          CLC                    ;|
$88:DB77 6D 11 09    ADC $0911  [$7E:0911]  ;|
$88:DB7A 8F DC CA 7E STA $7ECADC[$7E:CADC]  ;/
$88:DB7E BD 20 19    LDA $1920,x[$7E:1920]  ;\
$88:DB81 18          CLC                    ;|
$88:DB82 69 50 00    ADC #$0050             ;} HDMA object BG3 X offset += 50h
$88:DB85 9D 20 19    STA $1920,x[$7E:1920]  ;/
$88:DB88 AB          PLB
$88:DB89 6B          RTL
}
}


;;; $DB8A..DD31: FX type 26h: Tourian entrance statue ;;;
{
;;; $DB8A: FX type 26h: Tourian entrance statue ;;;
{
$88:DB8A A9 0A 00    LDA #$000A             ;\
$88:DB8D 22 33 82 80 JSL $808233[$80:8233]  ;} If entrance to Tourian is unlocked:
$88:DB91 90 0F       BCC $0F    [$DBA2]     ;/
$88:DB93 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$88:DB97             dx 06, 0C, B777        ;} Spawn PLM to clear access to Tourian elevator at (6, Ch)
$88:DB9B A9 02 02    LDA #$0202             ;\
$88:DB9E 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;} Scroll 0..1 = green

$88:DBA2 E2 20       SEP #$20
$88:DBA4 A9 4A       LDA #$4A               ;\
$88:DBA6 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4800, size = 32x64
$88:DBA8 C2 20       REP #$20
$88:DBAA A9 28 C4    LDA #$C428             ;\
$88:DBAD 8D 6C 19    STA $196C  [$7E:196C]  ;} FX rising function = $C428
$88:DBB0 AD 78 19    LDA $1978  [$7E:1978]  ;\
$88:DBB3 8D 5E 19    STA $195E  [$7E:195E]  ;} FX Y position = [FX base Y position]
$88:DBB6 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DBBA             dx 42, 11, D856        ;} Spawn indirect HDMA object for BG3 X scroll with instruction list $D856
$88:DBBE 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DBC2             dx 42, 10, DCFA        ;} Spawn indirect HDMA object for BG2 Y scroll with instruction list $DCFA
$88:DBC6 22 65 D8 88 JSL $88D865[$88:D865]  ; Spawn BG3 scroll HDMA object
$88:DBCA 6B          RTL
}


;;; $DBCB: Set Tourian entrance statue BG2 Y scroll ;;;
{
$88:DBCB BD 20 19    LDA $1920,x[$7E:1922]  ;\
$88:DBCE 18          CLC                    ;|
$88:DBCF 6D 15 09    ADC $0915  [$7E:0915]  ;} Tourian entrance statue BG2 Y scroll = [layer 1 Y position] + [HDMA object $1920]
$88:DBD2 8F 00 9E 7E STA $7E9E00[$7E:9E00]  ;/
$88:DBD6 60          RTS
}


;;; $DBD7: Pre-instruction - Tourian entrance statue BG2 Y scroll - wait for locks to be released ;;;
{
$88:DBD7 08          PHP
$88:DBD8 C2 30       REP #$30
$88:DBDA A9 06 00    LDA #$0006             ;\
$88:DBDD 22 33 82 80 JSL $808233[$80:8233]  ;} If Phantoon statue is grey:
$88:DBE1 90 3B       BCC $3B    [$DC1E]     ;/
$88:DBE3 A9 07 00    LDA #$0007             ;\
$88:DBE6 22 33 82 80 JSL $808233[$80:8233]  ;} If Ridley statue is grey:
$88:DBEA 90 32       BCC $32    [$DC1E]     ;/
$88:DBEC A9 08 00    LDA #$0008             ;\
$88:DBEF 22 33 82 80 JSL $808233[$80:8233]  ;} If Draygon statue is grey:
$88:DBF3 90 29       BCC $29    [$DC1E]     ;/
$88:DBF5 A9 09 00    LDA #$0009             ;\
$88:DBF8 22 33 82 80 JSL $808233[$80:8233]  ;} If Kraid statue is grey:
$88:DBFC 90 20       BCC $20    [$DC1E]     ;/
$88:DBFE A9 10 00    LDA #$0010             ;\
$88:DC01 0C 6F 1E    TSB $1E6F  [$7E:1E6F]  ;} Tourian entrance statue animation state |= 10h
$88:DC04 AD 6F 1E    LDA $1E6F  [$7E:1E6F]  ;\
$88:DC07 30 15       BMI $15    [$DC1E]     ;} If not busy releasing lock of a boss:
$88:DC09 A9 2C 01    LDA #$012C             ;\
$88:DC0C 9D 2C 19    STA $192C,x[$7E:192E]  ;} HDMA object descent delay timer = 300
$88:DC0F AE B2 18    LDX $18B2  [$7E:18B2]
$88:DC12 A9 01 00    LDA #$0001             ;\
$88:DC15 9D E4 18    STA $18E4,x[$7E:18E6]  ;} HDMA object instruction timer = 1
$88:DC18 FE CC 18    INC $18CC,x[$7E:18CE]  ;\
$88:DC1B FE CC 18    INC $18CC,x[$7E:18CE]  ;} HDMA object instruction list pointer += 2

$88:DC1E 20 CB DB    JSR $DBCB  [$88:DBCB]  ; Set Tourian entrance statue BG2 Y scroll
$88:DC21 28          PLP
$88:DC22 6B          RTL
}


;;; $DC23: Pre-instruction - Tourian entrance statue BG2 Y scroll - descent delay ;;;
{
$88:DC23 20 1D B2    JSR $B21D  [$88:B21D]  ; Handle earthquake sound effect
$88:DC26 A9 0D 00    LDA #$000D             ;\
$88:DC29 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 and BG2, 2 pixel displacement, vertical
$88:DC2C A9 20 00    LDA #$0020             ;\
$88:DC2F 0C 40 18    TSB $1840  [$7E:1840]  ;} Earthquake timer = 20h+
$88:DC32 DE 2C 19    DEC $192C,x[$7E:192E]  ; Decrement HDMA object descent delay timer
$88:DC35 10 2E       BPL $2E    [$DC65]     ; If [HDMA object descent delay timer] < 0:
$88:DC37 C2 30       REP #$30
$88:DC39 A0 84 AF    LDY #$AF84             ;\
$88:DC3C 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Tourian statue dust clouds enemy projectile
$88:DC40 A0 84 AF    LDY #$AF84             ;\
$88:DC43 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Tourian statue dust clouds enemy projectile
$88:DC47 A0 84 AF    LDY #$AF84             ;\
$88:DC4A 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Tourian statue dust clouds enemy projectile
$88:DC4E A0 84 AF    LDY #$AF84             ;\
$88:DC51 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Tourian statue dust clouds enemy projectile
$88:DC55 E2 10       SEP #$10
$88:DC57 C2 20       REP #$20
$88:DC59 A9 01 00    LDA #$0001             ;\
$88:DC5C 9D E4 18    STA $18E4,x[$7E:18E6]  ;} HDMA object instruction timer = 1
$88:DC5F FE CC 18    INC $18CC,x[$7E:18CE]  ;\
$88:DC62 FE CC 18    INC $18CC,x[$7E:18CE]  ;} HDMA object instruction list pointer += 2

$88:DC65 20 CB DB    JSR $DBCB  [$88:DBCB]  ; Set Tourian entrance statue BG2 Y scroll
$88:DC68 6B          RTL
}


;;; $DC69: Pre-instruction - Tourian entrance statue BG2 Y scroll - descending ;;;
{
$88:DC69 20 1D B2    JSR $B21D  [$88:B21D]  ; Handle earthquake sound effect
$88:DC6C A9 0D 00    LDA #$000D             ;\
$88:DC6F 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 and BG2, 2 pixel displacement, vertical
$88:DC72 A9 20 00    LDA #$0020             ;\
$88:DC75 0C 40 18    TSB $1840  [$7E:1840]  ;} Earthquake timer = 20h+
$88:DC78 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$88:DC7B D0 3C       BNE $3C    [$DCB9]     ;} If time if frozen: return
$88:DC7D BD 14 19    LDA $1914,x[$7E:1916]  ;\
$88:DC80 18          CLC                    ;|
$88:DC81 69 00 C0    ADC #$C000             ;|
$88:DC84 9D 14 19    STA $1914,x[$7E:1916]  ;} HDMA object BG2 Y offset -= 0.4000h
$88:DC87 BD 20 19    LDA $1920,x[$7E:1922]  ;|
$88:DC8A 69 FF FF    ADC #$FFFF             ;|
$88:DC8D 9D 20 19    STA $1920,x[$7E:1922]  ;/
$88:DC90 C9 10 FF    CMP #$FF10             ;\
$88:DC93 D0 21       BNE $21    [$DCB6]     ;} If [HDMA object BG2 Y offset] = -90h:
$88:DC95 DA          PHX                    ;\
$88:DC96 08          PHP                    ;|
$88:DC97 C2 10       REP #$10               ;|
$88:DC99 22 D7 83 84 JSL $8483D7[$84:83D7]  ;} Spawn PLM to crumble access to Tourian elevator at (6, Ch)
$88:DC9D             dx 06, 0C, B773        ;|
$88:DCA1 28          PLP                    ;|
$88:DCA2 FA          PLX                    ;/
$88:DCA3 A9 0A 00    LDA #$000A             ;\
$88:DCA6 22 FA 81 80 JSL $8081FA[$80:81FA]  ;} Mark entrance to Tourian is unlocked event
$88:DCAA A9 01 00    LDA #$0001             ;\
$88:DCAD 9D E4 18    STA $18E4,x[$7E:18E6]  ;} HDMA object instruction timer = 1
$88:DCB0 FE CC 18    INC $18CC,x[$7E:18CE]  ;\
$88:DCB3 FE CC 18    INC $18CC,x[$7E:18CE]  ;} HDMA object instruction list pointer += 2

$88:DCB6 20 CB DB    JSR $DBCB  [$88:DBCB]  ; Set Tourian entrance statue BG2 Y scroll

$88:DCB9 6B          RTL
}


;;; $DCBA: Pre-instruction - Tourian entrance statue BG2 Y scroll - enable scrolling ;;;
{
$88:DCBA A9 00 80    LDA #$8000             ;\
$88:DCBD 8D 6D 1E    STA $1E6D  [$7E:1E6D]  ;} Tourian entrance statue finished processing flag = 8000h
$88:DCC0 A9 02 02    LDA #$0202             ;\
$88:DCC3 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;} Scroll 0..1 = green
$88:DCC7 20 CB DB    JSR $DBCB  [$88:DBCB]  ; Set Tourian entrance statue BG2 Y scroll
$88:DCCA 6B          RTL
}


;;; $DCCB: Instruction - go to [[Y]] if entrance to Tourian is unlocked ;;;
{
$88:DCCB 9E 2C 19    STZ $192C,x[$7E:192E]  ; HDMA object $192C = 0
$88:DCCE 9E 14 19    STZ $1914,x[$7E:1916]  ; HDMA object $1914 = 0
$88:DCD1 A9 0A 00    LDA #$000A             ;\
$88:DCD4 22 33 82 80 JSL $808233[$80:8233]  ;} If entrance to Tourian is not unlocked:
$88:DCD8 B0 11       BCS $11    [$DCEB]     ;/
$88:DCDA 9E 20 19    STZ $1920,x[$7E:1922]  ; HDMA object $1920 = 0
$88:DCDD 8F 00 9E 7E STA $7E9E00[$7E:9E00]  ; $7E:9E00 = 0
$88:DCE1 A9 01 00    LDA #$0001             ;\
$88:DCE4 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;} Scroll 0 = blue
$88:DCE8 C8          INY                    ;\
$88:DCE9 C8          INY                    ;} Y += 2
$88:DCEA 60          RTS                    ; Return

$88:DCEB A9 10 FF    LDA #$FF10             ;\
$88:DCEE 9D 20 19    STA $1920,x            ;} $7E:9E00 = HDMA object $1920 = FF10h
$88:DCF1 8F 00 9E 7E STA $7E9E00[$7E:9E00]  ;/
$88:DCF5 B9 00 00    LDA $0000,y            ;\
$88:DCF8 A8          TAY                    ;} Y = [[Y]]
$88:DCF9 60          RTS
}


;;; $DCFA: Instruction list - Tourian entrance statue BG2 Y scroll ;;;
{
$88:DCFA             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        DCCB,DD1D,  ; Go to $DD1D if entrance to Tourian is unlocked
                        8570,88DBD7,; Pre-instruction = $88:DBD7
                        0001,DD28,
                        8682,       ; Sleep
                        8570,88DC23,; Pre-instruction = $88:DC23
                        8682,       ; Sleep
                        8570,88DC69,; Pre-instruction = $88:DC69
                        8682        ; Sleep
$88:DD1D             dx 8570,88DCBA,; Pre-instruction = $88:DCBA
                        0001,DD28,
                        8682        ; Sleep
}


;;; $DD28: Indirect HDMA table - Tourian entrance statue BG2 Y scroll ;;;
{
$88:DD28             dx 1F,9E00,
                        01,9E00,
                        01,9E00,
                        00
}
}


;;; $DD32..DDC6: Bomb Torizo haze ;;;
{
;;; $DD32: Spawn Bomb Torizo haze ;;;
{
$88:DD32 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DD36             dx 02, 32, DD4A        ;} Spawn HDMA object for colour math subscreen backdrop colour with instruction list $DD4A
$88:DD3A 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DD3E             dx 00, 32, DD62        ;} Spawn HDMA object for colour math subscreen backdrop colour with instruction list $DD62
$88:DD42 6B          RTL
}


;;; $DD43: Pre-instruction - Bomb Torizo haze colour math subscreen backdrop colour ;;;
{
; By default, empty space in BG3 is blank tiles, not transparent tiles, to support the blending of foregrounds like water
; Hence, the colour math backdrop has no effect when BG3 is enabled for colour math, hence why it's disabled here
$88:DD43 A9 2C 00    LDA #$002C             ;\
$88:DD46 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 2Ch (normal, but BG3 is disabled)
$88:DD49 6B          RTL
}


;;; $DD4A: Instruction list - Bomb Torizo haze colour math subscreen backdrop colour - green and red components ;;;
{
$88:DD4A             dx 8655,88,    ; HDMA table bank = $88
                        866A,88,    ; Indirect HDMA data bank = $88
                        8570,88DD43,; Pre-instruction = $88:DD43
                        0001,DD61,
                        7777,DD75,
                        85EC,DD59   ; Go to $DD59
}


;;; $DD61: HDMA table - nothing ;;;
{
$88:DD61             db 00
}


;;; $DD62: Instruction list - Bomb Torizo haze colour math subscreen backdrop colour - blue component ;;;
{
$88:DD62             dx 8655,88,    ; HDMA table bank = $88
                        866A,88,    ; Indirect HDMA data bank = $88
                        0001,DD74,
                        7777,DDA6,
                        85EC,DD6C   ; Go to $DD6C
}


;;; $DD74: HDMA table - nothing ;;;
{
$88:DD74             db 00
}


;;; $DD75: HDMA table - Bomb Torizo haze colour math subscreen backdrop colour - green and red components ;;;
{
$88:DD75             db 48,20,40,
                        0A,21,41,
                        0A,21,41,
                        0A,21,41,
                        0A,22,42,
                        0A,22,42,
                        0A,22,42,
                        0A,23,43,
                        0A,23,43,
                        0A,23,43,
                        0A,24,44,
                        0A,24,44,
                        0A,24,44,
                        0A,25,45,
                        0A,25,45,
                        0A,25,45,
                        00
}


;;; $DDA6: HDMA table - Bomb Torizo haze colour math subscreen backdrop colour - blue component ;;;
{
$88:DDA6             db 48,80,
                        0A,81,
                        0A,81,
                        0A,82,
                        0A,82,
                        0A,83,
                        0A,83,
                        0A,84,
                        0A,84,
                        0A,85,
                        0A,85,
                        0A,86,
                        0A,86,
                        0A,87,
                        0A,87,
                        0A,88,
                        00
}
}


;;; $DDC7..DF33: FX type 2Ch: Ceres haze ;;;
{
;;; $DDC7: FX type 2Ch: Ceres haze ;;;
{
$88:DDC7 A9 01 00    LDA #$0001             ;\
$88:DDCA 22 DC 81 80 JSL $8081DC[$80:81DC]  ;} If Ceres Ridley's not dead:
$88:DDCE B0 09       BCS $09    [$DDD9]     ;/
$88:DDD0 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DDD4             dx 40, 32, DED3        ;} Spawn indirect HDMA object for colour math subscreen backdrop colour with instruction list $DED3
$88:DDD8 6B          RTL                    ; Return

$88:DDD9 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DDDD             dx 40, 32, DEEB        ;} Spawn indirect HDMA object for colour math subscreen backdrop colour with instruction list $DEEB
$88:DDE1 6B          RTL
}


;;; $DDE2: Unused. Set Ceres haze pre-instruction for no fade ;;;
{
$88:DDE2 A9 E8 DD    LDA #$DDE8             ;\
$88:DDE5 9D F0 18    STA $18F0,x            ;} HDMA object pre-instruction = $DDE8
}


;;; $DDE8: Unused. Pre-instruction - Ceres haze colour math subscreen backdrop colour - no fade ;;;
{
; I assume this routine was used before they realised they needed to handle door transition fade
$88:DDE8 A0 20       LDY #$20               ;\
$88:DDEA 84 74       STY $74    [$7E:0074]  ;|
$88:DDEC A0 40       LDY #$40               ;|
$88:DDEE 84 75       STY $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$88:DDF0 A0 80       LDY #$80               ;|
$88:DDF2 84 76       STY $76    [$7E:0076]  ;/
$88:DDF4 A9 2C 00    LDA #$002C             ;\
$88:DDF7 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 2Ch (normal, but BG3 is disabled)
$88:DDFA E2 20       SEP #$20
$88:DDFC DA          PHX
$88:DDFD BD 20 19    LDA $1920,x            ;\
$88:DE00 09 0F       ORA #$0F               ;} A = [HDMA object colour component flags] | Fh
$88:DE02 A2 0F       LDX #$0F               ; X = Fh

; LOOP
$88:DE04 9F 00 9D 7E STA $7E9D00,x          ; $7E:9D00 + [X] = [A]
$88:DE08 3A          DEC A                  ; Decrement A
$88:DE09 CA          DEX                    ; Decrement X
$88:DE0A 10 F8       BPL $F8    [$DE04]     ; If [X] >= 0: go to LOOP
$88:DE0C FA          PLX
$88:DE0D C2 20       REP #$20
$88:DE0F 6B          RTL
}


;;; $DE10: Pre-instruction - Ceres haze colour math subscreen backdrop colour - Ceres Ridley alive ;;;
{
$88:DE10 A9 80 00    LDA #$0080             ; A = 80h (blue intensity)
$88:DE13 80 03       BRA $03    [$DE18]     ; Go to set up Ceres haze colour math subscreen backdrop colour HDMA object pre-instruction for fading in
}


;;; $DE15: Pre-instruction - Ceres haze colour math subscreen backdrop colour - Ceres Ridley dead ;;;
{
$88:DE15 A9 20 00    LDA #$0020             ; A = 20h (red intensity)
}


;;; $DE18: Set up Ceres haze colour math subscreen backdrop colour HDMA object pre-instruction for fading in ;;;
{
$88:DE18 9D 20 19    STA $1920,x[$7E:1920]  ; HDMA object colour component flags = [A]
$88:DE1B 9E 14 19    STZ $1914,x[$7E:1914]  ; HDMA object max colour intensity = 0
$88:DE1E AD 9C 09    LDA $099C  [$7E:099C]  ;\
$88:DE21 C9 37 E7    CMP #$E737             ;} If [door transition function] != $E737 (fading in):
$88:DE24 F0 01       BEQ $01    [$DE27]     ;/
$88:DE26 6B          RTL                    ; Return

$88:DE27 A9 2D DE    LDA #$DE2D             ;\
$88:DE2A 9D F0 18    STA $18F0,x[$7E:18F0]  ;} HDMA object pre-instruction = $DE2D
}


;;; $DE2D: Pre-instruction - Ceres haze colour math subscreen backdrop colour - fading in ;;;
{
$88:DE2D A0 20       LDY #$20               ;\
$88:DE2F 84 74       STY $74    [$7E:0074]  ;|
$88:DE31 A0 40       LDY #$40               ;|
$88:DE33 84 75       STY $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$88:DE35 A0 80       LDY #$80               ;|
$88:DE37 84 76       STY $76    [$7E:0076]  ;/
$88:DE39 A9 2C 00    LDA #$002C             ;\
$88:DE3C 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 2Ch (normal, but BG3 is disabled)
$88:DE3F BD 14 19    LDA $1914,x[$7E:1914]  ;\
$88:DE42 C9 10 00    CMP #$0010             ;} If [HDMA object max colour intensity] = 10h: go to BRANCH_DONE
$88:DE45 F0 26       BEQ $26    [$DE6D]     ;/
$88:DE47 DA          PHX
$88:DE48 08          PHP
$88:DE49 E2 20       SEP #$20
$88:DE4B BD 20 19    LDA $1920,x[$7E:1920]  ;\
$88:DE4E 85 14       STA $14    [$7E:0014]  ;} $14 = [HDMA object colour component flags]
$88:DE50 BD 14 19    LDA $1914,x[$7E:1914]  ; A = [HDMA object max colour intensity]
$88:DE53 A2 0F       LDX #$0F               ; X = Fh

; LOOP
$88:DE55 85 12       STA $12    [$7E:0012]  ;\
$88:DE57 05 14       ORA $14    [$7E:0014]  ;|
$88:DE59 9F 00 9D 7E STA $7E9D00,x[$7E:9D0F];} $7E:9D00 + [X] = [$14] | [A]
$88:DE5D A5 12       LDA $12    [$7E:0012]  ;/
$88:DE5F 3A          DEC A                  ;\
$88:DE60 10 02       BPL $02    [$DE64]     ;} A = max(0, [A] - 1)
$88:DE62 A9 00       LDA #$00               ;/

$88:DE64 CA          DEX                    ; Decrement X
$88:DE65 10 EE       BPL $EE    [$DE55]     ; If [X] >= 0: go to LOOP
$88:DE67 28          PLP
$88:DE68 FA          PLX
$88:DE69 FE 14 19    INC $1914,x[$7E:1914]  ; Increment HDMA object max colour intensity
$88:DE6C 6B          RTL                    ; Return

; BRANCH_DONE
$88:DE6D A9 74 DE    LDA #$DE74             ;\
$88:DE70 9D F0 18    STA $18F0,x[$7E:18F0]  ;} HDMA object pre-instruction = $DE74
$88:DE73 6B          RTL
}


;;; $DE74: Pre-instruction - Ceres haze colour math subscreen backdrop colour - faded in ;;;
{
$88:DE74 A0 20       LDY #$20               ;\
$88:DE76 84 74       STY $74    [$7E:0074]  ;|
$88:DE78 A0 40       LDY #$40               ;|
$88:DE7A 84 75       STY $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$88:DE7C A0 80       LDY #$80               ;|
$88:DE7E 84 76       STY $76    [$7E:0076]  ;/
$88:DE80 A9 2C 00    LDA #$002C             ;\
$88:DE83 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 2Ch (normal, but BG3 is disabled)
$88:DE86 AD 9C 09    LDA $099C  [$7E:099C]  ;\
$88:DE89 C9 DB E2    CMP #$E2DB             ;} If [door transition function] != $E2DB (fading out):
$88:DE8C F0 01       BEQ $01    [$DE8F]     ;/
$88:DE8E 6B          RTL                    ; Return

$88:DE8F A9 96 DE    LDA #$DE96             ;\
$88:DE92 9D F0 18    STA $18F0,x[$7E:18F0]  ;} HDMA object pre-instruction = $DE96
$88:DE95 6B          RTL
}


;;; $DE96: Pre-instruction - Ceres haze colour math subscreen backdrop colour - fading out ;;;
{
$88:DE96 A0 20       LDY #$20               ;\
$88:DE98 84 74       STY $74    [$7E:0074]  ;|
$88:DE9A A0 40       LDY #$40               ;|
$88:DE9C 84 75       STY $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$88:DE9E A0 80       LDY #$80               ;|
$88:DEA0 84 76       STY $76    [$7E:0076]  ;/
$88:DEA2 A9 2C 00    LDA #$002C             ;\
$88:DEA5 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 2Ch (normal, but BG3 is disabled)
$88:DEA8 BD 14 19    LDA $1914,x[$7E:1914]  ;\
$88:DEAB F0 25       BEQ $25    [$DED2]     ;} If [HDMA object max colour intensity] = 0: return
$88:DEAD DA          PHX
$88:DEAE 08          PHP
$88:DEAF E2 20       SEP #$20
$88:DEB1 BD 20 19    LDA $1920,x[$7E:1920]  ;\
$88:DEB4 85 14       STA $14    [$7E:0014]  ;} $14 = [HDMA object colour component flags]
$88:DEB6 BD 14 19    LDA $1914,x[$7E:1914]  ; A = [HDMA object max colour intensity]
$88:DEB9 A2 0F       LDX #$0F               ; X = Fh

; LOOP
$88:DEBB 85 12       STA $12    [$7E:0012]  ;\
$88:DEBD 05 14       ORA $14    [$7E:0014]  ;|
$88:DEBF 9F 00 9D 7E STA $7E9D00,x[$7E:9D0F];} $7E:9D00 + [X] = [$14] | [A]
$88:DEC3 A5 12       LDA $12    [$7E:0012]  ;/
$88:DEC5 3A          DEC A                  ;\
$88:DEC6 10 02       BPL $02    [$DECA]     ;} A = max(0, [A] - 1)
$88:DEC8 A9 00       LDA #$00               ;/

$88:DECA CA          DEX                    ; Decrement X
$88:DECB 10 EE       BPL $EE    [$DEBB]     ; If [X] >= 0: go to LOOP
$88:DECD 28          PLP
$88:DECE FA          PLX
$88:DECF DE 14 19    DEC $1914,x[$7E:1914]  ; Decrement HDMA object max colour intensity

$88:DED2 6B          RTL
}


;;; $DED3: Instruction list - Ceres haze colour math subscreen backdrop colour - Ceres Ridley not dead ;;;
{
$88:DED3             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,88DE10,; Pre-instruction = $88:DE10
                        0001,DEEA
$88:DEE2             dx 7777,DF03,
                        85EC,DEE2   ; Go to $DEE2
}


;;; $DEEA: Empty HDMA table ;;;
{
$88:DEEA             db 00
}


;;; $DEEB: Instruction list - Ceres haze colour math subscreen backdrop colour - Ceres Ridley dead ;;;
{
$88:DEEB             dx 8655,88,    ; HDMA table bank = $88
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,88DE15,; Pre-instruction = $88:DE15
                        0001,DF02
$88:DEFA             dx 7777,DF03,
                        85EC,DEFA   ; Go to $DEFA
}


;;; $DF02: Empty HDMA table ;;;
{
$88:DF02             dx 00
}


;;; $DF03: Indirect HDMA table - Ceres haze colour math subscreen backdrop colour ;;;
{
$88:DF03             dx 40,9D00,
                        08,9D01,
                        08,9D02,
                        08,9D03,
                        08,9D04,
                        08,9D05,
                        08,9D06,
                        08,9D07,
                        08,9D08,
                        08,9D09,
                        08,9D0A,
                        08,9D0B,
                        08,9D0C,
                        08,9D0D,
                        08,9D0E,
                        08,9D0F,
                        00
}
}


;;; $DF34..E025: Draygon main screen layers ;;;
{
;;; $DF34: Spawn Draygon main screen layers HDMA object ;;;
{
$88:DF34 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DF38             dx 00, 2C, DF4F        ;} Spawn HDMA object for main screen layers with instruction list $DF4F
$88:DF3C 6B          RTL
}


;;; $DF3D: Unused ;;;
{
$88:DF3D 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DF41             dx 00, 2C, DF6B        ;} Spawn HDMA object for main screen layers with instruction list $DF6B
$88:DF45 6B          RTL
}


;;; $DF46: Unused ;;;
{
$88:DF46 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:DF4A             dx 02, 12, DF77        ;} Spawn HDMA object for BG3 Y scroll with instruction list $DF77
$88:DF4E 6B          RTL
}


;;; $DF4F: Instruction list - Draygon main screen layers - initial ;;;
{
$88:DF4F             dx 8655,88,    ; HDMA table bank = $88
                        866A,88,    ; Indirect HDMA data bank = $88
                        85B4,88DF91,; NOP
                        8570,88DF94 ; Pre-instruction = $88:DF94
}


;;; $DF5F: Instruction list - Draygon main screen layers - Draygon is around middle of screen ;;;
{
$88:DF5F             dx 0001,E007,
                        8682        ; Sleep
}


;;; $DF65: Instruction list - Draygon main screen layers - Draygon is around bottom of screen ;;;
{
$88:DF65             dx 0001,E00C,
                        8682        ; Sleep
}


;;; $DF6B: Instruction list - Draygon main screen layers - Draygon is around top of screen ;;;
{
$88:DF6B             dx 0001,E013,
                        8682        ; Sleep
}


;;; $DF71: Instruction list - Draygon main screen layers - Draygon is off-screen ;;;
{
$88:DF71             dx 0001,E01A,
                        8682        ; Sleep
}


;;; $DF77: Instruction list - unused BG3 Y scroll ;;;
{
$88:DF77             dx 8655,88,    ; HDMA table bank = $88
                        866A,88,    ; Indirect HDMA data bank = $88
                        85B4,88DF92,; NOP
                        8570,88DF93 ; Pre-instruction = RTL
$88:DF87             dx 0001,E01F,
                        85EC,DF87,  ; Go to $DF87
                        8682        ; Sleep
}


;;; $DF91: RTL ;;;
{
$88:DF91 6B          RTL
}


;;; $DF92: RTL ;;;
{
$88:DF92 6B          RTL
}


;;; $DF93: RTL ;;;
{
$88:DF93 6B          RTL
}


;;; $DF94: Pre-instruction - Draygon main screen layers ;;;
{
$88:DF94 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$88:DF97 89 00 02    BIT #$0200             ;} If Draygon body is deleted: go to BRANCH_DRAYGON_OFF_SCREEN
$88:DF9A D0 44       BNE $44    [$DFE0]     ;/
$88:DF9C AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$88:DF9F 38          SEC                    ;|
$88:DFA0 ED 11 09    SBC $0911  [$7E:0911]  ;|
$88:DFA3 18          CLC                    ;|
$88:DFA4 69 40 00    ADC #$0040             ;} If not -40h <= [Draygon body X position] - [layer 1 X position] < 140h: go to BRANCH_DRAYGON_OFF_SCREEN
$88:DFA7 30 37       BMI $37    [$DFE0]     ;|
$88:DFA9 C9 80 01    CMP #$0180             ;|
$88:DFAC 10 32       BPL $32    [$DFE0]     ;/
$88:DFAE AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$88:DFB1 38          SEC                    ;|
$88:DFB2 ED 15 09    SBC $0915  [$7E:0915]  ;|
$88:DFB5 18          CLC                    ;|
$88:DFB6 69 10 00    ADC #$0010             ;|
$88:DFB9 30 25       BMI $25    [$DFE0]     ;} If not -10h <= [Draygon body Y position] - [layer 1 Y position] < 130h: go to BRANCH_DRAYGON_OFF_SCREEN
$88:DFBB AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;|
$88:DFBE 38          SEC                    ;|
$88:DFBF ED 15 09    SBC $0915  [$7E:0915]  ;|
$88:DFC2 C9 30 01    CMP #$0130             ;|
$88:DFC5 10 19       BPL $19    [$DFE0]     ;/
$88:DFC7 C9 28 00    CMP #$0028             ;\
$88:DFCA 30 07       BMI $07    [$DFD3]     ;} If [Draygon body Y position] - [layer 1 Y position] < 28h: go to BRANCH_AROUND_TOP
$88:DFCC C9 C0 00    CMP #$00C0             ;\
$88:DFCF 30 29       BMI $29    [$DFFA]     ;} If [Draygon body Y position] - [layer 1 Y position] < C0h: go to BRANCH_AROUND_MIDDLE
$88:DFD1 80 1A       BRA $1A    [$DFED]     ; Go to BRANCH_AROUND_BOTTOM

; BRANCH_AROUND_TOP
$88:DFD3 A9 01 00    LDA #$0001             ;\
$88:DFD6 9D E4 18    STA $18E4,x[$7E:18E6]  ;} HDMA object instruction timer = 1
$88:DFD9 A9 6B DF    LDA #$DF6B             ;\
$88:DFDC 9D CC 18    STA $18CC,x[$7E:18CE]  ;} HDMA object instruction list pointer = $DF6B
$88:DFDF 6B          RTL                    ; Return

; BRANCH_DRAYGON_OFF_SCREEN
$88:DFE0 A9 01 00    LDA #$0001             ;\
$88:DFE3 9D E4 18    STA $18E4,x[$7E:18E6]  ;} HDMA object instruction timer = 1
$88:DFE6 A9 71 DF    LDA #$DF71             ;\
$88:DFE9 9D CC 18    STA $18CC,x[$7E:18CE]  ;} HDMA object instruction list pointer = $DF71
$88:DFEC 6B          RTL                    ; Return

; BRANCH_AROUND_BOTTOM
$88:DFED A9 01 00    LDA #$0001             ;\
$88:DFF0 9D E4 18    STA $18E4,x[$7E:18E6]  ;} HDMA object instruction timer = 1
$88:DFF3 A9 65 DF    LDA #$DF65             ;\
$88:DFF6 9D CC 18    STA $18CC,x[$7E:18CE]  ;} HDMA object instruction list pointer = $DF65
$88:DFF9 6B          RTL                    ; Return

; BRANCH_AROUND_MIDDLE
$88:DFFA A9 01 00    LDA #$0001             ;\
$88:DFFD 9D E4 18    STA $18E4,x[$7E:18E6]  ;} HDMA object instruction timer = 1
$88:E000 A9 5F DF    LDA #$DF5F             ;\
$88:E003 9D CC 18    STA $18CC,x[$7E:18CE]  ;} HDMA object instruction list pointer = $DF5F
$88:E006 6B          RTL
}


;;; $E007: HDMA table - Draygon main screen layers - Draygon is around middle of screen ;;;
{
$88:E007             db 1F,04, ;         BG3
                        81,13, ; BG1/BG2/    sprites
                        00
}


;;; $E00C: HDMA table - Draygon main screen layers - Draygon is around bottom of screen ;;;
{
$88:E00C             db 1F,04, ;         BG3
                        60,11, ; BG1/        sprites
                        81,13, ; BG1/BG2/    sprites
                        00
}


;;; $E013: HDMA table - Draygon main screen layers - Draygon is around top of screen ;;;
{
$88:E013             db 1F,04, ;         BG3
                        40,13, ; BG1/BG2/    sprites
                        81,11, ; BG1/        sprites
                        00
}


;;; $E01A: HDMA table - Draygon main screen layers - Draygon is off-screen ;;;
{
$88:E01A             db 1F,04, ;         BG3
                        81,11, ; BG1/        sprites
                        00
}


;;; $E01F: HDMA table - unused BG3 Y scroll ;;;
{
$88:E01F             dx 40,0000,
                        81,0020,
                        00
}
}


;;; $E026..E448: Suit pickup ;;;
{
;;; $E026: Pre-instruction - varia suit pickup ;;;
{
$88:E026 08          PHP
$88:E027 C2 30       REP #$30
$88:E029 AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$88:E02C 0A          ASL A                  ;|
$88:E02D AA          TAX                    ;} Execute [$E04E + [suit pickup stage] * 2
$88:E02E FC 4E E0    JSR ($E04E,x)[$88:E092];/
$88:E031 90 19       BCC $19    [$E04C]     ; If carry set:
$88:E033 E2 20       SEP #$20
$88:E035 AD F0 0D    LDA $0DF0  [$7E:0DF0]  ;\
$88:E038 85 74       STA $74    [$7E:0074]  ;} Colour math subscreen backdrop colour 0 = [suit pickup colour math subscreen backdrop red component]
$88:E03A AD F1 0D    LDA $0DF1  [$7E:0DF1]  ;\
$88:E03D 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour 1 = [suit pickup colour math subscreen backdrop green component]
$88:E03F AD F2 0D    LDA $0DF2  [$7E:0DF2]  ;\
$88:E042 85 76       STA $76    [$7E:0076]  ;} Colour math subscreen backdrop colour 2 = [suit pickup colour math subscreen backdrop blue component]
$88:E044 C2 20       REP #$20
$88:E046 A9 12 00    LDA #$0012             ;\
$88:E049 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 12h (normal, but BG3 is disabled inside window 1)

$88:E04C 28          PLP
$88:E04D 6B          RTL

$88:E04E             dw E092, E0D7, E113, E320, E1BA, E22B, E258
}


;;; $E05C: Pre-instruction - gravity suit pickup ;;;
{
$88:E05C 08          PHP
$88:E05D C2 30       REP #$30
$88:E05F AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$88:E062 0A          ASL A                  ;|
$88:E063 AA          TAX                    ;} Execute [$E084 + [$0DEC] * 2
$88:E064 FC 84 E0    JSR ($E084,x)[$88:E092];/
$88:E067 90 19       BCC $19    [$E082]     ; If carry set:
$88:E069 E2 20       SEP #$20
$88:E06B AD F0 0D    LDA $0DF0  [$7E:0DF0]  ;\
$88:E06E 85 74       STA $74    [$7E:0074]  ;} Colour math subscreen backdrop colour 0 = [suit pickup colour math subscreen backdrop red component]
$88:E070 AD F1 0D    LDA $0DF1  [$7E:0DF1]  ;\
$88:E073 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour 1 = [suit pickup colour math subscreen backdrop green component]
$88:E075 AD F2 0D    LDA $0DF2  [$7E:0DF2]  ;\
$88:E078 85 76       STA $76    [$7E:0076]  ;} Colour math subscreen backdrop colour 2 = [suit pickup colour math subscreen backdrop blue component]
$88:E07A C2 20       REP #$20
$88:E07C A9 12 00    LDA #$0012             ;\
$88:E07F 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 12h (normal, but BG3 is disabled inside window 1)

$88:E082 28          PLP
$88:E083 6B          RTL

$88:E084             dw E092, E0D7, E113, E361, E1BA, E22B, E25F
}


;;; $E092: Suit pickup stage 0 - light beam appears ;;;
{
$88:E092 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E095 18          CLC                    ;|
$88:E096 69 08 00    ADC #$0008             ;} Suit pickup light beam height += 8
$88:E099 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;/
$88:E09C A8          TAY                    ; Y = [suit pickup light beam height]
$88:E09D A2 00 00    LDX #$0000             ; X = 0

; LOOP_UPPER_HALF
$88:E0A0 AD D5 E0    LDA $E0D5  [$88:E0D5]  ;\
$88:E0A3 9F 00 98 7E STA $7E9800,x[$7E:9800];} $7E:9800 + [X] = 78h,78h
$88:E0A7 E8          INX                    ;\
$88:E0A8 E8          INX                    ;} X += 2
$88:E0A9 88          DEY                    ; Decrement Y
$88:E0AA F0 02       BEQ $02    [$E0AE]     ;\
$88:E0AC 10 F2       BPL $F2    [$E0A0]     ;} If [Y] > 0: go to LOOP_UPPER_HALF

$88:E0AE A2 FE 01    LDX #$01FE             ; X = 1FEh
$88:E0B1 AC EE 0D    LDY $0DEE  [$7E:0DEE]  ; Y = [suit pickup light beam height]

; LOOP_LOWER_HALF
$88:E0B4 AD D5 E0    LDA $E0D5  [$88:E0D5]  ;\
$88:E0B7 9F 00 98 7E STA $7E9800,x[$7E:99FE];} $7E:9800 + [X] = 78h,78h
$88:E0BB CA          DEX                    ;\
$88:E0BC CA          DEX                    ;} X -= 2
$88:E0BD 88          DEY                    ; Decrement Y
$88:E0BE F0 02       BEQ $02    [$E0C2]     ;\
$88:E0C0 10 F2       BPL $F2    [$E0B4]     ;} If [Y] > 0: go to LOOP_LOWER_HALF

$88:E0C2 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E0C5 C9 80 00    CMP #$0080             ;} If [suit pickup light beam height] >= 80h:
$88:E0C8 30 09       BMI $09    [$E0D3]     ;/
$88:E0CA EE EC 0D    INC $0DEC  [$7E:0DEC]  ; Suit pickup stage = 1
$88:E0CD A9 78 78    LDA #$7878             ;\
$88:E0D0 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;} Suit pickup light beam left/right positions = 78h,78h

$88:E0D3 38          SEC                    ;\
$88:E0D4 60          RTS                    ;} Return carry set

$88:E0D5             db 78,78
}


;;; $E0D7: Suit pickup stage 1 - light beam widens - linear ;;;
{
$88:E0D7 E2 20       SEP #$20
$88:E0D9 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E0DC 38          SEC                    ;|
$88:E0DD ED DD 0D    SBC $0DDD  [$7E:0DDD]  ;} Suit pickup light beam left position -= [suit pickup light beam widening speed] / 100h
$88:E0E0 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;/
$88:E0E3 AD EF 0D    LDA $0DEF  [$7E:0DEF]  ;\
$88:E0E6 18          CLC                    ;|
$88:E0E7 6D DD 0D    ADC $0DDD  [$7E:0DDD]  ;} Suit pickup light beam right position += [suit pickup light beam widening speed] / 100h
$88:E0EA 8D EF 0D    STA $0DEF  [$7E:0DEF]  ;/
$88:E0ED C2 20       REP #$20
$88:E0EF A2 FE 01    LDX #$01FE             ; X = 1FEh

; LOOP
$88:E0F2 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E0F5 9F 00 98 7E STA $7E9800,x[$7E:99FE];} $7E:9800 + [X] = [suit pickup light beam left position],[suit pickup light beam right position]
$88:E0F9 CA          DEX                    ;\
$88:E0FA CA          DEX                    ;} X -= 2
$88:E0FB 10 F5       BPL $F5    [$E0F2]     ; If [X] >= 0: go to LOOP
$88:E0FD AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E100 29 FF 00    AND #$00FF             ;|
$88:E103 C9 61 00    CMP #$0061             ;} If [suit pickup light beam left position] <= 60h:
$88:E106 10 09       BPL $09    [$E111]     ;/
$88:E108 EE EC 0D    INC $0DEC  [$7E:0DEC]  ; Suit pickup stage = 2
$88:E10B A9 6C 84    LDA #$846C             ;\
$88:E10E 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;} Suit pickup light beam left position = 6Ch, right position = 84h

$88:E111 38          SEC                    ;\
$88:E112 60          RTS                    ;} Return carry set
}


;;; $E113: Suit pickup stage 2 - light beam widens - curved ;;;
{
$88:E113 20 B4 E2    JSR $E2B4  [$88:E2B4]  ; Advance suit pickup colour math subscreen backdrop transition to white
$88:E116 C2 10       REP #$10
$88:E118 E2 20       SEP #$20
$88:E11A AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E11D 38          SEC                    ;|
$88:E11E ED DD 0D    SBC $0DDD  [$7E:0DDD]  ;} Suit pickup light beam left position -= [suit pickup light beam widening speed] / 100h
$88:E121 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;/
$88:E124 F0 14       BEQ $14    [$E13A]     ;\
$88:E126 30 12       BMI $12    [$E13A]     ;} If [suit pickup light beam left position] > 0:
$88:E128 AD EF 0D    LDA $0DEF  [$7E:0DEF]  ;\
$88:E12B 18          CLC                    ;|
$88:E12C 6D DD 0D    ADC $0DDD  [$7E:0DDD]  ;|
$88:E12F 90 02       BCC $02    [$E133]     ;} Suit pickup light beam right position = min(FFh, [suit pickup light beam right position] + [suit pickup light beam widening speed] / 100h)
$88:E131 A9 FF       LDA #$FF               ;|
                                            ;|
$88:E133 8D EF 0D    STA $0DEF  [$7E:0DEF]  ;/
$88:E136 C2 20       REP #$20
$88:E138 80 08       BRA $08    [$E142]

$88:E13A C2 20       REP #$20               ; Else ([suit pickup light beam left position] <= 0):
$88:E13C A9 00 FF    LDA #$FF00             ;\
$88:E13F 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;} Suit pickup light beam left position = 0, right position = FFh

$88:E142 E2 20       SEP #$20
$88:E144 A2 00 00    LDX #$0000             ; X = 0
$88:E147 A0 00 00    LDY #$0000             ; Y = 0

; LOOP_UPPER_HALF
$88:E14A AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E14D 38          SEC                    ;|
$88:E14E F9 C9 E3    SBC $E3C9,y[$88:E3C9]  ;|
$88:E151 10 02       BPL $02    [$E155]     ;} $7E:9800 + [X] = max(0, [suit pickup light beam left position] - [$E3C9 + [Y]]
$88:E153 A9 00       LDA #$00               ;|
                                            ;|
$88:E155 9F 00 98 7E STA $7E9800,x[$7E:9800];/
$88:E159 E8          INX                    ;\
$88:E15A AD EF 0D    LDA $0DEF  [$7E:0DEF]  ;|
$88:E15D 18          CLC                    ;|
$88:E15E 79 C9 E3    ADC $E3C9,y[$88:E3C9]  ;|
$88:E161 90 02       BCC $02    [$E165]     ;} $7E:9800 + [X] + 1 = min(FFh, [suit pickup light beam right position] + [$E3C9 + [Y]]
$88:E163 A9 FF       LDA #$FF               ;|
                                            ;|
$88:E165 9F 00 98 7E STA $7E9800,x[$7E:9801];/
$88:E169 E8          INX                    ; X += 2
$88:E16A C8          INY                    ; Increment Y
$88:E16B E0 00 01    CPX #$0100             ;\
$88:E16E 30 DA       BMI $DA    [$E14A]     ;} If [X] < 100h: go to LOOP
$88:E170 88          DEY                    ; Y = 7Fh

; LOOP_LOWER_HALF
$88:E171 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E174 38          SEC                    ;|
$88:E175 F9 C9 E3    SBC $E3C9,y[$88:E448]  ;|
$88:E178 10 02       BPL $02    [$E17C]     ;} $7E:9800 + [X] = max(0, [suit pickup light beam left position] - [$E3C9 + [Y]]
$88:E17A A9 00       LDA #$00               ;|
                                            ;|
$88:E17C 9F 00 98 7E STA $7E9800,x[$7E:9900];/
$88:E180 E8          INX                    ;\
$88:E181 AD EF 0D    LDA $0DEF  [$7E:0DEF]  ;|
$88:E184 18          CLC                    ;|
$88:E185 79 C9 E3    ADC $E3C9,y[$88:E448]  ;|
$88:E188 90 02       BCC $02    [$E18C]     ;} $7E:9800 + [X] + 1 = min(FFh, [suit pickup light beam right position] + [$E3C9 + [Y]]
$88:E18A A9 FF       LDA #$FF               ;|
                                            ;|
$88:E18C 9F 00 98 7E STA $7E9800,x[$7E:9901];/
$88:E190 E8          INX                    ; X += 2
$88:E191 88          DEY                    ; Decrement Y
$88:E192 E0 00 02    CPX #$0200             ;\
$88:E195 30 DA       BMI $DA    [$E171]     ;} If [X] < 200h: go to LOOP
$88:E197 C2 20       REP #$20
$88:E199 AD DC 0D    LDA $0DDC  [$7E:0DDC]  ;\
$88:E19C 18          CLC                    ;|
$88:E19D 69 60 00    ADC #$0060             ;} Suit pickup light beam widening speed += 60h
$88:E1A0 8D DC 0D    STA $0DDC  [$7E:0DDC]  ;/
$88:E1A3 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E1A6 C9 00 FF    CMP #$FF00             ;} If [suit pickup light beam left/right positions] = 0,FFh:
$88:E1A9 D0 0D       BNE $0D    [$E1B8]     ;/
$88:E1AB EE EC 0D    INC $0DEC  [$7E:0DEC]  ; Suit pickup stage = 3
$88:E1AE AD DC 0D    LDA $0DDC  [$7E:0DDC]  ;\
$88:E1B1 4A          LSR A                  ;} Suit pickup light beam widening speed /= 2
$88:E1B2 8D DC 0D    STA $0DDC  [$7E:0DDC]  ;/
$88:E1B5 9C EE 0D    STZ $0DEE  [$7E:0DEE]  ; Suit pickup light beam top position = 0

$88:E1B8 38          SEC                    ;\
$88:E1B9 60          RTS                    ;} Return carry set
}


;;; $E1BA: Suit pickup stage 4 - light beam shrinks ;;;
{
$88:E1BA AD F2 0D    LDA $0DF2  [$7E:0DF2]  ;\
$88:E1BD 89 00 FF    BIT #$FF00             ;} If [suit pickup palette transition colour] = orange:
$88:E1C0 D0 05       BNE $05    [$E1C7]     ;/
$88:E1C2 20 F9 E2    JSR $E2F9  [$88:E2F9]  ; Advance suit pickup colour math subscreen backdrop transition to orange
$88:E1C5 80 03       BRA $03    [$E1CA]
                                            ; Else ([suit pickup palette transition colour] != orange):
$88:E1C7 20 A2 E3    JSR $E3A2  [$88:E3A2]  ; Advance suit pickup colour math subscreen backdrop transition to blue

$88:E1CA AD DC 0D    LDA $0DDC  [$7E:0DDC]  ;\
$88:E1CD 29 00 FF    AND #$FF00             ;|
$88:E1D0 EB          XBA                    ;|
$88:E1D1 85 12       STA $12    [$7E:0012]  ;|
$88:E1D3 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;} Suit pickup light beam top position += [suit pickup light beam widening speed] / 100h
$88:E1D6 18          CLC                    ;|
$88:E1D7 65 12       ADC $12    [$7E:0012]  ;|
$88:E1D9 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;/
$88:E1DC A8          TAY                    ; Y = [suit pickup light beam top position]
$88:E1DD A2 00 00    LDX #$0000             ; X = 0

; LOOP_UPPER_HALF
$88:E1E0 A9 FF 00    LDA #$00FF             ;\
$88:E1E3 9F 00 98 7E STA $7E9800,x[$7E:9800];} $7E:9800 + [X] = FFh,00h
$88:E1E7 E8          INX                    ;\
$88:E1E8 E8          INX                    ;} X += 2
$88:E1E9 88          DEY                    ; Decrement Y
$88:E1EA F0 02       BEQ $02    [$E1EE]     ;\
$88:E1EC 10 F2       BPL $F2    [$E1E0]     ;} If [Y] > 0: go to LOOP_UPPER_HALF

$88:E1EE A2 FE 01    LDX #$01FE             ; X = 1FEh
$88:E1F1 AC EE 0D    LDY $0DEE  [$7E:0DEE]  ;\
$88:E1F4 88          DEY                    ;} Y = [suit pickup light beam top position] - 1

; LOOP_LOWER_HALF
$88:E1F5 A9 FF 00    LDA #$00FF             ;\
$88:E1F8 9F 00 98 7E STA $7E9800,x[$7E:99FE];} $7E:9800 + [X] = FFh,00h
$88:E1FC CA          DEX                    ;\
$88:E1FD CA          DEX                    ;} X -= 2
$88:E1FE 88          DEY                    ; Decrement Y
$88:E1FF F0 02       BEQ $02    [$E203]     ;\
$88:E201 10 F2       BPL $F2    [$E1F5]     ;} If [Y] > 0: go to LOOP_LOWER_HALF

$88:E203 AD DC 0D    LDA $0DDC  [$7E:0DDC]  ;\
$88:E206 38          SEC                    ;|
$88:E207 E9 20 00    SBC #$0020             ;} Suit pickup light beam widening speed -= 20h
$88:E20A 8D DC 0D    STA $0DDC  [$7E:0DDC]  ;/
$88:E20D C9 00 01    CMP #$0100             ;\
$88:E210 10 06       BPL $06    [$E218]     ;|
$88:E212 A9 00 01    LDA #$0100             ;} Suit pickup light beam widening speed = max(100h, [suit pickup light beam widening speed])
$88:E215 8D DC 0D    STA $0DDC  [$7E:0DDC]  ;/

$88:E218 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E21B C9 80 00    CMP #$0080             ;} If [suit pickup light beam top position] >= 80h:
$88:E21E 30 09       BMI $09    [$E229]     ;/
$88:E220 EE EC 0D    INC $0DEC  [$7E:0DEC]  ; Suit pickup stage = 5
$88:E223 A9 FF F8    LDA #$F8FF             ;\
$88:E226 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;} Suit pickup light beam left position = -1, right position = F8h

$88:E229 38          SEC                    ;\
$88:E22A 60          RTS                    ;} Return carry set
}


;;; $E22B: Suit pickup stage 5 - light beam dissipates ;;;
{
$88:E22B E2 20       SEP #$20
$88:E22D AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E230 18          CLC                    ;|
$88:E231 69 08       ADC #$08               ;} Suit pickup light beam left position += 8
$88:E233 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;/
$88:E236 AD EF 0D    LDA $0DEF  [$7E:0DEF]  ;\
$88:E239 38          SEC                    ;|
$88:E23A E9 08       SBC #$08               ;} Suit pickup light beam right position -= 8
$88:E23C 8D EF 0D    STA $0DEF  [$7E:0DEF]  ;/
$88:E23F C2 20       REP #$20
$88:E241 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$88:E244 8F 00 99 7E STA $7E9900[$7E:9900]  ;} $7E:9800 + 80h * 2 = [suit pickup light beam left position],[suit pickup light beam right position]
$88:E248 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ; >_<;
$88:E24B 29 FF 00    AND #$00FF             ;\
$88:E24E C9 70 00    CMP #$0070             ;} If [suit pickup light beam left position] >= 70h:
$88:E251 30 03       BMI $03    [$E256]     ;/
$88:E253 EE EC 0D    INC $0DEC  [$7E:0DEC]  ; Suit pickup stage = 6

$88:E256 38          SEC                    ;\
$88:E257 60          RTS                    ;} Return carry set
}


;;; $E258: Varia suit pickup stage 6 ;;;
{
$88:E258 A9 03 00    LDA #$0003             ;\
$88:E25B 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue elevator music track
}


;;; $E25F: Gravity suit pickup stage 6 ;;;
{
; Called by varia suit pickup stage 6 too
$88:E25F E2 20       SEP #$20               ;\
$88:E261 A9 80       LDA #$80               ;|
$88:E263 85 76       STA $76    [$7E:0076]  ;|
$88:E265 A9 40       LDA #$40               ;|
$88:E267 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$88:E269 A9 20       LDA #$20               ;|
$88:E26B 85 74       STA $74    [$7E:0074]  ;|
$88:E26D C2 20       REP #$20               ;/
$88:E26F A9 01 00    LDA #$0001             ;\
$88:E272 8D 88 0A    STA $0A88  [$7E:0A88]  ;|
$88:E275 A9 00 98    LDA #$9800             ;|
$88:E278 8D 89 0A    STA $0A89  [$7E:0A89]  ;|
$88:E27B 9C 8B 0A    STZ $0A8B  [$7E:0A8B]  ;} $0A88..91 = 1,$9800, 0,0...
$88:E27E 9C 8C 0A    STZ $0A8C  [$7E:0A8C]  ;|
$88:E281 9C 8E 0A    STZ $0A8E  [$7E:0A8E]  ;|
$88:E284 9C 90 0A    STZ $0A90  [$7E:0A90]  ;/
$88:E287 A9 FF 00    LDA #$00FF             ;\
$88:E28A 8F 00 98 7E STA $7E9800[$7E:9800]  ;} $7E:9800 = FFh,0
$88:E28E 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ;\
$88:E291 9C EE 0D    STZ $0DEE  [$7E:0DEE]  ;|
$88:E294 9C F0 0D    STZ $0DF0  [$7E:0DF0]  ;} Suit pickup variables = 0
$88:E297 9C F2 0D    STZ $0DF2  [$7E:0DF2]  ;/
$88:E29A AE B2 18    LDX $18B2  [$7E:18B2]  ; X = [HDMA object index]
$88:E29D BD CC 18    LDA $18CC,x[$7E:18CC]  ;\
$88:E2A0 1A          INC A                  ;|
$88:E2A1 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:E2A2 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:E2A5 A9 01 00    LDA #$0001             ;\
$88:E2A8 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1
$88:E2AB A9 0B 00    LDA #$000B             ;\
$88:E2AE 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus from facing forward
$88:E2B2 18          CLC                    ;\
$88:E2B3 60          RTS                    ;} Return carry clear
}


;;; $E2B4: Advance suit pickup colour math subscreen backdrop transition to white ;;;
{
$88:E2B4 E2 20       SEP #$20
$88:E2B6 AD F0 0D    LDA $0DF0  [$7E:0DF0]  ;\
$88:E2B9 C9 3F       CMP #$3F               ;} If [suit pickup colour math subscreen backdrop red component] != 1Fh:
$88:E2BB F0 0E       BEQ $0E    [$E2CB]     ;/
$88:E2BD 1A          INC A                  ;\
$88:E2BE 1A          INC A                  ;} Suit pickup colour math subscreen backdrop red component += 2
$88:E2BF 8D F0 0D    STA $0DF0  [$7E:0DF0]  ;/
$88:E2C2 C9 40       CMP #$40               ;\
$88:E2C4 30 05       BMI $05    [$E2CB]     ;|
$88:E2C6 A9 3F       LDA #$3F               ;} Suit pickup colour math subscreen backdrop red component = min(1Fh, [suit pickup colour math subscreen backdrop red component])
$88:E2C8 8D F0 0D    STA $0DF0  [$7E:0DF0]  ;/

$88:E2CB AD F1 0D    LDA $0DF1  [$7E:0DF1]  ;\
$88:E2CE C9 5F       CMP #$5F               ;} If [suit pickup colour math subscreen backdrop green component] != 1Fh:
$88:E2D0 F0 0E       BEQ $0E    [$E2E0]     ;/
$88:E2D2 1A          INC A                  ;\
$88:E2D3 1A          INC A                  ;} Suit pickup colour math subscreen backdrop green component += 2
$88:E2D4 8D F1 0D    STA $0DF1  [$7E:0DF1]  ;/
$88:E2D7 C9 60       CMP #$60               ;\
$88:E2D9 30 05       BMI $05    [$E2E0]     ;|
$88:E2DB A9 5F       LDA #$5F               ;} Suit pickup colour math subscreen backdrop green component = min(1Fh, [suit pickup colour math subscreen backdrop green component])
$88:E2DD 8D F1 0D    STA $0DF1  [$7E:0DF1]  ;/

$88:E2E0 AD F2 0D    LDA $0DF2  [$7E:0DF2]  ;\
$88:E2E3 C9 9F       CMP #$9F               ;} If [suit pickup colour math subscreen backdrop blue component] != 1Fh:
$88:E2E5 F0 0E       BEQ $0E    [$E2F5]     ;/
$88:E2E7 1A          INC A                  ;\
$88:E2E8 1A          INC A                  ;} Suit pickup colour math subscreen backdrop blue component += 2
$88:E2E9 8D F2 0D    STA $0DF2  [$7E:0DF2]  ;/
$88:E2EC C9 A0       CMP #$A0               ;\
$88:E2EE 30 05       BMI $05    [$E2F5]     ;|
$88:E2F0 A9 9F       LDA #$9F               ;} Suit pickup colour math subscreen backdrop blue component = min(1Fh, [suit pickup colour math subscreen backdrop blue component])
$88:E2F2 8D F2 0D    STA $0DF2  [$7E:0DF2]  ;/

$88:E2F5 C2 20       REP #$20
$88:E2F7 38          SEC                    ; This carry has no effect
$88:E2F8 60          RTS
}


;;; $E2F9: Advance suit pickup colour math subscreen backdrop transition to orange ;;;
{
$88:E2F9 E2 20       SEP #$20
$88:E2FB AD F0 0D    LDA $0DF0  [$7E:0DF0]  ;\
$88:E2FE C9 3F       CMP #$3F               ;} If [suit pickup colour math subscreen backdrop red component] != 1Fh:
$88:E300 F0 04       BEQ $04    [$E306]     ;/
$88:E302 3A          DEC A                  ;\
$88:E303 8D F0 0D    STA $0DF0  [$7E:0DF0]  ;} Decrement suit pickup colour math subscreen backdrop red component

$88:E306 AD F1 0D    LDA $0DF1  [$7E:0DF1]  ;\
$88:E309 C9 4D       CMP #$4D               ;} If [suit pickup colour math subscreen backdrop green component] != Dh:
$88:E30B F0 04       BEQ $04    [$E311]     ;/
$88:E30D 3A          DEC A                  ;\
$88:E30E 8D F1 0D    STA $0DF1  [$7E:0DF1]  ;} Decrement suit pickup colour math subscreen backdrop green component

$88:E311 AD F2 0D    LDA $0DF2  [$7E:0DF2]  ;\
$88:E314 C9 83       CMP #$83               ;} If [suit pickup colour math subscreen backdrop blue component] != 3:
$88:E316 F0 04       BEQ $04    [$E31C]     ;/
$88:E318 3A          DEC A                  ;\
$88:E319 8D F2 0D    STA $0DF2  [$7E:0DF2]  ;} Decrement suit pickup colour math subscreen backdrop blue component

$88:E31C C2 20       REP #$20
$88:E31E 38          SEC                    ; This carry has no effect
$88:E31F 60          RTS
}


;;; $E320: Varia suit pickup stage 3 - give Samus varia suit ;;;
{
; This code is all redundant, as varia suit is already given to Samus by the PLM
$88:E320 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$88:E323 09 01 00    ORA #$0001             ;} Equip varia suit
$88:E326 8D A2 09    STA $09A2  [$7E:09A2]  ;/
$88:E329 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$88:E32C 09 01 00    ORA #$0001             ;} Collect varia suit
$88:E32F 8D A4 09    STA $09A4  [$7E:09A4]  ;/
$88:E332 A9 9B 00    LDA #$009B             ;\
$88:E335 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - varia/gravity suit
$88:E338 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$88:E33C 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$88:E340 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$88:E343 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$88:E346 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$88:E349 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$88:E34C AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$88:E34F 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$88:E352 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$88:E355 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$88:E358 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$88:E35C EE EC 0D    INC $0DEC  [$7E:0DEC]  ; Suit pickup stage = 4
$88:E35F 38          SEC                    ;\
$88:E360 60          RTS                    ;} Return carry set
}


;;; $E361: Gravity suit pickup stage 3 - give Samus gravity suit ;;;
{
; This code is all redundant, as gravity suit is already given to Samus by the PLM
$88:E361 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$88:E364 09 20 00    ORA #$0020             ;} Equip gravity suit
$88:E367 8D A2 09    STA $09A2  [$7E:09A2]  ;/
$88:E36A AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$88:E36D 09 20 00    ORA #$0020             ;} Collect gravity suit
$88:E370 8D A4 09    STA $09A4  [$7E:09A4]  ;/
$88:E373 A9 9B 00    LDA #$009B             ;\
$88:E376 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - varia/gravity suit
$88:E379 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$88:E37D 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$88:E381 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$88:E384 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$88:E387 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$88:E38A 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$88:E38D AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$88:E390 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$88:E393 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$88:E396 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$88:E399 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$88:E39D EE EC 0D    INC $0DEC  [$7E:0DEC]  ; Suit pickup stage = 4
$88:E3A0 38          SEC                    ;\
$88:E3A1 60          RTS                    ;} Return carry set
}


;;; $E3A2: Advance suit pickup colour math subscreen backdrop transition to blue ;;;
{
$88:E3A2 E2 20       SEP #$20
$88:E3A4 AD F0 0D    LDA $0DF0  [$7E:0DF0]  ;\
$88:E3A7 C9 30       CMP #$30               ;} If [suit pickup colour math subscreen backdrop red component] != 0:
$88:E3A9 F0 04       BEQ $04    [$E3AF]     ;/
$88:E3AB 3A          DEC A                  ;\
$88:E3AC 8D F0 0D    STA $0DF0  [$7E:0DF0]  ;} Decrement suit pickup colour math subscreen backdrop red component

$88:E3AF AD F1 0D    LDA $0DF1  [$7E:0DF1]  ;\
$88:E3B2 C9 49       CMP #$49               ;} If [suit pickup colour math subscreen backdrop green component] != 9:
$88:E3B4 F0 04       BEQ $04    [$E3BA]     ;/
$88:E3B6 3A          DEC A                  ;\
$88:E3B7 8D F1 0D    STA $0DF1  [$7E:0DF1]  ;} Decrement suit pickup colour math subscreen backdrop green component

$88:E3BA AD F2 0D    LDA $0DF2  [$7E:0DF2]  ;\
$88:E3BD C9 90       CMP #$90               ;} If [suit pickup colour math subscreen backdrop blue component] != 10h:
$88:E3BF F0 04       BEQ $04    [$E3C5]     ;/
$88:E3C1 3A          DEC A                  ;\
$88:E3C2 8D F2 0D    STA $0DF2  [$7E:0DF2]  ;} Decrement suit pickup colour math subscreen backdrop blue component

$88:E3C5 C2 20       REP #$20
$88:E3C7 38          SEC                    ; This carry has no effect
$88:E3C8 60          RTS
}


;;; $E3C9: Suit pickup light beam curve widths ;;;
{
; Indexed by scanline for upper half (`FFh - scanline` for lower half)
$88:E3C9             db 01, 02, 03, 04, 05, 06, 07, 07, 08, 08, 09, 09, 0A, 0A, 0B, 0B,
                        0B, 0C, 0C, 0C, 0D, 0D, 0D, 0E, 0E, 0E, 0E, 0F, 0F, 0F, 0F, 10,
                        10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12, 12,
                        13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15,
                        15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16,
                        16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17,
                        17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18,
                        18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18
}
}


;;; $E449: Pre-instruction - Phantoon semi-transparency ;;;
{
$88:E449 08          PHP
$88:E44A E2 10       SEP #$10
$88:E44C C2 20       REP #$20
$88:E44E 2C 88 19    BIT $1988  [$7E:1988]  ;\
$88:E451 70 13       BVS $13    [$E466]     ;} If [Phantoon semi-transparency flag] & 4000h != 0: go to BRANCH_SEMI_TRANSPARENT
$88:E453 AE 74 10    LDX $1074  [$7E:1074]  ;\
$88:E456 F0 06       BEQ $06    [$E45E]     ;} If [Phantoon semi-transparency HDMA object control] & FFh = 0: go to BRANCH_BG2_DISABLED
$88:E458 E0 FF       CPX #$FF               ;\
$88:E45A F0 12       BEQ $12    [$E46E]     ;} If [Phantoon semi-transparency HDMA object control] & FFh = FFh: go to BRANCH_DELETE
$88:E45C 80 0E       BRA $0E    [$E46C]     ; Return

; BRANCH_BG2_DISABLED
$88:E45E A9 04 00    LDA #$0004             ;\
$88:E461 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 4 (normal, but BG2 is disabled)
$88:E464 80 06       BRA $06    [$E46C]     ; Return

; BRANCH_SEMI_TRANSPARENT
$88:E466 A9 1A 00    LDA #$001A             ;\
$88:E469 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 1Ah (normal, but BG2 and BG3 have reversed roles and power bomb configuration = 4)

$88:E46C 28          PLP
$88:E46D 6B          RTL                    ; Return

; BRANCH_DELETE
$88:E46E A9 04 00    LDA #$0004             ;\
$88:E471 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 4 (normal, but BG2 is disabled)
$88:E474 AE B2 18    LDX $18B2  [$7E:18B2]
$88:E477 BD CC 18    LDA $18CC,x[$7E:18CC]  ;\
$88:E47A 1A          INC A                  ;|
$88:E47B 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:E47C 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:E47F A9 01 00    LDA #$0001             ;\
$88:E482 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1
$88:E485 28          PLP
$88:E486 6B          RTL
}


;;; $E487..E71D: Wavy Phantoon ;;;
{
;;; $E487: Spawn wavy Phantoon HDMA object ;;;
{
$88:E487 08          PHP
$88:E488 8B          PHB
$88:E489 4B          PHK                    ;\
$88:E48A AB          PLB                    ;} DB = $88
$88:E48B C2 30       REP #$30
$88:E48D DA          PHX
$88:E48E 8D 34 10    STA $1034  [$7E:1034]  ; Next wavy Phantoon mode = [A]
$88:E491 9C 6E 10    STZ $106E  [$7E:106E]  ; Wavy Phantoon amplitude = 0
$88:E494 9C 70 10    STZ $1070  [$7E:1070]  ; Wavy Phantoon phase delta direction = growing
$88:E497 A5 16       LDA $16    [$7E:0016]  ;\
$88:E499 8D 72 10    STA $1072  [$7E:1072]  ;} Wavy Phantoon phase delta = [$16]
$88:E49C 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:E4A0             dx 42, 0F, E4A8        ;} Spawn indirect HDMA object for BG2 X scroll with instruction list $E4A8
$88:E4A4 FA          PLX
$88:E4A5 AB          PLB
$88:E4A6 28          PLP
$88:E4A7 6B          RTL
}


;;; $E4A8: Instruction list - wavy Phantoon BG2 X scroll ;;;
{
$88:E4A8             dx 866A,7E,    ; Indirect HDMA data bank = $7E
                        8655,7E,    ; HDMA table bank = $7E
                        E4BD,       ; Set up wavy Phantoon
                        8570,88E567,; Pre-instruction = $88:E567
                        0001,9000,
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $E4BD: Instruction - set up wavy Phantoon ;;;
{
$88:E4BD 08          PHP
$88:E4BE C2 30       REP #$30
$88:E4C0 AD 34 10    LDA $1034  [$7E:1034]  ;\
$88:E4C3 8D F4 0F    STA $0FF4  [$7E:0FF4]  ;} Wavy Phantoon mode = [next wavy Phantoon mode]
$88:E4C6 89 01 00    BIT #$0001             ;\
$88:E4C9 D0 52       BNE $52    [$E51D]     ;} If Phantoon wavelength not doubled:
$88:E4CB A9 A0 00    LDA #$00A0             ;\
$88:E4CE 8F 00 90 7E STA $7E9000[$7E:9000]  ;|
$88:E4D2 8F 03 90 7E STA $7E9003[$7E:9003]  ;|
$88:E4D6 8F 06 90 7E STA $7E9006[$7E:9006]  ;|
$88:E4DA 8F 09 90 7E STA $7E9009[$7E:9009]  ;|
$88:E4DE 8F 0C 90 7E STA $7E900C[$7E:900C]  ;|
$88:E4E2 8F 0F 90 7E STA $7E900F[$7E:900F]  ;|
$88:E4E6 8F 12 90 7E STA $7E9012[$7E:9012]  ;|
$88:E4EA 8F 15 90 7E STA $7E9015[$7E:9015]  ;|
$88:E4EE A9 00 91    LDA #$9100             ;|
$88:E4F1 8F 01 90 7E STA $7E9001[$7E:9001]  ;} $7E:9000..19 = A0h,$9100, A0h,$9140, A0h,$9100, A0h,$9140, A0h,$9100, A0h,$9140, A0h,$9100, A0h,$9140, 0,0
$88:E4F5 8F 07 90 7E STA $7E9007[$7E:9007]  ;|
$88:E4F9 8F 0D 90 7E STA $7E900D[$7E:900D]  ;|
$88:E4FD 8F 13 90 7E STA $7E9013[$7E:9013]  ;|
$88:E501 A9 40 91    LDA #$9140             ;|
$88:E504 8F 04 90 7E STA $7E9004[$7E:9004]  ;|
$88:E508 8F 0A 90 7E STA $7E900A[$7E:900A]  ;|
$88:E50C 8F 10 90 7E STA $7E9010[$7E:9010]  ;|
$88:E510 8F 16 90 7E STA $7E9016[$7E:9016]  ;|
$88:E514 A9 00 00    LDA #$0000             ;|
$88:E517 8F 18 90 7E STA $7E9018[$7E:9018]  ;/
$88:E51B 80 36       BRA $36    [$E553]

$88:E51D A9 C0 00    LDA #$00C0             ;\ Else (Phantoon wavelength doubled):
$88:E520 8F 00 90 7E STA $7E9000[$7E:9000]  ;|
$88:E524 8F 03 90 7E STA $7E9003[$7E:9003]  ;|
$88:E528 8F 06 90 7E STA $7E9006[$7E:9006]  ;|
$88:E52C 8F 09 90 7E STA $7E9009[$7E:9009]  ;|
$88:E530 A9 00 91    LDA #$9100             ;|
$88:E533 8F 01 90 7E STA $7E9001[$7E:9001]  ;|
$88:E537 A9 80 91    LDA #$9180             ;} $7E:9000..0D = C0h,$9100, C0h,$9180, C0h,$9100, C0h,$9180, 0,0
$88:E53A 8F 04 90 7E STA $7E9004[$7E:9004]  ;|
$88:E53E A9 00 91    LDA #$9100             ;|
$88:E541 8F 07 90 7E STA $7E9007[$7E:9007]  ;|
$88:E545 A9 80 91    LDA #$9180             ;|
$88:E548 8F 0A 90 7E STA $7E900A[$7E:900A]  ;|
$88:E54C A9 00 00    LDA #$0000             ;|
$88:E54F 8F 0C 90 7E STA $7E900C[$7E:900C]  ;/

$88:E553 A9 FE FF    LDA #$FFFE             ;\
$88:E556 9D 14 19    STA $1914,x[$7E:1916]  ;} HDMA object wave phase = FFFEh
$88:E559 A9 01 00    LDA #$0001             ;\
$88:E55C 9D 20 19    STA $1920,x[$7E:1922]  ;} HDMA object phase increase timer = 1
$88:E55F 9E 2C 19    STZ $192C,x[$7E:192E]  ; HDMA object $192C = 0 (unused)
$88:E562 9E 38 19    STZ $1938,x[$7E:193A]  ; HDMA object $1938 = 0 (unused)
$88:E565 28          PLP
$88:E566 60          RTS
}


;;; $E567: Pre-instruction - wavy Phantoon ;;;
{
; If [wavy Phantoon mode] = 0:
;     Delete HDMA object
;     Return

; Decrement HDMA object phase increase timer
; If [HDMA object phase increase timer] = 0:
;     HDMA object phase increase timer = 1
;     HDMA object wave phase += [wavy Phantoon phase delta] * 2

; If Phantoon wavelength doubled ([wavy Phantoon mode] & 1 = 0):
;     n = 40h
; Else:
;     n = 20h

; t_0 = [HDMA object wave phase] / 2
; r = [wavy Phantoon amplitude] / 100h
; For i in 0..n-1:
;     t = t_0 + i * 80h / n
;     $7E:9100 + i*2       = [BG2 X scroll] + r * sin(t * pi / 80h)
;     $7E:9100 + n*2 + i*2 = [BG2 X scroll] - r * sin(t * pi / 80h)

; This routine could be rewritten to be considerably faster by using the 8-bit sine table and using the 16-bit x 8-bit signed multiplication registers ($211B et al)

$88:E567 08          PHP
$88:E568 C2 30       REP #$30
$88:E56A AD F4 0F    LDA $0FF4  [$7E:0FF4]  ;\
$88:E56D D0 13       BNE $13    [$E582]     ;} If wavy Phantoon is disabled:
$88:E56F AE B2 18    LDX $18B2  [$7E:18B2]
$88:E572 BD CC 18    LDA $18CC,x[$7E:18CE]  ;\
$88:E575 1A          INC A                  ;|
$88:E576 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:E577 9D CC 18    STA $18CC,x[$7E:18CE]  ;/
$88:E57A A9 01 00    LDA #$0001             ;\
$88:E57D 9D E4 18    STA $18E4,x[$7E:18E6]  ;} HDMA object instruction timer = 1
$88:E580 28          PLP
$88:E581 6B          RTL                    ; Return

$88:E582 89 01 00    BIT #$0001             ;\
$88:E585 D0 0C       BNE $0C    [$E593]     ;} If Phantoon wavelength not doubled:
$88:E587 A9 08 00    LDA #$0008             ;\
$88:E58A 85 1C       STA $1C    [$7E:001C]  ;} $1C = 8
$88:E58C A9 40 00    LDA #$0040             ;\
$88:E58F 85 1E       STA $1E    [$7E:001E]  ;} $1E = 40h
$88:E591 80 0A       BRA $0A    [$E59D]

$88:E593 A9 04 00    LDA #$0004             ;\ Else (Phantoon wavelength doubled):
$88:E596 85 1C       STA $1C    [$7E:001C]  ;} $1C = 4
$88:E598 A9 80 00    LDA #$0080             ;\
$88:E59B 85 1E       STA $1E    [$7E:001E]  ;} $1E = 80h

$88:E59D DA          PHX
$88:E59E DE 20 19    DEC $1920,x[$7E:1922]  ; Decrement HDMA object phase increase timer
$88:E5A1 D0 18       BNE $18    [$E5BB]     ; If [HDMA object phase increase timer] = 0:
$88:E5A3 A9 01 00    LDA #$0001             ;\
$88:E5A6 9D 20 19    STA $1920,x[$7E:1922]  ;} HDMA object phase increase timer = 1
$88:E5A9 AD 72 10    LDA $1072  [$7E:1072]  ;\
$88:E5AC 0A          ASL A                  ;|
$88:E5AD 85 12       STA $12    [$7E:0012]  ;|
$88:E5AF BD 14 19    LDA $1914,x[$7E:1916]  ;|
$88:E5B2 18          CLC                    ;} HDMA object wave phase += [wavy Phantoon phase delta] * 2
$88:E5B3 65 12       ADC $12    [$7E:0012]  ;|
$88:E5B5 29 FF 01    AND #$01FF             ;|
$88:E5B8 9D 14 19    STA $1914,x[$7E:1916]  ;/

$88:E5BB BD 14 19    LDA $1914,x[$7E:1916]  ;\
$88:E5BE 85 14       STA $14    [$7E:0014]  ;} $14 = [HDMA object wave phase]
$88:E5C0 A2 00 00    LDX #$0000             ; X = 0

; LOOP
$88:E5C3 DA          PHX
$88:E5C4 A6 14       LDX $14    [$7E:0014]  ;\
$88:E5C6 BF 43 B4 A0 LDA $A0B443,x[$A0:B451];} If [$14] / 2 <= 80h:
$88:E5CA 10 03       BPL $03    [$E5CF]     ;/
$88:E5CC 4C 56 E6    JMP $E656  [$88:E656]  ; Go to BRANCH_NEGATIVE

$88:E5CF 85 12       STA $12    [$7E:0012]  ; $12 = sin([$14] / 2 * pi / 80h) * 100h
$88:E5D1 E2 20       SEP #$20               ;\
$88:E5D3 8D 02 42    STA $4202              ;|
$88:E5D6 AD 6E 10    LDA $106E  [$7E:106E]  ;|
$88:E5D9 8D 03 42    STA $4203              ;|
$88:E5DC EA          NOP                    ;|
$88:E5DD EA          NOP                    ;} A = [wavy Phantoon amplitude low] * [$12 low] / 100h
$88:E5DE EA          NOP                    ;|
$88:E5DF C2 20       REP #$20               ;|
$88:E5E1 AD 16 42    LDA $4216              ;|
$88:E5E4 EB          XBA                    ;|
$88:E5E5 29 FF 00    AND #$00FF             ;/
$88:E5E8 85 16       STA $16    [$7E:0016]  ;\
$88:E5EA E2 20       SEP #$20               ;|
$88:E5EC A5 13       LDA $13    [$7E:0013]  ;|
$88:E5EE 8D 02 42    STA $4202              ;|
$88:E5F1 AD 6E 10    LDA $106E  [$7E:106E]  ;|
$88:E5F4 8D 03 42    STA $4203              ;|
$88:E5F7 EA          NOP                    ;} A += [wavy Phantoon amplitude low] * [$12 high]
$88:E5F8 EA          NOP                    ;|
$88:E5F9 EA          NOP                    ;|
$88:E5FA C2 20       REP #$20               ;|
$88:E5FC AD 16 42    LDA $4216              ;|
$88:E5FF 18          CLC                    ;|
$88:E600 65 16       ADC $16    [$7E:0016]  ;/
$88:E602 85 16       STA $16    [$7E:0016]  ;\
$88:E604 E2 20       SEP #$20               ;|
$88:E606 A5 12       LDA $12    [$7E:0012]  ;|
$88:E608 8D 02 42    STA $4202              ;|
$88:E60B AD 6F 10    LDA $106F  [$7E:106F]  ;|
$88:E60E 8D 03 42    STA $4203              ;|
$88:E611 EA          NOP                    ;|
$88:E612 EA          NOP                    ;|
$88:E613 EA          NOP                    ;|
$88:E614 C2 20       REP #$20               ;|
$88:E616 AD 16 42    LDA $4216              ;} A += [wavy Phantoon amplitude high] * [$12 low]
$88:E619 85 18       STA $18    [$7E:0018]  ;|
$88:E61B E2 20       SEP #$20               ;|
$88:E61D A5 13       LDA $13    [$7E:0013]  ;|
$88:E61F 8D 02 42    STA $4202              ;|
$88:E622 AD 6F 10    LDA $106F  [$7E:106F]  ;|
$88:E625 8D 03 42    STA $4203              ;|
$88:E628 C2 20       REP #$20               ;|
$88:E62A A5 16       LDA $16    [$7E:0016]  ;|
$88:E62C 18          CLC                    ;|
$88:E62D 65 18       ADC $18    [$7E:0018]  ;/
$88:E62F 85 16       STA $16    [$7E:0016]  ;\
$88:E631 AD 15 42    LDA $4215              ;|
$88:E634 29 00 FF    AND #$FF00             ;} A += [wavy Phantoon amplitude high] * [$12 high] * 100h (whoops, carry isn't being propagated)
$88:E637 18          CLC                    ;|
$88:E638 65 16       ADC $16    [$7E:0016]  ;/
$88:E63A 29 00 FF    AND #$FF00             ;\
$88:E63D EB          XBA                    ;} $12 = [A] / 100h
$88:E63E 85 12       STA $12    [$7E:0012]  ;/
$88:E640 8A          TXA                    ;\
$88:E641 18          CLC                    ;} $14 += [$1C]
$88:E642 65 1C       ADC $1C    [$7E:001C]  ;/
$88:E644 29 FF 01    AND #$01FF             ;\
$88:E647 85 14       STA $14    [$7E:0014]  ;} $14 %= 200h
$88:E649 FA          PLX
$88:E64A A5 B5       LDA $B5    [$7E:00B5]  ;\
$88:E64C 18          CLC                    ;|
$88:E64D 65 12       ADC $12    [$7E:0012]  ;} $7E:9100 + [X] = [BG2 X scroll] + [$12]
$88:E64F 9F 00 91 7E STA $7E9100,x[$7E:9100];/
$88:E653 4C DE E6    JMP $E6DE  [$88:E6DE]  ; Go to BRANCH_NEXT

; BRANCH_NEGATIVE
$88:E656 49 FF FF    EOR #$FFFF             ;\
$88:E659 1A          INC A                  ;} $12 = -sin([$14] / 2 * pi / 80h) * 100h
$88:E65A 85 12       STA $12    [$7E:0012]  ;/
$88:E65C E2 20       SEP #$20               ;\
$88:E65E 8D 02 42    STA $4202              ;|
$88:E661 AD 6E 10    LDA $106E  [$7E:106E]  ;|
$88:E664 8D 03 42    STA $4203              ;|
$88:E667 EA          NOP                    ;|
$88:E668 EA          NOP                    ;|
$88:E669 EA          NOP                    ;|
$88:E66A C2 20       REP #$20               ;|
$88:E66C AD 16 42    LDA $4216              ;|
$88:E66F EB          XBA                    ;|
$88:E670 29 FF 00    AND #$00FF             ;|
$88:E673 85 16       STA $16    [$7E:0016]  ;|
$88:E675 E2 20       SEP #$20               ;|
$88:E677 A5 13       LDA $13    [$7E:0013]  ;|
$88:E679 8D 02 42    STA $4202              ;|
$88:E67C AD 6E 10    LDA $106E  [$7E:106E]  ;|
$88:E67F 8D 03 42    STA $4203              ;|
$88:E682 EA          NOP                    ;|
$88:E683 EA          NOP                    ;|
$88:E684 EA          NOP                    ;|
$88:E685 C2 20       REP #$20               ;|
$88:E687 AD 16 42    LDA $4216              ;|
$88:E68A 18          CLC                    ;|
$88:E68B 65 16       ADC $16    [$7E:0016]  ;|
$88:E68D 85 16       STA $16    [$7E:0016]  ;|
$88:E68F E2 20       SEP #$20               ;|
$88:E691 A5 12       LDA $12    [$7E:0012]  ;} Same as above: $12 = [wavy Phantoon amplitude] * [$12] / 10000h (possibly off-by-1)
$88:E693 8D 02 42    STA $4202              ;|
$88:E696 AD 6F 10    LDA $106F  [$7E:106F]  ;|
$88:E699 8D 03 42    STA $4203              ;|
$88:E69C EA          NOP                    ;|
$88:E69D EA          NOP                    ;|
$88:E69E EA          NOP                    ;|
$88:E69F C2 20       REP #$20               ;|
$88:E6A1 AD 16 42    LDA $4216              ;|
$88:E6A4 85 18       STA $18    [$7E:0018]  ;|
$88:E6A6 E2 20       SEP #$20               ;|
$88:E6A8 A5 13       LDA $13    [$7E:0013]  ;|
$88:E6AA 8D 02 42    STA $4202              ;|
$88:E6AD AD 6F 10    LDA $106F  [$7E:106F]  ;|
$88:E6B0 8D 03 42    STA $4203              ;|
$88:E6B3 C2 20       REP #$20               ;|
$88:E6B5 A5 16       LDA $16    [$7E:0016]  ;|
$88:E6B7 18          CLC                    ;|
$88:E6B8 65 18       ADC $18    [$7E:0018]  ;|
$88:E6BA 85 16       STA $16    [$7E:0016]  ;|
$88:E6BC AD 15 42    LDA $4215              ;|
$88:E6BF 29 00 FF    AND #$FF00             ;|
$88:E6C2 18          CLC                    ;|
$88:E6C3 65 16       ADC $16    [$7E:0016]  ;|
$88:E6C5 29 00 FF    AND #$FF00             ;|
$88:E6C8 EB          XBA                    ;|
$88:E6C9 85 12       STA $12    [$7E:0012]  ;/
$88:E6CB 8A          TXA                    ;\
$88:E6CC 18          CLC                    ;} $14 += [$1C]
$88:E6CD 65 1C       ADC $1C    [$7E:001C]  ;/
$88:E6CF 29 FF 01    AND #$01FF             ;\
$88:E6D2 85 14       STA $14    [$7E:0014]  ;} $14 %= 200h
$88:E6D4 FA          PLX
$88:E6D5 A5 B5       LDA $B5    [$7E:00B5]  ;\
$88:E6D7 38          SEC                    ;|
$88:E6D8 E5 12       SBC $12    [$7E:0012]  ;} $7E:9100 + [X] = [BG2 X scroll] - [$12]
$88:E6DA 9F 00 91 7E STA $7E9100,x[$7E:913E];/

; BRANCH_NEXT
$88:E6DE E8          INX                    ;\
$88:E6DF E8          INX                    ;} X += 2
$88:E6E0 E4 1E       CPX $1E    [$7E:001E]  ;\
$88:E6E2 10 03       BPL $03    [$E6E7]     ;} If [X] < [$1E]:
$88:E6E4 4C C3 E5    JMP $E5C3  [$88:E5C3]  ; Go to LOOP

$88:E6E7 AD F4 0F    LDA $0FF4  [$7E:0FF4]  ;\
$88:E6EA 89 01 00    BIT #$0001             ;} If Phantoon wavelength not doubled:
$88:E6ED D0 17       BNE $17    [$E706]     ;/
$88:E6EF A2 3E 00    LDX #$003E             ;\
                                            ;|
$88:E6F2 A5 B5       LDA $B5    [$7E:00B5]  ;|
$88:E6F4 38          SEC                    ;|
$88:E6F5 FF 00 91 7E SBC $7E9100,x[$7E:913E];|
$88:E6F9 18          CLC                    ;} $7E:9140..7F = [BG2 X scroll] - ([$7E:9100..3F] - [BG2 X scroll])
$88:E6FA 65 B5       ADC $B5    [$7E:00B5]  ;|
$88:E6FC 9F 40 91 7E STA $7E9140,x[$7E:917E];|
$88:E700 CA          DEX                    ;|
$88:E701 CA          DEX                    ;|
$88:E702 10 EE       BPL $EE    [$E6F2]     ;/
$88:E704 80 15       BRA $15    [$E71B]

$88:E706 A2 7E 00    LDX #$007E             ;\ Else (Phantoon wavelength doubled):
                                            ;|
$88:E709 A5 B5       LDA $B5    [$7E:00B5]  ;|
$88:E70B 38          SEC                    ;|
$88:E70C FF 00 91 7E SBC $7E9100,x[$7E:917E];|
$88:E710 18          CLC                    ;} $7E:9180..FF = [BG2 X scroll] - ([$7E:9100..7F] - [BG2 X scroll])
$88:E711 65 B5       ADC $B5    [$7E:00B5]  ;|
$88:E713 9F 80 91 7E STA $7E9180,x[$7E:91FE];|
$88:E717 CA          DEX                    ;|
$88:E718 CA          DEX                    ;|
$88:E719 10 EE       BPL $EE    [$E709]     ;/

$88:E71B FA          PLX
$88:E71C 28          PLP
$88:E71D 6B          RTL
}
}


;;; $E71E..E747: Mother Brain rising HDMA object ;;;
{
;;; $E71E: Spawn Mother Brain rising HDMA object ;;;
{
; Prevent Mother Brain's legs (sprites) from appearing over the floor
$88:E71E 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:E722             dx 00, 2C, E727        ;} Spawn HDMA object for main screen layers with instruction list $E727
$88:E726 6B          RTL
}


;;; $E727: Instruction list - Mother Brain rising main screen layers ;;;
{
$88:E727             dx 8655,88,    ; HDMA table bank = $88
                        866A,88,    ; Indirect HDMA data bank = $88
                        85B4,88E726,; NOP
                        8570,88E726,; Pre-instruction = $88:E726 (RTL)
                        0001,E73D,
                        8682        ; Sleep
}


;;; $E73D: HDMA table - Mother Brain rising main screen layers ;;;
{
$88:E73D             db 20,04, ;         BG3
                        18,15, ; BG1/    BG3/sprites
                        60,13, ; BG1/BG2/    sprites
                        40,13, ; BG1/BG2/    sprites
                        08,05, ; BG1/    BG3
                        00
}
}


;;; $E748..E8D8: Mother Brain rainbow beam ;;;
{
;;; $E748: Spawn Mother Brain rainbow beam HDMA object ;;;
{
$88:E748 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:E74C             dx 41, 26, E751        ;} Spawn indirect HDMA object for window 1 position with instruction list $E751
$88:E750 6B          RTL
}


;;; $E751: Instruction list - Mother Brain rainbow beam window 1 position ;;;
{
$88:E751             dx 8655,7E,    ; HDMA table bank = $7E
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        85B4,88E767,; Initialise rainbow beam
                        8570,88E7BC,; Pre-instruction = $88:E7BC
                        0001,9C00,
                        8682        ; Sleep
}


;;; $E767: Initialise rainbow beam ;;;
{
$88:E767 08          PHP
$88:E768 E2 20       SEP #$20               ;\
$88:E76A C2 10       REP #$10               ;|
$88:E76C A9 20       LDA #$20               ;|
$88:E76E 85 74       STA $74    [$7E:0074]  ;|
$88:E770 A9 47       LDA #$47               ;} Colour math subscreen backdrop colour = (0, 7, Fh) (greenish blue)
$88:E772 85 75       STA $75    [$7E:0075]  ;|
$88:E774 A9 8F       LDA #$8F               ;|
$88:E776 85 76       STA $76    [$7E:0076]  ;|
$88:E778 C2 30       REP #$30               ;/
$88:E77A A9 24 00    LDA #$0024             ;\
$88:E77D 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 24h (BG1/BG2/sprites are drawn the backdrop is added on top inside window 1)
$88:E780 E2 20       SEP #$20
$88:E782 A9 E4       LDA #$E4               ; >_<;
$88:E784 A9 64       LDA #$64               ;\
$88:E786 8F 00 9C 7E STA $7E9C00[$7E:9C00]  ;|
$88:E78A C2 20       REP #$20               ;|
$88:E78C A9 00 9D    LDA #$9D00             ;} $7E:9C00..04 = 64h,$9D00, 0,0
$88:E78F 8F 01 9C 7E STA $7E9C01[$7E:9C01]  ;|
$88:E793 A9 00 00    LDA #$0000             ;|
$88:E796 8F 03 9C 7E STA $7E9C03[$7E:9C03]  ;/
$88:E79A A9 00 00    LDA #$0000             ;\
$88:E79D 8F 00 9D 7E STA $7E9D00[$7E:9D00]  ;} $7E:9D00 = 00h,00h
$88:E7A1 A9 20 80    LDA #$8020             ;\
$88:E7A4 8F 02 9D 7E STA $7E9D02[$7E:9D02]  ;} $7E:9D02 = 20h,80h
$88:E7A8 A9 00 00    LDA #$0000             ;\
$88:E7AB 8F 04 9D 7E STA $7E9D04[$7E:9D04]  ;} $7E:9D04 = 00h,00h
$88:E7AF 8B          PHB                    ;\
$88:E7B0 F4 00 A9    PEA $A900              ;|
$88:E7B3 AB          PLB                    ;|
$88:E7B4 AB          PLB                    ;} Calculate Mother Brain rainbow beam HDMA tables
$88:E7B5 22 66 94 A9 JSL $A99466[$A9:9466]  ;|
$88:E7B9 AB          PLB                    ;/
$88:E7BA 28          PLP
$88:E7BB 6B          RTL
}


;;; $E7BC: Pre-instruction - Mother Brain rainbow beam ;;;
{
$88:E7BC 08          PHP
$88:E7BD C2 30       REP #$30
$88:E7BF AD 98 09    LDA $0998  [$7E:0998]  ;\
$88:E7C2 C9 13 00    CMP #$0013             ;} If [game state] = death sequence, start: go to BRANCH_DELETE
$88:E7C5 F0 1E       BEQ $1E    [$E7E5]     ;/
$88:E7C7 A9 24 00    LDA #$0024             ;\
$88:E7CA 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 24h (BG1/BG2/sprites are drawn the backdrop is added on top inside window 1)
$88:E7CD AD 98 09    LDA $0998  [$7E:0998]  ;\
$88:E7D0 C9 1B 00    CMP #$001B             ;} If [game state] != reserve tanks auto:
$88:E7D3 F0 0E       BEQ $0E    [$E7E3]     ;/
$88:E7D5 8B          PHB                    ;\
$88:E7D6 F4 00 A9    PEA $A900              ;|
$88:E7D9 AB          PLB                    ;|
$88:E7DA AB          PLB                    ;} Calculate Mother Brain rainbow beam HDMA tables
$88:E7DB 22 66 94 A9 JSL $A99466[$A9:9466]  ;|
$88:E7DF AB          PLB                    ;/
$88:E7E0 20 ED E7    JSR $E7ED  [$88:E7ED]  ; Set rainbow beam colour math subscreen backdrop colour

$88:E7E3 28          PLP
$88:E7E4 6B          RTL                    ; Return

; BRANCH_DELETE
$88:E7E5 AE B2 18    LDX $18B2  [$7E:18B2]
$88:E7E8 9E B4 18    STZ $18B4,x            ; Delete HDMA object
$88:E7EB 28          PLP
$88:E7EC 6B          RTL
}


;;; $E7ED: Set rainbow beam colour math subscreen backdrop colour ;;;
{
$88:E7ED AE 14 19    LDX $1914  [$7E:1914]  ;\
$88:E7F0 BD 33 E8    LDA $E833,x[$88:E833]  ;} A = [$E833 + [HDMA object 0 colour index]]
$88:E7F3 10 08       BPL $08    [$E7FD]     ; If [A] & 8000h != 0:
$88:E7F5 9C 14 19    STZ $1914  [$7E:1914]  ; HDMA object 0 colour index = 0
$88:E7F8 AD 33 E8    LDA $E833  [$88:E833]  ; A = 1Fh (red)
$88:E7FB 80 0C       BRA $0C    [$E809]

$88:E7FD EE 14 19    INC $1914  [$7E:1914]  ;\ Else ([A] & 8000h = 0):
$88:E800 EE 14 19    INC $1914  [$7E:1914]  ;|
$88:E803 EE 14 19    INC $1914  [$7E:1914]  ;} HDMA object 0 colour index += 4
$88:E806 EE 14 19    INC $1914  [$7E:1914]  ;/

$88:E809 48          PHA                    ;\
$88:E80A E2 20       SEP #$20               ;|
$88:E80C 29 1F       AND #$1F               ;|
$88:E80E 09 20       ORA #$20               ;|
$88:E810 85 74       STA $74    [$7E:0074]  ;|
$88:E812 C2 20       REP #$20               ;|
$88:E814 A3 01       LDA $01,s  [$7E:1FF0]  ;|
$88:E816 0A          ASL A                  ;|
$88:E817 0A          ASL A                  ;|
$88:E818 0A          ASL A                  ;|
$88:E819 EB          XBA                    ;|
$88:E81A E2 20       SEP #$20               ;|
$88:E81C 29 1F       AND #$1F               ;} Colour math subscreen backdrop colour = ([A] & 1Fh, [A] >> 5 & 1Fh, [A] >> Ah & 1Fh)
$88:E81E 09 40       ORA #$40               ;|
$88:E820 85 75       STA $75    [$7E:0075]  ;|
$88:E822 C2 20       REP #$20               ;|
$88:E824 68          PLA                    ;|
$88:E825 4A          LSR A                  ;|
$88:E826 4A          LSR A                  ;|
$88:E827 EB          XBA                    ;|
$88:E828 E2 20       SEP #$20               ;|
$88:E82A 29 1F       AND #$1F               ;|
$88:E82C 09 80       ORA #$80               ;|
$88:E82E 85 76       STA $76    [$7E:0076]  ;|
$88:E830 C2 20       REP #$20               ;/
$88:E832 60          RTS

; Rainbow beam colour table
; The table index is incremented by 4 per frame instead of 2, so only entries 2k for some k are used
$88:E833             dw 001F,005F, 009F,00DF, 011F,015F, 019F,01DF,
                        023F,027F, 02BF,02FF, 033F,037F, 03BF,03FF,
                        03FD,03FB, 03F9,03F7, 03F5,03F3, 03F1,03EF,
                        03EC,03EA, 03E8,03E6, 03E4,03E2, 03E0,0BA0,
                        1360,1B20, 22E0,2AA0, 3260,3A20, 45E0,4D80,
                        5540,5D00, 64C0,6C80, 7440,7C00, 7C02,7C04,
                        7C06,7C08, 7C0A,7C0C, 7C0D,7C2F, 7C31,7C33,
                        7C35,7C37, 7C39,7C3B, 7C1F,741F, 6C1F,641F,
                        5C1F,541F, 4C1F,441F, 3C1F,301F, 281F,201F,
                        181F,101F, 081F,FFFF, FFFF,
                        FFFF,FFFF,FFFF,FFFF,FFFF,FFFF ; Excess terminators
}
}


;;; $E8D9..EB57: Morph ball eye beam ;;;
{
;;; $E8D9: Spawn morph ball eye beam HDMA object ;;;
{
$88:E8D9 08          PHP
$88:E8DA 8B          PHB
$88:E8DB 4B          PHK                    ;\
$88:E8DC AB          PLB                    ;} DB = $88
$88:E8DD C2 30       REP #$30
$88:E8DF DA          PHX
$88:E8E0 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:E8E4             dx 41, 26, E8EC        ;} Spawn indirect HDMA object for window 1 position with instruction list $E8EC
$88:E8E8 FA          PLX
$88:E8E9 AB          PLB
$88:E8EA 28          PLP
$88:E8EB 6B          RTL
}


;;; $E8EC: Instruction list - window 1 position - morph ball eye beam ;;;
{
$88:E8EC             dx 866A,7E,    ; Indirect HDMA data bank = $7E
                        8655,7E,    ; HDMA table bank = $7E
                        E917,       ; Initialise morph ball eye beam HDMA
                        8570,88E9E6,; Pre-instruction = $88:E9E6
                        0001,9000,
                        8682,       ; Sleep
                        8570,88EA3C,; Pre-instruction = $88:EA3C
                        0001,9000,
                        8682,       ; Sleep
                        8570,88EACB,; Pre-instruction = $88:EACB
                        0001,9000,
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $E917: Instruction - initialise morph ball eye beam HDMA ;;;
{
$88:E917 08          PHP
$88:E918 E2 20       SEP #$20
$88:E91A C2 10       REP #$10
$88:E91C A9 30       LDA #$30               ;\
$88:E91E 9D 14 19    STA $1914,x[$7E:1914]  ;|
$88:E921 85 74       STA $74    [$7E:0074]  ;|
$88:E923 A9 50       LDA #$50               ;|
$88:E925 9D 15 19    STA $1915,x[$7E:1915]  ;} Colour math subscreen backdrop colour = HDMA object colour components = (10h, 10h, 0) (dark yellow)
$88:E928 85 75       STA $75    [$7E:0075]  ;|
$88:E92A A9 80       LDA #$80               ;|
$88:E92C 9D 20 19    STA $1920,x[$7E:1920]  ;|
$88:E92F 85 76       STA $76    [$7E:0076]  ;/
$88:E931 C2 30       REP #$30
$88:E933 A9 10 00    LDA #$0010             ;\
$88:E936 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 10h (normal, but BG3 is disabled inside window 1)
$88:E939 A9 E4 00    LDA #$00E4             ;\
$88:E93C 8F 00 90 7E STA $7E9000[$7E:9000]  ;|
$88:E940 A9 00 91    LDA #$9100             ;|
$88:E943 8F 01 90 7E STA $7E9001[$7E:9001]  ;|
$88:E947 A9 E4 00    LDA #$00E4             ;|
$88:E94A 8F 03 90 7E STA $7E9003[$7E:9003]  ;|
$88:E94E A9 C8 91    LDA #$91C8             ;|
$88:E951 8F 04 90 7E STA $7E9004[$7E:9004]  ;} $7E:9000..0A = E4h,$9100, E4h,$91C8, 98h,$9290, 0,0
$88:E955 A9 98 00    LDA #$0098             ;|
$88:E958 8F 06 90 7E STA $7E9006[$7E:9006]  ;|
$88:E95C A9 90 92    LDA #$9290             ;|
$88:E95F 8F 07 90 7E STA $7E9007[$7E:9007]  ;|
$88:E963 A9 00 00    LDA #$0000             ;|
$88:E966 8F 09 90 7E STA $7E9009[$7E:9009]  ;/
$88:E96A A9 01 00    LDA #$0001             ;\
$88:E96D 8D EC 0F    STA $0FEC  [$7E:0FEC]  ;} Enemy 1 activated flag = 1
$88:E970 9E 2C 19    STZ $192C,x[$7E:192C]  ;\
$88:E973 9E 38 19    STZ $1938,x[$7E:1938]  ;} HDMA object angular width = 0.0
$88:E976 A9 00 00    LDA #$0000             ;\
$88:E979 8F 80 90 7E STA $7E9080[$7E:9080]  ;} Morph ball eye beam angular width delta = 0.0
$88:E97D 8F 82 90 7E STA $7E9082[$7E:9082]  ;/
$88:E981 8F 90 90 7E STA $7E9090[$7E:9090]  ; Morph ball eye beam colour index = 0
$88:E985 28          PLP
$88:E986 60          RTS
}


;;; $E987: Update morph ball eye beam HDMA data table and colour math subscreen backdrop colour ;;;
{
$88:E987 08          PHP
$88:E988 C2 30       REP #$30
$88:E98A DA          PHX
$88:E98B AD EE 0F    LDA $0FEE  [$7E:0FEE]  ;\
$88:E98E 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy 1 beam angle]
$88:E990 BD 2C 19    LDA $192C,x[$7E:192C]  ;\
$88:E993 85 14       STA $14    [$7E:0014]  ;} $14 = [HDMA object angular width]
$88:E995 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$88:E998 38          SEC                    ;|
$88:E999 ED 15 09    SBC $0915  [$7E:0915]  ;} Y = [enemy 1 Y position] - [layer 1 Y position] (morph ball eye beam origin Y position)
$88:E99C A8          TAY                    ;/
$88:E99D AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$88:E9A0 38          SEC                    ;|
$88:E9A1 ED 11 09    SBC $0911  [$7E:0911]  ;} X = [enemy 1 X position] - [layer 1 X position] (morph ball eye beam origin X position)
$88:E9A4 AA          TAX                    ;/
$88:E9A5 30 18       BMI $18    [$E9BF]     ;\
$88:E9A7 C9 00 01    CMP #$0100             ;} If 0 <= [X] < 100h:
$88:E9AA 10 13       BPL $13    [$E9BF]     ;/
$88:E9AC E2 20       SEP #$20               ;\
$88:E9AE A9 7E       LDA #$7E               ;|
$88:E9B0 85 02       STA $02    [$7E:0002]  ;|
$88:E9B2 C2 20       REP #$20               ;} $00 = $7E:9100 (morph ball eye beam HDMA data table)
$88:E9B4 A9 00 91    LDA #$9100             ;|
$88:E9B7 85 00       STA $00    [$7E:0000]  ;/
$88:E9B9 22 4B C5 91 JSL $91C54B[$91:C54B]  ; Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen
$88:E9BD 80 11       BRA $11    [$E9D0]

$88:E9BF E2 20       SEP #$20               ;\ Else (not 0 <= [X] < 100h):
$88:E9C1 A9 7E       LDA #$7E               ;|
$88:E9C3 85 02       STA $02    [$7E:0002]  ;|
$88:E9C5 C2 20       REP #$20               ;} $00 = $7E:9100 (morph ball eye beam HDMA data table)
$88:E9C7 A9 00 91    LDA #$9100             ;|
$88:E9CA 85 00       STA $00    [$7E:0000]  ;/
$88:E9CC 22 11 BE 91 JSL $91BE11[$91:BE11]  ; Calculate morph ball eye beam HDMA data table - origin is off screen

$88:E9D0 FA          PLX
$88:E9D1 E2 20       SEP #$20
$88:E9D3 BD 14 19    LDA $1914,x[$7E:1914]  ;\
$88:E9D6 85 74       STA $74    [$7E:0074]  ;|
$88:E9D8 BD 15 19    LDA $1915,x[$7E:1915]  ;|
$88:E9DB 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = [HDMA object colour component]
$88:E9DD BD 20 19    LDA $1920,x[$7E:1920]  ;|
$88:E9E0 85 76       STA $76    [$7E:0076]  ;/
$88:E9E2 C2 20       REP #$20               ; >_<;
$88:E9E4 28          PLP
$88:E9E5 60          RTS
}


;;; $E9E6: Pre-instruction - morph ball eye beam HDMA - beam is widening ;;;
{
$88:E9E6 08          PHP
$88:E9E7 C2 30       REP #$30
$88:E9E9 A9 10 00    LDA #$0010             ;\
$88:E9EC 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 10h (normal, but BG3 is disabled inside window 1)
$88:E9EF AF 82 90 7E LDA $7E9082[$7E:9082]  ;\
$88:E9F3 18          CLC                    ;|
$88:E9F4 69 00 40    ADC #$4000             ;|
$88:E9F7 8F 82 90 7E STA $7E9082[$7E:9082]  ;} Morph ball eye beam angular width delta += 0.4000h
$88:E9FB AF 80 90 7E LDA $7E9080[$7E:9080]  ;|
$88:E9FF 69 00 00    ADC #$0000             ;|
$88:EA02 8F 80 90 7E STA $7E9080[$7E:9080]  ;/
$88:EA06 BD 38 19    LDA $1938,x[$7E:1938]  ;\
$88:EA09 18          CLC                    ;|
$88:EA0A 6F 82 90 7E ADC $7E9082[$7E:9082]  ;|
$88:EA0E 9D 38 19    STA $1938,x[$7E:1938]  ;} HDMA object angular width += [morph ball eye beam angular width delta]
$88:EA11 BD 2C 19    LDA $192C,x[$7E:192C]  ;|
$88:EA14 6F 80 90 7E ADC $7E9080[$7E:9080]  ;|
$88:EA18 9D 2C 19    STA $192C,x[$7E:192C]  ;/
$88:EA1B C9 04 00    CMP #$0004             ;\
$88:EA1E 30 17       BMI $17    [$EA37]     ;} If [HDMA object angular width] >= 4:
$88:EA20 A9 04 00    LDA #$0004             ;\
$88:EA23 9D 2C 19    STA $192C,x[$7E:192C]  ;} HDMA object angular width = 4
$88:EA26 AE B2 18    LDX $18B2  [$7E:18B2]
$88:EA29 BD CC 18    LDA $18CC,x[$7E:18CC]  ;\
$88:EA2C 1A          INC A                  ;|
$88:EA2D 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:EA2E 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:EA31 A9 01 00    LDA #$0001             ;\
$88:EA34 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1

$88:EA37 20 87 E9    JSR $E987  [$88:E987]  ; Update morph ball eye beam HDMA data table and colour math subscreen backdrop colour
$88:EA3A 28          PLP
$88:EA3B 6B          RTL
}


;;; $EA3C: Pre-instruction - morph ball eye beam HDMA - full beam ;;;
{
$88:EA3C 08          PHP
$88:EA3D C2 30       REP #$30
$88:EA3F A9 10 00    LDA #$0010             ;\
$88:EA42 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 10h (normal, but BG3 is disabled inside window 1)
$88:EA45 AD EC 0F    LDA $0FEC  [$7E:0FEC]  ;\
$88:EA48 D0 13       BNE $13    [$EA5D]     ;} If [enemy 1 activated flag] = 0:
$88:EA4A AE B2 18    LDX $18B2  [$7E:18B2]
$88:EA4D BD CC 18    LDA $18CC,x[$7E:18CC]  ;\
$88:EA50 1A          INC A                  ;|
$88:EA51 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:EA52 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:EA55 A9 01 00    LDA #$0001             ;\
$88:EA58 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1
$88:EA5B 28          PLP
$88:EA5C 6B          RTL                    ; Return

$88:EA5D 20 87 E9    JSR $E987  [$88:E987]  ; Update morph ball eye beam HDMA data table and colour math subscreen backdrop colour
$88:EA60 AF 90 90 7E LDA $7E9090[$7E:9090]  ;\
$88:EA64 0A          ASL A                  ;|
$88:EA65 0A          ASL A                  ;} Y = [morph ball eye beam colour index] * 4
$88:EA66 A8          TAY                    ;/
$88:EA67 E2 20       SEP #$20
$88:EA69 B9 8B EA    LDA $EA8B,y[$88:EA8B]  ;\
$88:EA6C 9D 14 19    STA $1914,x[$7E:1914]  ;} HDMA object red colour component = [$EA8B + [Y]]
$88:EA6F B9 8C EA    LDA $EA8C,y[$88:EA8C]  ;\
$88:EA72 9D 15 19    STA $1915,x[$7E:1915]  ;} HDMA object green colour component = [$EA8B + [Y] + 1]
$88:EA75 B9 8D EA    LDA $EA8D,y[$88:EA8D]  ;\
$88:EA78 9D 20 19    STA $1920,x[$7E:1920]  ;} HDMA object blue colour component = [$EA8B + [Y] + 2]
$88:EA7B C2 20       REP #$20
$88:EA7D AF 90 90 7E LDA $7E9090[$7E:9090]  ;\
$88:EA81 1A          INC A                  ;|
$88:EA82 29 0F 00    AND #$000F             ;} Morph ball eye beam colour index = ([morph ball eye beam colour index] + 1) % 10h
$88:EA85 8F 90 90 7E STA $7E9090[$7E:9090]  ;/
$88:EA89 28          PLP
$88:EA8A 6B          RTL

;                        __________ Red component
;                       |   _______ Green component
;                       |  |   ____ Blue component
;                       |  |  |
$88:EA8B             db 30,50,80, 00,
                        2F,4F,80, 00,
                        2E,4E,80, 00,
                        2D,4D,80, 00,
                        2C,4C,80, 00,
                        2B,4B,80, 00,
                        2A,4A,80, 00,
                        29,49,80, 00,
                        28,48,80, 00,
                        29,49,80, 00,
                        2A,4A,80, 00,
                        2B,4B,80, 00,
                        2C,4C,80, 00,
                        2D,4D,80, 00,
                        2E,4E,80, 00,
                        2F,4F,80, 00
}


;;; $EACB: Pre-instruction - morph ball eye beam HDMA - deactivate beam ;;;
{
$88:EACB 08          PHP
$88:EACC C2 30       REP #$30
$88:EACE A9 10 00    LDA #$0010             ;\
$88:EAD1 8D 86 19    STA $1986  [$7E:1986]  ;} Layer blending configuration = 10h (normal, but BG3 is disabled inside window 1)
$88:EAD4 E2 20       SEP #$20
$88:EAD6 BD 15 19    LDA $1915,x[$7E:1915]  ;\
$88:EAD9 C9 40       CMP #$40               ;} If (HDMA object green colour component) != 0: go to BRANCH_NOT_DONE
$88:EADB D0 4C       BNE $4C    [$EB29]     ;/
$88:EADD A9 20       LDA #$20               ;\
$88:EADF 85 74       STA $74    [$7E:0074]  ;|
$88:EAE1 A9 40       LDA #$40               ;|
$88:EAE3 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$88:EAE5 A9 80       LDA #$80               ;|
$88:EAE7 85 76       STA $76    [$7E:0076]  ;/
$88:EAE9 C2 20       REP #$20
$88:EAEB 9E 38 19    STZ $1938,x[$7E:1938]  ;\
$88:EAEE 9E 2C 19    STZ $192C,x[$7E:192C]  ;} HDMA object angular width = 0.0
$88:EAF1 A2 FE 01    LDX #$01FE

$88:EAF4 A9 FF 00    LDA #$00FF             ;\
$88:EAF7 9F 00 91 7E STA $7E9100,x[$7E:92FE];|
$88:EAFB CA          DEX                    ;} Morph ball eye beam window 1 HDMA data table = FFh,0
$88:EAFC CA          DEX                    ;|
$88:EAFD 10 F5       BPL $F5    [$EAF4]     ;/
$88:EAFF A9 00 00    LDA #$0000             ;\
$88:EB02 8F 00 90 7E STA $7E9000[$7E:9000]  ;|
$88:EB06 8F 02 90 7E STA $7E9002[$7E:9002]  ;|
$88:EB0A 8F 04 90 7E STA $7E9004[$7E:9004]  ;} Morph ball eye beam window 1 indirect HDMA table = 0,0, ...
$88:EB0E 8F 06 90 7E STA $7E9006[$7E:9006]  ;|
$88:EB12 8F 08 90 7E STA $7E9008[$7E:9008]  ;/
$88:EB16 AE B2 18    LDX $18B2  [$7E:18B2]
$88:EB19 BD CC 18    LDA $18CC,x[$7E:18CC]  ;\
$88:EB1C 1A          INC A                  ;|
$88:EB1D 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:EB1E 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:EB21 A9 01 00    LDA #$0001             ;\
$88:EB24 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1
$88:EB27 80 2D       BRA $2D    [$EB56]     ; Return

; BRANCH_NOT_DONE
$88:EB29 C2 20       REP #$20
$88:EB2B 20 87 E9    JSR $E987  [$88:E987]  ; Update morph ball eye beam HDMA data table and colour math subscreen backdrop colour
$88:EB2E AE B2 18    LDX $18B2  [$7E:18B2]
$88:EB31 E2 20       SEP #$20
$88:EB33 BD 14 19    LDA $1914,x[$7E:1914]  ;\
$88:EB36 C9 20       CMP #$20               ;|
$88:EB38 F0 04       BEQ $04    [$EB3E]     ;} (HDMA object red colour component) = max(0, (HDMA object red colour component) - 1)
$88:EB3A 3A          DEC A                  ;|
$88:EB3B 9D 14 19    STA $1914,x[$7E:1914]  ;/

$88:EB3E BD 15 19    LDA $1915,x[$7E:1915]  ;\
$88:EB41 C9 40       CMP #$40               ;|
$88:EB43 F0 04       BEQ $04    [$EB49]     ;} (HDMA object green colour component) = max(0, (HDMA object green colour component) - 1)
$88:EB45 3A          DEC A                  ;|
$88:EB46 9D 15 19    STA $1915,x[$7E:1915]  ;/

$88:EB49 BD 20 19    LDA $1920,x[$7E:1920]  ;\
$88:EB4C C9 80       CMP #$80               ;|
$88:EB4E F0 04       BEQ $04    [$EB54]     ;} (HDMA object blue colour component) = max(0, (HDMA object blue colour component) - 1)
$88:EB50 3A          DEC A                  ;|
$88:EB51 9D 20 19    STA $1920,x            ;/

$88:EB54 C2 20       REP #$20

$88:EB56 28          PLP
$88:EB57 6B          RTL
}
}


;;; $EB58..EBEF: Title sequence gradient ;;;
{
;;; $EB58: Spawn title sequence gradient HDMA objects ;;;
{
$88:EB58 08          PHP
$88:EB59 8B          PHB
$88:EB5A 4B          PHK                    ;\
$88:EB5B AB          PLB                    ;} DB = $88
$88:EB5C C2 30       REP #$30
$88:EB5E DA          PHX
$88:EB5F 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:EB63             dx 00, 32, EB73        ;} Spawn HDMA object for colour math subscreen backdrop colour with instruction list $EB73
$88:EB67 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:EB6B             dx 00, 31, EB85        ;} Spawn HDMA object for colour math control register B with instruction list $EB85
$88:EB6F FA          PLX
$88:EB70 AB          PLB
$88:EB71 28          PLP
$88:EB72 6B          RTL
}


;;; $EB73: Instruction list - colour math subscreen backdrop colour - title sequence gradient ;;;
{
$88:EB73             dx 8655,7E,    ; HDMA table bank = $7E
                        EB9F,       ; Set up title sequence gradient HDMA table
                        8570,88EBB0,; Pre-instruction = $88:EBB0
                        0001,9800,
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $EB85: Instruction list - colour math control register B - title sequence gradient ;;;
{
$88:EB85             dx 8655,88,    ; HDMA table bank = $88
                        8570,88EBD2,; Pre-instruction = $88:EBD2
                        0001,EB95,
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $EB95: HDMA table - colour math control register B - title sequence gradient ;;;
{
$88:EB95             db 40,A1, ;\
                        3A,A1, ;} Enable subtractive colour math on BG1/backdrop
                        40,31, ;\
                        40,31, ;} Enable colour math on BG1/sprites/backdrop
                        00,00
}


;;; $EB9F: Instruction - set up title sequence gradient HDMA table ;;;
{
$88:EB9F 08          PHP
$88:EBA0 E2 20       SEP #$20
$88:EBA2 C2 10       REP #$10
$88:EBA4 DA          PHX
$88:EBA5 5A          PHY
$88:EBA6 64 6F       STZ $6F    [$7E:006F]  ; Colour math control register A = 0
$88:EBA8 22 0A A0 8B JSL $8BA00A[$8B:A00A]  ; Configure title sequence gradient HDMA table
$88:EBAC 7A          PLY
$88:EBAD FA          PLX
$88:EBAE 28          PLP
$88:EBAF 60          RTS
}


;;; $EBB0: Pre-instruction - colour math subscreen backdrop colour - title sequence gradient ;;;
{
$88:EBB0 08          PHP
$88:EBB1 C2 30       REP #$30
$88:EBB3 22 0A A0 8B JSL $8BA00A[$8B:A00A]  ; Configure title sequence gradient HDMA table
$88:EBB7 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$88:EBBA C9 68 9B    CMP #$9B68             ;} If [cinematic function] = $9B68 (load title sequence):
$88:EBBD D0 11       BNE $11    [$EBD0]     ;/
$88:EBBF AE B2 18    LDX $18B2  [$7E:18B2]  ;\
$88:EBC2 BD CC 18    LDA $18CC,x[$7E:18CC]  ;|
$88:EBC5 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:EBC6 1A          INC A                  ;|
$88:EBC7 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:EBCA A9 01 00    LDA #$0001             ;\
$88:EBCD 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1

$88:EBD0 28          PLP
$88:EBD1 6B          RTL
}


;;; $EBD2: Pre-instruction - colour math control register B - title sequence gradient ;;;
{
$88:EBD2 08          PHP
$88:EBD3 C2 30       REP #$30
$88:EBD5 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$88:EBD8 C9 68 9B    CMP #$9B68             ;} If [cinematic function] = $9B68 (load title sequence):
$88:EBDB D0 11       BNE $11    [$EBEE]     ;/
$88:EBDD AE B2 18    LDX $18B2  [$7E:18B2]  ;\
$88:EBE0 BD CC 18    LDA $18CC,x[$7E:18CE]  ;|
$88:EBE3 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:EBE4 1A          INC A                  ;|
$88:EBE5 9D CC 18    STA $18CC,x[$7E:18CE]  ;/
$88:EBE8 A9 01 00    LDA #$0001             ;\
$88:EBEB 9D E4 18    STA $18E4,x[$7E:18E6]  ;} HDMA object instruction timer = 1

$88:EBEE 28          PLP
$88:EBEF 6B          RTL
}
}


;;; $EBF0..EC3A: Intro cutscene cross-fade ;;;
{
;;; $EBF0: Spawn intro cutscene cross-fade HDMA object ;;;
{
$88:EBF0 08          PHP
$88:EBF1 8B          PHB
$88:EBF2 4B          PHK                    ;\
$88:EBF3 AB          PLB                    ;} DB = $88
$88:EBF4 C2 30       REP #$30
$88:EBF6 DA          PHX
$88:EBF7 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:EBFB             dx 00, 31, EC03        ;} Spawn HDMA object for colour math control register B with instruction list $EC03
$88:EBFF FA          PLX
$88:EC00 AB          PLB
$88:EC01 28          PLP
$88:EC02 6B          RTL
}


;;; $EC03: Instruction list - intro cutscene cross-fade ;;;
{
$88:EC03             dx 8655,88,    ; HDMA table bank = $88
                        8570,88EC1D,; Pre-instruction = $88:EC1D
                        0001,EC13,
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $EC13: HDMA table - intro cutscene cross-fade colour math control register B ;;;
{
$88:EC13             db 17,02, ; Enable colour math on BG2
                        60,06, ; Enable colour math on BG2/BG3
                        40,06, ; Enable colour math on BG2/BG3
                        48,02, ; Enable colour math on BG2
                        00,00
}


;;; $EC1D: Pre-instruction - intro cutscene cross-fade ;;;
{
$88:EC1D 08          PHP
$88:EC1E C2 30       REP #$30
$88:EC20 AD 4B 1A    LDA $1A4B  [$7E:1A4B]  ;\
$88:EC23 C9 01 00    CMP #$0001             ;} If [intro cross-fade timer] = 1:
$88:EC26 D0 11       BNE $11    [$EC39]     ;/
$88:EC28 AE B2 18    LDX $18B2  [$7E:18B2]
$88:EC2B BD CC 18    LDA $18CC,x[$7E:18CC]  ;\
$88:EC2E 1A          INC A                  ;|
$88:EC2F 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:EC30 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:EC33 A9 01 00    LDA #$0001             ;\
$88:EC36 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1

$88:EC39 28          PLP
$88:EC3A 6B          RTL
}
}


;;; $EC3B..EE31: Wavy Samus ;;;
{
;;; $EC3B: Spawn wavy Samus HDMA object ;;;
{
; Almost identical to doubled wavelength wavy Phantoon
$88:EC3B 08          PHP
$88:EC3C 8B          PHB
$88:EC3D 4B          PHK                    ;\
$88:EC3E AB          PLB                    ;} DB = $88
$88:EC3F C2 30       REP #$30
$88:EC41 DA          PHX
$88:EC42 A9 01 00    LDA #$0001             ;\
$88:EC45 8D 9C 0D    STA $0D9C  [$7E:0D9C]  ;} Enable wavy Samus
$88:EC48 A9 00 40    LDA #$4000             ;\
$88:EC4B 8D 9E 0D    STA $0D9E  [$7E:0D9E]  ;} Wavy Samus amplitude = 4000h
$88:EC4E A9 08 00    LDA #$0008             ;\
$88:EC51 8D A0 0D    STA $0DA0  [$7E:0DA0]  ;} Wavy Samus phase delta = 8
$88:EC54 A9 C0 00    LDA #$00C0             ;\
$88:EC57 8D 82 0D    STA $0D82  [$7E:0D82]  ;|
$88:EC5A 8D 85 0D    STA $0D85  [$7E:0D85]  ;|
$88:EC5D 8D 88 0D    STA $0D88  [$7E:0D88]  ;|
$88:EC60 8D 8B 0D    STA $0D8B  [$7E:0D8B]  ;|
$88:EC63 A9 00 98    LDA #$9800             ;|
$88:EC66 8D 83 0D    STA $0D83  [$7E:0D83]  ;|
$88:EC69 A9 80 98    LDA #$9880             ;} $0D82..8F = C0h,$9800, C0h,$9880, C0h,$9800, C0h,$9880, 0,0
$88:EC6C 8D 86 0D    STA $0D86  [$7E:0D86]  ;|
$88:EC6F A9 00 98    LDA #$9800             ;|
$88:EC72 8D 89 0D    STA $0D89  [$7E:0D89]  ;|
$88:EC75 A9 80 98    LDA #$9880             ;|
$88:EC78 8D 8C 0D    STA $0D8C  [$7E:0D8C]  ;|
$88:EC7B 9C 8E 0D    STZ $0D8E  [$7E:0D8E]  ;/
$88:EC7E 22 35 84 88 JSL $888435[$88:8435]  ;\
$88:EC82             dx 42, 11, EC8A        ;} Spawn indirect HDMA object for BG3 X scroll with instruction list $EC8A
$88:EC86 FA          PLX
$88:EC87 AB          PLB
$88:EC88 28          PLP
$88:EC89 6B          RTL
}


;;; $EC8A: Instruction list - wavy Samus ;;;
{
$88:EC8A             dx 866A,7E,    ; Indirect HDMA data bank = $7E
                        8655,00,    ; HDMA table bank = $00
                        EC9F,       ; Set up wavy Samus
                        8570,88ECB6,; Pre-instruction = $88:ECB6
                        0001,0D82,
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $EC9F: Instruction - set up wavy Samus ;;;
{
$88:EC9F 08          PHP
$88:ECA0 C2 30       REP #$30
$88:ECA2 A9 FE FF    LDA #$FFFE             ;\
$88:ECA5 9D 14 19    STA $1914,x[$7E:1914]  ;} HDMA object wave phase = FFFEh
$88:ECA8 A9 01 00    LDA #$0001             ;\
$88:ECAB 9D 20 19    STA $1920,x[$7E:1920]  ;} HDMA object phase increase timer = 1
$88:ECAE 9E 2C 19    STZ $192C,x[$7E:192C]  ; HDMA object $192C = 0 (unused)
$88:ECB1 9E 38 19    STZ $1938,x[$7E:1938]  ; HDMA object $1938 = 0 (unused)
$88:ECB4 28          PLP
$88:ECB5 60          RTS
}


;;; $ECB6: Pre-instruction - wavy Samus ;;;
{
$88:ECB6 08          PHP
$88:ECB7 C2 30       REP #$30
$88:ECB9 AD 9C 0D    LDA $0D9C  [$7E:0D9C]  ;\
$88:ECBC D0 13       BNE $13    [$ECD1]     ;} If wavy Samus is disabled:
$88:ECBE AE B2 18    LDX $18B2  [$7E:18B2]
$88:ECC1 BD CC 18    LDA $18CC,x[$7E:18CC]  ;\
$88:ECC4 1A          INC A                  ;|
$88:ECC5 1A          INC A                  ;} HDMA object instruction list pointer += 2
$88:ECC6 9D CC 18    STA $18CC,x[$7E:18CC]  ;/
$88:ECC9 A9 01 00    LDA #$0001             ;\
$88:ECCC 9D E4 18    STA $18E4,x[$7E:18E4]  ;} HDMA object instruction timer = 1
$88:ECCF 28          PLP
$88:ECD0 6B          RTL                    ; Return

$88:ECD1 A9 04 00    LDA #$0004             ;\
$88:ECD4 85 1C       STA $1C    [$7E:001C]  ;} $1C = 4
$88:ECD6 A9 80 00    LDA #$0080             ;\
$88:ECD9 85 1E       STA $1E    [$7E:001E]  ;} $1E = 80h
$88:ECDB DA          PHX
$88:ECDC AD A0 0D    LDA $0DA0  [$7E:0DA0]  ;\
$88:ECDF 0A          ASL A                  ;|
$88:ECE0 85 12       STA $12    [$7E:0012]  ;|
$88:ECE2 BD 14 19    LDA $1914,x[$7E:1914]  ;|
$88:ECE5 18          CLC                    ;} HDMA object wave phase += [wavy Samus phase delta] * 2
$88:ECE6 65 12       ADC $12    [$7E:0012]  ;|
$88:ECE8 29 FF 01    AND #$01FF             ;|
$88:ECEB 9D 14 19    STA $1914,x[$7E:1914]  ;/
$88:ECEE BD 14 19    LDA $1914,x[$7E:1914]  ; >_<;
$88:ECF1 85 14       STA $14    [$7E:0014]  ; $14 = [HDMA object wave phase]
$88:ECF3 A2 00 00    LDX #$0000             ; X = 0

; LOOP
$88:ECF6 DA          PHX
$88:ECF7 A6 14       LDX $14    [$7E:0014]  ;\
$88:ECF9 BF 43 B4 A0 LDA $A0B443,x[$A0:B451];} If [$14] / 2 <= 80h:
$88:ECFD 10 03       BPL $03    [$ED02]     ;/
$88:ECFF 4C 89 ED    JMP $ED89  [$88:ED89]  ; Go to BRANCH_NEGATIVE

$88:ED02 85 12       STA $12    [$7E:0012]  ; $12 = sin([$14] / 2 * pi / 80h) * 100h
$88:ED04 E2 20       SEP #$20               ;\
$88:ED06 8D 02 42    STA $4202              ;|
$88:ED09 AD 9E 0D    LDA $0D9E  [$7E:0D9E]  ;|
$88:ED0C 8D 03 42    STA $4203              ;|
$88:ED0F EA          NOP                    ;|
$88:ED10 EA          NOP                    ;} A = [wavy Samus amplitude low] * [$12 low] / 100h
$88:ED11 EA          NOP                    ;|
$88:ED12 C2 20       REP #$20               ;|
$88:ED14 AD 16 42    LDA $4216              ;|
$88:ED17 EB          XBA                    ;|
$88:ED18 29 FF 00    AND #$00FF             ;/
$88:ED1B 85 16       STA $16    [$7E:0016]  ;\
$88:ED1D E2 20       SEP #$20               ;|
$88:ED1F A5 13       LDA $13    [$7E:0013]  ;|
$88:ED21 8D 02 42    STA $4202              ;|
$88:ED24 AD 9E 0D    LDA $0D9E  [$7E:0D9E]  ;|
$88:ED27 8D 03 42    STA $4203              ;|
$88:ED2A EA          NOP                    ;} A += [wavy Samus amplitude low] * [$12 high]
$88:ED2B EA          NOP                    ;|
$88:ED2C EA          NOP                    ;|
$88:ED2D C2 20       REP #$20               ;|
$88:ED2F AD 16 42    LDA $4216              ;|
$88:ED32 18          CLC                    ;|
$88:ED33 65 16       ADC $16    [$7E:0016]  ;/
$88:ED35 85 16       STA $16    [$7E:0016]  ;\
$88:ED37 E2 20       SEP #$20               ;|
$88:ED39 A5 12       LDA $12    [$7E:0012]  ;|
$88:ED3B 8D 02 42    STA $4202              ;|
$88:ED3E AD 9F 0D    LDA $0D9F  [$7E:0D9F]  ;|
$88:ED41 8D 03 42    STA $4203              ;|
$88:ED44 EA          NOP                    ;|
$88:ED45 EA          NOP                    ;|
$88:ED46 EA          NOP                    ;|
$88:ED47 C2 20       REP #$20               ;|
$88:ED49 AD 16 42    LDA $4216              ;} A += [wavy Samus amplitude high] * [$12 low]
$88:ED4C 85 18       STA $18    [$7E:0018]  ;|
$88:ED4E E2 20       SEP #$20               ;|
$88:ED50 A5 13       LDA $13    [$7E:0013]  ;|
$88:ED52 8D 02 42    STA $4202              ;|
$88:ED55 AD 9F 0D    LDA $0D9F  [$7E:0D9F]  ;|
$88:ED58 8D 03 42    STA $4203              ;|
$88:ED5B C2 20       REP #$20               ;|
$88:ED5D A5 16       LDA $16    [$7E:0016]  ;|
$88:ED5F 18          CLC                    ;|
$88:ED60 65 18       ADC $18    [$7E:0018]  ;/
$88:ED62 85 16       STA $16    [$7E:0016]  ;\
$88:ED64 AD 15 42    LDA $4215              ;|
$88:ED67 29 00 FF    AND #$FF00             ;} A += [wavy Samus amplitude high] * [$12 high] * 100h (whoops, carry isn't being propagated)
$88:ED6A 18          CLC                    ;|
$88:ED6B 65 16       ADC $16    [$7E:0016]  ;/
$88:ED6D 29 00 FF    AND #$FF00             ;\
$88:ED70 EB          XBA                    ;} $12 = [A] / 100h
$88:ED71 85 12       STA $12    [$7E:0012]  ;/
$88:ED73 8A          TXA                    ;\
$88:ED74 18          CLC                    ;} $14 += 4
$88:ED75 65 1C       ADC $1C    [$7E:001C]  ;/
$88:ED77 29 FF 01    AND #$01FF             ;\
$88:ED7A 85 14       STA $14    [$7E:0014]  ;} $14 %= 200h
$88:ED7C FA          PLX
$88:ED7D A5 B9       LDA $B9    [$7E:00B9]  ;\
$88:ED7F 18          CLC                    ;|
$88:ED80 65 12       ADC $12    [$7E:0012]  ;} $7E:9800 + [X] = [BG3 X scroll] + [$12]
$88:ED82 9F 00 98 7E STA $7E9800,x[$7E:9800];/
$88:ED86 4C 11 EE    JMP $EE11  [$88:EE11]  ; Go to BRANCH_NEXT

; BRANCH_NEGATIVE
$88:ED89 49 FF FF    EOR #$FFFF             ;\
$88:ED8C 1A          INC A                  ;} $12 = -sin([$14] / 2 * pi / 80h) * 100h
$88:ED8D 85 12       STA $12    [$7E:0012]  ;/
$88:ED8F E2 20       SEP #$20               ;\
$88:ED91 8D 02 42    STA $4202              ;|
$88:ED94 AD 9E 0D    LDA $0D9E  [$7E:0D9E]  ;|
$88:ED97 8D 03 42    STA $4203              ;|
$88:ED9A EA          NOP                    ;|
$88:ED9B EA          NOP                    ;|
$88:ED9C EA          NOP                    ;|
$88:ED9D C2 20       REP #$20               ;|
$88:ED9F AD 16 42    LDA $4216              ;|
$88:EDA2 EB          XBA                    ;|
$88:EDA3 29 FF 00    AND #$00FF             ;|
$88:EDA6 85 16       STA $16    [$7E:0016]  ;|
$88:EDA8 E2 20       SEP #$20               ;|
$88:EDAA A5 13       LDA $13    [$7E:0013]  ;|
$88:EDAC 8D 02 42    STA $4202              ;|
$88:EDAF AD 9E 0D    LDA $0D9E  [$7E:0D9E]  ;|
$88:EDB2 8D 03 42    STA $4203              ;|
$88:EDB5 EA          NOP                    ;|
$88:EDB6 EA          NOP                    ;|
$88:EDB7 EA          NOP                    ;|
$88:EDB8 C2 20       REP #$20               ;|
$88:EDBA AD 16 42    LDA $4216              ;|
$88:EDBD 18          CLC                    ;|
$88:EDBE 65 16       ADC $16    [$7E:0016]  ;|
$88:EDC0 85 16       STA $16    [$7E:0016]  ;|
$88:EDC2 E2 20       SEP #$20               ;|
$88:EDC4 A5 12       LDA $12    [$7E:0012]  ;} Same as above: $12 = [wavy Samus amplitude] * [$12] / 10000h (possibly off-by-1)
$88:EDC6 8D 02 42    STA $4202              ;|
$88:EDC9 AD 9F 0D    LDA $0D9F  [$7E:0D9F]  ;|
$88:EDCC 8D 03 42    STA $4203              ;|
$88:EDCF EA          NOP                    ;|
$88:EDD0 EA          NOP                    ;|
$88:EDD1 EA          NOP                    ;|
$88:EDD2 C2 20       REP #$20               ;|
$88:EDD4 AD 16 42    LDA $4216              ;|
$88:EDD7 85 18       STA $18    [$7E:0018]  ;|
$88:EDD9 E2 20       SEP #$20               ;|
$88:EDDB A5 13       LDA $13    [$7E:0013]  ;|
$88:EDDD 8D 02 42    STA $4202              ;|
$88:EDE0 AD 9F 0D    LDA $0D9F  [$7E:0D9F]  ;|
$88:EDE3 8D 03 42    STA $4203              ;|
$88:EDE6 C2 20       REP #$20               ;|
$88:EDE8 A5 16       LDA $16    [$7E:0016]  ;|
$88:EDEA 18          CLC                    ;|
$88:EDEB 65 18       ADC $18    [$7E:0018]  ;|
$88:EDED 85 16       STA $16    [$7E:0016]  ;|
$88:EDEF AD 15 42    LDA $4215              ;|
$88:EDF2 29 00 FF    AND #$FF00             ;|
$88:EDF5 18          CLC                    ;|
$88:EDF6 65 16       ADC $16    [$7E:0016]  ;|
$88:EDF8 29 00 FF    AND #$FF00             ;|
$88:EDFB EB          XBA                    ;|
$88:EDFC 85 12       STA $12    [$7E:0012]  ;/
$88:EDFE 8A          TXA                    ;\
$88:EDFF 18          CLC                    ;} $14 += 4
$88:EE00 65 1C       ADC $1C    [$7E:001C]  ;/
$88:EE02 29 FF 01    AND #$01FF             ;\
$88:EE05 85 14       STA $14    [$7E:0014]  ;} $14 %= 200h
$88:EE07 FA          PLX
$88:EE08 A5 B9       LDA $B9    [$7E:00B9]  ;\
$88:EE0A 38          SEC                    ;|
$88:EE0B E5 12       SBC $12    [$7E:0012]  ;} $7E:9800 + [X] = [BG3 X scroll] - [$12]
$88:EE0D 9F 00 98 7E STA $7E9800,x[$7E:987A];/

; BRANCH_NEXT
$88:EE11 E8          INX                    ;\
$88:EE12 E8          INX                    ;} X += 2
$88:EE13 E4 1E       CPX $1E    [$7E:001E]  ;\
$88:EE15 10 03       BPL $03    [$EE1A]     ;} If [X] < 80h:
$88:EE17 4C F6 EC    JMP $ECF6  [$88:ECF6]  ; Go to LOOP

$88:EE1A A2 7E 00    LDX #$007E             ;\
                                            ;|
$88:EE1D A5 B9       LDA $B9    [$7E:00B9]  ;|
$88:EE1F 38          SEC                    ;|
$88:EE20 FF 00 98 7E SBC $7E9800,x[$7E:987E];|
$88:EE24 18          CLC                    ;} $7E:9880..FF = [BG3 X scroll] - ([$7E:9800..7F] - [BG3 X scroll])
$88:EE25 65 B9       ADC $B9    [$7E:00B9]  ;|
$88:EE27 9F 80 98 7E STA $7E9880,x[$7E:98FE];|
$88:EE2B CA          DEX                    ;|
$88:EE2C CA          DEX                    ;|
$88:EE2D 10 EE       BPL $EE    [$EE1D]     ;/
$88:EE2F FA          PLX
$88:EE30 28          PLP
$88:EE31 6B          RTL
}
}


;;; $EE32: Free space ;;;
{
$88:EE32             fillto $898000, $FF
}
