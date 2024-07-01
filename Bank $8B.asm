;;; $8000: Set up PPU for title sequence ;;;
{
$8B:8000 08          PHP
$8B:8001 E2 30       SEP #$30
$8B:8003 A9 80       LDA #$80               ;\
$8B:8005 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank, brightness = 0
$8B:8008 85 51       STA $51    [$7E:0051]  ;/
$8B:800A A9 03       LDA #$03               ;\
$8B:800C 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$8B:800F 85 52       STA $52    [$7E:0052]  ;/
$8B:8011 A9 07       LDA #$07               ;\
$8B:8013 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 7
$8B:8016 85 55       STA $55    [$7E:0055]  ;/
$8B:8018 A9 80       LDA #$80               ;\
$8B:801A 8D 1A 21    STA $211A  [$7E:211A]  ;} Set mode 7 BG map overflowing tiles as transparent, no screen flip
$8B:801D 85 5F       STA $5F    [$7E:005F]  ;/
$8B:801F A9 00       LDA #$00               ;\
$8B:8021 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $0000, size = 32x32
$8B:8023 8D 07 21    STA $2107  [$7E:2107]  ;/
$8B:8026 64 59       STZ $59    [$7E:0059]  ;\
$8B:8028 9C 08 21    STZ $2108  [$7E:2108]  ;} BG2 tilemap base address = $0000, size = 32x32
$8B:802B 64 5A       STZ $5A    [$7E:005A]  ;\
$8B:802D 9C 09 21    STZ $2109  [$7E:2109]  ;} BG3 tilemap base address = $0000, size = 32x32
$8B:8030 64 5C       STZ $5C    [$7E:005C]  ;\
$8B:8032 9C 0A 21    STZ $210A  [$7E:210A]  ;} BG4 tilemap base address = $0000, size = 32x32
$8B:8035 64 5D       STZ $5D    [$7E:005D]  ;\
$8B:8037 9C 0B 21    STZ $210B  [$7E:210B]  ;|
$8B:803A 64 5E       STZ $5E    [$7E:005E]  ;} BG tiles base address = $0000
$8B:803C 9C 0C 21    STZ $210C  [$7E:210C]  ;/
$8B:803F A9 10       LDA #$10               ;\
$8B:8041 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = sprites
$8B:8044 85 69       STA $69    [$7E:0069]  ;/
$8B:8046 9C 2D 21    STZ $212D  [$7E:212D]  ;\
$8B:8049 64 6B       STZ $6B    [$7E:006B]  ;} Disable all subscreen layers
$8B:804B 9C 2E 21    STZ $212E  [$7E:212E]  ;\
$8B:804E 64 6C       STZ $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$8B:8050 9C 15 21    STZ $2115  [$7E:2115]  ; VRAM address increment mode = 8-bit access
$8B:8053 9C 30 21    STZ $2130  [$7E:2130]  ;\
$8B:8056 64 6E       STZ $6E    [$7E:006E]  ;|
$8B:8058 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$8B:805B 64 71       STZ $71    [$7E:0071]  ;/
$8B:805D A9 E0       LDA #$E0               ;\
$8B:805F 8D 32 21    STA $2132  [$7E:2132]  ;} Colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:8062 A9 00       LDA #$00               ;\
$8B:8064 8D 33 21    STA $2133  [$7E:2133]  ;} Use standard NTSC resolution
$8B:8067 85 77       STA $77    [$7E:0077]  ;/
$8B:8069 C2 30       REP #$30
$8B:806B A9 00 00    LDA #$0000             ;\
$8B:806E A2 00 30    LDX #$3000             ;|
$8B:8071 A0 FE 07    LDY #$07FE             ;} $7E:3000..37FD = 0
$8B:8074 22 F6 83 80 JSL $8083F6[$80:83F6]  ;/
$8B:8078 9C 90 05    STZ $0590  [$7E:0590]  ; OAM data index = 0
$8B:807B 9C 9E 09    STZ $099E  [$7E:099E]  ; Menu option index = 0
$8B:807E 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$8B:8081 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$8B:8084 9C 29 07    STZ $0729  [$7E:0729]  ;\
$8B:8087 9C 2B 07    STZ $072B  [$7E:072B]  ;|
$8B:808A 9C 2D 07    STZ $072D  [$7E:072D]  ;} $0729..32 = 0
$8B:808D 9C 2F 07    STZ $072F  [$7E:072F]  ;|
$8B:8090 9C 31 07    STZ $0731  [$7E:0731]  ;/
$8B:8093 9C 3D 07    STZ $073D  [$7E:073D]  ;\
$8B:8096 9C 3F 07    STZ $073F  [$7E:073F]  ;|
$8B:8099 9C 41 07    STZ $0741  [$7E:0741]  ;} $073D..46 = 0
$8B:809C 9C 43 07    STZ $0743  [$7E:0743]  ;|
$8B:809F 9C 45 07    STZ $0745  [$7E:0745]  ;/
$8B:80A2 9C 51 07    STZ $0751  [$7E:0751]  ;\
$8B:80A5 9C 53 07    STZ $0753  [$7E:0753]  ;|
$8B:80A8 9C 55 07    STZ $0755  [$7E:0755]  ;} $0751..5A = 0
$8B:80AB 9C 57 07    STZ $0757  [$7E:0757]  ;|
$8B:80AE 9C 59 07    STZ $0759  [$7E:0759]  ;/
$8B:80B1 9C D6 09    STZ $09D6  [$7E:09D6]  ; Samus reserve health = 0
$8B:80B4 9C D8 09    STZ $09D8  [$7E:09D8]  ; Samus reserve missiles = 0
$8B:80B7 9C 8D 19    STZ $198D  [$7E:198D]  ; Mode 7 transformation angle = 0
$8B:80BA A9 00 01    LDA #$0100             ;\
$8B:80BD 8D 8F 19    STA $198F  [$7E:198F]  ;} Mode 7 transformation zoom level = 100h
$8B:80C0 9C 91 19    STZ $1991  [$7E:1991]  ;\
$8B:80C3 9C 93 19    STZ $1993  [$7E:1993]  ;} Mode 7 X position = 0.0
$8B:80C6 9C 95 19    STZ $1995  [$7E:1995]  ;\
$8B:80C9 9C 97 19    STZ $1997  [$7E:1997]  ;} Mode 7 Y position = 0.0
$8B:80CC 9C 99 19    STZ $1999  [$7E:1999]  ;\
$8B:80CF 9C 9B 19    STZ $199B  [$7E:199B]  ;} Mode 7 X speed = 0.0
$8B:80D2 9C 9D 19    STZ $199D  [$7E:199D]  ;\
$8B:80D5 9C 9F 19    STZ $199F  [$7E:199F]  ;} Mode 7 Y speed = 0.0
$8B:80D8 28          PLP
$8B:80D9 60          RTS
}


;;; $80DA: Set up PPU for intro ;;;
{
$8B:80DA 08          PHP
$8B:80DB E2 30       SEP #$30
$8B:80DD A9 80       LDA #$80               ;\
$8B:80DF 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank, brightness = 0
$8B:80E2 85 51       STA $51    [$7E:0051]  ;/
$8B:80E4 A9 03       LDA #$03               ;\
$8B:80E6 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$8B:80E9 85 52       STA $52    [$7E:0052]  ;/
$8B:80EB A9 09       LDA #$09               ;\
$8B:80ED 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 1 with BG3 priority, BG tile sizes = 8x8
$8B:80F0 85 55       STA $55    [$7E:0055]  ;/
$8B:80F2 A9 00       LDA #$00               ;\
$8B:80F4 8D 1A 21    STA $211A  [$7E:211A]  ;} Set mode 7 BG map to wrap within 128x128 tile area, no screen flip
$8B:80F7 85 5F       STA $5F    [$7E:005F]  ;/
$8B:80F9 A9 50       LDA #$50               ;\
$8B:80FB 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $5000, size = 32x32
$8B:80FD 8D 07 21    STA $2107  [$7E:2107]  ;/
$8B:8100 A9 48       LDA #$48               ;\
$8B:8102 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4800, size = 32x32
$8B:8104 8D 08 21    STA $2108  [$7E:2108]  ;/
$8B:8107 A9 4C       LDA #$4C               ;\
$8B:8109 85 5A       STA $5A    [$7E:005A]  ;} BG3 tilemap base address = $4C00, size = 32x32
$8B:810B 8D 09 21    STA $2109  [$7E:2109]  ;/
$8B:810E 64 5C       STZ $5C    [$7E:005C]  ;\
$8B:8110 9C 0A 21    STZ $210A  [$7E:210A]  ;} BG4 tilemap base address = $0000, size = 32x32
$8B:8113 64 5D       STZ $5D    [$7E:005D]  ;\
$8B:8115 9C 0B 21    STZ $210B  [$7E:210B]  ;|
$8B:8118 A9 04       LDA #$04               ;} BG1/2/4 tiles base address = $0000, BG3 tiles base address = $4000
$8B:811A 85 5E       STA $5E    [$7E:005E]  ;|
$8B:811C 8D 0C 21    STA $210C  [$7E:210C]  ;/
$8B:811F A9 04       LDA #$04               ;\
$8B:8121 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG3
$8B:8124 85 69       STA $69    [$7E:0069]  ;/
$8B:8126 9C 2D 21    STZ $212D  [$7E:212D]  ;\
$8B:8129 64 6B       STZ $6B    [$7E:006B]  ;} Disable all subscreen layers
$8B:812B 9C 2E 21    STZ $212E  [$7E:212E]  ;\
$8B:812E 64 6C       STZ $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$8B:8130 9C 15 21    STZ $2115  [$7E:2115]  ; VRAM address increment mode = 8-bit access
$8B:8133 9C 30 21    STZ $2130  [$7E:2130]  ;\
$8B:8136 64 6E       STZ $6E    [$7E:006E]  ;|
$8B:8138 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable PPU colour math
$8B:813B 64 71       STZ $71    [$7E:0071]  ;/
$8B:813D A9 E0       LDA #$E0               ;\
$8B:813F 8D 32 21    STA $2132  [$7E:2132]  ;} PPU colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:8142 A9 00       LDA #$00               ;\
$8B:8144 8D 33 21    STA $2133  [$7E:2133]  ;} Use standard NTSC resolution
$8B:8147 85 77       STA $77    [$7E:0077]  ;/
$8B:8149 64 6F       STZ $6F    [$7E:006F]  ;\
$8B:814B 64 72       STZ $72    [$7E:0072]  ;} Disable colour math
$8B:814D A9 20       LDA #$20               ;\
$8B:814F 85 74       STA $74    [$7E:0074]  ;|
$8B:8151 A9 40       LDA #$40               ;|
$8B:8153 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:8155 A9 80       LDA #$80               ;|
$8B:8157 85 76       STA $76    [$7E:0076]  ;/
$8B:8159 64 57       STZ $57    [$7E:0057]  ; Disable mosaic
$8B:815B C2 30       REP #$30
$8B:815D A9 2F 00    LDA #$002F             ;\
$8B:8160 A2 00 30    LDX #$3000             ;|
$8B:8163 A0 FE 07    LDY #$07FE             ;} $7E:3000..37FD = 0
$8B:8166 22 F6 83 80 JSL $8083F6[$80:83F6]  ;/
$8B:816A 9C 90 05    STZ $0590  [$7E:0590]  ; OAM data index = 0
$8B:816D 9C 8D 19    STZ $198D  [$7E:198D]  ; Mode 7 transformation angle = 0
$8B:8170 A9 00 01    LDA #$0100             ;\
$8B:8173 8D 8F 19    STA $198F  [$7E:198F]  ;} Mode 7 transformation zoom level = 100h
$8B:8176 9C 91 19    STZ $1991  [$7E:1991]  ;\
$8B:8179 9C 93 19    STZ $1993  [$7E:1993]  ;} Mode 7 X position = 0.0
$8B:817C 9C 95 19    STZ $1995  [$7E:1995]  ;\
$8B:817F 9C 97 19    STZ $1997  [$7E:1997]  ;} Mode 7 Y position = 0.0
$8B:8182 9C 99 19    STZ $1999  [$7E:1999]  ;\
$8B:8185 9C 9B 19    STZ $199B  [$7E:199B]  ;} Mode 7 X speed = 0.0
$8B:8188 9C 9D 19    STZ $199D  [$7E:199D]  ;\
$8B:818B 9C 9F 19    STZ $199F  [$7E:199F]  ;} Mode 7 Y speed = 0.0
$8B:818E 9C 82 19    STZ $1982  [$7E:1982]  ; Default layer blending configuration = 0
$8B:8191 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$8B:8193 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$8B:8195 64 B9       STZ $B9    [$7E:00B9]  ; BG3 X scroll = 0
$8B:8197 64 BB       STZ $BB    [$7E:00BB]  ; BG3 Y scroll = 0
$8B:8199 28          PLP
$8B:819A 60          RTS
}


;;; $819B: Set up PPU for Ceres cutscene ;;;
{
$8B:819B 08          PHP
$8B:819C E2 30       SEP #$30
$8B:819E A9 80       LDA #$80               ;\
$8B:81A0 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank, brightness = 0
$8B:81A3 85 51       STA $51    [$7E:0051]  ;/
$8B:81A5 A9 03       LDA #$03               ;\
$8B:81A7 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$8B:81AA 85 52       STA $52    [$7E:0052]  ;/
$8B:81AC A9 07       LDA #$07               ;\
$8B:81AE 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 7
$8B:81B1 85 55       STA $55    [$7E:0055]  ;/
$8B:81B3 A9 80       LDA #$80               ;\
$8B:81B5 8D 1A 21    STA $211A  [$7E:211A]  ;} Set mode 7 BG map overflowing tiles as transparent, no screen flip
$8B:81B8 85 5F       STA $5F    [$7E:005F]  ;/
$8B:81BA A9 00       LDA #$00               ;\
$8B:81BC 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $0000, size = 32x32
$8B:81BE 8D 07 21    STA $2107  [$7E:2107]  ;/
$8B:81C1 64 59       STZ $59    [$7E:0059]  ;\
$8B:81C3 9C 08 21    STZ $2108  [$7E:2108]  ;} BG2 tilemap base address = $0000, size = 32x32
$8B:81C6 64 5A       STZ $5A    [$7E:005A]  ;\
$8B:81C8 9C 09 21    STZ $2109  [$7E:2109]  ;} BG3 tilemap base address = $0000, size = 32x32
$8B:81CB 64 5C       STZ $5C    [$7E:005C]  ;\
$8B:81CD 9C 0A 21    STZ $210A  [$7E:210A]  ;} BG4 tilemap base address = $0000, size = 32x32
$8B:81D0 64 5D       STZ $5D    [$7E:005D]  ;\
$8B:81D2 9C 0B 21    STZ $210B  [$7E:210B]  ;|
$8B:81D5 64 5E       STZ $5E    [$7E:005E]  ;} BG tiles base address = $0000
$8B:81D7 9C 0C 21    STZ $210C  [$7E:210C]  ;/
$8B:81DA A9 11       LDA #$11               ;\
$8B:81DC 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG1/sprites
$8B:81DF 85 69       STA $69    [$7E:0069]  ;/
$8B:81E1 A9 00       LDA #$00               ;\
$8B:81E3 8D 2D 21    STA $212D  [$7E:212D]  ;} Disable all subscreen layers
$8B:81E6 85 6B       STA $6B    [$7E:006B]  ;/
$8B:81E8 9C 2E 21    STZ $212E  [$7E:212E]  ;\
$8B:81EB 64 6C       STZ $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$8B:81ED 9C 15 21    STZ $2115  [$7E:2115]  ; VRAM address increment mode = 8-bit access
$8B:81F0 9C 30 21    STZ $2130  [$7E:2130]  ;\
$8B:81F3 64 6E       STZ $6E    [$7E:006E]  ;|
$8B:81F5 9C 31 21    STZ $2131  [$7E:2131]  ;|
$8B:81F8 64 71       STZ $71    [$7E:0071]  ;|
$8B:81FA A9 E0       LDA #$E0               ;|
$8B:81FC 8D 32 21    STA $2132  [$7E:2132]  ;|
$8B:81FF 64 6F       STZ $6F    [$7E:006F]  ;|
$8B:8201 64 72       STZ $72    [$7E:0072]  ;} Disable colour math, colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:8203 A9 20       LDA #$20               ;|
$8B:8205 85 74       STA $74    [$7E:0074]  ;|
$8B:8207 A9 40       LDA #$40               ;|
$8B:8209 85 75       STA $75    [$7E:0075]  ;|
$8B:820B A9 80       LDA #$80               ;|
$8B:820D 85 76       STA $76    [$7E:0076]  ;/
$8B:820F 64 57       STZ $57    [$7E:0057]  ; Disable mosaic
$8B:8211 C2 30       REP #$30
$8B:8213 9C 91 19    STZ $1991  [$7E:1991]  ;\
$8B:8216 9C 93 19    STZ $1993  [$7E:1993]  ;} Mode 7 X position = 0.0
$8B:8219 9C 95 19    STZ $1995  [$7E:1995]  ;\
$8B:821C 9C 97 19    STZ $1997  [$7E:1997]  ;} Mode 7 Y position = 0.0
$8B:821F 9C 99 19    STZ $1999  [$7E:1999]  ;\
$8B:8222 9C 9B 19    STZ $199B  [$7E:199B]  ;} Mode 7 X speed = 0.0
$8B:8225 9C 9D 19    STZ $199D  [$7E:199D]  ;\
$8B:8228 9C 9F 19    STZ $199F  [$7E:199F]  ;} Mode 7 Y speed = 0.0
$8B:822B 9C 82 19    STZ $1982  [$7E:1982]  ; Default layer blending configuration = 0
$8B:822E 28          PLP
$8B:822F 60          RTS
}


;;; $8230: Set up PPU for Samus goes to Zebes cutscene ;;;
{
$8B:8230 08          PHP
$8B:8231 E2 30       SEP #$30
$8B:8233 A9 80       LDA #$80               ;\
$8B:8235 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank, brightness = 0
$8B:8238 85 51       STA $51    [$7E:0051]  ;/
$8B:823A A9 03       LDA #$03               ;\
$8B:823C 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$8B:823F 85 52       STA $52    [$7E:0052]  ;/
$8B:8241 A9 01       LDA #$01               ;\
$8B:8243 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 1 without BG3 priority, BG tile sizes = 8x8
$8B:8246 85 55       STA $55    [$7E:0055]  ;/
$8B:8248 A9 00       LDA #$00               ;\
$8B:824A 8D 1A 21    STA $211A  [$7E:211A]  ;} Set mode 7 BG map to wrap within 128x128 tile area, no screen flip
$8B:824D 85 5F       STA $5F    [$7E:005F]  ;/
$8B:824F A9 5C       LDA #$5C               ;\
$8B:8251 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $5C00, size = 32x32
$8B:8253 8D 07 21    STA $2107  [$7E:2107]  ;/
$8B:8256 64 59       STZ $59    [$7E:0059]  ;\
$8B:8258 9C 08 21    STZ $2108  [$7E:2108]  ;} BG2 tilemap base address = $0000, size = 32x32
$8B:825B 64 5A       STZ $5A    [$7E:005A]  ;\
$8B:825D 9C 09 21    STZ $2109  [$7E:2109]  ;} BG3 tilemap base address = $0000, size = 32x32
$8B:8260 64 5C       STZ $5C    [$7E:005C]  ;\
$8B:8262 9C 0A 21    STZ $210A  [$7E:210A]  ;} BG4 tilemap base address = $0000, size = 32x32
$8B:8265 A9 06       LDA #$06               ;\
$8B:8267 85 5D       STA $5D    [$7E:005D]  ;|
$8B:8269 8D 0B 21    STA $210B  [$7E:210B]  ;} BG1 tiles base address = $6000, BG2/3/4 tiles base address = $0000
$8B:826C 64 5E       STZ $5E    [$7E:005E]  ;|
$8B:826E 9C 0C 21    STZ $210C  [$7E:210C]  ;/
$8B:8271 A9 11       LDA #$11               ;\
$8B:8273 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG1/sprites
$8B:8276 85 69       STA $69    [$7E:0069]  ;/
$8B:8278 9C 2D 21    STZ $212D  [$7E:212D]  ;\
$8B:827B 64 6B       STZ $6B    [$7E:006B]  ;} Disable all subscreen layers
$8B:827D 64 60       STZ $60    [$7E:0060]  ;\
$8B:827F 64 61       STZ $61    [$7E:0061]  ;} Disable all window masks
$8B:8281 64 62       STZ $62    [$7E:0062]  ;/
$8B:8283 64 6C       STZ $6C    [$7E:006C]  ;\
$8B:8285 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area
$8B:8287 64 6F       STZ $6F    [$7E:006F]  ;\
$8B:8289 64 72       STZ $72    [$7E:0072]  ;} Disable colour math
$8B:828B C2 30       REP #$30
$8B:828D 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$8B:828F 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$8B:8291 28          PLP
$8B:8292 60          RTS
}


;;; $8293: Set up PPU for Zebes destruction ;;;
{
$8B:8293 08          PHP
$8B:8294 E2 30       SEP #$30
$8B:8296 A9 80       LDA #$80               ;\
$8B:8298 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank, brightness = 0
$8B:829B 85 51       STA $51    [$7E:0051]  ;/
$8B:829D A9 A3       LDA #$A3               ;\
$8B:829F 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $6000, sprite sizes = 32x32 / 64x64
$8B:82A2 85 52       STA $52    [$7E:0052]  ;/
$8B:82A4 A9 07       LDA #$07               ;\
$8B:82A6 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 7
$8B:82A9 85 55       STA $55    [$7E:0055]  ;/
$8B:82AB A9 00       LDA #$00               ;\
$8B:82AD 8D 1A 21    STA $211A  [$7E:211A]  ;} Set mode 7 BG map to wrap within 128x128 tile area, no screen flip
$8B:82B0 85 5F       STA $5F    [$7E:005F]  ;/
$8B:82B2 A9 00       LDA #$00               ;\
$8B:82B4 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $0000, size = 32x32
$8B:82B6 8D 07 21    STA $2107  [$7E:2107]  ;/
$8B:82B9 64 59       STZ $59    [$7E:0059]  ;\
$8B:82BB 9C 08 21    STZ $2108  [$7E:2108]  ;} BG2 tilemap base address = $0000, size = 32x32
$8B:82BE 64 5A       STZ $5A    [$7E:005A]  ;\
$8B:82C0 9C 09 21    STZ $2109  [$7E:2109]  ;} BG3 tilemap base address = $0000, size = 32x32
$8B:82C3 64 5C       STZ $5C    [$7E:005C]  ;\
$8B:82C5 9C 0A 21    STZ $210A  [$7E:210A]  ;} BG4 tilemap base address = $0000, size = 32x32
$8B:82C8 64 5D       STZ $5D    [$7E:005D]  ;\
$8B:82CA 9C 0B 21    STZ $210B  [$7E:210B]  ;|
$8B:82CD 64 5E       STZ $5E    [$7E:005E]  ;} BG tiles base address = $0000
$8B:82CF 9C 0C 21    STZ $210C  [$7E:210C]  ;/
$8B:82D2 A9 11       LDA #$11               ;\
$8B:82D4 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG1/sprites
$8B:82D7 85 69       STA $69    [$7E:0069]  ;/
$8B:82D9 9C 2D 21    STZ $212D  [$7E:212D]  ;\
$8B:82DC 64 6B       STZ $6B    [$7E:006B]  ;} Disable all subscreen layers
$8B:82DE 9C 2E 21    STZ $212E  [$7E:212E]  ;\
$8B:82E1 64 6C       STZ $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$8B:82E3 9C 15 21    STZ $2115  [$7E:2115]  ; VRAM address increment mode = 8-bit access
$8B:82E6 9C 30 21    STZ $2130  [$7E:2130]  ;\
$8B:82E9 64 6E       STZ $6E    [$7E:006E]  ;|
$8B:82EB 9C 31 21    STZ $2131  [$7E:2131]  ;|
$8B:82EE 64 71       STZ $71    [$7E:0071]  ;} Disable colour math
$8B:82F0 64 6F       STZ $6F    [$7E:006F]  ;|
$8B:82F2 64 72       STZ $72    [$7E:0072]  ;/
$8B:82F4 A9 E0       LDA #$E0               ;\
$8B:82F6 8D 32 21    STA $2132  [$7E:2132]  ;} PPU colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:82F9 A9 00       LDA #$00               ;\
$8B:82FB 8D 33 21    STA $2133  [$7E:2133]  ;} Use standard NTSC resolution
$8B:82FE 85 77       STA $77    [$7E:0077]  ;/
$8B:8300 A9 20       LDA #$20               ;\
$8B:8302 85 74       STA $74    [$7E:0074]  ;|
$8B:8304 A9 40       LDA #$40               ;|
$8B:8306 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:8308 A9 80       LDA #$80               ;|
$8B:830A 85 76       STA $76    [$7E:0076]  ;/
$8B:830C C2 30       REP #$30
$8B:830E 9C 90 05    STZ $0590  [$7E:0590]  ; OAM data index = 0
$8B:8311 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$8B:8314 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$8B:8317 9C 8D 19    STZ $198D  [$7E:198D]  ; Mode 7 transformation angle = 0
$8B:831A A9 00 01    LDA #$0100             ;\
$8B:831D 8D 8F 19    STA $198F  [$7E:198F]  ;} Mode 7 transformation zoom level = 100h
$8B:8320 9C 91 19    STZ $1991  [$7E:1991]  ;\
$8B:8323 9C 93 19    STZ $1993  [$7E:1993]  ;} Mode 7 X position = 0.0
$8B:8326 9C 95 19    STZ $1995  [$7E:1995]  ;\
$8B:8329 9C 97 19    STZ $1997  [$7E:1997]  ;} Mode 7 Y position = 0.0
$8B:832C 9C 99 19    STZ $1999  [$7E:1999]  ;\
$8B:832F 9C 9B 19    STZ $199B  [$7E:199B]  ;} Mode 7 X speed = 0.0
$8B:8332 9C 9D 19    STZ $199D  [$7E:199D]  ;\
$8B:8335 9C 9F 19    STZ $199F  [$7E:199F]  ;} Mode 7 Y speed = 0.0
$8B:8338 28          PLP
$8B:8339 60          RTS
}


;;; $833A: Unused. Set up PPU for Zebes destruction space view ;;;
{
; Corresponds to the PPU setup done at $DA64 as part of
;     $DA1A: Cinematic function - ending - Zebes destruction scene 2 - cross-fade to space view
$8B:833A 08          PHP
$8B:833B E2 30       SEP #$30
$8B:833D A9 80       LDA #$80               ;\
$8B:833F 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank, brightness = 0
$8B:8342 85 51       STA $51    [$7E:0051]  ;/
$8B:8344 A9 02       LDA #$02               ;\
$8B:8346 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $4000, sprite sizes = 8x8 / 16x16
$8B:8349 85 52       STA $52    [$7E:0052]  ;/
$8B:834B A9 01       LDA #$01               ;\
$8B:834D 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 1 without BG3 priority, BG tile sizes = 8x8
$8B:8350 85 55       STA $55    [$7E:0055]  ;/
$8B:8352 9C 1A 21    STZ $211A  [$7E:211A]  ;\
$8B:8355 64 5F       STZ $5F    [$7E:005F]  ;} Set mode 7 BG map to wrap within 128x128 tile area, no screen flip
$8B:8357 A9 70       LDA #$70               ;\
$8B:8359 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $7000, size = 32x32
$8B:835B 8D 07 21    STA $2107  [$7E:2107]  ;/
$8B:835E A9 78       LDA #$78               ;\
$8B:8360 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $7800, size = 32x32
$8B:8362 8D 08 21    STA $2108  [$7E:2108]  ;/
$8B:8365 64 5A       STZ $5A    [$7E:005A]  ;\
$8B:8367 9C 09 21    STZ $2109  [$7E:2109]  ;} BG3 tilemap base address = $0000, size = 32x32
$8B:836A 64 5C       STZ $5C    [$7E:005C]  ;\
$8B:836C 9C 0A 21    STZ $210A  [$7E:210A]  ;} BG4 tilemap base address = $0000, size = 32x32
$8B:836F A9 44       LDA #$44               ;\
$8B:8371 85 5D       STA $5D    [$7E:005D]  ;|
$8B:8373 8D 0B 21    STA $210B  [$7E:210B]  ;} BG1/2 tiles base address = $4000, BG3/4 tiles base address = $0000
$8B:8376 64 5E       STZ $5E    [$7E:005E]  ;|
$8B:8378 9C 0C 21    STZ $210C  [$7E:210C]  ;/
$8B:837B A9 10       LDA #$10               ;\
$8B:837D 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = sprites
$8B:8380 85 69       STA $69    [$7E:0069]  ;/
$8B:8382 9C 2D 21    STZ $212D  [$7E:212D]  ;\
$8B:8385 64 6B       STZ $6B    [$7E:006B]  ;} Disable all subscreen layers
$8B:8387 9C 2E 21    STZ $212E  [$7E:212E]  ;\
$8B:838A 64 6C       STZ $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$8B:838C 9C 15 21    STZ $2115  [$7E:2115]  ; VRAM address increment mode = 8-bit access
$8B:838F 9C 30 21    STZ $2130  [$7E:2130]  ;\
$8B:8392 64 6E       STZ $6E    [$7E:006E]  ;|
$8B:8394 9C 31 21    STZ $2131  [$7E:2131]  ;|
$8B:8397 64 71       STZ $71    [$7E:0071]  ;|
$8B:8399 A9 E0       LDA #$E0               ;|
$8B:839B 8D 32 21    STA $2132  [$7E:2132]  ;|
$8B:839E 64 6F       STZ $6F    [$7E:006F]  ;|
$8B:83A0 64 72       STZ $72    [$7E:0072]  ;} Disable colour math, colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:83A2 A9 20       LDA #$20               ;|
$8B:83A4 85 74       STA $74    [$7E:0074]  ;|
$8B:83A6 A9 40       LDA #$40               ;|
$8B:83A8 85 75       STA $75    [$7E:0075]  ;|
$8B:83AA A9 80       LDA #$80               ;|
$8B:83AC 85 76       STA $76    [$7E:0076]  ;/
$8B:83AE 64 57       STZ $57    [$7E:0057]  ; Disable mosaic
$8B:83B0 C2 30       REP #$30
$8B:83B2 9C 91 19    STZ $1991  [$7E:1991]  ;\
$8B:83B5 9C 93 19    STZ $1993  [$7E:1993]  ;} Mode 7 X position = 0.0
$8B:83B8 9C 95 19    STZ $1995  [$7E:1995]  ;\
$8B:83BB 9C 97 19    STZ $1997  [$7E:1997]  ;} Mode 7 Y position = 0.0
$8B:83BE 9C 99 19    STZ $1999  [$7E:1999]  ;\
$8B:83C1 9C 9B 19    STZ $199B  [$7E:199B]  ;} Mode 7 X speed = 0.0
$8B:83C4 9C 9D 19    STZ $199D  [$7E:199D]  ;\
$8B:83C7 9C 9F 19    STZ $199F  [$7E:199F]  ;} Mode 7 Y speed = 0.0
$8B:83CA 9C 82 19    STZ $1982  [$7E:1982]  ; Default layer blending configuration = 0
$8B:83CD 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$8B:83CF 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$8B:83D1 28          PLP
$8B:83D2 60          RTS
}


;;; $83D3: Set up PPU for credits ;;;
{
$8B:83D3 08          PHP
$8B:83D4 E2 30       SEP #$30
$8B:83D6 A9 80       LDA #$80               ;\
$8B:83D8 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank, brightness = 0
$8B:83DB 85 51       STA $51    [$7E:0051]  ;/
$8B:83DD A9 00       LDA #$00               ;\
$8B:83DF 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $0000, sprite sizes = 8x8 / 16x16
$8B:83E2 85 52       STA $52    [$7E:0052]  ;/
$8B:83E4 A9 01       LDA #$01               ;\
$8B:83E6 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 1 without BG3 priority, BG tile sizes = 8x8
$8B:83E9 85 55       STA $55    [$7E:0055]  ;/
$8B:83EB A9 00       LDA #$00               ;\
$8B:83ED 8D 1A 21    STA $211A  [$7E:211A]  ;} Set mode 7 BG map to wrap within 128x128 tile area, no screen flip
$8B:83F0 85 5F       STA $5F    [$7E:005F]  ;/
$8B:83F2 A9 48       LDA #$48               ;\
$8B:83F4 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $4800, size = 32x32
$8B:83F6 8D 07 21    STA $2107  [$7E:2107]  ;/
$8B:83F9 A9 4C       LDA #$4C               ;\
$8B:83FB 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4C00, size = 32x32
$8B:83FD 8D 08 21    STA $2108  [$7E:2108]  ;/
$8B:8400 A9 24       LDA #$24               ;\
$8B:8402 85 5A       STA $5A    [$7E:005A]  ;} BG3 tilemap base address = $2400, size = 32x32
$8B:8404 8D 09 21    STA $2109  [$7E:2109]  ;/
$8B:8407 64 5C       STZ $5C    [$7E:005C]  ;\
$8B:8409 9C 0A 21    STZ $210A  [$7E:210A]  ;} BG4 tilemap base address = $0000, size = 32x32
$8B:840C A9 54       LDA #$54               ;\
$8B:840E 85 5D       STA $5D    [$7E:005D]  ;} BG1 tiles base address = $4000, BG2 tiles base address = $5000
$8B:8410 8D 0B 21    STA $210B  [$7E:210B]  ;/
$8B:8413 A9 02       LDA #$02               ;\
$8B:8415 85 5E       STA $5E    [$7E:005E]  ;} BG3 tiles base address = $2000, BG4 tiles base address = $0000
$8B:8417 8D 0C 21    STA $210C  [$7E:210C]  ;/
$8B:841A A9 01       LDA #$01               ;\
$8B:841C 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG1
$8B:841F 85 69       STA $69    [$7E:0069]  ;/
$8B:8421 9C 2D 21    STZ $212D  [$7E:212D]  ;\
$8B:8424 64 6B       STZ $6B    [$7E:006B]  ;} Disable all subscreen layers
$8B:8426 64 60       STZ $60    [$7E:0060]  ;\
$8B:8428 64 61       STZ $61    [$7E:0061]  ;} Disable all window masks
$8B:842A 64 62       STZ $62    [$7E:0062]  ;/
$8B:842C 64 6C       STZ $6C    [$7E:006C]  ;\
$8B:842E 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area
$8B:8430 64 6F       STZ $6F    [$7E:006F]  ;\
$8B:8432 64 72       STZ $72    [$7E:0072]  ;} Disable colour math
$8B:8434 A9 20       LDA #$20               ;\
$8B:8436 85 74       STA $74    [$7E:0074]  ;|
$8B:8438 A9 40       LDA #$40               ;|
$8B:843A 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:843C A9 80       LDA #$80               ;|
$8B:843E 85 76       STA $76    [$7E:0076]  ;/
$8B:8440 C2 30       REP #$30
$8B:8442 9C 90 05    STZ $0590  [$7E:0590]  ; OAM data index = 0
$8B:8445 A9 00 01    LDA #$0100             ;\
$8B:8448 8D 1B 21    STA $211B  [$7E:211B]  ;} Mode 7 transformation matrix parameter A = 100h
$8B:844B 85 78       STA $78    [$7E:0078]  ;/
$8B:844D 9C 1C 21    STZ $211C  [$7E:211C]  ;\
$8B:8450 64 7A       STZ $7A    [$7E:007A]  ;} Mode 7 transformation matrix parameter B = 0
$8B:8452 9C 1D 21    STZ $211D  [$7E:211D]  ;\
$8B:8455 64 7C       STZ $7C    [$7E:007C]  ;} Mode 7 transformation matrix parameter C = 0
$8B:8457 8D 1E 21    STA $211E  [$7E:211E]  ;\
$8B:845A 85 7E       STA $7E    [$7E:007E]  ;} Mode 7 transformation matrix parameter D = 100h
$8B:845C A9 80 00    LDA #$0080             ;\
$8B:845F 8D 1F 21    STA $211F  [$7E:211F]  ;} Mode 7 transformation origin co-ordinate X = 80h
$8B:8462 85 80       STA $80    [$7E:0080]  ;/
$8B:8464 8D 20 21    STA $2120  [$7E:2120]  ;\
$8B:8467 85 82       STA $82    [$7E:0082]  ;} Mode 7 transformation origin co-ordinate Y = 80h
$8B:8469 9C 8D 19    STZ $198D  [$7E:198D]  ; Mode 7 transformation angle = 0
$8B:846C A9 01 00    LDA #$0001             ;\
$8B:846F 8D 8F 19    STA $198F  [$7E:198F]  ;} Mode 7 transformation zoom level = 1
$8B:8472 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$8B:8474 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$8B:8476 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$8B:8478 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$8B:847A 9C 91 19    STZ $1991  [$7E:1991]  ;\
$8B:847D 9C 93 19    STZ $1993  [$7E:1993]  ;} Mode 7 X position = 0.0
$8B:8480 9C 95 19    STZ $1995  [$7E:1995]  ;\
$8B:8483 9C 97 19    STZ $1997  [$7E:1997]  ;} Mode 7 Y position = 0.0
$8B:8486 28          PLP
$8B:8487 60          RTS
}


;;; $8488: Unused. Modify mode 7 transformation with controller ;;;
{
$8B:8488 08          PHP
$8B:8489 C2 30       REP #$30
$8B:848B A5 8B       LDA $8B    [$7E:008B]  ;\
$8B:848D 89 00 02    BIT #$0200             ;} If pressing left:
$8B:8490 F0 0A       BEQ $0A    [$849C]     ;/
$8B:8492 AD 93 19    LDA $1993  [$7E:1993]  ;\
$8B:8495 18          CLC                    ;|
$8B:8496 69 02 00    ADC #$0002             ;} Mode 7 X position += 2
$8B:8499 8D 93 19    STA $1993  [$7E:1993]  ;/

$8B:849C A5 8B       LDA $8B    [$7E:008B]  ;\
$8B:849E 89 00 01    BIT #$0100             ;} If pressing right:
$8B:84A1 F0 0A       BEQ $0A    [$84AD]     ;/
$8B:84A3 AD 93 19    LDA $1993  [$7E:1993]  ;\
$8B:84A6 38          SEC                    ;|
$8B:84A7 E9 02 00    SBC #$0002             ;} Mode 7 X position -= 2
$8B:84AA 8D 93 19    STA $1993  [$7E:1993]  ;/

$8B:84AD A5 8B       LDA $8B    [$7E:008B]  ;\
$8B:84AF 89 00 08    BIT #$0800             ;} If pressing up:
$8B:84B2 F0 0A       BEQ $0A    [$84BE]     ;/
$8B:84B4 AD 97 19    LDA $1997  [$7E:1997]  ;\
$8B:84B7 18          CLC                    ;|
$8B:84B8 69 02 00    ADC #$0002             ;} Mode 7 Y position += 2
$8B:84BB 8D 97 19    STA $1997  [$7E:1997]  ;/

$8B:84BE A5 8B       LDA $8B    [$7E:008B]  ;\
$8B:84C0 89 00 04    BIT #$0400             ;} If pressing down:
$8B:84C3 F0 0A       BEQ $0A    [$84CF]     ;/
$8B:84C5 AD 97 19    LDA $1997  [$7E:1997]  ;\
$8B:84C8 38          SEC                    ;|
$8B:84C9 E9 02 00    SBC #$0002             ;} Mode 7 Y position -= 2
$8B:84CC 8D 97 19    STA $1997  [$7E:1997]  ;/

$8B:84CF A5 8B       LDA $8B    [$7E:008B]  ;\
$8B:84D1 89 10 00    BIT #$0010             ;} If not pressing R:
$8B:84D4 D0 11       BNE $11    [$84E7]     ;/
$8B:84D6 89 20 00    BIT #$0020             ;\
$8B:84D9 F0 16       BEQ $16    [$84F1]     ;} If pressing L:
$8B:84DB AD 8D 19    LDA $198D  [$7E:198D]  ;\
$8B:84DE 3A          DEC A                  ;|
$8B:84DF 29 FF 00    AND #$00FF             ;} Mode 7 transformation angle = ([mode 7 transformation angle] - 1) % 100h
$8B:84E2 8D 8D 19    STA $198D  [$7E:198D]  ;/
$8B:84E5 80 0A       BRA $0A    [$84F1]

$8B:84E7 AD 8D 19    LDA $198D  [$7E:198D]  ;\ Else (pressing R):
$8B:84EA 1A          INC A                  ;|
$8B:84EB 29 FF 00    AND #$00FF             ;} Mode 7 transformation angle = ([mode 7 transformation angle] + 1) % 100h
$8B:84EE 8D 8D 19    STA $198D  [$7E:198D]  ;/

$8B:84F1 A5 8B       LDA $8B    [$7E:008B]  ;\
$8B:84F3 89 00 80    BIT #$8000             ;} If pressing B: go to BRANCH_ZOOM_OUT
$8B:84F6 D0 07       BNE $07    [$84FF]     ;/
$8B:84F8 89 40 00    BIT #$0040             ;\
$8B:84FB D0 10       BNE $10    [$850D]     ;} If pressing X: go to BRANCH_ZOOM_IN
$8B:84FD 28          PLP
$8B:84FE 60          RTS                    ; Return

; BRANCH_ZOOM_OUT
$8B:84FF AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:8502 C9 00 70    CMP #$7000             ;|
$8B:8505 10 0F       BPL $0F    [$8516]     ;} Mode 7 transformation zoom level = min(7000h, [mode 7 transformation zoom level] + 1)
$8B:8507 1A          INC A                  ;|
$8B:8508 8D 8F 19    STA $198F  [$7E:198F]  ;/
$8B:850B 80 09       BRA $09    [$8516]     ; Return

; BRANCH_ZOOM_IN
$8B:850D AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:8510 F0 04       BEQ $04    [$8516]     ;|
$8B:8512 3A          DEC A                  ;} Mode 7 transformation zoom level = max(0, [mode 7 transformation zoom level] - 1)
$8B:8513 8D 8F 19    STA $198F  [$7E:198F]  ;/

$8B:8516 28          PLP
$8B:8517 60          RTS
}


;;; $8518: Handle mode 7 transformation matrix - no rotation ;;;
{
$8B:8518 08          PHP
$8B:8519 C2 30       REP #$30
$8B:851B AD 8F 19    LDA $198F  [$7E:198F]
$8B:851E 85 78       STA $78    [$7E:0078]
$8B:8520 85 7E       STA $7E    [$7E:007E]
$8B:8522 64 7A       STZ $7A    [$7E:007A]
$8B:8524 64 7C       STZ $7C    [$7E:007C]
$8B:8526 AD 93 19    LDA $1993  [$7E:1993]
$8B:8529 85 B1       STA $B1    [$7E:00B1]
$8B:852B AD 97 19    LDA $1997  [$7E:1997]
$8B:852E 85 B3       STA $B3    [$7E:00B3]
$8B:8530 28          PLP
$8B:8531 60          RTS
}


;;; $8532: Handle mode 7 transformation matrix ;;;
{
$8B:8532 08          PHP
$8B:8533 C2 30       REP #$30
$8B:8535 AD 8D 19    LDA $198D  [$7E:198D]  ;\
$8B:8538 18          CLC                    ;|
$8B:8539 69 40 00    ADC #$0040             ;|
$8B:853C 29 FF 00    AND #$00FF             ;|
$8B:853F 0A          ASL A                  ;} $26 = cos([mode 7 transformation angle] * pi / 80h) * 100h
$8B:8540 AA          TAX                    ;|
$8B:8541 BF 43 B4 A0 LDA $A0B443,x[$A0:B4C3];|
$8B:8545 85 26       STA $26    [$7E:0026]  ;/
$8B:8547 AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:854A 85 28       STA $28    [$7E:0028]  ;} $28 = [mode 7 transformation zoom level]
$8B:854C 20 8F 85    JSR $858F  [$8B:858F]  ; $2A.$2C = ±[$26] * ±[$28] / 10000h
$8B:854F E2 20       SEP #$20               ;\
$8B:8551 A5 2A       LDA $2A    [$7E:002A]  ;|
$8B:8553 EB          XBA                    ;|
$8B:8554 A5 2D       LDA $2D    [$7E:002D]  ;} Mode 7 transformation matrix parameter A/D = [$2A].[$2C] * 100h & FFFFh
$8B:8556 C2 20       REP #$20               ;|
$8B:8558 85 78       STA $78    [$7E:0078]  ;|
$8B:855A 85 7E       STA $7E    [$7E:007E]  ;/
$8B:855C AD 8D 19    LDA $198D  [$7E:198D]  ;\
$8B:855F 29 FF 00    AND #$00FF             ;|
$8B:8562 0A          ASL A                  ;|
$8B:8563 AA          TAX                    ;} $26 = sin([mode 7 transformation angle] * pi / 80h) * 100h
$8B:8564 BF 43 B4 A0 LDA $A0B443,x[$A0:B443];|
$8B:8568 85 26       STA $26    [$7E:0026]  ;/
$8B:856A AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:856D 85 28       STA $28    [$7E:0028]  ;} $28 = [mode 7 transformation zoom level]
$8B:856F 20 8F 85    JSR $858F  [$8B:858F]  ; $2A.$2C = ±[$26] * ±[$28] / 10000h
$8B:8572 E2 20       SEP #$20               ;\
$8B:8574 A5 2A       LDA $2A    [$7E:002A]  ;|
$8B:8576 EB          XBA                    ;|
$8B:8577 A5 2D       LDA $2D    [$7E:002D]  ;} Mode 7 transformation matrix parameter B = [$2A].[$2C] * 100h & FFFFh
$8B:8579 C2 20       REP #$20               ;|
$8B:857B 85 7A       STA $7A    [$7E:007A]  ;/
$8B:857D 49 FF FF    EOR #$FFFF             ;\
$8B:8580 1A          INC A                  ;} Mode 7 transformation matrix parameter C = -[mode 7 transformation matrix parameter B]
$8B:8581 85 7C       STA $7C    [$7E:007C]  ;/
$8B:8583 AD 93 19    LDA $1993  [$7E:1993]  ;\
$8B:8586 85 B1       STA $B1    [$7E:00B1]  ;} BG1 X scroll = [mode 7 X position]
$8B:8588 AD 97 19    LDA $1997  [$7E:1997]  ;\
$8B:858B 85 B3       STA $B3    [$7E:00B3]  ;} BG1 Y scroll = [mode 7 Y position]
$8B:858D 28          PLP
$8B:858E 60          RTS
}


;;; $858F: $2A.$2C = ±[$26] * ±[$28] / 10000h (16-bit signed multiplication) ;;;
{
$8B:858F 08          PHP
$8B:8590 C2 30       REP #$30
$8B:8592 A5 26       LDA $26    [$7E:0026]  ;\
$8B:8594 10 4F       BPL $4F    [$85E5]     ;} If [$26] >= 0: go to BRANCH_LEFT_POSITIVE
$8B:8596 49 FF FF    EOR #$FFFF             ;\
$8B:8599 1A          INC A                  ;} $26 = -[$26]
$8B:859A 85 26       STA $26    [$7E:0026]  ;/
$8B:859C A5 28       LDA $28    [$7E:0028]  ;\
$8B:859E 30 1A       BMI $1A    [$85BA]     ;} If [$28] >= 0:
$8B:85A0 20 EE 85    JSR $85EE  [$8B:85EE]  ; $2A.$2C = [$26] * [$28] / 10000h
$8B:85A3 A5 2C       LDA $2C    [$7E:002C]  ;\
$8B:85A5 49 FF FF    EOR #$FFFF             ;|
$8B:85A8 18          CLC                    ;|
$8B:85A9 69 01 00    ADC #$0001             ;|
$8B:85AC 85 2C       STA $2C    [$7E:002C]  ;} $2A.$2C = -[$2A].[$2C]
$8B:85AE A5 2A       LDA $2A    [$7E:002A]  ;|
$8B:85B0 49 FF FF    EOR #$FFFF             ;|
$8B:85B3 69 00 00    ADC #$0000             ;|
$8B:85B6 85 2A       STA $2A    [$7E:002A]  ;/
$8B:85B8 28          PLP
$8B:85B9 60          RTS                    ; Return

$8B:85BA 49 FF FF    EOR #$FFFF             ;\
$8B:85BD 1A          INC A                  ;} $28 = -[$28]
$8B:85BE 85 28       STA $28    [$7E:0028]  ;/
$8B:85C0 20 EE 85    JSR $85EE  [$8B:85EE]  ; $2A.$2C = [$26] * [$28] / 10000h
$8B:85C3 28          PLP
$8B:85C4 60          RTS                    ; Return

; BRANCH_LEFT_POSITIVE_RIGHT_NEGATIVE
$8B:85C5 49 FF FF    EOR #$FFFF             ;\
$8B:85C8 1A          INC A                  ;} $28 = -[$28]
$8B:85C9 85 28       STA $28    [$7E:0028]  ;/
$8B:85CB 20 EE 85    JSR $85EE  [$8B:85EE]  ; $2A.$2C = [$26] * [$28] / 10000h
$8B:85CE A5 2C       LDA $2C    [$7E:002C]  ;\
$8B:85D0 49 FF FF    EOR #$FFFF             ;|
$8B:85D3 18          CLC                    ;|
$8B:85D4 69 01 00    ADC #$0001             ;|
$8B:85D7 85 2C       STA $2C    [$7E:002C]  ;} $2A.$2C = -[$2A].[$2C]
$8B:85D9 A5 2A       LDA $2A    [$7E:002A]  ;|
$8B:85DB 49 FF FF    EOR #$FFFF             ;|
$8B:85DE 69 00 00    ADC #$0000             ;|
$8B:85E1 85 2A       STA $2A    [$7E:002A]  ;/
$8B:85E3 28          PLP
$8B:85E4 60          RTS                    ; Return

; BRANCH_LEFT_POSITIVE
$8B:85E5 A5 28       LDA $28    [$7E:0028]  ;\
$8B:85E7 30 DC       BMI $DC    [$85C5]     ;} If [$28] < 0: go to BRANCH_LEFT_POSITIVE_RIGHT_NEGATIVE
$8B:85E9 20 EE 85    JSR $85EE  [$8B:85EE]  ; $2A.$2C = [$26] * [$28] / 10000h
$8B:85EC 28          PLP
$8B:85ED 60          RTS
}


;;; $85EE: $2A.$2C = [$26] * [$28] / 10000h (16-bit unsigned multiplication) ;;;
{
; Exactly 1204/1232 master cycles (88%/90% of a scanline).

; Compared to $80:82D6, this routine is a bit slower (144/172 master cycles slower),
; but produces correct results in all cases

; Let:
;     $26 = a + b * 100h
;     $28 = c + d * 100h
$8B:85EE 08          PHP
$8B:85EF E2 30       SEP #$30
$8B:85F1 A5 26       LDA $26    [$7E:0026]  ;\
$8B:85F3 8D 02 42    STA $4202  [$7E:4202]  ;|
$8B:85F6 A5 28       LDA $28    [$7E:0028]  ;|
$8B:85F8 8D 03 42    STA $4203  [$7E:4203]  ;|
$8B:85FB EA          NOP                    ;|
$8B:85FC EA          NOP                    ;} $2C = ac
$8B:85FD EA          NOP                    ;|
$8B:85FE AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:8601 85 2C       STA $2C    [$7E:002C]  ;|
$8B:8603 AD 17 42    LDA $4217  [$7E:4217]  ;|
$8B:8606 85 2D       STA $2D    [$7E:002D]  ;/
$8B:8608 A5 27       LDA $27    [$7E:0027]  ;\
$8B:860A 8D 02 42    STA $4202  [$7E:4202]  ;|
$8B:860D A5 28       LDA $28    [$7E:0028]  ;|
$8B:860F 8D 03 42    STA $4203  [$7E:4203]  ;|
$8B:8612 EA          NOP                    ;|
$8B:8613 EA          NOP                    ;} $2E = bc
$8B:8614 EA          NOP                    ;|
$8B:8615 AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:8618 85 2E       STA $2E    [$7E:002E]  ;|
$8B:861A AD 17 42    LDA $4217  [$7E:4217]  ;|
$8B:861D 85 2F       STA $2F    [$7E:002F]  ;/
$8B:861F A5 26       LDA $26    [$7E:0026]  ;\
$8B:8621 8D 02 42    STA $4202  [$7E:4202]  ;|
$8B:8624 A5 29       LDA $29    [$7E:0029]  ;|
$8B:8626 8D 03 42    STA $4203  [$7E:4203]  ;|
$8B:8629 EA          NOP                    ;|
$8B:862A EA          NOP                    ;} $30 = ad
$8B:862B EA          NOP                    ;|
$8B:862C AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:862F 85 30       STA $30    [$7E:0030]  ;|
$8B:8631 AD 17 42    LDA $4217  [$7E:4217]  ;|
$8B:8634 85 31       STA $31    [$7E:0031]  ;/
$8B:8636 A5 27       LDA $27    [$7E:0027]  ;\
$8B:8638 8D 02 42    STA $4202  [$7E:4202]  ;|
$8B:863B A5 29       LDA $29    [$7E:0029]  ;|
$8B:863D 8D 03 42    STA $4203  [$7E:4203]  ;|
$8B:8640 EA          NOP                    ;|
$8B:8641 EA          NOP                    ;} $2A = bd
$8B:8642 EA          NOP                    ;|
$8B:8643 C2 20       REP #$20               ;|
$8B:8645 AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:8648 85 2A       STA $2A    [$7E:002A]  ;/
$8B:864A A5 2E       LDA $2E    [$7E:002E]  ;\
$8B:864C 18          CLC                    ;|
$8B:864D 65 30       ADC $30    [$7E:0030]  ;|
$8B:864F 85 2E       STA $2E    [$7E:002E]  ;|
$8B:8651 E2 20       SEP #$20               ;|
$8B:8653 A5 2E       LDA $2E    [$7E:002E]  ;|
$8B:8655 18          CLC                    ;|
$8B:8656 65 2D       ADC $2D    [$7E:002D]  ;} $2A.$2C += (bc + ad) / 100h
$8B:8658 85 2D       STA $2D    [$7E:002D]  ;|
$8B:865A A5 2F       LDA $2F    [$7E:002F]  ;|
$8B:865C 65 2A       ADC $2A    [$7E:002A]  ;|
$8B:865E 85 2A       STA $2A    [$7E:002A]  ;|
$8B:8660 90 02       BCC $02    [$8664]     ;|
$8B:8662 E6 2B       INC $2B    [$7E:002B]  ;/

$8B:8664 28          PLP
$8B:8665 60          RTS
}


;;; $8666: Handle fading in ;;;
{
$8B:8666 22 4D 89 80 JSL $80894D[$80:894D]
$8B:866A 60          RTS
}


;;; $866B:  ;;;
{
; Blue light effect for title sequence
$8B:866B 08          PHP
$8B:866C E2 20       SEP #$20
$8B:866E 64 6F       STZ $6F    [$7E:006F]  ; Disable subscreen layers
$8B:8670 A9 81       LDA #$81               ;\
$8B:8672 85 72       STA $72    [$7E:0072]  ;} Enable subtractive colour math on BG1
$8B:8674 A9 38       LDA #$38               ;\
$8B:8676 85 74       STA $74    [$7E:0074]  ;|
$8B:8678 A9 58       LDA #$58               ;|
$8B:867A 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (18h, 18h, 0) (yellow)
$8B:867C A9 80       LDA #$80               ;|
$8B:867E 85 76       STA $76    [$7E:0076]  ;/
$8B:8680 28          PLP
$8B:8681 60          RTS
}


;;; $8682:  ;;;
{
; Undoes $866B
$8B:8682 08          PHP
$8B:8683 E2 20       SEP #$20
$8B:8685 64 6F       STZ $6F    [$7E:006F]  ;\
$8B:8687 64 72       STZ $72    [$7E:0072]  ;} Disable colour math
$8B:8689 A9 20       LDA #$20               ;\
$8B:868B 85 74       STA $74    [$7E:0074]  ;|
$8B:868D A9 40       LDA #$40               ;|
$8B:868F 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:8691 A9 80       LDA #$80               ;|
$8B:8693 85 76       STA $76    [$7E:0076]  ;/
$8B:8695 28          PLP
$8B:8696 60          RTS
}


;;; $8697: Debug. Display version info ;;;
{
; Removing the RTS and the title screen shows:
;     'Ver.02.02.21.30  00' on NTSC
;     'Ver.03.30.10.00  00' on PAL

; Last byte there is the game header version number
; Also displays and 'S' if audio is disabled by $80:8008

$8B:8697 60          RTS

$8B:8698 08          PHP
$8B:8699 C2 30       REP #$30
$8B:869B AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$8B:869E A0 00 00    LDY #$0000             ; Y = 0

; LOOP_VERSION_STRING
$8B:86A1 B9 64 87    LDA $8764,y            ;\
$8B:86A4 29 FF 00    AND #$00FF             ;} OAM entry X position = 80h + [Y] * 8
$8B:86A7 9D 70 03    STA $0370,x            ;/
$8B:86AA A9 CC 00    LDA #$00CC             ;\
$8B:86AD 9D 71 03    STA $0371,x            ;} OAM entry Y position = CCh
$8B:86B0 5A          PHY
$8B:86B1 B9 54 F7    LDA $F754,y            ;\
$8B:86B4 29 FF 00    AND #$00FF             ;} A = [$F754 + [Y]]
$8B:86B7 F0 23       BEQ $23    [$86DC]     ; If [A] = 0: go to BRANCH_DONE
$8B:86B9 C9 2E 00    CMP #$002E             ;\
$8B:86BC F0 0E       BEQ $0E    [$86CC]     ;} If [A] != 2Eh:
$8B:86BE 38          SEC                    ;\
$8B:86BF E9 30 00    SBC #$0030             ;|
$8B:86C2 0A          ASL A                  ;|
$8B:86C3 A8          TAY                    ;} OAM entry tile number and attributes = [$8780 + [A] - 30h]
$8B:86C4 B9 80 87    LDA $8780,y            ;|
$8B:86C7 9D 72 03    STA $0372,x            ;/
$8B:86CA 80 06       BRA $06    [$86D2]

$8B:86CC A9 F3 39    LDA #$39F3             ;\ Else ([$F754 + [Y]] = 2Eh):
$8B:86CF 9D 72 03    STA $0372,x            ;} OAM entry tile number and attributes = 39F3h

$8B:86D2 7A          PLY
$8B:86D3 8A          TXA                    ;\
$8B:86D4 18          CLC                    ;|
$8B:86D5 69 04 00    ADC #$0004             ;} X += 4 (next OAM entry)
$8B:86D8 AA          TAX                    ;/
$8B:86D9 C8          INY                    ; Increment Y
$8B:86DA 80 C5       BRA $C5    [$86A1]     ; Go to LOOP_VERSION_STRING

; BRANCH_DONE
$8B:86DC 7A          PLY
$8B:86DD 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$8B:86E0 AF 08 80 80 LDA $808008[$80:8008]  ;\
$8B:86E4 F0 18       BEQ $18    [$86FE]     ;} If audio disabled:
$8B:86E6 A9 B4 00    LDA #$00B4             ;\
$8B:86E9 9D 70 03    STA $0370,x            ;} OAM entry X position = B4h
$8B:86EC A9 C4 00    LDA #$00C4             ;\
$8B:86EF 9D 71 03    STA $0371,x            ;} OAM entry Y position = C4h
$8B:86F2 A9 E2 39    LDA #$39E2             ;\
$8B:86F5 9D 72 03    STA $0372,x            ;} OAM entry tile number and attributes = 39E2h
$8B:86F8 8A          TXA                    ;\
$8B:86F9 18          CLC                    ;|
$8B:86FA 69 04 00    ADC #$0004             ;} X += 4 (next OAM entry)
$8B:86FD AA          TAX                    ;/

$8B:86FE AF DB FF 00 LDA $00FFDB[$00:FFDB]  ;\
$8B:8702 48          PHA                    ;|
$8B:8703 29 0F 00    AND #$000F             ;|
$8B:8706 0A          ASL A                  ;} $12 = ([version number] & Fh) * 2
$8B:8707 85 12       STA $12    [$7E:0012]  ;|
$8B:8709 68          PLA                    ;/
$8B:870A 29 F0 00    AND #$00F0             ;\
$8B:870D 4A          LSR A                  ;|
$8B:870E 4A          LSR A                  ;} Y = ([version number] >> 4) * 2
$8B:870F 4A          LSR A                  ;|
$8B:8710 A8          TAY                    ;/
$8B:8711 A9 E8 00    LDA #$00E8             ;\
$8B:8714 9D 70 03    STA $0370,x            ;} OAM entry X position = E8h
$8B:8717 A9 CC 00    LDA #$00CC             ;\
$8B:871A 9D 71 03    STA $0371,x            ;} OAM entry Y position = CCh
$8B:871D B9 80 87    LDA $8780,y            ;\
$8B:8720 9D 72 03    STA $0372,x            ;} OAM entry tile number and attributes = [$8780 + [Y]]
$8B:8723 A9 F0 00    LDA #$00F0             ;\
$8B:8726 9D 74 03    STA $0374,x            ;} OAM entry ([X] + 1) X position = F0h
$8B:8729 A9 CC 00    LDA #$00CC             ;\
$8B:872C 9D 75 03    STA $0375,x            ;} OAM entry ([X] + 1) Y position = CCh
$8B:872F A4 12       LDY $12    [$7E:0012]  ;\
$8B:8731 B9 80 87    LDA $8780,y            ;} OAM entry ([X] + 1) tile number and attributes = [$8780 + [$12]]
$8B:8734 9D 76 03    STA $0376,x            ;/
$8B:8737 8A          TXA                    ;\
$8B:8738 18          CLC                    ;|
$8B:8739 69 08 00    ADC #$0008             ;} X += 8 (+2 OAM entries)
$8B:873C AA          TAX                    ;/
$8B:873D A0 00 00    LDY #$0000             ; Y = 0

; LOOP_VER
$8B:8740 B9 74 87    LDA $8774,y            ;\
$8B:8743 9D 70 03    STA $0370,x            ;} OAM entry X position = 74h - [Y] * 4
$8B:8746 A9 CC 00    LDA #$00CC             ;\
$8B:8749 9D 71 03    STA $0371,x            ;} OAM entry Y position = CCh
$8B:874C B9 7A 87    LDA $877A,y            ;\
$8B:874F 9D 72 03    STA $0372,x            ;} OAM entry tile number and attributes = [$877A + [Y]]
$8B:8752 8A          TXA                    ;\
$8B:8753 18          CLC                    ;|
$8B:8754 69 04 00    ADC #$0004             ;} X += 4 (next OAM entry)
$8B:8757 AA          TAX                    ;/
$8B:8758 C8          INY                    ;\
$8B:8759 C8          INY                    ;} Y += 2
$8B:875A C0 06 00    CPY #$0006             ;\
$8B:875D 30 E1       BMI $E1    [$8740]     ;} If [Y] < 6: go to LOOP_VER
$8B:875F 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$8B:8762 28          PLP
$8B:8763 60          RTS

; Version string OAM entry X positions
$8B:8764             db 80, 88, 90, 98, A0, A8, B0, B8, C0, C8, D0, D8, E0, E8, F0, F8

; 'Ver.' OAM entry X positions
$8B:8774             dw 0074, 006C, 0064

; 'Ver.' OAM entry tile numbers and attributes
$8B:877A             dw 31F2, 31F1, 31F0

; Version string ('0123456789ABCDEF') OAM entry tile numbers and attributes
$8B:8780             dw 39F4, 39F5, 39F6, 39F7, 39F8, 39F9, 39FA, 39FB, 39FC, 39FD, 39D0, 39D1, 39D2, 39D3, 39D4, 39D5
}


;;; $87A0: Update cinematic BG tilemap ;;;
{
; If not mode 7:
;     Queue DMA of 780h bytes from $7E:3000 to VRAM [$19F5]
$8B:87A0 08          PHP
$8B:87A1 C2 30       REP #$30
$8B:87A3 A5 55       LDA $55    [$7E:0055]
$8B:87A5 29 FF 00    AND #$00FF
$8B:87A8 C9 07 00    CMP #$0007
$8B:87AB F0 24       BEQ $24    [$87D1]
$8B:87AD AE 30 03    LDX $0330  [$7E:0330]
$8B:87B0 A9 80 07    LDA #$0780
$8B:87B3 95 D0       STA $D0,x  [$7E:00D0]
$8B:87B5 E8          INX
$8B:87B6 E8          INX
$8B:87B7 A9 00 30    LDA #$3000
$8B:87BA 95 D0       STA $D0,x  [$7E:00D2]
$8B:87BC E8          INX
$8B:87BD E8          INX
$8B:87BE E2 20       SEP #$20
$8B:87C0 A9 7E       LDA #$7E
$8B:87C2 95 D0       STA $D0,x  [$7E:00D4]
$8B:87C4 C2 20       REP #$20
$8B:87C6 E8          INX
$8B:87C7 AD F5 19    LDA $19F5  [$7E:19F5]
$8B:87CA 95 D0       STA $D0,x  [$7E:00D5]
$8B:87CC E8          INX
$8B:87CD E8          INX
$8B:87CE 8E 30 03    STX $0330  [$7E:0330]

$8B:87D1 28          PLP
$8B:87D2 60          RTS
}


;;; $87D3: Update Samus eyes tilemap ;;;
{
; If not mode 7:
;     Queue DMA for VRAM $49A0..DF = [$7E:3B40..BF] (BG2 tilemap rows Dh/Eh)
$8B:87D3 08          PHP
$8B:87D4 C2 30       REP #$30
$8B:87D6 A5 55       LDA $55    [$7E:0055]
$8B:87D8 29 FF 00    AND #$00FF
$8B:87DB C9 07 00    CMP #$0007
$8B:87DE F0 24       BEQ $24    [$8804]
$8B:87E0 AE 30 03    LDX $0330  [$7E:0330]
$8B:87E3 A9 80 00    LDA #$0080
$8B:87E6 95 D0       STA $D0,x  [$7E:00D7]
$8B:87E8 E8          INX
$8B:87E9 E8          INX
$8B:87EA A9 40 3B    LDA #$3B40
$8B:87ED 95 D0       STA $D0,x  [$7E:00D9]
$8B:87EF E8          INX
$8B:87F0 E8          INX
$8B:87F1 E2 20       SEP #$20
$8B:87F3 A9 7E       LDA #$7E
$8B:87F5 95 D0       STA $D0,x  [$7E:00DB]
$8B:87F7 C2 20       REP #$20
$8B:87F9 E8          INX
$8B:87FA A9 A0 49    LDA #$49A0
$8B:87FD 95 D0       STA $D0,x  [$7E:00DC]
$8B:87FF E8          INX
$8B:8800 E8          INX
$8B:8801 8E 30 03    STX $0330  [$7E:0330]

$8B:8804 28          PLP
$8B:8805 60          RTS
}


;;; $8806:  ;;;
{
; If not mode 7:
;     Queue DMA of 800h bytes from $7E:3000 to VRAM [$19F5]
$8B:8806 08          PHP
$8B:8807 C2 30       REP #$30
$8B:8809 A5 55       LDA $55    [$7E:0055]
$8B:880B 29 FF 00    AND #$00FF
$8B:880E C9 07 00    CMP #$0007
$8B:8811 F0 24       BEQ $24    [$8837]
$8B:8813 AE 30 03    LDX $0330  [$7E:0330]
$8B:8816 A9 00 08    LDA #$0800
$8B:8819 95 D0       STA $D0,x  [$7E:00D0]
$8B:881B E8          INX
$8B:881C E8          INX
$8B:881D A9 00 30    LDA #$3000
$8B:8820 95 D0       STA $D0,x  [$7E:00D2]
$8B:8822 E8          INX
$8B:8823 E8          INX
$8B:8824 E2 20       SEP #$20
$8B:8826 A9 7E       LDA #$7E
$8B:8828 95 D0       STA $D0,x  [$7E:00D4]
$8B:882A C2 20       REP #$20
$8B:882C E8          INX
$8B:882D AD F5 19    LDA $19F5  [$7E:19F5]
$8B:8830 95 D0       STA $D0,x  [$7E:00D5]
$8B:8832 E8          INX
$8B:8833 E8          INX
$8B:8834 8E 30 03    STX $0330  [$7E:0330]

$8B:8837 28          PLP
$8B:8838 60          RTS
}


;;; $8839: Process cinematic BG object indirect instruction ;;;
{
$8B:8839 08          PHP
$8B:883A C2 30       REP #$30
$8B:883C DA          PHX
$8B:883D 5A          PHY
$8B:883E BC B5 19    LDY $19B5,x[$7E:19BB]  ; Y = [cinematic BG object indirect instruction pointer]
$8B:8841 B9 00 00    LDA $0000,y[$8C:D781]  ;\
$8B:8844 85 1C       STA $1C    [$7E:001C]  ;} Go to [[Y]]
$8B:8846 6C 1C 00    JMP ($001C)[$8B:88FD]  ;/
}


;;; $8849: Indirect instruction function - nothing ;;;
{
; Used by dummy instruction used for delay
$8B:8849 7A          PLY
$8B:884A FA          PLX
$8B:884B 28          PLP
$8B:884C 60          RTS
}


;;; $884D: Indirect instruction function - draw text character [[Y] + 4] ;;;
{
; Only one tile can be specified
; Draws character, updates caret position (based on next instruction) and plays intro text click
$8B:884D AD A1 1B    LDA $1BA1  [$7E:1BA1]  ;\
$8B:8850 D0 08       BNE $08    [$885A]     ;|
$8B:8852 A9 01 00    LDA #$0001             ;|
$8B:8855 8D A1 1B    STA $1BA1  [$7E:1BA1]  ;} Toggle intro text click flag
$8B:8858 80 03       BRA $03    [$885D]     ;|
                                            ;|
$8B:885A 9C A1 1B    STZ $1BA1  [$7E:1BA1]  ;/

$8B:885D 20 F7 97    JSR $97F7  [$8B:97F7]  ; Spawn text glow object
$8B:8860 5A          PHY
$8B:8861 BC CD 19    LDY $19CD,x[$7E:19D1]  ; Y = [cinematic BG object instruction list pointer]
$8B:8864 A2 1E 00    LDX #$001E             ; X = 1Eh
$8B:8867 B9 06 00    LDA $0006,y[$8C:C391]  ;\
$8B:886A 30 1E       BMI $1E    [$888A]     ;} If [[Y] + 6] & 8000h = 0:
$8B:886C B9 08 00    LDA $0008,y[$8C:C393]  ;\
$8B:886F 29 FF 00    AND #$00FF             ;|
$8B:8872 0A          ASL A                  ;|
$8B:8873 0A          ASL A                  ;} Cinematic sprite object 1Eh X position = [[Y] + 8] * 8
$8B:8874 0A          ASL A                  ;|
$8B:8875 9D 7D 1A    STA $1A7D,x[$7E:1A9B]  ;/
$8B:8878 B9 09 00    LDA $0009,y[$8C:C394]  ;\
$8B:887B 29 FF 00    AND #$00FF             ;|
$8B:887E 0A          ASL A                  ;|
$8B:887F 0A          ASL A                  ;|
$8B:8880 0A          ASL A                  ;} Cinematic sprite object 1Eh Y position = ([[Y] + 9] - 1) * 8
$8B:8881 38          SEC                    ;|
$8B:8882 E9 08 00    SBC #$0008             ;|
$8B:8885 9D 9D 1A    STA $1A9D,x[$7E:1ABB]  ;/
$8B:8888 80 18       BRA $18    [$88A2]

$8B:888A A9 08 00    LDA #$0008             ;\ Else ([[Y] + 6] & 8000h != 0):
$8B:888D 9D 7D 1A    STA $1A7D,x[$7E:1A9B]  ;} Cinematic sprite object 1Eh X position = 8
$8B:8890 B9 03 00    LDA $0003,y[$8C:C790]  ;\
$8B:8893 29 FF 00    AND #$00FF             ;|
$8B:8896 1A          INC A                  ;|
$8B:8897 1A          INC A                  ;|
$8B:8898 0A          ASL A                  ;|
$8B:8899 0A          ASL A                  ;} Cinematic sprite object 1Eh Y position = ([[Y] + 3] + 2) * 8
$8B:889A 0A          ASL A                  ;|
$8B:889B 38          SEC                    ;|
$8B:889C E9 08 00    SBC #$0008             ;|
$8B:889F 9D 9D 1A    STA $1A9D,x[$7E:1ABB]  ;/

$8B:88A2 B9 04 00    LDA $0004,y[$8C:C38F]  ;\
$8B:88A5 C9 7D D6    CMP #$D67D             ;} If [[Y] + 4] = $D67D (" "): return
$8B:88A8 F0 0C       BEQ $0C    [$88B6]     ;/
$8B:88AA AD A1 1B    LDA $1BA1  [$7E:1BA1]  ;\
$8B:88AD F0 07       BEQ $07    [$88B6]     ;} If [intro text click flag] = 0: return
$8B:88AF A9 0D 00    LDA #$000D             ;\
$8B:88B2 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound Dh, sound library 3, max queued sounds allowed = 6 (typewriter stroke - intro)

$8B:88B6 7A          PLY
}


;;; $88B7: Indirect instruction function - draw the [[Y] + 3] x [[Y] + 2] region with tilemap values at [Y] + 4 to text tilemap ;;;
{
; Used for space colony label in intro and in the ending sequence
$8B:88B7 20 43 89    JSR $8943  [$8B:8943]  ; X = $16 = tilemap offset for tile ([$12], [$13])
$8B:88BA B9 02 00    LDA $0002,y[$8C:D6B7]  ;\
$8B:88BD 29 FF 00    AND #$00FF             ;|
$8B:88C0 8D 12 00    STA $0012  [$7E:0012]  ;} $12 = [[Y] + 2]
$8B:88C3 8D 18 00    STA $0018  [$7E:0018]  ; $18 = [$12] (columns)
$8B:88C6 B9 03 00    LDA $0003,y[$8C:D6B8]  ;\
$8B:88C9 29 FF 00    AND #$00FF             ;} $14 = [[Y] + 3] (rows)
$8B:88CC 8D 14 00    STA $0014  [$7E:0014]  ;/

; LOOP
$8B:88CF B9 04 00    LDA $0004,y[$8C:D6B9]  ;\
$8B:88D2 9F 00 30 7E STA $7E3000,x[$7E:3102];|
$8B:88D6 C8          INY                    ;|
$8B:88D7 C8          INY                    ;|
$8B:88D8 E8          INX                    ;} Copy [$12] * 2 bytes from [Y] + 4 to $7E:3000 + [X]
$8B:88D9 E8          INX                    ;} Y += [$12] * 2
$8B:88DA CE 12 00    DEC $0012  [$7E:0012]  ;|
$8B:88DD F0 02       BEQ $02    [$88E1]     ;|
$8B:88DF 80 EE       BRA $EE    [$88CF]     ;/

$8B:88E1 AD 18 00    LDA $0018  [$7E:0018]  ;\
$8B:88E4 8D 12 00    STA $0012  [$7E:0012]  ;} $12 = [$18]
$8B:88E7 CE 14 00    DEC $0014  [$7E:0014]  ; Decrement $14
$8B:88EA F0 0D       BEQ $0D    [$88F9]     ; If [$14] != 0:
$8B:88EC AD 16 00    LDA $0016  [$7E:0016]  ;\
$8B:88EF 18          CLC                    ;|
$8B:88F0 69 40 00    ADC #$0040             ;} X = $16 += 40h
$8B:88F3 8D 16 00    STA $0016  [$7E:0016]  ;|
$8B:88F6 AA          TAX                    ;/
$8B:88F7 80 D6       BRA $D6    [$88CF]     ; Go to LOOP

$8B:88F9 7A          PLY
$8B:88FA FA          PLX
$8B:88FB 28          PLP
$8B:88FC 60          RTS
}


;;; $88FD: Indirect instruction function - draw the [[Y] + 3] x [[Y] + 2] region with tilemap values at [Y] + 4 to BG2 ;;;
{
; Used for Samus eyes during the intro
$8B:88FD 20 43 89    JSR $8943  [$8B:8943]  ; X = $16 = tilemap offset for tile ([$12], [$13])
$8B:8900 B9 02 00    LDA $0002,y[$8C:D783]  ;\
$8B:8903 29 FF 00    AND #$00FF             ;|
$8B:8906 8D 12 00    STA $0012  [$7E:0012]  ;} $12 = [[Y] + 2]
$8B:8909 8D 18 00    STA $0018  [$7E:0018]  ; $18 = [$12] (columns)
$8B:890C B9 03 00    LDA $0003,y[$8C:D784]  ;\
$8B:890F 29 FF 00    AND #$00FF             ;} $14 = [[Y] + 3] (rows)
$8B:8912 8D 14 00    STA $0014  [$7E:0014]  ;/

; LOOP
$8B:8915 B9 04 00    LDA $0004,y[$8C:D785]  ;\
$8B:8918 9F 00 38 7E STA $7E3800,x[$7E:3B62];|
$8B:891C C8          INY                    ;|
$8B:891D C8          INY                    ;|
$8B:891E E8          INX                    ;} Copy [$12] * 2 bytes from [Y] + 4 to $7E:3800 + [X]
$8B:891F E8          INX                    ;} Y += [$12] * 2
$8B:8920 CE 12 00    DEC $0012  [$7E:0012]  ;|
$8B:8923 F0 02       BEQ $02    [$8927]     ;|
$8B:8925 80 EE       BRA $EE    [$8915]     ;/

$8B:8927 AD 18 00    LDA $0018  [$7E:0018]  ;\
$8B:892A 8D 12 00    STA $0012  [$7E:0012]  ;} $12 = [$18]
$8B:892D CE 14 00    DEC $0014  [$7E:0014]  ; Decrement $14
$8B:8930 F0 0D       BEQ $0D    [$893F]     ; If [$14] != 0:
$8B:8932 AD 16 00    LDA $0016  [$7E:0016]  ;\
$8B:8935 18          CLC                    ;|
$8B:8936 69 40 00    ADC #$0040             ;} X = $16 += 40h
$8B:8939 8D 16 00    STA $0016  [$7E:0016]  ;|
$8B:893C AA          TAX                    ;/
$8B:893D 80 D6       BRA $D6    [$8915]     ; Go to LOOP

$8B:893F 7A          PLY
$8B:8940 FA          PLX
$8B:8941 28          PLP
$8B:8942 60          RTS
}


;;; $8943: X = $16 = tilemap offset for tile ([$12], [$13]) ;;;
{
; X = $16 = ([$13] * 20h + [$12]) * 2
$8B:8943 AD 12 00    LDA $0012  [$7E:0012]
$8B:8946 29 FF 00    AND #$00FF
$8B:8949 0A          ASL A
$8B:894A 8D 14 00    STA $0014  [$7E:0014]
$8B:894D E2 20       SEP #$20
$8B:894F A9 40       LDA #$40
$8B:8951 8D 02 42    STA $4202  [$7E:4202]
$8B:8954 AD 13 00    LDA $0013  [$7E:0013]
$8B:8957 8D 03 42    STA $4203  [$7E:4203]
$8B:895A EA          NOP
$8B:895B EA          NOP
$8B:895C EA          NOP
$8B:895D C2 20       REP #$20
$8B:895F AD 16 42    LDA $4216  [$7E:4216]
$8B:8962 18          CLC
$8B:8963 6D 14 00    ADC $0014  [$7E:0014]
$8B:8966 8D 16 00    STA $0016  [$7E:0016]
$8B:8969 AA          TAX
$8B:896A 60          RTS
}


;;; $896B:  ;;;
{
$8B:896B 20 2C 8A    JSR $8A2C  [$8B:8A2C]
$8B:896E B9 02 00    LDA $0002,y
$8B:8971 29 FF 00    AND #$00FF
$8B:8974 8D 12 00    STA $0012  [$7E:0012]
$8B:8977 B9 03 00    LDA $0003,y
$8B:897A 29 FF 00    AND #$00FF
$8B:897D 8D 14 00    STA $0014  [$7E:0014]
$8B:8980 98          TYA
$8B:8981 18          CLC
$8B:8982 69 04 00    ADC #$0004
$8B:8985 A8          TAY
$8B:8986 AE 34 03    LDX $0334  [$7E:0334]

$8B:8989 A9 80 00    LDA #$0080
$8B:898C 9D D0 02    STA $02D0,x
$8B:898F 98          TYA
$8B:8990 9D D1 02    STA $02D1,x
$8B:8993 A9 8B 00    LDA #$008B
$8B:8996 9D D3 02    STA $02D3,x
$8B:8999 AD 12 00    LDA $0012  [$7E:0012]
$8B:899C 9D D4 02    STA $02D4,x
$8B:899F AD 16 00    LDA $0016  [$7E:0016]
$8B:89A2 9D D6 02    STA $02D6,x
$8B:89A5 A9 00 00    LDA #$0000
$8B:89A8 9D D8 02    STA $02D8,x
$8B:89AB 8A          TXA
$8B:89AC 18          CLC
$8B:89AD 69 09 00    ADC #$0009
$8B:89B0 AA          TAX
$8B:89B1 98          TYA
$8B:89B2 18          CLC
$8B:89B3 6D 12 00    ADC $0012  [$7E:0012]
$8B:89B6 A8          TAY
$8B:89B7 AD 16 00    LDA $0016  [$7E:0016]
$8B:89BA 18          CLC
$8B:89BB 69 80 00    ADC #$0080
$8B:89BE 8D 16 00    STA $0016  [$7E:0016]
$8B:89C1 CE 14 00    DEC $0014  [$7E:0014]
$8B:89C4 F0 02       BEQ $02    [$89C8]
$8B:89C6 80 C1       BRA $C1    [$8989]

$8B:89C8 8E 34 03    STX $0334  [$7E:0334]
$8B:89CB 7A          PLY
$8B:89CC FA          PLX
$8B:89CD 28          PLP
$8B:89CE 60          RTS
}


;;; $89CF:  ;;;
{
$8B:89CF 20 2C 8A    JSR $8A2C  [$8B:8A2C]
$8B:89D2 B9 02 00    LDA $0002,y
$8B:89D5 29 FF 00    AND #$00FF
$8B:89D8 8D 12 00    STA $0012  [$7E:0012]
$8B:89DB B9 03 00    LDA $0003,y
$8B:89DE 29 FF 00    AND #$00FF
$8B:89E1 8D 14 00    STA $0014  [$7E:0014]
$8B:89E4 98          TYA
$8B:89E5 18          CLC
$8B:89E6 69 04 00    ADC #$0004
$8B:89E9 A8          TAY
$8B:89EA AE 34 03    LDX $0334  [$7E:0334]

$8B:89ED A9 80 00    LDA #$0080
$8B:89F0 9D D0 02    STA $02D0,x
$8B:89F3 98          TYA
$8B:89F4 9D D1 02    STA $02D1,x
$8B:89F7 A9 8B 00    LDA #$008B
$8B:89FA 9D D3 02    STA $02D3,x
$8B:89FD AD 14 00    LDA $0014  [$7E:0014]
$8B:8A00 9D D4 02    STA $02D4,x
$8B:8A03 AD 16 00    LDA $0016  [$7E:0016]
$8B:8A06 9D D6 02    STA $02D6,x
$8B:8A09 A9 02 00    LDA #$0002
$8B:8A0C 9D D8 02    STA $02D8,x
$8B:8A0F 8A          TXA
$8B:8A10 18          CLC
$8B:8A11 69 09 00    ADC #$0009
$8B:8A14 AA          TAX
$8B:8A15 98          TYA
$8B:8A16 18          CLC
$8B:8A17 6D 14 00    ADC $0014  [$7E:0014]
$8B:8A1A A8          TAY
$8B:8A1B EE 16 00    INC $0016  [$7E:0016]
$8B:8A1E CE 12 00    DEC $0012  [$7E:0012]
$8B:8A21 F0 02       BEQ $02    [$8A25]
$8B:8A23 80 C8       BRA $C8    [$89ED]

$8B:8A25 8E 34 03    STX $0334  [$7E:0334]
$8B:8A28 7A          PLY
$8B:8A29 FA          PLX
$8B:8A2A 28          PLP
$8B:8A2B 60          RTS
}


;;; $8A2C:  ;;;
{
; Presumably mode 7 tilemap offset calculation
; $16 = [$13] * 80h + [$12]
$8B:8A2C AD 12 00    LDA $0012  [$7E:0012]
$8B:8A2F 29 FF 00    AND #$00FF
$8B:8A32 8D 14 00    STA $0014  [$7E:0014]
$8B:8A35 E2 20       SEP #$20
$8B:8A37 A9 80       LDA #$80
$8B:8A39 8D 02 42    STA $4202  [$7E:4202]
$8B:8A3C AD 13 00    LDA $0013  [$7E:0013]
$8B:8A3F 8D 03 42    STA $4203  [$7E:4203]
$8B:8A42 EA          NOP
$8B:8A43 EA          NOP
$8B:8A44 EA          NOP
$8B:8A45 C2 20       REP #$20
$8B:8A47 AD 16 42    LDA $4216  [$7E:4216]
$8B:8A4A 18          CLC
$8B:8A4B 6D 14 00    ADC $0014  [$7E:0014]
$8B:8A4E 8D 16 00    STA $0016  [$7E:0016]
$8B:8A51 60          RTS
}


;;; $8A52: Calculate position of Samus in rotating elevator room ;;;
{
$8B:8A52 08          PHP
$8B:8A53 8B          PHB
$8B:8A54 4B          PHK
$8B:8A55 AB          PLB
$8B:8A56 C2 30       REP #$30
$8B:8A58 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$8B:8A5B 38          SEC
$8B:8A5C E5 80       SBC $80    [$7E:0080]
$8B:8A5E 85 22       STA $22    [$7E:0022]
$8B:8A60 A5 82       LDA $82    [$7E:0082]
$8B:8A62 38          SEC
$8B:8A63 ED FA 0A    SBC $0AFA  [$7E:0AFA]
$8B:8A66 85 24       STA $24    [$7E:0024]
$8B:8A68 A5 22       LDA $22    [$7E:0022]
$8B:8A6A 85 26       STA $26    [$7E:0026]
$8B:8A6C A5 78       LDA $78    [$7E:0078]
$8B:8A6E 85 28       STA $28    [$7E:0028]
$8B:8A70 20 8F 85    JSR $858F  [$8B:858F]
$8B:8A73 E2 20       SEP #$20
$8B:8A75 A5 2A       LDA $2A    [$7E:002A]
$8B:8A77 EB          XBA
$8B:8A78 A5 2D       LDA $2D    [$7E:002D]
$8B:8A7A C2 20       REP #$20
$8B:8A7C 85 1A       STA $1A    [$7E:001A]
$8B:8A7E A5 7A       LDA $7A    [$7E:007A]
$8B:8A80 85 26       STA $26    [$7E:0026]
$8B:8A82 A5 24       LDA $24    [$7E:0024]
$8B:8A84 85 28       STA $28    [$7E:0028]
$8B:8A86 20 8F 85    JSR $858F  [$8B:858F]
$8B:8A89 E2 20       SEP #$20
$8B:8A8B A5 2A       LDA $2A    [$7E:002A]
$8B:8A8D EB          XBA
$8B:8A8E A5 2D       LDA $2D    [$7E:002D]
$8B:8A90 C2 20       REP #$20
$8B:8A92 18          CLC
$8B:8A93 65 1A       ADC $1A    [$7E:001A]
$8B:8A95 85 1A       STA $1A    [$7E:001A]
$8B:8A97 A5 80       LDA $80    [$7E:0080]
$8B:8A99 18          CLC
$8B:8A9A 65 1A       ADC $1A    [$7E:001A]
$8B:8A9C 8D F6 0A    STA $0AF6  [$7E:0AF6]
$8B:8A9F A5 7C       LDA $7C    [$7E:007C]
$8B:8AA1 85 26       STA $26    [$7E:0026]
$8B:8AA3 A5 22       LDA $22    [$7E:0022]
$8B:8AA5 85 28       STA $28    [$7E:0028]
$8B:8AA7 20 8F 85    JSR $858F  [$8B:858F]
$8B:8AAA E2 20       SEP #$20
$8B:8AAC A5 2A       LDA $2A    [$7E:002A]
$8B:8AAE EB          XBA
$8B:8AAF A5 2D       LDA $2D    [$7E:002D]
$8B:8AB1 C2 20       REP #$20
$8B:8AB3 85 1A       STA $1A    [$7E:001A]
$8B:8AB5 A5 78       LDA $78    [$7E:0078]
$8B:8AB7 85 26       STA $26    [$7E:0026]
$8B:8AB9 A5 24       LDA $24    [$7E:0024]
$8B:8ABB 85 28       STA $28    [$7E:0028]
$8B:8ABD 20 8F 85    JSR $858F  [$8B:858F]
$8B:8AC0 E2 20       SEP #$20
$8B:8AC2 A5 2A       LDA $2A    [$7E:002A]
$8B:8AC4 EB          XBA
$8B:8AC5 A5 2D       LDA $2D    [$7E:002D]
$8B:8AC7 C2 20       REP #$20
$8B:8AC9 18          CLC
$8B:8ACA 65 1A       ADC $1A    [$7E:001A]
$8B:8ACC 85 1A       STA $1A    [$7E:001A]
$8B:8ACE A5 82       LDA $82    [$7E:0082]
$8B:8AD0 38          SEC
$8B:8AD1 E5 1A       SBC $1A    [$7E:001A]
$8B:8AD3 8D FA 0A    STA $0AFA  [$7E:0AFA]
$8B:8AD6 AB          PLB
$8B:8AD7 28          PLP
$8B:8AD8 6B          RTL
}


;;; $8AD9: Calculate position of projectile explosion in rotating elevator room ;;;
{
$8B:8AD9 08          PHP
$8B:8ADA 8B          PHB
$8B:8ADB 4B          PHK
$8B:8ADC AB          PLB
$8B:8ADD C2 30       REP #$30
$8B:8ADF BD 64 0B    LDA $0B64,x
$8B:8AE2 38          SEC
$8B:8AE3 E5 80       SBC $80    [$7E:0080]
$8B:8AE5 85 22       STA $22    [$7E:0022]
$8B:8AE7 A5 82       LDA $82    [$7E:0082]
$8B:8AE9 38          SEC
$8B:8AEA FD 78 0B    SBC $0B78,x
$8B:8AED 85 24       STA $24    [$7E:0024]
$8B:8AEF A5 22       LDA $22    [$7E:0022]
$8B:8AF1 85 26       STA $26    [$7E:0026]
$8B:8AF3 A5 78       LDA $78    [$7E:0078]
$8B:8AF5 85 28       STA $28    [$7E:0028]
$8B:8AF7 20 8F 85    JSR $858F  [$8B:858F]
$8B:8AFA E2 20       SEP #$20
$8B:8AFC A5 2A       LDA $2A    [$7E:002A]
$8B:8AFE EB          XBA
$8B:8AFF A5 2D       LDA $2D    [$7E:002D]
$8B:8B01 C2 20       REP #$20
$8B:8B03 85 1A       STA $1A    [$7E:001A]
$8B:8B05 A5 7A       LDA $7A    [$7E:007A]
$8B:8B07 85 26       STA $26    [$7E:0026]
$8B:8B09 A5 24       LDA $24    [$7E:0024]
$8B:8B0B 85 28       STA $28    [$7E:0028]
$8B:8B0D 20 8F 85    JSR $858F  [$8B:858F]
$8B:8B10 E2 20       SEP #$20
$8B:8B12 A5 2A       LDA $2A    [$7E:002A]
$8B:8B14 EB          XBA
$8B:8B15 A5 2D       LDA $2D    [$7E:002D]
$8B:8B17 C2 20       REP #$20
$8B:8B19 18          CLC
$8B:8B1A 65 1A       ADC $1A    [$7E:001A]
$8B:8B1C 85 1A       STA $1A    [$7E:001A]
$8B:8B1E A5 80       LDA $80    [$7E:0080]
$8B:8B20 18          CLC
$8B:8B21 65 1A       ADC $1A    [$7E:001A]
$8B:8B23 38          SEC
$8B:8B24 ED 11 09    SBC $0911  [$7E:0911]
$8B:8B27 85 14       STA $14    [$7E:0014]
$8B:8B29 A5 7C       LDA $7C    [$7E:007C]
$8B:8B2B 85 26       STA $26    [$7E:0026]
$8B:8B2D A5 22       LDA $22    [$7E:0022]
$8B:8B2F 85 28       STA $28    [$7E:0028]
$8B:8B31 20 8F 85    JSR $858F  [$8B:858F]
$8B:8B34 E2 20       SEP #$20
$8B:8B36 A5 2A       LDA $2A    [$7E:002A]
$8B:8B38 EB          XBA
$8B:8B39 A5 2D       LDA $2D    [$7E:002D]
$8B:8B3B C2 20       REP #$20
$8B:8B3D 85 1A       STA $1A    [$7E:001A]
$8B:8B3F A5 78       LDA $78    [$7E:0078]
$8B:8B41 85 26       STA $26    [$7E:0026]
$8B:8B43 A5 24       LDA $24    [$7E:0024]
$8B:8B45 85 28       STA $28    [$7E:0028]
$8B:8B47 20 8F 85    JSR $858F  [$8B:858F]
$8B:8B4A E2 20       SEP #$20
$8B:8B4C A5 2A       LDA $2A    [$7E:002A]
$8B:8B4E EB          XBA
$8B:8B4F A5 2D       LDA $2D    [$7E:002D]
$8B:8B51 C2 20       REP #$20
$8B:8B53 18          CLC
$8B:8B54 65 1A       ADC $1A    [$7E:001A]
$8B:8B56 85 1A       STA $1A    [$7E:001A]
$8B:8B58 A5 82       LDA $82    [$7E:0082]
$8B:8B5A 38          SEC
$8B:8B5B E5 1A       SBC $1A    [$7E:001A]
$8B:8B5D 38          SEC
$8B:8B5E ED 15 09    SBC $0915  [$7E:0915]
$8B:8B61 85 12       STA $12    [$7E:0012]
$8B:8B63 AB          PLB
$8B:8B64 28          PLP
$8B:8B65 6B          RTL
}


;;; $8B66: Calculate position of Ceres steam in rotating elevator room ;;;
{
$8B:8B66 08          PHP
$8B:8B67 8B          PHB
$8B:8B68 4B          PHK
$8B:8B69 AB          PLB
$8B:8B6A C2 30       REP #$30
$8B:8B6C A5 12       LDA $12    [$7E:0012]
$8B:8B6E 38          SEC
$8B:8B6F E5 80       SBC $80    [$7E:0080]
$8B:8B71 85 22       STA $22    [$7E:0022]
$8B:8B73 A5 82       LDA $82    [$7E:0082]
$8B:8B75 38          SEC
$8B:8B76 E5 14       SBC $14    [$7E:0014]
$8B:8B78 85 24       STA $24    [$7E:0024]
$8B:8B7A A5 22       LDA $22    [$7E:0022]
$8B:8B7C 85 26       STA $26    [$7E:0026]
$8B:8B7E A5 78       LDA $78    [$7E:0078]
$8B:8B80 85 28       STA $28    [$7E:0028]
$8B:8B82 20 8F 85    JSR $858F  [$8B:858F]
$8B:8B85 E2 20       SEP #$20
$8B:8B87 A5 2A       LDA $2A    [$7E:002A]
$8B:8B89 EB          XBA
$8B:8B8A A5 2D       LDA $2D    [$7E:002D]
$8B:8B8C C2 20       REP #$20
$8B:8B8E 85 1A       STA $1A    [$7E:001A]
$8B:8B90 A5 7A       LDA $7A    [$7E:007A]
$8B:8B92 85 26       STA $26    [$7E:0026]
$8B:8B94 A5 24       LDA $24    [$7E:0024]
$8B:8B96 85 28       STA $28    [$7E:0028]
$8B:8B98 20 8F 85    JSR $858F  [$8B:858F]
$8B:8B9B E2 20       SEP #$20
$8B:8B9D A5 2A       LDA $2A    [$7E:002A]
$8B:8B9F EB          XBA
$8B:8BA0 A5 2D       LDA $2D    [$7E:002D]
$8B:8BA2 C2 20       REP #$20
$8B:8BA4 18          CLC
$8B:8BA5 65 1A       ADC $1A    [$7E:001A]
$8B:8BA7 85 1A       STA $1A    [$7E:001A]
$8B:8BA9 A5 80       LDA $80    [$7E:0080]
$8B:8BAB 18          CLC
$8B:8BAC 65 1A       ADC $1A    [$7E:001A]
$8B:8BAE 85 12       STA $12    [$7E:0012]
$8B:8BB0 A5 7C       LDA $7C    [$7E:007C]
$8B:8BB2 85 26       STA $26    [$7E:0026]
$8B:8BB4 A5 22       LDA $22    [$7E:0022]
$8B:8BB6 85 28       STA $28    [$7E:0028]
$8B:8BB8 20 8F 85    JSR $858F  [$8B:858F]
$8B:8BBB E2 20       SEP #$20
$8B:8BBD A5 2A       LDA $2A    [$7E:002A]
$8B:8BBF EB          XBA
$8B:8BC0 A5 2D       LDA $2D    [$7E:002D]
$8B:8BC2 C2 20       REP #$20
$8B:8BC4 85 1A       STA $1A    [$7E:001A]
$8B:8BC6 A5 78       LDA $78    [$7E:0078]
$8B:8BC8 85 26       STA $26    [$7E:0026]
$8B:8BCA A5 24       LDA $24    [$7E:0024]
$8B:8BCC 85 28       STA $28    [$7E:0028]
$8B:8BCE 20 8F 85    JSR $858F  [$8B:858F]
$8B:8BD1 E2 20       SEP #$20
$8B:8BD3 A5 2A       LDA $2A    [$7E:002A]
$8B:8BD5 EB          XBA
$8B:8BD6 A5 2D       LDA $2D    [$7E:002D]
$8B:8BD8 C2 20       REP #$20
$8B:8BDA 18          CLC
$8B:8BDB 65 1A       ADC $1A    [$7E:001A]
$8B:8BDD 85 1A       STA $1A    [$7E:001A]
$8B:8BDF A5 82       LDA $82    [$7E:0082]
$8B:8BE1 38          SEC
$8B:8BE2 E5 1A       SBC $1A    [$7E:001A]
$8B:8BE4 85 14       STA $14    [$7E:0014]
$8B:8BE6 AB          PLB
$8B:8BE7 28          PLP
$8B:8BE8 6B          RTL
}


;;; $8BE9: Copy current palettes to fading palettes ;;;
{
$8B:8BE9 08          PHP
$8B:8BEA 8B          PHB
$8B:8BEB E2 30       SEP #$30
$8B:8BED A9 7F       LDA #$7F
$8B:8BEF 48          PHA
$8B:8BF0 AB          PLB
$8B:8BF1 C2 30       REP #$30
$8B:8BF3 A0 00 01    LDY #$0100
$8B:8BF6 A2 00 00    LDX #$0000

$8B:8BF9 BF 00 C0 7E LDA $7EC000,x[$7E:C000]
$8B:8BFD 9F 00 22 7E STA $7E2200,x[$7E:2200]
$8B:8C01 E8          INX
$8B:8C02 E8          INX
$8B:8C03 88          DEY
$8B:8C04 D0 F3       BNE $F3    [$8BF9]
$8B:8C06 AB          PLB
$8B:8C07 28          PLP
$8B:8C08 60          RTS
}


;;; $8C09: Decompose palette data for fading ;;;
{
$8B:8C09 08          PHP
$8B:8C0A 8B          PHB
$8B:8C0B E2 30       SEP #$30
$8B:8C0D A9 7F       LDA #$7F
$8B:8C0F 48          PHA
$8B:8C10 AB          PLB
$8B:8C11 C2 30       REP #$30
$8B:8C13 A2 00 00    LDX #$0000             ; X = 0 (colour index)
$8B:8C16 A0 00 01    LDY #$0100             ; Y = 100h

; LOOP
$8B:8C19 BF 00 22 7E LDA $7E2200,x[$7E:2200];\
$8B:8C1D 85 12       STA $12    [$7E:0012]  ;} $12 = [$7E:2200 + [X]]
$8B:8C1F 29 1F 00    AND #$001F             ;\
$8B:8C22 EB          XBA                    ;} Fading intro red colour = ([$12] & 1Fh) * 100h
$8B:8C23 9F 00 24 7E STA $7E2400,x[$7E:2400];/
$8B:8C27 EB          XBA                    ;\
$8B:8C28 0A          ASL A                  ;|
$8B:8C29 0A          ASL A                  ;} Fading intro red colour delta = [fading intro red colour] / 20h
$8B:8C2A 0A          ASL A                  ;|
$8B:8C2B 9F 00 2A 7E STA $7E2A00,x[$7E:2A00];/
$8B:8C2F A5 12       LDA $12    [$7E:0012]  ;\
$8B:8C31 29 E0 03    AND #$03E0             ;|
$8B:8C34 0A          ASL A                  ;|
$8B:8C35 0A          ASL A                  ;} Fading intro green colour = ([$12] >> 5 & 1Fh) * 100h
$8B:8C36 0A          ASL A                  ;|
$8B:8C37 9F 00 26 7E STA $7E2600,x[$7E:2600];/
$8B:8C3B EB          XBA                    ;\
$8B:8C3C 0A          ASL A                  ;|
$8B:8C3D 0A          ASL A                  ;} Fading intro green colour delta = [fading intro green colour] / 20h
$8B:8C3E 0A          ASL A                  ;|
$8B:8C3F 9F 00 2C 7E STA $7E2C00,x[$7E:2C00];/
$8B:8C43 A5 12       LDA $12    [$7E:0012]  ;\
$8B:8C45 29 00 7C    AND #$7C00             ;|
$8B:8C48 4A          LSR A                  ;} Fading intro blue colour = ([$12] >> 10 & 1Fh) * 100h
$8B:8C49 4A          LSR A                  ;|
$8B:8C4A 9F 00 28 7E STA $7E2800,x[$7E:2800];/
$8B:8C4E EB          XBA                    ;\
$8B:8C4F 0A          ASL A                  ;|
$8B:8C50 0A          ASL A                  ;} Fading intro blue colour delta = [fading intro blue colour] / 20h
$8B:8C51 0A          ASL A                  ;|
$8B:8C52 9F 00 2E 7E STA $7E2E00,x[$7E:2E00];/
$8B:8C56 E8          INX                    ;\
$8B:8C57 E8          INX                    ;} X += 2
$8B:8C58 88          DEY                    ; Decrement Y
$8B:8C59 D0 BE       BNE $BE    [$8C19]     ; If [Y] != 0: go to LOOP
$8B:8C5B AB          PLB
$8B:8C5C 28          PLP
$8B:8C5D 60          RTS
}


;;; $8C5E: Clear [Y] colours starting from colour index [X] ;;;
{
$8B:8C5E 08          PHP
$8B:8C5F 8B          PHB
$8B:8C60 E2 20       SEP #$20
$8B:8C62 A9 7F       LDA #$7F
$8B:8C64 48          PHA
$8B:8C65 AB          PLB
$8B:8C66 C2 30       REP #$30

; LOOP
$8B:8C68 A9 00 00    LDA #$0000
$8B:8C6B 9F 00 22 7E STA $7E2200,x[$7E:2228]
$8B:8C6F 9F 00 24 7E STA $7E2400,x[$7E:2428]; Fading intro red colour = 0
$8B:8C73 9F 00 26 7E STA $7E2600,x[$7E:2628]; Fading intro green colour = 0
$8B:8C77 9F 00 28 7E STA $7E2800,x[$7E:2828]; Fading intro blue colour = 0
$8B:8C7B E8          INX                    ;\
$8B:8C7C E8          INX                    ;} X += 2 (colour index)
$8B:8C7D 88          DEY                    ; Decrement Y
$8B:8C7E D0 E8       BNE $E8    [$8C68]     ; If [Y] != 0: go to LOOP
$8B:8C80 AB          PLB
$8B:8C81 28          PLP
$8B:8C82 60          RTS
}


;;; $8C83: Fade out [Y] colours starting from colour index [X] ;;;
{
$8B:8C83 08          PHP

; LOOP
$8B:8C84 BF 00 24 7E LDA $7E2400,x[$7E:2400];\
$8B:8C88 38          SEC                    ;|
$8B:8C89 FF 00 2A 7E SBC $7E2A00,x[$7E:2A00];} Fading intro red colour -= [fading intro red colour delta]
$8B:8C8D 9F 00 24 7E STA $7E2400,x[$7E:2400];/
$8B:8C91 BF 00 26 7E LDA $7E2600,x[$7E:2600];\
$8B:8C95 38          SEC                    ;|
$8B:8C96 FF 00 2C 7E SBC $7E2C00,x[$7E:2C00];} Fading intro green colour -= [fading intro green colour delta]
$8B:8C9A 9F 00 26 7E STA $7E2600,x[$7E:2600];/
$8B:8C9E BF 00 28 7E LDA $7E2800,x[$7E:2800];\
$8B:8CA2 38          SEC                    ;|
$8B:8CA3 FF 00 2E 7E SBC $7E2E00,x[$7E:2E00];} Fading intro blue colour -= [fading intro blue colour delta]
$8B:8CA7 9F 00 28 7E STA $7E2800,x[$7E:2800];/
$8B:8CAB E8          INX                    ;\
$8B:8CAC E8          INX                    ;} X += 2 (colour index)
$8B:8CAD 88          DEY                    ; Decrement Y
$8B:8CAE D0 D4       BNE $D4    [$8C84]     ; If [Y] != 0: go to LOOP
$8B:8CB0 28          PLP
$8B:8CB1 60          RTS
}


;;; $8CB2: Fade in [Y] colours starting from colour index [X] ;;;
{
$8B:8CB2 08          PHP

; LOOP
$8B:8CB3 BF 00 24 7E LDA $7E2400,x[$7E:2428];\
$8B:8CB7 18          CLC                    ;|
$8B:8CB8 7F 00 2A 7E ADC $7E2A00,x[$7E:2A28];} Fading intro red colour = ([fading intro red colour] + [fading intro red colour delta]) % 2000h
$8B:8CBC 29 FF 1F    AND #$1FFF             ;|
$8B:8CBF 9F 00 24 7E STA $7E2400,x[$7E:2428];/
$8B:8CC3 BF 00 26 7E LDA $7E2600,x[$7E:2628];\
$8B:8CC7 18          CLC                    ;|
$8B:8CC8 7F 00 2C 7E ADC $7E2C00,x[$7E:2C28];} Fading intro green colour = ([fading intro green colour] + [fading intro green colour delta]) % 2000h
$8B:8CCC 29 FF 1F    AND #$1FFF             ;|
$8B:8CCF 9F 00 26 7E STA $7E2600,x[$7E:2628];/
$8B:8CD3 BF 00 28 7E LDA $7E2800,x[$7E:2828];\
$8B:8CD7 18          CLC                    ;|
$8B:8CD8 7F 00 2E 7E ADC $7E2E00,x[$7E:2E28];} Fading intro blue colour = ([fading intro blue colour] + [fading intro blue colour delta]) % 2000h
$8B:8CDC 29 FF 1F    AND #$1FFF             ;|
$8B:8CDF 9F 00 28 7E STA $7E2800,x[$7E:2828];/
$8B:8CE3 E8          INX                    ;\
$8B:8CE4 E8          INX                    ;} X += 2
$8B:8CE5 88          DEY                    ; Decrement Y
$8B:8CE6 D0 CB       BNE $CB    [$8CB3]     ; If [Y] != 0: go to LOOP
$8B:8CE8 28          PLP
$8B:8CE9 60          RTS
}


;;; $8CEA: Compose fading palettes ;;;
{
$8B:8CEA 08          PHP
$8B:8CEB A2 00 00    LDX #$0000             ; X = 0
$8B:8CEE A0 00 01    LDY #$0100             ; Y = 100h

; LOOP
$8B:8CF1 BF 00 24 7E LDA $7E2400,x[$7E:2400];\
$8B:8CF5 EB          XBA                    ;} A = [$7E:2400 + [X]] >> 8 & 1Fh (red component)
$8B:8CF6 29 1F 00    AND #$001F             ;/
$8B:8CF9 85 12       STA $12    [$7E:0012]  ;\
$8B:8CFB BF 00 26 7E LDA $7E2600,x[$7E:2600];|
$8B:8CFF 4A          LSR A                  ;|
$8B:8D00 4A          LSR A                  ;} A |= ([$7E:2600 + [X]] >> 8 & 1Fh) << 5 (green component)
$8B:8D01 4A          LSR A                  ;|
$8B:8D02 29 E0 03    AND #$03E0             ;|
$8B:8D05 05 12       ORA $12    [$7E:0012]  ;/
$8B:8D07 85 12       STA $12    [$7E:0012]  ;\
$8B:8D09 BF 00 28 7E LDA $7E2800,x[$7E:2800];|
$8B:8D0D 0A          ASL A                  ;|
$8B:8D0E 0A          ASL A                  ;} A |= ([$7E:2800 + [X]] >> 8 & 1Fh) << 10 (blue component)
$8B:8D0F 29 00 7C    AND #$7C00             ;|
$8B:8D12 05 12       ORA $12    [$7E:0012]  ;/
$8B:8D14 9F 00 20 7E STA $7E2000,x[$7E:2000]; $7E:2000 + [X] = [A]
$8B:8D18 9F 00 C0 7E STA $7EC000,x[$7E:C000]; $7E:C000 + [X] = [A]
$8B:8D1C E8          INX                    ;\
$8B:8D1D E8          INX                    ;} X += 2
$8B:8D1E 88          DEY                    ; Decrement Y
$8B:8D1F D0 D0       BNE $D0    [$8CF1]     ; If [Y] != 0: go to LOOP
$8B:8D21 28          PLP
$8B:8D22 60          RTS
}


;;; $8D23: Load Japanese intro text tiles ;;;
{
;; Parameters:
;;     Y: Pointer to Japanese intro text data

; Format:
;     dddd,nnnn
;     tttt,bbbb
;     tttt,bbbb
;     ...
; where
;     d: Japanese text tiles destination offset ($7E:4000 + d)
;     n: Number of characters
;     t: Top Japanese text tiles source offset ($7F:A000 + t)
;     b: Bottom Japanese text tiles source offset ($7F:A000 + b)

$8B:8D23 08          PHP
$8B:8D24 C2 30       REP #$30
$8B:8D26 DA          PHX
$8B:8D27 B9 00 00    LDA $0000,y
$8B:8D2A AA          TAX
$8B:8D2B B9 02 00    LDA $0002,y
$8B:8D2E 85 12       STA $12    [$7E:0012]

$8B:8D30 B9 04 00    LDA $0004,y
$8B:8D33 85 16       STA $16    [$7E:0016]
$8B:8D35 5A          PHY
$8B:8D36 A9 00 A0    LDA #$A000
$8B:8D39 18          CLC
$8B:8D3A 65 16       ADC $16    [$7E:0016]
$8B:8D3C A8          TAY
$8B:8D3D 8B          PHB
$8B:8D3E F4 00 7F    PEA $7F00
$8B:8D41 AB          PLB
$8B:8D42 AB          PLB
$8B:8D43 B9 00 00    LDA $0000,y
$8B:8D46 9F 00 40 7E STA $7E4000,x
$8B:8D4A B9 02 00    LDA $0002,y
$8B:8D4D 9F 02 40 7E STA $7E4002,x
$8B:8D51 B9 04 00    LDA $0004,y
$8B:8D54 9F 04 40 7E STA $7E4004,x
$8B:8D58 B9 06 00    LDA $0006,y
$8B:8D5B 9F 06 40 7E STA $7E4006,x
$8B:8D5F B9 08 00    LDA $0008,y
$8B:8D62 9F 08 40 7E STA $7E4008,x
$8B:8D66 B9 0A 00    LDA $000A,y
$8B:8D69 9F 0A 40 7E STA $7E400A,x
$8B:8D6D B9 0C 00    LDA $000C,y
$8B:8D70 9F 0C 40 7E STA $7E400C,x
$8B:8D74 B9 0E 00    LDA $000E,y
$8B:8D77 9F 0E 40 7E STA $7E400E,x
$8B:8D7B AB          PLB
$8B:8D7C 7A          PLY
$8B:8D7D B9 06 00    LDA $0006,y
$8B:8D80 85 16       STA $16    [$7E:0016]
$8B:8D82 8A          TXA
$8B:8D83 18          CLC
$8B:8D84 69 00 03    ADC #$0300
$8B:8D87 AA          TAX
$8B:8D88 5A          PHY
$8B:8D89 A9 00 A0    LDA #$A000
$8B:8D8C 18          CLC
$8B:8D8D 65 16       ADC $16    [$7E:0016]
$8B:8D8F A8          TAY
$8B:8D90 8B          PHB
$8B:8D91 F4 00 7F    PEA $7F00
$8B:8D94 AB          PLB
$8B:8D95 AB          PLB
$8B:8D96 B9 00 00    LDA $0000,y
$8B:8D99 9F 00 40 7E STA $7E4000,x
$8B:8D9D B9 02 00    LDA $0002,y
$8B:8DA0 9F 02 40 7E STA $7E4002,x
$8B:8DA4 B9 04 00    LDA $0004,y
$8B:8DA7 9F 04 40 7E STA $7E4004,x
$8B:8DAB B9 06 00    LDA $0006,y
$8B:8DAE 9F 06 40 7E STA $7E4006,x
$8B:8DB2 B9 08 00    LDA $0008,y
$8B:8DB5 9F 08 40 7E STA $7E4008,x
$8B:8DB9 B9 0A 00    LDA $000A,y
$8B:8DBC 9F 0A 40 7E STA $7E400A,x
$8B:8DC0 B9 0C 00    LDA $000C,y
$8B:8DC3 9F 0C 40 7E STA $7E400C,x
$8B:8DC7 B9 0E 00    LDA $000E,y
$8B:8DCA 9F 0E 40 7E STA $7E400E,x
$8B:8DCE AB          PLB
$8B:8DCF 7A          PLY
$8B:8DD0 8A          TXA
$8B:8DD1 38          SEC
$8B:8DD2 E9 F0 02    SBC #$02F0
$8B:8DD5 AA          TAX
$8B:8DD6 98          TYA
$8B:8DD7 18          CLC
$8B:8DD8 69 04 00    ADC #$0004
$8B:8DDB A8          TAY
$8B:8DDC C6 12       DEC $12    [$7E:0012]
$8B:8DDE F0 03       BEQ $03    [$8DE3]
$8B:8DE0 4C 30 8D    JMP $8D30  [$8B:8D30]

$8B:8DE3 FA          PLX
$8B:8DE4 28          PLP
$8B:8DE5 60          RTS
}


;;; $8DE6: Transfer Japanese text tiles to VRAM ;;;
{
; Queue DMA for VRAM $4180..447F = [$7E:4000..45FF]
$8B:8DE6 DA          PHX
$8B:8DE7 AE 30 03    LDX $0330  [$7E:0330]
$8B:8DEA A9 00 06    LDA #$0600
$8B:8DED 95 D0       STA $D0,x  [$7E:00D0]
$8B:8DEF E8          INX
$8B:8DF0 E8          INX
$8B:8DF1 A9 00 40    LDA #$4000
$8B:8DF4 95 D0       STA $D0,x  [$7E:00D2]
$8B:8DF6 E8          INX
$8B:8DF7 E8          INX
$8B:8DF8 E2 20       SEP #$20
$8B:8DFA A9 7E       LDA #$7E
$8B:8DFC 95 D0       STA $D0,x  [$7E:00D4]
$8B:8DFE C2 20       REP #$20
$8B:8E00 E8          INX
$8B:8E01 A9 80 41    LDA #$4180
$8B:8E04 95 D0       STA $D0,x  [$7E:00D5]
$8B:8E06 E8          INX
$8B:8E07 E8          INX
$8B:8E08 8E 30 03    STX $0330  [$7E:0330]
$8B:8E0B FA          PLX
$8B:8E0C 60          RTS
}


;;; $8E0D: Handle Samus during intro ;;;
{
$8B:8E0D AD 57 1A    LDA $1A57  [$7E:1A57]  ;\
$8B:8E10 F0 1A       BEQ $1A    [$8E2C]     ;} If [intro Samus display flag] = 0: return
$8B:8E12 22 92 E6 90 JSL $90E692[$90:E692]  ; Samus current state handler
$8B:8E16 22 22 E7 90 JSL $90E722[$90:E722]  ; Samus new state handler
$8B:8E1A AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$8B:8E1D F0 04       BEQ $04    [$8E23]     ;|
$8B:8E1F 3A          DEC A                  ;} Samus invincibility timer = max(0, [Samus invincibility timer] - 1)
$8B:8E20 8D A8 18    STA $18A8  [$7E:18A8]  ;/

$8B:8E23 AD AA 18    LDA $18AA  [$7E:18AA]  ;\
$8B:8E26 F0 04       BEQ $04    [$8E2C]     ;|
$8B:8E28 3A          DEC A                  ;} Samus knockback timer = max(0, [Samus knockback timer] - 1)
$8B:8E29 8D AA 18    STA $18AA  [$7E:18AA]  ;/

$8B:8E2C 60          RTS
}


;;; $8E2D: Draw intro sprites ;;;
{
$8B:8E2D AD 57 1A    LDA $1A57  [$7E:1A57]  ;\
$8B:8E30 F0 1C       BEQ $1C    [$8E4E]     ;} If [intro Samus display flag] = 0: go to BRANCH_NO_SAMUS
$8B:8E32 30 0D       BMI $0D    [$8E41]     ; If [intro Samus display flag] & 8000h: go to BRANCH_SAMUS_PRIORITY
$8B:8E34 20 46 97    JSR $9746  [$8B:9746]  ; Draw cinematic sprite objects
$8B:8E37 22 35 EB 90 JSL $90EB35[$90:EB35]  ; Draw Samus
$8B:8E3B 22 54 82 93 JSL $938254[$93:8254]  ; Draw projectiles
$8B:8E3F 80 10       BRA $10    [$8E51]

; BRANCH_SAMUS_PRIORITY
$8B:8E41 22 35 EB 90 JSL $90EB35[$90:EB35]  ; Draw Samus
$8B:8E45 22 54 82 93 JSL $938254[$93:8254]  ; Draw projectiles
$8B:8E49 20 46 97    JSR $9746  [$8B:9746]  ; Draw cinematic sprite objects
$8B:8E4C 80 03       BRA $03    [$8E51]

; BRANCH_NO_SAMUS
$8B:8E4E 20 46 97    JSR $9746  [$8B:9746]  ; Draw cinematic sprite objects

$8B:8E51 60          RTS
}


;;; $8E52: Unused. Calculate X/Y components of radius [A] angle [Y] ;;;
{
;; Parameters:
;;     A: Radius
;;     Y: Angle * 2. Origin = up, positive direction = clockwise
;; Returns:
;;     $14: X component of radius
;;     $16: Y component of radius

; Clone of $86:9BA2
$8B:8E52 08          PHP
$8B:8E53 C2 30       REP #$30
$8B:8E55 DA          PHX
$8B:8E56 85 18       STA $18    [$7E:0018]  ; $18 = [A]
$8B:8E58 98          TYA                    ;\
$8B:8E59 85 1A       STA $1A    [$7E:001A]  ;} $1A = [Y]
$8B:8E5B C9 80 00    CMP #$0080             ;\
$8B:8E5E 10 07       BPL $07    [$8E67]     ;|
$8B:8E60 0A          ASL A                  ;|
$8B:8E61 AA          TAX                    ;|
$8B:8E62 20 A3 8E    JSR $8EA3  [$8B:8EA3]  ;|
$8B:8E65 80 10       BRA $10    [$8E77]     ;|
                                            ;|
$8B:8E67 38          SEC                    ;|
$8B:8E68 E9 80 00    SBC #$0080             ;} $14 = [A] * sin([Y] * pi / 80h)
$8B:8E6B 29 FF 00    AND #$00FF             ;|
$8B:8E6E 0A          ASL A                  ;|
$8B:8E6F AA          TAX                    ;|
$8B:8E70 20 A3 8E    JSR $8EA3  [$8B:8EA3]  ;|
$8B:8E73 49 FF FF    EOR #$FFFF             ;|
$8B:8E76 1A          INC A                  ;|
                                            ;|
$8B:8E77 85 14       STA $14    [$7E:0014]  ;/
$8B:8E79 A5 1A       LDA $1A    [$7E:001A]  ;\
$8B:8E7B 38          SEC                    ;|
$8B:8E7C E9 40 00    SBC #$0040             ;|
$8B:8E7F 29 FF 00    AND #$00FF             ;|
$8B:8E82 C9 80 00    CMP #$0080             ;|
$8B:8E85 10 07       BPL $07    [$8E8E]     ;|
$8B:8E87 0A          ASL A                  ;|
$8B:8E88 AA          TAX                    ;|
$8B:8E89 20 A3 8E    JSR $8EA3  [$8B:8EA3]  ;|
$8B:8E8C 80 10       BRA $10    [$8E9E]     ;|
                                            ;} $16 = -[A] * cos([Y] * pi / 80h)
$8B:8E8E 38          SEC                    ;|
$8B:8E8F E9 80 00    SBC #$0080             ;|
$8B:8E92 29 FF 00    AND #$00FF             ;|
$8B:8E95 0A          ASL A                  ;|
$8B:8E96 AA          TAX                    ;|
$8B:8E97 20 A3 8E    JSR $8EA3  [$8B:8EA3]  ;|
$8B:8E9A 49 FF FF    EOR #$FFFF             ;|
$8B:8E9D 1A          INC A                  ;|
                                            ;|
$8B:8E9E 85 16       STA $16    [$7E:0016]  ;/
$8B:8EA0 FA          PLX
$8B:8EA1 28          PLP
$8B:8EA2 60          RTS
}


;;; $8EA3: A = [$18] * sin([X] / 2 * pi / 80h) ;;;
{
$8B:8EA3 E2 20       SEP #$20               ;\
$8B:8EA5 BF 43 B4 A0 LDA $A0B443,x          ;|
$8B:8EA9 8D 02 42    STA $4202  [$7E:4202]  ;|
$8B:8EAC A5 18       LDA $18    [$7E:0018]  ;|
$8B:8EAE 8D 03 42    STA $4203  [$7E:4203]  ;|
$8B:8EB1 EA          NOP                    ;|
$8B:8EB2 EA          NOP                    ;} $12 = [$18] * (sin([X] / 2 * pi / 80h) * 100h low byte) / 100h
$8B:8EB3 EA          NOP                    ;|
$8B:8EB4 C2 20       REP #$20               ;|
$8B:8EB6 AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:8EB9 EB          XBA                    ;|
$8B:8EBA 29 FF 00    AND #$00FF             ;|
$8B:8EBD 85 12       STA $12    [$7E:0012]  ;/
$8B:8EBF E2 20       SEP #$20               ;\
$8B:8EC1 BF 44 B4 A0 LDA $A0B444,x          ;|
$8B:8EC5 8D 02 42    STA $4202  [$7E:4202]  ;|
$8B:8EC8 A5 18       LDA $18    [$7E:0018]  ;|
$8B:8ECA 8D 03 42    STA $4203  [$7E:4203]  ;|
$8B:8ECD EA          NOP                    ;|
$8B:8ECE EA          NOP                    ;} $12 += [$18] * (sin([X] / 2 * pi / 80h) * 100h high byte)
$8B:8ECF EA          NOP                    ;|
$8B:8ED0 C2 20       REP #$20               ;|
$8B:8ED2 AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:8ED5 18          CLC                    ;|
$8B:8ED6 65 12       ADC $12    [$7E:0012]  ;/
$8B:8ED8 60          RTS
}


;;; $8ED9: Move unused sprites off-screen ;;;
{
; Move unused sprites to X = 180h
; Uses one hell of an unrolled loop
$8B:8ED9 08          PHP
$8B:8EDA C2 30       REP #$30
$8B:8EDC AD 90 05    LDA $0590  [$7E:0590]  ;\
$8B:8EDF C9 00 02    CMP #$0200             ;} If [OAM stack pointer] >= 200h: return
$8B:8EE2 10 40       BPL $40    [$8F24]     ;/
$8B:8EE4 4A          LSR A                  ;\
$8B:8EE5 4A          LSR A                  ;|
$8B:8EE6 48          PHA                    ;|
$8B:8EE7 29 07 00    AND #$0007             ;} Y = [OAM stack pointer] / 4 % 8 * 2 (high OAM bit index)
$8B:8EEA 0A          ASL A                  ;|
$8B:8EEB A8          TAY                    ;|
$8B:8EEC 68          PLA                    ;/
$8B:8EED 4A          LSR A                  ;\
$8B:8EEE 4A          LSR A                  ;} X = [OAM stack pointer] / 10h (high OAM byte index)
$8B:8EEF AA          TAX                    ;/
$8B:8EF0 BD 70 05    LDA $0570,x[$7E:0580]  ;\
$8B:8EF3 19 26 8F    ORA $8F26,y[$8B:8F26]  ;} Set high X position bits of sprites ([X] * 4 + [Y] / 2) .. ([X] * 4 + 7)
$8B:8EF6 9D 70 05    STA $0570,x[$7E:0580]  ;/
$8B:8EF9 E0 1E 00    CPX #$001E             ;\
$8B:8EFC 10 0F       BPL $0F    [$8F0D]     ;|
$8B:8EFE E8          INX                    ;|
$8B:8EFF E8          INX                    ;|
                                            ;|
$8B:8F00 A9 55 55    LDA #$5555             ;} Set high X position bits of sprites ([X] * 4 + 8) .. 7Fh
$8B:8F03 9D 70 05    STA $0570,x[$7E:0582]  ;|
$8B:8F06 E8          INX                    ;|
$8B:8F07 E8          INX                    ;|
$8B:8F08 E0 20 00    CPX #$0020             ;|
$8B:8F0B 30 F3       BMI $F3    [$8F00]     ;/

$8B:8F0D AD 90 05    LDA $0590  [$7E:0590]  ;\
$8B:8F10 4A          LSR A                  ;|
$8B:8F11 85 12       STA $12    [$7E:0012]  ;|
$8B:8F13 4A          LSR A                  ;|
$8B:8F14 65 12       ADC $12    [$7E:0012]  ;|
$8B:8F16 18          CLC                    ;} Sprites ([X] * 4)..7Fh low X positions = 80h
$8B:8F17 69 36 8F    ADC #$8F36             ;|
$8B:8F1A 85 12       STA $12    [$7E:0012]  ;|
$8B:8F1C A9 80 00    LDA #$0080             ;|
$8B:8F1F E2 30       SEP #$30               ;|
$8B:8F21 6C 12 00    JMP ($0012)[$8B:8FF6]  ;/

$8B:8F24 28          PLP
$8B:8F25 60          RTS                    ; Return

$8B:8F26             dw 5555, ; Sprites 0..7 high X position bits
                        5554, ; Sprites 1..7 high X position bits
                        5550, ; Sprites 2..7 high X position bits
                        5540, ; Sprites 3..7 high X position bits
                        5500, ; Sprites 4..7 high X position bits
                        5400, ; Sprites 5..7 high X position bits
                        5000, ; Sprites 6..7 high X position bits
                        4000  ; Sprites 7 high X position bit

$8B:8F36 8D 70 03    STA $0370  [$7E:0370]  ; Sprite 0 X position = 80h
$8B:8F39 8D 74 03    STA $0374  [$7E:0374]  ; Sprite 1 X position = 80h
$8B:8F3C 8D 78 03    STA $0378  [$7E:0378]  ; Sprite 2 X position = 80h
$8B:8F3F 8D 7C 03    STA $037C  [$7E:037C]  ; Sprite 3 X position = 80h
$8B:8F42 8D 80 03    STA $0380  [$7E:0380]  ; Sprite 4 X position = 80h
$8B:8F45 8D 84 03    STA $0384  [$7E:0384]  ; Sprite 5 X position = 80h
$8B:8F48 8D 88 03    STA $0388  [$7E:0388]  ; Sprite 6 X position = 80h
$8B:8F4B 8D 8C 03    STA $038C  [$7E:038C]  ; Sprite 7 X position = 80h
$8B:8F4E 8D 90 03    STA $0390  [$7E:0390]  ; Sprite 8 X position = 80h
$8B:8F51 8D 94 03    STA $0394  [$7E:0394]  ; Sprite 9 X position = 80h
$8B:8F54 8D 98 03    STA $0398  [$7E:0398]  ; Sprite Ah X position = 80h
$8B:8F57 8D 9C 03    STA $039C  [$7E:039C]  ; Sprite Bh X position = 80h
$8B:8F5A 8D A0 03    STA $03A0  [$7E:03A0]  ; Sprite Ch X position = 80h
$8B:8F5D 8D A4 03    STA $03A4  [$7E:03A4]  ; Sprite Dh X position = 80h
$8B:8F60 8D A8 03    STA $03A8  [$7E:03A8]  ; Sprite Eh X position = 80h
$8B:8F63 8D AC 03    STA $03AC  [$7E:03AC]  ; Sprite Fh X position = 80h
$8B:8F66 8D B0 03    STA $03B0  [$7E:03B0]  ; Sprite 10h X position = 80h
$8B:8F69 8D B4 03    STA $03B4  [$7E:03B4]  ; Sprite 11h X position = 80h
$8B:8F6C 8D B8 03    STA $03B8  [$7E:03B8]  ; Sprite 12h X position = 80h
$8B:8F6F 8D BC 03    STA $03BC  [$7E:03BC]  ; Sprite 13h X position = 80h
$8B:8F72 8D C0 03    STA $03C0  [$7E:03C0]  ; Sprite 14h X position = 80h
$8B:8F75 8D C4 03    STA $03C4  [$7E:03C4]  ; Sprite 15h X position = 80h
$8B:8F78 8D C8 03    STA $03C8  [$7E:03C8]  ; Sprite 16h X position = 80h
$8B:8F7B 8D CC 03    STA $03CC  [$7E:03CC]  ; Sprite 17h X position = 80h
$8B:8F7E 8D D0 03    STA $03D0  [$7E:03D0]  ; Sprite 18h X position = 80h
$8B:8F81 8D D4 03    STA $03D4  [$7E:03D4]  ; Sprite 19h X position = 80h
$8B:8F84 8D D8 03    STA $03D8  [$7E:03D8]  ; Sprite 1Ah X position = 80h
$8B:8F87 8D DC 03    STA $03DC  [$7E:03DC]  ; Sprite 1Bh X position = 80h
$8B:8F8A 8D E0 03    STA $03E0  [$7E:03E0]  ; Sprite 1Ch X position = 80h
$8B:8F8D 8D E4 03    STA $03E4  [$7E:03E4]  ; Sprite 1Dh X position = 80h
$8B:8F90 8D E8 03    STA $03E8  [$7E:03E8]  ; Sprite 1Eh X position = 80h
$8B:8F93 8D EC 03    STA $03EC  [$7E:03EC]  ; Sprite 1Fh X position = 80h
$8B:8F96 8D F0 03    STA $03F0  [$7E:03F0]  ; Sprite 20h X position = 80h
$8B:8F99 8D F4 03    STA $03F4  [$7E:03F4]  ; Sprite 21h X position = 80h
$8B:8F9C 8D F8 03    STA $03F8  [$7E:03F8]  ; Sprite 22h X position = 80h
$8B:8F9F 8D FC 03    STA $03FC  [$7E:03FC]  ; Sprite 23h X position = 80h
$8B:8FA2 8D 00 04    STA $0400  [$7E:0400]  ; Sprite 24h X position = 80h
$8B:8FA5 8D 04 04    STA $0404  [$7E:0404]  ; Sprite 25h X position = 80h
$8B:8FA8 8D 08 04    STA $0408  [$7E:0408]  ; Sprite 26h X position = 80h
$8B:8FAB 8D 0C 04    STA $040C  [$7E:040C]  ; Sprite 27h X position = 80h
$8B:8FAE 8D 10 04    STA $0410  [$7E:0410]  ; Sprite 28h X position = 80h
$8B:8FB1 8D 14 04    STA $0414  [$7E:0414]  ; Sprite 29h X position = 80h
$8B:8FB4 8D 18 04    STA $0418  [$7E:0418]  ; Sprite 2Ah X position = 80h
$8B:8FB7 8D 1C 04    STA $041C  [$7E:041C]  ; Sprite 2Bh X position = 80h
$8B:8FBA 8D 20 04    STA $0420  [$7E:0420]  ; Sprite 2Ch X position = 80h
$8B:8FBD 8D 24 04    STA $0424  [$7E:0424]  ; Sprite 2Dh X position = 80h
$8B:8FC0 8D 28 04    STA $0428  [$7E:0428]  ; Sprite 2Eh X position = 80h
$8B:8FC3 8D 2C 04    STA $042C  [$7E:042C]  ; Sprite 2Fh X position = 80h
$8B:8FC6 8D 30 04    STA $0430  [$7E:0430]  ; Sprite 30h X position = 80h
$8B:8FC9 8D 34 04    STA $0434  [$7E:0434]  ; Sprite 31h X position = 80h
$8B:8FCC 8D 38 04    STA $0438  [$7E:0438]  ; Sprite 32h X position = 80h
$8B:8FCF 8D 3C 04    STA $043C  [$7E:043C]  ; Sprite 33h X position = 80h
$8B:8FD2 8D 40 04    STA $0440  [$7E:0440]  ; Sprite 34h X position = 80h
$8B:8FD5 8D 44 04    STA $0444  [$7E:0444]  ; Sprite 35h X position = 80h
$8B:8FD8 8D 48 04    STA $0448  [$7E:0448]  ; Sprite 36h X position = 80h
$8B:8FDB 8D 4C 04    STA $044C  [$7E:044C]  ; Sprite 37h X position = 80h
$8B:8FDE 8D 50 04    STA $0450  [$7E:0450]  ; Sprite 38h X position = 80h
$8B:8FE1 8D 54 04    STA $0454  [$7E:0454]  ; Sprite 39h X position = 80h
$8B:8FE4 8D 58 04    STA $0458  [$7E:0458]  ; Sprite 3Ah X position = 80h
$8B:8FE7 8D 5C 04    STA $045C  [$7E:045C]  ; Sprite 3Bh X position = 80h
$8B:8FEA 8D 60 04    STA $0460  [$7E:0460]  ; Sprite 3Ch X position = 80h
$8B:8FED 8D 64 04    STA $0464  [$7E:0464]  ; Sprite 3Dh X position = 80h
$8B:8FF0 8D 68 04    STA $0468  [$7E:0468]  ; Sprite 3Eh X position = 80h
$8B:8FF3 8D 6C 04    STA $046C  [$7E:046C]  ; Sprite 3Fh X position = 80h
$8B:8FF6 8D 70 04    STA $0470  [$7E:0470]  ; Sprite 40h X position = 80h
$8B:8FF9 8D 74 04    STA $0474  [$7E:0474]  ; Sprite 41h X position = 80h
$8B:8FFC 8D 78 04    STA $0478  [$7E:0478]  ; Sprite 42h X position = 80h
$8B:8FFF 8D 7C 04    STA $047C  [$7E:047C]  ; Sprite 43h X position = 80h
$8B:9002 8D 80 04    STA $0480  [$7E:0480]  ; Sprite 44h X position = 80h
$8B:9005 8D 84 04    STA $0484  [$7E:0484]  ; Sprite 45h X position = 80h
$8B:9008 8D 88 04    STA $0488  [$7E:0488]  ; Sprite 46h X position = 80h
$8B:900B 8D 8C 04    STA $048C  [$7E:048C]  ; Sprite 47h X position = 80h
$8B:900E 8D 90 04    STA $0490  [$7E:0490]  ; Sprite 48h X position = 80h
$8B:9011 8D 94 04    STA $0494  [$7E:0494]  ; Sprite 49h X position = 80h
$8B:9014 8D 98 04    STA $0498  [$7E:0498]  ; Sprite 4Ah X position = 80h
$8B:9017 8D 9C 04    STA $049C  [$7E:049C]  ; Sprite 4Bh X position = 80h
$8B:901A 8D A0 04    STA $04A0  [$7E:04A0]  ; Sprite 4Ch X position = 80h
$8B:901D 8D A4 04    STA $04A4  [$7E:04A4]  ; Sprite 4Dh X position = 80h
$8B:9020 8D A8 04    STA $04A8  [$7E:04A8]  ; Sprite 4Eh X position = 80h
$8B:9023 8D AC 04    STA $04AC  [$7E:04AC]  ; Sprite 4Fh X position = 80h
$8B:9026 8D B0 04    STA $04B0  [$7E:04B0]  ; Sprite 50h X position = 80h
$8B:9029 8D B4 04    STA $04B4  [$7E:04B4]  ; Sprite 51h X position = 80h
$8B:902C 8D B8 04    STA $04B8  [$7E:04B8]  ; Sprite 52h X position = 80h
$8B:902F 8D BC 04    STA $04BC  [$7E:04BC]  ; Sprite 53h X position = 80h
$8B:9032 8D C0 04    STA $04C0  [$7E:04C0]  ; Sprite 54h X position = 80h
$8B:9035 8D C4 04    STA $04C4  [$7E:04C4]  ; Sprite 55h X position = 80h
$8B:9038 8D C8 04    STA $04C8  [$7E:04C8]  ; Sprite 56h X position = 80h
$8B:903B 8D CC 04    STA $04CC  [$7E:04CC]  ; Sprite 57h X position = 80h
$8B:903E 8D D0 04    STA $04D0  [$7E:04D0]  ; Sprite 58h X position = 80h
$8B:9041 8D D4 04    STA $04D4  [$7E:04D4]  ; Sprite 59h X position = 80h
$8B:9044 8D D8 04    STA $04D8  [$7E:04D8]  ; Sprite 5Ah X position = 80h
$8B:9047 8D DC 04    STA $04DC  [$7E:04DC]  ; Sprite 5Bh X position = 80h
$8B:904A 8D E0 04    STA $04E0  [$7E:04E0]  ; Sprite 5Ch X position = 80h
$8B:904D 8D E4 04    STA $04E4  [$7E:04E4]  ; Sprite 5Dh X position = 80h
$8B:9050 8D E8 04    STA $04E8  [$7E:04E8]  ; Sprite 5Eh X position = 80h
$8B:9053 8D EC 04    STA $04EC  [$7E:04EC]  ; Sprite 5Fh X position = 80h
$8B:9056 8D F0 04    STA $04F0  [$7E:04F0]  ; Sprite 60h X position = 80h
$8B:9059 8D F4 04    STA $04F4  [$7E:04F4]  ; Sprite 61h X position = 80h
$8B:905C 8D F8 04    STA $04F8  [$7E:04F8]  ; Sprite 62h X position = 80h
$8B:905F 8D FC 04    STA $04FC  [$7E:04FC]  ; Sprite 63h X position = 80h
$8B:9062 8D 00 05    STA $0500  [$7E:0500]  ; Sprite 64h X position = 80h
$8B:9065 8D 04 05    STA $0504  [$7E:0504]  ; Sprite 65h X position = 80h
$8B:9068 8D 08 05    STA $0508  [$7E:0508]  ; Sprite 66h X position = 80h
$8B:906B 8D 0C 05    STA $050C  [$7E:050C]  ; Sprite 67h X position = 80h
$8B:906E 8D 10 05    STA $0510  [$7E:0510]  ; Sprite 68h X position = 80h
$8B:9071 8D 14 05    STA $0514  [$7E:0514]  ; Sprite 69h X position = 80h
$8B:9074 8D 18 05    STA $0518  [$7E:0518]  ; Sprite 6Ah X position = 80h
$8B:9077 8D 1C 05    STA $051C  [$7E:051C]  ; Sprite 6Bh X position = 80h
$8B:907A 8D 20 05    STA $0520  [$7E:0520]  ; Sprite 6Ch X position = 80h
$8B:907D 8D 24 05    STA $0524  [$7E:0524]  ; Sprite 6Dh X position = 80h
$8B:9080 8D 28 05    STA $0528  [$7E:0528]  ; Sprite 6Eh X position = 80h
$8B:9083 8D 2C 05    STA $052C  [$7E:052C]  ; Sprite 6Fh X position = 80h
$8B:9086 8D 30 05    STA $0530  [$7E:0530]  ; Sprite 70h X position = 80h
$8B:9089 8D 34 05    STA $0534  [$7E:0534]  ; Sprite 71h X position = 80h
$8B:908C 8D 38 05    STA $0538  [$7E:0538]  ; Sprite 72h X position = 80h
$8B:908F 8D 3C 05    STA $053C  [$7E:053C]  ; Sprite 73h X position = 80h
$8B:9092 8D 40 05    STA $0540  [$7E:0540]  ; Sprite 74h X position = 80h
$8B:9095 8D 44 05    STA $0544  [$7E:0544]  ; Sprite 75h X position = 80h
$8B:9098 8D 48 05    STA $0548  [$7E:0548]  ; Sprite 76h X position = 80h
$8B:909B 8D 4C 05    STA $054C  [$7E:054C]  ; Sprite 77h X position = 80h
$8B:909E 8D 50 05    STA $0550  [$7E:0550]  ; Sprite 78h X position = 80h
$8B:90A1 8D 54 05    STA $0554  [$7E:0554]  ; Sprite 79h X position = 80h
$8B:90A4 8D 58 05    STA $0558  [$7E:0558]  ; Sprite 7Ah X position = 80h
$8B:90A7 8D 5C 05    STA $055C  [$7E:055C]  ; Sprite 7Bh X position = 80h
$8B:90AA 8D 60 05    STA $0560  [$7E:0560]  ; Sprite 7Ch X position = 80h
$8B:90AD 8D 64 05    STA $0564  [$7E:0564]  ; Sprite 7Dh X position = 80h
$8B:90B0 8D 68 05    STA $0568  [$7E:0568]  ; Sprite 7Eh X position = 80h
$8B:90B3 8D 6C 05    STA $056C  [$7E:056C]  ; Sprite 7Fh X position = 80h
$8B:90B6 28          PLP
$8B:90B7 60          RTS
}


;;; $90B8: Advance fast screen fade out ;;;
{
;; Returns:
;;     Carry: Set if reached zero brightness, otherwise clear

; Screen darkens at rate [screen fade counter] / Fh per frame
$8B:90B8 08          PHP
$8B:90B9 E2 30       SEP #$30
$8B:90BB A5 51       LDA $51    [$7E:0051]  ;\
$8B:90BD 29 0F       AND #$0F               ;} If [screen brightness] = 0: return carry set
$8B:90BF F0 11       BEQ $11    [$90D2]     ;/
$8B:90C1 38          SEC                    ;\
$8B:90C2 ED 25 07    SBC $0725  [$7E:0725]  ;|
$8B:90C5 F0 07       BEQ $07    [$90CE]     ;} If [screen brightness] - [screen fade counter] > 0:
$8B:90C7 30 05       BMI $05    [$90CE]     ;/
$8B:90C9 85 51       STA $51    [$7E:0051]  ; Screen brightness -= [screen fade counter], disable forced blank
$8B:90CB 28          PLP
$8B:90CC 18          CLC                    ;\
$8B:90CD 60          RTS                    ;} Return clear carry

$8B:90CE A9 80       LDA #$80               ;\
$8B:90D0 85 51       STA $51    [$7E:0051]  ;} Screen brightness = 0, enable forced blank

$8B:90D2 28          PLP
$8B:90D3 38          SEC                    ;\
$8B:90D4 60          RTS                    ;} Return carry set
}


;;; $90D5: Advance slow screen fade out ;;;
{
;; Returns:
;;     Carry: Set if reached zero brightness, otherwise clear

; Screen darkens at rate 1/Fh per [screen fade counter] frames
$8B:90D5 08          PHP
$8B:90D6 E2 30       SEP #$30
$8B:90D8 CE 23 07    DEC $0723  [$7E:0723]  ; Decrement screen fade delay
$8B:90DB F0 02       BEQ $02    [$90DF]     ;\
$8B:90DD 10 11       BPL $11    [$90F0]     ;} If [screen fade delay] > 0: return carry clear

$8B:90DF A5 51       LDA $51    [$7E:0051]  ;\
$8B:90E1 29 0F       AND #$0F               ;} If [screen brightness] = 0: return carry set
$8B:90E3 F0 18       BEQ $18    [$90FD]     ;/
$8B:90E5 3A          DEC A                  ;\
$8B:90E6 F0 0B       BEQ $0B    [$90F3]     ;} If [screen brightness] - 1 = 0: go to BRANCH_ZERO_BRIGHTNESS
$8B:90E8 85 51       STA $51    [$7E:0051]  ; Decrement screen brightness
$8B:90EA AD 25 07    LDA $0725  [$7E:0725]  ;\
$8B:90ED 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = [screen fade counter]

$8B:90F0 28          PLP
$8B:90F1 18          CLC                    ;\
$8B:90F2 60          RTS                    ;} Return carry set

; BRANCH_ZERO_BRIGHTNESS
$8B:90F3 A9 80       LDA #$80               ;\
$8B:90F5 85 51       STA $51    [$7E:0051]  ;} Screen brightness = 0, enable forced blank
$8B:90F7 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$8B:90FA 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0

$8B:90FD 28          PLP
$8B:90FE 38          SEC                    ;\
$8B:90FF 60          RTS                    ;} Return carry set
}


;;; $9100: Advance fast screen fade in ;;;
{
;; Returns:
;;     Carry: Set if reached max brightness, otherwise clear

; Screen brightens at rate [screen fade counter] / Fh per frame
$8B:9100 08          PHP
$8B:9101 E2 30       SEP #$30
$8B:9103 A5 51       LDA $51    [$7E:0051]  ;\
$8B:9105 18          CLC                    ;|
$8B:9106 6D 25 07    ADC $0725  [$7E:0725]  ;|
$8B:9109 29 1F       AND #$1F               ;} If [screen brightness] + [screen fade counter] < Fh:
$8B:910B C9 0F       CMP #$0F               ;|
$8B:910D 10 05       BPL $05    [$9114]     ;/
$8B:910F 85 51       STA $51    [$7E:0051]  ; Screen brightness += [screen fade counter], disable forced blank
$8B:9111 28          PLP
$8B:9112 18          CLC                    ;\
$8B:9113 60          RTS                    ;} Return carry set

$8B:9114 A9 0F       LDA #$0F               ;\
$8B:9116 85 51       STA $51    [$7E:0051]  ;} Screen brightness = Fh, disable forced blank
$8B:9118 28          PLP
$8B:9119 38          SEC                    ;\
$8B:911A 60          RTS                    ;} Return carry set
}


;;; $911B: Advance slow screen fade in ;;;
{
;; Returns:
;;     Carry: Set if reached max brightness, otherwise clear

; Screen brightens at rate 1/Fh per [screen fade counter] frames
$8B:911B 08          PHP
$8B:911C E2 30       SEP #$30
$8B:911E CE 23 07    DEC $0723  [$7E:0723]  ; Decrement screen fade delay
$8B:9121 F0 02       BEQ $02    [$9125]     ;\
$8B:9123 10 11       BPL $11    [$9136]     ;} If [screen fade delay] > 0: return carry clear

$8B:9125 A5 51       LDA $51    [$7E:0051]  ;\
$8B:9127 1A          INC A                  ;|
$8B:9128 29 1F       AND #$1F               ;} If [screen brightness] + 1 >= Fh: go to BRANCH_MAX_BRIGHTNESS
$8B:912A C9 0F       CMP #$0F               ;|
$8B:912C 10 0B       BPL $0B    [$9139]     ;/
$8B:912E 85 51       STA $51    [$7E:0051]  ; Increment screen brightness, disable forced blank
$8B:9130 AD 25 07    LDA $0725  [$7E:0725]  ;\
$8B:9133 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = [screen fade counter]

$8B:9136 28          PLP
$8B:9137 18          CLC                    ;\
$8B:9138 60          RTS                    ;} Return carry set

; BRANCH_MAX_BRIGHTNESS
$8B:9139 A9 0F       LDA #$0F               ;\
$8B:913B 85 51       STA $51    [$7E:0051]  ;} Screen brightness = Fh, disable forced blank
$8B:913D 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$8B:9140 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$8B:9143 28          PLP
$8B:9144 38          SEC                    ;\
$8B:9145 60          RTS                    ;} Return carry set
}


;;; $9146: Initialise IO registers and display Nintendo logo ;;;
{
$8B:9146 08          PHP
$8B:9147 8B          PHB
$8B:9148 4B          PHK                    ;\
$8B:9149 AB          PLB                    ;} DB = $8B
$8B:914A E2 30       SEP #$30
$8B:914C A9 8F       LDA #$8F               ;\
$8B:914E 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank and max screen brightness
$8B:9151 85 51       STA $51    [$7E:0051]  ;/
$8B:9153 C2 30       REP #$30
$8B:9155 9C 90 05    STZ $0590  [$7E:0590]  ; OAM stack pointer = 0
$8B:9158 22 1A 8B 80 JSL $808B1A[$80:8B1A]  ; Clear high OAM
$8B:915C 22 6E 89 80 JSL $80896E[$80:896E]  ; Finalise OAM
$8B:9160 9C 1D 07    STZ $071D  [$7E:071D]  ; Clear Samus tiles transfer flags
$8B:9163 9C 1F 07    STZ $071F  [$7E:071F]  ; Samus top half tiles definition = 0
$8B:9166 9C 21 07    STZ $0721  [$7E:0721]  ; Samus bottom half tiles definition = 0
$8B:9169 E2 20       SEP #$20
$8B:916B A9 01       LDA #$01               ;\
$8B:916D 8D 00 42    STA $4200  [$7E:4200]  ;} Enable auto-joypad read
$8B:9170 85 84       STA $84    [$7E:0084]  ;/
$8B:9172 9C 01 42    STZ $4201  [$7E:4201]  ; Joypad programmable IO port = 0
$8B:9175 9C 02 42    STZ $4202  [$7E:4202]  ;\
$8B:9178 9C 03 42    STZ $4203  [$7E:4203]  ;} Multiplication operands = 0
$8B:917B 9C 04 42    STZ $4204  [$7E:4204]  ;\
$8B:917E 9C 05 42    STZ $4205  [$7E:4205]  ;} Division operands = 0 (causes harmless division by zero)
$8B:9181 9C 06 42    STZ $4206  [$7E:4206]  ;/
$8B:9184 9C 07 42    STZ $4207  [$7E:4207]  ;\
$8B:9187 9C 08 42    STZ $4208  [$7E:4208]  ;} IRQ H-counter target = 0
$8B:918A 9C 09 42    STZ $4209  [$7E:4209]  ;\
$8B:918D 9C 0A 42    STZ $420A  [$7E:420A]  ;} IRQ V-counter target = 0
$8B:9190 9C 0B 42    STZ $420B  [$7E:420B]  ; Disable all DMA channels
$8B:9193 9C 0C 42    STZ $420C  [$7E:420C]  ;\
$8B:9196 64 85       STZ $85    [$7E:0085]  ;} Disable all HDMA channels
$8B:9198 A9 01       LDA #$01               ;\
$8B:919A 8D 0D 42    STA $420D  [$7E:420D]  ;} Enable FastROM
$8B:919D 85 86       STA $86    [$7E:0086]  ;/
$8B:919F A9 03       LDA #$03               ;\
$8B:91A1 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$8B:91A4 85 52       STA $52    [$7E:0052]  ;/
$8B:91A6 9C 02 21    STZ $2102  [$7E:2102]  ;\
$8B:91A9 64 53       STZ $53    [$7E:0053]  ;|
$8B:91AB A9 80       LDA #$80               ;} OAM address = $0000, priority sprite index = 0
$8B:91AD 8D 03 21    STA $2103  [$7E:2103]  ;|
$8B:91B0 85 54       STA $54    [$7E:0054]  ;/
$8B:91B2 9C 04 21    STZ $2104  [$7E:2104]  ;\
$8B:91B5 9C 04 21    STZ $2104  [$7E:2104]  ;} OAM $0000 = 0
$8B:91B8 A9 01       LDA #$01               ;\
$8B:91BA 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 1 without BG3 priority, BG tile sizes = 8x8
$8B:91BD 85 55       STA $55    [$7E:0055]  ;/
$8B:91BF 9C 06 21    STZ $2106  [$7E:2106]  ;\
$8B:91C2 64 57       STZ $57    [$7E:0057]  ;} Disable mosaic
$8B:91C4 9C 07 21    STZ $2107  [$7E:2107]  ;\
$8B:91C7 64 58       STZ $58    [$7E:0058]  ;} BG1 tilemap base address = $0000, size = 32x32
$8B:91C9 9C 08 21    STZ $2108  [$7E:2108]  ;\
$8B:91CC 64 59       STZ $59    [$7E:0059]  ;} BG2 tilemap base address = $0000, size = 32x32
$8B:91CE 9C 09 21    STZ $2109  [$7E:2109]  ;\
$8B:91D1 64 5A       STZ $5A    [$7E:005A]  ;} BG3 tilemap base address = $0000, size = 32x32
$8B:91D3 9C 0A 21    STZ $210A  [$7E:210A]  ;\
$8B:91D6 64 5C       STZ $5C    [$7E:005C]  ;} BG4 tilemap base address = $0000, size = 32x32
$8B:91D8 9C 0B 21    STZ $210B  [$7E:210B]  ;\
$8B:91DB 64 5D       STZ $5D    [$7E:005D]  ;|
$8B:91DD 9C 0C 21    STZ $210C  [$7E:210C]  ;} BG tiles base address = $0000
$8B:91E0 64 5E       STZ $5E    [$7E:005E]  ;/
$8B:91E2 9C 0D 21    STZ $210D  [$7E:210D]  ;\
$8B:91E5 9C 0D 21    STZ $210D  [$7E:210D]  ;} BG1 X scroll = 0
$8B:91E8 9C 0E 21    STZ $210E  [$7E:210E]  ;\
$8B:91EB 9C 0E 21    STZ $210E  [$7E:210E]  ;} BG1 Y scroll = 0
$8B:91EE 9C 0F 21    STZ $210F  [$7E:210F]  ;\
$8B:91F1 9C 0F 21    STZ $210F  [$7E:210F]  ;} BG2 X scroll = 0
$8B:91F4 9C 10 21    STZ $2110  [$7E:2110]  ;\
$8B:91F7 9C 10 21    STZ $2110  [$7E:2110]  ;} BG2 Y scroll = 0
$8B:91FA 9C 11 21    STZ $2111  [$7E:2111]  ;\
$8B:91FD 9C 11 21    STZ $2111  [$7E:2111]  ;} BG3 X scroll = 0
$8B:9200 9C 12 21    STZ $2112  [$7E:2112]  ;\
$8B:9203 9C 12 21    STZ $2112  [$7E:2112]  ;} BG3 Y scroll = 0
$8B:9206 9C 13 21    STZ $2113  [$7E:2113]  ;\
$8B:9209 9C 13 21    STZ $2113  [$7E:2113]  ;} BG4 X scroll = 0
$8B:920C 9C 14 21    STZ $2114  [$7E:2114]  ;\
$8B:920F 9C 14 21    STZ $2114  [$7E:2114]  ;} BG4 Y scroll = 0
$8B:9212 9C 15 21    STZ $2115  [$7E:2115]  ; VRAM address increment mode = 8-bit access
$8B:9215 9C 1A 21    STZ $211A  [$7E:211A]  ;\
$8B:9218 64 5F       STZ $5F    [$7E:005F]  ;} Mode 7 settings = 0
$8B:921A 9C 1B 21    STZ $211B  [$7E:211B]  ;\
$8B:921D 9C 1C 21    STZ $211C  [$7E:211C]  ;|
$8B:9220 9C 1D 21    STZ $211D  [$7E:211D]  ;} Mode 7 transformation matrix = {{0, 0}, {0, 0}}
$8B:9223 9C 1E 21    STZ $211E  [$7E:211E]  ;/
$8B:9226 9C 1F 21    STZ $211F  [$7E:211F]  ; Mode 7 transformation origin co-ordinate X = 0
$8B:9229 9C 20 21    STZ $2120  [$7E:2120]  ; Mode 7 transformation origin co-ordinate Y = 0
$8B:922C 9C 23 21    STZ $2123  [$7E:2123]  ;\
$8B:922F 64 60       STZ $60    [$7E:0060]  ;|
$8B:9231 9C 24 21    STZ $2124  [$7E:2124]  ;|
$8B:9234 64 61       STZ $61    [$7E:0061]  ;} Disable all window masks
$8B:9236 9C 25 21    STZ $2125  [$7E:2125]  ;|
$8B:9239 64 62       STZ $62    [$7E:0062]  ;/
$8B:923B 9C 26 21    STZ $2126  [$7E:2126]  ;\
$8B:923E 64 63       STZ $63    [$7E:0063]  ;} Window 1 left position = 0
$8B:9240 9C 27 21    STZ $2127  [$7E:2127]  ;\
$8B:9243 64 64       STZ $64    [$7E:0064]  ;} Window 1 right position = 0
$8B:9245 9C 28 21    STZ $2128  [$7E:2128]  ;\
$8B:9248 64 65       STZ $65    [$7E:0065]  ;} Window 2 left position = 0
$8B:924A 9C 29 21    STZ $2129  [$7E:2129]  ;\
$8B:924D 64 66       STZ $66    [$7E:0066]  ;} Window 2 right position = 0
$8B:924F 9C 2A 21    STZ $212A  [$7E:212A]  ;\
$8B:9252 64 67       STZ $67    [$7E:0067]  ;|
$8B:9254 9C 2B 21    STZ $212B  [$7E:212B]  ;} Window 1/2 mask logic = OR
$8B:9257 64 68       STZ $68    [$7E:0068]  ;/
$8B:9259 A9 10       LDA #$10               ;\
$8B:925B 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = sprites
$8B:925E 85 69       STA $69    [$7E:0069]  ;/
$8B:9260 9C 2E 21    STZ $212E  [$7E:212E]  ;\
$8B:9263 64 6C       STZ $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$8B:9265 9C 2D 21    STZ $212D  [$7E:212D]  ;\
$8B:9268 64 6B       STZ $6B    [$7E:006B]  ;} Disable all subscreen layers
$8B:926A 9C 2F 21    STZ $212F  [$7E:212F]  ;\
$8B:926D 64 6D       STZ $6D    [$7E:006D]  ;} Enable all layers in window area subscreen
$8B:926F 9C 30 21    STZ $2130  [$7E:2130]  ;\
$8B:9272 64 6E       STZ $6E    [$7E:006E]  ;|
$8B:9274 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$8B:9277 64 71       STZ $71    [$7E:0071]  ;/
$8B:9279 A9 E0       LDA #$E0               ;\
$8B:927B 8D 32 21    STA $2132  [$7E:2132]  ;|
$8B:927E A9 20       LDA #$20               ;|
$8B:9280 85 74       STA $74    [$7E:0074]  ;|
$8B:9282 A9 40       LDA #$40               ;} Colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:9284 85 75       STA $75    [$7E:0075]  ;|
$8B:9286 A9 80       LDA #$80               ;|
$8B:9288 85 76       STA $76    [$7E:0076]  ;/
$8B:928A A9 00       LDA #$00               ;\
$8B:928C 8D 33 21    STA $2133  [$7E:2133]  ;} Use standard NTSC resolution
$8B:928F 85 77       STA $77    [$7E:0077]  ;/
$8B:9291 C2 20       REP #$20
$8B:9293 A9 00 95    LDA #$9500             ;\
$8B:9296 85 48       STA $48    [$7E:0048]  ;|
$8B:9298 A9 D8 80    LDA #$80D8             ;|
$8B:929B 85 47       STA $47    [$7E:0047]  ;} Decompress title sprite tiles to $7F:5000
$8B:929D 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:92A1             dl 7F5000              ;/
$8B:92A4 E2 30       SEP #$30
$8B:92A6 A9 00       LDA #$00               ;\
$8B:92A8 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:92AB A9 60       LDA #$60               ;|
$8B:92AD 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:92B0 A9 80       LDA #$80               ;|
$8B:92B2 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $6000..7FFF = [$7F:5000..8FFF] (title sprite tiles)
$8B:92B5 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:92B9             dx 01,01,18,7F5000,4000;|
$8B:92C1 A9 02       LDA #$02               ;|
$8B:92C3 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:92C6 A9 80       LDA #$80               ;\
$8B:92C8 85 51       STA $51    [$7E:0051]  ;} Enable forced blank and zero brightness
$8B:92CA C2 30       REP #$30
$8B:92CC A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:92CF BF E9 E1 8C LDA $8CE1E9,x[$8C:E1E9];|
$8B:92D3 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$8B:92D7 E8          INX                    ;} Load title palettes
$8B:92D8 E8          INX                    ;|
$8B:92D9 E0 00 02    CPX #$0200             ;|
$8B:92DC 30 F1       BMI $F1    [$92CF]     ;/
$8B:92DE 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$8B:92E2 A9 01 00    LDA #$0001             ;\
$8B:92E5 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$8B:92E8 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade timer = 1

; LOOP_FADE_IN
$8B:92EB 22 1A 8B 80 JSL $808B1A[$80:8B1A]  ; Clear high OAM
$8B:92EF 9C 90 05    STZ $0590  [$7E:0590]  ; Clear OAM data offset
$8B:92F2 20 6B 93    JSR $936B  [$8B:936B]  ; Add 'Nintendo' logo spritemap to OAM
$8B:92F5 20 00 91    JSR $9100  [$8B:9100]  ; Advance fast screen fade in
$8B:92F8 B0 0A       BCS $0A    [$9304]     ; If not max brightness:
$8B:92FA 22 6E 89 80 JSL $80896E[$80:896E]  ; Finalise OAM
$8B:92FE 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$8B:9302 80 E7       BRA $E7    [$92EB]     ; Go to LOOP_FADE_IN

$8B:9304 22 6E 89 80 JSL $80896E[$80:896E]  ; Finalise OAM
$8B:9308 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$8B:930C A9 78 00    LDA #$0078             ;\
$8B:930F 8D E2 0D    STA $0DE2  [$7E:0DE2]  ;} Nintendo logo timer = 78h

; LOOP_NINTENDO_LOGO
$8B:9312 22 1A 8B 80 JSL $808B1A[$80:8B1A]  ; Clear high OAM
$8B:9316 9C 90 05    STZ $0590  [$7E:0590]  ; Clear OAM data offset
$8B:9319 20 6B 93    JSR $936B  [$8B:936B]  ; Add 'Nintendo' logo spritemap to OAM
$8B:931C CE E2 0D    DEC $0DE2  [$7E:0DE2]  ; Decrement Nintendo logo timer
$8B:931F F0 0A       BEQ $0A    [$932B]     ; If [Nintendo logo timer] != 0:
$8B:9321 22 6E 89 80 JSL $80896E[$80:896E]  ; Finalise OAM
$8B:9325 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$8B:9329 80 E7       BRA $E7    [$9312]     ; Go to LOOP_NINTENDO_LOGO

$8B:932B 22 6E 89 80 JSL $80896E[$80:896E]  ; Finalise OAM
$8B:932F 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$8B:9333 A9 01 00    LDA #$0001             ;\
$8B:9336 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$8B:9339 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade timer = 1

; LOOP_FADE_OUT
$8B:933C 22 1A 8B 80 JSL $808B1A[$80:8B1A]  ; Clear high OAM
$8B:9340 9C 90 05    STZ $0590  [$7E:0590]  ; Clear OAM data offset
$8B:9343 20 6B 93    JSR $936B  [$8B:936B]  ; Add 'Nintendo' logo spritemap to OAM
$8B:9346 20 B8 90    JSR $90B8  [$8B:90B8]  ; Advance fast screen fade out
$8B:9349 B0 0A       BCS $0A    [$9355]     ; If not reached zero brightness:
$8B:934B 22 6E 89 80 JSL $80896E[$80:896E]  ; Finalise OAM
$8B:934F 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$8B:9353 80 E7       BRA $E7    [$933C]     ; Go to LOOP_FADE_OUT

$8B:9355 22 6E 89 80 JSL $80896E[$80:896E]  ; Finalise OAM
$8B:9359 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$8B:935D E2 30       SEP #$30
$8B:935F A9 8F       LDA #$8F               ;\
$8B:9361 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank and max screen brightness
$8B:9364 85 51       STA $51    [$7E:0051]  ;/
$8B:9366 C2 30       REP #$30
$8B:9368 AB          PLB
$8B:9369 28          PLP
$8B:936A 6B          RTL
}


;;; $936B: Add Nintendo boot logo spritemap to OAM ;;;
{
$8B:936B 08          PHP
$8B:936C C2 30       REP #$30
$8B:936E 8B          PHB
$8B:936F F4 00 8C    PEA $8C00              ;\
$8B:9372 AB          PLB                    ;|
$8B:9373 AB          PLB                    ;} Spritemap address = $8C:80BB
$8B:9374 A0 BB 80    LDY #$80BB             ;/
$8B:9377 64 16       STZ $16    [$7E:0016]  ; Palette bits = 0
$8B:9379 A9 80 00    LDA #$0080             ;\
$8B:937C 85 14       STA $14    [$7E:0014]  ;} X position
$8B:937E A9 70 00    LDA #$0070             ;\
$8B:9381 85 12       STA $12    [$7E:0012]  ;} Y position
$8B:9383 22 9F 87 81 JSL $81879F[$81:879F]  ; Add spritemap to OAM
$8B:9387 AB          PLB
$8B:9388 28          PLP
$8B:9389 60          RTS
}


;;; $938A: Spawn cinematic sprite object [Y] ;;;
{
;; Parameters:
;;     A: Initialisation parameter(?)
;;     Y: Pointer to cinematic sprite object definition
$8B:938A 08          PHP
$8B:938B C2 30       REP #$30
$8B:938D DA          PHX
$8B:938E 8D 9D 1B    STA $1B9D  [$7E:1B9D]  ; $1B9D = [A]
$8B:9391 BB          TYX                    ; X = [Y]
$8B:9392 A0 1E 00    LDY #$001E             ; Y = 1Eh

; LOOP
$8B:9395 B9 1D 1B    LDA $1B1D,y[$7E:1B3B]  ;\
$8B:9398 F0 12       BEQ $12    [$93AC]     ;} If [cinematic sprite object instruction list pointer] = 0: go to spawn cinematic sprite object [X] to index [Y]
$8B:939A 88          DEY                    ;\
$8B:939B 88          DEY                    ;} Y -= 2
$8B:939C 10 F7       BPL $F7    [$9395]     ; If [Y] >= 0: go to LOOP
$8B:939E FA          PLX
$8B:939F 28          PLP
$8B:93A0 38          SEC                    ;\
$8B:93A1 60          RTS                    ;} Return carry set
}


;;; $93A2: Spawn cinematic sprite object [Y] to index [$12] ;;;
{
$8B:93A2 08          PHP
$8B:93A3 C2 30       REP #$30
$8B:93A5 DA          PHX
$8B:93A6 8D 9D 1B    STA $1B9D  [$7E:1B9D]  ; $1B9D = [A]
$8B:93A9 BB          TYX                    ; X = [Y]
$8B:93AA A4 12       LDY $12    [$7E:0012]  ; Y = [$12]
}


;;; $93AC: Spawn cinematic sprite object [X] to index [Y] ;;;
{
;; Parameters:
;;     X: Pointer to cinematic sprite object definition
;;     Y: Cinematic sprite object index
$8B:93AC C2 30       REP #$30
$8B:93AE BD 02 00    LDA $0002,x[$8B:A0F1]  ;\
$8B:93B1 99 3D 1B    STA $1B3D,y[$7E:1B5B]  ;} Cinematic sprite object pre-instruction = [[X] + 2]
$8B:93B4 BD 04 00    LDA $0004,x[$8B:A0F3]  ;\
$8B:93B7 99 1D 1B    STA $1B1D,y[$7E:1B3B]  ;} Cinematic sprite object instruction list pointer = [[X] + 4]
$8B:93BA A9 01 00    LDA #$0001             ;\
$8B:93BD 99 5D 1B    STA $1B5D,y[$7E:1B7B]  ;} Cinematic sprite object instruction timer = 1
$8B:93C0 A9 00 00    LDA #$0000             ;\
$8B:93C3 99 5D 1A    STA $1A5D,y[$7E:1A7B]  ;} Cinematic sprite object spritemap pointer = 0
$8B:93C6 A9 00 00    LDA #$0000             ;\
$8B:93C9 99 7D 1B    STA $1B7D,y[$7E:1B9B]  ;} Cinematic sprite object timer = 0
$8B:93CC 99 DD 1A    STA $1ADD,y[$7E:1AFB]  ; Cinematic sprite object $1ADD = 0
$8B:93CF 99 FD 1A    STA $1AFD,y[$7E:1B1B]  ; Cinematic sprite object $1AFD = 0
$8B:93D2 FC 00 00    JSR ($0000,x)[$8B:9CBC]; Execute [[X]]
$8B:93D5 FA          PLX
$8B:93D6 28          PLP
$8B:93D7 18          CLC                    ;\
$8B:93D8 60          RTS                    ;} Return carry clear
}


;;; $93D9: RTS ;;;
{
$8B:93D9 60          RTS
}


;;; $93DA: Clear cinematic sprite objects ;;;
{
$8B:93DA 08          PHP
$8B:93DB C2 30       REP #$30
$8B:93DD A2 1E 00    LDX #$001E
$8B:93E0 A9 00 00    LDA #$0000

$8B:93E3 9D 1D 1B    STA $1B1D,x[$7E:1B3B]
$8B:93E6 9D 5D 1A    STA $1A5D,x[$7E:1A7B]
$8B:93E9 CA          DEX
$8B:93EA CA          DEX
$8B:93EB 10 F6       BPL $F6    [$93E3]
$8B:93ED 28          PLP
$8B:93EE 60          RTS
}


;;; $93EF: Handle cinematic sprite objects ;;;
{
$8B:93EF 08          PHP
$8B:93F0 C2 30       REP #$30
$8B:93F2 A2 1E 00    LDX #$001E             ; X = 1Eh

; LOOP
$8B:93F5 8E 59 1A    STX $1A59  [$7E:1A59]  ; Cinematic sprite object index = [X]
$8B:93F8 BD 1D 1B    LDA $1B1D,x[$7E:1B3B]  ;\
$8B:93FB F0 06       BEQ $06    [$9403]     ;} If [cinematic sprite object instruction list pointer] != 0:
$8B:93FD 20 09 94    JSR $9409  [$8B:9409]  ; Process cinematic sprite object instruction list
$8B:9400 AE 59 1A    LDX $1A59  [$7E:1A59]

$8B:9403 CA          DEX                    ;\
$8B:9404 CA          DEX                    ;} X -= 2
$8B:9405 10 EE       BPL $EE    [$93F5]     ; If [X] >= 0: go to LOOP
$8B:9407 28          PLP
$8B:9408 60          RTS
}


;;; $9409: Process cinematic sprite object instruction list ;;;
{
;; Parameters:
;;     X: Cinematic sprite object index
$8B:9409 FC 3D 1B    JSR ($1B3D,x)[$8B:9CCF]; Execute [cinematic sprite object pre-instruction]
$8B:940C AE 59 1A    LDX $1A59  [$7E:1A59]
$8B:940F DE 5D 1B    DEC $1B5D,x[$7E:1B7B]  ; Decrement cinematic sprite object instruction timer
$8B:9412 D0 23       BNE $23    [$9437]     ; If [cinematic sprite object instruction timer] != 0: return
$8B:9414 BC 1D 1B    LDY $1B1D,x[$7E:1B3B]  ; Y = [cinematic sprite object instruction list pointer]

; LOOP
$8B:9417 B9 00 00    LDA $0000,y[$8B:A03D]  ;\
$8B:941A 10 0A       BPL $0A    [$9426]     ;} If [[Y]] & 8000h != 0:
$8B:941C 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]]
$8B:941E C8          INY                    ;\
$8B:941F C8          INY                    ;} Y += 2
$8B:9420 F4 16 94    PEA $9416              ;\
$8B:9423 6C 12 00    JMP ($0012)[$8B:9CE1]  ;} Execute [$12] and return to LOOP

$8B:9426 9D 5D 1B    STA $1B5D,x[$7E:1B7B]  ; Cinematic sprite object instruction timer = [[Y]]
$8B:9429 B9 02 00    LDA $0002,y[$8B:A03F]  ;\
$8B:942C 9D 5D 1A    STA $1A5D,x[$7E:1A7B]  ;} Cinematic sprite object spritemap pointer = [[Y] + 2]
$8B:942F 98          TYA                    ;\
$8B:9430 18          CLC                    ;|
$8B:9431 69 04 00    ADC #$0004             ;} Cinematic sprite object instruction list pointer = [Y] + 4
$8B:9434 9D 1D 1B    STA $1B1D,x[$7E:1B3B]  ;/

$8B:9437 60          RTS
}


;;; $9438..94E0: Cinematic sprite object instructions ;;;
{
;;; $9438: Instruction - delete ;;;
{
$8B:9438 C2 30       REP #$30
$8B:943A 9E 5D 1A    STZ $1A5D,x[$7E:1A7B]
$8B:943D 9E 1D 1B    STZ $1B1D,x[$7E:1B3B]
$8B:9440 68          PLA
$8B:9441 60          RTS
}


;;; $9442: Unused. Instruction - sleep ;;;
{
$8B:9442 C2 30       REP #$30
$8B:9444 88          DEY
$8B:9445 88          DEY
$8B:9446 98          TYA
$8B:9447 9D 1D 1B    STA $1B1D,x
$8B:944A 68          PLA
$8B:944B 60          RTS
}


;;; $944C: Instruction - pre-instruction = [[Y]] ;;;
{
$8B:944C C2 30       REP #$30
$8B:944E B9 00 00    LDA $0000,y[$8B:CB1D]
$8B:9451 9D 3D 1B    STA $1B3D,x[$7E:1B3D]
$8B:9454 C8          INY
$8B:9455 C8          INY
$8B:9456 60          RTS
}


;;; $9457: Unused. Instruction - clear pre-instruction ;;;
{
$8B:9457 C2 30       REP #$30
$8B:9459 A9 5F 94    LDA #$945F
$8B:945C 9D 3D 1B    STA $1B3D,x
$8B:945F 60          RTS
}


;;; $9460: Unused. Instruction - call external function [[Y]] ;;;
{
$8B:9460 C2 30       REP #$30
$8B:9462 B9 00 00    LDA $0000,y
$8B:9465 8D 12 00    STA $0012  [$7E:0012]
$8B:9468 B9 01 00    LDA $0001,y
$8B:946B 8D 13 00    STA $0013  [$7E:0013]
$8B:946E 5A          PHY
$8B:946F 22 7B 94 8B JSL $8B947B[$8B:947B]
$8B:9473 7A          PLY
$8B:9474 AE 59 1A    LDX $1A59  [$7E:1A59]
$8B:9477 C8          INY
$8B:9478 C8          INY
$8B:9479 C8          INY
$8B:947A 60          RTS

$8B:947B DC 12 00    JML [$0012]
}


;;; $947E: Unused. Instruction - call external function [[Y]] with A = [[Y] + 3] ;;;
{
$8B:947E C2 30       REP #$30
$8B:9480 B9 00 00    LDA $0000,y
$8B:9483 8D 12 00    STA $0012  [$7E:0012]
$8B:9486 B9 01 00    LDA $0001,y
$8B:9489 8D 13 00    STA $0013  [$7E:0013]
$8B:948C B9 03 00    LDA $0003,y
$8B:948F 5A          PHY
$8B:9490 22 9F 94 8B JSL $8B949F[$8B:949F]
$8B:9494 7A          PLY
$8B:9495 AE 59 1A    LDX $1A59  [$7E:1A59]
$8B:9498 98          TYA
$8B:9499 18          CLC
$8B:949A 69 05 00    ADC #$0005
$8B:949D A8          TAY
$8B:949E 60          RTS

$8B:949F DC 12 00    JML [$0012]
}


;;; $94A2: Unused. Instruction - go to [Y] + ±[[Y]] ;;;
{
$8B:94A2 C2 30       REP #$30
$8B:94A4 8C 12 00    STY $0012  [$7E:0012]
$8B:94A7 88          DEY
$8B:94A8 B9 00 00    LDA $0000,y
$8B:94AB EB          XBA
$8B:94AC 30 05       BMI $05    [$94B3]
$8B:94AE 29 FF 00    AND #$00FF
$8B:94B1 80 03       BRA $03    [$94B6]

$8B:94B3 09 00 FF    ORA #$FF00

$8B:94B6 18          CLC
$8B:94B7 6D 12 00    ADC $0012  [$7E:0012]
$8B:94BA A8          TAY
$8B:94BB 60          RTS
}


;;; $94BC: Instruction - go to [[Y]] ;;;
{
$8B:94BC C2 30       REP #$30
$8B:94BE B9 00 00    LDA $0000,y[$8B:A0D1]
$8B:94C1 A8          TAY
$8B:94C2 60          RTS
}


;;; $94C3: Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
$8B:94C3 C2 30       REP #$30
$8B:94C5 DE 7D 1B    DEC $1B7D,x[$7E:1B99]
$8B:94C8 D0 F2       BNE $F2    [$94BC]
$8B:94CA C8          INY
$8B:94CB C8          INY
$8B:94CC 60          RTS
}


;;; $94CD: Unused. Instruction - decrement timer and go to [Y] + ±[[Y]] if non-zero ;;;
{
$8B:94CD C2 30       REP #$30
$8B:94CF DE 7D 1B    DEC $1B7D,x
$8B:94D2 D0 CE       BNE $CE    [$94A2]
$8B:94D4 C8          INY
$8B:94D5 60          RTS
}


;;; $94D6: Instruction - timer = [[Y]] ;;;
{
$8B:94D6 C2 30       REP #$30
$8B:94D8 B9 00 00    LDA $0000,y[$8B:CB41]
$8B:94DB 9D 7D 1B    STA $1B7D,x[$7E:1B99]
$8B:94DE C8          INY
$8B:94DF C8          INY
$8B:94E0 60          RTS
}
}


;;; $94E1: RTS ;;;
{
$8B:94E1 C2 30       REP #$30
$8B:94E3 60          RTS
}


;;; $94E4: Spawn mode 7 object ;;;
{
;; Parameters:
;;     A: Initialisation parameter. Never actually used by anything
;;     Y: Pointer to mode 7 object definition
$8B:94E4 08          PHP
$8B:94E5 C2 30       REP #$30
$8B:94E7 DA          PHX
$8B:94E8 8D B3 19    STA $19B3  [$7E:19B3]  ; Mode 7 object initialisation parameter = [A]
$8B:94EB BB          TYX                    ; X = [Y]
$8B:94EC A0 02 00    LDY #$0002             ; Y = 2 (mode 7 object index)

; LOOP
$8B:94EF B9 A1 19    LDA $19A1,y[$7E:19A3]  ;\
$8B:94F2 F0 08       BEQ $08    [$94FC]     ;} If [mode 7 object instruction list pointer] != 0:
$8B:94F4 88          DEY                    ;\
$8B:94F5 88          DEY                    ;} Y -= 2
$8B:94F6 10 F7       BPL $F7    [$94EF]     ; If [Y] >= 0: go to LOOP
$8B:94F8 FA          PLX
$8B:94F9 28          PLP
$8B:94FA 38          SEC                    ;\
$8B:94FB 60          RTS                    ;} Return carry set

$8B:94FC C2 30       REP #$30
$8B:94FE BD 02 00    LDA $0002,x[$8B:A357]  ;\
$8B:9501 99 A5 19    STA $19A5,y[$7E:19A7]  ;} Mode 7 object pre-instruction = [[X] + 2]
$8B:9504 BD 04 00    LDA $0004,x[$8B:A359]  ;\
$8B:9507 99 A1 19    STA $19A1,y[$7E:19A3]  ;} Mode 7 object instruction list pointer = [[X] + 4]
$8B:950A A9 01 00    LDA #$0001             ;\
$8B:950D 99 A9 19    STA $19A9,y[$7E:19AB]  ;} Mode 7 object instruction timer = 1
$8B:9510 A9 00 00    LDA #$0000             ;\
$8B:9513 99 AD 19    STA $19AD,y[$7E:19AF]  ;} Mode 7 object timer = 0
$8B:9516 FC 00 00    JSR ($0000,x)[$8B:93D9]; Execute [[X]]
$8B:9519 FA          PLX
$8B:951A 28          PLP
$8B:951B 18          CLC                    ;\
$8B:951C 60          RTS                    ;} Return carry clear
}


;;; $951D: Handle mode 7 objects ;;;
{
$8B:951D 08          PHP
$8B:951E C2 30       REP #$30
$8B:9520 A2 02 00    LDX #$0002             ; X = 2

; LOOP
$8B:9523 8E B1 19    STX $19B1  [$7E:19B1]  ; Mode 7 object index = [X]
$8B:9526 BD A1 19    LDA $19A1,x[$7E:19A3]  ;\
$8B:9529 F0 06       BEQ $06    [$9531]     ;} If [mode 7 object instruction list pointer] != 0:
$8B:952B 20 37 95    JSR $9537  [$8B:9537]  ; Process mode 7 object instruction list
$8B:952E AE B1 19    LDX $19B1  [$7E:19B1]

$8B:9531 CA          DEX                    ;\
$8B:9532 CA          DEX                    ;} X -= 2
$8B:9533 10 EE       BPL $EE    [$9523]     ; If [X] >= 0: go to LOOP
$8B:9535 28          PLP
$8B:9536 60          RTS
}


;;; $9537: Process mode 7 object instruction list ;;;
{
;; Parameters:
;;     X: Mode 7 object index
$8B:9537 FC A5 19    JSR ($19A5,x)[$8B:93D9]; Execute [mode 7 object pre-instruction]
$8B:953A AE B1 19    LDX $19B1  [$7E:19B1]
$8B:953D DE A9 19    DEC $19A9,x[$7E:19AB]  ; Decrement mode 7 object instruction timer
$8B:9540 D0 28       BNE $28    [$956A]     ; If [mode 7 object instruction timer] != 0: return
$8B:9542 BC A1 19    LDY $19A1,x[$7E:19A3]  ; Y = [mode 7 object instruction list pointer]

; LOOP
$8B:9545 B9 00 00    LDA $0000,y[$8B:A12B]  ;\
$8B:9548 10 0A       BPL $0A    [$9554]     ;} If [[Y]] & 8000h != 0:
$8B:954A 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]]
$8B:954C C8          INY                    ;\
$8B:954D C8          INY                    ;} Y += 2
$8B:954E F4 44 95    PEA $9544              ;\
$8B:9551 6C 12 00    JMP ($0012)[$8B:A273]  ;} Execute [$12] and return to LOOP

$8B:9554 9D A9 19    STA $19A9,x[$7E:19AB]  ; Mode 7 object instruction timer = [[Y]]
$8B:9557 5A          PHY
$8B:9558 DA          PHX
$8B:9559 BE 02 00    LDX $0002,y[$8B:A133]  ; X = [[Y] + 2]
$8B:955C 22 4F 8B 80 JSL $808B4F[$80:8B4F]  ; Queue mode 7 transfers
$8B:9560 FA          PLX
$8B:9561 7A          PLY
$8B:9562 98          TYA                    ;\
$8B:9563 18          CLC                    ;|
$8B:9564 69 04 00    ADC #$0004             ;} Mode 7 object instruction list pointer = [Y] + 4
$8B:9567 9D A1 19    STA $19A1,x[$7E:19A3]  ;/

$8B:956A 60          RTS
}


;;; $956B..95A1: Mode 7 object instructions ;;;
{
;;; $956B: Instruction - delete ;;;
{
$8B:956B C2 30       REP #$30
$8B:956D 9E A1 19    STZ $19A1,x
$8B:9570 68          PLA
$8B:9571 60          RTS
}


;;; $9572: Instruction - pre-instruction = [[Y]] ;;;
{
$8B:9572 C2 30       REP #$30
$8B:9574 B9 00 00    LDA $0000,y
$8B:9577 9D A5 19    STA $19A5,x
$8B:957A C8          INY
$8B:957B C8          INY
$8B:957C 60          RTS
}


;;; $957D: Instruction - clear pre-instruction ;;;
{
$8B:957D C2 30       REP #$30
$8B:957F A9 85 95    LDA #$9585
$8B:9582 9D A5 19    STA $19A5,x
$8B:9585 60          RTS
}


;;; $9586: Instruction - go to [[Y]] ;;;
{
$8B:9586 C2 30       REP #$30
$8B:9588 B9 00 00    LDA $0000,y[$8B:A143]
$8B:958B A8          TAY
$8B:958C 60          RTS
}


;;; $958D: Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
$8B:958D C2 30       REP #$30
$8B:958F DE AD 19    DEC $19AD,x[$7E:19AF]
$8B:9592 D0 F2       BNE $F2    [$9586]
$8B:9594 C8          INY
$8B:9595 C8          INY
$8B:9596 60          RTS
}


;;; $9597: Instruction - timer = [[Y]] ;;;
{
$8B:9597 C2 30       REP #$30
$8B:9599 B9 00 00    LDA $0000,y[$8B:A12F]
$8B:959C 9D AD 19    STA $19AD,x[$7E:19AF]
$8B:959F C8          INY
$8B:95A0 C8          INY
$8B:95A1 60          RTS
}
}


;;; $95A2: Enable cinematic BG objects ;;;
{
$8B:95A2 08          PHP
$8B:95A3 C2 30       REP #$30
$8B:95A5 A9 00 80    LDA #$8000
$8B:95A8 0C F1 19    TSB $19F1  [$7E:19F1]
$8B:95AB 28          PLP
$8B:95AC 6B          RTL
}


;;; $95AD: Disable cinematic BG objects ;;;
{
$8B:95AD 08          PHP
$8B:95AE C2 30       REP #$30
$8B:95B0 A9 00 80    LDA #$8000
$8B:95B3 1C F1 19    TRB $19F1  [$7E:19F1]
$8B:95B6 28          PLP
$8B:95B7 6B          RTL
}


;;; $95B8: Enable cinematic BG tilemap updates ;;;
{
$8B:95B8 08          PHP
$8B:95B9 C2 30       REP #$30
$8B:95BB A9 00 80    LDA #$8000
$8B:95BE 0C F3 19    TSB $19F3  [$7E:19F3]
$8B:95C1 28          PLP
$8B:95C2 6B          RTL
}


;;; $95C3: Disable cinematic BG tilemap updates ;;;
{
$8B:95C3 08          PHP
$8B:95C4 C2 30       REP #$30
$8B:95C6 A9 00 80    LDA #$8000
$8B:95C9 1C F3 19    TRB $19F3  [$7E:19F3]
$8B:95CC 28          PLP
$8B:95CD 6B          RTL
}


;;; $95CE: Clear cinematic BG objects, cinematic BG tilemap = [A] ;;;
{
$8B:95CE 08          PHP
$8B:95CF C2 30       REP #$30
$8B:95D1 DA          PHX
$8B:95D2 A2 FE 07    LDX #$07FE

$8B:95D5 9F 00 30 7E STA $7E3000,x[$7E:37FE]
$8B:95D9 CA          DEX
$8B:95DA CA          DEX
$8B:95DB 10 F8       BPL $F8    [$95D5]
$8B:95DD A2 06 00    LDX #$0006

$8B:95E0 9E B5 19    STZ $19B5,x[$7E:19BB]
$8B:95E3 9E CD 19    STZ $19CD,x[$7E:19D3]
$8B:95E6 CA          DEX
$8B:95E7 CA          DEX
$8B:95E8 10 F6       BPL $F6    [$95E0]
$8B:95EA 9C A1 1B    STZ $1BA1  [$7E:1BA1]
$8B:95ED FA          PLX
$8B:95EE 28          PLP
$8B:95EF 6B          RTL
}


;;; $95F0: Spawn cinematic BG object ;;;
{
$8B:95F0 08          PHP
$8B:95F1 C2 30       REP #$30
$8B:95F3 DA          PHX
$8B:95F4 8D F5 19    STA $19F5  [$7E:19F5]  ; Cinematic BG VRAM address = [A]
$8B:95F7 BB          TYX                    ; X = [Y]
$8B:95F8 A0 06 00    LDY #$0006             ; Y = 6 (cinematic BG object index)

; LOOP
$8B:95FB B9 CD 19    LDA $19CD,y[$7E:19D3]  ;\
$8B:95FE F0 08       BEQ $08    [$9608]     ;} If [cinematic BG object instruction list pointer] != 0:
$8B:9600 88          DEY                    ;\
$8B:9601 88          DEY                    ;} Y -= 2
$8B:9602 10 F7       BPL $F7    [$95FB]     ; If [Y] >= 0: go to LOOP
$8B:9604 FA          PLX
$8B:9605 28          PLP
$8B:9606 38          SEC                    ;\
$8B:9607 60          RTS                    ;} Return carry set

$8B:9608 C2 30       REP #$30
$8B:960A BD 02 00    LDA $0002,x[$8B:CF65]  ;\
$8B:960D 99 D5 19    STA $19D5,y[$7E:19DB]  ;} Cinematic BG object pre-instruction = [[X] + 2]
$8B:9610 BD 04 00    LDA $0004,x[$8B:CF67]  ;\
$8B:9613 99 CD 19    STA $19CD,y[$7E:19D3]  ;} Cinematic BG object instruction list pointer = [[X] + 4]
$8B:9616 A9 01 00    LDA #$0001             ;\
$8B:9619 99 DD 19    STA $19DD,y[$7E:19E3]  ;} Cinematic BG object instruction timer = 1
$8B:961C A9 00 00    LDA #$0000             ;\
$8B:961F 99 B5 19    STA $19B5,y[$7E:19BB]  ;} Cinematic BG object indirect instruction pointer = 0
$8B:9622 A9 00 00    LDA #$0000             ;\
$8B:9625 99 E5 19    STA $19E5,y[$7E:19EB]  ;} Cinematic BG object timer = 0
$8B:9628 FC 00 00    JSR ($0000,x)[$8B:93D9]; Execute [[X]]
$8B:962B FA          PLX
$8B:962C 28          PLP
$8B:962D 18          CLC                    ;\
$8B:962E 60          RTS                    ;} Return carry clear
}


;;; $962F: Handle cinematic BG objects ;;;
{
$8B:962F 08          PHP
$8B:9630 C2 30       REP #$30
$8B:9632 2C F1 19    BIT $19F1  [$7E:19F1]  ;\
$8B:9635 10 20       BPL $20    [$9657]     ;} If cinematic BG objects not enabled: return
$8B:9637 A2 06 00    LDX #$0006             ; X = 6

; LOOP
$8B:963A 8E ED 19    STX $19ED  [$7E:19ED]  ; Cinematic BG object index = [X]
$8B:963D BD CD 19    LDA $19CD,x[$7E:19D3]  ;\
$8B:9640 F0 06       BEQ $06    [$9648]     ;} If [object instruction list pointer] != 0:
$8B:9642 20 59 96    JSR $9659  [$8B:9659]  ; Process cinematic BG object instruction list
$8B:9645 AE ED 19    LDX $19ED  [$7E:19ED]

$8B:9648 CA          DEX                    ;\
$8B:9649 CA          DEX                    ;} X -= 2
$8B:964A 10 EE       BPL $EE    [$963A]     ; If [X] >= 0: go to LOOP
$8B:964C 2C F3 19    BIT $19F3  [$7E:19F3]  ;\
$8B:964F 10 03       BPL $03    [$9654]     ;} If [BG tilemap update flag] & 8000h != 0:
$8B:9651 20 A0 87    JSR $87A0  [$8B:87A0]  ; Update cinematic BG tilemap

$8B:9654 20 D3 87    JSR $87D3  [$8B:87D3]  ; Update Samus eyes tilemap

$8B:9657 28          PLP
$8B:9658 60          RTS
}


;;; $9659: Process cinematic BG object instruction list ;;;
{
$8B:9659 FC D5 19    JSR ($19D5,x)[$8B:B4BC]; Execute [cinematic BG object pre-instruction]
$8B:965C 8B          PHB
$8B:965D F4 00 8C    PEA $8C00              ;\
$8B:9660 AB          PLB                    ;} DB = $8C
$8B:9661 AB          PLB                    ;/
$8B:9662 AE ED 19    LDX $19ED  [$7E:19ED]
$8B:9665 DE DD 19    DEC $19DD,x[$7E:19E3]  ; Decrement cinematic BG object instruction timer
$8B:9668 D0 2C       BNE $2C    [$9696]     ; If [cinematic BG object instruction timer] != 0: return
$8B:966A BC CD 19    LDY $19CD,x[$7E:19D3]  ; Y = [cinematic BG object instruction list pointer]

; LOOP
$8B:966D B9 00 00    LDA $0000,y[$8C:D5DF]  ;\
$8B:9670 10 0A       BPL $0A    [$967C]     ;} If [[Y]] & 8000h != 0:
$8B:9672 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]]
$8B:9674 C8          INY                    ;\
$8B:9675 C8          INY                    ;} Y += 2
$8B:9676 F4 6C 96    PEA $966C              ;\
$8B:9679 6C 12 00    JMP ($0012)[$8B:AE43]  ;} Execute [$12] and return to LOOP

$8B:967C 9D DD 19    STA $19DD,x[$7E:19E3]  ; Cinematic BG object instruction timer = [[Y]]
$8B:967F B9 02 00    LDA $0002,y[$8C:D5E1]  ;\
$8B:9682 8D 12 00    STA $0012  [$7E:0012]  ;} $12 = [[Y] + 2]
$8B:9685 B9 04 00    LDA $0004,y[$8C:D5E3]  ;\
$8B:9688 9D B5 19    STA $19B5,x[$7E:19BB]  ;} Cinematic BG object indirect instruction pointer = [[Y] + 4]
$8B:968B 20 39 88    JSR $8839  [$8B:8839]  ; Process cinematic BG object indirect instruction
$8B:968E 98          TYA                    ;\
$8B:968F 18          CLC                    ;|
$8B:9690 69 06 00    ADC #$0006             ;} Cinematic BG object instruction list pointer = [Y] + 6
$8B:9693 9D CD 19    STA $19CD,x[$7E:19D3]  ;/

$8B:9696 AB          PLB
$8B:9697 60          RTS
}


;;; $9698..9742: Cinematic BG object instructions ;;;
{
;;; $9698: Instruction - delete ;;;
{
$8B:9698 C2 30       REP #$30
$8B:969A 9E B5 19    STZ $19B5,x[$7E:19B9]
$8B:969D 9E CD 19    STZ $19CD,x[$7E:19D1]
$8B:96A0 68          PLA
$8B:96A1 AB          PLB
$8B:96A2 60          RTS
}


;;; $96A3: Unused. Instruction - sleep ;;;
{
$8B:96A3 C2 30       REP #$30
$8B:96A5 88          DEY
$8B:96A6 88          DEY
$8B:96A7 98          TYA
$8B:96A8 9D CD 19    STA $19CD,x
$8B:96AB 68          PLA
$8B:96AC AB          PLB
$8B:96AD 60          RTS
}


;;; $96AE: Unused. Instruction - pre-instruction = [[Y]] ;;;
{
$8B:96AE C2 30       REP #$30
$8B:96B0 B9 00 00    LDA $0000,y
$8B:96B3 9D D5 19    STA $19D5,x
$8B:96B6 C8          INY
$8B:96B7 C8          INY
$8B:96B8 60          RTS
}


;;; $96B9: Unused. Instruction - clear pre-instruction ;;;
{
$8B:96B9 C2 30       REP #$30
$8B:96BB A9 C1 96    LDA #$96C1
$8B:96BE 9D D5 19    STA $19D5,x
$8B:96C1 60          RTS
}


;;; $96C2: Unused. Instruction - call external function [[Y]] ;;;
{
$8B:96C2 C2 30       REP #$30
$8B:96C4 B9 00 00    LDA $0000,y
$8B:96C7 8D 12 00    STA $0012  [$7E:0012]
$8B:96CA B9 01 00    LDA $0001,y
$8B:96CD 8D 13 00    STA $0013  [$7E:0013]
$8B:96D0 5A          PHY
$8B:96D1 22 DD 96 8B JSL $8B96DD[$8B:96DD]
$8B:96D5 7A          PLY
$8B:96D6 AE ED 19    LDX $19ED  [$7E:19ED]
$8B:96D9 C8          INY
$8B:96DA C8          INY
$8B:96DB C8          INY
$8B:96DC 60          RTS

$8B:96DD DC 12 00    JML [$0012]
}


;;; $96E0: Unused. Instruction - call external function [[Y]] with A = [[Y] + 3] ;;;
{
$8B:96E0 C2 30       REP #$30
$8B:96E2 B9 00 00    LDA $0000,y
$8B:96E5 8D 12 00    STA $0012  [$7E:0012]
$8B:96E8 B9 01 00    LDA $0001,y
$8B:96EB 8D 13 00    STA $0013  [$7E:0013]
$8B:96EE B9 03 00    LDA $0003,y
$8B:96F1 5A          PHY
$8B:96F2 22 01 97 8B JSL $8B9701[$8B:9701]
$8B:96F6 7A          PLY
$8B:96F7 AE ED 19    LDX $19ED  [$7E:19ED]
$8B:96FA 98          TYA
$8B:96FB 18          CLC
$8B:96FC 69 05 00    ADC #$0005
$8B:96FF A8          TAY
$8B:9700 60          RTS

$8B:9701 DC 12 00    JML [$0012]
}


;;; $9704: Unused. Instruction - go to [Y] + ±[[Y]] ;;;
{
$8B:9704 C2 30       REP #$30
$8B:9706 8C 12 00    STY $0012  [$7E:0012]
$8B:9709 88          DEY
$8B:970A B9 00 00    LDA $0000,y
$8B:970D EB          XBA
$8B:970E 30 05       BMI $05    [$9715]
$8B:9710 29 FF 00    AND #$00FF
$8B:9713 80 03       BRA $03    [$9718]

$8B:9715 09 00 FF    ORA #$FF00

$8B:9718 18          CLC
$8B:9719 6D 12 00    ADC $0012  [$7E:0012]
$8B:971C A8          TAY
$8B:971D 60          RTS
}


;;; $971E: Instruction - go to [[Y]] ;;;
{
$8B:971E C2 30       REP #$30
$8B:9720 B9 00 00    LDA $0000,y[$8C:D611]
$8B:9723 A8          TAY
$8B:9724 60          RTS
}


;;; $9725: Unused. Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
$8B:9725 C2 30       REP #$30
$8B:9727 DE E5 19    DEC $19E5,x
$8B:972A D0 F2       BNE $F2    [$971E]
$8B:972C C8          INY
$8B:972D C8          INY
$8B:972E 60          RTS
}


;;; $972F: Unused. Instruction - decrement timer and go to [Y] + ±[[Y]] if non-zero ;;;
{
$8B:972F C2 30       REP #$30
$8B:9731 DE E5 19    DEC $19E5,x
$8B:9734 D0 CE       BNE $CE    [$9704]
$8B:9736 C8          INY
$8B:9737 60          RTS
}


;;; $9738: Unused. Instruction - timer = [[Y]] ;;;
{
$8B:9738 C2 30       REP #$30
$8B:973A B9 00 00    LDA $0000,y
$8B:973D 9D E5 19    STA $19E5,x
$8B:9740 C8          INY
$8B:9741 C8          INY
$8B:9742 60          RTS
}
}


;;; $9743: RTS ;;;
{
$8B:9743 C2 30       REP #$30
$8B:9745 60          RTS
}


;;; $9746: Draw cinematic sprite objects - intro/opening ;;;
{
$8B:9746 08          PHP
$8B:9747 C2 30       REP #$30
$8B:9749 8B          PHB
$8B:974A A2 1E 00    LDX #$001E             ; X = 1Eh (cinematic sprite object index)

; LOOP
$8B:974D BD 5D 1A    LDA $1A5D,x[$7E:1A7B]  ;\
$8B:9750 F0 40       BEQ $40    [$9792]     ;} If [cinematic sprite object spritemap pointer] = 0: go to BRANCH_NEXT
$8B:9752 F4 00 8C    PEA $8C00              ;\
$8B:9755 AB          PLB                    ;} DB = $8C
$8B:9756 AB          PLB                    ;/
$8B:9757 BC 5D 1A    LDY $1A5D,x[$7E:1A7B]  ; Y = [cinematic sprite object spritemap pointer]
$8B:975A BD BD 1A    LDA $1ABD,x[$7E:1ADB]  ;\
$8B:975D 85 16       STA $16    [$7E:0016]  ;} $16 = [cinematic sprite object palette index]
$8B:975F BD 7D 1A    LDA $1A7D,x[$7E:1A9B]  ;\
$8B:9762 38          SEC                    ;|
$8B:9763 ED 11 09    SBC $0911  [$7E:0911]  ;} $14 = [cinematic sprite object X position] - [layer 1 X position]
$8B:9766 85 14       STA $14    [$7E:0014]  ;/
$8B:9768 BD 9D 1A    LDA $1A9D,x[$7E:1ABB]  ;\
$8B:976B 38          SEC                    ;|
$8B:976C ED 15 09    SBC $0915  [$7E:0915]  ;} $12 = [cinematic sprite object Y position] - [layer 1 Y position]
$8B:976F 85 12       STA $12    [$7E:0012]  ;/
$8B:9771 89 00 FF    BIT #$FF00             ;\
$8B:9774 D0 0F       BNE $0F    [$9785]     ;} If 0 <= [$12] < 100h:
$8B:9776 18          CLC                    ;\
$8B:9777 69 80 00    ADC #$0080             ;|
$8B:977A C9 FF 01    CMP #$01FF             ;} If -80h <= [$12] < 17Fh: (redundant check)
$8B:977D B0 13       BCS $13    [$9792]     ;/
$8B:977F 22 9F 87 81 JSL $81879F[$81:879F]  ; Add spritemap to OAM
$8B:9783 80 0D       BRA $0D    [$9792]

$8B:9785 18          CLC                    ;\ Else (not 0 <= [$12] < 100h):
$8B:9786 69 80 00    ADC #$0080             ;|
$8B:9789 C9 FF 01    CMP #$01FF             ;} If -80h <= [$12] < 17Fh:
$8B:978C B0 04       BCS $04    [$9792]     ;/
$8B:978E 22 53 88 81 JSL $818853[$81:8853]  ; Add spritemap to OAM off-screen

; BRANCH_NEXT
$8B:9792 CA          DEX                    ;\
$8B:9793 CA          DEX                    ;} X -= 2
$8B:9794 10 B7       BPL $B7    [$974D]     ; If [X] >= 0: go to LOOP
$8B:9796 AB          PLB
$8B:9797 28          PLP
$8B:9798 60          RTS
}


;;; $9799: Draw cinematic sprite objects - ending/credits ;;;
{
$8B:9799 08          PHP
$8B:979A C2 30       REP #$30
$8B:979C 8B          PHB
$8B:979D A2 1E 00    LDX #$001E             ; X = 1Eh (cinematic sprite object index)

; LOOP
$8B:97A0 BD 5D 1A    LDA $1A5D,x[$7E:1A7B]  ;\
$8B:97A3 F0 40       BEQ $40    [$97E5]     ;} If [cinematic sprite object spritemap pointer] = 0: go to BRANCH_NEXT
$8B:97A5 F4 00 8C    PEA $8C00              ;\
$8B:97A8 AB          PLB                    ;} DB = $8C
$8B:97A9 AB          PLB                    ;/
$8B:97AA BC 5D 1A    LDY $1A5D,x[$7E:1A7B]  ; Y = [cinematic sprite object spritemap pointer]
$8B:97AD BD BD 1A    LDA $1ABD,x[$7E:1ADB]  ;\
$8B:97B0 85 16       STA $16    [$7E:0016]  ;} $16 = [cinematic sprite object palette index]
$8B:97B2 BD 7D 1A    LDA $1A7D,x[$7E:1A9B]  ;\
$8B:97B5 38          SEC                    ;|
$8B:97B6 ED 11 09    SBC $0911  [$7E:0911]  ;} $14 = [cinematic sprite object X position] - [layer 1 X position]
$8B:97B9 85 14       STA $14    [$7E:0014]  ;/
$8B:97BB BD 9D 1A    LDA $1A9D,x[$7E:1ABB]  ;\
$8B:97BE 38          SEC                    ;|
$8B:97BF ED 15 09    SBC $0915  [$7E:0915]  ;} $12 = [cinematic sprite object Y position] - [layer 1 Y position]
$8B:97C2 85 12       STA $12    [$7E:0012]  ;/
$8B:97C4 89 00 FF    BIT #$FF00             ;\
$8B:97C7 D0 0F       BNE $0F    [$97D8]     ;} If 0 <= [$12] < 100h:
$8B:97C9 18          CLC                    ;\
$8B:97CA 69 80 00    ADC #$0080             ;|
$8B:97CD C9 FF 01    CMP #$01FF             ;} If -80h <= [$12] < 17Fh: (redundant check)
$8B:97D0 B0 13       BCS $13    [$97E5]     ;/
$8B:97D2 22 9F 87 81 JSL $81879F[$81:879F]  ; Add spritemap to OAM
$8B:97D6 80 0D       BRA $0D    [$97E5]

$8B:97D8 18          CLC                    ;\ Else (not 0 <= [$12] < 100h):
$8B:97D9 69 80 00    ADC #$0080             ;|
$8B:97DC C9 FF 01    CMP #$01FF             ;} If -80h <= [$12] < 17Fh:
$8B:97DF B0 04       BCS $04    [$97E5]     ;/
$8B:97E1 22 53 88 81 JSL $818853[$81:8853]  ; Add spritemap to OAM off-screen

; BRANCH_NEXT
$8B:97E5 CA          DEX                    ;\
$8B:97E6 CA          DEX                    ;} X -= 2
$8B:97E7 10 B7       BPL $B7    [$97A0]     ; If [X] >= 0: go to LOOP
$8B:97E9 AB          PLB
$8B:97EA AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:97ED C9 02 DA    CMP #$DA02             ;} If [cinematic function] < $DA02:
$8B:97F0 10 03       BPL $03    [$97F5]     ;/
$8B:97F2 20 D9 8E    JSR $8ED9  [$8B:8ED9]  ; Move unused sprites off-screen

$8B:97F5 28          PLP
$8B:97F6 60          RTS
}


;;; $97F7: Spawn text glow object ;;;
{
$8B:97F7 DA          PHX
$8B:97F8 A2 0E 00    LDX #$000E             ; X = Eh

; LOOP
$8B:97FB BD F7 19    LDA $19F7,x[$7E:1A05]  ;\
$8B:97FE F0 06       BEQ $06    [$9806]     ;} If [text glow object indirect instruction pointer] != 0:
$8B:9800 CA          DEX                    ;\
$8B:9801 CA          DEX                    ;} X -= 2
$8B:9802 10 F7       BPL $F7    [$97FB]     ; If [X] >= 0: go to LOOP
$8B:9804 FA          PLX
$8B:9805 60          RTS                    ; Return

$8B:9806 98          TYA                    ;\
$8B:9807 9D F7 19    STA $19F7,x[$7E:1A05]  ;} Text glow object indirect instruction pointer = [Y]
$8B:980A A9 01 00    LDA #$0001             ;\
$8B:980D 9D 07 1A    STA $1A07,x[$7E:1A15]  ;} Text glow object timer = 1
$8B:9810 A5 12       LDA $12    [$7E:0012]  ;\
$8B:9812 29 FF 00    AND #$00FF             ;} Text glow object X position = [$12]
$8B:9815 9D 17 1A    STA $1A17,x[$7E:1A25]  ;/
$8B:9818 A5 13       LDA $13    [$7E:0013]  ;\
$8B:981A 29 FF 00    AND #$00FF             ;} Text glow object Y position = [$13]
$8B:981D 9D 27 1A    STA $1A27,x[$7E:1A35]  ;/
$8B:9820 A9 00 00    LDA #$0000             ;\
$8B:9823 9D 37 1A    STA $1A37,x[$7E:1A45]  ;} Text glow object palette index = 0
$8B:9826 FA          PLX
$8B:9827 60          RTS
}


;;; $9828: Handle text glow objects ;;;
{
$8B:9828 08          PHP
$8B:9829 C2 30       REP #$30
$8B:982B 8B          PHB
$8B:982C F4 00 8C    PEA $8C00              ;\
$8B:982F AB          PLB                    ;} DB = $8C
$8B:9830 AB          PLB                    ;/
$8B:9831 A2 0E 00    LDX #$000E             ; X = Eh

; LOOP
$8B:9834 8E 47 1A    STX $1A47  [$7E:1A47]  ; Text glow object index = [X]
$8B:9837 BD F7 19    LDA $19F7,x[$7E:1A05]  ;\
$8B:983A F0 06       BEQ $06    [$9842]     ;} If [text glow object indirect instruction pointer] != 0:
$8B:983C 20 49 98    JSR $9849  [$8B:9849]  ; Process text glow object
$8B:983F AE 47 1A    LDX $1A47  [$7E:1A47]

$8B:9842 CA          DEX                    ;\
$8B:9843 CA          DEX                    ;} X -= 2
$8B:9844 10 EE       BPL $EE    [$9834]     ; If [X] >= 0: go to LOOP
$8B:9846 AB          PLB
$8B:9847 28          PLP
$8B:9848 60          RTS
}


;;; $9849: Process text glow object ;;;
{
$8B:9849 AE 47 1A    LDX $1A47  [$7E:1A47]
$8B:984C DE 07 1A    DEC $1A07,x[$7E:1A15]  ; Decrement text glow object timer
$8B:984F F0 01       BEQ $01    [$9852]     ; If [text glow object timer] != 0:
$8B:9851 60          RTS                    ; Return

$8B:9852 BD 37 1A    LDA $1A37,x[$7E:1A45]  ;\
$8B:9855 85 1C       STA $1C    [$7E:001C]  ;} $1C = [text glow object palette index]
$8B:9857 BC F7 19    LDY $19F7,x[$7E:1A05]  ; Y = [text glow object indirect instruction pointer]
$8B:985A BD 17 1A    LDA $1A17,x[$7E:1A25]  ;\
$8B:985D 29 FF 00    AND #$00FF             ;|
$8B:9860 0A          ASL A                  ;|
$8B:9861 8D 14 00    STA $0014  [$7E:0014]  ;|
$8B:9864 E2 20       SEP #$20               ;|
$8B:9866 A9 40       LDA #$40               ;|
$8B:9868 8D 02 42    STA $4202  [$7E:4202]  ;|
$8B:986B BD 27 1A    LDA $1A27,x[$7E:1A35]  ;|
$8B:986E 8D 03 42    STA $4203  [$7E:4203]  ;} $16 = ([text glow object Y position] * 20h + [text glow object X position]) * 2
$8B:9871 EA          NOP                    ;|
$8B:9872 EA          NOP                    ;|
$8B:9873 EA          NOP                    ;|
$8B:9874 C2 20       REP #$20               ;|
$8B:9876 AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:9879 18          CLC                    ;|
$8B:987A 6D 14 00    ADC $0014  [$7E:0014]  ;|
$8B:987D 8D 16 00    STA $0016  [$7E:0016]  ;/
$8B:9880 AA          TAX                    ; X = [$16]
$8B:9881 B9 02 00    LDA $0002,y[$8C:D6B7]  ;\
$8B:9884 29 FF 00    AND #$00FF             ;|
$8B:9887 8D 12 00    STA $0012  [$7E:0012]  ;} $18 = $12 = [[Y] + 2] (columns, always 1)
$8B:988A 8D 18 00    STA $0018  [$7E:0018]  ;/
$8B:988D B9 03 00    LDA $0003,y[$8C:D6B8]  ;\
$8B:9890 29 FF 00    AND #$00FF             ;} $14 = [[Y] + 3] (rows, always 1)
$8B:9893 8D 14 00    STA $0014  [$7E:0014]  ;/

; LOOP
$8B:9896 BF 00 30 7E LDA $7E3000,x[$7E:3102];\
$8B:989A 29 FF E3    AND #$E3FF             ;|
$8B:989D 05 1C       ORA $1C    [$7E:001C]  ;} $7E:3000 + [X] = [$7E:3000 + [X]] & ~1C00h | [$1C]
$8B:989F 9F 00 30 7E STA $7E3000,x[$7E:3102];/
$8B:98A3 C8          INY                    ;\
$8B:98A4 C8          INY                    ;} Y += 2
$8B:98A5 E8          INX                    ;\
$8B:98A6 E8          INX                    ;} X += 2
$8B:98A7 CE 12 00    DEC $0012  [$7E:0012]  ; Decrement $12
$8B:98AA F0 02       BEQ $02    [$98AE]     ; If [$12] != 0:
$8B:98AC 80 E8       BRA $E8    [$9896]     ; Go to LOOP

$8B:98AE AD 18 00    LDA $0018  [$7E:0018]  ;\
$8B:98B1 8D 12 00    STA $0012  [$7E:0012]  ;} $12 = [$18]
$8B:98B4 CE 14 00    DEC $0014  [$7E:0014]  ; Decrement $14
$8B:98B7 F0 0D       BEQ $0D    [$98C6]     ; If [$14] != 0:
$8B:98B9 AD 16 00    LDA $0016  [$7E:0016]  ;\
$8B:98BC 18          CLC                    ;|
$8B:98BD 69 40 00    ADC #$0040             ;} $16 += 40h
$8B:98C0 8D 16 00    STA $0016  [$7E:0016]  ;/
$8B:98C3 AA          TAX                    ; X = [$16]
$8B:98C4 80 D0       BRA $D0    [$9896]     ; Go to LOOP

$8B:98C6 AE 47 1A    LDX $1A47  [$7E:1A47]
$8B:98C9 BD 37 1A    LDA $1A37,x[$7E:1A45]  ;\
$8B:98CC C9 00 0C    CMP #$0C00             ;} If [text glow object palette index] != C00h:
$8B:98CF F0 0E       BEQ $0E    [$98DF]     ;/
$8B:98D1 18          CLC                    ;\
$8B:98D2 69 00 04    ADC #$0400             ;} Text glow object palette index += 400h
$8B:98D5 9D 37 1A    STA $1A37,x[$7E:1A45]  ;/
$8B:98D8 A9 05 00    LDA #$0005             ;\
$8B:98DB 9D 07 1A    STA $1A07,x[$7E:1A15]  ;} Text glow object timer = 5
$8B:98DE 60          RTS                    ; Return

$8B:98DF 9E F7 19    STZ $19F7,x[$7E:1A05]  ; Text glow object indirect instruction pointer = 0
$8B:98E2 60          RTS
}


;;; $98E3: Enable credits object ;;;
{
$8B:98E3 08          PHP
$8B:98E4 C2 30       REP #$30
$8B:98E6 A9 00 80    LDA #$8000
$8B:98E9 0C FF 19    TSB $19FF  [$7E:19FF]
$8B:98EC 28          PLP
$8B:98ED 60          RTS
}


;;; $98EE: Disable credits object ;;;
{
$8B:98EE 08          PHP
$8B:98EF C2 30       REP #$30
$8B:98F1 A9 00 80    LDA #$8000
$8B:98F4 1C FF 19    TRB $19FF  [$7E:19FF]
$8B:98F7 28          PLP
$8B:98F8 60          RTS
}


;;; $98F9:  ;;;
{
$8B:98F9 08          PHP
$8B:98FA C2 30       REP #$30
$8B:98FC DA          PHX
$8B:98FD A2 FE 07    LDX #$07FE

$8B:9900 9F 00 30 7E STA $7E3000,x[$7E:37FE]
$8B:9904 CA          DEX
$8B:9905 CA          DEX
$8B:9906 10 F8       BPL $F8    [$9900]
$8B:9908 A9 00 00    LDA #$0000
$8B:990B 8D 01 1A    STA $1A01  [$7E:1A01]
$8B:990E 9C F7 19    STZ $19F7  [$7E:19F7]
$8B:9911 9C F9 19    STZ $19F9  [$7E:19F9]
$8B:9914 9C FB 19    STZ $19FB  [$7E:19FB]
$8B:9917 9C FD 19    STZ $19FD  [$7E:19FD]
$8B:991A A9 00 48    LDA #$4800             ;\
$8B:991D 8D F5 19    STA $19F5  [$7E:19F5]  ;} Cinematic BG VRAM address = $4800
$8B:9920 9C 03 1A    STZ $1A03  [$7E:1A03]
$8B:9923 9C 91 19    STZ $1991  [$7E:1991]
$8B:9926 9C 93 19    STZ $1993  [$7E:1993]
$8B:9929 9C 95 19    STZ $1995  [$7E:1995]
$8B:992C 9C 97 19    STZ $1997  [$7E:1997]
$8B:992F FA          PLX
$8B:9930 28          PLP
$8B:9931 60          RTS
}


;;; $9932:  ;;;
{
$8B:9932 08          PHP
$8B:9933 C2 30       REP #$30
$8B:9935 DA          PHX
$8B:9936 BB          TYX                    ; Y = [X]
$8B:9937 BD 02 00    LDA $0002,x[$8B:F6FA]  ;\
$8B:993A 8D FD 19    STA $19FD  [$7E:19FD]  ;} Credits object pre-instruction = [[X] + 2]
$8B:993D BD 04 00    LDA $0004,x[$8B:F6FC]  ;\
$8B:9940 8D F7 19    STA $19F7  [$7E:19F7]  ;} Credits object instruction list pointer = [[X] + 4]
$8B:9943 A9 01 00    LDA #$0001             ;\
$8B:9946 8D F9 19    STA $19F9  [$7E:19F9]  ;} Credits object instruction timer = 1
$8B:9949 A9 00 00    LDA #$0000             ;\
$8B:994C 8D FB 19    STA $19FB  [$7E:19FB]  ;} Credits object timer = 0
$8B:994F FC 00 00    JSR ($0000,x)[$8B:93D9]; Execute [[X]]
$8B:9952 FA          PLX
$8B:9953 28          PLP
$8B:9954 60          RTS
}


;;; $9955: Handle credits object ;;;
{
$8B:9955 08          PHP
$8B:9956 C2 30       REP #$30
$8B:9958 2C FF 19    BIT $19FF  [$7E:19FF]  ;\
$8B:995B 10 0B       BPL $0B    [$9968]     ;} If [credits object enable flag] & 8000h = 0: return
$8B:995D AD F7 19    LDA $19F7  [$7E:19F7]  ;\
$8B:9960 F0 03       BEQ $03    [$9965]     ;} If [credits object instruction list pointer] != 0:
$8B:9962 20 6A 99    JSR $996A  [$8B:996A]

$8B:9965 20 06 88    JSR $8806  [$8B:8806]

$8B:9968 28          PLP
$8B:9969 60          RTS
}


;;; $996A:  ;;;
{
$8B:996A A2 00 00    LDX #$0000             ;\
$8B:996D FC FD 19    JSR ($19FD,x)[$8B:93D9];} Execute [credits object pre-instruction]
$8B:9970 8B          PHB
$8B:9971 F4 00 8C    PEA $8C00              ;\
$8B:9974 AB          PLB                    ;} DB = $8C
$8B:9975 AB          PLB                    ;/
$8B:9976 AD 95 19    LDA $1995  [$7E:1995]  ;\
$8B:9979 18          CLC                    ;|
$8B:997A 69 00 80    ADC #$8000             ;|
$8B:997D 8D 95 19    STA $1995  [$7E:1995]  ;} $1997.$1995 += 0.8000h
$8B:9980 AD 97 19    LDA $1997  [$7E:1997]  ;|
$8B:9983 69 00 00    ADC #$0000             ;|
$8B:9986 8D 97 19    STA $1997  [$7E:1997]  ;/
$8B:9989 38          SEC                    ;\
$8B:998A ED 03 1A    SBC $1A03  [$7E:1A03]  ;|
$8B:998D C9 08 00    CMP #$0008             ;} If [$1997] < [$1A03] + 8: return
$8B:9990 30 2D       BMI $2D    [$99BF]     ;/
$8B:9992 AD 97 19    LDA $1997  [$7E:1997]  ;\
$8B:9995 8D 03 1A    STA $1A03  [$7E:1A03]  ;} $1A03 = [$1997]
$8B:9998 AC F7 19    LDY $19F7  [$7E:19F7]  ; Y = [credits object instruction list pointer]

; LOOP
$8B:999B B9 00 00    LDA $0000,y[$8C:D91B]  ;\
$8B:999E 10 0A       BPL $0A    [$99AA]     ;} If [[Y]] & 8000h != 0:
$8B:99A0 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]]
$8B:99A2 C8          INY                    ;\
$8B:99A3 C8          INY                    ;} Y += 2
$8B:99A4 F4 9A 99    PEA $999A              ;\
$8B:99A7 6C 12 00    JMP ($0012)[$8B:9A17]  ;} Execute [$12] and return to LOOP

$8B:99AA 20 C1 99    JSR $99C1  [$8B:99C1]  ; Execute $99C1
$8B:99AD AD 01 1A    LDA $1A01  [$7E:1A01]  ;\
$8B:99B0 1A          INC A                  ;|
$8B:99B1 29 1F 00    AND #$001F             ;} $1A01 = ([$1A01] + 1) % 20h
$8B:99B4 8D 01 1A    STA $1A01  [$7E:1A01]  ;/
$8B:99B7 98          TYA                    ;\
$8B:99B8 18          CLC                    ;|
$8B:99B9 69 04 00    ADC #$0004             ;} Credits object instruction list pointer = [Y] + 4
$8B:99BC 8D F7 19    STA $19F7  [$7E:19F7]  ;/

$8B:99BF AB          PLB
$8B:99C0 60          RTS
}


;;; $99C1:  ;;;
{
; Copy 40h bytes from $7F:0000 + [[Y] + 2] to $7E:3000 + [$1A01] * 40h

$8B:99C1 08          PHP
$8B:99C2 C2 30       REP #$30
$8B:99C4 A9 00 7F    LDA #$7F00
$8B:99C7 85 01       STA $01    [$7E:0001]
$8B:99C9 64 00       STZ $00    [$7E:0000]
$8B:99CB 5A          PHY
$8B:99CC E2 20       SEP #$20
$8B:99CE A9 40       LDA #$40
$8B:99D0 8D 02 42    STA $4202  [$7E:4202]
$8B:99D3 AD 01 1A    LDA $1A01  [$7E:1A01]
$8B:99D6 8D 03 42    STA $4203  [$7E:4203]
$8B:99D9 EA          NOP
$8B:99DA EA          NOP
$8B:99DB EA          NOP
$8B:99DC C2 20       REP #$20
$8B:99DE AD 16 42    LDA $4216  [$7E:4216]
$8B:99E1 AA          TAX
$8B:99E2 A9 1F 00    LDA #$001F
$8B:99E5 8D 14 00    STA $0014  [$7E:0014]
$8B:99E8 B9 02 00    LDA $0002,y[$8C:D921]
$8B:99EB A8          TAY

$8B:99EC B7 00       LDA [$00],y[$7F:1FC0]
$8B:99EE 9F 00 30 7E STA $7E3000,x[$7E:3000]
$8B:99F2 E8          INX
$8B:99F3 E8          INX
$8B:99F4 C8          INY
$8B:99F5 C8          INY
$8B:99F6 CE 14 00    DEC $0014  [$7E:0014]
$8B:99F9 10 F1       BPL $F1    [$99EC]
$8B:99FB 7A          PLY
$8B:99FC 28          PLP
$8B:99FD 60          RTS
}


;;; $99FE: Instruction - delete ;;;
{
$8B:99FE C2 30       REP #$30
$8B:9A00 9C F7 19    STZ $19F7  [$7E:19F7]
$8B:9A03 68          PLA
$8B:9A04 AB          PLB
$8B:9A05 60          RTS
}


;;; $9A06: Instruction - go to [[Y]] ;;;
{
$8B:9A06 C2 30       REP #$30
$8B:9A08 B9 00 00    LDA $0000,y[$8C:D925]
$8B:9A0B A8          TAY
$8B:9A0C 60          RTS
}


;;; $9A0D: Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
$8B:9A0D C2 30       REP #$30
$8B:9A0F CE FB 19    DEC $19FB  [$7E:19FB]
$8B:9A12 D0 F2       BNE $F2    [$9A06]
$8B:9A14 C8          INY
$8B:9A15 C8          INY
$8B:9A16 60          RTS
}


;;; $9A17: Instruction - timer = [[Y]] ;;;
{
$8B:9A17 C2 30       REP #$30
$8B:9A19 B9 00 00    LDA $0000,y[$8C:D91D]
$8B:9A1C 8D FB 19    STA $19FB  [$7E:19FB]
$8B:9A1F C8          INY
$8B:9A20 C8          INY
$8B:9A21 60          RTS
}


;;; $9A22: Game state 1 - opening ;;;
{
$8B:9A22 08          PHP
$8B:9A23 8B          PHB
$8B:9A24 4B          PHK                    ;\
$8B:9A25 AB          PLB                    ;} DB = $8B
$8B:9A26 C2 30       REP #$30
$8B:9A28 F4 2D 9A    PEA $9A2D              ;\
$8B:9A2B 6C 51 1F    JMP ($1F51)[$8B:9B68]  ;} Execute [cinematic function]

$8B:9A2E 20 EF 93    JSR $93EF  [$8B:93EF]  ; Handle cinematic sprite objects
$8B:9A31 20 1D 95    JSR $951D  [$8B:951D]  ; Handle mode 7 objects (baby Metroid)
$8B:9A34 22 27 C5 8D JSL $8DC527[$8D:C527]  ; Palette FX object handler
$8B:9A38 20 46 97    JSR $9746  [$8B:9746]  ; Draw cinematic sprite objects
$8B:9A3B 20 48 9A    JSR $9A48  [$8B:9A48]  ; Code suggests it handles button input to skip to title screen, but in practice, it has no effect
$8B:9A3E 20 6C 9A    JSR $9A6C  [$8B:9A6C]  ; Code suggests it handles transitions
$8B:9A41 20 18 85    JSR $8518  [$8B:8518]  ; Handle mode 7 transformation matrix - no rotation
$8B:9A44 AB          PLB
$8B:9A45 28          PLP
$8B:9A46 6B          RTL
}


;;; $9A47: RTS ;;;
{
$8B:9A47 60          RTS
}


;;; $9A48:  ;;;
{
$8B:9A48 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:9A4B C9 28 9F    CMP #$9F28             ;} If [cinematic function] >= $9F28: return
$8B:9A4E 10 1B       BPL $1B    [$9A6B]     ;/
$8B:9A50 A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:9A52 89 80 90    BIT #$9080             ;} If not newly pressed A, B or start: return
$8B:9A55 F0 14       BEQ $14    [$9A6B]     ;/
$8B:9A57 AD 53 1A    LDA $1A53  [$7E:1A53]
$8B:9A5A D0 0F       BNE $0F    [$9A6B]
$8B:9A5C A9 01 00    LDA #$0001
$8B:9A5F 8D 53 1A    STA $1A53  [$7E:1A53]
$8B:9A62 9C 23 07    STZ $0723  [$7E:0723]
$8B:9A65 A9 02 00    LDA #$0002
$8B:9A68 8D 25 07    STA $0725  [$7E:0725]

$8B:9A6B 60          RTS
}


;;; $9A6C:  ;;;
{
$8B:9A6C 08          PHP
$8B:9A6D C2 30       REP #$30
$8B:9A6F AD 53 1A    LDA $1A53  [$7E:1A53]
$8B:9A72 F0 05       BEQ $05    [$9A79]
$8B:9A74 0A          ASL A
$8B:9A75 AA          TAX
$8B:9A76 FC 7B 9A    JSR ($9A7B,x)[$8B:9A83]

$8B:9A79 28          PLP
$8B:9A7A 60          RTS

$8B:9A7B             dw 0000, 9A83, 9A9C, 9B53
}


;;; $9A83:  ;;;
{
$8B:9A83 20 B8 90    JSR $90B8  [$8B:90B8]  ; Advance fast screen fade out
$8B:9A86 90 13       BCC $13    [$9A9B]     ; If not reached zero brightness: return
$8B:9A88 A9 02 00    LDA #$0002
$8B:9A8B 8D 53 1A    STA $1A53  [$7E:1A53]
$8B:9A8E A9 28 9F    LDA #$9F28
$8B:9A91 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9A94 A9 06 00    LDA #$0006             ;\
$8B:9A97 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 1 music track

$8B:9A9B 60          RTS
}


;;; $9A9C:  ;;;
{
$8B:9A9C 20 DA 93    JSR $93DA  [$8B:93DA]  ; Clear cinematic sprite objects
$8B:9A9F A0 19 A1    LDY #$A119             ;\
$8B:9AA2 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $A119 (Super Metroid title logo - immediate)
$8B:9AA5 A0 25 A1    LDY #$A125             ;\
$8B:9AA8 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $A125 (Nintendo copyright - immediate)
$8B:9AAB 9C 23 07    STZ $0723  [$7E:0723]
$8B:9AAE A9 02 00    LDA #$0002
$8B:9AB1 8D 25 07    STA $0725  [$7E:0725]
$8B:9AB4 A9 00 01    LDA #$0100
$8B:9AB7 8D 8F 19    STA $198F  [$7E:198F]
$8B:9ABA 9C 93 19    STZ $1993  [$7E:1993]
$8B:9ABD 9C 91 19    STZ $1991  [$7E:1991]
$8B:9AC0 9C 97 19    STZ $1997  [$7E:1997]
$8B:9AC3 9C 95 19    STZ $1995  [$7E:1995]
$8B:9AC6 9C 9B 19    STZ $199B  [$7E:199B]
$8B:9AC9 9C 99 19    STZ $1999  [$7E:1999]
$8B:9ACC 9C 9F 19    STZ $199F  [$7E:199F]
$8B:9ACF 9C 9D 19    STZ $199D  [$7E:199D]
$8B:9AD2 A9 03 00    LDA #$0003
$8B:9AD5 8D 53 1A    STA $1A53  [$7E:1A53]
$8B:9AD8 A2 00 01    LDX #$0100             ;\
                                            ;|
$8B:9ADB BF E9 E1 8C LDA $8CE1E9,x[$8C:E2E9];|
$8B:9ADF 9F 00 C0 7E STA $7EC000,x[$7E:C100];|
$8B:9AE3 E8          INX                    ;} Load sprite palettes from title screen palettes
$8B:9AE4 E8          INX                    ;|
$8B:9AE5 E0 00 02    CPX #$0200             ;|
$8B:9AE8 30 F1       BMI $F1    [$9ADB]     ;/
$8B:9AEA A9 FF 7F    LDA #$7FFF
$8B:9AED 8F 92 C1 7E STA $7EC192[$7E:C192]
$8B:9AF1 A9 80 7D    LDA #$7D80
$8B:9AF4 8F 94 C1 7E STA $7EC194[$7E:C194]
$8B:9AF8 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]
$8B:9AFC A0 A0 E1    LDY #$E1A0             ;\
$8B:9AFF 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1A0 (title screen baby metroid tube light)
$8B:9B03 A0 A4 E1    LDY #$E1A4             ;\
$8B:9B06 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1A4 (title screen flickering displays)
$8B:9B0A 20 82 86    JSR $8682  [$8B:8682]
$8B:9B0D E2 20       SEP #$20
$8B:9B0F A9 11       LDA #$11
$8B:9B11 85 69       STA $69    [$7E:0069]
$8B:9B13 C2 20       REP #$20
$8B:9B15 22 58 EB 88 JSL $88EB58[$88:EB58]  ; Spawn title sequence gradient HDMA objects
$8B:9B19 60          RTS
}


;;; $9B1A: Initialisation function - cinematic sprite object $A119 (Super Metroid title logo - immediate) ;;;
{
$8B:9B1A A9 80 00    LDA #$0080
$8B:9B1D 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:9B20 A9 30 00    LDA #$0030
$8B:9B23 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:9B26 A9 00 04    LDA #$0400
$8B:9B29 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:9B2C 60          RTS
}


;;; $9B2D: Initialisation function - cinematic sprite object $A11F (unused. Nintendo boot logo - immediate) ;;;
{
$8B:9B2D A9 80 00    LDA #$0080
$8B:9B30 99 7D 1A    STA $1A7D,y
$8B:9B33 A9 51 00    LDA #$0051
$8B:9B36 99 9D 1A    STA $1A9D,y
$8B:9B39 A9 00 00    LDA #$0000
$8B:9B3C 99 BD 1A    STA $1ABD,y
$8B:9B3F 60          RTS
}


;;; $9B40: Initialisation function - cinematic sprite object $A125 (Nintendo copyright - immediate) ;;;
{
$8B:9B40 A9 80 00    LDA #$0080
$8B:9B43 99 7D 1A    STA $1A7D,y[$7E:1A99]
$8B:9B46 A9 C4 00    LDA #$00C4
$8B:9B49 99 9D 1A    STA $1A9D,y[$7E:1AB9]
$8B:9B4C A9 00 08    LDA #$0800
$8B:9B4F 99 BD 1A    STA $1ABD,y[$7E:1AD9]
$8B:9B52 60          RTS
}


;;; $9B53:  ;;;
{
$8B:9B53 20 00 91    JSR $9100  [$8B:9100]  ; Advance fast screen fade in
$8B:9B56 90 0F       BCC $0F    [$9B67]     ; If not reached max brightness: return
$8B:9B58 9C 53 1A    STZ $1A53  [$7E:1A53]
$8B:9B5B A9 84 03    LDA #$0384
$8B:9B5E 8D 53 1F    STA $1F53  [$7E:1F53]
$8B:9B61 A9 29 9F    LDA #$9F29
$8B:9B64 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:9B67 60          RTS
}


;;; $9B68: Cinematic function - load title sequence ;;;
{
$8B:9B68 22 87 9B 8B JSL $8B9B87[$8B:9B87]  ; Load title sequence graphics
$8B:9B6C A9 03 FF    LDA #$FF03             ;\
$8B:9B6F 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue title sequence music data
$8B:9B73 A9 47 9A    LDA #$9A47             ;\
$8B:9B76 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = RTS
$8B:9B79 A0 EF A0    LDY #$A0EF             ;\
$8B:9B7C 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $A0EF ('1994' scrolling text)
$8B:9B7F A9 05 00    LDA #$0005             ;\
$8B:9B82 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track
$8B:9B86 60          RTS
}


;;; $9B87: Load title sequence graphics ;;;
{
; Called by:
;     $9B68: Load title sequence
;     $82:85FB: Game state 2Ch (transition from demo)
$8B:9B87 08          PHP
$8B:9B88 8B          PHB
$8B:9B89 4B          PHK
$8B:9B8A AB          PLB
$8B:9B8B C2 30       REP #$30
$8B:9B8D 20 00 80    JSR $8000  [$8B:8000]
$8B:9B90 64 AB       STZ $AB    [$7E:00AB]
$8B:9B92 64 A7       STZ $A7    [$7E:00A7]
$8B:9B94 A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:9B97 BF E9 E1 8C LDA $8CE1E9,x[$8C:E1E9];|
$8B:9B9B 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$8B:9B9F E8          INX                    ;} Load title palettes
$8B:9BA0 E8          INX                    ;|
$8B:9BA1 E0 00 02    CPX #$0200             ;|
$8B:9BA4 30 F1       BMI $F1    [$9B97]     ;/
$8B:9BA6 A9 00 94    LDA #$9400             ;\
$8B:9BA9 85 48       STA $48    [$7E:0048]  ;|
$8B:9BAB A9 00 E0    LDA #$E000             ;|
$8B:9BAE 85 47       STA $47    [$7E:0047]  ;} Decompress title BG tiles to $7F:0000
$8B:9BB0 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:9BB4             dl 7F0000              ;/
$8B:9BB7 A9 00 96    LDA #$9600             ;\
$8B:9BBA 85 48       STA $48    [$7E:0048]  ;|
$8B:9BBC A9 04 FC    LDA #$FC04             ;|
$8B:9BBF 85 47       STA $47    [$7E:0047]  ;} Decompress title tilemap to $7F:4000
$8B:9BC1 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:9BC5             dl 7F4000              ;/
$8B:9BC8 A9 00 95    LDA #$9500             ;\
$8B:9BCB 85 48       STA $48    [$7E:0048]  ;|
$8B:9BCD A9 D8 80    LDA #$80D8             ;|
$8B:9BD0 85 47       STA $47    [$7E:0047]  ;} Decompress title sprite tiles to $7F:5000
$8B:9BD2 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:9BD6             dl 7F5000              ;/
$8B:9BD9 A9 00 95    LDA #$9500             ;\
$8B:9BDC 85 48       STA $48    [$7E:0048]  ;|
$8B:9BDE A9 E1 A5    LDA #$A5E1             ;|
$8B:9BE1 85 47       STA $47    [$7E:0047]  ;} Decompress baby metroid tiles to $7F:9000
$8B:9BE3 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:9BE7             dl 7F9000              ;/
$8B:9BEA E2 30       SEP #$30
$8B:9BEC A9 00       LDA #$00
$8B:9BEE 8D 16 21    STA $2116  [$7E:2116]
$8B:9BF1 A9 00       LDA #$00
$8B:9BF3 8D 17 21    STA $2117  [$7E:2117]
$8B:9BF6 A9 80       LDA #$80
$8B:9BF8 8D 15 21    STA $2115  [$7E:2115]
$8B:9BFB 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:9BFF             dx 01,00,19,7F0000,4000
$8B:9C07 A9 02       LDA #$02
$8B:9C09 8D 0B 42    STA $420B  [$7E:420B]
$8B:9C0C C2 10       REP #$10
$8B:9C0E 9C 15 21    STZ $2115  [$7E:2115]
$8B:9C11 9C 16 21    STZ $2116  [$7E:2116]
$8B:9C14 9C 17 21    STZ $2117  [$7E:2117]
$8B:9C17 A2 00 40    LDX #$4000
$8B:9C1A A9 FF       LDA #$FF

$8B:9C1C 8D 18 21    STA $2118  [$7E:2118]
$8B:9C1F CA          DEX
$8B:9C20 D0 FA       BNE $FA    [$9C1C]
$8B:9C22 E2 10       SEP #$10
$8B:9C24 A9 00       LDA #$00
$8B:9C26 8D 16 21    STA $2116  [$7E:2116]
$8B:9C29 A9 00       LDA #$00
$8B:9C2B 8D 17 21    STA $2117  [$7E:2117]
$8B:9C2E A9 00       LDA #$00
$8B:9C30 8D 15 21    STA $2115  [$7E:2115]
$8B:9C33 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:9C37             dx 01,00,18,7F4000,1000
$8B:9C3F A9 02       LDA #$02
$8B:9C41 8D 0B 42    STA $420B  [$7E:420B]
$8B:9C44 A9 00       LDA #$00
$8B:9C46 8D 16 21    STA $2116  [$7E:2116]
$8B:9C49 A9 60       LDA #$60
$8B:9C4B 8D 17 21    STA $2117  [$7E:2117]
$8B:9C4E A9 80       LDA #$80
$8B:9C50 8D 15 21    STA $2115  [$7E:2115]
$8B:9C53 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:9C57             dx 01,01,18,7F5000,4000
$8B:9C5F A9 02       LDA #$02
$8B:9C61 8D 0B 42    STA $420B  [$7E:420B]
$8B:9C64 C2 30       REP #$30
$8B:9C66 A9 00 01    LDA #$0100
$8B:9C69 8D 1B 21    STA $211B  [$7E:211B]
$8B:9C6C 85 78       STA $78    [$7E:0078]
$8B:9C6E 9C 1C 21    STZ $211C  [$7E:211C]
$8B:9C71 64 7A       STZ $7A    [$7E:007A]
$8B:9C73 9C 1D 21    STZ $211D  [$7E:211D]
$8B:9C76 64 7C       STZ $7C    [$7E:007C]
$8B:9C78 8D 1E 21    STA $211E  [$7E:211E]
$8B:9C7B 85 7E       STA $7E    [$7E:007E]
$8B:9C7D A9 80 00    LDA #$0080
$8B:9C80 8D 1F 21    STA $211F  [$7E:211F]
$8B:9C83 85 80       STA $80    [$7E:0080]
$8B:9C85 8D 20 21    STA $2120  [$7E:2120]
$8B:9C88 85 82       STA $82    [$7E:0082]
$8B:9C8A 22 4B 83 80 JSL $80834B[$80:834B]
$8B:9C8E A9 01 00    LDA #$0001
$8B:9C91 8D 23 07    STA $0723  [$7E:0723]
$8B:9C94 8D 25 07    STA $0725  [$7E:0725]
$8B:9C97 22 88 82 88 JSL $888288[$88:8288]
$8B:9C9B 22 C2 C4 8D JSL $8DC4C2[$8D:C4C2]
$8B:9C9F A9 00 00    LDA #$0000
$8B:9CA2 8D 82 19    STA $1982  [$7E:1982]
$8B:9CA5 A0 A0 E1    LDY #$E1A0             ;\
$8B:9CA8 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1A0 (title screen baby metroid tube light)
$8B:9CAC A0 A4 E1    LDY #$E1A4             ;\
$8B:9CAF 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1A4 (title screen flickering displays)
$8B:9CB3 A0 55 A3    LDY #$A355             ;\
$8B:9CB6 20 E4 94    JSR $94E4  [$8B:94E4]  ;} Spawn mode 7 object $A355 (baby metroid in title sequence)
$8B:9CB9 AB          PLB
$8B:9CBA 28          PLP
$8B:9CBB 6B          RTL
}


;;; $9CBC: Initialisation function - cinematic sprite object $A0EF ('1994' scrolling text) ;;;
{
$8B:9CBC A9 81 00    LDA #$0081
$8B:9CBF 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:9CC2 A9 70 00    LDA #$0070
$8B:9CC5 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:9CC8 A9 00 02    LDA #$0200
$8B:9CCB 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:9CCE 60          RTS
}


;;; $9CCF: Pre-instruction - cinematic sprite object $A0EF ('1994' scrolling text) ;;;
{
$8B:9CCF E2 20       SEP #$20
$8B:9CD1 A9 0F       LDA #$0F
$8B:9CD3 85 51       STA $51    [$7E:0051]
$8B:9CD5 C2 20       REP #$20
$8B:9CD7 A9 D9 93    LDA #$93D9
$8B:9CDA 9D 3D 1B    STA $1B3D,x[$7E:1B5B]
$8B:9CDD 60          RTS
}


;;; $9CDE: Unused. REP #$20 ;;;
{
$8B:9CDE C2 20       REP #$20
$8B:9CE0 60          RTS
}


;;; $9CE1: Instruction - trigger title sequence scene 0 ;;;
{
$8B:9CE1 E2 20       SEP #$20
$8B:9CE3 A9 11       LDA #$11
$8B:9CE5 85 69       STA $69    [$7E:0069]
$8B:9CE7 C2 20       REP #$20
$8B:9CE9 A9 17 9D    LDA #$9D17
$8B:9CEC 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9CEF A9 48 00    LDA #$0048
$8B:9CF2 8D 8F 19    STA $198F  [$7E:198F]
$8B:9CF5 A9 3B 01    LDA #$013B
$8B:9CF8 8D 93 19    STA $1993  [$7E:1993]
$8B:9CFB 9C 91 19    STZ $1991  [$7E:1991]
$8B:9CFE A9 E1 00    LDA #$00E1
$8B:9D01 8D 97 19    STA $1997  [$7E:1997]
$8B:9D04 9C 95 19    STZ $1995  [$7E:1995]
$8B:9D07 A9 FE FF    LDA #$FFFE
$8B:9D0A 8D 9B 19    STA $199B  [$7E:199B]
$8B:9D0D A9 00 80    LDA #$8000
$8B:9D10 8D 99 19    STA $1999  [$7E:1999]
$8B:9D13 20 6B 86    JSR $866B  [$8B:866B]
$8B:9D16 60          RTS
}


;;; $9D17: Cinematic function - title sequence scene 0 - panning left - lower ;;;
{
$8B:9D17 AD 91 19    LDA $1991  [$7E:1991]
$8B:9D1A 18          CLC
$8B:9D1B 6D 99 19    ADC $1999  [$7E:1999]
$8B:9D1E 8D 91 19    STA $1991  [$7E:1991]
$8B:9D21 AD 93 19    LDA $1993  [$7E:1993]
$8B:9D24 6D 9B 19    ADC $199B  [$7E:199B]
$8B:9D27 8D 93 19    STA $1993  [$7E:1993]
$8B:9D2A C9 F9 FF    CMP #$FFF9
$8B:9D2D 10 17       BPL $17    [$9D46]
$8B:9D2F E2 20       SEP #$20
$8B:9D31 A9 10       LDA #$10
$8B:9D33 85 69       STA $69    [$7E:0069]
$8B:9D35 C2 20       REP #$20
$8B:9D37 A9 47 9A    LDA #$9A47
$8B:9D3A 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9D3D A0 F5 A0    LDY #$A0F5             ;\
$8B:9D40 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $A0F5 ('NINTENDO' scrolling text)
$8B:9D43 20 82 86    JSR $8682  [$8B:8682]

$8B:9D46 20 48 9A    JSR $9A48  [$8B:9A48]
$8B:9D49 60          RTS
}


;;; $9D4A: Initialisation function - cinematic sprite object $A0F5 ('NINTENDO' scrolling text) ;;;
{
$8B:9D4A A9 81 00    LDA #$0081
$8B:9D4D 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:9D50 A9 70 00    LDA #$0070
$8B:9D53 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:9D56 A9 00 02    LDA #$0200
$8B:9D59 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:9D5C 60          RTS
}


;;; $9D5D: Instruction - trigger title sequence scene 1 ;;;
{
$8B:9D5D E2 20       SEP #$20
$8B:9D5F A9 11       LDA #$11
$8B:9D61 85 69       STA $69    [$7E:0069]
$8B:9D63 C2 20       REP #$20
$8B:9D65 A9 90 9D    LDA #$9D90
$8B:9D68 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9D6B A9 60 00    LDA #$0060
$8B:9D6E 8D 8F 19    STA $198F  [$7E:198F]
$8B:9D71 A9 2C 00    LDA #$002C
$8B:9D74 8D 93 19    STA $1993  [$7E:1993]
$8B:9D77 9C 91 19    STZ $1991  [$7E:1991]
$8B:9D7A A9 65 FF    LDA #$FF65
$8B:9D7D 8D 97 19    STA $1997  [$7E:1997]
$8B:9D80 9C 95 19    STZ $1995  [$7E:1995]
$8B:9D83 A9 FE FF    LDA #$FFFE
$8B:9D86 8D 9B 19    STA $199B  [$7E:199B]
$8B:9D89 A9 00 80    LDA #$8000
$8B:9D8C 8D 99 19    STA $1999  [$7E:1999]
$8B:9D8F 60          RTS
}


;;; $9D90: Cinematic function - title sequence scene 1 - panning left - upper ;;;
{
$8B:9D90 AD 91 19    LDA $1991  [$7E:1991]
$8B:9D93 18          CLC
$8B:9D94 6D 99 19    ADC $1999  [$7E:1999]
$8B:9D97 8D 91 19    STA $1991  [$7E:1991]
$8B:9D9A AD 93 19    LDA $1993  [$7E:1993]
$8B:9D9D 6D 9B 19    ADC $199B  [$7E:199B]
$8B:9DA0 8D 93 19    STA $1993  [$7E:1993]
$8B:9DA3 C9 50 FF    CMP #$FF50
$8B:9DA6 10 17       BPL $17    [$9DBF]
$8B:9DA8 E2 20       SEP #$20
$8B:9DAA A9 10       LDA #$10
$8B:9DAC 85 69       STA $69    [$7E:0069]
$8B:9DAE C2 20       REP #$20
$8B:9DB0 A9 47 9A    LDA #$9A47
$8B:9DB3 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9DB6 A0 FB A0    LDY #$A0FB             ;\
$8B:9DB9 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $A0FB ('PRESENTS' scrolling text)
$8B:9DBC 20 82 86    JSR $8682  [$8B:8682]

$8B:9DBF 20 48 9A    JSR $9A48  [$8B:9A48]
$8B:9DC2 60          RTS
}


;;; $9DC3: Initialisation function - cinematic sprite object $A0FB ('PRESENTS' scrolling text) ;;;
{
$8B:9DC3 A9 81 00    LDA #$0081
$8B:9DC6 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:9DC9 A9 70 00    LDA #$0070
$8B:9DCC 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:9DCF A9 00 02    LDA #$0200
$8B:9DD2 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:9DD5 60          RTS
}


;;; $9DD6: Instruction - trigger title sequence scene 2 ;;;
{
$8B:9DD6 E2 20       SEP #$20
$8B:9DD8 A9 11       LDA #$11
$8B:9DDA 85 69       STA $69    [$7E:0069]
$8B:9DDC C2 20       REP #$20
$8B:9DDE A9 12 9E    LDA #$9E12
$8B:9DE1 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9DE4 A9 60 00    LDA #$0060
$8B:9DE7 8D 8F 19    STA $198F  [$7E:198F]
$8B:9DEA A9 4F FF    LDA #$FF4F
$8B:9DED 8D 93 19    STA $1993  [$7E:1993]
$8B:9DF0 9C 91 19    STZ $1991  [$7E:1991]
$8B:9DF3 A9 60 FF    LDA #$FF60
$8B:9DF6 8D 97 19    STA $1997  [$7E:1997]
$8B:9DF9 9C 95 19    STZ $1995  [$7E:1995]
$8B:9DFC 9C 9B 19    STZ $199B  [$7E:199B]
$8B:9DFF 9C 99 19    STZ $1999  [$7E:1999]
$8B:9E02 A9 01 00    LDA #$0001
$8B:9E05 8D 9F 19    STA $199F  [$7E:199F]
$8B:9E08 A9 00 80    LDA #$8000
$8B:9E0B 8D 9D 19    STA $199D  [$7E:199D]
$8B:9E0E 20 6B 86    JSR $866B  [$8B:866B]
$8B:9E11 60          RTS
}


;;; $9E12: Cinematic function - title sequence scene 2 - panning down ;;;
{
$8B:9E12 AD 95 19    LDA $1995  [$7E:1995]
$8B:9E15 18          CLC
$8B:9E16 6D 9D 19    ADC $199D  [$7E:199D]
$8B:9E19 8D 95 19    STA $1995  [$7E:1995]
$8B:9E1C AD 97 19    LDA $1997  [$7E:1997]
$8B:9E1F 6D 9F 19    ADC $199F  [$7E:199F]
$8B:9E22 8D 97 19    STA $1997  [$7E:1997]
$8B:9E25 C9 A3 00    CMP #$00A3
$8B:9E28 30 17       BMI $17    [$9E41]
$8B:9E2A E2 20       SEP #$20
$8B:9E2C A9 10       LDA #$10
$8B:9E2E 85 69       STA $69    [$7E:0069]
$8B:9E30 C2 20       REP #$20
$8B:9E32 A9 47 9A    LDA #$9A47
$8B:9E35 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9E38 A0 01 A1    LDY #$A101             ;\
$8B:9E3B 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $A101 ('METROID 3' scrolling text)
$8B:9E3E 20 82 86    JSR $8682  [$8B:8682]

$8B:9E41 20 48 9A    JSR $9A48  [$8B:9A48]
$8B:9E44 60          RTS
}


;;; $9E45: Initialisation function - cinematic sprite object $A101 ('METROID 3' scrolling text) ;;;
{
$8B:9E45 A9 81 00    LDA #$0081
$8B:9E48 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:9E4B A9 70 00    LDA #$0070
$8B:9E4E 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:9E51 A9 00 02    LDA #$0200
$8B:9E54 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:9E57 60          RTS
}


;;; $9E58: Instruction - trigger title sequence scene 3 ;;;
{
$8B:9E58 E2 20       SEP #$20
$8B:9E5A A9 11       LDA #$11
$8B:9E5C 85 69       STA $69    [$7E:0069]
$8B:9E5E C2 20       REP #$20
$8B:9E60 A9 8B 9E    LDA #$9E8B
$8B:9E63 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9E66 A9 43 00    LDA #$0043
$8B:9E69 8D 8F 19    STA $198F  [$7E:198F]
$8B:9E6C 9C 93 19    STZ $1993  [$7E:1993]
$8B:9E6F 9C 91 19    STZ $1991  [$7E:1991]
$8B:9E72 9C 97 19    STZ $1997  [$7E:1997]
$8B:9E75 9C 95 19    STZ $1995  [$7E:1995]
$8B:9E78 9C 9B 19    STZ $199B  [$7E:199B]
$8B:9E7B 9C 99 19    STZ $1999  [$7E:1999]
$8B:9E7E 9C 9F 19    STZ $199F  [$7E:199F]
$8B:9E81 9C 9D 19    STZ $199D  [$7E:199D]
$8B:9E84 5A          PHY
$8B:9E85 22 58 EB 88 JSL $88EB58[$88:EB58]  ; Spawn title sequence gradient HDMA objects
$8B:9E89 7A          PLY
$8B:9E8A 60          RTS
}


;;; $9E8B: Cinematic function - title sequence scene 3 - zooming out ;;;
{
$8B:9E8B AD B6 05    LDA $05B6  [$7E:05B6]
$8B:9E8E 89 01 00    BIT #$0001
$8B:9E91 D0 0C       BNE $0C    [$9E9F]
$8B:9E93 AD 8F 19    LDA $198F  [$7E:198F]
$8B:9E96 C9 00 01    CMP #$0100
$8B:9E99 10 05       BPL $05    [$9EA0]
$8B:9E9B 1A          INC A
$8B:9E9C 8D 8F 19    STA $198F  [$7E:198F]

$8B:9E9F 60          RTS

$8B:9EA0 A9 00 01    LDA #$0100
$8B:9EA3 8D 8F 19    STA $198F  [$7E:198F]
$8B:9EA6 A9 28 9F    LDA #$9F28
$8B:9EA9 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9EAC A0 07 A1    LDY #$A107             ;\
$8B:9EAF 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $A107 (Super Metroid title logo - fade in)
$8B:9EB2 60          RTS
}


;;; $9EB3: Initialisation function - cinematic sprite object $A107 (Super Metroid title logo - fade in) ;;;
{
$8B:9EB3 A9 80 00    LDA #$0080
$8B:9EB6 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:9EB9 A9 30 00    LDA #$0030
$8B:9EBC 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:9EBF A9 00 04    LDA #$0400
$8B:9EC2 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:9EC5 A0 94 E1    LDY #$E194             ;\
$8B:9EC8 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E194 (fade in Super Metroid title logo)
$8B:9ECC 60          RTS
}


;;; $9ECD: Instruction - fade in Nintendo copyright ;;;
{
$8B:9ECD 5A          PHY
$8B:9ECE A0 13 A1    LDY #$A113             ;\
$8B:9ED1 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $A113 (Nintendo copyright - fade in)
$8B:9ED4 7A          PLY
$8B:9ED5 60          RTS
}


;;; $9ED6: Initialisation function - cinematic sprite object $A10D (unused. Nintendo boot logo - fade in) ;;;
{
$8B:9ED6 A9 80 00    LDA #$0080
$8B:9ED9 99 7D 1A    STA $1A7D,y
$8B:9EDC A9 51 00    LDA #$0051
$8B:9EDF 99 9D 1A    STA $1A9D,y
$8B:9EE2 A9 00 02    LDA #$0200
$8B:9EE5 99 BD 1A    STA $1ABD,y
$8B:9EE8 A0 98 E1    LDY #$E198             ;\
$8B:9EEB 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E198 (fade in Nintendo boot logo)
$8B:9EEF 60          RTS
}


;;; $9EF0: Instruction - use palette 0 and fade in Nintendo copyright ;;;
{
$8B:9EF0 A9 00 00    LDA #$0000
$8B:9EF3 9D BD 1A    STA $1ABD,x
$8B:9EF6 5A          PHY
$8B:9EF7 A0 13 A1    LDY #$A113             ;\
$8B:9EFA 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $A113 (Nintendo copyright - fade in)
$8B:9EFD 7A          PLY
$8B:9EFE 60          RTS
}


;;; $9EFF: Initialisation function - cinematic sprite object $A113 (Nintendo copyright - fade in) ;;;
{
$8B:9EFF A9 80 00    LDA #$0080
$8B:9F02 99 7D 1A    STA $1A7D,y[$7E:1A99]
$8B:9F05 A9 C4 00    LDA #$00C4
$8B:9F08 99 9D 1A    STA $1A9D,y[$7E:1AB9]
$8B:9F0B A9 00 08    LDA #$0800
$8B:9F0E 99 BD 1A    STA $1ABD,y[$7E:1AD9]
$8B:9F11 A0 9C E1    LDY #$E19C             ;\
$8B:9F14 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E19C (fade in Nintendo copyright)
$8B:9F18 60          RTS
}


;;; $9F19: Instruction - start demo countdown ;;;
{
$8B:9F19 5A          PHY
$8B:9F1A A9 84 03    LDA #$0384
$8B:9F1D 8D 53 1F    STA $1F53  [$7E:1F53]
$8B:9F20 A9 29 9F    LDA #$9F29
$8B:9F23 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9F26 7A          PLY
$8B:9F27 60          RTS
}


;;; $9F28: RTS ;;;
{
$8B:9F28 60          RTS
}


;;; $9F29: Cinematic function - title screen ;;;
{
$8B:9F29 CE 53 1F    DEC $1F53  [$7E:1F53]
$8B:9F2C F0 02       BEQ $02    [$9F30]
$8B:9F2E 10 08       BPL $08    [$9F38]

$8B:9F30 A9 AE 9F    LDA #$9FAE             ;\
$8B:9F33 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $9FAE
$8B:9F36 80 0D       BRA $0D    [$9F45]

$8B:9F38 A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:9F3A 89 80 90    BIT #$9080             ;} If not newly pressed A, B or start: go to BRANCH_9F4E
$8B:9F3D F0 0F       BEQ $0F    [$9F4E]     ;/
$8B:9F3F A9 52 9F    LDA #$9F52             ;\
$8B:9F42 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $9F52

$8B:9F45 A9 02 00    LDA #$0002
$8B:9F48 8D 23 07    STA $0723  [$7E:0723]
$8B:9F4B 8D 25 07    STA $0725  [$7E:0725]

; BRANCH_9F4E
$8B:9F4E 20 97 86    JSR $8697  [$8B:8697]  ; Debug. Display version info
$8B:9F51 60          RTS
}


;;; $9F52: Cinematic function - transition to file select menu ;;;
{
$8B:9F52 20 97 86    JSR $8697  [$8B:8697]  ; Debug. Display version info
$8B:9F55 20 D5 90    JSR $90D5  [$8B:90D5]  ; Advance slow screen fade out
$8B:9F58 90 53       BCC $53    [$9FAD]     ; If not reached zero brightness: return
$8B:9F5A 22 4B 83 80 JSL $80834B[$80:834B]
$8B:9F5E E2 20       SEP #$20
$8B:9F60 A9 01       LDA #$01
$8B:9F62 85 55       STA $55    [$7E:0055]
$8B:9F64 C2 20       REP #$20
$8B:9F66 9C 23 07    STZ $0723  [$7E:0723]
$8B:9F69 9C 25 07    STZ $0725  [$7E:0725]
$8B:9F6C 64 B5       STZ $B5    [$7E:00B5]
$8B:9F6E 64 B9       STZ $B9    [$7E:00B9]
$8B:9F70 64 B7       STZ $B7    [$7E:00B7]
$8B:9F72 64 BB       STZ $BB    [$7E:00BB]
$8B:9F74 9C 8D 19    STZ $198D  [$7E:198D]
$8B:9F77 A9 68 9B    LDA #$9B68
$8B:9F7A 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9F7D 22 CD C4 8D JSL $8DC4CD[$8D:C4CD]
$8B:9F81 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]
$8B:9F85 A9 1F 1C    LDA #$1C1F
$8B:9F88 3A          DEC A
$8B:9F89 3A          DEC A
$8B:9F8A 38          SEC
$8B:9F8B E9 8D 19    SBC #$198D
$8B:9F8E AA          TAX

$8B:9F8F 9E 8D 19    STZ $198D,x[$7E:1C1D]
$8B:9F92 CA          DEX
$8B:9F93 CA          DEX
$8B:9F94 10 F9       BPL $F9    [$9F8F]
$8B:9F96 A2 FE 01    LDX #$01FE
$8B:9F99 A9 00 00    LDA #$0000

$8B:9F9C 9F 00 98 7E STA $7E9800,x[$7E:99FE]
$8B:9FA0 CA          DEX
$8B:9FA1 CA          DEX
$8B:9FA2 10 F8       BPL $F8    [$9F9C]
$8B:9FA4 A9 04 00    LDA #$0004             ;\
$8B:9FA7 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 4 (file select menus)
$8B:9FAA 9C E2 0D    STZ $0DE2  [$7E:0DE2]

$8B:9FAD 60          RTS
}


;;; $9FAE: Cinematic function - transition to demos ;;;
{
$8B:9FAE 20 97 86    JSR $8697  [$8B:8697]  ; Debug. Display version info
$8B:9FB1 20 D5 90    JSR $90D5  [$8B:90D5]  ; Advance slow screen fade out
$8B:9FB4 90 53       BCC $53    [$A009]     ; If not reached zero brightness: return
$8B:9FB6 22 4B 83 80 JSL $80834B[$80:834B]
$8B:9FBA E2 20       SEP #$20
$8B:9FBC A9 01       LDA #$01
$8B:9FBE 85 55       STA $55    [$7E:0055]
$8B:9FC0 C2 20       REP #$20
$8B:9FC2 9C 23 07    STZ $0723  [$7E:0723]
$8B:9FC5 9C 25 07    STZ $0725  [$7E:0725]
$8B:9FC8 64 B5       STZ $B5    [$7E:00B5]
$8B:9FCA 64 B9       STZ $B9    [$7E:00B9]
$8B:9FCC 64 B7       STZ $B7    [$7E:00B7]
$8B:9FCE 64 BB       STZ $BB    [$7E:00BB]
$8B:9FD0 9C 8D 19    STZ $198D  [$7E:198D]
$8B:9FD3 A9 68 9B    LDA #$9B68
$8B:9FD6 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:9FD9 22 CD C4 8D JSL $8DC4CD[$8D:C4CD]
$8B:9FDD 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]
$8B:9FE1 A9 1F 1C    LDA #$1C1F
$8B:9FE4 3A          DEC A
$8B:9FE5 3A          DEC A
$8B:9FE6 38          SEC
$8B:9FE7 E9 8D 19    SBC #$198D
$8B:9FEA AA          TAX

$8B:9FEB 9E 8D 19    STZ $198D,x[$7E:1C1D]
$8B:9FEE CA          DEX
$8B:9FEF CA          DEX
$8B:9FF0 10 F9       BPL $F9    [$9FEB]
$8B:9FF2 A2 FE 01    LDX #$01FE
$8B:9FF5 A9 00 00    LDA #$0000

$8B:9FF8 9F 00 98 7E STA $7E9800,x[$7E:99FE]
$8B:9FFC CA          DEX
$8B:9FFD CA          DEX
$8B:9FFE 10 F8       BPL $F8    [$9FF8]
$8B:A000 A9 28 00    LDA #$0028             ;\
$8B:A003 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 28h (load demo game data)
$8B:A006 9C 57 1F    STZ $1F57  [$7E:1F57]

$8B:A009 60          RTS
}


;;; $A00A: Configure title screen gradient HDMA table ;;;
{
$8B:A00A 08          PHP
$8B:A00B 8B          PHB
$8B:A00C 4B          PHK                    ;\
$8B:A00D AB          PLB                    ;} DB = $8B
$8B:A00E C2 30       REP #$30
$8B:A010 AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:A013 29 F0 00    AND #$00F0             ;|
$8B:A016 4A          LSR A                  ;|
$8B:A017 4A          LSR A                  ;|
$8B:A018 4A          LSR A                  ;} Y = [$8C:BC5D + [title sequence zoom level] / 10h % 10h * 2]
$8B:A019 AA          TAX                    ;|
$8B:A01A BF 5D BC 8C LDA $8CBC5D,x[$8C:BC5D];|
$8B:A01E A8          TAY                    ;/
$8B:A01F 8B          PHB
$8B:A020 F4 00 8C    PEA $8C00              ;\
$8B:A023 AB          PLB                    ;} DB = $8C
$8B:A024 AB          PLB                    ;/
$8B:A025 A2 00 00    LDX #$0000             ; X = 0

; LOOP
$8B:A028 B9 00 00    LDA $0000,y[$8C:BC7D]  ;\
$8B:A02B 9F 00 98 7E STA $7E9800,x[$7E:9800];} $7E:9800 + [X] = [[Y]]
$8B:A02F F0 06       BEQ $06    [$A037]     ; If [[Y]] != 0:
$8B:A031 C8          INY                    ;\
$8B:A032 C8          INY                    ;} Y += 2
$8B:A033 E8          INX                    ;\
$8B:A034 E8          INX                    ;} X += 2
$8B:A035 80 F1       BRA $F1    [$A028]     ; Go to LOOP

$8B:A037 AB          PLB
$8B:A038 AB          PLB
$8B:A039 28          PLP
$8B:A03A 6B          RTL
}


;;; $A03B: RTL ;;;
{
$8B:A03B 6B          RTL
}


;;; $A03C: RTL ;;;
{
$8B:A03C 6B          RTL
}


;;; $A03D..A0EE: Cinematic sprite object instruction lists - title sequence ;;;
{
;;; $A03D: Instruction list - cinematic sprite object $A0EF ('1994' scrolling text) ;;;
{
$8B:A03D             dx 003C,0000,
                        0008,8862,
                        0008,886E,
                        0008,8884,
                        002D,88A4,
                        9CE1,       ; Trigger title sequence scene 0
                        9438        ; Delete
}


;;; $A055: Instruction list - cinematic sprite object $A0F5 ('NINTENDO' scrolling text) ;;;
{
$8B:A055             dx 0008,88CE,
                        0008,88DA,
                        0008,88F0,
                        0008,8910,
                        0008,893A,
                        0008,896E,
                        0008,89AC,
                        002D,89F4,
                        9D5D,       ; Trigger title sequence scene 1
                        9438        ; Delete
}


;;; $A079: Instruction list - cinematic sprite object $A0FB ('PRESENTS' scrolling text) ;;;
{
$8B:A079             dx 0008,8A46,
                        0008,8A52,
                        0008,8A68,
                        0008,8A88,
                        0008,8AB2,
                        0008,8AE6,
                        0008,8B24,
                        002D,8B6C,
                        9DD6,       ; Trigger title sequence scene 2
                        9438        ; Delete
}


;;; $A09D: Instruction list - cinematic sprite object $A101 ('METROID 3' scrolling text) ;;;
{
$8B:A09D             dx 0008,8BBE,
                        0008,8BCA,
                        0008,8BE0,
                        0008,85C8,
                        0008,85F2,
                        0008,867D,
                        0008,86BB,
                        0008,8703,
                        0078,874B,
                        9E58,       ; Trigger title sequence scene 3
                        9438        ; Delete
}


;;; $A0C5: Instruction list - cinematic sprite object $A107 (Super Metroid title logo - fade in) ;;;
{
$8B:A0C5             dx 0020,879D,
                        9ECD        ; Fade in Nintendo copyright
}


;;; $A0CB: Instruction list - cinematic sprite object $A119 (Super Metroid title logo - immediate) ;;;
{
$8B:A0CB             dx 0001,879D,
                        94BC,A0CB   ; Go to $A0CB
}


;;; $A0D3: Instruction list - cinematic sprite object $A10D (unused. Nintendo boot logo - fade in) ;;;
{
$8B:A0D3             dx 0020,80BB,
                        9EF0        ; Use palette 0 and fade in Nintendo copyright
}


;;; $A0D9: Instruction list - cinematic sprite object $A11F (unused. Nintendo boot logo - immediate) ;;;
{
$8B:A0D9             dx 0001,80BB,
                        94BC,A0D9   ; Go to $A0D9
}


;;; $A0E1: Instruction list - cinematic sprite object $A113 (Nintendo copyright - fade in) ;;;
{
$8B:A0E1             dx 0020,8103,
                        9F19        ; Start demo countdown
}


;;; $A0E7: Instruction list - cinematic sprite object $A125 (Nintendo copyright - immediate) ;;;
{
$8B:A0E7             dx 0001,8103,
                        94BC,A0E7   ; Go to $A0E7
}
}


;;; $A0EF: Cinematic sprite object definitions - title sequence ;;;
{
;                        _____________ Initialisation function
;                       |     ________ Pre-instruction
;                       |    |     ___ Instruction list
;                       |    |    |
$8B:A0EF             dw 9CBC,9CCF,A03D ; '1994' scrolling text
$8B:A0F5             dw 9D4A,93D9,A055 ; 'NINTENDO' scrolling text
$8B:A0FB             dw 9DC3,93D9,A079 ; 'PRESENTS' scrolling text
$8B:A101             dw 9E45,93D9,A09D ; 'METROID 3' scrolling text
$8B:A107             dw 9EB3,93D9,A0C5 ; Super Metroid title logo - fade in
$8B:A10D             dw 9ED6,93D9,A0D3 ; Unused. Nintendo boot logo - fade in
$8B:A113             dw 9EFF,93D9,A0E1 ; Nintendo copyright - fade in
$8B:A119             dw 9B1A,93D9,A0CB ; Super Metroid title logo - immediate
$8B:A11F             dw 9B2D,93D9,A0D9 ; Unused. Nintendo boot logo - immediate
$8B:A125             dw 9B40,93D9,A0E7 ; Nintendo copyright - immediate
}


;;; $A12B: Mode 7 object instruction list ;;;
{
$8B:A12B             dw A273,
                        9597,0002,
$8B:A131             dw 000A,A337,
                        000A,A341,
                        000A,A34B,
                        000A,A341,
                        958D,A131,
                        A25B,
                        A284,
                        0006,A337,
                        A295,
                        0005,A341,
                        A2A6,
                        0004,A34B,
                        A295,
                        0003,A341,
                        A284,
                        0002,A337,
                        A295,
                        0003,A341,
                        A2A6,
                        0004,A34B,
                        A295,
                        0005,A341,
                        A284,
                        0006,A337,
                        A295,
                        0007,A341,
                        A2A6,
                        0008,A34B,
                        A295,
                        0009,A341,
                        A273,
                        9597,0004,
$8B:A195             dw 000A,A337,
                        000A,A341,
                        000A,A34B,
                        000A,A341,
                        958D,A195,
                        A263,
                        A284,
                        0006,A337,
                        A295,
                        0005,A341,
                        A2A6,
                        0004,A34B,
                        A295,
                        0003,A341,
                        A284,
                        0002,A337,
                        A295,
                        0003,A341,
                        A2A6,
                        0004,A34B,
                        A295,
                        0005,A341,
                        A284,
                        0006,A337,
                        A295,
                        0007,A341,
                        A2A6,
                        0008,A34B,
                        A295,
                        0009,A341,
                        A273,
                        9597,0003,
$8B:A1F9             dw 000A,A337,
                        000A,A341,
                        000A,A34B,
                        000A,A341,
                        958D,A1F9,
                        A26B,
                        A284,
                        0006,A337,
                        A295,
                        0005,A341,
                        A2A6,
                        0004,A34B,
                        A295,
                        0003,A341,
                        A284,
                        0002,A337,
                        A295,
                        0003,A341,
                        A2A6,
                        0004,A34B,
                        A295,
                        0005,A341,
                        A284,
                        0006,A337,
                        A295,
                        0007,A341,
                        A2A6,
                        0008,A34B,
                        A295,
                        0009,A341,
                        9586,
                        A12B
}


;;; $A25B: Play Baby Metroid cry 1 ;;;
{
$8B:A25B A9 23 00    LDA #$0023             ;\
$8B:A25E 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 23h, sound library 3, max queued sounds allowed = 6 (baby metroid cry 1)
$8B:A262 60          RTS
}


;;; $A263: Play Baby Metroid cry 2 ;;;
{
$8B:A263 A9 26 00    LDA #$0026             ;\
$8B:A266 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 26h, sound library 3, max queued sounds allowed = 6 (baby metroid cry 2)
$8B:A26A 60          RTS
}


;;; $A26B: Play Baby Metroid cry 3 ;;;
{
$8B:A26B A9 27 00    LDA #$0027             ;\
$8B:A26E 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 27h, sound library 3, max queued sounds allowed = 6 (baby metroid cry 3)
$8B:A272 60          RTS
}


;;; $A273:  ;;;
{
$8B:A273 DA          PHX
$8B:A274 A2 1E 00    LDX #$001E

$8B:A277 BD B7 A2    LDA $A2B7,x[$8B:A2D5]
$8B:A27A 9F 60 C0 7E STA $7EC060,x[$7E:C07E]
$8B:A27E CA          DEX
$8B:A27F CA          DEX
$8B:A280 10 F5       BPL $F5    [$A277]
$8B:A282 FA          PLX
$8B:A283 60          RTS
}


;;; $A284:  ;;;
{
$8B:A284 DA          PHX
$8B:A285 A2 1E 00    LDX #$001E

$8B:A288 BD D7 A2    LDA $A2D7,x[$8B:A2F5]
$8B:A28B 9F 60 C0 7E STA $7EC060,x[$7E:C07E]
$8B:A28F CA          DEX
$8B:A290 CA          DEX
$8B:A291 10 F5       BPL $F5    [$A288]
$8B:A293 FA          PLX
$8B:A294 60          RTS
}


;;; $A295:  ;;;
{
$8B:A295 DA          PHX
$8B:A296 A2 1E 00    LDX #$001E

$8B:A299 BD F7 A2    LDA $A2F7,x[$8B:A315]
$8B:A29C 9F 60 C0 7E STA $7EC060,x[$7E:C07E]
$8B:A2A0 CA          DEX
$8B:A2A1 CA          DEX
$8B:A2A2 10 F5       BPL $F5    [$A299]
$8B:A2A4 FA          PLX
$8B:A2A5 60          RTS
}


;;; $A2A6:  ;;;
{
$8B:A2A6 DA          PHX
$8B:A2A7 A2 1E 00    LDX #$001E

$8B:A2AA BD 17 A3    LDA $A317,x[$8B:A335]
$8B:A2AD 9F 60 C0 7E STA $7EC060,x[$7E:C07E]
$8B:A2B1 CA          DEX
$8B:A2B2 CA          DEX
$8B:A2B3 10 F5       BPL $F5    [$A2AA]
$8B:A2B5 FA          PLX
$8B:A2B6 60          RTS
}


;;; $A2B7: Palettes ;;;
{
$8B:A2B7             dw 1000,6BF5,2E41,2DA1,2D01,5E5F,183F,1014,080A,0404,4F9F,3ED8,2E12,6F70,7FFF,5EE0
$8B:A2D7             dw 3800,6BF5,06E1,0641,05A1,5E5F,183F,1014,080A,0404,4F9F,3ED8,2E12,6F70,7FFF,5EE0
$8B:A2F7             dw 3800,77F8,1344,12A4,1204,6ABF,249F,1C77,146D,1067,5BFF,4B38,3A72,7BD3,7FFF,6B43
$8B:A317             dw 3800,7FFB,1FA7,1F07,1E67,771F,30FF,28DA,20D0,1CCA,67FF,579B,46D5,7BD6,7FFF,77A6
}


;;; $A337: Mode 7 transfer data ;;;
{
;                        ______________________ Control. C0h = write to VRAM tiles
;                       |   ___________________ Source address
;                       |  |       ____________ Size
;                       |  |      |     _______ Destination address (VRAM)
;                       |  |      |    |     __ VRAM address increment mode
;                       |  |      |    |    |
$8B:A337             dx C0,7F9000,0100,3800,80, 00
$8B:A341             dx C0,7F9100,0100,3800,80, 00
$8B:A34B             dx C0,7F9200,0100,3800,80, 00
}


;;; $A355: Mode 7 object - baby metroid in title sequence ;;;
{
;                        _______________ Initialisation function
;                       |      _________ Pre-instruction
;                       |     |      ___ Instruction list pointer
;                       |     |     |
$8B:A355             dw 93D9, 93D9, A12B
}


;;; $A35B: Game state 1Eh/22h/25h (intro / Ceres goes boom, Samus goes to Zebes / Ceres goes boom with Samus) ;;;
{
$8B:A35B 08          PHP
$8B:A35C 8B          PHB
$8B:A35D 4B          PHK                    ;\
$8B:A35E AB          PLB                    ;} DB = $8B
$8B:A35F C2 30       REP #$30
$8B:A361 F4 66 A3    PEA $A366              ;\
$8B:A364 6C 51 1F    JMP ($1F51)[$8B:A395]  ;} Execute [cinematic function]

$8B:A367 AD 9F 1B    LDA $1B9F  [$7E:1B9F]  ;\
$8B:A36A 30 04       BMI $04    [$A370]     ;} If [$1B9F] >= 0:
$8B:A36C 1A          INC A                  ;\
$8B:A36D 8D 9F 1B    STA $1B9F  [$7E:1B9F]  ;} Increment $1B9F

$8B:A370 EE 51 1A    INC $1A51  [$7E:1A51]  ; Increment cinematic frame counter
$8B:A373 20 0D 8E    JSR $8E0D  [$8B:8E0D]  ; Handle Samus during intro
$8B:A376 20 EF 93    JSR $93EF  [$8B:93EF]  ; Handle cinematic sprite objects (rinkas, MB, Ceres + space, next-page arrow)
$8B:A379 20 1D 95    JSR $951D  [$8B:951D]  ; Handle mode 7 objects (Japanese text)
$8B:A37C 20 2F 96    JSR $962F  [$8B:962F]  ; Handle cinematic BG objects (text, Samus blinking)
$8B:A37F 20 28 98    JSR $9828  [$8B:9828]  ; Handle text glow objects
$8B:A382 22 27 C5 8D JSL $8DC527[$8D:C527]  ; Palette FX object handler
$8B:A386 20 2D 8E    JSR $8E2D  [$8B:8E2D]  ; Draw intro sprites
$8B:A389 20 32 85    JSR $8532  [$8B:8532]  ; Handle mode 7 transformation matrix
$8B:A38C AB          PLB
$8B:A38D 28          PLP
$8B:A38E 6B          RTL
}


;;; $A38F: RTS ;;;
{
$8B:A38F 60          RTS
}


;;; $A390: RTS ;;;
{
$8B:A390 60          RTS
}


;;; $A391: Cinematic function - nothing ;;;
{
$8B:A391 20 10 B7    JSR $B710  [$8B:B710]  ; RTS
$8B:A394 60          RTS
}


;;; $A395: Cinematic function - intro - initial ;;;
{
$8B:A395 20 DA 80    JSR $80DA  [$8B:80DA]  ; Execute $80DA (initialise PPU regs, clear RAM)
$8B:A398 64 AB       STZ $AB    [$7E:00AB]  ; Interrupt command = nothing
$8B:A39A 64 A7       STZ $A7    [$7E:00A7]  ; Next interrupt command = nothing
$8B:A39C 9C 9F 07    STZ $079F  [$7E:079F]  ; Area index = Crateria
$8B:A39F A9 10 00    LDA #$0010             ;\
$8B:A3A2 8D A5 07    STA $07A5  [$7E:07A5]  ;} Room width = 10h blocks
$8B:A3A5 8D A7 07    STA $07A7  [$7E:07A7]  ; Room height = 10h blocks
$8B:A3A8 22 0D E0 91 JSL $91E00D[$91:E00D]  ; Initialise Samus
$8B:A3AC 22 8D AC 90 JSL $90AC8D[$90:AC8D]  ; Update beam tiles and palette
$8B:A3B0 A9 84 03    LDA #$0384             ;\
$8B:A3B3 8D C8 09    STA $09C8  [$7E:09C8]  ;} Samus max missiles = 900 (I'd like to see an intro movie that uses 900 missiles...)
$8B:A3B6 8D C6 09    STA $09C6  [$7E:09C6]  ; Samus missiles = 900
$8B:A3B9 9C 57 1A    STZ $1A57  [$7E:1A57]  ; $1A57 = 0
$8B:A3BC A9 52 EB    LDA #$EB52             ;\
$8B:A3BF 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$8B:A3C2 20 08 BC    JSR $BC08  [$8B:BC08]  ; Reset button assignments to default
$8B:A3C5 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$8B:A3C8 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knockback timer = 0
$8B:A3CB A9 1F 1C    LDA #$1C1F             ;\
$8B:A3CE 3A          DEC A                  ;|
$8B:A3CF 3A          DEC A                  ;|
$8B:A3D0 38          SEC                    ;|
$8B:A3D1 E9 8D 19    SBC #$198D             ;|
$8B:A3D4 AA          TAX                    ;} Clear non-gameplay use RAM
                                            ;|
$8B:A3D5 9E 8D 19    STZ $198D,x[$7E:1C1D]  ;|
$8B:A3D8 CA          DEX                    ;|
$8B:A3D9 CA          DEX                    ;|
$8B:A3DA 10 F9       BPL $F9    [$A3D5]     ;/
$8B:A3DC A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:A3DF BF E9 E3 8C LDA $8CE3E9,x[$8C:E3E9];|
$8B:A3E3 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$8B:A3E7 E8          INX                    ;} Load intro palettes
$8B:A3E8 E8          INX                    ;|
$8B:A3E9 E0 00 02    CPX #$0200             ;|
$8B:A3EC 30 F1       BMI $F1    [$A3DF]     ;/
$8B:A3EE A9 00 95    LDA #$9500             ;\
$8B:A3F1 85 48       STA $48    [$7E:0048]  ;|
$8B:A3F3 A9 0E F9    LDA #$F90E             ;|
$8B:A3F6 85 47       STA $47    [$7E:0047]  ;} Decompress intro BG1/2 tiles to $7F:0000
$8B:A3F8 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:A3FC             dl 7F0000              ;/
$8B:A3FF A9 00 95    LDA #$9500             ;\
$8B:A402 85 48       STA $48    [$7E:0048]  ;|
$8B:A404 A9 89 D0    LDA #$D089             ;|
$8B:A407 85 47       STA $47    [$7E:0047]  ;} Decompress font 1 tiles to $7F:8000
$8B:A409 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:A40D             dl 7F8000              ;/
$8B:A410 A9 00 97    LDA #$9700             ;\
$8B:A413 85 48       STA $48    [$7E:0048]  ;|
$8B:A415 A9 CC 88    LDA #$88CC             ;|
$8B:A418 85 47       STA $47    [$7E:0047]  ;} Decompress intro BG2 tilemap to $7F:9000 (Samus head)
$8B:A41A 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:A41E             dl 7F9000              ;/
$8B:A421 A9 00 96    LDA #$9600             ;\
$8B:A424 85 48       STA $48    [$7E:0048]  ;|
$8B:A426 A9 14 FF    LDA #$FF14             ;|
$8B:A429 85 47       STA $47    [$7E:0047]  ;} Decompress intro BG1 tilemap to $7F:9800 (Mother Brain's room)
$8B:A42B 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:A42F             dl 7F9800              ;/
$8B:A432 A9 00 95    LDA #$9500             ;\
$8B:A435 85 48       STA $48    [$7E:0048]  ;|
$8B:A437 A9 C2 E4    LDA #$E4C2             ;|
$8B:A43A 85 47       STA $47    [$7E:0047]  ;} Decompress intro sprite tiles to $7F:B800
$8B:A43C 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:A440             dl 7FB800              ;/
$8B:A443 A9 00 97    LDA #$9700             ;\
$8B:A446 85 48       STA $48    [$7E:0048]  ;|
$8B:A448 A9 12 8D    LDA #$8D12             ;|
$8B:A44B 85 47       STA $47    [$7E:0047]  ;} Decompress intro BG3 tilemap to $7F:E000 (the last Metroid is in captivity)
$8B:A44D 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:A451             dl 7FE000              ;/
$8B:A454 E2 30       SEP #$30
$8B:A456 A9 00       LDA #$00               ;\
$8B:A458 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:A45B A9 00       LDA #$00               ;|
$8B:A45D 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:A460 A9 80       LDA #$80               ;|
$8B:A462 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..3FFF = [$7F:0000..7FFF] (intro BG1/2 tiles)
$8B:A465 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:A469             dx 01,01,18,7F0000,8000;|
$8B:A471 A9 02       LDA #$02               ;|
$8B:A473 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:A476 A9 00       LDA #$00               ;\
$8B:A478 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:A47B A9 40       LDA #$40               ;|
$8B:A47D 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:A480 A9 80       LDA #$80               ;|
$8B:A482 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4000..447F = [$7F:8000..88FF] (font 1 tiles)
$8B:A485 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:A489             dx 01,01,18,7F8000,0900;|
$8B:A491 A9 02       LDA #$02               ;|
$8B:A493 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:A496 A9 00       LDA #$00               ;\
$8B:A498 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:A49B A9 48       LDA #$48               ;|
$8B:A49D 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:A4A0 A9 80       LDA #$80               ;|
$8B:A4A2 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4800..4BFF = [$7F:9000..97FF] (BG2 tilemap - Samus head)
$8B:A4A5 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:A4A9             dx 01,01,18,7F9000,0800;|
$8B:A4B1 A9 02       LDA #$02               ;|
$8B:A4B3 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:A4B6 A9 00       LDA #$00               ;\
$8B:A4B8 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:A4BB A9 4C       LDA #$4C               ;|
$8B:A4BD 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:A4C0 A9 80       LDA #$80               ;|
$8B:A4C2 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4C00..4FFF = [$7F:E000..E7FF] (BG3 tilemap - the last Metroid is in captivity)
$8B:A4C5 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:A4C9             dx 01,01,18,7FE000,0800;|
$8B:A4D1 A9 02       LDA #$02               ;|
$8B:A4D3 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:A4D6 A9 00       LDA #$00               ;\
$8B:A4D8 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:A4DB A9 50       LDA #$50               ;|
$8B:A4DD 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:A4E0 A9 80       LDA #$80               ;|
$8B:A4E2 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $5000..5FFF = [$7F:9800..B7FF] (BG1 tilemap - Mother Brain's room)
$8B:A4E5 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:A4E9             dx 01,01,18,7F9800,2000;|
$8B:A4F1 A9 02       LDA #$02               ;|
$8B:A4F3 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:A4F6 A9 00       LDA #$00               ;\
$8B:A4F8 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:A4FB A9 60       LDA #$60               ;|
$8B:A4FD 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:A500 A9 80       LDA #$80               ;|
$8B:A502 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $6000..6FFF = [$9A:D200..F1FF] (standard sprite tiles)
$8B:A505 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:A509             dx 01,01,18,9AD200,2000;|
$8B:A511 A9 02       LDA #$02               ;|
$8B:A513 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:A516 A9 00       LDA #$00               ;\
$8B:A518 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:A51B A9 6E       LDA #$6E               ;|
$8B:A51D 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:A520 A9 80       LDA #$80               ;|
$8B:A522 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $6E00..7FFF = [$7F:B800..DBFF] (intro sprite tiles)
$8B:A525 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:A529             dx 01,01,18,7FB800,2400;|
$8B:A531 A9 02       LDA #$02               ;|
$8B:A533 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:A536 C2 30       REP #$30
$8B:A538 A9 00 95    LDA #$9500             ;\
$8B:A53B 85 48       STA $48    [$7E:0048]  ;|
$8B:A53D A9 13 D7    LDA #$D713             ;|
$8B:A540 85 47       STA $47    [$7E:0047]  ;} Decompress font 2 tiles to $7F:A000
$8B:A542 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:A546             dl 7FA000              ;/
$8B:A549 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$8B:A54D A9 03 00    LDA #$0003             ;\
$8B:A550 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 3
$8B:A553 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 3
$8B:A556 22 88 82 88 JSL $888288[$88:8288]  ; Enable HDMA objects
$8B:A55A 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]  ; Clear palette FX objects
$8B:A55E 22 C2 C4 8D JSL $8DC4C2[$8D:C4C2]  ; Enable palette FX objects
$8B:A562 9C 8D 07    STZ $078D  [$7E:078D]  ; Door pointer = 0
$8B:A565 9C 11 09    STZ $0911  [$7E:0911]  ; Layer 1 X position = 0
$8B:A568 9C 15 09    STZ $0915  [$7E:0915]  ; Layer 1 Y position = 0
$8B:A56B 9C A3 1B    STZ $1BA3  [$7E:1BA3]  ; $1BA3 = 0
$8B:A56E A2 FE 07    LDX #$07FE             ;\
                                            ;|
$8B:A571 BF 00 90 7F LDA $7F9000,x[$7F:97FE];|
$8B:A575 9F 00 38 7E STA $7E3800,x[$7E:3FFE];} $7E:3800..3FFF = [$7F:9000..97FF] (BG2 tilemap - Samus head)
$8B:A579 CA          DEX                    ;|
$8B:A57A CA          DEX                    ;|
$8B:A57B 10 F4       BPL $F4    [$A571]     ;/
$8B:A57D A2 FE 00    LDX #$00FE             ;\
                                            ;|
$8B:A580 BF 1B D8 8C LDA $8CD81B,x[$8C:D919];|
$8B:A584 9F 00 30 7E STA $7E3000,x[$7E:30FE];} $7E:3000..FF = [$8C:D81B..D91A] (initial Japanese text)
$8B:A588 CA          DEX                    ;|
$8B:A589 CA          DEX                    ;|
$8B:A58A 10 F4       BPL $F4    [$A580]     ;/
$8B:A58C A9 FF FF    LDA #$FFFF             ;\
$8B:A58F 8D 9F 1B    STA $1B9F  [$7E:1B9F]  ;} $1B9F = FFFFh
$8B:A592 A9 A7 A5    LDA #$A5A7             ;\
$8B:A595 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A5A7
$8B:A598 A9 00 00    LDA #$0000             ;\
$8B:A59B 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$8B:A59F A9 3F FF    LDA #$FF3F             ;\
$8B:A5A2 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue "the last Metroid is in captivity" music data
$8B:A5A6 60          RTS
}


;;; $A5A7: Cinematic function - intro - wait for music queue and fade in ;;;
{
$8B:A5A7 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$8B:A5AB B0 0F       BCS $0F    [$A5BC]     ;} If music is queued: return
$8B:A5AD A9 BD A5    LDA #$A5BD             ;\
$8B:A5B0 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A5BD
$8B:A5B3 A9 02 00    LDA #$0002             ;\
$8B:A5B6 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 2
$8B:A5B9 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 2

$8B:A5BC 60          RTS
}


;;; $A5BD: Cinematic function - intro - handle drawing initial Japanese text and wait 60 frames ;;;
{
$8B:A5BD 20 1B 91    JSR $911B  [$8B:911B]  ; Advance slow screen fade in
$8B:A5C0 90 35       BCC $35    [$A5F7]     ; If not reached max brightness: return
$8B:A5C2 A9 F8 A5    LDA #$A5F8             ;\
$8B:A5C5 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A5F8
$8B:A5C8 A9 3C 00    LDA #$003C             ;\
$8B:A5CB 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 60
$8B:A5CE AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$8B:A5D1 F0 24       BEQ $24    [$A5F7]     ;} If Japanese text is enabled:
$8B:A5D3 AE 30 03    LDX $0330  [$7E:0330]  ;\
$8B:A5D6 A9 00 01    LDA #$0100             ;|
$8B:A5D9 95 D0       STA $D0,x              ;|
$8B:A5DB E8          INX                    ;|
$8B:A5DC E8          INX                    ;|
$8B:A5DD A9 00 30    LDA #$3000             ;|
$8B:A5E0 95 D0       STA $D0,x              ;|
$8B:A5E2 E8          INX                    ;|
$8B:A5E3 E8          INX                    ;|
$8B:A5E4 E2 20       SEP #$20               ;} Queue DMA for VRAM $4EE0..4F5F = [$7E:3000..FF]
$8B:A5E6 A9 7E       LDA #$7E               ;|
$8B:A5E8 95 D0       STA $D0,x              ;|
$8B:A5EA C2 20       REP #$20               ;|
$8B:A5EC E8          INX                    ;|
$8B:A5ED A9 E0 4E    LDA #$4EE0             ;|
$8B:A5F0 95 D0       STA $D0,x              ;|
$8B:A5F2 E8          INX                    ;|
$8B:A5F3 E8          INX                    ;|
$8B:A5F4 8E 30 03    STX $0330  [$7E:0330]  ;/

$8B:A5F7 60          RTS
}


;;; $A5F8: Cinematic function - intro - play "the last Metroid is in captivity" music for 200 frames ;;;
{
$8B:A5F8 CE 49 1A    DEC $1A49  [$7E:1A49]  ; Decrement cinematic function timer
$8B:A5FB F0 02       BEQ $02    [$A5FF]     ;\
$8B:A5FD 10 13       BPL $13    [$A612]     ;} If [cinematic function timer] > 0: return

$8B:A5FF A9 13 A6    LDA #$A613             ;\
$8B:A602 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A613
$8B:A605 A9 C8 00    LDA #$00C8             ;\
$8B:A608 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 200
$8B:A60B A9 05 00    LDA #$0005             ;\
$8B:A60E 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track

$8B:A612 60          RTS
}


;;; $A613: Cinematic function - intro - queue "the galaxy is at peace" music ;;;
{
$8B:A613 CE 49 1A    DEC $1A49  [$7E:1A49]  ; Decrement cinematic function timer
$8B:A616 F0 02       BEQ $02    [$A61A]     ;\
$8B:A618 10 1E       BPL $1E    [$A638]     ;} If [cinematic function timer] > 0: return

$8B:A61A A9 00 00    LDA #$0000             ;\
$8B:A61D 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$8B:A621 A9 42 FF    LDA #$FF42             ;\
$8B:A624 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue "the galaxy is at peace" music data
$8B:A628 A9 05 00    LDA #$0005             ;\
$8B:A62B A0 0E 00    LDY #$000E             ;} Queue song 0 music track, 14 frame delay
$8B:A62E 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/
$8B:A632 A9 39 A6    LDA #$A639             ;\
$8B:A635 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A639

$8B:A638 60          RTS
}


;;; $A639: Cinematic function - intro - wait for music queue and wait 240 frames ;;;
{
$8B:A639 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$8B:A63D B0 0C       BCS $0C    [$A64B]     ;} If music is queued: return
$8B:A63F A9 4C A6    LDA #$A64C             ;\
$8B:A642 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A64C
$8B:A645 A9 F0 00    LDA #$00F0             ;\
$8B:A648 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 240

$8B:A64B 60          RTS
}


;;; $A64C: Cinematic function - intro - fade out ;;;
{
$8B:A64C CE 49 1A    DEC $1A49  [$7E:1A49]  ; Decrement cinematic function timer
$8B:A64F F0 02       BEQ $02    [$A653]     ;\
$8B:A651 10 0F       BPL $0F    [$A662]     ;} If [cinematic function timer] > 0: return

$8B:A653 A9 63 A6    LDA #$A663             ;\
$8B:A656 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A663
$8B:A659 A9 02 00    LDA #$0002             ;\
$8B:A65C 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 2
$8B:A65F 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 2

$8B:A662 60          RTS
}


;;; $A663: Cinematic function - intro - wait for fade out ;;;
{
$8B:A663 20 D5 90    JSR $90D5  [$8B:90D5]  ; Advance slow screen fade out
$8B:A666 90 06       BCC $06    [$A66E]     ; If not reached zero brightness: return
$8B:A668 A9 6F A6    LDA #$A66F             ;\
$8B:A66B 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A66F

$8B:A66E 60          RTS
}


;;; $A66F: Cinematic function - intro - set up intro text page 1 ;;;
{
$8B:A66F C2 30       REP #$30
$8B:A671 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:A674 E2 30       SEP #$30
$8B:A676 A9 80       LDA #$80               ;\
$8B:A678 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:A67B A9 41       LDA #$41               ;|
$8B:A67D 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:A680 A9 80       LDA #$80               ;|
$8B:A682 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4180..447F = [$7E:4000..45FF] (Japanese tiles)
$8B:A685 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:A689             dx 01,01,18,7E4000,0600;|
$8B:A691 A9 02       LDA #$02               ;|
$8B:A693 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:A696 A9 16       LDA #$16               ;\
$8B:A698 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen sublayers = BG2/BG3/sprites
$8B:A69B 85 69       STA $69    [$7E:0069]  ;/
$8B:A69D C2 30       REP #$30
$8B:A69F A9 2F 00    LDA #$002F             ;\
$8B:A6A2 22 CE 95 8B JSL $8B95CE[$8B:95CE]  ;} Clear cinematic BG objects, cinematic BG tilemap = 002Fh
$8B:A6A6 22 A2 95 8B JSL $8B95A2[$8B:95A2]  ; Enable cinematic BG objects
$8B:A6AA 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:A6AE A9 00 4C    LDA #$4C00             ;\
$8B:A6B1 8D F5 19    STA $19F5  [$7E:19F5]  ;} Cinematic BG VRAM address = $4C00 (BG3 tilemap)
$8B:A6B4 A2 FE 00    LDX #$00FE             ;\
$8B:A6B7 A9 29 3C    LDA #$3C29             ;|
                                            ;|
$8B:A6BA 9F 00 30 7E STA $7E3000,x[$7E:30FE];|
$8B:A6BE 9F 00 37 7E STA $7E3700,x[$7E:37FE];} $7E:3000..FF = $7E:3700..FF = 3C29h (top/bottom margins)
$8B:A6C2 CA          DEX                    ;|
$8B:A6C3 CA          DEX                    ;|
$8B:A6C4 10 F4       BPL $F4    [$A6BA]     ;/
$8B:A6C6 A2 00 06    LDX #$0600             ;\
$8B:A6C9 A0 00 00    LDY #$0000             ;|
                                            ;|
$8B:A6CC B9 2B A7    LDA $A72B,y[$8B:A72B]  ;|
$8B:A6CF 9F 00 30 7E STA $7E3000,x[$7E:3600];|
$8B:A6D3 C8          INY                    ;} $7E:3600..FF = [$A72B..A82A] (Japanese text region)
$8B:A6D4 C8          INY                    ;|
$8B:A6D5 E8          INX                    ;|
$8B:A6D6 E8          INX                    ;|
$8B:A6D7 E0 00 07    CPX #$0700             ;|
$8B:A6DA 30 F0       BMI $F0    [$A6CC]     ;/
$8B:A6DC A9 29 1C    LDA #$1C29             ;\
$8B:A6DF 8F 1E 37 7E STA $7E371E[$7E:371E]  ;} Clear $7E:371E..21 priority bits (where the Japanese text next-page arrow goes)
$8B:A6E3 8F 20 37 7E STA $7E3720[$7E:3720]  ;/
$8B:A6E7 A0 6D CE    LDY #$CE6D             ;\
$8B:A6EA 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE6D (intro text caret)
$8B:A6ED A9 7F 00    LDA #$007F             ;\
$8B:A6F0 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 7Fh (used for fade into MB fight scene)
$8B:A6F3 A0 63 CF    LDY #$CF63             ;\
$8B:A6F6 A9 00 4C    LDA #$4C00             ;} Spawn Samus blinking cinematic BG object for VRAM $4C00
$8B:A6F9 20 F0 95    JSR $95F0  [$8B:95F0]  ;/
$8B:A6FC A9 08 00    LDA #$0008             ;\
$8B:A6FF 8D 97 19    STA $1997  [$7E:1997]  ;|
$8B:A702 85 B7       STA $B7    [$7E:00B7]  ;} BG2 Y scroll = BG3 Y scroll = $1997 = 8
$8B:A704 85 BB       STA $BB    [$7E:00BB]  ;/
$8B:A706 20 56 A8    JSR $A856  [$8B:A856]  ; Clear English text tilemap
$8B:A709 20 EE AD    JSR $ADEE  [$8B:ADEE]  ; Execute $ADEE (sets some stuff for the sprite object)
$8B:A70C A9 00 00    LDA #$0000             ;\
$8B:A70F 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$8B:A713 A9 36 FF    LDA #$FF36             ;\
$8B:A716 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue intro music data
$8B:A71A A9 05 00    LDA #$0005             ;\
$8B:A71D A0 0E 00    LDY #$000E             ;} Queue song 0 music track, 14 frame delay
$8B:A720 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/
$8B:A724 A9 2B A8    LDA #$A82B             ;\
$8B:A727 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A82B
$8B:A72A 60          RTS

$8B:A72B             dw 3C29, 3C29, 3C29, 3C29, 3030, 3031, 3032, 3033, 3034, 3035, 3036, 3037, 3038, 3039, 303A, 303B, 303C, 303D, 303E, 303F, 3040, 3041, 3042, 3043, 3044, 3045, 3046, 3047, 3C29, 3C29, 3C29, 3C29,
                        3C29, 3C29, 3C29, 3C29, 3060, 3061, 3062, 3063, 3064, 3065, 3066, 3067, 3068, 3069, 306A, 306B, 306C, 306D, 306E, 306F, 3070, 3071, 3072, 3073, 3074, 3075, 3076, 3077, 3C29, 3C29, 3C29, 3C29,
                        3C29, 3C29, 3C29, 3C29, 3048, 3049, 304A, 304B, 304C, 304D, 304E, 304F, 3050, 3051, 3052, 3053, 3054, 3055, 3056, 3057, 3058, 3059, 305A, 305B, 305C, 305D, 305E, 305F, 3C29, 3C29, 3C29, 3C29,
                        3C29, 3C29, 3C29, 3C29, 3078, 3079, 307A, 307B, 307C, 307D, 307E, 307F, 3080, 3081, 3082, 3083, 3084, 3085, 3086, 3087, 3088, 3089, 308A, 308B, 308C, 308D, 308E, 308F, 3C29, 3C29, 3C29, 3C29
}


;;; $A82B: Cinematic function - intro - wait for music queue, fade in and spawn intro text page 1 ;;;
{
$8B:A82B 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$8B:A82F B0 18       BCS $18    [$A849]     ;} If music is queued: return
$8B:A831 A9 4A A8    LDA #$A84A             ;\
$8B:A834 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $A84A
$8B:A837 A9 02 00    LDA #$0002             ;\
$8B:A83A 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 2
$8B:A83D 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 2
$8B:A840 A0 3F CF    LDY #$CF3F             ;\
$8B:A843 A9 00 4C    LDA #$4C00             ;} Spawn intro text page 1 cinematic BG object for VRAM $4C00
$8B:A846 20 F0 95    JSR $95F0  [$8B:95F0]  ;/

$8B:A849 60          RTS
}


;;; $A84A: Cinematic function - intro - wait for fade in and sleep ;;;
{
$8B:A84A 20 1B 91    JSR $911B  [$8B:911B]  ; Advance slow screen fade in
$8B:A84D 90 06       BCC $06    [$A855]     ; If not reached max brightness: return
$8B:A84F A9 91 A3    LDA #$A391             ;\
$8B:A852 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = nothing

$8B:A855 60          RTS
}


;;; $A856: Clear English text tilemap ;;;
{
$8B:A856 DA          PHX
$8B:A857 A2 00 01    LDX #$0100
$8B:A85A A9 2F 00    LDA #$002F

$8B:A85D 9F 00 30 7E STA $7E3000,x[$7E:3100]
$8B:A861 E8          INX
$8B:A862 E8          INX
$8B:A863 E0 00 06    CPX #$0600
$8B:A866 30 F5       BMI $F5    [$A85D]
$8B:A868 FA          PLX
$8B:A869 60          RTS
}


;;; $A86A: Blank out Japanese text tiles ;;;
{
$8B:A86A 08          PHP
$8B:A86B C2 30       REP #$30
$8B:A86D DA          PHX
$8B:A86E 5A          PHY
$8B:A86F A2 00 00    LDX #$0000             ; X = 0

; LOOP
$8B:A872 AF 90 82 7F LDA $7F8290[$7F:8290]  ;\
$8B:A876 9F 00 40 7E STA $7E4000,x[$7E:4000];|
$8B:A87A AF 92 82 7F LDA $7F8292[$7F:8292]  ;|
$8B:A87E 9F 02 40 7E STA $7E4002,x[$7E:4002];|
$8B:A882 AF 94 82 7F LDA $7F8294[$7F:8294]  ;|
$8B:A886 9F 04 40 7E STA $7E4004,x[$7E:4004];|
$8B:A88A AF 96 82 7F LDA $7F8296[$7F:8296]  ;|
$8B:A88E 9F 06 40 7E STA $7E4006,x[$7E:4006];|
$8B:A892 AF 98 82 7F LDA $7F8298[$7F:8298]  ;} Copy 10h bytes from $7F:8290 to $7E:4000 + [X] (blank tile)
$8B:A896 9F 08 40 7E STA $7E4008,x[$7E:4008];|
$8B:A89A AF 9A 82 7F LDA $7F829A[$7F:829A]  ;|
$8B:A89E 9F 0A 40 7E STA $7E400A,x[$7E:400A];|
$8B:A8A2 AF 9C 82 7F LDA $7F829C[$7F:829C]  ;|
$8B:A8A6 9F 0C 40 7E STA $7E400C,x[$7E:400C];|
$8B:A8AA AF 9E 82 7F LDA $7F829E[$7F:829E]  ;|
$8B:A8AE 9F 0E 40 7E STA $7E400E,x[$7E:400E];/
$8B:A8B2 8A          TXA                    ;\
$8B:A8B3 18          CLC                    ;|
$8B:A8B4 69 10 00    ADC #$0010             ;} X += 10h
$8B:A8B7 AA          TAX                    ;/
$8B:A8B8 E0 00 06    CPX #$0600             ;\
$8B:A8BB 30 B5       BMI $B5    [$A872]     ;} If [X] < 600h: go to LOOP
$8B:A8BD 7A          PLY
$8B:A8BE FA          PLX
$8B:A8BF 28          PLP
$8B:A8C0 60          RTS
}


;;; $A8C1:  ;;;
{
$8B:A8C1 A9 08 00    LDA #$0008
$8B:A8C4 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:A8C7 A9 18 00    LDA #$0018
$8B:A8CA 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:A8CD A9 00 0C    LDA #$0C00
$8B:A8D0 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:A8D3 60          RTS
}


;;; $A8D4: RTS ;;;
{
$8B:A8D4 60          RTS
}


;;; $A8D5:  ;;;
{
$8B:A8D5 A9 70 00    LDA #$0070
$8B:A8D8 99 7D 1A    STA $1A7D,y[$7E:1A99]
$8B:A8DB A9 9B 00    LDA #$009B
$8B:A8DE 99 9D 1A    STA $1A9D,y[$7E:1AB9]
$8B:A8E1 A9 00 0E    LDA #$0E00
$8B:A8E4 99 BD 1A    STA $1ABD,y[$7E:1AD9]
$8B:A8E7 60          RTS
}


;;; $A8E8:  ;;;
{
$8B:A8E8 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$8B:A8EB C9 A9 00    CMP #$00A9
$8B:A8EE 10 12       BPL $12    [$A902]
$8B:A8F0 A9 01 00    LDA #$0001
$8B:A8F3 9D 5D 1B    STA $1B5D,x[$7E:1B79]
$8B:A8F6 A9 3B CB    LDA #$CB3B
$8B:A8F9 9D 1D 1B    STA $1B1D,x[$7E:1B39]
$8B:A8FC A9 D9 93    LDA #$93D9
$8B:A8FF 9D 3D 1B    STA $1B3D,x[$7E:1B59]

$8B:A902 60          RTS
}


;;; $A903: Pre-instruction ;;;
{
; Used by cinematic sprite object $CE5B (metroid egg)
$8B:A903 AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:A906 D0 0F       BNE $0F    [$A917]
$8B:A908 A9 01 00    LDA #$0001
$8B:A90B 9D 5D 1B    STA $1B5D,x[$7E:1B79]
$8B:A90E A9 53 CE    LDA #$CE53
$8B:A911 9D 1D 1B    STA $1B1D,x[$7E:1B39]
$8B:A914 9C 57 1A    STZ $1A57  [$7E:1A57]

$8B:A917 60          RTS
}


;;; $A918: Instruction - spawn metroid egg particles ;;;
{
$8B:A918 5A          PHY
$8B:A919 A9 00 00    LDA #$0000
$8B:A91C A0 CD CE    LDY #$CECD             ;\
$8B:A91F 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CECD (metroid egg particle 1)
$8B:A922 A9 01 00    LDA #$0001
$8B:A925 A0 D3 CE    LDY #$CED3             ;\
$8B:A928 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CED3 (metroid egg particle 2)
$8B:A92B A9 02 00    LDA #$0002
$8B:A92E A0 D9 CE    LDY #$CED9             ;\
$8B:A931 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CED9 (metroid egg particle 3)
$8B:A934 A9 03 00    LDA #$0003
$8B:A937 A0 DF CE    LDY #$CEDF             ;\
$8B:A93A 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEDF (metroid egg particle 4)
$8B:A93D A9 04 00    LDA #$0004
$8B:A940 A0 E5 CE    LDY #$CEE5             ;\
$8B:A943 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEE5 (metroid egg particle 5)
$8B:A946 A9 05 00    LDA #$0005
$8B:A949 A0 EB CE    LDY #$CEEB             ;\
$8B:A94C 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEEB (metroid egg particle 6)
$8B:A94F A9 0B 00    LDA #$000B             ;\
$8B:A952 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound Bh, sound library 2, max queued sounds allowed = 6 (enemy killed by contact damage)
$8B:A956 7A          PLY
$8B:A957 60          RTS
}


;;; $A958:  ;;;
{
$8B:A958 AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:A95B 99 7D 1B    STA $1B7D,y[$7E:1B95]
$8B:A95E 0A          ASL A
$8B:A95F 0A          ASL A
$8B:A960 AA          TAX
$8B:A961 BD 7C A9    LDA $A97C,x[$8B:A97C]
$8B:A964 18          CLC
$8B:A965 69 10 00    ADC #$0010
$8B:A968 99 7D 1A    STA $1A7D,y[$7E:1A95]
$8B:A96B BD 7E A9    LDA $A97E,x[$8B:A97E]
$8B:A96E 18          CLC
$8B:A96F 69 3B 00    ADC #$003B
$8B:A972 99 9D 1A    STA $1A9D,y[$7E:1AB5]
$8B:A975 A9 00 0E    LDA #$0E00
$8B:A978 99 BD 1A    STA $1ABD,y[$7E:1AD5]
$8B:A97B 60          RTS

$8B:A97C             dw 005C,0058, 0063,0058, 0059,005D, 0060,005B, 0066,005E, 0063,0060
}


;;; $A994:  ;;;
{
$8B:A994 BD 7D 1B    LDA $1B7D,x[$7E:1B95]
$8B:A997 29 FF 00    AND #$00FF
$8B:A99A 0A          ASL A
$8B:A99B 0A          ASL A
$8B:A99C A8          TAY
$8B:A99D BD DD 1A    LDA $1ADD,x[$7E:1AF5]
$8B:A9A0 18          CLC
$8B:A9A1 79 EC A9    ADC $A9EC,y[$8B:A9EC]
$8B:A9A4 9D DD 1A    STA $1ADD,x[$7E:1AF5]
$8B:A9A7 BD 7D 1A    LDA $1A7D,x[$7E:1A95]
$8B:A9AA 79 EA A9    ADC $A9EA,y[$8B:A9EA]
$8B:A9AD 9D 7D 1A    STA $1A7D,x[$7E:1A95]
$8B:A9B0 BD 7D 1B    LDA $1B7D,x[$7E:1B95]
$8B:A9B3 EB          XBA
$8B:A9B4 29 FF 00    AND #$00FF
$8B:A9B7 0A          ASL A
$8B:A9B8 0A          ASL A
$8B:A9B9 A8          TAY
$8B:A9BA BD FD 1A    LDA $1AFD,x[$7E:1B15]
$8B:A9BD 18          CLC
$8B:A9BE 79 04 AA    ADC $AA04,y[$8B:AA04]
$8B:A9C1 9D FD 1A    STA $1AFD,x[$7E:1B15]
$8B:A9C4 BD 9D 1A    LDA $1A9D,x[$7E:1AB5]
$8B:A9C7 79 02 AA    ADC $AA02,y[$8B:AA02]
$8B:A9CA 9D 9D 1A    STA $1A9D,x[$7E:1AB5]
$8B:A9CD C9 A8 00    CMP #$00A8
$8B:A9D0 30 0D       BMI $0D    [$A9DF]
$8B:A9D2 A9 01 00    LDA #$0001
$8B:A9D5 9D 5D 1B    STA $1B5D,x[$7E:1B6B]
$8B:A9D8 A9 53 CE    LDA #$CE53
$8B:A9DB 9D 1D 1B    STA $1B1D,x[$7E:1B2B]
$8B:A9DE 60          RTS

$8B:A9DF BD 7D 1B    LDA $1B7D,x[$7E:1B95]
$8B:A9E2 18          CLC
$8B:A9E3 69 00 01    ADC #$0100
$8B:A9E6 9D 7D 1B    STA $1B7D,x[$7E:1B95]
$8B:A9E9 60          RTS

$8B:A9EA             dw FFFF,4000, 0000,4000, FFFF,8000, FFFF,2000, 0000,8000, 0000,2000

$8B:AA02             dw FFFE,0000, FFFE,C000, FFFE,A000, FFFE,8000, FFFE,6000, FFFE,4000, FFFE,2000, FFFF,0000,
                        FFFF,C000, FFFF,A000, FFFF,8000, FFFF,6000, FFFF,4000, FFFF,2000, 0000,0000, 0000,2000,
                        0000,4000, 0000,6000, 0000,8000, 0000,A000, 0000,C000, 0000,E000, 0001,0000, 0001,2000,
                        0001,4000, 0001,6000, 0001,8000, 0001,A000, 0001,C000, 0001,E000, 0002,0000, 0002,2000,
                        0002,4000, 0002,6000, 0002,8000, 0002,A000, 0002,C000, 0002,E000
}


;;; $AA9A:  ;;;
{
$8B:AA9A AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:AA9D 99 7D 1B    STA $1B7D,y[$7E:1B89]
$8B:AAA0 AD 97 1A    LDA $1A97  [$7E:1A97]
$8B:AAA3 99 7D 1A    STA $1A7D,y[$7E:1A89]
$8B:AAA6 AD B7 1A    LDA $1AB7  [$7E:1AB7]
$8B:AAA9 99 9D 1A    STA $1A9D,y[$7E:1AA9]
$8B:AAAC A9 00 0E    LDA #$0E00
$8B:AAAF 99 BD 1A    STA $1ABD,y[$7E:1AC9]
$8B:AAB2 60          RTS
}


;;; $AAB3:  ;;;
{
$8B:AAB3 BD 7D 1B    LDA $1B7D,x[$7E:1B89]
$8B:AAB6 29 FF 00    AND #$00FF
$8B:AAB9 0A          ASL A
$8B:AABA 0A          ASL A
$8B:AABB A8          TAY
$8B:AABC BD DD 1A    LDA $1ADD,x[$7E:1AE9]
$8B:AABF 18          CLC
$8B:AAC0 79 37 AB    ADC $AB37,y[$8B:AB37]
$8B:AAC3 9D DD 1A    STA $1ADD,x[$7E:1AE9]
$8B:AAC6 BD 7D 1A    LDA $1A7D,x[$7E:1A89]
$8B:AAC9 79 35 AB    ADC $AB35,y[$8B:AB35]
$8B:AACC 9D 7D 1A    STA $1A7D,x[$7E:1A89]
$8B:AACF BD 7D 1B    LDA $1B7D,x[$7E:1B89]
$8B:AAD2 89 01 00    BIT #$0001
$8B:AAD5 D0 21       BNE $21    [$AAF8]
$8B:AAD7 EB          XBA
$8B:AAD8 29 FF 00    AND #$00FF
$8B:AADB 0A          ASL A
$8B:AADC 0A          ASL A
$8B:AADD A8          TAY
$8B:AADE BD FD 1A    LDA $1AFD,x[$7E:1B09]
$8B:AAE1 18          CLC
$8B:AAE2 79 43 AC    ADC $AC43,y[$8B:AC43]
$8B:AAE5 9D FD 1A    STA $1AFD,x[$7E:1B09]
$8B:AAE8 BD 9D 1A    LDA $1A9D,x[$7E:1AA9]
$8B:AAEB 79 41 AC    ADC $AC41,y[$8B:AC41]
$8B:AAEE 9D 9D 1A    STA $1A9D,x[$7E:1AA9]
$8B:AAF1 C9 A8 00    CMP #$00A8
$8B:AAF4 30 34       BMI $34    [$AB2A]
$8B:AAF6 80 1F       BRA $1F    [$AB17]

$8B:AAF8 EB          XBA
$8B:AAF9 29 FF 00    AND #$00FF
$8B:AAFC 0A          ASL A
$8B:AAFD 0A          ASL A
$8B:AAFE A8          TAY
$8B:AAFF BD FD 1A    LDA $1AFD,x[$7E:1B07]
$8B:AB02 18          CLC
$8B:AB03 79 4B AB    ADC $AB4B,y[$8B:AB4B]
$8B:AB06 9D FD 1A    STA $1AFD,x[$7E:1B07]
$8B:AB09 BD 9D 1A    LDA $1A9D,x[$7E:1AA7]
$8B:AB0C 79 49 AB    ADC $AB49,y[$8B:AB49]
$8B:AB0F 9D 9D 1A    STA $1A9D,x[$7E:1AA7]
$8B:AB12 C9 A8 00    CMP #$00A8
$8B:AB15 30 13       BMI $13    [$AB2A]

$8B:AB17 A9 01 00    LDA #$0001
$8B:AB1A 9D 5D 1B    STA $1B5D,x[$7E:1B67]
$8B:AB1D A9 71 CD    LDA #$CD71
$8B:AB20 9D 1D 1B    STA $1B1D,x[$7E:1B27]
$8B:AB23 A9 D9 93    LDA #$93D9
$8B:AB26 9D 3D 1B    STA $1B3D,x[$7E:1B47]
$8B:AB29 60          RTS

$8B:AB2A BD 7D 1B    LDA $1B7D,x[$7E:1B89]
$8B:AB2D 18          CLC
$8B:AB2E 69 00 01    ADC #$0100
$8B:AB31 9D 7D 1B    STA $1B7D,x[$7E:1B89]
$8B:AB34 60          RTS

$8B:AB35             dw FFFF,0000, FFFF,8000, 0001,0000, 0000,8000, FFFF,8000

$8B:AB49             dw FFFE,0000, FFFE,C000, FFFE,A000, FFFE,8000, FFFE,6000, FFFE,4000, FFFE,2000, FFFF,0000,
                        FFFF,C000, FFFF,A000, FFFF,8000, FFFF,6000, FFFF,4000, FFFF,2000, 0000,0000, 0000,2000,
                        0000,4000, 0000,6000, 0000,8000, 0000,A000, 0000,C000, 0000,E000, 0001,0000, 0001,2000,
                        0001,4000, 0001,6000, 0001,8000, 0001,A000, 0001,C000, 0001,E000, 0002,0000, 0002,2000,
                        0002,4000, 0002,6000, 0002,8000, 0002,A000, 0002,C000, 0002,E000, 0003,0000, 0003,2000,
                        0003,4000, 0003,6000, 0003,8000, 0003,A000, 0003,C000, 0003,E000, 0004,0000, 0004,2000,
                        0004,4000, 0004,6000, 0004,8000, 0004,A000, 0004,C000, 0004,E000, 0005,0000, 0005,2000,
                        0005,4000, 0005,6000, 0005,8000, 0005,A000, 0005,C000, 0005,E000

$8B:AC41             dw FFFD,0000, FFFD,C000, FFFD,A000, FFFD,8000, FFFD,6000, FFFD,4000, FFFD,2000, FFFE,0000,
                        FFFE,C000, FFFE,A000, FFFE,8000, FFFE,6000, FFFE,4000, FFFE,2000, FFFF,0000, FFFF,C000,
                        FFFF,A000, FFFF,8000, FFFF,6000, FFFF,4000, FFFF,2000, 0000,0000, 0000,2000, 0000,4000,
                        0000,6000, 0000,8000, 0000,A000, 0000,C000, 0000,E000, 0001,0000, 0001,2000, 0001,4000,
                        0001,6000, 0001,8000, 0001,A000, 0001,C000, 0001,E000, 0002,0000, 0002,2000, 0002,4000,
                        0002,6000, 0002,8000, 0002,A000, 0002,C000, 0002,E000, 0003,0000, 0003,2000, 0003,4000,
                        0003,6000, 0003,8000, 0003,A000, 0003,C000, 0003,E000, 0004,0000, 0004,2000, 0004,4000,
                        0004,6000, 0004,8000, 0004,A000, 0004,C000, 0004,E000, 0005,0000, 0005,2000, 0005,4000,
                        0005,6000, 0005,8000, 0005,A000, 0005,C000, 0005,E000
}


;;; $AD55:  ;;;
{
$8B:AD55 A9 54 00    LDA #$0054
$8B:AD58 99 7D 1A    STA $1A7D,y[$7E:1A99]
$8B:AD5B A9 8B 00    LDA #$008B
$8B:AD5E 99 9D 1A    STA $1A9D,y[$7E:1AB9]
$8B:AD61 A9 00 0C    LDA #$0C00
$8B:AD64 99 BD 1A    STA $1ABD,y[$7E:1AD9]
$8B:AD67 60          RTS
}


;;; $AD68:  ;;;
{
$8B:AD68 AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:AD6B D0 0D       BNE $0D    [$AD7A]
$8B:AD6D A9 01 00    LDA #$0001
$8B:AD70 9D 5D 1B    STA $1B5D,x[$7E:1B79]
$8B:AD73 A9 53 CE    LDA #$CE53
$8B:AD76 9D 1D 1B    STA $1B1D,x[$7E:1B39]
$8B:AD79 60          RTS

$8B:AD7A AD 49 1A    LDA $1A49  [$7E:1A49]
$8B:AD7D 89 03 00    BIT #$0003
$8B:AD80 D0 10       BNE $10    [$AD92]
$8B:AD82 AD 93 19    LDA $1993  [$7E:1993]
$8B:AD85 F0 0B       BEQ $0B    [$AD92]
$8B:AD87 3A          DEC A
$8B:AD88 8D 93 19    STA $1993  [$7E:1993]
$8B:AD8B BD 7D 1A    LDA $1A7D,x[$7E:1A99]
$8B:AD8E 1A          INC A
$8B:AD8F 9D 7D 1A    STA $1A7D,x[$7E:1A99]

$8B:AD92 60          RTS
}


;;; $AD93:  ;;;
{
$8B:AD93 A9 70 00    LDA #$0070
$8B:AD96 99 7D 1A    STA $1A7D,y[$7E:1A99]
$8B:AD99 A9 6F 00    LDA #$006F
$8B:AD9C 99 9D 1A    STA $1A9D,y[$7E:1AB9]
$8B:AD9F A9 00 0C    LDA #$0C00
$8B:ADA2 99 BD 1A    STA $1ABD,y[$7E:1AD9]
$8B:ADA5 60          RTS
}


;;; $ADA6:  ;;;
{
$8B:ADA6 AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:ADA9 D0 0D       BNE $0D    [$ADB8]
$8B:ADAB A9 01 00    LDA #$0001
$8B:ADAE 9D 5D 1B    STA $1B5D,x[$7E:1B79]
$8B:ADB1 A9 53 CE    LDA #$CE53
$8B:ADB4 9D 1D 1B    STA $1B1D,x[$7E:1B39]
$8B:ADB7 60          RTS

$8B:ADB8 AD 49 1A    LDA $1A49  [$7E:1A49]
$8B:ADBB 89 03 00    BIT #$0003
$8B:ADBE D0 13       BNE $13    [$ADD3]
$8B:ADC0 AD 97 19    LDA $1997  [$7E:1997]
$8B:ADC3 C9 08 00    CMP #$0008
$8B:ADC6 10 0B       BPL $0B    [$ADD3]
$8B:ADC8 1A          INC A
$8B:ADC9 8D 97 19    STA $1997  [$7E:1997]
$8B:ADCC BD 9D 1A    LDA $1A9D,x[$7E:1AB9]
$8B:ADCF 3A          DEC A
$8B:ADD0 9D 9D 1A    STA $1A9D,x[$7E:1AB9]

$8B:ADD3 60          RTS
}


;;; $ADD4: Instruction - set caret to blink ;;;
{
$8B:ADD4 A9 03 CC    LDA #$CC03             ;\
$8B:ADD7 8D 3B 1B    STA $1B3B  [$7E:1B3B]  ;} Cinematic sprite object Fh instruction list pointer = $CC03
$8B:ADDA A9 01 00    LDA #$0001             ;\
$8B:ADDD 8D 7B 1B    STA $1B7B  [$7E:1B7B]  ;} Cinematic sprite object Fh instruction timer = 1
$8B:ADE0 60          RTS
}


;;; $ADE1:  ;;;
{
$8B:ADE1 A9 08 00    LDA #$0008             ;\
$8B:ADE4 8D 9B 1A    STA $1A9B  [$7E:1A9B]  ;} Cinematic sprite object Fh X position = 8
$8B:ADE7 A9 F8 00    LDA #$00F8             ;\
$8B:ADEA 8D BB 1A    STA $1ABB  [$7E:1ABB]  ;} Cinematic sprite object Fh Y position = F8h
$8B:ADED 60          RTS
}


;;; $ADEE:  ;;;
{
$8B:ADEE A9 08 00    LDA #$0008             ;\
$8B:ADF1 8D 9B 1A    STA $1A9B  [$7E:1A9B]  ;} Cinematic sprite object Fh X position = 8
$8B:ADF4 A9 18 00    LDA #$0018             ;\
$8B:ADF7 8D BB 1A    STA $1ABB  [$7E:1ABB]  ;} Cinematic sprite object Fh Y position = 18h
$8B:ADFA A9 FB CB    LDA #$CBFB             ;\
$8B:ADFD 8D 3B 1B    STA $1B3B  [$7E:1B3B]  ;} Cinematic sprite object Fh instruction list pointer = $CBFB
$8B:AE00 A9 01 00    LDA #$0001             ;\
$8B:AE03 8D 7B 1B    STA $1B7B  [$7E:1B7B]  ;} Cinematic sprite object Fh instruction timer = 1
$8B:AE06 60          RTS
}


;;; $AE07:  ;;;
{
$8B:AE07 A9 80 00    LDA #$0080
$8B:AE0A 99 7D 1A    STA $1A7D,y
$8B:AE0D A9 D8 00    LDA #$00D8
$8B:AE10 99 9D 1A    STA $1A9D,y
$8B:AE13 A9 00 0C    LDA #$0C00
$8B:AE16 99 BD 1A    STA $1ABD,y
$8B:AE19 60          RTS
}


;;; $AE1A:  ;;;
{
$8B:AE1A AD A3 1B    LDA $1BA3  [$7E:1BA3]
$8B:AE1D C9 3B 00    CMP #$003B
$8B:AE20 D0 0C       BNE $0C    [$AE2E]
$8B:AE22 A9 01 00    LDA #$0001
$8B:AE25 9D 5D 1B    STA $1B5D,x
$8B:AE28 A9 23 CC    LDA #$CC23
$8B:AE2B 9D 1D 1B    STA $1B1D,x

$8B:AE2E AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:AE31 C9 7F 00    CMP #$007F
$8B:AE34 D0 0C       BNE $0C    [$AE42]
$8B:AE36 A9 01 00    LDA #$0001
$8B:AE39 9D 5D 1B    STA $1B5D,x
$8B:AE3C A9 53 CE    LDA #$CE53
$8B:AE3F 9D 1D 1B    STA $1B1D,x

$8B:AE42 60          RTS
}


;;; $AE43: Instruction - handle creating Japanese text - page 1 ;;;
{
$8B:AE43 9C A1 1B    STZ $1BA1  [$7E:1BA1]  ; Clear flag to play click in the intro text
$8B:AE46 AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$8B:AE49 F0 0F       BEQ $0F    [$AE5A]     ;} If English text: return
$8B:AE4B 8B          PHB
$8B:AE4C F4 00 8B    PEA $8B00              ;\
$8B:AE4F AB          PLB                    ;} DB = $8B
$8B:AE50 AB          PLB                    ;/
$8B:AE51 5A          PHY
$8B:AE52 A0 01 D4    LDY #$D401             ;\
$8B:AE55 20 E4 94    JSR $94E4  [$8B:94E4]  ;} Spawn mode 7 object $D401
$8B:AE58 7A          PLY
$8B:AE59 AB          PLB

$8B:AE5A 60          RTS
}


;;; $AE5B: Instruction - spawn blinking markers and wait for input - page 1 ;;;
{
$8B:AE5B 20 D4 AD    JSR $ADD4  [$8B:ADD4]  ; Set caret to blink
$8B:AE5E AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$8B:AE61 F0 0F       BEQ $0F    [$AE72]     ;} If Japanese text enabled:
$8B:AE63 8B          PHB
$8B:AE64 F4 00 8B    PEA $8B00              ;\
$8B:AE67 AB          PLB                    ;} DB = $8B
$8B:AE68 AB          PLB                    ;/
$8B:AE69 5A          PHY
$8B:AE6A A0 73 CE    LDY #$CE73             ;\
$8B:AE6D 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE73 (next-page arrow for Japanese text)
$8B:AE70 7A          PLY
$8B:AE71 AB          PLB

$8B:AE72 A9 B8 AE    LDA #$AEB8             ;\
$8B:AE75 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $AEB8
$8B:AE78 60          RTS
}


;;; $AE79: Instruction - handle creating Japanese text - page 2 ;;;
{
$8B:AE79 9C A1 1B    STZ $1BA1  [$7E:1BA1]  ; Clear flag to play click in the intro text
$8B:AE7C AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$8B:AE7F F0 0F       BEQ $0F    [$AE90]     ;} If English text: return
$8B:AE81 8B          PHB
$8B:AE82 F4 00 8B    PEA $8B00              ;\
$8B:AE85 AB          PLB                    ;} DB = $8B
$8B:AE86 AB          PLB                    ;/
$8B:AE87 5A          PHY
$8B:AE88 A0 07 D4    LDY #$D407             ;\
$8B:AE8B 20 E4 94    JSR $94E4  [$8B:94E4]  ;} Spawn mode 7 object $D407
$8B:AE8E 7A          PLY
$8B:AE8F AB          PLB

$8B:AE90 60          RTS
}


;;; $AE91: Instruction - spawn blinking markers and wait for input - page 2 ;;;
{
$8B:AE91 20 D4 AD    JSR $ADD4  [$8B:ADD4]  ; Set caret to blink
$8B:AE94 AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$8B:AE97 F0 18       BEQ $18    [$AEB1]     ;} If Japanese text enabled:
$8B:AE99 8B          PHB
$8B:AE9A F4 00 8B    PEA $8B00              ;\
$8B:AE9D AB          PLB                    ;} DB = $8B
$8B:AE9E AB          PLB                    ;/
$8B:AE9F 5A          PHY
$8B:AEA0 A0 73 CE    LDY #$CE73             ;\
$8B:AEA3 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE73 (next-page arrow Japanese text)
$8B:AEA6 7A          PLY
$8B:AEA7 5A          PHY
$8B:AEA8 A0 0D D4    LDY #$D40D             ;\
$8B:AEAB 20 E4 94    JSR $94E4  [$8B:94E4]  ;} Spawn mode 7 object $D40D (Japanese text page 2 part 2)
$8B:AEAE 7A          PLY
$8B:AEAF AB          PLB
$8B:AEB0 60          RTS                    ; Return

$8B:AEB1 A9 6C AF    LDA #$AF6C             ;\
$8B:AEB4 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $AF6C
$8B:AEB7 60          RTS
}


;;; $AEB8: Cinematic function - intro - wait for input and set up old Mother Brain fight ;;;
{
$8B:AEB8 AD A3 1B    LDA $1BA3  [$7E:1BA3]  ;\
$8B:AEBB F0 05       BEQ $05    [$AEC2]     ;} If [intro Japanese text timer] != 0:
$8B:AEBD 3A          DEC A                  ;\
$8B:AEBE 8D A3 1B    STA $1BA3  [$7E:1BA3]  ;} Decrement intro Japanese text timer
$8B:AEC1 60          RTS                    ; Return

$8B:AEC2 A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:AEC4 D0 01       BNE $01    [$AEC7]     ;} If not newly pressed anything:
$8B:AEC6 60          RTS                    ; Return

$8B:AEC7 E2 20       SEP #$20
$8B:AEC9 A9 50       LDA #$50               ;\
$8B:AECB 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $5000, size = 32x32
$8B:AECD C2 20       REP #$20
$8B:AECF A9 02 00    LDA #$0002             ;\
$8B:AED2 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - normal
$8B:AED5 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$8B:AED9 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$8B:AEDD AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$8B:AEE0 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$8B:AEE3 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$8B:AEE6 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$8B:AEE9 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$8B:AEEC 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$8B:AEEF AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$8B:AEF2 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = Samus pose X direction / movement type
$8B:AEF5 A9 9B 00    LDA #$009B             ;\
$8B:AEF8 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;} Samus X position = 9Bh
$8B:AEFB 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$8B:AEFE A9 73 00    LDA #$0073             ;\
$8B:AF01 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;} Samus Y position = 73h
$8B:AF04 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$8B:AF07 9C 93 19    STZ $1993  [$7E:1993]  ; $1993 = 0
$8B:AF0A A9 7F 00    LDA #$007F             ;\
$8B:AF0D 8D 4B 1A    STA $1A4B  [$7E:1A4B]  ;} $1A4B = 7Fh
$8B:AF10 A0 55 CE    LDY #$CE55             ;\
$8B:AF13 64 12       STZ $12    [$7E:0012]  ;} Spawn cinematic sprite object $CE55 to index 0 (intro Mother Brain)
$8B:AF15 20 A2 93    JSR $93A2  [$8B:93A2]  ;/
$8B:AF18 A0 27 CF    LDY #$CF27             ;\
$8B:AF1B 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF27 (rinka spawner)
$8B:AF1E A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:AF21 BF C3 BE 8C LDA $8CBEC3,x[$8C:BEC3];|
$8B:AF25 9F 02 00 7F STA $7F0002,x[$7F:0002];|
$8B:AF29 E8          INX                    ;} Level data = [$8C:BEC3..C082] (old Mother Brain room)
$8B:AF2A E8          INX                    ;|
$8B:AF2B E0 C0 01    CPX #$01C0             ;|
$8B:AF2E 30 F1       BMI $F1    [$AF21]     ;/
$8B:AF30 A2 00 00    LDX #$0000             ;\
$8B:AF33 A9 00 00    LDA #$0000             ;|
                                            ;|
$8B:AF36 9F 02 64 7F STA $7F6402,x[$7F:6402];|
$8B:AF3A E8          INX                    ;} BTS = 0
$8B:AF3B E8          INX                    ;|
$8B:AF3C E0 00 02    CPX #$0200             ;|
$8B:AF3F 30 F5       BMI $F5    [$AF36]     ;/
$8B:AF41 A9 01 00    LDA #$0001             ;\
$8B:AF44 8D D2 09    STA $09D2  [$7E:09D2]  ;} HUD item index = missiles
$8B:AF47 A9 C9 E6    LDA #$E6C9             ;\
$8B:AF4A 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E6C9 (demo)
$8B:AF4D A9 33 E8    LDA #$E833             ;\
$8B:AF50 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E833 (intro demo)
$8B:AF53 22 70 83 91 JSL $918370[$91:8370]  ; Clear demo input RAM
$8B:AF57 22 4E 83 91 JSL $91834E[$91:834E]  ; Enable demo input
$8B:AF5B A0 84 87    LDY #$8784             ;\
$8B:AF5E 22 95 83 91 JSL $918395[$91:8395]  ;} Load demo input object $8784
$8B:AF62 A9 FF FF    LDA #$FFFF             ;\
$8B:AF65 8D 57 1A    STA $1A57  [$7E:1A57]  ;} Set Samus to be displayed over cinematic sprite objects
$8B:AF68 4C 18 B0    JMP $B018  [$8B:B018]  ; Go to set up intro cross-fade into Samus gameplay
}


;;; $AF6B: RTS ;;;
{
$8B:AF6B 60          RTS
}


;;; $AF6C: Cinematic function - intro - wait for input and set up baby metroid discovery ;;;
{
$8B:AF6C AD A3 1B    LDA $1BA3  [$7E:1BA3]  ;\
$8B:AF6F F0 05       BEQ $05    [$AF76]     ;} If [intro Japanese text timer] != 0:
$8B:AF71 3A          DEC A                  ;\
$8B:AF72 8D A3 1B    STA $1BA3  [$7E:1BA3]  ;} Decrement intro Japanese text timer
$8B:AF75 60          RTS                    ; Return

$8B:AF76 A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:AF78 D0 01       BNE $01    [$AF7B]     ;} If not newly pressed anything:
$8B:AF7A 60          RTS                    ; Return

$8B:AF7B E2 20       SEP #$20
$8B:AF7D A9 54       LDA #$54               ;\
$8B:AF7F 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $5400, size = 32x32
$8B:AF81 C2 20       REP #$20
$8B:AF83 A9 20 00    LDA #$0020             ;\
$8B:AF86 8D A5 07    STA $07A5  [$7E:07A5]  ;} Room width = 20h blocks
$8B:AF89 A9 10 00    LDA #$0010             ;\
$8B:AF8C 8D A7 07    STA $07A7  [$7E:07A7]  ;} Room height = 10h blocks
$8B:AF8F A9 02 00    LDA #$0002             ;\
$8B:AF92 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - normal
$8B:AF95 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$8B:AF99 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$8B:AF9D AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$8B:AFA0 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$8B:AFA3 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$8B:AFA6 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$8B:AFA9 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$8B:AFAC 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$8B:AFAF AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$8B:AFB2 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = Samus pose X direction / movement type
$8B:AFB5 A9 78 01    LDA #$0178             ;\
$8B:AFB8 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;} Samus X position = 17Bh
$8B:AFBB 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$8B:AFBE A9 93 00    LDA #$0093             ;\
$8B:AFC1 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;} Samus Y position = 93h
$8B:AFC4 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$8B:AFC7 9C 93 19    STZ $1993  [$7E:1993]  ; $1993 = 0
$8B:AFCA A9 7F 00    LDA #$007F             ;\
$8B:AFCD 8D 4B 1A    STA $1A4B  [$7E:1A4B]  ;} $1A4B = 7Fh
$8B:AFD0 A0 5B CE    LDY #$CE5B             ;\
$8B:AFD3 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE5B (metroid egg)
$8B:AFD6 A0 79 CE    LDY #$CE79             ;\
$8B:AFD9 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE79 (confused baby metroid)
$8B:AFDC 9C 9F 1B    STZ $1B9F  [$7E:1B9F]  ; $1B9F = 0
$8B:AFDF A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:AFE2 BF 83 C0 8C LDA $8CC083,x[$8C:C083];|
$8B:AFE6 9F 02 00 7F STA $7F0002,x[$7F:0002];|
$8B:AFEA E8          INX                    ;} Level data = [$8C:C083..C382] (room with Baby Metroid hatching)
$8B:AFEB E8          INX                    ;|
$8B:AFEC E0 00 03    CPX #$0300             ;|
$8B:AFEF 30 F1       BMI $F1    [$AFE2]     ;/
$8B:AFF1 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing
$8B:AFF4 A9 C9 E6    LDA #$E6C9             ;\
$8B:AFF7 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E6C9 (demo)
$8B:AFFA A9 33 E8    LDA #$E833             ;\
$8B:AFFD 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E833 (intro demo)
$8B:B000 22 70 83 91 JSL $918370[$91:8370]  ; Clear demo input RAM
$8B:B004 22 4E 83 91 JSL $91834E[$91:834E]  ; Enable demo input
$8B:B008 A0 7E 87    LDY #$877E             ;\
$8B:B00B 22 95 83 91 JSL $918395[$91:8395]  ;} Load demo input object $877E
$8B:B00F A9 01 00    LDA #$0001             ;\
$8B:B012 8D 57 1A    STA $1A57  [$7E:1A57]  ;} Set Samus to be displayed under cinematic sprite objects
$8B:B015 80 01       BRA $01    [$B018]     ; Go to set up intro cross-fade into Samus gameplay
$8B:B017 60          RTS
}


;;; $B018: Set up intro cross-fade into Samus gameplay ;;;
{
$8B:B018 E2 20       SEP #$20
$8B:B01A A9 06       LDA #$06               ;\
$8B:B01C 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG2/BG3
$8B:B01E A9 11       LDA #$11               ;\
$8B:B020 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG1/sprites
$8B:B022 A9 02       LDA #$02               ;\
$8B:B024 85 6F       STA $6F    [$7E:006F]  ;} Enable subscreen layers
$8B:B026 64 72       STZ $72    [$7E:0072]  ; Disable colour math on all layers
$8B:B028 22 F0 EB 88 JSL $88EBF0[$88:EBF0]  ; Spawn intro cutscene cross-fade HDMA object
$8B:B02C C2 20       REP #$20
$8B:B02E 20 E1 AD    JSR $ADE1  [$8B:ADE1]  ; Execute $ADE1 (set sprite object Fh position)
$8B:B031 A9 50 B2    LDA #$B250             ;\
$8B:B034 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $B250
$8B:B037 A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:B03A BF E9 E3 8C LDA $8CE3E9,x[$8C:E3E9];|
$8B:B03E 9F 00 22 7E STA $7E2200,x[$7E:2200];|
$8B:B042 E8          INX                    ;} Fading palettes = [$8C:E3E9..E5E8] (intro palettes)
$8B:B043 E8          INX                    ;|
$8B:B044 E0 00 02    CPX #$0200             ;|
$8B:B047 30 F1       BMI $F1    [$B03A]     ;/
$8B:B049 20 09 8C    JSR $8C09  [$8B:8C09]  ; Decompose fading palette data
$8B:B04C A2 28 00    LDX #$0028             ;\
$8B:B04F A0 03 00    LDY #$0003             ;} Clear fading BG palette 1 colours 4..6
$8B:B052 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:B055 A2 E0 00    LDX #$00E0             ;\
$8B:B058 A0 10 00    LDY #$0010             ;} Clear fading BG palette 7
$8B:B05B 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:B05E A2 80 01    LDX #$0180             ;\
$8B:B061 A0 20 00    LDY #$0020             ;} Clear fading sprite palette 4/5
$8B:B064 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:B067 A2 E0 01    LDX #$01E0             ;\
$8B:B06A A0 10 00    LDY #$0010             ;} Clear fading sprite palette 7
$8B:B06D 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:B070 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes
$8B:B073 60          RTS
}


;;; $B074: Instruction - handle creating Japanese text - page 3 ;;;
{
$8B:B074 9C A1 1B    STZ $1BA1  [$7E:1BA1]
$8B:B077 AD E2 09    LDA $09E2  [$7E:09E2]
$8B:B07A F0 0F       BEQ $0F    [$B08B]
$8B:B07C 8B          PHB
$8B:B07D F4 00 8B    PEA $8B00
$8B:B080 AB          PLB
$8B:B081 AB          PLB
$8B:B082 5A          PHY
$8B:B083 A0 13 D4    LDY #$D413
$8B:B086 20 E4 94    JSR $94E4  [$8B:94E4]
$8B:B089 7A          PLY
$8B:B08A AB          PLB

$8B:B08B 60          RTS
}


;;; $B08C: Instruction - spawn blinking markers and wait for input - page 3 ;;;
{
$8B:B08C 20 D4 AD    JSR $ADD4  [$8B:ADD4]
$8B:B08F AD E2 09    LDA $09E2  [$7E:09E2]
$8B:B092 F0 18       BEQ $18    [$B0AC]
$8B:B094 8B          PHB
$8B:B095 F4 00 8B    PEA $8B00
$8B:B098 AB          PLB
$8B:B099 AB          PLB
$8B:B09A 5A          PHY
$8B:B09B A0 73 CE    LDY #$CE73             ;\
$8B:B09E 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE73 (next-page arrow Japanese text)
$8B:B0A1 7A          PLY
$8B:B0A2 5A          PHY
$8B:B0A3 A0 19 D4    LDY #$D419
$8B:B0A6 20 E4 94    JSR $94E4  [$8B:94E4]
$8B:B0A9 7A          PLY
$8B:B0AA AB          PLB
$8B:B0AB 60          RTS

$8B:B0AC A9 F2 B0    LDA #$B0F2
$8B:B0AF 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B0B2 60          RTS
}


;;; $B0B3: Instruction - handle creating Japanese text - page 4 ;;;
{
$8B:B0B3 9C A1 1B    STZ $1BA1  [$7E:1BA1]
$8B:B0B6 AD E2 09    LDA $09E2  [$7E:09E2]
$8B:B0B9 F0 0F       BEQ $0F    [$B0CA]
$8B:B0BB 8B          PHB
$8B:B0BC F4 00 8B    PEA $8B00
$8B:B0BF AB          PLB
$8B:B0C0 AB          PLB
$8B:B0C1 5A          PHY
$8B:B0C2 A0 1F D4    LDY #$D41F
$8B:B0C5 20 E4 94    JSR $94E4  [$8B:94E4]
$8B:B0C8 7A          PLY
$8B:B0C9 AB          PLB

$8B:B0CA 60          RTS
}


;;; $B0CB: Instruction - spawn blinking markers and wait for input - page 4 ;;;
{
$8B:B0CB 20 D4 AD    JSR $ADD4  [$8B:ADD4]
$8B:B0CE AD E2 09    LDA $09E2  [$7E:09E2]
$8B:B0D1 F0 18       BEQ $18    [$B0EB]
$8B:B0D3 8B          PHB
$8B:B0D4 F4 00 8B    PEA $8B00
$8B:B0D7 AB          PLB
$8B:B0D8 AB          PLB
$8B:B0D9 5A          PHY
$8B:B0DA A0 73 CE    LDY #$CE73             ;\
$8B:B0DD 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE73 (next-page arrow Japanese text)
$8B:B0E0 7A          PLY
$8B:B0E1 5A          PHY
$8B:B0E2 A0 25 D4    LDY #$D425
$8B:B0E5 20 E4 94    JSR $94E4  [$8B:94E4]
$8B:B0E8 7A          PLY
$8B:B0E9 AB          PLB
$8B:B0EA 60          RTS

$8B:B0EB A9 23 B1    LDA #$B123
$8B:B0EE 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B0F1 60          RTS
}


;;; $B0F2: Cinematic function - intro -  ;;;
{
$8B:B0F2 AD A3 1B    LDA $1BA3  [$7E:1BA3]
$8B:B0F5 F0 05       BEQ $05    [$B0FC]
$8B:B0F7 3A          DEC A
$8B:B0F8 8D A3 1B    STA $1BA3  [$7E:1BA3]
$8B:B0FB 60          RTS

$8B:B0FC A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:B0FE F0 22       BEQ $22    [$B122]     ;} If not newly pressed anything: return
$8B:B100 E2 20       SEP #$20
$8B:B102 A9 58       LDA #$58
$8B:B104 85 58       STA $58    [$7E:0058]
$8B:B106 C2 20       REP #$20
$8B:B108 A9 20 00    LDA #$0020
$8B:B10B 8D 93 19    STA $1993  [$7E:1993]
$8B:B10E A9 08 00    LDA #$0008
$8B:B111 8D 97 19    STA $1997  [$7E:1997]
$8B:B114 A9 7F 00    LDA #$007F
$8B:B117 8D 4B 1A    STA $1A4B  [$7E:1A4B]
$8B:B11A A0 61 CE    LDY #$CE61             ;\
$8B:B11D 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE61 (baby metroid being delivered)
$8B:B120 80 2F       BRA $2F    [$B151]

$8B:B122 60          RTS
}


;;; $B123: Cinematic function - intro -  ;;;
{
$8B:B123 AD A3 1B    LDA $1BA3  [$7E:1BA3]
$8B:B126 F0 05       BEQ $05    [$B12D]
$8B:B128 3A          DEC A
$8B:B129 8D A3 1B    STA $1BA3  [$7E:1BA3]
$8B:B12C 60          RTS

$8B:B12D A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:B12F F0 1F       BEQ $1F    [$B150]     ;} If not newly pressed anything: return
$8B:B131 E2 20       SEP #$20
$8B:B133 A9 5C       LDA #$5C
$8B:B135 85 58       STA $58    [$7E:0058]
$8B:B137 C2 20       REP #$20
$8B:B139 9C 93 19    STZ $1993  [$7E:1993]
$8B:B13C A9 E8 FF    LDA #$FFE8
$8B:B13F 8D 97 19    STA $1997  [$7E:1997]
$8B:B142 A9 7F 00    LDA #$007F
$8B:B145 8D 4B 1A    STA $1A4B  [$7E:1A4B]
$8B:B148 A0 67 CE    LDY #$CE67             ;\
$8B:B14B 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE67 (baby metroid being examined)
$8B:B14E 80 01       BRA $01    [$B151]

$8B:B150 60          RTS
}


;;; $B151:  ;;;
{
$8B:B151 E2 20       SEP #$20
$8B:B153 A9 06       LDA #$06
$8B:B155 85 69       STA $69    [$7E:0069]
$8B:B157 A9 11       LDA #$11
$8B:B159 85 6B       STA $6B    [$7E:006B]
$8B:B15B A9 02       LDA #$02
$8B:B15D 85 6F       STA $6F    [$7E:006F]
$8B:B15F 64 72       STZ $72    [$7E:0072]
$8B:B161 22 F0 EB 88 JSL $88EBF0[$88:EBF0]
$8B:B165 C2 20       REP #$20
$8B:B167 20 E1 AD    JSR $ADE1  [$8B:ADE1]
$8B:B16A A9 D2 B2    LDA #$B2D2
$8B:B16D 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B170 A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:B173 BF E9 E3 8C LDA $8CE3E9,x[$8C:E3E9];|
$8B:B177 9F 00 22 7E STA $7E2200,x[$7E:2200];|
$8B:B17B E8          INX                    ;} $7E:2200..23FF = [$8C:E3E9..E5E8] (intro palettes)
$8B:B17C E8          INX                    ;|
$8B:B17D E0 00 02    CPX #$0200             ;|
$8B:B180 30 F1       BMI $F1    [$B173]     ;/
$8B:B182 20 09 8C    JSR $8C09  [$8B:8C09]  ; Decompose fading palette data
$8B:B185 A2 40 00    LDX #$0040             ;\
$8B:B188 A0 10 00    LDY #$0010             ;} Clear fading BG palette 2
$8B:B18B 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:B18E A2 C0 01    LDX #$01C0             ;\
$8B:B191 A0 09 00    LDY #$0009             ;} Clear fading sprite palette 6 colours 0..8
$8B:B194 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:B197 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes
$8B:B19A 60          RTS
}


;;; $B19B: Instruction - handle creating Japanese text - page 5 ;;;
{
$8B:B19B 9C A1 1B    STZ $1BA1  [$7E:1BA1]
$8B:B19E AD E2 09    LDA $09E2  [$7E:09E2]
$8B:B1A1 F0 0F       BEQ $0F    [$B1B2]
$8B:B1A3 8B          PHB
$8B:B1A4 F4 00 8B    PEA $8B00
$8B:B1A7 AB          PLB
$8B:B1A8 AB          PLB
$8B:B1A9 5A          PHY
$8B:B1AA A0 2B D4    LDY #$D42B
$8B:B1AD 20 E4 94    JSR $94E4  [$8B:94E4]
$8B:B1B0 7A          PLY
$8B:B1B1 AB          PLB

$8B:B1B2 60          RTS
}


;;; $B1B3: Instruction - spawn blinking markers and wait for input - page 5 ;;;
{
$8B:B1B3 20 D4 AD    JSR $ADD4  [$8B:ADD4]
$8B:B1B6 AD E2 09    LDA $09E2  [$7E:09E2]
$8B:B1B9 F0 18       BEQ $18    [$B1D3]
$8B:B1BB 8B          PHB
$8B:B1BC F4 00 8B    PEA $8B00
$8B:B1BF AB          PLB
$8B:B1C0 AB          PLB
$8B:B1C1 5A          PHY
$8B:B1C2 A0 73 CE    LDY #$CE73             ;\
$8B:B1C5 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE73 (next-page arrow Japanese text)
$8B:B1C8 7A          PLY
$8B:B1C9 5A          PHY
$8B:B1CA A0 31 D4    LDY #$D431
$8B:B1CD 20 E4 94    JSR $94E4  [$8B:94E4]
$8B:B1D0 7A          PLY
$8B:B1D1 AB          PLB
$8B:B1D2 60          RTS

$8B:B1D3 A9 DA B1    LDA #$B1DA
$8B:B1D6 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B1D9 60          RTS
}


;;; $B1DA: Cinematic function - intro -  ;;;
{
$8B:B1DA 20 10 B7    JSR $B710  [$8B:B710]
$8B:B1DD AD A3 1B    LDA $1BA3  [$7E:1BA3]
$8B:B1E0 F0 05       BEQ $05    [$B1E7]
$8B:B1E2 3A          DEC A
$8B:B1E3 8D A3 1B    STA $1BA3  [$7E:1BA3]
$8B:B1E6 60          RTS

$8B:B1E7 A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:B1E9 F0 1B       BEQ $1B    [$B206]     ;} If not newly pressed anything: return
$8B:B1EB A9 7F 00    LDA #$007F
$8B:B1EE 8D 4B 1A    STA $1A4B  [$7E:1A4B]
$8B:B1F1 AD E2 09    LDA $09E2  [$7E:09E2]
$8B:B1F4 F0 11       BEQ $11    [$B207]
$8B:B1F6 A9 07 B2    LDA #$B207
$8B:B1F9 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B1FC 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B200 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B203 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM

$8B:B206 60          RTS
}


;;; $B207: Cinematic function - intro -  ;;;
{
$8B:B207 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:B20B 20 56 A8    JSR $A856  [$8B:A856]
$8B:B20E A0 5D CF    LDY #$CF5D             ;\
$8B:B211 A9 00 4C    LDA #$4C00             ;} Spawn intro text page 6 cinematic BG object for VRAM $4C00
$8B:B214 20 F0 95    JSR $95F0  [$8B:95F0]  ;/
$8B:B217 A9 90 A3    LDA #$A390
$8B:B21A 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B21D 20 EE AD    JSR $ADEE  [$8B:ADEE]
$8B:B220 A9 00 00    LDA #$0000             ;\
$8B:B223 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$8B:B227 60          RTS
}


;;; $B228: Instruction - handle creating Japanese text - page 6 ;;;
{
$8B:B228 9C A1 1B    STZ $1BA1  [$7E:1BA1]
$8B:B22B AD E2 09    LDA $09E2  [$7E:09E2]
$8B:B22E F0 0F       BEQ $0F    [$B23F]
$8B:B230 8B          PHB
$8B:B231 F4 00 8B    PEA $8B00
$8B:B234 AB          PLB
$8B:B235 AB          PLB
$8B:B236 5A          PHY
$8B:B237 A0 37 D4    LDY #$D437
$8B:B23A 20 E4 94    JSR $94E4  [$8B:94E4]
$8B:B23D 7A          PLY
$8B:B23E AB          PLB

$8B:B23F 60          RTS
}


;;; $B240:  ;;;
{
$8B:B240 A9 2F B7    LDA #$B72F             ;\
$8B:B243 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $B72F
$8B:B246 A9 01 00    LDA #$0001             ;\
$8B:B249 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$8B:B24C 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$8B:B24F 60          RTS
}


;;; $B250: Cinematic function - intro - cross-fade to Samus gameplay and sleep ;;;
{
; Cinematic function timer for this routine is set all the way up at $A6F0
$8B:B250 AD 49 1A    LDA $1A49  [$7E:1A49]  ;\
$8B:B253 89 03 00    BIT #$0003             ;} If [cinematic function timer] % 4 = 0:
$8B:B256 D0 42       BNE $42    [$B29A]     ;/
$8B:B258 A2 00 00    LDX #$0000             ;\
$8B:B25B A0 14 00    LDY #$0014             ;} Fade out BG palette 0 and BG palette 1 colours 0..3
$8B:B25E 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B261 A2 60 00    LDX #$0060             ;\
$8B:B264 A0 10 00    LDY #$0010             ;} Fade out BG palette 3
$8B:B267 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B26A A2 D2 01    LDX #$01D2             ;\
$8B:B26D A0 06 00    LDY #$0006             ;} Fade out sprite palette 6 colours 9..Eh
$8B:B270 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B273 A2 28 00    LDX #$0028             ;\
$8B:B276 A0 03 00    LDY #$0003             ;} Fade in BG palette 1 colours 4..6
$8B:B279 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B27C A2 E0 00    LDX #$00E0             ;\
$8B:B27F A0 10 00    LDY #$0010             ;} Fade in BG palette 7
$8B:B282 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B285 A2 80 01    LDX #$0180             ;\
$8B:B288 A0 20 00    LDY #$0020             ;} Fade in sprite palette 4/5
$8B:B28B 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B28E A2 E0 01    LDX #$01E0             ;\
$8B:B291 A0 10 00    LDY #$0010             ;} Fade in sprite palette 7
$8B:B294 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B297 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes

$8B:B29A CE 49 1A    DEC $1A49  [$7E:1A49]  ; Decrement cinematic function timer
$8B:B29D 10 32       BPL $32    [$B2D1]     ; If [cinematic function timer] >= 0: return
$8B:B29F E2 20       SEP #$20
$8B:B2A1 A9 15       LDA #$15               ;\
$8B:B2A3 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG3/sprites
$8B:B2A5 64 6B       STZ $6B    [$7E:006B]  ;\
$8B:B2A7 64 6F       STZ $6F    [$7E:006F]  ;} Disable subscreen layers
$8B:B2A9 C2 20       REP #$20
$8B:B2AB A2 00 01    LDX #$0100             ;\
$8B:B2AE A9 2F 00    LDA #$002F             ;|
                                            ;|
$8B:B2B1 9F 00 30 7E STA $7E3000,x[$7E:3100];|
$8B:B2B5 E8          INX                    ;} Clear English text region
$8B:B2B6 E8          INX                    ;|
$8B:B2B7 E0 00 06    CPX #$0600             ;|
$8B:B2BA 30 F5       BMI $F5    [$B2B1]     ;/
$8B:B2BC 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B2BF A9 91 A3    LDA #$A391             ;\
$8B:B2C2 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = nothing
$8B:B2C5 AD 57 1A    LDA $1A57  [$7E:1A57]  ;\
$8B:B2C8 10 07       BPL $07    [$B2D1]     ;} If Samus/projectiles displayed over cinematic sprite objects:
$8B:B2CA A0 BC E1    LDY #$E1BC             ;\
$8B:B2CD 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1BC (old Mother Brain fight background lights)

$8B:B2D1 60          RTS
}


;;; $B2D2: Cinematic function - intro - cross-fade to scientist cutscene and sleep ;;;
{
$8B:B2D2 AD 49 1A    LDA $1A49  [$7E:1A49]  ;\
$8B:B2D5 89 03 00    BIT #$0003             ;} If [cinematic function timer] % 4 = 0:
$8B:B2D8 D0 30       BNE $30    [$B30A]     ;/
$8B:B2DA A2 00 00    LDX #$0000             ;\
$8B:B2DD A0 14 00    LDY #$0014             ;} Fade out BG palette 0 and BG palette 1 colours 0..3
$8B:B2E0 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B2E3 A2 60 00    LDX #$0060             ;\
$8B:B2E6 A0 10 00    LDY #$0010             ;} Fade out BG palette 3
$8B:B2E9 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B2EC A2 D2 01    LDX #$01D2             ;\
$8B:B2EF A0 06 00    LDY #$0006             ;} Fade out sprite palette 6 colours 9..Eh
$8B:B2F2 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B2F5 A2 40 00    LDX #$0040             ;\
$8B:B2F8 A0 10 00    LDY #$0010             ;} Fade in BG palette 2
$8B:B2FB 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B2FE A2 C0 01    LDX #$01C0             ;\
$8B:B301 A0 09 00    LDY #$0009             ;} Fade in sprite palette 6 colours 0..8
$8B:B304 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B307 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes

$8B:B30A CE 49 1A    DEC $1A49  [$7E:1A49]  ; Decrement cinematic function timer
$8B:B30D 10 26       BPL $26    [$B335]     ; If [cinematic function timer] >= 0: return
$8B:B30F E2 20       SEP #$20
$8B:B311 A9 15       LDA #$15               ;\
$8B:B313 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG3/sprites
$8B:B315 64 6B       STZ $6B    [$7E:006B]  ;\
$8B:B317 64 6F       STZ $6F    [$7E:006F]  ;} Disable subscreen layers
$8B:B319 C2 20       REP #$20
$8B:B31B A2 00 01    LDX #$0100             ;\
$8B:B31E A9 2F 00    LDA #$002F             ;|
                                            ;|
$8B:B321 9F 00 30 7E STA $7E3000,x[$7E:3100];|
$8B:B325 E8          INX                    ;} Clear English text region
$8B:B326 E8          INX                    ;|
$8B:B327 E0 00 06    CPX #$0600             ;|
$8B:B32A 30 F5       BMI $F5    [$B321]     ;/
$8B:B32C 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B32F A9 91 A3    LDA #$A391             ;\
$8B:B332 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = nothing

$8B:B335 60          RTS
}


;;; $B336: Instruction - start intro page 2 ;;;
{
$8B:B336 A9 5F B3    LDA #$B35F             ;\
$8B:B339 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $B35F
$8B:B33C 80 16       BRA $16    [$B354]     ; Go to clear Japanese text tiles and disable cinematic BG tilemap updates
}


;;; $B33E: Instruction - start intro page 3 ;;;
{
$8B:B33E A9 70 B3    LDA #$B370             ;\
$8B:B341 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $B370
$8B:B344 80 0E       BRA $0E    [$B354]     ; Go to clear Japanese text tiles and disable cinematic BG tilemap updates
}


;;; $B346: Instruction - start intro page 4 ;;;
{
$8B:B346 A9 81 B3    LDA #$B381             ;\
$8B:B349 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $B381
$8B:B34C 80 06       BRA $06    [$B354]     ; Go to clear Japanese text tiles and disable cinematic BG tilemap updates
}


;;; $B34E: Instruction - start intro page 5 ;;;
{
$8B:B34E A9 92 B3    LDA #$B392             ;\
$8B:B351 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $B392
}


;;; $B354: Clear Japanese text tiles and disable cinematic BG tilemap updates ;;;
{
$8B:B354 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B358 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B35B 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B35E 60          RTS
}


;;; $B35F: Cinematic function - intro - page 2 ;;;
{
$8B:B35F A0 45 CF    LDY #$CF45             ;\
$8B:B362 A9 00 4C    LDA #$4C00             ;} Spawn intro text page 2 cinematic BG object for VRAM $4C00
$8B:B365 20 F0 95    JSR $95F0  [$8B:95F0]  ;/
$8B:B368 A9 F4 B3    LDA #$B3F4
$8B:B36B 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B36E 80 31       BRA $31    [$B3A1]
}


;;; $B370: Cinematic function - intro - page 3 ;;;
{
$8B:B370 A0 4B CF    LDY #$CF4B             ;\
$8B:B373 A9 00 4C    LDA #$4C00             ;} Spawn intro text page 3 cinematic BG object for VRAM $4C00
$8B:B376 20 F0 95    JSR $95F0  [$8B:95F0]  ;/
$8B:B379 A9 F4 B3    LDA #$B3F4
$8B:B37C 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B37F 80 20       BRA $20    [$B3A1]
}


;;; $B381: Cinematic function - intro - page 4 ;;;
{
$8B:B381 A0 51 CF    LDY #$CF51             ;\
$8B:B384 A9 00 4C    LDA #$4C00             ;} Spawn intro text page 4 cinematic BG object for VRAM $4C00
$8B:B387 20 F0 95    JSR $95F0  [$8B:95F0]  ;/
$8B:B38A A9 58 B4    LDA #$B458
$8B:B38D 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B390 80 0F       BRA $0F    [$B3A1]
}


;;; $B392: Cinematic function - intro - page 5 ;;;
{
$8B:B392 A0 57 CF    LDY #$CF57             ;\
$8B:B395 A9 00 4C    LDA #$4C00             ;} Spawn intro text page 5 cinematic BG object for VRAM $4C00
$8B:B398 20 F0 95    JSR $95F0  [$8B:95F0]  ;/
$8B:B39B A9 58 B4    LDA #$B458
$8B:B39E 8D 51 1F    STA $1F51  [$7E:1F51]
}


;;; $B3A1:  ;;;
{
$8B:B3A1 E2 20       SEP #$20
$8B:B3A3 A9 06       LDA #$06
$8B:B3A5 85 69       STA $69    [$7E:0069]
$8B:B3A7 A9 11       LDA #$11
$8B:B3A9 85 6B       STA $6B    [$7E:006B]
$8B:B3AB A9 02       LDA #$02
$8B:B3AD 85 6F       STA $6F    [$7E:006F]
$8B:B3AF 64 72       STZ $72    [$7E:0072]
$8B:B3B1 C2 20       REP #$20
$8B:B3B3 A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:B3B6 BF E9 E3 8C LDA $8CE3E9,x[$8C:E3E9];|
$8B:B3BA 9F 00 22 7E STA $7E2200,x[$7E:2200];|
$8B:B3BE E8          INX                    ;} $7E:2200..23FF = [$8C:E3E9..E5E8] (intro palettes)
$8B:B3BF E8          INX                    ;|
$8B:B3C0 E0 00 02    CPX #$0200             ;|
$8B:B3C3 30 F1       BMI $F1    [$B3B6]     ;/
$8B:B3C5 20 09 8C    JSR $8C09  [$8B:8C09]  ; Decompose fading palette data
$8B:B3C8 A2 00 00    LDX #$0000             ;\
$8B:B3CB A0 10 00    LDY #$0010             ;} Clear fading BG palette 0
$8B:B3CE 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:B3D1 A2 60 00    LDX #$0060             ;\
$8B:B3D4 A0 10 00    LDY #$0010             ;} Clear fading BG palette 3
$8B:B3D7 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:B3DA A2 D2 01    LDX #$01D2             ;\
$8B:B3DD A0 06 00    LDY #$0006             ;} Clear fading sprite palette 6 colours 9..Eh
$8B:B3E0 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:B3E3 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes
$8B:B3E6 A9 7F 00    LDA #$007F
$8B:B3E9 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:B3EC 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:B3F0 20 EE AD    JSR $ADEE  [$8B:ADEE]
$8B:B3F3 60          RTS
}


;;; $B3F4: Cinematic function - intro -  ;;;
{
$8B:B3F4 AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:B3F7 89 03 00    BIT #$0003
$8B:B3FA D0 42       BNE $42    [$B43E]
$8B:B3FC A2 00 00    LDX #$0000             ;\
$8B:B3FF A0 10 00    LDY #$0010             ;} Fade in BG palette 0
$8B:B402 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B405 A2 60 00    LDX #$0060             ;\
$8B:B408 A0 10 00    LDY #$0010             ;} Fade in BG palette 3
$8B:B40B 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B40E A2 D2 01    LDX #$01D2             ;\
$8B:B411 A0 06 00    LDY #$0006             ;} Fade in sprite palette 6 colours 9..Eh
$8B:B414 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B417 A2 28 00    LDX #$0028             ;\
$8B:B41A A0 03 00    LDY #$0003             ;} Fade out BG palette 1 colours 4..6
$8B:B41D 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B420 A2 E0 00    LDX #$00E0             ;\
$8B:B423 A0 10 00    LDY #$0010             ;} Fade out BG palette 7
$8B:B426 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B429 A2 80 01    LDX #$0180             ;\
$8B:B42C A0 20 00    LDY #$0020             ;} Fade out sprite palette 4/5
$8B:B42F 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B432 A2 E0 01    LDX #$01E0             ;\
$8B:B435 A0 10 00    LDY #$0010             ;} Fade out sprite palette 7
$8B:B438 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B43B 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes

$8B:B43E CE 4B 1A    DEC $1A4B  [$7E:1A4B]
$8B:B441 10 14       BPL $14    [$B457]
$8B:B443 E2 20       SEP #$20
$8B:B445 A9 16       LDA #$16
$8B:B447 85 69       STA $69    [$7E:0069]
$8B:B449 64 6B       STZ $6B    [$7E:006B]
$8B:B44B 64 6F       STZ $6F    [$7E:006F]
$8B:B44D 64 72       STZ $72    [$7E:0072]
$8B:B44F C2 20       REP #$20
$8B:B451 A9 91 A3    LDA #$A391
$8B:B454 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:B457 60          RTS
}


;;; $B458: Cinematic function - intro -  ;;;
{
$8B:B458 AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:B45B 89 03 00    BIT #$0003
$8B:B45E D0 30       BNE $30    [$B490]
$8B:B460 A2 00 00    LDX #$0000             ;\
$8B:B463 A0 10 00    LDY #$0010             ;} Fade in BG palette 0
$8B:B466 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B469 A2 60 00    LDX #$0060             ;\
$8B:B46C A0 10 00    LDY #$0010             ;} Fade in BG palette 3
$8B:B46F 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B472 A2 D2 01    LDX #$01D2             ;\
$8B:B475 A0 06 00    LDY #$0006             ;} Fade in sprite palette 6 colours 9..Eh
$8B:B478 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:B47B A2 40 00    LDX #$0040             ;\
$8B:B47E A0 10 00    LDY #$0010             ;} Fade out BG palette 2
$8B:B481 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B484 A2 C0 01    LDX #$01C0             ;\
$8B:B487 A0 09 00    LDY #$0009             ;} Fade out sprite palette 6 colours 0..8
$8B:B48A 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:B48D 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes

$8B:B490 CE 4B 1A    DEC $1A4B  [$7E:1A4B]
$8B:B493 10 26       BPL $26    [$B4BB]
$8B:B495 E2 20       SEP #$20
$8B:B497 A9 16       LDA #$16
$8B:B499 85 69       STA $69    [$7E:0069]
$8B:B49B 64 6B       STZ $6B    [$7E:006B]
$8B:B49D 64 6F       STZ $6F    [$7E:006F]
$8B:B49F 64 72       STZ $72    [$7E:0072]
$8B:B4A1 C2 20       REP #$20
$8B:B4A3 A2 00 00    LDX #$0000

$8B:B4A6 BF A9 E5 8C LDA $8CE5A9,x[$8C:E5A9]
$8B:B4AA 9F C0 C1 7E STA $7EC1C0,x[$7E:C1C0]
$8B:B4AE E8          INX
$8B:B4AF E8          INX
$8B:B4B0 E0 0E 00    CPX #$000E
$8B:B4B3 30 F1       BMI $F1    [$B4A6]
$8B:B4B5 A9 91 A3    LDA #$A391
$8B:B4B8 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:B4BB 60          RTS
}


;;; $B4BC: Pre-instruction - Samus blinking cinematic BG object ;;;
{
; Switches Samus blinking pattern on page 6 to deadpan stare
$8B:B4BC AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:B4BF C9 07 B2    CMP #$B207             ;} If [cinematic function] != $B207:
$8B:B4C2 F0 05       BEQ $05    [$B4C9]     ;/
$8B:B4C4 C9 90 A3    CMP #$A390             ;\
$8B:B4C7 D0 12       BNE $12    [$B4DB]     ;} If [cinematic function] != $A390: return

$8B:B4C9 A9 13 D6    LDA #$D613             ;\
$8B:B4CC 9D CD 19    STA $19CD,x[$7E:19D3]  ;} Cinematic BG object instruction list pointer = $D613
$8B:B4CF A9 01 00    LDA #$0001             ;\
$8B:B4D2 9D DD 19    STA $19DD,x[$7E:19E3]  ;} Cinematic BG object instruction timer = 1
$8B:B4D5 A9 D9 93    LDA #$93D9             ;\
$8B:B4D8 9D D5 19    STA $19D5,x[$7E:19DB]  ;} Cinematic BG object pre-instruction = RTS

$8B:B4DB 60          RTS
}


;;; $B4DC:  ;;;
{
$8B:B4DC AD 3B 1B    LDA $1B3B  [$7E:1B3B]
$8B:B4DF C9 03 CC    CMP #$CC03
$8B:B4E2 30 06       BMI $06    [$B4EA]
$8B:B4E4 A9 01 00    LDA #$0001
$8B:B4E7 9D DD 19    STA $19DD,x

$8B:B4EA 60          RTS
}


;;; $B4EB:  ;;;
{
$8B:B4EB 5A          PHY
$8B:B4EC 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B4F0 AF 0B E4 8C LDA $8CE40B[$8C:E40B]
$8B:B4F4 8F 22 C0 7E STA $7EC022[$7E:C022]
$8B:B4F8 AF 0D E4 8C LDA $8CE40D[$8C:E40D]
$8B:B4FC 8F 24 C0 7E STA $7EC024[$7E:C024]
$8B:B500 AF 0F E4 8C LDA $8CE40F[$8C:E40F]
$8B:B504 8F 26 C0 7E STA $7EC026[$7E:C026]
$8B:B508 A0 89 D3    LDY #$D389
$8B:B50B 20 23 8D    JSR $8D23  [$8B:8D23]
$8B:B50E A0 89 D3    LDY #$D389
$8B:B511 20 23 8D    JSR $8D23  [$8B:8D23]
$8B:B514 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B517 7A          PLY
$8B:B518 60          RTS
}


;;; $B519:  ;;;
{
$8B:B519 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:B51D 60          RTS
}


;;; $B51E:  ;;;
{
$8B:B51E 5A          PHY
$8B:B51F 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B523 AF 0B E4 8C LDA $8CE40B[$8C:E40B]
$8B:B527 8F 22 C0 7E STA $7EC022[$7E:C022]
$8B:B52B AF 0D E4 8C LDA $8CE40D[$8C:E40D]
$8B:B52F 8F 24 C0 7E STA $7EC024[$7E:C024]
$8B:B533 AF 0F E4 8C LDA $8CE40F[$8C:E40F]
$8B:B537 8F 26 C0 7E STA $7EC026[$7E:C026]
$8B:B53B 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B53E A0 75 CF    LDY #$CF75             ;\
$8B:B541 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 1 - top line
$8B:B544 A0 BD CF    LDY #$CFBD             ;\
$8B:B547 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 1 - bottom line
$8B:B54A 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B54D 7A          PLY
$8B:B54E 60          RTS
}


;;; $B54F:  ;;;
{
$8B:B54F 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:B553 60          RTS
}


;;; $B554:  ;;;
{
$8B:B554 5A          PHY
$8B:B555 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B559 AF 0B E4 8C LDA $8CE40B[$8C:E40B]
$8B:B55D 8F 22 C0 7E STA $7EC022[$7E:C022]
$8B:B561 AF 0D E4 8C LDA $8CE40D[$8C:E40D]
$8B:B565 8F 24 C0 7E STA $7EC024[$7E:C024]
$8B:B569 AF 0F E4 8C LDA $8CE40F[$8C:E40F]
$8B:B56D 8F 26 C0 7E STA $7EC026[$7E:C026]
$8B:B571 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B574 A0 FD CF    LDY #$CFFD             ;\
$8B:B577 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 2 - subpage 1 - top line
$8B:B57A A0 55 D0    LDY #$D055             ;\
$8B:B57D 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 2 - subpage 1 - bottom line
$8B:B580 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B583 7A          PLY
$8B:B584 60          RTS
}


;;; $B585:  ;;;
{
$8B:B585 A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:B587 F0 2E       BEQ $2E    [$B5B7]     ;} If not newly pressed anything: return
$8B:B589 A9 A5 D3    LDA #$D3A5
$8B:B58C 9D A1 19    STA $19A1,x
$8B:B58F A9 01 00    LDA #$0001
$8B:B592 9D A9 19    STA $19A9,x
$8B:B595 A9 D9 93    LDA #$93D9
$8B:B598 9D A5 19    STA $19A5,x
$8B:B59B 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B59F 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B5A2 A0 85 D0    LDY #$D085             ;\
$8B:B5A5 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 2 - subpage 2 - top line
$8B:B5A8 A0 E1 D0    LDY #$D0E1             ;\
$8B:B5AB 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 2 - subpage 2 - bottom line
$8B:B5AE 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B5B1 A9 3C 00    LDA #$003C
$8B:B5B4 8D A3 1B    STA $1BA3  [$7E:1BA3]

$8B:B5B7 60          RTS
}


;;; $B5B8:  ;;;
{
$8B:B5B8 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:B5BC A9 6C AF    LDA #$AF6C
$8B:B5BF 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B5C2 60          RTS
}


;;; $B5C3:  ;;;
{
$8B:B5C3 5A          PHY
$8B:B5C4 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B5C8 AF 0B E4 8C LDA $8CE40B[$8C:E40B]
$8B:B5CC 8F 22 C0 7E STA $7EC022[$7E:C022]
$8B:B5D0 AF 0D E4 8C LDA $8CE40D[$8C:E40D]
$8B:B5D4 8F 24 C0 7E STA $7EC024[$7E:C024]
$8B:B5D8 AF 0F E4 8C LDA $8CE40F[$8C:E40F]
$8B:B5DC 8F 26 C0 7E STA $7EC026[$7E:C026]
$8B:B5E0 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B5E3 A0 F9 D0    LDY #$D0F9             ;\
$8B:B5E6 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 3 - subpage 1
$8B:B5E9 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B5EC 7A          PLY
$8B:B5ED 60          RTS
}


;;; $B5EE:  ;;;
{
$8B:B5EE A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:B5F0 F0 28       BEQ $28    [$B61A]     ;} If not newly pressed anything: return
$8B:B5F2 A9 BB D3    LDA #$D3BB
$8B:B5F5 9D A1 19    STA $19A1,x
$8B:B5F8 A9 01 00    LDA #$0001
$8B:B5FB 9D A9 19    STA $19A9,x
$8B:B5FE A9 D9 93    LDA #$93D9
$8B:B601 9D A5 19    STA $19A5,x
$8B:B604 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B608 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B60B A0 5D D1    LDY #$D15D             ;\
$8B:B60E 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 3 - subpage 2
$8B:B611 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B614 A9 3C 00    LDA #$003C
$8B:B617 8D A3 1B    STA $1BA3  [$7E:1BA3]

$8B:B61A 60          RTS
}


;;; $B61B:  ;;;
{
$8B:B61B 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:B61F A9 F2 B0    LDA #$B0F2
$8B:B622 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B625 60          RTS
}


;;; $B626:  ;;;
{
$8B:B626 5A          PHY
$8B:B627 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B62B AF 0B E4 8C LDA $8CE40B[$8C:E40B]
$8B:B62F 8F 22 C0 7E STA $7EC022[$7E:C022]
$8B:B633 AF 0D E4 8C LDA $8CE40D[$8C:E40D]
$8B:B637 8F 24 C0 7E STA $7EC024[$7E:C024]
$8B:B63B AF 0F E4 8C LDA $8CE40F[$8C:E40F]
$8B:B63F 8F 26 C0 7E STA $7EC026[$7E:C026]
$8B:B643 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B646 A0 B9 D1    LDY #$D1B9             ;\
$8B:B649 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 4 - subpage 1 - top line
$8B:B64C A0 15 D2    LDY #$D215             ;\
$8B:B64F 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 4 - subpage 1 - bottom line
$8B:B652 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B655 7A          PLY
$8B:B656 60          RTS
}


;;; $B657:  ;;;
{
$8B:B657 A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:B659 F0 2E       BEQ $2E    [$B689]     ;} If not newly pressed anything: return
$8B:B65B A9 D1 D3    LDA #$D3D1
$8B:B65E 9D A1 19    STA $19A1,x
$8B:B661 A9 01 00    LDA #$0001
$8B:B664 9D A9 19    STA $19A9,x
$8B:B667 A9 D9 93    LDA #$93D9
$8B:B66A 9D A5 19    STA $19A5,x
$8B:B66D 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B671 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B674 A0 59 D2    LDY #$D259             ;\
$8B:B677 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 2 - subpage 2 - top line
$8B:B67A A0 A5 D2    LDY #$D2A5             ;\
$8B:B67D 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 2 - subpage 2 - bottom line
$8B:B680 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B683 A9 3C 00    LDA #$003C
$8B:B686 8D A3 1B    STA $1BA3  [$7E:1BA3]

$8B:B689 60          RTS
}


;;; $B68A:  ;;;
{
$8B:B68A 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:B68E A9 23 B1    LDA #$B123
$8B:B691 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B694 60          RTS
}


;;; $B695:  ;;;
{
$8B:B695 5A          PHY
$8B:B696 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B69A AF 0B E4 8C LDA $8CE40B[$8C:E40B]
$8B:B69E 8F 22 C0 7E STA $7EC022[$7E:C022]
$8B:B6A2 AF 0D E4 8C LDA $8CE40D[$8C:E40D]
$8B:B6A6 8F 24 C0 7E STA $7EC024[$7E:C024]
$8B:B6AA AF 0F E4 8C LDA $8CE40F[$8C:E40F]
$8B:B6AE 8F 26 C0 7E STA $7EC026[$7E:C026]
$8B:B6B2 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B6B5 A0 D5 D2    LDY #$D2D5             ;\
$8B:B6B8 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 5 - subpage 1
$8B:B6BB 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B6BE 7A          PLY
$8B:B6BF 60          RTS
}


;;; $B6C0:  ;;;
{
$8B:B6C0 A5 8F       LDA $8F    [$7E:008F]  ;\
$8B:B6C2 F0 28       BEQ $28    [$B6EC]     ;} If not newly pressed anything: return
$8B:B6C4 A9 E7 D3    LDA #$D3E7
$8B:B6C7 9D A1 19    STA $19A1,x
$8B:B6CA A9 01 00    LDA #$0001
$8B:B6CD 9D A9 19    STA $19A9,x
$8B:B6D0 A9 D9 93    LDA #$93D9
$8B:B6D3 9D A5 19    STA $19A5,x
$8B:B6D6 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B6DA 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B6DD A0 0D D3    LDY #$D30D             ;\
$8B:B6E0 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 5 - subpage 2
$8B:B6E3 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B6E6 A9 3C 00    LDA #$003C
$8B:B6E9 8D A3 1B    STA $1BA3  [$7E:1BA3]

$8B:B6EC 60          RTS
}


;;; $B6ED:  ;;;
{
$8B:B6ED 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:B6F1 A9 DA B1    LDA #$B1DA
$8B:B6F4 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:B6F7 60          RTS
}


;;; $B6F8:  ;;;
{
$8B:B6F8 5A          PHY
$8B:B6F9 22 C3 95 8B JSL $8B95C3[$8B:95C3]  ; Disable cinematic BG tilemap updates
$8B:B6FD 20 6A A8    JSR $A86A  [$8B:A86A]  ; Blank out Japanese text tiles
$8B:B700 A0 71 D3    LDY #$D371             ;\
$8B:B703 20 23 8D    JSR $8D23  [$8B:8D23]  ;} Load Japanese intro text tiles - page 6
$8B:B706 20 E6 8D    JSR $8DE6  [$8B:8DE6]  ; Transfer Japanese text tiles to VRAM
$8B:B709 7A          PLY
$8B:B70A 60          RTS
}


;;; $B70B:  ;;;
{
$8B:B70B 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:B70F 60          RTS
}


;;; $B710: RTS ;;;
{
$8B:B710 60          RTS
}


;;; $B711:  ;;;
{
$8B:B711 AD B6 05    LDA $05B6  [$7E:05B6]
$8B:B714 89 01 00    BIT #$0001
$8B:B717 F0 0B       BEQ $0B    [$B724]
$8B:B719 E2 20       SEP #$20
$8B:B71B A5 69       LDA $69    [$7E:0069]
$8B:B71D 29 FD       AND #$FD
$8B:B71F 85 69       STA $69    [$7E:0069]
$8B:B721 C2 20       REP #$20
$8B:B723 60          RTS

$8B:B724 E2 20       SEP #$20
$8B:B726 A5 69       LDA $69    [$7E:0069]
$8B:B728 09 02       ORA #$02
$8B:B72A 85 69       STA $69    [$7E:0069]
$8B:B72C C2 20       REP #$20
$8B:B72E 60          RTS
}


;;; $B72F: Cinematic function - intro -  ;;;
{
$8B:B72F 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$8B:B733 E2 20       SEP #$20
$8B:B735 A5 51       LDA $51    [$7E:0051]  ;\
$8B:B737 C9 80       CMP #$80               ;} If not finished fading out: return
$8B:B739 D0 37       BNE $37    [$B772]     ;/
$8B:B73B 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$8B:B73F C2 20       REP #$20
$8B:B741 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$8B:B744 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$8B:B747 64 B5       STZ $B5    [$7E:00B5]  ;\
$8B:B749 64 B9       STZ $B9    [$7E:00B9]  ;|
$8B:B74B 64 B7       STZ $B7    [$7E:00B7]  ;} BG2/3 X/Y scroll = 0
$8B:B74D 64 BB       STZ $BB    [$7E:00BB]  ;/
$8B:B74F 9C 8D 19    STZ $198D  [$7E:198D]  ;\
$8B:B752 A9 1F 1C    LDA #$1C1F             ;|
$8B:B755 3A          DEC A                  ;|
$8B:B756 3A          DEC A                  ;|
$8B:B757 38          SEC                    ;|
$8B:B758 E9 8D 19    SBC #$198D             ;|
$8B:B75B AA          TAX                    ;} Clear non-gameplay use RAM
                                            ;|
$8B:B75C 9E 8D 19    STZ $198D,x[$7E:1C1D]  ;|
$8B:B75F CA          DEX                    ;|
$8B:B760 CA          DEX                    ;|
$8B:B761 10 F9       BPL $F9    [$B75C]     ;/
$8B:B763 A9 A0 BC    LDA #$BCA0             ;\
$8B:B766 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $BCA0
$8B:B769 20 75 BC    JSR $BC75  [$8B:BC75]  ; Recover previous button assignments
$8B:B76C 9C C8 09    STZ $09C8  [$7E:09C8]  ; Max missiles = 0
$8B:B76F 9C C6 09    STZ $09C6  [$7E:09C6]  ; Current missiles = 0

$8B:B772 60          RTS
}


;;; $B773:  ;;;
{
$8B:B773 A9 38 00    LDA #$0038
$8B:B776 99 7D 1A    STA $1A7D,y[$7E:1A7D]
$8B:B779 A9 6F 00    LDA #$006F
$8B:B77C 99 9D 1A    STA $1A9D,y[$7E:1A9D]
$8B:B77F A9 00 0E    LDA #$0E00
$8B:B782 99 BD 1A    STA $1ABD,y[$7E:1ABD]
$8B:B785 60          RTS
}


;;; $B786:  ;;;
{
$8B:B786 20 46 B8    JSR $B846  [$8B:B846]
$8B:B789 A0 08 00    LDY #$0008

$8B:B78C B9 18 0C    LDA $0C18,y[$7E:0C20]
$8B:B78F 29 FF 0F    AND #$0FFF
$8B:B792 C9 00 01    CMP #$0100
$8B:B795 F0 05       BEQ $05    [$B79C]
$8B:B797 88          DEY
$8B:B798 88          DEY
$8B:B799 10 F1       BPL $F1    [$B78C]
$8B:B79B 60          RTS

$8B:B79C B9 64 0B    LDA $0B64,y[$7E:0B64]
$8B:B79F C9 54 00    CMP #$0054
$8B:B7A2 10 6A       BPL $6A    [$B80E]
$8B:B7A4 DA          PHX
$8B:B7A5 BB          TYX
$8B:B7A6 22 06 AE 90 JSL $90AE06[$90:AE06]
$8B:B7AA FA          PLX
$8B:B7AB A9 08 00    LDA #$0008
$8B:B7AE 9D DD 1A    STA $1ADD,x[$7E:1ADD]
$8B:B7B1 BD 7D 1B    LDA $1B7D,x[$7E:1B7D]
$8B:B7B4 1A          INC A
$8B:B7B5 9D 7D 1B    STA $1B7D,x[$7E:1B7D]
$8B:B7B8 C9 04 00    CMP #$0004
$8B:B7BB D0 51       BNE $51    [$B80E]
$8B:B7BD 9E 7D 1B    STZ $1B7D,x[$7E:1B7D]
$8B:B7C0 A9 0F B8    LDA #$B80F
$8B:B7C3 9D 3D 1B    STA $1B3D,x[$7E:1B3D]
$8B:B7C6 A9 00 00    LDA #$0000
$8B:B7C9 A0 1B CF    LDY #$CF1B             ;\
$8B:B7CC 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF1B (intro Mother Brain explosion - small)
$8B:B7CF A9 01 00    LDA #$0001
$8B:B7D2 A0 1B CF    LDY #$CF1B             ;\
$8B:B7D5 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF1B (intro Mother Brain explosion - small)
$8B:B7D8 A9 02 00    LDA #$0002
$8B:B7DB A0 1B CF    LDY #$CF1B             ;\
$8B:B7DE 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF1B (intro Mother Brain explosion - small)
$8B:B7E1 A9 00 00    LDA #$0000
$8B:B7E4 A0 15 CF    LDY #$CF15             ;\
$8B:B7E7 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF15 (intro Mother Brain explosion - big)
$8B:B7EA A9 01 00    LDA #$0001
$8B:B7ED A0 15 CF    LDY #$CF15             ;\
$8B:B7F0 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF15 (intro Mother Brain explosion - big)
$8B:B7F3 A9 02 00    LDA #$0002
$8B:B7F6 A0 15 CF    LDY #$CF15             ;\
$8B:B7F9 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF15 (intro Mother Brain explosion - big)
$8B:B7FC A9 03 00    LDA #$0003
$8B:B7FF A0 15 CF    LDY #$CF15             ;\
$8B:B802 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF15 (intro Mother Brain explosion - big)
$8B:B805 A9 04 00    LDA #$0004
$8B:B808 A0 15 CF    LDY #$CF15             ;\
$8B:B80B 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF15 (intro Mother Brain explosion - big)

$8B:B80E 60          RTS
}


;;; $B80F:  ;;;
{
$8B:B80F 20 46 B8    JSR $B846  [$8B:B846]
$8B:B812 20 77 B8    JSR $B877  [$8B:B877]
$8B:B815 BD 7D 1B    LDA $1B7D,x[$7E:1B7D]
$8B:B818 1A          INC A
$8B:B819 9D 7D 1B    STA $1B7D,x[$7E:1B7D]
$8B:B81C C9 80 00    CMP #$0080
$8B:B81F 30 0C       BMI $0C    [$B82D]
$8B:B821 A9 01 00    LDA #$0001
$8B:B824 9D 5D 1B    STA $1B5D,x[$7E:1B5D]
$8B:B827 A9 19 CB    LDA #$CB19
$8B:B82A 9D 1D 1B    STA $1B1D,x[$7E:1B1D]

$8B:B82D 60          RTS
}


;;; $B82E: Pre-instruction ;;;
{
; Used by cinematic sprite object $CE55 (intro Mother Brain)
$8B:B82E 20 77 B8    JSR $B877  [$8B:B877]
$8B:B831 AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:B834 D0 0F       BNE $0F    [$B845]
$8B:B836 A9 01 00    LDA #$0001
$8B:B839 9D 5D 1B    STA $1B5D,x[$7E:1B5D]
$8B:B83C A9 53 CE    LDA #$CE53
$8B:B83F 9D 1D 1B    STA $1B1D,x[$7E:1B1D]
$8B:B842 9C 57 1A    STZ $1A57  [$7E:1A57]

$8B:B845 60          RTS
}


;;; $B846:  ;;;
{
$8B:B846 BD DD 1A    LDA $1ADD,x[$7E:1ADD]
$8B:B849 F0 2B       BEQ $2B    [$B876]
$8B:B84B 89 01 00    BIT #$0001
$8B:B84E D0 12       BNE $12    [$B862]
$8B:B850 DA          PHX
$8B:B851 A2 1E 00    LDX #$001E
$8B:B854 A9 FF 7F    LDA #$7FFF

$8B:B857 9F E0 C1 7E STA $7EC1E0,x[$7E:C1FE]
$8B:B85B CA          DEX
$8B:B85C CA          DEX
$8B:B85D 10 F8       BPL $F8    [$B857]
$8B:B85F FA          PLX
$8B:B860 80 11       BRA $11    [$B873]

$8B:B862 DA          PHX
$8B:B863 A2 1E 00    LDX #$001E

$8B:B866 BF C9 E5 8C LDA $8CE5C9,x[$8C:E5E7]
$8B:B86A 9F E0 C1 7E STA $7EC1E0,x[$7E:C1FE]
$8B:B86E CA          DEX
$8B:B86F CA          DEX
$8B:B870 10 F4       BPL $F4    [$B866]
$8B:B872 FA          PLX

$8B:B873 DE DD 1A    DEC $1ADD,x[$7E:1ADD]

$8B:B876 60          RTS
}


;;; $B877:  ;;;
{
$8B:B877 AD 51 1A    LDA $1A51  [$7E:1A51]
$8B:B87A 89 01 00    BIT #$0001
$8B:B87D D0 0C       BNE $0C    [$B88B]
$8B:B87F AD 97 19    LDA $1997  [$7E:1997]
$8B:B882 18          CLC
$8B:B883 69 04 00    ADC #$0004
$8B:B886 8D 97 19    STA $1997  [$7E:1997]
$8B:B889 80 0A       BRA $0A    [$B895]

$8B:B88B AD 97 19    LDA $1997  [$7E:1997]
$8B:B88E 38          SEC
$8B:B88F E9 04 00    SBC #$0004
$8B:B892 8D 97 19    STA $1997  [$7E:1997]

$8B:B895 60          RTS
}


;;; $B896:  ;;;
{
$8B:B896 AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:B899 99 7D 1B    STA $1B7D,y[$7E:1B97]
$8B:B89C 0A          ASL A
$8B:B89D AA          TAX
$8B:B89E BD B5 B8    LDA $B8B5,x[$8B:B8B5]
$8B:B8A1 99 7D 1A    STA $1A7D,y[$7E:1A97]
$8B:B8A4 BD BD B8    LDA $B8BD,x[$8B:B8BD]
$8B:B8A7 38          SEC
$8B:B8A8 E9 08 00    SBC #$0008
$8B:B8AB 99 9D 1A    STA $1A9D,y[$7E:1AB7]
$8B:B8AE A9 00 0E    LDA #$0E00
$8B:B8B1 99 BD 1A    STA $1ABD,y[$7E:1AD7]
$8B:B8B4 60          RTS

$8B:B8B5             dw 0070, 00C0, 0080, 00E8
$8B:B8BD             dw 0050, 0040, 0038, 0058
}


;;; $B8C5: Instruction -  ;;;
{
$8B:B8C5 BD 7D 1B    LDA $1B7D,x[$7E:1B97]
$8B:B8C8 D0 07       BNE $07    [$B8D1]
$8B:B8CA A9 D8 B8    LDA #$B8D8
$8B:B8CD 9D 3D 1B    STA $1B3D,x[$7E:1B57]
$8B:B8D0 60          RTS

$8B:B8D1 A9 3B B9    LDA #$B93B
$8B:B8D4 9D 3D 1B    STA $1B3D,x[$7E:1B55]
$8B:B8D7 60          RTS
}


;;; $B8D8:  ;;;
{
$8B:B8D8 BD DD 1A    LDA $1ADD,x[$7E:1AF7]
$8B:B8DB 18          CLC
$8B:B8DC 69 00 80    ADC #$8000
$8B:B8DF 9D DD 1A    STA $1ADD,x[$7E:1AF7]
$8B:B8E2 BD 7D 1A    LDA $1A7D,x[$7E:1A97]
$8B:B8E5 69 00 00    ADC #$0000
$8B:B8E8 9D 7D 1A    STA $1A7D,x[$7E:1A97]
$8B:B8EB BD FD 1A    LDA $1AFD,x[$7E:1B17]
$8B:B8EE 18          CLC
$8B:B8EF 69 00 80    ADC #$8000
$8B:B8F2 9D FD 1A    STA $1AFD,x[$7E:1B17]
$8B:B8F5 BD 9D 1A    LDA $1A9D,x[$7E:1AB7]
$8B:B8F8 69 00 00    ADC #$0000
$8B:B8FB 9D 9D 1A    STA $1A9D,x[$7E:1AB7]
$8B:B8FE AD F6 0A    LDA $0AF6  [$7E:0AF6]
$8B:B901 38          SEC
$8B:B902 E9 05 00    SBC #$0005
$8B:B905 85 12       STA $12    [$7E:0012]
$8B:B907 BD 7D 1A    LDA $1A7D,x[$7E:1A97]
$8B:B90A 18          CLC
$8B:B90B 69 08 00    ADC #$0008
$8B:B90E C5 12       CMP $12    [$7E:0012]
$8B:B910 30 14       BMI $14    [$B926]
$8B:B912 A9 0B 00    LDA #$000B
$8B:B915 8D A8 18    STA $18A8  [$7E:18A8]
$8B:B918 A9 0B 00    LDA #$000B
$8B:B91B 8D AA 18    STA $18AA  [$7E:18AA]
$8B:B91E A9 01 00    LDA #$0001
$8B:B921 8D 54 0A    STA $0A54  [$7E:0A54]
$8B:B924 80 08       BRA $08    [$B92E]

$8B:B926 AD 3D 1B    LDA $1B3D  [$7E:1B3D]
$8B:B929 C9 0F B8    CMP #$B80F
$8B:B92C D0 0C       BNE $0C    [$B93A]

$8B:B92E A9 01 00    LDA #$0001
$8B:B931 9D 5D 1B    STA $1B5D,x[$7E:1B77]
$8B:B934 A9 53 CE    LDA #$CE53
$8B:B937 9D 1D 1B    STA $1B1D,x[$7E:1B37]

$8B:B93A 60          RTS
}


;;; $B93B:  ;;;
{
$8B:B93B BD 7D 1B    LDA $1B7D,x[$7E:1B95]
$8B:B93E 0A          ASL A
$8B:B93F A8          TAY
$8B:B940 BD DD 1A    LDA $1ADD,x[$7E:1AF5]
$8B:B943 18          CLC
$8B:B944 69 00 80    ADC #$8000
$8B:B947 9D DD 1A    STA $1ADD,x[$7E:1AF5]
$8B:B94A BD 7D 1A    LDA $1A7D,x[$7E:1A95]
$8B:B94D 79 85 B9    ADC $B985,y[$8B:B987]
$8B:B950 9D 7D 1A    STA $1A7D,x[$7E:1A95]
$8B:B953 BD FD 1A    LDA $1AFD,x[$7E:1B15]
$8B:B956 18          CLC
$8B:B957 69 00 80    ADC #$8000
$8B:B95A 9D FD 1A    STA $1AFD,x[$7E:1B15]
$8B:B95D BD 9D 1A    LDA $1A9D,x[$7E:1AB5]
$8B:B960 69 00 00    ADC #$0000
$8B:B963 9D 9D 1A    STA $1A9D,x[$7E:1AB5]
$8B:B966 C9 10 00    CMP #$0010
$8B:B969 30 0D       BMI $0D    [$B978]
$8B:B96B C9 D0 00    CMP #$00D0
$8B:B96E 10 08       BPL $08    [$B978]
$8B:B970 AD 3D 1B    LDA $1B3D  [$7E:1B3D]
$8B:B973 C9 0F B8    CMP #$B80F
$8B:B976 D0 0C       BNE $0C    [$B984]

$8B:B978 A9 01 00    LDA #$0001
$8B:B97B 9D 5D 1B    STA $1B5D,x[$7E:1B77]
$8B:B97E A9 53 CE    LDA #$CE53
$8B:B981 9D 1D 1B    STA $1B1D,x[$7E:1B37]

$8B:B984 60          RTS

$8B:B985             dw 0000, FFFF, 0000, FFFF
}


;;; $B98D:  ;;;
{
$8B:B98D AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:B990 99 7D 1B    STA $1B7D,y[$7E:1B8D]
$8B:B993 0A          ASL A
$8B:B994 AA          TAX
$8B:B995 A9 38 00    LDA #$0038
$8B:B998 18          CLC
$8B:B999 7D B6 B9    ADC $B9B6,x[$8B:B9B6]
$8B:B99C 99 7D 1A    STA $1A7D,y[$7E:1A8D]
$8B:B99F A9 6F 00    LDA #$006F
$8B:B9A2 18          CLC
$8B:B9A3 7D C0 B9    ADC $B9C0,x[$8B:B9C0]
$8B:B9A6 99 9D 1A    STA $1A9D,y[$7E:1AAD]
$8B:B9A9 BD CA B9    LDA $B9CA,x[$8B:B9CA]
$8B:B9AC 99 5D 1B    STA $1B5D,y[$7E:1B6D]
$8B:B9AF A9 00 0A    LDA #$0A00
$8B:B9B2 99 BD 1A    STA $1ABD,y[$7E:1ACD]
$8B:B9B5 60          RTS

$8B:B9B6             dw 0000, 0010, FFF0, FFF8, 0008
$8B:B9C0             dw 0000, FFF0, 0008, FFF0, 0008
$8B:B9CA             dw 0001, 0010, 0020, 0030, 0040
}


;;; $B9D4:  ;;;
{
$8B:B9D4 AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:B9D7 99 7D 1B    STA $1B7D,y[$7E:1B99]
$8B:B9DA 0A          ASL A
$8B:B9DB AA          TAX
$8B:B9DC A9 38 00    LDA #$0038
$8B:B9DF 18          CLC
$8B:B9E0 7D FD B9    ADC $B9FD,x[$8B:B9FD]
$8B:B9E3 99 7D 1A    STA $1A7D,y[$7E:1A99]
$8B:B9E6 A9 6F 00    LDA #$006F
$8B:B9E9 18          CLC
$8B:B9EA 7D 03 BA    ADC $BA03,x[$8B:BA03]
$8B:B9ED 99 9D 1A    STA $1A9D,y[$7E:1AB9]
$8B:B9F0 BD 09 BA    LDA $BA09,x[$8B:BA09]
$8B:B9F3 99 5D 1B    STA $1B5D,y[$7E:1B79]
$8B:B9F6 A9 00 0A    LDA #$0A00
$8B:B9F9 99 BD 1A    STA $1ABD,y[$7E:1AD9]
$8B:B9FC 60          RTS

$8B:B9FD             dw 0010, FFF0, FFF0
$8B:BA03             dw 0000, 0004, FFF8
$8B:BA09             dw 0001, 0008, 0010
}


;;; $BA0F:  ;;;
{
$8B:BA0F AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:BA12 D0 0C       BNE $0C    [$BA20]
$8B:BA14 A9 01 00    LDA #$0001
$8B:BA17 9D 5D 1B    STA $1B5D,x[$7E:1B79]
$8B:BA1A A9 53 CE    LDA #$CE53
$8B:BA1D 9D 1D 1B    STA $1B1D,x[$7E:1B39]

$8B:BA20 60          RTS
}


;;; $BA21: Instruction - spawn intro rinkas 0/1 ;;;
{
$8B:BA21 5A          PHY
$8B:BA22 A9 00 00    LDA #$0000
$8B:BA25 A0 21 CF    LDY #$CF21             ;\
$8B:BA28 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF21 (intro rinka)
$8B:BA2B A9 01 00    LDA #$0001
$8B:BA2E A0 21 CF    LDY #$CF21             ;\
$8B:BA31 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF21 (intro rinka)
$8B:BA34 7A          PLY
$8B:BA35 60          RTS
}


;;; $BA36: Instruction - spawn intro rinkas 2/3 ;;;
{
$8B:BA36 5A          PHY
$8B:BA37 A9 02 00    LDA #$0002
$8B:BA3A A0 21 CF    LDY #$CF21             ;\
$8B:BA3D 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF21 (intro rinka)
$8B:BA40 A9 03 00    LDA #$0003
$8B:BA43 A0 21 CF    LDY #$CF21             ;\
$8B:BA46 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF21 (intro rinka)
$8B:BA49 7A          PLY
$8B:BA4A 60          RTS
}


;;; $BA4B:  ;;;
{
$8B:BA4B A9 70 00    LDA #$0070
$8B:BA4E 99 7D 1A    STA $1A7D,y[$7E:1A97]
$8B:BA51 A9 9B 00    LDA #$009B
$8B:BA54 99 9D 1A    STA $1A9D,y[$7E:1AB7]
$8B:BA57 A9 00 0E    LDA #$0E00
$8B:BA5A 99 BD 1A    STA $1ABD,y[$7E:1AD7]
$8B:BA5D 60          RTS
}


;;; $BA5E:  ;;;
{
$8B:BA5E BD 1F 1B    LDA $1B1F,x[$7E:1B39]
$8B:BA61 C9 79 CB    CMP #$CB79
$8B:BA64 30 0C       BMI $0C    [$BA72]
$8B:BA66 A9 73 BA    LDA #$BA73
$8B:BA69 9D 3D 1B    STA $1B3D,x[$7E:1B57]
$8B:BA6C 9C 4D 1A    STZ $1A4D  [$7E:1A4D]
$8B:BA6F 9C 4F 1A    STZ $1A4F  [$7E:1A4F]

$8B:BA72 60          RTS
}


;;; $BA73:  ;;;
{
$8B:BA73 BD 9D 1A    LDA $1A9D,x[$7E:1AB7]
$8B:BA76 C9 91 00    CMP #$0091
$8B:BA79 D0 2B       BNE $2B    [$BAA6]
$8B:BA7B A9 00 00    LDA #$0000
$8B:BA7E A0 F1 CE    LDY #$CEF1             ;\
$8B:BA81 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEF1 (metroid egg slime drops)
$8B:BA84 A9 01 00    LDA #$0001
$8B:BA87 A0 F1 CE    LDY #$CEF1             ;\
$8B:BA8A 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEF1 (metroid egg slime drops)
$8B:BA8D A9 02 00    LDA #$0002
$8B:BA90 A0 F1 CE    LDY #$CEF1             ;\
$8B:BA93 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEF1 (metroid egg slime drops)
$8B:BA96 A9 03 00    LDA #$0003
$8B:BA99 A0 F1 CE    LDY #$CEF1             ;\
$8B:BA9C 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEF1 (metroid egg slime drops)
$8B:BA9F A9 23 00    LDA #$0023             ;\
$8B:BAA2 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 23h, sound library 3, max queued sounds allowed = 6 (baby metroid cry 1)

$8B:BAA6 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$8B:BAA9 38          SEC
$8B:BAAA E9 20 00    SBC #$0020
$8B:BAAD DD 9D 1A    CMP $1A9D,x[$7E:1AB7]
$8B:BAB0 30 11       BMI $11    [$BAC3]
$8B:BAB2 AD 4F 1A    LDA $1A4F  [$7E:1A4F]
$8B:BAB5 C9 20 02    CMP #$0220
$8B:BAB8 10 18       BPL $18    [$BAD2]
$8B:BABA 18          CLC
$8B:BABB 69 20 00    ADC #$0020
$8B:BABE 8D 4F 1A    STA $1A4F  [$7E:1A4F]
$8B:BAC1 80 0F       BRA $0F    [$BAD2]

$8B:BAC3 AD 4F 1A    LDA $1A4F  [$7E:1A4F]
$8B:BAC6 C9 E1 FD    CMP #$FDE1
$8B:BAC9 30 07       BMI $07    [$BAD2]
$8B:BACB 38          SEC
$8B:BACC E9 20 00    SBC #$0020
$8B:BACF 8D 4F 1A    STA $1A4F  [$7E:1A4F]

$8B:BAD2 AD 4F 1A    LDA $1A4F  [$7E:1A4F]
$8B:BAD5 EB          XBA
$8B:BAD6 48          PHA
$8B:BAD7 29 00 FF    AND #$FF00
$8B:BADA 85 14       STA $14    [$7E:0014]
$8B:BADC 68          PLA
$8B:BADD 29 FF 00    AND #$00FF
$8B:BAE0 89 80 00    BIT #$0080
$8B:BAE3 F0 03       BEQ $03    [$BAE8]
$8B:BAE5 09 00 FF    ORA #$FF00

$8B:BAE8 85 12       STA $12    [$7E:0012]
$8B:BAEA BD FD 1A    LDA $1AFD,x[$7E:1B17]
$8B:BAED 18          CLC
$8B:BAEE 65 14       ADC $14    [$7E:0014]
$8B:BAF0 9D FD 1A    STA $1AFD,x[$7E:1B17]
$8B:BAF3 BD 9D 1A    LDA $1A9D,x[$7E:1AB7]
$8B:BAF6 65 12       ADC $12    [$7E:0012]
$8B:BAF8 9D 9D 1A    STA $1A9D,x[$7E:1AB7]
$8B:BAFB AD 4F 1A    LDA $1A4F  [$7E:1A4F]
$8B:BAFE 30 0C       BMI $0C    [$BB0C]
$8B:BB00 A9 80 00    LDA #$0080
$8B:BB03 8D 4D 1A    STA $1A4D  [$7E:1A4D]
$8B:BB06 A9 0D BB    LDA #$BB0D
$8B:BB09 9D 3D 1B    STA $1B3D,x[$7E:1B57]

$8B:BB0C 60          RTS
}


;;; $BB0D:  ;;;
{
$8B:BB0D CE 4D 1A    DEC $1A4D  [$7E:1A4D]
$8B:BB10 F0 02       BEQ $02    [$BB14]
$8B:BB12 10 0F       BPL $0F    [$BB23]

$8B:BB14 A9 24 BB    LDA #$BB24
$8B:BB17 9D 3D 1B    STA $1B3D,x[$7E:1B57]
$8B:BB1A 9C 4D 1A    STZ $1A4D  [$7E:1A4D]
$8B:BB1D 9C 4F 1A    STZ $1A4F  [$7E:1A4F]
$8B:BB20 9E 7D 1B    STZ $1B7D,x[$7E:1B97]

$8B:BB23 60          RTS
}


;;; $BB24:  ;;;
{
$8B:BB24 AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:BB27 D0 10       BNE $10    [$BB39]
$8B:BB29 A9 01 00    LDA #$0001
$8B:BB2C 9D 5D 1B    STA $1B5D,x[$7E:1B77]
$8B:BB2F A9 53 CE    LDA #$CE53
$8B:BB32 9D 1D 1B    STA $1B1D,x[$7E:1B37]
$8B:BB35 9C 57 1A    STZ $1A57  [$7E:1A57]
$8B:BB38 60          RTS

$8B:BB39 BD 7D 1B    LDA $1B7D,x[$7E:1B97]
$8B:BB3C C9 80 00    CMP #$0080
$8B:BB3F 10 10       BPL $10    [$BB51]
$8B:BB41 1A          INC A
$8B:BB42 9D 7D 1B    STA $1B7D,x[$7E:1B97]
$8B:BB45 89 3F 00    BIT #$003F
$8B:BB48 D0 07       BNE $07    [$BB51]
$8B:BB4A A9 23 00    LDA #$0023             ;\
$8B:BB4D 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 23h, sound library 3, max queued sounds allowed = 6 (baby metroid cry 1)

$8B:BB51 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$8B:BB54 DD 7D 1A    CMP $1A7D,x[$7E:1A97]
$8B:BB57 30 11       BMI $11    [$BB6A]
$8B:BB59 AD 4D 1A    LDA $1A4D  [$7E:1A4D]
$8B:BB5C C9 80 02    CMP #$0280
$8B:BB5F 10 18       BPL $18    [$BB79]
$8B:BB61 18          CLC
$8B:BB62 69 20 00    ADC #$0020
$8B:BB65 8D 4D 1A    STA $1A4D  [$7E:1A4D]
$8B:BB68 80 0F       BRA $0F    [$BB79]

$8B:BB6A AD 4D 1A    LDA $1A4D  [$7E:1A4D]
$8B:BB6D C9 81 FD    CMP #$FD81
$8B:BB70 30 07       BMI $07    [$BB79]
$8B:BB72 38          SEC
$8B:BB73 E9 20 00    SBC #$0020
$8B:BB76 8D 4D 1A    STA $1A4D  [$7E:1A4D]

$8B:BB79 AD 4D 1A    LDA $1A4D  [$7E:1A4D]
$8B:BB7C EB          XBA
$8B:BB7D 48          PHA
$8B:BB7E 29 00 FF    AND #$FF00
$8B:BB81 85 14       STA $14    [$7E:0014]
$8B:BB83 68          PLA
$8B:BB84 29 FF 00    AND #$00FF
$8B:BB87 89 80 00    BIT #$0080
$8B:BB8A F0 03       BEQ $03    [$BB8F]
$8B:BB8C 09 00 FF    ORA #$FF00

$8B:BB8F 85 12       STA $12    [$7E:0012]
$8B:BB91 10 08       BPL $08    [$BB9B]
$8B:BB93 A9 01 00    LDA #$0001
$8B:BB96 8D 57 1A    STA $1A57  [$7E:1A57]
$8B:BB99 80 06       BRA $06    [$BBA1]

$8B:BB9B A9 FF FF    LDA #$FFFF
$8B:BB9E 8D 57 1A    STA $1A57  [$7E:1A57]

$8B:BBA1 BD DD 1A    LDA $1ADD,x[$7E:1AF7]
$8B:BBA4 18          CLC
$8B:BBA5 65 14       ADC $14    [$7E:0014]
$8B:BBA7 9D DD 1A    STA $1ADD,x[$7E:1AF7]
$8B:BBAA BD 7D 1A    LDA $1A7D,x[$7E:1A97]
$8B:BBAD 65 12       ADC $12    [$7E:0012]
$8B:BBAF 9D 7D 1A    STA $1A7D,x[$7E:1A97]
$8B:BBB2 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$8B:BBB5 38          SEC
$8B:BBB6 E9 08 00    SBC #$0008
$8B:BBB9 DD 9D 1A    CMP $1A9D,x[$7E:1AB7]
$8B:BBBC 30 11       BMI $11    [$BBCF]
$8B:BBBE AD 4F 1A    LDA $1A4F  [$7E:1A4F]
$8B:BBC1 C9 20 02    CMP #$0220
$8B:BBC4 10 18       BPL $18    [$BBDE]
$8B:BBC6 18          CLC
$8B:BBC7 69 20 00    ADC #$0020
$8B:BBCA 8D 4F 1A    STA $1A4F  [$7E:1A4F]
$8B:BBCD 80 0F       BRA $0F    [$BBDE]

$8B:BBCF AD 4F 1A    LDA $1A4F  [$7E:1A4F]
$8B:BBD2 C9 E1 FD    CMP #$FDE1
$8B:BBD5 30 07       BMI $07    [$BBDE]
$8B:BBD7 38          SEC
$8B:BBD8 E9 20 00    SBC #$0020
$8B:BBDB 8D 4F 1A    STA $1A4F  [$7E:1A4F]

$8B:BBDE AD 4F 1A    LDA $1A4F  [$7E:1A4F]
$8B:BBE1 EB          XBA
$8B:BBE2 48          PHA
$8B:BBE3 29 00 FF    AND #$FF00
$8B:BBE6 85 14       STA $14    [$7E:0014]
$8B:BBE8 68          PLA
$8B:BBE9 29 FF 00    AND #$00FF
$8B:BBEC 89 80 00    BIT #$0080
$8B:BBEF F0 03       BEQ $03    [$BBF4]
$8B:BBF1 09 00 FF    ORA #$FF00

$8B:BBF4 85 12       STA $12    [$7E:0012]
$8B:BBF6 BD FD 1A    LDA $1AFD,x[$7E:1B17]
$8B:BBF9 18          CLC
$8B:BBFA 65 14       ADC $14    [$7E:0014]
$8B:BBFC 9D FD 1A    STA $1AFD,x[$7E:1B17]
$8B:BBFF BD 9D 1A    LDA $1A9D,x[$7E:1AB7]
$8B:BC02 65 12       ADC $12    [$7E:0012]
$8B:BC04 9D 9D 1A    STA $1A9D,x[$7E:1AB7]
$8B:BC07 60          RTS
}


;;; $BC08: Reset button assignments to default ;;;
{
$8B:BC08 A9 00 08    LDA #$0800             ;\
$8B:BC0B 8D AA 09    STA $09AA  [$7E:09AA]  ;} Up button
$8B:BC0E A9 00 04    LDA #$0400             ;\
$8B:BC11 8D AC 09    STA $09AC  [$7E:09AC]  ;} Down button
$8B:BC14 A9 00 02    LDA #$0200             ;\
$8B:BC17 8D AE 09    STA $09AE  [$7E:09AE]  ;} Left button
$8B:BC1A A9 00 01    LDA #$0100             ;\
$8B:BC1D 8D B0 09    STA $09B0  [$7E:09B0]  ;} Right button
$8B:BC20 AD B2 09    LDA $09B2  [$7E:09B2]  ;\
$8B:BC23 8D 82 0D    STA $0D82  [$7E:0D82]  ;|
$8B:BC26 AD B4 09    LDA $09B4  [$7E:09B4]  ;|
$8B:BC29 8D 84 0D    STA $0D84  [$7E:0D84]  ;|
$8B:BC2C AD B6 09    LDA $09B6  [$7E:09B6]  ;|
$8B:BC2F 8D 86 0D    STA $0D86  [$7E:0D86]  ;|
$8B:BC32 AD B8 09    LDA $09B8  [$7E:09B8]  ;|
$8B:BC35 8D 88 0D    STA $0D88  [$7E:0D88]  ;} Back up previous button settings to $0D82..8F
$8B:BC38 AD BA 09    LDA $09BA  [$7E:09BA]  ;|
$8B:BC3B 8D 8A 0D    STA $0D8A  [$7E:0D8A]  ;|
$8B:BC3E AD BC 09    LDA $09BC  [$7E:09BC]  ;|
$8B:BC41 8D 8C 0D    STA $0D8C  [$7E:0D8C]  ;|
$8B:BC44 AD BE 09    LDA $09BE  [$7E:09BE]  ;|
$8B:BC47 8D 8E 0D    STA $0D8E  [$7E:0D8E]  ;/
$8B:BC4A A9 40 00    LDA #$0040             ;\
$8B:BC4D 8D B2 09    STA $09B2  [$7E:09B2]  ;} Shoot button
$8B:BC50 A9 80 00    LDA #$0080             ;\
$8B:BC53 8D B4 09    STA $09B4  [$7E:09B4]  ;} Jump button
$8B:BC56 A9 00 80    LDA #$8000             ;\
$8B:BC59 8D B6 09    STA $09B6  [$7E:09B6]  ;} Run button
$8B:BC5C A9 00 40    LDA #$4000             ;\
$8B:BC5F 8D B8 09    STA $09B8  [$7E:09B8]  ;} Item cancel button
$8B:BC62 A9 00 20    LDA #$2000             ;\
$8B:BC65 8D BA 09    STA $09BA  [$7E:09BA]  ;} Item switch button
$8B:BC68 A9 20 00    LDA #$0020             ;\
$8B:BC6B 8D BC 09    STA $09BC  [$7E:09BC]  ;} Aim down button
$8B:BC6E A9 10 00    LDA #$0010             ;\
$8B:BC71 8D BE 09    STA $09BE  [$7E:09BE]  ;} Aim up button
$8B:BC74 60          RTS
}


;;; $BC75: Recover previous button assignments ;;;
{
$8B:BC75 AD 82 0D    LDA $0D82  [$7E:0D82]  ;\
$8B:BC78 8D B2 09    STA $09B2  [$7E:09B2]  ;} Shoot button
$8B:BC7B AD 84 0D    LDA $0D84  [$7E:0D84]  ;\
$8B:BC7E 8D B4 09    STA $09B4  [$7E:09B4]  ;} Jump button
$8B:BC81 AD 86 0D    LDA $0D86  [$7E:0D86]  ;\
$8B:BC84 8D B6 09    STA $09B6  [$7E:09B6]  ;} Run button
$8B:BC87 AD 88 0D    LDA $0D88  [$7E:0D88]  ;\
$8B:BC8A 8D B8 09    STA $09B8  [$7E:09B8]  ;} Item cancel button
$8B:BC8D AD 8A 0D    LDA $0D8A  [$7E:0D8A]  ;\
$8B:BC90 8D BA 09    STA $09BA  [$7E:09BA]  ;} Item switch button
$8B:BC93 AD 8C 0D    LDA $0D8C  [$7E:0D8C]  ;\
$8B:BC96 8D BC 09    STA $09BC  [$7E:09BC]  ;} Aim down button
$8B:BC99 AD 8E 0D    LDA $0D8E  [$7E:0D8E]  ;\
$8B:BC9C 8D BE 09    STA $09BE  [$7E:09BE]  ;} Aim up button
$8B:BC9F 60          RTS
}


;;; $BCA0:  ;;;
{
$8B:BCA0 20 9B 81    JSR $819B  [$8B:819B]
$8B:BCA3 20 DA 93    JSR $93DA  [$8B:93DA]  ; Clear cinematic sprite objects
$8B:BCA6 64 AB       STZ $AB    [$7E:00AB]
$8B:BCA8 64 A7       STZ $A7    [$7E:00A7]
$8B:BCAA A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:BCAD BF E9 E5 8C LDA $8CE5E9,x[$8C:E5E9];|
$8B:BCB1 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$8B:BCB5 E8          INX                    ;} Load space/gunship/Ceres palettes
$8B:BCB6 E8          INX                    ;|
$8B:BCB7 E0 00 02    CPX #$0200             ;|
$8B:BCBA 30 F1       BMI $F1    [$BCAD]     ;/
$8B:BCBC A9 00 95    LDA #$9500             ;\
$8B:BCBF 85 48       STA $48    [$7E:0048]  ;|
$8B:BCC1 A9 2F A8    LDA #$A82F             ;|
$8B:BCC4 85 47       STA $47    [$7E:0047]  ;} Decompress gunship/Ceres tiles to $7F:0000
$8B:BCC6 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:BCCA             dl 7F0000              ;/
$8B:BCCD A9 00 96    LDA #$9600             ;\
$8B:BCD0 85 48       STA $48    [$7E:0048]  ;|
$8B:BCD2 A9 69 FE    LDA #$FE69             ;|
$8B:BCD5 85 47       STA $47    [$7E:0047]  ;} Decompress gunship/Ceres tilemap to $7F:4000
$8B:BCD7 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:BCDB             dl 7F4000              ;/
$8B:BCDE A9 00 96    LDA #$9600             ;\
$8B:BCE1 85 48       STA $48    [$7E:0048]  ;|
$8B:BCE3 A9 0A D1    LDA #$D10A             ;|
$8B:BCE6 85 47       STA $47    [$7E:0047]  ;} Decompress space/Ceres tiles to $7F:5000
$8B:BCE8 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:BCEC             dl 7F5000              ;/
$8B:BCEF E2 30       SEP #$30
$8B:BCF1 A9 00       LDA #$00
$8B:BCF3 8D 16 21    STA $2116  [$7E:2116]
$8B:BCF6 A9 00       LDA #$00
$8B:BCF8 8D 17 21    STA $2117  [$7E:2117]
$8B:BCFB A9 80       LDA #$80
$8B:BCFD 8D 15 21    STA $2115  [$7E:2115]
$8B:BD00 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:BD04             dx 01,00,19,7F0000,4000
$8B:BD0C A9 02       LDA #$02
$8B:BD0E 8D 0B 42    STA $420B  [$7E:420B]
$8B:BD11 C2 10       REP #$10
$8B:BD13 9C 15 21    STZ $2115  [$7E:2115]
$8B:BD16 9C 16 21    STZ $2116  [$7E:2116]
$8B:BD19 9C 17 21    STZ $2117  [$7E:2117]
$8B:BD1C A2 00 40    LDX #$4000
$8B:BD1F A9 8C       LDA #$8C

$8B:BD21 8D 18 21    STA $2118  [$7E:2118]
$8B:BD24 CA          DEX
$8B:BD25 D0 FA       BNE $FA    [$BD21]
$8B:BD27 E2 10       SEP #$10
$8B:BD29 A9 00       LDA #$00
$8B:BD2B 8D 16 21    STA $2116  [$7E:2116]
$8B:BD2E A9 00       LDA #$00
$8B:BD30 8D 17 21    STA $2117  [$7E:2117]
$8B:BD33 A9 00       LDA #$00
$8B:BD35 8D 15 21    STA $2115  [$7E:2115]
$8B:BD38 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:BD3C             dx 01,00,18,7F4000,0300
$8B:BD44 A9 02       LDA #$02
$8B:BD46 8D 0B 42    STA $420B  [$7E:420B]
$8B:BD49 A9 00       LDA #$00
$8B:BD4B 8D 16 21    STA $2116  [$7E:2116]
$8B:BD4E A9 60       LDA #$60
$8B:BD50 8D 17 21    STA $2117  [$7E:2117]
$8B:BD53 A9 80       LDA #$80
$8B:BD55 8D 15 21    STA $2115  [$7E:2115]
$8B:BD58 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:BD5C             dx 01,01,18,7F5000,4000
$8B:BD64 A9 02       LDA #$02
$8B:BD66 8D 0B 42    STA $420B  [$7E:420B]
$8B:BD69 C2 30       REP #$30
$8B:BD6B A9 00 01    LDA #$0100
$8B:BD6E 8D 1B 21    STA $211B  [$7E:211B]
$8B:BD71 85 78       STA $78    [$7E:0078]
$8B:BD73 9C 1C 21    STZ $211C  [$7E:211C]
$8B:BD76 64 7A       STZ $7A    [$7E:007A]
$8B:BD78 9C 1D 21    STZ $211D  [$7E:211D]
$8B:BD7B 64 7C       STZ $7C    [$7E:007C]
$8B:BD7D 8D 1E 21    STA $211E  [$7E:211E]
$8B:BD80 85 7E       STA $7E    [$7E:007E]
$8B:BD82 A9 38 00    LDA #$0038
$8B:BD85 8D 1F 21    STA $211F  [$7E:211F]
$8B:BD88 85 80       STA $80    [$7E:0080]
$8B:BD8A A9 18 00    LDA #$0018
$8B:BD8D 8D 20 21    STA $2120  [$7E:2120]
$8B:BD90 85 82       STA $82    [$7E:0082]
$8B:BD92 A9 B8 FF    LDA #$FFB8
$8B:BD95 8D 93 19    STA $1993  [$7E:1993]
$8B:BD98 A9 98 FF    LDA #$FF98
$8B:BD9B 8D 97 19    STA $1997  [$7E:1997]
$8B:BD9E A9 E0 00    LDA #$00E0
$8B:BDA1 8D 8D 19    STA $198D  [$7E:198D]
$8B:BDA4 A9 00 02    LDA #$0200
$8B:BDA7 8D 8F 19    STA $198F  [$7E:198F]
$8B:BDAA 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]
$8B:BDAE 22 C2 C4 8D JSL $8DC4C2[$8D:C4C2]
$8B:BDB2 A9 00 00    LDA #$0000
$8B:BDB5 22 CE 95 8B JSL $8B95CE[$8B:95CE]
$8B:BDB9 A9 00 5C    LDA #$5C00             ;\
$8B:BDBC 8D F5 19    STA $19F5  [$7E:19F5]  ;} Cinematic BG VRAM address = $5C00 (BG1 tilemap)
$8B:BDBF 22 4B 83 80 JSL $80834B[$80:834B]
$8B:BDC3 A0 0F CF    LDY #$CF0F             ;\
$8B:BDC6 A9 00 00    LDA #$0000             ;} Spawn cinematic sprite object $CF0F (Ceres stars)
$8B:BDC9 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:BDCC A9 E4 BD    LDA #$BDE4
$8B:BDCF 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:BDD2 A9 2D FF    LDA #$FF2D             ;\
$8B:BDD5 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue Ceres music data
$8B:BDD9 A9 05 00    LDA #$0005             ;\
$8B:BDDC A0 0E 00    LDY #$000E             ;} Queue song 0 music track, 14 frame delay
$8B:BDDF 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/
$8B:BDE3 60          RTS
}


;;; $BDE4:  ;;;
{
$8B:BDE4 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$8B:BDE8 B0 0E       BCS $0E    [$BDF8]     ;} If music is queued: return
$8B:BDEA E2 20       SEP #$20
$8B:BDEC A9 0F       LDA #$0F
$8B:BDEE 85 51       STA $51    [$7E:0051]
$8B:BDF0 C2 20       REP #$20
$8B:BDF2 A9 F9 BD    LDA #$BDF9
$8B:BDF5 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:BDF8 60          RTS
}


;;; $BDF9:  ;;;
{
$8B:BDF9 AD 8F 19    LDA $198F  [$7E:198F]
$8B:BDFC C9 20 00    CMP #$0020
$8B:BDFF 30 08       BMI $08    [$BE09]
$8B:BE01 38          SEC
$8B:BE02 E9 10 00    SBC #$0010
$8B:BE05 8D 8F 19    STA $198F  [$7E:198F]
$8B:BE08 60          RTS

$8B:BE09 E2 20       SEP #$20
$8B:BE0B 64 6F       STZ $6F    [$7E:006F]
$8B:BE0D A9 31       LDA #$31
$8B:BE0F 85 72       STA $72    [$7E:0072]
$8B:BE11 A9 3F       LDA #$3F
$8B:BE13 85 74       STA $74    [$7E:0074]
$8B:BE15 A9 5F       LDA #$5F
$8B:BE17 85 75       STA $75    [$7E:0075]
$8B:BE19 A9 9F       LDA #$9F
$8B:BE1B 85 76       STA $76    [$7E:0076]
$8B:BE1D C2 20       REP #$20
$8B:BE1F 20 DA 93    JSR $93DA  [$8B:93DA]  ; Clear cinematic sprite objects
$8B:BE22 A2 74 BE    LDX #$BE74
$8B:BE25 22 4F 8B 80 JSL $808B4F[$80:8B4F]
$8B:BE29 A9 E0 FF    LDA #$FFE0
$8B:BE2C 8D 93 19    STA $1993  [$7E:1993]
$8B:BE2F A9 80 FF    LDA #$FF80
$8B:BE32 8D 97 19    STA $1997  [$7E:1997]
$8B:BE35 A9 20 00    LDA #$0020
$8B:BE38 8D 8D 19    STA $198D  [$7E:198D]
$8B:BE3B A0 39 CF    LDY #$CF39             ;\
$8B:BE3E 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF39 (Ceres explosion large asteroids)
$8B:BE41 A0 85 CE    LDY #$CE85             ;\
$8B:BE44 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE85 (Ceres under attack)
$8B:BE47 A0 8B CE    LDY #$CE8B             ;\
$8B:BE4A 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE8B (Ceres small asteroids)
$8B:BE4D A0 91 CE    LDY #$CE91             ;\
$8B:BE50 A9 01 00    LDA #$0001             ;} Spawn cinematic sprite object $CE91 (Ceres purple space vortex)
$8B:BE53 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:BE56 A0 0F CF    LDY #$CF0F             ;\
$8B:BE59 A9 01 00    LDA #$0001             ;} Spawn cinematic sprite object $CF0F (Ceres stars)
$8B:BE5C 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:BE5F A9 DA BF    LDA #$BFDA
$8B:BE62 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:BE65 A0 A8 E1    LDY #$E1A8             ;\
$8B:BE68 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1A8 (cutscene gunship engine flicker)
$8B:BE6C A0 AC E1    LDY #$E1AC             ;\
$8B:BE6F 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1AC (cutscene Ceres navigation lights - sprite Ceres)
$8B:BE73 60          RTS

; Mode 7 transfers data - back of gunship
;                        ______________________ Control. 80h = write to VRAM tilemap
;                       |   ___________________ Source address
;                       |  |       ____________ Size
;                       |  |      |     _______ Destination address (VRAM)
;                       |  |      |    |     __ VRAM address increment mode
;                       |  |      |    |    |
$8B:BE74             dx 80,7F4300,0300,0000,00, 00
}


;;; $BE7E:  ;;;
{
$8B:BE7E AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:BE81 D0 19       BNE $19    [$BE9C]
$8B:BE83 A9 00 FC    LDA #$FC00
$8B:BE86 99 7D 1B    STA $1B7D,y[$7E:1B9B]
$8B:BE89 A9 70 00    LDA #$0070
$8B:BE8C 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:BE8F A9 57 00    LDA #$0057
$8B:BE92 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:BE95 A9 00 08    LDA #$0800
$8B:BE98 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:BE9B 60          RTS

$8B:BE9C A9 C6 BF    LDA #$BFC6
$8B:BE9F 99 3D 1B    STA $1B3D,y[$7E:1B53]
$8B:BEA2 A9 E0 FF    LDA #$FFE0
$8B:BEA5 99 7D 1A    STA $1A7D,y[$7E:1A93]
$8B:BEA8 A9 57 00    LDA #$0057
$8B:BEAB 99 9D 1A    STA $1A9D,y[$7E:1AB3]
$8B:BEAE A9 00 08    LDA #$0800
$8B:BEB1 99 BD 1A    STA $1ABD,y[$7E:1AD3]
$8B:BEB4 60          RTS
}


;;; $BEB5:  ;;;
{
$8B:BEB5 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:BEB8 C9 F9 BD    CMP #$BDF9             ;} If [$1F51] != $BDF9:
$8B:BEBB F0 01       BEQ $01    [$BEBE]     ;/
$8B:BEBD 60          RTS                    ; Return

$8B:BEBE BD 7D 1B    LDA $1B7D,x[$7E:1B9B]
$8B:BEC1 18          CLC
$8B:BEC2 69 80 00    ADC #$0080
$8B:BEC5 9D 7D 1B    STA $1B7D,x[$7E:1B9B]
$8B:BEC8 EB          XBA
$8B:BEC9 48          PHA
$8B:BECA 29 00 FF    AND #$FF00
$8B:BECD 85 14       STA $14    [$7E:0014]
$8B:BECF 68          PLA
$8B:BED0 29 FF 00    AND #$00FF
$8B:BED3 89 80 00    BIT #$0080
$8B:BED6 F0 03       BEQ $03    [$BEDB]
$8B:BED8 09 00 FF    ORA #$FF00

$8B:BEDB 85 12       STA $12    [$7E:0012]
$8B:BEDD BD FD 1A    LDA $1AFD,x[$7E:1B1B]
$8B:BEE0 18          CLC
$8B:BEE1 65 14       ADC $14    [$7E:0014]
$8B:BEE3 9D FD 1A    STA $1AFD,x[$7E:1B1B]
$8B:BEE6 BD 9D 1A    LDA $1A9D,x[$7E:1ABB]
$8B:BEE9 65 12       ADC $12    [$7E:0012]
$8B:BEEB 9D 9D 1A    STA $1A9D,x[$7E:1ABB]
$8B:BEEE BD DD 1A    LDA $1ADD,x[$7E:1AFB]
$8B:BEF1 18          CLC
$8B:BEF2 65 14       ADC $14    [$7E:0014]
$8B:BEF4 9D DD 1A    STA $1ADD,x[$7E:1AFB]
$8B:BEF7 BD 7D 1A    LDA $1A7D,x[$7E:1A9B]
$8B:BEFA 65 12       ADC $12    [$7E:0012]
$8B:BEFC 9D 7D 1A    STA $1A7D,x[$7E:1A9B]
$8B:BEFF AD 91 19    LDA $1991  [$7E:1991]
$8B:BF02 18          CLC
$8B:BF03 65 14       ADC $14    [$7E:0014]
$8B:BF05 8D 91 19    STA $1991  [$7E:1991]
$8B:BF08 AD 93 19    LDA $1993  [$7E:1993]
$8B:BF0B 65 12       ADC $12    [$7E:0012]
$8B:BF0D 8D 93 19    STA $1993  [$7E:1993]
$8B:BF10 AD 95 19    LDA $1995  [$7E:1995]
$8B:BF13 18          CLC
$8B:BF14 65 14       ADC $14    [$7E:0014]
$8B:BF16 8D 95 19    STA $1995  [$7E:1995]
$8B:BF19 AD 97 19    LDA $1997  [$7E:1997]
$8B:BF1C 65 12       ADC $12    [$7E:0012]
$8B:BF1E 8D 97 19    STA $1997  [$7E:1997]
$8B:BF21 60          RTS
}


;;; $BF22:  ;;;
{
$8B:BF22 A9 50 00    LDA #$0050
$8B:BF25 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:BF28 A9 9F 00    LDA #$009F
$8B:BF2B 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:BF2E A9 00 08    LDA #$0800
$8B:BF31 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:BF34 60          RTS
}


;;; $BF35:  ;;;
{
$8B:BF35 BD DD 1A    LDA $1ADD,x[$7E:1AFB]
$8B:BF38 18          CLC
$8B:BF39 69 00 40    ADC #$4000
$8B:BF3C 9D DD 1A    STA $1ADD,x[$7E:1AFB]
$8B:BF3F BD 7D 1A    LDA $1A7D,x[$7E:1A9B]
$8B:BF42 69 00 00    ADC #$0000
$8B:BF45 29 FF 01    AND #$01FF
$8B:BF48 9D 7D 1A    STA $1A7D,x[$7E:1A9B]
$8B:BF4B 60          RTS
}


;;; $BF4C:  ;;;
{
$8B:BF4C A9 74 00    LDA #$0074
$8B:BF4F 99 7D 1A    STA $1A7D,y[$7E:1A99]
$8B:BF52 A9 A0 00    LDA #$00A0
$8B:BF55 99 9D 1A    STA $1A9D,y[$7E:1AB9]
$8B:BF58 A9 00 0C    LDA #$0C00
$8B:BF5B 99 BD 1A    STA $1ABD,y[$7E:1AD9]
$8B:BF5E 60          RTS
}


;;; $BF5F:  ;;;
{
$8B:BF5F BD DD 1A    LDA $1ADD,x[$7E:1AF9]
$8B:BF62 18          CLC
$8B:BF63 69 00 10    ADC #$1000
$8B:BF66 9D DD 1A    STA $1ADD,x[$7E:1AF9]
$8B:BF69 BD 7D 1A    LDA $1A7D,x[$7E:1A99]
$8B:BF6C 69 00 00    ADC #$0000
$8B:BF6F 29 FF 01    AND #$01FF
$8B:BF72 9D 7D 1A    STA $1A7D,x[$7E:1A99]
$8B:BF75 60          RTS
}


;;; $BF76:  ;;;
{
$8B:BF76 A9 80 00    LDA #$0080
$8B:BF79 99 7D 1A    STA $1A7D,y[$7E:1A97]
$8B:BF7C A9 60 00    LDA #$0060
$8B:BF7F 99 9D 1A    STA $1A9D,y[$7E:1AB7]
$8B:BF82 A9 00 08    LDA #$0800
$8B:BF85 99 BD 1A    STA $1ABD,y[$7E:1AD7]
$8B:BF88 60          RTS
}


;;; $BF89:  ;;;
{
$8B:BF89 BD DD 1A    LDA $1ADD,x[$7E:1AF7]
$8B:BF8C 18          CLC
$8B:BF8D 69 00 08    ADC #$0800
$8B:BF90 9D DD 1A    STA $1ADD,x[$7E:1AF7]
$8B:BF93 BD 7D 1A    LDA $1A7D,x[$7E:1A97]
$8B:BF96 69 00 00    ADC #$0000
$8B:BF99 29 FF 01    AND #$01FF
$8B:BF9C 9D 7D 1A    STA $1A7D,x[$7E:1A97]
$8B:BF9F 60          RTS
}


;;; $BFA0:  ;;;
{
$8B:BFA0 AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:BFA3 D0 0E       BNE $0E    [$BFB3]
$8B:BFA5 A9 70 00    LDA #$0070
$8B:BFA8 99 7D 1A    STA $1A7D,y[$7E:1A7D]
$8B:BFAB A9 D9 BF    LDA #$BFD9
$8B:BFAE 99 3D 1B    STA $1B3D,y[$7E:1B3D]
$8B:BFB1 80 06       BRA $06    [$BFB9]

$8B:BFB3 A9 E0 00    LDA #$00E0
$8B:BFB6 99 7D 1A    STA $1A7D,y[$7E:1A95]

$8B:BFB9 A9 57 00    LDA #$0057
$8B:BFBC 99 9D 1A    STA $1A9D,y[$7E:1AB5]
$8B:BFBF A9 00 08    LDA #$0800
$8B:BFC2 99 BD 1A    STA $1ABD,y[$7E:1AD5]
$8B:BFC5 60          RTS
}


;;; $BFC6:  ;;;
{
$8B:BFC6 BD DD 1A    LDA $1ADD,x[$7E:1AF5]
$8B:BFC9 38          SEC
$8B:BFCA E9 00 20    SBC #$2000
$8B:BFCD 9D DD 1A    STA $1ADD,x[$7E:1AF5]
$8B:BFD0 BD 7D 1A    LDA $1A7D,x[$7E:1A95]
$8B:BFD3 E9 00 00    SBC #$0000
$8B:BFD6 9D 7D 1A    STA $1A7D,x[$7E:1A95]
$8B:BFD9 60          RTS
}


;;; $BFDA:  ;;;
{
$8B:BFDA E2 20       SEP #$20
$8B:BFDC A5 74       LDA $74    [$7E:0074]
$8B:BFDE 38          SEC
$8B:BFDF E9 01       SBC #$01
$8B:BFE1 85 74       STA $74    [$7E:0074]
$8B:BFE3 C9 20       CMP #$20
$8B:BFE5 10 04       BPL $04    [$BFEB]
$8B:BFE7 A9 20       LDA #$20
$8B:BFE9 85 74       STA $74    [$7E:0074]

$8B:BFEB A5 75       LDA $75    [$7E:0075]
$8B:BFED 38          SEC
$8B:BFEE E9 01       SBC #$01
$8B:BFF0 85 75       STA $75    [$7E:0075]
$8B:BFF2 C9 40       CMP #$40
$8B:BFF4 10 04       BPL $04    [$BFFA]
$8B:BFF6 A9 40       LDA #$40
$8B:BFF8 85 75       STA $75    [$7E:0075]

$8B:BFFA A5 76       LDA $76    [$7E:0076]
$8B:BFFC 38          SEC
$8B:BFFD E9 01       SBC #$01
$8B:BFFF 85 76       STA $76    [$7E:0076]
$8B:C001 C9 80       CMP #$80
$8B:C003 10 04       BPL $04    [$C009]
$8B:C005 A9 80       LDA #$80
$8B:C007 85 76       STA $76    [$7E:0076]

$8B:C009 C2 20       REP #$20
$8B:C00B AD 91 19    LDA $1991  [$7E:1991]
$8B:C00E 38          SEC
$8B:C00F E9 00 20    SBC #$2000
$8B:C012 8D 91 19    STA $1991  [$7E:1991]
$8B:C015 AD 93 19    LDA $1993  [$7E:1993]
$8B:C018 E9 00 00    SBC #$0000
$8B:C01B 8D 93 19    STA $1993  [$7E:1993]
$8B:C01E AD 8F 19    LDA $198F  [$7E:198F]
$8B:C021 C9 00 0C    CMP #$0C00
$8B:C024 10 08       BPL $08    [$C02E]
$8B:C026 18          CLC
$8B:C027 69 10 00    ADC #$0010
$8B:C02A 8D 8F 19    STA $198F  [$7E:198F]
$8B:C02D 60          RTS

$8B:C02E AD 8F 19    LDA $198F  [$7E:198F]
$8B:C031 C9 00 20    CMP #$2000
$8B:C034 10 08       BPL $08    [$C03E]
$8B:C036 18          CLC
$8B:C037 69 20 00    ADC #$0020
$8B:C03A 8D 8F 19    STA $198F  [$7E:198F]
$8B:C03D 60          RTS

$8B:C03E E2 20       SEP #$20
$8B:C040 A9 11       LDA #$11
$8B:C042 85 69       STA $69    [$7E:0069]
$8B:C044 A9 01       LDA #$01
$8B:C046 85 55       STA $55    [$7E:0055]
$8B:C048 A9 00       LDA #$00
$8B:C04A 85 5F       STA $5F    [$7E:005F]
$8B:C04C A9 5C       LDA #$5C
$8B:C04E 85 58       STA $58    [$7E:0058]
$8B:C050 A9 06       LDA #$06
$8B:C052 85 5D       STA $5D    [$7E:005D]
$8B:C054 C2 20       REP #$20
$8B:C056 A9 00 01    LDA #$0100
$8B:C059 8D 8F 19    STA $198F  [$7E:198F]
$8B:C05C 9C 8D 19    STZ $198D  [$7E:198D]
$8B:C05F 9C 91 19    STZ $1991  [$7E:1991]
$8B:C062 9C 93 19    STZ $1993  [$7E:1993]
$8B:C065 9C 95 19    STZ $1995  [$7E:1995]
$8B:C068 9C 97 19    STZ $1997  [$7E:1997]
$8B:C06B 22 A2 95 8B JSL $8B95A2[$8B:95A2]
$8B:C06F 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:C073 A0 69 CF    LDY #$CF69             ;\
$8B:C076 A9 00 5C    LDA #$5C00             ;} Spawn space colony cinematic BG object for VRAM $4C00
$8B:C079 20 F0 95    JSR $95F0  [$8B:95F0]  ;/
$8B:C07C A9 8F A3    LDA #$A38F
$8B:C07F 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:C082 60          RTS
}


;;; $C083:  ;;;
{
$8B:C083 A9 7C 00    LDA #$007C
$8B:C086 99 7D 1A    STA $1A7D,y
$8B:C089 A9 BA 00    LDA #$00BA
$8B:C08C 99 9D 1A    STA $1A9D,y
$8B:C08F A9 00 00    LDA #$0000
$8B:C092 99 BD 1A    STA $1ABD,y
$8B:C095 60          RTS
}


;;; $C096: Instruction - skip next instruction if English text ;;;
{
$8B:C096 AD E2 09    LDA $09E2  [$7E:09E2]
$8B:C099 D0 06       BNE $06    [$C0A1]
$8B:C09B 98          TYA
$8B:C09C 18          CLC
$8B:C09D 69 06 00    ADC #$0006
$8B:C0A0 A8          TAY

$8B:C0A1 60          RTS
}


;;; $C0A2: Instruction - finish intro ;;;
{
$8B:C0A2 A9 C5 C0    LDA #$C0C5
$8B:C0A5 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:C0A8 A9 01 00    LDA #$0001
$8B:C0AB 8D 23 07    STA $0723  [$7E:0723]
$8B:C0AE 8D 25 07    STA $0725  [$7E:0725]
$8B:C0B1 60          RTS
}


;;; $C0B2:  ;;;
{
$8B:C0B2 A9 7C 00    LDA #$007C
$8B:C0B5 99 7D 1A    STA $1A7D,y
$8B:C0B8 A9 CC 00    LDA #$00CC
$8B:C0BB 99 9D 1A    STA $1A9D,y
$8B:C0BE A9 00 00    LDA #$0000
$8B:C0C1 99 BD 1A    STA $1ABD,y
$8B:C0C4 60          RTS
}


;;; $C0C5:  ;;;
{
$8B:C0C5 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$8B:C0C9 E2 20       SEP #$20
$8B:C0CB A5 51       LDA $51    [$7E:0051]  ;\
$8B:C0CD C9 80       CMP #$80               ;} If not finished fading out: return
$8B:C0CF D0 2E       BNE $2E    [$C0FF]     ;/
$8B:C0D1 22 4B 83 80 JSL $80834B[$80:834B]
$8B:C0D5 C2 20       REP #$20
$8B:C0D7 9C 23 07    STZ $0723  [$7E:0723]
$8B:C0DA 9C 25 07    STZ $0725  [$7E:0725]
$8B:C0DD 64 B5       STZ $B5    [$7E:00B5]
$8B:C0DF 64 B9       STZ $B9    [$7E:00B9]
$8B:C0E1 64 B7       STZ $B7    [$7E:00B7]
$8B:C0E3 64 BB       STZ $BB    [$7E:00BB]
$8B:C0E5 9C 8D 19    STZ $198D  [$7E:198D]
$8B:C0E8 A9 1F 1C    LDA #$1C1F
$8B:C0EB 3A          DEC A
$8B:C0EC 3A          DEC A
$8B:C0ED 38          SEC
$8B:C0EE E9 8D 19    SBC #$198D
$8B:C0F1 AA          TAX

$8B:C0F2 9E 8D 19    STZ $198D,x[$7E:1C1D]
$8B:C0F5 CA          DEX
$8B:C0F6 CA          DEX
$8B:C0F7 10 F9       BPL $F9    [$C0F2]
$8B:C0F9 A9 00 C1    LDA #$C100
$8B:C0FC 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:C0FF 60          RTS
}


;;; $C100:  ;;;
{
$8B:C100 A9 1F 00    LDA #$001F
$8B:C103 8F 14 D9 7E STA $7ED914[$7E:D914]
$8B:C107 8D 98 09    STA $0998  [$7E:0998]  ; Game state = 1Fh (set up new game)
$8B:C10A A9 06 00    LDA #$0006
$8B:C10D 8D 9F 07    STA $079F  [$7E:079F]
$8B:C110 9C 8B 07    STZ $078B  [$7E:078B]
$8B:C113 AD 52 09    LDA $0952  [$7E:0952]  ;\
$8B:C116 22 00 80 81 JSL $818000[$81:8000]  ;} Save current save slot to SRAM
$8B:C11A 60          RTS
}


;;; $C11B: Cinematic function - escaping Ceres ;;;
{
$8B:C11B A2 08 00    LDX #$0008

$8B:C11E 22 38 83 80 JSL $808338[$80:8338]
$8B:C122 CA          DEX
$8B:C123 10 F9       BPL $F9    [$C11E]
$8B:C125 20 9B 81    JSR $819B  [$8B:819B]
$8B:C128 A9 1F 1C    LDA #$1C1F
$8B:C12B 3A          DEC A
$8B:C12C 3A          DEC A
$8B:C12D 38          SEC
$8B:C12E E9 8D 19    SBC #$198D
$8B:C131 AA          TAX

$8B:C132 9E 8D 19    STZ $198D,x[$7E:1C1D]
$8B:C135 CA          DEX
$8B:C136 CA          DEX
$8B:C137 10 F9       BPL $F9    [$C132]
$8B:C139 9C 8D 07    STZ $078D  [$7E:078D]
$8B:C13C 9C 11 09    STZ $0911  [$7E:0911]
$8B:C13F 9C 15 09    STZ $0915  [$7E:0915]
$8B:C142 A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:C145 BF E9 E5 8C LDA $8CE5E9,x[$8C:E5E9];|
$8B:C149 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$8B:C14D E8          INX                    ;} Load space/gunship/Ceres palettes
$8B:C14E E8          INX                    ;|
$8B:C14F E0 00 02    CPX #$0200             ;|
$8B:C152 30 F1       BMI $F1    [$C145]     ;/
$8B:C154 A9 00 95    LDA #$9500             ;\
$8B:C157 85 48       STA $48    [$7E:0048]  ;|
$8B:C159 A9 2F A8    LDA #$A82F             ;|
$8B:C15C 85 47       STA $47    [$7E:0047]  ;} Decompress gunship/Ceres tiles to $7F:0000
$8B:C15E 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:C162             dl 7F0000              ;/
$8B:C165 A9 00 96    LDA #$9600             ;\
$8B:C168 85 48       STA $48    [$7E:0048]  ;|
$8B:C16A A9 69 FE    LDA #$FE69             ;|
$8B:C16D 85 47       STA $47    [$7E:0047]  ;} Decompress gunship/Ceres tilemap to $7F:4000
$8B:C16F 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:C173             dl 7F4000              ;/
$8B:C176 A9 00 96    LDA #$9600             ;\
$8B:C179 85 48       STA $48    [$7E:0048]  ;|
$8B:C17B A9 0A D1    LDA #$D10A             ;|
$8B:C17E 85 47       STA $47    [$7E:0047]  ;} Decompress space/Ceres tiles to $7F:5000
$8B:C180 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:C184             dl 7F5000              ;/
$8B:C187 E2 30       SEP #$30
$8B:C189 A9 00       LDA #$00
$8B:C18B 8D 16 21    STA $2116  [$7E:2116]
$8B:C18E A9 00       LDA #$00
$8B:C190 8D 17 21    STA $2117  [$7E:2117]
$8B:C193 A9 80       LDA #$80
$8B:C195 8D 15 21    STA $2115  [$7E:2115]
$8B:C198 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:C19C             dx 01,00,19,7F0000,4000
$8B:C1A4 A9 02       LDA #$02
$8B:C1A6 8D 0B 42    STA $420B  [$7E:420B]
$8B:C1A9 C2 10       REP #$10
$8B:C1AB 9C 15 21    STZ $2115  [$7E:2115]
$8B:C1AE 9C 16 21    STZ $2116  [$7E:2116]
$8B:C1B1 9C 17 21    STZ $2117  [$7E:2117]
$8B:C1B4 A2 00 40    LDX #$4000
$8B:C1B7 A9 8C       LDA #$8C

$8B:C1B9 8D 18 21    STA $2118  [$7E:2118]
$8B:C1BC CA          DEX
$8B:C1BD D0 FA       BNE $FA    [$C1B9]
$8B:C1BF E2 10       SEP #$10
$8B:C1C1 A9 00       LDA #$00
$8B:C1C3 8D 16 21    STA $2116  [$7E:2116]
$8B:C1C6 A9 00       LDA #$00
$8B:C1C8 8D 17 21    STA $2117  [$7E:2117]
$8B:C1CB A9 00       LDA #$00
$8B:C1CD 8D 15 21    STA $2115  [$7E:2115]
$8B:C1D0 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:C1D4             dx 01,00,18,7F4600,0600
$8B:C1DC A9 02       LDA #$02
$8B:C1DE 8D 0B 42    STA $420B  [$7E:420B]
$8B:C1E1 A9 00       LDA #$00
$8B:C1E3 8D 16 21    STA $2116  [$7E:2116]
$8B:C1E6 A9 60       LDA #$60
$8B:C1E8 8D 17 21    STA $2117  [$7E:2117]
$8B:C1EB A9 80       LDA #$80
$8B:C1ED 8D 15 21    STA $2115  [$7E:2115]
$8B:C1F0 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:C1F4             dx 01,01,18,7F5000,4000
$8B:C1FC A9 02       LDA #$02
$8B:C1FE 8D 0B 42    STA $420B  [$7E:420B]
$8B:C201 A9 00       LDA #$00
$8B:C203 8D 16 21    STA $2116  [$7E:2116]
$8B:C206 A9 60       LDA #$60
$8B:C208 8D 17 21    STA $2117  [$7E:2117]
$8B:C20B A9 80       LDA #$80
$8B:C20D 8D 15 21    STA $2115  [$7E:2115]
$8B:C210 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:C214             dx 01,01,18,9AD200,1A00
$8B:C21C A9 02       LDA #$02
$8B:C21E 8D 0B 42    STA $420B  [$7E:420B]
$8B:C221 C2 30       REP #$30
$8B:C223 A9 00 01    LDA #$0100
$8B:C226 8D 1B 21    STA $211B  [$7E:211B]
$8B:C229 85 78       STA $78    [$7E:0078]
$8B:C22B 9C 1C 21    STZ $211C  [$7E:211C]
$8B:C22E 64 7A       STZ $7A    [$7E:007A]
$8B:C230 9C 1D 21    STZ $211D  [$7E:211D]
$8B:C233 64 7C       STZ $7C    [$7E:007C]
$8B:C235 8D 1E 21    STA $211E  [$7E:211E]
$8B:C238 85 7E       STA $7E    [$7E:007E]
$8B:C23A A9 34 00    LDA #$0034
$8B:C23D 8D 1F 21    STA $211F  [$7E:211F]
$8B:C240 85 80       STA $80    [$7E:0080]
$8B:C242 A9 30 00    LDA #$0030
$8B:C245 8D 20 21    STA $2120  [$7E:2120]
$8B:C248 85 82       STA $82    [$7E:0082]
$8B:C24A A9 D4 FF    LDA #$FFD4
$8B:C24D 8D 93 19    STA $1993  [$7E:1993]
$8B:C250 A9 90 FF    LDA #$FF90
$8B:C253 8D 97 19    STA $1997  [$7E:1997]
$8B:C256 9C 8D 19    STZ $198D  [$7E:198D]
$8B:C259 A9 00 01    LDA #$0100
$8B:C25C 8D 8F 19    STA $198F  [$7E:198F]
$8B:C25F 22 93 82 88 JSL $888293[$88:8293]
$8B:C263 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$8B:C267 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]
$8B:C26B 22 C2 C4 8D JSL $8DC4C2[$8D:C4C2]
$8B:C26F A9 2F 00    LDA #$002F
$8B:C272 22 CE 95 8B JSL $8B95CE[$8B:95CE]
$8B:C276 A9 00 00    LDA #$0000
$8B:C279 8D F5 19    STA $19F5  [$7E:19F5]
$8B:C27C A0 7F CE    LDY #$CE7F             ;\
$8B:C27F 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CE7F (Ceres under attack large asteroids)
$8B:C282 A0 8B CE    LDY #$CE8B             ;\
$8B:C285 A9 02 00    LDA #$0002             ;|
$8B:C288 85 12       STA $12    [$7E:0012]  ;} Spawn cinematic sprite object $CE8B to index 2 (Ceres small asteroids)
$8B:C28A 20 A2 93    JSR $93A2  [$8B:93A2]  ;/
$8B:C28D A0 91 CE    LDY #$CE91             ;\
$8B:C290 64 12       STZ $12    [$7E:0012]  ;|
$8B:C292 A9 00 00    LDA #$0000             ;} Spawn cinematic sprite object $CE91 to index 0 (Ceres purple space vortex)
$8B:C295 20 A2 93    JSR $93A2  [$8B:93A2]  ;/
$8B:C298 A0 33 CF    LDY #$CF33             ;\
$8B:C29B 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF33 (Ceres explosion spawner)
$8B:C29E A0 B8 E1    LDY #$E1B8             ;\
$8B:C2A1 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1B8 (cutscene Ceres navigation lights - BG Ceres)
$8B:C2A5 22 4B 83 80 JSL $80834B[$80:834B]
$8B:C2A9 A9 01 00    LDA #$0001
$8B:C2AC 8D 23 07    STA $0723  [$7E:0723]
$8B:C2AF 8D 25 07    STA $0725  [$7E:0725]
$8B:C2B2 A9 E4 C2    LDA #$C2E4
$8B:C2B5 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:C2B8 A9 00 00    LDA #$0000             ;\
$8B:C2BB 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$8B:C2BF A9 2D FF    LDA #$FF2D             ;\
$8B:C2C2 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue Ceres music data
$8B:C2C6 AD 98 09    LDA $0998  [$7E:0998]
$8B:C2C9 C9 25 00    CMP #$0025
$8B:C2CC D0 0B       BNE $0B    [$C2D9]
$8B:C2CE A9 08 00    LDA #$0008
$8B:C2D1 A0 0E 00    LDY #$000E
$8B:C2D4 22 F7 8F 80 JSL $808FF7[$80:8FF7]
$8B:C2D8 60          RTS

$8B:C2D9 A9 07 00    LDA #$0007             ;\
$8B:C2DC A0 0E 00    LDY #$000E             ;} Queue song 2 music track, 14 frame delay
$8B:C2DF 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/
$8B:C2E3 60          RTS
}


;;; $C2E4:  ;;;
{
$8B:C2E4 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$8B:C2E8 B0 06       BCS $06    [$C2F0]     ;} If music is queued: return
$8B:C2EA A9 F1 C2    LDA #$C2F1
$8B:C2ED 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:C2F0 60          RTS
}


;;; $C2F1:  ;;;
{
$8B:C2F1 AD 95 19    LDA $1995  [$7E:1995]
$8B:C2F4 18          CLC
$8B:C2F5 69 00 10    ADC #$1000
$8B:C2F8 8D 95 19    STA $1995  [$7E:1995]
$8B:C2FB AD 97 19    LDA $1997  [$7E:1997]
$8B:C2FE 69 00 00    ADC #$0000
$8B:C301 8D 97 19    STA $1997  [$7E:1997]
$8B:C304 AD 91 19    LDA $1991  [$7E:1991]
$8B:C307 38          SEC
$8B:C308 E9 00 40    SBC #$4000
$8B:C30B 8D 91 19    STA $1991  [$7E:1991]
$8B:C30E AD 93 19    LDA $1993  [$7E:1993]
$8B:C311 E9 00 00    SBC #$0000
$8B:C314 8D 93 19    STA $1993  [$7E:1993]
$8B:C317 AD 8F 19    LDA $198F  [$7E:198F]
$8B:C31A 18          CLC
$8B:C31B 69 01 00    ADC #$0001
$8B:C31E 8D 8F 19    STA $198F  [$7E:198F]
$8B:C321 22 4D 89 80 JSL $80894D[$80:894D]
$8B:C325 E2 20       SEP #$20
$8B:C327 A5 51       LDA $51    [$7E:0051]
$8B:C329 C9 0F       CMP #$0F
$8B:C32B D0 17       BNE $17    [$C344]
$8B:C32D C2 20       REP #$20
$8B:C32F 9C 23 07    STZ $0723  [$7E:0723]
$8B:C332 9C 25 07    STZ $0725  [$7E:0725]
$8B:C335 A9 45 C3    LDA #$C345
$8B:C338 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:C33B A9 01 00    LDA #$0001
$8B:C33E 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:C341 9C 4B 1A    STZ $1A4B  [$7E:1A4B]

$8B:C344 60          RTS
}


;;; $C345:  ;;;
{
$8B:C345 AD 95 19    LDA $1995  [$7E:1995]
$8B:C348 18          CLC
$8B:C349 69 00 10    ADC #$1000
$8B:C34C 8D 95 19    STA $1995  [$7E:1995]
$8B:C34F AD 97 19    LDA $1997  [$7E:1997]
$8B:C352 69 00 00    ADC #$0000
$8B:C355 8D 97 19    STA $1997  [$7E:1997]
$8B:C358 AD 91 19    LDA $1991  [$7E:1991]
$8B:C35B 38          SEC
$8B:C35C E9 00 40    SBC #$4000
$8B:C35F 8D 91 19    STA $1991  [$7E:1991]
$8B:C362 AD 93 19    LDA $1993  [$7E:1993]
$8B:C365 E9 00 00    SBC #$0000
$8B:C368 8D 93 19    STA $1993  [$7E:1993]
$8B:C36B AD 8F 19    LDA $198F  [$7E:198F]
$8B:C36E C9 80 02    CMP #$0280
$8B:C371 10 08       BPL $08    [$C37B]
$8B:C373 18          CLC
$8B:C374 69 01 00    ADC #$0001
$8B:C377 8D 8F 19    STA $198F  [$7E:198F]
$8B:C37A 60          RTS

$8B:C37B AD 93 19    LDA $1993  [$7E:1993]
$8B:C37E 49 FF FF    EOR #$FFFF
$8B:C381 1A          INC A
$8B:C382 18          CLC
$8B:C383 65 80       ADC $80    [$7E:0080]
$8B:C385 8D E2 0C    STA $0CE2  [$7E:0CE2]
$8B:C388 AD 97 19    LDA $1997  [$7E:1997]
$8B:C38B 49 FF FF    EOR #$FFFF
$8B:C38E 1A          INC A
$8B:C38F 18          CLC
$8B:C390 65 82       ADC $82    [$7E:0082]
$8B:C392 8D E4 0C    STA $0CE4  [$7E:0CE4]
$8B:C395 DA          PHX
$8B:C396 5A          PHY
$8B:C397 08          PHP
$8B:C398 8B          PHB
$8B:C399 22 88 82 88 JSL $888288[$88:8288]
$8B:C39D 22 A4 8A 88 JSL $888AA4[$88:8AA4]  ; Spawn power bomb explosion
$8B:C3A1 AB          PLB
$8B:C3A2 28          PLP
$8B:C3A3 7A          PLY
$8B:C3A4 FA          PLX
$8B:C3A5 E2 20       SEP #$20
$8B:C3A7 A9 10       LDA #$10
$8B:C3A9 85 6F       STA $6F    [$7E:006F]
$8B:C3AB A9 37       LDA #$37
$8B:C3AD 85 72       STA $72    [$7E:0072]
$8B:C3AF C2 20       REP #$20
$8B:C3B1 A9 00 03    LDA #$0300
$8B:C3B4 8D 8F 19    STA $198F  [$7E:198F]
$8B:C3B7 A9 00 00    LDA #$0000
$8B:C3BA A0 2D CF    LDY #$CF2D             ;\
$8B:C3BD 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF2D (Ceres final explosion)
$8B:C3C0 AD 98 09    LDA $0998  [$7E:0998]  ;\
$8B:C3C3 C9 25 00    CMP #$0025             ;} If [game state] = 25h (Ceres goes boom with Samus):
$8B:C3C6 D0 09       BNE $09    [$C3D1]     ;/
$8B:C3C8 A2 FA C3    LDX #$C3FA
$8B:C3CB 22 4F 8B 80 JSL $808B4F[$80:8B4F]
$8B:C3CF 80 07       BRA $07    [$C3D8]

$8B:C3D1 A2 E6 C3    LDX #$C3E6             ;\ Else ([game state] != 25h (Ceres goes boom with Samus)):
$8B:C3D4 22 4F 8B 80 JSL $808B4F[$80:8B4F]

$8B:C3D8 A2 F0 C3    LDX #$C3F0
$8B:C3DB 22 4F 8B 80 JSL $808B4F[$80:8B4F]
$8B:C3DF A9 CA C5    LDA #$C5CA
$8B:C3E2 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:C3E5 60          RTS

; Mode 7 transfers data
;                        ______________________ Control. 80h = write to VRAM tilemap
;                       |   ___________________ Source address
;                       |  |       ____________ Size
;                       |  |      |     _______ Destination address (VRAM)
;                       |  |      |    |     __ VRAM address increment mode
;                       |  |      |    |    |
$8B:C3E6             dx 80,7F4000,0300,0000,00, 00 ; Front of gunship
$8B:C3F0             dx 80,7F4C00,0300,0300,00, 00 ; Clear Ceres lower half
$8B:C3FA             dx 80,7F4C00,0300,0000,00, 00 ; Clear Ceres upper half
}


;;; $C404: Instruction - spawn Ceres explosions 1 ;;;
{
$8B:C404 5A          PHY
$8B:C405 A9 00 00    LDA #$0000
$8B:C408 A0 BB CE    LDY #$CEBB             ;\
$8B:C40B 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEBB (Ceres explosion 1)
$8B:C40E A9 01 00    LDA #$0001
$8B:C411 A0 BB CE    LDY #$CEBB             ;\
$8B:C414 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEBB (Ceres explosion 1)
$8B:C417 A9 02 00    LDA #$0002
$8B:C41A A0 BB CE    LDY #$CEBB             ;\
$8B:C41D 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEBB (Ceres explosion 1)
$8B:C420 A9 03 00    LDA #$0003
$8B:C423 A0 BB CE    LDY #$CEBB             ;\
$8B:C426 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEBB (Ceres explosion 1)
$8B:C429 A9 04 00    LDA #$0004
$8B:C42C A0 BB CE    LDY #$CEBB             ;\
$8B:C42F 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEBB (Ceres explosion 1)
$8B:C432 7A          PLY
$8B:C433 60          RTS
}


;;; $C434:  ;;;
{
$8B:C434 AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:C437 99 7D 1B    STA $1B7D,y[$7E:1B97]
$8B:C43A 0A          ASL A
$8B:C43B AA          TAX
$8B:C43C BD 6B C4    LDA $C46B,x[$8B:C46B]
$8B:C43F 99 5D 1B    STA $1B5D,y[$7E:1B77]
$8B:C442 AD 93 19    LDA $1993  [$7E:1993]
$8B:C445 49 FF FF    EOR #$FFFF
$8B:C448 1A          INC A
$8B:C449 18          CLC
$8B:C44A 65 80       ADC $80    [$7E:0080]
$8B:C44C 18          CLC
$8B:C44D 7D 75 C4    ADC $C475,x[$8B:C475]
$8B:C450 99 7D 1A    STA $1A7D,y[$7E:1A97]
$8B:C453 AD 97 19    LDA $1997  [$7E:1997]
$8B:C456 49 FF FF    EOR #$FFFF
$8B:C459 1A          INC A
$8B:C45A 18          CLC
$8B:C45B 65 82       ADC $82    [$7E:0082]
$8B:C45D 18          CLC
$8B:C45E 7D 7F C4    ADC $C47F,x[$8B:C47F]
$8B:C461 99 9D 1A    STA $1A9D,y[$7E:1AB7]
$8B:C464 A9 00 0A    LDA #$0A00
$8B:C467 99 BD 1A    STA $1ABD,y[$7E:1AD7]
$8B:C46A 60          RTS

$8B:C46B             dw 0001, 0010, 0020, 0030, 0040
$8B:C475             dw 0010, FFF0, 0010, FFF0, 0000
$8B:C47F             dw FFF0, 0010, 0010, FFF0, 0000
}


;;; $C489: Pre-instruction ;;;
{
; Used by cinematic sprite object $CF33 (Ceres explosion spawner)
$8B:C489 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:C48C C9 CA C5    CMP #$C5CA             ;} If [$1F51] = $C5CA:
$8B:C48F D0 07       BNE $07    [$C498]     ;/
$8B:C491 A9 D9 93    LDA #$93D9
$8B:C494 9D 3D 1B    STA $1B3D,x
$8B:C497 60          RTS

$8B:C498 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:C49B F0 02       BEQ $02    [$C49F]
$8B:C49D 10 19       BPL $19    [$C4B8]

$8B:C49F AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:C4A2 A0 C1 CE    LDY #$CEC1             ;\
$8B:C4A5 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEC1 (Ceres explosion 2)
$8B:C4A8 A9 0C 00    LDA #$000C
$8B:C4AB 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:C4AE AD 4B 1A    LDA $1A4B  [$7E:1A4B]
$8B:C4B1 1A          INC A
$8B:C4B2 29 07 00    AND #$0007
$8B:C4B5 8D 4B 1A    STA $1A4B  [$7E:1A4B]

$8B:C4B8 60          RTS
}


;;; $C4B9:  ;;;
{
$8B:C4B9 AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:C4BC 99 7D 1B    STA $1B7D,y[$7E:1B97]
$8B:C4BF 0A          ASL A
$8B:C4C0 0A          ASL A
$8B:C4C1 AA          TAX
$8B:C4C2 AD 93 19    LDA $1993  [$7E:1993]
$8B:C4C5 49 FF FF    EOR #$FFFF
$8B:C4C8 1A          INC A
$8B:C4C9 18          CLC
$8B:C4CA 65 80       ADC $80    [$7E:0080]
$8B:C4CC 18          CLC
$8B:C4CD 7D EB C4    ADC $C4EB,x[$8B:C4EB]
$8B:C4D0 99 7D 1A    STA $1A7D,y[$7E:1A97]
$8B:C4D3 AD 97 19    LDA $1997  [$7E:1997]
$8B:C4D6 49 FF FF    EOR #$FFFF
$8B:C4D9 1A          INC A
$8B:C4DA 18          CLC
$8B:C4DB 65 82       ADC $82    [$7E:0082]
$8B:C4DD 18          CLC
$8B:C4DE 7D ED C4    ADC $C4ED,x[$8B:C4ED]
$8B:C4E1 99 9D 1A    STA $1A9D,y[$7E:1AB7]
$8B:C4E4 A9 00 0A    LDA #$0A00
$8B:C4E7 99 BD 1A    STA $1ABD,y[$7E:1AD7]
$8B:C4EA 60          RTS

$8B:C4EB             dw 000E,FFF8, 0008,000C, FFF0,000C, FFF8,FFF2, 0000,0000, 0010,000E, FFF4,0004, FFF8,FFF0
}


;;; $C50B: RTS ;;;
{
$8B:C50B 60          RTS
}


;;; $C50C: Instruction - spawn Ceres explosions 3 ;;;
{
$8B:C50C 5A          PHY
$8B:C50D A9 00 00    LDA #$0000
$8B:C510 A0 C7 CE    LDY #$CEC7             ;\
$8B:C513 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEC7 (Ceres explosion 3)
$8B:C516 A9 01 00    LDA #$0001
$8B:C519 A0 C7 CE    LDY #$CEC7             ;\
$8B:C51C 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEC7 (Ceres explosion 3)
$8B:C51F A9 02 00    LDA #$0002
$8B:C522 A0 C7 CE    LDY #$CEC7             ;\
$8B:C525 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEC7 (Ceres explosion 3)
$8B:C528 A9 03 00    LDA #$0003
$8B:C52B A0 C7 CE    LDY #$CEC7             ;\
$8B:C52E 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEC7 (Ceres explosion 3)
$8B:C531 7A          PLY
$8B:C532 60          RTS
}


;;; $C533:  ;;;
{
$8B:C533 AD 9D 1B    LDA $1B9D  [$7E:1B9D]
$8B:C536 99 7D 1B    STA $1B7D,y[$7E:1B8B]
$8B:C539 0A          ASL A
$8B:C53A AA          TAX
$8B:C53B BD 6A C5    LDA $C56A,x[$8B:C56A]
$8B:C53E 99 5D 1B    STA $1B5D,y[$7E:1B6B]
$8B:C541 AD 93 19    LDA $1993  [$7E:1993]
$8B:C544 49 FF FF    EOR #$FFFF
$8B:C547 1A          INC A
$8B:C548 18          CLC
$8B:C549 65 80       ADC $80    [$7E:0080]
$8B:C54B 18          CLC
$8B:C54C 7D 72 C5    ADC $C572,x[$8B:C572]
$8B:C54F 99 7D 1A    STA $1A7D,y[$7E:1A8B]
$8B:C552 AD 97 19    LDA $1997  [$7E:1997]
$8B:C555 49 FF FF    EOR #$FFFF
$8B:C558 1A          INC A
$8B:C559 18          CLC
$8B:C55A 65 82       ADC $82    [$7E:0082]
$8B:C55C 18          CLC
$8B:C55D 7D 7A C5    ADC $C57A,x[$8B:C57A]
$8B:C560 99 9D 1A    STA $1A9D,y[$7E:1AAB]
$8B:C563 A9 00 0A    LDA #$0A00
$8B:C566 99 BD 1A    STA $1ABD,y[$7E:1ACB]
$8B:C569 60          RTS

$8B:C56A             dw 0001, 0004, 0008, 0010
$8B:C572             dw 0008, 000C, FFF8, FFF4
$8B:C57A             dw FFFC, 0008, FFF6, 000C
}


;;; $C582:  ;;;
{
$8B:C582 BD FD 1A    LDA $1AFD,x[$7E:1B17]
$8B:C585 38          SEC
$8B:C586 E9 00 10    SBC #$1000
$8B:C589 9D FD 1A    STA $1AFD,x[$7E:1B17]
$8B:C58C BD 9D 1A    LDA $1A9D,x[$7E:1AB7]
$8B:C58F E9 00 00    SBC #$0000
$8B:C592 9D 9D 1A    STA $1A9D,x[$7E:1AB7]
$8B:C595 BD DD 1A    LDA $1ADD,x[$7E:1AF7]
$8B:C598 18          CLC
$8B:C599 69 00 40    ADC #$4000
$8B:C59C 9D DD 1A    STA $1ADD,x[$7E:1AF7]
$8B:C59F BD 7D 1A    LDA $1A7D,x[$7E:1A97]
$8B:C5A2 69 00 00    ADC #$0000
$8B:C5A5 9D 7D 1A    STA $1A7D,x[$7E:1A97]
$8B:C5A8 60          RTS
}


;;; $C5A9:  ;;;
{
$8B:C5A9 AD 93 19    LDA $1993  [$7E:1993]
$8B:C5AC 49 FF FF    EOR #$FFFF
$8B:C5AF 1A          INC A
$8B:C5B0 18          CLC
$8B:C5B1 65 80       ADC $80    [$7E:0080]
$8B:C5B3 99 7D 1A    STA $1A7D,y[$7E:1A99]
$8B:C5B6 AD 97 19    LDA $1997  [$7E:1997]
$8B:C5B9 49 FF FF    EOR #$FFFF
$8B:C5BC 1A          INC A
$8B:C5BD 18          CLC
$8B:C5BE 65 82       ADC $82    [$7E:0082]
$8B:C5C0 99 9D 1A    STA $1A9D,y[$7E:1AB9]
$8B:C5C3 A9 00 0A    LDA #$0A00
$8B:C5C6 99 BD 1A    STA $1ABD,y[$7E:1AD9]
$8B:C5C9 60          RTS
}


;;; $C5CA:  ;;;
{
$8B:C5CA E2 20       SEP #$20
$8B:C5CC A9 10       LDA #$10
$8B:C5CE 85 6F       STA $6F    [$7E:006F]
$8B:C5D0 A9 37       LDA #$37
$8B:C5D2 85 72       STA $72    [$7E:0072]
$8B:C5D4 C2 20       REP #$20
$8B:C5D6 AD 91 19    LDA $1991  [$7E:1991]
$8B:C5D9 18          CLC
$8B:C5DA 69 00 00    ADC #$0000
$8B:C5DD 8D 91 19    STA $1991  [$7E:1991]
$8B:C5E0 AD 93 19    LDA $1993  [$7E:1993]
$8B:C5E3 69 02 00    ADC #$0002
$8B:C5E6 8D 93 19    STA $1993  [$7E:1993]
$8B:C5E9 AD 8D 19    LDA $198D  [$7E:198D]
$8B:C5EC 3A          DEC A
$8B:C5ED 29 FF 00    AND #$00FF
$8B:C5F0 8D 8D 19    STA $198D  [$7E:198D]
$8B:C5F3 AD 8F 19    LDA $198F  [$7E:198F]
$8B:C5F6 C9 10 00    CMP #$0010
$8B:C5F9 30 08       BMI $08    [$C603]
$8B:C5FB 38          SEC
$8B:C5FC E9 10 00    SBC #$0010
$8B:C5FF 8D 8F 19    STA $198F  [$7E:198F]
$8B:C602 60          RTS

$8B:C603 A9 10 C6    LDA #$C610
$8B:C606 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:C609 A9 C0 00    LDA #$00C0
$8B:C60C 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:C60F 60          RTS
}


;;; $C610:  ;;;
{
$8B:C610 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:C613 F0 02       BEQ $02    [$C617]
$8B:C615 10 0F       BPL $0F    [$C626]

$8B:C617 A9 01 00    LDA #$0001
$8B:C61A 8D 23 07    STA $0723  [$7E:0723]
$8B:C61D 8D 25 07    STA $0725  [$7E:0725]
$8B:C620 A9 27 C6    LDA #$C627
$8B:C623 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:C626 60          RTS
}


;;; $C627:  ;;;
{
; Similar to $82:8431/DCE0
$8B:C627 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$8B:C62B E2 20       SEP #$20
$8B:C62D A5 51       LDA $51    [$7E:0051]  ;\
$8B:C62F C9 80       CMP #$80               ;} If not finished fading out: return
$8B:C631 D0 65       BNE $65    [$C698]     ;/
$8B:C633 22 4B 83 80 JSL $80834B[$80:834B]
$8B:C637 C2 20       REP #$20
$8B:C639 9C 23 07    STZ $0723  [$7E:0723]
$8B:C63C 9C 25 07    STZ $0725  [$7E:0725]
$8B:C63F AD 98 09    LDA $0998  [$7E:0998]
$8B:C642 C9 25 00    CMP #$0025
$8B:C645 F0 07       BEQ $07    [$C64E]
$8B:C647 A9 99 C6    LDA #$C699
$8B:C64A 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:C64D 60          RTS

$8B:C64E A9 00 00    LDA #$0000
$8B:C651 22 C1 8F 80 JSL $808FC1[$80:8FC1]
$8B:C655 9C D2 09    STZ $09D2  [$7E:09D2]
$8B:C658 9C 04 0A    STZ $0A04  [$7E:0A04]
$8B:C65B 9C A8 18    STZ $18A8  [$7E:18A8]
$8B:C65E 9C AA 18    STZ $18AA  [$7E:18AA]
$8B:C661 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$8B:C665 22 5F 98 80 JSL $80985F[$80:985F]
$8B:C669 9C 82 19    STZ $1982  [$7E:1982]
$8B:C66C E2 20       SEP #$20
$8B:C66E 64 6E       STZ $6E    [$7E:006E]
$8B:C670 64 71       STZ $71    [$7E:0071]
$8B:C672 A9 10       LDA #$10
$8B:C674 85 69       STA $69    [$7E:0069]
$8B:C676 64 6B       STZ $6B    [$7E:006B]
$8B:C678 64 6C       STZ $6C    [$7E:006C]
$8B:C67A 64 6D       STZ $6D    [$7E:006D]
$8B:C67C A9 09       LDA #$09
$8B:C67E 85 55       STA $55    [$7E:0055]
$8B:C680 C2 20       REP #$20
$8B:C682 9C E2 0D    STZ $0DE2  [$7E:0DE2]
$8B:C685 9C 27 07    STZ $0727  [$7E:0727]  ; Menu index = 0
$8B:C688 A2 FE 00    LDX #$00FE             ;\
                                            ;|
$8B:C68B 9E 8D 1A    STZ $1A8D,x            ;|
$8B:C68E CA          DEX                    ;} $1A8D..1B8C = 0 (?)
$8B:C68F CA          DEX                    ;|
$8B:C690 10 F9       BPL $F9    [$C68B]     ;/
$8B:C692 A9 19 00    LDA #$0019             ;\
$8B:C695 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 19h (death sequence, black out)

$8B:C698 60          RTS
}


;;; $C699:  ;;;
{
$8B:C699 20 30 82    JSR $8230  [$8B:8230]
$8B:C69C A9 1F 1C    LDA #$1C1F
$8B:C69F 3A          DEC A
$8B:C6A0 3A          DEC A
$8B:C6A1 38          SEC
$8B:C6A2 E9 8D 19    SBC #$198D
$8B:C6A5 AA          TAX

$8B:C6A6 9E 8D 19    STZ $198D,x[$7E:1C1D]
$8B:C6A9 CA          DEX
$8B:C6AA CA          DEX
$8B:C6AB 10 F9       BPL $F9    [$C6A6]
$8B:C6AD A9 00 97    LDA #$9700             ;\
$8B:C6B0 85 48       STA $48    [$7E:0048]  ;|
$8B:C6B2 A9 DB 8A    LDA #$8ADB             ;|
$8B:C6B5 85 47       STA $47    [$7E:0047]  ;} Decompress Zebes tilemap to $7F:9000
$8B:C6B7 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:C6BB             dl 7F9000              ;/
$8B:C6BE A9 00 96    LDA #$9600             ;\
$8B:C6C1 85 48       STA $48    [$7E:0048]  ;|
$8B:C6C3 A9 76 EC    LDA #$EC76             ;|
$8B:C6C6 85 47       STA $47    [$7E:0047]  ;} Decompress Zebes tiles to $7F:5000
$8B:C6C8 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:C6CC             dl 7F5000              ;/
$8B:C6CF E2 30       SEP #$30
$8B:C6D1 A9 00       LDA #$00
$8B:C6D3 8D 16 21    STA $2116  [$7E:2116]
$8B:C6D6 A9 00       LDA #$00
$8B:C6D8 8D 17 21    STA $2117  [$7E:2117]
$8B:C6DB A9 00       LDA #$00
$8B:C6DD 8D 15 21    STA $2115  [$7E:2115]
$8B:C6E0 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:C6E4             dx 01,00,18,7F4300,0300
$8B:C6EC A9 02       LDA #$02
$8B:C6EE 8D 0B 42    STA $420B  [$7E:420B]
$8B:C6F1 A9 00       LDA #$00
$8B:C6F3 8D 16 21    STA $2116  [$7E:2116]
$8B:C6F6 A9 5C       LDA #$5C
$8B:C6F8 8D 17 21    STA $2117  [$7E:2117]
$8B:C6FB A9 80       LDA #$80
$8B:C6FD 8D 15 21    STA $2115  [$7E:2115]
$8B:C700 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:C704             dx 01,01,18,7F9000,0800
$8B:C70C A9 02       LDA #$02
$8B:C70E 8D 0B 42    STA $420B  [$7E:420B]
$8B:C711 A9 00       LDA #$00
$8B:C713 8D 16 21    STA $2116  [$7E:2116]
$8B:C716 A9 60       LDA #$60
$8B:C718 8D 17 21    STA $2117  [$7E:2117]
$8B:C71B A9 80       LDA #$80
$8B:C71D 8D 15 21    STA $2115  [$7E:2115]
$8B:C720 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:C724             dx 01,01,18,7F5000,4000
$8B:C72C A9 02       LDA #$02
$8B:C72E 8D 0B 42    STA $420B  [$7E:420B]
$8B:C731 C2 30       REP #$30
$8B:C733 A9 00 01    LDA #$0100
$8B:C736 8D 1B 21    STA $211B  [$7E:211B]
$8B:C739 85 78       STA $78    [$7E:0078]
$8B:C73B 9C 1C 21    STZ $211C  [$7E:211C]
$8B:C73E 64 7A       STZ $7A    [$7E:007A]
$8B:C740 9C 1D 21    STZ $211D  [$7E:211D]
$8B:C743 64 7C       STZ $7C    [$7E:007C]
$8B:C745 8D 1E 21    STA $211E  [$7E:211E]
$8B:C748 85 7E       STA $7E    [$7E:007E]
$8B:C74A A9 38 00    LDA #$0038
$8B:C74D 8D 1F 21    STA $211F  [$7E:211F]
$8B:C750 85 80       STA $80    [$7E:0080]
$8B:C752 A9 18 00    LDA #$0018
$8B:C755 8D 20 21    STA $2120  [$7E:2120]
$8B:C758 85 82       STA $82    [$7E:0082]
$8B:C75A 9C 93 19    STZ $1993  [$7E:1993]
$8B:C75D 9C 97 19    STZ $1997  [$7E:1997]
$8B:C760 9C 8D 19    STZ $198D  [$7E:198D]
$8B:C763 A9 00 01    LDA #$0100
$8B:C766 8D 8F 19    STA $198F  [$7E:198F]
$8B:C769 22 93 82 88 JSL $888293[$88:8293]
$8B:C76D 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$8B:C771 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]
$8B:C775 22 C2 C4 8D JSL $8DC4C2[$8D:C4C2]
$8B:C779 E2 20       SEP #$20
$8B:C77B A9 81       LDA #$81
$8B:C77D 85 57       STA $57    [$7E:0057]
$8B:C77F C2 20       REP #$20
$8B:C781 A0 A8 E1    LDY #$E1A8             ;\
$8B:C784 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1A8 (cutscene gunship engine flicker)
$8B:C788 A9 9C C7    LDA #$C79C
$8B:C78B 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:C78E 22 4B 83 80 JSL $80834B[$80:834B]
$8B:C792 A9 01 00    LDA #$0001
$8B:C795 8D 23 07    STA $0723  [$7E:0723]
$8B:C798 8D 25 07    STA $0725  [$7E:0725]
$8B:C79B 60          RTS
}


;;; $C79C:  ;;;
{
$8B:C79C AD 51 1A    LDA $1A51  [$7E:1A51]
$8B:C79F 89 03 00    BIT #$0003
$8B:C7A2 D0 0B       BNE $0B    [$C7AF]
$8B:C7A4 E2 20       SEP #$20
$8B:C7A6 A5 57       LDA $57    [$7E:0057]
$8B:C7A8 38          SEC
$8B:C7A9 E9 10       SBC #$10
$8B:C7AB 85 57       STA $57    [$7E:0057]
$8B:C7AD C2 20       REP #$20

$8B:C7AF 22 4D 89 80 JSL $80894D[$80:894D]
$8B:C7B3 E2 20       SEP #$20
$8B:C7B5 A5 51       LDA $51    [$7E:0051]
$8B:C7B7 C9 0F       CMP #$0F
$8B:C7B9 D0 0E       BNE $0E    [$C7C9]
$8B:C7BB C2 20       REP #$20
$8B:C7BD 9C 23 07    STZ $0723  [$7E:0723]
$8B:C7C0 9C 25 07    STZ $0725  [$7E:0725]
$8B:C7C3 A9 CA C7    LDA #$C7CA
$8B:C7C6 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:C7C9 60          RTS
}


;;; $C7CA:  ;;;
{
$8B:C7CA AD 51 1A    LDA $1A51  [$7E:1A51]
$8B:C7CD 89 03 00    BIT #$0003
$8B:C7D0 D0 68       BNE $68    [$C83A]
$8B:C7D2 E2 20       SEP #$20
$8B:C7D4 A5 57       LDA $57    [$7E:0057]
$8B:C7D6 38          SEC
$8B:C7D7 E9 10       SBC #$10
$8B:C7D9 85 57       STA $57    [$7E:0057]
$8B:C7DB 89 F0       BIT #$F0
$8B:C7DD F0 03       BEQ $03    [$C7E2]
$8B:C7DF C2 20       REP #$20
$8B:C7E1 60          RTS

$8B:C7E2 E2 20       SEP #$20
$8B:C7E4 A9 07       LDA #$07
$8B:C7E6 85 55       STA $55    [$7E:0055]
$8B:C7E8 A9 80       LDA #$80
$8B:C7EA 85 5F       STA $5F    [$7E:005F]
$8B:C7EC A9 00       LDA #$00
$8B:C7EE 85 58       STA $58    [$7E:0058]
$8B:C7F0 64 5D       STZ $5D    [$7E:005D]
$8B:C7F2 A9 11       LDA #$11
$8B:C7F4 85 69       STA $69    [$7E:0069]
$8B:C7F6 C2 20       REP #$20
$8B:C7F8 A9 80 00    LDA #$0080
$8B:C7FB 8D 93 19    STA $1993  [$7E:1993]
$8B:C7FE A9 98 FF    LDA #$FF98
$8B:C801 8D 97 19    STA $1997  [$7E:1997]
$8B:C804 A9 20 00    LDA #$0020
$8B:C807 8D 8D 19    STA $198D  [$7E:198D]
$8B:C80A A9 00 01    LDA #$0100
$8B:C80D 8D 8F 19    STA $198F  [$7E:198F]
$8B:C810 A0 A3 CE    LDY #$CEA3             ;\
$8B:C813 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEA3 (Zebes)
$8B:C816 A0 F7 CE    LDY #$CEF7             ;\
$8B:C819 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEF7 (Zebes stars 2)
$8B:C81C A0 FD CE    LDY #$CEFD             ;\
$8B:C81F 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEFD (Zebes stars 3)
$8B:C822 A0 03 CF    LDY #$CF03             ;\
$8B:C825 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF03 (Zebes stars 4)
$8B:C828 A0 09 CF    LDY #$CF09             ;\
$8B:C82B 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CF09 (Zebes stars 5)
$8B:C82E A0 AF CE    LDY #$CEAF             ;\
$8B:C831 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEAF (planet Zebes text)
$8B:C834 A9 8F A3    LDA #$A38F
$8B:C837 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:C83A 60          RTS
}


;;; $C83B:  ;;;
{
$8B:C83B A9 88 00    LDA #$0088
$8B:C83E 99 7D 1A    STA $1A7D,y[$7E:1A9B]
$8B:C841 A9 6F 00    LDA #$006F
$8B:C844 99 9D 1A    STA $1A9D,y[$7E:1ABB]
$8B:C847 A9 00 0E    LDA #$0E00
$8B:C84A 99 BD 1A    STA $1ABD,y[$7E:1ADB]
$8B:C84D 60          RTS
}


;;; $C84E:  ;;;
{
$8B:C84E AD 51 1F    LDA $1F51  [$7E:1F51]
$8B:C851 C9 DE CA    CMP #$CADE
$8B:C854 D0 06       BNE $06    [$C85C]
$8B:C856 A9 5D C8    LDA #$C85D
$8B:C859 9D 3D 1B    STA $1B3D,x[$7E:1B5B]

$8B:C85C 60          RTS
}


;;; $C85D:  ;;;
{
$8B:C85D BD 7D 1B    LDA $1B7D,x[$7E:1B9B]
$8B:C860 18          CLC
$8B:C861 69 40 00    ADC #$0040
$8B:C864 9D 7D 1B    STA $1B7D,x[$7E:1B9B]
$8B:C867 EB          XBA
$8B:C868 48          PHA
$8B:C869 29 00 FF    AND #$FF00
$8B:C86C 85 14       STA $14    [$7E:0014]
$8B:C86E 68          PLA
$8B:C86F 29 FF 00    AND #$00FF
$8B:C872 85 12       STA $12    [$7E:0012]
$8B:C874 BD FD 1A    LDA $1AFD,x[$7E:1B1B]
$8B:C877 38          SEC
$8B:C878 E5 14       SBC $14    [$7E:0014]
$8B:C87A 9D FD 1A    STA $1AFD,x[$7E:1B1B]
$8B:C87D BD 9D 1A    LDA $1A9D,x[$7E:1ABB]
$8B:C880 E5 12       SBC $12    [$7E:0012]
$8B:C882 9D 9D 1A    STA $1A9D,x[$7E:1ABB]
$8B:C885 C9 80 FF    CMP #$FF80
$8B:C888 10 0C       BPL $0C    [$C896]
$8B:C88A A9 01 00    LDA #$0001
$8B:C88D 9D 5D 1B    STA $1B5D,x[$7E:1B7B]
$8B:C890 A9 53 CE    LDA #$CE53
$8B:C893 9D 1D 1B    STA $1B1D,x[$7E:1B3B]

$8B:C896 60          RTS
}


;;; $C897:  ;;;
{
$8B:C897 A9 80 00    LDA #$0080
$8B:C89A 99 7D 1A    STA $1A7D,y
$8B:C89D A9 7F 00    LDA #$007F
$8B:C8A0 99 9D 1A    STA $1A9D,y
$8B:C8A3 A9 00 08    LDA #$0800
$8B:C8A6 99 BD 1A    STA $1ABD,y
$8B:C8A9 60          RTS
}


;;; $C8AA:  ;;;
{
$8B:C8AA AD 51 1F    LDA $1F51  [$7E:1F51]
$8B:C8AD C9 DE CA    CMP #$CADE
$8B:C8B0 D0 06       BNE $06    [$C8B8]
$8B:C8B2 A9 B9 C8    LDA #$C8B9
$8B:C8B5 9D 3D 1B    STA $1B3D,x[$7E:1B53]

$8B:C8B8 60          RTS
}


;;; $C8B9:  ;;;
{
$8B:C8B9 BD 7D 1B    LDA $1B7D,x[$7E:1B93]
$8B:C8BC 18          CLC
$8B:C8BD 69 20 00    ADC #$0020
$8B:C8C0 9D 7D 1B    STA $1B7D,x[$7E:1B93]
$8B:C8C3 EB          XBA
$8B:C8C4 48          PHA
$8B:C8C5 29 00 FF    AND #$FF00
$8B:C8C8 85 14       STA $14    [$7E:0014]
$8B:C8CA 68          PLA
$8B:C8CB 29 FF 00    AND #$00FF
$8B:C8CE 85 12       STA $12    [$7E:0012]
$8B:C8D0 BD FD 1A    LDA $1AFD,x[$7E:1B13]
$8B:C8D3 38          SEC
$8B:C8D4 E5 14       SBC $14    [$7E:0014]
$8B:C8D6 9D FD 1A    STA $1AFD,x[$7E:1B13]
$8B:C8D9 BD 9D 1A    LDA $1A9D,x[$7E:1AB3]
$8B:C8DC E5 12       SBC $12    [$7E:0012]
$8B:C8DE 9D 9D 1A    STA $1A9D,x[$7E:1AB3]
$8B:C8E1 C9 80 FF    CMP #$FF80
$8B:C8E4 10 12       BPL $12    [$C8F8]
$8B:C8E6 A9 01 00    LDA #$0001
$8B:C8E9 9D 5D 1B    STA $1B5D,x[$7E:1B73]
$8B:C8EC A9 53 CE    LDA #$CE53
$8B:C8EF 9D 1D 1B    STA $1B1D,x[$7E:1B33]
$8B:C8F2 A9 DF CA    LDA #$CADF
$8B:C8F5 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:C8F8 60          RTS
}


;;; $C8F9:  ;;;
{
$8B:C8F9 AD 51 1F    LDA $1F51  [$7E:1F51]
$8B:C8FC C9 DE CA    CMP #$CADE
$8B:C8FF D0 06       BNE $06    [$C907]
$8B:C901 A9 08 C9    LDA #$C908
$8B:C904 9D 3D 1B    STA $1B3D,x[$7E:1B59]

$8B:C907 60          RTS
}


;;; $C908:  ;;;
{
$8B:C908 BD 7D 1B    LDA $1B7D,x[$7E:1B99]
$8B:C90B 18          CLC
$8B:C90C 69 20 00    ADC #$0020
$8B:C90F 9D 7D 1B    STA $1B7D,x[$7E:1B99]
$8B:C912 EB          XBA
$8B:C913 48          PHA
$8B:C914 29 00 FF    AND #$FF00
$8B:C917 85 14       STA $14    [$7E:0014]
$8B:C919 68          PLA
$8B:C91A 29 FF 00    AND #$00FF
$8B:C91D 85 12       STA $12    [$7E:0012]
$8B:C91F BD FD 1A    LDA $1AFD,x[$7E:1B19]
$8B:C922 38          SEC
$8B:C923 E5 14       SBC $14    [$7E:0014]
$8B:C925 9D FD 1A    STA $1AFD,x[$7E:1B19]
$8B:C928 BD 9D 1A    LDA $1A9D,x[$7E:1AB9]
$8B:C92B E5 12       SBC $12    [$7E:0012]
$8B:C92D 9D 9D 1A    STA $1A9D,x[$7E:1AB9]
$8B:C930 C9 80 FF    CMP #$FF80
$8B:C933 10 0C       BPL $0C    [$C941]
$8B:C935 A9 01 00    LDA #$0001
$8B:C938 9D 5D 1B    STA $1B5D,x[$7E:1B79]
$8B:C93B A9 53 CE    LDA #$CE53
$8B:C93E 9D 1D 1B    STA $1B1D,x[$7E:1B39]

$8B:C941 60          RTS
}


;;; $C942:  ;;;
{
$8B:C942 EA          NOP
$8B:C943 A9 30 00    LDA #$0030
$8B:C946 99 7D 1A    STA $1A7D,y[$7E:1A99]
$8B:C949 A9 2F 00    LDA #$002F
$8B:C94C 99 9D 1A    STA $1A9D,y[$7E:1AB9]
$8B:C94F A9 00 08    LDA #$0800
$8B:C952 99 BD 1A    STA $1ABD,y[$7E:1AD9]
$8B:C955 60          RTS
}


;;; $C956:  ;;;
{
$8B:C956 EA          NOP
$8B:C957 A9 D0 00    LDA #$00D0
$8B:C95A 99 7D 1A    STA $1A7D,y[$7E:1A97]
$8B:C95D A9 2F 00    LDA #$002F
$8B:C960 99 9D 1A    STA $1A9D,y[$7E:1AB7]
$8B:C963 A9 00 08    LDA #$0800
$8B:C966 99 BD 1A    STA $1ABD,y[$7E:1AD7]
$8B:C969 60          RTS
}


;;; $C96A:  ;;;
{
$8B:C96A EA          NOP
$8B:C96B A9 30 00    LDA #$0030
$8B:C96E 99 7D 1A    STA $1A7D,y[$7E:1A95]
$8B:C971 A9 CF 00    LDA #$00CF
$8B:C974 99 9D 1A    STA $1A9D,y[$7E:1AB5]
$8B:C977 A9 00 08    LDA #$0800
$8B:C97A 99 BD 1A    STA $1ABD,y[$7E:1AD5]
$8B:C97D 60          RTS
}


;;; $C97E:  ;;;
{
$8B:C97E EA          NOP
$8B:C97F A9 D0 00    LDA #$00D0
$8B:C982 99 7D 1A    STA $1A7D,y[$7E:1A93]
$8B:C985 A9 CF 00    LDA #$00CF
$8B:C988 99 9D 1A    STA $1A9D,y[$7E:1AB3]
$8B:C98B A9 00 08    LDA #$0800
$8B:C98E 99 BD 1A    STA $1ABD,y[$7E:1AD3]
$8B:C991 60          RTS
}


;;; $C992:  ;;;
{
$8B:C992 A9 80 00    LDA #$0080
$8B:C995 99 7D 1A    STA $1A7D,y[$7E:1A91]
$8B:C998 A9 BA 00    LDA #$00BA
$8B:C99B 99 9D 1A    STA $1A9D,y[$7E:1AB1]
$8B:C99E A9 00 00    LDA #$0000
$8B:C9A1 99 BD 1A    STA $1ABD,y[$7E:1AD1]
$8B:C9A4 60          RTS
}


;;; $C9A5: Instruction -  ;;;
{
$8B:C9A5 5A          PHY
$8B:C9A6 A0 B0 E1    LDY #$E1B0             ;\
$8B:C9A9 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1B0 (fade in PLANET ZEBES text)
$8B:C9AD 7A          PLY
$8B:C9AE 60          RTS
}


;;; $C9AF: Instruction -  ;;;
{
$8B:C9AF AD E2 09    LDA $09E2  [$7E:09E2]
$8B:C9B2 F0 08       BEQ $08    [$C9BC]
$8B:C9B4 5A          PHY
$8B:C9B5 A0 B5 CE    LDY #$CEB5             ;\
$8B:C9B8 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $CEB5 (planet Zebes Japanese text)
$8B:C9BB 7A          PLY

$8B:C9BC 60          RTS
}


;;; $C9BD: Instruction -  ;;;
{
$8B:C9BD 5A          PHY
$8B:C9BE A0 B4 E1    LDY #$E1B4             ;\
$8B:C9C1 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1B4 (fade out PLANET ZEBES text)
$8B:C9C5 7A          PLY
$8B:C9C6 60          RTS
}


;;; $C9C7: Instruction -  ;;;
{
$8B:C9C7 A9 3E 00    LDA #$003E
$8B:C9CA 8D 93 19    STA $1993  [$7E:1993]
$8B:C9CD A9 90 FF    LDA #$FF90
$8B:C9D0 8D 97 19    STA $1997  [$7E:1997]
$8B:C9D3 A9 20 00    LDA #$0020
$8B:C9D6 8D 8D 19    STA $198D  [$7E:198D]
$8B:C9D9 A9 10 00    LDA #$0010
$8B:C9DC 8D 8F 19    STA $198F  [$7E:198F]
$8B:C9DF A9 F9 C9    LDA #$C9F9
$8B:C9E2 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:C9E5 60          RTS
}


;;; $C9E6:  ;;;
{
$8B:C9E6 A9 80 00    LDA #$0080
$8B:C9E9 99 7D 1A    STA $1A7D,y
$8B:C9EC A9 CC 00    LDA #$00CC
$8B:C9EF 99 9D 1A    STA $1A9D,y
$8B:C9F2 A9 00 00    LDA #$0000
$8B:C9F5 99 BD 1A    STA $1ABD,y
$8B:C9F8 60          RTS
}


;;; $C9F9:  ;;;
{
$8B:C9F9 AD 95 19    LDA $1995  [$7E:1995]
$8B:C9FC 18          CLC
$8B:C9FD 69 00 20    ADC #$2000
$8B:CA00 8D 95 19    STA $1995  [$7E:1995]
$8B:CA03 AD 97 19    LDA $1997  [$7E:1997]
$8B:CA06 69 00 00    ADC #$0000
$8B:CA09 8D 97 19    STA $1997  [$7E:1997]
$8B:CA0C AD 91 19    LDA $1991  [$7E:1991]
$8B:CA0F 38          SEC
$8B:CA10 E9 00 80    SBC #$8000
$8B:CA13 8D 91 19    STA $1991  [$7E:1991]
$8B:CA16 AD 93 19    LDA $1993  [$7E:1993]
$8B:CA19 E9 00 00    SBC #$0000
$8B:CA1C 8D 93 19    STA $1993  [$7E:1993]
$8B:CA1F AD 8F 19    LDA $198F  [$7E:198F]
$8B:CA22 C9 80 04    CMP #$0480
$8B:CA25 10 08       BPL $08    [$CA2F]
$8B:CA27 18          CLC
$8B:CA28 69 04 00    ADC #$0004
$8B:CA2B 8D 8F 19    STA $198F  [$7E:198F]
$8B:CA2E 60          RTS

$8B:CA2F A9 36 CA    LDA #$CA36
$8B:CA32 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:CA35 60          RTS
}


;;; $CA36:  ;;;
{
$8B:CA36 AD 95 19    LDA $1995  [$7E:1995]
$8B:CA39 18          CLC
$8B:CA3A 69 00 20    ADC #$2000
$8B:CA3D 8D 95 19    STA $1995  [$7E:1995]
$8B:CA40 AD 97 19    LDA $1997  [$7E:1997]
$8B:CA43 69 00 00    ADC #$0000
$8B:CA46 8D 97 19    STA $1997  [$7E:1997]
$8B:CA49 AD 91 19    LDA $1991  [$7E:1991]
$8B:CA4C 38          SEC
$8B:CA4D E9 00 80    SBC #$8000
$8B:CA50 8D 91 19    STA $1991  [$7E:1991]
$8B:CA53 AD 93 19    LDA $1993  [$7E:1993]
$8B:CA56 E9 00 00    SBC #$0000
$8B:CA59 8D 93 19    STA $1993  [$7E:1993]
$8B:CA5C C9 80 FF    CMP #$FF80
$8B:CA5F 30 1D       BMI $1D    [$CA7E]
$8B:CA61 AD 8F 19    LDA $198F  [$7E:198F]
$8B:CA64 18          CLC
$8B:CA65 69 10 00    ADC #$0010
$8B:CA68 8D 8F 19    STA $198F  [$7E:198F]
$8B:CA6B AD 8D 19    LDA $198D  [$7E:198D]
$8B:CA6E C9 E0 00    CMP #$00E0
$8B:CA71 F0 0A       BEQ $0A    [$CA7D]
$8B:CA73 38          SEC
$8B:CA74 E9 01 00    SBC #$0001
$8B:CA77 29 FF 00    AND #$00FF
$8B:CA7A 8D 8D 19    STA $198D  [$7E:198D]

$8B:CA7D 60          RTS

$8B:CA7E A9 85 CA    LDA #$CA85
$8B:CA81 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:CA84 60          RTS
}


;;; $CA85:  ;;;
{
$8B:CA85 AD 95 19    LDA $1995  [$7E:1995]
$8B:CA88 18          CLC
$8B:CA89 69 00 20    ADC #$2000
$8B:CA8C 8D 95 19    STA $1995  [$7E:1995]
$8B:CA8F AD 97 19    LDA $1997  [$7E:1997]
$8B:CA92 69 00 00    ADC #$0000
$8B:CA95 8D 97 19    STA $1997  [$7E:1997]
$8B:CA98 AD 91 19    LDA $1991  [$7E:1991]
$8B:CA9B 18          CLC
$8B:CA9C 69 00 20    ADC #$2000
$8B:CA9F 8D 91 19    STA $1991  [$7E:1991]
$8B:CAA2 AD 93 19    LDA $1993  [$7E:1993]
$8B:CAA5 69 00 00    ADC #$0000
$8B:CAA8 8D 93 19    STA $1993  [$7E:1993]
$8B:CAAB AD 8F 19    LDA $198F  [$7E:198F]
$8B:CAAE C9 00 20    CMP #$2000
$8B:CAB1 10 08       BPL $08    [$CABB]
$8B:CAB3 18          CLC
$8B:CAB4 69 20 00    ADC #$0020
$8B:CAB7 8D 8F 19    STA $198F  [$7E:198F]
$8B:CABA 60          RTS

$8B:CABB E2 20       SEP #$20
$8B:CABD A9 10       LDA #$10
$8B:CABF 85 69       STA $69    [$7E:0069]
$8B:CAC1 C2 20       REP #$20
$8B:CAC3 A9 D0 CA    LDA #$CAD0
$8B:CAC6 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:CAC9 A9 40 00    LDA #$0040
$8B:CACC 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:CACF 60          RTS
}


;;; $CAD0:  ;;;
{
$8B:CAD0 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:CAD3 F0 02       BEQ $02    [$CAD7]
$8B:CAD5 10 06       BPL $06    [$CADD]

$8B:CAD7 A9 DE CA    LDA #$CADE
$8B:CADA 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:CADD 60          RTS
}


;;; $CADE: RTS ;;;
{
$8B:CADE 60          RTS
}


;;; $CADF: Cinematic function - load game data ;;;
{
$8B:CADF E2 20       SEP #$20               ;\
$8B:CAE1 A9 80       LDA #$80               ;|
$8B:CAE3 85 51       STA $51    [$7E:0051]  ;} Set forced blank
$8B:CAE5 C2 20       REP #$20               ;/
$8B:CAE7 A9 1F 1C    LDA #$1C1F             ;\
$8B:CAEA 3A          DEC A                  ;|
$8B:CAEB 3A          DEC A                  ;|
$8B:CAEC 38          SEC                    ;|
$8B:CAED E9 8D 19    SBC #$198D             ;|
$8B:CAF0 AA          TAX                    ;} Clear $198D..1C1E (non-gameplay RAM)
                                            ;|
$8B:CAF1 9E 8D 19    STZ $198D,x[$7E:1C1D]  ;|
$8B:CAF4 CA          DEX                    ;|
$8B:CAF5 CA          DEX                    ;|
$8B:CAF6 10 F9       BPL $F9    [$CAF1]     ;/
$8B:CAF8 A9 06 00    LDA #$0006             ;\
$8B:CAFB 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 6 (loading game data)
$8B:CAFE AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$8B:CB01 8D C2 09    STA $09C2  [$7E:09C2]  ;} Samus health = [Samus max health] (?!)
$8B:CB04 60          RTS
}


;;; $CB05..CE54: Cinematic sprite object instruction lists ;;;
{
;;; $CB05: Instruction list - cinematic sprite object $CE55 (intro Mother Brain) ;;;
{
$8B:CB05             dx 0010,8C00,
                        0010,8C2F,
                        0010,8C5E,
                        0010,8C2F,
                        94BC,CB05   ; Go to $CB05
}


;;; $CB19: Instruction list - intro Mother Brain - start page 2 ;;;
{
$8B:CB19             dx B336,       ; Start intro page 2
                        944C,B82E   ; Pre-instruction = $B82E
$8B:CB1F             dx 0010,8C00,
                        0010,8C2F,
                        0010,8C5E,
                        0010,8C2F,
                        94BC,CB1F   ; Go to $CB1F
}


;;; $CB33: Instruction list - cinematic sprite object $CE5B (metroid egg) ;;;
{
$8B:CB33             dx 0005,8D6F,
                        94BC,CB33   ; Go to $CB33
}


;;; $CB3B: Instruction list - metroid egg hatching ;;;
{
$8B:CB3B             dx 0020,8D6F,
                        94D6,0004   ; Timer = 4
$8B:CB43             dx 0005,8D6F,
                        0005,8D8F,
                        0005,8D6F,
                        0005,8DBE,
                        94C3,CB43,  ; Decrement timer and go to $CB43 if non-zero
                        000A,8D6F,
                        000A,8DED,
                        000A,8E1C,
                        000A,8E4B,
                        000A,8E7A,
                        000A,8EA9,
                        0050,8ED8,
                        A918,       ; Spawn metroid egg particles
                        000A,8F07,
                        000A,8F18,
                        000A,8F29,
                        000A,8F3A,
                        000A,8F4B,
                        000A,8F5C,
                        0140,8F6D,
                        B33E,       ; Start intro page 3
                        944C,A903   ; Pre-instruction = $A903
$8B:CB97             dx 0050,8F6D,
                        94BC,CB97   ; Go to $CB97
}


;;; $CB9F: Instruction list - cinematic sprite object $CE61 (baby metroid being delivered) ;;;
{
$8B:CB9F             dx 94D6,000A   ; Timer = Ah
$8B:CBA3             dx 000A,8CF3,
                        000A,8D13,
                        000A,8D33,
                        000A,8D13,
                        94C3,CBA3,  ; Decrement timer and go to $CBA3 if non-zero
                        B346        ; Start intro page 4
$8B:CBB9             dx 000A,8CF3,
                        000A,8D13,
                        000A,8D33,
                        000A,8D13,
                        94BC,CBB9   ; Go to $CBB9
}


;;; $CBCD: Instruction list - cinematic sprite object $CE67 (baby metroid being examined) ;;;
{
$8B:CBCD             dx 94D6,000A   ; Timer = Ah
$8B:CBD1             dx 000A,8D53,
                        000A,8D5A,
                        000A,8D61,
                        000A,8D5A,
                        94C3,CBD1,  ; Decrement timer and go to $CBD1 if non-zero
                        B34E        ; Start intro page 5
$8B:CBE7             dx 000A,8D53,
                        000A,8D5A,
                        000A,8D61,
                        000A,8D5A,
                        94BC,CBE7   ; Go to $CBE7
}


;;; $CBFB: Instruction list - cinematic sprite object $CE6D (intro text caret) ;;;
{
$8B:CBFB             dx 0005,8D68,
                        94BC,CBFB   ; Go to $CBFB
}


;;; $CC03: Instruction list - intro text caret - blink ;;;
{
$8B:CC03             dx 0005,8D68,
                        0005,0000,
                        94BC,CC03   ; Go to $CC03
}


;;; $CC0F: Instruction list - cinematic sprite object $CE73 (intro Japanese text next-page arrow) ;;;
{
$8B:CC0F             dx 000A,8CCF,
                        000A,8CDB,
                        000A,8CE7,
                        000A,8CDB,
                        94BC,CC0F   ; Go to $CC0F
}


;;; $CC23: Instruction list - intro Japanese text next-page arrow - blink ;;;
{
$8B:CC23             dx 003C,0000,
                        94BC,CC0F   ; Go to $CC0F
}


;;; $CC2B: Instruction list - cinematic sprite object $CE79 (confused baby metroid) ;;;
{
$8B:CC2B             dx 000A,8FCB,
                        000A,8FD2,
                        000A,8FD9,
                        000A,8FD2,
                        94BC,CC2B   ; Go to $CC2B
}


;;; $CC3F: Instruction list - cinematic sprite object $CE7F (Ceres under attack large asteroids) ;;;
{
$8B:CC3F             dx 000A,909D,
                        94BC,CC3F   ; Go to $CC3F
}


;;; $CC47: Instruction list - cinematic sprite object $CE85 (Ceres under attack) ;;;
{
$8B:CC47             dx 000A,9150,
                        94BC,CC47   ; Go to $CC47
}


;;; $CC4F: Instruction list - cinematic sprite object $CE8B (Ceres small asteroids) ;;;
{
$8B:CC4F             dx 000A,90FE,
                        94BC,CC4F   ; Go to $CC4F
}


;;; $CC57: Instruction list - cinematic sprite object $CE91 (Ceres purple space vortex) ;;;
{
$8B:CC57             dx 0001,8FE7,
                        0001,93D1,
                        94BC,CC57   ; Go to $CC57
}


;;; $CC63: Unused. Instruction list - cinematic sprite object $CE97 (space colony text) ;;;
{
$8B:CC63             dx 0100,0000,
                        000A,92AA,
                        000A,92B1,
                        000A,92BD,
                        000A,92CE,
                        000A,92E4,
                        000A,92FF,
                        000A,931F,
                        000A,9344,
                        000A,936E,
                        000A,939D,
                        000A,921F,
                        C096,       ; Skip next instruction if English text
                        0080,921F,
                        C0A2        ; Finish intro
$8B:CC9B             dx 0001,921F,
                        94BC,CC9B   ; Go to $CC9B
}


;;; $CCA3: Unused. Instruction list - cinematic sprite object $CE9D (space colony Japanese text) ;;;
{
$8B:CCA3             dx 000A,9258,
                        94BC,CCA3   ; Go to $CCA3
}


;;; $CCAB: Instruction list - cinematic sprite object $CEA3 (Zebes) ;;;
{
$8B:CCAB             dx 000A,9558,
                        94BC,CCAB   ; Go to $CCAB
}


;;; $CCB3: Instruction list - cinematic sprite object $CEA9 (Zebes stars 1) ;;;
{
$8B:CCB3             dx 000A,96CB,
                        94BC,CCB3   ; Go to $CCB3
}


;;; $CCBB: Instruction list - cinematic sprite object $CEAF (planet Zebes text) ;;;
{
$8B:CCBB             dx 0040,0000,
                        C9A5,       ;
                        0020,9654,
                        C9AF,       ;
                        00C0,9654,
                        C9BD,       ;
                        0060,9654,
                        C9C7,       ;
                        9438        ; Delete
}


;;; $CCD5: Instruction list - cinematic sprite object $CEB5 (planet Zebes Japanese text) ;;;
{
$8B:CCD5             dx 00C0,968D,
                        9438        ; Delete
}


;;; $CCDB: Instruction list - cinematic sprite object $CEBB (Ceres explosion 1) ;;;
{
$8B:CCDB             dx 0003,97F7,
                        0003,97FE,
                        0003,9805,
                        0003,981B,
                        0003,9831,
                        0003,9847,
                        9438        ; Delete
}


;;; $CCF5: Instruction list - cinematic sprite object $CEC1 (Ceres explosion 2) ;;;
{
$8B:CCF5             dx 94D6,0006   ; Timer = 6
$8B:CCF9             dx 0003,97F7,
                        0003,97FE,
                        0003,9805,
                        0003,981B,
                        0003,9831,
                        0003,9847,
                        0010,0000,
                        94C3,CCF9,  ; Decrement timer and go to $CCF9 if non-zero
                        9438        ; Delete
}


;;; $CD1B: Instruction list - cinematic sprite object $CEC7 (Ceres explosion 3) ;;;
{
$8B:CD1B             dx 94D6,0007   ; Timer = 7
$8B:CD1F             dx 0005,98D2,
                        0005,98D9,
                        0005,98E0,
                        0005,98E7,
                        0008,0000,
                        94C3,CD1F,  ; Decrement timer and go to $CD1F if non-zero
                        9438        ; Delete
}


;;; $CD39: Instruction list - cinematic sprite object $CECD (metroid egg particle 1) ;;;
{
$8B:CD39             dx 0001,8F7E,
                        94BC,CD39   ; Go to $CD39
}


;;; $CD41: Instruction list - cinematic sprite object $CED3 (metroid egg particle 2) ;;;
{
$8B:CD41             dx 0001,8F85,
                        94BC,CD41   ; Go to $CD41
}


;;; $CD49: Instruction list - cinematic sprite object $CED9 (metroid egg particle 3) ;;;
{
$8B:CD49             dx 0001,8F8C,
                        94BC,CD49   ; Go to $CD49
}


;;; $CD51: Instruction list - cinematic sprite object $CEDF (metroid egg particle 4) ;;;
{
$8B:CD51             dx 0001,8F93,
                        94BC,CD51   ; Go to $CD51
}


;;; $CD59: Instruction list - cinematic sprite object $CEE5 (metroid egg particle 5) ;;;
{
$8B:CD59             dx 0001,8F9A,
                        94BC,CD59   ; Go to $CD59
}


;;; $CD61: Instruction list - cinematic sprite object $CEEB (metroid egg particle 6) ;;;
{
$8B:CD61             dx 0001,8FA1,
                        94BC,CD61   ; Go to $CD61
}


;;; $CD69: Instruction list - cinematic sprite object $CEF1 (metroid egg slime drops) ;;;
{
$8B:CD69             dx 0001,8FA8,
                        94BC,CD69   ; Go to $CD69
}


;;; $CD71: Instruction list - metroid egg slime drops ;;;
{
$8B:CD71             dx 000A,8FAF,
                        000A,8FB6,
                        000A,8FBD,
                        000A,8FC4,
                        9438        ; Delete
}


;;; $CD83: Instruction list - cinematic sprite object $CEF7 (Zebes stars 2) ;;;
{
$8B:CD83             dx 000A,975E,
                        94BC,CD83   ; Go to $CD83
}


;;; $CD8B: Instruction list - cinematic sprite object $CEFD (Zebes stars 3) ;;;
{
$8B:CD8B             dx 000A,979C,
                        94BC,CD8B   ; Go to $CD8B
}


;;; $CD93: Instruction list - cinematic sprite object $CF03 (Zebes stars 4) ;;;
{
$8B:CD93             dx 000A,97BC,
                        94BC,CD93   ; Go to $CD93
}


;;; $CD9B: Instruction list - cinematic sprite object $CF09 (Zebes stars 5) ;;;
{
$8B:CD9B             dx 000A,97D2,
                        94BC,CD9B   ; Go to $CD9B
}


;;; $CDA3: Instruction list - cinematic sprite object $CF0F (Ceres stars) ;;;
{
$8B:CDA3             dx 000A,9478,
                        94BC,CDA3   ; Go to $CDA3
}


;;; $CDAB: Instruction list - cinematic sprite object $CF15 (intro Mother Brain explosion - big) ;;;
{
$8B:CDAB             dx 0006,985D,
                        0006,9864,
                        0006,987A,
                        0006,9890,
                        0006,98A6,
                        0006,98BC,
                        0010,0000,
                        94BC,CDAB   ; Go to $CDAB
}


;;; $CDCB: Instruction list - cinematic sprite object $CF1B (intro Mother Brain explosion - small) ;;;
{
$8B:CDCB             dx 0003,97F7,
                        0003,97FE,
                        0003,9805,
                        0003,981B,
                        0003,9831,
                        0003,9847,
                        0010,0000,
                        94BC,CDCB   ; Go to $CDCB
}


;;; $CDEB: Instruction list - cinematic sprite object $CF21 (intro rinka) ;;;
{
$8B:CDEB             dx 000A,8C8D,
                        000A,8CA3,
                        000A,8CB9
$8B:CDF7             dx B8C5,       ;
                        000A,8CA3,
                        000A,8C8D,
                        000A,8CA3,
                        000A,8CB9,
                        94BC,CDF9   ; Go to $CDF9
}


;;; $CE0D: Instruction list - cinematic sprite object $CF27 (rinka spawner) ;;;
{
$8B:CE0D             dx 004A,0000,
                        BA21,       ; Spawn intro rinkas 0/1
                        0080,0000,
                        BA36,       ; Spawn intro rinkas 2/3
                        9438        ; Delete
}


;;; $CE1B: Instruction list - cinematic sprite object $CF2D (Ceres final explosion) ;;;
{
$8B:CE1B             dx 0005,98EE,
                        0005,9904,
                        0005,991A,
                        0005,9930,
                        0005,996E,
                        0005,9998,
                        9438        ; Delete
}


;;; $CE35: Instruction list - cinematic sprite object $CF33 (Ceres explosion spawner) ;;;
{
$8B:CE35             dx 0080,0000,
                        C404,       ; Spawn Ceres explosions 1
                        0050,0000,
                        944C,C489,  ; Pre-instruction = $C489
                        0040,0000,
                        C50C,       ; Spawn Ceres explosions 3
                        9438        ; Delete
}


;;; $CE4B: Instruction list - cinematic sprite object $CF39 (Ceres explosion large asteroids) ;;;
{
$8B:CE4B             dx 000A,94F7,
                        94BC,CE4B   ; Go to $CE4B
}


;;; $CE53: Instruction list - nothing ;;;
{
$8B:CE53             dx 9438        ; Delete
}
}


;;; $CE55: Cinematic sprite object definitions - intro, Ceres, Zebes ;;;
{
;                        _____________ Initialisation function
;                       |     ________ Pre-instruction
;                       |    |     ___ Instruction list
;                       |    |    |
$8B:CE55             dw B773,B786,CB05 ; Intro Mother Brain
$8B:CE5B             dw A8D5,A8E8,CB33 ; Metroid egg
$8B:CE61             dw AD55,AD68,CB9F ; Baby metroid being delivered
$8B:CE67             dw AD93,ADA6,CBCD ; Baby metroid being examined
$8B:CE6D             dw A8C1,A8D4,CBFB ; Intro text caret
$8B:CE73             dw AE07,AE1A,CC0F ; Intro Japanese text next-page arrow
$8B:CE79             dw BA4B,BA5E,CC2B ; Confused baby metroid
$8B:CE7F             dw BF22,BF35,CC3F ; Ceres under attack large asteroids
$8B:CE85             dw BF4C,BF5F,CC47 ; Ceres under attack
$8B:CE8B             dw BF76,BF89,CC4F ; Ceres small asteroids
$8B:CE91             dw BFA0,BFC6,CC57 ; Ceres purple space vortex
$8B:CE97             dw C083,93D9,CC63 ; Unused. Space colony text
$8B:CE9D             dw C0B2,93D9,CCA3 ; Unused. Space colony Japanese text
$8B:CEA3             dw C83B,C84E,CCAB ; Zebes
$8B:CEA9             dw C897,C8AA,CCB3 ; Unused. Zebes stars 1
$8B:CEAF             dw C992,93D9,CCBB ; Planet Zebes text
$8B:CEB5             dw C9E6,93D9,CCD5 ; Planet Zebes Japanese text
$8B:CEBB             dw C434,C582,CCDB ; Ceres explosion 1
$8B:CEC1             dw C4B9,C582,CCF5 ; Ceres explosion 2
$8B:CEC7             dw C533,C582,CD1B ; Ceres explosion 3
$8B:CECD             dw A958,A994,CD39 ; Metroid egg particle 1
$8B:CED3             dw A958,A994,CD41 ; Metroid egg particle 2
$8B:CED9             dw A958,A994,CD49 ; Metroid egg particle 3
$8B:CEDF             dw A958,A994,CD51 ; Metroid egg particle 4
$8B:CEE5             dw A958,A994,CD59 ; Metroid egg particle 5
$8B:CEEB             dw A958,A994,CD61 ; Metroid egg particle 6
$8B:CEF1             dw AA9A,AAB3,CD69 ; Metroid egg slime drops
$8B:CEF7             dw C942,C8F9,CD83 ; Zebes stars 2
$8B:CEFD             dw C956,C8F9,CD8B ; Zebes stars 3
$8B:CF03             dw C96A,C8F9,CD93 ; Zebes stars 4
$8B:CF09             dw C97E,C8AA,CD9B ; Zebes stars 5
$8B:CF0F             dw BE7E,BEB5,CDA3 ; Ceres stars
$8B:CF15             dw B98D,BA0F,CDAB ; Intro Mother Brain explosion - big
$8B:CF1B             dw B9D4,BA0F,CDCB ; Intro Mother Brain explosion - small
$8B:CF21             dw B896,93D9,CDEB ; Intro rinka
$8B:CF27             dw 93D9,93D9,CE0D ; Rinka spawner
$8B:CF2D             dw C5A9,C582,CE1B ; Ceres final explosion
$8B:CF33             dw 93D9,93D9,CE35 ; Ceres explosion spawner
$8B:CF39             dw BF22,BF35,CE4B ; Ceres explosion large asteroids
}


;;; $CF3F: Cinematic BG object definitions - intro ;;;
{
;                        _____________ Initialisation function
;                       |     ________ Pre-instruction
;                       |    |     ___ Instruction list (bank $8C)
;                       |    |    |
$8B:CF3F             dw 93D9,93D9,C383 ; Intro text - page 1
$8B:CF45             dw 93D9,93D9,C797 ; Intro text - page 2
$8B:CF4B             dw 93D9,93D9,CB45 ; Intro text - page 3
$8B:CF51             dw 93D9,93D9,CE33 ; Intro text - page 4
$8B:CF57             dw 93D9,93D9,D15D ; Intro text - page 5
$8B:CF5D             dw 93D9,93D9,D511 ; Intro text - page 6
$8B:CF63             dw 93D9,B4BC,D5DF ; Samus blinking
$8B:CF69             dw 93D9,93D9,D629 ; Space colony
$8B:CF6F             dw 93D9,93D9,C383 ; Unused clone of $CF3F
}


;;; $CF75..D400: Japanese intro text data ;;;
{
; Format:
;     dddd,nnnn
;     tttt,bbbb
;     tttt,bbbb
;     ...
; where
;     d: Japanese text tiles destination offset ($7E:4000 + d)
;     n: Number of characters
;     t: Top Japanese text tiles source offset ($7F:A000 + t)
;     b: Bottom Japanese text tiles source offset ($7F:A000 + b)

;;; $CF75: Page 1 - top line ;;;
{
; 私が メトロイドの存在を知ったのは (I learnt of the metroids' existence)
$8B:CF75             dw 0040,0011,
                        0A60,0B60,
                        04E0,0150,
                        0EF0,0EF0,
                        0E00,0F00,
                        0E10,0F10,
                        0E20,0F20,
                        0E30,0F30,
                        0F70,0F10,
                        0280,0380,
                        0C70,0D70,
                        0C80,0D80,
                        04C0,05C0,
                        08E0,09E0,
                        0EF0,0760,
                        00F0,01F0,
                        0280,0380,
                        0290,0390
}


;;; $CFBD: Page 1 - bottom line ;;;
{
; 惑星ゼーベスでの戦いの時だった (it was during the battle on planet Zebes)
$8B:CFBD             dw 01C0,000F,
                        0680,0780,
                        0690,0790,
                        0E80,0F80,
                        0650,0750,
                        0E40,0F40,
                        0E60,0F60,
                        04F0,0320,
                        0280,0380,
                        08F0,09F0,
                        0010,0110,
                        0280,0380,
                        0C90,0D90,
                        05E0,01F0,
                        0EF0,0760,
                        00F0,01F0
}


;;; $CFFD: Page 2 - subpage 1 - top line ;;;
{
; その後 私は惑星ＳＲ３８８へ メトロイドを (after that, I, to planet SR388, with the metroid)
$8B:CFFD             dw 0020,0015,
                        00E0,01E0,
                        0280,0380,
                        0A20,0B20,
                        0EF0,0EF0,
                        0A60,0B60,
                        0290,0390,
                        0680,0780,
                        0690,0790,
                        0660,07E0,
                        0670,0770,
                        06E0,07E0,
                        06F0,07F0,
                        06F0,07F0,
                        02C0,03C0,
                        0EF0,0EF0,
                        0E00,0F00,
                        0E10,0F10,
                        0E20,0F20,
                        0E30,0F30,
                        0F70,0F10,
                        04C0,05C0
}


;;; $D055: Page 2 - subpage 1 - bottom line ;;;
{
; 壊滅させるために向った (headed there to destroy it)
$8B:D055             dw 01A0,000B,
                        0A30,0B30,
                        0A40,0B40,
                        00A0,01A0,
                        00D0,01D0,
                        0480,0580,
                        00F0,01F0,
                        0410,0510,
                        0250,0350,
                        0A50,0B50,
                        0EF0,0760,
                        00F0,01F0
}


;;; $D085: Page 2 - subpage 2 - top line ;;;
{
; そこで 唯一の生き残りであるベビーメトロイド (there, the only baby metroid left alive)
$8B:D085             dw 0010,0016,
                        00E0,01E0,
                        0090,0190,
                        04F0,0320,
                        0EF0,0EF0,
                        0A70,0B70,
                        0A80,0B80,
                        0280,0380,
                        0A90,0B90,
                        0060,0160,
                        0AA0,0BA0,
                        0470,0570,
                        04F0,0320,
                        0000,0100,
                        0480,0580,
                        0E40,0F40,
                        0E50,0F50,
                        0650,0750,
                        0E00,0F00,
                        0E10,0F10,
                        0E20,0F20,
                        0E30,0F30,
                        0F70,0F10
}


;;; $D0E1: Page 2 - subpage 2 - bottom line ;;;
{
; を捕獲した (I captured)
$8B:D0E1             dw 0190,0005,
                        04C0,05C0,
                        06A0,07A0,
                        06B0,07B0,
                        00B0,01B0,
                        00F0,01F0
}


;;; $D0F9: Page 3 - subpage 1 ;;;
{
; 正確にはベビーメトロイドがついて来たと言うべきだ (rather, I should say the metroid followed me)
$8B:D0F9             dw 0000,0018,
                        06C0,07C0,
                        06D0,07D0,
                        0250,0350,
                        0290,0390,
                        0E40,0F40,
                        0E50,0F50,
                        0650,0750,
                        0E00,0F00,
                        0E10,0F10,
                        0E20,0F20,
                        0E30,0F30,
                        0F70,0F10,
                        04E0,0150,
                        0210,0310,
                        0010,0110,
                        0220,0320,
                        0A00,0B00,
                        00F0,01F0,
                        0230,0330,
                        0A10,0B10,
                        0020,0120,
                        0E40,0F40,
                        0060,0160,
                        05E0,01F0
}


;;; $D15D: Page 3 - subpage 2 ;;;
{
; 生まれてすぐ目に入った私を母親だと思った様だ (when it was born, it seemed to think that I, whom it immediately noticed, was its mother)
$8B:D15D             dw 0010,0016,
                        0A90,0B90,
                        02E0,03E0,
                        0490,0590,
                        0220,0320,
                        00C0,01C0,
                        05F0,0170,
                        0AD0,0BD0,
                        0250,0350,
                        0CB0,0DB0,
                        0EF0,0760,
                        00F0,01F0,
                        0A60,0B60,
                        04C0,05C0,
                        08A0,09A0,
                        08B0,09B0,
                        05E0,01F0,
                        0230,0330,
                        08C0,09C0,
                        0EF0,0760,
                        00F0,01F0,
                        0C50,0D50,
                        05E0,01F0
}


;;; $D1B9: Page 4 - subpage 1 - top line ;;;
{
; そのベビーメトロイドを私はスペースコロニーの (I went to a space colony with this baby metroid)
$8B:D1B9             dw 0010,0016,
                        00E0,01E0,
                        0280,0380,
                        0E40,0F40,
                        0E50,0F50,
                        0650,0750,
                        0E00,0F00,
                        0E10,0F10,
                        0E20,0F20,
                        0E30,0F30,
                        0F70,0F10,
                        04C0,05C0,
                        0A60,0B60,
                        0290,0390,
                        0E60,0F60,
                        0E70,0F40,
                        0650,0750,
                        0E60,0F60,
                        0E90,0F90,
                        0E20,0F20,
                        0EA0,0FA0,
                        0650,0750,
                        0280,0380
}


;;; $D215: Page 4 - subpage 1 - bottom line ;;;
{
; 宇宙科学アカデミーへと持ち込んだ (the Space Science Academy)
$8B:D215             dw 0190,0010,
                        0CE0,0DE0,
                        0CF0,0DF0,
                        0C20,0D20,
                        0C30,0D30,
                        0610,0710,
                        0620,0720,
                        0630,0730,
                        0640,0740,
                        0650,0750,
                        02C0,03C0,
                        0230,0330,
                        0C60,0D60,
                        0200,0300,
                        08D0,09D0,
                        04D0,05D0,
                        05E0,01F0
}


;;; $D259: Page 4 - subpage 2 - top line ;;;
{
; メトロイドの優れた特性を宇宙の未来に (with the metroid's amazing special powers, for the future of space)
$8B:D259             dw 0030,0012,
                        0E00,0F00,
                        0E10,0F10,
                        0E20,0F20,
                        0E30,0F30,
                        0F70,0F10,
                        0280,0380,
                        0AB0,0BB0,
                        0490,0590,
                        00F0,01F0,
                        0CC0,0DC0,
                        0CD0,0DD0,
                        04C0,05C0,
                        0CE0,0DE0,
                        0CF0,0DF0,
                        0280,0380,
                        0CA0,0DA0,
                        0A00,0B00,
                        0250,0350
}


;;; $D2A5: Page 4 - subpage 2 - bottom line ;;;
{
; 役立たせるために・・・ (in order to harness it...)
$8B:D2A5             dw 01B0,000B,
                        0800,0900,
                        0810,0910,
                        00F0,01F0,
                        00D0,01D0,
                        0480,0580,
                        00F0,01F0,
                        0410,0510,
                        0250,0350,
                        0EF0,0600,
                        0EF0,0600,
                        0EF0,0600
}


;;; $D2D5: Page 5 - subpage 1 ;;;
{
; 研究は順調に進みつつあった (research was continuing smoothly)
$8B:D2D5             dw 0050,000D,
                        0860,0960,
                        0870,0970,
                        0290,0390,
                        0840,0940,
                        0850,0950,
                        0250,0350,
                        0C40,0D40,
                        02F0,03F0,
                        0210,0310,
                        0210,0310,
                        0000,0100,
                        0EF0,0760,
                        00F0,01F0
}


;;; $D30D: Page 5 - subpage 2 ;;;
{
; そんなある日スペースコロニーから突然連絡が入った (one day I got a sudden transmission from the space colony)
$8B:D30D             dw 0000,0018,
                        00E0,01E0,
                        04D0,05D0,
                        0240,0340,
                        0000,0100,
                        0480,0580,
                        0AC0,0BC0,
                        0E60,0F60,
                        0E70,0F40,
                        0650,0750,
                        0E60,0F60,
                        0E90,0F90,
                        0E20,0F20,
                        0EA0,0FA0,
                        0650,0750,
                        0050,0150,
                        0460,0560,
                        0880,0980,
                        0890,0990,
                        0820,0920,
                        0830,0930,
                        04E0,0150,
                        0CB0,0DB0,
                        0EF0,0760,
                        00F0,01F0
}


;;; $D371: Page 6 ;;;
{
; 非常事態だ (it's an emergency)
$8B:D371             dw 0090,0005,
                        0AE0,0BE0,
                        0AF0,0BF0,
                        0C00,0D00,
                        0C10,0D10,
                        05E0,01F0
}
}


;;; $D389..D400: Mode 7 object instruction lists - Japanese intro text ;;;
{
;;; $D389: Instruction list - mode 7 object $D401 (yyyy) ;;;
{
$8B:D389             dx B51E,       ; ???
                        0001,D3FF,
                        B54F,       ; ???
                        956B        ; Delete
}


;;; $D393: Instruction list - mode 7 object $D407 (yyyy) ;;;
{
$8B:D393             dx B554,       ; ???
                        0001,D3FF,
                        B54F,       ; ???
                        956B        ; Delete
}


;;; $D39D: Instruction list - mode 7 object $D40D (yyyy) ;;;
{
$8B:D39D             dx 0001,D3FF,
                        9586,D39D,  ; Go to $D39D
                        B5B8,       ; ???
                        956B        ; Delete
}


;;; $D3A9: Instruction list - mode 7 object $D413 (yyyy) ;;;
{
$8B:D3A9             dx B5C3,       ; ???
                        0001,D3FF,
                        B54F,       ; ???
                        956B        ; Delete
}


;;; $D3B3: Instruction list - mode 7 object $D419 (yyyy) ;;;
{
$8B:D3B3             dx 0001,D3FF,
                        9586,D3B3,  ; Go to $D3B3
                        B61B,       ; ???
                        956B        ; Delete
}


;;; $D3BF: Instruction list - mode 7 object $D41F (yyyy) ;;;
{
$8B:D3BF             dx B626,       ; ???
                        0001,D3FF,
                        B54F,       ; ???
                        956B        ; Delete
}


;;; $D3C9: Instruction list - mode 7 object $D425 (yyyy) ;;;
{
$8B:D3C9             dx 0001,D3FF,
                        9586,D3C9,  ; Go to $D3C9
                        B68A,       ; ???
                        956B        ; Delete
}


;;; $D3D5: Instruction list - mode 7 object $D42B (yyyy) ;;;
{
$8B:D3D5             dx B695,       ; ???
                        0001,D3FF,
                        B54F,       ; ???
                        956B        ; Delete
}


;;; $D3DF: Instruction list - mode 7 object $D431 (yyyy) ;;;
{
$8B:D3DF             dx 0001,D3FF,
                        9586,D3DF,  ; Go to $D3DF
                        B6ED,       ; ???
                        956B        ; Delete
}


;;; $D3EB: Instruction list - mode 7 object $D437 (yyyy) ;;;
{
$8B:D3EB             dx B6F8,       ; ???
                        0001,D3FF,
                        B70B,       ; ???
                        956B        ; Delete
}


;;; $D3F5: Instruction list - mode 7 object $D43D (yyyy) ;;;
{
$8B:D3F5             dx B4EB,       ; ???
                        0001,D3FF,
                        B519,       ; ???
                        956B        ; Delete
}


;;; $D3FF: Mode 7 transfer data - dummy ;;;
{
$8B:D3FF             db 00, 00
}
}


;;; $D401: Mode 7 objects. Japanese intro text ;;;
{
;                        _____________ Initialisation function
;                       |     ________ Pre-instruction
;                       |    |     ___ Instruction list pointer
;                       |    |    |
$8B:D401             dw 93D9,93D9,D389
$8B:D407             dw 93D9,93D9,D393
$8B:D40D             dw 93D9,B585,D39D
$8B:D413             dw 93D9,93D9,D3A9
$8B:D419             dw 93D9,B5EE,D3B3
$8B:D41F             dw 93D9,93D9,D3BF
$8B:D425             dw 93D9,B657,D3C9
$8B:D42B             dw 93D9,93D9,D3D5
$8B:D431             dw 93D9,B6C0,D3DF
$8B:D437             dw 93D9,93D9,D3EB
$8B:D43D             dw 93D9,93D9,D3F5 ; Unused, broken
}


;;; $D443: Game state 27h (ending and credits) ;;;
{
$8B:D443 08          PHP
$8B:D444 8B          PHB
$8B:D445 4B          PHK                    ;\
$8B:D446 AB          PLB                    ;} DB = $8B
$8B:D447 C2 30       REP #$30
$8B:D449 F4 4E D4    PEA $D44E              ;\
$8B:D44C 6C 51 1F    JMP ($1F51)[$8B:D480]  ;} Execute [cinematic function]

$8B:D44F AD 9F 1B    LDA $1B9F  [$7E:1B9F]  ;\
$8B:D452 30 04       BMI $04    [$D458]     ;} If [$1B9F] >= 0:
$8B:D454 1A          INC A                  ;\
$8B:D455 8D 9F 1B    STA $1B9F  [$7E:1B9F]  ;} Increment $1B9F

$8B:D458 EE 51 1A    INC $1A51  [$7E:1A51]  ; Increment cinematic frame counter
$8B:D45B 20 EF 93    JSR $93EF  [$8B:93EF]  ; Handle cinematic sprite objects
$8B:D45E 20 74 D4    JSR $D474  [$8B:D474]  ; Handle final screen cinematic BG objects
$8B:D461 20 55 99    JSR $9955  [$8B:9955]  ; Handle credits object
$8B:D464 22 27 C5 8D JSL $8DC527[$8D:C527]  ; Palette FX object handler
$8B:D468 20 99 97    JSR $9799  [$8B:9799]  ; Draw cinematic sprite objects
$8B:D46B 20 12 E8    JSR $E812  [$8B:E812]  ; Handle shooting stars
$8B:D46E 20 32 85    JSR $8532  [$8B:8532]  ; Handle mode 7 transformation matrix
$8B:D471 AB          PLB
$8B:D472 28          PLP
$8B:D473 6B          RTL
}


;;; $D474: Handle final screen cinematic BG objects ;;;
{
; Used for "see you next mission" and item percentage
$8B:D474 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:D477 C9 04 E5    CMP #$E504             ;} If [cinematic function] >= $E504:
$8B:D47A 30 03       BMI $03    [$D47F]     ;/
$8B:D47C 20 2F 96    JSR $962F  [$8B:962F]  ; Handle cinematic BG objects

$8B:D47F 60          RTS
}


;;; $D480: Cinematic function - ending - setup ;;;
{
$8B:D480 64 AB       STZ $AB    [$7E:00AB]  ; Interrupt command = nothing
$8B:D482 64 A7       STZ $A7    [$7E:00A7]  ; Next interrupt command = nothing
$8B:D484 A2 08 00    LDX #$0008             ;\
                                            ;|
$8B:D487 22 38 83 80 JSL $808338[$80:8338]  ;} Wait 8 frames
$8B:D48B CA          DEX                    ;|
$8B:D48C 10 F9       BPL $F9    [$D487]     ;/
$8B:D48E 20 93 82    JSR $8293  [$8B:8293]  ; Set up PPU for Zebes destruction
$8B:D491 A9 1F 1C    LDA #$1C1F             ;\
$8B:D494 3A          DEC A                  ;|
$8B:D495 3A          DEC A                  ;|
$8B:D496 38          SEC                    ;|
$8B:D497 E9 8D 19    SBC #$198D             ;|
$8B:D49A AA          TAX                    ;} $198D..1C1E = 0
                                            ;|
$8B:D49B 9E 8D 19    STZ $198D,x[$7E:1C1D]  ;|
$8B:D49E CA          DEX                    ;|
$8B:D49F CA          DEX                    ;|
$8B:D4A0 10 F9       BPL $F9    [$D49B]     ;/
$8B:D4A2 A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:D4A5 BF E9 ED 8C LDA $8CEDE9,x[$8C:EDE9];|
$8B:D4A9 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$8B:D4AD E8          INX                    ;} Load Zebes explosion palettes
$8B:D4AE E8          INX                    ;|
$8B:D4AF E0 00 02    CPX #$0200             ;|
$8B:D4B2 30 F1       BMI $F1    [$D4A5]     ;/
$8B:D4B4 A9 00 98    LDA #$9800             ;\
$8B:D4B7 85 48       STA $48    [$7E:0048]  ;|
$8B:D4B9 A9 D6 BC    LDA #$BCD6             ;|
$8B:D4BC 85 47       STA $47    [$7E:0047]  ;} Decompress Zebes being zoomed out during Zebes explosion tiles to $7F:0000
$8B:D4BE 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D4C2             dl 7F0000              ;/
$8B:D4C5 A9 00 99    LDA #$9900             ;\
$8B:D4C8 85 48       STA $48    [$7E:0048]  ;|
$8B:D4CA A9 6F A5    LDA #$A56F             ;|
$8B:D4CD 85 47       STA $47    [$7E:0047]  ;} Decompress yellow clouds during Zebes explosion tiles to $7F:4000
$8B:D4CF 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D4D3             dl 7F4000              ;/
$8B:D4D6 A9 00 99    LDA #$9900             ;\
$8B:D4D9 85 48       STA $48    [$7E:0048]  ;|
$8B:D4DB A9 7E D1    LDA #$D17E             ;|
$8B:D4DE 85 47       STA $47    [$7E:0047]  ;} Decompress clear BG tiles for Zebes being zoomed out during Zebes explosion to $7F:8000
$8B:D4E0 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D4E4             dl 7F8000              ;/
$8B:D4E7 E2 30       SEP #$30
$8B:D4E9 A9 00       LDA #$00               ;\
$8B:D4EB 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D4EE A9 00       LDA #$00               ;|
$8B:D4F0 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D4F3 A9 80       LDA #$80               ;|
$8B:D4F5 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..1FFF = [$7F:8000..BFFF] (clear BG tiles) <-- immediately overwritten >_<;
$8B:D4F8 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D4FC             dx 01,01,18,7F8000,4000;|
$8B:D504 A9 02       LDA #$02               ;|
$8B:D506 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D509 A9 00       LDA #$00               ;\
$8B:D50B 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D50E A9 20       LDA #$20               ;|
$8B:D510 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D513 A9 80       LDA #$80               ;|
$8B:D515 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $2000..3FFF = [$7F:8000..BFFF] (clear BG tiles)
$8B:D518 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D51C             dx 01,01,18,7F8000,4000;|
$8B:D524 A9 02       LDA #$02               ;|
$8B:D526 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D529 A9 00       LDA #$00               ;\
$8B:D52B 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D52E A9 60       LDA #$60               ;|
$8B:D530 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D533 A9 80       LDA #$80               ;|
$8B:D535 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $6000..7FFF = [$7F:4000..7FFF] (yellow clouds tiles)
$8B:D538 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D53C             dx 01,01,18,7F4000,4000;|
$8B:D544 A9 02       LDA #$02               ;|
$8B:D546 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D549 A9 00       LDA #$00               ;\
$8B:D54B 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D54E A9 00       LDA #$00               ;|
$8B:D550 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D553 A9 80       LDA #$80               ;|
$8B:D555 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..1FFF = [$7F:0000..3FFF] (Zebes being zoomed out tiles)
$8B:D558 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D55C             dx 01,00,19,7F0000,4000;|
$8B:D564 A9 02       LDA #$02               ;|
$8B:D566 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D569 C2 30       REP #$30
$8B:D56B A9 00 98    LDA #$9800             ;\
$8B:D56E 85 48       STA $48    [$7E:0048]  ;|
$8B:D570 A9 04 83    LDA #$8304             ;|
$8B:D573 85 47       STA $47    [$7E:0047]  ;} Decompress Zebes explosion tiles to $7F:8000
$8B:D575 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D579             dl 7F8000              ;/
$8B:D57C A9 00 95    LDA #$9500             ;\
$8B:D57F 85 48       STA $48    [$7E:0048]  ;|
$8B:D581 A9 2F A8    LDA #$A82F             ;|
$8B:D584 85 47       STA $47    [$7E:0047]  ;} Decompress gunship/Ceres tiles to $7F:0000
$8B:D586 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D58A             dl 7F0000              ;/
$8B:D58D A9 00 96    LDA #$9600             ;\
$8B:D590 85 48       STA $48    [$7E:0048]  ;|
$8B:D592 A9 69 FE    LDA #$FE69             ;|
$8B:D595 85 47       STA $47    [$7E:0047]  ;} Decompress gunship/Ceres tilemap to $7F:4000
$8B:D597 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D59B             dl 7F4000              ;/
$8B:D59E A2 00 03    LDX #$0300             ;\
$8B:D5A1 A9 8C 8C    LDA #$8C8C             ;|
                                            ;|
$8B:D5A4 9F 00 40 7F STA $7F4000,x[$7F:4300];|
$8B:D5A8 E8          INX                    ;} $7F:4300..7FFF = 8C8Ch (keep only the first gunship frame of the tilemap)
$8B:D5A9 E8          INX                    ;|
$8B:D5AA E0 00 40    CPX #$4000             ;|
$8B:D5AD 30 F5       BMI $F5    [$D5A4]     ;/
$8B:D5AF A9 00 98    LDA #$9800             ;\
$8B:D5B2 85 48       STA $48    [$7E:0048]  ;|
$8B:D5B4 A9 C1 B5    LDA #$B5C1             ;|
$8B:D5B7 85 47       STA $47    [$7E:0047]  ;} Decompress wide part of Zebes explosion tilemap to $7F:E000
$8B:D5B9 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D5BD             dl 7FE000              ;/
$8B:D5C0 A9 00 98    LDA #$9800             ;\
$8B:D5C3 85 48       STA $48    [$7E:0048]  ;|
$8B:D5C5 A9 57 B8    LDA #$B857             ;|
$8B:D5C8 85 47       STA $47    [$7E:0047]  ;} Decompress concentric wide part of Zebes explosion tilemap to $7F:E800
$8B:D5CA 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D5CE             dl 7FE800              ;/
$8B:D5D1 A9 00 98    LDA #$9800             ;\
$8B:D5D4 85 48       STA $48    [$7E:0048]  ;|
$8B:D5D6 A9 ED BA    LDA #$BAED             ;|
$8B:D5D9 85 47       STA $47    [$7E:0047]  ;} Decompress eclipse of Zebes during explosion tilemap to $7F:F000
$8B:D5DB 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D5DF             dl 7FF000              ;/
$8B:D5E2 A9 00 98    LDA #$9800             ;\
$8B:D5E5 85 48       STA $48    [$7E:0048]  ;|
$8B:D5E7 A9 CD BC    LDA #$BCCD             ;|
$8B:D5EA 85 47       STA $47    [$7E:0047]  ;} Decompress blank tilemap to $7F:F800
$8B:D5EC 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D5F0             dl 7FF800              ;/
$8B:D5F3 A9 00 97    LDA #$9700             ;\
$8B:D5F6 85 48       STA $48    [$7E:0048]  ;|
$8B:D5F8 A9 DE E7    LDA #$E7DE             ;|
$8B:D5FB 85 47       STA $47    [$7E:0047]  ;} Decompress font 3 tiles to $7E:A000
$8B:D5FD 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D601             dl 7EA000              ;/
$8B:D604 A9 00 99    LDA #$9900             ;\
$8B:D607 85 48       STA $48    [$7E:0048]  ;|
$8B:D609 A9 5B D6    LDA #$D65B             ;|
$8B:D60C 85 47       STA $47    [$7E:0047]  ;} Decompress clear BG tiles for grey clouds during Zebes explosion to $7E:2000
$8B:D60E 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D612             dl 7E2000              ;/
$8B:D615 A9 00 99    LDA #$9900             ;\
$8B:D618 85 48       STA $48    [$7E:0048]  ;|
$8B:D61A A9 32 D9    LDA #$D932             ;|
$8B:D61D 85 47       STA $47    [$7E:0047]  ;} Decompress clear BG tiles for big Zebes during Zebes explosion to $7E:6000
$8B:D61F 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D623             dl 7E6000              ;/
$8B:D626 A9 00 01    LDA #$0100             ;\
$8B:D629 8D 1B 21    STA $211B  [$7E:211B]  ;} Mode 7 transformation matrix parameter A = 100h
$8B:D62C 85 78       STA $78    [$7E:0078]  ;/
$8B:D62E 9C 1C 21    STZ $211C  [$7E:211C]  ;\
$8B:D631 64 7A       STZ $7A    [$7E:007A]  ;} Mode 7 transformation matrix parameter B = 0
$8B:D633 9C 1D 21    STZ $211D  [$7E:211D]  ;\
$8B:D636 64 7C       STZ $7C    [$7E:007C]  ;} Mode 7 transformation matrix parameter C = 0
$8B:D638 8D 1E 21    STA $211E  [$7E:211E]  ;\
$8B:D63B 85 7E       STA $7E    [$7E:007E]  ;} Mode 7 transformation matrix parameter D = 100h
$8B:D63D A9 80 00    LDA #$0080             ;\
$8B:D640 8D 1F 21    STA $211F  [$7E:211F]  ;} Mode 7 transformation origin co-ordinate X = 80h
$8B:D643 85 80       STA $80    [$7E:0080]  ;/
$8B:D645 8D 20 21    STA $2120  [$7E:2120]  ;\
$8B:D648 85 82       STA $82    [$7E:0082]  ;} Mode 7 transformation origin co-ordinate Y = 80h
$8B:D64A A9 20 00    LDA #$0020             ;\
$8B:D64D 8D 8D 19    STA $198D  [$7E:198D]  ;} Mode 7 transformation angle = 20h
$8B:D650 A9 40 00    LDA #$0040             ;\
$8B:D653 8D 8F 19    STA $198F  [$7E:198F]  ;} Mode 7 transformation zoom level = 40h
$8B:D656 A9 00 00    LDA #$0000             ;\
$8B:D659 8D 93 19    STA $1993  [$7E:1993]  ;} Mode 7 X position = 0
$8B:D65C 8D 97 19    STA $1997  [$7E:1997]  ; Mode 7 Y position = 0
$8B:D65F 9C 8D 07    STZ $078D  [$7E:078D]  ; Door pointer = 0 (?!)
$8B:D662 9C 11 09    STZ $0911  [$7E:0911]  ; Layer 1 X position = 0
$8B:D665 9C 15 09    STZ $0915  [$7E:0915]  ; Layer 1 Y position = 0
$8B:D668 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]  ; Clear palette FX objects
$8B:D66C 22 C2 C4 8D JSL $8DC4C2[$8D:C4C2]  ; Enable palette FX objects
$8B:D670 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$8B:D674 9C 05 1A    STZ $1A05  [$7E:1A05]  ; Shooting stars enable flag = 0
$8B:D677 E2 20       SEP #$20
$8B:D679 A9 11       LDA #$11               ;\
$8B:D67B 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$8B:D67D A9 01       LDA #$01               ;\
$8B:D67F 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG1
$8B:D681 A9 02       LDA #$02               ;\
$8B:D683 85 6F       STA $6F    [$7E:006F]  ;} Enable subscreen layers
$8B:D685 A9 11       LDA #$11               ;\
$8B:D687 85 72       STA $72    [$7E:0072]  ;} Enable colour math on BG1/sprites
$8B:D689 C2 20       REP #$20
$8B:D68B A9 00 00    LDA #$0000             ;\
$8B:D68E A0 EB EE    LDY #$EEEB             ;} Spawn cinematic sprite object $EEEB with parameter 0 (right cloud top)
$8B:D691 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:D694 A9 00 00    LDA #$0000             ;\
$8B:D697 A0 F1 EE    LDY #$EEF1             ;} Spawn cinematic sprite object $EEF1 with parameter 0 (left cloud bottom)
$8B:D69A 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:D69D A9 01 00    LDA #$0001             ;\
$8B:D6A0 A0 EB EE    LDY #$EEEB             ;} Spawn cinematic sprite object $EEEB with parameter 1 (right cloud bottom)
$8B:D6A3 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:D6A6 A9 01 00    LDA #$0001             ;\
$8B:D6A9 A0 F1 EE    LDY #$EEF1             ;} Spawn cinematic sprite object $EEF1 with parameter 1 (left cloud top)
$8B:D6AC 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:D6AF 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$8B:D6B2 A9 02 00    LDA #$0002             ;\
$8B:D6B5 8D 25 07    STA $0725  [$7E:0725]  ;} Screen fade counter = 2
$8B:D6B8 A9 D7 D6    LDA #$D6D7             ;\
$8B:D6BB 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $D6D7
$8B:D6BE A9 00 00    LDA #$0000             ;\
$8B:D6C1 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$8B:D6C5 A9 33 FF    LDA #$FF33             ;\
$8B:D6C8 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue Zebes boom music data
$8B:D6CC A9 05 00    LDA #$0005             ;\
$8B:D6CF A0 0E 00    LDY #$000E             ;} Queue song 0 music track, 14 frame delay
$8B:D6D2 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/
$8B:D6D6 60          RTS
}


;;; $D6D7: Cinematic function - ending - wait for music to change ;;;
{
$8B:D6D7 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$8B:D6DB B0 14       BCS $14    [$D6F1]     ;} If music is queued: return
$8B:D6DD A0 D8 E1    LDY #$E1D8             ;\
$8B:D6E0 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1D8 (exploding Zebes lava)
$8B:D6E4 A0 DC E1    LDY #$E1DC             ;\
$8B:D6E7 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1DC (fade out exploding Zebes crust)
$8B:D6EB A9 F2 D6    LDA #$D6F2             ;\
$8B:D6EE 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $D6F2

$8B:D6F1 60          RTS
}


;;; $D6F2: Cinematic function - ending - Zebes destruction scene 0 - zooming out, clouds on left/right - fading in ;;;
{
$8B:D6F2 20 01 D7    JSR $D701  [$8B:D701]  ; Cinematic function - ending - Zebes destruction scene 0 - zooming out, clouds on left/right
$8B:D6F5 20 00 91    JSR $9100  [$8B:9100]  ; Advance fast screen fade in
$8B:D6F8 90 06       BCC $06    [$D700]     ; If not reached max brightness: return
$8B:D6FA A9 01 D7    LDA #$D701             ;\
$8B:D6FD 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $D701

$8B:D700 60          RTS
}


;;; $D701: Cinematic function - ending - Zebes destruction scene 0 - zooming out, clouds on left/right ;;;
{
$8B:D701 AD 51 1A    LDA $1A51  [$7E:1A51]  ;\
$8B:D704 89 01 00    BIT #$0001             ;} If [cinematic frame counter] % 2 = 0:
$8B:D707 D0 0D       BNE $0D    [$D716]     ;/
$8B:D709 AD 8D 19    LDA $198D  [$7E:198D]  ;\
$8B:D70C 38          SEC                    ;|
$8B:D70D E9 01 00    SBC #$0001             ;} Mode 7 transformation angle = ([mode 7 transformation angle] - 1) % 100h
$8B:D710 29 FF 00    AND #$00FF             ;|
$8B:D713 8D 8D 19    STA $198D  [$7E:198D]  ;/

$8B:D716 AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:D719 18          CLC                    ;|
$8B:D71A 69 02 00    ADC #$0002             ;} Mode 7 transformation zoom level += 2
$8B:D71D 8D 8F 19    STA $198F  [$7E:198F]  ;/
$8B:D720 C9 80 01    CMP #$0180             ;\
$8B:D723 30 0B       BMI $0B    [$D730]     ;} If [mode 7 transformation zoom level] >= 180h:
$8B:D725 20 B8 90    JSR $90B8  [$8B:90B8]  ; Advance fast screen fade out
$8B:D728 90 06       BCC $06    [$D730]     ; If not reached zero brightness: return
$8B:D72A A9 31 D7    LDA #$D731             ;\
$8B:D72D 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $D731

$8B:D730 60          RTS
}


;;; $D731: Cinematic function - ending - Zebes destruction scene 1 - zooming out, clouds on top/bottom - setup ;;;
{
$8B:D731 E2 30       SEP #$30
$8B:D733 A9 00       LDA #$00               ;\
$8B:D735 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D738 A9 00       LDA #$00               ;|
$8B:D73A 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D73D A9 80       LDA #$80               ;|
$8B:D73F 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..1FFF = [$7E:2000..5FFF] (clear BG tiles) <-- immediately overwritten >_<;
$8B:D742 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D746             dx 01,01,18,7E2000,4000;|
$8B:D74E A9 02       LDA #$02               ;|
$8B:D750 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D753 A9 00       LDA #$00               ;\
$8B:D755 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D758 A9 20       LDA #$20               ;|
$8B:D75A 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D75D A9 80       LDA #$80               ;|
$8B:D75F 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $2000..3FFF = [$7E:2000..5FFF] (clear BG tiles)
$8B:D762 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D766             dx 01,01,18,7E2000,4000;|
$8B:D76E A9 02       LDA #$02               ;|
$8B:D770 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D773 C2 30       REP #$30
$8B:D775 A9 00 98    LDA #$9800             ;\
$8B:D778 85 48       STA $48    [$7E:0048]  ;|
$8B:D77A A9 4F ED    LDA #$ED4F             ;|
$8B:D77D 85 47       STA $47    [$7E:0047]  ;} Decompress grey clouds during Zebes explosion tiles to $7E:2000
$8B:D77F 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D783             dl 7E2000              ;/
$8B:D786 E2 30       SEP #$30               ;\
$8B:D788 A9 00       LDA #$00               ;|
$8B:D78A 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D78D A9 00       LDA #$00               ;|
$8B:D78F 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D792 A9 80       LDA #$80               ;|
$8B:D794 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..1FFF = [$7E:2000..5FFF] (grey clouds tiles)
$8B:D797 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D79B             dx 01,00,19,7E2000,4000;|
$8B:D7A3 A9 02       LDA #$02               ;|
$8B:D7A5 8D 0B 42    STA $420B  [$7E:420B]  ;|
$8B:D7A8 C2 30       REP #$30               ;/
$8B:D7AA 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]  ; Clear palette FX objects
$8B:D7AE 20 DA 93    JSR $93DA  [$8B:93DA]  ; Clear cinematic sprite objects
$8B:D7B1 A0 E0 E1    LDY #$E1E0             ;\
$8B:D7B4 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1E0 (fade out exploding Zebes grey clouds)
$8B:D7B8 A9 00 00    LDA #$0000             ;\
$8B:D7BB A0 D3 EE    LDY #$EED3             ;} Spawn cinematic sprite object $EED3 (yellow clouds - top - top half)
$8B:D7BE 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:D7C1 A9 00 00    LDA #$0000             ;\
$8B:D7C4 A0 D9 EE    LDY #$EED9             ;} Spawn cinematic sprite object $EED9 (yellow clouds - top - bottom half)
$8B:D7C7 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:D7CA A9 00 00    LDA #$0000             ;\
$8B:D7CD A0 DF EE    LDY #$EEDF             ;} Spawn cinematic sprite object $EEDF (yellow clouds - bottom - top half)
$8B:D7D0 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:D7D3 A9 00 00    LDA #$0000             ;\
$8B:D7D6 A0 E5 EE    LDY #$EEE5             ;} Spawn cinematic sprite object $EEE5 (yellow clouds - bottom - bottom half)
$8B:D7D9 20 8A 93    JSR $938A  [$8B:938A]  ;/
$8B:D7DC A9 20 00    LDA #$0020             ;\
$8B:D7DF 8D 8D 19    STA $198D  [$7E:198D]  ;} Mode 7 transformation angle = 20h
$8B:D7E2 A9 40 00    LDA #$0040             ;\
$8B:D7E5 8D 8F 19    STA $198F  [$7E:198F]  ;} Mode 7 transformation zoom level = 40h
$8B:D7E8 A9 00 00    LDA #$0000             ;\
$8B:D7EB 8D 93 19    STA $1993  [$7E:1993]  ;} Mode 7 X position = 0
$8B:D7EE 8D 97 19    STA $1997  [$7E:1997]  ; Mode 7 Y position = 0
$8B:D7F1 A9 F8 D7    LDA #$D7F8             ;\
$8B:D7F4 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $D7F8
$8B:D7F7 60          RTS
}


;;; $D7F8: Cinematic function - ending - Zebes destruction scene 1 - zooming out, clouds on top/bottom - fading in ;;;
{
$8B:D7F8 20 07 D8    JSR $D807  [$8B:D807]  ; Cinematic function - ending - Zebes destruction scene 1 - zooming out, clouds on top/bottom
$8B:D7FB 20 00 91    JSR $9100  [$8B:9100]  ; Advance fast screen fade in
$8B:D7FE 90 06       BCC $06    [$D806]     ; If not reached max brightness: return
$8B:D800 A9 07 D8    LDA #$D807             ;\
$8B:D803 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $D807

$8B:D806 60          RTS
}


;;; $D807: Cinematic function - ending - Zebes destruction scene 1 - zooming out, clouds on top/bottom ;;;
{
$8B:D807 AD 51 1A    LDA $1A51  [$7E:1A51]  ;\
$8B:D80A 89 01 00    BIT #$0001             ;} If [cinematic frame counter] % 2 = 0:
$8B:D80D D0 0D       BNE $0D    [$D81C]     ;/
$8B:D80F AD 8D 19    LDA $198D  [$7E:198D]  ;\
$8B:D812 38          SEC                    ;|
$8B:D813 E9 01 00    SBC #$0001             ;} Mode 7 transformation angle = ([mode 7 transformation angle] - 1) % 100h
$8B:D816 29 FF 00    AND #$00FF             ;|
$8B:D819 8D 8D 19    STA $198D  [$7E:198D]  ;/
                                            
$8B:D81C AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:D81F 18          CLC                    ;|
$8B:D820 69 03 00    ADC #$0003             ;} Mode 7 transformation zoom level += 3
$8B:D823 8D 8F 19    STA $198F  [$7E:198F]  ;/
$8B:D826 C9 80 01    CMP #$0180             ;\
$8B:D829 30 0B       BMI $0B    [$D836]     ;} If [mode 7 transformation zoom level] >= 180h:
$8B:D82B 20 B8 90    JSR $90B8  [$8B:90B8]  ; Advance fast screen fade out
$8B:D82E 90 06       BCC $06    [$D836]     ; If not reached zero brightness: return
$8B:D830 A9 37 D8    LDA #$D837             ;\
$8B:D833 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $D837

$8B:D836 60          RTS
}


;;; $D837: Cinematic function - ending - Zebes destruction scene 2 - cross-fade to space view - setup ;;;
{
$8B:D837 E2 30       SEP #$30
$8B:D839 A9 00       LDA #$00               ;\
$8B:D83B 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D83E A9 00       LDA #$00               ;|
$8B:D840 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D843 A9 80       LDA #$80               ;|
$8B:D845 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..1FFF = [$7E:6000..9FFF] (clear BG tiles) <-- immediately overwritten >_<;
$8B:D848 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D84C             dx 01,01,18,7E6000,4000;|
$8B:D854 A9 02       LDA #$02               ;|
$8B:D856 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D859 A9 00       LDA #$00               ;\
$8B:D85B 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D85E A9 20       LDA #$20               ;|
$8B:D860 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D863 A9 80       LDA #$80               ;|
$8B:D865 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $2000..3FFF = [$7E:6000..9FFF] (clear BG tiles)
$8B:D868 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D86C             dx 01,01,18,7E6000,4000;|
$8B:D874 A9 02       LDA #$02               ;|
$8B:D876 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D879 C2 30       REP #$30               ;\
$8B:D87B A9 00 99    LDA #$9900             ;|
$8B:D87E 85 48       STA $48    [$7E:0048]  ;|
$8B:D880 A9 01 91    LDA #$9101             ;|
$8B:D883 85 47       STA $47    [$7E:0047]  ;} Decompress big Zebes during Zebes explosion tiles to $7E:6000
$8B:D885 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:D889             dl 7E6000              ;|
$8B:D88C E2 30       SEP #$30               ;/
$8B:D88E A9 00       LDA #$00               ;\
$8B:D890 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D893 A9 00       LDA #$00               ;|
$8B:D895 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D898 A9 80       LDA #$80               ;|
$8B:D89A 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..1FFF = [$7E:6000..9FFF] (big Zebes tiles)
$8B:D89D 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D8A1             dx 01,00,19,7E6000,4000;|
$8B:D8A9 A9 02       LDA #$02               ;|
$8B:D8AB 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D8AE A9 00       LDA #$00               ;\
$8B:D8B0 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D8B3 A9 40       LDA #$40               ;|
$8B:D8B5 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D8B8 A9 80       LDA #$80               ;|
$8B:D8BA 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4000..6FFF = [$7F:8000..DFFF] (Zebes explosion tiles)
$8B:D8BD 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D8C1             dx 01,01,18,7F8000,6000;|
$8B:D8C9 A9 02       LDA #$02               ;|
$8B:D8CB 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D8CE A9 00       LDA #$00               ;\
$8B:D8D0 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D8D3 A9 70       LDA #$70               ;|
$8B:D8D5 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D8D8 A9 80       LDA #$80               ;|
$8B:D8DA 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $7000..73FF = [$7F:E000..E7FF] (wide part of Zebes explosion tilemap)
$8B:D8DD 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D8E1             dx 01,01,18,7FE000,0800;|
$8B:D8E9 A9 02       LDA #$02               ;|
$8B:D8EB 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D8EE A9 00       LDA #$00               ;\
$8B:D8F0 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D8F3 A9 74       LDA #$74               ;|
$8B:D8F5 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D8F8 A9 80       LDA #$80               ;|
$8B:D8FA 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $7400..77FF = [$7F:E800..EFFF] (concentric wide part of Zebes explosion tilemap)
$8B:D8FD 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D901             dx 01,01,18,7FE800,0800;|
$8B:D909 A9 02       LDA #$02               ;|
$8B:D90B 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D90E A9 00       LDA #$00               ;\
$8B:D910 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D913 A9 78       LDA #$78               ;|
$8B:D915 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D918 A9 80       LDA #$80               ;|
$8B:D91A 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $7800..7BFF = [$7F:F000..F7FF] (eclipse of Zebes during explosion tilemap)
$8B:D91D 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D921             dx 01,01,18,7FF000,0800;|
$8B:D929 A9 02       LDA #$02               ;|
$8B:D92B 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D92E A9 00       LDA #$00               ;\
$8B:D930 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D933 A9 7C       LDA #$7C               ;|
$8B:D935 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D938 A9 80       LDA #$80               ;|
$8B:D93A 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $7C00..7FFF = [$7F:F800..FFFF] (blank tilemap)
$8B:D93D 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D941             dx 01,01,18,7FF800,0800;|
$8B:D949 A9 02       LDA #$02               ;|
$8B:D94B 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D94E A9 00       LDA #$00               ;\
$8B:D950 8D 16 21    STA $2116  [$7E:2116]  ;|
$8B:D953 A9 50       LDA #$50               ;|
$8B:D955 8D 17 21    STA $2117  [$7E:2117]  ;|
$8B:D958 A9 80       LDA #$80               ;|
$8B:D95A 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $5000..57FF = [$7E:A000..AFFF] (font 3 tiles)
$8B:D95D 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$8B:D961             dx 01,01,18,7EA000,1000;|
$8B:D969 A9 02       LDA #$02               ;|
$8B:D96B 8D 0B 42    STA $420B  [$7E:420B]  ;/
$8B:D96E A9 02       LDA #$02               ;\
$8B:D970 85 52       STA $52    [$7E:0052]  ;} Sprite tiles base address = $4000, sprite sizes = 8x8 / 16x16
$8B:D972 C2 30       REP #$30
$8B:D974 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]  ; Clear palette FX objects
$8B:D978 20 DA 93    JSR $93DA  [$8B:93DA]  ; Clear cinematic sprite objects
$8B:D97B A2 00 01    LDX #$0100             ;\
                                            ;|
$8B:D97E BF E9 EB 8C LDA $8CEBE9,x[$8C:ECE9];|
$8B:D982 9F 00 C0 7E STA $7EC000,x[$7E:C100];|
$8B:D986 E8          INX                    ;} Sprite palettes = [$8C:ECE9..EDE8] (Zebes explosion scene)
$8B:D987 E8          INX                    ;|
$8B:D988 E0 00 02    CPX #$0200             ;|
$8B:D98B 30 F1       BMI $F1    [$D97E]     ;/
$8B:D98D A0 9D EE    LDY #$EE9D             ;\
$8B:D990 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EE9D (exploding Zebes - Zebes)
$8B:D993 A0 AF EE    LDY #$EEAF             ;\
$8B:D996 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EEAF (exploding Zebes - lava)
$8B:D999 A0 A3 EE    LDY #$EEA3             ;\
$8B:D99C 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EEA3 (exploding Zebes - purple glow)
$8B:D99F A0 A9 EE    LDY #$EEA9             ;\
$8B:D9A2 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EEA9 (exploding Zebes - stars)
$8B:D9A5 9C 8D 19    STZ $198D  [$7E:198D]  ; Mode 7 transformation angle = 0
$8B:D9A8 A9 40 00    LDA #$0040             ;\
$8B:D9AB 8D 8F 19    STA $198F  [$7E:198F]  ;} Mode 7 transformation zoom level = 40h
$8B:D9AE A9 00 01    LDA #$0100             ;\
$8B:D9B1 85 78       STA $78    [$7E:0078]  ;} Mode 7 transformation matrix parameter A = 100h
$8B:D9B3 64 7A       STZ $7A    [$7E:007A]  ; Mode 7 transformation matrix parameter B = 0
$8B:D9B5 64 7C       STZ $7C    [$7E:007C]  ; Mode 7 transformation matrix parameter C = 0
$8B:D9B7 85 7E       STA $7E    [$7E:007E]  ; Mode 7 transformation matrix parameter D = 100h
$8B:D9B9 A9 80 00    LDA #$0080             ;\
$8B:D9BC 85 80       STA $80    [$7E:0080]  ;} Mode 7 transformation origin co-ordinate X = 80h
$8B:D9BE 85 82       STA $82    [$7E:0082]  ; Mode 7 transformation origin co-ordinate Y = 80h
$8B:D9C0 9C 93 19    STZ $1993  [$7E:1993]  ;\
$8B:D9C3 9C 97 19    STZ $1997  [$7E:1997]  ;} Mode 7 X position = 0
$8B:D9C6 E2 20       SEP #$20               ; Mode 7 Y position = 0
$8B:D9C8 A9 01       LDA #$01               ;\
$8B:D9CA 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1
$8B:D9CC A9 10       LDA #$10               ;\
$8B:D9CE 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = sprites
$8B:D9D0 A9 02       LDA #$02               ;\
$8B:D9D2 85 6F       STA $6F    [$7E:006F]  ;} Enable subscreen layers
$8B:D9D4 A9 21       LDA #$21               ;\
$8B:D9D6 85 72       STA $72    [$7E:0072]  ;} Enable colour math on BG1/backdrop
$8B:D9D8 C2 20       REP #$20
$8B:D9DA 20 E9 8B    JSR $8BE9  [$8B:8BE9]  ; Copy current palettes to fading palettes
$8B:D9DD 20 09 8C    JSR $8C09  [$8B:8C09]  ; Decompose fading palette data
$8B:D9E0 A2 A0 01    LDX #$01A0             ;\
$8B:D9E3 A0 10 00    LDY #$0010             ;} Clear fading sprite palette 5
$8B:D9E6 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:D9E9 A2 E0 01    LDX #$01E0             ;\
$8B:D9EC A0 10 00    LDY #$0010             ;} Clear fading sprite palette 7
$8B:D9EF 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:D9F2 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes
$8B:D9F5 A9 3F 00    LDA #$003F             ;\
$8B:D9F8 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 3Fh
$8B:D9FB A9 02 DA    LDA #$DA02             ;\
$8B:D9FE 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $DA02
$8B:DA01 60          RTS
}


;;; $DA02: Cinematic function - ending - Zebes destruction scene 2 - cross-fade to space view - fading in ;;;
{
$8B:DA02 20 1A DA    JSR $DA1A  [$8B:DA1A]  ; Cinematic function - ending - Zebes destruction scene 2 - cross-fade to space view
$8B:DA05 20 00 91    JSR $9100  [$8B:9100]  ; Advance fast screen fade in
$8B:DA08 90 0F       BCC $0F    [$DA19]     ; If not reached max brightness: return
$8B:DA0A A9 02 00    LDA #$0002             ;\
$8B:DA0D 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 2
$8B:DA10 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 2
$8B:DA13 A9 1A DA    LDA #$DA1A             ;\
$8B:DA16 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $DA1A

$8B:DA19 60          RTS
}


;;; $DA1A: Cinematic function - ending - Zebes destruction scene 2 - cross-fade to space view ;;;
{
$8B:DA1A AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:DA1D 18          CLC                    ;|
$8B:DA1E 69 04 00    ADC #$0004             ;} Mode 7 transformation zoom level += 4
$8B:DA21 8D 8F 19    STA $198F  [$7E:198F]  ;/
$8B:DA24 AD 49 1A    LDA $1A49  [$7E:1A49]  ;\
$8B:DA27 89 01 00    BIT #$0001             ;} If [cinematic function timer] % 2 = 0:
$8B:DA2A D0 1E       BNE $1E    [$DA4A]     ;/
$8B:DA2C A2 E0 00    LDX #$00E0             ;\
$8B:DA2F A0 10 00    LDY #$0010             ;} Fade out BG palette 7
$8B:DA32 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:DA35 A2 A0 01    LDX #$01A0             ;\
$8B:DA38 A0 10 00    LDY #$0010             ;} Fade in sprite palette 5
$8B:DA3B 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:DA3E A2 E0 01    LDX #$01E0             ;\
$8B:DA41 A0 10 00    LDY #$0010             ;} Fade in sprite palette 7
$8B:DA44 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:DA47 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes

$8B:DA4A CE 49 1A    DEC $1A49  [$7E:1A49]  ; Decrement cinematic function timer
$8B:DA4D 30 03       BMI $03    [$DA52]     ; If [cinematic function timer] >= 0:
$8B:DA4F 4C D2 DA    JMP $DAD2  [$8B:DAD2]  ; Return

$8B:DA52 A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:DA55 BF E9 EB 8C LDA $8CEBE9,x[$8C:EBE9];|
$8B:DA59 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$8B:DA5D E8          INX                    ;} BG palettes = [$8C:ECE9..EDE8] (Zebes explosion scene)
$8B:DA5E E8          INX                    ;|
$8B:DA5F E0 00 01    CPX #$0100             ;|
$8B:DA62 30 F1       BMI $F1    [$DA55]     ;/
$8B:DA64 E2 20       SEP #$20
$8B:DA66 64 5F       STZ $5F    [$7E:005F]  ; Set mode 7 BG map to wrap within 128x128 tile area, no screen flip
$8B:DA68 A9 70       LDA #$70               ;\
$8B:DA6A 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $7000, size = 32x32
$8B:DA6C A9 78       LDA #$78               ;\
$8B:DA6E 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $7800, size = 32x32
$8B:DA70 64 5A       STZ $5A    [$7E:005A]  ; BG3 tilemap base address = $0000, size = 32x32
$8B:DA72 64 5C       STZ $5C    [$7E:005C]  ; BG4 tilemap base address = $0000, size = 32x32
$8B:DA74 A9 44       LDA #$44               ;\
$8B:DA76 85 5D       STA $5D    [$7E:005D]  ;} BG1/2 tiles base address = $4000, BG3/4 tiles base address = $0000
$8B:DA78 64 5E       STZ $5E    [$7E:005E]  ;/
$8B:DA7A A9 10       LDA #$10               ;\
$8B:DA7C 85 69       STA $69    [$7E:0069]  ;} Main screen layers = sprites
$8B:DA7E 64 6B       STZ $6B    [$7E:006B]  ; Disable all subscreen layers
$8B:DA80 64 6C       STZ $6C    [$7E:006C]  ; Enable all layers in window area main screen
$8B:DA82 64 6D       STZ $6D    [$7E:006D]  ; Enable all layers in window area subscreen
$8B:DA84 64 6E       STZ $6E    [$7E:006E]  ;\
$8B:DA86 64 71       STZ $71    [$7E:0071]  ;|
$8B:DA88 64 6F       STZ $6F    [$7E:006F]  ;|
$8B:DA8A 64 72       STZ $72    [$7E:0072]  ;|
$8B:DA8C A9 E0       LDA #$E0               ;|
$8B:DA8E 8D 32 21    STA $2132  [$7E:2132]  ;|
$8B:DA91 A9 20       LDA #$20               ;} Disable colour math, colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$8B:DA93 85 74       STA $74    [$7E:0074]  ;|
$8B:DA95 A9 40       LDA #$40               ;|
$8B:DA97 85 75       STA $75    [$7E:0075]  ;|
$8B:DA99 A9 80       LDA #$80               ;|
$8B:DA9B 85 76       STA $76    [$7E:0076]  ;/
$8B:DA9D 64 57       STZ $57    [$7E:0057]  ; Disable mosaic
$8B:DA9F C2 20       REP #$20
$8B:DAA1 9C 91 19    STZ $1991  [$7E:1991]  ;\
$8B:DAA4 9C 93 19    STZ $1993  [$7E:1993]  ;} Mode 7 X position = 0.0
$8B:DAA7 9C 95 19    STZ $1995  [$7E:1995]  ;\
$8B:DAAA 9C 97 19    STZ $1997  [$7E:1997]  ;} Mode 7 Y position = 0.0
$8B:DAAD 9C 99 19    STZ $1999  [$7E:1999]  ;\
$8B:DAB0 9C 9B 19    STZ $199B  [$7E:199B]  ;} Mode 7 X speed = 0.0
$8B:DAB3 9C 9D 19    STZ $199D  [$7E:199D]  ;\
$8B:DAB6 9C 9F 19    STZ $199F  [$7E:199F]  ;} Mode 7 Y speed = 0.0
$8B:DAB9 9C 82 19    STZ $1982  [$7E:1982]  ; Default layer blending configuration = 0
$8B:DABC 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$8B:DABE 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$8B:DAC0 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$8B:DAC3 A9 02 00    LDA #$0002             ;\
$8B:DAC6 8D 25 07    STA $0725  [$7E:0725]  ;} Screen fade counter = 2
$8B:DAC9 A9 D3 DA    LDA #$DAD3             ;\
$8B:DACC 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $DAD3
$8B:DACF 9C 49 1A    STZ $1A49  [$7E:1A49]  ; Cinematic function timer = 0

$8B:DAD2 60          RTS
}


;;; $DAD3: Cinematic function - ending - space view - load gunship BG ;;;
{
$8B:DAD3 AD 49 1A    LDA $1A49  [$7E:1A49]  ;\
$8B:DAD6 C9 08 00    CMP #$0008             ;} If [cinematic function timer] < 8:
$8B:DAD9 10 33       BPL $33    [$DB0E]     ;/
$8B:DADB 0A          ASL A                  ;\
$8B:DADC AA          TAX                    ;} X = [cinematic function timer] * 2
$8B:DADD AC 34 03    LDY $0334  [$7E:0334]  ;\
$8B:DAE0 A9 C0 00    LDA #$00C0             ;|
$8B:DAE3 99 D0 02    STA $02D0,y[$7E:02D0]  ;|
$8B:DAE6 BD 5D DB    LDA $DB5D,x[$8B:DB5D]  ;|
$8B:DAE9 99 D1 02    STA $02D1,y[$7E:02D1]  ;|
$8B:DAEC A9 7F 00    LDA #$007F             ;|
$8B:DAEF 99 D3 02    STA $02D3,y[$7E:02D3]  ;|
$8B:DAF2 A9 00 08    LDA #$0800             ;|
$8B:DAF5 99 D4 02    STA $02D4,y[$7E:02D4]  ;} Queue mode 7 tiles transfer of 800h bytes from $7F:0000 + [X] * 400h to VRAM [X] * 400h
$8B:DAF8 BD 7D DB    LDA $DB7D,x[$8B:DB7D]  ;|
$8B:DAFB 99 D6 02    STA $02D6,y[$7E:02D6]  ;|
$8B:DAFE A9 80 00    LDA #$0080             ;|
$8B:DB01 99 D8 02    STA $02D8,y[$7E:02D8]  ;|
$8B:DB04 98          TYA                    ;|
$8B:DB05 18          CLC                    ;|
$8B:DB06 69 09 00    ADC #$0009             ;|
$8B:DB09 8D 34 03    STA $0334  [$7E:0334]  ;/
$8B:DB0C 80 31       BRA $31    [$DB3F]

$8B:DB0E 0A          ASL A                  ;\ Else ([cinematic function timer] >= 8):
$8B:DB0F AA          TAX                    ;} X = [cinematic function timer] * 2
$8B:DB10 AC 34 03    LDY $0334  [$7E:0334]  ;\
$8B:DB13 A9 80 00    LDA #$0080             ;|
$8B:DB16 99 D0 02    STA $02D0,y[$7E:02D0]  ;|
$8B:DB19 BD 5D DB    LDA $DB5D,x[$8B:DB6D]  ;|
$8B:DB1C 99 D1 02    STA $02D1,y[$7E:02D1]  ;|
$8B:DB1F A9 7F 00    LDA #$007F             ;|
$8B:DB22 99 D3 02    STA $02D3,y[$7E:02D3]  ;|
$8B:DB25 A9 00 08    LDA #$0800             ;|
$8B:DB28 99 D4 02    STA $02D4,y[$7E:02D4]  ;} Queue mode 7 tilemap transfer of 800h bytes from $7F:0000 + [X] * 400h to VRAM ([X] - 10h) * 400h
$8B:DB2B BD 7D DB    LDA $DB7D,x[$8B:DB8D]  ;|
$8B:DB2E 99 D6 02    STA $02D6,y[$7E:02D6]  ;|
$8B:DB31 A9 00 00    LDA #$0000             ;|
$8B:DB34 99 D8 02    STA $02D8,y[$7E:02D8]  ;|
$8B:DB37 98          TYA                    ;|
$8B:DB38 18          CLC                    ;|
$8B:DB39 69 09 00    ADC #$0009             ;|
$8B:DB3C 8D 34 03    STA $0334  [$7E:0334]  ;/

$8B:DB3F AD 49 1A    LDA $1A49  [$7E:1A49]  ;\
$8B:DB42 1A          INC A                  ;} Increment cinematic function timer
$8B:DB43 8D 49 1A    STA $1A49  [$7E:1A49]  ;/
$8B:DB46 C9 10 00    CMP #$0010             ;\
$8B:DB49 30 11       BMI $11    [$DB5C]     ;} If [cinematic function timer] >= 10h:
$8B:DB4B E2 20       SEP #$20               ;\
$8B:DB4D A9 01       LDA #$01               ;|
$8B:DB4F 85 55       STA $55    [$7E:0055]  ;} BG mode = 1 without BG3 priority, BG tile sizes = 8x8
$8B:DB51 C2 20       REP #$20               ;/
$8B:DB53 9C 49 1A    STZ $1A49  [$7E:1A49]  ; Cinematic function timer = 0
$8B:DB56 A9 9D DB    LDA #$DB9D             ;\
$8B:DB59 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = RTS

$8B:DB5C 60          RTS

$8B:DB5D             dw 0000, 0800, 1000, 1800, 2000, 2800, 3000, 3800, ; Tiles source addresses (bank $7F)
                        4000, 4800, 5000, 5800, 6000, 6800, 7000, 7800  ; Tilemap source addresses (bank $7F)
$8B:DB7D             dw 0000, 0800, 1000, 1800, 2000, 2800, 3000, 3800, ; Tiles destination addresses (VRAM)
                        0000, 0800, 1000, 1800, 2000, 2800, 3000, 3800  ; Tilemap destination addresses (VRAM)
}


;;; $DB9D: RTS ;;;
{
$8B:DB9D 60          RTS
}


;;; $DB9E: Cinematic function - ending - space view - change music ;;;
{
$8B:DB9E CE 49 1A    DEC $1A49  [$7E:1A49]  ; Decrement cinematic function timer
$8B:DBA1 F0 02       BEQ $02    [$DBA5]     ;\
$8B:DBA3 10 1E       BPL $1E    [$DBC3]     ;} If [cinematic function timer] > 0: return

$8B:DBA5 A9 00 00    LDA #$0000             ;\
$8B:DBA8 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$8B:DBAC A9 3C FF    LDA #$FF3C             ;\
$8B:DBAF 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue credits music data
$8B:DBB3 A9 05 00    LDA #$0005             ;\
$8B:DBB6 A0 0E 00    LDY #$000E             ;} Queue song 0 music track, 14 frame delay
$8B:DBB9 22 F7 8F 80 JSL $808FF7[$80:8FF7]  ;/
$8B:DBBD A9 C4 DB    LDA #$DBC4             ;\
$8B:DBC0 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $DBC4

$8B:DBC3 60          RTS
}


;;; $DBC4: Cinematic function - ending - space view - gunship emergence - setup ;;;
{
$8B:DBC4 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$8B:DBC8 90 01       BCC $01    [$DBCB]     ;} If music is queued:
$8B:DBCA 60          RTS                    ; Return

$8B:DBCB E2 20       SEP #$20
$8B:DBCD A9 07       LDA #$07               ;\
$8B:DBCF 85 55       STA $55    [$7E:0055]  ;} BG mode = 7
$8B:DBD1 A9 80       LDA #$80               ;\
$8B:DBD3 85 5F       STA $5F    [$7E:005F]  ;} Set mode 7 BG map overflowing tiles as transparent, no screen flip
$8B:DBD5 A9 11       LDA #$11               ;\
$8B:DBD7 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$8B:DBD9 64 6B       STZ $6B    [$7E:006B]  ;\
$8B:DBDB 64 6F       STZ $6F    [$7E:006F]  ;} Disable subscreen layers
$8B:DBDD A9 30       LDA #$30               ;\
$8B:DBDF 85 72       STA $72    [$7E:0072]  ;} Enable colour math on sprites/backdrop
$8B:DBE1 A9 3F       LDA #$3F               ;\
$8B:DBE3 85 74       STA $74    [$7E:0074]  ;|
$8B:DBE5 A9 5F       LDA #$5F               ;|
$8B:DBE7 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (1Fh, 1Fh, 1Fh) (white)
$8B:DBE9 A9 9F       LDA #$9F               ;|
$8B:DBEB 85 76       STA $76    [$7E:0076]  ;/
$8B:DBED A9 00       LDA #$00               ;\
$8B:DBEF 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $0000, size = 32x32
$8B:DBF1 A9 00       LDA #$00               ;\
$8B:DBF3 85 5D       STA $5D    [$7E:005D]  ;} BG1/2 tiles base address = $0000
$8B:DBF5 C2 20       REP #$20
$8B:DBF7 A9 00 00    LDA #$0000             ;\
$8B:DBFA 8F 00 C0 7E STA $7EC000[$7E:C000]  ;} Main screen backdrop colour = 0 (black)
$8B:DBFE 8F 20 C0 7E STA $7EC020[$7E:C020]  ; BG1/2 palette 1 colour 0 = 0
$8B:DC02 8F 00 C1 7E STA $7EC100[$7E:C100]  ; Sprite palette 0 colour 0 = 0
$8B:DC06 A0 D4 E1    LDY #$E1D4             ;\
$8B:DC09 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1D4 (Zebes explosion planet afterglow)
$8B:DC0D A0 E4 E1    LDY #$E1E4             ;\
$8B:DC10 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1E4 (gunship emerging from Zebes explosion)
$8B:DC14 A9 38 00    LDA #$0038             ;\
$8B:DC17 85 80       STA $80    [$7E:0080]  ;} Mode 7 transformation origin co-ordinate X = 38h
$8B:DC19 A9 18 00    LDA #$0018             ;\
$8B:DC1C 85 82       STA $82    [$7E:0082]  ;} Mode 7 transformation origin co-ordinate Y = 18h
$8B:DC1E A9 B8 FF    LDA #$FFB8             ;\
$8B:DC21 8D 93 19    STA $1993  [$7E:1993]  ;} Mode 7 X position = -48h
$8B:DC24 A9 98 FF    LDA #$FF98             ;\
$8B:DC27 8D 97 19    STA $1997  [$7E:1997]  ;} Mode 7 Y position = -68h
$8B:DC2A A9 00 0C    LDA #$0C00             ;\
$8B:DC2D 8D 8F 19    STA $198F  [$7E:198F]  ;} Mode 7 transformation zoom level = C00h
$8B:DC30 A9 90 FF    LDA #$FF90             ;\
$8B:DC33 8D 8D 19    STA $198D  [$7E:198D]  ;} Mode 7 transformation angle = -70h
$8B:DC36 A9 01 00    LDA #$0001             ;\
$8B:DC39 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 1
$8B:DC3C A9 C0 00    LDA #$00C0             ;\
$8B:DC3F 8D 4B 1A    STA $1A4B  [$7E:1A4B]  ;} $1A4B = C0h
$8B:DC42 9C 4D 1A    STZ $1A4D  [$7E:1A4D]  ; $1A4D = 0
$8B:DC45 A9 A5 DC    LDA #$DCA5             ;\
$8B:DC48 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $DCA5
$8B:DC4B 60          RTS
}


;;; $DC4C: Fade out Zebes explosion afterglow ;;;
{
$8B:DC4C 08          PHP
$8B:DC4D C2 30       REP #$30
$8B:DC4F CE 49 1A    DEC $1A49  [$7E:1A49]  ; Decrement cinematic function timer
$8B:DC52 F0 02       BEQ $02    [$DC56]     ;\
$8B:DC54 10 4D       BPL $4D    [$DCA3]     ;} If [cinematic function timer] > 0: return

$8B:DC56 E2 20       SEP #$20
$8B:DC58 A5 74       LDA $74    [$7E:0074]  ;\
$8B:DC5A 38          SEC                    ;|
$8B:DC5B E9 01       SBC #$01               ;|
$8B:DC5D 85 74       STA $74    [$7E:0074]  ;|
$8B:DC5F C9 20       CMP #$20               ;} Colour math subscreen backdrop colour 0 = max(20h, [colour math subscreen backdrop colour 0] - 1)
$8B:DC61 10 04       BPL $04    [$DC67]     ;|
$8B:DC63 A9 20       LDA #$20               ;|
$8B:DC65 85 74       STA $74    [$7E:0074]  ;/

$8B:DC67 A5 75       LDA $75    [$7E:0075]  ;\
$8B:DC69 38          SEC                    ;|
$8B:DC6A E9 01       SBC #$01               ;|
$8B:DC6C 85 75       STA $75    [$7E:0075]  ;|
$8B:DC6E C9 40       CMP #$40               ;} Colour math subscreen backdrop colour 1 = max(40h, [colour math subscreen backdrop colour 0] - 1)
$8B:DC70 10 04       BPL $04    [$DC76]     ;|
$8B:DC72 A9 40       LDA #$40               ;|
$8B:DC74 85 75       STA $75    [$7E:0075]  ;/

$8B:DC76 A5 76       LDA $76    [$7E:0076]  ;\
$8B:DC78 38          SEC                    ;|
$8B:DC79 E9 01       SBC #$01               ;|
$8B:DC7B 85 76       STA $76    [$7E:0076]  ;|
$8B:DC7D C9 80       CMP #$80               ;} Colour math subscreen backdrop colour 2 = max(80h, [colour math subscreen backdrop colour 0] - 1)
$8B:DC7F 10 04       BPL $04    [$DC85]     ;|
$8B:DC81 A9 80       LDA #$80               ;|
$8B:DC83 85 76       STA $76    [$7E:0076]  ;/

$8B:DC85 A5 74       LDA $74    [$7E:0074]  ;\
$8B:DC87 C9 20       CMP #$20               ;} If [colour math subscreen backdrop colour 0] = 20h:
$8B:DC89 D0 10       BNE $10    [$DC9B]     ;/
$8B:DC8B A5 75       LDA $75    [$7E:0075]  ;\
$8B:DC8D C9 40       CMP #$40               ;} If [colour math subscreen backdrop colour 1] = 40h:
$8B:DC8F D0 0A       BNE $0A    [$DC9B]     ;/
$8B:DC91 A5 76       LDA $76    [$7E:0076]  ;\
$8B:DC93 C9 80       CMP #$80               ;} If [colour math subscreen backdrop colour 2] = 80h:
$8B:DC95 D0 04       BNE $04    [$DC9B]     ;/
$8B:DC97 64 6F       STZ $6F    [$7E:006F]  ;\
$8B:DC99 64 72       STZ $72    [$7E:0072]  ;} Disable colour math

$8B:DC9B C2 20       REP #$20
$8B:DC9D A9 08 00    LDA #$0008             ;\
$8B:DCA0 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 8

$8B:DCA3 28          PLP
$8B:DCA4 60          RTS
}


;;; $DCA5: Cinematic function - ending - space view - gunship emergence -  ;;;
{
$8B:DCA5 AD 4B 1A    LDA $1A4B  [$7E:1A4B]  ;\
$8B:DCA8 F0 06       BEQ $06    [$DCB0]     ;} If [$1A4B] != 0:
$8B:DCAA 3A          DEC A                  ;\
$8B:DCAB 8D 4B 1A    STA $1A4B  [$7E:1A4B]  ;} Decrement $1A4B
$8B:DCAE 80 03       BRA $03    [$DCB3]
                                            ; Else ([$1A4B] = 0):
$8B:DCB0 20 4C DC    JSR $DC4C  [$8B:DC4C]  ; Fade out Zebes explosion afterglow

$8B:DCB3 AD 8D 19    LDA $198D  [$7E:198D]  ;\
$8B:DCB6 38          SEC                    ;|
$8B:DCB7 E9 04 00    SBC #$0004             ;} Mode 7 transformation angle = ([mode 7 transformation angle] - 4) % 100h
$8B:DCBA 29 FF 00    AND #$00FF             ;|
$8B:DCBD 8D 8D 19    STA $198D  [$7E:198D]  ;/
$8B:DCC0 AD 4D 1A    LDA $1A4D  [$7E:1A4D]  ;\
$8B:DCC3 0A          ASL A                  ;|
$8B:DCC4 0A          ASL A                  ;} X = [$1A4D] * 4
$8B:DCC5 AA          TAX                    ;/
$8B:DCC6 AD 91 19    LDA $1991  [$7E:1991]  ;\
$8B:DCC9 18          CLC                    ;|
$8B:DCCA 7D 04 DD    ADC $DD04,x[$8B:DD04]  ;|
$8B:DCCD 8D 91 19    STA $1991  [$7E:1991]  ;} Mode 7 X position += [$DD02 + [X]].[$DD02 + [X] + 2]
$8B:DCD0 AD 93 19    LDA $1993  [$7E:1993]  ;|
$8B:DCD3 7D 02 DD    ADC $DD02,x[$8B:DD02]  ;|
$8B:DCD6 8D 93 19    STA $1993  [$7E:1993]  ;/
$8B:DCD9 AD 4D 1A    LDA $1A4D  [$7E:1A4D]  ;\
$8B:DCDC 1A          INC A                  ;|
$8B:DCDD 29 0F 00    AND #$000F             ;} $1A4D = ([$1A4D] + 1) % 10h
$8B:DCE0 8D 4D 1A    STA $1A4D  [$7E:1A4D]  ;/
$8B:DCE3 AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:DCE6 38          SEC                    ;|
$8B:DCE7 E9 08 00    SBC #$0008             ;} Mode 7 transformation zoom level -= 8
$8B:DCEA 8D 8F 19    STA $198F  [$7E:198F]  ;/
$8B:DCED C9 B0 05    CMP #$05B0             ;\
$8B:DCF0 10 0F       BPL $0F    [$DD01]     ;} If [mode 7 transformation zoom level] < 4A0h:
$8B:DCF2 A9 01 00    LDA #$0001             ;\
$8B:DCF5 8D 4B 1A    STA $1A4B  [$7E:1A4B]  ;} $1A4B = 1 (never read)
$8B:DCF8 9C 4D 1A    STZ $1A4D  [$7E:1A4D]  ; $1A4D = 0
$8B:DCFB A9 42 DD    LDA #$DD42             ;\
$8B:DCFE 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $DD42

$8B:DD01 60          RTS

$8B:DD02             dw 0000,8000, 0000,8000, 0000,8000, 0000,8000, FFFF,8000, FFFF,8000, 0000,8000, 0000,8000,
                        0000,8000, 0000,8000, FFFF,8000, FFFF,8000, 0000,8000, 0000,8000, FFFF,8000, FFFF,8000
}


;;; $DD42: Cinematic function - ending - space view - gunship emergence -  ;;;
{
$8B:DD42 20 4C DC    JSR $DC4C  [$8B:DC4C]  ; Fade out Zebes explosion afterglow
$8B:DD45 AD 8D 19    LDA $198D  [$7E:198D]  ;\
$8B:DD48 C9 E0 00    CMP #$00E0             ;} If [mode 7 transformation angle] != E0h:
$8B:DD4B F0 0A       BEQ $0A    [$DD57]     ;/
$8B:DD4D 38          SEC                    ;\
$8B:DD4E E9 01 00    SBC #$0001             ;|
$8B:DD51 29 FF 00    AND #$00FF             ;} Mode 7 transformation angle = ([mode 7 transformation angle] - 1) % 100h
$8B:DD54 8D 8D 19    STA $198D  [$7E:198D]  ;/

$8B:DD57 AD 4D 1A    LDA $1A4D  [$7E:1A4D]  ;\
$8B:DD5A 0A          ASL A                  ;|
$8B:DD5B 0A          ASL A                  ;} X = [$1A4D] * 4
$8B:DD5C AA          TAX                    ;/
$8B:DD5D AD 91 19    LDA $1991  [$7E:1991]  ;\
$8B:DD60 18          CLC                    ;|
$8B:DD61 7D AF DD    ADC $DDAF,x[$8B:DDAF]  ;|
$8B:DD64 8D 91 19    STA $1991  [$7E:1991]  ;} Mode 7 X position += [$DDAD + [X]].[$DDAD + [X] + 2]
$8B:DD67 AD 93 19    LDA $1993  [$7E:1993]  ;|
$8B:DD6A 7D AD DD    ADC $DDAD,x[$8B:DDAD]  ;|
$8B:DD6D 8D 93 19    STA $1993  [$7E:1993]  ;/
$8B:DD70 AD 4D 1A    LDA $1A4D  [$7E:1A4D]  ;\
$8B:DD73 1A          INC A                  ;|
$8B:DD74 29 07 00    AND #$0007             ;} $1A4D = ([$1A4D] + 1) % 8
$8B:DD77 8D 4D 1A    STA $1A4D  [$7E:1A4D]  ;/
$8B:DD7A AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:DD7D 38          SEC                    ;|
$8B:DD7E E9 02 00    SBC #$0002             ;} Mode 7 transformation zoom level -= 2
$8B:DD81 8D 8F 19    STA $198F  [$7E:198F]  ;/
$8B:DD84 C9 A0 04    CMP #$04A0             ;\
$8B:DD87 10 23       BPL $23    [$DDAC]     ;} If [mode 7 transformation zoom level] < 4A0h:
$8B:DD89 A9 CD DD    LDA #$DDCD             ;\
$8B:DD8C 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $DDCD
$8B:DD8F A9 00 80    LDA #$8000             ;\
$8B:DD92 8D 4D 1A    STA $1A4D  [$7E:1A4D]  ;} $1A4B.$1A4D = 0.8000h
$8B:DD95 9C 4B 1A    STZ $1A4B  [$7E:1A4B]  ;/
$8B:DD98 A9 0F 00    LDA #$000F             ;\
$8B:DD9B 22 33 82 80 JSL $808233[$80:8233]  ;} If critters escaped:
$8B:DD9F 90 0B       BCC $0B    [$DDAC]     ;/
$8B:DDA1 A0 21 EF    LDY #$EF21             ;\
$8B:DDA4 A9 04 00    LDA #$0004             ;|
$8B:DDA7 85 12       STA $12    [$7E:0012]  ;} Spawn cinematic sprite object $EF21 to index 4 (critters escape)
$8B:DDA9 20 A2 93    JSR $93A2  [$8B:93A2]  ;/

$8B:DDAC 60          RTS

$8B:DDAD             dw 0001,0000, 0001,0000, 0001,0000, FFFF,0000, FFFF,0000, 0001,0000, 0001,0000, FFFF,0000
}


;;; $DDCD: Cinematic function - ending - space view - gunship emergence -  ;;;
{
$8B:DDCD 20 4C DC    JSR $DC4C  [$8B:DC4C]  ; Fade out Zebes explosion afterglow
$8B:DDD0 AD 4D 1A    LDA $1A4D  [$7E:1A4D]  ;\
$8B:DDD3 38          SEC                    ;|
$8B:DDD4 E9 00 01    SBC #$0100             ;|
$8B:DDD7 8D 4D 1A    STA $1A4D  [$7E:1A4D]  ;} $1A4B.$1A4D -= 0.0100h
$8B:DDDA AD 4B 1A    LDA $1A4B  [$7E:1A4B]  ;|
$8B:DDDD E9 00 00    SBC #$0000             ;|
$8B:DDE0 8D 4B 1A    STA $1A4B  [$7E:1A4B]  ;/
$8B:DDE3 AD 91 19    LDA $1991  [$7E:1991]  ;\
$8B:DDE6 18          CLC                    ;|
$8B:DDE7 6D 4D 1A    ADC $1A4D  [$7E:1A4D]  ;|
$8B:DDEA 8D 91 19    STA $1991  [$7E:1991]  ;} Mode 7 X position += [$1A4B].[$1A4D]
$8B:DDED AD 93 19    LDA $1993  [$7E:1993]  ;|
$8B:DDF0 6D 4B 1A    ADC $1A4B  [$7E:1A4B]  ;|
$8B:DDF3 8D 93 19    STA $1993  [$7E:1993]  ;/
$8B:DDF6 AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:DDF9 C9 80 01    CMP #$0180             ;} If [mode 7 transformation zoom level] < 180h:
$8B:DDFC 10 1A       BPL $1A    [$DE18]     ;/
$8B:DDFE AD 51 1A    LDA $1A51  [$7E:1A51]  ;\
$8B:DE01 89 03 00    BIT #$0003             ;} If [cinematic frame counter] % 4 = 0:
$8B:DE04 D0 12       BNE $12    [$DE18]     ;/
$8B:DE06 AD 8D 19    LDA $198D  [$7E:198D]  ;\
$8B:DE09 C9 10 00    CMP #$0010             ;} If [mode 7 transformation angle] != 10h:
$8B:DE0C F0 0A       BEQ $0A    [$DE18]     ;/
$8B:DE0E 18          CLC                    ;\
$8B:DE0F 69 02 00    ADC #$0002             ;|
$8B:DE12 29 FF 00    AND #$00FF             ;} Mode 7 transformation angle = ([mode 7 transformation angle] + 2) % 100h
$8B:DE15 8D 8D 19    STA $198D  [$7E:198D]  ;/

$8B:DE18 AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:DE1B C9 20 00    CMP #$0020             ;} If [mode 7 transformation zoom level] >= 20h:
$8B:DE1E 30 08       BMI $08    [$DE28]     ;/
$8B:DE20 38          SEC                    ;\
$8B:DE21 E9 04 00    SBC #$0004             ;} Mode 7 transformation zoom level -= 4
$8B:DE24 8D 8F 19    STA $198F  [$7E:198F]  ;/
$8B:DE27 60          RTS                    ; Return

$8B:DE28 A0 C7 EE    LDY #$EEC7             ;\
$8B:DE2B 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EEC7 ('THE OPERATION WAS')
$8B:DE2E A9 63 DE    LDA #$DE63             ;\
$8B:DE31 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = RTS
$8B:DE34 A2 1E 00    LDX #$001E             ;\
                                            ;|
$8B:DE37 BD 43 DE    LDA $DE43,x[$8B:DE61]  ;|
$8B:DE3A 9F A0 C0 7E STA $7EC0A0,x[$7E:C0BE];} BG1/2 palette 5 = [$DE43..62]
$8B:DE3E CA          DEX                    ;|
$8B:DE3F CA          DEX                    ;|
$8B:DE40 10 F5       BPL $F5    [$DE37]     ;/
$8B:DE42 60          RTS

; Grey gunship palette
$8B:DE43             dw 0000, 6F7B, 4A52, 1CE7, 0000, 5AD6, 4A52, 35AD, 2529, 7FFF, 56B5, 294A, 4210, 2D6B, 18C6, 7FFF
}


;;; $DE63: RTS ;;;
{
$8B:DE63 60          RTS
}


;;; $DE64: Cinematic function - ending - space view - transition to credits ;;;
{
$8B:DE64 A9 01 00    LDA #$0001
$8B:DE67 8D 25 07    STA $0725  [$7E:0725]
$8B:DE6A 20 B8 90    JSR $90B8  [$8B:90B8]  ; Advance fast screen fade out
$8B:DE6D 90 10       BCC $10    [$DE7F]     ; If not reached zero brightness: return
$8B:DE6F 22 4B 83 80 JSL $80834B[$80:834B]
$8B:DE73 9C 23 07    STZ $0723  [$7E:0723]
$8B:DE76 9C 25 07    STZ $0725  [$7E:0725]
$8B:DE79 A9 80 DE    LDA #$DE80
$8B:DE7C 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:DE7F 60          RTS
}


;;; $DE80: Cinematic function - credits - setup ;;;
{
$8B:DE80 20 D3 83    JSR $83D3  [$8B:83D3]  ; Set up PPU for credits
$8B:DE83 20 DA 93    JSR $93DA  [$8B:93DA]  ; Clear cinematic sprite objects
$8B:DE86 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]  ; Clear palette FX objects
$8B:DE8A A2 00 00    LDX #$0000             ;\
                                            ;|
$8B:DE8D BF E9 E9 8C LDA $8CE9E9,x[$8C:E9E9];|
$8B:DE91 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$8B:DE95 E8          INX                    ;} Load credits palettes
$8B:DE96 E8          INX                    ;|
$8B:DE97 E0 00 01    CPX #$0100             ;|
$8B:DE9A 30 F1       BMI $F1    [$DE8D]     ;/
$8B:DE9C A9 00 97    LDA #$9700             ;\
$8B:DE9F 85 48       STA $48    [$7E:0048]  ;|
$8B:DEA1 A9 03 98    LDA #$9803             ;|
$8B:DEA4 85 47       STA $47    [$7E:0047]  ;} Decompress Samus waiting for the credits to end tiles to $7F:0000
$8B:DEA6 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:DEAA             dl 7F0000              ;/
$8B:DEAD A9 00 97    LDA #$9700             ;\
$8B:DEB0 85 48       STA $48    [$7E:0048]  ;|
$8B:DEB2 A9 57 B9    LDA #$B957             ;|
$8B:DEB5 85 47       STA $47    [$7E:0047]  ;} Decompress post-credits suitless Samus tiles to $7E:2000
$8B:DEB7 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:DEBB             dl 7E2000              ;/
$8B:DEBE A9 00 97    LDA #$9700             ;\
$8B:DEC1 85 48       STA $48    [$7E:0048]  ;|
$8B:DEC3 A9 FC D7    LDA #$D7FC             ;|
$8B:DEC6 85 47       STA $47    [$7E:0047]  ;} Decompress post-credits Samus shooting the screen tiles to $7E:6000
$8B:DEC8 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:DECC             dl 7E6000              ;/
$8B:DECF A9 00 97    LDA #$9700             ;\
$8B:DED2 85 48       STA $48    [$7E:0048]  ;|
$8B:DED4 A9 DE E7    LDA #$E7DE             ;|
$8B:DED7 85 47       STA $47    [$7E:0047]  ;} Decompress font 3 tiles to $7F:C000
$8B:DED9 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:DEDD             dl 7FC000              ;/
$8B:DEE0 A9 00 97    LDA #$9700             ;\
$8B:DEE3 85 48       STA $48    [$7E:0048]  ;|
$8B:DEE5 A9 F4 96    LDA #$96F4             ;|
$8B:DEE8 85 47       STA $47    [$7E:0047]  ;} Decompress Samus waiting for the credits to end tilemap to $7F:E000
$8B:DEEA 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:DEEE             dl 7FE000              ;/
$8B:DEF1 A9 00 97    LDA #$9700             ;\
$8B:DEF4 85 48       STA $48    [$7E:0048]  ;|
$8B:DEF6 A9 87 F9    LDA #$F987             ;|
$8B:DEF9 85 47       STA $47    [$7E:0047]  ;} Decompress post-credits Samus beam to $7F:4000 (interleaved tiles/tilemap)
$8B:DEFB 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:DEFF             dl 7F4000              ;/
$8B:DF02 A9 00 99    LDA #$9900             ;\
$8B:DF05 85 48       STA $48    [$7E:0048]  ;|
$8B:DF07 A9 9F DA    LDA #$DA9F             ;|
$8B:DF0A 85 47       STA $47    [$7E:0047]  ;} Decompress post-credits Samus transformation effect tiles to $7F:E800
$8B:DF0C 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:DF10             dl 7FE800              ;/
$8B:DF13 A9 00 99    LDA #$9900             ;\
$8B:DF16 85 48       STA $48    [$7E:0048]  ;|
$8B:DF18 A9 B1 DA    LDA #$DAB1             ;|
$8B:DF1B 85 47       STA $47    [$7E:0047]  ;} Decompress post-credits Samus transformation effect tilemap to $7F:F000
$8B:DF1D 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:DF21             dl 7FF000              ;/
$8B:DF24 E2 30       SEP #$30
$8B:DF26 A9 00       LDA #$00
$8B:DF28 8D 16 21    STA $2116  [$7E:2116]
$8B:DF2B A9 20       LDA #$20
$8B:DF2D 8D 17 21    STA $2117  [$7E:2117]
$8B:DF30 A9 80       LDA #$80
$8B:DF32 8D 15 21    STA $2115  [$7E:2115]
$8B:DF35 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:DF39             dx 01,01,18,7FE800,0100
$8B:DF41 A9 02       LDA #$02
$8B:DF43 8D 0B 42    STA $420B  [$7E:420B]
$8B:DF46 A9 00       LDA #$00
$8B:DF48 8D 16 21    STA $2116  [$7E:2116]
$8B:DF4B A9 24       LDA #$24
$8B:DF4D 8D 17 21    STA $2117  [$7E:2117]
$8B:DF50 A9 80       LDA #$80
$8B:DF52 8D 15 21    STA $2115  [$7E:2115]
$8B:DF55 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:DF59             dx 01,01,18,7FF000,0800
$8B:DF61 A9 02       LDA #$02
$8B:DF63 8D 0B 42    STA $420B  [$7E:420B]
$8B:DF66 A9 00       LDA #$00
$8B:DF68 8D 16 21    STA $2116  [$7E:2116]
$8B:DF6B A9 40       LDA #$40
$8B:DF6D 8D 17 21    STA $2117  [$7E:2117]
$8B:DF70 A9 80       LDA #$80
$8B:DF72 8D 15 21    STA $2115  [$7E:2115]
$8B:DF75 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:DF79             dx 01,01,18,7FC000,1000
$8B:DF81 A9 02       LDA #$02
$8B:DF83 8D 0B 42    STA $420B  [$7E:420B]
$8B:DF86 A9 00       LDA #$00
$8B:DF88 8D 16 21    STA $2116  [$7E:2116]
$8B:DF8B A9 60       LDA #$60
$8B:DF8D 8D 17 21    STA $2117  [$7E:2117]
$8B:DF90 A9 80       LDA #$80
$8B:DF92 8D 15 21    STA $2115  [$7E:2115]
$8B:DF95 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:DF99             dx 01,01,18,7E6000,4000
$8B:DFA1 A9 02       LDA #$02
$8B:DFA3 8D 0B 42    STA $420B  [$7E:420B]
$8B:DFA6 A9 00       LDA #$00
$8B:DFA8 8D 16 21    STA $2116  [$7E:2116]
$8B:DFAB A9 50       LDA #$50
$8B:DFAD 8D 17 21    STA $2117  [$7E:2117]
$8B:DFB0 A9 80       LDA #$80
$8B:DFB2 8D 15 21    STA $2115  [$7E:2115]
$8B:DFB5 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:DFB9             dx 01,01,18,7F0000,2000
$8B:DFC1 A9 02       LDA #$02
$8B:DFC3 8D 0B 42    STA $420B  [$7E:420B]
$8B:DFC6 A9 00       LDA #$00
$8B:DFC8 8D 16 21    STA $2116  [$7E:2116]
$8B:DFCB A9 4C       LDA #$4C
$8B:DFCD 8D 17 21    STA $2117  [$7E:2117]
$8B:DFD0 A9 80       LDA #$80
$8B:DFD2 8D 15 21    STA $2115  [$7E:2115]
$8B:DFD5 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:DFD9             dx 01,01,18,7FE000,0800
$8B:DFE1 A9 02       LDA #$02
$8B:DFE3 8D 0B 42    STA $420B  [$7E:420B]
$8B:DFE6 C2 30       REP #$30
$8B:DFE8 A9 00 99    LDA #$9900             ;\
$8B:DFEB 85 48       STA $48    [$7E:0048]  ;|
$8B:DFED A9 89 E0    LDA #$E089             ;|
$8B:DFF0 85 47       STA $47    [$7E:0047]  ;} Decompress post-credits Super Metroid icon tiles to $7E:6000
$8B:DFF2 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:DFF6             dl 7E6000              ;/
$8B:DFF9 A9 00 99    LDA #$9900             ;\
$8B:DFFC 85 48       STA $48    [$7E:0048]  ;|
$8B:DFFE A9 C4 EC    LDA #$ECC4             ;|
$8B:E001 85 47       STA $47    [$7E:0047]  ;} Decompress post-credits Super Metroid icon tilemap to $7E:8000
$8B:E003 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:E007             dl 7E8000              ;/
$8B:E00A AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:E00D C9 03 00    CMP #$0003             ;} If [game time hours] < 3:
$8B:E010 10 24       BPL $24    [$E036]     ;/
$8B:E012 E2 30       SEP #$30
$8B:E014 A9 00       LDA #$00
$8B:E016 8D 16 21    STA $2116  [$7E:2116]
$8B:E019 A9 00       LDA #$00
$8B:E01B 8D 17 21    STA $2117  [$7E:2117]
$8B:E01E A9 80       LDA #$80
$8B:E020 8D 15 21    STA $2115  [$7E:2115]
$8B:E023 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:E027             dx 01,01,18,7E2000,4000
$8B:E02F A9 02       LDA #$02
$8B:E031 8D 0B 42    STA $420B  [$7E:420B]
$8B:E034 80 22       BRA $22    [$E058]

$8B:E036 E2 30       SEP #$30
$8B:E038 A9 00       LDA #$00
$8B:E03A 8D 16 21    STA $2116  [$7E:2116]
$8B:E03D A9 00       LDA #$00
$8B:E03F 8D 17 21    STA $2117  [$7E:2117]
$8B:E042 A9 80       LDA #$80
$8B:E044 8D 15 21    STA $2115  [$7E:2115]
$8B:E047 22 A9 91 80 JSL $8091A9[$80:91A9]
$8B:E04B             dx 01,01,18,7F0000,4000
$8B:E053 A9 02       LDA #$02
$8B:E055 8D 0B 42    STA $420B  [$7E:420B]

$8B:E058 C2 30       REP #$30
$8B:E05A A9 00 01    LDA #$0100
$8B:E05D 8D 1B 21    STA $211B  [$7E:211B]
$8B:E060 85 78       STA $78    [$7E:0078]
$8B:E062 9C 1C 21    STZ $211C  [$7E:211C]
$8B:E065 64 7A       STZ $7A    [$7E:007A]
$8B:E067 9C 1D 21    STZ $211D  [$7E:211D]
$8B:E06A 64 7C       STZ $7C    [$7E:007C]
$8B:E06C 8D 1E 21    STA $211E  [$7E:211E]
$8B:E06F 85 7E       STA $7E    [$7E:007E]
$8B:E071 A9 68 00    LDA #$0068
$8B:E074 8D 1F 21    STA $211F  [$7E:211F]
$8B:E077 85 80       STA $80    [$7E:0080]
$8B:E079 A9 70 00    LDA #$0070
$8B:E07C 8D 20 21    STA $2120  [$7E:2120]
$8B:E07F 85 82       STA $82    [$7E:0082]
$8B:E081 A9 F8 FF    LDA #$FFF8
$8B:E084 8D 93 19    STA $1993  [$7E:1993]
$8B:E087 A9 E8 FF    LDA #$FFE8
$8B:E08A 8D 97 19    STA $1997  [$7E:1997]
$8B:E08D 9C 8D 19    STZ $198D  [$7E:198D]
$8B:E090 A9 00 09    LDA #$0900
$8B:E093 8D 8F 19    STA $198F  [$7E:198F]
$8B:E096 22 4B 83 80 JSL $80834B[$80:834B]
$8B:E09A E2 20       SEP #$20
$8B:E09C A9 0F       LDA #$0F
$8B:E09E 85 51       STA $51    [$7E:0051]
$8B:E0A0 C2 20       REP #$20
$8B:E0A2 9C 11 09    STZ $0911  [$7E:0911]
$8B:E0A5 9C 15 09    STZ $0915  [$7E:0915]
$8B:E0A8 22 88 82 88 JSL $888288[$88:8288]
$8B:E0AC A2 FE 01    LDX #$01FE
$8B:E0AF A9 00 00    LDA #$0000

$8B:E0B2 9F 00 98 7E STA $7E9800,x[$7E:99FE]
$8B:E0B6 CA          DEX
$8B:E0B7 CA          DEX
$8B:E0B8 10 F8       BPL $F8    [$E0B2]
$8B:E0BA 20 BB E7    JSR $E7BB  [$8B:E7BB]
$8B:E0BD A9 00 97    LDA #$9700             ;\
$8B:E0C0 85 48       STA $48    [$7E:0048]  ;|
$8B:E0C2 A9 FF EE    LDA #$EEFF             ;|
$8B:E0C5 85 47       STA $47    [$7E:0047]  ;} Decompress credits tilemap to $7F:0000
$8B:E0C7 22 FF B0 80 JSL $80B0FF[$80:B0FF]  ;|
$8B:E0CB             dl 7F0000              ;/
$8B:E0CE A9 7F 00    LDA #$007F
$8B:E0D1 22 CE 95 8B JSL $8B95CE[$8B:95CE]
$8B:E0D5 A9 7F 00    LDA #$007F
$8B:E0D8 20 F9 98    JSR $98F9  [$8B:98F9]
$8B:E0DB 20 E3 98    JSR $98E3  [$8B:98E3]
$8B:E0DE A9 03 00    LDA #$0003
$8B:E0E1 8D 23 07    STA $0723  [$7E:0723]
$8B:E0E4 8D 25 07    STA $0725  [$7E:0725]
$8B:E0E7 A0 F8 F6    LDY #$F6F8
$8B:E0EA 20 32 99    JSR $9932  [$8B:9932]
$8B:E0ED A9 9D DB    LDA #$DB9D
$8B:E0F0 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E0F3 60          RTS
}


;;; $E0F4:  ;;;
{
$8B:E0F4 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:E0F7 F0 02       BEQ $02    [$E0FB]
$8B:E0F9 10 14       BPL $14    [$E10F]

$8B:E0FB A9 10 E1    LDA #$E110
$8B:E0FE 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E101 A9 78 00    LDA #$0078
$8B:E104 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E107 E2 20       SEP #$20
$8B:E109 A9 10       LDA #$10
$8B:E10B 85 69       STA $69    [$7E:0069]
$8B:E10D C2 20       REP #$20

$8B:E10F 60          RTS
}


;;; $E110:  ;;;
{
$8B:E110 22 4D 89 80 JSL $80894D[$80:894D]
$8B:E114 E2 20       SEP #$20
$8B:E116 A5 51       LDA $51    [$7E:0051]
$8B:E118 C9 0F       CMP #$0F
$8B:E11A F0 03       BEQ $03    [$E11F]
$8B:E11C C2 20       REP #$20
$8B:E11E 60          RTS

$8B:E11F E2 20       SEP #$20
$8B:E121 A9 02       LDA #$02
$8B:E123 85 69       STA $69    [$7E:0069]
$8B:E125 A9 10       LDA #$10
$8B:E127 85 6B       STA $6B    [$7E:006B]
$8B:E129 A9 02       LDA #$02
$8B:E12B 85 6F       STA $6F    [$7E:006F]
$8B:E12D A9 22       LDA #$22
$8B:E12F 85 72       STA $72    [$7E:0072]
$8B:E131 C2 20       REP #$20
$8B:E133 9C 23 07    STZ $0723  [$7E:0723]
$8B:E136 9C 25 07    STZ $0725  [$7E:0725]
$8B:E139 20 E9 8B    JSR $8BE9  [$8B:8BE9]  ; Copy current palettes to fading palettes
$8B:E13C 20 09 8C    JSR $8C09  [$8B:8C09]  ; Decompose fading palette data
$8B:E13F A2 40 00    LDX #$0040             ;\
$8B:E142 A0 10 00    LDY #$0010             ;} Clear fading BG palette 2
$8B:E145 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:E148 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes
$8B:E14B A9 20 00    LDA #$0020
$8B:E14E 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E151 A9 58 E1    LDA #$E158
$8B:E154 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E157 60          RTS
}


;;; $E158:  ;;;
{
$8B:E158 A2 40 00    LDX #$0040             ;\
$8B:E15B A0 10 00    LDY #$0010             ;} Fade in BG palette 2
$8B:E15E 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:E161 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes
$8B:E164 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:E167 F0 02       BEQ $02    [$E16B]
$8B:E169 10 24       BPL $24    [$E18F]

$8B:E16B E2 20       SEP #$20
$8B:E16D A9 12       LDA #$12
$8B:E16F 85 69       STA $69    [$7E:0069]
$8B:E171 A9 04       LDA #$04
$8B:E173 85 6B       STA $6B    [$7E:006B]
$8B:E175 A9 02       LDA #$02
$8B:E177 85 6F       STA $6F    [$7E:006F]
$8B:E179 A9 02       LDA #$02
$8B:E17B 85 72       STA $72    [$7E:0072]
$8B:E17D C2 20       REP #$20
$8B:E17F A9 B4 00    LDA #$00B4
$8B:E182 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E185 A9 90 E1    LDA #$E190
$8B:E188 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E18B 22 3B EC 88 JSL $88EC3B[$88:EC3B]

$8B:E18F 60          RTS
}


;;; $E190:  ;;;
{
; Deer force
$8B:E190 A5 BB       LDA $BB    [$7E:00BB]
$8B:E192 18          CLC
$8B:E193 69 02 00    ADC #$0002
$8B:E196 85 BB       STA $BB    [$7E:00BB]
$8B:E198 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:E19B F0 02       BEQ $02    [$E19F]
$8B:E19D 10 32       BPL $32    [$E1D1]

$8B:E19F A2 00 00    LDX #$0000

$8B:E1A2 BF 9B DC 8C LDA $8CDC9B,x[$8C:DC9B]
$8B:E1A6 9F 40 32 7E STA $7E3240,x[$7E:3240]
$8B:E1AA E8          INX
$8B:E1AB E8          INX
$8B:E1AC E0 40 02    CPX #$0240
$8B:E1AF 30 F1       BMI $F1    [$E1A2]
$8B:E1B1 20 06 88    JSR $8806  [$8B:8806]
$8B:E1B4 E2 20       SEP #$20
$8B:E1B6 A9 01       LDA #$01
$8B:E1B8 85 69       STA $69    [$7E:0069]
$8B:E1BA 64 6B       STZ $6B    [$7E:006B]
$8B:E1BC 64 6F       STZ $6F    [$7E:006F]
$8B:E1BE 64 72       STZ $72    [$7E:0072]
$8B:E1C0 C2 20       REP #$20
$8B:E1C2 A9 B4 00    LDA #$00B4
$8B:E1C5 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E1C8 A9 D2 E1    LDA #$E1D2
$8B:E1CB 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E1CE 9C 9C 0D    STZ $0D9C  [$7E:0D9C]

$8B:E1D1 60          RTS
}


;;; $E1D2:  ;;;
{
$8B:E1D2 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:E1D5 F0 03       BEQ $03    [$E1DA]
$8B:E1D7 4C 64 E2    JMP $E264  [$8B:E264]

$8B:E1DA A9 7F 00    LDA #$007F
$8B:E1DD 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E1E0 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:E1E3 C9 03 00    CMP #$0003             ;} If [game time hours] < 3: go to BRANCH_BEST_ENDING
$8B:E1E6 30 44       BMI $44    [$E22C]     ;/
$8B:E1E8 C9 0A 00    CMP #$000A             ;\
$8B:E1EB 30 22       BMI $22    [$E20F]     ;} If [game time hours] < 10: go to BRANCH_MEDIOCRE_ENDING
$8B:E1ED A0 4B EF    LDY #$EF4B             ;\
$8B:E1F0 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF4B
$8B:E1F3 A0 45 EF    LDY #$EF45             ;\
$8B:E1F6 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF45
$8B:E1F9 A9 93 E2    LDA #$E293
$8B:E1FC 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E1FF E2 20       SEP #$20
$8B:E201 A9 10       LDA #$10
$8B:E203 85 69       STA $69    [$7E:0069]
$8B:E205 64 6B       STZ $6B    [$7E:006B]
$8B:E207 64 6F       STZ $6F    [$7E:006F]
$8B:E209 64 72       STZ $72    [$7E:0072]
$8B:E20B C2 20       REP #$20
$8B:E20D 80 55       BRA $55    [$E264]

; BRANCH_MEDIOCRE_ENDING
$8B:E20F 20 E9 8B    JSR $8BE9  [$8B:8BE9]  ; Copy current palettes to fading palettes
$8B:E212 20 09 8C    JSR $8C09  [$8B:8C09]  ; Decompose fading palette data
$8B:E215 A0 51 EF    LDY #$EF51             ;\
$8B:E218 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF51
$8B:E21B A0 45 EF    LDY #$EF45             ;\
$8B:E21E 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF45
$8B:E221 A2 C0 01    LDX #$01C0             ;\
$8B:E224 A0 10 00    LDY #$0010             ;} Clear fading sprite palette 6
$8B:E227 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:E22A 80 12       BRA $12    [$E23E]     ; Go to BRANCH_NOT_WORST_ENDING

; BRANCH_BEST_ENDING
$8B:E22C 20 E9 8B    JSR $8BE9  [$8B:8BE9]  ; Copy current palettes to fading palettes
$8B:E22F 20 09 8C    JSR $8C09  [$8B:8C09]  ; Decompose fading palette data
$8B:E232 A0 27 EF    LDY #$EF27             ;\
$8B:E235 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF27
$8B:E238 A0 2D EF    LDY #$EF2D             ;\
$8B:E23B 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF2D

; BRANCH_NOT_WORST_ENDING
$8B:E23E A2 A0 01    LDX #$01A0             ;\
$8B:E241 A0 10 00    LDY #$0010             ;} Clear fading sprite palette 5
$8B:E244 20 5E 8C    JSR $8C5E  [$8B:8C5E]  ;/
$8B:E247 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes
$8B:E24A E2 20       SEP #$20
$8B:E24C A9 02       LDA #$02
$8B:E24E 85 69       STA $69    [$7E:0069]
$8B:E250 A9 10       LDA #$10
$8B:E252 85 6B       STA $6B    [$7E:006B]
$8B:E254 A9 02       LDA #$02
$8B:E256 85 6F       STA $6F    [$7E:006F]
$8B:E258 A9 22       LDA #$22
$8B:E25A 85 72       STA $72    [$7E:0072]
$8B:E25C C2 20       REP #$20
$8B:E25E A9 65 E2    LDA #$E265
$8B:E261 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:E264 60          RTS
}


;;; $E265:  ;;;
{
$8B:E265 AD 49 1A    LDA $1A49  [$7E:1A49]
$8B:E268 89 03 00    BIT #$0003
$8B:E26B D0 26       BNE $26    [$E293]
$8B:E26D A2 40 00    LDX #$0040             ;\
$8B:E270 A0 10 00    LDY #$0010             ;} Fade out BG palette 2
$8B:E273 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:E276 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:E279 C9 03 00    CMP #$0003             ;} If [game time hours] >= 3:
$8B:E27C 30 09       BMI $09    [$E287]     ;/
$8B:E27E A2 C0 01    LDX #$01C0             ;\
$8B:E281 A0 10 00    LDY #$0010             ;} Fade in sprite palette 6
$8B:E284 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/

$8B:E287 A2 A0 01    LDX #$01A0             ;\
$8B:E28A A0 10 00    LDY #$0010             ;} Fade in sprite palette 5
$8B:E28D 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:E290 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes

$8B:E293 AD 49 1A    LDA $1A49  [$7E:1A49]
$8B:E296 3A          DEC A
$8B:E297 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E29A C9 41 00    CMP #$0041
$8B:E29D 10 3D       BPL $3D    [$E2DC]
$8B:E29F A2 3E 02    LDX #$023E
$8B:E2A2 A9 7F 00    LDA #$007F

$8B:E2A5 9F 40 32 7E STA $7E3240,x[$7E:347E]
$8B:E2A9 CA          DEX
$8B:E2AA CA          DEX
$8B:E2AB 10 F8       BPL $F8    [$E2A5]
$8B:E2AD A2 00 00    LDX #$0000

$8B:E2B0 BF DB DE 8C LDA $8CDEDB,x[$8C:DEDB]
$8B:E2B4 9F 00 33 7E STA $7E3300,x[$7E:3300]
$8B:E2B8 E8          INX
$8B:E2B9 E8          INX
$8B:E2BA E0 80 00    CPX #$0080
$8B:E2BD 30 F1       BMI $F1    [$E2B0]
$8B:E2BF 20 06 88    JSR $8806  [$8B:8806]
$8B:E2C2 E2 20       SEP #$20
$8B:E2C4 A9 01       LDA #$01
$8B:E2C6 85 69       STA $69    [$7E:0069]
$8B:E2C8 64 6B       STZ $6B    [$7E:006B]
$8B:E2CA 64 6F       STZ $6F    [$7E:006F]
$8B:E2CC 64 72       STZ $72    [$7E:0072]
$8B:E2CE C2 20       REP #$20
$8B:E2D0 A9 B4 00    LDA #$00B4
$8B:E2D3 8D 4B 1A    STA $1A4B  [$7E:1A4B]
$8B:E2D6 A9 DD E2    LDA #$E2DD
$8B:E2D9 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:E2DC 60          RTS
}


;;; $E2DD:  ;;;
{
$8B:E2DD CE 4B 1A    DEC $1A4B  [$7E:1A4B]
$8B:E2E0 F0 02       BEQ $02    [$E2E4]
$8B:E2E2 10 2F       BPL $2F    [$E313]

$8B:E2E4 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:E2E7 C9 03 00    CMP #$0003             ;} >_<;
$8B:E2EA 30 0D       BMI $0D    [$E2F9]     ;/
$8B:E2EC C9 0A 00    CMP #$000A             ;\
$8B:E2EF 30 08       BMI $08    [$E2F9]     ;} If [game time hours] >= 10:
$8B:E2F1 A9 42 E3    LDA #$E342
$8B:E2F4 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E2F7 80 1A       BRA $1A    [$E313]

$8B:E2F9 E2 20       SEP #$20
$8B:E2FB A9 02       LDA #$02
$8B:E2FD 85 69       STA $69    [$7E:0069]
$8B:E2FF A9 10       LDA #$10
$8B:E301 85 6B       STA $6B    [$7E:006B]
$8B:E303 A9 02       LDA #$02
$8B:E305 85 6F       STA $6F    [$7E:006F]
$8B:E307 A9 22       LDA #$22
$8B:E309 85 72       STA $72    [$7E:0072]
$8B:E30B C2 20       REP #$20
$8B:E30D A9 14 E3    LDA #$E314
$8B:E310 8D 51 1F    STA $1F51  [$7E:1F51]

$8B:E313 60          RTS
}


;;; $E314:  ;;;
{
$8B:E314 AD 49 1A    LDA $1A49  [$7E:1A49]
$8B:E317 89 03 00    BIT #$0003
$8B:E31A D0 26       BNE $26    [$E342]
$8B:E31C A2 40 00    LDX #$0040             ;\
$8B:E31F A0 10 00    LDY #$0010             ;} Fade out BG palette 2
$8B:E322 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:E325 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:E328 C9 03 00    CMP #$0003             ;} If [game time hours] >= 3:
$8B:E32B 30 09       BMI $09    [$E336]     ;/
$8B:E32D A2 C0 01    LDX #$01C0             ;\
$8B:E330 A0 10 00    LDY #$0010             ;} Fade in sprite palette 6
$8B:E333 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/

$8B:E336 A2 A0 01    LDX #$01A0             ;\
$8B:E339 A0 10 00    LDY #$0010             ;} Fade in sprite palette 5
$8B:E33C 20 B2 8C    JSR $8CB2  [$8B:8CB2]  ;/
$8B:E33F 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes

$8B:E342 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:E345 10 66       BPL $66    [$E3AD]
$8B:E347 E2 20       SEP #$20
$8B:E349 A9 10       LDA #$10
$8B:E34B 85 69       STA $69    [$7E:0069]
$8B:E34D 64 6B       STZ $6B    [$7E:006B]
$8B:E34F 64 6F       STZ $6F    [$7E:006F]
$8B:E351 64 72       STZ $72    [$7E:0072]
$8B:E353 A9 07       LDA #$07
$8B:E355 85 55       STA $55    [$7E:0055]
$8B:E357 A9 80       LDA #$80
$8B:E359 85 5F       STA $5F    [$7E:005F]
$8B:E35B A9 00       LDA #$00
$8B:E35D 85 58       STA $58    [$7E:0058]
$8B:E35F 64 5D       STZ $5D    [$7E:005D]
$8B:E361 C2 20       REP #$20
$8B:E363 A9 9D DB    LDA #$DB9D
$8B:E366 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E369 9C 4D 1A    STZ $1A4D  [$7E:1A4D]
$8B:E36C AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:E36F C9 03 00    CMP #$0003             ;} If [game time hours] < 3: go to BRANCH_BEST_ENDING
$8B:E372 30 2D       BMI $2D    [$E3A1]     ;/
$8B:E374 C9 0A 00    CMP #$000A             ;\
$8B:E377 30 14       BMI $14    [$E38D]     ;} If [game time hours] < 10: go to BRANCH_MEDIOCRE_ENDING
$8B:E379 A0 63 EF    LDY #$EF63             ;\
$8B:E37C 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF63
$8B:E37F A0 5D EF    LDY #$EF5D             ;\
$8B:E382 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF5D
$8B:E385 A0 57 EF    LDY #$EF57             ;\
$8B:E388 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF57
$8B:E38B 80 20       BRA $20    [$E3AD]     ; Return

; BRANCH_MEDIOCRE_ENDING
$8B:E38D A0 69 EF    LDY #$EF69             ;\
$8B:E390 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF69
$8B:E393 A0 5D EF    LDY #$EF5D             ;\
$8B:E396 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF5D
$8B:E399 A0 57 EF    LDY #$EF57             ;\
$8B:E39C 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF57
$8B:E39F 80 0C       BRA $0C    [$E3AD]     ; Return

; BRANCH_BEST_ENDING
$8B:E3A1 A0 33 EF    LDY #$EF33             ;\
$8B:E3A4 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF33
$8B:E3A7 A0 39 EF    LDY #$EF39             ;\
$8B:E3AA 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF39

$8B:E3AD 60          RTS
}


;;; $E3AE:  ;;;
{
$8B:E3AE AD 4D 1A    LDA $1A4D  [$7E:1A4D]
$8B:E3B1 F0 15       BEQ $15    [$E3C8]
$8B:E3B3 3A          DEC A
$8B:E3B4 8D 4D 1A    STA $1A4D  [$7E:1A4D]
$8B:E3B7 A2 80 01    LDX #$0180             ;\
$8B:E3BA A0 10 00    LDY #$0010             ;} Fade out sprite palette 4
$8B:E3BD 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:E3C0 AD 49 1A    LDA $1A49  [$7E:1A49]
$8B:E3C3 F0 03       BEQ $03    [$E3C8]
$8B:E3C5 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes

$8B:E3C8 AD 49 1A    LDA $1A49  [$7E:1A49]
$8B:E3CB F0 06       BEQ $06    [$E3D3]
$8B:E3CD 3A          DEC A
$8B:E3CE 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E3D1 80 03       BRA $03    [$E3D6]

$8B:E3D3 20 09 E4    JSR $E409  [$8B:E409]

$8B:E3D6 AD 8D 19    LDA $198D  [$7E:198D]
$8B:E3D9 38          SEC
$8B:E3DA E9 08 00    SBC #$0008
$8B:E3DD 29 FF 00    AND #$00FF
$8B:E3E0 8D 8D 19    STA $198D  [$7E:198D]
$8B:E3E3 AD 8F 19    LDA $198F  [$7E:198F]
$8B:E3E6 38          SEC
$8B:E3E7 E9 40 00    SBC #$0040
$8B:E3EA 8D 8F 19    STA $198F  [$7E:198F]
$8B:E3ED C9 18 00    CMP #$0018
$8B:E3F0 30 01       BMI $01    [$E3F3]
$8B:E3F2 60          RTS

$8B:E3F3 A9 18 00    LDA #$0018
$8B:E3F6 8D 8F 19    STA $198F  [$7E:198F]
$8B:E3F9 A9 8A E4    LDA #$E48A
$8B:E3FC 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E3FF A9 B4 00    LDA #$00B4
$8B:E402 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E405 9C 4D 1A    STZ $1A4D  [$7E:1A4D]
$8B:E408 60          RTS
}


;;; $E409:  ;;;
{
$8B:E409 AD 4F 1A    LDA $1A4F  [$7E:1A4F]
$8B:E40C F0 10       BEQ $10    [$E41E]
$8B:E40E 3A          DEC A
$8B:E40F 8D 4F 1A    STA $1A4F  [$7E:1A4F]
$8B:E412 A2 E0 01    LDX #$01E0             ;\
$8B:E415 A0 10 00    LDY #$0010             ;} Fade out sprite palette 7
$8B:E418 20 83 8C    JSR $8C83  [$8B:8C83]  ;/
$8B:E41B 20 EA 8C    JSR $8CEA  [$8B:8CEA]  ; Compose fading palettes

$8B:E41E 60          RTS
}


;;; $E41F:  ;;;
{
$8B:E41F AD 4F 1A    LDA $1A4F  [$7E:1A4F]
$8B:E422 D0 08       BNE $08    [$E42C]
$8B:E424 AD 4D 1A    LDA $1A4D  [$7E:1A4D]
$8B:E427 C9 06 00    CMP #$0006
$8B:E42A 30 01       BMI $01    [$E42D]

$8B:E42C 60          RTS

$8B:E42D 0A          ASL A
$8B:E42E 0A          ASL A
$8B:E42F 0A          ASL A
$8B:E430 A8          TAY
$8B:E431 AE 30 03    LDX $0330  [$7E:0330]
$8B:E434 B9 5A E4    LDA $E45A,y[$8B:E45A]
$8B:E437 95 D0       STA $D0,x  [$7E:00D0]
$8B:E439 E8          INX
$8B:E43A E8          INX
$8B:E43B B9 5C E4    LDA $E45C,y[$8B:E45C]
$8B:E43E 95 D0       STA $D0,x  [$7E:00D2]
$8B:E440 E8          INX
$8B:E441 E8          INX
$8B:E442 E2 20       SEP #$20
$8B:E444 B9 5E E4    LDA $E45E,y[$8B:E45E]
$8B:E447 95 D0       STA $D0,x  [$7E:00D4]
$8B:E449 C2 20       REP #$20
$8B:E44B E8          INX
$8B:E44C B9 60 E4    LDA $E460,y[$8B:E460]
$8B:E44F 95 D0       STA $D0,x  [$7E:00D5]
$8B:E451 E8          INX
$8B:E452 E8          INX
$8B:E453 8E 30 03    STX $0330  [$7E:0330]
$8B:E456 EE 4D 1A    INC $1A4D  [$7E:1A4D]
$8B:E459 60          RTS

$8B:E45A             dx 0400,7FD000,00,4800,
                        0800,7E6000,00,6000,
                        0800,7E6800,00,6400,
                        0800,7E7000,00,6800,
                        0800,7E7800,00,6C00,
                        0800,7E8000,00,5400
}


;;; $E48A:  ;;;
{
$8B:E48A 20 09 E4    JSR $E409  [$8B:E409]
$8B:E48D 20 1F E4    JSR $E41F  [$8B:E41F]
$8B:E490 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:E493 F0 01       BEQ $01    [$E496]
$8B:E495 60          RTS

$8B:E496 E2 20       SEP #$20
$8B:E498 A9 01       LDA #$01
$8B:E49A 85 55       STA $55    [$7E:0055]
$8B:E49C A9 11       LDA #$11
$8B:E49E 85 69       STA $69    [$7E:0069]
$8B:E4A0 64 6B       STZ $6B    [$7E:006B]
$8B:E4A2 64 6F       STZ $6F    [$7E:006F]
$8B:E4A4 A9 31       LDA #$31
$8B:E4A6 85 72       STA $72    [$7E:0072]
$8B:E4A8 A9 3F       LDA #$3F
$8B:E4AA 85 74       STA $74    [$7E:0074]
$8B:E4AC A9 5F       LDA #$5F
$8B:E4AE 85 75       STA $75    [$7E:0075]
$8B:E4B0 A9 9F       LDA #$9F
$8B:E4B2 85 76       STA $76    [$7E:0076]
$8B:E4B4 64 5F       STZ $5F    [$7E:005F]
$8B:E4B6 A9 4E       LDA #$4E
$8B:E4B8 85 58       STA $58    [$7E:0058]
$8B:E4BA A9 54       LDA #$54
$8B:E4BC 85 5D       STA $5D    [$7E:005D]
$8B:E4BE C2 20       REP #$20
$8B:E4C0 A2 80 01    LDX #$0180

$8B:E4C3 BF E9 E7 8C LDA $8CE7E9,x[$8C:E969]
$8B:E4C7 9F 00 C0 7E STA $7EC000,x[$7E:C180]
$8B:E4CB E8          INX
$8B:E4CC E8          INX
$8B:E4CD E0 A0 01    CPX #$01A0
$8B:E4D0 30 F1       BMI $F1    [$E4C3]
$8B:E4D2 9C 93 19    STZ $1993  [$7E:1993]
$8B:E4D5 9C 97 19    STZ $1997  [$7E:1997]
$8B:E4D8 A9 04 E5    LDA #$E504
$8B:E4DB 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E4DE A9 20 00    LDA #$0020
$8B:E4E1 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E4E4 22 A2 95 8B JSL $8B95A2[$8B:95A2]
$8B:E4E8 22 B8 95 8B JSL $8B95B8[$8B:95B8]  ; Enable cinematic BG tilemap updates
$8B:E4EC A9 00 4C    LDA #$4C00
$8B:E4EF 8D F5 19    STA $19F5  [$7E:19F5]
$8B:E4F2 A2 7E 00    LDX #$007E
$8B:E4F5 A9 7F 00    LDA #$007F

$8B:E4F8 9F 00 33 7E STA $7E3300,x[$7E:337E]
$8B:E4FC CA          DEX
$8B:E4FD CA          DEX
$8B:E4FE 10 F8       BPL $F8    [$E4F8]
$8B:E500 20 06 88    JSR $8806  [$8B:8806]
$8B:E503 60          RTS
}


;;; $E504:  ;;;
{
$8B:E504 E2 20       SEP #$20
$8B:E506 A5 74       LDA $74    [$7E:0074]
$8B:E508 38          SEC
$8B:E509 E9 01       SBC #$01
$8B:E50B 85 74       STA $74    [$7E:0074]
$8B:E50D C9 20       CMP #$20
$8B:E50F 10 04       BPL $04    [$E515]
$8B:E511 A9 20       LDA #$20
$8B:E513 85 74       STA $74    [$7E:0074]

$8B:E515 A5 75       LDA $75    [$7E:0075]
$8B:E517 38          SEC
$8B:E518 E9 01       SBC #$01
$8B:E51A 85 75       STA $75    [$7E:0075]
$8B:E51C C9 40       CMP #$40
$8B:E51E 10 04       BPL $04    [$E524]
$8B:E520 A9 40       LDA #$40
$8B:E522 85 75       STA $75    [$7E:0075]

$8B:E524 A5 76       LDA $76    [$7E:0076]
$8B:E526 38          SEC
$8B:E527 E9 01       SBC #$01
$8B:E529 85 76       STA $76    [$7E:0076]
$8B:E52B C9 80       CMP #$80
$8B:E52D 10 04       BPL $04    [$E533]
$8B:E52F A9 80       LDA #$80
$8B:E531 85 76       STA $76    [$7E:0076]

$8B:E533 C2 20       REP #$20
$8B:E535 CE 49 1A    DEC $1A49  [$7E:1A49]
$8B:E538 F0 02       BEQ $02    [$E53C]
$8B:E53A 10 4D       BPL $4D    [$E589]

$8B:E53C A9 BA E7    LDA #$E7BA
$8B:E53F 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E542 A9 00 50    LDA #$5000
$8B:E545 8D F5 19    STA $19F5  [$7E:19F5]
$8B:E548 20 06 88    JSR $8806  [$8B:8806]
$8B:E54B A9 00 01    LDA #$0100
$8B:E54E 8D 11 09    STA $0911  [$7E:0911]
$8B:E551 8D 15 09    STA $0915  [$7E:0915]
$8B:E554 A0 81 EF    LDY #$EF81             ;\
$8B:E557 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF81
$8B:E55A A0 87 EF    LDY #$EF87             ;\
$8B:E55D 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF87
$8B:E560 A0 8D EF    LDY #$EF8D             ;\
$8B:E563 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF8D
$8B:E566 A0 93 EF    LDY #$EF93             ;\
$8B:E569 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF93
$8B:E56C A2 1E 00    LDX #$001E
$8B:E56F A9 00 00    LDA #$0000

$8B:E572 9F 20 C0 7E STA $7EC020,x[$7E:C03E]
$8B:E576 CA          DEX
$8B:E577 CA          DEX
$8B:E578 10 F8       BPL $F8    [$E572]
$8B:E57A A2 1E 00    LDX #$001E

$8B:E57D BF E9 EF 8C LDA $8CEFE9,x[$8C:F007]
$8B:E581 9F E0 C1 7E STA $7EC1E0,x[$7E:C1FE]
$8B:E585 CA          DEX
$8B:E586 CA          DEX
$8B:E587 10 F4       BPL $F4    [$E57D]

$8B:E589 60          RTS
}


;;; $E58A:  ;;;
{
; Handles palette transition to greyscale of Super Metroid icon
$8B:E58A DA          PHX
$8B:E58B 5A          PHY
$8B:E58C 8B          PHB
$8B:E58D AD 49 1A    LDA $1A49  [$7E:1A49]
$8B:E590 0A          ASL A
$8B:E591 0A          ASL A
$8B:E592 AA          TAX
$8B:E593 BD E9 E5    LDA $E5E9,x[$8B:E5E9]
$8B:E596 48          PHA
$8B:E597 BD E7 E5    LDA $E5E7,x[$8B:E5E7]
$8B:E59A A8          TAY
$8B:E59B F4 00 8C    PEA $8C00
$8B:E59E AB          PLB
$8B:E59F AB          PLB
$8B:E5A0 A2 1E 00    LDX #$001E

$8B:E5A3 B9 00 00    LDA $0000,y[$8C:F3E7]
$8B:E5A6 9F 20 C0 7E STA $7EC020,x[$7E:C03E]
$8B:E5AA 88          DEY
$8B:E5AB 88          DEY
$8B:E5AC CA          DEX
$8B:E5AD CA          DEX
$8B:E5AE 10 F3       BPL $F3    [$E5A3]
$8B:E5B0 7A          PLY
$8B:E5B1 A2 1E 00    LDX #$001E

$8B:E5B4 B9 00 00    LDA $0000,y[$8C:F007]
$8B:E5B7 9F E0 C1 7E STA $7EC1E0,x[$7E:C1FE]
$8B:E5BB 88          DEY
$8B:E5BC 88          DEY
$8B:E5BD CA          DEX
$8B:E5BE CA          DEX
$8B:E5BF 10 F3       BPL $F3    [$E5B4]
$8B:E5C1 AD 49 1A    LDA $1A49  [$7E:1A49]
$8B:E5C4 1A          INC A
$8B:E5C5 8D 49 1A    STA $1A49  [$7E:1A49]
$8B:E5C8 C9 10 00    CMP #$0010
$8B:E5CB 30 16       BMI $16    [$E5E3]
$8B:E5CD A9 BA E7    LDA #$E7BA
$8B:E5D0 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E5D3 20 DA 93    JSR $93DA  [$8B:93DA]  ; Clear cinematic sprite objects
$8B:E5D6 AB          PLB
$8B:E5D7 A0 4E F7    LDY #$F74E             ;\
$8B:E5DA A9 00 4C    LDA #$4C00             ;} Spawn item percentage cinematic BG object for VRAM $4C00
$8B:E5DD 20 F0 95    JSR $95F0  [$8B:95F0]  ;/
$8B:E5E0 7A          PLY
$8B:E5E1 FA          PLX
$8B:E5E2 60          RTS

$8B:E5E3 AB          PLB
$8B:E5E4 7A          PLY
$8B:E5E5 FA          PLX
$8B:E5E6 60          RTS

$8B:E5E7             dw F3E7,F007, F3C7,F027, F3A7,F047, F387,F067, F367,F087, F347,F0A7, F327,F0C7, F307,F0E7,
                        F2E7,F107, F2C7,F127, F2A7,F147, F287,F167, F267,F187, F247,F1A7, F227,F1C7, F207,F1E7
}


;;; $E627: Item percentage count ;;;
{
$8B:E627 08          PHP
$8B:E628 8B          PHB
$8B:E629 4B          PHK                    ;\
$8B:E62A AB          PLB                    ;} DB = $8B
$8B:E62B C2 30       REP #$30
$8B:E62D DA          PHX
$8B:E62E 5A          PHY
$8B:E62F A2 08 00    LDX #$0008             ; X = 8 (tank index)
$8B:E632 64 12       STZ $12    [$7E:0012]  ; $12 = 0 (percentage)

; LOOP_TANKS
$8B:E634 BD 0D E7    LDA $E70D,x[$8B:E715]  ;\
$8B:E637 A8          TAY                    ;|
$8B:E638 B9 00 00    LDA $0000,y[$7E:09D0]  ;|
$8B:E63B 8D 04 42    STA $4204  [$7E:4204]  ;|
$8B:E63E E2 20       SEP #$20               ;|
$8B:E640 BD 17 E7    LDA $E717,x[$8B:E71F]  ;|
$8B:E643 8D 06 42    STA $4206  [$7E:4206]  ;|
$8B:E646 EA          NOP                    ;|
$8B:E647 EA          NOP                    ;|
$8B:E648 EA          NOP                    ;} $12 += [[$E70D + [X]]] / [$E717 + [X]]
$8B:E649 EA          NOP                    ;|
$8B:E64A EA          NOP                    ;|
$8B:E64B EA          NOP                    ;|
$8B:E64C EA          NOP                    ;|
$8B:E64D C2 20       REP #$20               ;|
$8B:E64F AD 14 42    LDA $4214  [$7E:4214]  ;|
$8B:E652 18          CLC                    ;|
$8B:E653 65 12       ADC $12    [$7E:0012]  ;|
$8B:E655 85 12       STA $12    [$7E:0012]  ;/
$8B:E657 CA          DEX                    ;\
$8B:E658 CA          DEX                    ;} X -= 2
$8B:E659 10 D9       BPL $D9    [$E634]     ; If [X] >= 0: go to LOOP_TANKS
$8B:E65B A2 14 00    LDX #$0014             ; X = 14h (item index)

; LOOP_ITEMS
$8B:E65E AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$8B:E661 3C 21 E7    BIT $E721,x[$8B:E735]  ;} If [collected items] & [$E721 + [X]] != 0:
$8B:E664 F0 02       BEQ $02    [$E668]     ;/
$8B:E666 E6 12       INC $12    [$7E:0012]  ; Increment $12

$8B:E668 CA          DEX                    ;\
$8B:E669 CA          DEX                    ;} X -= 2
$8B:E66A 10 F2       BPL $F2    [$E65E]     ; If [X] >= 0: go to LOOP_ITEMS
$8B:E66C A2 08 00    LDX #$0008             ; X = 8 (beam index)

; LOOP_BEAMS
$8B:E66F AD A8 09    LDA $09A8  [$7E:09A8]  ;\
$8B:E672 3C 37 E7    BIT $E737,x[$8B:E73F]  ;} If [collected beams] & [$E737 + [X]] != 0:
$8B:E675 F0 02       BEQ $02    [$E679]     ;/
$8B:E677 E6 12       INC $12    [$7E:0012]  ; Increment $12

$8B:E679 CA          DEX                    ;\
$8B:E67A CA          DEX                    ;} X -= 2
$8B:E67B 10 F2       BPL $F2    [$E66F]     ; If [X] >= 0: go to LOOP_BEAMS
$8B:E67D A5 12       LDA $12    [$7E:0012]  ;\
$8B:E67F 8D 04 42    STA $4204  [$7E:4204]  ;|
$8B:E682 E2 20       SEP #$20               ;|
$8B:E684 A9 0A       LDA #$0A               ;|
$8B:E686 8D 06 42    STA $4206  [$7E:4206]  ;|
$8B:E689 EA          NOP                    ;|
$8B:E68A EA          NOP                    ;|
$8B:E68B EA          NOP                    ;|
$8B:E68C EA          NOP                    ;} $16 = [$12] % 10 (units)
$8B:E68D EA          NOP                    ;|
$8B:E68E EA          NOP                    ;|
$8B:E68F EA          NOP                    ;|
$8B:E690 C2 20       REP #$20               ;|
$8B:E692 AD 14 42    LDA $4214  [$7E:4214]  ;|
$8B:E695 8D 04 42    STA $4204  [$7E:4204]  ;|
$8B:E698 AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:E69B 85 16       STA $16    [$7E:0016]  ;/
$8B:E69D E2 20       SEP #$20
$8B:E69F A9 0A       LDA #$0A               ;\
$8B:E6A1 8D 06 42    STA $4206  [$7E:4206]  ;|
$8B:E6A4 EA          NOP                    ;|
$8B:E6A5 EA          NOP                    ;|
$8B:E6A6 EA          NOP                    ;|
$8B:E6A7 EA          NOP                    ;|
$8B:E6A8 EA          NOP                    ;} $12 = [$12] / 100 (hundreds)
$8B:E6A9 EA          NOP                    ;|
$8B:E6AA EA          NOP                    ;|
$8B:E6AB C2 20       REP #$20               ;|
$8B:E6AD AD 14 42    LDA $4214  [$7E:4214]  ;|
$8B:E6B0 85 12       STA $12    [$7E:0012]  ;/
$8B:E6B2 AD 16 42    LDA $4216  [$7E:4216]  ;\
$8B:E6B5 85 14       STA $14    [$7E:0014]  ;} $14 = [$12] / 10 % 10 (tens)
$8B:E6B7 A5 12       LDA $12    [$7E:0012]  ;\
$8B:E6B9 F0 11       BEQ $11    [$E6CC]     ;} If [$12] != 0: (display hundreds)
$8B:E6BB 0A          ASL A                  ;\
$8B:E6BC 0A          ASL A                  ;|
$8B:E6BD A8          TAY                    ;} $7E:339C = [$E741 + [$12] * 4] (draw hundreds top half)
$8B:E6BE B9 41 E7    LDA $E741,y[$8B:E745]  ;|
$8B:E6C1 8F 9C 33 7E STA $7E339C[$7E:339C]  ;/
$8B:E6C5 B9 43 E7    LDA $E743,y[$8B:E747]  ;\
$8B:E6C8 8F DC 33 7E STA $7E33DC[$7E:33DC]  ;} $7E:33DC = [$E741 + [$12] * 4 + 2] (draw hundreds bottom half)

$8B:E6CC A5 14       LDA $14    [$7E:0014]  ;\
$8B:E6CE D0 06       BNE $06    [$E6D6]     ;} If [$14] = 0:
$8B:E6D0 A5 12       LDA $12    [$7E:0012]  ;\
$8B:E6D2 F0 13       BEQ $13    [$E6E7]     ;} If [$12] = 0: go to BRANCH_UNITS_ONLY
$8B:E6D4 A5 14       LDA $14    [$7E:0014]  ;/

$8B:E6D6 0A          ASL A                  ;\
$8B:E6D7 0A          ASL A                  ;|
$8B:E6D8 A8          TAY                    ;} $7E:339C + 2 = [$E741 + [$14] * 4] (draw tens top half)
$8B:E6D9 B9 41 E7    LDA $E741,y[$8B:E741]  ;|
$8B:E6DC 8F 9E 33 7E STA $7E339E[$7E:339E]  ;/
$8B:E6E0 B9 43 E7    LDA $E743,y[$8B:E743]  ;\
$8B:E6E3 8F DE 33 7E STA $7E33DE[$7E:33DE]  ;} $7E:33DC + 2 = [$E741 + [$14] * 4 + 2] (draw tens bottom half)

; BRANCH_UNITS_ONLY
$8B:E6E7 A5 16       LDA $16    [$7E:0016]  ;\
$8B:E6E9 0A          ASL A                  ;|
$8B:E6EA 0A          ASL A                  ;|
$8B:E6EB A8          TAY                    ;} $7E:339C + 4 = [$E741 + [$16] * 4] (draw units top half)
$8B:E6EC B9 41 E7    LDA $E741,y[$8B:E741]  ;|
$8B:E6EF 8F A0 33 7E STA $7E33A0[$7E:33A0]  ;/
$8B:E6F3 B9 43 E7    LDA $E743,y[$8B:E743]  ;\
$8B:E6F6 8F E0 33 7E STA $7E33E0[$7E:33E0]  ;} $7E:33DC + 4 = [$E741 + [$16] * 4 + 2] (draw units bottom half)
$8B:E6FA A9 6A 38    LDA #$386A             ;\
$8B:E6FD 8F A2 33 7E STA $7E33A2[$7E:33A2]  ;} $7E:339C + 6 = $386A (percent symbol top half)
$8B:E701 A9 7A 38    LDA #$387A             ;\
$8B:E704 8F E2 33 7E STA $7E33E2[$7E:33E2]  ;} $7E:33DC + 6 = $387A (percent symbol bottom half)
$8B:E708 7A          PLY
$8B:E709 FA          PLX
$8B:E70A AB          PLB
$8B:E70B 28          PLP
$8B:E70C 60          RTS

; Tank values
;                        ___________________________ Samus max health
;                       |      _____________________ Samus max reserve health
;                       |     |      _______________ Samus max missiles
;                       |     |     |      _________ Samus max super missiles
;                       |     |     |     |      ___ Samus max power bombs
;                       |     |     |     |     |
$8B:E70D             dw 09C4, 09D4, 09C8, 09CC, 09D0 ; RAM addresses to measure
$8B:E717             dw 0064, 0064, 0005, 0005, 0005 ; Divisors

; Item bits
$8B:E721             dw 0001, 0020, 0004, 1000, 0002, 0008, 0100, 0200, 2000, 4000, 8000

; Beam bits
$8B:E737             dw 0001, 0002, 0004, 0008, 1000

; Tilemap values for decimal digits:
;                        ________ Top half
;                       |     ___ Bottom half
;                       |    |
$8B:E741             dw 3860,3870, ; 0
                        3861,3871, ; 1
                        3862,3872, ; 2
                        3863,3873, ; 3
                        3864,3874, ; 4
                        3865,3875, ; 5
                        3866,3876, ; 6
                        3867,3877, ; 7
                        3868,3878, ; 8
                        3869,3879  ; 9
}


;;; $E769:  ;;;
{
; Note that the tilemap at $8C:DF5B is only 80h bytes, not 240h
$8B:E769 DA          PHX
$8B:E76A AD E2 09    LDA $09E2  [$7E:09E2]
$8B:E76D F0 0F       BEQ $0F    [$E77E]
$8B:E76F A2 7E 00    LDX #$007E
$8B:E772 BF 5B DF 8C LDA $8CDF5B,x
$8B:E776 9F C0 35 7E STA $7E35C0,x
$8B:E77A CA          DEX
$8B:E77B CA          DEX
$8B:E77C 10 F4       BPL $F4    [$E772]

$8B:E77E FA          PLX
$8B:E77F 60          RTS
}


;;; $E780:  ;;;
{
$8B:E780 DA          PHX
$8B:E781 A2 7E 00    LDX #$007E
$8B:E784 A9 7F 00    LDA #$007F

$8B:E787 9F C0 35 7E STA $7E35C0,x[$7E:363E]
$8B:E78B CA          DEX
$8B:E78C CA          DEX
$8B:E78D 10 F8       BPL $F8    [$E787]
$8B:E78F A9 97 E7    LDA #$E797
$8B:E792 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E795 FA          PLX
$8B:E796 60          RTS
}


;;; $E797:  ;;;
{
$8B:E797 AD 97 19    LDA $1997  [$7E:1997]
$8B:E79A 38          SEC
$8B:E79B E9 02 00    SBC #$0002
$8B:E79E 8D 97 19    STA $1997  [$7E:1997]
$8B:E7A1 C9 B1 FF    CMP #$FFB1
$8B:E7A4 10 13       BPL $13    [$E7B9]
$8B:E7A6 A0 48 F7    LDY #$F748             ;\
$8B:E7A9 A9 00 4C    LDA #$4C00             ;} Spawn see you next mission cinematic BG object for VRAM $4C00
$8B:E7AC 20 F0 95    JSR $95F0  [$8B:95F0]  ;/
$8B:E7AF A9 BA E7    LDA #$E7BA
$8B:E7B2 8D 51 1F    STA $1F51  [$7E:1F51]
$8B:E7B5 22 4F 82 80 JSL $80824F[$80:824F]

$8B:E7B9 60          RTS
}


;;; $E7BA: RTS ;;;
{
$8B:E7BA 60          RTS
}


;;; $E7BB: Initialise shooting stars ;;;
{
$8B:E7BB 08          PHP
$8B:E7BC C2 30       REP #$30
$8B:E7BE A0 0C 0E    LDY #$0E0C             ; Y = $0E0C (shooting star base address)
$8B:E7C1 A2 00 00    LDX #$0000             ; X = 0 (star index)
$8B:E7C4 86 12       STX $12    [$7E:0012]  ; >_<;

; LOOP
$8B:E7C6 DA          PHX
$8B:E7C7 8A          TXA                    ;\
$8B:E7C8 99 00 00    STA $0000,y[$7E:0E0C]  ;} Shooting star index = [X], animation frame = 0
$8B:E7CB 0A          ASL A
$8B:E7CC 0A          ASL A
$8B:E7CD 0A          ASL A
$8B:E7CE AA          TAX
$8B:E7CF A9 00 00    LDA #$0000             ;\
$8B:E7D2 99 0C 00    STA $000C,y[$7E:0E18]  ;} Shooting star X velocity = 0
$8B:E7D5 99 0E 00    STA $000E,y[$7E:0E1A]  ; Shooting star Y velocity = 0
$8B:E7D8 BD D5 E9    LDA $E9D5,x[$8B:E9D5]  ;\
$8B:E7DB F0 0E       BEQ $0E    [$E7EB]     ;} If [$E9CF + [X] * 8 + 6] (delay) != 0:
$8B:E7DD 99 0A 00    STA $000A,y[$7E:0E16]  ; Shooting star animation timer = [$E9CF + [X] * 8 + 6]
$8B:E7E0 B9 00 00    LDA $0000,y[$7E:0E0C]  ;\
$8B:E7E3 09 00 80    ORA #$8000             ;} Shooting star animation frame = 80h (set delay flag)
$8B:E7E6 99 00 00    STA $0000,y[$7E:0E0C]  ;/
$8B:E7E9 80 06       BRA $06    [$E7F1]

$8B:E7EB A9 20 00    LDA #$0020             ;\ Else ([$E9CF + [X] * 8 + 6] = 0):
$8B:E7EE 99 0A 00    STA $000A,y[$7E:0E26]  ;} Shooting star animation timer = 20h

$8B:E7F1 FA          PLX
$8B:E7F2 A9 80 00    LDA #$0080             ;\
$8B:E7F5 99 02 00    STA $0002,y[$7E:0E0E]  ;|
$8B:E7F8 99 06 00    STA $0006,y[$7E:0E12]  ;|
$8B:E7FB A9 00 00    LDA #$0000             ;} Shooting star X position = shooting star Y position = 80.00h
$8B:E7FE 99 04 00    STA $0004,y[$7E:0E10]  ;|
$8B:E801 99 08 00    STA $0008,y[$7E:0E14]  ;/
$8B:E804 98          TYA                    ;\
$8B:E805 18          CLC                    ;|
$8B:E806 69 10 00    ADC #$0010             ;} Y += 10h (next shooting star)
$8B:E809 A8          TAY                    ;/
$8B:E80A E8          INX                    ; Increment X
$8B:E80B E0 28 00    CPX #$0028             ;\
$8B:E80E 30 B6       BMI $B6    [$E7C6]     ;} If [X] < 28h: go to LOOP
$8B:E810 28          PLP
$8B:E811 60          RTS
}


;;; $E812: Handle shooting stars ;;;
{
$8B:E812 08          PHP
$8B:E813 C2 30       REP #$30
$8B:E815 AD 05 1A    LDA $1A05  [$7E:1A05]  ;\
$8B:E818 D0 02       BNE $02    [$E81C]     ;} If [shooting stars enable flag] = 0:
$8B:E81A 28          PLP
$8B:E81B 60          RTS                    ; Return

$8B:E81C A9 28 00    LDA #$0028             ;\
$8B:E81F 85 16       STA $16    [$7E:0016]  ;} $16 = 28h (loop counter)
$8B:E821 A0 0C 0E    LDY #$0E0C             ; Y = $0E0C (shooting star base address)
$8B:E824 80 1B       BRA $1B    [$E841]     ; Go to LOOP_PROCESS

; BRANCH_DELAY
$8B:E826 B9 0A 00    LDA $000A,y[$7E:0E16]  ;\
$8B:E829 3A          DEC A                  ;} Decrement shooting star animation timer
$8B:E82A 99 0A 00    STA $000A,y[$7E:0E16]  ;/
$8B:E82D 10 0F       BPL $0F    [$E83E]     ; If [shooting star animation timer] < 0:
$8B:E82F A9 20 00    LDA #$0020             ;\
$8B:E832 99 0A 00    STA $000A,y[$7E:0EA6]  ;} Shooting star animation timer = 20h
$8B:E835 B9 00 00    LDA $0000,y[$7E:0E9C]  ;\
$8B:E838 29 FF 00    AND #$00FF             ;} Shooting star animation frame = 0
$8B:E83B 99 00 00    STA $0000,y[$7E:0E9C]  ;/

$8B:E83E 4C E5 E8    JMP $E8E5  [$8B:E8E5]  ; Go to BRANCH_NEXT_PROCESS

; LOOP_PROCESS
$8B:E841 B9 00 00    LDA $0000,y[$7E:0E0C]  ;\
$8B:E844 30 E0       BMI $E0    [$E826]     ;} If [shooting star animation frame] & 80h != 0: go to BRANCH_DELAY
$8B:E846 48          PHA
$8B:E847 29 00 FF    AND #$FF00             ;\
$8B:E84A C9 00 04    CMP #$0400             ;} If [shooting star animation frame] >= 4:
$8B:E84D 30 26       BMI $26    [$E875]     ;/
$8B:E84F 68          PLA
$8B:E850 29 FF 00    AND #$00FF             ;\
$8B:E853 0A          ASL A                  ;|
$8B:E854 0A          ASL A                  ;} X = [shooting star index] * 8
$8B:E855 0A          ASL A                  ;|
$8B:E856 AA          TAX                    ;/
$8B:E857 B9 0C 00    LDA $000C,y[$7E:0F48]  ;\
$8B:E85A 18          CLC                    ;|
$8B:E85B 7D CF E9    ADC $E9CF,x[$8B:EA67]  ;|
$8B:E85E 18          CLC                    ;} Shooting star X velocity += [$E9CF + [X]] * 2
$8B:E85F 7D CF E9    ADC $E9CF,x[$8B:EA67]  ;|
$8B:E862 99 0C 00    STA $000C,y[$7E:0F48]  ;/
$8B:E865 B9 0E 00    LDA $000E,y[$7E:0F4A]  ;\
$8B:E868 18          CLC                    ;|
$8B:E869 7D D1 E9    ADC $E9D1,x[$8B:EA69]  ;|
$8B:E86C 18          CLC                    ;} Shooting star Y velocity += [$E9CF + [X] + 2] * 2
$8B:E86D 7D D1 E9    ADC $E9D1,x[$8B:EA69]  ;|
$8B:E870 99 0E 00    STA $000E,y[$7E:0F4A]  ;/
$8B:E873 80 1C       BRA $1C    [$E891]

$8B:E875 68          PLA
$8B:E876 29 FF 00    AND #$00FF             ;\ Else ([shooting star animation frame] < 4):
$8B:E879 0A          ASL A                  ;|
$8B:E87A 0A          ASL A                  ;} X = [shooting star index] * 8
$8B:E87B 0A          ASL A                  ;|
$8B:E87C AA          TAX                    ;/
$8B:E87D B9 0C 00    LDA $000C,y[$7E:0E28]  ;\
$8B:E880 18          CLC                    ;|
$8B:E881 7D CF E9    ADC $E9CF,x[$8B:E9D7]  ;} Shooting star X velocity += [$E9CF + [X]]
$8B:E884 99 0C 00    STA $000C,y[$7E:0E28]  ;/
$8B:E887 B9 0E 00    LDA $000E,y[$7E:0E2A]  ;\
$8B:E88A 18          CLC                    ;|
$8B:E88B 7D D1 E9    ADC $E9D1,x[$8B:E9D9]  ;} Shooting star Y velocity += [$E9CF + [X] + 2]
$8B:E88E 99 0E 00    STA $000E,y[$7E:0E2A]  ;/

$8B:E891 B9 0C 00    LDA $000C,y[$7E:0E28]  ;\
$8B:E894 48          PHA                    ;|
$8B:E895 EB          XBA                    ;|
$8B:E896 29 FF 00    AND #$00FF             ;|
$8B:E899 89 80 00    BIT #$0080             ;|
$8B:E89C F0 03       BEQ $03    [$E8A1]     ;|
$8B:E89E 09 00 FF    ORA #$FF00             ;|
                                            ;|
$8B:E8A1 85 12       STA $12    [$7E:0012]  ;|
$8B:E8A3 68          PLA                    ;|
$8B:E8A4 EB          XBA                    ;} Shooting star X position = [shooting star X velocity] / 100h
$8B:E8A5 29 00 FF    AND #$FF00             ;|
$8B:E8A8 85 14       STA $14    [$7E:0014]  ;|
$8B:E8AA B9 04 00    LDA $0004,y[$7E:0E20]  ;|
$8B:E8AD 18          CLC                    ;|
$8B:E8AE 65 14       ADC $14    [$7E:0014]  ;|
$8B:E8B0 99 04 00    STA $0004,y[$7E:0E20]  ;|
$8B:E8B3 B9 02 00    LDA $0002,y[$7E:0E1E]  ;|
$8B:E8B6 65 12       ADC $12    [$7E:0012]  ;|
$8B:E8B8 99 02 00    STA $0002,y[$7E:0E1E]  ;/
$8B:E8BB B9 0E 00    LDA $000E,y[$7E:0E2A]  ;\
$8B:E8BE 48          PHA                    ;|
$8B:E8BF EB          XBA                    ;|
$8B:E8C0 29 FF 00    AND #$00FF             ;|
$8B:E8C3 89 80 00    BIT #$0080             ;|
$8B:E8C6 F0 03       BEQ $03    [$E8CB]     ;|
$8B:E8C8 09 00 FF    ORA #$FF00             ;|
                                            ;|
$8B:E8CB 85 12       STA $12    [$7E:0012]  ;|
$8B:E8CD 68          PLA                    ;|
$8B:E8CE EB          XBA                    ;} Shooting star Y position = [shooting star Y velocity] / 100h
$8B:E8CF 29 00 FF    AND #$FF00             ;|
$8B:E8D2 85 14       STA $14    [$7E:0014]  ;|
$8B:E8D4 B9 08 00    LDA $0008,y[$7E:0E24]  ;|
$8B:E8D7 18          CLC                    ;|
$8B:E8D8 65 14       ADC $14    [$7E:0014]  ;|
$8B:E8DA 99 08 00    STA $0008,y[$7E:0E24]  ;|
$8B:E8DD B9 06 00    LDA $0006,y[$7E:0E22]  ;|
$8B:E8E0 65 12       ADC $12    [$7E:0012]  ;|
$8B:E8E2 99 06 00    STA $0006,y[$7E:0E22]  ;/

; BRANCH_NEXT_PROCESS
$8B:E8E5 98          TYA                    ;\
$8B:E8E6 18          CLC                    ;|
$8B:E8E7 69 10 00    ADC #$0010             ;} Y += 10h (next shooting star)
$8B:E8EA A8          TAY                    ;/
$8B:E8EB C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$8B:E8ED F0 03       BEQ $03    [$E8F2]     ; If [$16] != 0:
$8B:E8EF 4C 41 E8    JMP $E841  [$8B:E841]  ; Go to LOOP_PROCESS

$8B:E8F2 A9 28 00    LDA #$0028             ;\
$8B:E8F5 85 16       STA $16    [$7E:0016]  ;} $16 = 28h (loop counter)
$8B:E8F7 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$8B:E8FA A0 0C 0E    LDY #$0E0C             ; Y = $0E0C (shooting star base address)

; LOOP_DRAW
$8B:E8FD B9 00 00    LDA $0000,y[$7E:0E0C]  ;\
$8B:E900 30 69       BMI $69    [$E96B]     ;} If [shooting star animation frame] < 0: go to BRANCH_NEXT_DRAW
$8B:E902 B9 02 00    LDA $0002,y[$7E:0E1E]  ;\
$8B:E905 89 00 FF    BIT #$FF00             ;|
$8B:E908 D0 73       BNE $73    [$E97D]     ;|
$8B:E90A 38          SEC                    ;} If not 4 <= [shooting star X position] < 100h: go to BRANCH_OFFSCREEN
$8B:E90B E9 04 00    SBC #$0004             ;|
$8B:E90E 89 00 FF    BIT #$FF00             ;|
$8B:E911 D0 6A       BNE $6A    [$E97D]     ;/
$8B:E913 9D 70 03    STA $0370,x[$7E:0370]  ; OAM entry X position = [shooting star X position] - 4
$8B:E916 B9 06 00    LDA $0006,y[$7E:0E22]  ;\
$8B:E919 89 00 FF    BIT #$FF00             ;|
$8B:E91C D0 5F       BNE $5F    [$E97D]     ;|
$8B:E91E 38          SEC                    ;} If not 4 <= [shooting star Y position] < 100h: go to BRANCH_OFFSCREEN
$8B:E91F E9 04 00    SBC #$0004             ;|
$8B:E922 89 00 FF    BIT #$FF00             ;|
$8B:E925 D0 56       BNE $56    [$E97D]     ;/
$8B:E927 9D 71 03    STA $0371,x[$7E:0371]  ; OAM entry Y position = [shooting star Y position] - 4
$8B:E92A B9 0A 00    LDA $000A,y[$7E:0E26]  ;\
$8B:E92D 3A          DEC A                  ;} Decrement shooting star animation timer
$8B:E92E 99 0A 00    STA $000A,y[$7E:0E26]  ;/
$8B:E931 F0 02       BEQ $02    [$E935]     ;\
$8B:E933 10 1B       BPL $1B    [$E950]     ;} If [shooting star animation timer] <= 0:
$8B:E935 DA          PHX
$8B:E936 B9 00 00    LDA $0000,y[$7E:0E1C]  ;\
$8B:E939 48          PHA                    ;|
$8B:E93A 29 FF 00    AND #$00FF             ;|
$8B:E93D 0A          ASL A                  ;|
$8B:E93E 0A          ASL A                  ;} Shooting star animation timer = [$E9CF + [shooting star index] * 8 + 4]
$8B:E93F 0A          ASL A                  ;|
$8B:E940 AA          TAX                    ;|
$8B:E941 BD D3 E9    LDA $E9D3,x[$8B:E9DB]  ;|
$8B:E944 99 0A 00    STA $000A,y[$7E:0E26]  ;/
$8B:E947 68          PLA                    ;\
$8B:E948 18          CLC                    ;|
$8B:E949 69 00 02    ADC #$0200             ;} Shooting star animation frame += 2
$8B:E94C 99 00 00    STA $0000,y[$7E:0E1C]  ;/
$8B:E94F FA          PLX

$8B:E950 B9 00 00    LDA $0000,y[$7E:0E1C]  ;\
$8B:E953 89 00 FF    BIT #$FF00             ;} If [shooting star animation frame] = 0: go to BRANCH_NEXT_DRAW
$8B:E956 F0 13       BEQ $13    [$E96B]     ;/
$8B:E958 5A          PHY                    ;\
$8B:E959 EB          XBA                    ;|
$8B:E95A 29 FF 00    AND #$00FF             ;|
$8B:E95D A8          TAY                    ;} OAM entry tile number and attributes = [$E9A7 + [shooting star animation frame]]
$8B:E95E B9 A7 E9    LDA $E9A7,y[$8B:E9A9]  ;|
$8B:E961 9D 72 03    STA $0372,x[$7E:0372]  ;|
$8B:E964 7A          PLY                    ;/
$8B:E965 8A          TXA                    ;\
$8B:E966 18          CLC                    ;|
$8B:E967 69 04 00    ADC #$0004             ;} X += 4 (next OAM entry)
$8B:E96A AA          TAX                    ;/

; BRANCH_NEXT_DRAW
$8B:E96B 98          TYA                    ;\
$8B:E96C 18          CLC                    ;|
$8B:E96D 69 10 00    ADC #$0010             ;} Y += 10h (next shooting star)
$8B:E970 A8          TAY                    ;/
$8B:E971 C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$8B:E973 F0 03       BEQ $03    [$E978]     ; If [$16] != 0:
$8B:E975 4C FD E8    JMP $E8FD  [$8B:E8FD]  ; Go to LOOP_DRAW

$8B:E978 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$8B:E97B 28          PLP
$8B:E97C 60          RTS                    ; Return

; BRANCH_OFFSCREEN
$8B:E97D A9 20 00    LDA #$0020             ;\
$8B:E980 99 0A 00    STA $000A,y[$7E:0E46]  ;} Shooting star animation timer = 20h
$8B:E983 A9 80 00    LDA #$0080             ;\
$8B:E986 99 02 00    STA $0002,y[$7E:0E3E]  ;|
$8B:E989 99 06 00    STA $0006,y[$7E:0E42]  ;|
$8B:E98C A9 00 00    LDA #$0000             ;} Shooting star X position = shooting star Y position = 80.00h
$8B:E98F 99 04 00    STA $0004,y[$7E:0E40]  ;|
$8B:E992 99 08 00    STA $0008,y[$7E:0E44]  ;/
$8B:E995 99 0C 00    STA $000C,y[$7E:0E48]  ; Shooting star X velocity = 0
$8B:E998 99 0E 00    STA $000E,y[$7E:0E4A]  ; Shooting star Y velocity = 0
$8B:E99B B9 00 00    LDA $0000,y[$7E:0E3C]  ;\
$8B:E99E 29 FF 00    AND #$00FF             ;} Shooting star animation frame = 0
$8B:E9A1 99 00 00    STA $0000,y[$7E:0E3C]  ;/
$8B:E9A4 4C 6B E9    JMP $E96B  [$8B:E96B]  ; Go to BRANCH_NEXT_DRAW

; Tile number and attributes, indexed by animation frame
$8B:E9A7             dw 0000, 09F0, 09F1, 09F2, 09F3, 09F3, 09F3, 09F3, 09F3, 09F3, 09F3, 09F3, 09F3, 09F3, 09F3, 09F3,
                        09F3, 09F3, 09F3, 09F3
}


;;; $E9CF: Shooting star table ;;;
{
; Indexed by star index

;                        __________________ X acceleration. Unit 1/100h px/frame²
;                       |     _____________ Y acceleration. Unit 1/100h px/frame²
;                       |    |     ________ Animation timer reset value
;                       |    |    |     ___ Delay before appearing
;                       |    |    |    |
$8B:E9CF             dw 0010,FFF0,0006,0008,
                        000C,FFFF,0006,0000,
                        000D,FFF6,0006,0006,
                        0008,FFF0,0006,0000,
                        0002,FFF2,0006,0008,
                        0010,FFF8,0006,0000,
                        0002,FFFF,0F00,0000,
                        0001,FFFE,0F00,0000,
                        0000,FFFD,0F00,0000,
                        0002,FFFB,0020,0004,
                        000F,0010,0006,0008,
                        0002,0009,0008,0000,
                        000C,0008,0006,0000,
                        0010,0004,0006,0008,
                        0008,000C,0008,0000,
                        0002,0008,0008,0000,
                        0002,0004,0F00,0000,
                        0002,0001,0F00,0000,
                        FFF3,000D,0004,0008,
                        FFF2,0008,0004,0000,
                        FFF9,000E,0006,0000,
                        FFFB,0010,0004,0008,
                        FFFC,0005,0020,0000,
                        FFFE,0003,0F00,0000,
                        FFFE,0004,0F00,0000,
                        FFFD,0001,0F00,0000,
                        FFF4,0002,0004,0000,
                        FFFA,0005,0020,0000,
                        FFFD,0008,0020,0000,
                        FFF2,FFF7,0004,0008,
                        FFF8,FFF4,0004,0000,
                        FFFA,FFF2,0006,0000,
                        FFF4,FFF0,0004,0008,
                        FFF8,FFFC,0020,0000,
                        FFFD,FFFA,0020,0000,
                        FFF9,FFF8,0020,0000,
                        FFFE,FFFD,0F00,0000,
                        FFFC,FFFC,0F00,0000,
                        FFF8,FFFE,0F00,0000,
                        FFF8,FFFC,0F00,0000
}


;;; $EB0F..EE9C: Cinematic sprite object instruction lists - ending ;;;
{
;;; $EB0F: Instruction list - cinematic sprite object $EE9D (exploding Zebes - Zebes) ;;;
{
$8B:EB0F             dx 94D6,0005   ; Timer = 5
$8B:EB13             dx 000D,A396,
                        000D,A3AC,
                        000D,A3C2,
                        000D,A3D8,
                        94C3,EB13,  ; Decrement timer and go to $EB13 if non-zero
                        F284,       ; Fade out zoomed out exploding Zebes
                        0020,A3EE,
                        0020,A404,
                        0020,A41A,
                        0020,A430,
                        F295,       ; Spawn Zebes explosion silhouette cinematic sprite object
                        9438        ; Delete
}


;;; $EB3D: Instruction list - cinematic sprite object $EEA3 (exploding Zebes - purple glow) ;;;
{
$8B:EB3D             dx 0010,A472,
                        0010,A4B0,
                        0010,A516,
                        0010,A4B0,
                        94BC,EB3D   ; Go to $EB3D
}


;;; $EB51: Instruction list - cinematic sprite object $EEA9 (exploding Zebes - stars) ;;;
{
$8B:EB51             dx 0010,A28B,
                        94BC,EB51   ; Go to $EB51
}


;;; $EB59: Instruction list - cinematic sprite object $EEAF (exploding Zebes - lava) ;;;
{
$8B:EB59             dx 009C,0000
$8B:EB5D             dx 000A,A446,
                        000A,A45C,
                        94BC,EB5D   ; Go to $EB5D
}


;;; $EB69: Instruction list - cinematic sprite object $EEB5 (Zebes explosion - silhouette) ;;;
{
$8B:EB69             dx 0008,A57C,
                        F2B7,       ; Start Zebes explosion
                        9438        ; Delete
}


;;; $EB71: Instruction list - cinematic sprite object $EEBB (Zebes explosion - stars - right) ;;;
{
$8B:EB71             dx 0090,A28B,
                        F2FA,       ; Zebes explosion finale
                        014C,A28B,
                        F32B,       ; End Zebes explosion
                        944C,F35A   ; Pre-instruction = $F35A
}


;;; $EB81: Instruction list - cinematic sprite object $EEF7 (Zebes explosion - stars - left) ;;;
{
$8B:EB81             dx 0010,A28B,
                        94BC,EB81   ; Go to $EB81
}


;;; $EB89: Instruction list - cinematic sprite object $EEC1 (Zebes explosion - afterglow) ;;;
{
$8B:EB89             dx 0010,A5E2,
                        94BC,EB89   ; Go to $EB89
}


;;; $EB91: Instruction list - cinematic sprite object $EEC7 ('THE OPERATION WAS') ;;;
{
$8B:EB91             dx 0008,A69D,
                        0008,A6A9,
                        000F,A6BF,
                        0008,A6DF,
                        0008,A709,
                        0008,A73D,
                        0008,A77B,
                        0008,A7C3,
                        0008,A815,
                        0008,A871,
                        0008,A8D7,
                        000F,A947,
                        0008,A9C1,
                        0008,AA45,
                        000F,AAD3,
                        F3B0        ; Spawn 'COMPLETED SUCCESSFULLY' cinematic sprite object
$8B:EBCF             dx 000F,AAD3,
                        94BC,EBCF   ; Go to $EBCF
}


;;; $EBD7: Instruction list - cinematic sprite object $EECD ('COMPLETED SUCCESSFULLY') ;;;
{
$8B:EBD7             dx 0008,AB6B,
                        0008,AB77,
                        0008,AB8D,
                        0008,ABAD,
                        0008,ABD7,
                        0008,AC0B,
                        0008,AC49,
                        0008,AC91,
                        000F,ACE3,
                        0008,AD3F,
                        0008,ADA5,
                        0008,AE15,
                        0008,AE8F,
                        0008,AF13,
                        0008,AFA1,
                        0008,B039,
                        0008,B0DB,
                        0008,B187,
                        0008,B23D,
                        0008,B2FD,
                        000F,B3C7,
                        F3CE        ; Spawn clear time cinematic sprite object
$8B:EC2D             dx 0008,B3C7,
                        94BC,EC2D   ; Go to $EC2D
}


;;; $EC35: Instruction list - cinematic sprite object $EEFD (clear time) ;;;
{
$8B:EC35             dx 0008,B49B,
                        0008,B4A7,
                        0008,B4BD,
                        0008,B4DD,
                        000F,B507,
                        0008,B53B,
                        0008,B579,
                        0008,B5C1,
                        000F,B613,
                        F41B,       ; Spawn clear time hours tens digit cinematic sprite object
                        0008,B613,
                        F424,       ; Spawn clear time hours units digit cinematic sprite object
                        0008,B613,
                        F42D,       ; Spawn clear time colon cinematic sprite object
                        0008,B613,
                        F436,       ; Spawn clear time minutes tens digit cinematic sprite object
                        0008,B613,
                        F43F,       ; Spawn clear time minutes units digit cinematic sprite object
                        0080,B613,
                        F448        ; Transition to credits
$8B:EC79             dx 000F,B613,
                        94BC,EC79   ; Go to $EC79
}


;;; $EC81: Instruction list - clear time digit ;;;
{
; 0
$8B:EC81             dx 0008,B67B,
                        94BC,EC81   ; Go to $EC81

; 1
$8B:EC89             dx 0008,B687,
                        94BC,EC89   ; Go to $EC89

; 2
$8B:EC91             dx 0008,B693,
                        94BC,EC91   ; Go to $EC91

; 3
$8B:EC99             dx 0008,B69F,
                        94BC,EC99   ; Go to $EC99

; 4
$8B:ECA1             dx 0008,B6AB,
                        94BC,ECA1   ; Go to $ECA1

; 5
$8B:ECA9             dx 0008,B6B7,
                        94BC,ECA9   ; Go to $ECA9

; 6
$8B:ECB1             dx 0008,B6C3,
                        94BC,ECB1   ; Go to $ECB1

; 7
$8B:ECB9             dx 0008,B6CF,
                        94BC,ECB9   ; Go to $ECB9

; 8
$8B:ECC1             dx 0008,B6DB,
                        94BC,ECC1   ; Go to $ECC1

; 9
$8B:ECC9             dx 0008,B6E7,
                        94BC,ECC9   ; Go to $ECC9
}


;;; $ECD1: Instruction list - cinematic sprite object $EF0F (clear time - colon) ;;;
{
$8B:ECD1             dx 0008,B66F,
                        94BC,ECD1   ; Go to $ECD1
}


;;; $ECD9: Instruction list - cinematic sprite object $EF21 (critters escape) ;;;
{
$8B:ECD9             dx 0001,BC41,
                        0001,BC48,
                        0001,BC4F,
                        0001,BC56,
                        94BC,ECD9   ; Go to $ECD9
}


;;; $ECED: Instruction list - cinematic sprite object $EED3 (yellow clouds - top - top half) ;;;
{
$8B:ECED             dx 0001,B745,
                        94BC,ECED   ; Go to $ECED
}


;;; $ECF5: Instruction list - cinematic sprite object $EED9 (yellow clouds - top - bottom half) ;;;
{
$8B:ECF5             dx 0001,B7E9,
                        94BC,ECF5   ; Go to $ECF5
}


;;; $ECFD: Instruction list - cinematic sprite object $EEDF (yellow clouds - bottom - top half) ;;;
{
$8B:ECFD             dx 0001,B797,
                        94BC,ECFD   ; Go to $ECFD
}


;;; $ED05: Instruction list - cinematic sprite object $EEE5 (yellow clouds - bottom - bottom half) ;;;
{
$8B:ED05             dx 0001,B6F3,
                        94BC,ED05   ; Go to $ED05
}


;;; $ED0D: Instruction list - cinematic sprite object $EEEB (yellow clouds - right) ;;;
{
$8B:ED0D             dx 0001,B83B,
                        94BC,ED0D   ; Go to $ED0D
}


;;; $ED15: Instruction list - cinematic sprite object $EEF1 (yellow clouds - left) ;;;
{
$8B:ED15             dx 0001,B8DD,
                        94BC,ED15   ; Go to $ED15
}


;;; $ED1D: Instruction list - cinematic sprite object $EF27 (suitless Samus - idle) ;;;
{
$8B:ED1D             dx 0080,9FF7,
                        94BC,ED1D   ; Go to $ED1D
}


;;; $ED25: Instruction list - cinematic sprite object $EF2D (suitless Samus - idle - legs) ;;;
{
$8B:ED25             dx 0080,A243,
                        94BC,ED25   ; Go to $ED25
}


;;; $ED2D: Instruction list - cinematic sprite object $EF33 (suitless Samus - letting hair down) ;;;
{
$8B:ED2D             dx 005A,9FF7,
                        0008,A085,
                        000A,A0B4,
                        000A,A0E8,
                        0020,A11C,
                        000A,A150,
                        0009,A17F,
                        0010,A1B3,
                        000A,A200,
                        0030,9EA2,
                        F51D,       ; Spawn suitless Samus jump cinematic sprite object
                        9438        ; Delete
}


;;; $ED59: Instruction list - cinematic sprite object $EF39 (suitless Samus - letting hair down - legs) ;;;
{
$8B:ED59             dx 005A,A243,
                        0008,A243,
                        000A,A243,
                        000A,A243,
                        0020,A243,
                        000A,A243,
                        0009,A243,
                        0010,A243,
                        000A,A243,
                        9438        ; Delete
}


;;; $ED7F: Instruction list - cinematic sprite object $EF3F (suitless Samus - jump) ;;;
{
$8B:ED7F             dx 0030,9EA2,
                        000A,9F30,
                        F651,       ; ???
                        944C,F528   ; Pre-instruction = $F528
$8B:ED8D             dx 0030,9F96,
                        94BC,ED8D   ; Go to $ED8D
}


;;; $ED95: Instruction list ;;;
{
$8B:ED95             dx 000A,9D5A,
                        94BC,ED95   ; Go to $ED95
}


;;; $ED9D: Instruction list ;;;
{
$8B:ED9D             dx 000A,9DA7,
                        0010,9DEA,
                        0030,9E55,
                        F604,       ; Samus shoots screen
                        0080,9E55,
                        9438        ; Delete
}


;;; $EDB1: Instruction list - cinematic sprite object $EF45 (suited Samus - idle - body) ;;;
{
$8B:EDB1             dx 000A,99D6,
                        94BC,EDB1   ; Go to $EDB1
}


;;; $EDB9: Instruction list - cinematic sprite object $EF4B (suited Samus - idle - head - with helmet) ;;;
{
$8B:EDB9             dx 000A,9CAC,
                        94BC,EDB9   ; Go to $EDB9
}


;;; $EDC1: Instruction list - cinematic sprite object $EF51 (suited Samus - idle - head - without helmet) ;;;
{
$8B:EDC1             dx 000A,9C7C,
                        94BC,EDC1   ; Go to $EDC1
}


;;; $EDC9: Instruction list - cinematic sprite object $EF57 (suited Samus - thumbs up - body) ;;;
{
$8B:EDC9             dx 0040,99D6,
                        0108,9CC2,
                        9438        ; Delete
}


;;; $EDD3: Instruction list - cinematic sprite object $EF5D (suited Samus - thumbs up - arm) ;;;
{
$8B:EDD3             dx 0040,0000,
                        0008,9B9F,
                        0008,9BBA,
                        0005,9BDA,
                        0004,9BF5,
                        0003,9C10,
                        0020,9C2B,
                        0008,9C46,
                        0040,9C61,
                        0005,9C2B,
                        0005,9C10,
                        0005,9BF5,
                        0005,9BDA,
                        0070,9BBA,
                        F554,       ; ???
                        9438        ; Delete
}


;;; $EE0F: Instruction list - cinematic sprite object $EF63 (suited Samus - thumbs up - head - with helmet) ;;;
{
$8B:EE0F             dx 0148,9CAC,
                        9438        ; Delete
}


;;; $EE15: Instruction list - cinematic sprite object $EF69 (suited Samus - thumbs up - head - without helmet) ;;;
{
$8B:EE15             dx 0080,9C7C,
                        0005,9C88,
                        0005,9C94,
                        00BE,9CA0,
                        9438        ; Delete
}


;;; $EE27: Instruction list - cinematic sprite object $EF6F (suited Samus - jump - body) ;;;
{
$8B:EE27             dx F597,       ; ???
                        000A,9A82,
                        F5BA,       ; ???
                        F651,       ; ???
                        944C,F528   ; Pre-instruction = $F528
$8B:EE35             dx 0005,9AF2,
                        94BC,EE35   ; Go to $EE35
}


;;; $EE3D: Instruction list - cinematic sprite object $EF75 (suited Samus - jump - head - with helmet) ;;;
{
$8B:EE3D             dx 000A,9B58,
                        944C,F57F   ; Pre-instruction = $F57F
$8B:EE45             dx 0005,9B73,
                        94BC,EE45   ; Go to $EE45
}


;;; $EE4D: Instruction list - cinematic sprite object $EF7B (suited Samus - jump - head - without helmet) ;;;
{
$8B:EE4D             dx 000A,9B8E,
                        944C,F57F   ; Pre-instruction = $F57F
$8B:EE55             dx 0005,9B8E,
                        94BC,EE55   ; Go to $EE55
}


;;; $EE5D: Instruction list - cinematic sprite object $EF81 (Super Metroid icon - S - top half) ;;;
{
$8B:EE5D             dx 000A,B97F,
                        94BC,EE5D   ; Go to $EE5D
}


;;; $EE65: Instruction list - cinematic sprite object $EF87 (Super Metroid icon - S - bottom half) ;;;
{
$8B:EE65             dx 000A,B9C7,
                        94BC,EE65   ; Go to $EE65
}


;;; $EE6D: Instruction list - cinematic sprite object $EF8D (Super Metroid icon - circle - top half) ;;;
{
$8B:EE6D             dx 0060,0000,
                        0005,BA0F,
                        0005,BA4D,
                        0040,BAA9,
                        F25E        ; ???
$8B:EE7F             dx 0005,BAA9,
                        94BC,EE7F   ; Go to $EE7F
}


;;; $EE87: Instruction list - cinematic sprite object $EF93 (Super Metroid icon - circle - bottom half) ;;;
{
$8B:EE87             dx 0060,0000,
                        0005,BB28,
                        0005,BB66
$8B:EE93             dx 0005,BBC2,
                        94BC,EE93   ; Go to $EE93
}


;;; $EE9B: Instruction list - delete ;;;
{
$8B:EE9B             dx 9438        ; Delete
}
}


;;; $EE9D: Cinematic sprite object definitions - ending ;;;
{
;                        _____________ Initialisation function
;                       |     ________ Pre-instruction
;                       |    |     ___ Instruction list
;                       |    |    |
$8B:EE9D             dw EFEA,93D9,EB0F ; Exploding Zebes - Zebes
$8B:EEA3             dw EFEA,F2A5,EB3D ; Exploding Zebes - purple glow
$8B:EEA9             dw EFEA,F2A5,EB51 ; Exploding Zebes - stars
$8B:EEAF             dw F005,F2A5,EB59 ; Exploding Zebes - lava
$8B:EEB5             dw F005,93D9,EB69 ; Zebes explosion - silhouette
$8B:EEBB             dw EFEA,93D9,EB71 ; Zebes explosion - stars - right
$8B:EEC1             dw F018,F39B,EB89 ; Zebes explosion - afterglow
$8B:EEC7             dw F02B,F3B9,EB91 ; 'THE OPERATION WAS'
$8B:EECD             dw F02B,F3B9,EBD7 ; 'COMPLETED SUCCESSFULLY'
$8B:EED3             dw F0B2,F455,ECED ; Yellow clouds - top - top half
$8B:EED9             dw F0E1,F455,ECF5 ; Yellow clouds - top - bottom half
$8B:EEDF             dw F0E9,F478,ECFD ; Yellow clouds - bottom - top half
$8B:EEE5             dw F0F1,F478,ED05 ; Yellow clouds - bottom - bottom half
$8B:EEEB             dw F0F9,F49B,ED0D ; Yellow clouds - right
$8B:EEF1             dw F11E,F4D1,ED15 ; Yellow clouds - left
$8B:EEF7             dw EFFD,F35A,EB81 ; Zebes explosion - stars - left
$8B:EEFD             dw F03E,F3B9,EC35 ; Clear time
$8B:EF03             dw F05E,F3B9,EC81 ; Clear time - hours - tens digit
$8B:EF09             dw F06D,F3B9,EC81 ; Clear time - hours - units digit
$8B:EF0F             dw F07C,F3B9,ECD1 ; Clear time - colon
$8B:EF15             dw F085,F3B9,EC81 ; Clear time - minutes - tens digit
$8B:EF1B             dw F094,F3B9,EC81 ; Clear time - minutes - units digit
$8B:EF21             dw EF99,EFB2,ECD9 ; Critters escape
$8B:EF27             dw F143,F507,ED1D ; Suitless Samus - idle                            (best ending)
$8B:EF2D             dw F143,F507,ED25 ; Suitless Samus - idle - legs                     (best ending)
$8B:EF33             dw F143,F51C,ED2D ; Suitless Samus - letting hair down               (best ending)
$8B:EF39             dw F143,93D9,ED59 ; Suitless Samus - letting hair down - legs        (best ending)
$8B:EF3F             dw F143,93D9,ED7F ; Suitless Samus - jump                            (best ending)
$8B:EF45             dw F156,F507,EDB1 ; Suited Samus - idle - body                       (non-best ending)
$8B:EF4B             dw F169,F507,EDB9 ; Suited Samus - idle - head - with helmet         (worst ending)
$8B:EF51             dw F17C,F507,EDC1 ; Suited Samus - idle - head - without helmet      (mediocre ending)
$8B:EF57             dw F156,93D9,EDC9 ; Suited Samus - thumbs up - body                  (non-best ending)
$8B:EF5D             dw F156,93D9,EDD3 ; Suited Samus - thumbs up - arm                   (non-best ending)
$8B:EF63             dw F169,93D9,EE0F ; Suited Samus - thumbs up - head - with helmet    (worst ending)
$8B:EF69             dw F17C,93D9,EE15 ; Suited Samus - thumbs up - head - without helmet (mediocre ending)
$8B:EF6F             dw F156,93D9,EE27 ; Suited Samus - jump - body                       (non-best ending)
$8B:EF75             dw F169,93D9,EE3D ; Suited Samus - jump - head - with helmet         (worst ending)
$8B:EF7B             dw F17C,93D9,EE4D ; Suited Samus - jump - head - without helmet      (mediocre ending)
$8B:EF81             dw F18F,F1E7,EE5D ; Super Metroid icon - S - top half
$8B:EF87             dw F1A8,F227,EE65 ; Super Metroid icon - S - bottom half
$8B:EF8D             dw F1C1,93D9,EE6D ; Super Metroid icon - circle - top half
$8B:EF93             dw F1D4,93D9,EE87 ; Super Metroid icon - circle - bottom half
}


;;; $EF99: Initialisation function - cinematic sprite object $EF21 (critters escape) ;;;
{
$8B:EF99 A9 80 00    LDA #$0080             ;\
$8B:EF9C 99 9D 1A    STA $1A9D,y[$7E:1AA1]  ;} Cinematic sprite object Y position = 80h
$8B:EF9F A9 80 00    LDA #$0080             ;\
$8B:EFA2 99 7D 1A    STA $1A7D,y[$7E:1A81]  ;} Cinematic sprite object X position = 80h
$8B:EFA5 A9 00 0E    LDA #$0E00             ;\
$8B:EFA8 99 BD 1A    STA $1ABD,y[$7E:1AC1]  ;} Cinematic sprite object palette index = E00h (palette 7)
$8B:EFAB A9 04 01    LDA #$0104             ;\
$8B:EFAE 99 7D 1B    STA $1B7D,y[$7E:1B81]  ;} Cinematic sprite object timer = 104h
$8B:EFB1 60          RTS
}


;;; $EFB2: Pre-instruction - cinematic sprite object $EF21 (critters escape) ;;;
{
$8B:EFB2 BD FD 1A    LDA $1AFD,x[$7E:1B01]  ;\
$8B:EFB5 18          CLC                    ;|
$8B:EFB6 69 80 00    ADC #$0080             ;|
$8B:EFB9 9D FD 1A    STA $1AFD,x[$7E:1B01]  ;} Cinematic sprite object Y position += 0.0080h
$8B:EFBC BD 9D 1A    LDA $1A9D,x[$7E:1AA1]  ;|
$8B:EFBF 69 00 00    ADC #$0000             ;|
$8B:EFC2 9D 9D 1A    STA $1A9D,x[$7E:1AA1]  ;/
$8B:EFC5 BD DD 1A    LDA $1ADD,x[$7E:1AE1]
$8B:EFC8 18          CLC
$8B:EFC9 69 00 00    ADC #$0000
$8B:EFCC 9D DD 1A    STA $1ADD,x[$7E:1AE1]
$8B:EFCF BD 7D 1A    LDA $1A7D,x[$7E:1A81]  ;\
$8B:EFD2 69 01 00    ADC #$0001             ;} Cinematic sprite object X position += 1
$8B:EFD5 9D 7D 1A    STA $1A7D,x[$7E:1A81]  ;/
$8B:EFD8 C9 10 01    CMP #$0110             ;\
$8B:EFDB 30 0C       BMI $0C    [$EFE9]     ;} If [cinematic sprite object X position] >= 110h:
$8B:EFDD A9 01 00    LDA #$0001             ;\
$8B:EFE0 9D 5D 1B    STA $1B5D,x[$7E:1B61]  ;} Cinematic sprite object instruction timer = 1
$8B:EFE3 A9 9B EE    LDA #$EE9B             ;\
$8B:EFE6 9D 1D 1B    STA $1B1D,x[$7E:1B21]  ;} Cinematic sprite object instruction list pointer = $EE9B (delete)

$8B:EFE9 60          RTS
}


;;; $EFEA..F1E6: Cinematic sprite object initialisation functions - ending ;;;
{
;;; $EFEA: Initialisation function - cinematic sprite object $EE9D/$EEA3/$EEA9/$EEBB (exploding Zebes - palette 7) ;;;
{
$8B:EFEA A9 80 00    LDA #$0080             ;\
$8B:EFED 99 7D 1A    STA $1A7D,y[$7E:1A9B]  ;} Cinematic sprite object X position = 80h
}


;;; $EFF0:  ;;;
{
$8B:EFF0 A9 80 00    LDA #$0080             ;\
$8B:EFF3 99 9D 1A    STA $1A9D,y[$7E:1ABB]  ;} Cinematic sprite object Y position = 80h
$8B:EFF6 A9 00 0E    LDA #$0E00             ;\
$8B:EFF9 99 BD 1A    STA $1ABD,y[$7E:1ADB]  ;} Cinematic sprite object palette index = E00h (palette 7)
$8B:EFFC 60          RTS
}


;;; $EFFD: Initialisation function - cinematic sprite object $EEF7 (Zebes explosion - stars - left) ;;;
{
$8B:EFFD A9 80 FF    LDA #$FF80             ;\
$8B:F000 99 7D 1A    STA $1A7D,y[$7E:1A7F]  ;} Cinematic sprite object X position = -80h
$8B:F003 80 EB       BRA $EB    [$EFF0]     ; Go to $EFF0
}


;;; $F005: Initialisation function - cinematic sprite object $EEAF/$EEB5 (exploding Zebes - palette 5) ;;;
{
$8B:F005 A9 80 00    LDA #$0080             ;\
$8B:F008 99 7D 1A    STA $1A7D,y[$7E:1A99]  ;} Cinematic sprite object X position = 80h
$8B:F00B A9 80 00    LDA #$0080             ;\
$8B:F00E 99 9D 1A    STA $1A9D,y[$7E:1AB9]  ;} Cinematic sprite object Y position = 80h
$8B:F011 A9 00 0A    LDA #$0A00             ;\
$8B:F014 99 BD 1A    STA $1ABD,y[$7E:1AD9]  ;} Cinematic sprite object palette index = A00h (palette 5)
$8B:F017 60          RTS
}


;;; $F018: Initialisation function - cinematic sprite object $EEC1 (Zebes explosion - afterglow) ;;;
{
$8B:F018 A9 80 00    LDA #$0080             ;\
$8B:F01B 99 7D 1A    STA $1A7D,y[$7E:1A83]  ;} Cinematic sprite object X position = 80h
$8B:F01E A9 80 00    LDA #$0080             ;\
$8B:F021 99 9D 1A    STA $1A9D,y[$7E:1AA3]  ;} Cinematic sprite object Y position = 80h
$8B:F024 A9 00 0C    LDA #$0C00             ;\
$8B:F027 99 BD 1A    STA $1ABD,y[$7E:1AC3]  ;} Cinematic sprite object palette index = C00h (palette 6)
$8B:F02A 60          RTS
}


;;; $F02B: Initialisation function - cinematic sprite object $EEC7/$EECD ('THE OPERATION WAS' / 'COMPLETED SUCCESSFULLY') ;;;
{
$8B:F02B A9 80 00    LDA #$0080             ;\
$8B:F02E 99 7D 1A    STA $1A7D,y[$7E:1A9B]  ;} Cinematic sprite object X position = 80h
$8B:F031 A9 60 00    LDA #$0060             ;\
$8B:F034 99 9D 1A    STA $1A9D,y[$7E:1ABB]  ;} Cinematic sprite object Y position = 80h
$8B:F037 A9 00 04    LDA #$0400             ;\
$8B:F03A 99 BD 1A    STA $1ABD,y[$7E:1ADB]  ;} Cinematic sprite object palette index = 400h (palette 2)
$8B:F03D 60          RTS
}


;;; $F03E: Initialisation function - cinematic sprite object $EEFD (clear time) ;;;
{
$8B:F03E A9 80 00    LDA #$0080             ;\
$8B:F041 99 7D 1A    STA $1A7D,y[$7E:1A97]  ;} Cinematic sprite object X position = 80h
$8B:F044 A9 A0 00    LDA #$00A0             ;\
$8B:F047 99 9D 1A    STA $1A9D,y[$7E:1AB7]  ;} Cinematic sprite object Y position = A0h
$8B:F04A A9 00 02    LDA #$0200             ;\
$8B:F04D 99 BD 1A    STA $1ABD,y[$7E:1AD7]  ;} Cinematic sprite object palette index = 200h (palette 1)
$8B:F050 60          RTS
}


;;; $F051:  ;;;
{
$8B:F051 A9 A0 00    LDA #$00A0             ;\
$8B:F054 99 9D 1A    STA $1A9D,y[$7E:1AB5]  ;} Cinematic sprite object Y position = A0h
$8B:F057 A9 00 00    LDA #$0000             ;\
$8B:F05A 99 BD 1A    STA $1ABD,y[$7E:1AD5]  ;} Cinematic sprite object palette index = 0 (palette 0)
$8B:F05D 60          RTS
}


;;; $F05E: Initialisation function - cinematic sprite object $EF03 (clear time - hours - tens digit) ;;;
{
$8B:F05E AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$8B:F061 20 A3 F0    JSR $F0A3  [$8B:F0A3]  ;} Cinematic sprite object instruction list pointer += [$0DEC] * 8
$8B:F064 A9 9C 00    LDA #$009C             ;\
$8B:F067 99 7D 1A    STA $1A7D,y[$7E:1A95]  ;} Cinematic sprite object X position = 9Ch
$8B:F06A 4C 51 F0    JMP $F051  [$8B:F051]  ; Go to $F051
}


;;; $F06D: Initialisation function - cinematic sprite object $EF09 (clear time - hours - units digit) ;;;
{
$8B:F06D AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$8B:F070 20 A3 F0    JSR $F0A3  [$8B:F0A3]  ;} Cinematic sprite object instruction list pointer += [$0DEE] * 8
$8B:F073 A9 A4 00    LDA #$00A4             ;\
$8B:F076 99 7D 1A    STA $1A7D,y[$7E:1A93]  ;} Cinematic sprite object X position = A4h
$8B:F079 4C 51 F0    JMP $F051  [$8B:F051]  ; Go to $F051
}


;;; $F07C: Initialisation function - cinematic sprite object $EF0F (clear time - colon) ;;;
{
$8B:F07C A9 AC 00    LDA #$00AC             ;\
$8B:F07F 99 7D 1A    STA $1A7D,y[$7E:1A91]  ;} Cinematic sprite object X position = ACh
$8B:F082 4C 51 F0    JMP $F051  [$8B:F051]  ; Go to $F051
}


;;; $F085: Initialisation function - cinematic sprite object $EF15 (clear time - minutes - tens digit) ;;;
{
$8B:F085 AD F0 0D    LDA $0DF0  [$7E:0DF0]  ;\
$8B:F088 20 A3 F0    JSR $F0A3  [$8B:F0A3]  ;} Cinematic sprite object instruction list pointer += [$0DF0] * 8
$8B:F08B A9 B4 00    LDA #$00B4             ;\
$8B:F08E 99 7D 1A    STA $1A7D,y[$7E:1A8F]  ;} Cinematic sprite object X position = B4h
$8B:F091 4C 51 F0    JMP $F051  [$8B:F051]  ; Go to $F051
}


;;; $F094: Initialisation function - cinematic sprite object $EF1B (clear time - minutes - units digit) ;;;
{
$8B:F094 AD F2 0D    LDA $0DF2  [$7E:0DF2]  ;\
$8B:F097 20 A3 F0    JSR $F0A3  [$8B:F0A3]  ;} Cinematic sprite object instruction list pointer += [$0DF2] * 8
$8B:F09A A9 BC 00    LDA #$00BC             ;\
$8B:F09D 99 7D 1A    STA $1A7D,y[$7E:1A8D]  ;} Cinematic sprite object X position = BCh
$8B:F0A0 4C 51 F0    JMP $F051  [$8B:F051]  ; Go to $F051
}


;;; $F0A3: Cinematic sprite object instruction list pointer += [A] * 8 ;;;
{
$8B:F0A3 0A          ASL A
$8B:F0A4 0A          ASL A
$8B:F0A5 0A          ASL A
$8B:F0A6 85 12       STA $12    [$7E:0012]
$8B:F0A8 B9 1D 1B    LDA $1B1D,y[$7E:1B35]
$8B:F0AB 18          CLC
$8B:F0AC 65 12       ADC $12    [$7E:0012]
$8B:F0AE 99 1D 1B    STA $1B1D,y[$7E:1B35]
$8B:F0B1 60          RTS
}


;;; $F0B2: Initialisation function - cinematic sprite object $EED3 (yellow clouds - top - top half) ;;;
{
$8B:F0B2 A9 A0 FF    LDA #$FFA0             ;\
$8B:F0B5 99 9D 1A    STA $1A9D,y[$7E:1ABB]  ;} Cinematic sprite object Y position = -60h
}


;;; $F0B8:  ;;;
{
$8B:F0B8 AD 9D 1B    LDA $1B9D  [$7E:1B9D]  ;\
$8B:F0BB F0 17       BEQ $17    [$F0D4]     ;} If [cinematic sprite object initialisation parameter] != 0:
$8B:F0BD A9 80 01    LDA #$0180             ;\
$8B:F0C0 99 7D 1A    STA $1A7D,y            ;} Cinematic sprite object X position = 180h
$8B:F0C3 A9 00 0A    LDA #$0A00             ;\
$8B:F0C6 99 BD 1A    STA $1ABD,y            ;} Cinematic sprite object palette index = A00h (palette 5)
$8B:F0C9 B9 1D 1B    LDA $1B1D,y            ;\
$8B:F0CC 18          CLC                    ;|
$8B:F0CD 69 04 00    ADC #$0004             ;} Cinematic sprite object instruction list pointer += 4
$8B:F0D0 99 1D 1B    STA $1B1D,y            ;/
$8B:F0D3 60          RTS                    ; Return

$8B:F0D4 A9 80 00    LDA #$0080             ;\
$8B:F0D7 99 7D 1A    STA $1A7D,y[$7E:1A9B]  ;} Cinematic sprite object X position = 80h
$8B:F0DA A9 00 0A    LDA #$0A00             ;\
$8B:F0DD 99 BD 1A    STA $1ABD,y[$7E:1ADB]  ;} Cinematic sprite object palette index = A00h (palette 5)
$8B:F0E0 60          RTS
}


;;; $F0E1: Initialisation function - cinematic sprite object $EED9 (yellow clouds - top - bottom half) ;;;
{
$8B:F0E1 A9 E0 FF    LDA #$FFE0             ;\
$8B:F0E4 99 9D 1A    STA $1A9D,y[$7E:1AB9]  ;} Cinematic sprite object Y position = -20h
$8B:F0E7 80 CF       BRA $CF    [$F0B8]     ; Go to $F0B8
}


;;; $F0E9: Initialisation function - cinematic sprite object $EEDF (yellow clouds - bottom - top half) ;;;
{
$8B:F0E9 A9 20 01    LDA #$0120             ;\
$8B:F0EC 99 9D 1A    STA $1A9D,y[$7E:1AB7]  ;} Cinematic sprite object Y position = 120h
$8B:F0EF 80 C7       BRA $C7    [$F0B8]     ; Go to $F0B8
}


;;; $F0F1: Initialisation function - cinematic sprite object $EEE5 (yellow clouds - bottom - bottom half) ;;;
{
$8B:F0F1 A9 60 01    LDA #$0160             ;\
$8B:F0F4 99 9D 1A    STA $1A9D,y[$7E:1AB5]  ;} Cinematic sprite object Y position = 160h
$8B:F0F7 80 BF       BRA $BF    [$F0B8]     ; Go to $F0B8
}


;;; $F0F9: Initialisation function - cinematic sprite object $EEEB (yellow clouds - right) ;;;
{
$8B:F0F9 A9 40 01    LDA #$0140             ;\
$8B:F0FC 99 7D 1A    STA $1A7D,y[$7E:1A9B]  ;} Cinematic sprite object X position = 140h
$8B:F0FF AD 9D 1B    LDA $1B9D  [$7E:1B9D]  ;\
$8B:F102 F0 0D       BEQ $0D    [$F111]     ;} If [cinematic sprite object initialisation parameter] != 0:
$8B:F104 A9 C0 01    LDA #$01C0             ;\
$8B:F107 99 9D 1A    STA $1A9D,y[$7E:1AB7]  ;} Cinematic sprite object Y position = 1C0h
$8B:F10A A9 00 0A    LDA #$0A00             ;\
$8B:F10D 99 BD 1A    STA $1ABD,y[$7E:1AD7]  ;} Cinematic sprite object palette index = A00h (palette 5)
$8B:F110 60          RTS                    ; Return

$8B:F111 A9 C0 00    LDA #$00C0             ;\
$8B:F114 99 9D 1A    STA $1A9D,y[$7E:1ABB]  ;} Cinematic sprite object Y position = C0h
$8B:F117 A9 00 0A    LDA #$0A00             ;\
$8B:F11A 99 BD 1A    STA $1ABD,y[$7E:1ADB]  ;} Cinematic sprite object palette index = A00h (palette 5)
$8B:F11D 60          RTS
}


;;; $F11E: Initialisation function - cinematic sprite object $EEF1 (yellow clouds - left) ;;;
{
$8B:F11E A9 C0 FF    LDA #$FFC0             ;\
$8B:F121 99 7D 1A    STA $1A7D,y[$7E:1A99]  ;} Cinematic sprite object X position = -40h
$8B:F124 AD 9D 1B    LDA $1B9D  [$7E:1B9D]  ;\
$8B:F127 F0 0D       BEQ $0D    [$F136]     ;} If [cinematic sprite object initialisation parameter] != 0:
$8B:F129 A9 40 FF    LDA #$FF40             ;\
$8B:F12C 99 9D 1A    STA $1A9D,y[$7E:1AB5]  ;} Cinematic sprite object Y position = -C0h
$8B:F12F A9 00 0A    LDA #$0A00             ;\
$8B:F132 99 BD 1A    STA $1ABD,y[$7E:1AD5]  ;} Cinematic sprite object palette index = A00h (palette 5)
$8B:F135 60          RTS                    ; Return

$8B:F136 A9 40 00    LDA #$0040             ;\
$8B:F139 99 9D 1A    STA $1A9D,y[$7E:1AB9]  ;} Cinematic sprite object Y position = 40h
$8B:F13C A9 00 0A    LDA #$0A00             ;\
$8B:F13F 99 BD 1A    STA $1ABD,y[$7E:1AD9]  ;} Cinematic sprite object palette index = A00h (palette 5)
$8B:F142 60          RTS
}


;;; $F143: Initialisation function - cinematic sprite object $EF27/$EF2D/$EF33/$EF39/$EF3F (suitless Samus) ;;;
{
$8B:F143 A9 78 00    LDA #$0078             ;\
$8B:F146 99 7D 1A    STA $1A7D,y[$7E:1A9B]  ;} Cinematic sprite object X position = 78h
$8B:F149 A9 88 00    LDA #$0088             ;\
$8B:F14C 99 9D 1A    STA $1A9D,y[$7E:1ABB]  ;} Cinematic sprite object Y position = 88h
$8B:F14F A9 00 0A    LDA #$0A00             ;\
$8B:F152 99 BD 1A    STA $1ABD,y[$7E:1ADB]  ;} Cinematic sprite object palette index = A00h (palette 5)
$8B:F155 60          RTS
}


;;; $F156: Initialisation function - cinematic sprite object $EF45/$EF57/$EF5D/$EF6F (suited Samus body / arm) ;;;
{
$8B:F156 A9 78 00    LDA #$0078             ;\
$8B:F159 99 7D 1A    STA $1A7D,y            ;} Cinematic sprite object X position = 78h
$8B:F15C A9 98 00    LDA #$0098             ;\
$8B:F15F 99 9D 1A    STA $1A9D,y            ;} Cinematic sprite object Y position = 98h
$8B:F162 A9 00 0C    LDA #$0C00             ;\
$8B:F165 99 BD 1A    STA $1ABD,y            ;} Cinematic sprite object palette index = C00h (palette 6)
$8B:F168 60          RTS
}


;;; $F169: Initialisation function - cinematic sprite object $EF4B/$EF63/$EF75 (suited Samus head - with helmet) ;;;
{
$8B:F169 A9 7C 00    LDA #$007C             ;\
$8B:F16C 99 7D 1A    STA $1A7D,y            ;} Cinematic sprite object X position = 7Ch
$8B:F16F A9 6C 00    LDA #$006C             ;\
$8B:F172 99 9D 1A    STA $1A9D,y            ;} Cinematic sprite object Y position = 6Ch
$8B:F175 A9 00 0C    LDA #$0C00             ;\
$8B:F178 99 BD 1A    STA $1ABD,y            ;} Cinematic sprite object palette index = C00h (palette 6)
$8B:F17B 60          RTS
}


;;; $F17C: Initialisation function - cinematic sprite object $EF51/$EF69/$EF7B (suited Samus head - without helmet) ;;;
{
$8B:F17C A9 79 00    LDA #$0079             ;\
$8B:F17F 99 7D 1A    STA $1A7D,y            ;} Cinematic sprite object X position = 79h
$8B:F182 A9 6B 00    LDA #$006B             ;\
$8B:F185 99 9D 1A    STA $1A9D,y            ;} Cinematic sprite object Y position = 6Bh
$8B:F188 A9 00 0A    LDA #$0A00             ;\
$8B:F18B 99 BD 1A    STA $1ABD,y            ;} Cinematic sprite object palette index = A00h (palette 5)
$8B:F18E 60          RTS
}


;;; $F18F: Initialisation function - cinematic sprite object $EF81 (Super Metroid icon - S - top half) ;;;
{
$8B:F18F A9 12 02    LDA #$0212             ;\
$8B:F192 99 7D 1A    STA $1A7D,y[$7E:1A9B]  ;} Cinematic sprite object X position = 212h
$8B:F195 A9 E7 00    LDA #$00E7             ;\
$8B:F198 99 9D 1A    STA $1A9D,y[$7E:1ABB]  ;} Cinematic sprite object Y position = E7h
$8B:F19B A9 00 0E    LDA #$0E00             ;\
$8B:F19E 99 BD 1A    STA $1ABD,y[$7E:1ADB]  ;} Cinematic sprite object palette index = E00h (palette 7)
$8B:F1A1 A9 08 00    LDA #$0008             ;\
$8B:F1A4 99 7D 1B    STA $1B7D,y[$7E:1B9B]  ;} Cinematic sprite object timer = 8
$8B:F1A7 60          RTS
}


;;; $F1A8: Initialisation function - cinematic sprite object $EF87 (Super Metroid icon - S - bottom half) ;;;
{
$8B:F1A8 A9 F6 00    LDA #$00F6             ;\
$8B:F1AB 99 7D 1A    STA $1A7D,y[$7E:1A99]  ;} Cinematic sprite object X position = F6h
$8B:F1AE A9 07 02    LDA #$0207             ;\
$8B:F1B1 99 9D 1A    STA $1A9D,y[$7E:1AB9]  ;} Cinematic sprite object Y position = 207h
$8B:F1B4 A9 00 0E    LDA #$0E00             ;\
$8B:F1B7 99 BD 1A    STA $1ABD,y[$7E:1AD9]  ;} Cinematic sprite object palette index = E00h (palette 7)
$8B:F1BA A9 08 00    LDA #$0008             ;\
$8B:F1BD 99 7D 1B    STA $1B7D,y[$7E:1B99]  ;} Cinematic sprite object timer = 8
$8B:F1C0 60          RTS
}


;;; $F1C1: Initialisation function - cinematic sprite object $EF8D (Super Metroid icon - circle - top half) ;;;
{
$8B:F1C1 A9 81 01    LDA #$0181             ;\
$8B:F1C4 99 7D 1A    STA $1A7D,y[$7E:1A97]  ;} Cinematic sprite object X position = 181h
$8B:F1C7 A9 6E 01    LDA #$016E             ;\
$8B:F1CA 99 9D 1A    STA $1A9D,y[$7E:1AB7]  ;} Cinematic sprite object Y position = 16Eh
$8B:F1CD A9 00 0E    LDA #$0E00             ;\
$8B:F1D0 99 BD 1A    STA $1ABD,y[$7E:1AD7]  ;} Cinematic sprite object palette index = E00h (palette 7)
$8B:F1D3 60          RTS
}


;;; $F1D4: Initialisation function - cinematic sprite object $EF93 (Super Metroid icon - circle - bottom half) ;;;
{
$8B:F1D4 A9 87 01    LDA #$0187             ;\
$8B:F1D7 99 7D 1A    STA $1A7D,y[$7E:1A95]  ;} Cinematic sprite object X position = 187h
$8B:F1DA A9 80 01    LDA #$0180             ;\
$8B:F1DD 99 9D 1A    STA $1A9D,y[$7E:1AB5]  ;} Cinematic sprite object Y position = 180h
$8B:F1E0 A9 00 0E    LDA #$0E00             ;\
$8B:F1E3 99 BD 1A    STA $1ABD,y[$7E:1AD5]  ;} Cinematic sprite object palette index = E00h (palette 7)
$8B:F1E6 60          RTS
}
}


;;; $F1E7..F6F7: Cinematic sprite object pre-instructions and instructions ;;;
{
;;; $F1E7: Pre-instruction - cinematic sprite object $EF81 (Super Metroid icon - S - top half) ;;;
{
$8B:F1E7 BD 9D 1A    LDA $1A9D,x[$7E:1ABB]  ;\
$8B:F1EA 18          CLC                    ;|
$8B:F1EB 7D 7D 1B    ADC $1B7D,x[$7E:1B9B]  ;} Cinematic sprite object Y position += [cinematic sprite object speed]
$8B:F1EE 9D 9D 1A    STA $1A9D,x[$7E:1ABB]  ;/
$8B:F1F1 BD 7D 1A    LDA $1A7D,x[$7E:1A9B]  ;\
$8B:F1F4 38          SEC                    ;|
$8B:F1F5 FD 7D 1B    SBC $1B7D,x[$7E:1B9B]  ;} Cinematic sprite object X position -= [cinematic sprite object speed]
$8B:F1F8 9D 7D 1A    STA $1A7D,x[$7E:1A9B]  ;/
$8B:F1FB C9 8B 01    CMP #$018B             ;\
$8B:F1FE 10 1C       BPL $1C    [$F21C]     ;} If [cinematic sprite object X position] < 18Bh:
$8B:F200 A9 8A 01    LDA #$018A             ;\
$8B:F203 9D 7D 1A    STA $1A7D,x[$7E:1A9B]  ;} Cinematic sprite object X position = 18Ah
$8B:F206 A9 6F 01    LDA #$016F             ;\
$8B:F209 9D 9D 1A    STA $1A9D,x[$7E:1ABB]  ;} Cinematic sprite object Y position = 16Fh
$8B:F20C A9 D9 93    LDA #$93D9             ;\
$8B:F20F 9D 3D 1B    STA $1B3D,x[$7E:1B5B]  ;} Cinematic sprite object pre-instruction = RTS
$8B:F212 5A          PHY                    ;\
$8B:F213 A0 00 E2    LDY #$E200             ;|
$8B:F216 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E200 (post-credits Super Metroid icon)
$8B:F21A 7A          PLY                    ;/
$8B:F21B 60          RTS                    ; Return

$8B:F21C BD 7D 1B    LDA $1B7D,x[$7E:1B9B]  ;\
$8B:F21F 18          CLC                    ;|
$8B:F220 69 02 00    ADC #$0002             ;} Cinematic sprite object speed += 2
$8B:F223 9D 7D 1B    STA $1B7D,x[$7E:1B9B]  ;/
$8B:F226 60          RTS
}


;;; $F227: Pre-instruction - cinematic sprite object $EF87 (Super Metroid icon - S - bottom half) ;;;
{
$8B:F227 BD 9D 1A    LDA $1A9D,x[$7E:1AB9]  ;\
$8B:F22A 38          SEC                    ;|
$8B:F22B FD 7D 1B    SBC $1B7D,x[$7E:1B99]  ;} Cinematic sprite object Y position -= [cinematic sprite object speed]
$8B:F22E 9D 9D 1A    STA $1A9D,x[$7E:1AB9]  ;/
$8B:F231 BD 7D 1A    LDA $1A7D,x[$7E:1A99]  ;\
$8B:F234 18          CLC                    ;|
$8B:F235 7D 7D 1B    ADC $1B7D,x[$7E:1B99]  ;} Cinematic sprite object X position += [cinematic sprite object speed]
$8B:F238 9D 7D 1A    STA $1A7D,x[$7E:1A99]  ;/
$8B:F23B C9 7E 01    CMP #$017E             ;\
$8B:F23E 30 13       BMI $13    [$F253]     ;} If [cinematic sprite object X position] >= 17Eh:
$8B:F240 A9 7E 01    LDA #$017E             ;\
$8B:F243 9D 7D 1A    STA $1A7D,x[$7E:1A99]  ;} Cinematic sprite object X position = 17Eh
$8B:F246 A9 7F 01    LDA #$017F             ;\
$8B:F249 9D 9D 1A    STA $1A9D,x[$7E:1AB9]  ;} Cinematic sprite object Y position = 17Fh
$8B:F24C A9 D9 93    LDA #$93D9             ;\
$8B:F24F 9D 3D 1B    STA $1B3D,x[$7E:1B59]  ;} Cinematic sprite object pre-instruction = RTS
$8B:F252 60          RTS                    ; Return
                                            
$8B:F253 BD 7D 1B    LDA $1B7D,x[$7E:1B99]  ;\
$8B:F256 18          CLC                    ;|
$8B:F257 69 02 00    ADC #$0002             ;} Cinematic sprite object speed += 2
$8B:F25A 9D 7D 1B    STA $1B7D,x[$7E:1B99]  ;/
$8B:F25D 60          RTS
}


;;; $F25E: Instruction ;;;
{
$8B:F25E E2 20       SEP #$20
$8B:F260 A9 03       LDA #$03               ;\
$8B:F262 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2
$8B:F264 A9 10       LDA #$10               ;\
$8B:F266 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = sprites
$8B:F268 A9 02       LDA #$02               ;\
$8B:F26A 85 6F       STA $6F    [$7E:006F]  ;} Enable subscreen layers
$8B:F26C A9 22       LDA #$22               ;\
$8B:F26E 85 72       STA $72    [$7E:0072]  ;} Enable colour math on BG2/backdrop
$8B:F270 A9 64       LDA #$64               ;\
$8B:F272 85 5D       STA $5D    [$7E:005D]  ;} BG1 tiles base address = $4000, BG2 tiles base address = $6000
$8B:F274 A9 54       LDA #$54               ;\
$8B:F276 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $5400, size = 32x32
$8B:F278 C2 20       REP #$20
$8B:F27A 9C 49 1A    STZ $1A49  [$7E:1A49]  ; Cinematic function timer = 0
$8B:F27D A9 8A E5    LDA #$E58A             ;\
$8B:F280 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $E58A
$8B:F283 60          RTS
}


;;; $F284: Instruction - fade out zoomed out exploding Zebes ;;;
{
$8B:F284 5A          PHY
$8B:F285 A0 C4 E1    LDY #$E1C4             ;\
$8B:F288 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1C4 (fade out zoomed out exploding Zebes)
$8B:F28C A9 01 00    LDA #$0001             ;\
$8B:F28F 8F FC C1 7E STA $7EC1FC[$7E:C1FC]  ;} Sprite palette 7 colour Eh = 1 (almost black)
$8B:F293 7A          PLY
$8B:F294 60          RTS
}


;;; $F295: Instruction - spawn Zebes explosion silhouette cinematic sprite object ;;;
{
$8B:F295 5A          PHY
$8B:F296 A0 B5 EE    LDY #$EEB5             ;\
$8B:F299 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EEB5 (Zebes explosion - silhouette)
$8B:F29C A9 FF 7F    LDA #$7FFF             ;\
$8B:F29F 8F 00 C0 7E STA $7EC000[$7E:C000]  ;} Main screen backdrop colour = 7FFFh (white)
$8B:F2A3 7A          PLY
$8B:F2A4 60          RTS
}


;;; $F2A5: Pre-instruction - cinematic sprite object $EEA3/$EEA9/$EEAF (exploding Zebes - purple glow / stars / lava) ;;;
{
; Cinematic sprite object Fh is exploding Zebes - Zebes
$8B:F2A5 AD 3B 1B    LDA $1B3B  [$7E:1B3B]  ;\
$8B:F2A8 D0 0C       BNE $0C    [$F2B6]     ;} If [cinematic sprite object Fh instruction list pointer] = 0:
$8B:F2AA A9 01 00    LDA #$0001             ;\
$8B:F2AD 9D 5D 1B    STA $1B5D,x[$7E:1B79]  ;} Cinematic sprite object instruction timer = 1
$8B:F2B0 A9 9B EE    LDA #$EE9B             ;\
$8B:F2B3 9D 1D 1B    STA $1B1D,x[$7E:1B39]  ;} Cinematic sprite object instruction list pointer = $EE9B (delete)

$8B:F2B6 60          RTS
}


;;; $F2B7: Instruction - start Zebes explosion ;;;
{
$8B:F2B7 5A          PHY
$8B:F2B8 E2 20       SEP #$20
$8B:F2BA A9 11       LDA #$11               ;\
$8B:F2BC 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$8B:F2BE A9 02       LDA #$02               ;\
$8B:F2C0 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG2
$8B:F2C2 A9 02       LDA #$02               ;\
$8B:F2C4 85 6F       STA $6F    [$7E:006F]  ;} Enable subscreen layers
$8B:F2C6 A9 11       LDA #$11               ;\
$8B:F2C8 85 72       STA $72    [$7E:0072]  ;} Enable colour math on BG1/sprites
$8B:F2CA A9 7C       LDA #$7C               ;\
$8B:F2CC 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $7C00, size = 32x32
$8B:F2CE C2 20       REP #$20
$8B:F2D0 A0 BB EE    LDY #$EEBB             ;\
$8B:F2D3 64 12       STZ $12    [$7E:0012]  ;} Spawn cinematic sprite object $EEBB to index 0 (Zebes explosion - stars - right)
$8B:F2D5 20 A2 93    JSR $93A2  [$8B:93A2]  ;/
$8B:F2D8 A0 F7 EE    LDY #$EEF7             ;\
$8B:F2DB A9 02 00    LDA #$0002             ;|
$8B:F2DE 85 12       STA $12    [$7E:0012]  ;} Spawn cinematic sprite object $EEF7 to index 2 (Zebes explosion - stars - left)
$8B:F2E0 20 A2 93    JSR $93A2  [$8B:93A2]  ;/
$8B:F2E3 A0 C8 E1    LDY #$E1C8             ;\
$8B:F2E6 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1C8 (wide part of Zebes explosion - foreground)
$8B:F2EA A0 D0 E1    LDY #$E1D0             ;\
$8B:F2ED 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1D0 (white out space during Zebes explosion)
$8B:F2F1 A0 E8 E1    LDY #$E1E8             ;\
$8B:F2F4 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1E8 (wide part of Zebes explosion - background)
$8B:F2F8 7A          PLY
$8B:F2F9 60          RTS
}


;;; $F2FA: Instruction - Zebes explosion finale ;;;
{
$8B:F2FA 5A          PHY
$8B:F2FB E2 20       SEP #$20
$8B:F2FD A9 03       LDA #$03               ;\
$8B:F2FF 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2
$8B:F301 A9 12       LDA #$12               ;\
$8B:F303 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG2/sprites
$8B:F305 A9 02       LDA #$02               ;\
$8B:F307 85 6F       STA $6F    [$7E:006F]  ;} Enable subscreen layers
$8B:F309 A9 33       LDA #$33               ;\
$8B:F30B 85 72       STA $72    [$7E:0072]  ;} Enable colour math on BG1/BG2/sprites/backdrop
$8B:F30D A9 74       LDA #$74               ;\
$8B:F30F 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $7400, size = 32x32
$8B:F311 A9 78       LDA #$78               ;\
$8B:F313 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $7800, size = 32x32
$8B:F315 C2 20       REP #$20
$8B:F317 A0 CC E1    LDY #$E1CC             ;\
$8B:F31A 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1CC (Zebes explosion finale)
$8B:F31E A0 C1 EE    LDY #$EEC1             ;\
$8B:F321 A9 06 00    LDA #$0006             ;|
$8B:F324 85 12       STA $12    [$7E:0012]  ;} Spawn cinematic sprite object $EEC1 to index 6 (Zebes explosion - afterglow)
$8B:F326 20 A2 93    JSR $93A2  [$8B:93A2]  ;/
$8B:F329 7A          PLY
$8B:F32A 60          RTS
}


;;; $F32B: Instruction - end Zebes explosion ;;;
{
$8B:F32B 5A          PHY
$8B:F32C E2 20       SEP #$20
$8B:F32E 64 69       STZ $69    [$7E:0069]  ; Disable all main screen layers
$8B:F330 64 6B       STZ $6B    [$7E:006B]  ; Disable all subscreen layers
$8B:F332 C2 20       REP #$20
$8B:F334 A9 FF 7F    LDA #$7FFF             ;\
$8B:F337 8F 00 C0 7E STA $7EC000[$7E:C000]  ;} Main screen backdrop colour = 7FFFh (white)
$8B:F33B 8F 00 C1 7E STA $7EC100[$7E:C100]  ; Sprite palette 0 colour 0 = 7FFFh (maybe not used for sprites here?)
$8B:F33F DA          PHX                    ;\
$8B:F340 A2 1E 00    LDX #$001E             ;|
                                            ;|
$8B:F343 9F 20 C0 7E STA $7EC020,x[$7E:C03E];|
$8B:F347 CA          DEX                    ;} BG1/2 palette 1 = 7FFFh
$8B:F348 CA          DEX                    ;|
$8B:F349 10 F8       BPL $F8    [$F343]     ;|
$8B:F34B FA          PLX                    ;/
$8B:F34C A9 9E DB    LDA #$DB9E             ;\
$8B:F34F 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $DB9E
$8B:F352 A9 78 00    LDA #$0078             ;\
$8B:F355 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 120
$8B:F358 7A          PLY
$8B:F359 60          RTS
}


;;; $F35A: Pre-instruction - cinematic sprite object $EEF7 (Zebes explosion - stars - left) ;;;
{
$8B:F35A AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:F35D C9 A5 DC    CMP #$DCA5             ;} If [cinematic function] = $DCA5:
$8B:F360 D0 12       BNE $12    [$F374]     ;/
$8B:F362 A9 75 F3    LDA #$F375             ;\
$8B:F365 9D 3D 1B    STA $1B3D,x[$7E:1B3F]  ;} Cinematic sprite object pre-instruction = $F375
$8B:F368 A9 00 40    LDA #$4000             ;\
$8B:F36B 9D FD 1A    STA $1AFD,x[$7E:1AFF]  ;|
$8B:F36E A9 00 00    LDA #$0000             ;} Cinematic sprite object X velocity = 0.4000h
$8B:F371 9D 7D 1B    STA $1B7D,x[$7E:1B7F]  ;/

$8B:F374 60          RTS
}


;;; $F375: Pre-instruction ;;;
{
$8B:F375 BD FD 1A    LDA $1AFD,x[$7E:1AFF]  ;\
$8B:F378 18          CLC                    ;|
$8B:F379 69 E0 FF    ADC #$FFE0             ;|
$8B:F37C 9D FD 1A    STA $1AFD,x[$7E:1AFF]  ;} Cinematic sprite object X velocity -= 0.0020h
$8B:F37F BD 7D 1B    LDA $1B7D,x[$7E:1B7F]  ;|
$8B:F382 69 FF FF    ADC #$FFFF             ;|
$8B:F385 9D 7D 1B    STA $1B7D,x[$7E:1B7F]  ;/
$8B:F388 BD DD 1A    LDA $1ADD,x[$7E:1ADF]  ;\
$8B:F38B 18          CLC                    ;|
$8B:F38C 7D FD 1A    ADC $1AFD,x[$7E:1AFF]  ;|
$8B:F38F 9D DD 1A    STA $1ADD,x[$7E:1ADF]  ;} Cinematic sprite object X position += [cinematic sprite object X velocity]
$8B:F392 BD 7D 1A    LDA $1A7D,x[$7E:1A7F]  ;|
$8B:F395 7D 7D 1B    ADC $1B7D,x[$7E:1B7F]  ;|
$8B:F398 9D 7D 1A    STA $1A7D,x[$7E:1A7F]  ;/
}


;;; $F39B: Pre-instruction - cinematic sprite object $EEC1 (Zebes explosion - afterglow) ;;;
{
$8B:F39B AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:F39E C9 63 DE    CMP #$DE63             ;} If [cinematic function] = $DE63:
$8B:F3A1 D0 0C       BNE $0C    [$F3AF]     ;/
$8B:F3A3 A9 01 00    LDA #$0001             ;\
$8B:F3A6 9D 5D 1B    STA $1B5D,x[$7E:1B63]  ;} Cinematic sprite object instruction timer = 1
$8B:F3A9 A9 9B EE    LDA #$EE9B             ;\
$8B:F3AC 9D 1D 1B    STA $1B1D,x[$7E:1B23]  ;} Cinematic sprite object instruction list pointer = $EE9B (delete)

$8B:F3AF 60          RTS
}


;;; $F3B0: Instruction - spawn 'COMPLETED SUCCESSFULLY' cinematic sprite object ;;;
{
$8B:F3B0 5A          PHY                    ;\
$8B:F3B1 A0 CD EE    LDY #$EECD             ;|
$8B:F3B4 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EECD ('COMPLETED SUCCESSFULLY')
$8B:F3B7 7A          PLY                    ;/
$8B:F3B8 60          RTS
}


;;; $F3B9: Pre-instruction - cinematic sprite object $EEC7/$EECD/$EEFD/$EF03/$EF09/$EF0F/$EF15/$EF1B (text) ;;;
{
$8B:F3B9 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:F3BC C9 80 DE    CMP #$DE80             ;} If [cinematic function] = $DE80:
$8B:F3BF D0 0C       BNE $0C    [$F3CD]     ;/
$8B:F3C1 A9 01 00    LDA #$0001             ;\
$8B:F3C4 9D 5D 1B    STA $1B5D,x[$7E:1B7B]  ;} Cinematic sprite object instruction timer = 1
$8B:F3C7 A9 9B EE    LDA #$EE9B             ;\
$8B:F3CA 9D 1D 1B    STA $1B1D,x[$7E:1B3B]  ;} Cinematic sprite object instruction list pointer = $EE9B (delete)

$8B:F3CD 60          RTS
}


;;; $F3CE: Instruction - spawn clear time cinematic sprite object ;;;
{
$8B:F3CE 5A          PHY
$8B:F3CF A0 FD EE    LDY #$EEFD             ;\
$8B:F3D2 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EEFD (clear time)
$8B:F3D5 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:F3D8 8D 04 42    STA $4204  [$7E:4204]  ;|
$8B:F3DB E2 20       SEP #$20               ;|
$8B:F3DD A9 0A       LDA #$0A               ;|
$8B:F3DF 8D 06 42    STA $4206  [$7E:4206]  ;|
$8B:F3E2 EA          NOP                    ;|
$8B:F3E3 EA          NOP                    ;|
$8B:F3E4 EA          NOP                    ;|
$8B:F3E5 EA          NOP                    ;} $0DEC = [game time, hours] / 10
$8B:F3E6 EA          NOP                    ;} $0DEE = [game time, hours] % 10
$8B:F3E7 EA          NOP                    ;|
$8B:F3E8 EA          NOP                    ;|
$8B:F3E9 C2 20       REP #$20               ;|
$8B:F3EB AD 14 42    LDA $4214  [$7E:4214]  ;|
$8B:F3EE 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;|
$8B:F3F1 AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:F3F4 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;/
$8B:F3F7 AD DE 09    LDA $09DE  [$7E:09DE]  ;\
$8B:F3FA 8D 04 42    STA $4204  [$7E:4204]  ;|
$8B:F3FD E2 20       SEP #$20               ;|
$8B:F3FF A9 0A       LDA #$0A               ;|
$8B:F401 8D 06 42    STA $4206  [$7E:4206]  ;|
$8B:F404 EA          NOP                    ;|
$8B:F405 EA          NOP                    ;|
$8B:F406 EA          NOP                    ;|
$8B:F407 EA          NOP                    ;} $0DF0 = [game time, minutes] / 10
$8B:F408 EA          NOP                    ;} $0DF2 = [game time, minutes] % 10
$8B:F409 EA          NOP                    ;|
$8B:F40A EA          NOP                    ;|
$8B:F40B C2 20       REP #$20               ;|
$8B:F40D AD 14 42    LDA $4214  [$7E:4214]  ;|
$8B:F410 8D F0 0D    STA $0DF0  [$7E:0DF0]  ;|
$8B:F413 AD 16 42    LDA $4216  [$7E:4216]  ;|
$8B:F416 8D F2 0D    STA $0DF2  [$7E:0DF2]  ;/
$8B:F419 7A          PLY
$8B:F41A 60          RTS
}


;;; $F41B: Instruction - spawn clear time hours tens digit cinematic sprite object ;;;
{
$8B:F41B 5A          PHY                    ;\
$8B:F41C A0 03 EF    LDY #$EF03             ;|
$8B:F41F 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF03 (clear time - hours - tens digit)
$8B:F422 7A          PLY                    ;/
$8B:F423 60          RTS
}


;;; $F424: Instruction - spawn clear time hours units digit cinematic sprite object ;;;
{
$8B:F424 5A          PHY                    ;\
$8B:F425 A0 09 EF    LDY #$EF09             ;|
$8B:F428 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF09 (clear time - hours - units digit)
$8B:F42B 7A          PLY                    ;/
$8B:F42C 60          RTS
}


;;; $F42D: Instruction - spawn clear time colon cinematic sprite object ;;;
{
$8B:F42D 5A          PHY                    ;\
$8B:F42E A0 0F EF    LDY #$EF0F             ;|
$8B:F431 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF0F (clear time - colon)
$8B:F434 7A          PLY                    ;/
$8B:F435 60          RTS
}


;;; $F436: Instruction - spawn clear time minutes tens digit cinematic sprite object ;;;
{
$8B:F436 5A          PHY                    ;\
$8B:F437 A0 15 EF    LDY #$EF15             ;|
$8B:F43A 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF15 (clear time - minutes - tens digit)
$8B:F43D 7A          PLY                    ;/
$8B:F43E 60          RTS
}


;;; $F43F: Instruction - spawn clear time minutes units digit cinematic sprite object ;;;
{
$8B:F43F 5A          PHY                    ;\
$8B:F440 A0 1B EF    LDY #$EF1B             ;|
$8B:F443 20 8A 93    JSR $938A  [$8B:938A]  ;} Spawn cinematic sprite object $EF1B (clear time - minutes - units digit)
$8B:F446 7A          PLY                    ;/
$8B:F447 60          RTS
}


;;; $F448: Instruction - transition to credits ;;;
{
$8B:F448 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$8B:F44B 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$8B:F44E A9 64 DE    LDA #$DE64             ;\
$8B:F451 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $DE64
$8B:F454 60          RTS
}


;;; $F455: Pre-instruction - cinematic sprite object $EED3/$EED9 (yellow clouds - top) ;;;
{
$8B:F455 AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:F458 C9 B0 00    CMP #$00B0             ;} If [mode 7 transformation zoom level] < B0h:
$8B:F45B 10 06       BPL $06    [$F463]     ;/
$8B:F45D A9 64 F4    LDA #$F464             ;\
$8B:F460 9D 3D 1B    STA $1B3D,x[$7E:1B5B]  ;} Cinematic sprite object pre-instruction = $F464

$8B:F463 60          RTS
}


;;; $F464: Pre-instruction ;;;
{
$8B:F464 BD FD 1A    LDA $1AFD,x[$7E:1B1B]
$8B:F467 18          CLC
$8B:F468 69 00 00    ADC #$0000
$8B:F46B 9D FD 1A    STA $1AFD,x[$7E:1B1B]
$8B:F46E BD 9D 1A    LDA $1A9D,x[$7E:1ABB]  ;\
$8B:F471 69 01 00    ADC #$0001             ;} Cinematic sprite object Y position += 1
$8B:F474 9D 9D 1A    STA $1A9D,x[$7E:1ABB]  ;/
$8B:F477 60          RTS
}


;;; $F478: Pre-instruction - cinematic sprite object $EEDF/$EEE5 (yellow clouds - bottom) ;;;
{
$8B:F478 AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:F47B C9 B0 00    CMP #$00B0             ;} If [mode 7 transformation zoom level] < B0h:
$8B:F47E 10 06       BPL $06    [$F486]     ;/
$8B:F480 A9 87 F4    LDA #$F487             ;\
$8B:F483 9D 3D 1B    STA $1B3D,x[$7E:1B57]  ;} Cinematic sprite object pre-instruction = $F487

$8B:F486 60          RTS
}


;;; $F487: Pre-instruction ;;;
{
$8B:F487 BD FD 1A    LDA $1AFD,x[$7E:1B17]
$8B:F48A 38          SEC
$8B:F48B E9 00 00    SBC #$0000
$8B:F48E 9D FD 1A    STA $1AFD,x[$7E:1B17]
$8B:F491 BD 9D 1A    LDA $1A9D,x[$7E:1AB7]  ;\
$8B:F494 E9 01 00    SBC #$0001             ;} Cinematic sprite object Y position -= 1
$8B:F497 9D 9D 1A    STA $1A9D,x[$7E:1AB7]  ;/
$8B:F49A 60          RTS
}


;;; $F49B: Pre-instruction - cinematic sprite object $EEEB (yellow clouds - right) ;;;
{
$8B:F49B AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:F49E C9 60 00    CMP #$0060             ;} If [mode 7 transformation zoom level] < 60h:
$8B:F4A1 30 06       BMI $06    [$F4A9]     ;/
$8B:F4A3 A9 AA F4    LDA #$F4AA             ;\
$8B:F4A6 9D 3D 1B    STA $1B3D,x[$7E:1B5B]  ;} Cinematic sprite object pre-instruction = $F4AA

$8B:F4A9 60          RTS
}


;;; $F4AA: Pre-instruction ;;;
{
$8B:F4AA BD FD 1A    LDA $1AFD,x[$7E:1B1B]
$8B:F4AD 38          SEC
$8B:F4AE E9 00 00    SBC #$0000
$8B:F4B1 9D FD 1A    STA $1AFD,x[$7E:1B1B]
$8B:F4B4 BD 9D 1A    LDA $1A9D,x[$7E:1ABB]  ;\
$8B:F4B7 E9 02 00    SBC #$0002             ;} Cinematic sprite object Y position -= 2
$8B:F4BA 9D 9D 1A    STA $1A9D,x[$7E:1ABB]  ;/
$8B:F4BD BD DD 1A    LDA $1ADD,x[$7E:1AFB]
$8B:F4C0 38          SEC
$8B:F4C1 E9 00 00    SBC #$0000
$8B:F4C4 9D DD 1A    STA $1ADD,x[$7E:1AFB]
$8B:F4C7 BD 7D 1A    LDA $1A7D,x[$7E:1A9B]  ;\
$8B:F4CA E9 01 00    SBC #$0001             ;} Cinematic sprite object X position -= 1
$8B:F4CD 9D 7D 1A    STA $1A7D,x[$7E:1A9B]  ;/
$8B:F4D0 60          RTS
}


;;; $F4D1: Pre-instruction - cinematic sprite object $EEF1 (yellow clouds - left) ;;;
{
$8B:F4D1 AD 8F 19    LDA $198F  [$7E:198F]  ;\
$8B:F4D4 C9 60 00    CMP #$0060             ;} If [mode 7 transformation zoom level] < 60h:
$8B:F4D7 30 06       BMI $06    [$F4DF]     ;/
$8B:F4D9 A9 E0 F4    LDA #$F4E0             ;\
$8B:F4DC 9D 3D 1B    STA $1B3D,x[$7E:1B59]  ;} Cinematic sprite object pre-instruction = $F4E0

$8B:F4DF 60          RTS
}


;;; $F4E0: Pre-instruction ;;;
{
$8B:F4E0 BD FD 1A    LDA $1AFD,x[$7E:1B19]
$8B:F4E3 18          CLC
$8B:F4E4 69 00 00    ADC #$0000
$8B:F4E7 9D FD 1A    STA $1AFD,x[$7E:1B19]
$8B:F4EA BD 9D 1A    LDA $1A9D,x[$7E:1AB9]  ;\
$8B:F4ED 69 02 00    ADC #$0002             ;} Cinematic sprite object Y position -= 2
$8B:F4F0 9D 9D 1A    STA $1A9D,x[$7E:1AB9]  ;/
$8B:F4F3 BD DD 1A    LDA $1ADD,x[$7E:1AF9]  
$8B:F4F6 18          CLC                    
$8B:F4F7 69 00 00    ADC #$0000             
$8B:F4FA 9D DD 1A    STA $1ADD,x[$7E:1AF9]  
$8B:F4FD BD 7D 1A    LDA $1A7D,x[$7E:1A99]  ;\
$8B:F500 69 01 00    ADC #$0001             ;} Cinematic sprite object X position -= 1
$8B:F503 9D 7D 1A    STA $1A7D,x[$7E:1A99]  ;/
$8B:F506 60          RTS
}


;;; $F507: Pre-instruction - cinematic sprite object $EF27/$EF2D/$EF45/$EF4B/$EF51 (Samus - idle) ;;;
{
$8B:F507 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8B:F50A C9 9D DB    CMP #$DB9D             ;} If [cinematic function] = $DB9D:
$8B:F50D D0 0C       BNE $0C    [$F51B]     ;/
$8B:F50F A9 01 00    LDA #$0001             ;\
$8B:F512 9D 5D 1B    STA $1B5D,x[$7E:1B7B]  ;} Cinematic sprite object instruction timer = 1
$8B:F515 A9 9B EE    LDA #$EE9B             ;\
$8B:F518 9D 1D 1B    STA $1B1D,x[$7E:1B3B]  ;} Cinematic sprite object instruction list pointer = $EE9B (delete)

$8B:F51B 60          RTS
}


;;; $F51C: RTS. Pre-instruction - cinematic sprite object $EF33 (suitless Samus - letting hair down) ;;;
{
$8B:F51C 60          RTS
}


;;; $F51D: Instruction - spawn suitless Samus jump cinematic sprite object ;;;
{
$8B:F51D 5A          PHY                    ;\
$8B:F51E A0 3F EF    LDY #$EF3F             ;|
$8B:F521 64 12       STZ $12    [$7E:0012]  ;} Spawn cinematic sprite object $EF3F to index 0 (suitless Samus - jump)
$8B:F523 20 A2 93    JSR $93A2  [$8B:93A2]  ;|
$8B:F526 7A          PLY                    ;/
$8B:F527 60          RTS
}


;;; $F528: Pre-instruction ;;;
{
$8B:F528 20 5B F6    JSR $F65B  [$8B:F65B]  ; Make ending Samus fall
$8B:F52B BD 9D 1A    LDA $1A9D,x[$7E:1A9D]  ;\
$8B:F52E C9 B0 FF    CMP #$FFB0             ;} If [cinematic sprite object Y position] < -50h:
$8B:F531 10 20       BPL $20    [$F553]     ;/
$8B:F533 E2 20       SEP #$20               ;\
$8B:F535 A9 03       LDA #$03               ;|
$8B:F537 85 52       STA $52    [$7E:0052]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$8B:F539 C2 20       REP #$20               ;/
$8B:F53B A9 01 00    LDA #$0001             ;\
$8B:F53E 9D 5D 1B    STA $1B5D,x[$7E:1B5D]  ;} Cinematic sprite object instruction timer = 1
$8B:F541 A9 95 ED    LDA #$ED95             ;\
$8B:F544 9D 1D 1B    STA $1B1D,x[$7E:1B1D]  ;} Cinematic sprite object instruction list pointer = $ED95
$8B:F547 A9 DD F5    LDA #$F5DD             ;\
$8B:F54A 9D 3D 1B    STA $1B3D,x[$7E:1B3D]  ;} Cinematic sprite object pre-instruction = $F5DD
$8B:F54D A9 00 0C    LDA #$0C00             ;\
$8B:F550 9D BD 1A    STA $1ABD,x[$7E:1ABD]  ;} Cinematic sprite object palette index = C00h (palette 6)

$8B:F553 60          RTS
}


;;; $F554: Instruction ;;;
{
$8B:F554 5A          PHY
$8B:F555 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:F558 C9 0A 00    CMP #$000A             ;} If [game time hours] >= 10:
$8B:F55B 30 0D       BMI $0D    [$F56A]     ;/
$8B:F55D A0 75 EF    LDY #$EF75             ;\
$8B:F560 A9 02 00    LDA #$0002             ;|
$8B:F563 85 12       STA $12    [$7E:0012]  ;} Spawn cinematic sprite object $EF75 to index 2 (suited Samus - jump - head - with helmet)
$8B:F565 20 A2 93    JSR $93A2  [$8B:93A2]  ;/
$8B:F568 80 0B       BRA $0B    [$F575]

$8B:F56A A0 7B EF    LDY #$EF7B             ;\ Else ([game time hours] < 10):
$8B:F56D A9 02 00    LDA #$0002             ;|
$8B:F570 85 12       STA $12    [$7E:0012]  ;} Spawn cinematic sprite object $EF7B to index 2 (suited Samus - jump - head - without helmet)
$8B:F572 20 A2 93    JSR $93A2  [$8B:93A2]  ;/

$8B:F575 A0 6F EF    LDY #$EF6F             ;\
$8B:F578 64 12       STZ $12    [$7E:0012]  ;} Spawn cinematic sprite object $EF6F to index 0 (suited Samus - jump - body)
$8B:F57A 20 A2 93    JSR $93A2  [$8B:93A2]  ;/
$8B:F57D 7A          PLY
$8B:F57E 60          RTS
}


;;; $F57F: Pre-instruction ;;;
{
$8B:F57F 20 5B F6    JSR $F65B  [$8B:F65B]  ; Make ending Samus fall
$8B:F582 BD 9D 1A    LDA $1A9D,x            ;\
$8B:F585 C9 B0 FF    CMP #$FFB0             ;} If [cinematic sprite object Y position] < -50h:
$8B:F588 10 0C       BPL $0C    [$F596]     ;/
$8B:F58A A9 01 00    LDA #$0001             ;\
$8B:F58D 9D 5D 1B    STA $1B5D,x            ;} Cinematic sprite object instruction timer = 1
$8B:F590 A9 9B EE    LDA #$EE9B             ;\
$8B:F593 9D 1D 1B    STA $1B1D,x            ;} Cinematic sprite object instruction list pointer = $EE9B (delete)

$8B:F596 60          RTS
}


;;; $F597: Instruction ;;;
{
$8B:F597 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:F59A C9 0A 00    CMP #$000A             ;} If [game time hours] >= 10:
$8B:F59D 30 0E       BMI $0E    [$F5AD]     ;/
$8B:F59F A9 76 00    LDA #$0076             ;\
$8B:F5A2 9D 7F 1A    STA $1A7F,x            ;} Cinematic sprite object ([X] + 1) X position = 76h
$8B:F5A5 A9 78 00    LDA #$0078             ;\
$8B:F5A8 9D 9F 1A    STA $1A9F,x            ;} Cinematic sprite object ([X] + 1) Y position = 78h
$8B:F5AB 80 0C       BRA $0C    [$F5B9]

$8B:F5AD A9 78 00    LDA #$0078             ;\ Else ([game time hours] < 10):
$8B:F5B0 9D 7F 1A    STA $1A7F,x            ;} Cinematic sprite object ([X] + 1) X position = 78h
$8B:F5B3 A9 78 00    LDA #$0078             ;\
$8B:F5B6 9D 9F 1A    STA $1A9F,x            ;} Cinematic sprite object ([X] + 1) Y position = 78h

$8B:F5B9 60          RTS
}


;;; $F5BA: Instruction ;;;
{
$8B:F5BA AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$8B:F5BD C9 0A 00    CMP #$000A             ;} If [game time hours] >= 10:
$8B:F5C0 30 0E       BMI $0E    [$F5D0]     ;/
$8B:F5C2 A9 78 00    LDA #$0078             ;\
$8B:F5C5 9D 7F 1A    STA $1A7F,x            ;} Cinematic sprite object ([X] + 1) X position = 78h
$8B:F5C8 A9 72 00    LDA #$0072             ;\
$8B:F5CB 9D 9F 1A    STA $1A9F,x            ;} Cinematic sprite object ([X] + 1) Y position = 72h
$8B:F5CE 80 0C       BRA $0C    [$F5DC]     
                                            
$8B:F5D0 A9 79 00    LDA #$0079             ;\ Else ([game time hours] < 10):
$8B:F5D3 9D 7F 1A    STA $1A7F,x            ;} Cinematic sprite object ([X] + 1) X position = 79h
$8B:F5D6 A9 74 00    LDA #$0074             ;\
$8B:F5D9 9D 9F 1A    STA $1A9F,x            ;} Cinematic sprite object ([X] + 1) Y position = 74h

$8B:F5DC 60          RTS
}


;;; $F5DD: Pre-instruction ;;;
{
$8B:F5DD 20 82 F6    JSR $F682  [$8B:F682]  ; Execute $F682
$8B:F5E0 20 5B F6    JSR $F65B  [$8B:F65B]  ; Make ending Samus fall
$8B:F5E3 BD 9D 1A    LDA $1A9D,x[$7E:1A9D]  ;\
$8B:F5E6 C9 88 00    CMP #$0088             ;} If [cinematic sprite object Y position] >= 88h:
$8B:F5E9 30 18       BMI $18    [$F603]     ;/
$8B:F5EB A9 88 00    LDA #$0088             ;\
$8B:F5EE 9D 9D 1A    STA $1A9D,x[$7E:1A9D]  ;} Cinematic sprite object Y position = 88h
$8B:F5F1 A9 01 00    LDA #$0001             ;\
$8B:F5F4 9D 5D 1B    STA $1B5D,x[$7E:1B5D]  ;} Cinematic sprite object instruction timer = 1
$8B:F5F7 A9 9D ED    LDA #$ED9D             ;\
$8B:F5FA 9D 1D 1B    STA $1B1D,x[$7E:1B1D]  ;} Cinematic sprite object instruction list pointer = $ED9D
$8B:F5FD A9 D9 93    LDA #$93D9             ;\
$8B:F600 9D 3D 1B    STA $1B3D,x[$7E:1B3D]  ;} Cinematic sprite object pre-instruction = RTS

$8B:F603 60          RTS
}


;;; $F604: Instruction - Samus shoots screen ;;;
{
$8B:F604 DA          PHX
$8B:F605 5A          PHY
$8B:F606 A9 00 0E    LDA #$0E00             ;\
$8B:F609 9D BD 1A    STA $1ABD,x[$7E:1ABD]  ;} Cinematic sprite object palette index = E00h (palette 7)
$8B:F60C A9 AE E3    LDA #$E3AE             ;\
$8B:F60F 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $E3AE
$8B:F612 E2 20       SEP #$20
$8B:F614 A9 11       LDA #$11               ;\
$8B:F616 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$8B:F618 A9 10       LDA #$10               ;\
$8B:F61A 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = sprites
$8B:F61C A9 02       LDA #$02               ;\
$8B:F61E 85 6F       STA $6F    [$7E:006F]  ;} Enable subscreen layers
$8B:F620 A9 81       LDA #$81               ;\
$8B:F622 85 72       STA $72    [$7E:0072]  ;} Enable subtractive colour math on BG1
$8B:F624 C2 20       REP #$20
$8B:F626 A9 FC FF    LDA #$FFFC             ;\
$8B:F629 8D 93 19    STA $1993  [$7E:1993]  ;} Mode 7 X position = -4
$8B:F62C A9 F8 FF    LDA #$FFF8             ;\
$8B:F62F 8D 97 19    STA $1997  [$7E:1997]  ;} Mode 7 Y position = -8
$8B:F632 A9 10 00    LDA #$0010             ;\
$8B:F635 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 10h
$8B:F638 A9 20 00    LDA #$0020             ;\
$8B:F63B 8D 4D 1A    STA $1A4D  [$7E:1A4D]  ;} $1A4D = 20h
$8B:F63E 8D 4F 1A    STA $1A4F  [$7E:1A4F]  ; $1A4F = 20h
$8B:F641 20 E9 8B    JSR $8BE9  [$8B:8BE9]  ; Copy current palettes to fading palettes
$8B:F644 20 09 8C    JSR $8C09  [$8B:8C09]  ; Decompose fading palette data
$8B:F647 A9 22 00    LDA #$0022             ;\
$8B:F64A 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 22h, sound library 1, max queued sounds allowed = 15 (post-credits Samus shoots screen)
$8B:F64E 7A          PLY
$8B:F64F FA          PLX
$8B:F650 60          RTS
}


;;; $F651: Instruction - make ending Samus jump ;;;
{
$8B:F651 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$8B:F654 A9 F0 FF    LDA #$FFF0             ;} Samus Y speed = -10.0h
$8B:F657 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$8B:F65A 60          RTS
}


;;; $F65B: Make ending Samus fall ;;;
{
$8B:F65B AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$8B:F65E 18          CLC                    ;|
$8B:F65F 69 00 38    ADC #$3800             ;|
$8B:F662 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;} Samus Y speed += 0.38h
$8B:F665 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;|
$8B:F668 69 00 00    ADC #$0000             ;|
$8B:F66B 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$8B:F66E BD FD 1A    LDA $1AFD,x[$7E:1AFD]  ;\
$8B:F671 18          CLC                    ;|
$8B:F672 6D 2C 0B    ADC $0B2C  [$7E:0B2C]  ;|
$8B:F675 9D FD 1A    STA $1AFD,x[$7E:1AFD]  ;} Cinematic sprite object Y position += [Samus Y speed]
$8B:F678 BD 9D 1A    LDA $1A9D,x[$7E:1A9D]  ;|
$8B:F67B 6D 2E 0B    ADC $0B2E  [$7E:0B2E]  ;|
$8B:F67E 9D 9D 1A    STA $1A9D,x[$7E:1A9D]  ;/
$8B:F681 60          RTS
}


;;; $F682:  ;;;
{
$8B:F682 DA          PHX
$8B:F683 5A          PHY
$8B:F684 AD 4D 1A    LDA $1A4D  [$7E:1A4D]  ;\
$8B:F687 C9 10 00    CMP #$0010             ;} If [$1A4D] < 10h:
$8B:F68A 10 29       BPL $29    [$F6B5]     ;/
$8B:F68C 0A          ASL A                  ;\
$8B:F68D A8          TAY                    ;} Y = [$1A4D] * 2
$8B:F68E AE 30 03    LDX $0330  [$7E:0330]  ;\
$8B:F691 A9 00 08    LDA #$0800             ;|
$8B:F694 95 D0       STA $D0,x  [$7E:00D0]  ;|
$8B:F696 E8          INX                    ;|
$8B:F697 E8          INX                    ;|
$8B:F698 B9 B8 F6    LDA $F6B8,y[$8B:F6B8]  ;|
$8B:F69B 95 D0       STA $D0,x  [$7E:00D2]  ;|
$8B:F69D E8          INX                    ;|
$8B:F69E E8          INX                    ;|
$8B:F69F E2 20       SEP #$20               ;} Queue transfer of 800h bytes from $7F:4000 + [Y] * 400h to VRAM [Y] * 200h
$8B:F6A1 A9 7F       LDA #$7F               ;|
$8B:F6A3 95 D0       STA $D0,x  [$7E:00D4]  ;|
$8B:F6A5 C2 20       REP #$20               ;|
$8B:F6A7 E8          INX                    ;|
$8B:F6A8 B9 D8 F6    LDA $F6D8,y[$8B:F6D8]  ;|
$8B:F6AB 95 D0       STA $D0,x  [$7E:00D5]  ;|
$8B:F6AD E8          INX                    ;|
$8B:F6AE E8          INX                    ;|
$8B:F6AF 8E 30 03    STX $0330  [$7E:0330]  ;/
$8B:F6B2 EE 4D 1A    INC $1A4D  [$7E:1A4D]  ; Increment $1A4D

$8B:F6B5 7A          PLY
$8B:F6B6 FA          PLX
$8B:F6B7 60          RTS

$8B:F6B8             dw 4000, 4800, 5000, 5800, 6000, 6800, 7000, 7800, 8000, 8800, 9000, 9800, A000, A800, B000, B800 ; Source addresses (bank $7F)
$8B:F6D8             dw 0000, 0400, 0800, 0C00, 1000, 1400, 1800, 1C00, 2000, 2400, 2800, 2C00, 3000, 3400, 3800, 3C00 ; VRAM addresses
}
}


;;; $F6F8: Credits object definition ;;;
{
;                        _____________ Initialisation function
;                       |     ________ Pre-instruction
;                       |    |     ___ Instruction list (bank $8C)
;                       |    |    |
$8B:F6F8             dw 93D9,93D9,D91B
}


;;; $F6FE: Instruction - end credits ;;;
{
$8B:F6FE 08          PHP
$8B:F6FF 8B          PHB
$8B:F700 4B          PHK                    ;\
$8B:F701 AB          PLB                    ;} DB = $8B
$8B:F702 C2 30       REP #$30
$8B:F704 DA          PHX
$8B:F705 5A          PHY
$8B:F706 20 EE 98    JSR $98EE  [$8B:98EE]  ; Disable credits object
$8B:F709 A2 08 00    LDX #$0008             ;\
                                            ;|
$8B:F70C BF E9 E7 8C LDA $8CE7E9,x[$8C:E7F1];|
$8B:F710 9F 00 C0 7E STA $7EC000,x[$7E:C008];|
$8B:F714 E8          INX                    ;} Palettes = [$8C:E7E9..E9E8] (post-credits palettes)
$8B:F715 E8          INX                    ;|
$8B:F716 E0 00 02    CPX #$0200             ;|
$8B:F719 30 F1       BMI $F1    [$F70C]     ;/
$8B:F71B E2 20       SEP #$20
$8B:F71D 64 69       STZ $69    [$7E:0069]  ; Disable all main screen layers
$8B:F71F A9 80       LDA #$80               ;\
$8B:F721 85 51       STA $51    [$7E:0051]  ;} Enable forced blank
$8B:F723 C2 20       REP #$20
$8B:F725 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$8B:F728 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$8B:F72B 9C 95 19    STZ $1995  [$7E:1995]  ;\
$8B:F72E 9C 97 19    STZ $1997  [$7E:1997]  ;} Mode 7 Y position = 0.0
$8B:F731 A9 01 00    LDA #$0001             ;\
$8B:F734 8D 05 1A    STA $1A05  [$7E:1A05]  ;} Enable shooting stars
$8B:F737 A9 F4 E0    LDA #$E0F4             ;\
$8B:F73A 8D 51 1F    STA $1F51  [$7E:1F51]  ;} Cinematic function = $E0F4
$8B:F73D A9 3C 00    LDA #$003C             ;\
$8B:F740 8D 49 1A    STA $1A49  [$7E:1A49]  ;} Cinematic function timer = 60
$8B:F743 7A          PLY
$8B:F744 FA          PLX
$8B:F745 AB          PLB
$8B:F746 28          PLP
$8B:F747 60          RTS
}


;;; $F748: Cinematic BG object definitions - ending ;;;
{
;                        _____________ Initialisation function
;                       |     ________ Pre-instruction
;                       |    |     ___ Instruction list (bank $8C)
;                       |    |    |
$8B:F748             dw 93D9,93D9,E0AF ; See you next mission
$8B:F74E             dw 93D9,93D9,DFDB ; Item percentage
}


;;; $F754: Debug. Version string ;;;
{
; '02.02.21.30'
$8B:F754             db 30, 32, 2E, 30, 32, 2E, 32, 31, 2E, 33, 30, 00
}


;;; $F760: Free space ;;;
{
$8B:F760             fillto $8C8000, $FF
}
