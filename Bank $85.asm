;;; $8000: Large message box top/bottom border tilemap ;;;
{
$85:8000             dw 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 280F, 284E, 284E, 000E, 000E, 000E
}


;;; $8040: Small message box top/bottom border tilemap ;;;
{
$85:8040             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E
}


;;; $8080: Message box routine ;;;
{
;; Parameter:
;;     A: Message index
;;         1: Energy tank
;;         2: Missile
;;         3: Super missile
;;         4: Power bomb
;;         5: Grappling beam
;;         6: X-ray scope
;;         7: Varia suit
;;         8: Spring ball
;;         9: Morphing ball
;;         Ah: Screw attack
;;         Bh: Hi-jump boots
;;         Ch: Space jump
;;         Dh: Speed booster
;;         Eh: Charge beam
;;         Fh: Ice beam
;;         10h: Wave beam
;;         11h: Spazer
;;         12h: Plasma beam
;;         13h: Bomb
;;         14h: Map data access completed
;;         15h: Energy recharge completed
;;         16h: Missile reload completed
;;         17h: Would you like to save?
;;         18h: Save completed
;;         19h: Reserve tank
;;         1Ah: Gravity suit
;;         1Ch: Would you like to save? (Used by gunship)
;; Returns:
;;     A: If save confirmation, returns [save confirmation selection] (0: yes, 2: no)

; This routine does not return until the message box has disappeared (~6 seconds)
; This is the only routine in this bank that's externally callable
$85:8080 08          PHP
$85:8081 8B          PHB
$85:8082 DA          PHX
$85:8083 5A          PHY
$85:8084 4B          PHK                    ;\
$85:8085 AB          PLB                    ;} DB = $85
$85:8086 8D 1F 1C    STA $1C1F  [$7E:1C1F]  ; Message box index = [A]
$85:8089 22 17 BE 82 JSL $82BE17[$82:BE17]  ; Cancel sound effects
$85:808D 20 43 81    JSR $8143  [$85:8143]  ; Initialise PPU for message boxes
$85:8090 20 F3 81    JSR $81F3  [$85:81F3]  ; Clear message box BG3 tilemap
$85:8093 20 41 82    JSR $8241  [$85:8241]  ; Initialise message box
$85:8096 20 74 85    JSR $8574  [$85:8574]  ; Play 2 lag frames of music and sound effects
$85:8099 20 4C 84    JSR $844C  [$85:844C]  ; Open message box
$85:809C AD 1F 1C    LDA $1C1F  [$7E:1C1F]  ;\
$85:809F C9 1C 00    CMP #$001C             ;} If [message box index] = gunship save confirmation: go to BRANCH_GUNSHIP
$85:80A2 F0 1B       BEQ $1B    [$80BF]     ;/
$85:80A4 20 6D 84    JSR $846D  [$85:846D]  ; Handle message box interaction
$85:80A7 20 89 85    JSR $8589  [$85:8589]  ; Close message box
$85:80AA 20 F3 81    JSR $81F3  [$85:81F3]  ; Clear message box BG3 tilemap
$85:80AD 20 1A 86    JSR $861A  [$85:861A]  ; Restore PPU
$85:80B0 22 2F BE 82 JSL $82BE2F[$82:BE2F]  ; Queue Samus movement sound effects
$85:80B4 20 74 85    JSR $8574  [$85:8574]  ; Play 2 lag frames of music and sound effects
$85:80B7 20 FA 80    JSR $80FA  [$85:80FA]  ; Maybe trigger pause screen or return save confirmation selection

$85:80BA 7A          PLY
$85:80BB FA          PLX
$85:80BC AB          PLB
$85:80BD 28          PLP
$85:80BE 6B          RTL                    ; Return

; BRANCH_GUNSHIP
$85:80BF 20 6D 84    JSR $846D  [$85:846D]  ; Handle message box interaction
$85:80C2 20 89 85    JSR $8589  [$85:8589]  ; Close message box
$85:80C5 AD F9 05    LDA $05F9  [$7E:05F9]  ;\
$85:80C8 C9 02 00    CMP #$0002             ;} If [save confirmation selection] = yes:
$85:80CB F0 1B       BEQ $1B    [$80E8]     ;/
$85:80CD A9 18 00    LDA #$0018             ;\
$85:80D0 8D 1F 1C    STA $1C1F  [$7E:1C1F]  ;} Message box index = save completed
$85:80D3 20 F3 81    JSR $81F3  [$85:81F3]  ; Clear message box BG3 tilemap
$85:80D6 20 19 81    JSR $8119  [$85:8119]  ; Play saving sound effect
$85:80D9 20 41 82    JSR $8241  [$85:8241]  ; Initialise message box
$85:80DC 20 74 85    JSR $8574  [$85:8574]  ; Play 2 lag frames of music and sound effects
$85:80DF 20 4C 84    JSR $844C  [$85:844C]  ; Open message box
$85:80E2 20 6D 84    JSR $846D  [$85:846D]  ; Handle message box interaction
$85:80E5 20 89 85    JSR $8589  [$85:8589]  ; Close message box

$85:80E8 20 F3 81    JSR $81F3  [$85:81F3]  ; Clear message box BG3 tilemap
$85:80EB 20 1A 86    JSR $861A  [$85:861A]  ; Restore PPU
$85:80EE 22 2F BE 82 JSL $82BE2F[$82:BE2F]  ; Queue Samus movement sound effects
$85:80F2 20 74 85    JSR $8574  [$85:8574]  ; Play 2 lag frames of music and sound effects
$85:80F5 20 FA 80    JSR $80FA  [$85:80FA]  ; Maybe trigger pause screen or return save confirmation selection
$85:80F8 80 C0       BRA $C0    [$80BA]     ; Return
}


;;; $80FA: Maybe trigger pause screen or return save confirmation selection ;;;
{
$85:80FA C2 30       REP #$30
$85:80FC AD 1F 1C    LDA $1C1F  [$7E:1C1F]  ;\
$85:80FF C9 14 00    CMP #$0014             ;} If [message box index] = map data access completed:
$85:8102 D0 07       BNE $07    [$810B]     ;/
$85:8104 A9 0C 00    LDA #$000C             ;\
$85:8107 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = Ch (pausing, normal gameplay but darkening)
$85:810A 60          RTS                    ; Return

$85:810B C9 1C 00    CMP #$001C             ;\
$85:810E F0 05       BEQ $05    [$8115]     ;} If [message box index] != gunship save confirmation:
$85:8110 C9 17 00    CMP #$0017             ;\
$85:8113 D0 03       BNE $03    [$8118]     ;} If [message box index] != save confirmation: return

$85:8115 AD F9 05    LDA $05F9  [$7E:05F9]  ; A = [save confirmation selection]

$85:8118 60          RTS
}


;;; $8119: Play saving sound effect ;;;
{
$85:8119 C2 30       REP #$30
$85:811B A9 2E 00    LDA #$002E             ;\
$85:811E 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 2Eh, sound library 1, max queued sounds allowed = 6 (saving)
$85:8122 A9 A0 00    LDA #$00A0             ; A = A0h

; LOOP
$85:8125 48          PHA
$85:8126 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$85:812A 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$85:812E 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:8131 68          PLA
$85:8132 3A          DEC A                  ; Decrement A
$85:8133 D0 F0       BNE $F0    [$8125]     ; If [A] != 0: go to LOOP
$85:8135 60          RTS
}


;;; $8136: Wait for lag frame ;;;
{
$85:8136 08          PHP
$85:8137 E2 20       SEP #$20
$85:8139 AD B8 05    LDA $05B8  [$7E:05B8]

$85:813C CD B8 05    CMP $05B8  [$7E:05B8]
$85:813F F0 FB       BEQ $FB    [$813C]
$85:8141 28          PLP
$85:8142 60          RTS
}


;;; $8143: Initialise PPU for message boxes ;;;
{
$85:8143 C2 20       REP #$20
$85:8145 9C F9 05    STZ $05F9  [$7E:05F9]  ; Save confirmation selection = Yes
$85:8148 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:814B E2 20       SEP #$20
$85:814D 9C 0C 42    STZ $420C  [$7E:420C]  ; Clear HDMA enable flags
$85:8150 A9 19       LDA #$19               ;\
$85:8152 8D 21 21    STA $2121  [$7E:2121]  ;|
$85:8155 A9 B1       LDA #$B1               ;|
$85:8157 8D 22 21    STA $2122  [$7E:2122]  ;} CGRAM BG3 palette 6 colour 1 = 0BB1h (green for Y button)
$85:815A A9 0B       LDA #$0B               ;| 
$85:815C 8D 22 21    STA $2122  [$7E:2122]  ;/
$85:815F A9 1F       LDA #$1F               ;\
$85:8161 8D 22 21    STA $2122  [$7E:2122]  ;|
$85:8164 A9 00       LDA #$00               ;} CGRAM BG3 palette 6 colour 2 = 001Fh (red for save dialog option select arrow)
$85:8166 8D 22 21    STA $2122  [$7E:2122]  ;/
$85:8169 A5 85       LDA $85    [$7E:0085]  ;\
$85:816B 8F EA 33 7E STA $7E33EA[$7E:33EA]  ;} $7E:33EA = [HDMA channels to enable]
$85:816F A5 5B       LDA $5B    [$7E:005B]  ;\
$85:8171 8F EB 33 7E STA $7E33EB[$7E:33EB]  ;} $7E:33EB = [BG3 tilemap base address and size]
$85:8175 A9 58       LDA #$58               ;\
$85:8177 85 5B       STA $5B    [$7E:005B]  ;} BG3 tilemap base address = $5800, size = 32x32
$85:8179 A9 17       LDA #$17               ;\
$85:817B 85 6A       STA $6A    [$7E:006A]  ;} Gameplay main screen layers = BG1/BG2/BG3/sprites
$85:817D 64 70       STZ $70    [$7E:0070]  ; Gameplay colour math control register A = 0
$85:817F 64 73       STZ $73    [$7E:0073]  ; Gameplay colour math control register B = 0
$85:8181 A9 20       LDA #$20               ;\
$85:8183 8D 32 21    STA $2132  [$7E:2132]  ;|
$85:8186 A9 40       LDA #$40               ;|
$85:8188 8D 32 21    STA $2132  [$7E:2132]  ;} Colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$85:818B A9 80       LDA #$80               ;|
$85:818D 8D 32 21    STA $2132  [$7E:2132]  ;/
$85:8190 AD 11 21    LDA $2111  [$7E:2111]  ; Okay? We'll just read this write-only register for no reason
$85:8193 9C 11 21    STZ $2111  [$7E:2111]  ;\
$85:8196 9C 11 21    STZ $2111  [$7E:2111]  ;} BG3 X scroll = 0
$85:8199 AD 12 21    LDA $2112  [$7E:2112]  ; >_< !!!
$85:819C 9C 12 21    STZ $2112  [$7E:2112]  ;\
$85:819F 9C 12 21    STZ $2112  [$7E:2112]  ;} BG3 Y scroll = 0
$85:81A2 C2 30       REP #$30
$85:81A4 A2 80 00    LDX #$0080             ;\
$85:81A7 A9 00 00    LDA #$0000             ;|
                                            ;|
$85:81AA 9F 00 30 7E STA $7E3000,x[$7E:3080];} $7E:3000..7F = 0
$85:81AE CA          DEX                    ;|
$85:81AF CA          DEX                    ;|
$85:81B0 10 F8       BPL $F8    [$81AA]     ;/
$85:81B2 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:81B5 C2 20       REP #$20
$85:81B7 A9 80 58    LDA #$5880             ;\
$85:81BA 8D 16 21    STA $2116  [$7E:2116]  ;|
$85:81BD AD 39 21    LDA $2139  [$7E:2139]  ;|
$85:81C0 A9 81 39    LDA #$3981             ;| (8-bit transfer looks wrong, bug?)
$85:81C3 8D 10 43    STA $4310  [$7E:4310]  ;|
$85:81C6 A9 00 41    LDA #$4100             ;|
$85:81C9 8D 12 43    STA $4312  [$7E:4312]  ;|
$85:81CC A9 7E 00    LDA #$007E             ;|
$85:81CF 8D 14 43    STA $4314  [$7E:4314]  ;|
$85:81D2 A9 00 07    LDA #$0700             ;} $7E:4100..47FF = [VRAM $5880..5BFF]
$85:81D5 8D 15 43    STA $4315  [$7E:4315]  ;|
$85:81D8 9C 17 43    STZ $4317  [$7E:4317]  ;|
$85:81DB 9C 19 43    STZ $4319  [$7E:4319]  ;|
$85:81DE E2 20       SEP #$20               ;|
$85:81E0 A9 80       LDA #$80               ;|
$85:81E2 8D 15 21    STA $2115  [$7E:2115]  ;|
$85:81E5 A9 02       LDA #$02               ;|
$85:81E7 8D 0B 42    STA $420B  [$7E:420B]  ;/
$85:81EA 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$85:81EE 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$85:81F2 60          RTS
}


;;; $81F3: Clear message box BG3 tilemap ;;;
{
$85:81F3 C2 30       REP #$30
$85:81F5 A2 FE 06    LDX #$06FE             ;\
$85:81F8 AD 3F 82    LDA $823F  [$85:823F]  ;|
                                            ;|
$85:81FB 9F 00 38 7E STA $7E3800,x[$7E:3EFE];} $7E:3800..3EFF = 000Eh
$85:81FF CA          DEX                    ;|
$85:8200 CA          DEX                    ;|
$85:8201 10 F8       BPL $F8    [$81FB]     ;/
$85:8203 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:8206 A9 80 58    LDA #$5880             ;\
$85:8209 8D 16 21    STA $2116  [$7E:2116]  ;|
$85:820C A9 01 18    LDA #$1801             ;|
$85:820F 8D 10 43    STA $4310  [$7E:4310]  ;|
$85:8212 A9 00 38    LDA #$3800             ;|
$85:8215 8D 12 43    STA $4312  [$7E:4312]  ;|
$85:8218 A9 7E 00    LDA #$007E             ;|
$85:821B 8D 14 43    STA $4314  [$7E:4314]  ;|
$85:821E A9 00 07    LDA #$0700             ;} VRAM $5880..5BFF = [$7E:3800..3EFF]
$85:8221 8D 15 43    STA $4315  [$7E:4315]  ;|
$85:8224 9C 17 43    STZ $4317  [$7E:4317]  ;|
$85:8227 9C 19 43    STZ $4319  [$7E:4319]  ;|
$85:822A E2 20       SEP #$20               ;|
$85:822C A9 80       LDA #$80               ;|
$85:822E 8D 15 21    STA $2115  [$7E:2115]  ;|
$85:8231 A9 02       LDA #$02               ;|
$85:8233 8D 0B 42    STA $420B  [$7E:420B]  ;/
$85:8236 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$85:823A 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$85:823E 60          RTS

$85:823F             dw 000E
}


;;; $8241: Initialise message box ;;;
{
$85:8241 C2 30       REP #$30
$85:8243 AD 1F 1C    LDA $1C1F  [$7E:1C1F]  ;\
$85:8246 3A          DEC A                  ;|
$85:8247 0A          ASL A                  ;|
$85:8248 85 34       STA $34    [$7E:0034]  ;|
$85:824A 0A          ASL A                  ;} X = ([message box index] - 1) * 6
$85:824B 18          CLC                    ;|
$85:824C 65 34       ADC $34    [$7E:0034]  ;|
$85:824E AA          TAX                    ;/
$85:824F DA          PHX
$85:8250 FC 9D 86    JSR ($869D,x)[$85:8289]; Execute [$869B + [X] + 2] (write message box tilemap)
$85:8253 FA          PLX
$85:8254 FC 9B 86    JSR ($869B,x)[$85:8436]; Execute [$869B + [X]] (possibly modify message box and set up PPU)
$85:8257 60          RTS
}


;;; $8258: Unused REP instruction ;;;
{
$85:8258 C2 30       REP #$30
}


;;; $825A: Write large message box tilemap ;;;
{
$85:825A A2 00 00    LDX #$0000             ;\
                                            ;|
$85:825D BD 00 80    LDA $8000,x[$85:8000]  ;|
$85:8260 9F 00 32 7E STA $7E3200,x[$7E:3200];|
$85:8264 E8          INX                    ;} $7E:3200..3F = [$8000..3F]
$85:8265 E8          INX                    ;|
$85:8266 E0 40 00    CPX #$0040             ;|
$85:8269 D0 F2       BNE $F2    [$825D]     ;/
$85:826B A0 00 00    LDY #$0000             ; >_<
$85:826E 20 B8 82    JSR $82B8  [$85:82B8]  ; Write message tilemap
$85:8271 A9 20 00    LDA #$0020             ;\
$85:8274 85 16       STA $16    [$7E:0016]  ;|
$85:8276 A0 00 00    LDY #$0000             ;|
                                            ;|
$85:8279 B9 00 80    LDA $8000,y[$85:8000]  ;|
$85:827C 9F 00 32 7E STA $7E3200,x[$7E:3340];|
$85:8280 C8          INY                    ;} Copy 20h bytes from $8000 + [X] to $7E:3200 + [X]
$85:8281 C8          INY                    ;|
$85:8282 E8          INX                    ;|
$85:8283 E8          INX                    ;|
$85:8284 C6 16       DEC $16    [$7E:0016]  ;|
$85:8286 D0 F1       BNE $F1    [$8279]     ;/
$85:8288 60          RTS
}


;;; $8289: Write small message box tilemap ;;;
{
$85:8289 A0 00 00    LDY #$0000
$85:828C A2 00 00    LDX #$0000             ;\
                                            ;|
$85:828F BD 40 80    LDA $8040,x[$85:8040]  ;|
$85:8292 9F 00 32 7E STA $7E3200,x[$7E:3200];|
$85:8296 E8          INX                    ;} $7E:3200..3F = [$8040..3F]
$85:8297 E8          INX                    ;|
$85:8298 E0 40 00    CPX #$0040             ;|
$85:829B D0 F2       BNE $F2    [$828F]     ;/
$85:829D 20 B8 82    JSR $82B8  [$85:82B8]  ; Write message tilemap
$85:82A0 A9 20 00    LDA #$0020             ;\
$85:82A3 85 16       STA $16    [$7E:0016]  ;|
$85:82A5 A0 00 00    LDY #$0000             ;|
                                            ;|
$85:82A8 B9 40 80    LDA $8040,y[$85:8040]  ;|
$85:82AB 9F 00 32 7E STA $7E3200,x[$7E:3280];|
$85:82AF C8          INY                    ;} Copy 20h bytes from $8040 + [X] to $7E:3200 + [X]
$85:82B0 C8          INY                    ;|
$85:82B1 E8          INX                    ;|
$85:82B2 E8          INX                    ;|
$85:82B3 C6 16       DEC $16    [$7E:0016]  ;|
$85:82B5 D0 F1       BNE $F1    [$82A8]     ;/
$85:82B7 60          RTS                    
}


;;; $82B8: Write message tilemap ;;;
{
$85:82B8 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:82BB 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$85:82BF 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$85:82C3 C2 30       REP #$30
$85:82C5 A9 70 00    LDA #$0070             ;\
$85:82C8 8D A6 05    STA $05A6  [$7E:05A6]  ;} $05A6 = 70h
$85:82CB A9 7C 00    LDA #$007C             ;\
$85:82CE 8D A4 05    STA $05A4  [$7E:05A4]  ;} $05A4 = 7Ch
$85:82D1 9C A2 05    STZ $05A2  [$7E:05A2]  ; $05A2 = 0
$85:82D4 A2 00 00    LDX #$0000             ;\
$85:82D7 A9 00 00    LDA #$0000             ;|
                                            ;|
$85:82DA 9F 00 30 7E STA $7E3000,x[$7E:3000];|
$85:82DE E8          INX                    ;} $7E:3000..DF = 0
$85:82DF E8          INX                    ;|
$85:82E0 E0 E0 00    CPX #$00E0             ;|
$85:82E3 D0 F5       BNE $F5    [$82DA]     ;/
$85:82E5 AD 1F 1C    LDA $1C1F  [$7E:1C1F]  ;\
$85:82E8 3A          DEC A                  ;|
$85:82E9 0A          ASL A                  ;|
$85:82EA 85 34       STA $34    [$7E:0034]  ;|
$85:82EC 0A          ASL A                  ;|
$85:82ED 18          CLC                    ;} $00 = [$869B + ([message box index] - 1) * 6 + 4] (message tilemap source)
$85:82EE 65 34       ADC $34    [$7E:0034]  ;|
$85:82F0 AA          TAX                    ;|
$85:82F1 BD 9F 86    LDA $869F,x[$85:86CF]  ;|
$85:82F4 85 00       STA $00    [$7E:0000]  ;/
$85:82F6 BD A5 86    LDA $86A5,x[$85:86D5]  ;\
$85:82F9 38          SEC                    ;|
$85:82FA E5 00       SBC $00    [$7E:0000]  ;} $09 = [$869B + ([message box index] - 1 + 1) * 6 + 4] - [$00] (message tilemap size)
$85:82FC 85 09       STA $09    [$7E:0009]  ;/
$85:82FE 4A          LSR A                  ;\
$85:82FF 85 16       STA $16    [$7E:0016]  ;} $16 = [$09] / 2
$85:8301 A5 09       LDA $09    [$7E:0009]  ;\
$85:8303 18          CLC                    ;|
$85:8304 69 80 00    ADC #$0080             ;} $09 += 80h (message box tilemap size)
$85:8307 85 09       STA $09    [$7E:0009]  ;/
$85:8309 A2 40 00    LDX #$0040             ;\
$85:830C A0 00 00    LDY #$0000             ;|
                                            ;|
$85:830F B1 00       LDA ($00),y[$85:8D3F]  ;|
$85:8311 9F 00 32 7E STA $7E3200,x[$7E:3240];|
$85:8315 E8          INX                    ;} Copy [$16] words from [$00] to $7E:3240
$85:8316 E8          INX                    ;|
$85:8317 C8          INY                    ;|
$85:8318 C8          INY                    ;|
$85:8319 C6 16       DEC $16    [$7E:0016]  ;|
$85:831B D0 F2       BNE $F2    [$830F]     ;/
$85:831D 60          RTS
}


;;; $831E: Set up PPU for active message box ;;;
{
$85:831E 20 63 83    JSR $8363  [$85:8363]  ; Set up message box BG3 Y scroll HDMA
$85:8321 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:8324 C2 20       REP #$20
$85:8326 A9 00 58    LDA #$5800             ;\
$85:8329 18          CLC                    ;|
$85:832A 65 34       ADC $34    [$7E:0034]  ;|
$85:832C 85 34       STA $34    [$7E:0034]  ;|
$85:832E 8D 16 21    STA $2116  [$7E:2116]  ;|
$85:8331 A9 01 18    LDA #$1801             ;|
$85:8334 8D 10 43    STA $4310  [$7E:4310]  ;|
$85:8337 A9 00 32    LDA #$3200             ;|
$85:833A 8D 12 43    STA $4312  [$7E:4312]  ;|
$85:833D A9 7E 00    LDA #$007E             ;} Transfer [$09] bytes from $7E:3200 to VRAM $5800 + [$34]
$85:8340 8D 14 43    STA $4314  [$7E:4314]  ;|
$85:8343 A5 09       LDA $09    [$7E:0009]  ;|
$85:8345 8D 15 43    STA $4315  [$7E:4315]  ;|
$85:8348 9C 17 43    STZ $4317  [$7E:4317]  ;|
$85:834B 9C 19 43    STZ $4319  [$7E:4319]  ;|
$85:834E E2 20       SEP #$20               ;|
$85:8350 A9 80       LDA #$80               ;|
$85:8352 8D 15 21    STA $2115  [$7E:2115]  ;|
$85:8355 A9 02       LDA #$02               ;|
$85:8357 8D 0B 42    STA $420B  [$7E:420B]  ;/
$85:835A 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$85:835E 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$85:8362 60          RTS
}


;;; $8363: Set up message box BG3 Y scroll HDMA ;;;
{
$85:8363 E2 20       SEP #$20
$85:8365 A9 FF       LDA #$FF               ;\
$85:8367 8F 80 33 7E STA $7E3380[$7E:3380]  ;|
$85:836B A9 00       LDA #$00               ;|
$85:836D 8F 81 33 7E STA $7E3381[$7E:3381]  ;|
$85:8371 A9 30       LDA #$30               ;|
$85:8373 8F 82 33 7E STA $7E3382[$7E:3382]  ;|
$85:8377 A9 E1       LDA #$E1               ;|
$85:8379 8F 83 33 7E STA $7E3383[$7E:3383]  ;} $7E:3380..86 = FFh,$3000, E1h,$30FE, 0
$85:837D A9 FE       LDA #$FE               ;|
$85:837F 8F 84 33 7E STA $7E3384[$7E:3384]  ;|
$85:8383 A9 30       LDA #$30               ;|
$85:8385 8F 85 33 7E STA $7E3385[$7E:3385]  ;|
$85:8389 A9 00       LDA #$00               ;|
$85:838B 8F 86 33 7E STA $7E3386[$7E:3386]  ;/
$85:838F A9 42       LDA #$42               ;\
$85:8391 8D 60 43    STA $4360  [$7E:4360]  ;|
$85:8394 A9 12       LDA #$12               ;|
$85:8396 8D 61 43    STA $4361  [$7E:4361]  ;|
$85:8399 A9 80       LDA #$80               ;|
$85:839B 8D 62 43    STA $4362  [$7E:4362]  ;|
$85:839E 8D 65 43    STA $4365  [$7E:4365]  ;|
$85:83A1 A9 33       LDA #$33               ;|
$85:83A3 8D 63 43    STA $4363  [$7E:4363]  ;} Set up indirect HDMA from $7E:3380 to BG3 Y scroll on HDMA channel 6
$85:83A6 8D 66 43    STA $4366  [$7E:4366]  ;|
$85:83A9 A9 7E       LDA #$7E               ;|
$85:83AB 8D 64 43    STA $4364  [$7E:4364]  ;|
$85:83AE 8D 67 43    STA $4367  [$7E:4367]  ;|
$85:83B1 9C 68 43    STZ $4368  [$7E:4368]  ;|
$85:83B4 9C 69 43    STZ $4369  [$7E:4369]  ;|
$85:83B7 9C 6A 43    STZ $436A  [$7E:436A]  ;/
$85:83BA 20 9B 85    JSR $859B  [$85:859B]  ; Write message box BG3 Y scroll HDMA data table
$85:83BD E2 20       SEP #$20
$85:83BF A9 40       LDA #$40               ;\
$85:83C1 8D 0C 42    STA $420C  [$7E:420C]  ;} Enable HDMA channel 6
$85:83C4 60          RTS
}


;;; $83C5: Draw shoot button and set up PPU for large message box ;;;
{
$85:83C5 C2 30       REP #$30
$85:83C7 AD B2 09    LDA $09B2  [$7E:09B2]  ; A = [shoot binding]
$85:83CA 80 05       BRA $05    [$83D1]
}


;;; $83CC: Draw run button and set up PPU for large message box ;;;
{
$85:83CC C2 30       REP #$30
$85:83CE AD B6 09    LDA $09B6  [$7E:09B6]  ; A = [run binding]
}


;;; $83D1: Draw special button and set up PPU for large message box ;;;
{
$85:83D1 A0 00 00    LDY #$0000             ; Y = 0
$85:83D4 89 80 00    BIT #$0080             ;\
$85:83D7 D0 33       BNE $33    [$840C]     ;} If [A] & 80h != 0: go to BRANCH_FOUND
$85:83D9 A0 02 00    LDY #$0002             ; Y = 2
$85:83DC 89 00 80    BIT #$8000             ;\
$85:83DF D0 2B       BNE $2B    [$840C]     ;} If [A] & 8000h != 0: go to BRANCH_FOUND
$85:83E1 A0 04 00    LDY #$0004             ; Y = 4
$85:83E4 89 40 00    BIT #$0040             ;\
$85:83E7 D0 23       BNE $23    [$840C]     ;} If [A] & 40h != 0: go to BRANCH_FOUND
$85:83E9 A0 06 00    LDY #$0006             ; Y = 6
$85:83EC 89 00 40    BIT #$4000             ;\
$85:83EF D0 1B       BNE $1B    [$840C]     ;} If [A] & 4000h != 0: go to BRANCH_FOUND
$85:83F1 A0 08 00    LDY #$0008             ; Y = 8
$85:83F4 89 00 20    BIT #$2000             ;\
$85:83F7 D0 13       BNE $13    [$840C]     ;} If [A] & 2000h != 0: go to BRANCH_FOUND
$85:83F9 A0 0A 00    LDY #$000A             ; Y = Ah
$85:83FC 89 20 00    BIT #$0020             ;\
$85:83FF D0 0B       BNE $0B    [$840C]     ;} If [A] & 20h != 0: go to BRANCH_FOUND
$85:8401 A0 0C 00    LDY #$000C             ; Y = Ch
$85:8404 89 10 00    BIT #$0010             ;\
$85:8407 D0 03       BNE $03    [$840C]     ;} If [A] & 10h != 0: go to BRANCH_FOUND
$85:8409 A0 0E 00    LDY #$000E             ; Y = Eh

; BRANCH_FOUND
$85:840C AD 1F 1C    LDA $1C1F  [$7E:1C1F]  ;\
$85:840F 3A          DEC A                  ;|
$85:8410 0A          ASL A                  ;|
$85:8411 AA          TAX                    ;|
$85:8412 BD 49 87    LDA $8749,x[$85:874B]  ;} $7E:3200 + [$8749 + ([message box index] - 1) * 2] = [$8426 + [Y]]
$85:8415 AA          TAX                    ;|
$85:8416 B9 26 84    LDA $8426,y[$85:842A]  ;|
$85:8419 9F 00 32 7E STA $7E3200,x[$7E:332A];/
$85:841D A9 A0 01    LDA #$01A0             ;\
$85:8420 85 34       STA $34    [$7E:0034]  ;} $34 = 1A0h (BG3 tilemap offset)
$85:8422 20 1E 83    JSR $831E  [$85:831E]  ; Set up PPU for active message box
$85:8425 60          RTS

; Tile numbers for button letters
$85:8426             dw 28E0, ; A
                        3CE1, ; B
                        2CF7, ; X
                        38F8, ; Y
                        38D0, ; Select
                        38EB, ; L
                        38F1, ; R
                        284E  ; Blank
}


;;; $8436: Set up PPU for small message box ;;;
{
$85:8436 C2 30       REP #$30
$85:8438 A9 C0 01    LDA #$01C0             ;\
$85:843B 85 34       STA $34    [$7E:0034]  ;} $34 = 1C0h (BG3 tilemap offset)
$85:843D 20 1E 83    JSR $831E  [$85:831E]  ; Set up PPU for active message box
$85:8440 60          RTS
}


;;; $8441: Set up PPU for large message box ;;;
{
$85:8441 C2 30       REP #$30
$85:8443 A9 A0 01    LDA #$01A0             ;\
$85:8446 85 34       STA $34    [$7E:0034]  ;} $34 = 1A0h (BG3 tilemap offset)
$85:8448 20 1E 83    JSR $831E  [$85:831E]  ; Set up PPU for active message box
$85:844B 60          RTS
}


;;; $844C: Open message box ;;;
{
$85:844C C2 30       REP #$30
$85:844E 9C A2 05    STZ $05A2  [$7E:05A2]  ; Message box animation Y radius = 0

; LOOP
$85:8451 20 9B 85    JSR $859B  [$85:859B]  ; Write message box BG3 Y scroll HDMA data table
$85:8454 AD A2 05    LDA $05A2  [$7E:05A2]  ;\
$85:8457 18          CLC                    ;|
$85:8458 69 00 02    ADC #$0200             ;} Message box animation Y radius += 200h
$85:845B 8D A2 05    STA $05A2  [$7E:05A2]  ;/
$85:845E C9 00 18    CMP #$1800             ;\
$85:8461 30 EE       BMI $EE    [$8451]     ;} If [message box animation Y radius] < 1800h: go to LOOP
$85:8463 A9 00 18    LDA #$1800             ;\
$85:8466 8D A2 05    STA $05A2  [$7E:05A2]  ;} Message box animation Y radius = 1800h
$85:8469 20 9B 85    JSR $859B  [$85:859B]  ; Write message box BG3 Y scroll HDMA data table
$85:846C 60          RTS
}


;;; $846D: Handle message box interaction ;;;
{
$85:846D E2 20       SEP #$20
$85:846F AD 1F 1C    LDA $1C1F  [$7E:1C1F]  ;\
$85:8472 C9 17       CMP #$17               ;} If [message box index] = save confirmation: go to BRANCH_SAVE
$85:8474 F0 3F       BEQ $3F    [$84B5]     ;/
$85:8476 C9 1C       CMP #$1C               ;\
$85:8478 F0 3B       BEQ $3B    [$84B5]     ;} If [message box index] = gunship save confirmation: go to BRANCH_SAVE
$85:847A A2 0A 00    LDX #$000A             ; X = 10
$85:847D AD 1F 1C    LDA $1C1F  [$7E:1C1F]  ;\
$85:8480 C9 14       CMP #$14               ;} If [message box index] != map data access completed:
$85:8482 F0 0F       BEQ $0F    [$8493]     ;/
$85:8484 C9 15       CMP #$15               ;\
$85:8486 F0 0B       BEQ $0B    [$8493]     ;} If [message box index] != energy recharge completed:
$85:8488 C9 16       CMP #$16               ;\
$85:848A F0 07       BEQ $07    [$8493]     ;} If [message box index] != missile reload completed:
$85:848C C9 18       CMP #$18               ;\
$85:848E F0 03       BEQ $03    [$8493]     ;} If [message box index] != save completed:
$85:8490 A2 68 01    LDX #$0168             ; X = 360

$85:8493 20 36 81    JSR $8136  [$85:8136]  ;\
$85:8496 DA          PHX                    ;|
$85:8497 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ;|
$85:849B 22 EF 89 82 JSL $8289EF[$82:89EF]  ;} Play [X] lag frames of music and sound effects
$85:849F FA          PLX                    ;|
$85:84A0 CA          DEX                    ;|
$85:84A1 D0 F0       BNE $F0    [$8493]     ;/

; LOOP_INPUT
$85:84A3 AD 12 42    LDA $4212  [$7E:4212]  ;\
$85:84A6 89 01       BIT #$01               ;} Wait for auto-joypad-read busy flag to be clear
$85:84A8 D0 F9       BNE $F9    [$84A3]     ;/
$85:84AA AD 18 42    LDA $4218  [$7E:4218]  ;\
$85:84AD D0 05       BNE $05    [$84B4]     ;|
$85:84AF AD 19 42    LDA $4219  [$7E:4219]  ;} If no IO controller 1 input: go to LOOP_INPUT
$85:84B2 F0 EF       BEQ $EF    [$84A3]     ;/

$85:84B4 60          RTS                    ; Return

; BRANCH_SAVE
$85:84B5 C2 30       REP #$30
$85:84B7 9C F9 05    STZ $05F9  [$7E:05F9]  ; Save confirmation selection = yes

; LOOP_SAVE_INPUT
$85:84BA E2 30       SEP #$30
$85:84BC A2 02       LDX #$02               ;\
                                            ;|
$85:84BE 20 36 81    JSR $8136  [$85:8136]  ;|
$85:84C1 DA          PHX                    ;|
$85:84C2 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ;} Play 2 lag frames of music and sound effects
$85:84C6 22 EF 89 82 JSL $8289EF[$82:89EF]  ;|
$85:84CA FA          PLX                    ;|
$85:84CB CA          DEX                    ;|
$85:84CC D0 F0       BNE $F0    [$84BE]     ;/
$85:84CE 22 59 94 80 JSL $809459[$80:9459]  ; Read controller input
$85:84D2 C2 30       REP #$30
$85:84D4 A5 8F       LDA $8F    [$7E:008F]  ;\
$85:84D6 F0 E2       BEQ $E2    [$84BA]     ;} If not newly pressed anything: go to LOOP_SAVE_INPUT
$85:84D8 89 80 00    BIT #$0080             ;\
$85:84DB D0 1B       BNE $1B    [$84F8]     ;} If pressing A: return
$85:84DD 89 00 80    BIT #$8000             ;\
$85:84E0 D0 1D       BNE $1D    [$84FF]     ;} If pressing B: go to BRANCH_B
$85:84E2 89 00 23    BIT #$2300             ;\
$85:84E5 F0 D3       BEQ $D3    [$84BA]     ;} If not pressing select/left/right: go to LOOP_SAVE_INPUT
$85:84E7 20 07 85    JSR $8507  [$85:8507]  ; Toggle save confirmation selection
$85:84EA C2 30       REP #$30
$85:84EC A9 37 00    LDA #$0037             ;\
$85:84EF 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$85:84F3 C2 30       REP #$30
$85:84F5 80 C3       BRA $C3    [$84BA]     ; Go to LOOP_SAVE_INPUT

$85:84F7 60          RTS

$85:84F8 AD F9 05    LDA $05F9  [$7E:05F9]  ;\
$85:84FB D0 FA       BNE $FA    [$84F7]     ;} Yeah great. (Branch for pressing A)
$85:84FD 80 F8       BRA $F8    [$84F7]     ;/

; BRANCH_B
$85:84FF A9 02 00    LDA #$0002             ;\
$85:8502 8D F9 05    STA $05F9  [$7E:05F9]  ;} Save confirmation selection = no
$85:8505 80 F0       BRA $F0    [$84F7]     ; Return
}


;;; $8507: Toggle save confirmation selection ;;;
{
$85:8507 AD F9 05    LDA $05F9  [$7E:05F9]  ;\
$85:850A 49 02 00    EOR #$0002             ;} Toggle save confirmation selection
$85:850D 8D F9 05    STA $05F9  [$7E:05F9]  ;/
$85:8510 A0 40 00    LDY #$0040             ; Y = 40h
$85:8513 C9 02 00    CMP #$0002             ;\
$85:8516 D0 03       BNE $03    [$851B]     ;} If [save confirmation selection] = no:
$85:8518 A0 80 00    LDY #$0080             ; Y = 80h

$85:851B A2 00 01    LDX #$0100             ;\
$85:851E A9 20 00    LDA #$0020             ;|
$85:8521 85 34       STA $34    [$7E:0034]  ;|
                                            ;|
$85:8523 B9 81 95    LDA $9581,y            ;|
$85:8526 9F 00 32 7E STA $7E3200,x          ;|
$85:852A E8          INX                    ;} Copy 40h bytes from $9581 + [Y] to $7E:3300
$85:852B E8          INX                    ;|
$85:852C C8          INY                    ;|
$85:852D C8          INY                    ;|
$85:852E C6 34       DEC $34    [$7E:0034]  ;|
$85:8530 D0 F1       BNE $F1    [$8523]     ;/
$85:8532 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:8535 C2 20       REP #$20
$85:8537 A9 A0 59    LDA #$59A0             ;\
$85:853A 85 34       STA $34    [$7E:0034]  ;} >_<
$85:853C A5 34       LDA $34    [$7E:0034]  ;/
$85:853E 8D 16 21    STA $2116  [$7E:2116]  ;\
$85:8541 A9 01 18    LDA #$1801             ;|
$85:8544 8D 10 43    STA $4310  [$7E:4310]  ;|
$85:8547 A9 00 32    LDA #$3200             ;|
$85:854A 8D 12 43    STA $4312  [$7E:4312]  ;|
$85:854D A9 7E 00    LDA #$007E             ;|
$85:8550 8D 14 43    STA $4314  [$7E:4314]  ;|
$85:8553 A9 80 01    LDA #$0180             ;|
$85:8556 8D 15 43    STA $4315  [$7E:4315]  ;} VRAM $59A0..5B1F = [$7E:3200..337F]
$85:8559 9C 17 43    STZ $4317  [$7E:4317]  ;|
$85:855C 9C 19 43    STZ $4319  [$7E:4319]  ;|
$85:855F E2 20       SEP #$20               ;|
$85:8561 A9 80       LDA #$80               ;|
$85:8563 8D 15 21    STA $2115  [$7E:2115]  ;|
$85:8566 A9 02       LDA #$02               ;|
$85:8568 8D 0B 42    STA $420B  [$7E:420B]  ;/
$85:856B 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music
$85:856F 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$85:8573 60          RTS
}


;;; $8574: Play 2 lag frames of music and sound effects ;;;
{
$85:8574 E2 30       SEP #$30
$85:8576 A2 02       LDX #$02

$85:8578 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:857B DA          PHX
$85:857C 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$85:8580 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$85:8584 FA          PLX
$85:8585 CA          DEX
$85:8586 D0 F0       BNE $F0    [$8578]
$85:8588 60          RTS
}


;;; $8589: Close message box ;;;
{
$85:8589 C2 30       REP #$30

; LOOP
$85:858B 20 9B 85    JSR $859B  [$85:859B]  ; Write message box BG3 Y scroll HDMA data table
$85:858E AD A2 05    LDA $05A2  [$7E:05A2]  ;\
$85:8591 38          SEC                    ;|
$85:8592 E9 00 02    SBC #$0200             ;} Message box animation Y radius -= 200h
$85:8595 8D A2 05    STA $05A2  [$7E:05A2]  ;/
$85:8598 10 F1       BPL $F1    [$858B]     ; If [message box animation Y radius] >= 0: go to LOOP
$85:859A 60          RTS
}


;;; $859B: Write message box BG3 Y scroll HDMA data table ;;;
{
; This algorithm implementation is questionable... decrementing/incrementing $05A4..AB doesn't affect the calculations,
; probably an artefact leftover from porting the algorithm of the (unused) expanding and contracting effect ($88:B17F)
; Ideally this code would just do:
;     $7E:30BC..30F7 = -(18h - [message box animation Y radius] / 100h)
;     $7E:30F8..3133 = 18h - [message box animation Y radius] / 100h
;     $7E:3134..31DF = 0

; Given that message box animation Y radius is set to 0 and increased by 200h per frame (for opening the message box, the process happens backwards for closing):
;     The rows between Y positions 5Eh..7Bh are initially scrolled down by 18px, scrolling up 2px per frame
;     The rows between Y positions 7Ch..99h are initially scrolled up by 18px, scrolling down 2px per frame

; So basically the message appears to emerge out of thin air halfway between lines 7Bh and 7Ch
; Note that whilst only 18h pixels of the message are scrolled out on either side, the HDMA is affecting 1Eh lines on either side.
; The large message box actually is larger than 18h * 2 pixels, so the HDMA does make sense;
; the fact hat only 18h pixels are scrolled makes large message boxes abruptly expand at the end (actually quite hard to notice),
; but making the scroll affect more than 18h pixels on small message boxes wouldn't have any visible effect for some frames, causing a (more noticeable) delay

$85:859B 08          PHP
$85:859C 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:859F C2 30       REP #$30
$85:85A1 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$85:85A5 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$85:85A9 A9 00 7B    LDA #$7B00             ;\
$85:85AC 38          SEC                    ;|
$85:85AD ED A2 05    SBC $05A2  [$7E:05A2]  ;|
$85:85B0 EB          XBA                    ;} $05A8 = 7Bh - [message box animation Y radius] / 100h
$85:85B1 29 FF 00    AND #$00FF             ;|
$85:85B4 8D A8 05    STA $05A8  [$7E:05A8]  ;/
$85:85B7 A9 63 00    LDA #$0063             ;\
$85:85BA 8D AA 05    STA $05AA  [$7E:05AA]  ;} $05AA = 63h
$85:85BD A9 00 7C    LDA #$7C00             ;\
$85:85C0 18          CLC                    ;|
$85:85C1 6D A2 05    ADC $05A2  [$7E:05A2]  ;|
$85:85C4 EB          XBA                    ;} $05A4 = 7Ch + [message box animation Y radius] / 100h
$85:85C5 29 FF 00    AND #$00FF             ;|
$85:85C8 8D A4 05    STA $05A4  [$7E:05A4]  ;/
$85:85CB A9 94 00    LDA #$0094             ;\
$85:85CE 8D A6 05    STA $05A6  [$7E:05A6]  ;} $05A6 = 94h
$85:85D1 A2 F6 00    LDX #$00F6             ; X = F6h
$85:85D4 A0 F8 00    LDY #$00F8             ; Y = F8h
$85:85D7 A9 1E 00    LDA #$001E             ;\
$85:85DA 85 14       STA $14    [$7E:0014]  ;} $14 = 1Eh

; LOOP
$85:85DC AD AA 05    LDA $05AA  [$7E:05AA]  ;\
$85:85DF 38          SEC                    ;|
$85:85E0 ED A8 05    SBC $05A8  [$7E:05A8]  ;} $7E:3000 + [X] = [$05AA] - [$05A8]
$85:85E3 9F 00 30 7E STA $7E3000,x[$7E:30F6];/
$85:85E7 CE AA 05    DEC $05AA  [$7E:05AA]  ; Decrement $05AA
$85:85EA CE A8 05    DEC $05A8  [$7E:05A8]  ; Decrement $05A8
$85:85ED CA          DEX                    ;\
$85:85EE CA          DEX                    ;} X -= 2
$85:85EF DA          PHX                    ;\
$85:85F0 BB          TYX                    ;|
$85:85F1 AD A6 05    LDA $05A6  [$7E:05A6]  ;|
$85:85F4 38          SEC                    ;} $7E:3000 + [Y] = [$05A6] - [$05A4]
$85:85F5 ED A4 05    SBC $05A4  [$7E:05A4]  ;|
$85:85F8 9F 00 30 7E STA $7E3000,x[$7E:30F8];|
$85:85FC FA          PLX                    ;/
$85:85FD EE A6 05    INC $05A6  [$7E:05A6]  ; Increment $05A6
$85:8600 EE A4 05    INC $05A4  [$7E:05A4]  ; Increment $05A4
$85:8603 C8          INY                    ;\
$85:8604 C8          INY                    ;} Y += 2
$85:8605 C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$85:8607 D0 D3       BNE $D3    [$85DC]     ; If [$14] != 0: go to LOOP
$85:8609 BB          TYX                    ;\
$85:860A A9 00 00    LDA #$0000             ;|
                                            ;|
$85:860D 9F 00 30 7E STA $7E3000,x[$7E:3134];|
$85:8611 E8          INX                    ;} $7E:3134..31DF = 0
$85:8612 E8          INX                    ;|
$85:8613 E0 E0 01    CPX #$01E0             ;|
$85:8616 30 F5       BMI $F5    [$860D]     ;/
$85:8618 28          PLP
$85:8619 60          RTS
}


;;; $861A: Restore PPU ;;;
{
$85:861A C2 20       REP #$20
$85:861C 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:861F C2 20       REP #$20
$85:8621 A9 80 58    LDA #$5880             ;\
$85:8624 8D 16 21    STA $2116  [$7E:2116]  ;|
$85:8627 A9 01 18    LDA #$1801             ;|
$85:862A 8D 10 43    STA $4310  [$7E:4310]  ;|
$85:862D A9 00 41    LDA #$4100             ;|
$85:8630 8D 12 43    STA $4312  [$7E:4312]  ;|
$85:8633 A9 7E 00    LDA #$007E             ;|
$85:8636 8D 14 43    STA $4314  [$7E:4314]  ;|
$85:8639 A9 00 07    LDA #$0700             ;} VRAM $5880..5BFF = [$7E:4100..47FF]
$85:863C 8D 15 43    STA $4315  [$7E:4315]  ;|
$85:863F 9C 17 43    STZ $4317  [$7E:4317]  ;|
$85:8642 9C 19 43    STZ $4319  [$7E:4319]  ;|
$85:8645 E2 20       SEP #$20               ;|
$85:8647 A9 80       LDA #$80               ;|
$85:8649 8D 15 21    STA $2115  [$7E:2115]  ;|
$85:864C A9 02       LDA #$02               ;|
$85:864E 8D 0B 42    STA $420B  [$7E:420B]  ;/
$85:8651 20 36 81    JSR $8136  [$85:8136]  ; Wait for lag frame
$85:8654 E2 20       SEP #$20
$85:8656 AF EA 33 7E LDA $7E33EA[$7E:33EA]  ;\
$85:865A 85 85       STA $85    [$7E:0085]  ;} HDMA channels to enable = [$7E:33EA]
$85:865C 8D 0C 42    STA $420C  [$7E:420C]  ;/
$85:865F AF EB 33 7E LDA $7E33EB[$7E:33EB]  ;\
$85:8663 85 5B       STA $5B    [$7E:005B]  ;} BG3 tilemap base address and size = [$7E:33EB]
$85:8665 A5 69       LDA $69    [$7E:0069]  ;\
$85:8667 85 6A       STA $6A    [$7E:006A]  ;} Gameplay main screen layers = [main screen layers]
$85:8669 A5 6E       LDA $6E    [$7E:006E]  ;\
$85:866B 85 70       STA $70    [$7E:0070]  ;} Gameplay colour math control register A = [next gameplay colour math control register A]
$85:866D A5 71       LDA $71    [$7E:0071]  ;\
$85:866F 85 73       STA $73    [$7E:0073]  ;} Gameplay colour math control register B = [next gameplay colour math control register B]
$85:8671 A9 19       LDA #$19               ;\
$85:8673 8D 21 21    STA $2121  [$7E:2121]  ;|
$85:8676 AF 32 C0 7E LDA $7EC032[$7E:C032]  ;|
$85:867A 8D 22 21    STA $2122  [$7E:2122]  ;} CGRAM BG3 palette 6 colour 1 = [BG3 palette 6 colour 1] (palette blend colour 0)
$85:867D AF 33 C0 7E LDA $7EC033[$7E:C033]  ;| 
$85:8681 8D 22 21    STA $2122  [$7E:2122]  ;/
$85:8684 AF 34 C0 7E LDA $7EC034[$7E:C034]  ;\
$85:8688 8D 22 21    STA $2122  [$7E:2122]  ;|
$85:868B AF 35 C0 7E LDA $7EC035[$7E:C035]  ;} CGRAM BG3 palette 6 colour 2 = [BG3 palette 6 colour 2] (palette blend colour 1)
$85:868F 8D 22 21    STA $2122  [$7E:2122]  ;/
$85:8692 22 B9 84 88 JSL $8884B9[$88:84B9]  ; HDMA object handler (also handle music queue)
$85:8696 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$85:869A 60          RTS
}


;;; $869B: Message definitions ;;;
{
; Summary of ASM routines:
;     $825A: Write large message box tilemap
;     $8289: Write small message box tilemap

;     $83C5: Draw shoot button and set up PPU for large message box
;     $83CC: Draw run button and set up PPU for large message box
;     $8436: Set up PPU for small message box
;     $8441: Set up PPU for large message box

; In addition to using the correct ASM routines, the message tilemap will have to be the right size;
; *however*, the size of the message tilemap is calculated by subtracting the message tilemap pointer from *the next entry's message tilemap pointer*.
; This is why there are terminator entries (1Bh and 1Dh)

;                        ___________ Modify message box (e.g. draw special button) and set up PPU
;                       |     ______ Draw initial message box tilemap
;                       |    |     _ Message tilemap
;                       |    |    |
$85:869B             dw 8436,8289,877F, ; 1: Energy tank
                        83C5,825A,87BF, ; 2: Missile
                        83C5,825A,88BF, ; 3: Super missile
                        83C5,825A,89BF, ; 4: Power bomb
                        83C5,825A,8ABF, ; 5: Grappling beam
                        83CC,825A,8BBF, ; 6: X-ray scope
                        8436,8289,8CBF, ; 7: Varia suit
                        8436,8289,8CFF, ; 8: Spring ball
                        8436,8289,8D3F, ; 9: Morphing ball
                        8436,8289,8D7F, ; Ah: Screw attack
                        8436,8289,8DBF, ; Bh: Hi-jump boots
                        8436,8289,8DFF, ; Ch: Space jump
                        83CC,825A,8E3F, ; Dh: Speed booster
                        8436,8289,8F3F, ; Eh: Charge beam
                        8436,8289,8F7F, ; Fh: Ice beam
                        8436,8289,8FBF, ; 10h: Wave beam
                        8436,8289,8FFF, ; 11h: Spazer
                        8436,8289,903F, ; 12h: Plasma beam
                        83C5,825A,907F, ; 13h: Bomb
                        8436,8289,917F, ; 14h: Map data access completed
                        8436,8289,923F, ; 15h: Energy recharge completed
                        8436,8289,92FF, ; 16h: Missile reload completed
                        8441,8289,93BF, ; 17h: Would you like to save?
                        8436,8289,94BF, ; 18h: Save completed
                        8436,8289,94FF, ; 19h: Reserve tank
                        8436,8289,953F, ; 1Ah: Gravity suit
                        8436,8289,957F, ; 1Bh: Terminator
                        8441,8289,93BF, ; 1Ch: Would you like to save? (Used by gunship)
                        8436,8289,94BF  ; 1Dh: Terminator. (Save completed, unused)
}


;;; $8749: Special button tilemap offsets ;;;
{
$85:8749             dw 0000, ; 1: Energy tank
                        012A, ; 2: Missile
                        012A, ; 3: Super missile
                        012C, ; 4: Power bomb
                        012C, ; 5: Grappling beam
                        012C, ; 6: X-ray scope
                        0000, ; 7: Varia suit
                        0000, ; 8: Spring ball
                        0000, ; 9: Morphing ball
                        0000, ; Ah: Screw attack
                        0000, ; Bh: Hi-jump boots
                        0000, ; Ch: Space jump
                        0120, ; Dh: Speed booster
                        0000, ; Eh: Charge beam
                        0000, ; Fh: Ice beam
                        0000, ; 10h: Wave beam
                        0000, ; 11h: Spazer
                        0000, ; 12h: Plasma beam
                        012A, ; 13h: Bomb
                        0000, ; 14h: Map data access completed
                        0000, ; 15h: Energy recharge completed
                        0000, ; 16h: Missile reload completed
                        0000, ; 17h: Would you like to save?
                        0000, ; 18h: Save completed
                        0000, ; 19h: Reserve tank
                        0000, ; 1Ah: Gravity suit
                        0000  ; 1Bh: Dummy
}


;;; $877F: Message tilemaps ;;;
{
; '    ENERGY TANK    '
$85:877F             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 28E4, 28ED, 28E4, 28F1, 28E6, 28F8, 284E, 28F3, 28E0, 28ED, 28EA, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '          MISSILE         '
; '                          '
; '         |miss|                 '
; '  select |ile | & press the A button.  '
$85:87BF             dw 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 28EC, 28E8, 28F2, 28F2, 28E8, 28EB, 28E4, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 304B, 3049, 704B, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 28B9, 28BA, 28BB, 284E, 304C, 304A, 704C, 284E, 28C8, 284E, 28B0, 28B1, 28B2, 28C0, 28C1, 28D1, 28E0, 28D3, 28B5, 28B6, 28B7, 28CB, 284E, 284E, 000E, 000E, 000E

; '      SUPER MISSILE       '
; '                          '
; '         [sup                 '
; '   select er] & press the B button.  '
$85:88BF             dw 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 28F2, 28F4, 28EF, 28E4, 28F1, 284E, 28EC, 28E8, 28F2, 28F2, 28E8, 28EB, 28E4, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 3034, 7034, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 28B9, 28BA, 28BB, 284E, 3035, 7035, 284E, 28C8, 284E, 28B0, 28B1, 28B2, 28C0, 28C1, 28D1, 3CE1, 28D3, 28B5, 28B6, 28B7, 28CB, 284E, 284E, 000E, 000E, 000E

; '        POWER BOMB        '
; '                          '
; '       [pow                   '
; ' select er] & set it with the R button. '
$85:89BF             dw 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 28EF, 28EE, 28F6, 28E4, 28F1, 284E, 28E1, 28EE, 28EC, 28E1, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 3036, 7036, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 28B9, 28BA, 28BB, 284E, 3037, 7037, 284E, 28C8, 284E, 28C5, 28C6, 28C7, 284E, 28BE, 28BF, 28C0, 28C1, 28D1, 38F1, 28D3, 28B5, 28B6, 28B7, 28CB, 284E, 000E, 000E, 000E

; '      GRAPPLING BEAM      '
; '                          '
; '        [gra                   '
; ' select pple] press & hold the Y button. '
$85:8ABF             dw 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 28E6, 28F1, 28E0, 28EF, 28EF, 28EB, 28E8, 28ED, 28E6, 284E, 28E1, 28E4, 28E0, 28EC, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 3038, 7038, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 28B9, 28BA, 28BB, 284E, 3039, 7039, 284E, 28B0, 28B1, 28B2, 284E, 28C8, 284E, 28B3, 28B4, 28C0, 28C1, 28D1, 38F8, 28D3, 28B5, 28B6, 28B7, 28CB, 284E, 000E, 000E, 000E

; '        X-RAY SCOPE       '
; '                          '
; '        [x-                   '
; ' select ray] press & hold the X button. '
$85:8BBF             dw 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 28F7, 28CF, 28F1, 28E0, 28F8, 284E, 28F2, 28E2, 28EE, 28EF, 28E4, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 303A, 703A, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 28B9, 28BA, 28BB, 284E, 303B, 703B, 284E, 28B0, 28B1, 28B2, 284E, 28C8, 284E, 28B3, 28B4, 28C0, 28C1, 28D1, 2CF7, 28D3, 28B5, 28B6, 28B7, 28CB, 284E, 000E, 000E, 000E

; '    VARIA SUIT     '
$85:8CBF             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 28F5, 28E0, 28F1, 28E8, 28E0, 284E, 28F2, 28F4, 28E8, 28F3, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '    SPRING BALL    '
$85:8CFF             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 28F2, 28EF, 28F1, 28E8, 28ED, 28E6, 284E, 28E1, 28E0, 28EB, 28EB, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '   MORPHING BALL   '
$85:8D3F             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 28EC, 28EE, 28F1, 28EF, 28E7, 28E8, 28ED, 28E6, 284E, 28E1, 28E0, 28EB, 28EB, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '   SCREW ATTACK    '
$85:8D7F             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 28F2, 28E2, 28F1, 28E4, 28F6, 284E, 28E0, 28F3, 28F3, 28E0, 28E2, 28EA, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '   HI-JUMP BOOTS   '
$85:8DBF             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 28E7, 28E8, 28CF, 28E9, 28F4, 28EC, 28EF, 284E, 28E1, 28EE, 28EE, 28F3, 28F2, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '    SPACE JUMP     '
$85:8DFF             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 28F2, 28EF, 28E0, 28E2, 28E4, 284E, 28E9, 28F4, 28EC, 28EF, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '      SPEED BOOSTER       '
; '                          '
; '                          '
; '  press & hold the # button to run. '
$85:8E3F             dw 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 28F2, 28EF, 28E4, 28E4, 28E3, 284E, 28E1, 28EE, 28EE, 28F2, 28F3, 28E4, 28F1, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 28B0, 28B1, 28B2, 284E, 28C8, 284E, 28B3, 28B4, 28C0, 28C1, 28D1, 38D0, 28D3, 28B5, 28B6, 28B7, 284E, 28C2, 284E, 28BC, 28BD, 28CB, 284E, 284E, 000E, 000E, 000E

; '    CHARGE BEAM    '
$85:8F3F             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 28E2, 28E7, 28E0, 28F1, 28E6, 28E4, 284E, 28E1, 28E4, 28E0, 28EC, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '     ICE BEAM      '
$85:8F7F             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 28E8, 28E2, 28E4, 284E, 28E1, 28E4, 28E0, 28EC, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '     WAVE BEAM     '
$85:8FBF             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 28F6, 28E0, 28F5, 28E4, 284E, 28E1, 28E4, 28E0, 28EC, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '      SPAZER       '
$85:8FFF             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 28F2, 28EF, 28E0, 28F9, 28E4, 28F1, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '    PLASMA BEAM    '
$85:903F             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 284E, 28EF, 28EB, 28E0, 28F2, 28EC, 28E0, 284E, 28E1, 28E4, 28E0, 28EC, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '           BOMB           '
; '  o                       '
; '  T-                      '
; '  |=>O & set it with the L button.  '
$85:907F             dw 000E, 000E, 000E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 28E1, 28EE, 28EC, 28E1, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 38DC, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 3CDD, 3CDF, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 284E, 000E, 000E, 000E,
                        000E, 000E, 000E, 284E, 284E, 3CDE, 3CCC, 38CD, 3CC9, 284E, 28C8, 284E, 28C5, 28C6, 28C7, 284E, 28BE, 28BF, 28C0, 28C1, 28D1, 38EB, 28D3, 28B5, 28B6, 28B7, 28CB, 284E, 284E, 000E, 000E, 000E

; '  MAP DATA ACCESS  '
; '                   '
; '    COMPLETED.     '
$85:917F             dw 000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3CEC, 3CE0, 3CEF, 3C4E, 3CE3, 3CE0, 3CF3, 3CE0, 3C4E, 3CE0, 3CE2, 3CE2, 3CE4, 3CF2, 3CF2, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,
                        000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,
                        000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3C4E, 3C4E, 3CE2, 3CEE, 3CEC, 3CEF, 3CEB, 3CE4, 3CF3, 3CE4, 3CE3, 3CFA, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '  ENERGY RECHARGE  '
; '                   '
; '    COMPLETED.     '
$85:923F             dw 000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3CE4, 3CED, 3CE4, 3CF1, 3CE6, 3CF8, 3C4E, 3CF1, 3CE4, 3CE2, 3CE7, 3CE0, 3CF1, 3CE6, 3CE4, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,
                        000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,
                        000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3C4E, 3C4E, 3CE2, 3CEE, 3CEC, 3CEF, 3CEB, 3CE4, 3CF3, 3CE4, 3CE3, 3CFA, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '  MISSILE RELOAD   '
; '                   '
; '    COMPLETED.     '
$85:92FF             dw 000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3CEC, 3CE8, 3CF2, 3CF2, 3CE8, 3CEB, 3CE4, 3C4E, 3CF1, 3CE4, 3CEB, 3CEE, 3CE0, 3CE3, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,
                        000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 384E, 384E, 384E, 384E, 384E, 384E, 384E, 384E, 384E, 384E, 384E, 384E, 384E, 384E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,
                        000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 384E, 384E, 3CE2, 3CEE, 3CEC, 3CEF, 3CEB, 3CE4, 3CF3, 3CE4, 3CE3, 3CFA, 384E, 384E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '  WOULD YOU LIKE   '
; '  TO SAVE?         '
; '                   '
; '  =>YES      NO    '
$85:93BF             dw 000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3CF6, 3CEE, 3CF4, 3CEB, 3CE3, 3C4E, 3CF8, 3CEE, 3CF4, 3C4E, 3CEB, 3CE8, 3CEA, 3CE4, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,
                        000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3CF3, 3CEE, 3C4E, 3CF2, 3CE0, 3CF5, 3CE4, 3CFE, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,
                        000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,
                        000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 38CC, 38CD, 3CF8, 3CE4, 3CF2, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 2CED, 2CEE, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '  SAVE COMPLETED.  '
$85:94BF             dw 000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3CF2, 3CE0, 3CF5, 3CE4, 3C4E, 3CE2, 3CEE, 3CEC, 3CEF, 3CEB, 3CE4, 3CF3, 3CE4, 3CE3, 3CFA, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '   RESERVE TANK    '
$85:94FF             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 28F1, 28E4, 28F2, 28E4, 28F1, 28F5, 28E4, 284E, 28F3, 28E0, 28ED, 28EA, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '   GRAVITY SUIT    '
$85:953F             dw 000E, 000E, 000E, 000E, 000E, 000E, 284E, 284E, 284E, 28E6, 28F1, 28E0, 28F5, 28E8, 28F3, 28F8, 284E, 28F2, 28F4, 28E8, 28F3, 284E, 284E, 284E, 284E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; Terminator
$85:957F             dw 0000

; '  =>YES      NO    ' (unused)
$85:9581             dw 000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 38CC, 38CD, 3CF8, 3CE4, 3CF2, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 2CED, 2CEE, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E,

; '  =>YES      NO    '
$85:95C1             dw 000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 38CC, 38CD, 3CF8, 3CE4, 3CF2, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 3C4E, 2CED, 2CEE, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

; '    YES    =>NO    '
$85:9601             dw 000E, 000E, 000E, 000E, 000E, 000E, 3C4E, 3C4E, 3C4E, 3C4E, 2CF8, 2CE4, 2CF2, 3C4E, 3C4E, 3C4E, 3C4E, 38CC, 38CD, 3CED, 3CEE, 3C4E, 3C4E, 3C4E, 3C4E, 000E, 000E, 000E, 000E, 000E, 000E, 000E

$85:9641             dw 0000
}


;;; $9643: Free space ;;;
{
$85:9643             fillto $868000, $FF
}
