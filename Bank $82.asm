;;; $8000: Game state 6/1Fh/28h (loading game data / set up new game / transition to demo) ;;;
{
$82:8000 08          PHP
$82:8001 C2 30       REP #$30
$82:8003 AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:8006 C9 28 00    CMP #$0028             ;} If [game state] = 28h (transition to demo):
$82:8009 D0 12       BNE $12    [$801D]     ;/
$82:800B 20 9B 81    JSR $819B  [$82:819B]  ; Initialise IO registers for gameplay
$82:800E 20 E2 82    JSR $82E2  [$82:82E2]  ; Load standard BG3 tiles and sprite tiles, clear tilemaps
$82:8011 20 C5 82    JSR $82C5  [$82:82C5]  ; Load initial palette
$82:8014 22 0D E0 91 JSL $91E00D[$91:E00D]  ; Initialise Samus
$82:8018 20 79 86    JSR $8679  [$82:8679]  ; Load demo room data
$82:801B 80 42       BRA $42    [$805F]     ; Go to BRANCH_GAMEPLAY

$82:801D AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$82:8021 C9 05 00    CMP #$0005             ;} If already on Zebes: go to BRANCH_ON_ZEBES
$82:8024 F0 28       BEQ $28    [$804E]     ;/
$82:8026 C9 1F 00    CMP #$001F             ;\
$82:8029 F0 16       BEQ $16    [$8041]     ;} If starting at Ceres: go to BRANCH_CERES
$82:802B C9 22 00    CMP #$0022             ;\
$82:802E F0 02       BEQ $02    [$8032]     ;} If landing on Zebes: go to BRANCH_ZEBES_LANDING
$82:8030 80 1C       BRA $1C    [$804E]     ; Go to BRANCH_ON_ZEBES

; BRANCH_ZEBES_LANDING
$82:8032 9C 9F 07    STZ $079F  [$7E:079F]  ; Area = Crateria
$82:8035 A9 12 00    LDA #$0012             ;\
$82:8038 8D 8B 07    STA $078B  [$7E:078B]  ;} Load station index = 12h (Zebes landing cutscene)
$82:803B 22 8C 85 80 JSL $80858C[$80:858C]  ; Load mirror of current area's map explored
$82:803F 80 0D       BRA $0D    [$804E]     ; Go to BRANCH_ON_ZEBES

; BRANCH_CERES
$82:8041 A9 06 00    LDA #$0006             ;\
$82:8044 8D 9F 07    STA $079F  [$7E:079F]  ;} Area = Ceres
$82:8047 9C 8B 07    STZ $078B  [$7E:078B]  ; Load station index = 0
$82:804A 22 93 9E 80 JSL $809E93[$80:9E93]  ; Clear timer RAM

; BRANCH_ON_ZEBES
$82:804E 20 9B 81    JSR $819B  [$82:819B]  ; Initialise IO registers for gameplay
$82:8051 20 E2 82    JSR $82E2  [$82:82E2]  ; Load standard BG3 tiles and sprite tiles, clear tilemaps
$82:8054 20 C5 82    JSR $82C5  [$82:82C5]  ; Load initial palette
$82:8057 22 0D E0 91 JSL $91E00D[$91:E00D]  ; Initialise Samus
$82:805B 22 37 C4 80 JSL $80C437[$80:C437]  ; Load from load station

; BRANCH_GAMEPLAY
$82:805F 22 7B A0 80 JSL $80A07B[$80:A07B]  ; Start gameplay
$82:8063 22 79 9A 80 JSL $809A79[$80:9A79]  ; Initialise HUD
$82:8067 22 84 97 A0 JSL $A09784[$A0:9784]  ; RTL
$82:806B 08          PHP                    ;\
$82:806C C2 30       REP #$30               ;|
$82:806E A0 20 00    LDY #$0020             ;|
$82:8071 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:8074 BF 80 C1 7E LDA $7EC180,x[$7E:C180];|
$82:8078 9F 80 C3 7E STA $7EC380,x[$7E:C380];} Target Samus palette = [Samus palette]
$82:807C E8          INX                    ;|
$82:807D E8          INX                    ;|
$82:807E 88          DEY                    ;|
$82:807F 88          DEY                    ;|
$82:8080 D0 F2       BNE $F2    [$8074]     ;|
$82:8082 28          PLP                    ;/
$82:8083 A9 01 00    LDA #$0001             ;\
$82:8086 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$82:8089 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$82:808C 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:8090 22 00 80 86 JSL $868000[$86:8000]  ; Enable enemy projectiles
$82:8094 22 AD 83 84 JSL $8483AD[$84:83AD]  ; Enable PLMs
$82:8098 22 C2 C4 8D JSL $8DC4C2[$8D:C4C2]  ; Enable palette FX objects
$82:809C 22 88 82 88 JSL $888288[$88:8288]  ; Enable HDMA objects
$82:80A0 22 00 80 87 JSL $878000[$87:8000]  ; Enable animated tile objects
$82:80A4 22 0F 8E 90 JSL $908E0F[$90:8E0F]  ; Set liquid physics type
$82:80A8 AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:80AB C9 28 00    CMP #$0028             ;} If [game state] = 28h (transition to demo):
$82:80AE D0 03       BNE $03    [$80B3]     ;/
$82:80B0 4C 46 81    JMP $8146  [$82:8146]  ; Go to BRANCH_DEMO

$82:80B3 AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$82:80B7 C9 22 00    CMP #$0022             ;} If not landing on Zebes: go to BRANCH_NOT_ZEBES_LANDING
$82:80BA D0 37       BNE $37    [$80F3]     ;/
$82:80BC A9 05 00    LDA #$0005             ;\
$82:80BF 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track
$82:80C3 A9 0F 00    LDA #$000F             ;\
$82:80C6 8D A0 0D    STA $0DA0  [$7E:0DA0]  ;} $0DA0 = Fh

; LOOP_ALPHA
$82:80C9 22 D7 8C A0 JSL $A08CD7[$A0:8CD7]  ; Transfer enemy tiles to VRAM and initialise enemies
$82:80CD 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$82:80D1 CE A0 0D    DEC $0DA0  [$7E:0DA0]  ; Decrement $0DA0
$82:80D4 10 F3       BPL $F3    [$80C9]     ; If [$0DA0] > 0: go to LOOP_ALPHA
$82:80D6 EE 98 09    INC $0998  [$7E:0998]  ; Increment game state (loading game data -> setting game up after loading the game)
$82:80D9 08          PHP                    ;\
$82:80DA C2 30       REP #$30               ;|
$82:80DC A0 00 02    LDY #$0200             ;|
$82:80DF A2 00 00    LDX #$0000             ;|
                                            ;|
$82:80E2 BF 00 C2 7E LDA $7EC200,x[$7E:C200];|
$82:80E6 9F 00 C0 7E STA $7EC000,x[$7E:C000];} Palettes = [target palettes]
$82:80EA E8          INX                    ;|
$82:80EB E8          INX                    ;|
$82:80EC 88          DEY                    ;|
$82:80ED 88          DEY                    ;|
$82:80EE D0 F2       BNE $F2    [$80E2]     ;|
$82:80F0 28          PLP                    ;/
$82:80F1 28          PLP
$82:80F2 60          RTS                    ; Return

; BRANCH_NOT_ZEBES_LANDING
$82:80F3 A9 06 00    LDA #$0006             ;\
$82:80F6 8D A0 0D    STA $0DA0  [$7E:0DA0]  ;} $0DA0 = 6

; LOOP_BETA
$82:80F9 22 D7 8C A0 JSL $A08CD7[$A0:8CD7]  ; Transfer enemy tiles to VRAM and initialise enemies
$82:80FD 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$82:8101 CE A0 0D    DEC $0DA0  [$7E:0DA0]  ; Decrement $0DA0
$82:8104 10 F3       BPL $F3    [$80F9]     ; If [$0DA0] > 0: go to LOOP_BETA
$82:8106 A9 07 00    LDA #$0007             ;\
$82:8109 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 7 (setting game up after loading the game)
$82:810C 08          PHP                    ;\
$82:810D C2 30       REP #$30               ;|
$82:810F A0 00 02    LDY #$0200             ;|
$82:8112 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:8115 BF 00 C2 7E LDA $7EC200,x[$7E:C200];|
$82:8119 9F 00 C0 7E STA $7EC000,x[$7E:C000];} Palettes = [target palettes]
$82:811D E8          INX                    ;|
$82:811E E8          INX                    ;|
$82:811F 88          DEY                    ;|
$82:8120 88          DEY                    ;|
$82:8121 D0 F2       BNE $F2    [$8115]     ;|
$82:8123 28          PLP                    ;/
$82:8124 AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$82:8128 C9 1F 00    CMP #$001F             ;} If starting at Ceres:
$82:812B D0 10       BNE $10    [$813D]     ;/
$82:812D A9 00 00    LDA #$0000             ;\
$82:8130 8F BE C1 7E STA $7EC1BE[$7E:C1BE]  ;} Sprite palette 5, colour Fh = 0
$82:8134 A9 08 00    LDA #$0008             ;\
$82:8137 22 84 F0 90 JSL $90F084[$90:F084]  ;} Set up Samus for Ceres start
$82:813B 28          PLP
$82:813C 60          RTS                    ; Return

$82:813D A9 09 00    LDA #$0009             ;\
$82:8140 22 84 F0 90 JSL $90F084[$90:F084]  ;} Set up Samus for Zebes start
$82:8144 28          PLP
$82:8145 60          RTS                    ; Return

; BRANCH_DEMO
$82:8146 A9 06 00    LDA #$0006             ;\
$82:8149 8D A0 0D    STA $0DA0  [$7E:0DA0]  ;} $0DA0 = 6

$82:814C 22 D7 8C A0 JSL $A08CD7[$A0:8CD7]  ; Transfer enemy tiles to VRAM and initialise enemies
$82:8150 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$82:8154 CE A0 0D    DEC $0DA0  [$7E:0DA0]  ; Decrement $0DA0
$82:8157 10 F3       BPL $F3    [$814C]     ; If [$0DA0] > 0: loop
$82:8159 AD 57 1F    LDA $1F57  [$7E:1F57]  ;\
$82:815C 3A          DEC A                  ;|
$82:815D 85 12       STA $12    [$7E:0012]  ;|
$82:815F 0A          ASL A                  ;|
$82:8160 0A          ASL A                  ;|
$82:8161 0A          ASL A                  ;|
$82:8162 65 12       ADC $12    [$7E:0012]  ;|
$82:8164 0A          ASL A                  ;|
$82:8165 85 12       STA $12    [$7E:0012]  ;|
$82:8167 AD 55 1F    LDA $1F55  [$7E:1F55]  ;|
$82:816A 0A          ASL A                  ;} Execute [[$876C + demo set * 2] + (demo scene index - 1) * 12h + 10h]
$82:816B AA          TAX                    ;|
$82:816C BD 6C 87    LDA $876C,x            ;|
$82:816F 18          CLC                    ;|
$82:8170 65 12       ADC $12    [$7E:0012]  ;|
$82:8172 AA          TAX                    ;|
$82:8173 BD 10 00    LDA $0010,x            ;|
$82:8176 85 12       STA $12    [$7E:0012]  ;|
$82:8178 A2 00 00    LDX #$0000             ;|
$82:817B FC 12 00    JSR ($0012,x)          ;/
$82:817E EE 98 09    INC $0998  [$7E:0998]  ; Game state = 29h (transition to demo)
$82:8181 08          PHP                    ;\
$82:8182 C2 30       REP #$30               ;|
$82:8184 A0 00 02    LDY #$0200             ;|
$82:8187 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:818A BF 00 C2 7E LDA $7EC200,x[$7E:C880];|
$82:818E 9F 00 C0 7E STA $7EC000,x[$7E:C680];} Palettes = [target palettes]
$82:8192 E8          INX                    ;|
$82:8193 E8          INX                    ;|
$82:8194 88          DEY                    ;|
$82:8195 88          DEY                    ;|
$82:8196 D0 F2       BNE $F2    [$818A]     ;|
$82:8198 28          PLP                    ;/
$82:8199 28          PLP
$82:819A 60          RTS
}


;;; $819B: Initialise IO registers for gameplay ;;;
{
$82:819B 08          PHP
$82:819C 20 A4 81    JSR $81A4  [$82:81A4]  ; Initialise CPU registers for gameplay
$82:819F 20 DD 81    JSR $81DD  [$82:81DD]  ; Initialise PPU registers for gameplay
$82:81A2 28          PLP
$82:81A3 60          RTS
}


;;; $81A4: Initialise CPU registers for gameplay ;;;
{
$82:81A4 08          PHP
$82:81A5 E2 30       SEP #$30
$82:81A7 A9 01       LDA #$01               ;\
$82:81A9 8D 00 42    STA $4200  [$7E:4200]  ;} Enable joypad auto-read, disable interrupts
$82:81AC 85 84       STA $84    [$7E:0084]  ;/
$82:81AE 9C 01 42    STZ $4201  [$7E:4201]  ; Joypad programmable IO port = 0
$82:81B1 9C 02 42    STZ $4202  [$7E:4202]  ; Multiplicand = 0
$82:81B4 9C 03 42    STZ $4203  [$7E:4203]  ; Multiplier = 0
$82:81B7 9C 04 42    STZ $4204  [$7E:4204]  ;\
$82:81BA 9C 05 42    STZ $4205  [$7E:4205]  ;} Dividend = 0
$82:81BD 9C 06 42    STZ $4206  [$7E:4206]  ; Divisor = 0
$82:81C0 9C 07 42    STZ $4207  [$7E:4207]  ;\
$82:81C3 9C 08 42    STZ $4208  [$7E:4208]  ;} Horizontal timer = 0
$82:81C6 9C 09 42    STZ $4209  [$7E:4209]  ;\
$82:81C9 9C 0A 42    STZ $420A  [$7E:420A]  ;} Vertical timer = 0
$82:81CC 9C 0B 42    STZ $420B  [$7E:420B]  ; Disable DMAs
$82:81CF 9C 0C 42    STZ $420C  [$7E:420C]  ;\
$82:81D2 64 85       STZ $85    [$7E:0085]  ;} Disable HDMAs
$82:81D4 A9 01       LDA #$01               ;\
$82:81D6 8D 0D 42    STA $420D  [$7E:420D]  ;} Set fast ROM
$82:81D9 85 86       STA $86    [$7E:0086]  ;/
$82:81DB 28          PLP
$82:81DC 60          RTS
}


;;; $81DD: Set up PPU for gameplay ;;;
{
$82:81DD 08          PHP
$82:81DE E2 30       SEP #$30
$82:81E0 A9 80       LDA #$80               ;\
$82:81E2 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank
$82:81E5 85 51       STA $51    [$7E:0051]  ;/
$82:81E7 A9 03       LDA #$03               ;\
$82:81E9 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$82:81EC 85 52       STA $52    [$7E:0052]  ;/
$82:81EE 9C 02 21    STZ $2102  [$7E:2102]  ;\
$82:81F1 64 53       STZ $53    [$7E:0053]  ;|
$82:81F3 A9 80       LDA #$80               ;} Top priority sprite number = $00
$82:81F5 8D 03 21    STA $2103  [$7E:2103]  ;|
$82:81F8 85 54       STA $54    [$7E:0054]  ;/
$82:81FA 9C 04 21    STZ $2104  [$7E:2104]  ;\
$82:81FD 9C 04 21    STZ $2104  [$7E:2104]  ;} OAM write address = $0000
$82:8200 A9 09       LDA #$09               ;\
$82:8202 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 1 with BG3 priority, BG tile sizes = 8x8
$82:8205 85 55       STA $55    [$7E:0055]  ;/
$82:8207 9C 06 21    STZ $2106  [$7E:2106]  ;\
$82:820A 64 57       STZ $57    [$7E:0057]  ;} Disable mosaic
$82:820C 64 5D       STZ $5D    [$7E:005D]  ;\
$82:820E 9C 0B 21    STZ $210B  [$7E:210B]  ;|
$82:8211 A9 04       LDA #$04               ;} BG1/2/4 tiles base address = $0000, BG3 tiles base address = $4000
$82:8213 85 5E       STA $5E    [$7E:005E]  ;|
$82:8215 8D 0C 21    STA $210C  [$7E:210C]  ;/
$82:8218 A9 51       LDA #$51               ;\
$82:821A 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $5000, size = 64x32
$82:821C 8D 07 21    STA $2107  [$7E:2107]  ;/
$82:821F A9 49       LDA #$49               ;\
$82:8221 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4800, size = 64x32
$82:8223 8D 08 21    STA $2108  [$7E:2108]  ;/
$82:8226 A9 5A       LDA #$5A               ;\
$82:8228 85 5A       STA $5A    [$7E:005A]  ;} BG3 tilemap base address = $5800, size = 32x64
$82:822A 8D 09 21    STA $2109  [$7E:2109]  ;/
$82:822D A9 00       LDA #$00               ;\
$82:822F 85 5C       STA $5C    [$7E:005C]  ;} BG4 tilemap base address = $0000, size = 32x32
$82:8231 8D 0A 21    STA $210A  [$7E:210A]  ;/
$82:8234 9C 15 21    STZ $2115  [$7E:2115]  ; VRAM address increment mode = 8-bit access
$82:8237 9C 23 21    STZ $2123  [$7E:2123]  ;\
$82:823A 64 60       STZ $60    [$7E:0060]  ;} Disable BG1/2 windowing
$82:823C 9C 23 21    STZ $2123  [$7E:2123]
$82:823F 64 60       STZ $60    [$7E:0060]
$82:8241 9C 24 21    STZ $2124  [$7E:2124]  ;\
$82:8244 64 61       STZ $61    [$7E:0061]  ;} Disable BG3/4 windowing
$82:8246 9C 25 21    STZ $2125  [$7E:2125]  ;\
$82:8249 64 62       STZ $62    [$7E:0062]  ;} Disable sprite/colour windowing
$82:824B 9C 26 21    STZ $2126  [$7E:2126]  ;\
$82:824E 64 63       STZ $63    [$7E:0063]  ;} Window 1 left position = 0
$82:8250 9C 27 21    STZ $2127  [$7E:2127]  ;\
$82:8253 64 64       STZ $64    [$7E:0064]  ;} Window 1 right position = 0
$82:8255 9C 28 21    STZ $2128  [$7E:2128]  ;\
$82:8258 64 65       STZ $65    [$7E:0065]  ;} Window 2 left position = 0
$82:825A 9C 29 21    STZ $2129  [$7E:2129]  ;\
$82:825D 64 66       STZ $66    [$7E:0066]  ;} Window 2 right position = 0
$82:825F 9C 2A 21    STZ $212A  [$7E:212A]  ;\
$82:8262 64 67       STZ $67    [$7E:0067]  ;} Windowed background combining logic = OR
$82:8264 9C 2B 21    STZ $212B  [$7E:212B]  ;\
$82:8267 64 68       STZ $68    [$7E:0068]  ;} Windowed sprite/colour combining logic = OR
$82:8269 A9 17       LDA #$17               ;\
$82:826B 8D 2C 21    STA $212C  [$7E:212C]  ;} Enable BG1/2/3 and sprites
$82:826E 85 69       STA $69    [$7E:0069]  ;/
$82:8270 9C 2E 21    STZ $212E  [$7E:212E]  ;\
$82:8273 64 6C       STZ $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$82:8275 A9 00       LDA #$00               ;\
$82:8277 8D 2D 21    STA $212D  [$7E:212D]  ;} Disable all subscreen layers
$82:827A 85 6B       STA $6B    [$7E:006B]  ;/
$82:827C 9C 2F 21    STZ $212F  [$7E:212F]  ;\
$82:827F 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area subscreen
$82:8281 9C 30 21    STZ $2130  [$7E:2130]  ;\
$82:8284 64 6E       STZ $6E    [$7E:006E]  ;|
$82:8286 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$82:8289 64 71       STZ $71    [$7E:0071]  ;/
$82:828B A9 E0       LDA #$E0               ;\
$82:828D 8D 32 21    STA $2132  [$7E:2132]  ;} Colour math subscreen backdrop colour = 0
$82:8290 A9 00       LDA #$00               ;\
$82:8292 8D 33 21    STA $2133  [$7E:2133]  ;} Use standard NTSC resolution
$82:8295 85 77       STA $77    [$7E:0077]  ;/
$82:8297 C2 30       REP #$30
$82:8299 9C 90 05    STZ $0590  [$7E:0590]  ; OAM data index = 0
$82:829C A9 00 00    LDA #$0000             ;\
$82:829F A2 00 30    LDX #$3000             ;|
$82:82A2 A0 FE 07    LDY #$07FE             ;} $7E:3000..37FD = 0
$82:82A5 22 F6 83 80 JSL $8083F6[$80:83F6]  ;/
$82:82A9 A9 6F 00    LDA #$006F             ;\
$82:82AC A2 00 40    LDX #$4000             ;|
$82:82AF A0 FE 07    LDY #$07FE             ;} $7E:4000..47FD = 006Fh
$82:82B2 22 F6 83 80 JSL $8083F6[$80:83F6]  ;/
$82:82B6 A9 0F 2C    LDA #$2C0F             ;\
$82:82B9 A2 00 40    LDX #$4000             ;|
$82:82BC A0 FE 00    LDY #$00FE             ;} $7E:4000..FD = 2C0Fh
$82:82BF 22 F6 83 80 JSL $8083F6[$80:83F6]  ;/
$82:82C3 28          PLP
$82:82C4 60          RTS
}


;;; $82C5: Load initial palette ;;;
{
; Palette loaded when loading a save or demo.
; Nothing is displayed during this time, so it's unclear why this palette is loaded at all
$82:82C5 08          PHP
$82:82C6 E2 30       SEP #$30
$82:82C8 08          PHP
$82:82C9 C2 30       REP #$30
$82:82CB A0 00 02    LDY #$0200
$82:82CE A2 00 00    LDX #$0000

$82:82D1 BF 00 80 9A LDA $9A8000,x[$9A:8000]
$82:82D5 9F 00 C0 7E STA $7EC000,x[$7E:C000]
$82:82D9 E8          INX
$82:82DA E8          INX
$82:82DB 88          DEY
$82:82DC 88          DEY
$82:82DD D0 F2       BNE $F2    [$82D1]
$82:82DF 28          PLP
$82:82E0 28          PLP
$82:82E1 60          RTS
}


;;; $82E2: Load standard BG3 tiles and sprite tiles, clear tilemaps ;;;
{
$82:82E2 08          PHP
$82:82E3 E2 30       SEP #$30
$82:82E5 A9 00       LDA #$00               ;\
$82:82E7 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:82EA A9 40       LDA #$40               ;|
$82:82EC 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:82EF A9 80       LDA #$80               ;|
$82:82F1 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4000..4FFF (BG3 tiles and BG2 tilemap) = [$9A:B200..D1FF]
$82:82F4 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:82F8             dx 01,01,18,9AB200,2000;|
$82:8300 A9 02       LDA #$02               ;|
$82:8302 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8305 A9 00       LDA #$00               ;\
$82:8307 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:830A A9 60       LDA #$60               ;|
$82:830C 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:830F A9 80       LDA #$80               ;|
$82:8311 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $6000..7FFF (sprite tiles) = [$9A:D200..11FF] (size is completely wrong, goes through free space and wraps into RAM)
$82:8314 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8318             dx 01,01,18,9AD200,4000;|
$82:8320 A9 02       LDA #$02               ;|
$82:8322 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8325 A9 00       LDA #$00               ;\
$82:8327 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:832A A9 50       LDA #$50               ;|
$82:832C 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:832F A9 80       LDA #$80               ;|
$82:8331 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $5000..57FF (BG1 tilemap) = [$7E:4000..4FFF] (see $82A9)
$82:8334 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8338             dx 01,01,18,7E4000,1000;|
$82:8340 A9 02       LDA #$02               ;|
$82:8342 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8345 A9 00       LDA #$00               ;\
$82:8347 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:834A A9 58       LDA #$58               ;|
$82:834C 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:834F A9 80       LDA #$80               ;|
$82:8351 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $5800..5BFF (BG3 tilemap) = [$7E:4000..47FF] (see $82A9)
$82:8354 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8358             dx 01,01,18,7E4000,0800;|
$82:8360 A9 02       LDA #$02               ;|
$82:8362 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8365 28          PLP
$82:8366 60          RTS
}


;;; $8367: Game state 20h (made it to Ceres elevator) ;;;
{
$82:8367 08          PHP
$82:8368 C2 30       REP #$30
$82:836A AD 43 09    LDA $0943  [$7E:0943]  ;\
$82:836D F0 04       BEQ $04    [$8373]     ;} If [timer status] != inactive:
$82:836F 22 6C 9F 80 JSL $809F6C[$80:9F6C]  ; Draw timer

$82:8373 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:8376 CE A0 0A    DEC $0AA0  [$7E:0AA0]  ; Decrement reached Ceres elevator fade timer
$82:8379 F0 02       BEQ $02    [$837D]     ;\
$82:837B 10 09       BPL $09    [$8386]     ;} If [reached Ceres elevator fade timer] > 0: return

$82:837D EE 98 09    INC $0998  [$7E:0998]  ; Game state = 21h (blackout from Ceres)
$82:8380 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:8383 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0

$82:8386 28          PLP
$82:8387 60          RTS
}


;;; $8388: Game state 21h (blackout from Ceres) ;;;
{
$82:8388 08          PHP
$82:8389 C2 30       REP #$30
$82:838B AD 43 09    LDA $0943  [$7E:0943]  ;\
$82:838E F0 04       BEQ $04    [$8394]     ;} If [timer status] != inactive:
$82:8390 22 6C 9F 80 JSL $809F6C[$80:9F6C]  ; Draw timer

$82:8394 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:8397 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:839B E2 20       SEP #$20
$82:839D A5 51       LDA $51    [$7E:0051]  ;\
$82:839F C9 80       CMP #$80               ;} If not finished fading out:
$82:83A1 F0 04       BEQ $04    [$83A7]     ;/
$82:83A3 C2 20       REP #$20               ; >_<;
$82:83A5 28          PLP
$82:83A6 60          RTS                    ; Return

$82:83A7 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:83AB C2 20       REP #$20
$82:83AD 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA queue
$82:83B1 22 5F 98 80 JSL $80985F[$80:985F]  ; Disable h/v-counter interrupts
$82:83B5 9C 82 19    STZ $1982  [$7E:1982]  ; Default layer blending configuration = 0
$82:83B8 64 AB       STZ $AB    [$7E:00AB]  ; Interrupt command = 0
$82:83BA E2 20       SEP #$20
$82:83BC 64 6E       STZ $6E    [$7E:006E]  ;\
$82:83BE 64 71       STZ $71    [$7E:0071]  ;} Disable colour math
$82:83C0 A9 10       LDA #$10               ;\
$82:83C2 85 69       STA $69    [$7E:0069]  ;} Main screen layers = sprites
$82:83C4 64 6B       STZ $6B    [$7E:006B]  ; Disable subscreen layers
$82:83C6 64 6C       STZ $6C    [$7E:006C]  ;\
$82:83C8 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area
$82:83CA A9 09       LDA #$09               ;\
$82:83CC 85 55       STA $55    [$7E:0055]  ;} Use mode 1 with BG3 priority and 8x8 tile sizes
$82:83CE C2 20       REP #$20
$82:83D0 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:83D3 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:83D6 A9 22 00    LDA #$0022             ;\
$82:83D9 8F 14 D9 7E STA $7ED914[$7E:D914]  ;} Set landing on Zebes
$82:83DD 8D 98 09    STA $0998  [$7E:0998]  ; Game state = 22h (Ceres goes boom, Samus goes to Zebes)
$82:83E0 AD 52 09    LDA $0952  [$7E:0952]  ;\
$82:83E3 22 00 80 81 JSL $818000[$81:8000]  ;} Save current save slot to SRAM
$82:83E7 A9 1B C1    LDA #$C11B             ;\
$82:83EA 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $C11B
$82:83ED 9C 3F 09    STZ $093F  [$7E:093F]  ; Ceres status = 0
$82:83F0 9C 43 09    STZ $0943  [$7E:0943]  ; Timer status = inactive
$82:83F3 A9 00 00    LDA #$0000             ;\
$82:83F6 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$82:83FA A9 02 00    LDA #$0002             ;\
$82:83FD 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 15 (silence)
$82:8401 A9 71 00    LDA #$0071             ;\
$82:8404 22 A3 90 80 JSL $8090A3[$80:90A3]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 15 (silence)
$82:8408 A9 01 00    LDA #$0001             ;\
$82:840B 22 25 91 80 JSL $809125[$80:9125]  ;} Queue sound 1, sound library 3, max queued sounds allowed = 15 (silence)
$82:840F 28          PLP
$82:8410 60          RTS
}


;;; $8411: Game state 23h (time up) ;;;
{
$82:8411 08          PHP
$82:8412 C2 30       REP #$30
$82:8414 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:8417 A9 08 00    LDA #$0008             ;\
$82:841A 8F 02 C4 7E STA $7EC402[$7E:C402]  ;} Palette change denominator = 8
$82:841E 20 02 DA    JSR $DA02  [$82:DA02]  ; Advance gradual colour change of all palettes
$82:8421 90 0C       BCC $0C    [$842F]     ; If reached target colour:
$82:8423 A9 24 00    LDA #$0024             ;\
$82:8426 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 24h (whiting out from time up)
$82:8429 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:842C 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0

$82:842F 28          PLP
$82:8430 60          RTS
}


;;; $8431: Game state 24h (whiting out from time up) ;;;
{
$82:8431 08          PHP
$82:8432 C2 30       REP #$30
$82:8434 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:8438 E2 20       SEP #$20
$82:843A A5 51       LDA $51    [$7E:0051]  ;\
$82:843C C9 80       CMP #$80               ;} If not finished fading out:
$82:843E F0 04       BEQ $04    [$8444]     ;/
$82:8440 C2 20       REP #$20
$82:8442 28          PLP
$82:8443 60          RTS                    ; Return

$82:8444 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:8448 C2 20       REP #$20
$82:844A 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$82:844E 22 5F 98 80 JSL $80985F[$80:985F]  ; Disable h/v-counter interrupts
$82:8452 9C 82 19    STZ $1982  [$7E:1982]  ; Default layer blending configuration = 0
$82:8455 64 AB       STZ $AB    [$7E:00AB]  ; Interrupt command = 0
$82:8457 E2 20       SEP #$20
$82:8459 64 6E       STZ $6E    [$7E:006E]  ;\
$82:845B 64 71       STZ $71    [$7E:0071]  ;} Disable colour math
$82:845D A9 10       LDA #$10
$82:845F 85 69       STA $69    [$7E:0069]  ; Main screen layers = sprites
$82:8461 64 6B       STZ $6B    [$7E:006B]  ; Disable subscreen layers
$82:8463 64 6C       STZ $6C    [$7E:006C]  ;\
$82:8465 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area
$82:8467 A9 09       LDA #$09               ;\
$82:8469 85 55       STA $55    [$7E:0055]  ;} Use mode 1 with BG3 priority and 8x8 tile sizes
$82:846B C2 20       REP #$20
$82:846D 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:8470 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:8473 9C 3F 09    STZ $093F  [$7E:093F]  ; Ceres status = 0
$82:8476 9C 43 09    STZ $0943  [$7E:0943]  ; Timer status = inactive
$82:8479 A9 02 00    LDA #$0002             ;\
$82:847C 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 15 (silence)
$82:8480 A9 71 00    LDA #$0071             ;\
$82:8483 22 A3 90 80 JSL $8090A3[$80:90A3]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 15 (silence)
$82:8487 A9 01 00    LDA #$0001             ;\
$82:848A 22 25 91 80 JSL $809125[$80:9125]  ;} Queue sound 1, sound library 3, max queued sounds allowed = 15 (silence)
$82:848E A9 0E 00    LDA #$000E             ;\
$82:8491 22 33 82 80 JSL $808233[$80:8233]  ;} If Zebes timebomb not set: go to BRANCH_NOT_ZEBES_TIMEBOMB
$82:8495 90 18       BCC $18    [$84AF]     ;/
$82:8497 9C E2 0D    STZ $0DE2  [$7E:0DE2]  ; Game options menu index = 0
$82:849A 9C 27 07    STZ $0727  [$7E:0727]  ; Menu index = 0
$82:849D A2 FE 00    LDX #$00FE             ;\
                                            ;|
$82:84A0 9E 8D 1A    STZ $1A8D,x            ;|
$82:84A3 CA          DEX                    ;} $1A8D..1B8C = 00FEh
$82:84A4 CA          DEX                    ;|
$82:84A5 10 F9       BPL $F9    [$84A0]     ;/
$82:84A7 A9 19 00    LDA #$0019             ;\
$82:84AA 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 19h (death sequence, black out)
$82:84AD 28          PLP
$82:84AE 60          RTS                    ; Return

; BRANCH_NOT_ZEBES_TIMEBOMB
$82:84AF A9 25 00    LDA #$0025             ;\
$82:84B2 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 25h (Ceres goes boom with Samus)
$82:84B5 A9 1B C1    LDA #$C11B             ;\
$82:84B8 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $C11B
$82:84BB 28          PLP
$82:84BC 60          RTS
}


;;; $84BD: Game state 26h (Samus escapes from Zebes) ;;;
{
$82:84BD 08          PHP
$82:84BE C2 30       REP #$30
$82:84C0 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:84C3 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:84C7 E2 20       SEP #$20
$82:84C9 A5 51       LDA $51    [$7E:0051]  ;\
$82:84CB C9 80       CMP #$80               ;} If not finished fading out:
$82:84CD F0 04       BEQ $04    [$84D3]     ;/
$82:84CF C2 20       REP #$20               ; >_<;
$82:84D1 28          PLP
$82:84D2 60          RTS                    ; Return

$82:84D3 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:84D7 C2 20       REP #$20
$82:84D9 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$82:84DD 22 5F 98 80 JSL $80985F[$80:985F]  ; Disable h/v-counter interrupts
$82:84E1 9C 82 19    STZ $1982  [$7E:1982]  ; Default layer blending configuration = 0
$82:84E4 E2 20       SEP #$20
$82:84E6 64 6E       STZ $6E    [$7E:006E]  ;\
$82:84E8 64 71       STZ $71    [$7E:0071]  ;} Disable colour math
$82:84EA A9 10       LDA #$10               ;\
$82:84EC 85 69       STA $69    [$7E:0069]  ;} Main screen layers = sprites
$82:84EE 64 6B       STZ $6B    [$7E:006B]  ; Disable subscreen layers
$82:84F0 64 6C       STZ $6C    [$7E:006C]  ;\
$82:84F2 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area
$82:84F4 A9 09       LDA #$09               ;\
$82:84F6 85 55       STA $55    [$7E:0055]  ;} Use mode 1 with BG3 priority and 8x8 tile sizes
$82:84F8 C2 20       REP #$20
$82:84FA 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:84FD 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:8500 A9 27 00    LDA #$0027             ;\
$82:8503 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 27h (ending and credits)
$82:8506 A9 80 D4    LDA #$D480             ;\
$82:8509 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $D480
$82:850C 9C 43 09    STZ $0943  [$7E:0943]  ; Timer status = inactive
$82:850F A9 00 00    LDA #$0000             ;\
$82:8512 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$82:8516 A9 02 00    LDA #$0002             ;\
$82:8519 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 15 (silence)
$82:851D A9 71 00    LDA #$0071             ;\
$82:8520 22 A3 90 80 JSL $8090A3[$80:90A3]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 15 (silence)
$82:8524 A9 01 00    LDA #$0001             ;\
$82:8527 22 25 91 80 JSL $809125[$80:9125]  ;} Queue sound 1, sound library 3, max queued sounds allowed = 15 (silence)
$82:852B 28          PLP
$82:852C 60          RTS
}


;;; $852D..893C: Demos ;;;
{
;;; $852D: Game state 29h (transition to demo) ;;;
{
$82:852D 08          PHP
$82:852E C2 30       REP #$30
$82:8530 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:8533 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$82:8537 22 B9 84 88 JSL $8884B9[$88:84B9]  ; HDMA object handler (also handle music queue)
$82:853B EE 98 09    INC $0998  [$7E:0998]  ; Game state = 2Ah (playing demo)
$82:853E E2 20       SEP #$20               ;\
$82:8540 A9 0F       LDA #$0F               ;} Set max brightness
$82:8542 85 51       STA $51    [$7E:0051]  ;/
$82:8544 C2 20       REP #$20               ; >_<;
$82:8546 28          PLP
$82:8547 60          RTS
}


;;; $8548: Game state 2Ah (playing demo) ;;;
{
$82:8548 08          PHP
$82:8549 C2 30       REP #$30
$82:854B 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:854E A5 8F       LDA $8F    [$7E:008F]  ;\
$82:8550 F0 08       BEQ $08    [$855A]     ;} If newly pressed anything:
$82:8552 A9 01 00    LDA #$0001             ;\
$82:8555 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;} $0DEC = 1
$82:8558 80 20       BRA $20    [$857A]     ; Go to BRANCH_END_DEMOS

$82:855A CE 53 1F    DEC $1F53  [$7E:1F53]  ; Decrement demo timer
$82:855D F0 02       BEQ $02    [$8561]     ;\
$82:855F 10 30       BPL $30    [$8591]     ;} If [demo timer] > 0: return

$82:8561 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; $0DEC = 0
$82:8564 A2 5A 00    LDX #$005A             ; X = 90

; LOOP
$82:8567 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$82:856B A5 8F       LDA $8F    [$7E:008F]  ;\
$82:856D D0 05       BNE $05    [$8574]     ;} If not newly pressed anything:
$82:856F CA          DEX                    ; Decrement X
$82:8570 D0 F5       BNE $F5    [$8567]     ; If [X] != 0: go to LOOP
$82:8572 80 06       BRA $06    [$857A]     ; Go to BRANCH_END_DEMOS

$82:8574 A9 01 00    LDA #$0001             ;\
$82:8577 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;} $0DEC = 1

; BRANCH_END_DEMOS
$82:857A EE 98 09    INC $0998  [$7E:0998]  ; Game state = 2Bh (unload game data)
$82:857D 9C F5 05    STZ $05F5  [$7E:05F5]  ; Enable sounds
$82:8580 E2 20       SEP #$20               ;\
$82:8582 A9 80       LDA #$80               ;|
$82:8584 85 51       STA $51    [$7E:0051]  ;} Set forced blank
$82:8586 C2 20       REP #$20               ;/
$82:8588 A9 01 00    LDA #$0001             ;\
$82:858B 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$82:858E 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1

$82:8591 28          PLP
$82:8592 60          RTS
}


;;; $8593: Game state 2Bh (unload game data) ;;;
{
$82:8593 08          PHP
$82:8594 C2 30       REP #$30
$82:8596 AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$82:8599 C9 01 00    CMP #$0001             ;} If [$0DEC] != 1:
$82:859C F0 03       BEQ $03    [$85A1]     ;/
$82:859E 20 37 86    JSR $8637  [$82:8637]  ; Check for next demo

$82:85A1 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:85A5 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 2Ch (transition from demo)
$82:85A8 9C 23 07    STZ $0723  [$7E:0723]  ;\
$82:85AB 9C 25 07    STZ $0725  [$7E:0725]  ;} Disable screen fade
$82:85AE 22 9E 82 88 JSL $88829E[$88:829E]  ; Clear DMA queue
$82:85B2 22 5F 98 80 JSL $80985F[$80:985F]  ; Disable h/v-counter interrupts
$82:85B6 9C 82 19    STZ $1982  [$7E:1982]  ; Default layer blending configuration = 0
$82:85B9 64 AB       STZ $AB    [$7E:00AB]  ; Clear interrupt index
$82:85BB 64 A7       STZ $A7    [$7E:00A7]  ; Clear next interrupt index
$82:85BD 22 CD C4 8D JSL $8DC4CD[$8D:C4CD]  ; Disable glow
$82:85C1 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]  ; Clear palette FX objects
$82:85C5 A9 1F 1C    LDA #$1C1F             ;\
$82:85C8 3A          DEC A                  ;|
$82:85C9 3A          DEC A                  ;|
$82:85CA 38          SEC                    ;|
$82:85CB E9 8D 19    SBC #$198D             ;|
$82:85CE AA          TAX                    ;} Clear $198D..1C1E (non-gameplay RAM)
                                            ;|
$82:85CF 9E 8D 19    STZ $198D,x[$7E:1C1D]  ;|
$82:85D2 CA          DEX                    ;|
$82:85D3 CA          DEX                    ;|
$82:85D4 10 F9       BPL $F9    [$85CF]     ;/
$82:85D6 A9 98 09    LDA #$0998             ;\
$82:85D9 3A          DEC A                  ;|
$82:85DA 3A          DEC A                  ;|
$82:85DB 38          SEC                    ;|
$82:85DC E9 7C 07    SBC #$077C             ;|
$82:85DF AA          TAX                    ;} Clear $077C..0997 (main gameplay RAM)
                                            ;|
$82:85E0 9E 7C 07    STZ $077C,x[$7E:0996]  ;|
$82:85E3 CA          DEX                    ;|
$82:85E4 CA          DEX                    ;|
$82:85E5 10 F9       BPL $F9    [$85E0]     ;/
$82:85E7 E2 20       SEP #$20
$82:85E9 64 6E       STZ $6E    [$7E:006E]  ;\
$82:85EB 64 71       STZ $71    [$7E:0071]  ;} Disable colour math
$82:85ED A9 10       LDA #$10               ;\
$82:85EF 85 69       STA $69    [$7E:0069]  ;} Main screen layers = sprites
$82:85F1 64 6B       STZ $6B    [$7E:006B]  ; Disable subscreen layers
$82:85F3 64 6C       STZ $6C    [$7E:006C]  ;\
$82:85F5 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area
$82:85F7 C2 20       REP #$20               ; >_<;
$82:85F9 28          PLP
$82:85FA 60          RTS
}


;;; $85FB: Game state 2Ch (transition from demo) ;;;
{
$82:85FB 08          PHP
$82:85FC C2 30       REP #$30
$82:85FE A9 01 00    LDA #$0001             ;\
$82:8601 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 1 (opening)
$82:8604 AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$82:8607 30 26       BMI $26    [$862F]     ;} If [$0DEC] & 8000h != 0: go to BRANCH_NEXT_DEMO_SCENE
$82:8609 D0 12       BNE $12    [$861D]     ; If [$0DEC] = 0:
$82:860B A9 00 00    LDA #$0000             ;\
$82:860E 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$82:8612 9C F5 05    STZ $05F5  [$7E:05F5]  ; Enable sounds
$82:8615 A9 68 9B    LDA #$9B68             ;\
$82:8618 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $9B68 (title sequence)
$82:861B 28          PLP
$82:861C 60          RTS                    ; Return

$82:861D 22 87 9B 8B JSL $8B9B87[$8B:9B87]  ; Load title sequence graphics
$82:8621 A9 02 00    LDA #$0002             ;\
$82:8624 8D 53 1A    STA $1A53  [$7E:1A53]  ;} Demo timer = 2
$82:8627 A9 47 9A    LDA #$9A47             ;\
$82:862A 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = RTS
$82:862D 28          PLP
$82:862E 60          RTS                    ; Return

; BRANCH_NEXT_DEMO_SCENE
$82:862F A9 28 00    LDA #$0028             ;\
$82:8632 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 28h (transition to demo)
$82:8635 28          PLP
$82:8636 60          RTS
}


;;; $8637: Check for next demo ;;;
{
$82:8637 08          PHP
$82:8638 C2 30       REP #$30
$82:863A AD 57 1F    LDA $1F57  [$7E:1F57]  ;\
$82:863D 0A          ASL A                  ;|
$82:863E 0A          ASL A                  ;|
$82:863F 0A          ASL A                  ;|
$82:8640 6D 57 1F    ADC $1F57  [$7E:1F57]  ;|
$82:8643 0A          ASL A                  ;|
$82:8644 85 12       STA $12    [$7E:0012]  ;|
$82:8646 AD 55 1F    LDA $1F55  [$7E:1F55]  ;} A = [[$876C + [demo set] * 2] + [demo scene] * 12h]
$82:8649 0A          ASL A                  ;|
$82:864A AA          TAX                    ;|
$82:864B BD 6C 87    LDA $876C,x[$82:876C]  ;|
$82:864E 18          CLC                    ;|
$82:864F 65 12       ADC $12    [$7E:0012]  ;|
$82:8651 AA          TAX                    ;|
$82:8652 BD 00 00    LDA $0000,x[$82:8786]  ;/
$82:8655 C9 FF FF    CMP #$FFFF             ;\
$82:8658 D0 17       BNE $17    [$8671]     ;} If [A] != FFFFh: go to BRANCH_NEXT_DEMO_SCENE
$82:865A 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; $0DEC = 0
$82:865D AD 55 1F    LDA $1F55  [$7E:1F55]  ;\
$82:8660 1A          INC A                  ;|
$82:8661 CD 59 1F    CMP $1F59  [$7E:1F59]  ;|
$82:8664 90 03       BCC $03    [$8669]     ;} Demo set = (demo set + 1) % [number of demo sets]
$82:8666 A9 00 00    LDA #$0000             ;|
                                            ;|
$82:8669 8D 55 1F    STA $1F55  [$7E:1F55]  ;/
$82:866C 9C 57 1F    STZ $1F57  [$7E:1F57]  ; Demo scene = 0
$82:866F 28          PLP
$82:8670 60          RTS

; BRANCH_NEXT_DEMO_SCENE
$82:8671 A9 00 80    LDA #$8000             ;\
$82:8674 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;} $0DEC = 8000h
$82:8677 28          PLP
$82:8678 60          RTS
}


;;; $8679: Load demo room data ;;;
{
$82:8679 08          PHP
$82:867A C2 30       REP #$30
$82:867C 9C 8D 07    STZ $078D  [$7E:078D]  ; Door pointer = 0
$82:867F AD 57 1F    LDA $1F57  [$7E:1F57]  ;\
$82:8682 0A          ASL A                  ;|
$82:8683 0A          ASL A                  ;|
$82:8684 0A          ASL A                  ;|
$82:8685 6D 57 1F    ADC $1F57  [$7E:1F57]  ;|
$82:8688 0A          ASL A                  ;|
$82:8689 85 12       STA $12    [$7E:0012]  ;|
$82:868B AD 55 1F    LDA $1F55  [$7E:1F55]  ;} X = [$876C + [demo set] * 2] + [demo scene] * 12h
$82:868E 0A          ASL A                  ;|
$82:868F AA          TAX                    ;|
$82:8690 BD 6C 87    LDA $876C,x[$82:876C]  ;|
$82:8693 18          CLC                    ;|
$82:8694 65 12       ADC $12    [$7E:0012]  ;|
$82:8696 AA          TAX                    ;/
$82:8697 BD 00 00    LDA $0000,x[$82:8774]  ;\
$82:869A 8D 9B 07    STA $079B  [$7E:079B]  ;} Room pointer = [[X]]
$82:869D BD 02 00    LDA $0002,x[$82:8776]  ;\
$82:86A0 8D 8D 07    STA $078D  [$7E:078D]  ;} Door pointer = [[X] + 2]
$82:86A3 BD 04 00    LDA $0004,x[$82:8778]  ;\
$82:86A6 8D 8F 07    STA $078F  [$7E:078F]  ;} Door BTS = [[X] + 4]
$82:86A9 BD 06 00    LDA $0006,x[$82:877A]  ;\
$82:86AC 8D 11 09    STA $0911  [$7E:0911]  ;} Layer 1 X position = BG1 X offset = [[X] + 6]
$82:86AF 8D 1D 09    STA $091D  [$7E:091D]  ;/
$82:86B2 BD 08 00    LDA $0008,x[$82:877C]  ;\
$82:86B5 8D 15 09    STA $0915  [$7E:0915]  ;} Layer 1 Y position = BG1 Y offset = [[X] + 8]
$82:86B8 8D 1F 09    STA $091F  [$7E:091F]  ;/
$82:86BB BD 0A 00    LDA $000A,x[$82:877E]  ;\
$82:86BE 18          CLC                    ;|
$82:86BF 6D 15 09    ADC $0915  [$7E:0915]  ;} Samus previous Y position = Samus Y position = [layer 1 Y position] + [[X] + Ah]
$82:86C2 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;|
$82:86C5 8D 14 0B    STA $0B14  [$7E:0B14]  ;/
$82:86C8 AD 11 09    LDA $0911  [$7E:0911]  ;\
$82:86CB 18          CLC                    ;|
$82:86CC 69 80 00    ADC #$0080             ;|
$82:86CF 18          CLC                    ;} Samus previous X position = Samus X position = [layer 1 X position] + 80h + [[X] + Ch]
$82:86D0 7D 0C 00    ADC $000C,x[$82:8780]  ;|
$82:86D3 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;|
$82:86D6 8D 10 0B    STA $0B10  [$7E:0B10]  ;/
$82:86D9 BD 0E 00    LDA $000E,x[$82:8782]  ;\
$82:86DC 8D 53 1F    STA $1F53  [$7E:1F53]  ;} Demo timer = [[X] + Eh]
$82:86DF 8B          PHB                    ;\
$82:86E0 E2 20       SEP #$20               ;|
$82:86E2 A9 8F       LDA #$8F               ;|
$82:86E4 48          PHA                    ;|
$82:86E5 AB          PLB                    ;|
$82:86E6 AE 9B 07    LDX $079B  [$8F:079B]  ;} Set area from room header
$82:86E9 BD 01 00    LDA $0001,x[$8F:91F9]  ;|
$82:86EC 8D 9F 07    STA $079F  [$8F:079F]  ;|
$82:86EF C2 20       REP #$20               ;|
$82:86F1 AB          PLB                    ;/
$82:86F2 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$82:86F4 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$82:86F6 EE 57 1F    INC $1F57  [$7E:1F57]  ; Increment demo scene
$82:86F9 A2 00 00    LDX #$0000             ;\
                                            ;|
$82:86FC A9 FF FF    LDA #$FFFF             ;|
$82:86FF 9F 30 D8 7E STA $7ED830,x[$7E:D830];|
$82:8703 9F 70 D8 7E STA $7ED870,x[$7E:D870];|
$82:8707 9F F0 D8 7E STA $7ED8F0,x[$7E:D8F0];|
$82:870B 9F 08 D9 7E STA $7ED908,x[$7E:D908];|
$82:870F 9F F8 D8 7E STA $7ED8F8,x[$7E:D8F8];|
$82:8713 9F 00 D9 7E STA $7ED900,x[$7E:D900];|
$82:8717 A9 00 00    LDA #$0000             ;|
$82:871A 9F B0 D8 7E STA $7ED8B0,x[$7E:D8B0];|
$82:871E 9F 20 D8 7E STA $7ED820,x[$7E:D820];|
$82:8722 9F 28 D8 7E STA $7ED828,x[$7E:D828];|
$82:8726 E8          INX                    ;} Set all item / map station / save station / elevator bits
$82:8727 E8          INX                    ;} Clear all door / event / boss bits
$82:8728 E0 08 00    CPX #$0008             ;|
$82:872B 30 CF       BMI $CF    [$86FC]     ;|
                                            ;|
$82:872D A9 FF FF    LDA #$FFFF             ;|
$82:8730 9F 30 D8 7E STA $7ED830,x[$7E:D838];|
$82:8734 9F 70 D8 7E STA $7ED870,x[$7E:D878];|
$82:8738 A9 00 00    LDA #$0000             ;|
$82:873B 9F B0 D8 7E STA $7ED8B0,x[$7E:D8B8];|
$82:873F E8          INX                    ;|
$82:8740 E8          INX                    ;|
$82:8741 E0 40 00    CPX #$0040             ;|
$82:8744 30 E7       BMI $E7    [$872D]     ;/
$82:8746 A9 00 00    LDA #$0000             ;\
$82:8749 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:874C 9F 52 CD 7E STA $7ECD52,x[$7E:CD52];|
$82:8750 E8          INX                    ;} Clear map data (not including Ceres or debug area)
$82:8751 E8          INX                    ;|
$82:8752 E0 00 06    CPX #$0600             ;|
$82:8755 30 F5       BMI $F5    [$874C]     ;/
$82:8757 A9 00 00    LDA #$0000
$82:875A 8D D4 09    STA $09D4  [$7E:09D4]  ; Max reserve health = 0
$82:875D 8D D6 09    STA $09D6  [$7E:09D6]  ; Reserve health = 0
$82:8760 8D C0 09    STA $09C0  [$7E:09C0]  ; Reserve health mode = not obtained
$82:8763 8F 14 D9 7E STA $7ED914[$7E:D914]  ; Loading game state = 0 (intro)
$82:8767 8D F7 05    STA $05F7  [$7E:05F7]  ; Enable mini-map
$82:876A 28          PLP
$82:876B 60          RTS
}


;;; $876C: Demo room data ;;;
{
; Pointers to demo room data
$82:876C             dw 8774, 87E2, 8850, 88BE

;                        ___________________________________________________ Room pointer
;                       |      _____________________________________________ Door pointer
;                       |     |      _______________________________________ Door slot
;                       |     |     |      _________________________________ Screen X position
;                       |     |     |     |      ___________________________ Screen Y position
;                       |     |     |     |     |      _____________________ Samus Y offset from top of screen
;                       |     |     |     |     |     |      _______________ Samus X offset from centre of screen
;                       |     |     |     |     |     |     |      _________ Length of demo
;                       |     |     |     |     |     |     |     |      ___ Pointer to code
;                       |     |     |     |     |     |     |     |     |
$82:8774             dw 91F8, 896A, 0001, 0400, 0400, 0040, 0001, 04D3, 8925, ; Landing site
                        9F11, 8EAA, 0001, 0000, 0000, 006B, FFD2, 0151, 8924, ; Missile door
                        9D9C, 8DC6, 0000, 0100, 0000, 00BB, FFE0, 017A, 8924, ; Pre Spore Spawn hall
                        B106, 970E, 0000, 0700, 0000, 008B, 0048, 01A4, 8924, ; Speed booster
                        AFFB, 9792, 0001, 0000, 0000, 008B, FFC2, 01BC, 8924, ; Grapple beam
                        9D19, 8E7A, 0000, 0200, 0600, 0099, 0027, 0265, 891A, ; Pseudo screw attack
                        FFFF

$82:87E2             dw A408, A36C, 0000, 0100, 0100, 008B, 0056, 01FD, 8924, ; Ice beam
                        9C5E, 8CCA, 0003, 0200, 0000, 008B, 0049, 019A, 8924, ; Fireflea room
                        9E52, 8DEA, 0003, 0500, 0300, 00AB, FFE2, 0117, 8924, ; Brinstar diagonal room
                        AF14, 967E, 0002, 0300, 0000, 008B, 004B, 03CA, 8924, ; Lower Norfair entrance
                        9879, 8982, 0003, 0000, 0000, 00BB, FFF1, 00D5, 8924, ; Screw attack
                        9CB3, 8DD2, 0001, 0400, 0200, 0080, 0005, 0317, 8924, ; Dachora
                        FFFF

$82:8850             dw CC6F, A21C, 0003, 0200, 0000, 0060, 0004, 02EF, 8924, ; Pre Phantoon hall
                        91F8, 896A, 0001, 0300, 0400, 00B0, 0000, 00C7, 8925, ; Shinespark
                        A56B, 919E, 0001, 0000, 0100, 008B, FFD2, 02D3, 8924, ; Eye door
                        A322, 90EA, 0000, 0000, 0700, 008B, FFAA, 0164, 8924, ; Red Brinstar -> Crateria elevator
                        A59F, 91B6, 0001, 0000, 0100, 008B, FFBF, 013F, 892B, ; Kraid
                        A66A, 91F2, 0001, 0000, 0000, 008B, FFB1, 0197, 8932, ; Tourian entrance
                        FFFF

$82:88BE             dw 91F8, 890A, 0000, 0600, 0200, 0080, 0030, 0100, 8925, ; Gauntlet entrance
                        D0B9, A474, 0000, 0200, 0000, 00AB, 0000, 0332, 8924, ; Advanced grapple beam
                        91F8, 890A, 0000, 0600, 0200, 007B, 0020, 0185, 8925, ; IBJ
                        9AD9, 8D42, 0001, 0000, 0400, 008B, FFB7, 018A, 8924, ; SBA
                        91F8, 890A, 0000, 0600, 0200, 008B, 0004, 0200, 8925, ; Crystal flash
                        FFFF
}


;;; $891A: Demo room code - charge beam room: scroll 21h = red ;;;
{
$82:891A E2 20       SEP #$20
$82:891C A9 00       LDA #$00
$82:891E 8F 41 CD 7E STA $7ECD41[$7E:CD41]
$82:8922 C2 20       REP #$20
$82:8924 60          RTS
}


;;; $8925: Demo room code - landing site: BG2 tilemap base address = $4800, BG2 tilemap size = 32x64 ;;;
{
$82:8925 A9 4A 00    LDA #$004A
$82:8928 85 59       STA $59    [$7E:0059]
$82:892A 60          RTS
}


;;; $892B: Demo room code - Kraid - Kraid function timer = 60 ;;;
{
$82:892B A9 3C 00    LDA #$003C
$82:892E 8D B2 0F    STA $0FB2  [$7E:0FB2]
$82:8931 60          RTS
}


;;; $8932: Demo room code - Tourian entrance - Brinstar boss bits = Kraid is dead ;;;
{
$82:8932 E2 20       SEP #$20
$82:8934 A9 01       LDA #$01
$82:8936 8F 29 D8 7E STA $7ED829[$7E:D829]
$82:893A C2 20       REP #$20
$82:893C 60          RTS
}
}


;;; $893D: Main game loop ;;;
{
$82:893D 4B          PHK                    ;\
$82:893E AB          PLB                    ;} DB = $82
$82:893F C2 20       REP #$20
$82:8941 9C 98 09    STZ $0998  [$7E:0998]  ; Game state = 0 (reset/start)
$82:8944 9C F4 0D    STZ $0DF4  [$7E:0DF4]  ; Spare CPU display flag = 0
$82:8947 58          CLI                    ; Enable IRQ

; LOOP
$82:8948 08          PHP
$82:8949 C2 30       REP #$30
$82:894B 22 B9 84 88 JSL $8884B9[$88:84B9]  ; HDMA object handler (also handle music queue)
$82:894F 22 11 81 80 JSL $808111[$80:8111]  ; Generate new random number
$82:8953 22 1A 8B 80 JSL $808B1A[$80:8B1A]  ; Clear high OAM
$82:8957 9C 90 05    STZ $0590  [$7E:0590]  ; OAM stack pointer = 0
$82:895A 9C 1D 07    STZ $071D  [$7E:071D]  ; Clear Samus tiles transfer flags
$82:895D 9C 1F 07    STZ $071F  [$7E:071F]  ; Samus top half tiles definition = 0
$82:8960 9C 21 07    STZ $0721  [$7E:0721]  ; Samus bottom half tiles definition = 0
$82:8963 AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:8966 29 FF 00    AND #$00FF             ;|
$82:8969 0A          ASL A                  ;} Execute [$8981 + [game state] * 2]
$82:896A AA          TAX                    ;|
$82:896B FC 81 89    JSR ($8981,x)[$82:8AE4];/
$82:896E 22 EF 89 82 JSL $8289EF[$82:89EF]  ; Handle sound effects
$82:8972 22 6E 89 80 JSL $80896E[$80:896E]  ; Finalise OAM
$82:8976 22 B0 8A 82 JSL $828AB0[$82:8AB0]  ; Show spare CPU (debug) and update previous controller 1 input
$82:897A 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$82:897E 28          PLP
$82:897F 80 C7       BRA $C7    [$8948]     ; Go to LOOP

$82:8981             dw 8AE4, 8B08, EB9F, 8B0D, 89E5, 89EA, 8000, 8B20, 8B44, E169, E1B7, E288, 8CCF, 8CEF, 90C8, 90E8,
                        9324, 9367, 93A1, DC80, DCE0, DD71, DD87, DD9A, DDAF, DDC7, 89E0, DC10, 8B3F, 89DB, 8B0E, 8000,
                        8367, 8388, 8B0E, 8411, 8431, 8B0E, 84BD, 8B13, 8000, 852D, 8548, 8593, 85FB
}


;;; $89DB: Game state 1Dh (debug game over menu) ;;;
{
$82:89DB 22 F4 8C 81 JSL $818CF4[$81:8CF4]
$82:89DF 60          RTS
}


;;; $89E0: Game state 1Ah (game over screen) ;;;
{
$82:89E0 22 AE 90 81 JSL $8190AE[$81:90AE]
$82:89E4 60          RTS
}


;;; $89E5: Game state 4 (file select menus) ;;;
{
$82:89E5 22 FB 93 81 JSL $8193FB[$81:93FB]
$82:89E9 60          RTS
}


;;; $89EA: Game state 5 (file select map) ;;;
{
$82:89EA 22 3E 9E 81 JSL $819E3E[$81:9E3E]
$82:89EE 60          RTS
}


;;; $89EF..8AAF: Handle sounds ;;;
{
;;; $89EF: Handle sounds ;;;
{
$82:89EF 08          PHP
$82:89F0 E2 30       SEP #$30
$82:89F2 AD 86 06    LDA $0686  [$7E:0686]  ;\
$82:89F5 3A          DEC A                  ;} If [sound handler downtime] > 0: go to BRANCH_DOWNTIME
$82:89F6 10 13       BPL $13    [$8A0B]     ;/
$82:89F8 A0 00       LDY #$00               ; Y = 0 (sound library index)

; LOOP
$82:89FA 5A          PHY
$82:89FB B9 49 06    LDA $0649,y[$7E:0649]  ;\
$82:89FE 0A          ASL A                  ;|
$82:89FF AA          TAX                    ;} Execute [$8A22 + [sound state] * 2]
$82:8A00 FC 22 8A    JSR ($8A22,x)[$82:8A2C];/
$82:8A03 7A          PLY
$82:8A04 C8          INY                    ; Increment Y
$82:8A05 C0 03       CPY #$03               ;\
$82:8A07 90 F1       BCC $F1    [$89FA]     ;} If [Y] < 3: go to LOOP
$82:8A09 28          PLP
$82:8A0A 6B          RTL                    ; Return

; BRANCH_DOWNTIME
$82:8A0B 8D 86 06    STA $0686  [$7E:0686]  ; Decrement sound handler downtime
$82:8A0E 9C 41 21    STZ $2141  [$7E:2141]  ;\
$82:8A11 9C 4D 06    STZ $064D  [$7E:064D]  ;} APU IO 1 = current sound 1 = 0
$82:8A14 9C 42 21    STZ $2142  [$7E:2142]  ;\
$82:8A17 9C 4E 06    STZ $064E  [$7E:064E]  ;} APU IO 2 = current sound 2 = 0
$82:8A1A 9C 43 21    STZ $2143  [$7E:2143]  ;\
$82:8A1D 9C 4F 06    STZ $064F  [$7E:064F]  ;} APU IO 3 = current sound 3 = 0
$82:8A20 28          PLP
$82:8A21 6B          RTL

$82:8A22             dw 8A2C, 8A55, 8A6C, 8A7C, 8A90
}


;;; $8A2C: Sound state 0 - send APU sound request from queue ;;;
{
;; Parameter:
;;     Y: Sound library index to process queue of
$82:8A2C BB          TYX
$82:8A2D BD 43 06    LDA $0643,x[$7E:0643]  ;\
$82:8A30 DD 46 06    CMP $0646,x[$7E:0646]  ;} If [sound queue start index] = [sound queue next index]: return
$82:8A33 F0 1C       BEQ $1C    [$8A51]     ;/
$82:8A35 BF 52 8A 82 LDA $828A52,x[$82:8A54];\
$82:8A39 18          CLC                    ;|
$82:8A3A 7D 43 06    ADC $0643,x[$7E:0645]  ;|
$82:8A3D A8          TAY                    ;} APU IO 1 + [Y] = current sound = [sound queue + [sound queue start index]]
$82:8A3E B9 56 06    LDA $0656,y[$7E:0676]  ;|
$82:8A41 9D 41 21    STA $2141,x[$7E:2143]  ;|
$82:8A44 9D 4D 06    STA $064D,x[$7E:064F]  ;/
$82:8A47 C8          INY                    ;\
$82:8A48 98          TYA                    ;|
$82:8A49 29 0F       AND #$0F               ;} Sound queue start index = ([sound queue start index] + 1) % 10h
$82:8A4B 9D 43 06    STA $0643,x[$7E:0645]  ;/
$82:8A4E FE 49 06    INC $0649,x[$7E:064B]  ; Sound state = 1

$82:8A51 60          RTS

$82:8A52             db 00, 10, 20
}


;;; $8A55: Sound state 1 - wait for APU sound request acknowledgement ;;;
{
;; Parameter:
;;     Y: Sound library index to process queue of
$82:8A55 BB          TYX
$82:8A56 BD 4D 06    LDA $064D,x[$7E:064F]  ;\
$82:8A59 DD 41 21    CMP $2141,x[$7E:2143]  ;} If [APU IO 1 + [Y]] != [current sound]:
$82:8A5C F0 05       BEQ $05    [$8A63]     ;/
$82:8A5E 9D 41 21    STA $2141,x[$7E:2143]  ; APU IO 1 + [Y] = [current sound]
$82:8A61 80 08       BRA $08    [$8A6B]     ; Return

$82:8A63 FE 49 06    INC $0649,x[$7E:064B]  ; Sound state = 2
$82:8A66 A9 02       LDA #$02               ;\
$82:8A68 9D 50 06    STA $0650,x[$7E:0652]  ;} Delay before clearing sound = 2

$82:8A6B 60          RTS
}


;;; $8A6C: Sound state 2 - clear sound request ;;;
{
;; Parameter:
;;     Y: Sound library index to process queue of

; This delay is needed, but I have no idea why, screws up door transition though otherwise
$82:8A6C BB          TYX
$82:8A6D DE 50 06    DEC $0650,x[$7E:0652]  ; Decrement delay before clearing sound
$82:8A70 D0 09       BNE $09    [$8A7B]     ; If [delay before clearing sound] = 0:
$82:8A72 9E 41 21    STZ $2141,x[$7E:2143]  ; APU IO 1 + [Y] = 0
$82:8A75 9E 4D 06    STZ $064D,x[$7E:064F]  ; Current sound = 0
$82:8A78 FE 49 06    INC $0649,x[$7E:064B]  ; Sound state = 3

$82:8A7B 60          RTS
}


;;; $8A7C: Sound state 3 - wait for APU clear request acknowledgement ;;;
{
;; Parameter:
;;     Y: Sound library index to process queue of
$82:8A7C BB          TYX
$82:8A7D BD 4D 06    LDA $064D,x[$7E:064F]  ;\
$82:8A80 DD 41 21    CMP $2141,x[$7E:2143]  ;} If [APU IO 1 + [Y]] != [current sound]:
$82:8A83 F0 05       BEQ $05    [$8A8A]     ;/
$82:8A85 9D 41 21    STA $2141,x[$7E:2143]  ; APU IO 1 + [Y] = [current sound]
$82:8A88 80 05       BRA $05    [$8A8F]     ; Return

$82:8A8A 9E 49 06    STZ $0649,x[$7E:064B]  ; Sound state = 0
$82:8A8D 80 9D       BRA $9D    [$8A2C]     ; Process sound from sound queue

$82:8A8F 60          RTS
}


;;; $8A90: Sound state 4 - reset sound state ;;;
{
;; Parameter:
;;     Y: Sound library index to process queue of
$82:8A90 BB          TYX
$82:8A91 DE 50 06    DEC $0650,x            ; Decrement delay before clearing sound
$82:8A94 D0 03       BNE $03    [$8A99]     ; If [delay before clearing sound] = 0:
$82:8A96 9E 49 06    STZ $0649,x            ; Sound state = 0

$82:8A99 60          RTS
}


;;; $8A9A: Reset sound queues ;;;
{
$82:8A9A 08          PHP
$82:8A9B C2 20       REP #$20
$82:8A9D 9C 43 06    STZ $0643  [$7E:0643]
$82:8AA0 9C 45 06    STZ $0645  [$7E:0645]
$82:8AA3 9C 47 06    STZ $0647  [$7E:0647]
$82:8AA6 9C 49 06    STZ $0649  [$7E:0649]
$82:8AA9 E2 20       SEP #$20
$82:8AAB 9C 4B 06    STZ $064B  [$7E:064B]
$82:8AAE 28          PLP
$82:8AAF 6B          RTL
}
}


;;; $8AB0: Show spare CPU (debug) and update previous controller 1 input ;;;
{
; Lowers the brightness to show remaining v-draw time graphically
$82:8AB0 08          PHP
$82:8AB1 C2 30       REP #$30
$82:8AB3 AD C5 05    LDA $05C5  [$7E:05C5]  ;\
$82:8AB6 29 00 40    AND #$4000             ;} If newly pressed Y whilst select + L is pressed (and debug enabled):
$82:8AB9 F0 10       BEQ $10    [$8ACB]     ;/
$82:8ABB AD F4 0D    LDA $0DF4  [$7E:0DF4]  ;\
$82:8ABE D0 08       BNE $08    [$8AC8]     ;|
$82:8AC0 A9 01 00    LDA #$0001             ;|
$82:8AC3 8D F4 0D    STA $0DF4  [$7E:0DF4]  ;} Toggle spare CPU display flag
$82:8AC6 80 03       BRA $03    [$8ACB]     ;|
                                            ;|
$82:8AC8 9C F4 0D    STZ $0DF4  [$7E:0DF4]  ;/

$82:8ACB AD F4 0D    LDA $0DF4  [$7E:0DF4]  ;\
$82:8ACE F0 0D       BEQ $0D    [$8ADD]     ;} If [spare CPU display flag] != 0:
$82:8AD0 E2 20       SEP #$20
$82:8AD2 A5 51       LDA $51    [$7E:0051]  ;\
$82:8AD4 29 F0       AND #$F0               ;|
$82:8AD6 09 05       ORA #$05               ;} Brightness = 6 / 10h
$82:8AD8 8D 00 21    STA $2100  [$7E:2100]  ;/
$82:8ADB C2 20       REP #$20

$82:8ADD A5 8B       LDA $8B    [$7E:008B]  ;\
$82:8ADF 8D FE 0D    STA $0DFE  [$7E:0DFE]  ;} Previous controller 1 input = [controller 1 input]
$82:8AE2 28          PLP
$82:8AE3 6B          RTL
}


;;; $8AE4: Game state 0 (reset/start) ;;;
{
$82:8AE4 9C F8 0D    STZ $0DF8  [$7E:0DF8]  ; $0DF8 = 0
$82:8AE7 9C FA 0D    STZ $0DFA  [$7E:0DFA]  ; $0DFA = 0
$82:8AEA 9C FC 0D    STZ $0DFC  [$7E:0DFC]  ; $0DFC = 0
$82:8AED A9 68 9B    LDA #$9B68             ;\
$82:8AF0 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $9B68
$82:8AF3 9C 55 1F    STZ $1F55  [$7E:1F55]  ; Demo set = 0
$82:8AF6 AD 59 1F    LDA $1F59  [$7E:1F59]  ;\
$82:8AF9 C9 04 00    CMP #$0004             ;} If [number of demo sets] = 4:
$82:8AFC D0 06       BNE $06    [$8B04]     ;/
$82:8AFE A9 03 00    LDA #$0003             ;\
$82:8B01 8D 55 1F    STA $1F55  [$7E:1F55]  ;} Demo set = 3 (play the newly unlocked demo first)

$82:8B04 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 1 (opening)
$82:8B07 60          RTS
}


;;; $8B08: Game state 1 (opening) ;;;
{
; Opening
$82:8B08 22 22 9A 8B JSL $8B9A22[$8B:9A22]
$82:8B0C 60          RTS
}


;;; $8B0D: Game state 3 (nothing) ;;;
{
$82:8B0D 60          RTS
}


;;; $8B0E: Game state 1Eh/22h/25h (intro / Ceres goes boom, Samus goes to Zebes / Ceres goes boom with Samus) ;;;
{
$82:8B0E 22 5B A3 8B JSL $8BA35B[$8B:A35B]
$82:8B12 60          RTS
}


;;; $8B13: Game state 27h (ending and credits) ;;;
{
$82:8B13 22 43 D4 8B JSL $8BD443[$8B:D443]
$82:8B17 60          RTS
}


;;; $8B18: Unused. Increment game state ;;;
{
$82:8B18 08          PHP
$82:8B19 C2 30       REP #$30
$82:8B1B EE 98 09    INC $0998  [$7E:0998]
$82:8B1E 28          PLP
$82:8B1F 60          RTS
}


;;; $8B20: Game state 7 (main gameplay fading in) ;;;
{
$82:8B20 08          PHP
$82:8B21 C2 30       REP #$30
$82:8B23 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:8B26 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$82:8B2A E2 20       SEP #$20
$82:8B2C A5 51       LDA $51    [$7E:0051]  ;\
$82:8B2E C9 0F       CMP #$0F               ;} If not finished fading in: return
$82:8B30 D0 0B       BNE $0B    [$8B3D]     ;/
$82:8B32 C2 20       REP #$20
$82:8B34 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:8B37 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:8B3A EE 98 09    INC $0998  [$7E:0998]  ; Game state = 8 (main gameplay)

$82:8B3D 28          PLP
$82:8B3E 60          RTS
}


;;; $8B3F: Game state 1Ch (unused) ;;;
{
$82:8B3F 22 DA D4 91 JSL $91D4DA[$91:D4DA]
$82:8B43 60          RTS
}


;;; $8B44: Game state 8 (main gameplay) ;;;
{
$82:8B44 08          PHP
$82:8B45 C2 30       REP #$30
$82:8B47 22 B6 8E A0 JSL $A08EB6[$A0:8EB6]  ; Determine which enemies to process
$82:8B4B 22 09 98 B4 JSL $B49809[$B4:9809]  ; Debug handler
$82:8B4F 29 FF FF    AND #$FFFF             ;\
$82:8B52 D0 4C       BNE $4C    [$8BA0]     ;} If [A] != 0: go to BRANCH_SKIP_PROCESSING
$82:8B54 22 27 C5 8D JSL $8DC527[$8D:C527]  ; Palette FX object handler
$82:8B58 22 92 E6 90 JSL $90E692[$90:E692]  ; JSR ($0A42) - handles controller input for game physics
$82:8B5C AD 12 0E    LDA $0E12  [$7E:0E12]  ;\
$82:8B5F D0 04       BNE $04    [$8B65]     ;} If sprite interactions enabled:
$82:8B61 22 85 97 A0 JSL $A09785[$A0:9785]  ; Samus / projectile interaction handler

$82:8B65 22 D4 8F A0 JSL $A08FD4[$A0:8FD4]  ; Main enemy routine
$82:8B69 22 22 E7 90 JSL $90E722[$90:E722]  ; Handles Samus movements and pausing? JSR ($0A44)
$82:8B6D 22 04 81 86 JSL $868104[$86:8104]  ; Enemy projectile handler
$82:8B71 22 B4 85 84 JSL $8485B4[$84:85B4]  ; PLM handler
$82:8B75 22 64 80 87 JSL $878064[$87:8064]  ; Animated tiles objects handler
$82:8B79 AD 12 0E    LDA $0E12  [$7E:0E12]  ;\
$82:8B7C D0 0C       BNE $0C    [$8B8A]     ;} If sprite interactions enabled:
$82:8B7E 22 94 98 A0 JSL $A09894[$A0:9894]  ; Enemy projectile / Samus collision detection
$82:8B82 22 6C 99 A0 JSL $A0996C[$A0:996C]  ; Enemy projectile / projectile detection
$82:8B86 22 06 A3 A0 JSL $A0A306[$A0:A306]  ; Process enemy power bomb interaction

$82:8B8A 22 EC 94 90 JSL $9094EC[$90:94EC]  ; Main scrolling routine
$82:8B8E AF 06 80 80 LDA $808006[$80:8006]  ;\
$82:8B92 F0 04       BEQ $04    [$8B98]     ;} If debug scrolling enabled:
$82:8B94 22 AC A9 80 JSL $80A9AC[$80:A9AC]  ; Debug scrolling position saving/loading

$82:8B98 22 4D 88 A0 JSL $A0884D[$A0:884D]  ; Draw Samus, projectiles, enemies and enemy projectiles
$82:8B9C 22 26 97 A0 JSL $A09726[$A0:9726]  ; Handle queuing enemy BG2 tilemap VRAM transfer

; BRANCH_SKIP_PROCESSING
$82:8BA0 22 44 9B 80 JSL $809B44[$80:9B44]  ; Handle HUD tilemap
$82:8BA4 22 AB A3 80 JSL $80A3AB[$80:A3AB]  ; Calculate layer 2 position and BG scrolls and update BG graphics when scrolling
$82:8BA8 22 BD E8 8F JSL $8FE8BD[$8F:E8BD]  ; Execute room main ASM
$82:8BAC 20 69 DB    JSR $DB69  [$82:DB69]  ; Handle Samus running out of health and increment game time
$82:8BAF 22 87 86 A0 JSL $A08687[$A0:8687]  ; Handle room shaking
$82:8BB3 22 69 91 A0 JSL $A09169[$A0:9169]  ; Decrement Samus hurt timers and clear active enemy indices
$82:8BB7 28          PLP
$82:8BB8 60          RTS
}


;;; $8BB9..8CCE: Game options menu objects ;;;
{
;;; $8BB9: Delete game options menu objects ;;;
{
$82:8BB9 08          PHP
$82:8BBA C2 30       REP #$30
$82:8BBC A2 0E 00    LDX #$000E             ; X = Eh

; LOOP
$82:8BBF 9E 9D 1A    STZ $1A9D,x[$7E:1AAB]  ; Game options menu object spritemap pointer = 0
$82:8BC2 9E FD 1A    STZ $1AFD,x[$7E:1B0B]  ; Game options menu object instruction list pointer = 0
$82:8BC5 CA          DEX                    ;\
$82:8BC6 CA          DEX                    ;} X -= 2
$82:8BC7 10 F6       BPL $F6    [$8BBF]     ; If [X] >= 0: go to LOOP
$82:8BC9 28          PLP
$82:8BCA 60          RTS
}


;;; $8BCB: Spawn game options menu object ;;;
{
;; Parameters:
;;     A: Game options menu object initialisation parameter
;;     Y: Game options menu object ID
;; Returns:
;;     Carry: Set if enemy projectile could not be spawned

$82:8BCB 08          PHP
$82:8BCC C2 30       REP #$30
$82:8BCE DA          PHX
$82:8BCF 8D 93 1A    STA $1A93  [$7E:1A93]  ; Game options menu object initialisation parameter = [A]
$82:8BD2 BB          TYX                    ; X = [Y]
$82:8BD3 A0 0E 00    LDY #$000E             ; Y = Eh

; LOOP
$82:8BD6 B9 FD 1A    LDA $1AFD,y[$7E:1B0B]  ;\
$82:8BD9 F0 08       BEQ $08    [$8BE3]     ;} If [game options menu object instruction list pointer] != 0:
$82:8BDB 88          DEY                    ;\
$82:8BDC 88          DEY                    ;} Y -= 2
$82:8BDD 10 F7       BPL $F7    [$8BD6]     ; If [Y] >= 0: go to LOOP
$82:8BDF FA          PLX
$82:8BE0 28          PLP
$82:8BE1 38          SEC                    ;\
$82:8BE2 60          RTS                    ;} Return carry set

$82:8BE3 C2 30       REP #$30
$82:8BE5 BD 02 00    LDA $0002,x[$82:F4BA]  ;\
$82:8BE8 99 0D 1B    STA $1B0D,y[$7E:1B1B]  ;} Game options menu object pre-instruction = [[X] + 2]
$82:8BEB BD 04 00    LDA $0004,x[$82:F4BC]  ;\
$82:8BEE 99 FD 1A    STA $1AFD,y[$7E:1B0B]  ;} Game options menu object instruction list pointer = [[X] + 4]
$82:8BF1 A9 01 00    LDA #$0001             ;\
$82:8BF4 99 1D 1B    STA $1B1D,y[$7E:1B2B]  ;} Game options menu object instruction timer = 1
$82:8BF7 A9 00 00    LDA #$0000             ;\
$82:8BFA 99 9D 1A    STA $1A9D,y[$7E:1AAB]  ;} Game options menu object spritemap pointer = 0
$82:8BFD A9 00 00    LDA #$0000
$82:8C00 99 2D 1B    STA $1B2D,y[$7E:1B3B]  ; Game options menu object timer = 0
$82:8C03 99 DD 1A    STA $1ADD,y[$7E:1AEB]  ; Game options menu object $1ADD = 0
$82:8C06 99 ED 1A    STA $1AED,y[$7E:1AFB]  ; Game options menu object $1AED = 0
$82:8C09 FC 00 00    JSR ($0000,x)[$82:F296]; Execute [[X]]
$82:8C0C FA          PLX
$82:8C0D 28          PLP
$82:8C0E 18          CLC                    ;\
$82:8C0F 60          RTS                    ;} Return carry clear
}


;;; $8C10: RTS ;;;
{
$82:8C10 60          RTS
}


;;; $8C11: Game options menu object handler ;;;
{
$82:8C11 08          PHP
$82:8C12 C2 30       REP #$30
$82:8C14 A2 0E 00    LDX #$000E             ; X = Eh

; LOOP
$82:8C17 8E 8F 1A    STX $1A8F  [$7E:1A8F]  ; Game options menu object index = [X]
$82:8C1A BD FD 1A    LDA $1AFD,x[$7E:1B0B]  ;\
$82:8C1D F0 06       BEQ $06    [$8C25]     ;} If [game options menu object instruction list pointer] != 0:
$82:8C1F 20 2B 8C    JSR $8C2B  [$82:8C2B]  ; Process game options menu object
$82:8C22 AE 8F 1A    LDX $1A8F  [$7E:1A8F]  ; X = [game options menu object index]

$82:8C25 CA          DEX                    ;\
$82:8C26 CA          DEX                    ;} X -= 2
$82:8C27 10 EE       BPL $EE    [$8C17]     ; If [X] >= 0: go to LOOP
$82:8C29 28          PLP
$82:8C2A 60          RTS
}


;;; $8C2B: Process game options menu object ;;;
{
;; Parameter:
;;     X: Game options menu object index
$82:8C2B FC 0D 1B    JSR ($1B0D,x)[$82:F2A9]; Execute [game options menu object pre-instruction]
$82:8C2E AE 8F 1A    LDX $1A8F  [$7E:1A8F]
$82:8C31 DE 1D 1B    DEC $1B1D,x[$7E:1B2B]  ; Decrement game options menu object instruction timer
$82:8C34 D0 23       BNE $23    [$8C59]     ; If [game options menu object instruction timer] != 0: return
$82:8C36 BC FD 1A    LDY $1AFD,x[$7E:1B0B]  ; Y = [game options menu object instruction list pointer]

; LOOP
$82:8C39 B9 00 00    LDA $0000,y[$82:F442]  ;\
$82:8C3C 10 0A       BPL $0A    [$8C48]     ;} If [[Y]] is negative:
$82:8C3E 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]] (ASM instruction pointer)
$82:8C40 C8          INY                    ;\
$82:8C41 C8          INY                    ;} Y += 2
$82:8C42 F4 38 8C    PEA $8C38              ; Return to LOOP
$82:8C45 6C 12 00    JMP ($0012)[$82:8C6E]  ; Execute ASM instruction

$82:8C48 9D 1D 1B    STA $1B1D,x[$7E:1B2B]  ; Game options menu object instruction timer = [[Y]] (spritemap timer)
$82:8C4B B9 02 00    LDA $0002,y[$82:F444]  ;\
$82:8C4E 9D 9D 1A    STA $1A9D,x[$7E:1AAB]  ;} Game options menu object spritemap pointer = [[Y] + 2]
$82:8C51 98          TYA                    ;\
$82:8C52 18          CLC                    ;|
$82:8C53 69 04 00    ADC #$0004             ;} Game options menu object instruction list pointer = [Y] + 4
$82:8C56 9D FD 1A    STA $1AFD,x[$7E:1B0B]  ;/

$82:8C59 60          RTS
}


;;; $8C5A: Instruction - delete ;;;
{
$82:8C5A C2 30       REP #$30
$82:8C5C 9E 9D 1A    STZ $1A9D,x[$7E:1AA9]  ; Game options menu object spritemap pointer = 0
$82:8C5F 9E FD 1A    STZ $1AFD,x[$7E:1B09]  ; Game options menu object instruction list pointer = 0
$82:8C62 68          PLA                    ; Terminate processing game options menu object
$82:8C63 60          RTS
}


;;; $8C64: Instruction - sleep ;;;
{
$82:8C64 C2 30       REP #$30
$82:8C66 88          DEY                    ;\
$82:8C67 88          DEY                    ;|
$82:8C68 98          TYA                    ;} Game options menu object instruction list pointer = [Y] - 2
$82:8C69 9D FD 1A    STA $1AFD,x            ;/
$82:8C6C 68          PLA                    ; Terminate processing game options menu object
$82:8C6D 60          RTS
}


;;; $8C6E: Instruction - pre-instruction = [[Y]] ;;;
{
$82:8C6E C2 30       REP #$30
$82:8C70 B9 00 00    LDA $0000,y[$82:F484]
$82:8C73 9D 0D 1B    STA $1B0D,x[$7E:1B19]
$82:8C76 C8          INY
$82:8C77 C8          INY
$82:8C78 60          RTS
}


;;; $8C79: Instruction - clear pre-instruction ;;;
{
$82:8C79 C2 30       REP #$30
$82:8C7B A9 81 8C    LDA #$8C81             ;\
$82:8C7E 9D 0D 1B    STA $1B0D,x            ;} Game options menu object pre-instruction = RTS
$82:8C81 60          RTS
}


;;; $8C82: Instruction - go to [[Y]] ;;;
{
$82:8C82 C2 30       REP #$30
$82:8C84 B9 00 00    LDA $0000,y[$82:F454]
$82:8C87 A8          TAY
$82:8C88 60          RTS
}


;;; $8C89: Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
$82:8C89 C2 30       REP #$30
$82:8C8B DE 2D 1B    DEC $1B2D,x
$82:8C8E D0 F2       BNE $F2    [$8C82]
$82:8C90 C8          INY
$82:8C91 C8          INY
$82:8C92 60          RTS
}


;;; $8C93: Instruction - timer = [[Y]] ;;;
{
$82:8C93 C2 30       REP #$30
$82:8C95 B9 00 00    LDA $0000,y
$82:8C98 9D 2D 1B    STA $1B2D,x
$82:8C9B C8          INY
$82:8C9C C8          INY
$82:8C9D 60          RTS
}


;;; $8C9E: RTS ;;;
{
$82:8C9E C2 30       REP #$30
$82:8CA0 60          RTS
}


;;; $8CA1: Draw game options menu spritemaps ;;;
{
$82:8CA1 08          PHP
$82:8CA2 C2 30       REP #$30
$82:8CA4 8B          PHB
$82:8CA5 A2 0E 00    LDX #$000E             ; X = Eh

; LOOP
$82:8CA8 BD 9D 1A    LDA $1A9D,x[$7E:1AAB]  ;\
$82:8CAB F0 1B       BEQ $1B    [$8CC8]     ;} If [game options menu object spritemap pointer] != 0:
$82:8CAD F4 00 82    PEA $8200              ;\
$82:8CB0 AB          PLB                    ;} DB = $82
$82:8CB1 AB          PLB                    ;/
$82:8CB2 BC 9D 1A    LDY $1A9D,x[$7E:1AAB]  ; Y = [game options menu object spritemap pointer]
$82:8CB5 BD CD 1A    LDA $1ACD,x[$7E:1ADB]  ;\
$82:8CB8 85 16       STA $16    [$7E:0016]  ;} $16 = [game options menu object palette index]
$82:8CBA BD AD 1A    LDA $1AAD,x[$7E:1ABB]  ;\
$82:8CBD 85 14       STA $14    [$7E:0014]  ;} $14 = [game options menu object X position]
$82:8CBF BD BD 1A    LDA $1ABD,x[$7E:1ACB]  ;\
$82:8CC2 85 12       STA $12    [$7E:0012]  ;} $12 = [game options menu object Y position]
$82:8CC4 22 9F 87 81 JSL $81879F[$81:879F]  ; Add spritemap to OAM

$82:8CC8 CA          DEX                    ;\
$82:8CC9 CA          DEX                    ;} X -= 2
$82:8CCA 10 DC       BPL $DC    [$8CA8]     ; If [X] >= 0: go to LOOP
$82:8CCC AB          PLB
$82:8CCD 28          PLP
$82:8CCE 60          RTS
}
}


;;; $8CCF..BA34: Pause menu ;;;
{
;;; $8CCF: Game state Ch (pausing, normal gameplay but darkening) ;;;
{
$82:8CCF 08          PHP
$82:8CD0 C2 30       REP #$30
$82:8CD2 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:8CD5 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:8CD9 A5 51       LDA $51    [$7E:0051]  ;\
$82:8CDB 29 0F 00    AND #$000F             ;} If not finished fading out: return
$82:8CDE D0 0D       BNE $0D    [$8CED]     ;/
$82:8CE0 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:8CE4 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:8CE7 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:8CEA EE 98 09    INC $0998  [$7E:0998]  ; Game state = Dh (pausing, loading pause screen)

$82:8CED 28          PLP
$82:8CEE 60          RTS
}


;;; $8CEF: Game state Dh (pausing, loading pause screen) ;;;
{
$82:8CEF 08          PHP
$82:8CF0 C2 30       REP #$30
$82:8CF2 8B          PHB
$82:8CF3 4B          PHK                    ;\
$82:8CF4 AB          PLB                    ;} DB = $82
$82:8CF5 22 93 82 88 JSL $888293[$88:8293]  ; Disable HDMA objects
$82:8CF9 E2 20       SEP #$20               ;\
$82:8CFB A9 00       LDA #$00               ;|
$82:8CFD 85 85       STA $85    [$7E:0085]  ;} Disable HDMA
$82:8CFF 8D 0C 42    STA $420C  [$7E:420C]  ;|
$82:8D02 C2 20       REP #$20               ;/
$82:8D04 22 0B 80 87 JSL $87800B[$87:800B]  ; Disable animated tiles objects
$82:8D08 20 51 8D    JSR $8D51  [$82:8D51]  ; Back up BG2 tilemap for pause menu
$82:8D0B 08          PHP                    ;\
$82:8D0C 8B          PHB                    ;|
$82:8D0D 4B          PHK                    ;|
$82:8D0E F4 13 8D    PEA $8D13              ;} Execute [pause hook]
$82:8D11 DC 01 06    JML [$0601][$88:83E1]  ;|
$82:8D14 AB          PLB                    ;|
$82:8D15 28          PLP                    ;/
$82:8D16 22 17 BE 82 JSL $82BE17[$82:BE17]  ; Cancel sound effects
$82:8D1A 20 BD 8D    JSR $8DBD  [$82:8DBD]  ; Back up some graphics state for pause screen
$82:8D1D 22 75 8E 82 JSL $828E75[$82:8E75]  ; Load pause menu tiles and clear BG2 tilemap
$82:8D21 22 DA 8E 82 JSL $828EDA[$82:8EDA]  ; Load pause screen base tilemaps
$82:8D25 22 C3 93 82 JSL $8293C3[$82:93C3]  ; Load pause menu map tilemap and area label
$82:8D29 20 D4 8F    JSR $8FD4  [$82:8FD4]  ; Backup gameplay palettes and load pause screen palettes
$82:8D2C 20 09 90    JSR $9009  [$82:9009]  ; Continue initialising pause menu
$82:8D2F A9 01 00    LDA #$0001             ;\
$82:8D32 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$82:8D35 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$82:8D38 9C 4D 07    STZ $074D  [$7E:074D]  ; Map scroll left arrow animation frame = 0
$82:8D3B A9 01 00    LDA #$0001             ;\
$82:8D3E 8D 3B 07    STA $073B  [$7E:073B]  ;} Pause screen palette animation timer = 1
$82:8D41 9C FD 05    STZ $05FD  [$7E:05FD]  ; Map scrolling direction = none
$82:8D44 9C FF 05    STZ $05FF  [$7E:05FF]  ; $05FF = 0
$82:8D47 22 11 A2 80 JSL $80A211[$80:A211]  ; Queue clearing of FX tilemap
$82:8D4B EE 98 09    INC $0998  [$7E:0998]  ; Game state = Eh (paused, loading pause screen)
$82:8D4E AB          PLB
$82:8D4F 28          PLP
$82:8D50 60          RTS
}


;;; $8D51: Back up BG2 tilemap for pause menu ;;;
{
; Due to the prefetch glitch, the value read from VRAM after setting the VRAM address is returned twice by $2139 (after which VRAM is read in sequence correctly)
; The usual workaround is to issue a dummy read from $2139 before doing a read DMA
; This routine is instead setting the source address to be +1 what it should be, meaning the first read VRAM word is wrong, but the rest of VRAM is read correctly
; tl;dr: $7E:DF5C is just a copy of $7E:DF5E
$82:8D51 08          PHP
$82:8D52 E2 20       SEP #$20
$82:8D54 A9 01       LDA #$01               ;\
$82:8D56 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:8D59 A5 59       LDA $59    [$7E:0059]  ;|
$82:8D5B 29 FC       AND #$FC               ;|
$82:8D5D 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:8D60 A9 81       LDA #$81               ;|
$82:8D62 8D 10 43    STA $4310  [$7E:4310]  ;|
$82:8D65 A9 39       LDA #$39               ;|
$82:8D67 8D 11 43    STA $4311  [$7E:4311]  ;|
$82:8D6A A9 5C       LDA #$5C               ;|
$82:8D6C 8D 12 43    STA $4312  [$7E:4312]  ;|
$82:8D6F A9 DF       LDA #$DF               ;|
$82:8D71 8D 13 43    STA $4313  [$7E:4313]  ;} $7E:DF5C..EF5B = VRAM BG2 tilemap
$82:8D74 A9 7E       LDA #$7E               ;|
$82:8D76 8D 14 43    STA $4314  [$7E:4314]  ;|
$82:8D79 A9 00       LDA #$00               ;|
$82:8D7B 8D 15 43    STA $4315  [$7E:4315]  ;|
$82:8D7E A9 10       LDA #$10               ;|
$82:8D80 8D 16 43    STA $4316  [$7E:4316]  ;|
$82:8D83 9C 17 43    STZ $4317  [$7E:4317]  ;|
$82:8D86 9C 18 43    STZ $4318  [$7E:4318]  ;|
$82:8D89 9C 19 43    STZ $4319  [$7E:4319]  ;|
$82:8D8C 9C 1A 43    STZ $431A  [$7E:431A]  ;|
$82:8D8F A9 02       LDA #$02               ;|
$82:8D91 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8D94 28          PLP
$82:8D95 60          RTS
}


;;; $8D96: Restore BG2 tilemap from pause screen ;;;
{
$82:8D96 08          PHP
$82:8D97 E2 20       SEP #$20
$82:8D99 A9 00       LDA #$00               ;\
$82:8D9B 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:8D9E A5 59       LDA $59    [$7E:0059]  ;|
$82:8DA0 29 FC       AND #$FC               ;|
$82:8DA2 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:8DA5 A9 80       LDA #$80               ;} VRAM BG2 tilemap = [$7E:DF5C..EF5B]
$82:8DA7 8D 15 21    STA $2115  [$7E:2115]  ;|
$82:8DAA 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8DAE             dx 01,01,18,7EDF5C,1000;|
$82:8DB6 A9 02       LDA #$02               ;|
$82:8DB8 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8DBB 28          PLP
$82:8DBC 60          RTS
}


;;; $8DBD: Back up some graphics state for pause screen ;;;
{
$82:8DBD 08          PHP
$82:8DBE E2 20       SEP #$20
$82:8DC0 A5 58       LDA $58    [$7E:0058]  ;\
$82:8DC2 8D 65 07    STA $0765  [$7E:0765]  ;} $0765 = [$58] (BG1 tilemap base address and size)
$82:8DC5 A5 59       LDA $59    [$7E:0059]  ;\
$82:8DC7 8D 66 07    STA $0766  [$7E:0766]  ;} $0766 = [$59] (BG2 tilemap base address and size)
$82:8DCA A5 5A       LDA $5A    [$7E:005A]  ;\
$82:8DCC 8D 67 07    STA $0767  [$7E:0767]  ;} $0767 = [$5A] (BG3 tilemap base address and size)
$82:8DCF A5 5D       LDA $5D    [$7E:005D]  ;\
$82:8DD1 8D 68 07    STA $0768  [$7E:0768]  ;|
$82:8DD4 A5 5E       LDA $5E    [$7E:005E]  ;} $0768 = [$5D] (BG tiles base address)
$82:8DD6 8D 69 07    STA $0769  [$7E:0769]  ;/
$82:8DD9 A5 52       LDA $52    [$7E:0052]  ;\
$82:8DDB 8D 6A 07    STA $076A  [$7E:076A]  ;} $076A = [$52] (sprite size and sprite tiles base address)
$82:8DDE A5 B1       LDA $B1    [$7E:00B1]  ;\
$82:8DE0 8D 6B 07    STA $076B  [$7E:076B]  ;} $076B = [$B1] (BG1 X scroll)
$82:8DE3 A5 B5       LDA $B5    [$7E:00B5]  ;\
$82:8DE5 8D 6C 07    STA $076C  [$7E:076C]  ;} $076C = [$B5] (BG2 X scroll)
$82:8DE8 A5 B9       LDA $B9    [$7E:00B9]  ;\
$82:8DEA 8D 6D 07    STA $076D  [$7E:076D]  ;} $076D = [$B9] (BG3 X scroll)
$82:8DED A5 B3       LDA $B3    [$7E:00B3]  ;\
$82:8DEF 8D 6E 07    STA $076E  [$7E:076E]  ;} $076E = [$B3] (BG1 Y scroll)
$82:8DF2 A5 B7       LDA $B7    [$7E:00B7]  ;\
$82:8DF4 8D 6F 07    STA $076F  [$7E:076F]  ;} $076F = [$B7] (BG2 Y scroll)
$82:8DF7 A5 BB       LDA $BB    [$7E:00BB]  ;\
$82:8DF9 8D 70 07    STA $0770  [$7E:0770]  ;} $0770 = [$BB] (BG3 Y scroll)
$82:8DFC A5 55       LDA $55    [$7E:0055]  ;\
$82:8DFE 8D 71 07    STA $0771  [$7E:0771]  ;} $0771 = [$55] (mode and BG tile size)
$82:8E01 AD 1B 09    LDA $091B  [$7E:091B]  ;\
$82:8E04 8D 72 07    STA $0772  [$7E:0772]  ;} $0772 = [$091B] (layer 2 scroll X)
$82:8E07 AD 1C 09    LDA $091C  [$7E:091C]  ;\
$82:8E0A 8D 73 07    STA $0773  [$7E:0773]  ;} $0773 = [$091C] (layer 2 scroll Y)
$82:8E0D A5 57       LDA $57    [$7E:0057]  ;\
$82:8E0F 8D 74 07    STA $0774  [$7E:0774]  ;} $0774 = [$57] (mosaic size and enable)
$82:8E12 A5 71       LDA $71    [$7E:0071]  ;\
$82:8E14 8D 75 07    STA $0775  [$7E:0775]  ;} $0775 = [$71] (next gameplay colour math control register B)
$82:8E17 28          PLP
$82:8E18 60          RTS
}


;;; $8E19: Restore some graphics state from pause screen ;;;
{
$82:8E19 08          PHP
$82:8E1A E2 20       SEP #$20
$82:8E1C AD 72 07    LDA $0772  [$7E:0772]  ;\
$82:8E1F 8D 1B 09    STA $091B  [$7E:091B]  ;} $091B = [$0772] (layer 2 scroll X)
$82:8E22 AD 73 07    LDA $0773  [$7E:0773]  ;\
$82:8E25 8D 1C 09    STA $091C  [$7E:091C]  ;} $091C = [$0773] (layer 2 scroll Y)
$82:8E28 AD 71 07    LDA $0771  [$7E:0771]  ;\
$82:8E2B 85 55       STA $55    [$7E:0055]  ;} $55 = [$0771] (mode and BG tile size)
$82:8E2D AD 70 07    LDA $0770  [$7E:0770]  ;\
$82:8E30 85 BB       STA $BB    [$7E:00BB]  ;} $BB = [$0770] (BG3 Y scroll)
$82:8E32 AD 6F 07    LDA $076F  [$7E:076F]  ;\
$82:8E35 85 B7       STA $B7    [$7E:00B7]  ;} $B7 = [$076F] (BG2 Y scroll)
$82:8E37 AD 6E 07    LDA $076E  [$7E:076E]  ;\
$82:8E3A 85 B3       STA $B3    [$7E:00B3]  ;} $B3 = [$076E] (BG1 Y scroll)
$82:8E3C AD 6D 07    LDA $076D  [$7E:076D]  ;\
$82:8E3F 85 B9       STA $B9    [$7E:00B9]  ;} $B9 = [$076D] (BG3 X scroll)
$82:8E41 AD 6C 07    LDA $076C  [$7E:076C]  ;\
$82:8E44 85 B5       STA $B5    [$7E:00B5]  ;} $B5 = [$076C] (BG2 X scroll)
$82:8E46 AD 6B 07    LDA $076B  [$7E:076B]  ;\
$82:8E49 85 B1       STA $B1    [$7E:00B1]  ;} $B1 = [$076B] (BG1 X scroll)
$82:8E4B AD 6A 07    LDA $076A  [$7E:076A]  ;\
$82:8E4E 85 52       STA $52    [$7E:0052]  ;} $52 = [$076A] (sprite size and sprite tiles base address)
$82:8E50 AD 69 07    LDA $0769  [$7E:0769]  ;\
$82:8E53 85 5E       STA $5E    [$7E:005E]  ;|
$82:8E55 AD 68 07    LDA $0768  [$7E:0768]  ;} $5D = [$0768] (BG tiles base address)
$82:8E58 85 5D       STA $5D    [$7E:005D]  ;/
$82:8E5A AD 67 07    LDA $0767  [$7E:0767]  ;\
$82:8E5D 85 5A       STA $5A    [$7E:005A]  ;} $5A = [$0767] (BG3 tilemap base address and size)
$82:8E5F AD 66 07    LDA $0766  [$7E:0766]  ;\
$82:8E62 85 59       STA $59    [$7E:0059]  ;} $59 = [$0766] (BG2 tilemap base address and size)
$82:8E64 AD 65 07    LDA $0765  [$7E:0765]  ;\
$82:8E67 85 58       STA $58    [$7E:0058]  ;} $58 = [$0765] (BG1 tilemap base address and size)
$82:8E69 AD 74 07    LDA $0774  [$7E:0774]  ;\
$82:8E6C 85 57       STA $57    [$7E:0057]  ;} $57 = [$0774] (mosaic size and enable)
$82:8E6E AD 75 07    LDA $0775  [$7E:0775]  ;\
$82:8E71 85 71       STA $71    [$7E:0071]  ;} $71 = [$0775] (next gameplay colour math control register B)
$82:8E73 28          PLP
$82:8E74 60          RTS
}


;;; $8E75: Load pause menu tiles and clear BG2 tilemap ;;;
{
; VRAM $4800..4FFF isn't actually used for anything in the pause screen,
; so backing it up to $7E:DF5C, clearing it here, and restoring it later is a complete waste of time and memory.
; I think this backing up + restoring of BG2 miiight have been a workaround for "bug" whereby this VRAM is cleared in $8E75
$82:8E75 08          PHP
$82:8E76 E2 30       SEP #$30
$82:8E78 A9 00       LDA #$00               ;\
$82:8E7A 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:8E7D A9 00       LDA #$00               ;|
$82:8E7F 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:8E82 A9 80       LDA #$80               ;|
$82:8E84 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..1FFF = [$B6:8000..BFFF] (pause menu BG1/2 tiles)
$82:8E87 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8E8B             dx 01,01,18,B68000,4000;|
$82:8E93 A9 02       LDA #$02               ;|
$82:8E95 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8E98 A9 00       LDA #$00               ;\
$82:8E9A 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:8E9D A9 20       LDA #$20               ;|
$82:8E9F 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:8EA2 A9 80       LDA #$80               ;|
$82:8EA4 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $2000..2FFF = [$B6:C000..DFFF] (pause menu sprite tiles)
$82:8EA7 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8EAB             dx 01,01,18,B6C000,2000;|
$82:8EB3 A9 02       LDA #$02               ;|
$82:8EB5 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8EB8 A9 00       LDA #$00               ;\
$82:8EBA 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:8EBD A9 40       LDA #$40               ;|
$82:8EBF 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:8EC2 A9 80       LDA #$80               ;|
$82:8EC4 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4000..47FF = [$9A:B200..C1FF] (standard BG3 tiles), VRAM $4800..4FFF = 0
$82:8EC7 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8ECB             dx 01,01,18,9AB200,2000;|
$82:8ED3 A9 02       LDA #$02               ;|
$82:8ED5 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8ED8 28          PLP
$82:8ED9 6B          RTL
}


;;; $8EDA: Load pause screen base tilemaps ;;;
{
; Note that $B20C loads the actual Samus wireframe tilemap to the $7E:3800 area,
; unsure why this routine loads the dummy tilemap to the $7E:3000 area, possibly a typo during development
$82:8EDA 08          PHP
$82:8EDB E2 30       SEP #$30
$82:8EDD A9 00       LDA #$00               ;\
$82:8EDF 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:8EE2 A9 38       LDA #$38               ;|
$82:8EE4 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:8EE7 A9 80       LDA #$80               ;|
$82:8EE9 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $3800..3BFF = [$B6:E000..E7FF] (pause menu map BG2 tilemap)
$82:8EEC 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8EF0             dx 01,01,18,B6E000,0800;|
$82:8EF8 A9 02       LDA #$02               ;|
$82:8EFA 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8EFD A9 00       LDA #$00               ;\
$82:8EFF 8D 81 21    STA $2181  [$7E:2181]  ;|
$82:8F02 A9 34       LDA #$34               ;|
$82:8F04 8D 82 21    STA $2182  [$7E:2182]  ;|
$82:8F07 A9 7E       LDA #$7E               ;|
$82:8F09 8D 83 21    STA $2183  [$7E:2183]  ;} $7E:3400..37FF = [$B6:E400..E7FF] (the lower half of the map BG2 tilemap)
$82:8F0C 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8F10             dx 01,00,80,B6E400,0400;|
$82:8F18 A9 02       LDA #$02               ;|
$82:8F1A 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8F1D A9 00       LDA #$00               ;\
$82:8F1F 8D 81 21    STA $2181  [$7E:2181]  ;|
$82:8F22 A9 38       LDA #$38               ;|
$82:8F24 8D 82 21    STA $2182  [$7E:2182]  ;|
$82:8F27 A9 7E       LDA #$7E               ;|
$82:8F29 8D 83 21    STA $2183  [$7E:2183]  ;} $7E:3800..3FFF = [$B6:E800..EFFF] (equipment screen tilemap)
$82:8F2C 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:8F30             dx 01,00,80,B6E800,0800;|
$82:8F38 A9 02       LDA #$02               ;|
$82:8F3A 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:8F3D C2 30       REP #$30
$82:8F3F A0 39 C6    LDY #$C639             ; Y = $C639 (dummy Samus wireframe tilemap)
$82:8F42 A2 D8 01    LDX #$01D8             ; X = 1D8h (tilemap destination offset)
$82:8F45 A9 11 00    LDA #$0011             ;\
$82:8F48 85 14       STA $14    [$7E:0014]  ;} $14 = 11h (number of rows)

; LOOP_ROWS
$82:8F4A A9 08 00    LDA #$0008             ;\
$82:8F4D 85 12       STA $12    [$7E:0012]  ;} $12 = 8 (number of columns)

; LOOP_COLUMNS
$82:8F4F B9 00 00    LDA $0000,y[$82:C639]  ;\
$82:8F52 9F 00 30 7E STA $7E3000,x[$7E:31D8];} $7E:3000 + [X] = [[Y]]
$82:8F56 E8          INX                    ;\
$82:8F57 E8          INX                    ;} X += 2
$82:8F58 C8          INY                    ;\
$82:8F59 C8          INY                    ;} Y += 2
$82:8F5A C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$82:8F5C D0 F1       BNE $F1    [$8F4F]     ; If [$12] != 0: go to LOOP_COLUMNS
$82:8F5E 8A          TXA                    ;\
$82:8F5F 18          CLC                    ;|
$82:8F60 69 10 00    ADC #$0010             ;} X += 10h
$82:8F63 AA          TAX                    ;/
$82:8F64 C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$82:8F66 D0 E2       BNE $E2    [$8F4A]     ; If [$14] != 0: go to LOOP_ROWS
$82:8F68 20 0C B2    JSR $B20C  [$82:B20C]  ; Write Samus wireframe tilemap
$82:8F6B 20 70 8F    JSR $8F70  [$82:8F70]  ; Load equipment screen reserve health tilemap
$82:8F6E 28          PLP
$82:8F6F 6B          RTL
}


;;; $8F70: Load equipment screen reserve health tilemap ;;;
{
$82:8F70 08          PHP
$82:8F71 C2 30       REP #$30
$82:8F73 AD D4 09    LDA $09D4  [$7E:09D4]  ;\
$82:8F76 F0 5A       BEQ $5A    [$8FD2]     ;} If [Samus max reserve health] = 0: return
$82:8F78 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:8F7B 8D 04 42    STA $4204  [$7E:4204]  ;|
$82:8F7E E2 20       SEP #$20               ;|
$82:8F80 A9 64       LDA #$64               ;|
$82:8F82 8D 06 42    STA $4206  [$7E:4206]  ;|
$82:8F85 EA          NOP                    ;|
$82:8F86 EA          NOP                    ;|
$82:8F87 EA          NOP                    ;|
$82:8F88 EA          NOP                    ;|
$82:8F89 EA          NOP                    ;} $2A = [Samus reserve health] / 100
$82:8F8A EA          NOP                    ;|
$82:8F8B EA          NOP                    ;|
$82:8F8C EA          NOP                    ;|
$82:8F8D EA          NOP                    ;|
$82:8F8E AD 14 42    LDA $4214  [$7E:4214]  ;|
$82:8F91 85 2A       STA $2A    [$7E:002A]  ;|
$82:8F93 AD 15 42    LDA $4215  [$7E:4215]  ;|
$82:8F96 85 2B       STA $2B    [$7E:002B]  ;/
$82:8F98 AD 16 42    LDA $4216  [$7E:4216]  ;\
$82:8F9B 8D 04 42    STA $4204  [$7E:4204]  ;|
$82:8F9E AD 17 42    LDA $4217  [$7E:4217]  ;|
$82:8FA1 8D 05 42    STA $4205  [$7E:4205]  ;|
$82:8FA4 A9 0A       LDA #$0A               ;|
$82:8FA6 8D 06 42    STA $4206  [$7E:4206]  ;|
$82:8FA9 C2 20       REP #$20               ;|
$82:8FAB EA          NOP                    ;|
$82:8FAC EA          NOP                    ;|
$82:8FAD EA          NOP                    ;} Equipment screen BG1 tilemap tile (Ah, Ch) = 4 + [Samus reserve health] % 10
$82:8FAE EA          NOP                    ;|
$82:8FAF EA          NOP                    ;|
$82:8FB0 EA          NOP                    ;|
$82:8FB1 EA          NOP                    ;|
$82:8FB2 AD 16 42    LDA $4216  [$7E:4216]  ;|
$82:8FB5 18          CLC                    ;|
$82:8FB6 69 04 08    ADC #$0804             ;|
$82:8FB9 8F 14 3B 7E STA $7E3B14[$7E:3B14]  ;/
$82:8FBD AD 14 42    LDA $4214  [$7E:4214]  ;\
$82:8FC0 18          CLC                    ;|
$82:8FC1 69 04 08    ADC #$0804             ;} Equipment screen BG1 tilemap tile (9, Ch) = 4 + [Samus reserve health] % 100 / 10
$82:8FC4 8F 12 3B 7E STA $7E3B12[$7E:3B12]  ;/
$82:8FC8 A5 2A       LDA $2A    [$7E:002A]  ;\
$82:8FCA 18          CLC                    ;|
$82:8FCB 69 04 08    ADC #$0804             ;} Equipment screen BG1 tilemap tile (8, Ch) = 4 + [Samus reserve health] / 100
$82:8FCE 8F 10 3B 7E STA $7E3B10[$7E:3B10]  ;/

$82:8FD2 28          PLP
$82:8FD3 60          RTS
}


;;; $8FD4: Backup gameplay palettes and load pause screen palettes ;;;
{
$82:8FD4 08          PHP
$82:8FD5 E2 30       SEP #$30               ;\
$82:8FD7 08          PHP                    ;} >_<;;;
$82:8FD8 C2 30       REP #$30
$82:8FDA A0 00 02    LDY #$0200             ;\
$82:8FDD A2 00 00    LDX #$0000             ;|
                                            ;|
$82:8FE0 BF 00 C0 7E LDA $7EC000,x[$7E:C000];|
$82:8FE4 9F 00 33 7E STA $7E3300,x[$7E:3300];|
$82:8FE8 E8          INX                    ;} Backup of palettes during menu = [palettes]
$82:8FE9 E8          INX                    ;|
$82:8FEA 88          DEY                    ;|
$82:8FEB 88          DEY                    ;|
$82:8FEC D0 F2       BNE $F2    [$8FE0]     ;/
$82:8FEE 28          PLP                    ;\
$82:8FEF 08          PHP                    ;} >_<;
$82:8FF0 C2 30       REP #$30               ;/
$82:8FF2 A0 00 02    LDY #$0200             ;\
$82:8FF5 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:8FF8 BF 00 F0 B6 LDA $B6F000,x[$B6:F000];|
$82:8FFC 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$82:9000 E8          INX                    ;} Palettes = [$B6:F000..F1FF] (pause screen palettes)
$82:9001 E8          INX                    ;|
$82:9002 88          DEY                    ;|
$82:9003 88          DEY                    ;|
$82:9004 D0 F2       BNE $F2    [$8FF8]     ;/
$82:9006 28          PLP
$82:9007 28          PLP
$82:9008 60          RTS
}


;;; $9009: Continue initialising pause menu ;;;
{
; I don't know why this is a subroutine and not a part of $8CEF, hence the awkward name
$82:9009 08          PHP
$82:900A 8B          PHB
$82:900B 4B          PHK                    ;\
$82:900C AB          PLB                    ;} DB = $82
$82:900D 20 9A A0    JSR $A09A  [$82:A09A]  ; Set up PPU for pause menu
$82:9010 20 F7 A0    JSR $A0F7  [$82:A0F7]  ; Reset pause menu animations
$82:9013 20 2B A1    JSR $A12B  [$82:A12B]  ; Load equipment screen equipment tilemaps
$82:9016 20 96 A7    JSR $A796  [$82:A796]  ; Set pause screen button label palettes - map screen
$82:9019 20 4D A8    JSR $A84D  [$82:A84D]  ; Update pause menu L/R/start VRAM tilemap
$82:901C 20 C4 9E    JSR $9EC4  [$82:9EC4]  ; Determine map scroll limits
$82:901F A9 80 00    LDA #$0080             ;\
$82:9022 20 27 9E    JSR $9E27  [$82:9E27]  ;} Set up map scrolling for pause menu
$82:9025 AB          PLB
$82:9026 28          PLP
$82:9027 60          RTS
}


;;; $9028: Set up map scrolling for file select map ;;;
{
; This is just $9E27 with the A parameter hardcoded to 80h (which is the only parameter it's ever called with anyway)
$82:9028 20 F7 A0    JSR $A0F7  [$82:A0F7]  ; Reset pause menu animations
$82:902B 20 C4 9E    JSR $9EC4  [$82:9EC4]  ; Determine map scroll limits
$82:902E AD AE 05    LDA $05AE  [$7E:05AE]  ;\
$82:9031 38          SEC                    ;|
$82:9032 ED AC 05    SBC $05AC  [$7E:05AC]  ;|
$82:9035 4A          LSR A                  ;|
$82:9036 18          CLC                    ;} BG1 X scroll = midpoint([map min X scroll], [map max X scroll]) - 80h
$82:9037 6D AC 05    ADC $05AC  [$7E:05AC]  ;|
$82:903A 38          SEC                    ;|
$82:903B E9 80 00    SBC #$0080             ;|
$82:903E 85 B1       STA $B1    [$7E:00B1]  ;/
$82:9040 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$82:9043 29 00 FF    AND #$FF00             ;|
$82:9046 EB          XBA                    ;|
$82:9047 18          CLC                    ;|
$82:9048 6D A1 07    ADC $07A1  [$7E:07A1]  ;|
$82:904B 0A          ASL A                  ;} $12 = ([room X co-ordinate] + [Samus X position] / 100h) * 8 - [BG1 X scroll]
$82:904C 0A          ASL A                  ;|
$82:904D 0A          ASL A                  ;|
$82:904E 38          SEC                    ;|
$82:904F E5 B1       SBC $B1    [$7E:00B1]  ;|
$82:9051 85 12       STA $12    [$7E:0012]  ;/
$82:9053 A9 E0 00    LDA #$00E0             ;\
$82:9056 38          SEC                    ;|
$82:9057 E5 12       SBC $12    [$7E:0012]  ;} If [$12] > E0h:
$82:9059 10 0B       BPL $0B    [$9066]     ;/
$82:905B 85 12       STA $12    [$7E:0012]  ;\
$82:905D A5 B1       LDA $B1    [$7E:00B1]  ;|
$82:905F 38          SEC                    ;} BG1 X scroll += [$12] - E0h
$82:9060 E5 12       SBC $12    [$7E:0012]  ;|
$82:9062 85 B1       STA $B1    [$7E:00B1]  ;/
$82:9064 80 11       BRA $11    [$9077]

$82:9066 A9 20 00    LDA #$0020             ;\ Else ([$12] <= E0h):
$82:9069 38          SEC                    ;|
$82:906A E5 12       SBC $12    [$7E:0012]  ;} If [$12] <= 20h:
$82:906C 85 12       STA $12    [$7E:0012]  ;|
$82:906E 30 07       BMI $07    [$9077]     ;/
$82:9070 A5 B1       LDA $B1    [$7E:00B1]  ;\
$82:9072 38          SEC                    ;|
$82:9073 E5 12       SBC $12    [$7E:0012]  ;} BG1 X scroll -= 20h - [$12]
$82:9075 85 B1       STA $B1    [$7E:00B1]  ;/

$82:9077 AD B2 05    LDA $05B2  [$7E:05B2]  ;\
$82:907A 38          SEC                    ;|
$82:907B ED B0 05    SBC $05B0  [$7E:05B0]  ;|
$82:907E 4A          LSR A                  ;|
$82:907F 18          CLC                    ;|
$82:9080 69 10 00    ADC #$0010             ;|
$82:9083 18          CLC                    ;|
$82:9084 6D B0 05    ADC $05B0  [$7E:05B0]  ;|
$82:9087 85 12       STA $12    [$7E:0012]  ;} BG1 Y scroll = midpoint([map min Y scroll], [map max Y scroll]) - 60h rounded up to multiple of 8
$82:9089 A9 70 00    LDA #$0070             ;|
$82:908C 38          SEC                    ;|
$82:908D E5 12       SBC $12    [$7E:0012]  ;|
$82:908F 29 F8 FF    AND #$FFF8             ;|
$82:9092 49 FF FF    EOR #$FFFF             ;|
$82:9095 1A          INC A                  ;|
$82:9096 85 B3       STA $B3    [$7E:00B3]  ;/
$82:9098 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$82:909B EB          XBA                    ;|
$82:909C 29 FF 00    AND #$00FF             ;|
$82:909F 18          CLC                    ;|
$82:90A0 6D A3 07    ADC $07A3  [$7E:07A3]  ;|
$82:90A3 1A          INC A                  ;|
$82:90A4 0A          ASL A                  ;} $12 = ([room Y co-ordinate] + [Samus Y position] / 100h + 1) * 8 - [BG1 Y scroll]
$82:90A5 0A          ASL A                  ;|
$82:90A6 0A          ASL A                  ;|
$82:90A7 38          SEC                    ;|
$82:90A8 E5 B3       SBC $B3    [$7E:00B3]  ;|
$82:90AA 85 12       STA $12    [$7E:0012]  ;/
$82:90AC A9 40 00    LDA #$0040             ;\
$82:90AF 38          SEC                    ;|
$82:90B0 E5 12       SBC $12    [$7E:0012]  ;} If [$12] <= 40h:
$82:90B2 30 13       BMI $13    [$90C7]     ;/
$82:90B4 85 12       STA $12    [$7E:0012]  ;\
$82:90B6 A5 B3       LDA $B3    [$7E:00B3]  ;|
$82:90B8 38          SEC                    ;} BG1 Y scroll -= 40h - [$12]
$82:90B9 E5 12       SBC $12    [$7E:0012]  ;|
$82:90BB 85 B3       STA $B3    [$7E:00B3]  ;/
$82:90BD C9 D8 FF    CMP #$FFD8             ;\
$82:90C0 10 05       BPL $05    [$90C7]     ;|
$82:90C2 A9 D8 FF    LDA #$FFD8             ;} BG1 Y scroll = max([BG1 Y scroll], -28h)
$82:90C5 85 B3       STA $B3    [$7E:00B3]  ;/

$82:90C7 6B          RTL
}


;;; $90C8: Game state Eh (paused, loading pause screen) ;;;
{
$82:90C8 08          PHP
$82:90C9 C2 30       REP #$30
$82:90CB 22 2B B6 82 JSL $82B62B[$82:B62B]  ; Draw pause menu during fade in
$82:90CF 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$82:90D3 E2 20       SEP #$20               ;\
$82:90D5 A5 51       LDA $51    [$7E:0051]  ;|
$82:90D7 C9 0F       CMP #$0F               ;} If not finished fading in: return
$82:90D9 D0 0B       BNE $0B    [$90E6]     ;|
$82:90DB C2 20       REP #$20               ;/
$82:90DD 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:90E0 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:90E3 EE 98 09    INC $0998  [$7E:0998]  ; Game state = Fh (paused, map and item screens)

$82:90E6 28          PLP
$82:90E7 60          RTS
}


;;; $90E8: Game state Fh (paused, map and item screens) ;;;
{
$82:90E8 8B          PHB
$82:90E9 4B          PHK                    ;\
$82:90EA AB          PLB                    ;} DB = $82
$82:90EB A9 03 00    LDA #$0003             ;\
$82:90EE 22 46 81 80 JSL $808146[$80:8146]  ;} Update timed held input
$82:90F2 22 FF 90 82 JSL $8290FF[$82:90FF]  ; Main pause routine
$82:90F6 22 44 9B 80 JSL $809B44[$80:9B44]  ; Handle HUD tilemap
$82:90FA 20 2B A9    JSR $A92B  [$82:A92B]  ; Handle pause screen palette animation
$82:90FD AB          PLB
$82:90FE 60          RTS
}


;;; $90FF..925C: Main pause routine ;;;
{
;;; $90FF: Main pause routine ;;;
{
$82:90FF 08          PHP
$82:9100 8B          PHB
$82:9101 4B          PHK                    ;\
$82:9102 AB          PLB                    ;} DB = $82
$82:9103 C2 30       REP #$30
$82:9105 AD 27 07    LDA $0727  [$7E:0727]  ;\
$82:9108 0A          ASL A                  ;|
$82:9109 AA          TAX                    ;} Execute [$9110 + [menu index] * 2]
$82:910A FC 10 91    JSR ($9110,x)[$82:9120];/
$82:910D AB          PLB
$82:910E 28          PLP
$82:910F 6B          RTL

$82:9110             dw 9120, 9142, 9156, 91AB, 9231, 9186, 91D7, 9200
}


;;; $9120: Pause menu - index 0: map screen ;;;
{
$82:9120 C2 30       REP #$30
$82:9122 20 05 A5    JSR $A505  [$82:A505]  ; Handle pause screen L/R
$82:9125 20 B7 A5    JSR $A5B7  [$82:A5B7]  ; Handle pause screen start button
$82:9128 22 34 B9 82 JSL $82B934[$82:B934]  ; Handle map scroll arrows
$82:912C 22 5D 92 82 JSL $82925D[$82:925D]  ; Map scrolling
$82:9130 20 C8 B9    JSR $B9C8  [$82:B9C8]  ; Map screen - draw Samus position indicator
$82:9133 22 72 B6 82 JSL $82B672[$82:B672]  ; Draw map icons
$82:9137 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$82:913B A9 00 00    LDA #$0000             ;\
$82:913E 8D 63 07    STA $0763  [$7E:0763]  ;} Pause screen mode = map screen
$82:9141 60          RTS
}


;;; $9142: Pause menu - index 1: equipment screen ;;;
{
$82:9142 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$82:9144 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$82:9146 20 4F AC    JSR $AC4F  [$82:AC4F]  ; Equipment screen - main
$82:9149 20 05 A5    JSR $A505  [$82:A505]  ; Handle pause screen L/R
$82:914C 20 B7 A5    JSR $A5B7  [$82:A5B7]  ; Handle pause screen start button
$82:914F A9 01 00    LDA #$0001             ;\
$82:9152 8D 63 07    STA $0763  [$7E:0763]  ;} Pause screen mode = equipment screen
$82:9155 60          RTS
}


;;; $9156: Pause menu - index 2: map screen to equipment screen - fading out ;;;
{
$82:9156 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$82:915A 20 C8 B9    JSR $B9C8  [$82:B9C8]  ; Map screen - draw Samus position indicator
$82:915D 22 72 B6 82 JSL $82B672[$82:B672]  ; Draw map icons
$82:9161 20 6D A5    JSR $A56D  [$82:A56D]  ; Handle pause menu L/R pressed highlight
$82:9164 A9 00 00    LDA #$0000             ;\
$82:9167 8D 63 07    STA $0763  [$7E:0763]  ;} Pause screen mode = map screen
$82:916A 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:916E E2 20       SEP #$20
$82:9170 A5 51       LDA $51    [$7E:0051]  ;\
$82:9172 C9 80       CMP #$80               ;} If not finished fading out: return
$82:9174 D0 0F       BNE $0F    [$9185]     ;/
$82:9176 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:917A C2 20       REP #$20
$82:917C 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:917F 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:9182 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 3 (map screen to equipment screen - load equipment screen)

$82:9185 60          RTS
}


;;; $9186: Pause menu - index 5: equipment screen to map screen - fading out ;;;
{
$82:9186 20 67 B2    JSR $B267  [$82:B267]  ; Draw item selector
$82:9189 20 A2 B2    JSR $B2A2  [$82:B2A2]  ; Equipment screen - display reserve tank amount
$82:918C 20 6D A5    JSR $A56D  [$82:A56D]  ; Handle pause menu L/R pressed highlight
$82:918F 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:9193 E2 20       SEP #$20
$82:9195 A5 51       LDA $51    [$7E:0051]  ;\
$82:9197 C9 80       CMP #$80               ;} If not finished fading out: return
$82:9199 D0 0F       BNE $0F    [$91AA]     ;/
$82:919B 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:919F C2 20       REP #$20
$82:91A1 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:91A4 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:91A7 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 6 (equipment screen to map screen - load map screen)

$82:91AA 60          RTS
}


;;; $91AB: Pause menu - index 3: map screen to equipment screen - load equipment screen ;;;
{
$82:91AB C2 30       REP #$30
$82:91AD 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$82:91B1 20 47 AB    JSR $AB47  [$82:AB47]  ; Equipment screen - set up reserve mode and determine initial selection
$82:91B4 22 22 AC 82 JSL $82AC22[$82:AC22]  ; Equipment screen - transfer BG1 tilemap
$82:91B8 A9 01 00    LDA #$0001             ;\
$82:91BB 8D 63 07    STA $0763  [$7E:0763]  ;} Pause screen mode = equipment screen
$82:91BE 20 15 A6    JSR $A615  [$82:A615]  ; Set pause screen button label palettes
$82:91C1 9C 3F 07    STZ $073F  [$7E:073F]  ; L/R highlight animation frame = 0
$82:91C4 AD 0C C1    LDA $C10C  [$82:C10C]  ;\
$82:91C7 8D 2B 07    STA $072B  [$7E:072B]  ;} L/R highlight animation timer = Fh
$82:91CA A9 01 00    LDA #$0001             ;\
$82:91CD 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$82:91D0 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$82:91D3 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 4 (map screen to equipment screen - fading in)
$82:91D6 60          RTS
}


;;; $91D7: Pause menu - index 6: equipment screen to map screen - load map screen ;;;
{
$82:91D7 C2 30       REP #$30
$82:91D9 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$82:91DD 22 C3 93 82 JSL $8293C3[$82:93C3]  ; Load pause menu map tilemap and area label
$82:91E1 20 15 A6    JSR $A615  [$82:A615]  ; Set pause screen button label palettes
$82:91E4 9C 3F 07    STZ $073F  [$7E:073F]  ; L/R highlight animation frame = 0
$82:91E7 AD 0C C1    LDA $C10C  [$82:C10C]  ;\
$82:91EA 8D 2B 07    STA $072B  [$7E:072B]  ;} L/R highlight animation timer = Fh
$82:91ED A9 01 00    LDA #$0001             ;\
$82:91F0 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$82:91F3 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$82:91F6 A9 00 00    LDA #$0000             ;\
$82:91F9 8D 63 07    STA $0763  [$7E:0763]  ;} Pause screen mode = map screen
$82:91FC EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 7 (equipment screen to map screen - fading in)
$82:91FF 60          RTS
}


;;; $9200: Pause menu - index 7: equipment screen to map screen - fading in ;;;
{
$82:9200 20 C8 B9    JSR $B9C8  [$82:B9C8]  ; Map screen - draw Samus position indicator
$82:9203 22 72 B6 82 JSL $82B672[$82:B672]  ; Draw map icons
$82:9207 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$82:920B A9 00 00    LDA #$0000             ;\
$82:920E 8D 63 07    STA $0763  [$7E:0763]  ;} Pause screen mode = map screen
$82:9211 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$82:9215 E2 20       SEP #$20
$82:9217 A5 51       LDA $51    [$7E:0051]  ;\
$82:9219 C9 0F       CMP #$0F               ;} If not finished fading in: return
$82:921B D0 13       BNE $13    [$9230]     ;/
$82:921D C2 20       REP #$20
$82:921F 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:9222 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:9225 AD 53 07    LDA $0753  [$7E:0753]  ;\
$82:9228 F0 03       BEQ $03    [$922D]     ;|
$82:922A A9 01 00    LDA #$0001             ;} If [pause screen button label mode] != map screen: menu index = 1 (equipment screen)
                                            ;} Else ([pause screen button label mode] = map screen): menu index = 0 (map screen)
$82:922D 8D 27 07    STA $0727  [$7E:0727]  ;/

$82:9230 60          RTS
}


;;; $9231: Pause menu - index 4: map screen to equipment screen - fading in ;;;
{
$82:9231 20 67 B2    JSR $B267  [$82:B267]  ; Equipment screen - draw item selector
$82:9234 20 A2 B2    JSR $B2A2  [$82:B2A2]  ; Equipment screen - display reserve tank amount
$82:9237 A9 01 00    LDA #$0001             ;\
$82:923A 8D 63 07    STA $0763  [$7E:0763]  ;} Pause screen mode = equipment screen
$82:923D 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$82:9241 E2 20       SEP #$20
$82:9243 A5 51       LDA $51    [$7E:0051]  ;\
$82:9245 C9 0F       CMP #$0F               ;} If not finished fading in: return
$82:9247 D0 13       BNE $13    [$925C]     ;/
$82:9249 C2 20       REP #$20
$82:924B 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:924E 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:9251 AD 53 07    LDA $0753  [$7E:0753]  ;\
$82:9254 F0 03       BEQ $03    [$9259]     ;|
$82:9256 A9 01 00    LDA #$0001             ;} If [pause screen button label mode] != map screen: menu index = 1 (equipment screen)
                                            ;} Else ([pause screen button label mode] = map screen): menu index = 0 (map screen)
$82:9259 8D 27 07    STA $0727  [$7E:0727]  ;/

$82:925C 60          RTS
}
}


;;; $925D..9323: Map scrolling ;;;
{
;;; $925D: Map scrolling ;;;
{
$82:925D 08          PHP
$82:925E 8B          PHB
$82:925F 4B          PHK                    ;\
$82:9260 AB          PLB                    ;} DB = $82
$82:9261 C2 30       REP #$30
$82:9263 AD FD 05    LDA $05FD  [$7E:05FD]  ;\
$82:9266 0A          ASL A                  ;|
$82:9267 AA          TAX                    ;} Execute [$926E + [map scrolling direction] * 2]
$82:9268 FC 6E 92    JSR ($926E,x)[$82:9278];/
$82:926B AB          PLB
$82:926C 28          PLP
$82:926D 6B          RTL

$82:926E             dw 9278, 928E, 92BD, 92CA, 92D7
}


;;; $9278: Map scrolling - none ;;;
{
$82:9278 A9 04 00    LDA #$0004             ;\
$82:927B 8D FB 05    STA $05FB  [$7E:05FB]  ;} Map scrolling gear switch timer = 4
$82:927E 60          RTS
}


;;; $927F: X = map scroll speed index ;;;
{
$82:927F AE FF 05    LDX $05FF  [$7E:05FF]  ; X = [map scrolling speed index]
$82:9282 AD FB 05    LDA $05FB  [$7E:05FB]  ;\
$82:9285 D0 06       BNE $06    [$928D]     ;} If [map scrolling gear switch timer] = 0:
$82:9287 8A          TXA                    ;\
$82:9288 18          CLC                    ;|
$82:9289 69 20 00    ADC #$0020             ;} X += 20h (use other speed table, see $92E4)
$82:928C AA          TAX                    ;/

$82:928D 60          RTS
}


;;; $928E: Map scrolling - left ;;;
{
$82:928E 20 7F 92    JSR $927F  [$82:927F]  ; X = map scroll speed index
$82:9291 A5 B1       LDA $B1    [$7E:00B1]  ;\
$82:9293 38          SEC                    ;|
$82:9294 FD E4 92    SBC $92E4,x[$82:92E4]  ;} BG1 X scroll -= [$92E4 + [X]]
$82:9297 85 B1       STA $B1    [$7E:00B1]  ;/
}


;;; $9299: Map scrolling - common ;;;
{
$82:9299 EE FF 05    INC $05FF  [$7E:05FF]  ;\
$82:929C EE FF 05    INC $05FF  [$7E:05FF]  ;} Map scrolling speed index += 2
$82:929F AD FF 05    LDA $05FF  [$7E:05FF]  ;\
$82:92A2 29 0F 00    AND #$000F             ;} If [map scrolling speed index] % 10h != 0: return
$82:92A5 D0 15       BNE $15    [$92BC]     ;/
$82:92A7 A9 36 00    LDA #$0036             ;\
$82:92AA 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 36h, sound library 1, max queued sounds allowed = 6 (scrolling map)
$82:92AE 9C FD 05    STZ $05FD  [$7E:05FD]  ; Map scrolling direction = none
$82:92B1 9C FF 05    STZ $05FF  [$7E:05FF]  ; Map scrolling speed index = 0
$82:92B4 AD FB 05    LDA $05FB  [$7E:05FB]  ;\
$82:92B7 F0 03       BEQ $03    [$92BC]     ;} Map scrolling gear switch timer = max(0, [map scrolling gear switch timer] - 1)
$82:92B9 CE FB 05    DEC $05FB  [$7E:05FB]  ;/

$82:92BC 60          RTS
}


;;; $92BD: Map scrolling - right ;;;
{
$82:92BD 20 7F 92    JSR $927F  [$82:927F]  ; X = map scroll speed index
$82:92C0 BD E4 92    LDA $92E4,x[$82:92E4]  ;\
$82:92C3 18          CLC                    ;|
$82:92C4 65 B1       ADC $B1    [$7E:00B1]  ;} BG1 X scroll += [$92E4 + [X]]
$82:92C6 85 B1       STA $B1    [$7E:00B1]  ;/
$82:92C8 80 CF       BRA $CF    [$9299]     ; Go to map scrolling - common
}


;;; $92CA: Map scrolling - up ;;;
{
$82:92CA 20 7F 92    JSR $927F  [$82:927F]  ; X = map scroll speed index
$82:92CD A5 B3       LDA $B3    [$7E:00B3]  ;\
$82:92CF 38          SEC                    ;|
$82:92D0 FD E4 92    SBC $92E4,x[$82:92E4]  ;} BG1 Y scroll -= [$92E4 + [X]]
$82:92D3 85 B3       STA $B3    [$7E:00B3]  ;/
$82:92D5 80 C2       BRA $C2    [$9299]     ; Go to map scrolling - common
}


;;; $92D7: Map scrolling - down ;;;
{
$82:92D7 20 7F 92    JSR $927F  [$82:927F]  ; X = map scroll speed index
$82:92DA BD E4 92    LDA $92E4,x[$82:92E4]  ;\
$82:92DD 18          CLC                    ;|
$82:92DE 65 B3       ADC $B3    [$7E:00B3]  ;} BG1 Y scroll += [$92E4 + [X]]
$82:92E0 85 B3       STA $B3    [$7E:00B3]  ;/
$82:92E2 80 B5       BRA $B5    [$9299]     ; Go to map scrolling - common
}


;;; $92E4: Map scrolling speed table ;;;
{
; Some (very uninteresting) map scrolling data
$82:92E4             dw 0000, 0000, 0000, 0008, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
$82:9304             dw 0000, 0000, 0000, 0008, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}
}


;;; $9324: Game state 10h (unpausing, loading normal gameplay) ;;;
{
$82:9324 08          PHP
$82:9325 C2 30       REP #$30
$82:9327 22 F1 A5 82 JSL $82A5F1[$82:A5F1]  ; Highlight pause screen button
$82:932B 20 4B 93    JSR $934B  [$82:934B]  ; Draw pause menu during fade out
$82:932E 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:9332 E2 20       SEP #$20
$82:9334 A5 51       LDA $51    [$7E:0051]  ;\
$82:9336 C9 80       CMP #$80               ;} If not finished fading out: return
$82:9338 D0 0F       BNE $0F    [$9349]     ;/
$82:933A 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:933E C2 20       REP #$20
$82:9340 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:9343 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:9346 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 11h (unpausing, loading normal gameplay)

$82:9349 28          PLP
$82:934A 60          RTS
}


;;; $934B: Draw pause menu during fade out ;;;
{
$82:934B AD 63 07    LDA $0763  [$7E:0763]  ;\
$82:934E C9 01 00    CMP #$0001             ;} If [pause screen mode] != equipment screen:
$82:9351 F0 0B       BEQ $0B    [$935E]     ;/
$82:9353 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$82:9357 22 72 B6 82 JSL $82B672[$82:B672]  ; Draw map icons
$82:935B 4C C8 B9    JMP $B9C8  [$82:B9C8]  ; Map screen - draw Samus position indicator

$82:935E 20 67 B2    JSR $B267  [$82:B267]  ; Draw item selector
$82:9361 20 A2 B2    JSR $B2A2  [$82:B2A2]  ; Display reserve tank amount
$82:9364 4C 6D A5    JMP $A56D  [$82:A56D]  ; Handle pause menu L/R pressed highlight
}


;;; $9367: Game state 11h (unpausing, loading normal gameplay) ;;;
{
$82:9367 08          PHP
$82:9368 C2 30       REP #$30
$82:936A 20 BE A2    JSR $A2BE  [$82:A2BE]  ; Clear Samus/beam tiles
$82:936D 20 E3 A2    JSR $A2E3  [$82:A2E3]  ; Continue initialising gameplay resume
$82:9370 22 49 A1 80 JSL $80A149[$80:A149]  ; Resume gameplay
$82:9374 20 19 8E    JSR $8E19  [$82:8E19]  ; Restore some graphics state from pause screen
$82:9377 20 96 8D    JSR $8D96  [$82:8D96]  ; Restore BG2 tilemap from pause screen
$82:937A C2 30       REP #$30
$82:937C A9 01 00    LDA #$0001             ;\
$82:937F 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$82:9382 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$82:9385 08          PHP
$82:9386 8B          PHB
$82:9387 4B          PHK                    ;\
$82:9388 F4 8D 93    PEA $938D              ;} Execute unpause hook
$82:938B DC 04 06    JML [$0604][$88:83E1]  ;/

$82:938E 22 88 82 88 JSL $888288[$88:8288]  ; Enable HDMA objects
$82:9392 22 00 80 87 JSL $878000[$87:8000]  ; Enable animated tiles objects
$82:9396 22 2F BE 82 JSL $82BE2F[$82:BE2F]  ; Queue Samus movement sound effects
$82:939A AB          PLB
$82:939B 28          PLP
$82:939C EE 98 09    INC $0998  [$7E:0998]  ; Game state = 12h (unpausing, normal gameplay but brightening)
$82:939F 28          PLP
$82:93A0 60          RTS
}


;;; $93A1: Game state 12h (unpausing, normal gameplay but brightening) ;;;
{
$82:93A1 08          PHP
$82:93A2 C2 30       REP #$30
$82:93A4 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:93A7 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$82:93AB E2 20       SEP #$20
$82:93AD A5 51       LDA $51    [$7E:0051]  ;\
$82:93AF C9 0F       CMP #$0F               ;} If not finished fading in: return
$82:93B1 D0 0E       BNE $0E    [$93C1]     ;/
$82:93B3 C2 20       REP #$20
$82:93B5 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:93B8 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:93BB A9 08 00    LDA #$0008             ;\
$82:93BE 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 8 (main gameplay)

$82:93C1 28          PLP
$82:93C2 60          RTS
}


;;; $93C3..A099: Pause menu / room select map ;;;
{
;;; $93C3: Load pause menu map tilemap and area label ;;;
{
$82:93C3 08          PHP
$82:93C4 8B          PHB
$82:93C5 4B          PHK                    ;\
$82:93C6 AB          PLB                    ;} DB = $82
$82:93C7 C2 30       REP #$30
$82:93C9 A5 BD       LDA $BD    [$7E:00BD]  ;\
$82:93CB 85 B1       STA $B1    [$7E:00B1]  ;} BG1 X scroll = [BG4 X scroll]
$82:93CD A5 BF       LDA $BF    [$7E:00BF]  ;\
$82:93CF 85 B3       STA $B3    [$7E:00B3]  ;} BG1 Y scroll = [BG4 Y scroll]
$82:93D1 E2 30       SEP #$30
$82:93D3 A9 00       LDA #$00               ;\
$82:93D5 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:93D8 A9 30       LDA #$30               ;} VRAM address = $3000
$82:93DA 8D 17 21    STA $2117  [$7E:2117]  ;/
$82:93DD A9 80       LDA #$80               ;\
$82:93DF 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM address increment mode = 16-bit access
$82:93E2 20 3D 94    JSR $943D  [$82:943D]  ; Load pause menu map tilemap
$82:93E5 22 A9 91 80 JSL $8091A9[$80:91A9]  ;\
$82:93E9             dx 01,01,18,7E4000,1000;|
$82:93F1 A9 02       LDA #$02               ;} VRAM $3000..37FF = [$7E:4000..4FFF] (BG1 tilemap)
$82:93F3 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:93F6 A9 AA       LDA #$AA               ;\
$82:93F8 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:93FB A9 38       LDA #$38               ;} VRAM address = $38AA (BG2 tilemap, tile (15h, 2))
$82:93FD 8D 17 21    STA $2117  [$7E:2117]  ;/
$82:9400 A9 80       LDA #$80               ;\
$82:9402 8D 15 21    STA $2115  [$7E:2115]  ;} >_<;
$82:9405 A9 01       LDA #$01               ;\
$82:9407 8D 10 43    STA $4310  [$7E:4310]  ;} DMA 1 control = 16-bit write
$82:940A A9 18       LDA #$18               ;\
$82:940C 8D 11 43    STA $4311  [$7E:4311]  ;} DMA 1 target = VRAM
$82:940F A9 18       LDA #$18               ;\
$82:9411 8D 15 43    STA $4315  [$7E:4315]  ;|
$82:9414 A9 00       LDA #$00               ;} DMA 1 size = 18h
$82:9416 8D 16 43    STA $4316  [$7E:4316]  ;/
$82:9419 C2 30       REP #$30
$82:941B AD 9F 07    LDA $079F  [$7E:079F]  ; A = [area index]
$82:941E C9 07 00    CMP #$0007             ;\
$82:9421 30 03       BMI $03    [$9426]     ;} If [area index] >= debug:
$82:9423 A9 00 00    LDA #$0000             ; A = 0

$82:9426 0A          ASL A                  ;\
$82:9427 AA          TAX                    ;|
$82:9428 BD 5F 96    LDA $965F,x[$82:9661]  ;} DMA 1 source address = [$965F + [A] * 2] (area label tilemap)
$82:942B 8D 12 43    STA $4312  [$7E:4312]  ;/
$82:942E E2 20       SEP #$20
$82:9430 A9 82       LDA #$82               ;\
$82:9432 8D 14 43    STA $4314  [$7E:4314]  ;} DMA 1 source bank = $82
$82:9435 A9 02       LDA #$02               ;\
$82:9437 8D 0B 42    STA $420B  [$7E:420B]  ;} Execute DMA 1
$82:943A AB          PLB
$82:943B 28          PLP
$82:943C 6B          RTL
}


;;; $943D: Load pause menu map tilemap ;;;
{
$82:943D 08          PHP
$82:943E C2 30       REP #$30
$82:9440 AD 9F 07    LDA $079F  [$7E:079F]  ; $12 = [area index]
$82:9443 C9 07 00    CMP #$0007             ;\
$82:9446 30 03       BMI $03    [$944B]     ;} If [area index] >= debug:
$82:9448 A9 00 00    LDA #$0000             ; $12 = 0

$82:944B 85 12       STA $12    [$7E:0012]
$82:944D 0A          ASL A                  ;\
$82:944E 18          CLC                    ;|
$82:944F 65 12       ADC $12    [$7E:0012]  ;|
$82:9451 AA          TAX                    ;|
$82:9452 BD 4A 96    LDA $964A,x[$82:964D]  ;} $00 = [$964A + [$12] * 3] (source tilemap)
$82:9455 85 00       STA $00    [$7E:0000]  ;|
$82:9457 BD 4C 96    LDA $964C,x[$82:964F]  ;|
$82:945A 85 02       STA $02    [$7E:0002]  ;/
$82:945C A9 00 40    LDA #$4000             ;\
$82:945F 85 03       STA $03    [$7E:0003]  ;|
$82:9461 A9 7E 00    LDA #$007E             ;} $03 = $7E:4000 (destination tilemap)
$82:9464 85 05       STA $05    [$7E:0005]  ;/
$82:9466 A5 12       LDA $12    [$7E:0012]  ;\
$82:9468 0A          ASL A                  ;|
$82:9469 AA          TAX                    ;|
$82:946A A9 82 00    LDA #$0082             ;} $06 = $82:0000 + [$9717 + [$12] * 2] (map data)
$82:946D 85 08       STA $08    [$7E:0008]  ;|
$82:946F BF 17 97 82 LDA $829717,x[$82:9719];|
$82:9473 85 06       STA $06    [$7E:0006]  ;/
$82:9475 AE 9F 07    LDX $079F  [$7E:079F]  ;\
$82:9478 BF 08 D9 7E LDA $7ED908,x[$7E:D909];|
$82:947C 29 FF 00    AND #$00FF             ;} If area map collected: go to BRANCH_MAP_COLLECTED
$82:947F D0 3B       BNE $3B    [$94BC]     ;/
$82:9481 E2 20       SEP #$20
$82:9483 A0 00 00    LDY #$0000             ; Y = 0 (tilemap index)
$82:9486 A2 00 00    LDX #$0000             ; X = 0 (map data byte index)
$82:9489 64 12       STZ $12    [$7E:0012]  ; $12 = 0 (map data bit subindex)
$82:948B 18          CLC

; LOOP_WITHOUT_MAP_DATA
$82:948C 3E F7 07    ROL $07F7,x[$7E:07F7]  ;\
$82:948F B0 1D       BCS $1D    [$94AE]     ;} If [$07F7 + [X]] & 80h >> [$12] != 0: go to BRANCH_EXPLORED_MAP_TILE
$82:9491 C2 20       REP #$20
$82:9493 A9 1F 00    LDA #$001F             ;\
$82:9496 97 03       STA [$03],y[$7E:4000]  ;} [$03] + [Y] = 001Fh (blank tile)

; BRANCH_NEXT_WITHOUT_MAP_DATA
$82:9498 E2 20       SEP #$20
$82:949A C8          INY                    ;\
$82:949B C8          INY                    ;} Y += 2
$82:949C E6 12       INC $12    [$7E:0012]  ; Increment $12
$82:949E A5 12       LDA $12    [$7E:0012]  ;\
$82:94A0 C9 08       CMP #$08               ;} If [$12] < 8: go to LOOP
$82:94A2 30 E8       BMI $E8    [$948C]     ;/
$82:94A4 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$82:94A6 E8          INX                    ; Increment X
$82:94A7 E0 00 01    CPX #$0100             ;\
$82:94AA 30 E0       BMI $E0    [$948C]     ;} If [X] < 100h: go to LOOP
$82:94AC 28          PLP
$82:94AD 60          RTS                    ; Return

; BRANCH_EXPLORED_MAP_TILE
$82:94AE FE F7 07    INC $07F7,x[$7E:081E]
$82:94B1 C2 30       REP #$30
$82:94B3 B7 00       LDA [$00],y[$B5:8274]  ;\
$82:94B5 29 FF FB    AND #$FBFF             ;} [$03] + [Y] = [[$00] + [Y]] & ~400h
$82:94B8 97 03       STA [$03],y[$7E:4274]  ;/
$82:94BA 80 DC       BRA $DC    [$9498]     ; Go to BRANCH_NEXT_WITHOUT_MAP_DATA

; BRANCH_MAP_COLLECTED
$82:94BC C2 30       REP #$30
$82:94BE A7 06       LDA [$06]  [$82:9727]  ;\
$82:94C0 EB          XBA                    ;} $26 = [[$06]] << 8 | [[$06] + 1]
$82:94C1 85 26       STA $26    [$7E:0026]  ;/
$82:94C3 E6 06       INC $06    [$7E:0006]  ;\
$82:94C5 E6 06       INC $06    [$7E:0006]  ;} $06 += 2
$82:94C7 A9 00 00    LDA #$0000             ;\
$82:94CA 85 0B       STA $0B    [$7E:000B]  ;|
$82:94CC A9 F7 07    LDA #$07F7             ;} $09 = $00:07F7 (map tiles explored)
$82:94CF 85 09       STA $09    [$7E:0009]  ;/
$82:94D1 A7 09       LDA [$09]  [$7E:07F7]  ;\
$82:94D3 EB          XBA                    ;} $28 = [[$09]] << 8 | [[$09] + 1]
$82:94D4 85 28       STA $28    [$7E:0028]  ;/
$82:94D6 E6 09       INC $09    [$7E:0009]  ;\
$82:94D8 E6 09       INC $09    [$7E:0009]  ;} $09 += 2
$82:94DA A0 00 00    LDY #$0000             ; Y = 0 (tilemap index)
$82:94DD A2 10 00    LDX #$0010             ; X = 10h

; LOOP_WITH_MAP_DATA
$82:94E0 B7 00       LDA [$00],y[$B5:9000]  ; A = [[$00] + [Y]]
$82:94E2 06 28       ASL $28    [$7E:0028]  ;\
$82:94E4 90 07       BCC $07    [$94ED]     ;} If [$28] & (1 << [X]-1) != 0:
$82:94E6 29 FF FB    AND #$FBFF             ; A &= ~400h
$82:94E9 06 26       ASL $26    [$7E:0026]
$82:94EB 80 07       BRA $07    [$94F4]

$82:94ED 06 26       ASL $26    [$7E:0026]  ;\ Else ([$28] & (1 << [X]-1) = 0):
$82:94EF B0 03       BCS $03    [$94F4]     ;} If [$26] & (1 << [X]-1) = 0:
$82:94F1 A9 1F 00    LDA #$001F             ; A = 001Fh

$82:94F4 97 03       STA [$03],y[$7E:4000]  ; [$03] + [Y] = [A]
$82:94F6 CA          DEX                    ; Decrement X
$82:94F7 D0 15       BNE $15    [$950E]     ; If [X] = 0:
$82:94F9 A2 10 00    LDX #$0010             ; X = 10h
$82:94FC A7 06       LDA [$06]  [$82:9729]  ;\
$82:94FE EB          XBA                    ;} $26 = [[$06]] << 8 | [[$06] + 1]
$82:94FF 85 26       STA $26    [$7E:0026]  ;/
$82:9501 E6 06       INC $06    [$7E:0006]  ;\
$82:9503 E6 06       INC $06    [$7E:0006]  ;} $06 += 2
$82:9505 A7 09       LDA [$09]  [$7E:07F9]  ;\
$82:9507 EB          XBA                    ;} $28 = [[$09]] << 8 | [[$09] + 1]
$82:9508 85 28       STA $28    [$7E:0028]  ;/
$82:950A E6 09       INC $09    [$7E:0009]  ;\
$82:950C E6 09       INC $09    [$7E:0009]  ;} $09 += 2

$82:950E C8          INY                    ;\
$82:950F C8          INY                    ;} Y += 2
$82:9510 C0 00 10    CPY #$1000             ;\
$82:9513 30 CB       BMI $CB    [$94E0]     ;} If [Y] < 1000h: go to LOOP_WITH_MAP_DATA
$82:9515 28          PLP
$82:9516 60          RTS
}


;;; $9517: Draw room select map ;;;
{
; Similar to $943D, but different WRAM tilemap and some extra code
$82:9517 E2 30       SEP #$30
$82:9519 A9 33       LDA #$33               ;\
$82:951B 85 5D       STA $5D    [$7E:005D]  ;} BG1/2 tiles base address = $3000
$82:951D A9 13       LDA #$13               ;\
$82:951F 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$82:9521 A9 D8       LDA #$D8               ;\
$82:9523 85 B3       STA $B3    [$7E:00B3]  ;|
$82:9525 A9 FF       LDA #$FF               ;} BG1 Y scroll = -28h
$82:9527 85 B4       STA $B4    [$7E:00B4]  ;/
$82:9529 C2 30       REP #$30
$82:952B 4B          PHK                    ;\
$82:952C AB          PLB                    ;} DB = $82
$82:952D AD 9F 07    LDA $079F  [$7E:079F]  ; $12 = [area index]
$82:9530 C9 07 00    CMP #$0007             ;\
$82:9533 30 03       BMI $03    [$9538]     ;} If [area index] >= debug:
$82:9535 A9 00 00    LDA #$0000             ; $12 = 0

$82:9538 85 12       STA $12    [$7E:0012]
$82:953A 0A          ASL A                  ;\
$82:953B 18          CLC                    ;|
$82:953C 65 12       ADC $12    [$7E:0012]  ;|
$82:953E AA          TAX                    ;|
$82:953F BD 4A 96    LDA $964A,x[$82:964A]  ;} $00 = [$964A + [$12] * 3] (source tilemap)
$82:9542 85 00       STA $00    [$7E:0000]  ;|
$82:9544 BD 4C 96    LDA $964C,x[$82:964C]  ;|
$82:9547 85 02       STA $02    [$7E:0002]  ;/
$82:9549 A9 00 30    LDA #$3000             ;\
$82:954C 85 03       STA $03    [$7E:0003]  ;|
$82:954E A9 7E 00    LDA #$007E             ;} $03 = $7E:3000 (destination tilemap)
$82:9551 85 05       STA $05    [$7E:0005]  ;/
$82:9553 A5 12       LDA $12    [$7E:0012]  ;\
$82:9555 0A          ASL A                  ;|
$82:9556 AA          TAX                    ;|
$82:9557 A9 82 00    LDA #$0082             ;} $06 = $82:0000 + [$9717 + [$12] * 2] (map data)
$82:955A 85 08       STA $08    [$7E:0008]  ;|
$82:955C BF 17 97 82 LDA $829717,x[$82:9717];|
$82:9560 85 06       STA $06    [$7E:0006]  ;/
$82:9562 AE 9F 07    LDX $079F  [$7E:079F]  ;\
$82:9565 BF 08 D9 7E LDA $7ED908,x[$7E:D908];|
$82:9569 29 FF 00    AND #$00FF             ;} If area map collected: go to BRANCH_MAP_COLLECTED
$82:956C D0 3C       BNE $3C    [$95AA]     ;/
$82:956E E2 20       SEP #$20
$82:9570 A0 00 00    LDY #$0000             ; Y = 0 (tilemap index)
$82:9573 A2 00 00    LDX #$0000             ; X = 0 (map data byte index)
$82:9576 64 12       STZ $12    [$7E:0012]  ; $12 = 0 (map data bit subindex)
$82:9578 18          CLC

; LOOP_WITHOUT_MAP_DATA
$82:9579 3E F7 07    ROL $07F7,x[$7E:07F7]  ;\
$82:957C B0 1E       BCS $1E    [$959C]     ;} If [$07F7 + [X]] & 80h >> [$12] != 0: go to BRANCH_EXPLORED_MAP_TILE
$82:957E C2 20       REP #$20
$82:9580 A9 0F 00    LDA #$000F             ;\
$82:9583 97 03       STA [$03],y[$7E:3000]  ;} [$03] + [Y] = 000Fh (blank tile)

; BRANCH_NEXT_WITHOUT_MAP_DATA
$82:9585 E2 20       SEP #$20
$82:9587 C8          INY                    ;\
$82:9588 C8          INY                    ;} Y += 2
$82:9589 E6 12       INC $12    [$7E:0012]  ; Increment $12
$82:958B A5 12       LDA $12    [$7E:0012]  ;\
$82:958D C9 08       CMP #$08               ;} If [$12] < 8: go to LOOP
$82:958F 30 E8       BMI $E8    [$9579]     ;/
$82:9591 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$82:9593 E8          INX                    ; Increment X
$82:9594 E0 00 01    CPX #$0100             ;\
$82:9597 30 E0       BMI $E0    [$9579]     ;} If [X] < 100h: go to LOOP
$82:9599 4C 03 96    JMP $9603  [$82:9603]  ; Go to BRANCH_RETURN

; BRANCH_EXPLORED_MAP_TILE
$82:959C FE F7 07    INC $07F7,x[$7E:07FE]
$82:959F C2 30       REP #$30
$82:95A1 B7 00       LDA [$00],y[$B5:9076]  ;\
$82:95A3 29 FF FB    AND #$FBFF             ;} [$03] + [Y] = [[$00] + [Y]] & ~400h
$82:95A6 97 03       STA [$03],y[$7E:3076]  ;/
$82:95A8 80 DB       BRA $DB    [$9585]     ; Go to BRANCH_NEXT_WITHOUT_MAP_DATA

; BRANCH_MAP_COLLECTED
$82:95AA C2 30       REP #$30
$82:95AC A7 06       LDA [$06]              ;\
$82:95AE EB          XBA                    ;} $26 = [[$06]] << 8 | [[$06] + 1]
$82:95AF 85 26       STA $26    [$7E:0026]  ;/
$82:95B1 E6 06       INC $06    [$7E:0006]  ;\
$82:95B3 E6 06       INC $06    [$7E:0006]  ;} $06 += 2
$82:95B5 A9 00 00    LDA #$0000             ;\
$82:95B8 85 0B       STA $0B    [$7E:000B]  ;|
$82:95BA A9 F7 07    LDA #$07F7             ;} $09 = $00:07F7 (map tiles explored)
$82:95BD 85 09       STA $09    [$7E:0009]  ;/
$82:95BF A7 09       LDA [$09]              ;\
$82:95C1 EB          XBA                    ;} $28 = [[$09]] << 8 | [[$09] + 1]
$82:95C2 85 28       STA $28    [$7E:0028]  ;/
$82:95C4 E6 09       INC $09    [$7E:0009]  ;\
$82:95C6 E6 09       INC $09    [$7E:0009]  ;} $09 += 2
$82:95C8 A0 00 00    LDY #$0000             ; Y = 0 (tilemap index)
$82:95CB A2 10 00    LDX #$0010             ; X = 10h

; LOOP_WITH_MAP_DATA
$82:95CE B7 00       LDA [$00],y            ; A = [[$00] + [Y]]
$82:95D0 06 28       ASL $28    [$7E:0028]  ;\
$82:95D2 90 07       BCC $07    [$95DB]     ;} If [$28] & (1 << [X]-1) != 0:
$82:95D4 29 FF FB    AND #$FBFF             ; A &= ~400h
$82:95D7 06 26       ASL $26    [$7E:0026]
$82:95D9 80 07       BRA $07    [$95E2]

$82:95DB 06 26       ASL $26    [$7E:0026]  ;\ Else ([$28] & (1 << [X]-1) = 0):
$82:95DD B0 03       BCS $03    [$95E2]     ;} If [$26] & (1 << [X]-1) = 0:
$82:95DF A9 1F 00    LDA #$001F             ; A = 001Fh

$82:95E2 97 03       STA [$03],y            ; [$03] + [Y] = [A]
$82:95E4 CA          DEX                    ; Decrement X
$82:95E5 D0 15       BNE $15    [$95FC]     ; If [X] = 0:
$82:95E7 A2 10 00    LDX #$0010             ; X = 10h
$82:95EA A7 06       LDA [$06]              ;\
$82:95EC EB          XBA                    ;} $26 = [[$06]] << 8 | [[$06] + 1]
$82:95ED 85 26       STA $26    [$7E:0026]  ;/
$82:95EF E6 06       INC $06    [$7E:0006]  ;\
$82:95F1 E6 06       INC $06    [$7E:0006]  ;} $06 += 2
$82:95F3 A7 09       LDA [$09]              ;\
$82:95F5 EB          XBA                    ;} $28 = [[$09]] << 8 | [[$09] + 1]
$82:95F6 85 28       STA $28    [$7E:0028]  ;/
$82:95F8 E6 09       INC $09    [$7E:0009]  ;\
$82:95FA E6 09       INC $09    [$7E:0009]  ;} $09 += 2

$82:95FC C8          INY                    ;\
$82:95FD C8          INY                    ;} Y += 2
$82:95FE C0 00 10    CPY #$1000             ;\
$82:9601 30 CB       BMI $CB    [$95CE]     ;} If [Y] < 1000h: go to LOOP_WITH_MAP_DATA

; BRANCH_RETURN
$82:9603 C2 30       REP #$30
$82:9605 AE 30 03    LDX $0330  [$7E:0330]  ;\
$82:9608 A9 00 10    LDA #$1000             ;|
$82:960B 95 D0       STA $D0,x  [$7E:00D0]  ;|
$82:960D A9 00 30    LDA #$3000             ;|
$82:9610 95 D2       STA $D2,x  [$7E:00D2]  ;|
$82:9612 A9 7E 00    LDA #$007E             ;|
$82:9615 95 D4       STA $D4,x  [$7E:00D4]  ;|
$82:9617 A5 58       LDA $58    [$7E:0058]  ;} Queue transfer of 1000h bytes from $7E:3000 to VRAM BG1 tilemap
$82:9619 29 FC 00    AND #$00FC             ;|
$82:961C EB          XBA                    ;|
$82:961D 95 D5       STA $D5,x  [$7E:00D5]  ;|
$82:961F 8A          TXA                    ;|
$82:9620 18          CLC                    ;|
$82:9621 69 07 00    ADC #$0007             ;|
$82:9624 8D 30 03    STA $0330  [$7E:0330]  ;/
$82:9627 6B          RTL
}


;;; $9628: Draw room select map area label ;;;
{
;; Parameters:
;;     $00: Long pointer to tilemap
$82:9628 8B          PHB
$82:9629 4B          PHK                    ;\
$82:962A AB          PLB                    ;} DB = $82
$82:962B AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:962E 0A          ASL A                  ;|
$82:962F AA          TAX                    ;} X = [$965F + [area index] * 2]
$82:9630 BD 5F 96    LDA $965F,x[$82:965F]  ;|
$82:9633 AA          TAX                    ;/
$82:9634 A0 00 00    LDY #$0000             ; Y = 0

; LOOP
$82:9637 BD 00 00    LDA $0000,x[$82:966F]  ;\
$82:963A 29 FF EF    AND #$EFFF             ;} [$00] + [Y] = [[X]] & ~1000h (top palette index bit...)
$82:963D 97 00       STA [$00],y[$7E:4154]  ;/
$82:963F E8          INX                    ;\
$82:9640 E8          INX                    ;} X += 2
$82:9641 C8          INY                    ;\
$82:9642 C8          INY                    ;} Y += 2
$82:9643 C0 18 00    CPY #$0018             ;\
$82:9646 30 EF       BMI $EF    [$9637]     ;} If [Y] < 18h: go to LOOP
$82:9648 AB          PLB
$82:9649 6B          RTL
}


;;; $964A: Pointers to area maps ;;;
{
; Indexed by area, debug uses Crateria
$82:964A             dl B59000, B58000, B5A000, B5B000, B5C000, B5D000, B5E000
}


;;; $965F: Area label tilemaps ;;;
{
$82:965F             dw 966F, 9687, 969F, 96B7, 96CF, 96E7, 96FF, 96E7

$82:966F             dw 2801,2801,3832,3841,3830,3843,3834,3841,3838,2830,2801,2801 ; Crateria
$82:9687             dw 2801,2801,3831,3841,3838,383D,3842,3843,3830,3841,2801,2801 ; Brinstar
$82:969F             dw 2801,2801,383D,383E,3841,3835,3830,3838,3841,2801,2801,2801 ; Norfair
$82:96B7             dw 3846,3841,3834,3832,383A,3834,3833,2801,3842,3837,3838,383F ; Wrecked Ship
$82:96CF             dw 2801,2801,383C,3830,3841,3838,3833,3838,3830,2801,2801,2801 ; Maridia
$82:96E7             dw 2801,2801,3843,383E,3844,3841,3838,3830,383D,2801,2801,2801 ; Tourian / debug
$82:96FF             dw 2801,2801,2801,3832,383E,383B,383E,383D,3848,2801,2801,2801 ; Ceres
}


;;; $9717..9E26: Map data ;;;
{
; Laid out like in RAM
; From RAM map, $07F7..08F6:
;     Map tiles explored (for current area). One bit per room.
;     Laid out like a 64x32 1bpp VRAM tilemap:
;         2x1 pages of 32x32 map tiles (80h bytes per page, 4 bytes per row, 1 bit per tile),
;         each byte is 8 map tiles where the most significant bit is the leftmost tile.

;;; $9717: Map data pointers ;;;
{
$82:9717             dw 9727, 9827, 9927, 9A27, 9B27, 9C27, 9D27, 9C27
}


;;; $9727: Crateria ;;;
{
$82:9727             db 00,00,00,00,
                        00,00,00,7F,
                        00,00,00,7F,
                        00,00,00,7F,
                        00,00,00,7F,
                        00,01,FF,FF,
                        00,07,94,00,
                        00,1E,37,C0,
                        00,10,FF,00,
                        03,F0,10,00,
                        02,00,10,00,
                        02,00,10,00,
                        02,00,10,00,
                        00,00,10,00,
                        00,00,10,00,
                        00,00,10,00,
                        00,00,10,00,
                        00,00,10,00,
                        00,00,1F,00,
                        00,00,01,00,
                        00,00,01,00,
                        00,00,01,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                                    00,00,00,00,
                                    03,FC,00,00,
                                    03,FC,00,00,
                                    03,F0,00,00,
                                    03,F0,00,00,
                                    FF,FC,7F,80,
                                    0D,FC,7F,80,
                                    00,00,00,80,
                                    20,00,00,80,
                                    20,00,07,80,
                                    20,00,0F,80,
                                    20,00,08,00,
                                    00,00,08,00,
                                    00,00,08,00,
                                    00,00,08,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00
}


;;; $9827: Brinstar ;;;
{
$82:9827             db 00,00,00,00,
                        00,40,00,00,
                        00,40,02,00,
                        00,40,02,00,
                        00,40,02,00,
                        07,FD,FE,00,
                        00,C0,60,00,
                        03,FF,E0,00,
                        06,00,78,20,
                        00,00,7C,20,
                        00,00,60,20,
                        00,00,7E,7F,
                        00,00,1C,0C,
                        00,00,07,80,
                        00,FE,01,FF,
                        00,00,00,00,
                        00,00,01,FF,
                        00,00,00,66,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    04,00,00,00,
                                    04,00,00,00,
                                    04,00,00,00,
                                    04,00,00,00,
                                    1C,00,00,00,
                                    06,00,00,00,
                                    7C,00,00,00,
                                    C0,00,00,00,
                                    50,00,00,00,
                                    40,00,00,00,
                                    C0,00,00,00,
                                    40,00,00,00,
                                    C0,00,00,00,
                                    00,00,00,00,
                                    02,00,00,00,
                                    3F,FF,C1,80,
                                    00,79,FF,C0,
                                    00,40,00,00,
                                    00,40,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00
}


;;; $9927: Norfair ;;;
{
$82:9927             db 00,00,00,00,
                        00,20,00,00,
                        1E,20,00,FE,
                        1E,20,07,8F,
                        1F,FF,87,80,
                        3E,7F,FF,FC,
                        20,FF,FF,F8,
                        21,BE,1E,FC,
                        3F,1F,13,04,
                        03,C1,93,FC,
                        00,FF,FF,A0,
                        00,7F,F3,E0,
                        00,38,01,C0,
                        03,E0,01,80,
                        03,E0,00,00,
                        1E,20,00,00,
                        1F,3E,00,00,
                        1F,A0,01,00,
                        0F,F0,01,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    FC,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00
}


;;; $9A27: Wrecked Ship ;;;
{
$82:9A27             db 00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,0F,FC,00,
                        00,0F,00,00,
                        00,3E,00,00,
                        00,20,80,00,
                        00,0F,C4,00,
                        00,00,FC,00,
                        00,00,80,00,
                        00,01,80,00,
                        00,00,80,00,
                        00,07,F0,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00
}


;;; $9B27: Maridia ;;;
{
$82:9B27             db 00,00,00,00,
                        00,00,00,78,
                        00,00,00,58,
                        00,00,01,D8,
                        00,00,01,C0,
                        00,00,3F,C0,
                        00,00,FD,FF,
                        00,00,31,DF,
                        00,02,21,FF,
                        00,02,2F,BF,
                        00,3F,EF,C0,
                        00,3F,CF,FC,
                        00,37,9F,C0,
                        00,37,B0,00,
                        00,37,B0,00,
                        00,37,B0,00,
                        00,3E,70,00,
                        00,3F,FF,F0,
                        00,1F,C0,00,
                        00,7C,00,00,
                        00,18,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                                    00,00,00,00,
                                    20,00,00,00,
                                    20,00,00,00,
                                    20,00,00,00,
                                    20,00,00,00,
                                    30,00,00,00,
                                    E0,00,00,00,
                                    FF,E0,00,00,
                                    FF,E0,00,00,
                                    FE,00,00,00,
                                    01,80,00,00,
                                    03,80,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00
}


;;; $9C27: Tourian / debug ;;;
{
$82:9C27             db 00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,08,00,
                        00,00,08,00,
                        00,00,08,00,
                        00,00,08,00,
                        00,07,FC,00,
                        00,07,F8,00,
                        00,00,08,00,
                        00,0F,F8,00,
                        00,1F,C0,00,
                        00,00,C0,00,
                        00,07,C0,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00
}


;;; $9D27: Ceres ;;;
{
$82:9D27             db 00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,08,00,00,
                        00,08,00,00,
                        00,08,00,00,
                        00,08,00,00,
                        00,08,00,00,
                        00,0F,00,00,
                        00,01,F8,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                        00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00,
                                    00,00,00,00
}
}


;;; $9E27: Set up map scrolling for pause menu ;;;
{
;; Parameters:
;;     A: Always 80h. Affects BG1 Y scroll in some way
$82:9E27 C2 30       REP #$30
$82:9E29 85 14       STA $14    [$7E:0014]  ; $14 = [A]
$82:9E2B AD AE 05    LDA $05AE  [$7E:05AE]  ;\
$82:9E2E 38          SEC                    ;|
$82:9E2F ED AC 05    SBC $05AC  [$7E:05AC]  ;|
$82:9E32 4A          LSR A                  ;|
$82:9E33 18          CLC                    ;} BG1 X scroll = midpoint([map min X scroll], [map max X scroll]) - 80h
$82:9E34 6D AC 05    ADC $05AC  [$7E:05AC]  ;|
$82:9E37 38          SEC                    ;|
$82:9E38 E9 80 00    SBC #$0080             ;|
$82:9E3B 85 B1       STA $B1    [$7E:00B1]  ;/
$82:9E3D AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$82:9E40 29 00 FF    AND #$FF00             ;|
$82:9E43 EB          XBA                    ;|
$82:9E44 18          CLC                    ;|
$82:9E45 6D A1 07    ADC $07A1  [$7E:07A1]  ;|
$82:9E48 0A          ASL A                  ;} $12 = ([room X co-ordinate] + [Samus X position] / 100h) * 8 - [BG1 X scroll]
$82:9E49 0A          ASL A                  ;|
$82:9E4A 0A          ASL A                  ;|
$82:9E4B 38          SEC                    ;|
$82:9E4C E5 B1       SBC $B1    [$7E:00B1]  ;|
$82:9E4E 85 12       STA $12    [$7E:0012]  ;/
$82:9E50 A9 E0 00    LDA #$00E0             ;\
$82:9E53 38          SEC                    ;|
$82:9E54 E5 12       SBC $12    [$7E:0012]  ;} If [$12] > E0h:
$82:9E56 10 0B       BPL $0B    [$9E63]     ;/
$82:9E58 85 12       STA $12    [$7E:0012]  ;\
$82:9E5A A5 B1       LDA $B1    [$7E:00B1]  ;|
$82:9E5C 38          SEC                    ;} BG1 X scroll += [$12] - E0h
$82:9E5D E5 12       SBC $12    [$7E:0012]  ;|
$82:9E5F 85 B1       STA $B1    [$7E:00B1]  ;/
$82:9E61 80 11       BRA $11    [$9E74]

$82:9E63 A9 20 00    LDA #$0020             ;\ Else ([$12] <= E0h):
$82:9E66 38          SEC                    ;|
$82:9E67 E5 12       SBC $12    [$7E:0012]  ;} If [$12] <= 20h:
$82:9E69 85 12       STA $12    [$7E:0012]  ;|
$82:9E6B 30 07       BMI $07    [$9E74]     ;/
$82:9E6D A5 B1       LDA $B1    [$7E:00B1]  ;\
$82:9E6F 38          SEC                    ;|
$82:9E70 E5 12       SBC $12    [$7E:0012]  ;} BG1 X scroll -= 20h - [$12]
$82:9E72 85 B1       STA $B1    [$7E:00B1]  ;/

$82:9E74 AD B2 05    LDA $05B2  [$7E:05B2]  ;\
$82:9E77 38          SEC                    ;|
$82:9E78 ED B0 05    SBC $05B0  [$7E:05B0]  ;|
$82:9E7B 4A          LSR A                  ;|
$82:9E7C 18          CLC                    ;|
$82:9E7D 69 10 00    ADC #$0010             ;|
$82:9E80 18          CLC                    ;|
$82:9E81 6D B0 05    ADC $05B0  [$7E:05B0]  ;|
$82:9E84 85 12       STA $12    [$7E:0012]  ;} BG1 Y scroll = midpoint([map min Y scroll], [map max Y scroll]) - [$14] + 10h rounded up to multiple of 8
$82:9E86 A5 14       LDA $14    [$7E:0014]  ;|
$82:9E88 38          SEC                    ;|
$82:9E89 E5 12       SBC $12    [$7E:0012]  ;|
$82:9E8B 29 F8 FF    AND #$FFF8             ;|
$82:9E8E 49 FF FF    EOR #$FFFF             ;|
$82:9E91 1A          INC A                  ;|
$82:9E92 85 B3       STA $B3    [$7E:00B3]  ;/
$82:9E94 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$82:9E97 EB          XBA                    ;|
$82:9E98 29 FF 00    AND #$00FF             ;|
$82:9E9B 18          CLC                    ;|
$82:9E9C 6D A3 07    ADC $07A3  [$7E:07A3]  ;|
$82:9E9F 1A          INC A                  ;|
$82:9EA0 0A          ASL A                  ;} $12 = ([room Y co-ordinate] + [Samus Y position] / 100h + 1) * 8 - [BG1 Y scroll]
$82:9EA1 0A          ASL A                  ;|
$82:9EA2 0A          ASL A                  ;|
$82:9EA3 38          SEC                    ;|
$82:9EA4 E5 B3       SBC $B3    [$7E:00B3]  ;|
$82:9EA6 85 12       STA $12    [$7E:0012]  ;/
$82:9EA8 A9 40 00    LDA #$0040             ;\
$82:9EAB 38          SEC                    ;|
$82:9EAC E5 12       SBC $12    [$7E:0012]  ;} If [$12] <= 40h:
$82:9EAE 30 13       BMI $13    [$9EC3]     ;/
$82:9EB0 85 12       STA $12    [$7E:0012]  ;\
$82:9EB2 A5 B3       LDA $B3    [$7E:00B3]  ;|
$82:9EB4 38          SEC                    ;} BG1 Y scroll -= 40h - [$12]
$82:9EB5 E5 12       SBC $12    [$7E:0012]  ;|
$82:9EB7 85 B3       STA $B3    [$7E:00B3]  ;/
$82:9EB9 C9 D8 FF    CMP #$FFD8             ;\
$82:9EBC 10 05       BPL $05    [$9EC3]     ;|
$82:9EBE A9 D8 FF    LDA #$FFD8             ;} BG1 Y scroll = max([BG1 Y scroll], -28h)
$82:9EC1 85 B3       STA $B3    [$7E:00B3]  ;/

$82:9EC3 60          RTS
}


;;; $9EC4: Determine map scroll limits ;;;
{
$82:9EC4 08          PHP
$82:9EC5 8B          PHB
$82:9EC6 AD 89 07    LDA $0789  [$7E:0789]  ;\
$82:9EC9 F0 15       BEQ $15    [$9EE0]     ;} If area map has been collected:
$82:9ECB A9 82 00    LDA #$0082             ;\
$82:9ECE 85 08       STA $08    [$7E:0008]  ;} $08 = $82
$82:9ED0 A9 17 97    LDA #$9717             ;\
$82:9ED3 85 06       STA $06    [$7E:0006]  ;|
$82:9ED5 AD 9F 07    LDA $079F  [$7E:079F]  ;|
$82:9ED8 0A          ASL A                  ;} $06 = [$82:9717 + [area index] * 2] (map data pointer)
$82:9ED9 A8          TAY                    ;|
$82:9EDA B7 06       LDA [$06],y[$82:9717]  ;|
$82:9EDC 85 06       STA $06    [$7E:0006]  ;/
$82:9EDE 80 0A       BRA $0A    [$9EEA]

$82:9EE0 A9 00 00    LDA #$0000             ;\ Else (area map has not been collected):
$82:9EE3 85 08       STA $08    [$7E:0008]  ;|
$82:9EE5 A9 F7 07    LDA #$07F7             ;} $06 = $00:07F7 (map tiles explored)
$82:9EE8 85 06       STA $06    [$7E:0006]  ;/

$82:9EEA 4B          PHK                    ;\
$82:9EEB AB          PLB                    ;} DB = $82
$82:9EEC E2 20       SEP #$20               ;\
$82:9EEE A5 08       LDA $08    [$7E:0008]  ;|
$82:9EF0 85 02       STA $02    [$7E:0002]  ;|
$82:9EF2 C2 20       REP #$20               ;} $00 = [$06]
$82:9EF4 A5 06       LDA $06    [$7E:0006]  ;|
$82:9EF6 85 00       STA $00    [$7E:0000]  ;/
$82:9EF8 20 4A 9F    JSR $9F4A  [$82:9F4A]  ; Determine leftmost map column
$82:9EFB 20 45 9F    JSR $9F45  [$82:9F45]  ;\
$82:9EFE 8D AC 05    STA $05AC  [$7E:05AC]  ;} Map min X scroll = [X] * 8
$82:9F01 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:9F04 C9 04 00    CMP #$0004             ;} If [area index] = Maridia:
$82:9F07 D0 0A       BNE $0A    [$9F13]     ;/
$82:9F09 AD AC 05    LDA $05AC  [$7E:05AC]  ;\
$82:9F0C 38          SEC                    ;|
$82:9F0D E9 18 00    SBC #$0018             ;} Map min X scroll -= 18h
$82:9F10 8D AC 05    STA $05AC  [$7E:05AC]  ;/

$82:9F13 A5 06       LDA $06    [$7E:0006]  ;\
$82:9F15 18          CLC                    ;|
$82:9F16 69 83 00    ADC #$0083             ;} $00 = [$06] + 83h (byte index of rightmost map column of top row)
$82:9F19 85 00       STA $00    [$7E:0000]  ;/
$82:9F1B 20 A9 9F    JSR $9FA9  [$82:9FA9]  ; Determine rightmost map column
$82:9F1E 20 45 9F    JSR $9F45  [$82:9F45]  ;\
$82:9F21 8D AE 05    STA $05AE  [$7E:05AE]  ;} Map max X scroll = [X] * 8
$82:9F24 A5 06       LDA $06    [$7E:0006]  ;\
$82:9F26 85 00       STA $00    [$7E:0000]  ;} $00 = [$06]
$82:9F28 20 09 A0    JSR $A009  [$82:A009]  ; Determine topmost map row
$82:9F2B 20 45 9F    JSR $9F45  [$82:9F45]  ;\
$82:9F2E 8D B0 05    STA $05B0  [$7E:05B0]  ;} Map min Y scroll = [X] * 8
$82:9F31 A5 06       LDA $06    [$7E:0006]  ;\
$82:9F33 18          CLC                    ;|
$82:9F34 69 7C 00    ADC #$007C             ;} $00 = [$06] + 7Ch (byte index of leftmost map column of bottom row)
$82:9F37 85 00       STA $00    [$7E:0000]  ;/
$82:9F39 20 53 A0    JSR $A053  [$82:A053]  ; Determine bottommost map row
$82:9F3C 20 45 9F    JSR $9F45  [$82:9F45]  ;\
$82:9F3F 8D B2 05    STA $05B2  [$7E:05B2]  ;} Map max Y scroll = [X] * 8
$82:9F42 AB          PLB
$82:9F43 28          PLP
$82:9F44 60          RTS
}


;;; $9F45: A = [X] * 8 ;;;
{
$82:9F45 8A          TXA
$82:9F46 0A          ASL A
$82:9F47 0A          ASL A
$82:9F48 0A          ASL A
$82:9F49 60          RTS
}


;;; $9F4A: Determine leftmost map column ;;;
{
;; Parameters:
;;     $00: Long pointer to map data
;; Returns:
;;     X: Leftmost map column (or 1Ah if map is empty)
$82:9F4A 08          PHP
$82:9F4B E2 20       SEP #$20
$82:9F4D A9 00       LDA #$00               ;\
$82:9F4F EB          XBA                    ;} >_<;
$82:9F50 A9 00       LDA #$00               ;/
$82:9F52 A2 00 00    LDX #$0000             ; X = 0 (map column)

; LOOP_COLUMNS
$82:9F55 8A          TXA                    ;\
$82:9F56 29 07       AND #$07               ;} Y = [X] % 8 (bit subindex of map tile)
$82:9F58 A8          TAY                    ;/
$82:9F59 B9 A1 9F    LDA $9FA1,y[$82:9FA1]  ;\
$82:9F5C 85 12       STA $12    [$7E:0012]  ;} $12 = 80h >> [Y]
$82:9F5E A0 00 00    LDY #$0000             ; Y = 0 (byte index of map tile)

; LOOP_ROWS
$82:9F61 B7 00       LDA [$00],y[$7E:07F7]  ;\
$82:9F63 24 12       BIT $12    [$7E:0012]  ;} If [[$00] + [Y]] & [$12] != 0: return
$82:9F65 D0 38       BNE $38    [$9F9F]     ;/
$82:9F67 C8          INY                    ;\
$82:9F68 C8          INY                    ;|
$82:9F69 C8          INY                    ;} Y += 4 (next map row)
$82:9F6A C8          INY                    ;/
$82:9F6B C0 80 00    CPY #$0080             ;\
$82:9F6E 30 F1       BMI $F1    [$9F61]     ;} If [Y] < 80h: go to LOOP_ROWS
$82:9F70 E8          INX                    ; Increment X
$82:9F71 E0 40 00    CPX #$0040             ;\
$82:9F74 10 26       BPL $26    [$9F9C]     ;} If [X] >= 40h: go to BRANCH_EMPTY_MAP
$82:9F76 8A          TXA                    ;\
$82:9F77 29 07       AND #$07               ;} If [X] % 8 = 0:
$82:9F79 D0 0D       BNE $0D    [$9F88]     ;/
$82:9F7B A5 00       LDA $00    [$7E:0000]  ;\
$82:9F7D 18          CLC                    ;|
$82:9F7E 69 01       ADC #$01               ;|
$82:9F80 85 00       STA $00    [$7E:0000]  ;} Increment $00
$82:9F82 A5 01       LDA $01    [$7E:0001]  ;|
$82:9F84 69 00       ADC #$00               ;|
$82:9F86 85 01       STA $01    [$7E:0001]  ;/

$82:9F88 E0 20 00    CPX #$0020             ;\
$82:9F8B D0 C8       BNE $C8    [$9F55]     ;} If [X] != 20h: go to LOOP_COLUMNS
$82:9F8D A5 00       LDA $00    [$7E:0000]  ;\
$82:9F8F 18          CLC                    ;|
$82:9F90 69 7B       ADC #$7B               ;|
$82:9F92 85 00       STA $00    [$7E:0000]  ;} $00 += 80h - 4 - 1 (80h to get to right map page, 4 to go to back to start of row, 1 to undo the increment that just happened)
$82:9F94 A5 01       LDA $01    [$7E:0001]  ;|
$82:9F96 69 00       ADC #$00               ;|
$82:9F98 85 01       STA $01    [$7E:0001]  ;/
$82:9F9A 80 B9       BRA $B9    [$9F55]     ; Go to LOOP_COLUMNS

; BRANCH_EMPTY_MAP
$82:9F9C A2 1A 00    LDX #$001A             ; X = 1Ah

$82:9F9F 28          PLP
$82:9FA0 60          RTS

$82:9FA1             db 80, 40, 20, 10, 08, 04, 02, 01
}


;;; $9FA9: Determine rightmost map column ;;;
{
;; Parameters:
;;     $00: Long pointer to map data + 83h (byte index of rightmost map column of top row)
;; Returns:
;;     X: Rightmost map column (or 1Ch if map is empty)
$82:9FA9 08          PHP
$82:9FAA E2 20       SEP #$20
$82:9FAC A9 00       LDA #$00               ;\
$82:9FAE EB          XBA                    ;} >_<;
$82:9FAF A9 00       LDA #$00               ;/
$82:9FB1 A2 3F 00    LDX #$003F             ; X = 3Fh (map column)

; LOOP_COLUMNS
$82:9FB4 8A          TXA                    ;\
$82:9FB5 29 07       AND #$07               ;} Y = [X] % 8 (bit subindex of map tile)
$82:9FB7 A8          TAY                    ;/
$82:9FB8 B9 01 A0    LDA $A001,y[$82:A008]  ;\
$82:9FBB 85 12       STA $12    [$7E:0012]  ;} $12 = 80h >> [Y]
$82:9FBD A0 00 00    LDY #$0000             ; Y = 0 (byte index of map tile)

; LOOP_ROWS
$82:9FC0 B7 00       LDA [$00],y[$7E:087A]  ;\
$82:9FC2 24 12       BIT $12    [$7E:0012]  ;} If [[$00] + [Y]] & [$12] != 0: return
$82:9FC4 D0 39       BNE $39    [$9FFF]     ;/
$82:9FC6 C8          INY                    ;\
$82:9FC7 C8          INY                    ;|
$82:9FC8 C8          INY                    ;} Y += 4 (next map row)
$82:9FC9 C8          INY                    ;/
$82:9FCA C0 80 00    CPY #$0080             ;\
$82:9FCD 30 F1       BMI $F1    [$9FC0]     ;} If [Y] < 80h: go to LOOP_ROWS
$82:9FCF CA          DEX                    ; Decrement X
$82:9FD0 30 2A       BMI $2A    [$9FFC]     ; If [X] < 0: go to BRANCH_EMPTY_MAP
$82:9FD2 8A          TXA                    ;\
$82:9FD3 29 07       AND #$07               ;|
$82:9FD5 C9 07       CMP #$07               ;} If [X] % 8 = 7:
$82:9FD7 D0 0D       BNE $0D    [$9FE6]     ;/
$82:9FD9 A5 00       LDA $00    [$7E:0000]  ;\
$82:9FDB 38          SEC                    ;|
$82:9FDC E9 01       SBC #$01               ;|
$82:9FDE 85 00       STA $00    [$7E:0000]  ;} Decrement $00
$82:9FE0 A5 01       LDA $01    [$7E:0001]  ;|
$82:9FE2 E9 00       SBC #$00               ;|
$82:9FE4 85 01       STA $01    [$7E:0001]  ;/

$82:9FE6 E0 1F 00    CPX #$001F             ;\
$82:9FE9 D0 C9       BNE $C9    [$9FB4]     ;} If [X] != 1Fh: go to LOOP_COLUMNS
$82:9FEB C2 20       REP #$20
$82:9FED A5 00       LDA $00    [$7E:0000]  ;\
$82:9FEF 38          SEC                    ;|
$82:9FF0 E9 7C 00    SBC #$007C             ;} $00 += 3 + 1 - 80h (80h to get to left map page, 3 to go to back to end of row, 1 to undo the decrement that just happened))
$82:9FF3 85 00       STA $00    [$7E:0000]  ;/
$82:9FF5 A9 00 00    LDA #$0000             ; >_<;
$82:9FF8 E2 20       SEP #$20
$82:9FFA 80 B8       BRA $B8    [$9FB4]     ; Go to LOOP_COLUMNS

; BRANCH_EMPTY_MAP
$82:9FFC A2 1C 00    LDX #$001C             ; X = 1Ch

$82:9FFF 28          PLP
$82:A000 60          RTS

$82:A001             db 80, 40, 20, 10, 08, 04, 02, 01
}


;;; $A009: Determine topmost map row ;;;
{
;; Parameters:
;;     $00: Long pointer to map data
;; Returns:
;;     X: Topmost map row (or 1 if map is empty)
$82:A009 08          PHP
$82:A00A C2 20       REP #$20
$82:A00C A5 00       LDA $00    [$7E:0000]  ;\
$82:A00E 18          CLC                    ;|
$82:A00F 69 80 00    ADC #$0080             ;} $03 = [$00] + 80h (pointer to right map page)
$82:A012 85 03       STA $03    [$7E:0003]  ;/
$82:A014 A9 00 00    LDA #$0000             ; >_<;
$82:A017 E2 20       SEP #$20
$82:A019 A5 02       LDA $02    [$7E:0002]  ;\
$82:A01B 85 05       STA $05    [$7E:0005]  ;} $05 = [$02]
$82:A01D A2 00 00    LDX #$0000             ; X = 0 (map row)
$82:A020 A0 00 00    LDY #$0000             ; Y = 0 (byte offset of map tile in row)

; LOOP
$82:A023 B7 00       LDA [$00],y[$7E:07F7]  ;\
$82:A025 D0 2A       BNE $2A    [$A051]     ;} If [[$00] + [Y]] != 0: return
$82:A027 B7 03       LDA [$03],y[$7E:0877]  ;\
$82:A029 D0 26       BNE $26    [$A051]     ;} If [[$03] + [Y]] != 0: return
$82:A02B C8          INY                    ; Increment Y
$82:A02C C0 04 00    CPY #$0004             ;\
$82:A02F 30 F2       BMI $F2    [$A023]     ;} If [Y] < 4: go to LOOP
$82:A031 A0 00 00    LDY #$0000             ; Y = 0
$82:A034 C2 20       REP #$20
$82:A036 A5 00       LDA $00    [$7E:0000]  ;\
$82:A038 18          CLC                    ;|
$82:A039 69 04 00    ADC #$0004             ;} $00 += 4 (next row)
$82:A03C 85 00       STA $00    [$7E:0000]  ;/
$82:A03E A5 03       LDA $03    [$7E:0003]  ;\
$82:A040 18          CLC                    ;|
$82:A041 69 04 00    ADC #$0004             ;} $03 += 4 (next row)
$82:A044 85 03       STA $03    [$7E:0003]  ;/
$82:A046 E2 20       SEP #$20
$82:A048 E8          INX                    ; Increment X
$82:A049 E0 1F 00    CPX #$001F             ;\
$82:A04C 30 D5       BMI $D5    [$A023]     ;} If [X] < 1Fh: go to LOOP
$82:A04E A2 01 00    LDX #$0001             ; X = 1

$82:A051 28          PLP
$82:A052 60          RTS
}


;;; $A053: Determine bottommost map row ;;;
{
;; Parameters:
;;     $00: Long pointer to map data + 7Ch (byte index of leftmost map column of bottom row)
;; Returns:
;;     X: Bottommost map row (or Bh if map is empty)
$82:A053 08          PHP
$82:A054 C2 20       REP #$20
$82:A056 A5 00       LDA $00    [$7E:0000]  ;\
$82:A058 18          CLC                    ;|
$82:A059 69 80 00    ADC #$0080             ;} $03 = [$00] + 80h (pointer to right map page)
$82:A05C 85 03       STA $03    [$7E:0003]  ;/
$82:A05E A9 00 00    LDA #$0000             ; >_<;
$82:A061 E2 20       SEP #$20
$82:A063 A5 02       LDA $02    [$7E:0002]  ;\
$82:A065 85 05       STA $05    [$7E:0005]  ;} $05 = [$02]
$82:A067 A2 1F 00    LDX #$001F             ; X = 1Fh (map row)
$82:A06A A0 00 00    LDY #$0000             ; Y = 0 (byte offset of map tile in row)

; LOOP
$82:A06D B7 00       LDA [$00],y[$7E:0873]  ;\
$82:A06F D0 27       BNE $27    [$A098]     ;} If [[$00] + [Y]] != 0: return
$82:A071 B7 03       LDA [$03],y[$7E:08F3]  ;\
$82:A073 D0 23       BNE $23    [$A098]     ;} If [[$03] + [Y]] != 0: return
$82:A075 C8          INY                    ; Increment Y
$82:A076 C0 04 00    CPY #$0004             ;\
$82:A079 30 F2       BMI $F2    [$A06D]     ;} If [Y] < 4: go to LOOP
$82:A07B A0 00 00    LDY #$0000             ; Y = 0
$82:A07E C2 20       REP #$20
$82:A080 A5 00       LDA $00    [$7E:0000]  ;\
$82:A082 38          SEC                    ;|
$82:A083 E9 04 00    SBC #$0004             ;} $00 -= 4 (previous row)
$82:A086 85 00       STA $00    [$7E:0000]  ;/
$82:A088 A5 03       LDA $03    [$7E:0003]  ;\
$82:A08A 38          SEC                    ;|
$82:A08B E9 04 00    SBC #$0004             ;} $03 -= 4 (previous row)
$82:A08E 85 03       STA $03    [$7E:0003]  ;/
$82:A090 E2 20       SEP #$20
$82:A092 CA          DEX                    ; Decrement X
$82:A093 D0 D8       BNE $D8    [$A06D]     ; If [X] != 0: go to LOOP
$82:A095 A2 0B 00    LDX #$000B             ; X = Bh

$82:A098 28          PLP
$82:A099 60          RTS
}
}


;;; $A09A: Set up PPU for pause menu ;;;
{
$82:A09A E2 30       SEP #$30
$82:A09C A9 01       LDA #$01               ;\
$82:A09E 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $2000, sprite sizes = 8x8 / 16x16
$82:A0A1 85 52       STA $52    [$7E:0052]  ;/
$82:A0A3 A9 09       LDA #$09               ;\
$82:A0A5 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 1 with BG3 priority, BG tile sizes = 8x8
$82:A0A8 85 55       STA $55    [$7E:0055]  ;/
$82:A0AA 64 5D       STZ $5D    [$7E:005D]  ;\
$82:A0AC 9C 0B 21    STZ $210B  [$7E:210B]  ;} BG1/2 tiles base address = $0000
$82:A0AF A9 04       LDA #$04               ;\
$82:A0B1 85 5E       STA $5E    [$7E:005E]  ;} BG3 tiles base address = $4000
$82:A0B3 8D 0C 21    STA $210C  [$7E:210C]  ;/
$82:A0B6 A9 31       LDA #$31               ;\
$82:A0B8 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $3000, size = 64x32
$82:A0BA 8D 07 21    STA $2107  [$7E:2107]  ;/
$82:A0BD A9 38       LDA #$38               ;\
$82:A0BF 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $3800, size = 32x32
$82:A0C1 8D 08 21    STA $2108  [$7E:2108]  ;/
$82:A0C4 A9 58       LDA #$58               ;\
$82:A0C6 85 5A       STA $5A    [$7E:005A]  ;} BG3 tilemap base address = $5800, size = 32x32
$82:A0C8 8D 09 21    STA $2109  [$7E:2109]  ;/
$82:A0CB A9 00       LDA #$00               ;\
$82:A0CD 85 5C       STA $5C    [$7E:005C]  ;} BG4 tilemap base address = $0000, size = 32x32
$82:A0CF 8D 0A 21    STA $210A  [$7E:210A]  ;/
$82:A0D2 A9 17       LDA #$17               ;\
$82:A0D4 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG1/BG2/BG3/sprites
$82:A0D7 85 69       STA $69    [$7E:0069]  ;/
$82:A0D9 A9 00       LDA #$00               ;\
$82:A0DB 8D 06 21    STA $2106  [$7E:2106]  ;} Disable mosaic
$82:A0DE 85 57       STA $57    [$7E:0057]  ;/
$82:A0E0 A5 74       LDA $74    [$7E:0074]  ;\
$82:A0E2 29 E0       AND #$E0               ;|
$82:A0E4 85 74       STA $74    [$7E:0074]  ;|
$82:A0E6 A5 75       LDA $75    [$7E:0075]  ;|
$82:A0E8 29 E0       AND #$E0               ;} Colour math subscreen backdrop colour = (0, 0, 0)
$82:A0EA 85 75       STA $75    [$7E:0075]  ;|
$82:A0EC A5 76       LDA $76    [$7E:0076]  ;|
$82:A0EE 29 E0       AND #$E0               ;|
$82:A0F0 85 76       STA $76    [$7E:0076]  ;/
$82:A0F2 A9 00       LDA #$00               ;\
$82:A0F4 85 71       STA $71    [$7E:0071]  ;} Disable colour math
$82:A0F6 60          RTS
}


;;; $A0F7: Reset pause menu animations ;;;
{
$82:A0F7 C2 30       REP #$30
$82:A0F9 9C 57 07    STZ $0757  [$7E:0757]  ; $0757 = 0
$82:A0FC 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$82:A0FE 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$82:A100 64 B9       STZ $B9    [$7E:00B9]  ; BG3 X scroll = 0
$82:A102 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$82:A104 64 BB       STZ $BB    [$7E:00BB]  ; BG3 Y scroll = 0
$82:A106 9C 53 07    STZ $0753  [$7E:0753]  ; Pause screen button label mode = map screen
$82:A109 9C 3F 07    STZ $073F  [$7E:073F]  ; L/R highlight animation frame = 0
$82:A10C 9C 45 07    STZ $0745  [$7E:0745]  ; $0745 = 0
$82:A10F 9C 76 07    STZ $0776  [$7E:0776]  ; Samus position indicator animation frame = 0
$82:A112 9C 78 07    STZ $0778  [$7E:0778]  ; Samus position indicator animation timer = 0
$82:A115 9C 7A 07    STZ $077A  [$7E:077A]  ; Samus position indicator animation loop counter = 0
$82:A118 AD 0C C1    LDA $C10C  [$82:C10C]  ;\
$82:A11B 8D 2B 07    STA $072B  [$7E:072B]  ;} L/R highlight animation timer = Fh
$82:A11E A9 01 00    LDA #$0001             ;\
$82:A121 8D 3B 07    STA $073B  [$7E:073B]  ;} Pause screen palette animation timer = 1
$82:A124 A9 00 00    LDA #$0000             ;\
$82:A127 8D 4F 07    STA $074F  [$7E:074F]  ;} Pause screen palette animation frame = 0
$82:A12A 60          RTS
}


;;; $A12B: Load equipment screen equipment tilemaps ;;;
{
$82:A12B C2 30       REP #$30
$82:A12D AD D4 09    LDA $09D4  [$7E:09D4]  ;\
$82:A130 F0 38       BEQ $38    [$A16A]     ;} If [Samus max reserve health] != 0:
$82:A132 A0 00 00    LDY #$0000             ;\
$82:A135 A9 68 C0    LDA #$C068             ;|
$82:A138 85 03       STA $03    [$7E:0003]  ;|
$82:A13A A9 82 00    LDA #$0082             ;|
$82:A13D 85 05       STA $05    [$7E:0005]  ;|
$82:A13F B7 03       LDA [$03],y[$82:C068]  ;} Equipment screen BG1 tilemap tile (4..Ah, Ah) = [$BF06..13] (equipment tilemap - tanks - mode)
$82:A141 85 00       STA $00    [$7E:0000]  ;|
$82:A143 AE 88 C0    LDX $C088  [$82:C088]  ;|
$82:A146 A9 0E 00    LDA #$000E             ;|
$82:A149 85 16       STA $16    [$7E:0016]  ;|
$82:A14B 20 7E A2    JSR $A27E  [$82:A27E]  ;/
$82:A14E A0 02 00    LDY #$0002             ;\
$82:A151 A9 68 C0    LDA #$C068             ;|
$82:A154 85 03       STA $03    [$7E:0003]  ;|
$82:A156 A9 82 00    LDA #$0082             ;|
$82:A159 85 05       STA $05    [$7E:0005]  ;|
$82:A15B B7 03       LDA [$03],y[$82:C06A]  ;} Equipment screen BG1 tilemap tile (4..Ah, Bh) = [$BF14..21] (equipment tilemap - tanks - reserve tank)
$82:A15D 85 00       STA $00    [$7E:0000]  ;|
$82:A15F AE 8A C0    LDX $C08A  [$82:C08A]  ;|
$82:A162 A9 0E 00    LDA #$000E             ;|
$82:A165 85 16       STA $16    [$7E:0016]  ;|
$82:A167 20 7E A2    JSR $A27E  [$82:A27E]  ;/

$82:A16A A0 00 00    LDY #$0000             ; Y = 0
$82:A16D A9 6C C0    LDA #$C06C             ;\
$82:A170 85 03       STA $03    [$7E:0003]  ;|
$82:A172 A9 82 00    LDA #$0082             ;} $03 = $82:C06C (RAM tilemap offsets pointer - weapons)
$82:A175 85 05       STA $05    [$7E:0005]  ;/
$82:A177 B7 03       LDA [$03],y[$82:C06C]  ;\
$82:A179 85 00       STA $00    [$7E:0000]  ;} $00 = [$82:C06C] (RAM tilemap offset)
$82:A17B AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$82:A17E D0 42       BNE $42    [$A1C2]     ;} If hyper beam is enabled: go to BRANCH_HYPER_BEAM

; LOOP_WEAPONS
$82:A180 B9 4C C0    LDA $C04C,y[$82:C04C]  ;\
$82:A183 2C A8 09    BIT $09A8  [$7E:09A8]  ;} If [collected beams] & [$C04C + [Y]] = 0:
$82:A186 D0 0D       BNE $0D    [$A195]     ;/
$82:A188 A2 1A C0    LDX #$C01A             ;\
$82:A18B A9 0A 00    LDA #$000A             ;|
$82:A18E 85 16       STA $16    [$7E:0016]  ;} Copy Ah bytes from $C01A to [$00] (blank placeholder)
$82:A190 20 7E A2    JSR $A27E  [$82:A27E]  ;/
$82:A193 80 20       BRA $20    [$A1B5]

$82:A195 BE 8C C0    LDX $C08C,y[$82:C08C]  ;\ Else ([collected beams] & [$C04C + [Y]] != 0):
$82:A198 A9 0A 00    LDA #$000A             ;|
$82:A19B 85 16       STA $16    [$7E:0016]  ;} Copy Ah bytes from [$C08C + [Y]] to [$00] (weapons tilemap)
$82:A19D 20 7E A2    JSR $A27E  [$82:A27E]  ;/
$82:A1A0 B9 4C C0    LDA $C04C,y[$82:C04C]  ;\
$82:A1A3 2C A6 09    BIT $09A6  [$7E:09A6]  ;} If [equipped beams] & [$C04C + [Y]] = 0:
$82:A1A6 D0 0D       BNE $0D    [$A1B5]     ;/
$82:A1A8 A9 00 0C    LDA #$0C00             ;\
$82:A1AB 85 12       STA $12    [$7E:0012]  ;|
$82:A1AD A9 0A 00    LDA #$000A             ;} Set Ah bytes of [$00] to palette 6
$82:A1B0 85 16       STA $16    [$7E:0016]  ;|
$82:A1B2 20 9D A2    JSR $A29D  [$82:A29D]  ;/

$82:A1B5 C8          INY                    ;\
$82:A1B6 C8          INY                    ;} Y += 2
$82:A1B7 B7 03       LDA [$03],y[$82:C06E]  ;\
$82:A1B9 85 00       STA $00    [$7E:0000]  ;} $00 = [$82:C06C + [Y]]
$82:A1BB C0 0C 00    CPY #$000C             ;\
$82:A1BE 30 C0       BMI $C0    [$A180]     ;} If [Y] < Ch: go to LOOP_WEAPONS
$82:A1C0 80 19       BRA $19    [$A1DB]     ; Go to BRANCH_MERGE

; BRANCH_HYPER_BEAM
$82:A1C2 A0 00 00    LDY #$0000             ; >_<;

; LOOP_HYPER_BEAM_WEAPONS
$82:A1C5 BE A8 C0    LDX $C0A8,y            ;\
$82:A1C8 A9 0A 00    LDA #$000A             ;|
$82:A1CB 85 16       STA $16    [$7E:0016]  ;} Copy Ah bytes from [$C0A8 + [Y]] to [$00] (hyper beam weapons tilemap)
$82:A1CD 20 7E A2    JSR $A27E  [$82:A27E]  ;/
$82:A1D0 C8          INY                    ;\
$82:A1D1 C8          INY                    ;} Y += 2
$82:A1D2 B7 03       LDA [$03],y            ;\
$82:A1D4 85 00       STA $00    [$7E:0000]  ;} $00 = [$82:C06C + [Y]]
$82:A1D6 C0 0C 00    CPY #$000C             ;\
$82:A1D9 30 EA       BMI $EA    [$A1C5]     ;} If [Y] < Ch: go to LOOP_HYPER_BEAM_WEAPONS

; BRANCH_MERGE
$82:A1DB A0 00 00    LDY #$0000             ; Y = 0
$82:A1DE A9 76 C0    LDA #$C076             ;\
$82:A1E1 85 03       STA $03    [$7E:0003]  ;|
$82:A1E3 A9 82 00    LDA #$0082             ;} $03 = $82:C076 (RAM tilemap offsets pointer - suit/misc)
$82:A1E6 85 05       STA $05    [$7E:0005]  ;/
$82:A1E8 B7 03       LDA [$03],y[$82:C076]  ;\
$82:A1EA 85 00       STA $00    [$7E:0000]  ;} $00 = [$82:C076] (RAM tilemap offset)

; LOOP_SUIT_MISC
$82:A1EC B9 56 C0    LDA $C056,y[$82:C056]  ;\
$82:A1EF 2C A4 09    BIT $09A4  [$7E:09A4]  ;} If [collected items] & [$C056 + [Y]] = 0:
$82:A1F2 D0 0D       BNE $0D    [$A201]     ;/
$82:A1F4 A2 1A C0    LDX #$C01A             ;\
$82:A1F7 A9 12 00    LDA #$0012             ;|
$82:A1FA 85 16       STA $16    [$7E:0016]  ;} Copy 12h bytes from $C01A to [$00] (blank placeholder)
$82:A1FC 20 7E A2    JSR $A27E  [$82:A27E]  ;/
$82:A1FF 80 20       BRA $20    [$A221]

$82:A201 BE 96 C0    LDX $C096,y[$82:C09A]  ;\ Else ([collected items] & [$C056 + [Y]] != 0):
$82:A204 A9 12 00    LDA #$0012             ;|
$82:A207 85 16       STA $16    [$7E:0016]  ;} Copy 12h bytes from [$C096 + [Y]] to [$00] (weapons tilemap)
$82:A209 20 7E A2    JSR $A27E  [$82:A27E]  ;/
$82:A20C B9 56 C0    LDA $C056,y[$82:C05A]  ;\
$82:A20F 2C A2 09    BIT $09A2  [$7E:09A2]  ;} If [equipped items] & [$C056 + [Y]] = 0:
$82:A212 D0 0D       BNE $0D    [$A221]     ;/
$82:A214 A9 00 0C    LDA #$0C00             ;\
$82:A217 85 12       STA $12    [$7E:0012]  ;|
$82:A219 A9 12 00    LDA #$0012             ;} Set 12h bytes of [$00] to palette 6
$82:A21C 85 16       STA $16    [$7E:0016]  ;|
$82:A21E 20 9D A2    JSR $A29D  [$82:A29D]  ;/

$82:A221 C8          INY                    ;\
$82:A222 C8          INY                    ;} Y += 2
$82:A223 B7 03       LDA [$03],y[$82:C078]  ;\
$82:A225 85 00       STA $00    [$7E:0000]  ;} $00 = [$82:C076 + [Y]]
$82:A227 C0 0C 00    CPY #$000C             ;\
$82:A22A 30 C0       BMI $C0    [$A1EC]     ;} If [Y] < Ch: go to LOOP_SUIT_MISC
$82:A22C A0 00 00    LDY #$0000             ; Y = 0
$82:A22F A9 82 C0    LDA #$C082             ;\
$82:A232 85 03       STA $03    [$7E:0003]  ;|
$82:A234 A9 82 00    LDA #$0082             ;} $03 = $82:C082 (RAM tilemap offsets pointer - boots)
$82:A237 85 05       STA $05    [$7E:0005]  ;/
$82:A239 B7 03       LDA [$03],y[$82:C082]  ;\
$82:A23B 85 00       STA $00    [$7E:0000]  ;} $00 = [$82:C082] (RAM tilemap offset)

; LOOP_BOOTS
$82:A23D B9 62 C0    LDA $C062,y[$82:C062]  ;\
$82:A240 2C A4 09    BIT $09A4  [$7E:09A4]  ;} If [collected items] & [$C062 + [Y]] = 0:
$82:A243 D0 0D       BNE $0D    [$A252]     ;/
$82:A245 A2 1A C0    LDX #$C01A             ;\
$82:A248 A9 12 00    LDA #$0012             ;|
$82:A24B 85 16       STA $16    [$7E:0016]  ;} Copy 12h bytes from $C01A to [$00] (blank placeholder)
$82:A24D 20 7E A2    JSR $A27E  [$82:A27E]  ;/
$82:A250 80 20       BRA $20    [$A272]

$82:A252 A9 12 00    LDA #$0012             ;\ Else ([collected items] & [$C062 + [Y]] != 0):
$82:A255 85 16       STA $16    [$7E:0016]  ;|
$82:A257 BE A2 C0    LDX $C0A2,y[$82:C0A2]  ;} Copy 12h bytes from [$C0A2 + [Y]] to [$00] (weapons tilemap)
$82:A25A 20 7E A2    JSR $A27E  [$82:A27E]  ;/
$82:A25D B9 62 C0    LDA $C062,y[$82:C062]  ;\
$82:A260 2C A2 09    BIT $09A2  [$7E:09A2]  ;} If [equipped items] & [$C062 + [Y]] = 0:
$82:A263 D0 0D       BNE $0D    [$A272]     ;/
$82:A265 A9 00 0C    LDA #$0C00             ;\
$82:A268 85 12       STA $12    [$7E:0012]  ;|
$82:A26A A9 12 00    LDA #$0012             ;} Set 12h bytes of [$00] to palette 6
$82:A26D 85 16       STA $16    [$7E:0016]  ;|
$82:A26F 20 9D A2    JSR $A29D  [$82:A29D]  ;/

$82:A272 C8          INY                    ;\
$82:A273 C8          INY                    ;} Y += 2
$82:A274 B7 03       LDA [$03],y[$82:C084]  ;\
$82:A276 85 00       STA $00    [$7E:0000]  ;} $00 = [$82:C082 + [Y]]
$82:A278 C0 06 00    CPY #$0006             ;\
$82:A27B 30 C0       BMI $C0    [$A23D]     ;} If [Y] < 6: go to LOOP_BOOTS
$82:A27D 60          RTS
}


;;; $A27E: Copy [$16] bytes from [X] to $7E:[$00] ;;;
{
$82:A27E 08          PHP
$82:A27F 5A          PHY
$82:A280 E2 20       SEP #$20
$82:A282 A9 7E       LDA #$7E
$82:A284 85 02       STA $02    [$7E:0002]
$82:A286 C2 30       REP #$30
$82:A288 A0 00 00    LDY #$0000

$82:A28B BD 00 00    LDA $0000,x[$82:C01A]
$82:A28E 97 00       STA [$00],y[$7E:3C08]
$82:A290 E8          INX
$82:A291 E8          INX
$82:A292 C8          INY
$82:A293 C8          INY
$82:A294 C6 16       DEC $16    [$7E:0016]
$82:A296 C6 16       DEC $16    [$7E:0016]
$82:A298 D0 F1       BNE $F1    [$A28B]
$82:A29A 7A          PLY
$82:A29B 28          PLP
$82:A29C 60          RTS
}


;;; $A29D: Set the palette of [$16] bytes of $7E:[$00] to [$12] ;;;
{
$82:A29D 08          PHP
$82:A29E 5A          PHY
$82:A29F E2 20       SEP #$20
$82:A2A1 A9 7E       LDA #$7E
$82:A2A3 85 02       STA $02    [$7E:0002]
$82:A2A5 C2 30       REP #$30
$82:A2A7 A0 00 00    LDY #$0000

$82:A2AA B7 00       LDA [$00],y[$7E:3C48]
$82:A2AC 29 FF E3    AND #$E3FF
$82:A2AF 05 12       ORA $12    [$7E:0012]
$82:A2B1 97 00       STA [$00],y[$7E:3C48]
$82:A2B3 C8          INY
$82:A2B4 C8          INY
$82:A2B5 C6 16       DEC $16    [$7E:0016]
$82:A2B7 C6 16       DEC $16    [$7E:0016]
$82:A2B9 D0 EF       BNE $EF    [$A2AA]
$82:A2BB 7A          PLY
$82:A2BC 28          PLP
$82:A2BD 60          RTS
}


;;; $A2BE: Clear Samus/beam tiles ;;;
{
; Reloads the first quarter of the standard sprite tiles
$82:A2BE 08          PHP
$82:A2BF E2 30       SEP #$30
$82:A2C1 A9 00       LDA #$00
$82:A2C3 8D 16 21    STA $2116  [$7E:2116]
$82:A2C6 A9 60       LDA #$60
$82:A2C8 8D 17 21    STA $2117  [$7E:2117]
$82:A2CB A9 80       LDA #$80
$82:A2CD 8D 15 21    STA $2115  [$7E:2115]
$82:A2D0 22 A9 91 80 JSL $8091A9[$80:91A9]  ; Set up a (H)DMA transfer
$82:A2D4             dx 01,01,18,9AD200,1000
$82:A2DC A9 02       LDA #$02
$82:A2DE 8D 0B 42    STA $420B  [$7E:420B]
$82:A2E1 28          PLP
$82:A2E2 60          RTS
}


;;; $A2E3: Continue initialising gameplay resume ;;;
{
; Like $9009, I don't know why this is a subroutine and not a part of $9367
$82:A2E3 E2 30       SEP #$30
$82:A2E5 08          PHP
$82:A2E6 C2 30       REP #$30
$82:A2E8 A0 00 02    LDY #$0200             ;\
$82:A2EB A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A2EE BF 00 33 7E LDA $7E3300,x[$7E:3300];|
$82:A2F2 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$82:A2F6 E8          INX                    ;} Restore gameplay palettes
$82:A2F7 E8          INX                    ;|
$82:A2F8 88          DEY                    ;|
$82:A2F9 88          DEY                    ;|
$82:A2FA D0 F2       BNE $F2    [$A2EE]     ;/
$82:A2FC 28          PLP
$82:A2FD 20 13 A3    JSR $A313  [$82:A313]  ; Set up PPU for gameplay resume
$82:A300 20 4E A3    JSR $A34E  [$82:A34E]  ; Calculate BG scrolls
$82:A303 20 77 A3    JSR $A377  [$82:A377]  ; Update beam tiles and palette
$82:A306 20 80 A3    JSR $A380  [$82:A380]  ; Clear pause menu data
$82:A309 C2 30       REP #$30
$82:A30B A9 0C 00    LDA #$000C             ;\
$82:A30E 22 84 F0 90 JSL $90F084[$90:F084]  ;} Unlock Samus from map station
$82:A312 60          RTS
}


;;; $A313: Set up PPU for gameplay resume ;;;
{
$82:A313 08          PHP
$82:A314 E2 30       SEP #$30
$82:A316 A9 03       LDA #$03               ;\
$82:A318 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$82:A31B 85 52       STA $52    [$7E:0052]  ;/
$82:A31D A9 09       LDA #$09               ;\
$82:A31F 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 1 with BG3 priority, BG tile sizes = 8x8
$82:A322 85 55       STA $55    [$7E:0055]  ;/
$82:A324 64 5D       STZ $5D    [$7E:005D]  ;\
$82:A326 9C 0B 21    STZ $210B  [$7E:210B]  ;|
$82:A329 A9 04       LDA #$04               ;} BG1/2/4 tiles base address = $0000
$82:A32B 85 5E       STA $5E    [$7E:005E]  ;} BG3 tiles base address = $4000
$82:A32D 8D 0C 21    STA $210C  [$7E:210C]  ;/
$82:A330 A9 51       LDA #$51               ;\
$82:A332 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $5000, size = 64x32
$82:A334 8D 07 21    STA $2107  [$7E:2107]  ;/
$82:A337 A9 49       LDA #$49               ;\
$82:A339 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4800, size = 64x32
$82:A33B 8D 08 21    STA $2108  [$7E:2108]  ;/
$82:A33E A9 5A       LDA #$5A               ;\
$82:A340 85 5A       STA $5A    [$7E:005A]  ;} BG3 tilemap base address = $5800, size = 32x64
$82:A342 8D 09 21    STA $2109  [$7E:2109]  ;/
$82:A345 A9 00       LDA #$00               ;\
$82:A347 85 5C       STA $5C    [$7E:005C]  ;} BG3 tilemap base address = $0000, size = 32x32
$82:A349 8D 0A 21    STA $210A  [$7E:210A]  ;/
$82:A34C 28          PLP
$82:A34D 60          RTS
}


;;; $A34E: Calculate BG scrolls ;;;
{
; Called during unpausing
$82:A34E 08          PHP
$82:A34F C2 30       REP #$30
$82:A351 AD 11 09    LDA $0911  [$7E:0911]  ;\
$82:A354 18          CLC                    ;|
$82:A355 6D 1D 09    ADC $091D  [$7E:091D]  ;} BG1 X scroll = [layer 1 X position] + [BG1 X offset]
$82:A358 85 B1       STA $B1    [$7E:00B1]  ;/
$82:A35A AD 15 09    LDA $0915  [$7E:0915]  ;\
$82:A35D 18          CLC                    ;|
$82:A35E 6D 1F 09    ADC $091F  [$7E:091F]  ;} BG1 Y scroll = [layer 1 Y position] + [BG1 Y offset]
$82:A361 85 B3       STA $B3    [$7E:00B3]  ;/
$82:A363 AD 17 09    LDA $0917  [$7E:0917]  ;\
$82:A366 18          CLC                    ;|
$82:A367 6D 21 09    ADC $0921  [$7E:0921]  ;} BG2 X scroll = [layer 2 X position] + [BG2 X offset]
$82:A36A 85 B5       STA $B5    [$7E:00B5]  ;/
$82:A36C AD 19 09    LDA $0919  [$7E:0919]  ;\
$82:A36F 18          CLC                    ;|
$82:A370 6D 23 09    ADC $0923  [$7E:0923]  ;} BG2 Y scroll = [layer 2 Y position] + [BG2 Y offset]
$82:A373 85 B7       STA $B7    [$7E:00B7]  ;/
$82:A375 28          PLP
$82:A376 60          RTS
}


;;; $A377: Update beam tiles and palette ;;;
{
$82:A377 08          PHP
$82:A378 C2 30       REP #$30
$82:A37A 22 8D AC 90 JSL $90AC8D[$90:AC8D]  ; Update beam tiles and palette
$82:A37E 28          PLP
$82:A37F 60          RTS
}


;;; $A380: Clear pause menu data ;;;
{
$82:A380 08          PHP
$82:A381 C2 30       REP #$30
$82:A383 9C 27 07    STZ $0727  [$7E:0727]
$82:A386 9C 29 07    STZ $0729  [$7E:0729]
$82:A389 9C 2B 07    STZ $072B  [$7E:072B]
$82:A38C 9C 2D 07    STZ $072D  [$7E:072D]
$82:A38F 9C 2F 07    STZ $072F  [$7E:072F]
$82:A392 9C 31 07    STZ $0731  [$7E:0731]
$82:A395 9C 33 07    STZ $0733  [$7E:0733]
$82:A398 9C 35 07    STZ $0735  [$7E:0735]
$82:A39B 9C 37 07    STZ $0737  [$7E:0737]
$82:A39E 9C 39 07    STZ $0739  [$7E:0739]
$82:A3A1 9C 3D 07    STZ $073D  [$7E:073D]
$82:A3A4 9C 3F 07    STZ $073F  [$7E:073F]
$82:A3A7 9C 41 07    STZ $0741  [$7E:0741]
$82:A3AA 9C 43 07    STZ $0743  [$7E:0743]
$82:A3AD 9C 45 07    STZ $0745  [$7E:0745]
$82:A3B0 9C 47 07    STZ $0747  [$7E:0747]
$82:A3B3 9C 49 07    STZ $0749  [$7E:0749]
$82:A3B6 9C 4B 07    STZ $074B  [$7E:074B]
$82:A3B9 9C 4D 07    STZ $074D  [$7E:074D]
$82:A3BC 9C 51 07    STZ $0751  [$7E:0751]
$82:A3BF 9C 53 07    STZ $0753  [$7E:0753]
$82:A3C2 9C 55 07    STZ $0755  [$7E:0755]
$82:A3C5 9C 57 07    STZ $0757  [$7E:0757]
$82:A3C8 9C 59 07    STZ $0759  [$7E:0759]
$82:A3CB 9C 5B 07    STZ $075B  [$7E:075B]
$82:A3CE 9C 5D 07    STZ $075D  [$7E:075D]
$82:A3D1 9C 5F 07    STZ $075F  [$7E:075F]
$82:A3D4 9C 61 07    STZ $0761  [$7E:0761]
$82:A3D7 28          PLP
$82:A3D8 60          RTS
}


;;; $A3D9: Unused. Change pose due to equipment change ;;;
{
; Looks like maybe it was a hook on leaving the equipment screen if liquid physics apply
$82:A3D9 08          PHP
$82:A3DA C2 30       REP #$30
$82:A3DC AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$82:A3DF 29 FF 00    AND #$00FF             ;|
$82:A3E2 0A          ASL A                  ;} Execute [$A3ED + [Samus movement type] * 2]
$82:A3E3 AA          TAX                    ;|
$82:A3E4 FC ED A3    JSR ($A3ED,x)          ;/
$82:A3E7 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$82:A3EB 28          PLP
$82:A3EC 60          RTS

$82:A3ED             dw A425,  ; 0: Standing
                        A425,  ; 1: Running
                        A425,  ; 2: Normal jumping
                        A42A, ; 3: Spin jumping
                        A4A9, ; 4: Morph ball - on ground
                        A425,  ; 5: Crouching
                        A425,  ; 6: Falling
                        A47B, ; 7: Unused
                        A4A9, ; 8: Morph ball - falling
                        A47B, ; 9: Unused
                        A425,  ; Ah: Knockback / crystal flash ending
                        A425,  ; Bh: Unused
                        A425,  ; Ch: Unused
                        A425,  ; Dh: Unused
                        A425,  ; Eh: Turning around - on ground
                        A425,  ; Fh: Crouching/standing/morphing/unmorphing transition
                        A425,  ; 10h: Moonwalking
                        A4D7, ; 11h: Spring ball - on ground
                        A4D7, ; 12h: Spring ball - in air
                        A4D7, ; 13h: Spring ball - falling
                        A425,  ; 14h: Wall jumping
                        A425,  ; 15h: Ran into a wall
                        A425,  ; 16h: Grappling
                        A425,  ; 17h: Turning around - jumping
                        A425,  ; 18h: Turning around - falling
                        A425,  ; 19h: Damage boost
                        A425,  ; 1Ah: Grabbed by Draygon
                        A425   ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $A425: RTS ;;;
{
$82:A425 08          PHP
$82:A426 C2 30       REP #$30
$82:A428 28          PLP
$82:A429 60          RTS
}


;;; $A42A: Change pose due to equipment change - spin jumping ;;;
{
$82:A42A 08          PHP
$82:A42B C2 30       REP #$30
$82:A42D AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$82:A430 C9 81 00    CMP #$0081             ;|
$82:A433 F0 1B       BEQ $1B    [$A450]     ;} If [Samus pose] = screw attack: go to BRANCH_SCREW_ATTACK
$82:A435 C9 82 00    CMP #$0082             ;|
$82:A438 F0 16       BEQ $16    [$A450]     ;/
$82:A43A C9 1B 00    CMP #$001B             ;\
$82:A43D F0 07       BEQ $07    [$A446]     ;|
$82:A43F C9 1C 00    CMP #$001C             ;} If [Samus pose] = space jump: go to BRANCH_SPACE_JUMP
$82:A442 F0 02       BEQ $02    [$A446]     ;/
$82:A444 80 33       BRA $33    [$A479]     ; Return

; BRANCH_SPACE_JUMP
$82:A446 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$82:A449 89 20 00    BIT #$0020             ;} If gravity suit equipped: return
$82:A44C D0 2B       BNE $2B    [$A479]     ;/
$82:A44E 80 08       BRA $08    [$A458]     ; Go to BRANCH_MERGE

; BRANCH_SCREW_ATTACK
$82:A450 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$82:A453 89 08 00    BIT #$0008             ;} If screw attack equipped: return
$82:A456 D0 21       BNE $21    [$A479]     ;/

; BRANCH_MERGE
$82:A458 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$82:A45B 29 FF 00    AND #$00FF             ;|
$82:A45E C9 04 00    CMP #$0004             ;} If facing right:
$82:A461 F0 08       BEQ $08    [$A46B]     ;/
$82:A463 A9 19 00    LDA #$0019             ;\
$82:A466 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - spin jump
$82:A469 80 06       BRA $06    [$A471]

$82:A46B A9 1A 00    LDA #$001A             ;\ Else (facing left):
$82:A46E 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - spin jump

$82:A471 22 33 F4 91 JSL $91F433[$91:F433]  ; Execute $91:F433
$82:A475 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed

$82:A479 28          PLP
$82:A47A 60          RTS
}


;;; $A47B: Change pose due to equipment change - movement types 7/9 ;;;
{
; Unused movement types
$82:A47B 08          PHP
$82:A47C C2 30       REP #$30
$82:A47E AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$82:A481 89 04 00    BIT #$0004             ;} If morph ball equipped: return
$82:A484 D0 21       BNE $21    [$A4A7]     ;/
$82:A486 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$82:A489 29 FF 00    AND #$00FF             ;|
$82:A48C C9 04 00    CMP #$0004             ;} If facing right:
$82:A48F F0 08       BEQ $08    [$A499]     ;/
$82:A491 A9 1D 00    LDA #$001D             ;\
$82:A494 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - morph ball - no springball - on ground
$82:A497 80 06       BRA $06    [$A49F]

$82:A499 A9 41 00    LDA #$0041             ;\ Else (facing left):
$82:A49C 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - morph ball - no springball - on ground

$82:A49F 22 33 F4 91 JSL $91F433[$91:F433]  ; Execute $91:F433
$82:A4A3 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed

$82:A4A7 28          PLP
$82:A4A8 60          RTS
}


;;; $A4A9: Change pose due to equipment change - morph ball ;;;
{
$82:A4A9 08          PHP
$82:A4AA C2 30       REP #$30
$82:A4AC AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$82:A4AF 89 02 00    BIT #$0002             ;} If spring ball not equipped: return
$82:A4B2 F0 21       BEQ $21    [$A4D5]     ;/
$82:A4B4 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$82:A4B7 29 FF 00    AND #$00FF             ;|
$82:A4BA C9 04 00    CMP #$0004             ;} If facing right:
$82:A4BD F0 08       BEQ $08    [$A4C7]     ;/
$82:A4BF A9 79 00    LDA #$0079             ;\
$82:A4C2 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - morph ball - spring ball - on ground
$82:A4C5 80 06       BRA $06    [$A4CD]

$82:A4C7 A9 7A 00    LDA #$007A             ;\ Else (facing left):
$82:A4CA 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - morph ball - spring ball - on ground

$82:A4CD 22 33 F4 91 JSL $91F433[$91:F433]  ; Execute $91:F433
$82:A4D1 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed

$82:A4D5 28          PLP
$82:A4D6 60          RTS
}


;;; $A4D7: Change pose due to equipment change - spring ball ;;;
{
$82:A4D7 08          PHP
$82:A4D8 C2 30       REP #$30
$82:A4DA AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$82:A4DD 89 02 00    BIT #$0002             ;} If spring ball equipped: return
$82:A4E0 D0 21       BNE $21    [$A503]     ;/
$82:A4E2 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$82:A4E5 29 FF 00    AND #$00FF             ;|
$82:A4E8 C9 04 00    CMP #$0004             ;} If facing right:
$82:A4EB F0 08       BEQ $08    [$A4F5]     ;/
$82:A4ED A9 1D 00    LDA #$001D             ;\
$82:A4F0 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - morph ball - no springball - on ground
$82:A4F3 80 06       BRA $06    [$A4FB]

$82:A4F5 A9 41 00    LDA #$0041             ;\ Else (facing left):
$82:A4F8 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - morph ball - no springball - on ground

$82:A4FB 22 33 F4 91 JSL $91F433[$91:F433]  ; Execute $91:F433
$82:A4FF 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed

$82:A503 28          PLP
$82:A504 60          RTS
}


;;; $A505..AB46: Pause screen ;;;
{
;;; $A505: Handle pause screen L/R ;;;
{
$82:A505 20 0C A5    JSR $A50C  [$82:A50C]  ; Handle pause screen L/R input
$82:A508 20 9A A5    JSR $A59A  [$82:A59A]  ; Draw L/R highlight
$82:A50B 60          RTS
}


;;; $A50C: Handle pause screen L/R input ;;;
{
$82:A50C 08          PHP
$82:A50D C2 30       REP #$30
$82:A50F AD E1 05    LDA $05E1  [$7E:05E1]  ;\
$82:A512 89 20 00    BIT #$0020             ;} If newly holding down L: go to BRANCH_L
$82:A515 D0 30       BNE $30    [$A547]     ;/
$82:A517 89 10 00    BIT #$0010             ;\
$82:A51A D0 09       BNE $09    [$A525]     ;} If newly holding down R: go to BRANCH_R
$82:A51C 80 4D       BRA $4D    [$A56B]     ; Return
$82:A51E AD 53 07    LDA $0753  [$7E:0753]  ;\
$82:A521 D0 35       BNE $35    [$A558]     ;} Dead code
$82:A523 80 14       BRA $14    [$A539]     ;/

; BRANCH_R
$82:A525 AD 53 07    LDA $0753  [$7E:0753]  ;\
$82:A528 C9 02 00    CMP #$0002             ;} If [pause screen button label mode] = equipment screen: return
$82:A52B F0 3E       BEQ $3E    [$A56B]     ;/
$82:A52D AD 0A C1    LDA $C10A  [$82:C10A]  ;\
$82:A530 8D 29 07    STA $0729  [$7E:0729]  ;} L/R button pressed highlight timer = 5
$82:A533 A9 02 00    LDA #$0002             ;\
$82:A536 8D 27 07    STA $0727  [$7E:0727]  ;} Menu index = 2 (map screen to equipment screen - fading out)
$82:A539 A9 02 00    LDA #$0002             ;\
$82:A53C 8D 51 07    STA $0751  [$7E:0751]  ;} Shoulder button pressed highlight = R
$82:A53F 8D 53 07    STA $0753  [$7E:0753]  ; Pause screen button label mode = equipment screen
$82:A542 20 15 A6    JSR $A615  [$82:A615]  ; Set pause screen button label palettes
$82:A545 80 1D       BRA $1D    [$A564]     ; Go to BRANCH_MERGE

; BRANCH_L
$82:A547 AD 53 07    LDA $0753  [$7E:0753]  ;\
$82:A54A F0 1F       BEQ $1F    [$A56B]     ;} If [pause screen button label mode] = map screen: return
$82:A54C AD 0A C1    LDA $C10A  [$82:C10A]  ;\
$82:A54F 8D 29 07    STA $0729  [$7E:0729]  ;} L/R button pressed highlight timer = 5
$82:A552 A9 05 00    LDA #$0005             ;\
$82:A555 8D 27 07    STA $0727  [$7E:0727]  ;} Menu index = 5 (equipment screen to map screen - fading out)
$82:A558 A9 01 00    LDA #$0001             ;\
$82:A55B 8D 51 07    STA $0751  [$7E:0751]  ;} Shoulder button pressed highlight = L
$82:A55E 9C 53 07    STZ $0753  [$7E:0753]  ; Pause screen button label mode = map screen
$82:A561 20 15 A6    JSR $A615  [$82:A615]  ; Set pause screen button label palettes

; BRANCH_MERGE
$82:A564 A9 38 00    LDA #$0038             ;\
$82:A567 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)

$82:A56B 28          PLP
$82:A56C 60          RTS
}


;;; $A56D: Handle pause menu L/R pressed highlight ;;;
{
$82:A56D 08          PHP
$82:A56E C2 30       REP #$30
$82:A570 AD 29 07    LDA $0729  [$7E:0729]  ;\
$82:A573 F0 23       BEQ $23    [$A598]     ;} If [L/R button pressed highlight timer] = 0: return
$82:A575 3A          DEC A                  ;\
$82:A576 8D 29 07    STA $0729  [$7E:0729]  ;} Decrement L/R button pressed highlight timer
$82:A579 AD 51 07    LDA $0751  [$7E:0751]  ;\
$82:A57C F0 1A       BEQ $1A    [$A598]     ;} If [shoulder button pressed highlight] = none: return
$82:A57E 3A          DEC A                  ;\
$82:A57F 0A          ASL A                  ;} X = ([shoulder button pressed highlight] - 1) * 2
$82:A580 AA          TAX                    ;/
$82:A581 A9 00 00    LDA #$0000             ;\
$82:A584 85 03       STA $03    [$7E:0003]  ;} $03 = 0 (palette 0)
$82:A586 BD 82 C1    LDA $C182,x[$82:C184]  ; A = [$C182 + [X]]
$82:A589 48          PHA
$82:A58A BD 8A C1    LDA $C18A,x[$82:C18C]  ;\
$82:A58D A8          TAY                    ;} Y = [$C18A + [X]] - 1
$82:A58E 88          DEY                    ;/
$82:A58F BD 86 C1    LDA $C186,x[$82:C188]  ;\
$82:A592 AA          TAX                    ;} X = [$C186 + [X]]
$82:A593 68          PLA
$82:A594 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM

$82:A598 28          PLP
$82:A599 60          RTS
}


;;; $A59A: Equipment screen - draw L/R highlight ;;;
{
$82:A59A 08          PHP
$82:A59B C2 30       REP #$30
$82:A59D A0 D0 00    LDY #$00D0             ;\
$82:A5A0 A2 18 00    LDX #$0018             ;|
$82:A5A3 A9 02 00    LDA #$0002             ;} Draw pause screen spritemap 2 to (18h, CFh)
$82:A5A6 20 81 A8    JSR $A881  [$82:A881]  ;/
$82:A5A9 A0 D0 00    LDY #$00D0             ;\
$82:A5AC A2 E8 00    LDX #$00E8             ;|
$82:A5AF A9 02 00    LDA #$0002             ;} Draw pause screen spritemap 2 to (E8h, CFh)
$82:A5B2 20 81 A8    JSR $A881  [$82:A881]  ;/
$82:A5B5 28          PLP
$82:A5B6 60          RTS
}


;;; $A5B7: Handle pause screen start button ;;;
{
$82:A5B7 08          PHP
$82:A5B8 C2 30       REP #$30
$82:A5BA AD E1 05    LDA $05E1  [$7E:05E1]  ;\
$82:A5BD 89 00 10    BIT #$1000             ;} If newly holding down start:
$82:A5C0 F0 2A       BEQ $2A    [$A5EC]     ;/
$82:A5C2 A9 38 00    LDA #$0038             ;\
$82:A5C5 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$82:A5C9 A9 01 00    LDA #$0001             ;\
$82:A5CC 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$82:A5CF 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$82:A5D2 AD 53 07    LDA $0753  [$7E:0753]  ;\
$82:A5D5 48          PHA                    ;|
$82:A5D6 A9 01 00    LDA #$0001             ;|
$82:A5D9 8D 53 07    STA $0753  [$7E:0753]  ;} Set pause screen button label palettes - unpausing
$82:A5DC 20 15 A6    JSR $A615  [$82:A615]  ;|
$82:A5DF 68          PLA                    ;|
$82:A5E0 8D 53 07    STA $0753  [$7E:0753]  ;/
$82:A5E3 A9 0B 00    LDA #$000B             ;\
$82:A5E6 8D 29 07    STA $0729  [$7E:0729]  ;} Start button pressed highlight timer = Bh
$82:A5E9 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 10h (unpausing, loading normal gameplay)

$82:A5EC 20 4D A8    JSR $A84D  [$82:A84D]  ; Update pause menu L/R/start VRAM tilemap
$82:A5EF 28          PLP
$82:A5F0 60          RTS
}


;;; $A5F1: Handle pause menu start pressed highlight ;;;
{
$82:A5F1 08          PHP
$82:A5F2 8B          PHB
$82:A5F3 4B          PHK                    ;\
$82:A5F4 AB          PLB                    ;} DB = $82
$82:A5F5 C2 30       REP #$30
$82:A5F7 AD 29 07    LDA $0729  [$7E:0729]  ;\
$82:A5FA F0 16       BEQ $16    [$A612]     ;} If [start button pressed highlight timer] = 0: return
$82:A5FC 3A          DEC A                  ;\
$82:A5FD 8D 29 07    STA $0729  [$7E:0729]  ;} Decrement start button pressed highlight timer
$82:A600 A9 00 00    LDA #$0000             ;\
$82:A603 85 03       STA $03    [$7E:0003]  ;} $03 = 0 (palette 0)
$82:A605 A2 90 00    LDX #$0090             ; X = 90h
$82:A608 A0 D0 00    LDY #$00D0             ; Y = D0h
$82:A60B A9 2B 00    LDA #$002B             ; A = 2Bh
$82:A60E 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM

$82:A612 AB          PLB
$82:A613 28          PLP
$82:A614 6B          RTL
}


;;; $A615: Set pause screen button label palettes ;;;
{
$82:A615 08          PHP
$82:A616 C2 30       REP #$30
$82:A618 AD 53 07    LDA $0753  [$7E:0753]  ;\
$82:A61B 0A          ASL A                  ;|
$82:A61C AA          TAX                    ;} Execute [$A622 + [pause screen button label mode] * 2]
$82:A61D FC 22 A6    JSR ($A622,x)[$82:A6DF];/
$82:A620 28          PLP
$82:A621 60          RTS

$82:A622             dw A796, A6DF, A628
}


;;; $A628: Set pause screen button label palettes - equipment screen ;;;
{
; Someone liked pushing and pulling operations >_>
$82:A628 C2 30       REP #$30
$82:A62A 08          PHP
$82:A62B C2 30       REP #$30
$82:A62D A0 0A 00    LDY #$000A             ;\
$82:A630 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A633 BF 4A 36 7E LDA $7E364A,x[$7E:364A];|
$82:A637 29 FF E3    AND #$E3FF             ;|
$82:A63A 09 00 08    ORA #$0800             ;|
$82:A63D 9F 4A 36 7E STA $7E364A,x[$7E:364A];} Set tilemap palette indices at pause menu map tilemap tile (5..9, 19h) to 2 (top of MAP)
$82:A641 E8          INX                    ;|
$82:A642 E8          INX                    ;|
$82:A643 88          DEY                    ;|
$82:A644 88          DEY                    ;|
$82:A645 D0 EC       BNE $EC    [$A633]     ;/
$82:A647 28          PLP
$82:A648 08          PHP
$82:A649 C2 30       REP #$30
$82:A64B A0 0A 00    LDY #$000A             ;\
$82:A64E A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A651 BF 8A 36 7E LDA $7E368A,x[$7E:368A];|
$82:A655 29 FF E3    AND #$E3FF             ;|
$82:A658 09 00 08    ORA #$0800             ;|
$82:A65B 9F 8A 36 7E STA $7E368A,x[$7E:368A];} Set tilemap palette indices at pause menu map tilemap tile (5..9, 1Ah) to 2 (bottom of MAP)
$82:A65F E8          INX                    ;|
$82:A660 E8          INX                    ;|
$82:A661 88          DEY                    ;|
$82:A662 88          DEY                    ;|
$82:A663 D0 EC       BNE $EC    [$A651]     ;/
$82:A665 28          PLP
$82:A666 08          PHP
$82:A667 C2 30       REP #$30
$82:A669 A0 08 00    LDY #$0008             ;\
$82:A66C A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A66F BF 58 36 7E LDA $7E3658,x[$7E:3658];|
$82:A673 29 FF E3    AND #$E3FF             ;|
$82:A676 09 00 08    ORA #$0800             ;|
$82:A679 9F 58 36 7E STA $7E3658,x[$7E:3658];} Set tilemap palette indices at pause menu map tilemap tile (Ch..Fh, 19h) to 2 (top of EXIT)
$82:A67D E8          INX                    ;|
$82:A67E E8          INX                    ;|
$82:A67F 88          DEY                    ;|
$82:A680 88          DEY                    ;|
$82:A681 D0 EC       BNE $EC    [$A66F]     ;/
$82:A683 28          PLP
$82:A684 08          PHP
$82:A685 C2 30       REP #$30
$82:A687 A0 08 00    LDY #$0008             ;\
$82:A68A A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A68D BF 98 36 7E LDA $7E3698,x[$7E:3698];|
$82:A691 29 FF E3    AND #$E3FF             ;|
$82:A694 09 00 08    ORA #$0800             ;|
$82:A697 9F 98 36 7E STA $7E3698,x[$7E:3698];} Set tilemap palette indices at pause menu map tilemap tile (Ch..Fh, 1Ah) to 2 (bottom of EXIT)
$82:A69B E8          INX                    ;|
$82:A69C E8          INX                    ;|
$82:A69D 88          DEY                    ;|
$82:A69E 88          DEY                    ;|
$82:A69F D0 EC       BNE $EC    [$A68D]     ;/
$82:A6A1 28          PLP
$82:A6A2 08          PHP
$82:A6A3 C2 30       REP #$30
$82:A6A5 A0 0A 00    LDY #$000A             ;\
$82:A6A8 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A6AB BF 6C 36 7E LDA $7E366C,x[$7E:366C];|
$82:A6AF 29 FF E3    AND #$E3FF             ;|
$82:A6B2 09 00 14    ORA #$1400             ;|
$82:A6B5 9F 6C 36 7E STA $7E366C,x[$7E:366C];} Set tilemap palette indices at pause menu map tilemap tile (16h..1Ah, 19h) to 5 (top of SAMUS)
$82:A6B9 E8          INX                    ;|
$82:A6BA E8          INX                    ;|
$82:A6BB 88          DEY                    ;|
$82:A6BC 88          DEY                    ;|
$82:A6BD D0 EC       BNE $EC    [$A6AB]     ;/
$82:A6BF 28          PLP
$82:A6C0 08          PHP
$82:A6C1 C2 30       REP #$30
$82:A6C3 A0 0A 00    LDY #$000A             ;\
$82:A6C6 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A6C9 BF AC 36 7E LDA $7E36AC,x[$7E:36AC];|
$82:A6CD 29 FF E3    AND #$E3FF             ;|
$82:A6D0 09 00 14    ORA #$1400             ;|
$82:A6D3 9F AC 36 7E STA $7E36AC,x[$7E:36AC];} Set tilemap palette indices at pause menu map tilemap tile (16h..1Ah, 1Ah) to 5 (bottom of SAMUS)
$82:A6D7 E8          INX                    ;|
$82:A6D8 E8          INX                    ;|
$82:A6D9 88          DEY                    ;|
$82:A6DA 88          DEY                    ;|
$82:A6DB D0 EC       BNE $EC    [$A6C9]     ;/
$82:A6DD 28          PLP
$82:A6DE 60          RTS
}


;;; $A6DF: Set pause screen button label palettes - unpausing ;;;
{
$82:A6DF C2 30       REP #$30
$82:A6E1 08          PHP
$82:A6E2 C2 30       REP #$30
$82:A6E4 A0 08 00    LDY #$0008             ;\
$82:A6E7 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A6EA BF 58 36 7E LDA $7E3658,x[$7E:3658];|
$82:A6EE 29 FF E3    AND #$E3FF             ;|
$82:A6F1 09 00 08    ORA #$0800             ;|
$82:A6F4 9F 58 36 7E STA $7E3658,x[$7E:3658];} Set tilemap palette indices at pause menu map tilemap tile (Ch..Fh, 19h) to 2 (top of EXIT)
$82:A6F8 E8          INX                    ;|
$82:A6F9 E8          INX                    ;|
$82:A6FA 88          DEY                    ;|
$82:A6FB 88          DEY                    ;|
$82:A6FC D0 EC       BNE $EC    [$A6EA]     ;/
$82:A6FE 28          PLP
$82:A6FF 08          PHP
$82:A700 C2 30       REP #$30
$82:A702 A0 08 00    LDY #$0008             ;\
$82:A705 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A708 BF 98 36 7E LDA $7E3698,x[$7E:3698];|
$82:A70C 29 FF E3    AND #$E3FF             ;|
$82:A70F 09 00 08    ORA #$0800             ;|
$82:A712 9F 98 36 7E STA $7E3698,x[$7E:3698];} Set tilemap palette indices at pause menu map tilemap tile (Ch..Fh, 1Ah) to 2 (bottom of EXIT)
$82:A716 E8          INX                    ;|
$82:A717 E8          INX                    ;|
$82:A718 88          DEY                    ;|
$82:A719 88          DEY                    ;|
$82:A71A D0 EC       BNE $EC    [$A708]     ;/
$82:A71C 28          PLP
$82:A71D 08          PHP
$82:A71E C2 30       REP #$30
$82:A720 A0 0A 00    LDY #$000A             ;\
$82:A723 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A726 BF 4A 36 7E LDA $7E364A,x[$7E:364A];|
$82:A72A 29 FF E3    AND #$E3FF             ;|
$82:A72D 09 00 14    ORA #$1400             ;|
$82:A730 9F 4A 36 7E STA $7E364A,x[$7E:364A];} Set tilemap palette indices at pause menu map tilemap tile (5..9, 19h) to 5 (top of MAP)
$82:A734 E8          INX                    ;|
$82:A735 E8          INX                    ;|
$82:A736 88          DEY                    ;|
$82:A737 88          DEY                    ;|
$82:A738 D0 EC       BNE $EC    [$A726]     ;/
$82:A73A 28          PLP
$82:A73B 08          PHP
$82:A73C C2 30       REP #$30
$82:A73E A0 0A 00    LDY #$000A             ;\
$82:A741 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A744 BF 8A 36 7E LDA $7E368A,x[$7E:368A];|
$82:A748 29 FF E3    AND #$E3FF             ;|
$82:A74B 09 00 14    ORA #$1400             ;|
$82:A74E 9F 8A 36 7E STA $7E368A,x[$7E:368A];} Set tilemap palette indices at pause menu map tilemap tile (5..9, 1Ah) to 5 (bottom of MAP)
$82:A752 E8          INX                    ;|
$82:A753 E8          INX                    ;|
$82:A754 88          DEY                    ;|
$82:A755 88          DEY                    ;|
$82:A756 D0 EC       BNE $EC    [$A744]     ;/
$82:A758 28          PLP
$82:A759 08          PHP
$82:A75A C2 30       REP #$30
$82:A75C A0 0A 00    LDY #$000A             ;\
$82:A75F A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A762 BF 6C 36 7E LDA $7E366C,x[$7E:366C];|
$82:A766 29 FF E3    AND #$E3FF             ;|
$82:A769 09 00 14    ORA #$1400             ;|
$82:A76C 9F 6C 36 7E STA $7E366C,x[$7E:366C];} Set tilemap palette indices at pause menu map tilemap tile (16h..1Ah, 19h) to 5 (top of SAMUS)
$82:A770 E8          INX                    ;|
$82:A771 E8          INX                    ;|
$82:A772 88          DEY                    ;|
$82:A773 88          DEY                    ;|
$82:A774 D0 EC       BNE $EC    [$A762]     ;/
$82:A776 28          PLP
$82:A777 08          PHP
$82:A778 C2 30       REP #$30
$82:A77A A0 0A 00    LDY #$000A             ;\
$82:A77D A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A780 BF AC 36 7E LDA $7E36AC,x[$7E:36AC];|
$82:A784 29 FF E3    AND #$E3FF             ;|
$82:A787 09 00 14    ORA #$1400             ;|
$82:A78A 9F AC 36 7E STA $7E36AC,x[$7E:36AC];} Set tilemap palette indices at pause menu map tilemap tile (16h..1Ah, 1Ah) to 5 (bottom of SAMUS)
$82:A78E E8          INX                    ;|
$82:A78F E8          INX                    ;|
$82:A790 88          DEY                    ;|
$82:A791 88          DEY                    ;|
$82:A792 D0 EC       BNE $EC    [$A780]     ;/
$82:A794 28          PLP
$82:A795 60          RTS
}


;;; $A796: Set pause screen button label palettes - map screen ;;;
{
$82:A796 C2 30       REP #$30
$82:A798 08          PHP
$82:A799 C2 30       REP #$30
$82:A79B A0 0A 00    LDY #$000A             ;\
$82:A79E A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A7A1 BF 6C 36 7E LDA $7E366C,x[$7E:366C];|
$82:A7A5 29 FF E3    AND #$E3FF             ;|
$82:A7A8 09 00 08    ORA #$0800             ;|
$82:A7AB 9F 6C 36 7E STA $7E366C,x[$7E:366C];} Set tilemap palette indices at pause menu map tilemap tile (16h..1Ah, 19h) to 2 (top of SAMUS)
$82:A7AF E8          INX                    ;|
$82:A7B0 E8          INX                    ;|
$82:A7B1 88          DEY                    ;|
$82:A7B2 88          DEY                    ;|
$82:A7B3 D0 EC       BNE $EC    [$A7A1]     ;/
$82:A7B5 28          PLP
$82:A7B6 08          PHP
$82:A7B7 C2 30       REP #$30
$82:A7B9 A0 0A 00    LDY #$000A             ;\
$82:A7BC A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A7BF BF AC 36 7E LDA $7E36AC,x[$7E:36AC];|
$82:A7C3 29 FF E3    AND #$E3FF             ;|
$82:A7C6 09 00 08    ORA #$0800             ;|
$82:A7C9 9F AC 36 7E STA $7E36AC,x[$7E:36AC];} Set tilemap palette indices at pause menu map tilemap tile (16h..1Ah, 1Ah) to 2 (bottom of SAMUS)
$82:A7CD E8          INX                    ;|
$82:A7CE E8          INX                    ;|
$82:A7CF 88          DEY                    ;|
$82:A7D0 88          DEY                    ;|
$82:A7D1 D0 EC       BNE $EC    [$A7BF]     ;/
$82:A7D3 28          PLP
$82:A7D4 08          PHP
$82:A7D5 C2 30       REP #$30
$82:A7D7 A0 08 00    LDY #$0008             ;\
$82:A7DA A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A7DD BF 58 36 7E LDA $7E3658,x[$7E:3658];|
$82:A7E1 29 FF E3    AND #$E3FF             ;|
$82:A7E4 09 00 08    ORA #$0800             ;|
$82:A7E7 9F 58 36 7E STA $7E3658,x[$7E:3658];} Set tilemap palette indices at pause menu map tilemap tile (Ch..Fh, 19h) to 2 (top of EXIT)
$82:A7EB E8          INX                    ;|
$82:A7EC E8          INX                    ;|
$82:A7ED 88          DEY                    ;|
$82:A7EE 88          DEY                    ;|
$82:A7EF D0 EC       BNE $EC    [$A7DD]     ;/
$82:A7F1 28          PLP
$82:A7F2 08          PHP
$82:A7F3 C2 30       REP #$30
$82:A7F5 A0 08 00    LDY #$0008             ;\
$82:A7F8 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A7FB BF 98 36 7E LDA $7E3698,x[$7E:3698];|
$82:A7FF 29 FF E3    AND #$E3FF             ;|
$82:A802 09 00 08    ORA #$0800             ;|
$82:A805 9F 98 36 7E STA $7E3698,x[$7E:3698];} Set tilemap palette indices at pause menu map tilemap tile (Ch..Fh, 1Ah) to 2 (bottom of EXIT)
$82:A809 E8          INX                    ;|
$82:A80A E8          INX                    ;|
$82:A80B 88          DEY                    ;|
$82:A80C 88          DEY                    ;|
$82:A80D D0 EC       BNE $EC    [$A7FB]     ;/
$82:A80F 28          PLP
$82:A810 08          PHP
$82:A811 C2 30       REP #$30
$82:A813 A0 0A 00    LDY #$000A             ;\
$82:A816 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A819 BF 4A 36 7E LDA $7E364A,x[$7E:364A];|
$82:A81D 29 FF E3    AND #$E3FF             ;|
$82:A820 09 00 14    ORA #$1400             ;|
$82:A823 9F 4A 36 7E STA $7E364A,x[$7E:364A];} Set tilemap palette indices at pause menu map tilemap tile (5..9, 19h) to 5 (top of MAP)
$82:A827 E8          INX                    ;|
$82:A828 E8          INX                    ;|
$82:A829 88          DEY                    ;|
$82:A82A 88          DEY                    ;|
$82:A82B D0 EC       BNE $EC    [$A819]     ;/
$82:A82D 28          PLP
$82:A82E 08          PHP
$82:A82F C2 30       REP #$30
$82:A831 A0 0A 00    LDY #$000A             ;\
$82:A834 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:A837 BF 8A 36 7E LDA $7E368A,x[$7E:368A];|
$82:A83B 29 FF E3    AND #$E3FF             ;|
$82:A83E 09 00 14    ORA #$1400             ;|
$82:A841 9F 8A 36 7E STA $7E368A,x[$7E:368A];} Set tilemap palette indices at pause menu map tilemap tile (5..9, 1Ah) to 5 (bottom of MAP)
$82:A845 E8          INX                    ;|
$82:A846 E8          INX                    ;|
$82:A847 88          DEY                    ;|
$82:A848 88          DEY                    ;|
$82:A849 D0 EC       BNE $EC    [$A837]     ;/
$82:A84B 28          PLP
$82:A84C 60          RTS
}


;;; $A84D: Update pause menu L/R/start VRAM tilemap ;;;
{
$82:A84D 08          PHP
$82:A84E C2 30       REP #$30
$82:A850 AE 30 03    LDX $0330  [$7E:0330]  ;\
$82:A853 A9 80 00    LDA #$0080             ;|
$82:A856 95 D0       STA $D0,x  [$7E:00D0]  ;|
$82:A858 E8          INX                    ;|
$82:A859 E8          INX                    ;|
$82:A85A A9 40 36    LDA #$3640             ;|
$82:A85D 95 D0       STA $D0,x  [$7E:00D2]  ;|
$82:A85F E8          INX                    ;|
$82:A860 E8          INX                    ;|
$82:A861 E2 20       SEP #$20               ;|
$82:A863 A9 7E       LDA #$7E               ;|
$82:A865 95 D0       STA $D0,x  [$7E:00D4]  ;} Queue transfer of pause menu map tilemap rows 19h..1Ah to VRAM BG2 tilemap rows 19h..1Ah
$82:A867 C2 20       REP #$20               ;|
$82:A869 E8          INX                    ;|
$82:A86A A5 59       LDA $59    [$7E:0059]  ;|
$82:A86C 29 FC 00    AND #$00FC             ;|
$82:A86F EB          XBA                    ;|
$82:A870 18          CLC                    ;|
$82:A871 69 20 03    ADC #$0320             ;|
$82:A874 95 D0       STA $D0,x  [$7E:00D5]  ;|
$82:A876 E8          INX                    ;|
$82:A877 E8          INX                    ;|
$82:A878 8E 30 03    STX $0330  [$7E:0330]  ;/
$82:A87B 28          PLP
$82:A87C 60          RTS
}


;;; $A87D: Unused. External draw equipment screen spritemap ;;;
{
$82:A87D 20 81 A8    JSR $A881  [$82:A881]
$82:A880 6B          RTL
}


;;; $A881: Draw pause screen sprite animation ;;;
{
;; Parameters:
;;     A: Animation ID + 1
;;     X: X position
;;     Y: Y position + 1

; Used for L/R highlight ($A59A), item selector ($B267), and map scroll arrow ($B90A)

; [$C0B2 + (animation ID) * 2]: Animation timer pointer (in RAM, $0729..3A)
; [$C0C4 + (animation ID) * 2]: Animation frame pointer (in RAM, $073D..4E), indexes animation data
; [$C0D6 + (animation ID) * 2]: Animation mode pointer (in RAM, $0751..62)
; [$C0E8 + (animation ID) * 2]: Animation data pointer (in bank $82). Timers and spritemap IDs indices (always zero?)
; [$C1E4 + (animation ID) * 2]: Animation spritemap base IDs pointer (in bank $82)

$82:A881 08          PHP
$82:A882 DA          PHX
$82:A883 C2 30       REP #$30
$82:A885 86 12       STX $12    [$7E:0012]  ; $12 = [X]
$82:A887 84 14       STY $14    [$7E:0014]  ; $14 = [Y]
$82:A889 3A          DEC A                  ;\
$82:A88A 0A          ASL A                  ;} X = ([A] - 1) * 2
$82:A88B AA          TAX                    ;/
$82:A88C BD B2 C0    LDA $C0B2,x[$82:C0B4]  ;\
$82:A88F A8          TAY                    ;|
$82:A890 B9 00 00    LDA $0000,y[$7E:072B]  ;} Decrement (animation timer)
$82:A893 3A          DEC A                  ;|
$82:A894 99 00 00    STA $0000,y[$7E:072B]  ;/
$82:A897 F0 02       BEQ $02    [$A89B]     ;\
$82:A899 10 3F       BPL $3F    [$A8DA]     ;} If [(animation timer)] > 0: go to BRANCH_NON_ZERO

$82:A89B 84 18       STY $18    [$7E:0018]
$82:A89D BD C4 C0    LDA $C0C4,x[$82:C0C6]  ;\
$82:A8A0 A8          TAY                    ;|
$82:A8A1 B9 00 00    LDA $0000,y[$7E:073F]  ;} Increment (animation frame)
$82:A8A4 1A          INC A                  ;|
$82:A8A5 99 00 00    STA $0000,y[$7E:073F]  ;/
$82:A8A8 0A          ASL A                  ;\
$82:A8A9 18          CLC                    ;|
$82:A8AA 79 00 00    ADC $0000,y[$7E:073F]  ;|
$82:A8AD 85 16       STA $16    [$7E:0016]  ;|
$82:A8AF BD E8 C0    LDA $C0E8,x[$82:C0EA]  ;|
$82:A8B2 18          CLC                    ;|
$82:A8B3 65 16       ADC $16    [$7E:0016]  ;} If [(animation data pointer) + [(animation frame)] * 3] = FFh:
$82:A8B5 A8          TAY                    ;|
$82:A8B6 B9 00 00    LDA $0000,y[$82:C10F]  ;|
$82:A8B9 29 FF 00    AND #$00FF             ;|
$82:A8BC C9 FF 00    CMP #$00FF             ;|
$82:A8BF D0 14       BNE $14    [$A8D5]     ;/
$82:A8C1 BD C4 C0    LDA $C0C4,x[$82:C0C6]  ;\
$82:A8C4 A8          TAY                    ;|
$82:A8C5 A9 00 00    LDA #$0000             ;} (Animation frame) = 0
$82:A8C8 99 00 00    STA $0000,y[$7E:073F]  ;/
$82:A8CB BD E8 C0    LDA $C0E8,x[$82:C0EA]
$82:A8CE A8          TAY
$82:A8CF B9 00 00    LDA $0000,y[$82:C10C]
$82:A8D2 29 FF 00    AND #$00FF

$82:A8D5 A4 18       LDY $18    [$7E:0018]  ;\
$82:A8D7 99 00 00    STA $0000,y[$7E:072B]  ;} (Animation timer) = [(animation data pointer) + [(animation frame)] * 3]

; BRANCH_NON_ZERO
$82:A8DA BD C4 C0    LDA $C0C4,x[$82:C0C6]  ;\
$82:A8DD A8          TAY                    ;|
$82:A8DE B9 00 00    LDA $0000,y[$7E:073F]  ;|
$82:A8E1 0A          ASL A                  ;|
$82:A8E2 18          CLC                    ;|
$82:A8E3 79 00 00    ADC $0000,y[$7E:073F]  ;|
$82:A8E6 85 18       STA $18    [$7E:0018]  ;} Y = (animation data pointer) + [(animation frame)] * 3 + 1
$82:A8E8 BD E8 C0    LDA $C0E8,x[$82:C0EA]  ;|
$82:A8EB 18          CLC                    ;|
$82:A8EC 65 18       ADC $18    [$7E:0018]  ;|
$82:A8EE 1A          INC A                  ;|
$82:A8EF A8          TAY                    ;/
$82:A8F0 5A          PHY                    ;\
$82:A8F1 A9 03 00    LDA #$0003             ;|
$82:A8F4 0A          ASL A                  ;|
$82:A8F5 A8          TAY                    ;} $03 = 600h (palette 3)
$82:A8F6 B9 FA C0    LDA $C0FA,y[$82:C100]  ;|
$82:A8F9 85 03       STA $03    [$7E:0003]  ;|
$82:A8FB 7A          PLY                    ;/
$82:A8FC C8          INY                    ;\
$82:A8FD B9 00 00    LDA $0000,y[$82:C10E]  ;|
$82:A900 29 FF 00    AND #$00FF             ;} $18 = [[Y] + 1] (animation frame spritemap ID)
$82:A903 85 18       STA $18    [$7E:0018]  ;/
$82:A905 BD D6 C0    LDA $C0D6,x[$82:C0D8]  ;\
$82:A908 A8          TAY                    ;|
$82:A909 B9 00 00    LDA $0000,y[$7E:0753]  ;|
$82:A90C 29 FF 00    AND #$00FF             ;|
$82:A90F 0A          ASL A                  ;|
$82:A910 85 1A       STA $1A    [$7E:001A]  ;} Y = [(animation spritemap base IDs) + (animation mode) * 2]
$82:A912 BD E4 C1    LDA $C1E4,x[$82:C1E6]  ;|
$82:A915 18          CLC                    ;|
$82:A916 65 1A       ADC $1A    [$7E:001A]  ;|
$82:A918 A8          TAY                    ;/
$82:A919 B9 00 00    LDA $0000,y[$82:C1FC]  ;\
$82:A91C 18          CLC                    ;} A = [Y] + [$18]
$82:A91D 65 18       ADC $18    [$7E:0018]  ;/
$82:A91F A6 12       LDX $12    [$7E:0012]  ; X = [$12]
$82:A921 A4 14       LDY $14    [$7E:0014]  ;\
$82:A923 88          DEY                    ;} Y = [$14] - 1
$82:A924 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:A928 FA          PLX
$82:A929 28          PLP
$82:A92A 60          RTS
}


;;; $A92B: Handle pause screen palette animation ;;;
{
; Map arrows, status selection box, etc.
$82:A92B 08          PHP
$82:A92C E2 20       SEP #$20
$82:A92E A9 00       LDA #$00               ;\
$82:A930 EB          XBA                    ;} A high = 0
$82:A931 A9 00       LDA #$00               ; >_<;
$82:A933 AD 3B 07    LDA $073B  [$7E:073B]  ;\
$82:A936 F0 4D       BEQ $4D    [$A985]     ;} If [pause screen palette animation timer] = 0: return
$82:A938 3A          DEC A                  ;\
$82:A939 8D 3B 07    STA $073B  [$7E:073B]  ;} Decrement pause screen palette animation timer
$82:A93C D0 47       BNE $47    [$A985]     ; If [pause screen palette animation timer] != 0: return
$82:A93E AD 4F 07    LDA $074F  [$7E:074F]  ;\
$82:A941 1A          INC A                  ;} Increment pause screen palette animation frame

; LOOP
$82:A942 8D 4F 07    STA $074F  [$7E:074F]
$82:A945 0A          ASL A                  ;\
$82:A946 18          CLC                    ;|
$82:A947 6D 4F 07    ADC $074F  [$7E:074F]  ;|
$82:A94A AA          TAX                    ;} If [$C10C + [pause screen palette animation frame] * 3] = FFh:
$82:A94B BD 0C C1    LDA $C10C,x[$82:C10F]  ;|
$82:A94E C9 FF       CMP #$FF               ;|
$82:A950 D0 12       BNE $12    [$A964]     ;/
$82:A952 C2 30       REP #$30               ;\
$82:A954 A9 2A 00    LDA #$002A             ;|
$82:A957 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2Ah, sound library 3, max queued sounds allowed = 6 (pause menu ambient beep)
$82:A95B E2 20       SEP #$20               ;/
$82:A95D A9 00       LDA #$00               ;\
$82:A95F EB          XBA                    ;} A high = 0
$82:A960 A9 00       LDA #$00               ; Pause screen palette animation frame = 0
$82:A962 80 DE       BRA $DE    [$A942]     ; Go to LOOP

$82:A964 8D 3B 07    STA $073B  [$7E:073B]  ; Pause screen palette animation timer = [$C10C + [pause screen palette animation frame] * 3]
$82:A967 AD 4F 07    LDA $074F  [$7E:074F]  ;\
$82:A96A C2 30       REP #$30               ;|
$82:A96C EB          XBA                    ;|
$82:A96D 4A          LSR A                  ;|
$82:A96E 4A          LSR A                  ;|
$82:A96F 4A          LSR A                  ;|
$82:A970 18          CLC                    ;|
$82:A971 69 1E 00    ADC #$001E             ;|
$82:A974 A8          TAY                    ;|
$82:A975 A2 1E 00    LDX #$001E             ;} Sprite palette 3 = 20h bytes from $A987 + [pause screen palette animation frame] * 20h
                                            ;|
$82:A978 B9 87 A9    LDA $A987,y[$82:A9C5]  ;|
$82:A97B 9F 60 C1 7E STA $7EC160,x[$7E:C17E];|
$82:A97F 88          DEY                    ;|
$82:A980 88          DEY                    ;|
$82:A981 CA          DEX                    ;|
$82:A982 CA          DEX                    ;|
$82:A983 10 F3       BPL $F3    [$A978]     ;/

$82:A985 28          PLP
$82:A986 60          RTS

; Palette data
$82:A987             dw 0000,7E7F,015F,7C14,7FFF,4E73,0000,318C,0070,2870,318C,0000,0000,318C,0000,318C,
                        0000,6E1C,011B,7412,739C,5294,00A6,294D,004E,3092,294B,00A6,1084,294A,0000,298E,
                        0000,61BA,00F9,6810,6B5A,56B5,012A,2530,004C,34B4,294B,012A,18C6,2108,0000,25B0,
                        0000,5577,00B6,580C,6318,5AD6,018E,2111,004B,3CF5,252B,018E,294A,1CE7,0000,21B1,
                        0000,5156,0093,500A,6318,6318,0212,1CF2,0028,3CF6,210B,0212,39CE,14A5,0000,1DD3,
                        0000,44F4,0012,4407,5AD6,6739,0296,18D5,0004,4518,18CB,0296,4A52,0C63,0000,15D6,
                        0000,3CD2,0070,3805,5294,739C,02FA,0C7A,0002,495A,0C6F,02FA,6318,0421,0000,0DFA,
                        0000,200D,000A,2C02,4E73,7FFF,039F,001F,0000,559D,001D,039F,7FFF,0000,0000,023F,
                        0000,3CD2,0070,3805,5294,739C,02FA,0C7A,0002,495A,0C6F,02FA,6318,0421,0000,0DFA,
                        0000,44F4,0012,4407,5AD6,6739,0296,18D5,0004,4518,18CB,0296,4A52,0C63,0000,15D6,
                        0000,5156,0093,500A,6318,6318,0212,1CF2,0028,3CF6,210B,0212,39CE,14A5,0000,1DD3,
                        0000,5577,00B6,580C,6318,5AD6,018E,2111,004B,3CF5,252B,018E,294A,1CE7,0000,21B1,
                        0000,61BA,00F9,6810,6B5A,56B5,012A,2530,004C,34B4,294B,012A,18C6,2108,0000,25B0,
                        0000,6E1C,011B,7412,739C,5294,00A6,294D,004E,3092,294B,00A6,1084,294A,0000,298E
}
}


;;; $AB47..B5E7: Equipment screen ;;;
{
;;; $AB47: Equipment screen - set up reserve mode and determine initial selection ;;;
{
$82:AB47 08          PHP
$82:AB48 C2 30       REP #$30
$82:AB4A A5 B1       LDA $B1    [$7E:00B1]  ;\
$82:AB4C 85 BD       STA $BD    [$7E:00BD]  ;} BG4 X scroll = [BG1 X scroll]
$82:AB4E A5 B3       LDA $B3    [$7E:00B3]  ;\
$82:AB50 85 BF       STA $BF    [$7E:00BF]  ;} BG4 Y scroll = [BG1 Y scroll]
$82:AB52 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$82:AB54 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$82:AB56 AD D4 09    LDA $09D4  [$7E:09D4]  ;\
$82:AB59 F0 3A       BEQ $3A    [$AB95]     ;} If [Samus max reserve health] = 0: go to BRANCH_NO_RESERVES
$82:AB5B AD C0 09    LDA $09C0  [$7E:09C0]  ;\
$82:AB5E F0 35       BEQ $35    [$AB95]     ;} If not obtained reserve health: go to BRANCH_NO_RESERVES
$82:AB60 A2 2A BF    LDX #$BF2A             ;\
$82:AB63 A0 82 00    LDY #$0082             ;} $00 = $82:BF2A ([ AUTO ])
$82:AB66 C9 01 00    CMP #$0001             ;\
$82:AB69 F0 06       BEQ $06    [$AB71]     ;} If [reserve health mode] != auto:
$82:AB6B A2 22 BF    LDX #$BF22             ;\
$82:AB6E A0 82 00    LDY #$0082             ;} $00 = $82:BF22 ([MANUAL])

$82:AB71 84 02       STY $02    [$7E:0002]
$82:AB73 86 00       STX $00    [$7E:0000]
$82:AB75 A9 04 00    LDA #$0004             ;\
$82:AB78 85 12       STA $12    [$7E:0012]  ;|
$82:AB7A A2 00 00    LDX #$0000             ;|
$82:AB7D A0 00 00    LDY #$0000             ;|
                                            ;|
$82:AB80 BF 8E 3A 7E LDA $7E3A8E,x[$7E:3A8E];|
$82:AB84 29 00 FC    AND #$FC00             ;|
$82:AB87 17 00       ORA [$00],y[$82:BF2A]  ;} Equipment screen BG1 tilemap (7..Ah, Ah) = [equipment screen BG1 tilemap (7..Ah, Ah)] & ~3FFh | [[$00] .. [$00]+7]
$82:AB89 9F 8E 3A 7E STA $7E3A8E,x[$7E:3A8E];} (Copy 4 tile numbers from [$00])
$82:AB8D C8          INY                    ;|
$82:AB8E C8          INY                    ;|
$82:AB8F E8          INX                    ;|
$82:AB90 E8          INX                    ;|
$82:AB91 C6 12       DEC $12    [$7E:0012]  ;|
$82:AB93 D0 EB       BNE $EB    [$AB80]     ;/

; BRANCH_NO_RESERVES
$82:AB95 9C 41 07    STZ $0741  [$7E:0741]  ; Item selector animation frame = 0
$82:AB98 AD 0C C1    LDA $C10C  [$82:C10C]  ;\
$82:AB9B 29 FF 00    AND #$00FF             ;} Item selector animation timer = Fh
$82:AB9E 8D 2D 07    STA $072D  [$7E:072D]  ;/
$82:ABA1 9C 43 07    STZ $0743  [$7E:0743]  ; Reserve tank animation frame = 0
$82:ABA4 AD 65 C1    LDA $C165  [$82:C165]  ;\
$82:ABA7 29 FF 00    AND #$00FF             ;} Reserve tank animation timer = Fh
$82:ABAA 8D 2F 07    STA $072F  [$7E:072F]  ;/
$82:ABAD AD D4 09    LDA $09D4  [$7E:09D4]  ;\
$82:ABB0 F0 08       BEQ $08    [$ABBA]     ;} If [Samus max reserve health] != 0:
$82:ABB2 A9 00 00    LDA #$0000             ;\
$82:ABB5 8D 55 07    STA $0755  [$7E:0755]  ;} Equipment screen category index = tanks
$82:ABB8 80 5B       BRA $5B    [$AC15]     ; Go to BRANCH_RETURN

$82:ABBA AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$82:ABBD D0 1F       BNE $1F    [$ABDE]     ;} If hyper beam obtained: go to BRANCH_NO_BEAMS
$82:ABBF AD A8 09    LDA $09A8  [$7E:09A8]
$82:ABC2 A2 00 00    LDX #$0000             ; X = 0

; LOOP_BEAMS
$82:ABC5 3C 4C C0    BIT $C04C,x            ;\
$82:ABC8 D0 09       BNE $09    [$ABD3]     ;} If [collected beams] & [$C04C + [X]] = 0:
$82:ABCA E8          INX                    ;\
$82:ABCB E8          INX                    ;} X += 2
$82:ABCC E0 0A 00    CPX #$000A             ;\
$82:ABCF 30 F4       BMI $F4    [$ABC5]     ;} If [X] < Ah: go to LOOP_BEAMS
$82:ABD1 80 0B       BRA $0B    [$ABDE]     ; Go to BRANCH_NO_BEAMS

$82:ABD3 8A          TXA                    ;\
$82:ABD4 4A          LSR A                  ;} Equipment screen item index = [X] / 2
$82:ABD5 EB          XBA                    ;/
$82:ABD6 09 01 00    ORA #$0001             ; Equipment screen category index = weapons
$82:ABD9 8D 55 07    STA $0755  [$7E:0755]
$82:ABDC 80 37       BRA $37    [$AC15]     ; Go to BRANCH_RETURN

; BRANCH_NO_BEAMS
$82:ABDE AD A4 09    LDA $09A4  [$7E:09A4]
$82:ABE1 A2 00 00    LDX #$0000             ; X = 0

; LOOP_SUIT_MISC
$82:ABE4 3C 56 C0    BIT $C056,x            ;\
$82:ABE7 D0 09       BNE $09    [$ABF2]     ;} If [collected items] & [$C056 + [X]] = 0:
$82:ABE9 E8          INX                    ;\
$82:ABEA E8          INX                    ;} X += 2
$82:ABEB E0 0C 00    CPX #$000C             ;\
$82:ABEE 30 F4       BMI $F4    [$ABE4]     ;} If [X] < Ah: go to LOOP_SUIT_MISC
$82:ABF0 80 0B       BRA $0B    [$ABFD]     ; Go to BRANCH_NO_SUIT_MISC

$82:ABF2 8A          TXA                    ;\
$82:ABF3 4A          LSR A                  ;} Equipment screen item index = [X] / 2
$82:ABF4 EB          XBA                    ;/
$82:ABF5 09 02 00    ORA #$0002             ; Equipment screen category index = suit/misc
$82:ABF8 8D 55 07    STA $0755  [$7E:0755]
$82:ABFB 80 18       BRA $18    [$AC15]     ; Go to BRANCH_RETURN

; BRANCH_NO_SUIT_MISC
$82:ABFD A2 00 00    LDX #$0000             ;\
                                            ;|
$82:AC00 3C 62 C0    BIT $C062,x            ;|
$82:AC03 E8          INX                    ;} Inefficient NOP
$82:AC04 E8          INX                    ;|
$82:AC05 E0 06 00    CPX #$0006             ;|
$82:AC08 30 F6       BMI $F6    [$AC00]     ;/
$82:AC0A 80 09       BRA $09    [$AC15]     ; Go to BRANCH_RETURN
$82:AC0C 8A          TXA                    ;\
$82:AC0D 4A          LSR A                  ;|
$82:AC0E EB          XBA                    ;} Dead code (should be allowing boots to be the initial selection)
$82:AC0F 09 03 00    ORA #$0003             ;|
$82:AC12 8D 55 07    STA $0755  [$7E:0755]  ;/

; BRANCH_RETURN
$82:AC15 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:AC18 F0 06       BEQ $06    [$AC20]     ;} If [Samus reserve health] != 0:
$82:AC1A 20 DD AD    JSR $ADDD  [$82:ADDD]  ; Glowing arrow - solid - on
$82:AC1D 20 E0 B1    JSR $B1E0  [$82:B1E0]  ; Write Samus wireframe tilemap and queue transfer of BG1 to VRAM

$82:AC20 28          PLP
$82:AC21 60          RTS
}


;;; $AC22: Equipment screen - transfer BG1 tilemap ;;;
{
$82:AC22 08          PHP
$82:AC23 8B          PHB
$82:AC24 4B          PHK
$82:AC25 AB          PLB
$82:AC26 E2 30       SEP #$30
$82:AC28 A9 00       LDA #$00               ;\
$82:AC2A 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:AC2D A9 30       LDA #$30               ;|
$82:AC2F 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:AC32 A9 80       LDA #$80               ;|
$82:AC34 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $3000..33FF = [$7E:3800..3FFF]
$82:AC37 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:AC3B             dx 01,01,18,7E3800,0800;|
$82:AC43 A9 02       LDA #$02               ;|
$82:AC45 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:AC48 64 B3       STZ $B3    [$7E:00B3]  ;\
$82:AC4A 64 B4       STZ $B4    [$7E:00B4]  ;} BG1 Y scroll = 0
$82:AC4C AB          PLB
$82:AC4D 28          PLP
$82:AC4E 6B          RTL
}


;;; $AC4F: Equipment screen - main ;;;
{
$82:AC4F 08          PHP
$82:AC50 C2 30       REP #$30
$82:AC52 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:AC55 29 FF 00    AND #$00FF             ;|
$82:AC58 0A          ASL A                  ;} Execute [$AC68 + [equipment screen category index]]
$82:AC59 AA          TAX                    ;|
$82:AC5A FC 68 AC    JSR ($AC68,x)[$82:AC70];/
$82:AC5D 20 67 B2    JSR $B267  [$82:B267]  ; Draw item selector
$82:AC60 20 A2 B2    JSR $B2A2  [$82:B2A2]  ; Display reserve tank amount
$82:AC63 20 E0 B1    JSR $B1E0  [$82:B1E0]  ; Write Samus wireframe tilemap and queue transfer of BG1 to VRAM
$82:AC66 28          PLP
$82:AC67 60          RTS

$82:AC68             dw AC70, AFBE, B0C2, B150
}


;;; $AC70: Equipment screen - main - tanks ;;;
{
$82:AC70 08          PHP
$82:AC71 C2 30       REP #$30
$82:AC73 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:AC76 EB          XBA                    ;|
$82:AC77 29 FF 00    AND #$00FF             ;|
$82:AC7A 0A          ASL A                  ;} Execute [$AC87 + [equipment screen item index]]
$82:AC7B AA          TAX                    ;|
$82:AC7C FC 87 AC    JSR ($AC87,x)[$82:AE8B];/
$82:AC7F 20 8B AC    JSR $AC8B  [$82:AC8B]  ; D-pad response
$82:AC82 20 0A AD    JSR $AD0A  [$82:AD0A]  ; Glowing arrow
$82:AC85 28          PLP
$82:AC86 60          RTS

$82:AC87             dw AE8B, AF4F
}


;;; $AC8B: Equipment screen - main - tanks - d-pad response ;;;
{
; If this routine successfully moves the cursor,
; it should really clear $0757 to stop the manual reserve tank refill if one happens to be active
; The consequence of not doing this is that: starting a manual refill, moving the cursor away,
; and moving the cursor back to reserve tank again; causes the refill to automatically continue without needing to press A
$82:AC8B 08          PHP
$82:AC8C C2 30       REP #$30
$82:AC8E AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:AC91 85 12       STA $12    [$7E:0012]  ;} $12 = [equipment screen indices]
$82:AC93 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:AC95 89 00 01    BIT #$0100             ;} If not newly pressed right: go to BRANCH_NOT_RIGHT
$82:AC98 F0 18       BEQ $18    [$ACB2]     ;/
$82:AC9A 89 00 04    BIT #$0400             ;\
$82:AC9D D0 0B       BNE $0B    [$ACAA]     ;} If not newly pressed down:
$82:AC9F A2 00 00    LDX #$0000             ;\
$82:ACA2 20 B7 B4    JSR $B4B7  [$82:B4B7]  ;} Move to suits/misc.
$82:ACA5 C9 FF FF    CMP #$FFFF             ;\
$82:ACA8 D0 06       BNE $06    [$ACB0]     ;} If moved: return

$82:ACAA A2 00 00    LDX #$0000             ;\
$82:ACAD 20 11 B5    JSR $B511  [$82:B511]  ;} Move to boots

$82:ACB0 28          PLP
$82:ACB1 60          RTS

; BRANCH_NOT_RIGHT
$82:ACB2 89 00 08    BIT #$0800             ;\
$82:ACB5 D0 38       BNE $38    [$ACEF]     ;} If newly pressed up: go to BRANCH_UP
$82:ACB7 89 00 04    BIT #$0400             ;\
$82:ACBA F0 F4       BEQ $F4    [$ACB0]     ;} If not newly pressed down: return
$82:ACBC AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:ACBF 29 00 FF    AND #$FF00             ;|
$82:ACC2 C9 00 01    CMP #$0100             ;} If [equipment screen item index] != reserve tank:
$82:ACC5 F0 20       BEQ $20    [$ACE7]     ;/
$82:ACC7 AD C0 09    LDA $09C0  [$7E:09C0]  ;\
$82:ACCA C9 01 00    CMP #$0001             ;} If [reserve health mode] != auto:
$82:ACCD F0 18       BEQ $18    [$ACE7]     ;/
$82:ACCF AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:ACD2 18          CLC                    ;|
$82:ACD3 69 00 01    ADC #$0100             ;} Equipment screen item index = reserve tank
$82:ACD6 8D 55 07    STA $0755  [$7E:0755]  ;/
$82:ACD9 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:ACDC F0 09       BEQ $09    [$ACE7]     ;} If [Samus reserve health] != 0:
$82:ACDE A9 37 00    LDA #$0037             ;\
$82:ACE1 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:ACE5 80 21       BRA $21    [$AD08]     ; Return

$82:ACE7 A2 00 00    LDX #$0000             ;\
$82:ACEA 20 56 B4    JSR $B456  [$82:B456]  ;} Move to beams
$82:ACED 80 19       BRA $19    [$AD08]     ; Return

; BRANCH_UP
$82:ACEF AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:ACF2 29 00 FF    AND #$FF00             ;} If [equipment screen item index] != mode:
$82:ACF5 F0 11       BEQ $11    [$AD08]     ;/
$82:ACF7 A9 37 00    LDA #$0037             ;\
$82:ACFA 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:ACFE AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:AD01 38          SEC                    ;|
$82:AD02 E9 00 01    SBC #$0100             ;} Equipment screen item index = mode
$82:AD05 8D 55 07    STA $0755  [$7E:0755]  ;/

$82:AD08 28          PLP
$82:AD09 60          RTS
}


;;; $AD0A: Equipment screen - main - tanks - glowing arrow ;;;
{
$82:AD0A 08          PHP
$82:AD0B C2 30       REP #$30
$82:AD0D AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:AD10 89 FF 00    BIT #$00FF             ;} If [equipment screen category index] = tanks:
$82:AD13 D0 0B       BNE $0B    [$AD20]     ;/
$82:AD15 EB          XBA                    ;\
$82:AD16 29 FF 00    AND #$00FF             ;|
$82:AD19 0A          ASL A                  ;} Execute [$AD25 + [equipment screen item index] * 2]
$82:AD1A AA          TAX                    ;|
$82:AD1B FC 25 AD    JSR ($AD25,x)[$82:AD29];/
$82:AD1E 28          PLP
$82:AD1F 60          RTS                    ; Return

$82:AD20 20 EF AD    JSR $ADEF  [$82:ADEF]  ; Solid - off
$82:AD23 28          PLP
$82:AD24 60          RTS

$82:AD25             dw AD29, ADDD
}


;;; $AD29: Equipment screen - glowing arrow - animated ;;;
{
$82:AD29 AD C0 09    LDA $09C0  [$7E:09C0]  ;\
$82:AD2C C9 01 00    CMP #$0001             ;} If [reserve health mode] = auto:
$82:AD2F D0 1A       BNE $1A    [$AD4B]     ;/
$82:AD31 AD B5 05    LDA $05B5  [$7E:05B5]  ;\
$82:AD34 29 1F 00    AND #$001F             ;|
$82:AD37 0A          ASL A                  ;} X = [frame counter] % 20h * 2
$82:AD38 AA          TAX                    ;/
$82:AD39 BD 5D AD    LDA $AD5D,x[$82:AD7B]  ;\
$82:AD3C 8F CC C0 7E STA $7EC0CC[$7E:C0CC]  ;} BG palette 6 colour 6 = [$AD5D + [X]]
$82:AD40 BD 9D AD    LDA $AD9D,x[$82:ADBB]  ;\
$82:AD43 8F D6 C0 7E STA $7EC0D6[$7E:C0D6]  ;} BG palette 6 colour Bh = [$AD9D + [X]]
$82:AD47 20 01 AE    JSR $AE01  [$82:AE01]  ; Enable energy arrow glow
$82:AD4A 60          RTS                    ; Return

$82:AD4B A9 9E 03    LDA #$039E             ;\
$82:AD4E 8F D6 C0 7E STA $7EC0D6[$7E:C0D6]  ;} BG palette 6 colour Bh = (1Eh, 1Ch, 0)
$82:AD52 A9 56 01    LDA #$0156             ;\
$82:AD55 8F CC C0 7E STA $7EC0CC[$7E:C0CC]  ;} BG palette 6 colour 6 = (16h, Ah, 0)
$82:AD59 20 46 AE    JSR $AE46  [$82:AE46]  ; Disable energy arrow glow
$82:AD5C 60          RTS

$82:AD5D             dw 039E, 077D, 0B5C, 0F5B, 133A, 171A, 1F19, 22F8, 26D7, 2AD6, 2EB6, 3695, 3A94, 3E73, 4253, 4A52,
                        4A52, 4253, 3E73, 3A94, 3695, 2EB6, 2AD6, 26D7, 22F8, 1F19, 171A, 133A, 0F5B, 0B5C, 077D, 039E

$82:AD9D             dw 0156, 0155, 0554, 0954, 0D53, 0D52, 1152, 1551, 1970, 1D70, 1D6F, 216E, 256E, 296D, 296C, 318C,
                        318C, 296C, 296D, 256E, 216E, 1D6F, 1D70, 1970, 1551, 1152, 0D52, 0D53, 0954, 0554, 0155, 0156
}


;;; $ADDD: Equipment screen - glowing arrow - solid - on ;;;
{
$82:ADDD A9 9E 03    LDA #$039E             ;\
$82:ADE0 8F D6 C0 7E STA $7EC0D6[$7E:C0D6]  ;} BG palette 6 colour Bh = (1Eh, 1Ch, 0)
$82:ADE4 A9 56 01    LDA #$0156             ;\
$82:ADE7 8F CC C0 7E STA $7EC0CC[$7E:C0CC]  ;} BG palette 6 colour 6 = (16h, Ah, 0)
$82:ADEB 20 01 AE    JSR $AE01  [$82:AE01]  ; Enable energy arrow glow
$82:ADEE 60          RTS
}


;;; $ADEF: Equipment screen - glowing arrow - solid - off ;;;
{
$82:ADEF A9 9E 03    LDA #$039E             ;\
$82:ADF2 8F D6 C0 7E STA $7EC0D6[$7E:C0D6]  ;} BG palette 6 colour Bh = (1Eh, 1Ch, 0)
$82:ADF6 A9 56 01    LDA #$0156             ;\
$82:ADF9 8F CC C0 7E STA $7EC0CC[$7E:C0CC]  ;} BG palette 6 colour 6 = (16h, Ah, 0)
$82:ADFD 20 46 AE    JSR $AE46  [$82:AE46]  ; Disable energy arrow glow
$82:AE00 60          RTS
}


;;; $AE01: Equipment screen - enable energy arrow glow ;;;
{
$82:AE01 08          PHP                    ;\
$82:AE02 C2 30       REP #$30               ;|
$82:AE04 08          PHP                    ;} ...?!
$82:AE05 C2 30       REP #$30               ;/
$82:AE07 A0 10 00    LDY #$0010             ; Y = 10h
$82:AE0A A2 00 00    LDX #$0000             ; X = 0

; LOOP_VERTICAL
$82:AE0D BF 02 39 7E LDA $7E3902,x[$7E:3902];\
$82:AE11 29 FF E3    AND #$E3FF             ;|
$82:AE14 09 00 18    ORA #$1800             ;} Set tilemap palette index at $7E:3902 + [X] to 6
$82:AE17 9F 02 39 7E STA $7E3902,x[$7E:3902];/
$82:AE1B 8A          TXA                    ;\
$82:AE1C 18          CLC                    ;|
$82:AE1D 69 40 00    ADC #$0040             ;} X += 40h
$82:AE20 AA          TAX                    ;/
$82:AE21 88          DEY                    ;\
$82:AE22 88          DEY                    ;} Y -= 2
$82:AE23 D0 E8       BNE $E8    [$AE0D]     ; If [Y] != 0: go to LOOP_VERTICAL
$82:AE25 28          PLP                    ;\
$82:AE26 08          PHP                    ;} ...?!
$82:AE27 C2 30       REP #$30               ;/
$82:AE29 A0 04 00    LDY #$0004             ; Y = 4
$82:AE2C A2 00 00    LDX #$0000             ; X = 0

; LOOP_HORIZONTAL
$82:AE2F BF 02 3B 7E LDA $7E3B02,x[$7E:3B02];\
$82:AE33 29 FF E3    AND #$E3FF             ;|
$82:AE36 09 00 18    ORA #$1800             ;} Set tilemap palette index at $7E:3B02 + [X] to 6
$82:AE39 9F 02 3B 7E STA $7E3B02,x[$7E:3B02];/
$82:AE3D E8          INX                    ;\
$82:AE3E E8          INX                    ;} X += 2
$82:AE3F 88          DEY                    ;\
$82:AE40 88          DEY                    ;} Y -= 2
$82:AE41 D0 EC       BNE $EC    [$AE2F]     ; If [Y] != 0: go to LOOP_HORIZONTAL
$82:AE43 28          PLP
$82:AE44 28          PLP
$82:AE45 60          RTS
}


;;; $AE46: Equipment screen - disable energy arrow glow ;;;
{
$82:AE46 08          PHP                    ;\
$82:AE47 C2 30       REP #$30               ;|
$82:AE49 08          PHP                    ;} ...?!
$82:AE4A C2 30       REP #$30               ;/
$82:AE4C A0 10 00    LDY #$0010             ; Y = 10h
$82:AE4F A2 00 00    LDX #$0000             ; X = 0

; LOOP_VERTICAL
$82:AE52 BF 02 39 7E LDA $7E3902,x[$7E:3902];\
$82:AE56 29 FF E3    AND #$E3FF             ;|
$82:AE59 09 00 1C    ORA #$1C00             ;} Set tilemap palette index at $7E:3902 + [X] to 7
$82:AE5C 9F 02 39 7E STA $7E3902,x[$7E:3902];/
$82:AE60 8A          TXA                    ;\
$82:AE61 18          CLC                    ;|
$82:AE62 69 40 00    ADC #$0040             ;} X += 40h
$82:AE65 AA          TAX                    ;/
$82:AE66 88          DEY                    ;\
$82:AE67 88          DEY                    ;} Y -= 2
$82:AE68 D0 E8       BNE $E8    [$AE52]     ; If [Y] != 0: go to LOOP_VERTICAL
$82:AE6A 28          PLP                    ;\
$82:AE6B 08          PHP                    ;} ...?!
$82:AE6C C2 30       REP #$30               ;/
$82:AE6E A0 04 00    LDY #$0004             ; Y = 4
$82:AE71 A2 00 00    LDX #$0000             ; X = 0

; LOOP_HORIZONTAL
$82:AE74 BF 02 3B 7E LDA $7E3B02,x[$7E:3B02];\
$82:AE78 29 FF E3    AND #$E3FF             ;|
$82:AE7B 09 00 1C    ORA #$1C00             ;} Set tilemap palette index at $7E:3902 + [X] to 7
$82:AE7E 9F 02 3B 7E STA $7E3B02,x[$7E:3B02];/
$82:AE82 E8          INX                    ;\
$82:AE83 E8          INX                    ;} X += 2
$82:AE84 88          DEY                    ;\
$82:AE85 88          DEY                    ;} Y -= 2
$82:AE86 D0 EC       BNE $EC    [$AE74]     ; If [Y] != 0: go to LOOP_HORIZONTAL
$82:AE88 28          PLP
$82:AE89 28          PLP
$82:AE8A 60          RTS
}


;;; $AE8B: Equipment screen - main - tanks - mode ;;;
{
$82:AE8B 08          PHP
$82:AE8C C2 30       REP #$30
$82:AE8E A5 8F       LDA $8F    [$7E:008F]  ;\
$82:AE90 89 80 00    BIT #$0080             ;} If not newly pressed A: return
$82:AE93 F0 66       BEQ $66    [$AEFB]     ;/
$82:AE95 AD D4 09    LDA $09D4  [$7E:09D4]  ;\
$82:AE98 F0 61       BEQ $61    [$AEFB]     ;} If [Samus max reserve health] = 0: return
$82:AE9A A9 37 00    LDA #$0037             ;\
$82:AE9D 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:AEA1 AD C0 09    LDA $09C0  [$7E:09C0]  ;\
$82:AEA4 C9 01 00    CMP #$0001             ;} If [reserve health mode] != auto: go to BRANCH_MANUAL
$82:AEA7 D0 2A       BNE $2A    [$AED3]     ;/
$82:AEA9 A9 02 00    LDA #$0002             ;\
$82:AEAC 8D C0 09    STA $09C0  [$7E:09C0]  ;} Reserve health mode = manual
$82:AEAF 20 33 AF    JSR $AF33  [$82:AF33]  ; Clear HUD reserve AUTO tilemap
$82:AEB2 08          PHP
$82:AEB3 C2 30       REP #$30
$82:AEB5 A0 08 00    LDY #$0008             ;\
$82:AEB8 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:AEBB BF 8E 3A 7E LDA $7E3A8E,x          ;|
$82:AEBF 29 00 FC    AND #$FC00             ;|
$82:AEC2 1F 22 BF 82 ORA $82BF22,x          ;|
$82:AEC6 9F 8E 3A 7E STA $7E3A8E,x          ;} Equipment screen BG1 tilemap (7..Ah, Ah) = [equipment screen BG1 tilemap (7..Ah, Ah)] & ~3FFh | [$82:BF22..29] ([MANUAL] tile numbers)
$82:AECA E8          INX                    ;|
$82:AECB E8          INX                    ;|
$82:AECC 88          DEY                    ;|
$82:AECD 88          DEY                    ;|
$82:AECE D0 EB       BNE $EB    [$AEBB]     ;/
$82:AED0 28          PLP
$82:AED1 80 28       BRA $28    [$AEFB]     ; Return

; BRANCH_MANUAL
$82:AED3 A9 01 00    LDA #$0001             ;\
$82:AED6 8D C0 09    STA $09C0  [$7E:09C0]  ;} Reserve health mode = auto
$82:AED9 20 FD AE    JSR $AEFD  [$82:AEFD]  ; Set HUD reserve AUTO tilemap
$82:AEDC 08          PHP
$82:AEDD C2 30       REP #$30
$82:AEDF A0 08 00    LDY #$0008             ;\
$82:AEE2 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:AEE5 BF 8E 3A 7E LDA $7E3A8E,x          ;|
$82:AEE9 29 00 FC    AND #$FC00             ;|
$82:AEEC 1F 2A BF 82 ORA $82BF2A,x          ;|
$82:AEF0 9F 8E 3A 7E STA $7E3A8E,x          ;} Equipment screen BG1 tilemap (7..Ah, Ah) = [equipment screen BG1 tilemap (7..Ah, Ah)] & ~3FFh | [$82:BF2A..31] ([ AUTO ] tile numbers)
$82:AEF4 E8          INX                    ;|
$82:AEF5 E8          INX                    ;|
$82:AEF6 88          DEY                    ;|
$82:AEF7 88          DEY                    ;|
$82:AEF8 D0 EB       BNE $EB    [$AEE5]     ;/
$82:AEFA 28          PLP

$82:AEFB 28          PLP
$82:AEFC 60          RTS
}


;;; $AEFD: Equipment screen - set HUD reserve AUTO tilemap ;;;
{
; BUG: DB isn't set to $80 (where $998B/$9997 are HUD tilemaps),
; so this loads garbage that is immediately overwritten by the HUD update routine ($80:9B44).
; In short, this routine is useless

$82:AEFD A0 8B 99    LDY #$998B             ; Load (yellow) auto reserve
$82:AF00 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:AF03 D0 03       BNE $03    [$AF08]     ;} If [Samus reserve health] = 0:
$82:AF05 A0 97 99    LDY #$9997             ; Load (blue) empty auto reserve

$82:AF08 B9 00 00    LDA $0000,y            ;\
$82:AF0B 8F 18 C6 7E STA $7EC618[$7E:C618]  ;|
$82:AF0F B9 02 00    LDA $0002,y            ;} Write top row of auto reserve tilemap
$82:AF12 8F 1A C6 7E STA $7EC61A[$7E:C61A]  ;/
$82:AF16 B9 04 00    LDA $0004,y            ;\
$82:AF19 8F 58 C6 7E STA $7EC658[$7E:C658]  ;|
$82:AF1D B9 06 00    LDA $0006,y            ;} Write middle row of auto reserve tilemap
$82:AF20 8F 5A C6 7E STA $7EC65A[$7E:C65A]  ;/
$82:AF24 B9 08 00    LDA $0008,y            ;\
$82:AF27 8F 98 C6 7E STA $7EC698[$7E:C698]  ;|
$82:AF2B B9 0A 00    LDA $000A,y            ;} Write bottom row of auto reserve tilemap
$82:AF2E 8F 9A C6 7E STA $7EC69A[$7E:C69A]  ;/
$82:AF32 60          RTS
}


;;; $AF33: Equipment screen - clear HUD reserve AUTO tilemap ;;;
{
$82:AF33 A9 0F 2C    LDA #$2C0F
$82:AF36 8F 18 C6 7E STA $7EC618[$7E:C618]
$82:AF3A 8F 1A C6 7E STA $7EC61A[$7E:C61A]
$82:AF3E 8F 58 C6 7E STA $7EC658[$7E:C658]
$82:AF42 8F 5A C6 7E STA $7EC65A[$7E:C65A]
$82:AF46 8F 98 C6 7E STA $7EC698[$7E:C698]
$82:AF4A 8F 9A C6 7E STA $7EC69A[$7E:C69A]
$82:AF4E 60          RTS
}


;;; $AF4F: Equipment screen - main - tanks - reserve tank ;;;
{
; This routine contains the code the exhausts reserve health if Samus reaches max health
; The section at $AFB0 is executed when reserve health <= 0,
; it sets reserve health to zero just in case her reserve health became negative
; (which is a reasonable thing to do if you don't assume that [$BF04] is 1)
; The thing is, when Samus' health is fully replenished, the branch at $AF96 is taken to this same code,
; which IMO is a mistake, I think that branch should go $AFB3 instead, merely stopping the refill
$82:AF4F 08          PHP
$82:AF50 C2 30       REP #$30
$82:AF52 AD 57 07    LDA $0757  [$7E:0757]  ;\
$82:AF55 D0 14       BNE $14    [$AF6B]     ;} If [$0757] = 0:
$82:AF57 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:AF59 89 80 00    BIT #$0080             ;} If not newly pressed A: return
$82:AF5C F0 5E       BEQ $5E    [$AFBC]     ;/
$82:AF5E AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:AF61 18          CLC                    ;|
$82:AF62 69 07 00    ADC #$0007             ;} $0757 = [Samus reserve health] rounded up to nearest 8
$82:AF65 29 F8 FF    AND #$FFF8             ;|
$82:AF68 8D 57 07    STA $0757  [$7E:0757]  ;/

$82:AF6B AD 57 07    LDA $0757  [$7E:0757]  ;\
$82:AF6E 3A          DEC A                  ;} Decrement $0757
$82:AF6F 8D 57 07    STA $0757  [$7E:0757]  ;/
$82:AF72 29 07 00    AND #$0007             ;\
$82:AF75 C9 07 00    CMP #$0007             ;} If [$0757] % 8 = 7:
$82:AF78 D0 07       BNE $07    [$AF81]     ;/
$82:AF7A A9 2D 00    LDA #$002D             ;\
$82:AF7D 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2Dh, sound library 3, max queued sounds allowed = 6 (gaining/losing incremental health)

$82:AF81 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$82:AF84 18          CLC                    ;|
$82:AF85 6D 04 BF    ADC $BF04  [$82:BF04]  ;} Samus health += 1
$82:AF88 8D C2 09    STA $09C2  [$7E:09C2]  ;/
$82:AF8B CD C4 09    CMP $09C4  [$7E:09C4]  ;\
$82:AF8E 30 08       BMI $08    [$AF98]     ;} If [Samus health] >= [Samus max health]:
$82:AF90 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$82:AF93 8D C2 09    STA $09C2  [$7E:09C2]  ;} Samus health = [Samus max health]
$82:AF96 80 18       BRA $18    [$AFB0]

$82:AF98 AD D6 09    LDA $09D6  [$7E:09D6]  ;\ Else ([Samus health] < [Samus max health]):
$82:AF9B 38          SEC                    ;|
$82:AF9C ED 04 BF    SBC $BF04  [$82:BF04]  ;} Samus reserve health -= 1
$82:AF9F 8D D6 09    STA $09D6  [$7E:09D6]  ;/
$82:AFA2 F0 0C       BEQ $0C    [$AFB0]     ; If [Samus reserve health] != 0:
$82:AFA4 10 16       BPL $16    [$AFBC]     ; If [Samus reserve health] > 0: return
$82:AFA6 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$82:AFA9 18          CLC                    ;|
$82:AFAA 6D D6 09    ADC $09D6  [$7E:09D6]  ;} Samus health += [Samus reserve health]
$82:AFAD 8D C2 09    STA $09C2  [$7E:09C2]  ;/

$82:AFB0 9C D6 09    STZ $09D6  [$7E:09D6]  ; Samus reserve health = 0
$82:AFB3 9C 57 07    STZ $0757  [$7E:0757]  ; $0757 = 0
$82:AFB6 20 46 AE    JSR $AE46  [$82:AE46]  ; Disable energy arrow glow
$82:AFB9 9C 55 07    STZ $0755  [$7E:0755]  ; Equipment screen category index = tanks

$82:AFBC 28          PLP
$82:AFBD 60          RTS
}


;;; $AFBE: Equipment screen - main - weapons ;;;
{
$82:AFBE 08          PHP
$82:AFBF C2 30       REP #$30
$82:AFC1 20 DB AF    JSR $AFDB  [$82:AFDB]  ; Move response
$82:AFC4 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$82:AFC7 85 24       STA $24    [$7E:0024]  ;} $24 = [equipped beams] (previously equipped beams for the plasma-spazer check)
$82:AFC9 AD A8 09    LDA $09A8  [$7E:09A8]  ;\
$82:AFCC F0 0B       BEQ $0B    [$AFD9]     ;} If [collected beams] != 0:
$82:AFCE A9 0A 00    LDA #$000A             ;\
$82:AFD1 85 18       STA $18    [$7E:0018]  ;} $18 = Ah (weapon tilemap size in bytes)
$82:AFD3 20 68 B5    JSR $B568  [$82:B568]  ; Button response
$82:AFD6 20 68 B0    JSR $B068  [$82:B068]  ; Plasma-spazer check

$82:AFD9 28          PLP
$82:AFDA 60          RTS
}


;;; $AFDB: Equipment screen - main - weapons - move response ;;;
{
$82:AFDB 08          PHP
$82:AFDC C2 30       REP #$30
$82:AFDE AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:AFE1 85 12       STA $12    [$7E:0012]  ;} $12 = [equipment screen indices]
$82:AFE3 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:AFE5 89 00 01    BIT #$0100             ;} If not newly pressed right: go to BRANCH_RIGHT_END
$82:AFE8 F0 20       BEQ $20    [$B00A]     ;/
$82:AFEA 89 00 08    BIT #$0800             ;\
$82:AFED D0 13       BNE $13    [$B002]     ;} If not newly pressed up:
$82:AFEF A2 04 00    LDX #$0004             ;\
$82:AFF2 20 B7 B4    JSR $B4B7  [$82:B4B7]  ;} Move to suits/misc. morph ball or lower
$82:AFF5 C9 00 00    CMP #$0000             ;\
$82:AFF8 F0 6C       BEQ $6C    [$B066]     ;} If moved: return
$82:AFFA A2 00 00    LDX #$0000             ;\
$82:AFFD 20 11 B5    JSR $B511  [$82:B511]  ;} Move to top of boots
$82:B000 80 64       BRA $64    [$B066]     ; Return

$82:B002 A2 00 00    LDX #$0000             ;\
$82:B005 20 B7 B4    JSR $B4B7  [$82:B4B7]  ;} Move to top of suits/misc.
$82:B008 80 5C       BRA $5C    [$B066]     ; Return

; BRANCH_RIGHT_END
$82:B00A 89 00 04    BIT #$0400             ;\
$82:B00D D0 37       BNE $37    [$B046]     ;} If newly pressed down: go to BRANCH_DOWN
$82:B00F 89 00 08    BIT #$0800             ;\
$82:B012 F0 52       BEQ $52    [$B066]     ;} If not newly pressed up: return
$82:B014 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B017 29 00 FF    AND #$FF00             ;} If [equipment screen item index] != charge:
$82:B01A F0 18       BEQ $18    [$B034]     ;/
$82:B01C AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B01F 38          SEC                    ;|
$82:B020 E9 00 01    SBC #$0100             ;} Decrement equipment screen item index
$82:B023 8D 55 07    STA $0755  [$7E:0755]  ;/
$82:B026 EB          XBA                    ;\
$82:B027 29 FF 00    AND #$00FF             ;|
$82:B02A 0A          ASL A                  ;} X = [equipment screen item index] * 2
$82:B02B AA          TAX                    ;/
$82:B02C 20 89 B4    JSR $B489  [$82:B489]  ; Move higher on beams
$82:B02F C9 FF FF    CMP #$FFFF             ;\
$82:B032 D0 32       BNE $32    [$B066]     ;} If moved: return

$82:B034 A2 00 00    LDX #$0000             ;\
$82:B037 20 3F B4    JSR $B43F  [$82:B43F]  ;} Move to reserve tanks
$82:B03A C9 00 00    CMP #$0000             ;\
$82:B03D D0 27       BNE $27    [$B066]     ;} If moved: return
$82:B03F A5 12       LDA $12    [$7E:0012]  ;\
$82:B041 8D 55 07    STA $0755  [$7E:0755]  ;} Equipment screen indices = [$12]
$82:B044 80 20       BRA $20    [$B066]     ; Return

; BRANCH_DOWN
$82:B046 AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$82:B049 D0 1B       BNE $1B    [$B066]     ;} If hyper beam: return
$82:B04B AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B04E C9 01 04    CMP #$0401             ;} If [equipment screen item index] = plasma: return
$82:B051 F0 13       BEQ $13    [$B066]     ;/
$82:B053 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B056 18          CLC                    ;|
$82:B057 69 00 01    ADC #$0100             ;} Increment equipment screen item index
$82:B05A 8D 55 07    STA $0755  [$7E:0755]  ;/
$82:B05D EB          XBA                    ;\
$82:B05E 29 FF 00    AND #$00FF             ;|
$82:B061 0A          ASL A                  ;} X = [equipment screen item index] * 2
$82:B062 AA          TAX                    ;/
$82:B063 20 56 B4    JSR $B456  [$82:B456]  ; Move lower on beams

$82:B066 28          PLP
$82:B067 60          RTS
}


;;; $B068: Equipment screen - main - weapons - plasma-spazer check ;;;
{
;; Parameters:
;;     $24: Previously equipped beams
$82:B068 08          PHP
$82:B069 C2 30       REP #$30
$82:B06B A5 24       LDA $24    [$7E:0024]  ;\
$82:B06D 49 FF FF    EOR #$FFFF             ;|
$82:B070 2D A6 09    AND $09A6  [$7E:09A6]  ;} If spazer was toggled: go to BRANCH_SPAZER_TOGGLED
$82:B073 89 04 00    BIT #$0004             ;|
$82:B076 D0 21       BNE $21    [$B099]     ;/
$82:B078 89 08 00    BIT #$0008             ;\
$82:B07B F0 43       BEQ $43    [$B0C0]     ;} If plasma was not toggled: return

$82:B07D A5 24       LDA $24    [$7E:0024]  ;\
$82:B07F 89 08 00    BIT #$0008             ;} If plasma was previously equipped: return
$82:B082 D0 3C       BNE $3C    [$B0C0]     ;/
$82:B084 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$82:B087 89 04 00    BIT #$0004             ;} If spazer not equipped: return
$82:B08A F0 34       BEQ $34    [$B0C0]     ;/
$82:B08C 29 FB FF    AND #$FFFB             ;\
$82:B08F 8D A6 09    STA $09A6  [$7E:09A6]  ;} Unequip spazer beam
$82:B092 AD 72 C0    LDA $C072  [$82:C072]  ;\
$82:B095 85 00       STA $00    [$7E:0000]  ;} $00 = $3CC8 (spazer)
$82:B097 80 1A       BRA $1A    [$B0B3]     ; Go to BRANCH_MERGE

; BRANCH_SPAZER_TOGGLED
$82:B099 A5 24       LDA $24    [$7E:0024]  ;\
$82:B09B 89 04 00    BIT #$0004             ;} If spazer was previously equipped: return
$82:B09E D0 20       BNE $20    [$B0C0]     ;/
$82:B0A0 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$82:B0A3 89 08 00    BIT #$0008             ;} If plasma not equipped: return
$82:B0A6 F0 18       BEQ $18    [$B0C0]     ;/
$82:B0A8 29 F7 FF    AND #$FFF7             ;\
$82:B0AB 8D A6 09    STA $09A6  [$7E:09A6]  ;} Unequip plasma beam
$82:B0AE AD 74 C0    LDA $C074  [$82:C074]  ;\
$82:B0B1 85 00       STA $00    [$7E:0000]  ;} $00 = $3D08 (plasma)

; BRANCH_MERGE
$82:B0B3 A9 00 0C    LDA #$0C00             ;\
$82:B0B6 85 12       STA $12    [$7E:0012]  ;} $12 = C00h (palette 6)
$82:B0B8 A9 0A 00    LDA #$000A             ;\
$82:B0BB 85 16       STA $16    [$7E:0016]  ;} $16 = Ah
$82:B0BD 20 9D A2    JSR $A29D  [$82:A29D]  ; Set the palette of [$16] bytes of $7E:[$00] to [$12]

$82:B0C0 28          PLP
$82:B0C1 60          RTS
}


;;; $B0C2: Equipment screen - main - suit/misc. ;;;
{
$82:B0C2 08          PHP
$82:B0C3 C2 30       REP #$30
$82:B0C5 20 D2 B0    JSR $B0D2  [$82:B0D2]  ; Move response
$82:B0C8 A9 12 00    LDA #$0012             ;\
$82:B0CB 85 18       STA $18    [$7E:0018]  ;} $18 = 12h (suit/misc. tilemap size in bytes)
$82:B0CD 20 68 B5    JSR $B568  [$82:B568]  ; Button response
$82:B0D0 28          PLP
$82:B0D1 60          RTS
}


;;; $B0D2: Equipment screen - suit/misc. - move response ;;;
{
$82:B0D2 08          PHP
$82:B0D3 C2 30       REP #$30
$82:B0D5 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B0D8 85 12       STA $12    [$7E:0012]  ;} $12 = [equipment screen indices]
$82:B0DA A5 8F       LDA $8F    [$7E:008F]  ;\
$82:B0DC 89 00 02    BIT #$0200             ;} If not newly pressed left: go to BRANCH_LEFT_END
$82:B0DF F0 1D       BEQ $1D    [$B0FE]     ;/
$82:B0E1 89 00 04    BIT #$0400             ;\
$82:B0E4 D0 10       BNE $10    [$B0F6]     ;} If not newly pressed down:
$82:B0E6 A2 00 00    LDX #$0000             ;\
$82:B0E9 20 3F B4    JSR $B43F  [$82:B43F]  ;} Move to reserve tanks
$82:B0EC C9 00 00    CMP #$0000             ;\
$82:B0EF D0 5D       BNE $5D    [$B14E]     ;} If moved: return
$82:B0F1 A5 12       LDA $12    [$7E:0012]  ;\
$82:B0F3 8D 55 07    STA $0755  [$7E:0755]  ;} Equipment screen indices = [$12]

$82:B0F6 A2 00 00    LDX #$0000             ;\
$82:B0F9 20 56 B4    JSR $B456  [$82:B456]  ;} Move to top of beams
$82:B0FC 80 50       BRA $50    [$B14E]     ; Return

; BRANCH_LEFT_END
$82:B0FE 89 00 08    BIT #$0800             ;\
$82:B101 D0 30       BNE $30    [$B133]     ;} If newly pressed up: go to BRANCH_UP
$82:B103 89 00 04    BIT #$0400             ;\
$82:B106 F0 46       BEQ $46    [$B14E]     ;} If not newly pressed down: return
$82:B108 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B10B 29 00 FF    AND #$FF00             ;|
$82:B10E C9 00 05    CMP #$0500             ;} If [equipment screen item index] != screw attack:
$82:B111 F0 18       BEQ $18    [$B12B]     ;/
$82:B113 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B116 18          CLC                    ;|
$82:B117 69 00 01    ADC #$0100             ;} Increment equipment screen item index
$82:B11A 8D 55 07    STA $0755  [$7E:0755]  ;/
$82:B11D EB          XBA                    ;\
$82:B11E 29 FF 00    AND #$00FF             ;|
$82:B121 0A          ASL A                  ;} X = [equipment screen item index] * 2
$82:B122 AA          TAX                    ;/
$82:B123 20 B7 B4    JSR $B4B7  [$82:B4B7]  ; Move lower on suits/misc.
$82:B126 C9 FF FF    CMP #$FFFF             ;\
$82:B129 D0 23       BNE $23    [$B14E]     ;} If moved: return

$82:B12B A2 00 00    LDX #$0000             ;\
$82:B12E 20 11 B5    JSR $B511  [$82:B511]  ;} Move to boots
$82:B131 80 1B       BRA $1B    [$B14E]     ; Return

; BRANCH_UP
$82:B133 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B136 29 00 FF    AND #$FF00             ;} If [equipment screen item index] != varia suit:
$82:B139 F0 13       BEQ $13    [$B14E]     ;/
$82:B13B AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B13E 38          SEC                    ;|
$82:B13F E9 00 01    SBC #$0100             ;} Decrement equipment screen item index
$82:B142 8D 55 07    STA $0755  [$7E:0755]  ;/
$82:B145 EB          XBA                    ;\
$82:B146 29 FF 00    AND #$00FF             ;|
$82:B149 0A          ASL A                  ;} X = [equipment screen item index] * 2
$82:B14A AA          TAX                    ;/
$82:B14B 20 E6 B4    JSR $B4E6  [$82:B4E6]  ; Move higher on suits/misc.

$82:B14E 28          PLP
$82:B14F 60          RTS
}


;;; $B150: Equipment screen - main - boots ;;;
{
$82:B150 08          PHP
$82:B151 C2 30       REP #$30
$82:B153 20 60 B1    JSR $B160  [$82:B160]  ; Move response
$82:B156 A9 12 00    LDA #$0012             ;\
$82:B159 85 18       STA $18    [$7E:0018]  ;} $18 = 12h (boots tilemap size in bytes)
$82:B15B 20 68 B5    JSR $B568  [$82:B568]  ; Button response
$82:B15E 28          PLP
$82:B15F 60          RTS
}


;;; $B160: Equipment screen - main - boots - move response ;;;
{
$82:B160 08          PHP
$82:B161 C2 30       REP #$30
$82:B163 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B166 85 12       STA $12    [$7E:0012]  ;} $12 = [equipment screen indices]
$82:B168 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:B16A 89 00 02    BIT #$0200             ;} If not newly pressed left: go to BRANCH_LEFT_END
$82:B16D F0 22       BEQ $22    [$B191]     ;/
$82:B16F 89 00 08    BIT #$0800             ;\
$82:B172 D0 0B       BNE $0B    [$B17F]     ;} If not newly pressed up:
$82:B174 A2 08 00    LDX #$0008             ;\
$82:B177 20 89 B4    JSR $B489  [$82:B489]  ;} Move to bottom of beams
$82:B17A C9 FF FF    CMP #$FFFF             ;\
$82:B17D D0 5F       BNE $5F    [$B1DE]     ;} If moved: return

$82:B17F A2 00 00    LDX #$0000             ;\
$82:B182 20 3F B4    JSR $B43F  [$82:B43F]  ;} Move to reserve tanks
$82:B185 C9 00 00    CMP #$0000             ;\
$82:B188 D0 54       BNE $54    [$B1DE]     ;} If moved: return
$82:B18A A5 12       LDA $12    [$7E:0012]  ;\
$82:B18C 8D 55 07    STA $0755  [$7E:0755]  ;} Equipment screen indices = [$12]
$82:B18F 80 4D       BRA $4D    [$B1DE]     ; Return

; BRANCH_LEFT_END
$82:B191 89 00 04    BIT #$0400             ;\
$82:B194 D0 2D       BNE $2D    [$B1C3]     ;} If newly pressed up: go to BRANCH_UP
$82:B196 89 00 08    BIT #$0800             ;\
$82:B199 F0 43       BEQ $43    [$B1DE]     ;} If not newly pressed down: return
$82:B19B AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B19E 29 00 FF    AND #$FF00             ;} If [equipment screen item index] != hi-jump boots:
$82:B1A1 F0 18       BEQ $18    [$B1BB]     ;/
$82:B1A3 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B1A6 38          SEC                    ;|
$82:B1A7 E9 00 01    SBC #$0100             ;} Decrement equipment screen item index
$82:B1AA 8D 55 07    STA $0755  [$7E:0755]  ;/
$82:B1AD EB          XBA                    ;\
$82:B1AE 29 FF 00    AND #$00FF             ;|
$82:B1B1 0A          ASL A                  ;} X = [equipment screen item index] * 2
$82:B1B2 AA          TAX                    ;/
$82:B1B3 20 3F B5    JSR $B53F  [$82:B53F]  ; Move higher on boots
$82:B1B6 C9 FF FF    CMP #$FFFF             ;\
$82:B1B9 D0 23       BNE $23    [$B1DE]     ;} If moved: return

$82:B1BB A2 0A 00    LDX #$000A             ;\
$82:B1BE 20 E6 B4    JSR $B4E6  [$82:B4E6]  ;} Move to suits/misc.
$82:B1C1 80 1B       BRA $1B    [$B1DE]     ; Return

; BRANCH_UP
$82:B1C3 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B1C6 C9 03 02    CMP #$0203             ;} If [equipment screen item index] = speed booster: return
$82:B1C9 F0 13       BEQ $13    [$B1DE]     ;/
$82:B1CB AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B1CE 18          CLC                    ;|
$82:B1CF 69 00 01    ADC #$0100             ;} Increment equipment screen item index
$82:B1D2 8D 55 07    STA $0755  [$7E:0755]  ;/
$82:B1D5 EB          XBA                    ;\
$82:B1D6 29 FF 00    AND #$00FF             ;|
$82:B1D9 0A          ASL A                  ;} X = [equipment screen item index] * 2
$82:B1DA AA          TAX                    ;/
$82:B1DB 20 11 B5    JSR $B511  [$82:B511]  ; Move lower on boots

$82:B1DE 28          PLP
$82:B1DF 60          RTS
}


;;; $B1E0: Equipment screen - write Samus wireframe tilemap and queue transfer of BG1 to VRAM ;;;
{
$82:B1E0 08          PHP
$82:B1E1 C2 30       REP #$30
$82:B1E3 20 0C B2    JSR $B20C  [$82:B20C]  ; Write Samus wireframe tilemap
$82:B1E6 AE 30 03    LDX $0330  [$7E:0330]  ;\
$82:B1E9 A9 00 05    LDA #$0500             ;|
$82:B1EC 95 D0       STA $D0,x  [$7E:00D0]  ;|
$82:B1EE E8          INX                    ;|
$82:B1EF E8          INX                    ;|
$82:B1F0 A9 00 39    LDA #$3900             ;|
$82:B1F3 95 D0       STA $D0,x  [$7E:00D2]  ;|
$82:B1F5 E8          INX                    ;|
$82:B1F6 E8          INX                    ;|
$82:B1F7 E2 20       SEP #$20               ;} Queue transfer of [$7E:3900..3DFF] to VRAM $3080..32FF
$82:B1F9 A9 7E       LDA #$7E               ;|
$82:B1FB 95 D0       STA $D0,x  [$7E:00D4]  ;|
$82:B1FD C2 20       REP #$20               ;|
$82:B1FF E8          INX                    ;|
$82:B200 A9 80 30    LDA #$3080             ;|
$82:B203 95 D0       STA $D0,x  [$7E:00D5]  ;|
$82:B205 E8          INX                    ;|
$82:B206 E8          INX                    ;|
$82:B207 8E 30 03    STX $0330  [$7E:0330]  ;/
$82:B20A 28          PLP
$82:B20B 60          RTS
}


;;; $B20C: Equipment screen - write Samus wireframe tilemap ;;;
{
$82:B20C 08          PHP
$82:B20D C2 30       REP #$30
$82:B20F AD A2 09    LDA $09A2  [$7E:09A2]
$82:B212 29 01 01    AND #$0101
$82:B215 A2 00 00    LDX #$0000             ; X = 0

; LOOP_SUIT
$82:B218 DD 57 B2    CMP $B257,x[$82:B257]  ;\
$82:B21B F0 04       BEQ $04    [$B221]     ;} If [$B257 + [X]] != [equipped items] & 101h:
$82:B21D E8          INX                    ;\
$82:B21E E8          INX                    ;} X += 2
$82:B21F 80 F7       BRA $F7    [$B218]     ; Go to LOOP_SUIT

$82:B221 BD 5F B2    LDA $B25F,x[$82:B25F]  ;\
$82:B224 85 00       STA $00    [$7E:0000]  ;|
$82:B226 A9 82 00    LDA #$0082             ;} $00 = $82:0000 + [$B25F + [X]] (tilemap source base address)
$82:B229 85 02       STA $02    [$7E:0002]  ;/
$82:B22B A9 11 00    LDA #$0011             ;\
$82:B22E 85 14       STA $14    [$7E:0014]  ;} $14 = 11h
$82:B230 A0 00 00    LDY #$0000             ; Y = 0 (tilemap source offset)
$82:B233 A2 D8 01    LDX #$01D8             ; X = 1D8h (tilemap destination offset)

; LOOP_ROW
$82:B236 DA          PHX
$82:B237 A9 08 00    LDA #$0008             ;\
$82:B23A 85 12       STA $12    [$7E:0012]  ;|
                                            ;|
$82:B23C B7 00       LDA [$00],y[$82:D521]  ;|
$82:B23E 9F 00 38 7E STA $7E3800,x[$7E:39D8];|
$82:B242 E8          INX                    ;} Copy 10h bytes from [$00] + [Y] to $7E:3800 + [X]
$82:B243 E8          INX                    ;} Y += 10h (next source row)
$82:B244 C8          INY                    ;|
$82:B245 C8          INY                    ;|
$82:B246 C6 12       DEC $12    [$7E:0012]  ;|
$82:B248 D0 F2       BNE $F2    [$B23C]     ;/
$82:B24A FA          PLX
$82:B24B 8A          TXA                    ;\
$82:B24C 18          CLC                    ;|
$82:B24D 69 40 00    ADC #$0040             ;} X += 40h (next destination row)
$82:B250 AA          TAX                    ;/
$82:B251 C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$82:B253 D0 E1       BNE $E1    [$B236]     ; If [$14] != 0: go to LOOP_ROW
$82:B255 28          PLP
$82:B256 60          RTS

;                        _____________________ Power suit
;                       |      _______________ Hi-jump boots
;                       |     |      _________ Varia suit
;                       |     |     |      ___ Hi-jump boots + varia suit
;                       |     |     |     |
$82:B257             dw 0000, 0100, 0001, 0101
$82:B25F             dw D521, D631, D741, D851
}


;;; $B267: Equipment screen - draw item selector ;;;
{
$82:B267 08          PHP
$82:B268 C2 30       REP #$30
$82:B26A AD A8 09    LDA $09A8  [$7E:09A8]  ;\
$82:B26D 0D A4 09    ORA $09A4  [$7E:09A4]  ;|
$82:B270 0D D4 09    ORA $09D4  [$7E:09D4]  ;} If [collected beams] = 0 and [collected items] = 0 and [Samus max reserve health] = 0: return
$82:B273 F0 2B       BEQ $2B    [$B2A0]     ;/
$82:B275 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B278 29 FF 00    AND #$00FF             ;|
$82:B27B 0A          ASL A                  ;|
$82:B27C AA          TAX                    ;|
$82:B27D BD 8E C1    LDA $C18E,x[$82:C18E]  ;|
$82:B280 85 12       STA $12    [$7E:0012]  ;|
$82:B282 AD 55 07    LDA $0755  [$7E:0755]  ;|
$82:B285 EB          XBA                    ;} Y = [$C18E + [equipment screen category index] * 2] + [equipment screen item index] * 4
$82:B286 29 FF 00    AND #$00FF             ;|
$82:B289 0A          ASL A                  ;|
$82:B28A 0A          ASL A                  ;|
$82:B28B 18          CLC                    ;|
$82:B28C 65 12       ADC $12    [$7E:0012]  ;|
$82:B28E A8          TAY                    ;/
$82:B28F B9 00 00    LDA $0000,y[$82:C196]  ;\
$82:B292 AA          TAX                    ;|
$82:B293 CA          DEX                    ;|
$82:B294 C8          INY                    ;|
$82:B295 C8          INY                    ;} Draw pause screen spritemap 3 to ([[Y]] - 1, [[Y] + 2] - 1)
$82:B296 B9 00 00    LDA $0000,y[$82:C198]  ;|
$82:B299 A8          TAY                    ;|
$82:B29A A9 03 00    LDA #$0003             ;|
$82:B29D 20 81 A8    JSR $A881  [$82:A881]  ;/

$82:B2A0 28          PLP
$82:B2A1 60          RTS
}


;;; $B2A2: Equipment screen - display reserve tank amount ;;;
{
$82:B2A2 08          PHP
$82:B2A3 C2 30       REP #$30
$82:B2A5 20 AA B2    JSR $B2AA  [$82:B2AA]
$82:B2A8 28          PLP
$82:B2A9 60          RTS
}


;;; $B2AA: Equipment screen - display reserve tank amount ;;;
{
$82:B2AA 08          PHP
$82:B2AB C2 30       REP #$30
$82:B2AD 64 03       STZ $03    [$7E:0003]
$82:B2AF 20 F9 B3    JSR $B3F9  [$82:B3F9]  ; $03 = 600h (palette 3)
$82:B2B2 64 34       STZ $34    [$7E:0034]  ; $34 = 0
$82:B2B4 AD D4 09    LDA $09D4  [$7E:09D4]  ;\
$82:B2B7 D0 02       BNE $02    [$B2BB]     ;} If [Samus max reserve health] = 0:
$82:B2B9 28          PLP
$82:B2BA 60          RTS                    ; Return

$82:B2BB 8D 04 42    STA $4204  [$7E:4204]  ;\
$82:B2BE E2 20       SEP #$20               ;|
$82:B2C0 A9 64       LDA #$64               ;|
$82:B2C2 8D 06 42    STA $4206  [$7E:4206]  ;|
$82:B2C5 C2 20       REP #$20               ;|
$82:B2C7 EA          NOP                    ;|
$82:B2C8 EA          NOP                    ;|
$82:B2C9 EA          NOP                    ;} $2C = [Samus max reserve health] / 100 (number of reserve tanks)
$82:B2CA EA          NOP                    ;|
$82:B2CB EA          NOP                    ;|
$82:B2CC EA          NOP                    ;|
$82:B2CD EA          NOP                    ;|
$82:B2CE AD 14 42    LDA $4214  [$7E:4214]  ;|
$82:B2D1 85 2C       STA $2C    [$7E:002C]  ;/
$82:B2D3 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:B2D6 8D 04 42    STA $4204  [$7E:4204]  ;|
$82:B2D9 E2 20       SEP #$20               ;|
$82:B2DB A9 64       LDA #$64               ;|
$82:B2DD 8D 06 42    STA $4206  [$7E:4206]  ;|
$82:B2E0 C2 20       REP #$20               ;|
$82:B2E2 EA          NOP                    ;|
$82:B2E3 EA          NOP                    ;} $32 = [Samus reserve health] % 100 (sub-tank reserve health)
$82:B2E4 EA          NOP                    ;|
$82:B2E5 EA          NOP                    ;|
$82:B2E6 EA          NOP                    ;|
$82:B2E7 EA          NOP                    ;|
$82:B2E8 EA          NOP                    ;|
$82:B2E9 AD 16 42    LDA $4216  [$7E:4216]  ;|
$82:B2EC 85 32       STA $32    [$7E:0032]  ;/
$82:B2EE AD 14 42    LDA $4214  [$7E:4214]  ;\
$82:B2F1 85 2A       STA $2A    [$7E:002A]  ;} $2A = [Samus reserve health] / 100 (number of full reserve tanks)
$82:B2F3 85 30       STA $30    [$7E:0030]  ; $30 = [$2A]
$82:B2F5 85 2E       STA $2E    [$7E:002E]  ; $2E = [$2A]
$82:B2F7 F0 1C       BEQ $1C    [$B315]     ; If [$2A] = 0: go to BRANCH_EMPTY
$82:B2F9 A0 00 00    LDY #$0000             ; Y = 0

; LOOP_FULL_TANKS
$82:B2FC 5A          PHY                    ;\
$82:B2FD B9 D6 C1    LDA $C1D6,y[$82:C1D6]  ;|
$82:B300 AA          TAX                    ;|
$82:B301 AC E2 C1    LDY $C1E2  [$82:C1E2]  ;|
$82:B304 88          DEY                    ;} Add spritemap 1Bh from $82:C569 table to OAM at ([$C1D6 + [Y]], 5Fh)
$82:B305 A9 1B 00    LDA #$001B             ;|
$82:B308 22 1F 89 81 JSL $81891F[$81:891F]  ;|
$82:B30C 7A          PLY                    ;/
$82:B30D C8          INY                    ;\
$82:B30E C8          INY                    ;} Y += 2
$82:B30F C6 2E       DEC $2E    [$7E:002E]  ; Decrement $2E
$82:B311 D0 E9       BNE $E9    [$B2FC]     ; If [$2E] != 0: go to LOOP_FULL_TANKS
$82:B313 84 34       STY $34    [$7E:0034]  ; $34 = [Y]

; BRANCH_EMPTY
$82:B315 AD 16 42    LDA $4216  [$7E:4216]  ;\
$82:B318 F0 53       BEQ $53    [$B36D]     ;} If (sub-tank reserve health) = 0: go to BRANCH_NO_PARTIAL_TANK
$82:B31A 8D 04 42    STA $4204  [$7E:4204]  ;\
$82:B31D E2 20       SEP #$20               ;|
$82:B31F A9 0E       LDA #$0E               ;|
$82:B321 8D 06 42    STA $4206  [$7E:4206]  ;|
$82:B324 C2 20       REP #$20               ;|
$82:B326 EA          NOP                    ;|
$82:B327 EA          NOP                    ;|
$82:B328 EA          NOP                    ;} X = (sub-tank reserve health) / 14 * 2
$82:B329 EA          NOP                    ;|
$82:B32A EA          NOP                    ;|
$82:B32B EA          NOP                    ;|
$82:B32C EA          NOP                    ;|
$82:B32D AD 14 42    LDA $4214  [$7E:4214]  ;|
$82:B330 0A          ASL A                  ;|
$82:B331 AA          TAX                    ;/
$82:B332 C9 07 00    CMP #$0007             ;\
$82:B335 10 0F       BPL $0F    [$B346]     ;} If [X] < 7:
$82:B337 AD 16 42    LDA $4216  [$7E:4216]  ;\
$82:B33A F0 0A       BEQ $0A    [$B346]     ;} If (sub-tank reserve health) % 14 != 0:
$82:B33C AD B5 05    LDA $05B5  [$7E:05B5]  ;\
$82:B33F 89 04 00    BIT #$0004             ;} If [frame counter] / 4 % 2 = 0:
$82:B342 D0 02       BNE $02    [$B346]     ;/
$82:B344 E8          INX                    ;\
$82:B345 E8          INX                    ;} X += 2

$82:B346 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:B349 C9 64 00    CMP #$0064             ;} If [Samus reserve health] >= 100:
$82:B34C 30 06       BMI $06    [$B354]     ;/
$82:B34E 8A          TXA                    ;\
$82:B34F 18          CLC                    ;|
$82:B350 69 10 00    ADC #$0010             ;} X += 10h
$82:B353 AA          TAX                    ;/

$82:B354 BD D9 B3    LDA $B3D9,x[$82:B3E5]  ; A = [$B3D9 + [X]] (partial reserve tank)
$82:B357 48          PHA
$82:B358 A6 34       LDX $34    [$7E:0034]  ;\
$82:B35A BD D6 C1    LDA $C1D6,x[$82:C1D6]  ;} X = [$C1D6 + [$34]]
$82:B35D AA          TAX                    ;/
$82:B35E AC E2 C1    LDY $C1E2  [$82:C1E2]  ;\
$82:B361 88          DEY                    ;} Y = 5Fh
$82:B362 68          PLA
$82:B363 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:B367 E6 30       INC $30    [$7E:0030]  ; Increment $30
$82:B369 E6 34       INC $34    [$7E:0034]  ;\
$82:B36B E6 34       INC $34    [$7E:0034]  ;} $34 += 2

; BRANCH_NO_PARTIAL_TANK
; LOOP_EMPTY_TANKS
$82:B36D A6 34       LDX $34    [$7E:0034]
$82:B36F A5 30       LDA $30    [$7E:0030]  ;\
$82:B371 C5 2C       CMP $2C    [$7E:002C]  ;} If [$30] < [$2C]:
$82:B373 10 17       BPL $17    [$B38C]     ;/
$82:B375 BD D6 C1    LDA $C1D6,x[$82:C1D8]  ;\
$82:B378 AA          TAX                    ;} X = [$C1D6 + [$34]]
$82:B379 AC E2 C1    LDY $C1E2  [$82:C1E2]  ;\
$82:B37C 88          DEY                    ;} Y = 5Fh
$82:B37D A9 20 00    LDA #$0020             ; A = 20h
$82:B380 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:B384 E6 34       INC $34    [$7E:0034]  ;\
$82:B386 E6 34       INC $34    [$7E:0034]  ;} $34 += 2
$82:B388 E6 30       INC $30    [$7E:0030]  ; Increment $30
$82:B38A 80 E1       BRA $E1    [$B36D]     ; Go to LOOP_EMPTY_TANKS

$82:B38C A6 34       LDX $34    [$7E:0034]  ;\
$82:B38E BD D6 C1    LDA $C1D6,x[$82:C1DA]  ;} X = [$C1D6 + [$34]]
$82:B391 AA          TAX                    ;/
$82:B392 AC E2 C1    LDY $C1E2  [$82:C1E2]  ;\
$82:B395 88          DEY                    ;} Y = 5Fh
$82:B396 A9 1F 00    LDA #$001F             ; A = 1Fh (end of reserve health bar)
$82:B399 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:B39D E2 20       SEP #$20               ;\
$82:B39F A5 32       LDA $32    [$7E:0032]  ;|
$82:B3A1 8D 04 42    STA $4204  [$7E:4204]  ;|
$82:B3A4 A5 33       LDA $33    [$7E:0033]  ;|
$82:B3A6 8D 05 42    STA $4205  [$7E:4205]  ;|
$82:B3A9 A9 0A       LDA #$0A               ;|
$82:B3AB 8D 06 42    STA $4206  [$7E:4206]  ;|
$82:B3AE C2 20       REP #$20               ;|
$82:B3B0 EA          NOP                    ;|
$82:B3B1 EA          NOP                    ;} Equipment screen BG1 tilemap (Ah, Ch) = 804h + (sub-tank reserve health) % 10
$82:B3B2 EA          NOP                    ;|
$82:B3B3 EA          NOP                    ;|
$82:B3B4 EA          NOP                    ;|
$82:B3B5 EA          NOP                    ;|
$82:B3B6 EA          NOP                    ;|
$82:B3B7 AD 16 42    LDA $4216  [$7E:4216]  ;|
$82:B3BA 18          CLC                    ;|
$82:B3BB 69 04 08    ADC #$0804             ;|
$82:B3BE 8F 14 3B 7E STA $7E3B14[$7E:3B14]  ;/
$82:B3C2 AD 14 42    LDA $4214  [$7E:4214]  ;\
$82:B3C5 18          CLC                    ;|
$82:B3C6 69 04 08    ADC #$0804             ;} Equipment screen BG1 tilemap (9, Ch) = 804h + (sub-tank reserve health) / 10
$82:B3C9 8F 12 3B 7E STA $7E3B12[$7E:3B12]  ;/
$82:B3CD A5 2A       LDA $2A    [$7E:002A]  ;\
$82:B3CF 18          CLC                    ;|
$82:B3D0 69 04 08    ADC #$0804             ;} Equipment screen BG1 tilemap (8, Ch) = 804h + (number of full reserve tanks)
$82:B3D3 8F 10 3B 7E STA $7E3B10[$7E:3B10]  ;/
$82:B3D7 28          PLP
$82:B3D8 60          RTS

; Partial reserve tank spritemap IDs (for $82:C569 table)
$82:B3D9             dw 0020, 0021, 0022, 0023, 0024, 0025, 0026, 0027, ; [Samus reserve health] < 100
                        0020, 0021, 0022, 0023, 0024, 0025, 0026, 0027  ; [Samus reserve health] >= 100
}


;;; $B3F9: Equipment screen - main - display reserves - palette setup ;;;
{
; Sets $03 in preparation for a later call to $81:891F. Looks like the animation was unfinished/removed, so this always sets palette 3
$82:B3F9 08          PHP
$82:B3FA C2 30       REP #$30
$82:B3FC A9 00 06    LDA #$0600             ;\
$82:B3FF 85 03       STA $03    [$7E:0003]  ;} $03 = 600h (palette 3)
$82:B401 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:B404 F0 37       BEQ $37    [$B43D]     ;} If [Samus reserve health] = 0: return
$82:B406 CE 2F 07    DEC $072F  [$7E:072F]  ; Decrement reserve tank animation timer
$82:B409 F0 02       BEQ $02    [$B40D]     ;\
$82:B40B 10 20       BPL $20    [$B42D]     ;} If [reserve tank animation timer] > 0: go to BRANCH_POSITIVE

$82:B40D AD 43 07    LDA $0743  [$7E:0743]  ;\
$82:B410 1A          INC A                  ;} Increment reserve tank animation frame
$82:B411 8D 43 07    STA $0743  [$7E:0743]  ;/
$82:B414 0A          ASL A                  ;\
$82:B415 AA          TAX                    ;|
$82:B416 BD 65 C1    LDA $C165,x[$82:C167]  ;|
$82:B419 29 FF 00    AND #$00FF             ;} If [$C165 + [reserve tank animation frame] * 2] = FFh:
$82:B41C C9 FF 00    CMP #$00FF             ;|
$82:B41F D0 09       BNE $09    [$B42A]     ;/
$82:B421 9C 43 07    STZ $0743  [$7E:0743]  ; Reserve tank animation frame = 0
$82:B424 AD 65 C1    LDA $C165  [$82:C165]
$82:B427 29 FF 00    AND #$00FF

$82:B42A 8D 2F 07    STA $072F  [$7E:072F]  ; Reserve tank animation timer = [$C165 + [reserve tank animation frame] * 2]

; BRANCH_POSITIVE
$82:B42D AD 43 07    LDA $0743  [$7E:0743]  ;\
$82:B430 0A          ASL A                  ;|
$82:B431 1A          INC A                  ;} >_<;
$82:B432 AA          TAX                    ;/
$82:B433 A9 03 00    LDA #$0003             ;\
$82:B436 0A          ASL A                  ;|
$82:B437 AA          TAX                    ;} $03 = 600h (palette 3)
$82:B438 BD FA C0    LDA $C0FA,x[$82:C100]  ;|
$82:B43B 85 03       STA $03    [$7E:0003]  ;/

$82:B43D 28          PLP
$82:B43E 60          RTS
}


;;; $B43F: Equipment screen - move to reserve tanks ;;;
{
;; Returns:
;;     A: 1 if moved cursor, 0 otherwise
$82:B43F 08          PHP
$82:B440 C2 30       REP #$30
$82:B442 AD D4 09    LDA $09D4  [$7E:09D4]  ;\
$82:B445 F0 0D       BEQ $0D    [$B454]     ;} If [Samus max reserve health] = 0: return A = 0
$82:B447 9C 55 07    STZ $0755  [$7E:0755]  ; Equipment screen category index = tanks, item index = mode
$82:B44A A9 37 00    LDA #$0037             ;\
$82:B44D 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:B451 A9 01 00    LDA #$0001             ; Return A = 1

$82:B454 28          PLP
$82:B455 60          RTS
}


;;; $B456: Equipment screen - move lower on beams ;;;
{
;; Parameters:
;;     X: Equipment screen item index to start search from
;;     $12: Equipment screen indices
$82:B456 08          PHP
$82:B457 C2 30       REP #$30
$82:B459 AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$82:B45C D0 0F       BNE $0F    [$B46D]     ;} If hyper beam: go to BRANCH_CANCEL

; LOOP
$82:B45E AD A8 09    LDA $09A8  [$7E:09A8]  ;\
$82:B461 3C 4C C0    BIT $C04C,x[$82:C04C]  ;} If [collected beams] & [$C04C + [X]] != 0: go to BRANCH_FOUND
$82:B464 D0 0E       BNE $0E    [$B474]     ;/
$82:B466 E8          INX                    ;\
$82:B467 E8          INX                    ;} X += 2
$82:B468 E0 0A 00    CPX #$000A             ;\
$82:B46B 30 F1       BMI $F1    [$B45E]     ;} If [X] < Ah: go to LOOP

; BRANCH_CANCEL
$82:B46D A5 12       LDA $12    [$7E:0012]  ;\
$82:B46F 8D 55 07    STA $0755  [$7E:0755]  ;} Equipment screen indices = [$12]
$82:B472 80 13       BRA $13    [$B487]     ; Return

; BRANCH_FOUND
$82:B474 8A          TXA                    ;\
$82:B475 4A          LSR A                  ;|
$82:B476 EB          XBA                    ;} Equipment screen category index = weapons
$82:B477 29 00 FF    AND #$FF00             ;} Equipment screen item index = [X] / 2
$82:B47A 09 01 00    ORA #$0001             ;|
$82:B47D 8D 55 07    STA $0755  [$7E:0755]  ;/
$82:B480 A9 37 00    LDA #$0037             ;\
$82:B483 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)

$82:B487 28          PLP
$82:B488 60          RTS
}


;;; $B489: Equipment screen - move higher on beams ;;;
{
;; Parameters:
;;     X: Equipment screen item index to start search from
;; Returns:
;;     A: FFFFh if not moved cursor

$82:B489 08          PHP
$82:B48A C2 30       REP #$30
$82:B48C AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$82:B48F D0 0C       BNE $0C    [$B49D]     ;} If hyper beam: go to BRANCH_CANCEL

; LOOP
$82:B491 AD A8 09    LDA $09A8  [$7E:09A8]  ;\
$82:B494 3C 4C C0    BIT $C04C,x[$82:C04E]  ;} If [collected beams] & [$C04C + [X]] != 0: go to BRANCH_FOUND
$82:B497 D0 09       BNE $09    [$B4A2]     ;/
$82:B499 CA          DEX                    ;\
$82:B49A CA          DEX                    ;} X -= 2
$82:B49B 10 F4       BPL $F4    [$B491]     ; If [X] >= 0: go to LOOP

; BRANCH_CANCEL
$82:B49D A9 FF FF    LDA #$FFFF             ;\
$82:B4A0 80 13       BRA $13    [$B4B5]     ;} Return A = FFFFh

; BRANCH_FOUND
$82:B4A2 A9 37 00    LDA #$0037             ;\
$82:B4A5 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:B4A9 8A          TXA                    ;\
$82:B4AA 4A          LSR A                  ;|
$82:B4AB EB          XBA                    ;} Equipment screen category index = weapons
$82:B4AC 29 00 FF    AND #$FF00             ;} Equipment screen item index = [X] / 2
$82:B4AF 09 01 00    ORA #$0001             ;|
$82:B4B2 8D 55 07    STA $0755  [$7E:0755]  ;/

$82:B4B5 28          PLP
$82:B4B6 60          RTS
}


;;; $B4B7: Equipment screen - move lower on suits/misc. ;;;
{
;; Parameters:
;;     X: Equipment screen item index to start search from
;; Returns:
;;     A: 0 if moved cursor, FFFFh otherwise

; Bug: $B4C4 should be CPX #$000C. Can't access Screw Attack without Spring Ball or Boots
$82:B4B7 08          PHP
$82:B4B8 C2 30       REP #$30

; LOOP
$82:B4BA AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$82:B4BD 3C 56 C0    BIT $C056,x[$82:C056]  ;} If [collected items] & [$C056 + [X]] = 0:
$82:B4C0 D0 0C       BNE $0C    [$B4CE]     ;/
$82:B4C2 E8          INX                    ;\
$82:B4C3 E8          INX                    ;} X += 2
$82:B4C4 E0 0A 00    CPX #$000A             ;\
$82:B4C7 30 F1       BMI $F1    [$B4BA]     ;} If [X] < Ah: go to LOOP
$82:B4C9 A9 FF FF    LDA #$FFFF             ;\
$82:B4CC 80 16       BRA $16    [$B4E4]     ;} Return A = FFFFh

$82:B4CE A9 37 00    LDA #$0037             ;\
$82:B4D1 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:B4D5 8A          TXA                    ;\
$82:B4D6 4A          LSR A                  ;|
$82:B4D7 EB          XBA                    ;} Equipment screen category index = suit/misc
$82:B4D8 29 00 FF    AND #$FF00             ;} Equipment screen item index = [X] / 2
$82:B4DB 09 02 00    ORA #$0002             ;|
$82:B4DE 8D 55 07    STA $0755  [$7E:0755]  ;/
$82:B4E1 A9 00 00    LDA #$0000             ; Return A = 0

$82:B4E4 28          PLP
$82:B4E5 60          RTS
}


;;; $B4E6: Equipment screen - move higher on suits/misc. ;;;
{
;; Parameters:
;;     X: Equipment screen item index to start search from
;;     $12: Equipment screen indices
$82:B4E6 08          PHP
$82:B4E7 C2 30       REP #$30

; LOOP
$82:B4E9 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$82:B4EC 3C 56 C0    BIT $C056,x            ;} If [collected items] & [$C056 + [X]] = 0:
$82:B4EF D0 0B       BNE $0B    [$B4FC]     ;/
$82:B4F1 CA          DEX                    ;\
$82:B4F2 CA          DEX                    ;} X -= 2
$82:B4F3 10 F4       BPL $F4    [$B4E9]     ; If [X] >= 0: go to LOOP
$82:B4F5 A5 12       LDA $12    [$7E:0012]  ;\
$82:B4F7 8D 55 07    STA $0755  [$7E:0755]  ;} Equipment screen indices = [$12]
$82:B4FA 80 13       BRA $13    [$B50F]     ; Return

$82:B4FC A9 37 00    LDA #$0037             ;\
$82:B4FF 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:B503 8A          TXA                    ;\
$82:B504 4A          LSR A                  ;|
$82:B505 EB          XBA                    ;} Equipment screen category index = suit/misc
$82:B506 29 00 FF    AND #$FF00             ;} Equipment screen item index = [X] / 2
$82:B509 09 02 00    ORA #$0002             ;|
$82:B50C 8D 55 07    STA $0755  [$7E:0755]  ;/

$82:B50F 28          PLP
$82:B510 60          RTS
}


;;; $B511: Equipment screen - move lower on boots ;;;
{
;; Parameters:
;;     X: Equipment screen item index to start search from
;;     $12: Equipment screen indices
$82:B511 08          PHP
$82:B512 C2 30       REP #$30

; LOOP
$82:B514 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$82:B517 3C 62 C0    BIT $C062,x[$82:C062]  ;} If [collected items] & [$C062 + [X]] = 0:
$82:B51A D0 0E       BNE $0E    [$B52A]     ;/
$82:B51C E8          INX                    ;\
$82:B51D E8          INX                    ;} X += 2
$82:B51E E0 06 00    CPX #$0006             ;\
$82:B521 30 F1       BMI $F1    [$B514]     ;} If [X] < 6: go to LOOP
$82:B523 A5 12       LDA $12    [$7E:0012]  ;\
$82:B525 8D 55 07    STA $0755  [$7E:0755]  ;} Equipment screen indices = [$12]
$82:B528 80 13       BRA $13    [$B53D]     ; Return

$82:B52A A9 37 00    LDA #$0037             ;\
$82:B52D 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:B531 8A          TXA                    ;\
$82:B532 4A          LSR A                  ;|
$82:B533 EB          XBA                    ;} Equipment screen category index = boots
$82:B534 29 00 FF    AND #$FF00             ;} Equipment screen item index = [X] / 2
$82:B537 09 03 00    ORA #$0003             ;|
$82:B53A 8D 55 07    STA $0755  [$7E:0755]  ;/

$82:B53D 28          PLP
$82:B53E 60          RTS
}


;;; $B53F: Equipment screen - move higher on boots ;;;
{
;; Parameters:
;;     X: Equipment screen item index to start search from
;; Returns:
;;     A: FFFFh if not moved cursor

$82:B53F 08          PHP
$82:B540 C2 30       REP #$30

; LOOP
$82:B542 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$82:B545 3C 62 C0    BIT $C062,x[$82:C064]  ;} If [collected items] & [$C062 + [X]] = 0:
$82:B548 D0 09       BNE $09    [$B553]     ;/
$82:B54A CA          DEX                    ;\
$82:B54B CA          DEX                    ;} X -= 2
$82:B54C 10 F4       BPL $F4    [$B542]     ; If [X] >= 0: go to LOOP
$82:B54E A9 FF FF    LDA #$FFFF             ;\
$82:B551 80 13       BRA $13    [$B566]     ;} Return A = FFFFh

$82:B553 A9 37 00    LDA #$0037             ;\
$82:B556 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:B55A 8A          TXA                    ;\
$82:B55B 4A          LSR A                  ;|
$82:B55C EB          XBA                    ;} Equipment screen category index = boots
$82:B55D 29 00 FF    AND #$FF00             ;} Equipment screen item index = [X] / 2
$82:B560 09 03 00    ORA #$0003             ;|
$82:B563 8D 55 07    STA $0755  [$7E:0755]  ;/

$82:B566 28          PLP
$82:B567 60          RTS
}


;;; $B568: Equipment screen - main - button response ;;;
{
;; Parameters:
;;     $18: Tilemap size in bytes
$82:B568 08          PHP
$82:B569 C2 30       REP #$30
$82:B56B A5 8F       LDA $8F    [$7E:008F]  ;\
$82:B56D 89 80 00    BIT #$0080             ;} If not newly pressed A:
$82:B570 D0 02       BNE $02    [$B574]     ;/
$82:B572 28          PLP
$82:B573 60          RTS                    ; Return

$82:B574 A9 38 00    LDA #$0038             ;\
$82:B577 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$82:B57B AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B57E 29 FF 00    AND #$00FF             ;|
$82:B581 0A          ASL A                  ;} $1A = [equipment screen category index] * 2
$82:B582 AA          TAX                    ;|
$82:B583 85 1A       STA $1A    [$7E:001A]  ;/
$82:B585 AD 55 07    LDA $0755  [$7E:0755]  ;\
$82:B588 EB          XBA                    ;|
$82:B589 29 FF 00    AND #$00FF             ;} $12 = [equipment screen item index] * 2
$82:B58C 0A          ASL A                  ;|
$82:B58D 85 12       STA $12    [$7E:0012]  ;/
$82:B58F BD 2C C0    LDA $C02C,x[$82:C02E]  ;\
$82:B592 18          CLC                    ;|
$82:B593 65 12       ADC $12    [$7E:0012]  ;|
$82:B595 A8          TAY                    ;} $00 = [[$C02C + [$1A]] + [$12]] (equipment screen RAM tilemap offset)
$82:B596 B9 00 00    LDA $0000,y[$82:C06E]  ;|
$82:B599 85 00       STA $00    [$7E:0000]  ;/
$82:B59B BD 3C C0    LDA $C03C,x[$82:C03E]  ;\
$82:B59E A8          TAY                    ;} Y = [$C03C + [$1A]] (equipment bitset pointer)
$82:B59F BD 34 C0    LDA $C034,x[$82:C036]  ;\
$82:B5A2 18          CLC                    ;|
$82:B5A3 65 12       ADC $12    [$7E:0012]  ;} X = [$C034 + [$1A]] + [$12] (equipment bitmask)
$82:B5A5 AA          TAX                    ;/
$82:B5A6 B9 00 00    LDA $0000,y[$7E:09A6]  ;\
$82:B5A9 3C 00 00    BIT $0000,x[$82:C04E]  ;} If [[Y]] & [[X]] = 0 (not equipped):
$82:B5AC D0 1C       BNE $1C    [$B5CA]     ;/
$82:B5AE 1D 00 00    ORA $0000,x[$82:C04E]  ;\
$82:B5B1 99 00 00    STA $0000,y[$7E:09A6]  ;} [Y] |= [[X]] (equip)
$82:B5B4 A5 18       LDA $18    [$7E:0018]  ;\
$82:B5B6 85 16       STA $16    [$7E:0016]  ;} $16 = [$18]
$82:B5B8 A6 1A       LDX $1A    [$7E:001A]  ;\
$82:B5BA BD 44 C0    LDA $C044,x[$82:C046]  ;|
$82:B5BD 18          CLC                    ;|
$82:B5BE 65 12       ADC $12    [$7E:0012]  ;} X = [[$C044 + [$1A]] + [$12]] (pointer to equipment tilemap)
$82:B5C0 A8          TAY                    ;|
$82:B5C1 B9 00 00    LDA $0000,y[$82:C08E]  ;|
$82:B5C4 AA          TAX                    ;/
$82:B5C5 20 7E A2    JSR $A27E  [$82:A27E]  ; Copy [$16] bytes from [X] to [$00]
$82:B5C8 80 1C       BRA $1C    [$B5E6]

$82:B5CA BD 00 00    LDA $0000,x[$82:C04E]  ;\ Else ([[Y]] & [[X]] != 0):
$82:B5CD 49 FF FF    EOR #$FFFF             ;|
$82:B5D0 85 12       STA $12    [$7E:0012]  ;|
$82:B5D2 B9 00 00    LDA $0000,y[$7E:09A6]  ;} [Y] &= ~[[X]] (unequip)
$82:B5D5 25 12       AND $12    [$7E:0012]  ;|
$82:B5D7 99 00 00    STA $0000,y[$7E:09A6]  ;/
$82:B5DA A9 00 0C    LDA #$0C00             ;\
$82:B5DD 85 12       STA $12    [$7E:0012]  ;} $12 = C00h (palette 6)
$82:B5DF A5 18       LDA $18    [$7E:0018]  ;\
$82:B5E1 85 16       STA $16    [$7E:0016]  ;} $16 = [$18]
$82:B5E3 20 9D A2    JSR $A29D  [$82:A29D]  ; Set the palette of [$16] bytes of [$00] to [$12]

$82:B5E6 28          PLP
$82:B5E7 60          RTS
}
}


;;; $B5E8: Unused. Convert [A] to three decimal digits ;;;
{
;; Parameters:
;;     A: Value
;; Returns:
;;     $12: Units digit
;;     $14: Tens digit
;;     $16: Hundreds digit

; Does slow division... please avoid
$82:B5E8 08          PHP
$82:B5E9 C2 30       REP #$30
$82:B5EB 85 18       STA $18    [$7E:0018]
$82:B5ED 64 12       STZ $12    [$7E:0012]
$82:B5EF 64 14       STZ $14    [$7E:0014]
$82:B5F1 64 16       STZ $16    [$7E:0016]

$82:B5F3 A5 18       LDA $18    [$7E:0018]
$82:B5F5 38          SEC
$82:B5F6 E9 64 00    SBC #$0064
$82:B5F9 85 18       STA $18    [$7E:0018]
$82:B5FB 30 04       BMI $04    [$B601]
$82:B5FD E6 16       INC $16    [$7E:0016]
$82:B5FF 80 F2       BRA $F2    [$B5F3]

$82:B601 18          CLC
$82:B602 69 64 00    ADC #$0064
$82:B605 85 18       STA $18    [$7E:0018]

$82:B607 A5 18       LDA $18    [$7E:0018]
$82:B609 38          SEC
$82:B60A E9 0A 00    SBC #$000A
$82:B60D 85 18       STA $18    [$7E:0018]
$82:B60F 30 04       BMI $04    [$B615]
$82:B611 E6 14       INC $14    [$7E:0014]
$82:B613 80 F2       BRA $F2    [$B607]

$82:B615 18          CLC
$82:B616 69 0A 00    ADC #$000A
$82:B619 85 18       STA $18    [$7E:0018]

$82:B61B A5 18       LDA $18    [$7E:0018]
$82:B61D 38          SEC
$82:B61E E9 01 00    SBC #$0001
$82:B621 85 18       STA $18    [$7E:0018]
$82:B623 30 04       BMI $04    [$B629]
$82:B625 E6 12       INC $12    [$7E:0012]
$82:B627 80 F2       BRA $F2    [$B61B]

$82:B629 28          PLP
$82:B62A 60          RTS
}


;;; $B62B: Draw pause menu during fade in ;;;
{
$82:B62B 08          PHP
$82:B62C 8B          PHB
$82:B62D 4B          PHK                    ;\
$82:B62E AB          PLB                    ;} DB = $82
$82:B62F C2 30       REP #$30
$82:B631 AD 53 07    LDA $0753  [$7E:0753]  ; >_<;
$82:B634 AD 27 07    LDA $0727  [$7E:0727]  ;\
$82:B637 F0 09       BEQ $09    [$B642]     ;} If [menu index] != map screen:
$82:B639 20 67 B2    JSR $B267  [$82:B267]  ; Equipment screen - draw item selector
$82:B63C 20 A2 B2    JSR $B2A2  [$82:B2A2]  ; Equipment screen - display reserve tank amount
$82:B63F AB          PLB
$82:B640 28          PLP
$82:B641 6B          RTL                    ; Return

$82:B642 20 C8 B9    JSR $B9C8  [$82:B9C8]  ; Map screen - draw Samus position indicator
$82:B645 22 72 B6 82 JSL $82B672[$82:B672]  ; Draw map icons
$82:B649 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$82:B64D AB          PLB
$82:B64E 28          PLP
$82:B64F 6B          RTL
}


;;; $B650: Unused ;;;
{
; Almost clone of $B62B
$82:B650 08          PHP
$82:B651 8B          PHB
$82:B652 4B          PHK                    ;\
$82:B653 AB          PLB                    ;} DB = $82
$82:B654 C2 30       REP #$30
$82:B656 AD 53 07    LDA $0753  [$7E:0753]  ;\
$82:B659 D0 09       BNE $09    [$B664]     ;} If [pause screen button label mode] = map screen:
$82:B65B 20 67 B2    JSR $B267  [$82:B267]  ; Equipment screen - draw item selector
$82:B65E 20 A2 B2    JSR $B2A2  [$82:B2A2]  ; Equipment screen - display reserve tank amount
$82:B661 AB          PLB
$82:B662 28          PLP
$82:B663 6B          RTL                    ; Return

$82:B664 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$82:B668 20 C8 B9    JSR $B9C8  [$82:B9C8]  ; Map screen - draw Samus position indicator
$82:B66B 22 72 B6 82 JSL $82B672[$82:B672]  ; Draw map icons
$82:B66F AB          PLB
$82:B670 28          PLP
$82:B671 6B          RTL
}


;;; $B672..BA34: Map sprites ;;;
{
;;; $B672: Draw map icons ;;;
{
$82:B672 8B          PHB
$82:B673 C2 30       REP #$30
$82:B675 4B          PHK                    ;\
$82:B676 AB          PLB                    ;} DB = $82
$82:B677 A2 CB C7    LDX #$C7CB             ; X = $C7CB (boss icon data pointers)
$82:B67A A9 09 00    LDA #$0009             ; A = 9 (boss icon spritemap ID)
$82:B67D 20 92 B8    JSR $B892  [$82:B892]  ; Display map boss icons
$82:B680 A9 00 0E    LDA #$0E00             ;\
$82:B683 85 03       STA $03    [$7E:0003]  ;} $03 = E00h (palette 7)
$82:B685 A2 DB C7    LDX #$C7DB             ; X = $C7DB (missile station icon data pointers)
$82:B688 A9 0B 00    LDA #$000B             ; A = Bh (missile station spritemap ID)
$82:B68B 20 05 B8    JSR $B805  [$82:B805]  ; Draw simple map icons
$82:B68E A2 EB C7    LDX #$C7EB             ; X = $C7EB (energy station icon data pointers)
$82:B691 A9 0A 00    LDA #$000A             ; A = Ah (energy station spritemap ID)
$82:B694 20 05 B8    JSR $B805  [$82:B805]  ; Draw simple map icons
$82:B697 A2 FB C7    LDX #$C7FB             ; X = $C7FB (map station icon data pointers)
$82:B69A A9 4E 00    LDA #$004E             ; A = 4Eh (map station spritemap ID)
$82:B69D 20 05 B8    JSR $B805  [$82:B805]  ; Draw simple map icons
$82:B6A0 A9 00 04    LDA #$0400             ;\
$82:B6A3 85 03       STA $03    [$7E:0003]  ;} $03 = 400h (palette 2)
$82:B6A5 A2 0B C8    LDX #$C80B             ; X = $C80B (save icon data pointers)
$82:B6A8 A9 08 00    LDA #$0008             ; A = 8 (save icon spritemap ID)
$82:B6AB 20 98 B7    JSR $B798  [$82:B798]  ; Draw save station map icon
$82:B6AE AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$82:B6B1 F0 09       BEQ $09    [$B6BC]     ;} If debug mode enabled:
$82:B6B3 A2 2B C8    LDX #$C82B             ; X = $C82B (debug save icon data pointers)
$82:B6B6 A9 08 00    LDA #$0008             ; A = 8 (save icon spritemap ID)
$82:B6B9 20 05 B8    JSR $B805  [$82:B805]  ; Draw simple map icons

$82:B6BC AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:B6BF D0 1A       BNE $1A    [$B6DB]     ;} If [area index] = Crateria:
$82:B6C1 A9 00 0E    LDA #$0E00             ;\
$82:B6C4 85 03       STA $03    [$7E:0003]  ;} $03 = E00h (palette 7)
$82:B6C6 AD 55 C8    LDA $C855  [$82:C855]  ;\
$82:B6C9 38          SEC                    ;|
$82:B6CA E5 B3       SBC $B3    [$7E:00B3]  ;} Y = 28h - [BG1 Y scroll]
$82:B6CC A8          TAY                    ;/
$82:B6CD AD 53 C8    LDA $C853  [$82:C853]  ;\
$82:B6D0 38          SEC                    ;|
$82:B6D1 E5 B1       SBC $B1    [$7E:00B1]  ;} Y = D8h - [BG1 X scroll]
$82:B6D3 AA          TAX                    ;/
$82:B6D4 A9 63 00    LDA #$0063             ; A = 63h (gunship icon)
$82:B6D7 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM

$82:B6DB AB          PLB
$82:B6DC 6B          RTL
}


;;; $B6DD: Draw file select map icons ;;;
{
$82:B6DD 8B          PHB
$82:B6DE C2 30       REP #$30
$82:B6E0 4B          PHK                    ;\
$82:B6E1 AB          PLB                    ;} DB = $82
$82:B6E2 20 2B A9    JSR $A92B  [$82:A92B]  ; Handle pause screen palette animation
$82:B6E5 A2 CB C7    LDX #$C7CB             ; X = $C7CB (boss icon data pointers)
$82:B6E8 A9 09 00    LDA #$0009             ; A = 9 (boss icon spritemap ID)
$82:B6EB 20 92 B8    JSR $B892  [$82:B892]  ; Display map boss icons
$82:B6EE A9 00 0E    LDA #$0E00             ;\
$82:B6F1 85 03       STA $03    [$7E:0003]  ;} $03 = E00h (palette 7)
$82:B6F3 A2 DB C7    LDX #$C7DB             ; X = $C7DB (missile station icon data pointers)
$82:B6F6 A9 0B 00    LDA #$000B             ; A = Bh (missile station spritemap ID)
$82:B6F9 20 05 B8    JSR $B805  [$82:B805]  ; Draw simple map icons
$82:B6FC A2 EB C7    LDX #$C7EB             ; X = $C7EB (energy station icon data pointers)
$82:B6FF A9 0A 00    LDA #$000A             ; A = Ah (energy station spritemap ID)
$82:B702 20 05 B8    JSR $B805  [$82:B805]  ; Draw simple map icons
$82:B705 A2 FB C7    LDX #$C7FB             ; X = $C7FB (map station icon data pointers)
$82:B708 A9 4E 00    LDA #$004E             ; A = 4Eh (map station spritemap ID)
$82:B70B 20 05 B8    JSR $B805  [$82:B805]  ; Draw simple map icons
$82:B70E A9 00 0E    LDA #$0E00
$82:B711 85 03       STA $03    [$7E:0003]
$82:B713 20 FC B9    JSR $B9FC  [$82:B9FC]  ; Update Samus position indicator animation
$82:B716 48          PHA                    ; Save A (Samus position indicator spritemap ID)
$82:B717 A9 82 00    LDA #$0082             ;\
$82:B71A 85 02       STA $02    [$7E:0002]  ;|
$82:B71C AD 9F 07    LDA $079F  [$7E:079F]  ;|
$82:B71F 0A          ASL A                  ;} $00 = $82:0000 | [$C80B + [area index] * 2] (area save point icon data pointer)
$82:B720 AA          TAX                    ;|
$82:B721 BD 0B C8    LDA $C80B,x[$82:C80B]  ;|
$82:B724 85 00       STA $00    [$7E:0000]  ;/
$82:B726 AD 8B 07    LDA $078B  [$7E:078B]  ;\
$82:B729 0A          ASL A                  ;|
$82:B72A 0A          ASL A                  ;|
$82:B72B A8          TAY                    ;|
$82:B72C B7 00       LDA [$00],y[$82:C853]  ;} X = [[$00] + [load station index] * 4] - [BG1 X scroll]
$82:B72E 38          SEC                    ;|
$82:B72F E5 B1       SBC $B1    [$7E:00B1]  ;|
$82:B731 AA          TAX                    ;/
$82:B732 DA          PHX
$82:B733 C8          INY                    ;\
$82:B734 C8          INY                    ;|
$82:B735 B7 00       LDA [$00],y[$82:C855]  ;|
$82:B737 38          SEC                    ;} Y = [[$00] + [load station index] * 4 + 2] - [BG1 Y scroll]
$82:B738 E5 B3       SBC $B3    [$7E:00B3]  ;|
$82:B73A A8          TAY                    ;/
$82:B73B 5A          PHY
$82:B73C AD 7A 07    LDA $077A  [$7E:077A]  ;\
$82:B73F 89 01 00    BIT #$0001             ;} If [Samus position indicator animation loop counter] % 2 = 0:
$82:B742 D0 07       BNE $07    [$B74B]     ;/
$82:B744 A9 12 00    LDA #$0012             ; A = 12h (file select map Samus icon)
$82:B747 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM

$82:B74B 7A          PLY
$82:B74C FA          PLX
$82:B74D 68          PLA                    ; Restore A
$82:B74E 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:B752 AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$82:B755 F0 20       BEQ $20    [$B777]     ;} If debug mode enabled:
$82:B757 A9 00 06    LDA #$0600             ;\
$82:B75A 85 03       STA $03    [$7E:0003]  ;} $03 = 600h (palette 3)
$82:B75C A2 0B C8    LDX #$C80B             ; X = $C80B (save icon data pointers)
$82:B75F A9 0C 00    LDA #$000C             ; A = Ch (debug save icon spritemap ID)
$82:B762 20 D1 B7    JSR $B7D1  [$82:B7D1]  ; Draw debug save map icons
$82:B765 A2 1B C8    LDX #$C81B             ; X = $C81B (debug elevator icon data pointers)
$82:B768 A9 17 00    LDA #$0017             ; A = 17h (debug elevator icon spritemap ID)
$82:B76B 20 EB B7    JSR $B7EB  [$82:B7EB]  ; Draw debug elevator map icons
$82:B76E A2 2B C8    LDX #$C82B             ; X = $C82B (debug save icon data pointers)
$82:B771 A9 0C 00    LDA #$000C             ; A = Ch (debug save icon spritemap ID)
$82:B774 20 05 B8    JSR $B805  [$82:B805]  ; Draw simple map icons

$82:B777 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:B77A D0 1A       BNE $1A    [$B796]     ;} If [area index] = Crateria:
$82:B77C A9 00 0E    LDA #$0E00
$82:B77F 85 03       STA $03    [$7E:0003]
$82:B781 AD 55 C8    LDA $C855  [$82:C855]  ;\
$82:B784 38          SEC                    ;|
$82:B785 E5 B3       SBC $B3    [$7E:00B3]  ;} Y = 28h - [BG1 Y scroll]
$82:B787 A8          TAY                    ;/
$82:B788 AD 53 C8    LDA $C853  [$82:C853]  ;\
$82:B78B 38          SEC                    ;|
$82:B78C E5 B1       SBC $B1    [$7E:00B1]  ;} Y = D8h - [BG1 X scroll]
$82:B78E AA          TAX                    ;/
$82:B78F A9 63 00    LDA #$0063             ; A = 63h (gunship icon)
$82:B792 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM

$82:B796 AB          PLB
$82:B797 6B          RTL
}


;;; $B798: Draw save station map icon ;;;
{
;; Parameters:
;;     A: Save icon spritemap ID (always 8)
;;     X: Pointer to save icon data pointers (always $C80B)
;;     $03: Sprite palette bits
$82:B798 86 20       STX $20    [$7E:0020]  ; $20 = [X]
$82:B79A 85 22       STA $22    [$7E:0022]  ; $22 = [A]
$82:B79C AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:B79F CF 18 D9 7E CMP $7ED918[$7E:D918]  ;} If [area index] != [SRAM area index]: return
$82:B7A3 D0 23       BNE $23    [$B7C8]     ;/
$82:B7A5 0A          ASL A                  ;\
$82:B7A6 AA          TAX                    ;|
$82:B7A7 BF F8 D8 7E LDA $7ED8F8,x[$7E:D8F8];} $24 = [used area save stations]
$82:B7AB 85 24       STA $24    [$7E:0024]  ;/
$82:B7AD E2 20       SEP #$20               ;\
$82:B7AF AE 8B 07    LDX $078B  [$7E:078B]  ;|
$82:B7B2 BD C9 B7    LDA $B7C9,x[$82:B7C9]  ;|
$82:B7B5 25 24       AND $24    [$7E:0024]  ;} $24 &= 1 << [load station index]
$82:B7B7 85 24       STA $24    [$7E:0024]  ;|
$82:B7B9 C2 20       REP #$20               ;/
$82:B7BB AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:B7BE 0A          ASL A                  ;|
$82:B7BF 18          CLC                    ;|
$82:B7C0 65 20       ADC $20    [$7E:0020]  ;} A = [[X] + [area index] * 2]
$82:B7C2 AA          TAX                    ;|
$82:B7C3 BD 00 00    LDA $0000,x[$82:C80B]  ;/
$82:B7C6 D0 54       BNE $54    [$B81C]     ; If [A] != 0: go to draw map icons of given type

$82:B7C8 60          RTS

$82:B7C9             db 01, 02, 04, 08, 10, 20, 40, 80
}


;;; $B7D1: Draw debug save map icons ;;;
{
;; Parameters:
;;     A: Debug save icon spritemap ID (always Ch)
;;     X: Pointer to save icon data pointers (always $C80B)
;;     $03: Sprite palette bits
$82:B7D1 86 20       STX $20    [$7E:0020]  ; $20 = [X]
$82:B7D3 85 22       STA $22    [$7E:0022]  ; $22 = [A]
$82:B7D5 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:B7D8 0A          ASL A                  ;|
$82:B7D9 AA          TAX                    ;} $24 = [used area save stations]
$82:B7DA BF F8 D8 7E LDA $7ED8F8,x          ;|
$82:B7DE 85 24       STA $24    [$7E:0024]  ;/
$82:B7E0 8A          TXA                    ;\
$82:B7E1 18          CLC                    ;|
$82:B7E2 65 20       ADC $20    [$7E:0020]  ;} A = [[X] + [area index] * 2]
$82:B7E4 AA          TAX                    ;|
$82:B7E5 BD 00 00    LDA $0000,x            ;/
$82:B7E8 D0 32       BNE $32    [$B81C]     ; If [A] != 0: go to draw map icons of given type
$82:B7EA 60          RTS                    ; Return
}


;;; $B7EB: Draw debug elevator map icons ;;;
{
;; Parameters:
;;     A: Debug elevator icon spritemap ID (always 17h)
;;     X: Pointer to debug elevator icon data pointers (always $C81B)
;;     $03: Sprite palette bits
$82:B7EB 86 20       STX $20    [$7E:0020]  ; $20 = [X]
$82:B7ED 85 22       STA $22    [$7E:0022]  ; $22 = [A]
$82:B7EF AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:B7F2 0A          ASL A                  ;|
$82:B7F3 AA          TAX                    ;} $24 = [used area elevators]
$82:B7F4 BF F9 D8 7E LDA $7ED8F9,x          ;|
$82:B7F8 85 24       STA $24    [$7E:0024]  ;/
$82:B7FA 8A          TXA                    ;\
$82:B7FB 18          CLC                    ;|
$82:B7FC 65 20       ADC $20    [$7E:0020]  ;|
$82:B7FE AA          TAX                    ;} If [[X] + [area index] * 2] = 0:
$82:B7FF BD 00 00    LDA $0000,x            ;|
$82:B802 D0 18       BNE $18    [$B81C]     ;/
$82:B804 60          RTS                    ; Return
}


;;; $B805: Draw simple map icons ;;;
{
;; Parameters:
;;     A: Spritemap ID
;;     X: Pointer to icon data pointers
;;     $03: Sprite palette bits
$82:B805 86 20       STX $20    [$7E:0020]  ; $20 = [X]
$82:B807 85 22       STA $22    [$7E:0022]  ; $22 = [A]
$82:B809 A9 FF FF    LDA #$FFFF             ;\
$82:B80C 85 24       STA $24    [$7E:0024]  ;} $24 = FFFFh
$82:B80E AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:B811 0A          ASL A                  ;|
$82:B812 18          CLC                    ;|
$82:B813 65 20       ADC $20    [$7E:0020]  ;} If [[X] + [area index] * 2] = 0:
$82:B815 AA          TAX                    ;|
$82:B816 BD 00 00    LDA $0000,x[$82:C7DB]  ;|
$82:B819 D0 01       BNE $01    [$B81C]     ;/
$82:B81B 60          RTS                    ; Return
}


;;; $B81C: Draw map icons of given type ;;;
{
;; Parameters:
;;     A: Area icon data pointer
;;     $03: Sprite palette bits
;;     $22: Spritemap ID
;;     $24: Bitmask of icon data entries to check
$82:B81C AA          TAX                    ; X = [A]

; LOOP
$82:B81D BD 00 00    LDA $0000,x[$82:C84D]  ;\
$82:B820 89 00 80    BIT #$8000             ;} If [[X]] & 8000h != 0: return
$82:B823 D0 2F       BNE $2F    [$B854]     ;/
$82:B825 46 24       LSR $24    [$7E:0024]  ; $24 >>= 1
$82:B827 90 25       BCC $25    [$B84E]     ; If carry clear: go to BRANCH_NEXT
$82:B829 DA          PHX                    ; Save X
$82:B82A BD 02 00    LDA $0002,x[$82:C84F]  ;\
$82:B82D A8          TAY                    ;|
$82:B82E BD 00 00    LDA $0000,x[$82:C84D]  ;|
$82:B831 AA          TAX                    ;|
$82:B832 20 55 B8    JSR $B855  [$82:B855]  ;} If map position ([[X]], [[X] + 2]) is explored:
$82:B835 F0 16       BEQ $16    [$B84D]     ;|
$82:B837 FA          PLX                    ;|
$82:B838 DA          PHX                    ;/
$82:B839 BD 02 00    LDA $0002,x[$82:C84F]  ;\
$82:B83C 38          SEC                    ;|
$82:B83D E5 B3       SBC $B3    [$7E:00B3]  ;} Y = [[X] + 2] - [BG1 Y scroll]
$82:B83F A8          TAY                    ;/
$82:B840 BD 00 00    LDA $0000,x[$82:C84D]  ;\
$82:B843 38          SEC                    ;|
$82:B844 E5 B1       SBC $B1    [$7E:00B1]  ;} X = [[X]] - [BG1 X scroll]
$82:B846 AA          TAX                    ;/
$82:B847 A5 22       LDA $22    [$7E:0022]  ; A = [$22]
$82:B849 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM

$82:B84D FA          PLX                    ; Restore X

; BRANCH_NEXT
$82:B84E E8          INX                    ;\
$82:B84F E8          INX                    ;|
$82:B850 E8          INX                    ;} X += 4
$82:B851 E8          INX                    ;/
$82:B852 80 C9       BRA $C9    [$B81D]     ; Go to LOOP

$82:B854 60          RTS
}


;;; $B855: Check if map position is explored ;;;
{
;; Parameters:
;;     X: X position on map (in pixels)
;;     Y: Y position on map (in pixels)
;; Returns:
;;     Zero: Clear if map square is explored, else set
$82:B855 8A          TXA                    ;\
$82:B856 29 00 FF    AND #$FF00             ;|
$82:B859 4A          LSR A                  ;} $12 = [X] / 100h * 80h (byte index of map page)
$82:B85A 85 12       STA $12    [$7E:0012]  ;/
$82:B85C 8A          TXA                    ;\
$82:B85D 29 FF 00    AND #$00FF             ;|
$82:B860 4A          LSR A                  ;|
$82:B861 4A          LSR A                  ;|
$82:B862 4A          LSR A                  ;|
$82:B863 4A          LSR A                  ;} $12 += [X] % 100h / 40h (byte offset of map column)
$82:B864 4A          LSR A                  ;|
$82:B865 4A          LSR A                  ;|
$82:B866 18          CLC                    ;|
$82:B867 65 12       ADC $12    [$7E:0012]  ;|
$82:B869 85 12       STA $12    [$7E:0012]  ;/
$82:B86B 98          TYA                    ;\
$82:B86C 29 F8 FF    AND #$FFF8             ;|
$82:B86F 4A          LSR A                  ;|
$82:B870 18          CLC                    ;} $12 += [Y] / 8 * 4 (byte offset of map row)
$82:B871 65 12       ADC $12    [$7E:0012]  ;|
$82:B873 85 12       STA $12    [$7E:0012]  ;/
$82:B875 8A          TXA                    ;\
$82:B876 4A          LSR A                  ;|
$82:B877 4A          LSR A                  ;|
$82:B878 4A          LSR A                  ;} X = [X] / 8 % 8 (bit subindex of map column)
$82:B879 29 07 00    AND #$0007             ;|
$82:B87C AA          TAX                    ;/
$82:B87D A4 12       LDY $12    [$7E:0012]  ;\
$82:B87F E2 20       SEP #$20               ;|
$82:B881 B9 F7 07    LDA $07F7,y[$7E:0819]  ;} Clear zero if [$07F7 + [$12]] & 80h >> [X] != 0, else set zero
$82:B884 3C 8A B8    BIT $B88A,x[$82:B891]  ;|
$82:B887 C2 20       REP #$20               ;/
$82:B889 60          RTS

$82:B88A             db 80, 40, 20, 10, 08, 04, 02, 01
}


;;; $B892: Display map boss icons ;;;
{
;; Parameters:
;;     A: Boss icon spritemap ID (always 9)
;;     X: Pointer to boss icon data pointers (always $C7CB)
$82:B892 86 20       STX $20    [$7E:0020]  ; $20 = [X]
$82:B894 85 22       STA $22    [$7E:0022]  ; $22 = [A]
$82:B896 AE 9F 07    LDX $079F  [$7E:079F]  ;\
$82:B899 BF 28 D8 7E LDA $7ED828,x[$7E:D828];|
$82:B89D 29 FF 00    AND #$00FF             ;} $24 = [area boss bits]
$82:B8A0 85 24       STA $24    [$7E:0024]  ;/
$82:B8A2 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:B8A5 0A          ASL A                  ;|
$82:B8A6 18          CLC                    ;|
$82:B8A7 65 20       ADC $20    [$7E:0020]  ;} If [[X] + [area index] * 2] = 0: return
$82:B8A9 AA          TAX                    ;|
$82:B8AA BD 00 00    LDA $0000,x[$82:C7CB]  ;|
$82:B8AD F0 38       BEQ $38    [$B8E7]     ;/
$82:B8AF AA          TAX                    ; X = [[X] + [area index] * 2]

; LOOP_BOSS_ICONS
$82:B8B0 BD 00 00    LDA $0000,x[$82:C83B]  ;\
$82:B8B3 C9 FF FF    CMP #$FFFF             ;} If [[X]] = FFFFh: return
$82:B8B6 F0 2F       BEQ $2F    [$B8E7]     ;/
$82:B8B8 C9 FE FF    CMP #$FFFE             ;\
$82:B8BB F0 2B       BEQ $2B    [$B8E8]     ;} If [[X]] = FFFEh: go to BRANCH_SKIP
$82:B8BD A9 00 0E    LDA #$0E00             ;\
$82:B8C0 85 03       STA $03    [$7E:0003]  ;} $03 = E00h (palette 7)
$82:B8C2 46 24       LSR $24    [$7E:0024]  ; $24 >>= 1
$82:B8C4 B0 26       BCS $26    [$B8EC]     ; If carry set: go to BRANCH_BOSS_DEAD
$82:B8C6 AD 89 07    LDA $0789  [$7E:0789]  ;\
$82:B8C9 F0 1D       BEQ $1D    [$B8E8]     ;} If area map hasn't been collected: go to BRANCH_SKIP

; BRANCH_DRAW_BOSS_ICON
$82:B8CB DA          PHX                    ; Save X
$82:B8CC BD 02 00    LDA $0002,x[$82:C89F]  ;\
$82:B8CF 38          SEC                    ;|
$82:B8D0 E5 B3       SBC $B3    [$7E:00B3]  ;} Y = [[X] + 2] - [BG1 Y scroll]
$82:B8D2 A8          TAY                    ;/
$82:B8D3 BD 00 00    LDA $0000,x[$82:C89D]  ;\
$82:B8D6 38          SEC                    ;|
$82:B8D7 E5 B1       SBC $B1    [$7E:00B1]  ;} X = [[X]] - [BG1 X scroll]
$82:B8D9 AA          TAX                    ;/
$82:B8DA A5 22       LDA $22    [$7E:0022]  ; A = [$22] (boss icon)
$82:B8DC 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:B8E0 FA          PLX                    ; Restore X

; BRANCH_NEXT
$82:B8E1 E8          INX                    ;\
$82:B8E2 E8          INX                    ;|
$82:B8E3 E8          INX                    ;} X += 4
$82:B8E4 E8          INX                    ;/
$82:B8E5 80 C9       BRA $C9    [$B8B0]     ; Go to LOOP_BOSS_ICONS

$82:B8E7 60          RTS

; BRANCH_SKIP
$82:B8E8 46 24       LSR $24    [$7E:0024]  ; $24 >>= 1
$82:B8EA 80 F5       BRA $F5    [$B8E1]     ; Go to BRANCH_NEXT

; BRANCH_BOSS_DEAD
$82:B8EC DA          PHX                    ; Save X
$82:B8ED BD 02 00    LDA $0002,x[$82:C89F]  ;\
$82:B8F0 38          SEC                    ;|
$82:B8F1 E5 B3       SBC $B3    [$7E:00B3]  ;} Y = [[X] + 2] - [BG1 Y scroll]
$82:B8F3 A8          TAY                    ;/
$82:B8F4 BD 00 00    LDA $0000,x[$82:C89D]  ;\
$82:B8F7 38          SEC                    ;|
$82:B8F8 E5 B1       SBC $B1    [$7E:00B1]  ;} X = [[X]] - [BG1 X scroll]
$82:B8FA AA          TAX                    ;/
$82:B8FB A9 62 00    LDA #$0062             ; A = 62h (boss cross-out icon)
$82:B8FE 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:B902 FA          PLX                    ; Restore X
$82:B903 A9 00 0C    LDA #$0C00             ;\
$82:B906 85 03       STA $03    [$7E:0003]  ;} $03 = C00h (palette 6)
$82:B908 80 C1       BRA $C1    [$B8CB]     ; Go to BRANCH_DRAW_BOSS_ICON
}


;;; $B90A: Draw map scroll arrow and check to scroll in that direction ;;;
{
;; Parameters:
;;     X: Pointer to map scroll arrow data
$82:B90A DA          PHX                    ;\
$82:B90B BD 00 00    LDA $0000,x[$82:B9A0]  ;|
$82:B90E 48          PHA                    ;|
$82:B90F BD 02 00    LDA $0002,x[$82:B9A2]  ;|
$82:B912 A8          TAY                    ;|
$82:B913 BD 04 00    LDA $0004,x[$82:B9A4]  ;|
$82:B916 FA          PLX                    ;} Draw pause screen spritemap [[X] + 4] to ([[X]], [[X] + 2] - 1)
$82:B917 8B          PHB                    ;|
$82:B918 4B          PHK                    ;|
$82:B919 AB          PLB                    ;|
$82:B91A 20 81 A8    JSR $A881  [$82:A881]  ;|
$82:B91D AB          PLB                    ;|
$82:B91E FA          PLX                    ;/
$82:B91F BD 06 00    LDA $0006,x[$82:B9A6]  ;\
$82:B922 24 8B       BIT $8B    [$7E:008B]  ;} If pressing [[X] + 6]:
$82:B924 F0 0B       BEQ $0B    [$B931]     ;/
$82:B926 AD FD 05    LDA $05FD  [$7E:05FD]  ;\
$82:B929 D0 06       BNE $06    [$B931]     ;} If [map scrolling direction] = none:
$82:B92B BD 08 00    LDA $0008,x[$82:B9B2]  ;\
$82:B92E 8D FD 05    STA $05FD  [$7E:05FD]  ;} Map scrolling direction = [[X] + 8]

$82:B931 6B          RTL
}


;;; $B932: Unused. REP #$30 ;;;
{
$82:B932 C2 30       REP #$30
}


;;; $B934: Handle map scroll arrows ;;;
{
$82:B934 08          PHP
$82:B935 8B          PHB
$82:B936 E2 20       SEP #$20               ;\
$82:B938 A9 82       LDA #$82               ;|
$82:B93A 48          PHA                    ;} DB = $82
$82:B93B AB          PLB                    ;|
$82:B93C C2 20       REP #$20               ;/
$82:B93E AD AC 05    LDA $05AC  [$7E:05AC]  ;\
$82:B941 38          SEC                    ;|
$82:B942 E9 18 00    SBC #$0018             ;} If [map min X scroll] - 18h < [BG1 X scroll]:
$82:B945 C5 B1       CMP $B1    [$7E:00B1]  ;|
$82:B947 10 07       BPL $07    [$B950]     ;/
$82:B949 A2 A0 B9    LDX #$B9A0             ; X = $B9A0 (left map scroll arrow data)
$82:B94C 22 0A B9 82 JSL $82B90A[$82:B90A]  ; Draw map scroll arrow and check to scroll in that direction

$82:B950 AD AE 05    LDA $05AE  [$7E:05AE]  ;\
$82:B953 18          CLC                    ;|
$82:B954 69 18 00    ADC #$0018             ;|
$82:B957 38          SEC                    ;} If [map max X scroll] + 18h >= [BG1 X scroll] + 100h:
$82:B958 E9 00 01    SBC #$0100             ;|
$82:B95B C5 B1       CMP $B1    [$7E:00B1]  ;|
$82:B95D 30 07       BMI $07    [$B966]     ;/
$82:B95F A2 AA B9    LDX #$B9AA             ; X = $B9AA (right map scroll arrow data)
$82:B962 22 0A B9 82 JSL $82B90A[$82:B90A]  ; Draw map scroll arrow and check to scroll in that direction

$82:B966 AD B0 05    LDA $05B0  [$7E:05B0]  ;\
$82:B969 38          SEC                    ;|
$82:B96A E9 38 00    SBC #$0038             ;} If [map min Y scroll] - 38h < [BG1 Y scroll]:
$82:B96D C5 B3       CMP $B3    [$7E:00B3]  ;|
$82:B96F 10 07       BPL $07    [$B978]     ;/
$82:B971 A2 B4 B9    LDX #$B9B4             ; X = $B9B4 (up map scroll arrow data)
$82:B974 22 0A B9 82 JSL $82B90A[$82:B90A]  ; Draw map scroll arrow and check to scroll in that direction

$82:B978 AD B2 05    LDA $05B2  [$7E:05B2]  ;\
$82:B97B 38          SEC                    ;|
$82:B97C E9 B1 00    SBC #$00B1             ;} If [map max Y scroll] - B1h < [BG1 Y scroll]: go to BRANCH_CANCEL_SCROLL_DOWN
$82:B97F C5 B3       CMP $B3    [$7E:00B3]  ;|
$82:B981 30 0A       BMI $0A    [$B98D]     ;/
$82:B983 A2 BE B9    LDX #$B9BE             ; X = $B9BE (down map scroll arrow data)
$82:B986 22 0A B9 82 JSL $82B90A[$82:B90A]  ; Draw map scroll arrow and check to scroll in that direction

$82:B98A AB          PLB
$82:B98B 28          PLP
$82:B98C 6B          RTL

; BRANCH_CANCEL_SCROLL_DOWN
; I have no idea what this check is for
; As far as I can tell, [map scrolling direction] can't possibly down at this point
$82:B98D AD FD 05    LDA $05FD  [$7E:05FD]  ;\
$82:B990 CD C6 B9    CMP $B9C6  [$82:B9C6]  ;} If [map scrolling direction] != down: return
$82:B993 D0 F5       BNE $F5    [$B98A]     ;/
$82:B995 9C FB 05    STZ $05FB  [$7E:05FB]  ; $05FB = 0
$82:B998 9C FD 05    STZ $05FD  [$7E:05FD]  ; Map scrolling direction = none
$82:B99B 9C FF 05    STZ $05FF  [$7E:05FF]  ; $05FF = 0
$82:B99E 80 EA       BRA $EA    [$B98A]     ; Return

;                        _______________________ X position
;                       |     __________________ Y position
;                       |    |     _____________ Pause screen animation ID
;                       |    |    |     ________ Necessary input
;                       |    |    |    |     ___ Map scrolling direction
;                       |    |    |    |    |
$82:B9A0             dw 0010,0078,0009,0200,0001 ; Left
$82:B9AA             dw 00F0,0078,0008,0100,0002 ; Right
$82:B9B4             dw 0080,0038,0006,0800,0003 ; Up
$82:B9BE             dw 0080,00B8,0007,0400,0004 ; Down
}


;;; $B9C8: Map screen - draw Samus position indicator ;;;
{
$82:B9C8 A9 00 0E    LDA #$0E00             ;\
$82:B9CB 85 03       STA $03    [$7E:0003]  ;} Spritemap palette = 7
$82:B9CD 20 FC B9    JSR $B9FC  [$82:B9FC]  ; Update Samus position indicator animation
$82:B9D0 48          PHA                    ; Save A (Samus position indicator spritemap ID)
$82:B9D1 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$82:B9D4 EB          XBA                    ;|
$82:B9D5 29 FF 00    AND #$00FF             ;|
$82:B9D8 18          CLC                    ;|
$82:B9D9 6D A1 07    ADC $07A1  [$7E:07A1]  ;|
$82:B9DC 0A          ASL A                  ;} X = ([Samus X position] / 100h + [room X co-ordinate]) * 8 - [BG1 X scroll]
$82:B9DD 0A          ASL A                  ;|
$82:B9DE 0A          ASL A                  ;|
$82:B9DF 38          SEC                    ;|
$82:B9E0 E5 B1       SBC $B1    [$7E:00B1]  ;|
$82:B9E2 AA          TAX                    ;/
$82:B9E3 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$82:B9E6 EB          XBA                    ;|
$82:B9E7 29 FF 00    AND #$00FF             ;|
$82:B9EA 18          CLC                    ;|
$82:B9EB 6D A3 07    ADC $07A3  [$7E:07A3]  ;|
$82:B9EE 1A          INC A                  ;|
$82:B9EF 0A          ASL A                  ;} Y = ([Samus Y position] / 100h + [room Y co-ordinate] + 1) * 8 - [BG1 Y scroll]
$82:B9F0 0A          ASL A                  ;|
$82:B9F1 0A          ASL A                  ;|
$82:B9F2 38          SEC                    ;|
$82:B9F3 E5 B3       SBC $B3    [$7E:00B3]  ;|
$82:B9F5 A8          TAY                    ;/
$82:B9F6 68          PLA                    ; Restore A
$82:B9F7 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:B9FB 60          RTS
}


;;; $B9FC: Update Samus position indicator animation ;;;
{
;; Returns:
;;     A: Samus position indicator spritemap ID
$82:B9FC AD 78 07    LDA $0778  [$7E:0778]  ;\
$82:B9FF D0 19       BNE $19    [$BA1A]     ;} If [Samus position indicator animation timer] != 0: go to BRANCH_NON_ZERO
$82:BA01 AE 76 07    LDX $0776  [$7E:0776]  ;\
$82:BA04 E8          INX                    ;} X = [Samus position indicator animation frame] + 2
$82:BA05 E8          INX                    ;/
$82:BA06 E0 08 00    CPX #$0008             ;\
$82:BA09 30 06       BMI $06    [$BA11]     ;} If [X] >= 8:
$82:BA0B EE 7A 07    INC $077A  [$7E:077A]  ; Increment Samus position indicator animation loop counter
$82:BA0E A2 00 00    LDX #$0000             ; X = 0

$82:BA11 8E 76 07    STX $0776  [$7E:0776]  ; Samus position indicator animation frame = [X]
$82:BA14 BD 25 BA    LDA $BA25,x[$82:BA27]  ;\
$82:BA17 8D 78 07    STA $0778  [$7E:0778]  ;} Samus position indicator animation timer = [$BA25 + [X]]

; BRANCH_NON_ZERO
$82:BA1A 3A          DEC A                  ;\
$82:BA1B 8D 78 07    STA $0778  [$7E:0778]  ;} Decrement Samus position indicator animation timer
$82:BA1E AE 76 07    LDX $0776  [$7E:0776]  ;\
$82:BA21 BD 2D BA    LDA $BA2D,x[$82:BA2F]  ;} A = [$BA2D + [X]]
$82:BA24 60          RTS

$82:BA25             dw 0008, 0004, 0008, 0004 ; Delays
$82:BA2D             dw 005F, 0060, 0061, 0060 ; Spritemap IDs (into $82:C569 table)
}
}
}


;;; $BA35: Draw border around SAMUS DATA ;;;
{
$82:BA35 A9 00 0E    LDA #$0E00             ;\
$82:BA38 85 03       STA $03    [$7E:0003]  ;} $03 = E00h (palette 7)
$82:BA3A A2 80 00    LDX #$0080             ; X = 80h
$82:BA3D A0 10 00    LDY #$0010             ; Y = 10h
$82:BA40 A9 48 00    LDA #$0048             ; A = 48h
$82:BA43 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:BA47 6B          RTL
}


;;; $BA48: Draw border around DATA COPY MODE ;;;
{
$82:BA48 A9 00 0E    LDA #$0E00             ;\
$82:BA4B 85 03       STA $03    [$7E:0003]  ;} $03 = E00h (palette 7)
$82:BA4D A2 80 00    LDX #$0080             ; X = 80h
$82:BA50 A0 10 00    LDY #$0010             ; Y = 10h
$82:BA53 A9 49 00    LDA #$0049             ; A = 49h
$82:BA56 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:BA5A 6B          RTL
}


;;; $BA5B: Draw border around DATA CLEAR MODE ;;;
{
$82:BA5B A9 00 0E    LDA #$0E00             ;\
$82:BA5E 85 03       STA $03    [$7E:0003]  ;} $03 = E00h (palette 7)
$82:BA60 A2 7C 00    LDX #$007C             ; X = 7Ch
$82:BA63 A0 10 00    LDY #$0010             ; Y = 10h
$82:BA66 A9 4A 00    LDA #$004A             ; A = 4Ah
$82:BA69 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:BA6D 6B          RTL
}


;;; $BA6E: Draw menu selection missile ;;;
{
$82:BA6E 8B          PHB
$82:BA6F 4B          PHK                    ;\
$82:BA70 AB          PLB                    ;} DB = $82
$82:BA71 AD 8D 19    LDA $198D  [$7E:198D]  ;\
$82:BA74 F0 18       BEQ $18    [$BA8E]     ;} If [menu selection missile animation timer] != 0:
$82:BA76 3A          DEC A                  ;\
$82:BA77 8D 8D 19    STA $198D  [$7E:198D]  ;} Decrement menu selection missile animation timer
$82:BA7A D0 12       BNE $12    [$BA8E]     ; If [menu selection missile animation timer] = 0:
$82:BA7C AD 97 19    LDA $1997  [$7E:1997]  ;\
$82:BA7F 1A          INC A                  ;|
$82:BA80 29 03 00    AND #$0003             ;} Menu selection missile animation frame = ([menu selection missile animation frame] + 1) % 4
$82:BA83 8D 97 19    STA $1997  [$7E:1997]  ;/
$82:BA86 0A          ASL A                  ;\
$82:BA87 A8          TAY                    ;|
$82:BA88 B9 AA BA    LDA $BAAA,y[$82:BAAC]  ;} Menu selection missile animation timer = 8
$82:BA8B 8D 8D 19    STA $198D  [$7E:198D]  ;/

$82:BA8E A9 00 0E    LDA #$0E00             ;\
$82:BA91 85 03       STA $03    [$7E:0003]  ;} $03 = E00h (palette 7)
$82:BA93 AD 97 19    LDA $1997  [$7E:1997]  ;\
$82:BA96 0A          ASL A                  ;|
$82:BA97 A8          TAY                    ;} A = [$BAB2 + [menu selection missile animation frame] * 2]
$82:BA98 B9 B2 BA    LDA $BAB2,y[$82:BAB4]  ;/
$82:BA9B 48          PHA
$82:BA9C AD AB 19    LDA $19AB  [$7E:19AB]  ;\
$82:BA9F A8          TAY                    ;} Y = [menu selection missile Y position]
$82:BAA0 AD A1 19    LDA $19A1  [$7E:19A1]  ;\
$82:BAA3 AA          TAX                    ;} X = [menu selection missile X position]
$82:BAA4 68          PLA
$82:BAA5 AB          PLB
$82:BAA6 5C 1F 89 81 JMP $81891F[$81:891F]  ; Go to add spritemap from $82:C569 table to OAM

$82:BAAA             dw 0008, 0008, 0008, 0008
$82:BAB2             dw 0037, 0036, 0035, 0034
}


;;; $BABA: Draw file copy arrow ;;;
{
$82:BABA 8B          PHB
$82:BABB 4B          PHK                    ;\
$82:BABC AB          PLB                    ;} DB = $82
$82:BABD AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$82:BAC0 38          SEC                    ;} A = [file copy source slot] - [file copy destination slot]
$82:BAC1 ED B9 19    SBC $19B9  [$7E:19B9]  ;/
$82:BAC4 10 19       BPL $19    [$BADF]     ; If [A] >= 0: go to BRANCH_UPWARDS
$82:BAC6 49 FF FF    EOR #$FFFF             ;\
$82:BAC9 1A          INC A                  ;} Negate A
$82:BACA A2 00 00    LDX #$0000             ; X = 0
$82:BACD C9 02 00    CMP #$0002             ;\
$82:BAD0 10 23       BPL $23    [$BAF5]     ;} If [A] >= 2: go to BRANCH_SPAWN_SPRITE
$82:BAD2 A2 06 00    LDX #$0006             ; X = 6
$82:BAD5 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$82:BAD8 F0 03       BEQ $03    [$BADD]     ;} If [file copy source slot] = 0: go to BRANCH_SPAWN_SPRITE
$82:BADA A2 0C 00    LDX #$000C             ; X = Ch

$82:BADD 80 16       BRA $16    [$BAF5]     ; Go to BRANCH_SPAWN_SPRITE

; BRANCH_UPWARDS
$82:BADF A2 12 00    LDX #$0012             ; X = 12h
$82:BAE2 C9 02 00    CMP #$0002             ;\
$82:BAE5 10 0E       BPL $0E    [$BAF5]     ;} If [A] >= 2: go to BRANCH_SPAWN_SPRITE
$82:BAE7 A2 18 00    LDX #$0018             ; X = 18h
$82:BAEA AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$82:BAED C9 01 00    CMP #$0001             ;} If [file copy source slot] = 1: go to BRANCH_SPAWN_SPRITE
$82:BAF0 F0 03       BEQ $03    [$BAF5]     ;/
$82:BAF2 A2 1E 00    LDX #$001E             ; X = 1Eh

; BRANCH_SPAWN_SPRITE
$82:BAF5 A9 00 02    LDA #$0200             ;\
$82:BAF8 85 03       STA $03    [$7E:0003]  ;} $03 = 200h (palette 1)
$82:BAFA BD 0C BB    LDA $BB0C,x            ; A = [$BB0C + [X]]
$82:BAFD 48          PHA
$82:BAFE BD 10 BB    LDA $BB10,x            ;\
$82:BB01 A8          TAY                    ;} Y = [$BB0C + [X] + 4]
$82:BB02 BD 0E BB    LDA $BB0E,x            ;\
$82:BB05 AA          TAX                    ;} X = [$BB0C + [X] + 2]
$82:BB06 68          PLA
$82:BB07 AB          PLB
$82:BB08 5C 1F 89 81 JML $81891F[$81:891F]  ; Go to add spritemap from $82:C569 table to OAM

;                        _____________ Spritemap index
;                       |     ________ X position
;                       |    |     ___ Y position
;                       |    |    |
$82:BB0C             dw 0042,0014,0068, ; 0:   A ------> C
                        0040,0014,0058, ; 6:   A -> B
                        0040,0014,0078, ; Ch:       B -> C
                        0043,0014,0068, ; 12h: A <------ C
                        0041,0014,0058, ; 18h: A <- B
                        0041,0014,0078  ; 1Eh:      B <- C
}


;;; $BB30: Display map elevator destinations ;;;
{
$82:BB30 C2 30       REP #$30
$82:BB32 8B          PHB
$82:BB33 4B          PHK                    ;\
$82:BB34 AB          PLB                    ;} DB = $82
$82:BB35 A9 00 00    LDA #$0000             ;\
$82:BB38 85 03       STA $03    [$7E:0003]  ;} $03 = 0 (sprite palette bits)
$82:BB3A AE 9F 07    LDX $079F  [$7E:079F]  ;\
$82:BB3D BF 08 D9 7E LDA $7ED908,x[$7E:D908];|
$82:BB41 29 FF 00    AND #$00FF             ;} If not obtained current area map: return
$82:BB44 F0 2D       BEQ $2D    [$BB73]     ;/
$82:BB46 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:BB49 0A          ASL A                  ;|
$82:BB4A AA          TAX                    ;} X = [$C74D + [area index] * 2]
$82:BB4B BD 4D C7    LDA $C74D,x[$82:C74D]  ;|
$82:BB4E AA          TAX                    ;/

; LOOP
$82:BB4F BD 00 00    LDA $0000,x[$82:C759]  ;\
$82:BB52 C9 FF FF    CMP #$FFFF             ;} If [[X]] = FFFFh: return
$82:BB55 F0 1C       BEQ $1C    [$BB73]     ;/
$82:BB57 DA          PHX                    ;\
$82:BB58 38          SEC                    ;|
$82:BB59 E5 B1       SBC $B1    [$7E:00B1]  ;|
$82:BB5B 48          PHA                    ;|
$82:BB5C BD 02 00    LDA $0002,x[$82:C75B]  ;|
$82:BB5F 38          SEC                    ;} Add spritemap [[X] + 4] from $82:C569 table to OAM at position ([[X]] - [BG1 X scroll], [[X] + 2] - [BG1 Y scroll])
$82:BB60 E5 B3       SBC $B3    [$7E:00B3]  ;|
$82:BB62 A8          TAY                    ;|
$82:BB63 BD 04 00    LDA $0004,x[$82:C75D]  ;|
$82:BB66 FA          PLX                    ;|
$82:BB67 22 1F 89 81 JSL $81891F[$81:891F]  ;/
$82:BB6B 68          PLA                    ;\
$82:BB6C 18          CLC                    ;|
$82:BB6D 69 06 00    ADC #$0006             ;} X += 6
$82:BB70 AA          TAX                    ;/
$82:BB71 80 DC       BRA $DC    [$BB4F]     ; Go to LOOP

$82:BB73 AB          PLB
$82:BB74 6B          RTL
}


;;; $BB75..BE16: Game over baby metroid ;;;
{
;;; $BB75: Handle game over baby metroid ;;;
{
$82:BB75 8B          PHB
$82:BB76 C2 30       REP #$30
$82:BB78 4B          PHK                    ;\
$82:BB79 AB          PLB                    ;} DB = $82
$82:BB7A AD 94 0F    LDA $0F94  [$7E:0F94]  ;\
$82:BB7D F0 5E       BEQ $5E    [$BBDD]     ;} If [enemy 0 instruction timer] = 0: go to restart game over baby metroid instruction list
}


;;; $BB7F: Process game over baby metroid instruction list ;;;
{
$82:BB7F AE 92 0F    LDX $0F92  [$7E:0F92]  ; X = [enemy 0 instruction list pointer]
$82:BB82 3A          DEC A                  ;\
$82:BB83 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Decrement enemy 0 instruction timer
$82:BB86 D0 16       BNE $16    [$BB9E]     ; If [enemy 0 instruction timer] = 0:
$82:BB88 BD 06 00    LDA $0006,x[$82:BC2D]  ;\
$82:BB8B C9 FF FF    CMP #$FFFF             ;} If [[X] + 6] = FFFFh: go to restart game over baby metroid instruction list
$82:BB8E F0 4D       BEQ $4D    [$BBDD]     ;/
$82:BB90 30 59       BMI $59    [$BBEB]     ; If [[X] + 6] & 8000h != 0: go to [[X] + 6]
$82:BB92 8D 94 0F    STA $0F94  [$7E:0F94]  ; Enemy 0 instruction timer = [[X] + 6]
$82:BB95 8A          TXA                    ;\
$82:BB96 18          CLC                    ;|
$82:BB97 69 06 00    ADC #$0006             ;} Enemy 0 instruction list pointer = [X] + 6
$82:BB9A 8D 92 0F    STA $0F92  [$7E:0F92]  ;/
$82:BB9D AA          TAX                    ; X = [enemy 0 instruction list pointer]
}


;;; $BB9E: Draw game over baby metroid ;;;
{
$82:BB9E DA          PHX                    ;\
$82:BB9F BD 04 00    LDA $0004,x[$82:BC2B]  ;|
$82:BBA2 A8          TAY                    ;|
$82:BBA3 A2 00 00    LDX #$0000             ;|
                                            ;|
$82:BBA6 B9 00 00    LDA $0000,y[$82:BD97]  ;|
$82:BBA9 9F 80 C1 7E STA $7EC180,x[$7E:C180];|
$82:BBAD C8          INY                    ;} Sprite palette 4 = 20h bytes from [[X] + 4]
$82:BBAE C8          INY                    ;|
$82:BBAF E8          INX                    ;|
$82:BBB0 E8          INX                    ;|
$82:BBB1 E0 20 00    CPX #$0020             ;|
$82:BBB4 30 F0       BMI $F0    [$BBA6]     ;|
$82:BBB6 FA          PLX                    ;/
$82:BBB7 A9 00 08    LDA #$0800             ;\
$82:BBBA 85 03       STA $03    [$7E:0003]  ;} $03 = 800h (palette 4)
$82:BBBC BD 02 00    LDA $0002,x[$82:BC29]  ; A = [[X] + 2]
$82:BBBF A2 7C 00    LDX #$007C             ; X = 7Ch
$82:BBC2 A0 50 00    LDY #$0050             ; Y = 50h
$82:BBC5 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:BBC9 A9 00 0A    LDA #$0A00             ;\
$82:BBCC 85 03       STA $03    [$7E:0003]  ;} $03 = A00h (palette 5)
$82:BBCE A9 64 00    LDA #$0064             ; A = 64h (baby metroid container)
$82:BBD1 A2 7C 00    LDX #$007C             ; X = 7Ch
$82:BBD4 A0 50 00    LDY #$0050             ; Y = 50h
$82:BBD7 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$82:BBDB AB          PLB
$82:BBDC 6B          RTL
}


;;; $BBDD: Restart game over baby metroid instruction list ;;;
{
$82:BBDD A9 27 BC    LDA #$BC27             ;\
$82:BBE0 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Enemy 0 instruction list pointer = $BC27
$82:BBE3 A9 0A 00    LDA #$000A             ;\
$82:BBE6 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Enemy 0 instruction timer = Ah
$82:BBE9 80 94       BRA $94    [$BB7F]     ; Go to process game over baby metroid instruction list
}


;;; $BBEB: Go to [A] ;;;
{
$82:BBEB 85 12       STA $12    [$7E:0012]
$82:BBED 6C 12 00    JMP ($0012)
}


;;; $BBF0: Finish processing game over baby metroid ASM instruction ;;;
{
; Like $BB7F, but accounting for the two byte ASM instruction pointer
$82:BBF0 AE 92 0F    LDX $0F92  [$7E:0F92]  ; X = [enemy 0 instruction list pointer]
$82:BBF3 BD 08 00    LDA $0008,x            ;\
$82:BBF6 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Enemy 0 instruction timer = [[X] + 8]
$82:BBF9 8A          TXA                    ;\
$82:BBFA 18          CLC                    ;|
$82:BBFB 69 08 00    ADC #$0008             ;} Enemy 0 instruction list pointer = [X] + 8
$82:BBFE 8D 92 0F    STA $0F92  [$7E:0F92]  ;/
$82:BC01 AA          TAX                    ; X = [enemy 0 instruction list pointer]
$82:BC02 BD 00 00    LDA $0000,x            ;\
$82:BC05 C9 FF FF    CMP #$FFFF             ;} If [[X]] = FFFFh: go to $BBDD
$82:BC08 F0 D3       BEQ $D3    [$BBDD]     ;/
$82:BC0A 80 92       BRA $92    [$BB9E]     ; Go to draw game over baby metroid
}


;;; $BC0C: Instruction - queue baby metroid cry 1 sound effect ;;;
{
$82:BC0C A9 23 00    LDA #$0023             ;\
$82:BC0F 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 23h, sound library 3, max queued sounds allowed = 6 (baby metroid cry 1)
$82:BC13 80 DB       BRA $DB    [$BBF0]     ; Go to finish processing game over baby metroid ASM instruction
}


;;; $BC15: Instruction - queue baby metroid cry 2 sound effect ;;;
{
$82:BC15 A9 26 00    LDA #$0026             ;\
$82:BC18 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 26h, sound library 3, max queued sounds allowed = 6 (baby metroid cry 2)
$82:BC1C 80 D2       BRA $D2    [$BBF0]     ; Go to finish processing game over baby metroid ASM instruction
}


;;; $BC1E: Instruction - queue baby metroid cry 3 sound effect ;;;
{
$82:BC1E A9 27 00    LDA #$0027             ;\
$82:BC21 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 27h, sound library 3, max queued sounds allowed = 6 (baby metroid cry 3)
$82:BC25 80 C9       BRA $C9    [$BBF0]     ; Go to finish processing game over baby metroid ASM instruction
}


;;; $BC27: Game over baby metroid instruction list ;;;
{
; Positive instruction format: <timer> <spritemap index for $82:C569 table> <palette pointer>
$82:BC27             dw 000A,0065,BD97,
                        000A,0066,BD97,
                        000A,0067,BD97,
                        000A,0066,BD97,
                        000A,0065,BD97,
                        000A,0066,BD97,
                        000A,0067,BD97,
                        000A,0066,BD97,
                        0006,0065,BDB7,
                        BC0C,           ; Queue baby metroid cry 1 sound effect
                        0005,0066,BDD7,
                        0004,0067,BDF7,
                        0003,0066,BDD7,
                        0002,0065,BDB7,
                        0003,0066,BDD7,
                        0004,0067,BDF7,
                        0005,0066,BDD7,
                        000A,0065,BD97,
                        000A,0066,BD97,
                        000A,0067,BD97,
                        000A,0066,BD97,
                        000A,0065,BD97,
                        000A,0066,BD97,
                        000A,0067,BD97,
                        000A,0066,BD97,
                        000A,0065,BD97,
                        000A,0066,BD97,
                        000A,0067,BD97,
                        000A,0066,BD97,
                        000A,0065,BD97,
                        000A,0066,BD97,
                        000A,0067,BD97,
                        000A,0066,BD97,
                        0006,0065,BDB7,
                        BC15,           ; Queue baby metroid cry 2 sound effect
                        0005,0066,BDD7,
                        0004,0067,BDF7,
                        0003,0066,BDD7,
                        0002,0065,BDB7,
                        0003,0066,BDD7,
                        0004,0067,BDF7,
                        0005,0066,BDD7,
                        000A,0065,BD97,
                        000A,0066,BD97,
                        000A,0067,BD97,
                        000A,0066,BD97,
                        000A,0065,BD97,
                        000A,0066,BD97,
                        000A,0067,BD97,
                        000A,0066,BD97,
                        000A,0065,BD97,
                        000A,0066,BD97,
                        000A,0067,BD97,
                        000A,0066,BD97,
                        0006,0065,BDB7,
                        BC1E,           ; Queue baby metroid cry 3 sound effect
                        0005,0066,BDD7,
                        0004,0067,BDF7,
                        0003,0066,BDD7,
                        0002,0065,BDB7,
                        0003,0066,BDD7,
                        0004,0067,BDF7,
                        0005,0066,BDD7,
                        FFFF
}


;;; $BD97: Game over baby metroid palettes ;;;
{
$82:BD97             dw 3800,7F50,2E40,2DA0,2D00,725A,2C3A,240F,1C05,1800,639A,52D3,420D,7F66,7FFA,7240
$82:BDB7             dw 3800,6BF5,06E1,0641,05A1,5E5F,183F,1014,080A,0404,4F9F,3ED8,2E12,6F70,7FFF,5EE0
$82:BDD7             dw 3800,77F8,1344,12A4,1204,6ABF,249F,1C77,146D,1067,5BFF,4B38,3A72,7BD3,7FFF,6B43
$82:BDF7             dw 3800,7FFB,1FA7,1F07,1E67,771F,30FF,28DA,20D0,1CCA,67FF,579B,46D5,7BD6,7FFF,77A6
}
}


;;; $BE17: Cancel sound effects ;;;
{
$82:BE17 C2 30       REP #$30
$82:BE19 A9 02 00    LDA #$0002             ;\
$82:BE1C 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 6 (silence)
$82:BE20 A9 71 00    LDA #$0071             ;\
$82:BE23 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 6 (silence)
$82:BE27 A9 01 00    LDA #$0001             ;\
$82:BE2A 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1, sound library 3, max queued sounds allowed = 6 (silence)
$82:BE2E 6B          RTL
}


;;; $BE2F: Queue Samus movement sound effects ;;;
{
; Called by message boxes and unpausing
$82:BE2F C2 30       REP #$30
$82:BE31 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$82:BE34 29 00 FF    AND #$FF00             ;|
$82:BE37 C9 00 04    CMP #$0400             ;} If Samus is speed boosting:
$82:BE3A D0 07       BNE $07    [$BE43]     ;/
$82:BE3C A9 2B 00    LDA #$002B             ;\
$82:BE3F 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2Bh, sound library 3, max queued sounds allowed = 6 (resume speed booster)

$82:BE43 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$82:BE46 C9 10 00    CMP #$0010             ;} If Samus beam is charging:
$82:BE49 30 07       BMI $07    [$BE52]     ;/
$82:BE4B A9 41 00    LDA #$0041             ;\
$82:BE4E 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 41h, sound library 1, max queued sounds allowed = 6 (resume charging beam)

$82:BE52 A9 14 00    LDA #$0014             ;\
$82:BE55 22 84 F0 90 JSL $90F084[$90:F084]  ;} Queue low health, grapple and jump sound effects
$82:BE59 6B          RTL
}


;;; $BE5A: Unused ;;;
{
; So... this routine does some stuff and then crashes?
$82:BE5A C2 30       REP #$30
$82:BE5C AD 9F 07    LDA $079F  [$7E:079F]
$82:BE5F 85 12       STA $12    [$7E:0012]
$82:BE61 0A          ASL A
$82:BE62 18          CLC
$82:BE63 65 12       ADC $12    [$7E:0012]
$82:BE65 AA          TAX
$82:BE66 BD 4A 96    LDA $964A,x
$82:BE69 85 00       STA $00    [$7E:0000]
$82:BE6B BD 4C 96    LDA $964C,x
$82:BE6E 85 02       STA $02    [$7E:0002]
$82:BE70 A0 00 00    LDY #$0000

$82:BE73 64 12       STZ $12    [$7E:0012]

$82:BE75 B7 00       LDA [$00],y
$82:BE77 29 FF 03    AND #$03FF
$82:BE7A C9 1F 00    CMP #$001F
$82:BE7D F0 03       BEQ $03    [$BE82]
$82:BE7F 38          SEC
$82:BE80 80 01       BRA $01    [$BE83]

$82:BE82 18          CLC

$82:BE83 26 12       ROL $12    [$7E:0012]
$82:BE85 C8          INY
$82:BE86 C8          INY
$82:BE87 98          TYA
$82:BE88 29 0F 00    AND #$000F
$82:BE8B D0 E8       BNE $E8    [$BE75]
$82:BE8D C0 00 10    CPY #$1000

$82:BE90 10 FE       BPL $FE    [$BE90]
$82:BE92 98          TYA                    ;\
$82:BE93 4A          LSR A                  ;|
$82:BE94 4A          LSR A                  ;|
$82:BE95 4A          LSR A                  ;|
$82:BE96 4A          LSR A                  ;|
$82:BE97 AA          TAX                    ;} Dead code
$82:BE98 E2 20       SEP #$20               ;|
$82:BE9A A5 12       LDA $12    [$7E:0012]  ;|
$82:BE9C 9D F6 07    STA $07F6,x            ;|
$82:BE9F C2 20       REP #$20               ;|
$82:BEA1 80 D0       BRA $D0    [$BE73]     ;/
}


;;; $BEA3: Unused ;;;
{
; So... this routine does some stuff and then crashes as well? Great!
$82:BEA3 C2 30       REP #$30
$82:BEA5 A2 00 06    LDX #$0600
$82:BEA8 A9 00 00    LDA #$0000

$82:BEAB 9F 00 30 7E STA $7E3000,x
$82:BEAF 9F 00 40 7E STA $7E4000,x
$82:BEB3 CA          DEX
$82:BEB4 CA          DEX
$82:BEB5 10 F4       BPL $F4    [$BEAB]
$82:BEB7 8F 00 40 7E STA $7E4000[$7E:4000]
$82:BEBB 8F 02 40 7E STA $7E4002[$7E:4002]
$82:BEBF 8F 04 40 7E STA $7E4004[$7E:4004]
$82:BEC3 9C 9F 07    STZ $079F  [$7E:079F]

$82:BEC6 C2 20       REP #$20
$82:BEC8 AD 9F 07    LDA $079F  [$7E:079F]
$82:BECB EB          XBA
$82:BECC A8          TAY
$82:BECD AA          TAX
$82:BECE E2 20       SEP #$20
$82:BED0 A9 FF       LDA #$FF
$82:BED2 85 12       STA $12    [$7E:0012]

$82:BED4 B9 04 BF    LDA $BF04,y
$82:BED7 F0 14       BEQ $14    [$BEED]
$82:BED9 98          TYA
$82:BEDA 9F 00 30 7E STA $7E3000,x
$82:BEDE E8          INX
$82:BEDF DA          PHX
$82:BEE0 AE 9F 07    LDX $079F  [$7E:079F]
$82:BEE3 BF 00 40 7E LDA $7E4000,x
$82:BEE7 1A          INC A
$82:BEE8 9F 00 40 7E STA $7E4000,x
$82:BEEC FA          PLX

$82:BEED C8          INY
$82:BEEE A5 12       LDA $12    [$7E:0012]
$82:BEF0 3A          DEC A
$82:BEF1 85 12       STA $12    [$7E:0012]
$82:BEF3 C9 FF       CMP #$FF
$82:BEF5 D0 DD       BNE $DD    [$BED4]
$82:BEF7 AD 9F 07    LDA $079F  [$7E:079F]
$82:BEFA 1A          INC A
$82:BEFB 8D 9F 07    STA $079F  [$7E:079F]
$82:BEFE C9 07       CMP #$07
$82:BF00 30 C4       BMI $C4    [$BEC6]

$82:BF02 80 FE       BRA $FE    [$BF02]
}


;;; $BF04: Reserve tank transfer energy per frame ;;;
{
$82:BF04             dw 0001
}


;;; $BF06: Equipment screen tilemaps ;;;
{
; MODE[MANUAL]
$82:BF06             dw 2519, 251A, 251B, 3D46, 3D47, 3D48, 3D49

; RESERVE TANK
$82:BF14             dw 3C80, 3C81, 3C82, 3C83, 3C84, 3C85, 3C86

; [MANUAL]
$82:BF22             dw 3D46, 3D47, 3D48, 3D49

; [ AUTO ]
$82:BF2A             dw 3D56, 3D57, 3D58, 3D59

; oCHARGE
$82:BF32             dw 08FF, 08D8, 08D9, 08DA, 08E7

; oICE
$82:BF3C             dw 08FF, 08DB, 08DC, 08D4, 08D4

; oWAVE
$82:BF46             dw 08FF, 08DD, 08DE, 08DF, 08D4

; oSPAZER
$82:BF50             dw 08FF, 08E8, 08E9, 08EA, 08EB

; oPLASMA
$82:BF5A             dw 08FF, 08EC, 08ED, 08EE, 08EF

; oVARIA SUIT
$82:BF64             dw 08FF, 0900, 0901, 0902, 0903, 0904, 0905, 08D4, 08D4

; oGRAVITY SUIT
$82:BF76             dw 08FF, 08D0, 08D1, 08D2, 08D3, 0903, 0904, 0905, 08D4

; oMORPHING BALL
$82:BF88             dw 08FF, 0920, 0921, 0922, 0923, 0917, 0918, 090F, 091F

; oBOMBS
$82:BF9A             dw 08FF, 08D5, 08D6, 08D7, 08D4, 08D4, 08D4, 08D4, 08D4

; oSPRING BALL
$82:BFAC             dw 08FF, 0910, 0911, 0912, 0913, 0914, 0915, 0916, 08D4

; Unused
$82:BFBE             dw 0000

; oSCREW ATTACK
$82:BFC0             dw 08FF, 08E0, 08E1, 08E2, 08E3, 08E4, 08E5, 08E6, 08D4

; oHI-JUMP BOOTS
$82:BFD2             dw 08FF, 0930, 0931, 0932, 0933, 0934, 0935, 0936, 08D4

; oSPACE JUMP
$82:BFE4             dw 08FF, 08F0, 08F1, 08F2, 08F3, 08F4, 08F5, 08D4, 08D4

; oSPEED BOOSTER
$82:BFF6             dw 08FF, 0924, 0925, 0926, 0927, 0928, 0929, 092A, 092B

; oHYPER
$82:C008             dw 08FF, 0937, 0938, 0939, 092F, 08D4, 08D4, 08D4, 08D4

; Blank placeholder
$82:C01A             dw 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $C02C: Equipment screen data ;;;
{
; These pointers aren't always used, they're hardcoded in various places e.g. $82:A12B

;                        _____________________ Tanks
;                       |      _______________ Weapons
;                       |     |      _________ Suit/misc
;                       |     |     |      ___ Boots
;                       |     |     |     |
$82:C02C             dw C068, C06C, C076, C082 ; Pointers to lists of RAM tilemap offsets
$82:C034             dw 0000, C04C, C056, C062 ; Pointers to lists of equipment bitmasks
$82:C03C             dw 0000, 09A6, 09A2, 09A2 ; Pointers to equipment bitsets
$82:C044             dw 0000, C08C, C096, C0A2 ; Pointers to lists of pointers to equipment tilemaps

; Equipment bitmasks
$82:C04C             dw 1000, ; Weapons - charge
                        0002, ; Weapons - ice
                        0001, ; Weapons - wave
                        0004, ; Weapons - spazer
                        0008  ; Weapons - plasma
$82:C056             dw 0001, ; Suit/misc - varia suit
                        0020, ; Suit/misc - gravity suit
                        0004, ; Suit/misc - morph ball
                        1000, ; Suit/misc - bombs
                        0002, ; Suit/misc - spring ball
                        0008  ; Suit/misc - screw attack
$82:C062             dw 0100, ; Boots - hi-jump boots
                        0200, ; Boots - space jump
                        2000  ; Boots - speed booster

; RAM tilemap offsets
$82:C068             dw 3A88, ; Tanks - mode
                        3AC8  ; Tanks - reserve tank
$82:C06C             dw 3C08, ; Weapons - charge
                        3C48, ; Weapons - ice
                        3C88, ; Weapons - wave
                        3CC8, ; Weapons - spazer
                        3D08  ; Weapons - plasma
$82:C076             dw 3A6A, ; Suit/misc - varia suit
                        3AAA, ; Suit/misc - gravity suit
                        3B6A, ; Suit/misc - morph ball
                        3BAA, ; Suit/misc - bombs
                        3BEA, ; Suit/misc - spring ball
                        3C2A  ; Suit/misc - screw attack
$82:C082             dw 3CEA, ; Boots - hi-jump boots
                        3D2A, ; Boots - space jump
                        3D6A  ; Boots - speed booster

; Pointers to equipment tilemaps
$82:C088             dw BF06, ; Tanks - mode
                        BF14  ; Tanks - reserve tank
$82:C08C             dw BF32, ; Weapons - charge
                        BF3C, ; Weapons - ice
                        BF46, ; Weapons - wave
                        BF50, ; Weapons - spazer
                        BF5A  ; Weapons - plasma
$82:C096             dw BF64, ; Suit/misc - varia suit
                        BF76, ; Suit/misc - gravity suit
                        BF88, ; Suit/misc - morph ball
                        BF9A, ; Suit/misc - bombs
                        BFAC, ; Suit/misc - spring ball
                        BFC0  ; Suit/misc - screw attack
$82:C0A2             dw BFD2, ; Boots - hi-jump boots
                        BFE4, ; Boots - space jump
                        BFF6  ; Boots - speed booster

; Hyper beam weapons tilemaps
$82:C0A8             dw C01A, ; Blank
                        C01A, ; Blank
                        C008, ; Hyper beam
                        C01A, ; Blank
                        C01A  ; Blank
}


;;; $C0B2: Pause screen sprite animation data ;;;
{
;                        ___________________________________________________ 1: Unused (used for start / L/R button pressed highlight elsewhere)
;                       |      _____________________________________________ 2: L/R highlight
;                       |     |      _______________________________________ 3: Item selector
;                       |     |     |      _________________________________ 4: Unused (used for reserve tank animation elsewhere)
;                       |     |     |     |      ___________________________ 5: Unused
;                       |     |     |     |     |      _____________________ 6: Map scroll arrow - up
;                       |     |     |     |     |     |      _______________ 7: Map scroll arrow - down
;                       |     |     |     |     |     |     |      _________ 8: Map scroll arrow - right
;                       |     |     |     |     |     |     |     |      ___ 9: Map scroll arrow - left
;                       |     |     |     |     |     |     |     |     |
$82:C0B2             dw 0729, 072B, 072D, 072F, 0731, 0733, 0735, 0737, 0739 ; Pointers to use for animation timer
$82:C0C4             dw 073D, 073F, 0741, 0743, 0745, 0747, 0749, 074B, 074D ; Pointers to use for animation frame, indexes animation data
$82:C0D6             dw 0751, 0753, 0755, 0757, 0759, 075B, 075D, 075F, 0761 ; Pointers to use for animation mode, indexes [$C1E4 + (animation ID) * 2]
$82:C0E8             dw C10A, C10C, C137, C162, C137, C137, C137, C137, C137 ; Pointers to animation data

; Sprite palette index values
$82:C0FA             dw 0000, 0200, 0400, 0600, 0800, 0A00, 0C00, 0E00

; Duration of L/R button pressed highlight
$82:C10A             dw 0005

; FF = loop to start, else timer (1 byte), unknown (1 byte), spritemap ID (1 byte)
; L/R highlight animation data / pause screen palette animation delays
$82:C10C             db 0F,00,00, 03,01,00, 03,02,00, 03,03,00, 03,04,00, 03,05,00, 03,06,00, 03,07,00, 03,06,00, 03,05,00, 03,04,00, 03,03,00, 03,02,00, 03,01,00, FF

; Item selector and map scroll arrows
$82:C137             db 0F,00,00, 02,01,00, 02,02,00, 02,03,00, 02,04,00, 02,05,00, 02,06,00, 02,07,00, 02,06,00, 02,05,00, 02,04,00, 02,03,00, 02,02,00, 02,01,00, FF

; Unused (animation 4)
$82:C162             db 02,07, FF

; Reserve tank animation data
; FF = loop to start, else timer (1 byte), unknown (1 byte)
$82:C165             db 0F,00, 02,01, 02,02, 02,03, 02,04, 02,05, 02,06, 02,07, 02,06, 02,05, 02,04, 02,03, 02,02, 02,01, FF

; L/R button pressed highlight table
;                        ________ L button
;                       |     ___ R button
;                       |    |
$82:C182             dw 0028,0029 ; Spritemap ID (into $82:C569 table)
$82:C186             dw 0018,00E8 ; X position
$82:C18A             dw 00D0,00D0 ; Y position + 1


; Pointers to lists of equipment screen item selector positions
$82:C18E             dw C196, C19E, C1B2, C1CA

;                        ________ X position
;                       |     ___ Y position
;                       |    |
$82:C196             dw 001B,0054, ; Tanks - mode
                        001B,005C  ; Tanks - reserve tank
$82:C19E             dw 0030,0084, ; Weapons - charge
                        0030,008C, ; Weapons - ice
                        0030,0094, ; Weapons - wave
                        0030,009C, ; Weapons - spazer
                        0030,00A4  ; Weapons - plasma
$82:C1B2             dw 00CC,004C, ; Suit/misc - varia suit
                        00CC,0054, ; Suit/misc - gravity suit
                        00CC,006C, ; Suit/misc - morph ball
                        00CC,0074, ; Suit/misc - bombs
                        00CC,007C, ; Suit/misc - spring ball
                        00CC,0084  ; Suit/misc - screw attack
$82:C1CA             dw 00CC,009C, ; Boots - hi-jump boots
                        00CC,00A4, ; Boots - space jump
                        00CC,00AC  ; Boots - speed booster

; Equipment screen reserve tank X positions
$82:C1D6             dw 0018, 0020, 0028, 0030, 0038, 0040

; Equipment screen reserve tank Y position + 1
$82:C1E2             dw 0060


; Pointers to animation spritemap base IDs (into $82:C569 table)
$82:C1E4             dw C1F6, C1FC, C202, C20A, C20C, C20E, C210, C212, C214

; Unused (animation 0)
$82:C1F6             dw 0000,0028,0029

; L/R highlight (pause screen button label mode)
$82:C1FC             dw 002A, ; 0: Map screen (SAMUS on the right)
                        002A, ; 1: Unpausing (nothing)
                        002A  ; 2: Equipment screen (MAP on the left)

; Item selector (equipment screen category index)
$82:C202             dw 0014, ; 0: Tanks
                        0015, ; 1: Weapons
                        0016, ; 2: Suit/misc
                        0016  ; 3: Boots

$82:C20A             dw 002C ; Unused (animation 4)
$82:C20C             dw 0013 ; Unused (animation 5)
$82:C20E             dw 0006 ; Up scroll arrow
$82:C210             dw 0007 ; Down scroll arrow
$82:C212             dw 0004 ; Right scroll arrow
$82:C214             dw 0005 ; Left scroll arrow
}


;;; $C216: Spritemaps ;;;
{
; Spritemap 2
$82:C216             dx 0001, 0000,00,3095

; Spritemap 3
$82:C21D             dx 0001, 0000,00,B095

; Spritemap 1
$82:C224             dx 0001, 0000,00,3094

; Spritemap 0
$82:C22B             dx 0001, 0000,00,7094

; Spritemap 6: map scrolling arrow - up
$82:C232             dx 0002, 01FF,FC,F49D, 01F8,FC,B49D

; Spritemap 7: map scrolling arrow - down
$82:C23E             dx 0002, 01FF,FC,749D, 01F8,FC,349D

; Spritemap 5: map scrolling arrow - left
$82:C24A             dx 0002, 01FC,00,F49E, 01FC,F9,749E

; Spritemap 4: map scrolling arrow - right
$82:C256             dx 0002, 01FC,00,B49E, 01FC,F9,349E

; Spritemap 10h
$82:C262             dx 0005, 01FC,04,3097, 01F4,FC,3086, 0004,FC,3088, 01FC,F4,3077, 01FC,FC,3087

; Spritemap 11h
$82:C27D             dx 0005, 0004,FC,308B, 01F4,FC,3089, 01FC,04,309A, 01FC,FC,308A, 01FC,F4,307A

; Spritemap 12h: file select map Samus icon
$82:C298             dx 0001, 0001,00,2E89

; Spritemap 14h: equipment screen item selector - tanks
$82:C29F             dx 0001, 01FC,FC,3646

; Spritemap 19h
$82:C2A6             dx 0003, 01F8,F8,3063, 01E8,F8,30B9, 01E0,F8,30B8

; Spritemap 15h: equipment screen item selector - weapons
$82:C2B7             dx 000C, 0010,04,345C, 0010,FC,345C, 01F0,04,345C, 01F8,04,345C, 0000,04,345C, 0008,04,345C, 0018,04,345E, 0018,FC,345D, 0008,FC,345C, 0000,FC,345C, 01F8,FC,345C, 01F0,FC,345B

; Spritemap 16h: equipment screen item selector - suit/misc/boots
$82:C2F5             dx 0014, 001C,04,345C, 001C,FC,345C, 0004,04,345C, 0014,04,345C, 000C,04,345C, 0014,FC,345C, 000C,FC,345C, 0004,FC,345C, 01FC,04,345C, 01FC,FC,345C, 01DC,04,345C, 01E4,04,345C, 01EC,04,345C, 01F4,04,345C, 0024,04,345E, 0024,FC,345D, 01F4,FC,345C, 01EC,FC,345C, 01E4,FC,345C, 01DC,FC,345B

; Spritemap 1Bh: full equipment screen reserve tank
$82:C35B             dx 0001, 0000,00,344E

; Spritemap 1Ch
$82:C362             dx 0001, 0000,00,344D

; Spritemap 1Ah
$82:C369             dx 0001, 0000,00,344F

; Spritemap 1Fh: end of equipment screen reserve health bar
$82:C370             dx 0001, 0000,00,344E

; Spritemap 1Dh
$82:C377             dx 0001, 0000,00,304D

; Spritemap 1Eh
$82:C37E             dx 0001, 01FD,FC,3FF0

; Spritemap 8: save icon
$82:C385             dx 0001, 0001,00,208D

; Spritemap 9: boss icon
$82:C38C             dx 0001, 0001,00,208A

; Spritemap Ah: energy station icon
$82:C393             dx 0001, 0001,00,208C

; Spritemap Bh: missile station icon
$82:C39A             dx 0001, 0001,00,208B

; Spritemap 4Eh: map station icon
$82:C3A1             dx 0001, 0001,00,208E

; Spritemap 17h: debug elevator icon
$82:C3A8             dx 0001, 0001,00,208F

; Spritemap Ch: debug save icon
$82:C3AF             dx 0001, 0001,00,21F4

; Spritemap Dh
$82:C3B6             dx 0001, 0001,00,21F1

; Spritemap Eh
$82:C3BD             dx 0001, 0001,00,21F3

; Spritemap Fh
$82:C3C4             dx 0001, 0001,00,21F2

; Spritemap 18h
$82:C3CB             dx 0001, 0001,00,21F6

; ???
$82:C3D2             dx 0001, 0001,00,21F5

; Spritemap 20h: empty equipment screen reserve tank
$82:C3D9             dx 0001, 0000,00,344D

; Spritemap 21h: equipment screen 1/7 reserve tank
$82:C3E0             dx 0001, 0000,00,3447

; Spritemap 22h: equipment screen 2/7 reserve tank
$82:C3E7             dx 0001, 0000,00,3448

; Spritemap 23h: equipment screen 3/7 reserve tank
$82:C3EE             dx 0001, 0000,00,3449

; Spritemap 24h: equipment screen 4/7 reserve tank
$82:C3F5             dx 0001, 0000,00,344A

; Spritemap 25h: equipment screen 5/7 reserve tank
$82:C3FC             dx 0001, 0000,00,344B

; Spritemap 26h: equipment screen 6/7 reserve tank
$82:C403             dx 0001, 0000,00,344C

; Spritemap 27h: equipment screen 7/7 reserve tank
$82:C40A             dx 0001, 0000,00,344E

; Spritemap 4Fh
$82:C411             dx 0001, 0000,00,3064

; Spritemap 50h
$82:C418             dx 0001, 0000,00,3065

; Spritemap 51h
$82:C41F             dx 0001, 0000,00,3066

; Spritemap 52h
$82:C426             dx 0001, 0000,00,3067

; Spritemap 53h
$82:C42D             dx 0001, 0000,00,3068

; Spritemap 54h
$82:C434             dx 0001, 0000,00,3069

; Spritemap 55h
$82:C43B             dx 0001, 0000,00,306A

; Spritemap 56h
$82:C442             dx 0001, 0000,00,306B

; Spritemap 57h
$82:C449             dx 0001, 0000,00,306C

; Spritemap 58h
$82:C450             dx 0001, 0000,00,306D

; ???
$82:C457             dx 0001, 0000,00,306E

; ???
$82:C45E             dx 0001, 0000,00,306F

; Spritemap 2Ah: L/R highlight
$82:C465             dx 0008, 0008,00,7451, 0000,00,3443, 01F8,00,3443, 01F0,00,3451, 0000,F8,743D, 0008,F8,743C, 01F8,F8,343D, 01F0,F8,343C

; Spritemap 28h: L button pressed highlight
$82:C48F             dx 0003, 01FC,FC,3429, 0004,FC,342A, 01F4,FC,3428

; Spritemap 29h: R button pressed highlight
$82:C4A0             dx 0003, 01FC,FC,342E, 0004,FC,342A, 01F4,FC,3428

; Spritemap 2Bh: start button pressed highlight
$82:C4B1             dx 0008, 0008,00,34C7, 0000,00,34C6, 01F8,00,34C5, 01F0,00,34C4, 0000,F8,34B6, 01F8,F8,34B5, 0008,F8,74B4, 01F0,F8,34B4

; Spritemap 59h: elevator destination - Crateria
$82:C4DB             dx 0004, 0010,F8,2003, 0008,F8,2002, 0000,F8,2001, 01F8,F8,2000

; Spritemap 5Ah: elevator destination - Brinstar
$82:C4F1             dx 0004, 0010,F8,2007, 0008,F8,2006, 0000,F8,2005, 01F8,F8,2004

; Spritemap 5Bh: elevator destination - Norfair
$82:C507             dx 0004, 0010,F8,2014, 0008,F8,2013, 0000,F8,2012, 01F8,F8,2010

; Spritemap 5Eh: elevator destination - Tourian
$82:C51D             dx 0004, 0010,F8,2032, 0008,F8,2020, 0000,F8,2009, 01F8,F8,2008

; Spritemap 5Dh: elevator destination - Maridia
$82:C533             dx 0004, 0010,F8,2019, 0008,F8,2018, 0000,F8,2016, 01F8,F8,2015

; Spritemap 5Ch: elevator destination - Wrecked Ship
$82:C549             dx 0006, 0004,00,2045, 01FC,00,2044, 000C,F8,2056, 0004,F8,2055, 01FC,F8,2054, 01F4,F8,2053
}


;;; $C569: Spritemap pointers ;;;
{
; Spawned by $81:891F
$82:C569             dw C22B, C224, C216, C21D, C256, C24A, C232, C23E, C385, C38C, C393, C39A, C3AF, C3B6, C3BD, C3C4,
                        C262, C27D, C298, C37E, C29F, C2B7, C2F5, C3A8, C3CB, C2A6, C369, C35B, C362, C370, C377, C369,
                        C3D9, C3E0, C3E7, C3EE, C3F5, C3FC, C403, C40A, C48F, C4A0, C465, C4B1, CAE9, CAFF, CB15, CB2B,
                        CB4B, CB6B, CB8B, CBAB, CBCB, CBD7, CBE3, CBEF, CBFB, CC6B, CC95, CCBF, CD2E, CD09, CCE4, CD67,
                        CDCD, CE15, CE5D, CECD, CF3D, CF53, CF5F, CF66, D00B, D0AD, D177, D24B, D2F7, D41B, C3A1, C411,
                        C418, C41F, C426, C42D, C434, C43B, C442, C449, C450, C4DB, C4F1, C507, C549, C533, C51D, CF7C,
                        CF92, CFA8, CFBE, CFD4, CFE0, CFF6, CFFD, D004
}


;;; $C639: Dummy Samus wireframe tilemap ;;;
{
; Doubt this is needed
$82:C639             dw 0000,0000,0000,25B3,65B3,0000,0000,0000,
                        25C0,25C1,25C2,25C3,65C3,65C2,65C1,65C0,
                        25D0,25D1,25D2,25D3,65D3,65D2,65D1,65D0,
                        25E0,25E1,25EF,25E3,25E4,25E5,25E6,25E7,
                        25F0,25F1,25F2,25F3,25F4,25F5,65F1,65F0,
                        2600,2601,2602,2603,2604,2605,6601,6600,
                        2610,2611,2612,2613,2614,2615,2616,2617,
                        2620,2621,2622,2623,2624,2625,2626,2627,
                        2630,2631,2632,2633,6633,6632,2636,2637,
                        0000,25C9,25CA,25CB,65CB,65CA,0000,0000,
                        0000,0000,25DA,25DB,65DB,65DA,0000,0000,
                        0000,25E9,25EA,25EB,65EB,65EA,65E9,0000,
                        0000,25F9,25FA,25FB,65FB,65FA,65F9,0000,
                        0000,2609,260A,0000,0000,660A,6609,0000,
                        0000,2619,261A,0000,0000,661A,6619,0000,
                        2628,2629,262A,062B,462B,662A,262C,262D,
                        2638,2639,263A,0000,0000,663A,263C,6638
}


;;; $C749: Area select spritemap base index ;;;
{
$82:C749             dw 0038
}


;;; $C74B: Unused. D-pad icon spritemap index? ;;;
{
$82:C74B             dw 0044
}


;;; $C74D: Map elevator destinations ;;;
{
$82:C74D             dw C759, C779, C799, C7A1, C7AF, C7C3

; Spritemap indices:
;     $59: Crateria
;     $5A: Brinstar
;     $5B: Norfair
;     $5C: Wrecked Ship
;     $5D: Maridia
;     $5E: Tourian (unused)

;                        _____________ X position
;                       |     ________ Y position
;                       |    |     ___ Spritemap index
;                       |    |    |
; Crateria
$82:C759             dw 0030,0070,005A,
                        00B8,00B8,005A,
                        0110,0068,005A,
                        0178,0020,005C,
                        01A0,0080,005D,
                        FFFF

; Brinstar
$82:C779             dw 0048,0008,0059,
                        00D0,0040,0059,
                        0128,0020,0059,
                        0140,0090,005D,
                        0148,00C0,005B,
                        FFFF

; Norfair
$82:C799             dw 0050,0008,005A,
                        FFFF

; Wrecked Ship
$82:C7A1             dw 0040,0080,0059,
                        00C0,0080,0059,
                        FFFF

; Maridia
$82:C7AF             dw 0108,0008,0059,
                        0030,00A0,005A,
                        0078,00A0,005A,
                        FFFF

; Tourian
$82:C7C3             dw 0098,0048,0059,
                        FFFF
}


;;; $C7CB: Map icon data pointers ;;;
{
;                        ______________________________________ Crateria
;                       |     _________________________________ Brinstar
;                       |    |     ____________________________ Norfair
;                       |    |    |     _______________________ Wrecked Ship
;                       |    |    |    |     __________________ Maridia
;                       |    |    |    |    |     _____________ Tourian
;                       |    |    |    |    |    |     ________ Ceres
;                       |    |    |    |    |    |    |     ___ Debug
;                       |    |    |    |    |    |    |    |
$82:C7CB             dw C83B,C89D,C90B,C981,C9DB,0000,CA9B,0000 ; Boss icons (including cross-outs)
$82:C7DB             dw 0000,C8A3,0000,0000,C9E1,0000,0000,0000 ; Missile stations
$82:C7EB             dw 0000,C8A9,C913,0000,C9E7,CA49,0000,0000 ; Energy stations
$82:C7FB             dw C84D,C8B7,C91D,C98B,C9ED,CA4F,0000,0000 ; Map stations
$82:C80B             dw C853,C8BD,C923,C991,C9F3,CA51,0000,0000 ; Save points
$82:C81B             dw C873,C8DD,C943,C9B1,CA13,CA71,0000,0000 ; Debug elevator markers
$82:C82B             dw C893,C8FD,C963,C9D1,CA33,CA91,0000,0000 ; Debug save points
}


;;; $C83B: Crateria map icon data ;;;
{
; Boss icons
$82:C83B             dw FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFF

; (Missile stations)
$82:C849             dw FFFF

; (Energy station)
$82:C84B             dw FFFF

; Map stations
$82:C84D             dw 00B8,0040, FFFF

; Save points
$82:C853             dw 00D8,0028, 0090,0038, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug elevator markers
$82:C873             dw 01A0,0058, 0110,0040, 00B8,0090, 0030,0048, 0088,0050, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug save points
$82:C893             dw 00D8,0028, 0188,0028, FFFF
}


;;; $C89D: Brinstar map icon data ;;;
{
; Boss icons
$82:C89D             dw 01BC,009C, FFFF

; Missile stations
$82:C8A3             dw 0028,0040, FFFF

; Energy stations
$82:C8A9             dw 0048,0068, 0100,0098, 01B0,0098, FFFF

; Map stations
$82:C8B7             dw 0028,0028, FFFF

; Save points
$82:C8BD             dw 0078,0028, 0040,0030, 0028,0060, 0188,0098, 0130,0048, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug elevator markers
$82:C8DD             dw 0048,0018, 00D0,0058, 0128,0038, 0148,0098, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug save points
$82:C8FD             dw 0048,0018, 01B8,00A0, 0090,0020, FFFF
}


;;; $C90B: Norfair map icon data ;;;
{
; Boss icons
$82:C90B             dw 00B8,0090, FFFF

; (Missile stations)
$82:C911             dw FFFF

; Energy stations
$82:C913             dw 00A0,0050, 00A8,0080, FFFF

; Map stations
$82:C91D             dw 0048,0028, FFFF

; Save points
$82:C923             dw 0060,0060, 00A8,0020, 0058,0030, 0080,0048, 00A0,0058, 0120,0068, FFFE,FFFE, FFFE,FFFE

; Debug elevator markers
$82:C943             dw 0050,0018, 00A8,0058, 00A8,0070, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug save points
$82:C963             dw 0050,0010, 0078,0050, 00B0,0088, 0050,0058, 00A8,0070, 00A0,0080, 0010,0008, FFFF
}


;;; $C981: Wrecked Ship map icon data ;;;
{
; Boss icons
$82:C981             dw 0098,00A0, FFFF

; (Missile stations)
$82:C987             dw FFFF

; (Energy station)
$82:C989             dw FFFF

; Map stations
$82:C98B             dw 0068,00A0, FFFF

; Save points
$82:C991             dw 0088,0078, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug elevator markers
$82:C9B1             dw FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug save points
$82:C9D1             dw 0050,0078, 0090,00A0, FFFF
}


;;; $C9DB: Maridia map icon data ;;;
{
; Boss icons
$82:C9DB             dw 013C,0054, FFFF

; Missile stations
$82:C9E1             dw 0130,0048, FFFF

; Energy station
$82:C9E7             dw 0150,0038, FFFF

; Map stations
$82:C9ED             dw 0088,0090, FFFF

; Save points
$82:C9F3             dw 0060,00A0, 0118,0028, 0098,0060, 0148,0038, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug elevator markers
$82:CA13             dw 0110,0018, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug save points
$82:CA33             dw 0090,0028, 0148,0050, 00B8,0048, 00B0,0088, FFFF
}


;;; $CA45: Tourian map icon data ;;;
{
; (Boss icons)
$82:CA45             dw FFFF

; (Missile stations)
$82:CA47             dw FFFF

; Energy station
$82:CA49             dw 0058,0088, FFFF

; Map stations
$82:CA4F             dw FFFF

; Save points
$82:CA51             dw 0080,0090, 00A8,0068, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug elevator markers
$82:CA71             dw 00A0,0060, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; Debug save points
$82:CA91             dw 0088,0050, 0068,00C0, FFFF
}


;;; $CA9B: Ceres map icon data ;;;
{
; Boss icons
$82:CA9B             dw 00A0,0088, FFFF

; (Missile stations)
$82:CAA1             dw FFFF

; (Energy station)
$82:CAA3             dw FFFF

; (Map stations)
$82:CAA5             dw FFFF

; (Save points)
$82:CAA7             dw FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; (Debug elevator markers)
$82:CAC7             dw FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE, FFFE,FFFE

; (Debug save points)
$82:CAE7             dw FFFF
}


;;; $CAE9: Spritemaps ;;;
{
; Spritemap 2Ch: file select menu Samus helmet (frame 0)
$82:CAE9             dx 0004, C3FC,F4,3ED1, C3FC,FC,3EE1, C3F4,FC,3EE0, C3F4,F4,3ED0

; Spritemap 2Dh: file select menu Samus helmet (frame 1)
$82:CAFF             dx 0004, C3F4,FC,3EE3, C3F4,F4,3ED3, C3FC,F4,3ED4, C3FC,FC,3EE4

; Spritemap 2Eh: file select menu Samus helmet (frame 2)
$82:CB15             dx 0004, C3FC,F4,3ED7, C3F4,F4,3ED6, C3F4,FC,3EE6, C3FC,FC,3EE7

; Spritemap 2Fh: file select menu Samus helmet (frame 3)
$82:CB2B             dx 0006, 0000,FE,3EDA, 01F8,FE,3ED9, C3FC,F4,3ED7, C3F4,F4,3ED6, C3F4,FC,3EE6, C3FC,FC,3EE7

; Spritemap 30h: file select menu Samus helmet (frame 4)
$82:CB4B             dx 0006, 0000,FE,3EDC, 01F8,FE,3EDB, C3FC,F4,3ED7, C3F4,F4,3ED6, C3F4,FC,3EE6, C3FC,FC,3EE7

; Spritemap 31h: file select menu Samus helmet (frame 5)
$82:CB6B             dx 0006, 0000,FE,3EDE, 01F8,FE,3EDD, C3FC,F4,3ED7, C3F4,F4,3ED6, C3F4,FC,3EE6, C3FC,FC,3EE7

; Spritemap 32h: file select menu Samus helmet (frame 6)
$82:CB8B             dx 0006, 0000,FE,3EEA, 01F8,FE,3EE9, C3FC,F4,3ED7, C3F4,F4,3ED6, C3F4,FC,3EE6, C3FC,FC,3EE7

; Spritemap 33h: file select menu Samus helmet (frame 7)
$82:CBAB             dx 0006, 0000,FE,3EEC, 01F8,FE,3EEB, C3FC,F4,3ED7, C3F4,F4,3ED6, C3F4,FC,3EE6, C3FC,FC,3EE7

; Spritemap 34h: menu selection missile (frame 0)
$82:CBCB             dx 0002, 0000,FC,3EEF, 01F8,FC,3EDF

; Spritemap 35h: menu selection missile (frame 1)
$82:CBD7             dx 0002, 0000,FC,3EFF, 01F8,FC,3EEE

; Spritemap 36h: menu selection missile (frame 2)
$82:CBE3             dx 0002, 0000,FC,3ECC, 01F8,FC,3EFE

; Spritemap 37h: menu selection missile (frame 3)
$82:CBEF             dx 0002, 01F8,FC,3EC8, 0000,FC,3EFF

; Spritemap 38h: area select - planet Zebes
$82:CBFB             dx 0016, 0028,00,303B, 0028,F8,302B, 0020,00,301E, 0020,F8,300E, 0018,00,301B, 0018,F8,300B, 0010,00,301E, 0010,F8,300E, 0008,00,3052, 0008,F8,3042, 01F8,00,3011, 01F8,F8,302C, 01F0,00,301E, 01F0,F8,300E, 01E8,00,3037, 01E8,F8,3027, 01E0,00,301A, 01E0,F8,300A, 01D8,00,3035, 01D8,F8,3025, 01D0,F8,300D, 01D0,00,3038

; Spritemap 39h: area select - Crateria
$82:CC6B             dx 0008, 0017,FC,306A, 0010,FC,3072, 000A,FC,307B, 0002,FC,306E, 01FA,FC,307D, 01F2,FC,306A, 01EA,FC,307B, 01E2,FC,306C

; Spritemap 3Ah: area select - Brinstar
$82:CC95             dx 0008, 0017,FC,307B, 000E,FC,306A, 0007,FC,307D, 01FF,FC,307C, 01F7,FC,3077, 01EF,FC,3072, 01E9,FC,307B, 01E1,FC,306B

; Spritemap 3Bh: area select - Norfair
$82:CCBF             dx 0007, 0014,FC,307B, 000C,FC,3072, 0005,FC,306A, 01FD,FC,306F, 01F5,FC,307B, 01ED,FC,3078, 01E5,FC,3077

; Spritemap 3Eh: area select - Tourian
$82:CCE4             dx 0007, 0013,FC,3077, 000A,FC,306A, 0003,FC,3072, 01FD,FC,307B, 01F5,FC,307E, 01ED,FC,3078, 01E6,FC,307D

; Spritemap 3Dh: area select - Maridia
$82:CD09             dx 0007, 0013,FC,306A, 000B,FC,3072, 0004,FC,306D, 01FC,FC,3072, 01F6,FC,307B, 01EE,FC,306A, 01E6,FC,3076

; Spritemap 3Ch: area select - Wrecked Ship
$82:CD2E             dx 000B, 0018,00,3079, 0010,00,3072, 0009,00,3071, 0001,00,307C, 0010,F8,306D, 0008,F8,306E, 0000,F8,3074, 01F8,F8,306C, 01F0,F8,306E, 01E8,F8,307B, 01E0,F8,3080

; Spritemap 3Fh
$82:CD67             dx 0014, 0010,08,3EFA, 0008,08,3EFA, 0000,08,3EFA, 01F8,08,3EFA, 01F0,08,3EFA, 01E8,08,3EFA, 0010,F0,3EFA, 0008,F0,3EFA, 0000,F0,3EFA, 01F8,F0,3EFA, 01F0,F0,3EFA, 01E8,F0,3EFA, 01E0,00,3EED, 01E0,F8,3EED, 0018,00,3EED, 0018,F8,3EED, 0018,08,3EFD, 01E0,08,3EFC, 0018,F0,3EFB, 01E0,F0,3EF9

; Spritemap 40h: file copy arrow - one slot down
$82:CDCD             dx 000E, 0002,F0,32CF, 01FA,F0,32CE, 0002,E8,32BF, 01FA,E8,32BE, 01FA,08,32B9, 01FA,10,32C9, 0002,10,32CB, 0002,08,32BB, 01F2,08,32B8, 01F2,00,32BC, 01FA,00,32BD, 01F2,F0,32CD, 01FA,F8,32BD, 01F2,F8,32BC

; Spritemap 41h: file copy arrow - one slot up
$82:CE15             dx 000E, 01F2,F0,B2B8, 01F2,F8,B2BC, 01FA,F8,B2BD, 01FA,E8,B2C9, 01FA,F0,B2B9, 0002,08,B2CF, 01FA,08,B2CE, 0002,10,B2BF, 01FA,10,B2BE, 01F2,08,B2CD, 01FA,00,B2BD, 01F2,00,B2BC, 0002,E8,B2CB, 0002,F0,B2BB

; Spritemap 42h: file copy arrow - two slots down
$82:CE5D             dx 0016, 01FA,08,32BD, 01F2,08,32BC, 01FA,00,32BD, 01F2,00,32BC, 01FA,F8,32BD, 01F2,F8,32BC, 01FA,F0,32BD, 01F2,F0,32BC, 01F2,18,32B8, 01F2,10,32BC, 01FA,10,32BD, 01FA,20,32C9, 01FA,18,32B9, 0002,E0,32CF, 01FA,E0,32CE, 0002,D8,32BF, 01FA,D8,32BE, 01F2,E0,32CD, 01FA,E8,32BD, 01F2,E8,32BC, 0002,20,32CB, 0002,18,32BB

; Spritemap 43h: file copy arrow - two slots up
$82:CECD             dx 0016, 01FA,F0,B2BD, 01F2,F0,B2BC, 01FA,F8,B2BD, 01F2,F8,B2BC, 01FA,00,B2BD, 01F2,00,B2BC, 01FA,08,B2BD, 01F2,08,B2BC, 01F2,E0,B2B8, 01F2,E8,B2BC, 01FA,E8,B2BD, 01FA,D8,B2C9, 01FA,E0,B2B9, 0002,18,B2CF, 01FA,18,B2CE, 0002,20,B2BF, 01FA,20,B2BE, 01F2,18,B2CD, 01FA,10,B2BD, 01F2,10,B2BC, 0002,D8,B2CB, 0002,E0,B2BB

; Spritemap 44h:
$82:CF3D             dx 0004, 01FF,FF,F0B3, 01F8,FF,B0B3, 01FF,F8,70B3, 01F8,F8,30B3

; Spritemap 45h:
$82:CF53             dx 0002, C3F4,F8,3095, C3FC,F8,3096

; Spritemap 46h
$82:CF5F             dx 0001, C3F8,F8,3091

; Spritemap 47h
$82:CF66             dx 0004, 0000,00,70A0, 0000,F8,7090, 01F8,00,30A0, 01F8,F8,3090

; Spritemap 5Fh: Samus position indicator (frame 0)
$82:CF7C             dx 0004, 0004,04,EEAF, 01FC,04,AEAF, 0004,FC,6EAF, 01FC,FC,2EAF

; Spritemap 60h: Samus position indicator (frame 1)
$82:CF92             dx 0004, 0005,05,EEAF, 01FB,05,AEAF, 0005,FB,6EAF, 01FB,FB,2EAF

; Spritemap 61h: Samus position indicator (frame 2)
$82:CFA8             dx 0004, 0006,06,EEAF, 01FA,06,AEAF, 0006,FA,6EAF, 01FA,FA,2EAF

; Spritemap 62h: boss cross-out icon
$82:CFBE             dx 0004, 0003,04,EE9F, 0003,FC,6E9F, 01FC,04,AE9F, 01FC,FC,2E9F

; Spritemap 63h: gunship icon
$82:CFD4             dx 0002, 0004,FE,6E8F, 01FC,FE,2E8F

; Spritemap 64h: game over baby metroid container
$82:CFE0             dx 0004, 0000,08,FA9A, 01F8,08,BA9A, 0000,F0,7A9A, 01F8,F0,3A9A

; Spritemap 65h: game over baby metroid (frame 0)
$82:CFF6             dx 0001, C3F8,F8,3890

; Spritemap 66h: game over baby metroid (frame 1)
$82:CFFD             dx 0001, C3F8,F8,3892

; Spritemap 67h: game over baby metroid (frame 2)
$82:D004             dx 0001, C3F8,F8,389B

; Spritemap 48h: border around SAMUS DATA
$82:D00B             dx 0020, 01C8,00,3EED, 01C8,F8,3EED, 0030,00,3EED, 0030,F8,3EED, 0030,08,3EFD, 01C8,08,3EFC, 0030,F0,3EFB, 01C8,F0,3EF9, 01F8,08,3EFA, 01F0,08,3EFA, 01E8,08,3EFA, 01E0,08,3EFA, 01D8,08,3EFA, 01D0,08,3EFA, 0028,08,3EFA, 0020,08,3EFA, 0018,08,3EFA, 0010,08,3EFA, 0008,08,3EFA, 0000,08,3EFA, 0028,F0,3EFA, 0020,F0,3EFA, 0018,F0,3EFA, 0010,F0,3EFA, 0008,F0,3EFA, 0000,F0,3EFA, 01F8,F0,3EFA, 01F0,F0,3EFA, 01E8,F0,3EFA, 01E0,F0,3EFA, 01D8,F0,3EFA, 01D0,F0,3EFA

; Spritemap 49h: border around DATA COPY MODE
$82:D0AD             dx 0028, 0000,08,3EFA, 0008,08,3EFA, 01F0,08,3EFA, 01F8,08,3EFA, 0000,F0,3EFA, 0008,F0,3EFA, 01F0,F0,3EFA, 01F8,F0,3EFA, 01B8,00,3EED, 01B8,F8,3EED, 0040,00,3EED, 0040,F8,3EED, 0040,08,3EFD, 01B8,08,3EFC, 0040,F0,3EFB, 01B8,F0,3EF9, 01E8,08,3EFA, 01E0,08,3EFA, 01D8,08,3EFA, 01D0,08,3EFA, 01C8,08,3EFA, 01C0,08,3EFA, 0038,08,3EFA, 0030,08,3EFA, 0028,08,3EFA, 0020,08,3EFA, 0018,08,3EFA, 0010,08,3EFA, 0038,F0,3EFA, 0030,F0,3EFA, 0028,F0,3EFA, 0020,F0,3EFA, 0018,F0,3EFA, 0010,F0,3EFA, 01E8,F0,3EFA, 01E0,F0,3EFA, 01D8,F0,3EFA, 01D0,F0,3EFA, 01C8,F0,3EFA, 01C0,F0,3EFA

; Spritemap 4Ah: border around DATA CLEAR MODE
$82:D177             dx 002A, 01EC,F0,3EFA, 01EC,08,3EFA, 0004,08,3EFA, 000C,08,3EFA, 01F4,08,3EFA, 01FC,08,3EFA, 0004,F0,3EFA, 000C,F0,3EFA, 01F4,F0,3EFA, 01FC,F0,3EFA, 01B4,00,3EED, 01B4,F8,3EED, 0044,00,3EED, 0044,F8,3EED, 0044,08,3EFD, 01B4,08,3EFC, 0044,F0,3EFB, 01B4,F0,3EF9, 01E4,08,3EFA, 01DC,08,3EFA, 01D4,08,3EFA, 01CC,08,3EFA, 01C4,08,3EFA, 01BC,08,3EFA, 003C,08,3EFA, 0034,08,3EFA, 002C,08,3EFA, 0024,08,3EFA, 001C,08,3EFA, 0014,08,3EFA, 003C,F0,3EFA, 0034,F0,3EFA, 002C,F0,3EFA, 0024,F0,3EFA, 001C,F0,3EFA, 0014,F0,3EFA, 01E4,F0,3EFA, 01DC,F0,3EFA, 01D4,F0,3EFA, 01CC,F0,3EFA, 01C4,F0,3EFA, 01BC,F0,3EFA

; Spritemap 4Bh: border around OPTIONS MODE
$82:D24B             dx 0022, 01FC,08,3EFA, 01FC,F0,3EFA, 01F4,08,3EFA, 01F4,F0,3EFA, 01C4,00,3EED, 01C4,F8,3EED, 0034,00,3EED, 0034,F8,3EED, 0034,08,3EFD, 01C4,08,3EFC, 0034,F0,3EFB, 01C4,F0,3EF9, 01EC,08,3EFA, 01E4,08,3EFA, 01DC,08,3EFA, 01D4,08,3EFA, 01CC,08,3EFA, 002C,08,3EFA, 0024,08,3EFA, 001C,08,3EFA, 0014,08,3EFA, 000C,08,3EFA, 0004,08,3EFA, 002C,F0,3EFA, 0024,F0,3EFA, 001C,F0,3EFA, 0014,F0,3EFA, 000C,F0,3EFA, 0004,F0,3EFA, 01EC,F0,3EFA, 01E4,F0,3EFA, 01DC,F0,3EFA, 01D4,F0,3EFA, 01CC,F0,3EFA

; Spritemap 4Ch: border around CONTROLLER SETTING MODE
$82:D2F7             dx 003A, 01DC,08,3EFA, 01E4,08,3EFA, 0014,08,3EFA, 000C,08,3EFA, 0004,08,3EFA, 01EC,08,3EFA, 01FC,08,3EFA, 01F4,08,3EFA, 01DC,F0,3EFA, 01E4,F0,3EFA, 0014,F0,3EFA, 000C,F0,3EFA, 0004,F0,3EFA, 01EC,F0,3EFA, 01FC,F0,3EFA, 01F4,F0,3EFA, 01CC,F0,3EFA, 01CC,08,3EFA, 0024,08,3EFA, 002C,08,3EFA, 01D4,08,3EFA, 001C,08,3EFA, 0024,F0,3EFA, 002C,F0,3EFA, 01D4,F0,3EFA, 001C,F0,3EFA, 0194,00,3EED, 0194,F8,3EED, 0064,00,3EED, 0064,F8,3EED, 0064,08,3EFD, 0194,08,3EFC, 0064,F0,3EFB, 0194,F0,3EF9, 01C4,08,3EFA, 01BC,08,3EFA, 01B4,08,3EFA, 01AC,08,3EFA, 01A4,08,3EFA, 019C,08,3EFA, 005C,08,3EFA, 0054,08,3EFA, 004C,08,3EFA, 0044,08,3EFA, 003C,08,3EFA, 0034,08,3EFA, 005C,F0,3EFA, 0054,F0,3EFA, 004C,F0,3EFA, 0044,F0,3EFA, 003C,F0,3EFA, 0034,F0,3EFA, 01C4,F0,3EFA, 01BC,F0,3EFA, 01B4,F0,3EFA, 01AC,F0,3EFA, 01A4,F0,3EFA, 019C,F0,3EFA

; Spritemap 4Dh: border around SPECIAL SETTING MODE
$82:D41B             dx 0034, 01E8,08,3EFA, 01F0,08,3EFA, 0008,08,3EFA, 0000,08,3EFA, 01F8,08,3EFA, 01E8,F0,3EFA, 01F0,F0,3EFA, 0008,F0,3EFA, 0000,F0,3EFA, 01F8,F0,3EFA, 01D8,F0,3EFA, 01D8,08,3EFA, 0018,08,3EFA, 0020,08,3EFA, 01E0,08,3EFA, 0010,08,3EFA, 0018,F0,3EFA, 0020,F0,3EFA, 01E0,F0,3EFA, 0010,F0,3EFA, 01A0,00,3EED, 01A0,F8,3EED, 0058,00,3EED, 0058,F8,3EED, 0058,08,3EFD, 01A0,08,3EFC, 0058,F0,3EFB, 01A0,F0,3EF9, 01D0,08,3EFA, 01C8,08,3EFA, 01C0,08,3EFA, 01B8,08,3EFA, 01B0,08,3EFA, 01A8,08,3EFA, 0050,08,3EFA, 0048,08,3EFA, 0040,08,3EFA, 0038,08,3EFA, 0030,08,3EFA, 0028,08,3EFA, 0050,F0,3EFA, 0048,F0,3EFA, 0040,F0,3EFA, 0038,F0,3EFA, 0030,F0,3EFA, 0028,F0,3EFA, 01D0,F0,3EFA, 01C8,F0,3EFA, 01C0,F0,3EFA, 01B8,F0,3EFA, 01B0,F0,3EFA, 01A8,F0,3EFA
}


;;; $D521..D960: Samus wireframe tilemaps ;;;
{
;;; $D521: Power suit ;;;
{
$82:D521             dw 0000,0000,0000,25B3,65B3,0000,0000,0000,
                        25BC,25BD,25BE,25C3,65C3,65BE,65BD,65BC,
                        25CC,25CD,25CE,25D3,65D3,65CE,65CD,65CC,
                        25DC,25DD,25EC,25ED,257C,257D,257E,257F,
                        25F0,25F1,25FC,25FD,65FD,65FC,65F1,65F0,
                        2570,2571,2572,2573,2574,6572,6571,6570,
                        2580,2581,2594,2583,2584,2578,2586,2587,
                        2590,2591,25A4,25A5,65A5,2588,2596,2597,
                        25A0,25A1,25B4,25B5,65B5,65B4,25A6,25A7,
                        0000,25C9,25C4,25C5,65C5,65C4,0000,0000,
                        0000,0000,25D4,25D5,65D5,65D4,0000,0000,
                        0000,0000,25B6,25B7,65B7,65B6,0000,0000,
                        0000,0000,25C6,25C7,65C7,65C6,0000,0000,
                        0000,0000,25D6,05D7,45D7,65D6,0000,0000,
                        0000,0000,258F,0000,0000,658F,0000,F955,
                        258E,259E,259F,0000,0000,659F,25EE,259D,
                        25AD,25AE,25AF,0000,0000,65AF,25FE,65AD
}


;;; $D631: Hi-jump boots ;;;
{
$82:D631             dw 0000,0000,0000,25B3,65B3,0000,0000,0000,
                        25BC,25BD,25BE,25C3,65C3,65BE,65BD,65BC,
                        25CC,25CD,25CE,25D3,65D3,65CE,65CD,65CC,
                        25DC,25DD,25EC,25ED,257C,257D,257E,257F,
                        25F0,25F1,25FC,25FD,65FD,65FC,65F1,65F0,
                        2570,2571,2572,2573,2574,6572,6571,6570,
                        2580,2581,2594,2583,2584,2578,2586,2587,
                        2590,2591,25A4,25A5,65A5,2588,2596,2597,
                        25A0,25A1,25B4,25B5,65B5,65B4,25A6,25A7,
                        0000,25C9,25C4,25C5,65C5,65C4,0000,0000,
                        0000,0000,25D4,25D5,65D5,65D4,0000,0000,
                        0000,0000,25B6,25B7,65B7,65B6,0000,0000,
                        0000,0000,25C6,25C7,65C7,65C6,0000,0000,
                        0000,0579,258C,05D7,45D7,658C,4579,0000,
                        0000,0589,258A,0000,0000,658A,4589,E955,
                        2598,2599,259A,059B,459B,659A,259C,259D,
                        25A8,25A9,25AA,0000,0000,65AA,25AC,65A8
}


;;; $D741: Varia suit ;;;
{
$82:D741             dw 0000,0000,0000,25B3,65B3,0000,0000,0000,
                        25C0,25C1,25C2,25C3,65C3,65C2,65C1,65C0,
                        25D0,25D1,25D2,25D3,65D3,65D2,65D1,65D0,
                        25E0,25E1,25E2,25E3,25E4,25E5,25E6,25E7,
                        25F0,25F1,25F2,25F3,65F3,65F2,65F1,65F0,
                        2570,2571,2572,2573,2574,6572,6571,6570,
                        2580,2581,2582,2583,2584,2585,2586,2587,
                        2590,2591,2592,2593,6593,2595,2596,2597,
                        25A0,25A1,25A2,25A3,65A3,65A2,25A6,25A7,
                        0000,25C9,25CA,25CB,65CB,65CA,0000,0000,
                        0000,0000,25DA,25DB,65DB,65DA,0000,0000,
                        0000,05E9,25EA,25EB,45EB,65EA,65E9,0000,
                        0000,05F9,25FA,25FB,45FB,65FA,65F9,0000,
                        0000,0000,257B,05D7,45D7,657B,0000,0000,
                        0000,0000,258B,0000,0000,658B,0000,E955,
                        258E,259E,259F,0000,0000,659F,25EE,259D,
                        25AD,25AE,25AF,0000,0000,65AF,25FE,25FF
}


;;; $D851: Hi-jump boots + varia suit ;;;
{
$82:D851             dw 0000,0000,0000,25B3,65B3,0000,0000,0000,
                        25C0,25C1,25C2,25C3,65C3,65C2,65C1,65C0,
                        25D0,25D1,25D2,25D3,65D3,65D2,65D1,65D0,
                        25E0,25E1,25E2,25E3,25E4,25E5,25E6,25E7,
                        25F0,25F1,25F2,25F3,65F3,65F2,65F1,65F0,
                        2570,2571,2572,2573,2574,6572,6571,6570,
                        2580,2581,2582,2583,2584,2585,2586,2587,
                        2590,2591,2592,2593,6593,2595,2596,2597,
                        25A0,25A1,25A2,25A3,65A3,65A2,25A6,25A7,
                        0000,25C9,25CA,25CB,65CB,65CA,0000,0000,
                        0000,0000,25DA,25DB,65DB,65DA,0000,0000,
                        0000,25E9,25EA,25EB,65EB,65EA,65E9,0000,
                        0000,25F9,25FA,25FB,65FB,65FA,65F9,0000,
                        0000,2579,257A,0000,0000,657A,6579,0000,
                        0000,2589,258A,0000,0000,658A,6589,F955,
                        2598,2599,259A,059B,459B,659A,259C,259D,
                        25A8,25A9,25AA,0000,0000,65AA,25AC,65A8
}
}


;;; $D961..DB68: Gradual colour change ;;;
{
;;; $D961: Advance gradual colour change of all palettes - denominator = Ch ;;;
{
;; Returns:
;;     Carry: Set if reached target colour, clear otherwise

$82:D961 A9 0C 00    LDA #$000C             ;\
$82:D964 8F 02 C4 7E STA $7EC402[$7E:C402]  ;} Palette change denominator = Ch
$82:D968 20 02 DA    JSR $DA02  [$82:DA02]  ; Advance gradual colour change of all palettes
$82:D96B 60          RTS
}


;;; $D96C: Advance gradual colour change of BG palette 6 ;;;
{
;; Returns:
;;     Carry: Set if reached target colour, clear otherwise

; Called by Kraid when fading in the background
$82:D96C C2 30       REP #$30
$82:D96E A9 0C 00    LDA #$000C             ;\
$82:D971 8F 02 C4 7E STA $7EC402[$7E:C402]  ;} Palette change denominator = Ch
$82:D975 1A          INC A                  ;\
$82:D976 CF 00 C4 7E CMP $7EC400[$7E:C400]  ;} If [palette change numerator] > Dh:
$82:D97A B0 09       BCS $09    [$D985]     ;/
$82:D97C A9 00 00    LDA #$0000             ;\
$82:D97F 8F 00 C4 7E STA $7EC400[$7E:C400]  ;} Palette change numerator = 0
$82:D983 38          SEC                    ;\
$82:D984 6B          RTL                    ;} Return carry set

$82:D985 8B          PHB
$82:D986 F4 7E 7E    PEA $7E7E              ;\
$82:D989 AB          PLB                    ;} DB = $7E
$82:D98A AB          PLB                    ;/
$82:D98B A2 C0 00    LDX #$00C0             ; X = C0h

; LOOP
$82:D98E DA          PHX                    ;\
$82:D98F BF 00 C2 7E LDA $7EC200,x[$7E:C2C0];|
$82:D993 A8          TAY                    ;|
$82:D994 BF 00 C0 7E LDA $7EC000,x[$7E:C0C0];|
$82:D998 AA          TAX                    ;} $7E:C000 + [X] = the [palette change numerator]th transitional colour from [$7E:C000 + [X]] to [$7E:C200 + [X]]
$82:D999 AF 00 C4 7E LDA $7EC400[$7E:C400]  ;|
$82:D99D 20 4A DA    JSR $DA4A  [$82:DA4A]  ;|
$82:D9A0 FA          PLX                    ;|
$82:D9A1 9F 00 C0 7E STA $7EC000,x[$7E:C0C0];/
$82:D9A5 E8          INX                    ;\
$82:D9A6 E8          INX                    ;} X += 2
$82:D9A7 E0 E0 00    CPX #$00E0             ;\
$82:D9AA 90 E2       BCC $E2    [$D98E]     ;} If [X] < E0h: go to LOOP
$82:D9AC AB          PLB
$82:D9AD AF 00 C4 7E LDA $7EC400[$7E:C400]  ;\
$82:D9B1 1A          INC A                  ;} Increment palette change numerator
$82:D9B2 8F 00 C4 7E STA $7EC400[$7E:C400]  ;/
$82:D9B6 18          CLC                    ;\
$82:D9B7 6B          RTL                    ;} Return carry clear
}


;;; $D9B8: Advance gradual colour change of palette RAM [X]..[Y]-1 ;;;
{
;; Returns:
;;     Carry: Set if reached target colour, clear otherwise

$82:D9B8 C2 30       REP #$30
$82:D9BA A9 0F 00    LDA #$000F             ;\
$82:D9BD 8F 02 C4 7E STA $7EC402[$7E:C402]  ;} Palette change denominator = Fh
$82:D9C1 CF 00 C4 7E CMP $7EC400[$7E:C400]  ;\
$82:D9C5 10 09       BPL $09    [$D9D0]     ;} If [palette change numerator] > Fh:
$82:D9C7 A9 00 00    LDA #$0000             ;\
$82:D9CA 8F 00 C4 7E STA $7EC400[$7E:C400]  ;} Palette change numerator = 0
$82:D9CE 38          SEC                    ;\
$82:D9CF 6B          RTL                    ;} Return carry set

$82:D9D0 84 22       STY $22    [$7E:0022]  ; $22 = [Y]
$82:D9D2 8B          PHB
$82:D9D3 F4 7E 7E    PEA $7E7E              ;\
$82:D9D6 AB          PLB                    ;} DB = $7E
$82:D9D7 AB          PLB                    ;/

; LOOP
$82:D9D8 DA          PHX
$82:D9D9 BF 00 C2 7E LDA $7EC200,x[$7E:C200];\
$82:D9DD A8          TAY                    ;|
$82:D9DE BF 00 C0 7E LDA $7EC000,x[$7E:C000];|
$82:D9E2 AA          TAX                    ;|
$82:D9E3 AF 00 C4 7E LDA $7EC400[$7E:C400]  ;} $7E:C000 + [X] = the ([palette change numerator] + 1)th transitional colour from [$7E:C000 + [X]] to [$7E:C200 + [X]]
$82:D9E7 1A          INC A                  ;|
$82:D9E8 20 4A DA    JSR $DA4A  [$82:DA4A]  ;|
$82:D9EB FA          PLX                    ;|
$82:D9EC 9F 00 C0 7E STA $7EC000,x[$7E:C000];/
$82:D9F0 E8          INX                    ;\
$82:D9F1 E8          INX                    ;} X += 2
$82:D9F2 E4 22       CPX $22    [$7E:0022]  ;\
$82:D9F4 90 E2       BCC $E2    [$D9D8]     ;} If [X] < [$22]: go to LOOP
$82:D9F6 AB          PLB
$82:D9F7 AF 00 C4 7E LDA $7EC400[$7E:C400]  ;\
$82:D9FB 1A          INC A                  ;} Increment palette change numerator
$82:D9FC 8F 00 C4 7E STA $7EC400[$7E:C400]  ;/
$82:DA00 18          CLC                    ;\
$82:DA01 6B          RTL                    ;} Return carry clear
}


;;; $DA02: Advance gradual colour change of all palettes ;;;
{
;; Returns:
;;     Carry: Set if reached target colour, clear otherwise

$82:DA02 C2 30       REP #$30
$82:DA04 AF 02 C4 7E LDA $7EC402[$7E:C402]  ;\
$82:DA08 1A          INC A                  ;|
$82:DA09 CF 00 C4 7E CMP $7EC400[$7E:C400]  ;} If [palette change numerator] > [palette change denominator] + 1:
$82:DA0D B0 09       BCS $09    [$DA18]     ;/
$82:DA0F A9 00 00    LDA #$0000             ;\
$82:DA12 8F 00 C4 7E STA $7EC400[$7E:C400]  ;} Palette change numerator = 0
$82:DA16 38          SEC                    ;\
$82:DA17 60          RTS                    ;} Return carry set

$82:DA18 8B          PHB
$82:DA19 F4 7E 7E    PEA $7E7E              ;\
$82:DA1C AB          PLB                    ;} DB = $7E
$82:DA1D AB          PLB                    ;/
$82:DA1E A2 00 00    LDX #$0000             ; X = 0 (palette colour index)

; LOOP
$82:DA21 8E 04 C4    STX $C404  [$7E:C404]
$82:DA24 BD 00 C2    LDA $C200,x[$7E:C200]  ;\
$82:DA27 DD 00 C0    CMP $C000,x[$7E:C000]  ;} If [palette colour] != [target palette colour]:
$82:DA2A F0 11       BEQ $11    [$DA3D]     ;/
$82:DA2C A8          TAY                    ;\
$82:DA2D BD 00 C0    LDA $C000,x[$7E:C002]  ;|
$82:DA30 AA          TAX                    ;|
$82:DA31 AD 00 C4    LDA $C400  [$7E:C400]  ;} Palette colour = the [palette change numerator]th transitional colour from [palette colour] to [target palette colour]
$82:DA34 20 4A DA    JSR $DA4A  [$82:DA4A]  ;|
$82:DA37 AE 04 C4    LDX $C404  [$7E:C404]  ;|
$82:DA3A 9D 00 C0    STA $C000,x[$7E:C002]  ;/

$82:DA3D E8          INX                    ;\
$82:DA3E E8          INX                    ;} X += 2 (next palette colour)
$82:DA3F E0 00 02    CPX #$0200             ;\
$82:DA42 90 DD       BCC $DD    [$DA21]     ;} If [X] < 200h: go to LOOP
$82:DA44 EE 00 C4    INC $C400  [$7E:C400]  ; Increment palette change numerator
$82:DA47 AB          PLB
$82:DA48 18          CLC                    ;\
$82:DA49 60          RTS                    ;} Return carry clear
}


;;; $DA4A: Calculate the [A]th transitional colour from [X] to [Y] ;;;
{
;; Returns:
;;     A: Result colour

; The transition curve is an X-flipped reciprocal function (1/d, 1/(d-1), 1/(d-2), ..., 1/3, 1/2, 1)

; After pushes, we have:
;     $01 + [S]: Target colour
;     $03 + [S]: Source colour
;     $05 + [S]: Palette change numerator
;     $07 + [S]: Result colour
$82:DA4A 48          PHA
$82:DA4B 48          PHA
$82:DA4C DA          PHX
$82:DA4D 5A          PHY
$82:DA4E A3 01       LDA $01,s  [$7E:1FEA]  ;\
$82:DA50 29 1F 00    AND #$001F             ;|
$82:DA53 A8          TAY                    ;|
$82:DA54 A3 03       LDA $03,s  [$7E:1FEC]  ;|
$82:DA56 29 1F 00    AND #$001F             ;} $07 + [S] = [A]th transitional colour component from [X] & 1Fh to [Y] & 1Fh (red component)
$82:DA59 AA          TAX                    ;|
$82:DA5A A3 05       LDA $05,s  [$7E:1FEE]  ;|
$82:DA5C 20 A6 DA    JSR $DAA6  [$82:DAA6]  ;|
$82:DA5F 83 07       STA $07,s  [$7E:1FF0]  ;/
$82:DA61 A3 01       LDA $01,s  [$7E:1FEA]  ;\
$82:DA63 0A          ASL A                  ;|
$82:DA64 0A          ASL A                  ;|
$82:DA65 0A          ASL A                  ;|
$82:DA66 EB          XBA                    ;|
$82:DA67 29 1F 00    AND #$001F             ;|
$82:DA6A A8          TAY                    ;|
$82:DA6B A3 03       LDA $03,s  [$7E:1FEC]  ;|
$82:DA6D 0A          ASL A                  ;|
$82:DA6E 0A          ASL A                  ;|
$82:DA6F 0A          ASL A                  ;|
$82:DA70 EB          XBA                    ;} $07 + [S] |= ([A]th transitional colour component from [X] >> 5 & 1Fh to [Y] >> 5 & 1Fh) << 5 (green component)
$82:DA71 29 1F 00    AND #$001F             ;|
$82:DA74 AA          TAX                    ;|
$82:DA75 A3 05       LDA $05,s  [$7E:1FEE]  ;|
$82:DA77 20 A6 DA    JSR $DAA6  [$82:DAA6]  ;|
$82:DA7A 0A          ASL A                  ;|
$82:DA7B 0A          ASL A                  ;|
$82:DA7C 0A          ASL A                  ;|
$82:DA7D 0A          ASL A                  ;|
$82:DA7E 0A          ASL A                  ;|
$82:DA7F 03 07       ORA $07,s  [$7E:1FF0]  ;|
$82:DA81 83 07       STA $07,s  [$7E:1FF0]  ;/
$82:DA83 A3 01       LDA $01,s  [$7E:1FEA]  ;\
$82:DA85 4A          LSR A                  ;|
$82:DA86 4A          LSR A                  ;|
$82:DA87 EB          XBA                    ;|
$82:DA88 29 1F 00    AND #$001F             ;|
$82:DA8B A8          TAY                    ;|
$82:DA8C A3 03       LDA $03,s  [$7E:1FEC]  ;|
$82:DA8E 4A          LSR A                  ;|
$82:DA8F 4A          LSR A                  ;|
$82:DA90 EB          XBA                    ;} $07 + [S] |= ([A]th transitional colour component from [X] >> Ah & 1Fh to [Y] >> Ah & 1Fh) << Ah (blue component)
$82:DA91 29 1F 00    AND #$001F             ;|
$82:DA94 AA          TAX                    ;|
$82:DA95 A3 05       LDA $05,s  [$7E:1FEE]  ;|
$82:DA97 20 A6 DA    JSR $DAA6  [$82:DAA6]  ;|
$82:DA9A 0A          ASL A                  ;|
$82:DA9B 0A          ASL A                  ;|
$82:DA9C EB          XBA                    ;|
$82:DA9D 03 07       ORA $07,s  [$7E:1FF0]  ;|
$82:DA9F 83 07       STA $07,s  [$7E:1FF0]  ;/
$82:DAA1 7A          PLY
$82:DAA2 FA          PLX
$82:DAA3 68          PLA
$82:DAA4 68          PLA                    ; A = [$07 + [S]]
$82:DAA5 60          RTS
}


;;; $DAA6: Calculate the [A]th transitional colour component from [X] to [Y] ;;;
{
;; Returns:
;;     If [A] = 0:
;;         A = [X]
;;     If [A] = [palette change denominator] + 1:
;;         A = [Y]
;;     Otherwise:
;;         A = [X] + ([Y] - [X]) / ([palette change denominator] + 1 - [A])

; This routine is designed to be called iteratively with X = (last return value) and incrementing A.
; The resulting equation can be expressed as:
;      x_{t+1} = x_t + (y - x_t) / (d + 1 - t)
; where
;      t = [A]
;      x = [X]
;      y = [Y]
;      d = [palette change denominator]
; Solving this recurrence relation actually gives you:
;     x_t = x_0 + t (y - x_0) / d
; which is precisely what you would expect for a linear interpolation

$82:DAA6 C9 00 00    CMP #$0000             ;\
$82:DAA9 D0 02       BNE $02    [$DAAD]     ;} If [A] = 0:
$82:DAAB 8A          TXA                    ; A = [X]
$82:DAAC 60          RTS

$82:DAAD 3A          DEC A                  ;\
$82:DAAE CD 02 C4    CMP $C402  [$7E:C402]  ;} If [A] = [palette change denominator] + 1
$82:DAB1 D0 02       BNE $02    [$DAB5]     ;/
$82:DAB3 98          TYA                    ; A = [Y]
$82:DAB4 60          RTS

$82:DAB5 DA          PHX
$82:DAB6 1A          INC A
$82:DAB7 85 14       STA $14    [$7E:0014]  ;\
$82:DAB9 98          TYA                    ;|
$82:DABA 38          SEC                    ;|
$82:DABB E3 01       SBC $01,s  [$7E:1FE6]  ;|
$82:DABD 85 12       STA $12    [$7E:0012]  ;|
$82:DABF 10 04       BPL $04    [$DAC5]     ;|
$82:DAC1 49 FF FF    EOR #$FFFF             ;|
$82:DAC4 1A          INC A                  ;|
                                            ;|
$82:DAC5 EB          XBA                    ;|
$82:DAC6 29 00 FF    AND #$FF00             ;|
$82:DAC9 8F 04 42 00 STA $004204[$7E:4204]  ;|
$82:DACD E2 21       SEP #$21               ;|
$82:DACF AD 02 C4    LDA $C402  [$7E:C402]  ;|
$82:DAD2 E5 14       SBC $14    [$7E:0014]  ;} $12 = ([Y] - [X]) * 100h / ([palette change denominator] + 1 - [A])
$82:DAD4 1A          INC A                  ;|
$82:DAD5 8F 06 42 00 STA $004206[$7E:4206]  ;|
$82:DAD9 C2 20       REP #$20               ;|
$82:DADB EB          XBA                    ;|
$82:DADC EB          XBA                    ;|
$82:DADD EA          NOP                    ;|
$82:DADE EA          NOP                    ;|
$82:DADF AF 14 42 00 LDA $004214[$7E:4214]  ;|
$82:DAE3 24 12       BIT $12    [$7E:0012]  ;|
$82:DAE5 10 04       BPL $04    [$DAEB]     ;|
$82:DAE7 49 FF FF    EOR #$FFFF             ;|
$82:DAEA 1A          INC A                  ;|
                                            ;|
$82:DAEB 85 12       STA $12    [$7E:0012]  ;/
$82:DAED 68          PLA                    ;\
$82:DAEE EB          XBA                    ;|
$82:DAEF 18          CLC                    ;|
$82:DAF0 65 12       ADC $12    [$7E:0012]  ;} A = [X] + [$12] / 100h
$82:DAF2 EB          XBA                    ;|
$82:DAF3 29 FF 00    AND #$00FF             ;/
$82:DAF6 60          RTS
}


;;; $DAF7: Advance gradual colour change of palettes in [A] - denominator = Ch ;;;
{
;; Parameters:
;;     A: Bitset of palettes to advance
{
;;         1: BG palette 0
;;         2: BG palette 1
;;         4: BG palette 2
;;         8: BG palette 3
;;         10h: BG palette 4
;;         20h: BG palette 5
;;         40h: BG palette 6
;;         80h: BG palette 7
;;         100h: Sprite palette 0
;;         200h: Sprite palette 1
;;         400h: Sprite palette 2
;;         800h: Sprite palette 3
;;         1000h: Sprite palette 4
;;         2000h: Sprite palette 5
;;         4000h: Sprite palette 6
;;         8000h: Sprite palette 7
}
;; Returns:
;;     Carry: Set if reached target colour, clear otherwise

; Used by Torizo with sprite palettes 1 and 2
$82:DAF7 DA          PHX
$82:DAF8 5A          PHY
$82:DAF9 8B          PHB
$82:DAFA F4 7E 7E    PEA $7E7E              ;\
$82:DAFD AB          PLB                    ;} DB = $7E
$82:DAFE AB          PLB                    ;/
$82:DAFF A2 0C 00    LDX #$000C             ;\
$82:DB02 8E 02 C4    STX $C402  [$7E:C402]  ;} Palette change denominator = Ch
$82:DB05 20 0C DB    JSR $DB0C  [$82:DB0C]  ; Advance gradual colour change of palettes in [A]
$82:DB08 AB          PLB
$82:DB09 7A          PLY
$82:DB0A FA          PLX
$82:DB0B 6B          RTL
}


;;; $DB0C: Advance gradual colour change of palettes in [A] ;;;
{
;; Parameters:
;;     A: Bitset of palettes to advance
{
;;         1: BG palette 0
;;         2: BG palette 1
;;         4: BG palette 2
;;         8: BG palette 3
;;         10h: BG palette 4
;;         20h: BG palette 5
;;         40h: BG palette 6
;;         80h: BG palette 7
;;         100h: Sprite palette 0
;;         200h: Sprite palette 1
;;         400h: Sprite palette 2
;;         800h: Sprite palette 3
;;         1000h: Sprite palette 4
;;         2000h: Sprite palette 5
;;         4000h: Sprite palette 6
;;         8000h: Sprite palette 7
}
;; Returns:
;;     Carry: Set if reached target colour, clear otherwise

; DB must be set to $7E
$82:DB0C C2 30       REP #$30
$82:DB0E 48          PHA
$82:DB0F AD 02 C4    LDA $C402  [$7E:C402]  ;\
$82:DB12 1A          INC A                  ;|
$82:DB13 CD 00 C4    CMP $C400  [$7E:C400]  ;} If [palette change numerator] > [palette change denominator] + 1:
$82:DB16 B0 09       BCS $09    [$DB21]     ;/
$82:DB18 A9 00 00    LDA #$0000             ;\
$82:DB1B 8D 00 C4    STA $C400  [$7E:C400]  ;} Palette change numerator = 0
$82:DB1E 68          PLA
$82:DB1F 38          SEC                    ;\
$82:DB20 60          RTS                    ;} Return carry set

$82:DB21 9C 04 C4    STZ $C404  [$7E:C404]

; LOOP
$82:DB24 68          PLA
$82:DB25 F0 15       BEQ $15    [$DB3C]     ; If [A] = 0: go to BRANCH_RETURN
$82:DB27 4A          LSR A                  ; A >>= 1
$82:DB28 48          PHA
$82:DB29 B0 0B       BCS $0B    [$DB36]     ; If carry clear:
$82:DB2B AD 04 C4    LDA $C404  [$7E:C404]  ;\
$82:DB2E 69 20 00    ADC #$0020             ;} Colour index += 20h
$82:DB31 8D 04 C4    STA $C404  [$7E:C404]  ;/
$82:DB34 80 EE       BRA $EE    [$DB24]     ; Go to LOOP

$82:DB36 20 41 DB    JSR $DB41  [$82:DB41]  ; Advance gradual colour change of palette [X] / 20h
$82:DB39 80 E9       BRA $E9    [$DB24]     ; Go to LOOP

; Nothing points here
$82:DB3B 68          PLA

; BRANCH_RETURN
$82:DB3C EE 00 C4    INC $C400  [$7E:C400]  ; Increment palette change numerator
$82:DB3F 18          CLC                    ;\
$82:DB40 60          RTS                    ;} Return carry clear
}


;;; $DB41: Advance gradual colour change of palette [X] / 20h ;;;
{
$82:DB41 AE 04 C4    LDX $C404  [$7E:C404]  ; X = [colour index]

; LOOP
$82:DB44 BD 00 C2    LDA $C200,x[$7E:C320]  ;\
$82:DB47 DD 00 C0    CMP $C000,x[$7E:C120]  ;} If [palette colour] != [target palette colour]:
$82:DB4A F0 11       BEQ $11    [$DB5D]     ;/
$82:DB4C A8          TAY                    ;\
$82:DB4D BD 00 C0    LDA $C000,x[$7E:C122]  ;|
$82:DB50 AA          TAX                    ;|
$82:DB51 AD 00 C4    LDA $C400  [$7E:C400]  ;} Palette colour = the [palette change numerator]th transitional colour from [palette colour] to [target palette colour]
$82:DB54 20 4A DA    JSR $DA4A  [$82:DA4A]  ;|
$82:DB57 AE 04 C4    LDX $C404  [$7E:C404]  ;|
$82:DB5A 9D 00 C0    STA $C000,x[$7E:C122]  ;/

$82:DB5D E8          INX                    ;\
$82:DB5E E8          INX                    ;} X += 2 (next palette colour)
$82:DB5F 8E 04 C4    STX $C404  [$7E:C404]  ; Colour index = [X]
$82:DB62 8A          TXA                    ;\
$82:DB63 29 1F 00    AND #$001F             ;} If [X] % 20h != 0: go to LOOP
$82:DB66 D0 DC       BNE $DC    [$DB44]     ;/
$82:DB68 60          RTS
}
}


;;; $DB69: Handle Samus running out of health and increment game time ;;;
{
; The check at $DB95 is the cause of Samus not dying when spamming pause
$82:DB69 08          PHP
$82:DB6A C2 30       REP #$30
$82:DB6C AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$82:DB6F F0 02       BEQ $02    [$DB73]     ;} If [Samus health] > 0: go to BRANCH_TICK_GAME_TIME
$82:DB71 10 3F       BPL $3F    [$DBB2]     ;/

$82:DB73 AD C0 09    LDA $09C0  [$7E:09C0]  ;\
$82:DB76 89 01 00    BIT #$0001             ;} If [reserve health mode] = auto:
$82:DB79 F0 1A       BEQ $1A    [$DB95]     ;/
$82:DB7B AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:DB7E F0 15       BEQ $15    [$DB95]     ;} If [Samus reserve health] != 0:
$82:DB80 A9 00 80    LDA #$8000             ;\
$82:DB83 8D 78 0A    STA $0A78  [$7E:0A78]  ;} Freeze time
$82:DB86 A9 1B 00    LDA #$001B             ;\
$82:DB89 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 1Bh (reserve tanks auto)
$82:DB8C A9 1B 00    LDA #$001B             ;\
$82:DB8F 22 84 F0 90 JSL $90F084[$90:F084]  ;} Lock Samus for reserve tank
$82:DB93 80 1D       BRA $1D    [$DBB2]     ; Go to BRANCH_TICK_GAME_TIME

$82:DB95 AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:DB98 C9 08 00    CMP #$0008             ;} If [game state] != main gameplay:
$82:DB9B F0 02       BEQ $02    [$DB9F]     ;/
$82:DB9D 28          PLP
$82:DB9E 60          RTS                    ; Return

$82:DB9F A9 00 80    LDA #$8000             ;\
$82:DBA2 8D 78 0A    STA $0A78  [$7E:0A78]  ;} Freeze time
$82:DBA5 A9 11 00    LDA #$0011             ;\
$82:DBA8 22 84 F0 90 JSL $90F084[$90:F084]  ;} Set up Samus for death sequence
$82:DBAC A9 13 00    LDA #$0013             ;\
$82:DBAF 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 13h (death sequence, start)

; BRANCH_TICK_GAME_TIME
$82:DBB2 AD DA 09    LDA $09DA  [$7E:09DA]  ;\
$82:DBB5 18          CLC                    ;|
$82:DBB6 69 01 00    ADC #$0001             ;} Increment game time frames
$82:DBB9 8D DA 09    STA $09DA  [$7E:09DA]  ;/
$82:DBBC C9 3C 00    CMP #$003C             ;\
$82:DBBF 30 31       BMI $31    [$DBF2]     ;} If [game time frames] >= 60:
$82:DBC1 9C DA 09    STZ $09DA  [$7E:09DA]  ; Game timer frames = 0
$82:DBC4 AD DC 09    LDA $09DC  [$7E:09DC]  ;\
$82:DBC7 18          CLC                    ;|
$82:DBC8 69 01 00    ADC #$0001             ;} Increment game time seconds
$82:DBCB 8D DC 09    STA $09DC  [$7E:09DC]  ;/
$82:DBCE C9 3C 00    CMP #$003C             ;\
$82:DBD1 30 1F       BMI $1F    [$DBF2]     ;} If [game time seconds] >= 60:
$82:DBD3 9C DC 09    STZ $09DC  [$7E:09DC]  ; Game timer seconds = 0
$82:DBD6 AD DE 09    LDA $09DE  [$7E:09DE]  ;\
$82:DBD9 18          CLC                    ;|
$82:DBDA 69 01 00    ADC #$0001             ;} Increment game time minutes
$82:DBDD 8D DE 09    STA $09DE  [$7E:09DE]  ;/
$82:DBE0 C9 3C 00    CMP #$003C             ;\
$82:DBE3 30 0D       BMI $0D    [$DBF2]     ;} If [game time minutes] >= 60:
$82:DBE5 9C DE 09    STZ $09DE  [$7E:09DE]  ; Game timer minutes = 0
$82:DBE8 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$82:DBEB 18          CLC                    ;|
$82:DBEC 69 01 00    ADC #$0001             ;} Increment game time hours
$82:DBEF 8D E0 09    STA $09E0  [$7E:09E0]  ;/

$82:DBF2 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$82:DBF5 C9 64 00    CMP #$0064             ;} If [game time hours] < 100:
$82:DBF8 10 02       BPL $02    [$DBFC]     ;/
$82:DBFA 28          PLP
$82:DBFB 60          RTS                    ; Return

$82:DBFC A9 3B 00    LDA #$003B             ;\
$82:DBFF 8D DA 09    STA $09DA  [$7E:09DA]  ;|
$82:DC02 8D DC 09    STA $09DC  [$7E:09DC]  ;|
$82:DC05 8D DE 09    STA $09DE  [$7E:09DE]  ;} Game time = 99:59:59.59
$82:DC08 A9 63 00    LDA #$0063             ;|
$82:DC0B 8D E0 09    STA $09E0  [$7E:09E0]  ;/
$82:DC0E 28          PLP
$82:DC0F 60          RTS
}


;;; $DC10: Game state 1Bh (reserve tank auto) ;;;
{
$82:DC10 08          PHP
$82:DC11 C2 30       REP #$30
$82:DC13 20 31 DC    JSR $DC31  [$82:DC31]  ; Reserve tank auto refill
$82:DC16 90 10       BCC $10    [$DC28]     ; If finished refill:
$82:DC18 9C 78 0A    STZ $0A78  [$7E:0A78]  ; Unfreeze time
$82:DC1B A9 08 00    LDA #$0008             ;\
$82:DC1E 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 8 (main gameplay)
$82:DC21 A9 10 00    LDA #$0010             ;\
$82:DC24 22 84 F0 90 JSL $90F084[$90:F084]  ;} Unlock Samus from reserve tank

$82:DC28 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:DC2B 22 AB EA 90 JSL $90EAAB[$90:EAAB]  ; Low health check
$82:DC2F 28          PLP
$82:DC30 60          RTS
}


;;; $DC31: Reserve tank auto refill ;;;
{
;; Returns:
;;     Carry: Set if finished refill (i.e. reserve health has been depleted)
$82:DC31 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:DC34 F0 41       BEQ $41    [$DC77]     ;} If [Samus reserve health] = 0: go to BRANCH_RETURN
$82:DC36 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$82:DC39 89 07 00    BIT #$0007             ;} If [frame counter] % 8 = 0:
$82:DC3C D0 07       BNE $07    [$DC45]     ;/
$82:DC3E A9 2D 00    LDA #$002D             ;\
$82:DC41 22 39 91 80 JSL $809139[$80:9139]  ;} Queue sound 2Dh, sound library 3, max queued sounds allowed = 3 (gaining/losing incremental health)

$82:DC45 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$82:DC48 18          CLC                    ;|
$82:DC49 69 01 00    ADC #$0001             ;} Samus health += 1
$82:DC4C 8D C2 09    STA $09C2  [$7E:09C2]  ;/
$82:DC4F CD C4 09    CMP $09C4  [$7E:09C4]  ;\
$82:DC52 30 08       BMI $08    [$DC5C]     ;} If [Samus health] >= [Samus max health]:
$82:DC54 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$82:DC57 8D C2 09    STA $09C2  [$7E:09C2]  ;} Samus health = [Samus max health]
$82:DC5A 80 18       BRA $18    [$DC74]

$82:DC5C AD D6 09    LDA $09D6  [$7E:09D6]  ;\ Else ([Samus health] < [Samus max health]):
$82:DC5F 38          SEC                    ;|
$82:DC60 E9 01 00    SBC #$0001             ;} Samus reserve health -= 1
$82:DC63 8D D6 09    STA $09D6  [$7E:09D6]  ;/
$82:DC66 F0 0C       BEQ $0C    [$DC74]     ; If [Samus reserve health] != 0:
$82:DC68 10 0D       BPL $0D    [$DC77]     ; If [Samus reserve health] > 0: go to BRANCH_RETURN
$82:DC6A AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$82:DC6D 18          CLC                    ;|
$82:DC6E 6D D6 09    ADC $09D6  [$7E:09D6]  ;} Samus health += [Samus reserve health] <-- this is dead code
$82:DC71 8D C2 09    STA $09C2  [$7E:09C2]  ;/

$82:DC74 9C D6 09    STZ $09D6  [$7E:09D6]  ; Samus reserve health = 0

; BRANCH_RETURN
$82:DC77 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$82:DC7A D0 02       BNE $02    [$DC7E]     ;} If [Samus reserve health] = 0:
$82:DC7C 38          SEC                    ;\
$82:DC7D 60          RTS                    ;} Return carry set

$82:DC7E 18          CLC                    ;\
$82:DC7F 60          RTS                    ;} Return carry clear
}


;;; $DC80: Game state 13h (death sequence, start) ;;;
{
$82:DC80 08          PHP
$82:DC81 C2 30       REP #$30
$82:DC83 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:DC86 A2 FE 01    LDX #$01FE             ;\
                                            ;|
$82:DC89 BF 00 C0 7E LDA $7EC000,x[$7E:C1FE];|
$82:DC8D 9F 00 33 7E STA $7E3300,x[$7E:34FE];} $7E:3300..34FF = [palettes]
$82:DC91 CA          DEX                    ;|
$82:DC92 CA          DEX                    ;|
$82:DC93 10 F4       BPL $F4    [$DC89]     ;/
$82:DC95 A2 7E 01    LDX #$017E             ;\
$82:DC98 A9 00 00    LDA #$0000             ;|
                                            ;|
$82:DC9B 9F 00 C2 7E STA $7EC200,x[$7E:C37E];|
$82:DC9F CA          DEX                    ;|
$82:DCA0 CA          DEX                    ;|
$82:DCA1 10 F8       BPL $F8    [$DC9B]     ;|
$82:DCA3 A2 5E 00    LDX #$005E             ;} Target palettes = 0
$82:DCA6 A9 00 00    LDA #$0000             ;|
                                            ;|
$82:DCA9 9F A0 C3 7E STA $7EC3A0,x[$7E:C3FE];|
$82:DCAD CA          DEX                    ;|
$82:DCAE CA          DEX                    ;|
$82:DCAF 10 F8       BPL $F8    [$DCA9]     ;/
$82:DCB1 A2 1E 00    LDX #$001E             ;\
                                            ;|
$82:DCB4 BF 80 C1 7E LDA $7EC180,x[$7E:C19E];|
$82:DCB8 9F 80 C3 7E STA $7EC380,x[$7E:C39E];} Target sprite palette 4 = [sprite palette 4]
$82:DCBC CA          DEX                    ;|
$82:DCBD CA          DEX                    ;|
$82:DCBE 10 F4       BPL $F4    [$DCB4]     ;/
$82:DCC0 A9 03 00    LDA #$0003
$82:DCC3 8D E2 0D    STA $0DE2  [$7E:0DE2]
$82:DCC6 9C E4 0D    STZ $0DE4  [$7E:0DE4]
$82:DCC9 9C E6 0D    STZ $0DE6  [$7E:0DE6]
$82:DCCC 9C E8 0D    STZ $0DE8  [$7E:0DE8]
$82:DCCF 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing
$82:DCD2 9C 04 0A    STZ $0A04  [$7E:0A04]  ; Auto-cancel HUD item index = nothing
$82:DCD5 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$82:DCD8 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knockback timer = 0
$82:DCDB EE 98 09    INC $0998  [$7E:0998]  ; Game state = 14h (death sequence, black out surroundings)
$82:DCDE 28          PLP
$82:DCDF 60          RTS
}


;;; $DCE0: Game state 14h (death sequence, black out surroundings) ;;;
{
$82:DCE0 08          PHP
$82:DCE1 C2 30       REP #$30
$82:DCE3 20 44 8B    JSR $8B44  [$82:8B44]  ; Main gameplay
$82:DCE6 A9 06 00    LDA #$0006             ;\
$82:DCE9 8F 02 C4 7E STA $7EC402[$7E:C402]  ;} Palette change denominator = 6
$82:DCED 20 02 DA    JSR $DA02  [$82:DA02]  ; Advance gradual colour change of all palettes
$82:DCF0 B0 02       BCS $02    [$DCF4]     ; If not reached target colour:
$82:DCF2 28          PLP
$82:DCF3 60          RTS                    ; Return

$82:DCF4 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$82:DCF8 22 5F 98 80 JSL $80985F[$80:985F]  ; Disable h/v-counter interrupts
$82:DCFC 9C 82 19    STZ $1982  [$7E:1982]  ; Default layer blending configuration = 0
$82:DCFF 64 AB       STZ $AB    [$7E:00AB]  ; Interrupt command = nothing
$82:DD01 E2 20       SEP #$20
$82:DD03 64 6E       STZ $6E    [$7E:006E]  ;\
$82:DD05 64 71       STZ $71    [$7E:0071]  ;} Disable colour math
$82:DD07 A9 10       LDA #$10               ;\
$82:DD09 85 69       STA $69    [$7E:0069]  ;} Main screen layers = sprites
$82:DD0B 64 6B       STZ $6B    [$7E:006B]  ; Disable subscreen layers
$82:DD0D 64 6C       STZ $6C    [$7E:006C]  ;\
$82:DD0F 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area
$82:DD11 A9 09       LDA #$09               ;\
$82:DD13 85 55       STA $55    [$7E:0055]  ;} Use mode 1 with BG3 priority and 8x8 tile sizes
$82:DD15 C2 20       REP #$20
$82:DD17 9C E2 0D    STZ $0DE2  [$7E:0DE2]  ; >_<;
$82:DD1A 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:DD1D 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:DD20 A2 FE 00    LDX #$00FE             ;\
                                            ;|
$82:DD23 9E 8D 1A    STZ $1A8D,x[$7E:1B8B]  ;|
$82:DD26 CA          DEX                    ;} $1A8D..1B8C = 0
$82:DD27 CA          DEX                    ;|
$82:DD28 10 F9       BPL $F9    [$DD23]     ;/
$82:DD2A A9 10 00    LDA #$0010             ;\
$82:DD2D 8D E8 0D    STA $0DE8  [$7E:0DE8]  ;} Death animation pre-flashing timer = 10h
$82:DD30 A9 03 00    LDA #$0003             ;\
$82:DD33 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Death animation timer = 3
$82:DD36 9C E4 0D    STZ $0DE4  [$7E:0DE4]  ; Death animation index = 0
$82:DD39 9C E6 0D    STZ $0DE6  [$7E:0DE6]  ; Death animation counter = 0
$82:DD3C EE 98 09    INC $0998  [$7E:0998]  ; Game state = 15h (death sequence, wait for music)
$82:DD3F 9C 92 05    STZ $0592  [$7E:0592]  ; Power bomb explosion status = 0
$82:DD42 A9 02 00    LDA #$0002             ;\
$82:DD45 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 15 (silence)
$82:DD49 A9 71 00    LDA #$0071             ;\
$82:DD4C 22 A3 90 80 JSL $8090A3[$80:90A3]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 15 (silence)
$82:DD50 A9 01 00    LDA #$0001             ;\
$82:DD53 22 25 91 80 JSL $809125[$80:9125]  ;} Queue sound 1, sound library 3, max queued sounds allowed = 15 (silence)
$82:DD57 A9 00 00    LDA #$0000             ;\
$82:DD5A 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$82:DD5E A9 39 FF    LDA #$FF39             ;\
$82:DD61 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue death music data
$82:DD65 A9 05 00    LDA #$0005             ;\
$82:DD68 A0 0E 00    LDY #$000E             ;} Queue song 0 music track, 14 frame delay
$82:DD6B 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/
$82:DD6F 28          PLP
$82:DD70 60          RTS
}


;;; $DD71: Game state 15h (death sequence, wait for music) ;;;
{
$82:DD71 08          PHP
$82:DD72 C2 30       REP #$30
$82:DD74 22 00 8A 90 JSL $908A00[$90:8A00]  ; Draw inanimate Samus
$82:DD78 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$82:DD7C B0 07       BCS $07    [$DD85]     ;} If music is queued: return
$82:DD7E 22 A7 B3 9B JSL $9BB3A7[$9B:B3A7]  ; Set Samus death sequence pose
$82:DD82 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 16h (death sequence, pre-flashing)

$82:DD85 28          PLP
$82:DD86 60          RTS
}


;;; $DD87: Game state 16h (death sequence, pre-flashing) ;;;
{
; Death animation pre-flashing timer is initialised to 10h by $DCE0
$82:DD87 08          PHP
$82:DD88 C2 30       REP #$30
$82:DD8A 22 3C B4 9B JSL $9BB43C[$9B:B43C]  ; Draw Samus starting death animation
$82:DD8E CE E8 0D    DEC $0DE8  [$7E:0DE8]  ; Decrement death animation pre-flashing timer
$82:DD91 F0 02       BEQ $02    [$DD95]     ;\
$82:DD93 10 03       BPL $03    [$DD98]     ;} If [death animation pre-flashing timer] > 0: return

$82:DD95 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 17h (death sequence, flashing)

$82:DD98 28          PLP
$82:DD99 60          RTS
}


;;; $DD9A: Game state 17h (death sequence, flashing) ;;;
{
$82:DD9A 08          PHP
$82:DD9B C2 30       REP #$30
$82:DD9D 22 41 B4 9B JSL $9BB441[$9B:B441]  ; Handle death animation flashing
$82:DDA1 AA          TAX                    ;\
$82:DDA2 F0 05       BEQ $05    [$DDA9]     ;} If flashing has ended:
$82:DDA4 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 18h (death sequence, explosion white out)
$82:DDA7 80 04       BRA $04    [$DDAD]     ; Return

$82:DDA9 22 98 89 90 JSL $908998[$90:8998]  ; Draw Samus during death animation

$82:DDAD 28          PLP
$82:DDAE 60          RTS
}


;;; $DDAF: Game state 18h (death sequence, explosion white out) ;;;
{
$82:DDAF 08          PHP
$82:DDB0 C2 30       REP #$30
$82:DDB2 22 01 B7 9B JSL $9BB701[$9B:B701]  ; Handle death sequence suit explosion white out
$82:DDB6 AA          TAX                    ;\
$82:DDB7 F0 0C       BEQ $0C    [$DDC5]     ;} If finished:
$82:DDB9 A9 01 00    LDA #$0001             ;\
$82:DDBC 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$82:DDBF 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$82:DDC2 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 19h (death sequence, black out)

$82:DDC5 28          PLP
$82:DDC6 60          RTS
}


;;; $DDC7: Game state 19h (death sequence, black out) ;;;
{
; Also cut to by timeup death
$82:DDC7 08          PHP
$82:DDC8 C2 30       REP #$30
$82:DDCA 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:DDCE E2 20       SEP #$20
$82:DDD0 A5 51       LDA $51    [$7E:0051]  ;\
$82:DDD2 C9 80       CMP #$80               ;} If not finished fading out: return
$82:DDD4 D0 17       BNE $17    [$DDED]     ;/
$82:DDD6 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:DDDA C2 20       REP #$20
$82:DDDC 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:DDDF 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:DDE2 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 1Ah (game over screen)
$82:DDE5 9C 27 07    STZ $0727  [$7E:0727]  ; Menu index = 0
$82:DDE8 9C F5 05    STZ $05F5  [$7E:05F5]  ; Enable sounds
$82:DDEB 28          PLP
$82:DDEC 60          RTS                    ; Return

$82:DDED C2 20       REP #$20               ; >_<;
$82:DDEF 28          PLP
$82:DDF0 60          RTS
}


;;; $DDF1..E97B: Door transition ;;;
{
;;; $DDF1: Load destination room CRE bitset ;;;
{
$82:DDF1 8B          PHB
$82:DDF2 DA          PHX
$82:DDF3 F4 00 8F    PEA $8F00              ;\
$82:DDF6 AB          PLB                    ;} DB = $8F
$82:DDF7 AB          PLB                    ;/
$82:DDF8 AE 8D 07    LDX $078D  [$7E:078D]  ;\
$82:DDFB BF 00 00 83 LDA $830000,x[$83:AB58];} X = (destination room pointer)
$82:DDFF AA          TAX                    ;/
$82:DE00 AD B3 07    LDA $07B3  [$7E:07B3]  ;\
$82:DE03 8D B1 07    STA $07B1  [$7E:07B1]  ;} Previous CRE bitset = [CRE bitset]
$82:DE06 BD 08 00    LDA $0008,x[$8F:DF4D]  ;\
$82:DE09 29 FF 00    AND #$00FF             ;} CRE bitset = [[X] + 8] (destination room's CRE bitset)
$82:DE0C 8D B3 07    STA $07B3  [$7E:07B3]  ;/
$82:DE0F FA          PLX
$82:DE10 AB          PLB
$82:DE11 60          RTS
}


;;; $DE12: Load door header ;;;
{
; Regarding door transition speed.
; For speed s, the distance Samus is moved is 40h * s and 38h * s pixels total for horizontal and vertical transitions respectively
; With the default speeds of 0.C8h and 1.80h, that's 32h and 54h pixels distance respectively
$82:DE12 F4 00 83    PEA $8300              ;\
$82:DE15 AB          PLB                    ;} DB = $83
$82:DE16 AB          PLB                    ;/
$82:DE17 AE 8D 07    LDX $078D  [$7E:078D]  ; X = [door pointer]
$82:DE1A BD 00 00    LDA $0000,x[$83:AB58]  ;\
$82:DE1D 8D 9B 07    STA $079B  [$7E:079B]  ;} Room pointer = [[X]]
$82:DE20 BD 02 00    LDA $0002,x[$83:AB5A]  ;\
$82:DE23 8D 93 07    STA $0793  [$7E:0793]  ;} Elevator door properties = [[X] + 2]
$82:DE26 29 80 00    AND #$0080             ;\
$82:DE29 8D 16 0E    STA $0E16  [$7E:0E16]  ;} Elevator properties = [door flags] & 80h
$82:DE2C BD 03 00    LDA $0003,x[$83:AB5B]  ;\
$82:DE2F 29 FF 00    AND #$00FF             ;} Door orientation = [[X] + 3]
$82:DE32 8D 91 07    STA $0791  [$7E:0791]  ;/
$82:DE35 BD 06 00    LDA $0006,x[$83:AB5E]  ;\
$82:DE38 29 FF 00    AND #$00FF             ;|
$82:DE3B EB          XBA                    ;} Door destination X position = [[X] + 6] * 100h
$82:DE3C 8D 27 09    STA $0927  [$7E:0927]  ;/
$82:DE3F BD 07 00    LDA $0007,x[$83:AB5F]  ;\
$82:DE42 29 FF 00    AND #$00FF             ;|
$82:DE45 EB          XBA                    ;} Door destination Y position = [[X] + 7] * 100h
$82:DE46 8D 29 09    STA $0929  [$7E:0929]  ;/
$82:DE49 64 12       STZ $12    [$7E:0012]
$82:DE4B 64 14       STZ $14    [$7E:0014]
$82:DE4D BD 08 00    LDA $0008,x[$83:AB60]  ; A = [[X] + 8]
$82:DE50 10 10       BPL $10    [$DE62]     ; If [A] >= 0: go to BRANCH_POSITIVE
$82:DE52 AD 91 07    LDA $0791  [$7E:0791]  ;\
$82:DE55 89 02 00    BIT #$0002             ;} If door orientation is horizontal:
$82:DE58 D0 05       BNE $05    [$DE5F]     ;/
$82:DE5A A9 C8 00    LDA #$00C8             ; A = C8h
$82:DE5D 80 03       BRA $03    [$DE62]

                                            ; Else (door orientation is vertical):
$82:DE5F A9 80 01    LDA #$0180             ; A = 180h

; BRANCH_POSITIVE
$82:DE62 85 13       STA $13    [$7E:0013]  ;\
$82:DE64 A5 12       LDA $12    [$7E:0012]  ;|
$82:DE66 8D 2B 09    STA $092B  [$7E:092B]  ;} Door transition speed = [A] / 100h
$82:DE69 A5 14       LDA $14    [$7E:0014]  ;|
$82:DE6B 8D 2D 09    STA $092D  [$7E:092D]  ;/
$82:DE6E 60          RTS
}


;;; $DE6F: Load room header ;;;
{
$82:DE6F F4 00 8F    PEA $8F00              ;\
$82:DE72 AB          PLB                    ;} DB = $8F
$82:DE73 AB          PLB                    ;/
$82:DE74 AE 9B 07    LDX $079B  [$7E:079B]  ; X = [room pointer]
$82:DE77 BD 00 00    LDA $0000,x[$8F:DF45]  ;\
$82:DE7A 29 FF 00    AND #$00FF             ;} Room index = [[X]]
$82:DE7D 8D 9D 07    STA $079D  [$7E:079D]  ;/
$82:DE80 BD 01 00    LDA $0001,x[$8F:DF46]  ;\
$82:DE83 29 FF 00    AND #$00FF             ;} Area index = [[X] + 1]
$82:DE86 8D 9F 07    STA $079F  [$7E:079F]  ;/
$82:DE89 BD 02 00    LDA $0002,x[$8F:DF47]  ;\
$82:DE8C 29 FF 00    AND #$00FF             ;} Room X co-ordinate = [[X] + 2]
$82:DE8F 8D A1 07    STA $07A1  [$7E:07A1]  ;/
$82:DE92 BD 03 00    LDA $0003,x[$8F:DF48]  ;\
$82:DE95 29 FF 00    AND #$00FF             ;} Room Y co-ordinate = [[X] + 3]
$82:DE98 8D A3 07    STA $07A3  [$7E:07A3]  ;/
$82:DE9B BD 04 00    LDA $0004,x[$8F:DF49]  ;\
$82:DE9E 29 FF 00    AND #$00FF             ;} Room width in scrolls = [[X] + 4]
$82:DEA1 8D A9 07    STA $07A9  [$7E:07A9]  ;/
$82:DEA4 0A          ASL A                  ;\
$82:DEA5 0A          ASL A                  ;|
$82:DEA6 0A          ASL A                  ;} Room width in blocks = [[X] + 4] * 10h
$82:DEA7 0A          ASL A                  ;|
$82:DEA8 8D A5 07    STA $07A5  [$7E:07A5]  ;/
$82:DEAB BD 05 00    LDA $0005,x[$8F:DF4A]  ;\
$82:DEAE 29 FF 00    AND #$00FF             ;} Room height in scrolls = [[X] + 5]
$82:DEB1 8D AB 07    STA $07AB  [$7E:07AB]  ;/
$82:DEB4 0A          ASL A                  ;\
$82:DEB5 0A          ASL A                  ;|
$82:DEB6 0A          ASL A                  ;} Room height in blocks = [[X] + ] * 10h
$82:DEB7 0A          ASL A                  ;|
$82:DEB8 8D A7 07    STA $07A7  [$7E:07A7]  ;/
$82:DEBB BD 06 00    LDA $0006,x[$8F:DF4B]  ;\
$82:DEBE 29 FF 00    AND #$00FF             ;} Up scroller = [[X] + 6]
$82:DEC1 8D AD 07    STA $07AD  [$7E:07AD]  ;/
$82:DEC4 BD 07 00    LDA $0007,x[$8F:DF4C]  ;\
$82:DEC7 29 FF 00    AND #$00FF             ;} Down scroller = [[X] + 7]
$82:DECA 8D AF 07    STA $07AF  [$7E:07AF]  ;/
$82:DECD BD 09 00    LDA $0009,x[$8F:DF4E]  ;\
$82:DED0 8D B5 07    STA $07B5  [$7E:07B5]  ;} Door list pointer = [[X] + 9]
$82:DED3 22 D2 E5 8F JSL $8FE5D2[$8F:E5D2]  ; Room state checking handler
$82:DED7 E2 20       SEP #$20               ;\
$82:DED9 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$82:DEDC 8D 02 42    STA $4202  [$7E:4202]  ;|
$82:DEDF AD A7 07    LDA $07A7  [$7E:07A7]  ;|
$82:DEE2 8D 03 42    STA $4203  [$7E:4203]  ;|
$82:DEE5 C2 20       REP #$20               ;|
$82:DEE7 EA          NOP                    ;} Level data size = [room width in blocks] * [room height in blocks] * 2
$82:DEE8 EA          NOP                    ;|
$82:DEE9 EA          NOP                    ;|
$82:DEEA AD 16 42    LDA $4216  [$7E:4216]  ;|
$82:DEED 0A          ASL A                  ;|
$82:DEEE 8D B9 07    STA $07B9  [$7E:07B9]  ;/
$82:DEF1 60          RTS
}


;;; $DEF2: Load state header ;;;
{
$82:DEF2 F4 00 8F    PEA $8F00
$82:DEF5 AB          PLB
$82:DEF6 AB          PLB
$82:DEF7 AE BB 07    LDX $07BB  [$7E:07BB]  ;\
$82:DEFA BD 03 00    LDA $0003,x[$8F:DF5A]  ;|
$82:DEFD 29 FF 00    AND #$00FF             ;|
$82:DF00 0A          ASL A                  ;} X = [$8F:E7A7 + (graphic set) * 2]
$82:DF01 A8          TAY                    ;|
$82:DF02 BE A7 E7    LDX $E7A7,y[$8F:E7C9]  ;/
$82:DF05 BD 01 00    LDA $0001,x[$8F:E73C]  ;\
$82:DF08 8D C1 07    STA $07C1  [$7E:07C1]  ;|
$82:DF0B BD 00 00    LDA $0000,x[$8F:E73B]  ;} Room tile table pointer = [[X]]
$82:DF0E 8D C0 07    STA $07C0  [$7E:07C0]  ;/
$82:DF11 BD 04 00    LDA $0004,x[$8F:E73F]  ;\
$82:DF14 8D C4 07    STA $07C4  [$7E:07C4]  ;|
$82:DF17 BD 03 00    LDA $0003,x[$8F:E73E]  ;} Room tiles pointer = [[X] + 3]
$82:DF1A 8D C3 07    STA $07C3  [$7E:07C3]  ;/
$82:DF1D BD 07 00    LDA $0007,x[$8F:E742]  ;\
$82:DF20 8D C7 07    STA $07C7  [$7E:07C7]  ;|
$82:DF23 BD 06 00    LDA $0006,x[$8F:E741]  ;} Room tilemap pointer = [[X] + 6]
$82:DF26 8D C6 07    STA $07C6  [$7E:07C6]  ;/
$82:DF29 AE BB 07    LDX $07BB  [$7E:07BB]  ; X = room state pointer
$82:DF2C BD 01 00    LDA $0001,x[$8F:DF58]  ;\
$82:DF2F 8D BE 07    STA $07BE  [$7E:07BE]  ;|
$82:DF32 BD 00 00    LDA $0000,x[$8F:DF57]  ;} Level data pointer = [[X]]
$82:DF35 8D BD 07    STA $07BD  [$7E:07BD]  ;/
$82:DF38 BD 04 00    LDA $0004,x[$8F:DF5B]  ;\
$82:DF3B 29 FF 00    AND #$00FF             ;} Music data index = [[X] + 4]
$82:DF3E 8D CB 07    STA $07CB  [$7E:07CB]  ;/
$82:DF41 BD 05 00    LDA $0005,x[$8F:DF5C]  ;\
$82:DF44 29 FF 00    AND #$00FF             ;} Music track index = [[X] + 5]
$82:DF47 8D C9 07    STA $07C9  [$7E:07C9]  ;/
$82:DF4A BD 06 00    LDA $0006,x[$8F:DF5D]  ;\
$82:DF4D 8D CD 07    STA $07CD  [$7E:07CD]  ;} FX pointer = [[X] + 6]
$82:DF50 BD 08 00    LDA $0008,x[$8F:DF5F]  ;\
$82:DF53 8D CF 07    STA $07CF  [$7E:07CF]  ;} Enemy population pointer = [[X] + 8]
$82:DF56 BD 0A 00    LDA $000A,x[$8F:DF61]  ;\
$82:DF59 8D D1 07    STA $07D1  [$7E:07D1]  ;} Enemy set pointer = [[X] + Ah]
$82:DF5C BD 0C 00    LDA $000C,x[$8F:DF63]  ;\
$82:DF5F 8D 1B 09    STA $091B  [$7E:091B]  ;} Layer 2 scroll = [[X] + Ch]
$82:DF62 BD 12 00    LDA $0012,x[$8F:DF69]  ;\
$82:DF65 8D DF 07    STA $07DF  [$7E:07DF]  ;} Room main ASM = [[X] + 12h]
$82:DF68 60          RTS
}


;;; $DF69: Wait until the end of a v-blank and enable h/v-counter interrupts ;;;
{
$82:DF69 08          PHP
$82:DF6A E2 20       SEP #$20
$82:DF6C 22 C5 82 80 JSL $8082C5[$80:82C5]  ; Wait until the end of a v-blank
$82:DF70 A5 84       LDA $84    [$7E:0084]  ;\
$82:DF72 29 30       AND #$30               ;|
$82:DF74 C9 30       CMP #$30               ;} If h/v-counter interrupts are not both enabled:
$82:DF76 F0 04       BEQ $04    [$DF7C]     ;/
$82:DF78 22 41 98 80 JSL $809841[$80:9841]  ; Enable h/v-counter interrupts now

$82:DF7C C2 20       REP #$20               ; >_<;
$82:DF7E 28          PLP
$82:DF7F 60          RTS
}


;;; $DF80: Much ado about nothing ;;;
{
; This code is painfully redundant.
; It first checks whether the first byte of the function $80:982A is the same as the first byte of this function.
; These two bytes are both `PHP`, so the branch is always taken; even if the branch wasn't taken,
; it's completely pointless to disable h/v-counter interrupts only to enable them straight after.
; And of course there's a `REP #$20` just before a `PLP`
$82:DF80 08          PHP
$82:DF81 E2 20       SEP #$20
$82:DF83 AF 2A 98 80 LDA $80982A[$80:982A]  ;\
$82:DF87 CF 80 DF 82 CMP $82DF80[$82:DF80]  ;} If `PHP` != `PHP`:
$82:DF8B F0 08       BEQ $08    [$DF95]     ;/
$82:DF8D 22 5F 98 80 JSL $80985F[$80:985F]  ; Disable h/v-counter interrupts
$82:DF91 22 2A 98 80 JSL $80982A[$80:982A]  ; Enable h/v-counter interrupts

$82:DF95 C2 20       REP #$20
$82:DF97 28          PLP
$82:DF98 60          RTS
}


;;; $DF99: Save map explored if elevator ;;;
{
$82:DF99 AD 93 07    LDA $0793  [$7E:0793]  ;\
$82:DF9C 29 0F 00    AND #$000F             ;} A = [elevator door properties] & Fh (elevator index to mark as used)
$82:DF9F F0 04       BEQ $04    [$DFA5]     ; If [A] != 0:
$82:DFA1 22 07 CD 80 JSL $80CD07[$80:CD07]  ; Set elevators as used

$82:DFA5 AE 8D 07    LDX $078D  [$7E:078D]  ;\
$82:DFA8 BF 02 00 83 LDA $830002,x[$83:AB4E];|
$82:DFAC 89 40 00    BIT #$0040             ;} If [elevator door properties] & 40h != 0:
$82:DFAF F0 04       BEQ $04    [$DFB5]     ;/
$82:DFB1 22 C6 85 80 JSL $8085C6[$80:85C6]  ; Mirror current area's map explored

$82:DFB5 60          RTS
}


;;; $DFB6: Load map explored if elevator ;;;
{
$82:DFB6 AE 8D 07    LDX $078D  [$7E:078D]  ;\
$82:DFB9 BF 02 00 83 LDA $830002,x[$83:AB4E];|
$82:DFBD 89 40 00    BIT #$0040             ;} If [elevator door properties] & 40h != 0:
$82:DFC0 F0 04       BEQ $04    [$DFC6]     ;/
$82:DFC2 22 8C 85 80 JSL $80858C[$80:858C]  ; Load mirror of current area's map explored

$82:DFC6 60          RTS
}


;;; $DFC7: Draw inanimate Samus ;;;
{
; Elevator drawing of Samus is done by $90:EC14
$82:DFC7 AD 16 0E    LDA $0E16  [$7E:0E16]  ;\
$82:DFCA D0 04       BNE $04    [$DFD0]     ;} If door is an elevator: return
$82:DFCC 22 00 8A 90 JSL $908A00[$90:8A00]  ; Draw inanimate Samus

$82:DFD0 60          RTS
}


;;; $DFD1: Load enemy GFX to VRAM ;;;
{
$82:DFD1 A9 00 70    LDA #$7000             ;\
$82:DFD4 85 12       STA $12    [$7E:0012]  ;} $12 = $7000 (tile data VRAM destination)
$82:DFD6 AE D1 07    LDX $07D1  [$7E:07D1]  ;\
$82:DFD9 F0 5D       BEQ $5D    [$E038]     ;} If [enemy set pointer] = 0: return
$82:DFDB 9B          TXY

; LOOP
$82:DFDC BF 00 00 B4 LDA $B40000,x[$B4:9226];\
$82:DFE0 C9 FF FF    CMP #$FFFF             ;} If (enemy ID) = $FFFF: return
$82:DFE3 F0 53       BEQ $53    [$E038]     ;/
$82:DFE5 AA          TAX                    ;\
$82:DFE6 BF 36 00 A0 LDA $A00036,x[$A0:E275];|
$82:DFEA 8D C0 05    STA $05C0  [$7E:05C0]  ;} Door transition VRAM update source = (enemy tile data pointer)
$82:DFED BF 37 00 A0 LDA $A00037,x[$A0:E276];|
$82:DFF1 8D C1 05    STA $05C1  [$7E:05C1]  ;/
$82:DFF4 BF 00 00 A0 LDA $A00000,x[$A0:E23F];\
$82:DFF8 30 14       BMI $14    [$E00E]     ;} If (enemy tile data size) & 8000h = 0:
$82:DFFA 8D C3 05    STA $05C3  [$7E:05C3]  ; Door transition VRAM update size = (enemy tile data size)
$82:DFFD A5 12       LDA $12    [$7E:0012]  ;\
$82:DFFF 8D BE 05    STA $05BE  [$7E:05BE]  ;} Door transition VRAM update destination = [$12]
$82:E002 BF 00 00 A0 LDA $A00000,x[$A0:E13F];\
$82:E006 4A          LSR A                  ;|
$82:E007 18          CLC                    ;} $12 += (enemy tile data size) / 2
$82:E008 65 12       ADC $12    [$7E:0012]  ;|
$82:E00A 85 12       STA $12    [$7E:0012]  ;/
$82:E00C 80 18       BRA $18    [$E026]

$82:E00E 29 FF 7F    AND #$7FFF             ;\ Else ((enemy tile data size) & 8000h != 0):
$82:E011 8D C3 05    STA $05C3  [$7E:05C3]  ;} Door transition VRAM update size = (enemy tile data size) & ~8000h
$82:E014 BB          TYX                    ;\
$82:E015 BF 02 00 B4 LDA $B40002,x[$B4:9228];|
$82:E019 29 00 F0    AND #$F000             ;|
$82:E01C 4A          LSR A                  ;|
$82:E01D 4A          LSR A                  ;} Door transition VRAM update destination = $6000 | (enemy palette index) >> 4 & F00h
$82:E01E 4A          LSR A                  ;|
$82:E01F 4A          LSR A                  ;|
$82:E020 09 00 60    ORA #$6000             ;|
$82:E023 8D BE 05    STA $05BE  [$7E:05BE]  ;/

$82:E026 A9 00 80    LDA #$8000             ;\
$82:E029 0C BC 05    TSB $05BC  [$7E:05BC]  ;} Flag door transition VRAM update

$82:E02C AD BC 05    LDA $05BC  [$7E:05BC]  ;\
$82:E02F 30 FB       BMI $FB    [$E02C]     ;} Wait for door transition VRAM update
$82:E031 C8          INY                    ;\
$82:E032 C8          INY                    ;|
$82:E033 C8          INY                    ;} X += 4 (next enemy)
$82:E034 C8          INY                    ;|
$82:E035 BB          TYX                    ;/
$82:E036 80 A4       BRA $A4    [$DFDC]     ; Go to LOOP

$82:E038 60          RTS
}


;;; $E039: Perform door transition VRAM update ;;;
{
; 7 bytes after the JSR are used as arguments:
;  Source address (3 bytes),
;  VRAM address (2 bytes),
;  size (2 bytes).
; Waits for an IRQ to DMA - ONLY during door transitions.
$82:E039 A3 01       LDA $01,s  [$7E:1FF7]  ;\
$82:E03B 1A          INC A                  ;} $AD = (return address) + 1
$82:E03C 85 AD       STA $AD    [$7E:00AD]  ;/
$82:E03E 8B          PHB
$82:E03F 4B          PHK                    ;\
$82:E040 AB          PLB                    ;} DB = $82
$82:E041 B2 AD       LDA ($AD)  [$82:E449]  ;\
$82:E043 8D C0 05    STA $05C0  [$7E:05C0]  ;|
$82:E046 E6 AD       INC $AD    [$7E:00AD]  ;} Door transition VRAM update source = [[$AD]]
$82:E048 B2 AD       LDA ($AD)  [$82:E44A]  ;|
$82:E04A 8D C1 05    STA $05C1  [$7E:05C1]  ;/
$82:E04D E6 AD       INC $AD    [$7E:00AD]  ;\
$82:E04F E6 AD       INC $AD    [$7E:00AD]  ;|
$82:E051 B2 AD       LDA ($AD)  [$82:E44C]  ;} Door transition VRAM update destination = [[$AD] + 3]
$82:E053 8D BE 05    STA $05BE  [$7E:05BE]  ;/
$82:E056 E6 AD       INC $AD    [$7E:00AD]  ;\
$82:E058 E6 AD       INC $AD    [$7E:00AD]  ;|
$82:E05A B2 AD       LDA ($AD)  [$82:E44E]  ;} Door transition VRAM update size = [[$AD] + 5]
$82:E05C 8D C3 05    STA $05C3  [$7E:05C3]  ;/
$82:E05F AB          PLB
$82:E060 A5 AD       LDA $AD    [$7E:00AD]  ;\
$82:E062 1A          INC A                  ;} (Return address) = [$AD] + 7 - 1
$82:E063 83 01       STA $01,s  [$7E:1FF7]  ;/
$82:E065 A9 00 80    LDA #$8000             ;\
$82:E068 0C BC 05    TSB $05BC  [$7E:05BC]  ;} Flag door transition VRAM update

$82:E06B AD BC 05    LDA $05BC  [$7E:05BC]  ;\
$82:E06E 30 FB       BMI $FB    [$E06B]     ;} Wait for door transition VRAM update
$82:E070 60          RTS
}


;;; $E071: Queue room music data ;;;
{
$82:E071 08          PHP
$82:E072 8B          PHB
$82:E073 C2 30       REP #$30
$82:E075 AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:E078 C9 28 00    CMP #$0028             ;} If in demo: return
$82:E07B B0 1B       BCS $1B    [$E098]     ;/
$82:E07D AD CB 07    LDA $07CB  [$7E:07CB]  ;\
$82:E080 F0 16       BEQ $16    [$E098]     ;} If [room music data index] = 0: return
$82:E082 CD F3 07    CMP $07F3  [$7E:07F3]  ;\
$82:E085 F0 11       BEQ $11    [$E098]     ;} If [room music data index] = [music data index]: return
$82:E087 A9 00 00    LDA #$0000             ;\
$82:E08A 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$82:E08E AD CB 07    LDA $07CB  [$7E:07CB]  ;\
$82:E091 09 00 FF    ORA #$FF00             ;} Queue room music data
$82:E094 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;/

$82:E098 AB          PLB
$82:E099 28          PLP
$82:E09A 6B          RTL
}


;;; $E09B: Update music track index ;;;
{
; $E0AC..CB can be omitted >_<;
; Called only by $80:A07B (start gameplay) to set the music track to play when Samus fanfare finishes
$82:E09B 08          PHP
$82:E09C 8B          PHB
$82:E09D C2 30       REP #$30
$82:E09F AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:E0A2 C9 28 00    CMP #$0028             ;} If in demo: return
$82:E0A5 B0 2B       BCS $2B    [$E0D2]     ;/
$82:E0A7 AD C9 07    LDA $07C9  [$7E:07C9]  ;\
$82:E0AA F0 26       BEQ $26    [$E0D2]     ;} If [room music track index] = 0: return
$82:E0AC AD CA 07    LDA $07CA  [$7E:07CA]  ;\
$82:E0AF 29 00 FF    AND #$FF00             ;|
$82:E0B2 85 12       STA $12    [$7E:0012]  ;} $12 = [room music data index] << 8 | [room music track index]
$82:E0B4 AD C9 07    LDA $07C9  [$7E:07C9]  ;|
$82:E0B7 04 12       TSB $12    [$7E:0012]  ;/
$82:E0B9 AD F2 07    LDA $07F2  [$7E:07F2]  ;\
$82:E0BC 29 00 FF    AND #$FF00             ;|
$82:E0BF 85 14       STA $14    [$7E:0014]  ;} $14 = [music data index] << 8 | [music track index]
$82:E0C1 AD F5 07    LDA $07F5  [$7E:07F5]  ;|
$82:E0C4 04 14       TSB $14    [$7E:0014]  ;/
$82:E0C6 A5 12       LDA $12    [$7E:0012]  ;\
$82:E0C8 C5 14       CMP $14    [$7E:0014]  ;} If [$12] = [$14]: return
$82:E0CA F0 06       BEQ $06    [$E0D2]     ;/
$82:E0CC AD C9 07    LDA $07C9  [$7E:07C9]  ;\
$82:E0CF 8D F5 07    STA $07F5  [$7E:07F5]  ;} Music track index = [room music track index]

$82:E0D2 AB          PLB
$82:E0D3 28          PLP
$82:E0D4 6B          RTL
}


;;; $E0D5: Load new music track if changed ;;;
{
$82:E0D5 08          PHP
$82:E0D6 8B          PHB
$82:E0D7 C2 30       REP #$30
$82:E0D9 AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:E0DC C9 28 00    CMP #$0028             ;} If in demo: return
$82:E0DF B0 2F       BCS $2F    [$E110]     ;/
$82:E0E1 AD C9 07    LDA $07C9  [$7E:07C9]  ;\
$82:E0E4 F0 2A       BEQ $2A    [$E110]     ;} If [room music track index] = 0: return
$82:E0E6 AD CA 07    LDA $07CA  [$7E:07CA]  ;\
$82:E0E9 29 00 FF    AND #$FF00             ;|
$82:E0EC 85 12       STA $12    [$7E:0012]  ;} $12 = [room music data index] << 8 | [room music track index]
$82:E0EE AD C9 07    LDA $07C9  [$7E:07C9]  ;|
$82:E0F1 04 12       TSB $12    [$7E:0012]  ;/
$82:E0F3 AD F2 07    LDA $07F2  [$7E:07F2]  ;\
$82:E0F6 29 00 FF    AND #$FF00             ;|
$82:E0F9 85 14       STA $14    [$7E:0014]  ;} $14 = [music data index] << 8 | [music track index]
$82:E0FB AD F5 07    LDA $07F5  [$7E:07F5]  ;|
$82:E0FE 04 14       TSB $14    [$7E:0014]  ;/
$82:E100 A5 12       LDA $12    [$7E:0012]  ;\
$82:E102 C5 14       CMP $14    [$7E:0014]  ;} If [$12] = [$14]: return
$82:E104 F0 0A       BEQ $0A    [$E110]     ;/
$82:E106 A0 06 00    LDY #$0006             ;\
$82:E109 AD C9 07    LDA $07C9  [$7E:07C9]  ;} Queue room's music track
$82:E10C 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/

$82:E110 AB          PLB
$82:E111 28          PLP
$82:E112 6B          RTL
}


;;; $E113: RTL ;;;
{
$82:E113 08          PHP
$82:E114 C2 20       REP #$20
$82:E116 28          PLP
$82:E117 6B          RTL
}


;;; $E118: Play room music track after [A] frames ;;;
{
$82:E118 08          PHP
$82:E119 8B          PHB
$82:E11A C2 30       REP #$30
$82:E11C 5A          PHY
$82:E11D A8          TAY                    ; Y = [A]
$82:E11E AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:E121 C9 28 00    CMP #$0028             ;} If in demo: return
$82:E124 B0 0E       BCS $0E    [$E134]     ;/
$82:E126 A9 00 00    LDA #$0000             ;\
$82:E129 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;} Queue music stop, [Y] frame delay
$82:E12D AD F5 07    LDA $07F5  [$7E:07F5]  ;\
$82:E130 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music track [music track index]

$82:E134 7A          PLY
$82:E135 AB          PLB
$82:E136 28          PLP
$82:E137 6B          RTL
}


;;; $E138: RTL ;;;
{
$82:E138 6B          RTL
}


;;; $E139: Load target colours for common sprites, beams and flashing enemies ;;;
{
$82:E139 C2 30       REP #$30
$82:E13B A2 1E 00    LDX #$001E             ;\
                                            ;|
$82:E13E BF A0 81 9A LDA $9A81A0,x[$9A:81BE];|
$82:E142 9F A0 C3 7E STA $7EC3A0,x[$7E:C3BE];} Target sprite palette 5 = [$9A:81BE..DD]
$82:E146 CA          DEX                    ;|
$82:E147 CA          DEX                    ;|
$82:E148 10 F4       BPL $F4    [$E13E]     ;/
$82:E14A A2 1E 00    LDX #$001E             ;\
                                            ;|
$82:E14D BF C0 C1 7E LDA $7EC1C0,x[$7E:C1DE];|
$82:E151 9F C0 C3 7E STA $7EC3C0,x[$7E:C3DE];} Target sprite palette 6 = [sprite palette 6]
$82:E155 CA          DEX                    ;|
$82:E156 CA          DEX                    ;|
$82:E157 10 F4       BPL $F4    [$E14D]     ;/
$82:E159 A2 1E 00    LDX #$001E             ;\
                                            ;|
$82:E15C BF 00 FC 9A LDA $9AFC00,x[$9A:FC1E];|
$82:E160 9F 00 C3 7E STA $7EC300,x[$7E:C31E];} Target sprite palette 0 = [$9A:FC00..1F]
$82:E164 CA          DEX                    ;|
$82:E165 CA          DEX                    ;|
$82:E166 10 F4       BPL $F4    [$E15C]     ;/
$82:E168 6B          RTL
}


;;; $E169: Game state 9 (hit a door block) ;;;
{
$82:E169 08          PHP
$82:E16A C2 30       REP #$30
$82:E16C F4 71 E1    PEA $E171              ;\
$82:E16F 6C 9C 09    JMP ($099C)[$82:E17D]  ;} Execute [door transition function]
$82:E172 B0 02       BCS $02    [$E176]     ; If carry clear:
$82:E174 28          PLP
$82:E175 60          RTS                    ; Return

$82:E176 EE 98 09    INC $0998  [$7E:0998]  ; Game state = Ah (loading next room)
$82:E179 28          PLP
$82:E17A 4C B7 E1    JMP $E1B7  [$82:E1B7]  ; Go to game state Ah
}


;;; $E17D: Door transition function - handle elevator ;;;
{
$82:E17D AD 16 0E    LDA $0E16  [$7E:0E16]  ;\
$82:E180 F0 1B       BEQ $1B    [$E19D]     ;} If door is not an elevator: return carry set
$82:E182 A9 00 00    LDA #$0000             ;\
$82:E185 22 84 F0 90 JSL $90F084[$90:F084]  ;} Lock Samus
$82:E189 AD 99 07    LDA $0799  [$7E:0799]  ;\
$82:E18C 30 0F       BMI $0F    [$E19D]     ;} If elevator is going up: return carry set
$82:E18E A9 30 00    LDA #$0030             ;\
$82:E191 8D 2F 09    STA $092F  [$7E:092F]  ;} Downwards elevator delay timer = 30h
$82:E194 A9 9F E1    LDA #$E19F             ;\
$82:E197 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = wait 48 frames for down elevator
$82:E19A 4C 9F E1    JMP $E19F  [$82:E19F]  ; Go to wait 48 frames for down elevator

$82:E19D 38          SEC
$82:E19E 60          RTS
}


;;; $E19F: Door transition function - wait 48 frames for down elevator ;;;
{
$82:E19F CE 2F 09    DEC $092F  [$7E:092F]  ; Decrement downwards elevator delay timer
$82:E1A2 30 11       BMI $11    [$E1B5]     ; If [downwards elevator delay timer] < 0: return carry set
$82:E1A4 22 B6 8E A0 JSL $A08EB6[$A0:8EB6]  ; Determine which enemies to process
$82:E1A8 22 D4 8F A0 JSL $A08FD4[$A0:8FD4]  ; Main enemy routine
$82:E1AC 22 4D 88 A0 JSL $A0884D[$A0:884D]  ; Draw Samus, projectiles, enemies and enemy projectiles
$82:E1B0 20 C7 DF    JSR $DFC7  [$82:DFC7]  ; Draw inanimate Samus
$82:E1B3 18          CLC                    ;\
$82:E1B4 60          RTS                    ;} Return carry clear

$82:E1B5 38          SEC
$82:E1B6 60          RTS
}


;;; $E1B7: Game state Ah (loading next room) ;;;
{
$82:E1B7 08          PHP
$82:E1B8 8B          PHB
$82:E1B9 C2 30       REP #$30
$82:E1BB A9 01 00    LDA #$0001             ;\
$82:E1BE 8D 97 07    STA $0797  [$7E:0797]  ;} Set door transition flags
$82:E1C1 8D 95 07    STA $0795  [$7E:0795]  ;/
$82:E1C4 9C F7 05    STZ $05F7  [$7E:05F7]  ; Enable minimap
$82:E1C7 9C 75 1E    STZ $1E75  [$7E:1E75]  ; Clear save station used flag
$82:E1CA 22 B6 8E A0 JSL $A08EB6[$A0:8EB6]  ; Determine which enemies to process
$82:E1CE 22 D4 8F A0 JSL $A08FD4[$A0:8FD4]  ; Main enemy routine
$82:E1D2 22 4D 88 A0 JSL $A0884D[$A0:884D]  ; Draw Samus, projectiles, enemies and enemy projectiles
$82:E1D6 20 C7 DF    JSR $DFC7  [$82:DFC7]  ; Draw inanimate Samus
$82:E1D9 20 F1 DD    JSR $DDF1  [$82:DDF1]  ; Load destination room CRE bitset
$82:E1DC F4 00 7E    PEA $7E00              ;\
$82:E1DF AB          PLB                    ;} DB = $7E
$82:E1E0 AB          PLB                    ;/
$82:E1E1 A2 FE 00    LDX #$00FE             ;\
$82:E1E4 A9 00 00    LDA #$0000             ;|
                                            ;|
$82:E1E7 9D 00 C2    STA $C200,x[$7E:C2FE]  ;|
$82:E1EA 9D 00 C3    STA $C300,x[$7E:C3FE]  ;} Clear target palettes
$82:E1ED CA          DEX                    ;|
$82:E1EE CA          DEX                    ;|
$82:E1EF 10 F6       BPL $F6    [$E1E7]     ;/
$82:E1F1 AD 12 C0    LDA $C012  [$7E:C012]  ;\
$82:E1F4 8D 12 C2    STA $C212  [$7E:C212]  ;|
$82:E1F7 AD 14 C0    LDA $C014  [$7E:C014]  ;} Target BG3 palette 2 colour 1..2 = [BG3 palette 2 colour 1..2]
$82:E1FA 8D 14 C2    STA $C214  [$7E:C214]  ;/
$82:E1FD AD 1A C0    LDA $C01A  [$7E:C01A]  ;\
$82:E200 8D 1A C2    STA $C21A  [$7E:C21A]  ;|
$82:E203 AD 1C C0    LDA $C01C  [$7E:C01C]  ;} Target BG3 palette 3 colour 1..2 = [BG3 palette 3 colour 1..2]
$82:E206 8D 1C C2    STA $C21C  [$7E:C21C]  ;/
$82:E209 AD 22 C0    LDA $C022  [$7E:C022]  ;\
$82:E20C 8D 22 C2    STA $C222  [$7E:C222]  ;|
$82:E20F AD 24 C0    LDA $C024  [$7E:C024]  ;|
$82:E212 8D 24 C2    STA $C224  [$7E:C224]  ;} Target BG3 palette 4 colour 1..3 = [BG3 palette 4 colour 1..3]
$82:E215 AD 26 C0    LDA $C026  [$7E:C026]  ;|
$82:E218 8D 26 C2    STA $C226  [$7E:C226]  ;/
$82:E21B AD 3A C0    LDA $C03A  [$7E:C03A]  ;\
$82:E21E 8D 3A C2    STA $C23A  [$7E:C23A]  ;} Target BG3 palette 7 colour 1 = [BG3 palette 7 colour 1]
$82:E221 AD B3 07    LDA $07B3  [$7E:07B3]  ;\
$82:E224 0D B1 07    ORA $07B1  [$7E:07B1]  ;|
$82:E227 89 01 00    BIT #$0001             ;} If [CRE bitset] | [previous CRE bitset] & 1 = 0:
$82:E22A D0 3F       BNE $3F    [$E26B]     ;/
$82:E22C AD 28 C0    LDA $C028  [$7E:C028]  ;\
$82:E22F 8D 28 C2    STA $C228  [$7E:C228]  ;|
$82:E232 AD 2A C0    LDA $C02A  [$7E:C02A]  ;|
$82:E235 8D 2A C2    STA $C22A  [$7E:C22A]  ;|
$82:E238 AD 2C C0    LDA $C02C  [$7E:C02C]  ;} Target BG3 palette 5 = [BG3 palette 5]
$82:E23B 8D 2C C2    STA $C22C  [$7E:C22C]  ;|
$82:E23E AD 2E C0    LDA $C02E  [$7E:C02E]  ;|
$82:E241 8D 2E C2    STA $C22E  [$7E:C22E]  ;/
$82:E244 AD 38 C0    LDA $C038  [$7E:C038]  ;\
$82:E247 8D 38 C2    STA $C238  [$7E:C238]  ;} Target BG3 palette 7 colour 0 = [BG3 palette 7 colour 0]
$82:E24A AD 43 09    LDA $0943  [$7E:0943]  ;\
$82:E24D F0 1C       BEQ $1C    [$E26B]     ;} If timer is active:
$82:E24F AD A2 C1    LDA $C1A2  [$7E:C1A2]  ;\
$82:E252 8D A2 C3    STA $C3A2  [$7E:C3A2]  ;} Target sprite palette 5 colour 1 = [sprite palette 5 colour 1]
$82:E255 AD A4 C1    LDA $C1A4  [$7E:C1A4]  ;\
$82:E258 8D A4 C3    STA $C3A4  [$7E:C3A4]  ;} Target sprite palette 5 colour 2 = [sprite palette 5 colour 2]
$82:E25B AD A8 C1    LDA $C1A8  [$7E:C1A8]  ;\
$82:E25E 8D A8 C3    STA $C3A8  [$7E:C3A8]  ;} Target sprite palette 5 colour 4 = [sprite palette 5 colour 4]
$82:E261 AD BA C1    LDA $C1BA  [$7E:C1BA]  ;\
$82:E264 8D BA C3    STA $C3BA  [$7E:C3BA]  ;} Target sprite palette 5 colour Dh = [sprite palette 5 colour Dh]
$82:E267 22 6C 9F 80 JSL $809F6C[$80:9F6C]  ; Draw timer

$82:E26B 22 50 82 84 JSL $848250[$84:8250]  ; Clear sounds when going through door
$82:E26F A9 71 00    LDA #$0071             ;\
$82:E272 22 A3 90 80 JSL $8090A3[$80:90A3]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 15 (silence)
$82:E276 A9 FF FF    LDA #$FFFF             ;\
$82:E279 8D F5 05    STA $05F5  [$7E:05F5]  ;} Disable sounds
$82:E27C A9 9E E2    LDA #$E29E             ;\
$82:E27F 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E29E
$82:E282 EE 98 09    INC $0998  [$7E:0998]  ; Game state = Bh (loading next room)
$82:E285 AB          PLB
$82:E286 28          PLP
$82:E287 60          RTS
}


;;; $E288: Game state Bh (loading next room) ;;;
{
$82:E288 08          PHP
$82:E289 8B          PHB
$82:E28A C2 30       REP #$30
$82:E28C F4 91 E2    PEA $E291              ;\
$82:E28F 6C 9C 09    JMP ($099C)[$82:E29E]  ;} Execute [door transition function]
$82:E292 AD 43 09    LDA $0943  [$7E:0943]  ;\
$82:E295 F0 04       BEQ $04    [$E29B]     ;} If [timer status] != inactive:
$82:E297 22 6C 9F 80 JSL $809F6C[$80:9F6C]  ; Draw timer

$82:E29B AB          PLB
$82:E29C 28          PLP
$82:E29D 60          RTS
}


;;; $E29E: Handles door transitions - wait for sounds to finish ;;;
{
$82:E29E 08          PHP
$82:E29F 22 B6 8E A0 JSL $A08EB6[$A0:8EB6]  ; Determine which enemies to process
$82:E2A3 22 D4 8F A0 JSL $A08FD4[$A0:8FD4]  ; Main enemy routine
$82:E2A7 22 4D 88 A0 JSL $A0884D[$A0:884D]  ; Draw Samus, projectiles, enemies and enemy projectiles
$82:E2AB 20 C7 DF    JSR $DFC7  [$82:DFC7]  ; Draw inanimate Samus
$82:E2AE E2 20       SEP #$20
$82:E2B0 AD 46 06    LDA $0646  [$7E:0646]  ;\
$82:E2B3 38          SEC                    ;|
$82:E2B4 ED 43 06    SBC $0643  [$7E:0643]  ;} If [sound 1 queue next index] - [sound 1 queue start index] & Fh != 0: return
$82:E2B7 29 0F       AND #$0F               ;|
$82:E2B9 D0 1E       BNE $1E    [$E2D9]     ;/
$82:E2BB AD 47 06    LDA $0647  [$7E:0647]  ;\
$82:E2BE 38          SEC                    ;|
$82:E2BF ED 44 06    SBC $0644  [$7E:0644]  ;} If [sound 2 queue next index] - [sound 2 queue start index] & Fh != 0: return
$82:E2C2 29 0F       AND #$0F               ;|
$82:E2C4 D0 13       BNE $13    [$E2D9]     ;/
$82:E2C6 AD 48 06    LDA $0648  [$7E:0648]  ;\
$82:E2C9 38          SEC                    ;|
$82:E2CA ED 45 06    SBC $0645  [$7E:0645]  ;} If [sound 3 queue next index] - [sound 3 queue start index] & Fh != 0: return
$82:E2CD 29 0F       AND #$0F               ;|
$82:E2CF D0 08       BNE $08    [$E2D9]     ;/
$82:E2D1 C2 20       REP #$20
$82:E2D3 A9 DB E2    LDA #$E2DB             ;\
$82:E2D6 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E2DB

$82:E2D9 28          PLP
$82:E2DA 60          RTS
}


;;; $E2DB: Handles door transitions - fade out the screen ;;;
{
$82:E2DB 20 61 D9    JSR $D961  [$82:D961]  ; Advance gradual colour change of all palettes - denominator = Ch
$82:E2DE B0 10       BCS $10    [$E2F0]     ; If not reached target colour:
$82:E2E0 22 B6 8E A0 JSL $A08EB6[$A0:8EB6]  ; Determine which enemies to process
$82:E2E4 22 D4 8F A0 JSL $A08FD4[$A0:8FD4]  ; Main enemy routine
$82:E2E8 22 4D 88 A0 JSL $A0884D[$A0:884D]  ; Draw Samus, projectiles, enemies and enemy projectiles
$82:E2EC 20 C7 DF    JSR $DFC7  [$82:DFC7]  ; Draw inanimate Samus
$82:E2EF 60          RTS                    ; Return

$82:E2F0 A9 F7 E2    LDA #$E2F7             ;\
$82:E2F3 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E2F7
$82:E2F6 60          RTS
}


;;; $E2F7: Handles door transitions - load door header, delete HDMA objects, and set interrupt command ;;;
{
$82:E2F7 20 12 DE    JSR $DE12  [$82:DE12]  ; Load door header
$82:E2FA 22 AC 82 88 JSL $8882AC[$88:82AC]  ; Delete HDMA objects
$82:E2FE A9 00 80    LDA #$8000             ;\
$82:E301 1C B0 18    TRB $18B0  [$7E:18B0]  ;} Disable HDMA objects
$82:E304 A9 08 00    LDA #$0008             ;\
$82:E307 85 A7       STA $A7    [$7E:00A7]  ;} Next interrupt command = 8 (start of door transition)
$82:E309 A9 10 E3    LDA #$E310             ;\
$82:E30C 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E310
$82:E30F 60          RTS
}


;;; $E310: Handles door transitions - scroll screen to alignment ;;;
{
$82:E310 F4 00 8F    PEA $8F00              ;\
$82:E313 AB          PLB                    ;} DB = $8F
$82:E314 AB          PLB                    ;/
$82:E315 AD 91 07    LDA $0791  [$7E:0791]  ;\
$82:E318 89 02 00    BIT #$0002             ;} If door direction is vertical: go to BRANCH_VERTICAL
$82:E31B D0 14       BNE $14    [$E331]     ;/
$82:E31D AD 14 09    LDA $0914  [$7E:0914]  ;\
$82:E320 89 00 FF    BIT #$FF00             ;} If [layer 1 Y position] % 100h = 0: go to BRANCH_DONE
$82:E323 F0 23       BEQ $23    [$E348]     ;/
$82:E325 30 05       BMI $05    [$E32C]     ; If [layer 1 Y position] % 100h < 80h:
$82:E327 CE 15 09    DEC $0915  [$7E:0915]  ; Decrement layer 1 Y position
$82:E32A 80 17       BRA $17    [$E343]     ; Go to BRANCH_RETURN

$82:E32C EE 15 09    INC $0915  [$7E:0915]  ; Increment layer 1 Y position
$82:E32F 80 12       BRA $12    [$E343]     ; Go to BRANCH_RETURN

; BRANCH_VERTICAL
$82:E331 AD 10 09    LDA $0910  [$7E:0910]  ;\
$82:E334 89 00 FF    BIT #$FF00             ;} If [layer 1 X position] % 100h = 0: go to BRANCH_DONE
$82:E337 F0 0F       BEQ $0F    [$E348]     ;/
$82:E339 30 05       BMI $05    [$E340]     ; If [layer 1 X position] % 100h < 80h:
$82:E33B CE 11 09    DEC $0911  [$7E:0911]  ; Decrement layer 1 X position
$82:E33E 80 03       BRA $03    [$E343]     ; Go to BRANCH_RETURN

$82:E340 EE 11 09    INC $0911  [$7E:0911]  ; Increment layer 1 X position

; BRANCH_RETURN
$82:E343 22 AB A3 80 JSL $80A3AB[$80:A3AB]  ; Calculate layer 2 position and BG scrolls and update BG graphics when scrolling
$82:E347 60          RTS                    ; Return

; BRANCH_DONE
$82:E348 22 AB A3 80 JSL $80A3AB[$80:A3AB]  ; Calculate layer 2 position and BG scrolls and update BG graphics when scrolling
$82:E34C A9 53 E3    LDA #$E353             ;\
$82:E34F 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E353
$82:E352 60          RTS
}


;;; $E353: Handles door transitions - fix doors moving up ;;;
{
; See $80:AF89
$82:E353 F4 00 8F    PEA $8F00              ;\
$82:E356 AB          PLB                    ;} DB = $8F
$82:E357 AB          PLB                    ;/
$82:E358 AD 91 07    LDA $0791  [$7E:0791]  ;\
$82:E35B 29 03 00    AND #$0003             ;|
$82:E35E C9 03 00    CMP #$0003             ;} If door direction is up:
$82:E361 D0 04       BNE $04    [$E367]     ;/
$82:E363 22 1D AD 80 JSL $80AD1D[$80:AD1D]  ; Draw top row of screen for upwards door transition

$82:E367 A9 6E E3    LDA #$E36E             ;\
$82:E36A 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E36E
$82:E36D 60          RTS
}


;;; $E36E: Handles door transitions - load room header; set up map; decompress level, scroll, and CRE data ;;;
{
$82:E36E F4 00 8F    PEA $8F00              ;\
$82:E371 AB          PLB                    ;} DB = $8F
$82:E372 AB          PLB                    ;/
$82:E373 20 99 DF    JSR $DF99  [$82:DF99]  ; Save map explored if elevator
$82:E376 20 6F DE    JSR $DE6F  [$82:DE6F]  ; Load room header
$82:E379 20 F2 DE    JSR $DEF2  [$82:DEF2]  ; Load state header
$82:E37C 20 B6 DF    JSR $DFB6  [$82:DFB6]  ; Load map explored if elevator
$82:E37F 22 C1 82 88 JSL $8882C1[$88:82C1]  ; Initialise special effects for new room
$82:E383 22 73 EA 82 JSL $82EA73[$82:EA73]  ; Load level, scroll and CRE data
$82:E387 A9 8E E3    LDA #$E38E             ;\
$82:E38A 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E38E
$82:E38D 60          RTS
}


;;; $E38E: Handles door transitions - set up scrolling ;;;
{
$82:E38E F4 00 8F    PEA $8F00              ;\
$82:E391 AB          PLB                    ;} DB = $8F
$82:E392 AB          PLB                    ;/
$82:E393 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$82:E395 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$82:E397 9C E9 07    STZ $07E9  [$7E:07E9]  ; Scrolling finished hook = 0
$82:E39A AD 91 07    LDA $0791  [$7E:0791]  ;\
$82:E39D 29 03 00    AND #$0003             ;|
$82:E3A0 C9 02 00    CMP #$0002             ;} If door direction is down:
$82:E3A3 D0 02       BNE $02    [$E3A7]     ;/
$82:E3A5 E6 B3       INC $B3    [$7E:00B3]  ; Increment BG1 Y scroll

$82:E3A7 AD 91 07    LDA $0791  [$7E:0791]  ;\
$82:E3AA 29 03 00    AND #$0003             ;|
$82:E3AD C9 03 00    CMP #$0003             ;} If door direction is not up:
$82:E3B0 F0 03       BEQ $03    [$E3B5]     ;/
$82:E3B2 9C 25 09    STZ $0925  [$7E:0925]  ; Door transition frame counter = 0

$82:E3B5 22 30 AD 80 JSL $80AD30[$80:AD30]  ; Door transition scrolling setup
$82:E3B9 A9 C0 E3    LDA #$E3C0             ;\
$82:E3BC 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E3C0
$82:E3BF 60          RTS
}


;;; $E3C0: Handles door transitions - place Samus, load tiles ;;;
{
$82:E3C0 F4 00 8F    PEA $8F00              ;\
$82:E3C3 AB          PLB                    ;} DB = $8F
$82:E3C4 AB          PLB                    ;/
$82:E3C5 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$82:E3C8 29 FF 00    AND #$00FF             ;|
$82:E3CB 18          CLC                    ;} Samus X position = [layer 1 X position] + [Samus X position] % 100h
$82:E3CC 6D 11 09    ADC $0911  [$7E:0911]  ;|
$82:E3CF 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$82:E3D2 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$82:E3D5 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$82:E3D8 29 FF 00    AND #$00FF             ;|
$82:E3DB 18          CLC                    ;} Samus Y position = [layer 1 Y position] + [Samus Y position] % 100h
$82:E3DC 6D 15 09    ADC $0915  [$7E:0915]  ;|
$82:E3DF 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$82:E3E2 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$82:E3E5 9C 31 09    STZ $0931  [$7E:0931]  ; Door transition finished scrolling flag = 0
$82:E3E8 9C BC 05    STZ $05BC  [$7E:05BC]  ; Door transition VRAM update flag = 0
$82:E3EB AD 91 07    LDA $0791  [$7E:0791]  ;\
$82:E3EE 29 03 00    AND #$0003             ;|
$82:E3F1 C9 02 00    CMP #$0002             ;} If door direction is down:
$82:E3F4 D0 05       BNE $05    [$E3FB]     ;/
$82:E3F6 A9 10 00    LDA #$0010             ;\
$82:E3F9 80 03       BRA $03    [$E3FE]     ;} Next interrupt command = 10h (vertical room transition)

                                            ; Else (door direction is not down):
$82:E3FB A9 16 00    LDA #$0016             ; Next interrupt command = 16h (horizontal room transition)

$82:E3FE 85 A7       STA $A7    [$7E:00A7]
$82:E400 20 69 DF    JSR $DF69  [$82:DF69]  ; Wait until the end of a v-blank and enable h/v-counter interrupts
$82:E403 AD B3 07    LDA $07B3  [$7E:07B3]  ;\
$82:E406 89 02 00    BIT #$0002             ;} If [CRE bitset] & 2 != 0 (reload CRE):
$82:E409 F0 19       BEQ $19    [$E424]     ;/
$82:E40B AD 8D 07    LDA $078D  [$7E:078D]  ;\
$82:E40E C9 7A 94    CMP #$947A             ;} If [door pointer] != $947A (room $AB07 (post Crocomire shaft), door list index 0):
$82:E411 F0 11       BEQ $11    [$E424]     ;/
$82:E413 A9 00 B9    LDA #$B900             ;\
$82:E416 85 48       STA $48    [$7E:0048]  ;|
$82:E418 A9 00 80    LDA #$8000             ;|
$82:E41B 85 47       STA $47    [$7E:0047]  ;} Decompress CRE tiles to $7E:7000
$82:E41D 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:E421             dl 7E7000              ;/

$82:E424 AD C4 07    LDA $07C4  [$7E:07C4]  ;\
$82:E427 85 48       STA $48    [$7E:0048]  ;|
$82:E429 AD C3 07    LDA $07C3  [$7E:07C3]  ;|
$82:E42C 85 47       STA $47    [$7E:0047]  ;} Decompress tileset tiles to $7E:2000 (may overwrite CRE)
$82:E42E 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:E432             dl 7E2000              ;/
$82:E435 AD C7 07    LDA $07C7  [$7E:07C7]  ;\
$82:E438 85 48       STA $48    [$7E:0048]  ;|
$82:E43A AD C6 07    LDA $07C6  [$7E:07C6]  ;|
$82:E43D 85 47       STA $47    [$7E:0047]  ;} Decompress tileset palettes to target palettes
$82:E43F 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:E443             dl 7EC200              ;/
$82:E446 20 39 E0    JSR $E039  [$82:E039]  ;\
$82:E449             dx 7E2000, 0000, 2000  ;|
$82:E450 20 39 E0    JSR $E039  [$82:E039]  ;|
$82:E453             dx 7E4000, 1000, 2000  ;} VRAM $0000..27FF = [$7E:2000..6FFF] (tileset tiles)
$82:E45A 20 39 E0    JSR $E039  [$82:E039]  ;|
$82:E45D             dx 7E6000, 2000, 1000  ;/
$82:E464 AD B3 07    LDA $07B3  [$7E:07B3]  ;\
$82:E467 89 06 00    BIT #$0006             ;} If [CRE bitset] & 6 != 0 (reload CRE or load extra large tileset):
$82:E46A F0 26       BEQ $26    [$E492]     ;/
$82:E46C AD 8D 07    LDA $078D  [$7E:078D]  ;\
$82:E46F C9 7A 94    CMP #$947A             ;} If [door pointer] != $947A (room $AB07 (post Crocomire shaft), door list index 0):
$82:E472 F0 1E       BEQ $1E    [$E492]     ;/
$82:E474 20 39 E0    JSR $E039  [$82:E039]  ;\
$82:E477             dx 7E7000, 2800, 1000  ;|
$82:E47E 20 39 E0    JSR $E039  [$82:E039]  ;} VRAM $2800..3FFF = [$7E:7000..9FFF] (CRE or extended part of tileset tiles)
$82:E481             dx 7E8000, 3000, 2000  ;/
$82:E488 20 39 E0    JSR $E039  [$82:E039]  ;\
$82:E48B             dx 9AB200, 4000, 1000  ;} VRAM $4000..47FF = [$9A:B200..C1FF] (standard BG3 tiles)

$82:E492 AD 91 07    LDA $0791  [$7E:0791]  ;\
$82:E495 29 03 00    AND #$0003             ;|
$82:E498 C9 03 00    CMP #$0003             ;} If door direction is up:
$82:E49B D0 05       BNE $05    [$E4A2]     ;/
$82:E49D A9 10 00    LDA #$0010             ;\
$82:E4A0 85 A7       STA $A7    [$7E:00A7]  ;} Next interrupt command = 10h (vertical room transition)

$82:E4A2 A9 A9 E4    LDA #$E4A9             ;\
$82:E4A5 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E4A9
$82:E4A8 60          RTS
}


;;; $E4A9: Handles door transitions - load sprites, background, PLMs, audio; execute custom door and room ASM; and wait for scrolling to end ;;;
{
; In this routine, after all of the loading is done, we sit on this busy loop at $E526 waiting for door transition scrolling to finish
; During this busy loop, door transition scrolling updates are happening due to the IRQ handler ($80:979B),
; which will eventually set $0931 when scrolling has finished, freeing us from the busy loop
; On the frame of the last door transition scrolling update, this routine decides to run the PLM handler before waiting for the next frame
; Because scrolling updates take precedence over PLM draw updates, and because the scrolling updates were carried out prior to any PLM level data modifications,
; PLM draw updates that affect the top row of (the visible part of) the room for upwards doors or the bottom row of the room for downwards doors aren't visible
; This is the cause of the "red and green doors appear blue in the Crateria -> Red Brinstar room" bug

$82:E4A9 08          PHP
$82:E4AA 20 D1 DF    JSR $DFD1  [$82:DFD1]  ; Load enemy GFX to VRAM
$82:E4AD 22 71 E0 82 JSL $82E071[$82:E071]  ; Queue room music data
$82:E4B1 22 16 80 86 JSL $868016[$86:8016]  ; Clear enemy projectiles
$82:E4B5 22 16 80 87 JSL $878016[$87:8016]  ; Clear animated tiles objects
$82:E4B9 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]  ; Clear palette FX objects
$82:E4BD 22 C3 83 84 JSL $8483C3[$84:83C3]  ; Clear PLMs
$82:E4C1 22 6C EB 82 JSL $82EB6C[$82:EB6C]  ; Create PLMs, execute door ASM, room setup ASM and set elevator status
$82:E4C5 22 82 AB 89 JSL $89AB82[$89:AB82]  ; Load FX header
$82:E4C9 20 EB E8    JSR $E8EB  [$82:E8EB]  ; Spawn door closing PLM
$82:E4CC 22 8D AC 90 JSL $90AC8D[$90:AC8D]  ; Update beam graphics
$82:E4D0 22 39 E1 82 JSL $82E139[$82:E139]  ; Load target colours for common sprites, beams and slashing enemies / pickups
$82:E4D4 22 1E 8A A0 JSL $A08A1E[$A0:8A1E]  ; Load enemies
$82:E4D8 22 9E 8A A0 JSL $A08A9E[$A0:8A9E]  ; Initialise enemies
$82:E4DC 22 22 AD 90 JSL $90AD22[$90:AD22]  ; Reset projectile data
$82:E4E0 22 E6 DE 91 JSL $91DEE6[$91:DEE6]  ; Load Samus target colours based on suit
$82:E4E4 28          PLP
$82:E4E5 F4 00 8F    PEA $8F00              ;\
$82:E4E8 AB          PLB                    ;} DB = $8F
$82:E4E9 AB          PLB                    ;/
$82:E4EA 20 66 E5    JSR $E566  [$82:E566]  ; Clear FX tilemap
$82:E4ED A9 00 8A    LDA #$8A00
$82:E4F0 8D C1 05    STA $05C1  [$7E:05C1]
$82:E4F3 AD 64 19    LDA $1964  [$7E:1964]  ;\
$82:E4F6 F0 1A       BEQ $1A    [$E512]     ;} If [FX tilemap pointer] != 0:
$82:E4F8 8D C0 05    STA $05C0  [$7E:05C0]  ; Door transition VRAM update source = $8A:0000 + [FX tilemap pointer]
$82:E4FB A9 E0 5B    LDA #$5BE0             ;\
$82:E4FE 8D BE 05    STA $05BE  [$7E:05BE]  ;} Door transition VRAM update destination = $5BE0
$82:E501 A9 40 08    LDA #$0840             ;\
$82:E504 8D C3 05    STA $05C3  [$7E:05C3]  ;} Door transition VRAM update size = 840h
$82:E507 A9 00 80    LDA #$8000             ;\
$82:E50A 0C BC 05    TSB $05BC  [$7E:05BC]  ;} Flag door transition VRAM update

$82:E50D 2C BC 05    BIT $05BC  [$7E:05BC]  ;\
$82:E510 30 FB       BMI $FB    [$E50D]     ;} Wait for door transition VRAM update

$82:E512 AE BB 07    LDX $07BB  [$7E:07BB]  ;\
$82:E515 BC 16 00    LDY $0016,x[$8F:DFB5]  ;} Y = (room library background pointer)
$82:E518 10 0A       BPL $0A    [$E524]     ; If [Y] & 8000h = 0: go to BRANCH_NO_LIBRARY_BACKGROUND

; LOOP
$82:E51A BE 00 00    LDX $0000,y[$8F:E4A5]  ; X = [[Y]] (library background command)
$82:E51D C8          INY                    ;\
$82:E51E C8          INY                    ;} Y += 2
$82:E51F FC C7 E5    JSR ($E5C7,x)[$82:E616]; Execute [$E5C7 + [X]]
$82:E522 90 F6       BCC $F6    [$E51A]     ; If carry clear: go to LOOP

; BRANCH_NO_LIBRARY_BACKGROUND
$82:E524 C2 30       REP #$30

$82:E526 AD 31 09    LDA $0931  [$7E:0931]  ;\
$82:E529 10 FB       BPL $FB    [$E526]     ;} Wait until door transition has finished scrolling
$82:E52B A9 E0 3B    LDA #$3BE0             ;\
$82:E52E 8F 88 C1 7E STA $7EC188[$7E:C188]  ;} Sprite palette 4 colour 4 = (0, 1Fh, Eh)
$82:E532 22 65 D8 88 JSL $88D865[$88:D865]  ; Spawn HUD BG3 scroll HDMA object
$82:E536 A9 00 80    LDA #$8000             ;\
$82:E539 0C B0 18    TSB $18B0  [$7E:18B0]  ;} Set HDMA flag
$82:E53C 22 B4 85 84 JSL $8485B4[$84:85B4]  ; PLM handler
$82:E540 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$82:E544 AD 91 07    LDA $0791  [$7E:0791]  ;\
$82:E547 89 02 00    BIT #$0002             ;} If door direction is horizontal:
$82:E54A D0 13       BNE $13    [$E55F]     ;/
$82:E54C 29 03 00    AND #$0003             ;\
$82:E54F F0 08       BEQ $08    [$E559]     ;} If door direction is left:
$82:E551 A9 07 00    LDA #$0007             ;\
$82:E554 1C F6 0A    TRB $0AF6  [$7E:0AF6]  ;} Samus X &= ~7
$82:E557 80 06       BRA $06    [$E55F]

$82:E559 A9 07 00    LDA #$0007             ;\ Else (door direction is right):
$82:E55C 0C F6 0A    TSB $0AF6  [$7E:0AF6]  ;} Samus X |= 7

$82:E55F A9 59 E6    LDA #$E659             ;\
$82:E562 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E659
$82:E565 60          RTS
}


;;; $E566..E658: Library background - door transition ;;;
{
;;; $E566: Clear FX tilemap ;;;
{
$82:E566 A2 7E 07    LDX #$077E             ;\
$82:E569 A9 4E 18    LDA #$184E             ;|
                                            ;|
$82:E56C 9F 00 40 7E STA $7E4000,x[$7E:477E];|
$82:E570 9F 80 47 7E STA $7E4780,x[$7E:4EFE];} $7E:4000..4EFF = 184Eh
$82:E574 CA          DEX                    ;|
$82:E575 CA          DEX                    ;|
$82:E576 10 F4       BPL $F4    [$E56C]     ;/
$82:E578 20 39 E0    JSR $E039  [$82:E039]  ;\
$82:E57B             dx 7E4000, 5880, 0F00  ;} VRAM $5880..5FFF = [$7E:4000..4EFF]
$82:E582 60          RTS
}


;;; $E583: Clear BG2 tilemap ;;;
{
$82:E583 A2 FE 07    LDX #$07FE             ;\
$82:E586 A9 38 03    LDA #$0338             ;|
                                            ;|
$82:E589 9F 00 40 7E STA $7E4000,x[$7E:47FE];|
$82:E58D 9F 00 48 7E STA $7E4800,x[$7E:4FFE];} $7E:4000..4FFF = 0338h
$82:E591 CA          DEX                    ;|
$82:E592 CA          DEX                    ;|
$82:E593 10 F4       BPL $F4    [$E589]     ;/
$82:E595 20 39 E0    JSR $E039  [$82:E039]  ;\
$82:E598             dx 7E4000, 4800, 1000  ;} VRAM $4800..4FFF = [$7E:4000..4FFF]
$82:E59F 60          RTS
}


;;; $E5A0: Clear Kraid's BG2 tilemap ;;;
{
$82:E5A0 A2 FE 07    LDX #$07FE             ;\
$82:E5A3 A9 38 03    LDA #$0338             ;|
                                            ;|
$82:E5A6 9F 00 40 7E STA $7E4000,x[$7E:47FE];|
$82:E5AA 9F 00 48 7E STA $7E4800,x[$7E:4FFE];} $7E:4000..4FFF = 0338h
$82:E5AE CA          DEX                    ;|
$82:E5AF CA          DEX                    ;|
$82:E5B0 10 F4       BPL $F4    [$E5A6]     ;/
$82:E5B2 20 39 E0    JSR $E039  [$82:E039]  ;\
$82:E5B5             dx 7E4000, 4000, 1000  ;} VRAM $4000..47FF = [$7E:4000..4FFF]
$82:E5BC 20 39 E0    JSR $E039  [$82:E039]  ;\
$82:E5BF             dx 7E4000, 4800, 1000  ;} VRAM $4800..4FFF = [$7E:4000..4FFF]
$82:E5C6 60          RTS
}


;;; $E5C7: Library background function pointers ;;;
{
$82:E5C7             dw E5D7, E5EB, E616, E637, E63E, E64B, E652, E5D9
}


;;; $E5D7: Load library background - command 0: terminator ;;;
{
$82:E5D7 38          SEC                    ;\
$82:E5D8 60          RTS                    ;} Return carry set
}


;;; $E5D9: Load library background - command Eh: door dependent transfer to VRAM ;;;
{
; Command Eh is only used by landing site, WS entrance and WS back door
$82:E5D9 AD 8D 07    LDA $078D  [$7E:078D]  ;\
$82:E5DC D9 00 00    CMP $0000,y[$8F:B76C]  ;} If [door pointer] != [[Y]]:
$82:E5DF F0 08       BEQ $08    [$E5E9]     ;/
$82:E5E1 98          TYA                    ;\
$82:E5E2 18          CLC                    ;|
$82:E5E3 69 09 00    ADC #$0009             ;} Y += 9
$82:E5E6 A8          TAY                    ;/
$82:E5E7 18          CLC                    ;\
$82:E5E8 60          RTS                    ;} Return carry clear

$82:E5E9 C8          INY                    ;\
$82:E5EA C8          INY                    ;} Y += 2
}


;;; $E5EB: Load library background - command 2: transfer to VRAM ;;;
{
$82:E5EB B9 03 00    LDA $0003,y[$8F:E4B1]  ;\
$82:E5EE 8D BE 05    STA $05BE  [$7E:05BE]  ;} Door transition VRAM update destination = [[Y] + 3]
$82:E5F1 B9 00 00    LDA $0000,y[$8F:E4AE]  ;\
$82:E5F4 8D C0 05    STA $05C0  [$7E:05C0]  ;|
$82:E5F7 B9 01 00    LDA $0001,y[$8F:E4AF]  ;} Door transition VRAM update source = [[Y]]
$82:E5FA 8D C1 05    STA $05C1  [$7E:05C1]  ;/
$82:E5FD B9 05 00    LDA $0005,y[$8F:E4B3]  ;\
$82:E600 8D C3 05    STA $05C3  [$7E:05C3]  ;} Door transition VRAM update size = [[Y] + 5]
$82:E603 A9 00 80    LDA #$8000             ;\
$82:E606 0C BC 05    TSB $05BC  [$7E:05BC]  ;} Flag door transition VRAM update

$82:E609 2C BC 05    BIT $05BC  [$7E:05BC]  ;\
$82:E60C 30 FB       BMI $FB    [$E609]     ;} Wait for door transition VRAM update
$82:E60E 98          TYA                    ;\
$82:E60F 18          CLC                    ;|
$82:E610 69 07 00    ADC #$0007             ;} Y += 7
$82:E613 A8          TAY                    ;/
$82:E614 18          CLC                    ;\
$82:E615 60          RTS                    ;} Return carry clear
}


;;; $E616: Load library background - command 4: decompression ;;;
{
$82:E616 5A          PHY
$82:E617 B9 00 00    LDA $0000,y[$8F:E4A7]  ;\
$82:E61A 85 47       STA $47    [$7E:0047]  ;|
$82:E61C B9 01 00    LDA $0001,y[$8F:E4A8]  ;|
$82:E61F 85 48       STA $48    [$7E:0048]  ;|
$82:E621 A9 00 7E    LDA #$7E00             ;} Decompress [[Y]] to $7E:0000 | [[Y] + 3]
$82:E624 85 4D       STA $4D    [$7E:004D]  ;|
$82:E626 B9 03 00    LDA $0003,y[$8F:E4AA]  ;|
$82:E629 85 4C       STA $4C    [$7E:004C]  ;|
$82:E62B 22 19 B1 80 JSL $80B119[$80:B119]  ;/
$82:E62F 68          PLA                    ;\
$82:E630 18          CLC                    ;|
$82:E631 69 05 00    ADC #$0005             ;} Y += 5
$82:E634 A8          TAY                    ;/
$82:E635 18          CLC                    ;\
$82:E636 60          RTS                    ;} Return carry clear
}


;;; $E637: Load library background - command 6: clear FX tilemap ;;;
{
; Command 6 is unused
$82:E637 5A          PHY
$82:E638 20 66 E5    JSR $E566  [$82:E566]  ; Clear FX tilemap
$82:E63B 7A          PLY
$82:E63C 18          CLC                    ;\
$82:E63D 60          RTS                    ;} Return carry clear
}


;;; $E63E: Load library background - command 8: transfer to VRAM and set BG3 tiles base address = $2000 ;;;
{
; Command 8 is only used by Kraid's room
$82:E63E 20 EB E5    JSR $E5EB  [$82:E5EB]  ; Command 2: transfer to VRAM
$82:E641 E2 20       SEP #$20               ;\
$82:E643 A9 02       LDA #$02               ;|
$82:E645 85 5E       STA $5E    [$7E:005E]  ;} BG3 tiles base address = $2000
$82:E647 C2 20       REP #$20               ;/
$82:E649 18          CLC                    ;\
$82:E64A 60          RTS                    ;} Return carry clear
}


;;; $E64B: Load library background - command Ah: clear BG2 tilemap ;;;
{
; Command Ah is only used by:
;     Room $CD13, state $CD3F: Phantoon's room, Phantoon is dead
;     Room $DA60, state $DA8C: Draygon's room, Drayon is dead
;     Room $DF45: Ceres elevator
$82:E64B 5A          PHY
$82:E64C 20 83 E5    JSR $E583  [$82:E583]  ; Clear BG2 tilemap
$82:E64F 7A          PLY
$82:E650 18          CLC                    ;\
$82:E651 60          RTS                    ;} Return carry clear
}


;;; $E652: Load library background - command Ch: clear Kraid's layer 2 ;;;
{
; Command Ch is only used by:
;     Room $A59F, state $A5CB: Kraid's room, Kraid is dead
$82:E652 5A          PHY
$82:E653 20 A0 E5    JSR $E5A0  [$82:E5A0]  ; Clear Kraid's BG2 tilemap
$82:E656 7A          PLY
$82:E657 18          CLC                    ;\
$82:E658 60          RTS                    ;} Return carry clear
}
}


;;; $E659: Handles door transitions - handle animated tiles ;;;
{
$82:E659 22 64 80 87 JSL $878064[$87:8064]  ; Animated tiles handler
$82:E65D A9 64 E6    LDA #$E664             ;\
$82:E660 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E664
$82:E663 60          RTS
}


;;; $E664: Handles door transitions - wait for music queue to clear and possibly load new music ;;;
{
$82:E664 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$82:E668 B0 0A       BCS $0A    [$E674]     ;} If music is queued: return
$82:E66A A9 A2 E6    LDA #$E6A2             ;\
$82:E66D 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E6A2
$82:E670 22 D5 E0 82 JSL $82E0D5[$82:E0D5]  ; Load new music track if changed

$82:E674 60          RTS
}


;;; $E675:  ;;;
{
; Unused door transition code?
$82:E675 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$82:E679 22 B6 8E A0 JSL $A08EB6[$A0:8EB6]  ; Determine which enemies to process
$82:E67D 9C 95 07    STZ $0795  [$7E:0795]  ; Door transition flag = 0
$82:E680 22 D4 8F A0 JSL $A08FD4[$A0:8FD4]  ; Main enemy routine
$82:E684 EE 95 07    INC $0795  [$7E:0795]  ; Door transition flag = 1
$82:E687 22 4D 88 A0 JSL $A0884D[$A0:884D]  ; Draw Samus, projectiles, enemies and enemy projectiles
$82:E68B 22 EC 94 90 JSL $9094EC[$90:94EC]  ; Main scrolling routine
$82:E68F 20 C7 DF    JSR $DFC7  [$82:DFC7]  ; Draw inanimate Samus
$82:E692 22 AB A3 80 JSL $80A3AB[$80:A3AB]  ; Calculate layer 2 position and BG scrolls and update BG graphics when scrolling
$82:E696 CE 2F 09    DEC $092F  [$7E:092F]  ; Decrement downwards elevator delay timer
$82:E699 10 06       BPL $06    [$E6A1]     ; If [downwards elevator delay timer] >= 0: return
$82:E69B A9 A2 E6    LDA #$E6A2             ;\
$82:E69E 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E6A2

$82:E6A1 60          RTS
}


;;; $E6A2: Handles door transitions - nudge Samus if she's intercepting the door ;;;
{
; Positions Samus to avoid collision with the door (not enough to prevent door clip though) and enables normal IRQ command
; Neither of the calls to $90:F084 are needed (they've both already been done elsewhere, and there's no reason to do only one of the two anyway...)
; tldr, ignore the elevator specific code.
; The clearing of $7E:9C00..9FFF I don't think is needed, that RAM AFAIK is only used for HDMA tables (other RAM is used for HDMA tables too...)
$82:E6A2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$82:E6A5 29 F0 00    AND #$00F0             ;|
$82:E6A8 C9 10 00    CMP #$0010             ;} If (Samus X block) % 10h = 1:
$82:E6AB D0 0F       BNE $0F    [$E6BC]     ;/
$82:E6AD AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$82:E6B0 09 0F 00    ORA #$000F             ;|
$82:E6B3 18          CLC                    ;} Samus X position = ((Samus X block) + 1) * 10h + 7 (middle of block to the right)
$82:E6B4 69 08 00    ADC #$0008             ;|
$82:E6B7 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$82:E6BA 80 12       BRA $12    [$E6CE]

$82:E6BC C9 E0 00    CMP #$00E0             ;\ Else ((Samus X block) % 10h != 1):
$82:E6BF D0 0D       BNE $0D    [$E6CE]     ;} If (Samus X block) % 10h = Eh:
$82:E6C1 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$82:E6C4 29 F0 FF    AND #$FFF0             ;|
$82:E6C7 38          SEC                    ;} Samus X position = ((Samus X block) - 1) * 10h + 8 (middle of block to the left)
$82:E6C8 E9 08 00    SBC #$0008             ;|
$82:E6CB 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/

$82:E6CE AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$82:E6D1 29 F0 00    AND #$00F0             ;|
$82:E6D4 C9 10 00    CMP #$0010             ;} If (Samus Y block) % 10h = 1:
$82:E6D7 D0 0F       BNE $0F    [$E6E8]     ;/
$82:E6D9 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$82:E6DC 09 0F 00    ORA #$000F             ;|
$82:E6DF 18          CLC                    ;} Samus Y position = ((Samus Y block) + 1) * 10h + 7 (middle of block below)
$82:E6E0 69 08 00    ADC #$0008             ;|
$82:E6E3 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$82:E6E6 80 03       BRA $03    [$E6EB]

$82:E6E8 C9 E0 00    CMP #$00E0             ; Uhh, I'll finish writing this routine tomorrow... >_<;

$82:E6EB 8B          PHB                    ;\
$82:E6EC F4 00 7E    PEA $7E00              ;|
$82:E6EF AB          PLB                    ;|
$82:E6F0 AB          PLB                    ;|
$82:E6F1 A2 FE 01    LDX #$01FE             ;|
                                            ;|
$82:E6F4 9E 00 9C    STZ $9C00,x[$7E:9DFE]  ;} $7E:9C00..9FFF = 0
$82:E6F7 9E 00 9E    STZ $9E00,x[$7E:9FFE]  ;|
$82:E6FA CA          DEX                    ;|
$82:E6FB CA          DEX                    ;|
$82:E6FC 10 F6       BPL $F6    [$E6F4]     ;|
$82:E6FE AB          PLB                    ;/
$82:E6FF A5 A9       LDA $A9    [$7E:00A9]  ; A = [room loading interrupt command]
$82:E701 D0 03       BNE $03    [$E706]     ; If [A] = 0:
$82:E703 A9 04 00    LDA #$0004             ; A = 4 (main gameplay - begin HUD drawing)

$82:E706 85 A7       STA $A7    [$7E:00A7]  ; Next interrupt command = [A]
$82:E708 20 80 DF    JSR $DF80  [$82:DF80]  ; Ignore this
$82:E70B AD 16 0E    LDA $0E16  [$7E:0E16]  ;\
$82:E70E F0 15       BEQ $15    [$E725]     ;} If door is not an elevator: go to BRANCH_NOT_ELEVATOR
$82:E710 2C 99 07    BIT $0799  [$7E:0799]  ;\
$82:E713 10 09       BPL $09    [$E71E]     ;} If elevator direction is up:
$82:E715 A9 00 00    LDA #$0000             ;\
$82:E718 22 84 F0 90 JSL $90F084[$90:F084]  ;} Lock Samus
$82:E71C 80 07       BRA $07    [$E725]

$82:E71E A9 07 00    LDA #$0007             ;\ Else (elevator direction is down):
$82:E721 22 84 F0 90 JSL $90F084[$90:F084]  ;} Set up Samus for elevator

; BRANCH_NOT_ELEVATOR
$82:E725 22 0F 8E 90 JSL $908E0F[$90:8E0F]  ; Set liquid physics type
$82:E729 A9 37 E7    LDA #$E737             ;\
$82:E72C 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E737
$82:E72F A5 51       LDA $51    [$7E:0051]  ;\
$82:E731 09 1F 00    ORA #$001F             ;} Set full brightness (and set unused bit >_<;)
$82:E734 85 51       STA $51    [$7E:0051]  ;/
$82:E736 60          RTS
}


;;; $E737: Handles door transitions - fade in the screen and run enemies; finish door transition ;;;
{
$82:E737 22 64 80 87 JSL $878064[$87:8064]  ; Animated tiles objects handler
$82:E73B 22 B6 8E A0 JSL $A08EB6[$A0:8EB6]  ; Determine which enemies to process
$82:E73F 22 D4 8F A0 JSL $A08FD4[$A0:8FD4]  ; Main enemy routine
$82:E743 22 04 81 86 JSL $868104[$86:8104]  ; Enemy projectile handler
$82:E747 22 4D 88 A0 JSL $A0884D[$A0:884D]  ; Draw Samus, projectiles, enemies and enemy projectiles
$82:E74B 20 C7 DF    JSR $DFC7  [$82:DFC7]  ; Draw inanimate Samus
$82:E74E 22 26 97 A0 JSL $A09726[$A0:9726]  ; Handle queuing enemy BG2 tilemap VRAM transfer
$82:E752 20 61 D9    JSR $D961  [$82:D961]  ; Advance gradual colour change of all palettes - denominator = Ch
$82:E755 90 13       BCC $13    [$E76A]     ; If reached target colour:
$82:E757 9C F5 05    STZ $05F5  [$7E:05F5]  ; Enable sounds
$82:E75A 22 70 82 84 JSL $848270[$84:8270]  ; Play spin jump sound if spin jumping
$82:E75E 9C 95 07    STZ $0795  [$7E:0795]  ;\
$82:E761 9C 97 07    STZ $0797  [$7E:0797]  ;} Door transition flags = 0
$82:E764 A9 08 00    LDA #$0008             ;\
$82:E767 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 8 (main gameplay)

$82:E76A 60          RTS
}


;;; $E76B: Load destination room CRE bitset, door/room/state headers, CRE tiles, tileset tiles and tileset palette ;;;
{
$82:E76B 08          PHP
$82:E76C 8B          PHB
$82:E76D C2 30       REP #$30
$82:E76F F4 00 8F    PEA $8F00              ;\
$82:E772 AB          PLB                    ;} DB = $8F
$82:E773 AB          PLB                    ;/
$82:E774 20 F1 DD    JSR $DDF1  [$82:DDF1]  ; Load destination room CRE bitset
$82:E777 20 12 DE    JSR $DE12  [$82:DE12]  ; Load door header
$82:E77A 20 6F DE    JSR $DE6F  [$82:DE6F]  ; Load room header
$82:E77D 20 F2 DE    JSR $DEF2  [$82:DEF2]  ; Load state header
$82:E780 4C 8C E7    JMP $E78C  [$82:E78C]  ; Load CRE tiles, tileset tiles and tileset palette
}


;;; $E783: Load CRE tiles, tileset tiles and tileset palette ;;;
{
$82:E783 08          PHP
$82:E784 8B          PHB
$82:E785 C2 30       REP #$30
$82:E787 F4 00 8F    PEA $8F00              ;\
$82:E78A AB          PLB                    ;} DB = $8F
$82:E78B AB          PLB                    ;/
}


;;; $E78C: Load CRE tiles, tileset tiles and tileset palette ;;;
{
$82:E78C 9C 16 0E    STZ $0E16  [$7E:0E16]  ; Elevator properties = 0
$82:E78F A9 80 00    LDA #$0080             ;\
$82:E792 8D 15 21    STA $2115  [$7E:2115]  ;|
$82:E795 A9 00 B9    LDA #$B900             ;|
$82:E798 85 48       STA $48    [$7E:0048]  ;|
$82:E79A A9 00 80    LDA #$8000             ;|
$82:E79D 85 47       STA $47    [$7E:0047]  ;} Decompress $B9:8000 to VRAM $2800 (CRE tiles)
$82:E79F A9 00 50    LDA #$5000             ;|
$82:E7A2 85 4C       STA $4C    [$7E:004C]  ;|
$82:E7A4 4A          LSR A                  ;|
$82:E7A5 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:E7A8 22 71 B2 80 JSL $80B271[$80:B271]  ;/
$82:E7AC AD C4 07    LDA $07C4  [$7E:07C4]  ;\
$82:E7AF 85 48       STA $48    [$7E:0048]  ;|
$82:E7B1 AD C3 07    LDA $07C3  [$7E:07C3]  ;|
$82:E7B4 85 47       STA $47    [$7E:0047]  ;} Decompress [tileset tiles pointer] to VRAM $0000
$82:E7B6 9C 16 21    STZ $2116  [$7E:2116]  ;|
$82:E7B9 64 4C       STZ $4C    [$7E:004C]  ;|
$82:E7BB 22 71 B2 80 JSL $80B271[$80:B271]  ;/
$82:E7BF AD C7 07    LDA $07C7  [$7E:07C7]  ;\
$82:E7C2 85 48       STA $48    [$7E:0048]  ;|
$82:E7C4 AC C6 07    LDY $07C6  [$7E:07C6]  ;|
$82:E7C7 84 47       STY $47    [$7E:0047]  ;} Decompress [tileset palette pointer] to $7E:C200
$82:E7C9 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:E7CD             dl 7EC200              ;/
$82:E7D0 AB          PLB
$82:E7D1 28          PLP
$82:E7D2 6B          RTL
}


;;; $E7D3: Load level data, CRE, tile table, scroll data, create PLMs and execute door ASM and room setup ASM ;;;
{
; This routine is almost the same as gluing $EA73 and $EB6C together,
; the only difference being that this routine doesn't bother checking the CRE bitset to reload the CRE

; 'Level data' as pointed to by $07BD is a compressed block of data containing the actual level data, BTS data, and optionally custom layer 2 background data.
; It is decompressed to $7F:0000 where the first word gives the number of bytes of level data,
; followed by the level data (which is decompressed into the right location),
; followed by BTS data (which needs to be copied over to $7F:6402,
; optionally followed by custom layer 2 data (which is copied over to $7F:9602).

; As BTS data is half the size of level data, you get the following (slightly awkward) addresses for the begin and end of each data:
;     Level data: $7F:0002                      to $7F:0002 + [$7F:0000]
;     BTS:        $7F:0002 + [$7F:0000]         to $7F:0002 + [$7F:0000] / 2 * 3
;     Background: $7F:0002 + [$7F:0000] / 2 * 3 to $7F:0002 + [$7F:0000] / 2 * 5

$82:E7D3 08          PHP
$82:E7D4 8B          PHB
$82:E7D5 C2 30       REP #$30
$82:E7D7 F4 00 8F    PEA $8F00              ;\
$82:E7DA AB          PLB                    ;} DB = $8F
$82:E7DB AB          PLB                    ;/
$82:E7DC A2 FE 63    LDX #$63FE             ;\
$82:E7DF A9 00 80    LDA #$8000             ;|
                                            ;|
$82:E7E2 9F 02 00 7F STA $7F0002,x[$7F:6400];} $7F:0002..6401 = 8000h
$82:E7E6 CA          DEX                    ;|
$82:E7E7 CA          DEX                    ;|
$82:E7E8 10 F8       BPL $F8    [$E7E2]     ;/
$82:E7EA AD BE 07    LDA $07BE  [$7E:07BE]  ;\
$82:E7ED 85 48       STA $48    [$7E:0048]  ;|
$82:E7EF AD BD 07    LDA $07BD  [$7E:07BD]  ;|
$82:E7F2 85 47       STA $47    [$7E:0047]  ;} Decompress [level data pointer] to $7F:0000
$82:E7F4 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:E7F8             dl 7F0000              ;/
$82:E7FB 8B          PHB                    ;\
$82:E7FC F4 00 7F    PEA $7F00              ;|
$82:E7FF AB          PLB                    ;|
$82:E800 AB          PLB                    ;|
$82:E801 AD 00 00    LDA $0000  [$7F:0000]  ;|
$82:E804 AA          TAX                    ;|
$82:E805 4A          LSR A                  ;|
$82:E806 6D 00 00    ADC $0000  [$7F:0000]  ;|
$82:E809 6D 00 00    ADC $0000  [$7F:0000]  ;|
$82:E80C A8          TAY                    ;|
$82:E80D 80 06       BRA $06    [$E815]     ;} Mirror background data (regardless of whether custom layer 2 exists or not)
                                            ;|
$82:E80F B9 02 00    LDA $0002,y[$7F:0F00]  ;|
$82:E812 9D 02 96    STA $9602,x[$7F:9C00]  ;|
                                            ;|
$82:E815 88          DEY                    ;|
$82:E816 88          DEY                    ;|
$82:E817 CA          DEX                    ;|
$82:E818 CA          DEX                    ;|
$82:E819 10 F4       BPL $F4    [$E80F]     ;/
$82:E81B AD 00 00    LDA $0000  [$7F:0000]  ;\
$82:E81E 4A          LSR A                  ;|
$82:E81F AA          TAX                    ;|
$82:E820 6D 00 00    ADC $0000  [$7F:0000]  ;|
$82:E823 A8          TAY                    ;|
$82:E824 80 06       BRA $06    [$E82C]     ;|
                                            ;|
$82:E826 B9 02 00    LDA $0002,y[$7F:0900]  ;} Mirror BTS data
$82:E829 9D 02 64    STA $6402,x[$7F:6700]  ;|
                                            ;|
$82:E82C 88          DEY                    ;|
$82:E82D 88          DEY                    ;|
$82:E82E CA          DEX                    ;|
$82:E82F CA          DEX                    ;|
$82:E830 10 F4       BPL $F4    [$E826]     ;/
$82:E832 AB          PLB
$82:E833 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:E836 C9 06 00    CMP #$0006             ;} If not in Ceres: (no CRE bitset necessary)
$82:E839 F0 24       BEQ $24    [$E85F]     ;/
$82:E83B A9 00 B9    LDA #$B900             ;\
$82:E83E 85 48       STA $48    [$7E:0048]  ;|
$82:E840 A9 9D A0    LDA #$A09D             ;|
$82:E843 85 47       STA $47    [$7E:0047]  ;} Decompress CRE tile table to $7E:A000
$82:E845 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:E849             dl 7EA000              ;/
$82:E84C AD C1 07    LDA $07C1  [$7E:07C1]  ;\
$82:E84F 85 48       STA $48    [$7E:0048]  ;|
$82:E851 AD C0 07    LDA $07C0  [$7E:07C0]  ;|
$82:E854 85 47       STA $47    [$7E:0047]  ;} Decompress [tileset tile table pointer] to $7E:A800
$82:E856 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:E85A             dl 7EA800              ;/
$82:E85D 80 11       BRA $11    [$E870]

$82:E85F AD C1 07    LDA $07C1  [$7E:07C1]  ;\ Else (in Ceres):
$82:E862 85 48       STA $48    [$7E:0048]  ;|
$82:E864 AD C0 07    LDA $07C0  [$7E:07C0]  ;|
$82:E867 85 47       STA $47    [$7E:0047]  ;} Decompress [tileset tile table pointer] to $7E:A000
$82:E869 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:E86D             dl 7EA000              ;/

$82:E870 AE BB 07    LDX $07BB  [$7E:07BB]  ;\
$82:E873 BC 0E 00    LDY $000E,x[$8F:DF65]  ;} Y = (scroll pointer)
$82:E876 10 15       BPL $15    [$E88D]     ; If [Y] & 8000h = 0: go to BRANCH_PRESET_SCROLLS
$82:E878 A2 00 00    LDX #$0000             ;\
                                            ;|
$82:E87B B9 00 00    LDA $0000,y[$8F:9283]  ;|
$82:E87E 9F 20 CD 7E STA $7ECD20,x[$7E:CD20];|
$82:E882 C8          INY                    ;|
$82:E883 C8          INY                    ;} Copy 50 bytes from [Y] to room scrolls (regardless of the room size)
$82:E884 E8          INX                    ;|
$82:E885 E8          INX                    ;|
$82:E886 E0 32 00    CPX #$0032             ;|
$82:E889 D0 F0       BNE $F0    [$E87B]     ;/
$82:E88B 80 2C       BRA $2C    [$E8B9]     ; Go to BRANCH_SCROLLS_END

; BRANCH_PRESET_SCROLLS
$82:E88D 84 12       STY $12    [$7E:0012]  ; $12 = (scroll pointer)
$82:E88F E2 30       SEP #$30
$82:E891 AD AB 07    LDA $07AB  [$7E:07AB]  ;\
$82:E894 3A          DEC A                  ;} $14 = [room height in scrolls] - 1
$82:E895 85 14       STA $14    [$7E:0014]  ;/
$82:E897 A9 02       LDA #$02               ; A = green scroll
$82:E899 A2 00       LDX #$00               ; X = 0 (scroll index)
$82:E89B A0 00       LDY #$00               ; Y = 0 (scroll row)

; LOOP
$82:E89D C4 14       CPY $14    [$7E:0014]  ;\
$82:E89F D0 03       BNE $03    [$E8A4]     ;} If (scroll row) = [$14] (bottom row):
$82:E8A1 A5 12       LDA $12    [$7E:0012]  ;\
$82:E8A3 1A          INC A                  ;} A = (scroll pointer) + 1

$82:E8A4 5A          PHY
$82:E8A5 A0 00       LDY #$00               ;\
                                            ;|
$82:E8A7 9F 20 CD 7E STA $7ECD20,x[$7E:CD20];|
$82:E8AB E8          INX                    ;} Fill current row of scrolls with [A]
$82:E8AC C8          INY                    ;|
$82:E8AD CC A9 07    CPY $07A9  [$7E:07A9]  ;|
$82:E8B0 D0 F5       BNE $F5    [$E8A7]     ;/
$82:E8B2 7A          PLY
$82:E8B3 C8          INY                    ; Increment (scroll row)
$82:E8B4 CC AB 07    CPY $07AB  [$7E:07AB]  ;\
$82:E8B7 D0 E4       BNE $E4    [$E89D]     ;} If (scroll row) != [room height in scrolls]: go to LOOP

; BRANCH_SCROLLS_END
$82:E8B9 C2 30       REP #$30
$82:E8BB AE BB 07    LDX $07BB  [$7E:07BB]  ;\
$82:E8BE BD 14 00    LDA $0014,x[$8F:DF6B]  ;} If PLM pointer:
$82:E8C1 F0 12       BEQ $12    [$E8D5]     ;/
$82:E8C3 AA          TAX                    ;\
                                            ;|
$82:E8C4 BD 00 00    LDA $0000,x[$8F:C8BB]  ;|
$82:E8C7 F0 0C       BEQ $0C    [$E8D5]     ;|
$82:E8C9 22 6A 84 84 JSL $84846A[$84:846A]  ;|
$82:E8CD 8A          TXA                    ;} Create the PLMs
$82:E8CE 18          CLC                    ;|
$82:E8CF 69 06 00    ADC #$0006             ;|
$82:E8D2 AA          TAX                    ;|
$82:E8D3 80 EF       BRA $EF    [$E8C4]     ;/

$82:E8D5 22 A3 E8 8F JSL $8FE8A3[$8F:E8A3]  ; Execute door ASM
$82:E8D9 22 8F E8 8F JSL $8FE88F[$8F:E88F]  ; Execute room setup ASM
$82:E8DD AD 16 0E    LDA $0E16  [$7E:0E16]  ;\
$82:E8E0 F0 06       BEQ $06    [$E8E8]     ;} If door is an elevator:
$82:E8E2 A9 02 00    LDA #$0002             ;\
$82:E8E5 8D 18 0E    STA $0E18  [$7E:0E18]  ;} Elevator status = door transition

$82:E8E8 AB          PLB
$82:E8E9 28          PLP
$82:E8EA 6B          RTL
}


;;; $E8EB: Spawn door closing PLM ;;;
{
; PLM room argument is garbage then
$82:E8EB 08          PHP
$82:E8EC 8B          PHB
$82:E8ED C2 30       REP #$30
$82:E8EF F4 00 8F    PEA $8F00              ;\
$82:E8F2 AB          PLB                    ;} DB = $8F
$82:E8F3 AB          PLB                    ;/
$82:E8F4 20 1C E9    JSR $E91C  [$82:E91C]  ; Check if coloured doorcap was spawned, switch door PLM instruction lists if so
$82:E8F7 B0 20       BCS $20    [$E919]     ; If coloured doorcap was spawned: return
$82:E8F9 AD 91 07    LDA $0791  [$7E:0791]  ;\
$82:E8FC 0A          ASL A                  ;|
$82:E8FD 18          CLC                    ;|
$82:E8FE 69 8A E6    ADC #$E68A             ;} $12 = [$E68A + [door direction] * 2] (PLM ID)
$82:E901 AA          TAX                    ;|
$82:E902 BD 00 00    LDA $0000,x[$8F:E68A]  ;/
$82:E905 F0 12       BEQ $12    [$E919]     ; If [$12] = 0 (door has no cap): return
$82:E907 85 12       STA $12    [$7E:0012]
$82:E909 AE 8D 07    LDX $078D  [$7E:078D]  ;\
$82:E90C BF 04 00 83 LDA $830004,x[$83:891A];} $14 = [$83:0000 + [door pointer] + 4] (X and Y positions)
$82:E910 85 14       STA $14    [$7E:0014]  ;/
$82:E912 A2 12 00    LDX #$0012             ; X = $12
$82:E915 22 6A 84 84 JSL $84846A[$84:846A]  ; Spawn room PLM

$82:E919 AB          PLB
$82:E91A 28          PLP
$82:E91B 60          RTS
}


;;; $E91C: Check if coloured doorcap was spawned, switch door PLM instruction lists if so ;;;
{
; Disables IRQ during multiplication calculation, which is good practice seeing as interrupt handler can write to those registers,
; although this is the only piece of code in the game that does that
$82:E91C AE 8D 07    LDX $078D  [$7E:078D]  ; X = [door pointer]
$82:E91F 78          SEI                    ; Disable IRQ
$82:E920 E2 20       SEP #$20
$82:E922 BF 05 00 83 LDA $830005,x[$83:AB51];\
$82:E926 8D 02 42    STA $4202  [$7E:4202]  ;|
$82:E929 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$82:E92C 8D 03 42    STA $4203  [$7E:4203]  ;|
$82:E92F BF 04 00 83 LDA $830004,x[$83:AB50];|
$82:E933 C2 20       REP #$20               ;} A = [$83:0000 + [X] + 5] * [room width] + [$83:8000 + [X] + 4]
$82:E935 29 FF 00    AND #$00FF             ;|
$82:E938 18          CLC                    ;|
$82:E939 6D 16 42    ADC $4216  [$7E:4216]  ;|
$82:E93C 0A          ASL A                  ;/
$82:E93D 58          CLI                    ; Enable IRQ
$82:E93E A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$82:E941 DD 87 1C    CMP $1C87,x[$7E:1CD5]  ;\
$82:E944 F0 06       BEQ $06    [$E94C]     ;} If [PLM block index] = 0: go to BRANCH_FOUND
$82:E946 CA          DEX                    ;\
$82:E947 CA          DEX                    ;} X -= 2
$82:E948 10 F7       BPL $F7    [$E941]     ; If [X] >= 0: go to LOOP

; BRANCH_NO_COLOURED_DOOR
$82:E94A 18          CLC                    ;\
$82:E94B 60          RTS                    ;} Return carry clear

; BRANCH_FOUND
$82:E94C BD 37 1C    LDA $1C37,x[$7E:1C83]  ;\
$82:E94F F0 F9       BEQ $F9    [$E94A]     ;} If [PLM ID] = 0: go to BRANCH_NO_COLOURED_DOOR
$82:E951 BD C7 1D    LDA $1DC7,x[$7E:1E0F]  ;\
$82:E954 30 0F       BMI $0F    [$E965]     ;} If [PLM room argument] & 8000h = 0:
$82:E956 DA          PHX                    ;\
$82:E957 22 8E 81 80 JSL $80818E[$80:818E]  ;|
$82:E95B BF B0 D8 7E LDA $7ED8B0,x[$7E:D8B6];|
$82:E95F FA          PLX                    ;} If PLM room argument door is set: go to BRANCH_NO_COLOURED_DOOR
$82:E960 2D E7 05    AND $05E7  [$7E:05E7]  ;|
$82:E963 D0 E5       BNE $E5    [$E94A]     ;/

$82:E965 A9 01 00    LDA #$0001             ;\
$82:E968 9F 1C DE 7E STA $7EDE1C,x[$7E:DE64];} PLM instruction timer = 1
$82:E96C 9B          TXY
$82:E96D BD 37 1C    LDA $1C37,x[$7E:1C7F]  ;\
$82:E970 F0 D8       BEQ $D8    [$E94A]     ;} If [PLM ID] = 0: go to BRANCH_NO_COLOURED_DOOR
$82:E972 AA          TAX                    ;\
$82:E973 BF 04 00 84 LDA $840004,x[$84:C84C];} PLM instruction list pointer = [$84:0000 + [PLM ID] + 4] (the third PLM header pointer!)
$82:E977 99 27 1D    STA $1D27,y[$7E:1D6F]  ;/
$82:E97A 38          SEC                    ;\
$82:E97B 60          RTS                    ;} Return carry set
}
}


;;; $E97C..EA72: Load library background ;;;
{
;;; $E97C: Load library background ;;;
{
; Called when loading game or unpausing. For door transitions, see $E512
; Note that when unpausing, $8D96 (restore BG2 tilemap from pause screen) gets executed,
; overwriting any changes made to the BG2 tilemap here
$82:E97C 08          PHP
$82:E97D 8B          PHB
$82:E97E C2 30       REP #$30
$82:E980 22 9C A2 80 JSL $80A29C[$80:A29C]  ; Clear FX tilemap
$82:E984 AD 64 19    LDA $1964  [$7E:1964]  ;\
$82:E987 F0 30       BEQ $30    [$E9B9]     ;} [FX tilemap pointer] != 0:
$82:E989 8D 12 43    STA $4312  [$7E:4312]  ;\
$82:E98C A9 E0 5B    LDA #$5BE0             ;|
$82:E98F 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:E992 A9 01 18    LDA #$1801             ;|
$82:E995 8D 10 43    STA $4310  [$7E:4310]  ;|
$82:E998 A9 8A 00    LDA #$008A             ;|
$82:E99B 8D 14 43    STA $4314  [$7E:4314]  ;|
$82:E99E A9 40 08    LDA #$0840             ;} Transfer 840h bytes from [$8A:0000 + [FX tilemap pointer]] to VRAM $5BE0
$82:E9A1 8D 15 43    STA $4315  [$7E:4315]  ;|
$82:E9A4 E2 20       SEP #$20               ;|
$82:E9A6 A9 80       LDA #$80               ;|
$82:E9A8 8D 15 21    STA $2115  [$7E:2115]  ;|
$82:E9AB A9 02       LDA #$02               ;|
$82:E9AD 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:E9B0 C2 20       REP #$20
$82:E9B2 98          TYA                    ;\
$82:E9B3 18          CLC                    ;|
$82:E9B4 69 07 00    ADC #$0007             ;} >_<
$82:E9B7 A8          TAY                    ;|
$82:E9B8 18          CLC                    ;/

$82:E9B9 F4 00 8F    PEA $8F00              ;\
$82:E9BC AB          PLB                    ;} DB = $8F
$82:E9BD AB          PLB                    ;/
$82:E9BE C2 20       REP #$20
$82:E9C0 AE BB 07    LDX $07BB  [$7E:07BB]  ;\
$82:E9C3 BC 16 00    LDY $0016,x[$8F:DF6D]  ;} Y = library background pointer
$82:E9C6 10 0A       BPL $0A    [$E9D2]     ; If [Y] < 8000h: return

; LOOP
$82:E9C8 BE 00 00    LDX $0000,y[$8F:E1D4]  ;\
$82:E9CB C8          INY                    ;} Y += 2
$82:E9CC C8          INY                    ;} Execute [$E9D5 + [Y] - 2]
$82:E9CD FC D5 E9    JSR ($E9D5,x)[$82:EA56];/
$82:E9D0 90 F6       BCC $F6    [$E9C8]     ; If carry clear: go to LOOP

$82:E9D2 AB          PLB
$82:E9D3 28          PLP
$82:E9D4 6B          RTL

$82:E9D5             dw E9E5, E9F9, EA2D, EA4E, EA66, EA56, EA5E, E9E7
}


;;; $E9E5: Load library background - command 0: terminator ;;;
{
$82:E9E5 38          SEC                    ;\
$82:E9E6 60          RTS                    ;} Return carry set
}


;;; $E9E7: Load library background - command Eh: door dependent transfer to VRAM ;;;
{
; Command Eh is only used by landing site, WS entrance and WS back door
$82:E9E7 AD 8D 07    LDA $078D  [$7E:078D]  ;\
$82:E9EA D9 00 00    CMP $0000,y[$8F:B76C]  ;} If [door pointer] != [[Y]]:
$82:E9ED F0 08       BEQ $08    [$E9F7]     ;/
$82:E9EF 98          TYA                    ;\
$82:E9F0 18          CLC                    ;|
$82:E9F1 69 09 00    ADC #$0009             ;} Y += 9
$82:E9F4 A8          TAY                    ;/
$82:E9F5 18          CLC                    ;\
$82:E9F6 60          RTS                    ;} Return carry clear

$82:E9F7 C8          INY                    ;\
$82:E9F8 C8          INY                    ;} Y += 2
}


;;; $E9F9: Load library background - command 2: transfer to VRAM ;;;
{
$82:E9F9 B9 03 00    LDA $0003,y[$8F:B79D]  ;\
$82:E9FC 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:E9FF A9 01 18    LDA #$1801             ;|
$82:EA02 8D 10 43    STA $4310  [$7E:4310]  ;|
$82:EA05 B9 00 00    LDA $0000,y[$8F:B79A]  ;|
$82:EA08 8D 12 43    STA $4312  [$7E:4312]  ;|
$82:EA0B B9 02 00    LDA $0002,y[$8F:B79C]  ;|
$82:EA0E 8D 14 43    STA $4314  [$7E:4314]  ;} Transfer [[Y] + 5] bytes from [[Y]] to VRAM [[Y] + 3]
$82:EA11 B9 05 00    LDA $0005,y[$8F:B79F]  ;|
$82:EA14 8D 15 43    STA $4315  [$7E:4315]  ;|
$82:EA17 E2 20       SEP #$20               ;|
$82:EA19 A9 80       LDA #$80               ;|
$82:EA1B 8D 15 21    STA $2115  [$7E:2115]  ;|
$82:EA1E A9 02       LDA #$02               ;|
$82:EA20 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:EA23 C2 20       REP #$20
$82:EA25 98          TYA                    ;\
$82:EA26 18          CLC                    ;|
$82:EA27 69 07 00    ADC #$0007             ;} Y += 7
$82:EA2A A8          TAY                    ;/
$82:EA2B 18          CLC                    ;\
$82:EA2C 60          RTS                    ;} Return carry clear
}


;;; $EA2D: Load library background - command 4: decompression ;;;
{
$82:EA2D 5A          PHY
$82:EA2E B9 00 00    LDA $0000,y[$8F:BAF6]  ;\
$82:EA31 85 47       STA $47    [$7E:0047]  ;|
$82:EA33 B9 01 00    LDA $0001,y[$8F:BAF7]  ;|
$82:EA36 85 48       STA $48    [$7E:0048]  ;|
$82:EA38 A9 00 7E    LDA #$7E00             ;} Decompress [[Y]] to $7E:0000 | [[Y] + 3]
$82:EA3B 85 4D       STA $4D    [$7E:004D]  ;|
$82:EA3D B9 03 00    LDA $0003,y[$8F:BAF9]  ;|
$82:EA40 85 4C       STA $4C    [$7E:004C]  ;|
$82:EA42 22 19 B1 80 JSL $80B119[$80:B119]  ;/
$82:EA46 68          PLA                    ;\
$82:EA47 18          CLC                    ;|
$82:EA48 69 05 00    ADC #$0005             ;} Y += 5
$82:EA4B A8          TAY                    ;/
$82:EA4C 18          CLC                    ;\
$82:EA4D 60          RTS                    ;} Return carry clear
}


;;; $EA4E: Load library background - command 6: clear FX tilemap ;;;
{
; Command 6 is unused
$82:EA4E 5A          PHY
$82:EA4F 22 9C A2 80 JSL $80A29C[$80:A29C]  ; Clear FX tilemap
$82:EA53 7A          PLY
$82:EA54 18          CLC                    ;\
$82:EA55 60          RTS                    ;} Return carry clear
}


;;; $EA56: Load library background - command Ah: clear BG2 tilemap ;;;
{
; Command Ah is only used by:
;     Phanton's room and Draygon's room (which aren't load station rooms)
;     Ceres elevator shaft (which doesn't display BG2)

; So this routine has no observable effect (and hence the bug in $80:A23F doesn't show)

$82:EA56 5A          PHY
$82:EA57 22 3F A2 80 JSL $80A23F[$80:A23F]  ; Clear BG2 tilemap
$82:EA5B 7A          PLY
$82:EA5C 18          CLC                    ;\
$82:EA5D 60          RTS                    ;} Return carry clear
}


;;; $EA5E: Load library background - command Ch: clear Kraid's layer 2 ;;;
{
; Identical to $EA56
; Command Ch is only used by Kraid's room (which isn't a load station room),
; so this routine has no observable effect (and hence the bug in $80:A23F doesn't show)

$82:EA5E 5A          PHY
$82:EA5F 22 3F A2 80 JSL $80A23F[$80:A23F]  ; Clear BG2 tilemap
$82:EA63 7A          PLY
$82:EA64 18          CLC                    ;\
$82:EA65 60          RTS                    ;} Return carry clear
}


;;; $EA66: Load library background - command 8: transfer to VRAM and set BG3 tiles base address = $2000 ;;;
{
; Command 8 is only used by Kraid's room
$82:EA66 20 F9 E9    JSR $E9F9  [$82:E9F9]  ; Command 2: transfer to VRAM
$82:EA69 E2 20       SEP #$20               ;\
$82:EA6B A9 02       LDA #$02               ;|
$82:EA6D 85 5E       STA $5E    [$7E:005E]  ;} BG3 tiles base address = $2000
$82:EA6F C2 20       REP #$20               ;/
$82:EA71 18          CLC                    ;\
$82:EA72 60          RTS                    ;} Return carry clear
}
}


;;; $EA73: Load level, scroll and CRE data ;;;
{
; 'Level data' as pointed to by $07BD is a compressed block of data containing the actual level data, BTS data, and optionally custom layer 2 background data.
; It is decompressed to $7F:0000 where the first word gives the number of bytes of level data,
; followed by the level data (which is decompressed into the right location),
; followed by BTS data (which needs to be copied over to $7F:6402,
; optionally followed by custom layer 2 data (which is copied over to $7F:9602).

; As BTS data is half the size of level data, you get the following (slightly awkward) addresses for the begin and end of each data:
;     Level data: $7F:0002                      to $7F:0002 + [$7F:0000]
;     BTS:        $7F:0002 + [$7F:0000]         to $7F:0002 + [$7F:0000] / 2 * 3
;     Background: $7F:0002 + [$7F:0000] / 2 * 3 to $7F:0002 + [$7F:0000] / 2 * 5

$82:EA73 F4 00 8F    PEA $8F00              ;\
$82:EA76 AB          PLB                    ;} DB = $8F
$82:EA77 AB          PLB                    ;/
$82:EA78 A2 FE 18    LDX #$18FE             ;\
$82:EA7B A9 00 80    LDA #$8000             ;|
                                            ;|
$82:EA7E 9F 02 00 7F STA $7F0002,x[$7F:1900];|
$82:EA82 9F 02 19 7F STA $7F1902,x[$7F:3200];|
$82:EA86 9F 02 32 7F STA $7F3202,x[$7F:4B00];} $7F:0002..6401 = 8000h
$82:EA8A 9F 02 4B 7F STA $7F4B02,x[$7F:6400];|
$82:EA8E CA          DEX                    ;|
$82:EA8F CA          DEX                    ;|
$82:EA90 10 EC       BPL $EC    [$EA7E]     ;/
$82:EA92 AD BE 07    LDA $07BE  [$7E:07BE]  ;\
$82:EA95 85 48       STA $48    [$7E:0048]  ;|
$82:EA97 AD BD 07    LDA $07BD  [$7E:07BD]  ;|
$82:EA9A 85 47       STA $47    [$7E:0047]  ;} Decompress [level data pointer] to $7F:0000
$82:EA9C 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:EAA0             dl 7F0000              ;/
$82:EAA3 8B          PHB                    ;\
$82:EAA4 F4 00 7F    PEA $7F00              ;|
$82:EAA7 AB          PLB                    ;|
$82:EAA8 AB          PLB                    ;|
$82:EAA9 AD 00 00    LDA $0000  [$7F:0000]  ;|
$82:EAAC AA          TAX                    ;|
$82:EAAD 4A          LSR A                  ;|
$82:EAAE 6D 00 00    ADC $0000  [$7F:0000]  ;|
$82:EAB1 6D 00 00    ADC $0000  [$7F:0000]  ;|
$82:EAB4 A8          TAY                    ;} Mirror background data (regardless of whether custom layer 2 exists or not)
$82:EAB5 80 06       BRA $06    [$EABD]     ;|
                                            ;|
$82:EAB7 B9 02 00    LDA $0002,y[$7F:0A00]  ;|
$82:EABA 9D 02 96    STA $9602,x[$7F:9A00]  ;|
                                            ;|
$82:EABD 88          DEY                    ;|
$82:EABE 88          DEY                    ;|
$82:EABF CA          DEX                    ;|
$82:EAC0 CA          DEX                    ;|
$82:EAC1 10 F4       BPL $F4    [$EAB7]     ;/
$82:EAC3 AD 00 00    LDA $0000  [$7F:0000]  ;\
$82:EAC6 4A          LSR A                  ;|
$82:EAC7 AA          TAX                    ;|
$82:EAC8 6D 00 00    ADC $0000  [$7F:0000]  ;|
$82:EACB A8          TAY                    ;|
$82:EACC 80 06       BRA $06    [$EAD4]     ;|
                                            ;|
$82:EACE B9 02 00    LDA $0002,y[$7F:0600]  ;} Mirror BTS data
$82:EAD1 9D 02 64    STA $6402,x[$7F:6600]  ;|
                                            ;|
$82:EAD4 88          DEY                    ;|
$82:EAD5 88          DEY                    ;|
$82:EAD6 CA          DEX                    ;|
$82:EAD7 CA          DEX                    ;|
$82:EAD8 10 F4       BPL $F4    [$EACE]     ;/
$82:EADA AB          PLB
$82:EADB AD 9F 07    LDA $079F  [$7E:079F]  ;\
$82:EADE C9 06 00    CMP #$0006             ;} If not in Ceres:
$82:EAE1 F0 2C       BEQ $2C    [$EB0F]     ;/
$82:EAE3 AD B3 07    LDA $07B3  [$7E:07B3]  ;\
$82:EAE6 89 02 00    BIT #$0002             ;} If [CRE bitset] & 2 (reload CRE):
$82:EAE9 F0 11       BEQ $11    [$EAFC]     ;/
$82:EAEB A9 00 B9    LDA #$B900             ;\
$82:EAEE 85 48       STA $48    [$7E:0048]  ;|
$82:EAF0 A9 9D A0    LDA #$A09D             ;|
$82:EAF3 85 47       STA $47    [$7E:0047]  ;} Decompress CRE tile table to $7E:A000
$82:EAF5 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:EAF9             dl 7EA000              ;/

$82:EAFC AD C1 07    LDA $07C1  [$7E:07C1]  ;\
$82:EAFF 85 48       STA $48    [$7E:0048]  ;|
$82:EB01 AD C0 07    LDA $07C0  [$7E:07C0]  ;|
$82:EB04 85 47       STA $47    [$7E:0047]  ;} Decompress [tileset tile table pointer] to $7E:A800
$82:EB06 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:EB0A             dl 7EA800              ;/
$82:EB0D 80 11       BRA $11    [$EB20]

$82:EB0F AD C1 07    LDA $07C1  [$7E:07C1]  ;\ Else (in Ceres):
$82:EB12 85 48       STA $48    [$7E:0048]  ;|
$82:EB14 AD C0 07    LDA $07C0  [$7E:07C0]  ;|
$82:EB17 85 47       STA $47    [$7E:0047]  ;} Decompress [tileset tile table pointer] to $7E:A000
$82:EB19 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:EB1D             dl 7EA000              ;/

$82:EB20 AE BB 07    LDX $07BB  [$7E:07BB]  ;\
$82:EB23 BC 0E 00    LDY $000E,x[$8F:DFAD]  ;} Y = (scroll pointer)
$82:EB26 10 15       BPL $15    [$EB3D]     ; If [Y] & 8000h = 0: go to BRANCH_PRESET_SCROLLS
$82:EB28 A2 00 00    LDX #$0000             ;\
                                            ;|
$82:EB2B B9 00 00    LDA $0000,y[$8F:9370]  ;|
$82:EB2E 9F 20 CD 7E STA $7ECD20,x[$7E:CD20];|
$82:EB32 C8          INY                    ;|
$82:EB33 C8          INY                    ;} Copy 50 bytes from [Y] to room scrolls (regardless of the room size)
$82:EB34 E8          INX                    ;|
$82:EB35 E8          INX                    ;|
$82:EB36 E0 32 00    CPX #$0032             ;|
$82:EB39 D0 F0       BNE $F0    [$EB2B]     ;/
$82:EB3B 80 2C       BRA $2C    [$EB69]     ; Return

; BRANCH_PRESET_SCROLLS
$82:EB3D 84 12       STY $12    [$7E:0012]  ; $12 = (scroll pointer)
$82:EB3F E2 30       SEP #$30
$82:EB41 AD AB 07    LDA $07AB  [$7E:07AB]  ;\
$82:EB44 3A          DEC A                  ;} $14 = [room height in scrolls] - 1
$82:EB45 85 14       STA $14    [$7E:0014]  ;/
$82:EB47 A9 02       LDA #$02               ; A = green scroll
$82:EB49 A2 00       LDX #$00               ; X = 0 (scroll index)
$82:EB4B A0 00       LDY #$00               ; Y = 0 (scroll row)

; LOOP
$82:EB4D C4 14       CPY $14    [$7E:0014]  ;\
$82:EB4F D0 03       BNE $03    [$EB54]     ;} If (scroll row) = [$14] (bottom row):
$82:EB51 A5 12       LDA $12    [$7E:0012]  ;\
$82:EB53 1A          INC A                  ;} A = (scroll pointer) + 1

$82:EB54 5A          PHY
$82:EB55 A0 00       LDY #$00               ;\
                                            ;|
$82:EB57 9F 20 CD 7E STA $7ECD20,x[$7E:CD20];|
$82:EB5B E8          INX                    ;} Fill current row of scrolls with [A]
$82:EB5C C8          INY                    ;|
$82:EB5D CC A9 07    CPY $07A9  [$7E:07A9]  ;|
$82:EB60 D0 F5       BNE $F5    [$EB57]     ;/
$82:EB62 7A          PLY
$82:EB63 C8          INY                    ; Increment (scroll row)
$82:EB64 CC AB 07    CPY $07AB  [$7E:07AB]  ;\
$82:EB67 D0 E4       BNE $E4    [$EB4D]     ;} If (scroll row) != [room height in scrolls]: go to LOOP

$82:EB69 C2 30       REP #$30
$82:EB6B 6B          RTL
}


;;; $EB6C: Create PLMs, execute door ASM, room setup ASM and set elevator status ;;;
{
$82:EB6C F4 00 8F    PEA $8F00              ;\
$82:EB6F AB          PLB                    ;} DB = $8F
$82:EB70 AB          PLB                    ;/
$82:EB71 AE BB 07    LDX $07BB  [$7E:07BB]  ;\
$82:EB74 BD 14 00    LDA $0014,x[$8F:DFB3]  ;} If (PLM pointer) = 0: go to BRANCH_NO_PLMS
$82:EB77 F0 12       BEQ $12    [$EB8B]     ;/
$82:EB79 AA          TAX                    ; X = (PLM pointer)

; LOOP
$82:EB7A BD 00 00    LDA $0000,x[$8F:C8BD]  ;\
$82:EB7D F0 0C       BEQ $0C    [$EB8B]     ;} If [[X]] != 0:
$82:EB7F 22 6A 84 84 JSL $84846A[$84:846A]  ; Spawn room PLM
$82:EB83 8A          TXA                    ;\
$82:EB84 18          CLC                    ;|
$82:EB85 69 06 00    ADC #$0006             ;} X += 5
$82:EB88 AA          TAX                    ;/
$82:EB89 80 EF       BRA $EF    [$EB7A]     ; Go to LOOP

; BRANCH_NO_PLMS
$82:EB8B 22 A3 E8 8F JSL $8FE8A3[$8F:E8A3]  ; Execute door ASM
$82:EB8F 22 8F E8 8F JSL $8FE88F[$8F:E88F]  ; Execute room setup ASM
$82:EB93 AD 16 0E    LDA $0E16  [$7E:0E16]  ;\
$82:EB96 F0 06       BEQ $06    [$EB9E]     ;} If door is an elevator:
$82:EB98 A9 02 00    LDA #$0002             ;\
$82:EB9B 8D 18 0E    STA $0E18  [$7E:0E18]  ;} Elevator status = door transition

$82:EB9E 6B          RTL
}


;;; $EB9F..F70D: Game options menu ;;;
{
;;; $EB9F: Game state 2 (game options menu) ;;;
{
$82:EB9F 08          PHP
$82:EBA0 8B          PHB
$82:EBA1 4B          PHK                    ;\
$82:EBA2 AB          PLB                    ;} DB = $82
$82:EBA3 C2 30       REP #$30
$82:EBA5 AD E2 0D    LDA $0DE2  [$7E:0DE2]  ;\
$82:EBA8 0A          ASL A                  ;|
$82:EBA9 AA          TAX                    ;} Execute [$EBC1 + [game options menu index] * 2]
$82:EBAA FC C1 EB    JSR ($EBC1,x)[$82:EBDB];/
$82:EBAD 20 11 8C    JSR $8C11  [$82:8C11]  ; Game options menu object handler
$82:EBB0 20 A1 8C    JSR $8CA1  [$82:8CA1]  ; Draw game options menu spritemaps
$82:EBB3 AD E2 0D    LDA $0DE2  [$7E:0DE2]  ;\
$82:EBB6 C9 02 00    CMP #$0002             ;} If [game options menu index] > loading options menu:
$82:EBB9 30 03       BMI $03    [$EBBE]     ;/
$82:EBBB 20 FF EC    JSR $ECFF  [$82:ECFF]  ; Draw game options menu BG1

$82:EBBE AB          PLB
$82:EBBF 28          PLP
$82:EBC0 60          RTS

$82:EBC1             dw EBDB, ; 0: Finish fading out
                        EC11, ; 1: Loading options menu
                        ECE4, ; 2: Fading in options menu
                        ED42, ; 3: Options menu
                        EEB4, ; 4: Start game
                        EF18, ; 5: Dissolve out screen
                        EFDB, ; 6: Dissolve in screen
                        F159, ; 7: Controller settings
                        F024, ; 8: Special settings
                        F271, ; 9: Scroll controller settings down
                        F285, ; Ah: Scroll controller settings up
                        EE6A, ; Bh: Transition back to file select
                        EE92  ; Ch: Fading out options menu to start game
}


;;; $EBDB: Game state 2 (game options menu) - [$0DE2] = 0 (finish fading out) ;;;
{
$82:EBDB 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:EBDF E2 20       SEP #$20
$82:EBE1 A5 51       LDA $51    [$7E:0051]  ;\
$82:EBE3 C9 80       CMP #$80               ;} If finished fading out:
$82:EBE5 D0 10       BNE $10    [$EBF7]     ;/
$82:EBE7 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:EBEB C2 20       REP #$20
$82:EBED 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:EBF0 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:EBF3 EE E2 0D    INC $0DE2  [$7E:0DE2]  ; Game options menu index = 1
$82:EBF6 60          RTS                    ; Return

$82:EBF7 E2 20       SEP #$20
$82:EBF9 A5 51       LDA $51    [$7E:0051]  ;\
$82:EBFB C9 0E       CMP #$0E               ;} If [brightness] = Eh:
$82:EBFD D0 0F       BNE $0F    [$EC0E]     ;/
$82:EBFF A5 6B       LDA $6B    [$7E:006B]  ;\
$82:EC01 89 04       BIT #$04               ;} If BG3 disabled:
$82:EC03 D0 09       BNE $09    [$EC0E]     ;/
$82:EC05 C2 20       REP #$20
$82:EC07 A0 D6 F4    LDY #$F4D6             ;\
$82:EC0A 20 CB 8B    JSR $8BCB  [$82:8BCB]  ;} Spawn border around SAMUS DATA
$82:EC0D 60          RTS

$82:EC0E C2 20       REP #$20
$82:EC10 60          RTS
}


;;; $EC11: Game state 2 (game options menu) - [$0DE2] = 1 (loading options menu) ;;;
{
; Assumes forced blank
$82:EC11 08          PHP
$82:EC12 E2 30       SEP #$30
$82:EC14 A9 00       LDA #$00               ;\
$82:EC16 85 5D       STA $5D    [$7E:005D]  ;} BG1/2 tiles base address = $0000
$82:EC18 A9 13       LDA #$13               ;\
$82:EC1A 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$82:EC1C 64 6B       STZ $6B    [$7E:006B]  ; Disable all subscreen layers
$82:EC1E 64 6C       STZ $6C    [$7E:006C]  ;\
$82:EC20 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area
$82:EC22 64 6E       STZ $6E    [$7E:006E]  ;\
$82:EC24 64 71       STZ $71    [$7E:0071]  ;|
$82:EC26 64 6F       STZ $6F    [$7E:006F]  ;} Disable colour math
$82:EC28 64 72       STZ $72    [$7E:0072]  ;/
$82:EC2A A9 00       LDA #$00               ;\
$82:EC2C 8D 16 21    STA $2116  [$7E:2116]  ;|
$82:EC2F A9 58       LDA #$58               ;|
$82:EC31 8D 17 21    STA $2117  [$7E:2117]  ;|
$82:EC34 A9 80       LDA #$80               ;|
$82:EC36 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $5800..5BFF = [$8E:DC00..E3FF] (Zebes and stars tilemap)
$82:EC39 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$82:EC3D             dx 01,01,18,8EDC00,0800;|
$82:EC45 A9 02       LDA #$02               ;|
$82:EC47 8D 0B 42    STA $420B  [$7E:420B]  ;/
$82:EC4A C2 30       REP #$30
$82:EC4C 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$82:EC4E 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$82:EC50 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$82:EC52 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$82:EC54 9C E0 0D    STZ $0DE0  [$7E:0DE0]  ; Disable debug invincibility
$82:EC57 A2 FE 01    LDX #$01FE             ;\
                                            ;|
$82:EC5A BF 00 E4 8E LDA $8EE400,x[$8E:E5FE];|
$82:EC5E 9F 00 C0 7E STA $7EC000,x[$7E:C1FE];} Palettes = [$8E:E400..E5FF] (menu palettes)
$82:EC62 CA          DEX                    ;|
$82:EC63 CA          DEX                    ;|
$82:EC64 10 F4       BPL $F4    [$EC5A]     ;/
$82:EC66 A9 00 97    LDA #$9700             ;\
$82:EC69 85 48       STA $48    [$7E:0048]  ;|
$82:EC6B A9 F4 8D    LDA #$8DF4             ;|
$82:EC6E 85 47       STA $47    [$7E:0047]  ;} Decompress $97:8DF4 to $7F:C000 (tilemap - game options menu - options screen)
$82:EC70 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:EC74             dl 7FC000              ;/
$82:EC77 A9 00 97    LDA #$9700             ;\
$82:EC7A 85 48       STA $48    [$7E:0048]  ;|
$82:EC7C A9 CD 8F    LDA #$8FCD             ;|
$82:EC7F 85 47       STA $47    [$7E:0047]  ;} Decompress $97:8FCD to $7F:C800 (tilemap - game options menu - controller settings - English)
$82:EC81 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:EC85             dl 7FC800              ;/
$82:EC88 A9 00 97    LDA #$9700             ;\
$82:EC8B 85 48       STA $48    [$7E:0048]  ;|
$82:EC8D A9 C4 91    LDA #$91C4             ;|
$82:EC90 85 47       STA $47    [$7E:0047]  ;} Decompress $97:91C4 to $7F:D000 (tilemap - game options menu - controller settings - Japanese)
$82:EC92 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:EC96             dl 7FD000              ;/
$82:EC99 A9 00 97    LDA #$9700             ;\
$82:EC9C 85 48       STA $48    [$7E:0048]  ;|
$82:EC9E A9 8D 93    LDA #$938D             ;|
$82:ECA1 85 47       STA $47    [$7E:0047]  ;} Decompress $97:938D to $7F:D800 (tilemap - game options menu - special settings - English)
$82:ECA3 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:ECA7             dl 7FD800              ;/
$82:ECAA A9 00 97    LDA #$9700             ;\
$82:ECAD 85 48       STA $48    [$7E:0048]  ;|
$82:ECAF A9 3A 95    LDA #$953A             ;|
$82:ECB2 85 47       STA $47    [$7E:0047]  ;} Decompress $97:953A to $7F:E000 (tilemap - game options menu - special settings - Japanese)
$82:ECB4 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$82:ECB8             dl 7FE000              ;/
$82:ECBB A2 FE 07    LDX #$07FE             ;\
                                            ;|
$82:ECBE BF 00 C0 7F LDA $7FC000,x[$7F:C7FE];|
$82:ECC2 9F 00 30 7E STA $7E3000,x[$7E:37FE];} Game options menu tilemap = [$7F:C000..C7FF] (tilemap - game options menu - options screen)
$82:ECC6 CA          DEX                    ;|
$82:ECC7 CA          DEX                    ;|
$82:ECC8 10 F4       BPL $F4    [$ECBE]     ;/
$82:ECCA 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:ECCD 20 B9 8B    JSR $8BB9  [$82:8BB9]  ; Delete game options menu objects
$82:ECD0 A0 B8 F4    LDY #$F4B8             ;\
$82:ECD3 20 CB 8B    JSR $8BCB  [$82:8BCB]  ;} Spawn menu selection missile
$82:ECD6 A0 C4 F4    LDY #$F4C4             ;\
$82:ECD9 20 CB 8B    JSR $8BCB  [$82:8BCB]  ;} Spawn border around OPTIONS MODE
$82:ECDC EE E2 0D    INC $0DE2  [$7E:0DE2]  ; Game options menu index = 2
$82:ECDF 20 ED ED    JSR $EDED  [$82:EDED]  ; Set language text option highlight
$82:ECE2 28          PLP
$82:ECE3 60          RTS
}


;;; $ECE4: Game state 2 (game options menu) - [$0DE2] = 2 (fading in options menu) ;;;
{
$82:ECE4 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$82:ECE8 E2 20       SEP #$20
$82:ECEA A5 51       LDA $51    [$7E:0051]  ;\
$82:ECEC C9 0F       CMP #$0F               ;} If not finished fading in: return
$82:ECEE D0 0C       BNE $0C    [$ECFC]     ;/
$82:ECF0 C2 20       REP #$20
$82:ECF2 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:ECF5 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:ECF8 EE E2 0D    INC $0DE2  [$7E:0DE2]  ; Game options menu index = 3
$82:ECFB 60          RTS                    ; Return

$82:ECFC C2 20       REP #$20
$82:ECFE 60          RTS
}


;;; $ECFF: Draw game options menu BG1 ;;;
{
; Queue transfer of $7E:3000..37FF to VRAM $5000..53FF
$82:ECFF 08          PHP
$82:ED00 C2 30       REP #$30
$82:ED02 AE 30 03    LDX $0330  [$7E:0330]
$82:ED05 A9 00 08    LDA #$0800
$82:ED08 95 D0       STA $D0,x  [$7E:00D0]
$82:ED0A E8          INX
$82:ED0B E8          INX
$82:ED0C A9 00 30    LDA #$3000
$82:ED0F 95 D0       STA $D0,x  [$7E:00D2]
$82:ED11 E8          INX
$82:ED12 E8          INX
$82:ED13 E2 20       SEP #$20
$82:ED15 A9 7E       LDA #$7E
$82:ED17 95 D0       STA $D0,x  [$7E:00D4]
$82:ED19 C2 20       REP #$20
$82:ED1B E8          INX
$82:ED1C A9 00 50    LDA #$5000
$82:ED1F 95 D0       STA $D0,x  [$7E:00D5]
$82:ED21 E8          INX
$82:ED22 E8          INX
$82:ED23 8E 30 03    STX $0330  [$7E:0330]
$82:ED26 28          PLP
$82:ED27 60          RTS
}


;;; $ED28: Set game options menu tile palettes ;;;
{
;; Parameters:
;;     A: Palette index (multiple of 200h)
;;     X: Tilemap index (multiple of 2)
;;     Y: Size (multiple of 2)
$82:ED28 08          PHP
$82:ED29 C2 30       REP #$30
$82:ED2B 85 12       STA $12    [$7E:0012]

$82:ED2D BF 00 30 7E LDA $7E3000,x[$7E:3288]
$82:ED31 29 FF E3    AND #$E3FF
$82:ED34 05 12       ORA $12    [$7E:0012]
$82:ED36 9F 00 30 7E STA $7E3000,x[$7E:3288]
$82:ED3A E8          INX
$82:ED3B E8          INX
$82:ED3C 88          DEY
$82:ED3D 88          DEY
$82:ED3E D0 ED       BNE $ED    [$ED2D]
$82:ED40 28          PLP
$82:ED41 60          RTS
}


;;; $ED42: Game state 2 (game options menu) - [$0DE2] = 3 (options menu) ;;;
{
$82:ED42 08          PHP
$82:ED43 C2 30       REP #$30
$82:ED45 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:ED47 29 00 08    AND #$0800             ;} If newly pressed up:
$82:ED4A F0 14       BEQ $14    [$ED60]     ;/
$82:ED4C A9 37 00    LDA #$0037             ;\
$82:ED4F 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:ED53 CE 9E 09    DEC $099E  [$7E:099E]  ;\
$82:ED56 10 25       BPL $25    [$ED7D]     ;|
$82:ED58 A9 04 00    LDA #$0004             ;} Menu option index = ([menu option index] - 1) % 5
$82:ED5B 8D 9E 09    STA $099E  [$7E:099E]  ;/
$82:ED5E 80 1D       BRA $1D    [$ED7D]

$82:ED60 A5 8F       LDA $8F    [$7E:008F]  ;\ Else (if not newly pressed up):
$82:ED62 29 00 04    AND #$0400             ;} If newly pressed down:
$82:ED65 F0 16       BEQ $16    [$ED7D]     ;/
$82:ED67 A9 37 00    LDA #$0037             ;\
$82:ED6A 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:ED6E AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:ED71 1A          INC A                  ;|
$82:ED72 8D 9E 09    STA $099E  [$7E:099E]  ;|
$82:ED75 C9 05 00    CMP #$0005             ;} Menu option index = ([menu option index] + 1) % 5
$82:ED78 D0 03       BNE $03    [$ED7D]     ;|
$82:ED7A 9C 9E 09    STZ $099E  [$7E:099E]  ;/

$82:ED7D A5 8F       LDA $8F    [$7E:008F]  ;\
$82:ED7F 89 00 80    BIT #$8000             ;} If newly pressed B: go to BRANCH_CANCEL
$82:ED82 D0 1B       BNE $1B    [$ED9F]     ;/
$82:ED84 89 80 00    BIT #$0080             ;\
$82:ED87 D0 05       BNE $05    [$ED8E]     ;} If not newly pressed A:
$82:ED89 89 00 10    BIT #$1000             ;\
$82:ED8C F0 0F       BEQ $0F    [$ED9D]     ;} If not newly pressed start: return

$82:ED8E A9 38 00    LDA #$0038             ;\
$82:ED91 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$82:ED95 AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:ED98 0A          ASL A                  ;|
$82:ED99 AA          TAX                    ;} Execute [$EDA7 + [menu option index] * 2]
$82:ED9A FC A7 ED    JSR ($EDA7,x)[$82:EE55];/

$82:ED9D 28          PLP
$82:ED9E 60          RTS

; BRANCH_CANCEL
$82:ED9F A9 0B 00    LDA #$000B             ;\
$82:EDA2 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = Bh (transition back to file select)
$82:EDA5 28          PLP
$82:EDA6 60          RTS

$82:EDA7             dw EDB1, ; Start game
                        EDDA, ; English text
                        EDDA, ; Japanese text
                        EE55, ; Controller setting mode
                        EE55  ; Special setting mode
}


;;; $EDB1: Game options menu - options menu - start game ;;;
{
$82:EDB1 AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$82:EDB4 F0 07       BEQ $07    [$EDBD]     ;} If debug mode enabled:
$82:EDB6 A5 8B       LDA $8B    [$7E:008B]  ;\
$82:EDB8 89 20 00    BIT #$0020             ;} If not pressing L: go to BRANCH_START_GAME
$82:EDBB F0 09       BEQ $09    [$EDC6]     ;/

$82:EDBD AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$82:EDC1 C9 05 00    CMP #$0005             ;} If [loading game state] != main: go to BRANCH_FADE_SCREEN
$82:EDC4 D0 07       BNE $07    [$EDCD]     ;/

; BRANCH_START_GAME
$82:EDC6 A9 04 00    LDA #$0004             ;\
$82:EDC9 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = 4 (start game)
$82:EDCC 60          RTS                    ; Return

; BRANCH_FADE_SCREEN
$82:EDCD 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:EDD0 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:EDD3 A9 0C 00    LDA #$000C             ;\
$82:EDD6 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = Ch (fading out options menu to start game)
$82:EDD9 60          RTS
}


;;; $EDDA: Game options menu - options menu - toggle language text ;;;
{
$82:EDDA 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:EDDD AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$82:EDE0 F0 05       BEQ $05    [$EDE7]     ;} If Japanese text enabled:
$82:EDE2 9C E2 09    STZ $09E2  [$7E:09E2]  ; Disable Japanese text
$82:EDE5 80 06       BRA $06    [$EDED]

$82:EDE7 A9 01 00    LDA #$0001             ;\ Else (Japanese text disabled):
$82:EDEA 8D E2 09    STA $09E2  [$7E:09E2]  ;} Enable Japanese text
}


;;; $EDED: Set language text option highlight ;;;
{
$82:EDED AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$82:EDF0 D0 32       BNE $32    [$EE24]     ;} If Japanese text disabled:
$82:EDF2 A2 88 02    LDX #$0288             ;\
$82:EDF5 A0 18 00    LDY #$0018             ;|
$82:EDF8 A9 00 00    LDA #$0000             ;} Set game options menu tiles (4..Bh, Ah) to palette 0
$82:EDFB 20 28 ED    JSR $ED28  [$82:ED28]  ;/
$82:EDFE A2 C8 02    LDX #$02C8             ;\
$82:EE01 A0 18 00    LDY #$0018             ;|
$82:EE04 A9 00 00    LDA #$0000             ;} Set game options menu tiles (4..Bh, Bh) to palette 0
$82:EE07 20 28 ED    JSR $ED28  [$82:ED28]  ;/
$82:EE0A A2 48 03    LDX #$0348             ;\
$82:EE0D A0 32 00    LDY #$0032             ;|
$82:EE10 A9 00 04    LDA #$0400             ;} Set game options menu tiles (4..Bh, Dh) to palette 2
$82:EE13 20 28 ED    JSR $ED28  [$82:ED28]  ;/
$82:EE16 A2 88 03    LDX #$0388             ;\
$82:EE19 A0 32 00    LDY #$0032             ;|
$82:EE1C A9 00 04    LDA #$0400             ;} Set game options menu tiles (4..Bh, Eh) to palette 2
$82:EE1F 20 28 ED    JSR $ED28  [$82:ED28]  ;/
$82:EE22 80 30       BRA $30    [$EE54]

$82:EE24 A2 88 02    LDX #$0288             ;\ Else (Japanese text enabled):
$82:EE27 A0 18 00    LDY #$0018             ;|
$82:EE2A A9 00 04    LDA #$0400             ;} Set game options menu tiles (4..Bh, Ah) to palette 2
$82:EE2D 20 28 ED    JSR $ED28  [$82:ED28]  ;/
$82:EE30 A2 C8 02    LDX #$02C8             ;\
$82:EE33 A0 18 00    LDY #$0018             ;|
$82:EE36 A9 00 04    LDA #$0400             ;} Set game options menu tiles (4..Bh, Bh) to palette 2
$82:EE39 20 28 ED    JSR $ED28  [$82:ED28]  ;/
$82:EE3C A2 48 03    LDX #$0348             ;\
$82:EE3F A0 32 00    LDY #$0032             ;|
$82:EE42 A9 00 00    LDA #$0000             ;} Set game options menu tiles (4..Bh, Dh) to palette 0
$82:EE45 20 28 ED    JSR $ED28  [$82:ED28]  ;/
$82:EE48 A2 88 03    LDX #$0388             ;\
$82:EE4B A0 32 00    LDY #$0032             ;|
$82:EE4E A9 00 00    LDA #$0000             ;} Set game options menu tiles (4..Bh, Eh) to palette 0
$82:EE51 20 28 ED    JSR $ED28  [$82:ED28]  ;/

$82:EE54 60          RTS
}


;;; $EE55: Start game options menu dissolve transition ;;;
{
$82:EE55 E2 20       SEP #$20               ;\
$82:EE57 A9 03       LDA #$03               ;|
$82:EE59 85 57       STA $57    [$7E:0057]  ;} Enable BG1/2 mosaic, block size = 0
$82:EE5B C2 20       REP #$20               ;/
$82:EE5D 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:EE60 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:EE63 A9 05 00    LDA #$0005             ;\
$82:EE66 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = 5 (dissolve out screen)
$82:EE69 60          RTS
}


;;; $EE6A: Game state 2 (game options menu) - [$0DE2] = Bh (transition back to file select) ;;;
{
$82:EE6A 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:EE6E E2 20       SEP #$20
$82:EE70 A5 51       LDA $51    [$7E:0051]  ;\
$82:EE72 C9 80       CMP #$80               ;} If not finished fading out: return
$82:EE74 D0 19       BNE $19    [$EE8F]     ;/
$82:EE76 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:EE7A C2 20       REP #$20
$82:EE7C 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:EE7F 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:EE82 A9 04 00    LDA #$0004             ;\
$82:EE85 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 4 (file select menus)
$82:EE88 9C 27 07    STZ $0727  [$7E:0727]  ; Menu index = 0
$82:EE8B 9C E2 0D    STZ $0DE2  [$7E:0DE2]  ; Game options menu index = 0
$82:EE8E 60          RTS                    ; Return

$82:EE8F C2 20       REP #$20
$82:EE91 60          RTS
}


;;; $EE92: Game state 2 (game options menu) - [$0DE2] = Ch (fading out options menu to start game) ;;;
{
$82:EE92 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:EE96 E2 20       SEP #$20
$82:EE98 A5 51       LDA $51    [$7E:0051]  ;\
$82:EE9A C9 80       CMP #$80               ;} If not finished fading out: return
$82:EE9C D0 13       BNE $13    [$EEB1]     ;/
$82:EE9E 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:EEA2 C2 20       REP #$20
$82:EEA4 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:EEA7 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:EEAA A9 04 00    LDA #$0004             ;\
$82:EEAD 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = 4 (start game)
$82:EEB0 60          RTS                    ; Return

$82:EEB1 C2 20       REP #$20
$82:EEB3 60          RTS
}


;;; $EEB4: Game state 2 (game options menu) - [$0DE2] = 4 (start game) ;;;
{
$82:EEB4 9C E2 0D    STZ $0DE2  [$7E:0DE2]  ; Game options menu index = 0
$82:EEB7 AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$82:EEBA F0 07       BEQ $07    [$EEC3]     ;} If debug mode enabled:
$82:EEBC A5 8B       LDA $8B    [$7E:008B]  ;\
$82:EEBE 89 20 00    BIT #$0020             ;} If not pressing L: go to BRANCH_DEBUG
$82:EEC1 F0 33       BEQ $33    [$EEF6]     ;/

$82:EEC3 AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$82:EEC7 F0 10       BEQ $10    [$EED9]     ;} If [loading game state] != 0:
$82:EEC9 8D 98 09    STA $0998  [$7E:0998]  ; Game state = [loading game state]
$82:EECC C9 22 00    CMP #$0022             ;\
$82:EECF D0 1E       BNE $1E    [$EEEF]     ;} If [loading game state] = 22h (escaping Ceres / landing on Zebes):
$82:EED1 A9 1B C1    LDA #$C11B             ;\
$82:EED4 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $C11B
$82:EED7 80 16       BRA $16    [$EEEF]

$82:EED9 A9 1E 00    LDA #$001E             ;\ Else ([loading game state] = 0):
$82:EEDC 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 1Eh (intro)
$82:EEDF A9 95 A3    LDA #$A395             ;\
$82:EEE2 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A395
$82:EEE5 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:EEE8 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:EEEB 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:EEEE 60          RTS                    ; Return

$82:EEEF 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:EEF2 9C E2 0D    STZ $0DE2  [$7E:0DE2]  ; Game options menu index = 0
$82:EEF5 60          RTS                    ; Return

; BRANCH_DEBUG
$82:EEF6 AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$82:EEFA C9 05 00    CMP #$0005             ;} If [loading game state] != 5 (main):
$82:EEFD F0 12       BEQ $12    [$EF11]     ;/
$82:EEFF A9 05 00    LDA #$0005             ;\
$82:EF02 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 5 (loading game map view)
$82:EF05 8F 14 D9 7E STA $7ED914[$7E:D914]  ; Loading game state = 5 (main)
$82:EF09 AD 52 09    LDA $0952  [$7E:0952]  ;\
$82:EF0C 22 00 80 81 JSL $818000[$81:8000]  ;} Save current save slot to SRAM
$82:EF10 60          RTS                    ; Return

$82:EF11 A9 05 00    LDA #$0005             ;\
$82:EF14 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 5 (loading game map view)
$82:EF17 60          RTS
}


;;; $EF18: Game state 2 (game options menu) - [$0DE2] = 5 (dissolve out screen) ;;;
{
$82:EF18 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$82:EF1C E2 20       SEP #$20
$82:EF1E A5 57       LDA $57    [$7E:0057]  ;\
$82:EF20 C9 F3       CMP #$F3               ;|
$82:EF22 F0 05       BEQ $05    [$EF29]     ;|
$82:EF24 18          CLC                    ;} (Mosaic block size) = min(Fh, (mosaic block size))
$82:EF25 69 10       ADC #$10               ;|
$82:EF27 85 57       STA $57    [$7E:0057]  ;/

$82:EF29 A5 51       LDA $51    [$7E:0051]  ;\
$82:EF2B C9 80       CMP #$80               ;} If not finished fading out:
$82:EF2D F0 03       BEQ $03    [$EF32]     ;/
$82:EF2F C2 20       REP #$20
$82:EF31 60          RTS                    ; Return

$82:EF32 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$82:EF36 C2 20       REP #$20
$82:EF38 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:EF3B 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:EF3E 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$82:EF40 EE E2 0D    INC $0DE2  [$7E:0DE2]  ; Game options menu index = 6 (dissolve in screen)
$82:EF43 AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:EF46 F0 37       BEQ $37    [$EF7F]     ;} If [menu option index] = 0: go to BRANCH_OPTIONS_MENU
$82:EF48 89 04 00    BIT #$0004             ;\
$82:EF4B D0 34       BNE $34    [$EF81]     ;} If [menu option index] & 4 != 0: go to BRANCH_SPECIAL_SUBMENU
$82:EF4D AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$82:EF50 D0 11       BNE $11    [$EF63]     ;} If Japanese text disabled:
$82:EF52 A2 FE 07    LDX #$07FE             ;\
                                            ;|
$82:EF55 BF 00 C8 7F LDA $7FC800,x          ;|
$82:EF59 9F 00 30 7E STA $7E3000,x          ;} Game options menu tilemap = [$7F:C800..CFFF] (game options menu tilemap - controller settings - English)
$82:EF5D CA          DEX                    ;|
$82:EF5E CA          DEX                    ;|
$82:EF5F 10 F4       BPL $F4    [$EF55]     ;/
$82:EF61 80 0F       BRA $0F    [$EF72]

$82:EF63 A2 FE 07    LDX #$07FE             ;\ Else (Japanese text enabled):
                                            ;|
$82:EF66 BF 00 D0 7F LDA $7FD000,x          ;|
$82:EF6A 9F 00 30 7E STA $7E3000,x          ;} Game options menu tilemap = [$7F:D000..D7FF] (game options menu tilemap - controller settings - Japanese)
$82:EF6E CA          DEX                    ;|
$82:EF6F CA          DEX                    ;|
$82:EF70 10 F4       BPL $F4    [$EF66]     ;/

$82:EF72 A0 CA F4    LDY #$F4CA             ;\
$82:EF75 20 CB 8B    JSR $8BCB  [$82:8BCB]  ;} Spawn border around CONTROLLER SETTING MODE
$82:EF78 20 DC F4    JSR $F4DC  [$82:F4DC]  ; Load game options menu controller bindings
$82:EF7B 20 87 F5    JSR $F587  [$82:F587]  ; Draw game options menu controller bindings
$82:EF7E 60          RTS                    ; Return

$82:EF7F 80 41       BRA $41    [$EFC2]

; BRANCH_SPECIAL_SUBMENU
$82:EF81 AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$82:EF84 D0 11       BNE $11    [$EF97]     ;} If Japanese text disabled:
$82:EF86 A2 FE 07    LDX #$07FE             ;\
                                            ;|
$82:EF89 BF 00 D8 7F LDA $7FD800,x[$7F:DFFE];|
$82:EF8D 9F 00 30 7E STA $7E3000,x[$7E:37FE];} Game options menu tilemap = [$7F:D800..DFFF] (game options menu tilemap - special settings - English)
$82:EF91 CA          DEX                    ;|
$82:EF92 CA          DEX                    ;|
$82:EF93 10 F4       BPL $F4    [$EF89]     ;/
$82:EF95 80 0F       BRA $0F    [$EFA6]

$82:EF97 A2 FE 07    LDX #$07FE             ;\ Else (Japanese text enabled):
                                            ;|
$82:EF9A BF 00 E0 7F LDA $7FE000,x          ;|
$82:EF9E 9F 00 30 7E STA $7E3000,x          ;} Game options menu tilemap = [$7F:E000..E7FF] (game options menu tilemap - special settings - Japanese)
$82:EFA2 CA          DEX                    ;|
$82:EFA3 CA          DEX                    ;|
$82:EFA4 10 F4       BPL $F4    [$EF9A]     ;/

$82:EFA6 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0 (icon cancel)
$82:EFA9 20 B9 F0    JSR $F0B9  [$82:F0B9]  ; Set special setting highlights
$82:EFAC A9 01 00    LDA #$0001             ;\
$82:EFAF 8D 9E 09    STA $099E  [$7E:099E]  ;} Menu option index = 1 (moonwalk)
$82:EFB2 20 B9 F0    JSR $F0B9  [$82:F0B9]  ; Set special setting highlights
$82:EFB5 A9 04 00    LDA #$0004             ;\
$82:EFB8 8D 9E 09    STA $099E  [$7E:099E]  ;} Menu option index = 4
$82:EFBB A0 D0 F4    LDY #$F4D0             ;\
$82:EFBE 20 CB 8B    JSR $8BCB  [$82:8BCB]  ;} Spawn border around SPECIAL SETTING MODE
$82:EFC1 60          RTS                    ; Return

; BRANCH_OPTIONS_MENU
$82:EFC2 A2 FE 07    LDX #$07FE             ;\
                                            ;|
$82:EFC5 BF 00 C0 7F LDA $7FC000,x[$7F:C7FE];|
$82:EFC9 9F 00 30 7E STA $7E3000,x[$7E:37FE];} Game options menu tilemap = [$7F:C000..C7FF] (game options menu tilemap - options screen)
$82:EFCD CA          DEX                    ;|
$82:EFCE CA          DEX                    ;|
$82:EFCF 10 F4       BPL $F4    [$EFC5]     ;/
$82:EFD1 20 ED ED    JSR $EDED  [$82:EDED]  ; Set language text option highlight
$82:EFD4 A0 C4 F4    LDY #$F4C4             ;\
$82:EFD7 20 CB 8B    JSR $8BCB  [$82:8BCB]  ;} Spawn border around OPTIONS MODE
$82:EFDA 60          RTS
}


;;; $EFDB: Game state 2 (game options menu) - [$0DE2] = 6 (dissolve in screen) ;;;
{
$82:EFDB 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$82:EFDF E2 20       SEP #$20
$82:EFE1 A5 57       LDA $57    [$7E:0057]  ;\
$82:EFE3 C9 03       CMP #$03               ;|
$82:EFE5 F0 05       BEQ $05    [$EFEC]     ;|
$82:EFE7 38          SEC                    ;} (Mosaic block size) = max(0, (mosaic block size))
$82:EFE8 E9 10       SBC #$10               ;|
$82:EFEA 85 57       STA $57    [$7E:0057]  ;/

$82:EFEC A5 51       LDA $51    [$7E:0051]  ;\
$82:EFEE C9 0F       CMP #$0F               ;} If not finished fading in: return
$82:EFF0 D0 2F       BNE $2F    [$F021]     ;/
$82:EFF2 64 57       STZ $57    [$7E:0057]  ; Disable mosaic
$82:EFF4 C2 20       REP #$20
$82:EFF6 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$82:EFF9 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$82:EFFC AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:EFFF F0 19       BEQ $19    [$F01A]     ;} If [menu option index] = 0: go to BRANCH_OPTIONS_MENU
$82:F001 89 04 00    BIT #$0004             ;\
$82:F004 D0 0A       BNE $0A    [$F010]     ;} If [menu option index] & 4 != 0: go to BRANCH_SPECIAL_SUBMENU
$82:F006 A9 07 00    LDA #$0007             ;\
$82:F009 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = 7 (controller settings)
$82:F00C 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:F00F 60          RTS                    ; Return

; BRANCH_SPECIAL_SUBMENU
$82:F010 A9 08 00    LDA #$0008             ;\
$82:F013 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = 8 (special settings)
$82:F016 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:F019 60          RTS                    ; Return

; BRANCH_OPTIONS_MENU
$82:F01A A9 03 00    LDA #$0003             ;\
$82:F01D 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = 3 (options menu)
$82:F020 60          RTS                    ; Return

$82:F021 C2 20       REP #$20
$82:F023 60          RTS
}


;;; $F024..F158: Special settings ;;;
{
;;; $F024: Game state 2 (game options menu) - [$0DE2] = 8 (special settings) ;;;
{
$82:F024 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:F026 29 00 08    AND #$0800             ;} If newly pressed up:
$82:F029 F0 14       BEQ $14    [$F03F]     ;/
$82:F02B A9 37 00    LDA #$0037             ;\
$82:F02E 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:F032 CE 9E 09    DEC $099E  [$7E:099E]  ;\
$82:F035 10 25       BPL $25    [$F05C]     ;|
$82:F037 A9 02 00    LDA #$0002             ;} Menu option index = ([menu option index] - 1) % 3
$82:F03A 8D 9E 09    STA $099E  [$7E:099E]  ;/
$82:F03D 80 1D       BRA $1D    [$F05C]

$82:F03F A5 8F       LDA $8F    [$7E:008F]  ;\ Else (not newly pressed up):
$82:F041 29 00 04    AND #$0400             ;} If newly pressed down:
$82:F044 F0 16       BEQ $16    [$F05C]     ;/
$82:F046 A9 37 00    LDA #$0037             ;\
$82:F049 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:F04D AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F050 1A          INC A                  ;|
$82:F051 8D 9E 09    STA $099E  [$7E:099E]  ;|
$82:F054 C9 03 00    CMP #$0003             ;} Menu option index = ([menu option index] + 1) % 3
$82:F057 D0 03       BNE $03    [$F05C]     ;|
$82:F059 9C 9E 09    STZ $099E  [$7E:099E]  ;/

$82:F05C A5 8F       LDA $8F    [$7E:008F]  ;\
$82:F05E 89 00 80    BIT #$8000             ;} If newly pressed B:
$82:F061 F0 0E       BEQ $0E    [$F071]     ;/
$82:F063 A9 38 00    LDA #$0038             ;\
$82:F066 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$82:F06A 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:F06D 20 55 EE    JSR $EE55  [$82:EE55]  ; Start game options menu dissolve transition
$82:F070 60          RTS                    ; Return

$82:F071 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:F073 89 80 13    BIT #$1380             ;} If newly pressed A, left, right or start:
$82:F076 F0 0F       BEQ $0F    [$F087]     ;/
$82:F078 A9 38 00    LDA #$0038             ;\
$82:F07B 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$82:F07F AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F082 0A          ASL A                  ;|
$82:F083 AA          TAX                    ;} Execute [$F088 + [menu option index] * 2]
$82:F084 FC 88 F0    JSR ($F088,x)[$82:F08E];/

$82:F087 60          RTS

$82:F088             dw F08E, F08E, F0B2
}


;;; $F08E: Game options - special settings - toggle setting ;;;
{
$82:F08E AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F091 0A          ASL A                  ;|
$82:F092 AA          TAX                    ;} X = [$F0AE + [menu option index] * 2] (special setting RAM address)
$82:F093 BD AE F0    LDA $F0AE,x[$82:F0B0]  ;|
$82:F096 AA          TAX                    ;/
$82:F097 BD 00 00    LDA $0000,x[$7E:09E4]  ;\
$82:F09A F0 08       BEQ $08    [$F0A4]     ;} If [[X]] != 0:
$82:F09C A9 00 00    LDA #$0000             ;\
$82:F09F 9D 00 00    STA $0000,x            ;} [X] = 0
$82:F0A2 80 06       BRA $06    [$F0AA]

$82:F0A4 A9 01 00    LDA #$0001             ;\ Else ([[X]] = 0)L
$82:F0A7 9D 00 00    STA $0000,x[$7E:09E4]  ;} [X] = 1

$82:F0AA 20 B9 F0    JSR $F0B9  [$82:F0B9]  ; Set special setting highlights
$82:F0AD 60          RTS
}


;;; $F0AE: Special setting RAM addresses ;;;
{
$82:F0AE             dw 09EA, ; Icon cancel flag
                        09E4  ; Moonwalk flag
}


;;; $F0B2: Game options - special settings - end ;;;
{
$82:F0B2 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:F0B5 20 55 EE    JSR $EE55  [$82:EE55]  ; Start game options menu dissolve transition
$82:F0B8 60          RTS
}


;;; $F0B9: Set special setting highlights ;;;
{
$82:F0B9 AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F0BC 0A          ASL A                  ;|
$82:F0BD AA          TAX                    ;|
$82:F0BE BD AE F0    LDA $F0AE,x[$82:F0AE]  ;} If [[$F0AE + [menu option index] * 2]] = 0 (setting is off):
$82:F0C1 AA          TAX                    ;|
$82:F0C2 BD 00 00    LDA $0000,x[$7E:09EA]  ;|
$82:F0C5 D0 41       BNE $41    [$F108]     ;/
$82:F0C7 AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F0CA 0A          ASL A                  ;|
$82:F0CB 0A          ASL A                  ;} X = [menu option index] * 8
$82:F0CC AA          TAX                    ;/
$82:F0CD DA          PHX                    ;\
$82:F0CE BD 49 F1    LDA $F149,x[$82:F149]  ;|
$82:F0D1 AA          TAX                    ;|
$82:F0D2 A0 0C 00    LDY #$000C             ;} Set 6 game options menu tiles from (10h, 7 + [menu option index] * 6) to palette 2
$82:F0D5 A9 00 04    LDA #$0400             ;|
$82:F0D8 20 28 ED    JSR $ED28  [$82:ED28]  ;|
$82:F0DB FA          PLX                    ;/
$82:F0DC DA          PHX                    ;\
$82:F0DD BD 4B F1    LDA $F14B,x[$82:F14B]  ;|
$82:F0E0 AA          TAX                    ;|
$82:F0E1 A0 0C 00    LDY #$000C             ;} Set 6 game options menu tiles from (10h, 8 + [menu option index] * 6) to palette 2
$82:F0E4 A9 00 04    LDA #$0400             ;|
$82:F0E7 20 28 ED    JSR $ED28  [$82:ED28]  ;|
$82:F0EA FA          PLX                    ;/
$82:F0EB DA          PHX                    ;\
$82:F0EC BD 51 F1    LDA $F151,x[$82:F151]  ;|
$82:F0EF AA          TAX                    ;|
$82:F0F0 A0 0C 00    LDY #$000C             ;} Set 6 game options menu tiles from (17h, 7 + [menu option index] * 6) to palette 0
$82:F0F3 A9 00 00    LDA #$0000             ;|
$82:F0F6 20 28 ED    JSR $ED28  [$82:ED28]  ;|
$82:F0F9 FA          PLX                    ;/
$82:F0FA BD 53 F1    LDA $F153,x[$82:F153]  ;\
$82:F0FD AA          TAX                    ;|
$82:F0FE A0 0C 00    LDY #$000C             ;} Set 6 game options menu tiles from (17h, 8 + [menu option index] * 6) to palette 0
$82:F101 A9 00 00    LDA #$0000             ;|
$82:F104 20 28 ED    JSR $ED28  [$82:ED28]  ;/
$82:F107 60          RTS

$82:F108 AD 9E 09    LDA $099E  [$7E:099E]  ;\ Else (setting is on):
$82:F10B 0A          ASL A                  ;|
$82:F10C 0A          ASL A                  ;} X = [menu option index] * 8
$82:F10D AA          TAX                    ;/
$82:F10E DA          PHX                    ;\
$82:F10F BD 49 F1    LDA $F149,x[$82:F14D]  ;|
$82:F112 AA          TAX                    ;|
$82:F113 A0 0C 00    LDY #$000C             ;} Set 6 game options menu tiles from (10h, 7 + [menu option index] * 6) to palette 0
$82:F116 A9 00 00    LDA #$0000             ;|
$82:F119 20 28 ED    JSR $ED28  [$82:ED28]  ;|
$82:F11C FA          PLX                    ;/
$82:F11D DA          PHX                    ;\
$82:F11E BD 4B F1    LDA $F14B,x[$82:F14F]  ;|
$82:F121 AA          TAX                    ;|
$82:F122 A0 0C 00    LDY #$000C             ;} Set 6 game options menu tiles from (10h, 8 + [menu option index] * 6) to palette 0
$82:F125 A9 00 00    LDA #$0000             ;|
$82:F128 20 28 ED    JSR $ED28  [$82:ED28]  ;|
$82:F12B FA          PLX                    ;/
$82:F12C DA          PHX                    ;\
$82:F12D BD 51 F1    LDA $F151,x[$82:F155]  ;|
$82:F130 AA          TAX                    ;|
$82:F131 A0 0C 00    LDY #$000C             ;} Set 6 game options menu tiles from (17h, 7 + [menu option index] * 6) to palette 2
$82:F134 A9 00 04    LDA #$0400             ;|
$82:F137 20 28 ED    JSR $ED28  [$82:ED28]  ;|
$82:F13A FA          PLX                    ;/
$82:F13B BD 53 F1    LDA $F153,x[$82:F157]  ;\
$82:F13E AA          TAX                    ;|
$82:F13F A0 0C 00    LDY #$000C             ;} Set 6 game options menu tiles from (17h, 8 + [menu option index] * 6) to palette 2
$82:F142 A9 00 04    LDA #$0400             ;|
$82:F145 20 28 ED    JSR $ED28  [$82:ED28]  ;/
$82:F148 60          RTS

;                        ___________________ Icon cancel row 0
;                       |     ______________ Icon cancel row 1
;                       |    |      ________ Moonwalk row 0
;                       |    |     |     ___ Moonwalk row 1
;                       |    |     |    |
$82:F149             dw 01E0,0220, 0360,03A0 ; Left option tilemap indices
$82:F151             dw 01EE,022E, 036E,03AE ; Right option tilemap indices
}
}


;;; $F159..F295: Controller settings ;;;
{
;;; $F159: Game state 2 (game options menu) - [$0DE2] = 7 (controller settings) ;;;
{
$82:F159 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:F15B 29 00 08    AND #$0800             ;} If not newly pressed up: go to BRANCH_UP_END
$82:F15E F0 1F       BEQ $1F    [$F17F]     ;/
$82:F160 A9 37 00    LDA #$0037             ;\
$82:F163 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:F167 AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F16A 3A          DEC A                  ;} Decrement menu option index
$82:F16B 8D 9E 09    STA $099E  [$7E:099E]  ;/
$82:F16E 30 06       BMI $06    [$F176]     ; If [menu option index] >= 0:
$82:F170 C9 06 00    CMP #$0006             ;\
$82:F173 F0 35       BEQ $35    [$F1AA]     ;} If [menu option index] = 6 (angle down): go to BRANCH_SCROLL_UP
$82:F175 60          RTS                    ; Return

$82:F176 A9 08 00    LDA #$0008             ;\
$82:F179 8D 9E 09    STA $099E  [$7E:099E]  ;} Menu option index = 8
$82:F17C 80 25       BRA $25    [$F1A3]     ; Go to BRANCH_SCROLL_DOWN

$82:F17E 60          RTS

; BRANCH_UP_END
$82:F17F A5 8F       LDA $8F    [$7E:008F]  ;\
$82:F181 29 00 04    AND #$0400             ;} If not newly pressed down: go to BRANCH_DOWN_END
$82:F184 F0 2B       BEQ $2B    [$F1B1]     ;/
$82:F186 A9 37 00    LDA #$0037             ;\
$82:F189 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$82:F18D AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F190 1A          INC A                  ;} Increment menu option index
$82:F191 8D 9E 09    STA $099E  [$7E:099E]  ;/
$82:F194 C9 07 00    CMP #$0007             ;\
$82:F197 F0 0A       BEQ $0A    [$F1A3]     ;} If [menu option index] = 7 (end): go to BRANCH_SCROLL_DOWN
$82:F199 C9 09 00    CMP #$0009             ;\
$82:F19C D0 E0       BNE $E0    [$F17E]     ;} If [menu option index] != 9: return
$82:F19E 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:F1A1 80 07       BRA $07    [$F1AA]     ; Go to BRANCH_SCROLL_UP

; BRANCH_SCROLL_DOWN
$82:F1A3 A9 09 00    LDA #$0009             ;\
$82:F1A6 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = 9 (scroll controller settings down)
$82:F1A9 60          RTS                    ; Return

; BRANCH_SCROLL_UP
$82:F1AA A9 0A 00    LDA #$000A             ;\
$82:F1AD 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = Ah (scroll controller settings up)
$82:F1B0 60          RTS                    ; Return

; BRANCH_DOWN_END
$82:F1B1 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:F1B3 F0 10       BEQ $10    [$F1C5]     ;} If pressed anything:
$82:F1B5 A9 38 00    LDA #$0038             ;\
$82:F1B8 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$82:F1BC AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F1BF 0A          ASL A                  ;|
$82:F1C0 AA          TAX                    ;} Execute [$F1C9 + [menu option index] * 2]
$82:F1C1 FC C9 F1    JSR ($F1C9,x)          ;/
$82:F1C4 60          RTS                    ; Return

$82:F1C5 A5 91       LDA $91    [$7E:0091]
$82:F1C7 80 12       BRA $12    [$F1DB]     ; Wild BRA appeared!

$82:F1C9             dw F6B9, F6B9, F6B9, F6B9, F6B9, F6B9, F6B9, F25D, F224

$82:F1DB A8          TAY                    ; Y = [newly pressed controller 2 input]
$82:F1DC F0 25       BEQ $25    [$F203]     ; If controller 2 not newly pressed anything: return
$82:F1DE AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F1E1 C9 08 00    CMP #$0008             ;} If [menu option index] != 8 (reset to default): return
$82:F1E4 D0 1D       BNE $1D    [$F203]     ;/
$82:F1E6 AD E0 0D    LDA $0DE0  [$7E:0DE0]  ;\
$82:F1E9 C9 10 00    CMP #$0010             ;} If [debug invincibility] >= 10h: return
$82:F1EC 10 15       BPL $15    [$F203]     ;/
$82:F1EE AD E0 0D    LDA $0DE0  [$7E:0DE0]  ;\
$82:F1F1 0A          ASL A                  ;|
$82:F1F2 AA          TAX                    ;|
$82:F1F3 98          TYA                    ;} If controller 2 newly pressed [$F204 + [debug invincibility] * 2]:
$82:F1F4 3D 04 F2    AND $F204,x            ;|
$82:F1F7 DD 04 F2    CMP $F204,x            ;|
$82:F1FA D0 04       BNE $04    [$F200]     ;/
$82:F1FC EE E0 0D    INC $0DE0  [$7E:0DE0]  ; Increment debug invincibility
$82:F1FF 60          RTS                    ; Return

$82:F200 9C E0 0D    STZ $0DE0  [$7E:0DE0]  ; Debug invincibility = 0

$82:F203 60          RTS

$82:F204             dw 0020, 0020, 0020, 0020, ; L
                        0010, 0010, 0010, 0010, 0010, 0010, ; R
                        4000, ; Y
                        0040, 0040, ; X
                        0080, 0080, 0080 ; A
}


;;; $F224: Game options - controller settings - reset to default ;;;
{
$82:F224 A5 8F       LDA $8F    [$7E:008F]  ;\
$82:F226 89 80 10    BIT #$1080             ;} If not newly pressing start or A:
$82:F229 D0 01       BNE $01    [$F22C]     ;/
$82:F22B 60          RTS                    ; Return

$82:F22C A9 40 00    LDA #$0040             ;\
$82:F22F 8D B2 09    STA $09B2  [$7E:09B2]  ;} Shoot binding = X
$82:F232 A9 80 00    LDA #$0080             ;\
$82:F235 8D B4 09    STA $09B4  [$7E:09B4]  ;} Jump binding = A
$82:F238 A9 00 80    LDA #$8000             ;\
$82:F23B 8D B6 09    STA $09B6  [$7E:09B6]  ;} Run binding = B
$82:F23E A9 00 40    LDA #$4000             ;\
$82:F241 8D B8 09    STA $09B8  [$7E:09B8]  ;} Item cancel binding = Y
$82:F244 A9 00 20    LDA #$2000             ;\
$82:F247 8D BA 09    STA $09BA  [$7E:09BA]  ;} Item switch binding = select
$82:F24A A9 10 00    LDA #$0010             ;\
$82:F24D 8D BE 09    STA $09BE  [$7E:09BE]  ;} Aim up binding = R
$82:F250 A9 20 00    LDA #$0020             ;\
$82:F253 8D BC 09    STA $09BC  [$7E:09BC]  ;} Aim down binding = L
$82:F256 20 DC F4    JSR $F4DC  [$82:F4DC]  ; Load game options menu controller bindings
$82:F259 20 87 F5    JSR $F587  [$82:F587]  ; Draw game options menu controller bindings
$82:F25C 60          RTS
}


;;; $F25D: Game options - controller settings - end ;;;
{
$82:F25D A5 8F       LDA $8F    [$7E:008F]  ;\
$82:F25F 89 80 10    BIT #$1080             ;} If not newly pressing start or A:
$82:F262 D0 01       BNE $01    [$F265]     ;/
$82:F264 60          RTS                    ; Return

$82:F265 20 58 F5    JSR $F558  [$82:F558]  ; Save game options menu controller bindings
$82:F268 B0 06       BCS $06    [$F270]     ; (Carry is always clear)
$82:F26A 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$82:F26D 20 55 EE    JSR $EE55  [$82:EE55]  ; Start game options menu dissolve transition

$82:F270 60          RTS
}


;;; $F271: Game state 2 (game options menu) - [$0DE2] = 9 (scroll controller settings down) ;;;
{
$82:F271 A5 B3       LDA $B3    [$7E:00B3]  ;\
$82:F273 18          CLC                    ;|
$82:F274 69 02 00    ADC #$0002             ;} BG1 Y scroll += 2
$82:F277 85 B3       STA $B3    [$7E:00B3]  ;/
$82:F279 C9 20 00    CMP #$0020             ;\
$82:F27C D0 06       BNE $06    [$F284]     ;} If [BG1 Y scroll] = 20h:
$82:F27E A9 07 00    LDA #$0007             ;\
$82:F281 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = 7 (controller settings)

$82:F284 60          RTS
}


;;; $F285: Game state 2 (game options menu) - [$0DE2] = Ah (scroll controller settings up) ;;;
{
$82:F285 A5 B3       LDA $B3    [$7E:00B3]  ;\
$82:F287 38          SEC                    ;|
$82:F288 E9 02 00    SBC #$0002             ;} BG1 Y scroll -= 2
$82:F28B 85 B3       STA $B3    [$7E:00B3]  ;/
$82:F28D D0 06       BNE $06    [$F295]     ; If [BG1 Y scroll] = 0:
$82:F28F A9 07 00    LDA #$0007             ;\
$82:F292 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Game options menu index = 7 (controller settings)

$82:F295 60          RTS
}
}


;;; $F296..F4DB: Game options menu objects ;;;
{
;;; $F296: Setup - menu selection missile ;;;
{
$82:F296 A9 18 00    LDA #$0018             ;\
$82:F299 99 AD 1A    STA $1AAD,y[$7E:1ABB]  ;} Game options menu object X position = 18h
$82:F29C A9 38 00    LDA #$0038             ;\
$82:F29F 99 BD 1A    STA $1ABD,y[$7E:1ACB]  ;} Game options menu object Y position = 38h
$82:F2A2 A9 00 0E    LDA #$0E00             ;\
$82:F2A5 99 CD 1A    STA $1ACD,y[$7E:1ADB]  ;} Game options menu object palette index = E00h (palette 7)
$82:F2A8 60          RTS
}


;;; $F2A9: Pre-instruction - menu selection missile ;;;
{
$82:F2A9 AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:F2AC C9 02 00    CMP #$0002             ;} If [game state] != game options menu:
$82:F2AF F0 0D       BEQ $0D    [$F2BE]     ;/
$82:F2B1 A9 01 00    LDA #$0001             ;\
$82:F2B4 9D 1D 1B    STA $1B1D,x[$7E:1B2B]  ;} Game options menu object instruction timer = 1
$82:F2B7 A9 B6 F4    LDA #$F4B6             ;\
$82:F2BA 9D FD 1A    STA $1AFD,x[$7E:1B0B]  ;} Game options menu object instruction list pointer = $F4B6 (delete)
$82:F2BD 60          RTS                    ; Return

$82:F2BE AD E2 0D    LDA $0DE2  [$7E:0DE2]  ;\
$82:F2C1 0A          ASL A                  ;|
$82:F2C2 A8          TAY                    ;} If [$F2ED + [game options menu index] * 2] != 0:
$82:F2C3 B9 ED F2    LDA $F2ED,y[$82:F2F1]  ;|
$82:F2C6 F0 18       BEQ $18    [$F2E0]     ;/
$82:F2C8 85 12       STA $12    [$7E:0012]  ;\
$82:F2CA AD 9E 09    LDA $099E  [$7E:099E]  ;|
$82:F2CD 0A          ASL A                  ;|
$82:F2CE 0A          ASL A                  ;} Y = [$F2ED + [game options menu index] * 2] + [menu option index] * 4
$82:F2CF 18          CLC                    ;|
$82:F2D0 65 12       ADC $12    [$7E:0012]  ;|
$82:F2D2 A8          TAY                    ;/
$82:F2D3 B9 00 00    LDA $0000,y[$82:F307]  ;\
$82:F2D6 9D AD 1A    STA $1AAD,x[$7E:1ABB]  ;} Game options menu object X position = [[Y]]
$82:F2D9 B9 02 00    LDA $0002,y[$82:F309]  ;\
$82:F2DC 9D BD 1A    STA $1ABD,x[$7E:1ACB]  ;} Game options menu object Y position = [[Y] + 2]
$82:F2DF 60          RTS                    ; Return

$82:F2E0 A9 80 01    LDA #$0180             ;\
$82:F2E3 9D AD 1A    STA $1AAD,x[$7E:1ABB]  ;} Game options menu object X position = 180h
$82:F2E6 A9 10 00    LDA #$0010             ;\
$82:F2E9 9D BD 1A    STA $1ABD,x[$7E:1ACB]  ;} Game options menu object Y position = 10h
$82:F2EC 60          RTS

$82:F2ED             dw 0000, ; 0: Finish fading out
                        0000, ; 1: Loading options menu
                        F307, ; 2: Fading in options menu
                        F307, ; 3: Options menu
                        0000, ; 4: Start game
                        0000, ; 5: Dissolve out screen
                        0000, ; 6: Dissolve in screen
                        F31B, ; 7: Controller settings
                        F33F, ; 8: Special settings
                        0000, ; 9: Scroll controller settings down
                        0000, ; Ah: Scroll controller settings up
                        F307, ; Bh: Transition back to file selection
                        0000  ; Ch: Fading out options menu to start game

; Options menu
$82:F307             dw 0018,0038, ; 0: Start game
                        0018,0058, ; 1: English text
                        0018,0070, ; 2: Japanese text
                        0018,0090, ; 3: Controller setting mode
                        0018,00B0  ; 4: Special setting mode

; Controller settings
$82:F31B             dw 0028,0030, ; 0: Shot
                        0028,0048, ; 1: Jump
                        0028,0060, ; 2: Dash
                        0028,0078, ; 3: Item select
                        0028,0090, ; 4: Item cancel
                        0028,00A8, ; 5: Angle up
                        0028,00C0, ; 6: Angle down
                        0028,00B8, ; 7: End
                        0028,00D0  ; 8: Reset to default

; Special settings
$82:F33F             dw 0010,0040, ; 0: Icon cancel
                        0010,0070, ; 1: Moonwalk
                        0010,00A0  ; 2: End
}


;;; $F34B: Setup - border around OPTION MODE ;;;
{
$82:F34B A9 7C 00    LDA #$007C             ;\
$82:F34E 99 AD 1A    STA $1AAD,y[$7E:1AB9]  ;} Game options menu object X position = 7Ch
$82:F351 80 16       BRA $16    [$F369]     ; Go to common border setup
}


;;; $F353: Setup - border around CONTROLLER SETTING MODE ;;;
{
$82:F353 A9 84 00    LDA #$0084             ;\
$82:F356 99 AD 1A    STA $1AAD,y            ;} Game options menu object X position = 84h
$82:F359 80 0E       BRA $0E    [$F369]     ; Go to common border setup
}


;;; $F35B: Setup - border around SPECIAL SETTING MODE ;;;
{
$82:F35B A9 80 00    LDA #$0080             ;\
$82:F35E 99 AD 1A    STA $1AAD,y[$7E:1AB7]  ;} Game options menu object X position = 80h
$82:F361 80 06       BRA $06    [$F369]     ; Go to common border setup
}


;;; $F363: Setup - border around SAMUS DATA ;;;
{
$82:F363 A9 80 00    LDA #$0080             ;\
$82:F366 99 AD 1A    STA $1AAD,y            ;} Game options menu object X position = 80h
}


;;; $F369: Common border setup ;;;
{
$82:F369 A9 10 00    LDA #$0010             ;\
$82:F36C 99 BD 1A    STA $1ABD,y[$7E:1AC9]  ;} Game options menu object Y position = 10h
$82:F36F A9 00 0E    LDA #$0E00             ;\
$82:F372 99 CD 1A    STA $1ACD,y[$7E:1AD9]  ;} Game options menu object palette index = E00h (palette 7)
$82:F375 60          RTS
}


;;; $F376: Pre-instruction - border around OPTIONS MODE ;;;
{
$82:F376 AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:F379 C9 02 00    CMP #$0002             ;} If [game state] = game options menu:
$82:F37C D0 13       BNE $13    [$F391]     ;/
$82:F37E AD E2 0D    LDA $0DE2  [$7E:0DE2]  ;\
$82:F381 C9 06 00    CMP #$0006             ;} If [game options menu index] != 6 (dissolve in screen): return
$82:F384 D0 19       BNE $19    [$F39F]     ;/
$82:F386 E2 20       SEP #$20
$82:F388 A5 51       LDA $51    [$7E:0051]  ;\
$82:F38A C9 80       CMP #$80               ;} If started fading in:
$82:F38C F0 03       BEQ $03    [$F391]     ;/
$82:F38E C2 20       REP #$20
$82:F390 60          RTS                    ; Return

$82:F391 C2 20       REP #$20
$82:F393 A9 01 00    LDA #$0001             ;\
$82:F396 9D 1D 1B    STA $1B1D,x[$7E:1B29]  ;} Game options menu object instruction timer = 1
$82:F399 A9 B6 F4    LDA #$F4B6             ;\
$82:F39C 9D FD 1A    STA $1AFD,x[$7E:1B09]  ;} Game options menu object instruction list pointer = $F4B6 (delete)

$82:F39F 60          RTS
}


;;; $F3A0: Pre-instruction - border around CONTROLLER SETTING MODE ;;;
{
$82:F3A0 AD E2 0D    LDA $0DE2  [$7E:0DE2]  ;\
$82:F3A3 C9 06 00    CMP #$0006             ;} If [game options menu index] != 6 (dissolve in screen): go to BRANCH_DISSOLVE_IN_END
$82:F3A6 D0 1A       BNE $1A    [$F3C2]     ;/
$82:F3A8 E2 20       SEP #$20
$82:F3AA A5 51       LDA $51    [$7E:0051]  ;\
$82:F3AC C9 80       CMP #$80               ;} If started fading in:
$82:F3AE F0 03       BEQ $03    [$F3B3]     ;/
$82:F3B0 C2 20       REP #$20
$82:F3B2 60          RTS                    ; Return

$82:F3B3 C2 20       REP #$20
$82:F3B5 A9 01 00    LDA #$0001             ;\
$82:F3B8 9D 1D 1B    STA $1B1D,x            ;} Game options menu object instruction timer = 1
$82:F3BB A9 B6 F4    LDA #$F4B6             ;\
$82:F3BE 9D FD 1A    STA $1AFD,x            ;} Game options menu object instruction list pointer = $F4B6 (delete)
$82:F3C1 60          RTS                    ; Return

; BRANCH_DISSOLVE_IN_END
$82:F3C2 C9 09 00    CMP #$0009             ;\
$82:F3C5 D0 0B       BNE $0B    [$F3D2]     ;} If [game options menu index] != 6 (scroll controller settings down):
$82:F3C7 BD BD 1A    LDA $1ABD,x            ;\
$82:F3CA 38          SEC                    ;|
$82:F3CB E9 02 00    SBC #$0002             ;} Game options menu object Y position -= 2
$82:F3CE 9D BD 1A    STA $1ABD,x            ;/
$82:F3D1 60          RTS                    ; Return

$82:F3D2 C9 0A 00    CMP #$000A             ;\
$82:F3D5 D0 0A       BNE $0A    [$F3E1]     ;} If [game options menu index] != Ah (scroll controller settings up):
$82:F3D7 BD BD 1A    LDA $1ABD,x            ;\
$82:F3DA 18          CLC                    ;|
$82:F3DB 69 02 00    ADC #$0002             ;} Game options menu object Y position += 2
$82:F3DE 9D BD 1A    STA $1ABD,x            ;/

$82:F3E1 60          RTS
}


;;; $F3E2: Pre-instruction - border around SPECIAL SETTING MODE ;;;
{
$82:F3E2 AD E2 0D    LDA $0DE2  [$7E:0DE2]  ;\
$82:F3E5 C9 06 00    CMP #$0006             ;} If [game options menu index] != 6 (dissolve in screen): return
$82:F3E8 D0 19       BNE $19    [$F403]     ;/
$82:F3EA E2 20       SEP #$20
$82:F3EC A5 51       LDA $51    [$7E:0051]  ;\
$82:F3EE C9 80       CMP #$80               ;} If started fading in:
$82:F3F0 F0 03       BEQ $03    [$F3F5]     ;/
$82:F3F2 C2 20       REP #$20
$82:F3F4 60          RTS                    ; Return

$82:F3F5 C2 20       REP #$20
$82:F3F7 A9 01 00    LDA #$0001             ;\
$82:F3FA 9D 1D 1B    STA $1B1D,x[$7E:1B27]  ;} Game options menu object instruction timer = 1
$82:F3FD A9 B6 F4    LDA #$F4B6             ;\
$82:F400 9D FD 1A    STA $1AFD,x[$7E:1B07]  ;} Game options menu object instruction list pointer = $F4B6 (delete)

$82:F403 60          RTS
}


;;; $F404: Unused. Pre-instruction ;;;
{
$82:F404 AD E2 0D    LDA $0DE2  [$7E:0DE2]  ;\
$82:F407 C9 01 00    CMP #$0001             ;} If [game options menu index] = 1 (loading options menu):
$82:F40A D0 0C       BNE $0C    [$F418]     ;/
$82:F40C A9 01 00    LDA #$0001             ;\
$82:F40F 9D 1D 1B    STA $1B1D,x            ;} Game options menu object instruction timer = 1
$82:F412 A9 B6 F4    LDA #$F4B6             ;\
$82:F415 9D FD 1A    STA $1AFD,x            ;} Game options menu object instruction list pointer = $F4B6 (delete)

$82:F418 60          RTS
}


;;; $F419: Setup - file select menu Samus helmet ;;;
{
$82:F419 A9 D8 00    LDA #$00D8             ;\
$82:F41C 99 AD 1A    STA $1AAD,y            ;} Game options menu object X position = D8h
$82:F41F A9 10 00    LDA #$0010             ;\
$82:F422 99 BD 1A    STA $1ABD,y            ;} Game options menu object Y position = 10h
$82:F425 A9 00 0E    LDA #$0E00             ;\
$82:F428 99 CD 1A    STA $1ACD,y            ;} Game options menu object palette index = E00h (palette 7)
$82:F42B 60          RTS
}


;;; $F42C: Pre-instruction - file select menu Samus helmet ;;;
{
$82:F42C AD 98 09    LDA $0998  [$7E:0998]  ;\
$82:F42F C9 02 00    CMP #$0002             ;} If [game state] != game options menu:
$82:F432 F0 0D       BEQ $0D    [$F441]     ;/
$82:F434 A9 01 00    LDA #$0001             ;\
$82:F437 9D 1D 1B    STA $1B1D,x            ;} Game options menu object instruction timer = 1
$82:F43A A9 B6 F4    LDA #$F4B6             ;\
$82:F43D 9D FD 1A    STA $1AFD,x            ;} Game options menu object instruction list pointer = $F4B6 (delete)
$82:F440 60          RTS

$82:F441 60          RTS
}


;;; $F442: Instruction list - menu selection missile ;;;
{
$82:F442             dx 0008,CBCB,
                        0008,CBD7,
                        0008,CBE3,
                        0008,CBEF,
                        8C82,F442   ; Go to $F442
}


;;; $F456: Instruction list - file select menu Samus helmet ;;;
{
$82:F456             dx 0090,CAE9,
                        0006,CAFF,
                        0008,CB15,
                        0001,CB2B,
                        0002,CB4B,
                        0004,CB6B,
                        0002,CB8B,
                        0001,CBAB,
                        009F,CB15,
                        8C82,F456   ; Go to $F456
}


;;; $F47E: Instruction list - border around OPTIONS MODE ;;;
{
$82:F47E             dx 0002,D24B,
                        8C6E,F376   ; Pre-instruction = $F376
$82:F486             dx 0090,D24B,
                        8C82,F486   ; Go to $F486
}


;;; $F48E: Instruction list - border around CONTROLLER SETTING MODE ;;;
{
$82:F48E             dx 0002,D2F7,
                        8C6E,F3A0   ; Pre-instruction = $F3A0
$82:F496             dx 0090,D2F7,
                        8C82,F496   ; Go to $F496
}


;;; $F49E: Instruction list - border around SPECIAL SETTING MODE ;;;
{
$82:F49E             dx 0002,D41B,
                        8C6E,F3E2   ; Pre-instruction = $F3E2
$82:F4A6             dx 0090,D41B,
                        8C82,F4A6   ; Go to $F4A6
}


;;; $F4AE: Instruction list - border around SAMUS DATA ;;;
{
$82:F4AE             dx 0090,D00B,
                        8C82,F4AE   ; Go to $F4AE
}


;;; $F4B6: Instruction list - delete ;;;
{
$82:F4B6             dx 8C5A        ; Delete
}


;;; $F4B8: Game options menu objects ;;;
{
;                        _____________ Setup
;                       |     ________ Pre-instruction
;                       |    |     ___ Instruction list
;                       |    |    |
$82:F4B8             dw F296,F2A9,F442 ; Menu selection missile
$82:F4BE             dw F419,F42C,F456 ; Unused. File select menu Samus helmet
$82:F4C4             dw F34B,8C10,F47E ; Border around OPTION MODE
$82:F4CA             dw F353,8C10,F48E ; Border around CONTROLLER SETTING MODE
$82:F4D0             dw F35B,8C10,F49E ; Border around SPECIAL SETTING MODE
$82:F4D6             dw F363,8C10,F4AE ; Border around SAMUS DATA
}
}


;;; $F4DC..F70D: Game options menu controller bindings ;;;
{
;;; $F4DC: Load game options menu controller bindings ;;;
{
$82:F4DC A2 00 00    LDX #$0000             ; X = 0 (game options menu controller binding index)

; LOOP
$82:F4DF BD 4A F5    LDA $F54A,x            ;\
$82:F4E2 A8          TAY                    ;} Y = [$F54A + [X]] (button binding RAM address)
$82:F4E3 B9 00 00    LDA $0000,y            ;\
$82:F4E6 89 40 00    BIT #$0040             ;} If [[Y]] & 40h != 0: go to BRANCH_X
$82:F4E9 D0 1E       BNE $1E    [$F509]     ;/
$82:F4EB 89 80 00    BIT #$0080             ;\
$82:F4EE D0 21       BNE $21    [$F511]     ;} If [[Y]] & 80h != 0: go to BRANCH_A
$82:F4F0 89 00 80    BIT #$8000             ;\
$82:F4F3 D0 24       BNE $24    [$F519]     ;} If [[Y]] & 8000h != 0: go to BRANCH_B
$82:F4F5 89 00 20    BIT #$2000             ;\
$82:F4F8 D0 27       BNE $27    [$F521]     ;} If [[Y]] & 2000h != 0: go to BRANCH_SELECT
$82:F4FA 89 00 40    BIT #$4000             ;\
$82:F4FD D0 2A       BNE $2A    [$F529]     ;} If [[Y]] & 4000h != 0: go to BRANCH_Y
$82:F4FF 89 20 00    BIT #$0020             ;\
$82:F502 D0 2D       BNE $2D    [$F531]     ;} If [[Y]] & 20h != 0: go to BRANCH_L
$82:F504 89 10 00    BIT #$0010             ;\
$82:F507 D0 30       BNE $30    [$F539]     ;} If [[Y]] & 10h != 0: go to BRANCH_R

; BRANCH_X
$82:F509 A9 00 00    LDA #$0000             ;\
$82:F50C 9D 3D 1B    STA $1B3D,x            ;} Game options menu controller binding = 0
$82:F50F 80 2E       BRA $2E    [$F53F]     ; Go to BRANCH_NEXT

; BRANCH_A
$82:F511 A9 01 00    LDA #$0001             ;\
$82:F514 9D 3D 1B    STA $1B3D,x            ;} Game options menu controller binding = 1
$82:F517 80 26       BRA $26    [$F53F]     ; Go to BRANCH_NEXT

; BRANCH_B
$82:F519 A9 02 00    LDA #$0002             ;\
$82:F51C 9D 3D 1B    STA $1B3D,x            ;} Game options menu controller binding = 2
$82:F51F 80 1E       BRA $1E    [$F53F]     ; Go to BRANCH_NEXT

; BRANCH_SELECT
$82:F521 A9 03 00    LDA #$0003             ;\
$82:F524 9D 3D 1B    STA $1B3D,x            ;} Game options menu controller binding = 3
$82:F527 80 16       BRA $16    [$F53F]     ; Go to BRANCH_NEXT

; BRANCH_Y
$82:F529 A9 04 00    LDA #$0004             ;\
$82:F52C 9D 3D 1B    STA $1B3D,x            ;} Game options menu controller binding = 4
$82:F52F 80 0E       BRA $0E    [$F53F]     ; Go to BRANCH_NEXT

; BRANCH_L
$82:F531 A9 05 00    LDA #$0005             ;\
$82:F534 9D 3D 1B    STA $1B3D,x            ;} Game options menu controller binding = 5
$82:F537 80 06       BRA $06    [$F53F]     ; Go to BRANCH_NEXT

; BRANCH_R
$82:F539 A9 06 00    LDA #$0006             ;\
$82:F53C 9D 3D 1B    STA $1B3D,x            ;} Game options menu controller binding = 6

; BRANCH_NEXT
$82:F53F E8          INX                    ;\
$82:F540 E8          INX                    ;} X += 2
$82:F541 E0 0E 00    CPX #$000E             ;\
$82:F544 10 03       BPL $03    [$F549]     ;} If [X] < Eh:
$82:F546 4C DF F4    JMP $F4DF  [$82:F4DF]  ; Go to LOOP

$82:F549 60          RTS
}


;;; $F54A: Configurable controller binding RAM addresses ;;;
{
$82:F54A             dw 09B2, ; Shoot binding
                        09B4, ; Jump binding
                        09B6, ; Run binding
                        09BA, ; Item switch binding
                        09B8, ; Item cancel binding
                        09BE, ; Aim up binding
                        09BC  ; Aim down binding
}


;;; $F558: Save game options menu controller bindings ;;;
{
$82:F558 A2 00 00    LDX #$0000             ; X = 0 (game options menu controller binding index)

; LOOP
$82:F55B DA          PHX
$82:F55C BD 4A F5    LDA $F54A,x            ;\
$82:F55F A8          TAY                    ;|
$82:F560 BD 3D 1B    LDA $1B3D,x            ;|
$82:F563 0A          ASL A                  ;} [$F54A + [X]] = [$F575 + [game options menu controller binding] * 2]
$82:F564 AA          TAX                    ;|
$82:F565 BD 75 F5    LDA $F575,x            ;|
$82:F568 99 00 00    STA $0000,y            ;/
$82:F56B FA          PLX
$82:F56C E8          INX                    ;\
$82:F56D E8          INX                    ;} X += 2
$82:F56E E0 0E 00    CPX #$000E             ;\
$82:F571 30 E8       BMI $E8    [$F55B]     ;} If [X] < Eh: go to LOOP
$82:F573 18          CLC
$82:F574 60          RTS
}


;;; $F575: Controller input bitmasks ;;;
{
$82:F575             dw 0040, ; X
                        0080, ; A
                        8000, ; B
                        2000, ; Select
                        4000, ; Y
                        0020, ; L
                        0010, ; R
                        0200, ; Left
                        0100  ; Right
}


;;; $F587: Draw game options menu controller bindings ;;;
{
$82:F587 A2 00 00    LDX #$0000             ; X = 0 (game options menu controller binding index)

; LOOP
$82:F58A DA          PHX                    ;\
$82:F58B BD 3D 1B    LDA $1B3D,x            ;|
$82:F58E 0A          ASL A                  ;|
$82:F58F A8          TAY                    ;|
$82:F590 BD 39 F6    LDA $F639,x            ;|
$82:F593 AA          TAX                    ;|
$82:F594 B9 47 F6    LDA $F647,y            ;|
$82:F597 A8          TAY                    ;|
$82:F598 B9 00 00    LDA $0000,y            ;|
$82:F59B 9F 00 30 7E STA $7E3000,x          ;|
$82:F59F B9 02 00    LDA $0002,y            ;} Copy button tilemap from [$F647 + [game options menu controller binding] * 2] to the 3x2 tile region of game options menu tilemap starting (17h, 5 + [X] * 3)
$82:F5A2 9F 02 30 7E STA $7E3002,x          ;|
$82:F5A6 B9 04 00    LDA $0004,y            ;|
$82:F5A9 9F 04 30 7E STA $7E3004,x          ;|
$82:F5AD B9 06 00    LDA $0006,y            ;|
$82:F5B0 9F 40 30 7E STA $7E3040,x          ;|
$82:F5B4 B9 08 00    LDA $0008,y            ;|
$82:F5B7 9F 42 30 7E STA $7E3042,x          ;|
$82:F5BB B9 0A 00    LDA $000A,y            ;|
$82:F5BE 9F 44 30 7E STA $7E3044,x          ;|
$82:F5C2 FA          PLX                    ;/
$82:F5C3 E8          INX                    ;\
$82:F5C4 E8          INX                    ;} X += 2
$82:F5C5 E0 0E 00    CPX #$000E             ;\
$82:F5C8 30 C0       BMI $C0    [$F58A]     ;} If [X] < Eh: go to LOOP
$82:F5CA AD 47 1B    LDA $1B47  [$7E:1B47]  ;\
$82:F5CD C9 05 00    CMP #$0005             ;} If [game options menu controller aim up binding] != L:
$82:F5D0 F0 2F       BEQ $2F    [$F601]     ;/
$82:F5D2 C9 06 00    CMP #$0006             ;\
$82:F5D5 F0 2A       BEQ $2A    [$F601]     ;} If [game options menu controller aim up binding] != R:
$82:F5D7 AD AD F6    LDA $F6AD  [$82:F6AD]  ;\
$82:F5DA 8F 2E 35 7E STA $7E352E[$7E:352E]  ;|
$82:F5DE AD AF F6    LDA $F6AF  [$82:F6AF]  ;|
$82:F5E1 8F 30 35 7E STA $7E3530[$7E:3530]  ;|
$82:F5E5 AD B1 F6    LDA $F6B1  [$82:F6B1]  ;|
$82:F5E8 8F 32 35 7E STA $7E3532[$7E:3532]  ;|
$82:F5EC AD B3 F6    LDA $F6B3  [$82:F6B3]  ;} Game options menu tilemap tiles (17h..19h, 14h..15h) = [$F6AD..B8] (OFF tilemap)
$82:F5EF 8F 6E 35 7E STA $7E356E[$7E:356E]  ;|
$82:F5F3 AD B5 F6    LDA $F6B5  [$82:F6B5]  ;|
$82:F5F6 8F 70 35 7E STA $7E3570[$7E:3570]  ;|
$82:F5FA AD B7 F6    LDA $F6B7  [$82:F6B7]  ;|
$82:F5FD 8F 72 35 7E STA $7E3572[$7E:3572]  ;/

$82:F601 AD 49 1B    LDA $1B49  [$7E:1B49]  ;\
$82:F604 C9 05 00    CMP #$0005             ;} If [game options menu controller aim down binding] != L:
$82:F607 F0 2F       BEQ $2F    [$F638]     ;/
$82:F609 C9 06 00    CMP #$0006             ;\
$82:F60C F0 2A       BEQ $2A    [$F638]     ;} If [game options menu controller aim down binding] != R:
$82:F60E AD AD F6    LDA $F6AD  [$82:F6AD]  ;\
$82:F611 8F EE 35 7E STA $7E35EE[$7E:35EE]  ;|
$82:F615 AD AF F6    LDA $F6AF  [$82:F6AF]  ;|
$82:F618 8F F0 35 7E STA $7E35F0[$7E:35F0]  ;|
$82:F61C AD B1 F6    LDA $F6B1  [$82:F6B1]  ;|
$82:F61F 8F F2 35 7E STA $7E35F2[$7E:35F2]  ;|
$82:F623 AD B3 F6    LDA $F6B3  [$82:F6B3]  ;} Game options menu tilemap tiles (17h..19h, 17h..18h) = [$F6AD..B8] (OFF tilemap)
$82:F626 8F 2E 36 7E STA $7E362E[$7E:362E]  ;|
$82:F62A AD B5 F6    LDA $F6B5  [$82:F6B5]  ;|
$82:F62D 8F 30 36 7E STA $7E3630[$7E:3630]  ;|
$82:F631 AD B7 F6    LDA $F6B7  [$82:F6B7]  ;|
$82:F634 8F 32 36 7E STA $7E3632[$7E:3632]  ;/

$82:F638 60          RTS

; Game options menu tilemap offsets
$82:F639             dw 016E, 022E, 02EE, 03AE, 046E, 052E, 05EE

; Controller button tilemap pointers
$82:F647             dw F659, F665, F671, F67D, F689, F695, F6A1, F6AD, F6AD

; X button tilemap
$82:F659             dw 0093,C0A3,000F,
                        00A3,C093,000F

; A button tilemap
$82:F665             dw 0090,4090,000F,
                        00A0,40A0,000F

; B button tilemap
$82:F671             dw 0091,0092,000F,
                        00A1,00A2,000F

; Select button tilemap
$82:F67D             dw 0095,0096,0097,
                        00A5,00A6,00A7

; Y button tilemap
$82:F689             dw 0094,4094,000F,
                        00A4,40A4,000F

; L button tilemap
$82:F695             dw 009A,009B,409A,
                        809A,00AB,C09A

; R button tilemap
$82:F6A1             dw 009A,009C,409A,
                        809A,00AC,C09A

; OFF tilemap
$82:F6AD             dw 0000,000E,000E,
                        0010,001F,001F
}


;;; $F6B9: Game options - controller settings - set binding ;;;
{
$82:F6B9 A2 0C 00    LDX #$000C             ; X = Ch
$82:F6BC A5 8F       LDA $8F    [$7E:008F]

; LOOP_INPUT
$82:F6BE 3C 75 F5    BIT $F575,x            ;\
$82:F6C1 D0 05       BNE $05    [$F6C8]     ;} If not newly pressed [$F575 + [X]]:
$82:F6C3 CA          DEX                    ;\
$82:F6C4 CA          DEX                    ;} X -= 2
$82:F6C5 10 F7       BPL $F7    [$F6BE]     ; If [X] >= 0: go to LOOP_INPUT
$82:F6C7 60          RTS                    ; Return

$82:F6C8 8A          TXA                    ;\
$82:F6C9 4A          LSR A                  ;} $12 = [X] / 2 (new value for game options menu controller binding)
$82:F6CA 85 12       STA $12    [$7E:0012]  ;/
$82:F6CC AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F6CF 0A          ASL A                  ;|
$82:F6D0 18          CLC                    ;|
$82:F6D1 69 02 00    ADC #$0002             ;|
$82:F6D4 C9 0E 00    CMP #$000E             ;} Y = ([menu option index] * 2 + 2) % Eh
$82:F6D7 30 03       BMI $03    [$F6DC]     ;|
$82:F6D9 A9 00 00    LDA #$0000             ;|
                                            ;|
$82:F6DC A8          TAY                    ;/
$82:F6DD A2 05 00    LDX #$0005             ; X = 5

; LOOP_FIND_EXISTING
$82:F6E0 B9 3D 1B    LDA $1B3D,y            ;\
$82:F6E3 C5 12       CMP $12    [$7E:0012]  ;} If [$1B3D + [Y]] = [$12]: go to BRANCH_FOUND
$82:F6E5 F0 0D       BEQ $0D    [$F6F4]     ;/
$82:F6E7 C8          INY                    ;\
$82:F6E8 C8          INY                    ;|
$82:F6E9 C0 0E 00    CPY #$000E             ;} Y = ([Y] + 2) % Eh
$82:F6EC 30 03       BMI $03    [$F6F1]     ;|
$82:F6EE A0 00 00    LDY #$0000             ;/

$82:F6F1 CA          DEX                    ; Decrement X
$82:F6F2 10 EC       BPL $EC    [$F6E0]     ; If [X] >= 0: go to LOOP_FIND_EXISTING

; BRANCH_FOUND
$82:F6F4 5A          PHY
$82:F6F5 AD 9E 09    LDA $099E  [$7E:099E]  ;\
$82:F6F8 0A          ASL A                  ;|
$82:F6F9 A8          TAY                    ;} $14 = [game options menu controller binding]
$82:F6FA B9 3D 1B    LDA $1B3D,y            ;|
$82:F6FD 85 14       STA $14    [$7E:0014]  ;/
$82:F6FF A5 12       LDA $12    [$7E:0012]  ;\
$82:F701 99 3D 1B    STA $1B3D,y            ;} Game options menu controller binding = [$12]
$82:F704 7A          PLY
$82:F705 A5 14       LDA $14    [$7E:0014]  ;\
$82:F707 99 3D 1B    STA $1B3D,y            ;} Game options menu controller binding [Y] = [$14]
$82:F70A 20 87 F5    JSR $F587  [$82:F587]  ; Draw game options menu controller bindings
$82:F70D 60          RTS
}
}
}


;;; $F70E: RTL ;;;
{
$82:F70E 6B          RTL
}


;;; $F70F: Free space ;;;
{
$82:F70F             fillto $838000, $FF
}
