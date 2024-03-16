;;; $8000..84D5: Post grapple collision detection ;;;
{
;;; $8000: Post grapple collision detection - horizontal - slope - non-square ;;;
{
;; Parameters:
;;     X: Block index
;;     $20: Samus left/right boundary
;; Returns:
;;     Carry: Set if Samus collides with slope, clear otherwise
;;     A: If carry set, X depth into slope in pixels

$94:8000 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$94:8003 4A          LSR A                  ;} If collision direction is right:
$94:8004 90 03       BCC $03    [$8009]     ;/
$94:8006 4C 73 80    JMP $8073  [$94:8073]  ; Go to BRANCH_RIGHT

; BRANCH_LEFT
$94:8009 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:800C 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:800F E2 20       SEP #$20               ;|
$94:8011 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:8014 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:8017 C2 20       REP #$20               ;|
$94:8019 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} If [current block index] % [room width in blocks] != [Samus X position] / 10h (Samus' centre isn't in block):
$94:801C 4A          LSR A                  ;|
$94:801D 4A          LSR A                  ;|
$94:801E 4A          LSR A                  ;|
$94:801F 4A          LSR A                  ;|
$94:8020 CD 16 42    CMP $4216  [$7E:4216]  ;|
$94:8023 F0 02       BEQ $02    [$8027]     ;/
$94:8025 18          CLC                    ;\
$94:8026 60          RTS                    ;} Return carry clear

$94:8027 A5 20       LDA $20    [$7E:0020]  ;\
$94:8029 29 0F 00    AND #$000F             ;} $0DD4 = [Samus left boundary] % 10h (Samus left X offset)
$94:802C 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:802F BF 02 64 7F LDA $7F6402,x          ;\
$94:8033 29 1F 00    AND #$001F             ;|
$94:8036 0A          ASL A                  ;|
$94:8037 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:8038 0A          ASL A                  ;|
$94:8039 0A          ASL A                  ;|
$94:803A 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:803D BF 01 64 7F LDA $7F6401,x          ;\
$94:8041 0A          ASL A                  ;} If [block BTS] & 40h = 0: go to post grapple collision detection - horizontal - solid
$94:8042 10 2C       BPL $2C    [$8070]     ;/
$94:8044 BF 01 64 7F LDA $7F6401,x          ;\
$94:8048 30 05       BMI $05    [$804F]     ;} If [block BTS] & 80h = 0:
$94:804A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ; A = [Samus Y position] % 10h
$94:804D 80 06       BRA $06    [$8055]

$94:804F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\ Else ([block BTS] & 80h != 0):
$94:8052 49 0F 00    EOR #$000F             ;} A = Fh - [Samus Y position] % 10h

$94:8055 29 0F 00    AND #$000F
$94:8058 18          CLC                    ;\
$94:8059 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$94:805C AA          TAX                    ;} A = [$892B + [$0DD6] + [A]] (slope left X offset)
$94:805D BD 2B 89    LDA $892B,x            ;/
$94:8060 29 1F 00    AND #$001F
$94:8063 38          SEC                    ;\
$94:8064 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= (Samus left X offset) + 1
$94:8067 3A          DEC A                  ;/
$94:8068 F0 02       BEQ $02    [$806C]
$94:806A 30 02       BMI $02    [$806E]     ; If [A] < 0: return carry clear

$94:806C 38          SEC                    ;\
$94:806D 60          RTS                    ;} Return carry set

$94:806E 18          CLC
$94:806F 60          RTS

$94:8070 4C BE 82    JMP $82BE  [$94:82BE]

; BRANCH_RIGHT
$94:8073 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:8076 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:8079 E2 20       SEP #$20               ;|
$94:807B AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:807E 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:8081 C2 20       REP #$20               ;|
$94:8083 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} If [current block index] % [room width in blocks] != [Samus X position] / 10h (Samus' centre isn't in block):
$94:8086 4A          LSR A                  ;|
$94:8087 4A          LSR A                  ;|
$94:8088 4A          LSR A                  ;|
$94:8089 4A          LSR A                  ;|
$94:808A CD 16 42    CMP $4216  [$7E:4216]  ;|
$94:808D F0 02       BEQ $02    [$8091]     ;/
$94:808F 18          CLC                    ;\
$94:8090 60          RTS                    ;} Return carry clear

$94:8091 A5 20       LDA $20    [$7E:0020]  ;\
$94:8093 29 0F 00    AND #$000F             ;} $0DD4 = [Samus right boundary] % 10h (Samus right X offset)
$94:8096 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:8099 BF 02 64 7F LDA $7F6402,x          ;\
$94:809D 29 1F 00    AND #$001F             ;|
$94:80A0 0A          ASL A                  ;|
$94:80A1 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:80A2 0A          ASL A                  ;|
$94:80A3 0A          ASL A                  ;|
$94:80A4 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:80A7 BF 01 64 7F LDA $7F6401,x          ;\
$94:80AB 0A          ASL A                  ;} If [block BTS] & 40h != 0: go to post grapple collision detection - horizontal - solid
$94:80AC 30 2F       BMI $2F    [$80DD]     ;/
$94:80AE BF 01 64 7F LDA $7F6401,x          ;\
$94:80B2 30 05       BMI $05    [$80B9]     ;} If [block BTS] & 80h = 0:
$94:80B4 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ; A = [Samus Y position] % 10h
$94:80B7 80 06       BRA $06    [$80BF]

$94:80B9 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\ Else ([block BTS] & 80h != 0):
$94:80BC 49 0F 00    EOR #$000F             ;} A = Fh - [Samus Y position] % 10h

$94:80BF 29 0F 00    AND #$000F
$94:80C2 18          CLC                    ;\
$94:80C3 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$94:80C6 AA          TAX                    ;} A = [$892B + [$0DD6] + [A]] (slope left X offset)
$94:80C7 BD 2B 89    LDA $892B,x            ;/
$94:80CA 29 1F 00    AND #$001F
$94:80CD 38          SEC                    ;\
$94:80CE ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= (Samus right X offset) + 1
$94:80D1 3A          DEC A                  ;/
$94:80D2 F0 02       BEQ $02    [$80D6]     ;\
$94:80D4 10 05       BPL $05    [$80DB]     ;} If [A] > 0: return carry clear

$94:80D6 49 FF FF    EOR #$FFFF             ; A = -1 - [A]
$94:80D9 38          SEC                    ;\
$94:80DA 60          RTS                    ;} Return carry set

$94:80DB 18          CLC
$94:80DC 60          RTS

$94:80DD 4C BE 82    JMP $82BE  [$94:82BE]
}


;;; $80E0: Post grapple collision detection - vertical - slope - non-square ;;;
{
;; Parameters:
;;     X: Block index
;;     $20: Samus bottom/top boundary
;; Returns:
;;     Carry: Set if Samus collides with slope, clear otherwise
;;     A: If carry set, Y depth into slope in pixels

$94:80E0 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$94:80E3 4A          LSR A                  ;} If collision direction is down:
$94:80E4 90 03       BCC $03    [$80E9]     ;/
$94:80E6 4C 4F 81    JMP $814F  [$94:814F]  ; Go to BRANCH_DOWN

$94:80E9 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:80EC 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:80EF E2 20       SEP #$20               ;|
$94:80F1 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:80F4 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:80F7 C2 20       REP #$20               ;|
$94:80F9 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} If [current block index] % [room width in blocks] != [Samus X position] / 10h:
$94:80FC 4A          LSR A                  ;|
$94:80FD 4A          LSR A                  ;|
$94:80FE 4A          LSR A                  ;|
$94:80FF 4A          LSR A                  ;|
$94:8100 CD 16 42    CMP $4216  [$7E:4216]  ;|
$94:8103 F0 02       BEQ $02    [$8107]     ;/
$94:8105 18          CLC                    ;\
$94:8106 60          RTS                    ;} Return carry clear

$94:8107 A5 20       LDA $20    [$7E:0020]  ;\
$94:8109 29 0F 00    AND #$000F             ;} $0DD4 = [Samus top boundary] % 10h (Samus top Y offset)
$94:810C 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:810F BF 02 64 7F LDA $7F6402,x          ;\
$94:8113 29 1F 00    AND #$001F             ;|
$94:8116 0A          ASL A                  ;|
$94:8117 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:8118 0A          ASL A                  ;|
$94:8119 0A          ASL A                  ;|
$94:811A 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:811D BF 01 64 7F LDA $7F6401,x          ;\
$94:8121 10 29       BPL $29    [$814C]     ;} If [block BTS] & 80h = 0: go to post grapple collision detection - vertical - solid
$94:8123 0A          ASL A                  ;\
$94:8124 30 05       BMI $05    [$812B]     ;} If [block BTS] & 40h = 0:
$94:8126 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ; A = [Samus X position] % 10h
$94:8129 80 06       BRA $06    [$8131]

$94:812B AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\ Else ([block BTS] & 40h != 0):
$94:812E 49 0F 00    EOR #$000F             ;} A = Fh - [Samus X position] % 10h

$94:8131 29 0F 00    AND #$000F
$94:8134 18          CLC                    ;\
$94:8135 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$94:8138 AA          TAX                    ;} A = [$8B2B + [$0DD6] + [A]] (slope top Y offset)
$94:8139 BD 2B 8B    LDA $8B2B,x            ;/
$94:813C 29 1F 00    AND #$001F
$94:813F 38          SEC                    ;\
$94:8140 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= (Samus top Y offset) + 1
$94:8143 3A          DEC A                  ;/
$94:8144 F0 02       BEQ $02    [$8148]
$94:8146 30 02       BMI $02    [$814A]     ; If [A] < 0: return carry clear

$94:8148 38          SEC                    ;\
$94:8149 60          RTS                    ;} Return carry set

$94:814A 18          CLC
$94:814B 60          RTS

$94:814C 4C DA 82    JMP $82DA  [$94:82DA]

; BRANCH_DOWN
$94:814F AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:8152 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:8155 E2 20       SEP #$20               ;|
$94:8157 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:815A 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:815D C2 20       REP #$20               ;|
$94:815F AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} If [current block index] % [room width in blocks] != [Samus X position] / 10h:
$94:8162 4A          LSR A                  ;|
$94:8163 4A          LSR A                  ;|
$94:8164 4A          LSR A                  ;|
$94:8165 4A          LSR A                  ;|
$94:8166 CD 16 42    CMP $4216  [$7E:4216]  ;|
$94:8169 F0 02       BEQ $02    [$816D]     ;/
$94:816B 18          CLC                    ;\
$94:816C 60          RTS                    ;} Return carry clear

$94:816D A5 20       LDA $20    [$7E:0020]  ;\
$94:816F 29 0F 00    AND #$000F             ;} $0DD4 = [Samus bottom boundary] % 10h (Samus bottom Y offset)
$94:8172 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:8175 BF 02 64 7F LDA $7F6402,x          ;\
$94:8179 29 1F 00    AND #$001F             ;|
$94:817C 0A          ASL A                  ;|
$94:817D 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:817E 0A          ASL A                  ;|
$94:817F 0A          ASL A                  ;|
$94:8180 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:8183 BF 01 64 7F LDA $7F6401,x          ;\
$94:8187 30 2C       BMI $2C    [$81B5]     ;} If [block BTS] & 80h != 0: go to post grapple collision detection - vertical - solid
$94:8189 0A          ASL A                  ;\
$94:818A 30 05       BMI $05    [$8191]     ;} If [block BTS] & 40h = 0:
$94:818C AD F6 0A    LDA $0AF6  [$7E:0AF6]  ; A = [Samus X position] % 10h
$94:818F 80 06       BRA $06    [$8197]

$94:8191 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\ Else ([block BTS] & 40h != 0):
$94:8194 49 0F 00    EOR #$000F             ;} A = Fh - [Samus X position] % 10h

$94:8197 29 0F 00    AND #$000F
$94:819A 18          CLC                    ;\
$94:819B 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$94:819E AA          TAX                    ;} A = [$8B2B + [$0DD6] + [A]] (slope top Y offset)
$94:819F BD 2B 8B    LDA $8B2B,x            ;/
$94:81A2 29 1F 00    AND #$001F
$94:81A5 38          SEC                    ;\
$94:81A6 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= (Samus bottom Y offset) + 1
$94:81A9 3A          DEC A                  ;/
$94:81AA F0 02       BEQ $02    [$81AE]     ;\
$94:81AC 10 05       BPL $05    [$81B3]     ;} If [A] > 0: return carry clear

$94:81AE 49 FF FF    EOR #$FFFF             ; A = -1 - [A]
$94:81B1 38          SEC                    ;\
$94:81B2 60          RTS                    ;} Return carry set

$94:81B3 18          CLC
$94:81B4 60          RTS

$94:81B5 4C DA 82    JMP $82DA  [$94:82DA]
}


;;; $81B8: Post grapple collision detection - horizontal - slope - square ;;;
{
;; Parameters:
;;     X: Block index
;;     $1A: Number of blocks left to check (0 if final (bottom) block)
;;     $1C: Samus' Y block span
;;     $20: Samus left/right boundary
;; Returns:
;;     Carry: Set if Samus collides with solid slope, clear otherwise
;;     A: If carry set, X depth into slope in pixels
$94:81B8 BF 02 64 7F LDA $7F6402,x          ;\
$94:81BC 29 1F 00    AND #$001F             ;|
$94:81BF 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$94:81C0 0A          ASL A                  ;|
$94:81C1 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:81C4 BF 01 64 7F LDA $7F6401,x          ;\
$94:81C8 2A          ROL A                  ;|
$94:81C9 2A          ROL A                  ;|
$94:81CA 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$94:81CB 29 03 00    AND #$0003             ;|
$94:81CE 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:81D1 A5 20       LDA $20    [$7E:0020]  ;\
$94:81D3 29 08 00    AND #$0008             ;} A = [$20] & 8 (is Samus boundary in right half of block)
$94:81D6 4A          LSR A                  ;\
$94:81D7 4A          LSR A                  ;|
$94:81D8 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 3 (toggle X flip flag if Samus is in right half of block)
$94:81D9 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$94:81DC 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$94:81DF AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$94:81E0 A5 1A       LDA $1A    [$7E:001A]  ;\
$94:81E2 D0 14       BNE $14    [$81F8]     ;} If [$1A] = 0 (bottom block check):
$94:81E4 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:81E7 18          CLC                    ;|
$94:81E8 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$94:81EB 3A          DEC A                  ;} If Samus bottom boundary is in bottom half: go to BRANCH_CHECK_BOTH_HALVES
$94:81EC 29 08 00    AND #$0008             ;|
$94:81EF D0 17       BNE $17    [$8208]     ;/
$94:81F1 BD 53 8E    LDA $8E53,x            ;\
$94:81F4 30 23       BMI $23    [$8219]     ;} If [$8E54 + [X]] & 80h != 0 (top half is solid): go to BRANCH_SOLID
$94:81F6 80 1F       BRA $1F    [$8217]     ; Return carry clear

$94:81F8 C5 1C       CMP $1C    [$7E:001C]  ;\
$94:81FA D0 0C       BNE $0C    [$8208]     ;} If [$1A] = [$1C] (top block check):
$94:81FC AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:81FF 38          SEC                    ;|
$94:8200 ED 00 0B    SBC $0B00  [$7E:0B00]  ;} If Samus top boundary is in bottom half: go to BRANCH_CHECK_BOTTOM_HALF
$94:8203 29 08 00    AND #$0008             ;|
$94:8206 D0 05       BNE $05    [$820D]     ;/

; BRANCH_CHECK_BOTH_HALVES
$94:8208 BD 53 8E    LDA $8E53,x            ;\
$94:820B 30 0C       BMI $0C    [$8219]     ;} If [$8E54 + [X]] & 80h != 0 (top half is solid): go to BRANCH_SOLID

; BRANCH_CHECK_BOTTOM_HALF
$94:820D 8A          TXA                    ;\
$94:820E 49 02 00    EOR #$0002             ;|
$94:8211 AA          TAX                    ;} If [$8E54 + ([X] ^ 2)] & 80h != 0 (bottom half is solid): go to BRANCH_SOLID
$94:8212 BD 53 8E    LDA $8E53,x            ;|
$94:8215 30 02       BMI $02    [$8219]     ;/

$94:8217 18          CLC                    ;\
$94:8218 60          RTS                    ;} Return carry clear

; BRANCH_SOLID
$94:8219 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$94:821C 4A          LSR A                  ;} If collision direction is right:
$94:821D 90 07       BCC $07    [$8226]     ;/
$94:821F A5 20       LDA $20    [$7E:0020]  ;\
$94:8221 29 07 00    AND #$0007             ;} A = [$20] % 8
$94:8224 38          SEC                    ;\
$94:8225 60          RTS                    ;} Return carry set

$94:8226 A5 20       LDA $20    [$7E:0020]  ;\
$94:8228 29 07 00    AND #$0007             ;} A = 7 - [$20] % 8
$94:822B 49 07 00    EOR #$0007             ;/
$94:822E 38          SEC                    ;\
$94:822F 60          RTS                    ;} Return carry set
}


;;; $8230: Post grapple collision detection - vertical - slope - square ;;;
{
;; Parameters:
;;     X: Block index
;;     $1A: Number of blocks left to check (0 if final (rightmost) block)
;;     $1C: Samus' X block span
;;     $20: Samus bottom/top boundary
;; Returns:
;;     Carry: Set if Samus collides with solid slope, clear otherwise
;;     A: If carry set, Y depth into slope in pixels
$94:8230 BF 02 64 7F LDA $7F6402,x          ;\
$94:8234 29 1F 00    AND #$001F             ;|
$94:8237 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$94:8238 0A          ASL A                  ;|
$94:8239 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:823C BF 01 64 7F LDA $7F6401,x          ;\
$94:8240 2A          ROL A                  ;|
$94:8241 2A          ROL A                  ;|
$94:8242 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$94:8243 29 03 00    AND #$0003             ;|
$94:8246 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:8249 A5 20       LDA $20    [$7E:0020]  ;\
$94:824B 29 08 00    AND #$0008             ;} A = [$20] & 8 (is Samus boundary in lower half of block)
$94:824E 4A          LSR A                  ;\
$94:824F 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 2 (toggle Y flip flag if Samus is in lower half of block)
$94:8250 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$94:8253 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$94:8256 AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$94:8257 A5 1A       LDA $1A    [$7E:001A]  ;\
$94:8259 D0 14       BNE $14    [$826F]     ;} If [$1A] = 0 (rightmost block check):
$94:825B AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$94:825E 18          CLC                    ;|
$94:825F 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;|
$94:8262 3A          DEC A                  ;} If Samus right boundary is in right half: go to BRANCH_CHECK_BOTH_HALVES
$94:8263 29 08 00    AND #$0008             ;|
$94:8266 D0 17       BNE $17    [$827F]     ;/
$94:8268 BD 53 8E    LDA $8E53,x            ;\
$94:826B 30 23       BMI $23    [$8290]     ;} If [$8E54 + [X]] & 80h != 0 (left half is solid): go to BRANCH_SOLID
$94:826D 80 1F       BRA $1F    [$828E]     ; Return carry clear

$94:826F C5 1C       CMP $1C    [$7E:001C]  ;\
$94:8271 D0 0C       BNE $0C    [$827F]     ;} If [$1A] = [$1C] (leftmost block check):
$94:8273 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$94:8276 38          SEC                    ;|
$94:8277 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;} If Samus left boundary is in right half: go to BRANCH_CHECK_RIGHT_HALF
$94:827A 29 08 00    AND #$0008             ;|
$94:827D D0 05       BNE $05    [$8284]     ;/

; BRANCH_CHECK_BOTH_HALVES
$94:827F BD 53 8E    LDA $8E53,x            ;\
$94:8282 30 0C       BMI $0C    [$8290]     ;} If [$8E54 + [X]] & 80h != 0 (left half is solid): go to BRANCH_SOLID

; BRANCH_CHECK_RIGHT_HALF
$94:8284 8A          TXA                    ;\
$94:8285 49 01 00    EOR #$0001             ;|
$94:8288 AA          TAX                    ;} If [$8E54 + ([X] ^ 1)] & 80h != 0 (right half is solid): go to BRANCH_SOLID
$94:8289 BD 53 8E    LDA $8E53,x            ;|
$94:828C 30 02       BMI $02    [$8290]     ;/

$94:828E 18          CLC                    ;\
$94:828F 60          RTS                    ;} Return carry clear

; BRANCH_SOLID
$94:8290 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$94:8293 4A          LSR A                  ;} If collision direction is down:
$94:8294 90 07       BCC $07    [$829D]     ;/
$94:8296 A5 20       LDA $20    [$7E:0020]  ;\
$94:8298 29 07 00    AND #$0007             ;} A = [$20] % 8
$94:829B 38          SEC                    ;\
$94:829C 60          RTS                    ;} Return carry set

$94:829D A5 20       LDA $20    [$7E:0020]  ;\
$94:829F 29 07 00    AND #$0007             ;} A = 7 - [$20] % 8
$94:82A2 49 07 00    EOR #$0007             ;/
$94:82A5 38          SEC                    ;\
$94:82A6 60          RTS                    ;} Return carry set
}


;;; $82A7: Clear carry ;;;
{
$94:82A7 18          CLC
$94:82A8 60          RTS
}


;;; $82A9: Post grapple collision detection - horizontal - slope ;;;
{
;; Parameters:
;;     $1A: Number of blocks left to check (0 if final (bottom) block)
;;     $1C: Samus' Y block span
;;     $20: Samus left/right boundary
;; Returns:
;;     Carry: Set if Samus collides with slope, clear otherwise
;;     A: If carry set, X depth into slope in pixels
$94:82A9 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:82AC BF 02 64 7F LDA $7F6402,x          ;|
$94:82B0 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh >= 5:
$94:82B3 C9 05 00    CMP #$0005             ;|
$94:82B6 90 03       BCC $03    [$82BB]     ;/
$94:82B8 4C 00 80    JMP $8000  [$94:8000]  ; Go to post grapple collision detection - horizontal - slope - non-square

$94:82BB 4C B8 81    JMP $81B8  [$94:81B8]  ; Go to post grapple collision detection - horizontal - slope - square
}


;;; $82BE: Post grapple collision detection - horizontal - solid ;;;
{
;; Parameters:
;;     $20: Samus left/right boundary
;; Returns:
;;     Carry: Set (Samus collides with block)
;;     A: X depth into block in pixels
$94:82BE A5 20       LDA $20    [$7E:0020]
$94:82C0 29 0F 00    AND #$000F
$94:82C3 38          SEC
$94:82C4 60          RTS
}


;;; $82C5: Post grapple collision detection - vertical - slope ;;;
{
;; Parameters:
;;     $1A: Number of blocks left to check (0 if final (rightmost) block)
;;     $1C: Samus' X block span
;;     $20: Samus bottom/top boundary
;; Returns:
;;     Carry: Set if Samus collides with slope, clear otherwise
;;     A: If carry set, Y depth into slope in pixels
$94:82C5 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:82C8 BF 02 64 7F LDA $7F6402,x          ;|
$94:82CC 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh >= 5:
$94:82CF C9 05 00    CMP #$0005             ;|
$94:82D2 90 03       BCC $03    [$82D7]     ;/
$94:82D4 4C E0 80    JMP $80E0  [$94:80E0]  ; Go to post grapple collision detection - vertical - slope - non-square

$94:82D7 4C 30 82    JMP $8230  [$94:8230]  ; Go to post grapple collision detection - vertical - slope - square
}


;;; $82DA: Post grapple collision detection - vertical - solid ;;;
{
;; Parameters:
;;     $20: Samus bottom/top boundary
;; Returns:
;;     Carry: Set (Samus collides with block)
;;     A: Y depth into block in pixels
$94:82DA A5 20       LDA $20    [$7E:0020]
$94:82DC 29 0F 00    AND #$000F
$94:82DF 38          SEC
$94:82E0 60          RTS
}


;;; $82E1: Post grapple collision detection - horizontal - jump table ;;;
{
$94:82E1             dw 82A7, ;  0: Air
                        82A9, ; *1: Slope
                        82A7, ;  2: Spike air
                        82A7, ;  3: Special air
                        82A7, ;  4: Shootable air
                        82A7, ;  5: Horizontal extension
                        82A7, ;  6: Unused air
                        82A7, ;  7: Bombable air
                        82BE, ;  8: Solid block
                        82BE, ;  9: Door block
                        82BE, ;  Ah: Spike block
                        82BE, ;  Bh: Special block
                        82BE, ;  Ch: Shootable block
                        82BE, ;  Dh: Vertical extension
                        82BE, ;  Eh: Grapple block
                        82BE  ;  Fh: Bombable block
}


;;; $8301: Post grapple collision detection - vertical - jump table ;;;
{
$94:8301             dw 82A7, ;  0: Air
                        82C5, ; *1: Slope
                        82A7, ;  2: Spike air
                        82A7, ;  3: Special air
                        82A7, ;  4: Shootable air
                        82A7, ;  5: Horizontal extension
                        82A7, ;  6: Unused air
                        82A7, ;  7: Bombable air
                        82DA, ;  8: Solid block
                        82DA, ;  9: Door block
                        82DA, ;  Ah: Spike block
                        82DA, ;  Bh: Special block
                        82DA, ;  Ch: Shootable block
                        82DA, ;  Dh: Vertical extension
                        82DA, ;  Eh: Grapple block
                        82DA  ;  Fh: Bombable block
}


;;; $8321: Post grapple collision detection - horizontal - single block ;;;
{
;; Parameters:
;;     X: Block index
;;     $1A: Number of blocks left to check (0 if final (bottom) block)
;;     $1C: Samus Y block span
;;     $20: Samus left/right boundary
;; Returns:
;;     Carry: Set if Samus collides with block, clear otherwise
;;     A: If carry set, X depth into block in pixels
$94:8321 DA          PHX
$94:8322 8A          TXA                    ;\
$94:8323 4A          LSR A                  ;} Current block index = [X] / 2
$94:8324 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:8327 BF 02 00 7F LDA $7F0002,x[$7F:0262];\
$94:832B 29 00 F0    AND #$F000             ;|
$94:832E EB          XBA                    ;|
$94:832F 4A          LSR A                  ;|
$94:8330 4A          LSR A                  ;} Execute [$82E1 + (block type) * 2]
$94:8331 4A          LSR A                  ;|
$94:8332 AA          TAX                    ;|
$94:8333 FC E1 82    JSR ($82E1,x)[$94:82A7];/
$94:8336 FA          PLX
$94:8337 60          RTS
}


;;; $8338: Post grapple collision detection - vertical - single block ;;;
{
;; Parameters:
;;     X: Block index
;;     $1A: Number of blocks left to check (0 if final (rightmost) block)
;;     $1C: Samus' X block span
;;     $20: Samus bottom/top boundary
;; Returns:
;;     Carry: Set if Samus collides with block, clear otherwise
;;     A: If carry set, Y depth into block in pixels
$94:8338 DA          PHX
$94:8339 8A          TXA                    ;\
$94:833A 4A          LSR A                  ;} Current block index = [X] / 2
$94:833B 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:833E BF 02 00 7F LDA $7F0002,x[$7F:0320];\
$94:8342 29 00 F0    AND #$F000             ;|
$94:8345 EB          XBA                    ;|
$94:8346 4A          LSR A                  ;|
$94:8347 4A          LSR A                  ;} Execute [$8301 + (block type) * 2]
$94:8348 4A          LSR A                  ;|
$94:8349 AA          TAX                    ;|
$94:834A FC 01 83    JSR ($8301,x)[$94:82A7];/
$94:834D FA          PLX
$94:834E 60          RTS
}


;;; $834F: Post grapple collision detection - rightwards ;;;
{
$94:834F 8B          PHB
$94:8350 4B          PHK                    ;\
$94:8351 AB          PLB                    ;} DB = $94
$94:8352 A9 01 00    LDA #$0001             ;\
$94:8355 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = right
$94:8358 9C 04 0E    STZ $0E04  [$7E:0E04]  ; $0E04 = 0 (distance to eject Samus left)
$94:835B 20 95 94    JSR $9495  [$94:9495]  ; $1A = $1C = Samus Y block span
$94:835E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:8361 38          SEC                    ;|
$94:8362 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$94:8365 4A          LSR A                  ;|
$94:8366 4A          LSR A                  ;|
$94:8367 4A          LSR A                  ;} Calculate block index of the row of Samus top boundary
$94:8368 4A          LSR A                  ;|
$94:8369 E2 20       SEP #$20               ;|
$94:836B 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:836E AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:8371 8D 03 42    STA $4203  [$7E:4203]  ;/
$94:8374 C2 20       REP #$20
$94:8376 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$94:8379 85 16       STA $16    [$7E:0016]  ;|
$94:837B AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} $18.$16 = [Samus X position] <-- never read
$94:837E 85 18       STA $18    [$7E:0018]  ;/
$94:8380 18          CLC                    ;\
$94:8381 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;|
$94:8384 3A          DEC A                  ;} $20 = (Samus right boundary)
$94:8385 85 20       STA $20    [$7E:0020]  ;/
$94:8387 4A          LSR A                  ;\
$94:8388 4A          LSR A                  ;|
$94:8389 4A          LSR A                  ;|
$94:838A 4A          LSR A                  ;} Current block index = (Samus top-right corner)
$94:838B 18          CLC                    ;|
$94:838C 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:838F 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:8392 0A          ASL A                  ;\
$94:8393 AA          TAX                    ;} X = [current block index] * 2

; LOOP
$94:8394 20 21 83    JSR $8321  [$94:8321]  ; Post grapple collision detection - horizontal
$94:8397 90 09       BCC $09    [$83A2]     ; If collision:
$94:8399 1A          INC A                  ;\
$94:839A CD 04 0E    CMP $0E04  [$7E:0E04]  ;|
$94:839D 90 03       BCC $03    [$83A2]     ;} $0E04 = max([$0E04], [A] + 1) (distance to eject Samus left)
$94:839F 8D 04 0E    STA $0E04  [$7E:0E04]  ;/

$94:83A2 8A          TXA                    ;\
$94:83A3 18          CLC                    ;|
$94:83A4 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$94:83A7 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$94:83AA AA          TAX                    ;/
$94:83AB C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$94:83AD 10 E5       BPL $E5    [$8394]     ; If [$1A] >= 0: go to LOOP
$94:83AF AB          PLB
$94:83B0 60          RTS
}


;;; $83B1: Post grapple collision detection - leftwards ;;;
{
$94:83B1 8B          PHB
$94:83B2 4B          PHK                    ;\
$94:83B3 AB          PLB                    ;} DB = $94
$94:83B4 9C 02 0B    STZ $0B02  [$7E:0B02]  ; Collision direction = left
$94:83B7 9C 06 0E    STZ $0E06  [$7E:0E06]  ; $0E06 = 0 (distance to eject Samus right)
$94:83BA 20 95 94    JSR $9495  [$94:9495]  ; $1A = $1C = Samus Y block span
$94:83BD AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:83C0 38          SEC                    ;|
$94:83C1 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$94:83C4 4A          LSR A                  ;|
$94:83C5 4A          LSR A                  ;|
$94:83C6 4A          LSR A                  ;} Calculate block index of the row of Samus top boundary
$94:83C7 4A          LSR A                  ;|
$94:83C8 E2 20       SEP #$20               ;|
$94:83CA 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:83CD AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:83D0 8D 03 42    STA $4203  [$7E:4203]  ;/
$94:83D3 C2 20       REP #$20
$94:83D5 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$94:83D8 85 16       STA $16    [$7E:0016]  ;|
$94:83DA AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} $18.$16 = [Samus X position] <-- never read
$94:83DD 85 18       STA $18    [$7E:0018]  ;/
$94:83DF 38          SEC                    ;\
$94:83E0 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;} $20 = (Samus left boundary)
$94:83E3 85 20       STA $20    [$7E:0020]  ;/
$94:83E5 4A          LSR A                  ;\
$94:83E6 4A          LSR A                  ;|
$94:83E7 4A          LSR A                  ;|
$94:83E8 4A          LSR A                  ;} Current block index = Samus top-left corner
$94:83E9 18          CLC                    ;|
$94:83EA 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:83ED 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:83F0 0A          ASL A                  ;\
$94:83F1 AA          TAX                    ;} X = [current block index] * 2

; LOOP
$94:83F2 20 21 83    JSR $8321  [$94:8321]  ; Post grapple collision detection - horizontal
$94:83F5 90 09       BCC $09    [$8400]     ; If collision:
$94:83F7 1A          INC A                  ;\
$94:83F8 CD 06 0E    CMP $0E06  [$7E:0E06]  ;|
$94:83FB 90 03       BCC $03    [$8400]     ;} $0E06 = max([$0E06], [A] + 1) (distance to eject Samus right)
$94:83FD 8D 06 0E    STA $0E06  [$7E:0E06]  ;/

$94:8400 8A          TXA                    ;\
$94:8401 18          CLC                    ;|
$94:8402 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$94:8405 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$94:8408 AA          TAX                    ;/
$94:8409 C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$94:840B 10 E5       BPL $E5    [$83F2]     ; If [$1A] >= 0: go to LOOP
$94:840D AB          PLB
$94:840E 60          RTS
}


;;; $840F: Post grapple collision detection - downwards ;;;
{
$94:840F 8B          PHB
$94:8410 4B          PHK                    ;\
$94:8411 AB          PLB                    ;} DB = $94
$94:8412 A9 03 00    LDA #$0003             ;\
$94:8415 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = down
$94:8418 9C 08 0E    STZ $0E08  [$7E:0E08]  ; $0E08 = 0 (distance to eject Samus up)
$94:841B 20 B5 94    JSR $94B5  [$94:94B5]  ; $1A = $1C = Samus X block span
$94:841E AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$94:8421 85 16       STA $16    [$7E:0016]  ;|
$94:8423 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} $18.$16 = [Samus Y position] <-- never read
$94:8426 85 18       STA $18    [$7E:0018]  ;/
$94:8428 18          CLC                    ;\
$94:8429 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$94:842C 3A          DEC A                  ;} $20 = (Samus bottom boundary)
$94:842D 85 20       STA $20    [$7E:0020]  ;/
$94:842F 4A          LSR A                  ;\
$94:8430 4A          LSR A                  ;|
$94:8431 4A          LSR A                  ;|
$94:8432 4A          LSR A                  ;|
$94:8433 E2 20       SEP #$20               ;|
$94:8435 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:8438 AD A5 07    LDA $07A5  [$7E:07A5]  ;} Calculate Samus left boundary column block index
$94:843B 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:843E C2 20       REP #$20               ;|
$94:8440 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$94:8443 38          SEC                    ;|
$94:8444 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;/
$94:8447 4A          LSR A                  ;\
$94:8448 4A          LSR A                  ;|
$94:8449 4A          LSR A                  ;|
$94:844A 4A          LSR A                  ;} Current block index = (Samus bottom-left corner)
$94:844B 18          CLC                    ;|
$94:844C 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:844F 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:8452 0A          ASL A                  ;\
$94:8453 AA          TAX                    ;} X = [current block index] * 2

; LOOP
$94:8454 20 38 83    JSR $8338  [$94:8338]  ; Post grapple collision detection - vertical
$94:8457 90 09       BCC $09    [$8462]     ; If collision:
$94:8459 1A          INC A                  ;\
$94:845A CD 08 0E    CMP $0E08  [$7E:0E08]  ;|
$94:845D 90 03       BCC $03    [$8462]     ;} $0E08 = max([$0E08], [A] + 1) (distance to eject Samus up)
$94:845F 8D 08 0E    STA $0E08  [$7E:0E08]  ;/

$94:8462 E8          INX                    ;\
$94:8463 E8          INX                    ;} X += 2 (next block)
$94:8464 C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$94:8466 10 EC       BPL $EC    [$8454]     ; If [$1A] >= 0: go to LOOP
$94:8468 AB          PLB
$94:8469 60          RTS
}


;;; $846A: Post grapple collision detection - upwards ;;;
{
$94:846A 8B          PHB
$94:846B 4B          PHK                    ;\
$94:846C AB          PLB                    ;} DB = $94
$94:846D A9 02 00    LDA #$0002             ;\
$94:8470 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = up
$94:8473 9C 0A 0E    STZ $0E0A  [$7E:0E0A]  ; $0E0A = 0 (distance to eject Samus down)
$94:8476 20 B5 94    JSR $94B5  [$94:94B5]  ; $1A = $1C = Samus X block span
$94:8479 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$94:847C 85 16       STA $16    [$7E:0016]  ;|
$94:847E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} $18.$16 = [Samus Y position] <-- never read
$94:8481 85 18       STA $18    [$7E:0018]  ;/
$94:8483 38          SEC                    ;\
$94:8484 ED 00 0B    SBC $0B00  [$7E:0B00]  ;} $20 = (Samus top boundary)
$94:8487 85 20       STA $20    [$7E:0020]  ;/
$94:8489 4A          LSR A                  ;\
$94:848A 4A          LSR A                  ;|
$94:848B 4A          LSR A                  ;|
$94:848C 4A          LSR A                  ;|
$94:848D E2 20       SEP #$20               ;|
$94:848F 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:8492 AD A5 07    LDA $07A5  [$7E:07A5]  ;} Calculate Samus left boundary column block index
$94:8495 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:8498 C2 20       REP #$20               ;|
$94:849A AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$94:849D 38          SEC                    ;|
$94:849E ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;/
$94:84A1 4A          LSR A                  ;\
$94:84A2 4A          LSR A                  ;|
$94:84A3 4A          LSR A                  ;|
$94:84A4 4A          LSR A                  ;} Current block index = (Samus top-left corner)
$94:84A5 18          CLC                    ;|
$94:84A6 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:84A9 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:84AC 0A          ASL A                  ;\
$94:84AD AA          TAX                    ;} X = [current block index] * 2

; LOOP
$94:84AE 20 38 83    JSR $8338  [$94:8338]  ; Post grapple collision detection - vertical
$94:84B1 90 09       BCC $09    [$84BC]     ; If collision:
$94:84B3 1A          INC A                  ;\
$94:84B4 CD 0A 0E    CMP $0E0A  [$7E:0E0A]  ;|
$94:84B7 90 03       BCC $03    [$84BC]     ;} $0E0A = max([$0E0A], [A] + 1) (distance to eject Samus down)
$94:84B9 8D 0A 0E    STA $0E0A  [$7E:0E0A]  ;/

$94:84BC E8          INX                    ;\
$94:84BD E8          INX                    ;} X += 2 (next block)
$94:84BE C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$94:84C0 10 EC       BPL $EC    [$84AE]     ; If [$1A] >= 0: go to LOOP
$94:84C2 AB          PLB
$94:84C3 60          RTS
}


;;; $84C4: Post grapple collision detection - horizontal ;;;
{
; Called by $90:EF25 (post grapple collision detection)
; This routine is used to calculate $0E04/06 (distance to eject Samus left/right), which is never read,
; making this routine and all its subroutines entirely pointless
$94:84C4 08          PHP
$94:84C5 20 4F 83    JSR $834F  [$94:834F]  ; Post grapple collision handling - rightwards
$94:84C8 20 B1 83    JSR $83B1  [$94:83B1]  ; Post grapple collision handling - leftwards
$94:84CB 28          PLP
$94:84CC 6B          RTL
}


;;; $84CD: Post grapple collision detection - vertical ;;;
{
; Called by $90:EF25 (post grapple collision detection), sometimes twice (if Samus was ejected up and her hitbox is >= 10h pixels tall)
$94:84CD 08          PHP
$94:84CE 20 0F 84    JSR $840F  [$94:840F]  ; Post grapple collision handling - downwards
$94:84D1 20 6A 84    JSR $846A  [$94:846A]  ; Post grapple collision handling - upwards
$94:84D4 28          PLP
$94:84D5 6B          RTL
}
}


;;; $84D6..97BE: Samus block collision detection ;;;
{
;;; $84D6: Samus block collision reaction - horizontal - slope - non-square ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;; Returns:
;;     Carry: Clear (no collision)
;;     $12.$14: Adjusted distance to move Samus

$94:84D6 AD 77 1E    LDA $1E77  [$7E:1E77]  ;\
$94:84D9 89 80 00    BIT #$0080             ;} If [current slope BTS] & 80h = 0 (not Y flipped):
$94:84DC D0 08       BNE $08    [$84E6]     ;/
$94:84DE AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$94:84E1 0D 2E 0B    ORA $0B2E  [$7E:0B2E]  ;} If [Samus Y speed] = 0.0: go to BRANCH_SAMUS_ON_SLOPE_SURFACE
$94:84E4 F0 02       BEQ $02    [$84E8]     ;/

$94:84E6 18          CLC                    ;\
$94:84E7 60          RTS                    ;} Return carry clear

; BRANCH_SAMUS_ON_SLOPE_SURFACE
$94:84E8 AD 77 1E    LDA $1E77  [$7E:1E77]  ;\
$94:84EB 29 1F 00    AND #$001F             ;|
$94:84EE 0A          ASL A                  ;} X = ([current slope BTS] & 1Fh) * 4
$94:84EF 0A          ASL A                  ;|
$94:84F0 AA          TAX                    ;/
$94:84F1 A5 12       LDA $12    [$7E:0012]  ;\
$94:84F3 10 51       BPL $51    [$8546]     ;} If [$12] >= 0: go to BRANCH_RIGHT
$94:84F5 AD 48 0B    LDA $0B48  [$7E:0B48]  ;\
$94:84F8 0D 46 0B    ORA $0B46  [$7E:0B46]  ;|
$94:84FB F0 1C       BEQ $1C    [$8519]     ;|
$94:84FD AD 77 1E    LDA $1E77  [$7E:1E77]  ;|
$94:8500 89 40 00    BIT #$0040             ;|
$94:8503 D0 0B       BNE $0B    [$8510]     ;|
$94:8505 AD 48 0B    LDA $0B48  [$7E:0B48]  ;|
$94:8508 18          CLC                    ;|
$94:8509 7D 86 85    ADC $8586,x[$94:85D6]  ;} >_<;
$94:850C 90 0B       BCC $0B    [$8519]     ;|
$94:850E 80 09       BRA $09    [$8519]     ;|
                                            ;|
$94:8510 AD 48 0B    LDA $0B48  [$7E:0B48]  ;|
$94:8513 38          SEC                    ;|
$94:8514 FD 86 85    SBC $8586,x[$94:85D6]  ;|
$94:8517 B0 00       BCS $00    [$8519]     ;/

$94:8519 E2 20       SEP #$20               ;\
$94:851B A5 12       LDA $12    [$7E:0012]  ;|
$94:851D EB          XBA                    ;|
$94:851E A5 15       LDA $15    [$7E:0015]  ;|
$94:8520 C2 20       REP #$20               ;|
$94:8522 49 FF FF    EOR #$FFFF             ;|
$94:8525 1A          INC A                  ;|
$94:8526 BC 88 85    LDY $8588,x[$94:85D8]  ;|
$94:8529 22 D6 82 80 JSL $8082D6[$80:82D6]  ;|
$94:852D AD F1 05    LDA $05F1  [$7E:05F1]  ;} $12.$14 = [$12].[$14] * [$8588 + [X]] / 100h
$94:8530 49 FF FF    EOR #$FFFF             ;|
$94:8533 18          CLC                    ;|
$94:8534 69 01 00    ADC #$0001             ;|
$94:8537 85 14       STA $14    [$7E:0014]  ;|
$94:8539 AD F3 05    LDA $05F3  [$7E:05F3]  ;|
$94:853C 49 FF FF    EOR #$FFFF             ;|
$94:853F 69 00 00    ADC #$0000             ;|
$94:8542 85 12       STA $12    [$7E:0012]  ;/
$94:8544 18          CLC                    ;\
$94:8545 60          RTS                    ;} Return carry clear

; BRANCH_RIGHT
$94:8546 AD 48 0B    LDA $0B48  [$7E:0B48]  ;\
$94:8549 0D 46 0B    ORA $0B46  [$7E:0B46]  ;|
$94:854C F0 1C       BEQ $1C    [$856A]     ;|
$94:854E AD 77 1E    LDA $1E77  [$7E:1E77]  ;|
$94:8551 89 40 00    BIT #$0040             ;|
$94:8554 F0 0B       BEQ $0B    [$8561]     ;|
$94:8556 AD 48 0B    LDA $0B48  [$7E:0B48]  ;|
$94:8559 18          CLC                    ;|
$94:855A 7D 86 85    ADC $8586,x[$94:85D6]  ;} >_<;
$94:855D 90 0B       BCC $0B    [$856A]     ;|
$94:855F 80 09       BRA $09    [$856A]     ;|
                                            ;|
$94:8561 AD 48 0B    LDA $0B48  [$7E:0B48]  ;|
$94:8564 38          SEC                    ;|
$94:8565 FD 86 85    SBC $8586,x[$94:85D6]  ;|
$94:8568 B0 00       BCS $00    [$856A]     ;/

$94:856A E2 20       SEP #$20               ;\
$94:856C A5 12       LDA $12    [$7E:0012]  ;|
$94:856E EB          XBA                    ;|
$94:856F A5 15       LDA $15    [$7E:0015]  ;|
$94:8571 C2 20       REP #$20               ;|
$94:8573 BC 88 85    LDY $8588,x[$94:85D8]  ;} $12.$14 = [$12].[$14] * [$8588 + [X]] / 100h
$94:8576 22 D6 82 80 JSL $8082D6[$80:82D6]  ;|
$94:857A AD F1 05    LDA $05F1  [$7E:05F1]  ;|
$94:857D 85 14       STA $14    [$7E:0014]  ;|
$94:857F AD F3 05    LDA $05F3  [$7E:05F3]  ;|
$94:8582 85 12       STA $12    [$7E:0012]  ;/
$94:8584 18          CLC                    ;\
$94:8585 60          RTS                    ;} Return carry clear

;                        ________ Unused. Seem to be speed modifiers, added to or subtracted from Samus X base subspeed when moving down or up the slope respectively
;                       |     ___ Adjusted distance multiplier * 100h
;                       |    |
$94:8586             dw 0000,0100,
                        0000,0100,
                        0000,0100,
                        0000,0100,
                        0000,0100,
                        0000,0100, ; 5: Unused. Half height isosceles triangle
                        0000,0100, ; 6: Unused. Isosceles triangle
                        0000,0100, ; 7: Half height rectangle
                        0000,0100, ; 8: Unused. Rectangle
                        0000,0100, ; 9: Unused. Rectangle
                        0000,0100, ; Ah: Unused. Rectangle
                        0000,0100, ; Bh: Unused. Rectangle
                        0000,0100, ; Ch: Unused. Rectangle
                        0000,0100, ; Dh: Unused. Rectangle
                        1000,00B0, ; Eh: Unused. Very bumpy triangle
                        1000,00B0, ; Fh: Bumpy triangle
                        0000,0100, ; 10h: Unused
                        0000,0100, ; 11h: Unused
                        1000,00C0, ; 12h: Triangle
                        0000,0100, ; 13h: Rectangle
                        1000,00C0, ; 14h: Quarter triangle
                        1000,00C0, ; 15h: Three quarter triangle
                        0800,00D8, ; 16h: Lower half-height triangle
                        0800,00D8, ; 17h: Upper half-height triangle
                        0600,00F0, ; 18h: Unused. Lower third-height triangle
                        0600,00F0, ; 19h: Unused. Middle third-height triangle
                        0600,00F0, ; 1Ah: Unused. Upper third-height triangle
                        4000,0080, ; 1Bh: Upper half-width triangle
                        4000,0080, ; 1Ch: Lower half-width triangle
                        6000,0050, ; 1Dh: Unused. Upper third-width triangle
                        6000,0050, ; 1Eh: Unused. Middle third-width triangle
                        6000,0050  ; 1Fh: Unused. Lower third-width triangle
}


;;; $8606: Unused ;;;
{
;; Parameters:
;;     X: Block index
;;     $12: Distance to check for collision
;;     $18: Target X position
;; Returns:
;;     Carry: Set if Samus collides with solid slope, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

; This resembles $8000 adapted for block collision, or $86FE adapted for horizontal collision
; I guess this was written before it was decided that non-square slopes shouldn't have solid horizontal collision
; Looking at $86FE, I assume there's supposed to be a collision direction check here to branch to BRANCH_RIGHT

$94:8606 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:8609 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:860C E2 20       SEP #$20               ;|
$94:860E AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:8611 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:8614 C2 20       REP #$20               ;|
$94:8616 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} If [current block index] % [room width in blocks] != [Samus X position] / 10h (Samus' centre isn't in block):
$94:8619 4A          LSR A                  ;|
$94:861A 4A          LSR A                  ;|
$94:861B 4A          LSR A                  ;|
$94:861C 4A          LSR A                  ;|
$94:861D CD 16 42    CMP $4216  [$7E:4216]  ;|
$94:8620 F0 02       BEQ $02    [$8624]     ;/
$94:8622 18          CLC                    ;\
$94:8623 60          RTS                    ;} Return carry clear

$94:8624 A5 18       LDA $18    [$7E:0018]  ;\
$94:8626 38          SEC                    ;|
$94:8627 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$94:862A 29 0F 00    AND #$000F             ;} $0DD4 = Fh - (Samus target left boundary) % 10h
$94:862D 49 0F 00    EOR #$000F             ;|
$94:8630 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:8633 BF 02 64 7F LDA $7F6402,x          ;\
$94:8637 29 1F 00    AND #$001F             ;|
$94:863A 0A          ASL A                  ;|
$94:863B 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:863C 0A          ASL A                  ;|
$94:863D 0A          ASL A                  ;|
$94:863E 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:8641 BF 01 64 7F LDA $7F6401,x          ;\
$94:8645 0A          ASL A                  ;} If [block BTS] & 40h = 0: go to Samus block collision reaction - horizontal - solid/shootable/grapple block
$94:8646 10 38       BPL $38    [$8680]     ;/
$94:8648 BF 01 64 7F LDA $7F6401,x          ;\
$94:864C 30 05       BMI $05    [$8653]     ;} If [block BTS] & 80h = 0:
$94:864E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ; A = [Samus Y position] % 10h
$94:8651 80 06       BRA $06    [$8659]     
                                            
$94:8653 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\ Else ([block BTS] & 80h != 0):
$94:8656 49 0F 00    EOR #$000F             ;} A = Fh - [Samus Y position] % 10h
                                            
$94:8659 29 0F 00    AND #$000F             
$94:865C 18          CLC                    ;\
$94:865D 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$94:8660 AA          TAX                    ;} A = [$892B + [$0DD6] + [A]] (slope left X offset)
$94:8661 BD 2B 89    LDA $892B,x            ;/
$94:8664 29 1F 00    AND #$001F             
$94:8667 38          SEC                    ;\
$94:8668 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= [$0DD4] + 1
$94:866B 3A          DEC A                  ;/
$94:866C F0 02       BEQ $02    [$8670]     ;\
$94:866E 10 0E       BPL $0E    [$867E]     ;} If [A] > 0: return carry clear

$94:8670 18          CLC                    ;\
$94:8671 65 12       ADC $12    [$7E:0012]  ;|
$94:8673 10 03       BPL $03    [$8678]     ;|
$94:8675 A9 00 00    LDA #$0000             ;} $12 = max(0, [A] + [$12])
                                            ;|
$94:8678 85 12       STA $12    [$7E:0012]  ;/
$94:867A 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$94:867C 38          SEC                    ;\
$94:867D 60          RTS                    ;} Return carry set

$94:867E 18          CLC
$94:867F 60          RTS

$94:8680 4C 49 8F    JMP $8F49  [$94:8F49]

; BRANCH_RIGHT
$94:8683 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:8686 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:8689 E2 20       SEP #$20               ;|
$94:868B AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:868E 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:8691 C2 20       REP #$20               ;|
$94:8693 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} If [current block index] % [room width in blocks] != [Samus X position] / 10h (Samus' centre isn't in block):
$94:8696 4A          LSR A                  ;|
$94:8697 4A          LSR A                  ;|
$94:8698 4A          LSR A                  ;|
$94:8699 4A          LSR A                  ;|
$94:869A CD 16 42    CMP $4216  [$7E:4216]  ;|
$94:869D F0 02       BEQ $02    [$86A1]     ;/
$94:869F 18          CLC                    ;\
$94:86A0 60          RTS                    ;} Return carry clear

$94:86A1 A5 18       LDA $18    [$7E:0018]  ;\
$94:86A3 18          CLC                    ;|
$94:86A4 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;|
$94:86A7 3A          DEC A                  ;} $0DD4 = (Samus target right boundary) % 10h
$94:86A8 29 0F 00    AND #$000F             ;|
$94:86AB 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:86AE BF 02 64 7F LDA $7F6402,x          ;\
$94:86B2 29 1F 00    AND #$001F             ;|
$94:86B5 0A          ASL A                  ;|
$94:86B6 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:86B7 0A          ASL A                  ;|
$94:86B8 0A          ASL A                  ;|
$94:86B9 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:86BC BF 01 64 7F LDA $7F6401,x          ;\
$94:86C0 0A          ASL A                  ;} If [block BTS] & 40h != 0: go to Samus block collision reaction - horizontal - solid/shootable/grapple block
$94:86C1 30 38       BMI $38    [$86FB]     ;/
$94:86C3 BF 01 64 7F LDA $7F6401,x          ;\
$94:86C7 30 05       BMI $05    [$86CE]     ;} If [block BTS] & 80h = 0:
$94:86C9 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ; A = [Samus Y position] % 10h
$94:86CC 80 06       BRA $06    [$86D4]

$94:86CE AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\ Else ([block BTS] & 80h != 0):
$94:86D1 49 0F 00    EOR #$000F             ;} A = Fh - [Samus Y position] % 10h
                                            
$94:86D4 29 0F 00    AND #$000F             
$94:86D7 18          CLC                    ;\
$94:86D8 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$94:86DB AA          TAX                    ;} A = [$892B + [$0DD6] + [A]] (slope left X offset)
$94:86DC BD 2B 89    LDA $892B,x            ;/
$94:86DF 29 1F 00    AND #$001F             
$94:86E2 38          SEC                    ;\
$94:86E3 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= [$0DD4] + 1
$94:86E6 3A          DEC A                  ;/
$94:86E7 F0 02       BEQ $02    [$86EB]     ;\
$94:86E9 10 0E       BPL $0E    [$86F9]     ;} If [A] > 0: return carry clear
                                            
$94:86EB 18          CLC                    ;\
$94:86EC 65 12       ADC $12    [$7E:0012]  ;|
$94:86EE 10 03       BPL $03    [$86F3]     ;|
$94:86F0 A9 00 00    LDA #$0000             ;} $12 = max(0, [A] + [$12])
                                            ;|
$94:86F3 85 12       STA $12    [$7E:0012]  ;/
$94:86F5 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$94:86F7 38          SEC                    ;\
$94:86F8 60          RTS                    ;} Return carry set

$94:86F9 18          CLC
$94:86FA 60          RTS

$94:86FB 4C 49 8F    JMP $8F49  [$94:8F49]
}


;;; $86FE: Samus block collision reaction - vertical - slope - non-square ;;;
{
;; Parameters:
;;     X: Block index
;;     $12: Distance to check for collision
;;     $18: Target Y position
;; Returns:
;;     Carry: Set if Samus collides with solid slope, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision
$94:86FE AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$94:8701 4A          LSR A                  ;} If collision direction is down:
$94:8702 90 03       BCC $03    [$8707]     ;/
$94:8704 4C 80 87    JMP $8780  [$94:8780]  ; Go to BRANCH_DOWN

$94:8707 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:870A 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:870D E2 20       SEP #$20               ;|
$94:870F AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:8712 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:8715 C2 20       REP #$20               ;|
$94:8717 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} If [current block index] % [room width in blocks] != [Samus X position] / 10h (Samus' centre isn't in block):
$94:871A 4A          LSR A                  ;|
$94:871B 4A          LSR A                  ;|
$94:871C 4A          LSR A                  ;|
$94:871D 4A          LSR A                  ;|
$94:871E CD 16 42    CMP $4216  [$7E:4216]  ;|
$94:8721 F0 02       BEQ $02    [$8725]     ;/
$94:8723 18          CLC                    ;\
$94:8724 60          RTS                    ;} Return carry clear

$94:8725 A5 18       LDA $18    [$7E:0018]  ;\
$94:8727 38          SEC                    ;|
$94:8728 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$94:872B 29 0F 00    AND #$000F             ;} $0DD4 = Fh - (Samus target top boundary) % 10h
$94:872E 49 0F 00    EOR #$000F             ;|
$94:8731 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:8734 BF 02 64 7F LDA $7F6402,x[$7F:6626];\
$94:8738 29 1F 00    AND #$001F             ;|
$94:873B 0A          ASL A                  ;|
$94:873C 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:873D 0A          ASL A                  ;|
$94:873E 0A          ASL A                  ;|
$94:873F 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:8742 BF 01 64 7F LDA $7F6401,x[$7F:6625];\
$94:8746 10 35       BPL $35    [$877D]     ;} If [block BTS] & 80h = 0: return carry clear
$94:8748 0A          ASL A                  ;\
$94:8749 30 05       BMI $05    [$8750]     ;} If [block BTS] & 40h = 0:
$94:874B AD F6 0A    LDA $0AF6  [$7E:0AF6]  ; A = [Samus X position] % 10h
$94:874E 80 06       BRA $06    [$8756]

$94:8750 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\ Else ([block BTS] & 40h != 0):
$94:8753 49 0F 00    EOR #$000F             ;} A = Fh - [Samus X position] % 10h

$94:8756 29 0F 00    AND #$000F
$94:8759 18          CLC                    ;\
$94:875A 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$94:875D AA          TAX                    ;} A = [$8B2B + [$0DD6] + [A]] (slope top Y offset)
$94:875E BD 2B 8B    LDA $8B2B,x[$94:8C57]  ;/
$94:8761 29 1F 00    AND #$001F
$94:8764 38          SEC                    ;\
$94:8765 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= [$0DD4] + 1
$94:8768 3A          DEC A                  ;/
$94:8769 F0 02       BEQ $02    [$876D]     ;\
$94:876B 10 0E       BPL $0E    [$877B]     ;} If [A] > 0: return carry clear

$94:876D 18          CLC                    ;\
$94:876E 65 12       ADC $12    [$7E:0012]  ;|
$94:8770 10 03       BPL $03    [$8775]     ;|
$94:8772 A9 00 00    LDA #$0000             ;} $12 = max(0, [$12] + [A])
                                            ;|
$94:8775 85 12       STA $12    [$7E:0012]  ;/
$94:8777 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$94:8779 38          SEC                    ;\
$94:877A 60          RTS                    ;} Return carry set

$94:877B 18          CLC
$94:877C 60          RTS

$94:877D 4C 7B 87    JMP $877B  [$94:877B]

; BRANCH_DOWN
$94:8780 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:8783 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:8786 E2 20       SEP #$20               ;|
$94:8788 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:878B 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:878E C2 20       REP #$20               ;|
$94:8790 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} If [current block index] % [room width in blocks] != [Samus X position] / 10h (Samus' centre isn't in block):
$94:8793 4A          LSR A                  ;|
$94:8794 4A          LSR A                  ;|
$94:8795 4A          LSR A                  ;|
$94:8796 4A          LSR A                  ;|
$94:8797 CD 16 42    CMP $4216  [$7E:4216]  ;|
$94:879A F0 02       BEQ $02    [$879E]     ;/
$94:879C 18          CLC                    ;\
$94:879D 60          RTS                    ;} Return carry clear

$94:879E A5 18       LDA $18    [$7E:0018]  ;\
$94:87A0 18          CLC                    ;|
$94:87A1 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$94:87A4 3A          DEC A                  ;} $0DD4 = (Samus target bottom boundary) % 10h
$94:87A5 29 0F 00    AND #$000F             ;|
$94:87A8 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:87AB BF 02 64 7F LDA $7F6402,x[$7F:6544];\
$94:87AF 29 1F 00    AND #$001F             ;|
$94:87B2 0A          ASL A                  ;|
$94:87B3 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:87B4 0A          ASL A                  ;|
$94:87B5 0A          ASL A                  ;|
$94:87B6 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:87B9 BF 01 64 7F LDA $7F6401,x[$7F:6543];\
$94:87BD 30 33       BMI $33    [$87F2]     ;} If [block BTS] & 80h = 0: return carry clear
$94:87BF 0A          ASL A                  ;\
$94:87C0 30 05       BMI $05    [$87C7]     ;} If [block BTS] & 40h = 0:
$94:87C2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ; A = [Samus X position] % 10h
$94:87C5 80 06       BRA $06    [$87CD]

$94:87C7 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\ Else ([block BTS] & 40h != 0):
$94:87CA 49 0F 00    EOR #$000F             ;} A = Fh - [Samus X position] % 10h

$94:87CD 29 0F 00    AND #$000F
$94:87D0 18          CLC                    ;\
$94:87D1 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$94:87D4 AA          TAX                    ;} A = [$8B2B + [$0DD6] + [A]] (slope top Y offset)
$94:87D5 BD 2B 8B    LDA $8B2B,x[$94:8C64]  ;/
$94:87D8 29 1F 00    AND #$001F
$94:87DB 38          SEC                    ;\
$94:87DC ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= [$0DD4] + 1
$94:87DF 3A          DEC A                  ;/
$94:87E0 F0 02       BEQ $02    [$87E4]     ;\
$94:87E2 10 0E       BPL $0E    [$87F2]     ;} If [A] > 0: return carry clear

$94:87E4 18          CLC                    ;\
$94:87E5 65 12       ADC $12    [$7E:0012]  ;|
$94:87E7 10 03       BPL $03    [$87EC]     ;|
$94:87E9 A9 00 00    LDA #$0000             ;} $12 = max(0, [$12] + [A])
                                            ;|
$94:87EC 85 12       STA $12    [$7E:0012]  ;/
$94:87EE 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$94:87F0 38          SEC                    ;\
$94:87F1 60          RTS                    ;} Return carry set

$94:87F2 18          CLC
$94:87F3 60          RTS
}


;;; $87F4: Align Samus Y position with non-square slope ;;;
{
$94:87F4 8B          PHB
$94:87F5 4B          PHK                    ;\
$94:87F6 AB          PLB                    ;} DB = $94
$94:87F7 AD 46 0A    LDA $0A46  [$7E:0A46]  ;\
$94:87FA 89 02 00    BIT #$0002             ;} If horizontal slope detection disabled:
$94:87FD D0 03       BNE $03    [$8802]     ;/
$94:87FF 4C 19 89    JMP $8919  [$94:8919]  ; Return

$94:8802 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$94:8805 85 1A       STA $1A    [$7E:001A]  ;} $1A = [Samus X position]
$94:8807 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:880A 18          CLC                    ;|
$94:880B 6D 00 0B    ADC $0B00  [$7E:0B00]  ;} $1C = (Samus bottom boundary position)
$94:880E 3A          DEC A                  ;|
$94:880F 85 1C       STA $1C    [$7E:001C]  ;/
$94:8811 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0
$94:8813 64 20       STZ $20    [$7E:0020]  ; $20 = 0
$94:8815 20 1D 9C    JSR $9C1D  [$94:9C1D]  ; Calculate block at ([$1A], [$1C])
$94:8818 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:881B 0A          ASL A                  ;|
$94:881C AA          TAX                    ;|
$94:881D BF 02 00 7F LDA $7F0002,x[$7F:0114];} If (block type) != slope: go to BRANCH_SAMUS_TOP_CHECK
$94:8821 29 00 F0    AND #$F000             ;|
$94:8824 C9 00 10    CMP #$1000             ;|
$94:8827 D0 61       BNE $61    [$888A]     ;/
$94:8829 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:882C BF 02 64 7F LDA $7F6402,x[$7F:648B];|
$94:8830 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh < 5 (square slope): go to BRANCH_SAMUS_TOP_CHECK
$94:8833 C9 05 00    CMP #$0005             ;|
$94:8836 90 52       BCC $52    [$888A]     ;/
$94:8838 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:883B 18          CLC                    ;|
$94:883C 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$94:883F 3A          DEC A                  ;} $0DD4 = (Samus bottom boundary) % 10h (Y distance into slope)
$94:8840 29 0F 00    AND #$000F             ;|
$94:8843 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:8846 BF 02 64 7F LDA $7F6402,x[$7F:6545];\
$94:884A 29 1F 00    AND #$001F             ;|
$94:884D 0A          ASL A                  ;|
$94:884E 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:884F 0A          ASL A                  ;|
$94:8850 0A          ASL A                  ;|
$94:8851 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:8854 BF 01 64 7F LDA $7F6401,x[$7F:6544];\
$94:8858 30 30       BMI $30    [$888A]     ;} If [block BTS] & 80h != 0: go to BRANCH_SAMUS_TOP_CHECK
$94:885A 0A          ASL A                  ;\
$94:885B 30 05       BMI $05    [$8862]     ;} If [block BTS] & 40h = 0:
$94:885D AD F6 0A    LDA $0AF6  [$7E:0AF6]  ; A = [Samus X position] % 10h (X distance into slope)
$94:8860 80 06       BRA $06    [$8868]

$94:8862 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\ Else ([block BTS] & 40h != 0):
$94:8865 49 0F 00    EOR #$000F             ;} A = Fh - [Samus X position] % 10h (X distance into slope)

$94:8868 29 0F 00    AND #$000F
$94:886B 18          CLC                    ;\
$94:886C 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;} X = (slope definition table base index) + [A] (slope definition index)
$94:886F AA          TAX                    ;/
$94:8870 BD 2B 8B    LDA $8B2B,x[$94:8C7C]  ;\
$94:8873 29 1F 00    AND #$001F             ;} A = [$8B2B + [X]] % 20h (slope top Y offset)
$94:8876 38          SEC                    ;\
$94:8877 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= (Y distance into slope) + 1
$94:887A 3A          DEC A                  ;/
$94:887B 10 0D       BPL $0D    [$888A]     ; If [A] >= 0 (Samus is above the slope): go to BRANCH_SAMUS_TOP_CHECK
$94:887D 18          CLC                    ;\
$94:887E 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;} Samus Y position += [A] (bring Samus on top of slope)
$94:8881 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$94:8884 A9 01 00    LDA #$0001             ;\
$94:8887 8D BA 0D    STA $0DBA  [$7E:0DBA]  ;} Samus position was adjusted by a slope flag = 1

; BRANCH_SAMUS_TOP_CHECK
$94:888A AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$94:888D 85 1A       STA $1A    [$7E:001A]  ;} $1A = [Samus X position]
$94:888F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:8892 38          SEC                    ;|
$94:8893 ED 00 0B    SBC $0B00  [$7E:0B00]  ;} $1C = (Samus top boundary)
$94:8896 85 1C       STA $1C    [$7E:001C]  ;/
$94:8898 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0
$94:889A 64 20       STZ $20    [$7E:0020]  ; $20 = 0
$94:889C 20 1D 9C    JSR $9C1D  [$94:9C1D]  ; Calculate block at ([$1A], [$1C])
$94:889F AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:88A2 0A          ASL A                  ;|
$94:88A3 AA          TAX                    ;|
$94:88A4 BF 02 00 7F LDA $7F0002,x[$7F:00B4];} If (block type) != slope: return
$94:88A8 29 00 F0    AND #$F000             ;|
$94:88AB C9 00 10    CMP #$1000             ;|
$94:88AE D0 69       BNE $69    [$8919]     ;/
$94:88B0 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:88B3 BF 02 64 7F LDA $7F6402,x[$7F:65FF];|
$94:88B7 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh < 5 (square slope): return
$94:88BA C9 05 00    CMP #$0005             ;|
$94:88BD 90 5A       BCC $5A    [$8919]     ;/
$94:88BF AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:88C2 38          SEC                    ;|
$94:88C3 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$94:88C6 29 0F 00    AND #$000F             ;} $0DD4 = Fh - (Samus top boundary) % 10h (Y distance into slope)
$94:88C9 49 0F 00    EOR #$000F             ;|
$94:88CC 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:88CF BF 02 64 7F LDA $7F6402,x[$7F:6626];\
$94:88D3 29 1F 00    AND #$001F             ;|
$94:88D6 0A          ASL A                  ;|
$94:88D7 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:88D8 0A          ASL A                  ;|
$94:88D9 0A          ASL A                  ;|
$94:88DA 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:88DD BF 01 64 7F LDA $7F6401,x[$7F:6625];\
$94:88E1 10 36       BPL $36    [$8919]     ;} If [block BTS] & 80h != 0: return
$94:88E3 0A          ASL A                  ;\
$94:88E4 30 05       BMI $05    [$88EB]     ;} If [block BTS] & 40h = 0:
$94:88E6 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ; A = [Samus X position] % 10h (X distance into slope)
$94:88E9 80 06       BRA $06    [$88F1]

$94:88EB AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\ Else ([block BTS] & 40h != 0):
$94:88EE 49 0F 00    EOR #$000F             ;} A = Fh - [Samus X position] % 10h (X distance into slope)

$94:88F1 29 0F 00    AND #$000F
$94:88F4 18          CLC                    ;\
$94:88F5 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;} X = (slope definition table base index) + [A] (slope definition index)
$94:88F8 AA          TAX                    ;/
$94:88F9 BD 2B 8B    LDA $8B2B,x[$94:8C53]  ;\
$94:88FC 29 1F 00    AND #$001F             ;} A = [$8B2B + [X]] % 20h (slope top Y offset)
$94:88FF 38          SEC                    ;\
$94:8900 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= (Y distance into slope) + 1
$94:8903 3A          DEC A                  ;/
$94:8904 F0 02       BEQ $02    [$8908]     ;\
$94:8906 10 11       BPL $11    [$8919]     ;} If [A] > 0 (Samus is above the slope): return

$94:8908 49 FF FF    EOR #$FFFF             ;\
$94:890B 1A          INC A                  ;|
$94:890C 18          CLC                    ;} Samus Y position -= [A] (bring Samus under slope)
$94:890D 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;|
$94:8910 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$94:8913 A9 01 00    LDA #$0001             ;\
$94:8916 8D BA 0D    STA $0DBA  [$7E:0DBA]  ;} Samus position was adjusted by a slope flag = 1

$94:8919 AB          PLB
$94:891A 6B          RTL
}


;;; $891B: Unused slope definition ;;;
{
$94:891B             db 0F,0E,0D,0C,0B,0A,09,08,07,06,05,04,03,02,01,00
}


;;; $892B: Slope definitions (slope left X offset by Y pixel) ;;;
{
; ALMOST unused, used only by post-grapple collision detection (which has no effect), but referenced by some unused code too
; Data here looks incorrect, many of the rows here are identical to $8B2B
; Indexed by ([block BTS] & 1Fh) * 10h + [Samus Y position] % 10h
$94:892B             db 10,10,10,10,10,10,10,10,00,00,00,00,00,00,00,00,
                        08,08,08,08,08,08,08,08,08,08,08,08,08,08,08,08,
                        10,10,10,10,10,10,10,10,08,08,08,08,08,08,08,08,
                        08,08,08,08,08,08,08,08,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        10,0F,0E,0D,0C,0B,0A,09,09,0A,0B,0C,0D,0E,0F,10, ; 5: Unused. Half height isosceles triangle
                        10,0E,0C,0A,08,06,04,02,02,04,06,08,0A,0C,0E,10, ; 6: Unused. Isosceles triangle
                        10,10,10,10,10,10,10,10,00,00,00,00,00,00,00,00, ; 7: Half height rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; 8: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; 9: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; Ah: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; Bh: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; Ch: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; Dh: Unused. Rectangle
                        0C,0C,0C,0C,08,08,08,08,04,04,04,04,00,00,00,00, ; Eh: Unused. Very bumpy triangle
                        0E,0E,0C,0C,0A,0A,08,08,06,06,04,04,02,02,00,00, ; Fh: Bumpy triangle
                        10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10, ; 10h: Unused
                        14,14,14,14,14,14,14,14,14,14,14,14,14,10,10,10, ; 11h: Unused
                        10,0F,0E,0D,0C,0B,0A,09,08,07,06,05,04,03,02,01, ; 12h: Triangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; 13h: Rectangle
                        10,10,10,10,10,10,10,10,10,0F,0E,0D,0C,0B,0A,09, ; 14h: Quarter triangle
                        08,07,06,05,04,03,02,01,00,00,00,00,00,00,00,00, ; 15h: Three quarter triangle
                        10,10,10,10,10,10,10,10,10,0E,0C,0A,08,06,04,02, ; 16h: Lower half-height triangle
                        00,00,00,00,00,00,00,00,00,02,04,06,08,0A,0C,0E, ; 17h: Upper half-height triangle
                        10,10,10,0F,0F,0F,0E,0E,0E,0D,0D,0D,0C,0C,0C,0B, ; 18h: Unused. Lower third-height triangle
                        0B,0B,0A,0A,0A,09,09,09,08,08,08,07,07,07,06,06, ; 19h: Unused. Middle third-height triangle
                        06,05,05,05,04,04,04,03,03,03,02,02,02,01,01,01, ; 1Ah: Unused. Upper third-height triangle
                        14,14,14,14,14,14,14,14,10,0E,0C,0A,08,06,04,02, ; 1Bh: Upper half-width triangle
                        10,0E,0C,0A,08,06,04,02,00,00,00,00,00,00,00,00, ; 1Ch: Lower half-width triangle
                        14,14,14,14,14,14,14,14,14,14,14,0F,0C,09,06,03, ; 1Dh: Unused. Upper third-width triangle
                        14,14,14,14,14,14,0E,0B,08,05,02,00,00,00,00,00, ; 1Eh: Unused. Middle third-width triangle
                        10,0D,0A,07,04,01,00,00,00,00,00,00,00,00,00,00  ; 1Fh: Unused. Lower third-width triangle
}


;;; $8B2B: Slope definitions (slope top Y offset by X pixel) ;;;
{
; Indexed by ([block BTS] & 1Fh) * 10h + [Samus X position] % 10h
$94:8B2B             db 08,08,08,08,08,08,08,08,08,08,08,08,08,08,08,08,
                        10,10,10,10,10,10,10,10,00,00,00,00,00,00,00,00,
                        10,10,10,10,10,10,10,10,08,08,08,08,08,08,08,08,
                        08,08,08,08,08,08,08,08,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        10,0F,0E,0D,0C,0B,0A,09,09,0A,0B,0C,0D,0E,0F,10, ; 5: Unused. Half height isosceles triangle
                        10,0E,0C,0A,08,06,04,02,02,04,06,08,0A,0C,0E,10, ; 6: Unused. Isosceles triangle
                        08,08,08,08,08,08,08,08,08,08,08,08,08,08,08,08, ; 7: Half height rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; 8: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; 9: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; Ah: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; Bh: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; Ch: Unused. Rectangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; Dh: Unused. Rectangle
                        0C,0C,0C,0C,08,08,08,08,04,04,04,04,00,00,00,00, ; Eh: Unused. Very bumpy triangle
                        0E,0E,0C,0C,0A,0A,08,08,06,06,04,04,02,02,00,00, ; Fh: Bumpy triangle
                        10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10, ; 10h: Unused
                        14,14,14,14,14,14,14,14,14,14,14,14,14,10,10,10, ; 11h: Unused
                        10,0F,0E,0D,0C,0B,0A,09,08,07,06,05,04,03,02,01, ; 12h: Triangle
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00, ; 13h: Rectangle
                        10,10,10,10,10,10,10,10,10,0F,0E,0D,0C,0B,0A,09, ; 14h: Quarter triangle
                        08,07,06,05,04,03,02,01,00,00,00,00,00,00,00,00, ; 15h: Three quarter triangle
                        10,10,0F,0F,0E,0E,0D,0D,0C,0C,0B,0B,0A,0A,09,09, ; 16h: Lower half-height triangle
                        08,08,07,07,06,06,05,05,04,04,03,03,02,02,01,01, ; 17h: Upper half-height triangle
                        10,10,10,0F,0F,0F,0E,0E,0E,0D,0D,0D,0C,0C,0C,0B, ; 18h: Unused. Lower third-height triangle
                        0B,0B,0A,0A,0A,09,09,09,08,08,08,07,07,07,06,06, ; 19h: Unused. Middle third-height triangle
                        06,05,05,05,04,04,04,03,03,03,02,02,02,01,01,01, ; 1Ah: Unused. Upper third-height triangle
                        14,14,14,14,14,14,14,14,10,0E,0C,0A,08,06,04,02, ; 1Bh: Upper half-width triangle
                        10,0E,0C,0A,08,06,04,02,00,00,00,00,00,00,00,00, ; 1Ch: Lower half-width triangle
                        14,14,14,14,14,14,14,14,14,14,14,0F,0C,09,06,03, ; 1Dh: Unused. Upper third-width triangle
                        14,14,14,14,14,14,0E,0B,08,05,02,00,00,00,00,00, ; 1Eh: Unused. Middle third-width triangle
                        10,0D,0A,07,04,01,00,00,00,00,00,00,00,00,00,00  ; 1Fh: Unused. Lower third-width triangle
}


;;; $8D2B: Samus block collision reaction - horizontal - slope - square ;;;
{
;; Parameters:
;;     A: [Block BTS] & 1Fh
;;     X: Block index
;;     $12.$14: Distance to check for collision
;;     $1A: Number of blocks left to check (0 if final (bottom) block)
;;     $1C: Samus' Y block span
;;     $20: Target boundary position (left/right depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:8D2B 0A          ASL A                  ;\
$94:8D2C 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$94:8D2D 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:8D30 BF 01 64 7F LDA $7F6401,x[$7F:648D];\
$94:8D34 2A          ROL A                  ;|
$94:8D35 2A          ROL A                  ;|
$94:8D36 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$94:8D37 29 03 00    AND #$0003             ;|
$94:8D3A 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:8D3D A5 20       LDA $20    [$7E:0020]  ;\
$94:8D3F 29 08 00    AND #$0008             ;} A = [$20] & 8 (is Samus boundary in right half of block)
$94:8D42 4A          LSR A                  ;\
$94:8D43 4A          LSR A                  ;|
$94:8D44 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 3 (toggle X flip flag if Samus is in right half of block)
$94:8D45 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$94:8D48 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$94:8D4B AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$94:8D4C A5 1A       LDA $1A    [$7E:001A]  ;\
$94:8D4E D0 14       BNE $14    [$8D64]     ;} If [$1A] = 0 (bottom block check):
$94:8D50 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:8D53 18          CLC                    ;|
$94:8D54 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$94:8D57 3A          DEC A                  ;} If Samus bottom boundary is in bottom half: go to BRANCH_CHECK_BOTH_HALVES
$94:8D58 29 08 00    AND #$0008             ;|
$94:8D5B D0 17       BNE $17    [$8D74]     ;/
$94:8D5D BD 53 8E    LDA $8E53,x[$94:8E53]  ;\
$94:8D60 30 23       BMI $23    [$8D85]     ;} If [$8E54 + [X]] & 80h != 0 (top half is solid): go to BRANCH_SOLID
$94:8D62 80 1F       BRA $1F    [$8D83]     ; Return carry clear

$94:8D64 C5 1C       CMP $1C    [$7E:001C]  ;\
$94:8D66 D0 0C       BNE $0C    [$8D74]     ;} If [$1A] = [$1C] (top block check):
$94:8D68 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:8D6B 38          SEC                    ;|
$94:8D6C ED 00 0B    SBC $0B00  [$7E:0B00]  ;} If Samus top boundary is in bottom half: go to BRANCH_CHECK_BOTTOM_HALF
$94:8D6F 29 08 00    AND #$0008             ;|
$94:8D72 D0 05       BNE $05    [$8D79]     ;/

; BRANCH_CHECK_BOTH_HALVES
$94:8D74 BD 53 8E    LDA $8E53,x[$94:8E57]  ;\
$94:8D77 30 0C       BMI $0C    [$8D85]     ;} If [$8E54 + [X]] & 80h != 0 (top half is solid): go to BRANCH_SOLID

; BRANCH_CHECK_BOTTOM_HALF
$94:8D79 8A          TXA                    ;\
$94:8D7A 49 02 00    EOR #$0002             ;|
$94:8D7D AA          TAX                    ;} If [$8E54 + ([X] ^ 2)] & 80h != 0 (bottom half is solid): go to BRANCH_SOLID
$94:8D7E BD 53 8E    LDA $8E53,x[$94:8E59]  ;|
$94:8D81 30 02       BMI $02    [$8D85]     ;/

$94:8D83 18          CLC                    ;\
$94:8D84 60          RTS                    ;} Return carry clear

; BRANCH_SOLID
$94:8D85 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$94:8D87 A5 20       LDA $20    [$7E:0020]
$94:8D89 24 12       BIT $12    [$7E:0012]  ;\
$94:8D8B 30 19       BMI $19    [$8DA6]     ;} If [$12] >= 0:
$94:8D8D 29 F8 FF    AND #$FFF8             ; A = [$20] - [$20] % 8 (target right boundary rounded down to left of 8x8 tile)
$94:8D90 38          SEC                    ;\
$94:8D91 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$94:8D94 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$94:8D97 10 03       BPL $03    [$8D9C]     ;} $12 = max(0, [A] - (Samus right boundary))
$94:8D99 A9 00 00    LDA #$0000             ;|
                                            ;|
$94:8D9C 85 12       STA $12    [$7E:0012]  ;/
$94:8D9E A9 FF FF    LDA #$FFFF             ;\
$94:8DA1 8D F8 0A    STA $0AF8  [$7E:0AF8]  ;} Samus X subposition = FFFFh
$94:8DA4 38          SEC                    ;\
$94:8DA5 60          RTS                    ;} Return carry set

$94:8DA6 09 07 00    ORA #$0007             ;\
$94:8DA9 38          SEC                    ;} A = [$20] - [$20] % 8 + 8 (target left boundary rounded up to right of 8x8 tile)
$94:8DAA 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;\
$94:8DAD 38          SEC                    ;|
$94:8DAE ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$94:8DB1 30 03       BMI $03    [$8DB6]     ;} $12 = max(0, [A] - (Samus left boundary))
$94:8DB3 A9 00 00    LDA #$0000             ;|
                                            ;|
$94:8DB6 85 12       STA $12    [$7E:0012]  ;/
$94:8DB8 9C F8 0A    STZ $0AF8  [$7E:0AF8]  ; Samus X subposition = 0
$94:8DBB 38          SEC                    ;\
$94:8DBC 60          RTS                    ;} Return carry set
}


;;; $8DBD: Samus block collision reaction - vertical - slope - square ;;;
{
;; Parameters:
;;     A: [Block BTS] & 1Fh
;;     X: Block index
;;     $12: Distance to check for collision
;;     $1A: Number of blocks left to check (0 if final (rightmost) block)
;;     $1C: Samus' X block span
;;     $20: Target boundary position (top/bottom depending on sign of [$12])
;; Returns:
;;     Carry: Set if Samus collides with solid slope, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision
$94:8DBD 0A          ASL A                  ;\
$94:8DBE 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$94:8DBF 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:8DC2 BF 01 64 7F LDA $7F6401,x[$7F:648A];\
$94:8DC6 2A          ROL A                  ;|
$94:8DC7 2A          ROL A                  ;|
$94:8DC8 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$94:8DC9 29 03 00    AND #$0003             ;|
$94:8DCC 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:8DCF A5 20       LDA $20    [$7E:0020]  ;\
$94:8DD1 29 08 00    AND #$0008             ;} A = [$20] & 8 (is target boundary in lower half of block)
$94:8DD4 4A          LSR A                  ;\
$94:8DD5 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 2 (toggle Y flip flag if Samus is in lower half of block)
$94:8DD6 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$94:8DD9 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$94:8DDC AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$94:8DDD A5 1A       LDA $1A    [$7E:001A]  ;\
$94:8DDF D0 14       BNE $14    [$8DF5]     ;} If [$1A] = 0 (rightmost block check):
$94:8DE1 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$94:8DE4 18          CLC                    ;|
$94:8DE5 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;|
$94:8DE8 3A          DEC A                  ;} If Samus right boundary is in right half: go to BRANCH_CHECK_BOTH_HALVES
$94:8DE9 29 08 00    AND #$0008             ;|
$94:8DEC D0 17       BNE $17    [$8E05]     ;/
$94:8DEE BD 53 8E    LDA $8E53,x[$94:8E53]  ;\
$94:8DF1 30 23       BMI $23    [$8E16]     ;} If [$8E54 + [X]] & 80h != 0 (left half is solid): go to BRANCH_SOLID
$94:8DF3 80 1F       BRA $1F    [$8E14]     ; Return carry clear

$94:8DF5 C5 1C       CMP $1C    [$7E:001C]  ;\
$94:8DF7 D0 0C       BNE $0C    [$8E05]     ;} If [$1A] = [$1C] (leftmost block check):
$94:8DF9 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$94:8DFC 38          SEC                    ;|
$94:8DFD ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;} If Samus left boundary is in right half: go to BRANCH_CHECK_RIGHT_HALF
$94:8E00 29 08 00    AND #$0008             ;|
$94:8E03 D0 05       BNE $05    [$8E0A]     ;/

; BRANCH_CHECK_BOTH_HALVES
$94:8E05 BD 53 8E    LDA $8E53,x[$94:8E55]  ;\
$94:8E08 30 0C       BMI $0C    [$8E16]     ;} If [$8E54 + [X]] & 80h != 0 (left half is solid): go to BRANCH_SOLID

; BRANCH_CHECK_RIGHT_HALF
$94:8E0A 8A          TXA                    ;\
$94:8E0B 49 01 00    EOR #$0001             ;|
$94:8E0E AA          TAX                    ;} If [$8E54 + ([X] ^ 1)] & 80h != 0 (right half is solid): go to BRANCH_SOLID
$94:8E0F BD 53 8E    LDA $8E53,x[$94:8E54]  ;|
$94:8E12 30 02       BMI $02    [$8E16]     ;/

$94:8E14 18          CLC                    ;\
$94:8E15 60          RTS                    ;} Return carry clear

; BRANCH_SOLID
$94:8E16 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$94:8E18 A5 20       LDA $20    [$7E:0020]
$94:8E1A 24 12       BIT $12    [$7E:0012]  ;\
$94:8E1C 30 1F       BMI $1F    [$8E3D]     ;} If [$12] >= 0:
$94:8E1E 29 F8 FF    AND #$FFF8             ; A = [$20] - [$20] % 8 (target bottom boundary rounded down to top of 8x8 tile)
$94:8E21 38          SEC                    ;\
$94:8E22 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$94:8E25 ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$94:8E28 10 03       BPL $03    [$8E2D]     ;} $12 = max(0, [A] - (Samus bottom boundary))
$94:8E2A A9 00 00    LDA #$0000             ;|
                                            ;|
$94:8E2D 85 12       STA $12    [$7E:0012]  ;/
$94:8E2F A9 FF FF    LDA #$FFFF             ;\
$94:8E32 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus Y subposition = FFFFh
$94:8E35 A9 01 00    LDA #$0001             ;\
$94:8E38 8D BA 0D    STA $0DBA  [$7E:0DBA]  ;} Samus position was adjusted by a slope flag = 1
$94:8E3B 38          SEC                    ;\
$94:8E3C 60          RTS                    ;} Return carry set

$94:8E3D 09 07 00    ORA #$0007             ;\
$94:8E40 38          SEC                    ;} A = [$20] - [$20] % 8 + 8 (target top boundary rounded up to bottom of 8x8 tile)
$94:8E41 6D 00 0B    ADC $0B00  [$7E:0B00]  ;\
$94:8E44 38          SEC                    ;|
$94:8E45 ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$94:8E48 30 03       BMI $03    [$8E4D]     ;} $12 = min(0, [A] - (Samus top boundary))
$94:8E4A A9 00 00    LDA #$0000             ;|
                                            ;|
$94:8E4D 85 12       STA $12    [$7E:0012]  ;/
$94:8E4F 9C FC 0A    STZ $0AFC  [$7E:0AFC]  ; Samus Y subposition = 0
$94:8E52 38          SEC                    ;\
$94:8E53 60          RTS                    ;} Return carry set

}


;;; $8E54: Square slope definitions ;;;
{
; Enemies use $A0:C435
; 0 = air, 80h = solid

;                        __________ Top-left
;                       |   _______ Top-right
;                       |  |   ____ Bottom-left
;                       |  |  |   _ Bottom-right
;                       |  |  |  |
$94:8E54             db 00,00,80,80, ; 0: Half height
                        00,80,00,80, ; 1: Half width
                        00,00,00,80, ; 2: Quarter
                        00,80,80,80, ; 3: Three-quarters
                        80,80,80,80  ; 4: Whole
}


;;; $8E68: Unused. Determine Samus suit palette index ;;;
{
;; Returns:
;;     Y: 4 if gravity suit equipped, 2 if varia suit equipped, 0 otherwise

; Basing this routine name on $90:ECB6
$94:8E68 A0 04 00    LDY #$0004
$94:8E6B AD A2 09    LDA $09A2  [$7E:09A2]
$94:8E6E 89 20 00    BIT #$0020
$94:8E71 D0 09       BNE $09    [$8E7C]
$94:8E73 88          DEY
$94:8E74 88          DEY
$94:8E75 89 01 00    BIT #$0001
$94:8E78 D0 02       BNE $02    [$8E7C]
$94:8E7A 88          DEY
$94:8E7B 88          DEY

$94:8E7C 60          RTS
}


;;; $8E7D: Clear carry ;;;
{
$94:8E7D 18          CLC
$94:8E7E 60          RTS
}


;;; $8E7F: Clear carry ;;;
{
$94:8E7F 18          CLC
$94:8E80 60          RTS
}


;;; $8E81: Clear carry ;;;
{
$94:8E81 18          CLC
$94:8E82 60          RTS
}


;;; $8E83: Samus block collision reaction - spike block - BTS 0 (generic spike) ;;;
{
$94:8E83 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$94:8E86 C9 03 00    CMP #$0003             ;} If [area index] = Wrecked Ship:
$94:8E89 D0 09       BNE $09    [$8E94]     ;/
$94:8E8B A9 01 00    LDA #$0001             ;\
$94:8E8E 22 DC 81 80 JSL $8081DC[$80:81DC]  ;} If Phantoon is not dead: return
$94:8E92 90 3A       BCC $3A    [$8ECE]     ;/

$94:8E94 AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$94:8E97 D0 35       BNE $35    [$8ECE]     ;} If [Samus invincibility timer] != 0: return
$94:8E99 A9 3C 00    LDA #$003C             ;\
$94:8E9C 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 60
$94:8E9F A9 0A 00    LDA #$000A             ;\
$94:8EA2 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = Ah
$94:8EA5 AD 4E 0A    LDA $0A4E  [$7E:0A4E]
$94:8EA8 18          CLC
$94:8EA9 69 00 00    ADC #$0000
$94:8EAC 8D 4E 0A    STA $0A4E  [$7E:0A4E]
$94:8EAF AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$94:8EB2 69 3C 00    ADC #$003C             ;} Periodic damage += 60
$94:8EB5 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$94:8EB8 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$94:8EBB 49 0C 00    EOR #$000C             ;|
$94:8EBE 89 08 00    BIT #$0008             ;} If facing left:
$94:8EC1 F0 08       BEQ $08    [$8ECB]     ;/
$94:8EC3 A9 01 00    LDA #$0001             ;\
$94:8EC6 8D 54 0A    STA $0A54  [$7E:0A54]  ;} Knockback X direction = right
$94:8EC9 80 03       BRA $03    [$8ECE]

$94:8ECB 9C 54 0A    STZ $0A54  [$7E:0A54]  ; Knockback X direction = left

$94:8ECE 60          RTS
}


;;; $8ECF: Samus block collision reaction - spike block - BTS 1 (Kraid's lair spike) ;;;
{
$94:8ECF AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$94:8ED2 D0 35       BNE $35    [$8F09]     ;} If [Samus invincibility timer] != 0: return
$94:8ED4 A9 3C 00    LDA #$003C             ;\
$94:8ED7 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 60
$94:8EDA A9 0A 00    LDA #$000A             ;\
$94:8EDD 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = Ah
$94:8EE0 AD 4E 0A    LDA $0A4E  [$7E:0A4E]
$94:8EE3 18          CLC
$94:8EE4 69 00 00    ADC #$0000
$94:8EE7 8D 4E 0A    STA $0A4E  [$7E:0A4E]
$94:8EEA AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$94:8EED 69 10 00    ADC #$0010             ;} Periodic damage += 10h
$94:8EF0 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$94:8EF3 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$94:8EF6 49 0C 00    EOR #$000C             ;|
$94:8EF9 89 08 00    BIT #$0008             ;} If facing left:
$94:8EFC F0 08       BEQ $08    [$8F06]     ;/
$94:8EFE A9 01 00    LDA #$0001             ;\
$94:8F01 8D 54 0A    STA $0A54  [$7E:0A54]  ;} Knockback X direction = right
$94:8F04 80 03       BRA $03    [$8F09]

$94:8F06 9C 54 0A    STZ $0A54  [$7E:0A54]  ; Knockback X direction = left

$94:8F09 60          RTS
}


;;; $8F0A: Samus block collision reaction - spike block - BTS 3 (Draygon's broken turret) ;;;
{
; Clone of $8ECF
$94:8F0A AD A8 18    LDA $18A8  [$7E:18A8]
$94:8F0D D0 35       BNE $35    [$8F44]
$94:8F0F A9 3C 00    LDA #$003C
$94:8F12 8D A8 18    STA $18A8  [$7E:18A8]
$94:8F15 A9 0A 00    LDA #$000A
$94:8F18 8D AA 18    STA $18AA  [$7E:18AA]
$94:8F1B AD 4E 0A    LDA $0A4E  [$7E:0A4E]
$94:8F1E 18          CLC
$94:8F1F 69 00 00    ADC #$0000
$94:8F22 8D 4E 0A    STA $0A4E  [$7E:0A4E]
$94:8F25 AD 50 0A    LDA $0A50  [$7E:0A50]
$94:8F28 69 10 00    ADC #$0010
$94:8F2B 8D 50 0A    STA $0A50  [$7E:0A50]
$94:8F2E AD 1E 0A    LDA $0A1E  [$7E:0A1E]
$94:8F31 49 0C 00    EOR #$000C
$94:8F34 89 08 00    BIT #$0008
$94:8F37 F0 08       BEQ $08    [$8F41]
$94:8F39 A9 01 00    LDA #$0001
$94:8F3C 8D 54 0A    STA $0A54  [$7E:0A54]
$94:8F3F 80 03       BRA $03    [$8F44]

$94:8F41 9C 54 0A    STZ $0A54  [$7E:0A54]

$94:8F44 60          RTS
}


;;; $8F45: Set carry ;;;
{
$94:8F45 38          SEC
$94:8F46 60          RTS
}


;;; $8F47: Clear carry ;;;
{
$94:8F47 18          CLC
$94:8F48 60          RTS
}


;;; $8F49: Samus block collision reaction - horizontal - solid/shootable/grapple block ;;;
{
;; Parameters:
;;     $12: Distance to check for collision
;;     $20: Target boundary position (left/right depending on sign of [$12])
;; Returns:
;;     Carry: Set. Unconditional collision
;;     $12.$14: Distance to collision

; RTS this routine to enable walk through walls, works surprisingly effectively
$94:8F49 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$94:8F4B A5 20       LDA $20    [$7E:0020]
$94:8F4D 24 12       BIT $12    [$7E:0012]  ;\
$94:8F4F 30 1A       BMI $1A    [$8F6B]     ;} If [$12] >= 0:
$94:8F51 29 F0 FF    AND #$FFF0             ; A = [$20] - [$20] % 10h (target right boundary rounded down to left of 16x16 tile)
$94:8F54 38          SEC                    ;\
$94:8F55 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$94:8F58 38          SEC                    ;|
$94:8F59 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$94:8F5C 10 03       BPL $03    [$8F61]     ;} $12 = max(0, [A] - (Samus right boundary))
$94:8F5E A9 00 00    LDA #$0000             ;|
                                            ;|
$94:8F61 85 12       STA $12    [$7E:0012]  ;/
$94:8F63 A9 FF FF    LDA #$FFFF             ;\
$94:8F66 8D F8 0A    STA $0AF8  [$7E:0AF8]  ;} Samus X subposition = FFFFh
$94:8F69 38          SEC                    ;\
$94:8F6A 60          RTS                    ;} Return carry set

$94:8F6B 09 0F 00    ORA #$000F             ;\
$94:8F6E 38          SEC                    ;} A = [$20] - [$20] % 10h + 10h (target left boundary rounded up to right of 16x16 tile)
$94:8F6F 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;\
$94:8F72 38          SEC                    ;|
$94:8F73 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$94:8F76 30 03       BMI $03    [$8F7B]     ;} $12 = max(0, [A] - (Samus left boundary))
$94:8F78 A9 00 00    LDA #$0000             ;|
                                            ;|
$94:8F7B 85 12       STA $12    [$7E:0012]  ;/
$94:8F7D 9C F8 0A    STZ $0AF8  [$7E:0AF8]  ; Samus X subposition = 0
$94:8F80 38          SEC                    ;\
$94:8F81 60          RTS                    ;} Return carry set
}


;;; $8F82: Samus block collision reaction - vertical - solid/shootable/grapple block ;;;
{
;; Parameters:
;;     $12: Distance to check for collision
;;     $20: Target boundary position (top/bottom depending on sign of [$12])
;; Returns:
;;     Carry: Set. Unconditional collision
;;     $12.$14: Distance to collision

$94:8F82 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$94:8F84 A5 20       LDA $20    [$7E:0020]
$94:8F86 24 12       BIT $12    [$7E:0012]  ;\
$94:8F88 30 1A       BMI $1A    [$8FA4]     ;} If [$12] >= 0:
$94:8F8A 29 F0 FF    AND #$FFF0             ; A = [$20] - [$20] % 10h (target bottom boundary rounded down to top of 16x16 tile)
$94:8F8D 38          SEC                    ;\
$94:8F8E ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$94:8F91 38          SEC                    ;|
$94:8F92 ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$94:8F95 10 03       BPL $03    [$8F9A]     ;} $12 = max(0, [A] - 1 - (Samus bottom boundary))
$94:8F97 A9 00 00    LDA #$0000             ;|
                                            ;|
$94:8F9A 85 12       STA $12    [$7E:0012]  ;/
$94:8F9C A9 FF FF    LDA #$FFFF             ;\
$94:8F9F 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus Y subposition = FFFFh
$94:8FA2 38          SEC                    ;\
$94:8FA3 60          RTS                    ;} Return carry set

$94:8FA4 09 0F 00    ORA #$000F             ; A = [$20] - [$20] % 10h + Fh (target top boundary rounded up to bottom of 16x16 tile)
$94:8FA7 38          SEC                    ;\
$94:8FA8 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$94:8FAB 38          SEC                    ;|
$94:8FAC ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$94:8FAF 30 03       BMI $03    [$8FB4]     ;} $12 = min(0, [A] + 1 - (Samus top boundary))
$94:8FB1 A9 00 00    LDA #$0000             ;|
                                            ;|
$94:8FB4 85 12       STA $12    [$7E:0012]  ;/
$94:8FB6 9C FC 0A    STZ $0AFC  [$7E:0AFC]  ; Samus Y subposition = 0
$94:8FB9 38          SEC                    ;\
$94:8FBA 60          RTS                    ;} Return carry set
}


;;; $8FBB: Samus block collision reaction - horizontal - slope ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;;     $1A: Number of blocks left to check (0 if final (bottom) block)
;;     $1C: Samus' Y block span
;;     $20: Target boundary position (left/right depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:8FBB AE C4 0D    LDX $0DC4  [$7E:0DC4]  ; X = [current block index]
$94:8FBE BF 02 64 7F LDA $7F6402,x[$7F:648E]; A = [block BTS]
$94:8FC2 29 1F 00    AND #$001F             ;\
$94:8FC5 C9 05 00    CMP #$0005             ;} If [block BTS] & 1Fh >= 5:
$94:8FC8 90 0D       BCC $0D    [$8FD7]     ;/
$94:8FCA BF 02 64 7F LDA $7F6402,x[$7F:6546];\
$94:8FCE 29 FF 00    AND #$00FF             ;} Current slope BTS = [block BTS]
$94:8FD1 8D 77 1E    STA $1E77  [$7E:1E77]  ;/
$94:8FD4 4C D6 84    JMP $84D6  [$94:84D6]  ; Go to Samus block collision reaction - horizontal - slope - non-square

$94:8FD7 4C 2B 8D    JMP $8D2B  [$94:8D2B]  ; Go to Samus block collision reaction - horizontal - slope - square
}


;;; $8FDA: Samus block collision reaction - vertical - slope ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;;     $18: Target Y position
;;     $1A: Number of blocks left to check (0 if final (rightmost) block)
;;     $1C: Samus' X block span
;;     $20: Target boundary position (top/bottom depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:8FDA AE C4 0D    LDX $0DC4  [$7E:0DC4]  ; X = [current block index]
$94:8FDD BF 02 64 7F LDA $7F6402,x[$7F:648B]; A = [block BTS]
$94:8FE1 29 1F 00    AND #$001F             ;\
$94:8FE4 C9 05 00    CMP #$0005             ;} If [block BTS] & 1Fh >= 5:
$94:8FE7 90 0A       BCC $0A    [$8FF3]     ;/
$94:8FE9 BF 02 64 7F LDA $7F6402,x[$7F:6544];\
$94:8FED 8D 77 1E    STA $1E77  [$7E:1E77]  ;} Current slope BTS = [block BTS]
$94:8FF0 4C FE 86    JMP $86FE  [$94:86FE]  ; Go to Samus block collision reaction - vertical - slope - non-square

$94:8FF3 4C BD 8D    JMP $8DBD  [$94:8DBD]  ; Go to Samus block collision reaction - vertical - slope - square
}


;;; $8FF6: Samus block collision reaction - vertical - spike air - jump table ;;;
{
; Yeah, great table
$94:8FF6             dw 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81, 8E81
}


;;; $9018: Clear carry ;;;
{
$94:9018 18          CLC
$94:9019 60          RTS
}


;;; $901A: Samus block collision reaction - vertical - spike air ;;;
{
; Does nothing
$94:901A AE C4 0D    LDX $0DC4  [$7E:0DC4]
$94:901D BF 02 64 7F LDA $7F6402,x[$7F:665E]
$94:9021 29 FF 00    AND #$00FF
$94:9024 0A          ASL A
$94:9025 AA          TAX
$94:9026 FC F6 8F    JSR ($8FF6,x)[$94:8E81]
$94:9029 18          CLC
$94:902A 60          RTS
}


;;; $902B: Samus block collision reaction - spike block - jump table ;;;
{
$94:902B             dw 8E83, 8ECF, 8F45, 8F0A, 8F45, 8F45, 8F45, 8F45, 8F45, 8F45, 8F45, 8F45, 8F45, 8F45, 8F45, 8F45
}


;;; $904B: Samus block collision reaction - horizontal - spike block ;;;
{
;; Parameters:
;;     $12: Distance to check for collision
;;     $20: Target boundary position (left/right depending on sign of [$12])
;; Returns:
;;     Carry: Set. Unconditional collision
;;     $12.$14: Distance to collision

$94:904B AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:904E BF 02 64 7F LDA $7F6402,x[$7F:6691];|
$94:9052 0A          ASL A                  ;|
$94:9053 29 FF 01    AND #$01FF             ;} Execute [$902B + [block BTS] * 2]
$94:9056 AA          TAX                    ;|
$94:9057 FC 2B 90    JSR ($902B,x)[$94:8ECF];/
$94:905A 4C 49 8F    JMP $8F49  [$94:8F49]  ; Go to Samus block collision reaction - horizontal - solid/shootable/grapple block
}


;;; $905D: Samus block collision reaction - vertical - spike block ;;;
{
;; Parameters:
;;     $12: Distance to check for collision
;;     $20: Target boundary position (top/bottom depending on sign of [$12])
;; Returns:
;;     Carry: Set. Unconditional collision
;;     $12.$14: Distance to collision

$94:905D AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9060 BF 02 64 7F LDA $7F6402,x[$7F:678E];|
$94:9064 0A          ASL A                  ;|
$94:9065 29 FF 01    AND #$01FF             ;} Execute [$902B + [block BTS] * 2]
$94:9068 AA          TAX                    ;|
$94:9069 FC 2B 90    JSR ($902B,x)[$94:8ECF];/
$94:906C 4C 82 8F    JMP $8F82  [$94:8F82]  ; Go to Samus block collision reaction - vertical - solid/shootable/grapple block
}


;;; $906F: Samus block collision reaction - horizontal - special air ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

; Area independent BTS can never cause a collision, but area dependent BTS can (according to the carry returned by their PLM setup)

$94:906F AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9072 BF 01 64 7F LDA $7F6401,x[$7F:673D];|
$94:9076 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h = 0 (area independent):
$94:9079 EB          XBA                    ;|
$94:907A 30 0B       BMI $0B    [$9087]     ;/
$94:907C 0A          ASL A                  ;\
$94:907D AA          TAX                    ;|
$94:907E BD 39 91    LDA $9139,x[$94:91C5]  ;} Spawn PLM [$9139 + [block BTS] * 2]
$94:9081 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9085 18          CLC                    ;\
$94:9086 60          RTS                    ;} Return carry clear

$94:9087 29 7F 00    AND #$007F             ;\
$94:908A 0A          ASL A                  ;|
$94:908B A8          TAY                    ;|
$94:908C AD 9F 07    LDA $079F  [$7E:079F]  ;|
$94:908F 0A          ASL A                  ;|
$94:9090 AA          TAX                    ;} Spawn PLM [[$92D9 + [area index] * 2] + ([block BTS] & 7Fh) * 2]
$94:9091 BD D9 92    LDA $92D9,x[$94:92DB]  ;|
$94:9094 85 22       STA $22    [$7E:0022]  ;|
$94:9096 B1 22       LDA ($22),y[$94:91F9]  ;|
$94:9098 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:909C 60          RTS
}


;;; $909D: Samus block collision reaction - vertical - special air ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

; Clone of $906F
$94:909D AE C4 0D    LDX $0DC4  [$7E:0DC4]
$94:90A0 BF 01 64 7F LDA $7F6401,x[$7F:673D]
$94:90A4 29 00 FF    AND #$FF00
$94:90A7 EB          XBA
$94:90A8 30 0B       BMI $0B    [$90B5]
$94:90AA 0A          ASL A
$94:90AB AA          TAX
$94:90AC BD 39 91    LDA $9139,x[$94:91C5]
$94:90AF 22 E7 84 84 JSL $8484E7[$84:84E7]
$94:90B3 18          CLC
$94:90B4 60          RTS

$94:90B5 29 7F 00    AND #$007F
$94:90B8 0A          ASL A
$94:90B9 A8          TAY
$94:90BA AD 9F 07    LDA $079F  [$7E:079F]
$94:90BD 0A          ASL A
$94:90BE AA          TAX
$94:90BF BD D9 92    LDA $92D9,x[$94:92DB]
$94:90C2 85 22       STA $22    [$7E:0022]
$94:90C4 B1 22       LDA ($22),y[$94:91F9]
$94:90C6 22 E7 84 84 JSL $8484E7[$84:84E7]
$94:90CA 60          RTS
}


;;; $90CB: Samus block collision reaction - horizontal - special block ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;;     $20: Target boundary position (left/right depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:90CB AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:90CE BF 01 64 7F LDA $7F6401,x[$7F:6475];|
$94:90D2 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h != 0: go to BRANCH_AREA_DEPENDANT
$94:90D5 EB          XBA                    ;|
$94:90D6 30 0F       BMI $0F    [$90E7]     ;/
$94:90D8 0A          ASL A                  ;\
$94:90D9 AA          TAX                    ;|
$94:90DA BD 39 91    LDA $9139,x[$94:91C3]  ;} Spawn PLM [$9139 + [block BTS] * 2]
$94:90DD 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:90E1 90 03       BCC $03    [$90E6]     ; If carry clear: return carry clear
$94:90E3 4C 49 8F    JMP $8F49  [$94:8F49]  ; Go to Samus block collision reaction - horizontal - solid/shootable/grapple block

$94:90E6 60          RTS

; BRANCH_AREA_DEPENDANT
$94:90E7 29 7F 00    AND #$007F             ;\
$94:90EA 0A          ASL A                  ;|
$94:90EB A8          TAY                    ;|
$94:90EC AD 9F 07    LDA $079F  [$7E:079F]  ;|
$94:90EF 0A          ASL A                  ;|
$94:90F0 AA          TAX                    ;} Spawn PLM [[$92E9 + [area index] * 2] + ([block BTS] & 7Fh) * 2]
$94:90F1 BD E9 92    LDA $92E9,x[$94:92EB]  ;|
$94:90F4 85 22       STA $22    [$7E:0022]  ;|
$94:90F6 B1 22       LDA ($22),y[$94:9201]  ;|
$94:90F8 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:90FC 90 03       BCC $03    [$9101]     ; If carry clear: return carry clear
$94:90FE 4C 49 8F    JMP $8F49  [$94:8F49]  ; Go to Samus block collision reaction - horizontal - solid/shootable/grapple block

$94:9101 60          RTS
}


;;; $9102: Samus block collision reaction - vertical - special block ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;;     $20: Target boundary position (left/right depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:9102 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9105 BF 01 64 7F LDA $7F6401,x[$7F:78C6];|
$94:9109 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h != 0: go to BRANCH_AREA_DEPENDANT
$94:910C EB          XBA                    ;|
$94:910D 30 0F       BMI $0F    [$911E]     ;/
$94:910F 0A          ASL A                  ;\
$94:9110 AA          TAX                    ;|
$94:9111 BD 39 91    LDA $9139,x[$94:91C3]  ;} Spawn PLM [$9139 + [block BTS] * 2]
$94:9114 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9118 90 03       BCC $03    [$911D]     ; If carry clear: return carry clear
$94:911A 4C 82 8F    JMP $8F82  [$94:8F82]  ; Go to Samus block collision reaction - vertical - solid/shootable/grapple block

$94:911D 60          RTS

; BRANCH_AREA_DEPENDANT
$94:911E 29 7F 00    AND #$007F             ;\
$94:9121 0A          ASL A                  ;|
$94:9122 A8          TAY                    ;|
$94:9123 AD 9F 07    LDA $079F  [$7E:079F]  ;|
$94:9126 0A          ASL A                  ;|
$94:9127 AA          TAX                    ;} Spawn PLM [[$92E9 + [area index] * 2] + ([block BTS] & 7Fh) * 2]
$94:9128 BD E9 92    LDA $92E9,x[$94:92EB]  ;|
$94:912B 85 22       STA $22    [$7E:0022]  ;|
$94:912D B1 22       LDA ($22),y[$94:9201]  ;|
$94:912F 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9133 90 03       BCC $03    [$9138]     ; If carry clear: return carry clear
$94:9135 4C 82 8F    JMP $8F82  [$94:8F82]  ; Go to Samus block collision reaction - vertical - solid/shootable/grapple block

$94:9138 60          RTS
}


;;; $9139: Samus block collision reaction - special - PLM table ;;;
{
; Area independent
$94:9139             dw D044, D048, D04C, D050, D054, D058, D05C, D060, B62F, B62F, B62F, B62F, B62F, B62F, D038, D040,
                        B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F,
                        B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F,
                        B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F,
                        B62F, B62F, B62F, B62F, C83E, EED3, B6FF, B6D7, B6DB, B6E3, B6E7, B6EF, B6F3, B76B, B62F, B62F

; Area dependant
$94:91D9             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; Crateria
$94:91F9             dw B633, B633, D030, D034, D03C, D040, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; Brinstar
$94:9219             dw B62F, B62F, B62F, D6DA, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; Norfair
$94:9239             dw D6F2, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; Wrecked Ship
$94:9259             dw B72B, B72B, B72B, B737, B73B, B73F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; Maridia
$94:9279             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; Tourian
$94:9299             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; Ceres
$94:92B9             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; Debug

; Special air pointers to the above
$94:92D9             dw 91D9, 91F9, 9219, 9239, 9259, 9279, 9299, 92B9

; Special block pointers to the above
$94:92E9             dw 91D9, 91F9, 9219, 9239, 9259, 9279, 9299, 92B9
}


;;; $92F9: Samus block collision reaction - horizontal - bombable air ;;;
{
;; Returns:
;;     Carry: Clear. No collision
$94:92F9 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:92FC BF 01 64 7F LDA $7F6401,x          ;|
$94:9300 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h = 0:
$94:9303 EB          XBA                    ;|
$94:9304 30 0B       BMI $0B    [$9311]     ;/
$94:9306 0A          ASL A                  ;\
$94:9307 AA          TAX                    ;|
$94:9308 BD 6B 93    LDA $936B,x            ;} Spawn PLM [$936B + [block BTS] * 2]
$94:930B 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:930F 18          CLC
$94:9310 60          RTS

$94:9311 18          CLC                    ;\
$94:9312 60          RTS                    ;} Return carry clear
}


;;; $9313: Samus block collision reaction - vertical - bombable air ;;;
{
;; Returns:
;;     Carry: Clear. No collision

; Clone of $92F9
$94:9313 AE C4 0D    LDX $0DC4  [$7E:0DC4]
$94:9316 BF 01 64 7F LDA $7F6401,x
$94:931A 29 00 FF    AND #$FF00
$94:931D EB          XBA
$94:931E 30 0B       BMI $0B    [$932B]
$94:9320 0A          ASL A
$94:9321 AA          TAX
$94:9322 BD 6B 93    LDA $936B,x
$94:9325 22 E7 84 84 JSL $8484E7[$84:84E7]
$94:9329 18          CLC
$94:932A 60          RTS

$94:932B 18          CLC
$94:932C 60          RTS
}


;;; $932D: Samus block collision reaction - horizontal - bomb block ;;;
{
;; Parameters:
;;     $12: Distance to check for collision
;;     $20: Target boundary position (left/right depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: If carry set, distance to collision

$94:932D AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9330 BF 01 64 7F LDA $7F6401,x[$7F:66E0];|
$94:9334 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h = 0:
$94:9337 EB          XBA                    ;|
$94:9338 30 0E       BMI $0E    [$9348]     ;/
$94:933A 0A          ASL A                  ;\
$94:933B AA          TAX                    ;|
$94:933C BD 6B 93    LDA $936B,x[$94:936D]  ;} Spawn PLM [$936B + [block BTS] * 2]
$94:933F 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9343 90 06       BCC $06    [$934B]     ; If carry clear: return carry clear
$94:9345 4C 49 8F    JMP $8F49  [$94:8F49]

$94:9348 4C 49 8F    JMP $8F49  [$94:8F49]  ; Go to Samus block collision reaction - horizontal - solid/shootable/grapple block

$94:934B 60          RTS
}


;;; $934C: Samus block collision reaction - vertical - bomb block ;;;
{
;; Parameters:
;;     $12: Distance to check for collision
;;     $20: Target boundary position (top/bottom depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: If carry set, distance to collision

$94:934C AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:934F BF 01 64 7F LDA $7F6401,x[$7F:65E6];|
$94:9353 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h = 0:
$94:9356 EB          XBA                    ;|
$94:9357 30 0E       BMI $0E    [$9367]     ;/
$94:9359 0A          ASL A                  ;\
$94:935A AA          TAX                    ;|
$94:935B BD 6B 93    LDA $936B,x[$94:9377]  ;} Spawn PLM [$936B + [block BTS] * 2]
$94:935E 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9362 90 06       BCC $06    [$936A]     ; If carry clear: return carry clear
$94:9364 4C 82 8F    JMP $8F82  [$94:8F82]

$94:9367 4C 82 8F    JMP $8F82  [$94:8F82]  ; Go to Samus block collision reaction - vertical - solid/shootable/grapple block

$94:936A 60          RTS
}


;;; $936B: Samus block collision reaction - bombable - PLM table ;;;
{
$94:936B             dw D098, D09C, D0A0, D0A4, D0A8, D0AC, D0B0, D0B4, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F
}


;;; $938B: Samus block collision reaction - horizontal - door ;;;
{
;; Parameters:
;;     $12: Distance to check for collision
;;     $20: Target boundary position (left/right depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: If carry set, distance to collision

$94:938B A9 7D E1    LDA #$E17D             ;\
$94:938E 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E17D (handle elevator)
$94:9391 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9394 BF 01 64 7F LDA $7F6401,x[$7F:6680];|
$94:9398 29 00 FF    AND #$FF00             ;} Door BTS = [block BTS]
$94:939B EB          XBA                    ;|
$94:939C 8D 8F 07    STA $078F  [$7E:078F]  ;/
$94:939F 29 7F 00    AND #$007F             ;\
$94:93A2 0A          ASL A                  ;|
$94:93A3 6D B5 07    ADC $07B5  [$7E:07B5]  ;|
$94:93A6 AA          TAX                    ;} X = [$8F:0000 + [door list pointer] + ([door BTS] & 7Fh) * 2]
$94:93A7 BF 00 00 8F LDA $8F0000,x[$8F:DF8B];|
$94:93AB AA          TAX                    ;/
$94:93AC BF 00 00 83 LDA $830000,x[$83:AB4C];\
$94:93B0 10 0B       BPL $0B    [$93BD]     ;} If [$83:0000 + [X]] (destination room header pointer) >= $8000:
$94:93B2 8E 8D 07    STX $078D  [$7E:078D]  ; Door pointer = [X]
$94:93B5 A9 09 00    LDA #$0009             ;\
$94:93B8 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 9 (hit a door block)
$94:93BB 18          CLC                    ;\
$94:93BC 60          RTS                    ;} Return carry clear

$94:93BD AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$94:93C0 C9 09 00    CMP #$0009             ;} If [Samus pose] = standing still:
$94:93C3 B0 06       BCS $06    [$93CB]     ;/
$94:93C5 A9 01 00    LDA #$0001             ;\
$94:93C8 8D 16 0E    STA $0E16  [$7E:0E16]  ;} Elevator properties = standing on elevator

$94:93CB 4C 49 8F    JMP $8F49  [$94:8F49]  ; Go to Samus block collision reaction - horizontal - solid/shootable/grapple block
}


;;; $93CE: Samus block collision reaction - vertical - door ;;;
{
;; Parameters:
;;     $12: Distance to check for collision
;;     $20: Target boundary position (top/bottom depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: If carry set, distance to collision

$94:93CE A9 7D E1    LDA #$E17D             ;\
$94:93D1 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E17D (handle elevator)
$94:93D4 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:93D7 BF 01 64 7F LDA $7F6401,x[$7F:7CCA];|
$94:93DB 29 00 FF    AND #$FF00             ;} Door BTS = [block BTS]
$94:93DE EB          XBA                    ;|
$94:93DF 8D 8F 07    STA $078F  [$7E:078F]  ;/
$94:93E2 29 7F 00    AND #$007F             ;\
$94:93E5 0A          ASL A                  ;|
$94:93E6 6D B5 07    ADC $07B5  [$7E:07B5]  ;|
$94:93E9 AA          TAX                    ;} X = [$8F:0000 + [door list pointer] + ([door BTS] & 7Fh) * 2]
$94:93EA BF 00 00 8F LDA $8F0000,x[$8F:936A];|
$94:93EE AA          TAX                    ;/
$94:93EF BF 00 00 83 LDA $830000,x[$83:898E];\
$94:93F3 10 0B       BPL $0B    [$9400]     ;} If [$83:0000 + [X]] (destination room header pointer) >= $8000:
$94:93F5 8E 8D 07    STX $078D  [$7E:078D]  ; Door pointer = [X]
$94:93F8 A9 09 00    LDA #$0009             ;\
$94:93FB 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 9 (hit a door block)
$94:93FE 18          CLC                    ;\
$94:93FF 60          RTS                    ;} Return carry clear

$94:9400 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$94:9403 C9 09 00    CMP #$0009             ;} If [Samus pose] = standing still:
$94:9406 B0 06       BCS $06    [$940E]     ;/
$94:9408 A9 01 00    LDA #$0001             ;\
$94:940B 8D 16 0E    STA $0E16  [$7E:0E16]  ;} Elevator properties = standing on elevator


$94:940E 4C 82 8F    JMP $8F82  [$94:8F82]  ; Go to Samus block collision reaction - vertical - solid/shootable/grapple block
}


;;; $9411: Block shot/bombed/grappled/collision/inside reaction - horizontal extension ;;;
{
;; Returns:
;;     Carry: Clear. No collision

; If BTS is 0, acts like air
; Otherwise, offsets block index by block BTS, updates X, and loops back to the `JSR (xxxx, X)` instruction that jumped to here

$94:9411 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9414 BF 02 64 7F LDA $7F6402,x[$7F:6789];|
$94:9418 29 FF 00    AND #$00FF             ;} If [block BTS] = 0: return carry clear
$94:941B F0 28       BEQ $28    [$9445]     ;/
$94:941D 89 80 00    BIT #$0080             ;\
$94:9420 D0 05       BNE $05    [$9427]     ;|
$94:9422 29 FF 00    AND #$00FF             ;|
$94:9425 80 03       BRA $03    [$942A]     ;|
                                            ;|
$94:9427 09 00 FF    ORA #$FF00             ;} Current block index += ±[block BTS]
                                            ;|
$94:942A 18          CLC                    ;|
$94:942B 6D C4 0D    ADC $0DC4  [$7E:0DC4]  ;|
$94:942E 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:9431 0A          ASL A                  ;\
$94:9432 AA          TAX                    ;|
$94:9433 BF 02 00 7F LDA $7F0002,x[$7F:070E];|
$94:9437 29 00 F0    AND #$F000             ;|
$94:943A EB          XBA                    ;} X = (block type) * 2
$94:943B 4A          LSR A                  ;|
$94:943C 4A          LSR A                  ;|
$94:943D 4A          LSR A                  ;|
$94:943E AA          TAX                    ;/
$94:943F 68          PLA                    ;\
$94:9440 38          SEC                    ;|
$94:9441 E9 03 00    SBC #$0003             ;} (Return address) -= 3
$94:9444 48          PHA                    ;/

$94:9445 18          CLC
$94:9446 60          RTS
}


;;; $9447: Block shot/bombed/grappled/collision/inside reaction - vertical extension ;;;
{
;; Returns:
;;     Carry: Clear. No collision

; If BTS is 0, acts like air
; Otherwise, offsets block index by block BTS, updates X, and loops back to the `JSR (xxxx, X)` instruction that jumped to here
; Uses an addition/subtraction loop for multiplication, which is probably faster for an offset of 1 or maybe 2

$94:9447 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:944A BF 02 64 7F LDA $7F6402,x[$7F:8BF3];|
$94:944E 29 FF 00    AND #$00FF             ;} If [block BTS] = 0: return carry clear
$94:9451 F0 40       BEQ $40    [$9493]     ;/
$94:9453 89 80 00    BIT #$0080             ;\
$94:9456 D0 12       BNE $12    [$946A]     ;|
$94:9458 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;|
$94:945B AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;|
                                            ;|
$94:945E 18          CLC                    ;|
$94:945F 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$94:9462 CE D4 0D    DEC $0DD4  [$7E:0DD4]  ;|
$94:9465 D0 F7       BNE $F7    [$945E]     ;|
$94:9467 4C 7C 94    JMP $947C  [$94:947C]  ;|
                                            ;} Current block index += ±[block BTS] * [room width in blocks]
$94:946A 09 00 FF    ORA #$FF00             ;|
$94:946D 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;|
$94:9470 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;|
                                            ;|
$94:9473 38          SEC                    ;|
$94:9474 ED A5 07    SBC $07A5  [$7E:07A5]  ;|
$94:9477 EE D4 0D    INC $0DD4  [$7E:0DD4]  ;|
$94:947A D0 F7       BNE $F7    [$9473]     ;|
                                            ;|
$94:947C 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:947F 0A          ASL A                  ;\
$94:9480 AA          TAX                    ;|
$94:9481 BF 02 00 7F LDA $7F0002,x[$7F:4EC4];|
$94:9485 29 00 F0    AND #$F000             ;|
$94:9488 EB          XBA                    ;} X = (block type) * 2
$94:9489 4A          LSR A                  ;|
$94:948A 4A          LSR A                  ;|
$94:948B 4A          LSR A                  ;|
$94:948C AA          TAX                    ;/
$94:948D 68          PLA                    ;\
$94:948E 38          SEC                    ;|
$94:948F E9 03 00    SBC #$0003             ;} (Return address) -= 3
$94:9492 48          PHA                    ;/

$94:9493 18          CLC
$94:9494 60          RTS
}


;;; $9495: Calculate Samus Y block span ;;;
{
; A = $1A = $1C = ([Samus Y position] + [Samus Y radius] - 1) / 10h
;               - ([Samus Y position] - [Samus Y radius]) / 10h
$94:9495 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$94:9498 38          SEC
$94:9499 ED 00 0B    SBC $0B00  [$7E:0B00]
$94:949C 29 F0 FF    AND #$FFF0
$94:949F 85 1A       STA $1A    [$7E:001A]
$94:94A1 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$94:94A4 18          CLC
$94:94A5 6D 00 0B    ADC $0B00  [$7E:0B00]
$94:94A8 3A          DEC A
$94:94A9 38          SEC
$94:94AA E5 1A       SBC $1A    [$7E:001A]
$94:94AC 4A          LSR A
$94:94AD 4A          LSR A
$94:94AE 4A          LSR A
$94:94AF 4A          LSR A
$94:94B0 85 1A       STA $1A    [$7E:001A]
$94:94B2 85 1C       STA $1C    [$7E:001C]
$94:94B4 60          RTS
}


;;; $94B5: Calculate Samus X block span ;;;
{
; A = $1A = $1C = ([Samus X position] + [Samus X radius] - 1) / 10h
;               - ([Samus X position] - [Samus X radius]) / 10h
$94:94B5 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$94:94B8 38          SEC
$94:94B9 ED FE 0A    SBC $0AFE  [$7E:0AFE]
$94:94BC 29 F0 FF    AND #$FFF0
$94:94BF 85 1A       STA $1A    [$7E:001A]
$94:94C1 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$94:94C4 18          CLC
$94:94C5 6D FE 0A    ADC $0AFE  [$7E:0AFE]
$94:94C8 3A          DEC A
$94:94C9 38          SEC
$94:94CA E5 1A       SBC $1A    [$7E:001A]
$94:94CC 4A          LSR A
$94:94CD 4A          LSR A
$94:94CE 4A          LSR A
$94:94CF 4A          LSR A
$94:94D0 85 1A       STA $1A    [$7E:001A]
$94:94D2 85 1C       STA $1C    [$7E:001C]
$94:94D4 60          RTS
}


;;; $94D5: Samus block collision reaction pointers - horizontal ;;;
{
$94:94D5             dw 8F47, ; *0: Air
                        8FBB, ;  1: Slope
                        9018, ; *2: Spike air
                        906F, ;  3: Special air
                        8F47, ; *4: Shootable air
                        9411, ;  5: Horizontal extension
                        8F47, ; *6: Unused air
                        92F9, ;  7: Bombable air
                        8F49, ;  8: Solid block
                        938B, ;  9: Door block
                        904B, ;  Ah: Spike block
                        90CB, ;  Bh: Special block
                        8F49, ;  Ch: Shootable block
                        9447, ;  Dh: Vertical extension
                        8F49, ;  Eh: Grapple block
                        932D  ;  Fh: Bombable block
}


;;; $94F5: Samus block collision reaction pointers - vertical ;;;
{
$94:94F5             dw 8F47, ; 0: Air
                        8FDA, ; 1: Slope
                        901A, ; 2: Spike air
                        909D, ; 3: Special air
                        8F47, ; 4: Shootable air
                        9411, ; 5: Horizontal extension
                        8F47, ; 6: Unused air
                        9313, ; 7: Bombable air
                        8F82, ; 8: Solid block
                        93CE, ; 9: Door block
                        905D, ; Ah: Spike block
                        9102, ; Bh: Special block
                        8F82, ; Ch: Shootable block
                        9447, ; Dh: Vertical extension
                        8F82, ; Eh: Grapple block
                        934C  ; Fh: Bombable block
}


;;; $9515: Samus block collision reaction - horizontal ;;;
{
;; Parameters:
;;     X: Block index (multiple of 2)
;;     $12.$14: Distance to check for collision
;;     $1A: Number of blocks left to check (0 if final (bottom) block)
;;     $1C: Samus' Y block span
;;     $20: Target boundary position (left/right depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:9515 DA          PHX
$94:9516 8A          TXA                    ;\
$94:9517 4A          LSR A                  ;} Current block index = [X] / 2
$94:9518 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:951B BF 02 00 7F LDA $7F0002,x[$7F:00B6];\
$94:951F 29 00 F0    AND #$F000             ;|
$94:9522 EB          XBA                    ;|
$94:9523 4A          LSR A                  ;|
$94:9524 4A          LSR A                  ;} Execute [$94D5 + (block type) * 2]
$94:9525 4A          LSR A                  ;|
$94:9526 AA          TAX                    ;|
$94:9527 FC D5 94    JSR ($94D5,x)[$94:8F47];/
$94:952A FA          PLX
$94:952B 60          RTS
}


;;; $952C: Samus block collision reaction - vertical ;;;
{
;; Parameters:
;;     X: Block index (multiple of 2)
;;     $12.$14: Distance to check for collision
;;     $18: Target Y position
;;     $20: Target boundary position (top/bottom depending on sign of [$12])
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:952C DA          PHX
$94:952D 8A          TXA                    ;\
$94:952E 4A          LSR A                  ;} Current block index = [X] / 2
$94:952F 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:9532 BF 02 00 7F LDA $7F0002,x[$7F:0114];\
$94:9536 29 00 F0    AND #$F000             ;|
$94:9539 EB          XBA                    ;|
$94:953A 4A          LSR A                  ;|
$94:953B 4A          LSR A                  ;} Execute [$94F5 + (block type) * 2]
$94:953C 4A          LSR A                  ;|
$94:953D AA          TAX                    ;|
$94:953E FC F5 94    JSR ($94F5,x)[$94:8FDA];/
$94:9541 FA          PLX
$94:9542 60          RTS
}


;;; $9543: Samus block collision detection - horizontal ;;;
{
;; Parameters:
;;     $12.$14: Distance to move Samus
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:9543 20 95 94    JSR $9495  [$94:9495]  ; $1A = $1C = Samus Y block span
$94:9546 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:9549 38          SEC                    ;|
$94:954A ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$94:954D 4A          LSR A                  ;|
$94:954E 4A          LSR A                  ;|
$94:954F 4A          LSR A                  ;} Calculate block index of the row of Samus top boundary
$94:9550 4A          LSR A                  ;|
$94:9551 E2 20       SEP #$20               ;|
$94:9553 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:9556 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:9559 8D 03 42    STA $4203  [$7E:4203]  ;/
$94:955C C2 20       REP #$20
$94:955E AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$94:9561 18          CLC                    ;|
$94:9562 65 14       ADC $14    [$7E:0014]  ;|
$94:9564 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [Samus X position] + [$12].[$14]
$94:9566 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$94:9569 65 12       ADC $12    [$7E:0012]  ;|
$94:956B 85 18       STA $18    [$7E:0018]  ;/
$94:956D 24 12       BIT $12    [$7E:0012]  ;\
$94:956F 10 06       BPL $06    [$9577]     ;} If [$12] < 0: (moving left)
$94:9571 38          SEC                    ;\
$94:9572 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;} $20 = [$18] - [Samus X radius] (target left boundary position)
$94:9575 80 05       BRA $05    [$957C]

$94:9577 18          CLC                    ;\ Else ([$12] >= 0):
$94:9578 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;} $20 = [$18] + [Samus X radius] - 1 (target right boundary position)
$94:957B 3A          DEC A                  ;/

$94:957C 85 20       STA $20    [$7E:0020]
$94:957E 4A          LSR A                  ;\
$94:957F 4A          LSR A                  ;|
$94:9580 4A          LSR A                  ;|
$94:9581 4A          LSR A                  ;|
$94:9582 18          CLC                    ;} X = [$20] / 10h + (block index of the row of Samus top boundary)
$94:9583 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:9586 0A          ASL A                  ;|
$94:9587 AA          TAX                    ;/

; LOOP
$94:9588 20 15 95    JSR $9515  [$94:9515]  ; Samus block collision reaction - horizontal
$94:958B B0 0F       BCS $0F    [$959C]     ; If collision: return carry set
$94:958D 8A          TXA                    ;\
$94:958E 18          CLC                    ;|
$94:958F 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$94:9592 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$94:9595 AA          TAX                    ;/
$94:9596 C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$94:9598 10 EE       BPL $EE    [$9588]     ; If [$1A] >= 0: go to LOOP
$94:959A 18          CLC                    ;\
$94:959B 60          RTS                    ;} Return carry clear

$94:959C 38          SEC
$94:959D 60          RTS
}


;;; $959E: Samus block collision detection - vertical - left to right ;;;
{
;; Parameters:
;;     $12.$14: Distance to move Samus
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:959E 20 B5 94    JSR $94B5  [$94:94B5]  ; $1A = $1C = Samus X block span
$94:95A1 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$94:95A4 18          CLC                    ;|
$94:95A5 65 14       ADC $14    [$7E:0014]  ;|
$94:95A7 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [Samus Y position] + [$12].[$14] (target Y position)
$94:95A9 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$94:95AC 65 12       ADC $12    [$7E:0012]  ;|
$94:95AE 85 18       STA $18    [$7E:0018]  ;/
$94:95B0 24 12       BIT $12    [$7E:0012]  ;\
$94:95B2 10 06       BPL $06    [$95BA]     ;} If [$12] < 0: (moving up)
$94:95B4 38          SEC                    ;\
$94:95B5 ED 00 0B    SBC $0B00  [$7E:0B00]  ;} $20 = [$18] - [Samus Y radius] (target top boundary position)
$94:95B8 80 05       BRA $05    [$95BF]

$94:95BA 18          CLC                    ;\ Else ([$12] >= 0):
$94:95BB 6D 00 0B    ADC $0B00  [$7E:0B00]  ;} $20 = [$18] + [Samus Y radius] - 1 (target bottom boundary position)
$94:95BE 3A          DEC A                  ;/

$94:95BF 85 20       STA $20    [$7E:0020]
$94:95C1 4A          LSR A                  ;\
$94:95C2 4A          LSR A                  ;|
$94:95C3 4A          LSR A                  ;|
$94:95C4 4A          LSR A                  ;|
$94:95C5 E2 20       SEP #$20               ;|
$94:95C7 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:95CA AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:95CD 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:95D0 C2 20       REP #$20               ;|
$94:95D2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} Current block index = [$20] / 10h * [room width] + (Samus left boundary position) / 10h
$94:95D5 38          SEC                    ;|
$94:95D6 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$94:95D9 4A          LSR A                  ;|
$94:95DA 4A          LSR A                  ;|
$94:95DB 4A          LSR A                  ;|
$94:95DC 4A          LSR A                  ;|
$94:95DD 18          CLC                    ;|
$94:95DE 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:95E1 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:95E4 0A          ASL A                  ;\
$94:95E5 AA          TAX                    ;} X = [current block index] * 2

; LOOP
$94:95E6 20 2C 95    JSR $952C  [$94:952C]  ; Samus block collision reaction - vertical
$94:95E9 B0 08       BCS $08    [$95F3]     ; If collision: return carry set
$94:95EB E8          INX                    ;\
$94:95EC E8          INX                    ;} X += 2
$94:95ED C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$94:95EF 10 F5       BPL $F5    [$95E6]     ; If [$1A] >= 0: go to LOOP
$94:95F1 18          CLC                    ;\
$94:95F2 60          RTS                    ;} Return carry clear

$94:95F3 38          SEC
$94:95F4 60          RTS
}


;;; $95F5: Samus block collision detection - vertical - right to left ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

$94:95F5 20 B5 94    JSR $94B5  [$94:94B5]  ; $1C = Samus X block span
$94:95F8 64 1A       STZ $1A    [$7E:001A]  ; $1A = 0
$94:95FA AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$94:95FD 18          CLC                    ;|
$94:95FE 65 14       ADC $14    [$7E:0014]  ;|
$94:9600 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [Samus Y position] + [$12].[$14] (target Y position)
$94:9602 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$94:9605 65 12       ADC $12    [$7E:0012]  ;|
$94:9607 85 18       STA $18    [$7E:0018]  ;/
$94:9609 24 12       BIT $12    [$7E:0012]  ;\
$94:960B 10 06       BPL $06    [$9613]     ;} If [$12] < 0: (moving up)
$94:960D 38          SEC                    ;\
$94:960E ED 00 0B    SBC $0B00  [$7E:0B00]  ;} $20 = [$18] - [Samus Y radius] (target top boundary position)
$94:9611 80 05       BRA $05    [$9618]

$94:9613 18          CLC                    ;\ Else ([$12] >= 0):
$94:9614 6D 00 0B    ADC $0B00  [$7E:0B00]  ;} $20 = [$18] + [Samus Y radius] - 1 (target bottom boundary position)
$94:9617 3A          DEC A                  ;/

$94:9618 85 20       STA $20    [$7E:0020]  ;\
$94:961A 4A          LSR A                  ;|
$94:961B 4A          LSR A                  ;|
$94:961C 4A          LSR A                  ;|
$94:961D 4A          LSR A                  ;|
$94:961E E2 20       SEP #$20               ;|
$94:9620 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:9623 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:9626 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:9629 C2 20       REP #$20               ;|
$94:962B AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} Current block index = [$20] / 10h * [room width] + (Samus right boundary position) / 10h
$94:962E 18          CLC                    ;|
$94:962F 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;|
$94:9632 3A          DEC A                  ;|
$94:9633 4A          LSR A                  ;|
$94:9634 4A          LSR A                  ;|
$94:9635 4A          LSR A                  ;|
$94:9636 4A          LSR A                  ;|
$94:9637 18          CLC                    ;|
$94:9638 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:963B 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:963E 0A          ASL A                  ;\
$94:963F AA          TAX                    ;} X = [current block index] * 2

; LOOP
$94:9640 20 2C 95    JSR $952C  [$94:952C]  ; Samus block collision reaction - vertical
$94:9643 B0 0C       BCS $0C    [$9651]     ; If collision: return carry set
$94:9645 CA          DEX                    ;\
$94:9646 CA          DEX                    ;} X += 2
$94:9647 E6 1A       INC $1A    [$7E:001A]  ; Increment $1A
$94:9649 A5 1C       LDA $1C    [$7E:001C]  ;\
$94:964B C5 1A       CMP $1A    [$7E:001A]  ;} If [$1A] <= [$1C]: go to LOOP
$94:964D B0 F1       BCS $F1    [$9640]     ;/
$94:964F 18          CLC                    ;\
$94:9650 60          RTS                    ;} Return carry clear

$94:9651 38          SEC
$94:9652 60          RTS
}


;;; $9653: $12.$14 = |[$12].[$14]| ;;;
{
$94:9653 A5 12       LDA $12    [$7E:0012]
$94:9655 10 11       BPL $11    [$9668]
$94:9657 49 FF FF    EOR #$FFFF
$94:965A 85 12       STA $12    [$7E:0012]
$94:965C A5 14       LDA $14    [$7E:0014]
$94:965E 49 FF FF    EOR #$FFFF
$94:9661 1A          INC A
$94:9662 85 14       STA $14    [$7E:0014]
$94:9664 D0 02       BNE $02    [$9668]
$94:9666 E6 12       INC $12    [$7E:0012]

$94:9668 60          RTS
}


;;; $9669: $12.$14 = |[$12].[$14]| ;;;
{
; So good they coded it twice
$94:9669 A5 12       LDA $12    [$7E:0012]
$94:966B 10 11       BPL $11    [$967E]
$94:966D 49 FF FF    EOR #$FFFF
$94:9670 85 12       STA $12    [$7E:0012]
$94:9672 A5 14       LDA $14    [$7E:0014]
$94:9674 49 FF FF    EOR #$FFFF
$94:9677 1A          INC A
$94:9678 85 14       STA $14    [$7E:0014]
$94:967A D0 02       BNE $02    [$967E]
$94:967C E6 12       INC $12    [$7E:0012]

$94:967E 60          RTS
}


;;; $967F: Wall jump block collision detection ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12: If carry set: collision distance

; Wrapper function of $9543 for wall-jump check ($90:9D35/9CAC) that ignores special air/block collisions
; The result stored to $0DD0 is unused

; By setting $0B02 to Fh, all of the collision direction checks in special air/block collision PLM setup routines
; (map/energy/missile station left/right access, quicksand surface, save station / chozo hand trigger, crumble block)
; result in no effect (no other subroutine of $9543 checks collision direction)

$94:967F 08          PHP
$94:9680 8B          PHB
$94:9681 4B          PHK                    ;\
$94:9682 AB          PLB                    ;} DB = $94
$94:9683 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$94:9686 09 0F 00    ORA #$000F             ;} Collision direction = Fh
$94:9689 8D 02 0B    STA $0B02  [$7E:0B02]  ;/
$94:968C 9C 71 1E    STZ $1E71  [$7E:1E71]  ; Samus is in quicksand flag = 0
$94:968F 20 43 95    JSR $9543  [$94:9543]  ; Samus block collision handling - horizontal
$94:9692 90 0D       BCC $0D    [$96A1]     ; If collision:
$94:9694 20 53 96    JSR $9653  [$94:9653]  ; $12.$14 = |[$12].[$14]|
$94:9697 AB          PLB
$94:9698 28          PLP
$94:9699 38          SEC                    ; Set carry
$94:969A A9 01 00    LDA #$0001             ;\
$94:969D 8D D0 0D    STA $0DD0  [$7E:0DD0]  ;} Samus solid collision flag = block collision
$94:96A0 6B          RTL                    ; Return

$94:96A1 20 53 96    JSR $9653  [$94:9653]  ; $12.$14 = |[$12].[$14]|
$94:96A4 AB          PLB
$94:96A5 28          PLP
$94:96A6 18          CLC                    ; Clear carry
$94:96A7 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$94:96AA 6B          RTL
}


;;; $96AB: Block collision detection due to change of pose ;;;
{
;; Parameters:
;;     $12: Distance to check for collision (assume less than 10h)
;;     $14: 0. Subdistance to check for collision
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12: Adjusted distance to move Samus or distance to collision

; Check for collision with the one or two blocks (depending on the distance to check) below Samus, ignoring special air/block collisions

$94:96AB A5 12       LDA $12    [$7E:0012]  ;\
$94:96AD 10 04       BPL $04    [$96B3]     ;|
$94:96AF 49 FF FF    EOR #$FFFF             ;|
$94:96B2 1A          INC A                  ;} If |[$12]| < 8:
                                            ;|
$94:96B3 29 F8 FF    AND #$FFF8             ;|
$94:96B6 D0 05       BNE $05    [$96BD]     ;/
$94:96B8 22 E3 96 94 JSL $9496E3[$94:96E3]  ; Collision detection due to change of pose - single block
$94:96BC 6B          RTL                    ; Return

$94:96BD A5 12       LDA $12    [$7E:0012]  ;\
$94:96BF 48          PHA                    ;|
$94:96C0 A5 14       LDA $14    [$7E:0014]  ;} Save $12.$14
$94:96C2 48          PHA                    ;/
$94:96C3 A5 12       LDA $12    [$7E:0012]  ;\
$94:96C5 29 F8 FF    AND #$FFF8             ;|
$94:96C8 09 08 00    ORA #$0008             ;} $12.$14 = 8.0
$94:96CB 85 12       STA $12    [$7E:0012]  ;|
$94:96CD 64 14       STZ $14    [$7E:0014]  ;/
$94:96CF 22 E3 96 94 JSL $9496E3[$94:96E3]  ; Collision detection due to change of pose - single block
$94:96D3 90 03       BCC $03    [$96D8]     ; If collision:
$94:96D5 68          PLA                    ;\
$94:96D6 68          PLA                    ;} Return carry set
$94:96D7 6B          RTL                    ;/

$94:96D8 68          PLA                    ;\
$94:96D9 85 14       STA $14    [$7E:0014]  ;|
$94:96DB 68          PLA                    ;} Restore $12.$14
$94:96DC 85 12       STA $12    [$7E:0012]  ;/
$94:96DE 22 E3 96 94 JSL $9496E3[$94:96E3]  ; Collision detection due to change of pose - single block
$94:96E2 6B          RTL
}


;;; $96E3: Block collision detection due to change of pose - single block ;;;
{
;; Parameters:
;;     $12: Distance to check for collision (assume less than 8)
;;     $14: 0. Subdistance to check for collision
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12: Adjusted distance to move Samus or distance to collision

; The result stored to $0DD0 is unused

; By setting $0B02 to Fh, all of the collision direction checks in special air/block collision PLM setup routines *except for quicksand surface*
; (map/energy/missile station left/right access, save station / chozo hand trigger, crumble block)
; result in no effect (no other subroutine of $959E/95F5 checks collision direction)
; Quicksand surface collision is partially disabled, but can still set the Samus is in quicksand flag
; Not really sure if it makes sense to disable these interactions...

$94:96E3 08          PHP
$94:96E4 8B          PHB
$94:96E5 C2 30       REP #$30
$94:96E7 4B          PHK                    ;\
$94:96E8 AB          PLB                    ;} DB = $94
$94:96E9 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$94:96EC 09 0F 00    ORA #$000F             ;} Collision direction = Fh
$94:96EF 8D 02 0B    STA $0B02  [$7E:0B02]  ;/
$94:96F2 9C 71 1E    STZ $1E71  [$7E:1E71]  ; Clear Samus is in quicksand flag
$94:96F5 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$94:96F8 4A          LSR A                  ;} If [frame counter] % 2 = 0:
$94:96F9 B0 07       BCS $07    [$9702]     ;/
$94:96FB 20 9E 95    JSR $959E  [$94:959E]  ; Samus block collision handling - vertical - left to right
$94:96FE 90 14       BCC $14    [$9714]     ; If carry clear: go to BRANCH_NO_COLLISION
$94:9700 B0 05       BCS $05    [$9707]
                                            ; Else ([frame counter] % 2 != 0):
$94:9702 20 F5 95    JSR $95F5  [$94:95F5]  ; Samus block collision handling - vertical - right to left
$94:9705 90 0D       BCC $0D    [$9714]     ; If returned carry clear: go to BRANCH_NO_COLLISION

$94:9707 20 69 96    JSR $9669  [$94:9669]  ; $12.$14 = |[$12].[$14]|
$94:970A AB          PLB
$94:970B 28          PLP
$94:970C 38          SEC                    ; Set carry
$94:970D A9 01 00    LDA #$0001             ;\
$94:9710 8D D0 0D    STA $0DD0  [$7E:0DD0]  ;} Samus solid collision flag = block collision
$94:9713 6B          RTL                    ; Return

; BRANCH_NO_COLLISION
$94:9714 20 69 96    JSR $9669  [$94:9669]  ; $12.$14 = |[$12].[$14]|
$94:9717 AB          PLB
$94:9718 28          PLP
$94:9719 18          CLC                    ; Clear carry
$94:971A 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$94:971D 6B          RTL
}


;;; $971E: Move Samus right by [$12].[$14], no solid enemy collision ;;;
{
;; Parameters:
;;     $12.$14: Distance to move Samus
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance Samus was moved

$94:971E 08          PHP
$94:971F 8B          PHB
$94:9720 4B          PHK                    ;\
$94:9721 AB          PLB                    ;} DB = $94
$94:9722 A5 14       LDA $14    [$7E:0014]  ;\
$94:9724 05 12       ORA $12    [$7E:0012]  ;} If [$12].[$14] = 0.0: go to BRANCH_NO_COLLISION
$94:9726 F0 23       BEQ $23    [$974B]     ;/
$94:9728 9C 71 1E    STZ $1E71  [$7E:1E71]  ; Samus is in quicksand flag = 0
$94:972B 20 43 95    JSR $9543  [$94:9543]  ; Samus block collision handling - horizontal
$94:972E 90 1B       BCC $1B    [$974B]     ; If no collision: go to BRANCH_NO_COLLISION
$94:9730 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$94:9733 18          CLC                    ;|
$94:9734 65 14       ADC $14    [$7E:0014]  ;|
$94:9736 8D F8 0A    STA $0AF8  [$7E:0AF8]  ;} Samus X position += [$12].[$14]
$94:9739 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$94:973C 65 12       ADC $12    [$7E:0012]  ;|
$94:973E 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$94:9741 AB          PLB
$94:9742 28          PLP
$94:9743 38          SEC                    ; Set carry
$94:9744 A9 01 00    LDA #$0001             ;\
$94:9747 8D D0 0D    STA $0DD0  [$7E:0DD0]  ;} Samus solid collision flag = block collision
$94:974A 6B          RTL                    ; Return

; BRANCH_NO_COLLISION
$94:974B AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$94:974E 18          CLC                    ;|
$94:974F 65 14       ADC $14    [$7E:0014]  ;|
$94:9751 8D F8 0A    STA $0AF8  [$7E:0AF8]  ;} Samus X position += [$12].[$14]
$94:9754 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$94:9757 65 12       ADC $12    [$7E:0012]  ;|
$94:9759 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$94:975C AB          PLB
$94:975D 28          PLP
$94:975E 18          CLC                    ; Clear carry
$94:975F 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$94:9762 6B          RTL
}


;;; $9763: Move Samus down by [$12].[$14], no solid enemy collision ;;;
{
;; Parameters:
;;     $12.$14: Distance to move Samus
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance Samus was moved

$94:9763 08          PHP
$94:9764 8B          PHB
$94:9765 C2 30       REP #$30
$94:9767 4B          PHK                    ;\
$94:9768 AB          PLB                    ;} DB = $94
$94:9769 A5 14       LDA $14    [$7E:0014]  ;\
$94:976B 05 12       ORA $12    [$7E:0012]  ;} If [$12].[$14] = 0.0: go to BRANCH_NO_COLLISION
$94:976D F0 33       BEQ $33    [$97A2]     ;/
$94:976F 9C BA 0D    STZ $0DBA  [$7E:0DBA]  ; Samus position was adjusted by a slope flag = 0
$94:9772 9C 71 1E    STZ $1E71  [$7E:1E71]  ; Samus is in quicksand flag = 0
$94:9775 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$94:9778 4A          LSR A                  ;} If [frame counter] % 2 = 0:
$94:9779 B0 07       BCS $07    [$9782]     ;/
$94:977B 20 9E 95    JSR $959E  [$94:959E]  ; Samus block collision handling - vertical - left to right
$94:977E 90 22       BCC $22    [$97A2]     ; If no collision: go to BRANCH_NO_COLLISION
$94:9780 B0 05       BCS $05    [$9787]
                                            ; Else ([frame counter] % 2 != 0):
$94:9782 20 F5 95    JSR $95F5  [$94:95F5]  ; Samus block collision handling - vertical - right to left
$94:9785 90 1B       BCC $1B    [$97A2]     ; If no collision: go to BRANCH_NO_COLLISION

$94:9787 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$94:978A 18          CLC                    ;|
$94:978B 65 14       ADC $14    [$7E:0014]  ;|
$94:978D 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus vertical position += [$12].[$14]
$94:9790 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$94:9793 65 12       ADC $12    [$7E:0012]  ;|
$94:9795 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/

; BRANCH_COLLISION
$94:9798 AB          PLB
$94:9799 28          PLP
$94:979A 38          SEC                    ; Set carry
$94:979B A9 01 00    LDA #$0001             ;\
$94:979E 8D D0 0D    STA $0DD0  [$7E:0DD0]  ;} Samus solid collision flag = block collision
$94:97A1 6B          RTL                    ; Return

; BRANCH_NO_COLLISION
$94:97A2 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$94:97A5 18          CLC                    ;|
$94:97A6 65 14       ADC $14    [$7E:0014]  ;|
$94:97A8 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus Y position += [$12].[$14]
$94:97AB AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$94:97AE 65 12       ADC $12    [$7E:0012]  ;|
$94:97B0 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$94:97B3 AD 71 1E    LDA $1E71  [$7E:1E71]  ;\
$94:97B6 D0 E0       BNE $E0    [$9798]     ;} If Samus is in quicksand: go to BRANCH_COLLISION
$94:97B8 AB          PLB
$94:97B9 28          PLP
$94:97BA 18          CLC                    ; Clear carry
$94:97BB 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$94:97BE 6B          RTL
}
}


;;; $97BF..9C1C: Block inside handling ;;;
{
;;; $97BF: Block inside reaction - slope ;;;
{
; Check if the slope is a square slope (BTS 0..5) or not. Then do nothing
; Maybe they cared about the carry flag at one point, but probably not
$94:97BF AE C4 0D    LDX $0DC4  [$7E:0DC4]
$94:97C2 BF 02 64 7F LDA $7F6402,x[$7F:648B]
$94:97C6 29 1F 00    AND #$001F
$94:97C9 C9 05 00    CMP #$0005
$94:97CC B0 01       BCS $01    [$97CF]
$94:97CE 60          RTS

$94:97CF 60          RTS
}


;;; $97D0: Block inside reaction - air/shootable air/unused air/bombable air ;;;
{
$94:97D0 A9 55 9F    LDA #$9F55             ;\
$94:97D3 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $9F55 (normal)
$94:97D6 60          RTS
}


;;; $97D7: RTS ;;;
{
$94:97D7 60          RTS
}


;;; $97D8: Clear carry. Block inside reaction - spike air - BTS 0 (unused) ;;;
{
; Looks like this block's effect was NOP'd out, although this block is never used anyway
$94:97D8 18          CLC
$94:97D9 60          RTS                    ; Return

$94:97DA AD 4E 0A    LDA $0A4E  [$7E:0A4E]  ;\
$94:97DD 18          CLC                    ;} >_<;
$94:97DE 8D 4E 0A    STA $0A4E  [$7E:0A4E]  ;/
$94:97E1 AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$94:97E4 69 01 00    ADC #$0001             ;} Periodic damage += 1
$94:97E7 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$94:97EA 9C 42 0B    STZ $0B42  [$7E:0B42]  ; Samus X extra run speed = 0
$94:97ED 9C 46 0B    STZ $0B46  [$7E:0B46]  ; Samus X base speed = 0
$94:97F0 18          CLC
$94:97F1 60          RTS
}


;;; $97F2: Unused. Some kind of upwards boost ;;;
{
$94:97F2 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$94:97F5 C9 01 00    CMP #$0001             ;} If [Samus Y direction] = up:
$94:97F8 D0 0E       BNE $0E    [$9808]     ;/
$94:97FA A9 00 00    LDA #$0000             ;\
$94:97FD 8D 32 0B    STA $0B32  [$7E:0B32]  ;|
$94:9800 A9 02 00    LDA #$0002             ;} Samus Y acceleration = 2.0
$94:9803 8D 34 0B    STA $0B34  [$7E:0B34]  ;/
$94:9806 18          CLC
$94:9807 60          RTS                    ; Return

$94:9808 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;\
$94:980B 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;} Samus Y speed = 0.0
$94:980E 18          CLC
$94:980F 60          RTS
}


;;; $9810: Clear carry ;;;
{
$94:9810 18          CLC
$94:9811 60          RTS
}


;;; $9812: Clear carry. Block inside reaction - spike air - BTS 1 (unused) ;;;
{
; Looks like this block's effect was NOP'd out, although this block is never used anyway
$94:9812 18          CLC
$94:9813 60          RTS                    ; Return

; Damages Samus, kills her jump height, gives her lava X speed physics
$94:9814 A0 00 00    LDY #$0000
$94:9817 AD 4E 0A    LDA $0A4E  [$7E:0A4E]  ;\
$94:981A 18          CLC                    ;} >_<;
$94:981B 8D 4E 0A    STA $0A4E  [$7E:0A4E]  ;/
$94:981E AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$94:9821 69 01 00    ADC #$0001             ;} Periodic damage += 1
$94:9824 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$94:9827 A9 DD A1    LDA #$A1DD             ;\
$94:982A 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $A1DD (acid/lava)
$94:982D 9C 32 0B    STZ $0B32  [$7E:0B32]  ;\
$94:9830 9C 34 0B    STZ $0B34  [$7E:0B34]  ;} Samus Y acceleration = 0.0
$94:9833 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$94:9836 C9 01 00    CMP #$0001             ;} If [Samus Y direction] = up:
$94:9839 D0 0E       BNE $0E    [$9849]     ;/
$94:983B B9 5D 98    LDA $985D,y            ;\
$94:983E 8D 32 0B    STA $0B32  [$7E:0B32]  ;|
$94:9841 B9 5F 98    LDA $985F,y            ;} Samus Y acceleration = 5.0
$94:9844 8D 34 0B    STA $0B34  [$7E:0B34]  ;/
$94:9847 18          CLC
$94:9848 60          RTS                    ; Return

$94:9849 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;\
$94:984C 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;} Samus Y speed = 0.0
$94:984F B9 61 98    LDA $9861,y            ;\
$94:9852 8D 5A 0B    STA $0B5A  [$7E:0B5A]  ;|
$94:9855 B9 63 98    LDA $9863,y            ;} Extra Samus Y displacement = 2.0
$94:9858 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/
$94:985B 18          CLC
$94:985C 60          RTS

$94:985D             dw 0000, 0005
$94:9861             dw 0000, 0002
}


;;; $9865: RTS ;;;
{
$94:9865 60          RTS
}


;;; $9866: Block inside reaction - spike air - BTS 2 (air spike) ;;;
{
$94:9866 AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$94:9869 D0 3A       BNE $3A    [$98A5]     ;} If [Samus contact damage index] != normal: go to BRANCH_RETURN
$94:986B AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$94:986E D0 35       BNE $35    [$98A5]     ;} If [Samus invincibility timer] != 0: go to BRANCH_RETURN
$94:9870 A9 3C 00    LDA #$003C             ;\
$94:9873 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 60
$94:9876 A9 0A 00    LDA #$000A             ;\
$94:9879 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = 10
$94:987C AD 4E 0A    LDA $0A4E  [$7E:0A4E]
$94:987F 18          CLC
$94:9880 69 00 00    ADC #$0000
$94:9883 8D 4E 0A    STA $0A4E  [$7E:0A4E]
$94:9886 AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$94:9889 69 10 00    ADC #$0010             ;} Periodic damage += 10h
$94:988C 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$94:988F AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$94:9892 49 0C 00    EOR #$000C             ;|
$94:9895 89 08 00    BIT #$0008             ;} If facing left:
$94:9898 F0 08       BEQ $08    [$98A2]     ;/
$94:989A A9 01 00    LDA #$0001             ;\
$94:989D 8D 54 0A    STA $0A54  [$7E:0A54]  ;} Knockback X direction = right
$94:98A0 80 03       BRA $03    [$98A5]
                                            ; Else (facing right):
$94:98A2 9C 54 0A    STZ $0A54  [$7E:0A54]  ; Knockback X direction = right

; BRANCH_RETURN
$94:98A5 A9 55 9F    LDA #$9F55             ;\
$94:98A8 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $9F55 (normal)
$94:98AB 60          RTS
}


;;; $98AC: Block inside reaction - spike air - jump table ;;;
{
$94:98AC             dw 97D8, 9812, 9866, 97D7, 97D7, 97D7, 97D7, 97D7, 97D7, 97D7, 97D7, 97D7, 97D7, 97D7, 97D7, 97D7
}


;;; $98CC: Block inside reaction - spike air ;;;
{
$94:98CC AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:98CF BF 02 64 7F LDA $7F6402,x[$7F:665E];|
$94:98D3 29 FF 00    AND #$00FF             ;|
$94:98D6 0A          ASL A                  ;} Execute [$98AC + [block BTS] * 2]
$94:98D7 AA          TAX                    ;|
$94:98D8 FC AC 98    JSR ($98AC,x)[$94:9866];/
$94:98DB 60          RTS
}


;;; $98DC: Block inside reaction - solid/door/spike/special/shootable/grapple/bombable block ;;;
{
; Set normal momentum indices
$94:98DC A9 55 9F    LDA #$9F55             ;\
$94:98DF 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $9F55 (normal)
$94:98E2 60          RTS
}


;;; $98E3: Block inside reaction - special air - default ;;;
{
$94:98E3 A9 55 9F    LDA #$9F55             ;\
$94:98E6 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $9F55 (normal)
$94:98E9 60          RTS
}


;;; $98EA: Block inside reaction - special air - BTS 8 (Wrecked Ship treadmill - rightwards) ;;;
{
$94:98EA AD 9F 07    LDA $079F  [$7E:079F]  ;\
$94:98ED C9 03 00    CMP #$0003             ;} If [area index] = Wrecked Ship:
$94:98F0 D0 09       BNE $09    [$98FB]     ;/
$94:98F2 A9 01 00    LDA #$0001             ;\
$94:98F5 22 DC 81 80 JSL $8081DC[$80:81DC]  ;} If Phantoon is not dead: go to BRANCH_RETURN
$94:98F9 90 0E       BCC $0E    [$9909]     ;/

$94:98FB AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$94:98FE D0 09       BNE $09    [$9909]     ;} If [Samus Y speed] = 0:
$94:9900 9C 56 0B    STZ $0B56  [$7E:0B56]  ;\
$94:9903 A9 02 00    LDA #$0002             ;} Extra Samus X displacement = 2.0
$94:9906 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

; BRANCH_RETURN
$94:9909 A9 55 9F    LDA #$9F55             ;\
$94:990C 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $9F55 (normal)
$94:990F 60          RTS
}


;;; $9910: Block inside reaction - special air - BTS 9 (Wrecked Ship treadmill - leftwards) ;;;
{
$94:9910 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$94:9913 C9 03 00    CMP #$0003             ;} If [area index] = Wrecked Ship:
$94:9916 D0 09       BNE $09    [$9921]     ;/
$94:9918 A9 01 00    LDA #$0001             ;\
$94:991B 22 DC 81 80 JSL $8081DC[$80:81DC]  ;} If Phantoon is not dead: go to BRANCH_RETURN
$94:991F 90 0E       BCC $0E    [$992F]     ;/

$94:9921 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$94:9924 D0 09       BNE $09    [$992F]     ;} If [Samus Y speed] = 0:
$94:9926 9C 56 0B    STZ $0B56  [$7E:0B56]  ;\
$94:9929 A9 FE FF    LDA #$FFFE             ;} Extra Samus X displacement = -2.0
$94:992C 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

; BRANCH_RETURN
$94:992F A9 55 9F    LDA #$9F55             ;\
$94:9932 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $9F55 (normal)
$94:9935 60          RTS
}


;;; $9936: Block inside reaction - special air - BTS Ah (rightwards treadmill) ;;;
{
$94:9936 9C 56 0B    STZ $0B56  [$7E:0B56]  ;\
$94:9939 A9 02 00    LDA #$0002             ;} Extra Samus X displacement = 2.0
$94:993C 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$94:993F A9 55 9F    LDA #$9F55             ;\
$94:9942 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $9F55 (normal)
$94:9945 60          RTS
}


;;; $9946: Block inside reaction - special air - BTS Bh (leftwards treadmill) ;;;
{
$94:9946 9C 56 0B    STZ $0B56  [$7E:0B56]  ;\
$94:9949 A9 FE FF    LDA #$FFFE             ;} Extra Samus X displacement = -2.0
$94:994C 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$94:994F A9 55 9F    LDA #$9F55             ;\
$94:9952 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $9F55 (normal)
$94:9955 60          RTS
}


;;; $9956: Block inside reaction - special air - BTS 46h (scroll PLM trigger) ;;;
{
; This routine is weird, block collision should have already spawned the scroll PLM trigger PLM,
; and the check here means the PLM is only spawned here if Samus' bottom boundary is in a different block than her centre,
; which seems a bit random. As far as I can tell, this reaction can just be replaced with the default $98E3
$94:9956 AD 73 1E    LDA $1E73  [$7E:1E73]  ;\
$94:9959 C9 01 00    CMP #$0001             ;} If [inside block reaction Samus point] = centre:
$94:995C D0 07       BNE $07    [$9965]     ;/
$94:995E A9 FF B6    LDA #$B6FF             ;\
$94:9961 22 E7 84 84 JSL $8484E7[$84:84E7]  ;} Spawn scroll PLM trigger PLM

$94:9965 60          RTS
}


;;; $9966: Block inside reaction - special air - jump table ;;;
{
$94:9966             dw 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98EA, 9910, 9936, 9946, 98E3, 98E3, 98E3, 98E3,
                        98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3,
                        98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3,
                        98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3,
                        98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 9956, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3, 98E3
}


;;; $9A06: Block inside reaction - special air - PLM table ;;;
{
; Region dependant
$94:9A06             dw B70F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F  ; 0: Crateria
$94:9A26             dw B6CB, B6CF, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F  ; 1: Brinstar
$94:9A46             dw B653, B657, B65B, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F  ; 2: Norfair
$94:9A66             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F  ; 3: Wrecked Ship
$94:9A86             dw B713, B713, B713, B71F, B723, B727, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F  ; 4: Maridia
$94:9AA6             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F  ; 5: Tourian
$94:9AC6             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F  ; 6: Ceres
$94:9AE6             dw B70F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F  ; 7: Debug

$94:9B06             dw 9A06, 9A26, 9A46, 9A66, 9A86, 9AA6, 9AC6, 9AE6
}


;;; $9B16: Block inside reaction - special air ;;;
{
$94:9B16 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9B19 BF 01 64 7F LDA $7F6401,x[$7F:673D];} If [block BTS] & 80h = 0:
$94:9B1D 30 0A       BMI $0A    [$9B29]     ;/
$94:9B1F 29 00 FF    AND #$FF00             ;\
$94:9B22 EB          XBA                    ;|
$94:9B23 0A          ASL A                  ;} Execute [$9966 + [block BTS] * 2]
$94:9B24 AA          TAX                    ;|
$94:9B25 FC 66 99    JSR ($9966,x)[$94:9956];/
$94:9B28 60          RTS                    ; Return

$94:9B29 EB          XBA                    ;\
$94:9B2A 29 7F 00    AND #$007F             ;|
$94:9B2D 0A          ASL A                  ;|
$94:9B2E A8          TAY                    ;|
$94:9B2F AD 9F 07    LDA $079F  [$7E:079F]  ;|
$94:9B32 0A          ASL A                  ;} Spawn PLM [[$9B06 + [area index] * 2] + ([block BTS] & 7Fh) * 2]
$94:9B33 AA          TAX                    ;|
$94:9B34 BD 06 9B    LDA $9B06,x[$94:9B08]  ;|
$94:9B37 85 22       STA $22    [$7E:0022]  ;|
$94:9B39 B1 22       LDA ($22),y[$94:9A26]  ;|
$94:9B3B 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9B3F 60          RTS
}


;;; $9B40: Block inside reaction pointers ;;;
{
$94:9B40             dw 97D0, ; *0: Air
                        97BF, ;  1: Slope
                        98CC, ;  2: Spike air
                        9B16, ;  3: Special air
                        97D0, ; *4: Shootable air
                        9411, ;  5: Horizontal extension
                        97D0, ; *6: Unused air
                        97D0, ; *7: Bombable air
                        98DC, ; *8: Solid block
                        98DC, ; *9: Door block
                        98DC, ; *Ah: Spike block
                        98DC, ; *Bh: Special block
                        98DC, ; *Ch: Shootable block
                        9447, ;  Dh: Vertical extension
                        98DC, ; *Eh: Grapple block
                        98DC  ; *Fh: Bombable block
}


;;; $9B60: Samus block inside handling ;;;
{
; This routine uses XOR to test if two values are different, which is fine,
; but chaining it a second time ($94:9BEB) doesn't work at all,
; so that branch is very unlikely to be taken >_<;
; Result is that if Samus' top and centre are in the same block (and her bottom is in a different block),
; that block's inside reaction will usually be executed twice
; I guess the reaction of the block her top is inside *won't* be executed under some circumstances too
$94:9B60 8B          PHB
$94:9B61 4B          PHK                    ;\
$94:9B62 AB          PLB                    ;} DB = $94
$94:9B63 9C 4C 0B    STZ $0B4C  [$7E:0B4C]  ; Samus X deceleration multiplier = 0
$94:9B66 9C 56 0B    STZ $0B56  [$7E:0B56]  ;\
$94:9B69 9C 58 0B    STZ $0B58  [$7E:0B58]  ;} Extra Samus X displacement = 0.0
$94:9B6C 9C 5A 0B    STZ $0B5A  [$7E:0B5A]  ;\
$94:9B6F 9C 5C 0B    STZ $0B5C  [$7E:0B5C]  ;} Extra Samus Y displacement = 0.0
$94:9B72 9C 73 1E    STZ $1E73  [$7E:1E73]  ; Inside block reaction Samus point = bottom
$94:9B75 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$94:9B78 85 1A       STA $1A    [$7E:001A]  ;} $1A = [Samus X position]
$94:9B7A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:9B7D 18          CLC                    ;|
$94:9B7E 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$94:9B81 3A          DEC A                  ;} $1C = Samus bottom boundary position = [Samus Y position] + [Samus Y radius] - 1
$94:9B82 8D 02 0E    STA $0E02  [$7E:0E02]  ;|
$94:9B85 85 1C       STA $1C    [$7E:001C]  ;/
$94:9B87 64 1E       STZ $1E    [$7E:001E]  ;\
$94:9B89 64 20       STZ $20    [$7E:0020]  ;} Calculate block at ([$1A], [$1C])
$94:9B8B 20 1D 9C    JSR $9C1D  [$94:9C1D]  ;/
$94:9B8E AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:9B91 0A          ASL A                  ;|
$94:9B92 AA          TAX                    ;|
$94:9B93 BF 03 00 7F LDA $7F0003,x[$7F:0115];|
$94:9B97 29 F0 00    AND #$00F0             ;|
$94:9B9A 4A          LSR A                  ;} Execute [$9B40 + (block type) * 2]
$94:9B9B 4A          LSR A                  ;|
$94:9B9C 4A          LSR A                  ;|
$94:9B9D AA          TAX                    ;|
$94:9B9E FC 40 9B    JSR ($9B40,x)[$94:97BF];/
$94:9BA1 A9 01 00    LDA #$0001             ;\
$94:9BA4 8D 73 1E    STA $1E73  [$7E:1E73]  ;} Inside block reaction Samus point = centre
$94:9BA7 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:9BAA 4D 02 0E    EOR $0E02  [$7E:0E02]  ;|
$94:9BAD 29 F0 FF    AND #$FFF0             ;} If [Samus Y position] / 10h != [Samus bottom boundary position] / 10h:
$94:9BB0 F0 24       BEQ $24    [$9BD6]     ;/
$94:9BB2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$94:9BB5 85 1A       STA $1A    [$7E:001A]  ;} $1A = [Samus X position]
$94:9BB7 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:9BBA 85 1C       STA $1C    [$7E:001C]  ;} $1C = [Samus Y position]
$94:9BBC 64 1E       STZ $1E    [$7E:001E]  ;\
$94:9BBE 64 20       STZ $20    [$7E:0020]  ;} Calculate block at ([$1A], [$1C])
$94:9BC0 20 1D 9C    JSR $9C1D  [$94:9C1D]  ;/
$94:9BC3 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:9BC6 0A          ASL A                  ;|
$94:9BC7 AA          TAX                    ;|
$94:9BC8 BF 03 00 7F LDA $7F0003,x[$7F:00F5];|
$94:9BCC 29 F0 00    AND #$00F0             ;|
$94:9BCF 4A          LSR A                  ;} Execute [$9B40 + (block type) * 2]
$94:9BD0 4A          LSR A                  ;|
$94:9BD1 4A          LSR A                  ;|
$94:9BD2 AA          TAX                    ;|
$94:9BD3 FC 40 9B    JSR ($9B40,x)[$94:97D0];/

$94:9BD6 A9 02 00    LDA #$0002             ;\
$94:9BD9 8D 73 1E    STA $1E73  [$7E:1E73]  ;} Inside block reaction Samus point = top
$94:9BDC AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:9BDF 38          SEC                    ;|
$94:9BE0 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$94:9BE3 4D 02 0E    EOR $0E02  [$7E:0E02]  ;} If (Samus top boundary) / 10h != [Samus bottom boundary position] / 10h:
$94:9BE6 29 F0 FF    AND #$FFF0             ;|
$94:9BE9 F0 30       BEQ $30    [$9C1B]     ;/
$94:9BEB 4D FA 0A    EOR $0AFA  [$7E:0AFA]  ;\
$94:9BEE 29 F0 FF    AND #$FFF0             ;} If ((Samus top boundary) ^ [Samus bottom boundary position]) / 10h != [Samus X position] / 10h:
$94:9BF1 F0 28       BEQ $28    [$9C1B]     ;/
$94:9BF3 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$94:9BF6 85 1A       STA $1A    [$7E:001A]  ;} $1A = [Samus X position]
$94:9BF8 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$94:9BFB 38          SEC                    ;|
$94:9BFC ED 00 0B    SBC $0B00  [$7E:0B00]  ;} $1C = (Samus top boundary)
$94:9BFF 85 1C       STA $1C    [$7E:001C]  ;/
$94:9C01 64 1E       STZ $1E    [$7E:001E]  ;\
$94:9C03 64 20       STZ $20    [$7E:0020]  ;} Calculate block at ([$1A], [$1C])
$94:9C05 20 1D 9C    JSR $9C1D  [$94:9C1D]  ;/
$94:9C08 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:9C0B 0A          ASL A                  ;|
$94:9C0C AA          TAX                    ;|
$94:9C0D BF 03 00 7F LDA $7F0003,x[$7F:00B5];|
$94:9C11 29 F0 00    AND #$00F0             ;|
$94:9C14 4A          LSR A                  ;} Execute [$9B40 + (block type) * 2]
$94:9C15 4A          LSR A                  ;|
$94:9C16 4A          LSR A                  ;|
$94:9C17 AA          TAX                    ;|
$94:9C18 FC 40 9B    JSR ($9B40,x)[$94:97D0];/

$94:9C1B AB          PLB
$94:9C1C 6B          RTL
}
}


;;; $9C1D: Calculate block at ([$1A] + [$1E], [$1C] + [$20]) ;;;
{
; Every call site sets $1E and $20 to zero
; Sets X to zero if block index is calculated successfully (for no reason)
$94:9C1D 08          PHP
$94:9C1E C2 30       REP #$30
$94:9C20 A5 1A       LDA $1A    [$7E:001A]  ;\
$94:9C22 18          CLC                    ;|
$94:9C23 65 1E       ADC $1E    [$7E:001E]  ;} If [$1A] + [$1E] < 0: go to BRANCH_GIVE_UP
$94:9C25 30 44       BMI $44    [$9C6B]     ;/
$94:9C27 C9 00 10    CMP #$1000             ;\
$94:9C2A 10 3F       BPL $3F    [$9C6B]     ;} If [$1A] + [$1E] >= 1000h: go to BRANCH_GIVE_UP
$94:9C2C 29 F0 FF    AND #$FFF0             ; >_<;
$94:9C2F 4A          LSR A                  ;\
$94:9C30 4A          LSR A                  ;|
$94:9C31 4A          LSR A                  ;} $0DD4 = ([$1A] + [$1E]) / 10h (X block)
$94:9C32 4A          LSR A                  ;|
$94:9C33 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:9C36 A5 1C       LDA $1C    [$7E:001C]  ;\
$94:9C38 18          CLC                    ;|
$94:9C39 65 20       ADC $20    [$7E:0020]  ;} If [$1C] + [$20] < 0: go to BRANCH_GIVE_UP
$94:9C3B 30 2E       BMI $2E    [$9C6B]     ;/
$94:9C3D C9 00 10    CMP #$1000             ;\
$94:9C40 10 29       BPL $29    [$9C6B]     ;} If [$1C] + [$20] >= 1000h: go to BRANCH_GIVE_UP
$94:9C42 29 F0 FF    AND #$FFF0             ; >_<;
$94:9C45 4A          LSR A                  ;\
$94:9C46 4A          LSR A                  ;|
$94:9C47 4A          LSR A                  ;} A = ([$1C] + [$20]) / 10h (Y block)
$94:9C48 4A          LSR A                  ;/
$94:9C49 A8          TAY                    ;\
$94:9C4A F0 16       BEQ $16    [$9C62]     ;|
$94:9C4C A2 00 00    LDX #$0000             ;|
$94:9C4F E2 20       SEP #$20               ;|
$94:9C51 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:9C54 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:9C57 8C 03 42    STY $4203  [$7E:4203]  ;|
$94:9C5A EA          NOP                    ;|
$94:9C5B EA          NOP                    ;} Current block index = [A] * [room width] + [$0DD4]
$94:9C5C EA          NOP                    ;|
$94:9C5D C2 20       REP #$20               ;|
$94:9C5F AD 16 42    LDA $4216  [$7E:4216]  ;|
                                            ;|
$94:9C62 18          CLC                    ;|
$94:9C63 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;|
$94:9C66 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:9C69 80 06       BRA $06    [$9C71]

; BRANCH_GIVE_UP
$94:9C6B A9 FF FF    LDA #$FFFF             ;\
$94:9C6E 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;} Current block index = FFFFh

$94:9C71 28          PLP
$94:9C72 60          RTS
}


;;; $9C73..A956: Block shot/bombed/grappled handling ;;;
{
;;; $9C73: Determine projectile proto type ;;;
{
;; Parameters:
;;     X: Projectile index

; Called only as part of $9CAC for determining if a (power) bomb is a normal bomb or not
; Highly likely that this is based on an old model of the projectile system and was supposed to have been entirely abandoned,
; but here we are

; The is a frame after the end of a power bomb explosion where this subroutine is called where the projectile type is 0,
; cause the code at $9C83 to be executed. I doubt this is intentional
$94:9C73 08          PHP
$94:9C74 8B          PHB
$94:9C75 DA          PHX
$94:9C76 F4 00 90    PEA $9000              ;\
$94:9C79 AB          PLB                    ;} DB = $90
$94:9C7A AB          PLB                    ;/
$94:9C7B BD 19 0C    LDA $0C19,x[$7E:0C23]  ;\
$94:9C7E 29 0F 00    AND #$000F             ;} If (projectile type) = beam:
$94:9C81 D0 19       BNE $19    [$9C9C]     ;/
$94:9C83 BD 18 0C    LDA $0C18,x[$7E:0C22]  ;\
$94:9C86 29 0F 00    AND #$000F             ;|
$94:9C89 85 12       STA $12    [$7E:0012]  ;|
$94:9C8B 0A          ASL A                  ;|
$94:9C8C 65 12       ADC $12    [$7E:0012]  ;|
$94:9C8E 1A          INC A                  ;} Projectile proto type = [$C37B + [beam type] * 3 + 2]
$94:9C8F 1A          INC A                  ;|
$94:9C90 AA          TAX                    ;|
$94:9C91 BD 7B C3    LDA $C37B,x[$90:C37D]  ;|
$94:9C94 29 FF 00    AND #$00FF             ;|
$94:9C97 8D D2 0D    STA $0DD2  [$7E:0DD2]  ;/
$94:9C9A 80 0C       BRA $0C    [$9CA8]

$94:9C9C 0A          ASL A                  ;\ Else ((projectile type) != beam):
$94:9C9D 1A          INC A                  ;|
$94:9C9E AA          TAX                    ;|
$94:9C9F BD 9F C3    LDA $C39F,x[$90:C3AA]  ;} Projectile proto type = [$C39F + (projectile type) * 2 + 1]
$94:9CA2 29 FF 00    AND #$00FF             ;|
$94:9CA5 8D D2 0D    STA $0DD2  [$7E:0DD2]  ;/

$94:9CA8 FA          PLX
$94:9CA9 AB          PLB
$94:9CAA 28          PLP
$94:9CAB 60          RTS
}


;;; $9CAC: (Power) bomb explosion block collision handling ;;;
{
;; Parameters:
;;     X: Projectile index

; Executed for bombs on every frame, not just the frame(s) an explosion is active o_O
$94:9CAC 08          PHP
$94:9CAD 8B          PHB
$94:9CAE 4B          PHK                    ;\
$94:9CAF AB          PLB                    ;} DB = $94
$94:9CB0 C2 30       REP #$30
$94:9CB2 20 73 9C    JSR $9C73  [$94:9C73]  ; Determine projectile proto type
$94:9CB5 BD 64 0B    LDA $0B64,x[$7E:0B6E]  ;\
$94:9CB8 30 37       BMI $37    [$9CF1]     ;} If [projectile X position] < 0: return
$94:9CBA 85 1A       STA $1A    [$7E:001A]  ; $1A = [projectile X position]
$94:9CBC EB          XBA                    ;\
$94:9CBD 29 FF 00    AND #$00FF             ;|
$94:9CC0 CD A9 07    CMP $07A9  [$7E:07A9]  ;} If [projectile X position] >= [room width]: return
$94:9CC3 10 2C       BPL $2C    [$9CF1]     ;/
$94:9CC5 BD 78 0B    LDA $0B78,x[$7E:0B82]  ;\
$94:9CC8 30 27       BMI $27    [$9CF1]     ;} If [projectile Y position] < 0: return
$94:9CCA 85 1C       STA $1C    [$7E:001C]  ; $1C = [projectile Y position]
$94:9CCC EB          XBA                    ;\
$94:9CCD 29 FF 00    AND #$00FF             ;|
$94:9CD0 CD AB 07    CMP $07AB  [$7E:07AB]  ;} If [projectile Y position] >= [room height]: return
$94:9CD3 10 1C       BPL $1C    [$9CF1]     ;/
$94:9CD5 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0
$94:9CD7 64 20       STZ $20    [$7E:0020]  ; $20 = 0
$94:9CD9 9C C4 0D    STZ $0DC4  [$7E:0DC4]  ; Current block index = 0
$94:9CDC DA          PHX                    ;\
$94:9CDD 20 1D 9C    JSR $9C1D  [$94:9C1D]  ;} Calculate block at ([$1A], [$1C])
$94:9CE0 FA          PLX                    ;/
$94:9CE1 AD D2 0D    LDA $0DD2  [$7E:0DD2]  ;\
$94:9CE4 C9 02 00    CMP #$0002             ;} If [projectile proto type] != bomb:
$94:9CE7 F0 05       BEQ $05    [$9CEE]     ;/
$94:9CE9 20 6A A0    JSR $A06A  [$94:A06A]  ; Power bomb explosion block collision handling
$94:9CEC 80 03       BRA $03    [$9CF1]
                                            ; Else ([projectile proto type] = bomb):
$94:9CEE 20 F4 9C    JSR $9CF4  [$94:9CF4]  ; Bomb explosion block collision handling

$94:9CF1 AB          PLB
$94:9CF2 28          PLP
$94:9CF3 6B          RTL
}


;;; $9CF4: Bomb explosion block collision handling ;;;
{
;; Parameters:
;;     X: Projectile index

$94:9CF4 BD 7C 0C    LDA $0C7C,x[$7E:0C86]  ;\
$94:9CF7 D0 39       BNE $39    [$9D32]     ;} If [bomb timer] != 0: return
$94:9CF9 BD 18 0C    LDA $0C18,x[$7E:0C22]  ;\
$94:9CFC 89 01 00    BIT #$0001             ;} If bomb explosion active: return
$94:9CFF D0 31       BNE $31    [$9D32]     ;/
$94:9D01 09 01 00    ORA #$0001             ;\
$94:9D04 9D 18 0C    STA $0C18,x[$7E:0C22]  ;} Set bomb explosion active
$94:9D07 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:9D0A C9 FF FF    CMP #$FFFF             ;} If [current block index] = FFFFh: return
$94:9D0D F0 23       BEQ $23    [$9D32]     ;/
$94:9D0F A0 00 00    LDY #$0000             ; Y = 0
$94:9D12 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ; >_<;
$94:9D15 0A          ASL A                  ;\
$94:9D16 AA          TAX                    ;} X = [current block index] * 2
$94:9D17 20 52 A0    JSR $A052  [$94:A052]  ; Block bombed reaction
$94:9D1A 20 34 9D    JSR $9D34  [$94:9D34]  ; X = block index above (bug if bomb is laid on top row of room)
$94:9D1D 20 52 A0    JSR $A052  [$94:A052]  ; Block bombed reaction
$94:9D20 20 3E 9D    JSR $9D3E  [$94:9D3E]  ; X = block index to the right
$94:9D23 20 52 A0    JSR $A052  [$94:A052]  ; Block bombed reaction
$94:9D26 20 49 9D    JSR $9D49  [$94:9D49]  ; X = block index to the left
$94:9D29 20 52 A0    JSR $A052  [$94:A052]  ; Block bombed reaction
$94:9D2C 20 4E 9D    JSR $9D4E  [$94:9D4E]  ; X = block index below
$94:9D2F 20 52 A0    JSR $A052  [$94:A052]  ; Block bombed reaction

$94:9D32 60          RTS
}


;;; $9D33: RTS ;;;
{
$94:9D33 60          RTS
}


;;; $9D34: Move block index X one row up ;;;
{
$94:9D34 8A          TXA
$94:9D35 38          SEC
$94:9D36 ED A5 07    SBC $07A5  [$7E:07A5]
$94:9D39 ED A5 07    SBC $07A5  [$7E:07A5]
$94:9D3C AA          TAX
$94:9D3D 60          RTS
}


;;; $9D3E: Move block index X one row down, one column right ;;;
{
$94:9D3E 8A          TXA
$94:9D3F 38          SEC
$94:9D40 6D A5 07    ADC $07A5  [$7E:07A5]
$94:9D43 6D A5 07    ADC $07A5  [$7E:07A5]
$94:9D46 1A          INC A
$94:9D47 AA          TAX
$94:9D48 60          RTS
}


;;; $9D49: Move block index X two columns left ;;;
{
$94:9D49 CA          DEX
$94:9D4A CA          DEX
$94:9D4B CA          DEX
$94:9D4C CA          DEX
$94:9D4D 60          RTS
}


;;; $9D4E: Move block index X one row down, one column right ;;;
{
; Clone of $9D3E
$94:9D4E 8A          TXA
$94:9D4F 38          SEC
$94:9D50 6D A5 07    ADC $07A5  [$7E:07A5]
$94:9D53 6D A5 07    ADC $07A5  [$7E:07A5]
$94:9D56 1A          INC A
$94:9D57 AA          TAX
$94:9D58 60          RTS
}


;;; $9D59: Clear carry ;;;
{
$94:9D59 18          CLC
$94:9D5A 60          RTS
}


;;; $9D5B: Set carry ;;;
{
$94:9D5B 38          SEC
$94:9D5C 60          RTS
}


;;; $9D5D: Spread bomb block reaction - slope ;;;
{
;; Returns:
;;     Carry: Set if collision detected, clear otherwise
$94:9D5D AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9D60 BF 02 64 7F LDA $7F6402,x          ;|
$94:9D64 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh >= 5:
$94:9D67 C9 05 00    CMP #$0005             ;|
$94:9D6A 90 03       BCC $03    [$9D6F]     ;/
$94:9D6C 4C 43 A5    JMP $A543  [$94:A543]  ; Go to block shot reaction - horizontal - slope - non-square

$94:9D6F 38          SEC                    ;\
$94:9D70 60          RTS                    ;} Return carry set
}


;;; $9D71: Block bombed reaction - special block ;;;
{
$94:9D71 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9D74 BF 01 64 7F LDA $7F6401,x[$7F:6668];|
$94:9D78 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h != 0: go to BRANCH_AREA_DEPENDANT
$94:9D7B EB          XBA                    ;|
$94:9D7C 30 0D       BMI $0D    [$9D8B]     ;/
$94:9D7E 0A          ASL A                  ;\
$94:9D7F AA          TAX                    ;|
$94:9D80 BD A4 9D    LDA $9DA4,x[$94:9DA4]  ;} Spawn PLM [$9DA4 + [block BTS] * 2]
$94:9D83 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9D87 C2 40       REP #$40
$94:9D89 38          SEC
$94:9D8A 60          RTS                    ; Return

; BRANCH_AREA_DEPENDANT
$94:9D8B 29 7F 00    AND #$007F             ;\
$94:9D8E 0A          ASL A                  ;|
$94:9D8F A8          TAY                    ;|
$94:9D90 AD 9F 07    LDA $079F  [$7E:079F]  ;|
$94:9D93 0A          ASL A                  ;|
$94:9D94 AA          TAX                    ;} Spawn PLM [[$9E44 + [area index] * 2] + ([block BTS] & 7Fh) * 2]
$94:9D95 BD 44 9E    LDA $9E44,x            ;|
$94:9D98 85 12       STA $12    [$7E:0012]  ;|
$94:9D9A B1 12       LDA ($12),y            ;|
$94:9D9C 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9DA0 C2 40       REP #$40
$94:9DA2 38          SEC
$94:9DA3 60          RTS
}


;;; $9DA4: Block bombed reaction - special block - PLM table ;;;
{
; Region independent
$94:9DA4             dw CFFC, D000, D004, D008, CFFC, D000, D004, D008, B62F, B62F, B62F, B62F, B62F, B62F, D024, D024

; Region dependant
$94:9DC4             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 0: Crateria
$94:9DD4             dw B62F, B62F, D024, D024, D024, D024, B62F, B62F ; 1: Brinstar
$94:9DE4             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 2: Norfair
$94:9DF4             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 3: Wrecked Ship
$94:9E04             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 4: Maridia
$94:9E14             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 5: Tourian
$94:9E24             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 6: Ceres
$94:9E34             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 7: Debug

$94:9E44             dw 9DC4, 9DD4, 9DE4, 9DF4, 9E04, 9E14, 9E24, 9E34
}


;;; $9E54: RTS ;;;
{
$94:9E54 60          RTS
}


;;; $9E55: Block shot/bombed/grappled reaction - shootable air ;;;
{
;; Returns:
;;     Carry: Clear. No collision
;;     Overflow: Clear (no effect)
$94:9E55 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9E58 BF 01 64 7F LDA $7F6401,x[$7F:64C3];|
$94:9E5C 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h != 0: return carry clear, overflow clear
$94:9E5F EB          XBA                    ;|
$94:9E60 30 0D       BMI $0D    [$9E6F]     ;/
$94:9E62 0A          ASL A                  ;\
$94:9E63 AA          TAX                    ;|
$94:9E64 BD A6 9E    LDA $9EA6,x[$94:9EA6]  ;} Spawn PLM [$9EA6 + [block BTS] * 2]
$94:9E67 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9E6B C2 40       REP #$40               ;\
$94:9E6D 18          CLC                    ;} Return carry clear, overflow clear
$94:9E6E 60          RTS                    ;/

$94:9E6F C2 40       REP #$40
$94:9E71 18          CLC
$94:9E72 60          RTS
}


;;; $9E73: Block shot/bombed/grappled reaction - shootable block ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
;;     Overflow: Clear. Cancel grapple beam
$94:9E73 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9E76 BF 01 64 7F LDA $7F6401,x[$7F:8B62];|
$94:9E7A 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h != 0: go to BRANCH_AREA_DEPENDANT
$94:9E7D EB          XBA                    ;|
$94:9E7E 30 0D       BMI $0D    [$9E8D]     ;/
$94:9E80 0A          ASL A                  ;\
$94:9E81 AA          TAX                    ;|
$94:9E82 BD A6 9E    LDA $9EA6,x[$94:9F28]  ;} Spawn PLM [$9EA6 + [block BTS] * 2]
$94:9E85 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9E89 C2 40       REP #$40               ;\
$94:9E8B 38          SEC                    ;} Return carry set, overflow clear
$94:9E8C 60          RTS                    ;/

; BRANCH_AREA_DEPENDANT
$94:9E8D 29 7F 00    AND #$007F             ;\
$94:9E90 0A          ASL A                  ;|
$94:9E91 A8          TAY                    ;|
$94:9E92 AD 9F 07    LDA $079F  [$7E:079F]  ;|
$94:9E95 0A          ASL A                  ;|
$94:9E96 AA          TAX                    ;} Spawn PLM [[$9FC6 + [area index] * 2] + ([block BTS] & 7Fh) * 2]
$94:9E97 BD C6 9F    LDA $9FC6,x[$94:9FC6]  ;|
$94:9E9A 85 12       STA $12    [$7E:0012]  ;|
$94:9E9C B1 12       LDA ($12),y[$7E:5555]  ;|
$94:9E9E 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9EA2 C2 40       REP #$40               ;\
$94:9EA4 38          SEC                    ;} Return carry set, overflow clear
$94:9EA5 60          RTS                    ;/
}


;;; $9EA6: Block shot/bombed/grappled reaction - shootable - PLM table ;;;
{
; Region independent
$94:9EA6             dw D064, D068, D06C, D070, D074, D078, D07C, D080, D084, D088, D08C, D090, B62F, B62F, B62F, B62F,
                        B974, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F,
                        B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F,
                        B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F,
                        C8A2, C8A8, C8AE, C8B4, C83E, EED3, C816, C81A, C80E, C812, C806, C80A, C81E, C822, B62F, B9C1

; Region dependant. Shootable block only
$94:9F46             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 0: Crateria
$94:9F56             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 1: Brinstar
$94:9F66             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 2: Norfair
$94:9F76             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 3: Wrecked Ship
$94:9F86             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 4: Maridia
$94:9F96             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 5: Tourian
$94:9FA6             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 6: Ceres
$94:9FB6             dw B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F ; 7: Debug

$94:9FC6             dw 9F46, 9F56, 9F66, 9F76, 9F86, 9F96, 9FA6, 9FB6
}


;;; $9FD6: Block shot/bombed/grappled reaction - bombable air ;;;
{
;; Returns:
;;     Carry: Clear. No collision
;;     Overflow: Clear (no effect)
$94:9FD6 AE C4 0D    LDX $0DC4  [$7F:0DC4]  ;\
$94:9FD9 BF 01 64 7F LDA $7F6401,x[$7F:6401];|
$94:9FDD 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h != 0: return clear, overflow clear
$94:9FE0 EB          XBA                    ;|
$94:9FE1 30 0D       BMI $0D    [$9FF0]     ;/
$94:9FE3 0A          ASL A                  ;\
$94:9FE4 AA          TAX                    ;|
$94:9FE5 BD 12 A0    LDA $A012,x[$94:A012]  ;} Spawn PLM [$A012 + [block BTS] * 2]
$94:9FE8 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:9FEC C2 40       REP #$40               ;\
$94:9FEE 18          CLC                    ;} Return carry clear, overflow clear
$94:9FEF 60          RTS                    ;/

$94:9FF0 C2 40       REP #$40
$94:9FF2 18          CLC
$94:9FF3 60          RTS
}


;;; $9FF4: Block shot/bombed/grappled reaction - bombable block ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
;;     Overflow: Clear. Cancel grapple beam
$94:9FF4 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:9FF7 BF 01 64 7F LDA $7F6401,x[$7F:66E0];|
$94:9FFB 29 00 FF    AND #$FF00             ;} If [block BTS] & 80h != 0: return carry set, overflow clear
$94:9FFE EB          XBA                    ;|
$94:9FFF 30 0D       BMI $0D    [$A00E]     ;/
$94:A001 0A          ASL A                  ;\
$94:A002 AA          TAX                    ;|
$94:A003 BD 12 A0    LDA $A012,x[$94:A014]  ;} Spawn PLM [$A012 + [block BTS] * 2]
$94:A006 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:A00A C2 40       REP #$40               ;\
$94:A00C 38          SEC                    ;} Return carry set, overflow clear
$94:A00D 60          RTS                    ;/

$94:A00E C2 40       REP #$40
$94:A010 38          SEC
$94:A011 60          RTS
}


;;; $A012: Block shot/bombed/grappled reaction - bombable - PLM table ;;;
{
$94:A012             dw D0B8, D0BC, D0C0, D0C4, D0C8, D0CC, D0D0, D0D4, B62F, B62F, B62F, B62F, B62F, B62F, B62F, B62F
}


;;; $A032: Block bombed reaction pointers ;;;
{
$94:A032             dw 9D59, ;  0: Air
                        9D59, ;  1: Slope
                        9D59, ;  2: Spike air
                        9D59, ;  3: Special air
                        9E55, ; *4: Shootable air
                        9411, ; *5: Horizontal extension
                        9D59, ;  6: Unused air
                        9FD6, ; *7: Bombable air
                        9D5B, ;  8: Solid block
                        9D5B, ;  9: Door block
                        9D5B, ;  Ah: Spike block
                        9D71, ; *Bh: Special block
                        9E73, ; *Ch: Shootable block
                        9447, ; *Dh: Vertical extension
                        9D5B, ;  Eh: Grapple block
                        9FF4  ; *Fh: Bombable block
}


;;; $A052: Block bombed reaction ;;;
{
;; Parameters:
;;     X: Block index

$94:A052 DA          PHX
$94:A053 8E C4 0D    STX $0DC4  [$7E:0DC4]  ;\
$94:A056 4E C4 0D    LSR $0DC4  [$7E:0DC4]  ;} Current block index = [X] / 2
$94:A059 BF 02 00 7F LDA $7F0002,x[$7F:073C];\
$94:A05D 29 00 F0    AND #$F000             ;|
$94:A060 EB          XBA                    ;|
$94:A061 4A          LSR A                  ;|
$94:A062 4A          LSR A                  ;} Execute [$A032 + (block type) * 2]
$94:A063 4A          LSR A                  ;|
$94:A064 AA          TAX                    ;|
$94:A065 FC 32 A0    JSR ($A032,x)[$94:9D59];/
$94:A068 FA          PLX
$94:A069 60          RTS
}


;;; $A06A: Power bomb explosion block collision handling ;;;
{
;; Parameters:
;;     X: Projectile index

$94:A06A BD 7C 0C    LDA $0C7C,x[$7E:0C86]  ;\
$94:A06D F0 06       BEQ $06    [$A075]     ;} If [bomb timer] = 0: go to BRANCH_ZERO
$94:A06F 10 03       BPL $03    [$A074]     ;\
$94:A071 9E 7C 0C    STZ $0C7C,x[$7E:0C86]  ;} Bomb timer = max([bomb timer], 0)

$94:A074 60          RTS                    ; Return

; BRANCH_ZERO
$94:A075 AD EB 0C    LDA $0CEB  [$7E:0CEB]  ;\
$94:A078 29 FF 00    AND #$00FF             ;} $12 = [power bomb explosion radius] / 100h (power bomb X radius)
$94:A07B 85 12       STA $12    [$7E:0012]  ;/
$94:A07D 0A          ASL A                  ;\
$94:A07E 65 12       ADC $12    [$7E:0012]  ;|
$94:A080 4A          LSR A                  ;} $14 = (power bomb X radius) * 3/4 (power bomb Y radius)
$94:A081 4A          LSR A                  ;|
$94:A082 85 14       STA $14    [$7E:0014]  ;/
$94:A084 AD E2 0C    LDA $0CE2  [$7E:0CE2]  ;\
$94:A087 38          SEC                    ;|
$94:A088 E5 12       SBC $12    [$7E:0012]  ;|
$94:A08A 10 03       BPL $03    [$A08F]     ;|
$94:A08C A9 00 00    LDA #$0000             ;|
                                            ;} $16 = max(0, [power bomb explosion X position] - (power bomb X radius)) / 10h (power bomb left boundary)
$94:A08F 4A          LSR A                  ;|
$94:A090 4A          LSR A                  ;|
$94:A091 4A          LSR A                  ;|
$94:A092 4A          LSR A                  ;|
$94:A093 85 16       STA $16    [$7E:0016]  ;/
$94:A095 AD E2 0C    LDA $0CE2  [$7E:0CE2]  ;\
$94:A098 18          CLC                    ;|
$94:A099 65 12       ADC $12    [$7E:0012]  ;|
$94:A09B 4A          LSR A                  ;|
$94:A09C 4A          LSR A                  ;|
$94:A09D 4A          LSR A                  ;|
$94:A09E 4A          LSR A                  ;} $18 = min([room width in blocks] - 1, [power bomb explosion X position] + (power bomb X radius)) / 10h (power bomb right boundary)
$94:A09F CD A5 07    CMP $07A5  [$7E:07A5]  ;|
$94:A0A2 90 04       BCC $04    [$A0A8]     ;|
$94:A0A4 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A0A7 3A          DEC A                  ;|
                                            ;|
$94:A0A8 85 18       STA $18    [$7E:0018]  ;/
$94:A0AA AD E4 0C    LDA $0CE4  [$7E:0CE4]  ;\
$94:A0AD 38          SEC                    ;|
$94:A0AE E5 14       SBC $14    [$7E:0014]  ;|
$94:A0B0 10 03       BPL $03    [$A0B5]     ;|
$94:A0B2 A9 00 00    LDA #$0000             ;|
                                            ;} $1A = max(0, [power bomb explosion Y position] - (power bomb Y radius)) / 10h (power bomb top boundary)
$94:A0B5 4A          LSR A                  ;|
$94:A0B6 4A          LSR A                  ;|
$94:A0B7 4A          LSR A                  ;|
$94:A0B8 4A          LSR A                  ;|
$94:A0B9 85 1A       STA $1A    [$7E:001A]  ;/
$94:A0BB AD E4 0C    LDA $0CE4  [$7E:0CE4]  ;\
$94:A0BE 18          CLC                    ;|
$94:A0BF 65 14       ADC $14    [$7E:0014]  ;|
$94:A0C1 4A          LSR A                  ;|
$94:A0C2 4A          LSR A                  ;|
$94:A0C3 4A          LSR A                  ;|
$94:A0C4 4A          LSR A                  ;} $1C = min([room height in blocks] - 1, [power bomb explosion Y position] + (power bomb Y radius)) / 10h (power bomb bottom boundary)
$94:A0C5 CD A7 07    CMP $07A7  [$7E:07A7]  ;|
$94:A0C8 90 04       BCC $04    [$A0CE]     ;|
$94:A0CA AD A7 07    LDA $07A7  [$7E:07A7]  ;|
$94:A0CD 3A          DEC A                  ;|
                                            ;|
$94:A0CE 85 1C       STA $1C    [$7E:001C]  ;/
$94:A0D0 A5 15       LDA $15    [$7E:0015]  ;\
$94:A0D2 29 00 FF    AND #$FF00             ;} A high = (power bomb left boundary)
$94:A0D5 05 1A       ORA $1A    [$7E:001A]  ; A low = (power bomb top boundary)
$94:A0D7 48          PHA                    ;\
$94:A0D8 20 F4 A0    JSR $A0F4  [$94:A0F4]  ;} Power bomb explosion block collision detection - row
$94:A0DB 68          PLA                    ;/
$94:A0DC 20 1A A1    JSR $A11A  [$94:A11A]  ; Power bomb explosion block collision detection - column
$94:A0DF A5 15       LDA $15    [$7E:0015]  ;\
$94:A0E1 29 00 FF    AND #$FF00             ;} A high = (power bomb left boundary)
$94:A0E4 05 1C       ORA $1C    [$7E:001C]  ; A low = (power bomb bottom boundary)
$94:A0E6 20 F4 A0    JSR $A0F4  [$94:A0F4]  ; Power bomb explosion block collision detection - row
$94:A0E9 A5 17       LDA $17    [$7E:0017]  ;\
$94:A0EB 29 00 FF    AND #$FF00             ;} A high = (power bomb right boundary)
$94:A0EE 05 1A       ORA $1A    [$7E:001A]  ; A low = (power bomb top boundary)
$94:A0F0 20 1A A1    JSR $A11A  [$94:A11A]  ; Power bomb explosion block collision detection - column
$94:A0F3 60          RTS
}


;;; $A0F4: Power bomb explosion block collision handling - row ;;;
{
;; Parameters:
;;     A low: Origin Y block
;;     A high: Origin X block
;;     $16: Power bomb left boundary
;;     $18: Power bomb right boundary
$94:A0F4 E2 20       SEP #$20               ;\
$94:A0F6 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:A0F9 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A0FC 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A0FF A9 00       LDA #$00               ;|
$94:A101 EB          XBA                    ;} X = ((origin Y block) * [room width in blocks] + (origin X block)) * 2
$94:A102 C2 31       REP #$31               ;|
$94:A104 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:A107 0A          ASL A                  ;|
$94:A108 AA          TAX                    ;/
$94:A109 A5 18       LDA $18    [$7E:0018]  ;\
$94:A10B 38          SEC                    ;|
$94:A10C E5 16       SBC $16    [$7E:0016]  ;} Y = (power bomb right boundary) - (power bomb left boundary)
$94:A10E A8          TAY                    ;/

; LOOP
$94:A10F 5A          PHY                    ;\
$94:A110 20 52 A0    JSR $A052  [$94:A052]  ;} Block bombed reaction
$94:A113 7A          PLY                    ;/
$94:A114 E8          INX                    ;\
$94:A115 E8          INX                    ;} X += 2 (next block)
$94:A116 88          DEY                    ; Decrement Y
$94:A117 10 F6       BPL $F6    [$A10F]     ; If [Y] >= 0: go to LOOP
$94:A119 60          RTS
}


;;; $A11A: Power bomb explosion block collision handling - column ;;;
{
;; Parameters:
;;     A low: Origin Y block
;;     A high: Origin X block
;;     $1A: Power bomb top boundary
;;     $1C: Power bomb bottom boundary
$94:A11A E2 20       SEP #$20               ;\
$94:A11C 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:A11F AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A122 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A125 A9 00       LDA #$00               ;|
$94:A127 EB          XBA                    ;} X = ((origin Y block) * [room width in blocks] + (origin X block)) * 2
$94:A128 C2 31       REP #$31               ;|
$94:A12A 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:A12D 0A          ASL A                  ;|
$94:A12E AA          TAX                    ;/
$94:A12F A5 1C       LDA $1C    [$7E:001C]  ;\
$94:A131 38          SEC                    ;|
$94:A132 E5 1A       SBC $1A    [$7E:001A]  ;} Y = (power bomb bottom boundary) - (power bomb top boundary)
$94:A134 A8          TAY                    ;/

; LOOP
$94:A135 5A          PHY                    ;\
$94:A136 20 52 A0    JSR $A052  [$94:A052]  ;} Block bombed reaction
$94:A139 7A          PLY                    ;/
$94:A13A 8A          TXA                    ;\
$94:A13B 18          CLC                    ;|
$94:A13C 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width] * 2 (next row)
$94:A13F 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$94:A142 AA          TAX                    ;/
$94:A143 88          DEY                    ; Decrement Y
$94:A144 10 EF       BPL $EF    [$A135]     ; If [Y] >= 0: go to LOOP
$94:A146 60          RTS
}


;;; $A147: Block shot reaction - horizontal - slope ;;;
{
;; Parameters:
;;     $1A: Projectile Y span - 1
;;     $1C: Target boundary (left/right depending on sign of projectile velocity)
;;     $1E: (Super) missile flag
;;     $26: Number of blocks left to check - 1
;;     $28: Target number of collisions - 1
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $26: Remaining number of blocks left to check - 1
;;     $28: Remaining target number of collisions - 1
$94:A147 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:A14A BF 02 64 7F LDA $7F6402,x[$7F:6CE9];} A = [block BTS] & 1Fh
$94:A14E 29 1F 00    AND #$001F             ;/
$94:A151 C9 05 00    CMP #$0005             ;\
$94:A154 90 03       BCC $03    [$A159]     ;} If [A] >= 5:
$94:A156 4C 43 A5    JMP $A543  [$94:A543]  ; Go to block shot reaction - horizontal - slope - non-square

$94:A159 4C 6A A6    JMP $A66A  [$94:A66A]  ; Go to block shot reaction - horizontal - slope - square
}


;;; $A15C: Set carry ;;;
{
$94:A15C 38          SEC
$94:A15D 60          RTS
}


;;; $A15E: Block shot reaction - vertical - slope ;;;
{
;; Parameters:
;;     $1A: Projectile Y span - 1
;;     $1C: Target boundary (left/right depending on sign of projectile velocity)
;;     $1E: (Super) missile flag
;;     $26: Number of blocks left to check - 1
;;     $28: Target number of collisions - 1
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $26: Remaining number of blocks left to check - 1
;;     $28: Remaining target number of collisions - 1
$94:A15E AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:A161 BF 02 64 7F LDA $7F6402,x[$7F:6AA5];} A = [block BTS] & 1Fh
$94:A165 29 1F 00    AND #$001F             ;/
$94:A168 C9 05 00    CMP #$0005             ;\
$94:A16B 90 03       BCC $03    [$A170]     ;} If [A] >= 5:
$94:A16D 4C 69 A5    JMP $A569  [$94:A569]  ; Go to block shot reaction - vertical - slope - non-square

$94:A170 4C 1A A7    JMP $A71A  [$94:A71A]  ; Go to block shot reaction - vertical - slope - square
}


;;; $A173: Set carry ;;;
{
$94:A173 38          SEC
$94:A174 60          RTS
}


;;; $A175: Block shot reaction pointers - horizontal ;;;
{
$94:A175             dw 9D59, ;  0: Air
                        A147, ; *1: Slope
                        9D59, ;  2: Spike air
                        9D59, ;  3: Special air
                        9E55, ; *4: Shootable air
                        9411, ; *5: Horizontal extension
                        9D59, ;  6: Unused air
                        9FD6, ; *7: Bombable air
                        9D5B, ;  8: Solid block
                        9D5B, ;  9: Door block
                        9D5B, ;  Ah: Spike block
                        9D5B, ;  Bh: Special block
                        9E73, ; *Ch: Shootable block
                        9447, ; *Dh: Vertical extension
                        9D5B, ;  Eh: Grapple block
                        9FF4  ; *Fh: Bombable block
}


;;; $A195: Block shot reaction pointers - vertical ;;;
{
; Same as horizontal pointers except for slope
$94:A195             dw 9D59, ;  0: Air
                        A15E, ; *1: Slope
                        9D59, ;  2: Spike air
                        9D59, ;  3: Special air
                        9E55, ; *4: Shootable air
                        9411, ; *5: Horizontal extension
                        9D59, ;  6: Unused air
                        9FD6, ; *7: Bombable air
                        9D5B, ;  8: Solid block
                        9D5B, ;  9: Door block
                        9D5B, ;  Ah: Spike block
                        9D5B, ;  Bh: Special block
                        9E73, ; *Ch: Shootable block
                        9447, ; *Dh: Vertical extension
                        9D5B, ;  Eh: Grapple block
                        9FF4  ; *Fh: Bombable block
}


;;; $A1B5: Block shot reaction - horizontal ;;;
{
;; Parameters:
;;     X: Block index
;;     $1A: Projectile Y span - 1
;;     $1C: Target boundary (left/right depending on sign of projectile velocity)
;;     $1E: (Super) missile flag
;;     $26: Number of blocks left to check - 1
;;     $28: Target number of collisions - 1
;; Returns:
;;     Carry: set if collided with block, clear otherwise
;;     $26: Remaining number of blocks left to check - 1
;;     $28: Remaining target number of collisions - 1
$94:A1B5 EC B9 07    CPX $07B9  [$7E:07B9]  ;\
$94:A1B8 B0 1B       BCS $1B    [$A1D5]     ;} If [X] >= [level data size]: return set
$94:A1BA DA          PHX
$94:A1BB 8E C4 0D    STX $0DC4  [$7E:0DC4]  ;\
$94:A1BE 4E C4 0D    LSR $0DC4  [$7E:0DC4]  ;} Current block index = [X] / 2
$94:A1C1 BF 02 00 7F LDA $7F0002,x[$7F:5358];\
$94:A1C5 29 00 F0    AND #$F000             ;|
$94:A1C8 EB          XBA                    ;|
$94:A1C9 4A          LSR A                  ;|
$94:A1CA 4A          LSR A                  ;} Execute [$A175 + (block type) * 2]
$94:A1CB 4A          LSR A                  ;|
$94:A1CC AA          TAX                    ;|
$94:A1CD FC 75 A1    JSR ($A175,x)[$94:9D59];/
$94:A1D0 90 02       BCC $02    [$A1D4]     ; If collision:
$94:A1D2 C6 28       DEC $28    [$7E:0028]  ; Decrement (target number of collisions - 1)

$94:A1D4 FA          PLX

$94:A1D5 60          RTS
}


;;; $A1D6: Block shot reaction - vertical ;;;
{
;; Parameters:
;;     X: Block index
;;     $1A: Projectile X span - 1
;;     $1C: Target boundary (top/bottom depending on sign of projectile velocity)
;;     $1E: (Super) missile flag
;;     $26: Number of blocks left to check - 1
;;     $28: Target number of collisions - 1
;; Returns:
;;     Carry: set if collided with block, clear otherwise
;;     $26: Remaining number of blocks left to check - 1
;;     $28: Remaining target number of collisions - 1
$94:A1D6 EC B9 07    CPX $07B9  [$7E:07B9]  ;\
$94:A1D9 B0 1B       BCS $1B    [$A1F6]     ;} If [X] >= [level data size]: return set
$94:A1DB DA          PHX                    
$94:A1DC 8E C4 0D    STX $0DC4  [$7E:0DC4]  ;\
$94:A1DF 4E C4 0D    LSR $0DC4  [$7E:0DC4]  ;} Current block index = [X] / 2
$94:A1E2 BF 02 00 7F LDA $7F0002,x[$7F:5356];\
$94:A1E6 29 00 F0    AND #$F000             ;|
$94:A1E9 EB          XBA                    ;|
$94:A1EA 4A          LSR A                  ;|
$94:A1EB 4A          LSR A                  ;} Execute [$A195 + (block type) * 2]
$94:A1EC 4A          LSR A                  ;|
$94:A1ED AA          TAX                    ;|
$94:A1EE FC 95 A1    JSR ($A195,x)[$94:9D59];/
$94:A1F1 90 02       BCC $02    [$A1F5]     ; If collision:
$94:A1F3 C6 28       DEC $28    [$7E:0028]  ; Decrement (target number of collisions - 1)

$94:A1F5 FA          PLX

$94:A1F6 60          RTS
}


;;; $A1F7: Calculate projectile Y block span ;;;
{
;; Returns:
;;     $1A: Projectile Y span - 1
;;     $26: Number of blocks left to check - 1
;;     $28: Target number of collisions - 1

; $1A = $26 = $28 = (projectile bottom boundary) / 10h - (projectile top boundary) / 10h
$94:A1F7 BD 78 0B    LDA $0B78,x[$7E:0B78]
$94:A1FA 38          SEC
$94:A1FB FD C8 0B    SBC $0BC8,x[$7E:0BC8]
$94:A1FE 29 F0 FF    AND #$FFF0
$94:A201 85 26       STA $26    [$7E:0026]
$94:A203 BD 78 0B    LDA $0B78,x[$7E:0B78]
$94:A206 18          CLC
$94:A207 7D C8 0B    ADC $0BC8,x[$7E:0BC8]
$94:A20A 3A          DEC A
$94:A20B 38          SEC
$94:A20C E5 26       SBC $26    [$7E:0026]
$94:A20E 4A          LSR A
$94:A20F 4A          LSR A
$94:A210 4A          LSR A
$94:A211 4A          LSR A
$94:A212 85 26       STA $26    [$7E:0026]
$94:A214 85 1A       STA $1A    [$7E:001A]
$94:A216 85 28       STA $28    [$7E:0028]
$94:A218 60          RTS
}


;;; $A219: Calculate projectile X block span ;;;
{
;; Returns:
;;     $1A: Projectile X span - 1
;;     $26: Number of blocks left to check - 1
;;     $28: Target number of collisions - 1

; $1A = $26 = $28 = (projectile right boundary) / 10h - (projectile left boundary) / 10h
$94:A219 BD 64 0B    LDA $0B64,x[$7E:0B64]
$94:A21C 38          SEC
$94:A21D FD B4 0B    SBC $0BB4,x[$7E:0BB4]
$94:A220 29 F0 FF    AND #$FFF0
$94:A223 85 26       STA $26    [$7E:0026]
$94:A225 BD 64 0B    LDA $0B64,x[$7E:0B64]
$94:A228 18          CLC
$94:A229 7D B4 0B    ADC $0BB4,x[$7E:0BB4]
$94:A22C 3A          DEC A
$94:A22D 38          SEC
$94:A22E E5 26       SBC $26    [$7E:0026]
$94:A230 4A          LSR A
$94:A231 4A          LSR A
$94:A232 4A          LSR A
$94:A233 4A          LSR A
$94:A234 85 26       STA $26    [$7E:0026]
$94:A236 85 1A       STA $1A    [$7E:001A]
$94:A238 85 28       STA $28    [$7E:0028]
$94:A23A 60          RTS
}


;;; $A23B: Move beam horizontally - no wave beam ;;;
{
;; Parameters:
;;     X: Projectile index
;; Returns:
;;     Carry: set if collided with block, clear otherwise
$94:A23B 8B          PHB
$94:A23C DA          PHX
$94:A23D 4B          PHK                    ;\
$94:A23E AB          PLB                    ;} DB = $90
$94:A23F 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0 (missile flag)
$94:A241 64 12       STZ $12    [$7E:0012]  ;\
$94:A243 64 14       STZ $14    [$7E:0014]  ;|
$94:A245 BD DC 0B    LDA $0BDC,x[$7E:0BDC]  ;|
$94:A248 10 02       BPL $02    [$A24C]     ;} $14.$12 = ±[projectile X velocity] / 100h
$94:A24A C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$94:A24C 85 13       STA $13    [$7E:0013]  ;/
$94:A24E 20 F7 A1    JSR $A1F7  [$94:A1F7]  ; Calculate projectile Y block span
$94:A251 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$94:A254 38          SEC                    ;|
$94:A255 FD C8 0B    SBC $0BC8,x[$7E:0BC8]  ;|
$94:A258 4A          LSR A                  ;|
$94:A259 4A          LSR A                  ;|
$94:A25A 4A          LSR A                  ;|
$94:A25B 4A          LSR A                  ;} Calculate block index of row of projectile top boundary
$94:A25C E2 20       SEP #$20               ;|
$94:A25E 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:A261 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A264 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A267 C2 20       REP #$20               ;/
$94:A269 BD 8C 0B    LDA $0B8C,x[$7E:0B8C]  ;\
$94:A26C 18          CLC                    ;|
$94:A26D 65 12       ADC $12    [$7E:0012]  ;|
$94:A26F 9D 8C 0B    STA $0B8C,x[$7E:0B8C]  ;|
$94:A272 85 16       STA $16    [$7E:0016]  ;} Projectile X position += [$14].[$12]
$94:A274 BD 64 0B    LDA $0B64,x[$7E:0B64]  ;} $18.$16 = [projectile X position]
$94:A277 65 14       ADC $14    [$7E:0014]  ;|
$94:A279 9D 64 0B    STA $0B64,x[$7E:0B64]  ;|
$94:A27C 85 18       STA $18    [$7E:0018]  ;/
$94:A27E 24 14       BIT $14    [$7E:0014]  ;\
$94:A280 30 07       BMI $07    [$A289]     ;} If [$14] >= 0:
$94:A282 18          CLC                    ;\
$94:A283 7D B4 0B    ADC $0BB4,x[$7E:0BB4]  ;} $1C = (projectile right boundary)
$94:A286 3A          DEC A                  ;/
$94:A287 80 04       BRA $04    [$A28D]

$94:A289 38          SEC                    ;\ Else ([$14] < 0):
$94:A28A FD B4 0B    SBC $0BB4,x[$7E:0BB4]  ;} $1C = (projectile left boundary)

$94:A28D 85 1C       STA $1C    [$7E:001C]
$94:A28F 4A          LSR A                  ;\
$94:A290 4A          LSR A                  ;|
$94:A291 4A          LSR A                  ;|
$94:A292 4A          LSR A                  ;|
$94:A293 18          CLC                    ;} X = ((block index of row of projectile top boundary) + [$1C] / 10h) * 2 (index of top block to check)
$94:A294 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:A297 0A          ASL A                  ;|
$94:A298 AA          TAX                    ;/
$94:A299 A5 26       LDA $26    [$7E:0026]  ;\
$94:A29B C9 10 00    CMP #$0010             ;} If (number of blocks left to check - 1) >= 10h: return carry clear <-- I don't see how this condition could ever be true
$94:A29E 10 1E       BPL $1E    [$A2BE]     ;/
$94:A2A0 A5 1D       LDA $1D    [$7E:001D]  ;\
$94:A2A2 29 FF 00    AND #$00FF             ;|
$94:A2A5 CD A9 07    CMP $07A9  [$7E:07A9]  ;} If [$1C] >= [room width in pixels]: return carry clear
$94:A2A8 10 14       BPL $14    [$A2BE]     ;/

; LOOP
$94:A2AA 20 B5 A1    JSR $A1B5  [$94:A1B5]  ; Block shot reaction - horizontal
$94:A2AD 8A          TXA                    ;\
$94:A2AE 18          CLC                    ;|
$94:A2AF 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$94:A2B2 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$94:A2B5 AA          TAX                    ;/
$94:A2B6 C6 26       DEC $26    [$7E:0026]  ; Decrement $26 (number of blocks left to check - 1)
$94:A2B8 10 F0       BPL $F0    [$A2AA]     ; If [$26] >= 0: go to LOOP
$94:A2BA A5 28       LDA $28    [$7E:0028]  ;\
$94:A2BC 30 04       BMI $04    [$A2C2]     ;} If (target number of collisions - 1) < 0: go to BRANCH_COMPLETE_COLLISION

$94:A2BE FA          PLX
$94:A2BF AB          PLB
$94:A2C0 18          CLC                    ;\
$94:A2C1 6B          RTL                    ;} Return carry clear

; BRANCH_COMPLETE_COLLISION
$94:A2C2 FA          PLX
$94:A2C3 22 06 AE 90 JSL $90AE06[$90:AE06]  ; Kill projectile
$94:A2C7 AB          PLB
$94:A2C8 38          SEC                    ;\
$94:A2C9 6B          RTL                    ;} Return carry set
}


;;; $A2CA: Move beam vertically - no wave beam ;;;
{
;; Parameters:
;;     X: Projectile index
;; Returns:
;;     Carry: set if collided with block, clear otherwise
$94:A2CA 8B          PHB
$94:A2CB DA          PHX
$94:A2CC 4B          PHK                    ;\
$94:A2CD AB          PLB                    ;} DB = $90
$94:A2CE 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0 (missile flag)
$94:A2D0 64 12       STZ $12    [$7E:0012]  ;\
$94:A2D2 64 14       STZ $14    [$7E:0014]  ;|
$94:A2D4 BD F0 0B    LDA $0BF0,x[$7E:0BF0]  ;|
$94:A2D7 10 02       BPL $02    [$A2DB]     ;} $14.$12 = ±[projectile Y velocity] / 100h
$94:A2D9 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$94:A2DB 85 13       STA $13    [$7E:0013]  ;/
$94:A2DD 20 19 A2    JSR $A219  [$94:A219]  ; Calculate projectile X block span
$94:A2E0 BD A0 0B    LDA $0BA0,x[$7E:0BA0]  ;\
$94:A2E3 18          CLC                    ;|
$94:A2E4 65 12       ADC $12    [$7E:0012]  ;|
$94:A2E6 9D A0 0B    STA $0BA0,x[$7E:0BA0]  ;|
$94:A2E9 85 16       STA $16    [$7E:0016]  ;} Projectile Y position += [$14].[$12]
$94:A2EB BD 78 0B    LDA $0B78,x[$7E:0B78]  ;} $18.$16 = [projectile Y position]
$94:A2EE 65 14       ADC $14    [$7E:0014]  ;|
$94:A2F0 9D 78 0B    STA $0B78,x[$7E:0B78]  ;|
$94:A2F3 85 18       STA $18    [$7E:0018]  ;/
$94:A2F5 24 14       BIT $14    [$7E:0014]  ;\
$94:A2F7 30 07       BMI $07    [$A300]     ;} If [$14] >= 0:
$94:A2F9 18          CLC                    ;\
$94:A2FA 7D C8 0B    ADC $0BC8,x[$7E:0BC8]  ;} $1C = (projectile bottom boundary)
$94:A2FD 3A          DEC A                  ;/
$94:A2FE 80 04       BRA $04    [$A304]

$94:A300 38          SEC                    ;\ Else ([$14] < 0):
$94:A301 FD C8 0B    SBC $0BC8,x[$7E:0BC8]  ;} $1C = (projectile top boundary)

$94:A304 85 1C       STA $1C    [$7E:001C]
$94:A306 4A          LSR A                  ;\
$94:A307 4A          LSR A                  ;|
$94:A308 4A          LSR A                  ;|
$94:A309 4A          LSR A                  ;|
$94:A30A E2 20       SEP #$20               ;|
$94:A30C 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:A30F AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A312 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A315 C2 20       REP #$20               ;|
$94:A317 BD 64 0B    LDA $0B64,x[$7E:0B64]  ;|
$94:A31A 38          SEC                    ;} X = ([$1C] / 10h * [room width in blocks] + (projectile left boundary) / 10h) * 2 (index of leftmost block to check)
$94:A31B FD B4 0B    SBC $0BB4,x[$7E:0BB4]  ;|
$94:A31E 4A          LSR A                  ;|
$94:A31F 4A          LSR A                  ;|
$94:A320 4A          LSR A                  ;|
$94:A321 4A          LSR A                  ;|
$94:A322 18          CLC                    ;|
$94:A323 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:A326 0A          ASL A                  ;|
$94:A327 AA          TAX                    ;/
$94:A328 A5 26       LDA $26    [$7E:0026]  ;\
$94:A32A C9 10 00    CMP #$0010             ;} If (number of blocks left to check - 1) >= 10h: return carry clear <-- I don't see how this condition could ever be true
$94:A32D 10 17       BPL $17    [$A346]     ;/
$94:A32F A5 1D       LDA $1D    [$7E:001D]  ;\
$94:A331 29 FF 00    AND #$00FF             ;|
$94:A334 CD AB 07    CMP $07AB  [$7E:07AB]  ;} If [$1C] >= [room height in pixels]: return carry clear
$94:A337 10 0D       BPL $0D    [$A346]     ;/

; LOOP
$94:A339 20 D6 A1    JSR $A1D6  [$94:A1D6]  ; Block shot reaction - vertical
$94:A33C E8          INX                    ;\
$94:A33D E8          INX                    ;} X += 2 (next block)
$94:A33E C6 26       DEC $26    [$7E:0026]  ; Decrement $26 (number of blocks left to check - 1)
$94:A340 10 F7       BPL $F7    [$A339]     ; If [$26] >= 0: go to LOOP
$94:A342 A5 28       LDA $28    [$7E:0028]  ;\
$94:A344 30 04       BMI $04    [$A34A]     ;} If (target number of collisions - 1) < 0: go to BRANCH_COMPLETE_COLLISION

$94:A346 FA          PLX
$94:A347 AB          PLB
$94:A348 18          CLC                    ;\
$94:A349 6B          RTL                    ;} Return carry clear

; BRANCH_COMPLETE_COLLISION
$94:A34A FA          PLX
$94:A34B 22 06 AE 90 JSL $90AE06[$90:AE06]  ; Kill projectile
$94:A34F AB          PLB
$94:A350 38          SEC                    ;\
$94:A351 6B          RTL                    ;} Return carry set
}


;;; $A352: Move beam horizontally - wave beam ;;;
{
;; Parameters:
;;     X: Projectile index
;; Returns:
;;     Carry: Clear. No collision
$94:A352 8B          PHB
$94:A353 DA          PHX
$94:A354 4B          PHK                    ;\
$94:A355 AB          PLB                    ;} DB = $90
$94:A356 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0 (missile flag)
$94:A358 64 12       STZ $12    [$7E:0012]  ;\
$94:A35A 64 14       STZ $14    [$7E:0014]  ;|
$94:A35C BD DC 0B    LDA $0BDC,x[$7E:0BDC]  ;|
$94:A35F 10 02       BPL $02    [$A363]     ;} $14.$12 = ±[projectile X velocity] / 100h
$94:A361 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$94:A363 85 13       STA $13    [$7E:0013]  ;/
$94:A365 20 F7 A1    JSR $A1F7  [$94:A1F7]  ; Calculate projectile Y block span
$94:A368 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$94:A36B 38          SEC                    ;|
$94:A36C FD C8 0B    SBC $0BC8,x[$7E:0BC8]  ;|
$94:A36F 4A          LSR A                  ;|
$94:A370 4A          LSR A                  ;|
$94:A371 4A          LSR A                  ;|
$94:A372 4A          LSR A                  ;} Calculate block index of row of projectile top boundary
$94:A373 E2 20       SEP #$20               ;|
$94:A375 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:A378 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A37B 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A37E C2 20       REP #$20               ;/
$94:A380 BD 8C 0B    LDA $0B8C,x[$7E:0B8C]  ;\
$94:A383 18          CLC                    ;|
$94:A384 65 12       ADC $12    [$7E:0012]  ;|
$94:A386 9D 8C 0B    STA $0B8C,x[$7E:0B8C]  ;|
$94:A389 85 16       STA $16    [$7E:0016]  ;} Projectile X position += [$14].[$12]
$94:A38B BD 64 0B    LDA $0B64,x[$7E:0B64]  ;} $18.$16 = [projectile X position]
$94:A38E 65 14       ADC $14    [$7E:0014]  ;|
$94:A390 9D 64 0B    STA $0B64,x[$7E:0B64]  ;|
$94:A393 85 18       STA $18    [$7E:0018]  ;/
$94:A395 24 14       BIT $14    [$7E:0014]  ;\
$94:A397 30 07       BMI $07    [$A3A0]     ;} If [$14] >= 0:
$94:A399 18          CLC                    ;\
$94:A39A 7D B4 0B    ADC $0BB4,x[$7E:0BB6]  ;} $1C = (projectile right boundary)
$94:A39D 3A          DEC A                  ;/
$94:A39E 80 04       BRA $04    [$A3A4]

$94:A3A0 38          SEC                    ;\ Else ([$14] < 0):
$94:A3A1 FD B4 0B    SBC $0BB4,x[$7E:0BB4]  ;} $1C = (projectile left boundary)

$94:A3A4 85 1C       STA $1C    [$7E:001C]
$94:A3A6 4A          LSR A                  ;\
$94:A3A7 4A          LSR A                  ;|
$94:A3A8 4A          LSR A                  ;|
$94:A3A9 4A          LSR A                  ;|
$94:A3AA 18          CLC                    ;} Y = ((block index of row of projectile top boundary) + [$1C] / 10h) * 2 (index of top block to check)
$94:A3AB 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:A3AE 0A          ASL A                  ;|
$94:A3AF A8          TAY                    ;/
$94:A3B0 A5 26       LDA $26    [$7E:0026]  ;\
$94:A3B2 C9 10 00    CMP #$0010             ;} If (number of blocks left to check - 1) >= 10h: return carry clear <-- I don't see how this condition could ever be true
$94:A3B5 10 29       BPL $29    [$A3E0]     ;/
$94:A3B7 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$94:A3BA EB          XBA                    ;} If [projectile Y position] < 0: return carry clear
$94:A3BB 30 23       BMI $23    [$A3E0]     ;/
$94:A3BD 29 FF 00    AND #$00FF             ;\
$94:A3C0 CD AB 07    CMP $07AB  [$7E:07AB]  ;} If [projectile Y position] >= [room height in pixels]: return carry clear
$94:A3C3 10 1B       BPL $1B    [$A3E0]     ;/
$94:A3C5 A5 1D       LDA $1D    [$7E:001D]  ;\
$94:A3C7 29 FF 00    AND #$00FF             ;|
$94:A3CA CD A9 07    CMP $07A9  [$7E:07A9]  ;} If [$1C] >= [room width in pixels]: return carry clear
$94:A3CD 10 11       BPL $11    [$A3E0]     ;/
$94:A3CF BB          TYX                    ; X = [Y]

; LOOP
$94:A3D0 20 B5 A1    JSR $A1B5  [$94:A1B5]  ; Block shot reaction - horizontal
$94:A3D3 8A          TXA                    ;\
$94:A3D4 18          CLC                    ;|
$94:A3D5 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$94:A3D8 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$94:A3DB AA          TAX                    ;/
$94:A3DC C6 26       DEC $26    [$7E:0026]  ; Decrement $26 (number of blocks left to check - 1)
$94:A3DE 10 F0       BPL $F0    [$A3D0]     ; If [$26] >= 0: go to LOOP

$94:A3E0 FA          PLX
$94:A3E1 AB          PLB
$94:A3E2 18          CLC                    ;\
$94:A3E3 6B          RTL                    ;} Return carry clear
}


;;; $A3E4: Move beam vertically - wave beam ;;;
{
;; Parameters:
;;     X: Projectile index
;; Returns:
;;     Carry: Clear. No collision
$94:A3E4 8B          PHB
$94:A3E5 DA          PHX
$94:A3E6 4B          PHK                    ;\
$94:A3E7 AB          PLB                    ;} DB = $90
$94:A3E8 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0 (missile flag)
$94:A3EA 64 12       STZ $12    [$7E:0012]  ;\
$94:A3EC 64 14       STZ $14    [$7E:0014]  ;|
$94:A3EE BD F0 0B    LDA $0BF0,x[$7E:0BF2]  ;|
$94:A3F1 10 02       BPL $02    [$A3F5]     ;} $14.$12 = ±[projectile Y velocity] / 100h
$94:A3F3 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$94:A3F5 85 13       STA $13    [$7E:0013]  ;/
$94:A3F7 20 19 A2    JSR $A219  [$94:A219]  ; Calculate projectile X block span
$94:A3FA BD A0 0B    LDA $0BA0,x[$7E:0BA2]  ;\
$94:A3FD 18          CLC                    ;|
$94:A3FE 65 12       ADC $12    [$7E:0012]  ;|
$94:A400 9D A0 0B    STA $0BA0,x[$7E:0BA2]  ;|
$94:A403 85 16       STA $16    [$7E:0016]  ;} Projectile Y position += [$14].[$12]
$94:A405 BD 78 0B    LDA $0B78,x[$7E:0B7A]  ;} $18.$16 = [projectile Y position]
$94:A408 65 14       ADC $14    [$7E:0014]  ;|
$94:A40A 9D 78 0B    STA $0B78,x[$7E:0B7A]  ;|
$94:A40D 85 18       STA $18    [$7E:0018]  ;/
$94:A40F 24 14       BIT $14    [$7E:0014]  ;\
$94:A411 30 07       BMI $07    [$A41A]     ;} If [$14] >= 0:
$94:A413 18          CLC                    ;\
$94:A414 7D C8 0B    ADC $0BC8,x[$7E:0BCA]  ;} $1C = (projectile bottom boundary)
$94:A417 3A          DEC A                  ;/
$94:A418 80 04       BRA $04    [$A41E]

$94:A41A 38          SEC                    ;\ Else ([$14] < 0):
$94:A41B FD C8 0B    SBC $0BC8,x[$7E:0BCA]  ;} $1C = (projectile top boundary)

$94:A41E 85 1C       STA $1C    [$7E:001C]
$94:A420 4A          LSR A                  ;\
$94:A421 4A          LSR A                  ;|
$94:A422 4A          LSR A                  ;|
$94:A423 4A          LSR A                  ;|
$94:A424 E2 20       SEP #$20               ;|
$94:A426 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:A429 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A42C 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A42F C2 20       REP #$20               ;|
$94:A431 BD 64 0B    LDA $0B64,x[$7E:0B66]  ;|
$94:A434 38          SEC                    ;} Y = ([$1C] / 10h * [room width in blocks] + (projectile left boundary) / 10h) * 2 (index of leftmost block to check)
$94:A435 FD B4 0B    SBC $0BB4,x[$7E:0BB6]  ;|
$94:A438 4A          LSR A                  ;|
$94:A439 4A          LSR A                  ;|
$94:A43A 4A          LSR A                  ;|
$94:A43B 4A          LSR A                  ;|
$94:A43C 18          CLC                    ;|
$94:A43D 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:A440 0A          ASL A                  ;|
$94:A441 A8          TAY                    ;/
$94:A442 A5 26       LDA $26    [$7E:0026]  ;\
$94:A444 C9 10 00    CMP #$0010             ;} If (number of blocks left to check - 1) >= 10h: return carry clear <-- I don't see how this condition could ever be true
$94:A447 10 22       BPL $22    [$A46B]     ;/
$94:A449 BD 64 0B    LDA $0B64,x[$7E:0B66]  ;\
$94:A44C EB          XBA                    ;} If [projectile X position] < 0: return carry clear
$94:A44D 30 1C       BMI $1C    [$A46B]     ;/
$94:A44F 29 FF 00    AND #$00FF             ;\
$94:A452 CD A9 07    CMP $07A9  [$7E:07A9]  ;} If [projectile X position] >= [room width in pixels]: return carry clear
$94:A455 10 14       BPL $14    [$A46B]     ;/
$94:A457 A5 1D       LDA $1D    [$7E:001D]  ;\
$94:A459 29 FF 00    AND #$00FF             ;|
$94:A45C CD AB 07    CMP $07AB  [$7E:07AB]  ;} If [$1C] >= [room height in pixels]: return carry clear
$94:A45F 10 0A       BPL $0A    [$A46B]     ;/
$94:A461 BB          TYX                    ; X = [Y]

; LOOP
$94:A462 20 D6 A1    JSR $A1D6  [$94:A1D6]  ; Block shot reaction - vertical
$94:A465 E8          INX                    ;\
$94:A466 E8          INX                    ;} X += 2 (next block)
$94:A467 C6 26       DEC $26    [$7E:0026]  ; Decrement $26 (number of blocks left to check - 1)
$94:A469 10 F7       BPL $F7    [$A462]     ; If [$26] >= 0: go to LOOP

$94:A46B FA          PLX
$94:A46C AB          PLB
$94:A46D 18          CLC                    ;\
$94:A46E 6B          RTL                    ;} Return carry clear
}


;;; $A46F: Move (super) missile horizontally ;;;
{
;; Parameters:
;;     X: Projectile index
;; Returns:
;;     Carry: set if collided with block, clear otherwise
$94:A46F 8B          PHB
$94:A470 DA          PHX
$94:A471 4B          PHK                    ;\
$94:A472 AB          PLB                    ;} DB = $90
$94:A473 A9 01 00    LDA #$0001             ;\
$94:A476 85 1E       STA $1E    [$7E:001E]  ;} $1E = 1 (missile flag)
$94:A478 64 26       STZ $26    [$7E:0026]  ; $26 = 0 (number of blocks left to check - 1)
$94:A47A 64 1A       STZ $1A    [$7E:001A]  ; $1A = 0 (projectile Y span - 1)
$94:A47C 64 12       STZ $12    [$7E:0012]  ;\
$94:A47E 64 14       STZ $14    [$7E:0014]  ;|
$94:A480 BD DC 0B    LDA $0BDC,x[$7E:0BDC]  ;|
$94:A483 10 02       BPL $02    [$A487]     ;} $14.$12 = ±[projectile X velocity] / 100h
$94:A485 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$94:A487 85 13       STA $13    [$7E:0013]  ;/
$94:A489 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$94:A48C 4A          LSR A                  ;|
$94:A48D 4A          LSR A                  ;|
$94:A48E 4A          LSR A                  ;|
$94:A48F 4A          LSR A                  ;|
$94:A490 E2 20       SEP #$20               ;} Calculate block index of row of projectile
$94:A492 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:A495 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A498 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A49B C2 20       REP #$20               ;/
$94:A49D BD 8C 0B    LDA $0B8C,x[$7E:0B8C]  ;\
$94:A4A0 18          CLC                    ;|
$94:A4A1 65 12       ADC $12    [$7E:0012]  ;|
$94:A4A3 9D 8C 0B    STA $0B8C,x[$7E:0B8C]  ;|
$94:A4A6 85 16       STA $16    [$7E:0016]  ;} Projectile X position += [$14].[$12]
$94:A4A8 BD 64 0B    LDA $0B64,x[$7E:0B64]  ;} $18.$16 = [projectile X position]
$94:A4AB 65 14       ADC $14    [$7E:0014]  ;|
$94:A4AD 9D 64 0B    STA $0B64,x[$7E:0B64]  ;|
$94:A4B0 85 18       STA $18    [$7E:0018]  ;/
$94:A4B2 85 1C       STA $1C    [$7E:001C]  ; $1C = [projectile X position] (target boundary)
$94:A4B4 4A          LSR A                  ;\
$94:A4B5 4A          LSR A                  ;|
$94:A4B6 4A          LSR A                  ;|
$94:A4B7 4A          LSR A                  ;|
$94:A4B8 18          CLC                    ;} X = ((block index of row of projectile) + [$1C] / 10h) * 2 (index of block to check)
$94:A4B9 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:A4BC 0A          ASL A                  ;|
$94:A4BD AA          TAX                    ;/
$94:A4BE A5 19       LDA $19    [$7E:0019]  ;\
$94:A4C0 29 FF 00    AND #$00FF             ;|
$94:A4C3 CD A9 07    CMP $07A9  [$7E:07A9]  ;} If [$18] >= [room width in pixels]: return carry clear
$94:A4C6 10 05       BPL $05    [$A4CD]     ;/
$94:A4C8 20 B5 A1    JSR $A1B5  [$94:A1B5]  ; Block shot reaction - horizontal
$94:A4CB B0 04       BCS $04    [$A4D1]     ; If collision: go to BRANCH_COLLISION

$94:A4CD FA          PLX
$94:A4CE AB          PLB
$94:A4CF 18          CLC                    ;\
$94:A4D0 6B          RTL                    ;} Return carry clear

; BRANCH_COLLISION
$94:A4D1 FA          PLX
$94:A4D2 22 06 AE 90 JSL $90AE06[$90:AE06]  ; Kill projectile
$94:A4D6 AB          PLB
$94:A4D7 38          SEC                    ;\
$94:A4D8 6B          RTL                    ;} Return carry set
}


;;; $A4D9: Move (super) missile vertically ;;;
{
;; Parameters:
;;     X: Projectile index
;; Returns:
;;     Carry: set if collided with block, clear otherwise
$94:A4D9 8B          PHB
$94:A4DA DA          PHX
$94:A4DB 4B          PHK                    ;\
$94:A4DC AB          PLB                    ;} DB = $90
$94:A4DD A9 01 00    LDA #$0001             ;\
$94:A4E0 85 1E       STA $1E    [$7E:001E]  ;} $1E = 1 (missile flag)
$94:A4E2 64 26       STZ $26    [$7E:0026]  ; $26 = 0 (number of blocks left to check - 1)
$94:A4E4 64 1A       STZ $1A    [$7E:001A]  ; $1A = 0 (projectile X span - 1)
$94:A4E6 64 12       STZ $12    [$7E:0012]  ;\
$94:A4E8 64 14       STZ $14    [$7E:0014]  ;|
$94:A4EA BD F0 0B    LDA $0BF0,x[$7E:0BF0]  ;|
$94:A4ED 10 02       BPL $02    [$A4F1]     ;} $14.$12 = ±[projectile Y velocity] / 100h
$94:A4EF C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$94:A4F1 85 13       STA $13    [$7E:0013]  ;/
$94:A4F3 BD A0 0B    LDA $0BA0,x[$7E:0BA0]  ;\
$94:A4F6 18          CLC                    ;|
$94:A4F7 65 12       ADC $12    [$7E:0012]  ;|
$94:A4F9 9D A0 0B    STA $0BA0,x[$7E:0BA0]  ;|
$94:A4FC 85 16       STA $16    [$7E:0016]  ;} Projectile Y position += [$14].[$12]
$94:A4FE BD 78 0B    LDA $0B78,x[$7E:0B78]  ;} $18.$16 = [projectile Y position]
$94:A501 65 14       ADC $14    [$7E:0014]  ;|
$94:A503 9D 78 0B    STA $0B78,x[$7E:0B78]  ;|
$94:A506 85 18       STA $18    [$7E:0018]  ;/
$94:A508 85 1C       STA $1C    [$7E:001C]  ; $1C = [projectile Y position] (target boundary)
$94:A50A 4A          LSR A                  ;\
$94:A50B 4A          LSR A                  ;|
$94:A50C 4A          LSR A                  ;|
$94:A50D 4A          LSR A                  ;|
$94:A50E E2 20       SEP #$20               ;|
$94:A510 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:A513 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A516 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A519 C2 20       REP #$20               ;|
$94:A51B BD 64 0B    LDA $0B64,x[$7E:0B64]  ;} X = ([$1C] / 10h * [room width in blocks] + [projectile X position] / 10h) * 2 (index of block to check)
$94:A51E 4A          LSR A                  ;|
$94:A51F 4A          LSR A                  ;|
$94:A520 4A          LSR A                  ;|
$94:A521 4A          LSR A                  ;|
$94:A522 18          CLC                    ;|
$94:A523 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:A526 0A          ASL A                  ;|
$94:A527 AA          TAX                    ;/
$94:A528 A5 19       LDA $19    [$7E:0019]  ;\
$94:A52A 29 FF 00    AND #$00FF             ;|
$94:A52D CD AB 07    CMP $07AB  [$7E:07AB]  ;} If [$18] >= [room height in pixels]: return carry clear
$94:A530 10 05       BPL $05    [$A537]     ;/
$94:A532 20 D6 A1    JSR $A1D6  [$94:A1D6]  ; Block shot reaction - vertical
$94:A535 B0 04       BCS $04    [$A53B]     ; If collision: go to BRANCH_COLLISION

$94:A537 FA          PLX
$94:A538 AB          PLB
$94:A539 18          CLC                    ;\
$94:A53A 6B          RTL                    ;} Return carry clear

; BRANCH_COLLISION
$94:A53B FA          PLX
$94:A53C 22 06 AE 90 JSL $90AE06[$90:AE06]  ; Kill projectile
$94:A540 AB          PLB
$94:A541 38          SEC                    ;\
$94:A542 6B          RTL                    ;} Return carry set
}


;;; $A543: Block shot reaction - horizontal - slope - non-square ;;;
{
;; Parameters:
;;     $26: Number of blocks left to check - 1
;;     $28: Target number of collisions - 1
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $26: Remaining number of blocks left to check - 1
;;     $28: Remaining target number of collisions - 1

; Used for spread bomb collision also
$94:A543 C2 20       REP #$20
$94:A545 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ; X = [current block index]
$94:A548 AC DE 0D    LDY $0DDE  [$7E:0DDE]  ; Y = [projectile index]
$94:A54B AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:A54E 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:A551 E2 20       SEP #$20               ;|
$94:A553 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A556 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:A559 C2 20       REP #$20               ;|
$94:A55B B9 78 0B    LDA $0B78,y[$7E:0B78]  ;} If [projectile Y position] / 10h = [current block index] / [room width in blocks] (projectile centre isn't in block): go to block shot reaction - slope - non-square
$94:A55E 4A          LSR A                  ;|
$94:A55F 4A          LSR A                  ;|
$94:A560 4A          LSR A                  ;|
$94:A561 4A          LSR A                  ;|
$94:A562 CD 14 42    CMP $4214  [$7E:4214]  ;|
$94:A565 F0 28       BEQ $28    [$A58F]     ;/
$94:A567 18          CLC                    ;\
$94:A568 60          RTS                    ;} Return carry clear
}


;;; $A569: Block shot reaction - vertical - slope - non-square ;;;
{
;; Parameters:
;;     $26: Number of blocks left to check - 1
;;     $28: Target number of collisions - 1
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $26: Remaining number of blocks left to check - 1
;;     $28: Remaining target number of collisions - 1
$94:A569 C2 20       REP #$20
$94:A56B AE C4 0D    LDX $0DC4  [$7E:0DC4]  ; X = [current block index]
$94:A56E AC DE 0D    LDY $0DDE  [$7E:0DDE]  ; Y = [projectile index]
$94:A571 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:A574 8D 04 42    STA $4204  [$7E:4204]  ;|
$94:A577 E2 20       SEP #$20               ;|
$94:A579 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A57C 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:A57F C2 20       REP #$20               ;|
$94:A581 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;} If [projectile X position] / 10h = [current block index] % [room width in blocks] (projectile centre isn't in block): go to block shot reaction - slope - non-square
$94:A584 4A          LSR A                  ;|
$94:A585 4A          LSR A                  ;|
$94:A586 4A          LSR A                  ;|
$94:A587 4A          LSR A                  ;|
$94:A588 CD 16 42    CMP $4216  [$7E:4216]  ;|
$94:A58B F0 02       BEQ $02    [$A58F]     ;/
$94:A58D 18          CLC                    ;\
$94:A58E 60          RTS                    ;} Return carry clear
}


;;; $A58F: Block shot reaction - slope - non-square ;;;
{
;; Parameters:
;;     X: Block index
;;     $26: Number of blocks left to check - 1
;;     $28: Target number of collisions - 1
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $26: Remaining number of blocks left to check - 1
;;     $28: Remaining target number of collisions - 1

; Used for spread bomb collision also ($26/$28 don't matter in that case)

$94:A58F BF 02 64 7F LDA $7F6402,x[$7F:6AA6];\
$94:A593 29 1F 00    AND #$001F             ;|
$94:A596 0A          ASL A                  ;|
$94:A597 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$94:A598 0A          ASL A                  ;|
$94:A599 0A          ASL A                  ;|
$94:A59A 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:A59D BF 01 64 7F LDA $7F6401,x[$7F:6AA5];\
$94:A5A1 0A          ASL A                  ;} If [block BTS] & 40h = 0:
$94:A5A2 30 05       BMI $05    [$A5A9]     ;/
$94:A5A4 B9 64 0B    LDA $0B64,y[$7E:0B64]  ; A = [projectile X position] % 10h
$94:A5A7 80 06       BRA $06    [$A5AF]

$94:A5A9 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\ Else ([block BTS] & 40h != 0):
$94:A5AC 49 0F 00    EOR #$000F             ;} A = Fh - [projectile X position] % 10h

$94:A5AF 29 0F 00    AND #$000F             ;\
$94:A5B2 18          CLC                    ;|
$94:A5B3 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;} X = [$0DD6] + [A] (slope definition table index)
$94:A5B6 48          PHA                    ;/
$94:A5B7 BF 01 64 7F LDA $7F6401,x[$7F:6AA5];\
$94:A5BB 30 03       BMI $03    [$A5C0]     ;} If [block BTS] & 80h = 0:
$94:A5BD 4C E2 A5    JMP $A5E2  [$94:A5E2]  ; Go to BRANCH_Y_FLIP

$94:A5C0 FA          PLX
$94:A5C1 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$94:A5C4 29 0F 00    AND #$000F             ;|
$94:A5C7 49 0F 00    EOR #$000F             ;} $0DD4 = Fh - [projectile Y position] % 10h
$94:A5CA 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:A5CD BD 2B 8B    LDA $8B2B,x[$94:8C5A]  ; A = [$8B2B + [X]] (slope top Y offset)
$94:A5D0 29 1F 00    AND #$001F
$94:A5D3 CD D4 0D    CMP $0DD4  [$7E:0DD4]  ;\
$94:A5D6 30 04       BMI $04    [$A5DC]     ;} If [A] > [$0DD4]:
$94:A5D8 F0 02       BEQ $02    [$A5DC]     ;/
$94:A5DA 18          CLC                    ;\
$94:A5DB 60          RTS                    ;} Return carry clear

$94:A5DC 64 26       STZ $26    [$7E:0026]  ; (Number of blocks left to check - 1) = 0
$94:A5DE 64 28       STZ $28    [$7E:0028]  ; (Target number of collisions - 1) = 0
$94:A5E0 38          SEC                    ;\
$94:A5E1 60          RTS                    ;} Return carry set

; BRANCH_Y_FLIP
$94:A5E2 FA          PLX
$94:A5E3 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$94:A5E6 29 0F 00    AND #$000F             ;} $0DD4 = [projectile Y position] % 10h
$94:A5E9 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:A5EC BD 2B 8B    LDA $8B2B,x[$94:8C54]  ; A = [$8B2B + [X]] (slope top Y offset)
$94:A5EF 29 1F 00    AND #$001F
$94:A5F2 CD D4 0D    CMP $0DD4  [$7E:0DD4]  ;\
$94:A5F5 30 04       BMI $04    [$A5FB]     ;} If [A] > [$0DD4]:
$94:A5F7 F0 02       BEQ $02    [$A5FB]     ;/
$94:A5F9 18          CLC                    ;\
$94:A5FA 60          RTS                    ;} Return carry clear

$94:A5FB 64 26       STZ $26    [$7E:0026]  ; (Number of blocks left to check - 1) = 0
$94:A5FD 64 28       STZ $28    [$7E:0028]  ; (Target number of collisions - 1) = 0
$94:A5FF 38          SEC                    ;\
$94:A600 60          RTS                    ;} Return carry set
}


;;; $A601: Spread bomb block reaction pointers ;;;
{
$94:A601             dw 9D59, ;  0: Air
                        9D5D, ; *1: Slope
                        9D59, ;  2: Spike air
                        9D59, ;  3: Special air
                        9D5B, ;  4: Shootable air
                        9411, ; *5: Horizontal extension
                        9D59, ;  6: Unused air
                        9D59, ;  7: Bombable air
                        9D5B, ;  8: Solid block
                        9D5B, ;  9: Door block
                        9D5B, ;  Ah: Spike block
                        9D5B, ;  Bh: Special block
                        9D5B, ;  Ch: Shootable block
                        9447, ; *Dh: Vertical extension
                        9D5B, ;  Eh: Grapple block
                        9D5B  ;  Fh: Bombable block
}


;;; $A621: Spread bomb block collision detection ;;;
{
;; Parameters:
;;     X: Projectile index
;; Returns:
;;     Carry: Set if collision detected, clear otherwise
$94:A621 08          PHP
$94:A622 8B          PHB
$94:A623 4B          PHK                    ;\
$94:A624 AB          PLB                    ;} DB = $94
$94:A625 C2 30       REP #$30
$94:A627 BD 64 0B    LDA $0B64,x            ;\
$94:A62A 85 1A       STA $1A    [$7E:001A]  ;} $1A = [bomb X position]
$94:A62C BD 78 0B    LDA $0B78,x            ;\
$94:A62F 85 1C       STA $1C    [$7E:001C]  ;} $1C = [bomb Y position]
$94:A631 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0
$94:A633 64 20       STZ $20    [$7E:0020]  ; $20 = 0
$94:A635 9C C4 0D    STZ $0DC4  [$7E:0DC4]  ; Current block index = 0
$94:A638 DA          PHX                    ;\
$94:A639 20 1D 9C    JSR $9C1D  [$94:9C1D]  ;} Calculate block at ([$1A], [$1C])
$94:A63C FA          PLX                    ;/
$94:A63D BD 7C 0C    LDA $0C7C,x            ;\
$94:A640 D0 05       BNE $05    [$A647]     ;} If [bomb timer] = 0:
$94:A642 20 F4 9C    JSR $9CF4  [$94:9CF4]  ; Bomb explosion block collision handling
$94:A645 80 1B       BRA $1B    [$A662]     ; Return carry clear

$94:A647 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$94:A64A C9 FF FF    CMP #$FFFF             ;} If [current block index] = FFFFh: return carry set
$94:A64D F0 17       BEQ $17    [$A666]     ;/
$94:A64F 0A          ASL A                  ;\
$94:A650 AA          TAX                    ;|
$94:A651 BF 02 00 7F LDA $7F0002,x          ;|
$94:A655 29 00 F0    AND #$F000             ;|
$94:A658 EB          XBA                    ;|
$94:A659 4A          LSR A                  ;} Execute [$A601 + (block type) * 2]
$94:A65A 4A          LSR A                  ;|
$94:A65B 4A          LSR A                  ;|
$94:A65C AA          TAX                    ;|
$94:A65D FC 01 A6    JSR ($A601,x)          ;/
$94:A660 B0 04       BCS $04    [$A666]     ; If carry set: return carry set

$94:A662 AB          PLB
$94:A663 28          PLP
$94:A664 18          CLC                    ;\
$94:A665 6B          RTL                    ;} Return carry clear

$94:A666 AB          PLB
$94:A667 28          PLP
$94:A668 38          SEC
$94:A669 6B          RTL
}


;;; $A66A: Block shot reaction - horizontal - slope - square ;;;
{
;; Parameters:
;;     A: [Block BTS] & 1Fh
;;     X: Block index
;;     $1A: Projectile Y span - 1
;;     $1C: Target boundary (left/right depending on sign of projectile velocity)
;;     $1E: (Super) missile flag
;;     $26: Number of blocks left to check - 1
;; Returns:
;;     Carry: Set if collision, clear otherwise

$94:A66A 0A          ASL A                  ;\
$94:A66B 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$94:A66C 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:A66F BF 01 64 7F LDA $7F6401,x[$7F:6CE8];\
$94:A673 2A          ROL A                  ;|
$94:A674 2A          ROL A                  ;|
$94:A675 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$94:A676 29 03 00    AND #$0003             ;|
$94:A679 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:A67C A5 1C       LDA $1C    [$7E:001C]  ;\
$94:A67E 29 08 00    AND #$0008             ;} A = [$1C] & 8 (is projectile target boundary in right half of block)
$94:A681 4A          LSR A                  ;\
$94:A682 4A          LSR A                  ;|
$94:A683 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 3 (toggle X flip flag if projectile is in right half of block)
$94:A684 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$94:A687 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$94:A68A AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$94:A68B AC DE 0D    LDY $0DDE  [$7E:0DDE]  ; Y = [projectile index]
$94:A68E A5 1E       LDA $1E    [$7E:001E]  ;\
$94:A690 D0 6F       BNE $6F    [$A701]     ;} If (super) missile: go to BRANCH_MISSILE
$94:A692 A5 1A       LDA $1A    [$7E:001A]  ;\
$94:A694 D0 2D       BNE $2D    [$A6C3]     ;} If [$1A] != 0 (projectile spans more than one block): go to BRANCH_MULTI_BLOCK
$94:A696 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$94:A699 38          SEC                    ;|
$94:A69A F9 C8 0B    SBC $0BC8,y[$7E:0BC8]  ;} If (projectile top boundary) & 8 = 0 (projectile top boundary is in top half of block):
$94:A69D 29 08 00    AND #$0008             ;|
$94:A6A0 D0 05       BNE $05    [$A6A7]     ;/
$94:A6A2 BD 53 8E    LDA $8E53,x[$94:8E61]  ;\
$94:A6A5 30 19       BMI $19    [$A6C0]     ;} If [$8E54 + [X]] & 80h != 0 (top half is solid): return carry set

$94:A6A7 8A          TXA                    ;\
$94:A6A8 49 02 00    EOR #$0002             ;} X ^= 2 (toggle Y flip flag)
$94:A6AB AA          TAX                    ;/
$94:A6AC B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$94:A6AF 18          CLC                    ;|
$94:A6B0 79 C8 0B    ADC $0BC8,y[$7E:0BC8]  ;|
$94:A6B3 3A          DEC A                  ;} If (projectile bottom boundary) & 8 != 0 (projectile bottom boundary is in bottom half of block):
$94:A6B4 29 08 00    AND #$0008             ;|
$94:A6B7 F0 05       BEQ $05    [$A6BE]     ;/
$94:A6B9 BD 53 8E    LDA $8E53,x[$94:8E53]  ;\
$94:A6BC 30 02       BMI $02    [$A6C0]     ;} If [$8E54 + [X]] & 80h != 0 (bottom half is solid): return carry set

$94:A6BE 18          CLC                    ;\
$94:A6BF 60          RTS                    ;} Return carry clear

$94:A6C0 4C FF A6    JMP $A6FF  [$94:A6FF]

; BRANCH_MULTI_BLOCK
$94:A6C3 A5 26       LDA $26    [$7E:0026]  ;\
$94:A6C5 D0 14       BNE $14    [$A6DB]     ;} If [$26] = 0 (bottom block check):
$94:A6C7 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$94:A6CA 18          CLC                    ;|
$94:A6CB 79 C8 0B    ADC $0BC8,y[$7E:0BC8]  ;|
$94:A6CE 3A          DEC A                  ;} If (projectile bottom boundary) & 8 != 0 (projectile bottom boundary is in bottom half of block): go to BRANCH_CHECK_BOTH_HALVES
$94:A6CF 29 08 00    AND #$0008             ;|
$94:A6D2 D0 17       BNE $17    [$A6EB]     ;/
$94:A6D4 BD 53 8E    LDA $8E53,x[$94:8E56]  ;\
$94:A6D7 30 23       BMI $23    [$A6FC]     ;} If [$8E54 + [X]] & 80h != 0 (top half is solid): return carry set
$94:A6D9 80 1F       BRA $1F    [$A6FA]     ; Return carry clear

$94:A6DB C5 1A       CMP $1A    [$7E:001A]  ;\
$94:A6DD D0 0C       BNE $0C    [$A6EB]     ;} If [$26] = [$1A] (top block check):
$94:A6DF B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$94:A6E2 38          SEC                    ;|
$94:A6E3 F9 C8 0B    SBC $0BC8,y[$7E:0BC8]  ;} If projectile top boundary is in bottom half: go to BRANCH_CHECK_BOTTOM_HALF
$94:A6E6 29 08 00    AND #$0008             ;|
$94:A6E9 D0 05       BNE $05    [$A6F0]     ;/

; BRANCH_CHECK_BOTH_HALVES
$94:A6EB BD 53 8E    LDA $8E53,x[$94:8E56]  ;\
$94:A6EE 30 0C       BMI $0C    [$A6FC]     ;} If [$8E54 + [X]] & 80h != 0 (top half is solid): return carry set

; BRANCH_CHECK_BOTTOM_HALF
$94:A6F0 8A          TXA                    ;\
$94:A6F1 49 02 00    EOR #$0002             ;|
$94:A6F4 AA          TAX                    ;} If [$8E54 + ([X] ^ 2)] & 80h != 0 (bottom half is solid): return carry set
$94:A6F5 BD 53 8E    LDA $8E53,x[$94:8E5B]  ;|
$94:A6F8 30 02       BMI $02    [$A6FC]     ;/

$94:A6FA 18          CLC                    ;\
$94:A6FB 60          RTS                    ;} Return carry clear

$94:A6FC 4C FF A6    JMP $A6FF  [$94:A6FF]

$94:A6FF 38          SEC
$94:A700 60          RTS

; BRANCH_MISSILE
$94:A701 AC DE 0D    LDY $0DDE  [$7E:0DDE]
$94:A704 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$94:A707 29 08 00    AND #$0008             ;} If [projectile Y position] & 8 != 0 (projectile centre in bottom half of block):
$94:A70A F0 05       BEQ $05    [$A711]     ;/
$94:A70C 8A          TXA                    ;\
$94:A70D 49 02 00    EOR #$0002             ;} X ^= 2 (toggle Y flip flag)
$94:A710 AA          TAX                    ;/

$94:A711 BD 53 8E    LDA $8E53,x[$94:8E54]  ;\
$94:A714 30 02       BMI $02    [$A718]     ;} If [$8E54 + [X]] & 80h != 0: return carry set
$94:A716 18          CLC                    ;\
$94:A717 60          RTS                    ;} Return carry clear

$94:A718 38          SEC
$94:A719 60          RTS
}


;;; $A71A: Block shot reaction - vertical - slope - square ;;;
{
;; Parameters:
;;     A: [Block BTS] & 1Fh
;;     X: Block index
;;     $1A: Projectile X span - 1
;;     $1C: Target boundary (top/bottom depending on sign of projectile velocity)
;;     $1E: (Super) missile flag
;;     $26: Number of blocks left to check - 1
;; Returns:
;;     Carry: Set if collision, clear otherwise

$94:A71A 0A          ASL A                  ;\
$94:A71B 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$94:A71C 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$94:A71F BF 01 64 7F LDA $7F6401,x[$7F:71C5];\
$94:A723 2A          ROL A                  ;|
$94:A724 2A          ROL A                  ;|
$94:A725 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$94:A726 29 03 00    AND #$0003             ;|
$94:A729 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$94:A72C A5 1C       LDA $1C    [$7E:001C]  ;\
$94:A72E 29 08 00    AND #$0008             ;} A = [$1C] & 8 (is projectile target boundary in bottom half of block)
$94:A731 4A          LSR A                  ;\
$94:A732 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 2 (toggle Y flip flag if projectile is in bottom half of block)
$94:A733 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$94:A736 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$94:A739 AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$94:A73A AC DE 0D    LDY $0DDE  [$7E:0DDE]  ; Y = [projectile index]
$94:A73D A5 1E       LDA $1E    [$7E:001E]  ;\
$94:A73F D0 6F       BNE $6F    [$A7B0]     ;} If (super) missile: go to BRANCH_MISSILE
$94:A741 A5 1A       LDA $1A    [$7E:001A]  ;\
$94:A743 D0 2D       BNE $2D    [$A772]     ;} If [$1A] != 0 (projectile spans more than one block): go to BRANCH_MULTI_BLOCK
$94:A745 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$94:A748 38          SEC                    ;|
$94:A749 F9 B4 0B    SBC $0BB4,y[$7E:0BB4]  ;} If (projectile left boundary) & 8 = 0 (projectile left boundary is in left half of block):
$94:A74C 29 08 00    AND #$0008             ;|
$94:A74F D0 05       BNE $05    [$A756]     ;/
$94:A751 BD 53 8E    LDA $8E53,x[$94:8E54]  ;\
$94:A754 30 19       BMI $19    [$A76F]     ;} If [$8E54 + [X]] & 80h != 0 (left half is solid): return carry set

$94:A756 8A          TXA                    ;\
$94:A757 49 01 00    EOR #$0001             ;} X ^= 1 (toggle X flip flag)
$94:A75A AA          TAX                    ;/
$94:A75B B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$94:A75E 18          CLC                    ;|
$94:A75F 79 B4 0B    ADC $0BB4,y[$7E:0BB4]  ;|
$94:A762 3A          DEC A                  ;} If (projectile right boundary) & 8 != 0 (projectile right boundary is in right half of block):
$94:A763 29 08 00    AND #$0008             ;|
$94:A766 F0 05       BEQ $05    [$A76D]     ;/
$94:A768 BD 53 8E    LDA $8E53,x[$94:8E53]  ;\
$94:A76B 30 02       BMI $02    [$A76F]     ;} If [$8E54 + [X]] & 80h != 0 (right half is solid): return carry set
                                            
$94:A76D 18          CLC                    ;\
$94:A76E 60          RTS                    ;} Return carry clear

$94:A76F 4C AE A7    JMP $A7AE  [$94:A7AE]

; BRANCH_MULTI_BLOCK
$94:A772 A5 26       LDA $26    [$7E:0026]  ;\
$94:A774 D0 14       BNE $14    [$A78A]     ;} If [$26] = 0 (rightmost block check):
$94:A776 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$94:A779 18          CLC                    ;|
$94:A77A 79 B4 0B    ADC $0BB4,y[$7E:0BB4]  ;|
$94:A77D 3A          DEC A                  ;} If (projectile right boundary) & 8 != 0 (projectile right boundary is in right half of block): go to BRANCH_CHECK_BOTH_HALVES
$94:A77E 29 08 00    AND #$0008             ;|
$94:A781 D0 17       BNE $17    [$A79A]     ;/
$94:A783 BD 53 8E    LDA $8E53,x[$94:8E5B]  ;\
$94:A786 30 23       BMI $23    [$A7AB]     ;} If [$8E54 + [X]] & 80h != 0 (left half is solid): return carry set
$94:A788 80 1F       BRA $1F    [$A7A9]     ; Return carry clear
                                            
$94:A78A C5 1A       CMP $1A    [$7E:001A]  ;\
$94:A78C D0 0C       BNE $0C    [$A79A]     ;} If [$26] = [$1A] (leftmost block check):
$94:A78E B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$94:A791 38          SEC                    ;|
$94:A792 F9 B4 0B    SBC $0BB4,y[$7E:0BB4]  ;} If projectile left boundary is in left half: go to BRANCH_CHECK_LEFT_HALF
$94:A795 29 08 00    AND #$0008             ;|
$94:A798 D0 05       BNE $05    [$A79F]     ;/

; BRANCH_CHECK_BOTH_HALVES
$94:A79A BD 53 8E    LDA $8E53,x[$94:8E5E]  ;\
$94:A79D 30 0C       BMI $0C    [$A7AB]     ;} If [$8E54 + [X]] & 80h != 0 (left half is solid): return carry set
                                            
; BRANCH_CHECK_LEFT_HALF                    
$94:A79F 8A          TXA                    ;\
$94:A7A0 49 01 00    EOR #$0001             ;|
$94:A7A3 AA          TAX                    ;} If [$8E54 + ([X] ^ 1)] & 80h != 0 (right half is solid): return carry set
$94:A7A4 BD 53 8E    LDA $8E53,x[$94:8E55]  ;|
$94:A7A7 30 02       BMI $02    [$A7AB]     ;/
                                            
$94:A7A9 18          CLC                    ;\
$94:A7AA 60          RTS                    ;} Return carry clear

$94:A7AB 4C AE A7    JMP $A7AE  [$94:A7AE]

$94:A7AE 38          SEC
$94:A7AF 60          RTS

; BRANCH_MISSILE
$94:A7B0 AC DE 0D    LDY $0DDE  [$7E:0DDE]
$94:A7B3 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$94:A7B6 29 08 00    AND #$0008             ;} If [projectile X position] & 8 != 0 (projectile centre in right half of block):
$94:A7B9 F0 05       BEQ $05    [$A7C0]     ;/
$94:A7BB 8A          TXA                    ;\
$94:A7BC 49 01 00    EOR #$0001             ;} X ^= 1 (toggle X flip flag)
$94:A7BF AA          TAX                    ;/
                                            
$94:A7C0 BD 53 8E    LDA $8E53,x[$94:8E53]  ;\
$94:A7C3 30 02       BMI $02    [$A7C7]     ;} If [$8E54 + [X]] & 80h != 0: return carry set
$94:A7C5 18          CLC                    ;\
$94:A7C6 60          RTS                    ;} Return carry clear

$94:A7C7 38          SEC
$94:A7C8 60          RTS
}


;;; $A7C9: Block grapple reaction - air / spike air / special air / unused air ;;;
{
;; Returns:
;;     Carry: Clear. No collision
;;     Overflow: Clear (no effect)
$94:A7C9 C2 40       REP #$40
$94:A7CB 18          CLC
$94:A7CC 60          RTS
}


;;; $A7CD: Block grapple reaction - slope / solid block / door block / special block ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
;;     Overflow: Clear. Cancel grapple beam
$94:A7CD C2 40       REP #$40
$94:A7CF 38          SEC
$94:A7D0 60          RTS
}


;;; $A7D1: Block grapple reaction - grapple block ;;;
{
;; Returns:
;;     Carry/overflow: Clear if BTS >= 80h, otherwise set according to PLM initialisation (always set)

$94:A7D1 A9 00 80    LDA #$8000             ;\
$94:A7D4 1C F4 0C    TRB $0CF4  [$7E:0CF4]  ;} Clear grappling enemy flag
$94:A7D7 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:A7DA BF 01 64 7F LDA $7F6401,x[$7F:646C];|
$94:A7DE EB          XBA                    ;} If [block BTS] & 80h != 0: return carry clear, overflow clear
$94:A7DF 30 0D       BMI $0D    [$A7EE]     ;|
$94:A7E1 29 7F 00    AND #$007F             ;/
$94:A7E4 0A          ASL A                  ;\
$94:A7E5 AA          TAX                    ;|
$94:A7E6 BD F5 A7    LDA $A7F5,x[$94:A7F5]  ;} Spawn PLM [$9EA6 + [block BTS] * 2]
$94:A7E9 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:A7ED 60          RTS                    ; Return
                                            
$94:A7EE 29 7F 00    AND #$007F             ; >_<;
$94:A7F1 C2 40       REP #$40
$94:A7F3 18          CLC
$94:A7F4 60          RTS

$94:A7F5             dw D0D8, D0DC, D0E0, D0D8
}


;;; $A7FD: Block grapple reaction - spike block ;;;
{
;; Returns:
;;     Carry/overflow: Clear if BTS >= 80h, otherwise set according to PLM initialisation
;;         BTS 3h (Draygon's broken turret): Set carry and overflow
;;         Otherwise: Clear carry and overflow

; Spawn PLM for spike block
$94:A7FD AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:A800 BF 01 64 7F LDA $7F6401,x          ;|
$94:A804 EB          XBA                    ;} If [block BTS] & 80h != 0: return carry clear, overflow clear
$94:A805 30 0D       BMI $0D    [$A814]     ;|
$94:A807 29 7F 00    AND #$007F             ;/
$94:A80A 0A          ASL A                  ;\
$94:A80B AA          TAX                    ;|
$94:A80C BD 1B A8    LDA $A81B,x            ;} Spawn PLM [$9EA6 + [block BTS] * 2]
$94:A80F 22 E7 84 84 JSL $8484E7[$84:84E7]  ;/
$94:A813 60          RTS                    ; Return

$94:A814 29 7F 00    AND #$007F             ; >_<;
$94:A817 C2 40       REP #$40
$94:A819 18          CLC
$94:A81A 60          RTS

$94:A81B             dw D0E4, D0E4, D0E4, D0E8, D0E4, D0E4, D0E4, D0E4, D0E4, D0E4, D0E4, D0E4, D0E4, D0E4, D0E4, D0E4
}


;;; $A83B: Block grapple reaction pointers ;;;
{
$94:A83B             dw A7C9, ;  0: Air
                        A7CD, ;  1: Slope
                        A7C9, ;  2: Spike air
                        A7C9, ;  3: Special air
                        9E55, ; *4: Shootable air
                        9411, ; *5: Horizontal extension
                        A7C9, ;  6: Unused air
                        9FD6, ; *7: Bombable air
                        A7CD, ;  8: Solid block
                        A7CD, ;  9: Door block
                        A7FD, ; *Ah: Spike block
                        A7CD, ;  Bh: Special block
                        9E73, ; *Ch: Shootable block
                        9447, ; *Dh: Vertical extension
                        A7D1, ; *Eh: Grapple block
                        9FF4  ; *Fh: Bombable block
}


;;; $A85B: Grapple beam block collision detection ;;;
{
;; Returns:
;;     Carry: Set if collision, otherwise clear
;;     Overflow: If carry set; set if connecting to block, clear if grapple beam cancelled

; Checks the four points given by quarter increments of grapple velocity for block collision
; Grapple is connected if *any* point results in a connection, otherwise grapple cancel is determined by the *last* point

$94:A85B 8B          PHB
$94:A85C 4B          PHK                    ;\
$94:A85D AB          PLB                    ;} DB = $94
$94:A85E AD 22 0D    LDA $0D22  [$7E:0D22]  ;\
$94:A861 8D 83 0D    STA $0D83  [$7E:0D83]  ;|
$94:A864 18          CLC                    ;|
$94:A865 6E 84 0D    ROR $0D84  [$7E:0D84]  ;|
$94:A868 6E 82 0D    ROR $0D82  [$7E:0D82]  ;|
$94:A86B 6E 84 0D    ROR $0D84  [$7E:0D84]  ;} Grapple beam X quarter-velocity = ±[grapple beam extension X velocity] / 4
$94:A86E 6E 82 0D    ROR $0D82  [$7E:0D82]  ;|
$94:A871 AD 22 0D    LDA $0D22  [$7E:0D22]  ;|
$94:A874 10 06       BPL $06    [$A87C]     ;|
$94:A876 A9 C0 FF    LDA #$FFC0             ;|
$94:A879 0C 84 0D    TSB $0D84  [$7E:0D84]  ;/

$94:A87C AD 24 0D    LDA $0D24  [$7E:0D24]  ;\
$94:A87F 8D 87 0D    STA $0D87  [$7E:0D87]  ;|
$94:A882 18          CLC                    ;|
$94:A883 6E 88 0D    ROR $0D88  [$7E:0D88]  ;|
$94:A886 6E 86 0D    ROR $0D86  [$7E:0D86]  ;|
$94:A889 6E 88 0D    ROR $0D88  [$7E:0D88]  ;} Grapple beam Y quarter-velocity = ±[grapple beam extension X velocity] / 4
$94:A88C 6E 86 0D    ROR $0D86  [$7E:0D86]  ;|
$94:A88F AD 24 0D    LDA $0D24  [$7E:0D24]  ;|
$94:A892 10 06       BPL $06    [$A89A]     ;|
$94:A894 A9 C0 FF    LDA #$FFC0             ;|
$94:A897 0C 88 0D    TSB $0D88  [$7E:0D88]  ;/

$94:A89A A9 04 00    LDA #$0004             ;\
$94:A89D 8D 8A 0D    STA $0D8A  [$7E:0D8A]  ;} $0D8A = 4 (loop counter)

; LOOP
$94:A8A0 AD 0E 0D    LDA $0D0E  [$7E:0D0E]  ;\
$94:A8A3 18          CLC                    ;|
$94:A8A4 6D 82 0D    ADC $0D82  [$7E:0D82]  ;|
$94:A8A7 8D 0E 0D    STA $0D0E  [$7E:0D0E]  ;} Grapple beam end X offset += [grapple beam X quarter-velocity]
$94:A8AA AD 10 0D    LDA $0D10  [$7E:0D10]  ;|
$94:A8AD 6D 84 0D    ADC $0D84  [$7E:0D84]  ;|
$94:A8B0 8D 10 0D    STA $0D10  [$7E:0D10]  ;/
$94:A8B3 AD 12 0D    LDA $0D12  [$7E:0D12]  ;\
$94:A8B6 18          CLC                    ;|
$94:A8B7 6D 86 0D    ADC $0D86  [$7E:0D86]  ;|
$94:A8BA 8D 12 0D    STA $0D12  [$7E:0D12]  ;} Grapple beam end Y offset += [grapple beam Y quarter-velocity]
$94:A8BD AD 14 0D    LDA $0D14  [$7E:0D14]  ;|
$94:A8C0 6D 88 0D    ADC $0D88  [$7E:0D88]  ;|
$94:A8C3 8D 14 0D    STA $0D14  [$7E:0D14]  ;/
$94:A8C6 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$94:A8C9 18          CLC                    ;|
$94:A8CA 6D 0E 0D    ADC $0D0E  [$7E:0D0E]  ;|
$94:A8CD 8D 06 0D    STA $0D06  [$7E:0D06]  ;|
$94:A8D0 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} Grapple beam end X position = [Samus X position] + [grapple beam origin X offset] + [grapple beam end X offset]
$94:A8D3 6D 10 0D    ADC $0D10  [$7E:0D10]  ;|
$94:A8D6 18          CLC                    ;|
$94:A8D7 6D 02 0D    ADC $0D02  [$7E:0D02]  ;|
$94:A8DA 8D 08 0D    STA $0D08  [$7E:0D08]  ;/
$94:A8DD AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$94:A8E0 18          CLC                    ;|
$94:A8E1 6D 12 0D    ADC $0D12  [$7E:0D12]  ;|
$94:A8E4 8D 0A 0D    STA $0D0A  [$7E:0D0A]  ;|
$94:A8E7 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} Grapple beam end Y position = [Samus Y position] + [grapple beam origin Y offset] + [grapple beam end Y offset]
$94:A8EA 6D 14 0D    ADC $0D14  [$7E:0D14]  ;|
$94:A8ED 18          CLC                    ;|
$94:A8EE 6D 04 0D    ADC $0D04  [$7E:0D04]  ;|
$94:A8F1 8D 0C 0D    STA $0D0C  [$7E:0D0C]  ;/
$94:A8F4 22 1F A9 94 JSL $94A91F[$94:A91F]  ; Block grapple reaction
$94:A8F8 50 1E       BVC $1E    [$A918]     ; If overflow set (connect to block):
$94:A8FA 90 1C       BCC $1C    [$A918]     ; If collision:
$94:A8FC 08          PHP
$94:A8FD AD 08 0D    LDA $0D08  [$7E:0D08]  ;\
$94:A900 29 F0 FF    AND #$FFF0             ;|
$94:A903 09 08 00    ORA #$0008             ;} Grapple beam end X position = [grapple beam end X position] rounded to centre of 16x16 block
$94:A906 8D 08 0D    STA $0D08  [$7E:0D08]  ;/
$94:A909 AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;\
$94:A90C 29 F0 FF    AND #$FFF0             ;|
$94:A90F 09 08 00    ORA #$0008             ;} Grapple beam end Y position = [grapple beam end Y position] rounded to centre of 16x16 block
$94:A912 8D 0C 0D    STA $0D0C  [$7E:0D0C]  ;/
$94:A915 28          PLP
$94:A916 AB          PLB
$94:A917 6B          RTL                    ; Return carry set, overflow set

$94:A918 CE 8A 0D    DEC $0D8A  [$7E:0D8A]  ; Decrement $0D8A
$94:A91B D0 83       BNE $83    [$A8A0]     ; If [$0D8A] != 0: go to LOOP
$94:A91D AB          PLB
$94:A91E 6B          RTL                    ; Return result of last call to $A91F
}


;;; $A91F: Block grapple reaction ;;;
{
;; Returns:
;;     Carry: Set if collision, otherwise clear
;;     Overflow: If carry set; set if connecting to block, clear if grapple beam cancelled
$94:A91F 8B          PHB
$94:A920 4B          PHK                    ;\
$94:A921 AB          PLB                    ;} DB = $94
$94:A922 AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;\
$94:A925 4A          LSR A                  ;|
$94:A926 4A          LSR A                  ;|
$94:A927 4A          LSR A                  ;|
$94:A928 4A          LSR A                  ;|
$94:A929 E2 20       SEP #$20               ;|
$94:A92B 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:A92E AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:A931 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A934 C2 20       REP #$20               ;} Current block index = [grapple beam end Y position] / 10h * [room width in blocks] + [grapple beam end X position] / 10h
$94:A936 AD 08 0D    LDA $0D08  [$7E:0D08]  ;|
$94:A939 4A          LSR A                  ;|
$94:A93A 4A          LSR A                  ;|
$94:A93B 4A          LSR A                  ;|
$94:A93C 4A          LSR A                  ;|
$94:A93D 18          CLC                    ;|
$94:A93E 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:A941 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:A944 0A          ASL A                  ;\
$94:A945 AA          TAX                    ;|
$94:A946 BF 02 00 7F LDA $7F0002,x[$7F:0192];|
$94:A94A 29 00 F0    AND #$F000             ;|
$94:A94D EB          XBA                    ;|
$94:A94E 4A          LSR A                  ;} Execute [$A83B + (block type) * 2]
$94:A94F 4A          LSR A                  ;|
$94:A950 4A          LSR A                  ;|
$94:A951 AA          TAX                    ;|
$94:A952 FC 3B A8    JSR ($A83B,x)[$94:A7C9];/
$94:A955 AB          PLB
$94:A956 6B          RTL
}
}


;;; $A957..AF86: Grapple swing movement ;;;
{
;;; $A957: Calculate position from grapple beam end with distance and angle ;;;
{
;; Parameters:
;;     $0D82: Grapple beam end angle * 2
;;     $0D84: Distance from grapple beam end
;; Returns:
;;     $0D90: X position
;;     $0D92: Y position
;;     $0D94: X block
;;     $0D96: Y block

$94:A957 AE 82 0D    LDX $0D82  [$7E:0D82]  ; X = (grapple beam end angle) * 2
$94:A95A AD F4 0C    LDA $0CF4  [$7E:0CF4]  ;\
$94:A95D 30 3A       BMI $3A    [$A999]     ;} If grappling enemy: go to BRANCH_GRAPPLING_ENEMY
$94:A95F BF 43 B4 A0 LDA $A0B443,x[$A0:B56D];\
$94:A963 30 0B       BMI $0B    [$A970]     ;} If (grapple beam end angle) <= 80h:
$94:A965 AD 08 0D    LDA $0D08  [$7E:0D08]  ;\
$94:A968 29 F0 FF    AND #$FFF0             ;} Grapple beam end X position = [grapple beam end X position] rounded to pixel 8 of 16x16 block
$94:A96B 09 08 00    ORA #$0008             ;/
$94:A96E 80 09       BRA $09    [$A979]

$94:A970 AD 08 0D    LDA $0D08  [$7E:0D08]  ;\ Else ((grapple beam end angle) > 80h):
$94:A973 29 F0 FF    AND #$FFF0             ;} Grapple beam end X position = [grapple beam end X position] rounded to pixel 7 of 16x16 block
$94:A976 09 07 00    ORA #$0007             ;/

$94:A979 8D 08 0D    STA $0D08  [$7E:0D08]
$94:A97C BF C3 B3 A0 LDA $A0B3C3,x[$A0:B4ED];\
$94:A980 30 0B       BMI $0B    [$A98D]     ;} If 40h <= (grapple beam end angle) <= C0h:
$94:A982 AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;\
$94:A985 29 F0 FF    AND #$FFF0             ;} Grapple beam end Y position = [grapple beam end Y position] rounded to pixel 8 of 16x16 block
$94:A988 09 08 00    ORA #$0008             ;/
$94:A98B 80 09       BRA $09    [$A996]     
                                            
$94:A98D AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;\ Else (not 40h <= (grapple beam end angle) <= C0h):
$94:A990 29 F0 FF    AND #$FFF0             ;} Grapple beam end Y position = [grapple beam end Y position] rounded to pixel 7 of 16x16 block
$94:A993 09 07 00    ORA #$0007             ;/

$94:A996 8D 0C 0D    STA $0D0C  [$7E:0D0C]

; BRANCH_GRAPPLING_ENEMY
$94:A999 E2 20       SEP #$20               ;\
$94:A99B AD 84 0D    LDA $0D84  [$7E:0D84]  ;|
$94:A99E 8D 02 42    STA $4202  [$7E:4202]  ;} Multiplicand = [distance from grapple beam end]
$94:A9A1 C2 20       REP #$20               ;/
$94:A9A3 BF 43 B4 A0 LDA $A0B443,x[$A0:B56D];\
$94:A9A7 30 24       BMI $24    [$A9CD]     ;|
$94:A9A9 C9 00 01    CMP #$0100             ;|
$94:A9AC D0 09       BNE $09    [$A9B7]     ;|
$94:A9AE AD 08 0D    LDA $0D08  [$7E:0D08]  ;|
$94:A9B1 18          CLC                    ;|
$94:A9B2 6D 84 0D    ADC $0D84  [$7E:0D84]  ;|
$94:A9B5 80 3F       BRA $3F    [$A9F6]     ;|
                                            ;|
$94:A9B7 E2 20       SEP #$20               ;|
$94:A9B9 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A9BC C2 20       REP #$20               ;|
$94:A9BE EA          NOP                    ;|
$94:A9BF EA          NOP                    ;|
$94:A9C0 AD 16 42    LDA $4216  [$7E:4216]  ;|
$94:A9C3 29 00 FF    AND #$FF00             ;|
$94:A9C6 EB          XBA                    ;|
$94:A9C7 18          CLC                    ;|
$94:A9C8 6D 08 0D    ADC $0D08  [$7E:0D08]  ;|
$94:A9CB 80 29       BRA $29    [$A9F6]     ;|
                                            ;|
$94:A9CD C9 00 FF    CMP #$FF00             ;|
$94:A9D0 D0 09       BNE $09    [$A9DB]     ;} $0D90 = [grapple beam end X position] + [distance from grapple beam end] * sin((grapple beam end angle) * pi / 80h)
$94:A9D2 AD 08 0D    LDA $0D08  [$7E:0D08]  ;|
$94:A9D5 38          SEC                    ;|
$94:A9D6 ED 84 0D    SBC $0D84  [$7E:0D84]  ;|
$94:A9D9 80 1B       BRA $1B    [$A9F6]     ;|
                                            ;|
$94:A9DB E2 20       SEP #$20               ;|
$94:A9DD 49 FF       EOR #$FF               ;|
$94:A9DF 1A          INC A                  ;|
$94:A9E0 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:A9E3 C2 20       REP #$20               ;|
$94:A9E5 EA          NOP                    ;|
$94:A9E6 EA          NOP                    ;|
$94:A9E7 AD 16 42    LDA $4216  [$7E:4216]  ;|
$94:A9EA 29 00 FF    AND #$FF00             ;|
$94:A9ED EB          XBA                    ;|
$94:A9EE 49 FF FF    EOR #$FFFF             ;|
$94:A9F1 1A          INC A                  ;|
$94:A9F2 18          CLC                    ;|
$94:A9F3 6D 08 0D    ADC $0D08  [$7E:0D08]  ;|
                                            ;|
$94:A9F6 8D 90 0D    STA $0D90  [$7E:0D90]  ;/
$94:A9F9 4A          LSR A                  ;\
$94:A9FA 4A          LSR A                  ;|
$94:A9FB 4A          LSR A                  ;|
$94:A9FC 4A          LSR A                  ;} $0D94 = [$0D90] / 10h
$94:A9FD 29 FF 00    AND #$00FF             ;|
$94:AA00 8D 94 0D    STA $0D94  [$7E:0D94]  ;/
$94:AA03 BF C3 B3 A0 LDA $A0B3C3,x[$A0:B4ED];\
$94:AA07 30 24       BMI $24    [$AA2D]     ;|
$94:AA09 C9 00 01    CMP #$0100             ;|
$94:AA0C D0 09       BNE $09    [$AA17]     ;|
$94:AA0E AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;|
$94:AA11 18          CLC                    ;|
$94:AA12 6D 84 0D    ADC $0D84  [$7E:0D84]  ;|
$94:AA15 80 3F       BRA $3F    [$AA56]     ;|
                                            ;|
$94:AA17 E2 20       SEP #$20               ;|
$94:AA19 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:AA1C C2 20       REP #$20               ;|
$94:AA1E EA          NOP                    ;|
$94:AA1F EA          NOP                    ;|
$94:AA20 AD 16 42    LDA $4216  [$7E:4216]  ;|
$94:AA23 29 00 FF    AND #$FF00             ;|
$94:AA26 EB          XBA                    ;|
$94:AA27 18          CLC                    ;|
$94:AA28 6D 0C 0D    ADC $0D0C  [$7E:0D0C]  ;|
$94:AA2B 80 29       BRA $29    [$AA56]     ;|
                                            ;|
$94:AA2D C9 00 FF    CMP #$FF00             ;|
$94:AA30 D0 09       BNE $09    [$AA3B]     ;} $0D92 = [grapple beam end Y position] + [distance from grapple beam end] * -cos((grapple beam end angle) * pi / 80h)
$94:AA32 AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;|
$94:AA35 38          SEC                    ;|
$94:AA36 ED 84 0D    SBC $0D84  [$7E:0D84]  ;|
$94:AA39 80 1B       BRA $1B    [$AA56]     ;|
                                            ;|
$94:AA3B E2 20       SEP #$20               ;|
$94:AA3D 49 FF       EOR #$FF               ;|
$94:AA3F 1A          INC A                  ;|
$94:AA40 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:AA43 C2 20       REP #$20               ;|
$94:AA45 EA          NOP                    ;|
$94:AA46 EA          NOP                    ;|
$94:AA47 AD 16 42    LDA $4216  [$7E:4216]  ;|
$94:AA4A 29 00 FF    AND #$FF00             ;|
$94:AA4D EB          XBA                    ;|
$94:AA4E 49 FF FF    EOR #$FFFF             ;|
$94:AA51 1A          INC A                  ;|
$94:AA52 18          CLC                    ;|
$94:AA53 6D 0C 0D    ADC $0D0C  [$7E:0D0C]  ;|
                                            ;|
$94:AA56 8D 92 0D    STA $0D92  [$7E:0D92]  ;/
$94:AA59 4A          LSR A                  ;\
$94:AA5A 4A          LSR A                  ;|
$94:AA5B 4A          LSR A                  ;|
$94:AA5C 4A          LSR A                  ;} $0D96 = [$0D92] / 10h
$94:AA5D 29 FF 00    AND #$00FF             ;|
$94:AA60 8D 96 0D    STA $0D96  [$7E:0D96]  ;/
$94:AA63 60          RTS
}


;;; $AA64: Grapple swing collision reaction ;;;
{
;; Parameters:
;;     $0D94: X block
;;     $0D96: Y block
;; Returns:
;;     Carry: set if collision, clear otherwise
$94:AA64 E2 20       SEP #$20
$94:AA66 AD 96 0D    LDA $0D96  [$7E:0D96]  ;\
$94:AA69 8D 02 42    STA $4202  [$7E:4202]  ;|
$94:AA6C AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:AA6F 8D 03 42    STA $4203  [$7E:4203]  ;|
$94:AA72 C2 21       REP #$21               ;} Current block index = [$0D96] * [room width in blocks] + [$0D94]
$94:AA74 AD 94 0D    LDA $0D94  [$7E:0D94]  ;|
$94:AA77 6D 16 42    ADC $4216  [$7E:4216]  ;|
$94:AA7A 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:AA7D 0A          ASL A                  ;\
$94:AA7E AA          TAX                    ;|
$94:AA7F BF 02 00 7F LDA $7F0002,x[$7F:01F4];|
$94:AA83 29 00 F0    AND #$F000             ;|
$94:AA86 48          PHA                    ;|
$94:AA87 DA          PHX                    ;|
$94:AA88 EB          XBA                    ;} Execute [$AB90 + (block type) * 2]
$94:AA89 4A          LSR A                  ;|
$94:AA8A 4A          LSR A                  ;|
$94:AA8B 4A          LSR A                  ;|
$94:AA8C AA          TAX                    ;|
$94:AA8D FC 90 AB    JSR ($AB90,x)[$94:AA9A];/
$94:AA90 B0 04       BCS $04    [$AA96]     ; If collision: return carry set
$94:AA92 FA          PLX
$94:AA93 68          PLA
$94:AA94 18          CLC                    ;\
$94:AA95 60          RTS                    ;} Return carry clear

$94:AA96 FA          PLX
$94:AA97 68          PLA
$94:AA98 38          SEC
$94:AA99 60          RTS
}


;;; $AA9A: Clear carry ;;;
{
$94:AA9A 18          CLC
$94:AA9B 60          RTS
}


;;; $AA9C: Set carry ;;;
{
$94:AA9C 38          SEC
$94:AA9D 60          RTS
}


;;; $AA9E: Grapple swing collision reaction - spike air ;;;
{
;; Returns:
;;     Carry: Clear. No collision

; There's really no reason to have this reaction, the spike air inside reaction does this damage anyway
; Although you can set grapple swing specific damage here if you want...
$94:AA9E AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$94:AAA1 D0 32       BNE $32    [$AAD5]     ;} If [Samus invincibility timer] = 0:
$94:AAA3 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:AAA6 BF 02 64 7F LDA $7F6402,x          ;} If (BTS of one block right) & 80h = 0:
$94:AAAA 30 29       BMI $29    [$AAD5]     ;/
$94:AAAC 0A          ASL A                  ;\
$94:AAAD AA          TAX                    ;} X = [block BTS] * 2
$94:AAAE BD D7 AA    LDA $AAD7,x            ;\
$94:AAB1 1D F7 AA    ORA $AAF7,x            ;} If [$AAF7 + [X]] != 0:
$94:AAB4 F0 1F       BEQ $1F    [$AAD5]     ;/
$94:AAB6 AD 4E 0A    LDA $0A4E  [$7E:0A4E]  ;\
$94:AAB9 18          CLC                    ;|
$94:AABA 7D D7 AA    ADC $AAD7,x            ;} >_<;
$94:AABD 8D 4E 0A    STA $0A4E  [$7E:0A4E]  ;/
$94:AAC0 AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$94:AAC3 7D F7 AA    ADC $AAF7,x            ;} Periodic damage += [$AAF7 + [X]]
$94:AAC6 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$94:AAC9 A9 3C 00    LDA #$003C             ;\
$94:AACC 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 3Ch
$94:AACF A9 0A 00    LDA #$000A             ;\
$94:AAD2 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = Ah
                                            
$94:AAD5 18          CLC                    ;\
$94:AAD6 60          RTS                    ;} Return carry clear

$94:AAD7             dw 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
$94:AAF7             dw 0000, 0000, 0010, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $AB17: Grapple swing collision reaction - spike block ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
$94:AB17 AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$94:AB1A D0 32       BNE $32    [$AB4E]     ;} If [Samus invincibility timer] = 0:
$94:AB1C AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$94:AB1F BF 02 64 7F LDA $7F6402,x          ;} If (BTS of one block right) & 80h = 0:
$94:AB23 30 29       BMI $29    [$AB4E]     ;/
$94:AB25 0A          ASL A                  ;\
$94:AB26 AA          TAX                    ;} X = [block BTS] * 2
$94:AB27 BD 50 AB    LDA $AB50,x            ;\
$94:AB2A 1D 70 AB    ORA $AB70,x            ;} If [$AB70 + [X]] != 0:
$94:AB2D F0 1F       BEQ $1F    [$AB4E]     ;/
$94:AB2F AD 4E 0A    LDA $0A4E  [$7E:0A4E]  ;\
$94:AB32 18          CLC                    ;|
$94:AB33 7D 50 AB    ADC $AB50,x            ;} >_<;
$94:AB36 8D 4E 0A    STA $0A4E  [$7E:0A4E]  ;/
$94:AB39 AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$94:AB3C 7D 70 AB    ADC $AB70,x            ;} Periodic damage += [$AB70 + [X]]
$94:AB3F 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$94:AB42 A9 3C 00    LDA #$003C             ;\
$94:AB45 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 3Ch
$94:AB48 A9 0A 00    LDA #$000A             ;\
$94:AB4B 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = Ah

$94:AB4E 38          SEC                    ;\
$94:AB4F 60          RTS                    ;} Return carry set

$94:AB50             dw 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
$94:AB70             dw 003C, 0010, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $AB90: Grapple swing collision reaction pointers ;;;
{
$94:AB90             dw AA9A, ;  0: Air
                        AA9C, ;  1: Slope
                        AA9E, ; *2: Spike air
                        AA9A, ;  3: Special air
                        AA9A, ;  4: Shootable air
                        9411, ; *5: Horizontal extension
                        AA9A, ;  6: Unused air
                        AA9A, ;  7: Bombable air
                        AA9C, ;  8: Solid block
                        AA9C, ;  9: Door block
                        AB17, ; *Ah: Spike block
                        AA9C, ;  Bh: Special block
                        AA9C, ;  Ch: Shootable block
                        9447, ; *Dh: Vertical extension
                        AA9C, ;  Eh: Grapple block
                        AA9C  ;  Fh: Bombable block
}


;;; $ABB0: Grapple swing collision reaction ;;;
{
; Clone of $AA64
$94:ABB0 E2 20       SEP #$20
$94:ABB2 AD 96 0D    LDA $0D96  [$7E:0D96]
$94:ABB5 8D 02 42    STA $4202  [$7E:4202]
$94:ABB8 AD A5 07    LDA $07A5  [$7E:07A5]
$94:ABBB 8D 03 42    STA $4203  [$7E:4203]
$94:ABBE C2 21       REP #$21
$94:ABC0 AD 94 0D    LDA $0D94  [$7E:0D94]
$94:ABC3 6D 16 42    ADC $4216  [$7E:4216]
$94:ABC6 8D C4 0D    STA $0DC4  [$7E:0DC4]
$94:ABC9 0A          ASL A
$94:ABCA AA          TAX
$94:ABCB BF 02 00 7F LDA $7F0002,x[$7F:01F6]
$94:ABCF 29 00 F0    AND #$F000
$94:ABD2 48          PHA
$94:ABD3 DA          PHX
$94:ABD4 EB          XBA
$94:ABD5 4A          LSR A
$94:ABD6 4A          LSR A
$94:ABD7 4A          LSR A
$94:ABD8 AA          TAX
$94:ABD9 FC 90 AB    JSR ($AB90,x)[$94:AA9A]
$94:ABDC B0 04       BCS $04    [$ABE2]
$94:ABDE FA          PLX
$94:ABDF 68          PLA
$94:ABE0 18          CLC
$94:ABE1 60          RTS

$94:ABE2 FA          PLX
$94:ABE3 68          PLA
$94:ABE4 38          SEC
$94:ABE5 60          RTS
}


;;; $ABE6: Grapple swing collision detection due to swinging ;;;
{
;; Returns:
;;     Carry: set if collision, clear otherwise
;;     $0D98: Distance of grapple swing collision from Samus' feet. Unit 8px

; Checks 6(!) points along the 48px line projecting 8px beyond the grapple beam start position

$94:ABE6 A9 06 00    LDA #$0006             ;\
$94:ABE9 8D 98 0D    STA $0D98  [$7E:0D98]  ;} Distance of grapple swing collision from Samus' feet = 6
$94:ABEC A9 08 00    LDA #$0008             ;\
$94:ABEF 18          CLC                    ;|
$94:ABF0 6D FE 0C    ADC $0CFE  [$7E:0CFE]  ;} $0D84 = [grapple beam length] + 8 (distance from grapple beam end)
$94:ABF3 8D 84 0D    STA $0D84  [$7E:0D84]  ;/

; LOOP
$94:ABF6 20 57 A9    JSR $A957  [$94:A957]  ; Calculate position from grapple beam end with distance and angle
$94:ABF9 20 B0 AB    JSR $ABB0  [$94:ABB0]  ; Grapple swing collision reaction
$94:ABFC B0 11       BCS $11    [$AC0F]     ; If collision: return carry set
$94:ABFE AD 84 0D    LDA $0D84  [$7E:0D84]  ;\
$94:AC01 18          CLC                    ;|
$94:AC02 69 08 00    ADC #$0008             ;} (Distance from grapple beam end) += 8
$94:AC05 8D 84 0D    STA $0D84  [$7E:0D84]  ;/
$94:AC08 CE 98 0D    DEC $0D98  [$7E:0D98]  ; Decrement remaining number of blocks to check
$94:AC0B D0 E9       BNE $E9    [$ABF6]     ; If [remaining number of blocks to check] != 0: go to LOOP
$94:AC0D 18          CLC                    ;\
$94:AC0E 60          RTS                    ;} Return carry clear

$94:AC0F EA          NOP                    ; Wild NOP appears!
$94:AC10 60          RTS
}


;;; $AC11: Update grapple beam start position during grapple swinging ;;;
{
$94:AC11 AD FB 0C    LDA $0CFB  [$7E:0CFB]  ;\
$94:AC14 29 FF 00    AND #$00FF             ;|
$94:AC17 0A          ASL A                  ;} $0D82 = [grapple beam end angle] / 100h * 2
$94:AC18 8D 82 0D    STA $0D82  [$7E:0D82]  ;/
$94:AC1B AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$94:AC1E 8D 84 0D    STA $0D84  [$7E:0D84]  ;} $0D84 = [grapple beam length]
$94:AC21 20 57 A9    JSR $A957  [$94:A957]  ; Calculate position from grapple beam end with distance and angle
$94:AC24 AD 90 0D    LDA $0D90  [$7E:0D90]  ;\
$94:AC27 8D 16 0D    STA $0D16  [$7E:0D16]  ;} Grapple beam start X position = [$0D90]
$94:AC2A AD 92 0D    LDA $0D92  [$7E:0D92]  ;\
$94:AC2D 8D 18 0D    STA $0D18  [$7E:0D18]  ;} Grapple beam start Y position = [$0D92]
$94:AC30 6B          RTL
}


;;; $AC31: Handle grapple beam length change ;;;
{
$94:AC31 8B          PHB
$94:AC32 4B          PHK                    ;\
$94:AC33 AB          PLB                    ;} DB = $94
$94:AC34 AD 00 0D    LDA $0D00  [$7E:0D00]  ;\
$94:AC37 D0 03       BNE $03    [$AC3C]     ;} If [grapple beam length delta] = 0:
$94:AC39 4C FB AC    JMP $ACFB  [$94:ACFB]  ; Return carry clear

$94:AC3C 30 03       BMI $03    [$AC41]     ; If [grapple beam length delta] > 0:
$94:AC3E 4C 9E AC    JMP $AC9E  [$94:AC9E]  ; Go to BRANCH_INCREASE_LENGTH

$94:AC41 AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$94:AC44 18          CLC                    ;} Target grapple beam length = [grapple beam length] + [grapple beam length delta]
$94:AC45 6D 00 0D    ADC $0D00  [$7E:0D00]  ;/
$94:AC48 C9 08 00    CMP #$0008             ;\
$94:AC4B B0 06       BCS $06    [$AC53]     ;} If [target grapple beam length] < 8:
$94:AC4D 9C 00 0D    STZ $0D00  [$7E:0D00]  ; Grapple beam length delta = 0
$94:AC50 A9 08 00    LDA #$0008             ; Target grapple beam length = 8

$94:AC53 8D 8C 0D    STA $0D8C  [$7E:0D8C]
$94:AC56 A9 08 00    LDA #$0008             ;\
$94:AC59 8D 8E 0D    STA $0D8E  [$7E:0D8E]  ;} Samus front boundary offset from grapple beam start = 8
$94:AC5C AD FB 0C    LDA $0CFB  [$7E:0CFB]  ;\
$94:AC5F 29 FF 00    AND #$00FF             ;|
$94:AC62 0A          ASL A                  ;} $0D82 = [grapple beam end angle] / 100h * 2
$94:AC63 8D 82 0D    STA $0D82  [$7E:0D82]  ;/
$94:AC66 AD FE 0C    LDA $0CFE  [$7E:0CFE]  ; A = [grapple beam length]
$94:AC69 CD 8C 0D    CMP $0D8C  [$7E:0D8C]  ;\
$94:AC6C F0 1E       BEQ $1E    [$AC8C]     ;} If [A] = [target grapple beam length]: go to BRANCH_DECREASED_TO_TARGET_LENGTH

; LOOP_DECREASE_LENGTH
$94:AC6E 8D 8A 0D    STA $0D8A  [$7E:0D8A]  ; New grapple beam length = [A]
$94:AC71 3A          DEC A                  ;\
$94:AC72 18          CLC                    ;|
$94:AC73 6D 8E 0D    ADC $0D8E  [$7E:0D8E]  ;} $0D84 = [Samus front boundary offset from grapple beam start] + [new grapple beam length] - 1
$94:AC76 8D 84 0D    STA $0D84  [$7E:0D84]  ;/
$94:AC79 20 57 A9    JSR $A957  [$94:A957]  ; Calculate position from grapple beam end with distance and angle
$94:AC7C 20 64 AA    JSR $AA64  [$94:AA64]  ; Grapple swing collision reaction
$94:AC7F B0 14       BCS $14    [$AC95]     ; If collision: go to BRANCH_COLLISION
$94:AC81 CE 8A 0D    DEC $0D8A  [$7E:0D8A]  ; Decrement new grapple beam length
$94:AC84 AD 8A 0D    LDA $0D8A  [$7E:0D8A]  ; A = [new grapple beam length]
$94:AC87 CD 8C 0D    CMP $0D8C  [$7E:0D8C]  ;\
$94:AC8A D0 E2       BNE $E2    [$AC6E]     ;} If [A] != [target grapple beam length]: go to LOOP_DECREASE_LENGTH

; BRANCH_DECREASED_TO_TARGET_LENGTH
$94:AC8C AD 8C 0D    LDA $0D8C  [$7E:0D8C]  ;\
$94:AC8F 8D FE 0C    STA $0CFE  [$7E:0CFE]  ;} Grapple beam length = [target grapple beam length]
$94:AC92 AB          PLB
$94:AC93 18          CLC                    ;\
$94:AC94 6B          RTL                    ;} Return carry clear

; BRANCH_COLLISION
$94:AC95 AD 8A 0D    LDA $0D8A  [$7E:0D8A]  ;\
$94:AC98 8D FE 0C    STA $0CFE  [$7E:0CFE]  ;} Grapple beam length = [new grapple beam length]
$94:AC9B AB          PLB
$94:AC9C 38          SEC                    ;\
$94:AC9D 6B          RTL                    ;} Return carry set

; BRANCH_INCREASE_LENGTH
$94:AC9E AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$94:ACA1 18          CLC                    ;} Target grapple beam length = [grapple beam length] + [grapple beam length delta]
$94:ACA2 6D 00 0D    ADC $0D00  [$7E:0D00]  ;/
$94:ACA5 C9 3F 00    CMP #$003F             ;\
$94:ACA8 90 06       BCC $06    [$ACB0]     ;} If [target grapple beam length] >= 3Fh:
$94:ACAA 9C 00 0D    STZ $0D00  [$7E:0D00]  ; Grapple beam length delta = 0
$94:ACAD A9 3F 00    LDA #$003F             ; Target grapple beam length = 3Fh
                                            
$94:ACB0 8D 8C 0D    STA $0D8C  [$7E:0D8C]  
$94:ACB3 A9 38 00    LDA #$0038             ;\
$94:ACB6 8D 8E 0D    STA $0D8E  [$7E:0D8E]  ;} Samus front boundary offset from grapple beam start = 38h
$94:ACB9 AD FB 0C    LDA $0CFB  [$7E:0CFB]  ;\
$94:ACBC 29 FF 00    AND #$00FF             ;|
$94:ACBF 0A          ASL A                  ;} $0D82 = [grapple beam end angle] / 100h * 2
$94:ACC0 8D 82 0D    STA $0D82  [$7E:0D82]  ;/
$94:ACC3 AD FE 0C    LDA $0CFE  [$7E:0CFE]  ; A = [grapple beam length]
$94:ACC6 CD 8C 0D    CMP $0D8C  [$7E:0D8C]  ;\
$94:ACC9 F0 1E       BEQ $1E    [$ACE9]     ;} If [A] = [target grapple beam length]: go to BRANCH_INCREASED_TO_TARGET_LENGTH

; LOOP_INCREASE_LENGTH
$94:ACCB 8D 8A 0D    STA $0D8A  [$7E:0D8A]
$94:ACCE 1A          INC A                  ;\
$94:ACCF 18          CLC                    ;|
$94:ACD0 6D 8E 0D    ADC $0D8E  [$7E:0D8E]  ;} $0D84 = [Samus front boundary offset from grapple beam start] + [new grapple beam length] + 1
$94:ACD3 8D 84 0D    STA $0D84  [$7E:0D84]  ;/
$94:ACD6 20 57 A9    JSR $A957  [$94:A957]  ; Calculate position from grapple beam end with distance and angle
$94:ACD9 20 64 AA    JSR $AA64  [$94:AA64]  ; Grapple swing collision reaction
$94:ACDC B0 B7       BCS $B7    [$AC95]     ; If collision: go to BRANCH_COLLISION
$94:ACDE EE 8A 0D    INC $0D8A  [$7E:0D8A]  ; Increment new grapple beam length
$94:ACE1 AD 8A 0D    LDA $0D8A  [$7E:0D8A]  ; A = [new grapple beam length]
$94:ACE4 CD 8C 0D    CMP $0D8C  [$7E:0D8C]  ;\
$94:ACE7 D0 E2       BNE $E2    [$ACCB]     ;} If [A] != [target grapple beam length]: go to LOOP_INCREASE_LENGTH

; BRANCH_INCREASED_TO_TARGET_LENGTH
$94:ACE9 AD 8C 0D    LDA $0D8C  [$7E:0D8C]  ;\
$94:ACEC 8D FE 0C    STA $0CFE  [$7E:0CFE]  ;} Grapple beam length = [target grapple beam length]
$94:ACEF AB          PLB
$94:ACF0 18          CLC                    ;\
$94:ACF1 6B          RTL                    ;} Return carry clear

; Unused copy+paste of BRANCH_COLLISION
$94:ACF2 AD 8A 0D    LDA $0D8A  [$7E:0D8A]
$94:ACF5 8D FE 0C    STA $0CFE  [$7E:0CFE]
$94:ACF8 AB          PLB
$94:ACF9 38          SEC
$94:ACFA 6B          RTL

$94:ACFB AB          PLB
$94:ACFC 18          CLC
$94:ACFD 6B          RTL
}


;;; $ACFE: Handle grapple beam swinging movement ;;;
{
; The clockwise and anticlockwise branches are identical except for the INC/DEC in the loop >_>;
$94:ACFE 8B          PHB
$94:ACFF 4B          PHK                    ;\
$94:AD00 AB          PLB                    ;} DB = $94
$94:AD01 A0 00 01    LDY #$0100             ; Y = 100h
$94:AD04 AD F4 0C    LDA $0CF4  [$7E:0CF4]  ;\
$94:AD07 89 01 00    BIT #$0001             ;} If grapple beam liquid physics:
$94:AD0A F0 03       BEQ $03    [$AD0F]     ;/
$94:AD0C A0 A0 00    LDY #$00A0             ; Y = A0h

$94:AD0F AD 26 0D    LDA $0D26  [$7E:0D26]  ;\
$94:AD12 18          CLC                    ;} A = [grapple swing angular velocity] + [extra grapple swing angular velocity]
$94:AD13 6D 2E 0D    ADC $0D2E  [$7E:0D2E]  ;/
$94:AD16 10 17       BPL $17    [$AD2F]     ; If [A] < 0 (anticlockwise):
$94:AD18 49 FF FF    EOR #$FFFF             ;\
$94:AD1B 1A          INC A                  ;|
$94:AD1C 22 D6 82 80 JSL $8082D6[$80:82D6]  ;|
$94:AD20 AD F2 05    LDA $05F2  [$7E:05F2]  ;} A *= [Y] / 100h
$94:AD23 49 FF FF    EOR #$FFFF             ;|
$94:AD26 1A          INC A                  ;/
$94:AD27 F0 14       BEQ $14    [$AD3D]     ; If [A] = 0: go to BRANCH_FAILED_MOVEMENT
$94:AD29 8D 9C 0D    STA $0D9C  [$7E:0D9C]  ; Total grapple swing angular velocity = [A]
$94:AD2C 4C 10 AE    JMP $AE10  [$94:AE10]  ; Go to BRANCH_ANTICLOCKWISE

$94:AD2F 22 D6 82 80 JSL $8082D6[$80:82D6]  ;\
$94:AD33 AD F2 05    LDA $05F2  [$7E:05F2]  ;} A *= [Y] / 100h
$94:AD36 F0 05       BEQ $05    [$AD3D]     ; If [A] = 0: go to BRANCH_FAILED_MOVEMENT
$94:AD38 8D 9C 0D    STA $0D9C  [$7E:0D9C]  ; Total grapple swing angular velocity = [A]
$94:AD3B 80 03       BRA $03    [$AD40]     ; Go to BRANCH_CLOCKWISE

$94:AD3D 4C E0 AE    JMP $AEE0  [$94:AEE0]

; BRANCH_CLOCKWISE
{
$94:AD40 18          CLC                    ;\
$94:AD41 6D FA 0C    ADC $0CFA  [$7E:0CFA]  ;|
$94:AD44 EB          XBA                    ;|
$94:AD45 29 FF 00    AND #$00FF             ;} Target grapple beam end angle * 2 = ([total grapple swing angular velocity] + [grapple beam end angle]) / 100h * 2
$94:AD48 0A          ASL A                  ;|
$94:AD49 8D 88 0D    STA $0D88  [$7E:0D88]  ;/
$94:AD4C AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$94:AD4F 8D 84 0D    STA $0D84  [$7E:0D84]  ;} $0D84 = [grapple beam length]
$94:AD52 AD FB 0C    LDA $0CFB  [$7E:0CFB]  ;\
$94:AD55 29 FF 00    AND #$00FF             ;} A = [grapple beam end angle] / 100h * 2
$94:AD58 0A          ASL A                  ;/
$94:AD59 CD 88 0D    CMP $0D88  [$7E:0D88]  ;\
$94:AD5C F0 1D       BEQ $1D    [$AD7B]     ;} If [A] = [target grapple beam end angle * 2]: go to BRANCH_REACHED_TARGET_CLOCKWISE

; LOOP_CLOCKWISE
$94:AD5E 8D 86 0D    STA $0D86  [$7E:0D86]  ; New grapple beam end angle * 2 = [A]
$94:AD61 1A          INC A                  ;\
$94:AD62 1A          INC A                  ;|
$94:AD63 29 FF 01    AND #$01FF             ;} $0D82 = ([new grapple beam end angle * 2] + 2) % 200h
$94:AD66 8D 82 0D    STA $0D82  [$7E:0D82]  ;/
$94:AD69 20 E6 AB    JSR $ABE6  [$94:ABE6]  ; Grapple swing collision detection due to swinging
$94:AD6C B0 46       BCS $46    [$ADB4]     ; If collision: go to BRANCH_COLLISION_CLOCKWISE
$94:AD6E AD 86 0D    LDA $0D86  [$7E:0D86]  ;\
$94:AD71 1A          INC A                  ;|
$94:AD72 1A          INC A                  ;} A = ([new grapple beam end angle * 2] + 2) % 200h
$94:AD73 29 FF 01    AND #$01FF             ;/
$94:AD76 CD 88 0D    CMP $0D88  [$7E:0D88]  ;\
$94:AD79 D0 E3       BNE $E3    [$AD5E]     ;} If [A] != [target grapple beam end angle * 2]: go to LOOP_CLOCKWISE

; BRANCH_REACHED_TARGET_CLOCKWISE
$94:AD7B AD FA 0C    LDA $0CFA  [$7E:0CFA]  ;\
$94:AD7E 18          CLC                    ;|
$94:AD7F 6D 9C 0D    ADC $0D9C  [$7E:0D9C]  ;} Grapple beam end angle += [total grapple swing angular velocity]
$94:AD82 8D FA 0C    STA $0CFA  [$7E:0CFA]  ;|
$94:AD85 8D FC 0C    STA $0CFC  [$7E:0CFC]  ;/
$94:AD88 A9 00 80    LDA #$8000             ;\
$94:AD8B 1C 36 0D    TRB $0D36  [$7E:0D36]  ;} Disable special grapple beam angle handling
$94:AD8E CE 30 0D    DEC $0D30  [$7E:0D30]  ;\
$94:AD91 10 03       BPL $03    [$AD96]     ;} Grapple kick cooldown timer = max(0, [grapple kick cooldown timer] - 1)
$94:AD93 9C 30 0D    STZ $0D30  [$7E:0D30]  ;/

$94:AD96 AD 2E 0D    LDA $0D2E  [$7E:0D2E]  ;\
$94:AD99 10 08       BPL $08    [$ADA3]     ;} If [extra grapple swing angular velocity] < 0:
$94:AD9B 18          CLC                    ;\
$94:AD9C 69 06 00    ADC #$0006             ;} Extra grapple swing angular velocity = min(0, [extra grapple swing angular velocity] + 6)
$94:AD9F 10 0A       BPL $0A    [$ADAB]     ;/
$94:ADA1 80 0B       BRA $0B    [$ADAE]     ; Return carry clear

$94:ADA3 38          SEC                    ;\
$94:ADA4 E9 06 00    SBC #$0006             ;} Extra grapple swing angular velocity = max(0, [extra grapple swing angular velocity] - 6)
$94:ADA7 30 02       BMI $02    [$ADAB]     ;/
$94:ADA9 80 03       BRA $03    [$ADAE]     ; Return carry clear

$94:ADAB A9 00 00    LDA #$0000

$94:ADAE 8D 2E 0D    STA $0D2E  [$7E:0D2E]
$94:ADB1 AB          PLB
$94:ADB2 18          CLC
$94:ADB3 6B          RTL

; BRANCH_COLLISION_CLOCKWISE
$94:ADB4 AD 86 0D    LDA $0D86  [$7E:0D86]  ;\
$94:ADB7 4A          LSR A                  ;|
$94:ADB8 29 FF 00    AND #$00FF             ;|
$94:ADBB EB          XBA                    ;} Grapple beam end angle = 0.80h + [new grapple beam end angle * 2] / 2
$94:ADBC 09 80 00    ORA #$0080             ;|
$94:ADBF 8D FA 0C    STA $0CFA  [$7E:0CFA]  ;|
$94:ADC2 8D FC 0C    STA $0CFC  [$7E:0CFC]  ;/
$94:ADC5 AD 98 0D    LDA $0D98  [$7E:0D98]  ;\
$94:ADC8 C9 06 00    CMP #$0006             ;|
$94:ADCB F0 05       BEQ $05    [$ADD2]     ;} If [distance of grapple swing collision from Samus' feet] < 5 (40px): go to BRANCH_CLOCKWISE_BOUNCE
$94:ADCD C9 05 00    CMP #$0005             ;|
$94:ADD0 D0 17       BNE $17    [$ADE9]     ;/

$94:ADD2 AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$94:ADD5 C9 08 00    CMP #$0008             ;} If [grapple beam length] = 8:
$94:ADD8 D0 0F       BNE $0F    [$ADE9]     ;/
$94:ADDA A9 00 80    LDA #$8000             ;\
$94:ADDD 0C 36 0D    TSB $0D36  [$7E:0D36]  ;} Enable special grapple beam angle handling
$94:ADE0 9C 26 0D    STZ $0D26  [$7E:0D26]  ; Grapple swing angular velocity = 0
$94:ADE3 9C 2E 0D    STZ $0D2E  [$7E:0D2E]  ; Extra grapple swing angular velocity = 0
$94:ADE6 AB          PLB
$94:ADE7 38          SEC                    ;\
$94:ADE8 6B          RTL                    ;} Return carry set

; BRANCH_CLOCKWISE_BOUNCE
$94:ADE9 A9 10 00    LDA #$0010             ;\
$94:ADEC 8D 30 0D    STA $0D30  [$7E:0D30]  ;} Grapple kick cooldown timer = 10h
$94:ADEF AD 26 0D    LDA $0D26  [$7E:0D26]  ;\
$94:ADF2 0A          ASL A                  ;|
$94:ADF3 AD 26 0D    LDA $0D26  [$7E:0D26]  ;|
$94:ADF6 6A          ROR A                  ;} Grapple swing angular velocity = -[grapple swing angular velocity] / 2
$94:ADF7 49 FF FF    EOR #$FFFF             ;|
$94:ADFA 1A          INC A                  ;|
$94:ADFB 8D 26 0D    STA $0D26  [$7E:0D26]  ;/
$94:ADFE AD 2E 0D    LDA $0D2E  [$7E:0D2E]  ;\
$94:AE01 0A          ASL A                  ;|
$94:AE02 AD 2E 0D    LDA $0D2E  [$7E:0D2E]  ;|
$94:AE05 6A          ROR A                  ;} Extra grapple swing angular velocity = -[extra grapple swing angular velocity] / 2
$94:AE06 49 FF FF    EOR #$FFFF             ;|
$94:AE09 1A          INC A                  ;|
$94:AE0A 8D 2E 0D    STA $0D2E  [$7E:0D2E]  ;/
$94:AE0D AB          PLB
$94:AE0E 38          SEC                    ;\
$94:AE0F 6B          RTL                    ;} Return carry set
}

; BRANCH_ANTICLOCKWISE
{
$94:AE10 18          CLC                    ;\
$94:AE11 6D FA 0C    ADC $0CFA  [$7E:0CFA]  ;|
$94:AE14 EB          XBA                    ;|
$94:AE15 29 FF 00    AND #$00FF             ;} Target grapple beam end angle * 2 = ([total grapple swing angular velocity] + [grapple beam end angle]) / 100h * 2
$94:AE18 0A          ASL A                  ;|
$94:AE19 8D 88 0D    STA $0D88  [$7E:0D88]  ;/
$94:AE1C AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$94:AE1F 8D 84 0D    STA $0D84  [$7E:0D84]  ;} $0D84 = [grapple beam length]
$94:AE22 AD FB 0C    LDA $0CFB  [$7E:0CFB]  ;\
$94:AE25 29 FF 00    AND #$00FF             ;} A = [grapple beam end angle] / 100h * 2
$94:AE28 0A          ASL A                  ;/
$94:AE29 CD 88 0D    CMP $0D88  [$7E:0D88]  ;\
$94:AE2C F0 1D       BEQ $1D    [$AE4B]     ;} If [A] = [target grapple beam end angle * 2]: go to BRANCH_REACHED_TARGET_ANTICLOCKWISE

; LOOP_ANTICLOCKWISE
$94:AE2E 8D 86 0D    STA $0D86  [$7E:0D86]  ; New grapple beam end angle * 2 = [A]
$94:AE31 3A          DEC A                  ;\
$94:AE32 3A          DEC A                  ;|
$94:AE33 29 FF 01    AND #$01FF             ;} $0D82 = ([new grapple beam end angle * 2] - 2) % 200h
$94:AE36 8D 82 0D    STA $0D82  [$7E:0D82]  ;/
$94:AE39 20 E6 AB    JSR $ABE6  [$94:ABE6]  ; Grapple swing collision detection due to swinging
$94:AE3C B0 46       BCS $46    [$AE84]     ; If collision: go to BRANCH_COLLISION_ANTICLOCKWISE
$94:AE3E AD 86 0D    LDA $0D86  [$7E:0D86]  ;\
$94:AE41 3A          DEC A                  ;|
$94:AE42 3A          DEC A                  ;} A = ([new grapple beam end angle * 2] - 2) % 200h
$94:AE43 29 FF 01    AND #$01FF             ;/
$94:AE46 CD 88 0D    CMP $0D88  [$7E:0D88]  ;\
$94:AE49 D0 E3       BNE $E3    [$AE2E]     ;} If [A] != [target grapple beam end angle * 2]: go to LOOP_ANTICLOCKWISE

; BRANCH_REACHED_TARGET_ANTICLOCKWISE
$94:AE4B AD FA 0C    LDA $0CFA  [$7E:0CFA]  ;\
$94:AE4E 18          CLC                    ;|
$94:AE4F 6D 9C 0D    ADC $0D9C  [$7E:0D9C]  ;} Grapple beam end angle += [total grapple swing angular velocity]
$94:AE52 8D FA 0C    STA $0CFA  [$7E:0CFA]  ;|
$94:AE55 8D FC 0C    STA $0CFC  [$7E:0CFC]  ;/
$94:AE58 A9 00 80    LDA #$8000             ;\
$94:AE5B 1C 36 0D    TRB $0D36  [$7E:0D36]  ;} Disable special grapple beam angle handling
$94:AE5E CE 30 0D    DEC $0D30  [$7E:0D30]  ;\
$94:AE61 10 03       BPL $03    [$AE66]     ;} Grapple kick cooldown timer = max(0, [grapple kick cooldown timer] - 1)
$94:AE63 9C 30 0D    STZ $0D30  [$7E:0D30]  ;/
                                            
$94:AE66 AD 2E 0D    LDA $0D2E  [$7E:0D2E]  ;\
$94:AE69 10 08       BPL $08    [$AE73]     ;} If [extra grapple swing angular velocity] < 0:
$94:AE6B 18          CLC                    ;\
$94:AE6C 69 06 00    ADC #$0006             ;} Extra grapple swing angular velocity = min(0, [extra grapple swing angular velocity] + 6)
$94:AE6F 10 0A       BPL $0A    [$AE7B]     ;/
$94:AE71 80 0B       BRA $0B    [$AE7E]     ; Return carry clear
                                            
$94:AE73 38          SEC                    ;\
$94:AE74 E9 06 00    SBC #$0006             ;} Extra grapple swing angular velocity = max(0, [extra grapple swing angular velocity] - 6)
$94:AE77 30 02       BMI $02    [$AE7B]     ;/
$94:AE79 80 03       BRA $03    [$AE7E]     ; Return carry clear

$94:AE7B A9 00 00    LDA #$0000

$94:AE7E 8D 2E 0D    STA $0D2E  [$7E:0D2E]
$94:AE81 AB          PLB
$94:AE82 18          CLC
$94:AE83 6B          RTL

; BRANCH_COLLISION_ANTICLOCKWISE
$94:AE84 AD 86 0D    LDA $0D86  [$7E:0D86]  ;\
$94:AE87 4A          LSR A                  ;|
$94:AE88 29 FF 00    AND #$00FF             ;|
$94:AE8B EB          XBA                    ;} Grapple beam end angle = 0.80h + [new grapple beam end angle * 2] / 2
$94:AE8C 09 80 00    ORA #$0080             ;|
$94:AE8F 8D FA 0C    STA $0CFA  [$7E:0CFA]  ;|
$94:AE92 8D FC 0C    STA $0CFC  [$7E:0CFC]  ;/
$94:AE95 AD 98 0D    LDA $0D98  [$7E:0D98]  ;\
$94:AE98 C9 06 00    CMP #$0006             ;|
$94:AE9B F0 05       BEQ $05    [$AEA2]     ;} If [distance of grapple swing collision from Samus' feet] < 5 (40px): go to BRANCH_ANTICLOCKWISE_BOUNCE
$94:AE9D C9 05 00    CMP #$0005             ;|
$94:AEA0 D0 17       BNE $17    [$AEB9]     ;/
                                            
$94:AEA2 AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$94:AEA5 C9 08 00    CMP #$0008             ;} If [grapple beam length] = 8:
$94:AEA8 D0 0F       BNE $0F    [$AEB9]     ;/
$94:AEAA A9 00 80    LDA #$8000             ;\
$94:AEAD 0C 36 0D    TSB $0D36  [$7E:0D36]  ;} Enable special grapple beam angle handling
$94:AEB0 9C 26 0D    STZ $0D26  [$7E:0D26]  ; Grapple swing angular velocity = 0
$94:AEB3 9C 2E 0D    STZ $0D2E  [$7E:0D2E]  ; Extra grapple swing angular velocity = 0
$94:AEB6 AB          PLB                    
$94:AEB7 38          SEC                    ;\
$94:AEB8 6B          RTL                    ;} Return carry set

; BRANCH_ANTICLOCKWISE_BOUNCE
$94:AEB9 A9 10 00    LDA #$0010             ;\
$94:AEBC 8D 30 0D    STA $0D30  [$7E:0D30]  ;} Grapple kick cooldown timer = 10h
$94:AEBF AD 26 0D    LDA $0D26  [$7E:0D26]  ;\
$94:AEC2 0A          ASL A                  ;|
$94:AEC3 AD 26 0D    LDA $0D26  [$7E:0D26]  ;|
$94:AEC6 6A          ROR A                  ;} Grapple swing angular velocity = -[grapple swing angular velocity] / 2
$94:AEC7 49 FF FF    EOR #$FFFF             ;|
$94:AECA 1A          INC A                  ;|
$94:AECB 8D 26 0D    STA $0D26  [$7E:0D26]  ;/
$94:AECE AD 2E 0D    LDA $0D2E  [$7E:0D2E]  ;\
$94:AED1 0A          ASL A                  ;|
$94:AED2 AD 2E 0D    LDA $0D2E  [$7E:0D2E]  ;|
$94:AED5 6A          ROR A                  ;} Extra grapple swing angular velocity = -[extra grapple swing angular velocity] / 2
$94:AED6 49 FF FF    EOR #$FFFF             ;|
$94:AED9 1A          INC A                  ;|
$94:AEDA 8D 2E 0D    STA $0D2E  [$7E:0D2E]  ;/
$94:AEDD AB          PLB                    
$94:AEDE 38          SEC                    ;\
$94:AEDF 6B          RTL                    ;} Return carry set
}

; BRANCH_FAILED_MOVEMENT
; Looks like RTL'd out code
$94:AEE0 AB          PLB
$94:AEE1 18          CLC                    ;\
$94:AEE2 6B          RTL                    ;} Return carry clear

; This code would make Samus drop if she failed too many failed movements in a row (such as holding right from rest)
$94:AEE3 AD FA 0C    LDA $0CFA  [$7E:0CFA]  ;\
$94:AEE6 4D 26 0D    EOR $0D26  [$7E:0D26]  ;} If sgn([grapple beam end angle]) != sgn([grapple swing angular velocity]): go to BRANCH_RISING
$94:AEE9 30 1A       BMI $1A    [$AF05]     ;/
$94:AEEB EE 38 0D    INC $0D38  [$7E:0D38]  ; Increment failed grapple swing movement counter
$94:AEEE AD 38 0D    LDA $0D38  [$7E:0D38]  ;\
$94:AEF1 C9 20 00    CMP #$0020             ;} If [failed grapple swing movement counter] = 20h:
$94:AEF4 D0 06       BNE $06    [$AEFC]     ;/
$94:AEF6 A9 C5 C8    LDA #$C8C5             ;\
$94:AEF9 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Grapple beam function = dropped

$94:AEFC 9C 26 0D    STZ $0D26  [$7E:0D26]  ; Grapple swing angular velocity = 0
$94:AEFF 9C 2E 0D    STZ $0D2E  [$7E:0D2E]  ; Extra grapple swing angular velocity = 0
$94:AF02 AB          PLB
$94:AF03 38          SEC                    ;\
$94:AF04 6B          RTL                    ;} Return carry set

; BRANCH_RISING
$94:AF05 9C 38 0D    STZ $0D38  [$7E:0D38]  ; Failed grapple swing movement counter = 0
$94:AF08 AB          PLB
$94:AF09 38          SEC                    ;\
$94:AF0A 6B          RTL                    ;} Return carry set
}


;;; $AF0B: Clear carry ;;;
{
; Looks like RTL'd out code
; Either required a parameter X and the loop fixed, or there was supposed to be code to set X in the loop
; Appears to (try to) check for block collisions of the entire grapple beam, and drop grapple beam if so
$94:AF0B 18          CLC
$94:AF0C 6B          RTL

$94:AF0D 8B          PHB
$94:AF0E 4B          PHK                    ;\
$94:AF0F AB          PLB                    ;} DB = $94
$94:AF10 AD 08 0D    LDA $0D08  [$7E:0D08]  ;\
$94:AF13 4A          LSR A                  ;|
$94:AF14 4A          LSR A                  ;|
$94:AF15 4A          LSR A                  ;|
$94:AF16 4A          LSR A                  ;} $0D94 = [grapple beam end X position] / 10h * 100h
$94:AF17 29 FF 00    AND #$00FF             ;|
$94:AF1A EB          XBA                    ;|
$94:AF1B 8D 94 0D    STA $0D94  [$7E:0D94]  ;/
$94:AF1E AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;\
$94:AF21 4A          LSR A                  ;|
$94:AF22 4A          LSR A                  ;|
$94:AF23 4A          LSR A                  ;|
$94:AF24 4A          LSR A                  ;} $0D96 = [grapple beam end Y position] / 10h * 100h
$94:AF25 29 FF 00    AND #$00FF             ;|
$94:AF28 EB          XBA                    ;|
$94:AF29 8D 96 0D    STA $0D96  [$7E:0D96]  ;/
$94:AF2C AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$94:AF2F 4A          LSR A                  ;|
$94:AF30 4A          LSR A                  ;|
$94:AF31 4A          LSR A                  ;} $0D98 = [grapple beam length] / 10h
$94:AF32 4A          LSR A                  ;|
$94:AF33 8D 98 0D    STA $0D98  [$7E:0D98]  ;/

; LOOP
$94:AF36 BF C3 B3 A0 LDA $A0B3C3,x          ;\
$94:AF3A 18          CLC                    ;|
$94:AF3B 6D 96 0D    ADC $0D96  [$7E:0D96]  ;} $0D96 += 100h * -cos([X] / 2 * pi / 80h)
$94:AF3E 8D 96 0D    STA $0D96  [$7E:0D96]  ;/
$94:AF41 EB          XBA                    ;\
$94:AF42 E2 20       SEP #$20               ;|
$94:AF44 8D 02 42    STA $4202  [$7E:4202]  ;} Calculate [$0D96] / 100h * [room width in blocks]
$94:AF47 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$94:AF4A 8D 03 42    STA $4203  [$7E:4203]  ;/
$94:AF4D C2 21       REP #$21               ;\
$94:AF4F BF 43 B4 A0 LDA $A0B443,x          ;|
$94:AF53 6D 94 0D    ADC $0D94  [$7E:0D94]  ;} $0D94 += 100h * sin([X] / 2 * pi / 80h)
$94:AF56 8D 94 0D    STA $0D94  [$7E:0D94]  ;/
$94:AF59 29 00 FF    AND #$FF00             ;\
$94:AF5C EB          XBA                    ;|
$94:AF5D 6D 16 42    ADC $4216  [$7E:4216]  ;} Current block index = [$0D96] / 100h * [room width in blocks] + [$0D94] / 100h
$94:AF60 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$94:AF63 0A          ASL A                  ;\
$94:AF64 AA          TAX                    ;|
$94:AF65 BF 02 00 7F LDA $7F0002,x          ;|
$94:AF69 29 00 F0    AND #$F000             ;|
$94:AF6C EB          XBA                    ;|
$94:AF6D 4A          LSR A                  ;} Execute [$AB90 + (block type) * 2]
$94:AF6E 4A          LSR A                  ;|
$94:AF6F 4A          LSR A                  ;|
$94:AF70 AA          TAX                    ;|
$94:AF71 FC 90 AB    JSR ($AB90,x)          ;/
$94:AF74 B0 08       BCS $08    [$AF7E]     ; If no collision:
$94:AF76 CE 98 0D    DEC $0D98  [$7E:0D98]  ; Decrement $0D98
$94:AF79 10 BB       BPL $BB    [$AF36]     ; If [$0D98] >= 0: go to LOOP <-- X has been clobbered, so this loop is no good
$94:AF7B AB          PLB
$94:AF7C 18          CLC                    ;\
$94:AF7D 6B          RTL                    ;} Return carry clear

$94:AF7E A9 C5 C8    LDA #$C8C5             ;\
$94:AF81 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Grapple beam function = dropped
$94:AF84 AB          PLB
$94:AF85 38          SEC                    ;\
$94:AF86 6B          RTL                    ;} Return carry set
}
}


;;; $AF87..B19E: Grapple beam drawing ;;;
{
;;; $AF87: Initialise grapple segment animations ;;;
{
$94:AF87 A2 1E 00    LDX #$001E             ; X = 1Eh (grapple segment animation index)

; LOOP
$94:AF8A A9 97 B1    LDA #$B197             ;\
$94:AF8D 9D 62 0D    STA $0D62,x[$7E:0D80]  ;} Grapple segment animation instruction list pointer [X] = $B197
$94:AF90 A9 93 B1    LDA #$B193             ;\
$94:AF93 9D 60 0D    STA $0D60,x[$7E:0D7E]  ;} Grapple segment animation instruction list pointer ([X] - 2) = $B193
$94:AF96 A9 8F B1    LDA #$B18F             ;\
$94:AF99 9D 5E 0D    STA $0D5E,x[$7E:0D7C]  ;} Grapple segment animation instruction list pointer ([X] - 4) = $B18F
$94:AF9C A9 8B B1    LDA #$B18B             ;\
$94:AF9F 9D 5C 0D    STA $0D5C,x[$7E:0D7A]  ;} Grapple segment animation instruction list pointer ([X] - 6) = $B18B
$94:AFA2 A9 01 00    LDA #$0001             ;\
$94:AFA5 9D 42 0D    STA $0D42,x[$7E:0D60]  ;} Grapple segment animation instruction timer [X] = 1
$94:AFA8 9D 40 0D    STA $0D40,x[$7E:0D5E]  ; Grapple segment animation instruction timer ([X] - 2) = 1
$94:AFAB 9D 3E 0D    STA $0D3E,x[$7E:0D5C]  ; Grapple segment animation instruction timer ([X] - 4) = 1
$94:AFAE 9D 3C 0D    STA $0D3C,x[$7E:0D5A]  ; Grapple segment animation instruction timer ([X] - 6) = 1
$94:AFB1 8A          TXA                    ;\
$94:AFB2 38          SEC                    ;|
$94:AFB3 E9 08 00    SBC #$0008             ;} X -= 8 (next 4 grapple segment animations)
$94:AFB6 AA          TAX                    ;/
$94:AFB7 10 D1       BPL $D1    [$AF8A]     ; If [X] >= 0: go to LOOP
$94:AFB9 6B          RTL
}


;;; $AFBA: Draw grapple beam ;;;
{
; Uses:
;     $0CFE: Grapple beam length
;     $0D08: Grapple beam end X position
;     $0D0C: Grapple beam end Y position
;     $0D1A: Grapple beam flare X position
;     $0D1C: Grapple beam flare Y position
;     $0D42..61: Grapple segment animation instruction timers
;     $0D62..81: Grapple segment animation instruction list pointers

; Doesn't use [grapple beam end angle] except for unused calculation at $AFF7

$94:AFBA 8B          PHB
$94:AFBB 4B          PHK                    ;\
$94:AFBC AB          PLB                    ;} DB = $94
$94:AFBD AD 08 0D    LDA $0D08  [$7E:0D08]  ;\
$94:AFC0 38          SEC                    ;|
$94:AFC1 ED 1A 0D    SBC $0D1A  [$7E:0D1A]  ;|
$94:AFC4 85 12       STA $12    [$7E:0012]  ;|
$94:AFC6 AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;} A = angle from grapple beam flare to grapple beam end
$94:AFC9 38          SEC                    ;|
$94:AFCA ED 1C 0D    SBC $0D1C  [$7E:0D1C]  ;|
$94:AFCD 85 14       STA $14    [$7E:0014]  ;|
$94:AFCF 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$94:AFD3 0A          ASL A                  ;\
$94:AFD4 AA          TAX                    ;} X = [A] * 2
$94:AFD5 64 1A       STZ $1A    [$7E:001A]  ;\
$94:AFD7 64 1C       STZ $1C    [$7E:001C]  ;|
$94:AFD9 BF 43 B4 A0 LDA $A0B443,x[$A0:B633];|
$94:AFDD 0A          ASL A                  ;|
$94:AFDE 0A          ASL A                  ;|
$94:AFDF 0A          ASL A                  ;} $1C.$1A = 8 * sin([A] * pi / 80h) (width)
$94:AFE0 10 02       BPL $02    [$AFE4]     ;|
$94:AFE2 C6 1C       DEC $1C    [$7E:001C]  ;|
                                            ;|
$94:AFE4 85 1B       STA $1B    [$7E:001B]  ;/
$94:AFE6 64 1E       STZ $1E    [$7E:001E]  ;\
$94:AFE8 64 20       STZ $20    [$7E:0020]  ;|
$94:AFEA BF C3 B3 A0 LDA $A0B3C3,x[$A0:B5B3];|
$94:AFEE 0A          ASL A                  ;|
$94:AFEF 0A          ASL A                  ;|
$94:AFF0 0A          ASL A                  ;} $20.$1E = 8 * -cos([A] * pi / 80h) (height)
$94:AFF1 10 02       BPL $02    [$AFF5]     ;|
$94:AFF3 C6 20       DEC $20    [$7E:0020]  ;|
                                            ;|
$94:AFF5 85 1F       STA $1F    [$7E:001F]  ;/
$94:AFF7 AD FA 0C    LDA $0CFA  [$7E:0CFA]  ;\
$94:AFFA 29 00 80    AND #$8000             ;|
$94:AFFD 4A          LSR A                  ;|
$94:AFFE 85 26       STA $26    [$7E:0026]  ;|
$94:B000 4D FA 0C    EOR $0CFA  [$7E:0CFA]  ;} Map [grapple beam end angle] quadrant to $26, never read >_>;
$94:B003 29 00 40    AND #$4000             ;} 0 = bottom-left, 4000h = top-right, 8000h = bottom-right, C000h = top-left
$94:B006 49 00 40    EOR #$4000             ;|
$94:B009 0A          ASL A                  ;|
$94:B00A 05 26       ORA $26    [$7E:0026]  ;|
$94:B00C 85 26       STA $26    [$7E:0026]  ;/
$94:B00E AD 1A 0D    LDA $0D1A  [$7E:0D1A]  ;\
$94:B011 38          SEC                    ;|
$94:B012 ED 11 09    SBC $0911  [$7E:0911]  ;|
$94:B015 38          SEC                    ;} $14 = [grapple beam flare X position] - [layer 1 X position] - 4 (X position)
$94:B016 E9 04 00    SBC #$0004             ;|
$94:B019 85 14       STA $14    [$7E:0014]  ;/
$94:B01B 64 12       STZ $12    [$7E:0012]  ; $12 = 0 (X subposition)
$94:B01D AD 1C 0D    LDA $0D1C  [$7E:0D1C]  ;\
$94:B020 38          SEC                    ;|
$94:B021 ED 15 09    SBC $0915  [$7E:0915]  ;|
$94:B024 38          SEC                    ;} $18 = [grapple beam flare Y position] - [layer 1 Y position] - 4 (Y position)
$94:B025 E9 04 00    SBC #$0004             ;|
$94:B028 85 18       STA $18    [$7E:0018]  ;/
$94:B02A 64 16       STZ $16    [$7E:0016]  ; $16 = 0 (Y subposition)
$94:B02C AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$94:B02F 30 77       BMI $77    [$B0A8]     ;} If [grapple beam length] < 0: return
$94:B031 8D 04 42    STA $4204  [$7E:4204]  ;\
$94:B034 E2 20       SEP #$20               ;|
$94:B036 A9 08       LDA #$08               ;|
$94:B038 8D 06 42    STA $4206  [$7E:4206]  ;|
$94:B03B C2 20       REP #$20               ;|
$94:B03D EA          NOP                    ;|
$94:B03E EA          NOP                    ;} A = [grapple beam length] / 8
$94:B03F EA          NOP                    ;|
$94:B040 EA          NOP                    ;|
$94:B041 EA          NOP                    ;|
$94:B042 EA          NOP                    ;|
$94:B043 AD 14 42    LDA $4214  [$7E:4214]  ;/
$94:B046 30 60       BMI $60    [$B0A8]     ; >_<;
$94:B048 29 0F 00    AND #$000F             ;\
$94:B04B 38          SEC                    ;|
$94:B04C E9 01 00    SBC #$0001             ;} $28 = [grapple beam length] / 8 % 10h - 1 (number of grapple segments)
$94:B04F 85 28       STA $28    [$7E:0028]  ;/
$94:B051 A2 1E 00    LDX #$001E             ; X = 1Eh (grapple segment animation index)

; LOOP_ANIMATIONS
$94:B054 DE 42 0D    DEC $0D42,x[$7E:0D60]  ;\
$94:B057 D0 1D       BNE $1D    [$B076]     ;} If [grapple segment animation instruction timer] != 0: go to BRANCH_PROCESSED_INSTRUCTIONS
$94:B059 BC 62 0D    LDY $0D62,x[$7E:0D80]  ; Y = [grapple segment animation instruction list pointer]

; LOOP_INSTRUCTIONS
$94:B05C B9 00 00    LDA $0000,y[$94:B197]  ;\
$94:B05F 10 0A       BPL $0A    [$B06B]     ;} If [[Y]] & 8000h != 0:
$94:B061 85 24       STA $24    [$7E:0024]  ; $24 = [[Y]]
$94:B063 F4 5B B0    PEA $B05B              ; Return to LOOP_INSTRUCTIONS
$94:B066 C8          INY                    ;\
$94:B067 C8          INY                    ;} Y += 2
$94:B068 6C 24 00    JMP ($0024)[$94:B0F4]  ; Go to [$24]

$94:B06B 9D 42 0D    STA $0D42,x[$7E:0D60]  ; Grapple segment animation instruction timer = [[Y]]
$94:B06E 98          TYA                    ;\
$94:B06F 18          CLC                    ;|
$94:B070 69 04 00    ADC #$0004             ;} Grapple segment animation instruction list pointer = [Y] + 4
$94:B073 9D 62 0D    STA $0D62,x[$7E:0D80]  ;/

; BRANCH_PROCESSED_INSTRUCTIONS
$94:B076 A5 14       LDA $14    [$7E:0014]  ;\
$94:B078 05 18       ORA $18    [$7E:0018]  ;|
$94:B07A 29 00 FF    AND #$FF00             ;} If 0 <= (X position) | (Y position) < 100h:
$94:B07D D0 14       BNE $14    [$B093]     ;/
$94:B07F DA          PHX
$94:B080 BC 62 0D    LDY $0D62,x[$7E:0D80]  ;\
$94:B083 88          DEY                    ;|
$94:B084 88          DEY                    ;} Y = [[grapple segment animation instruction list pointer] - 2] (tile number and attributes)
$94:B085 B9 00 00    LDA $0000,y[$94:B199]  ;|
$94:B088 A8          TAY                    ;/
$94:B089 20 AA B0    JSR $B0AA  [$94:B0AA]  ; Draw grapple segment
$94:B08C FA          PLX
$94:B08D CA          DEX                    ;\
$94:B08E CA          DEX                    ;} X -= 2 (next grapple segment animation)
$94:B08F C6 28       DEC $28    [$7E:0028]  ; Decrement $28
$94:B091 10 C1       BPL $C1    [$B054]     ; If [$28] >= 0: go to LOOP_ANIMATIONS

$94:B093 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$94:B096 C9 B2 00    CMP #$00B2             ;|
$94:B099 F0 0A       BEQ $0A    [$B0A5]     ;} If [Samus pose] != [grapple swinging]:
$94:B09B C9 B3 00    CMP #$00B3             ;|
$94:B09E F0 05       BEQ $05    [$B0A5]     ;/
$94:B0A0 20 F9 B0    JSR $B0F9  [$94:B0F9]  ; Draw grapple beam end - not connected
$94:B0A3 80 03       BRA $03    [$B0A8]
                                            ; Else ([Samus pose] = [grapple swinging]):
$94:B0A5 20 4B B1    JSR $B14B  [$94:B14B]  ; Draw grapple beam end - connected

$94:B0A8 AB          PLB
$94:B0A9 6B          RTL
}


;;; $B0AA: Draw grapple segment ;;;
{
;; Parameters:
;;     Y: Tile number and attributes
;;     $14.$12: X position
;;     $18.$16: Y position
;;     $1C.$1A: Width
;;     $20.$1E: Height

; The branch at $B0C3 seems like it was supposed to be BEQ to set the high X position bit if X position >= 100h, 
; but it checks $14 after the width is added, so that would need to be fixed too to make the dead code useful
; The X position is checked to be < 100h by callers, so there is no point in doing this check anyway
; Tldr, $B0C0..D2 can be eliminated entirely
$94:B0AA AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$94:B0AD 18          CLC
$94:B0AE A5 14       LDA $14    [$7E:0014]  ;\
$94:B0B0 9D 70 03    STA $0370,x[$7E:0398]  ;} OAM entry X position = [$14]
$94:B0B3 A5 12       LDA $12    [$7E:0012]  ;\
$94:B0B5 18          CLC                    ;|
$94:B0B6 65 1A       ADC $1A    [$7E:001A]  ;|
$94:B0B8 85 12       STA $12    [$7E:0012]  ;} $14.$12 += [$1C].[$1A]
$94:B0BA A5 14       LDA $14    [$7E:0014]  ;|
$94:B0BC 65 1C       ADC $1C    [$7E:001C]  ;|
$94:B0BE 85 14       STA $14    [$7E:0014]  ;/
$94:B0C0 29 00 01    AND #$0100             ; >_<;
$94:B0C3 80 0E       BRA $0E    [$B0D3]     ; Go to BRANCH

; Nothing points to this
$94:B0C5 BF 9F 85 81 LDA $81859F,x          ;\
$94:B0C9 85 22       STA $22    [$7E:0022]  ;|
$94:B0CB B2 22       LDA ($22)              ;} Set OAM entry high X position bit
$94:B0CD 1F 9F 83 81 ORA $81839F,x          ;|
$94:B0D1 92 22       STA ($22)              ;/

; BRANCH
$94:B0D3 A5 18       LDA $18    [$7E:0018]  ;\
$94:B0D5 9D 71 03    STA $0371,x[$7E:0399]  ;} OAM entry Y position = [$18]
$94:B0D8 A5 16       LDA $16    [$7E:0016]  ;\
$94:B0DA 18          CLC                    ;|
$94:B0DB 65 1E       ADC $1E    [$7E:001E]  ;|
$94:B0DD 85 16       STA $16    [$7E:0016]  ;} $18.$16 += [$20].[$1E]
$94:B0DF A5 18       LDA $18    [$7E:0018]  ;|
$94:B0E1 65 20       ADC $20    [$7E:0020]  ;|
$94:B0E3 85 18       STA $18    [$7E:0018]  ;/
$94:B0E5 98          TYA                    ;\
$94:B0E6 05 26       ORA $26    [$7E:0026]  ;} OAM entry tile number and attributes = [Y] | [$26]
$94:B0E8 9D 72 03    STA $0372,x[$7E:039A]  ;/
$94:B0EB 8A          TXA                    ;\
$94:B0EC 18          CLC                    ;|
$94:B0ED 69 04 00    ADC #$0004             ;} OAM stack pointer = [X] + 4
$94:B0F0 8D 90 05    STA $0590  [$7E:0590]  ;/
$94:B0F3 60          RTS
}


;;; $B0F4: Instruction - go to [[Y]] ;;;
{
$94:B0F4 B9 00 00    LDA $0000,y[$94:B19D]
$94:B0F7 A8          TAY
$94:B0F8 60          RTS
}


;;; $B0F9: Draw grapple beam end - not connected ;;;
{
$94:B0F9 AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;\
$94:B0FC 38          SEC                    ;|
$94:B0FD ED 15 09    SBC $0915  [$7E:0915]  ;} If not 0 <= [grapple beam end Y position] - [layer 1 Y position] < 100h: return
$94:B100 89 00 FF    BIT #$FF00             ;|
$94:B103 D0 45       BNE $45    [$B14A]     ;/
$94:B105 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$94:B108 18          CLC                    ;\
$94:B109 A5 14       LDA $14    [$7E:0014]  ;} >_<;
$94:B10B AD 08 0D    LDA $0D08  [$7E:0D08]  ;\
$94:B10E 38          SEC                    ;|
$94:B10F ED 11 09    SBC $0911  [$7E:0911]  ;|
$94:B112 38          SEC                    ;} OAM entry X position = [grapple beam end X position] - [layer 1 X position] - 4
$94:B113 E9 04 00    SBC #$0004             ;|
$94:B116 9D 70 03    STA $0370,x[$7E:039C]  ;/
$94:B119 29 00 01    AND #$0100             ;\
$94:B11C F0 0E       BEQ $0E    [$B12C]     ;} If not 0 <= [OAM entry X position] < 100h:
$94:B11E BF 9F 85 81 LDA $81859F,x          ;\
$94:B122 85 22       STA $22    [$7E:0022]  ;|
$94:B124 B2 22       LDA ($22)              ;} Set OAM entry high X position bit
$94:B126 1F 9F 83 81 ORA $81839F,x          ;|
$94:B12A 92 22       STA ($22)              ;/

$94:B12C A5 18       LDA $18    [$7E:0018]  ; >_<;
$94:B12E AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;\
$94:B131 38          SEC                    ;|
$94:B132 ED 15 09    SBC $0915  [$7E:0915]  ;|
$94:B135 38          SEC                    ;} OAM entry Y position = [grapple beam end Y position] - [layer 1 Y position] - 4
$94:B136 E9 04 00    SBC #$0004             ;|
$94:B139 9D 71 03    STA $0371,x[$7E:039D]  ;/
$94:B13C A9 20 3A    LDA #$3A20             ;\
$94:B13F 9D 72 03    STA $0372,x[$7E:039E]  ;} OAM entry tile number and attributes = 3A20h
$94:B142 8A          TXA                    ;\
$94:B143 18          CLC                    ;|
$94:B144 69 04 00    ADC #$0004             ;} OAM stack pointer = [X] + 4
$94:B147 8D 90 05    STA $0590  [$7E:0590]  ;/

$94:B14A 60          RTS
}


;;; $B14B: Draw grapple beam end - connected ;;;
{
; Equivalent to $B0F9
$94:B14B AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$94:B14E 18          CLC                    ; >_<;
$94:B14F AD 08 0D    LDA $0D08  [$7E:0D08]  ;\
$94:B152 38          SEC                    ;|
$94:B153 ED 11 09    SBC $0911  [$7E:0911]  ;} OAM entry X position = [grapple beam end X position] - [layer 1 X position] - 4
$94:B156 E9 04 00    SBC #$0004             ;|
$94:B159 9D 70 03    STA $0370,x[$7E:03B0]  ;/
$94:B15C 29 00 01    AND #$0100             ;\
$94:B15F F0 0E       BEQ $0E    [$B16F]     ;} If not 0 <= [OAM entry X position] < 100h:
$94:B161 BF 9F 85 81 LDA $81859F,x          ;\
$94:B165 85 22       STA $22    [$7E:0022]  ;|
$94:B167 B2 22       LDA ($22)              ;} Set OAM entry high X position bit
$94:B169 1F 9F 83 81 ORA $81839F,x          ;|
$94:B16D 92 22       STA ($22)              ;/

$94:B16F AD 0C 0D    LDA $0D0C  [$7E:0D0C]  ;\
$94:B172 38          SEC                    ;|
$94:B173 ED 15 09    SBC $0915  [$7E:0915]  ;} OAM entry Y position = [grapple beam end Y position] - [layer 1 Y position] - 4
$94:B176 E9 04 00    SBC #$0004             ;|
$94:B179 9D 71 03    STA $0371,x[$7E:03B1]  ;/
$94:B17C A9 20 3A    LDA #$3A20             ;\
$94:B17F 9D 72 03    STA $0372,x[$7E:03B2]  ;} OAM entry tile number and attributes = 3A20h
$94:B182 8A          TXA                    ;\
$94:B183 18          CLC                    ;|
$94:B184 69 04 00    ADC #$0004             ;} OAM stack pointer = [X] + 4
$94:B187 8D 90 05    STA $0590  [$7E:0590]  ;/
$94:B18A 60          RTS
}


;;; $B18B: Instruction lists - grapple segment animations ;;;
{
$94:B18B             dw 0005,3A21
$94:B18F             dw 0005,3A22
$94:B193             dw 0005,3A23
$94:B197             dw 0005,3A24,
                        B0F4,B18B  ; Go to $B18B
}
}


;;; $B19F: Free space ;;;
{
$94:B19F             fillto $94C800, $FF
}


;;; $C800: Tiles - gunship liftoff dust clouds ;;;
{
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |DCEECD4D|E4444EDE|E444E444|444E3887|    4EEE|EEE4E4E4|        |        |        |        |        |        |    CDDD|        |        |        |
; |EDCCD4DE|4444EDEE|EEE4E444|EE444438| 444EDDD|DDDEDEDE|       4|44444444|     D  |  D     |    DCDD|  DD    | D  CD  |    DD  |      D |        |
; |4EDD4444|444EDEEE|EEE4EEE4|E4E4E444|4E4EEDCE|CCCECECE|   44444|EFFFFFFF|   DCCDD| DDD D  |   DCBCD| DCCDD  |  DDD CC|DDC  C  |D  D   D|DD     D|
; |444444EE|EEEEE4EE|EE4444EE|4E4E4E4E|EDEDDDE4|ECD4D4D4|  44DED4|DFEDCCCC|  DCBBCD|DDCCD   |  DCBCD |DDDCCD  |  CD DCD|D D   C |  D    D|   D    |
; |E444DDEE|444E4EE4|4444EEE4|E4E4E4EE|EDEEEDDD|EDDE4444| 444C4CE|EFEECEEE| DDC1BCC|CC1BCD  |  DCCD D|CDCDDD  |DDCD C D|        |   DD   |DDDD    |
; |44EDEE44|4444EE44|4EEEEEEE|4FFFFFFF|4EEEDDDD|EDEEEE44| 444D4DE|444ED444|  DCBCBB|BCBBCDD |  DDC DB|CCDCDDD |DCD     |D  D    | D  D   | D      |
; |CDDEEEEE|E44EE44E|EEEE4FFF|F4EEEDDD|EE4EEEEE|E4444444|44EEEEEE|4EE4E4ED| DDCCB1B|BBCCCD  | DDDD BB|CDCBCDD |  C DD D|  DCDD D|        |    DD  |
; |4EEEEEEE|EEEE44EE|EE4FF444|EEDDCDCC|44444444|4444444 |44444444|4EE444EE|DCCBCBBB|BBCDD   | DDBCDCD|DDDCCDDD|  CCD  D|    CDDD|  D     |   D D D|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |EEEE44  |    4EEE|4FFFEE44|4E4EEDDD|        |        |        |        |DCBBBBBB|BBBBCD  | DCCDDCC|DDD  D  |DDC  C  |   DDDC |D       |   D    |
; |E4      |     E44|FFEDDE44|44E4EEDD|        |        |        |        |DDCBCCBB|BBCBBCD | DDDDCCD|D  DDCD |DD  C   |   DDCD |DD      |        |
; |        |     EE4|FDCEE44E|4E444EED|        |        |        |        | DDCCBCB|CCCBCCD |  DDD DD|DD   DCD|  D  D  |  D DD  |        |   D    |
; |        |        |EEDDEEE4|E4E4EFFF|        |        |        |        |  CCDCB1|BDCCCD  |  DD  CC|DDD  DCD|  DD    |    D   |      D |D DD    |
; |        |        |  EEDEFF|4F4F4444|        |        |        |        | DDCDDCB|CDDDD   | DDC  BB|CCD DDD |D   DC D|D  D  D |  DD   D|        |
; |        |        |    FFEE|EE4E4E4E|        |        |        |        |   D DDC|DD D  D |   DDDCB|BD  D   |    DDCD| D    D | DD D   | D      |
; |        |        |      44|EEE4E4EE|        |        |        |        |       D|D       |  D  DDC|DDD     |  D   DC|   D D  |  D  DD |       D|
; |        |        |        |  44EEEE|        |        |        |        |        |        |        |        |      DD|        |      D |     D  |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |C   DDDD|        |        |        |D   DDDD|        |        |        |
; |        |        |        |        |   D    |      D |        |        | CDD  DD|        |        |        | DDD  DD|        |        |        |
; |      DD| D      |        |        |DDCCDDDD| D DDD D| D      |  DD    |CCDD    |        |DDDD    |  DD    |DDDD    |        | DDD    |        |
; |    DDDC|CDDDD DD|DD      |       C|DCCCDCDD|D D DDDD|        |  DD    |  DDD  D|   CDDD |DDDDD   |  DD    |  DDD  D|   DDDD |DDDDD   |        |
; |   CCCCC|CDDD  DD|DD      |      DD|CCBBCCDD|DDDDCCCC|DD D    |    D   |DD DCCCC| DDDCD  |  CCC   |    D   |DD DDD  |  DDD   |   DD   |        |
; |  CCCCBB|BCCDDDDC|CCDD    |    D DC|CCBCCCDD|D DDCCBC|DDDD    |     DDD| D  CCCD|DDDCCC  | DCCC DD|     DDD| D    DD|DD  DD  | DDDD DD|        |
; |  CCDC11|BCCCCBC1|1BCCD   |    DDCC|BCCCCD  |DDDDDDBB|CC D    |    C   |  D CCD |DD  DD  |   DCC  |    D   |  D     |DD      |   D D  |        |
; |  DDDC1B|BCCCCCC1|BBCCD   |    DDCB|BCCCDD  |DDDDDDCC|CCDD    |     CDD|     CD | D  DD  |   CCC  |     DDD|     DD | D      |   DDD  |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | DCCCCBB|CBBBBBCB|BBCCCD  |    DCCB|BCDDD DD|CCDCBCDD|DDDDDD  |D D  CDD|   C  DD|        |        |D D  DDD|   D    |        |        |        |
; |D DCDCCC|B111BBBC|CCCCCDC |   DDCCB|CBDDDCDC|CCDDCCDD|DDDD D  |D DDC   |   C    |        |     C C|D DDD   |   D    |        |     D D|        |
; | DDCDCCB|B11BBBBC|CCCCDDC |  D DDCD|CC  DDBB|CCCCDDCC|DDDDDD  |DD CDD  |        |DD      |        |DD DDD  |        |DD      |        |        |
; |  DCCBCB|BB1BBBBC|CDCDDC  |   DDDDD|BCD CDCB|BCCCDDCC|CCDDDD  |DDC  D  |        |      DD|D       |DDD  D  |        |      D |D       |        |
; |  DCCBCC|BBBBBBBB|BBCCDC  |  DDDDCD|DD DCCBB|CCCDCCBB|CCCDDD  |    C   |DDDD   D|    DD  | D    D |    D   |D D    D|    DD  | D    D |        |
; |  DCCBCB|BBBBBBBB|BBCCD   |  DDDDDD|DD  BBBC|CCCCCCBB|BCDDDD  |     C  |       D|     DCC|DDD   D |     D  |        |     DDD|  D   D |        |
; |   DDCBD|BBBBBBBC|CBBBCDD |  DDDDCB|CCDDCCCC|CDDCDDBB|CCCDDDDD|    CCCC|DD     D|       C|CCDD D D|     D  | D     D|       D|  DD D D|        |
; | DDDDCCC|CBBBBBBB|BBCCCDD |  DDDDBB|CCDDCCCD|DCCCDDCC|CCDDDDDD|   DCCCC|        |        |CCDD   D|   D    |        |        |  DD   D|        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | DDDCDDD|BCBBCBBB|CBCCCDD |  DDCCBB|CDDDCBCC|DDCDCD  |DDDD    | DDDCCC |        |      DD|DDD     | DDD D  |        |      DD| DD     |        |
; |D DCCCDD|CBB1BBDB|BCCCD   | DDDCCCC|DDDDBBCC|CDDDDD  |D DDDDD |DDCDCC  |        |       D|D    C  |DDDD D  |        |        |D    D  |        |
; |DDDDDCDD|DCCBCCDC|CBBD    |  DDDCDC|DDCBBCDD|DDD  DDD|DDCCDD  |DDCD    |        |        | DC  D  |DDD     |        |        | DD  D  |        |
; | DDDDCDD|DCCBCCDC|BBBD    |  DDDCDD|DDCCCCCD|DD  D DD|DDCCDD  | DDD    |        |    D   |D   D   | DDD    |        |    D   |D   D   |        |
; |  DD DDD|DDDCDDCC|BBCC    |    DDDC|DD  DDCD|DDDD D  |  DDCCDD|        |  DD    |    DD  |   D    |        |  DD    |    DD  |   D    |        |
; |   DDDD |   DDD C|CCC     |    DDDD|DDCDDDCD|CDDCDD  |D DDCBDD|        |  DD    |    DD  | DDD    |        |  DD    |    DD  |  DD    |        |
; |        |   DDD  |C       |    DDDD| D  CCCC|DCDDDDDD|  DDCCDD|      D |        |        | D      |      D |        |        | D      |        |
; |        |        |        |    DDDD|  D CCCC|CCCCDD  |D DDCCDD|        |  D  D  |        | D      |        |  D  D  |        | D      |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |  D DDCC| DD BBCB|CCCCDD  |DDDDDD  |DD      |  DCDDDD|      D |    DD  |DD      |  DD D D|      D |    D   |        |
; |        |        |        |  DDDDCC|DDD BBBB|CCCCDD  |DDDDDD  |DD      | DCCDCDD|DD      |    CD  |DD      |  DDD  D|        |    D   |        |
; |        |        |        |      DD|DDCDCBBB|BBDD  D |DD D    |        |D   CCDC|  DD    |    DD D|        |D       |  DD    |    D  D|        |
; |        |        |        |      DD|DDCCCCBB|BBDD    |DD      |        |  DDCCDD|  D     |   CCD  |        |  DDDDDD|  D     |   D D  |        |
; |        |        |        |    D   |  DDCCCC|DDDDDD  |        |    DD  |    DDC |       D|  DCDD  |    DD  |    DDD |       D|  DDDD  |        |
; |        |        |        |     D  |  DDDDCC|DDDDDD  |        |    DD  |       C|      DD| DDDD   |    DD  |       D|      DD| DDDD   |        |
; |        |        |        |        |        |        |        |        |    DD  |        |DD D D  |        |    DD  |        |DD D D  |        |
; |        |        |        |        |        |        |        |        |    DDDD|        |  D     |        |    DDDD|        |  D     |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |    DD  |    DD  |        |        |        |        |        |        |        | D  D   | DDD D  | D  D  D|     D  |        |        |
; |      D |        | D      |  D     |        |        |        |        |      D |D       | D      |   DDDDD|DD D    |DDDD    |        |        |
; |     D  |        |        |        |        |        |        |        | D DDDDD|CCDD    |   DDDDD|D D  DD |    D   |     D  |        |        |
; |      D |        |        |    D   |     D  |        |       D|DD      | DDCCCDC|CCD     | D   DDD|DDDD DD |      D |      D |        |        |
; |  D     |D       | D      |D    D  |  D DDDD|        |  DCCDDC|CDD     |D CCCDCC|BCDDD   |DD     D|DDD   D |        |      D |        |        |
; | DDD    |  D     |  D  D  |        |   DCDDC|DD      |DDCCCCCB|CCDD    |  DDDCDC|CBCCDD  |        |DDDD   D|        |      DD|        |        |
; |  D  D  |        |        |        |  DCCCBB|CCD     | DDCDCBB|CCCCD   |  CDDCCD|CBBCCD  |D    DDD|  DDD DD|D       |       D|        |        |
; |        |        |        |D       |  D DDCB|BCCD    | DCDDCBC|BCCCCD  |    CCDD|CCBCCD  | D      |DD DD   |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |     DD |    DCCB|CCD     |   DCCCB|CCBCDD  | DDCCDDC|DCCCD   |   DD   |DDDDD  D|   D    |    D  D|        |        |
; |        |        |        |        |   D DDC|CDD     |    DCCD|CCBCC   |   DCDDC|DCBBDD  |  D  D  |  D  D  |   DD   |     D  |        |        |
; |        |        |        |        |    D CD|D D     |    DCCD|DCCCD   |D  DCCDD|DBBCC   |DD   DD | DDD D  |        |     D  |        |        |
; |  D    D|        |        |        |   D    |        |  D D D |DDCDD   | D  D   |CCCCD   |      D |  D D   |      D |        |        |        |
; |  D     |        |        |        |        |D       |   D   D| DD     |  D   DD|CCCDD   |D       |D     DD|D       |       D|        |        |
; |   D    |        |        |       D|        |        |        | D  D   |     D D|CCD D   |        |D    DD |        |        |        |        |
; |        |        |        |        |        |        |     D  |        |  D D  D|  D     |        |   D    |        |   D    |        |        |
; |  D     |        |        |        |        |        |        |        |        |        |       D|D   D   |       D|   DD   |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |D D     |        |        |  D D   | D      |        |        |        |        |        |        |        |        |        |        |        |
; |D    D  |        |        |        |      D |      D |        |        |        |        |        |        |        |        |        |        |
; |        |   D    |     D  |        |D DD    |       D|        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |  D     |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        | D      |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |    D   |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |    DD  |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |     D D|        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |    D   |       D|       D|   D    |D       |        |        |        |        |        |        |        |        |        |        |        |
; |     D  |        |        |   D    | D      |        |        |        |        |        |        |        |        |        |        |        |
; |  D     |        |        |    D   |        |        |        |        |        |        |        |        |        |        |        |        |
; |  DD    |   D    |        | D  D   |        |   D  D |        |        |        |        |        |        |        |        |        |        |
; |    D   |    D   |        |        |  D    D|        |        |        |        |        |        |        |        |        |        |        |
; |    DD  |       D|   DD   |        | D  D   |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |   D    |  D  DD |       D|        |        |        |        |        |        |        |        |        |        |
; |        |    DD  |        |  D     |      D |     D  |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|

$94:C800             db 85,30,4A,81,30,40,00,03,0C,83,10,2C,60,1F,00,7F,FF,FD,FF,FB,FF,70,FF,03,FF,8F,FF,3C,FF,FF,FF,7F,
                        02,85,04,0B,08,17,00,FB,00,16,00,0C,00,99,00,F3,FF,87,FF,0F,FF,1F,FF,FB,FF,16,FF,0C,FF,99,FF,F3,
                        00,88,00,E8,00,EE,00,C3,00,0E,00,7F,07,F7,18,D8,FF,88,FF,E8,FF,EE,FF,C3,FF,0E,FF,7F,FF,F7,FF,D8,
                        09,19,02,C2,00,A8,00,55,00,AB,7F,7F,87,B8,34,C0,F1,16,FC,C1,FF,A8,FF,55,FF,AB,FF,7F,FF,BF,FF,FF,
                        00,07,07,08,04,59,5C,A2,47,B8,0F,70,00,DF,00,00,0F,07,7F,0F,FF,5F,FF,FE,FF,FF,FF,7F,FF,DF,FF,00,
                        00,EA,EA,15,00,15,2A,80,60,90,40,BC,00,80,00,00,FF,EA,FF,FF,FF,FF,FF,EA,FF,F0,FF,FC,FF,80,FE,00,
                        00,00,00,00,00,00,0A,04,00,01,0A,01,00,3F,00,00,00,00,01,00,1F,00,3F,0E,7F,0B,7F,0B,FF,3F,FF,00,
                        00,00,00,00,7F,FF,D0,60,40,F7,08,10,01,6A,00,63,00,00,FF,00,FF,FF,FF,FF,FF,FF,FF,18,FF,6B,FF,63,
                        00,00,04,00,13,00,2D,0C,6C,04,2B,0B,67,05,97,17,00,00,04,04,1F,1F,33,3F,73,77,34,3F,78,7D,E8,FF,
                        00,00,20,00,74,00,C8,00,34,10,B6,B0,C4,C0,D8,C0,00,00,20,20,74,74,F8,F8,CC,DC,4E,FE,3C,FC,38,F8,
                        00,00,0B,00,15,04,2A,08,25,00,33,01,7B,03,75,10,00,00,0F,0F,1B,1F,36,3E,3D,3D,3A,3B,78,7B,6F,7F,
                        00,00,30,00,4C,00,E4,00,5C,00,2E,00,56,10,E7,00,00,00,30,30,7C,7C,FC,FC,FC,FC,FE,FE,EE,FE,FF,FF,
                        07,00,44,00,38,00,15,00,D1,00,A0,00,0D,00,09,00,0F,0F,4C,4C,3B,3B,37,37,F5,F5,E0,E0,2D,2D,39,39,
                        00,00,0C,00,C0,00,A0,00,00,00,90,00,2D,00,07,00,00,00,0C,0C,E4,E4,A2,A2,00,00,90,90,3D,3D,0F,0F,
                        00,00,02,00,91,00,21,00,18,00,48,00,00,00,20,00,00,00,02,02,91,91,21,21,18,18,48,48,00,00,20,20,
                        00,00,00,00,C1,00,10,00,F0,00,40,00,0C,00,15,00,00,00,00,00,C1,C1,10,10,F0,F0,40,40,0C,0C,15,15,
                        00,F0,00,80,00,00,00,00,00,00,00,00,00,00,00,00,FC,F0,C0,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,07,00,04,00,06,00,00,00,00,00,00,00,00,00,00,0F,07,07,04,07,06,00,00,00,00,00,00,00,00,00,00,
                        70,7C,D8,E4,C0,99,30,CE,0B,37,0C,0F,00,00,00,00,FF,7C,FF,FC,FF,F9,FF,FE,3F,3F,0F,0F,03,00,00,00,
                        07,58,03,2C,01,46,07,AF,50,50,00,D5,00,EB,00,0F,FF,5F,FF,2F,FF,47,FF,AF,FF,50,FF,D5,FF,EB,3F,0F,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        BF,3F,D3,13,65,05,0B,02,6D,01,16,00,01,00,00,00,C0,FF,EC,FF,7A,7F,3C,3E,7E,7F,17,17,01,01,00,00,
                        F4,F0,DA,D8,12,10,C4,80,78,00,D2,00,80,00,00,00,0C,FC,26,FE,EE,FE,7C,FC,F8,F8,D2,D2,80,80,00,00,
                        4C,00,79,00,3B,00,30,00,63,03,1D,01,26,00,00,00,7F,7F,7F,7F,3B,3B,33,33,70,73,1E,1F,27,27,00,00,
                        E4,00,9A,00,C5,00,E5,00,2E,00,C8,80,E0,00,00,00,E4,E4,9E,9E,C7,C7,E7,E7,EE,EE,48,C8,E0,E0,00,00,
                        C0,00,C0,00,24,00,30,00,89,00,0D,00,22,00,03,00,E4,E4,C8,C8,24,24,30,30,8D,8D,0F,0F,23,23,03,03,
                        1C,00,1A,00,2C,00,08,00,92,00,42,00,14,00,00,00,1E,1E,1E,1E,2C,2C,08,08,92,92,42,42,14,14,00,00,
                        80,00,C0,00,00,00,02,00,31,00,68,00,26,00,02,00,80,80,C0,C0,00,00,02,02,31,31,68,68,26,26,02,02,
                        10,00,00,00,10,00,B0,00,00,00,40,00,01,00,04,00,10,10,00,00,10,10,B0,B0,00,00,40,40,01,01,04,04,
                        00,00,00,00,03,00,0E,00,00,00,03,03,0B,00,3B,01,00,00,00,00,03,03,0F,0F,1F,1F,3C,3F,3C,3C,3C,3D,
                        00,00,00,00,40,00,7B,00,73,00,9E,80,85,84,81,80,00,00,00,00,40,40,FB,FB,F3,F3,7F,FF,7A,FE,7E,FE,
                        00,00,00,00,00,00,C0,00,C0,00,30,00,C8,40,C8,C0,00,00,00,00,00,00,C0,C0,C0,C0,F0,F0,38,78,38,F8,
                        00,00,00,00,00,00,00,00,03,00,0A,00,0C,00,0D,01,00,00,00,00,00,00,01,01,03,03,0B,0B,0F,0F,0E,0F,
                        00,00,10,00,CF,00,8B,00,33,30,23,20,84,80,8C,80,00,00,10,10,FF,FF,FF,FF,CF,FF,DF,FF,7C,FC,7C,FC,
                        00,00,02,00,5D,00,AF,00,F0,00,B2,02,FF,03,FC,00,00,00,02,02,5D,5D,AF,AF,FF,FF,BD,BF,FC,FF,FF,FF,
                        00,00,00,00,40,00,00,00,D0,00,F0,00,10,00,30,00,00,00,00,00,40,40,00,00,D0,D0,F0,F0,D0,D0,F0,F0,
                        00,00,00,00,30,00,30,00,08,00,07,00,00,00,03,00,00,00,00,00,30,30,30,30,08,08,07,07,08,08,07,07,
                        0F,00,33,00,30,00,39,00,D0,00,41,00,22,00,02,00,8F,8F,73,73,F0,F0,39,39,DF,DF,4F,4F,2E,2E,06,06,
                        00,00,00,00,00,00,0E,00,74,00,E0,00,CC,00,4C,00,00,00,00,00,00,00,1E,1E,7C,7C,FC,FC,CC,CC,4C,4C,
                        00,00,00,00,F0,00,F8,00,00,00,43,00,10,00,00,00,00,00,00,00,F0,F0,F8,F8,38,38,7B,7B,1C,1C,1C,1C,
                        00,00,00,00,30,00,30,00,08,00,07,00,08,00,07,00,00,00,00,00,30,30,30,30,08,08,07,07,08,08,07,07,
                        8F,00,73,00,F0,00,39,00,DC,00,43,00,20,00,06,00,8F,8F,73,73,F0,F0,39,39,DC,DC,43,43,20,20,06,06,
                        00,00,00,00,00,00,1E,00,38,00,CC,00,C0,00,40,00,00,00,00,00,00,00,1E,1E,38,38,CC,CC,C0,C0,40,40,
                        00,00,00,00,70,00,F8,00,18,00,7B,00,14,00,1C,00,00,00,00,00,70,70,F8,F8,18,18,7B,7B,14,14,1C,1C,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        43,03,A8,00,69,01,25,05,24,04,25,05,1B,02,78,00,7C,7F,BF,BF,7E,7F,3A,3F,3B,3F,3A,3F,1D,1F,7F,7F,
                        7D,7D,FE,8E,FE,9E,FE,DE,FF,FF,FF,FF,FE,FE,7F,7F,82,FF,01,8F,01,9F,01,DF,00,FF,00,FF,01,FF,80,FF,
                        C4,C0,04,00,0C,00,58,00,C8,C0,C8,C0,76,70,C6,C0,3C,FC,FE,FE,FE,FE,FC,FC,3C,FC,38,F8,8E,FE,3E,FE,
                        09,01,19,01,2D,00,1F,00,3D,00,3F,00,3D,01,3F,03,0E,0F,1E,1F,2F,2F,1F,1F,3F,3F,3F,3F,3E,3F,3C,3F,
                        BB,80,7A,40,0F,03,A5,81,D3,03,CE,0E,30,00,31,00,7B,FB,BF,FF,CC,CF,6E,EF,DC,DF,C1,CF,FF,FF,FF,FF,
                        2B,08,33,00,0C,00,8C,80,13,03,03,03,6F,03,8C,00,F7,FF,FF,FF,FF,FF,7F,FF,FC,FF,FC,FF,FC,FF,FF,FF,
                        FC,00,F4,00,FC,00,3C,00,1C,00,BC,80,1F,00,3F,00,FC,FC,F4,F4,FC,FC,FC,FC,FC,FC,7C,FC,FF,FF,FF,FF,
                        A3,00,B0,00,CC,00,C4,00,00,00,00,00,00,00,10,00,A7,A7,B8,B8,DC,DC,E4,E4,08,08,04,04,0F,0F,1F,1F,
                        03,00,00,00,00,00,00,00,F1,00,01,00,C1,00,00,00,13,13,10,10,00,00,00,00,F1,F1,01,01,C1,C1,00,00,
                        00,00,00,00,C0,00,03,00,0C,00,04,00,00,00,00,00,00,00,00,00,C0,C0,03,03,0C,0C,07,07,01,01,00,00,
                        00,00,00,00,00,00,80,00,42,00,E2,00,35,00,31,00,00,00,05,05,00,00,80,80,42,42,E2,E2,F5,F5,F1,F1,
                        A7,00,B8,00,DC,00,E4,00,08,00,04,00,04,00,10,00,A7,A7,B8,B8,DC,DC,E4,E4,08,08,04,04,04,04,10,10,
                        10,00,10,00,00,00,00,00,A1,00,00,00,41,00,00,00,10,10,10,10,00,00,00,00,A1,A1,00,00,41,41,00,00,
                        00,00,00,00,C0,00,02,00,0C,00,07,00,01,00,00,00,00,00,00,00,C0,C0,02,02,0C,0C,07,07,01,01,00,00,
                        00,00,05,00,00,00,80,00,42,00,22,00,35,00,31,00,00,00,05,05,00,00,80,80,42,42,22,22,35,35,31,31,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        77,00,A3,00,FB,00,7B,00,37,00,1E,00,00,00,00,00,7F,7F,BF,BF,FF,FF,7F,7F,37,37,1E,1E,00,00,00,00,
                        B7,B7,7F,6D,92,10,92,10,EC,00,1C,00,1C,00,00,00,48,FF,82,EF,EF,FF,EF,FF,FF,FF,1D,1D,1C,1C,00,00,
                        46,40,88,80,70,60,F0,E0,C0,C0,00,00,00,00,00,00,BE,FE,78,F8,90,F0,10,F0,30,F0,E0,E0,80,80,00,00,
                        33,03,70,00,3A,00,3B,00,0E,00,0F,00,0F,00,0F,00,3C,3F,7F,7F,3F,3F,3F,3F,0F,0F,0F,0F,0F,0F,0F,0F,
                        74,04,FC,0C,DB,18,C1,00,CD,00,DD,00,40,00,20,00,FB,FF,F3,FF,E7,FF,FF,FF,CF,CF,FF,FF,4F,4F,2F,2F,
                        D4,00,7C,00,E7,00,CB,00,F4,00,6C,00,BF,00,0C,00,FC,FC,FC,FC,E7,E7,CB,CB,F4,F4,FC,FC,FF,FF,FC,FC,
                        F0,00,BE,00,CC,00,CC,00,33,00,B7,04,33,00,B3,00,F0,F0,BE,BE,FC,FC,FC,FC,3F,3F,BB,BF,3F,3F,BF,BF,
                        70,00,D0,00,D0,00,70,00,00,00,00,00,02,00,00,00,7E,7E,FC,FC,F0,F0,70,70,00,00,00,00,02,02,00,00,
                        00,00,00,00,00,00,00,00,30,00,30,00,00,00,24,00,00,00,00,00,00,00,00,00,30,30,30,30,00,00,24,24,
                        03,00,01,00,00,00,08,00,0C,00,0C,00,00,00,00,00,03,03,01,01,00,00,08,08,0C,0C,0C,0C,00,00,00,00,
                        E0,00,80,00,44,00,88,00,10,00,70,00,40,00,40,00,E0,E0,84,84,64,64,88,88,10,10,70,70,40,40,40,40,
                        74,00,F4,00,E0,00,70,00,00,00,00,00,02,00,00,00,74,74,F4,F4,E0,E0,70,70,00,00,00,00,02,02,00,00,
                        00,00,00,00,00,00,00,00,30,00,30,00,00,00,24,00,00,00,00,00,00,00,00,00,30,30,30,30,00,00,24,24,
                        03,00,00,00,00,00,08,00,0C,00,0C,00,00,00,00,00,03,03,00,00,00,00,08,08,0C,0C,0C,0C,00,00,00,00,
                        60,00,84,00,64,00,88,00,10,00,30,00,40,00,40,00,60,60,84,84,64,64,88,88,10,10,30,30,40,40,40,40,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        2C,00,3C,00,03,00,03,00,08,00,04,00,00,00,00,00,2F,2F,3F,3F,03,03,03,03,08,08,04,04,00,00,00,00,
                        6D,0D,EF,0F,D7,07,C3,03,30,00,3C,00,00,00,00,00,62,6F,E0,EF,F8,FF,FC,FF,3F,3F,3F,3F,00,00,00,00,
                        0C,00,0C,00,F2,C0,F0,C0,FC,00,FC,00,00,00,00,00,FC,FC,FC,FC,32,F2,30,F0,FC,FC,FC,FC,00,00,00,00,
                        FC,00,FC,00,D0,00,C0,00,00,00,00,00,00,00,00,00,FC,FC,FC,FC,D0,D0,C0,C0,00,00,00,00,00,00,00,00,
                        C0,00,C0,00,00,00,00,00,0C,00,0C,00,00,00,00,00,C0,C0,C0,C0,00,00,00,00,0C,0C,0C,0C,00,00,00,00,
                        2F,00,4B,00,82,00,33,00,0C,00,00,00,0C,00,0F,00,3F,3F,7F,7F,8F,8F,3F,3F,0E,0E,01,01,0C,0C,0F,0F,
                        02,00,C0,00,30,00,20,00,01,00,03,00,00,00,00,00,02,02,C0,C0,30,30,20,20,01,01,03,03,00,00,00,00,
                        0C,00,04,00,0D,00,04,00,2C,00,78,00,D4,00,20,00,0C,0C,0C,0C,0D,0D,1C,1C,3C,3C,78,78,D4,D4,20,20,
                        C0,00,C0,00,00,00,00,00,0C,00,0C,00,00,00,00,00,C0,C0,C0,C0,00,00,00,00,0C,0C,0C,0C,00,00,00,00,
                        35,00,39,00,80,00,3F,00,0E,00,01,00,0C,00,0F,00,35,35,39,39,80,80,3F,3F,0E,0E,01,01,0C,0C,0F,0F,
                        02,00,00,00,30,00,20,00,01,00,03,00,00,00,00,00,02,02,00,00,30,30,20,20,01,01,03,03,00,00,00,00,
                        08,00,08,00,09,00,14,00,3C,00,78,00,D4,00,20,00,08,08,08,08,09,09,14,14,3C,3C,78,78,D4,D4,20,20,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,02,00,04,00,02,00,20,00,70,00,24,00,00,00,00,00,02,02,04,04,02,02,20,20,70,70,24,24,00,00,
                        0C,00,00,00,00,00,00,00,80,00,20,00,00,00,00,00,0C,0C,00,00,00,00,00,00,80,80,20,20,00,00,00,00,
                        0C,00,40,00,00,00,00,00,40,00,24,00,00,00,00,00,0C,0C,40,40,00,00,00,00,40,40,24,24,00,00,00,00,
                        00,00,20,00,00,00,08,00,84,00,00,00,00,00,80,00,00,00,20,20,00,00,08,08,84,84,00,00,00,00,80,80,
                        00,00,00,00,00,00,04,00,2F,00,16,00,23,03,2D,01,00,00,00,00,00,00,04,04,2F,2F,1F,1F,3C,3F,2E,2F,
                        00,00,00,00,00,00,00,00,00,00,C0,00,20,00,90,80,00,00,00,00,00,00,00,00,00,00,C0,C0,E0,E0,70,F0,
                        00,00,00,00,00,00,01,00,26,00,C1,01,6B,03,5A,02,00,00,00,00,00,00,01,01,3F,3F,FE,FF,7C,7F,7D,7F,
                        00,00,00,00,00,00,C0,00,60,00,30,00,08,00,84,80,00,00,00,00,00,00,C0,C0,E0,E0,F0,F0,F8,F8,7C,FC,
                        00,00,02,00,5F,00,62,00,84,00,3A,00,19,00,03,00,00,00,02,02,5F,5F,7F,7F,BF,BF,3F,3F,3F,3F,0F,0F,
                        00,00,80,00,30,00,20,00,B8,80,4C,40,64,60,24,20,00,00,80,80,F0,F0,E0,E0,78,F8,BC,FC,9C,FC,DC,FC,
                        48,00,40,00,1F,00,47,00,C1,00,00,00,87,00,40,00,48,48,40,40,1F,1F,47,47,C1,C1,00,00,87,87,40,40,
                        74,00,1F,00,A6,00,F6,00,E2,00,F1,00,3B,00,D8,00,74,74,1F,1F,A6,A6,F6,F6,E2,E2,F1,F1,3B,3B,D8,D8,
                        49,00,D0,00,08,00,02,00,00,00,00,00,80,00,00,00,49,49,D0,D0,08,08,02,02,00,00,00,00,80,80,00,00,
                        04,00,F0,00,04,00,02,00,02,00,03,00,01,00,00,00,04,04,F0,F0,04,04,02,02,02,02,03,03,01,01,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,21,00,20,00,10,00,00,00,20,00,00,00,00,00,00,00,21,21,20,20,10,10,00,00,20,20,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        06,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,06,06,00,00,00,00,00,00,00,00,01,01,00,00,00,00,
                        09,01,16,00,09,00,10,00,00,00,00,00,00,00,00,00,0E,0F,17,17,0B,0B,10,10,00,00,00,00,00,00,00,00,
                        20,00,60,00,A0,00,00,00,80,00,00,00,00,00,00,00,E0,E0,E0,E0,A0,A0,00,00,80,80,00,00,00,00,00,00,
                        11,01,09,00,09,00,2A,00,11,00,00,00,04,00,00,00,1E,1F,0F,0F,0F,0F,2A,2A,11,11,00,00,04,04,00,00,
                        2C,20,20,20,88,00,D8,00,60,00,48,00,00,00,00,00,DC,FC,D8,F8,F8,F8,F8,F8,60,60,48,48,00,00,00,00,
                        66,00,16,00,93,00,48,00,23,00,05,00,29,00,00,00,7F,7F,1F,1F,9F,9F,48,48,23,23,05,05,29,29,00,00,
                        88,00,BC,30,E0,60,08,00,18,00,28,00,20,00,00,00,F8,F8,CC,FC,98,F8,F8,F8,F8,F8,E8,E8,20,20,00,00,
                        18,00,24,00,C6,00,02,00,80,00,00,00,00,00,01,00,18,18,24,24,C6,C6,02,02,80,80,00,00,00,00,01,01,
                        F9,00,24,00,74,00,28,00,83,00,86,00,10,00,88,00,F9,F9,24,24,74,74,28,28,83,83,86,86,10,10,88,88,
                        10,00,18,00,00,00,02,00,80,00,00,00,00,00,01,00,10,10,18,18,00,00,02,02,80,80,00,00,00,00,01,01,
                        09,00,04,00,04,00,00,00,01,00,00,00,10,00,18,00,09,09,04,04,04,04,00,00,01,01,00,00,10,10,18,18,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        A0,00,84,00,00,00,00,00,00,00,00,00,00,00,00,00,A0,A0,84,84,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,10,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,10,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,04,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,04,04,00,00,00,00,00,00,00,00,00,00,
                        28,00,00,00,00,00,00,00,00,00,08,00,00,00,00,00,28,28,00,00,00,00,00,00,00,00,08,08,00,00,00,00,
                        40,00,02,00,B0,00,20,00,00,00,00,00,00,00,00,00,40,40,02,02,B0,B0,20,20,00,00,00,00,00,00,00,00,
                        00,00,02,00,01,00,00,00,40,00,00,00,0C,00,05,00,00,00,02,02,01,01,00,00,40,40,00,00,0C,0C,05,05,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        08,00,04,00,20,00,30,00,08,00,0C,00,00,00,00,00,08,08,04,04,20,20,30,30,08,08,0C,0C,00,00,00,00,
                        01,00,00,00,00,00,10,00,08,00,01,00,00,00,0C,00,01,01,00,00,00,00,10,10,08,08,01,01,00,00,0C,0C,
                        01,00,00,00,00,00,00,00,00,00,18,00,00,00,00,00,01,01,00,00,00,00,00,00,00,00,18,18,00,00,00,00,
                        10,00,10,00,08,00,48,00,00,00,00,00,10,00,20,00,10,10,10,10,08,08,48,48,00,00,00,00,10,10,20,20,
                        80,00,40,00,00,00,00,00,21,00,48,00,26,00,02,00,80,80,40,40,00,00,00,00,21,21,48,48,26,26,02,02,
                        00,00,00,00,00,00,12,00,00,00,00,00,01,00,04,00,00,00,00,00,00,00,12,12,00,00,00,00,01,01,04,04,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
}


;;; $DC00: Free space ;;;
{
$94:DC00             fillto $94E000, $FF
}


;;; $E000: Tiles - title BG (mode 7) ;;;
{
; Spills over to next bank
; Decompressed to $7F:0000..3FFF around $8B:9BB7, then transferred to VRAM $0000..3FFF through $2119
$94:E000             db 00, 00, 22, 24, 03, 28, 23, 24, 24, C2, 08, 05, 23, 28, 23, 23, 24, 00, 22, 24, CC, 10, 22, 24, CC, 10, 22, 24, CB, 10, 07, 23, 23, 28, 26, 27, 23, 24, 28, 22, 24, 00, 28, 22, 24, C2, 13, C5, 10, 22, 24, 00, 28, 22, 24, C8, 10, 22, 24, 00, 28, 22, 24, C8, 10, 22, 24, 00, 27, 22, 24, 08, 28, 26, 25, 21, 25, 26, 23, 23, 27, C4, 08, 22, 24, CC, 10, 22, 24, CC, 10, 22, 24, CC, 10, E4, 5A, 24, 24, 23, 22, 24, 24, 23, 22, 24, 22, 27, 01, 23, 23, 22, 24, 00, 26, C2, BE, 00, 23, 22, 24, 00, 27, C3, 08, 22, 24, 01, 00, 00, 25, 24, C3, 08, 23, 23, 22, 00, 24, 24, 23, 00, C2, 26, 00, 23, 22, 00, C2, 35, 01, 23, 27, C4, 07, 03, 24, 21, 24, 00, C2, 3A, C2, 07, 00, 25, C2, 07, 03, 25, 21, 24, 25, 28, 24, 03, 23, 23, 28, 28, 22, 27, 00, 26, 22, 23, 01, 28, 28, 22, 27, C5, 12, 22, 27, C2, 65, 02, 23, 28, 28, 43, 27, 23, C4, 09, 01, 24, 23, C3, 13, 02, 23, 28, 26, C4, 82, 23, 24, 00, 23, 22, 26, C2, 1F, 83, 7F, 00, 63, 25, 03, 26, 26, 25, 21, 62, 25, C2, 16, C3, 08, 00, 26, C8, 08, 25, 24, 00, 23, 22, 27, C2, 7F, C2, 05, 00, 26, 44, 24, 25, 01, 26, 23, 27, 27, 26, 26, 01, 23, 26, 25, 25, 01, 23, 26, 22, 25, 22, 21, 01, 23, 26, 23, 25, C3, 08, 00, 26, 22, 25, 00, 21, C2, 3B, 01, 26, 26, 22, 25, 03, 21, 24, 23, 27, 22, 26, C2, 09, 01, 27, 27, 24, 00, 03, 21, 27, 00, 23, 23, 00, 02, 21, 27, 27, 24, 00, C3, 10, 23, 00, 02, 21, 27, 27, 24, 00, C3, 10, 23, 00, 02, 21, 27, 27, 24, 00, C3, 10, 23, 00, 28, 24, 01, 23, 26, C2, 99, 01, 25, 27, 28, 24, 03, 23, 23, 27, 27, 22, 26, C4, 08, 22, 26, C4, 08, 22, 26, C4, 08, 22, 26, C4, 08, 22, 26, 00, 27, 22, 23, 23, 27, C5, 98, 02, 21, 21, 24, 22, 26, C3, 08, 00, 25, 22, 26, C4, 08, 22, 26, C4, 08, 22, 26, C4, 08, 22, 26, 24, 25, 26, 26, 23, 00, 01, 25, 21, 24, 00, 03, 21, 26, 00, 21, 22, 00, C2, 07, 00, 00, 43, 25, 21, 00, 26, 24, 00, 02, 25, 25, 21, 26, 00, 03, 21, 26, 25, 25, 24, 00, C2, 06, 00, 26, 24, 00, 00, 26, 35, 00, 03, 26, 26, 21, 00, 43, 00, 26, 01, 21, 00, C2, A2, C2, 07, 00, 21, 22, 00, 00, 26, 22, 00, C3, 4A, 00, 26, 23, 00, C2, 41, 00, 21, 24, 00, C2, 67, 02, 2C, 27, 27, 24, 00, 03, 2C, 27, 00, 23, 23, 00, 02, 2C, 27, 27, 24, 00, 03, 2D, 27, 00, 23, 23, 00, 02, 2D, 27, 27, 24, 00, C3, 10, 23, 00, 01, 2A, 26, 22, 24, 02, 2B, 2B, 2A, 22, 24, 24, 2B, E4, 27, 00, 25, 2B, 23, 2A, 22, 2D, 22, 2C, 27, 2B, 83, AB, 01, 22, 24, 00, 00, 83, 99, 01, 87, 35, 00, 22, 24, CC, 10, 22, 24, CC, 10, 22, 24, C7, 10, 22, 00, 01, 27, 27, 23, 23, C3, 08, 83, BF, 02, 00, 00, 83, 70, 01, 62, 25, 02, 00, 00, 23, 22, 24, 01, 23, 23, 22, 00, 01, 27, 26, 62, 25, 22, 00, 22, 24, 01, 23, 23, 22, 00, 01, 27, 26, 62, 25, 22, 00, 22, 24, 01, 23, 23, 23, 28, 83, B8, 02, 84, E2, 01, 22, 24, 23, 28, C8, 10, 22, 24, 23, 28, C8, 10, 22, 24, 23, 28, C8, 10, 22, 24, 00, 23, C3, 75, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, 02, 23, 26, 27, 25, 23, 01, 26, 27, 25, 23, 00, 26, 25, 27, 00, 23, 26, 26, 27, 23, 26, 00, 00, 24, 25, 00, 01, 24, 27, 23, 00, 03, 25, 21, 27, 26, 23, 00, 03, 21, 25, 27, 25, 22, 00, 00, 24, 22, 27, 00, 21, 22, 00, 04, 24, 28, 25, 21, 21, 22, 00, 03, 27, 28, 28, 21, C2, 18, 05, 24, 25, 21, 28, 28, 25, C3, 89, 02, 21, 25, 24, 83, E1, 01, 01, 21, 25, C2, 92, C5, 07, 01, 26, 28, C6, 07, C2, 2A, C4, 07, 03, 23, 21, 21, 28, C3, 07, 00, 23, C2, 2C, C3, 07, 83, 76, 00, 02, 28, 23, 23, 22, 24, 00, 28, 85, B9, 01, 02, 28, 24, 23, 25, 24, 00, 23, 25, 24, 00, 23, 22, 24, 22, 23, C3, 08, 83, B1, 01, 22, 24, C2, F4, 01, 27, 23, 22, 24, C5, 08, 00, 00, 27, 24, 83, 8A, 02, C2, 43, 01, 23, 26, 44, 24, 25, 00, 26, C8, 10, 48, 25, 24, C4, 10, 02, 25, 24, 21, 44, 24, 25, 02, 21, 24, 21, C4, 10, 01, 21, 23, 47, 25, 24, C2, 66, 02, 24, 24, 23, 43, 23, 24, 84, B4, 04, C3, 06, 24, 24, CA, 10, 24, 24, CA, 10, 24, 24, C6, 10, 23, 00, 03, 23, 00, 27, 21, 24, 00, 02, 27, 27, 21, 23, 00, C3, 10, 24, 00, 02, 27, 27, 21, 23, 00, C3, 10, 24, 00, 02, 27, 27, 21, 23, 00, C3, 10, 24, 00, C2, 10, C4, DF, 00, 26, 85, 9F, 01, C3, 09, 83, B0, 03, C3, E2, 01, 2A, 27, 25, 24, 00, 2D, 83, 96, 01, 22, 2B, 85, 88, 03, 00, 24, C2, 08, 00, 27, 24, 00, 01, 2C, 27, 25, 00, 01, 26, 26, 23, 25, 04, 21, 21, 27, 26, 26, 22, 25, C4, 08, 23, 25, 00, 21, 27, 24, 22, 2A, 04, 2D, 2A, 2D, 2D, 2C, 22, 2B, 24, 2A, 01, 00, 00, 25, 2B, 2A, 00, 01, 26, 25, 23, 00, 00, 26, C2, 3B, 83, 33, 03, 01, 21, 27, C4, 9E, 01, 26, 27, 22, 00, 04, 21, 21, 00, 26, 27, 23, 00, 03, 21, 21, 25, 27, 24, 00, 01, 21, 21, 24, 00, 02, 21, 25, 21, 23, 00, 00, 25, 34, 00, 00, 26, 25, 00, 02, 26, 25, 26, 23, 00, C2, 55, 00, 25, C4, 95, 23, 00, 01, 27, 27, 27, 00, 00, 26, 26, 00, 22, 28, 24, 27, C3, 07, 43, 26, 25, 27, 24, 01, 27, 26, 24, 25, 01, 23, 26, 22, 25, 22, 23, 00, 26, 22, 25, 00, 23, 44, 26, 25, 01, 26, 23, 24, 26, 27, 24, 22, 27, 24, 26, 02, 25, 26, 25, 43, 25, 21, 00, 21, 27, 24, C4, 0F, 22, 21, C3, 07, 23, 21, 02, 25, 21, 25, 24, 21, 01, 25, 26, 25, 25, 00, 24, 26, 27, 00, 00, 26, 24, 02, 00, 24, 24, 23, 23, 03, 28, 00, 24, 24, 24, 23, 03, 00, 24, 28, 24, 22, 23, 05, 28, 24, 28, 27, 24, 24, 22, 23, 00, 28, 62, 26, 84, 3F, 00, 62, 26, 00, 24, 22, 23, 83, 62, 05, C3, 10, 27, 24, 83, A4, 01, 00, 28, 22, 27, 23, 28, 23, 27, C4, 10, 22, 27, 23, 28, C2, 06, 00, 26, C4, 10, 02, 28, 26, 25, 23, 28, 03, 27, 23, 26, 21, C4, 10, 02, 23, 25, 21, 27, 24, 01, 26, 27, 22, 26, C2, 9D, 00, 27, 24, 26, 03, 25, 25, 27, 27, 22, 26, 43, 25, 26, 00, 27, 23, 26, 22, 25, 02, 26, 27, 26, 43, 26, 25, 02, 21, 26, 27, 22, 26, C3, D6, 01, 27, 26, 43, 26, 25, 23, 26, 25, 25, 01, 21, 25, 23, 21, 22, 25, 24, 21, C3, 10, 22, 21, 00, 26, 22, 25, 22, 21, 00, 26, 22, 25, 83, 17, 03, 24, 25, C3, 0F, 01, 21, 25, 43, 25, 21, C2, 08, 02, 00, 00, 24, C2, 45, 01, 28, 24, 22, 00, 83, 2F, 01, 83, 47, 01, 01, 28, 24, 22, 27, C2, 07, C2, 16, C2, EC, 03, 27, 26, 21, 26, 43, 28, 24, 04, 27, 21, 26, 26, 28, 22, 24, C5, 2E, C4, 08, 00, 26, 22, 24, 00, 26, C2, D5, C2, 08, C2, 2F, 02, 23, 26, 25, 85, 47, 01, 01, 24, 24, 22, 00, 00, 28, 25, 24, 00, 00, 22, 24, 22, 27, 22, 24, 02, 27, 26, 26, 62, 25, 02, 24, 27, 26, 22, 25, 04, 21, 26, 24, 26, 25, 62, 25, 01, 26, 24, C2, 68, 86, B2, 05, 26, 24, C9, 10, CC, 08, 22, 24, C4, 08, 22, 24, 00, 23, 22, 27, 00, 23, 23, 24, 00, 23, 84, A8, 01, 86, E1, 05, 01, 23, 26, 44, 24, 25, 89, CF, 05, 00, 26, 44, 24, 25, C2, 62, 85, F2, 01, 01, 23, 27, 44, 24, 25, 00, 27, 23, 24, 00, 21, 22, 24, 84, B6, 04, 62, 25, 84, E0, 04, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, 24, 00, 02, 27, 25, 21, 25, 00, 01, 27, 25, 26, 00, 00, 27, E4, 27, 00, 03, 21, 24, 00, 26, 84, 73, 03, C2, 4A, 83, 54, 03, 01, 21, 24, 22, 00, 01, 25, 27, C4, 08, 00, 25, 23, 00, 44, 25, 24, C2, 50, C2, D0, 01, 00, 24, 83, 68, 07, 00, 26, 83, 4D, 09, 00, 21, 22, 00, C2, 64, 01, 27, 24, 31, 00, 01, 26, 26, 22, 00, C2, 04, 02, 26, 21, 26, C3, 0C, C2, 55, 00, 21, C3, 04, 00, 27, 22, 00, 83, FF, 08, 2E, 00, 00, 26, 26, 00, 00, 21, 26, 00, 02, 26, 21, 26, 26, 00, 01, 21, 21, 26, 00, 01, 21, 21, 26, 00, C3, 51, 24, 00, 01, 26, 26, 2E, 00, 01, 24, 21, 24, 00, 02, 26, 26, 21, 23, 00, 03, 21, 00, 24, 21, 22, 00, C3, 6E, 01, 21, 26, 43, 26, 00, C2, 0F, 02, 21, 21, 26, 22, 24, 00, 26, 22, 00, 83, 75, 09, 24, 00, 01, 21, 26, E4, 21, 00, 00, 24, 24, 00, 22, 24, 22, 00, 22, 24, 84, 4E, 04, 00, 24, 23, 23, 00, 00, 26, 24, 24, 00, 22, 24, 22, 00, 22, 24, 02, 23, 28, 00, 28, 24, 22, 23, 02, 28, 28, 27, 23, 23, 83, 62, 08, 22, 23, 84, 88, 07, C6, 07, 00, 26, 27, 24, 84, 38, 08, 22, 23, 00, 26, 62, 26, 84, 7D, 04, 62, 26, 00, 24, 22, 23, 86, 20, 08, C2, 50, 01, 28, 24, 23, 23, 02, 00, 24, 24, 23, 23, C3, 60, 24, 23, 00, 00, 26, 24, 23, 28, 02, 27, 23, 25, 86, 77, 08, 01, 26, 21, 23, 28, 83, C8, 01, 01, 23, 28, 44, 28, 27, 00, 26, 23, 28, 23, 27, C4, 10, 22, 27, 23, 28, 23, 27, 27, 24, 02, 21, 25, 27, 22, 26, 83, 73, 09, 01, 27, 26, 43, 26, 25, 62, 25, 22, 26, 00, 25, 62, 25, 22, 26, 83, 8D, 08, 00, 27, 23, 26, 02, 25, 25, 27, 23, 26, 43, 25, 26, 00, 27, 23, 26, 01, 25, 25, 27, 24, 22, 25, 85, F3, 08, 43, 25, 21, 02, 26, 25, 21, 22, 25, 02, 21, 21, 26, 23, 25, 83, DA, 08, 00, 26, 23, 25, 23, 21, 84, B5, 08, 23, 21, 22, 25, 24, 21, 23, 26, 23, 25, 02, 24, 26, 25, 62, 25, 83, 7C, 09, 01, 26, 21, 23, 25, 83, 51, 04, C3, 1E, 02, 00, 00, 24, 24, 27, 22, 00, 24, 24, 37, 00, 02, 25, 25, 26, 22, 24, 00, 27, 83, D0, 09, 01, 00, 00, 22, 24, 01, 27, 24, 23, 00, 02, 24, 27, 24, 25, 00, 00, 24, 3F, 00, C3, 39, 01, 24, 23, 62, 23, 02, 21, 26, 27, 23, 24, C3, 8F, 83, EE, 09, 02, 27, 26, 27, 43, 24, 26, 43, 27, 24, C3, A4, 02, 27, 00, 23, C2, 10, 00, 25, C2, 08, 01, 24, 23, 22, 27, 83, 20, 07, 00, 24, 22, 23, 83, 51, 09, 24, 27, 85, F7, 09, 62, 25, C5, 08, 83, E6, 09, 01, 26, 26, 62, 25, 84, B4, 00, C3, E0, C7, 08, 43, 23, 27, 83, EF, 04, 22, 27, 02, 23, 23, 26, C3, 75, 00, 27, 22, 24, 85, B9, 02, 23, 24, 01, 27, 27, 22, 26, 22, 25, C3, 08, 83, F1, 0C, 22, 27, C5, 08, 03, 24, 21, 27, 25, 22, 21, 00, 27, 22, 24, 23, 27, 87, C8, 02, 27, 25, 26, 21, 00, 25, 25, 27, 01, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, C2, 08, 00, 27, 26, 00, 01, 21, 27, 25, 00, 02, 25, 21, 27, 24, 00, C2, 6D, 00, 27, 24, 00, C3, 09, 24, 00, C3, 09, 24, 00, C3, 09, 24, 00, 03, 28, 25, 21, 27, 22, 00, 00, 27, 23, 25, C3, 07, 23, 21, 84, 7B, 03, 22, 27, C4, 4A, 24, 00, 02, 25, 21, 27, 24, 00, 02, 25, 21, 27, 24, 00, 02, 25, 21, 27, 24, 00, 02, 25, 21, 27, 22, 00, 27, 25, 27, 21, 27, 27, E4, 27, 00, 27, 23, 26, 26, 00, 23, 25, 27, 00, 26, 25, 23, 01, 27, 26, 25, 23, 02, 27, 26, 23, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C3, 08, 28, 23, 27, 26, 27, 27, 2F, 23, 47, 24, 23, 32, 24, C4, 48, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 00, 27, 26, 23, 02, 26, 25, 25, 22, 21, 02, 25, 25, 23, 26, 28, 01, 27, 28, 25, 23, 01, 27, 28, 25, 23, 03, 26, 28, 23, 23, 23, 24, C3, 08, 23, 24, C3, A2, 23, 24, 00, 27, 26, 26, 83, 22, 0E, 22, 21, 00, 25, 27, 24, 01, 23, 28, 25, 23, C3, 40, 23, 24, C3, 08, 23, 24, C3, 40, 23, 24, C3, 08, 23, 24, 83, BE, 02, 23, 24, 62, 25, 00, 23, 24, 24, 02, 28, 28, 23, 23, 24, 23, 23, E4, 23, 24, 84, F8, 0E, 24, 00, 02, 25, 21, 27, 24, 00, 02, 25, 21, 27, 24, 00, 02, 25, 21, 27, 24, 00, 02, 25, 21, 27, 24, 00, 02, 25, 21, 27, 24, 00, 02, 25, 21, 27, 24, 00, 02, 25, 21, 27, 27, 00, 02, 27, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, 02, 27, 21, 25, 24, 00, 01, 27, 21, 24, 25, 23, 26, 23, 21, 83, CE, 0C, 24, 21, 22, 25, 00, 26, 22, 21, 01, 25, 21, 22, 25, 00, 26, 22, 21, 24, 25, 00, 26, 43, 21, 25, 83, CB, 0D, 01, 21, 21, 22, 25, 02, 21, 25, 26, 43, 21, 25, 00, 25, 27, 24, 02, 25, 26, 25, 22, 26, 83, 48, 10, 24, 26, 03, 27, 25, 26, 25, 22, 26, 03, 27, 27, 25, 25, 23, 26, 00, 27, 44, 26, 25, 02, 26, 27, 26, 22, 25, 22, 26, 02, 27, 26, 21, 43, 25, 26, C2, 26, 00, 21, 27, 24, 22, 27, 83, 6A, 08, 00, 23, 23, 27, 23, 28, 22, 27, C4, 10, 03, 26, 28, 27, 27, 23, 28, 01, 25, 26, 84, 69, 08, 04, 23, 21, 26, 23, 27, 23, 28, 02, 21, 25, 23, C4, 10, 26, 24, 01, 00, 28, 23, 23, 02, 24, 24, 00, 24, 23, C3, 10, 22, 23, 03, 24, 28, 24, 00, 22, 23, 83, 66, 10, 84, 7A, 05, 03, 28, 27, 26, 28, 22, 23, C3, 08, 84, 78, 10, 83, D0, 01, 27, 00, 00, 24, 26, 00, 02, 24, 28, 24, 24, 00, 00, 24, 83, 2C, 09, 22, 00, 01, 24, 21, C2, 7B, 83, 4A, 0D, 03, 25, 28, 26, 21, C2, 09, 01, 24, 26, 83, 7E, 00, 83, 1F, 0C, C2, 03, 01, 21, 28, E4, 27, 00, 00, 24, 26, 00, 00, 24, 23, 00, 23, 24, 22, 00, 00, 24, 22, 28, 84, 4A, 0D, 23, 28, 83, 18, 09, 00, 26, 22, 25, 83, 0A, 09, 00, 28, 23, 24, C2, 0F, 03, 28, 24, 2F, 2F, C2, 1D, 00, 25, C2, 08, 00, 29, C2, C2, C4, 08, 00, 26, 83, 3F, 09, C2, 18, 00, 21, 62, 24, C3, 08, 27, 28, 24, 25, 22, 21, 27, 24, 27, 2F, 01, 29, 2F, 26, 29, 00, 2F, 25, 29, 2F, 2F, 27, 28, 22, 25, 23, 21, 00, 25, 27, 24, 26, 2F, 00, 24, 25, 29, 01, 2F, 24, 25, 29, 01, 2F, 24, 26, 2F, 00, 24, 26, 2F, 00, 24, 25, 28, 03, 23, 00, 25, 25, C3, B1, 01, 23, 00, C2, A6, 83, 7F, 06, 00, 00, 43, 28, 25, 00, 25, CA, 10, 43, 28, 25, CB, 10, 43, 28, 25, C3, 10, 30, 24, 45, 23, 24, 30, 23, 27, 27, 27, 26, 27, 23, 03, 48, 46, 48, 44, 23, 00, 00, 44, C3, 09, 23, 00, C4, 09, 23, 00, C4, 09, 23, 00, C4, 09, 23, 00, C3, 09, 24, 00, 02, 44, 48, 46, 25, 00, 01, 44, 48, 23, 00, C3, 18, 24, 00, 02, 44, 48, 46, 25, 00, 01, 44, 48, 26, 00, 00, 44, 27, 00, 00, 44, 26, 00, 01, 48, 44, 25, 00, 02, 46, 48, 44, 24, 00, 00, 44, 26, 00, 01, 48, 44, 25, 00, 02, 46, 48, 44, 24, 00, C3, 74, 23, 00, C4, 7D, 23, 00, C4, 09, 23, 00, C4, 09, 23, 00, 44, 44, 48, 24, 43, 22, 44, 01, 43, 46, 22, 42, 23, 43, 00, 46, 25, 47, 03, 43, 46, 46, 43, 23, 46, 04, 44, 43, 47, 46, 47, 22, 46, C3, 08, 00, 46, 23, 43, C3, 0E, 02, 43, 00, 00, C7, 08, 22, 44, 27, 43, 23, 46, 00, 43, 26, 47, 00, 43, 25, 46, 01, 43, 43, 23, 46, C2, 0F, 00, 44, 23, 43, C3, 08, 22, 00, 00, 43, 22, 47, 00, 43, 22, 00, 00, 43, 22, 47, 00, 43, 84, 70, 11, 22, 25, 85, 78, 11, 23, 25, 02, 26, 21, 21, 23, 25, 01, 26, 21, 43, 21, 25, 01, 25, 26, 23, 21, 22, 25, 23, 21, C3, 10, 24, 21, 26, 25, 23, 26, 01, 25, 25, 22, 26, 02, 27, 25, 21, 43, 25, 26, 84, B4, 11, 00, 25, 22, 26, 84, 8E, 11, 00, 25, 22, 26, C3, 09, 23, 26, 00, 27, 83, 97, 11, 23, 26, 02, 27, 25, 25, 23, 26, 01, 27, 26, 27, 24, 03, 21, 25, 23, 27, 23, 28, 01, 21, 26, 85, FA, 11, 03, 25, 26, 28, 27, 23, 28, 00, 26, 44, 28, 27, 01, 28, 23, 23, 27, 23, 28, 22, 27, C4, 10, 23, 27, 23, 28, 27, 24, 22, 23, 84, C9, 12, 86, 28, 12, 00, 26, 22, 23, 84, 2B, 12, 84, 79, 10, 02, 27, 28, 24, 23, 23, 83, 50, 12, 00, 28, 23, 23, 02, 24, 24, 00, 24, 23, 02, 24, 24, 00, 26, 24, 83, AE, 12, 00, 24, 22, 28, 22, 00, 83, 72, 12, 00, 24, 22, 00, C2, 0F, 01, 24, 24, 22, 00, 84, E9, 12, 22, 00, 03, 24, 28, 21, 24, 23, 00, C3, 08, 23, 00, C3, 08, 23, 00, C3, 20, 24, 00, 04, 28, 26, 21, 21, 24, 22, 00, 00, 28, 83, 3A, 09, 22, 00, 04, 28, 21, 28, 28, 24, 22, 00, 01, 24, 28, 22, 24, 22, 00, 02, 28, 21, 28, 24, 00, 02, 28, 21, 28, 24, 00, 02, 24, 25, 24, 24, 00, 83, 6D, 01, 01, 00, 25, 62, 24, 8B, EC, 12, 00, 28, 84, 19, 09, 01, 2F, 29, 84, 72, 12, C2, 10, C2, 5E, 84, EB, 12, C5, 8F, C2, 10, C9, 08, 01, 26, 28, 22, 24, 00, 2F, 84, 27, 13, 01, 2F, 29, 27, 2F, 23, 29, 02, 2F, 29, 29, 28, 2F, 02, 29, 2F, 29, 34, 2F, 27, 24, 23, 29, C2, 23, 00, 24, 26, 2F, 02, 24, 29, 2F, 22, 29, 02, 2F, 2F, 24, 26, 2F, 00, 24, 26, 2F, 00, 24, 26, 2F, 00, 24, 26, 2F, 28, 24, 87, B0, 13, 43, 28, 25, 83, BC, 13, 43, 28, 25, 03, 25, 24, 24, 00, 43, 28, 25, C3, E8, 43, 28, 25, C3, 08, 43, 28, 25, C3, 08, 43, 28, 25, C3, 08, 43, 28, 26, 83, 8E, 16, 22, 24, 84, FB, 0F, 22, 24, C4, 08, 22, 24, C3, 08, 25, 23, 01, 27, 26, 25, 23, 02, 27, 26, 23, 25, 27, 01, 26, 23, 26, 26, 28, 23, 26, 00, 00, 44, E4, 37, 00, 83, B3, 14, 23, 00, 84, B2, 14, 23, 00, C4, 09, 23, 00, C4, 09, 23, 00, C4, 09, 23, 00, 43, 44, 48, 24, 00, 02, 44, 48, 46, 25, 00, 01, 44, 48, 23, 00, C3, 21, 24, 00, 02, 44, 48, 46, 23, 00, C3, 10, 22, 00, C6, 38, C5, 07, 00, 44, C6, 0E, 00, 48, C3, 07, 22, 00, 03, 46, 46, 48, 44, 23, 00, 8F, F0, 14, 88, F8, 14, 83, E9, 14, 22, 43, C3, 08, 23, 48, C3, 18, 00, 43, 22, 48, 01, 43, 46, 22, 48, 27, 43, 22, 44, 22, 00, 00, 43, 22, 47, 00, 43, 22, 00, 00, 43, 22, 47, 00, 43, 22, 00, 00, 43, 22, 47, 24, 43, 83, 2C, 15, 24, 48, 02, 47, 43, 44, 24, 48, 00, 46, 25, 43, 22, 48, 00, 43, 23, 44, 23, 43, 09, 00, 00, 64, 63, 63, 64, 64, 63, 00, 00, 22, 64, 01, 63, 6B, C2, 0C, 0A, 67, 64, 68, 68, 69, 68, 63, 67, 6F, 67, 6B, 22, 6A, 0C, 67, 62, 6F, 6D, 67, 67, 6E, 6E, 67, 66, 6E, 6C, 6D, 43, 6E, 67, 02, 66, 6E, 6D, C2, 08, 04, 67, 64, 64, 6D, 6E, 43, 6E, 6D, 83, FA, 0D, 83, 86, 15, 22, 24, 02, 26, 25, 21, 62, 25, C6, 10, 22, 24, 02, 26, 25, 21, 62, 25, C6, 10, 22, 24, 02, 26, 25, 21, 62, 25, C6, 10, 22, 24, C4, 08, 83, AF, 01, 83, 31, 09, 00, 28, 22, 24, 01, 28, 26, 22, 28, C7, 10, 22, 24, 01, 28, 26, 22, 28, C7, 10, 22, 24, 01, 28, 26, 22, 28, C7, 10, 22, 24, 84, 6A, 05, 85, F9, 16, 83, C1, 12, C4, 08, F8, 2E, 10, 22, 00, 84, 4A, 16, 23, 00, 83, 72, 16, 23, 00, 83, 7B, 12, 23, 00, 84, 7A, 16, 23, 24, 83, 74, 12, 43, 28, 24, 83, 63, 12, 00, 25, 43, 24, 26, C2, 1F, 83, D9, 09, 00, 28, 25, 00, 02, 24, 25, 24, 24, 00, 02, 24, 21, 24, 24, 00, C2, 3F, 00, 24, 23, 00, 83, F2, 16, 23, 00, 83, 62, 12, 00, 24, 22, 00, C2, 48, 01, 24, 21, 23, 00, 03, 28, 26, 24, 26, 24, 00, C4, 89, 83, 04, 16, 03, 2E, 2E, 00, 00, 25, 24, 2A, 00, 00, 24, 24, 28, C3, A9, 22, 2E, 01, 25, 24, 25, 28, 00, 24, 22, 28, 00, 24, 22, 2E, 83, 52, 16, 23, 2E, 02, 2F, 2E, 2E, 24, 2F, 27, 24, 27, 00, 27, 28, 23, 26, 22, 2E, 00, 26, 22, 28, 00, 24, 23, 28, 00, 2E, 83, FC, 19, 22, 26, 01, 28, 26, 25, 28, 22, 2F, C3, 45, 00, 25, 27, 24, 27, 00, 27, 28, C2, 3D, 83, 8A, 13, 00, 26, 24, 28, 02, 24, 28, 28, 22, 26, 22, 28, 00, 25, 27, 28, 02, 25, 26, 26, 22, 28, 83, B5, 17, 24, 24, C3, 08, 25, 00, 23, 28, 83, BD, 17, 23, 26, 02, 28, 24, 24, 26, 28, 01, 24, 28, 23, 2E, C3, BC, 24, 28, 02, 24, 28, 28, 37, 00, 02, 24, 28, 28, 24, 00, 01, 26, 25, 23, 28, 84, 62, 1A, 02, 25, 25, 26, 22, 28, 00, 21, 83, 94, 16, 04, 28, 26, 24, 21, 28, 83, BD, 19, 00, 21, 26, 27, 00, 23, 26, 26, 00, 27, 25, 25, 01, 26, 23, 22, 21, 22, 25, C3, 08, 23, 25, C3, 08, 22, 25, 03, 26, 26, 23, 21, 22, 25, 83, 0C, 09, 01, 25, 25, 22, 26, 83, B3, 01, 00, 27, 22, 26, 83, 1A, 16, 85, BB, 19, 83, 21, 0E, 83, EF, 02, 86, D0, 01, 89, DF, 01, 00, 23, 25, 24, 00, 23, 84, E1, 09, 22, 27, 00, 26, 44, 24, 25, 00, 26, 28, 24, 00, 26, 22, 27, 83, 17, 16, 22, 27, 01, 28, 28, 22, 23, C5, 07, 83, 1B, 16, 83, FE, 11, 83, C2, 15, C4, 07, 83, 3A, 04, 83, F2, 0D, 22, 24, 83, AA, 09, 01, 24, 26, 25, 24, 01, 00, 00, 23, 23, C3, 08, 24, 24, 22, 00, 03, 23, 27, 24, 24, 23, 00, C2, DA, 01, 24, 24, 22, 00, C2, 76, C4, 09, 83, ED, 05, 83, 48, 0D, 83, EC, 05, 62, 25, 85, 37, 0A, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, 3E, 00, 00, 63, 23, 00, 08, 64, 63, 63, 61, 6F, 69, 6A, 64, 62, 62, 61, 22, 6B, 02, 64, 67, 62, 62, 62, 01, 6B, 64, 84, 42, 19, C3, 46, 23, 28, 22, 24, 02, 26, 25, 21, 62, 25, 02, 23, 23, 24, 23, 28, 22, 24, 02, 26, 25, 21, 62, 25, 02, 23, 23, 24, 23, 28, 22, 24, 02, 26, 25, 21, 62, 25, 02, 23, 23, 24, 23, 28, 22, 24, C4, 10, 23, 23, 83, 16, 0F, 83, E3, 17, C3, 08, 01, 27, 26, 62, 25, 84, C5, 1C, 22, 24, 83, 47, 04, 00, 26, 62, 25, 22, 00, 01, 23, 23, 22, 24, 22, 00, 01, 27, 26, 62, 25, 22, 00, 01, 23, 23, 22, 24, 22, 00, 01, 23, 24, 22, 28, 8C, 25, 1A, 22, 28, 94, 25, 1A, 22, 28, C3, 10, 00, 28, 86, 31, 09, C5, 08, 28, 00, 27, 44, 24, 48, 02, 44, 48, 44, 24, 46, 02, 44, 46, 44, 24, 47, 01, 44, 47, 28, 44, 2F, 00, 03, 64, 63, 64, 64, 23, 63, 00, 6F, 22, 63, 04, 6F, 6F, 67, 64, 6F, 22, 67, 0E, 63, 62, 62, 63, 6B, 64, 67, 66, 67, 63, 63, 64, 6E, 6E, 6F, 22, 67, 05, 63, 62, 6D, 68, 68, 63, 62, 61, 03, 62, 6C, 6E, 68, C3, 1F, 02, 63, 6E, 6E, C2, 11, 04, 63, 68, 68, 28, 28, 25, 24, 00, 28, 24, 26, 01, 25, 25, 27, 28, 25, 24, 27, 28, 83, 6D, 1B, 83, 54, 1C, 22, 24, 83, E7, 11, 02, 24, 28, 23, 85, E6, 11, 04, 24, 24, 25, 28, 28, 24, 2E, 83, 6E, 1B, 23, 25, 27, 28, 01, 27, 27, 24, 26, 02, 25, 28, 27, 45, 27, 26, 47, 28, 24, 26, 23, 00, 28, 27, 24, 25, 2E, 00, 28, 28, 25, 27, 28, 25, 25, 01, 21, 21, 45, 25, 26, 01, 21, 21, 27, 28, 28, 24, 01, 28, 24, 24, 28, 01, 25, 28, 23, 2E, 02, 24, 28, 25, 25, 26, 28, 28, 84, 8F, 15, 04, 27, 27, 28, 21, 25, 22, 26, 01, 27, 27, 28, 28, 27, 24, 27, 28, 00, 24, C3, 73, 83, F5, 1B, 00, 26, 84, 39, 1E, 01, 28, 24, 22, 28, 22, 24, 00, 28, 28, 24, 00, 28, 23, 24, 85, DF, 1A, 02, 25, 26, 28, 27, 24, 84, 17, 1E, C2, 10, 84, F7, 1D, 00, 23, 22, 24, 83, AF, 1D, 27, 24, 00, 23, 22, 24, C3, 10, 27, 24, 00, 23, 22, 24, C3, 10, 27, 24, 00, 23, 22, 24, C3, 10, 23, 24, 85, D1, 09, 43, 26, 24, 43, 25, 24, 00, 26, 84, 89, 02, 02, 24, 27, 26, 47, 24, 25, 00, 23, 88, E1, 05, 44, 24, 25, 88, EF, 05, 47, 24, 25, 84, 3E, 1C, 02, 27, 24, 28, 25, 24, 02, 23, 24, 28, 25, 24, 02, 23, 24, 24, 22, 23, 22, 24, 86, B1, 1C, 43, 24, 23, 83, AB, 09, 22, 24, C4, 08, 28, 24, 83, 77, 1A, 01, 21, 21, 62, 25, 84, D7, 07, 83, 4B, 1C, 86, 3A, 0E, 85, 08, 1F, 00, 21, 83, 47, 0C, C4, 09, 84, 0D, 0C, 02, 28, 21, 21, 84, 0C, 0C, C2, 34, 84, 1B, 0C, 83, DF, 1F, 26, 00, 01, 27, 24, 25, 00, 03, 26, 27, 21, 25, 23, 00, 03, 25, 27, 25, 21, 23, 00, 00, 21, 22, 27, 00, 24, 22, 00, C3, 53, 00, 24, 22, 00, 83, 3B, 05, 00, 27, 22, 00, C2, 61, 00, 21, 83, 84, 1A, 02, 44, 46, 46, 24, 44, C2, 06, 01, 46, 48, 83, A8, 18, C3, 08, 22, 46, 02, 44, 46, 46, 24, 48, 00, 44, 22, 48, 25, 44, C4, 0C, 83, A7, 18, C5, 08, 86, AA, 18, 27, 44, 27, 47, 27, 46, 27, 48, 27, 44, 00, 00, C2, 34, C9, 04, 43, 48, 00, C5, 0A, 24, 44, C2, 6F, C6, 7C, 23, 46, C4, 08, 24, 48, 01, 46, 46, 24, 44, 22, 48, C3, 40, C3, 7A, C8, 08, C2, 3C, C4, 83, 27, 00, 28, 44, 01, 48, 44, 24, 48, 02, 44, 46, 44, 24, 46, 02, 44, 47, 44, 24, 47, 27, 44, 37, 00, 27, 44, 27, 48, 27, 46, 27, 47, 27, 44, 2F, 00, 00, 64, 26, 00, 00, 63, 26, 00, 22, 64, 24, 00, 02, 63, 64, 64, 24, 00, 83, 80, 1E, 23, 00, 00, 61, 22, 63, 08, 64, 6A, 69, 6F, 63, 66, 63, 67, 64, 22, 6B, 00, 68, 43, 68, 64, 02, 64, 6B, 64, 85, F0, 1E, 01, 23, 25, C6, 08, 83, 71, 12, 84, A3, 1B, 00, 24, 23, 28, 44, 24, 00, 02, 28, 28, 24, 24, 00, 01, 24, 24, 33, 00, 45, 23, 25, 01, 24, 24, 45, 23, 26, 22, 24, 45, 28, 24, 00, 00, 45, 00, 24, E4, 21, 00, 43, 24, 28, 83, 9F, 15, 25, 24, 00, 28, 43, 28, 24, 62, 24, 00, 28, 43, 28, 24, 02, 24, 28, 28, 22, 24, 00, 28, 25, 24, 01, 00, 24, 25, 28, 00, 00, 26, 24, 27, 00, 01, 26, 24, 22, 26, 84, 58, 12, 84, E6, 1F, 84, F9, 1E, 84, F2, 1E, C4, 0E, 23, 24, 02, 27, 26, 27, 22, 24, 84, E7, 1E, 22, 28, 25, 24, 00, 27, 84, 71, 12, 83, 4D, 1C, 28, 24, 86, 39, 1E, 26, 24, 83, 5B, 01, 01, 25, 27, 24, 24, 02, 27, 25, 25, 24, 27, 01, 24, 27, 22, 25, 00, 28, C3, 4D, 22, 27, 02, 24, 26, 27, 25, 24, 28, 23, 26, 26, 01, 23, 26, 25, 27, 02, 23, 26, 27, 25, 23, 01, 26, 27, 25, 23, C3, 08, 22, 24, C4, 08, 22, 24, C4, 08, 22, 24, 87, 60, 20, 00, 26, 44, 24, 25, 87, 4E, 20, 43, 26, 24, 43, 25, 24, 83, E6, 17, C3, 10, 43, 27, 24, 43, 25, 24, 01, 27, 23, 22, 24, 00, 21, 23, 24, 83, 50, 1C, 62, 25, 87, A7, 20, 00, 00, 26, 24, 97, 90, 09, C6, 08, 22, 24, 00, 23, 22, 27, 00, 23, 22, 24, 83, FF, 0F, 22, 24, 83, 36, 09, 83, 32, 1B, 01, 00, 00, 62, 24, 02, 23, 28, 24, 22, 00, 85, 50, 09, 25, 24, 02, 28, 24, 24, 22, 27, 23, 24, 83, F0, 1D, C3, F5, 01, 26, 21, 22, 25, C2, E5, 83, 87, 08, 83, 45, 23, 83, C9, 23, 83, 16, 23, 83, 09, 0E, 22, 00, 22, 27, 84, 14, 23, 00, 28, C2, 07, 83, CC, 23, 83, 41, 23, 02, 21, 26, 27, 22, 24, 02, 28, 26, 26, 83, 2F, 0E, 85, 37, 1E, 23, 24, 83, DA, 0D, 00, 24, 88, 78, 21, C3, 08, 87, 75, 21, 8B, 75, 21, DE, 20, 85, B8, 21, 43, 00, 48, 8D, AA, 21, 24, 44, 02, 00, 00, 48, 23, 47, C3, 08, 22, 46, 00, 47, C3, 38, 00, 45, 62, 45, C3, 08, 00, 48, 62, 45, C6, 40, C5, 4B, 83, F1, 21, CA, 08, C7, 18, DF, 20, 26, 00, 00, 44, 25, 00, 01, 44, 48, 24, 00, 02, 44, 48, 46, 23, 00, C3, 21, 22, 00, 8C, 9B, 18, C7, 07, 44, 44, 48, 22, 00, C3, 0E, 23, 00, 02, 46, 48, 44, 24, 00, 01, 48, 44, 25, 00, 00, 44, 35, 00, 00, 44, 25, 00, 01, 44, 48, 24, 00, 02, 44, 48, 46, 23, 00, C3, 53, 22, 00, D6, 68, 02, 46, 48, 44, 22, 00, C3, 07, 23, 00, 02, 46, 48, 44, 24, 00, 01, 48, 44, E4, 2D, 00, 01, 2A, 2A, 25, 2B, 02, 2C, 2C, 2D, 43, 2D, 2A, 00, 2A, 27, 2B, 24, 00, 02, 27, 27, 25, 23, 00, 03, 23, 00, 27, 25, 24, 00, 02, 27, 27, 25, 23, 00, C3, 10, 24, 00, 02, 27, 27, 26, 23, 00, C2, 10, 03, 26, 2A, 2B, 2B, 22, 24, 01, 26, 26, 24, 2B, 22, 24, 86, 58, 16, 22, 00, C4, 08, 22, 00, C4, 08, 22, 00, C4, 08, 22, 00, C4, 08, 22, 00, C4, 08, 22, 00, C4, 08, 22, 00, C6, 08, 26, 24, 83, E0, 16, 84, 23, 1E, 26, 24, 00, 00, 83, D9, 23, 22, 24, C3, 08, 00, 25, 22, 27, 83, 06, 25, 23, 25, 22, 00, 00, 24, 23, 27, 23, 00, 23, 24, 01, 26, 25, 26, 27, 00, 26, 24, 25, 27, 27, 23, 24, 27, 27, 23, 25, 00, 28, 22, 25, 27, 27, 27, 24, 24, 00, 01, 23, 23, 22, 24, 02, 27, 24, 27, 23, 24, 83, A3, 1F, 22, 25, 22, 26, 01, 27, 27, 85, 58, 05, C6, 08, 22, 27, 22, 21, 03, 25, 27, 21, 24, 24, 27, 22, 24, C7, 20, 01, 24, 24, 24, 27, 85, 76, 24, 62, 25, 00, 23, C2, 42, 00, 21, 62, 25, 00, 23, 84, A5, 11, C4, 08, 83, EA, 0D, 84, E7, 04, C5, 08, 02, 26, 23, 27, 43, 27, 23, 04, 26, 21, 26, 23, 23, 22, 27, 84, 31, 06, 01, 27, 26, 24, 24, 83, 8D, 15, 84, 44, 0D, 00, 25, 62, 25, 43, 26, 24, 83, CA, 1D, 83, 4D, 05, 43, 24, 27, 84, 91, 0D, 83, 2C, 27, 22, 27, 00, 23, 83, 1E, 1E, 22, 23, 84, 05, 25, 22, 24, 02, 26, 25, 25, 22, 24, 84, 06, 25, 01, 27, 24, 23, 00, 02, 24, 27, 24, 25, 00, 00, 24, 3F, 00, C3, 98, C3, 5B, 23, 25, 83, 24, 25, 83, 46, 11, C3, 45, 24, 27, 02, 24, 00, 00, 24, 24, 3A, 00, 03, 44, 48, 45, 46, 85, 64, 25, C2, 08, 84, 75, 25, CA, 08, C7, 18, DA, 20, 85, 92, 25, 43, 00, 48, 8B, 8A, 25, 43, 48, 00, CB, 0E, 43, 00, 48, CB, 0E, 43, 48, 00, C8, 0E, 02, 44, 46, 45, 85, EE, 25, CB, 08, C7, 18, F8, 20, 20, 02, 46, 48, 44, 23, 00, 02, 46, 48, 44, 24, 00, C3, 10, 23, 00, C4, 19, 23, 00, C4, 09, 23, 00, C4, 09, 00, 44, 22, 00, C3, 09, 00, 48, 23, 00, C2, 09, 00, 46, 23, 00, C3, 11, 22, 00, 99, 8B, 26, 22, 00, 43, 48, 44, 23, 00, 02, 46, 48, 44, 24, 00, 01, 48, 44, 25, 00, 00, 44, E4, 3E, 00, 01, 26, 00, 24, 24, 22, 00, 85, FA, 1F, 00, 00, 25, 24, 00, 00, 22, 24, 84, 0C, 09, 22, 27, 62, 25, 00, 24, 83, 27, 21, 00, 25, 83, 1C, 29, 23, 27, 00, 24, 22, 00, 23, 24, 25, 00, 25, 28, C3, 40, 00, 26, 22, 25, 83, 87, 1B, 84, 94, 16, 83, 43, 23, C4, 08, DD, 10, 27, 28, 00, 25, 23, 21, 22, 25, 28, 24, 26, 2F, 01, 24, 2F, 25, 29, 01, 24, 2F, 25, 29, 00, 24, 26, 2F, 02, 24, 2F, 29, 44, 29, 2F, 27, 28, 22, 21, 24, 25, 27, 24, 27, 2F, 28, 29, 28, 2F, 25, 29, 00, 2F, 46, 2F, 29, 23, 28, C3, CA, 22, 25, 02, 26, 26, 28, 24, 24, 83, 1B, 25, 00, 28, 83, 7D, 13, 04, 25, 28, 24, 26, 29, C5, 08, 00, 25, C6, 10, 00, 25, C6, 10, C7, 18, 00, 28, 23, 27, 22, 23, 88, 37, 28, C3, 08, 22, 26, C4, 08, 22, 26, 84, 3D, 0E, 22, 26, C4, 08, 22, 26, 24, 25, 22, 26, 00, 25, 26, 26, 00, 25, 27, 24, 83, BD, 11, 02, 27, 26, 23, 28, 24, 22, 26, 84, 38, 10, 22, 26, C4, 08, 22, 26, C4, 08, 22, 26, C4, 08, 22, 26, C4, 08, E4, 27, 00, 01, 2A, 2A, 25, 2B, 22, 2C, 22, 2D, 01, 2A, 2A, 27, 2B, 24, 00, 02, 27, 27, 2C, 23, 00, 03, 23, 00, 27, 2C, 24, 00, 02, 27, 27, 2C, 23, 00, C2, 10, 00, 2D, 24, 00, 02, 27, 27, 2D, 23, 00, C3, 10, 02, 2A, 2B, 2B, 22, 24, 01, 26, 2A, 24, 2B, 22, 24, E4, 3F, 00, 83, 3C, 2A, 85, 7C, 21, 00, 48, 85, 73, 29, C7, 08, 22, 48, 24, 44, 01, 46, 45, 24, 48, 04, 46, 44, 44, 45, 48, 22, 46, 00, 45, 86, 49, 21, 62, 44, 24, 44, 85, BC, 29, 43, 00, 48, 8D, AA, 29, 27, 44, 27, 48, 27, 46, 27, 45, 27, 44, 84, F8, 29, 86, ED, 25, 84, 2C, 2A, C4, 08, 25, 44, 22, 48, 00, 44, 24, 48, 02, 45, 46, 44, 22, 46, 00, 48, C7, 7C, C3, 8C, 24, 44, 02, 46, 45, 44, 29, 24, 06, 27, 26, 22, 25, 27, 23, 22, 84, 3E, 28, 00, 23, 83, EA, 2A, 06, 26, 2A, 2A, 23, 2D, 23, 23, 83, F0, 03, 83, FB, 2C, 23, 23, 0A, 2B, 23, 00, 24, 2B, 2A, 2B, 2D, 2B, 2C, 00, 2E, 24, 03, 23, 27, 25, 22, 83, 3D, 28, 00, 25, 83, 5F, 24, 03, 24, 27, 22, 2D, C2, 38, 05, 26, 24, 27, 25, 2B, 2B, 83, B4, 2C, 22, 23, 00, 2B, 23, 23, 02, 24, 24, 2C, C2, 3D, 03, 2A, 2B, 24, 00, 26, 24, 01, 00, 00, 25, 24, 00, 2B, 83, CC, 28, C3, 5A, 01, 24, 24, 27, 23, 03, 27, 26, 2A, 2D, C2, 89, C6, 88, C7, 98, C7, A8, 27, 24, 00, 2B, 25, 24, 00, 00, C3, 56, 83, E4, 2A, 25, 23, C3, 90, 01, 2D, 2A, 83, 6C, 28, C7, 88, C7, 98, C5, A8, 29, 24, 88, 30, 2B, 84, E0, 16, C4, 08, 85, 2B, 2B, D9, 08, C7, 28, C4, 38, 00, 24, 26, 2F, 00, 24, 43, 2F, 29, C2, 03, 00, 24, 26, 2F, 84, 78, 2B, 22, 29, 00, 24, 26, 2F, 02, 24, 2F, 29, 44, 29, 2F, 00, 24, 26, 2F, C6, 20, 22, 2F, 00, 29, 45, 29, 2F, 45, 2F, 29, 22, 2F, 00, 29, 26, 2F, 25, 29, 29, 2F, 44, 29, 2F, 00, 29, 27, 2F, 02, 29, 29, 2F, 23, 29, 83, 44, 17, 83, FB, 2B, 00, 24, C6, 08, 00, 00, CF, 08, 86, E8, 2B, D0, 08, C7, 20, 01, 21, 21, 23, 25, 83, 10, 29, 22, 25, 03, 26, 26, 27, 21, 23, 25, 02, 26, 26, 27, 27, 24, 84, F1, 26, 27, 2A, 28, 2B, 29, 00, 87, 83, 06, 88, 84, 06, 84, AB, 24, 01, 26, 2A, 25, 24, 01, 27, 2A, 22, 2B, 83, AA, 2E, 01, 2D, 2B, 83, D5, 1D, 02, 00, 27, 2C, 24, 00, 02, 27, 27, 2C, 25, 00, 01, 27, 2C, 24, 26, 22, 27, 00, 21, 43, 21, 25, 02, 25, 26, 25, 27, 24, 22, 21, C4, 11, 23, 21, C3, 09, 24, 21, 01, 25, 21, 26, 25, 01, 26, 25, 26, 27, 00, 24, 24, 27, 22, 28, 43, 25, 26, C3, 09, 27, 24, 00, 23, 24, 25, 02, 26, 27, 26, 22, 23, 22, 25, 44, 26, 25, 00, 23, 22, 25, 24, 26, 02, 23, 26, 26, 2A, 24, 24, 00, 01, 28, 23, 22, 24, 22, 00, 26, 24, 83, 32, 05, 22, 23, C3, BB, 01, 28, 28, 23, 23, C4, 5D, 22, 23, 85, A3, 1F, 01, 23, 23, 27, 24, 37, 00, 00, 24, 26, 00, 22, 24, 24, 00, 01, 23, 23, 22, 24, 22, 00, 23, 23, C3, 09, 26, 24, 3A, 00, 22, 24, 01, 28, 28, 22, 24, 23, 28, 84, C3, 24, 01, 25, 26, 84, 7E, 1B, C2, 11, 00, 21, 43, 21, 28, 01, 26, 25, C2, 06, 85, BF, 1A, 22, 25, 01, 00, 00, 25, 24, 2A, 00, 00, 24, 24, 28, 83, D1, 2B, 04, 24, 2E, 2E, 24, 24, 25, 28, 00, 24, 22, 28, 00, 24, 22, 2E, C3, 5C, 23, 2E, 00, 25, 83, FF, 1A, 22, 2F, 27, 24, 27, 00, 27, 28, 01, 24, 26, C4, 3E, 00, 26, 22, 28, 23, 24, 00, 28, 24, 2E, 02, 24, 24, 28, 23, 2E, C3, 54, 24, 2F, 02, 2E, 2E, 2F, 27, 24, 27, 00, 27, 28, C4, 3D, 02, 26, 28, 26, 24, 28, 02, 24, 28, 28, 24, 2E, 2A, 28, 01, 2E, 2E, 22, 28, 02, 24, 00, 00, 25, 24, 29, 00, 23, 28, C3, 17, 23, 26, 02, 28, 24, 24, 26, 28, 02, 24, 28, 24, 22, 2E, 01, 24, 28, 43, 28, 24, 22, 2E, 02, 24, 28, 28, 27, 24, 88, 37, 1E, 29, 24, 84, 82, 20, 22, 27, 00, 26, 83, A0, 2E, 00, 28, 22, 25, 83, EE, 24, 00, 24, 22, 27, C3, 1B, 25, 24, 83, 1E, 27, 85, 3A, 2F, D2, 08, 87, 33, 2F, 83, A6, 31, D8, 08, 00, 24, 26, 2F, 87, 78, 2F, 00, 24, 26, 2F, 01, 24, 2F, 23, 29, 02, 2F, 29, 24, 26, 2F, 01, 24, 2F, 22, 29, C2, 04, 00, 24, 26, 2F, 27, 24, 27, 2F, 02, 29, 29, 2F, 24, 29, 28, 2F, 01, 29, 2F, 23, 29, 28, 2F, 02, 29, 29, 2F, 23, 29, 28, 2F, 27, 24, 8F, F0, 2F, D3, 10, 83, CD, 32, CF, 08, 22, 24, C3, 08, 2E, 00, 01, 68, 68, 24, 00, 02, 6E, 6D, 6E, 23, 00, 03, 6E, 6D, 6C, 6E, 22, 00, 04, 67, 6E, 6C, 6C, 6D, C2, 1C, C3, 0F, 00, 6E, C2, 07, 08, 66, 6E, 6E, 67, 6D, 67, 68, 67, 66, 62, 66, 00, 67, 25, 00, 03, 64, 63, 68, 68, 22, 00, 04, 64, 63, 62, 6E, 67, C2, 09, 00, 63, C2, 08, C2, 09, 00, 64, C5, 08, 00, 67, C2, 17, 00, 61, 84, 74, 19, C2, 08, 04, 6E, 67, 6E, 64, 63, 22, 62, 02, 67, 66, 66, 22, 63, 00, 62, 22, 63, 25, 00, 02, 62, 63, 63, 24, 00, C2, 08, 01, 64, 64, 22, 63, 62, 61, 00, 63, 22, 62, 04, 63, 61, 61, 62, 62, C2, 03, C4, 08, 22, 61, 00, 63, 23, 62, 00, 61, 62, 61, 02, 68, 63, 63, 23, 62, 00, 63, 27, 00, 22, 64, 24, 00, 00, 63, 84, 7B, 1D, 01, 00, 00, 43, 63, 64, 01, 67, 6B, 22, 63, 08, 64, 64, 68, 6B, 6B, 6A, 6A, 64, 64, 22, 68, 06, 6B, 6A, 69, 64, 64, 6B, 6B, 24, 64, C3, 0D, 02, 6B, 6B, 68, 37, 00, 00, 64, 26, 00, 02, 6B, 63, 64, 24, 00, 62, 69, 00, 64, C3, 6F, C3, 3F, 23, 63, 04, 67, 67, 66, 68, 68, 22, 64, 3C, 00, 00, 64, 24, 00, 24, 64, 22, 00, C6, 9A, 02, 64, 64, 63, 62, 62, C4, 0F, 62, 62, 84, B0, 31, 00, 25, 83, E8, 1A, 83, CB, 32, 02, 26, 24, 28, 22, 24, 22, 28, 28, 24, 01, 28, 28, 23, 24, 89, E7, 1F, 00, 00, 26, 24, 87, 88, 27, 01, 28, 28, 25, 24, 00, 28, 24, 26, 83, ED, 23, 24, 28, 00, 26, 25, 24, 01, 28, 26, 25, 28, C4, 64, 02, 26, 26, 28, 27, 24, 87, F6, 1E, 29, 24, 23, 26, 23, 25, 27, 28, 26, 26, 02, 25, 28, 27, 43, 27, 26, 00, 24, 48, 24, 28, 26, 23, 00, 28, 27, 24, 24, 2E, 02, 24, 28, 28, 23, 25, 22, 21, 00, 25, 27, 28, 24, 25, 22, 21, 27, 24, 27, 28, 28, 24, 01, 28, 24, 26, 28, 00, 24, 22, 2E, 02, 24, 28, 25, 25, 26, 28, 28, 87, 98, 1F, 01, 24, 25, 22, 26, 02, 27, 27, 23, 25, 28, 01, 23, 23, 27, 24, 28, 28, 02, 27, 27, 24, 22, 27, C2, A8, 83, C0, 20, 84, F6, 07, 00, 24, 22, 27, 00, 00, 27, 24, 00, 28, 23, 27, 00, 24, 83, DD, 32, 01, 26, 25, 43, 25, 24, 01, 28, 28, 22, 27, 01, 24, 27, 28, 24, 02, 28, 26, 24, 22, 26, 84, C9, 16, 02, 24, 28, 28, 22, 24, 84, 1A, 33, 83, 8E, 30, 86, E4, 1B, 01, 24, 24, 43, 27, 26, 00, 25, 22, 28, 84, AA, 23, 01, 26, 27, 25, 24, 00, 26, 86, B8, 35, 83, 03, 29, 44, 28, 24, 00, 28, 25, 24, 00, 28, 22, 25, 00, 24, 43, 24, 28, 84, 3D, 2C, 00, 28, 22, 24, 02, 26, 25, 24, 43, 24, 28, 86, 32, 33, C3, 58, 22, 24, 28, 00, 01, 24, 24, 45, 25, 23, 01, 24, 24, 45, 25, 23, 00, 00, 46, 24, 26, 00, 00, 46, 24, 26, 00, 00, 46, 24, 28, 00, 00, 46, 24, 28, 00, 00, 45, 00, 24, 28, 00, C2, 3A, 84, E1, 16, 01, 25, 23, 25, 24, 83, 25, 36, 83, EB, 35, 00, 26, 26, 24, 85, 35, 1E, 83, FF, 2E, 85, E8, 22, 00, 24, 2E, 00, 01, 3F, 34, 24, 00, 01, 32, 3F, 23, 00, 03, 32, 32, 33, 3D, 22, 00, 62, 32, 03, 00, 3D, 00, 00, 62, 32, 00, 00, C5, 08, 03, 3E, 00, 36, 31, C3, 08, 04, 00, 00, 37, 31, 00, 62, 32, 22, 00, 03, 3E, 00, 32, 33, 23, 00, 00, 32, 24, 00, 04, 34, 3F, 33, 32, 32, 23, 00, 04, 3F, 00, 34, 33, 32, 22, 00, C2, 37, C4, 09, 03, 3D, 37, 00, 00, C4, 08, 00, 38, C5, 08, 00, 31, 22, 00, C3, 19, 00, 31, 23, 00, C2, 08, 00, 3E, C4, 48, 01, 36, 37, C2, 11, C2, 08, 01, 37, 34, C3, 08, 03, 34, 00, 34, 32, C4, 78, 02, 34, 33, 3B, C3, 90, C2, 08, 02, 00, 32, 3D, 22, 00, 04, 32, 3C, 00, 00, 3F, 23, 00, 04, 3A, 3B, 00, 3F, 34, 26, 00, C2, 3C, C3, 48, 02, 00, 34, 38, C3, 08, C7, 3F, 00, 31, C2, 3B
}
