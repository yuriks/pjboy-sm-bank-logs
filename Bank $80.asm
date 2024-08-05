;;; $8000: Debug constants ;;;
{
$80:8000             dw 0000 ; Skip NTSC/PAL and SRAM mapping check ($85F6)
$80:8002             dw 0000 ; Demo recorder ($90:E759)
$80:8004             dw 0000 ; Debug mode, written to $05D1 on boot
$80:8006             dw 0000 ; Debug scrolling ($82:8B44: game state 8 - main gameplay)
$80:8008             dw 0000 ; Disable audio ($80:8024)
}


;;; $800A: Upload to APU (hardcoded parameter) ;;;
{
;; Parameter:
;;     [[S] + 1] + 1: APU data pointer ($CF:8000)
$80:800A A3 02       LDA $02,s  [$7E:1FFE]  ;\
$80:800C 85 04       STA $04    [$7E:0004]  ;|
$80:800E A3 01       LDA $01,s  [$7E:1FFD]  ;} $03 = (return address)
$80:8010 85 03       STA $03    [$7E:0003]  ;/
$80:8012 18          CLC                    ;\
$80:8013 69 03 00    ADC #$0003             ;} Adjust return address
$80:8016 83 01       STA $01,s  [$7E:1FFD]  ;/
$80:8018 A0 01 00    LDY #$0001             ;\
$80:801B B7 03       LDA [$03],y[$80:845D]  ;|
$80:801D 85 00       STA $00    [$7E:0000]  ;|
$80:801F C8          INY                    ;} $00 = [(return address) + 1] (parameter address)
$80:8020 B7 03       LDA [$03],y[$80:845E]  ;|
$80:8022 85 01       STA $01    [$7E:0001]  ;/
}


;;; $8024: Upload to APU (from [$00]) ;;;
{
;; Parameter
;;     $00: APU data pointer
$80:8024 20 28 80    JSR $8028  [$80:8028]
$80:8027 6B          RTL

$80:8028 AF 08 80 80 LDA $808008[$80:8008]  ;\
$80:802C F0 01       BEQ $01    [$802F]     ;} If [$80:8008] != 0:
$80:802E 60          RTS                    ; Return

$80:802F 08          PHP
$80:8030 8B          PHB
$80:8031 C2 30       REP #$30
$80:8033 A9 FF FF    LDA #$FFFF             ;\
$80:8036 8F 17 06 00 STA $000617[$7E:0617]  ;} Set uploading to APU flag
$80:803A E2 20       SEP #$20
$80:803C C2 10       REP #$10
$80:803E A9 FF       LDA #$FF               ;\
$80:8040 8F 40 21 00 STA $002140[$7E:2140]  ;} APU IO 0 = FFh (request APU upload)
$80:8044 A4 00       LDY $00    [$7E:0000]  ; Y = parameter short address
$80:8046 A5 02       LDA $02    [$7E:0002]  ;\
$80:8048 48          PHA                    ;} Set DB to parameter bank
$80:8049 AB          PLB                    ;/
$80:804A C2 30       REP #$30
$80:804C 20 59 80    JSR $8059  [$80:8059]  ; Send APU data
$80:804F A9 00 00    LDA #$0000             ;\
$80:8052 8F 17 06 00 STA $000617[$7E:0617]  ;} Clear uploading to APU flag
$80:8056 AB          PLB
$80:8057 28          PLP
$80:8058 60          RTS
}


;;; $8059: Send APU data ;;;
{
;; Parameters:
;;     Y: Address of data
;;     DB: Bank of data

; Data format:
;     ssss dddd [xx xx...] (data block 0)
;     ssss dddd [xx xx...] (data block 1)
;     ...
;     0000 aaaa
; Where:
;     s = data block size in bytes
;     d = destination address
;     x = data
;     a = entry address. Ignored by SPC engine after first APU transfer

; The xx data can cross bank boundaries, but the data block entries otherwise can't (i.e. s, d, a and 0000) unless they're word-aligned

; Wait until APU sets APU IO 0..1 = AAh BBh
; Kick = CCh
; For each data block:
;    APU IO 2..3 = destination address
;    APU IO 1 = 1 (arbitrary non-zero value)
;    APU IO 0 = kick
;    Wait until APU echoes kick back through APU IO 0
;    Index = 0
;    For each data byte
;       APU IO 1 = data byte
;       APU IO 0 = index
;       Wait until APU echoes index back through APU IO 0
;       Increment index
;    Increment index (and again if resulting in 0)
;    Kick = index
; Send entry address through APU IO 2..3
; APU IO 1 = 0
; APU IO 0 = kick
; (Optionally wait until APU echoes kick back through APU IO 0)

$80:8059 08          PHP
$80:805A C2 30       REP #$30
$80:805C A9 00 30    LDA #$3000             ;\
$80:805F 8F 41 06 00 STA $000641[$7E:0641]  ;|
                                            ;|
$80:8063 A9 AA BB    LDA #$BBAA             ;|
$80:8066 CF 40 21 00 CMP $002140[$7E:2140]  ;|
$80:806A F0 0D       BEQ $0D    [$8079]     ;} Wait until [APU IO 0..1] = AAh BBh
$80:806C AF 41 06 00 LDA $000641[$7E:0641]  ;|
$80:8070 3A          DEC A                  ;|
$80:8071 8F 41 06 00 STA $000641[$7E:0641]  ;|
$80:8075 D0 EC       BNE $EC    [$8063]     ;/

$80:8077 80 FE       BRA $FE    [$8077]     ; If exceeded 3000h attempts: crash

$80:8079 E2 20       SEP #$20
$80:807B A9 CC       LDA #$CC               ; Kick = CCh
$80:807D 80 2F       BRA $2F    [$80AE]     ; Go to BRANCH_PROCESS_DATA_BLOCK

; BRANCH_UPLOAD_DATA_BLOCK
$80:807F B9 00 00    LDA $0000,y[$CF:8004]  ;\
$80:8082 20 03 81    JSR $8103  [$80:8103]  ;} Data = [[Y++]]
$80:8085 EB          XBA                    ;/
$80:8086 A9 00       LDA #$00               ; Index = 0
$80:8088 80 0F       BRA $0F    [$8099]     ; Go to BRANCH_UPLOAD_DATA

; LOOP_NEXT_DATA
$80:808A EB          XBA                    ;\
$80:808B B9 00 00    LDA $0000,y[$CF:8005]  ;|
$80:808E 20 03 81    JSR $8103  [$80:8103]  ;} Data = [[Y++]]
$80:8091 EB          XBA                    ;/

$80:8092 CF 40 21 00 CMP $002140[$7E:2140]  ;\
$80:8096 D0 FA       BNE $FA    [$8092]     ;} Wait until APU IO 0 echoes
$80:8098 1A          INC A                  ; Increment index

; BRANCH_UPLOAD_DATA
$80:8099 C2 20       REP #$20
$80:809B 8F 40 21 00 STA $002140[$7E:2140]  ; APU IO 0..1 = [index] [data]
$80:809F E2 20       SEP #$20
$80:80A1 CA          DEX                    ; Decrement X (block size)
$80:80A2 D0 E6       BNE $E6    [$808A]     ; If [X] != 0: go to LOOP_NEXT_DATA

$80:80A4 CF 40 21 00 CMP $002140[$7E:2140]  ;\
$80:80A8 D0 FA       BNE $FA    [$80A4]     ;} Wait until APU IO 0 echoes

$80:80AA 69 03       ADC #$03               ; Kick = [index] + 4
$80:80AC F0 FC       BEQ $FC    [$80AA]     ; Ensure kick != 0

; BRANCH_PROCESS_DATA_BLOCK
$80:80AE 48          PHA
$80:80AF C2 20       REP #$20
$80:80B1 B9 00 00    LDA $0000,y[$CF:8000]  ;\
$80:80B4 20 00 81    JSR $8100  [$80:8100]  ;} X = [[Y]] (block size)
$80:80B7 AA          TAX                    ;} Y += 2
$80:80B8 B9 00 00    LDA $0000,y[$CF:8002]  ;\
$80:80BB 20 00 81    JSR $8100  [$80:8100]  ;} APU IO 2..3 = [[Y]] (destination address)
$80:80BE 8F 42 21 00 STA $002142[$7E:2142]  ;} Y += 2
$80:80C2 E2 20       SEP #$20
$80:80C4 E0 01 00    CPX #$0001             ;\
$80:80C7 A9 00       LDA #$00               ;|
$80:80C9 2A          ROL A                  ;} If block size = 0: APU IO 1 = 0 (EOF), else APU IO 1 = 1 (arbitrary non-zero value)
$80:80CA 8F 41 21 00 STA $002141[$7E:2141]  ;/
$80:80CE 69 7F       ADC #$7F               ; Set overflow if block size != 0, else clear overflow
$80:80D0 68          PLA                    ;\
$80:80D1 8F 40 21 00 STA $002140[$7E:2140]  ;} APU IO 0 = kick
$80:80D5 DA          PHX
$80:80D6 A2 00 10    LDX #$1000             ;\
                                            ;|
$80:80D9 CA          DEX                    ;} Wait until APU IO 0 echoes
$80:80DA F0 16       BEQ $16    [$80F2]     ;} If exceeded 1000h attempts: return
$80:80DC CF 40 21 00 CMP $002140[$7E:2140]  ;|
$80:80E0 D0 F7       BNE $F7    [$80D9]     ;/
$80:80E2 FA          PLX
$80:80E3 70 9A       BVS $9A    [$807F]     ; If block size != 0: go to BRANCH_UPLOAD_DATA_BLOCK
$80:80E5 E2 20       SEP #$20
$80:80E7 9C 41 21    STZ $2141              ;\
$80:80EA 9C 42 21    STZ $2142              ;} These stores have no effect (because DB is set to some hirom bank), but there's also no reason to do these stores anyway
$80:80ED 9C 43 21    STZ $2143              ;/
$80:80F0 28          PLP
$80:80F1 60          RTS                    ; Return

$80:80F2 E2 20       SEP #$20
$80:80F4 9C 41 21    STZ $2141
$80:80F7 9C 42 21    STZ $2142
$80:80FA 9C 43 21    STZ $2143
$80:80FD FA          PLX
$80:80FE 28          PLP
$80:80FF 60          RTS
}


;;; $8100: Increment Y twice, bank overflow check ;;;
{
; Only increments Y once if overflows bank first time (which is a bug scenario)
$80:8100 C8          INY
$80:8101 F0 04       BEQ $04    [$8107]
}


;;; $8103: Increment Y, bank overflow check ;;;
{
$80:8103 C8          INY
$80:8104 F0 01       BEQ $01    [$8107]
$80:8106 60          RTS

$80:8107 E6 02       INC $02    [$7E:0002]  ; Increment $02
$80:8109 D4 01       PEI ($01)  [$D080]     ;\
$80:810B AB          PLB                    ;} DB = [$02]
$80:810C AB          PLB                    ;/
$80:810D A0 00 80    LDY #$8000             ; Y = 8000h
$80:8110 60          RTS
}


;;; $8111: Generate random number ;;;
{
;; Returns:
;;     A: New random number

; r(t+1) = r(t) * 5 + 0x111 (roughly; if the adding of x * 100h causes overflow, then a further 1 is added)
$80:8111 E2 20       SEP #$20
$80:8113 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$80:8116 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:8119 A9 05       LDA #$05               ;|
$80:811B 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:811E EA          NOP                    ;} A = [random number low] * 5
$80:811F C2 20       REP #$20               ;|
$80:8121 AD 16 42    LDA $4216  [$7E:4216]  ;|
$80:8124 48          PHA                    ;/
$80:8125 E2 20       SEP #$20
$80:8127 AD E6 05    LDA $05E6  [$7E:05E6]  ;\
$80:812A 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:812D A9 05       LDA #$05               ;|
$80:812F 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:8132 EB          XBA                    ;|
$80:8133 EA          NOP                    ;|
$80:8134 AD 16 42    LDA $4216  [$7E:4216]  ;} A += ([random number high] * 5 + 1) * 100h
$80:8137 38          SEC                    ;|
$80:8138 63 02       ADC $02,s  [$7E:1FFB]  ;|
$80:813A 83 02       STA $02,s  [$7E:1FFB]  ;|
$80:813C C2 20       REP #$20               ;|
$80:813E 68          PLA                    ;/
$80:813F 69 11 00    ADC #$0011             ;\
$80:8142 8D E5 05    STA $05E5  [$7E:05E5]  ;} Random number = [A] + 11h
$80:8145 6B          RTL
}


;;; $8146: Update held input ;;;
{
;; Parameter:
;;     A: Timed held input timer reset value ("timed held input" is input held for [A] + 1 frames)

; Called by:
;     $82:90E8: Game state Fh (paused, map and item screens) with A = 3

; Held input is [$8B] & ![$8F]: the input pressed, but not newly
$80:8146 08          PHP
$80:8147 8B          PHB
$80:8148 C2 30       REP #$30
$80:814A DA          PHX
$80:814B 4B          PHK
$80:814C AB          PLB
$80:814D 8D DD 05    STA $05DD  [$7E:05DD]  ; Timed held input timer reset value = [A]
$80:8150 A5 8B       LDA $8B    [$7E:008B]  ;\
$80:8152 85 12       STA $12    [$7E:0012]  ;|
$80:8154 A5 8F       LDA $8F    [$7E:008F]  ;|
$80:8156 14 12       TRB $12    [$7E:0012]  ;|
$80:8158 A5 12       LDA $12    [$7E:0012]  ;} If held input != [previous held input]: go to BRANCH_UNHELD
$80:815A CD D9 05    CMP $05D9  [$7E:05D9]  ;|
$80:815D 8D D9 05    STA $05D9  [$7E:05D9]  ; } Previous held input = held input
$80:8160 D0 13       BNE $13    [$8175]     ;/
$80:8162 CE DB 05    DEC $05DB  [$7E:05DB]  ; Decrement timed held input timer
$80:8165 10 14       BPL $14    [$817B]     ; If [timed held input timer] >= 0: go to BRANCH_POSITIVE
$80:8167 9C DB 05    STZ $05DB  [$7E:05DB]  ; Timed held input timer = 0
$80:816A AE DF 05    LDX $05DF  [$7E:05DF]  ;\
$80:816D 8E E3 05    STX $05E3  [$7E:05E3]  ;} Previous timed held input = [timed held input]
$80:8170 8D DF 05    STA $05DF  [$7E:05DF]  ; Timed held input = [held input]
$80:8173 80 09       BRA $09    [$817E]     ; Go to BRANCH_RETURN

; BRANCH_UNHELD
$80:8175 AD DD 05    LDA $05DD  [$7E:05DD]  ;\
$80:8178 8D DB 05    STA $05DB  [$7E:05DB]  ;} Timed held input timer = [timed held input timer reset value]

; BRANCH_POSITIVE
$80:817B 9C DF 05    STZ $05DF  [$7E:05DF]  ; Timed held input = 0

; BRANCH_RETURN
$80:817E AD DF 05    LDA $05DF  [$7E:05DF]  ;\
$80:8181 4D E3 05    EOR $05E3  [$7E:05E3]  ;|
$80:8184 2D DF 05    AND $05DF  [$7E:05DF]  ;} Newly held down timed held input = newly held down timed held input
$80:8187 8D E1 05    STA $05E1  [$7E:05E1]  ;/
$80:818A FA          PLX
$80:818B AB          PLB
$80:818C 28          PLP
$80:818D 6B          RTL
}


;;; $818E: Change bit index to byte index and bitmask ;;;
{
;; Parameter:
;;     A: Bit index, bit 15 is forbidden (why?)
;; Returns:
;;     A/X: Byte index ([A] >> 3)
;;     $05E7: Bitmask (1 << ([A] & 7))

; Called mostly by PLMs
$80:818E AA          TAX
$80:818F 10 01       BPL $01    [$8192]
$80:8191 00          BRK

$80:8192 9C E7 05    STZ $05E7  [$7E:05E7]
$80:8195 48          PHA
$80:8196 29 07 00    AND #$0007
$80:8199 38          SEC

$80:819A 2E E7 05    ROL $05E7  [$7E:05E7]
$80:819D 3A          DEC A
$80:819E 10 FA       BPL $FA    [$819A]
$80:81A0 68          PLA
$80:81A1 4A          LSR A
$80:81A2 4A          LSR A
$80:81A3 4A          LSR A
$80:81A4 AA          TAX
$80:81A5 6B          RTL
}


;;; $81A6: Set boss bits in A for current area ;;;
{
;; Parameter:
;;     A: Boss bits
;;         1: Area boss (Kraid, Phantoon, Draygon, both Ridleys)
;;         2: Area mini-boss (Spore Spawn, Botwoon, Crocomire, Mother Brain)
;;         4: Area torizo (Bomb Torizo, Golden Torizo)

$80:81A6 DA          PHX
$80:81A7 5A          PHY
$80:81A8 08          PHP
$80:81A9 E2 20       SEP #$20
$80:81AB 8D E7 05    STA $05E7  [$7E:05E7]
$80:81AE AE 9F 07    LDX $079F  [$7E:079F]
$80:81B1 BF 28 D8 7E LDA $7ED828,x[$7E:D82E]
$80:81B5 0D E7 05    ORA $05E7  [$7E:05E7]
$80:81B8 9F 28 D8 7E STA $7ED828,x[$7E:D82E]
$80:81BC 28          PLP
$80:81BD 7A          PLY
$80:81BE FA          PLX
$80:81BF 6B          RTL
}


;;; $81C0: Unused. Clear boss bits in A for current area ;;;
{
;; Parameter:
;;     A: Boss bits
;;         1: Area boss (Kraid, Phantoon, Draygon, both Ridleys)
;;         2: Area mini-boss (Spore Spawn, Botwoon, Crocomire, Mother Brain)
;;         4: Area torizo (Bomb Torizo, Golden Torizo)
$80:81C0 DA          PHX
$80:81C1 5A          PHY
$80:81C2 08          PHP
$80:81C3 E2 20       SEP #$20
$80:81C5 49 FF       EOR #$FF
$80:81C7 8D E7 05    STA $05E7  [$7E:05E7]
$80:81CA AE 9F 07    LDX $079F  [$7E:079F]
$80:81CD BF 28 D8 7E LDA $7ED828,x[$7E:D828]
$80:81D1 2D E7 05    AND $05E7  [$7E:05E7]
$80:81D4 9F 28 D8 7E STA $7ED828,x[$7E:D828]
$80:81D8 28          PLP
$80:81D9 7A          PLY
$80:81DA FA          PLX
$80:81DB 6B          RTL
}


;;; $81DC: Checks if the boss bits for the current area match any bits in A ;;;
{
;; Parameter:
;;     A: Boss bits
;;         1: Area boss (Kraid, Phantoon, Draygon, both Ridleys)
;;         2: Area mini-boss (Spore Spawn, Botwoon, Crocomire, Mother Brain)
;;         4: Area torizo (Bomb Torizo, Golden Torizo)
;; Returns:
;;     A/carry: Set if there's a match

$80:81DC DA          PHX
$80:81DD 5A          PHY
$80:81DE 08          PHP
$80:81DF E2 20       SEP #$20
$80:81E1 8D E7 05    STA $05E7  [$7E:05E7]
$80:81E4 AE 9F 07    LDX $079F  [$7E:079F]
$80:81E7 BF 28 D8 7E LDA $7ED828,x[$7E:D82E]
$80:81EB 2D E7 05    AND $05E7  [$7E:05E7]
$80:81EE D0 05       BNE $05    [$81F5]
$80:81F0 28          PLP
$80:81F1 7A          PLY
$80:81F2 FA          PLX
$80:81F3 18          CLC
$80:81F4 6B          RTL

$80:81F5 28          PLP
$80:81F6 7A          PLY
$80:81F7 FA          PLX
$80:81F8 38          SEC
$80:81F9 6B          RTL
}


;;; $81FA: Mark event [A] ;;;
{
;; Parameter:
;;     A: Event number
       {
;;         0   - Zebes is awake
;;         1   - Shitroid ate sidehopper
;;         2   - Mother Brain's glass is destroyed
;;         3   - zebetite destroyed bit 0 (true if 1 or 3 zebetites are destroyed)
;;         4   - zebetite destroyed bit 1 (true if 2 or 3 zebetites are destroyed)
;;         5   - zebetite destroyed bit 2 (true if all 4 zebetites are destroyed)
;;         6   - Phantoon statue is grey
;;         7   - Ridley statue is grey
;;         8   - Draygon statue is grey
;;         9   - Kraid statue is grey
;;         Ah  - entrance to Tourian is unlocked
;;         Bh  - Maridia noobtube is broken
;;         Ch  - Lower Norfair chozo has lowered the acid
;;         Dh  - Shaktool cleared a path
;;         Eh  - Zebes timebomb set
;;         Fh  - critters escaped
;;         10h - 1st metroid hall cleared
;;         11h - 1st metroid shaft cleared
;;         12h - 2nd metroid hall cleared
;;         13h - 2nd metroid shaft cleared
;;         14h - unused
;;         15h - outran speed booster lavaquake
       }

$80:81FA DA          PHX
$80:81FB 5A          PHY
$80:81FC 08          PHP
$80:81FD C2 30       REP #$30
$80:81FF 22 8E 81 80 JSL $80818E[$80:818E]
$80:8203 BF 20 D8 7E LDA $7ED820,x[$7E:D820]
$80:8207 0D E7 05    ORA $05E7  [$7E:05E7]
$80:820A 9F 20 D8 7E STA $7ED820,x[$7E:D820]
$80:820E 28          PLP
$80:820F 7A          PLY
$80:8210 FA          PLX
$80:8211 6B          RTL
}


;;; $8212: Unmark a event [A] ;;;
{
;; Parameter:
;;     A: Event number

; Called by:
;     $A6:FCCB: Mark/unmark zebetite destroyed counter event
$80:8212 DA          PHX
$80:8213 5A          PHY
$80:8214 08          PHP
$80:8215 C2 30       REP #$30
$80:8217 22 8E 81 80 JSL $80818E[$80:818E]
$80:821B AD E7 05    LDA $05E7  [$7E:05E7]
$80:821E 49 FF FF    EOR #$FFFF
$80:8221 8D E7 05    STA $05E7  [$7E:05E7]
$80:8224 BF 20 D8 7E LDA $7ED820,x[$7E:D820]
$80:8228 2D E7 05    AND $05E7  [$7E:05E7]
$80:822B 9F 20 D8 7E STA $7ED820,x[$7E:D820]
$80:822F 28          PLP
$80:8230 7A          PLY
$80:8231 FA          PLX
$80:8232 6B          RTL
}


;;; $8233: Checks event [A] has happened ;;;
{
;; Parameter:
;;     A: Event number
;; Returns:
;;     Carry: Set if the event is marked

; Note that Tourian entrance statue FX routine $88:DCCB assumes this routine returns A = 0 when carry clear is returned
$80:8233 DA          PHX
$80:8234 5A          PHY
$80:8235 08          PHP
$80:8236 C2 30       REP #$30
$80:8238 22 8E 81 80 JSL $80818E[$80:818E]
$80:823C BF 20 D8 7E LDA $7ED820,x[$7E:D821]
$80:8240 2D E7 05    AND $05E7  [$7E:05E7]
$80:8243 D0 05       BNE $05    [$824A]
$80:8245 28          PLP
$80:8246 7A          PLY
$80:8247 FA          PLX
$80:8248 18          CLC
$80:8249 6B          RTL

$80:824A 28          PLP
$80:824B 7A          PLY
$80:824C FA          PLX
$80:824D 38          SEC
$80:824E 6B          RTL
}


;;; $824F: Write 'supermetroid' to SRAM  ;;;
{
; Called by:
;     $8B:E797

; $70:1FE0..1FEB = 'supermetroid'
$80:824F DA          PHX
$80:8250 A2 0A 00    LDX #$000A

$80:8253 BF B9 82 80 LDA $8082B9,x[$80:82C3]
$80:8257 9F E0 1F 70 STA $701FE0,x[$70:1FEA]
$80:825B CA          DEX
$80:825C CA          DEX
$80:825D 10 F4       BPL $F4    [$8253]
$80:825F FA          PLX
$80:8260 6B          RTL
}


;;; $8261: Check for non-corrupt SRAM ;;;
{
$80:8261 DA          PHX
$80:8262 A9 03 00    LDA #$0003             ;\
$80:8265 8D 59 1F    STA $1F59  [$7E:1F59]  ;} Number of demo sets = 3
$80:8268 A9 00 00    LDA #$0000             ;\
$80:826B 22 85 80 81 JSL $818085[$81:8085]  ;} Load SRAM slot A
$80:826F 90 23       BCC $23    [$8294]     ; If not corrupt, go to BRANCH_NON_CORRUPT
$80:8271 A9 01 00    LDA #$0001             ;\
$80:8274 22 85 80 81 JSL $818085[$81:8085]  ;} Load SRAM slot B
$80:8278 90 1A       BCC $1A    [$8294]     ; If not corrupt, go to BRANCH_NON_CORRUPT
$80:827A A9 02 00    LDA #$0002             ;\
$80:827D 22 85 80 81 JSL $818085[$81:8085]  ;} Load SRAM slot C
$80:8281 90 11       BCC $11    [$8294]     ; If not corrupt, go to BRANCH_NON_CORRUPT
$80:8283 A2 0A 00    LDX #$000A             ;\
                                            ;|
$80:8286 BF AD 82 80 LDA $8082AD,x[$80:949A];|
$80:828A 9F E0 1F 70 STA $701FE0,x[$70:31CD];} $70:1FE0..1FEB = 'madadameyohn' (all SRAM is corrupt)
$80:828E CA          DEX                    ;|
$80:828F CA          DEX                    ;|
$80:8290 10 F4       BPL $F4    [$8286]     ;/
$80:8292 FA          PLX
$80:8293 6B          RTL                    ; Return

; BRANCH_NON_CORRUPT
$80:8294 A2 0A 00    LDX #$000A             ;\
                                            ;|
$80:8297 BF E0 1F 70 LDA $701FE0,x[$70:1FEA];|
$80:829B DF B9 82 80 CMP $8082B9,x[$80:82C3];|
$80:829F D0 0A       BNE $0A    [$82AB]     ;} If $70:1FE0..1FEB = 'supermetroid':
                                            ;|
$80:82A1 CA          DEX                    ;|
$80:82A2 CA          DEX                    ;|
$80:82A3 10 F2       BPL $F2    [$8297]     ;/
$80:82A5 A9 04 00    LDA #$0004             ;\
$80:82A8 8D 59 1F    STA $1F59  [$7E:1F59]  ;} Number of demo sets = 4

$80:82AB FA          PLX
$80:82AC 6B          RTL

$80:82AD             db 6D, 61, 64, 61, 64, 61, 6D, 65, 79, 6F, 68, 6E ; madadameyohn
$80:82B9             db 73, 75, 70, 65, 72, 6D, 65, 74, 72, 6F, 69, 64 ; supermetroid
}


;;; $82C5: Wait until the end of a v-blank ;;;
{
$80:82C5 48          PHA
$80:82C6 08          PHP
$80:82C7 E2 20       SEP #$20

$80:82C9 AD 12 42    LDA $4212  [$7E:4212]  ;\
$80:82CC 10 FB       BPL $FB    [$82C9]     ;} Wait until v-blank is active

$80:82CE AD 12 42    LDA $4212  [$7E:4212]  ;\
$80:82D1 30 FB       BMI $FB    [$82CE]     ;} Wait until v-blank has finished
$80:82D3 28          PLP
$80:82D4 68          PLA
$80:82D5 6B          RTL
}


;;; $82D6: $05F1 = [A] * [Y] (16-bit unsigned multiplication) ;;;
{
;; Parameters:
;;     A: Multiplicand
;;     Y: Multiplicand
;; Returns:
;;     $05F1..F4: 32-bit result

; Called by:
;     $94:84D6: Block collision reaction - horizontal - slope - non-square
;     $94:ACFE (grapple beam collision detection)
;     $9B:CA65 (grapple)
;     $A0:C449: Enemy block collision horizontal reaction - slope - non-square
;     $A3:E8A5 (geemer)

; Exactly 1060 master cycles (78% of a scanline) (1250 if using slowrom).

; Can be inaccurate.
; Let:
;     [A] = a + b * 100h
;     [Y] = c + d * 100h
; Then:
;    [A] * [Y] = (a + b * 100h) (c + d * 100h)
;              = ac + (bc + ad) * 100h + bd * 10000h
; However, (bc + ad) can overflow 10000h (e.g. C0h * C0h + C0h * C0h = 12000h)
; and the carry isn't propagated to the calculation of bd (instruction $832D should be removed).

$80:82D6 DA          PHX
$80:82D7 8D E9 05    STA $05E9  [$7E:05E9]  ; Let $05E9 = a + b * 100h
$80:82DA 8C EB 05    STY $05EB  [$7E:05EB]  ; Let $05EB = c + d * 100h
$80:82DD 9C F1 05    STZ $05F1  [$7E:05F1]  ;\
$80:82E0 9C F3 05    STZ $05F3  [$7E:05F3]  ;} Result = 0
$80:82E3 E2 10       SEP #$10
$80:82E5 AC EB 05    LDY $05EB  [$7E:05EB]  ;\
$80:82E8 8C 02 42    STY $4202  [$7E:4202]  ;|
$80:82EB AC E9 05    LDY $05E9  [$7E:05E9]  ;|
$80:82EE 8C 03 42    STY $4203  [$7E:4203]  ;|
$80:82F1 EA          NOP                    ;} Result = ac
$80:82F2 EA          NOP                    ;|
$80:82F3 EA          NOP                    ;|
$80:82F4 AD 16 42    LDA $4216  [$7E:4216]  ;|
$80:82F7 8D F1 05    STA $05F1  [$7E:05F1]  ;/
$80:82FA AC EA 05    LDY $05EA  [$7E:05EA]  ;\
$80:82FD 8C 03 42    STY $4203  [$7E:4203]  ;|
$80:8300 EA          NOP                    ;|
$80:8301 AD F2 05    LDA $05F2  [$7E:05F2]  ;} Result += bc * 100h
$80:8304 18          CLC                    ;|
$80:8305 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:8308 8D F2 05    STA $05F2  [$7E:05F2]  ;/
$80:830B AC EC 05    LDY $05EC  [$7E:05EC]  ;\
$80:830E 8C 02 42    STY $4202  [$7E:4202]  ;|
$80:8311 AC E9 05    LDY $05E9  [$7E:05E9]  ;|
$80:8314 8C 03 42    STY $4203  [$7E:4203]  ;|
$80:8317 EA          NOP                    ;} Result += ad * 100h
$80:8318 AD F2 05    LDA $05F2  [$7E:05F2]  ;|
$80:831B 18          CLC                    ;|
$80:831C 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:831F 8D F2 05    STA $05F2  [$7E:05F2]  ;/
$80:8322 AC EA 05    LDY $05EA  [$7E:05EA]  ;\
$80:8325 8C 03 42    STY $4203  [$7E:4203]  ;|
$80:8328 EA          NOP                    ;|
$80:8329 EA          NOP                    ;|
$80:832A AD F3 05    LDA $05F3  [$7E:05F3]  ;} Result += bd * 10000h
$80:832D 18          CLC                    ;|
$80:832E 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:8331 8D F3 05    STA $05F3  [$7E:05F3]  ;/
$80:8334 C2 30       REP #$30
$80:8336 FA          PLX
$80:8337 6B          RTL
}


;;; $8338: Wait for NMI ;;;
{
$80:8338 08          PHP
$80:8339 8B          PHB
$80:833A 4B          PHK
$80:833B AB          PLB
$80:833C E2 30       SEP #$30
$80:833E A9 01       LDA #$01               ;\
$80:8340 8D B4 05    STA $05B4  [$7E:05B4]  ;} Set NMI request flag

$80:8343 AD B4 05    LDA $05B4  [$7E:05B4]  ;\
$80:8346 D0 FB       BNE $FB    [$8343]     ;} Wait until NMI request acknowledged
$80:8348 AB          PLB
$80:8349 28          PLP
$80:834A 6B          RTL
}


;;; $834B: Enable NMI ;;;
{
$80:834B 08          PHP
$80:834C 8B          PHB
$80:834D 4B          PHK
$80:834E AB          PLB
$80:834F E2 20       SEP #$20
$80:8351 A5 84       LDA $84    [$7E:0084]
$80:8353 09 80       ORA #$80
$80:8355 8D 00 42    STA $4200  [$7E:4200]
$80:8358 85 84       STA $84    [$7E:0084]
$80:835A AB          PLB
$80:835B 28          PLP
$80:835C 6B          RTL
}


;;; $835D: Disable NMI ;;;
{
$80:835D 08          PHP
$80:835E 8B          PHB
$80:835F 4B          PHK
$80:8360 AB          PLB
$80:8361 E2 20       SEP #$20
$80:8363 A5 84       LDA $84    [$7E:0084]
$80:8365 29 7F       AND #$7F
$80:8367 8D 00 42    STA $4200  [$7E:4200]
$80:836A 85 84       STA $84    [$7E:0084]
$80:836C AB          PLB
$80:836D 28          PLP
$80:836E 6B          RTL
}


;;; $836F: Set force blank and wait for NMI ;;;
{
; Called by:
;     $B032: Unused. Set up rotating mode 7 background
;     $81:8D0F: (Debug) game over menu - index 0: fade out and configure graphics for menu
;     $81:944E: File select menu - index 0: title sequence to main - fade out and configure graphics
;     $81:94EE: File select menu - index 5/13h: fade out from main
;     $81:AF83: File select map - index Eh: room select map to loading game data - wait
;     $A7:C1FB: Unpause hook - Kraid is dead
;     $A7:C24E: Unpause hook - Kraid is alive
;     $A7:C2A0: Unpause hook - Kraid is sinking

; Note that setting force blank allows PPU writes even if NMI execution spills into the next frame's drawing period,
; so you can set up large VRAM transfers before calling this
$80:836F 08          PHP
$80:8370 8B          PHB
$80:8371 4B          PHK
$80:8372 AB          PLB
$80:8373 E2 20       SEP #$20
$80:8375 A5 51       LDA $51    [$7E:0051]
$80:8377 09 80       ORA #$80
$80:8379 85 51       STA $51    [$7E:0051]
$80:837B 22 38 83 80 JSL $808338[$80:8338]
$80:837F AB          PLB
$80:8380 28          PLP
$80:8381 6B          RTL
}


;;; $8382: Clear force blank and wait for NMI ;;;
{
; Called by:
;     $B032: Unused. Set up rotating mode 7 background
;     $81:8D6D: Debug game over menu - index 1: initialise
;     $81:91A4: Game over menu - index 1: initialise
;     $81:9ED6: File select menu - index 2: title sequence to main - initialise
;     $A7:C24E: Unpause hook - Kraid is alive
$80:8382 08          PHP
$80:8383 8B          PHB
$80:8384 4B          PHK
$80:8385 AB          PLB
$80:8386 E2 20       SEP #$20
$80:8388 A5 51       LDA $51    [$7E:0051]
$80:838A 29 7F       AND #$7F
$80:838C 85 51       STA $51    [$7E:0051]
$80:838E 22 38 83 80 JSL $808338[$80:8338]
$80:8392 AB          PLB
$80:8393 28          PLP
$80:8394 6B          RTL
}


;;; $8395: Unused. Update CGRAM ;;;
{
; This routine is subsumed by $933A (update OAM & CGRAM)
$80:8395 08          PHP
$80:8396 E2 10       SEP #$10
$80:8398 C2 20       REP #$20
$80:839A A9 00 22    LDA #$2200
$80:839D 8D 10 43    STA $4310  [$7E:4310]
$80:83A0 A9 00 C0    LDA #$C000
$80:83A3 8D 12 43    STA $4312  [$7E:4312]
$80:83A6 A2 7E       LDX #$7E
$80:83A8 8E 14 43    STX $4314  [$7E:4314]
$80:83AB A9 00 02    LDA #$0200
$80:83AE 8D 15 43    STA $4315  [$7E:4315]
$80:83B1 A2 00       LDX #$00
$80:83B3 8E 21 21    STX $2121  [$7E:2121]
$80:83B6 A2 02       LDX #$02
$80:83B8 8E 0B 42    STX $420B  [$7E:420B]
$80:83BB 28          PLP
$80:83BC 6B          RTL
}


;;; $83BD: Unused. Write [Y] bytes of [A] to $00:0000 + [X] - 8-bit ;;;
{
$80:83BD 08          PHP
$80:83BE 8B          PHB
$80:83BF 4B          PHK
$80:83C0 AB          PLB
$80:83C1 E2 20       SEP #$20
$80:83C3 C2 10       REP #$10

$80:83C5 9F 00 00 00 STA $000000,x
$80:83C9 E8          INX
$80:83CA 88          DEY
$80:83CB D0 F8       BNE $F8    [$83C5]
$80:83CD AB          PLB
$80:83CE 28          PLP
$80:83CF 6B          RTL
}


;;; $83D0: Unused. Write [Y] bytes of [A] to $00:0000 + [X] - 16-bit ;;;
{
$80:83D0 08          PHP
$80:83D1 8B          PHB
$80:83D2 4B          PHK
$80:83D3 AB          PLB
$80:83D4 C2 30       REP #$30

$80:83D6 9F 00 00 00 STA $000000,x
$80:83DA E8          INX
$80:83DB E8          INX
$80:83DC 88          DEY
$80:83DD 88          DEY
$80:83DE D0 F6       BNE $F6    [$83D6]
$80:83E0 AB          PLB
$80:83E1 28          PLP
$80:83E2 6B          RTL
}


;;; $83E3: Unused. Write [Y] bytes of [A] to $7E:0000 + [X] - 8-bit ;;;
{
$80:83E3 08          PHP
$80:83E4 8B          PHB
$80:83E5 4B          PHK
$80:83E6 AB          PLB
$80:83E7 E2 20       SEP #$20
$80:83E9 C2 10       REP #$10

$80:83EB 9F 00 00 7E STA $7E0000,x
$80:83EF E8          INX
$80:83F0 88          DEY
$80:83F1 D0 F8       BNE $F8    [$83EB]
$80:83F3 AB          PLB
$80:83F4 28          PLP
$80:83F5 6B          RTL
}


;;; $83F6: Write [Y] bytes of [A] to $7E:0000 + [X] - 16-bit ;;;
{
; Called by:
;     $88B4: Unused. Clear high RAM
;     $88EB: Write 800h bytes of [A] to $7E:3000
;     $88FE: Write 800h bytes of [A] to $7E:4000
;     $88FE: Write 800h bytes of [A] to $7E:6000
;     $82:81DD: Initialise PPU registers
;     $8B:8000
;     $8B:80DA
$80:83F6 08          PHP
$80:83F7 8B          PHB
$80:83F8 4B          PHK
$80:83F9 AB          PLB
$80:83FA C2 30       REP #$30

$80:83FC 9F 00 00 7E STA $7E0000,x[$7E:3000]
$80:8400 E8          INX
$80:8401 E8          INX
$80:8402 88          DEY
$80:8403 88          DEY
$80:8404 D0 F6       BNE $F6    [$83FC]
$80:8406 AB          PLB
$80:8407 28          PLP
$80:8408 6B          RTL
}


;;; $8409: Write [Y] bytes of [A] to $7F:0000 + [X] - 16-bit ;;;
{
; Called by
;     $88B4: Unused. Clear high RAM
$80:8409 08          PHP
$80:840A 8B          PHB
$80:840B 4B          PHK
$80:840C AB          PLB
$80:840D C2 30       REP #$30

$80:840F 9F 00 00 7F STA $7F0000,x[$7F:11ED]
$80:8413 E8          INX
$80:8414 E8          INX
$80:8415 88          DEY
$80:8416 88          DEY
$80:8417 D0 F6       BNE $F6    [$840F]
$80:8419 AB          PLB
$80:841A 28          PLP
$80:841B 6B          RTL
}


;;; $841C: Boot ;;;
{
$80:841C 78          SEI                    ; Disable IRQ
$80:841D 18          CLC                    ;\
$80:841E FB          XCE                    ;} Enable native mode
$80:841F 5C 23 84 80 JML $808423[$80:8423]  ; Execute in bank $80 (FastROM)
$80:8423 E2 20       SEP #$20
$80:8425 A9 01       LDA #$01               ;\
$80:8427 8D 0D 42    STA $420D  [$7E:420D]  ;} Enable FastROM
$80:842A 85 86       STA $86    [$7E:0086]  ;/
$80:842C C2 30       REP #$30
$80:842E A2 FF 1F    LDX #$1FFF             ;\
$80:8431 9A          TXS                    ;} Allocate stack memory
$80:8432 A9 00 00    LDA #$0000             ;\
$80:8435 5B          TCD                    ;} Clear direct page
$80:8436 4B          PHK                    ;\
$80:8437 AB          PLB                    ;} DB = $80
$80:8438 E2 30       SEP #$30
$80:843A A2 04       LDX #$04               ;\
                                            ;|
$80:843C AD 12 42    LDA $4212  [$7E:4212]  ;|
$80:843F 10 FB       BPL $FB    [$843C]     ;|
                                            ;} Wait the remainder of this frame and 3 more frames (???)
$80:8441 AD 12 42    LDA $4212  [$7E:4212]  ;|
$80:8444 30 FB       BMI $FB    [$8441]     ;|
$80:8446 CA          DEX                    ;|
$80:8447 D0 F3       BNE $F3    [$843C]     ;/
$80:8449 C2 30       REP #$30
$80:844B A2 FE 1F    LDX #$1FFE             ;\
                                            ;|
$80:844E 9E 00 00    STZ $0000,x[$7E:1FFE]  ;|
$80:8451 CA          DEX                    ;} Clear $0000..1FFF
$80:8452 CA          DEX                    ;|
$80:8453 10 F9       BPL $F9    [$844E]     ;/
$80:8455 22 46 91 8B JSL $8B9146[$8B:9146]  ; Initialise IO registers and display Nintendo logo
$80:8459 22 0A 80 80 JSL $80800A[$80:800A]  ;\
$80:845D             dl CF8000              ;} Upload SPC engine to APU
$80:8460 80 20       BRA $20    [$8482]     ; Go to common boot section
}


;;; $8462: Soft reset ;;;
{
; Called by:
;     $9459: Read controller input. Also a debug branch
;     $81:9003: Debug game over menu - index 3: main
;     $81:90FE: Game over menu - index 7: fade out into soft reset
;     $81:94D5: File select menu - index 21h: fade out to title sequence

; Compared to boot ($841C), doesn't display Nintendo logo or upload SPC engine
$80:8462 78          SEI                    ; Disable IRQ
$80:8463 18          CLC                    ;\
$80:8464 FB          XCE                    ;} Enable native mode
$80:8465 C2 30       REP #$30
$80:8467 A2 FF 1F    LDX #$1FFF             ;\
$80:846A 9A          TXS                    ;} Allocate stack memory
$80:846B A9 00 00    LDA #$0000             ;\
$80:846E 5B          TCD                    ;} Clear direct page
$80:846F 4B          PHK                    ;\
$80:8470 AB          PLB                    ;} DB = $80
$80:8471 E2 30       SEP #$30
$80:8473 A2 04       LDX #$04               ;\
                                            ;|
$80:8475 AD 12 42    LDA $4212  [$80:4212]  ;|
$80:8478 10 FB       BPL $FB    [$8475]     ;|
                                            ;} Wait the remainder of this frame and 3 more frames (???)
$80:847A AD 12 42    LDA $4212  [$80:4212]  ;|
$80:847D 30 FB       BMI $FB    [$847A]     ;|
$80:847F CA          DEX                    ;|
$80:8480 D0 F3       BNE $F3    [$8475]     ;/
}


;;; $8482: Common boot section ;;;
{
$80:8482 E2 20       SEP #$20
$80:8484 A9 8F       LDA #$8F               ;\
$80:8486 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank
$80:8489 C2 30       REP #$30
$80:848B F4 00 7E    PEA $7E00              ;\
$80:848E AB          PLB                    ;|
$80:848F AB          PLB                    ;|
$80:8490 A2 FE 1F    LDX #$1FFE             ;|
                                            ;|
$80:8493 9E 00 00    STZ $0000,x[$7E:1FFE]  ;|
$80:8496 9E 00 20    STZ $2000,x[$7E:3FFE]  ;|
$80:8499 9E 00 40    STZ $4000,x[$7E:5FFE]  ;|
$80:849C 9E 00 60    STZ $6000,x[$7E:7FFE]  ;|
$80:849F 9E 00 80    STZ $8000,x[$7E:9FFE]  ;} Clear bank $7E
$80:84A2 9E 00 A0    STZ $A000,x[$7E:BFFE]  ;|
$80:84A5 9E 00 C0    STZ $C000,x[$7E:DFFE]  ;|
$80:84A8 9E 00 E0    STZ $E000,x[$7E:FFFE]  ;|
$80:84AB CA          DEX                    ;|
$80:84AC CA          DEX                    ;|
$80:84AD 10 E4       BPL $E4    [$8493]     ;|
$80:84AF 4B          PHK                    ;|
$80:84B0 AB          PLB                    ;/
$80:84B1 E2 30       SEP #$30
$80:84B3 9C 00 42    STZ $4200  [$7E:4200]  ;\
$80:84B6 64 84       STZ $84    [$7E:0084]  ;} Disable NMI and auto-joypad read
$80:84B8 A9 8F       LDA #$8F               ;\
$80:84BA 85 51       STA $51    [$7E:0051]  ;} Set forced blank
$80:84BC 20 5D 87    JSR $875D  [$80:875D]  ; Initialise CPU IO registers
$80:84BF 20 92 87    JSR $8792  [$80:8792]  ; Initialise PPU registers
$80:84C2 20 D1 88    JSR $88D1  [$80:88D1]  ; Write a load of 1C2Fh
$80:84C5 E2 20       SEP #$20
$80:84C7 9C 43 06    STZ $0643  [$7E:0643]  ;\
$80:84CA 9C 44 06    STZ $0644  [$7E:0644]  ;|
$80:84CD 9C 45 06    STZ $0645  [$7E:0645]  ;|
$80:84D0 9C 46 06    STZ $0646  [$7E:0646]  ;|
$80:84D3 9C 47 06    STZ $0647  [$7E:0647]  ;|
$80:84D6 9C 48 06    STZ $0648  [$7E:0648]  ;|
$80:84D9 9C 49 06    STZ $0649  [$7E:0649]  ;|
$80:84DC 9C 4A 06    STZ $064A  [$7E:064A]  ;|
$80:84DF 9C 4B 06    STZ $064B  [$7E:064B]  ;|
$80:84E2 9C 4D 06    STZ $064D  [$7E:064D]  ;} Clear sound queues
$80:84E5 9C 4E 06    STZ $064E  [$7E:064E]  ;|
$80:84E8 9C 4F 06    STZ $064F  [$7E:064F]  ;|
$80:84EB 9C 50 06    STZ $0650  [$7E:0650]  ;|
$80:84EE 9C 51 06    STZ $0651  [$7E:0651]  ;|
$80:84F1 9C 52 06    STZ $0652  [$7E:0652]  ;|
$80:84F4 9C 56 06    STZ $0656  [$7E:0656]  ;|
$80:84F7 9C 66 06    STZ $0666  [$7E:0666]  ;|
$80:84FA 9C 76 06    STZ $0676  [$7E:0676]  ;/
$80:84FD C2 20       REP #$20
$80:84FF 9C 90 05    STZ $0590  [$7E:0590]  ; OAM stack pointer = 0
$80:8502 64 53       STZ $53    [$7E:0053]  ; OAM address = 0
$80:8504 22 1A 8B 80 JSL $808B1A[$80:8B1A]  ; Clear high OAM
$80:8508 22 6E 89 80 JSL $80896E[$80:896E]  ; Finalise OAM
$80:850C 9C 1D 07    STZ $071D  [$7E:071D]  ; Clear Samus tiles transfer flags
$80:850F 9C 1F 07    STZ $071F  [$7E:071F]  ; Samus top half tiles definition = 0
$80:8512 9C 21 07    STZ $0721  [$7E:0721]  ; Samus bottom half tiles definition = 0
$80:8515 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$80:8519 C2 30       REP #$30
$80:851B 9C 40 21    STZ $2140  [$7E:2140]  ;\
$80:851E 9C 42 21    STZ $2142  [$7E:2142]  ;} Clear APU IO registers (harmless 16-bit write bug)
$80:8521 E2 30       SEP #$30
$80:8523 A2 04       LDX #$04               ;\
                                            ;|
$80:8525 AD 12 42    LDA $4212  [$7E:4212]  ;|
$80:8528 10 FB       BPL $FB    [$8525]     ;|
                                            ;} Wait the remainder of this frame and 3 more frames (???)
$80:852A AD 12 42    LDA $4212  [$7E:4212]  ;|
$80:852D 30 FB       BMI $FB    [$852A]     ;|
$80:852F CA          DEX                    ;|
$80:8530 D0 F3       BNE $F3    [$8525]     ;/
$80:8532 C2 30       REP #$30
$80:8534 A9 61 00    LDA #$0061             ;\
$80:8537 8D E5 05    STA $05E5  [$7E:05E5]  ;} Seed random number with 61h
$80:853A A9 00 00    LDA #$0000             ;\
$80:853D 8D 3F 06    STA $063F  [$7E:063F]  ;|
$80:8540 8D 29 06    STA $0629  [$7E:0629]  ;|
$80:8543 8D 2B 06    STA $062B  [$7E:062B]  ;|
$80:8546 8D 2D 06    STA $062D  [$7E:062D]  ;|
$80:8549 8D 2F 06    STA $062F  [$7E:062F]  ;} Clear music queue
$80:854C 8D 31 06    STA $0631  [$7E:0631]  ;|
$80:854F 8D 33 06    STA $0633  [$7E:0633]  ;|
$80:8552 8D 35 06    STA $0635  [$7E:0635]  ;|
$80:8555 8D 37 06    STA $0637  [$7E:0637]  ;/
$80:8558 AF 04 80 80 LDA $808004[$80:8004]  ;\
$80:855C 8D D1 05    STA $05D1  [$7E:05D1]  ;} Mirror debug byte to RAM
$80:855F 20 F6 85    JSR $85F6  [$80:85F6]  ; NTSC/PAL and SRAM mapping check
$80:8562 C2 30       REP #$30
$80:8564 22 61 82 80 JSL $808261[$80:8261]  ; Check for non-corrupt SRAM
$80:8568 9C F5 05    STZ $05F5  [$7E:05F5]  ; Enable sounds
$80:856B 9C 86 06    STZ $0686  [$7E:0686]  ; Sound handler downtime = 0
$80:856E 5C 3D 89 82 JML $82893D[$82:893D]  ; Go to main game loop
}


;;; $8572: Unused. BRK ;;;
{
$80:8572 00          BRK
}


;;; $8573: Infinite loop; pointed to by misc. error handling ;;;
{
; Called by:
;     $90:E9CE: Handle periodic damage to Samus
;     $91:DF51: Deal [A] damage to Samus
;     $93:8000: Initialise projectile
;     $93:8071 (super missiles)
;     $93:80A0: Initialise (power) bomb
;     $93:8163: Initialise shinespark echo
;     $93:81A4: Initialise SBA projectile
$80:8573 5C 73 85 80 JML $808573[$80:8573]
}


;;; $8577: Unused. Wait [A] frames ;;;
{
$80:8577 08          PHP
$80:8578 8B          PHB
$80:8579 4B          PHK
$80:857A AB          PLB
$80:857B E2 20       SEP #$20
$80:857D 8D 1C 07    STA $071C  [$82:071C]

$80:8580 22 38 83 80 JSL $808338[$80:8338]
$80:8584 CE 1C 07    DEC $071C  [$82:071C]
$80:8587 D0 F7       BNE $F7    [$8580]
$80:8589 AB          PLB
$80:858A 28          PLP
$80:858B 6B          RTL
}


;;; $858C: Load mirror of current area's map explored ;;;
{
$80:858C 08          PHP
$80:858D C2 30       REP #$30
$80:858F AD 9F 07    LDA $079F  [$7E:079F]
$80:8592 EB          XBA
$80:8593 AA          TAX
$80:8594 A0 00 00    LDY #$0000

$80:8597 BF 52 CD 7E LDA $7ECD52,x[$7E:CD52]
$80:859B 99 F7 07    STA $07F7,y[$7E:07F7]
$80:859E E8          INX
$80:859F E8          INX
$80:85A0 C8          INY
$80:85A1 C8          INY
$80:85A2 C0 00 01    CPY #$0100
$80:85A5 30 F0       BMI $F0    [$8597]
$80:85A7 AE 9F 07    LDX $079F  [$7E:079F]
$80:85AA BF 08 D9 7E LDA $7ED908,x[$7E:D908]
$80:85AE 29 FF 00    AND #$00FF
$80:85B1 8D 89 07    STA $0789  [$7E:0789]
$80:85B4 28          PLP
$80:85B5 6B          RTL
}


;;; $85B6: Unused. Generic bitmasks ;;;
{
$80:85B6             dw 0001, 0002, 0004, 0008, 0010, 0020, 0040, 0080
}


;;; $85C6: Mirror current area's map explored ;;;
{
; Called by:
;     $82:DF99: Save map explored if elevator
$80:85C6 08          PHP
$80:85C7 C2 30       REP #$30
$80:85C9 AD 9F 07    LDA $079F  [$7E:079F]
$80:85CC EB          XBA
$80:85CD AA          TAX
$80:85CE A0 00 00    LDY #$0000

$80:85D1 B9 F7 07    LDA $07F7,y[$7E:07F7]
$80:85D4 9F 52 CD 7E STA $7ECD52,x[$7E:CD52]
$80:85D8 E8          INX
$80:85D9 E8          INX
$80:85DA C8          INY
$80:85DB C8          INY
$80:85DC C0 00 01    CPY #$0100
$80:85DF 30 F0       BMI $F0    [$85D1]
$80:85E1 AD 89 07    LDA $0789  [$7E:0789]
$80:85E4 F0 0E       BEQ $0E    [$85F4]
$80:85E6 AE 9F 07    LDX $079F  [$7E:079F]
$80:85E9 BF 08 D9 7E LDA $7ED908,x[$7E:D908]
$80:85ED 09 FF 00    ORA #$00FF
$80:85F0 9F 08 D9 7E STA $7ED908,x[$7E:D908]

$80:85F4 28          PLP
$80:85F5 6B          RTL
}


;;; $85F6: NTSC/PAL and SRAM mapping check ;;;
{
; Checks that the SNES PPU's region matches up with the game header's region
; and that the SRAM regions $70:0000..1FFF and $70:2000..3FFF are mirrors
$80:85F6 08          PHP
$80:85F7 E2 30       SEP #$30
$80:85F9 AF 00 80 80 LDA $808000[$80:8000]  ;\
$80:85FD F0 03       BEQ $03    [$8602]     ;} If [$80:8000] != 0:
$80:85FF 4C E1 86    JMP $86E1  [$80:86E1]  ; Return

$80:8602 AF D9 FF 00 LDA $00FFD9[$00:FFD9]  ;\
$80:8606 C9 00       CMP #$00               ;} If country code != Japan:
$80:8608 F0 0A       BEQ $0A    [$8614]     ;/
$80:860A AD 3F 21    LDA $213F  [$7E:213F]  ;\
$80:860D 89 10       BIT #$10               ;} If PPU set to PAL:
$80:860F F0 0A       BEQ $0A    [$861B]     ;/
$80:8611 4C 93 86    JMP $8693  [$80:8693]  ; Go to BRANCH_SRAM_CHECK

$80:8614 AD 3F 21    LDA $213F  [$7E:213F]  ;\ Else (country code = Japan):
$80:8617 89 10       BIT #$10               ;} If PPU set to NTSC: go to BRANCH_SRAM_CHECK
$80:8619 F0 78       BEQ $78    [$8693]     ;/

; Failed region check
$80:861B A9 8F       LDA #$8F               ;\
$80:861D 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank
$80:8620 9C 00 42    STZ $4200  [$7E:4200]  ; Disable all interrupts
$80:8623 A9 00       LDA #$00               ;\
$80:8625 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:8628 A9 00       LDA #$00               ;|
$80:862A 8D 17 21    STA $2117  [$7E:2117]  ;|
$80:862D A9 80       LDA #$80               ;|
$80:862F 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $0000..1FFF = [$8E:8000..BFFF] (BG1 tiles)
$80:8632 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$80:8636             dx 01,01,18,8E8000,4000;|
$80:863E A9 02       LDA #$02               ;|
$80:8640 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8643 A9 00       LDA #$00               ;\
$80:8645 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:8648 A9 40       LDA #$40               ;|
$80:864A 8D 17 21    STA $2117  [$7E:2117]  ;|
$80:864D A9 80       LDA #$80               ;|
$80:864F 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $4000..47FF = [$80:B437..C436] (BG1 tilemap)
$80:8652 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$80:8656             dx 01,01,18,80B437,1000;|
$80:865E A9 02       LDA #$02               ;|
$80:8660 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8663 9C 21 21    STZ $2121  [$7E:2121]  ;\
$80:8666 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$80:866A             dx 01,00,22,8EE400,0200;} CGRAM = [$8E:E400..E5FF] (menu palettes)
$80:8672 A9 02       LDA #$02               ;|
$80:8674 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8677 9C 31 21    STZ $2131  [$7E:2131]  ; Disable colour math
$80:867A 9C 2D 21    STZ $212D  [$7E:212D]  ; Disable subscreen
$80:867D A9 01       LDA #$01               ;\
$80:867F 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG1
$80:8682 A9 0F       LDA #$0F               ;\
$80:8684 8D 00 21    STA $2100  [$7E:2100]  ;} Disable forced blank
$80:8687 A9 00       LDA #$00               ;\
$80:8689 8D 0B 21    STA $210B  [$7E:210B]  ;} BG1 tiles base address = $0000
$80:868C A9 40       LDA #$40               ;\
$80:868E 8D 07 21    STA $2107  [$7E:2107]  ;} BG1 tilemap base address = $4000

$80:8691 80 FE       BRA $FE    [$8691]     ; Crash

; BRANCH_SRAM_CHECK
$80:8693 C2 30       REP #$30
$80:8695 A2 FE 1F    LDX #$1FFE             ;\
                                            ;|
$80:8698 BF 00 00 70 LDA $700000,x[$70:1FFE];|
$80:869C 9F 00 00 7F STA $7F0000,x[$7F:1FFE];} $7F:0000..1FFF = [$70:0000..1FFF]
$80:86A0 CA          DEX                    ;|
$80:86A1 CA          DEX                    ;|
$80:86A2 10 F4       BPL $F4    [$8698]     ;/
$80:86A4 A9 00 00    LDA #$0000             ;\
$80:86A7 A2 FE 1F    LDX #$1FFE             ;|
                                            ;|
$80:86AA 9F 00 00 70 STA $700000,x[$70:1FFE];} Clear $70:0000..1FFF
$80:86AE CA          DEX                    ;|
$80:86AF CA          DEX                    ;|
$80:86B0 10 F8       BPL $F8    [$86AA]     ;/
$80:86B2 A9 00 00    LDA #$0000             ;\
$80:86B5 A2 FE 1F    LDX #$1FFE             ;|
                                            ;|
$80:86B8 9F 00 20 70 STA $702000,x[$70:3FFE];|
$80:86BC 1A          INC A                  ;} $70:2000..3FFF = 0..FFFh
$80:86BD CA          DEX                    ;|
$80:86BE CA          DEX                    ;|
$80:86BF 10 F7       BPL $F7    [$86B8]     ;/
$80:86C1 A9 00 00    LDA #$0000             ;\
$80:86C4 A2 FE 1F    LDX #$1FFE             ;|
                                            ;|
$80:86C7 DF 00 00 70 CMP $700000,x[$70:1FFE];|
$80:86CB D0 16       BNE $16    [$86E3]     ;} If [$70:0000..1FFF] != 0..FFFh: go to BRANCH_FAILED_SRAM_CHECK
$80:86CD 1A          INC A                  ;|
$80:86CE CA          DEX                    ;|
$80:86CF CA          DEX                    ;|
$80:86D0 10 F5       BPL $F5    [$86C7]     ;/
$80:86D2 A2 FE 1F    LDX #$1FFE             ;\
                                            ;|
$80:86D5 BF 00 00 7F LDA $7F0000,x[$7F:1FFE];|
$80:86D9 9F 00 00 70 STA $700000,x[$70:1FFE];} $70:0000..1FFF = [$7F:0000..1FFF]
$80:86DD CA          DEX                    ;|
$80:86DE CA          DEX                    ;|
$80:86DF 10 F4       BPL $F4    [$86D5]     ;/

$80:86E1 28          PLP
$80:86E2 60          RTS                    ; Return

; BRANCH_FAILED_SRAM_CHECK
$80:86E3 E2 20       SEP #$20
$80:86E5 A9 8F       LDA #$8F               ;\
$80:86E7 8D 00 21    STA $2100  [$82:2100]  ;} Enable forced blank
$80:86EA 9C 00 42    STZ $4200  [$82:4200]  ; Disable all interrupts
$80:86ED A9 00       LDA #$00               ;\
$80:86EF 8D 16 21    STA $2116  [$82:2116]  ;|
$80:86F2 A9 00       LDA #$00               ;|
$80:86F4 8D 17 21    STA $2117  [$82:2117]  ;|
$80:86F7 A9 80       LDA #$80               ;|
$80:86F9 8D 15 21    STA $2115  [$82:2115]  ;} VRAM $0000..1FFF = [$8E:8000..BFFF] (BG1 tiles)
$80:86FC 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$80:8700             dx 01,01,18,8E8000,4000;|
$80:8708 A9 02       LDA #$02               ;|
$80:870A 8D 0B 42    STA $420B  [$82:420B]  ;/
$80:870D A9 00       LDA #$00               ;\
$80:870F 8D 16 21    STA $2116  [$82:2116]  ;|
$80:8712 A9 40       LDA #$40               ;|
$80:8714 8D 17 21    STA $2117  [$82:2117]  ;|
$80:8717 A9 80       LDA #$80               ;|
$80:8719 8D 15 21    STA $2115  [$82:2115]  ;} VRAM $4000..47FF = [$80:BC37..C436] (BG1 tilemap)
$80:871C 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$80:8720             dx 01,01,18,80BC37,1000;|
$80:8728 A9 02       LDA #$02               ;|
$80:872A 8D 0B 42    STA $420B              ;/
$80:872D 9C 21 21    STZ $2121              ;\
$80:8730 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$80:8734             dx 01,00,22,8EE400,0200;} CGRAM = [$8E:E400..E5FF] (menu palettes)
$80:873C A9 02       LDA #$02               ;|
$80:873E 8D 0B 42    STA $420B  [$82:420B]  ;/
$80:8741 9C 31 21    STZ $2131  [$82:2131]  ; Disable colour math
$80:8744 9C 2D 21    STZ $212D  [$82:212D]  ; Disable subscreen
$80:8747 A9 01       LDA #$01               ;\
$80:8749 8D 2C 21    STA $212C  [$82:212C]  ;} Main screen layers = BG1
$80:874C A9 0F       LDA #$0F               ;\
$80:874E 8D 00 21    STA $2100  [$82:2100]  ;} Disable forced blank
$80:8751 A9 00       LDA #$00               ;\
$80:8753 8D 0B 21    STA $210B  [$82:210B]  ;} BG1 tiles base address = $0000
$80:8756 A9 40       LDA #$40               ;\
$80:8758 8D 07 21    STA $2107  [$82:2107]  ;} BG1 tilemap base address = $4000

$80:875B 80 FE       BRA $FE    [$875B]     ; Crash
}


;;; $875D: Initialise CPU IO registers ;;;
{
$80:875D A9 01       LDA #$01               ;\
$80:875F 8D 00 42    STA $4200  [$7E:4200]  ;} Enable auto-joypad read
$80:8762 85 84       STA $84    [$7E:0084]  ;/
$80:8764 9C 01 42    STZ $4201  [$7E:4201]  ; Joypad programmable IO port = 0
$80:8767 9C 02 42    STZ $4202  [$7E:4202]  ;\
$80:876A 9C 03 42    STZ $4203  [$7E:4203]  ;} Multiplication operands = 0
$80:876D 9C 04 42    STZ $4204  [$7E:4204]  ;\
$80:8770 9C 05 42    STZ $4205  [$7E:4205]  ;} Division operands = 0 (causes harmless division by zero)
$80:8773 9C 06 42    STZ $4206  [$7E:4206]  ;/
$80:8776 9C 07 42    STZ $4207  [$7E:4207]  ;\
$80:8779 9C 08 42    STZ $4208  [$7E:4208]  ;} IRQ h-counter target = 0
$80:877C 9C 09 42    STZ $4209  [$7E:4209]  ;\
$80:877F 9C 0A 42    STZ $420A  [$7E:420A]  ;} IRQ v-counter target = 0
$80:8782 9C 0B 42    STZ $420B  [$7E:420B]  ; Disable all DMA channels
$80:8785 9C 0C 42    STZ $420C  [$7E:420C]  ;\
$80:8788 64 85       STZ $85    [$7E:0085]  ;} Disable all HDMA channels
$80:878A A9 01       LDA #$01               ;\
$80:878C 8D 0D 42    STA $420D  [$7E:420D]  ;} Enable FastROM
$80:878F 85 86       STA $86    [$7E:0086]  ;/
$80:8791 60          RTS
}


;;; $8792: Initialise PPU registers ;;;
{
$80:8792 A9 8F       LDA #$8F               ;\
$80:8794 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank
$80:8797 85 51       STA $51    [$7E:0051]  ;/
$80:8799 A9 03       LDA #$03               ;\
$80:879B 8D 01 21    STA $2101  [$7E:2101]  ;} Sprite tiles base address = $6000, sprite sizes = 8x8 / 16x16
$80:879E 85 52       STA $52    [$7E:0052]  ;/
$80:87A0 9C 02 21    STZ $2102  [$7E:2102]  ;\
$80:87A3 64 53       STZ $53    [$7E:0053]  ;|
$80:87A5 A9 80       LDA #$80               ;} OAM address = $0000, priority sprite index = 0
$80:87A7 8D 03 21    STA $2103  [$7E:2103]  ;|
$80:87AA 85 54       STA $54    [$7E:0054]  ;/
$80:87AC 9C 04 21    STZ $2104  [$7E:2104]  ;\
$80:87AF 9C 04 21    STZ $2104  [$7E:2104]  ;} OAM $0000 = 0
$80:87B2 A9 09       LDA #$09               ;\
$80:87B4 8D 05 21    STA $2105  [$7E:2105]  ;} BG mode = 1 with BG3 priority, BG tile sizes = 8x8
$80:87B7 85 55       STA $55    [$7E:0055]  ;/
$80:87B9 9C 06 21    STZ $2106  [$7E:2106]  ;\
$80:87BC 64 57       STZ $57    [$7E:0057]  ;} Disable mosaic
$80:87BE A9 40       LDA #$40               ;\
$80:87C0 8D 07 21    STA $2107  [$7E:2107]  ;} BG1 tilemap base address = $4000, size = 32x32
$80:87C3 85 58       STA $58    [$7E:0058]  ;/
$80:87C5 A9 44       LDA #$44               ;\
$80:87C7 8D 08 21    STA $2108  [$7E:2108]  ;} BG2 tilemap base address = $4400, size = 32x32
$80:87CA 85 59       STA $59    [$7E:0059]  ;/
$80:87CC A9 48       LDA #$48               ;\
$80:87CE 8D 09 21    STA $2109  [$7E:2109]  ;} BG3 tilemap base address = $4800, size = 32x32
$80:87D1 85 5A       STA $5A    [$7E:005A]  ;/
$80:87D3 A9 48       LDA #$48               ; >_<
$80:87D5 9C 0A 21    STZ $210A  [$7E:210A]  ;\
$80:87D8 64 5C       STZ $5C    [$7E:005C]  ;} BG4 tilemap base address = $0000, size = 32x32
$80:87DA A9 00       LDA #$00               ;\
$80:87DC 8D 0B 21    STA $210B  [$7E:210B]  ;|
$80:87DF 85 5D       STA $5D    [$7E:005D]  ;} BG1/2/4 tiles base address = $0000
$80:87E1 A9 05       LDA #$05               ;} BG3 tiles base address = $5000
$80:87E3 8D 0C 21    STA $210C  [$7E:210C]  ;|
$80:87E6 85 5E       STA $5E    [$7E:005E]  ;/
$80:87E8 9C 0D 21    STZ $210D  [$7E:210D]  ;\
$80:87EB 9C 0D 21    STZ $210D  [$7E:210D]  ;} BG1 X scroll = 0
$80:87EE 9C 0E 21    STZ $210E  [$7E:210E]  ;\
$80:87F1 9C 0E 21    STZ $210E  [$7E:210E]  ;} BG1 Y scroll = 0
$80:87F4 9C 0F 21    STZ $210F  [$7E:210F]  ;\
$80:87F7 9C 0F 21    STZ $210F  [$7E:210F]  ;} BG2 X scroll = 0
$80:87FA 9C 10 21    STZ $2110  [$7E:2110]  ;\
$80:87FD 9C 10 21    STZ $2110  [$7E:2110]  ;} BG2 Y scroll = 0
$80:8800 9C 11 21    STZ $2111  [$7E:2111]  ;\
$80:8803 9C 11 21    STZ $2111  [$7E:2111]  ;} BG3 X scroll = 0
$80:8806 9C 12 21    STZ $2112  [$7E:2112]  ;\
$80:8809 9C 12 21    STZ $2112  [$7E:2112]  ;} BG3 Y scroll = 0
$80:880C 9C 13 21    STZ $2113  [$7E:2113]  ;\
$80:880F 9C 13 21    STZ $2113  [$7E:2113]  ;} BG4 X scroll = 0
$80:8812 9C 14 21    STZ $2114  [$7E:2114]  ;\
$80:8815 9C 14 21    STZ $2114  [$7E:2114]  ;} BG4 Y scroll = 0
$80:8818 9C 15 21    STZ $2115  [$7E:2115]  ; VRAM address increment mode = 8-bit
$80:881B 9C 1A 21    STZ $211A  [$7E:211A]  ;\
$80:881E 64 5F       STZ $5F    [$7E:005F]  ;} Mode 7 settings = 0
$80:8820 9C 1B 21    STZ $211B  [$7E:211B]  ;\
$80:8823 9C 1C 21    STZ $211C  [$7E:211C]  ;|
$80:8826 9C 1D 21    STZ $211D  [$7E:211D]  ;} Mode 7 transformation matrix = {{0, 0}, {0, 0}}
$80:8829 9C 1E 21    STZ $211E  [$7E:211E]  ;/
$80:882C 9C 1F 21    STZ $211F  [$7E:211F]  ; Mode 7 transformation origin co-ordinate X = 0
$80:882F 9C 20 21    STZ $2120  [$7E:2120]  ; Mode 7 transformation origin co-ordinate Y = 0
$80:8832 A9 00       LDA #$00               ;\
$80:8834 8D 23 21    STA $2123  [$7E:2123]  ;|
$80:8837 85 60       STA $60    [$7E:0060]  ;|
$80:8839 A9 00       LDA #$00               ;|
$80:883B 8D 24 21    STA $2124  [$7E:2124]  ;} Disable all window masks
$80:883E 85 61       STA $61    [$7E:0061]  ;|
$80:8840 9C 25 21    STZ $2125  [$7E:2125]  ;|
$80:8843 64 62       STZ $62    [$7E:0062]  ;/
$80:8845 A9 00       LDA #$00               ;\
$80:8847 8D 26 21    STA $2126  [$7E:2126]  ;} Window 1 left position = 0
$80:884A 85 63       STA $63    [$7E:0063]  ;/
$80:884C A9 F8       LDA #$F8               ;\
$80:884E 8D 27 21    STA $2127  [$7E:2127]  ;} Window 1 right position = F8h
$80:8851 85 64       STA $64    [$7E:0064]  ;/
$80:8853 9C 28 21    STZ $2128  [$7E:2128]  ;\
$80:8856 64 65       STZ $65    [$7E:0065]  ;} Window 2 left position = 0
$80:8858 9C 29 21    STZ $2129  [$7E:2129]  ;\
$80:885B 64 66       STZ $66    [$7E:0066]  ;} Window 2 right position = 0
$80:885D 9C 2A 21    STZ $212A  [$7E:212A]  ;\
$80:8860 64 67       STZ $67    [$7E:0067]  ;|
$80:8862 9C 2B 21    STZ $212B  [$7E:212B]  ;} Window 1/2 mask logic = OR
$80:8865 64 68       STZ $68    [$7E:0068]  ;/
$80:8867 A9 11       LDA #$11               ;\
$80:8869 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG1/sprites
$80:886C 85 69       STA $69    [$7E:0069]  ;/
$80:886E 8D 2E 21    STA $212E  [$7E:212E]  ;\
$80:8871 85 6C       STA $6C    [$7E:006C]  ;} Disable BG1/sprites in window area main screen
$80:8873 A9 02       LDA #$02               ;\
$80:8875 8D 2D 21    STA $212D  [$7E:212D]  ;} Subscreen layers = BG2
$80:8878 85 6B       STA $6B    [$7E:006B]  ;/
$80:887A 8D 2F 21    STA $212F  [$7E:212F]  ;\
$80:887D 85 6D       STA $6D    [$7E:006D]  ;} Disable BG2 in window area subscreen
$80:887F A9 02       LDA #$02               ;\
$80:8881 8D 30 21    STA $2130  [$7E:2130]  ;} Enable colour math subscreen layers
$80:8884 85 6E       STA $6E    [$7E:006E]  ;/
$80:8886 A9 A1       LDA #$A1               ;\
$80:8888 8D 31 21    STA $2131  [$7E:2131]  ;} Enable subtractive colour math on BG1/backdrop
$80:888B 85 71       STA $71    [$7E:0071]  ;/
$80:888D A9 E0       LDA #$E0               ;\
$80:888F 8D 32 21    STA $2132  [$7E:2132]  ;|
$80:8892 A9 E0       LDA #$E0               ;} >_<;
$80:8894 8D 32 21    STA $2132  [$7E:2132]  ;/
$80:8897 A9 80       LDA #$80               ;\
$80:8899 8D 32 21    STA $2132  [$7E:2132]  ;|
$80:889C 85 74       STA $74    [$7E:0074]  ;|
$80:889E A9 40       LDA #$40               ;|
$80:88A0 8D 32 21    STA $2132  [$7E:2132]  ;} Colour math subscreen backdrop colour = (0, 0, 0)
$80:88A3 85 75       STA $75    [$7E:0075]  ;|
$80:88A5 A9 20       LDA #$20               ;|
$80:88A7 8D 32 21    STA $2132  [$7E:2132]  ;|
$80:88AA 85 76       STA $76    [$7E:0076]  ;/
$80:88AC A9 00       LDA #$00               ;\
$80:88AE 8D 33 21    STA $2133  [$7E:2133]  ;} Use standard NTSC resolution
$80:88B1 85 77       STA $77    [$7E:0077]  ;/
$80:88B3 60          RTS
}


;;; $88B4: Unused. Clear high RAM ;;;
{
$80:88B4 C2 30       REP #$30
$80:88B6 A9 00 00    LDA #$0000             ;\
$80:88B9 A2 00 20    LDX #$2000             ;|
$80:88BC A0 00 E0    LDY #$E000             ;} Clear $7E:2000..FFFF
$80:88BF 22 F6 83 80 JSL $8083F6[$80:83F6]  ;/
$80:88C3 A9 00 00    LDA #$0000             ;\
$80:88C6 AA          TAX                    ;|
$80:88C7 A0 FE DF    LDY #$DFFE             ;} Clear $7F:0000..DFFD
$80:88CA 22 09 84 80 JSL $808409[$80:8409]  ;/
$80:88CE E2 30       SEP #$30
$80:88D0 60          RTS
}


;;; $88D1: Write a load of 1C2Fh ;;;
{
; Called by:
;     $8482: Common boot section
$80:88D1 C2 30       REP #$30
$80:88D3 A9 2F 1C    LDA #$1C2F             ;\
$80:88D6 22 EB 88 80 JSL $8088EB[$80:88EB]  ;} $7E:3000..37FF = 1C2Fh
$80:88DA A9 2F 1C    LDA #$1C2F             ;\
$80:88DD 22 FE 88 80 JSL $8088FE[$80:88FE]  ;} $7E:4000..47FF = 1C2Fh
$80:88E1 A9 2F 1C    LDA #$1C2F             ;\
$80:88E4 22 11 89 80 JSL $808911[$80:8911]  ;} $7E:6000..67FF = 1C2Fh
$80:88E8 E2 30       SEP #$30
$80:88EA 60          RTS
}


;;; $88EB: Write 800h bytes of [A] to $7E:3000 ;;;
{
; Called by:
;     $88D1: Write a load of 1C2Fh
$80:88EB 08          PHP
$80:88EC 8B          PHB
$80:88ED 4B          PHK
$80:88EE AB          PLB
$80:88EF C2 30       REP #$30
$80:88F1 A2 00 30    LDX #$3000
$80:88F4 A0 00 08    LDY #$0800
$80:88F7 22 F6 83 80 JSL $8083F6[$80:83F6]
$80:88FB AB          PLB
$80:88FC 28          PLP
$80:88FD 6B          RTL
}


;;; $88FE: Write 800h bytes of [A] to $7E:4000 ;;;
{
; Called by:
;     $88D1: Write a load of 1C2Fh
$80:88FE 08          PHP
$80:88FF 8B          PHB
$80:8900 4B          PHK
$80:8901 AB          PLB
$80:8902 C2 30       REP #$30
$80:8904 A2 00 40    LDX #$4000
$80:8907 A0 00 08    LDY #$0800
$80:890A 22 F6 83 80 JSL $8083F6[$80:83F6]
$80:890E AB          PLB
$80:890F 28          PLP
$80:8910 6B          RTL
}


;;; $8911: Write 800h bytes of [A] to $7E:6000 ;;;
{
; Called by:
;     $88D1: Write a load of 1C2Fh
$80:8911 08          PHP
$80:8912 8B          PHB
$80:8913 4B          PHK
$80:8914 AB          PLB
$80:8915 C2 30       REP #$30
$80:8917 A2 00 60    LDX #$6000
$80:891A A0 00 08    LDY #$0800
$80:891D 22 F6 83 80 JSL $8083F6[$80:83F6]
$80:8921 AB          PLB
$80:8922 28          PLP
$80:8923 6B          RTL
}


;;; $8924: Handle fading out ;;;
{
; When the screen has finished fading out, [$51] = 80h.
; Easiest way to check is:
;     LDA $51 : BMI BRANCH_FINISHED ; If PSR.M = 1
;     LDA $50 : BMI BRANCH_FINISHED ; If PSR.M = 0
$80:8924 08          PHP
$80:8925 C2 20       REP #$20
$80:8927 AD 25 07    LDA $0725  [$7E:0725]  ;\
$80:892A 3A          DEC A                  ;} If [screen fade counter] != 0:
$80:892B 30 05       BMI $05    [$8932]     ;/
$80:892D 8D 25 07    STA $0725  [$7E:0725]  ; Decrement screen fade counter
$80:8930 80 19       BRA $19    [$894B]     ; Return

$80:8932 AD 23 07    LDA $0723  [$7E:0723]  ;\
$80:8935 8D 25 07    STA $0725  [$7E:0725]  ;} Screen fade counter = [screen fade delay]
$80:8938 E2 30       SEP #$30
$80:893A A5 51       LDA $51    [$7E:0051]  ;\
$80:893C 29 0F       AND #$0F               ;} If (brightness) = 0: return
$80:893E F0 0B       BEQ $0B    [$894B]     ;/
$80:8940 3A          DEC A                  ;\
$80:8941 D0 06       BNE $06    [$8949]     ;} If (brightness) = 1:
$80:8943 A9 80       LDA #$80               ;\
$80:8945 85 51       STA $51    [$7E:0051]  ;} Enable forced blank, brightness = 0
$80:8947 80 02       BRA $02    [$894B]     ; Return

$80:8949 85 51       STA $51    [$7E:0051]  ; Decrement brightness (disable forced blank)

$80:894B 28          PLP
$80:894C 6B          RTL
}


;;; $894D: Handle fading in ;;;
{
; When the screen has finished fading in, [$51] = Fh.
; Easiest way to check is:
;     LDA $51 : CMP #$0F : BEQ BRANCH_FINISHED         ; If PSR.M = 1
;     LDA $50 : ASL : CMP #$1E00 : BCS BRANCH_FINISHED ; If PSR.M = 0
;     LDA $50 : CMP #$0F00 : BCS BRANCH_FINISHED       ; If PSR.M = 0 and forced blank is known to be disabled (force blank is enabled by fade out)
$80:894D 08          PHP
$80:894E C2 20       REP #$20
$80:8950 AD 25 07    LDA $0725  [$7E:0725]  ;\
$80:8953 3A          DEC A                  ;} If [screen fade counter] != 0:
$80:8954 30 05       BMI $05    [$895B]     ;/
$80:8956 8D 25 07    STA $0725  [$7E:0725]  ; Decrement screen fade counter
$80:8959 80 11       BRA $11    [$896C]     ; Return

$80:895B AD 23 07    LDA $0723  [$7E:0723]  ;\
$80:895E 8D 25 07    STA $0725  [$7E:0725]  ;} Screen fade counter = [screen fade delay]
$80:8961 E2 30       SEP #$30
$80:8963 A5 51       LDA $51    [$7E:0051]  ;\
$80:8965 1A          INC A                  ;|
$80:8966 29 0F       AND #$0F               ;} If brightness is not max:
$80:8968 F0 02       BEQ $02    [$896C]     ;/
$80:896A 85 51       STA $51    [$7E:0051]  ; Increment brightness (disable forced blank)

$80:896C 28          PLP
$80:896D 6B          RTL
}


;;; $896E: Finalise OAM ;;;
{
; Move unused sprites to Y = F0h and reset OAM stack pointer
; Uses one hell of an unrolled loop
$80:896E 08          PHP
$80:896F C2 30       REP #$30
$80:8971 AD 90 05    LDA $0590  [$7E:0590]  ;\
$80:8974 C9 00 02    CMP #$0200             ;} If [OAM stack pointer] < 200h:
$80:8977 10 14       BPL $14    [$898D]     ;/
$80:8979 4A          LSR A                  ;\
$80:897A 85 12       STA $12    [$7E:0012]  ;|
$80:897C 4A          LSR A                  ;|
$80:897D 65 12       ADC $12    [$7E:0012]  ;} $12 = $8992 + [OAM stack pointer] / 4 * 3
$80:897F 18          CLC                    ;|
$80:8980 69 92 89    ADC #$8992             ;|
$80:8983 85 12       STA $12    [$7E:0012]  ;/
$80:8985 A9 F0 00    LDA #$00F0             ; A = F0h (sprite Y position)
$80:8988 E2 30       SEP #$30
$80:898A 6C 12 00    JMP ($0012)[$80:8992]  ; Go to [$12]

$80:898D 9C 90 05    STZ $0590  [$7E:0590]  ; Clear OAM stack pointer = 0
$80:8990 28          PLP
$80:8991 6B          RTL                    ; Return

$80:8992 8D 71 03    STA $0371  [$7E:0371]  ; Sprite 0 Y position = F0h
$80:8995 8D 75 03    STA $0375  [$7E:0375]  ; Sprite 1 Y position = F0h
$80:8998 8D 79 03    STA $0379  [$7E:0379]  ; Sprite 2 Y position = F0h
$80:899B 8D 7D 03    STA $037D  [$7E:037D]  ; Sprite 3 Y position = F0h
$80:899E 8D 81 03    STA $0381  [$7E:0381]  ; Sprite 4 Y position = F0h
$80:89A1 8D 85 03    STA $0385  [$7E:0385]  ; Sprite 5 Y position = F0h
$80:89A4 8D 89 03    STA $0389  [$7E:0389]  ; Sprite 6 Y position = F0h
$80:89A7 8D 8D 03    STA $038D  [$7E:038D]  ; Sprite 7 Y position = F0h
$80:89AA 8D 91 03    STA $0391  [$7E:0391]  ; Sprite 8 Y position = F0h
$80:89AD 8D 95 03    STA $0395  [$7E:0395]  ; Sprite 9 Y position = F0h
$80:89B0 8D 99 03    STA $0399  [$7E:0399]  ; Sprite Ah Y position = F0h
$80:89B3 8D 9D 03    STA $039D  [$7E:039D]  ; Sprite Bh Y position = F0h
$80:89B6 8D A1 03    STA $03A1  [$7E:03A1]  ; Sprite Ch Y position = F0h
$80:89B9 8D A5 03    STA $03A5  [$7E:03A5]  ; Sprite Dh Y position = F0h
$80:89BC 8D A9 03    STA $03A9  [$7E:03A9]  ; Sprite Eh Y position = F0h
$80:89BF 8D AD 03    STA $03AD  [$7E:03AD]  ; Sprite Fh Y position = F0h
$80:89C2 8D B1 03    STA $03B1  [$7E:03B1]  ; Sprite 10h Y position = F0h
$80:89C5 8D B5 03    STA $03B5  [$7E:03B5]  ; Sprite 11h Y position = F0h
$80:89C8 8D B9 03    STA $03B9  [$7E:03B9]  ; Sprite 12h Y position = F0h
$80:89CB 8D BD 03    STA $03BD  [$7E:03BD]  ; Sprite 13h Y position = F0h
$80:89CE 8D C1 03    STA $03C1  [$7E:03C1]  ; Sprite 14h Y position = F0h
$80:89D1 8D C5 03    STA $03C5  [$7E:03C5]  ; Sprite 15h Y position = F0h
$80:89D4 8D C9 03    STA $03C9  [$7E:03C9]  ; Sprite 16h Y position = F0h
$80:89D7 8D CD 03    STA $03CD  [$7E:03CD]  ; Sprite 17h Y position = F0h
$80:89DA 8D D1 03    STA $03D1  [$7E:03D1]  ; Sprite 18h Y position = F0h
$80:89DD 8D D5 03    STA $03D5  [$7E:03D5]  ; Sprite 19h Y position = F0h
$80:89E0 8D D9 03    STA $03D9  [$7E:03D9]  ; Sprite 1Ah Y position = F0h
$80:89E3 8D DD 03    STA $03DD  [$7E:03DD]  ; Sprite 1Bh Y position = F0h
$80:89E6 8D E1 03    STA $03E1  [$7E:03E1]  ; Sprite 1Ch Y position = F0h
$80:89E9 8D E5 03    STA $03E5  [$7E:03E5]  ; Sprite 1Dh Y position = F0h
$80:89EC 8D E9 03    STA $03E9  [$7E:03E9]  ; Sprite 1Eh Y position = F0h
$80:89EF 8D ED 03    STA $03ED  [$7E:03ED]  ; Sprite 1Fh Y position = F0h
$80:89F2 8D F1 03    STA $03F1  [$7E:03F1]  ; Sprite 20h Y position = F0h
$80:89F5 8D F5 03    STA $03F5  [$7E:03F5]  ; Sprite 21h Y position = F0h
$80:89F8 8D F9 03    STA $03F9  [$7E:03F9]  ; Sprite 22h Y position = F0h
$80:89FB 8D FD 03    STA $03FD  [$7E:03FD]  ; Sprite 23h Y position = F0h
$80:89FE 8D 01 04    STA $0401  [$7E:0401]  ; Sprite 24h Y position = F0h
$80:8A01 8D 05 04    STA $0405  [$7E:0405]  ; Sprite 25h Y position = F0h
$80:8A04 8D 09 04    STA $0409  [$7E:0409]  ; Sprite 26h Y position = F0h
$80:8A07 8D 0D 04    STA $040D  [$7E:040D]  ; Sprite 27h Y position = F0h
$80:8A0A 8D 11 04    STA $0411  [$7E:0411]  ; Sprite 28h Y position = F0h
$80:8A0D 8D 15 04    STA $0415  [$7E:0415]  ; Sprite 29h Y position = F0h
$80:8A10 8D 19 04    STA $0419  [$7E:0419]  ; Sprite 2Ah Y position = F0h
$80:8A13 8D 1D 04    STA $041D  [$7E:041D]  ; Sprite 2Bh Y position = F0h
$80:8A16 8D 21 04    STA $0421  [$7E:0421]  ; Sprite 2Ch Y position = F0h
$80:8A19 8D 25 04    STA $0425  [$7E:0425]  ; Sprite 2Dh Y position = F0h
$80:8A1C 8D 29 04    STA $0429  [$7E:0429]  ; Sprite 2Eh Y position = F0h
$80:8A1F 8D 2D 04    STA $042D  [$7E:042D]  ; Sprite 2Fh Y position = F0h
$80:8A22 8D 31 04    STA $0431  [$7E:0431]  ; Sprite 30h Y position = F0h
$80:8A25 8D 35 04    STA $0435  [$7E:0435]  ; Sprite 31h Y position = F0h
$80:8A28 8D 39 04    STA $0439  [$7E:0439]  ; Sprite 32h Y position = F0h
$80:8A2B 8D 3D 04    STA $043D  [$7E:043D]  ; Sprite 33h Y position = F0h
$80:8A2E 8D 41 04    STA $0441  [$7E:0441]  ; Sprite 34h Y position = F0h
$80:8A31 8D 45 04    STA $0445  [$7E:0445]  ; Sprite 35h Y position = F0h
$80:8A34 8D 49 04    STA $0449  [$7E:0449]  ; Sprite 36h Y position = F0h
$80:8A37 8D 4D 04    STA $044D  [$7E:044D]  ; Sprite 37h Y position = F0h
$80:8A3A 8D 51 04    STA $0451  [$7E:0451]  ; Sprite 38h Y position = F0h
$80:8A3D 8D 55 04    STA $0455  [$7E:0455]  ; Sprite 39h Y position = F0h
$80:8A40 8D 59 04    STA $0459  [$7E:0459]  ; Sprite 3Ah Y position = F0h
$80:8A43 8D 5D 04    STA $045D  [$7E:045D]  ; Sprite 3Bh Y position = F0h
$80:8A46 8D 61 04    STA $0461  [$7E:0461]  ; Sprite 3Ch Y position = F0h
$80:8A49 8D 65 04    STA $0465  [$7E:0465]  ; Sprite 3Dh Y position = F0h
$80:8A4C 8D 69 04    STA $0469  [$7E:0469]  ; Sprite 3Eh Y position = F0h
$80:8A4F 8D 6D 04    STA $046D  [$7E:046D]  ; Sprite 3Fh Y position = F0h
$80:8A52 8D 71 04    STA $0471  [$7E:0471]  ; Sprite 40h Y position = F0h
$80:8A55 8D 75 04    STA $0475  [$7E:0475]  ; Sprite 41h Y position = F0h
$80:8A58 8D 79 04    STA $0479  [$7E:0479]  ; Sprite 42h Y position = F0h
$80:8A5B 8D 7D 04    STA $047D  [$7E:047D]  ; Sprite 43h Y position = F0h
$80:8A5E 8D 81 04    STA $0481  [$7E:0481]  ; Sprite 44h Y position = F0h
$80:8A61 8D 85 04    STA $0485  [$7E:0485]  ; Sprite 45h Y position = F0h
$80:8A64 8D 89 04    STA $0489  [$7E:0489]  ; Sprite 46h Y position = F0h
$80:8A67 8D 8D 04    STA $048D  [$7E:048D]  ; Sprite 47h Y position = F0h
$80:8A6A 8D 91 04    STA $0491  [$7E:0491]  ; Sprite 48h Y position = F0h
$80:8A6D 8D 95 04    STA $0495  [$7E:0495]  ; Sprite 49h Y position = F0h
$80:8A70 8D 99 04    STA $0499  [$7E:0499]  ; Sprite 4Ah Y position = F0h
$80:8A73 8D 9D 04    STA $049D  [$7E:049D]  ; Sprite 4Bh Y position = F0h
$80:8A76 8D A1 04    STA $04A1  [$7E:04A1]  ; Sprite 4Ch Y position = F0h
$80:8A79 8D A5 04    STA $04A5  [$7E:04A5]  ; Sprite 4Dh Y position = F0h
$80:8A7C 8D A9 04    STA $04A9  [$7E:04A9]  ; Sprite 4Eh Y position = F0h
$80:8A7F 8D AD 04    STA $04AD  [$7E:04AD]  ; Sprite 4Fh Y position = F0h
$80:8A82 8D B1 04    STA $04B1  [$7E:04B1]  ; Sprite 50h Y position = F0h
$80:8A85 8D B5 04    STA $04B5  [$7E:04B5]  ; Sprite 51h Y position = F0h
$80:8A88 8D B9 04    STA $04B9  [$7E:04B9]  ; Sprite 52h Y position = F0h
$80:8A8B 8D BD 04    STA $04BD  [$7E:04BD]  ; Sprite 53h Y position = F0h
$80:8A8E 8D C1 04    STA $04C1  [$7E:04C1]  ; Sprite 54h Y position = F0h
$80:8A91 8D C5 04    STA $04C5  [$7E:04C5]  ; Sprite 55h Y position = F0h
$80:8A94 8D C9 04    STA $04C9  [$7E:04C9]  ; Sprite 56h Y position = F0h
$80:8A97 8D CD 04    STA $04CD  [$7E:04CD]  ; Sprite 57h Y position = F0h
$80:8A9A 8D D1 04    STA $04D1  [$7E:04D1]  ; Sprite 58h Y position = F0h
$80:8A9D 8D D5 04    STA $04D5  [$7E:04D5]  ; Sprite 59h Y position = F0h
$80:8AA0 8D D9 04    STA $04D9  [$7E:04D9]  ; Sprite 5Ah Y position = F0h
$80:8AA3 8D DD 04    STA $04DD  [$7E:04DD]  ; Sprite 5Bh Y position = F0h
$80:8AA6 8D E1 04    STA $04E1  [$7E:04E1]  ; Sprite 5Ch Y position = F0h
$80:8AA9 8D E5 04    STA $04E5  [$7E:04E5]  ; Sprite 5Dh Y position = F0h
$80:8AAC 8D E9 04    STA $04E9  [$7E:04E9]  ; Sprite 5Eh Y position = F0h
$80:8AAF 8D ED 04    STA $04ED  [$7E:04ED]  ; Sprite 5Fh Y position = F0h
$80:8AB2 8D F1 04    STA $04F1  [$7E:04F1]  ; Sprite 60h Y position = F0h
$80:8AB5 8D F5 04    STA $04F5  [$7E:04F5]  ; Sprite 61h Y position = F0h
$80:8AB8 8D F9 04    STA $04F9  [$7E:04F9]  ; Sprite 62h Y position = F0h
$80:8ABB 8D FD 04    STA $04FD  [$7E:04FD]  ; Sprite 63h Y position = F0h
$80:8ABE 8D 01 05    STA $0501  [$7E:0501]  ; Sprite 64h Y position = F0h
$80:8AC1 8D 05 05    STA $0505  [$7E:0505]  ; Sprite 65h Y position = F0h
$80:8AC4 8D 09 05    STA $0509  [$7E:0509]  ; Sprite 66h Y position = F0h
$80:8AC7 8D 0D 05    STA $050D  [$7E:050D]  ; Sprite 67h Y position = F0h
$80:8ACA 8D 11 05    STA $0511  [$7E:0511]  ; Sprite 68h Y position = F0h
$80:8ACD 8D 15 05    STA $0515  [$7E:0515]  ; Sprite 69h Y position = F0h
$80:8AD0 8D 19 05    STA $0519  [$7E:0519]  ; Sprite 6Ah Y position = F0h
$80:8AD3 8D 1D 05    STA $051D  [$7E:051D]  ; Sprite 6Bh Y position = F0h
$80:8AD6 8D 21 05    STA $0521  [$7E:0521]  ; Sprite 6Ch Y position = F0h
$80:8AD9 8D 25 05    STA $0525  [$7E:0525]  ; Sprite 6Dh Y position = F0h
$80:8ADC 8D 29 05    STA $0529  [$7E:0529]  ; Sprite 6Eh Y position = F0h
$80:8ADF 8D 2D 05    STA $052D  [$7E:052D]  ; Sprite 6Fh Y position = F0h
$80:8AE2 8D 31 05    STA $0531  [$7E:0531]  ; Sprite 70h Y position = F0h
$80:8AE5 8D 35 05    STA $0535  [$7E:0535]  ; Sprite 71h Y position = F0h
$80:8AE8 8D 39 05    STA $0539  [$7E:0539]  ; Sprite 72h Y position = F0h
$80:8AEB 8D 3D 05    STA $053D  [$7E:053D]  ; Sprite 73h Y position = F0h
$80:8AEE 8D 41 05    STA $0541  [$7E:0541]  ; Sprite 74h Y position = F0h
$80:8AF1 8D 45 05    STA $0545  [$7E:0545]  ; Sprite 75h Y position = F0h
$80:8AF4 8D 49 05    STA $0549  [$7E:0549]  ; Sprite 76h Y position = F0h
$80:8AF7 8D 4D 05    STA $054D  [$7E:054D]  ; Sprite 77h Y position = F0h
$80:8AFA 8D 51 05    STA $0551  [$7E:0551]  ; Sprite 78h Y position = F0h
$80:8AFD 8D 55 05    STA $0555  [$7E:0555]  ; Sprite 79h Y position = F0h
$80:8B00 8D 59 05    STA $0559  [$7E:0559]  ; Sprite 7Ah Y position = F0h
$80:8B03 8D 5D 05    STA $055D  [$7E:055D]  ; Sprite 7Bh Y position = F0h
$80:8B06 8D 61 05    STA $0561  [$7E:0561]  ; Sprite 7Ch Y position = F0h
$80:8B09 8D 65 05    STA $0565  [$7E:0565]  ; Sprite 7Dh Y position = F0h
$80:8B0C 8D 69 05    STA $0569  [$7E:0569]  ; Sprite 7Eh Y position = F0h
$80:8B0F 8D 6D 05    STA $056D  [$7E:056D]  ; Sprite 7Fh Y position = F0h
$80:8B12 9C 90 05    STZ $0590  [$7E:0590]  ;\
$80:8B15 9C 91 05    STZ $0591  [$7E:0591]  ;} OAM stack pointer = 0
$80:8B18 28          PLP
$80:8B19 6B          RTL
}


;;; $8B1A: Clear high OAM ;;;
{
$80:8B1A 08          PHP
$80:8B1B C2 30       REP #$30
$80:8B1D 9C 70 05    STZ $0570  [$7E:0570]
$80:8B20 9C 72 05    STZ $0572  [$7E:0572]
$80:8B23 9C 74 05    STZ $0574  [$7E:0574]
$80:8B26 9C 76 05    STZ $0576  [$7E:0576]
$80:8B29 9C 78 05    STZ $0578  [$7E:0578]
$80:8B2C 9C 7A 05    STZ $057A  [$7E:057A]
$80:8B2F 9C 7C 05    STZ $057C  [$7E:057C]
$80:8B32 9C 7E 05    STZ $057E  [$7E:057E]
$80:8B35 9C 80 05    STZ $0580  [$7E:0580]
$80:8B38 9C 82 05    STZ $0582  [$7E:0582]
$80:8B3B 9C 84 05    STZ $0584  [$7E:0584]
$80:8B3E 9C 86 05    STZ $0586  [$7E:0586]
$80:8B41 9C 88 05    STZ $0588  [$7E:0588]
$80:8B44 9C 8A 05    STZ $058A  [$7E:058A]
$80:8B47 9C 8C 05    STZ $058C  [$7E:058C]
$80:8B4A 9C 8E 05    STZ $058E  [$7E:058E]
$80:8B4D 28          PLP
$80:8B4E 6B          RTL
}


;;; $8B4F: Queue mode 7 transfers ;;;
{
;; Parameter:
;;     DB:X: Pointer to mode 7 transfers data (see $8BD3)

; Called by:
;     $8B:9537: Process mode 7 object instruction list (used only by baby metroid in title sequence)
;     $8B:BDF9 with DB:X = $8B:BE74 (back of gunship going to Ceres)
;     $8B:C345 with DB:X = $8B:C3E6 (front of gunship leaving Ceres) / $8B:C3F0/C3FA (clear Ceres tilemap)
;     $A6:ACBC (Ceres Ridley)
;     $A6:AD27 (Ceres Ridley)
;     $A6:F8F1: Animate Ceres elevator platform

; CGRAM transfers are supported, but no mode 7 transfers data actually define any CGRAM transfers, so $8B62..8B8A is dead code

; From the RAM map:
; $02D0..032F: Mode 7 transfers. 7 or 9 byte entries. 1 byte zero-terminator
; {
;     + 0: Control
;         DMA control = [control] & 1Fh (transfer unit selection and address increment direction)
;         DMA target = [control] & C0h:
;             40h: CGRAM data write
;             80h: VRAM data write low (tilemap)
;             C0h: VRAM data write high (tiles)
;     + 1: Source address
;     + 4: Size
;     + 6: Destination address (1 byte for CGRAM transfers, 2 bytes for VRAM transfers)
;     + 8: VRAM address increment mode (for VRAM transfers only)
; }

$80:8B4F DA          PHX
$80:8B50 5A          PHY
$80:8B51 AC 34 03    LDY $0334  [$7E:0334]  ; Y = [mode 7 transfers stack pointer]
$80:8B54 CA          DEX

; LOOP
$80:8B55 3C 00 00    BIT $0000,x[$8B:A336]  ;\
$80:8B58 30 31       BMI $31    [$8B8B]     ;} If [[X]] & 80h != 0: go to BRANCH_VRAM
$80:8B5A 70 06       BVS $06    [$8B62]     ; If [[X]] & 40h != 0: go to BRANCH_CGRAM
$80:8B5C 8C 34 03    STY $0334  [$7E:0334]  ; Mode 7 transfers stack pointer = [Y]
$80:8B5F 7A          PLY
$80:8B60 FA          PLX
$80:8B61 6B          RTL                    ; Return

; BRANCH_CGRAM
$80:8B62 BD 01 00    LDA $0001,x            ;\
$80:8B65 99 D0 02    STA $02D0,y            ;|
$80:8B68 BD 03 00    LDA $0003,x            ;|
$80:8B6B 99 D2 02    STA $02D2,y            ;|
$80:8B6E BD 05 00    LDA $0005,x            ;} Copy 7 bytes from [X] to $02D0 + [Y]
$80:8B71 99 D4 02    STA $02D4,y            ;|
$80:8B74 BD 07 00    LDA $0007,x            ;|
$80:8B77 29 FF 00    AND #$00FF             ;|
$80:8B7A 99 D6 02    STA $02D6,y            ;/
$80:8B7D 8A          TXA                    ;\
$80:8B7E 18          CLC                    ;|
$80:8B7F 69 07 00    ADC #$0007             ;} X += 7
$80:8B82 AA          TAX                    ;/
$80:8B83 98          TYA                    ;\
$80:8B84 18          CLC                    ;|
$80:8B85 69 07 00    ADC #$0007             ;} Y += 7
$80:8B88 A8          TAY                    ;/
$80:8B89 80 CA       BRA $CA    [$8B55]     ; Go to LOOP

; BRANCH_VRAM
$80:8B8B BD 01 00    LDA $0001,x[$8B:A337]  ;\
$80:8B8E 99 D0 02    STA $02D0,y[$7E:02D0]  ;|
$80:8B91 BD 03 00    LDA $0003,x[$8B:A339]  ;|
$80:8B94 99 D2 02    STA $02D2,y[$7E:02D2]  ;|
$80:8B97 BD 05 00    LDA $0005,x[$8B:A33B]  ;|
$80:8B9A 99 D4 02    STA $02D4,y[$7E:02D4]  ;} Copy 9 bytes from [X] to $02D0 + [Y]
$80:8B9D BD 07 00    LDA $0007,x[$8B:A33D]  ;|
$80:8BA0 99 D6 02    STA $02D6,y[$7E:02D6]  ;|
$80:8BA3 BD 09 00    LDA $0009,x[$8B:A33F]  ;|
$80:8BA6 29 FF 00    AND #$00FF             ;|
$80:8BA9 99 D8 02    STA $02D8,y[$7E:02D8]  ;/
$80:8BAC 8A          TXA                    ;\
$80:8BAD 18          CLC                    ;|
$80:8BAE 69 09 00    ADC #$0009             ;} X += 9
$80:8BB1 AA          TAX                    ;/
$80:8BB2 98          TYA                    ;\
$80:8BB3 18          CLC                    ;|
$80:8BB4 69 09 00    ADC #$0009             ;} Y += 9
$80:8BB7 A8          TAY                    ;/
$80:8BB8 80 9B       BRA $9B    [$8B55]     ; Go to LOOP
}


;;; $8BBA: Handle mode 7 transfers ;;;
{
$80:8BBA 08          PHP
$80:8BBB C2 10       REP #$10
$80:8BBD AE 34 03    LDX $0334  [$7E:0334]  ;\
$80:8BC0 F0 0F       BEQ $0F    [$8BD1]     ;} If [mode 7 transfers stack pointer] = 0: return
$80:8BC2 A2 D0 02    LDX #$02D0             ; X = mode 7 transfers
$80:8BC5 22 D3 8B 80 JSL $808BD3[$80:8BD3]  ; Process mode 7 transfers
$80:8BC9 C2 20       REP #$20
$80:8BCB 9C D0 02    STZ $02D0  [$7E:02D0]  ; Mode 7 transfers = 0
$80:8BCE 9C 34 03    STZ $0334  [$7E:0334]  ; Mode 7 transfers stack pointer = 0

$80:8BD1 28          PLP
$80:8BD2 6B          RTL
}


;;; $8BD3: Process mode 7 transfers ;;;
{
;; Parameter:
;;     X: Pointer to mode 7 transfers data

; CGRAM transfers are never queued, so $8BE0..8C10 is dead code
$80:8BD3 08          PHP

; LOOP
$80:8BD4 E2 20       SEP #$20
$80:8BD6 BD 00 00    LDA $0000,x[$7E:02D0]  ;\
$80:8BD9 30 36       BMI $36    [$8C11]     ;} If [[X]] & 80h: go to BRANCH_VRAM
$80:8BDB 0A          ASL A                  ;\
$80:8BDC 30 02       BMI $02    [$8BE0]     ;} If [[X]] & 40h: go to BRANCH_CGRAM
$80:8BDE 28          PLP
$80:8BDF 6B          RTL                    ; Return

; BRANCH_CGRAM
$80:8BE0 4A          LSR A                  ;\
$80:8BE1 29 1F       AND #$1F               ;} DMA 1 control = [[X]] & 1Fh
$80:8BE3 8D 10 43    STA $4310  [$7E:4310]  ;/
$80:8BE6 BC 01 00    LDY $0001,x            ;\
$80:8BE9 8C 12 43    STY $4312  [$7E:4312]  ;|
$80:8BEC BD 03 00    LDA $0003,x            ;} DMA 1 source = [[X] + 1]
$80:8BEF 8D 14 43    STA $4314  [$7E:4314]  ;/
$80:8BF2 BC 04 00    LDY $0004,x            ;\
$80:8BF5 8C 15 43    STY $4315  [$7E:4315]  ;} DMA 1 size = [[X] + 4]
$80:8BF8 A9 22       LDA #$22               ;\
$80:8BFA 8D 11 43    STA $4311  [$7E:4311]  ;} DMA 1 destination = CGRAM data write
$80:8BFD BD 06 00    LDA $0006,x            ;\
$80:8C00 8D 21 21    STA $2121  [$7E:2121]  ;} CGRAM address = [[X] + 6]
$80:8C03 A9 02       LDA #$02               ;\
$80:8C05 8D 0B 42    STA $420B  [$7E:420B]  ;} Execute DMA 1
$80:8C08 C2 21       REP #$21               ;\
$80:8C0A 8A          TXA                    ;|
$80:8C0B 69 07 00    ADC #$0007             ;} X += 7
$80:8C0E AA          TAX                    ;/
$80:8C0F 80 C3       BRA $C3    [$8BD4]     ; Go to LOOP

; BRANCH_VRAM
$80:8C11 0A          ASL A                  ;\
$80:8C12 30 37       BMI $37    [$8C4B]     ;} If [[X]] & 40h != 0: go to BRANCH_VRAM_TILES
; VRAM tilemap
$80:8C14 4A          LSR A                  ;\
$80:8C15 29 1F       AND #$1F               ;} DMA 1 control = [[X]] & 1Fh
$80:8C17 8D 10 43    STA $4310  [$7E:4310]  ;/
$80:8C1A BC 01 00    LDY $0001,x[$7E:02D1]  ;\
$80:8C1D 8C 12 43    STY $4312  [$7E:4312]  ;|
$80:8C20 BD 03 00    LDA $0003,x[$7E:02D3]  ;} DMA 1 source = [[X] + 1]
$80:8C23 8D 14 43    STA $4314  [$7E:4314]  ;/
$80:8C26 BC 04 00    LDY $0004,x[$7E:02D4]  ;\
$80:8C29 8C 15 43    STY $4315  [$7E:4315]  ;} DMA 1 size = [[X] + 4]
$80:8C2C A9 18       LDA #$18               ;\
$80:8C2E 8D 11 43    STA $4311  [$7E:4311]  ;} DMA 1 destination = VRAM data write low
$80:8C31 BC 06 00    LDY $0006,x[$7E:02D6]  ;\
$80:8C34 8C 16 21    STY $2116  [$7E:2116]  ;} VRAM address = [[X] + 6]
$80:8C37 BD 08 00    LDA $0008,x[$7E:02D8]  ;\
$80:8C3A 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM address increment mode = [[X] + 8]
$80:8C3D A9 02       LDA #$02               ;\
$80:8C3F 8D 0B 42    STA $420B  [$7E:420B]  ;} Execute DMA 1
$80:8C42 C2 21       REP #$21               ;\
$80:8C44 8A          TXA                    ;|
$80:8C45 69 09 00    ADC #$0009             ;} X += 9
$80:8C48 AA          TAX                    ;/
$80:8C49 80 89       BRA $89    [$8BD4]     ; Go to LOOP

; BRANCH_VRAM_TILES
$80:8C4B 4A          LSR A                  ;\ Else ([[X]] & 40h = 0):
$80:8C4C 29 1F       AND #$1F               ;} DMA 1 control = [[X]] & 1Fh
$80:8C4E 8D 10 43    STA $4310  [$7E:4310]  ;/
$80:8C51 BC 01 00    LDY $0001,x[$7E:02D1]  ;\
$80:8C54 8C 12 43    STY $4312  [$7E:4312]  ;|
$80:8C57 BD 03 00    LDA $0003,x[$7E:02D3]  ;} DMA 1 source = [[X] + 1]
$80:8C5A 8D 14 43    STA $4314  [$7E:4314]  ;/
$80:8C5D BC 04 00    LDY $0004,x[$7E:02D4]  ;\
$80:8C60 8C 15 43    STY $4315  [$7E:4315]  ;} DMA 1 size = [[X] + 4]
$80:8C63 A9 19       LDA #$19               ;\
$80:8C65 8D 11 43    STA $4311  [$7E:4311]  ;} DMA 1 destination = VRAM data write high
$80:8C68 BC 06 00    LDY $0006,x[$7E:02D6]  ;\
$80:8C6B 8C 16 21    STY $2116  [$7E:2116]  ;} VRAM address = [[X] + 6]
$80:8C6E BD 08 00    LDA $0008,x[$7E:02D8]  ;\
$80:8C71 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM address increment mode = [[X] + 8]
$80:8C74 A9 02       LDA #$02               ;\
$80:8C76 8D 0B 42    STA $420B  [$7E:420B]  ;} Execute DMA 1
$80:8C79 C2 21       REP #$21               ;\
$80:8C7B 8A          TXA                    ;|
$80:8C7C 69 09 00    ADC #$0009             ;} X += 9
$80:8C7F AA          TAX                    ;/
$80:8C80 4C D4 8B    JMP $8BD4  [$80:8BD4]  ; Go to LOOP
}


;;; $8C83: Handle VRAM write table and scrolling DMAs ;;;
{
$80:8C83 08          PHP
$80:8C84 C2 30       REP #$30
$80:8C86 AE 30 03    LDX $0330  [$7E:0330]  ;\
$80:8C89 F0 3E       BEQ $3E    [$8CC9]     ;} If [VRAM write table stack pointer] = 0: go to BRANCH_DONE
$80:8C8B 74 D0       STZ $D0,x  [$7E:00D7]  ; $D0 + [VRAM write table stack pointer] = 0 (table terminator)
$80:8C8D A9 01 18    LDA #$1801             ;\
$80:8C90 8D 10 43    STA $4310  [$7E:4310]  ;} DMA 1 control / target = 16-bit VRAM data write
$80:8C93 A0 00 00    LDY #$0000             ; Y = 0 (VRAM write table index)

; LOOP
$80:8C96 B9 D0 00    LDA $00D0,y[$7E:00D0]  ;\
$80:8C99 F0 2E       BEQ $2E    [$8CC9]     ;} If [VRAM write table entry size] = 0: go to BRANCH_DONE
$80:8C9B 8D 15 43    STA $4315  [$7E:4315]  ; DMA 1 size = [VRAM write table entry size]
$80:8C9E B9 D2 00    LDA $00D2,y[$7E:00D2]  ;\
$80:8CA1 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:8CA4 B9 D3 00    LDA $00D3,y[$7E:00D3]  ;} DMA 1 source address = [VRAM write table entry source address]
$80:8CA7 8D 13 43    STA $4313  [$7E:4313]  ;/
$80:8CAA A9 80 00    LDA #$0080             ; VRAM address increment mode = 1-byte increment for 16-bit transfers
$80:8CAD B6 D5       LDX $D5,y  [$7E:00D5]  ;\
$80:8CAF 10 01       BPL $01    [$8CB2]     ;} If [VRAM write table entry destination address] & 8000h:
$80:8CB1 1A          INC A                  ; Use 32-byte VRAM address increment

$80:8CB2 8D 15 21    STA $2115  [$7E:2115]
$80:8CB5 8E 16 21    STX $2116  [$7E:2116]  ; VRAM address = [VRAM write table entry destination address]
$80:8CB8 E2 20       SEP #$20
$80:8CBA A9 02       LDA #$02               ;\
$80:8CBC 8D 0B 42    STA $420B  [$7E:420B]  ;} Execute DMA 1
$80:8CBF C2 20       REP #$20
$80:8CC1 98          TYA                    ;\
$80:8CC2 18          CLC                    ;|
$80:8CC3 69 07 00    ADC #$0007             ;} Y += 7 (next VRAM write table entry)
$80:8CC6 A8          TAY                    ;/
$80:8CC7 80 CD       BRA $CD    [$8C96]     ; Go to LOOP

; BRANCH_DONE
$80:8CC9 9C 30 03    STZ $0330  [$7E:0330]  ; VRAM write table stack pointer = 0
$80:8CCC E2 20       SEP #$20
$80:8CCE C2 10       REP #$10
$80:8CD0 20 D8 8C    JSR $8CD8  [$80:8CD8]  ; Execute horizontal scrolling DMAs
$80:8CD3 20 AC 8D    JSR $8DAC  [$80:8DAC]  ; Execute vertical scrolling DMAs
$80:8CD6 28          PLP
$80:8CD7 6B          RTL
}


;;; $8CD8: Execute horizontal scrolling DMAs ;;;
{
$80:8CD8 A9 81       LDA #$81               ;\
$80:8CDA 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM address increment mode = 16-bit access, 20h-byte increment
$80:8CDD AD 62 09    LDA $0962  [$7E:0962]  ;\
$80:8CE0 F0 62       BEQ $62    [$8D44]     ;} If BG1 VRAM tilemap column update:
$80:8CE2 9C 62 09    STZ $0962  [$7E:0962]  ; Clear BG1 VRAM tilemap column update flag
$80:8CE5 AC 5A 09    LDY $095A  [$7E:095A]  ;\
$80:8CE8 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8CEB A2 01 18    LDX #$1801             ;|
$80:8CEE 8E 10 43    STX $4310  [$7E:4310]  ;|
$80:8CF1 A2 C8 C8    LDX #$C8C8             ;|
$80:8CF4 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8CF7 A9 7E       LDA #$7E               ;} DMA [$0956] bytes from $7E:C8C8 to VRAM [$095A] (BG1 column update unwrapped tilemap left halves)
$80:8CF9 8D 14 43    STA $4314  [$7E:4314]  ;|
$80:8CFC AE 56 09    LDX $0956  [$7E:0956]  ;|
$80:8CFF 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8D02 A9 02       LDA #$02               ;|
$80:8D04 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8D07 C8          INY                    ;\
$80:8D08 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8D0B 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8D0E A2 08 C9    LDX #$C908             ;} DMA [$0956] bytes from $7E:C908 to VRAM [$095A] + 1 (BG1 column update unwrapped tilemap right halves)
$80:8D11 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8D14 A9 02       LDA #$02               ;|
$80:8D16 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8D19 AE 5E 09    LDX $095E  [$7E:095E]  ;\
$80:8D1C 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8D1F AE 58 09    LDX $0958  [$7E:0958]  ; \
$80:8D22 F0 20       BEQ $20    [$8D44]     ; } If [$0958] != 0:
$80:8D24 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8D27 AC 5C 09    LDY $095C  [$7E:095C]  ;} DMA [$0958] bytes from $7E:[$095E] to VRAM [$095C] (BG1 column update wrapped tilemap left halves)
$80:8D2A 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8D2D A9 02       LDA #$02               ;|
$80:8D2F 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8D32 C8          INY                    ;\
$80:8D33 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8D36 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8D39 AE 60 09    LDX $0960  [$7E:0960]  ;} DMA [$0958] bytes from $7E:[$0960] to VRAM [$095C] + 1 (BG1 column update wrapped tilemap right halves)
$80:8D3C 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8D3F A9 02       LDA #$02               ;|
$80:8D41 8D 0B 42    STA $420B  [$7E:420B]  ;/

$80:8D44 AD 7E 09    LDA $097E  [$7E:097E]  ;\
$80:8D47 F0 62       BEQ $62    [$8DAB]     ;} If not BG2 VRAM tilemap column update: return
$80:8D49 9C 7E 09    STZ $097E  [$7E:097E]  ; Clear BG2 VRAM tilemap column update flag
$80:8D4C AC 76 09    LDY $0976  [$7E:0976]  ;\
$80:8D4F 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8D52 A2 01 18    LDX #$1801             ;|
$80:8D55 8E 10 43    STX $4310  [$7E:4310]  ;|
$80:8D58 A2 D0 C9    LDX #$C9D0             ;|
$80:8D5B 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8D5E A9 7E       LDA #$7E               ;} DMA [$0972] bytes from $7E:C9D0 to VRAM [$0976] (BG2 column update unwrapped tilemap left halves)
$80:8D60 8D 14 43    STA $4314  [$7E:4314]  ;|
$80:8D63 AE 72 09    LDX $0972  [$7E:0972]  ;|
$80:8D66 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8D69 A9 02       LDA #$02               ;|
$80:8D6B 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8D6E C8          INY                    ;\
$80:8D6F 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8D72 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8D75 A2 10 CA    LDX #$CA10             ;} DMA [$0972] bytes from $7E:CA10 to VRAM [$0976] + 1 (BG2 column update unwrapped tilemap right halves)
$80:8D78 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8D7B A9 02       LDA #$02               ;|
$80:8D7D 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8D80 AE 7A 09    LDX $097A  [$7E:097A]  ;\
$80:8D83 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8D86 AE 74 09    LDX $0974  [$7E:0974]  ; \
$80:8D89 F0 20       BEQ $20    [$8DAB]     ; } If [$0974] = 0: return
$80:8D8B 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8D8E AC 78 09    LDY $0978  [$7E:0978]  ;} DMA [$0974] bytes from $7E:[$097A] to VRAM [$0978] (BG2 column update wrapped tilemap left halves)
$80:8D91 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8D94 A9 02       LDA #$02               ;|
$80:8D96 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8D99 C8          INY                    ;\
$80:8D9A 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8D9D 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8DA0 AE 7C 09    LDX $097C  [$7E:097C]  ;} DMA [$0974] bytes from $7E:[$097C] to VRAM [$0978] + 1 (BG2 column update wrapped tilemap right halves)
$80:8DA3 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8DA6 A9 02       LDA #$02               ;|
$80:8DA8 8D 0B 42    STA $420B  [$7E:420B]  ;/

$80:8DAB 60          RTS
}


;;; $8DAC: Execute vertical scrolling DMAs ;;;
{
$80:8DAC A9 80       LDA #$80               ;\
$80:8DAE 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM address increment mode = 16-bit access
$80:8DB1 AD 70 09    LDA $0970  [$7E:0970]  ;\
$80:8DB4 F0 70       BEQ $70    [$8E26]     ;} If BG1 VRAM tilemap row update:
$80:8DB6 9C 70 09    STZ $0970  [$7E:0970]  ; Clear BG1 VRAM tilemap row update flag
$80:8DB9 AC 68 09    LDY $0968  [$7E:0968]  ;\
$80:8DBC 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8DBF A2 01 18    LDX #$1801             ;|
$80:8DC2 8E 10 43    STX $4310  [$7E:4310]  ;|
$80:8DC5 A2 48 C9    LDX #$C948             ;|
$80:8DC8 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8DCB A9 7E       LDA #$7E               ;} DMA [$0964] bytes from $7E:C948 vertical scroll top tilemap to [$0968] VRAM (BG1 row update unwrapped tilemap left halves)
$80:8DCD 8D 14 43    STA $4314  [$7E:4314]  ;|
$80:8DD0 AE 64 09    LDX $0964  [$7E:0964]  ;|
$80:8DD3 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8DD6 A9 02       LDA #$02               ;|
$80:8DD8 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8DDB C2 20       REP #$20               ;\
$80:8DDD 98          TYA                    ;|
$80:8DDE 09 20 00    ORA #$0020             ;|
$80:8DE1 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:8DE4 E2 20       SEP #$20               ;|
$80:8DE6 8E 15 43    STX $4315  [$7E:4315]  ;} DMA [$0964] bytes from $7E:C98C vertical scroll bottom tilemap to [$0968] | 20h VRAM (BG1 row update unwrapped tilemap right halves)
$80:8DE9 A2 8C C9    LDX #$C98C             ;|
$80:8DEC 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8DEF A9 02       LDA #$02               ;|
$80:8DF1 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8DF4 AE 6C 09    LDX $096C  [$7E:096C]  ;\
$80:8DF7 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8DFA AE 66 09    LDX $0966  [$7E:0966]  ; \
$80:8DFD F0 27       BEQ $27    [$8E26]     ; } If [$0966]:
$80:8DFF 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8E02 AC 6A 09    LDY $096A  [$7E:096A]  ;} DMA [$0966] bytes from $7E:[$096C] to [$096A] VRAM (BG1 row update wrapped tilemap left halves)
$80:8E05 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8E08 A9 02       LDA #$02               ;|
$80:8E0A 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8E0D C2 20       REP #$20               ;\
$80:8E0F 98          TYA                    ;|
$80:8E10 09 20 00    ORA #$0020             ;|
$80:8E13 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:8E16 E2 20       SEP #$20               ;|
$80:8E18 8E 15 43    STX $4315  [$7E:4315]  ;} DMA [$0966] bytes from $7E:[$096E] to [$096A] | 20h VRAM (BG1 row update wrapped tilemap right halves)
$80:8E1B AE 6E 09    LDX $096E  [$7E:096E]  ;|
$80:8E1E 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8E21 A9 02       LDA #$02               ;|
$80:8E23 8D 0B 42    STA $420B  [$7E:420B]  ;/

$80:8E26 AD 8C 09    LDA $098C  [$7E:098C]  ;\
$80:8E29 F0 76       BEQ $76    [$8EA1]     ;} If not BG2 VRAM tilemap row update: return
$80:8E2B 9C 8C 09    STZ $098C  [$7E:098C]  ; Clear BG2 VRAM tilemap row update flag
$80:8E2E AC 84 09    LDY $0984  [$7E:0984]  ;\
$80:8E31 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8E34 A2 01 18    LDX #$1801             ;|
$80:8E37 8E 10 43    STX $4310  [$7E:4310]  ;|
$80:8E3A A2 50 CA    LDX #$CA50             ;|
$80:8E3D 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8E40 A9 7E       LDA #$7E               ;} DMA [$0980] bytes from $7E:CA50 to [$0984] VRAM (BG2 row update unwrapped tilemap left halves)
$80:8E42 8D 14 43    STA $4314  [$7E:4314]  ;|
$80:8E45 AE 80 09    LDX $0980  [$7E:0980]  ;|
$80:8E48 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8E4B A9 02       LDA #$02               ;|
$80:8E4D 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8E50 C2 20       REP #$20               ;\
$80:8E52 98          TYA                    ;|
$80:8E53 09 20 00    ORA #$0020             ;|
$80:8E56 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:8E59 E2 20       SEP #$20               ;|
$80:8E5B 8E 15 43    STX $4315  [$7E:4315]  ;} DMA [$0980] bytes from $7E:CA94 to [$0984] | 20h VRAM (BG2 row update unwrapped tilemap right halves)
$80:8E5E A2 94 CA    LDX #$CA94             ;|
$80:8E61 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8E64 A9 02       LDA #$02               ;|
$80:8E66 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8E69 AE 88 09    LDX $0988  [$7E:0988]  ;\
$80:8E6C 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8E6F AE 82 09    LDX $0982  [$7E:0982]  ; \
$80:8E72 F0 2D       BEQ $2D    [$8EA1]     ; } If [$0982] = 0: return
$80:8E74 8E 15 43    STX $4315  [$7E:4315]  ;|
$80:8E77 AC 86 09    LDY $0986  [$7E:0986]  ;} DMA [$0982] bytes from $7E:[$0988] to [$0986] VRAM (BG2 row update wrapped tilemap left halves)
$80:8E7A 8C 16 21    STY $2116  [$7E:2116]  ;|
$80:8E7D A9 02       LDA #$02               ;|
$80:8E7F 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:8E82 E2 02       SEP #$02               ;\
$80:8E84 F0 02       BEQ $02    [$8E88]     ;} Strange unconditional jump o_O

$80:8E86 80 FE       BRA $FE    [$8E86]     ; Crash

$80:8E88 C2 20       REP #$20               ;\
$80:8E8A 98          TYA                    ;|
$80:8E8B 09 20 00    ORA #$0020             ;|
$80:8E8E 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:8E91 E2 20       SEP #$20               ;|
$80:8E93 8E 15 43    STX $4315  [$7E:4315]  ;} DMA [$0982] bytes from $7E:[$098A] to [$0986] | 20h VRAM (BG2 row update wrapped tilemap right halves)
$80:8E96 AE 8A 09    LDX $098A  [$7E:098A]  ;|
$80:8E99 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:8E9C A9 02       LDA #$02               ;|
$80:8E9E 8D 0B 42    STA $420B  [$7E:420B]  ;/

$80:8EA1 60          RTS
}


;;; $8EA2: Handle VRAM read table ;;;
{
; Buggy? This routine stores a 1-byte zero-terminator but checks for a 2-byte zero terminator as the loop condition.
; I think this only works because only one entry is ever set up in any given frame
$80:8EA2 08          PHP
$80:8EA3 E2 30       SEP #$30
$80:8EA5 AE 60 03    LDX $0360  [$7E:0360]  ;\
$80:8EA8 D0 02       BNE $02    [$8EAC]     ;} If [VRAM read table stack pointer] = 0:
$80:8EAA 28          PLP
$80:8EAB 6B          RTL                    ; Return

$80:8EAC 9E 40 03    STZ $0340,x[$7E:0349]  ; $0340 + [VRAM read table stack pointer] = 0 (table terminator)
$80:8EAF A2 00       LDX #$00               ; X = 0 (VRAM read table index)
$80:8EB1 A9 80       LDA #$80               ;\
$80:8EB3 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM address increment mode = 16-bit access

; LOOP
$80:8EB6 C2 20       REP #$20
$80:8EB8 BD 40 03    LDA $0340,x[$7E:0340]  ;\
$80:8EBB F0 32       BEQ $32    [$8EEF]     ;} If [VRAM write table entry source address] = 0: go to BRANCH_DONE
$80:8EBD 8D 16 21    STA $2116  [$7E:2116]  ; VRAM address = [VRAM read table entry source address]
$80:8EC0 AD 39 21    LDA $2139  [$7E:2139]  ; Dummy VRAM read due to prefetch glitch
$80:8EC3 BD 42 03    LDA $0342,x[$7E:0342]  ;\
$80:8EC6 8D 10 43    STA $4310  [$7E:4310]  ;} DMA 1 control / target = [VRAM read table entry DMA control / target]
$80:8EC9 BD 44 03    LDA $0344,x[$7E:0344]  ;\
$80:8ECC 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:8ECF BD 45 03    LDA $0345,x[$7E:0345]  ;} DMA 1 source address = [VRAM read table entry destination address]
$80:8ED2 8D 13 43    STA $4313  [$7E:4313]  ;/
$80:8ED5 BD 47 03    LDA $0347,x[$7E:0347]  ;\
$80:8ED8 8D 15 43    STA $4315  [$7E:4315]  ;} DMA 1 size = [VRAM write table entry size]
$80:8EDB 9C 17 43    STZ $4317  [$7E:4317]  ;\
$80:8EDE 9C 19 43    STZ $4319  [$7E:4319]  ;} Clear DMA 1 HDMA registers
$80:8EE1 E2 20       SEP #$20
$80:8EE3 A9 02       LDA #$02               ;\
$80:8EE5 8D 0B 42    STA $420B  [$7E:420B]  ;} Enable DMA 1
$80:8EE8 8A          TXA                    ;\
$80:8EE9 18          CLC                    ;|
$80:8EEA 69 09       ADC #$09               ;} X += 9 (next VRAM read table entry)
$80:8EEC AA          TAX                    ;/
$80:8EED 80 C7       BRA $C7    [$8EB6]     ; Go to LOOP

; BRANCH_DONE
$80:8EEF 9C 60 03    STZ $0360  [$7E:0360]  ; VRAM read table stack pointer = 0
$80:8EF2 28          PLP
$80:8EF3 6B          RTL
}


;;; $8EF4: Check if music is queued ;;;
{
;; Returns:
;;     Carry: set if there's a non-zero music queue timer, clear otherwise

$80:8EF4 08          PHP
$80:8EF5 C2 30       REP #$30
$80:8EF7 DA          PHX
$80:8EF8 A2 0E 00    LDX #$000E

$80:8EFB BD 29 06    LDA $0629,x[$7E:0637]
$80:8EFE D0 08       BNE $08    [$8F08]
$80:8F00 CA          DEX
$80:8F01 CA          DEX
$80:8F02 10 F7       BPL $F7    [$8EFB]
$80:8F04 FA          PLX
$80:8F05 28          PLP
$80:8F06 18          CLC
$80:8F07 6B          RTL

$80:8F08 FA          PLX
$80:8F09 28          PLP
$80:8F0A 38          SEC
$80:8F0B 6B          RTL
}


;;; $8F0C: Handle music queue ;;;
{
; Decrement music timer
; If [music timer] > 0:
;     Return
; If [music timer] = 0:
;     Process [music entry]
;     Handle new music track / music data
;     Erase first entry from queue (advancing the start index)
;     Sound handler downtime = 8
;     If music data:
;         Return
; If [music queue start index] = [music queue next index] (queue is empty):
;     Music timer = 0 (try again next loop)
; Else:
;     Load music entry and music timer from first entry in queue

; Note that $064C (current music track) is never read anywhere, $07F5 is used instead (music track index)

$80:8F0C 08          PHP
$80:8F0D C2 20       REP #$20
$80:8F0F CE 3F 06    DEC $063F  [$7E:063F]  ; Decrement music timer
$80:8F12 30 33       BMI $33    [$8F47]     ; If [music timer] < 0: go to BRANCH_NEGATIVE
$80:8F14 F0 02       BEQ $02    [$8F18]     ; If [music timer] != 0:
$80:8F16 28          PLP
$80:8F17 6B          RTL                    ; Return

$80:8F18 AD 3D 06    LDA $063D  [$7E:063D]  ;\
$80:8F1B 30 45       BMI $45    [$8F62]     ;} If [music entry] & 8000h != 0: go to BRANCH_MUSIC_DATA
$80:8F1D E2 20       SEP #$20
$80:8F1F 29 7F       AND #$7F               ;\
$80:8F21 8D F5 07    STA $07F5  [$7E:07F5]  ;} Music track index = [music entry] & 7Fh
$80:8F24 9C F6 07    STZ $07F6  [$7E:07F6]  ;/
$80:8F27 8D 40 21    STA $2140  [$7E:2140]  ; APU IO 0 = [music track index]
$80:8F2A 8D 4C 06    STA $064C  [$7E:064C]  ; Current music track = [music track index]
$80:8F2D C2 20       REP #$20
$80:8F2F A9 08 00    LDA #$0008             ;\
$80:8F32 8D 86 06    STA $0686  [$7E:0686]  ;} Sound handler downtime = 8
$80:8F35 AE 3B 06    LDX $063B  [$7E:063B]  ;\
$80:8F38 9E 19 06    STZ $0619,x[$7E:061B]  ;} Music queue entries + [music queue start index] = 0
$80:8F3B 9E 29 06    STZ $0629,x[$7E:062B]  ; Music queue timer + [music queue start index] = 0
$80:8F3E E8          INX                    ;\
$80:8F3F E8          INX                    ;|
$80:8F40 8A          TXA                    ;} Music queue start index = ([music queue start index] + 2) % 10h
$80:8F41 29 0E 00    AND #$000E             ;|
$80:8F44 8D 3B 06    STA $063B  [$7E:063B]  ;/

; BRANCH_NEGATIVE
$80:8F47 AE 3B 06    LDX $063B  [$7E:063B]  ;\
$80:8F4A EC 39 06    CPX $0639  [$7E:0639]  ;} If [music queue start index] != [music queue next index]:
$80:8F4D F0 0E       BEQ $0E    [$8F5D]     ;/
$80:8F4F BD 19 06    LDA $0619,x[$7E:0619]  ;\
$80:8F52 8D 3D 06    STA $063D  [$7E:063D]  ;} Music entry = [music queue entries + [music queue start index]]
$80:8F55 BD 29 06    LDA $0629,x[$7E:0629]  ;\
$80:8F58 8D 3F 06    STA $063F  [$7E:063F]  ;} Music timer = [music queue timers + [music queue start index]]
$80:8F5B 28          PLP
$80:8F5C 6B          RTL                    ; Return

$80:8F5D 9C 3F 06    STZ $063F  [$7E:063F]  ; Music timer = 0
$80:8F60 28          PLP
$80:8F61 6B          RTL                    ; Return

; BRANCH_MUSIC_DATA
$80:8F62 29 FF 00    AND #$00FF             ;\
$80:8F65 8D F3 07    STA $07F3  [$7E:07F3]  ;} Music data index = [music entry] & FFh
$80:8F68 AA          TAX                    ; X = [music data index]
$80:8F69 E2 20       SEP #$20               ;\
$80:8F6B A9 FF       LDA #$FF               ;|
$80:8F6D 8D 4C 06    STA $064C  [$7E:064C]  ;} Current music track = FFh
$80:8F70 C2 20       REP #$20               ;/
$80:8F72 BF E1 E7 8F LDA $8FE7E1,x[$8F:E7E4];\
$80:8F76 85 00       STA $00    [$7E:0000]  ;|
$80:8F78 BF E2 E7 8F LDA $8FE7E2,x[$8F:E7E5];} $00 = [$8F:E7E1 + [music data index]]
$80:8F7C 85 01       STA $01    [$7E:0001]  ;/
$80:8F7E 22 24 80 80 JSL $808024[$80:8024]  ; Upload to APU
$80:8F82 E2 20       SEP #$20
$80:8F84 9C 4C 06    STZ $064C  [$7E:064C]  ; Current music track = 0
$80:8F87 C2 20       REP #$20
$80:8F89 AE 3B 06    LDX $063B  [$7E:063B]  ;\
$80:8F8C 9E 19 06    STZ $0619,x[$7E:0619]  ;} Music queue entries + [music queue start index] = 0
$80:8F8F 9E 29 06    STZ $0629,x[$7E:0629]  ; Music queue timer + [music queue start index] = 0
$80:8F92 E8          INX                    ;\
$80:8F93 E8          INX                    ;|
$80:8F94 8A          TXA                    ;} Music queue start index = ([music queue start index] + 2) % 10h
$80:8F95 29 0E 00    AND #$000E             ;|
$80:8F98 8D 3B 06    STA $063B  [$7E:063B]  ;/
$80:8F9B A9 08 00    LDA #$0008             ;\
$80:8F9E 8D 86 06    STA $0686  [$7E:0686]  ;} Sound handler downtime = 8
$80:8FA1 28          PLP
$80:8FA2 6B          RTL
}


;;; $8FA3: Unused. Queue music data or music track, 16 frame delay, can overwrite old entries, doesn't check for demo ;;;
{
;; Parameter:
;;     A: Music data / music track

; If [A] is negative, the low byte is a music data index, otherwise [A] is a music track
$80:8FA3 08          PHP
$80:8FA4 C2 30       REP #$30
$80:8FA6 DA          PHX
$80:8FA7 5A          PHY
$80:8FA8 AE 39 06    LDX $0639  [$7E:0639]  ;\
$80:8FAB 9D 19 06    STA $0619,x            ;} Music queue + [music queue next index] = [A]
$80:8FAE A9 10 00    LDA #$0010             ;\
$80:8FB1 9D 29 06    STA $0629,x            ;} Music queue timers + [music queue next index] = 10h
$80:8FB4 E8          INX                    ;\
$80:8FB5 E8          INX                    ;|
$80:8FB6 8A          TXA                    ;} Music queue next index = ([music queue next index] + 2) % 10h
$80:8FB7 29 0E 00    AND #$000E             ;|
$80:8FBA 8D 39 06    STA $0639  [$80:0639]  ;/
$80:8FBD 7A          PLY
$80:8FBE FA          PLX
$80:8FBF 28          PLP
$80:8FC0 6B          RTL
}


;;; $8FC1: Queue music data or music track, 8 frame delay, cannot set last queue entry ;;;
{
;; Parameter:
;;     A: Music data / music track

; If [A] is negative, the low byte is a music data index, otherwise [A] is a music track
$80:8FC1 08          PHP
$80:8FC2 C2 30       REP #$30
$80:8FC4 DA          PHX
$80:8FC5 5A          PHY
$80:8FC6 AE 98 09    LDX $0998  [$7E:0998]  ;\
$80:8FC9 E0 28 00    CPX #$0028             ;} If in demo: return
$80:8FCC B0 25       BCS $25    [$8FF3]     ;/
$80:8FCE 48          PHA                    ;\
$80:8FCF AD 39 06    LDA $0639  [$7E:0639]  ;|
$80:8FD2 1A          INC A                  ;|
$80:8FD3 1A          INC A                  ;|
$80:8FD4 29 0E 00    AND #$000E             ;} If ([music queue next index] + 2) % 10h = [music queue start index]: return
$80:8FD7 AA          TAX                    ;|
$80:8FD8 68          PLA                    ;|
$80:8FD9 EC 3B 06    CPX $063B  [$7E:063B]  ;|
$80:8FDC F0 15       BEQ $15    [$8FF3]     ;/
$80:8FDE AE 39 06    LDX $0639  [$7E:0639]  ;\
$80:8FE1 9D 19 06    STA $0619,x[$7E:0619]  ;} Music queue entries + [music queue next index] = [A]
$80:8FE4 A9 08 00    LDA #$0008             ;\
$80:8FE7 9D 29 06    STA $0629,x[$7E:0629]  ;} Music queue timers + [music queue next index] = 8
$80:8FEA E8          INX                    ;\
$80:8FEB E8          INX                    ;|
$80:8FEC 8A          TXA                    ;} Music queue next index = ([music queue next index] + 2) % 10h
$80:8FED 29 0E 00    AND #$000E             ;|
$80:8FF0 8D 39 06    STA $0639  [$7E:0639]  ;/

$80:8FF3 7A          PLY
$80:8FF4 FA          PLX
$80:8FF5 28          PLP
$80:8FF6 6B          RTL
}


;;; $8FF7: Queue music data or music track, max([Y], 8) frame delay, can overwrite old entries ;;;
{
;; Parameter:
;;     A: Music data / music track
;;     Y: Delay

; Called by:
;     $82:DCE0 with A = 5, Y = 14: Game state 14h (death sequence, black out surroundings)
;     $82:E0D5 with Y = 6: Load new music track if changed
;     $82:E118 with A = 0: Play room music track after [A] frames
;     $8B:A613 with A = 5, Y = 14: Cinematic function - intro - queue "the galaxy is at peace" music
;     $8B:A66F with A = 5, Y = 14: Cinematic function - intro - set up intro text page 1
;     $8B:BCA0 with A = 5, Y = 14
;     $8B:C11B with A = 7, Y = 14
;     $8B:D480 with A = 5, Y = 14
;     $8B:DB9E with A = 5, Y = 14
;     $92:ED24 with A = 1, Y = 14: Play Samus fanfare

; If [A] is negative, the low byte is a music data index, otherwise [A] is a music track
$80:8FF7 08          PHP
$80:8FF8 C2 30       REP #$30
$80:8FFA DA          PHX
$80:8FFB AE 98 09    LDX $0998  [$7E:0998]  ;\
$80:8FFE E0 28 00    CPX #$0028             ;} If in demo: return
$80:9001 B0 1B       BCS $1B    [$901E]     ;/
$80:9003 AE 39 06    LDX $0639  [$7E:0639]  ;\
$80:9006 9D 19 06    STA $0619,x[$7E:0619]  ;} Music queue + [music queue next index] = [A]
$80:9009 98          TYA                    ;\
$80:900A C9 08 00    CMP #$0008             ;|
$80:900D B0 03       BCS $03    [$9012]     ;} Y = max([Y], 8)
$80:900F A9 08 00    LDA #$0008             ;/

$80:9012 9D 29 06    STA $0629,x[$7E:0629]  ; Music queue timers + [music queue next index] = [Y]
$80:9015 E8          INX                    ;\
$80:9016 E8          INX                    ;|
$80:9017 8A          TXA                    ;} Music queue next index = ([music queue next index] + 2) % 10h
$80:9018 29 0E 00    AND #$000E             ;|
$80:901B 8D 39 06    STA $0639  [$7E:0639]  ;/

$80:901E FA          PLX
$80:901F 28          PLP
$80:9020 6B          RTL
}


;;; $9021..91A6: Queue sound ;;;
{
;;; $9021: Queue sound, sound library 1, max queued sounds allowed = 15 ;;;
{
$80:9021 DA          PHX
$80:9022 5A          PHY
$80:9023 08          PHP
$80:9024 E2 30       SEP #$30
$80:9026 EB          XBA
$80:9027 A9 0F       LDA #$0F
$80:9029 80 26       BRA $26    [$9051]
}


;;; $902B: Queue sound, sound library 1, max queued sounds allowed = 9 ;;;
{
$80:902B DA          PHX
$80:902C 5A          PHY
$80:902D 08          PHP
$80:902E E2 30       SEP #$30
$80:9030 EB          XBA
$80:9031 A9 09       LDA #$09
$80:9033 80 1C       BRA $1C    [$9051]
}


;;; $9035: Queue sound, sound library 1, max queued sounds allowed = 3 ;;;
{
$80:9035 DA          PHX
$80:9036 5A          PHY
$80:9037 08          PHP
$80:9038 E2 30       SEP #$30
$80:903A EB          XBA
$80:903B A9 03       LDA #$03
$80:903D 80 12       BRA $12    [$9051]
}


;;; $903F: Queue sound, sound library 1, max queued sounds allowed = 1 ;;;
{
$80:903F DA          PHX
$80:9040 5A          PHY
$80:9041 08          PHP
$80:9042 E2 30       SEP #$30
$80:9044 EB          XBA
$80:9045 A9 01       LDA #$01
$80:9047 80 08       BRA $08    [$9051]
}


;;; $9049: Queue sound, sound library 1, max queued sounds allowed = 6 ;;;
{
$80:9049 DA          PHX
$80:904A 5A          PHY
$80:904B 08          PHP
$80:904C E2 30       SEP #$30
$80:904E EB          XBA
$80:904F A9 06       LDA #$06
}


;;; $9051: Queue sound, sound library 1 ;;;
{
;; Parameter:
;;     A low: Max queued sounds allowed
;;     A high: Sound to queue

; Checks whether sound can be queued; returns if queue threshold is exceeded, sounds are disabled, in a demo or a power bomb is exploding.
; If it can be queued and the following slot is empty, queues the sound, sets the 'next index' and returns.
; If the following slot is not empty, the sound with the lower ID gets priority and the 'next index' is unchanged.
$80:9051 8D 53 06    STA $0653  [$7E:0653]  ; Max queued sounds allowed = [A low]
$80:9054 AD 46 06    LDA $0646  [$7E:0646]  ;\
$80:9057 38          SEC                    ;|
$80:9058 ED 43 06    SBC $0643  [$7E:0643]  ;|
$80:905B 29 0F       AND #$0F               ;} If [sound queue next index] - [sound queue start index] & Fh >= [max queued sounds allowed]: return
$80:905D CD 53 06    CMP $0653  [$7E:0653]  ;|
$80:9060 B0 30       BCS $30    [$9092]     ;/
$80:9062 EB          XBA                    ; A = [A high]
$80:9063 C2 30       REP #$30
$80:9065 AE F5 05    LDX $05F5  [$7E:05F5]  ;\
$80:9068 D0 28       BNE $28    [$9092]     ;} If sounds disabled: return
$80:906A AE 98 09    LDX $0998  [$7E:0998]  ;\
$80:906D E0 28 00    CPX #$0028             ;} If in demo: return
$80:9070 B0 20       BCS $20    [$9092]     ;/
$80:9072 AE 92 05    LDX $0592  [$7E:0592]  ;\
$80:9075 30 1B       BMI $1B    [$9092]     ;} If [power bomb explosion status] = exploding: return
$80:9077 E2 30       SEP #$30
$80:9079 AC 46 06    LDY $0646  [$7E:0646]  ;\
$80:907C BB          TYX                    ;|
$80:907D E8          INX                    ;|
$80:907E E0 10       CPX #$10               ;} X = [sound queue next index] + 1 & Fh
$80:9080 90 02       BCC $02    [$9084]     ;|
$80:9082 A2 00       LDX #$00               ;/

$80:9084 EC 43 06    CPX $0643  [$7E:0643]  ;\
$80:9087 F0 0D       BEQ $0D    [$9096]     ;} If [X] = [sound queue start index]: go to BRANCH_QUEUE_FULL
$80:9089 99 56 06    STA $0656,y[$7E:0656]  ; Sound queue + [sound queue next index] = [A]
$80:908C 8E 46 06    STX $0646  [$7E:0646]  ; Sound queue next index = [X]
$80:908F 9E 56 06    STZ $0656,x[$7E:0657]  ; Sound queue + [X] = 0

$80:9092 28          PLP
$80:9093 7A          PLY
$80:9094 FA          PLX
$80:9095 6B          RTL                    ; Return

; BRANCH_QUEUE_FULL
$80:9096 20 A7 91    JSR $91A7  [$80:91A7]  ; NOP : RTS
$80:9099 D9 56 06    CMP $0656,y            ;\
$80:909C B0 F4       BCS $F4    [$9092]     ;} If [A] < [sound queue + [sound queue next index]]:
$80:909E 99 56 06    STA $0656,y            ; Sound queue + [sound queue next index] = [A]
$80:90A1 80 EF       BRA $EF    [$9092]     ; Return
}


;;; $90A3: Queue sound, sound library 2, max queued sounds allowed = 15 ;;;
{
$80:90A3 DA          PHX
$80:90A4 5A          PHY
$80:90A5 08          PHP
$80:90A6 E2 30       SEP #$30
$80:90A8 EB          XBA
$80:90A9 A9 0F       LDA #$0F
$80:90AB 80 26       BRA $26    [$90D3]
}


;;; $90AD: Queue sound, sound library 2, max queued sounds allowed = 9 ;;;
{
$80:90AD DA          PHX
$80:90AE 5A          PHY
$80:90AF 08          PHP
$80:90B0 E2 30       SEP #$30
$80:90B2 EB          XBA
$80:90B3 A9 09       LDA #$09
$80:90B5 80 1C       BRA $1C    [$90D3]
}


;;; $90B7: Queue sound, sound library 2, max queued sounds allowed = 3 ;;;
{
$80:90B7 DA          PHX
$80:90B8 5A          PHY
$80:90B9 08          PHP
$80:90BA E2 30       SEP #$30
$80:90BC EB          XBA
$80:90BD A9 03       LDA #$03
$80:90BF 80 12       BRA $12    [$90D3]
}


;;; $90C1: Queue sound, sound library 2, max queued sounds allowed = 1 ;;;
{
$80:90C1 DA          PHX
$80:90C2 5A          PHY
$80:90C3 08          PHP
$80:90C4 E2 30       SEP #$30
$80:90C6 EB          XBA
$80:90C7 A9 01       LDA #$01
$80:90C9 80 08       BRA $08    [$90D3]
}


;;; $90CB: Queue sound, sound library 2, max queued sounds allowed = 6 ;;;
{
$80:90CB DA          PHX
$80:90CC 5A          PHY
$80:90CD 08          PHP
$80:90CE E2 30       SEP #$30
$80:90D0 EB          XBA
$80:90D1 A9 06       LDA #$06
}


;;; $90D3: Queue sound, sound library 2 ;;;
{
;; Parameter:
;;     A low: Max queued sounds allowed
;;     A high: Sound to queue

; Checks whether sound can be queued; returns if queue threshold is exceeded, sounds are disabled, in a demo or a power bomb is exploding.
; If it can be queued and the following slot is empty, queues the sound, sets the 'next index' and returns.
; If the following slot is not empty, the sound with the lower ID gets priority and the 'next index' is unchanged.
$80:90D3 8D 54 06    STA $0654  [$7E:0654]  ; Max queued sounds allowed = [A low]
$80:90D6 AD 47 06    LDA $0647  [$7E:0647]  ;\
$80:90D9 38          SEC                    ;|
$80:90DA ED 44 06    SBC $0644  [$7E:0644]  ;|
$80:90DD 29 0F       AND #$0F               ;} If [sound queue next index] - [sound queue start index] & Fh >= [max queued sounds allowed]: return
$80:90DF CD 54 06    CMP $0654  [$7E:0654]  ;|
$80:90E2 B0 30       BCS $30    [$9114]     ;/
$80:90E4 EB          XBA                    ; A = [A high]
$80:90E5 C2 30       REP #$30
$80:90E7 AE F5 05    LDX $05F5  [$7E:05F5]  ;\
$80:90EA D0 28       BNE $28    [$9114]     ;} If sounds disabled: return
$80:90EC AE 98 09    LDX $0998  [$7E:0998]  ;\
$80:90EF E0 28 00    CPX #$0028             ;} If in demo: return
$80:90F2 B0 20       BCS $20    [$9114]     ;/
$80:90F4 AE 92 05    LDX $0592  [$7E:0592]  ;\
$80:90F7 30 1B       BMI $1B    [$9114]     ;} If [power bomb explosion status] = exploding: return
$80:90F9 E2 30       SEP #$30
$80:90FB AC 47 06    LDY $0647  [$7E:0647]  ;\
$80:90FE BB          TYX                    ;|
$80:90FF E8          INX                    ;|
$80:9100 E0 10       CPX #$10               ;} X = [sound queue next index] + 1 & Fh
$80:9102 90 02       BCC $02    [$9106]     ;|
$80:9104 A2 00       LDX #$00               ;/

$80:9106 EC 44 06    CPX $0644  [$7E:0644]  ;\
$80:9109 F0 0D       BEQ $0D    [$9118]     ;} If [X] = [sound queue start index]: go to BRANCH_QUEUE_FULL
$80:910B 99 66 06    STA $0666,y[$7E:0666]  ; Sound queue + [sound queue next index] = [A]
$80:910E 8E 47 06    STX $0647  [$7E:0647]  ; Sound queue next index = [X]
$80:9111 9E 66 06    STZ $0666,x[$7E:0667]  ; Sound queue + [X] = 0

$80:9114 28          PLP
$80:9115 7A          PLY
$80:9116 FA          PLX
$80:9117 6B          RTL                    ; Return

; BRANCH_QUEUE_FULL
$80:9118 20 A7 91    JSR $91A7  [$80:91A7]  ; NOP : RTS
$80:911B D9 66 06    CMP $0666,y            ;\
$80:911E B0 F4       BCS $F4    [$9114]     ;} If [A] < [sound queue + [sound queue next index]]:
$80:9120 99 66 06    STA $0666,y            ; Sound queue + [sound queue next index] = [A]
$80:9123 80 EF       BRA $EF    [$9114]     ; Return
}


;;; $9125: Queue sound, sound library 3, max queued sounds allowed = 15 ;;;
{
$80:9125 DA          PHX
$80:9126 5A          PHY
$80:9127 08          PHP
$80:9128 E2 30       SEP #$30
$80:912A EB          XBA
$80:912B A9 0F       LDA #$0F
$80:912D 80 26       BRA $26    [$9155]
}


;;; $912F: Queue sound, sound library 3, max queued sounds allowed = 9 ;;;
{
$80:912F DA          PHX
$80:9130 5A          PHY
$80:9131 08          PHP
$80:9132 E2 30       SEP #$30
$80:9134 EB          XBA
$80:9135 A9 09       LDA #$09
$80:9137 80 1C       BRA $1C    [$9155]
}


;;; $9139: Queue sound, sound library 3, max queued sounds allowed = 3 ;;;
{
$80:9139 DA          PHX
$80:913A 5A          PHY
$80:913B 08          PHP
$80:913C E2 30       SEP #$30
$80:913E EB          XBA
$80:913F A9 03       LDA #$03
$80:9141 80 12       BRA $12    [$9155]
}


;;; $9143: Queue sound, sound library 3, max queued sounds allowed = 1 ;;;
{
$80:9143 DA          PHX
$80:9144 5A          PHY
$80:9145 08          PHP
$80:9146 E2 30       SEP #$30
$80:9148 EB          XBA
$80:9149 A9 01       LDA #$01
$80:914B 80 08       BRA $08    [$9155]
}


;;; $914D: Queue sound, sound library 3, max queued sounds allowed = 6 ;;;
{
$80:914D DA          PHX
$80:914E 5A          PHY
$80:914F 08          PHP
$80:9150 E2 30       SEP #$30
$80:9152 EB          XBA
$80:9153 A9 06       LDA #$06
}


;;; $9155: Queue sound, sound library 3 ;;;
{
;; Parameter:
;;     A low: Max queued sounds allowed
;;     A high: Sound to queue

; Checks whether sound can be queued; returns if queue threshold is exceeded, sounds are disabled, in a demo or a power bomb is exploding.
; If it can be queued and the following slot is empty, queues the sound, sets the 'next index' and returns.
; If the following slot is not empty, the sound with the lower ID gets priority and the 'next index' is unchanged.
$80:9155 8D 55 06    STA $0655  [$7E:0655]  ; Max queued sounds allowed = [A low]
$80:9158 AD 48 06    LDA $0648  [$7E:0648]  ;\
$80:915B 38          SEC                    ;|
$80:915C ED 45 06    SBC $0645  [$7E:0645]  ;|
$80:915F 29 0F       AND #$0F               ;} If [sound queue next index] - [sound queue start index] & Fh >= [max queued sounds allowed]: return
$80:9161 CD 55 06    CMP $0655  [$7E:0655]  ;|
$80:9164 B0 30       BCS $30    [$9196]     ;/
$80:9166 EB          XBA                    ; A = [A high]
$80:9167 C2 30       REP #$30
$80:9169 AE F5 05    LDX $05F5  [$7E:05F5]  ;\
$80:916C D0 28       BNE $28    [$9196]     ;} If sounds disabled: return
$80:916E AE 98 09    LDX $0998  [$7E:0998]  ;\
$80:9171 E0 28 00    CPX #$0028             ;} If in demo: return
$80:9174 B0 20       BCS $20    [$9196]     ;/
$80:9176 AE 92 05    LDX $0592  [$7E:0592]  ;\
$80:9179 30 1B       BMI $1B    [$9196]     ;} If [power bomb explosion status] = exploding: return
$80:917B E2 30       SEP #$30
$80:917D AC 48 06    LDY $0648  [$7E:0648]  ;\
$80:9180 BB          TYX                    ;|
$80:9181 E8          INX                    ;|
$80:9182 E0 10       CPX #$10               ;} X = [sound queue next index] + 1 & Fh
$80:9184 90 02       BCC $02    [$9188]     ;|
$80:9186 A2 00       LDX #$00               ;/

$80:9188 EC 45 06    CPX $0645  [$7E:0645]  ;\
$80:918B F0 0D       BEQ $0D    [$919A]     ;} If [X] = [sound queue start index]: go to BRANCH_QUEUE_FULL
$80:918D 99 76 06    STA $0676,y[$7E:0676]  ; Sound queue + [sound queue next index] = [A]
$80:9190 8E 48 06    STX $0648  [$7E:0648]  ; Sound queue next index = [X]
$80:9193 9E 76 06    STZ $0676,x[$7E:0677]  ; Sound queue + [X] = 0

$80:9196 28          PLP
$80:9197 7A          PLY
$80:9198 FA          PLX
$80:9199 6B          RTL                    ; Return

; BRANCH_QUEUE_FULL
$80:919A 20 A7 91    JSR $91A7  [$80:91A7]  ; NOP : RTS
$80:919D D9 76 06    CMP $0676,y            ;\
$80:91A0 B0 F4       BCS $F4    [$9196]     ;} If [A] < [sound queue + [sound queue next index]]:
$80:91A2 99 76 06    STA $0676,y            ; Sound queue + [sound queue next index] = [A]
$80:91A5 80 EF       BRA $EF    [$9196]     ; Return
}
}


;;; $91A7: NOP : RTS ;;;
{
; Called by:
;     $9051: Queue sound, sound library 1
;     $90D3: Queue sound, sound library 2
;     $9155: Queue sound, sound library 3
$80:91A7 EA          NOP
$80:91A8 60          RTS
}


;;; $91A9: Set up a (H)DMA transfer ;;;
{
;; Parameters:
;;     [[S] + 1] + 1: DMA channel
;;     [[S] + 1] + 2: DMA options
;;     [[S] + 1] + 3: DMA target
;;     [[S] + 1] + 4: Source address (24-bit)
;;     [[S] + 1] + 7: Size (in bytes)

$80:91A9 08          PHP
$80:91AA 8B          PHB
$80:91AB C2 30       REP #$30
$80:91AD A3 04       LDA $04,s  [$7E:1FF9]  ;\
$80:91AF 48          PHA                    ;|
$80:91B0 AB          PLB                    ;} DB = caller bank
$80:91B1 AB          PLB                    ;/
$80:91B2 A3 03       LDA $03,s  [$7E:1FF8]  ;\
$80:91B4 A8          TAY                    ;} Y = (return address)
$80:91B5 B9 01 00    LDA $0001,y[$8B:92B9]  ;\
$80:91B8 29 FF 00    AND #$00FF             ;|
$80:91BB AA          TAX                    ;} X = [(return address) + 1] * 10h
$80:91BC BF E6 91 80 LDA $8091E6,x[$80:91E7];|
$80:91C0 29 FF 00    AND #$00FF             ;/
$80:91C3 AA          TAX
$80:91C4 B9 02 00    LDA $0002,y[$8B:92BA]  ;\
$80:91C7 9D 00 43    STA $4300,x[$7E:4310]  ;|
$80:91CA B9 04 00    LDA $0004,y[$8B:92BC]  ;|
$80:91CD 9D 02 43    STA $4302,x[$7E:4312]  ;|
$80:91D0 B9 06 00    LDA $0006,y[$8B:92BE]  ;} Copy 7 bytes from (return address) + 2 to $4300 + [X]
$80:91D3 9D 04 43    STA $4304,x[$7E:4314]  ;|
$80:91D6 B9 07 00    LDA $0007,y[$8B:92BF]  ;|
$80:91D9 9D 05 43    STA $4305,x[$7E:4315]  ;/
$80:91DC 98          TYA                    ;\
$80:91DD 18          CLC                    ;|
$80:91DE 69 08 00    ADC #$0008             ;} (Return address) += 8
$80:91E1 83 03       STA $03,s  [$7E:1FF8]  ;/
$80:91E3 AB          PLB
$80:91E4 28          PLP
$80:91E5 6B          RTL

$80:91E6             db 00, 10, 20, 30, 40, 50, 60, 70
}


;;; $91EE: Update IO registers ;;;
{
$80:91EE A6 84       LDX $84    [$7E:0084]  ;\
$80:91F0 8E 00 42    STX $4200  [$7E:4200]  ;} Interrupt and auto-joypad enable
$80:91F3 A6 51       LDX $51    [$7E:0051]  ;\
$80:91F5 8E 00 21    STX $2100  [$7E:2100]  ;} Forced blank and brightness
$80:91F8 A6 52       LDX $52    [$7E:0052]  ;\
$80:91FA 8E 01 21    STX $2101  [$7E:2101]  ;} Sprite size and sprite tiles base address
$80:91FD A6 55       LDX $55    [$7E:0055]  ;\
$80:91FF 8E 05 21    STX $2105  [$7E:2105]  ;} Mode and BG tile size
$80:9202 A6 57       LDX $57    [$7E:0057]  ;\
$80:9204 8E 06 21    STX $2106  [$7E:2106]  ;} Mosaic size and enable
$80:9207 A6 58       LDX $58    [$7E:0058]  ;\
$80:9209 8E 07 21    STX $2107  [$7E:2107]  ;} BG1 tilemap base address and size
$80:920C A6 59       LDX $59    [$7E:0059]  ;\
$80:920E 8E 08 21    STX $2108  [$7E:2108]  ;} BG2 tilemap base address and size
$80:9211 A6 5A       LDX $5A    [$7E:005A]  ;\
$80:9213 8E 09 21    STX $2109  [$7E:2109]  ;} BG3 tilemap base address and size
$80:9216 A6 5C       LDX $5C    [$7E:005C]  ;\
$80:9218 8E 0A 21    STX $210A  [$7E:210A]  ;} BG4 tilemap base address and size
$80:921B A6 5D       LDX $5D    [$7E:005D]  ;\
$80:921D 8E 0B 21    STX $210B  [$7E:210B]  ;|
$80:9220 A6 5E       LDX $5E    [$7E:005E]  ;} BG tiles base address
$80:9222 8E 0C 21    STX $210C  [$7E:210C]  ;/
$80:9225 A6 5F       LDX $5F    [$7E:005F]  ;\
$80:9227 8E 1A 21    STX $211A  [$7E:211A]  ;} Mode 7 settings
$80:922A A6 60       LDX $60    [$7E:0060]  ;\
$80:922C 8E 23 21    STX $2123  [$7E:2123]  ;} Window BG1/2 mask settings
$80:922F A6 61       LDX $61    [$7E:0061]  ;\
$80:9231 8E 24 21    STX $2124  [$7E:2124]  ;} Window BG3/4 mask settings
$80:9234 A6 62       LDX $62    [$7E:0062]  ;\
$80:9236 8E 25 21    STX $2125  [$7E:2125]  ;} Window sprites/math mask settings
$80:9239 A6 63       LDX $63    [$7E:0063]  ;\
$80:923B 8E 26 21    STX $2126  [$7E:2126]  ;} Window 1 left position
$80:923E A6 64       LDX $64    [$7E:0064]  ;\
$80:9240 8E 27 21    STX $2127  [$7E:2127]  ;} Window 1 right position
$80:9243 A6 65       LDX $65    [$7E:0065]  ;\
$80:9245 8E 28 21    STX $2128  [$7E:2128]  ;} Window 2 left position
$80:9248 A6 66       LDX $66    [$7E:0066]  ;\
$80:924A 8E 29 21    STX $2129  [$7E:2129]  ;} Window 2 right position
$80:924D A6 67       LDX $67    [$7E:0067]  ;\
$80:924F 8E 2A 21    STX $212A  [$7E:212A]  ;} Window 1/2 BG mask logic
$80:9252 A6 68       LDX $68    [$7E:0068]  ;\
$80:9254 8E 2B 21    STX $212B  [$7E:212B]  ;} Window 1/2 sprites/colour math mask logic
$80:9257 A6 69       LDX $69    [$7E:0069]  ;\
$80:9259 86 6A       STX $6A    [$7E:006A]  ;} Main screen layers
$80:925B 8E 2C 21    STX $212C  [$7E:212C]  ;/
$80:925E A6 6C       LDX $6C    [$7E:006C]  ;\
$80:9260 8E 2E 21    STX $212E  [$7E:212E]  ;} Window area main screen disable
$80:9263 A6 6B       LDX $6B    [$7E:006B]  ;\
$80:9265 8E 2D 21    STX $212D  [$7E:212D]  ;} Subscreen layers
$80:9268 A6 6D       LDX $6D    [$7E:006D]  ;\
$80:926A 8E 2F 21    STX $212F  [$7E:212F]  ;} Window area subscreen disable
$80:926D A6 6F       LDX $6F    [$7E:006F]  ;\
$80:926F 8E 30 21    STX $2130  [$7E:2130]  ;} Colour math control register A
$80:9272 A6 72       LDX $72    [$7E:0072]  ;\
$80:9274 8E 31 21    STX $2131  [$7E:2131]  ;} Colour math control register B
$80:9277 A6 6E       LDX $6E    [$7E:006E]  ;\
$80:9279 86 70       STX $70    [$7E:0070]  ;} Next gameplay colour math control register A
$80:927B A6 71       LDX $71    [$7E:0071]  ;\
$80:927D 86 73       STX $73    [$7E:0073]  ;} Next gameplay colour math control register B
$80:927F A6 74       LDX $74    [$7E:0074]  ;\
$80:9281 8E 32 21    STX $2132  [$7E:2132]  ;|
$80:9284 A6 75       LDX $75    [$7E:0075]  ;|
$80:9286 8E 32 21    STX $2132  [$7E:2132]  ;} Colour math subscreen backdrop colour
$80:9289 A6 76       LDX $76    [$7E:0076]  ;|
$80:928B 8E 32 21    STX $2132  [$7E:2132]  ;/
$80:928E A6 77       LDX $77    [$7E:0077]  ;\
$80:9290 8E 33 21    STX $2133  [$7E:2133]  ;} Display resolution
$80:9293 A6 B1       LDX $B1    [$7E:00B1]  ;\
$80:9295 8E 0D 21    STX $210D  [$7E:210D]  ;|
$80:9298 A6 B2       LDX $B2    [$7E:00B2]  ;} BG1 X scroll
$80:929A 8E 0D 21    STX $210D  [$7E:210D]  ;/
$80:929D A6 B3       LDX $B3    [$7E:00B3]  ;\
$80:929F 8E 0E 21    STX $210E  [$7E:210E]  ;|
$80:92A2 A6 B4       LDX $B4    [$7E:00B4]  ;} BG1 Y scroll
$80:92A4 8E 0E 21    STX $210E  [$7E:210E]  ;/
$80:92A7 A6 B5       LDX $B5    [$7E:00B5]  ;\
$80:92A9 8E 0F 21    STX $210F  [$7E:210F]  ;|
$80:92AC A6 B6       LDX $B6    [$7E:00B6]  ;} BG2 X scroll
$80:92AE 8E 0F 21    STX $210F  [$7E:210F]  ;/
$80:92B1 A6 B7       LDX $B7    [$7E:00B7]  ;\
$80:92B3 8E 10 21    STX $2110  [$7E:2110]  ;|
$80:92B6 A6 B8       LDX $B8    [$7E:00B8]  ;} BG2 Y scroll
$80:92B8 8E 10 21    STX $2110  [$7E:2110]  ;/
$80:92BB A6 B9       LDX $B9    [$7E:00B9]  ;\
$80:92BD 8E 11 21    STX $2111  [$7E:2111]  ;|
$80:92C0 A6 BA       LDX $BA    [$7E:00BA]  ;} BG3 X scroll
$80:92C2 8E 11 21    STX $2111  [$7E:2111]  ;/
$80:92C5 A6 BB       LDX $BB    [$7E:00BB]  ;\
$80:92C7 8E 12 21    STX $2112  [$7E:2112]  ;|
$80:92CA A6 BC       LDX $BC    [$7E:00BC]  ;} BG3 Y scroll
$80:92CC 8E 12 21    STX $2112  [$7E:2112]  ;/
$80:92CF A6 BD       LDX $BD    [$7E:00BD]  ;\
$80:92D1 8E 13 21    STX $2113  [$7E:2113]  ;|
$80:92D4 A6 BE       LDX $BE    [$7E:00BE]  ;} BG4 X scroll
$80:92D6 8E 13 21    STX $2113  [$7E:2113]  ;/
$80:92D9 A6 BF       LDX $BF    [$7E:00BF]  ;\
$80:92DB 8E 14 21    STX $2114  [$7E:2114]  ;|
$80:92DE A6 C0       LDX $C0    [$7E:00C0]  ;} BG4 Y scroll
$80:92E0 8E 14 21    STX $2114  [$7E:2114]  ;/
$80:92E3 A6 56       LDX $56    [$7E:0056]  ;\
$80:92E5 8E EC 07    STX $07EC  [$7E:07EC]  ;} $07EC = [fake mode and BG tile size]
$80:92E8 A5 55       LDA $55    [$7E:0055]  ;\
$80:92EA 29 07 00    AND #$0007             ;|
$80:92ED C9 07 00    CMP #$0007             ;|
$80:92F0 F0 0B       BEQ $0B    [$92FD]     ;|
$80:92F2 A5 56       LDA $56    [$7E:0056]  ;} If not mode 7:
$80:92F4 29 07 00    AND #$0007             ;|
$80:92F7 C9 07 00    CMP #$0007             ;|
$80:92FA F0 01       BEQ $01    [$92FD]     ;/
$80:92FC 60          RTS                    ; Return

$80:92FD A6 78       LDX $78    [$7E:0078]  ;\
$80:92FF 8E 1B 21    STX $211B  [$7E:211B]  ;|
$80:9302 A6 79       LDX $79    [$7E:0079]  ;} Mode 7 transformation matrix parameter A
$80:9304 8E 1B 21    STX $211B  [$7E:211B]  ;/
$80:9307 A6 7A       LDX $7A    [$7E:007A]  ;\
$80:9309 8E 1C 21    STX $211C  [$7E:211C]  ;|
$80:930C A6 7B       LDX $7B    [$7E:007B]  ;} Mode 7 transformation matrix parameter B
$80:930E 8E 1C 21    STX $211C  [$7E:211C]  ;/
$80:9311 A6 7C       LDX $7C    [$7E:007C]  ;\
$80:9313 8E 1D 21    STX $211D  [$7E:211D]  ;|
$80:9316 A6 7D       LDX $7D    [$7E:007D]  ;} Mode 7 transformation matrix parameter C
$80:9318 8E 1D 21    STX $211D  [$7E:211D]  ;/
$80:931B A6 7E       LDX $7E    [$7E:007E]  ;\
$80:931D 8E 1E 21    STX $211E  [$7E:211E]  ;|
$80:9320 A6 7F       LDX $7F    [$7E:007F]  ;} Mode 7 transformation matrix parameter D
$80:9322 8E 1E 21    STX $211E  [$7E:211E]  ;/
$80:9325 A6 80       LDX $80    [$7E:0080]  ;\
$80:9327 8E 1F 21    STX $211F  [$7E:211F]  ;|
$80:932A A6 81       LDX $81    [$7E:0081]  ;} Mode 7 transformation origin co-ordinate X
$80:932C 8E 1F 21    STX $211F  [$7E:211F]  ;/
$80:932F A6 82       LDX $82    [$7E:0082]  ;\
$80:9331 8E 20 21    STX $2120  [$7E:2120]  ;|
$80:9334 A6 83       LDX $83    [$7E:0083]  ;} Mode 7 transformation origin co-ordinate Y
$80:9336 8E 20 21    STX $2120  [$7E:2120]  ;/
$80:9339 60          RTS
}


;;; $933A: Update OAM & CGRAM ;;;
{
$80:933A A9 00 04    LDA #$0400             ;\
$80:933D 8D 00 43    STA $4300  [$7E:4300]  ;|
$80:9340 A9 70 03    LDA #$0370             ;|
$80:9343 8D 02 43    STA $4302  [$7E:4302]  ;|
$80:9346 A2 00       LDX #$00               ;} Set up DMA 0 for OAM = [$0370..$058F]
$80:9348 8E 04 43    STX $4304  [$7E:4304]  ;|
$80:934B A9 20 02    LDA #$0220             ;|
$80:934E 8D 05 43    STA $4305  [$7E:4305]  ;|
$80:9351 9C 02 21    STZ $2102  [$7E:2102]  ;/
$80:9354 A9 00 22    LDA #$2200             ;\
$80:9357 8D 10 43    STA $4310  [$7E:4310]  ;|
$80:935A A9 00 C0    LDA #$C000             ;|
$80:935D 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:9360 A2 7E       LDX #$7E               ;|
$80:9362 8E 14 43    STX $4314  [$7E:4314]  ;} Set up DMA 1 for CGRAM = [$7E:C000..$C1FF]
$80:9365 A9 00 02    LDA #$0200             ;|
$80:9368 8D 15 43    STA $4315  [$7E:4315]  ;|
$80:936B A2 00       LDX #$00               ;|
$80:936D 8E 21 21    STX $2121  [$7E:2121]  ;/
$80:9370 A2 03       LDX #$03               ;\
$80:9372 8E 0B 42    STX $420B  [$7E:420B]  ;} Execute DMA 0 and 1
$80:9375 60          RTS
}


;;; $9376: Transfer Samus tiles to VRAM ;;;
{
; Samus tiles definition format:
;     aaaaaa nnnn NNNN
; where:
;     a: Source address
;     n: Part 1 size, n = 0 means 10000h bytes are transferred
;     N: Part 2 size, N = 0 means no bytes are transferred
$80:9376 8B          PHB
$80:9377 A2 92       LDX #$92               ;\
$80:9379 DA          PHX                    ;} DB = $92
$80:937A AB          PLB                    ;/
$80:937B A2 02       LDX #$02
$80:937D A0 80       LDY #$80               ;\
$80:937F 8C 15 21    STY $2115  [$7E:2115]  ;} VRAM address increment mode = 16-bit access
$80:9382 AC 1D 07    LDY $071D  [$7E:071D]  ;\
$80:9385 F0 44       BEQ $44    [$93CB]     ;} If Samus top half tiles flagged for transfer:
$80:9387 A0 02       LDY #$02
$80:9389 AD 1F 07    LDA $071F  [$7E:071F]  ;\
$80:938C 85 3C       STA $3C    [$7E:003C]  ;} $3C = [Samus top half tiles definition]
$80:938E A9 00 60    LDA #$6000             ;\
$80:9391 8D 16 21    STA $2116  [$7E:2116]  ;} VRAM address = $6000
$80:9394 A9 01 18    LDA #$1801             ;\
$80:9397 8D 10 43    STA $4310  [$7E:4310]  ;} DMA 1 control / target = 16-bit VRAM data write
$80:939A B2 3C       LDA ($3C)  [$92:D0C5]  ;\
$80:939C 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:939F 85 14       STA $14    [$7E:0014]  ;} DMA 1 source address = [[$3C]]
$80:93A1 B1 3C       LDA ($3C),y[$92:D0C7]  ;|
$80:93A3 8D 14 43    STA $4314  [$7E:4314]  ;/
$80:93A6 C8          INY                    ;\
$80:93A7 B1 3C       LDA ($3C),y[$92:D0C8]  ;} DMA 1 size = [[$3C] + 3]
$80:93A9 8D 15 43    STA $4315  [$7E:4315]  ;/
$80:93AC 18          CLC                    ;\
$80:93AD 65 14       ADC $14    [$7E:0014]  ;} $14 = [DMA 1 source address] + [DMA 1 size]
$80:93AF 85 14       STA $14    [$7E:0014]  ;/
$80:93B1 C8          INY
$80:93B2 C8          INY
$80:93B3 8E 0B 42    STX $420B  [$7E:420B]  ; Enable DMA 1
$80:93B6 A9 00 61    LDA #$6100             ;\
$80:93B9 8D 16 21    STA $2116  [$7E:2116]  ;} VRAM address = $6100
$80:93BC A5 14       LDA $14    [$7E:0014]  ;\
$80:93BE 8D 12 43    STA $4312  [$7E:4312]  ;} DMA 1 source address = [$14]
$80:93C1 B1 3C       LDA ($3C),y[$92:D0CA]  ;\
$80:93C3 F0 06       BEQ $06    [$93CB]     ;} If [[$3C] + 5] != 0:
$80:93C5 8D 15 43    STA $4315  [$7E:4315]  ; DMA 1 size = [[$3C] + 5]
$80:93C8 8E 0B 42    STX $420B  [$7E:420B]  ; Enable DMA 1

$80:93CB AC 1E 07    LDY $071E  [$7E:071E]  ;\
$80:93CE F0 44       BEQ $44    [$9414]     ;} If Samus bottom half tiles flagged for transfer:
$80:93D0 A0 02       LDY #$02
$80:93D2 AD 21 07    LDA $0721  [$7E:0721]  ;\
$80:93D5 85 3C       STA $3C    [$7E:003C]  ;} $3C = [Samus bottom half tiles definition]
$80:93D7 A9 80 60    LDA #$6080             ;\
$80:93DA 8D 16 21    STA $2116  [$7E:2116]  ;} VRAM address = $6080
$80:93DD A9 01 18    LDA #$1801             ;\
$80:93E0 8D 10 43    STA $4310  [$7E:4310]  ;} DMA 1 control / target = 16-bit VRAM data write
$80:93E3 B2 3C       LDA ($3C)  [$92:D1C8]  ;\
$80:93E5 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:93E8 85 14       STA $14    [$7E:0014]  ;} DMA 1 source address = [[$3C]]
$80:93EA B1 3C       LDA ($3C),y[$92:D1CA]  ;|
$80:93EC 8D 14 43    STA $4314  [$7E:4314]  ;/
$80:93EF C8          INY                    ;\
$80:93F0 B1 3C       LDA ($3C),y[$92:D1CB]  ;} DMA 1 size = [[$3C] + 3]
$80:93F2 8D 15 43    STA $4315  [$7E:4315]  ;/
$80:93F5 18          CLC                    ;\
$80:93F6 65 14       ADC $14    [$7E:0014]  ;} $14 = [DMA 1 source address] + [DMA 1 size]
$80:93F8 85 14       STA $14    [$7E:0014]  ;/
$80:93FA C8          INY
$80:93FB C8          INY
$80:93FC 8E 0B 42    STX $420B  [$7E:420B]  ; Enable DMA 1
$80:93FF A9 80 61    LDA #$6180             ;\
$80:9402 8D 16 21    STA $2116  [$7E:2116]  ;} VRAM address = $6180
$80:9405 A5 14       LDA $14    [$7E:0014]  ;\
$80:9407 8D 12 43    STA $4312  [$7E:4312]  ;} DMA 1 source address = [$14]
$80:940A B1 3C       LDA ($3C),y[$92:D1CD]  ;\
$80:940C F0 06       BEQ $06    [$9414]     ;} If [[$3C] + 5] != 0:
$80:940E 8D 15 43    STA $4315  [$7E:4315]  ; DMA 1 size = [[$3C] + 5]
$80:9411 8E 0B 42    STX $420B  [$7E:420B]  ; Enable DMA 1

$80:9414 AB          PLB
$80:9415 60          RTS
}


;;; $9416: Process animated tiles object VRAM transfers ;;;
{
$80:9416 8B          PHB
$80:9417 A2 87       LDX #$87               ;\
$80:9419 DA          PHX                    ;} DB = $87
$80:941A AB          PLB                    ;/
$80:941B AD F1 1E    LDA $1EF1  [$7E:1EF1]  ;\
$80:941E 10 37       BPL $37    [$9457]     ;} If animated tiles objects are disabled: return
$80:9420 A2 0A       LDX #$0A               ; X = Ah (animated tiles object index)

; LOOP
$80:9422 BD F5 1E    LDA $1EF5,x[$7E:1EFF]  ;\
$80:9425 F0 2C       BEQ $2C    [$9453]     ;} If [animated tiles object ID] != 0:
$80:9427 BD 25 1F    LDA $1F25,x[$7E:1F2F]  ;\
$80:942A F0 27       BEQ $27    [$9453]     ;} If [animated tiles object source address] != 0:
$80:942C 8D 02 43    STA $4302  [$7E:4302]  ;\
$80:942F A0 87       LDY #$87               ;} DMA 0 source address = $87:0000 + [animated tiles object source address]
$80:9431 8C 04 43    STY $4304  [$7E:4304]  ;/
$80:9434 A9 01 18    LDA #$1801             ;\
$80:9437 8D 00 43    STA $4300  [$7E:4300]  ;} DMA 0 control / target = 16-bit VRAM write
$80:943A BD 31 1F    LDA $1F31,x[$7E:1F3B]  ;\
$80:943D 8D 05 43    STA $4305  [$7E:4305]  ;} DMA 0 size = [animated tiles object size]
$80:9440 BD 3D 1F    LDA $1F3D,x[$7E:1F47]  ;\
$80:9443 8D 16 21    STA $2116  [$7E:2116]  ;} VRAM write address = [animated tiles object VRAM address]
$80:9446 A0 80       LDY #$80               ;\
$80:9448 8C 15 21    STY $2115  [$7E:2115]  ;} VRAM address increment mode = 16-bit access
$80:944B A0 01       LDY #$01               ;\
$80:944D 8C 0B 42    STY $420B  [$7E:420B]  ;} Enable DMA 0
$80:9450 9E 25 1F    STZ $1F25,x[$7E:1F2F]  ; Animated tiles object source address = 0

$80:9453 CA          DEX                    ;\
$80:9454 CA          DEX                    ;} X -= 2 (next animated tiles object index)
$80:9455 10 CB       BPL $CB    [$9422]     ; If [X] >= 0: go to LOOP

$80:9457 AB          PLB
$80:9458 60          RTS
}


;;; $9459: Read controller input. Also a debug branch ;;;
{
; This is executed at the end of NMI because auto-joypad read is only guaranteed to be executed at some point in the middle of the first scanline of v-blank,
; and then we need to wait ~3 scanlines for the joypad to finish reading
$80:9459 08          PHP
$80:945A E2 20       SEP #$20

$80:945C AD 12 42    LDA $4212  [$7E:4212]  ;\
$80:945F 29 01       AND #$01               ;} Wait until auto-joypad read has finished
$80:9461 D0 F9       BNE $F9    [$945C]     ;/
$80:9463 C2 20       REP #$20
$80:9465 AD 18 42    LDA $4218  [$7E:4218]  ;\
$80:9468 85 8B       STA $8B    [$7E:008B]  ;} Controller 1 input = [IO controller 1 input]
$80:946A 45 97       EOR $97    [$7E:0097]  ;\
$80:946C 25 8B       AND $8B    [$7E:008B]  ;} Newly pressed controller 1 input = [controller 1 input] & ~[previous controller 1 input]
$80:946E 85 8F       STA $8F    [$7E:008F]  ;/
$80:9470 85 93       STA $93    [$7E:0093]  ; Fake newly pressed controller 1 input = [newly pressed controller 1 input]
$80:9472 A5 8B       LDA $8B    [$7E:008B]  ;\
$80:9474 F0 12       BEQ $12    [$9488]     ;} If pressing nothing: go to BRANCH_UNHELD
$80:9476 C5 97       CMP $97    [$7E:0097]  ;\
$80:9478 D0 0E       BNE $0E    [$9488]     ;} If [controller 1 input] != [previous controller 1 input]: go to BRANCH_UNHELD
$80:947A C6 A3       DEC $A3    [$7E:00A3]  ; Decrement controller 1 auto-press timer
$80:947C D0 0E       BNE $0E    [$948C]     ; If [controller 1 auto-press timer] != 0: go to BRANCH_HELD_END
$80:947E A5 8B       LDA $8B    [$7E:008B]  ;\
$80:9480 85 93       STA $93    [$7E:0093]  ;} Fake newly pressed controller 1 input = [controller 1 input]
$80:9482 A5 89       LDA $89    [$7E:0089]  ;\
$80:9484 85 A3       STA $A3    [$7E:00A3]  ;} Controller 1 auto-press timer = [auto-press subsequent delay]
$80:9486 80 04       BRA $04    [$948C]     ; Go to BRANCH_HELD_END

; BRANCH_UNHELD
$80:9488 A5 87       LDA $87    [$7E:0087]  ;\
$80:948A 85 A3       STA $A3    [$7E:00A3]  ;} Controller 1 auto-press timer = [auto-press initial delay]

; BRANCH_HELD_END
$80:948C A5 8B       LDA $8B    [$7E:008B]  ;\
$80:948E 85 97       STA $97    [$7E:0097]  ;} Previous controller 1 input = [controller 1 input]
$80:9490 AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$80:9493 D0 02       BNE $02    [$9497]     ;} If debug not enabled:
$80:9495 28          PLP                    ;\
$80:9496 6B          RTL                    ;} Return

; Debug branch
$80:9497 AD 1A 42    LDA $421A  [$7E:421A]  ;\
$80:949A 85 8D       STA $8D    [$7E:008D]  ;} Controller 2 input = [IO controller 2 input]
$80:949C 45 99       EOR $99    [$7E:0099]  ;\
$80:949E 25 8D       AND $8D    [$7E:008D]  ;} Newly pressed controller 2 input = [controller 2 input] & ~[previous controller 2 input]
$80:94A0 85 91       STA $91    [$7E:0091]  ;/
$80:94A2 85 95       STA $95    [$7E:0095]  ; Fake newly pressed controller 2 input = [newly pressed controller 2 input]
$80:94A4 A5 8D       LDA $8D    [$7E:008D]  ;\
$80:94A6 F0 12       BEQ $12    [$94BA]     ;} If [controller 2 input] = 0: go to BRANCH_UNHELD_2
$80:94A8 C5 99       CMP $99    [$7E:0099]  ;\
$80:94AA D0 0E       BNE $0E    [$94BA]     ;} If [controller 2 input] != [previous controller 2 input]: go to BRANCH_UNHELD_2
$80:94AC C6 A5       DEC $A5    [$7E:00A5]  ; Decrement controller 2 auto-press timer
$80:94AE D0 0E       BNE $0E    [$94BE]     ; If [controller 2 auto-press timer] != 0: go to BRANCH_HELD_2_END
$80:94B0 A5 8D       LDA $8D    [$7E:008D]  ;\
$80:94B2 85 95       STA $95    [$7E:0095]  ;} Fake newly pressed controller 2 input = [controller 2 input]
$80:94B4 A5 89       LDA $89    [$7E:0089]  ;\
$80:94B6 85 A5       STA $A5    [$7E:00A5]  ;} Controller 2 auto-press timer = [auto-press subsequent delay]
$80:94B8 80 04       BRA $04    [$94BE]     ; Go to BRANCH_HELD_2_END

; BRANCH_UNHELD_2
$80:94BA A5 87       LDA $87    [$7E:0087]  ;\
$80:94BC 85 A5       STA $A5    [$7E:00A5]  ;} Controller 2 auto-press timer = [auto-press initial delay]

; BRANCH_HELD_2_END
$80:94BE A5 8D       LDA $8D    [$7E:008D]  ;\
$80:94C0 85 99       STA $99    [$7E:0099]  ;} Previous controller 2 input = [controller 2 input]
$80:94C2 AD 17 06    LDA $0617  [$7E:0617]  ;\
$80:94C5 D0 0D       BNE $0D    [$94D4]     ;} If not uploading to APU:
$80:94C7 A5 8B       LDA $8B    [$7E:008B]  ;\
$80:94C9 C9 30 30    CMP #$3030             ;} If pressing exactly sSLR:
$80:94CC D0 06       BNE $06    [$94D4]     ;/
$80:94CE 9C F5 05    STZ $05F5  [$7E:05F5]  ; Enable sounds
$80:94D1 4C 62 84    JMP $8462  [$80:8462]  ; Go to soft reset

$80:94D4 AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$80:94D7 D0 0F       BNE $0F    [$94E8]     ;} If debug mode not enabled:
$80:94D9 9C C5 05    STZ $05C5  [$7E:05C5]  ;\
$80:94DC 9C C7 05    STZ $05C7  [$7E:05C7]  ;|
$80:94DF A9 EF FF    LDA #$FFEF             ;|
$80:94E2 14 8D       TRB $8D    [$7E:008D]  ;} >_<
$80:94E4 14 91       TRB $91    [$7E:0091]  ;|
$80:94E6 28          PLP                    ;|
$80:94E7 6B          RTL                    ;/

$80:94E8 9C C5 05    STZ $05C5  [$7E:05C5]  ; $05C5 = 0 (newly pressed controller 1 input when select + L is pressed)
$80:94EB 9C C7 05    STZ $05C7  [$7E:05C7]  ; $05C7 = 0 (newly pressed controller 1 input when select + R is pressed)
$80:94EE 2C CF 05    BIT $05CF  [$7E:05CF]  ;\
$80:94F1 50 03       BVC $03    [$94F6]     ;} If [debug options] & 4000h != 0: (debug controller input processing is disabled)
$80:94F3 4C 81 95    JMP $9581  [$80:9581]  ; Return

$80:94F6 A5 8B       LDA $8B    [$7E:008B]  ;\
$80:94F8 29 20 20    AND #$2020             ;|
$80:94FB C9 20 20    CMP #$2020             ;} If pressing select and L:
$80:94FE D0 09       BNE $09    [$9509]     ;/
$80:9500 A5 8F       LDA $8F    [$7E:008F]  ;\
$80:9502 8D C5 05    STA $05C5  [$7E:05C5]  ;} $05C5 = [newly pressed input]
$80:9505 64 8B       STZ $8B    [$7E:008B]  ; Controller 1 input = 0
$80:9507 64 8F       STZ $8F    [$7E:008F]  ; Controller 1 newly pressed input = 0

$80:9509 A5 8B       LDA $8B    [$7E:008B]  ;\
$80:950B 29 10 20    AND #$2010             ;|
$80:950E C9 10 20    CMP #$2010             ;} If pressing select and R:
$80:9511 D0 0C       BNE $0C    [$951F]     ;/
$80:9513 A5 8F       LDA $8F    [$7E:008F]  ;\
$80:9515 8D C7 05    STA $05C7  [$7E:05C7]  ;} $05C7 = [newly pressed input]
$80:9518 A9 F0 E0    LDA #$E0F0             ; >_<
$80:951B 64 8B       STZ $8B    [$7E:008B]  ; Controller 1 input = 0
$80:951D 64 8F       STZ $8F    [$7E:008F]  ; Newly pressed controller 1 input = 0

$80:951F AD C7 05    LDA $05C7  [$7E:05C7]  ;\
$80:9522 89 80 00    BIT #$0080             ;} If [$05C7] & A:
$80:9525 F0 07       BEQ $07    [$952E]     ;/
$80:9527 A5 84       LDA $84    [$7E:0084]  ;\
$80:9529 49 30 00    EOR #$0030             ;} Toggle IRQ (toggle HUD display)
$80:952C 85 84       STA $84    [$7E:0084]  ;/

$80:952E AD C7 05    LDA $05C7  [$7E:05C7]  ;\
$80:9531 89 00 80    BIT #$8000             ;} If [$05C7] & B = 0: go to BRANCH_SWAP_END
$80:9534 F0 3A       BEQ $3A    [$9570]     ;/
$80:9536 AD CF 05    LDA $05CF  [$7E:05CF]  ;\
$80:9539 49 00 80    EOR #$8000             ;} Debug options ^= 8000h (ammo is swapped flag)
$80:953C 8D CF 05    STA $05CF  [$7E:05CF]  ;/
$80:953F 10 1D       BPL $1D    [$955E]     ; If [debug options] & 8000h != 0: (ammo is swapped)
$80:9541 AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$80:9544 8D C9 05    STA $05C9  [$7E:05C9]  ;} Missiles swap = [Samus missiles]
$80:9547 AD CA 09    LDA $09CA  [$7E:09CA]  ;\
$80:954A 8D CB 05    STA $05CB  [$7E:05CB]  ;} Super missiles swap = [Samus super missiles]
$80:954D AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$80:9550 8D CD 05    STA $05CD  [$7E:05CD]  ;} Power bombs swap = [Samus power bombs]
$80:9553 9C C6 09    STZ $09C6  [$7E:09C6]  ; Samus missiles = 0
$80:9556 9C CA 09    STZ $09CA  [$7E:09CA]  ; Samus super missiles = 0
$80:9559 9C CE 09    STZ $09CE  [$7E:09CE]  ; Samus power bombs = 0
$80:955C 80 12       BRA $12    [$9570]

$80:955E AD C9 05    LDA $05C9  [$7E:05C9]  ;\ Else ([debug options] & 8000h = 0): (ammo is not swapped)
$80:9561 8D C6 09    STA $09C6  [$7E:09C6]  ;} Samus missiles = [missiles swap]
$80:9564 AD CB 05    LDA $05CB  [$7E:05CB]  ;\
$80:9567 8D CA 09    STA $09CA  [$7E:09CA]  ;} Samus super missiles = [super missiles swap]
$80:956A AD CD 05    LDA $05CD  [$7E:05CD]  ;\
$80:956D 8D CE 09    STA $09CE  [$7E:09CE]  ;} Samus power bombs = [power bombs swap]

; BRANCH_SWAP_END
$80:9570 AD C7 05    LDA $05C7  [$7E:05C7]  ;\
$80:9573 89 40 00    BIT #$0040             ;} If [$05C7] & X = 0: return
$80:9576 F0 09       BEQ $09    [$9581]     ;/
$80:9578 AD CF 05    LDA $05CF  [$7E:05CF]  ;\
$80:957B 49 00 20    EOR #$2000             ;} Debug options ^= 2000h (X is pressed whilst select + R is held)
$80:957E 8D CF 05    STA $05CF  [$7E:05CF]  ;/

$80:9581 28          PLP
$80:9582 6B          RTL
}


;;; $9583: NMI ;;;
{
$80:9583 C2 30       REP #$30
$80:9585 5C 89 95 80 JML $809589[$80:9589]  ; Execute in bank $80 (FastROM)
$80:9589 8B          PHB
$80:958A 0B          PHD
$80:958B 48          PHA
$80:958C DA          PHX
$80:958D 5A          PHY
$80:958E 4B          PHK                    ;\
$80:958F AB          PLB                    ;} DB = $80
$80:9590 A9 00 00    LDA #$0000             ;\
$80:9593 5B          TCD                    ;} DP = $0000
$80:9594 E2 10       SEP #$10
$80:9596 AE 10 42    LDX $4210  [$7E:4210]  ; Read RDNMI, resetting the NMI request signal
$80:9599 AE B4 05    LDX $05B4  [$7E:05B4]  ;\
$80:959C F0 64       BEQ $64    [$9602]     ;} If NMI not requested: go to BRANCH_LAG
$80:959E 20 3A 93    JSR $933A  [$80:933A]  ; Update OAM & CGRAM
$80:95A1 20 76 93    JSR $9376  [$80:9376]  ; Transfer Samus tiles to VRAM
$80:95A4 20 16 94    JSR $9416  [$80:9416]  ; Process animated tiles object VRAM transfers
$80:95A7 20 EE 91    JSR $91EE  [$80:91EE]  ; Update IO registers
$80:95AA A2 00       LDX #$00               ;\
                                            ;|
$80:95AC BD B4 18    LDA $18B4,x[$7E:18B4]  ;|
$80:95AF F0 09       BEQ $09    [$95BA]     ;|
$80:95B1 BC C0 18    LDY $18C0,x[$7E:18C0]  ;|
$80:95B4 BD D8 18    LDA $18D8,x[$7E:18D8]  ;|
$80:95B7 99 02 43    STA $4302,y[$7E:4322]  ;} Handle HDMA queue
                                            ;|
$80:95BA E8          INX                    ;|
$80:95BB E8          INX                    ;|
$80:95BC E0 0C       CPX #$0C               ;|
$80:95BE D0 EC       BNE $EC    [$95AC]     ;/
$80:95C0 A6 55       LDX $55    [$7E:0055]  ;\
$80:95C2 E0 07       CPX #$07               ;|
$80:95C4 F0 06       BEQ $06    [$95CC]     ;|
$80:95C6 A6 56       LDX $56    [$7E:0056]  ;} If mode 7 enabled:
$80:95C8 E0 07       CPX #$07               ;|
$80:95CA D0 04       BNE $04    [$95D0]     ;/

$80:95CC 22 BA 8B 80 JSL $808BBA[$80:8BBA]  ; Handle mode 7 transfers

$80:95D0 22 83 8C 80 JSL $808C83[$80:8C83]  ; Handle VRAM write table and scrolling DMAs
$80:95D4 22 A2 8E 80 JSL $808EA2[$80:8EA2]  ; Handle VRAM read table
$80:95D8 E2 10       SEP #$10
$80:95DA C2 20       REP #$20
$80:95DC A6 85       LDX $85    [$7E:0085]  ;\
$80:95DE 8E 0C 42    STX $420C  [$7E:420C]  ;} Enable HDMA
$80:95E1 22 59 94 80 JSL $809459[$80:9459]  ; Read controller input. Also a debug branch
$80:95E5 A2 00       LDX #$00               ;\
$80:95E7 8E B4 05    STX $05B4  [$7E:05B4]  ;} NMI request flag = 0
$80:95EA 8E BA 05    STX $05BA  [$7E:05BA]  ; Lag counter = 0
$80:95ED AE B5 05    LDX $05B5  [$7E:05B5]  ;\
$80:95F0 E8          INX                    ;} Increment 8-bit counter
$80:95F1 8E B5 05    STX $05B5  [$7E:05B5]  ;/
$80:95F4 EE B6 05    INC $05B6  [$7E:05B6]  ; Increment 16-bit counter

; BRANCH_RETURN
$80:95F7 C2 30       REP #$30
$80:95F9 EE B8 05    INC $05B8  [$7E:05B8]  ; Increment NMI counter
$80:95FC 7A          PLY
$80:95FD FA          PLX
$80:95FE 68          PLA
$80:95FF 2B          PLD
$80:9600 AB          PLB
$80:9601 40          RTI

; BRANCH_LAG
$80:9602 AE BA 05    LDX $05BA  [$7E:05BA]  ;\
$80:9605 E8          INX                    ;} Increment lag counter
$80:9606 8E BA 05    STX $05BA  [$7E:05BA]  ;/
$80:9609 AE BA 05    LDX $05BA  [$7E:05BA]  ; >_<
$80:960C EC BB 05    CPX $05BB  [$7E:05BB]  ;\
$80:960F 90 E6       BCC $E6    [$95F7]     ;|
$80:9611 8E BB 05    STX $05BB  [$7E:05BB]  ;} Maximum lag = max([maximum lag], [lag counter]) and go to BRANCH_RETURN
$80:9614 80 E1       BRA $E1    [$95F7]     ;/
}


;;; $9616: Interrupt command pointers ;;;
{
$80:9616             dw 966E, 9680, 968B, 96A9, 96D3, 96F1, 971A, 9733, 9758, 9771, 97A9, 97C1, 97DA, 980A
}


;;; $9632: Execute door transition VRAM update ;;;
{
; Called by:
;     $9771: Interrupt command 12h. Vertical door transition, screen drawing
;     $980A: Interrupt command 1Ah. Horizontal door transition, screen drawn
$80:9632 E2 20       SEP #$20
$80:9634 A9 80       LDA #$80               ;\
$80:9636 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank
$80:9639 AE BE 05    LDX $05BE  [$7E:05BE]  ;\
$80:963C 8E 16 21    STX $2116  [$7E:2116]  ;} VRAM address = [door transition VRAM update destination]
$80:963F A2 01 18    LDX #$1801             ;\
$80:9642 8E 10 43    STX $4310  [$7E:4310]  ;} DMA 1 control / target = 16-bit VRAM write
$80:9645 AE C0 05    LDX $05C0  [$7E:05C0]  ;\
$80:9648 8E 12 43    STX $4312  [$7E:4312]  ;|
$80:964B AD C2 05    LDA $05C2  [$7E:05C2]  ;} DMA 1 source address = [door transition VRAM update source]
$80:964E 8D 14 43    STA $4314  [$7E:4314]  ;/
$80:9651 AE C3 05    LDX $05C3  [$7E:05C3]  ;\
$80:9654 8E 15 43    STX $4315  [$7E:4315]  ;} DMA 1 size = [door transition VRAM update size]
$80:9657 A9 80       LDA #$80               ;\
$80:9659 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM address increment mode = 16-bit access
$80:965C A9 02       LDA #$02               ;\
$80:965E 8D 0B 42    STA $420B  [$7E:420B]  ;} Execute DMA 1
$80:9661 A9 80       LDA #$80               ;\
$80:9663 1C BD 05    TRB $05BD  [$7E:05BD]  ;} Door transition VRAM update flag = 0
$80:9666 A9 0F       LDA #$0F               ;\
$80:9668 8D 00 21    STA $2100  [$7E:2100]  ;} Disable forced blank
$80:966B C2 20       REP #$20
$80:966D 60          RTS
}


;;; $966E..9829: Interrupt commands ;;;
{
;;; $966E: Interrupt command 0 - nothing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:966E A5 A7       LDA $A7    [$7E:00A7]  ; Interrupt command = [next interrupt command]
$80:9670 F0 04       BEQ $04    [$9676]
$80:9672 64 A7       STZ $A7    [$7E:00A7]  ; Next interrupt command = 0
$80:9674 80 03       BRA $03    [$9679]

$80:9676 A9 00 00    LDA #$0000

$80:9679 A2 00 00    LDX #$0000             ; IRQ h-counter target = 0
$80:967C A0 00 00    LDY #$0000             ; IRQ v-counter target = 0
$80:967F 60          RTS
}


;;; $9680: Interrupt command 2 - disable h/v-counter interrupts ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:9680 A9 30 00    LDA #$0030             ;\
$80:9683 14 84       TRB $84    [$7E:0084]  ;} Disable h/v-counter interrupts
$80:9685 A9 00 00    LDA #$0000             ; Interrupt command = 0
$80:9688 AA          TAX                    ; IRQ h-counter target = 0
$80:9689 A8          TAY                    ; IRQ v-counter target = 0
$80:968A 60          RTS
}


;;; $968B: Interrupt command 4 - main gameplay - begin HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:968B E2 20       SEP #$20
$80:968D A9 5A       LDA #$5A               ;\
$80:968F 8D 09 21    STA $2109  [$7E:2109]  ;} BG3 tilemap base address = $5800, size = 32x64
$80:9692 9C 30 21    STZ $2130  [$7E:2130]  ;\
$80:9695 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$80:9698 A9 04       LDA #$04               ;\
$80:969A 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG3
$80:969D C2 20       REP #$20
$80:969F A9 06 00    LDA #$0006             ; Interrupt command = 6
$80:96A2 A0 1F 00    LDY #$001F             ; IRQ v-counter target = 1Fh
$80:96A5 A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:96A8 60          RTS
}


;;; $96A9: Interrupt command 6 - main gameplay - end HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:96A9 E2 20       SEP #$20
$80:96AB A5 70       LDA $70    [$7E:0070]  ;\
$80:96AD 8D 30 21    STA $2130  [$7E:2130]  ;} Colour math control register A = [gameplay colour math control register A]
$80:96B0 A5 73       LDA $73    [$7E:0073]  ;\
$80:96B2 8D 31 21    STA $2131  [$7E:2131]  ;} Colour math control register B = [gameplay colour math control register B]
$80:96B5 A5 5B       LDA $5B    [$7E:005B]  ;\
$80:96B7 8D 09 21    STA $2109  [$7E:2109]  ;} BG3 tilemap base address and size = [gameplay BG3 tilemap base address and size]
$80:96BA A5 6A       LDA $6A    [$7E:006A]  ;\
$80:96BC 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = [gameplay main screen layers]
$80:96BF C2 20       REP #$20
$80:96C1 A5 A7       LDA $A7    [$7E:00A7]  ; Interrupt command = [next interrupt command]
$80:96C3 F0 04       BEQ $04    [$96C9]     ; If [next interrupt command] != 0:
$80:96C5 64 A7       STZ $A7    [$7E:00A7]  ; Next interrupt command = 0
$80:96C7 80 03       BRA $03    [$96CC]
                                            ; Else ([next interrupt command] = 0):
$80:96C9 A9 04 00    LDA #$0004             ; Interrupt command = 4

$80:96CC A0 00 00    LDY #$0000             ; IRQ v-counter target = 0
$80:96CF A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:96D2 60          RTS
}


;;; $96D3: Interrupt command 8 - start of door transition - begin HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:96D3 E2 20       SEP #$20
$80:96D5 A9 5A       LDA #$5A               ;\
$80:96D7 8D 09 21    STA $2109  [$7E:2109]  ;} BG3 tilemap base address = $5800, size = 32x64
$80:96DA A9 04       LDA #$04               ;\
$80:96DC 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG3
$80:96DF 9C 30 21    STZ $2130  [$7E:2130]  ;\
$80:96E2 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$80:96E5 C2 20       REP #$20
$80:96E7 A9 0A 00    LDA #$000A             ; Interrupt command = Ah
$80:96EA A0 1F 00    LDY #$001F             ; IRQ v-counter target = 1Fh
$80:96ED A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:96F0 60          RTS
}


;;; $96F1: Interrupt command Ah - start of door transition - end HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:96F1 E2 20       SEP #$20
$80:96F3 AD B3 07    LDA $07B3  [$7E:07B3]  ;\
$80:96F6 0D B1 07    ORA $07B1  [$7E:07B1]  ;|
$80:96F9 89 01       BIT #$01               ;} If ([CRE bitset] | [previous CRE bitset]) & 1 != 0:
$80:96FB F0 04       BEQ $04    [$9701]     ;/
$80:96FD A9 10       LDA #$10               ;\
$80:96FF 80 02       BRA $02    [$9703]     ;} Main screen layers = sprites

                                            ; Else (([CRE bitset] | [previous CRE bitset]) & 1 = 0):
$80:9701 A9 11       LDA #$11               ; Main screen layers = BG1/sprites

$80:9703 8D 2C 21    STA $212C  [$7E:212C]
$80:9706 C2 20       REP #$20
$80:9708 A5 A7       LDA $A7    [$7E:00A7]  ; Interrupt command = [next interrupt command]
$80:970A F0 04       BEQ $04    [$9710]     ; If [next interrupt command] != 0:
$80:970C 64 A7       STZ $A7    [$7E:00A7]  ; Next interrupt command = 0
$80:970E 80 03       BRA $03    [$9713]
                                            ; Else ([next interrupt command] = 0):
$80:9710 A9 08 00    LDA #$0008             ; Interrupt command = 8

$80:9713 A0 00 00    LDY #$0000             ; IRQ v-counter target = 0
$80:9716 A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:9719 60          RTS
}


;;; $971A: Interrupt command Ch - Draygon's room - begin HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

; Compared to interrupt command 4, this one doesn't set BG3 tilemap base address and size
$80:971A E2 20       SEP #$20
$80:971C A9 04       LDA #$04               ;\
$80:971E 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG3
$80:9721 9C 30 21    STZ $2130  [$7E:2130]  ;\
$80:9724 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$80:9727 C2 20       REP #$20
$80:9729 A9 0E 00    LDA #$000E             ; Interrupt command = Eh
$80:972C A0 1F 00    LDY #$001F             ; IRQ v-counter target = 1Fh
$80:972F A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:9732 60          RTS
}


;;; $9733: Interrupt command Eh - Draygon's room - end HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

; Compared to interrupt command 6, this one doesn't set the main screen layers
$80:9733 E2 20       SEP #$20
$80:9735 A5 5B       LDA $5B    [$7E:005B]  ;\
$80:9737 8D 09 21    STA $2109  [$7E:2109]  ;} BG3 tilemap base address and size = [gameplay BG3 tilemap base address and size]
$80:973A A5 70       LDA $70    [$7E:0070]  ;\
$80:973C 8D 30 21    STA $2130  [$7E:2130]  ;} Colour math control register A = [gameplay colour math control register A]
$80:973F A5 73       LDA $73    [$7E:0073]  ;\
$80:9741 8D 31 21    STA $2131  [$7E:2131]  ;} Colour math control register B = [gameplay colour math control register B]
$80:9744 C2 20       REP #$20
$80:9746 A5 A7       LDA $A7    [$7E:00A7]  ; Interrupt command = [next interrupt command]
$80:9748 F0 04       BEQ $04    [$974E]     ; If [next interrupt command] != 0:
$80:974A 64 A7       STZ $A7    [$7E:00A7]  ; Next interrupt command = 0
$80:974C 80 03       BRA $03    [$9751]
                                            ; Else ([next interrupt command] = 0):
$80:974E A9 0C 00    LDA #$000C             ; Interrupt command = Ch

$80:9751 A0 00 00    LDY #$0000             ; IRQ v-counter target = 0
$80:9754 A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:9757 60          RTS
}


;;; $9758: Interrupt command 10h - vertical door transition - begin HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:9758 E2 20       SEP #$20
$80:975A A9 04       LDA #$04               ;\
$80:975C 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG3
$80:975F 9C 30 21    STZ $2130  [$7E:2130]  ;\
$80:9762 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$80:9765 C2 20       REP #$20
$80:9767 A9 12 00    LDA #$0012             ; Interrupt command = 12h
$80:976A A0 1F 00    LDY #$001F             ; IRQ v-counter target = 1Fh
$80:976D A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:9770 60          RTS
}


;;; $9771: Interrupt command 12h - vertical door transition - end HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:9771 E2 20       SEP #$20
$80:9773 AD B3 07    LDA $07B3  [$7E:07B3]  ;\
$80:9776 0D B1 07    ORA $07B1  [$7E:07B1]  ;|
$80:9779 89 01       BIT #$01               ;} If ([CRE bitset] | [previous CRE bitset]) & 1 != 0:
$80:977B F0 04       BEQ $04    [$9781]     ;/
$80:977D A9 10       LDA #$10               ;\
$80:977F 80 02       BRA $02    [$9783]     ;} Main screen layers = sprites

                                            ; Else (([CRE bitset] | [previous CRE bitset]) & 1 = 0):
$80:9781 A9 11       LDA #$11               ; Main screen layers = BG1/sprites

$80:9783 8D 2C 21    STA $212C  [$7E:212C]
$80:9786 9C 30 21    STZ $2130  [$7E:2130]  ;\
$80:9789 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$80:978C C2 20       REP #$20
$80:978E AE BC 05    LDX $05BC  [$7E:05BC]  ;\
$80:9791 10 03       BPL $03    [$9796]     ;} If door transition VRAM update:
$80:9793 20 32 96    JSR $9632  [$80:9632]  ; Execute door transition VRAM update

$80:9796 AD 31 09    LDA $0931  [$7E:0931]  ;\
$80:9799 30 04       BMI $04    [$979F]     ;} If door transition has not finished scrolling:
$80:979B 22 4E AE 80 JSL $80AE4E[$80:AE4E]  ; Door transition scrolling

$80:979F A9 14 00    LDA #$0014             ; Interrupt command = 14h
$80:97A2 A0 D8 00    LDY #$00D8             ; IRQ v-counter target = D8h
$80:97A5 A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:97A8 60          RTS
}


;;; $97A9: Interrupt command 14h - vertical door transition - end drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:97A9 A5 A7       LDA $A7    [$7E:00A7]  ; Interrupt command = [next interrupt command]
$80:97AB F0 04       BEQ $04    [$97B1]     ; If [next interrupt command] != 0:
$80:97AD 64 A7       STZ $A7    [$7E:00A7]  ; Next interrupt command = 0
$80:97AF 80 03       BRA $03    [$97B4]
                                            ; Else ([next interrupt command] = 0):
$80:97B1 A9 10 00    LDA #$0010             ; Interrupt command = 10h

$80:97B4 A0 00 00    LDY #$0000             ; IRQ v-counter target = 0
$80:97B7 A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:97BA 9C B4 05    STZ $05B4  [$7E:05B4]  ;\
$80:97BD EE B4 05    INC $05B4  [$7E:05B4]  ;} NMI request flag = 1, 8-bit frame counter = 0
$80:97C0 60          RTS
}


;;; $97C1: Interrupt command 16h - horizontal door transition - begin HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:97C1 E2 20       SEP #$20
$80:97C3 A9 04       LDA #$04               ;\
$80:97C5 8D 2C 21    STA $212C  [$7E:212C]  ;} Main screen layers = BG3
$80:97C8 9C 30 21    STZ $2130  [$7E:2130]  ;\
$80:97CB 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$80:97CE C2 20       REP #$20
$80:97D0 A9 18 00    LDA #$0018             ; Interrupt command = 18h
$80:97D3 A0 1F 00    LDY #$001F             ; IRQ v-counter target = 1Fh
$80:97D6 A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:97D9 60          RTS
}


;;; $97DA: Interrupt command 18h - horizontal door transition - end HUD drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:97DA E2 20       SEP #$20
$80:97DC AD B3 07    LDA $07B3  [$7E:07B3]  ;\
$80:97DF 0D B1 07    ORA $07B1  [$7E:07B1]  ;|
$80:97E2 89 01       BIT #$01               ;} If ([CRE bitset] | [previous CRE bitset]) & 1 != 0:
$80:97E4 F0 04       BEQ $04    [$97EA]     ;/
$80:97E6 A9 10       LDA #$10               ;\
$80:97E8 80 02       BRA $02    [$97EC]     ;} Main screen layers = sprites

                                            ; Else (([CRE bitset] | [previous CRE bitset]) & 1 = 0):
$80:97EA A9 11       LDA #$11               ; Main screen layers = BG1/sprites

$80:97EC 8D 2C 21    STA $212C  [$7E:212C]
$80:97EF 9C 30 21    STZ $2130  [$7E:2130]  ;\
$80:97F2 9C 31 21    STZ $2131  [$7E:2131]  ;} Disable colour math
$80:97F5 C2 20       REP #$20
$80:97F7 AD 31 09    LDA $0931  [$7E:0931]  ;\
$80:97FA 30 04       BMI $04    [$9800]     ;} If door transition has not finished scrolling:
$80:97FC 22 4E AE 80 JSL $80AE4E[$80:AE4E]  ; Door transition scrolling

$80:9800 A9 1A 00    LDA #$001A             ; Interrupt command = 1Ah
$80:9803 A0 A0 00    LDY #$00A0             ; IRQ v-counter target = A0h (bottom of door)
$80:9806 A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:9809 60          RTS
}


;;; $980A: Interrupt command 1Ah - horizontal door transition - end drawing ;;;
{
;; Returns:
;;     A: Interrupt command
;;     X: IRQ h-counter target
;;     Y: IRQ v-counter target

$80:980A AE BC 05    LDX $05BC  [$7E:05BC]  ;\
$80:980D 10 03       BPL $03    [$9812]     ;} If door transition VRAM update:
$80:980F 20 32 96    JSR $9632  [$80:9632]  ; Execute door transition VRAM update

$80:9812 A5 A7       LDA $A7    [$7E:00A7]  ; Interrupt command = [next interrupt command]
$80:9814 F0 04       BEQ $04    [$981A]     ; If [next interrupt command] != 0:
$80:9816 64 A7       STZ $A7    [$7E:00A7]  ; Next interrupt command = 0
$80:9818 80 03       BRA $03    [$981D]
                                            ; Else ([next interrupt command] = 0):
$80:981A A9 16 00    LDA #$0016             ; Interrupt command = 16h

$80:981D A0 00 00    LDY #$0000             ; IRQ v-counter target = 0
$80:9820 A2 98 00    LDX #$0098             ; IRQ h-counter target = 98h
$80:9823 9C B4 05    STZ $05B4  [$7E:05B4]  ;\
$80:9826 EE B4 05    INC $05B4  [$7E:05B4]  ;} NMI request flag = 1, 8-bit frame counter = 0
$80:9829 60          RTS
}
}


;;; $982A: Enable h/v-counter interrupts ;;;
{
$80:982A 08          PHP
$80:982B C2 30       REP #$30
$80:982D A9 00 00    LDA #$0000             ;\
$80:9830 8D 09 42    STA $4209  [$7E:4209]  ;} IRQ v-counter target = 0
$80:9833 A9 98 00    LDA #$0098             ;\
$80:9836 8D 07 42    STA $4207  [$7E:4207]  ;} IRQ h-counter target = 98h
$80:9839 A9 30 00    LDA #$0030             ;\
$80:983C 04 84       TSB $84    [$7E:0084]  ;} Enable h/v-counter interrupts
$80:983E 28          PLP
$80:983F 58          CLI                    ; Enable IRQ
$80:9840 6B          RTL
}


;;; $9841: Enable h/v-counter interrupts now ;;;
{
$80:9841 08          PHP
$80:9842 C2 30       REP #$30
$80:9844 A9 00 00    LDA #$0000             ;\
$80:9847 8D 09 42    STA $4209  [$7E:4209]  ;} IRQ v-counter target = 0
$80:984A A9 98 00    LDA #$0098             ;\
$80:984D 8D 07 42    STA $4207  [$7E:4207]  ;} IRQ h-counter target = 98h
$80:9850 A9 30 00    LDA #$0030             ;\
$80:9853 04 84       TSB $84    [$7E:0084]  ;|
$80:9855 E2 20       SEP #$20               ;} Enable h/v-counter interrupts now
$80:9857 A5 84       LDA $84    [$7E:0084]  ;|
$80:9859 8D 00 42    STA $4200  [$7E:4200]  ;/
$80:985C 28          PLP
$80:985D 58          CLI                    ; Enable IRQ
$80:985E 6B          RTL
}


;;; $985F: Disable h/v-counter interrupts ;;;
{
$80:985F 08          PHP
$80:9860 C2 30       REP #$30
$80:9862 A9 30 00    LDA #$0030             ;\
$80:9865 14 84       TRB $84    [$7E:0084]  ;} Disable h/v-counter interrupts
$80:9867 28          PLP
$80:9868 78          SEI                    ; Disable IRQ
$80:9869 6B          RTL
}


;;; $986A: IRQ ;;;
{
; The first instruction of the routine called by the JSR (e.g. $966E) is executed 79 dots later than the IRQ h-counter target
; All of the (non-trivial) interrupt commands set IRQ h-counter = 98h, so that's 98h + 79 = 231 dots into the drawing period of the current scanline
; Also note that the IRQ timing is a bit loose. For the h-counter target 98h,
; I've seen the IRQ fire at all different points in the range 95h..A3h on different frames (according to Mesen-S event viewer)
$80:986A C2 30       REP #$30
$80:986C 5C 70 98 80 JML $809870[$80:9870]  ; Execute in bank $80 (FastROM)
$80:9870 8B          PHB
$80:9871 48          PHA
$80:9872 DA          PHX
$80:9873 5A          PHY
$80:9874 4B          PHK                    ;\
$80:9875 AB          PLB                    ;} DB = $80
$80:9876 AD 11 42    LDA $4211  [$7E:4211]  ; Acknowledge IRQ request
$80:9879 A6 AB       LDX $AB    [$7E:00AB]  ;\
$80:987B FC 16 96    JSR ($9616,x)[$80:966E];} Execute [$9616 + [interrupt command]]
$80:987E 85 AB       STA $AB    [$7E:00AB]  ; Interrupt command = [A]
$80:9880 8C 09 42    STY $4209  [$7E:4209]  ; IRQ v-counter target = [Y]
$80:9883 8E 07 42    STX $4207  [$7E:4207]  ; IRQ h-counter target = [X]
$80:9886 7A          PLY
$80:9887 FA          PLX
$80:9888 68          PLA
$80:9889 AB          PLB
$80:988A 40          RTI
}


;;; $988B..9DE6: HUD ;;;
{
;;; $988B: HUD tilemaps ;;;
{
; Top row, never changed
$80:988B             dw 2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C1D,2C1D,2C1D,2C1D,2C1D,2C1C

; Rows 1..3
$80:98CB             dw 2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C12,2C12,2C23,2C12,2C12,2C1E,
                        2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2822,2822,2823,2813,2C14,2C1E,
                        2C0F,2C0B,2C0C,2C0D,2C32,2C0F,2C09,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C0F,2C12,2C12,A824,2815,2C16,2C1E

; Auto reserve
$80:998B             dw                                         3C33,3C46,
                                                                3C47,3C48,
                                                                BC33,BC46

; Empty auto reserve
$80:9997             dw                                         2C33,2C46,
                                                                2C47,2C48,
                                                                AC33,AC46

; Missiles
$80:99A3             dw                                                   344B,3449,744B,
                                                                          344C,344A,744C

; Super missiles
$80:99AF             dw                                                                       3434,7434,
                                                                                              3435,7435

; Power bombs
$80:99B7             dw                                                                                      3436,7436,
                                                                                                             3437,7437

; Grapple
$80:99BF             dw                                                                                                     3438,7438,
                                                                                                                            3439,7439

; X-ray
$80:99C7             dw                                                                                                                    343A,743A,
                                                                                                                                           343B,743B
}


;;; $99CF: Add missiles to HUD tilemap ;;;
{
; Called by:
;     $9A79: Initialise HUD
;     $84:89A9: Instruction - collect [[Y]] ammo missile tank
;     $91:E355: Debug. Give ammo, all items and switch to next beam configuration if newly pressed B
$80:99CF 08          PHP
$80:99D0 8B          PHB
$80:99D1 4B          PHK                    ;\
$80:99D2 AB          PLB                    ;} DB = $80
$80:99D3 C2 30       REP #$30
$80:99D5 AF 1C C6 7E LDA $7EC61C[$7E:C61C]  ;\
$80:99D9 29 FF 03    AND #$03FF             ;|
$80:99DC C9 0F 00    CMP #$000F             ;} If missile tilemap is blank:
$80:99DF D0 2A       BNE $2A    [$9A0B]     ;/
$80:99E1 AD A3 99    LDA $99A3  [$80:99A3]  ;\
$80:99E4 8F 1C C6 7E STA $7EC61C[$7E:C61C]  ;|
$80:99E8 AD A5 99    LDA $99A5  [$80:99A5]  ;|
$80:99EB 8F 1E C6 7E STA $7EC61E[$7E:C61E]  ;} Write top row of missile icon
$80:99EF AD A7 99    LDA $99A7  [$80:99A7]  ;|
$80:99F2 8F 20 C6 7E STA $7EC620[$7E:C620]  ;/
$80:99F6 AD A9 99    LDA $99A9  [$80:99A9]  ;\
$80:99F9 8F 5C C6 7E STA $7EC65C[$7E:C65C]  ;|
$80:99FD AD AB 99    LDA $99AB  [$80:99AB]  ;|
$80:9A00 8F 5E C6 7E STA $7EC65E[$7E:C65E]  ;} Write bottom row of missile icon
$80:9A04 AD AD 99    LDA $99AD  [$80:99AD]  ;|
$80:9A07 8F 60 C6 7E STA $7EC660[$7E:C660]  ;/

$80:9A0B AB          PLB
$80:9A0C 28          PLP
$80:9A0D 6B          RTL
}


;;; $9A0E: Add super missiles to HUD tilemap ;;;
{
; Called by:
;     $9A79: Initialise HUD
;     $84:89D2: Instruction - collect [[Y]] ammo super missile tank
;     $91:E355: Debug. Give ammo, all items and switch to next beam configuration if newly pressed B
$80:9A0E 08          PHP
$80:9A0F DA          PHX
$80:9A10 5A          PHY
$80:9A11 8B          PHB
$80:9A12 4B          PHK                ;\
$80:9A13 AB          PLB                ;} DB = $80
$80:9A14 C2 30       REP #$30
$80:9A16 A0 AF 99    LDY #$99AF         ; Y = super missile HUD tilemap source address
$80:9A19 A2 1C 00    LDX #$001C         ; X = super missile HUD tilemap destination offset
$80:9A1C 80 2E       BRA $2E    [$9A4C] ; Write 2x2 tile icon to HUD tilemap
}


;;; $9A1E: Add power bombs to HUD tilemap ;;;
{
; Called by:
;     $9A79: Initialise HUD
;     $84:89FB: Instruction - collect [[Y]] ammo power bomb tank
;     $91:E355: Debug. Give ammo, all items and switch to next beam configuration if newly pressed B
$80:9A1E 08          PHP
$80:9A1F DA          PHX
$80:9A20 5A          PHY
$80:9A21 8B          PHB
$80:9A22 4B          PHK                ;\
$80:9A23 AB          PLB                ;} DB = $80
$80:9A24 C2 30       REP #$30
$80:9A26 A0 B7 99    LDY #$99B7         ; Y = power bomb HUD tilemap source address
$80:9A29 A2 22 00    LDX #$0022         ; X = power bomb HUD tilemap destination offset
$80:9A2C 80 1E       BRA $1E    [$9A4C] ; Write 2x2 tile icon to HUD tilemap
}


;;; $9A2E: Add grapple to HUD tilemap ;;;
{
; Called by:
;     $9A79: Initialise HUD
;     $84:891A: Instruction - pick up equipment [[Y]], add grapple to HUD and display grapple message box
;     $91:E355: Debug. Give ammo, all items and switch to next beam configuration if newly pressed B
$80:9A2E 08          PHP
$80:9A2F DA          PHX
$80:9A30 5A          PHY
$80:9A31 8B          PHB
$80:9A32 4B          PHK                ;\
$80:9A33 AB          PLB                ;} DB = $80
$80:9A34 C2 30       REP #$30
$80:9A36 A0 BF 99    LDY #$99BF         ; Y = grapple HUD tilemap source address
$80:9A39 A2 28 00    LDX #$0028         ; X = grapple HUD tilemap destination offset
$80:9A3C 80 0E       BRA $0E    [$9A4C] ; Write 2x2 tile icon to HUD tilemap
}


;;; $9A3E: Add x-ray to HUD tilemap ;;;
{
; Called by:
;     $9A79: Initialise HUD
;     $84:8941: Instruction - pick up equipment [[Y]], add x-ray to HUD and display x-ray message box
;     $91:E355: Debug. Give ammo, all items and switch to next beam configuration if newly pressed B
$80:9A3E 08          PHP
$80:9A3F DA          PHX
$80:9A40 5A          PHY
$80:9A41 8B          PHB
$80:9A42 4B          PHK                ;\
$80:9A43 AB          PLB                ;} DB = $80
$80:9A44 C2 30       REP #$30
$80:9A46 A0 C7 99    LDY #$99C7         ; Y = x-ray HUD tilemap source address
$80:9A49 A2 2E 00    LDX #$002E         ; X = x-ray HUD tilemap destination offset
}


;;; $9A4C: Write 2x2 tile icon to HUD tilemap ;;;
{
;; Parameters:
;;     X: HUD tilemap index
;;     Y: Source address
$80:9A4C BF 08 C6 7E LDA $7EC608,x[$7E:C624];\
$80:9A50 29 FF 03    AND #$03FF             ;|
$80:9A53 C9 0F 00    CMP #$000F             ;} If the tilemap is blank:
$80:9A56 D0 1C       BNE $1C    [$9A74]     ;/
$80:9A58 B9 00 00    LDA $0000,y[$80:99AF]  ;\
$80:9A5B 9F 08 C6 7E STA $7EC608,x[$7E:C624];|
$80:9A5F B9 02 00    LDA $0002,y[$80:99B1]  ;} Write top row
$80:9A62 9F 0A C6 7E STA $7EC60A,x[$7E:C626];/
$80:9A66 B9 04 00    LDA $0004,y[$80:99B3]  ;\
$80:9A69 9F 48 C6 7E STA $7EC648,x[$7E:C664];|
$80:9A6D B9 06 00    LDA $0006,y[$80:99B5]  ;} Write bottom row
$80:9A70 9F 4A C6 7E STA $7EC64A,x[$7E:C666];/

$80:9A74 AB          PLB
$80:9A75 7A          PLY
$80:9A76 FA          PLX
$80:9A77 28          PLP
$80:9A78 6B          RTL
}


;;; $9A79: Initialise HUD (HUD routine when game is loading) ;;;
{
$80:9A79 08          PHP
$80:9A7A 8B          PHB
$80:9A7B 4B          PHK                    ;\
$80:9A7C AB          PLB                    ;} DB = $80
$80:9A7D C2 30       REP #$30
$80:9A7F A9 00 58    LDA #$5800             ;\
$80:9A82 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:9A85 A9 80 00    LDA #$0080             ;|
$80:9A88 8D 15 21    STA $2115  [$7E:2115]  ;|
$80:9A8B 22 A9 91 80 JSL $8091A9[$80:91A9]  ;} VRAM $5800..1F = HUD top row tilemap
$80:9A8F             dx 01,01,18,80988B,0040;|
$80:9A97 E2 20       SEP #$20               ;|
$80:9A99 A9 02       LDA #$02               ;|
$80:9A9B 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:9A9E C2 20       REP #$20
$80:9AA0 A2 00 00    LDX #$0000

$80:9AA3 BD CB 98    LDA $98CB,x[$80:98CB]  ;\
$80:9AA6 9F 08 C6 7E STA $7EC608,x[$7E:C608];|
$80:9AAA E8          INX                    ;|
$80:9AAB E8          INX                    ;} $7E:C608..C6C7 = HUD rows 1..3 tilemap
$80:9AAC E0 C0 00    CPX #$00C0             ;|
$80:9AAF D0 F2       BNE $F2    [$9AA3]     ;/
$80:9AB1 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$80:9AB4 89 00 80    BIT #$8000             ;} If x-ray equipped:
$80:9AB7 F0 04       BEQ $04    [$9ABD]     ;/
$80:9AB9 22 3E 9A 80 JSL $809A3E[$80:9A3E]  ; Add x-ray to HUD tilemap

$80:9ABD AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$80:9AC0 89 00 40    BIT #$4000             ;} If grapple equipped:
$80:9AC3 F0 04       BEQ $04    [$9AC9]     ;/
$80:9AC5 22 2E 9A 80 JSL $809A2E[$80:9A2E]  ; Add grapple to HUD tilemap

$80:9AC9 AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$80:9ACC F0 04       BEQ $04    [$9AD2]     ;} If [Samus max missiles] != 0:
$80:9ACE 22 CF 99 80 JSL $8099CF[$80:99CF]  ; Add missiles to HUD tilemap

$80:9AD2 AD CC 09    LDA $09CC  [$7E:09CC]  ;\
$80:9AD5 F0 04       BEQ $04    [$9ADB]     ;} If [Samus max super missiles] != 0:
$80:9AD7 22 0E 9A 80 JSL $809A0E[$80:9A0E]  ; Add super missiles to HUD tilemap

$80:9ADB AD D0 09    LDA $09D0  [$7E:09D0]  ;\
$80:9ADE F0 04       BEQ $04    [$9AE4]     ;} If [Samus max power bombs] != 0:
$80:9AE0 22 1E 9A 80 JSL $809A1E[$80:9A1E]  ; Add power bombs to HUD tilemap

$80:9AE4 9C 06 0A    STZ $0A06  [$7E:0A06]  ; Samus previous health = 0
$80:9AE7 9C 08 0A    STZ $0A08  [$7E:0A08]  ; Samus previous missiles = 0
$80:9AEA 9C 0A 0A    STZ $0A0A  [$7E:0A0A]  ; Samus previous supers missiles = 0
$80:9AED 9C 0C 0A    STZ $0A0C  [$7E:0A0C]  ; Samus previous power bombs = 0
$80:9AF0 9C 0E 0A    STZ $0A0E  [$7E:0A0E]  ; Previous HUD item index = 0
$80:9AF3 22 EF A8 90 JSL $90A8EF[$90:A8EF]  ; Initialise mini-map (broken)
$80:9AF7 A9 D3 9D    LDA #$9DD3             ;\
$80:9AFA 85 00       STA $00    [$7E:0000]  ;|
$80:9AFC A9 80 00    LDA #$0080             ;} $00 = pointer to digit tiles
$80:9AFF 85 02       STA $02    [$7E:0002]  ;/
$80:9B01 AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$80:9B04 F0 09       BEQ $09    [$9B0F]     ;} If [Samus max missiles] != 0:
$80:9B06 AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$80:9B09 A2 94 00    LDX #$0094             ;} Draw missile count
$80:9B0C 20 78 9D    JSR $9D78  [$80:9D78]  ;/

$80:9B0F AD CC 09    LDA $09CC  [$7E:09CC]  ;\
$80:9B12 F0 09       BEQ $09    [$9B1D]     ;} If [Samus max super missiles] != 0:
$80:9B14 A2 9C 00    LDX #$009C             ;\
$80:9B17 AD CA 09    LDA $09CA  [$7E:09CA]  ;} Draw super missile count
$80:9B1A 20 98 9D    JSR $9D98  [$80:9D98]  ;/

$80:9B1D AD D0 09    LDA $09D0  [$7E:09D0]  ;\
$80:9B20 F0 09       BEQ $09    [$9B2B]     ;} If [Samus max power bombs] != 0:
$80:9B22 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$80:9B25 A2 A2 00    LDX #$00A2             ;} Draw power bomb count
$80:9B28 20 98 9D    JSR $9D98  [$80:9D98]  ;/

$80:9B2B AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$80:9B2E A2 00 10    LDX #$1000             ;} Highlight selected HUD item
$80:9B31 20 EA 9C    JSR $9CEA  [$80:9CEA]  ;/
$80:9B34 AD 0E 0A    LDA $0A0E  [$7E:0A0E]  ;\
$80:9B37 A2 00 14    LDX #$1400             ;} Unhighlight previously selected HUD item
$80:9B3A 20 EA 9C    JSR $9CEA  [$80:9CEA]  ;/
$80:9B3D 22 44 9B 80 JSL $809B44[$80:9B44]  ; Handle HUD tilemap
$80:9B41 AB          PLB
$80:9B42 28          PLP
$80:9B43 6B          RTL
}


;;; $9B44: Handle HUD tilemap (HUD routine when game is paused/running) ;;;
{
$80:9B44 08          PHP
$80:9B45 8B          PHB
$80:9B46 4B          PHK                    ;\
$80:9B47 AB          PLB                    ;} DB = $80
$80:9B48 E2 20       SEP #$20
$80:9B4A 64 02       STZ $02    [$7E:0002]  ; Digit tiles bank = $00 (equivalent to $80)
$80:9B4C C2 30       REP #$30
$80:9B4E AD C0 09    LDA $09C0  [$7E:09C0]  ;\
$80:9B51 C9 01 00    CMP #$0001             ;} If [reserve health mode] != auto: go to BRANCH_NOT_AUTO_RESERVES
$80:9B54 D0 35       BNE $35    [$9B8B]     ;/
$80:9B56 A0 8B 99    LDY #$998B             ; Load (yellow) auto reserve
$80:9B59 AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$80:9B5C D0 03       BNE $03    [$9B61]     ;} If [Samus reserve health] = 0:
$80:9B5E A0 97 99    LDY #$9997             ; Load (blue) empty auto reserve

$80:9B61 B9 00 00    LDA $0000,y[$80:9997]  ;\
$80:9B64 8F 18 C6 7E STA $7EC618[$7E:C618]  ;|
$80:9B68 B9 02 00    LDA $0002,y[$80:9999]  ;} Write top row of auto reserve tilemap
$80:9B6B 8F 1A C6 7E STA $7EC61A[$7E:C61A]  ;/
$80:9B6F B9 04 00    LDA $0004,y[$80:999B]  ;\
$80:9B72 8F 58 C6 7E STA $7EC658[$7E:C658]  ;|
$80:9B76 B9 06 00    LDA $0006,y[$80:999D]  ;} Write middle row of auto reserve tilemap
$80:9B79 8F 5A C6 7E STA $7EC65A[$7E:C65A]  ;/
$80:9B7D B9 08 00    LDA $0008,y[$80:999F]  ;\
$80:9B80 8F 98 C6 7E STA $7EC698[$7E:C698]  ;|
$80:9B84 B9 0A 00    LDA $000A,y[$80:99A1]  ;} Write bottom row of auto reserve tilemap
$80:9B87 8F 9A C6 7E STA $7EC69A[$7E:C69A]  ;/

; BRANCH_NOT_AUTO_RESERVES
; Handle Samus health
$80:9B8B AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$80:9B8E CD 06 0A    CMP $0A06  [$7E:0A06]  ;} If [Samus health] = [Samus previous health]: go to BRANCH_HEALTH_END
$80:9B91 F0 68       BEQ $68    [$9BFB]     ;/
$80:9B93 8D 06 0A    STA $0A06  [$7E:0A06]  ; Samus previous health = [Samus health]
$80:9B96 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$80:9B99 8D 04 42    STA $4204  [$7E:4204]  ;|
$80:9B9C E2 20       SEP #$20               ;|
$80:9B9E A9 64       LDA #$64               ;|
$80:9BA0 8D 06 42    STA $4206  [$7E:4206]  ;|
$80:9BA3 48          PHA                    ;|
$80:9BA4 68          PLA                    ;} $14 = number of whole energy tanks
$80:9BA5 48          PHA                    ;} $12 = sub-tank energy
$80:9BA6 68          PLA                    ;|
$80:9BA7 C2 20       REP #$20               ;|
$80:9BA9 AD 14 42    LDA $4214  [$7E:4214]  ;|
$80:9BAC 85 14       STA $14    [$7E:0014]  ;|
$80:9BAE AD 16 42    LDA $4216  [$7E:4216]  ;|
$80:9BB1 85 12       STA $12    [$7E:0012]  ;/
$80:9BB3 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$80:9BB6 8D 04 42    STA $4204  [$7E:4204]  ;|
$80:9BB9 E2 20       SEP #$20               ;|
$80:9BBB A9 64       LDA #$64               ;|
$80:9BBD 8D 06 42    STA $4206  [$7E:4206]  ;|
$80:9BC0 48          PHA                    ;|
$80:9BC1 68          PLA                    ;} $16 = number of collected energy tanks + 1
$80:9BC2 48          PHA                    ;} Y = 0 (energy tank index)
$80:9BC3 68          PLA                    ;|
$80:9BC4 C2 30       REP #$30               ;|
$80:9BC6 A0 00 00    LDY #$0000             ;|
$80:9BC9 AD 14 42    LDA $4214  [$7E:4214]  ;|
$80:9BCC 1A          INC A                  ;|
$80:9BCD 85 16       STA $16    [$7E:0016]  ;/

; LOOP_ETANKS
$80:9BCF C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$80:9BD1 F0 1B       BEQ $1B    [$9BEE]     ; If [$16] = 0: go to BRANCH_ETANKS_END
$80:9BD3 A2 30 34    LDX #$3430             ; X = empty energy tank tile
$80:9BD6 A5 14       LDA $14    [$7E:0014]  ;\
$80:9BD8 F0 05       BEQ $05    [$9BDF]     ;} If [$14] != 0:
$80:9BDA C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$80:9BDC A2 31 28    LDX #$2831             ; X = full energy tank tile

$80:9BDF 8A          TXA                    ;\
$80:9BE0 BE CE 9C    LDX $9CCE,y[$80:9CCE]  ;} $7E:C608 + [$9CCE + [Y]] = [X] (write energy tank tile)
$80:9BE3 9F 08 C6 7E STA $7EC608,x[$7E:C64A];/
$80:9BE7 C8          INY                    ;\
$80:9BE8 C8          INY                    ;} Y += 2 (next energy tank index)
$80:9BE9 C0 1C 00    CPY #$001C             ;\
$80:9BEC 30 E1       BMI $E1    [$9BCF]     ;} If [Y] < 1Ch: go to LOOP_ETANKS

; BRANCH_ETANKS_END
$80:9BEE A9 BF 9D    LDA #$9DBF             ;\
$80:9BF1 85 00       STA $00    [$7E:0000]  ;} $00 = pointer to digit tiles
$80:9BF3 A2 8C 00    LDX #$008C             ; X = sub-tank health HUD tilemap destination offset
$80:9BF6 A5 12       LDA $12    [$7E:0012]  ; A = sub-tank health
$80:9BF8 20 98 9D    JSR $9D98  [$80:9D98]  ; Draw two HUD digits

; BRANCH_HEALTH_END
; Handle Samus missiles
$80:9BFB A9 D3 9D    LDA #$9DD3             ;\
$80:9BFE 85 00       STA $00    [$7E:0000]  ;} $00 = pointer to other (identical) digit tiles
$80:9C00 AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$80:9C03 F0 11       BEQ $11    [$9C16]     ;} If [Samus max missiles] != 0:
$80:9C05 AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$80:9C08 CD 08 0A    CMP $0A08  [$7E:0A08]  ;} If [Samus missiles] != [Samus previous missiles]:
$80:9C0B F0 09       BEQ $09    [$9C16]     ;/
$80:9C0D 8D 08 0A    STA $0A08  [$7E:0A08]  ; Samus previous missiles = [Samus missiles]
$80:9C10 A2 94 00    LDX #$0094             ; X = missile count HUD tilemap destination offset
$80:9C13 20 78 9D    JSR $9D78  [$80:9D78]  ; Draw three HUD digits

; Handle Samus super missiles
$80:9C16 AD CC 09    LDA $09CC  [$7E:09CC]  ;\
$80:9C19 F0 24       BEQ $24    [$9C3F]     ;} If [Samus max super missiles] != 0:
$80:9C1B AD CA 09    LDA $09CA  [$7E:09CA]  ;\
$80:9C1E CD 0A 0A    CMP $0A0A  [$7E:0A0A]  ;} If [Samus super missiles] != [Samus previous super missiles]:
$80:9C21 F0 1C       BEQ $1C    [$9C3F]     ;/
$80:9C23 8D 0A 0A    STA $0A0A  [$7E:0A0A]  ; Samus previous super missiles = [Samus super missiles]
$80:9C26 A2 9C 00    LDX #$009C             ; X = super missile count HUD tilemap destination offset
$80:9C29 AD CF 05    LDA $05CF  [$7E:05CF]  ;\
$80:9C2C 89 40 1F    BIT #$1F40             ;} If [debug options] & 1F40h = 0:
$80:9C2F D0 08       BNE $08    [$9C39]     ;/
$80:9C31 AD 0A 0A    LDA $0A0A  [$7E:0A0A]  ; A = [Samus previous super missiles]
$80:9C34 20 98 9D    JSR $9D98  [$80:9D98]  ; Draw two HUD digits
$80:9C37 80 06       BRA $06    [$9C3F]

                                            ; Else ([debug options] & 1F40h != 0):
$80:9C39 AD 0A 0A    LDA $0A0A  [$7E:0A0A]  ; A = [Samus previous super missiles]
$80:9C3C 20 78 9D    JSR $9D78  [$80:9D78]  ; Draw three HUD digits

; Handle Samus power bombs
$80:9C3F AD D0 09    LDA $09D0  [$7E:09D0]  ;\
$80:9C42 F0 11       BEQ $11    [$9C55]     ;} If [Samus max power bombs] != 0:
$80:9C44 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$80:9C47 CD 0C 0A    CMP $0A0C  [$7E:0A0C]  ;} If [Samus power bombs] != [Samus previous power bombs]:
$80:9C4A F0 09       BEQ $09    [$9C55]     ;/
$80:9C4C 8D 0C 0A    STA $0A0C  [$7E:0A0C]  ; Samus previous power bombs = [Samus power bombs]
$80:9C4F A2 A2 00    LDX #$00A2             ; X = power bomb count HUD tilemap destination offset
$80:9C52 20 98 9D    JSR $9D98  [$80:9D98]  ; Draw two HUD digits

; Handle highlighter, plays click sound unless spin/wall jumping, grappling or x-raying
$80:9C55 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$80:9C58 CD 0E 0A    CMP $0A0E  [$7E:0A0E]  ;} If [HUD item index] != [previous HUD item index]:
$80:9C5B F0 39       BEQ $39    [$9C96]     ;/
$80:9C5D A2 00 10    LDX #$1000             ;\
$80:9C60 20 EA 9C    JSR $9CEA  [$80:9CEA]  ;} Highlight current item
$80:9C63 AD 0E 0A    LDA $0A0E  [$7E:0A0E]  ;\
$80:9C66 A2 00 14    LDX #$1400             ;} Unhighlight previous item
$80:9C69 20 EA 9C    JSR $9CEA  [$80:9CEA]  ;/
$80:9C6C AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$80:9C6F 8D 0E 0A    STA $0A0E  [$7E:0A0E]  ;} Previous HUD item index = [HUD item index]
$80:9C72 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$80:9C75 29 FF 00    AND #$00FF             ;|
$80:9C78 C9 03 00    CMP #$0003             ;} If [Samus movement type] != spin jumping:
$80:9C7B F0 19       BEQ $19    [$9C96]     ;/
$80:9C7D C9 14 00    CMP #$0014             ;\
$80:9C80 F0 14       BEQ $14    [$9C96]     ;} If [Samus movement type] != wall jumping:
$80:9C82 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$80:9C85 C9 F0 C4    CMP #$C4F0             ;} If [grapple beam function] = inactive:
$80:9C88 D0 0C       BNE $0C    [$9C96]     ;/
$80:9C8A AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$80:9C8D D0 07       BNE $07    [$9C96]     ;} If time is not frozen:
$80:9C8F A9 39 00    LDA #$0039             ;\
$80:9C92 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 39h, sound library 1, max queued sounds allowed = 6 (switch HUD item)

; Handle auto-cancel highlighter flash
; Note that the 8-bit frame counter used here is set to 0 by door transition,
; which usually causes the flash cycle to reset
$80:9C96 A2 00 14    LDX #$1400             ; X = 1400h (non highlight palette)
$80:9C99 AD B5 05    LDA $05B5  [$7E:05B5]  ;\
$80:9C9C 89 10 00    BIT #$0010             ;} If [8-bit frame counter] % 20h >= 10h:
$80:9C9F F0 03       BEQ $03    [$9CA4]     ;/
$80:9CA1 A2 00 10    LDX #$1000             ; X = 1000h (highlight palette)

$80:9CA4 AD 04 0A    LDA $0A04  [$7E:0A04]  ;\
$80:9CA7 20 EA 9C    JSR $9CEA  [$80:9CEA]  ;} Set auto-cancel HUD item palette
$80:9CAA AE 30 03    LDX $0330  [$7E:0330]  ;\
$80:9CAD A9 C0 00    LDA #$00C0             ;|
$80:9CB0 95 D0       STA $D0,x  [$7E:00D0]  ;|
$80:9CB2 E8          INX                    ;|
$80:9CB3 E8          INX                    ;|
$80:9CB4 A9 08 C6    LDA #$C608             ;|
$80:9CB7 95 D0       STA $D0,x  [$7E:00D2]  ;|
$80:9CB9 E8          INX                    ;|
$80:9CBA E8          INX                    ;} Queue transfer of $7E:C608..C7 to VRAM $5820..7F (HUD tilemap)
$80:9CBB A9 7E 00    LDA #$007E             ;|
$80:9CBE 95 D0       STA $D0,x  [$7E:00D4]  ;|
$80:9CC0 E8          INX                    ;|
$80:9CC1 A9 20 58    LDA #$5820             ;|
$80:9CC4 95 D0       STA $D0,x  [$7E:00D5]  ;|
$80:9CC6 E8          INX                    ;|
$80:9CC7 E8          INX                    ;|
$80:9CC8 8E 30 03    STX $0330  [$7E:0330]  ;/
$80:9CCB AB          PLB
$80:9CCC 28          PLP
$80:9CCD 6B          RTL

; Energy tank icon tilemap offsets
$80:9CCE             dw 0042, 0044, 0046, 0048, 004A, 004C, 004E; Bottom (first) row
$80:9CDC             dw 0002, 0004, 0006, 0008, 000A, 000C, 000E; Top (second) row
}


;;; $9CEA: Toggle HUD item highlight ;;;
{
;; Parameters:
;;     A: HUD item index
;;     X: Tilemap palette bits (palette index * 400h)

; Palette 4 (X = 1000h) is used for the highlighted palette, otherwise palette 5 (X = 1400h) is used
; This routine assumes missiles are 3 tiles wide and all other icons are 2 tiles wide
$80:9CEA 8E 7C 07    STX $077C  [$7E:077C]  ; HUD item tilemap palette bits = [X]
$80:9CED 3A          DEC A                  ;\
$80:9CEE 30 7D       BMI $7D    [$9D6D]     ;} If [A] <= 0: return
$80:9CF0 0A          ASL A                  ;\
$80:9CF1 A8          TAY                    ;} X = [$9D6E + ([A] - 1) * 2] (HUD item tilemap offset)
$80:9CF2 BE 6E 9D    LDX $9D6E,y[$80:9D6E]  ;/
$80:9CF5 BF 08 C6 7E LDA $7EC608,x[$7E:C61C];\
$80:9CF9 C9 0F 2C    CMP #$2C0F             ;} If top-left icon tile is not blank:
$80:9CFC F0 0A       BEQ $0A    [$9D08]     ;/
$80:9CFE 29 FF E3    AND #$E3FF             ;\
$80:9D01 0D 7C 07    ORA $077C  [$7E:077C]  ;} Set tile's palette bits
$80:9D04 9F 08 C6 7E STA $7EC608,x[$7E:C61C];/

$80:9D08 BF 0A C6 7E LDA $7EC60A,x[$7E:C61E];\
$80:9D0C C9 0F 2C    CMP #$2C0F             ;} If top-right/middle icon tile is not blank:
$80:9D0F F0 0A       BEQ $0A    [$9D1B]     ;/
$80:9D11 29 FF E3    AND #$E3FF             ;\
$80:9D14 0D 7C 07    ORA $077C  [$7E:077C]  ;} Set tile's palette bits
$80:9D17 9F 0A C6 7E STA $7EC60A,x[$7E:C61E];/

$80:9D1B BF 48 C6 7E LDA $7EC648,x[$7E:C65C];\
$80:9D1F C9 0F 2C    CMP #$2C0F             ;} If bottom-left icon tile is not blank:
$80:9D22 F0 0A       BEQ $0A    [$9D2E]     ;/
$80:9D24 29 FF E3    AND #$E3FF             ;\
$80:9D27 0D 7C 07    ORA $077C  [$7E:077C]  ;} Set tile's palette bits
$80:9D2A 9F 48 C6 7E STA $7EC648,x[$7E:C65C];/

$80:9D2E BF 4A C6 7E LDA $7EC64A,x[$7E:C65E];\
$80:9D32 C9 0F 2C    CMP #$2C0F             ;} If bottom-right/middle icon tile is not blank:
$80:9D35 F0 0A       BEQ $0A    [$9D41]     ;/
$80:9D37 29 FF E3    AND #$E3FF             ;\
$80:9D3A 0D 7C 07    ORA $077C  [$7E:077C]  ;} Set tile's palette bits
$80:9D3D 9F 4A C6 7E STA $7EC64A,x[$7E:C65E];/

$80:9D41 C0 00 00    CPY #$0000             ;\
$80:9D44 F0 01       BEQ $01    [$9D47]     ;} If not missiles: return
$80:9D46 60          RTS                    ;/

$80:9D47 BF 0C C6 7E LDA $7EC60C,x[$7E:C620];\
$80:9D4B C9 0F 2C    CMP #$2C0F             ;} If top-right icon tile is not blank:
$80:9D4E F0 0A       BEQ $0A    [$9D5A]     ;/
$80:9D50 29 FF E3    AND #$E3FF             ;\
$80:9D53 0D 7C 07    ORA $077C  [$7E:077C]  ;} Set tile's palette bits
$80:9D56 9F 0C C6 7E STA $7EC60C,x[$7E:C620];/

$80:9D5A BF 4C C6 7E LDA $7EC64C,x[$7E:C660];\
$80:9D5E C9 0F 2C    CMP #$2C0F             ;} If bottom-right icon tile is not blank:
$80:9D61 F0 0A       BEQ $0A    [$9D6D]     ;/
$80:9D63 29 FF E3    AND #$E3FF             ;\
$80:9D66 0D 7C 07    ORA $077C  [$7E:077C]  ;} Set tile's palette bits
$80:9D69 9F 4C C6 7E STA $7EC64C,x[$7E:C660];/

$80:9D6D 60          RTS

; HUD item tilemap offsets
$80:9D6E             dw 0014, ; Missiles
                        001C, ; Super missiles
                        0022, ; Power bombs
                        0028, ; Grapple beam
                        002E  ; X-ray
}


;;; $9D78: Draw three HUD digits ;;;
{
;; Parameters:
;;     A: Number to draw
;;     X: HUD tilemap index
;;     $00: Long pointer to digits tilemap

$80:9D78 8D 04 42    STA $4204  [$7E:4204]  ;\
$80:9D7B E2 20       SEP #$20               ;|
$80:9D7D A9 64       LDA #$64               ;|
$80:9D7F 8D 06 42    STA $4206  [$7E:4206]  ;|
$80:9D82 48          PHA                    ;|
$80:9D83 68          PLA                    ;|
$80:9D84 48          PHA                    ;|
$80:9D85 68          PLA                    ;} HUD tilemap base + [X] = [[$00] + ([A] / 100) * 2] (draw hundreds digit)
$80:9D86 C2 20       REP #$20               ;|
$80:9D88 AD 14 42    LDA $4214  [$7E:4214]  ;|
$80:9D8B 0A          ASL A                  ;|
$80:9D8C A8          TAY                    ;|
$80:9D8D B7 00       LDA [$00],y[$00:9DD3]  ;|
$80:9D8F 9F 08 C6 7E STA $7EC608,x[$7E:C69C];/
$80:9D93 E8          INX                    ;\
$80:9D94 E8          INX                    ;} X += 2 (next HUD tilemap index)
$80:9D95 AD 16 42    LDA $4216  [$7E:4216]  ; A = [A] % 100
}


;;; $9D98: Draw two HUD digits ;;;
{
;; Parameters:
;;     A: Number to draw
;;     X: HUD tilemap index
;;     $00: Long pointer to digits tilemap

$80:9D98 8D 04 42    STA $4204  [$7E:4204]  ;\
$80:9D9B E2 20       SEP #$20               ;|
$80:9D9D A9 0A       LDA #$0A               ;|
$80:9D9F 8D 06 42    STA $4206  [$7E:4206]  ;|
$80:9DA2 48          PHA                    ;|
$80:9DA3 68          PLA                    ;|
$80:9DA4 48          PHA                    ;|
$80:9DA5 68          PLA                    ;} HUD tilemap base + [X] = [[$00] + ([A] / 10) * 2] (draw tens digit)
$80:9DA6 C2 20       REP #$20               ;|
$80:9DA8 AD 14 42    LDA $4214  [$7E:4214]  ;|
$80:9DAB 0A          ASL A                  ;|
$80:9DAC A8          TAY                    ;|
$80:9DAD B7 00       LDA [$00],y[$00:9DD1]  ;|
$80:9DAF 9F 08 C6 7E STA $7EC608,x[$7E:C694];/
$80:9DB3 AD 16 42    LDA $4216  [$7E:4216]  ;\
$80:9DB6 0A          ASL A                  ;|
$80:9DB7 A8          TAY                    ;} HUD tilemap base + [X] = [[$00] + ([A] % 10) * 2] (draw units digit)
$80:9DB8 B7 00       LDA [$00],y[$00:9DD1]  ;|
$80:9DBA 9F 0A C6 7E STA $7EC60A,x[$7E:C696];/
$80:9DBE 60          RTS
}


;;; $9DBF: HUD digits tilemap ;;;
{
; Starting with zero

; Health
$80:9DBF             dw 2C09, 2C00, 2C01, 2C02, 2C03, 2C04, 2C05, 2C06, 2C07, 2C08

; Artillery
$80:9DD3             dw 2C09, 2C00, 2C01, 2C02, 2C03, 2C04, 2C05, 2C06, 2C07, 2C08
}
}


;;; $9DE7..A07A: Timer ;;;
{
;;; $9DE7: Process timer ;;;
{
;; Returns:
;;     Carry: Set if timer has reached zero, otherwise clear

; Called by:
;     $90:E0E6
;     $90:E12E: Push Samus out of Ceres Ridley's way
;     $90:E1C8
$80:9DE7 8B          PHB
$80:9DE8 4B          PHK                    ;\
$80:9DE9 AB          PLB                    ;} DB = $80
$80:9DEA DA          PHX
$80:9DEB 5A          PHY
$80:9DEC AD 43 09    LDA $0943  [$7E:0943]  ;\
$80:9DEF 29 FF 00    AND #$00FF             ;|
$80:9DF2 0A          ASL A                  ;} Execute [$9DFB + [timer status] * 2]
$80:9DF3 AA          TAX                    ;|
$80:9DF4 FC FB 9D    JSR ($9DFB,x)[$80:9E1A];/
$80:9DF7 7A          PLY
$80:9DF8 FA          PLX
$80:9DF9 AB          PLB
$80:9DFA 6B          RTL

$80:9DFB             dw 9E1A, 9E09, 9E1C, 9E2F, 9E41, 9E58, 9E89
}


;;; $9E09: Process timer - Ceres start ;;;
{
$80:9E09 22 93 9E 80 JSL $809E93[$80:9E93]  ; Clear timer RAM
$80:9E0D A9 00 01    LDA #$0100             ;\
$80:9E10 22 8C 9E 80 JSL $809E8C[$80:9E8C]  ;} Timer = 1 minute, 0 seconds
$80:9E14 A9 03 80    LDA #$8003             ;\
$80:9E17 8D 43 09    STA $0943  [$7E:0943]  ;} Timer status = initial delay
}


;;; $9E1A: Clear carry. Process timer - inactive ;;;
{
$80:9E1A 18          CLC
$80:9E1B 60          RTS
}


;;; $9E1C: Process timer - Mother Brain start ;;;
{
$80:9E1C 22 93 9E 80 JSL $809E93[$80:9E93]  ; Clear timer RAM
$80:9E20 A9 00 03    LDA #$0300             ;\
$80:9E23 22 8C 9E 80 JSL $809E8C[$80:9E8C]  ;} Timer = 3 minutes, 0 seconds
$80:9E27 A9 03 80    LDA #$8003             ;\
$80:9E2A 8D 43 09    STA $0943  [$7E:0943]  ;} Timer status = initial delay
$80:9E2D 18          CLC
$80:9E2E 60          RTS
}


;;; $9E2F: Process timer - initial delay ;;;
{
$80:9E2F E2 20       SEP #$20
$80:9E31 EE 48 09    INC $0948  [$7E:0948]  ; Increment timer status counter
$80:9E34 AD 48 09    LDA $0948  [$7E:0948]  ;\
$80:9E37 C9 10       CMP #$10               ;} If [timer status counter] >= 10h:
$80:9E39 90 03       BCC $03    [$9E3E]     ;/
$80:9E3B EE 43 09    INC $0943  [$7E:0943]  ; Timer status = timer running, movement delayed

$80:9E3E C2 21       REP #$21
$80:9E40 60          RTS
}


;;; $9E41: Process timer - timer running, movement delayed ;;;
{
$80:9E41 E2 20       SEP #$20
$80:9E43 EE 48 09    INC $0948  [$7E:0948]  ; Increment timer status counter
$80:9E46 AD 48 09    LDA $0948  [$7E:0948]  ;\
$80:9E49 C9 60       CMP #$60               ;} If [timer status counter] >= 60h:
$80:9E4B 90 06       BCC $06    [$9E53]     ;/
$80:9E4D 9C 48 09    STZ $0948  [$7E:0948]  ; Timer X position = 0
$80:9E50 EE 43 09    INC $0943  [$7E:0943]  ; Timer status = timer running, moving into place

$80:9E53 C2 20       REP #$20
$80:9E55 4C A9 9E    JMP $9EA9  [$80:9EA9]  ; Go to decrement timer
}


;;; $9E58: Process timer - timer running, moving into place ;;;
{
$80:9E58 A0 00 00    LDY #$0000             ; Y = 0
$80:9E5B A9 E0 00    LDA #$00E0             ;\
$80:9E5E 18          CLC                    ;} A = [timer X position] + 0.E0h
$80:9E5F 6D 48 09    ADC $0948  [$7E:0948]  ;/
$80:9E62 C9 00 DC    CMP #$DC00             ;\
$80:9E65 90 04       BCC $04    [$9E6B]     ;} If [A] >= DCh:
$80:9E67 C8          INY                    ; Increment Y
$80:9E68 A9 00 DC    LDA #$DC00             ; A = DCh.0

$80:9E6B 8D 48 09    STA $0948  [$7E:0948]  ; Timer X position = [A]
$80:9E6E A9 3F FF    LDA #$FF3F             ;\
$80:9E71 18          CLC                    ;} A = [timer Y position] - 0.C1h
$80:9E72 6D 4A 09    ADC $094A  [$7E:094A]  ;/
$80:9E75 C9 00 30    CMP #$3000             ;\
$80:9E78 B0 04       BCS $04    [$9E7E]     ;} If [A] < 30h:
$80:9E7A C8          INY                    ; Increment Y
$80:9E7B A9 00 30    LDA #$3000             ; A = 30h.0

$80:9E7E 8D 4A 09    STA $094A  [$7E:094A]  ; Timer Y position = [A]
$80:9E81 C0 02 00    CPY #$0002             ;\
$80:9E84 D0 03       BNE $03    [$9E89]     ;} If [Y] = 2 (in place):
$80:9E86 EE 43 09    INC $0943  [$7E:0943]  ; Timer status = timer running, moved into place
}


;;; $9E89: Process timer - timer running, moved into place ;;;
{
$80:9E89 4C A9 9E    JMP $9EA9  [$80:9EA9]  ; Go to decrement timer
}


;;; $9E8C: Timer = [A high] minutes, [A low] seconds ;;;
{
; Called by:
;     $9E09 with A = 100h: Process timer - Ceres start
;     $9E1C with A = 300h: Process timer - Mother Brain start
$80:9E8C 9C 45 09    STZ $0945  [$7E:0945]
$80:9E8F 8D 46 09    STA $0946  [$7E:0946]
$80:9E92 6B          RTL
}


;;; $9E93: Clear timer RAM ;;;
{
$80:9E93 A9 00 80    LDA #$8000             ;\
$80:9E96 8D 48 09    STA $0948  [$7E:0948]  ;|
$80:9E99 A9 00 80    LDA #$8000             ;} Position timer off-screen
$80:9E9C 8D 4A 09    STA $094A  [$7E:094A]  ;/
$80:9E9F 9C 45 09    STZ $0945  [$7E:0945]  ;\
$80:9EA2 9C 46 09    STZ $0946  [$7E:0946]  ;} Timer = 0
$80:9EA5 9C 43 09    STZ $0943  [$7E:0943]  ; Timer status = inactive
$80:9EA8 6B          RTL
}


;;; $9EA9: Decrement timer ;;;
{
;; Returns:
;;     Carry: Set if timer has reached zero, otherwise clear

$80:9EA9 E2 39       SEP #$39               ; Set carry and decimal
$80:9EAB AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$80:9EAE 29 7F       AND #$7F               ;|
$80:9EB0 AA          TAX                    ;|
$80:9EB1 AD 45 09    LDA $0945  [$7E:0945]  ;} Timer centiseconds -= [$9EEC + [frame counter] % 80h]
$80:9EB4 FD EC 9E    SBC $9EEC,x[$80:9F42]  ;|
$80:9EB7 8D 45 09    STA $0945  [$7E:0945]  ;/
$80:9EBA B0 24       BCS $24    [$9EE0]     ; If timer centiseconds wrapped:
$80:9EBC AD 46 09    LDA $0946  [$7E:0946]  ;\
$80:9EBF E9 00       SBC #$00               ;} Decrement timer seconds
$80:9EC1 8D 46 09    STA $0946  [$7E:0946]  ;/
$80:9EC4 B0 1A       BCS $1A    [$9EE0]     ; If timer seconds wrapped:
$80:9EC6 AD 47 09    LDA $0947  [$7E:0947]  ;\
$80:9EC9 E9 00       SBC #$00               ;} Decrement timer minutes
$80:9ECB 8D 47 09    STA $0947  [$7E:0947]  ;/
$80:9ECE 90 07       BCC $07    [$9ED7]     ; If [timer minutes] >= 0:
$80:9ED0 A9 59       LDA #$59               ;\
$80:9ED2 8D 46 09    STA $0946  [$7E:0946]  ;} Timer seconds = 59
$80:9ED5 80 09       BRA $09    [$9EE0]

$80:9ED7 9C 45 09    STZ $0945  [$7E:0945]  ;\ Else ([timer minutes] < 0):
$80:9EDA 9C 46 09    STZ $0946  [$7E:0946]  ;} Timer = 0
$80:9EDD 9C 47 09    STZ $0947  [$7E:0947]  ;/

$80:9EE0 C2 39       REP #$39               ; Clear carry and decimal
$80:9EE2 AD 45 09    LDA $0945  [$7E:0945]  ;\
$80:9EE5 0D 46 09    ORA $0946  [$7E:0946]  ;} If [timer] = 0:
$80:9EE8 D0 01       BNE $01    [$9EEB]     ;/
$80:9EEA 38          SEC                    ; Set carry

$80:9EEB 60          RTS

; Timer centisecond decrements (43 01's and 85 02's)
$80:9EEC             db 01, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 01, 02, 02, 01, 02, 02, 01, 02
$80:9F0C             db 01, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 01, 02, 02, 01, 02, 02, 01, 02
$80:9F2C             db 01, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 01, 02, 02, 01, 02, 02, 01, 02
$80:9F4C             db 01, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 01, 02, 02, 02, 01, 02, 02
}


;;; $9F6C: Draw timer ;;;
{
; Called by:
;     $82:8367: Game state 20h (made it to Ceres elevator)
;     $82:8388: Game state 21h (blackout from Ceres)
;     $82:E1B7: Game state Ah (loading next room)
;     $82:E288: Game state Bh (loading next room)
;     $90:E0E6
;     $90:E114
;     $90:E12E: Push Samus out of Ceres Ridley's way
;     $90:E1C8
$80:9F6C 8B          PHB
$80:9F6D 4B          PHK                    ;\
$80:9F6E AB          PLB                    ;} DB = $80
$80:9F6F A0 60 A0    LDY #$A060             ;\
$80:9F72 A9 00 00    LDA #$0000             ;} Draw TIME
$80:9F75 20 B3 9F    JSR $9FB3  [$80:9FB3]  ;/
$80:9F78 AD 47 09    LDA $0947  [$7E:0947]  ;\
$80:9F7B A2 E4 FF    LDX #$FFE4             ;} Draw minutes
$80:9F7E 20 95 9F    JSR $9F95  [$80:9F95]  ;/
$80:9F81 AD 46 09    LDA $0946  [$7E:0946]  ;\
$80:9F84 A2 FC FF    LDX #$FFFC             ;} Draw seconds
$80:9F87 20 95 9F    JSR $9F95  [$80:9F95]  ;/
$80:9F8A AD 45 09    LDA $0945  [$7E:0945]  ;\
$80:9F8D A2 14 00    LDX #$0014             ;} Draw centiseconds
$80:9F90 20 95 9F    JSR $9F95  [$80:9F95]  ;/
$80:9F93 AB          PLB
$80:9F94 6B          RTL
}


;;; $9F95: Draw two timer digits ;;;
{
;; Parameters:
;;     DB: Spritemap bank
;;     A:  Timer value
;;     X:  X position offset

$80:9F95 DA          PHX
$80:9F96 48          PHA
$80:9F97 29 F0 00    AND #$00F0             ;\
$80:9F9A 4A          LSR A                  ;|
$80:9F9B 4A          LSR A                  ;|
$80:9F9C 4A          LSR A                  ;} Y = tens digit spritemap pointer
$80:9F9D AA          TAX                    ;|
$80:9F9E BC D4 9F    LDY $9FD4,x[$80:9FD4]  ;/
$80:9FA1 A3 03       LDA $03,s  [$7E:1FE8]  ; A = [X]
$80:9FA3 20 B3 9F    JSR $9FB3  [$80:9FB3]  ; Draw timer spritemap
$80:9FA6 68          PLA                    ;\
$80:9FA7 29 0F 00    AND #$000F             ;|
$80:9FAA 0A          ASL A                  ;} Y = units digit spritemap pointer
$80:9FAB AA          TAX                    ;|
$80:9FAC BC D4 9F    LDY $9FD4,x[$80:9FD6]  ;/
$80:9FAF 68          PLA                    ;\
$80:9FB0 69 08 00    ADC #$0008             ;} A = [X] + 8
}


;;; $9FB3: Draw timer spritemap ;;;
{
;; Parameters:
;;     A:    X position offset
;;     DB:Y: Spritemap pointer

$80:9FB3 85 14       STA $14    [$7E:0014]  ;\
$80:9FB5 AD 48 09    LDA $0948  [$7E:0948]  ;|
$80:9FB8 EB          XBA                    ;|
$80:9FB9 29 FF 00    AND #$00FF             ;} $14 = [timer X position] + [A]
$80:9FBC 18          CLC                    ;|
$80:9FBD 65 14       ADC $14    [$7E:0014]  ;|
$80:9FBF 85 14       STA $14    [$7E:0014]  ;/
$80:9FC1 AD 4A 09    LDA $094A  [$7E:094A]  ;\
$80:9FC4 EB          XBA                    ;|
$80:9FC5 29 FF 00    AND #$00FF             ;} $12 = [timer Y position]
$80:9FC8 85 12       STA $12    [$7E:0012]  ;/
$80:9FCA A9 00 0A    LDA #$0A00             ;\
$80:9FCD 85 16       STA $16    [$7E:0016]  ;} $16 = A00h (palette 5)
$80:9FCF 22 9F 87 81 JSL $81879F[$81:879F]  ; Add spritemap to OAM
$80:9FD3 60          RTS
}


;;; $9FD4: Timer spritemap data ;;;
{
; Timer digits spritemap pointers
$80:9FD4             dw 9FE8, 9FF4, A000, A00C, A018, A024, A030, A03C, A048, A054

; Timer digits spritemaps
$80:9FE8             dx 0002, 01FC,00,3BEA, 01FC,F8,3BE0 ; 0
$80:9FF4             dx 0002, 01FC,00,3BEB, 01FC,F8,3BE1 ; 1
$80:A000             dx 0002, 01FC,00,3BEC, 01FC,F8,3BE2 ; 2
$80:A00C             dx 0002, 01FC,00,3BED, 01FC,F8,3BE3 ; 3
$80:A018             dx 0002, 01FC,00,3BEE, 01FC,F8,3BE4 ; 4
$80:A024             dx 0002, 01FC,00,3BEF, 01FC,F8,3BE5 ; 5
$80:A030             dx 0002, 01FC,00,3BF0, 01FC,F8,3BE6 ; 6
$80:A03C             dx 0002, 01FC,00,3BF1, 01FC,F8,3BE7 ; 7
$80:A048             dx 0002, 01FC,00,3BF2, 01FC,F8,3BE8 ; 8
$80:A054             dx 0002, 01FC,00,3BF3, 01FC,F8,3BE9 ; 9

; Timer TIME spritemap
$80:A060             dx 0005, 01F0,F0,3BF8, 01E8,F0,3BF7, 01E0,F0,3BF6, 0008,F8,3BF5, 01F0,F8,3BF4
}
}


;;; $A07B: Start gameplay ;;;
{
; Called by:
;     $82:8000: Game state 6/1Fh/28h (loading game data / set up new game / load demo game data)
$80:A07B 08          PHP
$80:A07C 8B          PHB
$80:A07D 4B          PHK                    ;\
$80:A07E AB          PLB                    ;} DB = $80
$80:A07F C2 30       REP #$30
$80:A081 78          SEI                    ; Disable IRQ
$80:A082 9C 0B 42    STZ $420B  [$7E:420B]  ; Clear (H)DMA enable flags
$80:A085 9C E9 07    STZ $07E9  [$7E:07E9]  ; Scrolling finished hook = 0
$80:A088 9C F3 07    STZ $07F3  [$7E:07F3]  ; Music data index = 0
$80:A08B 9C F5 07    STZ $07F5  [$7E:07F5]  ; Music track index = 0
$80:A08E 9C 43 09    STZ $0943  [$7E:0943]  ; Timer status = inactive
$80:A091 22 9A 8A 82 JSL $828A9A[$82:8A9A]  ; Reset sound queues
$80:A095 A9 FF FF    LDA #$FFFF             ;\
$80:A098 8D F5 05    STA $05F5  [$7E:05F5]  ;} Disable sounds
$80:A09B 22 5D 83 80 JSL $80835D[$80:835D]  ; Disable NMI
$80:A09F 22 5F 98 80 JSL $80985F[$80:985F]  ; Disable h/v-counter interrupts
$80:A0A3 22 6B E7 82 JSL $82E76B[$82:E76B]  ; Load destination room CRE bitset, door/room/state headers, CRE tiles, tileset tiles and tileset palette
$80:A0A7 20 2B A1    JSR $A12B  [$80:A12B]  ; Handle music queue for 20 frames
$80:A0AA 22 16 80 87 JSL $878016[$87:8016]  ; Clear animated tile objects
$80:A0AE 22 9E 82 88 JSL $88829E[$88:829E]  ; Wait until the end of a v-blank and clear (H)DMA enable flags
$80:A0B2 22 C1 82 88 JSL $8882C1[$88:82C1]  ; Initialise special effects for new room
$80:A0B6 22 C3 83 84 JSL $8483C3[$84:83C3]  ; Clear PLMs
$80:A0BA 22 16 80 86 JSL $868016[$86:8016]  ; Clear enemy projectiles
$80:A0BE 22 D8 C4 8D JSL $8DC4D8[$8D:C4D8]  ; Clear palette FX objects
$80:A0C2 22 8D AC 90 JSL $90AC8D[$90:AC8D]  ; Update beam tiles and palette
$80:A0C6 22 39 E1 82 JSL $82E139[$82:E139]  ; Load target colours for common sprites, beams and flashing enemies
$80:A0CA 22 1E 8A A0 JSL $A08A1E[$A0:8A1E]  ; Load enemies
$80:A0CE 22 71 E0 82 JSL $82E071[$82:E071]  ; Queue room music data
$80:A0D2 20 2B A1    JSR $A12B  [$80:A12B]  ; Handle music queue for 20 frames
$80:A0D5 22 9B E0 82 JSL $82E09B[$82:E09B]  ; Update music track index
$80:A0D9 22 13 E1 82 JSL $82E113[$82:E113]  ; RTL
$80:A0DD 22 3F A2 80 JSL $80A23F[$80:A23F]  ; Clear BG2 tilemap
$80:A0E1 22 D3 E7 82 JSL $82E7D3[$82:E7D3]  ; Load level data, CRE, tile table, scroll data, create PLMs and execute door ASM and room setup ASM
$80:A0E5 22 82 AB 89 JSL $89AB82[$89:AB82]  ; Load FX
$80:A0E9 22 7C E9 82 JSL $82E97C[$82:E97C]  ; Load library background
$80:A0ED 20 F9 A2    JSR $A2F9  [$80:A2F9]  ; Calculate layer 2 X position
$80:A0F0 20 3A A3    JSR $A33A  [$80:A33A]  ; Calculate layer 2 Y position
$80:A0F3 AD 17 09    LDA $0917  [$7E:0917]  ;\
$80:A0F6 8D 21 09    STA $0921  [$7E:0921]  ;} BG2 X offset = [layer 2 X position]
$80:A0F9 AD 19 09    LDA $0919  [$7E:0919]  ;\
$80:A0FC 8D 23 09    STA $0923  [$7E:0923]  ;} BG2 Y offset = [layer 2 Y position]
$80:A0FF 20 7B A3    JSR $A37B  [$80:A37B]  ; Calculate BG scrolls
$80:A102 22 76 A1 80 JSL $80A176[$80:A176]  ; Display the viewable part of the room
$80:A106 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$80:A10A A5 A9       LDA $A9    [$7E:00A9]  ; A = [room loading interrupt command]
$80:A10C D0 03       BNE $03    [$A111]     ; If [A] = 0:
$80:A10E A9 04 00    LDA #$0004             ; A = 4 (main gameplay)

$80:A111 85 A7       STA $A7    [$7E:00A7]  ; Next interrupt command = [A]
$80:A113 22 2A 98 80 JSL $80982A[$80:982A]  ; Enable h/v-counter interrupts
$80:A117 20 2B A1    JSR $A12B  [$80:A12B]  ; Handle music queue for 20 frames
$80:A11A 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$80:A11E             dx  08, 08, B7EB       ;} Enable sounds in 20h frames, or F0h frames if on Ceres
$80:A122 A9 37 E7    LDA #$E737             ;\
$80:A125 8D 9C 09    STA $099C  [$7E:099C]  ;} Door transition function = $E737 (fade in the screen and run enemies; finish door transition)
$80:A128 AB          PLB
$80:A129 28          PLP
$80:A12A 6B          RTL
}


;;; $A12B: Handle music queue for 20 frames ;;;
{
; Called by:
;     $A07B: Start gameplay
$80:A12B 08          PHP
$80:A12C E2 30       SEP #$30
$80:A12E 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$80:A132 A2 14       LDX #$14               ; X = 20

; LOOP
$80:A134 DA          PHX
$80:A135 08          PHP
$80:A136 22 0C 8F 80 JSL $808F0C[$80:8F0C]  ; Handle music queue
$80:A13A 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$80:A13E 28          PLP
$80:A13F FA          PLX
$80:A140 CA          DEX                    ; Decrement X
$80:A141 D0 F1       BNE $F1    [$A134]     ; If [X] != 0: go to LOOP
$80:A143 22 5D 83 80 JSL $80835D[$80:835D]  ; Disable NMI
$80:A147 28          PLP
$80:A148 60          RTS
}


;;; $A149: Resume gameplay ;;;
{
; Called by:
;     $82:9367: Game state 11h (unpausing, loading normal gameplay)
$80:A149 08          PHP
$80:A14A 8B          PHB
$80:A14B 4B          PHK                    ;\
$80:A14C AB          PLB                    ;} DB = $80
$80:A14D C2 30       REP #$30
$80:A14F 78          SEI                    ; Disable IRQ
$80:A150 9C 0B 42    STZ $420B  [$7E:420B]  ; Clear (H)DMA enable flags
$80:A153 22 5D 83 80 JSL $80835D[$80:835D]  ; Disable NMI
$80:A157 22 5F 98 80 JSL $80985F[$80:985F]  ; Disable h/v-counter interrupts
$80:A15B 22 83 E7 82 JSL $82E783[$82:E783]  ; Load CRE tiles, tileset tiles and tileset palette
$80:A15F 22 7C E9 82 JSL $82E97C[$82:E97C]  ; Load library background
$80:A163 22 76 A1 80 JSL $80A176[$80:A176]  ; Display the viewable part of the room
$80:A167 22 32 82 84 JSL $848232[$84:8232]  ; Load room PLM GFX
$80:A16B 22 4B 83 80 JSL $80834B[$80:834B]  ; Enable NMI
$80:A16F 22 2A 98 80 JSL $80982A[$80:982A]  ; Enable h/v-counter interrupts
$80:A173 AB          PLB
$80:A174 28          PLP
$80:A175 6B          RTL
}


;;; $A176: Display the viewable part of the room ;;;
{
; Called by:
;     $A07B: Start gameplay
;     $A149: Resume gameplay

; Draws the 17x16 block area starting at:
;     ([layer 1 X position], [layer 1 Y position]) for BG1 level data
;     ([layer 2 X position], [layer 2 Y position]) for BG2 level data
;     ([BG1 X position], [BG1 Y position]) for BG1 VRAM position
;     ([BG2 X position], [BG2 Y position]) for BG2 VRAM position

; Expects force blank to be enabled!

$80:A176 08          PHP
$80:A177 E2 20       SEP #$20
$80:A179 A5 58       LDA $58    [$7E:0058]  ;\
$80:A17B 38          SEC                    ;|
$80:A17C E5 59       SBC $59    [$7E:0059]  ;|
$80:A17E EB          XBA                    ;} BG2 size = (BG1 tilemap base address) - (BG2 tilemap base address)
$80:A17F C2 20       REP #$20               ;|
$80:A181 29 00 F8    AND #$F800             ;|
$80:A184 8D 8E 09    STA $098E  [$7E:098E]  ;/
$80:A187 20 BB A4    JSR $A4BB  [$80:A4BB]  ; Calculate BG and layer position blocks
$80:A18A A2 00 00    LDX #$0000             ; X = 0 (column counter)

; LOOP
$80:A18D DA          PHX
$80:A18E AD F7 08    LDA $08F7  [$7E:08F7]  ;\
$80:A191 8D 90 09    STA $0990  [$7E:0990]  ;} Blocks to update X block = [layer 1 block X]
$80:A194 AD F9 08    LDA $08F9  [$7E:08F9]  ;\
$80:A197 8D 92 09    STA $0992  [$7E:0992]  ;} Blocks to update Y block = [layer 1 block Y]
$80:A19A AD 07 09    LDA $0907  [$7E:0907]  ;\
$80:A19D 8D 94 09    STA $0994  [$7E:0994]  ;} VRAM blocks to update X block = [BG1 block X]
$80:A1A0 AD 09 09    LDA $0909  [$7E:0909]  ;\
$80:A1A3 8D 96 09    STA $0996  [$7E:0996]  ;} VRAM blocks to update Y block = [BG1 block Y]
$80:A1A6 20 DB A9    JSR $A9DB  [$80:A9DB]  ; Update level data column
$80:A1A9 AD 1B 09    LDA $091B  [$7E:091B]  ;\
$80:A1AC 4A          LSR A                  ;} If using custom layer 2:
$80:A1AD B0 1B       BCS $1B    [$A1CA]     ;/
$80:A1AF AD FB 08    LDA $08FB  [$7E:08FB]  ;\
$80:A1B2 8D 90 09    STA $0990  [$7E:0990]  ;} Blocks to update X block = [layer 2 block X]
$80:A1B5 AD FD 08    LDA $08FD  [$7E:08FD]  ;\
$80:A1B8 8D 92 09    STA $0992  [$7E:0992]  ;} Blocks to update Y block = [layer 2 block Y]
$80:A1BB AD 0B 09    LDA $090B  [$7E:090B]  ;\
$80:A1BE 8D 94 09    STA $0994  [$7E:0994]  ;} VRAM blocks to update X block = [BG2 block X]
$80:A1C1 AD 0D 09    LDA $090D  [$7E:090D]  ;\
$80:A1C4 8D 96 09    STA $0996  [$7E:0996]  ;} VRAM blocks to update Y block = [BG2 block Y]
$80:A1C7 20 D6 A9    JSR $A9D6  [$80:A9D6]  ; Update background data column

$80:A1CA 22 83 8C 80 JSL $808C83[$80:8C83]  ; Handle VRAM write table and scrolling DMAs
$80:A1CE FA          PLX
$80:A1CF EE F7 08    INC $08F7  [$7E:08F7]  ; Increment layer 1 block X
$80:A1D2 EE 07 09    INC $0907  [$7E:0907]  ; Increment BG1 block X
$80:A1D5 EE FB 08    INC $08FB  [$7E:08FB]  ; Increment layer 2 block X
$80:A1D8 EE 0B 09    INC $090B  [$7E:090B]  ; Increment BG2 block X
$80:A1DB E8          INX                    ; Increment X
$80:A1DC E0 11 00    CPX #$0011             ;\
$80:A1DF D0 AC       BNE $AC    [$A18D]     ;} If [X] != 17: go to LOOP
$80:A1E1 28          PLP
$80:A1E2 6B          RTL
}


;;; $A1E3: Unused. Queue clearing of BG2 tilemap ;;;
{
$80:A1E3 A2 FE 0F    LDX #$0FFE             ;\
$80:A1E6 A9 38 03    LDA #$0338             ;|
                                            ;|
$80:A1E9 9F 00 40 7E STA $7E4000,x[$7E:4002];} $7E:4000..4FFF = 338h
$80:A1ED CA          DEX                    ;|
$80:A1EE CA          DEX                    ;|
$80:A1EF 10 F8       BPL $F8    [$A1E9]     ;/
$80:A1F1 AE 30 03    LDX $0330  [$7E:0330]  ;\
$80:A1F4 A9 00 10    LDA #$1000             ;|
$80:A1F7 95 D0       STA $D0,x              ;|
$80:A1F9 A9 00 40    LDA #$4000             ;|
$80:A1FC 95 D2       STA $D2,x              ;|
$80:A1FE A9 7E 00    LDA #$007E             ;|
$80:A201 95 D4       STA $D4,x              ;} Queue transfer of $7E:4000..4FFF to VRAM $4800..4FFF
$80:A203 A9 00 48    LDA #$4800             ;|
$80:A206 95 D5       STA $D5,x              ;|
$80:A208 8A          TXA                    ;|
$80:A209 18          CLC                    ;|
$80:A20A 69 07 00    ADC #$0007             ;|
$80:A20D 8D 30 03    STA $0330  [$7E:0330]  ;/
$80:A210 6B          RTL
}


;;; $A211: Queue clearing of FX tilemap ;;;
{
; Called by:
;     $82:8CEF: Game state Dh (pausing, loading pause screen)
$80:A211 A2 FE 0E    LDX #$0EFE             ;\
$80:A214 A9 4E 18    LDA #$184E             ;|
                                            ;|
$80:A217 9F 00 40 7E STA $7E4000,x[$7E:4EFE];} $7E:4000..4EFF = 184Eh
$80:A21B CA          DEX                    ;|
$80:A21C CA          DEX                    ;|
$80:A21D 10 F8       BPL $F8    [$A217]     ;/
$80:A21F AE 30 03    LDX $0330  [$7E:0330]  ;\
$80:A222 A9 00 0F    LDA #$0F00             ;|
$80:A225 95 D0       STA $D0,x  [$7E:00D7]  ;|
$80:A227 A9 00 40    LDA #$4000             ;|
$80:A22A 95 D2       STA $D2,x  [$7E:00D9]  ;|
$80:A22C A9 7E 00    LDA #$007E             ;|
$80:A22F 95 D4       STA $D4,x  [$7E:00DB]  ;} Queue transfer of $7E:4000..4EFF to VRAM $5880..5FFF
$80:A231 A9 80 58    LDA #$5880             ;|
$80:A234 95 D5       STA $D5,x  [$7E:00DC]  ;|
$80:A236 8A          TXA                    ;|
$80:A237 18          CLC                    ;|
$80:A238 69 07 00    ADC #$0007             ;|
$80:A23B 8D 30 03    STA $0330  [$7E:0330]  ;/
$80:A23E 6B          RTL
}


;;; $A23F: Clear BG2 tilemap ;;;
{
; Called by:
;     $A07B: Start gameplay
;     $82:EA56: Load library background - command Ah: clear BG2 tilemap
;     $82:EA5E: Load library background - command Ch: clear Kraid's layer 2

; Looks like $A27A is supposed to be LDA #$A29B
$80:A23F 08          PHP
$80:A240 C2 20       REP #$20
$80:A242 A9 00 48    LDA #$4800             ;\
$80:A245 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:A248 A9 08 18    LDA #$1808             ;|
$80:A24B 8D 10 43    STA $4310  [$7E:4310]  ;|
$80:A24E A9 9A A2    LDA #$A29A             ;|
$80:A251 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:A254 A9 80 00    LDA #$0080             ;|
$80:A257 8D 14 43    STA $4314  [$7E:4314]  ;} VRAM $4800..4FFF low bytes = 38h
$80:A25A A9 00 08    LDA #$0800             ;|
$80:A25D 8D 15 43    STA $4315  [$7E:4315]  ;|
$80:A260 E2 20       SEP #$20               ;|
$80:A262 A9 00       LDA #$00               ;|
$80:A264 8D 15 21    STA $2115  [$7E:2115]  ;|
$80:A267 A9 02       LDA #$02               ;|
$80:A269 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:A26C C2 20       REP #$20
$80:A26E A9 00 48    LDA #$4800             ;\
$80:A271 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:A274 A9 08 19    LDA #$1908             ;|
$80:A277 8D 10 43    STA $4310  [$7E:4310]  ;|
$80:A27A A9 9A A2    LDA #$A29A             ;|
$80:A27D 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:A280 A9 80 00    LDA #$0080             ;|
$80:A283 8D 14 43    STA $4314  [$7E:4314]  ;} VRAM $4800..4FFF high bytes = 38h
$80:A286 A9 00 08    LDA #$0800             ;|
$80:A289 8D 15 43    STA $4315  [$7E:4315]  ;|
$80:A28C E2 20       SEP #$20               ;|
$80:A28E A9 80       LDA #$80               ;|
$80:A290 8D 15 21    STA $2115  [$7E:2115]  ;|
$80:A293 A9 02       LDA #$02               ;|
$80:A295 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:A298 28          PLP
$80:A299 6B          RTL

$80:A29A             dw 0338
}


;;; $A29C: Clear FX tilemap ;;;
{
; Called by:
;     $82:E97C: Load library background
;     $82:EA4E: Load library background - command 6: clear FX tilemap
$80:A29C 08          PHP
$80:A29D C2 20       REP #$20
$80:A29F A9 80 58    LDA #$5880             ;\
$80:A2A2 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:A2A5 A9 08 18    LDA #$1808             ;|
$80:A2A8 8D 10 43    STA $4310  [$7E:4310]  ;|
$80:A2AB A9 F7 A2    LDA #$A2F7             ;|
$80:A2AE 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:A2B1 A9 80 00    LDA #$0080             ;|
$80:A2B4 8D 14 43    STA $4314  [$7E:4314]  ;} VRAM $5880..5FFF low bytes = 4Eh
$80:A2B7 A9 80 07    LDA #$0780             ;|
$80:A2BA 8D 15 43    STA $4315  [$7E:4315]  ;|
$80:A2BD E2 20       SEP #$20               ;|
$80:A2BF A9 00       LDA #$00               ;|
$80:A2C1 8D 15 21    STA $2115  [$7E:2115]  ;|
$80:A2C4 A9 02       LDA #$02               ;|
$80:A2C6 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:A2C9 C2 20       REP #$20
$80:A2CB A9 80 58    LDA #$5880             ;\
$80:A2CE 8D 16 21    STA $2116  [$7E:2116]  ;|
$80:A2D1 A9 08 19    LDA #$1908             ;|
$80:A2D4 8D 10 43    STA $4310  [$7E:4310]  ;|
$80:A2D7 A9 F8 A2    LDA #$A2F8             ;|
$80:A2DA 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:A2DD A9 80 00    LDA #$0080             ;|
$80:A2E0 8D 14 43    STA $4314  [$7E:4314]  ;} VRAM $5880..5FFF high bytes = 18h
$80:A2E3 A9 80 07    LDA #$0780             ;|
$80:A2E6 8D 15 43    STA $4315  [$7E:4315]  ;|
$80:A2E9 E2 20       SEP #$20               ;|
$80:A2EB A9 80       LDA #$80               ;|
$80:A2ED 8D 15 21    STA $2115  [$7E:2115]  ;|
$80:A2F0 A9 02       LDA #$02               ;|
$80:A2F2 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:A2F5 28          PLP
$80:A2F6 6B          RTL

$80:A2F7             dw 184E
}


;;; $A2F9..B031: Scrolling ;;;
{
;;; $A2F9: Calculate layer 2 X position ;;;
{
;; Returns:
;;     A:     [Layer 2 X position]
;;     Carry: Clear if BG2 needs to be scrolled

; Called by:
;     $A07B: Start gameplay
;     $A3AB: Calculate layer 2 position and BG scrolls and update BG graphics when scrolling
;     $AD4A: Door transition scrolling setup - right
;     $AD74: Door transition scrolling setup - left
;     $AD9E: Door transition scrolling setup - down
;     $ADC8: Door transition scrolling setup - up

; If [layer 2 scroll X] = 0:
;     Layer 2 X position = [layer 1 X position]
; Else if [layer 2 scroll X] = 1:
;     Carry is set (layer 2 X position unchanged)
; Else:
;     Layer 2 X position = [layer 1 X position] * ([layer 2 scroll X] >> 1) / 80h
$80:A2F9 08          PHP
$80:A2FA AC 11 09    LDY $0911  [$7E:0911]  ; Y = [layer 1 X position]
$80:A2FD E2 20       SEP #$20
$80:A2FF AD 1B 09    LDA $091B  [$7E:091B]  ;\
$80:A302 F0 2A       BEQ $2A    [$A32E]     ;} If [layer 2 scroll X] != 0:
$80:A304 C9 01       CMP #$01               ;\
$80:A306 F0 2F       BEQ $2F    [$A337]     ;} If [layer 2 scroll X] = 1: return carry set
$80:A308 29 FE       AND #$FE               ;\
$80:A30A 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A30D AD 11 09    LDA $0911  [$7E:0911]  ;|
$80:A310 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A313 9C 34 09    STZ $0934  [$7E:0934]  ;} $0933 = [layer 1 X position] % 0x100 * ([layer 2 scroll X] & ~1) / 100h
$80:A316 48          PHA                    ;|
$80:A317 68          PLA                    ;|
$80:A318 AD 17 42    LDA $4217  [$7E:4217]  ;|
$80:A31B 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:A31E AD 12 09    LDA $0912  [$7E:0912]  ;\
$80:A321 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A324 C2 20       REP #$20               ;|
$80:A326 AD 33 09    LDA $0933  [$7E:0933]  ;} Y = [$0933] + [layer 1 X position] / 100h * ([layer 2 scroll X] & ~1)
$80:A329 18          CLC                    ;|
$80:A32A 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A32D A8          TAY                    ;/

$80:A32E C2 20       REP #$20
$80:A330 98          TYA                    ;\
$80:A331 8D 17 09    STA $0917  [$7E:0917]  ;} Layer 2 X position = [Y]
$80:A334 28          PLP                    ;\
$80:A335 18          CLC                    ;} Return carry clear
$80:A336 60          RTS                    ;/

$80:A337 28          PLP                    ;\
$80:A338 38          SEC                    ;} Return carry set
$80:A339 60          RTS                    ;/
}


;;; $A33A: Calculate layer 2 Y position ;;;
{
;; Returns:
;;     Carry: Clear if BG2 needs to be scrolled
;;     A:     [Layer 2 Y position]

; Called by:
;     $A07B: Start gameplay
;     $A3AB: Calculate layer 2 position and BG scrolls and update BG graphics when scrolling
;     $AD4A: Door transition scrolling setup - right
;     $AD74: Door transition scrolling setup - left
;     $AD9E: Door transition scrolling setup - down
;     $ADC8: Door transition scrolling setup - up

; If [layer 2 scroll Y] = 0:
;     Layer 2 Y position = [layer 1 Y position]
; Else if [layer 2 scroll Y] = 1:
;     Carry is set (layer 2 Y position unchanged)
; Else:
;     Layer 2 Y position = [layer 1 Y position] * ([layer 2 scroll Y] >> 1) / 80h
$80:A33A 08          PHP
$80:A33B AC 15 09    LDY $0915  [$7E:0915]  ; Y = [layer 1 Y position]
$80:A33E E2 20       SEP #$20
$80:A340 AD 1C 09    LDA $091C  [$7E:091C]  ;\
$80:A343 F0 2A       BEQ $2A    [$A36F]     ;} If [layer 2 scroll Y] != 0:
$80:A345 C9 01       CMP #$01               ;\
$80:A347 F0 2F       BEQ $2F    [$A378]     ;} If [layer 2 scroll Y] = 1: return carry set
$80:A349 29 FE       AND #$FE               ;\
$80:A34B 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A34E AD 15 09    LDA $0915  [$7E:0915]  ;|
$80:A351 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A354 9C 34 09    STZ $0934  [$7E:0934]  ;} $0933 = [layer 1 Y position] % 0x100 * ([layer 2 scroll Y] & ~1) / 100h
$80:A357 48          PHA                    ;|
$80:A358 68          PLA                    ;|
$80:A359 AD 17 42    LDA $4217  [$7E:4217]  ;|
$80:A35C 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:A35F AD 16 09    LDA $0916  [$7E:0916]  ;\
$80:A362 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A365 C2 20       REP #$20               ;|
$80:A367 AD 33 09    LDA $0933  [$7E:0933]  ;} Y = [$0933] + [layer 1 Y position] / 100h * ([layer 2 scroll Y] & ~1)
$80:A36A 18          CLC                    ;|
$80:A36B 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A36E A8          TAY                    ;/

$80:A36F C2 20       REP #$20
$80:A371 98          TYA                    ;\
$80:A372 8D 19 09    STA $0919  [$7E:0919]  ;} Layer 2 Y position = [Y]
$80:A375 28          PLP                    ;\
$80:A376 18          CLC                    ;} Return carry clear
$80:A377 60          RTS                    ;/

$80:A378 28          PLP                    ;\
$80:A379 38          SEC                    ;} Return carry set
$80:A37A 60          RTS                    ;/
}


;;; $A37B: Calculate BG scrolls ;;;
{
; Called by:
;     $A07B: Start gameplay
;     $A3A0: Calculate BG scrolls and update BG graphics when scrolling (door transition)
$80:A37B AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A37E 18          CLC                    ;|
$80:A37F 6D 1D 09    ADC $091D  [$7E:091D]  ;} BG1 X scroll = [layer 1 X position] + [BG1 X offset]
$80:A382 85 B1       STA $B1    [$7E:00B1]  ;/
$80:A384 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A387 18          CLC                    ;|
$80:A388 6D 1F 09    ADC $091F  [$7E:091F]  ;} BG1 Y scroll = [layer 1 Y position] + [BG1 Y offset]
$80:A38B 85 B3       STA $B3    [$7E:00B3]  ;/
$80:A38D AD 17 09    LDA $0917  [$7E:0917]  ;\
$80:A390 18          CLC                    ;|
$80:A391 6D 21 09    ADC $0921  [$7E:0921]  ;} BG2 X scroll = [layer 2 X position] + [BG2 X offset]
$80:A394 85 B5       STA $B5    [$7E:00B5]  ;/
$80:A396 AD 19 09    LDA $0919  [$7E:0919]  ;\
$80:A399 18          CLC                    ;|
$80:A39A 6D 23 09    ADC $0923  [$7E:0923]  ;} BG2 Y scroll = [layer 2 Y position] + [BG2 Y offset]
$80:A39D 85 B7       STA $B7    [$7E:00B7]  ;/
$80:A39F 60          RTS
}


;;; $A3A0: Calculate BG scrolls and update BG graphics when scrolling ;;;
{
; Called by:
;     $AE7E: Door transition scrolling - right
;     $AEC2: Door transition scrolling - left
;     $AF02: Door transition scrolling - down
;     $AF89: Door transition scrolling - up
$80:A3A0 08          PHP
$80:A3A1 8B          PHB
$80:A3A2 4B          PHK
$80:A3A3 AB          PLB
$80:A3A4 C2 30       REP #$30
$80:A3A6 20 7B A3    JSR $A37B  [$80:A37B]  ; Calculate BG scrolls
$80:A3A9 80 34       BRA $34    [$A3DF]     ; Go to update BG graphics when scrolling
}


;;; $A3AB: Calculate layer 2 position and BG scrolls and update BG graphics when scrolling ;;;
{
; Called by
;     $82:8B44: Game state 8 (main gameplay)
;     $82:E310: Handles door transitions - scroll screen to alignment
;     $82:E675
$80:A3AB AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$80:A3AE F0 01       BEQ $01    [$A3B1]     ;} If time frozen: return
$80:A3B0 6B          RTL                    ;/

$80:A3B1 08          PHP
$80:A3B2 8B          PHB
$80:A3B3 4B          PHK
$80:A3B4 AB          PLB
$80:A3B5 C2 30       REP #$30
$80:A3B7 AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A3BA 18          CLC                    ;|
$80:A3BB 6D 1D 09    ADC $091D  [$7E:091D]  ;} BG1 X scroll = [layer 1 X position] + [BG1 X offset]
$80:A3BE 85 B1       STA $B1    [$7E:00B1]  ;/
$80:A3C0 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A3C3 18          CLC                    ;|
$80:A3C4 6D 1F 09    ADC $091F  [$7E:091F]  ;} BG1 Y scroll = [layer 1 Y position] + [BG1 Y offset]
$80:A3C7 85 B3       STA $B3    [$7E:00B3]  ;/
$80:A3C9 20 F9 A2    JSR $A2F9  [$80:A2F9]  ; Calculate layer 2 X position
$80:A3CC B0 06       BCS $06    [$A3D4]     ; If BG2 needs to be scrolled:
$80:A3CE 18          CLC                    ;\
$80:A3CF 6D 21 09    ADC $0921  [$7E:0921]  ;} BG2 X scroll = [layer 2 X position] + [BG2 X offset]
$80:A3D2 85 B5       STA $B5    [$7E:00B5]  ;/

$80:A3D4 20 3A A3    JSR $A33A  [$80:A33A]  ; Calculate layer 2 Y position
$80:A3D7 B0 06       BCS $06    [$A3DF]     ; If BG2 needs to be scrolled:
$80:A3D9 18          CLC                    ;\
$80:A3DA 6D 23 09    ADC $0923  [$7E:0923]  ;} BG2 Y scroll = [layer 2 Y position] + [BG2 Y offset]
$80:A3DD 85 B7       STA $B7    [$7E:00B7]  ;/
}


;;; $A3DF: Update BG graphics when scrolling ;;;
{
; Called by:
;     $A3A0: Calculate BG scrolls and update BG graphics when scrolling
;     $A3AB: Calculate layer 2 position and BG scrolls and update BG graphics when scrolling

; Calculates new BG and layer positions,
; calls the update level/background data row/column functions
; and updates the previous layer 1/2 block X/Y values
$80:A3DF C2 20       REP #$20
$80:A3E1 20 BB A4    JSR $A4BB  [$80:A4BB]  ; Calculate BG and layer position blocks
$80:A3E4 A2 00 00    LDX #$0000
$80:A3E7 AD F7 08    LDA $08F7  [$7E:08F7]  ;\
$80:A3EA CD FF 08    CMP $08FF  [$7E:08FF]  ;} If [layer 1 block X] = [previous layer 1 block X]: go to BRANCH_LAYER_1_HORIZONTAL_END
$80:A3ED F0 27       BEQ $27    [$A416]     ;/
$80:A3EF 8D FF 08    STA $08FF  [$7E:08FF]  ; Previous layer 1 block X = [layer 1 block X]
$80:A3F2 30 03       BMI $03    [$A3F7]     ;\
$80:A3F4 A2 10 00    LDX #$0010             ;} If scrolled rightwards: X = 10h, else X = 0

$80:A3F7 8A          TXA                    ;\
$80:A3F8 18          CLC                    ;|
$80:A3F9 6D F7 08    ADC $08F7  [$7E:08F7]  ;} Blocks to update X block = [layer 1 block X] + [X]
$80:A3FC 8D 90 09    STA $0990  [$7E:0990]  ;/
$80:A3FF 8A          TXA                    ;\
$80:A400 18          CLC                    ;|
$80:A401 6D 07 09    ADC $0907  [$7E:0907]  ;} VRAM blocks to update X block = [BG1 block X] + [X]
$80:A404 8D 94 09    STA $0994  [$7E:0994]  ;/
$80:A407 AD F9 08    LDA $08F9  [$7E:08F9]  ;\
$80:A40A 8D 92 09    STA $0992  [$7E:0992]  ;} Blocks to update Y block = [layer 1 block Y]
$80:A40D AD 09 09    LDA $0909  [$7E:0909]  ;\
$80:A410 8D 96 09    STA $0996  [$7E:0996]  ;} VRAM blocks to update Y block = [BG1 block Y]
$80:A413 20 DB A9    JSR $A9DB  [$80:A9DB]  ; Update level data column

; BRANCH_LAYER_1_HORIZONTAL_END
$80:A416 AD 1B 09    LDA $091B  [$7E:091B]  ;\
$80:A419 4A          LSR A                  ;} If not using custom layer 2: go to BRANCH_LAYER_2_HORIZONTAL_END
$80:A41A B0 32       BCS $32    [$A44E]     ;/
$80:A41C A2 00 00    LDX #$0000
$80:A41F AD FB 08    LDA $08FB  [$7E:08FB]  ;\
$80:A422 CD 03 09    CMP $0903  [$7E:0903]  ;} If [layer 2 block X] = [previous layer 2 block X]: go to BRANCH_LAYER_2_HORIZONTAL_END
$80:A425 F0 27       BEQ $27    [$A44E]     ;/
$80:A427 8D 03 09    STA $0903  [$7E:0903]  ; Previous layer 2 block X = [layer 2 block X]
$80:A42A 30 03       BMI $03    [$A42F]     ;\
$80:A42C A2 10 00    LDX #$0010             ;} If scrolled rightwards: X = 10h, else X = 0

$80:A42F 8A          TXA                    ;\
$80:A430 18          CLC                    ;|
$80:A431 6D FB 08    ADC $08FB  [$7E:08FB]  ;} Blocks to update X block = [layer 2 block X] + [X]
$80:A434 8D 90 09    STA $0990  [$7E:0990]  ;/
$80:A437 8A          TXA                    ;\
$80:A438 18          CLC                    ;|
$80:A439 6D 0B 09    ADC $090B  [$7E:090B]  ;} VRAM blocks to update X block = [BG2 block X] + [X]
$80:A43C 8D 94 09    STA $0994  [$7E:0994]  ;/
$80:A43F AD FD 08    LDA $08FD  [$7E:08FD]  ;\
$80:A442 8D 92 09    STA $0992  [$7E:0992]  ;} Blocks to update Y block = [layer 2 block Y]
$80:A445 AD 0D 09    LDA $090D  [$7E:090D]  ;\
$80:A448 8D 96 09    STA $0996  [$7E:0996]  ;} VRAM blocks to update Y block = [BG2 block Y]
$80:A44B 20 D6 A9    JSR $A9D6  [$80:A9D6]  ; Update background data column

; BRANCH_LAYER_2_HORIZONTAL_END
$80:A44E A2 01 00    LDX #$0001
$80:A451 AD F9 08    LDA $08F9  [$7E:08F9]  ;\
$80:A454 CD 01 09    CMP $0901  [$7E:0901]  ;} If [layer 1 block Y] = [previous layer 1 block Y]: go to BRANCH_LAYER_1_VERTICAL_END
$80:A457 F0 27       BEQ $27    [$A480]     ;/
$80:A459 8D 01 09    STA $0901  [$7E:0901]  ; Previous layer 1 block Y = [layer 1 block Y]
$80:A45C 30 03       BMI $03    [$A461]     ;\
$80:A45E A2 0F 00    LDX #$000F             ;} If scrolled down: X = Fh, else X = 1

$80:A461 8A          TXA                    ;\
$80:A462 18          CLC                    ;|
$80:A463 6D F9 08    ADC $08F9  [$7E:08F9]  ;} Blocks to update Y block = [layer 1 block Y] + [X]
$80:A466 8D 92 09    STA $0992  [$7E:0992]  ;/
$80:A469 8A          TXA                    ;\
$80:A46A 18          CLC                    ;|
$80:A46B 6D 09 09    ADC $0909  [$7E:0909]  ;} VRAM blocks to update Y block = [BG1 block Y] + [X]
$80:A46E 8D 96 09    STA $0996  [$7E:0996]  ;/
$80:A471 AD F7 08    LDA $08F7  [$7E:08F7]  ;\
$80:A474 8D 90 09    STA $0990  [$7E:0990]  ;} Blocks to update X block = [layer 1 block X]
$80:A477 AD 07 09    LDA $0907  [$7E:0907]  ;\
$80:A47A 8D 94 09    STA $0994  [$7E:0994]  ;} VRAM blocks to update X block = [BG1 block X]
$80:A47D 20 75 AB    JSR $AB75  [$80:AB75]  ; Update level data row

; BRANCH_LAYER_1_VERTICAL_END
$80:A480 AD 1C 09    LDA $091C  [$7E:091C]  ;\
$80:A483 4A          LSR A                  ;} If not using custom layer 2: return
$80:A484 B0 32       BCS $32    [$A4B8]     ;/
$80:A486 A2 01 00    LDX #$0001
$80:A489 AD FD 08    LDA $08FD  [$7E:08FD]  ;\
$80:A48C CD 05 09    CMP $0905  [$7E:0905]  ;} If [layer 2 block Y] = [previous layer 2 block Y]: return
$80:A48F F0 27       BEQ $27    [$A4B8]     ;/
$80:A491 8D 05 09    STA $0905  [$7E:0905]  ; Previous layer 2 block Y = [layer 2 block Y]
$80:A494 30 03       BMI $03    [$A499]     ;\
$80:A496 A2 0F 00    LDX #$000F             ;} If scrolled down: X = Fh, else X = 1

$80:A499 8A          TXA                    ;\
$80:A49A 18          CLC                    ;|
$80:A49B 6D FD 08    ADC $08FD  [$7E:08FD]  ;} Blocks to update Y block = [layer 2 block Y] + [X]
$80:A49E 8D 92 09    STA $0992  [$7E:0992]  ;/
$80:A4A1 8A          TXA                    ;\
$80:A4A2 18          CLC                    ;|
$80:A4A3 6D 0D 09    ADC $090D  [$7E:090D]  ;} VRAM blocks to update Y block = [BG2 block Y] + [X]
$80:A4A6 8D 96 09    STA $0996  [$7E:0996]  ;/
$80:A4A9 AD FB 08    LDA $08FB  [$7E:08FB]  ;\
$80:A4AC 8D 90 09    STA $0990  [$7E:0990]  ;} Blocks to update X block = [layer 2 block X]
$80:A4AF AD 0B 09    LDA $090B  [$7E:090B]  ;\
$80:A4B2 8D 94 09    STA $0994  [$7E:0994]  ;} VRAM blocks to update X block = [BG2 block X]
$80:A4B5 20 70 AB    JSR $AB70  [$80:AB70]  ; Update background data row

$80:A4B8 AB          PLB
$80:A4B9 28          PLP
$80:A4BA 6B          RTL
}


;;; $A4BB: Calculate BG scroll and layer position blocks ;;;
{
; Called by:
;     $A176: Display the viewable part of the room
;     $A3DF: Update BG graphics when scrolling
;     $AD1D: Draw top row of screen for upwards door transition
;     $AD4A: Door transition scrolling setup - right
;     $AD74: Door transition scrolling setup - left
;     $AD9E: Door transition scrolling setup - down
;     $ADC8: Door transition scrolling setup - up
;     $AF02: Door transition scrolling - down
;     $AF89: Door transition scrolling - up
$80:A4BB A5 B1       LDA $B1    [$7E:00B1]  ;\
$80:A4BD 4A          LSR A                  ;|
$80:A4BE 4A          LSR A                  ;|
$80:A4BF 4A          LSR A                  ;} BG1 X block = [BG1 X scroll] / 10h
$80:A4C0 4A          LSR A                  ;|
$80:A4C1 8D 07 09    STA $0907  [$7E:0907]  ;/
$80:A4C4 A5 B5       LDA $B5    [$7E:00B5]  ;\
$80:A4C6 4A          LSR A                  ;|
$80:A4C7 4A          LSR A                  ;|
$80:A4C8 4A          LSR A                  ;} BG2 X block = [BG2 X scroll] / 10h
$80:A4C9 4A          LSR A                  ;|
$80:A4CA 8D 0B 09    STA $090B  [$7E:090B]  ;/
$80:A4CD AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A4D0 4A          LSR A                  ;|
$80:A4D1 4A          LSR A                  ;|
$80:A4D2 4A          LSR A                  ;|
$80:A4D3 4A          LSR A                  ;|
$80:A4D4 89 00 08    BIT #$0800             ;} Layer 1 X block = [layer 1 X position] / 10h
$80:A4D7 F0 03       BEQ $03    [$A4DC]     ;|
$80:A4D9 09 00 F0    ORA #$F000             ;|
                                            ;|
$80:A4DC 8D F7 08    STA $08F7  [$7E:08F7]  ;/
$80:A4DF AD 17 09    LDA $0917  [$7E:0917]  ;\
$80:A4E2 4A          LSR A                  ;|
$80:A4E3 4A          LSR A                  ;|
$80:A4E4 4A          LSR A                  ;|
$80:A4E5 4A          LSR A                  ;|
$80:A4E6 89 00 08    BIT #$0800             ;} Layer 2 X block = [layer 2 X position] / 10h
$80:A4E9 F0 03       BEQ $03    [$A4EE]     ;|
$80:A4EB 09 00 F0    ORA #$F000             ;|
                                            ;|
$80:A4EE 8D FB 08    STA $08FB  [$7E:08FB]  ;/
$80:A4F1 A5 B3       LDA $B3    [$7E:00B3]  ;\
$80:A4F3 4A          LSR A                  ;|
$80:A4F4 4A          LSR A                  ;|
$80:A4F5 4A          LSR A                  ;} BG1 Y block = [BG1 Y scroll] / 10h
$80:A4F6 4A          LSR A                  ;|
$80:A4F7 8D 09 09    STA $0909  [$7E:0909]  ;/
$80:A4FA A5 B7       LDA $B7    [$7E:00B7]  ;\
$80:A4FC 4A          LSR A                  ;|
$80:A4FD 4A          LSR A                  ;|
$80:A4FE 4A          LSR A                  ;} BG2 Y block = [BG2 Y scroll] / 10h
$80:A4FF 4A          LSR A                  ;|
$80:A500 8D 0D 09    STA $090D  [$7E:090D]  ;/
$80:A503 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A506 4A          LSR A                  ;|
$80:A507 4A          LSR A                  ;|
$80:A508 4A          LSR A                  ;|
$80:A509 4A          LSR A                  ;|
$80:A50A 89 00 08    BIT #$0800             ;} Layer 1 Y block = [layer 1 Y position] / 10h
$80:A50D F0 03       BEQ $03    [$A512]     ;|
$80:A50F 09 00 F0    ORA #$F000             ;|
                                            ;|
$80:A512 8D F9 08    STA $08F9  [$7E:08F9]  ;/
$80:A515 AD 19 09    LDA $0919  [$7E:0919]  ;\
$80:A518 4A          LSR A                  ;|
$80:A519 4A          LSR A                  ;|
$80:A51A 4A          LSR A                  ;|
$80:A51B 4A          LSR A                  ;|
$80:A51C 89 00 08    BIT #$0800             ;} Layer 2 Y block = [layer 2 Y position] / 10h
$80:A51F F0 03       BEQ $03    [$A524]     ;|
$80:A521 09 00 F0    ORA #$F000             ;|
                                            ;|
$80:A524 8D FD 08    STA $08FD  [$7E:08FD]  ;/
$80:A527 60          RTS
}


;;; $A528: Handle scroll zones - horizontal autoscrolling ;;;
{
; Called by:
;     $90:94EC: Main scrolling routine
;     $90:95A0: Handle horizontal scrolling

; If time frozen:
;     Return
;
; Layer 1 X position = clamp([layer 1 X position], 0, (room width in pixels) - 100h)
;
; If layer 1 position + 1/2 scroll down's scroll = red:
; {
;     $0933 = position of right scroll boundary
;     $0939 = [layer 1 X position] + [camera X speed] + 2
;     Layer 1 X position = min([$0939], [$0933])
;     If [$0939] < [$0933] and layer 1 position + 1/2 scroll down + 1 scroll right's scroll = red:
;         Round layer 1 X position to left scroll boundary
; }
; Else if layer 1 position + 1/2 scroll down + 1 scroll right's scroll = red:
; {
;     $0933 = position of left scroll boundary
;     $0939 = [layer 1 X position] - [camera X speed] - 2
;     Layer 1 X position = max([$0939], [$0933])
;     If [$0939] >= [$0933] and layer 1 position + 1/2 scroll down's scroll = red:
;         Layer 1 X position = [$0939] rounded to right scroll boundary
; }

$80:A528 08          PHP
$80:A529 8B          PHB
$80:A52A E2 20       SEP #$20
$80:A52C AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$80:A52F 0D 79 0A    ORA $0A79  [$7E:0A79]  ;|
$80:A532 F0 03       BEQ $03    [$A537]     ;} If time frozen: return
$80:A534 4C 3E A6    JMP $A63E  [$80:A63E]  ;/

$80:A537 A9 8F       LDA #$8F               ;\
$80:A539 48          PHA                    ;} DB = $8F
$80:A53A AB          PLB                    ;/
$80:A53B C2 30       REP #$30
$80:A53D AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A540 8D 39 09    STA $0939  [$7E:0939]  ;} $0939 = [layer 1 X position]
$80:A543 10 03       BPL $03    [$A548]     ;\
$80:A545 9C 11 09    STZ $0911  [$7E:0911]  ;} Layer 1 X position = max([layer 1 X position], 0)

$80:A548 AD A9 07    LDA $07A9  [$7E:07A9]  ;\
$80:A54B 3A          DEC A                  ;|
$80:A54C EB          XBA                    ;|
$80:A54D CD 11 09    CMP $0911  [$7E:0911]  ;} Layer 1 X position = min([layer 1 X position], (room width in pixels) - 100h)
$80:A550 B0 03       BCS $03    [$A555]     ;|
$80:A552 8D 11 09    STA $0911  [$7E:0911]  ;/

$80:A555 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A558 18          CLC                    ;|
$80:A559 69 80 00    ADC #$0080             ;|
$80:A55C EB          XBA                    ;|
$80:A55D E2 20       SEP #$20               ;|
$80:A55F 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A562 AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A565 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A568 C2 20       REP #$20               ;} If layer 1 position + 1/2 scroll down's scroll != red: go to BRANCH_UNBOUNDED_FROM_LEFT
$80:A56A AD 12 09    LDA $0912  [$7E:0912]  ;|
$80:A56D 29 FF 00    AND #$00FF             ;|
$80:A570 18          CLC                    ;|
$80:A571 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A574 AA          TAX                    ;|
$80:A575 BF 20 CD 7E LDA $7ECD20,x[$7E:CD20];|
$80:A579 29 FF 00    AND #$00FF             ;|
$80:A57C D0 5B       BNE $5B    [$A5D9]     ;/
$80:A57E AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A581 29 00 FF    AND #$FF00             ;|
$80:A584 18          CLC                    ;} $0933 = position of right scroll boundary
$80:A585 69 00 01    ADC #$0100             ;|
$80:A588 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:A58B AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A58E 18          CLC                    ;|
$80:A58F 6D A2 0D    ADC $0DA2  [$7E:0DA2]  ;|
$80:A592 69 02 00    ADC #$0002             ;} If [$0939] + [camera X speed] + 2 >= (position of right scroll boundary): go to BRANCH_REACHED_RIGHT_SCROLL_BOUNDARY
$80:A595 CD 33 09    CMP $0933  [$7E:0933]  ;|
$80:A598 B0 3A       BCS $3A    [$A5D4]     ;/
$80:A59A 8D 39 09    STA $0939  [$7E:0939]  ; $0939 += [camera X speed] + 2
$80:A59D AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A5A0 18          CLC                    ;|
$80:A5A1 69 80 00    ADC #$0080             ;|
$80:A5A4 EB          XBA                    ;|
$80:A5A5 E2 20       SEP #$20               ;|
$80:A5A7 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A5AA AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A5AD 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A5B0 C2 20       REP #$20               ;|
$80:A5B2 AD 3A 09    LDA $093A  [$7E:093A]  ;} If new layer 1 position + 1/2 scroll down + 1 scroll right's scroll = red:
$80:A5B5 1A          INC A                  ;|
$80:A5B6 29 FF 00    AND #$00FF             ;|
$80:A5B9 18          CLC                    ;|
$80:A5BA 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A5BD AA          TAX                    ;|
$80:A5BE BF 20 CD 7E LDA $7ECD20,x[$7E:CD2D];|
$80:A5C2 29 FF 00    AND #$00FF             ;|
$80:A5C5 D0 08       BNE $08    [$A5CF]     ;/
$80:A5C7 AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A5CA 29 00 FF    AND #$FF00             ;} Layer 1 X position = [$0939] rounded to left scroll boundary
$80:A5CD 80 6C       BRA $6C    [$A63B]     ; Return

$80:A5CF AD 39 09    LDA $0939  [$7E:0939]  ; Layer 1 X position = [$0939]
$80:A5D2 80 67       BRA $67    [$A63B]     ; Return

; BRANCH_REACHED_RIGHT_SCROLL_BOUNDARY
$80:A5D4 AD 33 09    LDA $0933  [$7E:0933]  ; Layer 1 X position = (position of right scroll boundary)
$80:A5D7 80 62       BRA $62    [$A63B]     ; Return

; BRANCH_UNBOUNDED_FROM_LEFT
$80:A5D9 E8          INX                    ;\
$80:A5DA BF 20 CD 7E LDA $7ECD20,x[$7E:CD21];|
$80:A5DE 29 FF 00    AND #$00FF             ;} If layer 1 position + 1/2 scroll down + 1 scroll right's scroll != red: return
$80:A5E1 D0 5B       BNE $5B    [$A63E]     ;/
$80:A5E3 AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A5E6 29 00 FF    AND #$FF00             ;} $0933 = position of left scroll boundary
$80:A5E9 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:A5EC AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A5EF 38          SEC                    ;|
$80:A5F0 ED A2 0D    SBC $0DA2  [$7E:0DA2]  ;|
$80:A5F3 E9 02 00    SBC #$0002             ;} If [$0939] - [camera X speed] - 2 < (position of left scroll boundary): go to BRANCH_REACHED_LEFT_SCROLL_BOUNDARY
$80:A5F6 CD 33 09    CMP $0933  [$7E:0933]  ;|
$80:A5F9 30 3D       BMI $3D    [$A638]     ;/
$80:A5FB 8D 39 09    STA $0939  [$7E:0939]  ; $0939 -= [camera X speed] + 2
$80:A5FE AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A601 18          CLC                    ;|
$80:A602 69 80 00    ADC #$0080             ;|
$80:A605 EB          XBA                    ;|
$80:A606 E2 20       SEP #$20               ;|
$80:A608 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A60B AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A60E 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A611 C2 20       REP #$20               ;} If new layer 1 position + 1/2 scroll down's scroll = red:
$80:A613 AD 3A 09    LDA $093A  [$7E:093A]  ;|
$80:A616 29 FF 00    AND #$00FF             ;|
$80:A619 18          CLC                    ;|
$80:A61A 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A61D AA          TAX                    ;|
$80:A61E BF 20 CD 7E LDA $7ECD20,x[$7E:CD21];|
$80:A622 29 FF 00    AND #$00FF             ;|
$80:A625 D0 0C       BNE $0C    [$A633]     ;/
$80:A627 AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A62A 29 00 FF    AND #$FF00             ;|
$80:A62D 18          CLC                    ;} Layer 1 X position = [$0939] rounded to right scroll boundary
$80:A62E 69 00 01    ADC #$0100             ;/
$80:A631 80 08       BRA $08    [$A63B]     ; Return

$80:A633 AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A636 80 03       BRA $03    [$A63B]     ;} Layer 1 X position = [$0939]

; BRANCH_REACHED_LEFT_SCROLL_BOUNDARY
$80:A638 AD 33 09    LDA $0933  [$7E:0933]  ; Layer 1 X position = (position of left scroll boundary)

$80:A63B 8D 11 09    STA $0911  [$7E:0911]

$80:A63E AB          PLB
$80:A63F 28          PLP
$80:A640 6B          RTL
}


;;; $A641: Handle scroll zones - scrolling right ;;;
{
; Called by:
;     $90:95A0: Handle horizontal scrolling
$80:A641 08          PHP
$80:A642 8B          PHB
$80:A643 E2 20       SEP #$20
$80:A645 A9 8F       LDA #$8F               ;\
$80:A647 48          PHA                    ;} DB = $8F
$80:A648 AB          PLB                    ;/
$80:A649 C2 30       REP #$30
$80:A64B AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A64E 8D 39 09    STA $0939  [$7E:0939]  ;} $0939 = [layer 1 X position]
$80:A651 AD 0A 0B    LDA $0B0A  [$7E:0B0A]  ;\
$80:A654 CD 11 09    CMP $0911  [$7E:0911]  ;|
$80:A657 10 09       BPL $09    [$A662]     ;|
$80:A659 AD 0A 0B    LDA $0B0A  [$7E:0B0A]  ;} Layer 1 X position = min([layer 1 X position], [ideal layer 1 X position])
$80:A65C 8D 11 09    STA $0911  [$7E:0911]  ;|
$80:A65F 9C 0F 09    STZ $090F  [$7E:090F]  ;/

$80:A662 AD A9 07    LDA $07A9  [$7E:07A9]  ;\
$80:A665 3A          DEC A                  ;|
$80:A666 EB          XBA                    ;} If [layer 1 position] > (room width in pixels) - 100h:
$80:A667 CD 11 09    CMP $0911  [$7E:0911]  ;|
$80:A66A B0 05       BCS $05    [$A671]     ;/
$80:A66C 8D 11 09    STA $0911  [$7E:0911]  ; Layer 1 X position = (room width in pixels) - 100h
$80:A66F 80 47       BRA $47    [$A6B8]     ; Return

$80:A671 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A674 18          CLC                    ;|
$80:A675 69 80 00    ADC #$0080             ;|
$80:A678 EB          XBA                    ;|
$80:A679 E2 20       SEP #$20               ;|
$80:A67B 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A67E AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A681 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A684 C2 20       REP #$20               ;} If layer 1 position + 1/2 scroll down + 1 scroll right's scroll = red:
$80:A686 AD 12 09    LDA $0912  [$7E:0912]  ;|
$80:A689 29 FF 00    AND #$00FF             ;|
$80:A68C 38          SEC                    ;|
$80:A68D 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A690 AA          TAX                    ;|
$80:A691 BF 20 CD 7E LDA $7ECD20,x[$7E:CD21];|
$80:A695 29 FF 00    AND #$00FF             ;|
$80:A698 D0 1E       BNE $1E    [$A6B8]     ;/
$80:A69A AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A69D 29 00 FF    AND #$FF00             ;} $0933 = position of left scroll boundary
$80:A6A0 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:A6A3 AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A6A6 38          SEC                    ;|
$80:A6A7 ED A2 0D    SBC $0DA2  [$7E:0DA2]  ;|
$80:A6AA E9 02 00    SBC #$0002             ;|
$80:A6AD CD 33 09    CMP $0933  [$7E:0933]  ;} Layer 1 X position = max([$0933], [$0939] - [camera X speed] - 2)
$80:A6B0 10 03       BPL $03    [$A6B5]     ;|
$80:A6B2 AD 33 09    LDA $0933  [$7E:0933]  ;|
                                            ;|
$80:A6B5 8D 11 09    STA $0911  [$7E:0911]  ;/

$80:A6B8 AB          PLB
$80:A6B9 28          PLP
$80:A6BA 6B          RTL
}


;;; $A6BB: Handle scroll zones - scrolling left ;;;
{
; Called by:
;     $90:95A0: Handle horizontal scrolling
$80:A6BB 08          PHP
$80:A6BC 8B          PHB
$80:A6BD E2 20       SEP #$20
$80:A6BF A9 8F       LDA #$8F               ;\
$80:A6C1 48          PHA                    ;} DB = $8F
$80:A6C2 AB          PLB                    ;/
$80:A6C3 C2 30       REP #$30
$80:A6C5 AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A6C8 8D 39 09    STA $0939  [$7E:0939]  ;} $0939 = [layer 1 X position]
$80:A6CB CD 0A 0B    CMP $0B0A  [$7E:0B0A]  ;\
$80:A6CE 10 09       BPL $09    [$A6D9]     ;|
$80:A6D0 AD 0A 0B    LDA $0B0A  [$7E:0B0A]  ;} Layer 1 X position = max([layer 1 X position], [ideal layer 1 X position])
$80:A6D3 8D 11 09    STA $0911  [$7E:0911]  ;|
$80:A6D6 9C 0F 09    STZ $090F  [$7E:090F]  ;/

$80:A6D9 AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A6DC 10 05       BPL $05    [$A6E3]     ;} If [layer 1 position] < 0:
$80:A6DE 9C 11 09    STZ $0911  [$7E:0911]  ; Layer 1 X position = 0
$80:A6E1 80 4B       BRA $4B    [$A72E]     ; Return

$80:A6E3 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A6E6 18          CLC                    ;|
$80:A6E7 69 80 00    ADC #$0080             ;|
$80:A6EA EB          XBA                    ;|
$80:A6EB E2 20       SEP #$20               ;|
$80:A6ED 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A6F0 AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A6F3 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A6F6 C2 20       REP #$20               ;} If layer 1 position + 1/2 screen down's scroll = red:
$80:A6F8 AD 12 09    LDA $0912  [$7E:0912]  ;|
$80:A6FB 29 FF 00    AND #$00FF             ;|
$80:A6FE 18          CLC                    ;|
$80:A6FF 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A702 AA          TAX                    ;|
$80:A703 BF 20 CD 7E LDA $7ECD20,x[$7E:CD20];|
$80:A707 29 FF 00    AND #$00FF             ;|
$80:A70A D0 22       BNE $22    [$A72E]     ;/
$80:A70C AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A70F 29 00 FF    AND #$FF00             ;|
$80:A712 18          CLC                    ;} $0933 = position of right scroll boundary
$80:A713 69 00 01    ADC #$0100             ;|
$80:A716 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:A719 AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A71C 18          CLC                    ;|
$80:A71D 6D A2 0D    ADC $0DA2  [$7E:0DA2]  ;|
$80:A720 69 02 00    ADC #$0002             ;|
$80:A723 CD 33 09    CMP $0933  [$7E:0933]  ;} Layer 1 X position = min([$0933], [$0939] + [camera X speed] + 2)
$80:A726 90 03       BCC $03    [$A72B]     ;|
$80:A728 AD 33 09    LDA $0933  [$7E:0933]  ;|
                                            ;|
$80:A72B 8D 11 09    STA $0911  [$7E:0911]  ;/

$80:A72E AB          PLB
$80:A72F 28          PLP
$80:A730 6B          RTL
}


;;; $A731: Handle scroll zones - vertical autoscrolling ;;;
{
; Called by:
;     $90:94EC: Main scrolling routine
;     $90:964F: Handle vertical scrolling

; If time frozen:
;     Return
;
; If layer 1 position + 1/2 scroll right's scroll = blue:
;     $0933 = 0
; Else
;     $0933 = 1Fh
;
; Layer 1 Y position = clamp([layer 1 Y position], 0, (room height in pixels) - 100h + [$0933])
;
; If layer 1 position + 1/2 scroll right's scroll = red:
; {
;     $0935 = position of bottom scroll boundary
;     $0939 = [layer 1 Y position] + [camera Y speed] + 2
;     Layer 1 X position = min([$0939], [$0935])
;     If [$0939] < [$0935] and layer 1 position + 1/2 scroll right + 1 scroll down's scroll = red:
;         Round layer 1 Y position to top scroll boundary
; }
; Else if layer 1 position + 1/2 scroll right + 1 scroll down's scroll = red:
; {
;     $0937 = position of top scroll boundary + [$0933]
;     If [$0937] < [layer 1 Y position]:
;     {
;         $0939 = [layer 1 Y position] - [camera Y speed] - 2
;         Layer 1 Y position = max([$0939], [$0937])
;         If [$0939] >= [$0937] and layer 1 position + 1/2 scroll right's scroll = red:
;             Layer 1 Y position = [$0939] rounded to right bottom boundary
;     }
; }

$80:A731 08          PHP
$80:A732 8B          PHB
$80:A733 E2 20       SEP #$20
$80:A735 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$80:A738 0D 79 0A    ORA $0A79  [$7E:0A79]  ;|
$80:A73B F0 03       BEQ $03    [$A740]     ;} If time frozen: return
$80:A73D 4C 90 A8    JMP $A890  [$80:A890]  ;/

$80:A740 A9 8F       LDA #$8F               ;\
$80:A742 48          PHA                    ;} DB = $8F
$80:A743 AB          PLB                    ;/
$80:A744 C2 30       REP #$30
$80:A746 A0 00 00    LDY #$0000             ; Y = 0
$80:A749 E2 20       SEP #$20
$80:A74B AD 16 09    LDA $0916  [$7E:0916]  ;\
$80:A74E 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A751 AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A754 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A757 C2 20       REP #$20               ;|
$80:A759 AD 11 09    LDA $0911  [$7E:0911]  ;|
$80:A75C 18          CLC                    ;|
$80:A75D 69 80 00    ADC #$0080             ;|
$80:A760 EB          XBA                    ;|
$80:A761 29 FF 00    AND #$00FF             ;} If layer 1 position + 1/2 scroll right's scroll != blue:
$80:A764 18          CLC                    ;|
$80:A765 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A768 85 14       STA $14    [$7E:0014]  ;|
$80:A76A AA          TAX                    ;|
$80:A76B BF 20 CD 7E LDA $7ECD20,x[$7E:CD20];|
$80:A76F 29 FF 00    AND #$00FF             ;|
$80:A772 C9 01 00    CMP #$0001             ;|
$80:A775 F0 03       BEQ $03    [$A77A]     ;/
$80:A777 A0 1F 00    LDY #$001F             ; Y = 1Fh

$80:A77A 8C 33 09    STY $0933  [$7E:0933]  ; $0933 = [Y]
$80:A77D AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A780 8D 39 09    STA $0939  [$7E:0939]  ;} $0939 = [layer 1 Y position]
$80:A783 10 03       BPL $03    [$A788]     ;\
$80:A785 9C 15 09    STZ $0915  [$7E:0915]  ;} Layer 1 Y position = max([layer 1 Y position], 0)

$80:A788 AD AB 07    LDA $07AB  [$7E:07AB]  ;\
$80:A78B 3A          DEC A                  ;|
$80:A78C EB          XBA                    ;|
$80:A78D 18          CLC                    ;|
$80:A78E 6D 33 09    ADC $0933  [$7E:0933]  ;} Layer 1 Y position = min([layer 1 Y position], (room height in pixels) - 100h + [$0933])
$80:A791 CD 15 09    CMP $0915  [$7E:0915]  ;|
$80:A794 B0 03       BCS $03    [$A799]     ;|
$80:A796 8D 15 09    STA $0915  [$7E:0915]  ;/

$80:A799 E2 20       SEP #$20
$80:A79B AD 16 09    LDA $0916  [$7E:0916]  ;\
$80:A79E 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A7A1 AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A7A4 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A7A7 C2 20       REP #$20               ;|
$80:A7A9 AD 11 09    LDA $0911  [$7E:0911]  ;|
$80:A7AC 18          CLC                    ;|
$80:A7AD 69 80 00    ADC #$0080             ;|
$80:A7B0 EB          XBA                    ;} If layer 1 position + 1/2 scroll right's scroll != red: go to BRANCH_UNBOUNDED_FROM_ABOVE
$80:A7B1 29 FF 00    AND #$00FF             ;|
$80:A7B4 18          CLC                    ;|
$80:A7B5 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A7B8 AA          TAX                    ;|
$80:A7B9 BF 20 CD 7E LDA $7ECD20,x[$7E:CD20];|
$80:A7BD 29 FF 00    AND #$00FF             ;|
$80:A7C0 D0 5B       BNE $5B    [$A81D]     ;/
$80:A7C2 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A7C5 29 00 FF    AND #$FF00             ;|
$80:A7C8 18          CLC                    ;} $0935 = position of bottom scroll boundary
$80:A7C9 69 00 01    ADC #$0100             ;|
$80:A7CC 8D 35 09    STA $0935  [$7E:0935]  ;/
$80:A7CF AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A7D2 18          CLC                    ;|
$80:A7D3 6D A6 0D    ADC $0DA6  [$7E:0DA6]  ;|
$80:A7D6 69 02 00    ADC #$0002             ;} If [$0939] + [camera Y speed] + 2 >= (position of bottom scroll boundary): go to BRANCH_REACHED_BOTTOM_SCROLL_BOUNDARY
$80:A7D9 CD 35 09    CMP $0935  [$7E:0935]  ;|
$80:A7DC B0 3A       BCS $3A    [$A818]     ;/
$80:A7DE 8D 39 09    STA $0939  [$7E:0939]  ; $0939 += [camera Y speed] + 2
$80:A7E1 E2 20       SEP #$20               ;\
$80:A7E3 AD 3A 09    LDA $093A  [$7E:093A]  ;|
$80:A7E6 1A          INC A                  ;|
$80:A7E7 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A7EA AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A7ED 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A7F0 C2 20       REP #$20               ;|
$80:A7F2 AD 11 09    LDA $0911  [$7E:0911]  ;|
$80:A7F5 18          CLC                    ;|
$80:A7F6 69 80 00    ADC #$0080             ;} If layer 1 position + 1/2 scroll right + 1 scroll down's scroll = red:
$80:A7F9 EB          XBA                    ;|
$80:A7FA 29 FF 00    AND #$00FF             ;|
$80:A7FD 18          CLC                    ;|
$80:A7FE 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A801 AA          TAX                    ;|
$80:A802 BF 20 CD 7E LDA $7ECD20,x[$7E:CD23];|
$80:A806 29 FF 00    AND #$00FF             ;|
$80:A809 D0 08       BNE $08    [$A813]     ;/
$80:A80B AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A80E 29 00 FF    AND #$FF00             ;} Layer 1 Y position = [$0939] rounded to top scroll boundary
$80:A811 80 7A       BRA $7A    [$A88D]     ; Return

$80:A813 AD 39 09    LDA $0939  [$7E:0939]  ; Layer 1 Y position = [$0939]
$80:A816 80 75       BRA $75    [$A88D]     ; Return

; BRANCH_REACHED_BOTTOM_SCROLL_BOUNDARY
$80:A818 AD 35 09    LDA $0935  [$7E:0935]  ; Layer 1 Y position = (position of bottom scroll boundary)
$80:A81B 80 70       BRA $70    [$A88D]     ; Return

; BRANCH_UNBOUNDED_FROM_ABOVE
$80:A81D 8A          TXA                    ;\
$80:A81E 18          CLC                    ;|
$80:A81F 6D A9 07    ADC $07A9  [$7E:07A9]  ;|
$80:A822 AA          TAX                    ;} If layer 1 position + 1/2 scroll right + 1 scroll down's scroll != red: return
$80:A823 BF 20 CD 7E LDA $7ECD20,x[$7E:CD21];|
$80:A827 29 FF 00    AND #$00FF             ;|
$80:A82A D0 64       BNE $64    [$A890]     ;/
$80:A82C AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A82F 29 00 FF    AND #$FF00             ;|
$80:A832 18          CLC                    ;} $0937 = position of top scroll boundary + [$0933]
$80:A833 6D 33 09    ADC $0933  [$7E:0933]  ;|
$80:A836 8D 37 09    STA $0937  [$7E:0937]  ;/
$80:A839 CD 15 09    CMP $0915  [$7E:0915]  ;\
$80:A83C B0 52       BCS $52    [$A890]     ;} If [$0937] >= [layer 1 Y position]: return
$80:A83E AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A841 38          SEC                    ;|
$80:A842 ED A6 0D    SBC $0DA6  [$7E:0DA6]  ;|
$80:A845 E9 02 00    SBC #$0002             ;} If [$0939] - [camera Y speed] - 2 < [$0937]: go to BRANCH_REACHED_TOP_SCROLL_BOUNDARY
$80:A848 CD 37 09    CMP $0937  [$7E:0937]  ;|
$80:A84B 30 3D       BMI $3D    [$A88A]     ;/
$80:A84D 8D 39 09    STA $0939  [$7E:0939]  ; $0939 -= [camera Y speed] + 2
$80:A850 E2 20       SEP #$20               ;\
$80:A852 AD 3A 09    LDA $093A  [$7E:093A]  ;|
$80:A855 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A858 AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A85B 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A85E C2 20       REP #$20               ;|
$80:A860 AD 11 09    LDA $0911  [$7E:0911]  ;|
$80:A863 18          CLC                    ;|
$80:A864 69 80 00    ADC #$0080             ;} If layer 1 position + 1/2 scroll right's scroll = red:
$80:A867 EB          XBA                    ;|
$80:A868 29 FF 00    AND #$00FF             ;|
$80:A86B 18          CLC                    ;|
$80:A86C 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A86F AA          TAX                    ;|
$80:A870 BF 20 CD 7E LDA $7ECD20,x[$7E:CD22];|
$80:A874 29 FF 00    AND #$00FF             ;|
$80:A877 D0 0C       BNE $0C    [$A885]     ;/
$80:A879 AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A87C 29 00 FF    AND #$FF00             ;|
$80:A87F 18          CLC                    ;} Layer 1 Y position = [$0939] rounded to bottom scroll boundary
$80:A880 69 00 01    ADC #$0100             ;/
$80:A883 80 08       BRA $08    [$A88D]     ; Return

$80:A885 AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A888 80 03       BRA $03    [$A88D]     ;} Layer 1 Y position = [$0939]

; BRANCH_REACHED_TOP_SCROLL_BOUNDARY
$80:A88A AD 37 09    LDA $0937  [$7E:0937]  ; Layer 1 Y position = [$0937]

$80:A88D 8D 15 09    STA $0915  [$7E:0915]

$80:A890 AB          PLB
$80:A891 28          PLP
$80:A892 6B          RTL
}


;;; $A893: Handle scroll zones - scrolling down ;;;
{
; Called by:
;     $90:964F: Handle vertical scrolling
$80:A893 08          PHP
$80:A894 8B          PHB
$80:A895 E2 20       SEP #$20
$80:A897 A9 8F       LDA #$8F               ;\
$80:A899 48          PHA                    ;} DB = $8F
$80:A89A AB          PLB                    ;/
$80:A89B C2 30       REP #$30
$80:A89D AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A8A0 8D 39 09    STA $0939  [$7E:0939]  ;} $0939 = [layer 1 Y position]
$80:A8A3 A0 00 00    LDY #$0000             ; Y = 0
$80:A8A6 E2 20       SEP #$20               ;\
$80:A8A8 AD 16 09    LDA $0916  [$7E:0916]  ;|
$80:A8AB 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A8AE AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A8B1 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A8B4 C2 20       REP #$20               ;|
$80:A8B6 AD 11 09    LDA $0911  [$7E:0911]  ;|
$80:A8B9 18          CLC                    ;|
$80:A8BA 69 80 00    ADC #$0080             ;|
$80:A8BD EB          XBA                    ;} If layer 1 position + 1/2 screen right's scroll != blue:
$80:A8BE 29 FF 00    AND #$00FF             ;|
$80:A8C1 18          CLC                    ;|
$80:A8C2 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A8C5 85 14       STA $14    [$7E:0014]  ;|
$80:A8C7 AA          TAX                    ;|
$80:A8C8 BF 20 CD 7E LDA $7ECD20,x[$7E:CD20];|
$80:A8CC 29 FF 00    AND #$00FF             ;|
$80:A8CF C9 01 00    CMP #$0001             ;|
$80:A8D2 F0 03       BEQ $03    [$A8D7]     ;/
$80:A8D4 A0 1F 00    LDY #$001F             ; Y = 1Fh

$80:A8D7 8C 33 09    STY $0933  [$7E:0933]  ; $0933 = [Y]
$80:A8DA AD 0E 0B    LDA $0B0E  [$7E:0B0E]  ;\
$80:A8DD CD 15 09    CMP $0915  [$7E:0915]  ;|
$80:A8E0 10 09       BPL $09    [$A8EB]     ;|
$80:A8E2 AD 0E 0B    LDA $0B0E  [$7E:0B0E]  ;} Layer 1 Y position = min([layer 1 Y position], [ideal layer 1 Y position])
$80:A8E5 8D 15 09    STA $0915  [$7E:0915]  ;|
$80:A8E8 9C 13 09    STZ $0913  [$7E:0913]  ;/

$80:A8EB AD AB 07    LDA $07AB  [$7E:07AB]  ;\
$80:A8EE 3A          DEC A                  ;|
$80:A8EF EB          XBA                    ;|
$80:A8F0 18          CLC                    ;} $0937 = (room width in pixels) - 100h + [$0933]
$80:A8F1 6D 33 09    ADC $0933  [$7E:0933]  ;|
$80:A8F4 8D 37 09    STA $0937  [$7E:0937]  ;/
$80:A8F7 CD 15 09    CMP $0915  [$7E:0915]  ;\
$80:A8FA 90 22       BCC $22    [$A91E]     ;} If [$0937] >= [layer 1 Y position]:
$80:A8FC A5 14       LDA $14    [$7E:0014]  ;\
$80:A8FE 18          CLC                    ;|
$80:A8FF 6D A9 07    ADC $07A9  [$7E:07A9]  ;|
$80:A902 AA          TAX                    ;} If layer 1 position + 1/2 screen right's scroll + 1 screen down != red: return
$80:A903 BF 20 CD 7E LDA $7ECD20,x[$7E:CD21];|
$80:A907 29 FF 00    AND #$00FF             ;|
$80:A90A D0 27       BNE $27    [$A933]     ;/
$80:A90C AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A90F 29 00 FF    AND #$FF00             ;|
$80:A912 18          CLC                    ;} $0937 = position of top scroll boundary + [$0933]
$80:A913 6D 33 09    ADC $0933  [$7E:0933]  ;|
$80:A916 8D 37 09    STA $0937  [$7E:0937]  ;/
$80:A919 CD 15 09    CMP $0915  [$7E:0915]  ;\
$80:A91C B0 15       BCS $15    [$A933]     ;} If [$0937] >= [layer 1 Y position]: return

$80:A91E AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A921 38          SEC                    ;|
$80:A922 ED A6 0D    SBC $0DA6  [$7E:0DA6]  ;|
$80:A925 E9 02 00    SBC #$0002             ;|
$80:A928 CD 37 09    CMP $0937  [$7E:0937]  ;} Layer 1 Y position = max([$0937], [$0939] - [camera Y speed] - 2)
$80:A92B 10 03       BPL $03    [$A930]     ;|
$80:A92D AD 37 09    LDA $0937  [$7E:0937]  ;|
                                            ;|
$80:A930 8D 15 09    STA $0915  [$7E:0915]  ;/

$80:A933 AB          PLB
$80:A934 28          PLP
$80:A935 6B          RTL
}


;;; $A936: Handle scroll zones - scrolling up ;;;
{
; Called by:
;     $90:964F: Handle vertical scrolling
$80:A936 08          PHP
$80:A937 8B          PHB
$80:A938 E2 20       SEP #$20
$80:A93A A9 8F       LDA #$8F               ;\
$80:A93C 48          PHA                    ;} DB = $8F
$80:A93D AB          PLB                    ;/
$80:A93E C2 30       REP #$30
$80:A940 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A943 8D 39 09    STA $0939  [$7E:0939]  ;} $0939 = [layer 1 Y position]
$80:A946 CD 0E 0B    CMP $0B0E  [$7E:0B0E]  ;\
$80:A949 10 09       BPL $09    [$A954]     ;|
$80:A94B AD 0E 0B    LDA $0B0E  [$7E:0B0E]  ;} Layer 1 Y position = max([layer 1 Y position], [ideal layer 1 Y position])
$80:A94E 8D 15 09    STA $0915  [$7E:0915]  ;|
$80:A951 9C 13 09    STZ $0913  [$7E:0913]  ;/

$80:A954 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A957 10 05       BPL $05    [$A95E]     ;} If [layer 1 Y position] < 0:
$80:A959 9C 15 09    STZ $0915  [$7E:0915]  ; Layer 1 Y position = 0
$80:A95C 80 4B       BRA $4B    [$A9A9]     ; Return

$80:A95E E2 20       SEP #$20               ;\
$80:A960 AD 16 09    LDA $0916  [$7E:0916]  ;|
$80:A963 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A966 AD A9 07    LDA $07A9  [$7E:07A9]  ;|
$80:A969 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A96C C2 20       REP #$20               ;|
$80:A96E AD 11 09    LDA $0911  [$7E:0911]  ;|
$80:A971 18          CLC                    ;|
$80:A972 69 80 00    ADC #$0080             ;} If layer 1 position + 1/2 screen right's scroll = red:
$80:A975 EB          XBA                    ;|
$80:A976 29 FF 00    AND #$00FF             ;|
$80:A979 18          CLC                    ;|
$80:A97A 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A97D AA          TAX                    ;|
$80:A97E BF 20 CD 7E LDA $7ECD20,x[$7E:CD20];|
$80:A982 29 FF 00    AND #$00FF             ;|
$80:A985 D0 22       BNE $22    [$A9A9]     ;/
$80:A987 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A98A 29 00 FF    AND #$FF00             ;|
$80:A98D 18          CLC                    ;} $0933 = position of bottom scroll boundary
$80:A98E 69 00 01    ADC #$0100             ;|
$80:A991 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:A994 AD 39 09    LDA $0939  [$7E:0939]  ;\
$80:A997 18          CLC                    ;|
$80:A998 6D A6 0D    ADC $0DA6  [$7E:0DA6]  ;|
$80:A99B 69 02 00    ADC #$0002             ;|
$80:A99E CD 33 09    CMP $0933  [$7E:0933]  ;} Layer 1 Y position = min([$0933], [$0939] + [camera Y speed] + 2)
$80:A9A1 90 03       BCC $03    [$A9A6]     ;|
$80:A9A3 AD 33 09    LDA $0933  [$7E:0933]  ;|
                                            ;|
$80:A9A6 8D 15 09    STA $0915  [$7E:0915]  ;/

$80:A9A9 AB          PLB
$80:A9AA 28          PLP
$80:A9AB 6B          RTL
}


;;; $A9AC: Debug layer 1 position save/loading ;;;
{
; Good for testing scrolling
$80:A9AC A5 91       LDA $91    [$7E:0091]  ;\
$80:A9AE 29 40 00    AND #$0040             ;} If controller 2 newly pressed X:
$80:A9B1 F0 03       BEQ $03    [$A9B6]     ;/
$80:A9B3 EE D3 05    INC $05D3  [$7E:05D3]  ; Toggle debug saved scroll flag

$80:A9B6 AD D3 05    LDA $05D3  [$7E:05D3]  ;\
$80:A9B9 4A          LSR A                  ;} If [debug saved scroll flag] set:
$80:A9BA 90 0D       BCC $0D    [$A9C9]     ;/
$80:A9BC AD D5 05    LDA $05D5  [$7E:05D5]  ;\
$80:A9BF 8D 11 09    STA $0911  [$7E:0911]  ;} Layer 1 X position = [saved layer 1 X position]
$80:A9C2 AD D7 05    LDA $05D7  [$7E:05D7]  ;\
$80:A9C5 8D 15 09    STA $0915  [$7E:0915]  ;} Layer 1 Y position = [saved layer 1 Y position]
$80:A9C8 6B          RTL                    ; Return

$80:A9C9 AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:A9CC 8D D5 05    STA $05D5  [$7E:05D5]  ;} Saved layer 1 X position = [layer 1 X position]
$80:A9CF AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:A9D2 8D D7 05    STA $05D7  [$7E:05D7]  ;} Saved layer 1 Y position = [layer 1 Y position]
$80:A9D5 6B          RTL
}


;;; $A9D6: Update background data column ;;;
{
; Called by:
;     $A176: Display the viewable part of the room
;     $A3DF: Update BG graphics when scrolling
$80:A9D6 A2 1C 00    LDX #$001C             ; X = 1Ch
$80:A9D9 80 03       BRA $03    [$A9DE]     ; Branch to $A9DE
}


;;; $A9DB: Update level data column ;;;
{
; Called by:
;     $A176: Display the viewable part of the room
;     $A3DF: Update BG graphics when scrolling
$80:A9DB A2 00 00    LDX #$0000             ; X = 0
}


;;; $A9DE: Update level/background data column ;;;
{
; Called by:
;     $A9D6: Update background data column
;     $A9DB: Update level data column

; VRAM is allocated 32x16 blocks (64x32 VRAM blocks) of space (2 screens)
; The visible part of the room spans 16x14 blocks
; Suppose we have a 2x2 screen room, that's 32x32 blocks (64x64 VRAM blocks)
; Suppose the room was loaded from the top-left and has been scrolled to position (8,8) (in blocks)
; Initially the memory layout of the level data and VRAM mirror each other (broadly speaking)
; As the screen is being scrolled down, rows of blocks are loaded and placed after the end of where the previous last row of blocks is
; Note that the previous top row of blocks isn't erased and the VRAM data isn't "moved up" in memory, the BG1/BG2 scroll registers are incremented instead
; If the bottom of the VRAM has been reached, the blocks are loaded to the top of VRAM instead, so there's a pacman-escaue wrapping behaviour

; When loading a new column of data (due to scrolling horizontally), the column will have to be loaded in two parts (if the visible screen is vertically wrapped in VRAM)
; The first part is the top of the visible screen corresponding to the bottom part in VRAM
; The second part is the remaining bottom part of the visible screen corresponding to the wrapped top part in VRAM

; The diagram below is attempting to show this correspondence graphically, each character is 2x2 blocks (4x4 VRAM blocks)
; # blocks are whatever off-screen blocks
; O blocks are whatever on-screen blocks
; * blocks are the blocks that are being loaded by this routine
; @ blocks (in VRAM) are whatever garbage that exists in VRAM because the screen hasn't been scrolled far enough right

;             Level data            =>              VRAM
;   0 1 2 3 4 5 6 7 8 9 A B C D E F    0 1 2 3 4 5 6 7 8 9 A B C D E F
; 0 # # # # # # # # # # # # # # # #    # # # # O O O * O O O O @ @ @ @ \
; 1 # # # # # # # # # # # # # # # #    # # # # O O O * O O O O @ @ @ @ } The bottom section of the visible screen
; 2 # # # # # # # # # # # # # # # #    # # # # O O O O O O O O @ @ @ @ /
; 3 # # # # # # # # # # # # # # # #    # # # # # # # # # # # # @ @ @ @ <-- The row above the visible part of the screen
; 4 # # # # O O O O O O O O # # # #    # # # # O O O O O O O O @ @ @ @ \
; 5 # # # # O O O O O O O O # # # #    # # # # O O O O O O O O @ @ @ @ |
; 6 # # # # O O O * O O O O # # # #    # # # # O O O * O O O O @ @ @ @ } The top section of the visible screen
; 7 # # # # O O O * O O O O # # # #    # # # # O O O * O O O O @ @ @ @ /
; 8 # # # # O O O * O O O O # # # #
; 9 # # # # O O O * O O O O # # # #
; A # # # # O O O O O O O O # # # #
; B # # # # # # # # # # # # # # # #
; C # # # # # # # # # # # # # # # #
; D # # # # # # # # # # # # # # # #
; E # # # # # # # # # # # # # # # #
; F # # # # # # # # # # # # # # # #

$80:A9DE AD 83 07    LDA $0783  [$7E:0783]  ;\
$80:A9E1 F0 01       BEQ $01    [$A9E4]     ;} If mode 7: return
$80:A9E3 60          RTS                    ;/

$80:A9E4 08          PHP
$80:A9E5 E2 20       SEP #$20               ;\
$80:A9E7 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$80:A9EA 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:A9ED AD 92 09    LDA $0992  [$7E:0992]  ;|
$80:A9F0 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:A9F3 8B          PHB                    ;|
$80:A9F4 C2 30       REP #$30               ;|
$80:A9F6 AD 90 09    LDA $0990  [$7E:0990]  ;|
$80:A9F9 18          CLC                    ;|
$80:A9FA 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:A9FD 0A          ASL A                  ;} $36 = address of blocks to update (in bank $7F)
$80:A9FE 18          CLC                    ;|
$80:A9FF 69 02 00    ADC #$0002             ;|
$80:AA02 9B          TXY                    ;|
$80:AA03 F0 04       BEQ $04    [$AA09]     ;|
$80:AA05 18          CLC                    ;|
$80:AA06 69 00 96    ADC #$9600             ;|
                                            ;|
$80:AA09 85 36       STA $36    [$7E:0036]  ;|
$80:AA0B A9 7F 00    LDA #$007F             ;|
$80:AA0E 85 38       STA $38    [$7E:0038]  ;/
$80:AA10 AD 96 09    LDA $0996  [$7E:0996]  ;\
$80:AA13 0A          ASL A                  ;|
$80:AA14 0A          ASL A                  ;} Wrapped tilemap VRAM update size = ([VRAM blocks to update Y block] & Fh) * 4
$80:AA15 29 3C 00    AND #$003C             ;|
$80:AA18 9D 58 09    STA $0958,x[$7E:0958]  ;/
$80:AA1B 49 3F 00    EOR #$003F             ;\
$80:AA1E 1A          INC A                  ;} Unwrapped tilemap VRAM update size = (10h - ([VRAM blocks to update Y block] & Fh)) * 4
$80:AA1F 9D 56 09    STA $0956,x[$7E:0956]  ;/
$80:AA22 E2 20       SEP #$20               ;\
$80:AA24 AD 96 09    LDA $0996  [$7E:0996]  ;|
$80:AA27 29 0F       AND #$0F               ;|
$80:AA29 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:AA2C A9 40       LDA #$40               ;|
$80:AA2E 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:AA31 C2 20       REP #$20               ;|
$80:AA33 AD 94 09    LDA $0994  [$7E:0994]  ;} VRAM offset of blocks to update = (([VRAM blocks to update Y block] & Fh) * 20h + ([X block of VRAM blocks to update] & 1Fh)) * 2
$80:AA36 29 1F 00    AND #$001F             ;|
$80:AA39 8D 35 09    STA $0935  [$7E:0935]  ;|
$80:AA3C 0A          ASL A                  ;|
$80:AA3D 18          CLC                    ;|
$80:AA3E 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:AA41 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:AA44 A9 00 50    LDA #$5000             ; A = VRAM map 1st screen base address
$80:AA47 AC 35 09    LDY $0935  [$7E:0935]  ;\
$80:AA4A C0 10 00    CPY #$0010             ;} If [X block of VRAM blocks to update] & 1Fh >= 10h:
$80:AA4D 90 03       BCC $03    [$AA52]     ;/
$80:AA4F A9 E0 53    LDA #$53E0             ; A = VRAM map 2nd screen base address (devs opted to subtract 20h here, rather than take $0935 & Fh before summing)

$80:AA52 9B          TXY                    ;\
$80:AA53 F0 04       BEQ $04    [$AA59]     ;} If background update:
$80:AA55 38          SEC                    ;\
$80:AA56 ED 8E 09    SBC $098E  [$7E:098E]  ;} A -= [size of BG2]

$80:AA59 8D 37 09    STA $0937  [$7E:0937]  ; Base address of VRAM tilemap screen = [A]
$80:AA5C 18          CLC                    ;\
$80:AA5D 6D 33 09    ADC $0933  [$7E:0933]  ;} Unwrapped tilemap VRAM update destination = [base address of VRAM tilemap screen] + [VRAM offset of blocks to update]
$80:AA60 9D 5A 09    STA $095A,x[$7E:095A]  ;/
$80:AA63 AD 37 09    LDA $0937  [$7E:0937]  ;\
$80:AA66 18          CLC                    ;|
$80:AA67 6D 35 09    ADC $0935  [$7E:0935]  ;} Wrapped tilemap VRAM update destination = [base address of VRAM tilemap screen] + ([X block of VRAM blocks to update] & 1Fh) * 2
$80:AA6A 6D 35 09    ADC $0935  [$7E:0935]  ;|
$80:AA6D 9D 5C 09    STA $095C,x[$7E:095C]  ;/
$80:AA70 A9 C8 C8    LDA #$C8C8             ;\
$80:AA73 A0 00 00    LDY #$0000             ;|
$80:AA76 E0 00 00    CPX #$0000             ;|
$80:AA79 F0 06       BEQ $06    [$AA81]     ;} New tilemap source address = $C8C8 if level update, else $C9D0 (background update)
$80:AA7B A9 D0 C9    LDA #$C9D0             ;|
$80:AA7E A0 08 01    LDY #$0108             ;/

$80:AA81 18          CLC                    ;\
$80:AA82 7D 56 09    ADC $0956,x[$7E:0956]  ;} Wrapped tilemap VRAM update left halves source = new tilemap source address + [unwrapped tilemap VRAM update size]
$80:AA85 9D 5E 09    STA $095E,x[$7E:095E]  ;/
$80:AA88 18          CLC                    ;\
$80:AA89 69 40 00    ADC #$0040             ;} Wrapped tilemap VRAM update right halves source = [wrapped tilemap VRAM update left halves source] + 40h
$80:AA8C 9D 60 09    STA $0960,x[$7E:0960]  ;/
$80:AA8F 8C 37 09    STY $0937  [$7E:0937]  ; $0937 = index of VRAM tilemap source data
$80:AA92 E2 20       SEP #$20               ;\
$80:AA94 A9 7E       LDA #$7E               ;|
$80:AA96 48          PHA                    ;} DB = $7E
$80:AA97 AB          PLB                    ;|
$80:AA98 C2 20       REP #$20               ;/
$80:AA9A DA          PHX                    ; Save X parameter
$80:AA9B A0 00 00    LDY #$0000             ; Y = 0 (nth row offset for block to update)
$80:AA9E A9 10 00    LDA #$0010             ;\
$80:AAA1 8D 39 09    STA $0939  [$7E:0939]  ;} $0939 = 10h (counter for following loop)

; LOOP
$80:AAA4 B7 36       LDA [$36],y[$7F:0002]  ;\
$80:AAA6 8D 3B 09    STA $093B  [$7E:093B]  ;} $093B = block to update (in $7F)
$80:AAA9 29 FF 03    AND #$03FF             ;\
$80:AAAC 0A          ASL A                  ;|
$80:AAAD 0A          ASL A                  ;} X = tile number of block * 8 (offset of tile table at $7E:A000)
$80:AAAE 0A          ASL A                  ;|
$80:AAAF AA          TAX                    ;/
$80:AAB0 5A          PHY                    ; Push Y
$80:AAB1 AC 37 09    LDY $0937  [$7E:0937]  ; Y = [index of VRAM tilemap source data]
$80:AAB4 AD 3B 09    LDA $093B  [$7E:093B]  ;\
$80:AAB7 29 00 0C    AND #$0C00             ;} If block has no flip:
$80:AABA D0 1B       BNE $1B    [$AAD7]     ;/
$80:AABC BD 00 A0    LDA $A000,x[$7E:A010]  ;\
$80:AABF 99 C8 C8    STA $C8C8,y[$7E:C8C8]  ;} Copy top-left VRAM tile of the block
$80:AAC2 BD 02 A0    LDA $A002,x[$7E:A012]  ;\
$80:AAC5 99 08 C9    STA $C908,y[$7E:C908]  ;} Copy top-right VRAM tile of the block
$80:AAC8 BD 04 A0    LDA $A004,x[$7E:A014]  ;\
$80:AACB 99 CA C8    STA $C8CA,y[$7E:C8CA]  ;} Copy bottom-left VRAM tile of the block
$80:AACE BD 06 A0    LDA $A006,x[$7E:A016]  ;\
$80:AAD1 99 0A C9    STA $C90A,y[$7E:C90A]  ;} Copy bottom-right VRAM tile of the block
$80:AAD4 4C 51 AB    JMP $AB51  [$80:AB51]  ; Go to BRANCH_NEXT

$80:AAD7 C9 00 04    CMP #$0400             ;\
$80:AADA D0 26       BNE $26    [$AB02]     ;} Else if block has only horizontal flip:
$80:AADC BD 02 A0    LDA $A002,x[$7E:A42A]  ;\
$80:AADF 49 00 40    EOR #$4000             ;|
$80:AAE2 99 C8 C8    STA $C8C8,y[$7E:C8E0]  ;|
$80:AAE5 BD 00 A0    LDA $A000,x[$7E:A428]  ;|
$80:AAE8 49 00 40    EOR #$4000             ;|
$80:AAEB 99 08 C9    STA $C908,y[$7E:C920]  ;|
$80:AAEE BD 06 A0    LDA $A006,x[$7E:A42E]  ;} Copy the four VRAM tiles of the block, with horizontal flip
$80:AAF1 49 00 40    EOR #$4000             ;|
$80:AAF4 99 CA C8    STA $C8CA,y[$7E:C8E2]  ;|
$80:AAF7 BD 04 A0    LDA $A004,x[$7E:A42C]  ;|
$80:AAFA 49 00 40    EOR #$4000             ;|
$80:AAFD 99 0A C9    STA $C90A,y[$7E:C922]  ;/
$80:AB00 80 4F       BRA $4F    [$AB51]     ; Go to BRANCH_NEXT

$80:AB02 C9 00 08    CMP #$0800             ;\
$80:AB05 D0 26       BNE $26    [$AB2D]     ;} Else if block has only vertical flip:
$80:AB07 BD 04 A0    LDA $A004,x[$7E:A00C]  ;\
$80:AB0A 49 00 80    EOR #$8000             ;|
$80:AB0D 99 C8 C8    STA $C8C8,y[$7E:C8DC]  ;|
$80:AB10 BD 06 A0    LDA $A006,x[$7E:A00E]  ;|
$80:AB13 49 00 80    EOR #$8000             ;|
$80:AB16 99 08 C9    STA $C908,y[$7E:C91C]  ;|
$80:AB19 BD 00 A0    LDA $A000,x[$7E:A008]  ;} Copy the four VRAM tiles of the block, with vertical flip
$80:AB1C 49 00 80    EOR #$8000             ;|
$80:AB1F 99 CA C8    STA $C8CA,y[$7E:C8DE]  ;|
$80:AB22 BD 02 A0    LDA $A002,x[$7E:A00A]  ;|
$80:AB25 49 00 80    EOR #$8000             ;|
$80:AB28 99 0A C9    STA $C90A,y[$7E:C91E]  ;/
$80:AB2B 80 24       BRA $24    [$AB51]     ; Go to BRANCH_NEXT

$80:AB2D BD 06 A0    LDA $A006,x[$7E:A52E]  ;\ Else: block has horizontal and vertical flips
$80:AB30 49 00 C0    EOR #$C000             ;|
$80:AB33 99 C8 C8    STA $C8C8,y[$7E:C8E8]  ;|
$80:AB36 BD 04 A0    LDA $A004,x[$7E:A52C]  ;|
$80:AB39 49 00 C0    EOR #$C000             ;|
$80:AB3C 99 08 C9    STA $C908,y[$7E:C928]  ;|
$80:AB3F BD 02 A0    LDA $A002,x[$7E:A52A]  ;} Copy the four VRAM tiles of the block, with horizontal and vertical flips
$80:AB42 49 00 C0    EOR #$C000             ;|
$80:AB45 99 CA C8    STA $C8CA,y[$7E:C8EA]  ;|
$80:AB48 BD 00 A0    LDA $A000,x[$7E:A528]  ;|
$80:AB4B 49 00 C0    EOR #$C000             ;|
$80:AB4E 99 0A C9    STA $C90A,y[$7E:C92A]  ;/

; BRANCH_NEXT
$80:AB51 C8          INY                    ;\
$80:AB52 C8          INY                    ;|
$80:AB53 C8          INY                    ;} Index of VRAM tilemap source data += 4
$80:AB54 C8          INY                    ;|
$80:AB55 8C 37 09    STY $0937  [$7E:0937]  ;/
$80:AB58 68          PLA                    ;\
$80:AB59 18          CLC                    ;|
$80:AB5A 6D A5 07    ADC $07A5  [$7E:07A5]  ;} Y = next row offset
$80:AB5D 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$80:AB60 A8          TAY                    ;/
$80:AB61 CE 39 09    DEC $0939  [$7E:0939]  ; Decrement $0939
$80:AB64 F0 03       BEQ $03    [$AB69]     ;\
$80:AB66 4C A4 AA    JMP $AAA4  [$80:AAA4]  ;} If [$0939] != 0: go to LOOP

$80:AB69 FA          PLX                    ; Restore X parameter
$80:AB6A FE 62 09    INC $0962,x[$7E:0962]  ; Set flag to perform VRAM update DMAs
$80:AB6D AB          PLB
$80:AB6E 28          PLP
$80:AB6F 60          RTS
}


;;; $AB70: Update background data row ;;;
{
; Called by:
;     $A3DF: Update BG graphics when scrolling
$80:AB70 A2 1C 00    LDX #$001C             ; X = 1Ch
$80:AB73 80 03       BRA $03    [$AB78]     ; Go to update level/background data row
}


;;; $AB75: Update level data row ;;;
{
; Called by:
;     $A3DF: Update BG graphics when scrolling
$80:AB75 A2 00 00    LDX #$0000             ; X = 0
}


;;; $AB78: Update level/background data row ;;;
{
; Called by:
;     $AB70: Update background data row
;     $AB75: Update level data row
$80:AB78 AD 83 07    LDA $0783  [$7E:0783]  ;\
$80:AB7B F0 01       BEQ $01    [$AB7E]     ;} If mode 7: return
$80:AB7D 60          RTS                    ;/

$80:AB7E 08          PHP
$80:AB7F E2 20       SEP #$20               ;\
$80:AB81 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$80:AB84 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:AB87 AD 92 09    LDA $0992  [$7E:0992]  ;|
$80:AB8A 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:AB8D 8B          PHB                    ;|
$80:AB8E C2 30       REP #$30               ;|
$80:AB90 AD 90 09    LDA $0990  [$7E:0990]  ;|
$80:AB93 18          CLC                    ;|
$80:AB94 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:AB97 0A          ASL A                  ;} $36 = address of blocks to update (in bank $7F)
$80:AB98 18          CLC                    ;|
$80:AB99 69 02 00    ADC #$0002             ;|
$80:AB9C 9B          TXY                    ;|
$80:AB9D F0 04       BEQ $04    [$ABA3]     ;|
$80:AB9F 18          CLC                    ;|
$80:ABA0 69 00 96    ADC #$9600             ;|
                                            ;|
$80:ABA3 85 36       STA $36    [$7E:0036]  ;|
$80:ABA5 A9 7F 00    LDA #$007F             ;|
$80:ABA8 85 38       STA $38    [$7E:0038]  ;/
$80:ABAA AD 94 09    LDA $0994  [$7E:0994]  ;\
$80:ABAD 29 0F 00    AND #$000F             ;} $0933 = [VRAM blocks to update X block] & Fh
$80:ABB0 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:ABB3 A9 10 00    LDA #$0010             ;\
$80:ABB6 38          SEC                    ;|
$80:ABB7 ED 33 09    SBC $0933  [$7E:0933]  ;|
$80:ABBA 0A          ASL A                  ;} Unwrapped tilemap VRAM update size = (10h - ([VRAM blocks to update X block] & Fh)) * 4
$80:ABBB 0A          ASL A                  ;|
$80:ABBC 9D 64 09    STA $0964,x[$7E:0964]  ;/
$80:ABBF AD 33 09    LDA $0933  [$7E:0933]  ;\
$80:ABC2 1A          INC A                  ;|
$80:ABC3 0A          ASL A                  ;} Wrapped tilemap VRAM update size = (([VRAM blocks to update X block] & Fh) + 1) * 4
$80:ABC4 0A          ASL A                  ;|
$80:ABC5 9D 66 09    STA $0966,x[$7E:0966]  ;/
$80:ABC8 E2 20       SEP #$20               ;\
$80:ABCA AD 96 09    LDA $0996  [$7E:0996]  ;|
$80:ABCD 29 0F       AND #$0F               ;|
$80:ABCF 8D 02 42    STA $4202  [$7E:4202]  ;|
$80:ABD2 A9 40       LDA #$40               ;|
$80:ABD4 8D 03 42    STA $4203  [$7E:4203]  ;|
$80:ABD7 C2 20       REP #$20               ;|
$80:ABD9 AD 94 09    LDA $0994  [$7E:0994]  ;} VRAM offset of blocks to update = (([VRAM blocks to update Y block] & Fh) * 20h + [X block of VRAM blocks to update] & 1Fh) * 2
$80:ABDC 29 1F 00    AND #$001F             ;|
$80:ABDF 8D 35 09    STA $0935  [$7E:0935]  ;|
$80:ABE2 0A          ASL A                  ;|
$80:ABE3 18          CLC                    ;|
$80:ABE4 6D 16 42    ADC $4216  [$7E:4216]  ;|
$80:ABE7 8D 33 09    STA $0933  [$7E:0933]  ;/
$80:ABEA A9 00 54    LDA #$5400             ;\
$80:ABED 8D 37 09    STA $0937  [$7E:0937]  ;} Base address of wrapped VRAM tilemap screen = VRAM map 2nd screen base address
$80:ABF0 A9 00 50    LDA #$5000             ; A = VRAM map 1st screen base address
$80:ABF3 AC 35 09    LDY $0935  [$7E:0935]  ;\
$80:ABF6 C0 10 00    CPY #$0010             ;} If [X block of VRAM blocks to update] & 1Fh >= 10h:
$80:ABF9 90 09       BCC $09    [$AC04]     ;/
$80:ABFB A9 00 50    LDA #$5000             ;\
$80:ABFE 8D 37 09    STA $0937  [$7E:0937]  ;} Base address of wrapped VRAM tilemap screen = VRAM map 1st screen base address
$80:AC01 A9 E0 53    LDA #$53E0             ; A = VRAM map 2nd screen base address (devs opted to subtract 20h here, rather than take $0935 & Fh before summing)

$80:AC04 9B          TXY                    ;\
$80:AC05 F0 04       BEQ $04    [$AC0B]     ;} If background update:
$80:AC07 38          SEC                    ;\
$80:AC08 ED 8E 09    SBC $098E  [$7E:098E]  ;} A -= [size of BG2]

$80:AC0B 18          CLC                    ;\
$80:AC0C 6D 33 09    ADC $0933  [$7E:0933]  ;} Unwrapped tilemap VRAM update destination = [A] + [VRAM offset of blocks to update]
$80:AC0F 9D 68 09    STA $0968,x[$7E:0968]  ;/
$80:AC12 AD 37 09    LDA $0937  [$7E:0937]  ; A = [base address of wrapped VRAM tilemap screen]
$80:AC15 9B          TXY                    ;\
$80:AC16 F0 04       BEQ $04    [$AC1C]     ;} If background update:
$80:AC18 38          SEC                    ;\
$80:AC19 ED 8E 09    SBC $098E  [$7E:098E]  ;} A -= [size of BG2]

$80:AC1C 18          CLC                    ;\
$80:AC1D 6D 16 42    ADC $4216  [$7E:4216]  ;} Wrapped tilemap VRAM update destination = [A] + (VRAM blocks to update Y position & 0Fh) * 20h * 2
$80:AC20 9D 6A 09    STA $096A,x[$7E:096A]  ;/
$80:AC23 A9 48 C9    LDA #$C948             ;\
$80:AC26 A0 00 00    LDY #$0000             ;|
$80:AC29 E0 00 00    CPX #$0000             ;|
$80:AC2C F0 06       BEQ $06    [$AC34]     ;} New tilemap source address = $C948 if level update, else $CA50 (background update)
$80:AC2E A9 50 CA    LDA #$CA50             ;|
$80:AC31 A0 08 01    LDY #$0108             ;/

$80:AC34 18          CLC                    ;\
$80:AC35 7D 64 09    ADC $0964,x[$7E:0964]  ;} Wrapped tilemap VRAM update top halves source = new tilemap source address + [unwrapped tilemap VRAM update size]
$80:AC38 9D 6C 09    STA $096C,x[$7E:096C]  ;/
$80:AC3B 18          CLC                    ;\
$80:AC3C 69 44 00    ADC #$0044             ;} Wrapped tilemap VRAM update bottom halves source = [wrapped tilemap VRAM update top halves source] + 44h
$80:AC3F 9D 6E 09    STA $096E,x[$7E:096E]  ;/
$80:AC42 8C 37 09    STY $0937  [$7E:0937]  ; $0937 = index of VRAM tilemap source data
$80:AC45 E2 20       SEP #$20               ;\
$80:AC47 A9 7E       LDA #$7E               ;|
$80:AC49 48          PHA                    ;} DB = $7E
$80:AC4A AB          PLB                    ;|
$80:AC4B C2 20       REP #$20               ;/
$80:AC4D DA          PHX                    ; Save X parameter
$80:AC4E A0 00 00    LDY #$0000             ; Y = 0 (nth row offset for block to update)
$80:AC51 A9 11 00    LDA #$0011             ;\
$80:AC54 8D 39 09    STA $0939  [$7E:0939]  ;} $0939 = 11h (counter for following loop)

; LOOP
$80:AC57 B7 36       LDA [$36],y[$7F:0202]  ;\
$80:AC59 8D 3B 09    STA $093B  [$7E:093B]  ;} $093B = block to update (in $7F)
$80:AC5C 29 FF 03    AND #$03FF             ;\
$80:AC5F 0A          ASL A                  ;|
$80:AC60 0A          ASL A                  ;} X = tile number of block * 8 (offset of tile table at $7E:A000)
$80:AC61 0A          ASL A                  ;|
$80:AC62 AA          TAX                    ;/
$80:AC63 5A          PHY                    ; Push Y
$80:AC64 AC 37 09    LDY $0937  [$7E:0937]  ; Y = [index of VRAM tilemap source data]
$80:AC67 AD 3B 09    LDA $093B  [$7E:093B]  ;\
$80:AC6A 29 00 0C    AND #$0C00             ;} If block has no flip:
$80:AC6D D0 1B       BNE $1B    [$AC8A]     ;/
$80:AC6F BD 00 A0    LDA $A000,x[$7E:A158]  ;\
$80:AC72 99 48 C9    STA $C948,y[$7E:C948]  ;} Copy top-left VRAM tile of the block
$80:AC75 BD 02 A0    LDA $A002,x[$7E:A15A]  ;\
$80:AC78 99 4A C9    STA $C94A,y[$7E:C94A]  ;} Copy top-right VRAM tile of the block
$80:AC7B BD 04 A0    LDA $A004,x[$7E:A15C]  ;\
$80:AC7E 99 8C C9    STA $C98C,y[$7E:C98C]  ;} Copy bottom-left VRAM tile of the block
$80:AC81 BD 06 A0    LDA $A006,x[$7E:A15E]  ;\
$80:AC84 99 8E C9    STA $C98E,y[$7E:C98E]  ;} Copy bottom-right VRAM tile of the block
$80:AC87 4C 04 AD    JMP $AD04  [$80:AD04]  ; Go to BRANCH_NEXT

$80:AC8A C9 00 04    CMP #$0400             ;\
$80:AC8D D0 26       BNE $26    [$ACB5]     ;} Else if block has only horizontal flip:
$80:AC8F BD 02 A0    LDA $A002,x[$7E:A172]  ;\
$80:AC92 49 00 40    EOR #$4000             ;|
$80:AC95 99 48 C9    STA $C948,y[$7E:C954]  ;|
$80:AC98 BD 00 A0    LDA $A000,x[$7E:A170]  ;|
$80:AC9B 49 00 40    EOR #$4000             ;|
$80:AC9E 99 4A C9    STA $C94A,y[$7E:C956]  ;|
$80:ACA1 BD 06 A0    LDA $A006,x[$7E:A176]  ;} Copy the four VRAM tiles of the block, with horizontal flip
$80:ACA4 49 00 40    EOR #$4000             ;|
$80:ACA7 99 8C C9    STA $C98C,y[$7E:C998]  ;|
$80:ACAA BD 04 A0    LDA $A004,x[$7E:A174]  ;|
$80:ACAD 49 00 40    EOR #$4000             ;|
$80:ACB0 99 8E C9    STA $C98E,y[$7E:C99A]  ;/
$80:ACB3 80 4F       BRA $4F    [$AD04]     ; Go to BRANCH_NEXT

$80:ACB5 C9 00 08    CMP #$0800             ;\
$80:ACB8 D0 26       BNE $26    [$ACE0]     ;} Else if block has only vertical flip:
$80:ACBA BD 04 A0    LDA $A004,x[$7E:A17C]  ;\
$80:ACBD 49 00 80    EOR #$8000             ;|
$80:ACC0 99 48 C9    STA $C948,y[$7E:C950]  ;|
$80:ACC3 BD 06 A0    LDA $A006,x[$7E:A17E]  ;|
$80:ACC6 49 00 80    EOR #$8000             ;|
$80:ACC9 99 4A C9    STA $C94A,y[$7E:C952]  ;|
$80:ACCC BD 00 A0    LDA $A000,x[$7E:A178]  ;} Copy the four VRAM tiles of the block, with vertical flip
$80:ACCF 49 00 80    EOR #$8000             ;|
$80:ACD2 99 8C C9    STA $C98C,y[$7E:C994]  ;|
$80:ACD5 BD 02 A0    LDA $A002,x[$7E:A17A]  ;|
$80:ACD8 49 00 80    EOR #$8000             ;|
$80:ACDB 99 8E C9    STA $C98E,y[$7E:C996]  ;/
$80:ACDE 80 24       BRA $24    [$AD04]     ; Go to BRANCH_NEXT

$80:ACE0 BD 06 A0    LDA $A006,x[$7E:A00E]  ;\ Else: block has horizontal and vertical flips
$80:ACE3 49 00 C0    EOR #$C000             ;|
$80:ACE6 99 48 C9    STA $C948,y[$7E:C968]  ;|
$80:ACE9 BD 04 A0    LDA $A004,x[$7E:A00C]  ;|
$80:ACEC 49 00 C0    EOR #$C000             ;|
$80:ACEF 99 4A C9    STA $C94A,y[$7E:C96A]  ;|
$80:ACF2 BD 02 A0    LDA $A002,x[$7E:A00A]  ;} Copy the four VRAM tiles of the block, with horizontal and vertical flips
$80:ACF5 49 00 C0    EOR #$C000             ;|
$80:ACF8 99 8C C9    STA $C98C,y[$7E:C9AC]  ;|
$80:ACFB BD 00 A0    LDA $A000,x[$7E:A008]  ;|
$80:ACFE 49 00 C0    EOR #$C000             ;|
$80:AD01 99 8E C9    STA $C98E,y[$7E:C9AE]  ;/

; BRANCH_NEXT
$80:AD04 C8          INY                    ;\
$80:AD05 C8          INY                    ;|
$80:AD06 C8          INY                    ;} Index of VRAM tilemap source data += 4
$80:AD07 C8          INY                    ;|
$80:AD08 8C 37 09    STY $0937  [$7E:0937]  ;/
$80:AD0B 7A          PLY                    ;\
$80:AD0C C8          INY                    ;} Y = next block offset
$80:AD0D C8          INY                    ;/
$80:AD0E CE 39 09    DEC $0939  [$7E:0939]  ; Decrement $0939
$80:AD11 F0 03       BEQ $03    [$AD16]     ;\
$80:AD13 4C 57 AC    JMP $AC57  [$80:AC57]  ;} If [$0939] != 0: go to LOOP

$80:AD16 FA          PLX                    ; Restore X parameter
$80:AD17 FE 70 09    INC $0970,x[$7E:0970]  ; Set flag to perform VRAM update DMAs
$80:AD1A AB          PLB
$80:AD1B 28          PLP
$80:AD1C 60          RTS
}


;;; $AD1D: Draw top row of screen for upwards door transition ;;;
{
; Called by:
;     $82:E353: Handles door transitions - fix doors moving up

; See $AF89
$80:AD1D 9C 25 09    STZ $0925  [$7E:0925]  ; Door transition frame counter = 0
$80:AD20 20 BB A4    JSR $A4BB  [$80:A4BB]  ; Calculate BG and layer position blocks
$80:AD23 20 10 AE    JSR $AE10  [$80:AE10]  ; Update previous layer blocks
$80:AD26 EE 01 09    INC $0901  [$7E:0901]  ; Increment previous layer 1 Y block
$80:AD29 EE 05 09    INC $0905  [$7E:0905]  ; Increment previous layer 2 Y block
$80:AD2C 20 89 AF    JSR $AF89  [$80:AF89]  ; Door transition scrolling - up
$80:AD2F 6B          RTL
}


;;; $AD30: Door transition scrolling setup ;;;
{
; Called by:
;     $82:E38E: Handles door transitions - set up scrolling
$80:AD30 C2 30       REP #$30
$80:AD32 AD 27 09    LDA $0927  [$7E:0927]  ;\
$80:AD35 8D 11 09    STA $0911  [$7E:0911]  ;} Layer 1 X position = [door destination X position]
$80:AD38 AD 29 09    LDA $0929  [$7E:0929]  ;\
$80:AD3B 8D 15 09    STA $0915  [$7E:0915]  ;} Layer 1 Y position = [door destination Y position]
$80:AD3E AD 91 07    LDA $0791  [$7E:0791]  ;\
$80:AD41 29 03 00    AND #$0003             ;|
$80:AD44 0A          ASL A                  ;} Go to [$AE08 + ([door direction] & 3) * 2]
$80:AD45 AA          TAX                    ;|
$80:AD46 FC 08 AE    JSR ($AE08,x)[$80:AD4A];/
$80:AD49 6B          RTL
}


;;; $AD4A: Door transition scrolling setup - right ;;;
{
$80:AD4A 20 F9 A2    JSR $A2F9  [$80:A2F9]  ; Calculate layer 2 X position
$80:AD4D 38          SEC                    ;\
$80:AD4E E9 00 01    SBC #$0100             ;} Layer 2 X position -= 100h
$80:AD51 8D 17 09    STA $0917  [$7E:0917]  ;/
$80:AD54 20 3A A3    JSR $A33A  [$80:A33A]  ; Calculate layer 2 Y position
$80:AD57 AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:AD5A 38          SEC                    ;|
$80:AD5B E9 00 01    SBC #$0100             ;} Layer 1 X position -= 100h
$80:AD5E 8D 11 09    STA $0911  [$7E:0911]  ;/
$80:AD61 20 29 AE    JSR $AE29  [$80:AE29]  ; Update BG scroll offsets
$80:AD64 20 BB A4    JSR $A4BB  [$80:A4BB]  ; Calculate BG and layer position blocks
$80:AD67 20 10 AE    JSR $AE10  [$80:AE10]  ; Update previous layer blocks
$80:AD6A CE FF 08    DEC $08FF  [$7E:08FF]  ; Decrement previous layer 1 X block
$80:AD6D CE 03 09    DEC $0903  [$7E:0903]  ; Decrement previous layer 2 X block
$80:AD70 20 7E AE    JSR $AE7E  [$80:AE7E]  ; Door transition scrolling - right
$80:AD73 60          RTS
}


;;; $AD74: Door transition scrolling setup - left ;;;
{
$80:AD74 20 F9 A2    JSR $A2F9  [$80:A2F9]  ; Calculate layer 2 X position
$80:AD77 18          CLC                    ;\
$80:AD78 69 00 01    ADC #$0100             ;} Layer 2 X position += 100h
$80:AD7B 8D 17 09    STA $0917  [$7E:0917]  ;/
$80:AD7E 20 3A A3    JSR $A33A  [$80:A33A]  ; Calculate layer 2 Y position
$80:AD81 AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:AD84 18          CLC                    ;|
$80:AD85 69 00 01    ADC #$0100             ;} Layer 1 X position += 100h
$80:AD88 8D 11 09    STA $0911  [$7E:0911]  ;/
$80:AD8B 20 29 AE    JSR $AE29  [$80:AE29]  ; Update BG scroll offsets
$80:AD8E 20 BB A4    JSR $A4BB  [$80:A4BB]  ; Calculate BG and layer position blocks
$80:AD91 20 10 AE    JSR $AE10  [$80:AE10]  ; Update previous layer blocks
$80:AD94 EE FF 08    INC $08FF  [$7E:08FF]  ; Increment previous layer 1 X block
$80:AD97 EE 03 09    INC $0903  [$7E:0903]  ; Increment previous layer 2 X block
$80:AD9A 20 C2 AE    JSR $AEC2  [$80:AEC2]  ; Door transition scrolling - left
$80:AD9D 60          RTS
}


;;; $AD9E: Door transition scrolling setup - down ;;;
{
$80:AD9E 20 F9 A2    JSR $A2F9  [$80:A2F9]  ; Calculate layer 2 X position
$80:ADA1 20 3A A3    JSR $A33A  [$80:A33A]  ; Calculate layer 2 Y position
$80:ADA4 38          SEC                    ;\
$80:ADA5 E9 E0 00    SBC #$00E0             ;} Layer 2 Y position -= E0h
$80:ADA8 8D 19 09    STA $0919  [$7E:0919]  ;/
$80:ADAB AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:ADAE 38          SEC                    ;|
$80:ADAF E9 E0 00    SBC #$00E0             ;} Layer 1 Y position -= E0h
$80:ADB2 8D 15 09    STA $0915  [$7E:0915]  ;/
$80:ADB5 20 29 AE    JSR $AE29  [$80:AE29]  ; Update BG scroll offsets
$80:ADB8 20 BB A4    JSR $A4BB  [$80:A4BB]  ; Calculate BG and layer position blocks
$80:ADBB 20 10 AE    JSR $AE10  [$80:AE10]  ; Update previous layer blocks
$80:ADBE CE 01 09    DEC $0901  [$7E:0901]  ; Decrement previous layer 1 Y block
$80:ADC1 CE 05 09    DEC $0905  [$7E:0905]  ; Decrement previous layer 2 Y block
$80:ADC4 20 02 AF    JSR $AF02  [$80:AF02]  ; Door transition scrolling - down
$80:ADC7 60          RTS
}


;;; $ADC8: Door transition scrolling setup - up ;;;
{
$80:ADC8 20 F9 A2    JSR $A2F9  [$80:A2F9]  ; Calculate layer 2 X position
$80:ADCB AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:ADCE 48          PHA                    ;|
$80:ADCF 18          CLC                    ;} Use (layer 1 Y position + 1Fh) for layer 2 Y position calculation
$80:ADD0 69 1F 00    ADC #$001F             ;|
$80:ADD3 8D 15 09    STA $0915  [$7E:0915]  ;/
$80:ADD6 20 3A A3    JSR $A33A  [$80:A33A]  ; Calculate layer 2 Y position
$80:ADD9 18          CLC                    ;\
$80:ADDA 69 E0 00    ADC #$00E0             ;} Layer 2 Y position += E0h
$80:ADDD 8D 19 09    STA $0919  [$7E:0919]  ;/
$80:ADE0 68          PLA                    ;\
$80:ADE1 18          CLC                    ;|
$80:ADE2 69 00 01    ADC #$0100             ;} Layer 1 Y position += 100h
$80:ADE5 8D 15 09    STA $0915  [$7E:0915]  ;/
$80:ADE8 20 29 AE    JSR $AE29  [$80:AE29]  ; Update BG scroll offsets
$80:ADEB AD 29 09    LDA $0929  [$7E:0929]  ;\
$80:ADEE 18          CLC                    ;|
$80:ADEF 69 20 00    ADC #$0020             ;} Y position of door destination += 20h
$80:ADF2 8D 29 09    STA $0929  [$7E:0929]  ;/
$80:ADF5 20 BB A4    JSR $A4BB  [$80:A4BB]  ; Calculate BG and layer position blocks
$80:ADF8 20 10 AE    JSR $AE10  [$80:AE10]  ; Update previous layer blocks
$80:ADFB EE 01 09    INC $0901  [$7E:0901]  ; Increment previous layer 1 Y block
$80:ADFE EE 05 09    INC $0905  [$7E:0905]  ; Increment previous layer 2 Y block
$80:AE01 CE 15 09    DEC $0915  [$7E:0915]  ; Decrement layer 1 Y position
$80:AE04 20 89 AF    JSR $AF89  [$80:AF89]  ; Door transition scrolling - up
$80:AE07 60          RTS
}


;;; $AE08: Pointers to door transition scrolling setup code ;;;
{
$80:AE08             dw AD4A, AD74, AD9E, ADC8
}


;;; $AE10: Update previous layer blocks ;;;
{
$80:AE10 AD F7 08    LDA $08F7  [$7E:08F7]  ;\
$80:AE13 8D FF 08    STA $08FF  [$7E:08FF]  ;} Previous layer 1 X block = [layer 1 X block]
$80:AE16 AD FB 08    LDA $08FB  [$7E:08FB]  ;\
$80:AE19 8D 03 09    STA $0903  [$7E:0903]  ;} Previous layer 2 X block = [layer 2 X block]
$80:AE1C AD F9 08    LDA $08F9  [$7E:08F9]  ;\
$80:AE1F 8D 01 09    STA $0901  [$7E:0901]  ;} Previous layer 1 Y block = [layer 1 Y block]
$80:AE22 AD FD 08    LDA $08FD  [$7E:08FD]  ;\
$80:AE25 8D 05 09    STA $0905  [$7E:0905]  ;} Previous layer 2 Y block = [layer 2 Y block]
$80:AE28 60          RTS
}


;;; $AE29: Update BG scroll offsets ;;;
{
; Called by door transition scrolling setup
$80:AE29 A5 B1       LDA $B1    [$7E:00B1]  ;\
$80:AE2B 38          SEC                    ;|
$80:AE2C ED 11 09    SBC $0911  [$7E:0911]  ;} BG1 X offset = [BG1 X scroll] - [layer 1 X position]
$80:AE2F 8D 1D 09    STA $091D  [$7E:091D]  ;/
$80:AE32 A5 B3       LDA $B3    [$7E:00B3]  ;\
$80:AE34 38          SEC                    ;|
$80:AE35 ED 15 09    SBC $0915  [$7E:0915]  ;} BG1 Y offset = [BG1 Y scroll] - [layer 1 Y position]
$80:AE38 8D 1F 09    STA $091F  [$7E:091F]  ;/
$80:AE3B A5 B5       LDA $B5    [$7E:00B5]  ;\
$80:AE3D 38          SEC                    ;|
$80:AE3E ED 11 09    SBC $0911  [$7E:0911]  ;} BG2 X offset = [BG2 X scroll] - [layer 1 X position]
$80:AE41 8D 21 09    STA $0921  [$7E:0921]  ;/
$80:AE44 A5 B7       LDA $B7    [$7E:00B7]  ;\
$80:AE46 38          SEC                    ;|
$80:AE47 ED 15 09    SBC $0915  [$7E:0915]  ;} BG2 Y offset = [BG2 Y scroll] - [layer 1 Y position]
$80:AE4A 8D 23 09    STA $0923  [$7E:0923]  ;/
$80:AE4D 60          RTS
}


;;; $AE4E: Door transition scrolling ;;;
{
$80:AE4E 08          PHP
$80:AE4F 8B          PHB
$80:AE50 4B          PHK                    ;\
$80:AE51 AB          PLB                    ;} DB = $80
$80:AE52 C2 30       REP #$30
$80:AE54 AD 91 07    LDA $0791  [$7E:0791]  ;\
$80:AE57 29 03 00    AND #$0003             ;|
$80:AE5A 0A          ASL A                  ;} Execute [$AE08 + ([door direction] & 3) * 2]
$80:AE5B AA          TAX                    ;|
$80:AE5C FC 76 AE    JSR ($AE76,x)[$80:AE7E];/
$80:AE5F 90 12       BCC $12    [$AE73]     ; If carry set:
$80:AE61 AD 27 09    LDA $0927  [$7E:0927]  ;\
$80:AE64 8D 11 09    STA $0911  [$7E:0911]  ;} Layer 1 X position = [door destination X position]
$80:AE67 AD 29 09    LDA $0929  [$7E:0929]  ;\                      
$80:AE6A 8D 15 09    STA $0915  [$7E:0915]  ;} Layer 1 Y position = [door destination Y position]
$80:AE6D A9 00 80    LDA #$8000             ;\
$80:AE70 0C 31 09    TSB $0931  [$7E:0931]  ;} Door transition finished scrolling flag = 8000h

$80:AE73 AB          PLB
$80:AE74 28          PLP
$80:AE75 6B          RTL

$80:AE76             dw AE7E, AEC2, AF02, AF89
}


;;; $AE7E: Door transition scrolling - right ;;;
{
$80:AE7E AE 25 09    LDX $0925  [$7E:0925]  ; X = [door transition frame counter]
$80:AE81 DA          PHX                    
$80:AE82 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$80:AE85 18          CLC                    ;|
$80:AE86 6D 2B 09    ADC $092B  [$7E:092B]  ;|
$80:AE89 8D F8 0A    STA $0AF8  [$7E:0AF8]  ;} Samus X position += [Samus speed during door transition]
$80:AE8C AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$80:AE8F 6D 2D 09    ADC $092D  [$7E:092D]  ;|
$80:AE92 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$80:AE95 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$80:AE98 AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:AE9B 18          CLC                    ;|
$80:AE9C 69 04 00    ADC #$0004             ;} Layer 1 X position += 4
$80:AE9F 8D 11 09    STA $0911  [$7E:0911]  ;/
$80:AEA2 AD 17 09    LDA $0917  [$7E:0917]  ;\
$80:AEA5 18          CLC                    ;|
$80:AEA6 69 04 00    ADC #$0004             ;} Layer 2 X position += 4
$80:AEA9 8D 17 09    STA $0917  [$7E:0917]  ;/
$80:AEAC 22 A0 A3 80 JSL $80A3A0[$80:A3A0]  ; Calculate BG positions and update BG graphics when scrolling
$80:AEB0 FA          PLX                    ;\
$80:AEB1 E8          INX                    ;} Increment door transition frame counter
$80:AEB2 8E 25 09    STX $0925  [$7E:0925]  ;/
$80:AEB5 E0 40 00    CPX #$0040             ;\
$80:AEB8 D0 06       BNE $06    [$AEC0]     ;} If [door transition frame counter] = 40h:
$80:AEBA 22 A0 A3 80 JSL $80A3A0[$80:A3A0]  ; Calculate BG positions and update BG graphics when scrolling
$80:AEBE 38          SEC                    ;\
$80:AEBF 60          RTS                    ;} Return carry set
                                            
$80:AEC0 18          CLC                    ;\
$80:AEC1 60          RTS                    ;} Return carry clear
}


;;; $AEC2: Door transition scrolling - left ;;;
{
$80:AEC2 AE 25 09    LDX $0925  [$7E:0925]  ; X = [door transition frame counter]
$80:AEC5 DA          PHX                    
$80:AEC6 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$80:AEC9 38          SEC                    ;|
$80:AECA ED 2B 09    SBC $092B  [$7E:092B]  ;|
$80:AECD 8D F8 0A    STA $0AF8  [$7E:0AF8]  ;} Samus X position -= [Samus speed during door transition]
$80:AED0 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$80:AED3 ED 2D 09    SBC $092D  [$7E:092D]  ;|
$80:AED6 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$80:AED9 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$80:AEDC AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:AEDF 38          SEC                    ;|
$80:AEE0 E9 04 00    SBC #$0004             ;} Layer 1 X position -= 4
$80:AEE3 8D 11 09    STA $0911  [$7E:0911]  ;/
$80:AEE6 AD 17 09    LDA $0917  [$7E:0917]  ;\
$80:AEE9 38          SEC                    ;|
$80:AEEA E9 04 00    SBC #$0004             ;} Layer 2 X position -= 4
$80:AEED 8D 17 09    STA $0917  [$7E:0917]  ;/
$80:AEF0 22 A0 A3 80 JSL $80A3A0[$80:A3A0]  ; Calculate BG positions and update BG graphics when scrolling
$80:AEF4 FA          PLX                    ;\
$80:AEF5 E8          INX                    ;} Increment door transition frame counter
$80:AEF6 8E 25 09    STX $0925  [$7E:0925]  ;/
$80:AEF9 E0 40 00    CPX #$0040             ;\
$80:AEFC D0 02       BNE $02    [$AF00]     ;} If [door transition frame counter] = 40h:
$80:AEFE 38          SEC                    ;\
$80:AEFF 60          RTS                    ;} Return carry set
                                            
$80:AF00 18          CLC                    ;\
$80:AF01 60          RTS                    ;} Return carry clear
}


;;; $AF02: Door transition scrolling - down ;;;
{
; Spends 1 frame drawing the top row of the new room
; Then spends 38h frames doing the scrolling (38h frames * 4px/frame = 224px)

; The reason the top row of the new room isn't drawn by scrolling is that vertical scrolling loads one row ahead below the screen
; In other words, there's always a tilemap row loaded that's fully off-screen below the visible tilemap
; So prior to the door transition when the camera is scrolled to the edge of a scroll,
; it has already loaded the row below the door into the tilemap (which is garbage if the door was at a room boundary)
; Any further scrolling would work on the assumption that row has been loaded already, and that row is the top row of the destination room

; tldr: need to redraw the top row to replace the garbage

$80:AF02 AE 25 09    LDX $0925  [$7E:0925]  ; X = [door transition frame counter]
$80:AF05 DA          PHX                    
$80:AF06 D0 3C       BNE $3C    [$AF44]     ; If [door transition frame counter] = 0:
$80:AF08 A5 B3       LDA $B3    [$7E:00B3]  ;\
$80:AF0A 48          PHA                    ;} Save BG1 Y scroll
$80:AF0B A5 B7       LDA $B7    [$7E:00B7]  ;\
$80:AF0D 48          PHA                    ;} Save BG2 Y scroll
$80:AF0E AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:AF11 48          PHA                    ;} Save layer 1 Y position
$80:AF12 38          SEC                    ;\
$80:AF13 E9 0F 00    SBC #$000F             ;} Layer 1 Y position -= Fh
$80:AF16 8D 15 09    STA $0915  [$7E:0915]  ;/
$80:AF19 AD 19 09    LDA $0919  [$7E:0919]  ;\
$80:AF1C 48          PHA                    ;} Save layer 2 Y position
$80:AF1D 38          SEC                    ;\
$80:AF1E E9 0F 00    SBC #$000F             ;} Layer 2 Y position -= Fh
$80:AF21 8D 19 09    STA $0919  [$7E:0919]  ;/
$80:AF24 20 BB A4    JSR $A4BB  [$80:A4BB]  ; Calculate BG and layer position blocks
$80:AF27 20 10 AE    JSR $AE10  [$80:AE10]  ; Update previous layer blocks
$80:AF2A CE 01 09    DEC $0901  [$7E:0901]  ; Decrement previous layer 1 Y block
$80:AF2D CE 05 09    DEC $0905  [$7E:0905]  ; Decrement previous layer 2 Y block
$80:AF30 22 A0 A3 80 JSL $80A3A0[$80:A3A0]  ; Calculate BG positions and update BG graphics when scrolling
$80:AF34 68          PLA                    ;\
$80:AF35 8D 19 09    STA $0919  [$7E:0919]  ;} Restore layer 2 Y position
$80:AF38 68          PLA                    ;\
$80:AF39 8D 15 09    STA $0915  [$7E:0915]  ;} Restore layer 1 Y position
$80:AF3C 68          PLA                    ;\
$80:AF3D 85 B7       STA $B7    [$7E:00B7]  ;} Restore BG2 Y scroll
$80:AF3F 68          PLA                    ;\
$80:AF40 85 B3       STA $B3    [$7E:00B3]  ;} Restore BG1 Y scroll
$80:AF42 80 33       BRA $33    [$AF77]

$80:AF44 E0 39 00    CPX #$0039             ;\ Else ([door transition frame counter] != 0):
$80:AF47 B0 2E       BCS $2E    [$AF77]     ;} If [door transition frame counter] < 39h:
$80:AF49 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$80:AF4C 18          CLC                    ;|
$80:AF4D 6D 2B 09    ADC $092B  [$7E:092B]  ;|
$80:AF50 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus Y position += [Samus speed during door transition]
$80:AF53 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$80:AF56 6D 2D 09    ADC $092D  [$7E:092D]  ;|
$80:AF59 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$80:AF5C 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$80:AF5F AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:AF62 18          CLC                    ;|
$80:AF63 69 04 00    ADC #$0004             ;} Layer 1 Y position += 4
$80:AF66 8D 15 09    STA $0915  [$7E:0915]  ;/
$80:AF69 AD 19 09    LDA $0919  [$7E:0919]  ;\
$80:AF6C 18          CLC                    ;|
$80:AF6D 69 04 00    ADC #$0004             ;} Layer 2 Y position += 4
$80:AF70 8D 19 09    STA $0919  [$7E:0919]  ;/
$80:AF73 22 A0 A3 80 JSL $80A3A0[$80:A3A0]  ; Calculate BG positions and update BG graphics when scrolling

$80:AF77 FA          PLX                    ;\
$80:AF78 E8          INX                    ;} Increment door transition frame counter
$80:AF79 8E 25 09    STX $0925  [$7E:0925]  ;/
$80:AF7C E0 39 00    CPX #$0039             ;\
$80:AF7F 90 06       BCC $06    [$AF87]     ;} If [door transition frame counter] >= 39h:
$80:AF81 22 A0 A3 80 JSL $80A3A0[$80:A3A0]  ; Calculate BG positions and update BG graphics when scrolling
$80:AF85 38          SEC                    ;\
$80:AF86 60          RTS                    ;} Return carry set
                                            
$80:AF87 18          CLC                    ;\
$80:AF88 60          RTS                    ;} Return carry clear
}


;;; $AF89: Door transition scrolling - up ;;;
{
; This routine - unlike the other three door transition directions - is called once prior to the destination room being loaded (via $AD1D)
; The reason for this is to load the tilemap for the top row of the scroll, which hasn't yet been loaded by the scrolling routine
; After the destination room has been loaded and the screen starts scrolling, on frames 1..4 don't call the scrolling routine,
; as that would load the tilemap according to the destination room, which would be the row below the scroll you're going to (likely garbage)
; Of course there doesn't need to be any updates due to scrolling because the row was already loaded manually on frame 0
; Then scrolling as per usual for the remaining 34h frames (38h frames * 4px/frame = 224px)

; tldr: need to load top row and not overwrite that row in the next room
; I'm fairly sure all of this could have been avoided if the vertical scrolling tilemap did updates to rows 0..Fh instead of 1..Fh (see $80:A45E)

$80:AF89 AE 25 09    LDX $0925  [$7E:0925]  ; X = [door transition frame counter]
$80:AF8C DA          PHX
$80:AF8D D0 3C       BNE $3C    [$AFCB]     ; If [door transition frame counter] = 0:
$80:AF8F A5 B3       LDA $B3    [$7E:00B3]  ;\
$80:AF91 48          PHA                    ;} Save BG1 Y scroll
$80:AF92 A5 B7       LDA $B7    [$7E:00B7]  ;\
$80:AF94 48          PHA                    ;} Save BG2 Y scroll
$80:AF95 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:AF98 48          PHA                    ;} Save layer 1 Y position
$80:AF99 38          SEC                    ;\
$80:AF9A E9 10 00    SBC #$0010             ;} Layer 1 Y position -= 10h
$80:AF9D 8D 15 09    STA $0915  [$7E:0915]  ;/
$80:AFA0 AD 19 09    LDA $0919  [$7E:0919]  ;\
$80:AFA3 48          PHA                    ;} Save layer 2 Y position
$80:AFA4 38          SEC                    ;\
$80:AFA5 E9 10 00    SBC #$0010             ;} Layer 2 Y position -= 10h
$80:AFA8 8D 19 09    STA $0919  [$7E:0919]  ;/
$80:AFAB 20 BB A4    JSR $A4BB  [$80:A4BB]  ; Calculate BG and layer position blocks
$80:AFAE 20 10 AE    JSR $AE10  [$80:AE10]  ; Update previous layer blocks
$80:AFB1 EE 01 09    INC $0901  [$7E:0901]  ; Increment previous layer 1 Y block
$80:AFB4 EE 05 09    INC $0905  [$7E:0905]  ; Increment previous layer 2 Y block
$80:AFB7 22 A0 A3 80 JSL $80A3A0[$80:A3A0]  ; Calculate BG positions and update BG graphics when scrolling
$80:AFBB 68          PLA                    ;\
$80:AFBC 8D 19 09    STA $0919  [$7E:0919]  ;} Restore layer 2 Y position
$80:AFBF 68          PLA                    ;\
$80:AFC0 8D 15 09    STA $0915  [$7E:0915]  ;} Restore layer 1 Y position
$80:AFC3 68          PLA                    ;\
$80:AFC4 85 B7       STA $B7    [$7E:00B7]  ;} Restore BG2 Y scroll
$80:AFC6 68          PLA                    ;\
$80:AFC7 85 B3       STA $B3    [$7E:00B3]  ;} Restore BG1 Y scroll
$80:AFC9 80 59       BRA $59    [$B024]     ; Go to BRANCH_DONE

$80:AFCB AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$80:AFCE 38          SEC                    ;|
$80:AFCF ED 2B 09    SBC $092B  [$7E:092B]  ;|
$80:AFD2 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus Y position -= [Samus speed during door transition]
$80:AFD5 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$80:AFD8 ED 2D 09    SBC $092D  [$7E:092D]  ;|
$80:AFDB 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$80:AFDE 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$80:AFE1 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:AFE4 38          SEC                    ;|
$80:AFE5 E9 04 00    SBC #$0004             ;} Layer 1 Y position -= 4
$80:AFE8 8D 15 09    STA $0915  [$7E:0915]  ;/
$80:AFEB AD 19 09    LDA $0919  [$7E:0919]  ;\
$80:AFEE 38          SEC                    ;|
$80:AFEF E9 04 00    SBC #$0004             ;} Layer 2 Y position -= 4
$80:AFF2 8D 19 09    STA $0919  [$7E:0919]  ;/
$80:AFF5 E0 05 00    CPX #$0005             ;\
$80:AFF8 B0 26       BCS $26    [$B020]     ;} If [door transition frame counter] <= 4:
$80:AFFA AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:AFFD 18          CLC                    ;|
$80:AFFE 6D 1D 09    ADC $091D  [$7E:091D]  ;} BG1 X scroll = [layer 1 X position] + [BG1 X offset]
$80:B001 85 B1       STA $B1    [$7E:00B1]  ;/
$80:B003 AD 15 09    LDA $0915  [$7E:0915]  ;\
$80:B006 18          CLC                    ;|
$80:B007 6D 1F 09    ADC $091F  [$7E:091F]  ;} BG1 Y scroll = [layer 1 Y position] + [BG1 Y offset]
$80:B00A 85 B3       STA $B3    [$7E:00B3]  ;/
$80:B00C AD 17 09    LDA $0917  [$7E:0917]  ;\
$80:B00F 18          CLC                    ;|
$80:B010 6D 21 09    ADC $0921  [$7E:0921]  ;} BG2 X scroll = [layer 2 X position] + [BG2 X offset]
$80:B013 85 B5       STA $B5    [$7E:00B5]  ;/
$80:B015 AD 19 09    LDA $0919  [$7E:0919]  ;\
$80:B018 18          CLC                    ;|
$80:B019 6D 23 09    ADC $0923  [$7E:0923]  ;} BG2 Y scroll = [layer 2 Y position] + [BG2 Y offset]
$80:B01C 85 B7       STA $B7    [$7E:00B7]  ;/
$80:B01E 80 04       BRA $04    [$B024]     ; Go to BRANCH_DONE

$80:B020 22 A0 A3 80 JSL $80A3A0[$80:A3A0]  ; Calculate BG positions and update BG graphics when scrolling

; BRANCH_DONE
$80:B024 FA          PLX                    ;\
$80:B025 E8          INX                    ;} Increment door transition frame counter
$80:B026 8E 25 09    STX $0925  [$7E:0925]  ;/
$80:B029 E0 39 00    CPX #$0039             ;\
$80:B02C D0 02       BNE $02    [$B030]     ;} If [door transition frame counter] = 39h:
$80:B02E 38          SEC                    ;\
$80:B02F 60          RTS                    ;} Return carry set

$80:B030 18          CLC                    ;\
$80:B031 60          RTS                    ;} Return carry clear
}
}


;;; $B032: Unused. Set up rotating mode 7 background ;;;
{
; Uses data from $98 that doesn't exist anymore
$80:B032 A9 01 00    LDA #$0001             ;\
$80:B035 8D 83 07    STA $0783  [$7E:0783]  ;} Set mode 7
$80:B038 AD 83 07    LDA $0783  [$7E:0783]  ;\
$80:B03B D0 02       BNE $02    [$B03F]     ;|
$80:B03D 38          SEC                    ;} ...Ignore this
$80:B03E 6B          RTL                    ;/

$80:B03F 22 6F 83 80 JSL $80836F[$80:836F]  ; Set force blank and wait for NMI
$80:B043 A9 80 00    LDA #$0080             ;\
$80:B046 8D 15 21    STA $2115  [$7E:2115]  ;|
$80:B049 9C 16 21    STZ $2116  [$7E:2116]  ;|
$80:B04C A9 00 19    LDA #$1900             ;|
$80:B04F 8D 10 43    STA $4310  [$7E:4310]  ;|
$80:B052 A9 00 80    LDA #$8000             ;|
$80:B055 8D 12 43    STA $4312  [$7E:4312]  ;|
$80:B058 A9 00 40    LDA #$4000             ;} VRAM $0000..3FFF high bytes = [$98:8000..BFFF] (mode 7 tiles)
$80:B05B 8D 15 43    STA $4315  [$7E:4315]  ;|
$80:B05E E2 20       SEP #$20               ;|
$80:B060 A9 98       LDA #$98               ;|
$80:B062 8D 14 43    STA $4314  [$7E:4314]  ;|
$80:B065 A9 02       LDA #$02               ;|
$80:B067 8D 0B 42    STA $420B  [$7E:420B]  ;/
$80:B06A 9C 15 21    STZ $2115  [$7E:2115]  ;\
$80:B06D 9C 16 21    STZ $2116  [$7E:2116]  ;|
$80:B070 9C 17 21    STZ $2117  [$7E:2117]  ;|
$80:B073 A2 00 40    LDX #$4000             ;|
                                            ;} VRAM $0000..3FFF low bytes = 0 (mode 7 tilemap)
$80:B076 9C 18 21    STZ $2118  [$7E:2118]  ;|
$80:B079 CA          DEX                    ;|
$80:B07A D0 FA       BNE $FA    [$B076]     ;/
$80:B07C A0 00 00    LDY #$0000             ; Y = 0
$80:B07F BB          TYX                    ; X = 0

; LOOP
$80:B080 8C 16 21    STY $2116  [$7E:2116]  ;\
$80:B083 5A          PHY                    ;|
$80:B084 A0 20 00    LDY #$0020             ;|
                                            ;|
$80:B087 BF 00 C0 98 LDA $98C000,x          ;} Copy 20h bytes from $98:C000 + [X] to VRAM [Y] low bytes (mode 7 tilemap)
$80:B08B 8D 18 21    STA $2118  [$7E:2118]  ;} X += 20h
$80:B08E E8          INX                    ;|
$80:B08F 88          DEY                    ;|
$80:B090 D0 F5       BNE $F5    [$B087]     ;/
$80:B092 C2 20       REP #$20               ;\
$80:B094 68          PLA                    ;|
$80:B095 18          CLC                    ;|
$80:B096 69 80 00    ADC #$0080             ;} Y += 80h (next VRAM tilemap row)
$80:B099 A8          TAY                    ;|
$80:B09A E2 20       SEP #$20               ;/
$80:B09C E0 00 04    CPX #$0400             ;\
$80:B09F D0 DF       BNE $DF    [$B080]     ;} If [X] != 400h: go to LOOP
$80:B0A1 A9 07       LDA #$07               ;\
$80:B0A3 85 55       STA $55    [$7E:0055]  ;} BG mode = 7
$80:B0A5 C2 20       REP #$20
$80:B0A7 A9 00 01    LDA #$0100             ;\
$80:B0AA 85 78       STA $78    [$7E:0078]  ;|
$80:B0AC 64 7A       STZ $7A    [$7E:007A]  ;} Mode 7 transformation matrix = identity
$80:B0AE 64 7C       STZ $7C    [$7E:007C]  ;|
$80:B0B0 85 7E       STA $7E    [$7E:007E]  ;/
$80:B0B2 A9 80 00    LDA #$0080             ;\
$80:B0B5 85 80       STA $80    [$7E:0080]  ;} Mode 7 transformation origin = (80h, 80h)
$80:B0B7 85 82       STA $82    [$7E:0082]  ;/
$80:B0B9 9C 85 07    STZ $0785  [$7E:0785]  ; Mode 7 rotation angle = 0
$80:B0BC 22 82 83 80 JSL $808382[$80:8382]  ; Clear force blank and wait for NMI
$80:B0C0 38          SEC
$80:B0C1 6B          RTL
}


;;; $B0C2: Unused. Configure mode 7 rotation matrix ;;;
{
$80:B0C2 08          PHP
$80:B0C3 C2 30       REP #$30
$80:B0C5 AD 83 07    LDA $0783  [$7E:0783]  ;\
$80:B0C8 F0 33       BEQ $33    [$B0FD]     ;} If [mode 7 flag] = 0: return
$80:B0CA AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$80:B0CD 29 07 00    AND #$0007             ;} If [frame counter] % 8 != 0: return
$80:B0D0 D0 2B       BNE $2B    [$B0FD]     ;/
$80:B0D2 AD 85 07    LDA $0785  [$7E:0785]  ;\
$80:B0D5 29 FF 00    AND #$00FF             ;|
$80:B0D8 0A          ASL A                  ;|
$80:B0D9 AA          TAX                    ;} Mode 7 transformation matrix parameter B = sin([mode 7 rotation angle] * pi / 80h) * 100h
$80:B0DA BF 43 B4 A0 LDA $A0B443,x          ;|
$80:B0DE 85 7A       STA $7A    [$7E:007A]  ;/
$80:B0E0 49 FF FF    EOR #$FFFF             ;\
$80:B0E3 1A          INC A                  ;} Mode 7 transformation matrix parameter C = -[mode 7 transformation matrix parameter B]
$80:B0E4 85 7C       STA $7C    [$7E:007C]  ;/
$80:B0E6 AD 85 07    LDA $0785  [$7E:0785]  ;\
$80:B0E9 18          CLC                    ;|
$80:B0EA 69 40 00    ADC #$0040             ;|
$80:B0ED 29 FF 00    AND #$00FF             ;|
$80:B0F0 0A          ASL A                  ;} Mode 7 transformation matrix parameter A/D = cos([mode 7 rotation angle] * pi / 80h) * 100h
$80:B0F1 AA          TAX                    ;|
$80:B0F2 BF 43 B4 A0 LDA $A0B443,x          ;|
$80:B0F6 85 78       STA $78    [$7E:0078]  ;|
$80:B0F8 85 7E       STA $7E    [$7E:007E]  ;/
$80:B0FA EE 85 07    INC $0785  [$7E:0785]  ; Increment mode 7 rotation angle

$80:B0FD 28          PLP
$80:B0FE 6B          RTL
}


;;; $B0FF: Decompression - hardcoded destination ;;;
{
;; Parameters:
;;     [[S] + 1]: Destination address (3 bytes)
;;     $47:       Source address (3 bytes)

; Source may overflow bank, target may NOT
$80:B0FF A3 02       LDA $02,s  [$7E:1FF9]  ;\
$80:B101 85 45       STA $45    [$7E:0045]  ;|
$80:B103 A3 01       LDA $01,s  [$7E:1FF8]  ;} $44 = (return address) - 1
$80:B105 85 44       STA $44    [$7E:0044]  ;/
$80:B107 18          CLC                    ;\
$80:B108 69 03 00    ADC #$0003             ;} (Return address) += 3
$80:B10B 83 01       STA $01,s  [$7E:1FF8]  ;/
$80:B10D A0 01 00    LDY #$0001             ;\
$80:B110 B7 44       LDA [$44],y[$8B:92A1]  ;|
$80:B112 85 4C       STA $4C    [$7E:004C]  ;|
$80:B114 C8          INY                    ;} $4C = [[$44] + 1] (destination address)
$80:B115 B7 44       LDA [$44],y[$8B:92A2]  ;|
$80:B117 85 4D       STA $4D    [$7E:004D]  ;/
}


;;; $B119: Decompression - variable destination ;;;
{
;; Parameters:
;;     $47: Source address (3 bytes)
;;     $4C: Destination address (3 bytes)

; Source may overflow bank, target may NOT
$80:B119 08          PHP
$80:B11A 8B          PHB
$80:B11B E2 20       SEP #$20
$80:B11D C2 10       REP #$10
$80:B11F A5 49       LDA $49    [$7E:0049]  ;\
$80:B121 48          PHA                    ;} DB = [source bank]
$80:B122 AB          PLB                    ;/
$80:B123 64 50       STZ $50    [$7E:0050]  ; For checking the 20h (invert) mask when loading $4F to X in the dictionary copy methods
$80:B125 A0 00 00    LDY #$0000             ; Y = 0 (source offset)

; LOOP_MAIN
$80:B128 DA          PHX                    ;\
$80:B129 A6 47       LDX $47    [$7E:0047]  ;|
$80:B12B BD 00 00    LDA $0000,x[$95:80D8]  ;|
$80:B12E E8          INX                    ;|
$80:B12F D0 03       BNE $03    [$B134]     ;|
$80:B131 20 66 B2    JSR $B266  [$80:B266]  ;} $4A = [source++]
                                            ;|
$80:B134 86 47       STX $47    [$7E:0047]  ;|
$80:B136 FA          PLX                    ;|
$80:B137 85 4A       STA $4A    [$7E:004A]  ;/
$80:B139 C9 FF       CMP #$FF               ;\
$80:B13B D0 03       BNE $03    [$B140]     ;} If [$4A] = FFh: (terminator)
$80:B13D AB          PLB
$80:B13E 28          PLP
$80:B13F 6B          RTL                    ; Return

$80:B140 29 E0       AND #$E0               ;\
$80:B142 C9 E0       CMP #$E0               ;} If [$4A] >> 5 = 7: (extended size)
$80:B144 D0 1E       BNE $1E    [$B164]     ;/
$80:B146 A5 4A       LDA $4A    [$7E:004A]  ;\
$80:B148 0A          ASL A                  ;|
$80:B149 0A          ASL A                  ;|
$80:B14A 0A          ASL A                  ;} Push ([$4A] >> 2 & 7) << 5 (command bits shifted to "normal" position)
$80:B14B 29 E0       AND #$E0               ;|
$80:B14D 48          PHA                    ;/
$80:B14E A5 4A       LDA $4A    [$7E:004A]  ;\
$80:B150 29 03       AND #$03               ;} A high = [$4A] & 3 (upper 2 bits of size)
$80:B152 EB          XBA                    ;/
$80:B153 DA          PHX                    ;\
$80:B154 A6 47       LDX $47    [$7E:0047]  ;|
$80:B156 BD 00 00    LDA $0000,x[$95:818C]  ;|
$80:B159 E8          INX                    ;|
$80:B15A D0 03       BNE $03    [$B15F]     ;} A = [source++] (lower 8 bits of size)
$80:B15C 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B15F 86 47       STX $47    [$7E:0047]  ;|
$80:B161 FA          PLX                    ;/
$80:B162 80 08       BRA $08    [$B16C]
                                            ; Else ([$4A] >> 5 != 7):
$80:B164 48          PHA                    ; Push [A] (command bits)
$80:B165 A9 00       LDA #$00               ;\
$80:B167 EB          XBA                    ;} A high = 0
$80:B168 A5 4A       LDA $4A    [$7E:004A]  ;\
$80:B16A 29 1F       AND #$1F               ;} A = [$4A] & 1Fh (size bits)

$80:B16C AA          TAX                    ;\
$80:B16D E8          INX                    ;} X = [A] + 1 (size)
$80:B16E 68          PLA                    ; Pull to A (command bits)
$80:B16F C9 00       CMP #$00               ;\
$80:B171 10 03       BPL $03    [$B176]     ;} If [A] >> 5 >= 4:
$80:B173 4C FF B1    JMP $B1FF  [$80:B1FF]  ; Go to BRANCH_DICTIONARY_VARIANT

$80:B176 C9 20       CMP #$20               ;\
$80:B178 F0 1F       BEQ $1F    [$B199]     ;} If [A] >> 5 = 1: go to BRANCH_BYTE_FILL
$80:B17A C9 40       CMP #$40               ;\
$80:B17C F0 33       BEQ $33    [$B1B1]     ;} If [A] >> 5 = 2: go to BRANCH_WORD_FILL
$80:B17E C9 60       CMP #$60               ;\
$80:B180 F0 64       BEQ $64    [$B1E6]     ;} If [A] >> 5 = 3: go to BRANCH_INCREMENTING_FILL

; Command 0: Direct copy
; LOOP_DIRECT_COPY
$80:B182 DA          PHX                    ;\
$80:B183 A6 47       LDX $47    [$7E:0047]  ;|
$80:B185 BD 00 00    LDA $0000,x[$95:80DB]  ;|
$80:B188 E8          INX                    ;|
$80:B189 D0 03       BNE $03    [$B18E]     ;} A = [source++]
$80:B18B 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B18E 86 47       STX $47    [$7E:0047]  ;|
$80:B190 FA          PLX                    ;/
$80:B191 97 4C       STA [$4C],y[$7F:5020]  ;\
$80:B193 C8          INY                    ;} dest++ = [A]
$80:B194 CA          DEX                    ; Decrement X
$80:B195 D0 EB       BNE $EB    [$B182]     ; If [X] != 0: go to LOOP_DIRECT_COPY
$80:B197 F0 8F       BEQ $8F    [$B128]     ; Go to LOOP_MAIN

; Command 1: Byte fill
; BRANCH_BYTE_FILL
$80:B199 DA          PHX                    ;\
$80:B19A A6 47       LDX $47    [$7E:0047]  ;|
$80:B19C BD 00 00    LDA $0000,x[$95:80D9]  ;|
$80:B19F E8          INX                    ;|
$80:B1A0 D0 03       BNE $03    [$B1A5]     ;} A = [source++]
$80:B1A2 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B1A5 86 47       STX $47    [$7E:0047]  ;|
$80:B1A7 FA          PLX                    ;/

; LOOP_BYTE_FILL
$80:B1A8 97 4C       STA [$4C],y[$7F:5000]  ;\
$80:B1AA C8          INY                    ;} dest++ = [A]
$80:B1AB CA          DEX                    ; Decrement X
$80:B1AC D0 FA       BNE $FA    [$B1A8]     ; If [X] != 0: go to LOOP_BYTE_FILL
$80:B1AE 4C 28 B1    JMP $B128  [$80:B128]  ; Go to LOOP_MAIN

; Command 2: Word fill
; BRANCH_WORD_FILL
$80:B1B1 DA          PHX                    ;\
$80:B1B2 A6 47       LDX $47    [$7E:0047]  ;|
$80:B1B4 BD 00 00    LDA $0000,x[$95:80F3]  ;|
$80:B1B7 E8          INX                    ;|
$80:B1B8 D0 03       BNE $03    [$B1BD]     ;|
$80:B1BA 20 66 B2    JSR $B266  [$80:B266]  ;} $4A = [source++]
                                            ;|
$80:B1BD 86 47       STX $47    [$7E:0047]  ;|
$80:B1BF FA          PLX                    ;|
$80:B1C0 85 4A       STA $4A    [$7E:004A]  ;/
$80:B1C2 DA          PHX                    ;\
$80:B1C3 A6 47       LDX $47    [$7E:0047]  ;|
$80:B1C5 BD 00 00    LDA $0000,x[$95:80F4]  ;|
$80:B1C8 E8          INX                    ;|
$80:B1C9 D0 03       BNE $03    [$B1CE]     ;|
$80:B1CB 20 66 B2    JSR $B266  [$80:B266]  ;} $4B = [source++]
                                            ;|
$80:B1CE 86 47       STX $47    [$7E:0047]  ;|
$80:B1D0 FA          PLX                    ;|
$80:B1D1 85 4B       STA $4B    [$7E:004B]  ;/

; LOOP_WORD_FILL
$80:B1D3 A5 4A       LDA $4A    [$7E:004A]  ;\
$80:B1D5 97 4C       STA [$4C],y[$7F:503A]  ;} dest++ = [$4A]
$80:B1D7 C8          INY                    ;/
$80:B1D8 CA          DEX                    ; Decrement X
$80:B1D9 F0 08       BEQ $08    [$B1E3]     ; If [X] != 0:
$80:B1DB A5 4B       LDA $4B    [$7E:004B]  ;\
$80:B1DD 97 4C       STA [$4C],y[$7F:503B]  ;} dest++ = [$4B]
$80:B1DF C8          INY                    ;/
$80:B1E0 CA          DEX                    ; Decrement X
$80:B1E1 D0 F0       BNE $F0    [$B1D3]     ; If [X] != 0: go to LOOP_WORD_FILL

$80:B1E3 4C 28 B1    JMP $B128  [$80:B128]  ; Go to LOOP_MAIN

; Command 3: Incrementing fill
; BRANCH_INCREMENTING_FILL
$80:B1E6 DA          PHX                    ;\
$80:B1E7 A6 47       LDX $47    [$7E:0047]  ;|
$80:B1E9 BD 00 00    LDA $0000,x[$95:81BC]  ;|
$80:B1EC E8          INX                    ;|
$80:B1ED D0 03       BNE $03    [$B1F2]     ;} A = [source++]
$80:B1EF 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B1F2 86 47       STX $47    [$7E:0047]  ;|
$80:B1F4 FA          PLX                    ;/

; LOOP_INCREMENTING_FILL
$80:B1F5 97 4C       STA [$4C],y[$7F:5111]  ;\
$80:B1F7 1A          INC A                  ;} dest++ = [A++]
$80:B1F8 C8          INY                    ;/
$80:B1F9 CA          DEX                    ; Decrement X
$80:B1FA D0 F9       BNE $F9    [$B1F5]     ; If [X] != 0: go to LOOP_INCREMENTING_FILL
$80:B1FC 4C 28 B1    JMP $B128  [$80:B128]  ; Go to LOOP_MAIN

; Commands 4..7:
; BRANCH_DICTIONARY_VARIANT
$80:B1FF C9 C0       CMP #$C0               ;\
$80:B201 B0 42       BCS $42    [$B245]     ;} If [A] >> 5 >= 6: go to BRANCH_SLIDING_DICTIONARY
; Command 4 and 5: dictionary copy and inverted dictionary copy
$80:B203 29 20       AND #$20               ;\
$80:B205 85 4F       STA $4F    [$7E:004F]  ;} $4F = ([A] >> 5 & 1 != 0) (invert bit)
$80:B207 DA          PHX                    ;\
$80:B208 A6 47       LDX $47    [$7E:0047]  ;|
$80:B20A BD 00 00    LDA $0000,x[$95:8396]  ;|
$80:B20D E8          INX                    ;|
$80:B20E D0 03       BNE $03    [$B213]     ;|
$80:B210 20 66 B2    JSR $B266  [$80:B266]  ;} $4A low = [source++]
                                            ;|
$80:B213 86 47       STX $47    [$7E:0047]  ;|
$80:B215 FA          PLX                    ;|
$80:B216 85 4A       STA $4A    [$7E:004A]  ;/
$80:B218 DA          PHX                    ;\
$80:B219 A6 47       LDX $47    [$7E:0047]  ;|
$80:B21B BD 00 00    LDA $0000,x[$95:8397]  ;|
$80:B21E E8          INX                    ;|
$80:B21F D0 03       BNE $03    [$B224]     ;|
$80:B221 20 66 B2    JSR $B266  [$80:B266]  ;} $4A high = [source++]
                                            ;|
$80:B224 86 47       STX $47    [$7E:0047]  ;|
$80:B226 FA          PLX                    ;|
$80:B227 85 4B       STA $4B    [$7E:004B]  ;/

; BRANCH_DICTIONARY_COPY
$80:B229 E2 20       SEP #$20

; LOOP_DICTIONARY_COPY
$80:B22B DA          PHX
$80:B22C 5A          PHY                    ;\
$80:B22D A4 4A       LDY $4A    [$7E:004A]  ;|
$80:B22F B7 4C       LDA [$4C],y[$7F:50A0]  ;|
$80:B231 C8          INY                    ;} A = [dest base address + [$4A++]]
$80:B232 84 4A       STY $4A    [$7E:004A]  ;|
$80:B234 7A          PLY                    ;/
$80:B235 A6 4F       LDX $4F    [$7E:004F]  ;\
$80:B237 F0 02       BEQ $02    [$B23B]     ;} If invert bit:
$80:B239 49 FF       EOR #$FF               ; Invert A

$80:B23B 97 4C       STA [$4C],y[$7F:50E0]  ;\
$80:B23D C8          INY                    ;} dest++ = [A]
$80:B23E FA          PLX                    ;/
$80:B23F CA          DEX                    ; Decrement X
$80:B240 D0 E9       BNE $E9    [$B22B]     ; If [X] != 0: go to LOOP_DICTIONARY_COPY
$80:B242 4C 28 B1    JMP $B128  [$80:B128]  ; Go to LOOP_MAIN

; Command 6 and 7: sliding dictionary copy and inverted sliding dictionary copy
; BRANCH_SLIDING_DICTIONARY
$80:B245 29 20       AND #$20               ;\
$80:B247 85 4F       STA $4F    [$7E:004F]  ;} $4F = ([A] >> 5 & 1 != 0) (invert bit)
$80:B249 DA          PHX                    ;\
$80:B24A A6 47       LDX $47    [$7E:0047]  ;|
$80:B24C BD 00 00    LDA $0000,x[$95:818A]  ;|
$80:B24F E8          INX                    ;|
$80:B250 D0 03       BNE $03    [$B255]     ;} A = [source++]
$80:B252 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B255 86 47       STX $47    [$7E:0047]  ;|
$80:B257 FA          PLX                    ;/
$80:B258 85 4A       STA $4A    [$7E:004A]  ;\
$80:B25A 64 4B       STZ $4B    [$7E:004B]  ;|
$80:B25C C2 20       REP #$20               ;|
$80:B25E 98          TYA                    ;} $4A = [Y] - [A]
$80:B25F 38          SEC                    ;|
$80:B260 E5 4A       SBC $4A    [$7E:004A]  ;|
$80:B262 85 4A       STA $4A    [$7E:004A]  ;/
$80:B264 80 C3       BRA $C3    [$B229]     ; Go to BRANCH_DICTIONARY_COPY
}


;;; $B266: Source bank overflow correction ;;;
{
$80:B266 A2 00 80    LDX #$8000             ; Set address to $8000
$80:B269 48          PHA                    ;\
$80:B26A 8B          PHB                    ;|
$80:B26B 68          PLA                    ;|
$80:B26C 1A          INC A                  ;} Increment bank
$80:B26D 48          PHA                    ;|
$80:B26E AB          PLB                    ;|
$80:B26F 68          PLA                    ;/
$80:B270 60          RTS
}


;;; $B271: Decompression to VRAM ;;;
{
;; Parameters:
;;     $47: Source address (3 bytes)
;;     $4C: Destination VRAM address * 2 (2 bytes) (must not be odd)

; VRAM destination address $2116 and VRAM increment mode $2115 must be set by the caller (ready for 16-bit access)!

$80:B271 08          PHP
$80:B272 8B          PHB
$80:B273 C2 10       REP #$10
$80:B275 E2 20       SEP #$20
$80:B277 A5 49       LDA $49    [$7E:0049]  ;\
$80:B279 48          PHA                    ;} DB = [source bank]
$80:B27A AB          PLB                    ;/
$80:B27B 64 50       STZ $50    [$7E:0050]  ; For checking the 20h (invert) mask when loading $4F to X in the dictionary copy methods
$80:B27D A4 4C       LDY $4C    [$7E:004C]  ; Y = dest base address

; LOOP_MAIN
$80:B27F DA          PHX                    ;\
$80:B280 A6 47       LDX $47    [$7E:0047]  ;|
$80:B282 BD 00 00    LDA $0000,x[$B9:8000]  ;|
$80:B285 E8          INX                    ;|
$80:B286 D0 03       BNE $03    [$B28B]     ;|
$80:B288 20 66 B2    JSR $B266  [$80:B266]  ;} $4A = [source++]
                                            ;|
$80:B28B 86 47       STX $47    [$7E:0047]  ;|
$80:B28D FA          PLX                    ;|
$80:B28E 85 4A       STA $4A    [$7E:004A]  ;/
$80:B290 C9 FF       CMP #$FF               ;\
$80:B292 D0 03       BNE $03    [$B297]     ;} If [$4A] = FFh: (terminator)
$80:B294 AB          PLB
$80:B295 28          PLP
$80:B296 6B          RTL                    ; Return

$80:B297 29 E0       AND #$E0               ;\
$80:B299 C9 E0       CMP #$E0               ;} If [$4A] >> 5 = 7: (extended size)
$80:B29B D0 1E       BNE $1E    [$B2BB]     ;/
$80:B29D A5 4A       LDA $4A    [$7E:004A]  ;\
$80:B29F 0A          ASL A                  ;|
$80:B2A0 0A          ASL A                  ;|
$80:B2A1 0A          ASL A                  ;} Push ([$4A] >> 2 & 7) << 5 (command bits shifted to "normal" position)
$80:B2A2 29 E0       AND #$E0               ;|
$80:B2A4 48          PHA                    ;/
$80:B2A5 A5 4A       LDA $4A    [$7E:004A]  ;\
$80:B2A7 29 03       AND #$03               ;} A high = [$4A] & 3 (upper 2 bits of size)
$80:B2A9 EB          XBA                    ;/
$80:B2AA DA          PHX                    ;\
$80:B2AB A6 47       LDX $47    [$7E:0047]  ;|
$80:B2AD BD 00 00    LDA $0000,x[$B9:88F3]  ;|
$80:B2B0 E8          INX                    ;|
$80:B2B1 D0 03       BNE $03    [$B2B6]     ;} A = [source++] (lower 8 bits of size)
$80:B2B3 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B2B6 86 47       STX $47    [$7E:0047]  ;|
$80:B2B8 FA          PLX                    ;/
$80:B2B9 80 08       BRA $08    [$B2C3]
                                            ; Else ([$4A] >> 5 != 7):
$80:B2BB 48          PHA                    ; Push [A] (command bits)
$80:B2BC A9 00       LDA #$00               ;\
$80:B2BE EB          XBA                    ;} A high = 0
$80:B2BF A5 4A       LDA $4A    [$7E:004A]  ;\
$80:B2C1 29 1F       AND #$1F               ;} A = [$4A] & 1Fh (size bits)

$80:B2C3 AA          TAX                    ;\
$80:B2C4 E8          INX                    ;} X = [A] + 1 (size)
$80:B2C5 68          PLA                    ; Pull to A (command bits)
$80:B2C6 C9 00       CMP #$00               ;\
$80:B2C8 10 03       BPL $03    [$B2CD]     ;} If [A] >> 5 >= 4:
$80:B2CA 4C A0 B3    JMP $B3A0  [$80:B3A0]  ; Go to BRANCH_DICTIONARY_VARIANT

$80:B2CD C9 20       CMP #$20               ;\
$80:B2CF F0 31       BEQ $31    [$B302]     ;} If [A] >> 5 = 1: go to BRANCH_BYTE_FILL
$80:B2D1 C9 40       CMP #$40               ;\
$80:B2D3 F0 53       BEQ $53    [$B328]     ;} If [A] >> 5 = 2: go to BRANCH_WORD_FILL
$80:B2D5 C9 60       CMP #$60               ;\
$80:B2D7 D0 03       BNE $03    [$B2DC]     ;} If [A] >> 5 = 3:
$80:B2D9 4C 79 B3    JMP $B379  [$80:B379]  ; Go to BRANCH_INCREMENTING_FILL

; Command 0: Direct copy
; LOOP_DIRECT_COPY
$80:B2DC DA          PHX                    ;\
$80:B2DD A6 47       LDX $47    [$7E:0047]  ;|
$80:B2DF BD 00 00    LDA $0000,x[$B9:8004]  ;|
$80:B2E2 E8          INX                    ;|
$80:B2E3 D0 03       BNE $03    [$B2E8]     ;} A = [source++]
$80:B2E5 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B2E8 86 47       STX $47    [$7E:0047]  ;|
$80:B2EA FA          PLX                    ;/
$80:B2EB 48          PHA                    ;\
$80:B2EC 98          TYA                    ;|
$80:B2ED 4A          LSR A                  ;} If dest % 2 == 0:
$80:B2EE 68          PLA                    ;|
$80:B2EF B0 06       BCS $06    [$B2F7]     ;/
$80:B2F1 8F 18 21 00 STA $002118[$7E:2118]  ;\
$80:B2F5 80 04       BRA $04    [$B2FB]     ;} VRAM data write low = [A]

                                            ; Else (dest % 2 != 0):
$80:B2F7 8F 19 21 00 STA $002119[$7E:2119]  ; VRAM data write high = [A]

$80:B2FB C8          INY                    ; ++dest
$80:B2FC CA          DEX                    ; Decrement X
$80:B2FD D0 DD       BNE $DD    [$B2DC]     ; If [X] != 0: go to LOOP_DIRECT_COPY
$80:B2FF 4C 7F B2    JMP $B27F  [$80:B27F]  ; Go to LOOP_MAIN

; Command 1: Byte fill
; BRANCH_BYTE_FILL
$80:B302 DA          PHX                    ;\
$80:B303 A6 47       LDX $47    [$7E:0047]  ;|
$80:B305 BD 00 00    LDA $0000,x[$B9:800A]  ;|
$80:B308 E8          INX                    ;|
$80:B309 D0 03       BNE $03    [$B30E]     ;} A = [source++]
$80:B30B 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B30E 86 47       STX $47    [$7E:0047]  ;|
$80:B310 FA          PLX                    ;/

; LOOP_BYTE_FILL
$80:B311 48          PHA                    ;\
$80:B312 98          TYA                    ;|
$80:B313 4A          LSR A                  ;} If dest % 2 == 0:
$80:B314 68          PLA                    ;|
$80:B315 B0 06       BCS $06    [$B31D]     ;/
$80:B317 8F 18 21 00 STA $002118[$7E:2118]  ;\
$80:B31B 80 04       BRA $04    [$B321]     ;} VRAM data write low = [A]

                                            ; Else (dest % 2 != 0):
$80:B31D 8F 19 21 00 STA $002119[$7E:2119]  ; VRAM data write high = [A]

$80:B321 C8          INY                    ; ++dest
$80:B322 CA          DEX                    ; Decrement X
$80:B323 D0 EC       BNE $EC    [$B311]     ; If [X] != 0: go to LOOP_BYTE_FILL
$80:B325 4C 7F B2    JMP $B27F  [$80:B27F]  ; Go to LOOP_MAIN

; Command 2: Word fill
; BRANCH_WORD_FILL
$80:B328 DA          PHX                    ;\
$80:B329 A6 47       LDX $47    [$7E:0047]  ;|
$80:B32B BD 00 00    LDA $0000,x[$B9:8001]  ;|
$80:B32E E8          INX                    ;|
$80:B32F D0 03       BNE $03    [$B334]     ;|
$80:B331 20 66 B2    JSR $B266  [$80:B266]  ;} $4A = [source++]
                                            ;|
$80:B334 86 47       STX $47    [$7E:0047]  ;|
$80:B336 FA          PLX                    ;|
$80:B337 85 4A       STA $4A    [$7E:004A]  ;/
$80:B339 DA          PHX                    ;\
$80:B33A A6 47       LDX $47    [$7E:0047]  ;|
$80:B33C BD 00 00    LDA $0000,x[$B9:8002]  ;|
$80:B33F E8          INX                    ;|
$80:B340 D0 03       BNE $03    [$B345]     ;|
$80:B342 20 66 B2    JSR $B266  [$80:B266]  ;} $4B = [source++]
                                            ;|
$80:B345 86 47       STX $47    [$7E:0047]  ;|
$80:B347 FA          PLX                    ;|
$80:B348 85 4B       STA $4B    [$7E:004B]  ;/

; LOOP_WORD_FILL
$80:B34A A5 4A       LDA $4A    [$7E:004A]  ; A = [$4A]
$80:B34C 48          PHA                    ;\
$80:B34D 98          TYA                    ;|
$80:B34E 4A          LSR A                  ;} If dest % 2 == 0:
$80:B34F 68          PLA                    ;|
$80:B350 B0 06       BCS $06    [$B358]     ;/
$80:B352 8F 18 21 00 STA $002118[$7E:2118]  ;\
$80:B356 80 04       BRA $04    [$B35C]     ;} VRAM data write low = [A]

                                            ; Else (dest % 2 != 0):
$80:B358 8F 19 21 00 STA $002119[$7E:2119]  ; VRAM data write high = [A]

$80:B35C C8          INY                    ; ++dest
$80:B35D CA          DEX                    ; Decrement X
$80:B35E F0 16       BEQ $16    [$B376]     ; If [X] = 0: go to LOOP_MAIN
$80:B360 A5 4B       LDA $4B    [$7E:004B]  ; A = [$4B]
$80:B362 48          PHA                    ;\
$80:B363 98          TYA                    ;|
$80:B364 4A          LSR A                  ;} If dest % 2 == 0:
$80:B365 68          PLA                    ;|
$80:B366 B0 06       BCS $06    [$B36E]     ;/
$80:B368 8F 18 21 00 STA $002118[$7E:2118]  ;\
$80:B36C 80 04       BRA $04    [$B372]     ;} VRAM data write low = [A]

                                            ; Else (dest % 2 != 0):
$80:B36E 8F 19 21 00 STA $002119[$7E:2119]  ; VRAM data write high = [A]

$80:B372 C8          INY                    ; ++dest
$80:B373 CA          DEX                    ; Decrement X
$80:B374 D0 D4       BNE $D4    [$B34A]     ; If [X] != 0: go to LOOP_WORD_FILL

$80:B376 4C 7F B2    JMP $B27F  [$80:B27F]  ; Go to LOOP_MAIN

; Command 3: Incrementing fill
; BRANCH_INCREMENTING_FILL
$80:B379 DA          PHX                    ;\
$80:B37A A6 47       LDX $47    [$7E:0047]  ;|
$80:B37C BD 00 00    LDA $0000,x[$B9:8663]  ;|
$80:B37F E8          INX                    ;|
$80:B380 D0 03       BNE $03    [$B385]     ;} A = [source++]
$80:B382 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B385 86 47       STX $47    [$7E:0047]  ;|
$80:B387 FA          PLX                    ;/

; LOOP_INCREMENTING_FILL
$80:B388 48          PHA                    ;\
$80:B389 98          TYA                    ;|
$80:B38A 4A          LSR A                  ;} If dest % 2 == 0:
$80:B38B 68          PLA                    ;|
$80:B38C B0 06       BCS $06    [$B394]     ;/
$80:B38E 8F 18 21 00 STA $002118[$7E:2118]  ;\
$80:B392 80 04       BRA $04    [$B398]     ;} VRAM data write low = [A]

                                            ; Else (dest % 2 != 0):
$80:B394 8F 19 21 00 STA $002119[$7E:2119]  ; VRAM data write high = [A]

$80:B398 C8          INY                    ; ++dest
$80:B399 1A          INC A                  ; ++A
$80:B39A CA          DEX                    ; Decrement X
$80:B39B D0 EB       BNE $EB    [$B388]     ; If [X] != 0: go to LOOP_INCREMENTING_FILL
$80:B39D 4C 7F B2    JMP $B27F  [$80:B27F]  ; Go to LOOP_MAIN

; Commands 4..7:
; BRANCH_DICTIONARY_VARIANT
$80:B3A0 C9 C0       CMP #$C0               ;\
$80:B3A2 B0 72       BCS $72    [$B416]     ;} If [A] >> 5 >= 6: go to BRANCH_SLIDING_DICTIONARY
; Command 4 and 5: dictionary copy and inverted dictionary copy
$80:B3A4 29 20       AND #$20               ;\
$80:B3A6 85 4F       STA $4F    [$7E:004F]  ;} $4F = ([A] >> 5 & 1 != 0) (invert bit)
$80:B3A8 DA          PHX                    ;\
$80:B3A9 A6 47       LDX $47    [$7E:0047]  ;|
$80:B3AB BD 00 00    LDA $0000,x[$B9:815E]  ;|
$80:B3AE E8          INX                    ;|
$80:B3AF D0 03       BNE $03    [$B3B4]     ;|
$80:B3B1 20 66 B2    JSR $B266  [$80:B266]  ;} $4A low = [source++]
                                            ;|
$80:B3B4 86 47       STX $47    [$7E:0047]  ;|
$80:B3B6 FA          PLX                    ;|
$80:B3B7 85 4A       STA $4A    [$7E:004A]  ;/
$80:B3B9 DA          PHX                    ;\
$80:B3BA A6 47       LDX $47    [$7E:0047]  ;|
$80:B3BC BD 00 00    LDA $0000,x[$B9:815F]  ;|
$80:B3BF E8          INX                    ;|
$80:B3C0 D0 03       BNE $03    [$B3C5]     ;|
$80:B3C2 20 66 B2    JSR $B266  [$80:B266]  ;} $4A high = [source++]
                                            ;|
$80:B3C5 86 47       STX $47    [$7E:0047]  ;|
$80:B3C7 FA          PLX                    ;|
$80:B3C8 85 4B       STA $4B    [$7E:004B]  ;/
$80:B3CA C2 20       REP #$20               ;\
$80:B3CC A5 4C       LDA $4C    [$7E:004C]  ;|
$80:B3CE 18          CLC                    ;} $4A += [dest base address]
$80:B3CF 65 4A       ADC $4A    [$7E:004A]  ;|
$80:B3D1 85 4A       STA $4A    [$7E:004A]  ;/

; LOOP_DICTIONARY_COPY
$80:B3D3 DA          PHX
$80:B3D4 C2 20       REP #$20
$80:B3D6 A5 4A       LDA $4A    [$7E:004A]  ;\
$80:B3D8 4A          LSR A                  ;} VRAM address = [$4A] / 2 (actual VRAM address)
$80:B3D9 8F 16 21 00 STA $002116[$7E:2116]  ;/
$80:B3DD AF 39 21 00 LDA $002139[$7E:2139]  ; Dummy VRAM read due to prefetch glitch
$80:B3E1 AF 39 21 00 LDA $002139[$7E:2139]  ; A = [VRAM data read]
$80:B3E5 90 01       BCC $01    [$B3E8]     ; If [$4A] % 2 != 0:
$80:B3E7 EB          XBA                    ; A = [A high]

$80:B3E8 E6 4A       INC $4A    [$7E:004A]  ; ++$4A
$80:B3EA E2 20       SEP #$20
$80:B3EC A6 4F       LDX $4F    [$7E:004F]  ;\
$80:B3EE F0 02       BEQ $02    [$B3F2]     ;} If invert bit:
$80:B3F0 49 FF       EOR #$FF               ; Invert A

$80:B3F2 48          PHA                    ;\
$80:B3F3 C2 20       REP #$20               ;|
$80:B3F5 98          TYA                    ;|
$80:B3F6 4A          LSR A                  ;} VRAM address = [Y] / 2 (actual VRAM address)
$80:B3F7 8F 16 21 00 STA $002116[$7E:2116]  ;|
$80:B3FB E2 20       SEP #$20               ;|
$80:B3FD 68          PLA                    ;/
$80:B3FE 48          PHA                    ;\
$80:B3FF 98          TYA                    ;|
$80:B400 4A          LSR A                  ;} If dest % 2 == 0:
$80:B401 68          PLA                    ;|
$80:B402 B0 06       BCS $06    [$B40A]     ;/
$80:B404 8F 18 21 00 STA $002118[$7E:2118]  ;\
$80:B408 80 04       BRA $04    [$B40E]     ;} VRAM data write low = [A]

                                            ; Else (dest % 2 != 0):
$80:B40A 8F 19 21 00 STA $002119[$7E:2119]  ; VRAM data write high = [A]

$80:B40E C8          INY                    ; ++dest
$80:B40F FA          PLX                    ;\
$80:B410 CA          DEX                    ;} Decrement X
$80:B411 D0 C0       BNE $C0    [$B3D3]     ; If [X] != 0: go to LOOP_DICTIONARY_COPY
$80:B413 4C 7F B2    JMP $B27F  [$80:B27F]  ; Go to LOOP_MAIN

; Command 6 and 7: sliding dictionary copy and inverted sliding dictionary copy
; BRANCH_SLIDING_DICTIONARY
$80:B416 29 20       AND #$20               ;\
$80:B418 85 4F       STA $4F    [$7E:004F]  ;} $4F = invert bit
$80:B41A DA          PHX                    ;\
$80:B41B A6 47       LDX $47    [$7E:0047]  ;|
$80:B41D BD 00 00    LDA $0000,x[$B9:8088]  ;|
$80:B420 E8          INX                    ;|
$80:B421 D0 03       BNE $03    [$B426]     ;} A = [source++]
$80:B423 20 66 B2    JSR $B266  [$80:B266]  ;|
                                            ;|
$80:B426 86 47       STX $47    [$7E:0047]  ;|
$80:B428 FA          PLX                    ;/
$80:B429 85 4A       STA $4A    [$7E:004A]  ;\
$80:B42B 64 4B       STZ $4B    [$7E:004B]  ;|
$80:B42D C2 20       REP #$20               ;|
$80:B42F 98          TYA                    ;} $4A = [Y] - [A]
$80:B430 38          SEC                    ;|
$80:B431 E5 4A       SBC $4A    [$7E:004A]  ;|
$80:B433 85 4A       STA $4A    [$7E:004A]  ;/
$80:B435 80 9C       BRA $9C    [$B3D3]     ; Go to LOOP_DICTIONARY_COPY
}


;;; $B437: Tilemap - failed NTSC/PAL check ;;;
{
; THIS GAME PAK IS NOT DESIGNED
; FOR YOUR SUPER FAMICOM OR
; SUPER NES.            NINTENDO

$80:B437             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 007D, 0071, 0072, 007C, 000F, 0070, 006A, 0076, 006E, 000F, 0079, 006A, 0074, 000F, 0072, 007C, 000F, 0077, 0078, 007D, 000F, 006D, 006E, 007C, 0072, 0070, 0072, 0077, 006E, 006D, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 002B, 002D, 000D, 000E, 000D, 000F, 000E, 000A, 0026, 0022, 000C, 0000, 0026, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 006F, 0078, 007B, 000F, 0082, 0078, 007E, 007B, 000F, 003B, 0010, 0038, 001E, 003A, 000F, 001F, 001A, 0036, 0011, 001C, 0010, 0036, 000F, 0078, 007B, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 002B, 002D, 000D, 000E, 000D, 000F, 0027, 000E, 002B, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 003B, 0010, 0038, 001E, 003A, 000F, 0037, 001E, 003B, 0088, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 0077, 0072, 0077, 007D, 006E, 0077, 006D, 0078, 000F,
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
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F
}


;;; $BC37: Tilemap - failed SRAM mapping check ;;;
{
;  IT IS A SERIOUS CRIME TO COPY
;  VIDEO GAMES.      18 USC 2319.
;  PLEASE REFER TO YOUR NINTENDO
;  GAME INSTRUCTION BOOKLET FOR
;  FURTHER INFORMATION.
; --------------------------------
;
;              警  告
;      ビデオゲームのコピーは法律で禁じられています。
;      詳しくは取扱説明書を参照してください。

; (warning)
; (game copying is prohibited by law.)
; (for further information, please consult your user's manual.)

$80:BC37             dw 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 002F, 000A, 000D, 0027, 0022, 0027, 000C, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 003F, 001A, 003A, 0037, 0011, 0037, 0030, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 0072, 007D, 000F, 0072, 007C, 000F, 006A, 000F, 007C, 006E, 007B, 0072, 0078, 007E, 007C, 000F, 006C, 007B, 0072, 0076, 006E, 000F, 007D, 0078, 000F, 006C, 0078, 0079, 0082, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 007F, 0072, 006D, 006E, 0078, 000F, 0070, 006A, 0076, 006E, 007C, 0088, 000F, 000F, 000F, 000F, 000F, 000F, 0061, 0068, 000F, 007E, 007C, 006C, 000F, 0062, 0063, 0061, 0069, 0088, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 0079, 0075, 006E, 006A, 007C, 006E, 000F, 007B, 006E, 006F, 006E, 007B, 000F, 007D, 0078, 000F, 0082, 0078, 007E, 007B, 000F, 0077, 0072, 0077, 007D, 006E, 0077, 006D, 0078, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 0070, 006A, 0076, 006E, 000F, 0072, 0077, 007C, 007D, 007B, 007E, 006C, 007D, 0072, 0078, 0077, 000F, 006B, 0078, 0078, 0074, 0075, 006E, 007D, 000F, 006F, 0078, 007B, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 006F, 007E, 007B, 007D, 0071, 006E, 007B, 000F, 0072, 0077, 006F, 0078, 007B, 0076, 006A, 007D, 0072, 0078, 0077, 0088, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056, 0056,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 0168, 000F, 000F, 0169, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 0178, 000F, 000F, 0179, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 008E, 00C8, 00D6, 0106, 000F, 0119, 018F, 00F0, 008D, 000F, 0161, 016A, 016B, 0126, 016C, 017E, 0180, 0181, 0182, 0183, 0184, 0185, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 008F, 00E4, 00E6, 010F, 0056, 0129, 019F, 0100, 008F, 0056, 0171, 017A, 017B, 0192, 017C, 017D, 0190, 0191, 0192, 0193, 0194, 0195, 017F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 0051, 016D, 0186, 0161, 0187, 0188, 0189, 018A, 018B, 018C, 018D, 018E, 016D, 0182, 0186, 00E3, 0110, 0183, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 0043, 017D, 0196, 0171, 0197, 0198, 0199, 019A, 019B, 019C, 019D, 019E, 017D, 0192, 0196, 00EB, 0120, 0193, 017F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F,
                        000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F, 000F
}


;;; $C437: Load from load station ;;;
{
$80:C437 08          PHP
$80:C438 8B          PHB
$80:C439 4B          PHK                    ;\
$80:C43A AB          PLB                    ;} DB = $80
$80:C43B C2 30       REP #$30
$80:C43D A9 01 00    LDA #$0001             ;\
$80:C440 8D 75 1E    STA $1E75  [$7E:1E75]  ;} Save station lockout flag = 1
$80:C443 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$80:C446 0A          ASL A                  ;|
$80:C447 AA          TAX                    ;|
$80:C448 AD 8B 07    LDA $078B  [$7E:078B]  ;|
$80:C44B 0A          ASL A                  ;|
$80:C44C 85 12       STA $12    [$7E:0012]  ;|
$80:C44E 0A          ASL A                  ;|
$80:C44F 18          CLC                    ;} X = [[$C4B5 + [area index] * 2] + [load station index] * Eh]
$80:C450 65 12       ADC $12    [$7E:0012]  ;|
$80:C452 6D 8B 07    ADC $078B  [$7E:078B]  ;|
$80:C455 0A          ASL A                  ;|
$80:C456 18          CLC                    ;|
$80:C457 7D B5 C4    ADC $C4B5,x[$80:C4C1]  ;|
$80:C45A AA          TAX                    ;/
$80:C45B BD 00 00    LDA $0000,x[$80:CB2B]  ;\
$80:C45E 8D 9B 07    STA $079B  [$7E:079B]  ;} Room pointer = [[X]]
$80:C461 BD 02 00    LDA $0002,x[$80:CB2D]  ;\
$80:C464 8D 8D 07    STA $078D  [$7E:078D]  ;} Door pointer = [[X] + 2]
$80:C467 BD 04 00    LDA $0004,x[$80:CB2F]  ;\
$80:C46A 8D 8F 07    STA $078F  [$7E:078F]  ;} Door BTS = [[X] + 4]
$80:C46D BD 06 00    LDA $0006,x[$80:CB31]  ;\
$80:C470 8D 11 09    STA $0911  [$7E:0911]  ;} Layer 1 X position = BG1 X offset = [[X] + 6]
$80:C473 8D 1D 09    STA $091D  [$7E:091D]  ;/
$80:C476 BD 08 00    LDA $0008,x[$80:CB33]  ;\
$80:C479 8D 15 09    STA $0915  [$7E:0915]  ;} Layer 1 Y position = BG1 Y offset = [[X] + 8]
$80:C47C 8D 1F 09    STA $091F  [$7E:091F]  ;/
$80:C47F BD 0A 00    LDA $000A,x[$80:CB35]  ;\
$80:C482 18          CLC                    ;|
$80:C483 6D 15 09    ADC $0915  [$7E:0915]  ;} Samus Y position = Samus previous Y position = [[X] + Ah] + [layer 1 Y position]
$80:C486 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;|
$80:C489 8D 14 0B    STA $0B14  [$7E:0B14]  ;/
$80:C48C AD 11 09    LDA $0911  [$7E:0911]  ;\
$80:C48F 18          CLC                    ;|
$80:C490 69 80 00    ADC #$0080             ;|
$80:C493 7D 0C 00    ADC $000C,x[$80:CB37]  ;} Samus X position = Samus previous X position = [[X] + Ch] + [layer 1 X position] + 80h
$80:C496 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;|
$80:C499 8D 10 0B    STA $0B10  [$7E:0B10]  ;/
$80:C49C 64 B1       STZ $B1    [$7E:00B1]  ; BG1 X scroll = 0
$80:C49E 64 B3       STZ $B3    [$7E:00B3]  ; BG1 Y scroll = 0
$80:C4A0 E2 20       SEP #$20               ;\
$80:C4A2 A9 8F       LDA #$8F               ;|
$80:C4A4 48          PHA                    ;|
$80:C4A5 AB          PLB                    ;} Area index = [[room pointer] + 1]
$80:C4A6 AE 9B 07    LDX $079B  [$7E:079B]  ;|
$80:C4A9 BD 01 00    LDA $0001,x[$8F:DF46]  ;|
$80:C4AC 8D 9F 07    STA $079F  [$7E:079F]  ;/
$80:C4AF 9C F7 05    STZ $05F7  [$7E:05F7]  ; Enable mini-map
$80:C4B2 AB          PLB
$80:C4B3 28          PLP
$80:C4B4 6B          RTL
}


;;; $C4B5: Load station lists ;;;
{
; Pointers to each area's load station list
$80:C4B5             dw C4C5, C5CF, C6D9, C81B, C917, CA2F, CB2B, CC19

; Load station lists are indexed by $078B
; Indices 0..7 are the only ones that can be used by save stations (gunship save station uses 0)
; Indices 8..Fh are elevators, selectable by the debug file select map if they've been used before (if elevator doors mark them as used)
; Indices 10h+ are debug load points, except for Crateria's index 12h, which is used for the gunship landing sequence,
; these debug load points are unconditionally selectable in the debug file select map

;                        _______________________________ Room pointer
;                       |     __________________________ Door pointer
;                       |    |     _____________________ Door BTS
;                       |    |    |     ________________ Screen X position
;                       |    |    |    |     ___________ Screen Y position
;                       |    |    |    |    |     ______ Samus Y offset (relative to screen top)
;                       |    |    |    |    |    |     _ Samus X offset (relative to screen centre)
;                       |    |    |    |    |    |    |
; Crateria load stations
$80:C4C5             dw 91F8,896A,0000,0400,0400,0040,0000, ; 0: Landing site (from Crateria mainstreet)
                        93D5,899A,0000,0000,0000,0098,FFE0, ; 1: Crateria save station (from Crateria mainstreet)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        94CC,8ABA,0000,0000,0000,00A8,0000, ; 8: Crateria -> Maridia elevator (from Post Crateria maze yellow door)
                        962A,8A42,0000,0000,0000,00A8,0000, ; 9: Crateria -> Red Brinstar elevator (from Pre moat room)
                        97B5,8B86,0000,0000,0000,0088,0000, ; Ah: Crateria -> Blue Brinstar elevator (from Old Mother Brain room)
                        9938,8C22,0000,0000,0000,0088,0000, ; Bh: Crateria -> Green Brinstar elevator (from West Crateria kago hall)
                        A66A,91F2,0000,0000,0100,0098,0000, ; Ch: Tourian entrance (from Pre Tourian hall)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        91F8,896A,0000,0400,0400,0040,0000, ; 10h: Landing site (from Crateria mainstreet)
                        94FD,8A7E,0000,0000,0400,0095,0000, ; 11h: Wrecked Ship back door (from East Crateria kago shaft)
                        91F8,88FE,0000,0400,0000,0080,0000  ; 12h: Gunship landing sequence (landing site from landing site)

; Brinstar load stations
$80:C5CF             dw A184,8DF6,0000,0000,0000,0098,FFE0, ; 0: Pre Spore Spawn save station (from Charge beam room)
                        A201,8D12,0000,0000,0000,0098,FFE0, ; 1: Green Brinstar mainstreet save station (from Green Brinstar mainstreet)
                        A22A,8F52,0000,0000,0000,0098,FFE0, ; 2: Brinstar false floor save station (from Brinstar false floor spike hall)
                        A70B,9186,0000,0000,0000,0098,0000, ; 3: Kraid save station (from Kraid kihunter hall)
                        A734,90D2,0000,0000,0000,0098,0000, ; 4: Red Brinstar save station (from Red Brinstar -> Crateria elevator)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        9AD9,8D42,0001,0000,0200,00A8,0000, ; 8: Green Brinstar mainstreet (from Pre Brinstar map room hall)
                        9E9F,8E86,0000,0500,0200,00A8,0000, ; 9: Morph ball room (from Brinstar diagonal room)
                        A322,908A,0000,0000,0200,00A8,0000, ; Ah: Red Brinstar -> Crateria elevator (from Red Brinstar damage boost hall)
                        A6A1,A384,0000,0000,0000,0088,0000, ; Bh: Kraid's lair entrance (from n00b tube east)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        9AD9,8D42,0001,0000,0200,00A8,0000, ; 10h: Green Brinstar mainstreet (from Pre Brinstar map room hall)
                        A56B,91CE,0000,0000,0100,0080,0000, ; 11h: Pre Kraid room (from Kraid)
                        9D19,8E62,0000,0300,0000,0080,0000  ; 12h: Charge beam room (from Brinstar false wall super-sidehopper power bomb room)

; Norfair load stations
$80:C6D9             dw AAB5,9456,0000,0000,0000,0098,0000, ; 0: Post Crocomire save station (from Post Crocomire room)
                        B0DD,959A,0000,0000,0000,0098,FFE0, ; 1: Bubble Norfair save station (from Bubble Norfair mainstreet)
                        B167,97DA,0000,0000,0000,0098,0000, ; 2: Rock Norfair save station (from Norfair speed blockade hall)
                        B192,93BA,0000,0000,0000,0098,0000, ; 3: Pre Crocomire save station (from Norfair slope)
                        B1BB,9702,0000,0000,0000,0098,FFE0, ; 4: Pre Lower Norfair save station (from Norfair -> Lower Norfair elevator)
                        B741,9A0E,0000,0000,0000,0098,0000, ; 5: Lower Norfair save station (from Lower Norfair kihunter shaft)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        A7DE,92A6,0000,0000,0200,00A8,0000, ; 8: Norfair mainstreet (from first hot room)
                        AF3F,96DE,0000,0000,0000,0088,0000, ; 9: Norfair -> Lower Norfair elevator (from Lower Norfair entrance)
                        B236,9846,0000,0400,0200,0088,0000, ; Ah: Lower Norfair mainstreet (from Golden chozo statue lava lake)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        A7DE,932A,0002,0000,0200,00A8,0000, ; 10h: Norfair mainstreet (from Ice beam mockball hall)
                        A923,93EA,0001,0C00,0200,00A0,0000, ; 11h: Norfair slope (from Crocomire)
                        B37A,995A,0000,0000,0000,00A0,0000, ; 12h: Pre Ridley hall (from Lower Norfair holtz room)
                        AA82,946E,0000,0000,0000,00B5,0000, ; 13h: Post Crocomire room (from Post Crocomire power bombs room)
                        B236,9846,0001,0500,0200,0035,0000, ; 14h: Lower Norfair mainstreet (from Golden chozo statue lava lake)
                        B283,98A6,0000,0200,0200,0000,0000, ; 15h: Golden Torizo (from Lower Norfair energy station)
                        B283,983A,0000,0000,0000,0080,0000  ; 16h: Golden Torizo (from Golden chozo statue lava lake)

; Wrecked Ship load stations
$80:C81B             dw CE8A,A240,0000,0000,0000,0098,0000, ; 0: Wrecked Ship save station (from Wrecked Ship mainstreet)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        CA08,A1F8,0001,0000,0000,0080,0000, ; 10h: Wrecked Ship entrance treadmill (from Wrecked Ship mainstreet)
                        CC6F,A2B8,0000,0400,0000,0080,0000  ; 11h: Pre Phantoon hall (from Wrecked Ship map station)

; Maridia load stations
$80:C917             dw CED2,A354,0000,0000,0000,0098,0000, ; 0: n00b tube save station (from n00b tube)
                        D3DF,A588,0000,0000,0000,0098,0000, ; 1: Maridia save station (from Maridia -> Crateria elevator)
                        D765,A744,0000,0000,0000,0098,FFE0, ; 2: Snail room save station (from Snail room)
                        D81A,A7EC,0000,0000,0000,0098,0000, ; 3: Draygon save station (from Maridia grapple room)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        D30B,A570,0000,0000,0200,00A8,0000, ; 8: Maridia -> Crateria elevator (from Sandy Maridia thin platform hall)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        D1DD,A4A4,0001,0000,0000,00D0,0000, ; 10h: Sandy Maridia unused passage to Sandy Maridia mainstreet (from Sandy Maridia memu room)
                        D78F,A81C,0000,0000,0200,0080,0000, ; 11h: Pre Draygon room (from ?)
                        D617,A72C,0000,0300,0000,0080,0000, ; 12h: Mochtroid room (from Snail room)
                        D48E,A648,0000,0000,0100,0080,0000  ; 13h: Elevatube south (from Sand falls west)

; Tourian load stations
$80:CA2F             dw DE23,AABC,0000,0000,0000,0098,FFE0, ; 0: Pre Mother Brain save station trap (from Pre Mother Brain shaft)
                        DF1B,A99C,0000,0000,0000,0098,0000, ; 1: Tourian save station (from Tourian -> Crateria elevator)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        DAAE,A9A8,0000,0000,0200,00A8,0000, ; 8: Tourian -> Crateria elevator (from Metroid room 1)
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        0000,0000,0000,0400,0400,00B0,0000,
                        DDF3,AAA4,0000,0000,0200,0080,0000, ; 10h: Pre Mother Brain shaft (from Tourian eye-door room)
                        DDF3,AA38,0000,0000,0000,0080,0000  ; 11h: Pre Mother Brain shaft (from Shitroid room)

; Ceres load stations
$80:CB2B             dw DF45,AB58,0000,0000,0000,0048,0000, ; Ceres elevator shaft (from Ceres pre elevator hall)
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000,
                        DF45,AB58,0000,0000,0000,0040,0000

; Debug load stations
$80:CC19             dw E82C,ABC4,0000,0000,0000,00B0,0000, ; Debug room (from ?)
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000,
                        E82C,ABC4,0000,0000,0000,00B0,0000
}


;;; $CD07: Set debug elevators as used ;;;
{
; Called if an elevator door has (elevator properties) & Fh != 0, which is never true, so this routine is unused/debug
$80:CD07 08          PHP
$80:CD08 8B          PHB
$80:CD09 4B          PHK                    ;\
$80:CD0A AB          PLB                    ;} DB = $80
$80:CD0B C2 30       REP #$30
$80:CD0D AD 9F 07    LDA $079F  [$7E:079F]  ;\
$80:CD10 0A          ASL A                  ;|
$80:CD11 AA          TAX                    ;|
$80:CD12 AD 93 07    LDA $0793  [$7E:0793]  ;|
$80:CD15 29 0F 00    AND #$000F             ;|
$80:CD18 3A          DEC A                  ;} Y = [$CD46 + [area index] * 2] + (([elevator door properties] & Fh) - 1) * 4
$80:CD19 0A          ASL A                  ;|
$80:CD1A 0A          ASL A                  ;|
$80:CD1B 18          CLC                    ;|
$80:CD1C 7D 46 CD    ADC $CD46,x            ;|
$80:CD1F A8          TAY                    ;/
$80:CD20 A9 00 00    LDA #$0000             ; Clear A high
$80:CD23 E2 20       SEP #$20
$80:CD25 B9 00 00    LDA $0000,y            ;\
$80:CD28 AA          TAX                    ;|
$80:CD29 B9 01 00    LDA $0001,y            ;} $7E:D8F8 + [[Y]] |= [[Y] + 1] (set source elevator as used)
$80:CD2C 1F F8 D8 7E ORA $7ED8F8,x          ;|
$80:CD30 9F F8 D8 7E STA $7ED8F8,x          ;/
$80:CD34 B9 02 00    LDA $0002,y            ;\
$80:CD37 AA          TAX                    ;|
$80:CD38 B9 03 00    LDA $0003,y            ;} $7E:D8F8 + [[Y] + 2] |= [[Y] + 3] (set destination elevator as used)
$80:CD3B 1F F8 D8 7E ORA $7ED8F8,x          ;|
$80:CD3F 9F F8 D8 7E STA $7ED8F8,x          ;/
$80:CD43 AB          PLB
$80:CD44 28          PLP
$80:CD45 6B          RTL

; Pointers to each area's elevator bits
$80:CD46             dw CD52, CD66, CD76, CD8A, CD82, CD86

;                        __________ Source area index
;                       |   _______ Source bit
;                       |  |   ____ Destination area index
;                       |  |  |   _ Destination bit
;                       |  |  |  |
; Crateria elevator bits
$80:CD52             db 01,01,09,01,
                        01,02,03,04,
                        01,04,03,02,
                        01,08,03,01,
                        01,10,0B,01

; Brinstar elevator bits
$80:CD66             db 03,01,01,08,
                        03,02,01,04,
                        03,04,01,02,
                        03,08,05,01

; Norfair elevator bits
$80:CD76             db 05,01,03,08,
                        05,02,05,04,
                        05,04,05,02

; Maridia elevator bits
$80:CD82             db 09,01,01,01

; Tourian elevator bits
$80:CD86             db 0B,01,01,10

; Wrecked Ship elevator bits
$80:CD8A             db 00,00,00,00
}


;;; $CD8E: Free space ;;;
{
$80:CD8E             fillto $80FFC0, $FF
}


;;; $FFC0: Game header ;;;
{
$80:FFC0             db 53,75,70,65,72,20,4D,65,74,72,6F,69,64,20,20,20,20,20,20,20,20 ; 'Super Metroid        '
$80:FFD5             db 30 ; ROM speed and map mode: FastROM, LoROM
$80:FFD6             db 02 ; Chipset: ROM + RAM + SRAM
$80:FFD7             db 0C ; ROM size: 400000h bytes = 4 MiB
$80:FFD8             db 03 ; SRAM size: 2000h bytes = 8 KiB
$80:FFD9             db 00 ; Country code: Japan
$80:FFDA             db 01 ; Developer code: Nintendo
$80:FFDB             db 00 ; Version number
$80:FFDC             dw 0720 ; Checksum complement
$80:FFDE             dw F8DF ; Checksum
$80:FFE0             dw 8573, 8573, 8573, 8573, 8573, 9583, 8573, 986A ; Native interrupt vectors
$80:FFF0             dw 8573, 8573, 8573, 8573, 8573, 8573, 841C, 8573 ; Emulation interrupt vectors
}
