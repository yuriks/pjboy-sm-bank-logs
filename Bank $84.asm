;;; $8000..86B3: Routines ;;;
{
;;; $8000: Golden Torizo health-based palette handling ;;;
{
;; Parameter:
;;     A: Health. Assumed to be less than 8000h

; This is a great way to start the PLM bank
$84:8000 DA          PHX
$84:8001 5A          PHY
$84:8002 8B          PHB
$84:8003 4B          PHK                    ;\
$84:8004 AB          PLB                    ;} DB = $84
$84:8005 EB          XBA                    ;\
$84:8006 29 78 00    AND #$0078             ;|
$84:8009 89 40 00    BIT #$0040             ;|
$84:800C F0 03       BEQ $03    [$8011]     ;|
$84:800E A9 38 00    LDA #$0038             ;|
                                            ;} Y = min(7, [A] / 800h) * 20h + 1Eh (source index)
$84:8011 0A          ASL A                  ;|
$84:8012 0A          ASL A                  ;|
$84:8013 09 1E 00    ORA #$001E             ;|
$84:8016 A8          TAY                    ;/
$84:8017 A2 1E 00    LDX #$001E             ; X = 1Eh (destination index)

; LOOP
$84:801A B9 32 81    LDA $8132,y[$84:8210]  ;\
$84:801D 9F 40 C1 7E STA $7EC140,x[$7E:C15E];} Sprite palette 2 + [X] = [$8132 + [Y]]
$84:8021 B9 32 80    LDA $8032,y[$84:8110]  ;\
$84:8024 9F 20 C1 7E STA $7EC120,x[$7E:C13E];} Sprite palette 1 + [X] = [$8032 + [Y]]
$84:8028 88          DEY                    ;\
$84:8029 88          DEY                    ;} Y -= 2
$84:802A CA          DEX                    ;\
$84:802B CA          DEX                    ;} X -= 2
$84:802C 10 EC       BPL $EC    [$801A]     ; If [X] >= 0: go to LOOP
$84:802E AB          PLB
$84:802F 7A          PLY
$84:8030 FA          PLX
$84:8031 6B          RTL

; Golden Torizo palette 1
$84:8032             dw 1000, 56BA, 41B2, 1447, 0403, 4E15, 3570, 24CB, 1868, 6F7F, 51F8, 410E, 031F, 01DA, 00F5, 0C63, ; 0..7FFh
                        1000, 56DB, 39D3, 1047, 0403, 4636, 2D91, 20EC, 1489, 6F9B, 5215, 3D2C, 133B, 0DF6, 0CF2, 0C63, ; 800h..FFFh
                        1000, 52FB, 31F4, 1067, 0402, 3E76, 25B2, 192D, 10A9, 6F96, 5251, 396A, 2756, 1A13, 190F, 0863, ; 1000h..17FFh
                        1000, 531C, 2A15, 0C67, 0402, 3697, 1DD3, 154E, 0CCA, 6FB2, 526E, 3588, 3772, 262F, 250C, 0863, ; 1800h..1FFFh
                        1000, 4F5C, 1E56, 0888, 0001, 2EB8, 1A13, 116F, 0CEB, 73AD, 4EAA, 35A6, 4B8D, 364B, 3509, 0443, ; 2000h..27FFh
                        1000, 4F7D, 1677, 0488, 0001, 26D9, 1234, 0D90, 090C, 73C9, 4EC7, 31C4, 5BA9, 4267, 4106, 0443, ; 2800h..2FFFh
                        1000, 4B9D, 0E98, 04A8, 0000, 1F19, 0A55, 05D1, 052C, 73C4, 4F03, 2E02, 6FC4, 4E84, 4D23, 0043, ; 3000h..37FFh
                        0000, 4BBE, 06B9, 00A8, 0000, 173A, 0276, 01F2, 014D, 73E0, 4F20, 2A20, 7FE0, 5AA0, 5920, 0043  ; 3800h+

; Golden Torizo palette 2
$84:8132             dw 1000, 4215, 2D0D, 0002, 0000, 3970, 20CB, 0C26, 0403, 463A, 28B3, 1809, 6F7F, 51FD, 4113, 0C63, ; 0..7FFh
                        1000, 4236, 252E, 0002, 0000, 3191, 1CEC, 0C47, 0424, 4656, 28D0, 1428, 6F7B, 51F9, 40F0, 0C63, ; 800h..FFFh
                        1000, 3E56, 214F, 0002, 0000, 29D1, 190D, 0888, 0424, 4693, 290E, 1046, 6F76, 4DF5, 40EE, 0842, ; 1000h..17FFh
                        1000, 3E77, 1970, 0002, 0000, 21F2, 152E, 08A9, 0445, 46AF, 292B, 0C65, 6F72, 4DF1, 40CB, 0842, ; 1800h..1FFFh
                        1000, 3AB7, 15B1, 0003, 0000, 1A13, 0D6E, 04CA, 0066, 4ACB, 2568, 0C84, 6B4D, 4A0C, 44C8, 0421, ; 2000h..27FFh
                        1000, 3AD8, 0DD2, 0003, 0000, 1234, 098F, 04EB, 0087, 4AE7, 2585, 08A3, 6B49, 4A08, 44A5, 0421, ; 2800h..2FFFh
                        1000, 36F8, 09F3, 0003, 0000, 0A74, 05B0, 012C, 0087, 4B24, 25C3, 04C1, 6B44, 4604, 44A3, 0000, ; 3000h..37FFh
                        1000, 3719, 0214, 0003, 0000, 0295, 01D1, 014D, 00A8, 4B40, 25E0, 00E0, 6B40, 4600, 4480, 0000  ; 3800h+
}


;;; $8232: Load room PLM GFX ;;;
{
; Called as part of unpausing
$84:8232 08          PHP
$84:8233 8B          PHB
$84:8234 C2 30       REP #$30
$84:8236 4B          PHK                    ;\
$84:8237 AB          PLB                    ;} DB = $84
$84:8238 9C 2D 1C    STZ $1C2D  [$7E:1C2D]  ; PLM item GFX index = 0
$84:823B A2 00 00    LDX #$0000             ; X = 0 (item PLM index)

; LOOP
$84:823E DA          PHX
$84:823F BC 2F 1C    LDY $1C2F,x[$7E:1C2F]  ; Y = [item PLM GFX pointers]
$84:8242 20 64 87    JSR $8764  [$84:8764]  ; Load item PLM GFX
$84:8245 FA          PLX
$84:8246 E8          INX                    ;\
$84:8247 E8          INX                    ;} X += 2 (next item PLM)
$84:8248 E0 08 00    CPX #$0008             ;\
$84:824B D0 F1       BNE $F1    [$823E]     ;} If [X] != 8: go to LOOP
$84:824D AB          PLB
$84:824E 28          PLP
$84:824F 6B          RTL
}


;;; $8250: Clear sounds when going through door ;;;
{
; Called at start of door transition
$84:8250 A9 1D 00    LDA #$001D             ;\
$84:8253 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - clear sounds when going through door
$84:8257 6B          RTL
}


;;; $8258: Unused. Clear spin jump sound when going through door ;;;
{
$84:8258 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$84:825B 29 00 FF    AND #$FF00             ;|
$84:825E C9 00 03    CMP #$0300             ;} If not spin jumping:
$84:8261 F0 05       BEQ $05    [$8268]     ;/
$84:8263 C9 00 14    CMP #$1400             ;\
$84:8266 D0 07       BNE $07    [$826F]     ;} If not wall jumping: return

$84:8268 A9 32 00    LDA #$0032             ;\
$84:826B 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 32h, sound library 1, max queued sounds allowed = 15 (spin jump end)

$84:826F 6B          RTL
}


;;; $8270: Play spin jump sound if spin jumping ;;;
{
; Called at end of door transition
$84:8270 A9 1C 00    LDA #$001C             ;\
$84:8273 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - play spin jump sound if spin jumping
$84:8277 6B          RTL
}


;;; $8278: Unused. Play resumed spin jump sound ;;;
{
$84:8278 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$84:827B 29 00 FF    AND #$FF00             ;|
$84:827E C9 00 03    CMP #$0300             ;} If not spin jumping:
$84:8281 F0 05       BEQ $05    [$8288]     ;/
$84:8283 C9 00 14    CMP #$1400             ;\
$84:8286 D0 07       BNE $07    [$828F]     ;} If not wall jumping: return

$84:8288 A9 30 00    LDA #$0030             ;\
$84:828B 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 30h, sound library 1, max queued sounds allowed = 15 (resumed spin jump)

$84:828F 6B          RTL
}


;;; $8290: Calculate PLM block co-ordinates ;;;
{
;; Parameters:
;;     X: PLM index
$84:8290 BD 87 1C    LDA $1C87,x[$7E:1CD3]  ;\
$84:8293 4A          LSR A                  ;|
$84:8294 8D 04 42    STA $4204  [$7E:4204]  ;|
$84:8297 E2 20       SEP #$20               ;|
$84:8299 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$84:829C 8D 06 42    STA $4206  [$7E:4206]  ;|
$84:829F C2 20       REP #$20               ;|
$84:82A1 EA          NOP                    ;} PLM Y block = [PLM block index] / 2 / [room width in blocks]
$84:82A2 EA          NOP                    ;|
$84:82A3 EA          NOP                    ;|
$84:82A4 EA          NOP                    ;|
$84:82A5 EA          NOP                    ;|
$84:82A6 EA          NOP                    ;|
$84:82A7 AD 14 42    LDA $4214  [$7E:4214]  ;|
$84:82AA 8D 2B 1C    STA $1C2B  [$7E:1C2B]  ;/
$84:82AD AD 16 42    LDA $4216  [$7E:4216]  ;\
$84:82B0 8D 29 1C    STA $1C29  [$7E:1C29]  ;} PLM X block = [PLM block index] / 2 % [room width in blocks]
$84:82B3 6B          RTL
}


;;; $82B4: Write level data block type and BTS ;;;
{
;; Parameter:
;;     A low: BTS
;;     A high: high byte of level data
;;     X: PLM block index
$84:82B4 DA          PHX
$84:82B5 85 12       STA $12    [$7E:0012]  ;\
$84:82B7 E2 20       SEP #$20               ;|
$84:82B9 BF 03 00 7F LDA $7F0003,x[$7F:2D3F];|
$84:82BD 29 0F       AND #$0F               ;} (PLM block type) = [A high] / 10h
$84:82BF 05 13       ORA $13    [$7E:0013]  ;|
$84:82C1 9F 03 00 7F STA $7F0003,x[$7F:2D3F];|
$84:82C5 C2 20       REP #$20               ;/
$84:82C7 8A          TXA                    ;\
$84:82C8 4A          LSR A                  ;|
$84:82C9 AA          TAX                    ;|
$84:82CA E2 20       SEP #$20               ;} PLM BTS = [A low]
$84:82CC A5 12       LDA $12    [$7E:0012]  ;|
$84:82CE 9F 02 64 7F STA $7F6402,x[$7F:7AA0];|
$84:82D2 C2 20       REP #$20               ;/
$84:82D4 FA          PLX
$84:82D5 60          RTS
}


;;; $82D6: Write row of level data block and BTS ;;;
{
;; Parameters:
;;     [[S] + 1] + 1: Level data block
;;     [[S] + 1] + 3: BTS
;;     [[S] + 1] + 5: Number of blocks
;;     X: PLM index
$84:82D6 DA          PHX
$84:82D7 5A          PHY
$84:82D8 A0 01 00    LDY #$0001             ;\
$84:82DB B3 05       LDA ($05,s),y[$84:AD46];} $12 = [(return address) + 1] (level data block)
$84:82DD 85 12       STA $12    [$7E:0012]  ;/
$84:82DF C8          INY                    ;\
$84:82E0 C8          INY                    ;|
$84:82E1 B3 05       LDA ($05,s),y[$84:AD48];} $14 = [(return address) + 3] (BTS)
$84:82E3 85 14       STA $14    [$7E:0014]  ;/
$84:82E5 C8          INY                    ;\
$84:82E6 C8          INY                    ;|
$84:82E7 B3 05       LDA ($05,s),y[$84:AD4A];} $16 = [(return address) + 5] (number of blocks)
$84:82E9 85 16       STA $16    [$7E:0016]  ;/
$84:82EB A3 05       LDA $05,s  [$7E:1FEE]  ;\
$84:82ED 18          CLC                    ;|
$84:82EE 69 06 00    ADC #$0006             ;} (Return address) += 6
$84:82F1 83 05       STA $05,s  [$7E:1FEE]  ;/
$84:82F3 BD 87 1C    LDA $1C87,x[$7E:1CD5]  ;\
$84:82F6 AA          TAX                    ;} X = [PLM block index]
$84:82F7 4A          LSR A
$84:82F8 48          PHA
$84:82F9 A5 12       LDA $12    [$7E:0012]
$84:82FB A4 16       LDY $16    [$7E:0016]  ; Y = (number of blocks)

; LOOP_LEVEL_DATA
$84:82FD 9F 02 00 7F STA $7F0002,x[$7F:048A]; $7F:0002 + [X] = (level data block)
$84:8301 E8          INX                    ;\
$84:8302 E8          INX                    ;} X += 2 (next block)
$84:8303 88          DEY                    ; Decrement Y
$84:8304 D0 F7       BNE $F7    [$82FD]     ; If [Y] != 0: go to LOOP_LEVEL_DATA
$84:8306 E2 20       SEP #$20
$84:8308 FA          PLX                    ; X = [PLM block index] / 2
$84:8309 A5 14       LDA $14    [$7E:0014]
$84:830B A4 16       LDY $16    [$7E:0016]  ; Y = (number of blocks)

; LOOP_BTS
$84:830D 9F 02 64 7F STA $7F6402,x[$7F:6646]; $7F:6402 + [X] = (BTS)
$84:8311 E8          INX                    ; Increment X (next block)
$84:8312 88          DEY                    ; Decrement Y
$84:8313 D0 F8       BNE $F8    [$830D]     ; If [Y] != 0: go to LOOP_BTS
$84:8315 C2 20       REP #$20
$84:8317 7A          PLY
$84:8318 FA          PLX
$84:8319 60          RTS
}


;;; $831A: Load item x-ray blocks (also load room special x-ray blocks) ;;;
{
; Note that any new PLMs created in the free space in this bank will be considered to be an "item PLM",
; meaning the PLM argument specified in the PLM populations will be used as a unique ID in the picked up items table ($7E:D870)
; and won't show an x-ray block if they've been "picked up".

; Note that these same PLMs are expected to have $7E:DF0C,x set to a 'PLM item GFX index',
; which is an index (2k for k in 0..7) to the table of draw instruction pointers responsible for drawing the x-ray tile
$84:831A 08          PHP
$84:831B 8B          PHB
$84:831C C2 30       REP #$30
$84:831E DA          PHX
$84:831F 5A          PHY
$84:8320 4B          PHK                    ;\
$84:8321 AB          PLB                    ;} DB = $84
$84:8322 A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP_PLM
$84:8325 BD 37 1C    LDA $1C37,x[$7E:1C85]  ;\
$84:8328 C9 89 DF    CMP #$DF89             ;} If not an item PLM: go to BRANCH_NEXT
$84:832B 90 32       BCC $32    [$835F]     ;/
$84:832D DA          PHX
$84:832E BD C7 1D    LDA $1DC7,x[$7E:1E0F]  ;\
$84:8331 30 2C       BMI $2C    [$835F]     ;} If [PLM room argument] is negative: go to BRANCH_NEXT (doesn't PLX, will crash)
$84:8333 22 8E 81 80 JSL $80818E[$80:818E]  ;\
$84:8337 BF 70 D8 7E LDA $7ED870,x[$7E:D870];|
$84:833B FA          PLX                    ;} If nth item is picked up (n = [PLM room argument]): go to BRANCH_NEXT
$84:833C 2D E7 05    AND $05E7  [$7E:05E7]  ;|
$84:833F D0 1E       BNE $1E    [$835F]     ;/
$84:8341 DA          PHX
$84:8342 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$84:8346 BF 0C DF 7E LDA $7EDF0C,x[$7E:DF52];\
$84:834A A8          TAY                    ;|
$84:834B BE 9D 83    LDX $839D,y[$84:83A7]  ;} A = [[$839D + [PLM item GFX index]] + 2] & FFFh
$84:834E BD 02 00    LDA $0002,x[$84:A2F3]  ;|
$84:8351 29 FF 0F    AND #$0FFF             ;/
$84:8354 AE 29 1C    LDX $1C29  [$7E:1C29]  ;\
$84:8357 AC 2B 1C    LDY $1C2B  [$7E:1C2B]  ;} Load block [A] to x-ray BG2 tilemap at ([PLM X block], [PLM Y block])
$84:835A 22 4C D0 91 JSL $91D04C[$91:D04C]  ;/
$84:835E FA          PLX

; BRANCH_NEXT
$84:835F CA          DEX                    ;\
$84:8360 CA          DEX                    ;} X -= 2
$84:8361 10 C2       BPL $C2    [$8325]     ; If [X] >= 0: go to LOOP_PLM
$84:8363 AE BB 07    LDX $07BB  [$7E:07BB]  ;\
$84:8366 BF 10 00 8F LDA $8F0010,x[$8F:941B];} If (special x-ray blocks pointer) = 0: return
$84:836A F0 2C       BEQ $2C    [$8398]     ;/
$84:836C AA          TAX                    ; X = (special x-ray blocks pointer)

; LOOP_ROOMVAR
$84:836D BF 00 00 8F LDA $8F0000,x          ;\
$84:8371 F0 25       BEQ $25    [$8398]     ;} If [$8F:0000 + [X]] = 0: return
$84:8373 29 FF 00    AND #$00FF             ;\
$84:8376 85 12       STA $12    [$7E:0012]  ;} $12 = [$8F:0000 + [X]] & FFh
$84:8378 BF 01 00 8F LDA $8F0001,x          ;\
$84:837C 29 FF 00    AND #$00FF             ;} $14 = [$8F:0000 + [X] + 1] & FFh
$84:837F 85 14       STA $14    [$7E:0014]  ;/
$84:8381 DA          PHX
$84:8382 BF 02 00 8F LDA $8F0002,x          ; A = [$8F:0000 + [X] + 2]
$84:8386 A6 12       LDX $12    [$7E:0012]  ;\
$84:8388 A4 14       LDY $14    [$7E:0014]  ;} Load block [A] to x-ray BG2 tilemap at ([$12], [$14])
$84:838A 22 4C D0 91 JSL $91D04C[$91:D04C]  ;/
$84:838E FA          PLX
$84:838F 8A          TXA                    ;\
$84:8390 18          CLC                    ;|
$84:8391 69 04 00    ADC #$0004             ;} X += 4
$84:8394 AA          TAX                    ;/
$84:8395 4C 6D 83    JMP $836D  [$84:836D]  ; Go to LOOP_ROOMVAR

$84:8398 7A          PLY
$84:8399 FA          PLX
$84:839A AB          PLB
$84:839B 28          PLP
$84:839C 6B          RTL

; Pointers to x-ray block drawing instructions
$84:839D             dw A30F, ;\
                        A31B, ;|
                        A327, ;} Misc. items in loaded order
                        A333, ;/
                        A2DF, ; Energy tank
                        A2F1, ; Missile tank
                        A2FD, ; Super missile tank
                        A303  ; Power bomb tank
}


;;; $83AD: Enable PLMs ;;;
{
$84:83AD 08          PHP
$84:83AE C2 20       REP #$20
$84:83B0 A9 00 80    LDA #$8000
$84:83B3 0C 23 1C    TSB $1C23  [$7E:1C23]
$84:83B6 28          PLP
$84:83B7 6B          RTL
}


;;; $83B8: Disable PLMs ;;;
{
$84:83B8 08          PHP
$84:83B9 C2 20       REP #$20
$84:83BB A9 00 80    LDA #$8000
$84:83BE 1C 23 1C    TRB $1C23  [$7E:1C23]
$84:83C1 28          PLP
$84:83C2 6B          RTL
}


;;; $83C3: Clear PLMs ;;;
{
$84:83C3 08          PHP
$84:83C4 C2 30       REP #$30
$84:83C6 DA          PHX
$84:83C7 A2 4E 00    LDX #$004E             ;\
                                            ;|
$84:83CA 9E 37 1C    STZ $1C37,x[$7E:1C85]  ;|
$84:83CD CA          DEX                    ;} PLM IDs = 0
$84:83CE CA          DEX                    ;|
$84:83CF 10 F9       BPL $F9    [$83CA]     ;/
$84:83D1 9C 2D 1C    STZ $1C2D  [$7E:1C2D]  ; PLM item GFX index = 0
$84:83D4 FA          PLX
$84:83D5 28          PLP
$84:83D6 6B          RTL
}


;;; $83D7: Spawn hard-coded PLM ;;;
{
;; Parameters:
;;     [[S] + 1] + 1: X position
;;     [[S] + 1] + 2: Y position
;;     [[S] + 1] + 3: PLM ID
;; Returns:
;;     Carry: set if PLM could not be spawned

; Must be called from lorom bank

$84:83D7 8B          PHB
$84:83D8 5A          PHY
$84:83D9 DA          PHX
$84:83DA 4B          PHK                    ;\
$84:83DB AB          PLB                    ;} DB = $84
$84:83DC A0 4E 00    LDY #$004E             ; Y = 4Eh (PLM index)

; LOOP
$84:83DF B9 37 1C    LDA $1C37,y[$7E:1C85]  ;\
$84:83E2 F0 11       BEQ $11    [$83F5]     ;} If [PLM ID] = 0: go to BRANCH_FOUND
$84:83E4 88          DEY                    ;\
$84:83E5 88          DEY                    ;} Y -= 2
$84:83E6 10 F7       BPL $F7    [$83DF]     ; If [Y] >= 0: go to LOOP
$84:83E8 A3 06       LDA $06,s              ;\
$84:83EA 18          CLC                    ;|
$84:83EB 69 04 00    ADC #$0004             ;} (Return address) += 4
$84:83EE 83 06       STA $06,s              ;/
$84:83F0 FA          PLX
$84:83F1 7A          PLY
$84:83F2 AB          PLB
$84:83F3 38          SEC                    ;\
$84:83F4 6B          RTL                    ;} Return carry set

; BRANCH_FOUND
$84:83F5 E2 20       SEP #$20
$84:83F7 A3 08       LDA $08,s  [$7E:1FF6]  ;\
$84:83F9 48          PHA                    ;} DB = (caller bank)
$84:83FA AB          PLB                    ;/
$84:83FB BB          TYX                    ;\
$84:83FC A0 02 00    LDY #$0002             ;|
$84:83FF B3 06       LDA ($06,s),y[$80:A11F];|
$84:8401 8D 02 42    STA $4202  [$7E:4202]  ;|
$84:8404 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$84:8407 8D 03 42    STA $4203  [$7E:4203]  ;|
$84:840A A0 01 00    LDY #$0001             ;|
$84:840D B3 06       LDA ($06,s),y[$80:A11E];} PLM block index = ([(return address) + 1] * [room width] + [(return address) + 2]) * 2
$84:840F C2 20       REP #$20               ;|
$84:8411 29 FF 00    AND #$00FF             ;|
$84:8414 18          CLC                    ;|
$84:8415 6D 16 42    ADC $4216  [$7E:4216]  ;|
$84:8418 0A          ASL A                  ;|
$84:8419 9D 87 1C    STA $1C87,x[$7E:1CD5]  ;/
$84:841C A0 03 00    LDY #$0003             ;\
$84:841F B3 06       LDA ($06,s),y[$80:A120];} A = [(return address) + 3] (PLM ID)
$84:8421 9B          TXY
$84:8422 AA          TAX
$84:8423 A3 06       LDA $06,s  [$7E:1FF4]  ;\
$84:8425 18          CLC                    ;|
$84:8426 69 04 00    ADC #$0004             ;} Adjust return address
$84:8429 83 06       STA $06,s  [$7E:1FF4]  ;/
$84:842B 4B          PHK                    ;\
$84:842C AB          PLB                    ;} DB = $84
$84:842D 8A          TXA
$84:842E 99 37 1C    STA $1C37,y[$7E:1C85]  ; PLM ID = [A]
$84:8431 BB          TYX
$84:8432 A8          TAY
$84:8433 A9 00 00    LDA #$0000
$84:8436 9D C7 1D    STA $1DC7,x[$7E:1E15]  ; PLM room argument = 0
$84:8439 9F 0C DF 7E STA $7EDF0C,x[$7E:DF5A]; PLM $7E:DF0C = 0
$84:843D A9 69 84    LDA #$8469             ;\
$84:8440 9D D7 1C    STA $1CD7,x[$7E:1D25]  ;} PLM pre-instruction = RTS
$84:8443 B9 02 00    LDA $0002,y[$84:B7ED]  ;\
$84:8446 9D 27 1D    STA $1D27,x[$7E:1D75]  ;} PLM instruction list pointer = [[PLM ID] + 2]
$84:8449 A9 01 00    LDA #$0001             ;\
$84:844C 9F 1C DE 7E STA $7EDE1C,x[$7E:DE6A];} PLM instruction timer = 1
$84:8450 A9 A0 8D    LDA #$8DA0             ;\
$84:8453 9F 6C DE 7E STA $7EDE6C,x[$7E:DEBA];} PLM draw instruction pointer = $8DA0
$84:8457 9E 77 1D    STZ $1D77,x[$7E:1DC5]  ; PLM $1D77 = 0
$84:845A 8E 27 1C    STX $1C27  [$7E:1C27]  ;\
$84:845D BB          TYX                    ;} PLM index = [Y]
$84:845E AC 27 1C    LDY $1C27  [$7E:1C27]  ;/
$84:8461 FC 00 00    JSR ($0000,x)[$84:B7C3]; Execute [[PLM ID]] (PLM setup)
$84:8464 FA          PLX
$84:8465 7A          PLY
$84:8466 AB          PLB
$84:8467 18          CLC                    ;\
$84:8468 6B          RTL                    ;} Return carry clear

$84:8469 60          RTS
}


;;; $846A: Spawn room PLM ;;;
{
;; Parameters:
;;     X: Pointer to room PLM entry
;;         [X]: PLM ID
;;         [X] + 2: PLM X block
;;         [X] + 3: PLM Y block
;;         [X] + 4: PLM room argument
;; Returns:
;;     Carry: set if PLM could not be spawned
$84:846A 08          PHP
$84:846B 8B          PHB
$84:846C 5A          PHY
$84:846D DA          PHX
$84:846E 4B          PHK                    ;\
$84:846F AB          PLB                    ;} DB = $84
$84:8470 A0 4E 00    LDY #$004E             ; Y = 4Eh (PLM index)

; LOOP
$84:8473 B9 37 1C    LDA $1C37,y[$7E:1C85]  ;\
$84:8476 F0 0A       BEQ $0A    [$8482]     ;} If [PLM ID] = 0: go to BRANCH_FOUND
$84:8478 88          DEY                    ;\
$84:8479 88          DEY                    ;} Y -= 2
$84:847A 10 F7       BPL $F7    [$8473]     ; If [Y] >= 0: go to LOOP
$84:847C FA          PLX
$84:847D 7A          PLY
$84:847E AB          PLB
$84:847F 28          PLP
$84:8480 38          SEC                    ;\
$84:8481 6B          RTL                    ;} Return carry set

; BRANCH_FOUND
$84:8482 E2 20       SEP #$20
$84:8484 BF 03 00 8F LDA $8F0003,x[$8F:8003];\
$84:8488 8D 02 42    STA $4202  [$7E:4202]  ;|
$84:848B AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$84:848E 8D 03 42    STA $4203  [$7E:4203]  ;|
$84:8491 BF 02 00 8F LDA $8F0002,x[$8F:8002];|
$84:8495 C2 20       REP #$20               ;} PLM block index = [$8F:0003 + [X]] * [room width] + [$8F:8002 + [X]]
$84:8497 29 FF 00    AND #$00FF             ;|
$84:849A 18          CLC                    ;|
$84:849B 6D 16 42    ADC $4216  [$7E:4216]  ;|
$84:849E 0A          ASL A                  ;|
$84:849F 99 87 1C    STA $1C87,y[$7E:1CD5]  ;/
$84:84A2 BF 04 00 8F LDA $8F0004,x[$8F:8004];\
$84:84A6 99 C7 1D    STA $1DC7,y[$7E:1E15]  ;} PLM room argument = [$8F:0004 + [X]]
$84:84A9 BF 00 00 8F LDA $8F0000,x[$8F:8000];\
$84:84AD 99 37 1C    STA $1C37,y[$7E:1C85]  ;} PLM ID = [$8F:0000 + [X]]
$84:84B0 BB          TYX
$84:84B1 A8          TAY
$84:84B2 A9 00 00    LDA #$0000             ;\
$84:84B5 9F 0C DF 7E STA $7EDF0C,x[$7E:DF5A];} PLM $7E:DF0C = 0
$84:84B9 A9 E6 84    LDA #$84E6             ;\
$84:84BC 9D D7 1C    STA $1CD7,x[$7E:1D25]  ;} PLM pre-instruction = RTS
$84:84BF B9 02 00    LDA $0002,y[$84:B705]  ;\
$84:84C2 9D 27 1D    STA $1D27,x[$7E:1D75]  ;} PLM instruction list pointer = [[PLM ID] + 2]
$84:84C5 A9 01 00    LDA #$0001             ;\
$84:84C8 9F 1C DE 7E STA $7EDE1C,x[$7E:DE6A];} PLM instruction timer = 1
$84:84CC A9 A0 8D    LDA #$8DA0             ;\
$84:84CF 9F 6C DE 7E STA $7EDE6C,x[$7E:DEBA];} PLM draw instruction pointer = $8DA0
$84:84D3 9E 77 1D    STZ $1D77,x[$7E:1DC5]  ; PLM $1D77 = 0
$84:84D6 8E 27 1C    STX $1C27  [$7E:1C27]  ;\
$84:84D9 BB          TYX                    ;} PLM index = [Y]
$84:84DA AC 27 1C    LDY $1C27  [$7E:1C27]  ;/
$84:84DD FC 00 00    JSR ($0000,x)[$84:B371]; Execute [[PLM ID]] (PLM setup)
$84:84E0 FA          PLX
$84:84E1 7A          PLY
$84:84E2 AB          PLB
$84:84E3 28          PLP
$84:84E4 18          CLC                    ;\
$84:84E5 6B          RTL                    ;} Return carry clear

$84:84E6 60          RTS
}


;;; $84E7: Spawn PLM (to current block index) ;;;
{
;; Parameter:
;;     A: PLM ID
;; Returns:
;;     Carry: If PLM is not spawned, carry is unchanged. Otherwise set according to PLM setup, or clear if PLM setup doesn't change the carry (thanks to the lucky ASL at $8500)
$84:84E7 8B          PHB
$84:84E8 5A          PHY
$84:84E9 DA          PHX
$84:84EA 4B          PHK                    ;\
$84:84EB AB          PLB                    ;} DB = $84
$84:84EC A8          TAY                    ; Y = [A]
$84:84ED A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$84:84F0 BD 37 1C    LDA $1C37,x[$7E:1C85]  ;\
$84:84F3 F0 08       BEQ $08    [$84FD]     ;} If [PLM ID] = 0: go to BRANCH_FOUND
$84:84F5 CA          DEX                    ;\
$84:84F6 CA          DEX                    ;} X -= 2
$84:84F7 10 F7       BPL $F7    [$84F0]     ; If [X] >= 0: go to LOOP
$84:84F9 FA          PLX
$84:84FA 7A          PLY
$84:84FB AB          PLB
$84:84FC 6B          RTL                    ; Return

; BRANCH_FOUND
$84:84FD AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$84:8500 0A          ASL A                  ;} PLM block index = [current block index] * 2
$84:8501 9D 87 1C    STA $1C87,x[$7E:1CCF]  ;/
$84:8504 98          TYA                    ;\
$84:8505 9D 37 1C    STA $1C37,x[$7E:1C7F]  ;} PLM ID = [Y]
$84:8508 A9 3D 85    LDA #$853D             ;\
$84:850B 9D D7 1C    STA $1CD7,x[$7E:1D1F]  ;} PLM pre-instruction = RTS
$84:850E B9 02 00    LDA $0002,y[$84:C8AA]  ;\
$84:8511 9D 27 1D    STA $1D27,x[$7E:1D6F]  ;} PLM instruction list pointer = [[PLM ID] + 2]
$84:8514 A9 01 00    LDA #$0001             ;\
$84:8517 9F 1C DE 7E STA $7EDE1C,x[$7E:DE64];} PLM instruction timer = 1
$84:851B A9 A0 8D    LDA #$8DA0             ;\
$84:851E 9F 6C DE 7E STA $7EDE6C,x[$7E:DEB4];} PLM draw instruction pointer = $8DA0
$84:8522 A9 00 00    LDA #$0000
$84:8525 9D 77 1D    STA $1D77,x[$7E:1DBF]  ; PLM $1D77 = 0
$84:8528 9D C7 1D    STA $1DC7,x[$7E:1E0F]  ; PLM room argument = 0
$84:852B 9F 0C DF 7E STA $7EDF0C,x[$7E:DF54]; PLM $7E:DF0C = 0
$84:852F 8E 27 1C    STX $1C27  [$7E:1C27]  ;\
$84:8532 BB          TYX                    ;} PLM index = [Y]
$84:8533 AC 27 1C    LDY $1C27  [$7E:1C27]  ;/
$84:8536 FC 00 00    JSR ($0000,x)[$84:C7BB]; Execute [[PLM ID]] (PLM setup)
$84:8539 FA          PLX
$84:853A 7A          PLY
$84:853B AB          PLB
$84:853C 6B          RTL

$84:853D 60          RTS
}


;;; $853E: Unused. Spawn enemy PLM ;;;
{
;; Parameters:
;;     A: PLM ID
;;     X: Enemy index
$84:853E 8B          PHB
$84:853F 5A          PHY
$84:8540 DA          PHX
$84:8541 4B          PHK                    ;\
$84:8542 AB          PLB                    ;} DB = $84
$84:8543 9B          TXY                    ; Y = [X]
$84:8544 48          PHA
$84:8545 A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$84:8548 BD 37 1C    LDA $1C37,x            ;\
$84:854B F0 09       BEQ $09    [$8556]     ;} If [PLM ID] = 0: go to BRANCH_FOUND
$84:854D CA          DEX                    ;\
$84:854E CA          DEX                    ;} X -= 2
$84:854F 10 F7       BPL $F7    [$8548]     ; If [X] >= 0: go to LOOP
$84:8551 68          PLA
$84:8552 FA          PLX
$84:8553 7A          PLY
$84:8554 AB          PLB
$84:8555 6B          RTL                    ; Return

; BRANCH_FOUND
$84:8556 B9 7E 0F    LDA $0F7E,y            ;\
$84:8559 4A          LSR A                  ;|
$84:855A 4A          LSR A                  ;|
$84:855B 4A          LSR A                  ;|
$84:855C 4A          LSR A                  ;|
$84:855D E2 20       SEP #$20               ;|
$84:855F 8D 02 42    STA $4202  [$7E:4202]  ;|
$84:8562 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$84:8565 8D 03 42    STA $4203  [$7E:4203]  ;|
$84:8568 C2 20       REP #$20               ;} PLM block index = [enemy Y position] / 10h * [room width] + [enemy X position] / 10h
$84:856A B9 7A 0F    LDA $0F7A,y            ;|
$84:856D 4A          LSR A                  ;|
$84:856E 4A          LSR A                  ;|
$84:856F 4A          LSR A                  ;|
$84:8570 4A          LSR A                  ;|
$84:8571 18          CLC                    ;|
$84:8572 6D 16 42    ADC $4216  [$7E:4216]  ;|
$84:8575 0A          ASL A                  ;|
$84:8576 9D 87 1C    STA $1C87,x            ;/
$84:8579 68          PLA
$84:857A 9D 37 1C    STA $1C37,x            ; PLM ID = [A]
$84:857D A8          TAY
$84:857E A9 B3 85    LDA #$85B3             ;\
$84:8581 9D D7 1C    STA $1CD7,x            ;} PLM pre-instruction = RTS
$84:8584 B9 02 00    LDA $0002,y            ;\
$84:8587 9D 27 1D    STA $1D27,x            ;} PLM instruction list pointer = [[PLM ID] + 2]
$84:858A A9 01 00    LDA #$0001             ;\
$84:858D 9F 1C DE 7E STA $7EDE1C,x          ;} PLM instruction timer = 1
$84:8591 A9 A0 8D    LDA #$8DA0             ;\
$84:8594 9F 6C DE 7E STA $7EDE6C,x          ;} PLM draw instruction pointer = $8DA0
$84:8598 A9 00 00    LDA #$0000
$84:859B 9D 77 1D    STA $1D77,x            ; PLM $1D77 = 0
$84:859E 9D C7 1D    STA $1DC7,x            ; PLM room argument = 0
$84:85A1 9F 0C DF 7E STA $7EDF0C,x          ; PLM $7E:DF0C = 0
$84:85A5 8E 27 1C    STX $1C27  [$7E:1C27]  ;\
$84:85A8 BB          TYX                    ;} PLM index = [Y]
$84:85A9 AC 27 1C    LDY $1C27  [$7E:1C27]  ;/
$84:85AC FC 00 00    JSR ($0000,x)          ; Execute [[PLM ID]] (PLM setup)
$84:85AF FA          PLX
$84:85B0 7A          PLY
$84:85B1 AB          PLB
$84:85B2 6B          RTL

$84:85B3 60          RTS
}


;;; $85B4: PLM handler ;;;
{
$84:85B4 08          PHP
$84:85B5 8B          PHB
$84:85B6 4B          PHK
$84:85B7 AB          PLB
$84:85B8 C2 30       REP #$30
$84:85BA 2C 23 1C    BIT $1C23  [$7E:1C23]  ;\
$84:85BD 10 18       BPL $18    [$85D7]     ;} If PLMs not enabled: return
$84:85BF 9C 25 1C    STZ $1C25  [$7E:1C25]  ; PLM draw tilemap index = 0
$84:85C2 A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$84:85C5 8E 27 1C    STX $1C27  [$7E:1C27]  ; PLM index = [X]
$84:85C8 BD 37 1C    LDA $1C37,x[$7E:1C85]  ;\
$84:85CB F0 06       BEQ $06    [$85D3]     ;} If [PLM ID] != 0:
$84:85CD 20 DA 85    JSR $85DA  [$84:85DA]  ; Process PLM
$84:85D0 AE 27 1C    LDX $1C27  [$7E:1C27]  ; X = [PLM index]

$84:85D3 CA          DEX                    ;\
$84:85D4 CA          DEX                    ;} X -= 2
$84:85D5 10 EE       BPL $EE    [$85C5]     ; If [X] >= 0: go to LOOP

$84:85D7 AB          PLB
$84:85D8 28          PLP
$84:85D9 6B          RTL
}


;;; $85DA: Process PLM ;;;
{
;; Parameter:
;;     X: PLM index
$84:85DA FC D7 1C    JSR ($1CD7,x)[$84:B7DD]; Execute PLM pre-instruction
$84:85DD AE 27 1C    LDX $1C27  [$7E:1C27]  ; X = [PLM index]
$84:85E0 BF 1C DE 7E LDA $7EDE1C,x[$7E:DE6A];\
$84:85E4 3A          DEC A                  ;} Decrement PLM instruction timer
$84:85E5 9F 1C DE 7E STA $7EDE1C,x[$7E:DE6A];/
$84:85E9 D0 32       BNE $32    [$861D]     ; If [PLM instruction timer] != 0: return
$84:85EB BC 27 1D    LDY $1D27,x[$7E:1D75]  ; Y = [PLM instruction list pointer]

; LOOP
$84:85EE B9 00 00    LDA $0000,y[$84:B7E9]  ;\
$84:85F1 10 0A       BPL $0A    [$85FD]     ;} If [[Y]] & 8000h != 0:
$84:85F3 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]] (ASM instruction pointer)
$84:85F5 C8          INY                    ;\
$84:85F6 C8          INY                    ;} Y += 2
$84:85F7 F4 ED 85    PEA $85ED              ; Return to LOOP
$84:85FA 6C 12 00    JMP ($0012)[$84:86B4]  ; Execute ASM instruction

$84:85FD 9F 1C DE 7E STA $7EDE1C,x[$7E:DE68]; PLM instruction timer = [[Y]] (draw timer)
$84:8601 B9 02 00    LDA $0002,y[$84:C1AA]  ;\
$84:8604 9F 6C DE 7E STA $7EDE6C,x[$7E:DEB8];} PLM draw instruction pointer = [[Y] + 2]
$84:8608 98          TYA                    ;\
$84:8609 18          CLC                    ;|
$84:860A 69 04 00    ADC #$0004             ;} PLM instruction list pointer = [Y] + 4
$84:860D 9D 27 1D    STA $1D27,x[$7E:1D73]  ;/
$84:8610 20 1E 86    JSR $861E  [$84:861E]  ; Process PLM draw instruction
$84:8613 AE 27 1C    LDX $1C27  [$7E:1C27]  ; X = [PLM index]
$84:8616 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$84:861A 20 AA 8D    JSR $8DAA  [$84:8DAA]  ; Draw PLM

$84:861D 60          RTS
}


;;; $861E: Process PLM draw instruction ;;;
{
;; Parameter:
;;     X: PLM index
$84:861E BF 6C DE 7E LDA $7EDE6C,x[$7E:DEB8];\
$84:8622 A8          TAY                    ;} Y = [PLM draw instruction pointer]
$84:8623 BD 87 1C    LDA $1C87,x[$7E:1CD3]  ;\
$84:8626 85 12       STA $12    [$7E:0012]  ;} X = $12 = [PLM block index]
$84:8628 AA          TAX                    ;/

; LOOP_DRAW_ENTRY
$84:8629 B9 00 00    LDA $0000,y[$84:A827]  ;\
$84:862C 30 19       BMI $19    [$8647]     ;} If [[Y]] & 8000h: go to BRANCH_COLUMN
$84:862E 29 FF 00    AND #$00FF             ;\
$84:8631 85 16       STA $16    [$7E:0016]  ;} $16 = [[Y]] & FFh (number of blocks)
$84:8633 C8          INY                    ;\
$84:8634 C8          INY                    ;} Y += 2

; LOOP_ROW
$84:8635 B9 00 00    LDA $0000,y[$84:AA39]  ;\
$84:8638 9F 02 00 7F STA $7F0002,x[$7F:304E];} $7F:0002 + [X] = [[Y]] (write level data)
$84:863C C8          INY                    ;\
$84:863D C8          INY                    ;} Y += 2
$84:863E E8          INX                    ;\
$84:863F E8          INX                    ;} X += 2
$84:8640 C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$84:8642 D0 F1       BNE $F1    [$8635]     ; If [$16] != 0: go to LOOP_ROW
$84:8644 4C 64 86    JMP $8664  [$84:8664]  ; Go to BRANCH_NEXT

; BRANCH_COLUMN
$84:8647 29 FF 00    AND #$00FF             ;\
$84:864A 85 16       STA $16    [$7E:0016]  ;} $16 = [[Y]] & FFh (number of blocks)
$84:864C C8          INY                    ;\
$84:864D C8          INY                    ;} Y += 2

; LOOP_COLUMN
$84:864E B9 00 00    LDA $0000,y[$84:A829]  ;\
$84:8651 9F 02 00 7F STA $7F0002,x[$7F:4FDE];} $7F:0002 + [X] = [[Y]] (write level data)
$84:8655 C8          INY                    ;\
$84:8656 C8          INY                    ;} Y += 2
$84:8657 8A          TXA                    ;\
$84:8658 18          CLC                    ;|
$84:8659 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width] * 2
$84:865C 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:865F AA          TAX                    ;/
$84:8660 C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$84:8662 D0 EA       BNE $EA    [$864E]     ; If [$16] != 0: go to LOOP_COLUMN

; BRANCH_NEXT
$84:8664 B9 00 00    LDA $0000,y[$84:A831]  ;\
$84:8667 D0 01       BNE $01    [$866A]     ;} If [[Y]] = 0: return
$84:8669 60          RTS                    ;/

$84:866A 88          DEY                    ; Decrement Y
$84:866B B9 00 00    LDA $0000,y[$84:9F28]  ;\
$84:866E EB          XBA                    ;|
$84:866F 10 05       BPL $05    [$8676]     ;|
$84:8671 09 00 FF    ORA #$FF00             ;|
$84:8674 80 03       BRA $03    [$8679]     ;|
                                            ;|
$84:8676 29 FF 00    AND #$00FF             ;} $14 = [PLM block index] + ±[[Y] + 1] * 2
                                            ;|
$84:8679 0A          ASL A                  ;|
$84:867A 18          CLC                    ;|
$84:867B 65 12       ADC $12    [$7E:0012]  ;|
$84:867D 85 14       STA $14    [$7E:0014]  ;/
$84:867F B9 01 00    LDA $0001,y[$84:9F29]  ;\
$84:8682 EB          XBA                    ;|
$84:8683 10 14       BPL $14    [$8699]     ;|
$84:8685 09 00 FF    ORA #$FF00             ;|
$84:8688 49 FF FF    EOR #$FFFF             ;|
$84:868B 1A          INC A                  ;|
$84:868C AA          TAX                    ;|
$84:868D A9 00 00    LDA #$0000             ;|
                                            ;|
$84:8690 38          SEC                    ;|
$84:8691 ED A5 07    SBC $07A5  [$7E:07A5]  ;|
$84:8694 CA          DEX                    ;|
$84:8695 D0 F9       BNE $F9    [$8690]     ;|
$84:8697 80 10       BRA $10    [$86A9]     ;|
                                            ;} $14 += ±[[Y] + 2] * [room width] * 2
$84:8699 29 FF 00    AND #$00FF             ;|
$84:869C F0 0B       BEQ $0B    [$86A9]     ;|
$84:869E AA          TAX                    ;|
$84:869F A9 00 00    LDA #$0000             ;|
                                            ;|
$84:86A2 18          CLC                    ;|
$84:86A3 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:86A6 CA          DEX                    ;|
$84:86A7 D0 F9       BNE $F9    [$86A2]     ;|
                                            ;|
$84:86A9 0A          ASL A                  ;|
$84:86AA 18          CLC                    ;|
$84:86AB 65 14       ADC $14    [$7E:0014]  ;/
$84:86AD AA          TAX                    ; X = [$14]
$84:86AE C8          INY                    ;\
$84:86AF C8          INY                    ;} Y += 3
$84:86B0 C8          INY                    ;/
$84:86B1 4C 29 86    JMP $8629  [$84:8629]  ; Go to LOOP_DRAW_ENTRY
}
}


;;; $86B4..8D96: Instructions ;;;
{
;;; $86B4: Instruction - sleep ;;;
{
$84:86B4 88          DEY
$84:86B5 88          DEY
$84:86B6 98          TYA
$84:86B7 9D 27 1D    STA $1D27,x[$7E:1D75]
$84:86BA 68          PLA
$84:86BB 60          RTS
}


;;; $86BC: Instruction - delete ;;;
{
$84:86BC 9E 37 1C    STZ $1C37,x[$7E:1C85]
$84:86BF 68          PLA
$84:86C0 60          RTS
}


;;; $86C1: Instruction - pre-instruction = [[Y]] ;;;
{
$84:86C1 B9 00 00    LDA $0000,y[$84:C1A6]
$84:86C4 9D D7 1C    STA $1CD7,x[$7E:1D23]
$84:86C7 C8          INY
$84:86C8 C8          INY
$84:86C9 60          RTS
}


;;; $86CA: Instruction - clear pre-instruction ;;;
{
$84:86CA A9 D0 86    LDA #$86D0
$84:86CD 9D D7 1C    STA $1CD7,x[$7E:1D25]

$84:86D0 60          RTS
}


;;; $86D1: Unused. Instruction - call function [[Y]] ;;;
{
$84:86D1 B9 00 00    LDA $0000,y
$84:86D4 85 12       STA $12    [$7E:0012]
$84:86D6 B9 01 00    LDA $0001,y
$84:86D9 85 13       STA $13    [$7E:0013]
$84:86DB 5A          PHY
$84:86DC 22 E8 86 84 JSL $8486E8[$84:86E8]
$84:86E0 7A          PLY
$84:86E1 AE 27 1C    LDX $1C27  [$7E:1C27]
$84:86E4 C8          INY
$84:86E5 C8          INY
$84:86E6 C8          INY
$84:86E7 60          RTS

$84:86E8 DC 12 00    JML [$0012]
}


;;; $86EB: Unused. Instruction - call function [[Y]] with A = [[Y] + 3] ;;;
{
$84:86EB B9 00 00    LDA $0000,y
$84:86EE 85 12       STA $12    [$7E:0012]
$84:86F0 B9 01 00    LDA $0001,y
$84:86F3 85 13       STA $13    [$7E:0013]
$84:86F5 B9 03 00    LDA $0003,y
$84:86F8 5A          PHY
$84:86F9 22 08 87 84 JSL $848708[$84:8708]
$84:86FD 7A          PLY
$84:86FE AE 27 1C    LDX $1C27  [$7E:1C27]
$84:8701 98          TYA
$84:8702 18          CLC
$84:8703 69 05 00    ADC #$0005
$84:8706 A8          TAY
$84:8707 60          RTS

$84:8708 DC 12 00    JML [$0012]
}


;;; $870B: Instruction - call function [[Y]] ;;;
{
$84:870B B9 00 00    LDA $0000,y[$84:E72C]
$84:870E 85 12       STA $12    [$7E:0012]
$84:8710 B9 01 00    LDA $0001,y[$84:E72D]
$84:8713 85 13       STA $13    [$7E:0013]
$84:8715 DA          PHX
$84:8716 5A          PHY
$84:8717 22 21 87 84 JSL $848721[$84:8721]
$84:871B 7A          PLY
$84:871C FA          PLX
$84:871D C8          INY
$84:871E C8          INY
$84:871F C8          INY
$84:8720 60          RTS

$84:8721 DC 12 00    JML [$0012][$91:D4E4]
}


;;; $8724: Instruction - go to [[Y]] ;;;
{
$84:8724 B9 00 00    LDA $0000,y[$84:AF90]
$84:8727 A8          TAY
$84:8728 60          RTS
}


;;; $8729: Unused. Instruction - go to [Y] + ±[[Y]] ;;;
{
$84:8729 84 12       STY $12    [$7E:0012]
$84:872B 88          DEY
$84:872C B9 00 00    LDA $0000,y
$84:872F EB          XBA
$84:8730 30 05       BMI $05    [$8737]
$84:8732 29 FF 00    AND #$00FF
$84:8735 80 03       BRA $03    [$873A]

$84:8737 09 00 FF    ORA #$FF00

$84:873A 18          CLC
$84:873B 65 12       ADC $12    [$7E:0012]
$84:873D A8          TAY
$84:873E 60          RTS
}


;;; $873F: Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
$84:873F DE 77 1D    DEC $1D77,x[$7E:1DBF]
$84:8742 D0 E0       BNE $E0    [$8724]
$84:8744 C8          INY
$84:8745 C8          INY
$84:8746 60          RTS
}


;;; $8747: Unused. Instruction - decrement timer and go to [Y] + ±[[Y]] if non-zero ;;;
{
$84:8747 DE 77 1D    DEC $1D77,x[$7E:1D77]
$84:874A D0 DD       BNE $DD    [$8729]
$84:874C C8          INY
$84:874D 60          RTS
}


;;; $874E: Instruction - timer = [[Y]] (8-bit) ;;;
{
$84:874E E2 20       SEP #$20
$84:8750 B9 00 00    LDA $0000,y[$84:E492]
$84:8753 9D 77 1D    STA $1D77,x[$7E:1DC5]
$84:8756 C2 20       REP #$20
$84:8758 C8          INY
$84:8759 60          RTS
}


;;; $875A: Unused. Instruction - timer = [[Y]] (16-bit) ;;;
{
$84:875A B9 00 00    LDA $0000,y
$84:875D 9D 77 1D    STA $1D77,x
$84:8760 C8          INY
$84:8761 C8          INY
$84:8762 60          RTS
}


;;; $8763: RTS ;;;
{
$84:8763 60          RTS
}


;;; $8764: Instruction - load item PLM GFX ;;;
{
;; Parameter
;;     [Y]: Pointer to GFX of two blocks (each composed of 4 tiles in the following order)
;;     [Y] + 2: Palette index - block 1 - top-left
;;     [Y] + 3: Palette index - block 1 - top-right
;;     [Y] + 4: Palette index - block 1 - bottom-left
;;     [Y] + 5: Palette index - block 1 - bottom-right
;;     [Y] + 6: Palette index - block 2 - top-left
;;     [Y] + 7: Palette index - block 2 - top-right
;;     [Y] + 8: Palette index - block 2 - bottom-left
;;     [Y] + 9: Palette index - block 2 - bottom-right
$84:8764 AD 2D 1C    LDA $1C2D  [$7E:1C2D]  ;\
$84:8767 9F 0C DF 7E STA $7EDF0C,x[$7E:DF50];} X = PLM $DF0C = [PLM item GFX index]
$84:876B AA          TAX                    ;/
$84:876C 1A          INC A                  ;\
$84:876D 1A          INC A                  ;|
$84:876E 29 06 00    AND #$0006             ;} PLM item GFX index = ([PLM item GFX index] + 2) % 8
$84:8771 8D 2D 1C    STA $1C2D  [$7E:1C2D]  ;/
$84:8774 BD CD 87    LDA $87CD,x[$84:87CD]  ;\
$84:8777 85 12       STA $12    [$7E:0012]  ;} $12 = [$87CD + [X]] (VRAM address)
$84:8779 BD D5 87    LDA $87D5,x[$84:87D5]  ;\
$84:877C 85 14       STA $14    [$7E:0014]  ;} $14 = [$87D5 + [X]] (tile table index)
$84:877E BD DD 87    LDA $87DD,x[$84:87DD]  ;\
$84:8781 85 16       STA $16    [$7E:0016]  ;} $16 = [$87DD + [X]] (tile number)
$84:8783 98          TYA                    ;\
$84:8784 9D 2F 1C    STA $1C2F,x[$7E:1C2F]  ;} Item PLM GFX pointers + [X] = [Y]
$84:8787 AE 30 03    LDX $0330  [$7E:0330]  ;\
$84:878A A9 00 01    LDA #$0100             ;|
$84:878D 95 D0       STA $D0,x  [$7E:00D0]  ;|
$84:878F B9 00 00    LDA $0000,y[$84:E3F1]  ;|
$84:8792 95 D2       STA $D2,x  [$7E:00D2]  ;|
$84:8794 A9 89 00    LDA #$0089             ;|
$84:8797 95 D4       STA $D4,x  [$7E:00D4]  ;} Queue transfer of 100h bytes from $89:0000 to VRAM [$12]
$84:8799 A5 12       LDA $12    [$7E:0012]  ;|
$84:879B 95 D5       STA $D5,x  [$7E:00D5]  ;|
$84:879D 8A          TXA                    ;|
$84:879E 18          CLC                    ;|
$84:879F 69 07 00    ADC #$0007             ;|
$84:87A2 8D 30 03    STA $0330  [$7E:0330]  ;/
$84:87A5 C8          INY                    ;\
$84:87A6 C8          INY                    ;} Y += 2
$84:87A7 A6 14       LDX $14    [$7E:0014]  ; X = [$14] (tile table index)
$84:87A9 8A          TXA                    ;\
$84:87AA 18          CLC                    ;|
$84:87AB 69 10 00    ADC #$0010             ;} $18 = (tile table index) + 10h (tile table end index)
$84:87AE 85 18       STA $18    [$7E:0018]  ;/

; LOOP
$84:87B0 B9 00 00    LDA $0000,y[$84:E3F3]  ;\
$84:87B3 29 FF 00    AND #$00FF             ;} A = [[Y]] (palette index)
$84:87B6 EB          XBA                    ;\
$84:87B7 0A          ASL A                  ;|
$84:87B8 0A          ASL A                  ;|
$84:87B9 18          CLC                    ;} Tile table entry = [A] * 400h + (tile number)
$84:87BA 65 16       ADC $16    [$7E:0016]  ;|
$84:87BC 9F 00 A0 7E STA $7EA000,x[$7E:A470];/
$84:87C0 E6 16       INC $16    [$7E:0016]  ; (Tile number) += 1
$84:87C2 C8          INY                    ; Y += 1 (next tile palette)
$84:87C3 E8          INX                    ;\
$84:87C4 E8          INX                    ;} X += 2 (next tile table entry)
$84:87C5 E4 18       CPX $18    [$7E:0018]  ;\
$84:87C7 D0 E7       BNE $E7    [$87B0]     ;} If [X] != (tile table end index): go to LOOP
$84:87C9 AE 27 1C    LDX $1C27  [$7E:1C27]
$84:87CC 60          RTS

; VRAM addresses
$84:87CD             dw 3E00,3E80,3F00,3F80

; Tile table indices
$84:87D5             dw 0470,0480,0490,04A0

; Starting tile numbers
$84:87DD             dw 03E0,03E8,03F0,03F8
}


;;; $87E5: Instruction - transfer [[Y]] bytes from [[Y] + 2] to VRAM [[Y] + 5] ;;;
{
$84:87E5 AE 30 03    LDX $0330  [$7E:0330]  ;\
$84:87E8 B9 00 00    LDA $0000,y[$84:D378]  ;|
$84:87EB 95 D0       STA $D0,x  [$7E:00D0]  ;|
$84:87ED B9 02 00    LDA $0002,y[$84:D37A]  ;|
$84:87F0 95 D2       STA $D2,x  [$7E:00D2]  ;|
$84:87F2 B9 03 00    LDA $0003,y[$84:D37B]  ;|
$84:87F5 95 D3       STA $D3,x  [$7E:00D3]  ;} Queue transfer of [[Y]] bytes from [[Y] + 2] to VRAM [[Y] + 5]
$84:87F7 B9 05 00    LDA $0005,y[$84:D37D]  ;|
$84:87FA 95 D5       STA $D5,x  [$7E:00D5]  ;|
$84:87FC 8A          TXA                    ;|
$84:87FD 18          CLC                    ;|
$84:87FE 69 07 00    ADC #$0007             ;|
$84:8801 8D 30 03    STA $0330  [$7E:0330]  ;/
$84:8804 98          TYA                    ;\
$84:8805 18          CLC                    ;|
$84:8806 69 07 00    ADC #$0007             ;} Y += 7
$84:8809 A8          TAY                    ;/
$84:880A AE 27 1C    LDX $1C27  [$7E:1C27]
$84:880D 60          RTS
}


;;; $880E: Instruction - go to [[Y] + 1] if any of the boss bits [[Y]] are set ;;;
{
$84:880E B9 00 00    LDA $0000,y[$84:AD3A]  ; A = [[Y]]
$84:8811 C8          INY                    ; Y += 1
$84:8812 29 FF 00    AND #$00FF             ;\
$84:8815 22 DC 81 80 JSL $8081DC[$80:81DC]  ;} If any of the boss bits [[Y]] are set:
$84:8819 90 03       BCC $03    [$881E]     ;/
$84:881B 4C 24 87    JMP $8724  [$84:8724]  ; Go to go to [[Y]]

$84:881E C8          INY                    ;\
$84:881F C8          INY                    ;} Y += 2
$84:8820 60          RTS
}


;;; $8821: Unused. Instruction - set the boss bits [[Y]] ;;;
{
$84:8821 B9 00 00    LDA $0000,y            ;\
$84:8824 29 FF 00    AND #$00FF             ;} Set boss bits [[Y]] for current area
$84:8827 22 A6 81 80 JSL $8081A6[$80:81A6]  ;/
$84:882B C8          INY                    ; Increment Y
$84:882C 60          RTS
}


;;; $882D: Instruction - go to [[Y] + 2] if the event [[Y]] is set ;;;
{
$84:882D B9 00 00    LDA $0000,y[$84:D4D6]  ; A = [[Y]]
$84:8830 C8          INY                    ;\
$84:8831 C8          INY                    ;} Y += 2
$84:8832 22 33 82 80 JSL $808233[$80:8233]  ;\
$84:8836 90 03       BCC $03    [$883B]     ;} If the event [[Y]] is marked:
$84:8838 4C 24 87    JMP $8724  [$84:8724]  ; Go to go to [[Y]]
                                            
$84:883B C8          INY                    ;\
$84:883C C8          INY                    ;} Y += 2
$84:883D 60          RTS
}


;;; $883E: Instruction - set the event [[Y]] ;;;
{
$84:883E B9 00 00    LDA $0000,y[$84:D511]  ;\
$84:8841 22 FA 81 80 JSL $8081FA[$80:81FA]  ;} Mark event [[Y]]
$84:8845 C8          INY                    ;\
$84:8846 C8          INY                    ;} Y += 2
$84:8847 60          RTS
}


;;; $8848: Instruction - go to [[Y]] if room argument chozo block destroyed ;;;
{
; Negative room argument => chozo block is not destroyed
; Used by unused chozo block PLMs $D700/D708
$84:8848 DA          PHX                    ; >_<;
$84:8849 BD C7 1D    LDA $1DC7,x            ;\
$84:884C 30 14       BMI $14    [$8862]     ;} If [PLM room argument] & 8000h = 0:
$84:884E 22 8E 81 80 JSL $80818E[$80:818E]  ;\
$84:8852 BF 30 D8 7E LDA $7ED830,x          ;|
$84:8856 FA          PLX                    ;} If PLM room argument chozo block destroyed:
$84:8857 2D E7 05    AND $05E7  [$7E:05E7]  ;|
$84:885A F0 03       BEQ $03    [$885F]     ;/
$84:885C 4C 24 87    JMP $8724  [$84:8724]  ; Go to go to [[Y]]

$84:885F C8          INY                    ;\
$84:8860 C8          INY                    ;} Y += 2
$84:8861 60          RTS                    ; Return

$84:8862 FA          PLX
$84:8863 80 FA       BRA $FA    [$885F]
}


;;; $8865: Instruction - set room argument chozo block destroyed ;;;
{
; Negative room argument => chozo block destroyed flag isn't set
; Used by unused chozo block PLMs $D700/D708
$84:8865 DA          PHX
$84:8866 BD C7 1D    LDA $1DC7,x            ;\
$84:8869 30 0F       BMI $0F    [$887A]     ;} If [PLM room argument] & 8000h = 0:
$84:886B 22 8E 81 80 JSL $80818E[$80:818E]  ;\
$84:886F BF 30 D8 7E LDA $7ED830,x          ;|
$84:8873 0D E7 05    ORA $05E7  [$7E:05E7]  ;} Set PLM room argument chozo block destroyed
$84:8876 9F 30 D8 7E STA $7ED830,x          ;/

$84:887A FA          PLX
$84:887B 60          RTS
}


;;; $887C: Instruction - go to [[Y]] if the room argument item is collected ;;;
{
; Negative room argument => item is not collected
$84:887C DA          PHX                    ; >_<;
$84:887D BD C7 1D    LDA $1DC7,x[$7E:1E0B]  ;\
$84:8880 30 14       BMI $14    [$8896]     ;} If [PLM room argument] & 8000h = 0:
$84:8882 22 8E 81 80 JSL $80818E[$80:818E]  ;\
$84:8886 BF 70 D8 7E LDA $7ED870,x[$7E:D873];|
$84:888A FA          PLX                    ;} If PLM room argument item collected:
$84:888B 2D E7 05    AND $05E7  [$7E:05E7]  ;|
$84:888E F0 03       BEQ $03    [$8893]     ;/
$84:8890 4C 24 87    JMP $8724  [$84:8724]  ; Go to go to [[Y]]
                                            
$84:8893 C8          INY                    ;\
$84:8894 C8          INY                    ;} Y += 2
$84:8895 60          RTS                    ; Return

$84:8896 FA          PLX
$84:8897 80 FA       BRA $FA    [$8893]
}


;;; $8899: Instruction - set the room argument item collected ;;;
{
; Negative room argument => item collected is not set
$84:8899 DA          PHX
$84:889A BD C7 1D    LDA $1DC7,x[$7E:1E0B]  ;\
$84:889D 30 0F       BMI $0F    [$88AE]     ;} If [PLM room argument] & 8000h = 0:
$84:889F 22 8E 81 80 JSL $80818E[$80:818E]  ;\
$84:88A3 BF 70 D8 7E LDA $7ED870,x[$7E:D873];|
$84:88A7 0D E7 05    ORA $05E7  [$7E:05E7]  ;} Set PLM room argument chozo block destroyed
$84:88AA 9F 70 D8 7E STA $7ED870,x[$7E:D873];/

$84:88AE FA          PLX
$84:88AF 60          RTS
}


;;; $88B0: Instruction - pick up beam [[Y]] and display message box [[Y] + 2] ;;;
{
$84:88B0 B9 00 00    LDA $0000,y[$84:E57F]  ;\
$84:88B3 0D A8 09    ORA $09A8  [$7E:09A8]  ;} Collected beams |= [[Y]]
$84:88B6 8D A8 09    STA $09A8  [$7E:09A8]  ;/
$84:88B9 B9 00 00    LDA $0000,y[$84:E57F]  ;\
$84:88BC 0D A6 09    ORA $09A6  [$7E:09A6]  ;} Equipped beams |= [[Y]]
$84:88BF 8D A6 09    STA $09A6  [$7E:09A6]  ;/
$84:88C2 B9 00 00    LDA $0000,y[$84:E57F]  ;\
$84:88C5 0A          ASL A                  ;|
$84:88C6 29 08 00    AND #$0008             ;} If setting spazer: clear plasma
$84:88C9 1C A6 09    TRB $09A6  [$7E:09A6]  ;/
$84:88CC B9 00 00    LDA $0000,y[$84:E57F]  ;\
$84:88CF 4A          LSR A                  ;|
$84:88D0 29 04 00    AND #$0004             ;} If setting plasma: clear spazer
$84:88D3 1C A6 09    TRB $09A6  [$7E:09A6]  ;/
$84:88D6 DA          PHX                    ;\
$84:88D7 5A          PHY                    ;|
$84:88D8 22 8D AC 90 JSL $90AC8D[$90:AC8D]  ;} Update beam GFX
$84:88DC 7A          PLY                    ;|
$84:88DD FA          PLX                    ;/
$84:88DE A9 68 01    LDA #$0168             ;\
$84:88E1 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:88E5 B9 02 00    LDA $0002,y[$84:E581]  ;\
$84:88E8 29 FF 00    AND #$00FF             ;} Display message box [[Y] + 2]
$84:88EB 22 80 80 85 JSL $858080[$85:8080]  ;/
$84:88EF C8          INY                    ;\
$84:88F0 C8          INY                    ;} Y += 3
$84:88F1 C8          INY                    ;/
$84:88F2 60          RTS
}


;;; $88F3: Instruction - pick up equipment [[Y]] and display message box [[Y] + 2] ;;;
{
$84:88F3 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$84:88F6 19 00 00    ORA $0000,y[$84:E416]  ;} Equipped equipment |= [[Y]]
$84:88F9 8D A2 09    STA $09A2  [$7E:09A2]  ;/
$84:88FC AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$84:88FF 19 00 00    ORA $0000,y[$84:E416]  ;} Collected equipment |= [[Y]]
$84:8902 8D A4 09    STA $09A4  [$7E:09A4]  ;/
$84:8905 A9 68 01    LDA #$0168             ;\
$84:8908 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:890C B9 02 00    LDA $0002,y[$84:E418]  ;\
$84:890F 29 FF 00    AND #$00FF             ;} Display message box [[Y] + 2]
$84:8912 22 80 80 85 JSL $858080[$85:8080]  ;/
$84:8916 C8          INY                    ;\
$84:8917 C8          INY                    ;} Y += 3
$84:8918 C8          INY                    ;/
$84:8919 60          RTS
}


;;; $891A: Instruction - pick up equipment [[Y]], add grapple to HUD and display grapple message box ;;;
{
$84:891A AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$84:891D 19 00 00    ORA $0000,y[$84:E81E]  ;} Equipped equipment |= [[Y]]
$84:8920 8D A2 09    STA $09A2  [$7E:09A2]  ;/
$84:8923 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$84:8926 19 00 00    ORA $0000,y[$84:E81E]  ;} Collected equipment |= [[Y]]
$84:8929 8D A4 09    STA $09A4  [$7E:09A4]  ;/
$84:892C 22 2E 9A 80 JSL $809A2E[$80:9A2E]  ; Add grapple to HUD tilemap
$84:8930 A9 68 01    LDA #$0168             ;\
$84:8933 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:8937 A9 05 00    LDA #$0005             ;\
$84:893A 22 80 80 85 JSL $858080[$85:8080]  ;} Display grapple message box
$84:893E C8          INY                    ;\
$84:893F C8          INY                    ;} Y += 2
$84:8940 60          RTS
}


;;; $8941: Instruction - pick up equipment [[Y]], add x-ray to HUD and display x-ray message box ;;;
{
$84:8941 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$84:8944 19 00 00    ORA $0000,y[$84:E7A9]  ;} Equipped equipment |= [[Y]]
$84:8947 8D A2 09    STA $09A2  [$7E:09A2]  ;/
$84:894A AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$84:894D 19 00 00    ORA $0000,y[$84:E7A9]  ;} Collected equipment |= [[Y]]
$84:8950 8D A4 09    STA $09A4  [$7E:09A4]  ;/
$84:8953 22 3E 9A 80 JSL $809A3E[$80:9A3E]  ; Add x-ray to HUD tilemap
$84:8957 A9 68 01    LDA #$0168             ;\
$84:895A 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:895E A9 06 00    LDA #$0006             ;\
$84:8961 22 80 80 85 JSL $858080[$85:8080]  ;} Display x-ray message box
$84:8965 C8          INY                    ;\
$84:8966 C8          INY                    ;} Y += 2
$84:8967 60          RTS
}


;;; $8968: Instruction - collect [[Y]] health energy tank ;;;
{
$84:8968 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$84:896B 18          CLC                    ;|
$84:896C 79 00 00    ADC $0000,y[$84:E93F]  ;} Samus max health += [[Y]]
$84:896F 8D C4 09    STA $09C4  [$7E:09C4]  ;/
$84:8972 8D C2 09    STA $09C2  [$7E:09C2]  ; Samus health = [Samus max health]
$84:8975 A9 68 01    LDA #$0168             ;\
$84:8978 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:897C A9 01 00    LDA #$0001             ;\
$84:897F 22 80 80 85 JSL $858080[$85:8080]  ;} Display energy tank message box
$84:8983 C8          INY                    ;\
$84:8984 C8          INY                    ;} Y += 2
$84:8985 60          RTS
}


;;; $8986: Instruction - collect [[Y]] health reserve tank ;;;
{
$84:8986 AD D4 09    LDA $09D4  [$7E:09D4]  ;\
$84:8989 18          CLC                    ;|
$84:898A 79 00 00    ADC $0000,y[$84:E909]  ;} Samus reserve energy += [[Y]]
$84:898D 8D D4 09    STA $09D4  [$7E:09D4]  ;/
$84:8990 AD C0 09    LDA $09C0  [$7E:09C0]  ;\
$84:8993 D0 03       BNE $03    [$8998]     ;} If first reserve tank:
$84:8995 EE C0 09    INC $09C0  [$7E:09C0]  ; Reserve health mode = auto

$84:8998 A9 68 01    LDA #$0168             ;\
$84:899B 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:899F A9 19 00    LDA #$0019             ;\
$84:89A2 22 80 80 85 JSL $858080[$85:8080]  ;} Display reserve tank message box
$84:89A6 C8          INY                    ;\
$84:89A7 C8          INY                    ;} Y += 2
$84:89A8 60          RTS
}


;;; $89A9: Instruction - collect [[Y]] ammo missile tank ;;;
{
$84:89A9 AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$84:89AC 18          CLC                    ;|
$84:89AD 79 00 00    ADC $0000,y[$84:E4A6]  ;} Samus max missiles += [[Y]]
$84:89B0 8D C8 09    STA $09C8  [$7E:09C8]  ;/
$84:89B3 AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$84:89B6 18          CLC                    ;|
$84:89B7 79 00 00    ADC $0000,y[$84:E4A6]  ;} Samus missiles += [[Y]]
$84:89BA 8D C6 09    STA $09C6  [$7E:09C6]  ;/
$84:89BD 22 CF 99 80 JSL $8099CF[$80:99CF]  ; Add missiles to HUD tilemap
$84:89C1 A9 68 01    LDA #$0168             ;\
$84:89C4 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:89C8 A9 02 00    LDA #$0002             ;\
$84:89CB 22 80 80 85 JSL $858080[$85:8080]  ;} Display missile tank message box
$84:89CF C8          INY                    ;\
$84:89D0 C8          INY                    ;} Y += 2
$84:89D1 60          RTS
}


;;; $89D2: Instruction - collect [[Y]] ammo super missile tank ;;;
{
$84:89D2 AD CC 09    LDA $09CC  [$7E:09CC]  ;\
$84:89D5 18          CLC                    ;|
$84:89D6 79 00 00    ADC $0000,y[$84:E102]  ;} Samus max super missiles += [[Y]]
$84:89D9 8D CC 09    STA $09CC  [$7E:09CC]  ;/
$84:89DC AD CA 09    LDA $09CA  [$7E:09CA]  ;\
$84:89DF 18          CLC                    ;|
$84:89E0 79 00 00    ADC $0000,y[$84:E102]  ;} Samus super missiles += [[Y]]
$84:89E3 8D CA 09    STA $09CA  [$7E:09CA]  ;/
$84:89E6 22 0E 9A 80 JSL $809A0E[$80:9A0E]  ; Add super missiles to HUD tilemap
$84:89EA A9 68 01    LDA #$0168             ;\
$84:89ED 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:89F1 A9 03 00    LDA #$0003             ;\
$84:89F4 22 80 80 85 JSL $858080[$85:8080]  ;} Display super missile tank message box
$84:89F8 C8          INY                    ;\
$84:89F9 C8          INY                    ;} Y += 2
$84:89FA 60          RTS
}


;;; $89FB: Instruction - collect [[Y]] ammo power bomb tank ;;;
{
$84:89FB AD D0 09    LDA $09D0  [$7E:09D0]  ;\
$84:89FE 18          CLC                    ;|
$84:89FF 79 00 00    ADC $0000,y[$84:E50A]  ;} Samus max power bombs += [[Y]]
$84:8A02 8D D0 09    STA $09D0  [$7E:09D0]  ;/
$84:8A05 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$84:8A08 18          CLC                    ;|
$84:8A09 79 00 00    ADC $0000,y[$84:E50A]  ;} Samus power bombs += [[Y]]
$84:8A0C 8D CE 09    STA $09CE  [$7E:09CE]  ;/
$84:8A0F 22 1E 9A 80 JSL $809A1E[$80:9A1E]  ; Add power bombs to HUD tilemap
$84:8A13 A9 68 01    LDA #$0168             ;\
$84:8A16 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:8A1A A9 04 00    LDA #$0004             ;\
$84:8A1D 22 80 80 85 JSL $858080[$85:8080]  ;} Display power bomb tank message box
$84:8A21 C8          INY                    ;\
$84:8A22 C8          INY                    ;} Y += 2
$84:8A23 60          RTS
}


;;; $8A24: Instruction - link instruction = [[Y]] ;;;
{
$84:8A24 B9 00 00    LDA $0000,y[$84:C1A2]  ;\
$84:8A27 9F BC DE 7E STA $7EDEBC,x[$7E:DF08];} PLM link instruction = [[Y]]
$84:8A2B C8          INY                    ;\
$84:8A2C C8          INY                    ;} Y += 2
$84:8A2D 60          RTS
}


;;; $8A2E: Instruction - call [[Y]] ;;;
{
$84:8A2E 98          TYA                    ;\
$84:8A2F 1A          INC A                  ;|
$84:8A30 1A          INC A                  ;} PLM link instruction = [Y] + 2
$84:8A31 9F BC DE 7E STA $7EDEBC,x[$7E:DF0A];/
$84:8A35 B9 00 00    LDA $0000,y[$84:E482]  ;\
$84:8A38 A8          TAY                    ;} Y = [[Y]]
$84:8A39 60          RTS
}


;;; $8A3A: Instruction - return ;;;
{
$84:8A3A BF BC DE 7E LDA $7EDEBC,x[$7E:DF0A];\
$84:8A3E A8          TAY                    ;} Y = [PLM link instruction]
$84:8A3F 60          RTS
}


;;; $8A40: Unused. Instruction - wait until enemy 0 is dead ;;;
{
$84:8A40 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$84:8A43 29 00 02    AND #$0200             ;} If enemy 0 is deleted: return
$84:8A46 D0 10       BNE $10    [$8A58]     ;/
$84:8A48 AD 78 0F    LDA $0F78  [$7E:0F78]  ;\
$84:8A4B C9 FF DA    CMP #$DAFF             ;} If enemy 0 is respawning enemy placeholder: return
$84:8A4E F0 08       BEQ $08    [$8A58]     ;/
$84:8A50 68          PLA                    ; Terminate processing PLM
$84:8A51 A9 01 00    LDA #$0001             ;\
$84:8A54 9F 1C DE 7E STA $7EDE1C,x          ;} PLM instruction timer = 1

$84:8A58 60          RTS
}


;;; $8A59: Unused. Instruction - wait until enemy 1 is dead ;;;
{
$84:8A59 AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$84:8A5C 29 00 02    AND #$0200             ;} If enemy 1 is deleted: return
$84:8A5F D0 10       BNE $10    [$8A71]     ;/
$84:8A61 AD B8 0F    LDA $0FB8  [$7E:0FB8]  ;\
$84:8A64 C9 FF DA    CMP #$DAFF             ;} If enemy 1 is respawning enemy placeholder: return
$84:8A67 F0 08       BEQ $08    [$8A71]     ;/
$84:8A69 68          PLA                    ; Terminate processing PLM
$84:8A6A A9 01 00    LDA #$0001             ;\
$84:8A6D 9F 1C DE 7E STA $7EDE1C,x          ;} PLM instruction timer = 1

$84:8A71 60          RTS
}


;;; $8A72: Instruction - go to [[Y]] if the room argument door is set ;;;
{
; Negative room argument => door is not set
$84:8A72 DA          PHX                    ; >_<;
$84:8A73 BD C7 1D    LDA $1DC7,x[$7E:1E13]  ;\
$84:8A76 30 16       BMI $16    [$8A8E]     ;} If [PLM room argument] & 8000h = 0:
$84:8A78 22 8E 81 80 JSL $80818E[$80:818E]  ;\
$84:8A7C BF B0 D8 7E LDA $7ED8B0,x[$7E:D8B0];|
$84:8A80 FA          PLX                    ;} If PLM room argument door is set:
$84:8A81 2D E7 05    AND $05E7  [$7E:05E7]  ;|
$84:8A84 F0 05       BEQ $05    [$8A8B]     ;/
$84:8A86 B9 00 00    LDA $0000,y[$84:C31A]  ;\
$84:8A89 A8          TAY                    ;} Y = [[Y]]
$84:8A8A 60          RTS                    ; Return
                                            
$84:8A8B C8          INY                    ;\
$84:8A8C C8          INY                    ;} Y += 2
$84:8A8D 60          RTS                    ; Return

$84:8A8E FA          PLX
$84:8A8F 80 FA       BRA $FA    [$8A8B]
}


;;; $8A91: Instruction - increment door hit counter; set room argument door and go to [[Y] + 1] if [door hit counter] >= [[Y]] ;;;
{
$84:8A91 BF 0C DF 7E LDA $7EDF0C,x[$7E:DF58];\
$84:8A95 1A          INC A                  ;} Increment PLM door hit counter
$84:8A96 9F 0C DF 7E STA $7EDF0C,x[$7E:DF58];/
$84:8A9A E2 20       SEP #$20               ;\
$84:8A9C D9 00 00    CMP $0000,y[$84:C32C]  ;|
$84:8A9F C2 20       REP #$20               ;} If [PLM door hit counter] < [[Y]]:
$84:8AA1 B0 04       BCS $04    [$8AA7]     ;/
$84:8AA3 C8          INY                    ;\
$84:8AA4 C8          INY                    ;} Y += 3
$84:8AA5 C8          INY                    ;/
$84:8AA6 60          RTS                    ; Return

$84:8AA7 DA          PHX
$84:8AA8 BD C7 1D    LDA $1DC7,x[$7E:1E13]  ;\
$84:8AAB 30 0F       BMI $0F    [$8ABC]     ;} If [PLM room argument] & 8000h = 0:
$84:8AAD 22 8E 81 80 JSL $80818E[$80:818E]  ;\
$84:8AB1 BF B0 D8 7E LDA $7ED8B0,x[$7E:D8B6];|
$84:8AB5 0D E7 05    ORA $05E7  [$7E:05E7]  ;} Set PLM room argument door
$84:8AB8 9F B0 D8 7E STA $7ED8B0,x[$7E:D8B6];/

$84:8ABC FA          PLX
$84:8ABD 09 00 80    ORA #$8000             ;\
$84:8AC0 9D C7 1D    STA $1DC7,x[$7E:1E13]  ;} PLM room argument |= 8000h
$84:8AC3 A9 A6 8A    LDA #$8AA6             ;\
$84:8AC6 9D D7 1C    STA $1CD7,x[$7E:1D23]  ;} Clear PLM pre-instruction
$84:8AC9 C8          INY                    ; Y += 1
$84:8ACA 4C 24 87    JMP $8724  [$84:8724]  ; Go to go to [[Y]]
}


;;; $8ACD: Instruction - increment room argument; room argument = FFFFh and go to [[Y] + 1] if [room argument] >= [[Y]] ;;;
{
; Used by Draygon turrets
$84:8ACD E2 20       SEP #$20               ;\
$84:8ACF BD C7 1D    LDA $1DC7,x[$7E:1E0F]  ;|
$84:8AD2 1A          INC A                  ;|
$84:8AD3 D9 00 00    CMP $0000,y[$84:DCF2]  ;} If [PLM room argument] + 1 < [[Y]]:
$84:8AD6 C2 20       REP #$20               ;|
$84:8AD8 B0 07       BCS $07    [$8AE1]     ;/
$84:8ADA 9D C7 1D    STA $1DC7,x[$7E:1E0F]  ; Increment PLM room argument
$84:8ADD C8          INY                    ;\
$84:8ADE C8          INY                    ;} Y += 3
$84:8ADF C8          INY                    ;/
$84:8AE0 60          RTS                    ; Return

$84:8AE1 A9 FF FF    LDA #$FFFF             ;\
$84:8AE4 9D C7 1D    STA $1DC7,x[$7E:1E0F]  ;} PLM room argument = FFFFh
$84:8AE7 A9 E0 8A    LDA #$8AE0             ;\
$84:8AEA 9D D7 1C    STA $1CD7,x[$7E:1D1F]  ;} Clear PLM pre-instruction
$84:8AED C8          INY                    ; Y += 1
$84:8AEE 4C 24 87    JMP $8724  [$84:8724]  ; Go to go to [[Y]]
}


;;; $8AF1: Instruction - PLM BTS = [[Y]] ;;;
{
$84:8AF1 DA          PHX                    ;\
$84:8AF2 BD 87 1C    LDA $1C87,x[$7E:1CBF]  ;|
$84:8AF5 4A          LSR A                  ;|
$84:8AF6 AA          TAX                    ;|
$84:8AF7 E2 20       SEP #$20               ;} PLM BTS = [[Y]]
$84:8AF9 B9 00 00    LDA $0000,y[$84:C4B3]  ;|
$84:8AFC 9F 02 64 7F STA $7F6402,x[$7F:6630];|
$84:8B00 C2 20       REP #$20               ;|
$84:8B02 FA          PLX                    ;/
$84:8B03 C8          INY                    ; Y += 1
$84:8B04 60          RTS
}


;;; $8B05: Instruction - draw PLM block ;;;
{
; Clone of below
$84:8B05 C2 20       REP #$20
$84:8B07 DA          PHX
$84:8B08 5A          PHY
$84:8B09 9B          TXY
$84:8B0A BE 87 1C    LDX $1C87,y[$7E:1CCF]
$84:8B0D B9 17 1E    LDA $1E17,y[$7E:1E5F]
$84:8B10 9F 02 00 7F STA $7F0002,x[$7F:0CFA]
$84:8B14 4C 26 8B    JMP $8B26  [$84:8B26]
}


;;; $8B17: Instruction - draw PLM block ;;;
{
; This works by creating a draw instruction in RAM and calling the PLM handler's drawing routine manually
$84:8B17 C2 20       REP #$20
$84:8B19 DA          PHX
$84:8B1A 5A          PHY
$84:8B1B 9B          TXY
$84:8B1C BE 87 1C    LDX $1C87,y[$7E:1CCD]  ;\
$84:8B1F B9 17 1E    LDA $1E17,y[$7E:1E5D]  ;} PLM block = [PLM respawn block]
$84:8B22 9F 02 00 7F STA $7F0002,x[$7F:08BC];/

$84:8B26 8D 69 1E    STA $1E69  [$7E:1E69]  ;\
$84:8B29 A9 01 00    LDA #$0001             ;|
$84:8B2C 8D 67 1E    STA $1E67  [$7E:1E67]  ;} Custom draw instruction = 1, [PLM block], 0
$84:8B2F 9C 6B 1E    STZ $1E6B  [$7E:1E6B]  ;/
$84:8B32 7A          PLY
$84:8B33 FA          PLX
$84:8B34 A9 01 00    LDA #$0001             ;\
$84:8B37 9F 1C DE 7E STA $7EDE1C,x[$7E:DE64];} PLM instruction timer = 1
$84:8B3B A9 67 1E    LDA #$1E67             ;\
$84:8B3E 9F 6C DE 7E STA $7EDE6C,x[$7E:DEB4];} PLM draw instruction pointer = custom draw instruction
$84:8B42 98          TYA                    ;\
$84:8B43 9D 27 1D    STA $1D27,x[$7E:1D6F]  ;} PLM instruction list pointer = [Y]
$84:8B46 20 1E 86    JSR $861E  [$84:861E]  ; Process PLM draw instruction
$84:8B49 AE 27 1C    LDX $1C27  [$7E:1C27]
$84:8B4C 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$84:8B50 20 AA 8D    JSR $8DAA  [$84:8DAA]  ; Draw PLM
$84:8B53 68          PLA
$84:8B54 60          RTS
}


;;; $8B55: Instruction - process air scroll update ;;;
{
$84:8B55 8B          PHB
$84:8B56 DA          PHX
$84:8B57 5A          PHY                    ; Save Y
$84:8B58 9E 17 1E    STZ $1E17,x[$7E:1E5B]  ; PLM scroll triggered flag = 0
$84:8B5B BC C7 1D    LDY $1DC7,x[$7E:1E0B]  ; Y = [PLM room argument]
$84:8B5E F4 00 8F    PEA $8F00              ;\
$84:8B61 AB          PLB                    ;} DB = $8F
$84:8B62 AB          PLB                    ;/
$84:8B63 A9 00 00    LDA #$0000
$84:8B66 E2 20       SEP #$20

; LOOP
$84:8B68 B9 00 00    LDA $0000,y[$8F:939C]  ;\
$84:8B6B 30 0C       BMI $0C    [$8B79]     ;} If [[Y]] & 80h = 0:
$84:8B6D AA          TAX                    ;\
$84:8B6E B9 01 00    LDA $0001,y[$8F:939D]  ;} Scroll [[Y]] = [[Y] + 1]
$84:8B71 9F 20 CD 7E STA $7ECD20,x[$7E:CD22];/
$84:8B75 C8          INY                    ;\
$84:8B76 C8          INY                    ;} Y += 2
$84:8B77 80 EF       BRA $EF    [$8B68]     ; Go to LOOP

$84:8B79 C2 20       REP #$20
$84:8B7B 7A          PLY                    ; Restore Y
$84:8B7C FA          PLX
$84:8B7D AB          PLB
$84:8B7E DA          PHX
$84:8B7F BD 87 1C    LDA $1C87,x[$7E:1CCB]  ;\
$84:8B82 AA          TAX                    ;|
$84:8B83 BF 02 00 7F LDA $7F0002,x[$7F:067A];|
$84:8B87 29 FF 0F    AND #$0FFF             ;} PLM block type = special air
$84:8B8A 09 00 30    ORA #$3000             ;|
$84:8B8D 9F 02 00 7F STA $7F0002,x[$7F:067A];/
$84:8B91 FA          PLX
$84:8B92 60          RTS
}


;;; $8B93: Instruction - process solid scroll update ;;;
{
$84:8B93 8B          PHB
$84:8B94 DA          PHX
$84:8B95 5A          PHY                    ; Save Y
$84:8B96 9E 17 1E    STZ $1E17,x[$7E:1E17]  ; PLM scroll triggered flag = 0
$84:8B99 BC C7 1D    LDY $1DC7,x            ; Y = [PLM room argument]
$84:8B9C F4 00 8F    PEA $8F00              ;\
$84:8B9F AB          PLB                    ;} DB = $8F
$84:8BA0 AB          PLB                    ;/
$84:8BA1 A9 00 00    LDA #$0000
$84:8BA4 E2 20       SEP #$20

; LOOP
$84:8BA6 B9 00 00    LDA $0000,y            ;\
$84:8BA9 30 0C       BMI $0C    [$8BB7]     ;} If [[Y]] & 80h = 0:
$84:8BAB AA          TAX                    ;\
$84:8BAC B9 01 00    LDA $0001,y            ;} Scroll [[Y]] = [[Y] + 1]
$84:8BAF 9F 20 CD 7E STA $7ECD20,x          ;/
$84:8BB3 C8          INY                    ;\
$84:8BB4 C8          INY                    ;} Y += 2
$84:8BB5 80 EF       BRA $EF    [$8BA6]     ; Go to LOOP

$84:8BB7 C2 20       REP #$20
$84:8BB9 7A          PLY                    ; Restore Y
$84:8BBA FA          PLX
$84:8BBB AB          PLB
$84:8BBC DA          PHX
$84:8BBD BD 87 1C    LDA $1C87,x            ;\
$84:8BC0 AA          TAX                    ;|
$84:8BC1 BF 02 00 7F LDA $7F0002,x          ;|
$84:8BC5 29 FF 0F    AND #$0FFF             ;} PLM block type = special block
$84:8BC8 09 00 B0    ORA #$B000             ;|
$84:8BCB 9F 02 00 7F STA $7F0002,x          ;/
$84:8BCF FA          PLX
$84:8BD0 60          RTS
}


;;; $8BD1: Unused. Instruction - queue music track [[Y]] ;;;
{
$84:8BD1 B9 00 00    LDA $0000,y            ;\
$84:8BD4 29 FF 00    AND #$00FF             ;} Queue music track [[Y]]
$84:8BD7 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;/
$84:8BDB C8          INY                    ; Y += 1
$84:8BDC 60          RTS
}


;;; $8BDD: Instruction - clear music queue and queue music track [[Y]] ;;;
{
$84:8BDD DA          PHX                    ;\
$84:8BDE A2 0E 00    LDX #$000E             ;|
                                            ;|
$84:8BE1 9E 19 06    STZ $0619,x[$7E:0627]  ;|
$84:8BE4 9E 29 06    STZ $0629,x[$7E:0637]  ;} Music queue entries = music queue timers = 0
$84:8BE7 CA          DEX                    ;|
$84:8BE8 CA          DEX                    ;|
$84:8BE9 10 F6       BPL $F6    [$8BE1]     ;|
$84:8BEB FA          PLX                    ;/
$84:8BEC AD 39 06    LDA $0639  [$7E:0639]  ;\
$84:8BEF 8D 3B 06    STA $063B  [$7E:063B]  ;} Music queue start index = [music queue next index]
$84:8BF2 A9 00 00    LDA #$0000             ;\
$84:8BF5 8D 3F 06    STA $063F  [$7E:063F]  ;} Music timer = 0
$84:8BF8 8D 3D 06    STA $063D  [$7E:063D]  ; Music entry = 0
$84:8BFB B9 00 00    LDA $0000,y[$84:E413]  ;\
$84:8BFE 29 FF 00    AND #$00FF             ;} Queue music track [[Y]]
$84:8C01 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;/
$84:8C05 C8          INY                    ; Y += 1
$84:8C06 60          RTS
}


;;; $8C07: Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 6 ;;;
{
$84:8C07 B9 00 00    LDA $0000,y[$84:AFF6]
$84:8C0A 22 49 90 80 JSL $809049[$80:9049]
$84:8C0E C8          INY
$84:8C0F 60          RTS
}


;;; $8C10: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 6 ;;;
{
$84:8C10 B9 00 00    LDA $0000,y[$84:E011]
$84:8C13 22 CB 90 80 JSL $8090CB[$80:90CB]
$84:8C17 C8          INY
$84:8C18 60          RTS
}


;;; $8C19: Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 6 ;;;
{
$84:8C19 B9 00 00    LDA $0000,y[$84:C4BC]
$84:8C1C 22 4D 91 80 JSL $80914D[$80:914D]
$84:8C20 C8          INY
$84:8C21 60          RTS
}


;;; $8C22: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 15 ;;;
{
$84:8C22 B9 00 00    LDA $0000,y
$84:8C25 22 21 90 80 JSL $809021[$80:9021]
$84:8C29 C8          INY
$84:8C2A 60          RTS
}


;;; $8C2B: Unused. Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 15 ;;;
{
$84:8C2B B9 00 00    LDA $0000,y
$84:8C2E 22 A3 90 80 JSL $8090A3[$80:90A3]
$84:8C32 C8          INY
$84:8C33 60          RTS
}


;;; $8C34: Unused. Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 15 ;;;
{
$84:8C34 B9 00 00    LDA $0000,y
$84:8C37 22 25 91 80 JSL $809125[$80:9125]
$84:8C3B C8          INY
$84:8C3C 60          RTS
}


;;; $8C3D: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 3 ;;;
{
$84:8C3D B9 00 00    LDA $0000,y
$84:8C40 22 35 90 80 JSL $809035[$80:9035]
$84:8C44 C8          INY
$84:8C45 60          RTS
}


;;; $8C46: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 3 ;;;
{
$84:8C46 B9 00 00    LDA $0000,y[$84:CCEC]
$84:8C49 22 B7 90 80 JSL $8090B7[$80:90B7]
$84:8C4D C8          INY
$84:8C4E 60          RTS
}


;;; $8C4F: Unused. Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 3 ;;;
{
$84:8C4F B9 00 00    LDA $0000,y
$84:8C52 22 39 91 80 JSL $809139[$80:9139]
$84:8C56 C8          INY
$84:8C57 60          RTS
}


;;; $8C58: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 9 ;;;
{
$84:8C58 B9 00 00    LDA $0000,y
$84:8C5B 22 2B 90 80 JSL $80902B[$80:902B]
$84:8C5F C8          INY
$84:8C60 60          RTS
}


;;; $8C61: Unused. Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 9 ;;;
{
$84:8C61 B9 00 00    LDA $0000,y
$84:8C64 22 AD 90 80 JSL $8090AD[$80:90AD]
$84:8C68 C8          INY
$84:8C69 60          RTS
}


;;; $8C6A: Unused. Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 9 ;;;
{
$84:8C6A B9 00 00    LDA $0000,y
$84:8C6D 22 2F 91 80 JSL $80912F[$80:912F]
$84:8C71 C8          INY
$84:8C72 60          RTS
}


;;; $8C73: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 1 ;;;
{
$84:8C73 B9 00 00    LDA $0000,y
$84:8C76 22 3F 90 80 JSL $80903F[$80:903F]
$84:8C7A C8          INY
$84:8C7B 60          RTS
}


;;; $8C7C: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 1 ;;;
{
$84:8C7C B9 00 00    LDA $0000,y[$84:CBB9]
$84:8C7F 22 C1 90 80 JSL $8090C1[$80:90C1]
$84:8C83 C8          INY
$84:8C84 60          RTS
}


;;; $8C85: Unused. Instruction - queue sound [[Y]], sound library 3, max queued sounds allow = 1 ;;;
{
$84:8C85 B9 00 00    LDA $0000,y
$84:8C88 22 43 91 80 JSL $809143[$80:9143]
$84:8C8C C8          INY
$84:8C8D 60          RTS
}


;;; $8C8E: RTS ;;;
{
$84:8C8E 60          RTS
}


;;; $8C8F: Instruction - activate map station ;;;
{
$84:8C8F DA          PHX
$84:8C90 5A          PHY
$84:8C91 AE 9F 07    LDX $079F  [$7E:079F]  ;\
$84:8C94 BF 08 D9 7E LDA $7ED908,x[$7E:D908];|
$84:8C98 09 FF 00    ORA #$00FF             ;} Set map station activated
$84:8C9B 9F 08 D9 7E STA $7ED908,x[$7E:D908];/
$84:8C9F A9 14 00    LDA #$0014             ;\
$84:8CA2 22 80 80 85 JSL $858080[$85:8080]  ;} Display map data access completed message box
$84:8CA6 A9 01 00    LDA #$0001             ;\
$84:8CA9 8D 89 07    STA $0789  [$7E:0789]  ;} Set current area map collected flag
$84:8CAC 7A          PLY
$84:8CAD FA          PLX
$84:8CAE 60          RTS
}


;;; $8CAF: Instruction - activate energy station ;;;
{
$84:8CAF DA          PHX
$84:8CB0 5A          PHY
$84:8CB1 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$84:8CB4 CD C2 09    CMP $09C2  [$7E:09C2]  ;} If [Samus health] != [Samus max health]:
$84:8CB7 F0 0D       BEQ $0D    [$8CC6]     ;/
$84:8CB9 A9 15 00    LDA #$0015             ;\
$84:8CBC 22 80 80 85 JSL $858080[$85:8080]  ;} Display energy recharge completed message box
$84:8CC0 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$84:8CC3 8D C2 09    STA $09C2  [$7E:09C2]  ;} Samus health = [Samus max health]

$84:8CC6 A9 01 00    LDA #$0001             ;\
$84:8CC9 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$84:8CCD 7A          PLY
$84:8CCE FA          PLX
$84:8CCF 60          RTS
}


;;; $8CD0: Instruction - activate missile station ;;;
{
$84:8CD0 DA          PHX
$84:8CD1 5A          PHY
$84:8CD2 AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$84:8CD5 CD C6 09    CMP $09C6  [$7E:09C6]  ;} If [Samus missiles] != [Samus max missiles]:
$84:8CD8 F0 0D       BEQ $0D    [$8CE7]     ;/
$84:8CDA A9 16 00    LDA #$0016             ;\
$84:8CDD 22 80 80 85 JSL $858080[$85:8080]  ;} Display missile reload completed message box
$84:8CE1 AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$84:8CE4 8D C6 09    STA $09C6  [$7E:09C6]  ;} Samus missiles = [Samus max missiles]
                                            
$84:8CE7 A9 01 00    LDA #$0001             ;\
$84:8CEA 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$84:8CEE 7A          PLY
$84:8CEF FA          PLX
$84:8CF0 60          RTS
}


;;; $8CF1: Instruction - go to [[Y]] if [save confirmation selection] = no, otherwise activate save station ;;;
{
$84:8CF1 DA          PHX
$84:8CF2 5A          PHY
$84:8CF3 A9 17 00    LDA #$0017             ;\
$84:8CF6 22 80 80 85 JSL $858080[$85:8080]  ;} Display save confirmation message box
$84:8CFA C9 02 00    CMP #$0002             ;\
$84:8CFD F0 33       BEQ $33    [$8D32]     ;} If [save confirmation selection] != no:
$84:8CFF AE 27 1C    LDX $1C27  [$7E:1C27]
$84:8D02 A0 D2 E6    LDY #$E6D2             ;\
$84:8D05 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn save station electricity enemy projectile
$84:8D09 BD C7 1D    LDA $1DC7,x[$7E:1E15]  ;\
$84:8D0C 29 07 00    AND #$0007             ;} Load station index = [PLM room argument] & 7
$84:8D0F 8D 8B 07    STA $078B  [$7E:078B]  ;/
$84:8D12 22 8E 81 80 JSL $80818E[$80:818E]  ;\
$84:8D16 AD 9F 07    LDA $079F  [$7E:079F]  ;|
$84:8D19 0A          ASL A                  ;|
$84:8D1A AA          TAX                    ;} Set save station [load station index] in current area
$84:8D1B BF F8 D8 7E LDA $7ED8F8,x[$7E:D8F8];|
$84:8D1F 0D E7 05    ORA $05E7  [$7E:05E7]  ;|
$84:8D22 9F F8 D8 7E STA $7ED8F8,x[$7E:D8F8];/
$84:8D26 AD 52 09    LDA $0952  [$7E:0952]  ;\
$84:8D29 22 00 80 81 JSL $818000[$81:8000]  ;} Save current save slot to SRAM
$84:8D2D 7A          PLY
$84:8D2E FA          PLX
$84:8D2F C8          INY                    ;\
$84:8D30 C8          INY                    ;} Y += 2
$84:8D31 60          RTS                    ; Return

$84:8D32 7A          PLY
$84:8D33 FA          PLX
$84:8D34 B9 00 00    LDA $0000,y            ;\
$84:8D37 A8          TAY                    ;} Y = [[Y]]
$84:8D38 60          RTS
}


;;; $8D39: Unused. Instruction - resume music in 6 seconds ;;;
{
$84:8D39 A9 68 01    LDA #$0168             ;\
$84:8D3C 22 18 E1 82 JSL $82E118[$82:E118]  ;} Play room music track after 6 seconds
$84:8D40 60          RTS
}


;;; $8D41: Instruction - go to [[Y] + 2] if Samus is within [[Y]] columns and [[Y] + 1] rows of PLM ;;;
{
$84:8D41 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$84:8D45 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:8D48 4A          LSR A                  ;|
$84:8D49 4A          LSR A                  ;|
$84:8D4A 4A          LSR A                  ;|
$84:8D4B 4A          LSR A                  ;|
$84:8D4C 38          SEC                    ;|
$84:8D4D ED 29 1C    SBC $1C29  [$7E:1C29]  ;|
$84:8D50 10 04       BPL $04    [$8D56]     ;|
$84:8D52 49 FF FF    EOR #$FFFF             ;} If |[Samus X position] / 10h - [PLM X block]| > [[Y]]: go to BRANCH_TOO_FAR
$84:8D55 1A          INC A                  ;|
                                            ;|
$84:8D56 E2 20       SEP #$20               ;|
$84:8D58 D9 00 00    CMP $0000,y[$84:D8EF]  ;|
$84:8D5B C2 20       REP #$20               ;|
$84:8D5D F0 02       BEQ $02    [$8D61]     ;|
$84:8D5F B0 21       BCS $21    [$8D82]     ;/

$84:8D61 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$84:8D64 4A          LSR A                  ;|
$84:8D65 4A          LSR A                  ;|
$84:8D66 4A          LSR A                  ;|
$84:8D67 4A          LSR A                  ;|
$84:8D68 38          SEC                    ;|
$84:8D69 ED 2B 1C    SBC $1C2B  [$7E:1C2B]  ;|
$84:8D6C 10 04       BPL $04    [$8D72]     ;|
$84:8D6E 49 FF FF    EOR #$FFFF             ;} If |[Samus Y position] / 10h - [PLM Y block]| > [[Y] + 1]: go to BRANCH_TOO_FAR
$84:8D71 1A          INC A                  ;|
                                            ;|
$84:8D72 E2 20       SEP #$20               ;|
$84:8D74 D9 01 00    CMP $0001,y[$84:D8F0]  ;|
$84:8D77 C2 20       REP #$20               ;|
$84:8D79 F0 02       BEQ $02    [$8D7D]     ;|
$84:8D7B B0 05       BCS $05    [$8D82]     ;/

$84:8D7D B9 02 00    LDA $0002,y[$84:D8F1]  ;\
$84:8D80 A8          TAY                    ;} Y = [[Y] + 2]
$84:8D81 60          RTS                    ; Return

; BRANCH_TOO_FAR
$84:8D82 98          TYA                    ;\
$84:8D83 18          CLC                    ;|
$84:8D84 69 04 00    ADC #$0004             ;} Y += 4
$84:8D87 A8          TAY                    ;/
$84:8D88 60          RTS
}


;;; $8D89: Unused. Instruction - move PLM down one block ;;;
{
$84:8D89 BD 87 1C    LDA $1C87,x            ;\
$84:8D8C 18          CLC                    ;|
$84:8D8D 6D A5 07    ADC $07A5  [$7E:07A5]  ;} PLM block index += [room width in blocks]
$84:8D90 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:8D93 9D 87 1C    STA $1C87,x            ;/
$84:8D96 60          RTS
}
}


;;; $8D97..924C: Routines ;;;
{
;;; $8D97: RTS ;;;
{
$84:8D97 60          RTS
}


;;; $8D98: Unused. Default PLM instruction list ;;;
{
$84:8D98             dw 1000,8DA0,
                        8724,8D98
}


;;; $8DA0: Default PLM draw instruction ;;;
{
; Note that this is an invalid draw instruction
; Used by instruction list $8D98: Unused. Default PLM instruction list
$84:8DA0             dw 0180,0000,
                        0000
}


;;; $8DA6: Unused. Draw PLM with custom draw instruction pointer and tilemap base addresses ;;;
{
$84:8DA6 20 BB 8D    JSR $8DBB  [$84:8DBB]
$84:8DA9 6B          RTL
}


;;; $8DAA: Draw PLM ;;;
{
;; Parameter:
;;     X: PLM index
$84:8DAA C2 30       REP #$30
$84:8DAC A9 00 50    LDA #$5000             ;\
$84:8DAF 85 09       STA $09    [$7E:0009]  ;} $09 = VRAM map 1st screen base address
$84:8DB1 A9 E0 53    LDA #$53E0             ;\
$84:8DB4 85 0C       STA $0C    [$7E:000C]  ;} $0C = VRAM map 2nd screen base address - 20h (devs opted to subtract 20h here, rather than take $18 & Fh before summing)
$84:8DB6 BF 6C DE 7E LDA $7EDE6C,x[$7E:DEB8];\
$84:8DBA A8          TAY                    ;} Y = [PLM draw instruction pointer]

$84:8DBB AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$84:8DBE 85 1E       STA $1E    [$7E:001E]  ;} PLM draw X block = [PLM X block]
$84:8DC0 AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$84:8DC3 85 20       STA $20    [$7E:0020]  ;} PLM draw Y block = [PLM Y block]

; LOOP_DRAW_ENTRY
$84:8DC5 AD 15 09    LDA $0915  [$7E:0915]  ;\
$84:8DC8 4A          LSR A                  ;|
$84:8DC9 4A          LSR A                  ;|
$84:8DCA 4A          LSR A                  ;} Screen Y block = [layer 1 Y position] / 10h
$84:8DCB 4A          LSR A                  ;|
$84:8DCC 85 1A       STA $1A    [$7E:001A]  ;/
$84:8DCE 18          CLC                    ;\
$84:8DCF 69 0F 00    ADC #$000F             ;|
$84:8DD2 C5 20       CMP $20    [$7E:0020]  ;} If [screen Y block] + Fh < [PLM draw Y block]: return
$84:8DD4 10 01       BPL $01    [$8DD7]     ;|
$84:8DD6 60          RTS                    ;/

$84:8DD7 B9 00 00    LDA $0000,y[$84:A9FB]  ;\
$84:8DDA 10 03       BPL $03    [$8DDF]     ;} If [[Y]] & 8000h:
$84:8DDC 4C 1F 90    JMP $901F  [$84:901F]  ; Go to BRANCH_VERTICAL

; Horizontal
{
$84:8DDF 29 FF 7F    AND #$7FFF             ;\
$84:8DE2 85 14       STA $14    [$7E:0014]  ;} Draw length = [[Y]]
$84:8DE4 64 1C       STZ $1C    [$7E:001C]  ; Clear 32-byte increment mode flag
$84:8DE6 A5 20       LDA $20    [$7E:0020]  ;\
$84:8DE8 C5 1A       CMP $1A    [$7E:001A]  ;} If [PLM draw Y block] < [screen Y block]: return
$84:8DEA 30 43       BMI $43    [$8E2F]     ;/
$84:8DEC 85 1A       STA $1A    [$7E:001A]  ; $1A = [PLM draw Y block]
$84:8DEE 64 12       STZ $12    [$7E:0012]  ; Number of blocks skipped = 0
$84:8DF0 A5 1E       LDA $1E    [$7E:001E]  ;\
$84:8DF2 85 18       STA $18    [$7E:0018]  ;} $18 = [PLM draw X block]
$84:8DF4 AD 11 09    LDA $0911  [$7E:0911]  ;\
$84:8DF7 18          CLC                    ;|
$84:8DF8 69 0F 00    ADC #$000F             ;|
$84:8DFB 4A          LSR A                  ;|
$84:8DFC 4A          LSR A                  ;} Block left of screen = ([layer 1 X position] - 1) / 10h
$84:8DFD 4A          LSR A                  ;|
$84:8DFE 4A          LSR A                  ;|
$84:8DFF 3A          DEC A                  ;|
$84:8E00 85 16       STA $16    [$7E:0016]  ;/
$84:8E02 38          SEC                    ;\
$84:8E03 E5 1E       SBC $1E    [$7E:001E]  ;|
$84:8E05 30 1C       BMI $1C    [$8E23]     ;} If [PLM draw X block] < [block left of screen]:
$84:8E07 F0 1A       BEQ $1A    [$8E23]     ;/
$84:8E09 85 12       STA $12    [$7E:0012]  ; Number of blocks skipped = [block left of screen] - [PLM draw X block]
$84:8E0B A5 14       LDA $14    [$7E:0014]  ;\
$84:8E0D 18          CLC                    ;|
$84:8E0E 65 1E       ADC $1E    [$7E:001E]  ;|
$84:8E10 C5 16       CMP $16    [$7E:0016]  ;} If [draw length] + [PLM draw X block] <= 0: return
$84:8E12 F0 1B       BEQ $1B    [$8E2F]     ;|
$84:8E14 30 19       BMI $19    [$8E2F]     ;/
$84:8E16 A5 14       LDA $14    [$7E:0014]  ; >_<;
$84:8E18 A5 14       LDA $14    [$7E:0014]  ;\
$84:8E1A 38          SEC                    ;|
$84:8E1B E5 12       SBC $12    [$7E:0012]  ;} Draw length -= [number of blocks skipped]
$84:8E1D 85 14       STA $14    [$7E:0014]  ;/
$84:8E1F A5 16       LDA $16    [$7E:0016]  ;\
$84:8E21 85 18       STA $18    [$7E:0018]  ;} PLM draw X block = [block left of screen]

$84:8E23 A5 16       LDA $16    [$7E:0016]  ;\
$84:8E25 18          CLC                    ;|
$84:8E26 69 11 00    ADC #$0011             ;} Block right of screen = [block left of screen] + 11h
$84:8E29 85 16       STA $16    [$7E:0016]  ;/
$84:8E2B C5 1E       CMP $1E    [$7E:001E]  ;\
$84:8E2D 10 01       BPL $01    [$8E30]     ;} If [block right of screen] < [PLM draw X block]: return

$84:8E2F 60          RTS

$84:8E30 A5 18       LDA $18    [$7E:0018]  ;\
$84:8E32 18          CLC                    ;|
$84:8E33 65 14       ADC $14    [$7E:0014]  ;|
$84:8E35 3A          DEC A                  ;} Number of blocks truncated = [PLM draw X block] + [draw length] - 1 - [block right of screen]
$84:8E36 38          SEC                    ;|
$84:8E37 E5 16       SBC $16    [$7E:0016]  ;|
$84:8E39 85 16       STA $16    [$7E:0016]  ;/
$84:8E3B 30 09       BMI $09    [$8E46]     ; If [number of blocks truncated] >= 0:
$84:8E3D A5 14       LDA $14    [$7E:0014]  ;\
$84:8E3F 38          SEC                    ;|
$84:8E40 E5 16       SBC $16    [$7E:0016]  ;} Draw length -= [number of blocks truncated]
$84:8E42 85 14       STA $14    [$7E:0014]  ;/
$84:8E44 F0 E9       BEQ $E9    [$8E2F]     ; If [draw length] = 0: return

$84:8E46 DA          PHX
$84:8E47 AE 30 03    LDX $0330  [$7E:0330]  ;\
$84:8E4A E0 E0 01    CPX #$01E0             ;} If [VRAM write table stack pointer] >= 1E0h: return (this number seems pretty random, it's not even a multiple of 7)
$84:8E4D 30 02       BMI $02    [$8E51]     ;/

$84:8E4F FA          PLX
$84:8E50 60          RTS

$84:8E51 A9 00 02    LDA #$0200             ;\
$84:8E54 38          SEC                    ;|
$84:8E55 ED 25 1C    SBC $1C25  [$7E:1C25]  ;|
$84:8E58 4A          LSR A                  ;|
$84:8E59 4A          LSR A                  ;} If (200h - [PLM draw tilemap index]) / 8 < [draw length]: return (not enough space for the new tilemap)
$84:8E5A 4A          LSR A                  ;|
$84:8E5B C5 14       CMP $14    [$7E:0014]  ;|
$84:8E5D 30 F0       BMI $F0    [$8E4F]     ;/
$84:8E5F A5 1A       LDA $1A    [$7E:001A]  ;\
$84:8E61 29 0F 00    AND #$000F             ;|
$84:8E64 09 00 40    ORA #$4000             ;} Calculate ([PLM draw Y block] & Fh) * 40h
$84:8E67 8D 02 42    STA $4202  [$7E:4202]  ;/
$84:8E6A A5 18       LDA $18    [$7E:0018]  ;\
$84:8E6C 29 1F 00    AND #$001F             ;|
$84:8E6F C9 10 00    CMP #$0010             ;} If [PLM draw X block] & 1Fh < 10h:
$84:8E72 B0 18       BCS $18    [$8E8C]     ;/
$84:8E74 0A          ASL A                  ;\
$84:8E75 18          CLC                    ;|
$84:8E76 65 09       ADC $09    [$7E:0009]  ;} PLM draw tilemap VRAM destination = ([PLM draw X block] & 1Fh) * 2 + VRAM map 1st screen base address + ([PLM draw Y block] & Fh) * 40h
$84:8E78 6D 16 42    ADC $4216  [$7E:4216]  ;|
$84:8E7B 48          PHA                    ;/
$84:8E7C AD 1D 09    LDA $091D  [$7E:091D]  ;\
$84:8E7F 29 00 01    AND #$0100             ;} If [BG1 X scroll offset] & 100h != 0:
$84:8E82 F0 1E       BEQ $1E    [$8EA2]     ;/
$84:8E84 68          PLA                    ;\
$84:8E85 18          CLC                    ;|
$84:8E86 69 00 04    ADC #$0400             ;} PLM draw tilemap VRAM destination = ([PLM draw X block] & 1Fh) * 2 + VRAM map 2nd screen base address + ([PLM draw Y block] & Fh) * 40h
$84:8E89 48          PHA                    ;/
$84:8E8A 80 16       BRA $16    [$8EA2]

$84:8E8C 0A          ASL A                  ;\ Else ([PLM draw X block] & 1Fh >= 10h):
$84:8E8D 18          CLC                    ;|
$84:8E8E 65 0C       ADC $0C    [$7E:000C]  ;} PLM draw tilemap VRAM destination = ([PLM draw X block] & 1Fh) * 2 - 20h + VRAM map 2nd screen base address + ([PLM draw Y block] & Fh) * 40h
$84:8E90 6D 16 42    ADC $4216  [$7E:4216]  ;|
$84:8E93 48          PHA                    ;/
$84:8E94 AD 1D 09    LDA $091D  [$7E:091D]  ;\
$84:8E97 29 00 01    AND #$0100             ;} If [BG1 X scroll offset] & 100h != 0:
$84:8E9A F0 06       BEQ $06    [$8EA2]     ;/
$84:8E9C 68          PLA                    ;\
$84:8E9D 38          SEC                    ;|
$84:8E9E E9 00 04    SBC #$0400             ;} PLM draw tilemap VRAM destination = ([PLM draw X block] & 1Fh) * 2 - 20h + VRAM map 1st screen base address + ([PLM draw Y block] & Fh) * 40h
$84:8EA1 48          PHA                    ;/

$84:8EA2 A5 14       LDA $14    [$7E:0014]  ;\
$84:8EA4 0A          ASL A                  ;} $1E = [draw length] * 2
$84:8EA5 85 1E       STA $1E    [$7E:001E]  ;/
$84:8EA7 68          PLA                    ;\
$84:8EA8 48          PHA                    ;|
$84:8EA9 29 1F 00    AND #$001F             ;} $22 = [PLM draw tilemap VRAM destination] & 1Fh
$84:8EAC 85 22       STA $22    [$7E:0022]  ;/
$84:8EAE 18          CLC                    ;\
$84:8EAF 65 1E       ADC $1E    [$7E:001E]  ;|
$84:8EB1 3A          DEC A                  ;} If ([PLM draw tilemap VRAM destination] & 1Fh) + [draw length] * 2 - 1 < 20h: (all blocks being drawn are on the same VRAM screen)
$84:8EB2 29 E0 FF    AND #$FFE0             ;|
$84:8EB5 D0 03       BNE $03    [$8EBA]     ;/
$84:8EB7 4C 2F 8F    JMP $8F2F  [$84:8F2F]  ; Go to BRANCH_HORIZONTAL_ONE_SCREEN

$84:8EBA E0 E4 00    CPX #$00E4             ;\
$84:8EBD 10 6D       BPL $6D    [$8F2C]     ;} If [VRAM write table stack pointer] >= E4h: return
$84:8EBF A9 20 00    LDA #$0020             ;\
$84:8EC2 38          SEC                    ;|
$84:8EC3 E5 22       SBC $22    [$7E:0022]  ;} If [PLM draw tilemap VRAM destination] & 1Fh > 20h: return (impossible)
$84:8EC5 30 65       BMI $65    [$8F2C]     ;/
$84:8EC7 0A          ASL A                  ;\
$84:8EC8 95 D0       STA $D0,x  [$7E:00D0]  ;} VRAM write table entry 0 size + [X] = (20h - ([PLM draw tilemap VRAM destination] & 1Fh)) * 2 (size until end of screen)
$84:8ECA 95 DE       STA $DE,x  [$7E:00DE]  ; VRAM write table entry 2 size + [X] = [VRAM write table entry 0 size + [X]]
$84:8ECC 68          PLA                    ;\
$84:8ECD 95 D5       STA $D5,x  [$7E:00D5]  ;} VRAM write table entry 0 destination + [X] = [PLM draw tilemap VRAM destination]
$84:8ECF 29 E0 FF    AND #$FFE0             ;\
$84:8ED2 49 00 04    EOR #$0400             ;} VRAM write table entry 1 destination + [X] = [PLM draw tilemap VRAM destination] & FFE0h ^ 400h (address of start of other screen)
$84:8ED5 95 DC       STA $DC,x  [$7E:00DC]  ;/
$84:8ED7 B5 DC       LDA $DC,x  [$7E:00DC]
$84:8ED9 18          CLC                    ;\
$84:8EDA 69 20 00    ADC #$0020             ;} VRAM write table entry 3 destination + [X] = [VRAM write table entry 1 destination + [X]] + 20h (address of row below entry 1)
$84:8EDD 95 EA       STA $EA,x  [$7E:00EA]  ;/
$84:8EDF B5 D5       LDA $D5,x  [$7E:00D5]  ;\
$84:8EE1 18          CLC                    ;|
$84:8EE2 69 20 00    ADC #$0020             ;} VRAM write table entry 2 destination + [X] = [VRAM write table entry 0 destination + [X]] + 20h (address of row below entry 0)
$84:8EE5 95 E3       STA $E3,x  [$7E:00E3]  ;/
$84:8EE7 A5 14       LDA $14    [$7E:0014]  ;\
$84:8EE9 0A          ASL A                  ;|
$84:8EEA 0A          ASL A                  ;|
$84:8EEB 85 1E       STA $1E    [$7E:001E]  ;} VRAM write table entry 1 size + [X] = [draw length] * 4 - [VRAM write table entry 0 size + [X]] (the remaining size after entry 0)
$84:8EED 38          SEC                    ;|
$84:8EEE F5 D0       SBC $D0,x  [$7E:00D0]  ;|
$84:8EF0 95 D7       STA $D7,x  [$7E:00D7]  ;/
$84:8EF2 95 E5       STA $E5,x  [$7E:00E5]  ; VRAM write table entry 3 size + [X] = [VRAM write table entry 1 size + [X]]
$84:8EF4 A9 C8 C6    LDA #$C6C8             ;\
$84:8EF7 18          CLC                    ;|
$84:8EF8 6D 25 1C    ADC $1C25  [$7E:1C25]  ;} PLM draw tilemap top halves source address = VRAM write table entry 0 source address + [X] = PLM draw tilemap + [PLM draw tilemap index]
$84:8EFB 95 D2       STA $D2,x  [$7E:00D2]  ;|
$84:8EFD 85 00       STA $00    [$7E:0000]  ;/
$84:8EFF 18          CLC                    ;\
$84:8F00 75 D0       ADC $D0,x  [$7E:00D0]  ;} VRAM write table entry 1 source address + [X] = [VRAM write table entry 0 source address + [X]] + [VRAM write table entry 0 size + [X]]
$84:8F02 95 D9       STA $D9,x  [$7E:00D9]  ;/
$84:8F04 18          CLC                    ;\
$84:8F05 75 D7       ADC $D7,x  [$7E:00D7]  ;|
$84:8F07 95 E0       STA $E0,x  [$7E:00E0]  ;} PLM draw tilemap bottom halves source address = VRAM write table entry 2 source address + [X] = [VRAM write table entry 1 source address + [X]] + [VRAM write table entry 1 size + [X]]
$84:8F09 85 06       STA $06    [$7E:0006]  ;/
$84:8F0B 18          CLC                    ;\
$84:8F0C 75 DE       ADC $DE,x  [$7E:00DE]  ;} VRAM write table entry 3 source address + [X] = [VRAM write table entry 2 source address + [X]] + [VRAM write table entry 2 size + [X]]
$84:8F0E 95 E7       STA $E7,x  [$7E:00E7]  ;/
$84:8F10 E2 20       SEP #$20
$84:8F12 A9 7E       LDA #$7E               ;\
$84:8F14 95 D4       STA $D4,x  [$7E:00D4]  ;} VRAM write table entry 0 source bank + [X] = $7E
$84:8F16 85 02       STA $02    [$7E:0002]  ; PLM draw tilemap top halves source bank = $7E
$84:8F18 95 DB       STA $DB,x  [$7E:00DB]  ; VRAM write table entry 1 source bank + [X] = $7E
$84:8F1A 85 08       STA $08    [$7E:0008]  ; PLM draw tilemap bottom halves source bank = $7E
$84:8F1C 95 E2       STA $E2,x  [$7E:00E2]  ; VRAM write table entry 2 source bank + [X] = $7E
$84:8F1E 95 E9       STA $E9,x  [$7E:00E9]  ; VRAM write table entry 3 source bank + [X] = $7E
$84:8F20 C2 20       REP #$20
$84:8F22 8A          TXA                    ;\
$84:8F23 18          CLC                    ;|
$84:8F24 69 1C 00    ADC #$001C             ;} VRAM write table stack pointer += 1Ch
$84:8F27 8D 30 03    STA $0330  [$7E:0330]  ;/
$84:8F2A 80 17       BRA $17    [$8F43]     ; Go to BRANCH_HORIZONTAL_ADD_TO_VRAM_WRITE_TABLE_END

$84:8F2C 68          PLA
$84:8F2D FA          PLX
$84:8F2E 60          RTS

; BRANCH_HORIZONTAL_ONE_SCREEN
$84:8F2F 68          PLA                    ; A = [PLM draw tilemap VRAM destination]
$84:8F30 20 20 92    JSR $9220  [$84:9220]  ; Partially set up VRAM write table entries for single-screen PLM draw tilemap
$84:8F33 B5 D5       LDA $D5,x  [$7E:00D5]  ;\
$84:8F35 18          CLC                    ;|
$84:8F36 69 20 00    ADC #$0020             ;} VRAM write table entry 1 destination + [X] = [VRAM write table entry 0 destination + [X]] + 20h
$84:8F39 95 DC       STA $DC,x  [$7E:00DC]  ;/
$84:8F3B 8A          TXA                    ;\
$84:8F3C 18          CLC                    ;|
$84:8F3D 69 0E 00    ADC #$000E             ;} VRAM write table stack pointer += Eh
$84:8F40 8D 30 03    STA $0330  [$7E:0330]  ;/

; BRANCH_HORIZONTAL_ADD_TO_VRAM_WRITE_TABLE_END
$84:8F43 A5 12       LDA $12    [$7E:0012]  ;\
$84:8F45 0A          ASL A                  ;|
$84:8F46 85 12       STA $12    [$7E:0012]  ;|
$84:8F48 C8          INY                    ;|
$84:8F49 C8          INY                    ;} Draw data address = [Y] + 2 + [number of blocks skipped] * 2
$84:8F4A 98          TYA                    ;|
$84:8F4B 18          CLC                    ;|
$84:8F4C 65 12       ADC $12    [$7E:0012]  ;|
$84:8F4E 85 03       STA $03    [$7E:0003]  ;/
$84:8F50 A0 00 00    LDY #$0000             ; PLM draw tilemap index = 0

; LOOP_HORIZONTAL_BLOCK
$84:8F53 B2 03       LDA ($03)  [$84:AA39]  ;\
$84:8F55 85 1E       STA $1E    [$7E:001E]  ;} Block = [[draw data address]]
$84:8F57 29 FF 03    AND #$03FF             ;\
$84:8F5A 0A          ASL A                  ;|
$84:8F5B 0A          ASL A                  ;} Tile table index = ([block] & 3FFh) * 8
$84:8F5C 0A          ASL A                  ;|
$84:8F5D AA          TAX                    ;/
$84:8F5E A5 1E       LDA $1E    [$7E:001E]  ;\
$84:8F60 29 00 0C    AND #$0C00             ;} If [block] & C00h != 0: go to BRANCH_HORIZONTAL_COPY_BLOCK_WITH_FLIP
$84:8F63 D0 1C       BNE $1C    [$8F81]     ;/
$84:8F65 BF 00 A0 7E LDA $7EA000,x[$7E:A1E0];\
$84:8F69 97 00       STA [$00],y[$7E:C6D0]  ;} Copy top-left VRAM tile of the block
$84:8F6B BF 04 A0 7E LDA $7EA004,x[$7E:A1E4];\
$84:8F6F 97 06       STA [$06],y[$7E:C6E0]  ;} Copy bottom-left VRAM tile of the block
$84:8F71 C8          INY                    ;\
$84:8F72 C8          INY                    ;|
$84:8F73 BF 02 A0 7E LDA $7EA002,x[$7E:A1E2];} Copy top-right VRAM tile of the block
$84:8F77 97 00       STA [$00],y[$7E:C6D2]  ;/
$84:8F79 BF 06 A0 7E LDA $7EA006,x[$7E:A1E6];\
$84:8F7D 97 06       STA [$06],y[$7E:C6E2]  ;} Copy bottom-right VRAM tile of the block
$84:8F7F 80 2B       BRA $2B    [$8FAC]     ; Go to BRANCH_HORIZONTAL_NEXT_BLOCK

; BRANCH_HORIZONTAL_COPY_BLOCK_WITH_FLIP
$84:8F81 C9 00 04    CMP #$0400             ;\
$84:8F84 D0 44       BNE $44    [$8FCA]     ;} If [block] & C00h != 400h: go to BRANCH_HORIZONTAL_COPY_BLOCK_WITH_VERTICAL_FLIP
$84:8F86 BF 02 A0 7E LDA $7EA002,x[$7E:A1EA];\
$84:8F8A 49 00 40    EOR #$4000             ;|
$84:8F8D 97 00       STA [$00],y[$7E:C6C8]  ;|
$84:8F8F BF 06 A0 7E LDA $7EA006,x[$7E:A1EE];|
$84:8F93 49 00 40    EOR #$4000             ;|
$84:8F96 97 06       STA [$06],y[$7E:C6D8]  ;|
$84:8F98 C8          INY                    ;|
$84:8F99 C8          INY                    ;} Copy the four VRAM tiles of the block, with horizontal flip
$84:8F9A BF 00 A0 7E LDA $7EA000,x[$7E:A1E8];|
$84:8F9E 49 00 40    EOR #$4000             ;|
$84:8FA1 97 00       STA [$00],y[$7E:C6CA]  ;|
$84:8FA3 BF 04 A0 7E LDA $7EA004,x[$7E:A1EC];|
$84:8FA7 49 00 40    EOR #$4000             ;|
$84:8FAA 97 06       STA [$06],y[$7E:C6DA]  ;/

; BRANCH_HORIZONTAL_NEXT_BLOCK
$84:8FAC C8          INY                    ;\
$84:8FAD C8          INY                    ;} Next PLM draw tilemap index
$84:8FAE E6 03       INC $03    [$7E:0003]  ;\
$84:8FB0 E6 03       INC $03    [$7E:0003]  ;} Draw data address += 2
$84:8FB2 AD 25 1C    LDA $1C25  [$7E:1C25]  ;\
$84:8FB5 18          CLC                    ;|
$84:8FB6 69 08 00    ADC #$0008             ;} PLM draw tilemap index += 8
$84:8FB9 8D 25 1C    STA $1C25  [$7E:1C25]  ;/
$84:8FBC C9 00 02    CMP #$0200             ;\
$84:8FBF 10 07       BPL $07    [$8FC8]     ;} If [PLM draw tilemap index] >= 200h: return (impossible)
$84:8FC1 C6 14       DEC $14    [$7E:0014]  ; Decrement draw length
$84:8FC3 D0 8E       BNE $8E    [$8F53]     ; If [draw length] != 0: go to LOOP_HORIZONTAL_BLOCK
$84:8FC5 4C 8E 91    JMP $918E  [$84:918E]  ; Go to BRANCH_NEXT_DRAW_ENTRY

$84:8FC8 FA          PLX
$84:8FC9 60          RTS

; BRANCH_HORIZONTAL_COPY_BLOCK_WITH_VERTICAL_FLIP
$84:8FCA C9 00 08    CMP #$0800             ;\
$84:8FCD D0 28       BNE $28    [$8FF7]     ;} If [block] & C00h != 800h: go to BRANCH_HORIZONTAL_COPY_BLOCK_WITH_BOTH_FLIPS
$84:8FCF BF 04 A0 7E LDA $7EA004,x[$7E:A41C];\
$84:8FD3 49 00 80    EOR #$8000             ;|
$84:8FD6 97 00       STA [$00],y[$7E:C6D0]  ;|
$84:8FD8 BF 00 A0 7E LDA $7EA000,x[$7E:A418];|
$84:8FDC 49 00 80    EOR #$8000             ;|
$84:8FDF 97 06       STA [$06],y[$7E:C6E0]  ;|
$84:8FE1 C8          INY                    ;|
$84:8FE2 C8          INY                    ;} Copy the four VRAM tiles of the block, with vertical flip
$84:8FE3 BF 06 A0 7E LDA $7EA006,x[$7E:A41E];|
$84:8FE7 49 00 80    EOR #$8000             ;|
$84:8FEA 97 00       STA [$00],y[$7E:C6D2]  ;|
$84:8FEC BF 02 A0 7E LDA $7EA002,x[$7E:A41A];|
$84:8FF0 49 00 80    EOR #$8000             ;|
$84:8FF3 97 06       STA [$06],y[$7E:C6E2]  ;/
$84:8FF5 80 B5       BRA $B5    [$8FAC]     ; Go to BRANCH_HORIZONTAL_NEXT_BLOCK

; BRANCH_HORIZONTAL_COPY_BLOCK_WITH_BOTH_FLIPS
$84:8FF7 BF 06 A0 7E LDA $7EA006,x[$7E:A426];\
$84:8FFB 49 00 C0    EOR #$C000             ;|
$84:8FFE 97 00       STA [$00],y[$7E:C6C8]  ;|
$84:9000 BF 02 A0 7E LDA $7EA002,x[$7E:A422];|
$84:9004 49 00 C0    EOR #$C000             ;|
$84:9007 97 06       STA [$06],y[$7E:C6D8]  ;|
$84:9009 C8          INY                    ;|
$84:900A C8          INY                    ;} Copy the four VRAM tiles of the block, with horizontal and vertical flip
$84:900B BF 04 A0 7E LDA $7EA004,x[$7E:A424];|
$84:900F 49 00 C0    EOR #$C000             ;|
$84:9012 97 00       STA [$00],y[$7E:C6CA]  ;|
$84:9014 BF 00 A0 7E LDA $7EA000,x[$7E:A420];|
$84:9018 49 00 C0    EOR #$C000             ;|
$84:901B 97 06       STA [$06],y[$7E:C6DA]  ;/
$84:901D 80 8D       BRA $8D    [$8FAC]     ; Go to BRANCH_HORIZONTAL_NEXT_BLOCK
}

; BRANCH_VERTICAL
{
$84:901F 29 FF 7F    AND #$7FFF             ;\
$84:9022 85 14       STA $14    [$7E:0014]  ;} Draw length = [[Y]] & 7FFFh
$84:9024 AD 11 09    LDA $0911  [$7E:0911]  ;\
$84:9027 4A          LSR A                  ;|
$84:9028 4A          LSR A                  ;|
$84:9029 4A          LSR A                  ;|
$84:902A 4A          LSR A                  ;} If (screen X block) > [PLM draw X block]: return
$84:902B C5 1E       CMP $1E    [$7E:001E]  ;|
$84:902D F0 02       BEQ $02    [$9031]     ;|
$84:902F 10 0A       BPL $0A    [$903B]     ;/

$84:9031 18          CLC                    ;\
$84:9032 69 11 00    ADC #$0011             ;|
$84:9035 C5 1E       CMP $1E    [$7E:001E]  ;} If (screen X block) + 11h <= [PLM draw X block]: return
$84:9037 F0 02       BEQ $02    [$903B]     ;|
$84:9039 10 01       BPL $01    [$903C]     ;/

$84:903B 60          RTS

$84:903C A5 1E       LDA $1E    [$7E:001E]  ;\
$84:903E 85 18       STA $18    [$7E:0018]  ;} $18 = [PLM draw X block]
$84:9040 64 12       STZ $12    [$7E:0012]  ; Number of blocks skipped = 0
$84:9042 A5 1A       LDA $1A    [$7E:001A]  ;\
$84:9044 18          CLC                    ;|
$84:9045 69 10 00    ADC #$0010             ;} Block below screen = [screen Y block] + 10h
$84:9048 85 16       STA $16    [$7E:0016]  ;/
$84:904A A5 1A       LDA $1A    [$7E:001A]  ;\
$84:904C 38          SEC                    ;|
$84:904D E5 20       SBC $20    [$7E:0020]  ;} If [PLM draw Y block] <= [screen Y block]:
$84:904F 30 17       BMI $17    [$9068]     ;/
$84:9051 85 12       STA $12    [$7E:0012]  ; Number of blocks skipped = [screen Y block] - [PLM draw Y block]
$84:9053 A5 14       LDA $14    [$7E:0014]  ;\
$84:9055 18          CLC                    ;|
$84:9056 65 20       ADC $20    [$7E:0020]  ;} If [PLM draw Y block] + [draw length] < [screen Y block]: return
$84:9058 C5 1A       CMP $1A    [$7E:001A]  ;|
$84:905A 30 DF       BMI $DF    [$903B]     ;/
$84:905C A5 14       LDA $14    [$7E:0014]  ;\
$84:905E 38          SEC                    ;|
$84:905F E5 12       SBC $12    [$7E:0012]  ;} Draw length -= [number of blocks skipped]
$84:9061 85 14       STA $14    [$7E:0014]  ;/

$84:9063 30 FE       BMI $FE    [$9063]     ; If [draw length] < 0: crash (!) (TODO: check if this is possible)
$84:9065 D0 05       BNE $05    [$906C]     ; If [draw length] = 0: return
$84:9067 60          RTS

$84:9068 A5 20       LDA $20    [$7E:0020]  ;\ Else ([PLM draw Y block] > [screen Y block]):
$84:906A 85 1A       STA $1A    [$7E:001A]  ;} $1A = [PLM draw Y block]

$84:906C A5 1A       LDA $1A    [$7E:001A]  ;\
$84:906E 18          CLC                    ;|
$84:906F 65 14       ADC $14    [$7E:0014]  ;|
$84:9071 38          SEC                    ;} Number of blocks truncated = [PLM draw Y block] + [draw length] - [block below screen]
$84:9072 E5 16       SBC $16    [$7E:0016]  ;|
$84:9074 85 16       STA $16    [$7E:0016]  ;/
$84:9076 30 0B       BMI $0B    [$9083]     ; If [number of blocks truncated] >= 0:
$84:9078 A5 14       LDA $14    [$7E:0014]  ;\
$84:907A 38          SEC                    ;|
$84:907B E5 16       SBC $16    [$7E:0016]  ;} Draw length -= [number of blocks truncated]
$84:907D 85 14       STA $14    [$7E:0014]  ;/
$84:907F F0 BA       BEQ $BA    [$903B]     ; If [draw length] = 0: return
$84:9081 30 09       BMI $09    [$908C]     ; If [draw length] < 0: pull X and return (TODO: check if this is possible; if so, makes draw PLM block instruction *not* terminate PLM handling)

$84:9083 DA          PHX
$84:9084 AE 30 03    LDX $0330  [$7E:0330]  ;\
$84:9087 E0 F0 00    CPX #$00F0             ;} If [VRAM write table stack pointer] >= F0h: return
$84:908A 30 02       BMI $02    [$908E]     ;/

$84:908C FA          PLX
$84:908D 60          RTS

$84:908E A9 00 02    LDA #$0200             ;\
$84:9091 38          SEC                    ;|
$84:9092 ED 25 1C    SBC $1C25  [$7E:1C25]  ;|
$84:9095 4A          LSR A                  ;|
$84:9096 4A          LSR A                  ;} If (200h - [PLM draw tilemap index]) / 8 < [draw length]: return (not enough space for the new tilemap)
$84:9097 4A          LSR A                  ;|
$84:9098 C5 14       CMP $14    [$7E:0014]  ;|
$84:909A 30 F0       BMI $F0    [$908C]     ;/
$84:909C A9 00 80    LDA #$8000             ;\
$84:909F 85 1C       STA $1C    [$7E:001C]  ;} Set 32-byte increment mode flag
$84:90A1 20 DC 91    JSR $91DC  [$84:91DC]  ; Calculate PLM draw tilemap VRAM destination
$84:90A4 B5 D5       LDA $D5,x  [$7E:00D5]  ;\
$84:90A6 1A          INC A                  ;} VRAM write table entry 1 destination + [X] = [VRAM write table entry 0 destination + [X]] + 1
$84:90A7 95 DC       STA $DC,x  [$7E:00DC]  ;/
$84:90A9 8A          TXA                    ;\
$84:90AA 18          CLC                    ;|
$84:90AB 69 0E 00    ADC #$000E             ;} VRAM write table stack pointer += Eh
$84:90AE 8D 30 03    STA $0330  [$7E:0330]  ;/
$84:90B1 A5 12       LDA $12    [$7E:0012]  ;\
$84:90B3 0A          ASL A                  ;|
$84:90B4 85 12       STA $12    [$7E:0012]  ;|
$84:90B6 C8          INY                    ;|
$84:90B7 C8          INY                    ;} Draw data address = [Y] + 2 + [number of blocks skipped] * 2
$84:90B8 98          TYA                    ;|
$84:90B9 18          CLC                    ;|
$84:90BA 65 12       ADC $12    [$7E:0012]  ;|
$84:90BC 85 03       STA $03    [$7E:0003]  ;/
$84:90BE A0 00 00    LDY #$0000             ; PLM draw tilemap index = 0

; LOOP_VERTICAL_BLOCK
$84:90C1 B2 03       LDA ($03)  [$84:A9FD]  ;\
$84:90C3 85 1E       STA $1E    [$7E:001E]  ;} Block = [[draw data address]]
$84:90C5 29 FF 03    AND #$03FF             ;\
$84:90C8 0A          ASL A                  ;|
$84:90C9 0A          ASL A                  ;} Tile table index = ([block] & 3FFh) * 8
$84:90CA 0A          ASL A                  ;|
$84:90CB AA          TAX                    ;/
$84:90CC A5 1E       LDA $1E    [$7E:001E]  ;\
$84:90CE 29 00 0C    AND #$0C00             ;} If [block] & C00h != 0: go to BRANCH_VERTICAL_COPY_BLOCK_WITH_FLIP
$84:90D1 D0 1D       BNE $1D    [$90F0]     ;/
$84:90D3 BF 00 A0 7E LDA $7EA000,x[$7E:A410];\
$84:90D7 97 00       STA [$00],y[$7E:C6C8]  ;} Copy top-left VRAM tile of the block
$84:90D9 BF 02 A0 7E LDA $7EA002,x[$7E:A412];\
$84:90DD 97 06       STA [$06],y[$7E:C6D8]  ;} Copy top-right VRAM tile of the block
$84:90DF C8          INY                    ;\
$84:90E0 C8          INY                    ;|
$84:90E1 BF 04 A0 7E LDA $7EA004,x[$7E:A414];} Copy bottom-left VRAM tile of the block
$84:90E5 97 00       STA [$00],y[$7E:C6CA]  ;/
$84:90E7 BF 06 A0 7E LDA $7EA006,x[$7E:A416];\
$84:90EB 97 06       STA [$06],y[$7E:C6DA]  ;} Copy bottom-right VRAM tile of the block
$84:90ED 4C 70 91    JMP $9170  [$84:9170]  ; Go to BRANCH_VERTICAL_NEXT_BLOCK

; BRANCH_VERTICAL_COPY_BLOCK_WITH_FLIP
$84:90F0 C9 00 04    CMP #$0400             ;\
$84:90F3 D0 28       BNE $28    [$911D]     ;} If [block] & C00h != 400h: go to BRANCH_VERTICAL_COPY_BLOCK_WITH_VERTICAL_FLIP
$84:90F5 BF 02 A0 7E LDA $7EA002,x[$7E:A06A];\
$84:90F9 49 00 40    EOR #$4000             ;|
$84:90FC 97 00       STA [$00],y[$7E:C6C8]  ;|
$84:90FE BF 00 A0 7E LDA $7EA000,x[$7E:A068];|
$84:9102 49 00 40    EOR #$4000             ;|
$84:9105 97 06       STA [$06],y[$7E:C6D8]  ;|
$84:9107 C8          INY                    ;|
$84:9108 C8          INY                    ;} Copy the four VRAM tiles of the block, with horizontal flip
$84:9109 BF 06 A0 7E LDA $7EA006,x[$7E:A06E];|
$84:910D 49 00 40    EOR #$4000             ;|
$84:9110 97 00       STA [$00],y[$7E:C6CA]  ;|
$84:9112 BF 04 A0 7E LDA $7EA004,x[$7E:A06C];|
$84:9116 49 00 40    EOR #$4000             ;|
$84:9119 97 06       STA [$06],y[$7E:C6DA]  ;/
$84:911B 80 53       BRA $53    [$9170]     ; Go to BRANCH_VERTICAL_NEXT_BLOCK

; BRANCH_VERTICAL_COPY_BLOCK_WITH_VERTICAL_FLIP
$84:911D C9 00 08    CMP #$0800             ;\
$84:9120 D0 28       BNE $28    [$914A]     ;} If [block] & C00h != 800h: go to BRANCH_VERTICAL_COPY_BLOCK_WITH_BOTH_FLIPS
$84:9122 BF 04 A0 7E LDA $7EA004,x[$7E:A514];\
$84:9126 49 00 80    EOR #$8000             ;|
$84:9129 97 00       STA [$00],y[$7E:C6D0]  ;|
$84:912B BF 06 A0 7E LDA $7EA006,x[$7E:A516];|
$84:912F 49 00 80    EOR #$8000             ;|
$84:9132 97 06       STA [$06],y[$7E:C6E0]  ;|
$84:9134 C8          INY                    ;|
$84:9135 C8          INY                    ;} Copy the four VRAM tiles of the block, with vertical flip
$84:9136 BF 00 A0 7E LDA $7EA000,x[$7E:A510];|
$84:913A 49 00 80    EOR #$8000             ;|
$84:913D 97 00       STA [$00],y[$7E:C6D2]  ;|
$84:913F BF 02 A0 7E LDA $7EA002,x[$7E:A512];|
$84:9143 49 00 80    EOR #$8000             ;|
$84:9146 97 06       STA [$06],y[$7E:C6E2]  ;/
$84:9148 80 26       BRA $26    [$9170]     ; Go to BRANCH_VERTICAL_NEXT_BLOCK

; BRANCH_VERTICAL_COPY_BLOCK_WITH_BOTH_FLIPS
$84:914A BF 06 A0 7E LDA $7EA006,x[$7E:A16E];\
$84:914E 49 00 C0    EOR #$C000             ;|
$84:9151 97 00       STA [$00],y[$7E:C6D0]  ;|
$84:9153 BF 04 A0 7E LDA $7EA004,x[$7E:A16C];|
$84:9157 49 00 C0    EOR #$C000             ;|
$84:915A 97 06       STA [$06],y[$7E:C6E0]  ;|
$84:915C C8          INY                    ;|
$84:915D C8          INY                    ;} Copy the four VRAM tiles of the block, with horizontal and vertical flip
$84:915E BF 02 A0 7E LDA $7EA002,x[$7E:A16A];|
$84:9162 49 00 C0    EOR #$C000             ;|
$84:9165 97 00       STA [$00],y[$7E:C6D2]  ;|
$84:9167 BF 00 A0 7E LDA $7EA000,x[$7E:A168];|
$84:916B 49 00 C0    EOR #$C000             ;|
$84:916E 97 06       STA [$06],y[$7E:C6E2]  ;/

; BRANCH_VERTICAL_NEXT_BLOCK
$84:9170 C8          INY                    ;\
$84:9171 C8          INY                    ;} Next PLM draw tilemap index
$84:9172 E6 03       INC $03    [$7E:0003]  ;\
$84:9174 E6 03       INC $03    [$7E:0003]  ;} Draw data address += 2
$84:9176 AD 25 1C    LDA $1C25  [$7E:1C25]  ;\
$84:9179 18          CLC                    ;|
$84:917A 69 08 00    ADC #$0008             ;} PLM draw tilemap index += 8
$84:917D 8D 25 1C    STA $1C25  [$7E:1C25]  ;/
$84:9180 C9 00 02    CMP #$0200             ;\
$84:9183 10 07       BPL $07    [$918C]     ;} If [PLM draw tilemap index] >= 200h: return (impossible)
$84:9185 C6 14       DEC $14    [$7E:0014]  ; Decrement draw length
$84:9187 F0 05       BEQ $05    [$918E]     ; If [draw length] = 0: go to BRANCH_NEXT_DRAW_ENTRY
$84:9189 4C C1 90    JMP $90C1  [$84:90C1]  ; Go to LOOP_VERTICAL_BLOCK

$84:918C FA          PLX
$84:918D 60          RTS
}

; BRANCH_NEXT_DRAW_ENTRY
$84:918E FA          PLX
$84:918F A4 03       LDY $03    [$7E:0003]  ; Y = [draw data address]
$84:9191 A5 16       LDA $16    [$7E:0016]  ;\
$84:9193 30 05       BMI $05    [$919A]     ;} If [number of blocks truncated] >= 0:
$84:9195 0A          ASL A                  ;\
$84:9196 18          CLC                    ;|
$84:9197 65 03       ADC $03    [$7E:0003]  ;} Y += [number of blocks truncated] * 2
$84:9199 A8          TAY                    ;/

$84:919A B9 00 00    LDA $0000,y[$84:AA05]  ;\
$84:919D D0 01       BNE $01    [$91A0]     ;} If [[Y]] = 0: return
$84:919F 60          RTS

$84:91A0 29 FF 00    AND #$00FF             ;\
$84:91A3 89 80 00    BIT #$0080             ;|
$84:91A6 D0 08       BNE $08    [$91B0]     ;|
$84:91A8 18          CLC                    ;|
$84:91A9 6D 29 1C    ADC $1C29  [$7E:1C29]  ;|
$84:91AC 85 1E       STA $1E    [$7E:001E]  ;|
$84:91AE 80 09       BRA $09    [$91B9]     ;} PLM draw X block = [PLM X block] + ±[[Y]]
                                            ;|
$84:91B0 09 00 FF    ORA #$FF00             ;|
$84:91B3 18          CLC                    ;|
$84:91B4 6D 29 1C    ADC $1C29  [$7E:1C29]  ;|
$84:91B7 85 1E       STA $1E    [$7E:001E]  ;/

$84:91B9 C8          INY                    ; Increment Y
$84:91BA B9 00 00    LDA $0000,y[$84:9F2A]  ;\
$84:91BD 29 FF 00    AND #$00FF             ;|
$84:91C0 89 80 00    BIT #$0080             ;|
$84:91C3 D0 0A       BNE $0A    [$91CF]     ;|
$84:91C5 18          CLC                    ;|
$84:91C6 6D 2B 1C    ADC $1C2B  [$7E:1C2B]  ;|
$84:91C9 85 20       STA $20    [$7E:0020]  ;|
$84:91CB C8          INY                    ;} PLM draw Y block = [PLM Y block] + ±[[Y]]
$84:91CC 4C C5 8D    JMP $8DC5  [$84:8DC5]  ;|
                                            ;|
$84:91CF 09 00 FF    ORA #$FF00             ;|
$84:91D2 18          CLC                    ;|
$84:91D3 6D 2B 1C    ADC $1C2B  [$7E:1C2B]  ;|
$84:91D6 85 20       STA $20    [$7E:0020]  ;/
$84:91D8 C8          INY                    ; Increment Y
$84:91D9 4C C5 8D    JMP $8DC5  [$84:8DC5]  ; Go to LOOP_DRAW_ENTRY
}


;;; $91DC: Calculate PLM draw tilemap VRAM destination ;;;
{
$84:91DC A5 1A       LDA $1A    [$7E:001A]  ;\
$84:91DE 29 0F 00    AND #$000F             ;|
$84:91E1 09 00 40    ORA #$4000             ;} Calculate ([PLM draw Y block] & Fh) * 40h
$84:91E4 8D 02 42    STA $4202  [$7E:4202]  ;/
$84:91E7 A5 18       LDA $18    [$7E:0018]  ;\
$84:91E9 29 1F 00    AND #$001F             ;|
$84:91EC C9 10 00    CMP #$0010             ;} If [PLM draw X block] & 1Fh < 10h:
$84:91EF B0 18       BCS $18    [$9209]     ;/
$84:91F1 0A          ASL A                  ;\
$84:91F2 18          CLC                    ;|
$84:91F3 65 09       ADC $09    [$7E:0009]  ;} PLM draw tilemap VRAM destination = ([PLM draw X block] & 1Fh) * 2 + VRAM map 1st screen base address + ([PLM draw Y block] & Fh) * 40h
$84:91F5 6D 16 42    ADC $4216  [$7E:4216]  ;|
$84:91F8 48          PHA                    ;/
$84:91F9 AD 1D 09    LDA $091D  [$7E:091D]  ;\
$84:91FC 29 00 01    AND #$0100             ;} If [BG1 X scroll offset] & 100h != 0:
$84:91FF F0 1E       BEQ $1E    [$921F]     ;/
$84:9201 68          PLA                    ;\
$84:9202 18          CLC                    ;|
$84:9203 69 00 04    ADC #$0400             ;} PLM draw tilemap VRAM destination = ([PLM draw X block] & 1Fh) * 2 + VRAM map 2nd screen base address + ([PLM draw Y block] & Fh) * 40h
$84:9206 48          PHA                    ;/
$84:9207 80 16       BRA $16    [$921F]

$84:9209 0A          ASL A                  ;\ Else ([PLM draw X block] & 1Fh >= 10h):
$84:920A 18          CLC                    ;|
$84:920B 65 0C       ADC $0C    [$7E:000C]  ;} PLM draw tilemap VRAM destination = ([PLM draw X block] & 1Fh) * 2 - 20h + VRAM map 2nd screen base address + ([PLM draw Y block] & Fh) * 40h
$84:920D 6D 16 42    ADC $4216  [$7E:4216]  ;|
$84:9210 48          PHA                    ;/
$84:9211 AD 1D 09    LDA $091D  [$7E:091D]  ;\
$84:9214 29 00 01    AND #$0100             ;} If [BG1 X scroll offset] & 100h != 0:
$84:9217 F0 06       BEQ $06    [$921F]     ;/
$84:9219 68          PLA                    ;\
$84:921A 38          SEC                    ;|
$84:921B E9 00 04    SBC #$0400             ;} PLM draw tilemap VRAM destination = ([PLM draw X block] & 1Fh) * 2 - 20h + VRAM map 1st screen base address + ([PLM draw Y block] & Fh) * 40h
$84:921E 48          PHA                    ;/

$84:921F 68          PLA
}


;;; $9220: Partially set up VRAM write table entries for single-screen PLM draw tilemap ;;;
{
;; Parameter:
;;     A: PLM draw tilemap VRAM destination
;;     X: VRAM write table stack pointer
$84:9220 05 1C       ORA $1C    [$7E:001C]  ;\
$84:9222 95 D5       STA $D5,x  [$7E:00D5]  ;} VRAM write table entry 0 destination + [X] = [A] | [32-byte increment mode flag]
$84:9224 A5 14       LDA $14    [$7E:0014]  ;\
$84:9226 0A          ASL A                  ;|
$84:9227 0A          ASL A                  ;} VRAM write table entry 0 size = [draw length] * 4
$84:9228 95 D0       STA $D0,x  [$7E:00D0]  ;/
$84:922A 95 D7       STA $D7,x  [$7E:00D7]  ; VRAM write table entry 1 size + [X] = [VRAM write table entry 0 size + [X]]
$84:922C A9 C8 C6    LDA #$C6C8             ;\
$84:922F 18          CLC                    ;|
$84:9230 6D 25 1C    ADC $1C25  [$7E:1C25]  ;} PLM draw tilemap top halves source address = VRAM write table entry 0 source address + [X] = PLM draw tilemap + [PLM draw tilemap index]
$84:9233 95 D2       STA $D2,x  [$7E:00D2]  ;|
$84:9235 85 00       STA $00    [$7E:0000]  ;/
$84:9237 18          CLC                    ;\
$84:9238 75 D0       ADC $D0,x  [$7E:00D0]  ;|
$84:923A 95 D9       STA $D9,x  [$7E:00D9]  ;} PLM draw tilemap bottom halves source address = VRAM write table entry 1 source address + [X] = [VRAM write table entry 0 source address + [X]] + [VRAM write table entry 0 size + [X]]
$84:923C 85 06       STA $06    [$7E:0006]  ;/
$84:923E E2 20       SEP #$20
$84:9240 A9 7E       LDA #$7E               ;\
$84:9242 95 D4       STA $D4,x  [$7E:00D4]  ;} VRAM write table entry 0 source bank = $7E
$84:9244 95 DB       STA $DB,x  [$7E:00DB]  ; VRAM write table entry 1 source bank = $7E
$84:9246 85 02       STA $02    [$7E:0002]  ; PLM draw tilemap top halves source bank = $7E
$84:9248 85 08       STA $08    [$7E:0008]  ; PLM draw tilemap bottom halves source bank = $7E
$84:924A C2 20       REP #$20
$84:924C 60          RTS
}
}


;;; $924D: Draw instructions ;;;
{
; Used by instruction list $D0EC: PLM $D0F2
$84:924D             dw 0001, 817E
                        0000

; Used by instruction list $BB19: PLM $BB30 (Crateria mainstreet escape)
$84:9253             dw 0002, 00FF, 00FF
                        0000

; Used by instruction list $B9A2: PLM $B9C1 (shot/bombed/grappled reaction, shootable, BTS 4Fh. Critters escape block)
$84:925B             dw 8003, 8053, 8053, 8053
                        0000

; Used by instruction list $B9A2: PLM $B9C1 (shot/bombed/grappled reaction, shootable, BTS 4Fh. Critters escape block)
$84:9265             dw 8003, 8054, 8054, 8054
                        0000

; Used by instruction list $B9A2: PLM $B9C1 (shot/bombed/grappled reaction, shootable, BTS 4Fh. Critters escape block)
$84:926F             dw 8003, 8055, 8055, 8055
                        0000

; Used by instruction list $B9A2: PLM $B9C1 (shot/bombed/grappled reaction, shootable, BTS 4Fh. Critters escape block)
$84:9279             dw 8003, 80FF, 80FF, 80FF
                        0000

; Used by instruction list $B919: PLM $B964 (old Tourian escape shaft escape)
$84:9283             dx 8003, 00FF, 00FF, 00FF
                        01, 00
                        8003, 00FF, 00FF, 00FF
                        0000

; Used by instruction list $AAE5: PLM $B773 (crumble access to Tourian elevator)
$84:9297             dw 0004, 00FF, 00FF, 00FF, 00FF
                        0000

; Used by instruction list $AAE5: PLM $B773 (crumble access to Tourian elevator)
$84:92A3             dw 0004, 0053, 0053, 0053, 0053
                        0000

; Used by instruction list $AAE5: PLM $B773 (crumble access to Tourian elevator)
$84:92AF             dw 0004, 0054, 0054, 0054, 0054
                        0000

; Used by instruction list $AAE5: PLM $B773 (crumble access to Tourian elevator)
$84:92BB             dw 0004, 0055, 0055, 0055, 0055
                        0000

; Used by instruction list $AB0C: PLM $B777 (clear access to Tourian elevator)
$84:92C7             dx 0004, 00FF, 00FF, 00FF, 00FF
                        00, 01
                        0004, 00FF, 00FF, 00FF, 00FF
                        00, 02
                        0004, 00FF, 00FF, 00FF, 00FF
                        00, 03
                        0004, 00FF, 00FF, 00FF, 00FF
                        00, 04
                        0004, 00FF, 00FF, 00FF, 00FF
                        00, 05
                        0004, 00FF, 00FF, 00FF, 00FF
                        0000

; Used by instruction list $AB67: PLM $B797 (clear Botwoon wall)
$84:930F             dw 8009, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF
                        0000

; Unused
$84:9325             dw 8009, 8053, 8053, 8053, 8053, 8053, 8053, 8053, 8053, 8053
                        0000

; Unused
$84:933B             dw 8009, 8054, 8054, 8054, 8054, 8054, 8054, 8054, 8054, 8054
                        0000

; Unused
$84:9351             dw 8009, 0055, 0055, 0055, 0055, 0055, 0055, 0055, 0055, 0055
                        0000

; Used by instruction lists:
;     $AB6D: PLM $B7A3 (crumble Kraid ceiling block into background 1)
;     $AB7F: PLM $B7AB (crumble Kraid ceiling block into background 2)
;     $AB91: PLM $B7B3 (crumble Kraid ceiling block into background 3)
;     $ABA9: PLM $B7BF (crumble Kraid spike blocks)
;     $B8F0: PLM $B8F9 (Maridia elevatube)
$84:9367             dw 0001, 8180
                        0000

; Used by instruction lists:
;     $AB6D: PLM $B7A3 (crumble Kraid ceiling block into background 1)
;     $AB7F: PLM $B7AB (crumble Kraid ceiling block into background 2)
;     $AB91: PLM $B7B3 (crumble Kraid ceiling block into background 3)
;     $ABA9: PLM $B7BF (crumble Kraid spike blocks)
$84:936D             dw 0001, 8181
                        0000

; Used by instruction lists:
;     $AB6D: PLM $B7A3 (crumble Kraid ceiling block into background 1)
;     $AB7F: PLM $B7AB (crumble Kraid ceiling block into background 2)
;     $AB91: PLM $B7B3 (crumble Kraid ceiling block into background 3)
;     $ABA9: PLM $B7BF (crumble Kraid spike blocks)
$84:9373             dw 0001, 0182
                        0000

; Used by instruction list $AB79: Unused. PLM $B79F (set Kraid ceiling block to background 1)
$84:9379             dw 0001, 013C
                        0000

; Used by instruction list $AB8B: PLM $B7A7 (set Kraid ceiling block to background 2)
$84:937F             dw 0001, 0131
                        0000

; Used by instruction list $AB9D: PLM $B7AF (set Kraid ceiling block to background 3)
$84:9385             dw 0001, 0130
                        0000

; Unused
$84:938B             dw 0001, 011C
                        0000

; Used by instruction list $ABA9: PLM $B7BF (crumble Kraid spike blocks)
$84:9391             dw 0001, 0111
                        0000

; Used by instruction list $ABA9: PLM $B7BF (crumble Kraid spike blocks)
$84:9397             dw 0001, 0110
                        0000

; Used by instruction list $ABA3: PLM $B7B7 (clear Kraid ceiling)
$84:939D             dw 000F, 013C, 0131, 0130, 0131, 0130, 0131, 0130, 0131, 0130, 0131, 0130, 0131, 0130, 0131, 0130
                        0000

; Used by instruction list $ABDD: PLM $B7BB (clear Kraid spike blocks)
$84:93BF             dw 0016, 0111, 0110, 0111, 0110, 0111, 0110, 0111, 0110, 0111, 0110, 0111, 0110, 0111, 0110, 0111, 0110, 0111, 0110, 0111, 0110, 0111, 0110
                        0000

; Used by instruction list $B77B: PLM $B781 (draw Phantoon's door during boss fight)
$84:93EF             dx 8004, 95C1, 95E1, 9DE1, 9DC1
                        01, 00
                        8004, C5C0, D5E0, DDE0, DDC0
                        0000

; Used by instruction list $B785: PLM $B78B (restore Phantoon's door after boss fight)
$84:9407             dw 8004, 9440, 9460, 9C60, 9C40
                        0000

; Used by instruction list $AB21: PLM $B793 (clear Spore Spawn ceiling)
$84:9413             dx 0002, 00FF, 00FF
                        00, 01
                        0002, 00FF, 00FF
                        0000

; Used by instruction list $AB12: PLM $B78F (crumble Spore Spawn ceiling)
$84:9423             dx 0002, 0053, 0053
                        00, 01
                        0002, 0053, 0053
                        0000

; Used by instruction list $AB12: PLM $B78F (crumble Spore Spawn ceiling)
$84:9433             dx 0002, 0054, 0054
                        00, 01
                        0002, 0054, 0054
                        0000

; Used by instruction list $AB12: PLM $B78F (crumble Spore Spawn ceiling)
$84:9443             dx 0002, 0055, 0055
                        00, 01
                        0002, 0055, 0055
                        0000

; Used by instruction list $ABE3: Unused. PLM $B65F
$84:9453             dx 8002, 00FF, 12FB
                        00, FE
                        8002, 1AFB, 00FF
                        0000

; Used by instruction list $ABE9: Unused. PLM $B663
$84:9463             dx 8002, 80FF, 82FB
                        00, FE
                        8002, 8AFB, 80FF
                        0000

; Used by instruction lists:
;     $ABEF: Unused. PLM $B667
;     $BB3A: Unused
;     $BB44: door $C8CA / PLM $C8D0 (gate that closes during escape in room after Mother Brain)
$84:9473             dw 8004, 80FF, 80FF, 80FF, 80FF
                        0000

; Used by instruction lists:
;     $BB3A: Unused
;     $BB44: door $C8CA / PLM $C8D0 (gate that closes during escape in room after Mother Brain)
$84:947F             dw 8004, 830F, 80FF, 80FF, 830F
                        0000

; Used by instruction lists:
;     $ABEF: Unused. PLM $B667
;     $BB34: door $C8CA (gate that closes during escape in room after Mother Brain)
;     $BB44: door $C8CA / PLM $C8D0 (gate that closes during escape in room after Mother Brain)
$84:948B             dw 8004, 830F, 8AE8, 82E8, 830F
                        0000

; Used by instruction list $ABF9: Unused. PLM $B66B
$84:9497             dw 0001, 00FF
                        0000

; Used by instruction list $ABFF: Unused. PLM $B66F
$84:949D             dw 0001, 80FF
                        0000

; Used by instruction list $AC05: PLM $B673 (fill Mother Brain's wall)
$84:94A3             dx 8002, 8340, 830F
                        00, FF
                        8001, 8B0F
                        0000

; Used by instruction list $AC0B: PLM $B677 (Mother Brain's room escape door)
$84:94B1             dx 8004, 9222, D1AF, D1D0, D220
                        01, 00
                        8004, 0223, 01EB, 01D0, 0221
                        0000

; Unused
$84:94C9             dw 000D, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044
                        0000

; Unused
$84:94E7             dw 000D, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044
                        0000

; Used by instruction list $AC11: PLM $B67B (Mother Brain's background row 2)
$84:9505             dw 000D, 1241, 1242, 12FC, 12FC, 12FC, 1243, 1244, 12FC, 1245, 1642, 1241, 1241, 1246
                        0000

; Used by instruction list $AC17: PLM $B67F (Mother Brain's background row 3)
$84:9523             dw 000D, 09EF, 01B2, 01E5, 01E5, 01E6, 01E5, 01E5, 01E5, 01E5, 05B2, 09EF, 09EF, 01B2
                        0000

; Used by instruction list $AC1D: PLM $B683 (Mother Brain's background row 4)
$84:9541             dw 000D, 01B1, 01D2, 01C6, 01C7, 00FF, 0206, 0207, 00FF, 01A6, 09CA, 060C, 05B1, 0A09
                        0000

; Used by instruction list $AC23: PLM $B687 (Mother Brain's background row 5)
$84:955F             dw 000D, 01D1, 01F2, 01A4, 01E7, 01A4, 0226, 0227, 01A5, 01A4, 020D, 0E09, 01B1, 01AB
                        0000

; Used by instruction list $AC29: PLM $B68B (Mother Brain's background row 6)
$84:957D             dw 000D, 01B1, 0212, 01C4, 01C9, 01C4, 0206, 0207, 01C5, 01C4, 0628, 01AC, 01EC, 01EC
                        0000

; Used by instruction list $AC2F: PLM $B68F (Mother Brain's background row 7)
$84:959B             dw 000D, 01B1, 0A0C, 05CA, 0DC7, 01AA, 01A8, 01A8, 01A8, 01A8, 0628, 01AB, 01CD, 01CD
                        0000

; Used by instruction list $AC35: PLM $B693 (Mother Brain's background row 8)
$84:95B9             dw 000D, 01D1, 01D0, 05EA, 00FF, 00FF, 0206, 0207, 00FF, 01A7, 0A0D, 0609, 01EB, 01D0
                        0000

; Used by instruction list $AC3B: PLM $B697 (Mother Brain's background row 9)
$84:95D7             dw 000D, 01EB, 01EB, 05EA, 00FF, 00FF, 0206, 0207, 00FF, 01A6, 00FF, 0A2C, 0609, 01AE
                        0000

; Used by instruction list $AC41: PLM $B69B (Mother Brain's background row Ah)
$84:95F5             dw 000D, 01EC, 01AF, 05EA, 05C7, 05C6, 0206, 0207, 01A8, 01A6, 01A8, 01A8, 05D2, 01AE
                        0000

; Used by instruction list $AC47: PLM $B69F (Mother Brain's background row Bh)
$84:9613             dw 000D, 01AC, 01AF, 01B2, 05E7, 01E5, 0226, 0227, 01E5, 01A6, 01E6, 01E5, 05B2, 01CD
                        0000

; Used by instruction list $AC4D: PLM $B6A3 (Mother Brain's background row Ch)
$84:9631             dw 000D, 060C, 01EF, 01B2, 01E5, 01E6, 01E5, 01E5, 01E6, 01E5, 01E5, 01E5, 05B2, 01EF
                        0000

; Used by instruction list $AC53: PLM $B6A7 (Mother Brain's background row Dh)
$84:964F             dw 000D, 1248, 1249, 124A, 124B, 1339, 124C, 124D, 1339, 124E, 1339, 1339, 124F, 1249
                        0000

; Used by instruction list $AC59: Unused. PLM $B6AB
$84:966D             dw 000D, 8319, 8319, 8319, 8319, 8319, 8319, 8319, 8319, 8319, 8319, 8319, 8319, 8319
                        0000

; Used by instruction list $AC5F: Unused. PLM $B6AF
$84:968B             dw 000D, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044, 8044
                        0000

; Used by instruction list $AC65: PLM $B6B3 (clear ceiling block in Mother Brain's room)
$84:96A9             dw 8002, 12FC, 00FF
                        0000

; Used by instruction list $AC6B: PLM $B6B7 (clear ceiling tube in Mother Brain's room)
$84:96B1             dw 8005, 12FC, 00FF, 00FF, 00FF, 00FF
                        0000

; Used by instruction list $AC71: PLM $B6BB (clear Mother Brain's bottom-middle-side tube)
$84:96BF             dw 8004, 00FF, 00FF, 00FF, 1339
                        0000

; Used by instruction list $AC77: PLM $B6BF (clear Mother Brain's bottom-middle tubes)
$84:96CB             dx 8007, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 1339
                        01, 00
                        8007, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 1339
                        0000

; Used by instruction list $AC7D: PLM $B6C3 (clear Mother Brain's bottom-left tube)
$84:96EF             dx 8005, 00FF, 00FF, 00FF, 00FF, 1339
                        01, 00
                        0001, 00FF
                        0000

; Used by instruction list $AC83: PLM $B6C7 (clear Mother Brain's bottom-right tube)
$84:9703             dx 8005, 00FF, 00FF, 00FF, 00FF, 1339
                        FF, 00
                        0001, 00FF
                        0000

; Used by instruction list $D202: PLM $D6DE (Mother Brain's glass)
$84:9717             dw 0001, C6C0
                        0000

; Used by instruction list $D202: PLM $D6DE (Mother Brain's glass)
$84:971D             dx 8004, C2C7, D2C9, DAC9, 5AC7
                        FF, 01
                        8002, D2C8, DAC8
                        0000

; Used by instruction list $D202: PLM $D6DE (Mother Brain's glass)
$84:9731             dx 8004, C2C7, D2CB, DACB, 5AC7
                        FF, 01
                        8002, D2CA, DACA
                        0000

; Used by instruction list $D202: PLM $D6DE (Mother Brain's glass)
$84:9745             dw 8003, C2C7, 02CC, 0ACC
                        0000

; Used by instruction list $D202: PLM $D6DE (Mother Brain's glass)
$84:974F             dx 0001, C2C7
                        FD, 00
                        8004, 82CD, 86C9, 8EC9, 8ACD
                        FE, 01
                        8002, 86C8, 8EC8
                        0000

; Used by instruction list $D202: PLM $D6DE (Mother Brain's glass)
$84:9769             dx 0001, C2C7
                        FD, 01
                        8003, 86CB, 8ECB, 8ACD
                        FE, 01
                        8002, 86CA, 8ECA
                        0000

; Used by instruction list $D202: PLM $D6DE (Mother Brain's glass)
$84:9781             dx 0001, C2C7
                        FD, 01
                        8002, 06CC, 0ECC
                        0000

; Used by instruction list $D202: PLM $D6DE (Mother Brain's glass)
$84:978F             dx 8004, C2CE, 02CF, 0ACF, 5ACE
                        FD, 00
                        8004, 86CE, 06CF, 0ECF, 8ECE
                        FE, 01
                        8002, D6D0, DED0
                        FF, 01
                        8002, D2D0, DAD0
                        0000

; Used by instruction list $D202: PLM $D6DE (Mother Brain's glass)
$84:97B7             dx 8004, C2CE, 00FF, 00FF, 5ACE
                        FD, 00
                        8004, 86CE, 00FF, 00FF, 8ECE
                        FE, 00
                        8004, 52C2, D2C3, DAC3, D2C4
                        FF, 00
                        8004, 56C2, D6C3, DEC3, D6C4
                        0000

; Used by instruction lists:
;     $D202: PLM $D6DE (Mother Brain's glass)
;     $D2F3: PLM $D6E6 (unused. Mother Brain's glass, no glass state)
$84:97E7             dx 8004, 00FF, 00FF, 00FF, 00FF
                        FD, 00
                        8004, 00FF, 00FF, 00FF, 00FF
                        FE, 00
                        8004, 02D2, 02D3, 0AD3, 02D4
                        FF, 00
                        8004, 06D2, 06D3, 0ED3, 06D4
                        0000

; Used by instruction list $D2ED: PLM $D6E2 (unused. Mother Brain's glass, area boss dead)
$84:9817             dx 8004, 00FF, 00FF, 00FF, 00FF
                        FD, 00
                        8004, 00FF, 00FF, 00FF, 00FF
                        FE, 00
                        8004, 00FF, 00FF, 00FF, 00FF
                        FF, 00
                        8004, 00FF, 00FF, 00FF, 00FF
                        0000

; Unused
$84:9847             dx 8004, 00FF, 00FF, 00FF, 00FF
                        FF, 00
                        8004, 0172, 0173, 0173, 0172
                        FE, 00
                        8004, 0172, 0173, 0173, 0172
                        FD, 00
                        8004, 00FF, 00FF, 00FF, 00FF
                        0000

; Used by instruction list $D368: PLM $D6EA (Bomb Torizo's crumbling chozo)
$84:9877             dx 0002, 8065, 8066
                        FF, 00
                        0001, 8064
                        00, FF
                        0002, 8045, 8046
                        FF, 01
                        0003, 8047, 8048, 8049
                        0000

; Unused
$84:9897             dw 0001, 0001
                        0000

; Used by instruction list $D368: PLM $D6EA (Bomb Torizo's crumbling chozo)
$84:989D             dx 0002, 00FF, 00FF
                        FE, 00
                        0002, 00FF, 00FF
                        FE, 01
                        0004, 00FF, 00FF, 00FF, 00FF
                        FE, FE
                        0004, 00FF, 00FF, 00FF, 00FF
                        FE, FF
                        0004, 00FF, 00FF, 00FF, 00FF
                        0000

; Used by instruction list $D4D4: PLM $D70C (n00b tube)
$84:98D1             dw 0001, C540
                        0000

; Used by instruction list $D4D4: PLM $D70C (n00b tube)
$84:98D7             dw 0001, 8540
                        0000

; Used by instruction list $D4D4: PLM $D70C (n00b tube)
$84:98DD             dw 0001, 8141
                        0000

; Used by instruction list $D4D4: PLM $D70C (n00b tube)
$84:98E3             dx 000C, 8141, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 8541
                        00, 01
                        000C, 0322, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 0722
                        00, 02
                        000C, 0323, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 0723
                        00, 03
                        000C, 0B23, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 0F23
                        0000

; Used by instruction list $D4D4: PLM $D70C (n00b tube)
$84:9953             dx 0001, 0141
                        00, 04
                        000C, 0B22, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 0F22
                        00, 05
                        000C, 814E, 814F, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 854F, 854E
                        0000

; Used by instruction list $D4D4: PLM $D70C (n00b tube)
$84:9991             dx 000C, 8141, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 8541
                        00, 01
                        000C, 0322, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 0722
                        00, 02
                        000C, 0323, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 0723
                        0000

; Used by instruction list $D4D4: PLM $D70C (n00b tube)
$84:99E5             dx 0001, 0141
                        00, 03
                        000C, 0B23, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 0F23
                        00, 04
                        000C, 0B22, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 0F22
                        00, 05
                        000C, 814E, 814F, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 854F, 854E
                        0000

; Used by instruction list $AFE8: PLM $B76F (save station)
$84:9A3F             dx 0002, B859, 8C59
                        00, FF
                        0002, 005B, 045B
                        00, FE
                        0002, 005B, 045B
                        00, FD
                        0002, 005B, 045B
                        00, FC
                        0002, 005B, 045B
                        00, FB
                        0002, 8059, 8459
                        0000

; Used by instruction list $AFE8: PLM $B76F (save station)
$84:9A6F             dx 0002, 8859, 8C59
                        00, FF
                        0002, 005B, 045B
                        00, FE
                        0002, 005B, 045B
                        00, FD
                        0002, 005B, 045B
                        00, FC
                        0002, 005B, 045B
                        00, FB
                        0002, 8059, 8459
                        0000

; Used by instruction list $AFE8: PLM $B76F (save station)
$84:9A9F             dx 0002, 885A, 8C5A
                        00, FF
                        0002, 005C, 045C
                        00, FE
                        0002, 005C, 045C
                        00, FD
                        0002, 005C, 045C
                        00, FC
                        0002, 005C, 045C
                        00, FB
                        0002, 805A, 845A
                        0000

; Used by instruction list $B03E: Unused. PLM $B75B (draw 13 blank air tiles)
$84:9ACF             dw 000D, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF, 00FF
                        0000

; Used by instruction list $B044: Unused. PLM $B75F (draw 13 blank solid tiles)
$84:9AED             dw 000D, 80FF, 80FF, 80FF, 80FF, 80FF, 80FF, 80FF, 80FF, 80FF, 80FF, 80FF, 80FF, 80FF
                        0000

; Used by instruction list $D490: Unused. PLM $D708 (Lower Norfair 2x2 chozo shot block)
$84:9B0B             dx 0002, C64A, 524A
                        00, 01
                        0002, D66A, D26A
                        0000

; Used by instruction list $D490: Unused. PLM $D708 (Lower Norfair 2x2 chozo shot block)
$84:9B1B             dx 0002, 8053, 8053
                        00, 01
                        0002, 8053, 8053
                        0000

; Used by instruction list $D490: Unused. PLM $D708 (Lower Norfair 2x2 chozo shot block)
$84:9B2B             dx 0002, 8054, 8054
                        00, 01
                        0002, 8054, 8054
                        0000

; Used by instruction list $D490: Unused. PLM $D708 (Lower Norfair 2x2 chozo shot block)
$84:9B3B             dx 0002, 0055, 0055
                        00, 01
                        0002, 0055, 0055
                        0000

; Used by instruction list $D490: Unused. PLM $D708 (Lower Norfair 2x2 chozo shot block)
$84:9B4B             dx 0002, 00FF, 00FF
                        00, 01
                        0002, 00FF, 00FF
                        0000

; Used by instruction list $AFCA: PLM $B747 (clear Crocomire's bridge)
$84:9B5B             dw 000A, 0080, 0080, 0080, 0080, 0080, 0080, 0080, 0080, 0080, 0080
                        0000

; Used by instruction list $AFD0: PLM $B74B (crumble a block of Crocomire's bridge)
$84:9B73             dw 0001, 810B
                        0000

; Used by instruction list $AFD6: PLM $B74F (clear a block of Crocomire's bridge)
$84:9B79             dw 0001, 0080
                        0000

; Used by instruction list $AFDC: PLM $B753 (clear Crocomire invisible wall)
$84:9B7F             dx 8008, 0080, 0107, 0127, 0107, 0127, 0147, 0080, 0080
                        01, 00
                        8008, 0080, 0108, 0128, 0108, 0128, 0148, 0080, 0080
                        02, 00
                        8008, 0080, 0109, 0129, 0109, 0129, 0149, 0080, 0080
                        0000

; Used by instruction list $AFE2: PLM $B757 (create Crocomire invisible wall)
$84:9BBB             dx 8008, 8080, 8107, 8127, 8107, 8127, 8147, 8080, 8080
                        01, 00
                        8008, 8080, 8108, 8128, 8108, 8128, 8148, 8080, 8080
                        02, 00
                        8008, 8080, 8109, 8129, 8109, 8129, 8149, 8080, 8080
                        0000

; Used by instruction list $D81E: PLM $DB56 (eye door eye, facing left)
$84:9BF7             dw 8004, 84AA, 84CC, 8CCC, 8CAA
                        0000

; Used by instruction list $D81E: PLM $DB56 (eye door eye, facing left)
$84:9C03             dw 8002, 84CC, 8CCC
                        0000

; Used by instruction list $D81E: PLM $DB56 (eye door eye, facing left)
$84:9C0B             dw 8002, 84CB, 8CCB
                        0000

; Used by instruction list $D81E: PLM $DB56 (eye door eye, facing left)
$84:9C13             dw 8002, C4CA, DCCA
                        0000

; Used by instruction list $D81E: PLM $DB56 (eye door eye, facing left)
$84:9C1B             dw 8002, 84CD, 8CCD
                        0000

; Used by instruction list $D81E: PLM $DB56 (eye door eye, facing left)
$84:9C23             dw 8002, 84CA, 8CCA
                        0000

; Used by instruction list $D8E9: door $DB5A (eye door, facing left)
$84:9C2B             dw 0001, A4AA
                        0000

; Used by instruction list $D8E9: door $DB5A (eye door, facing left)
$84:9C31             dw 0001, A4AB
                        0000

; Used by instruction list $D8E9: door $DB5A (eye door, facing left)
$84:9C37             dw 0001, A4AC
                        0000

; Used by instruction list $D91F: PLM $DB60 (eye door bottom, facing left)
$84:9C3D             dw 0001, ACAA
                        0000

; Used by instruction list $D91F: PLM $DB60 (eye door bottom, facing left)
$84:9C43             dw 0001, ACAB
                        0000

; Used by instruction list $D91F: PLM $DB60 (eye door bottom, facing left)
$84:9C49             dw 0001, ACAC
                        0000

; Used by instruction list $D955: PLM $DB48 (eye door eye, facing right)
$84:9C4F             dw 8004, 80AA, 80CC, 88CC, 88AA
                        0000

; Used by instruction list $D955: PLM $DB48 (eye door eye, facing right)
$84:9C5B             dw 8002, 80CC, 88CC
                        0000

; Used by instruction list $D955: PLM $DB48 (eye door eye, facing right)
$84:9C63             dw 8002, 80CB, 88CB
                        0000

; Used by instruction list $D955: PLM $DB48 (eye door eye, facing right)
$84:9C6B             dw 8002, C0CA, D8CA
                        0000

; Used by instruction list $D955: PLM $DB48 (eye door eye, facing right)
$84:9C73             dw 8002, 80CD, 88CD
                        0000

; Used by instruction list $D955: PLM $DB48 (eye door eye, facing right)
$84:9C7B             dw 8002, 80CA, 88CA
                        0000

; Used by instruction list $DA20: door $DB4C (eye door, facing right)
$84:9C83             dw 0001, A0AA
                        0000

; Used by instruction list $DA20: door $DB4C (eye door, facing right)
$84:9C89             dw 0001, A0AB
                        0000

; Used by instruction list $DA20: door $DB4C (eye door, facing right)
$84:9C8F             dw 0001, A0AC
                        0000

; Used by instruction list $DA56: PLM $DB52 (eye door bottom, facing right)
$84:9C95             dw 0001, A8AA
                        0000

; Used by instruction list $DA56: PLM $DB52 (eye door bottom, facing right)
$84:9C9B             dw 0001, A8AB
                        0000

; Used by instruction list $DA56: PLM $DB52 (eye door bottom, facing right)
$84:9CA1             dw 0001, A8AC
                        0000

; Used by instruction list $D44E: Unused. PLM $D704 (alternate Lower Norfair chozo hand)
$84:9CA7             dw 0001, C0FF
                        0000

; Unused
$84:9CAD             dw 0001, 8053
                        0000

; Unused
$84:9CB3             dw 0001, 8054
                        0000

; Unused
$84:9CB9             dw 0001, 0055
                        0000

; Used by instruction list $D44E: Unused. PLM $D704 (alternate Lower Norfair chozo hand)
$84:9CBF             dw 0001, 00FF
                        0000

; Used by instruction list $D3CF: PLM $D6F8 (clear slope access for Wrecked Ship chozo)
$84:9CC5             dx 000E, 012B, 012B, 012B, 012B, 012B, 012B, 012B, 012B, 012B, 012B, 012B, 012B, 012B, 112B
                        00, 05
                        0009, 0111, 0111, 0111, 0111, 0111, 019B, 0129, 0129, 1129
                        05, 06
                        0002, 01BB, 0129
                        05, 07
                        0001, 01BB
                        05, 08
                        0001, 11BB
                        0000

; Used by instruction list $D3EC: PLM $D6FC (block slope access for Wrecked Ship chozo)
$84:9D0F             dx 000E, A12B, A12B, A12B, A12B, A12B, A12B, A12B, A12B, A12B, A12B, A12B, A12B, A12B, 812B
                        00, 05
                        0009, 8111, 8111, 8111, 8111, 8111, 819B, 8129, 8129, 8129
                        05, 06
                        0002, 81BB, 8129
                        05, 07
                        0001, 81BB
                        05, 08
                        0001, 81BB
                        0000

; Used by instruction list $D426: Unused. PLM $D700 (Wrecked Ship 3x4 chozo bomb block)
$84:9D59             dx 8004, C171, D171, D171, D171
                        FF, 00
                        8004, 8102, 8102, 8102, 8102
                        FE, 00
                        8004, 8560, 8560, 8560, 8560
                        0000

; Used by instruction list $D426: Unused. PLM $D700 (Wrecked Ship 3x4 chozo bomb block)
$84:9D7D             dx 8004, 8053, 8053, 8053, 8053
                        FF, 00
                        8004, 8053, 8053, 8053, 8053
                        FE, 00
                        8004, 8053, 8053, 8053, 8053
                        0000

; Used by instruction list $D426: Unused. PLM $D700 (Wrecked Ship 3x4 chozo bomb block)
$84:9DA1             dx 8004, 0054, 0054, 0054, 0054
                        FF, 00
                        8004, 0054, 0054, 0054, 0054
                        FE, 00
                        8004, 0054, 0054, 0054, 0054
                        0000

; Used by instruction list $D426: Unused. PLM $D700 (Wrecked Ship 3x4 chozo bomb block)
$84:9DC5             dx 8004, 8055, 8055, 8055, 8055
                        FF, 00
                        8004, 8055, 8055, 8055, 8055
                        FE, 00
                        8004, 8055, 8055, 8055, 8055
                        0000

; Used by instruction list $D426: Unused. PLM $D700 (Wrecked Ship 3x4 chozo bomb block)
$84:9DE9             dx 8004, 00FF, 00FF, 00FF, 00FF
                        FF, 00
                        8004, D0FF, D0FF, D0FF, 30FF
                        FE, 00
                        8004, D0FF, D0FF, D0FF, 30FF
                        0000

; Used by instruction list $ACB8: PLM $B6CB (inside reaction, special air, BTS Brinstar 80h. Floor plant)
$84:9E0D             dx 0002, 35A1, 85A0
                        FE, 00
                        0002, 81A0, 51A1
                        FE, FF
                        0004, 2180, 2181, 2581, 2580
                        0000

; Unused
$84:9E29             dx 0002, 05A1, 85A0
                        FE, 00
                        0002, 81A0, 01A1
                        FE, FF
                        0004, 2180, 2181, 2581, 2580
                        0000

; Used by instruction list $ACB8: PLM $B6CB (inside reaction, special air, BTS Brinstar 80h. Floor plant)
$84:9E45             dx 0002, 05A3, 85A2
                        FE, 00
                        0002, 81A2, 01A3
                        FE, FF
                        0004, 2182, 2183, 2583, 2582
                        0000

; Used by instruction list $ACB8: PLM $B6CB (inside reaction, special air, BTS Brinstar 80h. Floor plant)
$84:9E61             dx 0002, 05A5, 85A4
                        FE, 00
                        0002, 81A4, 01A5
                        FE, FF
                        0004, 2184, 2185, 2585, 2584
                        0000

; Used by instruction list $ACB8: PLM $B6CB (inside reaction, special air, BTS Brinstar 80h. Floor plant)
$84:9E7D             dx 0002, 05A7, 85A6
                        FE, 00
                        0002, 81A6, 01A7
                        FE, FF
                        0004, 2186, 2187, 2587, 2586
                        0000

; Used by instruction list $ACF8: PLM $B6CF (inside reaction, special air, BTS Brinstar 81h. Ceiling plant)
$84:9E99             dx 0002, 3DA1, 8DA0
                        FE, 00
                        0002, 89A0, 59A1
                        FE, 01
                        0004, 2980, 2981, 2D81, 2D80
                        0000

; Unused
$84:9EB5             dx 0002, 0DA1, 8DA0
                        FE, 00
                        0002, 89A0, 09A1
                        FE, 01
                        0004, 2980, 2981, 2D81, 2D80
                        0000

; Used by instruction list $ACF8: PLM $B6CF (inside reaction, special air, BTS Brinstar 81h. Ceiling plant)
$84:9ED1             dx 0002, 0DA3, 8DA2
                        FE, 00
                        0002, 89A2, 09A3
                        FE, 01
                        0004, 2982, 2983, 2D83, 2D82
                        0000

; Used by instruction list $ACF8: PLM $B6CF (inside reaction, special air, BTS Brinstar 81h. Ceiling plant)
$84:9EED             dx 0002, 0DA5, 8DA4
                        FE, 00
                        0002, 89A4, 09A5
                        FE, 01
                        0004, 2984, 2985, 2D85, 2D84
                        0000

; Used by instruction list $ACF8: PLM $B6CF (inside reaction, special air, BTS Brinstar 81h. Ceiling plant)
$84:9F09             dx 0002, 0DA7, 8DA6
                        FE, 00
                        0002, 89A6, 09A7
                        FE, 01
                        0004, 2986, 2987, 2D87, 2D86
                        0000

; Used by instruction list $AD62: PLM $B6D3 (map station)
$84:9F25             dx 0001, 810C
                        FF, 00
                        0001, 810B
                        0000

; Used by instruction list $AD62: PLM $B6D3 (map station)
$84:9F31             dx 0001, 812C
                        FF, 00
                        0001, 812B
                        0000

; Used by instruction list $AD62: PLM $B6D3 (map station)
$84:9F3D             dx 0001, 814C
                        FF, 00
                        0001, 814B
                        0000

; Used by instruction list $AD86: PLM $B6D7 (collision reaction, special, BTS 47h. Map station right access)
$84:9F49             dx 0001, 8128
                        FD, 00
                        0001, 8528
                        0000

; Used by instruction list $AD86: PLM $B6D7 (collision reaction, special, BTS 47h. Map station right access)
$84:9F55             dw 0001, 8129
                        0000

; Used by instruction list $ADA4: PLM $B6DB (collision reaction, special, BTS 48h. Map station left access)
$84:9F5B             dx 0001, 8528
                        03, 00
                        0001, 8128
                        0000

; Used by instruction list $ADA4: PLM $B6DB (collision reaction, special, BTS 48h. Map station left access)
$84:9F67             dw 0001, 8529
                        0000

; Used by instruction list $ADC2: PLM $B6DF (energy station)
$84:9F6D             dx 0001, 80C4
                        00, FF
                        0001, 10A4
                        0000

; Used by instruction list $ADC2: PLM $B6DF (energy station)
$84:9F79             dx 0001, 80C5
                        00, FF
                        0001, 10A5
                        0000

; Used by instruction list $ADC2: PLM $B6DF (energy station)
$84:9F85             dx 0001, 80C6
                        00, FF
                        0001, 10A6
                        0000

; Used by instruction list $AE4C: PLM $B6EB (missile station)
$84:9F91             dx 0001, 80C7
                        00, FF
                        0001, 10A7
                        0000

; Used by instruction list $AE4C: PLM $B6EB (missile station)
$84:9F9D             dx 0001, 80C8
                        00, FF
                        0001, 10A8
                        0000

; Used by instruction list $AE4C: PLM $B6EB (missile station)
$84:9FA9             dx 0001, 80C9
                        00, FF
                        0001, 10A9
                        0000

; Used by instruction lists:
;     $ADF1: PLM $B6E3 (collision reaction, special, BTS 49h. Energy station right access)
;     $AE7B: PLM $B6EF (collision reaction, special, BTS 4Bh. Missile station right access)
$84:9FB5             dw 0001, B4C3
                        0000

; Used by instruction lists:
;     $ADF1: PLM $B6E3 (collision reaction, special, BTS 49h. Energy station right access)
;     $AE7B: PLM $B6EF (collision reaction, special, BTS 4Bh. Missile station right access)
$84:9FBB             dw 0001, 84C1
                        0000

; Used by instruction lists:
;     $AE13: PLM $B6E7 (collision reaction, special, BTS 4Ah. Energy station left access)
;     $AE9D: PLM $B6F3 (collision reaction, special, BTS 4Ch. Missile station left access)
$84:9FC1             dw 0001, B0C3
                        0000

; Used by instruction lists:
;     $AE13: PLM $B6E7 (collision reaction, special, BTS 4Ah. Energy station left access)
;     $AE9D: PLM $B6F3 (collision reaction, special, BTS 4Ch. Missile station left access)
$84:9FC7             dw 0001, 80C1
                        0000

; Used by instruction list $DCDE: PLM $DF59 (Draygon cannon, with shield, facing right)
$84:9FCD             dx 0002, C514, 0513
                        00, 01
                        0002, D534, 0533
                        0000

; Used by instruction list $DCDE: PLM $DF59 (Draygon cannon, with shield, facing right)
$84:9FDD             dx 0002, C516, 0515
                        00, 01
                        0002, D536, 0535
                        0000

; Used by instruction list $DD27: PLM $DF5D (unused. Draygon cannon, with shield, facing down-right)
$84:9FED             dx 0002, C510, 550F
                        00, 01
                        0002, D530, D52F
                        0000

; Used by instruction list $DD27: PLM $DF5D (unused. Draygon cannon, with shield, facing down-right)
$84:9FFD             dx 0002, C512, 5511
                        00, 01
                        0002, D532, D531
                        0000

; Used by instruction list $DD70: PLM $DF61 (unused. Draygon cannon, with shield, facing up-right)
$84:A00D             dx 0002, CD30, 5D2F
                        00, 01
                        0002, DD10, DD0F
                        0000

; Used by instruction list $DD70: PLM $DF61 (unused. Draygon cannon, with shield, facing up-right)
$84:A01D             dx 0002, CD32, 5D31
                        00, 01
                        0002, DD12, DD11
                        0000

; Used by instruction list $DD11: PLM $DF65 (Draygon cannon, facing right)
$84:A02D             dx 0002, A580, 00FF
                        00, 01
                        0002, A5A0, 00FF
                        0000

; Used by instruction list $DD11: PLM $DF65 (Draygon cannon, facing right)
$84:A03D             dx 0002, A581, 00FF
                        00, 01
                        0002, A5A1, 00FF
                        0000

; Used by instruction list $DD11: PLM $DF65 (Draygon cannon, facing right)
$84:A04D             dx 0002, A582, 00FF
                        00, 01
                        0002, A5A2, 00FF
                        0000

; Used by instruction list $DD11: PLM $DF65 (Draygon cannon, facing right)
$84:A05D             dx 0002, A583, 00FF
                        00, 01
                        0002, A5A3, 00FF
                        0000

; Used by instruction list $DD5A: PLM $DF69 (unused. Draygon cannon, facing down-right)
$84:A06D             dx 0002, A5A5, A5A4
                        00, 01
                        0002, A5C5, 05C4
                        0000

; Used by instruction list $DD5A: PLM $DF69 (unused. Draygon cannon, facing down-right)
$84:A07D             dx 0002, A5A7, A5A6
                        00, 01
                        0002, A5C7, 05C6
                        0000

; Used by instruction list $DD5A: PLM $DF69 (unused. Draygon cannon, facing down-right)
$84:A08D             dx 0002, A5A9, A5A8
                        00, 01
                        0002, A5C9, 05C8
                        0000

; Used by instruction list $DD5A: PLM $DF69 (unused. Draygon cannon, facing down-right)
$84:A09D             dx 0002, A5AB, A5AA
                        00, 01
                        0002, A5CB, 05CA
                        0000

; Used by instruction list $DDA3: PLM $DF6D (unused. Draygon cannon, facing up-right)
$84:A0AD             dx 0002, ADC5, 0DC4
                        00, 01
                        0002, ADA5, ADA4
                        0000

; Used by instruction list $DDA3: PLM $DF6D (unused. Draygon cannon, facing up-right)
$84:A0BD             dx 0002, ADC7, 0DC6
                        00, 01
                        0002, ADA7, ADA6
                        0000

; Used by instruction list $DDA3: PLM $DF6D (unused. Draygon cannon, facing up-right)
$84:A0CD             dx 0002, ADC9, 0DC8
                        00, 01
                        0002, ADA9, ADA8
                        0000

; Used by instruction list $DDA3: PLM $DF6D (unused. Draygon cannon, facing up-right)
$84:A0DD             dx 0002, ADCB, 0DCA
                        00, 01
                        0002, ADAB, ADAA
                        0000

; Used by instruction list $DDB9: PLM $DF71 (Draygon cannon, with shield, facing left)
$84:A0ED             dx 0001, C114
                        FF, 00
                        0001, 0113
                        FF, 01
                        0002, 0133, D134
                        0000

; Used by instruction list $DDB9: PLM $DF71 (Draygon cannon, with shield, facing left)
$84:A101             dx 0001, C116
                        FF, 00
                        0001, 0115
                        FF, 01
                        0002, 0135, D136
                        0000

; Used by instruction list $DE02: PLM $DF75 (unused. Draygon cannon, with shield, facing down-left)
$84:A115             dx 0001, C110
                        FF, 00
                        0001, 510F
                        FF, 01
                        0002, D12F, D130
                        0000

; Used by instruction list $DE02: PLM $DF75 (unused. Draygon cannon, with shield, facing down-left)
$84:A129             dx 0001, C112
                        FF, 00
                        0001, 5111
                        FF, 01
                        0002, D131, D132
                        0000

; Used by instruction list $DE4B: PLM $DF79 (unused. Draygon cannon, with shield, facing up-left)
$84:A13D             dx 0001, C930
                        FF, 00
                        0001, 592F
                        FF, 01
                        0002, D90F, D910
                        0000

; Used by instruction list $DE4B: PLM $DF79 (unused. Draygon cannon, with shield, facing up-left)
$84:A151             dx 0001, C932
                        FF, 00
                        0001, 5931
                        FF, 01
                        0002, D911, D912
                        0000

; Used by instruction list $DDEC: PLM $DF7D (Dragon cannon, facing left)
$84:A165             dx 0001, A180
                        FF, 00
                        0001, 00FF
                        FF, 01
                        0002, 00FF, A1A0
                        0000

; Used by instruction list $DDEC: PLM $DF7D (Dragon cannon, facing left)
$84:A179             dx 0001, A181
                        FF, 00
                        0001, 00FF
                        FF, 01
                        0002, 00FF, A1A1
                        0000

; Used by instruction list $DDEC: PLM $DF7D (Dragon cannon, facing left)
$84:A18D             dx 0001, A182
                        FF, 00
                        0001, 00FF
                        FF, 01
                        0002, 00FF, A1A2
                        0000

; Used by instruction list $DDEC: PLM $DF7D (Dragon cannon, facing left)
$84:A1A1             dx 0001, A183
                        FF, 00
                        0001, 00FF
                        FF, 01
                        0002, 00FF, A1A3
                        0000

; Used by instruction list $DE35: PLM $DF81 (unused. Draygon cannon, facing down-left)
$84:A1B5             dx 0001, A1A5
                        FF, 00
                        0001, A1A4
                        FF, 01
                        0002, 01C4, A1C5
                        0000

; Used by instruction list $DE35: PLM $DF81 (unused. Draygon cannon, facing down-left)
$84:A1C9             dx 0001, A1A7
                        FF, 00
                        0001, A1A6
                        FF, 01
                        0002, 01C6, A1C7
                        0000

; Used by instruction list $DE35: PLM $DF81 (unused. Draygon cannon, facing down-left)
$84:A1DD             dx 0001, A1A9
                        FF, 00
                        0001, A1A8
                        FF, 01
                        0002, 01C8, A1C9
                        0000

; Used by instruction list $DE35: PLM $DF81 (unused. Draygon cannon, facing down-left)
$84:A1F1             dx 0001, A1AB
                        FF, 00
                        0001, A1AA
                        FF, 01
                        0002, 01CA, A1CB
                        0000

; Used by instruction list $DE7E: PLM $DF85 (unused. Draygon cannon, facing up-left)
$84:A205             dx 0001, A9C5
                        FF, 00
                        0001, 09C4
                        FF, 01
                        0002, A9A4, A9A5
                        0000

; Used by instruction list $DE7E: PLM $DF85 (unused. Draygon cannon, facing up-left)
$84:A219             dx 0001, A9C7
                        FF, 00
                        0001, 09C6
                        FF, 01
                        0002, A9A6, A9A7
                        0000

; Used by instruction list $DE7E: PLM $DF85 (unused. Draygon cannon, facing up-left)
$84:A22D             dx 0001, A9C9
                        FF, 00
                        0001, 09C8
                        FF, 01
                        0002, A9A8, A9A9
                        0000

; Used by instruction list $DE7E: PLM $DF85 (unused. Draygon cannon, facing up-left)
$84:A241             dx 0001, A9CB
                        FF, 00
                        0001, 09CA
                        FF, 01
                        0002, A9AA, A9AB
                        0000

; Used by instruction list $AED8: Unused
$84:A255             dw 8002, 2330, 2350
                        0000

; Used by instruction list $AED8: Unused
$84:A25D             dw 8002, 2331, 2351
                        0000

; Used by instruction list $AED8: Unused
$84:A265             dw 8002, 2332, 2352
                        0000

; Used by instruction list $AED8: Unused
$84:A26D             dw 8002, 2333, 2353
                        0000

; Used by instruction list $AF1E: Unused
$84:A275             dx 8002, 2330, 2350
                        FF, 00
                        8002, 2330, 2350
                        0000

; Used by instruction list $AF1E: Unused
$84:A285             dx 8002, 2331, 2351
                        FF, 00
                        8002, 2331, 2351
                        0000

; Used by instruction list $AF1E: Unused
$84:A295             dx 8002, 2332, 2352
                        FF, 00
                        8002, 2332, 2352
                        0000

; Used by instruction list $AF1E: Unused
$84:A2A5             dx 8002, 2333, 2353
                        FF, 00
                        8002, 2333, 2353
                        0000

; Used by instruction lists:
;     $AADF: Unused. draw empty tile
;     $D13F: PLM $D6D6 (Lower Norfair chozo hand)
;     $DFA9: empty item
;     $DFC7: item orb burst
;     $DFD7: empty item orb
;     $E032: empty item shot block reconcealing
;     $E44A: PLM $EF2B (energy tank, chozo orb)
;     $E47C: PLM $EF2F (missile tank, chozo orb)
;     $E4AE: PLM $EF33 (super missile tank, chozo orb)
;     $E4E0: PLM $EF37 (power bomb tank, chozo orb)
;     $E512: PLM $EF3B (bombs, chozo orb)
;     $E54D: PLM $EF3F (charge beam, chozo orb)
;     $E588: PLM $EF43 (ice beam, chozo orb)
;     $E5C3: PLM $EF47 (hi-jump, chozo orb)
;     $E5FE: PLM $EF4B (speed booster, chozo orb)
;     $E642: PLM $EF4F (wave beam, chozo orb)
;     $E67D: PLM $EF53 (spazer beam, chozo orb)
;     $E6B8: PLM $EF57 (spring ball, chozo orb)
;     $E6F3: PLM $EF5B (varia suit, chozo orb)
;     $E735: PLM $EF5F (gravity suit, chozo orb)
;     $E777: PLM $EF63 (x-ray scope, chozo orb)
;     $E7B1: PLM $EF67 (plasma beam, chozo orb)
;     $E7EC: PLM $EF6B (grapple beam, chozo orb)
;     $E826: PLM $EF6F (space jump, chozo orb)
;     $E861: PLM $EF73 (screw attack, chozo orb)
;     $E89C: PLM $EF77 (morph ball, chozo orb)
;     $E8D7: PLM $EF7B (reserve tank, chozo orb)
$84:A2B5             dw 0001, 00FF
                        0000

; Unused
$84:A2BB             dw 0001, 805D
                        0000

; Unused
$84:A2C1             dw 0001, 805E
                        0000

; Used by instruction list $DFAF: item orb
$84:A2C7             dw 0001, C072
                        0000

; Used by instruction list $DFAF: item orb
$84:A2CD             dw 0001, C073
                        0000

; Used by instruction list $DFAF: item orb
$84:A2D3             dw 0001, C074
                        0000

; Used by instruction list $DFC7: item orb burst
$84:A2D9             dw 0001, 8075
                        0000

; Used by instruction lists:
;     $E099: PLM $EED7 (energy tank)
;     $E44A: PLM $EF2B (energy tank, chozo orb)
;     $E911: PLM $EF7F (energy tank, shot block)
$84:A2DF             dw 0001, B04A
                        0000

; Used by instruction lists:
;     $E099: PLM $EED7 (energy tank)
;     $E44A: PLM $EF2B (energy tank, chozo orb)
;     $E911: PLM $EF7F (energy tank, shot block)
$84:A2E5             dw 0001, B04B
                        0000

; Used by instruction lists:
;     $E0BE: PLM $EEDB (missile tank)
;     $E47C: PLM $EF2F (missile tank, chozo orb)
;     $E949: PLM $EF83 (missile tank, shot block)
$84:A2EB             dw 0001, B04C
                        0000

; Used by instruction lists:
;     $E0BE: PLM $EEDB (missile tank)
;     $E47C: PLM $EF2F (missile tank, chozo orb)
;     $E949: PLM $EF83 (missile tank, shot block)
$84:A2F1             dw 0001, B04D
                        0000

; Used by instruction lists:
;     $E0E3: PLM $EEDF (super missile tank)
;     $E4AE: PLM $EF33 (super missile tank, chozo orb)
;     $E981: PLM $EF87 (super missile tank, shot block)
$84:A2F7             dw 0001, B04E
                        0000

; Used by instruction lists:
;     $E0E3: PLM $EEDF (super missile tank)
;     $E4AE: PLM $EF33 (super missile tank, chozo orb)
;     $E981: PLM $EF87 (super missile tank, shot block)
$84:A2FD             dw 0001, B04F
                        0000

; Used by instruction lists:
;     $E108: PLM $EEE3 (power bomb tank)
;     $E4E0: PLM $EF37 (power bomb tank, chozo orb)
;     $E9B9: PLM $EF8B (power bomb tank, shot block)
$84:A303             dw 0001, B050
                        0000

; Used by instruction lists:
;     $E108: PLM $EEE3 (power bomb tank)
;     $E4E0: PLM $EF37 (power bomb tank, chozo orb)
;     $E9B9: PLM $EF8B (power bomb tank, shot block)
$84:A309             dw 0001, B051
                        0000

; Used by instruction $E04F: draw item frame 0
$84:A30F             dw 0001, B08E
                        0000

; Used by instruction $E04F: draw item frame 1
$84:A315             dw 0001, B08F
                        0000

; Used by instruction $E04F: draw item frame 0
$84:A31B             dw 0001, B090
                        0000

; Used by instruction $E04F: draw item frame 1
$84:A321             dw 0001, B091
                        0000

; Used by instruction $E04F: draw item frame 0
$84:A327             dw 0001, B092
                        0000

; Used by instruction $E04F: draw item frame 1
$84:A32D             dw 0001, B093
                        0000

; Used by instruction $E04F: draw item frame 0
$84:A333             dw 0001, B094
                        0000

; Used by instruction $E04F: draw item frame 1
$84:A339             dw 0001, B095
                        0000

; Used by instruction list $D121: PLM $D127
$84:A33F             dw 0001, 8052
                        0000

; Used by instruction lists:
;     $AB31: PLM $B79B (crumble Botwoon wall)
;     $C92E: PLM $D028 (unused)
;     $C951: PLM $D030 (collision reaction, special, BTS Brinstar 82h. Respawning speed block, slower crumble animation)
;     $C974: PLM $D038 (collision reaction, special, BTS Eh. Respawning speed boost block)
;     $C997: PLM $D03C (collision reaction, special, BTS Brinstar 84h. Respawning speed block)
;     $C9BA: PLM $D02C (unused)
;     $C9CF: PLM $D034 (collision reaction, special, BTS Brinstar 83h. Speed block, slower crumble animation)
;     $C9E4: PLM $D040 (collision reaction, special, BTS Fh / Brinstar 85h. Speed boost block)
;     $C9F9: PLM $D044 (collision reaction, special, BTS 0. 1x1 respawning crumble block)
;     $CA8B: PLM $D054 (collision reaction, special, BTS 4. 1x1 crumble block)
;     $CADF: PLM $D064 (shot/bombed/grappled reaction, shootable, BTS 0. 1x1 respawning shot block)
;     $CB71: PLM $D08C (shot/bombed/grappled reaction, shootable, BTS Ah. Respawning super missile block)
;     $CB94: PLM $D084 (shot/bombed/grappled reaction, shootable, BTS 8. Respawning power bomb block)
;     $CBB7: PLM $D074 (shot/bombed/grappled reaction, shootable, BTS 4. 1x1 shot block)
;     $CC0B: PLM $D090 (shot/bombed/grappled reaction, shootable, BTS Bh. Super missile block)
;     $CC3F: 1x1 respawning bomb block
;     $CC20: PLM $D088 (shot/bombed/grappled reaction, shootable, BTS 9. Power bomb block)
;     $CCED: 1x1 bomb block
;     $CD53: PLM $D094 (enemy collision reaction, spike block, BTS Fh. Enemy breakable block)
;     $D0F6: PLM $D113 (crumble Lower Norfair chozo room plug)
;     $E032: empty item shot block reconcealing
$84:A345             dw 0001, 0053
                        0000

; Used by instruction lists:
;     $AB31: PLM $B79B (crumble Botwoon wall)
;     $C92E: PLM $D028 (unused)
;     $C951: PLM $D030 (collision reaction, special, BTS Brinstar 82h. Respawning speed block, slower crumble animation)
;     $C974: PLM $D038 (collision reaction, special, BTS Eh. Respawning speed boost block)
;     $C997: PLM $D03C (collision reaction, special, BTS Brinstar 84h. Respawning speed block)
;     $C9BA: PLM $D02C (unused)
;     $C9CF: PLM $D034 (collision reaction, special, BTS Brinstar 83h. Speed block, slower crumble animation)
;     $C9E4: PLM $D040 (collision reaction, special, BTS Fh / Brinstar 85h. Speed boost block)
;     $C9F9: PLM $D044 (collision reaction, special, BTS 0. 1x1 respawning crumble block)
;     $CA8B: PLM $D054 (collision reaction, special, BTS 4. 1x1 crumble block)
;     $CADF: PLM $D064 (shot/bombed/grappled reaction, shootable, BTS 0. 1x1 respawning shot block)
;     $CB71: PLM $D08C (shot/bombed/grappled reaction, shootable, BTS Ah. Respawning super missile block)
;     $CB94: PLM $D084 (shot/bombed/grappled reaction, shootable, BTS 8. Respawning power bomb block)
;     $CBB7: PLM $D074 (shot/bombed/grappled reaction, shootable, BTS 4. 1x1 shot block)
;     $CC0B: PLM $D090 (shot/bombed/grappled reaction, shootable, BTS Bh. Super missile block)
;     $CC20: PLM $D088 (shot/bombed/grappled reaction, shootable, BTS 9. Power bomb block)
;     $CC3F: 1x1 respawning bomb block
;     $CCED: 1x1 bomb block
;     $CD53: PLM $D094 (enemy collision reaction, spike block, BTS Fh. Enemy breakable block)
;     $D0F6: PLM $D113 (crumble Lower Norfair chozo room plug)
;     $E032: empty item shot block reconcealing
$84:A34B             dw 0001, 0054
                        0000

; Used by instruction lists:
;     $AB31: PLM $B79B (crumble Botwoon wall)
;     $C92E: PLM $D028 (unused)
;     $C951: PLM $D030 (collision reaction, special, BTS Brinstar 82h. Respawning speed block, slower crumble animation)
;     $C974: PLM $D038 (collision reaction, special, BTS Eh. Respawning speed boost block)
;     $C997: PLM $D03C (collision reaction, special, BTS Brinstar 84h. Respawning speed block)
;     $C9BA: PLM $D02C (unused)
;     $C9CF: PLM $D034 (collision reaction, special, BTS Brinstar 83h. Speed block, slower crumble animation)
;     $C9E4: PLM $D040 (collision reaction, special, BTS Fh / Brinstar 85h. Speed boost block)
;     $C9F9: PLM $D044 (collision reaction, special, BTS 0. 1x1 respawning crumble block)
;     $CA8B: PLM $D054 (collision reaction, special, BTS 4. 1x1 crumble block)
;     $CADF: PLM $D064 (shot/bombed/grappled reaction, shootable, BTS 0. 1x1 respawning shot block)
;     $CB71: PLM $D08C (shot/bombed/grappled reaction, shootable, BTS Ah. Respawning super missile block)
;     $CB94: PLM $D084 (shot/bombed/grappled reaction, shootable, BTS 8. Respawning power bomb block)
;     $CBB7: PLM $D074 (shot/bombed/grappled reaction, shootable, BTS 4. 1x1 shot block)
;     $CC0B: PLM $D090 (shot/bombed/grappled reaction, shootable, BTS Bh. Super missile block)
;     $CC20: PLM $D088 (shot/bombed/grappled reaction, shootable, BTS 9. Power bomb block)
;     $CC3F: 1x1 respawning bomb block
;     $CCED: 1x1 bomb block
;     $CD53: PLM $D094 (enemy collision reaction, spike block, BTS Fh. Enemy breakable block)
;     $D0F6: PLM $D113 (crumble Lower Norfair chozo room plug)
;     $E032: empty item shot block reconcealing
$84:A351             dw 0001, 0055
                        0000

; Used by instruction lists:
;     $AB31: PLM $B79B (crumble Botwoon wall)
;     $C92E: PLM $D028 (unused)
;     $C951: PLM $D030 (collision reaction, special, BTS Brinstar 82h. Respawning speed block, slower crumble animation)
;     $C974: PLM $D038 (collision reaction, special, BTS Eh. Respawning speed boost block)
;     $C997: PLM $D03C (collision reaction, special, BTS Brinstar 84h. Respawning speed block)
;     $C9BA: PLM $D02C (unused)
;     $C9CF: PLM $D034 (collision reaction, special, BTS Brinstar 83h. Speed block, slower crumble animation)
;     $C9E4: PLM $D040 (collision reaction, special, BTS Fh / Brinstar 85h. Speed boost block)
;     $C9F9: PLM $D044 (collision reaction, special, BTS 0. 1x1 respawning crumble block)
;     $CA8B: PLM $D054 (collision reaction, special, BTS 4. 1x1 crumble block)
;     $CADF: PLM $D064 (shot/bombed/grappled reaction, shootable, BTS 0. 1x1 respawning shot block)
;     $CB71: PLM $D08C (shot/bombed/grappled reaction, shootable, BTS Ah. Respawning super missile block)
;     $CB94: PLM $D084 (shot/bombed/grappled reaction, shootable, BTS 8. Respawning power bomb block)
;     $CBB7: PLM $D074 (shot/bombed/grappled reaction, shootable, BTS 4. 1x1 shot block)
;     $CC0B: PLM $D090 (shot/bombed/grappled reaction, shootable, BTS Bh. Super missile block)
;     $CC20: PLM $D088 (shot/bombed/grappled reaction, shootable, BTS 9. Power bomb block)
;     $CC3F: 1x1 respawning bomb block
;     $CCED: 1x1 bomb block
;     $CD53: PLM $D094 (enemy collision reaction, spike block, BTS Fh. Enemy breakable block)
;     $D0F6: PLM $D113 (crumble Lower Norfair chozo room plug)
$84:A357             dw 0001, 00FF
                        0000

; Used by instruction lists:
;     $CA1C: PLM $D048 (collision reaction, special, BTS 1. 2x1 respawning crumble block)
;     $CAA0: PLM $D058 (collision reaction, special, BTS 5. 2x1 crumble block)
;     $CB02: PLM $D068 (shot/bombed/grappled reaction, shootable, BTS 1. 2x1 respawning shot block)
;     $CBCC: PLM $D078 (shot/bombed/grappled reaction, shootable, BTS 5. 2x1 shot block)
;     $CC69: 2x1 respawning bomb block
;     $CD09: 2x1 bomb block
$84:A35D             dw 0002, 0053, 0053
                        0000

; Used by instruction lists:
;     $CA1C: PLM $D048 (collision reaction, special, BTS 1. 2x1 respawning crumble block)
;     $CAA0: PLM $D058 (collision reaction, special, BTS 5. 2x1 crumble block)
;     $CB02: PLM $D068 (shot/bombed/grappled reaction, shootable, BTS 1. 2x1 respawning shot block)
;     $CBCC: PLM $D078 (shot/bombed/grappled reaction, shootable, BTS 5. 2x1 shot block)
;     $CC69: 2x1 respawning bomb block
;     $CD09: 2x1 bomb block
$84:A365             dw 0002, 0054, 0054
                        0000

; Used by instruction lists:
;     $CA1C: PLM $D048 (collision reaction, special, BTS 1. 2x1 respawning crumble block)
;     $CAA0: PLM $D058 (collision reaction, special, BTS 5. 2x1 crumble block)
;     $CB02: PLM $D068 (shot/bombed/grappled reaction, shootable, BTS 1. 2x1 respawning shot block)
;     $CBCC: PLM $D078 (shot/bombed/grappled reaction, shootable, BTS 5. 2x1 shot block)
;     $CC69: 2x1 respawning bomb block
;     $CD09: 2x1 bomb block
$84:A36D             dw 0002, 0055, 0055
                        0000

; Used by instruction lists:
;     $CA1C: PLM $D048 (collision reaction, special, BTS 1. 2x1 respawning crumble block)
;     $CAA0: PLM $D058 (collision reaction, special, BTS 5. 2x1 crumble block)
;     $CB02: PLM $D068 (shot/bombed/grappled reaction, shootable, BTS 1. 2x1 respawning shot block)
;     $CBCC: PLM $D078 (shot/bombed/grappled reaction, shootable, BTS 5. 2x1 shot block)
;     $CC69: 2x1 respawning bomb block
;     $CD09: 2x1 bomb block
$84:A375             dw 0002, 00FF, 00FF
                        0000

; Used by instruction lists:
;     $CA41: PLM $D04C (collision reaction, special, BTS 2. 1x2 respawning crumble block)
;     $CAB5: PLM $D05C (collision reaction, special, BTS 6. 1x2 crumble block)
;     $CB27: PLM $D06C (shot/bombed/grappled reaction, shootable, BTS 2. 1x2 respawning shot block)
;     $CBE1: PLM $D07C (shot/bombed/grappled reaction, shootable, BTS 6. 1x2 shot block)
;     $CC95: 1x2 respawning bomb block
;     $CD25: 1x2 bomb block
$84:A37D             dw 8002, 0053, 0053
                        0000

; Used by instruction lists:
;     $CA41: PLM $D04C (collision reaction, special, BTS 2. 1x2 respawning crumble block)
;     $CAB5: PLM $D05C (collision reaction, special, BTS 6. 1x2 crumble block)
;     $CB27: PLM $D06C (shot/bombed/grappled reaction, shootable, BTS 2. 1x2 respawning shot block)
;     $CBE1: PLM $D07C (shot/bombed/grappled reaction, shootable, BTS 6. 1x2 shot block)
;     $CC95: 1x2 respawning bomb block
;     $CD25: 1x2 bomb block
$84:A385             dw 8002, 0054, 0054
                        0000

; Used by instruction lists:
;     $CA41: PLM $D04C (collision reaction, special, BTS 2. 1x2 respawning crumble block)
;     $CAB5: PLM $D05C (collision reaction, special, BTS 6. 1x2 crumble block)
;     $CB27: PLM $D06C (shot/bombed/grappled reaction, shootable, BTS 2. 1x2 respawning shot block)
;     $CBE1: PLM $D07C (shot/bombed/grappled reaction, shootable, BTS 6. 1x2 shot block)
;     $CC95: 1x2 respawning bomb block
;     $CD25: 1x2 bomb block
$84:A38D             dw 8002, 0055, 0055
                        0000

; Used by instruction lists:
;     $CA41: PLM $D04C (collision reaction, special, BTS 2. 1x2 respawning crumble block)
;     $CAB5: PLM $D05C (collision reaction, special, BTS 6. 1x2 crumble block)
;     $CB27: PLM $D06C (shot/bombed/grappled reaction, shootable, BTS 2. 1x2 respawning shot block)
;     $CBE1: PLM $D07C (shot/bombed/grappled reaction, shootable, BTS 6. 1x2 shot block)
;     $CC95: 1x2 respawning bomb block
;     $CD25: 1x2 bomb block
$84:A395             dw 8002, 00FF, 00FF
                        0000

; Used by instruction lists:
;     $CA66: PLM $D050 (collision reaction, special, BTS 3. 2x2 respawning crumble block)
;     $CACA: PLM $D060 (collision reaction, special, BTS 7. 2x2 crumble block)
;     $CB4C: PLM $D070 (shot/bombed/grappled reaction, shootable, BTS 3. 2x2 respawning shot block)
;     $CBF6: PLM $D080 (shot/bombed/grappled reaction, shootable, BTS 7. 2x2 shot block)
;     $CCC1: 2x2 respawning bomb block
;     $CD41: 2x2 bomb block
$84:A39D             dx 0002, 0053, 0053
                        00, 01
                        0002, 0053, 0053
                        0000

; Used by instruction lists:
;     $CA66: PLM $D050 (collision reaction, special, BTS 3. 2x2 respawning crumble block)
;     $CACA: PLM $D060 (collision reaction, special, BTS 7. 2x2 crumble block)
;     $CB4C: PLM $D070 (shot/bombed/grappled reaction, shootable, BTS 3. 2x2 respawning shot block)
;     $CBF6: PLM $D080 (shot/bombed/grappled reaction, shootable, BTS 7. 2x2 shot block)
;     $CCC1: 2x2 respawning bomb block
;     $CD41: 2x2 bomb block
$84:A3AD             dx 0002, 0054, 0054
                        00, 01
                        0002, 0054, 0054
                        0000

; Used by instruction lists:
;     $CA66: PLM $D050 (collision reaction, special, BTS 3. 2x2 respawning crumble block)
;     $CACA: PLM $D060 (collision reaction, special, BTS 7. 2x2 crumble block)
;     $CB4C: PLM $D070 (shot/bombed/grappled reaction, shootable, BTS 3. 2x2 respawning shot block)
;     $CBF6: PLM $D080 (shot/bombed/grappled reaction, shootable, BTS 7. 2x2 shot block)
;     $CCC1: 2x2 respawning bomb block
;     $CD41: 2x2 bomb block
$84:A3BD             dx 0002, 0055, 0055
                        00, 01
                        0002, 0055, 0055
                        0000

; Used by instruction lists:
;     $CA66: PLM $D050 (collision reaction, special, BTS 3. 2x2 respawning crumble block)
;     $CACA: PLM $D060 (collision reaction, special, BTS 7. 2x2 crumble block)
;     $CB4C: PLM $D070 (shot/bombed/grappled reaction, shootable, BTS 3. 2x2 respawning shot block)
;     $CBF6: PLM $D080 (shot/bombed/grappled reaction, shootable, BTS 7. 2x2 shot block)
;     $CCC1: 2x2 respawning bomb block
;     $CD41: 2x2 bomb block
$84:A3CD             dx 0002, 00FF, 00FF
                        00, 01
                        0002, 00FF, 00FF
                        0000

; Used by instruction lists:
;     $E007: item shot block
;     $E020: item shot block reconcealing
$84:A3DD             dw 0001, 8053
                        0000

; Used by instruction lists:
;     $E007: item shot block
;     $E020: item shot block reconcealing
$84:A3E3             dw 0001, 8054
                        0000

; Used by instruction lists:
;     $E007: item shot block
;     $E020: item shot block reconcealing
$84:A3E9             dw 0001, 8055
                        0000

; Unused
$84:A3EF             dw 0001, 80FF
                        0000

; Unused
$84:A3F5             dw 0002, 8053, 8053
                        0000

; Unused
$84:A3FD             dw 0002, 8054, 8054
                        0000

; Unused
$84:A405             dw 0002, 8055, 8055
                        0000

; Unused
$84:A40D             dw 0002, 80FF, 80FF
                        0000

; Unused
$84:A415             dw 8002, 8053, 8053
                        0000

; Unused
$84:A41D             dw 8002, 8054, 8054
                        0000

; Unused
$84:A425             dw 8002, 8055, 8055
                        0000

; Unused
$84:A42D             dw 8002, 80FF, 80FF
                        0000

; Unused
$84:A435             dx 0002, 8053, 8053
                        00, 01
                        0002, 8053, 8053
                        0000

; Unused
$84:A445             dx 0002, 8054, 8054
                        00, 01
                        0002, 8054, 8054
                        0000

; Unused
$84:A455             dx 0002, 8055, 8055
                        00, 01
                        0002, 8055, 8055
                        0000

; Unused
$84:A465             dx 0002, 80FF, 80FF
                        00, 01
                        0002, 80FF, 80FF
                        0000

; Used by instruction list $C8D4: PLM $CFEC (unused. Draws 1x1 shot block)
$84:A475             dw 0001, C052
                        0000

; Used by instruction lists:
;     $C8DA: PLM $CFF0 (unused. Draws 1x2 shot block)
;     $CB02: PLM $D068 (shot/bombed/grappled reaction, shootable, BTS 1. 2x1 respawning shot block)
$84:A47B             dw 0002, C096, 5097
                        0000

; Used by instruction lists:
;     $C8E0: PLM $CFF4 (unused. Draws 2x1 shot block)
;     $CB27: PLM $D06C (shot/bombed/grappled reaction, shootable, BTS 2. 1x2 respawning shot block)
$84:A483             dw 8002, C098, D0B8
                        0000

; Used by instruction lists:
;     $C8E6: PLM $CFF8 (unused. Draws 2x2 shot block)
;     $CB4C: PLM $D070 (shot/bombed/grappled reaction, shootable, BTS 3. 2x2 respawning shot block)
$84:A48B             dx 0002, C099, 509A
                        00, 01
                        0002, D0B9, D0BA
                        0000

; Used by instruction list $C8EC: PLM $CFFC (bomb reaction, special block, BTS 0/4. 1x1 (respawning) crumble block)
$84:A49B             dw 0001, B0BC
                        0000

; Used by instruction lists:
;     $C8F2: PLM $D000 (bomb reaction, special block, BTS 1/5. 2x1 (respawning) crumble block)
;     $CA1C: PLM $D048 (collision reaction, special, BTS 1. 2x1 respawning crumble block)
$84:A4A1             dw 0002, B0BC, 50BC
                        0000

; Used by instruction lists:
;     $C8F8: PLM $D004 (bomb reaction, special block, BTS 2/6. 1x2 (respawning) crumble block)
;     $CA41: PLM $D04C (collision reaction, special, BTS 2. 1x2 respawning crumble block)
$84:A4A9             dw 8002, B0BC, D0BC
                        0000

; Used by instruction lists:
;     $C8FE: PLM $D008 (bomb reaction, special block, BTS 3/7. 2x2 (respawning) crumble block)
;     $CA66: PLM $D050 (collision reaction, special, BTS 3. 2x2 respawning crumble block)
$84:A4B1             dx 0002, B0BC, 50BC
                        00, 01
                        0002, D0BC, D0BC
                        0000

; Used by instruction list $C904: PLM $D00C (unused)
$84:A4C1             dw 0001, F058
                        0000

; Used by instruction lists:
;     $C90A: PLM $D010 (unused)
;     $CC69: 2x1 respawning bomb block
$84:A4C7             dw 0002, F058, 5058
                        0000

; Used by instruction lists:
;     $C910: PLM $D014 (unused)
;     $CC95: 1x2 respawning bomb block
$84:A4CF             dw 8002, F058, D058
                        0000

; Used by instruction lists:
;     $C916: PLM $D018 (unused)
;     $CCC1: 2x2 respawning bomb block
$84:A4D7             dx 0002, F058, 5058
                        00, 01
                        0002, D058, D058
                        0000

; Used by instruction list $C91C: PLM $D01C (unused) / power bomb block bombed
$84:A4E7             dw 0001, C057
                        0000

; Used by instruction list $C922: PLM $D020 (unused) / super missile block bombed
$84:A4ED             dw 0001, C09F
                        0000

; Used by instruction list $C928: PLM $D024 (bomb reaction, special block, BTS 0Eh/0Fh / Brinstar 82h/83h/84h/85h. Speed block)
$84:A4F3             dw 0001, B0B6
                        0000

; Used by instruction lists:
;     $CD6A: PLM $D0DC (grappled reaction, grapple block, BTS 1. Respawning breakable grapple block)
;     $CDA9: PLM $D0E0 (grappled reaction, grapple block, BTS 2. Breakable grapple block)
;     $D135: PLM $D13B
$84:A4F9             dw 0001, E0B7
                        0000

; Used by instruction lists:
;     $CD6A: PLM $D0DC (grappled reaction, grapple block, BTS 1. Respawning breakable grapple block)
;     $CDA9: PLM $D0E0 (grappled reaction, grapple block, BTS 2. Breakable grapple block)
$84:A4FF             dw 0001, 0053
                        0000

; Used by instruction lists:
;     $CD6A: PLM $D0DC (grappled reaction, grapple block, BTS 1. Respawning breakable grapple block)
;     $CDA9: PLM $D0E0 (grappled reaction, grapple block, BTS 2. Breakable grapple block)
$84:A505             dw 0001, 0054
                        0000

; Used by instruction lists:
;     $CD6A: PLM $D0DC (grappled reaction, grapple block, BTS 1. Respawning breakable grapple block)
;     $CDA9: PLM $D0E0 (grappled reaction, grapple block, BTS 2. Breakable grapple block)
$84:A50B             dw 0001, 0055
                        0000

; Used by instruction lists:
;     $CD6A: PLM $D0DC (grappled reaction, grapple block, BTS 1. Respawning breakable grapple block)
;     $CDA9: PLM $D0E0 (grappled reaction, grapple block, BTS 2. Breakable grapple block)
$84:A511             dw 0001, 00FF
                        0000

; Used by instruction list $BC13: PLM $C826 (downwards open gate)
$84:A517             dw 8005, C0D6, 00FF, 00FF, 00FF, 00FF
                        0000

; Used by instruction lists:
;     $BC13: PLM $C826 (downwards open gate)
;     $BC3A: PLM $C82A (downwards closed gate)
$84:A525             dw 8005, C0D7, C0FF, 00FF, 00FF, 00FF
                        0000

; Used by instruction lists:
;     $BC13: PLM $C826 (downwards open gate)
;     $BC3A: PLM $C82A (downwards closed gate)
$84:A533             dw 8005, C0D7, C0FF, C0FF, 00FF, 00FF
                        0000

; Used by instruction lists:
;     $BC13: PLM $C826 (downwards open gate)
;     $BC3A: PLM $C82A (downwards closed gate)
$84:A541             dw 8005, C0D7, C0FF, C0FF, C0FF, 00FF
                        0000

; Used by instruction lists:
;     $BC13: PLM $C826 (downwards open gate)
;     $BC3A: PLM $C82A (downwards closed gate)
$84:A54F             dw 8005, C0D7, C0FF, C0FF, C0FF, C0FF
                        0000

; Used by instruction list $BC3A: PLM $C82A (downwards closed gate)
$84:A55D             dw 8005, C0D6, C0FF, C0FF, C0FF, C0FF
                        0000

; Used by instruction list $BC61: PLM $C82E (upwards open gate)
$84:A56B             dx 8001, C0D6
                        00, FC
                        8004, 00FF, 00FF, 00FF, 00FF
                        0000

; Used by instruction lists:
;     $BC61: PLM $C82E (upwards open gate)
;     $BC88: PLM $C832 (upwards closed gate)
$84:A57D             dx 8001, C0D7
                        00, FC
                        8004, 00FF, 00FF, 00FF, 80FF
                        0000

; Used by instruction lists:
;     $BC61: PLM $C82E (upwards open gate)
;     $BC88: PLM $C832 (upwards closed gate)
$84:A58F             dx 8001, C0D7
                        00, FC
                        8004, 00FF, 00FF, C0FF, C0FF
                        0000

; Used by instruction lists:
;     $BC61: PLM $C82E (upwards open gate)
;     $BC88: PLM $C832 (upwards closed gate)
$84:A5A1             dx 8001, C0D7
                        00, FC
                        8004, 00FF, C0FF, C0FF, C0FF
                        0000

; Used by instruction lists:
;     $BC61: PLM $C82E (upwards open gate)
;     $BC88: PLM $C832 (upwards closed gate)
$84:A5B3             dx 8001, C0D7
                        00, FC
                        8004, C0FF, C0FF, C0FF, C0FF
                        0000

; Used by instruction list $BC88: PLM $C832 (upwards closed gate)
$84:A5C5             dx 8001, C0D6
                        00, FC
                        8004, C0FF, C0FF, C0FF, C0FF
                        0000

; Used by instruction list $BCAF: PLM $C836 (downwards gate shotblock) - blue left
$84:A5D7             dx 0001, 80D6
                        FF, 00
                        0001, C0DB
                        0000

; Used by instruction list $BCB5: PLM $C836 (downwards gate shotblock) - blue right
$84:A5E3             dw 0002, 80D6, C4DB
                        0000

; Used by instruction list $BCBB: PLM $C836 (downwards gate shotblock) - red left
$84:A5EB             dx 0001, 80D6
                        FF, 00
                        0001, C0DA
                        0000

; Used by instruction list $BCC1: PLM $C836 (downwards gate shotblock) - red right
$84:A5F7             dw 0002, 80D6, C4DA
                        0000

; Used by instruction list $BCC7: PLM $C836 (downwards gate shotblock) - green left
$84:A5FF             dx 0001, 80D6
                        FF, 00
                        0001, C0D9
                        0000

; Used by instruction list $BCCD: PLM $C836 (downwards gate shotblock) - green right
$84:A60B             dw 0002, 80D6, C4D9
                        0000

; Used by instruction list $BCD3: PLM $C836 (downwards gate shotblock) - yellow left
$84:A613             dx 0001, 80D6
                        FF, 00
                        0001, C0D8
                        0000

; Used by instruction list $BCD9: PLM $C836 (downwards gate shotblock) - yellow right
$84:A61F             dw 0002, 80D6, C4D8
                        0000

; Used by instruction list $BCDF: PLM $C83A (upwards gate shotblock) - blue left
$84:A627             dx 0001, 88D6
                        FF, 00
                        0001, C8DB
                        0000

; Used by instruction list $BCE5: PLM $C83A (upwards gate shotblock) - blue right
$84:A633             dw 0002, 88D6, CCDB
                        0000

; Used by instruction list $BCEB: PLM $C83A (upwards gate shotblock) - red left
$84:A63B             dx 0001, 88D6
                        FF, 00
                        0001, C8DA
                        0000

; Used by instruction list $BCF1: PLM $C83A (upwards gate shotblock) - red right
$84:A647             dw 0002, 88D6, CCDA
                        0000

; Used by instruction list $BCF7: PLM $C83A (upwards gate shotblock) - green left
$84:A64F             dx 0001, 88D6
                        FF, 00
                        0001, C8D9
                        0000

; Used by instruction list $BCFD: PLM $C83A (upwards gate shotblock) - green right
$84:A65B             dw 0002, 88D6, CCD9
                        0000

; Used by instruction list $BD03: PLM $C83A (upwards gate shotblock) - yellow left
$84:A663             dx 0001, 88D6
                        FF, 00
                        0001, C8D8
                        0000

; Used by instruction list $BD09: PLM $C83A (upwards gate shotblock) - yellow right
$84:A66F             dw 0002, 88D6, CCD8
                        0000

; Used by instruction lists:
;     $BE59: door $C842 (grey door facing left)
;     $BE70: door $C842 (grey door facing left)
;     $BFFD: door $C85A (yellow door facing left)
;     $C014: door $C85A (yellow door facing left)
;     $C185: door $C872 (green door facing left)
;     $C19C: door $C872 (green door facing left)
;     $C301: door $C88A (red door facing left)
;     $C318: door $C88A (red door facing left)
;     $C489: door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left)
;     $C49E: door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left)
$84:A677             dw 8004, 0082, 00A2, 08A2, 0882
                        0000

; Used by instruction lists:
;     $BA4C: PLM $BAF4 (bomb torizo grey door)
;     $BA7F: PLM $BAF4 (bomb torizo grey door)
;     $BEC2: door $C848 (grey door facing right)
;     $BED9: door $C848 (grey door facing right)
;     $C060: door $C860 (yellow door facing right)
;     $C077: door $C860 (yellow door facing right)
;     $C1E4: door $C878 (green door facing right)
;     $C1FB: door $C878 (green door facing right)
;     $C363: door $C890 (red door facing right)
;     $C37A: door $C890 (red door facing right)
;     $C4BA: door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right)
;     $C4CF: door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right)
$84:A683             dw 8004, 0482, 04A2, 0CA2, 0C82
                        0000

; Used by instruction lists:
;     $BF2B: door $C84E (grey door facing up)
;     $BF42: door $C84E (grey door facing up)
;     $C0C3: door $C866 (yellow door facing up)
;     $C0DA: door $C866 (yellow door facing up)
;     $C243: door $C87E (green door facing up)
;     $C25A: door $C87E (green door facing up)
;     $C3C5: door $C896 (red door facing up)
;     $C3DC: door $C896 (red door facing up)
;     $C4EB: door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up)
;     $C500: door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up)
$84:A68F             dw 0004, 0484, 0483, 0083, 0084
                        0000

; Used by instruction lists:
;     $BF94: door $C854 (grey door facing down)
;     $BFAB: door $C854 (grey door facing down)
;     $C122: door $C86C (yellow door facing down)
;     $C139: door $C86C (yellow door facing down)
;     $C2A2: door $C884 (green door facing down)
;     $C2B9: door $C884 (green door facing down)
;     $C427: door $C89C (red door facing down)
;     $C43E: door $C89C (red door facing down)
;     $C51C: door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down)
;     $C531: door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down)
$84:A69B             dw 0004, 0C84, 0C83, 0883, 0884
                        0000

; Used by instruction lists:
;     $BE59: door $C842 (grey door facing left)
;     $BE70: door $C842 (grey door facing left)
$84:A6A7             dw 8004, C0AE, D0CE, D8CE, D8AE
                        0000

; Used by instruction lists:
;     $BE59: door $C842 (grey door facing left)
;     $BE70: door $C842 (grey door facing left)
$84:A6B3             dw 8004, 80AF, 80CF, 88CF, 88AF
                        0000

; Used by instruction lists:
;     $BE59: door $C842 (grey door facing left)
;     $BE70: door $C842 (grey door facing left)
$84:A6BF             dw 8004, 80B0, 80D0, 88D0, 88B0
                        0000

; Used by instruction lists:
;     $BE59: door $C842 (grey door facing left)
;     $BE70: door $C842 (grey door facing left)
$84:A6CB             dw 8004, 80B1, 00D1, 08D1, 88B1
                        0000

; Used by instruction lists:
;     $BA4C: PLM $BAF4 (bomb torizo grey door)
;     $BA7F: PLM $BAF4 (bomb torizo grey door)
;     $BEC2: door $C848 (grey door facing right)
;     $BED9: door $C848 (grey door facing right)
$84:A6D7             dw 8004, C4AE, D4CE, DCCE, DCAE
                        0000

; Used by instruction lists:
;     $BA4C: PLM $BAF4 (bomb torizo grey door)
;     $BA7F: PLM $BAF4 (bomb torizo grey door)
;     $BEC2: door $C848 (grey door facing right)
;     $BED9: door $C848 (grey door facing right)
$84:A6E3             dw 8004, 84AF, 84CF, 8CCF, 8CAF
                        0000

; Used by instruction lists:
;     $BA4C: PLM $BAF4 (bomb torizo grey door)
;     $BA7F: PLM $BAF4 (bomb torizo grey door)
;     $BEC2: door $C848 (grey door facing right)
;     $BED9: door $C848 (grey door facing right)
$84:A6EF             dw 8004, 84B0, 84D0, 8CD0, 8CB0
                        0000

; Used by instruction lists:
;     $BA4C: PLM $BAF4 (bomb torizo grey door)
;     $BA7F: PLM $BAF4 (bomb torizo grey door)
;     $BEC2: door $C848 (grey door facing right)
;     $BED9: door $C848 (grey door facing right)
$84:A6FB             dw 8004, 84B1, 84D1, 8CD1, 8CB1
                        0000

; Used by instruction lists:
;     $BF2B: door $C84E (grey door facing up)
;     $BF42: door $C84E (grey door facing up)
$84:A707             dw 0004, C4B3, 54B2, 50B2, 50B3
                        0000

; Used by instruction lists:
;     $BF2B: door $C84E (grey door facing up)
;     $BF42: door $C84E (grey door facing up)
$84:A713             dw 0004, 84D3, 84D2, 80D2, 80D3
                        0000

; Used by instruction lists:
;     $BF2B: door $C84E (grey door facing up)
;     $BF42: door $C84E (grey door facing up)
$84:A71F             dw 0004, 84B5, 84B4, 80B4, 80B5
                        0000

; Used by instruction lists:
;     $BF2B: door $C84E (grey door facing up)
;     $BF42: door $C84E (grey door facing up)
$84:A72B             dw 0004, 84D5, 84D4, 80D4, 80D5
                        0000

; Used by instruction lists:
;     $BF94: door $C854 (grey door facing down)
;     $BFAB: door $C854 (grey door facing down)
$84:A737             dw 0004, CCB3, 5CB2, 58B2, 58B3
                        0000

; Used by instruction lists:
;     $BF94: door $C854 (grey door facing down)
;     $BFAB: door $C854 (grey door facing down)
$84:A743             dw 0004, 8CD3, 8CD2, 88D2, 88D3
                        0000

; Used by instruction lists:
;     $BF94: door $C854 (grey door facing down)
;     $BFAB: door $C854 (grey door facing down)
$84:A74F             dw 0004, 8CB5, 8CB4, 88B4, 88B5
                        0000

; Used by instruction lists:
;     $BF94: door $C854 (grey door facing down)
;     $BFAB: door $C854 (grey door facing down)
$84:A75B             dw 0004, 8CD5, 0CD4, 08D4, 88D5
                        0000

; Used by instruction lists:
;     $BFFD: door $C85A (yellow door facing left)
;     $C014: door $C85A (yellow door facing left)
$84:A767             dw 8004, C000, D020, D820, D800
                        0000

; Used by instruction lists:
;     $BFFD: door $C85A (yellow door facing left)
;     $C014: door $C85A (yellow door facing left)
$84:A773             dw 8004, 8001, 8021, 8821, 8801
                        0000

; Used by instruction lists:
;     $BFFD: door $C85A (yellow door facing left)
;     $C014: door $C85A (yellow door facing left)
$84:A77F             dw 8004, 8002, 8022, 8822, 8802
                        0000

; Used by instruction lists:
;     $BFFD: door $C85A (yellow door facing left)
;     $C014: door $C85A (yellow door facing left)
$84:A78B             dw 8004, 8003, 0023, 0823, 8803
                        0000

; Used by instruction lists:
;     $C060: door $C860 (yellow door facing right)
;     $C077: door $C860 (yellow door facing right)
$84:A797             dw 8004, C400, D420, DC20, DC00
                        0000

; Used by instruction lists:
;     $C060: door $C860 (yellow door facing right)
;     $C077: door $C860 (yellow door facing right)
$84:A7A3             dw 8004, 8401, 8421, 8C21, 8C01
                        0000

; Used by instruction lists:
;     $C060: door $C860 (yellow door facing right)
;     $C077: door $C860 (yellow door facing right)
$84:A7AF             dw 8004, 8402, 8422, 8C22, 8C02
                        0000

; Used by instruction lists:
;     $C060: door $C860 (yellow door facing right)
;     $C077: door $C860 (yellow door facing right)
$84:A7BB             dw 8004, 8403, 8423, 8C23, 8C03
                        0000

; Used by instruction lists:
;     $C0C3: door $C866 (yellow door facing up)
;     $C0DA: door $C866 (yellow door facing up)
$84:A7C7             dw 0004, C411, 5410, 5010, 5011
                        0000

; Used by instruction lists:
;     $C0C3: door $C866 (yellow door facing up)
;     $C0DA: door $C866 (yellow door facing up)
$84:A7D3             dw 0004, 8431, 8430, 8030, 8031
                        0000

; Used by instruction lists:
;     $C0C3: door $C866 (yellow door facing up)
;     $C0DA: door $C866 (yellow door facing up)
$84:A7DF             dw 0004, 8413, 8412, 8012, 8013
                        0000

; Used by instruction lists:
;     $C0C3: door $C866 (yellow door facing up)
;     $C0DA: door $C866 (yellow door facing up)
$84:A7EB             dw 0004, 8433, 8432, 8032, 8033
                        0000

; Used by instruction lists:
;     $C122: door $C86C (yellow door facing down)
;     $C139: door $C86C (yellow door facing down)
$84:A7F7             dw 0004, CC11, 5C10, 5810, 5811
                        0000

; Used by instruction lists:
;     $C122: door $C86C (yellow door facing down)
;     $C139: door $C86C (yellow door facing down)
$84:A803             dw 0004, 8C31, 8C30, 8830, 8831
                        0000

; Used by instruction lists:
;     $C122: door $C86C (yellow door facing down)
;     $C139: door $C86C (yellow door facing down)
$84:A80F             dw 0004, 8C13, 8C12, 8812, 8813
                        0000

; Used by instruction lists:
;     $C122: door $C86C (yellow door facing down)
;     $C139: door $C86C (yellow door facing down)
$84:A81B             dw 0004, 8C33, 0C32, 0832, 8833
                        0000

; Used by instruction lists:
;     $C185: door $C872 (green door facing left)
;     $C19C: door $C872 (green door facing left)
$84:A827             dw 8004, C004, D024, D824, D804
                        0000

; Used by instruction lists:
;     $C185: door $C872 (green door facing left)
;     $C19C: door $C872 (green door facing left)
$84:A833             dw 8004, 8005, 8025, 8825, 8805
                        0000

; Used by instruction lists:
;     $C185: door $C872 (green door facing left)
;     $C19C: door $C872 (green door facing left)
$84:A83F             dw 8004, 8006, 8026, 8826, 8806
                        0000

; Used by instruction lists:
;     $C185: door $C872 (green door facing left)
;     $C19C: door $C872 (green door facing left)
$84:A84B             dw 8004, 8007, 0027, 0827, 8807
                        0000

; Used by instruction lists:
;     $C1E4: door $C878 (green door facing right)
;     $C1FB: door $C878 (green door facing right)
$84:A857             dw 8004, C404, D424, DC24, DC04
                        0000

; Used by instruction lists:
;     $C1E4: door $C878 (green door facing right)
;     $C1FB: door $C878 (green door facing right)
$84:A863             dw 8004, 8405, 8425, 8C25, 8C05
                        0000

; Used by instruction lists:
;     $C1E4: door $C878 (green door facing right)
;     $C1FB: door $C878 (green door facing right)
$84:A86F             dw 8004, 8406, 8426, 8C26, 8C06
                        0000

; Used by instruction lists:
;     $C1E4: door $C878 (green door facing right)
;     $C1FB: door $C878 (green door facing right)
$84:A87B             dw 8004, 8407, 0427, 0C27, 8C07
                        0000

; Used by instruction lists:
;     $C243: door $C87E (green door facing up)
;     $C25A: door $C87E (green door facing up)
$84:A887             dw 0004, C415, 5414, 5014, 5015
                        0000

; Used by instruction lists:
;     $C243: door $C87E (green door facing up)
;     $C25A: door $C87E (green door facing up)
$84:A893             dw 0004, 8435, 8434, 8034, 8035
                        0000

; Used by instruction lists:
;     $C243: door $C87E (green door facing up)
;     $C25A: door $C87E (green door facing up)
$84:A89F             dw 0004, 8417, 8416, 8016, 8017
                        0000

; Used by instruction lists:
;     $C243: door $C87E (green door facing up)
;     $C25A: door $C87E (green door facing up)
$84:A8AB             dw 0004, 8437, 8436, 8036, 8037
                        0000

; Used by instruction lists:
;     $C2A2: door $C884 (green door facing down)
;     $C2B9: door $C884 (green door facing down)
$84:A8B7             dw 0004, CC15, 5C14, 5814, 5815
                        0000

; Used by instruction lists:
;     $C2A2: door $C884 (green door facing down)
;     $C2B9: door $C884 (green door facing down)
$84:A8C3             dw 0004, 8C35, 8C34, 8834, 8835
                        0000

; Used by instruction lists:
;     $C2A2: door $C884 (green door facing down)
;     $C2B9: door $C884 (green door facing down)
$84:A8CF             dw 0004, 8C17, 8C16, 8816, 8817
                        0000

; Used by instruction lists:
;     $C2A2: door $C884 (green door facing down)
;     $C2B9: door $C884 (green door facing down)
$84:A8DB             dw 0004, 8C37, 8C36, 8836, 8837
                        0000

; Used by instruction lists:
;     $C301: door $C88A (red door facing left)
;     $C318: door $C88A (red door facing left)
$84:A8E7             dw 8004, C008, D028, D828, D808
                        0000

; Used by instruction lists:
;     $C301: door $C88A (red door facing left)
;     $C318: door $C88A (red door facing left)
$84:A8F3             dw 8004, 8009, 8029, 8829, 8809
                        0000

; Used by instruction lists:
;     $C301: door $C88A (red door facing left)
;     $C318: door $C88A (red door facing left)
$84:A8FF             dw 8004, 800A, 802A, 882A, 880A
                        0000

; Used by instruction lists:
;     $C301: door $C88A (red door facing left)
;     $C318: door $C88A (red door facing left)
$84:A90B             dw 8004, 800B, 002B, 082B, 880B
                        0000

; Used by instruction lists:
;     $C363: door $C890 (red door facing right)
;     $C37A: door $C890 (red door facing right)
$84:A917             dw 8004, C408, D428, DC28, DC08
                        0000

; Used by instruction lists:
;     $C363: door $C890 (red door facing right)
;     $C37A: door $C890 (red door facing right)
$84:A923             dw 8004, 8409, 8429, 8C29, 8C09
                        0000

; Used by instruction lists:
;     $C363: door $C890 (red door facing right)
;     $C37A: door $C890 (red door facing right)
$84:A92F             dw 8004, 840A, 842A, 8C2A, 8C0A
                        0000

; Used by instruction lists:
;     $C363: door $C890 (red door facing right)
;     $C37A: door $C890 (red door facing right)
$84:A93B             dw 8004, 840B, 042B, 0C2B, 8C0B
                        0000

; Used by instruction lists:
;     $C3C5: door $C896 (red door facing up)
;     $C3DC: door $C896 (red door facing up)
$84:A947             dw 0004, C419, 5418, 5018, 5019
                        0000

; Used by instruction lists:
;     $C3C5: door $C896 (red door facing up)
;     $C3DC: door $C896 (red door facing up)
$84:A953             dw 0004, 8439, 8438, 8038, 8039
                        0000

; Used by instruction lists:
;     $C3C5: door $C896 (red door facing up)
;     $C3DC: door $C896 (red door facing up)
$84:A95F             dw 0004, 841B, 841A, 801A, 801B
                        0000

; Used by instruction lists:
;     $C3C5: door $C896 (red door facing up)
;     $C3DC: door $C896 (red door facing up)
$84:A96B             dw 0004, 843B, 843A, 803A, 803B
                        0000

; Used by instruction lists:
;     $C427: door $C89C (red door facing down)
;     $C43E: door $C89C (red door facing down)
$84:A977             dw 0004, CC19, 5C18, 5818, 5819
                        0000

; Used by instruction lists:
;     $C427: door $C89C (red door facing down)
;     $C43E: door $C89C (red door facing down)
$84:A983             dw 0004, 8C39, 8C38, 8838, 8839
                        0000

; Used by instruction lists:
;     $C427: door $C89C (red door facing down)
;     $C43E: door $C89C (red door facing down)
$84:A98F             dw 0004, 8C1B, 8C1A, 881A, 881B
                        0000

; Used by instruction lists:
;     $C427: door $C89C (red door facing down)
;     $C43E: door $C89C (red door facing down)
$84:A99B             dw 0004, 8C3B, 8C3A, 883A, 883B
                        0000

; Used by instruction list $D81E: PLM $DB56 (eye door eye, facing left)
$84:A9A7             dw 8004, 800C, D02C, D82C, D80C
                        0000

; Used by instruction lists:
;     $BE70: door $C842 (grey door facing left)
;     $C014: door $C85A (yellow door facing left)
;     $C19C: door $C872 (green door facing left)
;     $C318: door $C88A (red door facing left)
;     $C4B1: closed blue door facing left
$84:A9B3             dw 8004, C00C, D02C, D82C, D80C
                        0000

; Used by instruction lists:
;     $C489: door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left)
;     $C49E: door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left)
$84:A9BF             dw 8004, 800D, 802D, 882D, 880D
                        0000

; Used by instruction lists:
;     $C489: door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left)
;     $C49E: door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left)
$84:A9CB             dw 8004, 800E, 802E, 882E, 880E
                        0000

; Used by instruction lists:
;     $C489: door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left)
;     $C49E: door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left)
$84:A9D7             dw 8004, 800F, 002F, 082F, 880F
                        0000

; Used by instruction list $D955: PLM $DB48 (eye door eye, facing right)
$84:A9E3             dw 8004, 840C, D42C, DC2C, DC0C
                        0000

; Used by instruction lists:
;     $BA7F: PLM $BAF4 (bomb torizo grey door)
;     $BED9: door $C848 (grey door facing right)
;     $C077: door $C860 (yellow door facing right)
;     $C1FB: door $C878 (green door facing right)
;     $C37A: door $C890 (red door facing right)
;     $C4E2: closed blue door facing right
$84:A9EF             dw 8004, C40C, D42C, DC2C, DC0C
                        0000

; Used by instruction lists:
;     $C4BA: door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right)
;     $C4CF: door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right)
$84:A9FB             dw 8004, 840D, 842D, 8C2D, 8C0D
                        0000

; Used by instruction lists:
;     $C4BA: door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right)
;     $C4CF: door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right)
$84:AA07             dw 8004, 840E, 842E, 8C2E, 8C0E
                        0000

; Used by instruction lists:
;     $C4BA: door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right)
;     $C4CF: door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right)
$84:AA13             dw 8004, 840F, 042F, 0C2F, 8C0F
                        0000

; Unused
$84:AA1F             dw 0004, 841D, 541C, 501C, 501D
                        0000

; Used by instruction lists:
;     $BF42: door $C84E (grey door facing up)
;     $C0DA: door $C866 (yellow door facing up)
;     $C25A: door $C87E (green door facing up)
;     $C3DC: door $C896 (red door facing up)
;     $C513: closed blue door facing up
$84:AA2B             dw 0004, C41D, 541C, 501C, 501D
                        0000

; Used by instruction lists:
;     $C4EB: door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up)
;     $C500: door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up)
$84:AA37             dw 0004, 843D, 843C, 803C, 803D
                        0000

; Used by instruction lists:
;     $C4EB: door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up)
;     $C500: door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up)
$84:AA43             dw 0004, 841F, 841E, 801E, 801F
                        0000

; Used by instruction lists:
;     $C4EB: door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up)
;     $C500: door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up)
$84:AA4F             dw 0004, 843F, 843E, 803E, 803F
                        0000

; Unused
$84:AA5B             dw 0004, 8C1D, 5C1C, 581C, 581D
                        0000

; Used by instruction lists:
;     $BFAB: door $C854 (grey door facing down)
;     $C139: door $C86C (yellow door facing down)
;     $C2B9: door $C884 (green door facing down)
;     $C43E: door $C89C (red door facing down)
;     $C544: closed blue door facing down
$84:AA67             dw 0004, CC1D, 5C1C, 581C, 581D
                        0000

; Used by instruction lists:
;     $C51C: door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down)
;     $C531: door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down)
$84:AA73             dw 0004, 8C3D, 8C3C, 883C, 883D
                        0000

; Used by instruction lists:
;     $C51C: door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down)
;     $C531: door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down)
$84:AA7F             dw 0004, 8C1F, 8C1E, 881E, 881F
                        0000

; Used by instruction lists:
;     $C51C: door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down)
;     $C531: door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down)
$84:AA8B             dw 0004, 8C3F, 8C3E, 883E, 883F
                        0000

; Used by instruction list $AFB6: PLM $B70B (elevator platform)
$84:AA97             dx 0001, 8085
                        03, 00
                        0001, 8485
                        00, 01
                        0004, 8088, 8089, 8489, 8488
                        0000

; Used by instruction list $AFB6: PLM $B70B (elevator platform)
$84:AAAF             dx 0001, 8086
                        03, 00
                        0001, 8486
                        00, 01
                        0004, 808A, 808B, 848B, 848A
                        0000

; Used by instruction list $AFB6: PLM $B70B (elevator platform)
$84:AAC7             dx 0001, 8087
                        03, 00
                        0001, 8487
                        00, 01
                        0004, 808C, 808D, 848D, 848C
                        0000
}


;;; $AADF..B049: Instruction lists (mostly) ;;;
{
;;; $AADF: Unused. Instruction list - draw empty tile ;;;
{
$84:AADF             dw 0001,A2B5
}


;;; $AAE3: Instruction list - delete ;;;
{
$84:AAE3             dw 86BC    ; Delete
}


;;; $AAE5: Instruction list - PLM $B773 (crumble access to Tourian elevator) ;;;
{
$84:AAE5             dx 874E,06     ; Timer = 6
$84:AAE8             dw 0004,92A3,
                        0004,92AF,
                        0004,92BB,
                        0004,9297,
                        AB00,       ; Move PLM down one block
                        873F,AAE8,  ; Decrement timer and go to $AAE8 if non-zero
                        86BC        ; Delete
}


;;; $AB00: Instruction - move PLM down one block ;;;
{
; Clone of $8D89
$84:AB00 AD A5 07    LDA $07A5  [$7E:07A5]
$84:AB03 0A          ASL A
$84:AB04 18          CLC
$84:AB05 7D 87 1C    ADC $1C87,x[$7E:1CD3]
$84:AB08 9D 87 1C    STA $1C87,x[$7E:1CD3]
$84:AB0B 60          RTS
}


;;; $AB0C: Instruction list - PLM $B777 (clear access to Tourian elevator) ;;;
{
$84:AB0C             dw 0001,92C7,
                        86BC        ; Delete
}


;;; $AB12: Instruction list - PLM $B78F (crumble Spore Spawn ceiling) ;;;
{
$84:AB12             dx 8C10,0A     ; Queue sound Ah, sound library 2, max queued sounds allowed = 6 (block crumble)
                        0004,9423,
                        0004,9433,
                        0004,9443,
}


;;; $AB21: Instruction list - PLM $B793 (clear Spore Spawn ceiling) ;;;
{
$84:AB21             dw 0004,9413,
                        86BC        ; Delete
}


;;; $AB27: RTS. Setup - PLM $B797 (clear Botwoon wall) ;;;
{
$84:AB27 60          RTS
}


;;; $AB28: Setup - PLM $B79B (crumble Botwoon wall) - wait 40h frames ;;;
{
$84:AB28 BB          TYX                    ;\
$84:AB29 A9 40 00    LDA #$0040             ;} PLM instruction timer = 40h
$84:AB2C 9F 1C DE 7E STA $7EDE1C,x[$7E:DE68];/
$84:AB30 60          RTS
}


;;; $AB31: Instruction list - PLM $B79B (crumble Botwoon wall) ;;;
{
$84:AB31             dx 874E,09,    ; Timer = 9h
                        AB51,       ; Scroll 0..1 = blue
$84:AB36             dx 8C10,0A,    ; Queue sound Ah, sound library 2, max queued sounds allowed = 6 (block crumble)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0004,A357,
                        AB59,       ; Move PLM down one block
                        873F,AB36,  ; Decrement timer and go to $AB36 if non-zero
                        86BC        ; Delete
}


;;; $AB51: Instruction - scroll 0..1 = blue ;;;
{
$84:AB51 A9 01 01    LDA #$0101
$84:AB54 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$84:AB58 60          RTS
}


;;; $AB59: Instruction - move PLM down one block ;;;
{
; Clone of $8D89
$84:AB59 BD 87 1C    LDA $1C87,x[$7E:1CD3]
$84:AB5C 18          CLC
$84:AB5D 6D A5 07    ADC $07A5  [$7E:07A5]
$84:AB60 6D A5 07    ADC $07A5  [$7E:07A5]
$84:AB63 9D 87 1C    STA $1C87,x[$7E:1CD3]
$84:AB66 60          RTS
}


;;; $AB67: Instruction list - PLM $B797 (clear Botwoon wall) ;;;
{
$84:AB67             dw 0001,930F,
                        86BC        ; Delete
}


;;; $AB6D: Instruction list - PLM $B7A3 (crumble Kraid ceiling block into background 1) ;;;
{
$84:AB6D             dw 0003,9367,
                        0003,936D,
                        0003,9373
}


;;; $AB79: Unused. Instruction list - PLM $B79F (set Kraid ceiling block to background 1) ;;;
{
$84:AB79             dw 0003,9379,
                        86BC        ; Delete
}


;;; $AB7F: Instruction list - PLM $B7AB (crumble Kraid ceiling block into background 2) ;;;
{
$84:AB7F             dw 0003,9367,
                        0003,936D,
                        0003,9373
}


;;; $AB8B: Instruction list - PLM $B7A7 (set Kraid ceiling block to background 2) ;;;
{
$84:AB8B             dw 0003,937F,
                        86BC        ; Delete
}


;;; $AB91: Instruction list - PLM $B7B3 (crumble Kraid ceiling block into background 3) ;;;
{
$84:AB91             dw 0003,9367,
                        0003,936D,
                        0003,9373
}


;;; $AB9D: Instruction list - PLM $B7AF (set Kraid ceiling block to background 3) ;;;
{
$84:AB9D             dw 0003,9385,
                        86BC        ; Delete
}


;;; $ABA3: Instruction list - PLM $B7B7 (clear Kraid ceiling) ;;;
{
$84:ABA3             dw 0001,939D,
                        86BC        ; Delete
}


;;; $ABA9: Instruction list - PLM $B7BF (crumble Kraid spike blocks) ;;;
{
$84:ABA9             dx 874E,0B     ; Timer = Bh
$84:ABAC             dw 0003,9367,
                        0003,936D,
                        0003,9373,
                        0003,9391,
                        ABD6,       ; Move PLM right one block
                        0003,9367,
                        0003,936D,
                        0003,9373,
                        0003,9397,
                        ABD6,       ; Move PLM right one block
                        873F,ABAC,  ; Decrement timer and go to $ABAC if non-zero
                        86BC        ; Delete
}


;;; $ABD6: Instruction - move PLM right one block ;;;
{
$84:ABD6 FE 87 1C    INC $1C87,x[$7E:1CD1]
$84:ABD9 FE 87 1C    INC $1C87,x[$7E:1CD1]
$84:ABDC 60          RTS
}


;;; $ABDD: Instruction list - PLM $B7BB (clear Kraid spike blocks) ;;;
{
$84:ABDD             dw 0001,93BF,
                        86BC        ; Delete
}


;;; $ABE3: Unused. Instruction list - PLM $B65F ;;;
{
$84:ABE3             dw 0001,9453,
                        86BC        ; Delete
}


;;; $ABE9: Unused. Instruction list - PLM $B663 ;;;
{
$84:ABE9             dw 0001,9463,
                        86BC        ; Delete
}


;;; $ABEF: Unused. Instruction list - PLM $B667 ;;;
{
$84:ABEF             dw 0018,9473,
$84:ABF3             dw 0001,948B,
                        86BC        ; Delete
}


;;; $ABF9: Unused. Instruction list - PLM $B66B ;;;
{
$84:ABF9             dw 0001,9497,
                        86BC        ; Delete
}


;;; $ABFF: Unused. Instruction list - PLM $B66F ;;;
{
$84:ABFF             dw 0001,949D,
                        86BC        ; Delete
}


;;; $AC05: Instruction list - PLM $B673 (fill Mother Brain's wall) ;;;
{
$84:AC05             dw 0001,94A3,
                        86BC        ; Delete
}


;;; $AC0B: Instruction list - PLM $B677 (Mother Brain's room escape door) ;;;
{
$84:AC0B             dw 0001,94B1,
                        86BC        ; Delete
}


;;; $AC11: Instruction list - PLM $B67B (Mother Brain's background row 2) ;;;
{
$84:AC11             dw 0001,9505,
                        86BC        ; Delete
}


;;; $AC17: Instruction list - PLM $B67F (Mother Brain's background row 3) ;;;
{
$84:AC17             dw 0001,9523,
                        86BC        ; Delete
}


;;; $AC1D: Instruction list - PLM $B683 (Mother Brain's background row 4) ;;;
{
$84:AC1D             dw 0001,9541,
                        86BC        ; Delete
}


;;; $AC23: Instruction list - PLM $B687 (Mother Brain's background row 5) ;;;
{
$84:AC23             dw 0001,955F,
                        86BC        ; Delete
}


;;; $AC29: Instruction list - PLM $B68B (Mother Brain's background row 6) ;;;
{
$84:AC29             dw 0001,957D,
                        86BC        ; Delete
}


;;; $AC2F: Instruction list - PLM $B68F (Mother Brain's background row 7) ;;;
{
$84:AC2F             dw 0001,959B,
                        86BC        ; Delete
}


;;; $AC35: Instruction list - PLM $B693 (Mother Brain's background row 8) ;;;
{
$84:AC35             dw 0001,95B9,
                        86BC        ; Delete
}


;;; $AC3B: Instruction list - PLM $B697 (Mother Brain's background row 9) ;;;
{
$84:AC3B             dw 0001,95D7,
                        86BC        ; Delete
}


;;; $AC41: Instruction list - PLM $B69B (Mother Brain's background row Ah) ;;;
{
$84:AC41             dw 0001,95F5,
                        86BC        ; Delete
}


;;; $AC47: Instruction list - PLM $B69F (Mother Brain's background row Bh) ;;;
{
$84:AC47             dw 0001,9613,
                        86BC        ; Delete
}


;;; $AC4D: Instruction list - PLM $B6A3 (Mother Brain's background row Ch) ;;;
{
$84:AC4D             dw 0001,9631,
                        86BC        ; Delete
}


;;; $AC53: Instruction list - PLM $B6A7 (Mother Brain's background row Dh) ;;;
{
$84:AC53             dw 0001,964F,
                        86BC        ; Delete
}


;;; $AC59: Unused. Instruction list - PLM $B6AB ;;;
{
$84:AC59             dw 0001,966D,
                        86BC        ; Delete
}


;;; $AC5F: Unused. Instruction list - PLM $B6AF ;;;
{
$84:AC5F             dw 0001,968B,
                        86BC        ; Delete
}


;;; $AC65: Instruction list - PLM $B6B3 (clear ceiling block in Mother Brain's room) ;;;
{
$84:AC65             dw 0001,96A9,
                        86BC        ; Delete
}


;;; $AC6B: Instruction list - PLM $B6B7 (clear ceiling tube in Mother Brain's room) ;;;
{
$84:AC6B             dw 0001,96B1,
                        86BC        ; Delete
}


;;; $AC71: Instruction list - PLM $B6BB (clear Mother Brain's bottom-middle-side tube) ;;;
{
$84:AC71             dw 0001,96BF,
                        86BC        ; Delete
}


;;; $AC77: Instruction list - PLM $B6BF (clear Mother Brain's bottom-middle tubes) ;;;
{
$84:AC77             dw 0001,96CB,
                        86BC        ; Delete
}


;;; $AC7D: Instruction list - PLM $B6C3 (clear Mother Brain's bottom-left tube) ;;;
{
$84:AC7D             dw 0001,96EF,
                        86BC        ; Delete
}


;;; $AC83: Instruction list - PLM $B6C7 (clear Mother Brain's bottom-right tube) ;;;
{
$84:AC83             dw 0001,9703,
                        86BC        ; Delete
}


;;; $AC89: Pre-instruction - position Samus and give at least 10h frames of invincibility ;;;
{
; Used for Brinstar plants
$84:AC89 BD 17 1E    LDA $1E17,x[$7E:1E65]  ;\
$84:AC8C 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;} Samus X position = [PLM Samus X position]
$84:AC8F BF 0C DF 7E LDA $7EDF0C,x[$7E:DF5A];\
$84:AC93 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;} Samus Y position = [PLM Samus Y position]
$84:AC96 A9 10 00    LDA #$0010             ;\
$84:AC99 0C A8 18    TSB $18A8  [$7E:18A8]  ;} Samus invincibility timer |= 10h
$84:AC9C 60          RTS
}


;;; $AC9D: Instruction - deal 2 damage to Samus ;;;
{
$84:AC9D AD 4E 0A    LDA $0A4E  [$7E:0A4E]
$84:ACA0 18          CLC
$84:ACA1 69 00 00    ADC #$0000
$84:ACA4 8D 4E 0A    STA $0A4E  [$7E:0A4E]
$84:ACA7 AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$84:ACAA 69 02 00    ADC #$0002             ;} Periodic damage += 2
$84:ACAD 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$84:ACB0 60          RTS
}


;;; $ACB1: Instruction - give Samus 30h frames of invincibility ;;;
{
$84:ACB1 A9 30 00    LDA #$0030             ;\
$84:ACB4 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 30h
$84:ACB7 60          RTS
}


;;; $ACB8: Instruction list - PLM $B6CB (inside reaction, special air, BTS Brinstar 80h. Floor plant) ;;;
{
$84:ACB8             dx 86C1,AC89,  ; Pre-instruction = position Samus and give at least 10h frames of invincibility
                        874E,04     ; Timer = 4
$84:ACBF             dx 0005,9E61,
                        0005,9E45,
                        0005,9E61,
                        8C10,31,    ; Queue sound 31h, sound library 2, max queued sounds allowed = 6 (Brinstar plant chewing)
                        AC9D,       ; Deal 2 damage to Samus
                        0005,9E7D,
                        0005,9E61,
                        0005,9E45,
                        0005,9E61,
                        AC9D,       ; Deal 2 damage to Samus
                        0005,9E7D,
                        873F,ACBF,  ; Decrement timer and go to $ACBF if non-zero
                        ACB1,       ; Give Samus 30h frames of invincibility
                        86CA,       ; Clear pre-instruction
                        0060,9E7D,
                        0001,9E0D,
                        86BC        ; Delete
}


;;; $ACF8: Instruction list - PLM $B6CF (inside reaction, special air, BTS Brinstar 81h. Ceiling plant) ;;;
{
$84:ACF8             dx 86C1,AC89,  ; Pre-instruction = position Samus and give at least 10h frames of invincibility
                        874E,08,    ; Timer = 08h
$84:ACFF             dx 0005,9EED,
                        0005,9ED1,
                        0005,9EED,
                        8C10,31,    ; Queue sound 31h, sound library 2, max queued sounds allowed = 6 (Brinstar plant chewing)
                        AC9D,       ; Deal 2 damage to Samus
                        0005,9F09,
                        0005,9EED,
                        0005,9ED1,
                        0005,9EED,
                        AC9D,       ; Deal 2 damage to Samus
                        0005,9F09,
                        873F,ACFF,  ; Decrement timer and go to $ACFF if non-zero
                        ACB1,       ; Give Samus 30h frames of invincibility
                        86CA,       ; Clear pre-instruction
                        0060,9F09,
                        0001,9E99,
                        86BC        ; Delete
}


;;; $AD38: Instruction list - PLM $B64B (Wrecked Ship entrance treadmill from west) ;;;
{
$84:AD38             dx 880E,01,AD3F,   ; Go to $AD3F if any of the boss bits 01h are set
                        86BC            ; Delete
$84:AD3F             dw AD43,           ; Draw 38h tiles of blank rightwards treadmill
                        86BC            ; Delete
}


;;; $AD43: Instruction - draw 38h tiles of blank rightwards treadmill ;;;
{
$84:AD43 20 D6 82    JSR $82D6  [$84:82D6]
$84:AD46             dw 30FF, 0008, 0038
$84:AD4C 60          RTS
}


;;; $AD4D: Instruction list - PLM $B64F (Wrecked Ship entrance treadmill from east) ;;;
{
$84:AD4D             dx 880E,01,AD54,   ; Go to $AD54 if any of the boss bits 01h are set
                        86BC            ; Delete
$84:AD54             dw AD58,           ; Draw 38h tiles of blank leftwards treadmill
                        86BC            ; Delete
}


;;; $AD58: Instruction - draw 38h tiles of blank leftwards treadmill ;;;
{
$84:AD58 20 D6 82    JSR $82D6  [$84:82D6]
$84:AD5B             dw 30FF, 0009, 0038
$84:AD61 60          RTS
}


;;; $AD62: Instruction list - PLM $B6D3 (map station) ;;;
{
$84:AD62             dx 8A24,AD76,  ; Link instruction = $AD76
$84:AD66             dx 0006,9F25,
                        0006,9F31,
                        0006,9F3D,
                        8724,AD66,  ; Go to $AD66
$84:AD76             dx 0002,9F25,
                        0002,9F31,
                        0002,9F3D,
                        8724,AD76,  ; Go to $AD76
}


;;; $AD86: Instruction list - PLM $B6D7 (collision reaction, special, BTS 47h. Map station right access) ;;;
{
$84:AD86             dx 8C10,37,    ; Queue sound 37h, sound library 2, max queued sounds allowed = 6 (refill/map station engaged)
                        0006,9F49,
                        0060,9F55,
                        8C8F,       ; Activate map station
                        0006,9F55,
                        8C10,38,    ; Queue sound 38h, sound library 2, max queued sounds allowed = 6 (refill/map station disengaged)
                        0006,9F55,
                        0006,9F49,
                        86BC        ; Delete
}


;;; $ADA4: Instruction list - PLM $B6DB (collision reaction, special, BTS 48h. Map station left access) ;;;
{
$84:ADA4             dx 8C10,37,    ; Queue sound 37h, sound library 2, max queued sounds allowed = 6 (refill/map station engaged)
                        0006,9F5B,
                        0060,9F67,
                        8C8F,       ; Activate map station
                        0006,9F67,
                        8C10,38,    ; Queue sound 38h, sound library 2, max queued sounds allowed = 6 (refill/map station disengaged)
                        0006,9F67,
                        0006,9F5B,
                        86BC        ; Delete
}


;;; $ADC2: Instruction list - PLM $B6DF (energy station) ;;;
{
$84:ADC2             dx 8A24,ADD6,  ; Link instruction = $ADD6
$84:ADC6             dx 0006,9F6D,
                        0006,9F79,
                        0006,9F85,
                        8724,ADC6,  ; Go to $ADC6
$84:ADD6             dx AE35,ADED,  ; Go to $ADED and enable movement if Samus health is full
                        874E,10,    ; Timer = 10h
$84:ADDD             dx 0002,9F6D,
                        0002,9F79,
                        0002,9F85,
                        873F,ADDD,  ; Decrement timer and go to $ADDD if non-zero
$84:ADED             dx 8724,ADC2,  ; Go to $ADC2
}


;;; $ADF1: Instruction list - PLM $B6E3 (collision reaction, special, BTS 49h. Energy station right access) ;;;
{
$84:ADF1             dx AE35,AE11,  ; Go to $AE11 and enable movement if Samus health is full
                        8C10,37,    ; Queue sound 37h, sound library 2, max queued sounds allowed = 6 (refill/map station engaged)
                        0006,9FB5,
                        0060,9FBB,
                        8CAF,       ; Activate energy station
                        0006,9FBB,
                        8C10,38,    ; Queue sound 38h, sound library 2, max queued sounds allowed = 6 (refill/map station disengaged)
                        0006,9FBB,
                        0006,9FB5,
$84:AE11             dx 86BC        ; Delete
}


;;; $AE13: Instruction list - PLM $B6E7 (collision reaction, special, BTS 4Ah. Energy station left access) ;;;
{
$84:AE13             dx AE35,AE33,  ; Go to $AE33 and enable movement if Samus health is full
                        8C10,37,    ; Queue sound 37h, sound library 2, max queued sounds allowed = 6 (refill/map station engaged)
                        0006,9FC1,
                        0060,9FC7,
                        8CAF,       ; Activate energy station
                        0006,9FC7,
                        8C10,38,    ; Queue sound 38h, sound library 2, max queued sounds allowed = 6 (refill/map station disengaged)
                        0006,9FC7,
                        0006,9FC1,
$84:AE33             dx 86BC        ; Delete
}


;;; $AE35: Instruction - go to [[Y]] and enable movement if Samus health is full ;;;
{
$84:AE35 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$84:AE38 CD C2 09    CMP $09C2  [$7E:09C2]  ;} If [Samus health] != [Samus max health]:
$84:AE3B F0 03       BEQ $03    [$AE40]     ;/
$84:AE3D C8          INY                    ;\
$84:AE3E C8          INY                    ;} Y += 2
$84:AE3F 60          RTS                    ; Return

$84:AE40 A9 01 00    LDA #$0001             ;\
$84:AE43 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$84:AE47 B9 00 00    LDA $0000,y            ;\
$84:AE4A A8          TAY                    ;} Y = [[Y]]
$84:AE4B 60          RTS
}


;;; $AE4C: Instruction list - PLM $B6EB (missile station) ;;;
{
$84:AE4C             dx 8A24,AE60,  ; Link instruction = $AE60
$84:AE50             dx 0006,9F91,
                        0006,9F9D,
                        0006,9FA9,
                        8724,AE50,  ; Go to $AE50
$84:AE60             dx AEBF,AE77,  ; Go to $AE77 and enable movement if Samus missiles are full
                        874E,10,    ; Timer = 10h
$84:AE67             dx 0003,9F91,
                        0003,9F9D,
                        0003,9FA9,
                        873F,AE67,  ; Decrement timer and go to $AE67 if non-zero
$84:AE77             dx 8724,AE4C,  ; Go to $AE4C
}


;;; $AE7B: Instruction list - PLM $B6EF (collision reaction, special, BTS 4Bh. Missile station right access) ;;;
{
$84:AE7B             dx AEBF,AE9B,  ; Go to $AE9B and enable movement if Samus missiles are full
                        8C10,37,    ; Queue sound 37h, sound library 2, max queued sounds allowed = 6 (refill/map station engaged)
                        0006,9FB5,
                        0060,9FBB,
                        8CD0,       ; Activate missile station
                        0006,9FBB,
                        8C10,38,    ; Queue sound 38h, sound library 2, max queued sounds allowed = 6 (refill/map station disengaged)
                        0006,9FBB,
                        0006,9FB5,
$84:AE9B             dx 86BC        ; Delete
}


;;; $AE9D: Instruction list - PLM $B6F3 (collision reaction, special, BTS 4Ch. Missile station left access) ;;;
{
$84:AE9D             dx AEBF,AEBD,  ; Go to $AEBD and enable movement if Samus missiles are full
                        8C10,37,    ; Queue sound 37h, sound library 2, max queued sounds allowed = 6 (refill/map station engaged)
                        0006,9FC1,
                        0060,9FC7,
                        8CD0,       ; Activate missile station
                        0006,9FC7,
                        8C10,38,    ; Queue sound 38h, sound library 2, max queued sounds allowed = 6 (refill/map station disengaged)
                        0006,9FC7,
                        0006,9FC1,
$84:AEBD             dx 86BC        ; Delete
}


;;; $AEBF: Instruction - go to [[Y]] and enable movement if Samus missiles are full ;;;
{
$84:AEBF AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$84:AEC2 CD C6 09    CMP $09C6  [$7E:09C6]  ;} If [Samus missiles] != [Samus max missiles]:
$84:AEC5 F0 03       BEQ $03    [$AECA]     ;/
$84:AEC7 C8          INY                    ;\
$84:AEC8 C8          INY                    ;} Y += 2
$84:AEC9 60          RTS                    ; Return
                                            
$84:AECA A9 01 00    LDA #$0001             ;\
$84:AECD 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$84:AED1 B9 00 00    LDA $0000,y            ;\
$84:AED4 A8          TAY                    ;} Y = [[Y]]
$84:AED5 60          RTS
}


;;; $AED6: Instruction list - PLM $B6F7 (nothing) ;;;
{
$84:AED6             dw 86BC        ; Delete
$84:AED8             dw 0010,A255,
                        0010,A25D,
                        0010,A265,
                        0010,A26D,
                        0012,A255,
                        0012,A25D,
                        0012,A265,
                        0012,A26D,
                        0014,A255,
                        0014,A25D,
                        0014,A265,
                        0014,A26D,
                        0012,A255,
                        0012,A25D,
                        0012,A265,
                        0012,A26D,
                        8724,AED8   ; Go to $AED8
}


;;; $AF1C: Instruction list - PLM $B6FB (nothing) ;;;
{
$84:AF1C             dw 86BC        ; Delete
$84:AF1E             dw 0010,A275,
                        0010,A285,
                        0010,A295,
                        0010,A2A5,
                        0012,A275,
                        0012,A285,
                        0012,A295,
                        0012,A2A5,
                        0014,A275,
                        0014,A285,
                        0014,A295,
                        0014,A2A5,
                        0012,A275,
                        0012,A285,
                        0012,A295,
                        0012,A2A5,
                        8724,AF1E   ; Go to $AF1E
}


;;; $AF62: Draw instructions ;;;
{
; Used by instruction list $AF86: PLM $B703 (scroll PLM)
$84:AF62             dw 0001,3074,
                        0000

; Used by instruction list $AF92: Unused. PLM $B707 (solid scroll PLM)
$84:AF68             dw 0001,B074,
                        0000

; Used by instruction list $AF9E: PLM $B63F (rightwards extension)
$84:AF6E             dw 0001,5011,
                        0000

; Used by instruction list $AFA4: PLM $B63B (leftwards extension)
$84:AF74             dw 0001,5411,
                        0000

; Used by instruction list $AFAA: PLM $B647 (downwards extension)
$84:AF7A             dw 0001,D800,
                        0000

; Used by instruction list $AFB0: PLM $B643 (upwards extension)
$84:AF80             dw 0001,D000,
                        0000
}


;;; $AF86: Instruction list - PLM $B703 (scroll PLM) ;;;
{
$84:AF86             dx 0001,AF62,
$84:AF8A             dx 86B4,       ; Sleep
                        8B55,       ; Process air scroll update
                        8724,AF8A,  ; Go to $AF8A
}


;;; $AF92: Instruction list - PLM $B707 (solid scroll PLM) ;;;
{
$84:AF92             dx 0001,AF68,
$84:AF96             dx 86B4,       ; Sleep
                        8B93,       ; Process solid scroll update
                        8724,AF96,  ; Go to $AF96
}


;;; $AF9E: Instruction list - PLM $B63F (rightwards extension) ;;;
{
$84:AF9E             dx 0001,AF6E,
                        86BC        ; Delete
}


;;; $AFA4: Instruction list - PLM $B63B (leftwards extension) ;;;
{
$84:AFA4             dx 0001,AF74,
                        86BC        ; Delete
}


;;; $AFAA: Instruction list - PLM $B647 (downwards extension) ;;;
{
$84:AFAA             dx 0001,AF7A,
                        86BC        ; Delete
}


;;; $AFB0: Instruction list - PLM $B643 (upwards extension) ;;;
{
$84:AFB0             dx 0001,AF80,
                        86BC        ; Delete
}


;;; $AFB6: Instruction list - PLM $B70B (elevator platform) ;;;
{
$84:AFB6             dx 0004,AA97,
                        0004,AAAF,
                        0004,AAC7,
                        0004,AAAF,
                        8724,AFB6,  ; Go to $AFB6
}


;;; $AFCA: Instruction list - PLM $B747 (clear Crocomire's bridge) ;;;
{
$84:AFCA             dx 0001,9B5B,
                        86BC        ; Delete
}


;;; $AFD0: Instruction list - PLM $B74B (crumble a block of Crocomire's bridge) ;;;
{
$84:AFD0             dx 0001,9B73,
                        86BC        ; Delete
}


;;; $AFD6: Instruction list - PLM $B74F (clear a block of Crocomire's bridge) ;;;
{
$84:AFD6             dx 0001,9B79,
                        86BC        ; Delete
}


;;; $AFDC: Instruction list - PLM $B753 (clear Crocomire invisible wall) ;;;
{
$84:AFDC             dx 0001,9B7F,
                        86BC        ; Delete
}


;;; $AFE2: Instruction list - PLM $B757 (create Crocomire invisible wall) ;;;
{
$84:AFE2             dx 0001,9BBB,
                        86BC        ; Delete
}


;;; $AFE8: Instruction list - PLM $B76F (save station) ;;;
{
$84:AFE8             dx 0001,9A3F,
                        86B4,       ; Sleep
                        8CF1,B008,  ; Go to $B008 if [save confirmation selection] = no, otherwise activate save station
                        B00E,       ; Place Samus on save station
                        8C07,2E,    ; Queue sound 2Eh, sound library 1, max queued sounds allowed = 6 (saving)
                        874E,15,    ; Timer = 15h
$84:AFFA             dx 0004,9A9F,
                        0004,9A6F,
                        873F,AFFA,  ; Decrement timer and go to $AFFA if non-zero
                        B024,       ; Display game saved message box
$84:B008             dx B030,       ; Enable movement and set save station used
                        8724,AFE8,  ; Go to $AFE8
}


;;; $B00E: Instruction - place Samus on save station ;;;
{
$84:B00E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:B011 18          CLC                    ;|
$84:B012 69 08 00    ADC #$0008             ;} Samus X position = [Samus X position] - [Samus X position] % 10h + 8
$84:B015 29 F0 FF    AND #$FFF0             ;|
$84:B018 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$84:B01B DA          PHX
$84:B01C 5A          PHY
$84:B01D 22 F6 E3 91 JSL $91E3F6[$91:E3F6]  ; Make Samus face forward
$84:B021 7A          PLY
$84:B022 FA          PLX
$84:B023 60          RTS
}


;;; $B024: Instruction - display game saved message box ;;;
{
$84:B024 DA          PHX
$84:B025 5A          PHY
$84:B026 A9 18 00    LDA #$0018             ;\
$84:B029 22 80 80 85 JSL $858080[$85:8080]  ;} Display save completed message box
$84:B02D 7A          PLY
$84:B02E FA          PLX
$84:B02F 60          RTS
}


;;; $B030: Instruction - enable movement and set save station used ;;;
{
$84:B030 A9 01 00    LDA #$0001             ;\
$84:B033 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$84:B037 A9 01 00    LDA #$0001             ;\
$84:B03A 8D 75 1E    STA $1E75  [$7E:1E75]  ;} Save station lockout flag = 1
$84:B03D 60          RTS
}


;;; $B03E: Unused. Instruction list - PLM $B75B (draw 13 blank air tiles) ;;;
{
$84:B03E             dx 0001,9ACF,
                        86BC        ; Delete
}


;;; $B044: Unused. Instruction list - PLM $B75F (draw 13 blank solid tiles) ;;;
{
$84:B044             dx 0001,9AED,
                        86BC        ; Delete
}
}


;;; $B04A..B62E: Setups ;;;
{
;;; $B04A: Setup - PLM $B64B / $B64F (Wrecked Ship entrance treadmill) ;;;
{
; Write 38h blocks of blank air
$84:B04A BE 87 1C    LDX $1C87,y[$7E:1CD5]
$84:B04D A9 FF 00    LDA #$00FF
$84:B050 A0 38 00    LDY #$0038

$84:B053 9F 02 00 7F STA $7F0002,x[$7F:048A]
$84:B057 E8          INX
$84:B058 E8          INX
$84:B059 88          DEY
$84:B05A D0 F7       BNE $F7    [$B053]
$84:B05C 60          RTS
}


;;; $B05D: Unused. Load FX entry, completely broken ;;;
{
; I guess it was supposed to be an optimised wrapper that only loads the FX data if it hasn't already been loaded,
; but it's not even close to functional.
; Wrong bank, almost guaranteed stack corruption and non-sense comparison
$84:B05D 8B          PHB
$84:B05E 48          PHA
$84:B05F F4 00 8F    PEA $8F00              ;\
$84:B062 AB          PLB                    ;} DB = $8F (wrong bank for FX data)
$84:B063 AB          PLB                    ;/
$84:B064 0A          ASL A                  ;\
$84:B065 0A          ASL A                  ;|
$84:B066 0A          ASL A                  ;|
$84:B067 0A          ASL A                  ;} If [A] * 10h = [FX index]: return (doesn't pull A, crashes)
$84:B068 AA          TAX                    ;|
$84:B069 CD 68 19    CMP $1968  [$7E:1968]  ;|
$84:B06C F0 1B       BEQ $1B    [$B089]     ;/
$84:B06E AD 7C 19    LDA $197C  [$7E:197C]  ;\
$84:B071 F0 12       BEQ $12    [$B085]     ;} If [FX Y velocity] = 0: go to BRANCH_ALPHA (doesn't pull, crashes)
$84:B073 AD 78 19    LDA $1978  [$7E:1978]  ;\
$84:B076 30 0D       BMI $0D    [$B085]     ;} If [FX Y base position] < 0: go to BRANCH_ALPHA (doesn't pull, crashes)
$84:B078 98          TYA                    ;\
$84:B079 18          CLC                    ;|
$84:B07A 6D CD 07    ADC $07CD  [$7E:07CD]  ;|
$84:B07D AA          TAX                    ;} If [Y] + [room FX pointer] < [[Y] + [room FX pointer] + 2] (FX Y position): return
$84:B07E DD 02 00    CMP $0002,x            ;} I suppose they forgot to load the FX Y base position back into A, and used Y instead of X?
$84:B081 68          PLA                    ;|
$84:B082 AB          PLB                    ;|
$84:B083 90 04       BCC $04    [$B089]     ;/

; BRANCH_ALPHA
$84:B085 22 02 AB 89 JSL $89AB02[$89:AB02]  ; Load FX entry

$84:B089 18          CLC
$84:B08A 60          RTS
}


;;; $B08B: Unused. Load FX entry 0 if PLM is in leftmost screen column ;;;
{
$84:B08B AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$84:B08E 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$84:B092 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:B095 4A          LSR A                  ;|
$84:B096 4A          LSR A                  ;|
$84:B097 4A          LSR A                  ;} If [screen X block] != [PLM X block]: return
$84:B098 4A          LSR A                  ;|
$84:B099 CD 29 1C    CMP $1C29  [$7E:1C29]  ;|
$84:B09C D0 06       BNE $06    [$B0A4]     ;/
$84:B09E A9 00 00    LDA #$0000             ;\
$84:B0A1 4C 5D B0    JMP $B05D  [$84:B05D]  ;} Load FX entry 0

$84:B0A4 18          CLC
$84:B0A5 60          RTS
}


;;; $B0A6: Unused. Load FX entry 1 if PLM is in leftmost screen column ;;;
{
$84:B0A6 AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$84:B0A9 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$84:B0AD AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:B0B0 4A          LSR A                  ;|
$84:B0B1 4A          LSR A                  ;|
$84:B0B2 4A          LSR A                  ;} If [screen X block] != [PLM X block]: return
$84:B0B3 4A          LSR A                  ;|
$84:B0B4 CD 29 1C    CMP $1C29  [$7E:1C29]  ;|
$84:B0B7 D0 06       BNE $06    [$B0BF]     ;/
$84:B0B9 A9 01 00    LDA #$0001             ;\
$84:B0BC 4C 5D B0    JMP $B05D  [$84:B05D]  ;} Load FX entry 1

$84:B0BF 18          CLC
$84:B0C0 60          RTS
}


;;; $B0C1: Unused. Load FX entry 2 if PLM is in leftmost screen column ;;;
{
$84:B0C1 AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$84:B0C4 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$84:B0C8 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:B0CB 4A          LSR A                  ;|
$84:B0CC 4A          LSR A                  ;|
$84:B0CD 4A          LSR A                  ;} If [screen X block] != [PLM X block]: return
$84:B0CE 4A          LSR A                  ;|
$84:B0CF CD 29 1C    CMP $1C29  [$7E:1C29]  ;|
$84:B0D2 D0 06       BNE $06    [$B0DA]     ;/
$84:B0D4 A9 02 00    LDA #$0002             ;\
$84:B0D7 4C 5D B0    JMP $B05D  [$84:B05D]  ;} Load FX entry 2

$84:B0DA 18          CLC
$84:B0DB 60          RTS
}


;;; $B0DC: Setup - PLM $B6CB (inside reaction, special air, BTS Brinstar 80h. Floor plant) ;;;
{
$84:B0DC AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$84:B0DF 18          CLC                    ;|
$84:B0E0 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$84:B0E3 3A          DEC A                  ;} If Samus bottom boundary is not block aligned:
$84:B0E4 29 0F 00    AND #$000F             ;|
$84:B0E7 C9 0F 00    CMP #$000F             ;|
$84:B0EA F0 08       BEQ $08    [$B0F4]     ;/
$84:B0EC A9 00 00    LDA #$0000             ;\
$84:B0EF 99 37 1C    STA $1C37,y[$7E:1C85]  ;} PLM ID = 0
$84:B0F2 18          CLC
$84:B0F3 60          RTS                    ; Return

$84:B0F4 BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B0F7 BF 02 00 7F LDA $7F0002,x[$7F:0502];|
$84:B0FB 29 FF 8F    AND #$8FFF             ;} Deactivate block
$84:B0FE 9F 02 00 7F STA $7F0002,x[$7F:0502];/
$84:B102 BB          TYX
$84:B103 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:B106 9D 17 1E    STA $1E17,x[$7E:1E65]  ;} PLM Samus X position = [Samus X position]
$84:B109 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$84:B10C 3A          DEC A                  ;} PLM Samus Y position = [Samus Y position] - 1
$84:B10D 9F 0C DF 7E STA $7EDF0C,x[$7E:DF5A];/
$84:B111 18          CLC
$84:B112 60          RTS
}


;;; $B113: Setup - PLM $B6CF (inside reaction, special air, BTS Brinstar 81h. Ceiling plant) ;;;
{
$84:B113 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$84:B116 38          SEC                    ;|
$84:B117 ED 00 0B    SBC $0B00  [$7E:0B00]  ;} If Samus top boundary is not block aligned:
$84:B11A 29 0F 00    AND #$000F             ;|
$84:B11D F0 08       BEQ $08    [$B127]     ;/
$84:B11F A9 00 00    LDA #$0000             ;\
$84:B122 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:B125 18          CLC
$84:B126 60          RTS                    ; Return

$84:B127 BE 87 1C    LDX $1C87,y[$7E:1C87]  ;\
$84:B12A BF 02 00 7F LDA $7F0002,x          ;|
$84:B12E 29 FF 8F    AND #$8FFF             ;} Deactivate block
$84:B131 9F 02 00 7F STA $7F0002,x          ;/
$84:B135 BB          TYX
$84:B136 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:B139 9D 17 1E    STA $1E17,x            ;} PLM Samus X position = [Samus X position]
$84:B13C AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$84:B13F 1A          INC A                  ;} PLM Samus Y position = [Samus Y position] + 1
$84:B140 9F 0C DF 7E STA $7EDF0C,x          ;/
$84:B144 18          CLC
$84:B145 60          RTS
}


;;; $B146: Activate the station at block index [A] if Samus arm cannon is lined up ;;;
{
;; Returns:
;;     Carry: Set
$84:B146 A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$84:B149 DD 87 1C    CMP $1C87,x[$7E:1CD5]  ;\
$84:B14C F0 06       BEQ $06    [$B154]     ;} If [PLM block index] = [A]: go to BRANCH_FOUND
$84:B14E CA          DEX                    ;\
$84:B14F CA          DEX                    ;} X -= 2
$84:B150 10 F7       BPL $F7    [$B149]     ; If [X] >= 0: go to LOOP
$84:B152 80 2F       BRA $2F    [$B183]     ; Go to BRANCH_DELETE

; BRANCH_FOUND
$84:B154 DA          PHX                    ;\
$84:B155 AE 27 1C    LDX $1C27  [$7E:1C27]  ;|
$84:B158 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$84:B15C FA          PLX                    ;/
$84:B15D AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$84:B160 0A          ASL A                  ;|
$84:B161 0A          ASL A                  ;|
$84:B162 0A          ASL A                  ;|
$84:B163 0A          ASL A                  ;} If [PLM Y block] * 10h + Bh != [Samus Y position}: go to BRANCH_DELETE
$84:B164 09 0B 00    ORA #$000B             ;|
$84:B167 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;|
$84:B16A D0 17       BNE $17    [$B183]     ;/
$84:B16C BF BC DE 7E LDA $7EDEBC,x[$7E:DF0A];\
$84:B170 9D 27 1D    STA $1D27,x[$7E:1D75]  ;} PLM instruction list pointer = [PLM link instruction]
$84:B173 A9 01 00    LDA #$0001             ;\    
$84:B176 9F 1C DE 7E STA $7EDE1C,x[$7E:DE6A];} PLM instruction timer = 1
$84:B17A A9 06 00    LDA #$0006             ;\
$84:B17D 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus into recharge station
$84:B181 38          SEC                    ;\
$84:B182 60          RTS                    ;} Return carry set

; BRANCH_DELETE
$84:B183 A9 00 00    LDA #$0000             ;\
$84:B186 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:B189 38          SEC                    ;\
$84:B18A 60          RTS                    ;} Return carry set
}


;;; $B18B: Setup - PLM $B6D3 (map station) ;;;
{
$84:B18B BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B18E BF 02 00 7F LDA $7F0002,x[$7F:0158];|
$84:B192 29 FF 0F    AND #$0FFF             ;} Make PLM block solid
$84:B195 09 00 80    ORA #$8000             ;|
$84:B198 9F 02 00 7F STA $7F0002,x[$7F:0158];/
$84:B19C AE 9F 07    LDX $079F  [$7E:079F]  ;\
$84:B19F BF 08 D9 7E LDA $7ED908,x[$7E:D908];|
$84:B1A3 29 FF 00    AND #$00FF             ;} If not collected current area map:
$84:B1A6 D0 19       BNE $19    [$B1C1]     ;/
$84:B1A8 BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B1AB E8          INX                    ;|
$84:B1AC E8          INX                    ;} Make block to the right a map station right access
$84:B1AD A9 47 B0    LDA #$B047             ;|
$84:B1B0 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:B1B3 BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B1B6 CA          DEX                    ;|
$84:B1B7 CA          DEX                    ;|
$84:B1B8 CA          DEX                    ;} Make block two to the left a map station left access
$84:B1B9 CA          DEX                    ;|
$84:B1BA A9 48 B0    LDA #$B048             ;|
$84:B1BD 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:B1C0 60          RTS                    ; Return

$84:B1C1 A9 76 AD    LDA #$AD76             ;\
$84:B1C4 99 27 1D    STA $1D27,y            ;} PLM instruction list pointer = $AD76
$84:B1C7 60          RTS
}


;;; $B1C8: Setup - PLM $B6D7 (collision reaction, special, BTS 47h. Map station right access) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
$84:B1C8 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:B1CB 29 0F 00    AND #$000F             ;} If [collision direction] = left:
$84:B1CE D0 18       BNE $18    [$B1E8]     ;/
$84:B1D0 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:B1D3 C9 8A 00    CMP #$008A             ;} If [Samus pose] = 8Ah (facing left - ran into a wall):
$84:B1D6 D0 10       BNE $10    [$B1E8]     ;/
$84:B1D8 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$84:B1DB 29 04 00    AND #$0004             ;} If [direction Samus is facing] = left:
$84:B1DE F0 08       BEQ $08    [$B1E8]     ;/
$84:B1E0 B9 87 1C    LDA $1C87,y[$7E:1CD3]  ;\
$84:B1E3 3A          DEC A                  ;|
$84:B1E4 3A          DEC A                  ;} Go to activate the station at the block to the left if arm cannon is lined up
$84:B1E5 4C 46 B1    JMP $B146  [$84:B146]  ;/

$84:B1E8 A9 00 00    LDA #$0000             ;\
$84:B1EB 99 37 1C    STA $1C37,y[$7E:1C83]  ;} PLM ID = 0
$84:B1EE 38          SEC                    ;\
$84:B1EF 60          RTS                    ;} Return carry set
}


;;; $B1F0: Setup - PLM $B6DB (collision reaction, special, BTS 48h. Map station left access) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
$84:B1F0 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:B1F3 29 0F 00    AND #$000F             ;|
$84:B1F6 C9 01 00    CMP #$0001             ;} If [collision direction] = right:
$84:B1F9 D0 1A       BNE $1A    [$B215]     ;/
$84:B1FB AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:B1FE C9 89 00    CMP #$0089             ;} If [Samus pose] = 89h (facing right - ran into a wall):
$84:B201 D0 12       BNE $12    [$B215]     ;/
$84:B203 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$84:B206 29 08 00    AND #$0008             ;} If [direction Samus is facing] = right:
$84:B209 F0 0A       BEQ $0A    [$B215]     ;/
$84:B20B B9 87 1C    LDA $1C87,y[$7E:1CD3]  ;\
$84:B20E 1A          INC A                  ;|
$84:B20F 1A          INC A                  ;|
$84:B210 1A          INC A                  ;} Go to activate the station at the block two to the right if arm cannon is lined up
$84:B211 1A          INC A                  ;|
$84:B212 4C 46 B1    JMP $B146  [$84:B146]  ;/

$84:B215 A9 00 00    LDA #$0000             ;\
$84:B218 99 37 1C    STA $1C37,y[$7E:1C83]  ;} PLM ID = 0
$84:B21B 38          SEC                    ;\
$84:B21C 60          RTS                    ;} Return carry set
}


;;; $B21D: Setup - PLM $B6DF (energy station) ;;;
{
$84:B21D BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B220 BF 02 00 7F LDA $7F0002,x[$7F:014A];|
$84:B224 29 FF 0F    AND #$0FFF             ;} Make PLM block solid
$84:B227 09 00 80    ORA #$8000             ;|
$84:B22A 9F 02 00 7F STA $7F0002,x[$7F:014A];/
$84:B22E BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B231 E8          INX                    ;|
$84:B232 E8          INX                    ;} Make block to the right an energy station right access
$84:B233 A9 49 B0    LDA #$B049             ;|
$84:B236 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:B239 BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B23C CA          DEX                    ;|
$84:B23D CA          DEX                    ;} Make block to the left an energy station left access
$84:B23E A9 4A B0    LDA #$B04A             ;|
$84:B241 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:B244 60          RTS
}


;;; $B245: Setup - PLM $B6EB (missile station) ;;;
{
$84:B245 BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B248 BF 02 00 7F LDA $7F0002,x[$7F:014A];|
$84:B24C 29 FF 0F    AND #$0FFF             ;} Make PLM block solid
$84:B24F 09 00 80    ORA #$8000             ;|
$84:B252 9F 02 00 7F STA $7F0002,x[$7F:014A];/
$84:B256 BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B259 E8          INX                    ;|
$84:B25A E8          INX                    ;} Make block to the right a missile station right access
$84:B25B A9 4B B0    LDA #$B04B             ;|
$84:B25E 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:B261 BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:B264 CA          DEX                    ;|
$84:B265 CA          DEX                    ;} Make block to the left a missile station left access
$84:B266 A9 4C B0    LDA #$B04C             ;|
$84:B269 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:B26C 60          RTS
}


;;; $B26D: Setup - PLM $B6E3 (collision reaction, special, BTS 49h. Energy station right access) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
$84:B26D AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:B270 29 0F 00    AND #$000F             ;} If [collision direction] = left:
$84:B273 D0 20       BNE $20    [$B295]     ;/
$84:B275 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:B278 C9 8A 00    CMP #$008A             ;} If [Samus pose] = 8Ah (facing left - ran into a wall):
$84:B27B D0 18       BNE $18    [$B295]     ;/
$84:B27D AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$84:B280 29 04 00    AND #$0004             ;} If [direction Samus is facing] = left:
$84:B283 F0 10       BEQ $10    [$B295]     ;/
$84:B285 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$84:B288 CD C4 09    CMP $09C4  [$7E:09C4]  ;} If [Samus health] != [Samus max health]:
$84:B28B F0 08       BEQ $08    [$B295]     ;/
$84:B28D B9 87 1C    LDA $1C87,y[$7E:1CD3]  ;\
$84:B290 3A          DEC A                  ;|
$84:B291 3A          DEC A                  ;} Go to activate the station at the block to the left if arm cannon is lined up
$84:B292 4C 46 B1    JMP $B146  [$84:B146]  ;/

$84:B295 A9 00 00    LDA #$0000             ;\
$84:B298 99 37 1C    STA $1C37,y[$7E:1C83]  ;} PLM ID = 0
$84:B29B 38          SEC                    ;\
$84:B29C 60          RTS                    ;} Return carry set
}


;;; $B29D: Setup - PLM $B6E7 (collision reaction, special, BTS 4Ah. Energy station left access) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
$84:B29D AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:B2A0 29 0F 00    AND #$000F             ;|
$84:B2A3 C9 01 00    CMP #$0001             ;} If [collision direction] = right:
$84:B2A6 D0 20       BNE $20    [$B2C8]     ;/
$84:B2A8 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:B2AB C9 89 00    CMP #$0089             ;} If [Samus pose] = 89h (facing right - ran into a wall):
$84:B2AE D0 18       BNE $18    [$B2C8]     ;/
$84:B2B0 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$84:B2B3 29 08 00    AND #$0008             ;} If [direction Samus is facing] = right:
$84:B2B6 F0 10       BEQ $10    [$B2C8]     ;/
$84:B2B8 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$84:B2BB CD C4 09    CMP $09C4  [$7E:09C4]  ;} If [Samus health] != [Samus max health]:
$84:B2BE F0 08       BEQ $08    [$B2C8]     ;/
$84:B2C0 B9 87 1C    LDA $1C87,y[$7E:1CD1]  ;\
$84:B2C3 1A          INC A                  ;|
$84:B2C4 1A          INC A                  ;} Go to activate the station at the block to the right if arm cannon is lined up
$84:B2C5 4C 46 B1    JMP $B146  [$84:B146]  ;/

$84:B2C8 A9 00 00    LDA #$0000             ;\
$84:B2CB 99 37 1C    STA $1C37,y[$7E:1C81]  ;} PLM ID = 0
$84:B2CE 38          SEC                    ;\
$84:B2CF 60          RTS                    ;} Return carry set
}


;;; $B2D0: Setup - PLM $B6EF (collision reaction, special, BTS 4Bh. Missile station right access) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
$84:B2D0 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:B2D3 29 0F 00    AND #$000F             ;} If [collision direction] = left:
$84:B2D6 D0 20       BNE $20    [$B2F8]     ;/
$84:B2D8 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:B2DB C9 8A 00    CMP #$008A             ;} If [Samus pose] = 8Ah (facing left - ran into a wall):
$84:B2DE D0 18       BNE $18    [$B2F8]     ;/
$84:B2E0 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$84:B2E3 29 04 00    AND #$0004             ;} If [direction Samus is facing] = left:
$84:B2E6 F0 10       BEQ $10    [$B2F8]     ;/
$84:B2E8 AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$84:B2EB CD C8 09    CMP $09C8  [$7E:09C8]  ;} If [Samus missiles] != [Samus max missiles]:
$84:B2EE F0 08       BEQ $08    [$B2F8]     ;/
$84:B2F0 B9 87 1C    LDA $1C87,y[$7E:1CD3]  ;\
$84:B2F3 3A          DEC A                  ;|
$84:B2F4 3A          DEC A                  ;} Go to activate the station at the block to the left if arm cannon is lined up
$84:B2F5 4C 46 B1    JMP $B146  [$84:B146]  ;/

$84:B2F8 A9 00 00    LDA #$0000             ;\
$84:B2FB 99 37 1C    STA $1C37,y[$7E:1C83]  ;} PLM ID = 0
$84:B2FE 38          SEC                    ;\
$84:B2FF 60          RTS                    ;} Return carry set
}


;;; $B300: Setup - PLM $B6F3 (collision reaction, special, BTS 4Ch. Missile station left access) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
$84:B300 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:B303 29 0F 00    AND #$000F             ;|
$84:B306 C9 01 00    CMP #$0001             ;} If [collision direction] = right:
$84:B309 D0 20       BNE $20    [$B32B]     ;/
$84:B30B AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:B30E C9 89 00    CMP #$0089             ;} If [Samus pose] = 89h (facing right - ran into a wall):
$84:B311 D0 18       BNE $18    [$B32B]     ;/
$84:B313 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$84:B316 29 08 00    AND #$0008             ;} If [direction Samus is facing] = right:
$84:B319 F0 10       BEQ $10    [$B32B]     ;/
$84:B31B AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$84:B31E CD C8 09    CMP $09C8  [$7E:09C8]  ;} If [Samus missiles] != [Samus max missiles]:
$84:B321 F0 08       BEQ $08    [$B32B]     ;/
$84:B323 B9 87 1C    LDA $1C87,y            ;\
$84:B326 1A          INC A                  ;|
$84:B327 1A          INC A                  ;} Go to activate the station at the block to the right if arm cannon is lined up
$84:B328 4C 46 B1    JMP $B146  [$84:B146]  ;/

$84:B32B A9 00 00    LDA #$0000             ;\
$84:B32E 99 37 1C    STA $1C37,y[$7E:1C81]  ;} PLM ID = 0
$84:B331 38          SEC                    ;\
$84:B332 60          RTS                    ;} Return carry set
}


;;; $B333: Delete PLM ;;;
{
$84:B333 A9 00 00    LDA #$0000
$84:B336 99 37 1C    STA $1C37,y[$7E:1C83]
$84:B339 60          RTS
}


;;; $B33A: Setup - PLM $B63B (rightwards extension) ;;;
{
; Write horizontal extension block with BTS FFh and delete PLM
$84:B33A BE 87 1C    LDX $1C87,y[$7E:1CCF]
$84:B33D A9 FF 50    LDA #$50FF
$84:B340 20 B4 82    JSR $82B4  [$84:82B4]
$84:B343 80 EE       BRA $EE    [$B333]
}


;;; $B345: Setup - PLM $B63F (leftwards extension) ;;;
{
; Write horizontal extension block with BTS 1 and delete PLM
$84:B345 BE 87 1C    LDX $1C87,y[$7E:1CCD]
$84:B348 A9 01 50    LDA #$5001
$84:B34B 20 B4 82    JSR $82B4  [$84:82B4]
$84:B34E 80 E3       BRA $E3    [$B333]
}


;;; $B350: Setup - PLM $B643 (downwards extension) ;;;
{
; Write vertical extension block with BTS FFh and delete PLM
$84:B350 BE 87 1C    LDX $1C87,y[$7E:1CD5]
$84:B353 A9 FF D0    LDA #$D0FF
$84:B356 20 B4 82    JSR $82B4  [$84:82B4]
$84:B359 80 D8       BRA $D8    [$B333]
}


;;; $B35B: Setup - PLM $B647 (upwards extension) ;;;
{
; Write vertical extension block with BTS 1 and delete PLM
$84:B35B BE 87 1C    LDX $1C87,y[$7E:1CD3]
$84:B35E A9 01 D0    LDA #$D001
$84:B361 20 B4 82    JSR $82B4  [$84:82B4]
$84:B364 80 CD       BRA $CD    [$B333]
}


;;; $B366: Skip debug draw instruction for scroll PLMs ;;;
{
$84:B366 B9 27 1D    LDA $1D27,y[$7E:1D75]  ;\
$84:B369 18          CLC                    ;|
$84:B36A 69 04 00    ADC #$0004             ;} PLM instruction list pointer += 4
$84:B36D 99 27 1D    STA $1D27,y[$7E:1D75]  ;/
$84:B370 60          RTS
}


;;; $B371: Setup - PLM $B703 (scroll PLM) ;;;
{
; Write scroll PLM trigger block, set PLM as not triggered and skip debug draw instruction
$84:B371 BE 87 1C    LDX $1C87,y[$7E:1CD5]
$84:B374 A9 46 30    LDA #$3046
$84:B377 20 B4 82    JSR $82B4  [$84:82B4]
$84:B37A A9 00 00    LDA #$0000
$84:B37D 99 17 1E    STA $1E17,y[$7E:1E65]
$84:B380 80 E4       BRA $E4    [$B366]
}


;;; $B382: Setup - PLM $B707 (solid scroll PLM) ;;;
{
; Write solid scroll PLM trigger block, set PLM as not triggered and skip debug draw instruction
$84:B382 BE 87 1C    LDX $1C87,y
$84:B385 A9 46 B0    LDA #$B046
$84:B388 20 B4 82    JSR $82B4  [$84:82B4]
$84:B38B A9 00 00    LDA #$0000
$84:B38E 99 17 1E    STA $1E17,y
$84:B391 80 D3       BRA $D3    [$B366]
}


;;; $B393: Setup - PLM $B6FF (collision reaction, special, BTS 46h / inside reaction, special air, BTS 46h. Scroll block touch PLM) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
$84:B393 BB          TYX                    ;\
$84:B394 BD 87 1C    LDA $1C87,x[$7E:1CBF]  ;} A = [PLM block index]
$84:B397 9E 87 1C    STZ $1C87,x[$7E:1CBF]  ; PLM block index = 0
$84:B39A A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$84:B39D DD 87 1C    CMP $1C87,x[$7E:1CD5]  ;\
$84:B3A0 F0 06       BEQ $06    [$B3A8]     ;} If [PLM block index] = [A]: go to BRANCH_FOUND
$84:B3A2 CA          DEX                    ;\
$84:B3A3 CA          DEX                    ;} X -= 2
$84:B3A4 10 F7       BPL $F7    [$B39D]     ; If [X] >= 0: Go to LOOP

$84:B3A6 80 FE       BRA $FE    [$B3A6]     ; Crash

; BRANCH_FOUND
$84:B3A8 BD 17 1E    LDA $1E17,x[$7E:1E5B]  ;\
$84:B3AB 30 13       BMI $13    [$B3C0]     ;} If PLM has been triggered: return
$84:B3AD A9 00 80    LDA #$8000             ;\
$84:B3B0 9D 17 1E    STA $1E17,x[$7E:1E5B]  ;} Trigger PLM
$84:B3B3 FE 27 1D    INC $1D27,x[$7E:1D6B]  ;\
$84:B3B6 FE 27 1D    INC $1D27,x[$7E:1D6B]  ;} PLM instruction list pointer += 2
$84:B3B9 A9 01 00    LDA #$0001             ;\
$84:B3BC 9F 1C DE 7E STA $7EDE1C,x[$7E:DE60];} PLM instruction timer = 1

$84:B3C0 60          RTS
}


;;; $B3C1: Setup - deactivate PLM ;;;
{
$84:B3C1 BE 87 1C    LDX $1C87,y[$7E:1CBF]
$84:B3C4 BF 02 00 7F LDA $7F0002,x[$7F:045E]
$84:B3C8 29 FF 8F    AND #$8FFF
$84:B3CB 9F 02 00 7F STA $7F0002,x[$7F:045E]
$84:B3CF 60          RTS
}


;;; $B3D0: Clear carry. Setup - PLM $B633 (collision reaction, special, BTS Brinstar 80h/81h) ;;;
{
$84:B3D0 18          CLC
$84:B3D1 60          RTS
}


;;; $B3D2: Unused. Set carry. Setup - PLM $B637 (nothing) ;;;
{
$84:B3D2 38          SEC
$84:B3D3 60          RTS
}


;;; $B3D4: Setup - PLM $D094 (enemy collision reaction, spike block, BTS Fh. Enemy breakable block) ;;;
{
; Make PLM block air
$84:B3D4 BE 87 1C    LDX $1C87,y[$7E:1CD3]
$84:B3D7 BF 02 00 7F LDA $7F0002,x[$7F:03A2]
$84:B3DB 29 FF 0F    AND #$0FFF
$84:B3DE 9F 02 00 7F STA $7F0002,x[$7F:03A2]
$84:B3E2 60          RTS
}


;;; $B3E3: Unused. Setup - PLM $B743 (Torizo drool?) ;;;
{
$84:B3E3 A0 77 A9    LDY #$A977             ;\
$84:B3E6 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn enemy projectile $A977
$84:B3EA 60          RTS
}


;;; $B3EB: Setup - PLM $B70F (inside reaction, special air, BTS Crateria/Debug 80h. Ice physics) ;;;
{
$84:B3EB AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$84:B3EE 18          CLC                    ;|
$84:B3EF 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$84:B3F2 3A          DEC A                  ;|
$84:B3F3 29 0F 00    AND #$000F             ;} If Samus bottom boundary is not half-block aligned: return
$84:B3F6 C9 07 00    CMP #$0007             ;|
$84:B3F9 F0 05       BEQ $05    [$B400]     ;|
$84:B3FB C9 0F 00    CMP #$000F             ;|
$84:B3FE D0 06       BNE $06    [$B406]     ;/

$84:B400 A9 10 00    LDA #$0010             ;\
$84:B403 8D 4C 0B    STA $0B4C  [$7E:0B4C]  ;} Samus X deceleration multiplier = 10h

$84:B406 18          CLC
$84:B407 60          RTS
}


;;; $B408: Setup - PLM $B713 / $B717 / $B71B (inside reaction, special air, BTS Maridia 80h/81h/82h. Quicksand surface) ;;;
{
$84:B408 9C 3C 0B    STZ $0B3C  [$7E:0B3C]  ; Samus running momentum flag = 0
$84:B40B 9C 3E 0B    STZ $0B3E  [$7E:0B3E]  ; Speed boost counter / timer = 0
$84:B40E 9C 40 0B    STZ $0B40  [$7E:0B40]  ; Samus echo sound playing flag = 0
$84:B411 9C 44 0B    STZ $0B44  [$7E:0B44]  ;\
$84:B414 9C 42 0B    STZ $0B42  [$7E:0B42]  ;} Samus X extra run speed = 0.0
$84:B417 A9 00 80    LDA #$8000             ;\
$84:B41A 1C 48 0B    TRB $0B48  [$7E:0B48]  ;} Samus X base subspeed %= 8000h
$84:B41D 9C 46 0B    STZ $0B46  [$7E:0B46]  ; Samus X base speed = 0
$84:B420 A0 00 00    LDY #$0000             ; Y = 0
$84:B423 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$84:B426 89 20 00    BIT #$0020             ;} If gravity suit equipped:
$84:B429 F0 03       BEQ $03    [$B42E]     ;/
$84:B42B A0 02 00    LDY #$0002             ; Y = 2

$84:B42E AD 73 1E    LDA $1E73  [$7E:1E73]  ;\
$84:B431 D0 26       BNE $26    [$B459]     ;} If [inside block reaction Samus point] != bottom: return
$84:B433 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$84:B436 29 03 00    AND #$0003             ;|
$84:B439 0A          ASL A                  ;} Execute [$B43F + [Samus Y direction] * 2]
$84:B43A AA          TAX                    ;|
$84:B43B FC 3F B4    JSR ($B43F,x)[$84:B447];/
$84:B43E 60          RTS

$84:B43F             dw B447, B45A, B47B, B447
}


;;; $B447: Inside reaction - quicksand surface - Samus is grounded ;;;
{
$84:B447 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$84:B44A 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$84:B44D 9C 5A 0B    STZ $0B5A  [$7E:0B5A]  ;\
$84:B450 9C 5C 0B    STZ $0B5C  [$7E:0B5C]  ;|
$84:B453 B9 8F B4    LDA $B48F,y[$84:B491]  ;} Extra Samus Y displacement = [$B48F + [Y]] / 100h
$84:B456 8D 5B 0B    STA $0B5B  [$7E:0B5B]  ;/

$84:B459 60          RTS
}


;;; $B45A: Inside reaction - quicksand surface - Samus is moving up ;;;
{
$84:B45A B9 93 B4    LDA $B493,y[$84:B495]  ;\
$84:B45D CD 2D 0B    CMP $0B2D  [$7E:0B2D]  ;} If [$B493 + [Y]] < [Samus Y speed] / 100h:
$84:B460 B0 0C       BCS $0C    [$B46E]     ;/
$84:B462 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$84:B465 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;|
$84:B468 B9 93 B4    LDA $B493,y[$84:B495]  ;} Samus Y speed = [$B493 + [Y]] / 100h
$84:B46B 8D 2D 0B    STA $0B2D  [$7E:0B2D]  ;/

$84:B46E 9C 5A 0B    STZ $0B5A  [$7E:0B5A]  ;\
$84:B471 9C 5C 0B    STZ $0B5C  [$7E:0B5C]  ;|
$84:B474 B9 8B B4    LDA $B48B,y[$84:B48D]  ;} Extra Samus Y displacement = [$B48B + [Y]] / 100h
$84:B477 8D 5B 0B    STA $0B5B  [$7E:0B5B]  ;/
$84:B47A 60          RTS
}


;;; $B47B: Inside reaction - quicksand surface - Samus is moving down ;;;
{
$84:B47B 9C 5A 0B    STZ $0B5A  [$7E:0B5A]  ;\
$84:B47E 9C 5C 0B    STZ $0B5C  [$7E:0B5C]  ;|
$84:B481 B9 8B B4    LDA $B48B,y[$84:B48D]  ;} Extra Samus Y displacement = [$B48B + [Y]] / 100h
$84:B484 8D 5B 0B    STA $0B5B  [$7E:0B5B]  ;/
$84:B487 9C F4 0A    STZ $0AF4  [$7E:0AF4]  ; Auto-jump timer = 0
$84:B48A 60          RTS
}


;;; $B48B: Quicksand surface inside reaction constants ;;;
{
;                        _________ Without gravity suit
;                       |      ___ With gravity suit
;                       |     |
$84:B48B             dw 0200, 0200  ; Distance to move Samus vertically * 100h in air
$84:B48F             dw 0120, 0100  ; Distance to move Samus vertically * 100h on ground
$84:B493             dw 0280, 0380  ; Samus max vertical velocity * 100h
}


;;; $B497: Setup - PLM $B71F (inside reaction, special air, BTS Maridia 83h. Submerging quicksand) ;;;
{
$84:B497 9C F4 0A    STZ $0AF4  [$7E:0AF4]  ; Auto-jump timer = 0
$84:B49A A9 00 20    LDA #$2000             ;\
$84:B49D 8D 5A 0B    STA $0B5A  [$7E:0B5A]  ;|
$84:B4A0 A9 01 00    LDA #$0001             ;} Extra Samus Y displacement = 1.2000h
$84:B4A3 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/
$84:B4A6 18          CLC
$84:B4A7 60          RTS
}


;;; $B4A8: Setup - PLM $B723 (inside reaction, special air, BTS Maridia 84h. Sand falls - slow) ;;;
{
$84:B4A8 A9 00 40    LDA #$4000             ;\
$84:B4AB 8D 5A 0B    STA $0B5A  [$7E:0B5A]  ;|
$84:B4AE A9 01 00    LDA #$0001             ;} Extra Samus Y displacement = 1.4000h
$84:B4B1 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/
$84:B4B4 18          CLC
$84:B4B5 60          RTS
}


;;; $B4B6: Setup - PLM $B727 (inside reaction, special air, BTS Maridia 85h. Sand falls - fast) ;;;
{
$84:B4B6 A9 00 C0    LDA #$C000             ;\
$84:B4B9 8D 5A 0B    STA $0B5A  [$7E:0B5A]  ;|
$84:B4BC A9 01 00    LDA #$0001             ;} Extra Samus Y displacement = 1.C000h
$84:B4BF 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/
$84:B4C2 18          CLC
$84:B4C3 60          RTS
}


;;; $B4C4: Setup - PLM $B72B / $B72F / $B733 (collision reaction, special, BTS Maridia 80h/81h/82h. Quicksand surface) ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $12.$14: Adjusted distance to move Samus or distance to collision

; Effectively no effect for horizontal collisions

$84:B4C4 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:B4C7 29 02 00    AND #$0002             ;} If collision direction is not vertical:
$84:B4CA D0 02       BNE $02    [$B4CE]     ;/
$84:B4CC 18          CLC                    ;\
$84:B4CD 60          RTS                    ;} Return carry clear

$84:B4CE A0 00 00    LDY #$0000             ; Y = 0
$84:B4D1 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$84:B4D4 89 20 00    BIT #$0020             ;} If gravity suit equipped:
$84:B4D7 F0 03       BEQ $03    [$B4DC]     ;/
$84:B4D9 A0 02 00    LDY #$0002             ; Y = 2

$84:B4DC A6 12       LDX $12    [$7E:0012]  ;\
$84:B4DE A5 14       LDA $14    [$7E:0014]  ;|
$84:B4E0 85 12       STA $12    [$7E:0012]  ;} $14.$12 = [$12].[$14]
$84:B4E2 86 14       STX $14    [$7E:0014]  ;/
$84:B4E4 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$84:B4E7 29 03 00    AND #$0003             ;|
$84:B4EA 0A          ASL A                  ;} Go to [$B4F8 + [Samus Y direction] * 2]
$84:B4EB AA          TAX                    ;|
$84:B4EC FC F8 B4    JSR ($B4F8,x)[$84:B52A];/
$84:B4EF A6 12       LDX $12    [$7E:0012]  ;\
$84:B4F1 A5 14       LDA $14    [$7E:0014]  ;|
$84:B4F3 85 12       STA $12    [$7E:0012]  ;} $12.$14 = [$14].[$12]
$84:B4F5 86 14       STX $14    [$7E:0014]  ;/
$84:B4F7 60          RTS

$84:B4F8             dw B500, B528, B52A, B500
}


;;; $B500: Collision reaction - quicksand surface - Samus is grounded ;;;
{
;; Parameters:
;;     Y: Quicksand surface max sinking speed table index. 0 without gravity suit, 2 with gravity suit
;;     $14.$12: Distance to check for collision
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $14.$12: Adjusted distance to move Samus or distance to collision

$84:B500 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:B503 29 0F 00    AND #$000F             ;|
$84:B506 C9 02 00    CMP #$0002             ;} If [collision direction] = up: return carry clear
$84:B509 F0 1B       BEQ $1B    [$B526]     ;/
$84:B50B C9 03 00    CMP #$0003             ;\
$84:B50E F0 02       BEQ $02    [$B512]     ;} If [collision direction] != down:
$84:B510 80 14       BRA $14    [$B526]     ; Return carry clear

$84:B512 AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$84:B515 C9 01 00    CMP #$0001             ;} If [Samus contact damage index] = speed boosting: go to quicksand speed boosting
$84:B518 F0 1D       BEQ $1D    [$B537]     ;/
$84:B51A B9 3D B5    LDA $B53D,y[$84:B53F]  ;\
$84:B51D C5 13       CMP $13    [$7E:0013]  ;|
$84:B51F B0 02       BCS $02    [$B523]     ;} $14.$12 = min([$14].[$12], 0.3000h)
$84:B521 85 13       STA $13    [$7E:0013]  ;/

$84:B523 EE 71 1E    INC $1E71  [$7E:1E71]  ; Set Samus in in quicksand flag

$84:B526 18          CLC                    ;\
$84:B527 60          RTS                    ;} Return carry clear
}


;;; $B528: Clear carry. Collision reaction - quicksand surface - Samus is moving up ;;;
{
$84:B528 18          CLC
$84:B529 60          RTS
}


;;; $B52A: Collision reaction - quicksand surface - Samus is moving down ;;;
{
;; Parameters:
;;     $14.$12: Distance to check for collision
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $14.$12: Distance to move Samus or distance to collision

$84:B52A AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$84:B52D C9 01 00    CMP #$0001             ;} If [Samus contact damage index] = speed boosting: go to quicksand speed boosting
$84:B530 F0 05       BEQ $05    [$B537]     ;/
$84:B532 EE 71 1E    INC $1E71  [$7E:1E71]  ; Set Samus in in quicksand flag
$84:B535 18          CLC                    ;\
$84:B536 60          RTS                    ;} Return carry clear
}


;;; $B537: Collision reaction - quicksand surface - quicksand speed boosting ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
;;     $14.$12: 0.0. Distance to collision

$84:B537 64 12       STZ $12    [$7E:0012]
$84:B539 64 14       STZ $14    [$7E:0014]
$84:B53B 38          SEC
$84:B53C 60          RTS
}


;;; $B53D: Quicksand surface max sinking speed ;;;
{
;                        _________ Without gravity suit
;                       |      ___ With gravity suit
;                       |     |
$84:B53D             dw 0030, 0030
}


;;; $B541: Setup - PLM $B737 (collision reaction, special, BTS Maridia 83h. Submerging quicksand) ;;;
{
;; Returns:
;;     Carry: Clear. No collision
$84:B541 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$84:B544 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$84:B547 9C 32 0B    STZ $0B32  [$7E:0B32]  ;\
$84:B54A 9C 34 0B    STZ $0B34  [$7E:0B34]  ;} Samus Y acceleration = 0.0
$84:B54D 18          CLC                    ;\
$84:B54E 60          RTS                    ;} Return carry clear
}


;;; $B54F: Clear carry. Setup - PLM $B73B / $B73F (collision reaction, special, BTS Maridia  84h/85h. Sand falls) ;;;
{
$84:B54F 18          CLC
$84:B550 60          RTS
}


;;; $B551: Setup - PLM $B763 (clear Shitroid invisible wall) ;;;
{
; Make the 10-block column below this PLM air
$84:B551 BE 87 1C    LDX $1C87,y[$7E:1CD3]
$84:B554 A0 0A 00    LDY #$000A

$84:B557 BF 02 00 7F LDA $7F0002,x[$7F:01E2]
$84:B55B 29 FF 0F    AND #$0FFF
$84:B55E 9F 02 00 7F STA $7F0002,x[$7F:01E2]
$84:B562 8A          TXA
$84:B563 18          CLC
$84:B564 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B567 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B56A AA          TAX
$84:B56B 88          DEY
$84:B56C D0 E9       BNE $E9    [$B557]
$84:B56E 60          RTS
}


;;; $B56F: Setup - PLM $B767 (create Shitroid invisible wall) ;;;
{
; Make the 10-block column below this PLM solid
$84:B56F BE 87 1C    LDX $1C87,y[$7E:1CD3]
$84:B572 A0 0A 00    LDY #$000A

$84:B575 BF 02 00 7F LDA $7F0002,x[$7F:01E2]
$84:B579 29 FF 0F    AND #$0FFF
$84:B57C 09 00 80    ORA #$8000
$84:B57F 9F 02 00 7F STA $7F0002,x[$7F:01E2]
$84:B583 8A          TXA
$84:B584 18          CLC
$84:B585 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B588 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B58B AA          TAX
$84:B58C 88          DEY
$84:B58D D0 E6       BNE $E6    [$B575]
$84:B58F 60          RTS
}


;;; $B590: Setup - PLM $B76B (collision reaction, special, BTS 4Dh. Save station trigger) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision

; I wrote `[Samus X position] < PLM X position + 18h` below,
; but Samus X position must be less than PLM X position + 10h for the collision to happen in the first place.
; So save stations cruelly require Samus centre to be within the centre-left quarter of the station
$84:B590 AD 92 05    LDA $0592  [$7E:0592]  ;\
$84:B593 D0 57       BNE $57    [$B5EC]     ;} If power bomb explosion is active: return set
$84:B595 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:B598 C9 01 00    CMP #$0001             ;|
$84:B59B F0 05       BEQ $05    [$B5A2]     ;} If Samus current pose is not normally standing: return set
$84:B59D C9 02 00    CMP #$0002             ;|
$84:B5A0 D0 4A       BNE $4A    [$B5EC]     ;/

$84:B5A2 AD 75 1E    LDA $1E75  [$7E:1E75]  ;\
$84:B5A5 D0 45       BNE $45    [$B5EC]     ;} If save station has been used: return set
$84:B5A7 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:B5AA 29 0F 00    AND #$000F             ;|
$84:B5AD C9 03 00    CMP #$0003             ;} If [collision direction] != down: return set
$84:B5B0 D0 3A       BNE $3A    [$B5EC]     ;/
$84:B5B2 BB          TYX                    ;\
$84:B5B3 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$84:B5B7 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:B5BA 38          SEC                    ;|
$84:B5BB E9 08 00    SBC #$0008             ;|
$84:B5BE 4A          LSR A                  ;|
$84:B5BF 4A          LSR A                  ;} If not (PLM X position + 8 <= [Samus X position] < PLM X position + 18h): return set
$84:B5C0 4A          LSR A                  ;|
$84:B5C1 4A          LSR A                  ;|
$84:B5C2 CD 29 1C    CMP $1C29  [$7E:1C29]  ;|
$84:B5C5 D0 25       BNE $25    [$B5EC]     ;/
$84:B5C7 BB          TYX                    ;\
$84:B5C8 BD 87 1C    LDA $1C87,x[$7E:1CD3]  ;} A = [PLM block index]
$84:B5CB 9E 87 1C    STZ $1C87,x[$7E:1CD3]  ; PLM block index = 0
$84:B5CE 9E 37 1C    STZ $1C37,x[$7E:1C83]  ; PLM ID = 0
$84:B5D1 A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$84:B5D4 DD 87 1C    CMP $1C87,x[$7E:1CD5]  ;\
$84:B5D7 F0 06       BEQ $06    [$B5DF]     ;} If [PLM [X] block index] = [A]: go to BRANCH_FOUND
$84:B5D9 CA          DEX                    ;\
$84:B5DA CA          DEX                    ;} X -= 2
$84:B5DB 10 F7       BPL $F7    [$B5D4]     ; If [X] >= 0: Go to LOOP
$84:B5DD 38          SEC                    ;\
$84:B5DE 60          RTS                    ;} Return carry set

; BRANCH_FOUND
$84:B5DF FE 27 1D    INC $1D27,x[$7E:1D75]  ;\
$84:B5E2 FE 27 1D    INC $1D27,x[$7E:1D75]  ;} PLM [X] instruction list pointer += 2
$84:B5E5 A9 01 00    LDA #$0001             ;\
$84:B5E8 9F 1C DE 7E STA $7EDE1C,x[$7E:DE6A];} PLM [X] instruction timer = 1

$84:B5EC 38          SEC                    ;\
$84:B5ED 60          RTS                    ;} Return carry set
}


;;; $B5EE: Setup - PLM $B76F (save station) ;;;
{
; Make PLM block a save station trigger
$84:B5EE BE 87 1C    LDX $1C87,y[$7E:1CD5]
$84:B5F1 A9 4D B0    LDA #$B04D
$84:B5F4 20 B4 82    JSR $82B4  [$84:82B4]
$84:B5F7 60          RTS
}


;;; $B5F8: Setup - PLM $B677 (Mother Brain's room escape door) ;;;
{
; Make PLM block a door block with BTS 1, extended downwards by 3 blocks
$84:B5F8 BE 87 1C    LDX $1C87,y[$7E:1CD5]
$84:B5FB A9 01 90    LDA #$9001
$84:B5FE 20 B4 82    JSR $82B4  [$84:82B4]
$84:B601 8A          TXA
$84:B602 18          CLC
$84:B603 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B606 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B609 AA          TAX
$84:B60A A9 FF D0    LDA #$D0FF
$84:B60D 20 B4 82    JSR $82B4  [$84:82B4]
$84:B610 8A          TXA
$84:B611 18          CLC
$84:B612 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B615 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B618 AA          TAX
$84:B619 A9 FF D0    LDA #$D0FF
$84:B61C 20 B4 82    JSR $82B4  [$84:82B4]
$84:B61F 8A          TXA
$84:B620 18          CLC
$84:B621 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B624 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B627 AA          TAX
$84:B628 A9 FF D0    LDA #$D0FF
$84:B62B 20 B4 82    JSR $82B4  [$84:82B4]
$84:B62E 60          RTS
}
}


;;; $B62F..B7C2: PLM entries ;;;
{
$84:B62F             dw B3CF,AAE3   ; Nothing
$84:B633             dw B3D0,AAE3   ; Collision reaction, special, BTS Brinstar 80h/81h. Clear carry
$84:B637             dw B3D2,AAE3   ; Unused. Set carry
$84:B63B             dw B33A,AFA4   ; Rightwards extension
$84:B63F             dw B345,AF9E   ; Leftwards extension
$84:B643             dw B350,AFB0   ; Downwards extension
$84:B647             dw B35B,AFAA   ; Upwards extension
$84:B64B             dw B04A,AD38   ; Wrecked Ship entrance treadmill from west
$84:B64F             dw B04A,AD4D   ; Wrecked Ship entrance treadmill from east
$84:B653             dw B3CF,AAE3   ; Inside reaction, special air, BTS Norfair 80h. Nothing
$84:B657             dw B3CF,AAE3   ; Inside reaction, special air, BTS Norfair 81h. Nothing
$84:B65B             dw B3CF,AAE3   ; Inside reaction, special air, BTS Norfair 82h. Nothing
$84:B65F             dw B3C1,ABE3   ; Unused
$84:B663             dw B3C1,ABE9   ; Unused
$84:B667             dw B3C1,ABEF   ; Unused
$84:B66B             dw B3C1,ABF9   ; Unused
$84:B66F             dw B3C1,ABFF   ; Unused
$84:B673             dw B3C1,AC05   ; Fill Mother Brain's wall
$84:B677             dw B5F8,AC0B   ; Mother Brain's room escape door
$84:B67B             dw B3C1,AC11   ; Mother Brain's background row 2
$84:B67F             dw B3C1,AC17   ; Mother Brain's background row 3
$84:B683             dw B3C1,AC1D   ; Mother Brain's background row 4
$84:B687             dw B3C1,AC23   ; Mother Brain's background row 5
$84:B68B             dw B3C1,AC29   ; Mother Brain's background row 6
$84:B68F             dw B3C1,AC2F   ; Mother Brain's background row 7
$84:B693             dw B3C1,AC35   ; Mother Brain's background row 8
$84:B697             dw B3C1,AC3B   ; Mother Brain's background row 9
$84:B69B             dw B3C1,AC41   ; Mother Brain's background row Ah
$84:B69F             dw B3C1,AC47   ; Mother Brain's background row Bh
$84:B6A3             dw B3C1,AC4D   ; Mother Brain's background row Ch
$84:B6A7             dw B3C1,AC53   ; Mother Brain's background row Dh
$84:B6AB             dw B3C1,AC59   ; Unused
$84:B6AF             dw B3C1,AC5F   ; Unused
$84:B6B3             dw B3C1,AC65   ; Clear ceiling block in Mother Brain's room
$84:B6B7             dw B3C1,AC6B   ; Clear ceiling tube in Mother Brain's room
$84:B6BB             dw B3C1,AC71   ; Clear Mother Brain's bottom-middle-side tube
$84:B6BF             dw B3C1,AC77   ; Clear Mother Brain's bottom-middle tubes
$84:B6C3             dw B3C1,AC7D   ; Clear Mother Brain's bottom-left tube
$84:B6C7             dw B3C1,AC83   ; Clear Mother Brain's bottom-right tube
$84:B6CB             dw B0DC,ACB8   ; Inside reaction, special air, BTS Brinstar 80h. Floor plant
$84:B6CF             dw B113,ACF8   ; Inside reaction, special air, BTS Brinstar 81h. Ceiling plant
$84:B6D3             dw B18B,AD62   ; Map station
$84:B6D7             dw B1C8,AD86   ; Collision reaction, special, BTS 47h. Map station right access
$84:B6DB             dw B1F0,ADA4   ; Collision reaction, special, BTS 48h. Map station left access
$84:B6DF             dw B21D,ADC2   ; Energy station
$84:B6E3             dw B26D,ADF1   ; Collision reaction, special, BTS 49h. Energy station right access
$84:B6E7             dw B29D,AE13   ; Collision reaction, special, BTS 4Ah. Energy station left access
$84:B6EB             dw B245,AE4C   ; Missile station
$84:B6EF             dw B2D0,AE7B   ; Collision reaction, special, BTS 4Bh. Missile station right access
$84:B6F3             dw B300,AE9D   ; Collision reaction, special, BTS 4Ch. Missile station left access
$84:B6F7             dw B3C1,AED6   ; Nothing
$84:B6FB             dw B3C1,AF1C   ; Nothing
$84:B6FF             dw B393,AAE3   ; Collision reaction, special, BTS 46h / inside reaction, special air, BTS 46h. Scroll PLM trigger
$84:B703             dw B371,AF86   ; Scroll PLM
$84:B707             dw B382,AF92   ; Unused. Solid scroll PLM
$84:B70B             dw B3C1,AFB6   ; Elevator platform
$84:B70F             dw B3EB,AAE3   ; Inside reaction, special air, BTS Crateria/Debug 80h
$84:B713             dw B408,AAE3   ; Inside reaction, special air, BTS Maridia 80h/81h/82h. Quicksand surface
$84:B717             dw B408,AAE3   ; Unused. Clone of PLM B713
$84:B71B             dw B408,AAE3   ; Unused. Clone of PLM B713
$84:B71F             dw B497,AAE3   ; Inside reaction, special air, BTS Maridia 83h. Submerging quicksand
$84:B723             dw B4A8,AAE3   ; Inside reaction, special air, BTS Maridia 84h. Sand falls - slow
$84:B727             dw B4B6,AAE3   ; Inside reaction, special air, BTS Maridia 85h. Sand falls - fast
$84:B72B             dw B4C4,AAE3   ; Collision reaction, special, BTS Maridia 80h/81h/82h. Quicksand surface
$84:B72F             dw B4C4,AAE3   ; Unused
$84:B733             dw B4C4,AAE3   ; Unused
$84:B737             dw B541,AAE3   ; Collision reaction, special, BTS Maridia 83h. Submerging quicksand
$84:B73B             dw B54F,AAE3   ; Collision reaction, special, BTS Maridia 84h. Sand falls - slow
$84:B73F             dw B54F,AAE3   ; Collision reaction, special, BTS Maridia 85h. Sand falls - fast
$84:B743             dw B3E3,AAE3   ; Unused. Torizo drool?
$84:B747             dw B3C1,AFCA   ; Clear Crocomire's bridge
$84:B74B             dw B3C1,AFD0   ; Crumble a block of Crocomire's bridge
$84:B74F             dw B3C1,AFD6   ; Clear a block of Crocomire's bridge
$84:B753             dw B3C1,AFDC   ; Clear Crocomire invisible wall
$84:B757             dw B3C1,AFE2   ; Create Crocomire invisible wall
$84:B75B             dw B3CF,B03E   ; Unused. Draw 13 blank air tiles
$84:B75F             dw B3CF,B044   ; Unused. Draw 13 blank solid tiles
$84:B763             dw B551,AAE3   ; Clear Shitroid invisible wall
$84:B767             dw B56F,AAE3   ; Create Shitroid invisible wall
$84:B76B             dw B590,AAE3   ; Collision reaction, special, BTS 4Dh. Save station trigger
$84:B76F             dw B5EE,AFE8   ; Save station
$84:B773             dw B3C1,AAE5   ; Crumble access to Tourian elevator
$84:B777             dw B3C1,AB0C   ; Clear access to Tourian elevator


;;; $B77B: Instruction list - PLM $B781 (draw Phantoon's door during boss fight) ;;;
{
$84:B77B             dx 0001,93EF,
                        86BC        ; Delete
}


$84:B781             dw B3C1,B77B   ; Draw Phantoon's door during boss fight


;;; $B785: Instruction list - PLM $B78B (restore Phantoon's door after boss fight) ;;;
{
$84:B785             dx 0001,9407,
                        86BC        ; Delete
}


$84:B78B             dw B3C1,B785   ; Restore Phantoon's door after boss fight
$84:B78F             dw B3C1,AB12   ; Crumble Spore Spawn ceiling
$84:B793             dw B3C1,AB21   ; Clear Spore Spawn ceiling
$84:B797             dw AB27,AB67   ; Clear Botwoon wall
$84:B79B             dw AB28,AB31   ; Crumble Botwoon wall
$84:B79F             dw B3C1,AB79   ; Unused. Set Kraid ceiling block to background 1
$84:B7A3             dw B3C1,AB6D   ; Crumble Kraid ceiling block into background 1
$84:B7A7             dw B3C1,AB8B   ; Set Kraid ceiling block to background 2
$84:B7AB             dw B3C1,AB7F   ; Crumble Kraid ceiling block into background 2
$84:B7AF             dw B3C1,AB9D   ; Set Kraid ceiling block to background 3
$84:B7B3             dw B3C1,AB91   ; Crumble Kraid ceiling block into background 3
$84:B7B7             dw B3C1,ABA3   ; Clear Kraid ceiling blocks
$84:B7BB             dw B3C1,ABDD   ; Clear Kraid spike blocks
$84:B7BF             dw B3C1,ABA9   ; Crumble Kraid spike blocks
}


;;; $B7C3..BC12: Misc. ;;;
{
;;; $B7C3: Setup - PLM $B7EB (enable sounds in 20h frames, or F0h frames if on Ceres) ;;;
{
$84:B7C3 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$84:B7C6 C9 06 00    CMP #$0006             ;} If [area index] = Ceres:
$84:B7C9 D0 05       BNE $05    [$B7D0]     ;/
$84:B7CB A9 20 00    LDA #$0020             ; A = 20h
$84:B7CE 80 03       BRA $03    [$B7D3]
                                            ; Else ([area index] != Ceres):
$84:B7D0 A9 F0 00    LDA #$00F0             ; A = F0h

$84:B7D3 99 77 1D    STA $1D77,y[$7E:1DC5]  ; PLM timer = F0h
$84:B7D6 A9 DD B7    LDA #$B7DD             ;\
$84:B7D9 99 D7 1C    STA $1CD7,y[$7E:1D25]  ;} PLM pre-instruction = decrement timer, enable sounds and delete PLM if zero
$84:B7DC 60          RTS
}


;;; $B7DD: Pre-instruction - decrement timer, enable sounds and delete PLM if zero ;;;
{
; Used by PLM $B7EB (enable sounds in 20h frames, or F0h frames if on Ceres)
$84:B7DD DE 77 1D    DEC $1D77,x[$7E:1DC5]  ; Decrement PLM timer
$84:B7E0 D0 06       BNE $06    [$B7E8]     ; If [PLM timer] = 0:
$84:B7E2 9C F5 05    STZ $05F5  [$7E:05F5]  ; Enable sounds
$84:B7E5 9E 37 1C    STZ $1C37,x[$7E:1C85]  ; PLM ID = 0

$84:B7E8 60          RTS
}


;;; $B7E9: Instruction list - PLM $B7EB (enable sounds in 20h frames, or F0h frames if on Ceres) ;;;
{
$84:B7E9             dw 86B4        ; Sleep
}


;;; $B7EB: PLM entry - enable sounds in 20h frames, or F0h frames if on Ceres ;;;
{
$84:B7EB             dw B7C3,B7E9
}


;;; $B7EF: Pre-instruction - wake PLM and start lavaquake if speed booster collected ;;;
{
; Used by PLM $B8AC (speed booster escape)
$84:B7EF AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$84:B7F2 29 00 20    AND #$2000             ;} If Samus has not collected speed booster:
$84:B7F5 D0 13       BNE $13    [$B80A]     ;/
$84:B7F7 A9 FF FF    LDA #$FFFF             ;\
$84:B7FA 8D 7A 19    STA $197A  [$7E:197A]  ;} FX target Y position = FFFFh
$84:B7FD 9C 7C 19    STZ $197C  [$7E:197C]  ; FX Y velocity = 0
$84:B800 9C 80 19    STZ $1980  [$7E:1980]  ; FX timer = 0
$84:B803 9C 40 18    STZ $1840  [$7E:1840]  ; Screen shaking duration = 0
$84:B806 9E 37 1C    STZ $1C37,x[$7E:1C85]  ; PLM ID = 0
$84:B809 60          RTS                    ; Return

$84:B80A AD 7A 19    LDA $197A  [$7E:197A]  ;\
$84:B80D 30 17       BMI $17    [$B826]     ;} If [FX target Y position] >= 0:
$84:B80F A9 80 FF    LDA #$FF80             ;\
$84:B812 8D 7C 19    STA $197C  [$7E:197C]  ;} FX Y velocity = -80h
$84:B815 A9 01 00    LDA #$0001             ;\
$84:B818 9F 1C DE 7E STA $7EDE1C,x[$7E:DE6A];} PLM instruction timer = 1
$84:B81C FE 27 1D    INC $1D27,x[$7E:1D75]  ;\
$84:B81F FE 27 1D    INC $1D27,x[$7E:1D75]  ;} PLM instruction list pointer += 2
$84:B822 9E 77 1D    STZ $1D77,x[$7E:1DC5]  ; PLM timer = 0
$84:B825 60          RTS                    ; Return

$84:B826 9E 37 1C    STZ $1C37,x            ; PLM ID = 0
$84:B829 60          RTS
}


;;; $B82A: Pre-instruction - wake PLM and start FX motion if Samus is far enough left ;;;
{
; Used by PLM $B8AC (speed booster escape)
$84:B82A A9 E0 0A    LDA #$0AE0             ;\
$84:B82D CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;} If [Samus X position] <= AE0h:
$84:B830 90 13       BCC $13    [$B845]     ;/
$84:B832 A9 01 00    LDA #$0001             ;\
$84:B835 8D 80 19    STA $1980  [$7E:1980]  ;} FX timer = 1
$84:B838 9F 1C DE 7E STA $7EDE1C,x[$7E:DE6A]; PLM instruction timer = 1
$84:B83C FE 27 1D    INC $1D27,x[$7E:1D75]  ;\
$84:B83F FE 27 1D    INC $1D27,x[$7E:1D75]  ;} PLM instruction list pointer += 2
$84:B842 9E 77 1D    STZ $1D77,x[$7E:1DC5]  ; PLM timer = 0

$84:B845 60          RTS
}


;;; $B846: Pre-instruction - advance lava as Samus moves left, set speed booster lavaquake event when done ;;;
{
; Used by PLM $B8AC (speed booster escape)
$84:B846 BD 77 1D    LDA $1D77,x[$7E:1DC5]  ;\
$84:B849 A8          TAY                    ;|
$84:B84A B9 76 B8    LDA $B876,y[$84:B876]  ;} If [$B876 + [PLM timer]] < 0: go to BRANCH_DONE
$84:B84D 30 1F       BMI $1F    [$B86E]     ;/
$84:B84F CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;\
$84:B852 90 19       BCC $19    [$B86D]     ;} If [$B876 + [PLM timer]] < [Samus X position]: return
$84:B854 B9 78 B8    LDA $B878,y[$84:B878]  ;\
$84:B857 CD 78 19    CMP $1978  [$7E:1978]  ;|
$84:B85A B0 03       BCS $03    [$B85F]     ;} FX Y position = min([FX Y position], [$B878 + [PLM timer]])
$84:B85C 8D 78 19    STA $1978  [$7E:1978]  ;/

$84:B85F B9 7A B8    LDA $B87A,y[$84:B87A]  ;\
$84:B862 8D 7C 19    STA $197C  [$7E:197C]  ;} FX Y velocity = [$B87A + [PLM timer]]
$84:B865 98          TYA                    ;\
$84:B866 18          CLC                    ;|
$84:B867 69 06 00    ADC #$0006             ;} PLM timer += 6
$84:B86A 9D 77 1D    STA $1D77,x[$7E:1DC5]  ;/

$84:B86D 60          RTS                    ; Return

; BRANCH_DONE
$84:B86E A9 15 00    LDA #$0015             ;\
$84:B871 22 FA 81 80 JSL $8081FA[$80:81FA]  ;} Set speed booster lavaquake event
$84:B875 60          RTS

;                        _____________ Target Samus X position
;                       |     ________ Maximum FX Y position
;                       |    |     ___ FX Y velocity
;                       |    |    |
$84:B876             dw 072B,01BF,FF50,
                        050A,0167,FF20,
                        0244,0100,FF20,
                        8000
}


;;; $B88A: Instruction list - PLM $B8AC (speed booster escape) ;;;
{
$84:B88A             dx 86C1,B7EF,  ; Pre-instruction = wake PLM and start lavaquake if speed booster collected
                        86B4,       ; Sleep
                        86C1,B82A,  ; Pre-instruction = wake PLM and start FX motion if Samus is far enough left
                        86B4,       ; Sleep
                        86C1,B846,  ; Pre-instruction = advance lava as Samus moves left, set speed booster lavaquake event when done
                        86B4        ; Sleep
}


;;; $B89C: Setup - PLM $B8AC (speed booster escape) ;;;
{
$84:B89C A9 15 00    LDA #$0015             ;\
$84:B89F 22 33 82 80 JSL $808233[$80:8233]  ;} If speed booster lavaquake event is set:
$84:B8A3 90 06       BCC $06    [$B8AB]     ;/
$84:B8A5 A9 00 00    LDA #$0000             ;\
$84:B8A8 99 37 1C    STA $1C37,y            ;} PLM ID = 0

$84:B8AB 60          RTS
}


;;; $B8AC: PLM entry - speed booster escape ;;;
{
$84:B8AC             dw B89C,B88A
}


;;; $B8B0: Pre-instruction - Shaktool's room ;;;
{
; Used by PLM $B8EB (Shaktool's room)
$84:B8B0 AD 92 05    LDA $0592  [$7E:0592]  ;\
$84:B8B3 F0 0E       BEQ $0E    [$B8C3]     ;} If power bomb explosion is active:
$84:B8B5 A9 01 01    LDA #$0101             ;\
$84:B8B8 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;|
$84:B8BC A9 01 01    LDA #$0101             ;} Scroll 0..3 = blue
$84:B8BF 8F 22 CD 7E STA $7ECD22[$7E:CD22]  ;/

$84:B8C3 A9 48 03    LDA #$0348             ;\
$84:B8C6 CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;} If [Samus X position] <= 348h: return
$84:B8C9 B0 0A       BCS $0A    [$B8D5]     ;/
$84:B8CB A9 0D 00    LDA #$000D             ;\
$84:B8CE 22 FA 81 80 JSL $8081FA[$80:81FA]  ;} Set Shaktool event
$84:B8D2 9E 37 1C    STZ $1C37,x[$7E:1C85]  ; PLM ID = 0

$84:B8D5 60          RTS
}


;;; $B8D6: Instruction list - PLM $B8EB (Shaktool's room) ;;;
{
$84:B8D6             dx 86C1,B8B0,  ; Pre-instruction = Shaktool's room
                        86B4        ; Sleep
}


;;; $B8DC: Setup - PLM $B8EB (Shaktool's room) ;;;
{
; Scroll 0 = blue, 1..3 = red
$84:B8DC A9 01 00    LDA #$0001
$84:B8DF 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$84:B8E3 A9 00 00    LDA #$0000
$84:B8E6 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$84:B8EA 60          RTS
}


;;; $B8EB: PLM entry - Shaktool's room ;;;
{
$84:B8EB             dw B8DC,B8D6
}


;;; $B8EF: Setup - PLM $B8F9 (Maridia elevatube) ;;;
{
$84:B8EF 60          RTS
}


;;; $B8F0: Instruction list - PLM $B8F9 (Maridia elevatube) ;;;
{
; The draw instruction is just some garbage block, it only exists to create a 10h frame delay (this PLM is created at (1, 0) so is hidden by the HUD)
; I have no idea what sound effect this is
$84:B8F0             dx 0010,9367,
                        8C10,15,    ; Queue sound 15h, sound library 2, max queued sounds allowed = 6 (Maridia elevatube)
                        86BC        ; Delete
}


;;; $B8F9: PLM entry - Maridia elevatube ;;;
{
; This PLM effectively does nothing
$84:B8F9             dw B8EF,B8F0
}


;;; $B8FD: Wake PLM if Samus is below and right of target position ;;;
{
;; Parameters:
;;     $12: Target X position
;;     $14: Target Y position
$84:B8FD A5 12       LDA $12    [$7E:0012]  ;\
$84:B8FF CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;} If [$12] >= [Samus X position]: return
$84:B902 B0 14       BCS $14    [$B918]     ;/
$84:B904 A5 14       LDA $14    [$7E:0014]  ;\
$84:B906 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;} If [$14] >= [Samus Y position]: return
$84:B909 B0 0D       BCS $0D    [$B918]     ;/
$84:B90B FE 27 1D    INC $1D27,x[$7E:1D71]  ;\
$84:B90E FE 27 1D    INC $1D27,x[$7E:1D71]  ;} PLM instruction list pointer += 2
$84:B911 A9 01 00    LDA #$0001             ;\
$84:B914 9F 1C DE 7E STA $7EDE1C,x[$7E:DE66];} PLM instruction timer = 1

$84:B918 60          RTS
}


;;; $B919: Instruction list - PLM $B964 (make old Tourian escape shaft fake wall explode) ;;;
{
$84:B919             dx 86C1,B927,  ; Pre-instruction = old Tourian escape shaft escape
                        86B4,       ; Sleep
                        86CA,       ; Clear pre-instruction
                        0001,9283,
                        86BC        ; Delete
}


;;; $B927: Pre-instruction - make old Tourian escape shaft fake wall explode ;;;
{
$84:B927 A9 F0 00    LDA #$00F0             ;\
$84:B92A 85 12       STA $12    [$7E:0012]  ;|
$84:B92C A9 20 08    LDA #$0820             ;|
$84:B92F 85 14       STA $14    [$7E:0014]  ;} If Samus is below and right of (F0h, 820h): wake PLM, else return
$84:B931 20 FD B8    JSR $B8FD  [$84:B8FD]  ;|
$84:B934 B0 09       BCS $09    [$B93F]     ;/
$84:B936 5A          PHY                    ;\
$84:B937 A0 B1 B4    LDY #$B4B1             ;|
$84:B93A 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn old Tourian escape shaft fake wall explosion enemy projectile
$84:B93E 7A          PLY                    ;/

$84:B93F 60          RTS
}


;;; $B940: Instruction list - PLM $B968 (raise acid in escape room before old Tourian escape shaft) ;;;
{
$84:B940             dx 86C1,B948,  ; Pre-instruction = raise acid in escape room before old Tourian escape shaft
                        86B4,       ; Sleep
                        86BC        ; Delete
}


;;; $B948: Pre-instruction - raise acid in escape room before old Tourian escape shaft ;;;
{
$84:B948 A9 F0 00    LDA #$00F0             ;\
$84:B94B 85 12       STA $12    [$7E:0012]  ;|
$84:B94D A9 40 05    LDA #$0540             ;|
$84:B950 85 14       STA $14    [$7E:0014]  ;} If Samus is below and right of (F0h, 540h): wake PLM, else return
$84:B952 20 FD B8    JSR $B8FD  [$84:B8FD]  ;|
$84:B955 B0 0C       BCS $0C    [$B963]     ;/
$84:B957 A9 98 FF    LDA #$FF98             ;\
$84:B95A 8D 7C 19    STA $197C  [$7E:197C]  ;} FX Y velocity = -68h
$84:B95D A9 10 00    LDA #$0010             ;\
$84:B960 8D 80 19    STA $1980  [$7E:1980]  ;} FX timer = 10h

$84:B963 60          RTS
}


;;; $B964: PLM entry - make old Tourian escape shaft fake wall explode ;;;
{
$84:B964             dw B3C1,B919
}


;;; $B968: PLM entry - raise acid in escape room before old Tourian escape shaft ;;;
{
$84:B968             dw B3C1,B940
}


;;; $B96C: Setup - PLM $B974 (shot/bombed/grappled reaction, shootable, BTS 10h. Gate block) ;;;
{
$84:B96C 64 26       STZ $26    [$7E:0026]  ; Remaining number of blocks left to check - 1 = 0 (don't check any more blocks)
$84:B96E A9 FF FF    LDA #$FFFF             ;\
$84:B971 85 28       STA $28    [$7E:0028]  ;} Remaining target number of collisions - 1 = -1 (report collision even if only partial contact)
$84:B973 60          RTS
}


;;; $B974: PLM entry - shot/bombed/grappled reaction, shootable, BTS 10h. Gate block ;;;
{
$84:B974             dw B96C,AAE3
}


;;; $B978: Setup - PLM $B9C1 (shot/bombed/grappled reaction, shootable, BTS 4Fh. Critters escape block) ;;;
{
; Sets the PLM respawn block, but never uses it
$84:B978 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:B97B BD 18 0C    LDA $0C18,x[$7E:0C1A]  ;} If [projectile type] = 0: (not sure if this can ever happen, maybe grapple or last frame of power bomb)
$84:B97E D0 0A       BNE $0A    [$B98A]     ;/
$84:B980 29 00 0F    AND #$0F00             ; >_<;
$84:B983 A9 00 00    LDA #$0000             ;\
$84:B986 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:B989 60          RTS                    ; Return

$84:B98A BE 87 1C    LDX $1C87,y[$7E:1CD1]  ;\
$84:B98D BF 02 00 7F LDA $7F0002,x[$7F:0160];|
$84:B991 29 00 F0    AND #$F000             ;} PLM respawn block = [PLM block] & F000h | 9Fh (same block type, super missile graphic)
$84:B994 09 9F 00    ORA #$009F             ;|
$84:B997 99 17 1E    STA $1E17,y[$7E:1E61]  ;/
$84:B99A 29 FF 8F    AND #$8FFF             ;\
$84:B99D 9F 02 00 7F STA $7F0002,x[$7F:0160];} Deactivate PLM
$84:B9A1 60          RTS
}


;;; $B9A2: Instruction list - PLM $B9C1 (shot/bombed/grappled reaction, shootable, BTS 4Fh. Critters escape block) ;;;
{
$84:B9A2             dx 8C10,0A,    ; Queue sound Ah, sound library 2, max queued sounds allowed = 6 (block crumbled)
                        0004,925B,
                        0004,9265,
                        0004,926F,
                        0001,9279,
                        B9B9,       ; Set critters escaped event
                        86BC        ; Delete
}


;;; $B9B9: Instruction - set critters escaped event ;;;
{
$84:B9B9 A9 0F 00    LDA #$000F
$84:B9BC 22 FA 81 80 JSL $8081FA[$80:81FA]
$84:B9C0 60          RTS
}


;;; $B9C1: PLM entry - shot/bombed/grappled reaction, shootable, BTS 4Fh. Critters escape block ;;;
{
$84:B9C1             dw B978,B9A2
}


;;; $B9C5: Setup - PLM $B9ED (critters escape block) ;;;
{
; Make PLM block a critters escape block, extended downwards by 2 blocks
$84:B9C5 BE 87 1C    LDX $1C87,y[$7E:1CD1]
$84:B9C8 A9 4F C0    LDA #$C04F
$84:B9CB 20 B4 82    JSR $82B4  [$84:82B4]
$84:B9CE 8A          TXA
$84:B9CF 18          CLC
$84:B9D0 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B9D3 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B9D6 AA          TAX
$84:B9D7 A9 FF D0    LDA #$D0FF
$84:B9DA 20 B4 82    JSR $82B4  [$84:82B4]
$84:B9DD 8A          TXA
$84:B9DE 18          CLC
$84:B9DF 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B9E2 6D A5 07    ADC $07A5  [$7E:07A5]
$84:B9E5 AA          TAX
$84:B9E6 A9 FF D0    LDA #$D0FF
$84:B9E9 20 B4 82    JSR $82B4  [$84:82B4]
$84:B9EC 60          RTS
}


;;; $B9ED: PLM entry - critters escape block ;;;
{
$84:B9ED             dw B9C5,AAE3
}


;;; $B9F1: Setup - PLM $BA48 (turn Ceres elevator door to solid blocks during escape) ;;;
{
$84:B9F1 BE 87 1C    LDX $1C87,y[$7E:1CD5]
$84:B9F4 BF 02 00 7F LDA $7F0002,x[$7F:04E0]
$84:B9F8 29 FF 0F    AND #$0FFF
$84:B9FB 09 00 80    ORA #$8000
$84:B9FE 9F 02 00 7F STA $7F0002,x[$7F:04E0]
$84:BA02 8A          TXA
$84:BA03 18          CLC
$84:BA04 6D A5 07    ADC $07A5  [$7E:07A5]
$84:BA07 6D A5 07    ADC $07A5  [$7E:07A5]
$84:BA0A AA          TAX
$84:BA0B BF 02 00 7F LDA $7F0002,x[$7F:0500]
$84:BA0F 29 FF 0F    AND #$0FFF
$84:BA12 09 00 80    ORA #$8000
$84:BA15 9F 02 00 7F STA $7F0002,x[$7F:0500]
$84:BA19 8A          TXA
$84:BA1A 18          CLC
$84:BA1B 6D A5 07    ADC $07A5  [$7E:07A5]
$84:BA1E 6D A5 07    ADC $07A5  [$7E:07A5]
$84:BA21 AA          TAX
$84:BA22 BF 02 00 7F LDA $7F0002,x[$7F:0520]
$84:BA26 29 FF 0F    AND #$0FFF
$84:BA29 09 00 80    ORA #$8000
$84:BA2C 9F 02 00 7F STA $7F0002,x[$7F:0520]
$84:BA30 8A          TXA
$84:BA31 18          CLC
$84:BA32 6D A5 07    ADC $07A5  [$7E:07A5]
$84:BA35 6D A5 07    ADC $07A5  [$7E:07A5]
$84:BA38 AA          TAX
$84:BA39 BF 02 00 7F LDA $7F0002,x[$7F:0540]
$84:BA3D 29 FF 0F    AND #$0FFF
$84:BA40 09 00 80    ORA #$8000
$84:BA43 9F 02 00 7F STA $7F0002,x[$7F:0540]
$84:BA47 60          RTS
}


;;; $BA48: PLM entry - turn Ceres elevator door to solid blocks during escape ;;;
{
$84:BA48             dw B9F1,AAE3
}


;;; $BA4C: Instruction list - PLM $BAF4 (bomb torizo grey door) ;;;
{
$84:BA4C             dx 0002,A683,
                        BA6F,BA4C,  ; Go to $BA4C if Samus doesn't have bombs
                        0028,A683,
                        8C19,08,    ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A6FB,
                        0002,A6EF,
                        0002,A6E3,
                        0001,A6D7,
                        8724,BA7F   ; Go to $BA7F
}


;;; $BA6F: Instruction - go to [[Y]] if Samus doesn't have bombs ;;;
{
$84:BA6F AD A4 09    LDA $09A4  [$7E:09A4]
$84:BA72 89 00 10    BIT #$1000
$84:BA75 F0 03       BEQ $03    [$BA7A]
$84:BA77 C8          INY
$84:BA78 C8          INY
$84:BA79 60          RTS

$84:BA7A B9 00 00    LDA $0000,y[$84:BA52]
$84:BA7D A8          TAY
$84:BA7E 60          RTS
}


;;; $BA7F: Instruction list - PLM $BAF4 (bomb torizo grey door) ;;;
{
$84:BA7F             dx 8A72,C4E2,      ; Go to $C4E2 if the room argument door is set
                        8A24,BA93,      ; Link instruction = $BA93
                        BE3F,           ; Set grey door pre-instruction
                        0001,A6D7,
$84:BA8D             dx 86B4,           ; Sleep
                        8724,BA8D,      ; Go to $BA8D
$84:BA93             dx 8A24,BAB7,      ; Link instruction = $BAB7
                        86C1,BD0F,      ; Pre-instruction = go to link instruction if shot
$84:BA9B             dx 0003,A9EF,
                        0004,A6D7,
                        0003,A9EF,
                        0004,A6D7,
                        0003,A9EF,
                        0004,A6D7,
                        8724,BA9B,      ; Go to $BA9B
$84:BAB7             dx 8A91,01,BABC,   ; Increment door hit counter; Set room argument door and go to $BABC if [door hit counter] >= 01h
$84:BABC             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0004,A6E3,
                        0004,A6EF,
                        0004,A6FB,
                        0001,A683,
                        86BC            ; Delete
}


;;; $BAD1: Unused. Setup ;;;
{
; Would be the setup for the bomb torizo grey door, just the same as the generic grey door setup, but with a hard coded grey door type
$84:BAD1 B9 C8 1D    LDA $1DC8,y            ;\
$84:BAD4 29 7C 00    AND #$007C             ;} Residual copy+pasted code from grey door setup
$84:BAD7 4A          LSR A                  ;/
$84:BAD8 A9 04 00    LDA #$0004             ;\
$84:BADB 99 17 1E    STA $1E17,y            ;} PLM grey door type = 4 (area torizo is dead)
$84:BADE B9 C7 1D    LDA $1DC7,y            ;\
$84:BAE1 29 FF 83    AND #$83FF             ;|
$84:BAE4 09 00 80    ORA #$8000             ;} PLM room argument = [PLM room argument] & ~7C00h | 8000h
$84:BAE7 99 C7 1D    STA $1DC7,y            ;/
$84:BAEA BE 87 1C    LDX $1C87,y            ;\
$84:BAED A9 44 C0    LDA #$C044             ;} Make PLM shotblock with BTS 44h (generic shot trigger)
$84:BAF0 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:BAF3 60          RTS
}


;;; $BAF4: PLM entry - bomb torizo grey door ;;;
{
$84:BAF4             dw C794,BA7F,BA4C
}


;;; $BAFA: Setup - PLM $BB05 (Wrecked Ship attic) ;;;
{
$84:BAFA E2 20       SEP #$20
$84:BAFC C2 20       REP #$20
$84:BAFE 60          RTS
}


;;; $BAFF: Instruction list - PLM $BB05 (Wrecked Ship attic) ;;;
{
$84:BAFF             dx 86C1,BAFA,  ; Pre-instruction = setup
                        86B4        ; Sleep
}


;;; $BB05: PLM entry - Wrecked Ship attic ;;;
{
$84:BB05             dw BAFA,BAFF
}


;;; $BB09: Setup - PLM $BB30 (clear Crateria mainstreet escape passage if critters escaped) ;;;
{
$84:BB09 A9 0F 00    LDA #$000F             ;\
$84:BB0C 22 33 82 80 JSL $808233[$80:8233]  ;} If critters not escaped:
$84:BB10 B0 06       BCS $06    [$BB18]     ;/
$84:BB12 A9 00 00    LDA #$0000             ;\
$84:BB15 99 37 1C    STA $1C37,y[$7E:1C65]  ;} PLM ID = 0

$84:BB18 60          RTS
}


;;; $BB19: Instruction list - PLM $BB30 (clear Crateria mainstreet escape passage if critters escaped) ;;;
{
$84:BB19             dx 0001,9253,
                        BB25,       ; Move PLM right 4 blocks
                        0001,9253,
                        86BC        ; Delete
}


;;; $BB25: Instruction - move PLM right 4 blocks ;;;
{
$84:BB25 BD 87 1C    LDA $1C87,x[$7E:1CB5]
$84:BB28 18          CLC
$84:BB29 69 08 00    ADC #$0008
$84:BB2C 9D 87 1C    STA $1C87,x[$7E:1CB5]
$84:BB2F 60          RTS
}


;;; $BB30: PLM entry - clear Crateria mainstreet escape passage if critters escaped ;;;
{
$84:BB30             dw BB09,BB19
}


;;; $BB34: Instruction list - door $C8CA (gate that closes during escape in room after Mother Brain) ;;;
{
$84:BB34             dx 0006,948B,
                        86BC        ; Delete
}


;;; $BB3A: Unused. Instruction list ;;;
{
$84:BB3A             dx 0006,947F,
                        005E,9473,
                        86BC        ; Delete
}


;;; $BB44: Instruction list - door $C8CA / PLM $C8D0 (gate that closes during escape in room after Mother Brain) ;;;
{
$84:BB44             dx 0002,9473,
                        0002,947F,
                        0002,948B,
                        86BC        ; Delete
}


;;; $BB52: Pre-instruction - wake PLM if triggered ;;;
{
$84:BB52 BD 77 1D    LDA $1D77,x[$7E:1DC5]  ;\
$84:BB55 F0 13       BEQ $13    [$BB6A]     ;} If not triggered: return
$84:BB57 FE 27 1D    INC $1D27,x            ;\
$84:BB5A FE 27 1D    INC $1D27,x            ;} PLM instruction list pointer += 2
$84:BB5D A9 01 00    LDA #$0001             ;\
$84:BB60 9F 1C DE 7E STA $7EDE1C,x          ;} PLM instruction timer = 1
$84:BB64 A9 6A BB    LDA #$BB6A             ;\
$84:BB67 9D D7 1C    STA $1CD7,x            ;} PLM pre-instruction = RTS

$84:BB6A 60          RTS
}


;;; $BB6B: Pre-instruction - wake PLM if triggered or Samus is within 4 block column below PLM ;;;
{
$84:BB6B 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$84:BB6F AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:BB72 4A          LSR A                  ;|
$84:BB73 4A          LSR A                  ;|
$84:BB74 4A          LSR A                  ;} If [Samus X block] = [PLM X block]:
$84:BB75 4A          LSR A                  ;|
$84:BB76 CD 29 1C    CMP $1C29  [$7E:1C29]  ;|
$84:BB79 D0 10       BNE $10    [$BB8B]     ;/
$84:BB7B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$84:BB7E 4A          LSR A                  ;|
$84:BB7F 4A          LSR A                  ;|
$84:BB80 4A          LSR A                  ;|
$84:BB81 4A          LSR A                  ;} If 0 <= [Samus Y block] - [PLM Y block] < 5: go to BRANCH_TRIGGERED
$84:BB82 38          SEC                    ;|
$84:BB83 ED 2B 1C    SBC $1C2B  [$7E:1C2B]  ;|
$84:BB86 C9 05 00    CMP #$0005             ;|
$84:BB89 90 05       BCC $05    [$BB90]     ;/

$84:BB8B BD 77 1D    LDA $1D77,x[$7E:1DC5]  ;\
$84:BB8E F0 13       BEQ $13    [$BBA3]     ;} If not triggered: return

; BRANCH_TRIGGERED
$84:BB90 FE 27 1D    INC $1D27,x[$7E:1D75]  ;\
$84:BB93 FE 27 1D    INC $1D27,x[$7E:1D75]  ;} PLM instruction list pointer += 2
$84:BB96 A9 01 00    LDA #$0001             ;\
$84:BB99 9F 1C DE 7E STA $7EDE1C,x[$7E:DE6A];} PLM instruction timer = 1
$84:BB9D A9 A3 BB    LDA #$BBA3             ;\
$84:BBA0 9D D7 1C    STA $1CD7,x[$7E:1D25]  ;} PLM pre-instruction = RTS

$84:BBA3 60          RTS
}


;;; $BBA4: Pre-instruction - wake PLM if triggered or Samus is within 4 block column above PLM ;;;
{
$84:BBA4 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$84:BBA8 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$84:BBAB 4A          LSR A                  ;|
$84:BBAC 4A          LSR A                  ;|
$84:BBAD 4A          LSR A                  ;} If [Samus X block] = [PLM X block]:
$84:BBAE 4A          LSR A                  ;|
$84:BBAF CD 29 1C    CMP $1C29  [$7E:1C29]  ;|
$84:BBB2 D0 10       BNE $10    [$BBC4]     ;/
$84:BBB4 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$84:BBB7 4A          LSR A                  ;|
$84:BBB8 4A          LSR A                  ;|
$84:BBB9 4A          LSR A                  ;|
$84:BBBA 4A          LSR A                  ;} If 0 > [Samus Y block] - [PLM Y block] >= -4: go to BRANCH_TRIGGERED
$84:BBBB 38          SEC                    ;|
$84:BBBC ED 2B 1C    SBC $1C2B  [$7E:1C2B]  ;|
$84:BBBF C9 FC FF    CMP #$FFFC             ;|
$84:BBC2 B0 05       BCS $05    [$BBC9]     ;/

$84:BBC4 BD 77 1D    LDA $1D77,x            ;\
$84:BBC7 F0 13       BEQ $13    [$BBDC]     ;} If not triggered: return

$84:BBC9 FE 27 1D    INC $1D27,x            ;\
$84:BBCC FE 27 1D    INC $1D27,x            ;} PLM instruction list pointer += 2
$84:BBCF A9 01 00    LDA #$0001             ;\
$84:BBD2 9F 1C DE 7E STA $7EDE1C,x          ;} PLM instruction timer = 1
$84:BBD6 A9 DC BB    LDA #$BBDC             ;\
$84:BBD9 9D D7 1C    STA $1CD7,x            ;} PLM pre-instruction = RTS

$84:BBDC 60          RTS
}


;;; $BBDD: Instruction - clear trigger ;;;
{
$84:BBDD 9E 77 1D    STZ $1D77,x[$7E:1DC5]
$84:BBE0 60          RTS
}


;;; $BBE1: Instruction - spawn enemy projectile [[Y]] ;;;
{
$84:BBE1 DA          PHX
$84:BBE2 5A          PHY
$84:BBE3 B9 00 00    LDA $0000,y
$84:BBE6 A8          TAY
$84:BBE7 22 97 80 86 JSL $868097[$86:8097]
$84:BBEB 7A          PLY
$84:BBEC FA          PLX
$84:BBED C8          INY
$84:BBEE C8          INY
$84:BBEF 60          RTS
}


;;; $BBF0: Instruction - wake enemy projectile at PLM's position ;;;
{
; 2-byte unused enemy projectile ID argument
$84:BBF0 DA          PHX
$84:BBF1 5A          PHY
$84:BBF2 BD 87 1C    LDA $1C87,x[$7E:1CD5]
$84:BBF5 A2 22 00    LDX #$0022             ; X = 22h

; LOOP
$84:BBF8 DD FF 1A    CMP $1AFF,x[$7E:1B21]  ;\
$84:BBFB F0 05       BEQ $05    [$BC02]     ;} If enemy projectile [X] $1AFF = [PLM block index]: go to BRANCH_FOUND
$84:BBFD CA          DEX                    ;\
$84:BBFE CA          DEX                    ;} X -= 2
$84:BBFF 10 F7       BPL $F7    [$BBF8]     ; If [X] >= 0: go to LOOP
$84:BC01 00          BRK

; BRANCH_FOUND
$84:BC02 A9 01 00    LDA #$0001             ;\
$84:BC05 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile [X] instruction delay = 1
$84:BC08 FE 47 1B    INC $1B47,x[$7E:1B69]  ;\
$84:BC0B FE 47 1B    INC $1B47,x[$7E:1B69]  ;} Enemy projectile [X] instruction list pointer += 2
$84:BC0E 7A          PLY
$84:BC0F FA          PLX
$84:BC10 C8          INY
$84:BC11 C8          INY
$84:BC12 60          RTS
}
}


;;; $BC13..BD0E: Instruction lists ;;;
{
;;; $BC13: Instruction list - PLM $C826 (downwards open gate) ;;;
{
$84:BC13             dx 0001,A517,
                        BBDD,       ; Clear trigger
                        86C1,BB52,  ; Pre-instruction = wake PLM if triggered
                        86B4,       ; Sleep
                        0010,A517,
                        BBE1,E64B,  ; Spawn downwards gate enemy projectile
                        8C19,0E,    ; Queue sound Eh, sound library 3, max queued sounds allowed = 6 (gate opening/closing)
                        0010,A525,
                        0010,A533,
                        0010,A541,
                        0018,A54F
}


;;; $BC3A: Instruction list - PLM $C82A (downwards closed gate) ;;;
{
$84:BC3A             dx 0001,A55D,
                        BBDD,       ; Clear trigger
                        86C1,BB6B,  ; Pre-instruction = wake PLM if triggered or Samus is within 4 block column below PLM
                        86B4,       ; Sleep
                        BBF0,E566,  ; Wake enemy projectile at PLM's position
                        8C19,0E,    ; Queue sound Eh, sound library 3, max queued sounds allowed = 6 (gate opening/closing)
                        0010,A54F,
                        0010,A541,
                        0010,A533,
                        0018,A525,
                        8724,BC13   ; Go to $BC13
}


;;; $BC61: Instruction list - PLM $C82E (upwards open gate) ;;;
{
$84:BC61             dx 0008,A56B,
                        BBDD,       ; Clear trigger
                        86C1,BB52,  ; Pre-instruction = wake PLM if triggered
                        86B4,       ; Sleep
                        0010,A56B,
                        BBE1,E667,  ; Spawn upwards gate enemy projectile
                        8C19,0E,    ; Queue sound Eh, sound library 3, max queued sounds allowed = 6 (gate opening/closing)
                        0010,A57D,
                        0010,A58F,
                        0010,A5A1,
                        0010,A5B3
}


;;; $BC88: Instruction list - PLM $C832 (upwards closed gate) ;;;
{
$84:BC88             dx 0008,A5C5,
                        BBDD,       ; Clear trigger
                        86C1,BBA4,  ; Pre-instruction = wake PLM if triggered or Samus is within 4 block column above PLM
                        86B4,       ; Sleep
                        BBF0,E5B0,  ; Wake enemy projectile at PLM's position
                        8C19,0E,    ; Queue sound Eh, sound library 3, max queued sounds allowed = 6 (gate opening/closing)
                        0010,A5B3,
                        0010,A5A1,
                        0010,A58F,
                        0010,A57D,
                        8724,BC61   ; Go to $BC61
}


;;; $BCAF: Instruction list - PLM $C836 (downwards gate shotblock) - blue left ;;;
{
$84:BCAF             dx 0001,A5D7,
                        86BC        ; Delete
}


;;; $BCB5: Instruction list - PLM $C836 (downwards gate shotblock) - blue right ;;;
{
$84:BCB5             dx 0001,A5E3,
                        86BC        ; Delete
}


;;; $BCBB: Instruction list - PLM $C836 (downwards gate shotblock) - red left ;;;
{
$84:BCBB             dx 0001,A5EB,
                        86BC        ; Delete
}


;;; $BCC1: Instruction list - PLM $C836 (downwards gate shotblock) - red right ;;;
{
$84:BCC1             dx 0001,A5F7,
                        86BC        ; Delete
}


;;; $BCC7: Instruction list - PLM $C836 (downwards gate shotblock) - green left ;;;
{
$84:BCC7             dx 0001,A5FF,
                        86BC        ; Delete
}


;;; $BCCD: Instruction list - PLM $C836 (downwards gate shotblock) - green right ;;;
{
$84:BCCD             dx 0001,A60B,
                        86BC        ; Delete
}


;;; $BCD3: Instruction list - PLM $C836 (downwards gate shotblock) - yellow left ;;;
{
$84:BCD3             dx 0001,A613,
                        86BC        ; Delete
}


;;; $BCD9: Instruction list - PLM $C836 (downwards gate shotblock) - yellow right ;;;
{
$84:BCD9             dx 0001,A61F,
                        86BC        ; Delete
}


;;; $BCDF: Instruction list - PLM $C83A (upwards gate shotblock) - blue left ;;;
{
$84:BCDF             dx 0001,A627,
                        86BC        ; Delete
}


;;; $BCE5: Instruction list - PLM $C83A (upwards gate shotblock) - blue right ;;;
{
$84:BCE5             dx 0001,A633,
                        86BC        ; Delete
}


;;; $BCEB: Instruction list - PLM $C83A (upwards gate shotblock) - red left ;;;
{
$84:BCEB             dx 0001,A63B,
                        86BC        ; Delete
}


;;; $BCF1: Instruction list - PLM $C83A (upwards gate shotblock) - red right ;;;
{
$84:BCF1             dx 0001,A647,
                        86BC        ; Delete
}


;;; $BCF7: Instruction list - PLM $C83A (upwards gate shotblock) - green left ;;;
{
$84:BCF7             dx 0001,A64F,
                        86BC        ; Delete
}


;;; $BCFD: Instruction list - PLM $C83A (upwards gate shotblock) - green right ;;;
{
$84:BCFD             dx 0001,A65B,
                        86BC        ; Delete
}


;;; $BD03: Instruction list - PLM $C83A (upwards gate shotblock) - yellow left ;;;
{
$84:BD03             dx 0001,A663,
                        86BC        ; Delete
}


;;; $BD09: Instruction list - PLM $C83A (upwards gate shotblock) - yellow right ;;;
{
$84:BD09             dx 0001,A66F,
                        86BC        ; Delete
}
}


;;; $BD0F..BE58: Pre-instructions ;;;
{
;;; $BD0F: Pre-instruction - go to link instruction if shot ;;;
{
$84:BD0F BD 77 1D    LDA $1D77,x[$7E:1DBF]  ;\
$84:BD12 F0 11       BEQ $11    [$BD25]     ;} If not shot: return
$84:BD14 9E 77 1D    STZ $1D77,x[$7E:1DBD]  ; Clear PLM shot status
$84:BD17 BF BC DE 7E LDA $7EDEBC,x[$7E:DF02];\
$84:BD1B 9D 27 1D    STA $1D27,x[$7E:1D6D]  ;} PLM instruction list pointer = [PLM link instruction]
$84:BD1E A9 01 00    LDA #$0001             ;\
$84:BD21 9F 1C DE 7E STA $7EDE1C,x[$7E:DE62];} PLM instruction timer = 1

$84:BD25 60          RTS
}


;;; $BD26: Pre-instruction - go to link instruction if shot with a power bomb ;;;
{
$84:BD26 BD 77 1D    LDA $1D77,x[$7E:1DC1]  ;\
$84:BD29 F0 21       BEQ $21    [$BD4C]     ;} If not shot: return
$84:BD2B 29 00 0F    AND #$0F00             ;\
$84:BD2E C9 00 03    CMP #$0300             ;} If shot with power bomb:
$84:BD31 D0 12       BNE $12    [$BD45]     ;/
$84:BD33 9E 77 1D    STZ $1D77,x[$7E:1DB7]  ; Clear PLM shot status
$84:BD36 BF BC DE 7E LDA $7EDEBC,x[$7E:DEFC];\
$84:BD3A 9D 27 1D    STA $1D27,x[$7E:1D67]  ;} PLM instruction list pointer = [PLM link instruction]
$84:BD3D A9 01 00    LDA #$0001             ;\
$84:BD40 9F 1C DE 7E STA $7EDE1C,x[$7E:DE5C];} PLM instruction timer = 1
$84:BD44 60          RTS                    ; Return

$84:BD45 A9 57 00    LDA #$0057             ;\
$84:BD48 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)

$84:BD4C 9E 77 1D    STZ $1D77,x[$7E:1DC1]  ; Clear PLM shot status
$84:BD4F 60          RTS
}


;;; $BD50: Pre-instruction - go to link instruction if shot with a (super) missile ;;;
{
$84:BD50 BD 77 1D    LDA $1D77,x[$7E:1DB1]  ;\
$84:BD53 F0 26       BEQ $26    [$BD7B]     ;} If not shot: return
$84:BD55 29 00 0F    AND #$0F00             ;\
$84:BD58 C9 00 02    CMP #$0200             ;} If shot with super missile: go to BRANCH_SUPER
$84:BD5B F0 22       BEQ $22    [$BD7F]     ;/
$84:BD5D C9 00 01    CMP #$0100             ;\
$84:BD60 D0 12       BNE $12    [$BD74]     ;} If not shot with missile: go to BRANCH_DUD

; BRANCH_MISSILE
$84:BD62 9E 77 1D    STZ $1D77,x[$7E:1DC3]  ; Clear PLM shot status
$84:BD65 BF BC DE 7E LDA $7EDEBC,x[$7E:DF08];\
$84:BD69 9D 27 1D    STA $1D27,x[$7E:1D73]  ;} PLM instruction list pointer = [PLM link instruction]
$84:BD6C A9 01 00    LDA #$0001             ;\
$84:BD6F 9F 1C DE 7E STA $7EDE1C,x[$7E:DE68];} PLM instruction timer = 1
$84:BD73 60          RTS                    ; Return

; BRANCH_DUD
$84:BD74 A9 57 00    LDA #$0057             ;\
$84:BD77 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)

$84:BD7B 9E 77 1D    STZ $1D77,x[$7E:1DB1]  ; Clear PLM shot status
$84:BD7E 60          RTS                    ; Return

; BRANCH_SUPER
$84:BD7F A9 77 00    LDA #$0077             ;\
$84:BD82 9F 0C DF 7E STA $7EDF0C,x[$7E:DF58];} PLM door hit counter = 77h
$84:BD86 80 DA       BRA $DA    [$BD62]     ; Go to BRANCH_MISSILE
}


;;; $BD88: Pre-instruction - go to link instruction if shot with a super missile ;;;
{
$84:BD88 BD 77 1D    LDA $1D77,x[$7E:1DC3]  ;\
$84:BD8B F0 21       BEQ $21    [$BDAE]     ;} If not shot: return
$84:BD8D 29 00 0F    AND #$0F00             ;\
$84:BD90 C9 00 02    CMP #$0200             ;} If shot with super missile:
$84:BD93 D0 12       BNE $12    [$BDA7]     ;/
$84:BD95 9E 77 1D    STZ $1D77,x[$7E:1DB1]  ; Clear PLM shot status
$84:BD98 BF BC DE 7E LDA $7EDEBC,x[$7E:DEF6];\
$84:BD9C 9D 27 1D    STA $1D27,x[$7E:1D61]  ;} PLM instruction list pointer = [PLM link instruction]
$84:BD9F A9 01 00    LDA #$0001             ;\
$84:BDA2 9F 1C DE 7E STA $7EDE1C,x[$7E:DE56];} PLM instruction timer = 1
$84:BDA6 60          RTS                    ; Return

$84:BDA7 A9 57 00    LDA #$0057             ;\
$84:BDAA 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)

$84:BDAE 9E 77 1D    STZ $1D77,x[$7E:1DC3]  ; Clear PLM shot status
$84:BDB1 60          RTS
}


;;; $BDB2: Go to link instruction ;;;
{
$84:BDB2 9E 77 1D    STZ $1D77,x[$7E:1DBF]  ; Clear PLM shot status
$84:BDB5 BF BC DE 7E LDA $7EDEBC,x[$7E:DF04];\
$84:BDB9 9D 27 1D    STA $1D27,x[$7E:1D6F]  ;} PLM instruction list pointer = [PLM link instruction]
$84:BDBC A9 01 00    LDA #$0001             ;\
$84:BDBF 9F 1C DE 7E STA $7EDE1C,x[$7E:DE64];} PLM instruction timer = 1
$84:BDC3 60          RTS
}


;;; $BDC4: Play dud sound ;;;
{
$84:BDC4 BD 77 1D    LDA $1D77,x[$7E:1DB5]  ;\
$84:BDC7 F0 07       BEQ $07    [$BDD0]     ;} If not shot: return
$84:BDC9 A9 57 00    LDA #$0057             ;\
$84:BDCC 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)

$84:BDD0 9E 77 1D    STZ $1D77,x[$7E:1DB5]  ; Clear PLM shot status
$84:BDD3 60          RTS
}


;;; $BDD4: Pre-instruction - go to link instruction if area boss is dead else play dud sound ;;;
{
$84:BDD4 A9 01 00    LDA #$0001
$84:BDD7 22 DC 81 80 JSL $8081DC[$80:81DC]
$84:BDDB 90 03       BCC $03    [$BDE0]
$84:BDDD 4C B2 BD    JMP $BDB2  [$84:BDB2]

$84:BDE0 4C C4 BD    JMP $BDC4  [$84:BDC4]
}


;;; $BDE3: Pre-instruction - go to link instruction if area mini-boss (inc. Mother Brain) is dead else play dud sound ;;;
{
$84:BDE3 A9 02 00    LDA #$0002
$84:BDE6 22 DC 81 80 JSL $8081DC[$80:81DC]
$84:BDEA 90 03       BCC $03    [$BDEF]
$84:BDEC 4C B2 BD    JMP $BDB2  [$84:BDB2]

$84:BDEF 4C C4 BD    JMP $BDC4  [$84:BDC4]
}


;;; $BDF2: Pre-instruction - go to link instruction if area torizo is dead else play dud sound ;;;
{
$84:BDF2 A9 04 00    LDA #$0004
$84:BDF5 22 DC 81 80 JSL $8081DC[$80:81DC]
$84:BDF9 90 03       BCC $03    [$BDFE]
$84:BDFB 4C B2 BD    JMP $BDB2  [$84:BDB2]

$84:BDFE 4C C4 BD    JMP $BDC4  [$84:BDC4]
}


;;; $BE01: Pre-instruction - go to link instruction and set grey door event if enemy death quota is met else play dud sound ;;;
{
$84:BE01 5A          PHY
$84:BE02 DA          PHX
$84:BE03 AD 50 0E    LDA $0E50  [$7E:0E50]
$84:BE06 CD 52 0E    CMP $0E52  [$7E:0E52]
$84:BE09 90 0C       BCC $0C    [$BE17]
$84:BE0B A9 00 00    LDA #$0000
$84:BE0E 22 FA 81 80 JSL $8081FA[$80:81FA]
$84:BE12 FA          PLX
$84:BE13 7A          PLY
$84:BE14 4C B2 BD    JMP $BDB2  [$84:BDB2]

$84:BE17 FA          PLX
$84:BE18 7A          PLY
$84:BE19 4C C4 BD    JMP $BDC4  [$84:BDC4]
}


;;; $BE1C: Pre-instruction - play dud sound ;;;
{
$84:BE1C 4C C4 BD    JMP $BDC4  [$84:BDC4]
}


;;; $BE1F: Pre-instruction - go to link instruction if Tourian statue has finished processing else play dud sound ;;;
{
$84:BE1F 5A          PHY
$84:BE20 DA          PHX
$84:BE21 AD 6D 1E    LDA $1E6D  [$7E:1E6D]
$84:BE24 10 05       BPL $05    [$BE2B]
$84:BE26 FA          PLX
$84:BE27 7A          PLY
$84:BE28 4C B2 BD    JMP $BDB2  [$84:BDB2]

$84:BE2B FA          PLX
$84:BE2C 7A          PLY
$84:BE2D 4C C4 BD    JMP $BDC4  [$84:BDC4]
}


;;; $BE30: Pre-instruction - go to link instruction if critters escaped else play dud sound ;;;
{
$84:BE30 A9 0F 00    LDA #$000F
$84:BE33 22 33 82 80 JSL $808233[$80:8233]
$84:BE37 90 03       BCC $03    [$BE3C]
$84:BE39 4C B2 BD    JMP $BDB2  [$84:BDB2]

$84:BE3C 4C C4 BD    JMP $BDC4  [$84:BDC4]
}


;;; $BE3F: Instruction - set grey door pre-instruction ;;;
{
$84:BE3F 5A          PHY
$84:BE40 BC 17 1E    LDY $1E17,x[$7E:1E55]
$84:BE43 B9 4B BE    LDA $BE4B,y[$84:BE53]
$84:BE46 9D D7 1C    STA $1CD7,x[$7E:1D15]
$84:BE49 7A          PLY
$84:BE4A 60          RTS

$84:BE4B             dw BDD4, BDE3, BDF2, BE01, BE1C, BE1F, BE30
}
}


;;; $BE59..C54C: Instruction lists ;;;
{
;;; $BE59: Instruction list - door $C842 (grey door facing left) ;;;
{
$84:BE59             dx 0002,A677,
                        0002,A6CB,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A6BF,
                        0002,A6B3,
                        0001,A6A7
}


;;; $BE70: Instruction list - door $C842 (grey door facing left) ;;;
{
$84:BE70             dx 8A72,C4B1,      ; Go to $C4B1 if the room argument door is set
                        8A24,BE84,      ; Link instruction = $BE84
                        BE3F,           ; Set grey door pre-instruction
                        0001,A6A7,
$84:BE7E             dx 86B4,           ; Sleep
                        8724,BE7E,      ; Go to $BE7E
$84:BE84             dx 8A24,BEA8,      ; Link instruction = $BEA8
                        86C1,BD0F,      ; Pre-instruction = go to link instruction if shot
$84:BE8C             dx 0003,A9B3,
                        0004,A6A7,
                        0003,A9B3,
                        0004,A6A7,
                        0003,A9B3,
                        0004,A6A7,
                        8724,BE8C,      ; Go to $BE8C
$84:BEA8             dx 8A91,01,BEAD,   ; Increment door hit counter; Set room argument door and go to $BEAD if [door hit counter] >= 01h
$84:BEAD             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0004,A6B3,
                        0004,A6BF,
                        0004,A6CB,
                        0001,A677,
                        86BC            ; Delete
}


;;; $BEC2: Instruction list - door $C848 (grey door facing right) ;;;
{
$84:BEC2             dx 0002,A683,
                        0002,A6FB,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A6EF,
                        0002,A6E3,
                        0001,A6D7
}


;;; $BED9: Instruction list - door $C848 (grey door facing right) ;;;
{
$84:BED9             dx 8A72,C4E2,      ; Go to $C4E2 if the room argument door is set
                        8A24,BEED,      ; Link instruction = $BEED
                        BE3F,           ; Set grey door pre-instruction
                        0001,A6D7,
$84:BEE7             dx 86B4,           ; Sleep
                        8724,BEE7,      ; Go to $BEE7
$84:BEED             dx 8A24,BF11,      ; Link instruction = $BF11
                        86C1,BD0F,      ; Pre-instruction = go to link instruction if shot
$84:BEF5             dx 0003,A9EF,
                        0004,A6D7,
                        0003,A9EF,
                        0004,A6D7,
                        0003,A9EF,
                        0004,A6D7,
                        8724,BEF5,      ; Go to $BEF5
$84:BF11             dx 8A91,01,BF16,   ; Increment door hit counter; Set room argument door and go to $BF16 if [door hit counter] >= 01h
$84:BF16             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0004,A6E3,
                        0004,A6EF,
                        0004,A6FB,
                        0001,A683,
                        86BC            ; Delete
}


;;; $BF2B: Instruction list - door $C84E (grey door facing up) ;;;
{
$84:BF2B             dx 0002,A68F,
                        0002,A72B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A71F,
                        0002,A713,
                        0001,A707
}


;;; $BF42: Instruction list - door $C84E (grey door facing up) ;;;
{
$84:BF42             dx 8A72,C513,      ; Go to $C513 if the room argument door is set
                        8A24,BF56,      ; Link instruction = $BF56
                        BE3F,           ; Set grey door pre-instruction
                        0001,A707,
$84:BF50             dx 86B4,           ; Sleep
                        8724,BF50,      ; Go to $BF50
$84:BF56             dx 8A24,BF7A,      ; Link instruction = $BF7A
                        86C1,BD0F,      ; Pre-instruction = go to link instruction if shot
$84:BF5E             dx 0003,AA2B,
                        0004,A707,
                        0003,AA2B,
                        0004,A707,
                        0003,AA2B,
                        0004,A707,
                        8724,BF5E,      ; Go to $BF5E
$84:BF7A             dx 8A91,01,BF7F,   ; Increment door hit counter; Set room argument door and go to $BF7F if [door hit counter] >= 01h
$84:BF7F             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0004,A713,
                        0004,A71F,
                        0004,A72B,
                        0001,A68F,
                        86BC            ; Delete
}


;;; $BF94: Instruction list - door $C854 (grey door facing down) ;;;
{
$84:BF94             dx 0002,A69B,
                        0002,A75B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A74F,
                        0002,A743,
                        0001,A737
}


;;; $BFAB: Instruction list - door $C854 (grey door facing down) ;;;
{
$84:BFAB             dx 8A72,C544,      ; Go to $C544 if the room argument door is set
                        8A24,BFBF,      ; Link instruction = $BFBF
                        BE3F,           ; Set grey door pre-instruction
                        0001,A737,
$84:BFB9             dx 86B4,           ; Sleep
                        8724,BFB9,      ; Go to $BFB9
$84:BFBF             dx 8A24,BFE3,      ; Link instruction = $BFE3
                        86C1,BD0F,      ; Pre-instruction = go to link instruction if shot
$84:BFC7             dx 0003,AA67,
                        0004,A737,
                        0003,AA67,
                        0004,A737,
                        0003,AA67,
                        0004,A737,
                        8724,BFC7,      ; Go to $BFC7
$84:BFE3             dx 8A91,01,BFE8,   ; Increment door hit counter; Set room argument door and go to $BFE8 if [door hit counter] >= 01h
$84:BFE8             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0004,A743,
                        0004,A74F,
                        0004,A75B,
                        0001,A69B,
                        86BC            ; Delete
}


;;; $BFFD: Instruction list - door $C85A (yellow door facing left) ;;;
{
$84:BFFD             dx 0002,A677,
                        0002,A78B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A77F,
                        0002,A773,
                        0001,A767
}


;;; $C014: Instruction list - door $C85A (yellow door facing left) ;;;
{
$84:C014             dx 8A72,C4B1,      ; Go to $C4B1 if the room argument door is set
                        8A24,C02A,      ; Link instruction = $C02A
                        86C1,BD26,      ; Pre-instruction = go to link instruction if shot with a power bomb
                        0001,A767,
$84:C024             dx 86B4,           ; Sleep
                        8724,C024,      ; Go to $C024
$84:C02A             dx 8A91,01,C04B,   ; Increment door hit counter; Set room argument door and go to $C04B if [door hit counter] >= 01h
                        0003,A9B3,
                        0004,A767,
                        0003,A9B3,
                        0004,A767,
                        0003,A9B3,
                        0004,A767,
                        8724,C024,      ; Go to $C024
$84:C04B             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0004,A773,
                        0004,A77F,
                        0004,A78B,
                        005C,A677,
                        86BC            ; Delete
}


;;; $C060: Instruction list - door $C860 (yellow door facing right) ;;;
{
$84:C060             dx 0002,A683,
                        0002,A7BB,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A7AF,
                        0002,A7A3,
                        0001,A797
}


;;; $C077: Instruction list - door $C860 (yellow door facing right) ;;;
{
$84:C077             dx 8A72,C4E2,      ; Go to $C4E2 if the room argument door is set
                        8A24,C08D,      ; Link instruction = $C08D
                        86C1,BD26,      ; Pre-instruction = go to link instruction if shot with a power bomb
                        0001,A797,
$84:C087             dx 86B4,           ; Sleep
                        8724,C087,      ; Go to $C087
$84:C08D             dx 8A91,01,C0AE,   ; Increment door hit counter; Set room argument door and go to $C0AE if [door hit counter] >= 01h
                        0003,A9EF,
                        0004,A797,
                        0003,A9EF,
                        0004,A797,
                        0003,A9EF,
                        0004,A797,
                        8724,C087,      ; Go to $C087
$84:C0AE             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A7A3,
                        0006,A7AF,
                        0006,A7BB,
                        0001,A683,
                        86BC            ; Delete
}


;;; $C0C3: Instruction list - door $C866 (yellow door facing up) ;;;
{
$84:C0C3             dx 0002,A68F,
                        0002,A7EB,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A7DF,
                        0002,A7D3,
                        0001,A7C7
}


;;; $C0DA: Instruction list - door $C866 (yellow door facing up) ;;;
{
$84:C0DA             dx 8A72,C513,      ; Go to $C513 if the room argument door is set
                        8A24,C0EC,      ; Link instruction = $C0EC
                        86C1,BD26,      ; Pre-instruction = go to link instruction if shot with a power bomb
                        0001,A7C7,
$84:C0EA             dx 86B4,           ; Sleep
$84:C0EC             dx 8A91,01,C10D,   ; Increment door hit counter; Set room argument door and go to $C10D if [door hit counter] >= 01h
                        0003,AA2B,
                        0004,A7C7,
                        0003,AA2B,
                        0004,A7C7,
                        0003,AA2B,
                        0004,A7C7,
                        8724,C0EA,      ; Go to $C0EA
$84:C10D             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A7D3,
                        0006,A7DF,
                        0006,A7EB,
                        0001,A68F,
                        86BC            ; Delete
}


;;; $C122: Instruction list - door $C86C (yellow door facing down) ;;;
{
$84:C122             dx 0002,A69B,
                        0002,A81B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A80F,
                        0002,A803,
                        0001,A7F7
}


;;; $C139: Instruction list - door $C86C (yellow door facing down) ;;;
{
$84:C139             dx 8A72,C544,      ; Go to $C544 if the room argument door is set
                        8A24,C14F,      ; Link instruction = $C14F
                        86C1,BD26,      ; Pre-instruction = go to link instruction if shot with a power bomb
                        0002,A7F7,
                        0001,A7F7,
$84:C14D             dx 86B4,           ; Sleep
$84:C14F             dx 8A91,01,C170,   ; Increment door hit counter; Set room argument door and go to $C170 if [door hit counter] >= 01h
                        0003,AA67,
                        0004,A7F7,
                        0003,AA67,
                        0004,A7F7,
                        0003,AA67,
                        0004,A7F7,
                        8724,C14D,      ; Go to $C14D
$84:C170             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A803,
                        0006,A80F,
                        0006,A81B,
                        0001,A69B,
                        86BC            ; Delete
}


;;; $C185: Instruction list - door $C872 (green door facing left) ;;;
{
$84:C185             dx 0002,A677,
                        0002,A84B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A83F,
                        0002,A833,
                        0001,A827
}


;;; $C19C: Instruction list - door $C872 (green door facing left) ;;;
{
$84:C19C             dx 8A72,C4B1,      ; Go to $C4B1 if the room argument door is set
                        8A24,C1AE,      ; Link instruction = $C1AE
                        86C1,BD88,      ; Pre-instruction = go to link instruction if shot with a super missile
                        0001,A827,
$84:C1AC             dx 86B4,           ; Sleep
$84:C1AE             dx 8A91,01,C1CF,   ; Increment door hit counter; Set room argument door and go to $C1CF if [door hit counter] >= 01h
                        0003,A9B3,
                        0004,A827,
                        0003,A9B3,
                        0004,A827,
                        0003,A9B3,
                        0004,A827,
                        8724,C1AC,      ; Go to $C1AC
$84:C1CF             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A833,
                        0006,A83F,
                        0006,A84B,
                        0001,A677,
                        86BC            ; Delete
}


;;; $C1E4: Instruction list - door $C878 (green door facing right) ;;;
{
$84:C1E4             dx 0002,A683,
                        0002,A87B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A86F,
                        0002,A863,
                        0001,A857
}


;;; $C1FB: Instruction list - door $C878 (green door facing right) ;;;
{
$84:C1FB             dx 8A72,C4E2,      ; Go to $C4E2 if the room argument door is set
                        8A24,C20D,      ; Link instruction = $C20D
                        86C1,BD88,      ; Pre-instruction = go to link instruction if shot with a super missile
                        0001,A857,
$84:C20B             dx 86B4,           ; Sleep
$84:C20D             dx 8A91,01,C22E,   ; Increment door hit counter; Set room argument door and go to $C22E if [door hit counter] >= 01h
                        0003,A9EF,
                        0004,A857,
                        0003,A9EF,
                        0004,A857,
                        0003,A9EF,
                        0004,A857,
                        8724,C20B,      ; Go to $C20B
$84:C22E             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A863,
                        0006,A86F,
                        0006,A87B,
                        0001,A683,
                        86BC            ; Delete
}


;;; $C243: Instruction list - door $C87E (green door facing up) ;;;
{
$84:C243             dx 0002,A68F,
                        0002,A8AB,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A89F,
                        0002,A893,
                        0001,A887
}


;;; $C25A: Instruction list - door $C87E (green door facing up) ;;;
{
$84:C25A             dx 8A72,C513,      ; Go to $C513 if the room argument door is set
                        8A24,C26C,      ; Link instruction = $C26C
                        86C1,BD88,      ; Pre-instruction = go to link instruction if shot with a super missile
                        0001,A887,
$84:C26A             dx 86B4,           ; Sleep
$84:C26C             dx 8A91,01,C28D,   ; Increment door hit counter; Set room argument door and go to $C28D if [door hit counter] >= 01h
                        0003,AA2B,
                        0004,A887,
                        0003,AA2B,
                        0004,A887,
                        0003,AA2B,
                        0004,A887,
                        8724,C26A,      ; Go to $C26A
$84:C28D             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A893,
                        0006,A89F,
                        0006,A8AB,
                        0001,A68F,
                        86BC            ; Delete
}


;;; $C2A2: Instruction list - door $C884 (green door facing down) ;;;
{
$84:C2A2             dx 0002,A69B,
                        0002,A8DB,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A8CF,
                        0002,A8C3,
                        0001,A8B7
}


;;; $C2B9: Instruction list - door $C884 (green door facing down) ;;;
{
$84:C2B9             dx 8A72,C544,      ; Go to $C544 if the room argument door is set
                        8A24,C2CB,      ; Link instruction = $C2CB
                        86C1,BD88,      ; Pre-instruction = go to link instruction if shot with a super missile
                        0001,A8B7,
$84:C2C9             dx 86B4,           ; Sleep
$84:C2CB             dx 8A91,01,C2EC,   ; Increment door hit counter; Set room argument door and go to $C2EC if [door hit counter] >= 01h
                        0003,AA67,
                        0004,A8B7,
                        0003,AA67,
                        0004,A8B7,
                        0003,AA67,
                        0004,A8B7,
                        8724,C2C9,      ; Go to $C2C9
$84:C2EC             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A8C3,
                        0006,A8CF,
                        0006,A8DB,
                        0001,A69B,
                        86BC            ; Delete
}


;;; $C301: Instruction list - door $C88A (red door facing left) ;;;
{
$84:C301             dx 0002,A677,
                        0002,A90B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A8FF,
                        0002,A8F3,
                        0001,A8E7
}


;;; $C318: Instruction list - door $C88A (red door facing left) ;;;
{
$84:C318             dx 8A72,C4B1,      ; Go to $C4B1 if the room argument door is set
                        8A24,C32A,      ; Link instruction = $C32A
                        86C1,BD50,      ; Pre-instruction = go to link instruction if shot with a (super) missile
                        0001,A8E7,
$84:C328             dx 86B4,           ; Sleep
$84:C32A             dx 8A91,05,C34E,   ; Increment door hit counter; Set room argument door and go to $C34E if [door hit counter] >= 05h
                        8C19,09,        ; Queue sound 9, sound library 3, max queued sounds allowed = 6 (missile door shot with missile)
                        0003,A9B3,
                        0004,A8E7,
                        0003,A9B3,
                        0004,A8E7,
                        0003,A9B3,
                        0004,A8E7,
                        8724,C328,      ; Go to $C328
$84:C34E             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A8F3,
                        0006,A8FF,
                        0006,A90B,
                        0001,A677,
                        86BC            ; Delete
}


;;; $C363: Instruction list - door $C890 (red door facing right) ;;;
{
$84:C363             dx 0002,A683,
                        0002,A93B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A92F,
                        0002,A923,
                        0001,A917
}


;;; $C37A: Instruction list - door $C890 (red door facing right) ;;;
{
$84:C37A             dx 8A72,C4E2,      ; Go to $C4E2 if the room argument door is set
                        8A24,C38C,      ; Link instruction = $C38C
                        86C1,BD50,      ; Pre-instruction = go to link instruction if shot with a (super) missile
                        0001,A917,
$84:C38A             dx 86B4,           ; Sleep
$84:C38C             dx 8A91,05,C3B0,   ; Increment door hit counter; Set room argument door and go to $C3B0 if [door hit counter] >= 05h
                        8C19,09,        ; Queue sound 9, sound library 3, max queued sounds allowed = 6 (missile door shot with missile)
                        0003,A9EF,
                        0004,A917,
                        0003,A9EF,
                        0004,A917,
                        0003,A9EF,
                        0004,A917,
                        8724,C38A,      ; Go to $C38A
$84:C3B0             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A923,
                        0006,A92F,
                        0006,A93B,
                        0001,A683,
                        86BC            ; Delete
}


;;; $C3C5: Instruction list - door $C896 (red door facing up) ;;;
{
$84:C3C5             dx 0002,A68F,
                        0002,A96B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A95F,
                        0002,A953,
                        0001,A947
}


;;; $C3DC: Instruction list - door $C896 (red door facing up) ;;;
{
$84:C3DC             dx 8A72,C513,      ; Go to $C513 if the room argument door is set
                        8A24,C3EE,      ; Link instruction = $C3EE
                        86C1,BD50,      ; Pre-instruction = go to link instruction if shot with a (super) missile
                        0001,A947,
$84:C3EC             dx 86B4,           ; Sleep
$84:C3EE             dx 8A91,05,C412,   ; Increment door hit counter; Set room argument door and go to $C412 if [door hit counter] >= 05h
                        8C19,09,        ; Queue sound 9, sound library 3, max queued sounds allowed = 6 (missile door shot with missile)
                        0003,AA2B,
                        0004,A947,
                        0003,AA2B,
                        0004,A947,
                        0003,AA2B,
                        0004,A947,
                        8724,C3EC,      ; Go to $C3EC
$84:C412             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A953,
                        0006,A95F,
                        0006,A96B,
                        0001,A68F,
                        86BC            ; Delete
}


;;; $C427: Instruction list - door $C89C (red door facing down) ;;;
{
$84:C427             dx 0002,A69B,
                        0002,A99B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A98F,
                        0002,A983,
                        0001,A977
}


;;; $C43E: Instruction list - door $C89C (red door facing down) ;;;
{
$84:C43E             dx 8A72,C544,      ; Go to $C544 if the room argument door is set
                        8A24,C450,      ; Link instruction = $C450
                        86C1,BD50,      ; Pre-instruction = go to link instruction if shot with a (super) missile
                        0001,A977,
$84:C44E             dx 86B4,           ; Sleep
$84:C450             dx 8A91,05,C474,   ; Increment door hit counter; Set room argument door and go to $C474 if [door hit counter] >= 05h
                        8C19,09,        ; Queue sound 9, sound library 3, max queued sounds allowed = 6 (missile door shot with missile)
                        0003,AA67,
                        0004,A977,
                        0003,AA67,
                        0004,A977,
                        0003,AA67,
                        0004,A977,
                        8724,C44E,      ; Go to $C44E
$84:C474             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A983,
                        0006,A98F,
                        0006,A99B,
                        0001,A69B,
                        86BC            ; Delete
}


;;; $C489: Instruction list - door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left) ;;;
{
$84:C489             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A9BF,
                        0006,A9CB,
                        0006,A9D7,
                        005E,A677,
                        86BC            ; Delete
}


;;; $C49E: Instruction list - door $C8A2 (shot/bombed/grappled reaction, shootable, BTS 40h. Blue door facing left) ;;;
{
$84:C49E             dx 0002,A677,
                        0002,A9D7,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,A9CB,
                        0002,A9BF
}


;;; $C4B1: Instruction list - closed blue door facing left ;;;
{
$84:C4B1             dx 8AF1,40,        ; PLM BTS = 40h
                        0001,A9B3,
                        86BC            ; Delete
}


;;; $C4BA: Instruction list - door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right) ;;;
{
$84:C4BA             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,A9FB,
                        0006,AA07,
                        0006,AA13,
                        005E,A683,
                        86BC            ; Delete
}


;;; $C4CF: Instruction list - door $C8A8 (shot/bombed/grappled reaction, shootable, BTS 41h. Blue door facing right) ;;;
{
$84:C4CF             dx 0002,A683,
                        0002,AA13,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,AA07,
                        0002,A9FB
}


;;; $C4E2: Instruction list - closed blue door facing right ;;;
{
$84:C4E2             dx 8AF1,41,        ; PLM BTS = 41h
                        0001,A9EF,
                        86BC            ; Delete
}


;;; $C4EB: Instruction list - door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up) ;;;
{
$84:C4EB             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,AA37,
                        0006,AA43,
                        0006,AA4F,
                        005E,A68F,
                        86BC            ; Delete
}


;;; $C500: Instruction list - door $C8AE (shot/bombed/grappled reaction, shootable, BTS 42h. Blue door facing up) ;;;
{
$84:C500             dx 0002,A68F,
                        0002,AA4F,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,AA43,
                        0002,AA37
}


;;; $C513: Instruction list - closed blue door facing up ;;;
{
$84:C513             dx 8AF1,42,        ; PLM BTS = 42h
                        0001,AA2B,
                        86BC            ; Delete
}


;;; $C51C: Instruction list - door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down) ;;;
{
$84:C51C             dx 8C19,07,        ; Queue sound 7, sound library 3, max queued sounds allowed = 6 (door opened)
                        0006,AA73,
                        0006,AA7F,
                        0006,AA8B,
                        005E,A69B,
                        86BC            ; Delete
}


;;; $C531: Instruction list - door $C8B4 (shot/bombed/grappled reaction, shootable, BTS 43h. Blue door facing down) ;;;
{
$84:C531             dx 0002,A69B,
                        0002,AA8B,
                        8C19,08,        ; Queue sound 8, sound library 3, max queued sounds allowed = 6 (door closed)
                        0002,AA7F,
                        0002,AA73
}


;;; $C544: Instruction list - closed blue door facing down ;;;
{
$84:C544             dx 8AF1,43,        ; PLM BTS = 43h
                        0001,AA67,
                        86BC            ; Delete
}
}


;;; $C54D..C805: Setups ;;;
{
;;; $C54D: Setup - PLM $C806 (shot/bombed/grappled reaction, shootable, BTS 4Ah. Left green gate trigger) ;;;
{
$84:C54D AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:C550 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;|
$84:C553 29 FF 0F    AND #$0FFF             ;} If current projectile is super missile:
$84:C556 C9 00 02    CMP #$0200             ;|
$84:C559 D0 03       BNE $03    [$C55E]     ;/
$84:C55B 4C 3F C6    JMP $C63F  [$84:C63F]  ; Go to trigger PLM of block to the right

$84:C55E A9 57 00    LDA #$0057             ;\
$84:C561 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)
$84:C565 A9 00 00    LDA #$0000             ;\
$84:C568 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:C56B 60          RTS
}


;;; $C56C: Setup - PLM $C80A (shot/bombed/grappled reaction, shootable, BTS 4Bh. Right green gate trigger) ;;;
{
$84:C56C AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:C56F BD 18 0C    LDA $0C18,x[$7E:0C18]  ;|
$84:C572 29 FF 0F    AND #$0FFF             ;} If current projectile is super missile:
$84:C575 C9 00 02    CMP #$0200             ;|
$84:C578 D0 03       BNE $03    [$C57D]     ;/
$84:C57A 4C 47 C6    JMP $C647  [$84:C647]  ; Go to trigger PLM of block to the left

$84:C57D A9 57 00    LDA #$0057             ;\
$84:C580 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)
$84:C584 A9 00 00    LDA #$0000             ;\
$84:C587 99 37 1C    STA $1C37,y[$7E:1C83]  ;} PLM ID = 0
$84:C58A 60          RTS
}


;;; $C58B: Setup - PLM $C80E (shot/bombed/grappled reaction, shootable, BTS 48h. Left red gate trigger) ;;;
{
$84:C58B AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:C58E BD 18 0C    LDA $0C18,x            ;|
$84:C591 29 FF 0F    AND #$0FFF             ;|
$84:C594 C9 00 01    CMP #$0100             ;} If current projectile is (super) missile:
$84:C597 F0 05       BEQ $05    [$C59E]     ;|
$84:C599 C9 00 02    CMP #$0200             ;|
$84:C59C D0 03       BNE $03    [$C5A1]     ;/

$84:C59E 4C 3F C6    JMP $C63F  [$84:C63F]  ; Go to trigger PLM of block to the right

$84:C5A1 A9 57 00    LDA #$0057             ;\
$84:C5A4 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)
$84:C5A8 A9 00 00    LDA #$0000             ;\
$84:C5AB 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:C5AE 60          RTS
}


;;; $C5AF: Setup - PLM $C812 (shot/bombed/grappled reaction, shootable, BTS 49h. Right red gate trigger) ;;;
{
$84:C5AF AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:C5B2 BD 18 0C    LDA $0C18,x            ;|
$84:C5B5 29 FF 0F    AND #$0FFF             ;|
$84:C5B8 C9 00 01    CMP #$0100             ;} If current projectile is (super) missile:
$84:C5BB F0 05       BEQ $05    [$C5C2]     ;|
$84:C5BD C9 00 02    CMP #$0200             ;|
$84:C5C0 D0 03       BNE $03    [$C5C5]     ;/

$84:C5C2 4C 47 C6    JMP $C647  [$84:C647]  ; Go to trigger PLM of block to the left

$84:C5C5 A9 57 00    LDA #$0057             ;\
$84:C5C8 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)
$84:C5CC A9 00 00    LDA #$0000             ;\
$84:C5CF 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:C5D2 60          RTS
}


;;; $C5D3: Setup - PLM $C81E (shot/bombed/grappled reaction, shootable, BTS 4Ch. Left yellow gate trigger) ;;;
{
$84:C5D3 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:C5D6 BD 18 0C    LDA $0C18,x            ;|
$84:C5D9 29 FF 0F    AND #$0FFF             ;} If current projectile is power bomb:
$84:C5DC C9 00 03    CMP #$0300             ;|
$84:C5DF D0 03       BNE $03    [$C5E4]     ;/
$84:C5E1 4C 3F C6    JMP $C63F  [$84:C63F]  ; Go to trigger PLM of block to the right

$84:C5E4 A9 57 00    LDA #$0057             ;\
$84:C5E7 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)
$84:C5EB A9 00 00    LDA #$0000             ;\
$84:C5EE 99 37 1C    STA $1C37,y            ;} PLM ID = 0
}


;;; $C5F1: Setup - PLM $C822 (shot/bombed/grappled reaction, shootable, BTS 4Dh. Right yellow gate trigger) ;;;
{
$84:C5F1 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:C5F4 BD 18 0C    LDA $0C18,x            ;|
$84:C5F7 29 FF 0F    AND #$0FFF             ;} If current projectile is power bomb:
$84:C5FA C9 00 03    CMP #$0300             ;|
$84:C5FD D0 03       BNE $03    [$C602]     ;/
$84:C5FF 4C 47 C6    JMP $C647  [$84:C647]  ; Go to trigger PLM of block to the left

$84:C602 A9 57 00    LDA #$0057             ;\
$84:C605 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot door/gate with dud shot)
$84:C609 A9 00 00    LDA #$0000             ;\
$84:C60C 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:C60F 60          RTS
}


;;; $C610: Setup - PLM $C816 (shot/bombed/grappled reaction, shootable, BTS 46h. Left blue gate trigger) ;;;
{
$84:C610 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:C613 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;|
$84:C616 29 FF 0F    AND #$0FFF             ;} If current projectile is not power bomb:
$84:C619 C9 00 03    CMP #$0300             ;|
$84:C61C F0 03       BEQ $03    [$C621]     ;/
$84:C61E 4C 3F C6    JMP $C63F  [$84:C63F]  ; Go to trigger PLM of block to the right

$84:C621 A9 00 00    LDA #$0000             ;\
$84:C624 99 37 1C    STA $1C37,y            ;} PLM ID = 0
}


;;; $C627: Setup - PLM $C81A (shot/bombed/grappled reaction, shootable, BTS 47h. Right blue gate trigger) ;;;
{
$84:C627 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:C62A BD 18 0C    LDA $0C18,x[$7E:0C18]  ;|
$84:C62D 29 FF 0F    AND #$0FFF             ;} If current projectile is not power bomb:
$84:C630 C9 00 03    CMP #$0300             ;|
$84:C633 F0 03       BEQ $03    [$C638]     ;/
$84:C635 4C 47 C6    JMP $C647  [$84:C647]  ; Go to trigger PLM of block to the left

$84:C638 A9 00 00    LDA #$0000             ;\
$84:C63B 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:C63E 60          RTS
}


;;; $C63F: Trigger PLM of block to the right ;;;
{
$84:C63F B9 87 1C    LDA $1C87,y[$7E:1CD3]
$84:C642 1A          INC A
$84:C643 1A          INC A
$84:C644 4C 4C C6    JMP $C64C  [$84:C64C]
}


;;; $C647: Trigger PLM of block to the left ;;;
{
$84:C647 B9 87 1C    LDA $1C87,y[$7E:1CD3]
$84:C64A 3A          DEC A
$84:C64B 3A          DEC A
}


;;; $C64C: Trigger PLM at block index [A] ;;;
{
$84:C64C A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$84:C64F DD 87 1C    CMP $1C87,x[$7E:1CD5]  ;\
$84:C652 F0 06       BEQ $06    [$C65A]     ;} If [PLM [X] block index] = [A]: go to BRANCH_FOUND
$84:C654 CA          DEX                    ;\
$84:C655 CA          DEX                    ;} X -= 2
$84:C656 10 F7       BPL $F7    [$C64F]     ; If [X] >= 0: go to LOOP
$84:C658 80 08       BRA $08    [$C662]     ; Go to BRANCH_RETURN

; BRANCH_FOUND
$84:C65A BD 77 1D    LDA $1D77,x[$7E:1DC5]  ;\
$84:C65D D0 03       BNE $03    [$C662]     ;} If PLM [X] is not triggered:
$84:C65F FE 77 1D    INC $1D77,x[$7E:1DC5]  ; Trigger PLM [X]

; BRANCH_RETURN
$84:C662 A9 00 00    LDA #$0000             ;\
$84:C665 99 37 1C    STA $1C37,y[$7E:1C83]  ;} PLM ID = 0
$84:C668 38          SEC
$84:C669 60          RTS
}


;;; $C66A: Give 5-block column below PLM BTS 10h ;;;
{
$84:C66A B9 87 1C    LDA $1C87,y[$7E:1CD5]
$84:C66D 4A          LSR A
$84:C66E AA          TAX
$84:C66F 20 7F C6    JSR $C67F  [$84:C67F]
$84:C672 20 7F C6    JSR $C67F  [$84:C67F]
$84:C675 20 7F C6    JSR $C67F  [$84:C67F]
$84:C678 20 7F C6    JSR $C67F  [$84:C67F]
$84:C67B 20 7F C6    JSR $C67F  [$84:C67F]
$84:C67E 60          RTS
}


;;; $C67F: PLM BTS = 10h, move PLM down a row ;;;
{
$84:C67F BF 02 64 7F LDA $7F6402,x[$7F:7FE6]
$84:C683 29 00 FF    AND #$FF00
$84:C686 09 10 00    ORA #$0010
$84:C689 9F 02 64 7F STA $7F6402,x[$7F:7FE6]
$84:C68D 8A          TXA
$84:C68E 18          CLC
$84:C68F 6D A5 07    ADC $07A5  [$7E:07A5]
$84:C692 AA          TAX
$84:C693 60          RTS
}


;;; $C694: Give 5-block column above PLM BTS 10h ;;;
{
$84:C694 B9 87 1C    LDA $1C87,y
$84:C697 4A          LSR A
$84:C698 AA          TAX
$84:C699 20 A9 C6    JSR $C6A9  [$84:C6A9]
$84:C69C 20 A9 C6    JSR $C6A9  [$84:C6A9]
$84:C69F 20 A9 C6    JSR $C6A9  [$84:C6A9]
$84:C6A2 20 A9 C6    JSR $C6A9  [$84:C6A9]
$84:C6A5 20 A9 C6    JSR $C6A9  [$84:C6A9]
$84:C6A8 60          RTS
}


;;; $C6A9: PLM BTS = 10h, move PLM up a row ;;;
{
$84:C6A9 BF 02 64 7F LDA $7F6402,x
$84:C6AD 29 00 FF    AND #$FF00
$84:C6B0 09 10 00    ORA #$0010
$84:C6B3 9F 02 64 7F STA $7F6402,x
$84:C6B7 8A          TXA
$84:C6B8 38          SEC
$84:C6B9 ED A5 07    SBC $07A5  [$7E:07A5]
$84:C6BC AA          TAX
$84:C6BD 60          RTS
}


;;; $C6BE: Setup - PLM $C82A (downwards closed gate) ;;;
{
$84:C6BE 5A          PHY                    ;\
$84:C6BF A0 59 E6    LDY #$E659             ;|
$84:C6C2 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn initial closed downwards shot gate enemy projectile
$84:C6C6 7A          PLY                    ;/
$84:C6C7 20 6A C6    JSR $C66A  [$84:C66A]  ; Give 5-block column below PLM BTS 10h
$84:C6CA 60          RTS
}


;;; $C6CB: Setup - PLM $C832 (upwards closed gate) ;;;
{
$84:C6CB 5A          PHY                    ;\
$84:C6CC A0 75 E6    LDY #$E675             ;|
$84:C6CF 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn initial upwards shot gate enemy projectile
$84:C6D3 7A          PLY                    ;/
$84:C6D4 20 94 C6    JSR $C694  [$84:C694]  ; Give 5-block column above PLM BTS 10h
$84:C6D7 60          RTS
}


;;; $C6D8: Setup - PLM $C826 (downwards open gate) ;;;
{
$84:C6D8 20 6A C6    JSR $C66A  [$84:C66A]  ; Give 5-block column below PLM BTS 10h
$84:C6DB 60          RTS
}


;;; $C6DC: Setup - PLM $C82E (upwards open gate) ;;;
{
$84:C6DC 20 94 C6    JSR $C694  [$84:C694]  ; Give 5-block column above PLM BTS 10h
$84:C6DF 60          RTS
}


;;; $C6E0: Setup - PLM $C836 (downwards gate shotblock) ;;;
{
$84:C6E0 BE C7 1D    LDX $1DC7,y[$7E:1E13]  ;\
$84:C6E3 BD 0A C7    LDA $C70A,x[$84:C70A]  ;} PLM instruction list pointer = [$C70A + [PLM room argument]]
$84:C6E6 99 27 1D    STA $1D27,y[$7E:1D73]  ;/
$84:C6E9 BE C7 1D    LDX $1DC7,y[$7E:1E13]  ;\
$84:C6EC BD 1A C7    LDA $C71A,x[$84:C71A]  ;} If [$C71A + [PLM room argument]] != 0:
$84:C6EF F0 08       BEQ $08    [$C6F9]     ;/
$84:C6F1 BE 87 1C    LDX $1C87,y[$7E:1CD3]  ;\
$84:C6F4 CA          DEX                    ;|
$84:C6F5 CA          DEX                    ;} Block to the left's block type / BTS = [$C71A + [PLM room argument]]
$84:C6F6 20 B4 82    JSR $82B4  [$84:82B4]  ;/

$84:C6F9 BE C7 1D    LDX $1DC7,y[$7E:1E13]  ;\
$84:C6FC BD 2A C7    LDA $C72A,x[$84:C72A]  ;} If [$C72A + [PLM room argument]] != 0:
$84:C6FF F0 08       BEQ $08    [$C709]     ;/
$84:C701 BE 87 1C    LDX $1C87,y[$7E:1CCB]  ;\
$84:C704 E8          INX                    ;|
$84:C705 E8          INX                    ;} Block to the right's block type / BTS = [$C72A + [PLM room argument]]
$84:C706 20 B4 82    JSR $82B4  [$84:82B4]  ;/

$84:C709 60          RTS

;                        _____________________________________________ 0: Blue left
;                       |      _______________________________________ 2: Blue right
;                       |     |      _________________________________ 4: Red left
;                       |     |     |      ___________________________ 6: Red right
;                       |     |     |     |      _____________________ 8: Green left
;                       |     |     |     |     |      _______________ Ah: Green right
;                       |     |     |     |     |     |      _________ Ch: Yellow left
;                       |     |     |     |     |     |     |      ___ Eh: Yellow right
;                       |     |     |     |     |     |     |     |
$84:C70A             dw BCAF, BCB5, BCBB, BCC1, BCC7, BCCD, BCD3, BCD9  ; Instruction list
$84:C71A             dw C046, 0000, C048, 0000, C04A, 0000, C04C, 0000  ; Block type / BTS for block to the left
$84:C72A             dw 0000, C047, 0000, C049, 0000, C04B, 0000, C04D  ; Block type / BTS for block to the right
}


;;; $C73A: Setup - PLM $C83A (upwards gate shotblock) ;;;
{
$84:C73A BE C7 1D    LDX $1DC7,y            ;\
$84:C73D BD 64 C7    LDA $C764,x            ;} PLM instruction list pointer = [$C764 + [PLM room argument]]
$84:C740 99 27 1D    STA $1D27,y            ;/
$84:C743 BE C7 1D    LDX $1DC7,y            ;\
$84:C746 BD 74 C7    LDA $C774,x            ;} If [$C774 + [PLM room argument]] != 0:
$84:C749 F0 08       BEQ $08    [$C753]     ;/
$84:C74B BE 87 1C    LDX $1C87,y            ;\
$84:C74E CA          DEX                    ;|
$84:C74F CA          DEX                    ;} Block to the left's block type / BTS = [$C774 + [PLM room argument]]
$84:C750 20 B4 82    JSR $82B4  [$84:82B4]  ;/

$84:C753 BE C7 1D    LDX $1DC7,y            ;\
$84:C756 BD 84 C7    LDA $C784,x            ;} If [$C784 + [PLM room argument]] != 0:
$84:C759 F0 08       BEQ $08    [$C763]     ;/
$84:C75B BE 87 1C    LDX $1C87,y            ;\
$84:C75E E8          INX                    ;|
$84:C75F E8          INX                    ;} Block to the right's block type / BTS = [$C784 + [PLM room argument]]
$84:C760 20 B4 82    JSR $82B4  [$84:82B4]  ;/

$84:C763 60          RTS

;                        _____________________________________________ 0: Blue left
;                       |      _______________________________________ 2: Blue right
;                       |     |      _________________________________ 4: Red left
;                       |     |     |      ___________________________ 6: Red right
;                       |     |     |     |      _____________________ 8: Green left
;                       |     |     |     |     |      _______________ Ah: Green right
;                       |     |     |     |     |     |      _________ Ch: Yellow left
;                       |     |     |     |     |     |     |      ___ Eh: Yellow right
;                       |     |     |     |     |     |     |     |
$84:C764             dw BCDF, BCE5, BCEB, BCF1, BCF7, BCFD, BD03, BD09  ; Instruction list
$84:C774             dw C046, 0000, C048, 0000, C04A, 0000, C04C, 0000  ; Block type / BTS for block to the left
$84:C784             dw 0000, C047, 0000, C049, 0000, C04B, 0000, C04D  ; Block type / BTS for block to the right
}


;;; $C794: Setup - door $BAF4/$C842/$C848/$C84E/$C854 (grey door) ;;;
{
$84:C794 B9 C8 1D    LDA $1DC8,y[$7E:1E06]  ;\
$84:C797 29 7C 00    AND #$007C             ;|
$84:C79A 4A          LSR A                  ;} PLM grey door type = [PLM room argument] >> 9 & 3Eh
$84:C79B 99 17 1E    STA $1E17,y[$7E:1E55]  ;/
$84:C79E B9 C7 1D    LDA $1DC7,y[$7E:1E05]  ;\
$84:C7A1 29 FF 83    AND #$83FF             ;} PLM room argument &= ~7C00h
$84:C7A4 99 C7 1D    STA $1DC7,y[$7E:1E05]  ;/
$84:C7A7 BE 87 1C    LDX $1C87,y[$7E:1CC5]  ;\
$84:C7AA A9 44 C0    LDA #$C044             ;} Make PLM shotblock with BTS 44h (generic shot trigger)
$84:C7AD 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:C7B0 60          RTS
}


;;; $C7B1: Setup - door $C85A/$C860/$C866/$C86C/$C872/$C878/$C87E/$C884/$C88A/$C890/$C896/$C89C (coloured door) ;;;
{
$84:C7B1 BE 87 1C    LDX $1C87,y[$7E:1CD3]  ;\
$84:C7B4 A9 44 C0    LDA #$C044             ;} Make PLM shotblock with BTS 44h (generic shot trigger)
$84:C7B7 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:C7BA 60          RTS
}


;;; $C7BB: Setup - door $C8A2/$C8A8/$C8AE/$C8B4 (shot/bombed/grappled reaction, shootable, BTS 40h..43h. Blue door) ;;;
{
$84:C7BB AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:C7BE BD 18 0C    LDA $0C18,x[$7E:0C18]  ;|
$84:C7C1 29 00 0F    AND #$0F00             ;} If current projectile is power bomb:
$84:C7C4 C9 00 03    CMP #$0300             ;|
$84:C7C7 D0 07       BNE $07    [$C7D0]     ;/
$84:C7C9 A9 00 00    LDA #$0000             ;\
$84:C7CC 99 37 1C    STA $1C37,y[$7E:1C79]  ;} PLM ID = 0
$84:C7CF 60          RTS                    ; Return

$84:C7D0 BE 87 1C    LDX $1C87,y[$7E:1CCF]  ;\
$84:C7D3 BF 02 00 7F LDA $7F0002,x[$7F:4EC4];|
$84:C7D7 29 FF 0F    AND #$0FFF             ;} Make PLM block solid
$84:C7DA 09 00 80    ORA #$8000             ;|
$84:C7DD 9F 02 00 7F STA $7F0002,x[$7F:4EC4];/
$84:C7E1 60          RTS
}


;;; $C7E2: Setup - PLM $C83E (shot/bombed/grappled reaction, shootable, BTS 44h / collision reaction, special, BTS 44h. Generic shot trigger for a PLM) ;;;
{
;; Returns:
;;     Carry: Set if PLM found (unconditional collision), garbage otherwise
$84:C7E2 BB          TYX                    ;\
$84:C7E3 BD 87 1C    LDA $1C87,x[$7E:1CCB]  ;} A = [PLM block index]
$84:C7E6 9E 87 1C    STZ $1C87,x[$7E:1CCB]  ; PLM block index = 0
$84:C7E9 A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$84:C7EC DD 87 1C    CMP $1C87,x[$7E:1CD5]  ;\
$84:C7EF F0 05       BEQ $05    [$C7F6]     ;} If [PLM [X] block index] = [A]: go to BRANCH_FOUND
$84:C7F1 CA          DEX                    ;\
$84:C7F2 CA          DEX                    ;} X -= 2
$84:C7F3 10 F7       BPL $F7    [$C7EC]     ; If [X] >= 0: go to LOOP
$84:C7F5 60          RTS                    ; Return

; BRANCH_FOUND
$84:C7F6 AC DE 0D    LDY $0DDE  [$7E:0DDE]  ;\
$84:C7F9 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;|
$84:C7FC 29 FF 1F    AND #$1FFF             ;} PLM [X] shot status = [current projectile type] & 1FFFh | 8000h
$84:C7FF 09 00 80    ORA #$8000             ;|
$84:C802 9D 77 1D    STA $1D77,x[$7E:1DC3]  ;/
$84:C805 60          RTS
}
}


;;; $C806: PLM entries ;;;
{
$84:C806             dw C54D,AAE3       ; Shot/bombed/grappled reaction, shootable, BTS 4Ah. Left green gate trigger
$84:C80A             dw C56C,AAE3       ; Shot/bombed/grappled reaction, shootable, BTS 4Bh. Right green gate trigger
$84:C80E             dw C58B,AAE3       ; Shot/bombed/grappled reaction, shootable, BTS 48h. Left red gate trigger
$84:C812             dw C5AF,AAE3       ; Shot/bombed/grappled reaction, shootable, BTS 49h. Right red gate trigger
$84:C816             dw C610,AAE3       ; Shot/bombed/grappled reaction, shootable, BTS 46h. Left blue gate trigger
$84:C81A             dw C627,AAE3       ; Shot/bombed/grappled reaction, shootable, BTS 47h. Right blue gate trigger
$84:C81E             dw C5D3,AAE3       ; Shot/bombed/grappled reaction, shootable, BTS 4Ch. Left yellow gate trigger
$84:C822             dw C5F1,AAE3       ; Shot/bombed/grappled reaction, shootable, BTS 4Dh. Right yellow gate trigger
$84:C826             dw C6D8,BC13       ; Downwards open gate
$84:C82A             dw C6BE,BC3A       ; Downwards closed gate
$84:C82E             dw C6DC,BC61       ; Upwards open gate
$84:C832             dw C6CB,BC88       ; Upwards closed gate
$84:C836             dw C6E0,BCAF       ; Downwards gate shotblock
$84:C83A             dw C73A,BCDF       ; Upwards gate shotblock
$84:C83E             dw C7E2,AAE3       ; Shot/bombed/grappled reaction, shootable, BTS 44h / collision reaction, special, BTS 44h. Generic shot trigger for a PLM
$84:C842             dw C794,BE70,BE59  ; Door. Grey door facing left
$84:C848             dw C794,BED9,BEC2  ; Door. Grey door facing right
$84:C84E             dw C794,BF42,BF2B  ; Door. Grey door facing up
$84:C854             dw C794,BFAB,BF94  ; Door. Grey door facing down
$84:C85A             dw C7B1,C014,BFFD  ; Door. Yellow door facing left
$84:C860             dw C7B1,C077,C060  ; Door. Yellow door facing right
$84:C866             dw C7B1,C0DA,C0C3  ; Door. Yellow door facing up
$84:C86C             dw C7B1,C139,C122  ; Door. Yellow door facing down
$84:C872             dw C7B1,C19C,C185  ; Door. Green door facing left
$84:C878             dw C7B1,C1FB,C1E4  ; Door. Green door facing right
$84:C87E             dw C7B1,C25A,C243  ; Door. Green door facing up
$84:C884             dw C7B1,C2B9,C2A2  ; Door. Green door facing down
$84:C88A             dw C7B1,C318,C301  ; Door. Red door facing left
$84:C890             dw C7B1,C37A,C363  ; Door. Red door facing right
$84:C896             dw C7B1,C3DC,C3C5  ; Door. Red door facing up
$84:C89C             dw C7B1,C43E,C427  ; Door. Red door facing down
$84:C8A2             dw C7BB,C489,C49E  ; Door. shot/bombed/grappled reaction, shootable, BTS 40h. Blue facing left
$84:C8A8             dw C7BB,C4BA,C4CF  ; Door. shot/bombed/grappled reaction, shootable, BTS 41h. Blue facing right
$84:C8AE             dw C7BB,C4EB,C500  ; Door. shot/bombed/grappled reaction, shootable, BTS 42h. Blue facing up
$84:C8B4             dw C7BB,C51C,C531  ; Door. shot/bombed/grappled reaction, shootable, BTS 43h. Blue facing down
$84:C8BA             dw B3C1,C49E       ; Blue door closing facing left
$84:C8BE             dw B3C1,C4CF       ; Blue door closing facing right
$84:C8C2             dw B3C1,C500       ; Blue door closing facing up
$84:C8C6             dw B3C1,C531       ; Blue door closing facing down
$84:C8CA             dw B3C1,BB34,BB44  ; Door. Gate that closes during escape in room after Mother Brain
$84:C8D0             dw B3C1,BB44       ; PLM version of the above
}


;;; $C8D4..CDC1: Instruction lists ;;;
{
;;; $C8D4: Instruction list - PLM $CFEC (unused. Draws 1x1 shot block) ;;;
{
$84:C8D4             dx 0001,A475,
                        86BC            ; Delete
}


;;; $C8DA: Instruction list - PLM $CFF0 (unused. Draws 1x2 shot block) ;;;
{
$84:C8DA             dx 0001,A47B,
                        86BC            ; Delete
}


;;; $C8E0: Instruction list - PLM $CFF4 (unused. Draws 2x1 shot block) ;;;
{
$84:C8E0             dx 0001,A483,
                        86BC            ; Delete
}


;;; $C8E6: Instruction list - PLM $CFF8 (unused. Draws 2x2 shot block) ;;;
{
$84:C8E6             dx 0001,A48B,
                        86BC            ; Delete
}


;;; $C8EC: Instruction list - PLM $CFFC (bomb reaction, special block, BTS 0/4. 1x1 (respawning) crumble block) ;;;
{
$84:C8EC             dx 0001,A49B,
                        86BC            ; Delete
}


;;; $C8F2: Instruction list - PLM $D000 (bomb reaction, special block, BTS 1/5. 2x1 (respawning) crumble block) ;;;
{
$84:C8F2             dx 0001,A4A1,
                        86BC            ; Delete
}


;;; $C8F8: Instruction list - PLM $D004 (bomb reaction, special block, BTS 2/6. 1x2 (respawning) crumble block) ;;;
{
$84:C8F8             dx 0001,A4A9,
                        86BC            ; Delete
}


;;; $C8FE: Instruction list - PLM $D008 (bomb reaction, special block, BTS 3/7. 2x2 (respawning) crumble block) ;;;
{
$84:C8FE             dx 0001,A4B1,
                        86BC            ; Delete
}


;;; $C904: Instruction list - PLM $D00C (unused) ;;;
{
$84:C904             dx 0001,A4C1,
                        86BC            ; Delete
}


;;; $C90A: Instruction list - PLM $D010 (unused) ;;;
{
$84:C90A             dx 0001,A4C7,
                        86BC            ; Delete
}


;;; $C910: Instruction list - PLM $D014 (unused) ;;;
{
$84:C910             dx 0001,A4CF,
                        86BC            ; Delete
}


;;; $C916: Instruction list - PLM $D018 (unused) ;;;
{
$84:C916             dx 0001,A4D7,
                        86BC            ; Delete
}


;;; $C91C: Instruction list - PLM $D01C (unused) / power bomb block bombed ;;;
{
$84:C91C             dx 0001,A4E7,
                        86BC            ; Delete
}


;;; $C922: Instruction list - PLM $D020 (unused) / super missile block bombed ;;;
{
$84:C922             dx 0001,A4ED,
                        86BC            ; Delete
}


;;; $C928: Instruction list - PLM $D024 (bomb reaction, special block, BTS 0Eh/0Fh / Brinstar 82h/83h/84h/85h. Speed block) ;;;
{
$84:C928             dx 0001,A4F3,
                        86BC            ; Delete
}


;;; $C92E: Instruction list - PLM $D028 (unused) ;;;
{
$84:C92E             dx 8C10,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 6 (block destroyed by contact damage)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0180,A357,
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B17,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $C951: Instruction list - PLM $D030 (collision reaction, special, BTS Brinstar 82h. Respawning speed block, slower crumble animation) ;;;
{
$84:C951             dx 8C7C,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 1 (block destroyed by contact damage)
                        0002,A345,
                        0002,A34B,
                        0002,A351,
                        0030,A357,
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B17,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $C974: Instruction list - PLM $D038 (collision reaction, special, BTS Eh. Respawning speed boost block) ;;;
{
$84:C974             dx 8C7C,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 1 (block destroyed by contact damage)
                        0001,A345,
                        0001,A34B,
                        0001,A351,
                        0030,A357,
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B17,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $C997: Instruction list - PLM $D03C (collision reaction, special, BTS Brinstar 84h. Respawning speed block) ;;;
{
$84:C997             dx 8C7C,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 1 (block destroyed by contact damage)
                        0001,A345,
                        0001,A34B,
                        0001,A351,
                        0030,A357,
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B05,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $C9BA: Instruction list - PLM $D02C (unused) ;;;
{
$84:C9BA             dx 8C10,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 6 (block destroyed by contact damage)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0001,A357,
                        86BC            ; Delete
}


;;; $C9CF: Instruction list - PLM $D034 (collision reaction, special, BTS Brinstar 83h. Speed block, slower crumble animation) ;;;
{
$84:C9CF             dx 8C7C,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 1 (block destroyed by contact damage)
                        0002,A345,
                        0002,A34B,
                        0002,A351,
                        0001,A357,
                        86BC            ; Delete
}


;;; $C9E4: Instruction list - PLM $D040 (collision reaction, special, BTS Fh / Brinstar 85h. Speed boost block) ;;;
{
$84:C9E4             dx 8C7C,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 1 (block destroyed by contact damage)
                        0001,A345,
                        0001,A34B,
                        0001,A351,
                        0001,A357,
                        86BC            ; Delete
}


;;; $C9F9: Instruction list - PLM $D044 (collision reaction, special, BTS 0. 1x1 respawning crumble block) ;;;
{
$84:C9F9             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0008,A345,
                        0006,A34B,
                        0004,A351,
                        0010,A357,
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B17,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $CA1C: Instruction list - PLM $D048 (collision reaction, special, BTS 1. 2x1 respawning crumble block) ;;;
{
$84:CA1C             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A35D,
                        0004,A365,
                        0004,A36D,
                        0010,A375,
                        0004,A36D,
                        0004,A365,
                        0004,A35D,
                        0001,A4A1,
                        86BC            ; Delete
}


;;; $CA41: Instruction list - PLM $D04C (collision reaction, special, BTS 2. 1x2 respawning crumble block) ;;;
{
$84:CA41             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A37D,
                        0004,A385,
                        0004,A38D,
                        0020,A395,
                        0004,A38D,
                        0004,A385,
                        0004,A37D,
                        0001,A4A9,
                        86BC            ; Delete
}


;;; $CA66: Instruction list - PLM $D050 (collision reaction, special, BTS 3. 2x2 respawning crumble block) ;;;
{
$84:CA66             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A39D,
                        0004,A3AD,
                        0004,A3BD,
                        0020,A3CD,
                        0004,A3BD,
                        0004,A3AD,
                        0004,A39D,
                        0001,A4B1,
                        86BC            ; Delete
}


;;; $CA8B: Instruction list - PLM $D054 (collision reaction, special, BTS 4. 1x1 crumble block) ;;;
{
$84:CA8B             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0001,A357,
                        86BC            ; Delete
}


;;; $CAA0: Instruction list - PLM $D058 (collision reaction, special, BTS 5. 2x1 crumble block) ;;;
{
$84:CAA0             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A35D,
                        0004,A365,
                        0004,A36D,
                        0001,A375,
                        86BC            ; Delete
}


;;; $CAB5: Instruction list - PLM $D05C (collision reaction, special, BTS 6. 1x2 crumble block) ;;;
{
$84:CAB5             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A37D,
                        0004,A385,
                        0004,A38D,
                        0001,A395,
                        86BC            ; Delete
}


;;; $CACA: Instruction list - PLM $D060 (collision reaction, special, BTS 7. 2x2 crumble block) ;;;
{
$84:CACA             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A39D,
                        0004,A3AD,
                        0004,A3BD,
                        0001,A3CD,
                        86BC            ; Delete
}


;;; $CADF: Instruction list - PLM $D064 (shot/bombed/grappled reaction, shootable, BTS 0. 1x1 respawning shot block) ;;;
{
$84:CADF             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0180,A357,
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B17,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $CB02: Instruction list - PLM $D068 (shot/bombed/grappled reaction, shootable, BTS 1. 2x1 respawning shot block) ;;;
{
$84:CB02             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A35D,
                        0004,A365,
                        0004,A36D,
                        0180,A375,
                        0004,A36D,
                        0004,A365,
                        0004,A35D,
                        0001,A47B,
                        86BC            ; Delete
}


;;; $CB27: Instruction list - PLM $D06C (shot/bombed/grappled reaction, shootable, BTS 2. 1x2 respawning shot block) ;;;
{
$84:CB27             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A37D,
                        0004,A385,
                        0004,A38D,
                        0180,A395,
                        0004,A38D,
                        0004,A385,
                        0004,A37D,
                        0001,A483,
                        86BC            ; Delete
}


;;; $CB4C: Instruction list - PLM $D070 (shot/bombed/grappled reaction, shootable, BTS 3. 2x2 respawning shot block) ;;;
{
$84:CB4C             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A39D,
                        0004,A3AD,
                        0004,A3BD,
                        0180,A3CD,
                        0004,A3BD,
                        0004,A3AD,
                        0004,A39D,
                        0001,A48B,
                        86BC            ; Delete
}


;;; $CB71: Instruction list - PLM $D08C (shot/bombed/grappled reaction, shootable, BTS Ah. Respawning super missile block) ;;;
{
$84:CB71             dx 8C10,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 6 (block crumbled)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0180,A357,
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B17,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $CB94: Instruction list - PLM $D084 (shot/bombed/grappled reaction, shootable, BTS 8. Respawning power bomb block) ;;;
{
$84:CB94             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0180,A357,
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B17,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $CBB7: Instruction list - PLM $D074 (shot/bombed/grappled reaction, shootable, BTS 4. 1x1 shot block) ;;;
{
$84:CBB7             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0001,A357,
                        86BC            ; Delete
}


;;; $CBCC: Instruction list - PLM $D078 (shot/bombed/grappled reaction, shootable, BTS 5. 2x1 shot block) ;;;
{
$84:CBCC             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A35D,
                        0004,A365,
                        0004,A36D,
                        0001,A375,
                        86BC            ; Delete
}


;;; $CBE1: Instruction list - PLM $D07C (shot/bombed/grappled reaction, shootable, BTS 6. 1x2 shot block) ;;;
{
$84:CBE1             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A37D,
                        0004,A385,
                        0004,A38D,
                        0001,A395,
                        86BC            ; Delete
}


;;; $CBF6: Instruction list - PLM $D080 (shot/bombed/grappled reaction, shootable, BTS 7. 2x2 shot block) ;;;
{
$84:CBF6             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0004,A39D,
                        0004,A3AD,
                        0004,A3BD,
                        0001,A3CD,
                        86BC            ; Delete
}


;;; $CC0B: Instruction list - PLM $D090 (shot/bombed/grappled reaction, shootable, BTS Bh. Super missile block) ;;;
{
$84:CC0B             dx 8C10,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 6 (block crumbled)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0001,A357,
                        86BC            ; Delete
}


;;; $CC20: Instruction list - PLM $D088 (shot/bombed/grappled reaction, shootable, BTS 9. Power bomb block) ;;;
{
$84:CC20             dx 8C7C,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 1 (block crumbled)
                        0003,A345,
                        0002,A34B,
                        0001,A351,
                        0001,A357,
                        86BC            ; Delete
}


;;; $CC35: Instruction list - PLM $D098 (collision reaction, bombable, BTS 0. 1x1 respawning bomb block) ;;;
{
$84:CC35             dx 8C46,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 3 (block destroyed by contact damage)
                        8724,CC3F       ; Go to $CC3F
}


;;; $CC3C: Instruction list - PLM $D0B8 (shot/bombed/grappled reaction, bombable, BTS 0. 1x1 respawning bomb block) ;;;
{
$84:CC3C             dx 8C46,0A         ; Queue sound Ah, sound library 2, max queued sounds allowed = 3 (block crumbled)
}


;;; $CC3F: Instruction list - 1x1 respawning bomb block ;;;
{
$84:CC3F             dw 0004,A345,
                        0004,A34B,
                        0004,A351,
                        0180,A357,
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B17,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $CC5F: Instruction list - PLM $D09C (collision reaction, bombable, BTS 1. 2x1 respawning bomb block) ;;;
{
$84:CC5F             dx 8C46,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 3 (block destroyed by contact damage)
                        8724,CC69       ; Go to $CC69
}


;;; $CC66: Instruction list - PLM $D0BC (shot/bombed/grappled reaction, bombable, BTS 1. 2x1 respawning bomb block) ;;;
{
$84:CC66             dx 8C46,0A         ; Queue sound Ah, sound library 2, max queued sounds allowed = 3 (block crumbled)
}


;;; $CC69: Instruction list - 2x1 respawning bomb block ;;;
{
$84:CC69             dx 0004,A35D,
                        0004,A365,
                        0004,A36D,
                        0180,A375,
                        0004,A36D,
                        0004,A365,
                        0004,A35D,
                        0001,A4C7,
                        86BC            ; Delete
}


;;; $CC8B: Instruction list - PLM $D0A0 (collision reaction, bombable, BTS 2. 1x2 respawning bomb block) ;;;
{
$84:CC8B             dx 8C46,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 3 (block destroyed by contact damage)
                        8724,CC95       ; Go to $CC95
}


;;; $CC92: Instruction list - PLM $D0C0 (shot/bombed/grappled reaction, bombable, BTS 2. 1x2 respawning bomb block) ;;;
{
$84:CC92             dx 8C46,0A         ; Queue sound Ah, sound library 2, max queued sounds allowed = 3 (block crumbled)
}


;;; $CC95: Instruction list - 1x2 respawning bomb block ;;;
{
$84:CC95             dx 0004,A37D,
                        0004,A385,
                        0004,A38D,
                        0180,A395,
                        0004,A38D,
                        0004,A385,
                        0004,A37D,
                        0001,A4CF,
                        86BC            ; Delete
}


;;; $CCB7: Instruction list - PLM $D0A4 (collision reaction, bombable, BTS 3. 2x2 respawning bomb block) ;;;
{
$84:CCB7             dx 8C46,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 3 (block destroyed by contact damage)
                        8724,CCC1       ; Go to $CCC1
}


;;; $CCBE: Instruction list - PLM $D0C4 (shot/bombed/grappled reaction, bombable, BTS 3. 2x2 respawning bomb block) ;;;
{
$84:CCBE             dx 8C46,0A         ; Queue sound Ah, sound library 2, max queued sounds allowed = 3 (block crumbled)
}


;;; $CCC1: Instruction list - 2x2 respawning bomb block ;;;
{
$84:CCC1             dx 0004,A39D,
                        0004,A3AD,
                        0004,A3BD,
                        0180,A3CD,
                        0004,A3BD,
                        0004,A3AD,
                        0004,A39D,
                        0001,A4D7,
                        86BC            ; Delete
}


;;; $CCE3: Instruction list - PLM $D0A8 (collision reaction, bombable, BTS 4. 1x1 bomb block) ;;;
{
$84:CCE3             dx 8C46,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 3 (block destroyed by contact damage)
                        8724,CCED       ; Go to $CCED
}


;;; $CCEA: Instruction list - PLM $D0C8 (shot/bombed/grappled reaction, bombable, BTS 4. 1x1 bomb block) ;;;
{
$84:CCEA             dx 8C46,0A         ; Queue sound Ah, sound library 2, max queued sounds allowed = 3 (block crumbled)
}


;;; $CCED: Instruction list - 1x1 bomb block ;;;
{
$84:CCED             dx 0004,A345,
                        0004,A34B,
                        0004,A351,
                        0001,A357,
                        86BC            ; Delete
}


;;; $CCFF: Instruction list - PLM $D0AC (collision reaction, bombable, BTS 5. 2x1 bomb block) ;;;
{
$84:CCFF             dx 8C46,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 3 (block destroyed by contact damage)
                        8724,CD09       ; Go to $CD09
}


;;; $CD06: Instruction list - PLM $D0CC (shot/bombed/grappled reaction, bombable, BTS 5. 2x1 bomb block) ;;;
{
$84:CD06             dx 8C46,0A         ; Queue sound Ah, sound library 2, max queued sounds allowed = 3 (block crumbled)
}


;;; $CD09: Instruction list - 2x1 bomb block ;;;
{
$84:CD09             dx 0004,A35D,
                        0004,A365,
                        0004,A36D,
                        0001,A375,
                        86BC            ; Delete
}


;;; $CD1B: Instruction list - PLM $D0B0 (collision reaction, bombable, BTS 6. 1x2 bomb block) ;;;
{
$84:CD1B             dx 8C46,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 3 (block destroyed by contact damage)
                        8724,CD25       ; Go to $CD25
}


;;; $CD22: Instruction list - PLM $D0D0 (shot/bombed/grappled reaction, bombable, BTS 6. 1x2 bomb block) ;;;
{
$84:CD22             dx 8C46,0A         ; Queue sound Ah, sound library 2, max queued sounds allowed = 3 (block crumbled)
}


;;; $CD25: Instruction list - 1x2 bomb block ;;;
{
$84:CD25             dx 0004,A37D,
                        0004,A385,
                        0004,A38D,
                        0001,A395,
                        86BC            ; Delete
}


;;; $CD37: Instruction list - PLM $D0B4 (collision reaction, bombable, BTS 7. 2x2 bomb block) ;;;
{
$84:CD37             dx 8C46,06,        ; Queue sound 6, sound library 2, max queued sounds allowed = 3 (block destroyed by contact damage)
                        8724,CD41       ; Go to $CD41
}


;;; $CD3E: Instruction list - PLM $D0D4 (shot/bombed/grappled reaction, bombable, BTS 7. 2x2 bomb block) ;;;
{
$84:CD3E             dx 8C46,0A         ; Queue sound Ah, sound library 2, max queued sounds allowed = 3 (block crumbled)
}


;;; $CD41: Instruction list - 2x2 bomb block ;;;
{
$84:CD41             dx 0004,A39D,
                        0004,A3AD,
                        0004,A3BD,
                        0001,A3CD,
                        86BC            ; Delete
}


;;; $CD53: Instruction list - PLM $D094 (enemy collision reaction, spike block, BTS Fh. Enemy breakable block) ;;;
{
$84:CD53             dx 8C46,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 3 (block crumbled)
                        0004,A345,
                        0004,A34B,
                        0004,A351,
                        0001,A357,
                        86BC            ; Delete
}


;;; $CD68: Instruction list - PLM $D0D8/$D0E4/$D0E8 (grappled reaction, spike block / grapple block, BTS 0/3. Grapple block) ;;;
{
$84:CD68             dx 86BC            ; Delete
}


;;; $CD6A: Instruction list - PLM $D0DC (grappled reaction, grapple block, BTS 1. Respawning breakable grapple block) ;;;
{
$84:CD6A             dx 00F0,A4F9,
                        8C10,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 6 (block crumbled)
                        0004,A4FF,
                        0004,A505,
                        0004,A50B,
                        0006,A511,
                        0004,A50B,
                        0004,A505,
                        0004,A4FF,
                        CD93,           ; PLM BTS = 1
                        8B17,           ; Draw PLM block
                        86BC            ; Delete
}


;;; $CD93: PLM BTS = 1 ;;;
{
$84:CD93 DA          PHX
$84:CD94 BD 87 1C    LDA $1C87,x[$7E:1CD5]
$84:CD97 4A          LSR A
$84:CD98 AA          TAX
$84:CD99 BF 02 64 7F LDA $7F6402,x[$7F:6451]
$84:CD9D 29 00 FF    AND #$FF00
$84:CDA0 09 01 00    ORA #$0001
$84:CDA3 9F 02 64 7F STA $7F6402,x[$7F:6451]
$84:CDA7 FA          PLX
$84:CDA8 60          RTS
}


;;; $CDA9: Instruction list - PLM $D0E0 (grappled reaction, grapple block, BTS 2. Breakable grapple block) ;;;
{
$84:CDA9             dx 0078,A4F9,
                        8C10,0A,        ; Queue sound Ah, sound library 2, max queued sounds allowed = 6 (block crumbled)
                        0004,A4FF,
                        0004,A505,
                        0004,A50B,
                        0001,A511,
                        86BC            ; Delete
}
}


;;; $CDC2..CFEB: Setups ;;;
{
;;; $CDC2: Setup - PLM $D028/$D02C (unused) ;;;
{
$84:CDC2 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:CDC5 C9 81 00    CMP #$0081             ;|
$84:CDC8 F0 05       BEQ $05    [$CDCF]     ;} If Samus is screw attacking:
$84:CDCA C9 82 00    CMP #$0082             ;|
$84:CDCD D0 13       BNE $13    [$CDE2]     ;/

$84:CDCF BE 87 1C    LDX $1C87,y            ;\
$84:CDD2 BF 02 00 7F LDA $7F0002,x          ;|
$84:CDD6 99 17 1E    STA $1E17,y            ;} Make PLM block air
$84:CDD9 29 FF 0F    AND #$0FFF             ;|
$84:CDDC 9F 02 00 7F STA $7F0002,x          ;/
$84:CDE0 18          CLC
$84:CDE1 60          RTS                    ; Return

$84:CDE2 A9 00 00    LDA #$0000             ;\
$84:CDE5 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:CDE8 38          SEC
$84:CDE9 60          RTS
}


;;; $CDEA: Setup - PLM $D030/$D034/$D038/$D03C/$D040 (collision reaction, special, BTS Eh/Fh / Brinstar 82h..85h. Respawning speed boost block) ;;;
{
;; Returns:
;;     Carry: Set if collision, clear otherwise
$84:CDEA AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$84:CDED 29 00 0F    AND #$0F00             ;|
$84:CDF0 C9 00 04    CMP #$0400             ;} If Samus is not speed boosting:
$84:CDF3 F0 29       BEQ $29    [$CE1E]     ;/
$84:CDF5 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:CDF8 C9 C9 00    CMP #$00C9             ;|
$84:CDFB F0 21       BEQ $21    [$CE1E]     ;|
$84:CDFD C9 CA 00    CMP #$00CA             ;|
$84:CE00 F0 1C       BEQ $1C    [$CE1E]     ;|
$84:CE02 C9 CB 00    CMP #$00CB             ;|
$84:CE05 F0 17       BEQ $17    [$CE1E]     ;} If Samus is not shinesparking:
$84:CE07 C9 CC 00    CMP #$00CC             ;|
$84:CE0A F0 12       BEQ $12    [$CE1E]     ;|
$84:CE0C C9 CD 00    CMP #$00CD             ;|
$84:CE0F F0 0D       BEQ $0D    [$CE1E]     ;|
$84:CE11 C9 CE 00    CMP #$00CE             ;|
$84:CE14 F0 08       BEQ $08    [$CE1E]     ;/
$84:CE16 A9 00 00    LDA #$0000             ;\
$84:CE19 99 37 1C    STA $1C37,y[$7E:1C7F]  ;} PLM ID = 0
$84:CE1C 38          SEC                    ;\
$84:CE1D 60          RTS                    ;} Return carry set

$84:CE1E BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:CE21 BF 02 00 7F LDA $7F0002,x[$7F:099A];|
$84:CE25 29 00 F0    AND #$F000             ;} PLM respawn block = [PLM block] & F000h | B6h
$84:CE28 09 B6 00    ORA #$00B6             ;|
$84:CE2B 99 17 1E    STA $1E17,y[$7E:1E65]  ;/
$84:CE2E 29 FF 0F    AND #$0FFF             ;\
$84:CE31 9F 02 00 7F STA $7F0002,x[$7F:099A];} PLM block = 00B6h
$84:CE35 18          CLC                    ;\
$84:CE36 60          RTS                    ;} Return carry clear
}


;;; $CE37: Setup - PLM $D044/$D048/$D04C/$D050/$D054/$D058/$D05C/$D060 (collision reaction, special, BTS 0..7. (Respawning) crumble block) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
$84:CE37 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:CE3A 29 0F 00    AND #$000F             ;|
$84:CE3D C9 03 00    CMP #$0003             ;} If [collision direction] = down:
$84:CE40 D0 21       BNE $21    [$CE63]     ;/
$84:CE42 BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:CE45 BF 02 00 7F LDA $7F0002,x[$7F:0230];|
$84:CE49 29 00 F0    AND #$F000             ;} PLM respawn block = [PLM block] & F000h | BCh
$84:CE4C 09 BC 00    ORA #$00BC             ;|
$84:CE4F 99 17 1E    STA $1E17,y[$7E:1E65]  ;/
$84:CE52 29 FF 8F    AND #$8FFF             ;\
$84:CE55 9F 02 00 7F STA $7F0002,x[$7F:0230];} PLM block = [PLM block] & 8000h | BCh
$84:CE59 BB          TYX                    ;\
$84:CE5A A9 04 00    LDA #$0004             ;} PLM instruction timer = 4
$84:CE5D 9F 1C DE 7E STA $7EDE1C,x[$7E:DE6A];/
$84:CE61 38          SEC                    ;\
$84:CE62 60          RTS                    ;} Return carry set

$84:CE63 A9 00 00    LDA #$0000             ;\
$84:CE66 99 37 1C    STA $1C37,y[$7E:1C77]  ;} PLM ID = 0
$84:CE69 38          SEC                    ;\
$84:CE6A 60          RTS                    ;} Return carry set
}


;;; $CE6B: Setup - PLM $D064/$D068/$D06C/$D070 (shot/bombed/grappled reaction, shootable, BTS 0..3. Respawning shot block) ;;;
{
; Note that the PLM respawn block is only used by the 1x1 case
$84:CE6B BE 87 1C    LDX $1C87,y[$7E:1CCD]  ;\
$84:CE6E BF 02 00 7F LDA $7F0002,x[$7F:018E];|
$84:CE72 29 00 F0    AND #$F000             ;} PLM respawn block = [PLM block] & F000h | 52h
$84:CE75 09 52 00    ORA #$0052             ;|
$84:CE78 99 17 1E    STA $1E17,y[$7E:1E5D]  ;/
$84:CE7B 29 FF 8F    AND #$8FFF             ;\
$84:CE7E 9F 02 00 7F STA $7F0002,x[$7F:018E];} PLM block = [PLM block] & 8000h | 52h
$84:CE82 60          RTS
}


;;; $CE83: Setup - PLM $D098/$D09C/$D0A0/$D0A4/$D0A8/$D0AC/$D0B0/$D0B4 (collision reaction, bombable, BTS 0..7. (Respawning) bomb block) ;;;
{
$84:CE83 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$84:CE86 29 00 0F    AND #$0F00             ;|
$84:CE89 C9 00 04    CMP #$0400             ;} If Samus is not speed boosting:
$84:CE8C F0 33       BEQ $33    [$CEC1]     ;/
$84:CE8E AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:CE91 C9 81 00    CMP #$0081             ;|
$84:CE94 F0 2B       BEQ $2B    [$CEC1]     ;} If Samus is not screw attacking:
$84:CE96 C9 82 00    CMP #$0082             ;|
$84:CE99 F0 26       BEQ $26    [$CEC1]     ;/
$84:CE9B C9 C9 00    CMP #$00C9             ;\
$84:CE9E F0 21       BEQ $21    [$CEC1]     ;|
$84:CEA0 C9 CA 00    CMP #$00CA             ;|
$84:CEA3 F0 1C       BEQ $1C    [$CEC1]     ;|
$84:CEA5 C9 CB 00    CMP #$00CB             ;|
$84:CEA8 F0 17       BEQ $17    [$CEC1]     ;|
$84:CEAA C9 CC 00    CMP #$00CC             ;} If Samus is not shinesparking:
$84:CEAD F0 12       BEQ $12    [$CEC1]     ;|
$84:CEAF C9 CD 00    CMP #$00CD             ;|
$84:CEB2 F0 0D       BEQ $0D    [$CEC1]     ;|
$84:CEB4 C9 CE 00    CMP #$00CE             ;|
$84:CEB7 F0 08       BEQ $08    [$CEC1]     ;/
$84:CEB9 A9 00 00    LDA #$0000             ;\
$84:CEBC 99 37 1C    STA $1C37,y[$7E:1C7B]  ;} PLM ID = 0
$84:CEBF 38          SEC
$84:CEC0 60          RTS                    ; Return

$84:CEC1 BE 87 1C    LDX $1C87,y[$7E:1CCF]  ;\
$84:CEC4 BF 02 00 7F LDA $7F0002,x[$7F:5428];|
$84:CEC8 29 00 F0    AND #$F000             ;} PLM respawn block = [PLM block] & F000h | 58h
$84:CECB 09 58 00    ORA #$0058             ;|
$84:CECE 99 17 1E    STA $1E17,y[$7E:1E5F]  ;/
$84:CED1 29 FF 0F    AND #$0FFF             ;\
$84:CED4 9F 02 00 7F STA $7F0002,x[$7F:5428];} PLM block = 0058h
$84:CED8 18          CLC
$84:CED9 60          RTS
}


;;; $CEDA: Setup - PLM $D0B8/$D0BC/$D0C0/$D0C4/$D0C8/$D0CC/$D0D0/$D0D4 (shot/bombed/grappled reaction, bombable, BTS 0..7. (Respawning) bomb block) ;;;
{
$84:CEDA AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:CEDD BD 18 0C    LDA $0C18,x[$7E:0C22]  ;|
$84:CEE0 29 00 0F    AND #$0F00             ;} If current projectile is bomb: go to BRANCH_BOMB
$84:CEE3 C9 00 05    CMP #$0500             ;|
$84:CEE6 F0 24       BEQ $24    [$CF0C]     ;/
$84:CEE8 C9 00 03    CMP #$0300             ;\
$84:CEEB F0 07       BEQ $07    [$CEF4]     ;} If current projectile is power bomb: go to BRANCH_POWER_BOMB
$84:CEED A9 00 00    LDA #$0000             ;\
$84:CEF0 99 37 1C    STA $1C37,y[$7E:1C83]  ;} PLM ID = 0
$84:CEF3 60          RTS                    ; Return

; BRANCH_POWER_BOMB
$84:CEF4 BE 87 1C    LDX $1C87,y[$7E:1CCB]  ;\
$84:CEF7 BF 02 00 7F LDA $7F0002,x[$7F:064E];|
$84:CEFB 29 00 F0    AND #$F000             ;} PLM respawn block = [PLM block] & F000h | 58h
$84:CEFE 09 58 00    ORA #$0058             ;|
$84:CF01 99 17 1E    STA $1E17,y[$7E:1E5B]  ;/
$84:CF04 29 FF 8F    AND #$8FFF             ;\
$84:CF07 9F 02 00 7F STA $7F0002,x[$7F:064E];} PLM block = [PLM block] & 8000h | 58h
$84:CF0B 60          RTS                    ; Return

; BRANCH_BOMB
$84:CF0C B9 27 1D    LDA $1D27,y[$7E:1D61]  ;\
$84:CF0F 18          CLC                    ;|
$84:CF10 69 03 00    ADC #$0003             ;} PLM instruction list pointer += 3
$84:CF13 99 27 1D    STA $1D27,y[$7E:1D61]  ;/
$84:CF16 BE 87 1C    LDX $1C87,y[$7E:1CC1]  ;\
$84:CF19 BF 02 00 7F LDA $7F0002,x[$7F:05C0];|
$84:CF1D 29 00 F0    AND #$F000             ;} PLM respawn block = [PLM block] & F000h | 58h
$84:CF20 09 58 00    ORA #$0058             ;|
$84:CF23 99 17 1E    STA $1E17,y[$7E:1E51]  ;/
$84:CF26 29 FF 8F    AND #$8FFF             ;\
$84:CF29 9F 02 00 7F STA $7F0002,x[$7F:05C0];} PLM block = [PLM block] & 8000h | 58h
$84:CF2D 60          RTS
}


;;; $CF2E: Setup - PLM $D084/$D088 (shot/bombed/grappled reaction, shootable, BTS 8/9. (Respawning) power bomb block) ;;;
{
$84:CF2E AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:CF31 BD 18 0C    LDA $0C18,x[$7E:0C22]  ;|
$84:CF34 29 00 0F    AND #$0F00             ;} If current projectile is bomb: go to BRANCH_BOMB
$84:CF37 C9 00 05    CMP #$0500             ;|
$84:CF3A F0 24       BEQ $24    [$CF60]     ;/
$84:CF3C C9 00 03    CMP #$0300             ;\
$84:CF3F F0 07       BEQ $07    [$CF48]     ;} If current projectile is power bomb: go to BRANCH_POWER_BOMB
$84:CF41 A9 00 00    LDA #$0000             ;\
$84:CF44 99 37 1C    STA $1C37,y[$7E:1C85]  ;} PLM ID = 0
$84:CF47 60          RTS                    ; Return

; BRANCH_POWER_BOMB
$84:CF48 BE 87 1C    LDX $1C87,y[$7E:1CD3]  ;\
$84:CF4B BF 02 00 7F LDA $7F0002,x[$7F:01A4];|
$84:CF4F 29 00 F0    AND #$F000             ;} PLM respawn block = [PLM block] & F000h | 57h
$84:CF52 09 57 00    ORA #$0057             ;|
$84:CF55 99 17 1E    STA $1E17,y[$7E:1E63]  ;/
$84:CF58 29 FF 8F    AND #$8FFF             ;\
$84:CF5B 9F 02 00 7F STA $7F0002,x[$7F:01A4];} PLM block = [PLM block] & 8000h | 57h
$84:CF5F 60          RTS                    ; Return

; BRANCH_BOMB
$84:CF60 A9 1C C9    LDA #$C91C             ;\
$84:CF63 99 27 1D    STA $1D27,y[$7E:1D69]  ;} PLM instruction list pointer = $C91C
$84:CF66 60          RTS
}


;;; $CF67: Setup - PLM $D08C/$D090 (shot/bombed/grappled reaction, shootable, BTS Ah/Bh. (Respawning) super missile block) ;;;
{
$84:CF67 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:CF6A BD 18 0C    LDA $0C18,x[$7E:0C18]  ;|
$84:CF6D 29 00 0F    AND #$0F00             ;} If current projectile is bomb: go to BRANCH_BOMB
$84:CF70 C9 00 05    CMP #$0500             ;|
$84:CF73 F0 24       BEQ $24    [$CF99]     ;/
$84:CF75 C9 00 02    CMP #$0200             ;\
$84:CF78 F0 07       BEQ $07    [$CF81]     ;} If current projectile is super missile: go to BRANCH_SUPER_MISSILE
$84:CF7A A9 00 00    LDA #$0000             ;\
$84:CF7D 99 37 1C    STA $1C37,y[$7E:1C83]  ;} PLM ID = 0
$84:CF80 60          RTS                    ; Return

; BRANCH_SUPER_MISSILE
$84:CF81 BE 87 1C    LDX $1C87,y[$7E:1CCD]  ;\
$84:CF84 BF 02 00 7F LDA $7F0002,x[$7F:0380];|
$84:CF88 29 00 F0    AND #$F000             ;} PLM respawn block = [PLM block] & F000h | 9Fh
$84:CF8B 09 9F 00    ORA #$009F             ;|
$84:CF8E 99 17 1E    STA $1E17,y[$7E:1E5D]  ;/
$84:CF91 29 FF 8F    AND #$8FFF             ;\
$84:CF94 9F 02 00 7F STA $7F0002,x[$7F:0380];} PLM block = [PLM block] & 8000h | 9Fh
$84:CF98 60          RTS                    ; Return

; BRANCH_BOMB
$84:CF99 A9 22 C9    LDA #$C922             ;\
$84:CF9C 99 27 1D    STA $1D27,y[$7E:1D6D]  ;} PLM instruction list pointer = $C922
$84:CF9F 60          RTS
}


;;; $CFA0: Setup - PLM $CFEC/$CFF0/$CFF4/$CFF8/$CFFC/$D000/$D004/$D008/$D00C/$D010/$D014/$D018/$D01C/$D020/$D024 (bomb reaction, special block, BTS 0..7 / Eh/Fh / Brinstar 82h..85h. (Respawning) crumble block / speed block / unused) ;;;
{
$84:CFA0 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;\
$84:CFA3 BD 18 0C    LDA $0C18,x[$7E:0C22]  ;|
$84:CFA6 29 00 0F    AND #$0F00             ;} If current projectile is not bomb:
$84:CFA9 C9 00 05    CMP #$0500             ;|
$84:CFAC F0 06       BEQ $06    [$CFB4]     ;/
$84:CFAE A9 00 00    LDA #$0000             ;\
$84:CFB1 99 37 1C    STA $1C37,y[$7E:1C71]  ;} PLM ID = 0

$84:CFB4 60          RTS
}


;;; $CFB5: Setup - PLM $D0DC/$D0E0 (grappled reaction, grapple block, BTS 1/2. (Respawning) breakable grapple block) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
;;     Overflow: Set. Connect grapple beam
$84:CFB5 BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:CFB8 BF 02 00 7F LDA $7F0002,x[$7F:00A2];} PLM respawn block = [PLM block]
$84:CFBC 99 17 1E    STA $1E17,y[$7E:1E65]  ;/
$84:CFBF 8A          TXA                    ;\
$84:CFC0 4A          LSR A                  ;|
$84:CFC1 AA          TAX                    ;|
$84:CFC2 BF 02 64 7F LDA $7F6402,x[$7F:6452];} PLM BTS = 0
$84:CFC6 29 00 FF    AND #$FF00             ;|
$84:CFC9 9F 02 64 7F STA $7F6402,x[$7F:6452];/
}


;;; $CFCD: Setup - PLM $D0D8 (grappled reaction, grapple block, BTS 0/3. Generic grapple block) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
;;     Overflow: Set. Connect grapple beam
$84:CFCD E2 40       SEP #$40
$84:CFCF 38          SEC
$84:CFD0 60          RTS
}


;;; $CFD1: Setup - PLM $D0E4 (grappled reaction, generic spike block) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
;;     Overflow: Clear. Cancel grapple beam
$84:CFD1 C2 40       REP #$40
$84:CFD3 38          SEC
$84:CFD4 60          RTS
}


;;; $CFD5: Setup - PLM $D0E8 (grappled reaction, spike block, BTS 3. Draygon's broken turret) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision
;;     Overflow: Set. Connect grapple beam

; Deal 1 damage to Samus
$84:CFD5 AD 4E 0A    LDA $0A4E  [$7E:0A4E]
$84:CFD8 18          CLC
$84:CFD9 69 00 00    ADC #$0000
$84:CFDC 8D 4E 0A    STA $0A4E  [$7E:0A4E]
$84:CFDF AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$84:CFE2 69 01 00    ADC #$0001             ;} Periodic damage += 1
$84:CFE5 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$84:CFE8 E2 40       SEP #$40               ;\
$84:CFEA 38          SEC                    ;} Return carry set, overflow set
$84:CFEB 60          RTS                    ;/
}
}


;;; $CFEC..D13E: PLM entries ;;;
{
$84:CFEC             dw CFA0,C8D4   ; Unused. Draws 1x1 shot block
$84:CFF0             dw CFA0,C8DA   ; Unused. Draws 1x2 shot block
$84:CFF4             dw CFA0,C8E0   ; Unused. Draws 2x1 shot block
$84:CFF8             dw CFA0,C8E6   ; Unused. Draws 2x2 shot block
$84:CFFC             dw CFA0,C8EC   ; Bomb reaction, special block, BTS 0/4. 1x1 (respawning) crumble block
$84:D000             dw CFA0,C8F2   ; Bomb reaction, special block, BTS 1/5. 2x1 (respawning) crumble block
$84:D004             dw CFA0,C8F8   ; Bomb reaction, special block, BTS 2/6. 1x2 (respawning) crumble block
$84:D008             dw CFA0,C8FE   ; Bomb reaction, special block, BTS 3/7. 2x2 (respawning) crumble block
$84:D00C             dw CFA0,C904   ; Unused
$84:D010             dw CFA0,C90A   ; Unused
$84:D014             dw CFA0,C910   ; Unused
$84:D018             dw CFA0,C916   ; Unused
$84:D01C             dw CFA0,C91C   ; Unused
$84:D020             dw CFA0,C922   ; Unused
$84:D024             dw CFA0,C928   ; Bomb reaction, special block, BTS Eh/Fh / Brinstar 82h/83h/84h/85h. Speed boost block
$84:D028             dw CDC2,C92E   ; Unused
$84:D02C             dw CDC2,C9BA   ; Unused
$84:D030             dw CDEA,C951   ; Collision reaction, special, BTS Brinstar 82h
$84:D034             dw CDEA,C9CF   ; Collision reaction, special, BTS Brinstar 83h
$84:D038             dw CDEA,C974   ; Collision reaction, special, BTS Eh. Respawning speed boost block
$84:D03C             dw CDEA,C997   ; Collision reaction, special, BTS Brinstar 84h. Respawning speed boost block (used by dachora pit)
$84:D040             dw CDEA,C9E4   ; Collision reaction, special, BTS Fh / Brinstar 85h. Speed boost block
$84:D044             dw CE37,C9F9   ; Collision reaction, special, BTS 0. 1x1 respawning crumble block
$84:D048             dw CE37,CA1C   ; Collision reaction, special, BTS 1. 2x1 respawning crumble block
$84:D04C             dw CE37,CA41   ; Collision reaction, special, BTS 2. 1x2 respawning crumble block
$84:D050             dw CE37,CA66   ; Collision reaction, special, BTS 3. 2x2 respawning crumble block
$84:D054             dw CE37,CA8B   ; Collision reaction, special, BTS 4. 1x1 crumble block
$84:D058             dw CE37,CAA0   ; Collision reaction, special, BTS 5. 2x1 crumble block
$84:D05C             dw CE37,CAB5   ; Collision reaction, special, BTS 6. 1x2 crumble block
$84:D060             dw CE37,CACA   ; Collision reaction, special, BTS 7. 2x2 crumble block
$84:D064             dw CE6B,CADF   ; Shot/bombed/grappled reaction, shootable, BTS 0. 1x1 respawning shot block
$84:D068             dw CE6B,CB02   ; Shot/bombed/grappled reaction, shootable, BTS 1. 2x1 respawning shot block
$84:D06C             dw CE6B,CB27   ; Shot/bombed/grappled reaction, shootable, BTS 2. 1x2 respawning shot block
$84:D070             dw CE6B,CB4C   ; Shot/bombed/grappled reaction, shootable, BTS 3. 2x2 respawning shot block
$84:D074             dw B3C1,CBB7   ; Shot/bombed/grappled reaction, shootable, BTS 4. 1x1 shot block
$84:D078             dw B3C1,CBCC   ; Shot/bombed/grappled reaction, shootable, BTS 5. 2x1 shot block
$84:D07C             dw B3C1,CBE1   ; Shot/bombed/grappled reaction, shootable, BTS 6. 1x2 shot block
$84:D080             dw B3C1,CBF6   ; Shot/bombed/grappled reaction, shootable, BTS 7. 2x2 shot block
$84:D084             dw CF2E,CB94   ; Shot/bombed/grappled reaction, shootable, BTS 8. Respawning power bomb block
$84:D088             dw CF2E,CC20   ; Shot/bombed/grappled reaction, shootable, BTS 9. Power bomb block
$84:D08C             dw CF67,CB71   ; Shot/bombed/grappled reaction, shootable, BTS A. Respawning super missile block
$84:D090             dw CF67,CC0B   ; Shot/bombed/grappled reaction, shootable, BTS B. Super missile block
$84:D094             dw B3D4,CD53   ; Enemy collision reaction, spike block, BTS Fh. Enemy breakable block
$84:D098             dw CE83,CC35   ; Collision reaction, bombable, BTS 0. 1x1 respawning bomb block
$84:D09C             dw CE83,CC5F   ; Collision reaction, bombable, BTS 1. 2x1 respawning bomb block
$84:D0A0             dw CE83,CC8B   ; Collision reaction, bombable, BTS 2. 1x2 respawning bomb block
$84:D0A4             dw CE83,CCB7   ; Collision reaction, bombable, BTS 3. 2x2 respawning bomb block
$84:D0A8             dw CE83,CCE3   ; Collision reaction, bombable, BTS 4. 1x1 bomb block
$84:D0AC             dw CE83,CCFF   ; Collision reaction, bombable, BTS 5. 2x1 bomb block
$84:D0B0             dw CE83,CD1B   ; Collision reaction, bombable, BTS 6. 1x2 bomb block
$84:D0B4             dw CE83,CD37   ; Collision reaction, bombable, BTS 7. 2x2 bomb block
$84:D0B8             dw CEDA,CC3C   ; Shot/bombed/grappled reaction, bombable, BTS 0. 1x1 respawning bomb block
$84:D0BC             dw CEDA,CC66   ; Shot/bombed/grappled reaction, bombable, BTS 1. 2x1 respawning bomb block
$84:D0C0             dw CEDA,CC92   ; Shot/bombed/grappled reaction, bombable, BTS 2. 1x2 respawning bomb block
$84:D0C4             dw CEDA,CCBE   ; Shot/bombed/grappled reaction, bombable, BTS 3. 2x2 respawning bomb block
$84:D0C8             dw CEDA,CCEA   ; Shot/bombed/grappled reaction, bombable, BTS 4. 1x1 bomb block
$84:D0CC             dw CEDA,CD06   ; Shot/bombed/grappled reaction, bombable, BTS 5. 2x1 bomb block
$84:D0D0             dw CEDA,CD22   ; Shot/bombed/grappled reaction, bombable, BTS 6. 1x2 bomb block
$84:D0D4             dw CEDA,CD3E   ; Shot/bombed/grappled reaction, bombable, BTS 7. 2x2 bomb block
$84:D0D8             dw CFCD,CD68   ; Grappled reaction, grapple block, BTS 0/3. Grapple block
$84:D0DC             dw CFB5,CD6A   ; Grappled reaction, grapple block, BTS 1. Respawning breakable grapple block
$84:D0E0             dw CFB5,CDA9   ; Grappled reaction, grapple block, BTS 2. Breakable grapple block
$84:D0E4             dw CFD1,CD68   ; Grappled reaction, generic spike block
$84:D0E8             dw CFD5,CD68   ; Grappled reaction, spike block, BTS 3. Draygon's broken turret


;;; $D0EC: Instruction list - PLM $D0F2 ;;;
{
$84:D0EC             dx 0001,924D,
                        86BC        ; Delete
}


$84:D0F2             dw B3C1,D0EC   ; Unused. Blue Brinstar face-block


;;; $D0F6: Instruction list - PLM $D113 (crumble Lower Norfair chozo room plug) ;;;
{
$84:D0F6             dx 0004,A345,
                        0004,A34B,
                        0004,A351,
                        0001,A357,
                        86BC        ; Delete
}


;;; $D108: Setup - PLM $D113 (crumble Lower Norfair chozo room plug) ;;;
{
$84:D108 BE 87 1C    LDX $1C87,y[$7E:1CCB]
$84:D10B 29 FF 0F    AND #$0FFF
$84:D10E 9F 02 00 7F STA $7F0002,x[$7F:158C]
$84:D112 60          RTS
}


$84:D113             dw D108,D0F6   ; Crumble Lower Norfair chozo room plug


;;; $D117: Setup - PLM $D127 ;;;
{
$84:D117 BE 87 1C    LDX $1C87  [$7E:1C87]
$84:D11A A9 00 C0    LDA #$C000
$84:D11D 20 B4 82    JSR $82B4  [$84:82B4]
$84:D120 60          RTS
}


;;; $D121: Instruction list - PLM $D127 ;;;
{
$84:D121             dx 0004,A33F,
                        86BC        ; Delete
}


$84:D127             dw D117,D121   ; Unused. Shot block


;;; $D12B: Setup - PLM $D13B ;;;
{
$84:D12B BE 87 1C    LDX $1C87  [$7E:1C87]
$84:D12E A9 00 E0    LDA #$E000             ;\
$84:D131 20 B4 82    JSR $82B4  [$84:82B4]  ;} PLM block = generic grapple block
$84:D134 60          RTS
}


;;; $D135: Instruction list - PLM $D13B ;;;
{
$84:D135             dx 0001,A4F9,
                        86BC        ; Delete
}


$84:D13B             dw D12B,D135   ; Unused. Grapple block
}


;;; $D13F..D5F5: Instructions and instruction lists ;;;
{
;;; $D13F: Instruction list - PLM $D6D6 (Lower Norfair chozo hand) ;;;
{
$84:D13F             dx 882D,000C,D14D, ; Go to $D14D if the event 000Ch is set
                        86C1,D15C,      ; Pre-instruction = delete PLM and spawn trigger block if block (4, 8) is a blank air block
                        86B4,           ; Sleep
                        86BC            ; Delete

$84:D14D             dx D155,           ; FX base Y position = 2D2h
                        0001,A2B5,
                        86BC            ; Delete
}


;;; $D155: Instruction - FX base Y position = 2D2h ;;;
{
$84:D155 A9 D2 02    LDA #$02D2
$84:D158 8D 78 19    STA $1978  [$7E:1978]
$84:D15B 60          RTS
}


;;; $D15C: Pre-instruction - delete PLM and spawn trigger block if block (4, 8) is a blank air block ;;;
{
; Used by PLM $D6D6 (Lower Norfair chozo hand)
; Block (4, 8) is presumed to be where the chozo's hand is
$84:D15C DA          PHX
$84:D15D E2 20       SEP #$20               ;\
$84:D15F A9 08       LDA #$08               ;|
$84:D161 8D 02 42    STA $4202  [$7E:4202]  ;|
$84:D164 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$84:D167 8D 03 42    STA $4203  [$7E:4203]  ;|
$84:D16A A9 04       LDA #$04               ;|
$84:D16C C2 20       REP #$20               ;|
$84:D16E 29 FF 00    AND #$00FF             ;} If block (4, 8) is not a blank air block: return
$84:D171 18          CLC                    ;|
$84:D172 6D 16 42    ADC $4216  [$7E:4216]  ;|
$84:D175 0A          ASL A                  ;|
$84:D176 AA          TAX                    ;|
$84:D177 BF 02 00 7F LDA $7F0002,x[$7F:030A];|
$84:D17B C9 FF 00    CMP #$00FF             ;|
$84:D17E D0 0C       BNE $0C    [$D18C]     ;/
$84:D180 A9 83 B0    LDA #$B083             ;\
$84:D183 20 B4 82    JSR $82B4  [$84:82B4]  ;} PLM block = Lower Norfair chozo hand trigger
$84:D186 AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$84:D189 9E 37 1C    STZ $1C37,x[$7E:1C7F]  ;} PLM ID = 0

$84:D18C FA          PLX
$84:D18D 60          RTS
}


;;; $D18E: Setup = PLM $D6D6 (Lower Norfair chozo hand) ;;;
{
$84:D18E 60          RTS
}


;;; $D18F: Setup - PLM $D6DA (collision reaction, special, BTS Norfair 83h. Lower Norfair chozo hand trigger) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision

; Enemy 0 is presumed to be the chozo
$84:D18F AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$84:D192 29 00 02    AND #$0200             ;} If Samus doesn't have space jump: go to BRANCH_RETURN
$84:D195 F0 47       BEQ $47    [$D1DE]     ;/
$84:D197 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:D19A 29 0F 00    AND #$000F             ;|
$84:D19D C9 03 00    CMP #$0003             ;} If [collision direction] != down: go to BRANCH_RETURN
$84:D1A0 D0 3C       BNE $3C    [$D1DE]     ;/
$84:D1A2 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:D1A5 C9 1D 00    CMP #$001D             ;} If [Samus pose] != facing right - morph ball - no springball - on ground:
$84:D1A8 F0 0A       BEQ $0A    [$D1B4]     ;/
$84:D1AA C9 79 00    CMP #$0079             ;\
$84:D1AD F0 05       BEQ $05    [$D1B4]     ;|
$84:D1AF C9 7A 00    CMP #$007A             ;} If [Samus pose] != morph ball - spring ball - on ground: go to BRANCH_RETURN
$84:D1B2 D0 2A       BNE $2A    [$D1DE]     ;/

$84:D1B4 A9 0C 00    LDA #$000C             ;\
$84:D1B7 22 FA 81 80 JSL $8081FA[$80:81FA]  ;} Set Lower Norfair chozo event
$84:D1BB A9 01 00    LDA #$0001             ;\
$84:D1BE 8D B4 0F    STA $0FB4  [$7E:0FB4]  ;} Enemy 0 $0FB4 = 1
$84:D1C1 BE 87 1C    LDX $1C87,y[$7E:1CD1]  ;\
$84:D1C4 BF 02 00 7F LDA $7F0002,x[$7F:030A];|
$84:D1C8 29 FF 0F    AND #$0FFF             ;} Make PLM block air
$84:D1CB 9F 02 00 7F STA $7F0002,x[$7F:030A];/
$84:D1CF A9 00 00    LDA #$0000             ;\
$84:D1D2 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus
$84:D1D6 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$84:D1DA             dx 0C, 1D, D113        ;} Spawn PLM $D113 (crumble Lower Norfair chozo room plug)

; BRANCH_RETURN
$84:D1DE A9 00 00    LDA #$0000             ;\
$84:D1E1 99 37 1C    STA $1C37,y[$7E:1C81]  ;} PLM ID = 0
$84:D1E4 38          SEC                    ;\
$84:D1E5 60          RTS                    ;} Return carry set
}


;;; $D1E6: Pre-instruction - increment PLM room argument if shot by (super) missile ;;;
{
; Used by PLM $D6DE (Mother Brain's glass)
$84:D1E6 BD 77 1D    LDA $1D77,x[$7E:1DC5]  ;\
$84:D1E9 F0 13       BEQ $13    [$D1FE]     ;} If not shot: return
$84:D1EB 29 00 0F    AND #$0F00             ;\
$84:D1EE C9 00 02    CMP #$0200             ;|
$84:D1F1 F0 05       BEQ $05    [$D1F8]     ;} If not shot with (super) missile: return
$84:D1F3 C9 00 01    CMP #$0100             ;|
$84:D1F6 D0 06       BNE $06    [$D1FE]     ;/

$84:D1F8 9E 77 1D    STZ $1D77,x[$7E:1DC5]  ; >_<
$84:D1FB FE C7 1D    INC $1DC7,x[$7E:1E15]  ; Increment PLM room argument

$84:D1FE 9E 77 1D    STZ $1D77,x[$7E:1DC5]  ; Clear PLM shot status
$84:D201 60          RTS
}


;;; $D202: Instruction list - PLM $D6DE (Mother Brain's glass) ;;;
{
$84:D202             dx 880E,01,D2ED,               ; Go to $D2ED if the area boss is dead
                        882D,0002,D2F3,             ; Go to $D2F3 if the event 2 is set (Mother Brain's glass is broken)
                        86C1,D1E6                   ; Pre-instruction = increment PLM room argument if shot by (super) missile
$84:D211             dx 0001,9717,
                        D2F9,0002,D211              ; Go to $D211 if [room argument] < 2
$84:D21B             dx 0001,971D,
                        D2F9,0004,D21B              ; Go to $D21B if [room argument] < 4
$84:D225             dx 0001,9731,
                        D2F9,0006,D225,             ; Go to $D225 if [room argument] < 6
                        D30B,0000,0000,0000,0000,   ; Spawn four Mother Brain's glass shattering shards with arguments 0, 0, 0, 0
                        0004,9745,
                        D30B,0000,0000,0000,0000    ; Spawn four Mother Brain's glass shattering shards with arguments 0, 0, 0, 0
$84:D247             dx 0001,9745,
                        D2F9,0008,D247              ; Go to $D247 if [room argument] < 8
$84:D251             dx 0001,974F,
                        D2F9,000A,D251              ; Go to $D251 if [room argument] < Ah
$84:D25B             dx 0001,9769,
                        D2F9,000C,D25B,             ; Go to $D25B if [room argument] < Ch
                        D30B,0002,0002,0002,0002,   ; Spawn four Mother Brain's glass shattering shards with arguments 2, 2, 2, 2
                        0004,9781,
                        D30B,0002,0002,0002,0002    ; Spawn four Mother Brain's glass shattering shards with arguments 2, 2, 2, 2
$84:D27D             dx 0001,9781,
                        D2F9,000E,D27D,             ; Go to $D27D if [room argument] < Eh
                        D30B,0000,0000,0002,0002,   ; Spawn four Mother Brain's glass shattering shards with arguments 0, 0, 2, 2
                        0004,978F,
                        D30B,0004,0004,0004,0004    ; Spawn four Mother Brain's glass shattering shards with arguments 4, 4, 4, 4
$84:D29F             dx 0001,978F,
                        D2F9,0010,D29F,             ; Go to $D29F if [room argument] < 10h
                        D30B,0002,0002,0004,0004,   ; Spawn four Mother Brain's glass shattering shards with arguments 2, 2, 4, 4
                        0004,97B7,
                        D30B,0002,0002,0004,0004    ; Spawn four Mother Brain's glass shattering shards with arguments 2, 2, 4, 4
$84:D2C1             dx 0001,97B7,
                        D2F9,0012,D2C1,             ; Go to $D2C1 if [room argument] < 12h
                        D30B,0002,0002,0004,0004,   ; Spawn four Mother Brain's glass shattering shards with arguments 2, 2, 4, 4
                        0004,97E7,
                        D30B,0002,0002,0004,0004,   ; Spawn four Mother Brain's glass shattering shards with arguments 2, 2, 4, 4
                        0030,97E7,
                        883E,0002,                  ; Set the event 2 (Mother Brain's glass is broken)
                        86BC                        ; Delete
}


;;; $D2ED: Instruction list - PLM $D6E2 (unused. Mother Brain's glass, area boss dead) ;;;
{
$84:D2ED             dx 0001,9817,
                        86BC            ; Delete
}


;;; $D2F3: Instruction list - PLM $D6E6 (unused. Mother Brain's glass, no glass state) ;;;
{
$84:D2F3             dx 0001,97E7,
                        86BC            ; Delete
}


;;; $D2F9: Instruction - go to [[Y] + 2] if [room argument] < [[Y]] ;;;
{
$84:D2F9 BD C7 1D    LDA $1DC7,x[$7E:1E15]
$84:D2FC D9 00 00    CMP $0000,y[$84:D217]
$84:D2FF B0 05       BCS $05    [$D306]
$84:D301 B9 02 00    LDA $0002,y[$84:D219]
$84:D304 A8          TAY
$84:D305 60          RTS

$84:D306 C8          INY
$84:D307 C8          INY
$84:D308 C8          INY
$84:D309 C8          INY
$84:D30A 60          RTS
}


;;; $D30B: Instruction - spawn four Mother Brain's glass shattering shards with arguments [[Y]..[Y]+7] ;;;
{
$84:D30B A9 2E 00    LDA #$002E             ;\
$84:D30E 22 25 91 80 JSL $809125[$80:9125]  ;} Queue sound 2Eh, sound library 3, max queued sounds allowed = 15 (Mother Brain's glass shattering)
$84:D312 B9 00 00    LDA $0000,y[$84:D231]  ;\
$84:D315 20 31 D3    JSR $D331  [$84:D331]  ;} Spawn Mother Brain's glass shattering shard with argument [[Y]]
$84:D318 B9 02 00    LDA $0002,y[$84:D233]  ;\
$84:D31B 20 31 D3    JSR $D331  [$84:D331]  ;} Spawn Mother Brain's glass shattering shard with argument [[Y] + 2]
$84:D31E B9 04 00    LDA $0004,y[$84:D235]  ;\
$84:D321 20 31 D3    JSR $D331  [$84:D331]  ;} Spawn Mother Brain's glass shattering shard with argument [[Y] + 4]
$84:D324 B9 06 00    LDA $0006,y[$84:D237]  ;\
$84:D327 20 31 D3    JSR $D331  [$84:D331]  ;} Spawn Mother Brain's glass shattering shard with argument [[Y] + 6]
$84:D32A 98          TYA                    ;\
$84:D32B 18          CLC                    ;|
$84:D32C 69 08 00    ADC #$0008             ;} Y += 8
$84:D32F A8          TAY                    ;/
$84:D330 60          RTS
}


;;; $D331: Spawn Mother Brain's glass shattering shard with argument [A] ;;;
{
$84:D331 5A          PHY
$84:D332 A0 FC CE    LDY #$CEFC             ;\
$84:D335 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's glass shattering - shard enemy projectile
$84:D339 7A          PLY
$84:D33A 60          RTS
}


;;; $D33B: Pre-instruction - wake PLM if Samus has bombs ;;;
{
; Used by PLM $D6EA (Bomb Torizo's crumbling chozo)
$84:D33B AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$84:D33E 29 00 10    AND #$1000             ;} If Samus doesn't have bombs: return
$84:D341 F0 13       BEQ $13    [$D356]     ;/
$84:D343 A9 01 00    LDA #$0001             ;\
$84:D346 9F 1C DE 7E STA $7EDE1C,x[$7E:DE66];} PLM instruction timer = 1
$84:D34A FE 27 1D    INC $1D27,x[$7E:1D71]  ;\
$84:D34D FE 27 1D    INC $1D27,x[$7E:1D71]  ;} PLM instruction list pointer += 2
$84:D350 A9 56 D3    LDA #$D356             ;\
$84:D353 9D D7 1C    STA $1CD7,x[$7E:1D21]  ;} PLM pre-instruction = RTS

$84:D356 60          RTS
}


;;; $D357: Instruction - spawn Bomb Torizo statue breaking with argument [[Y]] ;;;
{
$84:D357 DA          PHX
$84:D358 5A          PHY
$84:D359 B9 00 00    LDA $0000,y[$84:D385]  ; A = [[Y]]
$84:D35C A0 93 A9    LDY #$A993             ;\
$84:D35F 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Bomb Torizo statue breaking enemy projectile
$84:D363 7A          PLY
$84:D364 FA          PLX
$84:D365 C8          INY
$84:D366 C8          INY
$84:D367 60          RTS
}


;;; $D368: Instruction list - PLM $D6EA (Bomb Torizo's crumbling chozo) ;;;
{
$84:D368             dx 0001,9877,
                        86C1,D33B,            ; Pre-instruction = wake PLM if Samus has bombs
                        86B4,                 ; Sleep
                        0078,9877,
                        87E5,0400,ADB200,6E00,; Transfer 400h bytes from $AD:B200 to VRAM $6E00
                        0060,9877,
                        D357,0000,            ; Spawn Bomb Torizo statue breaking with argument 0
                        0030,9877,
                        D357,0002,            ; Spawn Bomb Torizo statue breaking with argument 2
                        000F,9877,
                        D357,0004,            ; Spawn Bomb Torizo statue breaking with argument 4
                        000E,9877,
                        D357,0006,            ; Spawn Bomb Torizo statue breaking with argument 6
                        000D,9877,
                        D357,0008,            ; Spawn Bomb Torizo statue breaking with argument 8
                        000C,9877,
                        D357,000A,            ; Spawn Bomb Torizo statue breaking with argument Ah
                        000B,9877,
                        D357,000C,            ; Spawn Bomb Torizo statue breaking with argument Ch
                        000A,9877,
                        D357,000E,            ; Spawn Bomb Torizo statue breaking with argument Eh
                        0001,989D,
                        D3C7,                 ; Queue song 1 music track
                        86BC                  ; Delete
}


;;; $D3C7: Instruction - queue song 1 music track ;;;
{
$84:D3C7 A9 06 00    LDA #$0006             ;\
$84:D3CA 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 1 music track
$84:D3CE 60          RTS
}


;;; $D3CF: Instruction list - PLM $D6F8 (clear slope access for Wrecked Ship chozo) ;;;
{
$84:D3CF             dx 0001,9CC5,
                        D3D7,       ; Transform Wrecked Ship chozo's spikes into slopes
                        86BC        ; Delete
}


;;; $D3D7: Instruction - transform Wrecked Ship chozo's spikes into slopes ;;;
{
$84:D3D7 DA          PHX
$84:D3D8 A2 08 16    LDX #$1608
$84:D3DB A9 12 10    LDA #$1012
$84:D3DE 20 B4 82    JSR $82B4  [$84:82B4]
$84:D3E1 A2 0A 16    LDX #$160A
$84:D3E4 A9 13 10    LDA #$1013
$84:D3E7 20 B4 82    JSR $82B4  [$84:82B4]
$84:D3EA FA          PLX
$84:D3EB 60          RTS
}


;;; $D3EC: Instruction list - PLM $D6FC (block slope access for Wrecked Ship chozo) ;;;
{
$84:D3EC             dx 0001,9D0F,
                        D3F4,       ; Revert Wrecked Ship chozo's slopes into spikes
                        86BC        ; Delete
}


;;; $D3F4: Instruction - revert Wrecked Ship chozo's slopes into spikes ;;;
{
$84:D3F4 DA          PHX
$84:D3F5 A2 08 16    LDX #$1608
$84:D3F8 A9 00 A0    LDA #$A000
$84:D3FB 20 B4 82    JSR $82B4  [$84:82B4]
$84:D3FE A2 0A 16    LDX #$160A
$84:D401 A9 00 A0    LDA #$A000
$84:D404 20 B4 82    JSR $82B4  [$84:82B4]
$84:D407 FA          PLX
$84:D408 60          RTS
}


;;; $D409: Unused. Pre-instruction - go to link instruction if shot with a bomb ;;;
{
; Used PLM $D700 (unused. Wrecked Ship 3x4 chozo bomb block)
$84:D409 BD 77 1D    LDA $1D77,x        ;\
$84:D40C 29 00 0F    AND #$0F00         ;|
$84:D40F C9 00 05    CMP #$0500         ;} If shot with bomb:
$84:D412 D0 0E       BNE $0E    [$D422] ;/
$84:D414 BF BC DE 7E LDA $7EDEBC,x      ;\
$84:D418 9D 27 1D    STA $1D27,x        ;} PLM instruction list pointer = [PLM link instruction]
$84:D41B A9 01 00    LDA #$0001         ;\
$84:D41E 9F 1C DE 7E STA $7EDE1C,x      ;} PLM instruction timer = 1

$84:D422 9E 77 1D    STZ $1D77,x        ; Clear PLM shot status
$84:D425 60          RTS
}


;;; $D426: Unused. Instruction list - PLM $D700 (Wrecked Ship 3x4 chozo bomb block) ;;;
{
$84:D426             dx 8848,D448,  ; Go to $D448 if room argument chozo block destroyed
                        8A24,D43A,  ; Link instruction = $D43A
                        86C1,D409   ; Pre-instruction = go to link instruction if shot with a bomb
$84:D432             dx 0077,9D59,
                        8724,D432   ; Go to $D432
$84:D43A             dx 8865,       ; Set room argument chozo block destroyed
                        0004,9D7D,
                        0004,9DA1,
                        0004,9DC5
$84:D448             dx 0004,9DE9,
                        86BC        ; Delete
}


;;; $D44E: Unused. Instruction list - PLM $D704 (alternate Lower Norfair chozo hand) ;;;
{
$84:D44E             dx 882D,000C,D46E, ; Go to $D46E if the event 000Ch is set
                        8A24,D462,      ; Link instruction = $D462
                        86C1,BD26,      ; Pre-instruction = go to link instruction if shot with a power bomb
                        0001,9CA7,
                        86B4,           ; Sleep
$84:D462             dx 0001,9CBF,
                        D476,           ; Drain acid lake
                        883E,000C,      ; Set the event 000Ch
                        86BC            ; Delete
$84:D46E             dx D489,           ; FX base Y position = 2D2h
                        0001,9CBF,
                        86BC            ; Delete
}


;;; $D476: Unused. Instruction - drain acid lake ;;;
{
$84:D476 A9 D2 02    LDA #$02D2             ;\
$84:D479 8D 7A 19    STA $197A  [$7E:197A]  ;} FX target Y position = 2D2h
$84:D47C A9 70 00    LDA #$0070             ;\
$84:D47F 8D 7C 19    STA $197C  [$7E:197C]  ;} FX Y velocity = 70h
$84:D482 A9 20 00    LDA #$0020             ;\
$84:D485 8D 80 19    STA $1980  [$7E:1980]  ;} FX delay = 20h
$84:D488 60          RTS
}


;;; $D489: Unused. Instruction - FX base Y position = 2D2h ;;;
{
; Clone of $D155
$84:D489 A9 D2 02    LDA #$02D2
$84:D48C 8D 78 19    STA $1978  [$7E:1978]
$84:D48F 60          RTS
}


;;; $D490: Instruction list - PLM $D708 (unused. Lower Norfair 2x2 chozo shot block) ;;;
{
$84:D490             dx 8848,D4B8,  ; Go to $D4B8 if room argument chozo block destroyed
                        8A24,D4A2,  ; Link instruction = $D4A2
                        86C1,BD0F,  ; Pre-instruction = go to link instruction if shot
                        0001,9B0B,
                        86B4        ; Sleep
$84:D4A2             dx 0004,9B1B,
                        0004,9B2B,
                        0004,9B3B,
                        0001,9B4B,
                        8865,       ; Set room argument chozo block destroyed
                        D4BE,       ; NOP
                        86BC        ; Delete
$84:D4B8             dx 0001,9B4B,
                        86BC        ; Delete
}


;;; $D4BE: Instruction - NOP ;;;
{
$84:D4BE 60          RTS
}


;;; $D4BF: Pre-instruction - wake PLM if A/X/B/Y/left/right pressed ;;;
{
; Used by PLM $D70C (n00b tube)
$84:D4BF A5 8F       LDA $8F    [$7E:008F]
$84:D4C1 29 C0 C3    AND #$C3C0
$84:D4C4 F0 0D       BEQ $0D    [$D4D3]
$84:D4C6 A9 01 00    LDA #$0001
$84:D4C9 9F 1C DE 7E STA $7EDE1C,x[$7E:DE64]
$84:D4CD FE 27 1D    INC $1D27,x[$7E:1D6F]
$84:D4D0 FE 27 1D    INC $1D27,x[$7E:1D6F]

$84:D4D3 60          RTS
}


;;; $D4D4: Instruction list - PLM $D70C (n00b tube) ;;;
{
$84:D4D4             dx 882D,000B,D521, ; Go to $D521 if the event Bh is set
                        8A24,D4E8,      ; Link instruction = $D4E8
                        86C1,BD26,      ; Pre-instruction = go to link instruction if shot with a power bomb
                        0001,98D1,
                        86B4            ; Sleep
$84:D4E8             dx 8A24,D4F2,      ; Link instruction = $D4F2
                        86C1,D4BF,      ; Pre-instruction = wake PLM if A/X/B/Y/left/right pressed
                        86B4            ; Sleep
$84:D4F2             dx 86CA,           ; Clear pre-instruction
                        D5E6,           ; Lock Samus
                        D52C,           ; Spawn n00b tube crack enemy projectile
                        0030,98D7,
                        0001,9991,
                        0001,99E5,
                        8C10,1A,        ; Queue sound 1Ah, sound library 2, max queued sounds allowed = 6 (n00b tube shattering)
                        D543,           ; Spawn ten n00b tube shards and six n00b tube released air bubbles
                        D536,           ; Trigger n00b tube earthquake
                        0060,98DD,
                        883E,000B,      ; Set the event Bh
                        D525,           ; Enable water physics
                        D5EE,           ; Unlock Samus
                        86BC            ; Delete
$84:D519             dx 0001,98E3,
                        0001,9953
$84:D521             dx D525,           ; Enable water physics
                        86BC            ; Delete
}

;;; $D525: Instruction - enable water physics ;;;
{
$84:D525 A9 04 00    LDA #$0004
$84:D528 1C 7E 19    TRB $197E  [$7E:197E]
$84:D52B 60          RTS
}


;;; $D52C: Instruction - spawn n00b tube crack enemy projectile ;;;
{
$84:D52C 5A          PHY
$84:D52D A0 04 D9    LDY #$D904             ;\
$84:D530 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn n00b tube crack enemy projectile
$84:D534 7A          PLY
$84:D535 60          RTS
}


;;; $D536: Instruction - trigger n00b tube earthquake ;;;
{
$84:D536 A9 0B 00    LDA #$000B             ;\
$84:D539 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 and BG2, 1 pixel displacement, diagonal
$84:D53C A9 40 00    LDA #$0040             ;\
$84:D53F 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 40h
$84:D542 60          RTS
}


;;; $D543: Instruction - spawn ten n00b tube shards and six n00b tube released air bubbles ;;;
{
$84:D543 5A          PHY
$84:D544 A9 00 00    LDA #$0000             ;\
$84:D547 A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D54A 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D54E A9 02 00    LDA #$0002             ;\
$84:D551 A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D554 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D558 A9 04 00    LDA #$0004             ;\
$84:D55B A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D55E 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D562 A9 06 00    LDA #$0006             ;\
$84:D565 A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D568 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D56C A9 08 00    LDA #$0008             ;\
$84:D56F A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D572 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D576 A9 0A 00    LDA #$000A             ;\
$84:D579 A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D57C 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D580 A9 0C 00    LDA #$000C             ;\
$84:D583 A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D586 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D58A A9 0E 00    LDA #$000E             ;\
$84:D58D A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D590 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D594 A9 10 00    LDA #$0010             ;\
$84:D597 A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D59A 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D59E A9 12 00    LDA #$0012             ;\
$84:D5A1 A0 12 D9    LDY #$D912             ;} Spawn n00b tube shards enemy projectile
$84:D5A4 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D5A8 A9 00 00    LDA #$0000             ;\
$84:D5AB A0 20 D9    LDY #$D920             ;} Spawn n00b tube released air bubbles enemy projectile
$84:D5AE 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D5B2 A9 02 00    LDA #$0002             ;\
$84:D5B5 A0 20 D9    LDY #$D920             ;} Spawn n00b tube released air bubbles enemy projectile
$84:D5B8 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D5BC A9 04 00    LDA #$0004             ;\
$84:D5BF A0 20 D9    LDY #$D920             ;} Spawn n00b tube released air bubbles enemy projectile
$84:D5C2 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D5C6 A9 06 00    LDA #$0006             ;\
$84:D5C9 A0 20 D9    LDY #$D920             ;} Spawn n00b tube released air bubbles enemy projectile
$84:D5CC 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D5D0 A9 08 00    LDA #$0008             ;\
$84:D5D3 A0 20 D9    LDY #$D920             ;} Spawn n00b tube released air bubbles enemy projectile
$84:D5D6 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D5DA A9 0A 00    LDA #$000A             ;\
$84:D5DD A0 20 D9    LDY #$D920             ;} Spawn n00b tube released air bubbles enemy projectile
$84:D5E0 22 97 80 86 JSL $868097[$86:8097]  ;/
$84:D5E4 7A          PLY
$84:D5E5 60          RTS
}


;;; $D5E6: Instruction - lock Samus ;;;
{
$84:D5E6 A9 00 00    LDA #$0000             ;\
$84:D5E9 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus
$84:D5ED 60          RTS
}


;;; $D5EE: Instruction - unlock Samus ;;;
{
$84:D5EE A9 01 00    LDA #$0001             ;\
$84:D5F1 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$84:D5F5 60          RTS
}
}


;;; $D5F6..D6D5: Setups ;;;
{
;;; $D5F6: Setup - PLM $D6DE (Mother Brain's glass) ;;;
{
; A draw instruction changes the PLM block type to shot block, making this a generic shot trigger
$84:D5F6 A9 00 00    LDA #$0000             ;\
$84:D5F9 99 C7 1D    STA $1DC7,y[$7E:1E15]  ;} Clear PLM room argument (used as hit counter)
$84:D5FC BE 87 1C    LDX $1C87,y[$7E:1CD5]  ;\
$84:D5FF A9 44 80    LDA #$8044             ;} Make PLM solid block with BTS 44h
$84:D602 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:D605 60          RTS
}


;;; $D606: Setup - PLM $D6EA (Bomb Torizo's crumbling chozo) ;;;
{
; Delete PLM if area torizo is dead
$84:D606 A9 04 00    LDA #$0004
$84:D609 22 DC 81 80 JSL $8081DC[$80:81DC]
$84:D60D 90 06       BCC $06    [$D615]
$84:D60F A9 00 00    LDA #$0000
$84:D612 99 37 1C    STA $1C37,y

$84:D615 60          RTS
}


;;; $D616: Setup - PLM $D6EE (Wrecked Ship chozo hand) ;;;
{
; Make PLM block a Wrecked Ship chozo hand trigger
$84:D616 BE 87 1C    LDX $1C87,y[$7E:1CCB]
$84:D619 A9 80 B0    LDA #$B080
$84:D61C 20 B4 82    JSR $82B4  [$84:82B4]
$84:D61F 60          RTS
}


;;; $D620: Setup - PLM $D6F2 (collision reaction, special, BTS Wrecked Ship 80h. Wrecked Ship chozo hand trigger) ;;;
{
;; Returns:
;;     Carry: Set. Unconditional collision

; Enemy 0 is presumed to be the chozo
$84:D620 A9 01 00    LDA #$0001             ;\
$84:D623 22 DC 81 80 JSL $8081DC[$80:81DC]  ;} If area main boss is not dead: go to BRANCH_RETURN
$84:D627 90 4E       BCC $4E    [$D677]     ;/
$84:D629 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$84:D62C 29 0F 00    AND #$000F             ;|
$84:D62F C9 03 00    CMP #$0003             ;} If [collision direction] != down: go to BRANCH_RETURN
$84:D632 D0 43       BNE $43    [$D677]     ;/
$84:D634 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$84:D637 C9 1D 00    CMP #$001D             ;} If [Samus pose] != facing right - morph ball - no springball - on ground:
$84:D63A F0 0A       BEQ $0A    [$D646]     ;/
$84:D63C C9 79 00    CMP #$0079             ;\
$84:D63F F0 05       BEQ $05    [$D646]     ;|
$84:D641 C9 7A 00    CMP #$007A             ;} If [Samus pose] != morph ball - spring ball - on ground: go to BRANCH_RETURN
$84:D644 D0 31       BNE $31    [$D677]     ;/

$84:D646 A9 01 00    LDA #$0001             ;\
$84:D649 8D B4 0F    STA $0FB4  [$7E:0FB4]  ;} Enemy 0 $0FB4 = 1
$84:D64C A9 02 02    LDA #$0202             ;\
$84:D64F 8F 27 CD 7E STA $7ECD27[$7E:CD27]  ;} Scrolls 7/8 = green
$84:D653 A9 01 01    LDA #$0101             ;\
$84:D656 8F 2D CD 7E STA $7ECD2D[$7E:CD2D]  ;} Scrolls Dh/Eh = blue
$84:D65A BE 87 1C    LDX $1C87,y[$7E:1CCB]  ;\
$84:D65D BF 02 00 7F LDA $7F0002,x[$7F:11D6];|
$84:D661 29 FF 0F    AND #$0FFF             ;} Make PLM block air
$84:D664 9F 02 00 7F STA $7F0002,x[$7F:11D6];/
$84:D668 A9 00 00    LDA #$0000             ;\
$84:D66B 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus
$84:D66F 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$84:D673             dx 17, 1D, D6F8        ;} Spawn PLM $D6F8 (clear slope access for Wrecked Ship chozo)

; BRANCH_RETURN
$84:D677 A9 00 00    LDA #$0000             ;\
$84:D67A 99 37 1C    STA $1C37,y[$7E:1C7B]  ;} PLM ID = 0
$84:D67D 38          SEC                    ;\
$84:D67E 60          RTS                    ;} Return carry set
}


;;; $D67F: Setup - PLM $D700 (unused. Wrecked Ship 3x4 chozo bomb block) ;;;
{
; Make PLM block an air block with BTS 44h (BTS for generic shot trigger)
$84:D67F BE 87 1C    LDX $1C87,y
$84:D682 A9 44 00    LDA #$0044
$84:D685 20 B4 82    JSR $82B4  [$84:82B4]
$84:D688 60          RTS
}


;;; $D689: Setup - PLM $D704 (unused. Alternate Lower Norfair chozo hand) ;;;
{
; Make PLM block a solid block with BTS 44h (BTS for generic shot trigger)
$84:D689 BE 87 1C    LDX $1C87,y
$84:D68C A9 44 80    LDA #$8044
$84:D68F 20 B4 82    JSR $82B4  [$84:82B4]
$84:D692 60          RTS
}


;;; $D693: Setup - PLM $D708 (unused. Lower Norfair 2x2 chozo shot block) ;;;
{
; Make PLM block a solid block with BTS 44h (BTS for generic shot trigger), extended to the right and down to a 2x2 block
$84:D693 BE 87 1C    LDX $1C87,y
$84:D696 A9 44 80    LDA #$8044
$84:D699 20 B4 82    JSR $82B4  [$84:82B4]
$84:D69C BE 87 1C    LDX $1C87,y
$84:D69F E8          INX
$84:D6A0 E8          INX
$84:D6A1 A9 FF 50    LDA #$50FF
$84:D6A4 20 B4 82    JSR $82B4  [$84:82B4]
$84:D6A7 B9 87 1C    LDA $1C87,y
$84:D6AA 18          CLC
$84:D6AB 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D6AE 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D6B1 AA          TAX
$84:D6B2 A9 FF D0    LDA #$D0FF
$84:D6B5 20 B4 82    JSR $82B4  [$84:82B4]
$84:D6B8 B9 87 1C    LDA $1C87,y
$84:D6BB 18          CLC
$84:D6BC 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D6BF 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D6C2 AA          TAX
$84:D6C3 E8          INX
$84:D6C4 E8          INX
$84:D6C5 A9 FF D0    LDA #$D0FF
$84:D6C8 20 B4 82    JSR $82B4  [$84:82B4]
$84:D6CB 60          RTS
}


;;; $D6CC: Setup - PLM $D70C (n00b tube) ;;;
{
; Make PLM block a solid block with BTS 44h (BTS for generic shot trigger)
$84:D6CC BE 87 1C    LDX $1C87,y[$7E:1CCF]
$84:D6CF A9 44 80    LDA #$8044
$84:D6D2 20 B4 82    JSR $82B4  [$84:82B4]
$84:D6D5 60          RTS
}
}


;;; $D6D6..D70F: PLM entries ;;;
{
$84:D6D6             dw D18E,D13F   ; Lower Norfair chozo hand
$84:D6DA             dw D18F,AAE3   ; Collision reaction, special, BTS Norfair 83h. Lower Norfair chozo hand check
$84:D6DE             dw D5F6,D202   ; Mother Brain's glass
$84:D6E2             dw B3C1,D2ED   ; Unused. Mother Brain's glass, area boss dead
$84:D6E6             dw B3C1,D2F3   ; Unused. Mother Brain's glass, no glass state
$84:D6EA             dw D606,D368   ; Bomb Torizo's crumbling chozo
$84:D6EE             dw D616,AAE3   ; Wrecked Ship chozo hand
$84:D6F2             dw D620,AAE3   ; Collision reaction, special, BTS Wrecked Ship 80h. Wrecked Ship chozo hand check


;;; $D6F6: Setup - PLM $D6F8 (clear slope access for Wrecked Ship chozo) ;;;
{
$84:D6F6 60          RTS
}


;;; $D6F7: Setup - PLM $D6FC (block slope access for Wrecked Ship chozo) ;;;
{
$84:D6F7 60          RTS
}


$84:D6F8             dw D6F6,D3CF   ; Clear slope access for Wrecked Ship chozo
$84:D6FC             dw D6F7,D3EC   ; Block slope access for Wrecked Ship chozo
$84:D700             dw D67F,D426   ; Unused. Wrecked Ship 3x4 chozo bomb block
$84:D704             dw D689,D44E   ; Unused. Alternate Lower Norfair chozo hand
$84:D708             dw D693,D490   ; Unused. Lower Norfair 2x2 chozo shot block
$84:D70C             dw D6CC,D4D4   ; n00b tube
}


;;; $D710..D81D: Instructions ;;;
{
;;; $D710: Unused. Pre-instruction - wake PLM if Samus is within 4 blocks of PLM ;;;
{
$84:D710 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$84:D714 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$84:D717 4A          LSR A
$84:D718 4A          LSR A
$84:D719 4A          LSR A
$84:D71A 4A          LSR A
$84:D71B 38          SEC
$84:D71C ED 29 1C    SBC $1C29  [$7E:1C29]
$84:D71F 10 04       BPL $04    [$D725]
$84:D721 49 FF FF    EOR #$FFFF
$84:D724 1A          INC A

$84:D725 C9 04 00    CMP #$0004
$84:D728 F0 02       BEQ $02    [$D72C]
$84:D72A B0 26       BCS $26    [$D752]

$84:D72C AD FA 0A    LDA $0AFA  [$7E:0AFA]
$84:D72F 4A          LSR A
$84:D730 4A          LSR A
$84:D731 4A          LSR A
$84:D732 4A          LSR A
$84:D733 38          SEC
$84:D734 ED 2B 1C    SBC $1C2B  [$7E:1C2B]
$84:D737 10 04       BPL $04    [$D73D]
$84:D739 49 FF FF    EOR #$FFFF
$84:D73C 1A          INC A

$84:D73D C9 04 00    CMP #$0004
$84:D740 F0 02       BEQ $02    [$D744]
$84:D742 B0 0E       BCS $0E    [$D752]

$84:D744 BF BC DE 7E LDA $7EDEBC,x
$84:D748 9D 27 1D    STA $1D27,x
$84:D74B A9 01 00    LDA #$0001
$84:D74E 9F 1C DE 7E STA $7EDE1C,x

$84:D752 60          RTS
}


;;; $D753: Pre-instruction - wake PLM if room argument door is set ;;;
{
$84:D753 9B          TXY
$84:D754 BD C7 1D    LDA $1DC7,x[$7E:1E11]
$84:D757 22 8E 81 80 JSL $80818E[$80:818E]
$84:D75B BF B0 D8 7E LDA $7ED8B0,x[$7E:D8B8]
$84:D75F 2D E7 05    AND $05E7  [$7E:05E7]
$84:D762 F0 15       BEQ $15    [$D779]
$84:D764 BB          TYX
$84:D765 A9 79 D7    LDA #$D779
$84:D768 9D D7 1C    STA $1CD7,x[$7E:1D21]
$84:D76B BF BC DE 7E LDA $7EDEBC,x[$7E:DF06]
$84:D76F 9D 27 1D    STA $1D27,x[$7E:1D71]
$84:D772 A9 01 00    LDA #$0001
$84:D775 9F 1C DE 7E STA $7EDE1C,x[$7E:DE66]

$84:D779 60          RTS
}


;;; $D77A: Instruction - shoot eye door projectile with enemy projectile argument [[Y]] ;;;
{
$84:D77A B9 00 00    LDA $0000,y            ; A = [[Y]]
$84:D77D 5A          PHY
$84:D77E A0 43 B7    LDY #$B743             ;\
$84:D781 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn eye door projectile enemy projectile
$84:D785 A9 4C 00    LDA #$004C             ;\
$84:D788 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 4Ch, sound library 2, max queued sounds allowed = 6 (eye door acid spit)
$84:D78C 7A          PLY
$84:D78D C8          INY
$84:D78E C8          INY
$84:D78F 60          RTS
}


;;; $D790: Instruction - spawn eye door sweat enemy projectile with argument [[Y]] ;;;
{
$84:D790 B9 00 00    LDA $0000,y[$84:D8B2]
$84:D793 5A          PHY
$84:D794 A0 51 B7    LDY #$B751             ;\
$84:D797 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn eye door sweat enemy projectile
$84:D79B 7A          PLY
$84:D79C C8          INY
$84:D79D C8          INY
$84:D79E 60          RTS
}


;;; $D79F: Instruction - spawn two eye door smoke enemy projectiles ;;;
{
$84:D79F 5A          PHY
$84:D7A0 A9 0A 03    LDA #$030A
$84:D7A3 A0 17 E5    LDY #$E517             ;\
$84:D7A6 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn eye door smoke enemy projectile
$84:D7AA A9 0A 03    LDA #$030A
$84:D7AD A0 17 E5    LDY #$E517             ;\
$84:D7B0 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn eye door smoke enemy projectile
$84:D7B4 7A          PLY
$84:D7B5 60          RTS
}


;;; $D7B6: Instruction - spawn eye door smoke projectile ;;;
{
$84:D7B6 5A          PHY
$84:D7B7 A9 0B 00    LDA #$000B
$84:D7BA A0 17 E5    LDY #$E517             ;\
$84:D7BD 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn eye door smoke enemy projectile
$84:D7C1 7A          PLY
$84:D7C2 60          RTS
}


;;; $D7C3: Instruction - move PLM up one row and make a blue door facing right ;;;
{
$84:D7C3 DA          PHX
$84:D7C4 BD 87 1C    LDA $1C87,x[$7E:1CCF]
$84:D7C7 38          SEC
$84:D7C8 ED A5 07    SBC $07A5  [$7E:07A5]
$84:D7CB ED A5 07    SBC $07A5  [$7E:07A5]
$84:D7CE 9D 87 1C    STA $1C87,x[$7E:1CCF]
$84:D7D1 AA          TAX
$84:D7D2 A9 41 C0    LDA #$C041
$84:D7D5 20 B4 82    JSR $82B4  [$84:82B4]
$84:D7D8 80 15       BRA $15    [$D7EF]
}


;;; $D7DA: Instruction - move PLM up one row and make a blue door facing left ;;;
{
$84:D7DA DA          PHX
$84:D7DB BD 87 1C    LDA $1C87,x[$7E:1CCD]
$84:D7DE 38          SEC
$84:D7DF ED A5 07    SBC $07A5  [$7E:07A5]
$84:D7E2 ED A5 07    SBC $07A5  [$7E:07A5]
$84:D7E5 9D 87 1C    STA $1C87,x[$7E:1CCD]
$84:D7E8 AA          TAX
$84:D7E9 A9 40 C0    LDA #$C040
$84:D7EC 20 B4 82    JSR $82B4  [$84:82B4]
}


;;; $D7EF: Create 3 block vertical extension ;;;
{
; Used to make the rest of the blue door the eye door spawns
$84:D7EF 8A          TXA
$84:D7F0 18          CLC
$84:D7F1 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D7F4 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D7F7 AA          TAX
$84:D7F8 A9 FF D0    LDA #$D0FF
$84:D7FB 20 B4 82    JSR $82B4  [$84:82B4]
$84:D7FE 8A          TXA
$84:D7FF 18          CLC
$84:D800 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D803 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D806 AA          TAX
$84:D807 A9 FE D0    LDA #$D0FE
$84:D80A 20 B4 82    JSR $82B4  [$84:82B4]
$84:D80D 8A          TXA
$84:D80E 18          CLC
$84:D80F 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D812 6D A5 07    ADC $07A5  [$7E:07A5]
$84:D815 AA          TAX
$84:D816 A9 FD D0    LDA #$D0FD
$84:D819 20 B4 82    JSR $82B4  [$84:82B4]
$84:D81C FA          PLX
$84:D81D 60          RTS
}
}


;;; $D81E..DA8B: Instruction lists ;;;
{
;;; $D81E: Instruction list - PLM $DB56 (eye door eye, facing left) ;;;
{
$84:D81E             dw 8A72,D8E3       ; Go to $D8E3 if the room argument door is set
$84:D822             dx 0004,9C03,
                        8D41,06,04,D830,; Go to $D830 if Samus is within 6 columns and 4 rows of PLM
                        8724,D822       ; Go to $D822
$84:D830             dw 8A24,D880,      ; Link instruction = $D880
                        86C1,BD50,      ; Pre-instruction = go to link instruction if shot with a (super) missile
                        0008,9C0B 
$84:D83C             dx 8D41,01,04,D878,; Go to $D878 if Samus is within 1 column and 4 rows of PLM
                        0040,9C13,
                        D77A,0000,      ; Shoot eye door projectile with enemy projectile argument 0
                        0020,9C13,
                        D77A,0000,      ; Shoot eye door projectile with enemy projectile argument 0
                        0020,9C13,
                        D77A,0000,      ; Shoot eye door projectile with enemy projectile argument 0
                        0040,9C13,
                        0006,9C0B,
                        0030,9C03,
                        0030,9C03,
                        0006,9C0B,
                        8D41,06,04,D83C,; Go to $D83C if Samus is within 6 columns and 4 rows of PLM
                        8724,D822       ; Go to $D822
$84:D878             dw 0004,9C03,
                        8724,D83C       ; Go to $D83C
$84:D880             dx 8C10,09,        ; Queue sound 9, sound library 2, max queued sounds allowed = 6 (enemy killed)
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        8A91,03,D8C4,   ; Increment door hit counter; Set room argument door and go to $D8C4 if [door hit counter] >= 3
                        0002,9C1B,
                        0002,9C23,
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        0002,9C1B,
                        0002,9C23,
                        0002,9C1B,
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        0002,9C23,
                        0004,9C0B,
                        0008,9C03,
                        D790,0000,      ; Spawn eye door sweat enemy projectile with argument 0
                        0038,9C03,
                        0004,9C0B,
                        0004,9C23,
                        8724,D83C       ; Go to $D83C
$84:D8C4             dx 86CA,           ; Clear pre-instruction
                        D7B6,           ; Spawn eye door smoke projectile
                        D7B6,           ; Spawn eye door smoke projectile
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        D7DA,           ; Move PLM up one row and make a blue door facing left
                        874E,0A         ; Timer = Ah
$84:D8D3             dw 0003,9BF7,
                        0004,A9A7,
                        873F,D8D3,      ; Decrement timer and go to $D8D3 if non-zero
                        8724,C4B1       ; Go to $C4B1
$84:D8E3             dw D7DA,           ; Move PLM up one row and make a blue door facing left
                        8724,C4B1       ; Go to $C4B1
}


;;; $D8E9: Instruction list - door $DB5A (eye door, facing left) ;;;
{
$84:D8E9             dx 8A72,D91D,      ; Go to $D91D if the room argument door is set
$84:D8ED             dx 8D41,06,10,D8FB,; Go to $D8FB if Samus is within 6 columns and 10h rows of PLM
                        0008,9C2B,
                        8724,D8ED,      ; Go to $D8ED
$84:D8FB             dx 8A24,D91D,      ; Link instruction = $D91D
                        86C1,D753,      ; Pre-instruction = wake PLM if room argument door is set
$84:D903             dx 0008,9C2B,
                        0008,9C31,
                        0008,9C37,
                        0008,9C31,
                        8D41,06,10,D903,; Go to $D903 if Samus is within 6 columns and 10h rows of PLM
                        8724,D8ED,      ; Go to $D8ED
$84:D91D             dx 86BC            ; Delete
}


;;; $D91F: Instruction list - PLM $DB60 (eye door bottom, facing left) ;;;
{
$84:D91F             dx 8A72,D953,      ; Go to $D953 if the room argument door is set
$84:D923             dx 8D41,06,10,D931,; Go to $D931 if Samus is within 6 columns and 10h rows of PLM
                        0008,9C3D,
                        8724,D923,      ; Go to $D923
$84:D931             dx 8A24,D953,      ; Link instruction = $D953
                        86C1,D753,      ; Pre-instruction = wake PLM if room argument door is set
$84:D939             dx 0008,9C3D,
                        0008,9C43,
                        0008,9C49,
                        0008,9C43,
                        8D41,06,10,D939,; Go to $D939 if Samus is within 6 columns and 10h rows of PLM
                        8724,D923,      ; Go to $D923
$84:D953             dx 86BC            ; Delete
}


;;; $D955: Instruction list - PLM $DB48 (eye door eye, facing right) ;;;
{
$84:D955             dx 8A72,DA1A,      ; Go to $DA1A if the room argument door is set
$84:D959             dx 0004,9C5B,
                        8D41,06,04,D967,; Go to $D967 if Samus is within 6 columns and 4 rows of PLM
                        8724,D959,      ; Go to $D959
$84:D967             dx 8A24,D9B7,      ; Link instruction = $D9B7
                        86C1,BD50,      ; Pre-instruction = go to link instruction if shot with a (super) missile
                        0008,9C63,
$84:D973             dx 8D41,01,04,D9AF,; Go to $D9AF if Samus is within 1 columns and 4 rows of PLM
                        0040,9C6B,
                        D77A,0014,      ; Shoot eye door projectile with enemy projectile argument 14h
                        0020,9C6B,
                        D77A,0014,      ; Shoot eye door projectile with enemy projectile argument 14h
                        0020,9C6B,
                        D77A,0014,      ; Shoot eye door projectile with enemy projectile argument 14h
                        0040,9C6B,
                        0006,9C63,
                        0030,9C5B,
                        0030,9C5B,
                        0006,9C63,
                        8D41,06,04,D973,; Go to $D973 if Samus is within 6 columns and 4 rows of PLM
                        8724,D959,      ; Go to $D959
$84:D9AF             dx 0004,9C5B,
                        8724,D973,      ; Go to $D973
$84:D9B7             dx 8C10,09,        ; Queue sound 9, sound library 2, max queued sounds allowed = 6 (enemy killed)
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        8A91,03,D9FB,   ; Increment door hit counter; Set room argument door and go to $D9FB if [door hit counter] >= 3
                        0002,9C73,
                        0002,9C7B,
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        0002,9C73,
                        0002,9C7B,
                        0002,9C73,
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        0002,9C7B,
                        0004,9C63,
                        0008,9C5B,
                        D790,0004,      ; Spawn eye door sweat enemy projectile with argument 4
                        0038,9C5B,
                        0004,9C63,
                        0004,9C7B,
                        8724,D973,      ; Go to $D973
$84:D9FB             dx 86CA,           ; Clear pre-instruction
                        D7B6,           ; Spawn eye door smoke projectile
                        D7B6,           ; Spawn eye door smoke projectile
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        D79F,           ; Spawn two eye door smoke enemy projectiles
                        D7C3,           ; Move PLM up one row and make a blue door facing right
                        874E,0A,        ; Timer = 0Ah
$84:DA0A             dx 0003,9C4F,
                        0004,A9E3,
                        873F,DA0A,      ; Decrement timer and go to $DA0A if non-zero
                        8724,C4E2,      ; Go to $C4E2
$84:DA1A             dx D7C3,           ; Move PLM up one row and make a blue door facing right
                        8724,C4E2,      ; Go to $C4E2
}


;;; $DA20: Instruction list - door $DB4C (eye door, facing right) ;;;
{
$84:DA20             dx 8A72,DA54,      ; Go to $DA54 if the room argument door is set
$84:DA24             dx 8D41,06,10,DA32,; Go to $DA32 if Samus is within 6 columns and 10h rows of PLM
                        0008,9C83,
                        8724,DA24,      ; Go to $DA24
$84:DA32             dx 8A24,DA54,      ; Link instruction = $DA54
                        86C1,D753,      ; Pre-instruction = wake PLM if room argument door is set
$84:DA3A             dx 0006,9C83,
                        0006,9C89,
                        0006,9C8F,
                        0006,9C89,
                        8D41,06,10,DA3A,; Go to $DA3A if Samus is within 6 columns and 10h rows of PLM
                        8724,DA24,      ; Go to $DA24
$84:DA54             dx 86BC            ; Delete
}


;;; $DA56: Instruction list - PLM $DB52 (eye door bottom, facing right) ;;;
{
$84:DA56             dx 8A72,DA8A,      ; Go to $DA8A if the room argument door is set
$84:DA5A             dx 8D41,06,10,DA68,; Go to $DA68 if Samus is within 6 columns and 10h rows of PLM
                        0008,9C95,
                        8724,DA5A,      ; Go to $DA5A
$84:DA68             dx 8A24,DA8A,      ; Link instruction = $DA8A
                        86C1,D753,      ; Pre-instruction = wake PLM if room argument door is set
$84:DA70             dx 0006,9C95,
                        0006,9C9B,
                        0006,9CA1,
                        0006,9C9B,
                        8D41,06,10,DA70,; Go to $DA70 if Samus is within 6 columns and 10h rows of PLM
                        8724,DA5A,      ; Go to $DA5A
$84:DA8A             dx 86BC            ; Delete
}
}


;;; $DA8C..DB43: Misc. ;;;
{
;;; $DA8C: Setup - PLM $DB48/$DB56 (eye door eye) ;;;
{
$84:DA8C 5A          PHY                    ;\
$84:DA8D B9 C7 1D    LDA $1DC7,y[$7E:1E0D]  ;|
$84:DA90 22 8E 81 80 JSL $80818E[$80:818E]  ;|
$84:DA94 BF B0 D8 7E LDA $7ED8B0,x[$7E:D8B8];} If PLM room argument door is set: return
$84:DA98 7A          PLY                    ;|
$84:DA99 2D E7 05    AND $05E7  [$7E:05E7]  ;|
$84:DA9C D0 1A       BNE $1A    [$DAB8]     ;/
$84:DA9E BE 87 1C    LDX $1C87,y[$7E:1CCD]  ;\
$84:DAA1 A9 44 C0    LDA #$C044             ;|
$84:DAA4 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DAA7 B9 87 1C    LDA $1C87,y[$7E:1CCD]  ;|
$84:DAAA 18          CLC                    ;|
$84:DAAB 6D A5 07    ADC $07A5  [$7E:07A5]  ;} 2 block column below PLM = generic shot trigger
$84:DAAE 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DAB1 AA          TAX                    ;|
$84:DAB2 A9 FF D0    LDA #$D0FF             ;|
$84:DAB5 20 B4 82    JSR $82B4  [$84:82B4]  ;/

$84:DAB8 60          RTS
}


;;; $DAB9: Setup - door $DB4C/$DB5A / PLM $DB52/$DB60 (eye door) ;;;
{
$84:DAB9 5A          PHY                    ;\
$84:DABA B9 C7 1D    LDA $1DC7,y[$7E:1E11]  ;|
$84:DABD 22 8E 81 80 JSL $80818E[$80:818E]  ;|
$84:DAC1 BF B0 D8 7E LDA $7ED8B0,x[$7E:D8B8];} If PLM room argument door is set: return
$84:DAC5 7A          PLY                    ;|
$84:DAC6 2D E7 05    AND $05E7  [$7E:05E7]  ;|
$84:DAC9 D0 09       BNE $09    [$DAD4]     ;/
$84:DACB BE 87 1C    LDX $1C87,y[$7E:1CD1]  ;\
$84:DACE A9 00 A0    LDA #$A000             ;} Make PLM block a generic spike
$84:DAD1 20 B4 82    JSR $82B4  [$84:82B4]  ;/

$84:DAD4 60          RTS
}


;;; $DAD5: RTS. Pre-instruction - set Metroids cleared state when required - room argument = 0 ;;;
{
$84:DAD5 60          RTS
}


;;; $DAD6: RTS. Pre-instruction - set Metroids cleared state when required - room argument = 2 ;;;
{
$84:DAD6 60          RTS
}


;;; $DAD7: RTS. Pre-instruction - set Metroids cleared state when required - room argument = 4 ;;;
{
$84:DAD7 60          RTS
}


;;; $DAD8: RTS. Pre-instruction - set Metroids cleared state when required - room argument = 6 ;;;
{
$84:DAD8 60          RTS
}


;;; $DAD9: RTS. Pre-instruction - set Metroids cleared state when required - room argument = 8 ;;;
{
$84:DAD9 60          RTS
}


;;; $DADA: RTS. Pre-instruction - set Metroids cleared state when required - room argument = Ah ;;;
{
$84:DADA 60          RTS
}


;;; $DADB: RTS. Pre-instruction - set Metroids cleared state when required - room argument = Ch ;;;
{
$84:DADB 60          RTS
}


;;; $DADC: RTS. Pre-instruction - set Metroids cleared state when required - room argument = Eh ;;;
{
$84:DADC 60          RTS
}


;;; $DADD: RTS. Pre-instruction - set Metroids cleared state when required - room argument = 10h ;;;
{
$84:DADD 60          RTS
}


;;; $DADE: Pre-instruction - set Metroids cleared state when required - room argument = 12h ;;;
{
$84:DADE AD 50 0E    LDA $0E50  [$7E:0E50]
$84:DAE1 CD 52 0E    CMP $0E52  [$7E:0E52]
$84:DAE4 90 07       BCC $07    [$DAED]
$84:DAE6 A9 10 00    LDA #$0010
$84:DAE9 22 FA 81 80 JSL $8081FA[$80:81FA]

$84:DAED 60          RTS
}


;;; $DAEE: Pre-instruction - set Metroids cleared state when required - room argument = 14h ;;;
{
$84:DAEE AD 50 0E    LDA $0E50  [$7E:0E50]
$84:DAF1 CD 52 0E    CMP $0E52  [$7E:0E52]
$84:DAF4 90 07       BCC $07    [$DAFD]
$84:DAF6 A9 11 00    LDA #$0011
$84:DAF9 22 FA 81 80 JSL $8081FA[$80:81FA]

$84:DAFD 60          RTS
}


;;; $DAFE: Pre-instruction - set Metroids cleared state when required - room argument = 16h ;;;
{
$84:DAFE AD 50 0E    LDA $0E50  [$7E:0E50]
$84:DB01 CD 52 0E    CMP $0E52  [$7E:0E52]
$84:DB04 90 07       BCC $07    [$DB0D]
$84:DB06 A9 12 00    LDA #$0012
$84:DB09 22 FA 81 80 JSL $8081FA[$80:81FA]

$84:DB0D 60          RTS
}


;;; $DB0E: Pre-instruction - set Metroids cleared state when required - room argument = 18h ;;;
{
$84:DB0E AD 50 0E    LDA $0E50  [$7E:0E50]
$84:DB11 CD 52 0E    CMP $0E52  [$7E:0E52]
$84:DB14 90 07       BCC $07    [$DB1D]
$84:DB16 A9 13 00    LDA #$0013
$84:DB19 22 FA 81 80 JSL $8081FA[$80:81FA]

$84:DB1D 60          RTS
}


;;; $DB1E: Setup - PLM $DB44 (sets Metroids cleared states when required) ;;;
{
$84:DB1E BE C7 1D    LDX $1DC7,y[$7E:1E15]  ;\
$84:DB21 BD 28 DB    LDA $DB28,x[$84:DB3A]  ;} PLM pre-instruction = [$DB28 + [PLM room argument]]
$84:DB24 99 D7 1C    STA $1CD7,y[$7E:1D25]  ;/
$84:DB27 60          RTS

$84:DB28             dw DAD5, DAD6, DAD7, DAD8, DAD9, DADA, DADB, DADC, DADD, DADE, DAEE, DAFE, DB0E
}


;;; $DB42: Instruction list - PLM $DB44 (sets Metroids cleared states when required) ;;;
{
$84:DB42             dx 86B4        ; Sleep
}
}


;;; $DB44: PLM entries ;;;
{
$84:DB44             dw DB1E,DB42       ; Sets Metroids cleared states when required
$84:DB48             dw DA8C,D955       ; Eye door eye, facing right
$84:DB4C             dw DAB9,DA20,AAE3  ; Door. Eye door, facing right
$84:DB52             dw DAB9,DA56       ; Eye door bottom, facing right
$84:DB56             dw DA8C,D81E       ; Eye door eye, facing left
$84:DB5A             dw DAB9,D8E9,AAE3  ; Door. Eye door, facing left
$84:DB60             dw DAB9,D91F       ; Eye door bottom, facing left
}


;;; $DB64..DCDD: Instructions ;;;
{
;;; $DB64: Pre-instruction - go to link instruction if shot with a (super) missile ;;;
{
; Used by Draygon cannon with shield
$84:DB64 BD 77 1D    LDA $1D77,x[$7E:1DBF]  ;\
$84:DB67 29 00 0F    AND #$0F00             ;|
$84:DB6A C9 00 02    CMP #$0200             ;} If shot with super missile: go to BRANCH_SUPER
$84:DB6D F0 17       BEQ $17    [$DB86]     ;/
$84:DB6F C9 00 01    CMP #$0100             ;\
$84:DB72 D0 11       BNE $11    [$DB85]     ;} If not shot with missile: return

; BRANCH_MISSILE
$84:DB74 9E 77 1D    STZ $1D77,x[$7E:1DBF]  ; Clear PLM shot status
$84:DB77 BF BC DE 7E LDA $7EDEBC,x[$7E:DF04];\
$84:DB7B 9D 27 1D    STA $1D27,x[$7E:1D6F]  ;} PLM instruction list pointer = [PLM link instruction]
$84:DB7E A9 01 00    LDA #$0001             ;\
$84:DB81 9F 1C DE 7E STA $7EDE1C,x[$7E:DE64];} PLM instruction timer = 1

$84:DB85 60          RTS                    ; Return

; BRANCH_SUPER
$84:DB86 A9 77 00    LDA #$0077             ;\
$84:DB89 9D C7 1D    STA $1DC7,x            ;} PLM door hit counter = 77h
$84:DB8C 80 E6       BRA $E6    [$DB74]     ; Go to BRANCH_MISSILE
}


;;; $DB8E: Instruction - damage Draygon turret ;;;
{
$84:DB8E DA          PHX                    ;\
$84:DB8F BD 17 1E    LDA $1E17,x[$7E:1E61]  ;|
$84:DB92 AA          TAX                    ;|
$84:DB93 A9 01 00    LDA #$0001             ;} Set Draygon turret as damaged
$84:DB96 9F 00 00 7E STA $7E0000,x[$7E:8802];|
$84:DB9A FA          PLX                    ;/
$84:DB9B BD 87 1C    LDA $1C87,x[$7E:1CD1]  ;\
$84:DB9E AA          TAX                    ;|
$84:DB9F A9 03 A0    LDA #$A003             ;|
$84:DBA2 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DBA5 8A          TXA                    ;|
$84:DBA6 18          CLC                    ;|
$84:DBA7 6D A5 07    ADC $07A5  [$7E:07A5]  ;} 2 block column below PLM = spike block with BTS 3
$84:DBAA 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DBAD AA          TAX                    ;|
$84:DBAE A9 03 A0    LDA #$A003             ;|
$84:DBB1 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DBB4 AE 27 1C    LDX $1C27  [$7E:1C27]  ;/
$84:DBB7 60          RTS
}


;;; $DBB8: Instruction - damage Draygon turret facing down-right ;;;
{
$84:DBB8 DA          PHX                    ;\
$84:DBB9 BD 17 1E    LDA $1E17,x            ;|
$84:DBBC AA          TAX                    ;|
$84:DBBD A9 01 00    LDA #$0001             ;} Set Draygon turret as damaged
$84:DBC0 9F 00 00 7E STA $7E0000,x          ;|
$84:DBC4 FA          PLX                    ;/
$84:DBC5 BD 87 1C    LDA $1C87,x            ;\
$84:DBC8 AA          TAX                    ;|
$84:DBC9 A9 03 A0    LDA #$A003             ;|
$84:DBCC 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DBCF E8          INX                    ;|
$84:DBD0 E8          INX                    ;|
$84:DBD1 A9 03 A0    LDA #$A003             ;|
$84:DBD4 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DBD7 AE 27 1C    LDX $1C27  [$7E:1C27]  ;|
$84:DBDA BD 87 1C    LDA $1C87,x            ;|
$84:DBDD 18          CLC                    ;} 2x2 block below and right of PLM = spike block with BTS 3 with air block in the bottom right
$84:DBDE 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DBE1 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DBE4 AA          TAX                    ;|
$84:DBE5 A9 03 A0    LDA #$A003             ;|
$84:DBE8 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DBEB E8          INX                    ;|
$84:DBEC E8          INX                    ;|
$84:DBED A9 00 00    LDA #$0000             ;|
$84:DBF0 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DBF3 AE 27 1C    LDX $1C27  [$7E:1C27]  ;/
$84:DBF6 60          RTS
}


;;; $DBF7: Instruction - damage Draygon turret facing up-right ;;;
{
$84:DBF7 DA          PHX                    ;\
$84:DBF8 BD 17 1E    LDA $1E17,x            ;|
$84:DBFB AA          TAX                    ;|
$84:DBFC A9 01 00    LDA #$0001             ;} Set Draygon turret as damaged
$84:DBFF 9F 00 00 7E STA $7E0000,x          ;|
$84:DC03 FA          PLX                    ;/
$84:DC04 BD 87 1C    LDA $1C87,x            ;\
$84:DC07 AA          TAX                    ;|
$84:DC08 A9 03 A0    LDA #$A003             ;|
$84:DC0B 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC0E E8          INX                    ;|
$84:DC0F E8          INX                    ;|
$84:DC10 A9 00 00    LDA #$0000             ;|
$84:DC13 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC16 AE 27 1C    LDX $1C27  [$7E:1C27]  ;|
$84:DC19 BD 87 1C    LDA $1C87,x            ;|
$84:DC1C 18          CLC                    ;} 2x2 block below and right of PLM = spike block with BTS 3 with air block in the top right
$84:DC1D 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DC20 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DC23 AA          TAX                    ;|
$84:DC24 A9 03 A0    LDA #$A003             ;|
$84:DC27 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC2A E8          INX                    ;|
$84:DC2B E8          INX                    ;|
$84:DC2C A9 03 A0    LDA #$A003             ;|
$84:DC2F 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC32 AE 27 1C    LDX $1C27  [$7E:1C27]  ;/
$84:DC35 60          RTS
}


;;; $DC36: Instruction - damage Draygon turret ;;;
{
; Clone of $DB8E
$84:DC36 DA          PHX                    ;\
$84:DC37 BD 17 1E    LDA $1E17,x[$7E:1E5B]  ;|
$84:DC3A AA          TAX                    ;|
$84:DC3B A9 01 00    LDA #$0001             ;} Set Draygon turret as damaged
$84:DC3E 9F 00 00 7E STA $7E0000,x[$7E:8808];|
$84:DC42 FA          PLX                    ;/
$84:DC43 BD 87 1C    LDA $1C87,x[$7E:1CCB]  ;\
$84:DC46 AA          TAX                    ;|
$84:DC47 A9 03 A0    LDA #$A003             ;|
$84:DC4A 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC4D 8A          TXA                    ;|
$84:DC4E 18          CLC                    ;|
$84:DC4F 6D A5 07    ADC $07A5  [$7E:07A5]  ;} 2 block column below PLM = spike block with BTS 3
$84:DC52 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DC55 AA          TAX                    ;|
$84:DC56 A9 03 A0    LDA #$A003             ;|
$84:DC59 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC5C AE 27 1C    LDX $1C27  [$7E:1C27]  ;/
$84:DC5F 60          RTS
}


;;; $DC60: Instruction - damage Draygon turret facing down-left ;;;
{
$84:DC60 DA          PHX                    ;\
$84:DC61 BD 17 1E    LDA $1E17,x            ;|
$84:DC64 AA          TAX                    ;|
$84:DC65 A9 01 00    LDA #$0001             ;} Set Draygon turret as damaged
$84:DC68 9F 00 00 7E STA $7E0000,x          ;|
$84:DC6C FA          PLX                    ;/
$84:DC6D BD 87 1C    LDA $1C87,x            ;\
$84:DC70 AA          TAX                    ;|
$84:DC71 A9 03 A0    LDA #$A003             ;|
$84:DC74 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC77 CA          DEX                    ;|
$84:DC78 CA          DEX                    ;|
$84:DC79 A9 03 A0    LDA #$A003             ;|
$84:DC7C 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC7F AE 27 1C    LDX $1C27  [$7E:1C27]  ;|
$84:DC82 BD 87 1C    LDA $1C87,x            ;|
$84:DC85 18          CLC                    ;} 2x2 block below and right of PLM = spike block with BTS 3 with air block in the bottom left
$84:DC86 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DC89 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DC8C AA          TAX                    ;|
$84:DC8D A9 03 A0    LDA #$A003             ;|
$84:DC90 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC93 CA          DEX                    ;|
$84:DC94 CA          DEX                    ;|
$84:DC95 A9 00 00    LDA #$0000             ;|
$84:DC98 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DC9B AE 27 1C    LDX $1C27  [$7E:1C27]  ;/
$84:DC9E 60          RTS
}


;;; $DC9F: Instruction - damage Draygon turret facing up-left ;;;
{
$84:DC9F DA          PHX                    ;\
$84:DCA0 BD 17 1E    LDA $1E17,x            ;|
$84:DCA3 AA          TAX                    ;|
$84:DCA4 A9 01 00    LDA #$0001             ;} Set Draygon turret as damaged
$84:DCA7 9F 00 00 7E STA $7E0000,x          ;|
$84:DCAB FA          PLX                    ;/
$84:DCAC BD 87 1C    LDA $1C87,x            ;\
$84:DCAF AA          TAX                    ;|
$84:DCB0 A9 03 A0    LDA #$A003             ;|
$84:DCB3 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DCB6 CA          DEX                    ;|
$84:DCB7 CA          DEX                    ;|
$84:DCB8 A9 00 00    LDA #$0000             ;|
$84:DCBB 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DCBE AE 27 1C    LDX $1C27  [$7E:1C27]  ;|
$84:DCC1 BD 87 1C    LDA $1C87,x            ;|
$84:DCC4 18          CLC                    ;} 2x2 block below and right of PLM = spike block with BTS 3 with air block in the top left
$84:DCC5 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DCC8 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DCCB AA          TAX                    ;|
$84:DCCC A9 03 A0    LDA #$A003             ;|
$84:DCCF 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DCD2 CA          DEX                    ;|
$84:DCD3 CA          DEX                    ;|
$84:DCD4 A9 03 A0    LDA #$A003             ;|
$84:DCD7 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DCDA AE 27 1C    LDX $1C27  [$7E:1C27]  ;/
$84:DCDD 60          RTS
}
}


;;; $DCDE..DE93: Instruction lists ;;;
{
;;; $DCDE: Instruction list - PLM $DF59 (Draygon cannon, with shield, facing right) ;;;
{
$84:DCDE             dx 8A24,DCF0,      ; Link instruction = $DCF0
                        86C1,DB64,      ; Pre-instruction = go to link instruction if shot with a (super) missile
$84:DCE6             dx 0008,9FCD,
                        86B4,           ; Sleep
                        8724,DCE6,      ; Go to $DCE6
$84:DCF0             dx 8ACD,03,DD11,   ; Increment room argument; room argument = FFFFh and go to $DD11 if [room argument] >= 3
                        0003,9FCD,
                        0004,9FDD,
                        0003,9FCD,
                        0004,9FDD,
                        0003,9FCD,
                        0004,9FDD,
                        8724,DCE6,      ; Go to $DCE6
}


;;; $DD11: Instruction list - PLM $DF65 (Draygon cannon, facing right) ;;;
{
$84:DD11             dx DB8E,           ; Damage Draygon turret
$84:DD13             dx 0006,A02D,
                        0006,A03D,
                        0006,A04D,
                        0006,A05D,
                        8724,DD13,      ; Go to $DD13
}


;;; $DD27: Instruction list - PLM $DF5D (unused. Draygon cannon, with shield, facing down-right) ;;;
{
$84:DD27             dx 8A24,DD39,      ; Link instruction = $DD39
                        86C1,DB64,      ; Pre-instruction = go to link instruction if shot with a (super) missile
$84:DD2F             dx 0008,9FED,
                        86B4,           ; Sleep
                        8724,DD2F,      ; Go to $DD2F
$84:DD39             dx 8ACD,03,DD5A,   ; Increment room argument; room argument = FFFFh and go to $DD5A if [room argument] >= 3
                        0003,9FED,
                        0004,9FFD,
                        0003,9FED,
                        0004,9FFD,
                        0003,9FED,
                        0004,9FFD,
                        8724,DD2F,      ; Go to $DD2F
}


;;; $DD5A: Instruction list - PLM $DF69 (unused. Draygon cannon, facing down-right) ;;;
{
$84:DD5A             dx DBB8,           ; Damage Draygon turret facing down-right
$84:DD5C             dx 0006,A06D,
                        0006,A07D,
                        0006,A08D,
                        0006,A09D,
                        8724,DD5C,      ; Go to $DD5C
}


;;; $DD70: Instruction list - PLM $DF61 (unused. Draygon cannon, with shield, facing up-right) ;;;
{
$84:DD70             dx 8A24,DD82,      ; Link instruction = $DD82
                        86C1,DB64,      ; Pre-instruction = go to link instruction if shot with a (super) missile
$84:DD78             dx 0008,A00D,
                        86B4,           ; Sleep
                        8724,DD78,      ; Go to $DD78
$84:DD82             dx 8ACD,03,DDA3,   ; Increment room argument; room argument = FFFFh and go to $DDA3 if [room argument] >= 3
                        0003,A00D,
                        0004,A01D,
                        0003,A00D,
                        0004,A01D,
                        0003,A00D,
                        0004,A01D,
                        8724,DD78,      ; Go to $DD78
}


;;; $DDA3: Instruction list - PLM $DF6D (unused. Draygon cannon, facing up-right) ;;;
{
$84:DDA3             dx DBF7,           ; Damage Draygon turret facing up-right
$84:DDA5             dx 0006,A0AD,
                        0006,A0BD,
                        0006,A0CD,
                        0006,A0DD,
                        8724,DDA5,      ; Go to $DDA5
}


;;; $DDB9: Instruction list - PLM $DF71 (Draygon cannon, with shield, facing left) ;;;
{
$84:DDB9             dx 8A24,DDCB,      ; Link instruction = $DDCB
                        86C1,DB64,      ; Pre-instruction = go to link instruction if shot with a (super) missile
$84:DDC1             dx 0008,A0ED,
                        86B4,           ; Sleep
                        8724,DDC1,      ; Go to $DDC1
$84:DDCB             dx 8ACD,03,DDEC,   ; Increment room argument; room argument = FFFFh and go to $DDEC if [room argument] >= 3
                        0003,A0ED,
                        0004,A101,
                        0003,A0ED,
                        0004,A101,
                        0003,A0ED,
                        0004,A101,
                        8724,DDC1,      ; Go to $DDC1
}


;;; $DDEC: Instruction list - PLM $DF7D (Dragon cannon, facing left) ;;;
{
$84:DDEC             dx DC36,           ; Damage Draygon turret
$84:DDEE             dx 0006,A165,
                        0006,A179,
                        0006,A18D,
                        0006,A1A1,
                        8724,DDEE,      ; Go to $DDEE
}


;;; $DE02: Instruction list - PLM $DF75 (unused. Draygon cannon, with shield, facing down-left) ;;;
{
$84:DE02             dx 8A24,DE14,      ; Link instruction = $DE14
                        86C1,DB64,      ; Pre-instruction = go to link instruction if shot with a (super) missile
$84:DE0A             dx 0008,A115,
                        86B4,           ; Sleep
                        8724,DE0A,      ; Go to $DE0A
$84:DE14             dx 8ACD,03,DE35,   ; Increment room argument; room argument = FFFFh and go to $DE35 if [room argument] >= 3
                        0003,A115,
                        0004,A129,
                        0003,A115,
                        0004,A129,
                        0003,A115,
                        0004,A129,
                        8724,DE0A,      ; Go to $DE0A
}


;;; $DE35: Instruction list - PLM $DF81 (unused. Draygon cannon, facing down-left) ;;;
{
$84:DE35             dx DC60,           ; Damage Draygon turret facing down-left
$84:DE37             dx 0006,A1B5,
                        0006,A1C9,
                        0006,A1DD,
                        0006,A1F1,
                        8724,DE37,      ; Go to $DE37
}


;;; $DE4B: Instruction list - PLM $DF79 (unused. Draygon cannon, with shield, facing up-left) ;;;
{
$84:DE4B             dx 8A24,DE5D,      ; Link instruction = $DE5D
                        86C1,DB64,      ; Pre-instruction = go to link instruction if shot with a (super) missile
$84:DE53             dx 0008,A13D,
                        86B4,           ; Sleep
                        8724,DE53,      ; Go to $DE53
$84:DE5D             dx 8ACD,03,DE7E,   ; Increment room argument; room argument = FFFFh and go to $DE7E if [room argument] >= 3
                        0003,A13D,
                        0004,A151,
                        0003,A13D,
                        0004,A151,
                        0003,A13D,
                        0004,A151,
                        8724,DE53,      ; Go to $DE53
}


;;; $DE7E: Instruction list - PLM $DF85 (unused. Draygon cannon, facing up-left) ;;;
{
$84:DE7E             dx DC9F,           ; Damage Draygon turret facing up-left
$84:DE80             dx 0006,A205,
                        0006,A219,
                        0006,A22D,
                        0006,A241,
                        8724,DE80,      ; Go to $DE80
}
}


;;; $DE94..DF58: Setups ;;;
{
;;; $DE94: Setup - PLM $DF59 (Draygon cannon, with shield, facing right) ;;;
{
$84:DE94 B9 C7 1D    LDA $1DC7,y[$7E:1E0F]  ;\
$84:DE97 99 17 1E    STA $1E17,y[$7E:1E5F]  ;} PLM turret destroyed flag address = [PLM room argument]
$84:DE9A A9 00 00    LDA #$0000             ;\
$84:DE9D 99 C7 1D    STA $1DC7,y[$7E:1E0F]  ;} PLM room argument = 0
$84:DEA0 BE 87 1C    LDX $1C87,y[$7E:1CCF]  ;\
$84:DEA3 A9 44 C0    LDA #$C044             ;|
$84:DEA6 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DEA9 8A          TXA                    ;|
$84:DEAA 18          CLC                    ;|
$84:DEAB 6D A5 07    ADC $07A5  [$7E:07A5]  ;} 2 block column below PLM = generic shot trigger
$84:DEAE 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DEB1 AA          TAX                    ;|
$84:DEB2 A9 FF D0    LDA #$D0FF             ;|
$84:DEB5 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:DEB8 60          RTS
}


;;; $DEB9: Setup - PLM $DF5D/$DF61 (unused. Draygon cannon, with shield, facing down-right / up-right) ;;;
{
$84:DEB9 B9 C7 1D    LDA $1DC7,y            ;\
$84:DEBC 99 17 1E    STA $1E17,y            ;} PLM turret destroyed flag address = [PLM room argument]
$84:DEBF A9 00 00    LDA #$0000             ;\
$84:DEC2 99 C7 1D    STA $1DC7,y            ;} PLM room argument = 0
$84:DEC5 BE 87 1C    LDX $1C87,y            ;\
$84:DEC8 A9 44 C0    LDA #$C044             ;|
$84:DECB 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DECE E8          INX                    ;|
$84:DECF E8          INX                    ;|
$84:DED0 A9 FF 50    LDA #$50FF             ;|
$84:DED3 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DED6 B9 87 1C    LDA $1C87,y            ;|
$84:DED9 18          CLC                    ;|
$84:DEDA 6D A5 07    ADC $07A5  [$7E:07A5]  ;} 2x2 block below and right of PLM = generic shot trigger
$84:DEDD 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DEE0 AA          TAX                    ;|
$84:DEE1 A9 FF D0    LDA #$D0FF             ;|
$84:DEE4 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DEE7 E8          INX                    ;|
$84:DEE8 E8          INX                    ;|
$84:DEE9 A9 FF D0    LDA #$D0FF             ;|
$84:DEEC 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:DEEF 60          RTS
}


;;; $DEF0: Setup - PLM $DF71 (Draygon cannon, with shield, facing left) ;;;
{
; Clone of $DE94
$84:DEF0 B9 C7 1D    LDA $1DC7,y[$7E:1E0D]  ;\
$84:DEF3 99 17 1E    STA $1E17,y[$7E:1E5D]  ;} PLM turret destroyed flag address = [PLM room argument]
$84:DEF6 A9 00 00    LDA #$0000             ;\
$84:DEF9 99 C7 1D    STA $1DC7,y[$7E:1E0D]  ;} PLM room argument = 0
$84:DEFC BE 87 1C    LDX $1C87,y[$7E:1CCD]  ;\
$84:DEFF A9 44 C0    LDA #$C044             ;|
$84:DF02 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DF05 8A          TXA                    ;|
$84:DF06 18          CLC                    ;|
$84:DF07 6D A5 07    ADC $07A5  [$7E:07A5]  ;} 2 block column below PLM = generic shot trigger
$84:DF0A 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DF0D AA          TAX                    ;|
$84:DF0E A9 FF D0    LDA #$D0FF             ;|
$84:DF11 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:DF14 60          RTS
}


;;; $DF15: Setup - PLM $DF75/$DF79 (unused. Draygon cannon, with shield, facing down-left / up-left) ;;;
{
$84:DF15 B9 C7 1D    LDA $1DC7,y            ;\
$84:DF18 99 17 1E    STA $1E17,y            ;} PLM turret destroyed flag address = [PLM room argument]
$84:DF1B A9 00 00    LDA #$0000             ;\
$84:DF1E 99 C7 1D    STA $1DC7,y            ;} PLM room argument = 0
$84:DF21 BE 87 1C    LDX $1C87,y            ;\
$84:DF24 A9 44 C0    LDA #$C044             ;|
$84:DF27 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DF2A CA          DEX                    ;|
$84:DF2B CA          DEX                    ;|
$84:DF2C A9 01 50    LDA #$5001             ;|
$84:DF2F 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DF32 B9 87 1C    LDA $1C87,y            ;|
$84:DF35 18          CLC                    ;|
$84:DF36 6D A5 07    ADC $07A5  [$7E:07A5]  ;} 2x2 block below and left of PLM = generic shot trigger
$84:DF39 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$84:DF3C AA          TAX                    ;|
$84:DF3D A9 FF D0    LDA #$D0FF             ;|
$84:DF40 20 B4 82    JSR $82B4  [$84:82B4]  ;|
$84:DF43 CA          DEX                    ;|
$84:DF44 CA          DEX                    ;|
$84:DF45 A9 FF D0    LDA #$D0FF             ;|
$84:DF48 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:DF4B 60          RTS
}


;;; $DF4C: Setup - PLM $DF65/$DF69/$DF6D/$DF7D/$DF81/$DF85 (Draygon cannon) ;;;
{
$84:DF4C B9 C7 1D    LDA $1DC7,y[$7E:1E11]  ;\
$84:DF4F 99 17 1E    STA $1E17,y[$7E:1E61]  ;} PLM turret damaged flag address = [room argument]
$84:DF52 A9 03 00    LDA #$0003             ;\
$84:DF55 99 C7 1D    STA $1DC7,y[$7E:1E11]  ;} PLM room argument = 3
$84:DF58 60          RTS
}
}


;;; $DF59: PLM entries ;;;
{
$84:DF59             dw DE94,DCDE ; Draygon cannon, with shield, facing right
$84:DF5D             dw DEB9,DD27 ; Unused. Draygon cannon, with shield, facing down-right
$84:DF61             dw DEB9,DD70 ; Unused. Draygon cannon, with shield, facing up-right
$84:DF65             dw DF4C,DD11 ; Draygon cannon, facing right
$84:DF69             dw DF4C,DD5A ; Unused. Draygon cannon, facing down-right
$84:DF6D             dw DF4C,DDA3 ; Unused. Draygon cannon, facing up-right
$84:DF71             dw DEF0,DDB9 ; Draygon cannon, with shield, facing left
$84:DF75             dw DF15,DE02 ; Unused. Draygon cannon, with shield, facing down-left
$84:DF79             dw DF15,DE4B ; Unused. Draygon cannon, with shield, facing up-left
$84:DF7D             dw DF4C,DDEC ; Dragon cannon, facing left
$84:DF81             dw DF4C,DE35 ; Unused. Draygon cannon, facing down-left
$84:DF85             dw DF4C,DE7E ; Unused. Draygon cannon, facing up-left
}


;;; $DF89..EE4C: Instruction lists ;;;
{
;;; $DF89: Pre-instruction - go to link instruction if triggered ;;;
{
$84:DF89 BD 77 1D    LDA $1D77,x[$7E:1DBB]  ;\
$84:DF8C 29 FF 00    AND #$00FF             ;|
$84:DF8F C9 FF 00    CMP #$00FF             ;} If not triggered: return
$84:DF92 D0 14       BNE $14    [$DFA8]     ;/
$84:DF94 A9 A8 DF    LDA #$DFA8             ;\
$84:DF97 9D D7 1C    STA $1CD7,x[$7E:1D1B]  ;} PLM pre-instruction = RTS
$84:DF9A BF BC DE 7E LDA $7EDEBC,x[$7E:DF00];\
$84:DF9E 9D 27 1D    STA $1D27,x[$7E:1D6B]  ;} PLM instruction list pointer = [PLM link instruction]
$84:DFA1 A9 01 00    LDA #$0001             ;\
$84:DFA4 9F 1C DE 7E STA $7EDE1C,x[$7E:DE60];} PLM instruction timer = 1

$84:DFA8 60          RTS
}


;;; $DFA9: Instruction list - empty item ;;;
{
$84:DFA9             dx 0001,A2B5,
                        86BC        ; Delete
}


;;; $DFAF: Instruction list - item orb ;;;
{
$84:DFAF             dw 86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
$84:DFB3             dw 0014,A2C7,
                        000A,A2CD,
                        0014,A2D3,
                        000A,A2CD,
                        8724,DFB3   ; Go to $DFB3
}


;;; $DFC7: Instruction list - callable - item orb burst ;;;
{
$84:DFC7             dx 86CA,       ; Clear pre-instruction
                        0003,A2B5,
                        0003,A2D9,
                        0003,A2B5,
                        8A3A        ; Return
}


;;; $DFD7: Instruction list - callable - empty item orb ;;;
{
; Coded like an incomplete reconcealing orb
$84:DFD7             dx 86CA,       ; Clear pre-instruction
                        874E,16,    ; Timer = 16h
                        0008,A2B5,
                        873F,DFDC,  ; Decrement timer and go to $DFDC if non-zero
                        8A3A        ; Return
}


;;; $DFE6: Pre-instruction - wake PLM if triggered ;;;
{
$84:DFE6 BD 77 1D    LDA $1D77,x[$7E:1DBF]  ;\
$84:DFE9 C9 00 03    CMP #$0300             ;} Dead code: check against power bombs (if the item collision detection stored the projectile type into $1D77,x, which it doesn't)
$84:DFEC F0 18       BEQ $18    [$E006]     ;/
$84:DFEE 29 FF 00    AND #$00FF             ;\
$84:DFF1 C9 FF 00    CMP #$00FF             ;} If not triggered: return
$84:DFF4 D0 10       BNE $10    [$E006]     ;/
$84:DFF6 9E 77 1D    STZ $1D77,x[$7E:1DBF]  ; Clear triggered flag
$84:DFF9 FE 27 1D    INC $1D27,x[$7E:1D6F]  ;\
$84:DFFC FE 27 1D    INC $1D27,x[$7E:1D6F]  ;} PLM instruction list pointer += 2
$84:DFFF A9 01 00    LDA #$0001             ;\
$84:E002 9F 1C DE 7E STA $7EDE1C,x[$7E:DE64];} PLM instruction timer = 1

$84:E006 60          RTS
}


;;; $E007: Instruction list - callable - item shot block ;;;
{
$84:E007             dx 86C1,DFE6,  ; Pre-instruction = wake PLM if triggered
                        86B4,       ; Sleep
                        86CA,       ; Clear pre-instruction
                        8C10,0A,    ; Queue sound Ah, sound library 2, max queued sounds allowed = 6 (block crumbled)
                        0004,A3DD,
                        0004,A3E3,
                        0004,A3E9,
                        8A3A        ; Return
}


;;; $E020: Instruction list - callable - item shot block reconcealing ;;;
{
$84:E020             dx 86CA,       ; Clear pre-instruction
                        0004,A3E9,
                        0004,A3E3,
                        0004,A3DD,
                        8B05,       ; Draw PLM block
                        8A3A        ; Return
}


;;; $E032: Instruction list - callable - empty item shot block reconcealing ;;;
{
$84:E032             dx 86CA,       ; Clear pre-instruction
                        874E,16,    ; Timer = 16h
                        0008,A2B5,
                        873F,E037,  ; Decrement timer and go to $E037 if non-zero
                        0004,A351,
                        0004,A34B,
                        0004,A345,
                        8B05,       ; Draw PLM block
                        8A3A        ; Return
}


;;; $E04F: Instruction - draw item frame 0 ;;;
{
$84:E04F 5A          PHY                    ;\
$84:E050 BF 0C DF 7E LDA $7EDF0C,x[$7E:DF50];|
$84:E054 A8          TAY                    ;|
$84:E055 B9 5F E0    LDA $E05F,y[$84:E05F]  ;} PLM draw instruction = [$E05F + [PLM item GFX index]]
$84:E058 9F 6C DE 7E STA $7EDE6C,x[$7E:DEB0];|
$84:E05C 7A          PLY                    ;/
$84:E05D 80 20       BRA $20    [$E07F]

$84:E05F             dw A30F, A31B, A327, A333
}


;;; $E067: Instruction - draw item frame 1 ;;;
{
$84:E067 5A          PHY                    ;\
$84:E068 BF 0C DF 7E LDA $7EDF0C,x[$7E:DF50];|
$84:E06C A8          TAY                    ;|
$84:E06D B9 77 E0    LDA $E077,y[$84:E077]  ;} PLM draw instruction = [$E077 + [PLM item GFX index]]
$84:E070 9F 6C DE 7E STA $7EDE6C,x[$7E:DEB0];|
$84:E074 7A          PLY                    ;/
$84:E075 80 08       BRA $08    [$E07F]

$84:E077             dw A315, A321, A32D, A339
}


;;; $E07F: Draw PLM and wait 4 frames ;;;
{
$84:E07F A9 04 00    LDA #$0004             ;\
$84:E082 9F 1C DE 7E STA $7EDE1C,x[$7E:DE60];} PLM instruction timer = 4
$84:E086 98          TYA                    ;\
$84:E087 9D 27 1D    STA $1D27,x[$7E:1D6B]  ;} PLM instruction list pointer = [Y]
$84:E08A 20 1E 86    JSR $861E  [$84:861E]  ; Process PLM draw instruction
$84:E08D AE 27 1C    LDX $1C27  [$7E:1C27]  ; X = [PLM index]
$84:E090 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$84:E094 20 AA 8D    JSR $8DAA  [$84:8DAA]  ; Draw PLM
$84:E097 68          PLA                    ; Terminate processing PLM
$84:E098 60          RTS
}


;;; $E099: Instruction list - PLM $EED7 (energy tank) ;;;
{
$84:E099             dx 887C,E0BA,  ; Go to $E0BA if the room argument item is collected
                        8A24,E0B1,  ; Link instruction = $E0B1
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
$84:E0A5             dx 0004,A2DF,
                        0004,A2E5,
                        8724,E0A5,  ; Go to $E0A5
$84:E0B1             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        8968,0064,  ; Collect 100 health energy tank
$84:E0BA             dx 8724,DFA9,  ; Go to $DFA9
}


;;; $E0BE: Instruction list - PLM $EEDB (missile tank) ;;;
{
$84:E0BE             dx 887C,E0DF,  ; Go to $E0DF if the room argument item is collected
                        8A24,E0D6,  ; Link instruction = $E0D6
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
$84:E0CA             dx 0004,A2EB,
                        0004,A2F1,
                        8724,E0CA,  ; Go to $E0CA
$84:E0D6             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        89A9,0005,  ; Collect 5 ammo missile tank
$84:E0DF             dx 8724,DFA9,  ; Go to $DFA9
}


;;; $E0E3: Instruction list - PLM $EEDF (super missile tank) ;;;
{
$84:E0E3             dx 887C,E104,  ; Go to $E104 if the room argument item is collected
                        8A24,E0FB,  ; Link instruction = $E0FB
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
$84:E0EF             dx 0004,A2F7,
                        0004,A2FD,
                        8724,E0EF,  ; Go to $E0EF
$84:E0FB             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        89D2,0005,  ; Collect 5 ammo super missile tank
$84:E104             dx 8724,DFA9,  ; Go to $DFA9
}


;;; $E108: Instruction list - PLM $EEE3 (power bomb tank) ;;;
{
$84:E108             dx 887C,E129,  ; Go to $E129 if the room argument item is collected
                        8A24,E120,  ; Link instruction = $E120
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
$84:E114             dx 0004,A303,
                        0004,A309,
                        8724,E114,  ; Go to $E114
$84:E120             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        89FB,0005,  ; Collect 5 ammo power bomb tank
$84:E129             dx 8724,DFA9,  ; Go to $DFA9
}


;;; $E12D: Instruction list - PLM $EEE7 (bombs) ;;;
{
$84:E12D             dx 8764,8000,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E157,                          ; Go to $E157 if the room argument item is collected
                        8A24,E14D,                          ; Link instruction = $E14D
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E145             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E145,                          ; Go to $E145
$84:E14D             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,1000,13,                       ; Pick up equipment 1000h and display message box 13h
$84:E157             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E15B: Instruction list - PLM $EEEB (charge beam) ;;;
{
$84:E15B             dx 8764,8B00,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E185,                          ; Go to $E185 if the room argument item is collected
                        8A24,E17B,                          ; Link instruction = $E17B
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E173             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E173,                          ; Go to $E173
$84:E17B             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,1000,0E,                       ; Pick up beam 1000h and display message box Eh
$84:E185             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E189: Instruction list - PLM $EEEF (ice beam) ;;;
{
$84:E189             dx 8764,8C00,00,03,00,00,00,03,00,00,  ; Load item PLM GFX
                        887C,E1B3,                          ; Go to $E1B3 if the room argument item is collected
                        8A24,E1A9,                          ; Link instruction = $E1A9
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E1A1             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E1A1,                          ; Go to $E1A1
$84:E1A9             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0002,0F,                       ; Pick up beam 2 and display message box Fh
$84:E1B3             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E1B7: Instruction list - PLM $EEF3 (hi-jump) ;;;
{
$84:E1B7             dx 8764,8400,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E1E1,                          ; Go to $E1E1 if the room argument item is collected
                        8A24,E1D7,                          ; Link instruction = $E1D7
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E1CF             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E1CF,                          ; Go to $E1CF
$84:E1D7             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0100,0B,                       ; Pick up equipment 100h and display message box Bh
$84:E1E1             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E1E5: Instruction list - PLM $EEF7 (speed booster) ;;;
{
$84:E1E5             dx 8764,8A00,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E20F,                          ; Go to $E20F if the room argument item is collected
                        8A24,E205,                          ; Link instruction = $E205
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E1FD             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E1FD,                          ; Go to $E1FD
$84:E205             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,2000,0D,                       ; Pick up equipment 2000h and display message box Dh
$84:E20F             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E213: Instruction list - PLM $EEFB (wave beam) ;;;
{
$84:E213             dx 8764,8D00,00,02,00,00,00,02,00,00,  ; Load item PLM GFX
                        887C,E23D,                          ; Go to $E23D if the room argument item is collected
                        8A24,E233,                          ; Link instruction = $E233
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E22B             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E22B,                          ; Go to $E22B
$84:E233             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0001,10,                       ; Pick up beam 1 and display message box 10h
$84:E23D             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E241: Instruction list - PLM $EEFF (spazer beam) ;;;
{
$84:E241             dx 8764,8F00,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E26B,                          ; Go to $E26B if the room argument item is collected
                        8A24,E261,                          ; Link instruction = $E261
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E259             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E259,                          ; Go to $E259
$84:E261             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0004,11,                       ; Pick up beam 4 and display message box 11h
$84:E26B             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E26F: Instruction list - PLM $EF03 (spring ball) ;;;
{
$84:E26F             dx 8764,8200,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E299,                          ; Go to $E299 if the room argument item is collected
                        8A24,E28F,                          ; Link instruction = $E28F
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E287             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E287,                          ; Go to $E287
$84:E28F             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0002,08,                       ; Pick up equipment 2 and display message box 8
$84:E299             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E29D: Instruction - clear charge beam counter ;;;
{
$84:E29D 9C D0 0C    STZ $0CD0  [$7E:0CD0]
$84:E2A0 60          RTS
}


;;; $E2A1: Instruction list - PLM $EF07 (varia suit) ;;;
{
$84:E2A1             dx 8764,8300,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E2D2,                          ; Go to $E2D2 if the room argument item is collected
                        8A24,E2C1,                          ; Link instruction = $E2C1
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E2B9             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E2B9,                          ; Go to $E2B9
$84:E2C1             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        E29D,                               ; Clear charge beam counter
                        88F3,0001,07,                       ; Pick up equipment 1 and display message box 7
                        870B,91D4E4,                        ; Call function varia suit pick up
$84:E2D2             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E2D6: Instruction list - PLM $EF0B (gravity suit) ;;;
{
$84:E2D6             dx 8764,8100,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E307,                          ; Go to $E307 if the room argument item is collected
                        8A24,E2F6,                          ; Link instruction = $E2F6
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E2EE             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E2EE,                          ; Go to $E2EE
$84:E2F6             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        E29D,                               ; Clear charge beam counter
                        88F3,0020,1A,                       ; Pick up equipment 20h and display message box 1Ah
                        870B,91D5BA,                        ; Call function gravity suit pick up
$84:E307             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E30B: Instruction list - PLM $EF0F (x-ray scope) ;;;
{
$84:E30B             dx 8764,8900,01,01,00,00,03,03,00,00,  ; Load item PLM GFX
                        887C,E334,                          ; Go to $E334 if the room argument item is collected
                        8A24,E32B,                          ; Link instruction = $E32B
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E323             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E323,                          ; Go to $E323
$84:E32B             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        8941,8000,                          ; Pick up equipment 8000h, add x-ray to HUD and display x-ray message box
$84:E334             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E338: Instruction list - PLM $EF13 (plasma beam) ;;;
{
$84:E338             dx 8764,8E00,00,01,00,00,00,01,00,00,  ; Load item PLM GFX
                        887C,E362,                          ; Go to $E362 if the room argument item is collected
                        8A24,E358,                          ; Link instruction = $E358
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E350             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E350,                          ; Go to $E350
$84:E358             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0008,12,                       ; Pick up beam 8 and display message box 12h
$84:E362             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E366: Instruction list - PLM $EF17 (grapple beam) ;;;
{
$84:E366             dx 8764,8800,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E38F,                          ; Go to $E38F if the room argument item is collected
                        8A24,E386,                          ; Link instruction = $E386
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E37E             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E37E,                          ; Go to $E37E
$84:E386             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        891A,4000,                          ; Pick up equipment 4000h, add grapple to HUD and display grapple message box
$84:E38F             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E393: Instruction list - PLM $EF1B (space jump) ;;;
{
$84:E393             dx 8764,8600,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E3BD,                          ; Go to $E3BD if the room argument item is collected
                        8A24,E3B3,                          ; Link instruction = $E3B3
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E3AB             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E3AB,                          ; Go to $E3AB
$84:E3B3             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0200,0C,                       ; Pick up equipment 0200h and display message box Ch
$84:E3BD             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E3C1: Instruction list - PLM $EF1F (screw attack) ;;;
{
$84:E3C1             dx 8764,8500,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E3EB,                          ; Go to $E3EB if the room argument item is collected
                        8A24,E3E1,                          ; Link instruction = $E3E1
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E3D9             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E3D9,                          ; Go to $E3D9
$84:E3E1             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0008,0A,                       ; Pick up equipment 8 and display message box Ah
$84:E3EB             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E3EF: Instruction list - PLM $EF23 (morph ball) ;;;
{
$84:E3EF             dx 8764,8700,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E419,                          ; Go to $E419 if the room argument item is collected
                        8A24,E40F,                          ; Link instruction = $E40F
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E407             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E407,                          ; Go to $E407
$84:E40F             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0004,09,                       ; Pick up equipment 4 and display message box 9
$84:E419             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E41D: Instruction list - PLM $EF27 (reserve tank) ;;;
{
$84:E41D             dx 8764,9000,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E446,                          ; Go to $E446 if the room argument item is collected
                        8A24,E43D,                          ; Link instruction = $E43D
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
$84:E435             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E435,                          ; Go to $E435
$84:E43D             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        8986,0064,                          ; Collect 0064h health reserve tank
$84:E446             dx 8724,DFA9,                          ; Go to $DFA9
}


;;; $E44A: Instruction list - PLM $EF2B (energy tank, chozo orb) ;;;
{
$84:E44A             dx 887C,E476,  ; Go to $E476 if the room argument item is collected
                        8A2E,DFAF,  ; Call $DFAF (item orb)
                        8A2E,DFC7,  ; Call $DFC7 (item orb burst)
                        8A24,E46D,  ; Link instruction = $E46D
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
                        874E,16,    ; Timer = 16h
$84:E461             dx 0004,A2DF,
                        0004,A2E5,
                        8724,E461,  ; Go to $E461
$84:E46D             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        8968,0064,  ; Collect 0064h health energy tank
$84:E476             dx 0001,A2B5,
                        86BC        ; Delete
}


;;; $E47C: Instruction list - PLM $EF2F (missile tank, chozo orb) ;;;
{
$84:E47C             dx 887C,E4A8,  ; Go to $E4A8 if the room argument item is collected
                        8A2E,DFAF,  ; Call $DFAF (item orb)
                        8A2E,DFC7,  ; Call $DFC7 (item orb burst)
                        8A24,E49F,  ; Link instruction = $E49F
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
                        874E,16,    ; Timer = 16h
$84:E493             dx 0004,A2EB,
                        0004,A2F1,
                        8724,E493,  ; Go to $E493
$84:E49F             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        89A9,0005,  ; Collect 0005h ammo missile tank
$84:E4A8             dx 0001,A2B5,
                        86BC        ; Delete
}


;;; $E4AE: Instruction list - PLM $EF33 (super missile tank, chozo orb) ;;;
{
$84:E4AE             dx 887C,E4DA,  ; Go to $E4DA if the room argument item is collected
                        8A2E,DFAF,  ; Call $DFAF (item orb)
                        8A2E,DFC7,  ; Call $DFC7 (item orb burst)
                        8A24,E4D1,  ; Link instruction = $E4D1
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
                        874E,16,    ; Timer = 16h
$84:E4C5             dx 0004,A2F7,
                        0004,A2FD,
                        8724,E4C5,  ; Go to $E4C5
$84:E4D1             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        89D2,0005,  ; Collect 0005h ammo super missile tank
$84:E4DA             dx 0001,A2B5,
                        86BC        ; Delete
}


;;; $E4E0: Instruction list - PLM $EF37 (power bomb tank, chozo orb) ;;;
{
$84:E4E0             dx 887C,E50C,  ; Go to $E50C if the room argument item is collected
                        8A2E,DFAF,  ; Call $DFAF (item orb)
                        8A2E,DFC7,  ; Call $DFC7 (item orb burst)
                        8A24,E503,  ; Link instruction = $E503
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
                        874E,16,    ; Timer = 16h
$84:E4F7             dx 0004,A303,
                        0004,A309,
                        8724,E4F7,  ; Go to $E4F7
$84:E503             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        89FB,0005,  ; Collect 0005h ammo power bomb tank
$84:E50C             dx 0001,A2B5,
                        86BC        ; Delete
}


;;; $E512: Instruction list - PLM $EF3B (bombs, chozo orb) ;;;
{
$84:E512             dx 8764,8000,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E547,                          ; Go to $E547 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E53D,                          ; Link instruction = $E53D
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E535             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E535,                          ; Go to $E535
$84:E53D             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,1000,13,                       ; Pick up equipment 1000h and display message box 13h
$84:E547             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E54D: Instruction list - PLM $EF3F (charge beam, chozo orb) ;;;
{
$84:E54D             dx 8764,8B00,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E582,                          ; Go to $E582 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E578,                          ; Link instruction = $E578
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E570             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E570,                          ; Go to $E570
$84:E578             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,1000,0E,                       ; Pick up beam 1000h and display message box 0Eh
$84:E582             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E588: Instruction list - PLM $EF43 (ice beam, chozo orb) ;;;
{
$84:E588             dx 8764,8C00,00,03,00,00,00,03,00,00,  ; Load item PLM GFX
                        887C,E5BD,                          ; Go to $E5BD if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E5B3,                          ; Link instruction = $E5B3
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E5AB             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E5AB,                          ; Go to $E5AB
$84:E5B3             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0002,0F,                       ; Pick up beam 0002h and display message box 0Fh
$84:E5BD             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E5C3: Instruction list - PLM $EF47 (hi-jump, chozo orb) ;;;
{
$84:E5C3             dx 8764,8400,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E5F8,                          ; Go to $E5F8 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E5EE,                          ; Link instruction = $E5EE
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E5E6             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E5E6,                          ; Go to $E5E6
$84:E5EE             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0100,0B,                       ; Pick up equipment 0100h and display message box 0Bh
$84:E5F8             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E5FE: Instruction list - PLM $EF4B (speed booster, chozo orb) ;;;
{
$84:E5FE             dx 8764,8A00,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E635,                          ; Go to $E635 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E629,                          ; Link instruction = $E629
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E621             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E621,                          ; Go to $E621
$84:E629             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,2000,0D,                       ; Pick up equipment 2000h and display message box 0Dh
$84:E633             dx E63B,                               ; FX Y velocity = FFE0h
                        0001,A2B5,
                        86BC                                ; Delete
}


;;; $E63B: Instruction - FX Y velocity = FFE0h ;;;
{
$84:E63B A9 E0 FF    LDA #$FFE0
$84:E63E 8D 7C 19    STA $197C  [$7E:197C]
$84:E641 60          RTS
}


;;; $E642: Instruction list - PLM $EF4F (wave beam, chozo orb) ;;;
{
$84:E642             dx 8764,8D00,00,02,00,00,00,02,00,00,  ; Load item PLM GFX
                        887C,E677,                          ; Go to $E677 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E66D,                          ; Link instruction = $E66D
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E665             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E665,                          ; Go to $E665
$84:E66D             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0001,10,                       ; Pick up beam 0001h and display message box 10h
$84:E677             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E67D: Instruction list - PLM $EF53 (spazer beam, chozo orb) ;;;
{
$84:E67D             dx 8764,8F00,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E6B2,                          ; Go to $E6B2 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E6A8,                          ; Link instruction = $E6A8
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E6A0             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E6A0,                          ; Go to $E6A0
$84:E6A8             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0004,11,                       ; Pick up beam 0004h and display message box 11h
$84:E6B2             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E6B8: Instruction list - PLM $EF57 (spring ball, chozo orb) ;;;
{
$84:E6B8             dx 8764,8200,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E6ED,                          ; Go to $E6ED if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E6E3,                          ; Link instruction = $E6E3
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E6DB             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E6DB,                          ; Go to $E6DB
$84:E6E3             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0002,08,                       ; Pick up equipment 0002h and display message box 08h
$84:E6ED             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E6F3: Instruction list - PLM $EF5B (varia suit, chozo orb) ;;;
{
$84:E6F3             dx 8764,8300,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E72F,                          ; Go to $E72F if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E71E,                          ; Link instruction = $E71E
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E716             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E716,                          ; Go to $E716
$84:E71E             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        E29D,                               ; Clear charge beam counter
                        88F3,0001,07,                       ; Pick up equipment 0001h and display message box 07h
                        870B,91D4E4,                        ; Call function varia suit pick up
$84:E72F             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E735: Instruction list - PLM $EF5F (gravity suit, chozo orb) ;;;
{
$84:E735             dx 8764,8100,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E771,                          ; Go to $E771 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E760,                          ; Link instruction = $E760
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E758             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E758,                          ; Go to $E758
$84:E760             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        E29D,                               ; Clear charge beam counter
                        88F3,0020,1A,                       ; Pick up equipment 0020h and display message box 1Ah
                        870B,91D5BA,                        ; Call function gravity suit pick up
$84:E771             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E777: Instruction list - PLM $EF63 (x-ray scope, chozo orb) ;;;
{
$84:E777             dx 8764,8900,01,01,00,00,03,03,00,00,  ; Load item PLM GFX
                        887C,E7AB,                          ; Go to $E7AB if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E7A2,                          ; Link instruction = $E7A2
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E79A             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E79A,                          ; Go to $E79A
$84:E7A2             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        8941,8000,                          ; Pick up equipment 8000h, add x-ray to HUD and display x-ray message box
$84:E7AB             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E7B1: Instruction list - PLM $EF67 (plasma beam, chozo orb) ;;;
{
$84:E7B1             dx 8764,8E00,00,01,00,00,00,01,00,00,  ; Load item PLM GFX
                        887C,E7E6,                          ; Go to $E7E6 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E7DC,                          ; Link instruction = $E7DC
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E7D4             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E7D4,                          ; Go to $E7D4
$84:E7DC             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0008,12,                       ; Pick up beam 0008h and display message box 12h
$84:E7E6             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E7EC: Instruction list - PLM $EF6B (grapple beam, chozo orb) ;;;
{
$84:E7EC             dx 8764,8800,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E820,                          ; Go to $E820 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E817,                          ; Link instruction = $E817
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E80F             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E80F,                          ; Go to $E80F
$84:E817             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        891A,4000,                          ; Pick up equipment 4000h, add grapple to HUD and display grapple message box
$84:E820             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E826: Instruction list - PLM $EF6F (space jump, chozo orb) ;;;
{
$84:E826             dx 8764,8600,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E85B,                          ; Go to $E85B if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E851,                          ; Link instruction = $E851
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E849             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E849,                          ; Go to $E849
$84:E851             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0200,0C,                       ; Pick up equipment 0200h and display message box 0Ch
$84:E85B             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E861: Instruction list - PLM $EF73 (screw attack, chozo orb) ;;;
{
$84:E861             dx 8764,8500,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E896,                          ; Go to $E896 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E88C,                          ; Link instruction = $E88C
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E884             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E884,                          ; Go to $E884
$84:E88C             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0008,0A,                       ; Pick up equipment 0008h and display message box 0Ah
$84:E896             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E89C: Instruction list - PLM $EF77 (morph ball, chozo orb) ;;;
{
$84:E89C             dx 8764,8700,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E8D1,                          ; Go to $E8D1 if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E8C7,                          ; Link instruction = $E8C7
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E8BF             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E8BF,                          ; Go to $E8BF
$84:E8C7             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0002,09,                       ; Pick up equipment 0002h and display message box 09h
$84:E8D1             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E8D7: Instruction list - PLM $EF7B (reserve tank, chozo orb) ;;;
{
$84:E8D7             dx 8764,9000,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        887C,E90B,                          ; Go to $E90B if the room argument item is collected
                        8A2E,DFAF,                          ; Call $DFAF (item orb)
                        8A2E,DFC7,                          ; Call $DFC7 (item orb burst)
                        8A24,E902,                          ; Link instruction = $E902
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:E8FA             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        8724,E8FA,                          ; Go to $E8FA
$84:E902             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        8986,0064,                          ; Collect 0064h health reserve tank
$84:E90B             dx 0001,A2B5,
                        86BC                                ; Delete
}


;;; $E911: Instruction list - PLM $EF7F (energy tank, shot block) ;;;
{
$84:E911             dx 8A2E,E007,  ; Call $E007 (item shot block)
                        887C,E941,  ; Go to $E941 if the room argument item is collected
                        8A24,E938,  ; Link instruction = $E938
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
                        874E,16,    ; Timer = 16h
$84:E924             dx 0004,A2DF,
                        0004,A2E5,
                        873F,E924,  ; Decrement timer and go to $E924 if non-zero
                        8A2E,E020,  ; Call $E020 (item shot block reconcealing)
                        8724,E911,  ; Go to $E911
$84:E938             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        8968,0064,  ; Collect 0064h health energy tank
$84:E941             dx 8A2E,E032,  ; Call $E032 (empty item shot block reconcealing)
                        8724,E911,  ; Go to $E911
}


;;; $E949: Instruction list - PLM $EF83 (missile tank, shot block) ;;;
{
$84:E949             dx 8A2E,E007,  ; Call $E007 (item shot block)
                        887C,E979,  ; Go to $E979 if the room argument item is collected
                        8A24,E970,  ; Link instruction = $E970
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
                        874E,16,    ; Timer = 16h
$84:E95C             dx 0004,A2EB,
                        0004,A2F1,
                        873F,E95C,  ; Decrement timer and go to $E95C if non-zero
                        8A2E,E020,  ; Call $E020 (item shot block reconcealing)
                        8724,E949,  ; Go to $E949
$84:E970             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        89A9,0005,  ; Collect 0005h ammo missile tank
$84:E979             dx 8A2E,E032,  ; Call $E032 (empty item shot block reconcealing)
                        8724,E949,  ; Go to $E949
}


;;; $E981: Instruction list - PLM $EF87 (super missile tank, shot block) ;;;
{
$84:E981             dx 8A2E,E007,  ; Call $E007 (item shot block)
                        887C,E9B1,  ; Go to $E9B1 if the room argument item is collected
                        8A24,E9A8,  ; Link instruction = $E9A8
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
                        874E,16,    ; Timer = 16h
$84:E994             dx 0004,A2F7,
                        0004,A2FD,
                        873F,E994,  ; Decrement timer and go to $E994 if non-zero
                        8A2E,E020,  ; Call $E020 (item shot block reconcealing)
                        8724,E981,  ; Go to $E981
$84:E9A8             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        89D2,0005,  ; Collect 0005h ammo super missile tank
$84:E9B1             dx 8A2E,E032,  ; Call $E032 (empty item shot block reconcealing)
                        8724,E981,  ; Go to $E981
}


;;; $E9B9: Instruction list - PLM $EF8B (power bomb tank, shot block) ;;;
{
$84:E9B9             dx 8A2E,E007,  ; Call $E007 (item shot block)
                        887C,E9E9,  ; Go to $E9E9 if the room argument item is collected
                        8A24,E9E0,  ; Link instruction = $E9E0
                        86C1,DF89,  ; Pre-instruction = go to link instruction if triggered
                        874E,16,    ; Timer = 16h
$84:E9CC             dx 0004,A303,
                        0004,A309,
                        873F,E9CC,  ; Decrement timer and go to $E9CC if non-zero
                        8A2E,E020,  ; Call $E020 (item shot block reconcealing)
                        8724,E9B9,  ; Go to $E9B9
$84:E9E0             dx 8899,       ; Set the room argument item collected
                        8BDD,02,    ; Clear music queue and queue item fanfare music track
                        89FB,0005,  ; Collect 0005h ammo power bomb tank
$84:E9E9             dx 8A2E,E032,  ; Call $E032 (empty item shot block reconcealing)
                        8724,E9B9,  ; Go to $E9B9
}


;;; $E9F1: Instruction list - PLM $EF8F (bombs, shot block) ;;;
{
$84:E9F1             dx 8764,8000,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EA2A,                          ; Go to $EA2A if the room argument item is collected
                        8A24,EA20,                          ; Link instruction = $EA20
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EA10             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EA10,                          ; Decrement timer and go to $EA10 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,E9FD,                          ; Go to $E9FD
$84:EA20             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,1000,13,                       ; Pick up equipment 1000h and display message box 13h
$84:EA2A             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,E9FD,                          ; Go to $E9FD
}


;;; $EA32: Instruction list - PLM $EF93 (charge beam, shot block) ;;;
{
$84:EA32             dx 8764,8B00,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EA6B,                          ; Go to $EA6B if the room argument item is collected
                        8A24,EA61,                          ; Link instruction = $EA61
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EA51             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EA51,                          ; Decrement timer and go to $EA51 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EA3E,                          ; Go to $EA3E
$84:EA61             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,1000,0E,                       ; Pick up beam 1000h and display message box 0Eh
$84:EA6B             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EA3E,                          ; Go to $EA3E
}


;;; $EA73: Instruction list - PLM $EF97 (ice beam, shot block) ;;;
{
$84:EA73             dx 8764,8C00,00,03,00,00,00,03,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EAAC,                          ; Go to $EAAC if the room argument item is collected
                        8A24,EAA2,                          ; Link instruction = $EAA2
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EA92             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EA92,                          ; Decrement timer and go to $EA92 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EA7F,                          ; Go to $EA7F
$84:EAA2             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0002,0F,                       ; Pick up beam 0002h and display message box 0Fh
$84:EAAC             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EA7F,                          ; Go to $EA7F
}


;;; $EAB4: Instruction list - PLM $EF9B (hi-jump, shot block) ;;;
{
$84:EAB4             dx 8764,8400,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EAED,                          ; Go to $EAED if the room argument item is collected
                        8A24,EAE3,                          ; Link instruction = $EAE3
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EAD3             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EAD3,                          ; Decrement timer and go to $EAD3 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EAC0,                          ; Go to $EAC0
$84:EAE3             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0100,0B,                       ; Pick up equipment 0100h and display message box 0Bh
$84:EAED             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EAC0,                          ; Go to $EAC0
}


;;; $EAF5: Instruction list - PLM $EF9F (speed booster, shot block) ;;;
{
$84:EAF5             dx 8764,8A00,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EB2E,                          ; Go to $EB2E if the room argument item is collected
                        8A24,EB24,                          ; Link instruction = $EB24
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EB14             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EB14,                          ; Decrement timer and go to $EB14 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EB01,                          ; Go to $EB01
$84:EB24             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,2000,0D,                       ; Pick up equipment 2000h and display message box 0Dh
$84:EB2E             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EB01,                          ; Go to $EB01
}


;;; $EB36: Instruction list - PLM $EFA3 (wave beam, shot block) ;;;
{
$84:EB36             dx 8764,8D00,00,02,00,00,00,02,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EB6F,                          ; Go to $EB6F if the room argument item is collected
                        8A24,EB65,                          ; Link instruction = $EB65
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EB55             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EB55,                          ; Decrement timer and go to $EB55 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EB42,                          ; Go to $EB42
$84:EB65             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0001,10,                       ; Pick up beam 0001h and display message box 10h
$84:EB6F             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EB42,                          ; Go to $EB42
}


;;; $EB77: Instruction list - PLM $EFA7 (spazer beam, shot block) ;;;
{
$84:EB77             dx 8764,8F00,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EBB0,                          ; Go to $EBB0 if the room argument item is collected
                        8A24,EBA6,                          ; Link instruction = $EBA6
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EB96             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EB96,                          ; Decrement timer and go to $EB96 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EB83,                          ; Go to $EB83
$84:EBA6             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0004,11,                       ; Pick up beam 0004h and display message box 11h
$84:EBB0             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EB83,                          ; Go to $EB83
}


;;; $EBB8: Instruction list - PLM $EFAB (spring ball, shot block) ;;;
{
$84:EBB8             dx 8764,8200,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EBF1,                          ; Go to $EBF1 if the room argument item is collected
                        8A24,EBE7,                          ; Link instruction = $EBE7
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EBD7             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EBD7,                          ; Decrement timer and go to $EBD7 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EBC4,                          ; Go to $EBC4
$84:EBE7             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0002,08,                       ; Pick up equipment 0002h and display message box 08h
$84:EBF1             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EBC4,                          ; Go to $EBC4
}


;;; $EBF9: Instruction list - PLM $EFAF (varia suit, shot block) ;;;
{
$84:EBF9             dx 8764,8300,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EC39,                          ; Go to $EC39 if the room argument item is collected
                        8A24,EC28,                          ; Link instruction = $EC28
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EC18             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EC18,                          ; Decrement timer and go to $EC18 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EC05,                          ; Go to $EC05
$84:EC28             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        E29D,                               ; Clear charge beam counter
                        88F3,0001,07,                       ; Pick up equipment 0001h and display message box 07h
                        870B,91D4E4,                        ; Call function varia suit pick up
$84:EC39             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EC05,                          ; Go to $EC05
}


;;; $EC41: Instruction list - PLM $EFB3 (gravity suit, shot block) ;;;
{
$84:EC41             dx 8764,8100,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EC81,                          ; Go to $EC81 if the room argument item is collected
                        8A24,EC70,                          ; Link instruction = $EC70
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EC60             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EC60,                          ; Decrement timer and go to $EC60 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EC4D,                          ; Go to $EC4D
$84:EC70             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        E29D,                               ; Clear charge beam counter
                        88F3,0020,1A,                       ; Pick up equipment 0020h and display message box 1Ah
                        870B,91D5BA,                        ; Call function gravity suit pick up
$84:EC81             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EC4D,                          ; Go to $EC4D
}


;;; $EC89: Instruction list - PLM $EFB7 (x-ray scope, shot block) ;;;
{
$84:EC89             dx 8764,8900,01,01,00,00,03,03,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,ECC1,                          ; Go to $ECC1 if the room argument item is collected
                        8A24,ECB8,                          ; Link instruction = $ECB8
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:ECA8             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,ECA8,                          ; Decrement timer and go to $ECA8 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EC95,                          ; Go to $EC95
$84:ECB8             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        8941,8000,                          ; Pick up equipment 8000h, add x-ray to HUD and display x-ray message box
$84:ECC1             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EC95,                          ; Go to $EC95
}


;;; $ECC9: Instruction list - PLM $EFBB (plasma beam, shot block) ;;;
{
$84:ECC9             dx 8764,8E00,00,01,00,00,00,01,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,ED02,                          ; Go to $ED02 if the room argument item is collected
                        8A24,ECF8,                          ; Link instruction = $ECF8
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:ECE8             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,ECE8,                          ; Decrement timer and go to $ECE8 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,ECD5,                          ; Go to $ECD5
$84:ECF8             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88B0,0008,12,                       ; Pick up beam 0008h and display message box 12h
$84:ED02             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,ECD5,                          ; Go to $ECD5
}


;;; $ED0A: Instruction list - PLM $EFBF (grapple beam, shot block) ;;;
{
$84:ED0A             dx 8764,8800,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,ED42,                          ; Go to $ED42 if the room argument item is collected
                        8A24,ED39,                          ; Link instruction = $ED39
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:ED29             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,ED29,                          ; Decrement timer and go to $ED29 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,ED16,                          ; Go to $ED16
$84:ED39             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        891A,4000,                          ; Pick up equipment 4000h, add grapple to HUD and display grapple message box
$84:ED42             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,ED16,                          ; Go to $ED16
}


;;; $ED4A: Instruction list - PLM $EFC3 (space jump, shot block) ;;;
{
$84:ED4A             dx 8764,8600,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,ED83,                          ; Go to $ED83 if the room argument item is collected
                        8A24,ED79,                          ; Link instruction = $ED79
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:ED69             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,ED69,                          ; Decrement timer and go to $ED69 if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,ED56,                          ; Go to $ED56
$84:ED79             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0200,0C,                       ; Pick up equipment 0200h and display message box 0Ch
$84:ED83             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,ED56,                          ; Go to $ED56
}


;;; $ED8B: Instruction list - PLM $EFC7 (screw attack, shot block) ;;;
{
$84:ED8B             dx 8764,8500,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EDC4,                          ; Go to $EDC4 if the room argument item is collected
                        8A24,EDBA,                          ; Link instruction = $EDBA
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EDAA             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EDAA,                          ; Decrement timer and go to $EDAA if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,ED97,                          ; Go to $ED97
$84:EDBA             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0008,0A,                       ; Pick up equipment 0008h and display message box 0Ah
$84:EDC4             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,ED97,                          ; Go to $ED97
}


;;; $EDCC: Instruction list - PLM $EFCB (morph ball, shot block) ;;;
{
$84:EDCC             dx 8764,8700,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EE05,                          ; Go to $EE05 if the room argument item is collected
                        8A24,EDFB,                          ; Link instruction = $EDFB
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EDEB             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EDEB,                          ; Decrement timer and go to $EDEB if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EDD8,                          ; Go to $EDD8
$84:EDFB             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        88F3,0002,09,                       ; Pick up equipment 0002h and display message box 09h
$84:EE05             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EDD8,                          ; Go to $EDD8
}


;;; $EE0D: Instruction list - PLM $EFCF (reserve tank, shot block) ;;;
{
$84:EE0D             dx 8764,9000,00,00,00,00,00,00,00,00,  ; Load item PLM GFX
                        8A2E,E007,                          ; Call $E007 (item shot block)
                        887C,EE45,                          ; Go to $EE45 if the room argument item is collected
                        8A24,EE3C,                          ; Link instruction = $EE3C
                        86C1,DF89,                          ; Pre-instruction = go to link instruction if triggered
                        874E,16,                            ; Timer = 16h
$84:EE2C             dx E04F,                               ; Draw item frame 0
                        E067,                               ; Draw item frame 1
                        873F,EE2C,                          ; Decrement timer and go to $EE2C if non-zero
                        8A2E,E020,                          ; Call $E020 (item shot block reconcealing)
                        8724,EE19,                          ; Go to $EE19
$84:EE3C             dx 8899,                               ; Set the room argument item collected
                        8BDD,02,                            ; Clear music queue and queue item fanfare music track
                        8986,0064,                          ; Collect 0064h health reserve tank
$84:EE45             dx 8A2E,E032,                          ; Call $E032 (empty item shot block reconcealing)
                        8724,EE19,                          ; Go to $EE19
}
}


;;; $EE4D..D2: Setups ;;;
{
;;; $EE4D: Setup - PLM $EED7/$EF2B (energy tank) ;;;
{
$84:EE4D A9 08 00    LDA #$0008
$84:EE50 80 0D       BRA $0D    [$EE5F]
}


;;; $EE52: Setup - PLM $EEDB/$EF2F (missile tank) ;;;
{
$84:EE52 A9 0A 00    LDA #$000A
$84:EE55 80 08       BRA $08    [$EE5F]
}


;;; $EE57: Setup - PLM $EEDF/$EF33 (super missile tank) ;;;
{
$84:EE57 A9 0C 00    LDA #$000C
$84:EE5A 80 03       BRA $03    [$EE5F]
}


;;; $EE5C: Setup - PLM $EEE3/$EF37 (power bomb tank) ;;;
{
$84:EE5C A9 0E 00    LDA #$000E
}


;;; $EE5F: Set PLM item GFX index and do ability setup ;;;
{
$84:EE5F BB          TYX                    ;\
$84:EE60 9F 0C DF 7E STA $7EDF0C,x[$7E:DF5A];} PLM item GFX index = [A]
}


;;; $EE64: Setup - PLM $EEE7/$EEEB/$EEEF/$EF03/$EF07/$EF0B/$EF0F/$EF13/$EF17/$EF1B/$EF1F/$EF23/$EF27/$EF2B/$EF2F/$EF33/$EF37/$EF3B/$EF3F/$EF43/$EF47/$EF4B/$EF4F/$EF53/$EF57/$EF5B/$EF5F/$EF63/$EF67/$EF6B/$EF6F/$EF73/$EF77/$EF7B (ability) ;;;
{
$84:EE64 BE 87 1C    LDX $1C87,y[$7E:1CCB]  ;\
$84:EE67 A9 45 00    LDA #$0045             ;} Make PLM block an air block with BTS 45h (BTS for item collision detection)
$84:EE6A 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:EE6D AF 1A D9 7E LDA $7ED91A[$7E:D91A]  ;\
$84:EE71 1A          INC A                  ;} Increment global number of items loaded counter
$84:EE72 8F 1A D9 7E STA $7ED91A[$7E:D91A]  ;/
$84:EE76 60          RTS
}


;;; $EE77: Setup - PLM $EF7F (energy tank shot block) ;;;
{
$84:EE77 A9 08 00    LDA #$0008
$84:EE7A 80 0D       BRA $0D    [$EE89]
}


;;; $EE7C: Setup - PLM $EF83 (missile tank shot block) ;;;
{
$84:EE7C A9 0A 00    LDA #$000A
$84:EE7F 80 08       BRA $08    [$EE89]
}


;;; $EE81: Setup - PLM $EF87 (super missile tank shot block) ;;;
{
$84:EE81 A9 0C 00    LDA #$000C
$84:EE84 80 03       BRA $03    [$EE89]
}


;;; $EE86: Setup - PLM $EF8B (power bomb tank shot block) ;;;
{
$84:EE86 A9 0E 00    LDA #$000E
}


;;; $EE89: Set PLM item GFX index and do ability shot block setup ;;;
{
$84:EE89 BB          TYX                    ;\
$84:EE8A 9F 0C DF 7E STA $7EDF0C,x[$7E:DF54];} PLM item GFX index = [A]
}


;;; $EE8E: Setup - PLM $EF8F/$EF93/$EF97/$EF9B/$EF9F/$EFA3/$EFA7/$EFAB/$EFAF/$EFB3/$EFB7/$EFBB/$EFBF/$EFC3/$EFC7/$EFCB/$EFCF (ability shot block) ;;;
{
$84:EE8E BE 87 1C    LDX $1C87,y[$7E:1CCF]  ;\
$84:EE91 A9 45 C0    LDA #$C045             ;} Make PLM block an item collision detection block
$84:EE94 20 B4 82    JSR $82B4  [$84:82B4]  ;/
$84:EE97 BE 87 1C    LDX $1C87,y[$7E:1CCF]  ;\
$84:EE9A BF 02 00 7F LDA $7F0002,x[$7F:0CFA];} PLM respawn block = [PLM block]
$84:EE9E 99 17 1E    STA $1E17,y[$7E:1E5F]  ;/
$84:EEA1 AF 1A D9 7E LDA $7ED91A[$7E:D91A]  ;\
$84:EEA5 1A          INC A                  ;} Increment global number of items loaded counter
$84:EEA6 8F 1A D9 7E STA $7ED91A[$7E:D91A]  ;/
$84:EEAA 60          RTS
}


;;; $EEAB: Setup - PLM $EED3 (shot/bombed/grappled reaction, shootable, BTS 45h / collision reaction, special, BTS 45h. Item collision detection) ;;;
{
;; Returns:
;;     Carry: Clear (no collision) if time is not frozen, unchanged otherwise
$84:EEAB AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$84:EEAE D0 1C       BNE $1C    [$EECC]     ;} If time is frozen: go to BRANCH_DELETE
$84:EEB0 BB          TYX                    ;\
$84:EEB1 BD 87 1C    LDA $1C87,x[$7E:1CC9]  ;} A = [PLM block index]
$84:EEB4 9E 87 1C    STZ $1C87,x[$7E:1CC9]  ; PLM block index = 0
$84:EEB7 A2 4E 00    LDX #$004E             ; X = 4Eh (PLM index)

; LOOP
$84:EEBA DD 87 1C    CMP $1C87,x[$7E:1CD5]  ;\
$84:EEBD F0 05       BEQ $05    [$EEC4]     ;} If [PLM [X] block index] = [A]: go to BRANCH_FOUND
$84:EEBF CA          DEX                    ;\
$84:EEC0 CA          DEX                    ;} X -= 2
$84:EEC1 10 F7       BPL $F7    [$EEBA]     ; If [X] >= 0: go to LOOP
$84:EEC3 00          BRK                    ; Crash

; BRANCH_FOUND
$84:EEC4 A9 FF 00    LDA #$00FF             ;\
$84:EEC7 9D 77 1D    STA $1D77,x[$7E:1DBB]  ;} Trigger PLM [X]
$84:EECA 18          CLC                    ;\
$84:EECB 60          RTS                    ;} Return carry clear

; BRANCH_DELETE
$84:EECC A9 00 00    LDA #$0000             ;\
$84:EECF 99 37 1C    STA $1C37,y            ;} PLM ID = 0
$84:EED2 60          RTS
}
}


;;; $EED3: PLM entries ;;;
{
$84:EED3             dw EEAB,AAE3 ; Shot/bombed/grappled reaction, shootable, BTS 45h / collision reaction, special, BTS 45h. Item collision detection
$84:EED7             dw EE4D,E099 ; Energy tank
$84:EEDB             dw EE52,E0BE ; Missile tank
$84:EEDF             dw EE57,E0E3 ; Super missile tank
$84:EEE3             dw EE5C,E108 ; Power bomb tank
$84:EEE7             dw EE64,E12D ; Bombs
$84:EEEB             dw EE64,E15B ; Charge beam
$84:EEEF             dw EE64,E189 ; Ice beam
$84:EEF3             dw EE64,E1B7 ; Hi-jump
$84:EEF7             dw EE64,E1E5 ; Speed booster
$84:EEFB             dw EE64,E213 ; Wave beam
$84:EEFF             dw EE64,E241 ; Spazer beam
$84:EF03             dw EE64,E26F ; Spring ball
$84:EF07             dw EE64,E2A1 ; Varia suit
$84:EF0B             dw EE64,E2D6 ; Gravity suit
$84:EF0F             dw EE64,E30B ; X-ray scope
$84:EF13             dw EE64,E338 ; Plasma beam
$84:EF17             dw EE64,E366 ; Grapple beam
$84:EF1B             dw EE64,E393 ; Space jump
$84:EF1F             dw EE64,E3C1 ; Screw attack
$84:EF23             dw EE64,E3EF ; Morph ball
$84:EF27             dw EE64,E41D ; Reserve tank
$84:EF2B             dw EE4D,E44A ; Energy tank, chozo orb
$84:EF2F             dw EE52,E47C ; Missile tank, chozo orb
$84:EF33             dw EE57,E4AE ; Super missile tank, chozo orb
$84:EF37             dw EE5C,E4E0 ; Power bomb tank, chozo orb
$84:EF3B             dw EE64,E512 ; Bombs, chozo orb
$84:EF3F             dw EE64,E54D ; Charge beam, chozo orb
$84:EF43             dw EE64,E588 ; Ice beam, chozo orb
$84:EF47             dw EE64,E5C3 ; Hi-jump, chozo orb
$84:EF4B             dw EE64,E5FE ; Speed booster, chozo orb
$84:EF4F             dw EE64,E642 ; Wave beam, chozo orb
$84:EF53             dw EE64,E67D ; Spazer beam, chozo orb
$84:EF57             dw EE64,E6B8 ; Spring ball, chozo orb
$84:EF5B             dw EE64,E6F3 ; Varia suit, chozo orb
$84:EF5F             dw EE64,E735 ; Gravity suit, chozo orb
$84:EF63             dw EE64,E777 ; X-ray scope, chozo orb
$84:EF67             dw EE64,E7B1 ; Plasma beam, chozo orb
$84:EF6B             dw EE64,E7EC ; Grapple beam, chozo orb
$84:EF6F             dw EE64,E826 ; Space jump, chozo orb
$84:EF73             dw EE64,E861 ; Screw attack, chozo orb
$84:EF77             dw EE64,E89C ; Morph ball, chozo orb
$84:EF7B             dw EE64,E8D7 ; Reserve tank, chozo orb
$84:EF7F             dw EE77,E911 ; Energy tank, shot block
$84:EF83             dw EE7C,E949 ; Missile tank, shot block
$84:EF87             dw EE81,E981 ; Super missile tank, shot block
$84:EF8B             dw EE86,E9B9 ; Power bomb tank, shot block
$84:EF8F             dw EE8E,E9F1 ; Bombs, shot block
$84:EF93             dw EE8E,EA32 ; Charge beam, shot block
$84:EF97             dw EE8E,EA73 ; Ice beam, shot block
$84:EF9B             dw EE8E,EAB4 ; Hi-jump, shot block
$84:EF9F             dw EE8E,EAF5 ; Speed booster, shot block
$84:EFA3             dw EE8E,EB36 ; Wave beam, shot block
$84:EFA7             dw EE8E,EB77 ; Spazer beam, shot block
$84:EFAB             dw EE8E,EBB8 ; Spring ball, shot block
$84:EFAF             dw EE8E,EBF9 ; Varia suit, shot block
$84:EFB3             dw EE8E,EC41 ; Gravity suit, shot block
$84:EFB7             dw EE8E,EC89 ; X-ray scope, shot block
$84:EFBB             dw EE8E,ECC9 ; Plasma beam, shot block
$84:EFBF             dw EE8E,ED0A ; Grapple beam, shot block
$84:EFC3             dw EE8E,ED4A ; Space jump, shot block
$84:EFC7             dw EE8E,ED8B ; Screw attack, shot block
$84:EFCB             dw EE8E,EDCC ; Morph ball, shot block
$84:EFCF             dw EE8E,EE0D ; Reserve tank, shot block
}


;;; $EFD3: Free space ;;;
{
$84:EFD3             fillto $858000, $FF
}
