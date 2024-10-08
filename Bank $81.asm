;;; $8000: Save to SRAM ;;;
{
;; Parameter:
;;     A: SRAM slot (0, 1 or 2)

; Almost returns carry clear

$81:8000 08          PHP
$81:8001 C2 30       REP #$30
$81:8003 8B          PHB
$81:8004 DA          PHX
$81:8005 5A          PHY
$81:8006 F4 00 7E    PEA $7E00              ;\
$81:8009 AB          PLB                    ;} DB = $7E
$81:800A AB          PLB                    ;/
$81:800B 64 14       STZ $14    [$7E:0014]  ; $14 = 0 (checksum)
$81:800D 29 03 00    AND #$0003             ;\
$81:8010 0A          ASL A                  ;} $12 = ([A] & 3) * 2
$81:8011 85 12       STA $12    [$7E:0012]  ;/
$81:8013 A0 5E 00    LDY #$005E             ;\
                                            ;|
$81:8016 B9 A2 09    LDA $09A2,y[$7E:0A00]  ;|
$81:8019 99 C0 D7    STA $D7C0,y[$7E:D81E]  ;} $D7C0..D81F = [$09A2..0A01]
$81:801C 88          DEY                    ;|
$81:801D 88          DEY                    ;|
$81:801E 10 F6       BPL $F6    [$8016]     ;/
$81:8020 A2 00 00    LDX #$0000             ; >_<
$81:8023 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$81:8026 EB          XBA                    ;|
$81:8027 AA          TAX                    ;|
$81:8028 A0 00 00    LDY #$0000             ;|
                                            ;|
$81:802B B9 F7 07    LDA $07F7,y[$7E:07F7]  ;|
$81:802E 9D 52 CD    STA $CD52,x[$7E:D352]  ;} Copy 100h bytes from $07F7 to $CD52 + [area index] * 100h
$81:8031 C8          INY                    ;|
$81:8032 C8          INY                    ;|
$81:8033 E8          INX                    ;|
$81:8034 E8          INX                    ;|
$81:8035 C0 00 01    CPY #$0100             ;|
$81:8038 30 F1       BMI $F1    [$802B]     ;/
$81:803A 20 4B 83    JSR $834B  [$81:834B]  ; Save map
$81:803D AD 8B 07    LDA $078B  [$7E:078B]  ;\
$81:8040 8D 16 D9    STA $D916  [$7E:D916]  ;} SRAM save station index = [save station index]
$81:8043 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$81:8046 8D 18 D9    STA $D918  [$7E:D918]  ;} SRAM area index = [area index]
$81:8049 A6 12       LDX $12    [$7E:0012]  ;\
$81:804B BF 2B 81 81 LDA $81812B,x[$81:812B];} X = [$81:812B + [$12]] (SRAM offset for save slot)
$81:804F AA          TAX                    ;/
$81:8050 A0 C0 D7    LDY #$D7C0             ; Y = $D7C0

; LOOP
$81:8053 B9 00 00    LDA $0000,y[$7E:D7C0]  ;\
$81:8056 9F 00 00 70 STA $700000,x[$70:0010];} $70:0000 + [X] = [[Y]]
$81:805A 18          CLC                    ;\
$81:805B 65 14       ADC $14    [$7E:0014]  ;} $14 += [[Y]]
$81:805D 85 14       STA $14    [$7E:0014]  ;/
$81:805F E8          INX                    ;\
$81:8060 E8          INX                    ;} X += 2
$81:8061 C8          INY                    ;\
$81:8062 C8          INY                    ;} Y += 2
$81:8063 C0 1C DE    CPY #$DE1C             ;\
$81:8066 D0 EB       BNE $EB    [$8053]     ;} If [Y] != $DE1C: go to LOOP
$81:8068 A6 12       LDX $12    [$7E:0012]  ;\
$81:806A A5 14       LDA $14    [$7E:0014]  ;|
$81:806C 9F 00 00 70 STA $700000,x[$70:0000];} $70:0000 + [$12] = $70:1FF0 + [$12] = [$14] (checksums)
$81:8070 9F F0 1F 70 STA $701FF0,x[$70:1FF0];/
$81:8074 49 FF FF    EOR #$FFFF             ;\
$81:8077 9F 08 00 70 STA $700008,x[$70:0008];} $70:0008 + [$12] = $70:1FF8 + [$12] = ~[$14] (checksum complements)
$81:807B 9F F8 1F 70 STA $701FF8,x[$70:1FF8];/
$81:807F 7A          PLY
$81:8080 FA          PLX
$81:8081 18          CLC                    ; >_<
$81:8082 AB          PLB
$81:8083 28          PLP
$81:8084 6B          RTL
}


;;; $8085: Load from SRAM ;;;
{
;; Parameter:
;;     A: SRAM slot (0, 1 or 2)
;; Returns:
;;     Carry: Set if SRAM is corrupt
$81:8085 C2 30       REP #$30
$81:8087 8B          PHB
$81:8088 DA          PHX
$81:8089 5A          PHY
$81:808A F4 00 7E    PEA $7E00              ;\
$81:808D AB          PLB                    ;} DB = $7E
$81:808E AB          PLB                    ;/
$81:808F 64 14       STZ $14    [$7E:0014]  ; $14 = 0 (checksum)
$81:8091 29 03 00    AND #$0003             ;\
$81:8094 0A          ASL A                  ;} $12 = ([A] & 3) * 2
$81:8095 85 12       STA $12    [$7E:0012]  ;/
$81:8097 AA          TAX                    ;\
$81:8098 BF 2B 81 81 LDA $81812B,x[$81:812B];} X = [$81:812B + [$12]] (SRAM offset)
$81:809C AA          TAX                    ;/
$81:809D A0 C0 D7    LDY #$D7C0             ; Y = $D7C0 (save data)

; LOOP
$81:80A0 BF 00 00 70 LDA $700000,x[$70:0010];\
$81:80A4 99 00 00    STA $0000,y[$7E:D7C0]  ;} [Y] = [$70:0000 + [X]]
$81:80A7 18          CLC                    ;\
$81:80A8 65 14       ADC $14    [$7E:0014]  ;} $14 += [Y]
$81:80AA 85 14       STA $14    [$7E:0014]  ;/
$81:80AC E8          INX                    ;\
$81:80AD E8          INX                    ;} X += 2
$81:80AE C8          INY                    ;\
$81:80AF C8          INY                    ;} Y += 2
$81:80B0 C0 1C DE    CPY #$DE1C             ;\
$81:80B3 D0 EB       BNE $EB    [$80A0]     ;} If [Y] != $DE1C: go to LOOP
$81:80B5 A6 12       LDX $12    [$7E:0012]  ;\
$81:80B7 A5 14       LDA $14    [$7E:0014]  ;|
$81:80B9 DF 00 00 70 CMP $700000,x[$70:0000];} If [$14] != [$70:0000 + [$12]]: go to BRANCH_DOUBLE_CHECK
$81:80BD D0 0B       BNE $0B    [$80CA]     ;/
$81:80BF 49 FF FF    EOR #$FFFF             ;\
$81:80C2 DF 08 00 70 CMP $700008,x[$70:0008];} If ~[$14] != [$70:0008 + [$12]]: go to BRANCH_DOUBLE_CHECK
$81:80C6 D0 02       BNE $02    [$80CA]     ;/
$81:80C8 80 11       BRA $11    [$80DB]     ; Go to BRANCH_SUCCESS

; BRANCH_DOUBLE_CHECK
$81:80CA A5 14       LDA $14    [$7E:0014]  ;\
$81:80CC DF F0 1F 70 CMP $701FF0,x[$70:1FF2];} If [$14] != [$70:1FF0 + [$12]]: go to BRANCH_CORRUPT
$81:80D0 D0 2A       BNE $2A    [$80FC]     ;/
$81:80D2 49 FF FF    EOR #$FFFF             ;\
$81:80D5 DF F8 1F 70 CMP $701FF8,x[$70:1FF8];} If ~[$14] != [$70:1FF8 + [$12]]: go to BRANCH_CORRUPT
$81:80D9 D0 21       BNE $21    [$80FC]     ;/

; BRANCH_SUCCESS
$81:80DB A0 5E 00    LDY #$005E             ;\
                                            ;|
$81:80DE B9 C0 D7    LDA $D7C0,y[$7E:D81E]  ;|
$81:80E1 99 A2 09    STA $09A2,y[$7E:0A00]  ;} $09A2..0A01 = [$D7C0..D81F] (Samus data and game options)
$81:80E4 88          DEY                    ;|
$81:80E5 88          DEY                    ;|
$81:80E6 10 F6       BPL $F6    [$80DE]     ;/
$81:80E8 20 E4 82    JSR $82E4  [$81:82E4]  ; Load map
$81:80EB AD 16 D9    LDA $D916  [$7E:D916]  ;\
$81:80EE 8D 8B 07    STA $078B  [$7E:078B]  ;} Load station index = [SRAM save station index]
$81:80F1 AD 18 D9    LDA $D918  [$7E:D918]  ;\
$81:80F4 8D 9F 07    STA $079F  [$7E:079F]  ;} Area index = [SRAM area index]
$81:80F7 7A          PLY
$81:80F8 FA          PLX
$81:80F9 18          CLC                    ; Return carry clear
$81:80FA AB          PLB
$81:80FB 6B          RTL                    ; Return

; BRANCH_CORRUPT
$81:80FC 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$81:80FE A6 12       LDX $12    [$7E:0012]  ;\
$81:8100 BF 2B 81 81 LDA $81812B,x[$81:812D];} X = [$81:812B + [$12]] (SRAM offset)
$81:8104 AA          TAX                    ;/
$81:8105 A0 C0 D7    LDY #$D7C0             ;\
$81:8108 A9 00 00    LDA #$0000             ;|
                                            ;|
$81:810B 9F 00 00 70 STA $700000,x[$70:066C];|
$81:810F 18          CLC                    ;|
$81:8110 65 14       ADC $14    [$7E:0014]  ;|
$81:8112 85 14       STA $14    [$7E:0014]  ;} Clear 65Ch bytes at $70:0000 + [X]
$81:8114 E8          INX                    ;|
$81:8115 E8          INX                    ;|
$81:8116 C8          INY                    ;|
$81:8117 C8          INY                    ;|
$81:8118 C0 1C DE    CPY #$DE1C             ;|
$81:811B D0 EE       BNE $EE    [$810B]     ;/
$81:811D A9 00 00    LDA #$0000             ;\
$81:8120 8D 8B 07    STA $078B  [$7E:078B]  ;} Load station index = 0
$81:8123 8D 9F 07    STA $079F  [$7E:079F]  ; Region = Crateria
$81:8126 7A          PLY
$81:8127 FA          PLX
$81:8128 38          SEC                    ; Return carry set
$81:8129 AB          PLB
$81:812A 6B          RTL
}


;;; $812B: SRAM offsets for each save slot ;;;
{
$81:812B             dw 0010, 066C, 0CC8
}


;;; $8131: SRAM map data ;;;
{
; Note that map room indices of 80h+ are specifying the right half of the map (7Fh- are specifying the left half)

; Size of each area map
$81:8131             db 4A, 48, 4C, 12, 42, 15, 08

; Offset for each area map
$81:8138             dw 0000, 004A, 0092, 00DE, 00F0, 0132, 0147

; Crateria map rooms
{
$81:8146             db          07,
                                 0B,
                           0D,0E,0F,
                           11,   13,
                           15,16,17,
                           19,1A,
                           1D,1E,1F,
                           21,22,
                        24,25,26,
                        28,   2A,2B,
                        2C,   2E,2F,
                        30,   32,33,
                              36,37,
                              3A,3B,
                              3E,3F,
                              42,43,
                              46,47,
                              4A,
                              4E,
                              52,
                              56,
                                    84,85,
                                    88,89,
                                    8C,8D,
                                    90,91,
                                    94,95,96,97,
                                    98,99,9A,9B,
                                    9C,      9F,
                                    A0,      A3,
                                    A4,   A6,A7,
                                    A8,   AA,AB,
                                    AC,   AE,
                                          B2,
                                          B6,
                                          BA,
                        00,00,00,00,00,00
}

; Brinstar map rooms
{
$81:8196             db    05,
                           09,0A,0B,
                           0D,0E,0F,
                           11,12,13,
                        14,15,16,17,
                           19,1A,1B,
                        1C,1D,1E,1F,
                        20,21,22,23,
                           25,26,27,
                           29,2A,2B,
                        2C,2D,2E,2F,
                        30,31,32,33,
                           35,36,37,
                           39,3A,3B,
                              42,43,
                                 47,
                                    90,
                                    94,
                                    98,
                                    9C,
                                    A0,
                                    A4,
                                    A8,
                                    AC,
                                    B0,
                                    B4,
                                    B8,
                                    BC,
                                    C0,
                                    C4,
                                    C8,
                                    CC,CD,CE,CF,
                                       D1,D2,D3,
                                       D5,D9,
                        00,00,00,00,00,00,00,00
}

; Norfair map rooms
{
$81:81E6             db    05,
                        08,09,   0B,
                        0C,0D,0E,0F,
                        10,11,12,13,
                        14,15,16,17,
                        18,19,1A,1B,
                        1C,1D,1E,1F,
                        20,21,22,23,
                        24,25,26,27,
                           29,2A,2B,
                           2D,2E,2F,
                           31,32,33,
                        34,35,36,37,
                        38,39,3A,3B,
                        3C,3D,3E,3F,
                        40,41,42,
                        44,45,46,47,
                        48,49,4A,
                                    8C,


                                    98,
                                    9C,
                                    A0,
                                    A4,
                                    A8,
                                    AC,
                                    B0,
                                    B4,
                                    B8,
                                    BC,
                                    C0,
                                    C4,
                        00,00,00,00
}

; Wrecked Ship map rooms
{
$81:8236             db    2D,2E,
                           31,32,
                           35,36,
                           39,3A,
                           3D,3E,
                              42,
                           45,46,
                           49,4A,
                              4E,
                           51,52,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00
}

; Maridia map rooms
{
$81:8256             db          07,
                                 0B,
                              0E,0F,
                              12,13,
                           15,16,17,
                           19,1A,1B,
                           1D,1E,1F,
                           21,22,23,
                           25,26,27,
                           29,2A,2B,
                           2D,2E,2F,
                           31,32,33,
                           35,36,
                           39,3A,3B,
                           3D,3E,3F,
                           41,42,43,
                           45,46,47,
                           49,4A,
                           4D,
                           51,
                                    84,
                                    88,
                                    8C,
                                    90,
                                    94,
                                    98,
                                    9C,9D,
                                    A0,A1,
                                    A4,A5,
                                    A8,A9,
                                    AC,AD,
                                    C0,
                                    C4,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00
}

; Tourian map rooms
{
$81:82A6             db       26,
                              2A,
                              2E,
                              32,
                           35,36,
                           39,3A,
                              3E,
                           41,42,
                           45,46,
                              4A,
                           4D,4E,
                           51,52,
                           55,56,
                              5A,
                        00,00,00,00,00,00,00,00,00,00,00
}

; Ceres map rooms
{
$81:82C6             db    2D,
                           31,
                           35,
                           39,
                           3D,
                           41,
                           45,46,
                        00,00,00,00,00,00,00,00
}


; Pointer to each area's map rooms
$81:82D6             dw 8146, 8196, 81E6, 8236, 8256, 82A6, 82C6
}


;;; $82E4: Load map ;;;
{
; Doesn't load Ceres map, but does clear it
$81:82E4 8B          PHB
$81:82E5 08          PHP
$81:82E6 4B          PHK                    ;\
$81:82E7 AB          PLB                    ;} DB = $81
$81:82E8 C2 30       REP #$30
$81:82EA A2 00 07    LDX #$0700             ;\
$81:82ED A9 00 00    LDA #$0000             ;|
                                            ;|
$81:82F0 9F 52 CD 7E STA $7ECD52,x[$7E:D452];} $7E:CD52..D453 = 0 (map tiles explored, not including debug area, although initial index 700h is off-by-2)
$81:82F4 CA          DEX                    ;|
$81:82F5 CA          DEX                    ;|
$81:82F6 10 F8       BPL $F8    [$82F0]     ;/
$81:82F8 64 16       STZ $16    [$7E:0016]  ; $16 = 0 (area index)

; LOOP_AREA
$81:82FA A5 16       LDA $16    [$7E:0016]  ;\
$81:82FC EB          XBA                    ;} $14 = (area index) * 100h (area map base offset)
$81:82FD 85 14       STA $14    [$7E:0014]  ;/
$81:82FF A6 16       LDX $16    [$7E:0016]  ;\
$81:8301 BD 31 81    LDA $8131,x[$81:8131]  ;|
$81:8304 29 FF 00    AND #$00FF             ;} $12 = [$8131 + (area index)] (area map size)
$81:8307 85 12       STA $12    [$7E:0012]  ;/
$81:8309 A5 16       LDA $16    [$7E:0016]  ;\
$81:830B 0A          ASL A                  ;|
$81:830C AA          TAX                    ;|
$81:830D BD D6 82    LDA $82D6,x[$81:82D6]  ;} $00 = $81:0000 + [$82D6 + (area index) * 2] (area room list pointer)
$81:8310 85 00       STA $00    [$7E:0000]  ;|
$81:8312 A9 81 00    LDA #$0081             ;|
$81:8315 85 02       STA $02    [$7E:0002]  ;/
$81:8317 BD 38 81    LDA $8138,x[$81:8138]  ;\
$81:831A AA          TAX                    ;} X = [$8138 + (area index) * 2] (saved area map offset)
$81:831B A9 52 CD    LDA #$CD52             ;\
$81:831E 85 03       STA $03    [$7E:0003]  ;|
$81:8320 A9 7E 00    LDA #$007E             ;} $03 = $7E:CD52 (explored map tiles base address)
$81:8323 85 05       STA $05    [$7E:0005]  ;/

; LOOP_ROOM
$81:8325 B2 00       LDA ($00)  [$81:8146]  ;\
$81:8327 29 FF 00    AND #$00FF             ;|
$81:832A 18          CLC                    ;} Y = [$14] + [[$00]] (area map room offset)
$81:832B 65 14       ADC $14    [$7E:0014]  ;|
$81:832D A8          TAY                    ;/
$81:832E E2 20       SEP #$20               ;\
$81:8330 BF 1C D9 7E LDA $7ED91C,x[$7E:D91C];|
$81:8334 97 03       STA [$03],y[$7E:CD59]  ;} $7E:CD52 + [Y] = [$7E:D91C + [X]]
$81:8336 C2 20       REP #$20               ;/
$81:8338 E6 00       INC $00    [$7E:0000]  ; Increment $00 (area map rooms address)
$81:833A E8          INX                    ; Increment X (saved map room offset)
$81:833B C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$81:833D D0 E6       BNE $E6    [$8325]     ; If [$12] != 0: go to LOOP_ROOM
$81:833F E6 16       INC $16    [$7E:0016]  ; Increment (area index)
$81:8341 A5 16       LDA $16    [$7E:0016]  ;\
$81:8343 C9 06 00    CMP #$0006             ;} If (area index) < Ceres: go to LOOP_AREA
$81:8346 30 B2       BMI $B2    [$82FA]     ;/
$81:8348 28          PLP
$81:8349 AB          PLB
$81:834A 60          RTS
}


;;; $834B: Save map ;;;
{
; Doesn't save Ceres
$81:834B 8B          PHB
$81:834C 08          PHP
$81:834D 4B          PHK                    ;\
$81:834E AB          PLB                    ;} DB = $81
$81:834F C2 30       REP #$30
$81:8351 64 1A       STZ $1A    [$7E:001A]  ; $1A = 0 (area index)

; LOOP_AREAS
$81:8353 A6 1A       LDX $1A    [$7E:001A]  ;\
$81:8355 BD 31 81    LDA $8131,x[$81:8131]  ;|
$81:8358 29 FF 00    AND #$00FF             ;} $16 = [$8131 + (area index)] (area map size)
$81:835B 85 16       STA $16    [$7E:0016]  ;/
$81:835D A5 1A       LDA $1A    [$7E:001A]  ;\
$81:835F 0A          ASL A                  ;|
$81:8360 AA          TAX                    ;} $00 = [$82D6 + (area index) * 2] (area room list pointer)
$81:8361 BD D6 82    LDA $82D6,x[$81:82D6]  ;|
$81:8364 85 00       STA $00    [$7E:0000]  ;/
$81:8366 BD 38 81    LDA $8138,x[$81:8138]  ;\
$81:8369 AA          TAX                    ;} X = [$8138 + (area index) * 2] (saved area map offset)
$81:836A A5 1A       LDA $1A    [$7E:001A]  ;\
$81:836C EB          XBA                    ;} $18 = (area index) * 100h (area map base offset)
$81:836D 85 18       STA $18    [$7E:0018]  ;/
$81:836F A9 52 CD    LDA #$CD52             ;\
$81:8372 85 03       STA $03    [$7E:0003]  ;|
$81:8374 A9 7E 00    LDA #$007E             ;} $03 = $7E:CD52 (explored map tiles base address)
$81:8377 85 05       STA $05    [$7E:0005]  ;/

; LOOP_ROOMS
$81:8379 B2 00       LDA ($00)  [$81:8146]  ;\
$81:837B 29 FF 00    AND #$00FF             ;|
$81:837E 18          CLC                    ;} Y = [$18] + [[$00]] (area map room offset)
$81:837F 65 18       ADC $18    [$7E:0018]  ;|
$81:8381 A8          TAY                    ;/
$81:8382 E2 20       SEP #$20               ;\
$81:8384 B7 03       LDA [$03],y[$7E:CD59]  ;|
$81:8386 9F 1C D9 7E STA $7ED91C,x[$7E:D91C];} $7E:D91C + [X] = [$7E:CD52 + [Y]]
$81:838A C2 20       REP #$20               ;/
$81:838C E6 00       INC $00    [$7E:0000]  ; Increment $00 (area map rooms address)
$81:838E E8          INX                    ; Increment X (saved map room offset)
$81:838F C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$81:8391 D0 E6       BNE $E6    [$8379]     ; If [$16] != 0: go to LOOP_ROOMS
$81:8393 E6 1A       INC $1A    [$7E:001A]  ; Increment (area index)
$81:8395 A5 1A       LDA $1A    [$7E:001A]  ;\
$81:8397 C9 06 00    CMP #$0006             ;} If (area index) < Ceres: go to LOOP_AREAS
$81:839A 30 B7       BMI $B7    [$8353]     ;/
$81:839C 28          PLP
$81:839D AB          PLB
$81:839E 60          RTS
}


;;; $839F..8CF3: Spritemap processing ;;;
{
;;; $839F: Map of OAM index to high X position bit and size bit ;;;
{
;                           ______ High X position bit
;                          |     _ Size bit
;                          |    |
$81:839F             dw 0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000,
                        0001,0002, 0004,0008, 0010,0020, 0040,0080, 0100,0200, 0400,0800, 1000,2000, 4000,8000
}


;;; $859F: Map of OAM index to high OAM address and corresponding bitmask ;;;
{
$81:859F             dw 0570,0003, 0570,000C, 0570,0030, 0570,00C0, 0570,0300, 0570,0C00, 0570,3000, 0570,C000,
                        0572,0003, 0572,000C, 0572,0030, 0572,00C0, 0572,0300, 0572,0C00, 0572,3000, 0572,C000,
                        0574,0003, 0574,000C, 0574,0030, 0574,00C0, 0574,0300, 0574,0C00, 0574,3000, 0574,C000,
                        0576,0003, 0576,000C, 0576,0030, 0576,00C0, 0576,0300, 0576,0C00, 0576,3000, 0576,C000,
                        0578,0003, 0578,000C, 0578,0030, 0578,00C0, 0578,0300, 0578,0C00, 0578,3000, 0578,C000,
                        057A,0003, 057A,000C, 057A,0030, 057A,00C0, 057A,0300, 057A,0C00, 057A,3000, 057A,C000,
                        057C,0003, 057C,000C, 057C,0030, 057C,00C0, 057C,0300, 057C,0C00, 057C,3000, 057C,C000,
                        057E,0003, 057E,000C, 057E,0030, 057E,00C0, 057E,0300, 057E,0C00, 057E,3000, 057E,C000,
                        0580,0003, 0580,000C, 0580,0030, 0580,00C0, 0580,0300, 0580,0C00, 0580,3000, 0580,C000,
                        0582,0003, 0582,000C, 0582,0030, 0582,00C0, 0582,0300, 0582,0C00, 0582,3000, 0582,C000,
                        0584,0003, 0584,000C, 0584,0030, 0584,00C0, 0584,0300, 0584,0C00, 0584,3000, 0584,C000,
                        0586,0003, 0586,000C, 0586,0030, 0586,00C0, 0586,0300, 0586,0C00, 0586,3000, 0586,C000,
                        0588,0003, 0588,000C, 0588,0030, 0588,00C0, 0588,0300, 0588,0C00, 0588,3000, 0588,C000,
                        058A,0003, 058A,000C, 058A,0030, 058A,00C0, 058A,0300, 058A,0C00, 058A,3000, 058A,C000,
                        058C,0003, 058C,000C, 058C,0030, 058C,00C0, 058C,0300, 058C,0C00, 058C,3000, 058C,C000,
                        058E,0003, 058E,000C, 058E,0030, 058E,00C0, 058E,0300, 058E,0C00, 058E,3000, 058E,C000
}


;;; $879F: Add spritemap to OAM ;;;
{
;; Parameters:
;;     DB:Y: Address of spritemap
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre
;;     $16: Palette bits of sprite (palette * 200h)

; Spritemap format is roughly:
;     nnnn         ; Number of entries (2 bytes)
;     xxxx yy attt ; Entry 0 (5 bytes)
;     ...          ; Entry 1...
; Where:
;     n = number of entries
;     x = X offset of sprite from centre
;     y = Y offset of sprite from centre
;     a = attributes
;     t = tile number

; More specifically, a spritemap entry is:
;     s000000xxxxxxxxx yyyyyyyy YXpp000ttttttttt
; Where:
;     s = size bit
;     x = X offset of sprite from centre
;     y = Y offset of sprite from centre
;     Y = Y flip
;     X = X flip
;     p = priority (relative to background)
;     t = tile number

; Called by:
;    $80:9FB3: Draw timer spritemap
;    $82:8CA1: Draw options menu spritemaps
;    $8B:936B: Draw Nintendo logo
;    $8B:9746: Draw cinematic sprite objects
;    $8B:9799: Draw ending and credits sprites
;    $A6:A2F2: Ceres Ridley's enemy graphics drawn hook
$81:879F DA          PHX
$81:87A0 B9 00 00    LDA $0000,y[$8C:80BB]  ;\
$81:87A3 D0 05       BNE $05    [$87AA]     ;|
$81:87A5 FA          PLX                    ;|
$81:87A6 6B          RTL                    ;} If [[Y]] = 0: return
                                            ;|
$81:87A7 4C 4E 88    JMP $884E              ;/

$81:87AA 85 18       STA $18    [$7E:0018]  ; $18 = [[Y]] (size)
$81:87AC C8          INY                    ;\
$81:87AD C8          INY                    ;} Y += 2
$81:87AE AD 90 05    LDA $0590  [$7E:0590]  ;\
$81:87B1 89 00 FE    BIT #$FE00             ;} If [OAM stack pointer] >= 200h: return
$81:87B4 D0 F1       BNE $F1    [$87A7]     ;/
$81:87B6 AA          TAX                    ; X = [OAM stack pointer]
$81:87B7 18          CLC

; LOOP
$81:87B8 B9 00 00    LDA $0000,y[$8C:80BD]  ;\
$81:87BB 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:87BD 9D 70 03    STA $0370,x[$7E:0370]  ;/
$81:87C0 29 00 01    AND #$0100             ;\
$81:87C3 F0 26       BEQ $26    [$87EB]     ;} If [OAM entry X position] % 200h < 100h: BRANCH_X_HIGH_CLEAR
$81:87C5 B9 00 00    LDA $0000,y[$82:CBD9]  ;\
$81:87C8 10 11       BPL $11    [$87DB]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:87CA BF 9F 85 81 LDA $81859F,x[$81:859F];\
$81:87CE 85 1C       STA $1C    [$7E:001C]  ;|
$81:87D0 B2 1C       LDA ($1C)  [$7E:0570]  ;} Set OAM entry high X position bit and size bit
$81:87D2 1F A1 85 81 ORA $8185A1,x[$81:85A1];|
$81:87D6 92 1C       STA ($1C)  [$7E:0570]  ;/
$81:87D8 4C FE 87    JMP $87FE  [$81:87FE]  ; Go to BRANCH_MERGE

$81:87DB BF 9F 85 81 LDA $81859F,x[$81:859F];\
$81:87DF 85 1C       STA $1C    [$7E:001C]  ;|
$81:87E1 B2 1C       LDA ($1C)  [$7E:0570]  ;} Set OAM entry high X position bit
$81:87E3 1F 9F 83 81 ORA $81839F,x[$81:839F];|
$81:87E7 92 1C       STA ($1C)  [$7E:0570]  ;/
$81:87E9 80 13       BRA $13    [$87FE]     ; Go to BRANCH_MERGE

; BRANCH_X_HIGH_CLEAR
$81:87EB B9 00 00    LDA $0000,y[$8C:80BD]  ;\
$81:87EE 10 0E       BPL $0E    [$87FE]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:87F0 BF 9F 85 81 LDA $81859F,x[$81:859F];\
$81:87F4 85 1C       STA $1C    [$7E:001C]  ;|
$81:87F6 B2 1C       LDA ($1C)  [$7E:0570]  ;} Set OAM entry size bit
$81:87F8 1F A1 83 81 ORA $8183A1,x[$81:83A1];|
$81:87FC 92 1C       STA ($1C)  [$7E:0570]  ;/

; BRANCH_MERGE
$81:87FE E2 20       SEP #$20
$81:8800 B9 02 00    LDA $0002,y[$8C:80BF]  ;\
$81:8803 18          CLC                    ;} If [[Y] + 2] (Y offset) >= 0:
$81:8804 30 0A       BMI $0A    [$8810]     ;/
$81:8806 65 12       ADC $12    [$7E:0012]  ;\
$81:8808 B0 14       BCS $14    [$881E]     ;|
$81:880A C9 E0       CMP #$E0               ;} If [$12] + [[Y] + 2] (Y position) < E0h: go to BRANCH_ON_SCREEN
$81:880C 90 15       BCC $15    [$8823]     ;|
$81:880E 80 0E       BRA $0E    [$881E]     ;/

$81:8810 65 12       ADC $12    [$7E:0012]  ;\ Else ((Y offset) < 0):
$81:8812 B0 06       BCS $06    [$881A]     ;|
$81:8814 C9 E0       CMP #$E0               ;|
$81:8816 B0 0B       BCS $0B    [$8823]     ;|
$81:8818 80 04       BRA $04    [$881E]     ;} If -20h <= (Y position) < E0h: go to BRANCH_ON_SCREEN
                                            ;|
$81:881A C9 E0       CMP #$E0               ;|
$81:881C 90 05       BCC $05    [$8823]     ;/

$81:881E 20 07 89    JSR $8907  [$81:8907]  ; OAM entry X position = 180h
$81:8821 A9 E0       LDA #$E0               ; Use E0h as Y position

; BRANCH_ON_SCREEN
$81:8823 9D 71 03    STA $0371,x[$7E:0371]  ; OAM entry Y position = (Y position)
$81:8826 C2 21       REP #$21
$81:8828 B9 03 00    LDA $0003,y[$8C:80C0]  ;\
$81:882B 29 FF F1    AND #$F1FF             ;|
$81:882E 05 16       ORA $16    [$7E:0016]  ;} OAM entry tile number and attributes = [[Y] + 3] & F1FFh | [$16] (palette)
$81:8830 9D 72 03    STA $0372,x[$7E:0372]  ;/
$81:8833 8A          TXA                    ;\
$81:8834 69 04 00    ADC #$0004             ;|
$81:8837 89 00 FE    BIT #$FE00             ;} If [X] + 4 >= 200h: OAM stack pointer = [X] + 4, return
$81:883A D0 12       BNE $12    [$884E]     ;/
$81:883C AA          TAX                    ; X += 4 (next OAM entry)
$81:883D 98          TYA                    ;\
$81:883E 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:8841 A8          TAY                    ;/
$81:8842 C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:8844 F0 03       BEQ $03    [$8849]     ; If [$18] != 0:
$81:8846 4C B8 87    JMP $87B8  [$81:87B8]  ; Go to LOOP

$81:8849 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$81:884C FA          PLX
$81:884D 6B          RTL                    ; Return

$81:884E 8D 90 05    STA $0590  [$7E:0590]  ; OAM stack pointer = [A]
$81:8851 FA          PLX
$81:8852 6B          RTL
}


;;; $8853: Add spritemap to OAM off-screen ;;;
{
;; Parameters:
;;     DB:YYYY = address of spritemap
;;     $12     = Y position of spritemap centre
;;     $14     = X position of spritemap centre
;;     $16     = palette bits of sprite (palette * 200h)

; Called by:
;    $8B:9746: Draw title sequence sprites (including scrolled text)
;    $8B:9799: Draw ending and credits sprites

; See $879F for spritemap format
$81:8853 DA          PHX
$81:8854 B9 00 00    LDA $0000,y[$8C:975E]  ;\
$81:8857 D0 05       BNE $05    [$885E]     ;|
$81:8859 FA          PLX                    ;|
$81:885A 6B          RTL                    ;} If [[Y]] = 0: return
                                            ;|
$81:885B 4C 02 89    JMP $8902  [$81:8902]  ;/

$81:885E 85 18       STA $18    [$7E:0018]  ; $18 = [[Y]] (size)
$81:8860 C8          INY                    ;\
$81:8861 C8          INY                    ;} Y += 2
$81:8862 AD 90 05    LDA $0590  [$7E:0590]  ;\
$81:8865 89 00 FE    BIT #$FE00             ;} If [OAM stack pointer] >= 200h: return
$81:8868 D0 F1       BNE $F1    [$885B]     ;/
$81:886A AA          TAX                    ; X = [OAM stack pointer]
$81:886B 18          CLC

; LOOP
$81:886C B9 00 00    LDA $0000,y[$8C:9760]  ;\
$81:886F 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:8871 9D 70 03    STA $0370,x[$7E:0438]  ;/
$81:8874 29 00 01    AND #$0100             ;\
$81:8877 F0 26       BEQ $26    [$889F]     ;} If [OAM entry X position] % 200h < 100h: BRANCH_X_HIGH_CLEAR
$81:8879 B9 00 00    LDA $0000,y[$8C:B8DF]  ;\
$81:887C 10 11       BPL $11    [$888F]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:887E BF 9F 85 81 LDA $81859F,x[$81:85AF];\
$81:8882 85 1C       STA $1C    [$7E:001C]  ;|
$81:8884 B2 1C       LDA ($1C)  [$7E:0570]  ;} Set OAM entry high X position bit and size bit
$81:8886 1F A1 85 81 ORA $8185A1,x[$81:85B1];|
$81:888A 92 1C       STA ($1C)  [$7E:0570]  ;/
$81:888C 4C B2 88    JMP $88B2  [$81:88B2]  ; Go to BRANCH_MERGE

$81:888F BF 9F 85 81 LDA $81859F,x[$81:869F];\
$81:8893 85 1C       STA $1C    [$7E:001C]  ;|
$81:8895 B2 1C       LDA ($1C)  [$7E:0580]  ;} Set OAM entry high X position bit
$81:8897 1F 9F 83 81 ORA $81839F,x[$81:849F];|
$81:889B 92 1C       STA ($1C)  [$7E:0580]  ;/
$81:889D 80 13       BRA $13    [$88B2]     ; Go to BRANCH_MERGE

; BRANCH_X_HIGH_CLEAR
$81:889F B9 00 00    LDA $0000,y[$8C:9760]  ;\
$81:88A2 10 0E       BPL $0E    [$88B2]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:88A4 BF 9F 85 81 LDA $81859F,x[$81:85DB];\
$81:88A8 85 1C       STA $1C    [$7E:001C]  ;|
$81:88AA B2 1C       LDA ($1C)  [$7E:0572]  ;} Set OAM entry size bit
$81:88AC 1F A1 83 81 ORA $8183A1,x[$81:83DD];|
$81:88B0 92 1C       STA ($1C)  [$7E:0572]  ;/

; BRANCH_MERGE
$81:88B2 E2 20       SEP #$20
$81:88B4 B9 02 00    LDA $0002,y[$8C:9762]  ;\
$81:88B7 18          CLC                    ;} If [[Y] + 2] (Y offset) >= 0:
$81:88B8 30 0A       BMI $0A    [$88C4]     ;/
$81:88BA 65 12       ADC $12    [$7E:0012]  ;\
$81:88BC B0 19       BCS $19    [$88D7]     ;|
$81:88BE C9 E0       CMP #$E0               ;} If [$12] + [[Y] + 2] (Y position) >= -20h: go to BRANCH_ON_SCREEN
$81:88C0 B0 15       BCS $15    [$88D7]     ;|
$81:88C2 80 0E       BRA $0E    [$88D2]     ;/

$81:88C4 65 12       ADC $12    [$7E:0012]  ;\ Else (Y offset < 0):
$81:88C6 B0 06       BCS $06    [$88CE]     ;|
$81:88C8 C9 E0       CMP #$E0               ;|
$81:88CA 90 0B       BCC $0B    [$88D7]     ;|
$81:88CC 80 04       BRA $04    [$88D2]     ;} If -20 <= (Y position) < E0h: go to BRANCH_ON_SCREEN
                                            ;|
$81:88CE C9 E0       CMP #$E0               ;|
$81:88D0 B0 05       BCS $05    [$88D7]     ;/

$81:88D2 20 07 89    JSR $8907  [$81:8907]  ; OAM entry X position = 180h
$81:88D5 A9 E0       LDA #$E0               ; Use E0h as Y position

; BRANCH_ON_SCREEN
$81:88D7 9D 71 03    STA $0371,x[$7E:0439]  ; OAM entry Y position = (Y position)
$81:88DA C2 21       REP #$21
$81:88DC B9 03 00    LDA $0003,y[$8C:9763]  ;\
$81:88DF 29 FF F1    AND #$F1FF             ;|
$81:88E2 05 16       ORA $16    [$7E:0016]  ;} OAM entry tile number and attributes = [[Y] + 3] & F1FFh | [$16] (palette)
$81:88E4 9D 72 03    STA $0372,x[$7E:043A]  ;/
$81:88E7 8A          TXA                    ;\
$81:88E8 69 04 00    ADC #$0004             ;|
$81:88EB 89 00 FE    BIT #$FE00             ;} If [X] + 4 >= 200h: OAM stack pointer = [X] + 4, return
$81:88EE D0 12       BNE $12    [$8902]     ;/
$81:88F0 AA          TAX                    ; X += 4 (next OAM entry)
$81:88F1 98          TYA                    ;\
$81:88F2 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:88F5 A8          TAY                    ;/
$81:88F6 C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:88F8 F0 03       BEQ $03    [$88FD]     ; If [$18] != 0:
$81:88FA 4C 6C 88    JMP $886C  [$81:886C]  ; Go to LOOP

$81:88FD 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$81:8900 FA          PLX
$81:8901 6B          RTL                    ; Return

$81:8902 8D 90 05    STA $0590  [$7E:0590]  ; OAM stack pointer = [A]
$81:8905 FA          PLX
$81:8906 6B          RTL
}


;;; $8907: OAM entry X position = 180h ;;;
{
$81:8907 A9 80       LDA #$80               ;\
$81:8909 9D 70 03    STA $0370,x[$7E:038C]  ;} $0370 + [X] = 80h
$81:890C C2 20       REP #$20
$81:890E BF 9F 85 81 LDA $81859F,x[$81:85BB];\
$81:8912 85 1C       STA $1C    [$7E:001C]  ;|
$81:8914 B2 1C       LDA ($1C)  [$7E:0570]  ;} [$81:859F + [X]] |= [$81:839F + [X]]
$81:8916 1F 9F 83 81 ORA $81839F,x[$81:83BB];|
$81:891A 92 1C       STA ($1C)  [$7E:0570]  ;/
$81:891C E2 20       SEP #$20
$81:891E 60          RTS
}


;;; $891F: Add spritemap from $82:C569 table to OAM ;;;
{
;; Parameters:
;;     A: Index into $82:C569 table
;;     X: X position of spritemap centre
;;     Y: Y position of spritemap centre
;;     $03: Palette bits of sprite (palette * 200h)

; See $879F for spritemap format
; Used for general menu sprites I think
$81:891F 8B          PHB
$81:8920 F4 00 82    PEA $8200              ;\
$81:8923 AB          PLB                    ;} DB = $82
$81:8924 AB          PLB                    ;/
$81:8925 84 12       STY $12    [$7E:0012]  ; $12 = [Y]
$81:8927 86 14       STX $14    [$7E:0014]  ; $14 = [X]
$81:8929 0A          ASL A                  ;\
$81:892A AA          TAX                    ;} Y = [$C569 + [A] * 2] (address of spritemap)
$81:892B BC 69 C5    LDY $C569,x[$82:C5C1]  ;/
$81:892E B9 00 00    LDA $0000,y[$82:CAE9]  ;\
$81:8931 F0 79       BEQ $79    [$89AC]     ;} If [[Y]] = 0: return
$81:8933 85 18       STA $18    [$7E:0018]  ; $18 = [[Y]] (size)
$81:8935 C8          INY                    ;\
$81:8936 C8          INY                    ;} Y += 2
$81:8937 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$81:893A 18          CLC

; LOOP
$81:893B B9 00 00    LDA $0000,y[$82:CAEB]  ;\
$81:893E 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:8940 9D 70 03    STA $0370,x[$7E:0370]  ;/
$81:8943 29 00 01    AND #$0100             ;\
$81:8946 F0 27       BEQ $27    [$896F]     ;} If [OAM entry X position] % 200h < 100h: BRANCH_X_HIGH_CLEAR
$81:8948 B9 00 00    LDA $0000,y[$82:C4F3]  ;\
$81:894B 10 11       BPL $11    [$895E]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:894D BF 9F 85 81 LDA $81859F,x          ;\
$81:8951 85 16       STA $16    [$7E:0016]  ;|
$81:8953 B2 16       LDA ($16)              ;} Set OAM entry high X position bit and size bit
$81:8955 1F A1 85 81 ORA $8185A1,x          ;|
$81:8959 92 16       STA ($16)              ;/
$81:895B 4C 82 89    JMP $8982  [$81:8982]  ; Go to BRANCH_MERGE

$81:895E BF 9F 85 81 LDA $81859F,x[$81:85BF];\
$81:8962 85 16       STA $16    [$7E:0016]  ;|
$81:8964 B2 16       LDA ($16)  [$7E:0572]  ;} Set OAM entry high X position bit
$81:8966 1F 9F 83 81 ORA $81839F,x[$81:83BF];|
$81:896A 92 16       STA ($16)  [$7E:0572]  ;/
$81:896C 4C 82 89    JMP $8982  [$81:8982]  ; Go to BRANCH_MERGE

; BRANCH_X_HIGH_CLEAR
$81:896F B9 00 00    LDA $0000,y[$82:CAEB]  ;\
$81:8972 10 0E       BPL $0E    [$8982]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:8974 BF 9F 85 81 LDA $81859F,x[$81:859F];\
$81:8978 85 16       STA $16    [$7E:0016]  ;|
$81:897A B2 16       LDA ($16)  [$7E:0570]  ;} Set OAM entry size bit
$81:897C 1F A1 83 81 ORA $8183A1,x[$81:83A1];|
$81:8980 92 16       STA ($16)  [$7E:0570]  ;/

; BRANCH_MERGE
$81:8982 B9 02 00    LDA $0002,y[$82:CAED]  ;\
$81:8985 18          CLC                    ;|
$81:8986 65 12       ADC $12    [$7E:0012]  ;} OAM entry Y position = [$12] + [[Y] + 2] (Y position)
$81:8988 9D 71 03    STA $0371,x[$7E:0371]  ;/
$81:898B B9 03 00    LDA $0003,y[$82:CAEE]  ;\
$81:898E 29 FF F1    AND #$F1FF             ;|
$81:8991 05 03       ORA $03    [$7E:0003]  ;} OAM entry tile number and attributes = [[Y] + 3] & F1FFh | [$03] (palette)
$81:8993 9D 72 03    STA $0372,x[$7E:0372]  ;/
$81:8996 98          TYA                    ;\
$81:8997 18          CLC                    ;|
$81:8998 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:899B A8          TAY                    ;/
$81:899C 8A          TXA                    ;\
$81:899D 18          CLC                    ;|
$81:899E 69 04 00    ADC #$0004             ;} X += 4 (next OAM entry)
$81:89A1 29 FF 01    AND #$01FF             ;|
$81:89A4 AA          TAX                    ;/
$81:89A5 C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:89A7 D0 92       BNE $92    [$893B]     ; If [$18] != 0: go to LOOP
$81:89A9 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]

$81:89AC AB          PLB
$81:89AD 6B          RTL
}


;;; $89AE: Add Samus spritemap to OAM ;;;
{
;; Parameters:
;;     A: Index into $92:808D table
;;     X: X position of spritemap centre
;;     Y: Y position of spritemap centre

; Actually uses the palette defined in the spritemap
; See $8A5F for spritemap format
; Also called for some atmospheric graphics:
;     186h..18Eh: Bubbles
;     18Fh..197h: Diving splash
$81:89AE 8B          PHB
$81:89AF F4 00 92    PEA $9200              ;\
$81:89B2 AB          PLB                    ;} DB = $92
$81:89B3 AB          PLB                    ;/
$81:89B4 84 12       STY $12    [$7E:0012]  ; $12 = [Y]
$81:89B6 86 14       STX $14    [$7E:0014]  ; $14 = [X]
$81:89B8 0A          ASL A                  ;\
$81:89B9 AA          TAX                    ;} Y = [$808D + [A] * 2] (address of spritemap)
$81:89BA BC 8D 80    LDY $808D,x[$92:83D3]  ;/
$81:89BD B9 00 00    LDA $0000,y[$92:A0B4]  ;\
$81:89C0 F0 73       BEQ $73    [$8A35]     ;} If [[Y]] = 0: return
$81:89C2 85 18       STA $18    [$7E:0018]  ; $18 = [[Y]] (size)
$81:89C4 C8          INY                    ;\
$81:89C5 C8          INY                    ;} Y += 2
$81:89C6 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$81:89C9 18          CLC

; LOOP
$81:89CA B9 00 00    LDA $0000,y[$92:A0B6]  ;\
$81:89CD 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:89CF 9D 70 03    STA $0370,x[$7E:0370]  ;/
$81:89D2 29 00 01    AND #$0100             ;\
$81:89D5 F0 27       BEQ $27    [$89FE]     ;} If [OAM entry X position] % 200h < 100h: BRANCH_X_HIGH_CLEAR
$81:89D7 B9 00 00    LDA $0000,y[$92:A0B6]  ;\
$81:89DA 10 11       BPL $11    [$89ED]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:89DC BF 9F 85 81 LDA $81859F,x[$81:85BF];\
$81:89E0 85 16       STA $16    [$7E:0016]  ;|
$81:89E2 B2 16       LDA ($16)  [$7E:0572]  ;} Set OAM entry high X position bit and size bit
$81:89E4 1F A1 85 81 ORA $8185A1,x[$81:85C1];|
$81:89E8 92 16       STA ($16)  [$7E:0572]  ;/
$81:89EA 4C 11 8A    JMP $8A11  [$81:8A11]  ; Go to BRANCH_MERGE
                                            
$81:89ED BF 9F 85 81 LDA $81859F,x[$81:85C7];\
$81:89F1 85 16       STA $16    [$7E:0016]  ;|
$81:89F3 B2 16       LDA ($16)  [$7E:0572]  ;} Set OAM entry high X position bit
$81:89F5 1F 9F 83 81 ORA $81839F,x[$81:83C7];|
$81:89F9 92 16       STA ($16)  [$7E:0572]  ;/
$81:89FB 4C 11 8A    JMP $8A11  [$81:8A11]  ; Go to BRANCH_MERGE
                                            
; BRANCH_X_HIGH_CLEAR                       
$81:89FE B9 00 00    LDA $0000,y[$92:A0B6]  ;\
$81:8A01 10 0E       BPL $0E    [$8A11]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:8A03 BF 9F 85 81 LDA $81859F,x[$81:859F];\
$81:8A07 85 16       STA $16    [$7E:0016]  ;|
$81:8A09 B2 16       LDA ($16)  [$7E:0570]  ;} Set OAM entry size bit
$81:8A0B 1F A1 83 81 ORA $8183A1,x[$81:83A1];|
$81:8A0F 92 16       STA ($16)  [$7E:0570]  ;/

; BRANCH_MERGE
$81:8A11 B9 02 00    LDA $0002,y[$92:A0B8]  ;\
$81:8A14 18          CLC                    ;|
$81:8A15 65 12       ADC $12    [$7E:0012]  ;} OAM entry Y position = [$12] + [[Y] + 2] (Y position)
$81:8A17 9D 71 03    STA $0371,x[$7E:0371]  ;/
$81:8A1A B9 03 00    LDA $0003,y[$92:A0B9]  ;\
$81:8A1D 9D 72 03    STA $0372,x[$7E:0372]  ;} OAM entry tile number and attributes = [[Y] + 3]
$81:8A20 98          TYA                    ;\
$81:8A21 18          CLC                    ;|
$81:8A22 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:8A25 A8          TAY                    ;/
$81:8A26 8A          TXA                    ;\
$81:8A27 69 04 00    ADC #$0004             ;|
$81:8A2A 29 FF 01    AND #$01FF             ;} X += 4 (next OAM entry)
$81:8A2D AA          TAX                    ;/
$81:8A2E C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:8A30 D0 98       BNE $98    [$89CA]     ; If [$18] != 0: go to LOOP
$81:8A32 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]

$81:8A35 AB          PLB
$81:8A36 6B          RTL
}


;;; $8A37: Add spritemap from $93:A1A1 table to OAM ;;;
{
;; Parameters:
;;     A: Index into $93:A1A1 table
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre

; Called by:
;    $90:BBE1: Draw flare animation component
;    $93:F5E2: Unused. Draw shinespark windup effect sprite
;    $9B:C036: Handle grapple beam flare

; Actually uses the palette defined in the spritemap
; See $8A5F for spritemap format
; Draws charge / grapple beam flare and charge sparks
$81:8A37 8B          PHB
$81:8A38 F4 00 93    PEA $9300              ;\
$81:8A3B AB          PLB                    ;} DB = $93
$81:8A3C AB          PLB                    ;/
$81:8A3D 0A          ASL A                  ;\
$81:8A3E AA          TAX                    ;} Y = [$A1A1 + [A] * 2]
$81:8A3F BC A1 A1    LDY $A1A1,x[$93:A1A1]  ;/
$81:8A42 B9 00 00    LDA $0000,y[$93:AB6C]  ;\
$81:8A45 85 18       STA $18    [$7E:0018]  ;} $18 = [[Y]] (size)
$81:8A47 C8          INY                    ;\
$81:8A48 C8          INY                    ;} Y += 2
$81:8A49 80 14       BRA $14    [$8A5F]     ; Go to $8A5F
}


;;; $8A4B: Add projectile spritemap to OAM ;;;
{
;; Parameters:
;;     X: Projectile index
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre

; Actually uses the palette defined in the spritemap
; See $8A5F for spritemap format
$81:8A4B 8B          PHB
$81:8A4C F4 00 93    PEA $9300              ;\
$81:8A4F AB          PLB                    ;} DB = $93
$81:8A50 AB          PLB                    ;/
$81:8A51 BC B8 0C    LDY $0CB8,x[$7E:0CB8]  ; Y = [projectile spritemap pointer]
$81:8A54 B9 00 00    LDA $0000,y[$93:AD61]  ;\
$81:8A57 D0 02       BNE $02    [$8A5B]     ;} If [[Y]] = 0:
$81:8A59 AB          PLB
$81:8A5A 6B          RTL                    ; Return

$81:8A5B 85 18       STA $18    [$7E:0018]  ; $18 = [[Y]] (size)
$81:8A5D C8          INY                    ;\
$81:8A5E C8          INY                    ;} Y += 2
}


;;; $8A5F: Add spritemap to OAM ;;;
{
;; Parameters:
;;     DB:Y: Address of first entry in spritemap
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre
;;     $18: Number of entries

; Spritemap format is roughly:
;     nnnn         ; Number of entries (2 bytes)
;     xxxx yy aatt ; Entry 0 (5 bytes)
;     ...          ; Entry 1...
; Where:
;     n = number of entries
;     x = X offset of sprite from centre
;     y = Y offset of sprite from centre
;     a = attributes
;     t = tile number

; More specifically, a spritemap entry is:
;     s000000xxxxxxxxx yyyyyyyy YXppPPPttttttttt
; Where:
;     s = size bit
;     x = X offset of sprite from centre
;     y = Y offset of sprite from centre
;     Y = Y flip
;     X = X flip
;     P = palette
;     p = priority (relative to background)
;     t = tile number

; Out of all of the spritemap loading routines, this one is the most sanely coded. No offscreen handling though (sprites wrap)
$81:8A5F AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$81:8A62 18          CLC

; LOOP
$81:8A63 B9 00 00    LDA $0000,y[$93:AD63]  ;\
$81:8A66 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:8A68 9D 70 03    STA $0370,x[$7E:0390]  ;/
$81:8A6B 29 00 01    AND #$0100             ;\
$81:8A6E F0 0E       BEQ $0E    [$8A7E]     ;} If [OAM entry X position] % 200h >= 100h:
$81:8A70 BF 9F 85 81 LDA $81859F,x[$81:8607];\
$81:8A74 85 16       STA $16    [$7E:0016]  ;|
$81:8A76 B2 16       LDA ($16)  [$7E:0576]  ;} Set OAM entry high X position bit
$81:8A78 1F 9F 83 81 ORA $81839F,x[$81:8407];|
$81:8A7C 92 16       STA ($16)  [$7E:0576]  ;/

$81:8A7E B9 00 00    LDA $0000,y[$93:AD63]  ;\
$81:8A81 10 0E       BPL $0E    [$8A91]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:8A83 BF 9F 85 81 LDA $81859F,x[$81:859F];\
$81:8A87 85 16       STA $16    [$7E:0016]  ;|
$81:8A89 B2 16       LDA ($16)  [$7E:0570]  ;} Set OAM entry size bit
$81:8A8B 1F A1 83 81 ORA $8183A1,x[$81:83A1];|
$81:8A8F 92 16       STA ($16)  [$7E:0570]  ;/

$81:8A91 B9 02 00    LDA $0002,y[$93:AD65]  ;\
$81:8A94 18          CLC                    ;|
$81:8A95 65 12       ADC $12    [$7E:0012]  ;} OAM entry Y position = [$12] + [[Y] + 2] (Y position)
$81:8A97 9D 71 03    STA $0371,x[$7E:0391]  ;/
$81:8A9A B9 03 00    LDA $0003,y[$93:AD66]  ;\
$81:8A9D 9D 72 03    STA $0372,x[$7E:0392]  ;} OAM entry tile number and attributes = [[Y] + 3]
$81:8AA0 98          TYA                    ;\
$81:8AA1 18          CLC                    ;|
$81:8AA2 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:8AA5 A8          TAY                    ;/
$81:8AA6 8A          TXA                    ;\
$81:8AA7 69 04 00    ADC #$0004             ;|
$81:8AAA 29 FF 01    AND #$01FF             ;} X += 4 (next OAM entry)
$81:8AAD AA          TAX                    ;/
$81:8AAE C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:8AB0 D0 B1       BNE $B1    [$8A63]     ; If [$18] != 0: go to LOOP
$81:8AB2 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$81:8AB5 AB          PLB
$81:8AB6 6B          RTL
}


;;; $8AB7: RTL ;;;
{
$81:8AB7 6B          RTL
}


;;; $8AB8: Add spritemap to OAM with base tile number ;;;
{
;; Parameters:
;;     DB:Y: Address of spritemap
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre
;;     $03: Palette bits of sprite (palette * 200h)
;;     $00: Base tile number

; Called by:
;    $A0:944A: Write enemy OAM (non multi-hitbox)
;    $B4:BD32: Draw sprite objects

; See $879F for spritemap format
$81:8AB8 5A          PHY
$81:8AB9 B9 00 00    LDA $0000,y[$A6:F921]  ; $18 = [[Y]] (number of entries)
$81:8ABC F0 61       BEQ $61    [$8B1F]     ; If [$18] = 0: return
$81:8ABE C8          INY                    ;\
$81:8ABF C8          INY                    ;} Y += 2
$81:8AC0 85 18       STA $18    [$7E:0018]
$81:8AC2 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$81:8AC5 18          CLC

; LOOP
$81:8AC6 B9 00 00    LDA $0000,y[$A6:F923]  ;\
$81:8AC9 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:8ACB 9D 70 03    STA $0370,x[$7E:0370]  ;/
$81:8ACE 29 00 01    AND #$0100             ;\
$81:8AD1 F0 0E       BEQ $0E    [$8AE1]     ;} If [OAM entry X position] % 200h >= 100h:
$81:8AD3 BF 9F 85 81 LDA $81859F,x[$81:85A7];\
$81:8AD7 85 16       STA $16    [$7E:0016]  ;|
$81:8AD9 B2 16       LDA ($16)  [$7E:0570]  ;} Set OAM entry high X position bit
$81:8ADB 1F 9F 83 81 ORA $81839F,x[$81:83A7];|
$81:8ADF 92 16       STA ($16)  [$7E:0570]  ;/
                                            
$81:8AE1 B9 00 00    LDA $0000,y[$A6:F923]  ;\
$81:8AE4 10 0E       BPL $0E    [$8AF4]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:8AE6 BF 9F 85 81 LDA $81859F,x[$81:859F];\
$81:8AEA 85 16       STA $16    [$7E:0016]  ;|
$81:8AEC B2 16       LDA ($16)  [$7E:0570]  ;} Set OAM entry size bit
$81:8AEE 1F A1 83 81 ORA $8183A1,x[$81:83A1];|
$81:8AF2 92 16       STA ($16)  [$7E:0570]  ;/

$81:8AF4 E2 20       SEP #$20
$81:8AF6 B9 02 00    LDA $0002,y[$A6:F925]  ;\
$81:8AF9 18          CLC                    ;|
$81:8AFA 65 12       ADC $12    [$7E:0012]  ;} OAM entry Y position = [$12] + [[Y] + 2] (Y position)
$81:8AFC 9D 71 03    STA $0371,x[$7E:0371]  ;/
$81:8AFF C2 21       REP #$21
$81:8B01 B9 03 00    LDA $0003,y[$A6:F926]  ;\
$81:8B04 65 00       ADC $00    [$7E:0000]  ;|
$81:8B06 05 03       ORA $03    [$7E:0003]  ;} OAM entry tile number and attributes = [[Y] + 3] + [$00] | [$03]
$81:8B08 9D 72 03    STA $0372,x[$7E:0372]  ;/
$81:8B0B 98          TYA                    ;\
$81:8B0C 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:8B0F A8          TAY                    ;/
$81:8B10 8A          TXA                    ;\
$81:8B11 69 04 00    ADC #$0004             ;|
$81:8B14 29 FF 01    AND #$01FF             ;} X += 4 (next OAM entry)
$81:8B17 AA          TAX                    ;/
$81:8B18 C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:8B1A D0 AA       BNE $AA    [$8AC6]     ; If [$18] != 0: go to LOOP
$81:8B1C 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]

$81:8B1F 7A          PLY
$81:8B20 6B          RTL
}


;;; $8B21: RTL ;;;
{
$81:8B21 6B          RTL
}


;;; $8B22: Add spritemap to OAM with base tile number ;;;
{
;; Parameters:
;;     DB:Y: Address of spritemap
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre
;;     $03: Palette bits of sprite (palette * 200h)
;;     $00: Base tile number

; Called by:
;    $A0:944A: Write enemy OAM (multi-hitbox)

; See $879F for spritemap format
; Bug: missing CLC before ADC when calclulating Y position, causes enemies straddling the left screen boundary to shift down a pixel

$81:8B22 5A          PHY
$81:8B23 B9 00 00    LDA $0000,y[$A6:ED29]  ; $18 = [[Y]] (number of entries)
$81:8B26 F0 6C       BEQ $6C    [$8B94]     ; If [$18] = 0: return
$81:8B28 C8          INY                    ;\
$81:8B29 C8          INY                    ;} Y += 2
$81:8B2A 85 18       STA $18    [$7E:0018]  
$81:8B2C AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$81:8B2F 18          CLC

; LOOP
$81:8B30 B9 00 00    LDA $0000,y[$A6:ED2B]  ;\
$81:8B33 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:8B35 9D 70 03    STA $0370,x[$7E:03A4]  ;/
$81:8B38 29 00 01    AND #$0100             ;\
$81:8B3B F0 0E       BEQ $0E    [$8B4B]     ;} If [OAM entry X position] % 200h >= 100h:
$81:8B3D BF 9F 85 81 LDA $81859F,x[$81:85B7];\
$81:8B41 85 16       STA $16    [$7E:0016]  ;|
$81:8B43 B2 16       LDA ($16)  [$7E:0570]  ;} Set OAM entry high X position bit
$81:8B45 1F 9F 83 81 ORA $81839F,x[$81:83B7];|
$81:8B49 92 16       STA ($16)  [$7E:0570]  ;/

$81:8B4B B9 00 00    LDA $0000,y[$A6:ED2B]  ;\
$81:8B4E 10 0E       BPL $0E    [$8B5E]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:8B50 BF 9F 85 81 LDA $81859F,x[$81:85D3];\
$81:8B54 85 16       STA $16    [$7E:0016]  ;|
$81:8B56 B2 16       LDA ($16)  [$7E:0572]  ;} Set OAM entry size bit
$81:8B58 1F A1 83 81 ORA $8183A1,x[$81:83D5];|
$81:8B5C 92 16       STA ($16)  [$7E:0572]  ;/

$81:8B5E E2 20       SEP #$20
$81:8B60 B9 02 00    LDA $0002,y[$A6:ED2D]  ;\
$81:8B63 30 06       BMI $06    [$8B6B]     ;} If [[Y] + 2] (Y offset) >= 0:
$81:8B65 65 12       ADC $12    [$7E:0012]  ;\
$81:8B67 90 08       BCC $08    [$8B71]     ;} If [$12] + [[Y] + 2] (Y position) < 100h: go to BRANCH_ON_SCREEN
$81:8B69 B0 04       BCS $04    [$8B6F]

$81:8B6B 65 12       ADC $12    [$7E:0012]  ;\ Else ((Y offset) < 0):
$81:8B6D B0 02       BCS $02    [$8B71]     ;} If (Y position) >= 0: go to BRANCH_ON_SCREEN

$81:8B6F A9 F0       LDA #$F0               ; Use F0h as Y position

; BRANCH_ON_SCREEN
$81:8B71 9D 71 03    STA $0371,x[$7E:03A5]  ; OAM entry Y position = (Y position)
$81:8B74 C2 21       REP #$21
$81:8B76 B9 03 00    LDA $0003,y[$A6:ED2E]  ;\
$81:8B79 65 00       ADC $00    [$7E:0000]  ;|
$81:8B7B 05 03       ORA $03    [$7E:0003]  ;} OAM entry tile number and attributes = [[Y] + 3] + [$00] | [$03]
$81:8B7D 9D 72 03    STA $0372,x[$7E:03A6]  ;/
$81:8B80 98          TYA                    ;\
$81:8B81 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:8B84 A8          TAY                    ;/
$81:8B85 8A          TXA                    ;\
$81:8B86 69 04 00    ADC #$0004             ;|
$81:8B89 29 FF 01    AND #$01FF             ;} X += 4 (next OAM entry)
$81:8B8C AA          TAX                    ;/
$81:8B8D C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:8B8F D0 9F       BNE $9F    [$8B30]     ; If [$18] != 0: go to LOOP
$81:8B91 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]

$81:8B94 7A          PLY
$81:8B95 6B          RTL
}


;;; $8B96: Add spritemap to OAM with base tile number off-screen ;;;
{
;; Parameters:
;;     DB:Y: Address of spritemap
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre
;;     $03: Palette bits of sprite (palette * 200h)
;;     $00: Base tile number

; Called by:
;    $A0:944A: Write enemy OAM

; See $879F for spritemap format
$81:8B96 5A          PHY
$81:8B97 B9 00 00    LDA $0000,y[$A6:EC5B]  ; $18 = [[Y]] (number of entries)
$81:8B9A F0 6C       BEQ $6C    [$8C08]     ; If [$18] = 0: return
$81:8B9C C8          INY                    ;\
$81:8B9D C8          INY                    ;} Y += 2
$81:8B9E 85 18       STA $18    [$7E:0018]  
$81:8BA0 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$81:8BA3 18          CLC

; LOOP
$81:8BA4 B9 00 00    LDA $0000,y[$A6:EC5D]  ;\
$81:8BA7 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:8BA9 9D 70 03    STA $0370,x[$7E:03D4]  ;/
$81:8BAC 29 00 01    AND #$0100             ;\
$81:8BAF F0 0E       BEQ $0E    [$8BBF]     ;} If [OAM entry X position] % 200h >= 100h:
$81:8BB1 BF 9F 85 81 LDA $81859F,x[$81:85FB];\
$81:8BB5 85 16       STA $16    [$7E:0016]  ;|
$81:8BB7 B2 16       LDA ($16)  [$7E:0574]  ;} Set OAM entry high X position bit
$81:8BB9 1F 9F 83 81 ORA $81839F,x[$81:83FB];|
$81:8BBD 92 16       STA ($16)  [$7E:0574]  ;/
                                            
$81:8BBF B9 00 00    LDA $0000,y[$A6:EC5D]  ;\
$81:8BC2 10 0E       BPL $0E    [$8BD2]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:8BC4 BF 9F 85 81 LDA $81859F,x[$81:861F];\
$81:8BC8 85 16       STA $16    [$7E:0016]  ;|
$81:8BCA B2 16       LDA ($16)  [$7E:0578]  ;} Set OAM entry size bit
$81:8BCC 1F A1 83 81 ORA $8183A1,x[$81:8421];|
$81:8BD0 92 16       STA ($16)  [$7E:0578]  ;/

$81:8BD2 E2 20       SEP #$20
$81:8BD4 B9 02 00    LDA $0002,y[$A6:EC5F]  ;\
$81:8BD7 30 06       BMI $06    [$8BDF]     ;} If [[Y] + 2] (Y offset) >= 0:
$81:8BD9 65 12       ADC $12    [$7E:0012]  ;\
$81:8BDB B0 08       BCS $08    [$8BE5]     ;} If [$12] + [[Y] + 2] (Y position) >= 0: go to BRANCH_ON_SCREEN
$81:8BDD 90 04       BCC $04    [$8BE3]

$81:8BDF 65 12       ADC $12    [$7E:0012]  ;\ Else ((Y offset) < 0):
$81:8BE1 90 02       BCC $02    [$8BE5]     ;} If (Y position) < 100h: go to BRANCH_ON_SCREEN

$81:8BE3 A9 F0       LDA #$F0               ; Use F0h as Y position

; BRANCH_ON_SCREEN
$81:8BE5 9D 71 03    STA $0371,x[$7E:03D5]  ; OAM entry Y position = (Y position)
$81:8BE8 C2 21       REP #$21               
$81:8BEA B9 03 00    LDA $0003,y[$A6:EC60]  ;\
$81:8BED 65 00       ADC $00    [$7E:0000]  ;|
$81:8BEF 05 03       ORA $03    [$7E:0003]  ;} OAM entry tile number and attributes = [[Y] + 3] + [$00] | [$03]
$81:8BF1 9D 72 03    STA $0372,x[$7E:03D6]  ;/
$81:8BF4 98          TYA                    ;\
$81:8BF5 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:8BF8 A8          TAY                    ;/
$81:8BF9 8A          TXA                    ;\
$81:8BFA 69 04 00    ADC #$0004             ;|
$81:8BFD 29 FF 01    AND #$01FF             ;} X += 4 (next OAM entry)
$81:8C00 AA          TAX                    ;/
$81:8C01 C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:8C03 D0 9F       BNE $9F    [$8BA4]     ; If [$18] != 0: go to LOOP
$81:8C05 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]

$81:8C08 7A          PLY
$81:8C09 6B          RTL
}


;;; $8C0A: Add spritemap to OAM with base tile number ;;;
{
;; Parameters:
;;     DB:Y: Address of spritemap
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre
;;     $1A: Base tile number
;;     $1C: Palette bits of sprite (palette * 200h)

; Called by:
;    $86:83D6: Draw enemy projectile

; See $879F for spritemap format
$81:8C0A B9 00 00    LDA $0000,y[$8D:B1BA]  ;\
$81:8C0D D0 01       BNE $01    [$8C10]     ;} If [[Y]] = 0: return
$81:8C0F 6B          RTL                    ;/

$81:8C10 85 18       STA $18    [$7E:0018]  ; $18 = [[Y]] (size)
$81:8C12 C8          INY                    ;\
$81:8C13 C8          INY                    ;} Y += 2
$81:8C14 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$81:8C17 18          CLC

; LOOP
$81:8C18 B9 00 00    LDA $0000,y[$8D:B1BC]  ;\
$81:8C1B 18          CLC                    ;|
$81:8C1C 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:8C1E 9D 70 03    STA $0370,x[$7E:0370]  ;/
$81:8C21 89 00 01    BIT #$0100             ;\
$81:8C24 F0 0E       BEQ $0E    [$8C34]     ;} If [OAM entry X position] % 200h >= 100h:
$81:8C26 BF 9F 85 81 LDA $81859F,x[$81:85FB];\
$81:8C2A 85 16       STA $16    [$7E:0016]  ;|
$81:8C2C B2 16       LDA ($16)  [$7E:0574]  ;} Set OAM entry high X position bit
$81:8C2E 1F 9F 83 81 ORA $81839F,x[$81:83FB];|
$81:8C32 92 16       STA ($16)  [$7E:0574]  ;/

$81:8C34 E2 20       SEP #$20
$81:8C36 18          CLC
$81:8C37 B9 02 00    LDA $0002,y[$8D:B1BE]  ;\
$81:8C3A 30 06       BMI $06    [$8C42]     ;} If [[Y] + 2] (Y offset) >= 0:
$81:8C3C 65 12       ADC $12    [$7E:0012]  ;\
$81:8C3E 90 08       BCC $08    [$8C48]     ;} If [$12] + [[Y] + 2] (Y position) < 100h: go to BRANCH_ON_SCREEN
$81:8C40 B0 04       BCS $04    [$8C46]

$81:8C42 65 12       ADC $12    [$7E:0012]  ;\ Else ((Y offset) < 0):
$81:8C44 B0 02       BCS $02    [$8C48]     ;} If (Y position) >= 0: go to BRANCH_ON_SCREEN

$81:8C46 A9 F0       LDA #$F0               ; Use F0h as Y position

; BRANCH_ON_SCREEN
$81:8C48 9D 71 03    STA $0371,x[$7E:0371]  ; OAM entry Y position = (Y position)
$81:8C4B C2 21       REP #$21
$81:8C4D B9 00 00    LDA $0000,y[$8D:B1BC]  ;\
$81:8C50 10 0E       BPL $0E    [$8C60]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:8C52 BF 9F 85 81 LDA $81859F,x[$81:860B];\
$81:8C56 85 16       STA $16    [$7E:0016]  ;|
$81:8C58 B2 16       LDA ($16)  [$7E:0576]  ;} Set OAM entry size bit
$81:8C5A 1F A1 83 81 ORA $8183A1,x[$81:840D];|
$81:8C5E 92 16       STA ($16)  [$7E:0576]  ;/

$81:8C60 B9 03 00    LDA $0003,y[$8D:B1BF]  ;\
$81:8C63 65 1A       ADC $1A    [$7E:001A]  ;|
$81:8C65 05 1C       ORA $1C    [$7E:001C]  ;} OAM entry tile number and attributes = [[Y] + 3] + [$1A] | [$1C]
$81:8C67 9D 72 03    STA $0372,x[$7E:0372]  ;/
$81:8C6A 8A          TXA                    ;\
$81:8C6B 69 04 00    ADC #$0004             ;|
$81:8C6E 29 FF 01    AND #$01FF             ;} X += 4 (next OAM entry)
$81:8C71 AA          TAX                    ;/
$81:8C72 98          TYA                    ;\
$81:8C73 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:8C76 A8          TAY                    ;/
$81:8C77 C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:8C79 D0 9D       BNE $9D    [$8C18]     ; If [$18] != 0: go to LOOP
$81:8C7B 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$81:8C7E 6B          RTL
}


;;; $8C7F: Add spritemap to OAM with base tile number offscreen ;;;
{
;; Parameters:
;;     DB:Y: Address of spritemap
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre
;;     $1A: Base tile number
;;     $1C: Palette bits of sprite (palette * 200h)

; Called by:
;    $86:83D6: Draw enemy projectile

; See $879F for spritemap format
$81:8C7F B9 00 00    LDA $0000,y[$8D:B250]  ;\
$81:8C82 D0 01       BNE $01    [$8C85]     ;} If [[Y]] = 0: return
$81:8C84 6B          RTL                    ;/

$81:8C85 85 18       STA $18    [$7E:0018]  ; $18 = [[Y]] (size)
$81:8C87 C8          INY                    ;\
$81:8C88 C8          INY                    ;} Y += 2
$81:8C89 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$81:8C8C 18          CLC

; LOOP
$81:8C8D B9 00 00    LDA $0000,y[$8D:B252]  ;\
$81:8C90 18          CLC                    ;|
$81:8C91 65 14       ADC $14    [$7E:0014]  ;} OAM entry X position = [$14] + [[Y]] (X position)
$81:8C93 9D 70 03    STA $0370,x[$7E:03D4]  ;/
$81:8C96 89 00 01    BIT #$0100             ;\
$81:8C99 F0 0E       BEQ $0E    [$8CA9]     ;} If [OAM entry X position] % 200h >= 100h:
$81:8C9B BF 9F 85 81 LDA $81859F,x[$81:859F];\
$81:8C9F 85 16       STA $16    [$7E:0016]  ;|
$81:8CA1 B2 16       LDA ($16)  [$7E:0570]  ;} Set OAM entry high X position bit
$81:8CA3 1F 9F 83 81 ORA $81839F,x[$81:839F];|
$81:8CA7 92 16       STA ($16)  [$7E:0570]  ;/

$81:8CA9 E2 20       SEP #$20
$81:8CAB 18          CLC
$81:8CAC B9 02 00    LDA $0002,y[$8D:B254]  ;\
$81:8CAF 30 06       BMI $06    [$8CB7]     ;} If [[Y] + 2] (Y offset) >= 0:
$81:8CB1 65 12       ADC $12    [$7E:0012]  ;\
$81:8CB3 B0 08       BCS $08    [$8CBD]     ;} If [[Y] + 2] + [$12] (Y position) >= 0: go to BRANCH_ON_SCREEN
$81:8CB5 90 04       BCC $04    [$8CBB]

$81:8CB7 65 12       ADC $12    [$7E:0012]  ;\ Else ((Y offset) < 0):
$81:8CB9 90 02       BCC $02    [$8CBD]     ;} If (Y position) < 100h: go to BRANCH_ON_SCREEN

$81:8CBB A9 F0       LDA #$F0               ; Use F0h as Y position

; BRANCH_ON_SCREEN
$81:8CBD 9D 71 03    STA $0371,x[$7E:03D5]  ; OAM entry Y position = (Y position)
$81:8CC0 C2 21       REP #$21               
$81:8CC2 B9 00 00    LDA $0000,y[$8D:B252]  ;\
$81:8CC5 10 0E       BPL $0E    [$8CD5]     ;} If [[Y]] & 8000h (size bit) != 0:
$81:8CC7 BF 9F 85 81 LDA $81859F,x[$81:8603];\
$81:8CCB 85 16       STA $16    [$7E:0016]  ;|
$81:8CCD B2 16       LDA ($16)  [$7E:0576]  ;} Set OAM entry size bit
$81:8CCF 1F A1 83 81 ORA $8183A1,x[$81:8405];|
$81:8CD3 92 16       STA ($16)  [$7E:0576]  ;/
                                            
$81:8CD5 B9 03 00    LDA $0003,y[$8D:B255]  ;\
$81:8CD8 65 1A       ADC $1A    [$7E:001A]  ;|
$81:8CDA 05 1C       ORA $1C    [$7E:001C]  ;} OAM entry tile number and attributes = [[Y] + 3] + [$1A] | [$1C]
$81:8CDC 9D 72 03    STA $0372,x[$7E:03D6]  ;/
$81:8CDF 8A          TXA                    ;\
$81:8CE0 69 04 00    ADC #$0004             ;|
$81:8CE3 29 FF 01    AND #$01FF             ;} X += 4 (next OAM entry)
$81:8CE6 AA          TAX                    ;/
$81:8CE7 98          TYA                    ;\
$81:8CE8 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$81:8CEB A8          TAY                    ;/
$81:8CEC C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:8CEE D0 9D       BNE $9D    [$8C8D]     ; If [$18] != 0: go to LOOP
$81:8CF0 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$81:8CF3 6B          RTL
}
}


;;; $8CF4..93FA: Game over menu ;;;
{
;;; $8CF4: Debug game over menu ;;;
{
; Game state 1Dh
$81:8CF4 C2 30       REP #$30
$81:8CF6 8B          PHB
$81:8CF7 4B          PHK                    ;\
$81:8CF8 AB          PLB                    ;} DB = $81
$81:8CF9 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:8CFC 0A          ASL A                  ;|
$81:8CFD AA          TAX                    ;} Execute [$8D03 + [menu index]]
$81:8CFE FC 03 8D    JSR ($8D03,x)          ;/
$81:8D01 AB          PLB
$81:8D02 6B          RTL

$81:8D03             dw 8D0F, 8D6D, 8DA6, 9003, 8DA6, 907E
}


;;; $8D0F: (Debug) game over menu - index 0: fade out and configure graphics for menu ;;;
{
$81:8D0F C2 30       REP #$30
$81:8D11 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$81:8D15 A5 51       LDA $51    [$7E:0051]  ;\
$81:8D17 29 0F 00    AND #$000F             ;} If (brightness) != 0:
$81:8D1A F0 01       BEQ $01    [$8D1D]     ;/
$81:8D1C 60          RTS                    ; Return

$81:8D1D 22 6F 83 80 JSL $80836F[$80:836F]  ; Set force blank and wait for NMI
$81:8D21 A9 01 00    LDA #$0001             ;\
$81:8D24 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1, sound library 3, max queued sounds allowed = 6 (silence)
$81:8D28 22 93 82 88 JSL $888293[$88:8293]  ; Disable HDMA objects
$81:8D2C 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$81:8D30 A2 00 00    LDX #$0000             ;\
                                            ;|
$81:8D33 BF 00 C0 7E LDA $7EC000,x[$7E:C000];|
$81:8D37 9F 00 33 7E STA $7E3300,x[$7E:3300];|
$81:8D3B E8          INX                    ;} $7E:3300..34FF = [palettes]
$81:8D3C E8          INX                    ;|
$81:8D3D E0 00 02    CPX #$0200             ;|
$81:8D40 30 F1       BMI $F1    [$8D33]     ;/
$81:8D42 A2 00 00    LDX #$0000             ;\
                                            ;|
$81:8D45 B5 51       LDA $51,x  [$7E:0051]  ;|
$81:8D47 9F 00 35 7E STA $7E3500,x[$7E:3500];|
$81:8D4B E8          INX                    ;} $7E:3500..35 = [$51..86] (regular IO registers)
$81:8D4C E8          INX                    ;|
$81:8D4D E0 36 00    CPX #$0036             ;|
$81:8D50 30 F3       BMI $F3    [$8D45]     ;/
$81:8D52 20 BA 8D    JSR $8DBA  [$81:8DBA]  ; Map VRAM for menu
$81:8D55 20 DB 8D    JSR $8DDB  [$81:8DDB]  ; Load initial menu tiles
$81:8D58 C2 30       REP #$30
$81:8D5A 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$81:8D5C 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$81:8D5E 64 B9       STZ $B9    [$7E:00B9]  ; BG3 X scroll = 0
$81:8D60 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$81:8D62 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$81:8D64 64 BB       STZ $BB    [$7E:00BB]  ; BG3 Y scroll = 0
$81:8D66 20 60 8E    JSR $8E60  [$81:8E60]  ; Load menu palettes
$81:8D69 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 1
$81:8D6C 60          RTS
}


;;; $8D6D: Debug game over menu - index 1: initialise ;;;
{
$81:8D6D C2 30       REP #$30
$81:8D6F A9 00 00    LDA #$0000             ;\
$81:8D72 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$81:8D76 A9 03 FF    LDA #$FF03             ;\
$81:8D79 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue title sequence music data
$81:8D7D E2 20       SEP #$20               ;\
$81:8D7F A9 11       LDA #$11               ;|
$81:8D81 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$81:8D83 C2 30       REP #$30               ;/
$81:8D85 A9 E1 8E    LDA #$8EE1             ;\
$81:8D88 85 00       STA $00    [$7E:0000]  ;|
$81:8D8A A9 81 00    LDA #$0081             ;} $00 = $81:8EE1
$81:8D8D 85 02       STA $02    [$7E:0002]  ;/
$81:8D8F 22 7F 8E 81 JSL $818E7F[$81:8E7F]  ; Load debug game over menu tilemaps
$81:8D93 22 82 83 80 JSL $808382[$80:8382]  ; Clear force blank and wait for NMI
$81:8D97 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 2
$81:8D9A 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$81:8D9D 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$81:8DA0 9C 50 09    STZ $0950  [$7E:0950]  ; Game over menu selection = end
$81:8DA3 60          RTS
}


;;; $8DA4: Unused ;;;
{
$81:8DA4             dw 000F
}


;;; $8DA6: Debug game over menu - index 2/4: fade in ;;;
{
$81:8DA6 C2 30       REP #$30
$81:8DA8 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$81:8DAC A5 51       LDA $51    [$7E:0051]  ;\
$81:8DAE 29 0F 00    AND #$000F             ;|
$81:8DB1 C9 0F 00    CMP #$000F             ;} If (brightness) = Fh:
$81:8DB4 D0 03       BNE $03    [$8DB9]     ;/
$81:8DB6 EE 27 07    INC $0727  [$7E:0727]  ; Increment menu index

$81:8DB9 60          RTS
}


;;; $8DBA: Map VRAM for menu ;;;
{
; PSR.M is set on return(!)
$81:8DBA E2 20       SEP #$20
$81:8DBC 64 6B       STZ $6B    [$7E:006B]  ; Disable all subscreen layers
$81:8DBE A9 03       LDA #$03               ;\
$81:8DC0 85 52       STA $52    [$7E:0052]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$81:8DC2 A9 51       LDA #$51               ;\
$81:8DC4 85 58       STA $58    [$7E:0058]  ;} BG1 tilemap base address = $5000, size = 64x32
$81:8DC6 A9 58       LDA #$58               ;\
$81:8DC8 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $5800, size = 32x32
$81:8DCA A9 5C       LDA #$5C               ;\
$81:8DCC 85 5A       STA $5A    [$7E:005A]  ;} BG3 tilemap base address = $5C00, size = 32x32
$81:8DCE A9 00       LDA #$00               ;\
$81:8DD0 85 5D       STA $5D    [$7E:005D]  ;} BG1/2 tiles base address = $0000
$81:8DD2 A9 04       LDA #$04               ;\
$81:8DD4 85 5E       STA $5E    [$7E:005E]  ;} BG3 tiles base address = $4000
$81:8DD6 A9 13       LDA #$13               ;\
$81:8DD8 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$81:8DDA 60          RTS
}


;;; $8DDB: Load initial menu tiles ;;;
{
$81:8DDB 08          PHP
$81:8DDC E2 30       SEP #$30
$81:8DDE A9 00       LDA #$00               ;\
$81:8DE0 8D 16 21    STA $2116  [$7E:2116]  ;|
$81:8DE3 A9 00       LDA #$00               ;|
$81:8DE5 8D 17 21    STA $2117  [$7E:2117]  ;|
$81:8DE8 A9 80       LDA #$80               ;|
$81:8DEA 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..2AFF = [$8E:8000..D5FF] (menu tiles)
$81:8DED 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$81:8DF1             dx 01,01,18,8E8000,5600;|
$81:8DF9 A9 02       LDA #$02               ;|
$81:8DFB 8D 0B 42    STA $420B  [$7E:420B]  ;/
$81:8DFE A9 00       LDA #$00               ;\
$81:8E00 8D 16 21    STA $2116  [$7E:2116]  ;|
$81:8E03 A9 30       LDA #$30               ;|
$81:8E05 8D 17 21    STA $2117  [$7E:2117]  ;|
$81:8E08 A9 80       LDA #$80               ;|
$81:8E0A 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $3000..3FFF = [$B6:8000..9FFF] (first half of pause screen BG1/2 tiles)
$81:8E0D 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$81:8E11             dx 01,01,18,B68000,2000;|
$81:8E19 A9 02       LDA #$02               ;|
$81:8E1B 8D 0B 42    STA $420B  [$7E:420B]  ;/
$81:8E1E A9 00       LDA #$00               ;\
$81:8E20 8D 16 21    STA $2116  [$7E:2116]  ;|
$81:8E23 A9 60       LDA #$60               ;|
$81:8E25 8D 17 21    STA $2117  [$7E:2117]  ;|
$81:8E28 A9 80       LDA #$80               ;|
$81:8E2A 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $6000..6FFF = [$B6:C000..DFFF] (menu / pause screen sprite tiles)
$81:8E2D 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$81:8E31             dx 01,01,18,B6C000,2000;|
$81:8E39 A9 02       LDA #$02               ;|
$81:8E3B 8D 0B 42    STA $420B  [$7E:420B]  ;/
$81:8E3E A9 00       LDA #$00               ;\
$81:8E40 8D 16 21    STA $2116  [$7E:2116]  ;|
$81:8E43 A9 40       LDA #$40               ;|
$81:8E45 8D 17 21    STA $2117  [$7E:2117]  ;|
$81:8E48 A9 80       LDA #$80               ;|
$81:8E4A 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4000..42FF = [$8E:D600..DBFF] (beta minimap tiles)
$81:8E4D 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$81:8E51             dx 01,01,18,8ED600,0600;|
$81:8E59 A9 02       LDA #$02               ;|
$81:8E5B 8D 0B 42    STA $420B  [$7E:420B]  ;/
$81:8E5E 28          PLP
$81:8E5F 60          RTS
}


;;; $8E60: Load menu palettes ;;;
{
$81:8E60 C2 30       REP #$30
$81:8E62 A2 00 00    LDX #$0000             ;\
                                            ;|
$81:8E65 BF 00 E4 8E LDA $8EE400,x[$8E:E400];|
$81:8E69 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$81:8E6D BF 02 E4 8E LDA $8EE402,x[$8E:E402];|
$81:8E71 9F 02 C0 7E STA $7EC002,x[$7E:C002];|
$81:8E75 E8          INX                    ;} Palettes = [$8E:E400..E5FF]
$81:8E76 E8          INX                    ;|
$81:8E77 E8          INX                    ;|
$81:8E78 E8          INX                    ;|
$81:8E79 E0 00 02    CPX #$0200             ;|
$81:8E7C 30 E7       BMI $E7    [$8E65]     ;/
$81:8E7E 60          RTS
}


;;; $8E7F: Load debug game over menu tilemap ;;;
{
;; Parameters:
;;     $00: Pointer to VRAM transfer definitions ($81:8EE1)
$81:8E7F A2 00 00    LDX #$0000             ;\
$81:8E82 A9 0F 00    LDA #$000F             ;|
                                            ;|
$81:8E85 9F 00 38 7E STA $7E3800,x          ;|
$81:8E89 E8          INX                    ;} $7E:3800..3FFF = 000Fh (debug game over menu tilemap)
$81:8E8A E8          INX                    ;|
$81:8E8B E0 00 08    CPX #$0800             ;|
$81:8E8E 30 F5       BMI $F5    [$8E85]     ;/
$81:8E90 AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:8E93 A9 00 08    LDA #$0800             ;|
$81:8E96 95 D0       STA $D0,x              ;|
$81:8E98 A9 00 38    LDA #$3800             ;|
$81:8E9B 95 D2       STA $D2,x              ;|
$81:8E9D A9 7E 00    LDA #$007E             ;|
$81:8EA0 95 D4       STA $D4,x              ;|
$81:8EA2 A5 58       LDA $58    [$7E:0058]  ;} Queue transfer of 800h bytes from $7E:3800 to VRAM BG1 tilemap
$81:8EA4 29 FC 00    AND #$00FC             ;|
$81:8EA7 EB          XBA                    ;|
$81:8EA8 95 D5       STA $D5,x              ;|
$81:8EAA 8A          TXA                    ;|
$81:8EAB 18          CLC                    ;|
$81:8EAC 69 07 00    ADC #$0007             ;|
$81:8EAF 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:8EB2 AE 30 03    LDX $0330  [$7E:0330]  ; X = [VRAM write table stack pointer]
$81:8EB5 A0 00 00    LDY #$0000             ; Y = 0

; LOOP
$81:8EB8 B7 00       LDA [$00],y            ;\
$81:8EBA C9 FF FF    CMP #$FFFF             ;} If [[$00] + [Y]] != FFFFh:
$81:8EBD F0 1E       BEQ $1E    [$8EDD]     ;/
$81:8EBF 95 D0       STA $D0,x              ;\
$81:8EC1 C8          INY                    ;|
$81:8EC2 C8          INY                    ;|
$81:8EC3 B7 00       LDA [$00],y            ;|
$81:8EC5 95 D2       STA $D2,x              ;|
$81:8EC7 C8          INY                    ;|
$81:8EC8 C8          INY                    ;|
$81:8EC9 B7 00       LDA [$00],y            ;|
$81:8ECB 95 D4       STA $D4,x              ;} Queue transfer of [[$00] + [Y]] bytes from [[$00] + [Y] + 2] to VRAM [[$00] + [Y] + 6]
$81:8ECD C8          INY                    ;|
$81:8ECE C8          INY                    ;|
$81:8ECF B7 00       LDA [$00],y            ;|
$81:8ED1 95 D5       STA $D5,x              ;|
$81:8ED3 8A          TXA                    ;|
$81:8ED4 18          CLC                    ;|
$81:8ED5 69 07 00    ADC #$0007             ;|
$81:8ED8 AA          TAX                    ;/
$81:8ED9 C8          INY                    ;\
$81:8EDA C8          INY                    ;} Y += 8
$81:8EDB 80 DB       BRA $DB    [$8EB8]     ; Go to LOOP

$81:8EDD 8E 30 03    STX $0330  [$7E:0330]  ; VRAM write table stack pointer = [X]
$81:8EE0 6B          RTL
}


;;; $8EE1: Debug game over menu VRAM transfer definitions ;;;
{
;                        __________________ Size (or FFFFh terminator)
;                       |     _____________ Source address
;                       |    |       ______ Padding byte for source bank
;                       |    |      |   ___ Destination VRAM address
;                       |    |      |  |
$81:8EE1             dx 0040,818F03,00,5140, ; '            CONTINUE            '
$81:8EE9             dx 0040,818F43,00,5180, ; '            END                 '
$81:8EF1             dx 0040,818F83,00,51E0, ; '        WOULD YOU PLAY ?        '
$81:8EF9             dx 0040,818FC3,00,5220, ; '            GAME QUIT           '
$81:8F01             dx FFFF
}


;;; $8F03: Debug game over menu tilemaps ;;;
{
; '            GAME QUIT           '
; '        WOULD YOU PLAY ?        '
; '            END                 '
; '            CONTINUE            '
$81:8F03             dw 000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,0070,006A,0076,006E,000F,007A,007E,0072,007D,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F
$81:8F43             dw 000F,000F,000F,000F,000F,000F,000F,000F,0080,0078,007E,0075,006D,000F,0082,0078,007E,000F,0079,0075,006A,0082,000F,0085,000F,000F,000F,000F,000F,000F,000F,000F
$81:8F83             dw 000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,006E,0077,006D,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F
$81:8FC3             dw 000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,006C,0078,0077,007D,0072,0077,007E,006E,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F
}


;;; $9003: Debug game over menu - index 3: main ;;;
{
$81:9003 C2 30       REP #$30
$81:9005 A5 8F       LDA $8F    [$7E:008F]  ;\
$81:9007 89 00 20    BIT #$2000             ;} If newly pressed select: go to BRANCH_TOGGLE_SELECTION
$81:900A D0 23       BNE $23    [$902F]     ;/
$81:900C 89 00 08    BIT #$0800             ;\
$81:900F D0 1E       BNE $1E    [$902F]     ;} If newly pressed up: go to BRANCH_TOGGLE_SELECTION
$81:9011 89 00 04    BIT #$0400             ;\
$81:9014 D0 19       BNE $19    [$902F]     ;} If newly pressed down: go to BRANCH_TOGGLE_SELECTION
$81:9016 89 80 90    BIT #$9080             ;\
$81:9019 F0 1D       BEQ $1D    [$9038]     ;} If newly pressed none of A/B/start: go to BRANCH_NO_CHANGE
$81:901B AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:901E D0 0B       BNE $0B    [$902B]     ;} If [debug game over menu selection] = end:
$81:9020 AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:9023 22 00 80 81 JSL $818000[$81:8000]  ;} Save current save slot to SRAM
$81:9027 5C 62 84 80 JML $808462[$80:8462]  ; Go to soft reset

$81:902B EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 4
$81:902E 60          RTS                    ; Return

; BRANCH_TOGGLE_SELECTION
$81:902F AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:9032 49 01 00    EOR #$0001             ;} Debug game over menu selection ^= 1
$81:9035 8D 50 09    STA $0950  [$7E:0950]  ;/

; BRANCH_NO_CHANGE
$81:9038 A2 00 78    LDX #$7800             ; A high = 78h (Y position)
$81:903B AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:903E F0 03       BEQ $03    [$9043]     ;} If [debug game over menu selection] = continue:
$81:9040 A2 00 88    LDX #$8800             ; A high = 88h (Y position)

$81:9043 8A          TXA
$81:9044 09 28 00    ORA #$0028             ; A low = 28h (X position)
$81:9047 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$81:904A 9D 70 03    STA $0370,x            ; OAM entry X/Y position = [A]
$81:904D A9 B6 00    LDA #$00B6             ;\
$81:9050 9D 72 03    STA $0372,x            ;} OAM entry tile number and attributes = 00B6h (top-right tile of start button...)
$81:9053 E8          INX                    ;\
$81:9054 E8          INX                    ;|
$81:9055 E8          INX                    ;} OAM stack pointer += 4
$81:9056 E8          INX                    ;|
$81:9057 8E 90 05    STX $0590  [$7E:0590]  ;/
$81:905A 60          RTS
}


;;; $905B: Restore palettes and regular IO registers from debug game over menu ;;;
{
$81:905B A2 00 00    LDX #$0000             ;\
                                            ;|
$81:905E BF 00 33 7E LDA $7E3300,x          ;|
$81:9062 9F 00 C0 7E STA $7EC000,x          ;|
$81:9066 E8          INX                    ;} Palettes = [$7E:3300..34FF]
$81:9067 E8          INX                    ;|
$81:9068 E0 00 02    CPX #$0200             ;|
$81:906B 30 F1       BMI $F1    [$905E]     ;/
$81:906D A2 00 00    LDX #$0000             ;\
                                            ;|
$81:9070 BF 00 35 7E LDA $7E3500,x          ;|
$81:9074 95 51       STA $51,x              ;|
$81:9076 E8          INX                    ;} $51..86 = [$7E:3500..35] (regular IO registers)
$81:9077 E8          INX                    ;|
$81:9078 E0 36 00    CPX #$0036             ;|
$81:907B 30 F3       BMI $F3    [$9070]     ;/
$81:907D 60          RTS
}


;;; $907E: Debug game over menu - index 5: continue ;;;
{
$81:907E E2 30       SEP #$30
$81:9080 A9 00       LDA #$00               ;\
$81:9082 8D 16 21    STA $2116  [$7E:2116]  ;|
$81:9085 A9 40       LDA #$40               ;|
$81:9087 8D 17 21    STA $2117  [$7E:2117]  ;|
$81:908A A9 80       LDA #$80               ;|
$81:908C 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4000..4FFF (BG3 tiles and BG2 tilemap) = [$9A:B200..D1FF] (standard BG3 tiles, clear BG2)
$81:908F 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$81:9093             dx 01,01,18,9AB200,2000;|
$81:909B A9 02       LDA #$02               ;|
$81:909D 8D 0B 42    STA $420B  [$7E:420B]  ;/
$81:90A0 C2 30       REP #$30
$81:90A2 A9 10 00    LDA #$0010             ;\
$81:90A5 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 10h (unpausing, loading normal gameplay)
$81:90A8 9C 50 09    STZ $0950  [$7E:0950]  ; Debug game over menu selection = 0
$81:90AB 4C 5B 90    JMP $905B  [$81:905B]  ; Go to restore palettes and regular IO registers from debug game over menu
}


;;; $90AE: Game over menu ;;;
{
$81:90AE C2 30       REP #$30
$81:90B0 8B          PHB
$81:90B1 4B          PHK                    ;\
$81:90B2 AB          PLB                    ;} DB = $81
$81:90B3 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:90B6 0A          ASL A                  ;|
$81:90B7 AA          TAX                    ;} Execute [$90BD + [menu index]]
$81:90B8 FC BD 90    JSR ($90BD,x)[$81:8D0F];/
$81:90BB AB          PLB
$81:90BC 6B          RTL

$81:90BD             dw 8D0F, 91A4, 93E8, 90CD, 912B, 90E7, 9116, 90FE
}


;;; $90CD: Game over menu - index 3: fade in ;;;
{
$81:90CD 22 75 BB 82 JSL $82BB75[$82:BB75]  ; Handle game over baby metroid
$81:90D1 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:90D5 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$81:90D9 A5 51       LDA $51    [$7E:0051]  ;\
$81:90DB 29 0F 00    AND #$000F             ;|
$81:90DE C9 0F 00    CMP #$000F             ;} If (brightness) = Fh:
$81:90E1 D0 03       BNE $03    [$90E6]     ;/
$81:90E3 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 4

$81:90E6 60          RTS
}


;;; $90E7: Game over menu - index 5: fade out into game map view ;;;
{
$81:90E7 22 75 BB 82 JSL $82BB75[$82:BB75]  ; Handle game over baby metroid
$81:90EB 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:90EF 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$81:90F3 A5 51       LDA $51    [$7E:0051]  ;\
$81:90F5 29 0F 00    AND #$000F             ;} If (brightness) = 0:
$81:90F8 D0 03       BNE $03    [$90FD]     ;/
$81:90FA EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 6

$81:90FD 60          RTS
}


;;; $90FE: Game over menu - index 7: fade out into soft reset ;;;
{
$81:90FE 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:9102 22 75 BB 82 JSL $82BB75[$82:BB75]  ; Handle game over baby metroid
$81:9106 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$81:910A A5 51       LDA $51    [$7E:0051]  ;\
$81:910C 29 0F 00    AND #$000F             ;} If (brightness) != 0:
$81:910F F0 01       BEQ $01    [$9112]     ;/
$81:9111 60          RTS                    ; Return

$81:9112 5C 62 84 80 JML $808462[$80:8462]  ; Go to soft reset
}


;;; $9116: Game over menu - index 6: load game map view ;;;
{
$81:9116 22 93 82 88 JSL $888293[$88:8293]  ; Disable HDMA objects
$81:911A 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$81:911E A9 05 00    LDA #$0005             ;\
$81:9121 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 5 (file select map)
$81:9124 A9 00 00    LDA #$0000             ;\
$81:9127 8D 27 07    STA $0727  [$7E:0727]  ;} Menu index = 0
$81:912A 60          RTS
}


;;; $912B: Game over menu - index 4: main ;;;
{
$81:912B C2 30       REP #$30
$81:912D 22 75 BB 82 JSL $82BB75[$82:BB75]  ; Handle game over baby metroid
$81:9131 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:9135 A5 8F       LDA $8F    [$7E:008F]  ;\
$81:9137 89 00 20    BIT #$2000             ;} If newly pressed select: go to BRANCH_TOGGLE_SELECTION
$81:913A D0 40       BNE $40    [$917C]     ;/
$81:913C 89 00 08    BIT #$0800             ;\
$81:913F D0 3B       BNE $3B    [$917C]     ;} If newly pressed up: go to BRANCH_TOGGLE_SELECTION
$81:9141 89 00 04    BIT #$0400             ;\
$81:9144 D0 36       BNE $36    [$917C]     ;} If newly pressed down: go to BRANCH_TOGGLE_SELECTION
$81:9146 89 80 00    BIT #$0080             ;\
$81:9149 F0 41       BEQ $41    [$918C]     ;} If not newly pressed A: go to BRANCH_NO_CHANGE
$81:914B A9 B4 00    LDA #$00B4             ;\
$81:914E 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Enemy 0 instruction timer = B4h
$81:9151 AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:9154 F0 07       BEQ $07    [$915D]     ;} If [game over menu selection] != yes:
$81:9156 A9 07 00    LDA #$0007             ;\
$81:9159 8D 27 07    STA $0727  [$7E:0727]  ;} Menu index = 7
$81:915C 60          RTS                    ; Return

$81:915D AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$81:9161 C9 1F 00    CMP #$001F             ;} If [loading game state] != starting at Ceres:
$81:9164 F0 0B       BEQ $0B    [$9171]     ;/
$81:9166 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 5
$81:9169 AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:916C 22 85 80 81 JSL $818085[$81:8085]  ;} Load current save slot from SRAM
$81:9170 60          RTS                    ; Return

$81:9171 8D 98 09    STA $0998  [$7E:0998]  ; Game state = 1Fh (set up new game)
$81:9174 AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:9177 22 85 80 81 JSL $818085[$81:8085]  ;} Load current save slot from SRAM
$81:917B 60          RTS                    ; Return

; BRANCH_TOGGLE_SELECTION
$81:917C A9 37 00    LDA #$0037             ;\
$81:917F 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9183 AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:9186 49 01 00    EOR #$0001             ;} Game over menu selection ^= 1
$81:9189 8D 50 09    STA $0950  [$7E:0950]  ;/

; BRANCH_NO_CHANGE
$81:918C A2 28 00    LDX #$0028             ; X = 28h
$81:918F A0 A0 00    LDY #$00A0             ; Y = A0h
$81:9192 AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:9195 F0 06       BEQ $06    [$919D]     ;} If [game over menu selection] != yes:
$81:9197 A2 28 00    LDX #$0028             ; >_<;
$81:919A A0 C0 00    LDY #$00C0             ; Y = C0h

$81:919D 8E A1 19    STX $19A1  [$7E:19A1]  ; Menu selection missile X position = [X]
$81:91A0 8C AB 19    STY $19AB  [$7E:19AB]  ; Menu selection missile Y position = [Y]
$81:91A3 60          RTS
}


;;; $91A4: Game over menu - index 1: initialise ;;;
{
$81:91A4 E2 20       SEP #$20
$81:91A6 A9 11       LDA #$11               ;\
$81:91A8 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$81:91AA A9 20       LDA #$20               ;\
$81:91AC 85 74       STA $74    [$7E:0074]  ;|
$81:91AE A9 40       LDA #$40               ;|
$81:91B0 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$81:91B2 A9 80       LDA #$80               ;|
$81:91B4 85 76       STA $76    [$7E:0076]  ;/
$81:91B6 C2 30       REP #$30
$81:91B8 A9 00 00    LDA #$0000             ;\
$81:91BB 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$81:91BF A9 03 FF    LDA #$FF03             ;\
$81:91C2 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue title sequence music data
$81:91C6 A9 01 00    LDA #$0001             ;\
$81:91C9 8D 8D 19    STA $198D  [$7E:198D]  ;} Menu selection missile animation timer = 1
$81:91CC 3A          DEC A                  ;\
$81:91CD 8D 97 19    STA $1997  [$7E:1997]  ;} Menu selection missile animation frame = 0
$81:91D0 A2 00 00    LDX #$0000             ;\
$81:91D3 A9 0F 00    LDA #$000F             ;|
                                            ;|
$81:91D6 9F 00 36 7E STA $7E3600,x[$7E:3600];|
$81:91DA E8          INX                    ;} $7E:3600..3DFF = 000Fh (menu tilemap)
$81:91DB E8          INX                    ;|
$81:91DC E0 00 08    CPX #$0800             ;|
$81:91DF 30 F5       BMI $F5    [$91D6]     ;/
$81:91E1 AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:91E4 A9 00 08    LDA #$0800             ;|
$81:91E7 95 D0       STA $D0,x  [$7E:00D0]  ;|
$81:91E9 A9 00 36    LDA #$3600             ;|
$81:91EC 95 D2       STA $D2,x  [$7E:00D2]  ;|
$81:91EE A9 7E 00    LDA #$007E             ;|
$81:91F1 95 D4       STA $D4,x  [$7E:00D4]  ;|
$81:91F3 A5 58       LDA $58    [$7E:0058]  ;} Queue transfer of 800h bytes from $7E:3600 to VRAM BG1 tilemap
$81:91F5 29 FC 00    AND #$00FC             ;|
$81:91F8 EB          XBA                    ;|
$81:91F9 95 D5       STA $D5,x  [$7E:00D5]  ;|
$81:91FB 8A          TXA                    ;|
$81:91FC 18          CLC                    ;|
$81:91FD 69 07 00    ADC #$0007             ;|
$81:9200 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:9203 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:9206 A0 DC 92    LDY #$92DC             ;\
$81:9209 A2 56 01    LDX #$0156             ;} Load menu tilemap $92DC to (Bh, 5) (GAME OVER)
$81:920C 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:920F A0 04 93    LDY #$9304             ;\
$81:9212 A2 8A 03    LDX #$038A             ;} Load menu tilemap $9304 to (5, Eh) (FIND THE METROID LARVA!)
$81:9215 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9218 A0 34 93    LDY #$9334             ;\
$81:921B A2 14 04    LDX #$0414             ;} Load menu tilemap $9334 to (Ah, 10h) (TRY AGAIN?)
$81:921E 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9221 A0 4C 93    LDY #$934C             ;\
$81:9224 A2 CE 04    LDX #$04CE             ;} Load menu tilemap $934C to (7, 13h) (YES (RETURN TO GAME))
$81:9227 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:922A A0 A0 93    LDY #$93A0             ;\
$81:922D A2 CE 05    LDX #$05CE             ;} Load menu tilemap $93A0 to (7, 17h) (N O (GO TO TITLE))
$81:9230 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9233 9C 92 0F    STZ $0F92  [$7E:0F92]  ; Enemy 0 instruction list pointer = 0
$81:9236 9C 94 0F    STZ $0F94  [$7E:0F94]  ; Enemy 0 instruction list timer = 0
$81:9239 22 75 BB 82 JSL $82BB75[$82:BB75]  ; Handle game over baby metroid
$81:923D A5 6F       LDA $6F    [$7E:006F]  ;\
$81:923F 29 00 FF    AND #$FF00             ;} Colour math control register A = 0
$81:9242 85 6F       STA $6F    [$7E:006F]  ;/
$81:9244 22 93 82 88 JSL $888293[$88:8293]  ; Disable HDMA objects
$81:9248 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$81:924C 22 88 82 88 JSL $888288[$88:8288]  ; Enable HDMA objects
$81:9250 22 35 84 88 JSL $888435[$88:8435]  ;\
$81:9254             dx 00, 32, 927D        ;} Spawn HDMA object for colour math subscreen backdrop colour with instruction list $927D
$81:9258 22 35 84 88 JSL $888435[$88:8435]  ;\
$81:925C             dx 00, 31, 928D        ;} Spawn HDMA object for colour math control register B with instruction list $928D
$81:9260 22 82 83 80 JSL $808382[$80:8382]  ; Clear force blank and wait for NMI
$81:9264 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 2
$81:9267 9C 23 07    STZ $0723  [$7E:0723]  ; Screen fade delay = 0
$81:926A 9C 25 07    STZ $0725  [$7E:0725]  ; Screen fade counter = 0
$81:926D 9C 50 09    STZ $0950  [$7E:0950]  ; Game over menu selection = yes
$81:9270 A9 28 00    LDA #$0028             ;\
$81:9273 8D A1 19    STA $19A1  [$7E:19A1]  ;} Menu selection missile X position = 28h
$81:9276 A9 A0 00    LDA #$00A0             ;\
$81:9279 8D AB 19    STA $19AB  [$7E:19AB]  ;} Menu selection missile Y position = A0h
$81:927C 60          RTS
}


;;; $927D: HDMA object instruction list - colour math subscreen backdrop colour - game over menu gradient ;;;
{
$81:927D             dx 8655,81,    ; HDMA table bank = $81
                        8570,8192DB,; Pre-instruction = RTL
                        0001,92A7,
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $928D: HDMA object instruction list - colour math control register B - game over menu gradient ;;;
{
$81:928D             dx 8655,81,    ; HDMA table bank = $81
                        8570,8192DB,; Pre-instruction = RTL
                        0001,929D,
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $929D: HDMA table - colour math control register B - game over menu gradient ;;;
{
$81:929D             db 40,A1, ;\
                        3A,A1, ;} Enable subtractive colour math on BG1/backdrop
                        40,21, ;\
                        40,21, ;} Enable colour math on BG1/backdrop
                        00,00
}


;;; $92A7: HDMA table - colour math subscreen backdrop colour - game over menu gradient ;;;
{
$81:92A7             db 05,E8,
                        05,E7,
                        05,E6,
                        07,E5,
                        08,E4,
                        0A,E3,
                        0C,E2,
                        0C,E1,
                        40,E0,
                        05,C0,
                        0E,C1,
                        0C,C2,
                        0C,C3,
                        08,C4,
                        07,C5,
                        06,C6,
                        06,C7,
                        06,C8,
                        06,C9,
                        07,CA,
                        06,CB,
                        06,CC,
                        06,CD,
                        06,CE,
                        02,CF,
                        00,00
}


;;; $92DB: RTL ;;;
{
$81:92DB 6B          RTL
}


;;; $92DC: Game over tilemaps ;;;
{
; GAME OVER
$81:92DC             dw 000C,000A,0026,000E,000F,0000,002D,000E,000D,FFFE,
                        0030,001A,0036,001E,000F,0010,003E,001E,003A,FFFF

; FIND THE METROID LARVA!
$81:9304             dw 006F,0072,0077,006D,000F,007D,0071,006E,000F,0076,006E,007D,007B,0078,0072,006D,000F,0075,006A,007B,007F,006A,0084,FFFF

; TRY AGAIN?
$81:9334             dw 007D,007B,0082,000F,006A,0070,006A,0072,0077,000F,0085,FFFF

; YES (RETURN TO GAME)
$81:934C             dw 0041,000E,002B,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,FFFE,
                        0017,001E,003B,000F,008A,007B,006E,007D,007E,007B,0077,000F,007D,0078,000F,0070,006A,0076,006E,008B,FFFF

; N O (GO TO TITLE)
$81:93A0             dw 0027,000F,0000,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,FFFE,
                        0037,000F,0010,000F,008A,0070,0078,000F,007D,0078,000F,007D,0072,007D,0075,006E,008B,FFFF
}


;;; $93E8: Game over menu - index 2: play pre-statue hall music track ;;;
{
$81:93E8 C2 30       REP #$30
$81:93EA 22 F4 8E 80 JSL $808EF4[$80:8EF4]  ;\
$81:93EE B0 0A       BCS $0A    [$93FA]     ;} If music is queued: return
$81:93F0 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 3
$81:93F3 A9 04 00    LDA #$0004             ;\
$81:93F6 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue pre-statue hall music track

$81:93FA 60          RTS
}
}


;;; $93FB..A329: File select menu ;;;
{
;;; $93FB: File select menu ;;;
{
$81:93FB C2 30       REP #$30
$81:93FD 8B          PHB
$81:93FE 4B          PHK                    ;\
$81:93FF AB          PLB                    ;} DB = $81
$81:9400 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:9403 0A          ASL A                  ;|
$81:9404 AA          TAX                    ;} Execute [$940A + [menu index] * 2]
$81:9405 FC 0A 94    JSR ($940A,x)[$81:944E];/
$81:9408 AB          PLB
$81:9409 6B          RTL

$81:940A             dw 944E, 9E93, 9ED6, A058, A1C2, 94EE, 9561, 9532, 96C2, 977A, 9813, 98B7, 9984, 9A2C, 9AFA, 94F4,
                        9EF3, 951E, 9B28, 94EE, 9B33, 9532, 9B64, 9C0B, 9C36, 9C9E, 9D26, 94F4, 9EF3, 951E, 9D68, 9D77,
                        94A3, 94D5
}


;;; $944E: File select menu - index 0: title sequence to main - fade out and configure graphics ;;;
{
$81:944E C2 30       REP #$30
$81:9450 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$81:9454 A5 51       LDA $51    [$7E:0051]  ;\
$81:9456 29 0F 00    AND #$000F             ;} If (brightness) != 0:
$81:9459 F0 01       BEQ $01    [$945C]     ;/
$81:945B 60          RTS                    ; Return

$81:945C 22 6F 83 80 JSL $80836F[$80:836F]
$81:9460 A9 01 00    LDA #$0001             ;\
$81:9463 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1, sound library 3, max queued sounds allowed = 6 (silence)
$81:9467 22 93 82 88 JSL $888293[$88:8293]  ; Disable HDMA objects
$81:946B 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$81:946F EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 1 (load BG2)
$81:9472 20 BA 8D    JSR $8DBA  [$81:8DBA]  ; Map VRAM for menu
$81:9475 20 DB 8D    JSR $8DDB  [$81:8DDB]  ; Load initial menu tiles
$81:9478 C2 30       REP #$30
$81:947A 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$81:947C 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$81:947E 64 B9       STZ $B9    [$7E:00B9]  ; BG3 X scroll = 0
$81:9480 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$81:9482 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$81:9484 64 BB       STZ $BB    [$7E:00BB]  ; BG3 Y scroll = 0
}


;;; $9486: Load file select palettes ;;;
{
; Clone of $8E60, expect with no `REP #$30`
$81:9486 A2 00 00    LDX #$0000             ;\
                                            ;|
$81:9489 BF 00 E4 8E LDA $8EE400,x[$8E:E400];|
$81:948D 9F 00 C0 7E STA $7EC000,x[$7E:C000];|
$81:9491 BF 02 E4 8E LDA $8EE402,x[$8E:E402];|
$81:9495 9F 02 C0 7E STA $7EC002,x[$7E:C002];|
$81:9499 E8          INX                    ;} Palettes = [$8E:E400..E5FF]
$81:949A E8          INX                    ;|
$81:949B E8          INX                    ;|
$81:949C E8          INX                    ;|
$81:949D E0 00 02    CPX #$0200             ;|
$81:94A0 30 E7       BMI $E7    [$9489]     ;/
$81:94A2 60          RTS
}


;;; $94A3: File select menu - index 20h: main to options menu - fade out ;;;
{
$81:94A3 C2 30       REP #$30
$81:94A5 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:94A9 22 35 BA 82 JSL $82BA35[$82:BA35]  ; Draw border around SAMUS DATA
$81:94AD 20 C3 9D    JSR $9DC3  [$81:9DC3]  ; Draw file select Samus helmets
$81:94B0 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$81:94B4 A5 51       LDA $51    [$7E:0051]  ;\
$81:94B6 29 0F 00    AND #$000F             ;} If (brightness) != 0: return
$81:94B9 D0 19       BNE $19    [$94D4]     ;/
$81:94BB A9 02 00    LDA #$0002             ;\
$81:94BE 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 2 (game options menu)
$81:94C1 9C 27 07    STZ $0727  [$7E:0727]  ; Menu index = 0
$81:94C4 A0 00 00    LDY #$0000             ;\
$81:94C7 A9 00 00    LDA #$0000             ;|
                                            ;|
$81:94CA 99 8D 19    STA $198D,y[$7E:198D]  ;|
$81:94CD C8          INY                    ;} $198D..BC = 0
$81:94CE C8          INY                    ;|
$81:94CF C0 30 00    CPY #$0030             ;|
$81:94D2 30 F6       BMI $F6    [$94CA]     ;/

$81:94D4 60          RTS
}


;;; $94D5: File select menu - index 21h: main to title sequence ;;;
{
$81:94D5 C2 30       REP #$30
$81:94D7 22 35 BA 82 JSL $82BA35[$82:BA35]  ; Draw border around SAMUS DATA
$81:94DB 20 C3 9D    JSR $9DC3  [$81:9DC3]  ; Draw file select Samus helmets
$81:94DE 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$81:94E2 A5 51       LDA $51    [$7E:0051]  ;\
$81:94E4 29 0F 00    AND #$000F             ;} If (brightness) != 0: return
$81:94E7 D0 04       BNE $04    [$94ED]     ;/
$81:94E9 5C 62 84 80 JML $808462[$80:8462]  ; Go to soft reset

$81:94ED 60          RTS
}


;;; $94EE: File select menu - index 5/13h: fade out from main ;;;
{
$81:94EE C2 30       REP #$30
$81:94F0 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
}


;;; $94F4: File select menu - index Fh/1Bh: fade out to main ;;;
{
$81:94F4 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$81:94F8 A5 57       LDA $57    [$7E:0057]  ;\
$81:94FA 29 0F FF    AND #$FF0F             ;|
$81:94FD 85 12       STA $12    [$7E:0012]  ;|
$81:94FF A5 51       LDA $51    [$7E:0051]  ;|
$81:9501 29 0F 00    AND #$000F             ;|
$81:9504 0A          ASL A                  ;|
$81:9505 0A          ASL A                  ;} (Mosaic block size) = Fh - (brightness)
$81:9506 0A          ASL A                  ;|
$81:9507 0A          ASL A                  ;|
$81:9508 49 F0 00    EOR #$00F0             ;|
$81:950B 05 12       ORA $12    [$7E:0012]  ;|
$81:950D 85 57       STA $57    [$7E:0057]  ;/
$81:950F A5 51       LDA $51    [$7E:0051]  ;\
$81:9511 29 0F 00    AND #$000F             ;} If (brightness) != 0: return
$81:9514 D0 07       BNE $07    [$951D]     ;/
$81:9516 22 6F 83 80 JSL $80836F[$80:836F]
$81:951A EE 27 07    INC $0727  [$7E:0727]  ; Increment menu index

$81:951D 60          RTS
}


;;; $951E: File select menu - index 11h/1Dh: fade in to main ;;;
{
$81:951E C2 30       REP #$30
$81:9520 AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:9523 0A          ASL A                  ;|
$81:9524 0A          ASL A                  ;} X = [file select menu selection] * 4
$81:9525 AA          TAX                    ;/
$81:9526 BD 12 A3    LDA $A312,x[$81:A312]  ;\
$81:9529 8D AB 19    STA $19AB  [$7E:19AB]  ;} Menu selection missile Y position = [$A312 + [X]]
$81:952C BD 14 A3    LDA $A314,x[$81:A314]  ;\
$81:952F 8D A1 19    STA $19A1  [$7E:19A1]  ;} Menu selection missile X position = [$A312 + [X] + 2]
}


;;; $9532: File select menu - index 7/15h: fade in from main ;;;
{
$81:9532 C2 30       REP #$30
$81:9534 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:9538 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$81:953C A5 57       LDA $57    [$7E:0057]  ;\
$81:953E 29 0F FF    AND #$FF0F             ;|
$81:9541 85 12       STA $12    [$7E:0012]  ;|
$81:9543 A5 51       LDA $51    [$7E:0051]  ;|
$81:9545 29 0F 00    AND #$000F             ;|
$81:9548 0A          ASL A                  ;|
$81:9549 0A          ASL A                  ;} (Mosaic block size) = Fh - (brightness)
$81:954A 0A          ASL A                  ;|
$81:954B 0A          ASL A                  ;|
$81:954C 49 F0 00    EOR #$00F0             ;|
$81:954F 05 12       ORA $12    [$7E:0012]  ;|
$81:9551 85 57       STA $57    [$7E:0057]  ;/
$81:9553 A5 51       LDA $51    [$7E:0051]  ;\
$81:9555 29 0F 00    AND #$000F             ;|
$81:9558 C9 0F 00    CMP #$000F             ;} If (brightness) = Fh:
$81:955B D0 03       BNE $03    [$9560]     ;/
$81:955D EE 27 07    INC $0727  [$7E:0727]  ; Increment menu index

$81:9560 60          RTS
}


;;; $9561: File select menu - index 6: main to file copy - initialise ;;;
{
$81:9561 C2 30       REP #$30
$81:9563 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 7 (fade in)
}


;;; $9566: Initialise file select menu file copy ;;;
{
$81:9566 20 A6 95    JSR $95A6  [$81:95A6]  ; Clear menu tilemap
$81:9569 A0 F8 B4    LDY #$B4F8
$81:956C A2 52 00    LDX #$0052
$81:956F 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:9572 20 E2 B3    JSR $B3E2  [$81:B3E2]  ; Load menu tilemap $B4F8 to (9, 1) (DATA COPY MODE)
$81:9575 A0 74 B5    LDY #$B574             ;\
$81:9578 A2 50 01    LDX #$0150             ;} Load menu tilemap $B574 to (8, 5) (COPY WHICH DATA?)
$81:957B 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:957E 20 B5 95    JSR $95B5  [$81:95B5]  ; Load menu exit tilemap
$81:9581 20 BE 95    JSR $95BE  [$81:95BE]  ; Draw file copy save file info
$81:9584 20 93 95    JSR $9593  [$81:9593]  ; Set initial file copy menu selection
$81:9587 20 5E 97    JSR $975E  [$81:975E]  ; Set file copy menu selection missile position
$81:958A 9C B7 19    STZ $19B7  [$7E:19B7]  ; File copy source slot = 0
$81:958D 9C B9 19    STZ $19B9  [$7E:19B9]  ; File copy destination slot = 0
$81:9590 60          RTS
}


;;; $9591: Unused. REP #$30 ;;;
{
$81:9591 C2 30       REP #$30
}


;;; $9593: Set initial file copy/clear menu selection ;;;
{
$81:9593 AD 54 09    LDA $0954  [$7E:0954]  ; A = [non-empty save slots]
$81:9596 A0 00 00    LDY #$0000             ; Y = 0

; LOOP
$81:9599 4A          LSR A                  ; A >>= 1
$81:959A B0 06       BCS $06    [$95A2]     ; If carry clear:
$81:959C C8          INY                    ; Increment Y
$81:959D C0 03 00    CPY #$0003             ; If [Y] < 3:
$81:95A0 30 F7       BMI $F7    [$9599]     ; Go to LOOP

$81:95A2 8C B5 19    STY $19B5  [$7E:19B5]  ; File copy/clear menu selection = [Y]
$81:95A5 60          RTS
}


;;; $95A6: Clear menu tilemap ;;;
{
$81:95A6 A2 FE 07    LDX #$07FE             ;\
$81:95A9 A9 0F 00    LDA #$000F             ;|
                                            ;|
$81:95AC 9F 00 36 7E STA $7E3600,x[$7E:3DFE];} $7E:3600..3DFF = 000Fh
$81:95B0 CA          DEX                    ;|
$81:95B1 CA          DEX                    ;|
$81:95B2 10 F8       BPL $F8    [$95AC]     ;/
$81:95B4 60          RTS
}


;;; $95B5: Load menu exit tilemap ;;;
{
$81:95B5 A0 EE B4    LDY #$B4EE             ;\
$81:95B8 A2 88 06    LDX #$0688             ;} Go to load menu tilemap $B574 to (4, 1Ah) (EXIT)
$81:95BB 4C E2 B3    JMP $B3E2  [$81:B3E2]  ;/
}


;;; $95BE: Draw file copy/clear save file info ;;;
{
$81:95BE A9 00 00    LDA #$0000             ;\
$81:95C1 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot A
$81:95C4 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:95C7 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:95CA 89 01 00    BIT #$0001             ;} If save slot A is empty:
$81:95CD D0 06       BNE $06    [$95D5]     ;/
$81:95CF A9 00 04    LDA #$0400             ;\
$81:95D2 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Enemy 0 palette index = 400h (palette 2)

$81:95D5 20 0F 96    JSR $960F  [$81:960F]  ; Draw file copy save slot A info
$81:95D8 A9 01 00    LDA #$0001             ;\
$81:95DB 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot B
$81:95DE 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:95E1 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:95E4 89 02 00    BIT #$0002             ;} If save slot B is empty:
$81:95E7 D0 06       BNE $06    [$95EF]     ;/
$81:95E9 A9 00 04    LDA #$0400             ;\
$81:95EC 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Enemy 0 palette index = 400h (palette 2)

$81:95EF 20 3F 96    JSR $963F  [$81:963F]  ; Draw file copy save slot B info
$81:95F2 A9 02 00    LDA #$0002             ;\
$81:95F5 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot C
$81:95F8 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:95FB AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:95FE 89 04 00    BIT #$0004             ;} If save slot C is empty:
$81:9601 D0 06       BNE $06    [$9609]     ;/
$81:9603 A9 00 04    LDA #$0400             ;\
$81:9606 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Enemy 0 palette index = 400h (palette 2)

$81:9609 20 6F 96    JSR $966F  [$81:966F]  ; Draw file copy save slot C info
$81:960C 4C 9F 96    JMP $969F  [$81:969F]  ; Go to queue transfer of menu tilemap to VRAM BG1
}


;;; $960F: Draw file copy/clear save slot A info ;;;
{
$81:960F A2 18 02    LDX #$0218             ; X = 218h (Ch, 8)
$81:9612 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9615 49 FF FF    EOR #$FFFF             ;} Clear zero if save slot A is empty, otherwise set zero
$81:9618 29 01 00    AND #$0001             ;/
$81:961B 20 87 A0    JSR $A087  [$81:A087]  ; Draw file selection health
$81:961E A2 72 02    LDX #$0272             ; X = 272h (19h, 9)
$81:9621 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9624 49 FF FF    EOR #$FFFF             ;} Clear zero if save slot A is empty, otherwise set zero
$81:9627 29 01 00    AND #$0001             ;/
$81:962A 20 4E A1    JSR $A14E  [$81:A14E]  ; Draw file selection time
$81:962D A0 A0 B4    LDY #$B4A0             ;\
$81:9630 A2 34 02    LDX #$0234             ;} Load menu tilemap $B4A0 to (1Ah, 8) (TIME)
$81:9633 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9636 A0 36 B4    LDY #$B436             ;\
$81:9639 A2 08 02    LDX #$0208             ;} Go to load menu tilemap $B436 to (4, 8) (SAMUS A)
$81:963C 4C E2 B3    JMP $B3E2  [$81:B3E2]  ;/
}


;;; $963F: Draw file copy/clear save slot B info ;;;
{
$81:963F A2 18 03    LDX #$0318             ; X = 318h (Ch, Ch)
$81:9642 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9645 49 FF FF    EOR #$FFFF             ;} Clear zero if save slot B is empty, otherwise set zero
$81:9648 29 02 00    AND #$0002             ;/
$81:964B 20 87 A0    JSR $A087  [$81:A087]  ; Draw file selection health
$81:964E A2 72 03    LDX #$0372             ; X = 372h (19h, Dh)
$81:9651 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9654 49 FF FF    EOR #$FFFF             ;} Clear zero if save slot B is empty, otherwise set zero
$81:9657 29 02 00    AND #$0002             ;/
$81:965A 20 4E A1    JSR $A14E  [$81:A14E]  ; Draw file selection time
$81:965D A0 A0 B4    LDY #$B4A0             ;\
$81:9660 A2 34 03    LDX #$0334             ;} Load menu tilemap $B4A0 to (1Ah, Ch) (TIME)
$81:9663 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9666 A0 56 B4    LDY #$B456             ;\
$81:9669 A2 08 03    LDX #$0308             ;} Go to load menu tilemap $B456 to (4, Ch) (SAMUS B)
$81:966C 4C E2 B3    JMP $B3E2  [$81:B3E2]  ;/
}


;;; $966F: Draw file copy/clear save slot C info ;;;
{
$81:966F A2 18 04    LDX #$0418             ; X = 418h (Ch, 10h)
$81:9672 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9675 49 FF FF    EOR #$FFFF             ;} Clear zero if save slot C is empty, otherwise set zero
$81:9678 29 04 00    AND #$0004             ;/
$81:967B 20 87 A0    JSR $A087  [$81:A087]  ; Draw file selection health
$81:967E A2 72 04    LDX #$0472             ; X = 472h (19h, 11h)
$81:9681 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9684 49 FF FF    EOR #$FFFF             ;} Clear zero if save slot C is empty, otherwise set zero
$81:9687 29 04 00    AND #$0004             ;/
$81:968A 20 4E A1    JSR $A14E  [$81:A14E]  ; Draw file selection time
$81:968D A0 A0 B4    LDY #$B4A0             ;\
$81:9690 A2 34 04    LDX #$0434             ;} Load menu tilemap $B4A0 to (1Ah, 10h) (TIME)
$81:9693 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9696 A0 76 B4    LDY #$B476             ;\
$81:9699 A2 08 04    LDX #$0408             ;} Go to load menu tilemap $B476 to (4, 10h) (SAMUS C)
$81:969C 4C E2 B3    JMP $B3E2  [$81:B3E2]  ;/
}


;;; $969F: Queue transfer of menu tilemap to VRAM BG1 ;;;
{
$81:969F AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:96A2 A9 00 08    LDA #$0800             ;|
$81:96A5 95 D0       STA $D0,x  [$7E:00D0]  ;|
$81:96A7 A9 00 36    LDA #$3600             ;|
$81:96AA 95 D2       STA $D2,x  [$7E:00D2]  ;|
$81:96AC A9 7E 00    LDA #$007E             ;|
$81:96AF 95 D4       STA $D4,x  [$7E:00D4]  ;|
$81:96B1 A5 58       LDA $58    [$7E:0058]  ;} Queue transfer of 800h bytes from $7E:3600 to VRAM BG1 tilemap
$81:96B3 29 FC 00    AND #$00FC             ;|
$81:96B6 EB          XBA                    ;|
$81:96B7 95 D5       STA $D5,x  [$7E:00D5]  ;|
$81:96B9 8A          TXA                    ;|
$81:96BA 18          CLC                    ;|
$81:96BB 69 07 00    ADC #$0007             ;|
$81:96BE 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:96C1 60          RTS
}


;;; $96C2: File select menu - index 8: file copy - select source ;;;
{
$81:96C2 C2 30       REP #$30
$81:96C4 22 48 BA 82 JSL $82BA48[$82:BA48]  ; Draw border around DATA COPY MODE
$81:96C8 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:96CC A5 8F       LDA $8F    [$7E:008F]  ;\
$81:96CE 89 80 10    BIT #$1080             ;} If new pressed A or start: go to BRANCH_SELECT
$81:96D1 D0 65       BNE $65    [$9738]     ;/
$81:96D3 89 00 80    BIT #$8000             ;\
$81:96D6 D0 30       BNE $30    [$9708]     ;} If newly pressed B: go to BRANCH_B
$81:96D8 89 00 08    BIT #$0800             ;\
$81:96DB D0 3D       BNE $3D    [$971A]     ;} If newly pressed up: go to BRANCH_UP
$81:96DD 89 00 04    BIT #$0400             ;\
$81:96E0 F0 7C       BEQ $7C    [$975E]     ;} If not newly pressed down: go to set file copy menu selection missile position
$81:96E2 E2 30       SEP #$30
$81:96E4 AD 54 09    LDA $0954  [$7E:0954]  ; A = [non-empty save slots]
$81:96E7 AE B5 19    LDX $19B5  [$7E:19B5]  ; X = [file copy menu selection]

; LOOP_DOWN
$81:96EA E8          INX                    ; Increment X
$81:96EB E0 04       CPX #$04               ;\
$81:96ED 10 6F       BPL $6F    [$975E]     ;} If [X] >= 4: go to set file copy menu selection missile position
$81:96EF E0 03       CPX #$03               ;\
$81:96F1 F0 05       BEQ $05    [$96F8]     ;} If [X] != 3:
$81:96F3 3C 5B 97    BIT $975B,x            ;\
$81:96F6 F0 F2       BEQ $F2    [$96EA]     ;} If [non-empty save slots] & (1 << [X]) = 0 (save slot is empty): go to LOOP_DOWN

$81:96F8 8E B5 19    STX $19B5  [$7E:19B5]  ; File copy menu selection = [X]
$81:96FB C2 30       REP #$30
$81:96FD A9 37 00    LDA #$0037             ;\
$81:9700 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9704 80 58       BRA $58    [$975E]     ; Go to set file copy menu selection missile position
$81:9706 C2 30       REP #$30               ; >_<;

; BRANCH_B
$81:9708 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:970B 18          CLC                    ;|
$81:970C 69 07 00    ADC #$0007             ;} Menu index = Fh (file copy to main)
$81:970F 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:9712 A9 37 00    LDA #$0037             ;\
$81:9715 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9719 60          RTS                    ; Return

; BRANCH_UP
$81:971A E2 30       SEP #$30
$81:971C AD 54 09    LDA $0954  [$7E:0954]  ; A = [non-empty save slots]
$81:971F AE B5 19    LDX $19B5  [$7E:19B5]  ; X = [file copy menu selection]

; LOOP_UP
$81:9722 CA          DEX                    ; Decrement X
$81:9723 30 39       BMI $39    [$975E]     ; If [X] < 0: go to set file copy menu selection missile position
$81:9725 3C 5B 97    BIT $975B,x            ;\
$81:9728 F0 F8       BEQ $F8    [$9722]     ;} If [non-empty save slots] & 1 << [X] = 0 (save slot is empty): go to LOOP_UP
$81:972A 8E B5 19    STX $19B5  [$7E:19B5]  ; File copy menu selection = [X]
$81:972D C2 30       REP #$30
$81:972F A9 37 00    LDA #$0037             ;\
$81:9732 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9736 80 26       BRA $26    [$975E]     ; Go to set file copy menu selection missile position

; BRANCH_SELECT
$81:9738 C2 30       REP #$30
$81:973A A9 37 00    LDA #$0037             ;\
$81:973D 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9741 AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:9744 C9 03 00    CMP #$0003             ;} If [file copy menu selection] != 3:
$81:9747 F0 07       BEQ $07    [$9750]     ;/
$81:9749 8D B7 19    STA $19B7  [$7E:19B7]  ; File copy source slot = [file copy menu selection]
$81:974C EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 9 (initialise select destination)
$81:974F 60          RTS                    ; Return

$81:9750 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:9753 18          CLC                    ;|
$81:9754 69 07 00    ADC #$0007             ;} Menu index = Fh (file copy to main)
$81:9757 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:975A 60          RTS

$81:975B             db 01, 02, 04
}


;;; $975E: Set file copy menu selection missile position ;;;
{
$81:975E C2 30       REP #$30
$81:9760 AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:9763 0A          ASL A                  ;|
$81:9764 AA          TAX                    ;} Menu selection missile Y position = [$9772 + [file copy menu selection] * 2]
$81:9765 BD 72 97    LDA $9772,x            ;|
$81:9768 8D AB 19    STA $19AB  [$7E:19AB]  ;/
$81:976B A9 16 00    LDA #$0016             ;\
$81:976E 8D A1 19    STA $19A1  [$7E:19A1]  ;} Menu selection missile X position = 16h
$81:9771 60          RTS

$81:9772             dw 0048, 0068, 0088, 00D3
}


;;; $977A: File select menu - index 9: file copy - initialise select destination ;;;
{
$81:977A C2 30       REP #$30
$81:977C 22 48 BA 82 JSL $82BA48[$82:BA48]  ; Draw border around DATA COPY MODE
$81:9780 20 99 97    JSR $9799  [$81:9799]  ; Draw file copy select destination save file info
$81:9783 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = Ah (select destination)
$81:9786 A9 00 00    LDA #$0000             ; A = 0

; LOOP
$81:9789 CD B7 19    CMP $19B7  [$7E:19B7]  ;\
$81:978C D0 06       BNE $06    [$9794]     ;} If [A] = [file copy source slot]:
$81:978E 1A          INC A                  ; Increment A
$81:978F C9 03 00    CMP #$0003             ;\
$81:9792 30 F5       BMI $F5    [$9789]     ;} If [A] < 3: go to LOOP

$81:9794 8D B5 19    STA $19B5  [$7E:19B5]  ; File copy menu selection = [A]
$81:9797 80 C5       BRA $C5    [$975E]     ; Go to set file copy menu selection missile position
}


;;; $9799: Draw file copy select destination save file info ;;;
{
$81:9799 20 A6 95    JSR $95A6  [$81:95A6]  ; Clear menu tilemap
$81:979C A0 F8 B4    LDY #$B4F8
$81:979F A2 52 00    LDX #$0052
$81:97A2 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:97A5 20 E2 B3    JSR $B3E2  [$81:B3E2]  ; Load menu tilemap $B4F8 to (9, 1) (DATA COPY MODE)
$81:97A8 A0 96 B5    LDY #$B596             ;\
$81:97AB A2 48 01    LDX #$0148             ;|
$81:97AE 9C 96 0F    STZ $0F96  [$7E:0F96]  ;} Load menu tilemap $B596 to (4, 5) (COPY (SAMUS  ) TO WHERE?)
$81:97B1 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:97B4 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:97B7 18          CLC                    ;|
$81:97B8 69 6A 20    ADC #$206A             ;} Menu tilemap tile (10h, 5) = 206Ah + [file copy source slot] (tile A/B/C)
$81:97BB 8F 60 37 7E STA $7E3760[$7E:3760]  ;/
$81:97BF 20 B5 95    JSR $95B5  [$81:95B5]  ; Load menu exit tilemap
$81:97C2 A9 00 00    LDA #$0000             ;\
$81:97C5 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot A
$81:97C8 A2 00 04    LDX #$0400             ; X = 400h (palette 2)
$81:97CB AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:97CE F0 03       BEQ $03    [$97D3]     ;} If [file copy source slot] != 0:
$81:97D0 A2 00 00    LDX #$0000             ; X = 0 (palette 0)

$81:97D3 8A          TXA                    ;\
$81:97D4 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Enemy 0 palette index = [X]
$81:97D7 20 0F 96    JSR $960F  [$81:960F]  ; Draw file copy save slot A info
$81:97DA A9 01 00    LDA #$0001             ;\
$81:97DD 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot B
$81:97E0 A2 00 04    LDX #$0400             ; X = 400h (palette 2)
$81:97E3 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:97E6 C9 01 00    CMP #$0001             ;} If [file copy source slot] != 1:
$81:97E9 F0 03       BEQ $03    [$97EE]     ;/
$81:97EB A2 00 00    LDX #$0000             ; X = 0 (palette 0)

$81:97EE 8A          TXA                    ;\
$81:97EF 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Enemy 0 palette index = [X]
$81:97F2 20 3F 96    JSR $963F  [$81:963F]  ; Draw file copy save slot B info
$81:97F5 A9 02 00    LDA #$0002             ;\
$81:97F8 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot C
$81:97FB A2 00 04    LDX #$0400             ; X = 400h (palette 2)
$81:97FE AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:9801 C9 02 00    CMP #$0002             ;} If [file copy source slot] != 2:
$81:9804 F0 03       BEQ $03    [$9809]     ;/
$81:9806 A2 00 00    LDX #$0000             ; X = 0 (palette 0)

$81:9809 8A          TXA                    ;\
$81:980A 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Enemy 0 palette index = [X]
$81:980D 20 6F 96    JSR $966F  [$81:966F]  ; Draw file copy save slot C info
$81:9810 4C 9F 96    JMP $969F  [$81:969F]  ; Go to queue transfer of menu tilemap to VRAM BG1
}


;;; $9813: File select menu - index Ah: file copy - select destination ;;;
{
$81:9813 C2 30       REP #$30
$81:9815 22 48 BA 82 JSL $82BA48[$82:BA48]  ; Draw border around DATA COPY MODE
$81:9819 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:981D A5 8F       LDA $8F    [$7E:008F]  ;\
$81:981F 89 80 10    BIT #$1080             ;} If new pressed A or start: go to BRANCH_SELECT
$81:9822 D0 55       BNE $55    [$9879]     ;/
$81:9824 89 00 80    BIT #$8000             ;\
$81:9827 D0 36       BNE $36    [$985F]     ;} If newly pressed B: go to BRANCH_B
$81:9829 89 00 08    BIT #$0800             ;\
$81:982C D0 6D       BNE $6D    [$989B]     ;} If newly pressed up: go to BRANCH_UP
$81:982E 89 00 04    BIT #$0400             ;\
$81:9831 F0 1A       BEQ $1A    [$984D]     ;} If not newly pressed down: go to BRANCH_SET_MISSILE_POSITION
$81:9833 A9 37 00    LDA #$0037             ;\
$81:9836 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:983A AE B5 19    LDX $19B5  [$7E:19B5]  ; X = [file copy menu selection]

; LOOP_DOWN
$81:983D E8          INX                    ; Increment X
$81:983E E0 04 00    CPX #$0004             ;\
$81:9841 F0 0A       BEQ $0A    [$984D]     ;} If [X] = 4: go to BRANCH_SET_MISSILE_POSITION
$81:9843 EC B7 19    CPX $19B7  [$7E:19B7]  ;\
$81:9846 D0 02       BNE $02    [$984A]     ;} If [X] != [file copy source slot]: go to BRANCH_SET_MENU_SELECTION
$81:9848 80 F3       BRA $F3    [$983D]     ; Go to LOOP_DOWN

; BRANCH_SET_MENU_SELECTION
$81:984A 8E B5 19    STX $19B5  [$7E:19B5]  ; File copy menu selection = [X]

; BRANCH_SET_MISSILE_POSITION
$81:984D AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:9850 0A          ASL A                  ;|
$81:9851 AA          TAX                    ;} Menu selection missile Y position = [$98AF + [file copy menu selection] * 2]
$81:9852 BD AF 98    LDA $98AF,x            ;|
$81:9855 8D AB 19    STA $19AB  [$7E:19AB]  ;/
$81:9858 A9 16 00    LDA #$0016             ;\
$81:985B 8D A1 19    STA $19A1  [$7E:19A1]  ;} Menu selection missile X position = 16h
$81:985E 60          RTS                    ; Return

; BRANCH_B
$81:985F AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:9862 38          SEC                    ;|
$81:9863 E9 02 00    SBC #$0002             ;} Menu index = 8 (select source)
$81:9866 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:9869 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:986C 8D B5 19    STA $19B5  [$7E:19B5]  ;} File copy menu selection = [file copy source slot]
$81:986F A9 37 00    LDA #$0037             ;\
$81:9872 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9876 4C 66 95    JMP $9566  [$81:9566]  ; Go to initialise file select menu file copy

; BRANCH_SELECT
$81:9879 A9 37 00    LDA #$0037             ;\
$81:987C 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9880 AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:9883 C9 03 00    CMP #$0003             ;} If [file copy menu selection] != 3:
$81:9886 F0 08       BEQ $08    [$9890]     ;/
$81:9888 8D B9 19    STA $19B9  [$7E:19B9]  ; File copy destination slot = [file copy menu selection]
$81:988B EE 27 07    INC $0727  [$7E:0727]  ; Menu index = Bh (initialise confirmation)
$81:988E 80 BD       BRA $BD    [$984D]     ; Go to BRANCH_SET_MISSILE_POSITION

$81:9890 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:9893 18          CLC                    ;|
$81:9894 69 05 00    ADC #$0005             ;} Menu index = Fh (file copy to main)
$81:9897 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:989A 60          RTS                    ; Return

; BRANCH_UP
$81:989B A9 37 00    LDA #$0037             ;\
$81:989E 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:98A2 AE B5 19    LDX $19B5  [$7E:19B5]  ; X = [file copy menu selection]

; LOOP_UP
$81:98A5 CA          DEX                    ; Decrement X
$81:98A6 30 A5       BMI $A5    [$984D]     ; If [X] < 0: go to BRANCH_SET_MISSILE_POSITION
$81:98A8 EC B7 19    CPX $19B7  [$7E:19B7]  ;\
$81:98AB D0 9D       BNE $9D    [$984A]     ;} If [X] != [file copy source slot]: go to BRANCH_SET_MENU_SELECTION
$81:98AD 80 F6       BRA $F6    [$98A5]     ; Go to LOOP_UP

$81:98AF             dw 0048, 0068, 0088, 00D4
}


;;; $98B7: File select menu - index Bh: file copy - initialise confirmation ;;;
{
$81:98B7 22 48 BA 82 JSL $82BA48[$82:BA48]  ; Draw border around DATA COPY MODE
$81:98BB A0 C8 B5    LDY #$B5C8
$81:98BE A2 44 01    LDX #$0144
$81:98C1 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:98C4 20 E2 B3    JSR $B3E2  [$81:B3E2]  ; Load menu tilemap $B5C8 to (2, 5) (COPY (SAMUS  ) TO (SAMUS  ).)
$81:98C7 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:98CA 18          CLC                    ;|
$81:98CB 69 6A 20    ADC #$206A             ;} Menu tilemap tile (Eh, 5) = 206Ah + [file copy source slot] (tile A/B/C)
$81:98CE 8F 5C 37 7E STA $7E375C[$7E:375C]  ;/
$81:98D2 AD B9 19    LDA $19B9  [$7E:19B9]  ;\
$81:98D5 18          CLC                    ;|
$81:98D6 69 6A 20    ADC #$206A             ;} Menu tilemap tile (1Bh, 5) = 206Ah + [file copy destination slot] (tile A/B/C)
$81:98D9 8F 76 37 7E STA $7E3776[$7E:3776]  ;/
$81:98DD 20 ED 98    JSR $98ED  [$81:98ED]  ; Draw file copy confirmation
$81:98E0 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = Ch (confirmation)
$81:98E3 9C B5 19    STZ $19B5  [$7E:19B5]  ; File copy menu selection = 0
$81:98E6 A9 08 00    LDA #$0008             ;\
$81:98E9 8D 8F 19    STA $198F  [$7E:198F]  ;} File copy arrow palette timer = 8
$81:98EC 60          RTS
}


;;; $98ED: Draw file copy/clear confirmation ;;;
{
$81:98ED A0 02 B6    LDY #$B602
$81:98F0 A2 14 05    LDX #$0514
$81:98F3 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:98F6 20 E2 B3    JSR $B3E2  [$81:B3E2]  ; Load menu tilemap $B602 to (Ah, 14h) (IS THIS OK?)
$81:98F9 A0 1A B6    LDY #$B61A             ;\
$81:98FC A2 9C 05    LDX #$059C             ;|
$81:98FF 9C 96 0F    STZ $0F96  [$7E:0F96]  ;} Load menu tilemap $B61A to (Eh, 16h) (YES)
$81:9902 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9905 A2 80 06    LDX #$0680             ;\
$81:9908 A9 0F 00    LDA #$000F             ;|
                                            ;|
$81:990B 9F 00 36 7E STA $7E3600,x[$7E:3C80];|
$81:990F E8          INX                    ;} Menu tilemap row 1Ah = 000Fh
$81:9910 E8          INX                    ;|
$81:9911 E0 C0 06    CPX #$06C0             ;|
$81:9914 30 F5       BMI $F5    [$990B]     ;/
$81:9916 A0 2A B6    LDY #$B62A             ;\
$81:9919 A2 5C 06    LDX #$065C             ;|
$81:991C 9C 96 0F    STZ $0F96  [$7E:0F96]  ;} Load menu tilemap $B62A to (Eh, 19h) (N O)
$81:991F 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
}


;;; $9922: Draw file copy/clear confirmation save file info ;;;
{
$81:9922 A9 00 00    LDA #$0000             ;\
$81:9925 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot A
$81:9928 A2 00 00    LDX #$0000             ; X = 0 (palette 0)
$81:992B AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:992E F0 08       BEQ $08    [$9938]     ;} If [file copy source slot] != 0:
$81:9930 AD B9 19    LDA $19B9  [$7E:19B9]  ;\
$81:9933 F0 03       BEQ $03    [$9938]     ;} If [file copy destination slot] != 0:
$81:9935 A2 00 04    LDX #$0400             ; X = 400h (palette 2)

$81:9938 8A          TXA                    ;\
$81:9939 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Enemy 0 palette index = [X]
$81:993C 20 0F 96    JSR $960F  [$81:960F]  ; Draw file copy save slot A info
$81:993F A9 01 00    LDA #$0001             ;\
$81:9942 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot B
$81:9945 A2 00 00    LDX #$0000             ; X = 0 (palette 0)
$81:9948 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:994B 3A          DEC A                  ;} If [file copy source slot] != 1:
$81:994C F0 09       BEQ $09    [$9957]     ;/
$81:994E AD B9 19    LDA $19B9  [$7E:19B9]  ;\
$81:9951 3A          DEC A                  ;} If [file copy destination slot] != 1:
$81:9952 F0 03       BEQ $03    [$9957]     ;/
$81:9954 A2 00 04    LDX #$0400             ; X = 400h (palette 2)

$81:9957 8A          TXA                    ;\
$81:9958 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Enemy 0 palette index = [X]
$81:995B 20 3F 96    JSR $963F  [$81:963F]  ; Draw file copy save slot B info
$81:995E A9 02 00    LDA #$0002             ;\
$81:9961 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot C
$81:9964 A2 00 00    LDX #$0000             ; X = 0 (palette 0)
$81:9967 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:996A C9 02 00    CMP #$0002             ;} If [file copy source slot] != 2:
$81:996D F0 0B       BEQ $0B    [$997A]     ;/
$81:996F AD B9 19    LDA $19B9  [$7E:19B9]  ;\
$81:9972 C9 02 00    CMP #$0002             ;} If [file copy destination slot] != 2:
$81:9975 F0 03       BEQ $03    [$997A]     ;/
$81:9977 A2 00 04    LDX #$0400             ; X = 400h (palette 2)

$81:997A 8A          TXA                    ;\
$81:997B 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Enemy 0 palette index = [X]
$81:997E 20 6F 96    JSR $966F  [$81:966F]  ; Draw file copy save slot C info
$81:9981 4C 9F 96    JMP $969F  [$81:969F]  ; Go to queue transfer of menu tilemap to VRAM BG1
}


;;; $9984: File select menu - index Ch: file copy - confirmation ;;;
{
$81:9984 22 48 BA 82 JSL $82BA48[$82:BA48]  ; Draw border around DATA COPY MODE
$81:9988 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:998C 20 FE 99    JSR $99FE  [$81:99FE]  ; Handle file copy arrow palette
$81:998F 22 BA BA 82 JSL $82BABA[$82:BABA]  ; Draw file copy arrow
$81:9993 A5 8F       LDA $8F    [$7E:008F]  ;\
$81:9995 89 00 0C    BIT #$0C00             ;} If newly pressed up or down: go to BRANCH_TOGGLE
$81:9998 D0 3F       BNE $3F    [$99D9]     ;/
$81:999A 89 00 80    BIT #$8000             ;\
$81:999D D0 1E       BNE $1E    [$99BD]     ;} If newly pressed B: go to BRANCH_B
$81:999F 89 80 10    BIT #$1080             ;\
$81:99A2 F0 45       BEQ $45    [$99E9]     ;} If not newly pressed A or start: go to BRANCH_SET_MISSILE_POSITION
$81:99A4 A9 38 00    LDA #$0038             ;\
$81:99A7 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$81:99AB AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:99AE F0 25       BEQ $25    [$99D5]     ;} If [file copy menu selection] = 0: go to BRANCH_YES
$81:99B0 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:99B3 38          SEC                    ;|
$81:99B4 E9 04 00    SBC #$0004             ;} Menu index = 8 (select source)
$81:99B7 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:99BA 4C 66 95    JMP $9566  [$81:9566]  ; Go to initialise file select menu file copy

; BRANCH_B
$81:99BD AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:99C0 38          SEC                    ;|
$81:99C1 E9 03 00    SBC #$0003             ;} Menu index = 9 (initialise select destination)
$81:99C4 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:99C7 AD B9 19    LDA $19B9  [$7E:19B9]  ;\
$81:99CA 8D B5 19    STA $19B5  [$7E:19B5]  ;} File copy menu selection = [file copy destination slot]
$81:99CD A9 37 00    LDA #$0037             ;\
$81:99D0 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:99D4 60          RTS                    ; Return

; BRANCH_YES
$81:99D5 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = Dh (do file copy)
$81:99D8 60          RTS                    ; Return

; BRANCH_TOGGLE
$81:99D9 AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:99DC 49 01 00    EOR #$0001             ;} File copy menu selection ^= 1
$81:99DF 8D B5 19    STA $19B5  [$7E:19B5]  ;/
$81:99E2 A9 37 00    LDA #$0037             ;\
$81:99E5 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)

; BRANCH_SET_MISSILE_POSITION
$81:99E9 A0 B8 00    LDY #$00B8             ; Menu selection missile Y position = B8h
$81:99EC AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:99EF F0 03       BEQ $03    [$99F4]     ;} If [file copy menu selection] != 0:
$81:99F1 A0 D0 00    LDY #$00D0             ; Menu selection missile Y position = D0h

$81:99F4 8C AB 19    STY $19AB  [$7E:19AB]
$81:99F7 A9 5E 00    LDA #$005E             ;\
$81:99FA 8D A1 19    STA $19A1  [$7E:19A1]  ;} Menu selection missile X position = 5Eh
$81:99FD 60          RTS
}


;;; $99FE: Handle file copy arrow palette ;;;
{
$81:99FE AD 8F 19    LDA $198F  [$7E:198F]  ;\
$81:9A01 F0 28       BEQ $28    [$9A2B]     ;} If [file copy arrow palette timer] = 0: return
$81:9A03 3A          DEC A                  ;\
$81:9A04 8D 8F 19    STA $198F  [$7E:198F]  ;} Decrement file copy arrow palette timer
$81:9A07 D0 22       BNE $22    [$9A2B]     ; If [file copy arrow palette timer] != 0: return
$81:9A09 A9 04 00    LDA #$0004             ;\
$81:9A0C 8D 8F 19    STA $198F  [$7E:198F]  ;} File copy arrow palette timer = 4
$81:9A0F AF 22 C1 7E LDA $7EC122[$7E:C122]  ;\
$81:9A13 A8          TAY                    ;} Y = [sprite palette 1 colour 1]
$81:9A14 A2 00 00    LDX #$0000             ;\
                                            ;|
$81:9A17 BF 24 C1 7E LDA $7EC124,x          ;|
$81:9A1B 9F 22 C1 7E STA $7EC122,x          ;|
$81:9A1F E8          INX                    ;} Sprite palette 1 colours 1..6 = [sprite palette 1 colours 2..7]
$81:9A20 E8          INX                    ;|
$81:9A21 E0 0C 00    CPX #$000C             ;|
$81:9A24 30 F1       BMI $F1    [$9A17]     ;/
$81:9A26 98          TYA                    ;\
$81:9A27 8F 2E C1 7E STA $7EC12E[$7E:C12E]  ;} Sprite palette 1 colour 7 = [Y]

$81:9A2B 60          RTS
}


;;; $9A2C: File select menu - index Dh: file copy - do file copy ;;;
{
$81:9A2C 22 48 BA 82 JSL $82BA48[$82:BA48]  ; Draw border around DATA COPY MODE
$81:9A30 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:9A34 20 FE 99    JSR $99FE  [$81:99FE]  ; Handle file copy arrow palette
$81:9A37 22 BA BA 82 JSL $82BABA[$82:BABA]  ; Draw file copy arrow
$81:9A3B A9 70 00    LDA #$0070             ;\
$81:9A3E 85 02       STA $02    [$7E:0002]  ;} $02 = $70 (source bank)
$81:9A40 85 05       STA $05    [$7E:0005]  ; $05 = $70 (destination bank)
$81:9A42 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:9A45 0A          ASL A                  ;|
$81:9A46 AA          TAX                    ;} $00 = [$81:812B + [file copy source slot] * 2] (SRAM offset)
$81:9A47 BF 2B 81 81 LDA $81812B,x          ;|
$81:9A4B 85 00       STA $00    [$7E:0000]  ;/
$81:9A4D AD B9 19    LDA $19B9  [$7E:19B9]  ;\
$81:9A50 0A          ASL A                  ;|
$81:9A51 AA          TAX                    ;} $03 = [$81:812B + [file copy destination slot] * 2] (SRAM offset)
$81:9A52 BF 2B 81 81 LDA $81812B,x          ;|
$81:9A56 85 03       STA $03    [$7E:0003]  ;/
$81:9A58 A0 00 00    LDY #$0000             ;\
                                            ;|
$81:9A5B B7 00       LDA [$00],y            ;|
$81:9A5D 97 03       STA [$03],y            ;|
$81:9A5F C8          INY                    ;} Copy 65Ch bytes from [$00] to [$03]
$81:9A60 C8          INY                    ;|
$81:9A61 C0 5C 06    CPY #$065C             ;|
$81:9A64 30 F5       BMI $F5    [$9A5B]     ;/
$81:9A66 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:9A69 0A          ASL A                  ;|
$81:9A6A AA          TAX                    ;|
$81:9A6B BF F0 1F 70 LDA $701FF0,x          ;|
$81:9A6F 48          PHA                    ;} $70:1FF0 + [file copy destination slot] * 2 = [$70:1FF0 + [file copy source slot] * 2]
$81:9A70 BF F8 1F 70 LDA $701FF8,x          ; \
$81:9A74 48          PHA                    ; } $70:1FF8 + [file copy destination slot] * 2 = [$70:1FF8 + [file copy source slot] * 2]
$81:9A75 BF 00 00 70 LDA $700000,x          ;  \
$81:9A79 48          PHA                    ;  } $70:0000 + [file copy destination slot] * 2 = [$70:0000 + [file copy source slot] * 2]
$81:9A7A BF 08 00 70 LDA $700008,x          ;   \
$81:9A7E 48          PHA                    ;   |
$81:9A7F AD B9 19    LDA $19B9  [$7E:19B9]  ;   |
$81:9A82 0A          ASL A                  ;   } $70:0008 + [file copy destination slot] * 2 = [$70:0008 + [file copy source slot] * 2]
$81:9A83 AA          TAX                    ;   |
$81:9A84 68          PLA                    ;   |
$81:9A85 9F 08 00 70 STA $700008,x          ;   /
$81:9A89 68          PLA                    ;  |
$81:9A8A 9F 00 00 70 STA $700000,x          ;  /
$81:9A8E 68          PLA                    ; |
$81:9A8F 9F F8 1F 70 STA $701FF8,x          ; /
$81:9A93 68          PLA                    ;|
$81:9A94 9F F0 1F 70 STA $701FF0,x          ;/
$81:9A98 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = Eh (copy completed)
$81:9A9B A2 00 05    LDX #$0500             ;\
$81:9A9E A9 0F 00    LDA #$000F             ;|
                                            ;|
$81:9AA1 9F 00 36 7E STA $7E3600,x          ;|
$81:9AA5 E8          INX                    ;} Menu tilemap rows 14h..1Ch = 000Fh
$81:9AA6 E8          INX                    ;|
$81:9AA7 E0 40 07    CPX #$0740             ;|
$81:9AAA 30 F5       BMI $F5    [$9AA1]     ;/
$81:9AAC AD B9 19    LDA $19B9  [$7E:19B9]  ;\
$81:9AAF 0A          ASL A                  ;|
$81:9AB0 AA          TAX                    ;|
$81:9AB1 AD 54 09    LDA $0954  [$7E:0954]  ;} Non-empty save slots |= 1 << [file copy destination slot]
$81:9AB4 1D F4 9A    ORA $9AF4,x            ;|
$81:9AB7 8D 54 09    STA $0954  [$7E:0954]  ;/
$81:9ABA AD B9 19    LDA $19B9  [$7E:19B9]  ;\
$81:9ABD 0A          ASL A                  ;} A = [file copy destination slot] * 4
$81:9ABE 0A          ASL A                  ;/
$81:9ABF 18          CLC                    ;\
$81:9AC0 69 09 00    ADC #$0009             ;|
$81:9AC3 0A          ASL A                  ;|
$81:9AC4 0A          ASL A                  ;|
$81:9AC5 0A          ASL A                  ;|
$81:9AC6 0A          ASL A                  ;|
$81:9AC7 0A          ASL A                  ;|
$81:9AC8 0A          ASL A                  ;|
$81:9AC9 18          CLC                    ;|
$81:9ACA 69 18 00    ADC #$0018             ;|
$81:9ACD AA          TAX                    ;|
$81:9ACE A0 00 00    LDY #$0000             ;} Menu tilemap rows (8 + [A]) .. (9 + [A]) columns Ch..16h = 000Fh
$81:9AD1 A9 0F 00    LDA #$000F             ;|
                                            ;|
$81:9AD4 9F 00 36 7E STA $7E3600,x          ;|
$81:9AD8 9F C0 35 7E STA $7E35C0,x          ;|
$81:9ADC E8          INX                    ;|
$81:9ADD E8          INX                    ;|
$81:9ADE C8          INY                    ;|
$81:9ADF C8          INY                    ;|
$81:9AE0 C0 16 00    CPY #$0016             ;|
$81:9AE3 30 EF       BMI $EF    [$9AD4]     ;/
$81:9AE5 A0 3A B6    LDY #$B63A
$81:9AE8 A2 10 05    LDX #$0510
$81:9AEB 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:9AEE 20 E2 B3    JSR $B3E2  [$81:B3E2]  ; Load menu tilemap $B63A to (8, 14h) (COPY COMPLETED.)
$81:9AF1 4C 22 99    JMP $9922  [$81:9922]  ; Go to draw file copy confirmation save file info

$81:9AF4             dw 0001, 0002, 0004
}


;;; $9AFA: File select menu - index Eh: file copy - copy completed ;;;
{
$81:9AFA 22 48 BA 82 JSL $82BA48[$82:BA48]  ; Draw border around DATA COPY MODE
$81:9AFE A5 8F       LDA $8F    [$7E:008F]  ;\
$81:9B00 F0 25       BEQ $25    [$9B27]     ;} If not newly pressed anything: return
$81:9B02 A9 37 00    LDA #$0037             ;\
$81:9B05 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9B09 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = Fh (file copy to main)
$81:9B0C AF EC 1F 70 LDA $701FEC[$70:1FEC]  ;\
$81:9B10 C9 00 00    CMP #$0000             ;|
$81:9B13 30 0C       BMI $0C    [$9B21]     ;} If 0 <= [SRAM save slot selected] < 3:
$81:9B15 C9 03 00    CMP #$0003             ;|
$81:9B18 10 07       BPL $07    [$9B21]     ;/
$81:9B1A AA          TAX                    ; X = [SRAM save slot selected]
$81:9B1B 2F EE 1F 70 AND $701FEE[$70:1FEE]  ;\
$81:9B1F F0 03       BEQ $03    [$9B24]     ;} If [SRAM save slot selected] & [SRAM save slot selected complement] = 0: go to BRANCH_VALID_SAVE_SLOT

$81:9B21 A2 00 00    LDX #$0000             ; X = 0

; BRANCH_VALID_SAVE_SLOT
$81:9B24 8E 52 09    STX $0952  [$7E:0952]  ; Save slot selected = [X]

$81:9B27 60          RTS
}


;;; $9B28: File select menu - index 12h: file copy to main - menu index = main ;;;
{
$81:9B28 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:9B2B 38          SEC                    ;|
$81:9B2C E9 0E 00    SBC #$000E             ;} Menu index = 4 (main)
$81:9B2F 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:9B32 60          RTS
}


;;; $9B33: File select menu - index 14h: main to file clear - initialise ;;;
{
$81:9B33 C2 30       REP #$30
$81:9B35 22 5B BA 82 JSL $82BA5B[$82:BA5B]  ; Draw border around DATA CLEAR MODE
$81:9B39 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 15h (fade in)
}


;;; $9B3C: Initialise file select menu file clear ;;;
{
$81:9B3C 20 A6 95    JSR $95A6  [$81:95A6]  ; Clear menu tilemap
$81:9B3F A0 34 B5    LDY #$B534
$81:9B42 A2 50 00    LDX #$0050
$81:9B45 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:9B48 20 E2 B3    JSR $B3E2  [$81:B3E2]  ; Load menu tilemap $B534 to (8, 1) (DATA CLEAR MODE)
$81:9B4B A0 5A B6    LDY #$B65A             ;\
$81:9B4E A2 40 01    LDX #$0140             ;} Load menu tilemap $B65A to (0, 5) (       CLEAR WHICH DATA?)
$81:9B51 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9B54 20 B5 95    JSR $95B5  [$81:95B5]  ; Load menu exit tilemap
$81:9B57 20 BE 95    JSR $95BE  [$81:95BE]  ; Draw file clear save file info
$81:9B5A 9C B7 19    STZ $19B7  [$7E:19B7]  ; File clear slot = 0
$81:9B5D 20 93 95    JSR $9593  [$81:9593]  ; Set initial file clear menu selection
$81:9B60 20 EF 9B    JSR $9BEF  [$81:9BEF]  ; Set file clear menu selection missile position
$81:9B63 60          RTS
}


;;; $9B64: File select menu - index 16h: file clear - select slot ;;;
{
$81:9B64 C2 30       REP #$30
$81:9B66 22 5B BA 82 JSL $82BA5B[$82:BA5B]  ; Draw border around DATA CLEAR MODE
$81:9B6A 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:9B6E A5 8F       LDA $8F    [$7E:008F]  ;\
$81:9B70 89 80 10    BIT #$1080             ;} If new pressed A or start: go to BRANCH_SELECT
$81:9B73 D0 5F       BNE $5F    [$9BD4]     ;/
$81:9B75 89 00 80    BIT #$8000             ;\
$81:9B78 D0 2B       BNE $2B    [$9BA5]     ;} If newly pressed B: go to BRANCH_EXIT
$81:9B7A 89 00 08    BIT #$0800             ;\
$81:9B7D D0 3A       BNE $3A    [$9BB9]     ;} If newly pressed up: go to BRANCH_UP
$81:9B7F 89 00 04    BIT #$0400             ;\
$81:9B82 F0 6B       BEQ $6B    [$9BEF]     ;} If not newly pressed down: go to set file clear menu selection missile position
$81:9B84 E2 30       SEP #$30
$81:9B86 AD 54 09    LDA $0954  [$7E:0954]  ; A = [non-empty save slots]
$81:9B89 AE B5 19    LDX $19B5  [$7E:19B5]  ; X = [file clear menu selection]

; LOOP_DOWN
$81:9B8C E8          INX                    ; Increment X
$81:9B8D E0 04       CPX #$04               ;\
$81:9B8F 10 5E       BPL $5E    [$9BEF]     ;} If [X] >= 4: go to set file clear menu selection missile position
$81:9B91 E0 03       CPX #$03               ;\
$81:9B93 F0 05       BEQ $05    [$9B9A]     ;} If [X] != 3:
$81:9B95 3C EC 9B    BIT $9BEC,x            ;\
$81:9B98 F0 F2       BEQ $F2    [$9B8C]     ;} If [non-empty save slots] & (1 << [X]) = 0 (save slot is empty): go to LOOP_DOWN

$81:9B9A 8E B5 19    STX $19B5  [$7E:19B5]  ; File clear menu selection = [X]
$81:9B9D A9 37       LDA #$37               ;\
$81:9B9F 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9BA3 80 4A       BRA $4A    [$9BEF]     ; Go to set file clear menu selection missile position

; BRANCH_EXIT
$81:9BA5 C2 30       REP #$30
$81:9BA7 A9 37 00    LDA #$0037             ;\
$81:9BAA 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9BAE AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:9BB1 18          CLC                    ;|
$81:9BB2 69 05 00    ADC #$0005             ;} Menu index = 1Bh (file clear to main)
$81:9BB5 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:9BB8 60          RTS                    ; Return

; BRANCH_UP
$81:9BB9 E2 30       SEP #$30
$81:9BBB AD 54 09    LDA $0954  [$7E:0954]  ; A = [non-empty save slots]
$81:9BBE AE B5 19    LDX $19B5  [$7E:19B5]  ; X = [file clear menu selection]

; LOOP_UP
$81:9BC1 CA          DEX                    ; Decrement X
$81:9BC2 30 2B       BMI $2B    [$9BEF]     ; If [X] < 0: go to set file clear menu selection missile position
$81:9BC4 3C EC 9B    BIT $9BEC,x            ;\
$81:9BC7 F0 F8       BEQ $F8    [$9BC1]     ;} If [non-empty save slots] & 1 << [X] = 0 (save slot is empty): go to LOOP_UP
$81:9BC9 8E B5 19    STX $19B5  [$7E:19B5]  ; File clear menu selection = [X]
$81:9BCC A9 37       LDA #$37               ;\
$81:9BCE 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9BD2 80 1B       BRA $1B    [$9BEF]     ; Go to set file clear menu selection missile position

; BRANCH_SELECT
$81:9BD4 C2 30       REP #$30
$81:9BD6 A9 37 00    LDA #$0037             ;\
$81:9BD9 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9BDD AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:9BE0 C9 03 00    CMP #$0003             ;} If [file clear menu selection] = 3: go to BRANCH_EXIT
$81:9BE3 F0 C0       BEQ $C0    [$9BA5]     ;/
$81:9BE5 8D B7 19    STA $19B7  [$7E:19B7]  ; File clear slot = [file clear menu selection]
$81:9BE8 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 17h (initialise confirmation)
$81:9BEB 60          RTS

$81:9BEC             db 01, 02, 04
}


;;; $9BEF: Set file clear menu selection missile position ;;;
{
$81:9BEF C2 30       REP #$30
$81:9BF1 AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:9BF4 0A          ASL A                  ;|
$81:9BF5 AA          TAX                    ;} Menu selection missile Y position = [$9C03 + [file clear menu selection] * 2]
$81:9BF6 BD 03 9C    LDA $9C03,x[$81:9C03]  ;|
$81:9BF9 8D AB 19    STA $19AB  [$7E:19AB]  ;/
$81:9BFC A9 16 00    LDA #$0016             ;\
$81:9BFF 8D A1 19    STA $19A1  [$7E:19A1]  ;} Menu selection missile X position = 16h
$81:9C02 60          RTS

$81:9C03             dw 0048, 0068, 0088, 00D3
}


;;; $9C0B: File select menu - index 17h: file clear - initialise confirmation ;;;
{
$81:9C0B 22 5B BA 82 JSL $82BA5B[$82:BA5B]  ; Draw border around DATA CLEAR MODE
$81:9C0F A0 9A B6    LDY #$B69A
$81:9C12 A2 40 01    LDX #$0140
$81:9C15 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:9C18 20 E2 B3    JSR $B3E2  [$81:B3E2]  ; Load menu tilemap $B69A to (0, 5) (        CLEAR (SAMUS A).)
$81:9C1B AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:9C1E 18          CLC                    ;|
$81:9C1F 69 6A 20    ADC #$206A             ;} Menu tilemap tile (15h, 5) = 206Ah + [file clear slot] (tile A/B/C)
$81:9C22 8F 6A 37 7E STA $7E376A[$7E:376A]  ;/
$81:9C26 A9 03 00    LDA #$0003             ;\
$81:9C29 8D B9 19    STA $19B9  [$7E:19B9]  ;} $19B9 = 3
$81:9C2C 20 ED 98    JSR $98ED  [$81:98ED]  ; Draw file clear confirmation
$81:9C2F EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 18h (confirmation)
$81:9C32 9C B5 19    STZ $19B5  [$7E:19B5]  ; File clear menu selection = 0
$81:9C35 60          RTS
}


;;; $9C36: File select menu - index 18h: file clear - confirmation ;;;
{
$81:9C36 22 5B BA 82 JSL $82BA5B[$82:BA5B]  ; Draw border around DATA CLEAR MODE
$81:9C3A 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:9C3E A5 8F       LDA $8F    [$7E:008F]  ;\
$81:9C40 89 00 0C    BIT #$0C00             ;} If newly pressed up or down: go to BRANCH_TOGGLE
$81:9C43 D0 34       BNE $34    [$9C79]     ;/
$81:9C45 89 00 80    BIT #$8000             ;\
$81:9C48 D0 11       BNE $11    [$9C5B]     ;} If newly pressed B: go to BRANCH_B
$81:9C4A 89 80 10    BIT #$1080             ;\
$81:9C4D F0 3A       BEQ $3A    [$9C89]     ;} If not newly pressed A or start: go to BRANCH_SET_MISSILE_POSITION
$81:9C4F A9 38 00    LDA #$0038             ;\
$81:9C52 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$81:9C56 AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:9C59 F0 1A       BEQ $1A    [$9C75]     ;} If [file clear menu selection] = 0: go to BRANCH_YES

; BRANCH_B
$81:9C5B AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:9C5E 38          SEC                    ;|
$81:9C5F E9 02 00    SBC #$0002             ;} Menu index = 16h (select slot)
$81:9C62 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:9C65 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:9C68 8D B5 19    STA $19B5  [$7E:19B5]  ;} File clear menu selection = [file clear slot]
$81:9C6B A9 37 00    LDA #$0037             ;\
$81:9C6E 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9C72 4C 3C 9B    JMP $9B3C  [$81:9B3C]  ; Go to initialise file select menu file clear

; BRANCH_YES
$81:9C75 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 19h (do file clear)
$81:9C78 60          RTS                    ; Return

; BRANCH_TOGGLE
$81:9C79 AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:9C7C 49 01 00    EOR #$0001             ;} File clear menu selection ^= 1
$81:9C7F 8D B5 19    STA $19B5  [$7E:19B5]  ;/
$81:9C82 A9 37 00    LDA #$0037             ;\
$81:9C85 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)

; BRANCH_SET_MISSILE_POSITION
$81:9C89 A0 B8 00    LDY #$00B8             ; Menu selection missile Y position = B8h
$81:9C8C AD B5 19    LDA $19B5  [$7E:19B5]  ;\
$81:9C8F F0 03       BEQ $03    [$9C94]     ;} If [file clear menu selection] != 0:
$81:9C91 A0 D0 00    LDY #$00D0             ; Menu selection missile Y position = D0h

$81:9C94 8C AB 19    STY $19AB  [$7E:19AB]
$81:9C97 A9 5E 00    LDA #$005E             ;\
$81:9C9A 8D A1 19    STA $19A1  [$7E:19A1]  ;} Menu selection missile X position = 5Eh
$81:9C9D 60          RTS
}


;;; $9C9E: File select menu - index 19h: file clear - do file clear ;;;
{
$81:9C9E C2 30       REP #$30
$81:9CA0 22 5B BA 82 JSL $82BA5B[$82:BA5B]  ; Draw border around DATA CLEAR MODE
$81:9CA4 A9 70 00    LDA #$0070             ;\
$81:9CA7 85 02       STA $02    [$7E:0002]  ;} $02 = $70 (source bank)
$81:9CA9 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:9CAC 0A          ASL A                  ;|
$81:9CAD AA          TAX                    ;} $00 = [$81:812B + [file clear slot] * 2] (SRAM offset)
$81:9CAE BF 2B 81 81 LDA $81812B,x[$81:812B];|
$81:9CB2 85 00       STA $00    [$7E:0000]  ;/
$81:9CB4 A0 00 00    LDY #$0000             ;\
$81:9CB7 A9 00 00    LDA #$0000             ;|
                                            ;|
$81:9CBA 97 00       STA [$00],y[$7E:0010]  ;|
$81:9CBC C8          INY                    ;} Clear 65Ch bytes from [$00]
$81:9CBD C8          INY                    ;|
$81:9CBE C0 5C 06    CPY #$065C             ;|
$81:9CC1 30 F7       BMI $F7    [$9CBA]     ;/
$81:9CC3 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:9CC6 0A          ASL A                  ;|
$81:9CC7 AA          TAX                    ;} $70:0000 + [file clear slot] * 2 = 0
$81:9CC8 A9 00 00    LDA #$0000             ;|
$81:9CCB 9F 00 00 70 STA $700000,x[$70:0000];/
$81:9CCF 9F 08 00 70 STA $700008,x[$70:0008]; $70:0008 + [file clear slot] * 2 = 0
$81:9CD3 9F F0 1F 70 STA $701FF0,x[$70:1FF0]; $70:1FF0 + [file clear slot] * 2 = 0
$81:9CD7 9F F8 1F 70 STA $701FF8,x[$70:1FF8]; $70:1FF8 + [file clear slot] * 2 = 0
$81:9CDB EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 1Ah (clear completed)
$81:9CDE 20 CB B2    JSR $B2CB  [$81:B2CB]  ; New save file <-- what?
$81:9CE1 AD B7 19    LDA $19B7  [$7E:19B7]  ; A = [file clear slot]
$81:9CE4 22 85 80 81 JSL $818085[$81:8085]  ; Load from SRAM <-- huh?
$81:9CE8 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:9CEB 8D 9F 07    STA $079F  [$7E:079F]  ;} Area index = [file clear slot] <-- w-what?
$81:9CEE 22 8C 85 80 JSL $80858C[$80:858C]  ; Load mirror of current area's map explored <-- ...?
$81:9CF2 A2 00 05    LDX #$0500             ;\
$81:9CF5 A9 0F 00    LDA #$000F             ;|
                                            ;|
$81:9CF8 9F 00 36 7E STA $7E3600,x[$7E:3B00];|
$81:9CFC E8          INX                    ;} Menu tilemap rows 14h..1Ch = 000Fh
$81:9CFD E8          INX                    ;|
$81:9CFE E0 40 07    CPX #$0740             ;|
$81:9D01 30 F5       BMI $F5    [$9CF8]     ;/
$81:9D03 AD B7 19    LDA $19B7  [$7E:19B7]  ;\
$81:9D06 0A          ASL A                  ;|
$81:9D07 AA          TAX                    ;|
$81:9D08 AD 54 09    LDA $0954  [$7E:0954]  ;} Non-empty save slots &= ~(1 << [file copy destination slot])
$81:9D0B 3D 20 9D    AND $9D20,x[$81:9D20]  ;|
$81:9D0E 8D 54 09    STA $0954  [$7E:0954]  ;/
$81:9D11 A0 DA B6    LDY #$B6DA
$81:9D14 A2 00 05    LDX #$0500
$81:9D17 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:9D1A 20 E2 B3    JSR $B3E2  [$81:B3E2]  ; Load menu tilemap $B6DA to (0, 14h) (        DATA CLEARED...)
$81:9D1D 4C 22 99    JMP $9922  [$81:9922]  ; Go to draw file clear confirmation save file info

$81:9D20             dw FFFE, FFFD, FFFB
}


;;; $9D26: File select menu - index 1Ah: file clear - clear completed ;;;
{
$81:9D26 22 5B BA 82 JSL $82BA5B[$82:BA5B]  ; Draw border around DATA CLEAR MODE
$81:9D2A A5 8F       LDA $8F    [$7E:008F]  ;\
$81:9D2C F0 39       BEQ $39    [$9D67]     ;} If not newly pressed anything: return
$81:9D2E A9 37 00    LDA #$0037             ;\
$81:9D31 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:9D35 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 1Bh (file clear to main)
$81:9D38 A9 00 00    LDA #$0000             ;\
$81:9D3B 22 85 80 81 JSL $818085[$81:8085]  ;} Load SRAM slot A
$81:9D3F B0 07       BCS $07    [$9D48]     ; If corrupt: go to BRANCH_SLOT_A_CORRUPT

; BRANCH_SELECT_SLOT_A
$81:9D41 A9 00 00    LDA #$0000             ;\
$81:9D44 8D 52 09    STA $0952  [$7E:0952]  ;} File select menu selection = 0
$81:9D47 60          RTS                    ; Return

; BRANCH_SLOT_A_CORRUPT
$81:9D48 A9 01 00    LDA #$0001             ;\
$81:9D4B 22 85 80 81 JSL $818085[$81:8085]  ;} Load SRAM slot B
$81:9D4F B0 07       BCS $07    [$9D58]     ; If not corrupt:
$81:9D51 A9 01 00    LDA #$0001             ;\
$81:9D54 8D 52 09    STA $0952  [$7E:0952]  ;} File select menu selection = 1
$81:9D57 60          RTS                    ; Return

$81:9D58 A9 02 00    LDA #$0002             ;\
$81:9D5B 22 85 80 81 JSL $818085[$81:8085]  ;} Load SRAM slot C
$81:9D5F B0 E0       BCS $E0    [$9D41]     ; If corrupt: go to BRANCH_SELECT_SLOT_A
$81:9D61 A9 02 00    LDA #$0002             ;\
$81:9D64 8D 52 09    STA $0952  [$7E:0952]  ;} File select menu selection = 2

$81:9D67 60          RTS
}


;;; $9D68: File select menu - index 1Eh: file clear to main - menu index = main ;;;
{
$81:9D68 22 35 BA 82 JSL $82BA35[$82:BA35]  ; Draw border around SAMUS DATA
$81:9D6C AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:9D6F 38          SEC                    ;|
$81:9D70 E9 1A 00    SBC #$001A             ;} Menu index = 4 (main)
$81:9D73 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:9D76 60          RTS
}


;;; $9D77: File select menu - index 1Fh: main to options menu - turn Samus helmet ;;;
{
$81:9D77 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:9D7B 22 35 BA 82 JSL $82BA35[$82:BA35]  ; Draw border around SAMUS DATA
$81:9D7F A2 04 00    LDX #$0004             ;\
$81:9D82 20 E4 9D    JSR $9DE4  [$81:9DE4]  ;} Draw file select slot A Samus helmet
$81:9D85 A2 06 00    LDX #$0006             ;\
$81:9D88 20 E4 9D    JSR $9DE4  [$81:9DE4]  ;} Draw file select slot B Samus helmet
$81:9D8B A2 08 00    LDX #$0008             ;\
$81:9D8E 20 E4 9D    JSR $9DE4  [$81:9DE4]  ;} Draw file select slot C Samus helmet
$81:9D91 A5 8F       LDA $8F    [$7E:008F]  ;\
$81:9D93 89 80 10    BIT #$1080             ;} If newly pressed A or start: go to BRANCH_ADVANCE
$81:9D96 D0 27       BNE $27    [$9DBF]     ;/
$81:9D98 AD 9B 19    LDA $199B  [$7E:199B]  ;\
$81:9D9B C9 07 00    CMP #$0007             ;} If [slot A Samus helmet animation frame] = 7:
$81:9D9E D0 05       BNE $05    [$9DA5]     ;/
$81:9DA0 AD 91 19    LDA $1991  [$7E:1991]  ;\
$81:9DA3 F0 1A       BEQ $1A    [$9DBF]     ;} If [slot A Samus helmet animation timer] = 0 (not animating): go to BRANCH_ADVANCE

$81:9DA5 AD 9D 19    LDA $199D  [$7E:199D]  ;\
$81:9DA8 C9 07 00    CMP #$0007             ;} If [slot B Samus helmet animation frame] = 7:
$81:9DAB D0 05       BNE $05    [$9DB2]     ;/
$81:9DAD AD 93 19    LDA $1993  [$7E:1993]  ;\
$81:9DB0 F0 0D       BEQ $0D    [$9DBF]     ;} If [slot B Samus helmet animation timer] = 0 (not animating): go to BRANCH_ADVANCE

$81:9DB2 AD 9F 19    LDA $199F  [$7E:199F]  ;\
$81:9DB5 C9 07 00    CMP #$0007             ;} If [slot C Samus helmet animation frame] != 7: return
$81:9DB8 D0 08       BNE $08    [$9DC2]     ;/
$81:9DBA AD 95 19    LDA $1995  [$7E:1995]  ;\
$81:9DBD D0 03       BNE $03    [$9DC2]     ;} If [slot C Samus helmet animation timer] != 0: return

; BRANCH_ADVANCE
$81:9DBF EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 20h (fade out)

$81:9DC2 60          RTS
}


;;; $9DC3: Draw file select Samus helmets ;;;
{
$81:9DC3 A2 04 00    LDX #$0004             ; X = 4 (slot A Samus helmet index)
$81:9DC6 A9 00 00    LDA #$0000             ;\
$81:9DC9 9D 8D 19    STA $198D,x[$7E:1991]  ;} Slot A Samus helmet animation timer = 0 (not animating)
$81:9DCC 20 E4 9D    JSR $9DE4  [$81:9DE4]  ; Draw slot Samus helmet
$81:9DCF A2 06 00    LDX #$0006             ; X = 6 (slot B Samus helmet index)
$81:9DD2 A9 00 00    LDA #$0000             ;\
$81:9DD5 9D 8D 19    STA $198D,x[$7E:1993]  ;} Slot B Samus helmet animation timer = 0 (not animating)
$81:9DD8 20 E4 9D    JSR $9DE4  [$81:9DE4]  ; Draw slot Samus helmet
$81:9DDB A2 08 00    LDX #$0008             ; X = 8 (slot C Samus helmet index)
$81:9DDE A9 00 00    LDA #$0000             ;\
$81:9DE1 9D 8D 19    STA $198D,x[$7E:1995]  ;} Slot C Samus helmet animation timer = 0 (not animating)
}


;;; $9DE4: Draw file select slot Samus helmet ;;;
{
;; Parameters:
;;     X: Slot Samus helmet index. 4/6/8 for slot A/B/C
$81:9DE4 DA          PHX
$81:9DE5 8B          PHB
$81:9DE6 4B          PHK                    ;\
$81:9DE7 AB          PLB                    ;} DB = $81
$81:9DE8 BD 8D 19    LDA $198D,x[$7E:1991]  ;\
$81:9DEB F0 21       BEQ $21    [$9E0E]     ;} If [slot Samus helmet timer] = 0: go to BRANCH_TIMER_HANDLED
$81:9DED 3A          DEC A                  ;\
$81:9DEE 9D 8D 19    STA $198D,x[$7E:1991]  ;} Decrement slot Samus helmet timer
$81:9DF1 D0 1B       BNE $1B    [$9E0E]     ; If [slot Samus helmet timer] != 0: go to BRANCH_TIMER_HANDLED
$81:9DF3 A9 08 00    LDA #$0008             ;\
$81:9DF6 9D 8D 19    STA $198D,x[$7E:1991]  ;} Slot Samus helmet timer = 8
$81:9DF9 BD 97 19    LDA $1997,x[$7E:199B]  ;\
$81:9DFC 1A          INC A                  ;} Increment $1997 + [X]
$81:9DFD C9 08 00    CMP #$0008             ;\
$81:9E00 30 09       BMI $09    [$9E0B]     ;} If [$1997 + [X]] >= 8:
$81:9E02 A9 00 00    LDA #$0000             ;\
$81:9E05 9D 8D 19    STA $198D,x            ;} Slot Samus helmet timer = 0
$81:9E08 A9 07 00    LDA #$0007             ; $1997 + [X] = 7

$81:9E0B 9D 97 19    STA $1997,x[$7E:199B]

; BRANCH_TIMER_HANDLED
$81:9E0E BD 97 19    LDA $1997,x[$7E:199B]  ;\
$81:9E11 0A          ASL A                  ;} Y = [$1997 + [X]] * 2
$81:9E12 A8          TAY                    ;/
$81:9E13 A9 00 0E    LDA #$0E00             ;\
$81:9E16 85 03       STA $03    [$7E:0003]  ;} $03 = E00h (palette 7)
$81:9E18 B9 2C 9E    LDA $9E2C,y[$81:9E2C]  ; A = [$9E2C + [$1997 + [X]] * 2]
$81:9E1B 48          PHA
$81:9E1C BD AB 19    LDA $19AB,x[$7E:19AF]  ;\
$81:9E1F A8          TAY                    ;} Y = [$19AB + [X]]
$81:9E20 BD A1 19    LDA $19A1,x[$7E:19A5]  ;\
$81:9E23 AA          TAX                    ;} X = [$19A1 + [X]]
$81:9E24 68          PLA
$81:9E25 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$81:9E29 AB          PLB
$81:9E2A FA          PLX
$81:9E2B 60          RTS

$81:9E2C             dw 002C, 002D, 002E, 002F, 0030, 0031, 0032, 0033, 0033
}


;;; $9E3E: File select map ;;;
{
$81:9E3E C2 30       REP #$30
$81:9E40 8B          PHB
$81:9E41 4B          PHK
$81:9E42 AB          PLB
$81:9E43 AD 27 07    LDA $0727  [$7E:0727]
$81:9E46 0A          ASL A
$81:9E47 AA          TAX
$81:9E48 FC 4D 9E    JSR ($9E4D,x)[$81:A32A]
$81:9E4B AB          PLB
$81:9E4C 6B          RTL

$81:9E4D             dw A32A, A37C, A546, A582, A5B3, A725, A800, AAAC, AC66, AD17, AD7F, AF5A, AF5A, AF66, AF83, AF97,
                        AFD3, A546, A578, A5B3, AFF6, B0BB, 9E7B
}


;;; $9E7B: File select map - index 16h: file clear - area select map to game options ;;;
{
$81:9E7B 20 7E A9    JSR $A97E  [$81:A97E]  ; Draw area select map labels
$81:9E7E 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$81:9E82 A5 51       LDA $51    [$7E:0051]  ;\
$81:9E84 29 0F 00    AND #$000F             ;} If not finished fading out: return
$81:9E87 D0 09       BNE $09    [$9E92]     ;/
$81:9E89 A9 02 00    LDA #$0002             ;\
$81:9E8C 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 2 (game options menu)
$81:9E8F 9C 27 07    STZ $0727  [$7E:0727]  ; Menu index = 0

$81:9E92 60          RTS
}


;;; $9E93: File select menu - index 1: title sequence to main - load BG2 ;;;
{
$81:9E93 C2 30       REP #$30
$81:9E95 A2 FE 07    LDX #$07FE             ;\
$81:9E98 A9 0F 00    LDA #$000F             ;|
                                            ;|
$81:9E9B BF 00 DC 8E LDA $8EDC00,x[$8E:E3FE];|
$81:9E9F 9F 00 36 7E STA $7E3600,x[$7E:3DFE];} $7E:3600..3DFF = [$8E:DC00..E3FF] (Zebes and stars tilemap)
$81:9EA3 CA          DEX                    ;|
$81:9EA4 CA          DEX                    ;|
$81:9EA5 10 F4       BPL $F4    [$9E9B]     ;/
$81:9EA7 AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:9EAA A9 00 08    LDA #$0800             ;|
$81:9EAD 95 D0       STA $D0,x  [$7E:00D0]  ;|
$81:9EAF A9 00 36    LDA #$3600             ;|
$81:9EB2 95 D2       STA $D2,x  [$7E:00D2]  ;|
$81:9EB4 A9 7E 00    LDA #$007E             ;|
$81:9EB7 95 D4       STA $D4,x  [$7E:00D4]  ;|
$81:9EB9 A5 59       LDA $59    [$7E:0059]  ;} Queue transfer of 800h bytes from $7E:3600 to VRAM BG2 tilemap
$81:9EBB 29 FC 00    AND #$00FC             ;|
$81:9EBE EB          XBA                    ;|
$81:9EBF 95 D5       STA $D5,x  [$7E:00D5]  ;|
$81:9EC1 8A          TXA                    ;|
$81:9EC2 18          CLC                    ;|
$81:9EC3 69 07 00    ADC #$0007             ;|
$81:9EC6 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:9EC9 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 2 (initialise)
$81:9ECC A9 01 00    LDA #$0001             ;\
$81:9ECF 8D 8D 19    STA $198D  [$7E:198D]  ;} Menu selection missile animation timer = 1
$81:9ED2 9C 97 19    STZ $1997  [$7E:1997]  ; Menu selection missile animation frame = 0
$81:9ED5 60          RTS
}


;;; $9ED6: File select menu - index 2: title sequence to main - initialise ;;;
{
$81:9ED6 C2 30       REP #$30
$81:9ED8 AF EC 1F 70 LDA $701FEC[$70:1FEC]  ;\
$81:9EDC C9 00 00    CMP #$0000             ;|
$81:9EDF 30 0C       BMI $0C    [$9EED]     ;} If 0 <= [SRAM save slot selected] < 3:
$81:9EE1 C9 03 00    CMP #$0003             ;|
$81:9EE4 10 07       BPL $07    [$9EED]     ;/
$81:9EE6 AA          TAX                    ; X = [SRAM save slot selected]
$81:9EE7 2F EE 1F 70 AND $701FEE[$70:1FEE]  ;\
$81:9EEB F0 03       BEQ $03    [$9EF0]     ;} If [SRAM save slot selected] & [SRAM save slot selected complement] = 0: go to BRANCH_VALID_SAVE_SLOT

$81:9EED A2 00 00    LDX #$0000             ; X = 0

; BRANCH_VALID_SAVE_SLOT
$81:9EF0 8E 52 09    STX $0952  [$7E:0952]  ; Save slot selected = [X]
}


;;; $9EF3: File select menu - index 10h/1Ch: reload main ;;;
{
$81:9EF3 A2 FE 07    LDX #$07FE             ;\
$81:9EF6 A9 0F 00    LDA #$000F             ;|
                                            ;|
$81:9EF9 9F 00 36 7E STA $7E3600,x[$7E:3DFE];} $7E:3600..3DFF = 000Fh (menu tilemap)
$81:9EFD CA          DEX                    ;|
$81:9EFE CA          DEX                    ;|
$81:9EFF 10 F8       BPL $F8    [$9EF9]     ;/
$81:9F01 A9 FF FF    LDA #$FFFF             ;\
$81:9F04 8D 54 09    STA $0954  [$7E:0954]  ;} $0954 = FFFFh
$81:9F07 A0 0A B4    LDY #$B40A
$81:9F0A A2 56 00    LDX #$0056
$81:9F0D 9C 96 0F    STZ $0F96  [$7E:0F96]  ; Enemy 0 palette index = 0
$81:9F10 20 E2 B3    JSR $B3E2  [$81:B3E2]  ; Load menu tilemap $B40A to (Bh, 1) (SAMUS DATA)
$81:9F13 A0 36 B4    LDY #$B436             ;\
$81:9F16 A2 46 01    LDX #$0146             ;} Load menu tilemap $B40A to (3, 5) (SAMUS A)
$81:9F19 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9F1C A9 00 00    LDA #$0000             ;\
$81:9F1F 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot A (carry set if corrupt)
$81:9F22 6E 54 09    ROR $0954  [$7E:0954]  ; $0954 = [$0954] >> 1 | carry << Fh
$81:9F25 A2 5C 01    LDX #$015C             ; X = 15Ch (Eh, 5)
$81:9F28 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9F2B 89 00 80    BIT #$8000             ;} Clear zero if SRAM is corrupt, otherwise set zero
$81:9F2E 20 87 A0    JSR $A087  [$81:A087]  ; Draw file selection health
$81:9F31 A2 B4 01    LDX #$01B4             ; X = 1B4h (1Ah, 6)
$81:9F34 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9F37 89 00 80    BIT #$8000             ;} Clear zero if SRAM is corrupt, otherwise set zero
$81:9F3A 20 4E A1    JSR $A14E  [$81:A14E]  ; Draw file selection time
$81:9F3D A0 A0 B4    LDY #$B4A0             ;\
$81:9F40 A2 76 01    LDX #$0176             ;} Load menu tilemap $B4A0 to (1Bh, 5) (TIME)
$81:9F43 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9F46 A0 56 B4    LDY #$B456             ;\
$81:9F49 A2 86 02    LDX #$0286             ;|
$81:9F4C 9C 96 0F    STZ $0F96  [$7E:0F96]  ;} Load menu tilemap $B456 to (3, Ah) (SAMUS B)
$81:9F4F 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9F52 A9 01 00    LDA #$0001             ;\
$81:9F55 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot B (carry set if corrupt)
$81:9F58 6E 54 09    ROR $0954  [$7E:0954]  ; $0954 = [$0954] >> 1 | carry << Fh
$81:9F5B A2 9C 02    LDX #$029C             ; X = 29Ch (Eh, Ah)
$81:9F5E AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9F61 89 00 80    BIT #$8000             ;} Clear zero if SRAM is corrupt, otherwise set zero
$81:9F64 20 87 A0    JSR $A087  [$81:A087]  ; Draw file selection health
$81:9F67 A2 F4 02    LDX #$02F4             ; X = 2F4h (1Ah, Bh)
$81:9F6A AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9F6D 89 00 80    BIT #$8000             ;} Clear zero if SRAM is corrupt, otherwise set zero
$81:9F70 20 4E A1    JSR $A14E  [$81:A14E]  ; Draw file selection time
$81:9F73 A0 A0 B4    LDY #$B4A0             ;\
$81:9F76 A2 B6 02    LDX #$02B6             ;} Load menu tilemap $B4A0 to (1Bh, Ah) (TIME)
$81:9F79 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9F7C A0 76 B4    LDY #$B476             ;\
$81:9F7F A2 C6 03    LDX #$03C6             ;|
$81:9F82 9C 96 0F    STZ $0F96  [$7E:0F96]  ;} Load menu tilemap $B476 to (3, Fh) (SAMUS C)
$81:9F85 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9F88 A9 02 00    LDA #$0002             ;\
$81:9F8B 20 53 A0    JSR $A053  [$81:A053]  ;} Load SRAM slot C (carry set if corrupt)
$81:9F8E 6E 54 09    ROR $0954  [$7E:0954]  ; $0954 = [$0954] >> 1 | carry << Fh
$81:9F91 A2 DC 03    LDX #$03DC             ; X = 3DCh (Eh, Fh)
$81:9F94 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9F97 89 00 80    BIT #$8000             ;} Clear zero if SRAM is corrupt, otherwise set zero
$81:9F9A 20 87 A0    JSR $A087  [$81:A087]  ; Draw file selection health
$81:9F9D A2 34 04    LDX #$0434             ; X = 434h (1Ah, 10h)
$81:9FA0 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9FA3 89 00 80    BIT #$8000             ;} Clear zero if SRAM is corrupt, otherwise set zero
$81:9FA6 20 4E A1    JSR $A14E  [$81:A14E]  ; Draw file selection time
$81:9FA9 A0 A0 B4    LDY #$B4A0             ;\
$81:9FAC A2 F6 03    LDX #$03F6             ;} Load menu tilemap $B4A0 to (1Bh, Fh) (TIME)
$81:9FAF 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9FB2 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:9FB5 49 FF FF    EOR #$FFFF             ;|
$81:9FB8 EB          XBA                    ;|
$81:9FB9 4A          LSR A                  ;|
$81:9FBA 4A          LSR A                  ;} $0954 = ~[$0954] >> Dh (non-empty save slots)
$81:9FBB 4A          LSR A                  ;|
$81:9FBC 4A          LSR A                  ;|
$81:9FBD 4A          LSR A                  ;|
$81:9FBE 8D 54 09    STA $0954  [$7E:0954]  ;/
$81:9FC1 C9 00 00    CMP #$0000             ;\
$81:9FC4 F0 18       BEQ $18    [$9FDE]     ;} If any non-empty save slots:
$81:9FC6 A0 C4 B4    LDY #$B4C4             ;\
$81:9FC9 A2 08 05    LDX #$0508             ;|
$81:9FCC 9C 96 0F    STZ $0F96  [$7E:0F96]  ;} Load menu tilemap $B4C4 to (4, 14h) (DATA COPY)
$81:9FCF 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9FD2 A0 D8 B4    LDY #$B4D8             ;\
$81:9FD5 A2 C8 05    LDX #$05C8             ;|
$81:9FD8 9C 96 0F    STZ $0F96  [$7E:0F96]  ;} Load menu tilemap $B4D8 to (4, 17h) (DATA CLEAR)
$81:9FDB 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/

$81:9FDE A0 EE B4    LDY #$B4EE             ;\
$81:9FE1 A2 88 06    LDX #$0688             ;|
$81:9FE4 9C 96 0F    STZ $0F96  [$7E:0F96]  ;} Load menu tilemap $B4D8 to (4, 1Ah) (EXIT)
$81:9FE7 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;/
$81:9FEA 20 9F 96    JSR $969F  [$81:969F]  ; Queue transfer of menu tilemap to VRAM BG1
$81:9FED A9 01 00    LDA #$0001             ;\
$81:9FF0 8D 8D 19    STA $198D  [$7E:198D]  ;} $198D = 1
$81:9FF3 3A          DEC A                  ;\
$81:9FF4 8D 8F 19    STA $198F  [$7E:198F]  ;} $198F = 0
$81:9FF7 8D 91 19    STA $1991  [$7E:1991]  ; $1991 = 0
$81:9FFA 8D 93 19    STA $1993  [$7E:1993]  ; $1993 = 0
$81:9FFD 8D 95 19    STA $1995  [$7E:1995]  ; $1995 = 0
$81:A000 8D 97 19    STA $1997  [$7E:1997]  ; $1997 = 0
$81:A003 8D 99 19    STA $1999  [$7E:1999]  ; $1999 = 0
$81:A006 8D 9B 19    STA $199B  [$7E:199B]  ; $199B = 0
$81:A009 8D 9D 19    STA $199D  [$7E:199D]  ; $199D = 0
$81:A00C 8D 9F 19    STA $199F  [$7E:199F]  ; $199F = 0
$81:A00F 8D A1 19    STA $19A1  [$7E:19A1]  ; $19A1 = 0
$81:A012 8D AB 19    STA $19AB  [$7E:19AB]  ; $19AB = 0
$81:A015 8D A3 19    STA $19A3  [$7E:19A3]  ; $19A3 = 0
$81:A018 8D AD 19    STA $19AD  [$7E:19AD]  ; $19AD = 0
$81:A01B A9 64 00    LDA #$0064             ;\
$81:A01E 8D A5 19    STA $19A5  [$7E:19A5]  ;} $19A5 = 100
$81:A021 8D A7 19    STA $19A7  [$7E:19A7]  ; $19A7 = 100
$81:A024 8D A9 19    STA $19A9  [$7E:19A9]  ; $19A9 = 100
$81:A027 A9 2F 00    LDA #$002F             ;\
$81:A02A 8D AF 19    STA $19AF  [$7E:19AF]  ;} $19AF = 2Fh
$81:A02D A9 57 00    LDA #$0057             ;\
$81:A030 8D B1 19    STA $19B1  [$7E:19B1]  ;} $19B1 = 57h
$81:A033 A9 7F 00    LDA #$007F             ;\
$81:A036 8D B3 19    STA $19B3  [$7E:19B3]  ;} $19B3 = 7Fh
$81:A039 A9 01 00    LDA #$0001             ;\
$81:A03C 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$81:A03F 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$81:A042 22 82 83 80 JSL $808382[$80:8382]  ; Clear force blank and wait for NMI
$81:A046 EE 27 07    INC $0727  [$7E:0727]  ; Increment menu index
$81:A049 9C B5 19    STZ $19B5  [$7E:19B5]  ; $19B5 = 0
$81:A04C 9C B7 19    STZ $19B7  [$7E:19B7]  ; $19B7 = 0
$81:A04F 9C B9 19    STZ $19B9  [$7E:19B9]  ; $19B9 = 0
$81:A052 60          RTS
}


;;; $A053: Load from SRAM ;;;
{
$81:A053 22 85 80 81 JSL $818085[$81:8085]
$81:A057 60          RTS
}


;;; $A058: File select menu - index 3: title sequence to main - fade in ;;;
{
$81:A058 20 C3 9D    JSR $9DC3  [$81:9DC3]  ; Draw file select Samus helmets
$81:A05B AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A05E 0A          ASL A                  ;|
$81:A05F 0A          ASL A                  ;} X = [file select menu selection] * 4
$81:A060 AA          TAX                    ;/
$81:A061 BD 12 A3    LDA $A312,x[$81:A312]  ;\
$81:A064 8D AB 19    STA $19AB  [$7E:19AB]  ;} Menu selection missile Y position = [$A312 + [X]]
$81:A067 BD 14 A3    LDA $A314,x[$81:A314]  ;\
$81:A06A 8D A1 19    STA $19A1  [$7E:19A1]  ;} Menu selection missile X position = [$A312 + [X] + 2]
$81:A06D 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:A071 22 35 BA 82 JSL $82BA35[$82:BA35]  ; Draw border around SAMUS DATA
$81:A075 22 4D 89 80 JSL $80894D[$80:894D]  ; Handle fading in
$81:A079 A5 51       LDA $51    [$7E:0051]  ;\
$81:A07B 29 0F 00    AND #$000F             ;|
$81:A07E C9 0F 00    CMP #$000F             ;} If (brightness) = Fh:
$81:A081 D0 03       BNE $03    [$A086]     ;/
$81:A083 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 4 (main)

$81:A086 60          RTS
}


;;; $A087: Draw file selection health ;;;
{
;; Parameters:
;;     X: Menu tilemap index
;;     Zero: Clear if SRAM is corrupt
$81:A087 F0 10       BEQ $10    [$A099]     ; If zero clear:
$81:A089 DA          PHX
$81:A08A 20 C5 B3    JSR $B3C5  [$81:B3C5]  ; Clear rest of menu tilemap row
$81:A08D 68          PLA                    ;\
$81:A08E 18          CLC                    ;|
$81:A08F 69 40 00    ADC #$0040             ;} X += 40h (one row down)
$81:A092 AA          TAX                    ;/
$81:A093 A0 AC B4    LDY #$B4AC             ;\
$81:A096 4C E2 B3    JMP $B3E2  [$81:B3E2]  ;} Go to load menu tilemap $B4AC to ([X] / 2 % 20h, [X] / 40h) (NO DATA)

$81:A099 86 1A       STX $1A    [$7E:001A]  ; $1A = [X]
$81:A09B A0 96 B4    LDY #$B496             ;\
$81:A09E 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;} Go to load menu tilemap $B496 to ([X] / 2 % 20h, [X] / 40h) (ENERGY)
$81:A0A1 A5 1A       LDA $1A    [$7E:001A]  ;\
$81:A0A3 18          CLC                    ;|
$81:A0A4 69 08 00    ADC #$0008             ;} X = [$1A] + 8 (4 columns right)
$81:A0A7 AA          TAX                    ;/
$81:A0A8 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$81:A0AB 8D 04 42    STA $4204  [$7E:4204]  ;|
$81:A0AE E2 20       SEP #$20               ;|
$81:A0B0 A9 64       LDA #$64               ;|
$81:A0B2 8D 06 42    STA $4206  [$7E:4206]  ;|
$81:A0B5 48          PHA                    ;|
$81:A0B6 68          PLA                    ;} $14 = number of whole energy tanks
$81:A0B7 48          PHA                    ;} $12 = sub-tank energy
$81:A0B8 68          PLA                    ;|
$81:A0B9 C2 20       REP #$20               ;|
$81:A0BB AD 14 42    LDA $4214  [$7E:4214]  ;|
$81:A0BE 85 14       STA $14    [$7E:0014]  ;|
$81:A0C0 AD 16 42    LDA $4216  [$7E:4216]  ;|
$81:A0C3 85 12       STA $12    [$7E:0012]  ;/
$81:A0C5 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$81:A0C8 8D 04 42    STA $4204  [$7E:4204]  ;|
$81:A0CB E2 20       SEP #$20               ;|
$81:A0CD A9 64       LDA #$64               ;|
$81:A0CF 8D 06 42    STA $4206  [$7E:4206]  ;|
$81:A0D2 48          PHA                    ;|
$81:A0D3 68          PLA                    ;} $16 = number of collected energy tanks
$81:A0D4 48          PHA                    ;|
$81:A0D5 68          PLA                    ;|
$81:A0D6 C2 20       REP #$20               ;|
$81:A0D8 AD 14 42    LDA $4214  [$7E:4214]  ;|
$81:A0DB 85 16       STA $16    [$7E:0016]  ;/
$81:A0DD A9 07 00    LDA #$0007             ;\
$81:A0E0 85 18       STA $18    [$7E:0018]  ;} $18 = 7 (max energy tanks per row)
$81:A0E2 8A          TXA                    ;\
$81:A0E3 18          CLC                    ;|
$81:A0E4 69 40 00    ADC #$0040             ;} X += 40h (one row down)
$81:A0E7 AA          TAX                    ;/

; LOOP
$81:A0E8 C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$81:A0EA 30 27       BMI $27    [$A113]     ; If [$16] < 0: go to BRANCH_ETANKS_DRAWN
$81:A0EC A0 99 00    LDY #$0099             ; Y = 99h (sub-tank)
$81:A0EF A5 14       LDA $14    [$7E:0014]  ;\
$81:A0F1 F0 05       BEQ $05    [$A0F8]     ;} If [$14] != 0:
$81:A0F3 C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$81:A0F5 A0 98 00    LDY #$0098             ; Y = 98h (whole energy tank)

$81:A0F8 98          TYA                    ;\
$81:A0F9 0D 96 0F    ORA $0F96  [$7E:0F96]  ;} $7E:3600 + [X] = [Y] | [enemy 0 palette index]
$81:A0FC 9F 00 36 7E STA $7E3600,x[$7E:37A4];/
$81:A100 E8          INX                    ;\
$81:A101 E8          INX                    ;} X += 2 (one column right)
$81:A102 C6 18       DEC $18    [$7E:0018]  ; Decrement $18
$81:A104 D0 E2       BNE $E2    [$A0E8]     ; If [$18] != 0: go to LOOP
$81:A106 8A          TXA                    ;\
$81:A107 38          SEC                    ;|
$81:A108 E9 4E 00    SBC #$004E             ;} X -= 4Eh (one row up, 7 columns left)
$81:A10B AA          TAX                    ;/
$81:A10C A9 08 00    LDA #$0008             ;\
$81:A10F 85 18       STA $18    [$7E:0018]  ;} $18 = 8 (more than 7 so that the above branch is taken)
$81:A111 80 D5       BRA $D5    [$A0E8]     ; Go to LOOP

; BRANCH_ETANKS_DRAWN
$81:A113 A6 1A       LDX $1A    [$7E:001A]  ; X = [$1A]
$81:A115 A5 12       LDA $12    [$7E:0012]  ;\
$81:A117 8D 04 42    STA $4204  [$7E:4204]  ;|
$81:A11A E2 20       SEP #$20               ;|
$81:A11C A9 0A       LDA #$0A               ;|
$81:A11E 8D 06 42    STA $4206  [$7E:4206]  ;|
$81:A121 48          PHA                    ;|
$81:A122 68          PLA                    ;} $14 = (sub-tank energy) / 10
$81:A123 48          PHA                    ;} $12 = (sub-tank energy) % 10
$81:A124 68          PLA                    ;|
$81:A125 C2 20       REP #$20               ;|
$81:A127 AD 14 42    LDA $4214  [$7E:4214]  ;|
$81:A12A 85 14       STA $14    [$7E:0014]  ;|
$81:A12C AD 16 42    LDA $4216  [$7E:4216]  ;|
$81:A12F 85 12       STA $12    [$7E:0012]  ;/
$81:A131 A6 1A       LDX $1A    [$7E:001A]  ;\
$81:A133 A5 12       LDA $12    [$7E:0012]  ;} >_<;
$81:A135 18          CLC                    ;\
$81:A136 69 60 20    ADC #$2060             ;|
$81:A139 0D 96 0F    ORA $0F96  [$7E:0F96]  ;} $7E:3600 + [X] + 44h = 2060h + [$12] | [enemy 0 palette index] (units)
$81:A13C 9F 44 36 7E STA $7E3644,x[$7E:37A0];/
$81:A140 A5 14       LDA $14    [$7E:0014]  ;\
$81:A142 18          CLC                    ;|
$81:A143 69 60 20    ADC #$2060             ;} $7E:3600 + [X] + 42h = 2060h + [$14] | [enemy 0 palette index] (tens)
$81:A146 0D 96 0F    ORA $0F96  [$7E:0F96]  ;|
$81:A149 9F 42 36 7E STA $7E3642,x[$7E:379E];/
$81:A14D 60          RTS
}


;;; $A14E: Draw file selection time ;;;
{
;; Parameters:
;;     X: Menu tilemap index
;;     Zero: Clear if SRAM is corrupt
$81:A14E D0 71       BNE $71    [$A1C1]     ; If zero clear: return
$81:A150 86 1A       STX $1A    [$7E:001A]  ; $1A = [X]
$81:A152 AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$81:A155 8D 04 42    STA $4204  [$7E:4204]  ;|
$81:A158 E2 20       SEP #$20               ;|
$81:A15A A9 0A       LDA #$0A               ;|
$81:A15C 8D 06 42    STA $4206  [$7E:4206]  ;} $4214 = [game time, hours] / 10
$81:A15F 48          PHA                    ;} $4216 = [game time, hours] % 10
$81:A160 68          PLA                    ;|
$81:A161 48          PHA                    ;|
$81:A162 68          PLA                    ;|
$81:A163 C2 20       REP #$20               ;/
$81:A165 A6 1A       LDX $1A    [$7E:001A]  ; X = [$1A]
$81:A167 AD 16 42    LDA $4216  [$7E:4216]  ;\
$81:A16A 18          CLC                    ;|
$81:A16B 69 60 20    ADC #$2060             ;} $7E:3600 + [X] + 2 = 2060h + [$4216] | [enemy 0 palette index] (units)
$81:A16E 0D 96 0F    ORA $0F96  [$7E:0F96]  ;|
$81:A171 9F 02 36 7E STA $7E3602,x[$7E:37B6];/
$81:A175 AD 14 42    LDA $4214  [$7E:4214]  ;\
$81:A178 18          CLC                    ;|
$81:A179 69 60 20    ADC #$2060             ;} $7E:3600 + [X] = 2060h + [$4214] | [enemy 0 palette index] (tens)
$81:A17C 0D 96 0F    ORA $0F96  [$7E:0F96]  ;|
$81:A17F 9F 00 36 7E STA $7E3600,x[$7E:37B4];/
$81:A183 A5 1A       LDA $1A    [$7E:001A]  ;\
$81:A185 18          CLC                    ;|
$81:A186 69 04 00    ADC #$0004             ;} X = [$1A] + 4 (two columns right)
$81:A189 AA          TAX                    ;/
$81:A18A A0 A8 B4    LDY #$B4A8             ;\
$81:A18D 20 E2 B3    JSR $B3E2  [$81:B3E2]  ;} Load menu tilemap $B4A8 to ([X] / 2 % 20h, [X] / 40h) (:)
$81:A190 AD DE 09    LDA $09DE  [$7E:09DE]  ;\
$81:A193 8D 04 42    STA $4204  [$7E:4204]  ;|
$81:A196 E2 20       SEP #$20               ;|
$81:A198 A9 0A       LDA #$0A               ;|
$81:A19A 8D 06 42    STA $4206  [$7E:4206]  ;} $4214 = [game time, minutes] / 10
$81:A19D 48          PHA                    ;} $4216 = [game time, minutes] % 10
$81:A19E 68          PLA                    ;|
$81:A19F 48          PHA                    ;|
$81:A1A0 68          PLA                    ;|
$81:A1A1 C2 20       REP #$20               ;/
$81:A1A3 A6 1A       LDX $1A    [$7E:001A]  ; X = [$1A]
$81:A1A5 AD 16 42    LDA $4216  [$7E:4216]  ;\
$81:A1A8 18          CLC                    ;|
$81:A1A9 69 60 20    ADC #$2060             ;} $7E:3600 + [X] + 8 = 2060h + [$4216] | [enemy 0 palette index] (units)
$81:A1AC 0D 96 0F    ORA $0F96  [$7E:0F96]  ;|
$81:A1AF 9F 08 36 7E STA $7E3608,x[$7E:37BC];/
$81:A1B3 AD 14 42    LDA $4214  [$7E:4214]  ;\
$81:A1B6 18          CLC                    ;|
$81:A1B7 69 60 20    ADC #$2060             ;} $7E:3600 + [X] + 6 = 2060h + [$4214] | [enemy 0 palette index] (tens)
$81:A1BA 0D 96 0F    ORA $0F96  [$7E:0F96]  ;|
$81:A1BD 9F 06 36 7E STA $7E3606,x[$7E:37BA];/

$81:A1C1 60          RTS
}


;;; $A1C2: File select menu - index 4: main ;;;
{
$81:A1C2 C2 30       REP #$30
$81:A1C4 22 35 BA 82 JSL $82BA35[$82:BA35]  ; Draw border around SAMUS DATA
$81:A1C8 22 6E BA 82 JSL $82BA6E[$82:BA6E]  ; Draw menu selection missile
$81:A1CC A2 04 00    LDX #$0004             ;\
$81:A1CF 20 E4 9D    JSR $9DE4  [$81:9DE4]  ;} Draw slot A Samus helmet
$81:A1D2 A2 06 00    LDX #$0006             ;\
$81:A1D5 20 E4 9D    JSR $9DE4  [$81:9DE4]  ;} Draw slot B Samus helmet
$81:A1D8 A2 08 00    LDX #$0008             ;\
$81:A1DB 20 E4 9D    JSR $9DE4  [$81:9DE4]  ;} Draw slot C Samus helmet
$81:A1DE A5 8F       LDA $8F    [$7E:008F]  ;\
$81:A1E0 89 80 10    BIT #$1080             ;} If newly pressed A or start: go to BRANCH_SELECT
$81:A1E3 D0 29       BNE $29    [$A20E]     ;/
$81:A1E5 89 00 08    BIT #$0800             ;\
$81:A1E8 D0 74       BNE $74    [$A25E]     ;} If newly pressed up: go to BRANCH_UP
$81:A1EA 89 00 04    BIT #$0400             ;\
$81:A1ED F0 03       BEQ $03    [$A1F2]     ;} If newly pressed down:
$81:A1EF 4C 86 A2    JMP $A286  [$81:A286]  ; Go to BRANCH_DOWN

$81:A1F2 89 00 80    BIT #$8000             ;\
$81:A1F5 F0 14       BEQ $14    [$A20B]     ;} If newly pressed B:
$81:A1F7 A9 37 00    LDA #$0037             ;\
$81:A1FA 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:A1FE A9 21 00    LDA #$0021             ;\
$81:A201 8D 27 07    STA $0727  [$7E:0727]  ;} Menu index = 21h (main to title sequence)
$81:A204 A9 37 00    LDA #$0037             ;\
$81:A207 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)

$81:A20B 4C B9 A2    JMP $A2B9  [$81:A2B9]  ; Go to BRANCH_DONE

; BRANCH_SELECT
$81:A20E AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A211 C9 03 00    CMP #$0003             ;} If [file select menu selection] >= 3:
$81:A214 30 03       BMI $03    [$A219]     ;/
$81:A216 4C CC A2    JMP $A2CC  [$81:A2CC]  ; Go to BRANCH_FILE_OPERATION

$81:A219 A9 2A 00    LDA #$002A             ;\
$81:A21C 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 2Ah, sound library 1, max queued sounds allowed = 6 (selected save file)
$81:A220 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:A223 18          CLC                    ;|
$81:A224 69 1B 00    ADC #$001B             ;} Menu index = 1Fh (main to options menu)
$81:A227 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:A22A AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A22D 18          CLC                    ;|
$81:A22E 69 02 00    ADC #$0002             ;} X = 4 + [file select menu selection] * 2 (slot Samus helmet index)
$81:A231 0A          ASL A                  ;|
$81:A232 AA          TAX                    ;/
$81:A233 A9 01 00    LDA #$0001             ;\
$81:A236 9D 8D 19    STA $198D,x[$7E:1991]  ;} Slot Samus helmet animation timer = 1 (trigger animation)
$81:A239 AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A23C 8F EC 1F 70 STA $701FEC[$70:1FEC]  ;} SRAM save slot selected = [file select menu selection]
$81:A240 49 FF FF    EOR #$FFFF             ;\
$81:A243 8F EE 1F 70 STA $701FEE[$70:1FEE]  ;} SRAM save slot selected complement = ~[SRAM save slot selected]
$81:A247 AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A24A 22 85 80 81 JSL $818085[$81:8085]  ;} Load current save slot from SRAM
$81:A24E B0 06       BCS $06    [$A256]     ; If not corrupt:
$81:A250 22 8C 85 80 JSL $80858C[$80:858C]  ; Load mirror of current area's map explored
$81:A254 80 63       BRA $63    [$A2B9]     ; Go to BRANCH_DONE

$81:A256 20 CB B2    JSR $B2CB  [$81:B2CB]  ; New save file
$81:A259 9C 89 07    STZ $0789  [$7E:0789]  ; Clear current area map collected flag
$81:A25C 80 5B       BRA $5B    [$A2B9]     ; Go to BRANCH_DONE

; BRANCH_UP
$81:A25E AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:A261 F0 0B       BEQ $0B    [$A26E]     ;} If [non-empty save slots] != 0:
$81:A263 AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A266 3A          DEC A                  ;} Decrement file select menu selection
$81:A267 10 18       BPL $18    [$A281]     ; If [file select menu selection] >= 0: go to BRANCH_CURSOR_SOUND
$81:A269 A9 05 00    LDA #$0005             ; File select menu selection = 5
$81:A26C 80 13       BRA $13    [$A281]     ; Go to BRANCH_CURSOR_SOUND

$81:A26E AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A271 3A          DEC A                  ;} Decrement file select menu selection
$81:A272 10 05       BPL $05    [$A279]     ; If [file select menu selection] < 0:
$81:A274 A9 05 00    LDA #$0005             ; File select menu selection = 5
$81:A277 80 08       BRA $08    [$A281]

$81:A279 C9 04 00    CMP #$0004             ;\ Else ([file select menu selection] >= 0):
$81:A27C 30 03       BMI $03    [$A281]     ;} If [file select menu selection] >= 4:
$81:A27E A9 02 00    LDA #$0002             ; File select menu selection = 2

$81:A281 8D 52 09    STA $0952  [$7E:0952]
$81:A284 80 2C       BRA $2C    [$A2B2]     ; Go to BRANCH_CURSOR_SOUND

; BRANCH_DOWN
$81:A286 AD 54 09    LDA $0954  [$7E:0954]  ;\
$81:A289 F0 0E       BEQ $0E    [$A299]     ;} If [non-empty save slots] != 0:
$81:A28B AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A28E 1A          INC A                  ;} Increment file select menu selection
$81:A28F C9 06 00    CMP #$0006             ;\
$81:A292 30 1B       BMI $1B    [$A2AF]     ;} If [file select menu selection] < 6: go to BRANCH_CURSOR_SOUND
$81:A294 A9 00 00    LDA #$0000             ; File select menu selection = 0
$81:A297 80 16       BRA $16    [$A2AF]     ; Go to BRANCH_CURSOR_SOUND

$81:A299 AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A29C 1A          INC A                  ;} Increment file select menu selection
$81:A29D C9 03 00    CMP #$0003             ;\
$81:A2A0 30 0D       BMI $0D    [$A2AF]     ;} If [file select menu selection] < 3: go to BRANCH_CURSOR_SOUND
$81:A2A2 C9 06 00    CMP #$0006             ;\
$81:A2A5 10 05       BPL $05    [$A2AC]     ;} If [file select menu selection] < 6:
$81:A2A7 A9 05 00    LDA #$0005             ; File select menu selection = 5
$81:A2AA 80 03       BRA $03    [$A2AF]

$81:A2AC A9 00 00    LDA #$0000             ; File select menu selection = 0

$81:A2AF 8D 52 09    STA $0952  [$7E:0952]

; BRANCH_CURSOR_SOUND
$81:A2B2 A9 37 00    LDA #$0037             ;\
$81:A2B5 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)

; BRANCH_DONE
$81:A2B9 AD 52 09    LDA $0952  [$7E:0952]  ;\
$81:A2BC 0A          ASL A                  ;|
$81:A2BD 0A          ASL A                  ;} X = [file select menu selection] * 4
$81:A2BE AA          TAX                    ;/
$81:A2BF BD 12 A3    LDA $A312,x[$81:A312]  ;\
$81:A2C2 8D AB 19    STA $19AB  [$7E:19AB]  ;} Menu selection missile Y position = [$A312 + [X]]
$81:A2C5 BD 14 A3    LDA $A314,x[$81:A314]  ;\
$81:A2C8 8D A1 19    STA $19A1  [$7E:19A1]  ;} Menu selection missile X position = [$A312 + [X] + 2]
$81:A2CB 60          RTS                    ; Return

; BRANCH_FILE_OPERATION
$81:A2CC C9 03 00    CMP #$0003             ;\
$81:A2CF D0 15       BNE $15    [$A2E6]     ;} If [file select menu selection] = 3 (file copy):
$81:A2D1 A9 37 00    LDA #$0037             ;\
$81:A2D4 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:A2D8 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 5 (main to file copy)
$81:A2DB A5 57       LDA $57    [$7E:0057]  ;\
$81:A2DD 29 0F FF    AND #$FF0F             ;|
$81:A2E0 09 03 00    ORA #$0003             ;} Enable BG1/2 mosaic, block size = 0
$81:A2E3 85 57       STA $57    [$7E:0057]  ;/
$81:A2E5 60          RTS                    ; Return

$81:A2E6 C9 04 00    CMP #$0004             ;\
$81:A2E9 D0 1B       BNE $1B    [$A306]     ;} If [file select menu selection] = 4 (file clear):
$81:A2EB A9 37 00    LDA #$0037             ;\
$81:A2EE 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:A2F2 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:A2F5 18          CLC                    ;|
$81:A2F6 69 0F 00    ADC #$000F             ;} Menu index = 13h (main to file clear)
$81:A2F9 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:A2FC A5 57       LDA $57    [$7E:0057]  ;\
$81:A2FE 29 0F FF    AND #$FF0F             ;|
$81:A301 09 03 00    ORA #$0003             ;} Enable BG1/2 mosaic, block size = 0
$81:A304 85 57       STA $57    [$7E:0057]  ;/ <-- Missing RTS after this (fortunately, the next check will always fail)

$81:A306 C9 05 00    CMP #$0005             ;\
$81:A309 D0 06       BNE $06    [$A311]     ;} If [file select menu selection] = 5 (exit):
$81:A30B A9 21 00    LDA #$0021             ;\
$81:A30E 8D 27 07    STA $0727  [$7E:0727]  ;} Menu index = 21h (main to title sequence)

$81:A311 60          RTS
}


;;; $A312: File select menu selection missile co-ordinates ;;;
{
;                        ________ Y position
;                       |     ___ X position
;                       |    |
$81:A312             dw 0030,000E, ; Slot A
                        0058,000E, ; Slot B
                        0080,000E, ; Slot C
                        00A3,000E, ; File copy
                        00BB,000E, ; File clear
                        00D3,000E  ; Exit
}
}


;;; $A32A..B2CA: File select map ;;;
{
;;; $A32A: File select map - index 0: game options to area select map - clear BG2 and set up fade out ;;;
{
$81:A32A C2 30       REP #$30
$81:A32C 20 A6 95    JSR $95A6  [$81:95A6]  ; Clear menu tilemap
$81:A32F AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:A332 A9 00 08    LDA #$0800             ;|
$81:A335 95 D0       STA $D0,x  [$7E:00D0]  ;|
$81:A337 A9 00 36    LDA #$3600             ;|
$81:A33A 95 D2       STA $D2,x  [$7E:00D2]  ;|
$81:A33C A9 7E 00    LDA #$007E             ;|
$81:A33F 95 D4       STA $D4,x  [$7E:00D4]  ;|
$81:A341 A5 59       LDA $59    [$7E:0059]  ;} Queue transfer of 800h bytes from $7E:3600 to VRAM BG2 tilemap
$81:A343 29 FC 00    AND #$00FC             ;|
$81:A346 EB          XBA                    ;|
$81:A347 95 D5       STA $D5,x  [$7E:00D5]  ;|
$81:A349 8A          TXA                    ;|
$81:A34A 18          CLC                    ;|
$81:A34B 69 07 00    ADC #$0007             ;|
$81:A34E 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:A351 A9 00 00    LDA #$0000             ;\
$81:A354 8F 00 C4 7E STA $7EC400[$7E:C400]  ;} Palette change numerator = 0
$81:A358 20 86 94    JSR $9486  [$81:9486]  ; Load file select palettes
$81:A35B A2 00 00    LDX #$0000             ;\
                                            ;|
$81:A35E BF 00 C0 7E LDA $7EC000,x[$7E:C000];|
$81:A362 9F 00 C2 7E STA $7EC200,x[$7E:C200];|
$81:A366 E8          INX                    ;} Target BG1/2 palettes 0/1 = [BG1/2 palettes 0/1]
$81:A367 E8          INX                    ;|
$81:A368 E0 40 00    CPX #$0040             ;|
$81:A36B 30 F1       BMI $F1    [$A35E]     ;/
$81:A36D A9 00 00    LDA #$0000             ;\
$81:A370 8F 1C C2 7E STA $7EC21C[$7E:C21C]  ;} Target BG1/2 palette 0 colour Eh = 0
$81:A374 8F 3C C2 7E STA $7EC23C[$7E:C23C]  ; Target BG1/2 palette 1 colour Eh = 0
$81:A378 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 1 (fade out and load area palettes)
$81:A37B 60          RTS
}


;;; $A37C: File select map - index 1: game options to area select map - fade out and load area palettes ;;;
{
$81:A37C C2 30       REP #$30
$81:A37E A2 00 00    LDX #$0000             ;\
$81:A381 A0 40 00    LDY #$0040             ;} Advance gradual colour change of BG1/2 palettes 0/1
$81:A384 22 B8 D9 82 JSL $82D9B8[$82:D9B8]  ;/
$81:A388 90 46       BCC $46    [$A3D0]     ; If not reached target colour: return
$81:A38A 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$81:A38C 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$81:A38E 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$81:A390 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$81:A392 A2 00 00    LDX #$0000             ; X = 0
$81:A395 AD 9F 07    LDA $079F  [$7E:079F]  ; A = [area index]

; LOOP_MAP_AREA_INDEX
$81:A398 DD A0 AA    CMP $AAA0,x[$81:AAA0]  ;\
$81:A39B F0 0A       BEQ $0A    [$A3A7]     ;} If [$AAA0 + [X]] != [area index]:
$81:A39D E8          INX                    ;\
$81:A39E E8          INX                    ;} X += 2
$81:A39F E0 0C 00    CPX #$000C             ;\
$81:A3A2 30 F4       BMI $F4    [$A398]     ;} If [X] < Ch: go to LOOP_MAP_AREA_INDEX
$81:A3A4 A2 00 00    LDX #$0000             ; X = 0 (Crateria)

$81:A3A7 8A          TXA                    ;\
$81:A3A8 4A          LSR A                  ;} File select map area index = [X] / 2
$81:A3A9 8D 50 09    STA $0950  [$7E:0950]  ;/
$81:A3AC A2 00 00    LDX #$0000             ; X = 0

; LOOP_AREA_COLOURS
$81:A3AF DA          PHX
$81:A3B0 EC 9F 07    CPX $079F  [$7E:079F]  ;\
$81:A3B3 F0 05       BEQ $05    [$A3BA]     ;} If [X] != [area index]:
$81:A3B5 20 DC A3    JSR $A3DC  [$81:A3DC]  ; Load inactive area map foreground colours
$81:A3B8 80 03       BRA $03    [$A3BD]

$81:A3BA 20 D3 A3    JSR $A3D3  [$81:A3D3]  ; Load active area map foreground colours

$81:A3BD FA          PLX
$81:A3BE E8          INX                    ; Increment X
$81:A3BF E0 06 00    CPX #$0006             ;\
$81:A3C2 30 EB       BMI $EB    [$A3AF]     ;} If [X] < 6: go to LOOP_AREA_COLOURS
$81:A3C4 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 2 (load foreground tilemap)
$81:A3C7 9C 87 07    STZ $0787  [$7E:0787]  ; $0787 = 0
$81:A3CA E2 20       SEP #$20               ;\
$81:A3CC A9 02       LDA #$02               ;} Main screen layers = BG2
$81:A3CE 85 69       STA $69    [$7E:0069]  ;/

$81:A3D0 60          RTS
}


;;; $A3D1: Unused. REP #$30 ;;;
{
$81:A3D1 C2 30       REP #$30
}


;;; $A3D3: Load active area map foreground colours ;;;
{
;; Parameters:
;;     X: Area index
$81:A3D3 8A          TXA                    ;\
$81:A3D4 0A          ASL A                  ;|
$81:A3D5 AA          TAX                    ;} Y = [$A4CE + [X] / 2]
$81:A3D6 BD CE A4    LDA $A4CE,x[$81:A4CE]  ;|
$81:A3D9 A8          TAY                    ;/
$81:A3DA 80 07       BRA $07    [$A3E3]     ; Go to load area map foreground colours
}


;;; $A3DC: Load inactive area map foreground colours ;;;
{
;; Parameters:
;;     X: Area index
$81:A3DC 8A          TXA                    ;\
$81:A3DD 0A          ASL A                  ;|
$81:A3DE AA          TAX                    ;} Y = [$A4DA + [X] / 2]
$81:A3DF BD DA A4    LDA $A4DA,x[$81:A4DC]  ;|
$81:A3E2 A8          TAY                    ;/
}


;;; $A3E3: Load area map foreground colours ;;;
{
;; Parameters:
;;     Y: Area select map foreground palette table index (relative to $A4E6)

; Colour set table format:
;     ssss,dddd ; Entry 0
;     [...]     ; Entry 1...
;     FFFF      ; Terminator
; Where:
;     s: Palette data index (relative to $A40E) to load 5 colours from
;     d: Palette RAM index (relative to $7E:C000) to store colours to

; LOOP_ENTRY
$81:A3E3 B9 E6 A4    LDA $A4E6,y[$81:A4E6]  ;\
$81:A3E6 C9 FF FF    CMP #$FFFF             ;} If [$A4E6 + [Y]] = FFFFh: return
$81:A3E9 F0 22       BEQ $22    [$A40D]     ;/
$81:A3EB 5A          PHY                    ; Save Y
$81:A3EC 48          PHA                    ;\
$81:A3ED B9 E8 A4    LDA $A4E8,y[$81:A4E8]  ;} X = [$A4E6 + [Y] + 2] (palette RAM dest index)
$81:A3F0 AA          TAX                    ;} Y = [$A4E6 + [Y]] (palette data source index)
$81:A3F1 7A          PLY                    ;/
$81:A3F2 A9 05 00    LDA #$0005             ;\
$81:A3F5 85 12       STA $12    [$7E:0012]  ;} $12 = 5 (loop counter)

; LOOP_COLOURS
$81:A3F7 B9 0E A4    LDA $A40E,y[$81:A41A]  ;\
$81:A3FA 9F 00 C0 7E STA $7EC000,x[$7E:C0AC];} $7E:C000 + [X] = [$A40E + [Y]]
$81:A3FE E8          INX                    ;\
$81:A3FF E8          INX                    ;} X += 2
$81:A400 C8          INY                    ;\
$81:A401 C8          INY                    ;} Y += 2
$81:A402 C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$81:A404 D0 F1       BNE $F1    [$A3F7]     ; If [$12] != 0: go to LOOP_COLOURS
$81:A406 7A          PLY                    ; Restore Y
$81:A407 C8          INY                    ;\
$81:A408 C8          INY                    ;|
$81:A409 C8          INY                    ;} Y += 4 (next palette table entry)
$81:A40A C8          INY                    ;/
$81:A40B 80 D6       BRA $D6    [$A3E3]     ; Go to LOOP_ENTRY

$81:A40D 60          RTS
}


;;; $A40E: Area select map foreground palette data ;;;
{
;                             2                         Ch                        16h
$81:A40E             dw 0000, 7FE0,7EA0,7D40,7C00,4000, 01DB,0196,0150,00EB,00A5, 033B,0296,01F0,014B,00A5 ; 0.   Active.   WS-Crateria,  Crateria, Crateria
$81:A42E             dw 0400, 6400,4C00,3400,1C00,0400, 0013,000F,000A,0006,0001, 0BB1,0B0D,0669,05A4,0100 ; 20h. Active.   Maridia,      Norfair,  Brinstar
$81:A44E             dw 0000, 7FE0,7EA0,7D40,7C00,4000, 6417,4C12,380D,2007,0802, 5280,4620,39C0,2940,14A5 ; 40h. Active.   Wrecked Ship, Tourian,  Wrecked Ship
$81:A46E             dw 0000, 35AD,2D6B,2529,18C6,1084, 4A52,3DEF,318C,2108,14A5, 56B5,4A52,39CE,2D6B,1CE7 ; 60h. Inactive. WS-Crateria,  Crateria, Crateria
$81:A48E             dw 0000, 18C6,14A5,1084,0842,0421, 1084,0C63,0842,0421,0000, 2108,1CE7,14A5,1084,0842 ; 80h. Inactive. Maridia,      Norfair,  Brinstar
$81:A4AE             dw 0000, 35AD,2D6B,2529,18C6,1084, 294A,2108,1CE7,14A5,0C63, 4A52,3DEF,318C,2108,14A5 ; A0h. Inactive. Wrecked Ship, Tourian,  Wrecked Ship
}


;;; $A4CE: Area select map foreground palette table ;;;
{
; Area select map foreground palette table indices (relative to $A4E6)
$81:A4CE             dw 0000, 000A, 0010, 0016, 0024, 002A ; Active
$81:A4DA             dw 0030, 003A, 0040, 0046, 0054, 005A ; Inactive


;                        ________ Palette data index (relative to $A40E)
;                       |     ___ Palette RAM index (relative to $7E:C000)
;                       |    |
$81:A4E6             dw 000C,00AC, ; Active - Crateria - orange
                        0016,00B6, ; Active - Crateria - yellow
                        FFFF

$81:A4F0             dw 0036,00D6, ; Active - Brinstar
                        FFFF

$81:A4F6             dw 002C,00CC, ; Active - Norfair
                        FFFF

$81:A4FC             dw 0002,00A2, ; Active - Wrecked Ship - part that overlaps with Crateria
                        0042,00E2, ; Active - Wrecked Ship - dark blue
                        0056,00F6, ; Active - Wrecked Ship - light blue
                        FFFF

$81:A50A             dw 0022,00C2, ; Active - Maridia
                        FFFF

$81:A510             dw 004C,00EC, ; Active - Tourian
                        FFFF

$81:A516             dw 006C,00AC, ; Inactive - Crateria - dark greys
                        0076,00B6, ; Inactive - Crateria - light greys
                        FFFF

$81:A520             dw 0096,00D6, ; Inactive - Brinstar
                        FFFF

$81:A526             dw 008C,00CC, ; Inactive - Norfair
                        FFFF

$81:A52C             dw 0062,00A2, ; Inactive - Wrecked Ship - part that overlaps with Crateria
                        00A2,00E2, ; Inactive - Wrecked Ship - dark greys
                        00B6,00F6, ; Inactive - Wrecked Ship - light greys
                        FFFF

$81:A53A             dw 0082,00C2, ; Inactive - Maridia
                        FFFF

$81:A540             dw 00AC,00EC, ; Inactive - Tourian
                        FFFF
}


;;; $A546: File select map - index 2/11h: load area select foreground tilemap ;;;
{
$81:A546 C2 30       REP #$30
$81:A548 AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:A54B A9 00 08    LDA #$0800             ;|
$81:A54E 95 D0       STA $D0,x  [$7E:00D0]  ;|
$81:A550 A9 1A B7    LDA #$B71A             ;|
$81:A553 95 D2       STA $D2,x  [$7E:00D2]  ;|
$81:A555 A9 81 00    LDA #$0081             ;|
$81:A558 95 D4       STA $D4,x  [$7E:00D4]  ;|
$81:A55A A5 58       LDA $58    [$7E:0058]  ;} Queue transfer of 800h bytes from $81:B71A to VRAM BG1 tilemap
$81:A55C 29 FC 00    AND #$00FC             ;|
$81:A55F EB          XBA                    ;|
$81:A560 95 D5       STA $D5,x  [$7E:00D5]  ;|
$81:A562 8A          TXA                    ;|
$81:A563 18          CLC                    ;|
$81:A564 69 07 00    ADC #$0007             ;|
$81:A567 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:A56A A5 51       LDA $51    [$7E:0051]  ;\
$81:A56C 29 00 FF    AND #$FF00             ;|
$81:A56F 09 0F 00    ORA #$000F             ;} Set max brightness
$81:A572 85 51       STA $51    [$7E:0051]  ;/
$81:A574 EE 27 07    INC $0727  [$7E:0727]  ; Increment menu index (load background tilemap)
$81:A577 60          RTS
}


;;; $A578: File select map - index 12h: room select map to area select map - load background tilemap ;;;
{
$81:A578 C2 30       REP #$30
$81:A57A EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 13h (prepare expanding/contracting square transition)
$81:A57D AC 9F 07    LDY $079F  [$7E:079F]  ; Y = [area index]
$81:A580 80 08       BRA $08    [$A58A]     ; Go to load area select background tilemap
}


;;; $A582: File select map - index 3: game options to area select map - load background tilemap ;;;
{
$81:A582 C2 30       REP #$30
$81:A584 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 4 (prepare expanding/contracting square transition)
$81:A587 AC 9F 07    LDY $079F  [$7E:079F]  ; Y = [area index]
}


;;; $A58A: Load area select background tilemap ;;;
{
;; Parameters:
;;     Y: Area index
$81:A58A AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:A58D A9 00 08    LDA #$0800             ;|
$81:A590 95 D0       STA $D0,x  [$7E:00D0]  ;|
$81:A592 98          TYA                    ;|
$81:A593 EB          XBA                    ;|
$81:A594 0A          ASL A                  ;|
$81:A595 0A          ASL A                  ;|
$81:A596 0A          ASL A                  ;|
$81:A597 18          CLC                    ;|
$81:A598 69 1A BF    ADC #$BF1A             ;|
$81:A59B 95 D2       STA $D2,x  [$7E:00D2]  ;} Queue transfer of 800h bytes from $81:BF1A + [Y] * 800h to VRAM BG3 tilemap
$81:A59D A9 81 00    LDA #$0081             ;|
$81:A5A0 95 D4       STA $D4,x  [$7E:00D4]  ;|
$81:A5A2 A5 5A       LDA $5A    [$7E:005A]  ;|
$81:A5A4 29 FC 00    AND #$00FC             ;|
$81:A5A7 EB          XBA                    ;|
$81:A5A8 95 D5       STA $D5,x  [$7E:00D5]  ;|
$81:A5AA 8A          TXA                    ;|
$81:A5AB 18          CLC                    ;|
$81:A5AC 69 07 00    ADC #$0007             ;|
$81:A5AF 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:A5B2 60          RTS
}


;;; $A5B3: File select map - index 4/13h: prepare expanding/contracting square transition to area select map ;;;
{
$81:A5B3 E2 20       SEP #$20
$81:A5B5 A9 04       LDA #$04               ;\
$81:A5B7 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3
$81:A5B9 8D 2D 21    STA $212D  [$7E:212D]  ;/
$81:A5BC A9 04       LDA #$04               ; >_<
$81:A5BE 85 6D       STA $6D    [$7E:006D]  ;\
$81:A5C0 8D 2F 21    STA $212F  [$7E:212F]  ;} Disable BG3 in window area subscreen
$81:A5C3 A9 02       LDA #$02               ;\
$81:A5C5 85 6F       STA $6F    [$7E:006F]  ;} Enable subscreen layers
$81:A5C7 8D 30 21    STA $2130  [$7E:2130]  ;/
$81:A5CA A9 25       LDA #$25               ;\
$81:A5CC 85 72       STA $72    [$7E:0072]  ;} Enable colour math on BG1/BG3/backdrop
$81:A5CE 8D 31 21    STA $2131  [$7E:2131]  ;/
$81:A5D1 A9 80       LDA #$80               ;\
$81:A5D3 85 76       STA $76    [$7E:0076]  ;|
$81:A5D5 A9 40       LDA #$40               ;|
$81:A5D7 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (0, 0, 0) (transparent)
$81:A5D9 A9 20       LDA #$20               ;|
$81:A5DB 85 74       STA $74    [$7E:0074]  ;/
$81:A5DD 20 1C A6    JSR $A61C  [$81:A61C]  ; Set up initial expanding square transition HDMA
$81:A5E0 A9 0C       LDA #$0C               ;\
$81:A5E2 85 85       STA $85    [$7E:0085]  ;} Enable HDMA channels 2/3
$81:A5E4 8D 0C 42    STA $420C  [$7E:420C]  ;/
$81:A5E7 20 F6 A5    JSR $A5F6  [$81:A5F6]  ; Configure window 1 for expanding square transition
$81:A5EA 9C B0 18    STZ $18B0  [$7E:18B0]  ;\
$81:A5ED 9C B1 18    STZ $18B1  [$7E:18B1]  ;} Disable HDMA objects
$81:A5F0 EE 27 07    INC $0727  [$7E:0727]  ; Increment menu index (expanding/contracting square transition)
$81:A5F3 C2 30       REP #$30
$81:A5F5 60          RTS
}


;;; $A5F6: Configure window 1 for expanding square transition ;;;
{
$81:A5F6 E2 20       SEP #$20
$81:A5F8 A9 13       LDA #$13               ;\
$81:A5FA 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$81:A5FC 8D 2C 21    STA $212C  [$7E:212C]  ;/
$81:A5FF A9 13       LDA #$13               ; >_<
$81:A601 85 6C       STA $6C    [$7E:006C]  ;\
$81:A603 8D 2E 21    STA $212E  [$7E:212E]  ;} Disable BG1/BG2/sprites in window area subscreen
$81:A606 A9 23       LDA #$23               ;\
$81:A608 85 60       STA $60    [$7E:0060]  ;} Enable BG1 window 1 exclusive mask and BG2 window 1 inclusive mask
$81:A60A 8D 23 21    STA $2123  [$7E:2123]  ;/
$81:A60D A9 03       LDA #$03               ;\
$81:A60F 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 1 exclusive mask
$81:A611 8D 24 21    STA $2124  [$7E:2124]  ;/
$81:A614 A9 23       LDA #$23               ;\
$81:A616 85 62       STA $62    [$7E:0062]  ;} Enable sprites window 1 exclusive mask and colour math window 1 inclusive mask
$81:A618 8D 25 21    STA $2125  [$7E:2125]  ;/
$81:A61B 60          RTS
}


;;; $A61C: Set up initial expanding square transition HDMA ;;;
{
$81:A61C E2 20       SEP #$20
$81:A61E A9 00       LDA #$00               ;\
$81:A620 8F 20 9E 7E STA $7E9E20[$7E:9E20]  ;} Expanding square top/bottom margin right position = 0
$81:A624 8F 21 9E 7E STA $7E9E21[$7E:9E21]  ;/
$81:A628 3A          DEC A                  ;\
$81:A629 8F 22 9E 7E STA $7E9E22[$7E:9E22]  ;} Expanding square top/bottom margin left position = FFFFh
$81:A62D 8F 23 9E 7E STA $7E9E23[$7E:9E23]  ;/
$81:A631 A9 7F       LDA #$7F               ;\
$81:A633 8F 32 9E 7E STA $7E9E32[$7E:9E32]  ;} Expanding square left position = 7Fh
$81:A637 A9 81       LDA #$81               ;\
$81:A639 8F 36 9E 7E STA $7E9E36[$7E:9E36]  ;} Expanding square right position = 81h
$81:A63D A9 6F       LDA #$6F               ;\
$81:A63F 8F 00 9E 7E STA $7E9E00[$7E:9E00]  ;|
$81:A643 A9 22       LDA #$22               ;|
$81:A645 8F 01 9E 7E STA $7E9E01[$7E:9E01]  ;|
$81:A649 A9 9E       LDA #$9E               ;|
$81:A64B 8F 02 9E 7E STA $7E9E02[$7E:9E02]  ;|
$81:A64F A9 01       LDA #$01               ;|
$81:A651 8F 03 9E 7E STA $7E9E03[$7E:9E03]  ;|
$81:A655 A9 32       LDA #$32               ;|
$81:A657 8F 04 9E 7E STA $7E9E04[$7E:9E04]  ;|
$81:A65B A9 9E       LDA #$9E               ;|
$81:A65D 8F 05 9E 7E STA $7E9E05[$7E:9E05]  ;|
$81:A661 A9 01       LDA #$01               ;} $7E:9E00..0B = 6Fh,$9E22, 1,$9E32, 1,$9E32, 6Fh,$9E20 (expanding square transition window 1 left position indirect HDMA table)
$81:A663 8F 06 9E 7E STA $7E9E06[$7E:9E06]  ;|
$81:A667 A9 32       LDA #$32               ;|
$81:A669 8F 07 9E 7E STA $7E9E07[$7E:9E07]  ;|
$81:A66D A9 9E       LDA #$9E               ;|
$81:A66F 8F 08 9E 7E STA $7E9E08[$7E:9E08]  ;|
$81:A673 A9 6F       LDA #$6F               ;|
$81:A675 8F 09 9E 7E STA $7E9E09[$7E:9E09]  ;|
$81:A679 A9 20       LDA #$20               ;|
$81:A67B 8F 0A 9E 7E STA $7E9E0A[$7E:9E0A]  ;|
$81:A67F A9 9E       LDA #$9E               ;|
$81:A681 8F 0B 9E 7E STA $7E9E0B[$7E:9E0B]  ;/
$81:A685 A9 40       LDA #$40               ;\
$81:A687 8D 20 43    STA $4320  [$7E:4320]  ;|
$81:A68A A9 26       LDA #$26               ;|
$81:A68C 8D 21 43    STA $4321  [$7E:4321]  ;|
$81:A68F A9 00       LDA #$00               ;|
$81:A691 8D 22 43    STA $4322  [$7E:4322]  ;} Set up DMA channel 2 for 8-bit HDMA to window 1 left position with indirect table $7E:9E00 and data table bank $7E
$81:A694 A9 9E       LDA #$9E               ;|
$81:A696 8D 23 43    STA $4323  [$7E:4323]  ;|
$81:A699 A9 7E       LDA #$7E               ;|
$81:A69B 8D 24 43    STA $4324  [$7E:4324]  ;|
$81:A69E 8D 27 43    STA $4327  [$7E:4327]  ;/
$81:A6A1 9C 25 43    STZ $4325  [$7E:4325]
$81:A6A4 9C 26 43    STZ $4326  [$7E:4326]
$81:A6A7 9C 28 43    STZ $4328  [$7E:4328]
$81:A6AA 9C 29 43    STZ $4329  [$7E:4329]
$81:A6AD 9C 2A 43    STZ $432A  [$7E:432A]
$81:A6B0 A9 6F       LDA #$6F               ;\
$81:A6B2 8F 10 9E 7E STA $7E9E10[$7E:9E10]  ;|
$81:A6B6 A9 20       LDA #$20               ;|
$81:A6B8 8F 11 9E 7E STA $7E9E11[$7E:9E11]  ;|
$81:A6BC A9 9E       LDA #$9E               ;|
$81:A6BE 8F 12 9E 7E STA $7E9E12[$7E:9E12]  ;|
$81:A6C2 A9 01       LDA #$01               ;|
$81:A6C4 8F 13 9E 7E STA $7E9E13[$7E:9E13]  ;|
$81:A6C8 A9 36       LDA #$36               ;|
$81:A6CA 8F 14 9E 7E STA $7E9E14[$7E:9E14]  ;|
$81:A6CE A9 9E       LDA #$9E               ;|
$81:A6D0 8F 15 9E 7E STA $7E9E15[$7E:9E15]  ;|
$81:A6D4 A9 01       LDA #$01               ;} $7E:9E10..1B = 6Fh,$9E20, 1,$9E36, 1,$9E36, 6Fh,$9E20 (expanding square transition window 1 right position indirect HDMA table)
$81:A6D6 8F 16 9E 7E STA $7E9E16[$7E:9E16]  ;|
$81:A6DA A9 36       LDA #$36               ;|
$81:A6DC 8F 17 9E 7E STA $7E9E17[$7E:9E17]  ;|
$81:A6E0 A9 9E       LDA #$9E               ;|
$81:A6E2 8F 18 9E 7E STA $7E9E18[$7E:9E18]  ;|
$81:A6E6 A9 6F       LDA #$6F               ;|
$81:A6E8 8F 19 9E 7E STA $7E9E19[$7E:9E19]  ;|
$81:A6EC A9 20       LDA #$20               ;|
$81:A6EE 8F 1A 9E 7E STA $7E9E1A[$7E:9E1A]  ;|
$81:A6F2 A9 9E       LDA #$9E               ;|
$81:A6F4 8F 1B 9E 7E STA $7E9E1B[$7E:9E1B]  ;/
$81:A6F8 A9 40       LDA #$40               ;\
$81:A6FA 8D 30 43    STA $4330  [$7E:4330]  ;|
$81:A6FD A9 27       LDA #$27               ;|
$81:A6FF 8D 31 43    STA $4331  [$7E:4331]  ;|
$81:A702 A9 10       LDA #$10               ;|
$81:A704 8D 32 43    STA $4332  [$7E:4332]  ;} Set up DMA channel 3 for 8-bit HDMA to window 1 right position with indirect table $7E:9E10 and data table bank $7E
$81:A707 A9 9E       LDA #$9E               ;|
$81:A709 8D 33 43    STA $4333  [$7E:4333]  ;|
$81:A70C A9 7E       LDA #$7E               ;|
$81:A70E 8D 34 43    STA $4334  [$7E:4334]  ;|
$81:A711 8D 37 43    STA $4337  [$7E:4337]  ;/
$81:A714 9C 35 43    STZ $4335  [$7E:4335]
$81:A717 9C 36 43    STZ $4336  [$7E:4336]
$81:A71A 9C 38 43    STZ $4338  [$7E:4338]
$81:A71D 9C 39 43    STZ $4339  [$7E:4339]
$81:A720 9C 3A 43    STZ $433A  [$7E:433A]
$81:A723 60          RTS
}


;;; $A724: Expanding square transition speed ;;;
{
$81:A724             db 04
}


;;; $A725: File select map - index 5: game options to area select map - expanding square transition ;;;
{
; Prepares the room select map when finished transition
$81:A725 C2 30       REP #$30
$81:A727 20 7E A9    JSR $A97E  [$81:A97E]  ; Draw area select map labels
$81:A72A E2 20       SEP #$20
$81:A72C AF 00 9E 7E LDA $7E9E00[$7E:9E00]  ;\
$81:A730 38          SEC                    ;} A = [$7E:9E00] - 4 (margin height)
$81:A731 ED 24 A7    SBC $A724  [$81:A724]  ;/
$81:A734 30 41       BMI $41    [$A777]     ; If [A] >= 0:
$81:A736 8F 00 9E 7E STA $7E9E00[$7E:9E00]  ; $7E:9E00 = [A]
$81:A73A 8F 09 9E 7E STA $7E9E09[$7E:9E09]  ; $7E:9E09 = [A]
$81:A73E 8F 10 9E 7E STA $7E9E10[$7E:9E10]  ; $7E:9E10 = [A]
$81:A742 8F 19 9E 7E STA $7E9E19[$7E:9E19]  ; $7E:9E19 = [A]
$81:A746 AF 03 9E 7E LDA $7E9E03[$7E:9E03]  ;\
$81:A74A 18          CLC                    ;} A = [$7E:9E03] + 4 (square height / 2)
$81:A74B 6D 24 A7    ADC $A724  [$81:A724]  ;/
$81:A74E 8F 03 9E 7E STA $7E9E03[$7E:9E03]  ; $7E:9E03 = [A]
$81:A752 8F 06 9E 7E STA $7E9E06[$7E:9E06]  ; $7E:9E06 = [A]
$81:A756 8F 13 9E 7E STA $7E9E13[$7E:9E13]  ; $7E:9E13 = [A]
$81:A75A 8F 16 9E 7E STA $7E9E16[$7E:9E16]  ; $7E:9E16 = [A]
$81:A75E AF 32 9E 7E LDA $7E9E32[$7E:9E32]  ;\
$81:A762 38          SEC                    ;|
$81:A763 ED 24 A7    SBC $A724  [$81:A724]  ;} Expanding square left position -= 4
$81:A766 8F 32 9E 7E STA $7E9E32[$7E:9E32]  ;/
$81:A76A AF 36 9E 7E LDA $7E9E36[$7E:9E36]  ;\
$81:A76E 18          CLC                    ;|
$81:A76F 6D 24 A7    ADC $A724  [$81:A724]  ;} Expanding square right position += 4
$81:A772 8F 36 9E 7E STA $7E9E36[$7E:9E36]  ;/
$81:A776 60          RTS                    ; Return

$81:A777 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 6 (area select map)
$81:A77A A5 69       LDA $69    [$7E:0069]  ;\
$81:A77C 29 FD       AND #$FD               ;} Disable main screen layer BG2
$81:A77E 85 69       STA $69    [$7E:0069]  ;/
$81:A780 A5 6C       LDA $6C    [$7E:006C]  ; >_<;
$81:A782 29 00       AND #$00               ;\
$81:A784 85 6C       STA $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$81:A786 A5 6D       LDA $6D    [$7E:006D]  ;\
$81:A788 29 00       AND #$00               ;} >_<;
$81:A78A 85 6D       STA $6D    [$7E:006D]  ; Enable all layers in window area subscreen
$81:A78C A9 18       LDA #$18               ;\
$81:A78E 85 B7       STA $B7    [$7E:00B7]  ;|
$81:A790 A9 00       LDA #$00               ;} BG2 Y scroll = 18h
$81:A792 85 B8       STA $B8    [$7E:00B8]  ;/
$81:A794 C2 30       REP #$30
$81:A796 A9 01 00    LDA #$0001             ;\
$81:A799 8D 3B 07    STA $073B  [$7E:073B]  ;} Pause screen palette animation timer = 1
$81:A79C A2 00 00    LDX #$0000             ;\
                                            ;|
$81:A79F BF 00 E0 B6 LDA $B6E000,x[$B6:E000];|
$81:A7A3 9F 00 40 7E STA $7E4000,x[$7E:4000];|
$81:A7A7 E8          INX                    ;} $7E:4000..463F = [$B6:E000..E63F] (BG2 room select map tilemap)
$81:A7A8 E8          INX                    ;|
$81:A7A9 E0 40 06    CPX #$0640             ;|
$81:A7AC 30 F1       BMI $F1    [$A79F]     ;/
$81:A7AE A9 01 28    LDA #$2801             ;\
                                            ;|
$81:A7B1 9F 00 40 7E STA $7E4000,x[$7E:4640];|
$81:A7B5 E8          INX                    ;} $7E:4640..47FF = 2801h (pointless, gets overwritten below anyway)
$81:A7B6 E8          INX                    ;|
$81:A7B7 E0 00 08    CPX #$0800             ;|
$81:A7BA 30 F5       BMI $F5    [$A7B1]     ;/
$81:A7BC A9 54 41    LDA #$4154             ;\
$81:A7BF 85 00       STA $00    [$7E:0000]  ;|
$81:A7C1 A9 7E 00    LDA #$007E             ;} $00 = $7E:4154
$81:A7C4 85 02       STA $02    [$7E:0002]  ;/
$81:A7C6 22 28 96 82 JSL $829628[$82:9628]  ; Draw room select map area label
$81:A7CA A0 40 01    LDY #$0140             ;\
$81:A7CD A2 7E 07    LDX #$077E             ;|
                                            ;|
$81:A7D0 B9 4B B1    LDA $B14B,y[$81:B28B]  ;|
$81:A7D3 9F 00 40 7E STA $7E4000,x[$7E:477E];|
$81:A7D7 CA          DEX                    ;} $7E:4640..477F = [$B14D..B28C] (room select map controls)
$81:A7D8 CA          DEX                    ;|
$81:A7D9 88          DEY                    ;|
$81:A7DA 88          DEY                    ;|
$81:A7DB D0 F3       BNE $F3    [$A7D0]     ;/
$81:A7DD AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:A7E0 A9 00 08    LDA #$0800             ;|
$81:A7E3 95 D0       STA $D0,x  [$7E:00D0]  ;|
$81:A7E5 A9 00 40    LDA #$4000             ;|
$81:A7E8 95 D2       STA $D2,x  [$7E:00D2]  ;|
$81:A7EA A9 7E 00    LDA #$007E             ;|
$81:A7ED 95 D4       STA $D4,x  [$7E:00D4]  ;|
$81:A7EF A5 59       LDA $59    [$7E:0059]  ;} Queue transfer of $7E:4000..47FF to VRAM BG2 tilemap
$81:A7F1 29 FC 00    AND #$00FC             ;|
$81:A7F4 EB          XBA                    ;|
$81:A7F5 95 D5       STA $D5,x  [$7E:00D5]  ;|
$81:A7F7 8A          TXA                    ;|
$81:A7F8 18          CLC                    ;|
$81:A7F9 69 07 00    ADC #$0007             ;|
$81:A7FC 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:A7FF 60          RTS
}


;;; $A800: File select map - index 6: area select map ;;;
{
; BUG: The check for debug mode here loads zero if debug mode isn't enabled,
;      causing the subsequent BITs that expect newly pressed controller 1 input in A to always flag zero
;      This means pressing up/left/down/right/select the same frame as B/A/start negates the B/A/start input
$81:A800 C2 30       REP #$30
$81:A802 A5 8F       LDA $8F    [$7E:008F]  ;\
$81:A804 89 00 0A    BIT #$0A00             ;} If newly pressing up or left:
$81:A807 F0 08       BEQ $08    [$A811]     ;/
$81:A809 AD D1 05    LDA $05D1  [$7E:05D1]  ;\ <-- clobbers A >_<;
$81:A80C F0 10       BEQ $10    [$A81E]     ;} If debug mode enabled:
$81:A80E 4C 3E A8    JMP $A83E  [$81:A83E]  ; Go to BRANCH_DEBUG_PREVIOUS

$81:A811 89 00 25    BIT #$2500             ;\ Else (not newly pressing up or left):
$81:A814 F0 08       BEQ $08    [$A81E]     ;} If newly pressing select, down or right:
$81:A816 AD D1 05    LDA $05D1  [$7E:05D1]  ;\ <-- clobbers A >_<;
$81:A819 F0 03       BEQ $03    [$A81E]     ;} If debug mode enabled:
$81:A81B 4C 70 A8    JMP $A870  [$81:A870]  ; Go to BRANCH_DEBUG_NEXT

$81:A81E 89 00 80    BIT #$8000             ;\
$81:A821 F0 09       BEQ $09    [$A82C]     ;} If newly pressing B:
$81:A823 A9 16 00    LDA #$0016             ;\
$81:A826 8D 27 07    STA $0727  [$7E:0727]  ;} Menu index = 16h (area select map to game options)
$81:A829 4C 7E A9    JMP $A97E  [$81:A97E]  ; Go to draw area select map labels

$81:A82C 89 80 10    BIT #$1080             ;\
$81:A82F F0 0A       BEQ $0A    [$A83B]     ;} If newly pressing A or start:
$81:A831 A9 38 00    LDA #$0038             ;\
$81:A834 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$81:A838 4C A9 A8    JMP $A8A9  [$81:A8A9]  ; Go to select file select map area

$81:A83B 4C 7E A9    JMP $A97E  [$81:A97E]  ; Go to draw area select map labels

; BRANCH_DEBUG_PREVIOUS
$81:A83E 64 18       STZ $18    [$7E:0018]  ; >_<
$81:A840 A5 16       LDA $16    [$7E:0016]  ;\
$81:A842 85 18       STA $18    [$7E:0018]  ;} $18 = [$16] ($16 doesn't seem to be set to anything, $18 never seems to be used)
$81:A844 AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:A847 20 98 A8    JSR $A898  [$81:A898]  ;} A = ([file select map area index] - 1) % 6
$81:A84A 20 31 A9    JSR $A931  [$81:A931]  ;\
$81:A84D D0 14       BNE $14    [$A863]     ;} If file select map area can't be selected:
$81:A84F A5 1C       LDA $1C    [$7E:001C]  ;\
$81:A851 20 98 A8    JSR $A898  [$81:A898]  ;} A = ([file select map area index] - 2) % 6
$81:A854 20 31 A9    JSR $A931  [$81:A931]  ;\
$81:A857 D0 0A       BNE $0A    [$A863]     ;} If file select map area can't be selected:
$81:A859 A5 1C       LDA $1C    [$7E:001C]  ;\
$81:A85B 20 98 A8    JSR $A898  [$81:A898]  ;} A = ([file select map area index] - 3) % 6
$81:A85E 20 31 A9    JSR $A931  [$81:A931]  ;\
$81:A861 F0 D8       BEQ $D8    [$A83B]     ;} If file select map area can't be selected: go to draw area select map labels

$81:A863 A9 37 00    LDA #$0037             ;\
$81:A866 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:A86A 20 58 A9    JSR $A958  [$81:A958]  ; Switch active file select map area
$81:A86D 4C 7E A9    JMP $A97E  [$81:A97E]  ; Go to draw area select map labels

; BRANCH_DEBUG_NEXT
$81:A870 A9 06 00    LDA #$0006             ;\
$81:A873 85 16       STA $16    [$7E:0016]  ;} $16 = 6
$81:A875 AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:A878 85 1C       STA $1C    [$7E:001C]  ;} $1C = [file select map area index]

; LOOP
$81:A87A A5 1C       LDA $1C    [$7E:001C]  ;\
$81:A87C 20 9F A8    JSR $A89F  [$81:A89F]  ;} A = ([$1C] + 1) % 6
$81:A87F 20 31 A9    JSR $A931  [$81:A931]  ;\
$81:A882 D0 07       BNE $07    [$A88B]     ;} If file select map area can't be selected:
$81:A884 C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$81:A886 D0 F2       BNE $F2    [$A87A]     ; If [$16] != 0: go to LOOP
$81:A888 4C 7E A9    JMP $A97E  [$81:A97E]  ; Go to draw area select map labels

$81:A88B 20 58 A9    JSR $A958  [$81:A958]  ; Switch active file select map area
$81:A88E A9 37 00    LDA #$0037             ;\
$81:A891 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 37h, sound library 1, max queued sounds allowed = 6 (moved cursor)
$81:A895 4C 7E A9    JMP $A97E  [$81:A97E]  ; Go to draw area select map labels
}


;;; $A898: A = ([A] - 1) % 6 ;;;
{
$81:A898 3A          DEC A
$81:A899 10 03       BPL $03    [$A89E]
$81:A89B A9 05 00    LDA #$0005

$81:A89E 60          RTS
}


;;; $A89F: A = ([A] + 1) % 6 ;;;
{
$81:A89F 1A          INC A
$81:A8A0 C9 06 00    CMP #$0006
$81:A8A3 30 03       BMI $03    [$A8A8]
$81:A8A5 A9 00 00    LDA #$0000

$81:A8A8 60          RTS
}


;;; $A8A9: Select file select map area ;;;
{
$81:A8A9 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 7 (area select map to room select map)
$81:A8AC AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$81:A8AF D0 11       BNE $11    [$A8C2]     ;} If debug mode not enabled:
$81:A8B1 AF 18 D9 7E LDA $7ED918[$7E:D918]  ;\
$81:A8B5 8D 9F 07    STA $079F  [$7E:079F]  ;} Area index = [SRAM area index]
$81:A8B8 AF 16 D9 7E LDA $7ED916[$7E:D916]  ;\
$81:A8BC 8D 8B 07    STA $078B  [$7E:078B]  ;} Load station index = [SRAM save station index]
$81:A8BF 4C 3B A8    JMP $A83B  [$81:A83B]  ; Go to draw area select map labels

$81:A8C2 AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:A8C5 0A          ASL A                  ;|
$81:A8C6 AA          TAX                    ;} Area index = [$AAA0 + [file select map area index] * 2]
$81:A8C7 BD A0 AA    LDA $AAA0,x            ;|
$81:A8CA 8D 9F 07    STA $079F  [$7E:079F]  ;/
$81:A8CD 0A          ASL A                  ;\
$81:A8CE AA          TAX                    ;|
$81:A8CF BF F8 D8 7E LDA $7ED8F8,x          ;} $12 = [$7E:D8F8 + [area index] * 2] (used save stations / debug elevators)
$81:A8D3 85 12       STA $12    [$7E:0012]  ;/
$81:A8D5 A2 00 00    LDX #$0000             ; X = 0
$81:A8D8 A9 82 00    LDA #$0082             ;\
$81:A8DB 85 02       STA $02    [$7E:0002]  ;} $02 = $82
$81:A8DD A9 0B C8    LDA #$C80B             ;\
$81:A8E0 85 00       STA $00    [$7E:0000]  ;|
$81:A8E2 AD 9F 07    LDA $079F  [$7E:079F]  ;|
$81:A8E5 0A          ASL A                  ;} A = [$82:C80B + [area index] * 2] (save point map icon positions)
$81:A8E6 A8          TAY                    ;|
$81:A8E7 B7 00       LDA [$00],y            ;/

$81:A8E9 F0 FE       BEQ $FE    [$A8E9]     ; If [A] = 0: crash
$81:A8EB 85 00       STA $00    [$7E:0000]  ; $00 = [A]
$81:A8ED A9 10 00    LDA #$0010             ;\
$81:A8F0 85 14       STA $14    [$7E:0014]  ;} $14 = 10h (loop counter)

; LOOP_SAVES_ELEVATORS
$81:A8F2 46 12       LSR $12    [$7E:0012]  ; $12 >>= 1
$81:A8F4 90 13       BCC $13    [$A909]     ; If carry set:
$81:A8F6 8A          TXA                    ;\
$81:A8F7 0A          ASL A                  ;|
$81:A8F8 0A          ASL A                  ;} A = [[$00] + [X] * 4]
$81:A8F9 A8          TAY                    ;|
$81:A8FA B7 00       LDA [$00],y            ;/
$81:A8FC C9 FE FF    CMP #$FFFE             ;\
$81:A8FF F0 08       BEQ $08    [$A909]     ;} If [A] != FFFEh:
$81:A901 C9 FF FF    CMP #$FFFF             ;\
$81:A904 D0 25       BNE $25    [$A92B]     ;} If [A] != FFFFh: go to BRANCH_FOUND
$81:A906 A2 FF FF    LDX #$FFFF             ; X = -1

$81:A909 E8          INX                    ; Increment X
$81:A90A C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$81:A90C D0 E4       BNE $E4    [$A8F2]     ; If [$14] != 0: go to LOOP_SAVES_ELEVATORS
$81:A90E A9 08 00    LDA #$0008             ; >_<; (missing `STA $14`)

; LOOP_DEBUG_SAVE_POINTS
$81:A911 8A          TXA                    ;\
$81:A912 0A          ASL A                  ;|
$81:A913 0A          ASL A                  ;} A = [[$00] + [X] * 4]
$81:A914 A8          TAY                    ;|
$81:A915 B7 00       LDA [$00],y            ;/
$81:A917 C9 FE FF    CMP #$FFFE             ;\
$81:A91A F0 08       BEQ $08    [$A924]     ;} If [A] != FFFEh:
$81:A91C C9 FF FF    CMP #$FFFF             ;\
$81:A91F D0 0A       BNE $0A    [$A92B]     ;} If [A] != FFFFh: go to BRANCH_FOUND
$81:A921 A2 FF FF    LDX #$FFFF             ; X = -1

$81:A924 E8          INX                    ; Increment X
$81:A925 C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$81:A927 D0 E8       BNE $E8    [$A911]     ; If [$14] != 0: go to LOOP_DEBUG_SAVE_POINTS

$81:A929 80 FE       BRA $FE    [$A929]     ; Crash

; BRANCH_FOUND
$81:A92B 8E 8B 07    STX $078B  [$7E:078B]  ; Load station index = [X]
$81:A92E 4C 3B A8    JMP $A83B  [$81:A83B]  ; Go to draw area select map labels
}


;;; $A931: Debug. Check if file select map area can be selected ;;;
{
;; Parameters:
;;     A: File select map area index
;; Returns:
;;     Zero: Clear if used save station or elevator in area, or if area has debug elevator markers (which they all do); otherwise set

; Always returns zero clear

$81:A931 85 1C       STA $1C    [$7E:001C]  ; $1C = [A]
$81:A933 0A          ASL A                  ;\
$81:A934 AA          TAX                    ;|
$81:A935 BD A0 AA    LDA $AAA0,x            ;} X = [$AAA0 + [A] * 2]
$81:A938 0A          ASL A                  ;|
$81:A939 AA          TAX                    ;/
$81:A93A BF F8 D8 7E LDA $7ED8F8,x          ;\
$81:A93E D0 17       BNE $17    [$A957]     ;} If [$7E:D8F8 + [X]] != 0 (used save station / debug elevator): return zero clear
$81:A940 8B          PHB
$81:A941 A9 00 82    LDA #$8200             ;\
$81:A944 48          PHA                    ;|
$81:A945 AB          PLB                    ;} DB = $82
$81:A946 AB          PLB                    ;/
$81:A947 BF 0B C8 82 LDA $82C80B,x          ;\
$81:A94B 18          CLC                    ;|
$81:A94C 69 40 00    ADC #$0040             ;} A = [[$82:C80B + [X]] + 40h] (debug save point 0)
$81:A94F AA          TAX                    ;|
$81:A950 BD 00 00    LDA $0000,x            ;/
$81:A953 AB          PLB
$81:A954 C9 FF FF    CMP #$FFFF             ; Clear zero if [A] != FFFFh, else set zero

$81:A957 60          RTS
}


;;; $A958: Debug. Switch active file select map area ;;;
{
$81:A958 AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:A95B 0A          ASL A                  ;|
$81:A95C AA          TAX                    ;} X = [$AAA0 + [file select map area index] * 2]
$81:A95D BD A0 AA    LDA $AAA0,x            ;|
$81:A960 AA          TAX                    ;/
$81:A961 20 DC A3    JSR $A3DC  [$81:A3DC]  ; Load inactive area map foreground colours
$81:A964 A5 1C       LDA $1C    [$7E:001C]  ;\
$81:A966 8D 50 09    STA $0950  [$7E:0950]  ;} File select map area index = [$1C]
$81:A969 0A          ASL A                  ;\
$81:A96A AA          TAX                    ;} X = [$AAA0 + [file select map area index] * 2]
$81:A96B BD A0 AA    LDA $AAA0,x            ;|
$81:A96E AA          TAX                    ;/
$81:A96F 20 D3 A3    JSR $A3D3  [$81:A3D3]  ; Load active area map foreground colours
$81:A972 AD 50 09    LDA $0950  [$7E:0950]  ;\
$81:A975 0A          ASL A                  ;|
$81:A976 AA          TAX                    ;} Y = [$AAA0 + [file select map area index] * 2]
$81:A977 BD A0 AA    LDA $AAA0,x            ;|
$81:A97A A8          TAY                    ;/
$81:A97B 4C 8A A5    JMP $A58A  [$81:A58A]  ; Go to load area select background tilemap
}


;;; $A97E: Draw area select map labels ;;;
{
$81:A97E 64 03       STZ $03    [$7E:0003]  ; $03 = 0 (palette 0)
$81:A980 A2 80 00    LDX #$0080             ; X = 80h
$81:A983 A0 10 00    LDY #$0010             ; Y = 10h
$81:A986 AF 49 C7 82 LDA $82C749[$82:C749]  ; A = 38h (area select - planet Zebes)
$81:A98A 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM
$81:A98E 64 1C       STZ $1C    [$7E:001C]  ; $1C = 0 (area index)

; LOOP_AREAS
$81:A990 A2 00 02    LDX #$0200             ; X = 200h (palette 1)
$81:A993 A5 1C       LDA $1C    [$7E:001C]  ;\
$81:A995 CD 50 09    CMP $0950  [$7E:0950]  ;} If [$1C] = [file select map area index]:
$81:A998 D0 03       BNE $03    [$A99D]     ;/
$81:A99A A2 00 00    LDX #$0000             ; X = 0 (palette 0)

$81:A99D 86 03       STX $03    [$7E:0003]  ; $03 = [X]
$81:A99F A5 1C       LDA $1C    [$7E:001C]  ;\
$81:A9A1 0A          ASL A                  ;|
$81:A9A2 AA          TAX                    ;|
$81:A9A3 BD A0 AA    LDA $AAA0,x[$81:AAA0]  ;} X = [$AAA0 + [$1C] * 2] * 2
$81:A9A6 0A          ASL A                  ;|
$81:A9A7 AA          TAX                    ;/
$81:A9A8 8B          PHB
$81:A9A9 A9 00 82    LDA #$8200             ;\
$81:A9AC 48          PHA                    ;|
$81:A9AD AB          PLB                    ;} DB = $82
$81:A9AE AB          PLB                    ;/
$81:A9AF BF F8 D8 7E LDA $7ED8F8,x[$7E:D8F8];\
$81:A9B3 85 24       STA $24    [$7E:0024]  ;} $24 = [$7E:D8F8 + [X]] (used save station / debug elevator)
$81:A9B5 BF 0B C8 82 LDA $82C80B,x[$82:C80B];\
$81:A9B9 AA          TAX                    ;} X = [$82:C80B + [X]] (save point icon data pointer)
$81:A9BA A9 10 00    LDA #$0010             ;\
$81:A9BD 85 1E       STA $1E    [$7E:001E]  ;} $1E = 10h (loop counter)

; LOOP_SAVE_POINTS
$81:A9BF BD 00 00    LDA $0000,x[$82:C853]  ;\
$81:A9C2 C9 FF FF    CMP #$FFFF             ;} If [[X]] = FFFFh: go to BRANCH_NEXT
$81:A9C5 F0 52       BEQ $52    [$AA19]     ;/
$81:A9C7 46 24       LSR $24    [$7E:0024]  ; $24 >>= 1
$81:A9C9 90 05       BCC $05    [$A9D0]     ; If carry set:
$81:A9CB C9 FE FF    CMP #$FFFE             ;\
$81:A9CE D0 17       BNE $17    [$A9E7]     ;} If [[X]] != FFFEh: go to BRANCH_FOUND_USED_SAVE_POINT

$81:A9D0 8A          TXA                    ;\
$81:A9D1 18          CLC                    ;|
$81:A9D2 69 04 00    ADC #$0004             ;} X += 4
$81:A9D5 AA          TAX                    ;/
$81:A9D6 C6 1E       DEC $1E    [$7E:001E]  ; Decrement $1E
$81:A9D8 D0 E5       BNE $E5    [$A9BF]     ; If [$1E] != 0: go to LOOP_SAVE_POINTS
$81:A9DA AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$81:A9DD F0 3A       BEQ $3A    [$AA19]     ;} If debug mode not enabled: go to BRANCH_NEXT
$81:A9DF BD 00 00    LDA $0000,x            ;\
$81:A9E2 C9 FF FF    CMP #$FFFF             ;} If [[X]] = FFFFh: go to BRANCH_NEXT
$81:A9E5 F0 32       BEQ $32    [$AA19]     ;/

; BRANCH_FOUND_USED_SAVE_POINT
$81:A9E7 AB          PLB
$81:A9E8 A5 1C       LDA $1C    [$7E:001C]  ;\
$81:A9EA 0A          ASL A                  ;|
$81:A9EB AA          TAX                    ;|
$81:A9EC BD A0 AA    LDA $AAA0,x[$81:AAA0]  ;} X = [$AAA0 + [$1C] * 2] * 4
$81:A9EF 0A          ASL A                  ;|
$81:A9F0 0A          ASL A                  ;|
$81:A9F1 AA          TAX                    ;/
$81:A9F2 BD 1E AA    LDA $AA1E,x[$81:AA1E]  ;\
$81:A9F5 A8          TAY                    ;} Y = [$AA1C + [X] + 2]
$81:A9F6 BD 1C AA    LDA $AA1C,x[$81:AA1C]  ; X = [$AA1C + [X]]
$81:A9F9 48          PHA                    ;\
$81:A9FA A5 1C       LDA $1C    [$7E:001C]  ;|
$81:A9FC 0A          ASL A                  ;|
$81:A9FD AA          TAX                    ;|
$81:A9FE BD A0 AA    LDA $AAA0,x[$81:AAA0]  ;} A = 39h + [$AAA0 + [$1C] * 2] (area select label)
$81:AA01 18          CLC                    ;|
$81:AA02 6F 49 C7 82 ADC $82C749[$82:C749]  ;|
$81:AA06 1A          INC A                  ;|
$81:AA07 FA          PLX                    ;/
$81:AA08 22 1F 89 81 JSL $81891F[$81:891F]  ; Add spritemap from $82:C569 table to OAM

; BRANCH_NEXT
$81:AA0C E6 1C       INC $1C    [$7E:001C]  ; Increment $1C
$81:AA0E A5 1C       LDA $1C    [$7E:001C]  ;\
$81:AA10 C9 06 00    CMP #$0006             ;} If [$1C] < 6:
$81:AA13 10 03       BPL $03    [$AA18]     ;/
$81:AA15 4C 90 A9    JMP $A990  [$81:A990]  ; Go to LOOP_AREAS

$81:AA18 60          RTS

$81:AA19 AB          PLB
$81:AA1A 80 F0       BRA $F0    [$AA0C]
}


;;; $AA1C: Area select map labels positions ;;;
{
;                        ________ X position
;                       |     ___ Y position
;                       |    |
$81:AA1C             dw 005B,0032, ; Crateria
                        002A,007F, ; Brinstar
                        005E,00B5, ; Norfair
                        00CE,0050, ; Wrecked Ship
                        00CE,009F, ; Maridia
                        0087,008B  ; Tourian
}


;;; $AA34: Room select map expanding square velocities ;;;
{
;                        _________________________________________ Left position subvelocity
;                       |     ____________________________________ Left position velocity
;                       |    |      ______________________________ Right subvelocity
;                       |    |     |     _________________________ Right velocity
;                       |    |     |    |      ___________________ Top subvelocity
;                       |    |     |    |     |     ______________ Top velocity
;                       |    |     |    |     |    |      ________ Bottom subvelocity
;                       |    |     |    |     |    |     |     ___ Bottom velocity
;                       |    |     |    |     |    |     |    |
$81:AA34             dw 3C00,FFFE, 3400,0003, 0800,FFFF, 0000,0004, ; Crateria
                        3800,FFFF, 0000,0004, A400,FFFD, 6800,0002, ; Brinstar
                        F000,FFFD, 9400,0003, 0000,FFFC, A800,0001, ; Norfair
                        0000,FFFC, F800,0000, 7400,FFFE, 6800,0003, ; Wrecked Ship
                        0000,FFFC, F800,0000, EC00,FFFC, E000,0001, ; Maridia
                        2000,FFFC, 7800,0003, 0000,FFFC, 5C00,0003  ; Tourian
}


;;; $AA94: Room select map expanding square timers ;;;
{
$81:AA94             dw 0033, ; Crateria
                        0035, ; Brinstar
                        002D, ; Norfair
                        0033, ; Wrecked Ship
                        0033, ; Maridia
                        0022  ; Tourian
}


;;; $AAA0: File select map area index table ;;;
{
; Maps file select map area index ($0950) to area index ($079F)
$81:AAA0             dw 0000, ; Crateria
                        0003, ; Wrecked Ship
                        0005, ; Tourian
                        0001, ; Brinstar
                        0004, ; Maridia
                        0002  ; Norfair
}


;;; $AAAC: File select map - index 7: area select map to room select map - prepare expanding square transition ;;;
{
$81:AAAC C2 30       REP #$30
$81:AAAE 20 7E A9    JSR $A97E  [$81:A97E]  ; Draw area select map labels
$81:AAB1 E2 20       SEP #$20
$81:AAB3 20 1C A6    JSR $A61C  [$81:A61C]  ; Set up initial expanding square transition HDMA
$81:AAB6 A9 13       LDA #$13               ;\
$81:AAB8 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$81:AABA A9 13       LDA #$13               ;\
$81:AABC 85 6C       STA $6C    [$7E:006C]  ;} Disable BG1/BG2/sprites in window area main screen
$81:AABE A9 32       LDA #$32               ;\
$81:AAC0 85 60       STA $60    [$7E:0060]  ;} Enable BG1 window 1 inclusive mask and BG2 window 1 exclusive mask
$81:AAC2 8D 23 21    STA $2123  [$7E:2123]  ;/
$81:AAC5 A9 02       LDA #$02               ;\
$81:AAC7 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 1 inclusive mask
$81:AAC9 8D 24 21    STA $2124  [$7E:2124]  ;/
$81:AACC A9 05       LDA #$05               ;\
$81:AACE 85 72       STA $72    [$7E:0072]  ;} Enable colour math on BG1/BG3
$81:AAD0 8D 31 21    STA $2131  [$7E:2131]  ;/
$81:AAD3 A9 22       LDA #$22               ;\
$81:AAD5 85 62       STA $62    [$7E:0062]  ;} Enable sprite window 1 inclusive mask and colour math window 1 inclusive mask
$81:AAD7 8D 25 21    STA $2125  [$7E:2125]  ;/
$81:AADA A9 30       LDA #$30               ;\
$81:AADC 85 5D       STA $5D    [$7E:005D]  ;} BG1 tiles base address = $0000, BG2 tiles base address = $3000
$81:AADE A9 00       LDA #$00               ; A = 0 (terminator)
$81:AAE0 8F 09 9E 7E STA $7E9E09[$7E:9E09]  ; $7E:9E09 = [A]
$81:AAE4 8F 19 9E 7E STA $7E9E19[$7E:9E19]  ; $7E:9E19 = [A]
$81:AAE8 C2 30       REP #$30
$81:AAEA A9 54 41    LDA #$4154             ;\
$81:AAED 85 00       STA $00    [$7E:0000]  ;|
$81:AAEF A9 7E 00    LDA #$007E             ;} $00 = $7E:4154
$81:AAF2 85 02       STA $02    [$7E:0002]  ;/
$81:AAF4 22 28 96 82 JSL $829628[$82:9628]  ; Draw room select map area label
$81:AAF8 AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:AAFB A9 00 02    LDA #$0200             ;|
$81:AAFE 95 D0       STA $D0,x  [$7E:00D0]  ;|
$81:AB00 A9 00 40    LDA #$4000             ;|
$81:AB03 95 D2       STA $D2,x  [$7E:00D2]  ;|
$81:AB05 A9 7E 00    LDA #$007E             ;|
$81:AB08 95 D4       STA $D4,x  [$7E:00D4]  ;|
$81:AB0A A5 59       LDA $59    [$7E:0059]  ;} Queue transfer of $7E:4000..41FF to VRAM BG2 tilemap
$81:AB0C 29 FC 00    AND #$00FC             ;|
$81:AB0F EB          XBA                    ;|
$81:AB10 95 D5       STA $D5,x  [$7E:00D5]  ;|
$81:AB12 8A          TXA                    ;|
$81:AB13 18          CLC                    ;|
$81:AB14 69 07 00    ADC #$0007             ;|
$81:AB17 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:AB1A AD 9F 07    LDA $079F  [$7E:079F]  ;\
$81:AB1D 0A          ASL A                  ;|
$81:AB1E AA          TAX                    ;} Expanding square timer = [$AA94 + [area index] * 2]
$81:AB1F BD 94 AA    LDA $AA94,x[$81:AA94]  ;|
$81:AB22 8F 50 9E 7E STA $7E9E50[$7E:9E50]  ;/
$81:AB26 8A          TXA                    ;\
$81:AB27 0A          ASL A                  ;} X = [area index] * 4
$81:AB28 AA          TAX                    ;/
$81:AB29 BD 1C AA    LDA $AA1C,x[$81:AA1C]  ; A = [$AA1C + [X]] (area select map labels X position)
$81:AB2C 8F 32 9E 7E STA $7E9E32[$7E:9E32]  ; Expanding square left position = [A]
$81:AB30 8F 36 9E 7E STA $7E9E36[$7E:9E36]  ; Expanding square right position = [A]
$81:AB34 BD 1E AA    LDA $AA1E,x[$81:AA1E]  ; A = [$AA1C + [X] + 2] (area select map labels Y position)
$81:AB37 8F 3A 9E 7E STA $7E9E3A[$7E:9E3A]  ; Expanding square top position = [A]
$81:AB3B 8F 3E 9E 7E STA $7E9E3E[$7E:9E3E]  ; Expanding square bottom position = [A]
$81:AB3F A9 00 00    LDA #$0000             ;\
$81:AB42 8F 30 9E 7E STA $7E9E30[$7E:9E30]  ;} Expanding square left subposition = 0
$81:AB46 8F 34 9E 7E STA $7E9E34[$7E:9E34]  ; Expanding square right subposition = 0
$81:AB4A 8F 38 9E 7E STA $7E9E38[$7E:9E38]  ; Expanding square top subposition = 0
$81:AB4E 8F 3C 9E 7E STA $7E9E3C[$7E:9E3C]  ; Expanding square bottom subposition = 0
$81:AB52 8A          TXA                    ;\
$81:AB53 0A          ASL A                  ;|
$81:AB54 0A          ASL A                  ;} X = [area index] * 10h
$81:AB55 AA          TAX                    ;/
$81:AB56 BD 34 AA    LDA $AA34,x[$81:AA34]  ;\
$81:AB59 8F 40 9E 7E STA $7E9E40[$7E:9E40]  ;|
$81:AB5D BD 36 AA    LDA $AA36,x[$81:AA36]  ;} Expanding square left position velocity = [$AA34 + [X] + 2].[$AA34 + [X]]
$81:AB60 8F 42 9E 7E STA $7E9E42[$7E:9E42]  ;/
$81:AB64 BD 38 AA    LDA $AA38,x[$81:AA38]  ;\
$81:AB67 8F 44 9E 7E STA $7E9E44[$7E:9E44]  ;|
$81:AB6B BD 3A AA    LDA $AA3A,x[$81:AA3A]  ;} Expanding square right position velocity = [$AA34 + [X] + 6].[$AA34 + [X] + 4]
$81:AB6E 8F 46 9E 7E STA $7E9E46[$7E:9E46]  ;/
$81:AB72 BD 3C AA    LDA $AA3C,x[$81:AA3C]  ;\
$81:AB75 8F 48 9E 7E STA $7E9E48[$7E:9E48]  ;|
$81:AB79 BD 3E AA    LDA $AA3E,x[$81:AA3E]  ;} Expanding square top position velocity = [$AA34 + [X] + Ah].[$AA34 + [X] + 8]
$81:AB7C 8F 4A 9E 7E STA $7E9E4A[$7E:9E4A]  ;/
$81:AB80 BD 40 AA    LDA $AA40,x[$81:AA40]  ;\
$81:AB83 8F 4C 9E 7E STA $7E9E4C[$7E:9E4C]  ;|
$81:AB87 BD 42 AA    LDA $AA42,x[$81:AA42]  ;} Expanding square bottom position velocity = [$AA34 + [X] + Eh].[$AA34 + [X] + Ch]
$81:AB8A 8F 4E 9E 7E STA $7E9E4E[$7E:9E4E]  ;/
$81:AB8E E2 20       SEP #$20
$81:AB90 20 A7 AB    JSR $ABA7  [$81:ABA7]  ; Set up file select map expanding square transition HDMA
$81:AB93 A9 0C       LDA #$0C               ;\
$81:AB95 85 85       STA $85    [$7E:0085]  ;} Enable HDMA channels 2/3
$81:AB97 8D 0C 42    STA $420C  [$7E:420C]  ;/
$81:AB9A C2 20       REP #$20
$81:AB9C EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 8 (expanding square transition)
$81:AB9F A9 3B 00    LDA #$003B             ;\
$81:ABA2 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Bh, sound library 1, max queued sounds allowed = 6 (hexagon map -> square map transition)
$81:ABA6 60          RTS
}


;;; $ABA7: Set up file select map expanding square transition HDMA ;;;
{
$81:ABA7 E2 20       SEP #$20
$81:ABA9 A2 00 00    LDX #$0000             ; X = 0
$81:ABAC AF 3A 9E 7E LDA $7E9E3A[$7E:9E3A]  ; A = [expanding square top position]
$81:ABB0 A0 22 9E    LDY #$9E22             ; Y = $9E22
$81:ABB3 20 F7 AB    JSR $ABF7  [$81:ABF7]  ; Add expanding square transition left position indirect HDMA table entry
$81:ABB6 A0 20 9E    LDY #$9E20             ; Y = $9E20
$81:ABB9 20 2D AC    JSR $AC2D  [$81:AC2D]  ; Add expanding square transition right position indirect HDMA table entry
$81:ABBC AF 3E 9E 7E LDA $7E9E3E[$7E:9E3E]  ;\
$81:ABC0 38          SEC                    ;} A = [expanding square bottom position] - [expanding square top position]
$81:ABC1 EF 3A 9E 7E SBC $7E9E3A[$7E:9E3A]  ;/
$81:ABC5 D0 02       BNE $02    [$ABC9]     ; If [A] = 0:
$81:ABC7 A9 01       LDA #$01               ; A = 1

$81:ABC9 A0 32 9E    LDY #$9E32             ; Y = expanding square left position
$81:ABCC 20 F7 AB    JSR $ABF7  [$81:ABF7]  ; Add expanding square transition left position indirect HDMA table entry
$81:ABCF A0 36 9E    LDY #$9E36             ; Y = expanding square right position
$81:ABD2 20 2D AC    JSR $AC2D  [$81:AC2D]  ; Add expanding square transition right position indirect HDMA table entry
$81:ABD5 A9 E0       LDA #$E0               ;\
$81:ABD7 38          SEC                    ;} A = E0h - [expanding square bottom position]
$81:ABD8 EF 3E 9E 7E SBC $7E9E3E[$7E:9E3E]  ;/
$81:ABDC D0 02       BNE $02    [$ABE0]     ; If [A] = 0:
$81:ABDE A9 01       LDA #$01               ; A = 1

$81:ABE0 A0 22 9E    LDY #$9E22             ; Y = $9E22
$81:ABE3 20 F7 AB    JSR $ABF7  [$81:ABF7]  ; Add expanding square transition left position indirect HDMA table entry
$81:ABE6 A0 20 9E    LDY #$9E20             ; Y = $9E20
$81:ABE9 20 2D AC    JSR $AC2D  [$81:AC2D]  ; Add expanding square transition right position indirect HDMA table entry
$81:ABEC A9 00       LDA #$00               ;\
$81:ABEE 9F 00 9E 7E STA $7E9E00,x[$7E:9E0C];} $7E:9E00 + [X] = 0 (terminator)
$81:ABF2 9F 10 9E 7E STA $7E9E10,x[$7E:9E1C]; $7E:9E10 + [X] = 0 (terminator)
$81:ABF6 60          RTS
}


;;; $ABF7: Add expanding square transition left position indirect HDMA table entry ;;;
{
;; Parameters:
;;     A: Number of lines
;;     X: Indirect HDMA table offset
;;     Y: Address of window 1 left position
$81:ABF7 48          PHA
$81:ABF8 5A          PHY
$81:ABF9 08          PHP
$81:ABFA E2 20       SEP #$20
$81:ABFC 89 80       BIT #$80               ;\
$81:ABFE D0 11       BNE $11    [$AC11]     ;} If [A] < 80h:
$81:AC00 9F 00 9E 7E STA $7E9E00,x[$7E:9E00];\
$81:AC04 C2 20       REP #$20               ;|
$81:AC06 98          TYA                    ;} $7E:9E00..02 + [X] = [A],[Y]
$81:AC07 9F 01 9E 7E STA $7E9E01,x[$7E:9E01];/
$81:AC0B 28          PLP
$81:AC0C 7A          PLY
$81:AC0D 68          PLA
$81:AC0E 60          RTS                    ; Return
$81:AC0F E2 20       SEP #$20               ; >_<;

$81:AC11 38          SEC                    ;\
$81:AC12 E9 7F       SBC #$7F               ;} A -= 7Fh
$81:AC14 9F 00 9E 7E STA $7E9E00,x[$7E:9E06];\
$81:AC18 A9 7F       LDA #$7F               ;|
$81:AC1A 9F 03 9E 7E STA $7E9E03,x[$7E:9E09];|
$81:AC1E C2 20       REP #$20               ;} $7E:9E00..05 + [X] = [A],[Y], 7Fh,[Y]
$81:AC20 98          TYA                    ;|
$81:AC21 9F 01 9E 7E STA $7E9E01,x[$7E:9E07];|
$81:AC25 9F 04 9E 7E STA $7E9E04,x[$7E:9E0A];/
$81:AC29 28          PLP
$81:AC2A 7A          PLY
$81:AC2B 68          PLA
$81:AC2C 60          RTS
}


;;; $AC2D: Add expanding square transition right position indirect HDMA table entry ;;;
{
;; Parameters:
;;     A: Number of lines
;;     X: Indirect HDMA table offset
;;     Y: Address of window 1 right position
;; Returns:
;;     X: Next indirect HDMA table offset
$81:AC2D 08          PHP
$81:AC2E E2 20       SEP #$20
$81:AC30 89 80       BIT #$80               ;\
$81:AC32 D0 12       BNE $12    [$AC46]     ;} If [A] < 80h:
$81:AC34 9F 10 9E 7E STA $7E9E10,x[$7E:9E10];\
$81:AC38 C2 20       REP #$20               ;|
$81:AC3A 98          TYA                    ;} $7E:9E10..12 + [X] = [A],[Y]
$81:AC3B 9F 11 9E 7E STA $7E9E11,x[$7E:9E11];/
$81:AC3F E8          INX                    ;\
$81:AC40 E8          INX                    ;} X += 3
$81:AC41 E8          INX                    ;/
$81:AC42 28          PLP
$81:AC43 60          RTS                    ; Return
$81:AC44 E2 20       SEP #$20               ; >_<;

$81:AC46 38          SEC                    ;\
$81:AC47 E9 7F       SBC #$7F               ;} A -= 7Fh
$81:AC49 9F 10 9E 7E STA $7E9E10,x[$7E:9E16];\
$81:AC4D A9 7F       LDA #$7F               ;|
$81:AC4F 9F 13 9E 7E STA $7E9E13,x[$7E:9E19];|
$81:AC53 C2 20       REP #$20               ;} $7E:9E10..15 + [X] = [A],[Y], 7Fh,[Y]
$81:AC55 98          TYA                    ;|
$81:AC56 9F 11 9E 7E STA $7E9E11,x[$7E:9E17];|
$81:AC5A 9F 14 9E 7E STA $7E9E14,x[$7E:9E1A];/
$81:AC5E 8A          TXA                    ;\
$81:AC5F 18          CLC                    ;|
$81:AC60 69 06 00    ADC #$0006             ;} X += 6
$81:AC63 AA          TAX                    ;/
$81:AC64 28          PLP
$81:AC65 60          RTS
}


;;; $AC66: File select map - index 8: area select map to room select map - expanding square transition ;;;
{
$81:AC66 C2 30       REP #$30
$81:AC68 20 84 AC    JSR $AC84  [$81:AC84]  ; Handle room select map expanding square transition
$81:AC6B 10 11       BPL $11    [$AC7E]     ; If finished:
$81:AC6D EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 9 (initialise)
$81:AC70 E2 20       SEP #$20
$81:AC72 A9 02       LDA #$02               ;\
$81:AC74 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG2
$81:AC76 A9 00       LDA #$00               ;\
$81:AC78 85 6C       STA $6C    [$7E:006C]  ;} Enable all layers in window area main screen
$81:AC7A 85 6D       STA $6D    [$7E:006D]  ; Enable all layers in window area subscreen
$81:AC7C 85 6B       STA $6B    [$7E:006B]  ; Disable all subscreen layers

$81:AC7E C2 30       REP #$30
$81:AC80 20 7E A9    JSR $A97E  [$81:A97E]  ; Draw area select map labels
$81:AC83 60          RTS
}


;;; $AC84: Handle room select map expanding square transition ;;;
{
;; Returns:
;;     Negative: Set if finished, clear otherwise
$81:AC84 AF 30 9E 7E LDA $7E9E30[$7E:9E30]  ;\
$81:AC88 18          CLC                    ;|
$81:AC89 6F 40 9E 7E ADC $7E9E40[$7E:9E40]  ;|
$81:AC8D 8F 30 9E 7E STA $7E9E30[$7E:9E30]  ;|
$81:AC91 AF 32 9E 7E LDA $7E9E32[$7E:9E32]  ;|
$81:AC95 6F 42 9E 7E ADC $7E9E42[$7E:9E42]  ;} Expanding square left position = max(1, [expanding square left position] + [expanding square left velocity])
$81:AC99 C9 01 00    CMP #$0001             ;|
$81:AC9C 10 03       BPL $03    [$ACA1]     ;|
$81:AC9E A9 01 00    LDA #$0001             ;|
                                            ;|
$81:ACA1 8F 32 9E 7E STA $7E9E32[$7E:9E32]  ;/
$81:ACA5 AF 34 9E 7E LDA $7E9E34[$7E:9E34]  ;\
$81:ACA9 18          CLC                    ;|
$81:ACAA 6F 44 9E 7E ADC $7E9E44[$7E:9E44]  ;|
$81:ACAE 8F 34 9E 7E STA $7E9E34[$7E:9E34]  ;|
$81:ACB2 AF 36 9E 7E LDA $7E9E36[$7E:9E36]  ;|
$81:ACB6 6F 46 9E 7E ADC $7E9E46[$7E:9E46]  ;} Expanding square right position = min(FFh, [expanding square right position] + [expanding square right velocity])
$81:ACBA C9 00 01    CMP #$0100             ;|
$81:ACBD 30 03       BMI $03    [$ACC2]     ;|
$81:ACBF A9 FF 00    LDA #$00FF             ;|
                                            ;|
$81:ACC2 8F 36 9E 7E STA $7E9E36[$7E:9E36]  ;/
$81:ACC6 AF 38 9E 7E LDA $7E9E38[$7E:9E38]  ;\
$81:ACCA 18          CLC                    ;|
$81:ACCB 6F 48 9E 7E ADC $7E9E48[$7E:9E48]  ;|
$81:ACCF 8F 38 9E 7E STA $7E9E38[$7E:9E38]  ;|
$81:ACD3 AF 3A 9E 7E LDA $7E9E3A[$7E:9E3A]  ;|
$81:ACD7 6F 4A 9E 7E ADC $7E9E4A[$7E:9E4A]  ;} Expanding square top position = max(1, [expanding square top position] + [expanding square top velocity])
$81:ACDB C9 01 00    CMP #$0001             ;|
$81:ACDE 10 03       BPL $03    [$ACE3]     ;|
$81:ACE0 A9 01 00    LDA #$0001             ;|
                                            ;|
$81:ACE3 8F 3A 9E 7E STA $7E9E3A[$7E:9E3A]  ;/
$81:ACE7 AF 3C 9E 7E LDA $7E9E3C[$7E:9E3C]  ;\
$81:ACEB 18          CLC                    ;|
$81:ACEC 6F 4C 9E 7E ADC $7E9E4C[$7E:9E4C]  ;|
$81:ACF0 8F 3C 9E 7E STA $7E9E3C[$7E:9E3C]  ;|
$81:ACF4 AF 3E 9E 7E LDA $7E9E3E[$7E:9E3E]  ;|
$81:ACF8 6F 4E 9E 7E ADC $7E9E4E[$7E:9E4E]  ;} Expanding square bottom position = min(E0h, [expanding square bottom position] + [expanding square bottom velocity])
$81:ACFC C9 E0 00    CMP #$00E0             ;|
$81:ACFF 30 03       BMI $03    [$AD04]     ;|
$81:AD01 A9 E0 00    LDA #$00E0             ;|
                                            ;|
$81:AD04 8F 3E 9E 7E STA $7E9E3E[$7E:9E3E]  ;/
$81:AD08 20 A7 AB    JSR $ABA7  [$81:ABA7]  ; Set up file select map expanding square transition HDMA
$81:AD0B C2 20       REP #$20
$81:AD0D AF 50 9E 7E LDA $7E9E50[$7E:9E50]  ;\
$81:AD11 3A          DEC A                  ;} Decrement expanding square timer
$81:AD12 8F 50 9E 7E STA $7E9E50[$7E:9E50]  ;/
$81:AD16 60          RTS
}


;;; $AD17: File select map - index 9: area select map to room select map - initialise ;;;
{
$81:AD17 C2 30       REP #$30
$81:AD19 22 8C 85 80 JSL $80858C[$80:858C]  ; Load mirror of current area's map explored
$81:AD1D 22 17 95 82 JSL $829517[$82:9517]  ; Draw room select map
$81:AD21 22 37 C4 80 JSL $80C437[$80:C437]  ; Load from load station
$81:AD25 22 93 82 88 JSL $888293[$88:8293]  ; Disable HDMA objects
$81:AD29 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$81:AD2D 8B          PHB
$81:AD2E E2 20       SEP #$20
$81:AD30 A9 8F       LDA #$8F               ;\
$81:AD32 48          PHA                    ;} DB = $8F
$81:AD33 AB          PLB                    ;/
$81:AD34 AE 9B 07    LDX $079B  [$7E:079B]  ;\
$81:AD37 BD 01 00    LDA $0001,x[$8F:91F9]  ;|
$81:AD3A 29 FF       AND #$FF               ;} Area index = [[room pointer] + 1] (this was already done in $80:C437 >_<;)
$81:AD3C 8D 9F 07    STA $079F  [$7E:079F]  ;/
$81:AD3F BD 02 00    LDA $0002,x[$8F:91FA]  ;\
$81:AD42 29 FF       AND #$FF               ;} Room X co-ordinate = [[room pointer] + 2]
$81:AD44 8D A1 07    STA $07A1  [$7E:07A1]  ;/
$81:AD47 BD 03 00    LDA $0003,x[$8F:91FB]  ;\
$81:AD4A 29 FF       AND #$FF               ;} Room Y co-ordinate = [[room pointer] + 3]
$81:AD4C 8D A3 07    STA $07A3  [$7E:07A3]  ;/
$81:AD4F AB          PLB
$81:AD50 C2 20       REP #$20
$81:AD52 22 28 90 82 JSL $829028[$82:9028]  ; Set up map scrolling for file select map
$81:AD56 AD B0 05    LDA $05B0  [$7E:05B0]  ;\
$81:AD59 18          CLC                    ;|
$81:AD5A 69 18 00    ADC #$0018             ;} Minimum Y scroll on mini-map += 18h (accounting for lack of HUD)
$81:AD5D 8D B0 05    STA $05B0  [$7E:05B0]  ;/
$81:AD60 A9 18 00    LDA #$0018             ;\
$81:AD63 85 B7       STA $B7    [$7E:00B7]  ;} BG2 Y scroll = 18h
$81:AD65 A5 69       LDA $69    [$7E:0069]  ;\
$81:AD67 29 FB FF    AND #$FFFB             ;} Disable BG3
$81:AD6A 85 69       STA $69    [$7E:0069]  ;/
$81:AD6C EE 27 07    INC $0727  [$7E:0727]  ; Menu index = Ah (room select map)
$81:AD6F 9C FD 05    STZ $05FD  [$7E:05FD]  ; Map scrolling direction = none
$81:AD72 9C FF 05    STZ $05FF  [$7E:05FF]  ; $05FF = 0
$81:AD75 9C 76 07    STZ $0776  [$7E:0776]  ; Samus position indicator animation frame = 0
$81:AD78 9C 78 07    STZ $0778  [$7E:0778]  ; Samus position indicator animation timer = 0
$81:AD7B 9C 7A 07    STZ $077A  [$7E:077A]  ; Samus position indicator animation loop counter = 0
$81:AD7E 60          RTS
}


;;; $AD7F: File select map - index Ah: room select map ;;;
{
$81:AD7F C2 30       REP #$30
$81:AD81 22 DD B6 82 JSL $82B6DD[$82:B6DD]  ; Draw file select map icons
$81:AD85 20 CA AE    JSR $AECA  [$81:AECA]  ; Handle file select map scroll arrows
$81:AD88 22 5D 92 82 JSL $82925D[$82:925D]  ; Map scrolling
$81:AD8C 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$81:AD90 AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$81:AD93 F0 07       BEQ $07    [$AD9C]     ;} If debug mode enabled:
$81:AD95 A5 91       LDA $91    [$7E:0091]  ;\
$81:AD97 89 00 20    BIT #$2000             ;} If controller 2 newly pressed select: go to BRANCH_DEBUG
$81:AD9A D0 44       BNE $44    [$ADE0]     ;/

$81:AD9C A5 8F       LDA $8F    [$7E:008F]  ;\
$81:AD9E 89 00 80    BIT #$8000             ;} If newly pressed B: go to BRANCH_EXIT
$81:ADA1 D0 10       BNE $10    [$ADB3]     ;/
$81:ADA3 89 80 10    BIT #$1080             ;\
$81:ADA6 F0 0A       BEQ $0A    [$ADB2]     ;} If newly pressed A or start:
$81:ADA8 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = Bh (room select map to loading game data)
$81:ADAB A9 38 00    LDA #$0038             ;\
$81:ADAE 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)

$81:ADB2 60          RTS                    ; Return

; BRANCH_EXIT
$81:ADB3 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:ADB6 18          CLC                    ;|
$81:ADB7 69 05 00    ADC #$0005             ;} Menu index = Fh (room select map to area select map)
$81:ADBA 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:ADBD A2 00 00    LDX #$0000             ; X = 0
$81:ADC0 AD 9F 07    LDA $079F  [$7E:079F]  ; A = [area index]

; LOOP_MAP_AREA_INDEX
$81:ADC3 DD A0 AA    CMP $AAA0,x            ;\
$81:ADC6 F0 0B       BEQ $0B    [$ADD3]     ;} If [$AAA0 + [X]] != [area index]:
$81:ADC8 E8          INX                    ;\
$81:ADC9 E8          INX                    ;} X += 2
$81:ADCA E0 0C 00    CPX #$000C             ;\
$81:ADCD 30 F4       BMI $F4    [$ADC3]     ;} If [X] < Ch: go to LOOP_MAP_AREA_INDEX
$81:ADCF 9C 50 09    STZ $0950  [$7E:0950]  ; File select map area index = 0
$81:ADD2 60          RTS                    ; Return

$81:ADD3 8A          TXA                    ;\
$81:ADD4 4A          LSR A                  ;} File select map area index = [X] / 2
$81:ADD5 8D 50 09    STA $0950  [$7E:0950]  ;/
$81:ADD8 A9 3C 00    LDA #$003C             ;\
$81:ADDB 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Ch, sound library 1, max queued sounds allowed = 6 (square map -> hexagon map transition)
$81:ADDF 60          RTS                    ; Return

; BRANCH_DEBUG
$81:ADE0 A9 38 00    LDA #$0038             ;\
$81:ADE3 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 38h, sound library 1, max queued sounds allowed = 6 (menu option selected)
$81:ADE7 8B          PHB
$81:ADE8 E2 20       SEP #$20
$81:ADEA A9 82       LDA #$82               ;\
$81:ADEC 85 02       STA $02    [$7E:0002]  ;} $02 = $82
$81:ADEE 48          PHA                    ;\
$81:ADEF AB          PLB                    ;} DB = $82
$81:ADF0 C2 20       REP #$20
$81:ADF2 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$81:ADF5 0A          ASL A                  ;|
$81:ADF6 AA          TAX                    ;} $18 = [$7E:D8F8 + [area index] * 2] (used save stations / debug elevators)
$81:ADF7 BF F8 D8 7E LDA $7ED8F8,x          ;|
$81:ADFB 85 18       STA $18    [$7E:0018]  ;/
$81:ADFD AD 8B 07    LDA $078B  [$7E:078B]  ;\
                                            ;|
$81:AE00 46 18       LSR $18    [$7E:0018]  ;} $18 >>= [load station index]
$81:AE02 3A          DEC A                  ;|
$81:AE03 10 FB       BPL $FB    [$AE00]     ;/
$81:AE05 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$81:AE08 0A          ASL A                  ;|
$81:AE09 18          CLC                    ;|
$81:AE0A 69 0B C8    ADC #$C80B             ;} A = [$C80B + [area index] * 2] (save points)
$81:AE0D AA          TAX                    ;|
$81:AE0E BD 00 00    LDA $0000,x            ;/

$81:AE11 F0 FE       BEQ $FE    [$AE11]     ; If [A] = 0: crash
$81:AE13 85 00       STA $00    [$7E:0000]  ; $00 = [A]
$81:AE15 AD 8B 07    LDA $078B  [$7E:078B]  ;\
$81:AE18 0A          ASL A                  ;|
$81:AE19 0A          ASL A                  ;} Y = [load station index] * 4
$81:AE1A A8          TAY                    ;/
$81:AE1B B7 00       LDA [$00],y            ;\
$81:AE1D 85 12       STA $12    [$7E:0012]  ;} $12 = [[$00] + [Y]]
$81:AE1F C8          INY                    ;\
$81:AE20 C8          INY                    ;|
$81:AE21 B7 00       LDA [$00],y            ;} $14 = [[$00] + [Y] + 2]
$81:AE23 85 14       STA $14    [$7E:0014]  ;/
$81:AE25 AD 8B 07    LDA $078B  [$7E:078B]  ;\
$81:AE28 C9 10 00    CMP #$0010             ;} If [load station index] >= 10h: go to BRANCH_DEBUG_SAVE_POINTS
$81:AE2B 10 35       BPL $35    [$AE62]     ;/
$81:AE2D 80 16       BRA $16    [$AE45]     ; Go to BRANCH_SAVES_ELEVATORS

; LOOP_SAVES_ELEVATORS
$81:AE2F 46 18       LSR $18    [$7E:0018]  ; $18 >>= 1
$81:AE31 90 12       BCC $12    [$AE45]     ; If carry set:
$81:AE33 AD 8B 07    LDA $078B  [$7E:078B]  ;\
$81:AE36 0A          ASL A                  ;|
$81:AE37 0A          ASL A                  ;} A = [[$00] + [load station index] * 4]
$81:AE38 A8          TAY                    ;|
$81:AE39 B7 00       LDA [$00],y            ;/
$81:AE3B C9 FE FF    CMP #$FFFE             ;\
$81:AE3E F0 05       BEQ $05    [$AE45]     ;} If [A] != FFFEh:
$81:AE40 C9 FF FF    CMP #$FFFF             ;\
$81:AE43 D0 32       BNE $32    [$AE77]     ;} If [A] != FFFFh: go to BRANCH_FOUND

; BRANCH_SAVES_ELEVATORS
$81:AE45 EE 8B 07    INC $078B  [$7E:078B]  ; Increment load station index
$81:AE48 AD 8B 07    LDA $078B  [$7E:078B]  ;\
$81:AE4B C9 10 00    CMP #$0010             ;} If [load station index] < 10h: go to LOOP_SAVES_ELEVATORS
$81:AE4E 30 DF       BMI $DF    [$AE2F]     ;/

; LOOP_DEBUG_SAVE_POINTS
$81:AE50 AD 8B 07    LDA $078B  [$7E:078B]  ;\
$81:AE53 0A          ASL A                  ;|
$81:AE54 0A          ASL A                  ;} A = [[$00] + [load station index] * 4]
$81:AE55 A8          TAY                    ;|
$81:AE56 B7 00       LDA [$00],y            ;/
$81:AE58 C9 FF FF    CMP #$FFFF             ;\
$81:AE5B F0 0A       BEQ $0A    [$AE67]     ;} If [A] = FFFEh: go to BRANCH_FINISHED_DEBUG_SAVE_POINTS
$81:AE5D C9 FE FF    CMP #$FFFE             ;\
$81:AE60 D0 15       BNE $15    [$AE77]     ;} If [A] != FFFFh: go to BRANCH_FOUND

; BRANCH_DEBUG_SAVE_POINTS
$81:AE62 EE 8B 07    INC $078B  [$7E:078B]  ; Increment load station index
$81:AE65 80 E9       BRA $E9    [$AE50]     ; Go to LOOP_DEBUG_SAVE_POINTS

; BRANCH_FINISHED_DEBUG_SAVE_POINTS
$81:AE67 9C 8B 07    STZ $078B  [$7E:078B]  ; Load station index = 0
$81:AE6A AD 9F 07    LDA $079F  [$7E:079F]  ;\
$81:AE6D 0A          ASL A                  ;|
$81:AE6E AA          TAX                    ;} $18 = [$7E:D8F8 + [area index] * 2] (used save stations / debug elevators)
$81:AE6F BF F8 D8 7E LDA $7ED8F8,x          ;|
$81:AE73 85 18       STA $18    [$7E:0018]  ;/
$81:AE75 80 B8       BRA $B8    [$AE2F]     ; Go to LOOP_SAVES_ELEVATORS

; BRANCH_FOUND
$81:AE77 AD 8B 07    LDA $078B  [$7E:078B]  ;\
$81:AE7A 0A          ASL A                  ;|
$81:AE7B 0A          ASL A                  ;} Y = [load station index] * 4
$81:AE7C A8          TAY                    ;/
$81:AE7D B7 00       LDA [$00],y            ; A = [[$00] + [Y]]
$81:AE7F C5 B1       CMP $B1    [$7E:00B1]  ;\
$81:AE81 30 08       BMI $08    [$AE8B]     ;|
$81:AE83 38          SEC                    ;|
$81:AE84 E9 00 01    SBC #$0100             ;} If 0 <= [A] - [BG1 X scroll] < 100h: go to BRANCH_NO_X_SCROLL
$81:AE87 C5 B1       CMP $B1    [$7E:00B1]  ;|
$81:AE89 30 19       BMI $19    [$AEA4]     ;/

$81:AE8B B7 00       LDA [$00],y            ;\
$81:AE8D 38          SEC                    ;|
$81:AE8E E5 12       SBC $12    [$7E:0012]  ;|
$81:AE90 18          CLC                    ;|
$81:AE91 65 B1       ADC $B1    [$7E:00B1]  ;|
$81:AE93 10 05       BPL $05    [$AE9A]     ;|
$81:AE95 A9 00 00    LDA #$0000             ;|
$81:AE98 80 08       BRA $08    [$AEA2]     ;} BG1 X scroll = clamp([BG1 X scroll] + [A] - [$12], 0, [map min X scroll])
                                            ;|
$81:AE9A CD AC 05    CMP $05AC  [$7E:05AC]  ;|
$81:AE9D 30 03       BMI $03    [$AEA2]     ;|
$81:AE9F AD AC 05    LDA $05AC  [$7E:05AC]  ;|
                                            ;|
$81:AEA2 85 B1       STA $B1    [$7E:00B1]  ;/

; BRANCH_NO_X_SCROLL
$81:AEA4 C8          INY                    ;\
$81:AEA5 C8          INY                    ;} A = [[$00] + [Y] + 2]
$81:AEA6 B7 00       LDA [$00],y            ;/
$81:AEA8 C5 B3       CMP $B3    [$7E:00B3]  ;\
$81:AEAA 30 08       BMI $08    [$AEB4]     ;|
$81:AEAC 38          SEC                    ;|
$81:AEAD E9 A1 00    SBC #$00A1             ;} If 0 <= [A] - [BG1 Y scroll] < A1h: return
$81:AEB0 C5 B3       CMP $B3    [$7E:00B3]  ;|
$81:AEB2 30 12       BMI $12    [$AEC6]     ;/

$81:AEB4 B7 00       LDA [$00],y            ;\
$81:AEB6 38          SEC                    ;|
$81:AEB7 E5 14       SBC $14    [$7E:0014]  ;|
$81:AEB9 18          CLC                    ;|
$81:AEBA 65 B3       ADC $B3    [$7E:00B3]  ;|
$81:AEBC CD B0 05    CMP $05B0  [$7E:05B0]  ;} BG1 Y scroll = min([BG1 Y scroll] + [A] - [$14], [map min Y scroll])
$81:AEBF 30 03       BMI $03    [$AEC4]     ;|
$81:AEC1 AD B0 05    LDA $05B0  [$7E:05B0]  ;|
                                            ;|
$81:AEC4 85 B3       STA $B3    [$7E:00B3]  ;/

$81:AEC6 AB          PLB
$81:AEC7 60          RTS
}


;;; $AEC8: Unused. REP #$30 ;;;
{
$81:AEC8 C2 30       REP #$30
}


;;; $AECA: Handle file select map scroll arrows ;;;
{
; Fork of $82:B934 (handle map scroll arrows) that changes the map screen boundaries
$81:AECA 08          PHP
$81:AECB 8B          PHB
$81:AECC 4B          PHK                    ;\
$81:AECD AB          PLB                    ;} DB = $81
$81:AECE C2 20       REP #$20
$81:AED0 AD AC 05    LDA $05AC  [$7E:05AC]  ;\
$81:AED3 38          SEC                    ;|
$81:AED4 E9 18 00    SBC #$0018             ;} If [map min X scroll] - 18h < [BG1 X scroll]:
$81:AED7 C5 B1       CMP $B1    [$7E:00B1]  ;|
$81:AED9 10 07       BPL $07    [$AEE2]     ;/
$81:AEDB A2 32 AF    LDX #$AF32             ; X = $AF32 (left map scroll arrow data)
$81:AEDE 22 0A B9 82 JSL $82B90A[$82:B90A]  ; Draw map scroll arrow and check to scroll in that direction

$81:AEE2 AD AE 05    LDA $05AE  [$7E:05AE]  ;\
$81:AEE5 18          CLC                    ;|
$81:AEE6 69 18 00    ADC #$0018             ;|
$81:AEE9 38          SEC                    ;} If [map max X scroll] + 18h >= [BG1 X scroll] + 100h:
$81:AEEA E9 00 01    SBC #$0100             ;|
$81:AEED C5 B1       CMP $B1    [$7E:00B1]  ;|
$81:AEEF 30 07       BMI $07    [$AEF8]     ;/
$81:AEF1 A2 3C AF    LDX #$AF3C             ; X = $AF3C (right map scroll arrow data)
$81:AEF4 22 0A B9 82 JSL $82B90A[$82:B90A]  ; Draw map scroll arrow and check to scroll in that direction

$81:AEF8 AD B0 05    LDA $05B0  [$7E:05B0]  ;\
$81:AEFB 38          SEC                    ;|
$81:AEFC E9 40 00    SBC #$0040             ;} If [map min Y scroll] - 40h < [BG1 Y scroll]:
$81:AEFF C5 B3       CMP $B3    [$7E:00B3]  ;|
$81:AF01 10 07       BPL $07    [$AF0A]     ;/
$81:AF03 A2 46 AF    LDX #$AF46             ; X = $AF46 (up map scroll arrow data)
$81:AF06 22 0A B9 82 JSL $82B90A[$82:B90A]  ; Draw map scroll arrow and check to scroll in that direction

$81:AF0A AD B2 05    LDA $05B2  [$7E:05B2]  ;\
$81:AF0D 38          SEC                    ;|
$81:AF0E E9 91 00    SBC #$0091             ;} If [map max Y scroll] - 91h < [BG1 Y scroll]: go to BRANCH_CANCEL_SCROLL_DOWN
$81:AF11 C5 B3       CMP $B3    [$7E:00B3]  ;|
$81:AF13 30 0A       BMI $0A    [$AF1F]     ;/
$81:AF15 A2 50 AF    LDX #$AF50             ; X = $AF50 (down map scroll arrow data)
$81:AF18 22 0A B9 82 JSL $82B90A[$82:B90A]  ; Draw map scroll arrow and check to scroll in that direction

$81:AF1C AB          PLB
$81:AF1D 28          PLP
$81:AF1E 60          RTS                    ; Return

; BRANCH_CANCEL_SCROLL_DOWN
$81:AF1F AD FD 05    LDA $05FD  [$7E:05FD]  ;\
$81:AF22 CD 58 AF    CMP $AF58  [$81:AF58]  ;} If [map scrolling direction] != down: return
$81:AF25 D0 F5       BNE $F5    [$AF1C]     ;/
$81:AF27 9C FB 05    STZ $05FB  [$7E:05FB]  ; $05FB = 0
$81:AF2A 9C FD 05    STZ $05FD  [$7E:05FD]  ; Map scrolling direction = none
$81:AF2D 9C FF 05    STZ $05FF  [$7E:05FF]  ; $05FF = 0
$81:AF30 80 EA       BRA $EA    [$AF1C]     ; Return

; Map scroll arrow data
;                        _______________________ X position
;                       |     __________________ Y position
;                       |    |     _____________ Pause screen animation ID
;                       |    |    |     ________ Necessary input
;                       |    |    |    |     ___ Map scrolling direction
;                       |    |    |    |    |
$81:AF32             dw 0010,0060,0009,0200,0001 ; Left
$81:AF3C             dw 00F0,0060,0008,0100,0002 ; Right
$81:AF46             dw 0080,0020,0006,0800,0003 ; Up
$81:AF50             dw 0080,00A0,0007,0400,0004 ; Down
}


;;; $AF5A: File select map - index Bh/Ch: room select map to loading game data - wait before fade out ;;;
{
$81:AF5A 22 DD B6 82 JSL $82B6DD[$82:B6DD]  ; Draw file select map icons
$81:AF5E 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$81:AF62 EE 27 07    INC $0727  [$7E:0727]  ; Increment menu index
$81:AF65 60          RTS
}


;;; $AF66: File select map - index Dh: room select map to loading game data - fade out ;;;
{
$81:AF66 22 DD B6 82 JSL $82B6DD[$82:B6DD]  ; Draw file select map icons
$81:AF6A 22 30 BB 82 JSL $82BB30[$82:BB30]  ; Display map elevator destinations
$81:AF6E 22 24 89 80 JSL $808924[$80:8924]  ; Handle fading out
$81:AF72 A5 51       LDA $51    [$7E:0051]  ;\
$81:AF74 29 0F 00    AND #$000F             ;} If (brightness) != 0: return
$81:AF77 D0 09       BNE $09    [$AF82]     ;/
$81:AF79 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = Eh (wait)
$81:AF7C A9 20 00    LDA #$0020             ;\
$81:AF7F 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Enemy 0 X position = 20h

$81:AF82 60          RTS
}


;;; $AF83: File select map - index Eh: room select map to loading game data - wait ;;;
{
$81:AF83 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$81:AF86 3A          DEC A                  ;} Decrement enemy 0 X position
$81:AF87 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$81:AF8A D0 0A       BNE $0A    [$AF96]     ; If [enemy 0 X position] != 0: return
$81:AF8C 22 6F 83 80 JSL $80836F[$80:836F]  ; Set force blank and wait for NMI
$81:AF90 EE 98 09    INC $0998  [$7E:0998]  ; Game state = 6 (loading game data)
$81:AF93 9C 27 07    STZ $0727  [$7E:0727]  ; Menu index = 0

$81:AF96 60          RTS
}


;;; $AF97: File select map - index Fh: room select map to area select map - clear BG1 tilemap ;;;
{
$81:AF97 E2 20       SEP #$20               ;\
$81:AF99 A9 12       LDA #$12               ;|
$81:AF9B 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG2/sprites
$81:AF9D C2 30       REP #$30               ;/
$81:AF9F A9 0F 00    LDA #$000F             ;\
$81:AFA2 A2 FE 07    LDX #$07FE             ;|
                                            ;|
$81:AFA5 9F 00 30 7E STA $7E3000,x          ;} $7E:3000..37FF = 000Fh
$81:AFA9 CA          DEX                    ;|
$81:AFAA CA          DEX                    ;|
$81:AFAB 10 F8       BPL $F8    [$AFA5]     ;/
$81:AFAD AE 30 03    LDX $0330  [$7E:0330]  ;\
$81:AFB0 A9 00 08    LDA #$0800             ;|
$81:AFB3 95 D0       STA $D0,x              ;|
$81:AFB5 A9 00 30    LDA #$3000             ;|
$81:AFB8 95 D2       STA $D2,x              ;|
$81:AFBA A9 7E 00    LDA #$007E             ;|
$81:AFBD 95 D4       STA $D4,x              ;|
$81:AFBF A5 58       LDA $58    [$7E:0058]  ;} Queue transfer from $7E:3000..37FF to VRAM BG1 tilemap
$81:AFC1 29 FC 00    AND #$00FC             ;|
$81:AFC4 EB          XBA                    ;|
$81:AFC5 95 D5       STA $D5,x              ;|
$81:AFC7 8A          TXA                    ;|
$81:AFC8 18          CLC                    ;|
$81:AFC9 69 07 00    ADC #$0007             ;|
$81:AFCC 8D 30 03    STA $0330  [$7E:0330]  ;/
$81:AFCF EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 10h (load palettes)
$81:AFD2 60          RTS
}


;;; $AFD3: File select map - index 10h: room select map to area select map - load palettes ;;;
{
$81:AFD3 C2 30       REP #$30
$81:AFD5 20 60 8E    JSR $8E60  [$81:8E60]  ; Load menu palettes
$81:AFD8 A2 00 00    LDX #$0000             ; X = 0 (area index)

; LOOP
$81:AFDB DA          PHX
$81:AFDC 20 DC A3    JSR $A3DC  [$81:A3DC]  ; Load inactive area map foreground colours
$81:AFDF FA          PLX
$81:AFE0 E8          INX                    ; Increment X
$81:AFE1 E0 06 00    CPX #$0006             ;\
$81:AFE4 30 F5       BMI $F5    [$AFDB]     ;} If [X] < 6 (Ceres): go to LOOP
$81:AFE6 AE 9F 07    LDX $079F  [$7E:079F]  ; X = [area index]
$81:AFE9 20 D3 A3    JSR $A3D3  [$81:A3D3]  ; Load active area map foreground colours
$81:AFEC AC 9F 07    LDY $079F  [$7E:079F]  ; Y = [area index]
$81:AFEF 20 8A A5    JSR $A58A  [$81:A58A]  ; Go to load area select background tilemap
$81:AFF2 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 11h (load foreground tilemap)
$81:AFF5 60          RTS
}


;;; $AFF6: File select map - index 14h: prepare contracting square transition to area select map ;;;
{
$81:AFF6 E2 20       SEP #$20
$81:AFF8 A9 00       LDA #$00               ;\
$81:AFFA 85 85       STA $85    [$7E:0085]  ;} Disable all HDMA channels
$81:AFFC C2 30       REP #$30
$81:AFFE A9 3C 00    LDA #$003C             ;\
$81:B001 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Ch, sound library 1, max queued sounds allowed = 6 (square map -> hexagon map transition)
$81:B005 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$81:B008 0A          ASL A                  ;|
$81:B009 AA          TAX                    ;|
$81:B00A BD 94 AA    LDA $AA94,x            ;} Expanding square timer = [$AA94 + [area index] * 2]
$81:B00D 38          SEC                    ;|
$81:B00E E9 0C 00    SBC #$000C             ;|
$81:B011 8F 50 9E 7E STA $7E9E50[$7E:9E50]  ;/
$81:B015 8A          TXA                    ;\
$81:B016 0A          ASL A                  ;|
$81:B017 0A          ASL A                  ;} X = [area index] * 10h
$81:B018 0A          ASL A                  ;|
$81:B019 AA          TAX                    ;/
$81:B01A BD 34 AA    LDA $AA34,x            ;\
$81:B01D 8F 40 9E 7E STA $7E9E40[$7E:9E40]  ;|
$81:B021 BD 36 AA    LDA $AA36,x            ;} Expanding square left position velocity = [$AA34 + [X] + 2].[$AA34 + [X]]
$81:B024 8F 42 9E 7E STA $7E9E42[$7E:9E42]  ;/
$81:B028 BD 38 AA    LDA $AA38,x            ;\
$81:B02B 8F 44 9E 7E STA $7E9E44[$7E:9E44]  ;|
$81:B02F BD 3A AA    LDA $AA3A,x            ;} Expanding square right position velocity = [$AA34 + [X] + 6].[$AA34 + [X] + 4]
$81:B032 8F 46 9E 7E STA $7E9E46[$7E:9E46]  ;/
$81:B036 BD 3C AA    LDA $AA3C,x            ;\
$81:B039 8F 48 9E 7E STA $7E9E48[$7E:9E48]  ;|
$81:B03D BD 3E AA    LDA $AA3E,x            ;} Expanding square top position velocity = [$AA34 + [X] + Ah].[$AA34 + [X] + 8]
$81:B040 8F 4A 9E 7E STA $7E9E4A[$7E:9E4A]  ;/
$81:B044 BD 40 AA    LDA $AA40,x            ;\
$81:B047 8F 4C 9E 7E STA $7E9E4C[$7E:9E4C]  ;|
$81:B04B BD 42 AA    LDA $AA42,x            ;} Expanding square bottom position velocity = [$AA34 + [X] + Eh].[$AA34 + [X] + Ch]
$81:B04E 8F 4E 9E 7E STA $7E9E4E[$7E:9E4E]  ;/
$81:B052 A9 08 00    LDA #$0008             ;\
$81:B055 8F 32 9E 7E STA $7E9E32[$7E:9E32]  ;} Expanding square left position = 8
$81:B059 A9 F8 00    LDA #$00F8             ;\
$81:B05C 8F 36 9E 7E STA $7E9E36[$7E:9E36]  ;} Expanding square right position = -8
$81:B060 A9 08 00    LDA #$0008             ;\
$81:B063 8F 3A 9E 7E STA $7E9E3A[$7E:9E3A]  ;} Expanding square top position = 8
$81:B067 A9 D8 00    LDA #$00D8             ;\
$81:B06A 8F 3E 9E 7E STA $7E9E3E[$7E:9E3E]  ;} Expanding square bottom position = -28h
$81:B06E A9 00 00    LDA #$0000             ;\
$81:B071 8F 30 9E 7E STA $7E9E30[$7E:9E30]  ;} Expanding square left subposition = 0
$81:B075 8F 34 9E 7E STA $7E9E34[$7E:9E34]  ; Expanding square right subposition = 0
$81:B079 8F 38 9E 7E STA $7E9E38[$7E:9E38]  ; Expanding square top subposition = 0
$81:B07D 8F 3C 9E 7E STA $7E9E3C[$7E:9E3C]  ; Expanding square bottom subposition = 0
$81:B081 20 A7 AB    JSR $ABA7  [$81:ABA7]  ; Set up file select map expanding square transition HDMA
$81:B084 EE 27 07    INC $0727  [$7E:0727]  ; Menu index = 15h (contracting square transition)
$81:B087 E2 20       SEP #$20
$81:B089 A9 0C       LDA #$0C               ;\
$81:B08B 85 85       STA $85    [$7E:0085]  ;} Enable HDMA channels 2/3
$81:B08D 8D 0C 42    STA $420C  [$7E:420C]  ;/
$81:B090 A9 32       LDA #$32               ;\
$81:B092 85 60       STA $60    [$7E:0060]  ;} Enable BG1 window 1 inclusive mask and BG2 window 1 exclusive mask
$81:B094 8D 23 21    STA $2123  [$7E:2123]  ;/
$81:B097 A9 02       LDA #$02               ;\
$81:B099 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 1 inclusive mask
$81:B09B 8D 24 21    STA $2124  [$7E:2124]  ;/
$81:B09E A9 30       LDA #$30               ;\
$81:B0A0 85 5D       STA $5D    [$7E:005D]  ;} BG1 tiles base address = $0000, BG2 tiles base address = $3000
$81:B0A2 A9 22       LDA #$22               ;\
$81:B0A4 85 62       STA $62    [$7E:0062]  ;} Enable sprite window 1 inclusive mask and colour math window 1 inclusive mask
$81:B0A6 A9 00       LDA #$00               ; A = 0 (terminator)
$81:B0A8 8F 09 9E 7E STA $7E9E09[$7E:9E09]  ; $7E:9E09 = [A]
$81:B0AC 8F 19 9E 7E STA $7E9E19[$7E:9E19]  ; $7E:9E19 = [A]
$81:B0B0 A9 00       LDA #$00               ;\
$81:B0B2 85 B3       STA $B3    [$7E:00B3]  ;} BG1 Y scroll = 0
$81:B0B4 85 B4       STA $B4    [$7E:00B4]  ;/
$81:B0B6 85 B1       STA $B1    [$7E:00B1]  ;\
$81:B0B8 85 B2       STA $B2    [$7E:00B2]  ;} BG1 X scroll = 0
$81:B0BA 60          RTS
}


;;; $B0BB: File select map - index 15h: room select map to area select map - contracting square transition ;;;
{
$81:B0BB C2 30       REP #$30
$81:B0BD AF 30 9E 7E LDA $7E9E30[$7E:9E30]  ;\
$81:B0C1 38          SEC                    ;|
$81:B0C2 EF 40 9E 7E SBC $7E9E40[$7E:9E40]  ;|
$81:B0C6 8F 30 9E 7E STA $7E9E30[$7E:9E30]  ;} Expanding square left position -= [expanding square left velocity]
$81:B0CA AF 32 9E 7E LDA $7E9E32[$7E:9E32]  ;|
$81:B0CE EF 42 9E 7E SBC $7E9E42[$7E:9E42]  ;|
$81:B0D2 8F 32 9E 7E STA $7E9E32[$7E:9E32]  ;/
$81:B0D6 AF 34 9E 7E LDA $7E9E34[$7E:9E34]  ;\
$81:B0DA 38          SEC                    ;|
$81:B0DB EF 44 9E 7E SBC $7E9E44[$7E:9E44]  ;|
$81:B0DF 8F 34 9E 7E STA $7E9E34[$7E:9E34]  ;} Expanding square right position -= [expanding square right velocity]
$81:B0E3 AF 36 9E 7E LDA $7E9E36[$7E:9E36]  ;|
$81:B0E7 EF 46 9E 7E SBC $7E9E46[$7E:9E46]  ;|
$81:B0EB 8F 36 9E 7E STA $7E9E36[$7E:9E36]  ;/
$81:B0EF AF 38 9E 7E LDA $7E9E38[$7E:9E38]  ;\
$81:B0F3 38          SEC                    ;|
$81:B0F4 EF 48 9E 7E SBC $7E9E48[$7E:9E48]  ;|
$81:B0F8 8F 38 9E 7E STA $7E9E38[$7E:9E38]  ;} Expanding square top position -= [expanding square top velocity]
$81:B0FC AF 3A 9E 7E LDA $7E9E3A[$7E:9E3A]  ;|
$81:B100 EF 4A 9E 7E SBC $7E9E4A[$7E:9E4A]  ;|
$81:B104 8F 3A 9E 7E STA $7E9E3A[$7E:9E3A]  ;/
$81:B108 AF 3C 9E 7E LDA $7E9E3C[$7E:9E3C]  ;\
$81:B10C 38          SEC                    ;|
$81:B10D EF 4C 9E 7E SBC $7E9E4C[$7E:9E4C]  ;|
$81:B111 8F 3C 9E 7E STA $7E9E3C[$7E:9E3C]  ;} Expanding square bottom position -= [expanding square bottom velocity]
$81:B115 AF 3E 9E 7E LDA $7E9E3E[$7E:9E3E]  ;|
$81:B119 EF 4E 9E 7E SBC $7E9E4E[$7E:9E4E]  ;|
$81:B11D 8F 3E 9E 7E STA $7E9E3E[$7E:9E3E]  ;/
$81:B121 20 A7 AB    JSR $ABA7  [$81:ABA7]  ; Set up file select map expanding square transition HDMA
$81:B124 C2 20       REP #$20
$81:B126 20 7E A9    JSR $A97E  [$81:A97E]  ; Draw area select map labels
$81:B129 AF 50 9E 7E LDA $7E9E50[$7E:9E50]  ;\
$81:B12D 3A          DEC A                  ;} Decrement expanding square timer
$81:B12E 8F 50 9E 7E STA $7E9E50[$7E:9E50]  ;/
$81:B132 10 16       BPL $16    [$B14A]     ; If [expanding square timer] >= 0: return
$81:B134 AD 27 07    LDA $0727  [$7E:0727]  ;\
$81:B137 38          SEC                    ;|
$81:B138 E9 0F 00    SBC #$000F             ;} Menu index = 6 (area select map)
$81:B13B 8D 27 07    STA $0727  [$7E:0727]  ;/
$81:B13E E2 20       SEP #$20
$81:B140 A9 11       LDA #$11               ;\
$81:B142 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/sprites
$81:B144 A9 00       LDA #$00               ;\
$81:B146 85 6C       STA $6C    [$7E:006C]  ;} Enable all layers in window area
$81:B148 85 6D       STA $6D    [$7E:006D]  ;/

$81:B14A 60          RTS
}


;;; $B14B: Tilemap - room select map controls ;;;
{
; First word is skipped
$81:B14B             dw 2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,
                        2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,
                        2801,2801,2801,28B6,28B7,283C,2830,283F,2801,2801,2801,2801,2801,2850,6850,2801,2801,2801,2801,2801,2801,2801,2851,2852,2801,2801,2801,2801,2801,2801,2801,2801,
                        2801,2801,2801,28C6,28C7,2842,2832,2841,283E,283B,283B,2801,2801,2860,6860,2842,2843,2830,2841,2843,2801,2801,2861,2862,2832,2830,283D,2832,2834,283B,2801,2801,
                        2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,
                        2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801,2801
}
}


;;; $B2CB: New save file ;;;
{
$81:B2CB C2 30       REP #$30
$81:B2CD A9 63 00    LDA #$0063             ;\
$81:B2D0 8D C4 09    STA $09C4  [$7E:09C4]  ;} Samus health = Samus max health = 99
$81:B2D3 8D C2 09    STA $09C2  [$7E:09C2]  ;/
$81:B2D6 A9 00 00    LDA #$0000             ;\
$81:B2D9 8D C8 09    STA $09C8  [$7E:09C8]  ;} Samus missiles = Samus max missiles = 0
$81:B2DC 8D C6 09    STA $09C6  [$7E:09C6]  ;/
$81:B2DF A9 00 00    LDA #$0000             ;\
$81:B2E2 8D CC 09    STA $09CC  [$7E:09CC]  ;} Samus super missiles = Samus max super missiles = 0
$81:B2E5 8D CA 09    STA $09CA  [$7E:09CA]  ;/
$81:B2E8 A9 00 00    LDA #$0000             ;\
$81:B2EB 8D D0 09    STA $09D0  [$7E:09D0]  ;} Samus power bombs = Samus max power bombs = 0
$81:B2EE 8D CE 09    STA $09CE  [$7E:09CE]  ;/
$81:B2F1 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing
$81:B2F4 9C A8 09    STZ $09A8  [$7E:09A8]  ;\
$81:B2F7 9C A6 09    STZ $09A6  [$7E:09A6]  ;} Equipped beams = collected beams = none
$81:B2FA 9C A4 09    STZ $09A4  [$7E:09A4]  ;\
$81:B2FD 9C A2 09    STZ $09A2  [$7E:09A2]  ;} Equipped items = collected items = none
$81:B300 9C C0 09    STZ $09C0  [$7E:09C0]  ; Reserve health mode = not obtained
$81:B303 9C D4 09    STZ $09D4  [$7E:09D4]  ;\
$81:B306 9C D6 09    STZ $09D6  [$7E:09D6]  ;} Samus reserve health = Samus max reserve health = 0
$81:B309 9C D8 09    STZ $09D8  [$7E:09D8]  ; Samus reserve missiles = 0
$81:B30C A9 00 08    LDA #$0800             ;\
$81:B30F 8D AA 09    STA $09AA  [$7E:09AA]  ;} Up button = up
$81:B312 A9 00 04    LDA #$0400             ;\
$81:B315 8D AC 09    STA $09AC  [$7E:09AC]  ;} Down button = down
$81:B318 A9 00 02    LDA #$0200             ;\
$81:B31B 8D AE 09    STA $09AE  [$7E:09AE]  ;} Left button = left
$81:B31E A9 00 01    LDA #$0100             ;\
$81:B321 8D B0 09    STA $09B0  [$7E:09B0]  ;} Right button = right
$81:B324 A9 80 00    LDA #$0080             ;\
$81:B327 8D B4 09    STA $09B4  [$7E:09B4]  ;} Jump button = A
$81:B32A A9 00 80    LDA #$8000             ;\
$81:B32D 8D B6 09    STA $09B6  [$7E:09B6]  ;} Run button = B
$81:B330 A9 40 00    LDA #$0040             ;\
$81:B333 8D B2 09    STA $09B2  [$7E:09B2]  ;} Shoot button = X
$81:B336 A9 00 40    LDA #$4000             ;\
$81:B339 8D B8 09    STA $09B8  [$7E:09B8]  ;} Item cancel button = Y
$81:B33C A9 00 20    LDA #$2000             ;\
$81:B33F 8D BA 09    STA $09BA  [$7E:09BA]  ;} Item select button = select
$81:B342 A9 10 00    LDA #$0010             ;\
$81:B345 8D BE 09    STA $09BE  [$7E:09BE]  ;} Aim up button = R
$81:B348 A9 20 00    LDA #$0020             ;\
$81:B34B 8D BC 09    STA $09BC  [$7E:09BC]  ;} Aim down button = L
$81:B34E 9C DA 09    STZ $09DA  [$7E:09DA]  ;\
$81:B351 9C DC 09    STZ $09DC  [$7E:09DC]  ;|
$81:B354 9C DE 09    STZ $09DE  [$7E:09DE]  ;} In-game timer = 0:0:0.0
$81:B357 9C E0 09    STZ $09E0  [$7E:09E0]  ;/
$81:B35A 9C E2 09    STZ $09E2  [$7E:09E2]  ; Disable Japanese text
$81:B35D 9C E4 09    STZ $09E4  [$7E:09E4]  ; Disable moonwalk
$81:B360 9C EA 09    STZ $09EA  [$7E:09EA]  ; Disable HUD auto-cancel
$81:B363 A9 01 00    LDA #$0001             ;\
$81:B366 8D E6 09    STA $09E6  [$7E:09E6]  ;} Debug disable Samus placement mode flag = 1
$81:B369 8D E8 09    STA $09E8  [$7E:09E8]  ; $09E8 = 1 (never read)
$81:B36C A2 00 00    LDX #$0000             ;\
$81:B36F A9 00 00    LDA #$0000             ;|
                                            ;|
$81:B372 9F 30 D8 7E STA $7ED830,x[$7E:D830];|
$81:B376 9F 70 D8 7E STA $7ED870,x[$7E:D870];|
$81:B37A 9F 70 D8 7E STA $7ED870,x[$7E:D870];|
$81:B37E 9F B0 D8 7E STA $7ED8B0,x[$7E:D8B0];|
$81:B382 9F F0 D8 7E STA $7ED8F0,x[$7E:D8F0];|
$81:B386 9F 08 D9 7E STA $7ED908,x[$7E:D908];|
$81:B38A 9F F8 D8 7E STA $7ED8F8,x[$7E:D8F8];|
$81:B38E 9F 00 D9 7E STA $7ED900,x[$7E:D900];|
$81:B392 E8          INX                    ;|
$81:B393 E8          INX                    ;} Clear all item / door / map station / save station / debug elevator bits
$81:B394 E0 08 00    CPX #$0008             ;|
$81:B397 30 D9       BMI $D9    [$B372]     ;|
$81:B399 A9 00 00    LDA #$0000             ;|
                                            ;|
$81:B39C 9F 30 D8 7E STA $7ED830,x[$7E:D838];|
$81:B3A0 9F 70 D8 7E STA $7ED870,x[$7E:D878];|
$81:B3A4 9F 70 D8 7E STA $7ED870,x[$7E:D878];|
$81:B3A8 9F B0 D8 7E STA $7ED8B0,x[$7E:D8B8];|
$81:B3AC E8          INX                    ;|
$81:B3AD E8          INX                    ;|
$81:B3AE E0 40 00    CPX #$0040             ;|
$81:B3B1 30 E9       BMI $E9    [$B39C]     ;/
$81:B3B3 A2 00 00    LDX #$0000             ;\
$81:B3B6 A9 00 00    LDA #$0000             ;|
                                            ;|
$81:B3B9 9F 52 CD 7E STA $7ECD52,x[$7E:CD52];|
$81:B3BD E8          INX                    ;} Clear map data (not including debug area)
$81:B3BE E8          INX                    ;|
$81:B3BF E0 00 07    CPX #$0700             ;|
$81:B3C2 30 F5       BMI $F5    [$B3B9]     ;/
$81:B3C4 60          RTS
}


;;; $B3C5: Clear rest of menu tilemap row ;;;
{
;; Parameters:
;;     X: Menu tilemap index
$81:B3C5 8A          TXA                    ;\
$81:B3C6 29 3F 00    AND #$003F             ;|
$81:B3C9 4A          LSR A                  ;|
$81:B3CA 38          SEC                    ;|
$81:B3CB E9 20 00    SBC #$0020             ;} $12 = 20h - [X] / 2 % 20h
$81:B3CE 49 FF FF    EOR #$FFFF             ;|
$81:B3D1 1A          INC A                  ;|
$81:B3D2 85 12       STA $12    [$7E:0012]  ;/
$81:B3D4 A9 0F 00    LDA #$000F             ;\
                                            ;|
$81:B3D7 9F 00 36 7E STA $7E3600,x[$7E:389C];|
$81:B3DB E8          INX                    ;} Fill [$12] words from $7E:3600 + [X] with 000Fh
$81:B3DC E8          INX                    ;|
$81:B3DD C6 12       DEC $12    [$7E:0012]  ;|
$81:B3DF D0 F6       BNE $F6    [$B3D7]     ;/
$81:B3E1 60          RTS
}


;;; $B3E2: Load menu tilemap [Y] to ([X] / 2 % 20h, [X] / 40h) ;;;
{
; def f(i):
;     formatValue = lambda v: f'{v:X}' + ('h' if v >= 0xA else '')
;     print(f'{formatValue(i // 2 % 0x20)}, {formatValue(i // 0x40)}')

$81:B3E2 DA          PHX

$81:B3E3 B9 00 00    LDA $0000,y[$81:B40A]
$81:B3E6 C9 FE FF    CMP #$FFFE
$81:B3E9 F0 12       BEQ $12    [$B3FD]
$81:B3EB C9 FF FF    CMP #$FFFF
$81:B3EE F0 18       BEQ $18    [$B408]
$81:B3F0 0D 96 0F    ORA $0F96  [$7E:0F96]
$81:B3F3 9F 00 36 7E STA $7E3600,x[$7E:3656]
$81:B3F7 E8          INX
$81:B3F8 E8          INX
$81:B3F9 C8          INY
$81:B3FA C8          INY
$81:B3FB 80 E6       BRA $E6    [$B3E3]

$81:B3FD C8          INY
$81:B3FE C8          INY
$81:B3FF 68          PLA
$81:B400 18          CLC
$81:B401 69 40 00    ADC #$0040
$81:B404 AA          TAX
$81:B405 48          PHA
$81:B406 80 DB       BRA $DB    [$B3E3]

$81:B408 FA          PLX
$81:B409 60          RTS
}


;;; $B40A: File select tilemaps ;;;
{
; SAMUS DATA
$81:B40A             dw 202B, 200A, 2026, 202D, 202B, 200F, 200D, 200A, 202C, 200A, FFFE,
                        203B, 201A, 2036, 2010, 203B, 200F, 201D, 201A, 2011, 201A, FFFF

; SAMUS A
$81:B436             dw 202B, 200A, 2026, 202D, 202B, 200F, 200A, FFFE,
                        203B, 201A, 2036, 2010, 203B, 200F, 201A, FFFF

; SAMUS B
$81:B456             dw 202B, 200A, 2026, 202D, 202B, 200F, 200B, FFFE,
                        203B, 201A, 2036, 2010, 203B, 200F, 201B, FFFF

; SAMUS C
$81:B476             dw 202B, 200A, 2026, 202D, 202B, 200F, 200C, FFFE,
                        203B, 201A, 2036, 2010, 203B, 200F, 201C, FFFF

; ENERGY
$81:B496             dw 209D, 209E, 209F, 20CC, FFFF

; TIME
$81:B4A0             dw 20AD, 20AE, 20AF, FFFF

; :
$81:B4A8             dw 208C, FFFF

; NO DATA
$81:B4AC             dw 000F, 2077, 2078, 200F, 206D, 206A, 207D, 206A, 200F, 200F, 200F, FFFF

; DATA COPY
$81:B4C4             dw 206D, 206A, 207D, 206A, 200F, 206C, 2078, 2079, 2082, FFFF

; DATA CLEAR
$81:B4D8             dw 206D, 206A, 207D, 206A, 200F, 206C, 2075, 206E, 206A, 207B, FFFF

; EXIT
$81:B4EE             dw 206E, 2081, 2072, 207D, FFFF

; DATA COPY MODE
$81:B4F8             dw 000D, 200A, 202C, 200A, 200F, 200C, 2000, 200D, 2041, 200F, 2026, 2000, 200D, 200E, FFFE,
                        201D, 201A, 2011, 201A, 200F, 201C, 2010, 2038, 2017, 200F, 2036, 2010, 201D, 201E, FFFF

; DATA CLEAR MODE
$81:B534             dw 000D, 000A, 002C, 000A, 000F, 000C, 0025, 000E, 000A, 000D, 000F, 0026, 0000, 000D, 000E, FFFE,
                        001D, 001A, 0011, 001A, 000F, 001C, 0035, 001E, 001A, 003A, 000F, 0036, 0010, 001D, 001E, FFFF

; COPY WHICH DATA?
$81:B574             dw 206C, 2078, 2079, 2082, 200F, 2080, 2071, 2072, 206C, 2071, 200F, 206D, 206A, 207D, 206A, 2085, FFFF

; COPY (SAMUS  ) TO WHERE?
$81:B596             dw 206C, 2078, 2079, 2082, 200F, 208A, 207C, 206A, 2076, 207E, 207C, 200F, 200F, 208B, 200F, 207D, 2078, 200F, 2080, 2071, 206E, 207B, 206E, 2085, FFFF

; COPY (SAMUS  ) TO (SAMUS  ).
$81:B5C8             dw 206C, 2078, 2079, 2082, 200F, 208A, 207C, 206A, 2076, 207E, 207C, 200F, 200F, 208B, 200F, 207D, 2078, 200F, 208A, 207C, 206A, 2076, 207E, 207C, 200F, 200F, 208B, 2088, FFFF

; IS THIS OK?
$81:B602             dw 2072, 207C, 200F, 207D, 2071, 2072, 207C, 200F, 2078, 2074, 2085, FFFF

; YES
$81:B61A             dw 2041, 200E, 202B, FFFE,
                        2017, 201E, 203B, FFFF

; N O
$81:B62A             dw 2027, 200F, 2000, FFFE,
                        2037, 200F, 2010, FFFF

; COPY COMPLETED.
$81:B63A             dw 206C, 2078, 2079, 2082, 200F, 206C, 2078, 2076, 2079, 2075, 206E, 207D, 206E, 206D, 2088, FFFF

;        CLEAR WHICH DATA?
$81:B65A             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 006C, 0075, 006E, 006A, 007B, 000F, 0080, 0071, 0072, 006C, 0071, 000F, 006D, 006A, 007D, 006A, 0085, 000F, 000F, 000F, 000F, 000F, 000F, 000F, FFFF

;         CLEAR (SAMUS A).
$81:B69A             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 006C, 0075, 006E, 006A, 007B, 000F, 008A, 007C, 006A, 0076, 007E, 007C, 000F, 006A, 008B, 0088, 000F, 000F, 000F, 000F, 000F, 000F, 000F, FFFF

;         DATA CLEARED...
$81:B6DA             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 006D, 006A, 007D, 006A, 000F, 006C, 0075, 006E, 006A, 007B, 006E, 006D, 0088, 0088, 0088, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, FFFF
}


;;; $B71A: Area select tilemaps ;;;
{
;;; $B71A: Area select foreground tilemap ;;;
{
$81:B71A             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 15AD, 15AE, 55AD, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 15AD, 15AE, 95CC, 15BC, 15D5, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 15AD, 15AE, 15DA, 15A8, 55A7, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 15BB, 15BC, 15D5, 15C8, 15DB, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 15BB, 15BC, 15D5, 15B6, 15B7, 000F, 1DA1, 1DA2, 5DA1, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 15DC, 15C8, 15CF, 15A8, 55A7, 000F, 15A7, 15A8, 55A7, 000F, 15A7, 15A8, 55CB, 15AE, 55CA, 15A8, 55AA, 1DA2, 9DA6, 1DB0, 1DD4, 1DAE, 5DAD, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 55D0, 55A8, 95AC, 15B6, 15AC, 15A8, 15D3, 15BC, 55D3, 15A8, 15D3, 15AE, 95CC, 15BC, 15D5, 15B6, 15B7, 1DB0, 1DA6, 1DA2, 1DBB, 1DBC, 1DD5, 1DA2, 5DA1, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 15B5, 15B6, 15AC, 15A8, 15D3, 15AE, 15CC, 15AE, 95CC, 15AE, 95CC, 15BC, 15D5, 15C8, 15CF, 15A8, 55AA, 1DA2, 9DA6, 1DB0, 1DDC, 1DC8, 1DDD, 1DB0, DDA4, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 15C2, 15C3, 15B5, 15B6, 15BB, 15BC, 15BB, 15BC, 15D5, 15BC, 15D5, 15C8, 15CF, 15A8, 55AC, 15B6, 15B7, 1DB0, 1DA6, 1DA2, 1DE6, 1DC8, 1DB4, 1DA2, 5DA4, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 15C2, 15C3, 15DC, 15C8, 15DC, 15C8, 15DD, 15C8, 15CF, 15A8, 55AC, 15B6, 15AC, 15A8, 55AA, 1DA2, 9DA6, 1DB0, 1DA6, 1DA2, 9DA6, 1DA2, DDA4, 000F, 000F, 000F,
                        000F, 000F, 19AD, 19AE, 59AD, 000F, 000F, 000F, 15C7, 15C8, 15DC, 15C8, 15CF, 15A8, 55AC, 15B6, 15B7, 15C3, 15B5, 15B6, 15B7, 1DB0, 1DA6, 1DA2, 9DA6, 1DA2, DDA4, 1DBE, 1DBF, 000F, 000F, 000F,
                        000F, 000F, 19BB, 19BC, 19CC, 19AE, 59AD, 000F, 000F, 000F, 15C7, 15C8, 15B5, 15B6, 15B7, 15C3, 15C4, 000F, 15C2, 15C3, 15CD, 1DA2, 9DA6, 1DA2, DDA4, 1DBE, 1DBF, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 19C7, 19C8, 19BB, 19BC, 19D5, 000F, 000F, 000F, 000F, 000F, 15C2, 15C3, 15C4, 000F, 000F, 000F, 000F, 000F, 15AF, 1DB0, DDA4, 1DBE, 1DBF, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 59D7, 19AE, 59D8, 000F, 19AD, 19AE, 59AD, 000F, 000F, 000F, 000F, 1DA7, 1DA8, 5DA7, 000F, 000F, 15BD, 1DBE, 1DBF, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 19BB, 19BC, 19CC, 19AE, 99CC, 19BC, 19CC, 19AE, 59AD, 000F, 000F, 1DB5, 1DB6, 1DB7, 000F, 000F, 000F, 000F, 000F, 19A1, 19A2, 59A1, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 59D7, 19AE, 99CC, 19AE, 19CC, 19AE, 99CC, 19BC, 19D5, 000F, 000F, 1DC2, 1DC3, 1DC4, 000F, 000F, 000F, 19A1, 19A2, 99A6, 19B0, 19A6, 19A2, 59A1, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 19BB, 19BC, 19D5, 19C8, 19BB, 19BC, 19D5, 19C8, D9D5, 19AE, 59AD, 000F, 000F, 000F, 000F, 000F, 000F, 19AF, 19B0, 19A6, 19A2, 99A6, 19B0, D9A4, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 19C7, 19C8, 19DB, 000F, 19DC, 19C8, 19DD, 19C8, 19BB, 19BC, 19D5, 000F, 000F, 19A1, 19A2, 59A1, 000F, 59B2, 19A2, 99A6, 19B0, 19A6, 19A2, 59A4, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 19C7, 19C8, 19DB, 000F, 19C7, 19C8, 19DB, 000F, 000F, 19AF, 19B0, 19A6, 19A2, 99A6, 19B0, 19A6, 19A2, 99A6, 19A2, D9A4, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 19A7, 19A8, 59A7, 000F, 19A7, 19A8, 59A7, 19BD, 19BE, 19AF, 19B0, 19A6, 19A2, 99A6, 19A2, D9A4, 19BE, 19C1, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 19A7, 19A8, 99AC, 19B6, 19AC, 19A8, 99AC, 19B6, 19B7, 000F, 000F, 59B2, 19A2, 99A6, 19A2, D9A4, 19BE, 19A3, 19BE, 19C1, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 19A7, 19A8, 99AC, 19B6, 19AC, 19A8, 99AC, 19B6, 19AC, 19A8, 59BA, 000F, 000F, 19AF, 19B0, D9A4, 19BE, 19C1, 000F, 19BD, 19BE, 19BF, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 19B5, 19B6, 19AC, 19A8, 59AC, 19B6, 19AC, 19A8, 99AC, 19B6, 19AC, 19A8, 59A7, 19C0, 19BE, 19C1, 19BE, 19BF, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 19C2, 19C3, 19B5, 19B6, 19B7, 19C3, 19B5, 19A8, 19B7, 19C3, 19B5, 19A8, 19B7, 19BD, 19BE, 19BF, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 19C2, 19C3, 19C4, 000F, 19C2, 19C3, 19C4, 000F, 19C2, 19C3, 19C4, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F
}


;;; $BF1A: Area select background tilemap - Crateria ;;;
{
$81:BF1A             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 1C51, 1C4E, 5C50, 000F, 1C50, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 1C51, 1C4E, 5C50, 000F, 000F, 000F, 000F, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C50, 000F, 1C54, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C51, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F,
                        9C4D, 1C53, 1C4D, 1C4E, 000F, 000F, 000F, 000F, 9C51, 1C53, DC51, 000F, 9C51, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C50, 000F, 1C50, 1C4E, 5C51, 000F, 000F, 000F,
                        1C4D, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 1C53, 1C4D, 1C4E, 5C51, 000F,
                        9C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F,
                        9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F
}


;;; $C71A: Area select background tilemap - Brinstar ;;;
{
$81:C71A             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 9C54, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 1C51, 1C4E, 5C4D, 1C53, DC50, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C51, 1C4E, 5C50, 000F, 1C50, 1C4E, 5C4D, 1C53, DC50, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        9C4D, 1C53, 000F, 000F, 000F, 000F, 1C50, 1C4E, 5C4D, 1C53, DC50, 000F, 000F, 000F, 000F, 000F, 9C50, 1C53, DC50, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C51, 000F, 000F, 000F,
                        1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC50, 000F, 9C50, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F,
                        9C4D, 1C53, 1C4D, 1C4E, 5C52, 000F, 1C52, 1C4E, 5C50, 000F, 1C50, 1C4E, 5C4D, 1C53, 1C4D, 5C55, 000F, 9C51, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C50, 1C4E, 5C4D, 000F, 000F, 000F, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C52, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C53, 1C4D, 5C51, 000F, 1C51, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F,
                        9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
}


;;; $CF1A: Area select background tilemap - Norfair ;;;
{
$81:CF1A             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C54, 000F, 000F, 000F, 000F, 000F, 9C54, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, DC50, 000F, 9C50, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 9C57, 1C4E, 5C50, 000F, 1C50, 1C4E, 5C4D, 1C53, 1C4D, 5C55, 000F, 9C51, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C50, 1C4E, 5C4D, 000F, 000F, 000F, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 1C51, 1C4E, 5C52, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C53, 1C4D, 5C51, 000F, 1C56, 1C4D, 1C4E, 5C4D, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C51, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        9C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C4E, 5C4D, DC51, 000F, 1C55, 5C4D, 5C52, 000F, 000F, 000F, 000F, 000F, 000F, 5C51, 000F, 000F, 000F,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC50, 000F, 9C58, 1C53, DC50, 000F, 9C58, 1C53, 1C4D, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C4D, 1C4E, 5C51, 000F,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 9C51, 1C53, DC51, 000F, 9C51, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 5C52, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 000F, 000F, 000F, 000F, 000F, 5C4D, 5C51, 000F, 1C56, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 000F, 000F, 000F, 000F, 1C56, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C51, 000F, 1C51, 5C51, 000F, 1C56, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F,
                        9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
}


;;; $D71A: Area select background tilemap - Wrecked Ship ;;;
{
$81:D71A             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 1C54, 000F, 1C50, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 1C51, 1C4E, 000F, 000F, 000F, 000F, 9C50, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 000F, 000F, 000F, 000F, 000F, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C51, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 000F, 1C50, 1C4E, 5C50, 000F, 1C50, 1C4E, 5C50, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        9C4D, 1C53, 1C4D, 1C4E, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C4D, 1C4E, 5C4D, 1C53, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C51, 000F,
                        9C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53,
                        9C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F,
                        1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F,
                        9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
}


;;; $DF1A: Area select background tilemap - Maridia ;;;
{
$81:DF1A             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 1C51, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 9C51, 5C4D, 1C53, 1C4D, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 1C51, 000F, 000F, 000F, 000F, 1C55, 5C4D, 1C53, 1C4D, 5C51, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4D, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C4E, 5C4D, 5C51, 000F, 000F, 000F, 000F, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 5C51, 000F, 1C51, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 000F, 000F, 000F, 000F, 1C51, 5C51, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C53, 1C4D, 1C4E, 5C4D, 5C57, 000F, 1C52, 5C4D, DC51, 000F, 1C55, 5C4D, 1C53, 1C4D, 1C4E, 5C50, 000F, 1C50, 1C4E, 5C4D, 5C51, 000F, 1C51, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F,
                        1C4E, 5C4D, 1C53, 1C4D, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C55, 5C4D, 1C53, 000F, 000F, 000F, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F,
                        1C53, 1C4D, 1C4E, 5C4D, 5C57, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C51,
                        1C4E, 5C4D, 1C53, 1C4D, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D,
                        1C53, 1C4D, 1C4E, 5C4D, 5C51, 000F, 1C56, 5C4D, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 5C4D, 1C53, DC51, 000F, 9C51, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 5C51, 000F, 1C56, 1C4D, 5C51, 000F, 1C56, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
}


;;; $E71A: Area select background tilemap - Tourian ;;;
{
$81:E71A             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 1C51, 000F, 000F, 000F, 000F, 1C55, 5C4D, DC51, 000F, 1C55, 5C4D, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 1C51, 1C4E, 5C4D, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C4E, 5C4D, 1C53, 1C4D, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C53, 1C4D, 1C4E, 5C4D, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 5C51, 000F, 000F,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4D, 1C4E, 5C51,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 5C51, 000F, 000F, 000F, 000F, 000F, 1C51, 5C4D, 5C51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 1C51, 1C4D, 1C4E, 5C4D, 1C53, 1C4D,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 5C51, 000F, 1C51, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 000F, 000F, 000F, 000F, 1C51, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 9C51, 1C53, 1C4D, 5C51, 000F, 1C51, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C51, 000F, 1C51, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F,
                        1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F,
                        1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, 1C4D, 1C4E, 5C4D, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 9C51, 1C53, DC51, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F
}
}


;;; $EF1A: Free space ;;;
{
$81:EF1A             fillto $81FF00, $FF
}


;;; $FF00: Thanks Genji! ;;;
{
$81:FF00             db 20,53,70,65,63,69,61,6C,20,74,68,61,6E,6B,73,20, ; ' Special thanks '
                        20,20,20,20,20,20,20,32,20,20,20,20,20,20,20,20, ; '       2        '
                        20,20,47,65,6E,6A,69,20,4B,75,62,6F,74,61,20,20, ; '  Genji Kubota  '
                        20,20,20,20,20,20,20,26,20,20,20,20,20,20,20,20, ; '       &        '
                        61,6C,6C,20,64,65,62,75,67,20,73,74,61,66,66,2E, ; 'all debug staff.'
                        20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20  ; '                '
}


;;; $FF60: Free space ;;;
{
$81:FF60             fillto $828000, $FF
}
