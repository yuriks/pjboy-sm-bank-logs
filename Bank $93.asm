;;; $8000: Initialise projectile ;;;
{
;; Parameters:
;;     X: Projectile index
$93:8000 08          PHP
$93:8001 8B          PHB
$93:8002 4B          PHK                    ;\
$93:8003 AB          PLB                    ;} DB = $93
$93:8004 C2 30       REP #$30
$93:8006 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$93:8009 29 0F 00    AND #$000F             ;|
$93:800C 0A          ASL A                  ;} $12 = [projectile direction] * 2
$93:800D 85 12       STA $12    [$7E:0012]  ;/
$93:800F BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$93:8012 89 00 0F    BIT #$0F00             ;} If not beam: go to BRANCH_NOT_BEAM
$93:8015 D0 1B       BNE $1B    [$8032]     ;/
$93:8017 89 10 00    BIT #$0010             ;\
$93:801A D0 0B       BNE $0B    [$8027]     ;} If not charged:
$93:801C 29 0F 00    AND #$000F             ;\
$93:801F 0A          ASL A                  ;|
$93:8020 A8          TAY                    ;} Y = [$83C1 + (beam type) * 2]
$93:8021 B9 C1 83    LDA $83C1,y[$93:83C1]  ;|
$93:8024 A8          TAY                    ;/
$93:8025 80 15       BRA $15    [$803C]     ; Go to BRANCH_MERGE

$93:8027 29 0F 00    AND #$000F             ;\ Else (charged):
$93:802A 0A          ASL A                  ;|
$93:802B A8          TAY                    ;} Y = [$83D9 + (beam type) * 2]
$93:802C B9 D9 83    LDA $83D9,y[$93:83E1]  ;|
$93:802F A8          TAY                    ;/
$93:8030 80 0A       BRA $0A    [$803C]     ; Go to BRANCH_MERGE

; BRANCH_NOT_BEAM
$93:8032 EB          XBA                    ;\
$93:8033 29 0F 00    AND #$000F             ;|
$93:8036 0A          ASL A                  ;|
$93:8037 A8          TAY                    ;} Y = [$83F1 + (projectile type) * 2]
$93:8038 B9 F1 83    LDA $83F1,y[$93:83F3]  ;|
$93:803B A8          TAY                    ;/

; BRANCH_MERGE
$93:803C B9 00 00    LDA $0000,y[$93:8641]  ;\
$93:803F 9D 2C 0C    STA $0C2C,x[$7E:0C2C]  ;} Projectile damage = [[Y]]
$93:8042 10 04       BPL $04    [$8048]     ; If [projectile damage] < 0:
$93:8044 5C 73 85 80 JMP $808573[$80:8573]  ; Crash

$93:8048 C8          INY                    ;\
$93:8049 C8          INY                    ;|
$93:804A 98          TYA                    ;|
$93:804B 18          CLC                    ;|
$93:804C 65 12       ADC $12    [$7E:0012]  ;} Projectile instruction pointer = [[Y] + 2 + [projectile direction] * 2]
$93:804E A8          TAY                    ;|
$93:804F B9 00 00    LDA $0000,y[$93:8651]  ;|
$93:8052 9D 40 0C    STA $0C40,x[$7E:0C40]  ;/
$93:8055 A8          TAY                    ;\
$93:8056 B9 04 00    LDA $0004,y[$93:9F07]  ;|
$93:8059 29 FF 00    AND #$00FF             ;} Projectile X radius = [[projectile instruction pointer] + 4]
$93:805C 9D B4 0B    STA $0BB4,x[$7E:0BB4]  ;/
$93:805F B9 05 00    LDA $0005,y[$93:9F08]  ;\
$93:8062 29 FF 00    AND #$00FF             ;} Projectile Y radius = [[projectile instruction pointer] + 5]
$93:8065 9D C8 0B    STA $0BC8,x[$7E:0BC8]  ;/
$93:8068 A9 01 00    LDA #$0001             ;\
$93:806B 9D 54 0C    STA $0C54,x[$7E:0C54]  ;} Projectile instruction timer = 1
$93:806E AB          PLB
$93:806F 28          PLP
$93:8070 6B          RTL
}


;;; $8071: Initialise super missile link ;;;
{
; Instruction list is $9F7B (loop of single instruction with 8x8 radius and dummy empty spritemap)
$93:8071 08          PHP
$93:8072 8B          PHB
$93:8073 4B          PHK                    ;\
$93:8074 AB          PLB                    ;} DB = $93
$93:8075 C2 30       REP #$30
$93:8077 BD 19 0C    LDA $0C19,x[$7E:0C1B]  ;\
$93:807A 29 0F 00    AND #$000F             ;|
$93:807D 0A          ASL A                  ;|
$93:807E A8          TAY                    ;|
$93:807F B9 2B 84    LDA $842B,y[$93:842F]  ;} Projectile damage = [[$842B + (projectile type) * 2]]
$93:8082 A8          TAY                    ;|
$93:8083 B9 00 00    LDA $0000,y[$93:866D]  ;|
$93:8086 9D 2C 0C    STA $0C2C,x[$7E:0C2E]  ;/
$93:8089 10 04       BPL $04    [$808F]     ; If [projectile damage] < 0:
$93:808B 5C 73 85 80 JML $808573[$80:8573]  ; Crash

$93:808F C8          INY                    ;\
$93:8090 C8          INY                    ;|
$93:8091 B9 00 00    LDA $0000,y[$93:866F]  ;} Projectile instruction pointer = [[$842B + (projectile type) * 2] + 2]
$93:8094 9D 40 0C    STA $0C40,x[$7E:0C42]  ;/
$93:8097 A9 01 00    LDA #$0001             ;\
$93:809A 9D 54 0C    STA $0C54,x[$7E:0C56]  ;} Projectile instruction timer = 1
$93:809D AB          PLB
$93:809E 28          PLP
$93:809F 6B          RTL
}


;;; $80A0: Initialise (power) bomb ;;;
{
$93:80A0 08          PHP
$93:80A1 8B          PHB
$93:80A2 4B          PHK                    ;\
$93:80A3 AB          PLB                    ;} DB = $93
$93:80A4 C2 30       REP #$30
$93:80A6 BD 19 0C    LDA $0C19,x[$7E:0C23]  ;\
$93:80A9 29 0F 00    AND #$000F             ;|
$93:80AC 0A          ASL A                  ;|
$93:80AD A8          TAY                    ;|
$93:80AE B9 F1 83    LDA $83F1,y[$93:83FB]  ;} Projectile damage = [[$83F1 + projectile type * 2]]
$93:80B1 A8          TAY                    ;|
$93:80B2 B9 00 00    LDA $0000,y[$93:8675]  ;|
$93:80B5 9D 2C 0C    STA $0C2C,x[$7E:0C36]  ;/
$93:80B8 10 04       BPL $04    [$80BE]     ; If [projectile damage] < 0:
$93:80BA 5C 73 85 80 JML $808573[$80:8573]  ; Crash
                                            

$93:80BE C8          INY                    ;\
$93:80BF C8          INY                    ;|
$93:80C0 B9 00 00    LDA $0000,y[$93:8677]  ;} Projectile instruction = [[$83F1 + projectile type * 2] + 2]
$93:80C3 9D 40 0C    STA $0C40,x[$7E:0C4A]  ;/
$93:80C6 A9 01 00    LDA #$0001             ;\
$93:80C9 9D 54 0C    STA $0C54,x[$7E:0C5E]  ;} Projectile instruction timer = 1
$93:80CC AB          PLB
$93:80CD 28          PLP
$93:80CE 6B          RTL
}


;;; $80CF: Part of kill projectile - queue sound effect and set instruction ;;;
{
; Called by $90:AE06 (kill projectile)
$93:80CF 08          PHP
$93:80D0 8B          PHB
$93:80D1 4B          PHK                    ;\
$93:80D2 AB          PLB                    ;} DB = $93
$93:80D3 C2 30       REP #$30
$93:80D5 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$93:80D8 89 00 0F    BIT #$0F00             ;} If beam: 
$93:80DB D0 1B       BNE $1B    [$80F8]     ;/
$93:80DD BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$93:80E0 29 FF F0    AND #$F0FF             ;|
$93:80E3 09 00 07    ORA #$0700             ;} Projectile type = beam explosion
$93:80E6 9D 18 0C    STA $0C18,x[$7E:0C18]  ;/
$93:80E9 AD 7B 86    LDA $867B  [$93:867B]  ;\
$93:80EC 9D 40 0C    STA $0C40,x[$7E:0C40]  ;} Projectile instruction pointer = $A007 (beam explosion)
$93:80EF A9 0C 00    LDA #$000C             ;\
$93:80F2 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound Ch, sound library 2, max queued sounds allowed = 6 (beam hit wall)
$93:80F6 80 47       BRA $47    [$813F]     ; Go to BRANCH_RETURN

$93:80F8 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$93:80FB D0 07       BNE $07    [$8104]     ;} If [$1F51] = 0:
$93:80FD A9 07 00    LDA #$0007             ;\
$93:8100 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 7, sound library 2, max queued sounds allowed = 6 (missile hit wall)

$93:8104 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$93:8107 48          PHA                    ;|
$93:8108 29 FF F0    AND #$F0FF             ;} Projectile type = (super) missile explosion
$93:810B 09 00 08    ORA #$0800             ;|
$93:810E 9D 18 0C    STA $0C18,x[$7E:0C18]  ;/
$93:8111 68          PLA                    ;\
$93:8112 89 00 02    BIT #$0200             ;} If not super missile:
$93:8115 D0 08       BNE $08    [$811F]     ;/
$93:8117 AD 7F 86    LDA $867F  [$93:867F]  ;\
$93:811A 9D 40 0C    STA $0C40,x[$7E:0C40]  ;} Projectile instruction pointer = $A039 (missile explosion)
$93:811D 80 12       BRA $12    [$8131]

$93:811F AD 93 86    LDA $8693  [$93:8693]  ;\ Else (super missile):
$93:8122 9D 40 0C    STA $0C40,x[$7E:0C40]  ;} Projectile instruction pointer = $A0C1 (super missile explosion)
$93:8125 A9 14 00    LDA #$0014             ;\
$93:8128 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1, BG2 and enemies; 1 pixel displacement, diagonal shaking
$93:812B A9 1E 00    LDA #$001E             ;\
$93:812E 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 30

$93:8131 AD CC 0C    LDA $0CCC  [$7E:0CCC]  ;\
$93:8134 C9 15 00    CMP #$0015             ;|
$93:8137 30 06       BMI $06    [$813F]     ;} Cooldown timer = min(20, [cooldown timer])
$93:8139 A9 14 00    LDA #$0014             ;|
$93:813C 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/

; BRANCH_RETURN
$93:813F A9 01 00    LDA #$0001             ;\
$93:8142 9D 54 0C    STA $0C54,x[$7E:0C54]  ;} Projectile instruction timer = 1
$93:8145 A9 08 00    LDA #$0008             ;\
$93:8148 9D 2C 0C    STA $0C2C,x[$7E:0C2C]  ;} Projectile damage = 8
$93:814B AB          PLB
$93:814C 28          PLP
$93:814D 6B          RTL
}


;;; $814E: Initialise bomb explosion ;;;
{
$93:814E 08          PHP
$93:814F 8B          PHB
$93:8150 4B          PHK                    ;\
$93:8151 AB          PLB                    ;} DB = $93
$93:8152 C2 30       REP #$30
$93:8154 AD 83 86    LDA $8683  [$93:8683]  ;\
$93:8157 9D 40 0C    STA $0C40,x[$7E:0C4A]  ;} Projectile instruction pointer = $A06B
$93:815A A9 01 00    LDA #$0001             ;\
$93:815D 9D 54 0C    STA $0C54,x[$7E:0C5E]  ;} Projectile instruction timer = 1
$93:8160 AB          PLB
$93:8161 28          PLP
$93:8162 6B          RTL
}


;;; $8163: Initialise shinespark echo or spazer SBA trail projectile ;;;
{
$93:8163 08          PHP
$93:8164 8B          PHB
$93:8165 4B          PHK                    ;\
$93:8166 AB          PLB                    ;} DB = $93
$93:8167 C2 30       REP #$30
$93:8169 BD 04 0C    LDA $0C04,x[$7E:0C0A]  ;\
$93:816C 29 0F 00    AND #$000F             ;|
$93:816F 0A          ASL A                  ;} $12 = (projectile direction) * 2
$93:8170 85 12       STA $12    [$7E:0012]  ;/
$93:8172 BD 18 0C    LDA $0C18,x[$7E:0C1E]  ;\
$93:8175 29 FF 00    AND #$00FF             ;|
$93:8178 38          SEC                    ;|
$93:8179 E9 22 00    SBC #$0022             ;|
$93:817C 0A          ASL A                  ;|
$93:817D A8          TAY                    ;} Projectile damage = [[$8403 + (([projectile type] & FFh) - 22h) * 2]]
$93:817E B9 03 84    LDA $8403,y[$93:8411]  ;|
$93:8181 A8          TAY                    ;|
$93:8182 B9 00 00    LDA $0000,y[$93:86C1]  ;|
$93:8185 9D 2C 0C    STA $0C2C,x[$7E:0C32]  ;/
$93:8188 10 04       BPL $04    [$818E]     ; If [projectile damage] < 0:
$93:818A 5C 73 85 80 JML $808573[$80:8573]  ; Crash

$93:818E C8          INY                    ;\
$93:818F C8          INY                    ;|
$93:8190 98          TYA                    ;|
$93:8191 18          CLC                    ;|
$93:8192 65 12       ADC $12    [$7E:0012]  ;} Projectile instruction pointer = [[$8403 + (([projectile type] & FFh) - 22h) * 2] + (projectile direction + 1) * 2 ]
$93:8194 A8          TAY                    ;|
$93:8195 B9 00 00    LDA $0000,y[$93:86C3]  ;|
$93:8198 9D 40 0C    STA $0C40,x[$7E:0C46]  ;/
$93:819B A9 01 00    LDA #$0001             ;\
$93:819E 9D 54 0C    STA $0C54,x[$7E:0C5A]  ;} Projectile instruction timer = 1
$93:81A1 AB          PLB
$93:81A2 28          PLP
$93:81A3 6B          RTL
}


;;; $81A4: Initialise SBA projectile ;;;
{
; Excluding ice SBA, which is run as a regular projectile
$93:81A4 08          PHP
$93:81A5 8B          PHB
$93:81A6 4B          PHK                    ;\
$93:81A7 AB          PLB                    ;} DB = $93
$93:81A8 C2 30       REP #$30
$93:81AA BD 18 0C    LDA $0C18,x[$7E:0C1E]  ;\
$93:81AD 29 0F 00    AND #$000F             ;|
$93:81B0 0A          ASL A                  ;|
$93:81B1 A8          TAY                    ;|
$93:81B2 B9 13 84    LDA $8413,y[$93:8423]  ;} Projectile damage = [[$8413 + (beam type) * 2]]
$93:81B5 A8          TAY                    ;|
$93:81B6 B9 00 00    LDA $0000,y[$93:8685]  ;|
$93:81B9 9D 2C 0C    STA $0C2C,x[$7E:0C32]  ;/
$93:81BC 10 04       BPL $04    [$81C2]     ; If [projectile damage] < 0:
$93:81BE 5C 73 85 80 JML $808573[$80:8573]  ; Crash

$93:81C2 B9 02 00    LDA $0002,y[$93:8687]  ;\
$93:81C5 9D 40 0C    STA $0C40,x[$7E:0C46]  ;} Projectile instruction = [[$8413 + (beam type) * 2] + 2]
$93:81C8 A9 01 00    LDA #$0001             ;\
$93:81CB 9D 54 0C    STA $0C54,x[$7E:0C5A]  ;} Projectile instruction timer = 1
$93:81CE AB          PLB
$93:81CF 28          PLP
$93:81D0 6B          RTL
}


;;; $81D1: $16 = projectile trail frame ;;;
{
$93:81D1 08          PHP
$93:81D2 8B          PHB
$93:81D3 4B          PHK                    ;\
$93:81D4 AB          PLB                    ;} DB = $93
$93:81D5 C2 30       REP #$30
$93:81D7 5A          PHY
$93:81D8 BD 40 0C    LDA $0C40,x[$7E:0C40]  ;\
$93:81DB 38          SEC                    ;|
$93:81DC E9 08 00    SBC #$0008             ;|
$93:81DF A8          TAY                    ;} $16 = [[projectile instruction pointer] - 2]
$93:81E0 B9 06 00    LDA $0006,y[$93:9F09]  ;|
$93:81E3 85 16       STA $16    [$7E:0016]  ;/
$93:81E5 7A          PLY
$93:81E6 AB          PLB
$93:81E7 28          PLP
$93:81E8 6B          RTL
}


;;; $81E9: Projectile instruction handler ;;;
{
; Called by $90:AECE (handle projectiles)
$93:81E9 08          PHP
$93:81EA 8B          PHB
$93:81EB 4B          PHK                    ;\
$93:81EC AB          PLB                    ;} DB = $93
$93:81ED C2 30       REP #$30
$93:81EF AE DE 0D    LDX $0DDE  [$7E:0DDE]  ; X = [projectile index]
$93:81F2 DE 54 0C    DEC $0C54,x[$7E:0C54]  ; Decrement projectile instruction timer
$93:81F5 D0 35       BNE $35    [$822C]     ; If [projectile instruction timer] != 0: return
$93:81F7 BC 40 0C    LDY $0C40,x[$7E:0C40]  ; Y = projectile instruction

; LOOP
$93:81FA B9 00 00    LDA $0000,y[$93:9F03]  ;\
$93:81FD 10 0A       BPL $0A    [$8209]     ;} If [[Y]] & 8000h:
$93:81FF 85 12       STA $12    [$7E:0012]  ;\
$93:8201 C8          INY                    ;|
$93:8202 C8          INY                    ;} Execute [[Y]], Y += 2, go to LOOP
$93:8203 F4 F9 81    PEA $81F9              ;|
$93:8206 6C 12 00    JMP ($0012)[$93:8239]  ;/

;                                            Else (positive):
$93:8209 9D 54 0C    STA $0C54,x[$7E:0C54]  ; Projectile instruction timer = [[Y]]
$93:820C B9 02 00    LDA $0002,y[$93:9F05]  ;\
$93:820F 9D B8 0C    STA $0CB8,x[$7E:0CB8]  ;} Projectile spritemap pointer = [[Y] + 2]
$93:8212 B9 04 00    LDA $0004,y[$93:9F07]  ;\
$93:8215 29 FF 00    AND #$00FF             ;} Projectile X radius = [[Y] + 4]
$93:8218 9D B4 0B    STA $0BB4,x[$7E:0BB4]  ;/
$93:821B B9 05 00    LDA $0005,y[$93:9F08]  ;\
$93:821E 29 FF 00    AND #$00FF             ;} Projectile Y radius = [[Y] + 5]
$93:8221 9D C8 0B    STA $0BC8,x[$7E:0BC8]  ;/
$93:8224 98          TYA                    ;\
$93:8225 18          CLC                    ;|
$93:8226 69 08 00    ADC #$0008             ;} Projectile instruction = [Y] + 8
$93:8229 9D 40 0C    STA $0C40,x[$7E:0C40]  ;/

$93:822C AB          PLB
$93:822D 28          PLP
$93:822E 6B          RTL
}


;;; $822F: Instruction - delete ;;;
{
$93:822F C2 30       REP #$30
$93:8231 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$93:8235 68          PLA                    ; Terminate projectile handling
$93:8236 AB          PLB
$93:8237 28          PLP
$93:8238 6B          RTL
}


;;; $8239: Instruction - go to [[Y]] ;;;
{
$93:8239 C2 30       REP #$30
$93:823B B9 00 00    LDA $0000,y[$93:9F0D]
$93:823E A8          TAY
$93:823F 60          RTS
}


;;; $8240: Unused. Instruction - go to [[Y] + 2] if [bomb timer] <= [[Y]] else go to [[Y] + 4] ;;;
{
$93:8240 C2 30       REP #$30
$93:8242 B9 00 00    LDA $0000,y
$93:8245 DD 7C 0C    CMP $0C7C,x
$93:8248 10 05       BPL $05    [$824F]
$93:824A B9 04 00    LDA $0004,y
$93:824D A8          TAY
$93:824E 60          RTS

$93:824F B9 02 00    LDA $0002,y
$93:8252 A8          TAY
$93:8253 60          RTS
}


;;; $8254: Draw projectiles ;;;
{
$93:8254 08          PHP
$93:8255 C2 30       REP #$30
$93:8257 A2 08 00    LDX #$0008             ;\
$93:825A 8E DE 0D    STX $0DDE  [$7E:0DDE]  ;} Projectile index = 8
                                            
; LOOP                                      
$93:825D BD 40 0C    LDA $0C40,x[$7E:0C48]  ;\
$93:8260 D0 03       BNE $03    [$8265]     ;} If [projectile instruction pointer] = 0:
$93:8262 4C E9 82    JMP $82E9  [$93:82E9]  ; Go to BRANCH_NEXT

$93:8265 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$93:8268 89 10 0F    BIT #$0F10             ;} If projectile is not uncharged beam: go to BRANCH_NO_FLICKER
$93:826B D0 39       BNE $39    [$82A6]     ;/
$93:826D 89 0C 00    BIT #$000C             ;\
$93:8270 D0 1A       BNE $1A    [$828C]     ;} If beam is spazer or plasma: go to BRANCH_SPAZER_PLASMA
$93:8272 8A          TXA                    ;\
$93:8273 89 02 00    BIT #$0002             ;} If [projectile index] & 2 = 0:
$93:8276 D0 0A       BNE $0A    [$8282]     ;/
$93:8278 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$93:827B 89 01 00    BIT #$0001             ;} If [frame counter] % 2 != 0: go to BRANCH_DRAW
$93:827E D0 2E       BNE $2E    [$82AE]     ;/
$93:8280 80 67       BRA $67    [$82E9]     ; Go to BRANCH_NEXT

$93:8282 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$93:8285 89 01 00    BIT #$0001             ;} If [frame counter] % 2 != 0: go to BRANCH_NEXT
$93:8288 D0 5F       BNE $5F    [$82E9]     ;/
$93:828A 80 22       BRA $22    [$82AE]     ; Go to BRANCH_DRAW

; BRANCH_SPAZER_PLASMA
$93:828C 8A          TXA                    ;\
$93:828D 89 02 00    BIT #$0002             ;} If [projectile index] & 2 = 0:
$93:8290 D0 0A       BNE $0A    [$829C]     ;/
$93:8292 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$93:8295 89 02 00    BIT #$0002             ;} If [frame counter] & 2 != 0: go to BRANCH_NEXT
$93:8298 D0 4F       BNE $4F    [$82E9]     ;/
$93:829A 80 12       BRA $12    [$82AE]     ; Go to BRANCH_DRAW

$93:829C AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$93:829F 89 02 00    BIT #$0002             ;} If [frame counter] & 2 = 0: go to BRANCH_NEXT
$93:82A2 F0 45       BEQ $45    [$82E9]     ;/
$93:82A4 80 08       BRA $08    [$82AE]     ; Go to BRANCH_DRAW

; BRANCH_NO_FLICKER
$93:82A6 29 00 0F    AND #$0F00             ;\
$93:82A9 C9 00 03    CMP #$0300             ;} If projectile is (power) bomb: go to BRANCH_NEXT
$93:82AC 10 3B       BPL $3B    [$82E9]     ;/

; BRANCH_DRAW
$93:82AE AD 3F 09    LDA $093F  [$7E:093F]  ;\
$93:82B1 10 08       BPL $08    [$82BB]     ;} If Ceres elevator room is rotating:
$93:82B3 22 D9 8A 8B JSL $8B8AD9[$8B:8AD9]  ; Calculate position of projectile explosion in rotating elevator room
$93:82B7 A5 12       LDA $12    [$7E:0012]
$93:82B9 80 12       BRA $12    [$82CD]     ; Go to BRANCH_POSITION_CALCULATED

$93:82BB BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$93:82BE 38          SEC                    ;|
$93:82BF ED 11 09    SBC $0911  [$7E:0911]  ;} $14 = [projectile X position] - [layer 1 X position]
$93:82C2 85 14       STA $14    [$7E:0014]  ;/
$93:82C4 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$93:82C7 38          SEC                    ;|
$93:82C8 ED 15 09    SBC $0915  [$7E:0915]  ;} $12 = [projectile Y position] - [layer 1 Y position]
$93:82CB 85 12       STA $12    [$7E:0012]  ;/

; BRANCH_POSITION_CALCULATED
$93:82CD 29 00 FF    AND #$FF00             ;\
$93:82D0 D0 0B       BNE $0B    [$82DD]     ;} If 0 <= [$12] < 100h:
$93:82D2 BD B8 0C    LDA $0CB8,x[$7E:0CB8]  ;\
$93:82D5 10 0F       BPL $0F    [$82E6]     ;} If [projectile spritemap pointer] & 8000h != 0:
$93:82D7 22 4B 8A 81 JSL $818A4B[$81:8A4B]  ; Add projectile spritemap to OAM
$93:82DB 80 09       BRA $09    [$82E6]     
                                            
$93:82DD BD B8 0C    LDA $0CB8,x[$7E:0CBA]  ;\ Else (not 0 <= [$14] < 100h):
$93:82E0 10 04       BPL $04    [$82E6]     ;} If [projectile spritemap pointer] & 8000h != 0:
$93:82E2 22 B7 8A 81 JSL $818AB7[$81:8AB7]  ; RTL

$93:82E6 AE DE 0D    LDX $0DDE  [$7E:0DDE]

; BRANCH_NEXT
$93:82E9 CA          DEX                    ;\
$93:82EA CA          DEX                    ;} Projectile index -= 2
$93:82EB 8E DE 0D    STX $0DDE  [$7E:0DDE]  ;/
$93:82EE 30 03       BMI $03    [$82F3]     ; If [projectile index] >= 0:
$93:82F0 4C 5D 82    JMP $825D  [$93:825D]  ; Go to LOOP
                                            
$93:82F3 22 53 89 90 JSL $908953[$90:8953]  ; Draw shinespark crash echoes
$93:82F7 22 A9 B6 90 JSL $90B6A9[$90:B6A9]  ; Draw projectile trail
$93:82FB 28          PLP
$93:82FC 6B          RTL
}


;;; $82FD: Unused. Partial draw projectiles ;;;
{
; Compared to $8254, this routine doesn't handle flickering,
; doesn't drawn shinespark crash echoes, and doesn't handle Ceres elevator room rotation.
; It also randomly subtracts 8 from the projectile's Y position.
$93:82FD 08          PHP
$93:82FE C2 30       REP #$30
$93:8300 A2 08 00    LDX #$0008             ;\
$93:8303 8E DE 0D    STX $0DDE  [$7E:0DDE]  ;} Projectile index = 8

; LOOP
$93:8306 BD 40 0C    LDA $0C40,x            ;\
$93:8309 F0 32       BEQ $32    [$833D]     ;} If [projectile instruction pointer] = 0: go to BRANCH_NEXT
$93:830B BD 64 0B    LDA $0B64,x            ;\
$93:830E 38          SEC                    ;|
$93:830F ED 11 09    SBC $0911  [$7E:0911]  ;} $14 = [projectile X position] - [layer 1 X position]
$93:8312 85 14       STA $14    [$7E:0014]  ;/
$93:8314 BD 78 0B    LDA $0B78,x            ;\
$93:8317 38          SEC                    ;|
$93:8318 E9 08 00    SBC #$0008             ;|
$93:831B 38          SEC                    ;} $14 = [projectile Y position] - 8 - [layer 1 X position]
$93:831C ED 15 09    SBC $0915  [$7E:0915]  ;|
$93:831F 85 12       STA $12    [$7E:0012]  ;/
$93:8321 29 00 FF    AND #$FF00             ;\
$93:8324 D0 0B       BNE $0B    [$8331]     ;} If 0 <= [$14] < 100h:
$93:8326 BD B8 0C    LDA $0CB8,x            ;\
$93:8329 10 0F       BPL $0F    [$833A]     ;} If [projectile spritemap pointer] & 8000h != 0:
$93:832B 22 4B 8A 81 JSL $818A4B[$81:8A4B]  ; Add projectile spritemap to OAM
$93:832F 80 09       BRA $09    [$833A]

$93:8331 BD B8 0C    LDA $0CB8,x            ;\ Else (not 0 <= [$14] < 100h):
$93:8334 10 04       BPL $04    [$833A]     ;} If [projectile spritemap pointer] & 8000h != 0:
$93:8336 22 B7 8A 81 JSL $818AB7[$81:8AB7]  ; RTL

$93:833A AE DE 0D    LDX $0DDE  [$7E:0DDE]

; BRANCH_NEXT
$93:833D CA          DEX                    ;\
$93:833E CA          DEX                    ;} Projectile index -= 2
$93:833F 8E DE 0D    STX $0DDE  [$7E:0DDE]  ;/
$93:8342 30 03       BMI $03    [$8347]     ; If [projectile index] >= 0:
$93:8344 4C 06 83    JMP $8306  [$93:8306]  ; Go to LOOP

$93:8347 22 A9 B6 90 JSL $90B6A9[$90:B6A9]  ; Draw projectile trail
$93:834B 28          PLP
$93:834C 6B          RTL
}


;;; $834D: Draw bombs and projectile explosions ;;;
{
$93:834D 08          PHP
$93:834E C2 30       REP #$30
$93:8350 A2 12 00    LDX #$0012             ;\
$93:8353 8E DE 0D    STX $0DDE  [$7E:0DDE]  ;} Projectile index = 12h

; LOOP
$93:8356 BD 40 0C    LDA $0C40,x[$7E:0C52]  ;\
$93:8359 F0 5B       BEQ $5B    [$83B6]     ;} If [projectile instruction] = 0: go to BRANCH_NEXT
$93:835B BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$93:835E 29 00 0F    AND #$0F00             ;|
$93:8361 C9 00 03    CMP #$0300             ;} If projectile is beam or (super) missile: go to BRANCH_NEXT
$93:8364 30 50       BMI $50    [$83B6]     ;/
$93:8366 F0 12       BEQ $12    [$837A]     ; If projectile is not a power bomb:
$93:8368 C9 00 05    CMP #$0500             ;\
$93:836B F0 12       BEQ $12    [$837F]     ;} If projectile is a bomb: go to BRANCH_NORMAL_POSITION_CALCULATION
$93:836D AD 3F 09    LDA $093F  [$7E:093F]  ;\
$93:8370 10 0D       BPL $0D    [$837F]     ;} If [Ceres status] != elevator room rotates: go to BRANCH_NORMAL_POSITION_CALCULATION
$93:8372 22 D9 8A 8B JSL $8B8AD9[$8B:8AD9]  ; Calculate position of projectile explosion in rotating elevator room
$93:8376 A5 12       LDA $12    [$7E:0012]  ; A = [$12]
$93:8378 80 21       BRA $21    [$839B]     ; Go to BRANCH_CALCULATED_POSITION

$93:837A BD 7C 0C    LDA $0C7C,x[$7E:0C86]  ;\
$93:837D F0 37       BEQ $37    [$83B6]     ;} If [bomb timer] = 0: go to BRANCH_NEXT

; BRANCH_NORMAL_POSITION_CALCULATION
$93:837F BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$93:8382 38          SEC                    ;|
$93:8383 ED 11 09    SBC $0911  [$7E:0911]  ;} Spritemap X position = [projectile X position] - [layer 1 X position]
$93:8386 85 14       STA $14    [$7E:0014]  ;/
$93:8388 C9 30 01    CMP #$0130             ;\
$93:838B 10 29       BPL $29    [$83B6]     ;} If projectile at least three blocks off right of screen: go to BRANCH_NEXT
$93:838D C9 D0 FF    CMP #$FFD0             ;\
$93:8390 30 24       BMI $24    [$83B6]     ;} If projectile over three blocks off left of screen: go to BRANCH_NEXT
$93:8392 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$93:8395 38          SEC                    ;|
$93:8396 ED 15 09    SBC $0915  [$7E:0915]  ;} Spritemap Y position = [projectile Y position] - [layer 1 Y position]
$93:8399 85 12       STA $12    [$7E:0012]  ;/

; BRANCH_CALCULATED_POSITION
$93:839B 29 00 FF    AND #$FF00             ;\
$93:839E D0 0C       BNE $0C    [$83AC]     ;} If on screen:
$93:83A0 BD B8 0C    LDA $0CB8,x[$7E:0CB8]  ; Spritemap address = [projectile spritemap pointer]
$93:83A3 22 4B 8A 81 JSL $818A4B[$81:8A4B]  ; Add spritemap to OAM
$93:83A7 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ; X = [projectile index]
$93:83AA 80 0A       BRA $0A    [$83B6]     ; Go to BRANCH_NEXT

$93:83AC BD B8 0C    LDA $0CB8,x[$7E:0CBA]  ; A = [projectile spritemap pointer]
$93:83AF 22 B7 8A 81 JSL $818AB7[$81:8AB7]  ; RTL
$93:83B3 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ; X = [projectile index]

; BRANCH_NEXT
$93:83B6 CA          DEX                    ;\
$93:83B7 CA          DEX                    ;} X -= 2
$93:83B8 8E DE 0D    STX $0DDE  [$7E:0DDE]  ; Projectile index = [X]
$93:83BB 10 99       BPL $99    [$8356]     ; If [projectile index] >= 0: go to LOOP
$93:83BD 28          PLP
$93:83BE 6B          RTL
}


;;; $83BF: Hyper beam damage value ;;;
{
$93:83BF             dw 03E8
}


;;; $83C1: Projectile data pointers ;;;
{
; Uncharged beams. Indexed by beam type
$93:83C1             dw 8431, 84B5, 849F, 84E1, 8447, 84F7, 845D, 8473, 84CB, 850D, 8523, 8489

; Charged beams. Indexed by beam type
$93:83D9             dw 8539, 85D3, 85A7, 85E9, 854F, 85FF, 8565, 857B, 85BD, 862B, 8615, 8591

; Non-beam projectiles. Indexed by projectile type
$93:83F1             dw 8641, 8641, 8657, 8671, 8641, 8675, 8641, 8679, 867D

; Shinespark echo and spazer SBA trail projectile. Indexed by projectile type - 22h
$93:8403             dw 0000, 0000, 86AB, 8695, 86AB, 86D7, 0000, 86C1

; SBA projectiles. Indexed by beam type
$93:8413             dw 0000, 8689, 0000, 0000, 868D, 868D, 0000, 0000, 8685, 8685, 0000, 0000

; Super missile link. Indexed by projectile type (always 2)
$93:842B             dw 0000, 0000, 866D
}


;;; $8431: Projectile data table ;;;
{
;                        ___________________________________________________ Damage
;                       |     ______________________________________________ Up, facing right
;                       |    |     _________________________________________ Up-right
;                       |    |    |     ____________________________________ Right
;                       |    |    |    |     _______________________________ Down-right
;                       |    |    |    |    |     __________________________ Down, facing right
;                       |    |    |    |    |    |     _____________________ Down, facing left
;                       |    |    |    |    |    |    |     ________________ Down-left
;                       |    |    |    |    |    |    |    |     ___________ Left
;                       |    |    |    |    |    |    |    |    |     ______ Up-left
;                       |    |    |    |    |    |    |    |    |    |     _ Up, facing left
;                       |    |    |    |    |    |    |    |    |    |    |
; Uncharged beams
$93:8431             dw 0014,86DB,86E7,86F3,86FF,870B,870B,8717,8723,872F,86DB ; Power
$93:8447             dw 0028,8977,8993,89AF,89CB,89E7,89E7,8A03,8A1F,8A3B,8977 ; Spazer
$93:845D             dw 003C,8977,8993,89AF,89CB,89E7,89E7,8A03,8A1F,8A3B,8977 ; Spazer + ice
$93:8473             dw 0064,8A57,8AAB,8AFF,8B53,8BA7,8BA7,8BFB,8C4F,8CA3,8A57 ; Spazer + ice + wave
$93:8489             dw 012C,8D47,8D93,8DDF,8E2B,8D47,8D47,8D93,8DDF,8E2B,8D47 ; Plasma + ice + wave
$93:849F             dw 001E,8953,8953,8953,8953,8953,8953,8953,8953,8953,8953 ; Ice
$93:84B5             dw 0032,873B,87C7,884B,88CF,8743,8743,87C7,884B,88CF,873B ; Wave
$93:84CB             dw 0096,8CF7,8D0B,8D1F,8D33,8CF7,8CF7,8D0B,8D1F,8D33,8CF7 ; Plasma
$93:84E1             dw 003C,873B,87C7,884B,88CF,8743,8743,87C7,884B,88CF,873B ; Ice + wave
$93:84F7             dw 0046,8A57,8AAB,8AFF,8B53,8BA7,8BA7,8BFB,8C4F,8CA3,8A57 ; Spazer + wave
$93:850D             dw 00FA,8D4F,8D9B,8DDF,8E33,8D4F,8D4F,8D9B,8DDF,8E33,8D4F ; Plasma + wave
$93:8523             dw 00C8,8CF7,8D0B,8D1F,8D33,8CF7,8CF7,8D0B,8D1F,8D33,8CF7 ; Plasma + ice

; Charged beams
$93:8539             dw 003C,8E77,8E8B,8E9F,8EB3,8EC7,8EC7,8EDB,8EEF,8F03,8E77 ; Power
$93:854F             dw 0078,936B,93BF,9413,9467,936B,936B,93BF,9413,9467,936B ; Spazer
$93:8565             dw 00B4,936B,93BF,9413,9467,936B,936B,93BF,9413,9467,936B ; Spazer + ice
$93:857B             dw 012C,94BB,957F,9643,9707,97CB,97CB,988F,9953,9A17,94BB ; Spazer + ice + wave
$93:8591             dw 0384,9BEB,9C9F,9D53,9E07,9BEB,9BEB,9C9F,9D53,9E07,9BEB ; Plasma + ice + wave
$93:85A7             dw 005A,912F,912F,912F,912F,912F,912F,912F,912F,912F,912F ; Ice
$93:85BD             dw 01C2,9ADB,9B1F,9B63,9BA7,9ADB,9ADB,9B1F,9B63,9BA7,9ADB ; Plasma
$93:85D3             dw 0096,8F17,8FA3,9027,90AB,8F1F,8F1F,8FA3,9027,90AB,8F17 ; Wave
$93:85E9             dw 00B4,9153,91DF,9263,92E7,915B,915B,91DF,9263,92E7,9153 ; Ice + wave
$93:85FF             dw 00D2,94BB,957F,9643,9707,97CB,97CB,988F,9953,9A17,94BB ; Spazer + wave
$93:8615             dw 0258,9ADB,9B1F,9B63,9BA7,9ADB,9ADB,9B1F,9B63,9BA7,9ADB ; Plasma + ice
$93:862B             dw 02EE,9BEB,9C9F,9D53,9E07,9BEB,9BEB,9C9F,9D53,9E07,9BEB ; Plasma + wave

; Non-beam projectiles
$93:8641             dw 0064,9EBB,9EC7,9ED3,9EDF,9EEB,9EEB,9EF7,9F03,9F0F,9EBB ; Missile
$93:8657             dw 012C,9F1B,9F27,9F33,9F3F,9F4B,9F4B,9F57,9F63,9F6F,9F1B ; Super missile
$93:866D             dw 012C,9F7B ; Super missile link
$93:8671             dw 00C8,9F87 ; Power bomb
$93:8675             dw 001E,9FBF ; Bomb
$93:8679             dw 0008,A007 ; Beam explosion
$93:867D             dw 0008,A039 ; (Super) missile explosion
$93:8681             dw 0000,A06B ; Unused. Bomb explosion
$93:8685             dw 012C,A095 ; Plasma SBA
$93:8689             dw 012C,A159 ; Wave SBA
$93:868D             dw 012C,8977 ; Spazer SBA
$93:8691             dw 0008,A0C1 ; Unused. Super missile explosion
$93:8695             dw F000,A0F3,A0F3,A0F3,A0F3,A0F3,A0F3,A0F3,A0F3,A0F3,A0F3 ; Unused projectile 25h
$93:86AB             dw 012C,A13D,A13D,A13D,A13D,A13D,A13D,A13D,A13D,A13D,A13D ; Spazer SBA trail
$93:86C1             dw 1000,A119,A119,A119,A119,A119,A119,A119,A119,A119,A119 ; Shinespark echo
$93:86D7             dw 0000,A16D ; Unused projectile 27h (unused shinespark beam?)
}


;;; $86DB..A1A0: Instruction lists ;;;
{
;;; $86DB: Instruction list - power - up ;;;
{
$93:86DB             dx 000F,A25B,04,04,0000,
                        8239,86DB             ; Go to $86DB
}


;;; $86E7: Instruction list - power - up-right ;;;
{
$93:86E7             dx 000F,A262,08,04,0000,
                        8239,86E7             ; Go to $86E7
}


;;; $86F3: Instruction list - power - right ;;;
{
$93:86F3             dx 000F,A269,08,04,0000,
                        8239,86F3             ; Go to $86F3
}


;;; $86FF: Instruction list - power - down-right ;;;
{
$93:86FF             dx 000F,A270,08,04,0000,
                        8239,86FF             ; Go to $86FF
}


;;; $870B: Instruction list - power - down ;;;
{
$93:870B             dx 000F,A277,04,04,0000,
                        8239,870B             ; Go to $870B
}


;;; $8717: Instruction list - power - down-left ;;;
{
$93:8717             dx 000F,A27E,08,04,0000,
                        8239,8717             ; Go to $8717
}


;;; $8723: Instruction list - power - left ;;;
{
$93:8723             dx 000F,A24D,08,04,0000,
                        8239,8723             ; Go to $8723
}


;;; $872F: Instruction list - power - up-left ;;;
{
$93:872F             dx 000F,A254,08,04,0000,
                        8239,872F             ; Go to $872F
}


;;; $873B: Instruction list - wave / ice + wave - up ;;;
{
$93:873B             dx 0004,A117,0C,04,0000
}


;;; $8743: Instruction list - wave / ice + wave - down ;;;
{
$93:8743             dx 0001,AE65,0C,04,0000,
                        0001,AEDC,0C,04,0001,
                        0001,AEE3,0C,04,0002,
                        0001,AEEA,10,04,0003,
                        0001,AEF1,14,04,0004,
                        0001,AEEA,10,04,0005,
                        0001,AEE3,0C,04,0006,
                        0001,AEDC,0C,04,0007,
                        0001,AE65,0C,04,0008,
                        0001,AEF8,0C,04,0009,
                        0001,AEFF,0C,04,000A,
                        0001,AF06,10,04,000B,
                        0001,AF0D,14,04,000C,
                        0001,AF06,10,04,000D,
                        0001,AEFF,0C,04,000E,
                        0001,AEF8,0C,04,000F,
                        8239,8743             ; Go to $8743
}


;;; $87C7: Instruction list - wave / ice + wave - down-left / up-right ;;;
{
$93:87C7             dx 0001,AE65,08,08,0000,
                        0001,AF14,08,08,0001,
                        0001,AF1B,08,08,0002,
                        0001,AF22,0A,0A,0003,
                        0001,AF29,0C,0C,0004,
                        0001,AF22,0A,0A,0005,
                        0001,AF1B,08,08,0006,
                        0001,AF14,06,06,0007,
                        0001,AE65,04,04,0008,
                        0001,AF30,06,06,0009,
                        0001,AF37,08,08,000A,
                        0001,AF3E,0A,0A,000B,
                        0001,AF45,0C,0C,000C,
                        0001,AF3E,0A,0A,000D,
                        0001,AF37,08,08,000E,
                        0001,AF30,08,08,000F,
                        8239,87C7             ; Go to $87C7
}


;;; $884B: Instruction list - wave / ice + wave - left / right ;;;
{
$93:884B             dx 0001,AE65,04,0C,0000,
                        0001,AE6C,04,0C,0001,
                        0001,AE73,04,0C,0002,
                        0001,AE7A,04,10,0003,
                        0001,AE81,04,14,0004,
                        0001,AE7A,04,10,0005,
                        0001,AE73,04,0C,0006,
                        0001,AE6C,04,0C,0007,
                        0001,AE65,04,0C,0008,
                        0001,AE88,04,0C,0009,
                        0001,AE8F,04,0C,000A,
                        0001,AE96,04,10,000B,
                        0001,AE9D,04,14,000C,
                        0001,AE96,04,10,000D,
                        0001,AE8F,04,0C,000E,
                        0001,AE88,04,0C,000F,
                        8239,884B             ; Go to $884B
}


;;; $88CF: Instruction list - wave / ice + wave - down-right / up-left ;;;
{
$93:88CF             dx 0001,AE65,08,08,0000,
                        0001,AEA4,08,08,0001,
                        0001,AEAB,08,08,0002,
                        0001,AEB2,0A,0A,0003,
                        0001,AEB9,0C,0C,0004,
                        0001,AEB2,0A,0A,0005,
                        0001,AEAB,08,08,0006,
                        0001,AEA4,06,06,0007,
                        0001,AE65,04,04,0008,
                        0001,AEC0,06,06,0009,
                        0001,AEC7,08,08,000A,
                        0001,AECE,0A,0A,000B,
                        0001,AED5,0C,0C,000C,
                        0001,AECE,0A,0A,000D,
                        0001,AEC7,08,08,000E,
                        0001,AEC0,08,08,000F,
                        8239,88CF             ; Go to $88CF
}


;;; $8953: Instruction list - ice ;;;
{
$93:8953             dx 0001,EDF6,08,08,0000,
                        0001,EDFD,08,08,0001,
                        0001,EE04,08,08,0002,
                        0001,EE0B,08,08,0003,
                        8239,8953             ; Go to $8953
}


;;; $8977: Instruction list - spazer / spazer + ice - up ;;;
{
$93:8977             dx 0002,D796,0C,08,0000,
                        0002,D7C2,0C,08,0001,
$93:8987             dx 0002,D822,14,08,0002,
                        8239,8987             ; Go to $8987
}


;;; $8993: Instruction list - spazer / spazer + ice - up-right ;;;
{
$93:8993             dx 0002,D10E,08,08,0000,
                        0002,D124,0C,0C,0001,
$93:89A3             dx 0002,D1DE,10,10,0002,
                        8239,89A3             ; Go to $89A3
}


;;; $89AF: Instruction list - spazer / spazer + ice - right ;;;
{
$93:89AF             dx 0002,D842,08,0C,0000,
                        0002,D86E,08,0C,0001,
$93:89BF             dx 0002,D8CE,08,14,0002,
                        8239,89BF             ; Go to $89BF
}


;;; $89CB: Instruction list - spazer / spazer + ice - down-right ;;;
{
$93:89CB             dx 0002,D25A,08,08,0000,
                        0002,D270,0C,0C,0001,
$93:89DB             dx 0002,D32A,10,10,0002,
                        8239,89DB             ; Go to $89DB
}


;;; $89E7: Instruction list - spazer / spazer + ice - down ;;;
{
$93:89E7             dx 0002,D63E,0C,08,0000,
                        0002,D66A,0C,08,0001,
$93:89F7             dx 0002,D6CA,14,08,0002,
                        8239,89F7             ; Go to $89F7
}


;;; $8A03: Instruction list - spazer / spazer + ice - down-left ;;;
{
$93:8A03             dx 0002,D3A6,08,08,0000,
                        0002,D3BC,0C,0C,0001,
$93:8A13             dx 0002,D476,10,10,0002,
                        8239,8A13             ; Go to $8A13
}


;;; $8A1F: Instruction list - spazer / spazer + ice - left ;;;
{
$93:8A1F             dx 0002,D6EA,08,0C,0000,
                        0002,D716,08,0C,0001,
$93:8A2F             dx 0002,D776,08,14,0002,
                        8239,8A2F             ; Go to $8A2F
}


;;; $8A3B: Instruction list - spazer / spazer + ice - up-left ;;;
{
$93:8A3B             dx 0002,D4F2,08,08,0000,
                        0002,D508,0C,0C,0001,
$93:8A4B             dx 0002,D5C2,10,10,0002,
                        8239,8A4B             ; Go to $8A4B
}


;;; $8A57: Instruction list - spazer + wave / spazer + ice + wave - up ;;;
{
$93:8A57             dx 0002,D796,0C,08,0000,
                        0002,D7A2,0C,08,0001,
                        0002,D7C2,0C,08,0002,
                        0002,D7E2,11,08,0003,
                        0002,D802,13,08,0004,
                        0002,D822,14,08,0005,
                        0002,D802,13,08,0006,
                        0002,D7E2,11,08,0007,
                        0002,D7C2,0C,08,0008,
                        0002,D7A2,0C,08,0009,
                        8239,8A57             ; Go to $8A57
}


;;; $8AAB: Instruction list - spazer + wave / spazer + ice + wave - up-right ;;;
{
$93:8AAB             dx 0002,D10E,08,08,0000,
                        0002,D21C,08,08,0001,
                        0002,D124,0C,0C,0002,
                        0002,D162,10,10,0003,
                        0002,D1A0,10,10,0004,
                        0002,D1DE,10,10,0005,
                        0002,D1A0,10,10,0006,
                        0002,D162,10,10,0007,
                        0002,D124,0C,0C,0008,
                        0002,D21C,08,08,0009,
                        8239,8AAB             ; Go to $8AAB
}


;;; $8AFF: Instruction list - spazer + wave / spazer + ice + wave - right ;;;
{
$93:8AFF             dx 0002,D842,08,0C,0000,
                        0002,D84E,08,0C,0001,
                        0002,D86E,08,0C,0002,
                        0002,D88E,08,11,0003,
                        0002,D8AE,08,13,0004,
                        0002,D8CE,08,14,0005,
                        0002,D8AE,08,13,0006,
                        0002,D88E,08,11,0007,
                        0002,D86E,08,0C,0008,
                        0002,D84E,08,0C,0009,
                        8239,8AFF             ; Go to $8AFF
}


;;; $8B53: Instruction list - spazer + wave / spazer + ice + wave - down-right ;;;
{
$93:8B53             dx 0002,D25A,08,08,0000,
                        0002,D368,08,08,0001,
                        0002,D270,0C,0C,0002,
                        0002,D2AE,10,10,0003,
                        0002,D2EC,10,10,0004,
                        0002,D32A,10,10,0005,
                        0002,D2EC,10,10,0006,
                        0002,D2AE,10,10,0007,
                        0002,D270,0C,0C,0008,
                        0002,D368,08,08,0009,
                        8239,8B53             ; Go to $8B53
}


;;; $8BA7: Instruction list - spazer + wave / spazer + ice + wave - down ;;;
{
$93:8BA7             dx 0002,D63E,0C,08,0000,
                        0002,D64A,0C,08,0001,
                        0002,D66A,0C,08,0002,
                        0002,D68A,11,08,0003,
                        0002,D6AA,13,08,0004,
                        0002,D6CA,14,08,0005,
                        0002,D6AA,13,08,0006,
                        0002,D68A,11,08,0007,
                        0002,D66A,0C,08,0008,
                        0002,D64A,0C,08,0009,
                        8239,8BA7             ; Go to $8BA7
}


;;; $8BFB: Instruction list - spazer + wave / spazer + ice + wave - down-left ;;;
{
$93:8BFB             dx 0002,D3A6,08,08,0000,
                        0002,D3BC,08,08,0001,
                        0002,D3FA,0C,0C,0002,
                        0002,D438,10,10,0003,
                        0002,D476,10,10,0004,
                        0002,D476,10,10,0005,
                        0002,D476,10,10,0006,
                        0002,D438,10,10,0007,
                        0002,D3FA,0C,0C,0008,
                        0002,D3BC,08,08,0009,
                        8239,8BFB             ; Go to $8BFB
}


;;; $8C4F: Instruction list - spazer + wave / spazer + ice + wave - left ;;;
{
$93:8C4F             dx 0002,D6EA,08,0C,0000,
                        0002,D6F6,08,0C,0001,
                        0002,D716,08,0C,0002,
                        0002,D736,08,11,0003,
                        0002,D756,08,13,0004,
                        0002,D776,08,14,0005,
                        0002,D756,08,13,0006,
                        0002,D736,08,11,0007,
                        0002,D716,08,0C,0008,
                        0002,D6F6,08,0C,0009,
                        8239,8C4F             ; Go to $8C4F
}


;;; $8CA3: Instruction list - spazer + wave / spazer + ice + wave - up-left ;;;
{
$93:8CA3             dx 0002,D4F2,08,08,0000,
                        0002,D600,08,08,0001,
                        0002,D508,0C,0C,0002,
                        0002,D546,10,10,0003,
                        0002,D584,10,10,0004,
                        0002,D5C2,10,10,0005,
                        0002,D584,10,10,0006,
                        0002,D546,10,10,0007,
                        0002,D508,0C,0C,0008,
                        0002,D600,08,08,0009,
                        8239,8CA3             ; Go to $8CA3
}


;;; $8CF7: Instruction list - plasma / plasma + ice - down / up ;;;
{
$93:8CF7             dx 0001,F194,08,10,0000,
$93:8CFF             dx 000F,A3B3,08,10,0001,
                        8239,8CFF             ; Go to $8CFF
}


;;; $8D0B: Instruction list - plasma / plasma + ice - down-left / up-right ;;;
{
$93:8D0B             dx 0001,F2CE,08,08,0000,
$93:8D13             dx 000F,A3C9,08,08,0001,
                        8239,8D13             ; Go to $8D13
}


;;; $8D1F: Instruction list - plasma / plasma + ice - left / right ;;;
{
$93:8D1F             dx 0001,F0FA,08,08,0000,
$93:8D27             dx 000F,A37D,10,08,0001,
                        8239,8D27             ; Go to $8D27
}


;;; $8D33: Instruction list - plasma / plasma + ice - down-right / up-left ;;;
{
$93:8D33             dx 0001,F22E,08,08,0000,
$93:8D3B             dx 000F,A393,08,08,0001,
                        8239,8D3B             ; Go to $8D3B
}


;;; $8D47: Instruction list - plasma + ice + wave - down / up ;;;
{
$93:8D47             dx 0001,F194,0C,10,0000
}


;;; $8D4F: Instruction list - plasma + wave - down / up ;;;
{
$93:8D4F             dx 0002,C0F1,0C,10,0001,
                        0002,C107,0C,10,0002,
                        0002,C131,11,10,0003,
                        0002,C15B,13,10,0004,
                        0002,C185,14,10,0005,
                        0002,C15B,13,10,0006,
                        0002,C131,11,10,0007,
                        0002,C107,0C,10,0008,
                        8239,8D4F             ; Go to $8D4F
}


;;; $8D93: Instruction list - plasma + ice + wave - down-left / up-right ;;;
{
$93:8D93             dx 0001,F2CE,08,08,0000
}


;;; $8D9B: Instruction list - plasma + wave - down-left / up-right ;;;
{
$93:8D9B             dx 0002,CE2A,08,08,0001,
                        0002,CE4A,0C,0C,0002,
                        0002,CE88,10,10,0003,
                        0002,CEC6,10,10,0004,
                        0002,CF04,14,14,0005,
                        0002,CEC6,10,10,0006,
                        0002,CE88,10,10,0007,
                        0002,CE4A,0C,0C,0008,
                        8239,8D9B             ; Go to $8D9B
}


;;; $8DDF: Instruction list - plasma + wave / plasma + ice + wave - left / right ;;;
{
$93:8DDF             dx 0001,F0FA,08,0C,0000,
$93:8DE7             dx 0002,BC0A,10,0C,0001,
                        0002,BC20,10,0C,0002,
                        0002,BC4A,10,11,0003,
                        0002,BC74,10,13,0004,
                        0002,BC9E,10,14,0005,
                        0002,BC74,10,13,0006,
                        0002,BC4A,10,11,0007,
                        0002,BC20,10,0C,0008,
                        8239,8DE7             ; Go to $8DE7
}


;;; $8E2B: Instruction list - plasma + ice + wave - down-right / up-left ;;;
{
$93:8E2B             dx 0001,F22E,08,08,0000
}


;;; $8E33: Instruction list - plasma + wave - down-right / up-left ;;;
{
$93:8E33             dx 0002,BE0D,08,08,0001,
                        0002,BE2D,0C,0C,0002,
                        0002,BE6B,10,10,0003,
                        0002,BEA9,10,10,0004,
                        0002,BEE7,14,14,0005,
                        0002,BEA9,10,10,0006,
                        0002,BE6B,10,10,0007,
                        0002,BE2D,0C,0C,0008,
                        8239,8E33             ; Go to $8E33
}


;;; $8E77: Instruction list - charged power - up ;;;
{
$93:8E77             dx 0001,EC6A,08,08,0000,
                        0001,ED1A,08,08,0001,
                        8239,8E77             ; Go to $8E77
}


;;; $8E8B: Instruction list - charged power - up-right ;;;
{
$93:8E8B             dx 0001,EC80,08,08,0000,
                        0001,ED30,08,08,0001,
                        8239,8E8B             ; Go to $8E8B
}


;;; $8E9F: Instruction list - charged power - right ;;;
{
$93:8E9F             dx 0001,EC96,08,08,0000,
                        0001,ED46,08,08,0001,
                        8239,8E9F             ; Go to $8E9F
}


;;; $8EB3: Instruction list - charged power - down-right ;;;
{
$93:8EB3             dx 0001,ECAC,08,08,0000,
                        0001,ED5C,08,08,0001,
                        8239,8EB3             ; Go to $8EB3
}


;;; $8EC7: Instruction list - charged power - down ;;;
{
$93:8EC7             dx 0001,ECC2,08,08,0000,
                        0001,ED72,08,08,0001,
                        8239,8EC7             ; Go to $8EC7
}


;;; $8EDB: Instruction list - charged power - down-left ;;;
{
$93:8EDB             dx 0001,ECD8,08,08,0000,
                        0001,ED88,08,08,0001,
                        8239,8EDB             ; Go to $8EDB
}


;;; $8EEF: Instruction list - charged power - left ;;;
{
$93:8EEF             dx 0001,EC3E,08,08,0000,
                        0001,ECEE,08,08,0001,
                        8239,8EEF             ; Go to $8EEF
}


;;; $8F03: Instruction list - charged power - up-left ;;;
{
$93:8F03             dx 0001,EC54,08,08,0000,
                        0001,ED04,08,08,0001,
                        8239,8F03             ; Go to $8F03
}


;;; $8F17: Instruction list - charged wave - up ;;;
{
$93:8F17             dx 0003,A117,0C,08,0000
}


;;; $8F1F: Instruction list - charged wave - down ;;;
{
$93:8F1F             dx 0001,AF4C,0C,08,0000,
                        0001,AF62,0C,08,0001,
                        0001,B394,10,08,0002,
                        0001,B3BE,10,08,0003,
                        0001,B3E8,14,08,0004,
                        0001,B412,14,08,0005,
                        0001,B43C,17,08,0006,
                        0001,B466,17,08,0007,
                        0001,B490,18,08,0008,
                        0001,B4BA,18,08,0009,
                        0001,B43C,17,08,000A,
                        0001,B466,17,08,000B,
                        0001,B3E8,14,08,000C,
                        0001,B412,14,08,000D,
                        0001,B3BE,10,08,000E,
                        0001,B394,10,08,000F,
                        8239,8F1F             ; Go to $8F1F
}


;;; $8FA3: Instruction list - charged wave - down-left / up-right ;;;
{
$93:8FA3             dx 0001,AF4C,08,08,0000,
                        0001,AF62,08,08,0001,
                        0001,B218,0C,0C,0002,
                        0001,B242,0C,0C,0003,
                        0001,B26C,10,10,0004,
                        0001,B296,10,10,0005,
                        0001,B2C0,11,11,0006,
                        0001,B2EA,11,11,0007,
                        0001,B314,12,12,0008,
                        0001,B33E,12,12,0009,
                        0001,B2C0,11,11,000A,
                        0001,B2EA,11,11,000B,
                        0001,B26C,10,10,000C,
                        0001,B296,10,10,000D,
                        0001,B218,0C,0C,000E,
                        0001,B242,0C,0C,000F,
                        8239,8FA3             ; Go to $8FA3
}


;;; $9027: Instruction list - charged wave - left / right ;;;
{
$93:9027             dx 0001,AF4C,08,0C,0000,
                        0001,AF62,08,0C,0001,
                        0001,AF78,08,10,0002,
                        0001,AFA2,08,10,0003,
                        0001,AFCC,08,14,0004,
                        0001,AFF6,08,14,0005,
                        0001,B020,08,17,0006,
                        0001,B04A,08,17,0007,
                        0001,B074,08,18,0008,
                        0001,B09E,08,18,0009,
                        0001,B020,08,17,000A,
                        0001,B04A,08,17,000B,
                        0001,AFCC,08,14,000C,
                        0001,AFF6,08,14,000D,
                        0001,AFA2,08,10,000E,
                        0001,AF78,08,10,000F,
                        8239,9027             ; Go to $9027
}


;;; $90AB: Instruction list - charged wave - down-right / up-left ;;;
{
$93:90AB             dx 0001,AF4C,08,08,0000,
                        0001,AF62,08,08,0001,
                        0001,B0C8,0C,0C,0002,
                        0001,B0F2,0C,0C,0003,
                        0001,B11C,10,10,0004,
                        0001,B146,10,10,0005,
                        0001,B170,11,11,0006,
                        0001,B19A,11,11,0007,
                        0001,B1C4,12,12,0008,
                        0001,B1EE,12,12,0009,
                        0001,B170,11,11,000A,
                        0001,B19A,11,11,000B,
                        0001,B11C,10,10,000C,
                        0001,B146,10,10,000D,
                        0001,B0C8,0C,0C,000E,
                        0001,B0F2,0C,0C,000F,
                        8239,90AB             ; Go to $90AB
}


;;; $912F: Instruction list - charged ice ;;;
{
$93:912F             dx 0001,ED9E,08,08,0000,
                        0001,EDB4,08,08,0001,
                        0001,EDCA,08,08,0002,
                        0001,EDE0,08,08,0003,
                        8239,912F             ; Go to $912F
}


;;; $9153: Instruction list - charged ice + wave - up ;;;
{
$93:9153             dx 0003,A117,0C,08,0000
}


;;; $915B: Instruction list - charged ice + wave - down ;;;
{
$93:915B             dx 0001,B672,0C,08,0000,
                        0001,B688,0C,08,0001,
                        0001,BABA,10,08,0002,
                        0001,BAE4,10,08,0003,
                        0001,BB0E,14,08,0004,
                        0001,BB38,14,08,0005,
                        0001,BB62,17,08,0006,
                        0001,BB8C,17,08,0007,
                        0001,BBB6,18,08,0008,
                        0001,BBE0,18,08,0009,
                        0001,BB62,17,08,000A,
                        0001,BB8C,17,08,000B,
                        0001,BB0E,14,08,000C,
                        0001,BB38,14,08,000D,
                        0001,BAE4,10,08,000E,
                        0001,BABA,10,08,000F,
                        8239,915B             ; Go to $915B
}


;;; $91DF: Instruction list - charged ice + wave - down-left / up-right ;;;
{
$93:91DF             dx 0001,B672,08,08,0000,
                        0001,B688,08,08,0001,
                        0001,B93E,0C,0C,0002,
                        0001,B968,0C,0C,0003,
                        0001,B992,10,10,0004,
                        0001,B9BC,10,10,0005,
                        0001,B9E6,11,11,0006,
                        0001,BA10,11,11,0007,
                        0001,BA3A,12,12,0008,
                        0001,BA64,12,12,0009,
                        0001,B9E6,11,11,000A,
                        0001,BA10,11,11,000B,
                        0001,B992,10,10,000C,
                        0001,B9BC,10,10,000D,
                        0001,B93E,0C,0C,000E,
                        0001,B968,0C,0C,000F,
                        8239,91DF             ; Go to $91DF
}


;;; $9263: Instruction list - charged ice + wave - left / right ;;;
{
$93:9263             dx 0001,B672,08,0C,0000,
                        0001,B688,08,0C,0001,
                        0001,B69E,08,10,0002,
                        0001,B6C8,08,10,0003,
                        0001,B6F2,08,14,0004,
                        0001,B71C,08,14,0005,
                        0001,B746,08,17,0006,
                        0001,B770,08,17,0007,
                        0001,B79A,08,18,0008,
                        0001,B7C4,08,18,0009,
                        0001,B746,08,17,000A,
                        0001,B770,08,17,000B,
                        0001,B6F2,08,14,000C,
                        0001,B71C,08,14,000D,
                        0001,B6C8,08,10,000E,
                        0001,B69E,08,10,000F,
                        8239,9263             ; Go to $9263
}


;;; $92E7: Instruction list - charged ice + wave - down-right / up-left ;;;
{
$93:92E7             dx 0001,B672,08,08,0000,
                        0001,B688,08,08,0001,
                        0001,B7EE,0C,0C,0002,
                        0001,B818,0C,0C,0003,
                        0001,B842,10,10,0004,
                        0001,B86C,10,10,0005,
                        0001,B896,11,11,0006,
                        0001,B8C0,11,11,0007,
                        0001,B8EA,12,12,0008,
                        0001,B914,12,12,0009,
                        0001,B896,11,11,000A,
                        0001,B8C0,11,11,000B,
                        0001,B842,10,10,000C,
                        0001,B86C,10,10,000D,
                        0001,B7EE,0C,0C,000E,
                        0001,B818,0C,0C,000F,
                        8239,92E7             ; Go to $92E7
}


;;; $936B: Instruction list - charged spazer / spazer + ice - down / up ;;;
{
$93:936B             dx 0001,EE8E,0C,08,0000,
                        0001,F07E,0C,08,0001,
                        0001,EE95,0C,08,0002,
                        0001,F085,0C,08,0003,
                        0001,E9A6,0C,10,0004,
                        0001,DA3A,0C,10,0005,
                        0001,E9FA,0C,10,0006,
                        0001,DA8E,0C,10,0007,
$93:93AB             dx 0001,EAB4,14,10,0008,
                        0001,DB48,14,10,0009,
                        8239,93AB             ; Go to $93AB
}


;;; $93BF: Instruction list - charged spazer / spazer + ice - down-left / up-right ;;;
{
$93:93BF             dx 0001,EEC8,08,08,0000,
                        0001,F0B8,08,08,0001,
                        0001,EED4,08,08,0002,
                        0001,F0C4,08,08,0003,
                        0001,DF5E,0C,0C,0004,
                        0001,DD72,0C,0C,0005,
                        0001,DF7E,10,10,0006,
                        0001,DDEE,10,10,0007,
$93:93FF             dx 0001,E092,14,14,0008,
                        0001,DF02,14,14,0009,
                        8239,93FF             ; Go to $93FF
}


;;; $9413: Instruction list - charged spazer / spazer + ice - left / right ;;;
{
$93:9413             dx 0001,EF0A,08,0C,0000,
                        0001,F002,08,0C,0001,
                        0001,EF11,08,0C,0002,
                        0001,F009,08,0C,0003,
                        0001,E85A,10,0C,0004,
                        0001,D8EE,10,0C,0005,
                        0001,E8AE,10,0C,0006,
                        0001,D942,10,0C,0007,
$93:9453             dx 0001,E968,10,14,0008,
                        0001,D9FC,10,14,0009,
                        8239,9453             ; Go to $9453
}


;;; $9467: Instruction list - charged spazer / spazer + ice - down-right / up-left ;;;
{
$93:9467             dx 0001,EF44,08,08,0000,
                        0001,F03C,08,08,0001,
                        0001,EF50,08,08,0002,
                        0001,F048,08,08,0003,
                        0001,E14A,0C,0C,0004,
                        0001,DB86,0C,0C,0005,
                        0001,E16A,10,10,0006,
                        0001,DC02,10,10,0007,
$93:94A7             dx 0001,E27E,14,14,0008,
                        0001,DD16,14,14,0009,
                        8239,94A7             ; Go to $94A7
}


;;; $94BB: Instruction list - charged spazer + wave / spazer + ice + wave - up ;;;
{
$93:94BB             dx 0001,EE8E,0C,08,0000,
                        0001,F07E,0C,08,0001,
                        0001,EE95,0C,08,0002,
                        0001,F085,0C,08,0003,
$93:94DB             dx 0001,E9A6,0C,10,0004,
                        0001,DA3A,0C,10,0005,
                        0001,E9BC,0C,10,0006,
                        0001,DA50,0C,10,0007,
                        0001,E9FA,0C,10,0008,
                        0001,DA8E,0C,10,0009,
                        0001,EA38,10,10,000A,
                        0001,DACC,10,10,000B,
                        0001,EA76,12,10,000C,
                        0001,DB0A,12,10,000D,
                        0001,EAB4,14,10,000E,
                        0001,DB48,14,10,000F,
                        0001,EA76,12,10,0010,
                        0001,DB0A,12,10,0011,
                        0001,EA38,10,10,0012,
                        0001,DACC,10,10,0013,
                        0001,E9FA,0C,10,0014,
                        0001,DA8E,0C,10,0015,
                        0001,E9BC,08,10,0016,
                        0001,DA50,08,10,0017,
                        8239,94DB             ; Go to $94DB
}


;;; $957F: Instruction list - charged spazer + wave / spazer + ice + wave - up-right ;;;
{
$93:957F             dx 0001,EEC8,08,08,0000,
                        0001,F0B8,08,08,0001,
                        0001,EED4,08,08,0002,
                        0001,F0C4,08,08,0003,
$93:959F             dx 0001,DF5E,0C,0C,0004,
                        0001,DD72,0C,0C,0005,
                        0001,E0EE,0C,0C,0006,
                        0001,DD92,0C,0C,0007,
                        0001,DF7E,10,10,0008,
                        0001,DDEE,10,10,0009,
                        0001,DFDA,10,10,000A,
                        0001,DE4A,10,10,000B,
                        0001,E036,10,10,000C,
                        0001,DEA6,10,10,000D,
                        0001,E092,14,14,000E,
                        0001,DF02,14,14,000F,
                        0001,E036,10,10,0010,
                        0001,DEA6,10,10,0011,
                        0001,DFDA,10,10,0012,
                        0001,DE4A,10,10,0013,
                        0001,DF7E,10,10,0014,
                        0001,DDEE,10,10,0015,
                        0001,E0EE,0C,0C,0016,
                        0001,DD92,0C,0C,0017,
                        8239,959F             ; Go to $959F
}


;;; $9643: Instruction list - charged spazer + wave / spazer + ice + wave - right ;;;
{
$93:9643             dx 0001,EF0A,08,0C,0000,
                        0001,F002,08,0C,0001,
                        0001,EF11,08,0C,0002,
                        0001,F009,08,0C,0003,
$93:9663             dx 0001,EAF2,10,0C,0004,
                        0001,D8EE,10,0C,0005,
                        0001,EB08,10,0C,0006,
                        0001,D904,10,0C,0007,
                        0001,EB46,10,0C,0008,
                        0001,D942,10,0C,0009,
                        0001,EB84,10,10,000A,
                        0001,D980,10,10,000B,
                        0001,EBC2,10,12,000C,
                        0001,D9BE,10,12,000D,
                        0001,EC00,10,14,000E,
                        0001,D9FC,10,14,000F,
                        0001,EBC2,10,12,0010,
                        0001,D9BE,10,12,0011,
                        0001,EB84,10,10,0012,
                        0001,D980,10,10,0013,
                        0001,EB46,10,0C,0014,
                        0001,D942,10,0C,0015,
                        0001,EB08,10,08,0016,
                        0001,D904,10,08,0017,
                        8239,9663             ; Go to $9663
}


;;; $9707: Instruction list - charged spazer + wave / spazer + ice + wave - down-right ;;;
{
$93:9707             dx 0001,EF44,08,08,0000,
                        0001,F03C,08,08,0001,
                        0001,EF50,08,08,0002,
                        0001,F048,08,08,0003,
$93:9727             dx 0001,E14A,0C,0C,0004,
                        0001,DB86,0C,0C,0005,
                        0001,E2DA,0C,0C,0006,
                        0001,DBA6,0C,0C,0007,
                        0001,E16A,10,10,0008,
                        0001,DC02,10,10,0009,
                        0001,E1C6,10,10,000A,
                        0001,DC5E,10,10,000B,
                        0001,E222,10,10,000C,
                        0001,DCBA,10,10,000D,
                        0001,E27E,14,14,000E,
                        0001,DD16,14,14,000F,
                        0001,E222,10,10,0010,
                        0001,DCBA,10,10,0011,
                        0001,E1C6,10,10,0012,
                        0001,DC5E,10,10,0013,
                        0001,E16A,10,10,0014,
                        0001,DC02,10,10,0015,
                        0001,E2DA,0C,0C,0016,
                        0001,DBA6,0C,0C,0017,
                        8239,9727             ; Go to $9727
}


;;; $97CB: Instruction list - charged spazer + wave / spazer + ice + wave - down ;;;
{
$93:97CB             dx 0001,EF86,0C,08,0000,
                        0001,F07E,0C,08,0001,
                        0001,EF8D,0C,08,0002,
                        0001,F085,0C,08,0003,
$93:97EB             dx 0001,E70E,0C,10,0004,
                        0001,DA3A,0C,10,0005,
                        0001,E724,0C,10,0006,
                        0001,DA50,0C,10,0007,
                        0001,E762,0C,10,0008,
                        0001,DA8E,0C,10,0009,
                        0001,E7A0,10,10,000A,
                        0001,DACC,10,10,000B,
                        0001,E7DE,12,10,000C,
                        0001,DB0A,12,10,000D,
                        0001,E81C,14,10,000E,
                        0001,DB48,14,10,000F,
                        0001,E7DE,12,10,0010,
                        0001,DB0A,12,10,0011,
                        0001,E7A0,10,10,0012,
                        0001,DACC,10,10,0013,
                        0001,E762,0C,10,0014,
                        0001,DA8E,0C,10,0015,
                        0001,E724,08,10,0016,
                        0001,DA50,08,10,0017,
                        8239,97EB             ; Go to $97EB
}


;;; $988F: Instruction list - charged spazer + wave / spazer + ice + wave - down-left ;;;
{
$93:988F             dx 0001,EEC8,08,08,0000,
                        0001,F0B8,08,08,0001,
                        0001,EED4,08,08,0002,
                        0001,F0C4,08,08,0003,
$93:98AF             dx 0001,E336,0C,0C,0004,
                        0001,DD72,0C,0C,0005,
                        0001,E4C6,0C,0C,0006,
                        0001,DD92,0C,0C,0007,
                        0001,E356,10,10,0008,
                        0001,DDEE,10,10,0009,
                        0001,E3B2,10,10,000A,
                        0001,DE4A,10,10,000B,
                        0001,E40E,10,10,000C,
                        0001,DEA6,10,10,000D,
                        0001,E46A,14,14,000E,
                        0001,DF02,14,14,000F,
                        0001,E40E,10,10,0010,
                        0001,DEA6,10,10,0011,
                        0001,E3B2,10,10,0012,
                        0001,DE4A,10,10,0013,
                        0001,E356,10,10,0014,
                        0001,DDEE,10,10,0015,
                        0001,E4C6,0C,0C,0016,
                        0001,DD92,0C,0C,0017,
                        8239,98AF             ; Go to $98AF
}


;;; $9953: Instruction list - charged spazer + wave / spazer + ice + wave - left ;;;
{
$93:9953             dx 0001,EE12,08,0C,0000,
                        0001,F002,08,0C,0001,
                        0001,EE19,08,0C,0002,
                        0001,F009,08,0C,0003,
$93:9973             dx 0001,E85A,10,0C,0004,
                        0001,D8EE,10,0C,0005,
                        0001,E870,10,0C,0006,
                        0001,D904,10,0C,0007,
                        0001,E8AE,10,0C,0008,
                        0001,D942,10,0C,0009,
                        0001,E8EC,10,10,000A,
                        0001,D980,10,10,000B,
                        0001,E92A,10,12,000C,
                        0001,D9BE,10,12,000D,
                        0001,E968,10,14,000E,
                        0001,D9FC,10,14,000F,
                        0001,E92A,10,12,0010,
                        0001,D9BE,10,12,0011,
                        0001,E8EC,10,10,0012,
                        0001,D980,10,10,0013,
                        0001,E8AE,10,0C,0014,
                        0001,D942,10,0C,0015,
                        0001,E870,10,08,0016,
                        0001,D904,10,08,0017,
                        8239,9973             ; Go to $9973
}


;;; $9A17: Instruction list - charged spazer + wave / spazer + ice + wave - up-left ;;;
{
$93:9A17             dx 0001,EE4C,08,08,0000,
                        0001,F03C,08,08,0001,
                        0001,EE58,08,08,0002,
                        0001,F048,08,08,0003,
$93:9A37             dx 0001,E522,0C,0C,0004,
                        0001,DB86,0C,0C,0005,
                        0001,E6B2,0C,0C,0006,
                        0001,DBA6,0C,0C,0007,
                        0001,E542,10,10,0008,
                        0001,DC02,10,10,0009,
                        0001,E59E,10,10,000A,
                        0001,DC5E,10,10,000B,
                        0001,E5FA,10,10,000C,
                        0001,DCBA,10,10,000D,
                        0001,E656,14,14,000E,
                        0001,DD16,14,14,000F,
                        0001,E5FA,10,10,0010,
                        0001,DCBA,10,10,0011,
                        0001,E59E,10,10,0012,
                        0001,DC5E,10,10,0013,
                        0001,E542,10,10,0014,
                        0001,DC02,10,10,0015,
                        0001,E6B2,0C,0C,0016,
                        0001,DBA6,0C,0C,0017,
                        8239,9A37             ; Go to $9A37
}


;;; $9ADB: Instruction list - charged plasma / plasma + ice - down / up ;;;
{
$93:9ADB             dx 0001,F194,08,08,0000,
                        0001,F408,08,08,0001,
                        0001,F1A7,08,10,0002,
                        0001,F41B,08,10,0003,
                        0001,F1E9,08,18,0004,
                        0001,F45D,08,18,0005,
$93:9B0B             dx 0001,F209,08,1C,0006,
                        0001,F47D,08,1C,0007,
                        8239,9B0B             ; Go to $9B0B
}


;;; $9B1F: Instruction list - charged plasma / plasma + ice - down-left / up-right ;;;
{
$93:9B1F             dx 0001,F2CE,08,08,0000,
                        0001,F542,08,08,0001,
                        0001,F2DA,0C,0C,0002,
                        0001,F54E,0C,0C,0003,
                        0001,F310,10,10,0004,
                        0001,F584,10,10,0005,
$93:9B4F             dx 0001,F33A,14,14,0006,
                        0001,F5AE,14,14,0007,
                        8239,9B4F             ; Go to $9B4F
}


;;; $9B63: Instruction list - charged plasma / plasma + ice - left / right ;;;
{
$93:9B63             dx 0001,F0FA,08,08,0000,
                        0001,F36E,08,08,0001,
                        0001,F10D,10,08,0002,
                        0001,F381,10,08,0003,
                        0001,F14F,18,08,0004,
                        0001,F3C3,18,08,0005,
$93:9B93             dx 0001,F16F,1C,08,0006,
                        0001,F3E3,1C,08,0007,
                        8239,9B93             ; Go to $9B93
}


;;; $9BA7: Instruction list - charged plasma / plasma + ice - down-right / up-left ;;;
{
$93:9BA7             dx 0001,F22E,08,08,0000,
                        0001,F4A2,08,08,0001,
                        0001,F23A,0C,0C,0002,
                        0001,F4AE,0C,0C,0003,
                        0001,F270,10,10,0004,
                        0001,F4E4,10,10,0005,
$93:9BD7             dx 0001,F29A,14,14,0006,
                        0001,F50E,14,14,0007,
                        8239,9BD7             ; Go to $9BD7
}


;;; $9BEB: Instruction list - charged plasma + wave / plasma + ice + wave - down / up ;;;
{
$93:9BEB             dx 0001,F194,0C,08,0000,
                        0001,F408,0C,08,0001,
                        0001,F1A7,0C,08,0002,
                        0001,F41B,0C,08,0003,
                        0001,F1E9,0C,18,0004,
                        0001,F45D,0C,18,0005,
$93:9C1B             dx 0001,C1AF,0C,1E,0006,
                        0001,C94D,0C,1E,0007,
                        0001,C1D4,0C,1E,0008,
                        0001,C972,0C,1E,0009,
                        0001,C21C,11,1E,000A,
                        0001,C9BA,11,1E,000B,
                        0001,C264,13,1E,000C,
                        0001,CA02,13,1E,000D,
                        0001,C2AC,14,1E,000E,
                        0001,CA4A,14,1E,000F,
                        0001,C264,13,1E,0010,
                        0001,CA02,13,1E,0011,
                        0001,C21C,11,1E,0012,
                        0001,C9BA,11,1E,0013,
                        0001,C1D4,0C,1E,0014,
                        0001,C972,0C,1E,0015,
                        8239,9C1B             ; Go to $9C1B
}


;;; $9C9F: Instruction list - charged plasma + wave / plasma + ice + wave - down-left / up-right ;;;
{
$93:9C9F             dx 0001,F2CE,08,08,0000,
                        0001,F542,08,08,0001,
                        0001,F2DA,08,08,0002,
                        0001,F54E,08,08,0003,
                        0001,F310,0C,0C,0004,
                        0001,F584,0C,0C,0005,
$93:9CCF             dx 0001,CF42,0C,0C,0006,
                        0001,CC04,0C,0C,0007,
                        0001,CF76,10,10,0008,
                        0001,CC42,10,10,0009,
                        0001,CFDC,11,11,000A,
                        0001,CCBC,11,11,000B,
                        0001,D042,14,14,000C,
                        0001,CD36,14,14,000D,
                        0001,D0A8,18,18,000E,
                        0001,CDB0,18,18,000F,
                        0001,D042,14,14,0010,
                        0001,CD36,14,14,0011,
                        0001,CFDC,11,11,0012,
                        0001,CCBC,11,11,0013,
                        0001,CF76,10,10,0014,
                        0001,CC42,10,10,0015,
                        8239,9CCF             ; Go to $9CCF
}


;;; $9D53: Instruction list - charged plasma + wave / plasma + ice + wave - left / right ;;;
{
$93:9D53             dx 0001,F0FA,08,0C,0000,
                        0001,F36E,08,0C,0001,
                        0001,F10D,08,0C,0002,
                        0001,F381,08,0C,0003,
                        0001,F14F,18,0C,0004,
                        0001,F3C3,18,0C,0005,
$93:9D83             dx 0001,BCC8,1C,0C,0006,
                        0001,C3B2,1C,0C,0007,
                        0001,BCED,1C,0C,0008,
                        0001,C3D7,1C,0C,0009,
                        0001,BD35,1C,11,000A,
                        0001,C41F,1C,11,000B,
                        0001,BD7D,1C,13,000C,
                        0001,C467,1C,13,000D,
                        0001,BDC5,1C,14,000E,
                        0001,C4AF,1C,14,000F,
                        0001,BD7D,1C,13,0010,
                        0001,C467,1C,13,0011,
                        0001,BD35,1C,11,0012,
                        0001,C41F,1C,11,0013,
                        0001,BCED,1C,0C,0014,
                        0001,C3D7,1C,0C,0015,
                        8239,9D83             ; Go to $9D83
}


;;; $9E07: Instruction list - charged plasma + wave / plasma + ice + wave - down-right / up-left ;;;
{
$93:9E07             dx 0001,F22E,08,08,0000,
                        0001,F4A2,08,08,0001,
                        0001,F23A,08,08,0002,
                        0001,F4AE,08,08,0003,
                        0001,F270,0C,0C,0004,
                        0001,F4E4,0C,0C,0005,
$93:9E37             dx 0001,BF25,0C,0C,0006,
                        0001,C669,0C,0C,0007,
                        0001,BF59,10,10,0008,
                        0001,C6A7,10,10,0009,
                        0001,BFBF,11,11,000A,
                        0001,C721,11,11,000B,
                        0001,C025,14,14,000C,
                        0001,C79B,14,14,000D,
                        0001,C08B,18,18,000E,
                        0001,C815,18,18,000F,
                        0001,C025,14,14,0010,
                        0001,C79B,14,14,0011,
                        0001,BFBF,11,11,0012,
                        0001,C721,11,11,0013,
                        0001,BF59,10,10,0014,
                        0001,C6A7,10,10,0015,
                        8239,9E37             ; Go to $9E37
}


;;; $9EBB: Instruction list - missiles - up ;;;
{
$93:9EBB             dx 000F,AD7E,04,04,0000,
                        8239,9EBB             ; Go to $9EBB
}


;;; $9EC7: Instruction list - missiles - up-right ;;;
{
$93:9EC7             dx 000F,AD8A,04,04,0000,
                        8239,9EC7             ; Go to $9EC7
}


;;; $9ED3: Instruction list - missiles - right ;;;
{
$93:9ED3             dx 000F,AD9B,04,04,0000,
                        8239,9ED3             ; Go to $9ED3
}


;;; $9EDF: Instruction list - missiles - down-right ;;;
{
$93:9EDF             dx 000F,ADA7,04,04,0000,
                        8239,9EDF             ; Go to $9EDF
}


;;; $9EEB: Instruction list - missiles - down ;;;
{
$93:9EEB             dx 000F,ADB8,04,04,0000,
                        8239,9EEB             ; Go to $9EEB
}


;;; $9EF7: Instruction list - missiles - down-left ;;;
{
$93:9EF7             dx 000F,ADC4,04,04,0000,
                        8239,9EF7             ; Go to $9EF7
}


;;; $9F03: Instruction list - missiles - left ;;;
{
$93:9F03             dx 000F,AD61,04,04,0000,
                        8239,9F03             ; Go to $9F03
}


;;; $9F0F: Instruction list - missiles - up-left ;;;
{
$93:9F0F             dx 000F,AD6D,04,04,0000,
                        8239,9F0F             ; Go to $9F0F
}


;;; $9F1B: Instruction list - super missile - up ;;;
{
$93:9F1B             dx 000F,ADF2,08,08,0000,
                        8239,9F1B             ; Go to $9F1B
}


;;; $9F27: Instruction list - super missile - up-right ;;;
{
$93:9F27             dx 000F,ADFE,08,08,0000,
                        8239,9F27             ; Go to $9F27
}


;;; $9F33: Instruction list - super missile - right ;;;
{
$93:9F33             dx 000F,AE0F,08,08,0000,
                        8239,9F33             ; Go to $9F33
}


;;; $9F3F: Instruction list - super missile - down-right ;;;
{
$93:9F3F             dx 000F,AE1B,08,08,0000,
                        8239,9F3F             ; Go to $9F3F
}


;;; $9F4B: Instruction list - super missile - down ;;;
{
$93:9F4B             dx 000F,AE2C,08,08,0000,
                        8239,9F4B             ; Go to $9F4B
}


;;; $9F57: Instruction list - super missile - down-left ;;;
{
$93:9F57             dx 000F,AE38,08,08,0000,
                        8239,9F57             ; Go to $9F57
}


;;; $9F63: Instruction list - super missile - left ;;;
{
$93:9F63             dx 000F,ADD5,08,08,0000,
                        8239,9F63             ; Go to $9F63
}


;;; $9F6F: Instruction list - super missile - up-left ;;;
{
$93:9F6F             dx 000F,ADE1,08,08,0000,
                        8239,9F6F             ; Go to $9F6F
}


;;; $9F7B: Instruction list - super missile link ;;;
{
$93:9F7B             dx 000F,A117,08,08,0000,
                        8239,9F7B             ; Go to $9F7B
}


;;; $9F87: Instruction list - power bomb ;;;
{
$93:9F87             dx 0005,AB97,04,04,0000,
                        0005,AB9E,04,04,0000,
                        0005,ABA5,04,04,0000,
                        8239,9F87             ; Go to $9F87
}


;;; $9FA3: Unused. Instruction list - fast power bomb ;;;
{
$93:9FA3             dx 0001,AB97,04,04,0000,
                        0001,AB9E,04,04,0000,
                        0001,ABA5,04,04,0000,
                        8239,9FA3             ; Go to $9FA3
}


;;; $9FBF: Instruction list - bomb ;;;
{
$93:9FBF             dx 0005,AD45,04,04,0000,
                        0005,AD4C,04,04,0000,
                        0005,AD53,04,04,0000,
                        0005,AD5A,04,04,0000,
                        8239,9FBF             ; Go to $9FBF
}


;;; $9FE3: Unused. Instruction list - fast bomb ;;;
{
$93:9FE3             dx 0001,AD45,04,04,0000,
                        0001,AD4C,04,04,0000,
                        0001,AD53,04,04,0000,
                        0001,AD5A,04,04,0000,
                        8239,9FE3             ; Go to $9FE3
}


;;; $A007: Instruction list - beam explosion ;;;
{
$93:A007             dx 0003,ABB3,00,00,0000,
                        0003,ABBA,00,00,0000,
                        0003,ABC1,00,00,0000,
                        0003,ABD7,00,00,0000,
                        0003,ABED,00,00,0000,
                        0003,AC03,00,00,0000,
                        822F                  ; Delete
}


;;; $A039: Instruction list - missile explosion ;;;
{
$93:A039             dx 0003,A7C9,08,08,0000,
                        0003,A7D0,08,08,0000,
                        0003,A7E6,08,08,0000,
                        0003,A7FC,08,08,0000,
                        0003,A812,08,08,0000,
                        0003,A828,08,08,0000,
                        822F                  ; Delete
}


;;; $A06B: Instruction list - bomb explosion ;;;
{
$93:A06B             dx 0002,A83E,08,08,0000,
                        0002,A854,0C,0C,0000,
                        0002,A86A,10,10,0000,
                        0002,A880,10,10,0000,
                        0002,A896,10,10,0000,
                        822F                  ; Delete
}


;;; $A095: Instruction list - plasma SBA ;;;
{
$93:A095             dx 0002,A83E,08,08,0000,
                        0002,A854,0C,0C,0000,
                        0002,A86A,10,10,0000,
                        0002,A880,10,10,0000,
                        0002,A896,10,10,0000,
                        8239,A095             ; Go to $A095
}


;;; $A0C1: Instruction list - super missile explosion ;;;
{
$93:A0C1             dx 0005,AA84,08,08,0000,
                        0005,AA9A,0C,0C,0000,
                        0005,AAB0,10,10,0000,
                        0005,AAC6,10,10,0000,
                        0005,AB04,10,10,0000,
                        0005,AB2E,10,10,0000,
                        822F                  ; Delete
}


;;; $A0F3: Instruction list - unused projectile 25h ;;;
{
$93:A0F3             dx 0002,A117,10,20,0000,
                        0002,A117,10,20,0001,
                        0002,A117,10,20,0002,
                        0002,A117,10,20,0003,
                        8239,A0F3             ; Go to $A0F3
}


;;; $A117: Spritemap - nothing ;;;
{
$93:A117             dx 0000
}


;;; $A119: Instruction list - shinespark echoes ;;;
{
$93:A119             dx 0002,A117,20,20,0000,
                        0002,A117,20,20,0001,
                        0002,A117,20,20,0002,
                        0002,A117,20,20,0003,
                        8239,A119             ; Go to $A119
}


;;; $A13D: Instruction list - spazer SBA trail ;;;
{
$93:A13D             dx 0002,A117,04,08,0000,
                        0002,A117,0C,08,0001,
$93:A14D             dx 0002,A117,14,08,0002,
                        8239,A14D             ; Go to $A14D
}


;;; $A159: Instruction list - wave SBA ;;;
{
$93:A159             dx 0008,AF4C,04,04,0000,
                        0008,AF62,04,04,0001,
                        8239,A159             ; Go to $A159
}


;;; $A16D: Instruction list - unused shinespark beam (projectile 27h) ;;;
{
$93:A16D             dx 0003,ABB3,00,00,0000,
                        0003,ABBA,00,00,0000,
                        0003,ABC1,00,00,0000,
                        0003,ABD7,00,00,0000,
                        0003,ABED,00,00,0000,
                        0003,AC03,00,00,0000,
                        8239,A16D             ; Go to $A16D
}
}


;;; $A1A1: Flare spritemap pointers ;;;
{
; Index 3Eh is used for a shinespark windup effect by unused function $F5E2
$93:A1A1             dw AB6C, AB73, AB6C, AB73, AB6C, AB73, AB6C, AB73, AB7A, AB73, AB7A, AB73, AB7A, AB73, AB7A, AB73,
                        AB7A, AB81, AB7A, AB81, AB7A, AB81, AB7A, AB81, AB7A, AB81, AB7A, AB81, AB7A, AB81, ; 0..1Dh: Flare (charge beam / hyper beam / grapple beam)
                        A6FD, A70E, A71F, A730, A741, A752, ; 1Eh..23h: Flare slow sparks (charge beam / hyper beam) - facing right
                        A763, A774, A785, A796, A7A7, A7B8, ; 24h..29h: Flare fast sparks (charge beam / hyper beam) - facing right
                        A8DE, A8EF, A900, A911, A922, A933, ; 2Ah..2Fh: Flare slow sparks (charge beam / hyper beam) - facing left
                        A944, A955, A966, A977, A988, A999, ; 30h..35h: Flare fast sparks (charge beam / hyper beam) - facing left
                        ABB3, ABBA, ABC1, ABD7, ABED, AC03, ; 36h..3Bh: Unused
                        A83E, A854, A86A, A880, A896, A8AC  ; 3Ch..41h: Unused
}


;;; $A225: Flare spritemap table index offsets ;;;
{
;                        _______________ Flare (charge beam / hyper beam / grapple beam)
;                       |      _________ Flare slow sparks (charge beam / hyper beam)
;                       |     |      ___ Flare fast sparks (charge beam / hyper beam)
;                       |     |     |
$93:A225             dw 0000, 001E, 0024 ; Facing right
$93:A22B             dw 0000, 002A, 0030 ; Facing left
}


;;; $A231: Projectile / flare spritemaps ;;;
{
$93:A231             dx 0001, 01FC,FC,3A2B ; Unused
$93:A238             dx 0001, 01FC,FC,3A2A ; Unused
$93:A23F             dx 0001, 01FC,FC,3A29 ; Unused
$93:A246             dx 0001, 01FC,FC,3A28 ; Unused

; Power
$93:A24D             dx 0001, 01FC,FC,2C30
$93:A254             dx 0001, 01FC,FC,2C31
$93:A25B             dx 0001, 01FC,FC,2C32
$93:A262             dx 0001, 01FC,FC,6C31
$93:A269             dx 0001, 01FC,FC,EC30
$93:A270             dx 0001, 01FC,FC,EC31
$93:A277             dx 0001, 01FC,FC,AC32
$93:A27E             dx 0001, 01FC,FC,AC31

$93:A285             dx 0001, 01FC,FC,2C30 ; Unused
$93:A28C             dx 0001, 01FC,FC,2C31 ; Unused
$93:A293             dx 0001, 01FC,FC,2C32 ; Unused
$93:A29A             dx 0001, 01FC,FC,2C32 ; Unused
$93:A2A1             dx 0001, 01FC,FC,2C30 ; Unused
$93:A2A8             dx 0001, 01FC,FC,2C31 ; Unused
$93:A2AF             dx 0001, 01FC,FC,2C32 ; Unused
$93:A2B6             dx 0001, 01FC,FC,6C31 ; Unused
$93:A2BD             dx 0001, 01FC,FC,6C30 ; Unused
$93:A2C4             dx 0001, 01FC,FC,EC31 ; Unused
$93:A2CB             dx 0001, 01FC,FC,AC32 ; Unused
$93:A2D2             dx 0001, 01FC,FC,AC31 ; Unused
$93:A2D9             dx 0002, 0000,FC,2C30, 01F8,FC,2C30 ; Unused
$93:A2E5             dx 0004, 0006,00,2C32, 01FE,00,2C31, 01FE,F8,2C32, 01F6,F8,2C31 ; Unused
$93:A2FB             dx 0002, 01FC,00,2C33, 01FC,F8,2C33 ; Unused
$93:A307             dx 0004, 01F2,00,6C32, 01FA,00,6C31, 01FA,F8,6C32, 0002,F8,6C31 ; Unused
$93:A31D             dx 0002, 01F8,FC,6C30, 0000,FC,6C30 ; Unused
$93:A329             dx 0004, 01F2,F8,EC32, 01FA,F8,EC31, 01FA,00,EC32, 0002,00,EC31 ; Unused
$93:A33F             dx 0002, 01FC,F8,AC33, 01FC,00,AC33 ; Unused
$93:A34B             dx 0004, 01F2,00,6C32, 01FA,00,6C31, 01FA,F8,6C32, 0002,F8,6C31 ; Unused
$93:A361             dx 0001, 01FC,FC,2C38 ; Unused
$93:A368             dx 0001, 01FC,FC,2C39 ; Unused
$93:A36F             dx 0001, 01FC,FC,2C3A ; Unused
$93:A376             dx 0001, 01FC,FC,2C3B ; Unused

; Plasma / plasma + ice
$93:A37D             dx 0004, 0008,FC,2C30, 01F0,FC,2C30, 0000,FC,2C30, 01F8,FC,2C30
$93:A393             dx 0006, 0008,04,2C32, 0000,04,2C31, 0000,FC,2C32, 01F8,FC,2C31, 01F8,F4,2C32, 01F0,F4,2C31
$93:A3B3             dx 0004, 01FC,08,2C33, 01FC,00,2C33, 01FC,F8,2C33, 01FC,F0,2C33
$93:A3C9             dx 0006, 01F0,04,6C32, 01F8,04,6C31, 01F8,FC,6C32, 0000,FC,6C31, 0000,F4,6C32, 0008,F4,6C31

$93:A3E9             dx 0004, 0008,FC,2C30, 01F0,FC,2C30, 0000,FC,2C30, 01F8,FC,2C30 ; Unused
$93:A3FF             dx 0006, 000A,04,2C32, 0002,04,2C31, 0002,FC,2C32, 01FA,FC,2C31, 01FA,F4,2C32, 01F2,F4,2C31 ; Unused
$93:A41F             dx 0004, 01FC,08,2C33, 01FC,F0,2C33, 01FC,00,2C33, 01FC,F8,2C33 ; Unused
$93:A435             dx 0006, 01EE,04,6C32, 01F6,04,6C31, 01F6,FC,6C32, 01FE,FC,6C31, 01FE,F4,6C32, 0006,F4,6C31 ; Unused
$93:A455             dx 0004, 01F0,FC,6C30, 0008,FC,6C30, 01F8,FC,6C30, 0000,FC,6C30 ; Unused
$93:A46B             dx 0006, 01EE,F4,EC32, 01F6,F4,EC31, 01F6,FC,EC32, 01FE,FC,EC31, 01FE,04,EC32, 0006,04,EC31 ; Unused
$93:A48B             dx 0004, 01FC,F0,AC33, 01FC,08,AC33, 01FC,F8,AC33, 01FC,00,AC33 ; Unused
$93:A4A1             dx 0006, 000A,F4,AC32, 0002,F4,AC31, 0002,FC,AC32, 01FA,FC,AC31, 01FA,04,AC32, 01F2,04,AC31 ; Unused
$93:A4C1             dx 0007, 0014,FC,2C30, 01E4,FC,2C30, 01EC,FC,2C30, 000C,FC,2C30, 0004,FC,2C30, 01FC,FC,2C30, 01F4,FC,2C30 ; Unused
$93:A4E6             dx 000A, 0010,0C,2C32, 0008,0C,2C31, 0008,04,2C32, 0000,04,2C31, 0000,FC,2C32, 01F8,FC,2C31, 01F8,F4,2C32, 01F0,F4,2C31, 01F0,EC,2C32, 01E8,EC,2C31 ; Unused
$93:A51A             dx 0007, 01FC,14,2C33, 01FC,0C,2C33, 01FC,04,2C33, 01FC,FC,2C33, 01FC,F4,2C33, 01FC,EC,2C33, 01FC,E4,2C33 ; Unused
$93:A53F             dx 000A, 0008,EC,6C32, 0010,EC,6C31, 01E8,0C,6C32, 01F0,0C,6C31, 01F0,04,6C32, 01F8,04,6C31, 01F8,FC,6C32, 0000,FC,6C31, 0000,F4,6C32, 0008,F4,6C31 ; Unused
$93:A573             dx 0007, 0014,FC,2C34, 01E4,FC,2C34, 000C,FC,2C34, 01EC,FC,2C34, 0004,FC,2C34, 01FC,FC,2C34, 01F4,FC,2C34 ; Unused
$93:A598             dx 000A, 0010,0C,2C36, 0008,0C,2C35, 01F0,EC,2C36, 01E8,EC,2C35, 01F8,F4,2C36, 01F0,F4,2C35, 0008,04,2C36, 0000,04,2C35, 0000,FC,2C36, 01F8,FC,2C35 ; Unused
$93:A5CC             dx 0007, 01FC,14,2C37, 01FC,0C,2C37, 01FC,E4,2C37, 01FC,04,2C37, 01FC,FC,2C37, 01FC,F4,2C37, 01FC,EC,2C37 ; Unused
$93:A5F1             dx 000A, 01E8,0C,6C36, 01F0,0C,6C35, 01F0,04,6C36, 01F8,04,6C35, 0008,EC,6C36, 0010,EC,6C35, 01F8,FC,6C36, 0000,FC,6C35, 0000,F4,6C36, 0008,F4,6C35 ; Unused
$93:A625             dx 0004, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34 ; Unused
$93:A63B             dx 0006, 0008,04,2C36, 0000,04,2C35, 0000,FC,2C36, 01F8,FC,2C35, 01F8,F4,2C36, 01F0,F4,2C35 ; Unused
$93:A65B             dx 0004, 01FC,08,2C37, 01FC,00,2C37, 01FC,F8,2C37, 01FC,F0,2C37 ; Unused
$93:A671             dx 0006, 01F0,04,6C36, 01F8,04,6C35, 01F8,FC,6C36, 0000,FC,6C35, 0000,F4,6C36, 0008,F4,6C35 ; Unused
$93:A691             dx 0004, 0000,00,EC34, 01F8,00,AC34, 0000,F8,6C34, 01F8,F8,2C34 ; Unused
$93:A6A7             dx 0004, 0000,00,EC33, 01F8,00,AC33, 0000,F8,6C33, 01F8,F8,2C33 ; Unused
$93:A6BD             dx 0001, 01FC,FC,2C35 ; Unused
$93:A6C4             dx 0001, 01FC,FC,2C36 ; Unused
$93:A6CB             dx 0001, 01FC,FC,2C37 ; Unused
$93:A6D2             dx 0001, 01FC,FC,3C53 ; Unused
$93:A6D9             dx 0001, 01FC,FC,3C52 ; Unused
$93:A6E0             dx 0001, 01FC,FC,3C51 ; Unused
$93:A6E7             dx 0004, 01F8,00,BC50, 0000,00,FC50, 0000,F8,7C50, 01F8,F8,3C50 ; Unused

; Flare slow sparks (charge beam / hyper beam) - facing right. Uses palette 5(!)
$93:A6FD             dx 0003, 0000,0C,2A5B, 0008,EC,2A5B, 01F0,F4,2A5B
$93:A70E             dx 0003, 01FD,0A,2A5C, 0006,EE,2A5C, 01F2,F6,2A5C
$93:A71F             dx 0003, 01FC,08,2A5C, 0004,F0,2A5C, 01F4,F8,2A5C
$93:A730             dx 0003, 0002,F2,2A5D, 01FB,06,2A5D, 01F6,FA,2A5D
$93:A741             dx 0003, 01FB,04,2A5D, 01F8,FB,2A5D, 0000,F4,2A5D
$93:A752             dx 0003, 01FB,02,2A5D, 01FA,FA,2A5D, 0000,F6,2A5D

; Flare fast sparks (charge beam / hyper beam) - facing right. Uses palette 5(!)
$93:A763             dx 0003, 0000,EC,AA5B, 0008,0C,AA5B, 01F0,04,AA5B
$93:A774             dx 0003, 01FE,EE,AA5C, 0006,0A,AA5C, 01F2,02,AA5C
$93:A785             dx 0003, 0004,08,AA5C, 01F4,00,AA5C, 01FD,F0,AA5C
$93:A796             dx 0003, 0002,06,AA5D, 01FC,F2,AA5D, 01F6,FE,AA5D
$93:A7A7             dx 0003, 01FC,F4,AA5D, 01F8,FC,AA5D, 0000,04,AA5D
$93:A7B8             dx 0003, 01FC,F6,AA5D, 01FA,FD,AA5D, 0000,02,AA5D

; Missile explosion
$93:A7C9             dx 0001, 01FC,FC,3A5F
$93:A7D0             dx 0004, 0000,00,FA8A, 01F8,00,BA8A, 0000,F8,7A8A, 01F8,F8,3A8A
$93:A7E6             dx 0004, C200,00,FA90, C3F0,00,BA90, C200,F0,7A90, C3F0,F0,3A90
$93:A7FC             dx 0004, C200,00,FA92, C3F0,00,BA92, C200,F0,7A92, C3F0,F0,3A92
$93:A812             dx 0004, C200,00,FA94, C3F0,00,BA94, C200,F0,7A94, C3F0,F0,3A94
$93:A828             dx 0004, C200,00,FA96, C3F0,00,BA96, C200,F0,7A96, C3F0,F0,3A96

; Bomb explosion / plasma SBA / unused flare spritemaps 3Ch..41h
$93:A83E             dx 0004, 0000,00,FA8B, 01F8,00,BA8B, 0000,F8,7A8B, 01F8,F8,3A8B
$93:A854             dx 0004, 0000,00,FA7A, 01F8,00,BA7A, 0000,F8,7A7A, 01F8,F8,3A7A
$93:A86A             dx 0004, C200,00,FA70, C3F0,00,BA70, C200,F0,7A70, C3F0,F0,3A70
$93:A880             dx 0004, C200,00,FA72, C3F0,00,BA72, C200,F0,7A72, C3F0,F0,3A72
$93:A896             dx 0004, C200,00,FA74, C3F0,00,BA74, C200,F0,7A74, C3F0,F0,3A74
$93:A8AC             dx 0004, 01F8,00,3A5E, 0000,00,3A5E, 0000,F8,3A5E, 01F8,F8,3A5E ; Flare spritemap 41h only (not part of bomb explosion / plasma SBA)

$93:A8C2             dx 0001, 01FC,FC,3C38 ; Unused
$93:A8C9             dx 0001, 01FC,FC,3C39 ; Unused
$93:A8D0             dx 0001, 01FC,FC,3C3A ; Unused
$93:A8D7             dx 0001, 01FC,FC,3C3B ; Unused

; Flare slow sparks (charge beam / hyper beam) - facing left
$93:A8DE             dx 0003, 01F8,0C,6C5B, 01F0,EC,6C5B, 0008,F4,6C5B
$93:A8EF             dx 0003, 01FB,0A,6C5C, 01F2,EE,6C5C, 0006,F6,6C5C
$93:A900             dx 0003, 01FC,08,6C5C, 01F4,F0,6C5C, 0004,F8,6C5C
$93:A911             dx 0003, 01F6,F2,6C5D, 01FD,06,6C5D, 0002,FA,6C5D
$93:A922             dx 0003, 01FD,04,6C5D, 0000,FB,6C5D, 01F8,F4,6C5D
$93:A933             dx 0003, 01FD,02,6C5D, 01FE,FA,6C5D, 01F8,F6,6C5D

; Flare fast sparks (charge beam / hyper beam) - facing left
$93:A944             dx 0003, 01F8,EC,EC5B, 01F0,0C,EC5B, 0008,04,EC5B
$93:A955             dx 0003, 01FA,EE,EC5C, 01F2,0A,EC5C, 0006,02,EC5C
$93:A966             dx 0003, 01F4,08,EC5C, 0004,00,EC5C, 01FB,F0,EC5C
$93:A977             dx 0003, 01F6,06,EC5D, 01FC,F2,EC5D, 0002,FE,EC5D
$93:A988             dx 0003, 01FC,F4,EC5D, 0000,FC,EC5D, 01F8,04,EC5D
$93:A999             dx 0003, 01FC,F6,EC5D, 01FE,FD,EC5D, 01F8,02,EC5D

$93:A9AA             dx 0001, 01F7,F7,3A48 ; Unused
$93:A9B1             dx 0002, 0001,01,3A48, C3F3,F3,3A7C ; Unused
$93:A9BD             dx 0003, C3FD,FD,3A7C, 01F7,01,3A48, C3F3,F3,3A7E ; Unused
$93:A9CE             dx 0004, 0001,F7,3A48, C3FD,FD,3A7E, C3F3,FD,3A7C, C3F3,F3,3A9A ; Unused
$93:A9E4             dx 0004, C3FD,F3,3A7C, C3FD,FD,3A9A, C3F3,FD,3A7E, C3F3,F3,3A9C ; Unused
$93:A9FA             dx 0003, C3FD,F3,3A7E, C3FD,FD,3A9C, C3F3,FD,3A9A ; Unused
$93:AA0B             dx 0002, C3FD,F3,3A9A, C3F3,FD,3A9C ; Unused
$93:AA17             dx 0001, C3FD,F3,3A9C ; Unused
$93:AA1E             dx 0001, 01FC,FC,3C5E ; Unused
$93:AA25             dx 0001, 01FC,FC,3C5F ; Unused
$93:AA2C             dx 0004, 0000,00,FC60, 0000,F8,7C60, 01F8,00,BC60, 01F8,F8,3C60 ; Unused
$93:AA42             dx 0004, 0000,00,FC61, 0000,F8,7C61, 01F8,00,BC61, 01F8,F8,3C61 ; Unused
$93:AA58             dx 0004, 0000,00,FC62, 0000,F8,7C62, 01F8,00,BC62, 01F8,F8,3C62 ; Unused
$93:AA6E             dx 0004, 0000,00,FC63, 0000,F8,7C63, 01F8,00,BC63, 01F8,F8,3C63 ; Unused

; Super missile explosion
$93:AA84             dx 0004, 0000,00,FA8A, 01F8,00,BA8A, 0000,F8,7A8A, 01F8,F8,3A8A
$93:AA9A             dx 0004, C200,00,FA90, C200,F0,7A90, C3F0,00,BA90, C3F0,F0,3A90
$93:AAB0             dx 0004, C200,00,FA92, C3F0,00,BA92, C200,F0,7A92, C3F0,F0,3A92
$93:AAC6             dx 000C, 0010,00,FAC2, 0010,F8,7AC2, 0000,10,FAB2, 01F8,10,BAB2, 01E8,00,BAC2, 01E8,F8,3AC2, 0000,E8,7AB2, 01F8,E8,3AB2, C200,00,FAB0, C200,F0,7AB0, C3F0,00,BAB0, C3F0,F0,3AB0
$93:AB04             dx 0008, C208,00,FAB5, C200,08,FAB3, C3E8,00,BAB5, C3F0,08,BAB3, C208,F0,7AB5, C200,E8,7AB3, C3E8,F0,3AB5, C3F0,E8,3AB3
$93:AB2E             dx 000C, 0000,10,FABB, 01F8,10,BABB, 0000,E8,7ABB, 01F8,E8,3ABB, 0010,00,FAB7, 0010,F8,7AB7, 01E8,00,BAB7, 01E8,F8,3AB7, C208,08,FAB8, C3E8,08,BAB8, C208,E8,7AB8, C3E8,E8,3AB8

; Flare (charge beam / hyper beam / grapple beam)
$93:AB6C             dx 0001, 01FC,FC,2C53
$93:AB73             dx 0001, 01FC,FC,2C52
$93:AB7A             dx 0001, 01FC,FC,2C51
$93:AB81             dx 0004, 01F8,00,AC50, 0000,00,EC50, 0000,F8,6C50, 01F8,F8,2C50

; Power bomb
$93:AB97             dx 0001, 01FC,FC,3A26
$93:AB9E             dx 0001, 01FC,FC,3A27
$93:ABA5             dx 0001, 01FC,FC,3A7B

$93:ABAC             dx 0001, 01FC,FC,3A5F ; Unused

; Beam explosion / unused flare spritemaps 36h..3Bh / unused shinespark beam
$93:ABB3             dx 0001, 01FC,FC,3C53
$93:ABBA             dx 0001, 01FC,FC,3C51
$93:ABC1             dx 0004, 0000,00,FC60, 0000,F8,7C60, 01F8,00,BC60, 01F8,F8,3C60
$93:ABD7             dx 0004, 0000,00,FC61, 0000,F8,7C61, 01F8,00,BC61, 01F8,F8,3C61
$93:ABED             dx 0004, 0000,00,FC62, 0000,F8,7C62, 01F8,00,BC62, 01F8,F8,3C62
$93:AC03             dx 0004, 0000,00,FC63, 0000,F8,7C63, 01F8,00,BC63, 01F8,F8,3C63

$93:AC19             dx 0004, 01F2,FC,7A6C, 0006,FC,7A6C, 0000,FC,7A6C, 01F8,FC,3A6C ; Unused
$93:AC2F             dx 0004, 0000,FC,7A6E, 0008,FC,7A6D, 01F8,FC,3A6E, 01F0,FC,3A6D ; Unused
$93:AC45             dx 0004, 01F0,FE,3A6F, 0008,FE,3A6F, 0000,FE,3A6F, 01F8,FE,3A6F ; Unused
$93:AC5B             dx 0001, C3F8,F8,3A7C ; Unused
$93:AC62             dx 0001, C3F8,F6,3A7E ; Unused
$93:AC69             dx 0001, C3F8,F4,3A9A ; Unused
$93:AC70             dx 0001, C3F8,F2,3A9C ; Unused
$93:AC77             dx 0001, 01FC,FC,2A48 ; Unused
$93:AC7E             dx 0001, 01FC,FA,2A49 ; Unused
$93:AC85             dx 0001, 01FC,F8,2A4A ; Unused
$93:AC8C             dx 0001, 01FC,F6,2A4B ; Unused
$93:AC93             dx 0001, 01FC,FC,3A2C ; Unused
$93:AC9A             dx 0001, 01FC,FC,3A2D ; Unused
$93:ACA1             dx 0001, 01FC,FC,3A2E ; Unused
$93:ACA8             dx 0001, 01FC,FC,3A2F ; Unused
$93:ACAF             dx 0001, C3F8,F6,3A76 ; Unused
$93:ACB6             dx 0001, C3F8,F4,3A78 ; Unused
$93:ACBD             dx 0001, C3F8,F2,3A98 ; Unused
$93:ACC4             dx 0001, C3F8,F0,3A9E ; Unused
$93:ACCB             dx 0001, 01FC,FC,3A25 ; Unused
$93:ACD2             dx 0001, 01FC,FC,3A43 ; Unused
$93:ACD9             dx 0001, 01FC,FC,3A40 ; Unused
$93:ACE0             dx 0001, 01FC,FC,3A3E ; Unused
$93:ACE7             dx 0001, 01FC,FC,3A3D ; Unused
$93:ACEE             dx 0001, 01FC,FC,3A41 ; Unused
$93:ACF5             dx 0001, 01FC,FC,3A42 ; Unused
$93:ACFC             dx 0004, 0000,00,FA44, 01F8,00,BA44, 0000,F8,7A44, 01F8,F8,3A44 ; Unused
$93:AD12             dx 0004, 0000,00,FA45, 0000,F8,7A45, 01F8,00,BA45, 01F8,F8,3A45 ; Unused
$93:AD28             dx 0004, 01F8,00,BA46, 0000,00,FA46, 0000,F8,7A46, 01F8,F8,3A46 ; Unused
$93:AD3E             dx 0001, 01FC,FC,3A42 ; Unused

; Bomb
$93:AD45             dx 0001, 01FC,FC,3A4C
$93:AD4C             dx 0001, 01FC,FC,3A4D
$93:AD53             dx 0001, 01FC,FC,3A4E
$93:AD5A             dx 0001, 01FC,FC,3A4F

; Missile
$93:AD61             dx 0002, 01FF,FC,2A55, 01F7,FC,2A54
$93:AD6D             dx 0003, 01F8,F5,2A56, 0000,FD,2A58, 01F8,FD,2A57
$93:AD7E             dx 0002, 01FC,F7,2A59, 01FC,FF,2A5A
$93:AD8A             dx 0003, 0000,F5,6A56, 01F8,FD,6A58, 0000,FD,6A57
$93:AD9B             dx 0002, 01F9,FC,6A55, 0001,FC,6A54
$93:ADA7             dx 0003, 0000,03,EA56, 01F8,FB,EA58, 0000,FB,EA57
$93:ADB8             dx 0002, 01FD,01,AA59, 01FD,F9,AA5A
$93:ADC4             dx 0003, 01F8,03,AA56, 0000,FB,AA58, 01F8,FB,AA57

; Super missile
$93:ADD5             dx 0002, 0000,FC,2A65, 01F8,FC,2A64
$93:ADE1             dx 0003, 0002,FE,2A68, 01FA,FE,2A67, 01FA,F6,2A66
$93:ADF2             dx 0002, 01FC,F8,2A69, 01FC,00,2A6A
$93:ADFE             dx 0003, 01F6,FE,6A68, 01FE,FE,6A67, 01FE,F6,6A66
$93:AE0F             dx 0002, 01F8,FC,6A65, 0000,FC,6A64
$93:AE1B             dx 0003, 01F6,FA,EA68, 01FE,FA,EA67, 01FE,02,EA66
$93:AE2C             dx 0002, 01FC,00,AA69, 01FC,F8,AA6A
$93:AE38             dx 0003, 0002,FA,AA68, 01FA,FA,AA67, 01FA,02,AA66

$93:AE49             dx 0001, 01FC,FC,3A3C ; Unused
$93:AE50             dx 0001, 01FC,FC,3A3D ; Unused
$93:AE57             dx 0001, 01FC,FC,3A3E ; Unused
$93:AE5E             dx 0001, 01FC,FC,3A3F ; Unused

; Wave / ice + wave
$93:AE65             dx 0001, 01FC,FC,2C30
$93:AE6C             dx 0001, 01FC,F4,2C30
$93:AE73             dx 0001, 01FC,EF,2C31
$93:AE7A             dx 0001, 01FC,ED,2C31
$93:AE81             dx 0001, 01FC,EC,2C32
$93:AE88             dx 0001, 01FC,04,2C30
$93:AE8F             dx 0001, 01FC,09,2C31
$93:AE96             dx 0001, 01FC,0B,2C31
$93:AE9D             dx 0001, 01FC,0C,2C32
$93:AEA4             dx 0001, 0002,F6,2C30
$93:AEAB             dx 0001, 0005,F3,2C31
$93:AEB2             dx 0001, 0007,F1,2C31
$93:AEB9             dx 0001, 0008,F0,2C32
$93:AEC0             dx 0001, 01F6,02,2C30
$93:AEC7             dx 0001, 01F3,05,2C31
$93:AECE             dx 0001, 01F1,07,2C31
$93:AED5             dx 0001, 01F0,08,2C32
$93:AEDC             dx 0001, 0004,FC,2C30
$93:AEE3             dx 0001, 0009,FC,2C31
$93:AEEA             dx 0001, 000B,FC,2C31
$93:AEF1             dx 0001, 000C,FC,2C32
$93:AEF8             dx 0001, 01F4,FC,2C30
$93:AEFF             dx 0001, 01EF,FC,2C31
$93:AF06             dx 0001, 01ED,FC,2C31
$93:AF0D             dx 0001, 01EC,FC,2C32
$93:AF14             dx 0001, 01F6,F6,2C30
$93:AF1B             dx 0001, 01F3,F3,2C31
$93:AF22             dx 0001, 01F1,F1,2C31
$93:AF29             dx 0001, 01F0,F0,2C32
$93:AF30             dx 0001, 0002,02,2C30
$93:AF37             dx 0001, 0005,05,2C31
$93:AF3E             dx 0001, 0007,07,2C31
$93:AF45             dx 0001, 0008,08,2C32

; Charged wave / wave SBA
$93:AF4C             dx 0004, 0000,00,EC34, 01F8,00,AC34, 0000,F8,6C34, 01F8,F8,2C34
$93:AF62             dx 0004, 0000,00,EC33, 01F8,00,AC33, 0000,F8,6C33, 01F8,F8,2C33
$93:AF78             dx 0008, 0000,08,EC33, 01F8,08,AC33, 0000,00,6C33, 01F8,00,2C33, 0000,F8,EC34, 01F8,F8,AC34, 0000,F0,6C34, 01F8,F0,2C34
$93:AFA2             dx 0008, 0000,08,EC34, 01F8,08,AC34, 0000,00,6C34, 01F8,00,2C34, 0000,F8,EC33, 01F8,F8,AC33, 0000,F0,6C33, 01F8,F0,2C33
$93:AFCC             dx 0008, 0000,0D,EC33, 01F8,0D,AC33, 0000,05,6C33, 01F8,05,2C33, 0000,F3,EC34, 01F8,F3,AC34, 0000,EB,6C34, 01F8,EB,2C34
$93:AFF6             dx 0008, 0000,0D,EC34, 01F8,0D,AC34, 0000,05,6C34, 01F8,05,2C34, 0000,F3,EC33, 01F8,F3,AC33, 0000,EB,6C33, 01F8,EB,2C33
$93:B020             dx 0008, 0000,0F,EC33, 01F8,0F,AC33, 0000,07,6C33, 01F8,07,2C33, 0000,F1,EC34, 01F8,F1,AC34, 0000,E9,6C34, 01F8,E9,2C34
$93:B04A             dx 0008, 0000,0F,EC34, 01F8,0F,AC34, 0000,07,6C34, 01F8,07,2C34, 0000,F1,EC33, 01F8,F1,AC33, 0000,E9,6C33, 01F8,E9,2C33
$93:B074             dx 0008, 0000,10,EC33, 01F8,10,AC33, 0000,08,6C33, 01F8,08,2C33, 0000,F0,EC34, 01F8,F0,AC34, 0000,E8,6C34, 01F8,E8,2C34
$93:B09E             dx 0008, 0000,10,EC34, 01F8,10,AC34, 0000,08,6C34, 01F8,08,2C34, 0000,F0,EC33, 01F8,F0,AC33, 0000,E8,6C33, 01F8,E8,2C33
$93:B0C8             dx 0008, 0005,FB,EC34, 01FD,FB,AC34, 0005,F3,6C34, 01FD,F3,2C34, 01FB,05,EC33, 01F3,05,AC33, 01FB,FD,6C33, 01F3,FD,2C33
$93:B0F2             dx 0008, 0004,FC,EC33, 01FC,FC,AC33, 0004,F4,6C33, 01FC,F4,2C33, 01FC,04,EC34, 01F4,04,AC34, 01FC,FC,6C34, 01F4,FC,2C34
$93:B11C             dx 0008, 01F9,07,EC33, 01F1,07,AC33, 01F9,FF,6C33, 01F1,FF,2C33, 0007,F9,EC34, 01FF,F9,AC34, 0007,F1,6C34, 01FF,F1,2C34
$93:B146             dx 0008, 01F9,07,EC34, 01F1,07,AC34, 01F9,FF,6C34, 01F1,FF,2C34, 0007,F9,EC33, 01FF,F9,AC33, 0007,F1,6C33, 01FF,F1,2C33
$93:B170             dx 0008, 01F7,09,EC33, 01EF,09,AC33, 01F7,01,6C33, 01EF,01,2C33, 0009,F7,EC34, 0001,F7,AC34, 0009,EF,6C34, 0001,EF,2C34
$93:B19A             dx 0008, 01F7,09,EC34, 01EF,09,AC34, 01F7,01,6C34, 01EF,01,2C34, 0009,F7,EC33, 0001,F7,AC33, 0009,EF,6C33, 0001,EF,2C33
$93:B1C4             dx 0008, 01F6,0A,EC33, 01EE,0A,AC33, 01F6,02,6C33, 01EE,02,2C33, 000A,F6,EC34, 0002,F6,AC34, 000A,EE,6C34, 0002,EE,2C34
$93:B1EE             dx 0008, 01F6,0A,EC34, 01EE,0A,AC34, 01F6,02,6C34, 01EE,02,2C34, 000A,F6,EC33, 0002,F6,AC33, 000A,EE,6C33, 0002,EE,2C33
$93:B218             dx 0008, 01F3,FB,AC34, 01FB,FB,EC34, 01F3,F3,2C34, 01FB,F3,6C34, 01FD,05,AC33, 0005,05,EC33, 01FD,FD,2C33, 0005,FD,6C33
$93:B242             dx 0008, 01F4,FC,AC33, 01FC,FC,EC33, 01F4,F4,2C33, 01FC,F4,6C33, 01FC,04,AC34, 0004,04,EC34, 01FC,FC,2C34, 0004,FC,6C34
$93:B26C             dx 0008, 01FF,07,AC33, 0007,07,EC33, 01FF,FF,2C33, 0007,FF,6C33, 01F1,F9,AC34, 01F9,F9,EC34, 01F1,F1,2C34, 01F9,F1,6C34
$93:B296             dx 0008, 01FF,07,AC34, 0007,07,EC34, 01FF,FF,2C34, 0007,FF,6C34, 01F1,F9,AC33, 01F9,F9,EC33, 01F1,F1,2C33, 01F9,F1,6C33
$93:B2C0             dx 0008, 0001,09,AC33, 0009,09,EC33, 0001,01,2C33, 0009,01,6C33, 01EF,F7,AC34, 01F7,F7,EC34, 01EF,EF,2C34, 01F7,EF,6C34
$93:B2EA             dx 0008, 0001,09,AC34, 0009,09,EC34, 0001,01,2C34, 0009,01,6C34, 01EF,F7,AC33, 01F7,F7,EC33, 01EF,EF,2C33, 01F7,EF,6C33
$93:B314             dx 0008, 0002,0A,AC33, 000A,0A,EC33, 0002,02,2C33, 000A,02,6C33, 01EE,F6,AC34, 01F6,F6,EC34, 01EE,EE,2C34, 01F6,EE,6C34
$93:B33E             dx 0008, 0002,0A,AC34, 000A,0A,EC34, 0002,02,2C34, 000A,02,6C34, 01EE,F6,AC33, 01F6,F6,EC33, 01EE,EE,2C33, 01F6,EE,6C33
$93:B368             dx 0004, 0000,F8,6C34, 0000,00,EC34, 01F8,00,AC34, 01F8,F8,2C34 ; Unused
$93:B37E             dx 0004, 0000,F8,6C33, 0000,00,EC33, 01F8,00,AC33, 01F8,F8,2C33 ; Unused
$93:B394             dx 0008, 01F8,F8,6C34, 01F8,00,EC34, 01F0,00,AC34, 01F0,F8,2C34, 0008,00,EC33, 0000,00,AC33, 0008,F8,6C33, 0000,F8,2C33
$93:B3BE             dx 0008, 01F8,F8,6C33, 01F8,00,EC33, 01F0,00,AC33, 01F0,F8,2C33, 0008,00,EC34, 0000,00,AC34, 0008,F8,6C34, 0000,F8,2C34
$93:B3E8             dx 0008, 01F3,F8,6C34, 01F3,00,EC34, 01EB,00,AC34, 01EB,F8,2C34, 000D,00,EC33, 0005,00,AC33, 000D,F8,6C33, 0005,F8,2C33
$93:B412             dx 0008, 01F3,F8,6C33, 01F3,00,EC33, 01EB,00,AC33, 01EB,F8,2C33, 000D,00,EC34, 0005,00,AC34, 000D,F8,6C34, 0005,F8,2C34
$93:B43C             dx 0008, 01F1,F8,6C34, 01F1,00,EC34, 01E9,00,AC34, 01E9,F8,2C34, 000F,00,EC33, 0007,00,AC33, 000F,F8,6C33, 0007,F8,2C33
$93:B466             dx 0008, 01F1,F8,6C33, 01F1,00,EC33, 01E9,00,AC33, 01E9,F8,2C33, 000F,00,EC34, 0007,00,AC34, 000F,F8,6C34, 0007,F8,2C34
$93:B490             dx 0008, 01F0,F8,6C34, 01F0,00,EC34, 01E8,00,AC34, 01E8,F8,2C34, 0010,00,EC33, 0008,00,AC33, 0010,F8,6C33, 0008,F8,2C33
$93:B4BA             dx 0008, 01F0,F8,6C33, 01F0,00,EC33, 01E8,00,AC33, 01E8,F8,2C33, 0010,00,EC34, 0008,00,AC34, 0010,F8,6C34, 0008,F8,2C34

$93:B4E4             dx 0001, 01FC,FC,2C30 ; Unused
$93:B4EB             dx 0002, 01FC,04,2C37, 01FC,F4,2C30 ; Unused
$93:B4F7             dx 0002, 01FC,09,2C36, 01FC,EF,2C31 ; Unused
$93:B503             dx 0002, 01FC,0B,2C37, 01FC,ED,2C32 ; Unused
$93:B50F             dx 0002, 01FC,0C,2C35, 01FC,EC,2C30 ; Unused
$93:B51B             dx 0002, 01FC,F4,2C37, 01FC,04,2C30 ; Unused
$93:B527             dx 0002, 01FC,EF,2C35, 01FC,09,2C31 ; Unused
$93:B533             dx 0002, 01FC,0B,2C32, 01FC,ED,2C36 ; Unused
$93:B53F             dx 0002, 01FC,EC,2C37, 01FC,0C,2C30 ; Unused
$93:B54B             dx 0002, 01F6,02,2C37, 0002,F6,2C30 ; Unused
$93:B557             dx 0002, 01F3,05,2C36, 0005,F3,2C31 ; Unused
$93:B563             dx 0002, 01F1,07,2C37, 0007,F1,2C32 ; Unused
$93:B56F             dx 0002, 0008,F0,2C30, 01F0,08,2C35 ; Unused
$93:B57B             dx 0002, 0002,F6,2C35, 01F6,02,2C30 ; Unused
$93:B587             dx 0002, 0005,F3,2C36, 01F3,05,2C31 ; Unused
$93:B593             dx 0002, 0007,F1,2C37, 01F1,07,2C30 ; Unused
$93:B59F             dx 0002, 01F0,08,2C31, 0008,F0,2C35 ; Unused
$93:B5AB             dx 0002, 01F4,FC,2C37, 0004,FC,2C30 ; Unused
$93:B5B7             dx 0002, 01F1,FC,2C36, 0009,FC,2C31 ; Unused
$93:B5C3             dx 0002, 01ED,FC,2C37, 000B,FC,2C32 ; Unused
$93:B5CF             dx 0002, 000C,FC,2C35, 01EC,FC,2C31 ; Unused
$93:B5DB             dx 0002, 01F4,FC,2C30, 0004,FC,2C37 ; Unused
$93:B5E7             dx 0002, 0009,FC,2C36, 01EF,FC,2C31 ; Unused
$93:B5F3             dx 0002, 000C,FC,2C35, 01ED,FC,2C32 ; Unused
$93:B5FF             dx 0002, 01EC,FC,2C37, 000D,FC,2C30 ; Unused
$93:B60B             dx 0002, 0002,02,2C37, 01F6,F6,2C30 ; Unused
$93:B617             dx 0002, 0005,05,2C36, 01F3,F3,2C31 ; Unused
$93:B623             dx 0002, 0007,07,2C35, 01F1,F1,2C32 ; Unused
$93:B62F             dx 0002, 0008,08,2C37, 01F0,F0,2C31 ; Unused
$93:B63B             dx 0002, 01F6,F6,2C37, 0002,02,2C30 ; Unused
$93:B647             dx 0002, 01F3,F3,2C36, 0005,05,2C31 ; Unused
$93:B653             dx 0002, 01F1,F1,2C35, 0007,07,2C32 ; Unused
$93:B65F             dx 0002, 01F0,F0,2C37, 0008,08,2C30 ; Unused
$93:B66B             dx 0001, 01FC,FC,2C30 ; Unused

; Charged ice + wave
$93:B672             dx 0004, 0000,00,EC34, 01F8,00,AC34, 0000,F8,6C34, 01F8,F8,2C34
$93:B688             dx 0004, 0000,00,EC33, 01F8,00,AC33, 0000,F8,6C33, 01F8,F8,2C33
$93:B69E             dx 0008, 0000,08,EC33, 01F8,08,AC33, 0000,00,6C33, 01F8,00,2C33, 0000,F8,EC34, 01F8,F8,AC34, 0000,F0,6C34, 01F8,F0,2C34
$93:B6C8             dx 0008, 0000,08,EC34, 01F8,08,AC34, 0000,00,6C34, 01F8,00,2C34, 0000,F8,EC33, 01F8,F8,AC33, 0000,F0,6C33, 01F8,F0,2C33
$93:B6F2             dx 0008, 0000,0D,EC33, 01F8,0D,AC33, 0000,05,6C33, 01F8,05,2C33, 0000,F3,EC34, 01F8,F3,AC34, 0000,EB,6C34, 01F8,EB,2C34
$93:B71C             dx 0008, 0000,0D,EC34, 01F8,0D,AC34, 0000,05,6C34, 01F8,05,2C34, 0000,F3,EC33, 01F8,F3,AC33, 0000,EB,6C33, 01F8,EB,2C33
$93:B746             dx 0008, 0000,0F,EC33, 01F8,0F,AC33, 0000,07,6C33, 01F8,07,2C33, 0000,F1,EC34, 01F8,F1,AC34, 0000,E9,6C34, 01F8,E9,2C34
$93:B770             dx 0008, 0000,0F,EC34, 01F8,0F,AC34, 0000,07,6C34, 01F8,07,2C34, 0000,F1,EC33, 01F8,F1,AC33, 0000,E9,6C33, 01F8,E9,2C33
$93:B79A             dx 0008, 0000,10,EC33, 01F8,10,AC33, 0000,08,6C33, 01F8,08,2C33, 0000,F0,EC34, 01F8,F0,AC34, 0000,E8,6C34, 01F8,E8,2C34
$93:B7C4             dx 0008, 0000,10,EC34, 01F8,10,AC34, 0000,08,6C34, 01F8,08,2C34, 0000,F0,EC33, 01F8,F0,AC33, 0000,E8,6C33, 01F8,E8,2C33
$93:B7EE             dx 0008, 0005,FB,EC34, 01FD,FB,AC34, 0005,F3,6C34, 01FD,F3,2C34, 01FB,05,EC33, 01F3,05,AC33, 01FB,FD,6C33, 01F3,FD,2C33
$93:B818             dx 0008, 0004,FC,EC33, 01FC,FC,AC33, 0004,F4,6C33, 01FC,F4,2C33, 01FC,04,EC34, 01F4,04,AC34, 01FC,FC,6C34, 01F4,FC,2C34
$93:B842             dx 0008, 01F9,07,EC33, 01F1,07,AC33, 01F9,FF,6C33, 01F1,FF,2C33, 0007,F9,EC34, 01FF,F9,AC34, 0007,F1,6C34, 01FF,F1,2C34
$93:B86C             dx 0008, 01F9,07,EC34, 01F1,07,AC34, 01F9,FF,6C34, 01F1,FF,2C34, 0007,F9,EC33, 01FF,F9,AC33, 0007,F1,6C33, 01FF,F1,2C33
$93:B896             dx 0008, 01F7,09,EC33, 01EF,09,AC33, 01F7,01,6C33, 01EF,01,2C33, 0009,F7,EC34, 0001,F7,AC34, 0009,EF,6C34, 0001,EF,2C34
$93:B8C0             dx 0008, 01F7,09,EC34, 01EF,09,AC34, 01F7,01,6C34, 01EF,01,2C34, 0009,F7,EC33, 0001,F7,AC33, 0009,EF,6C33, 0001,EF,2C33
$93:B8EA             dx 0008, 01F6,0A,EC33, 01EE,0A,AC33, 01F6,02,6C33, 01EE,02,2C33, 000A,F6,EC34, 0002,F6,AC34, 000A,EE,6C34, 0002,EE,2C34
$93:B914             dx 0008, 01F6,0A,EC34, 01EE,0A,AC34, 01F6,02,6C34, 01EE,02,2C34, 000A,F6,EC33, 0002,F6,AC33, 000A,EE,6C33, 0002,EE,2C33
$93:B93E             dx 0008, 01F3,FB,AC34, 01FB,FB,EC34, 01F3,F3,2C34, 01FB,F3,6C34, 01FD,05,AC33, 0005,05,EC33, 01FD,FD,2C33, 0005,FD,6C33
$93:B968             dx 0008, 01F4,FC,AC33, 01FC,FC,EC33, 01F4,F4,2C33, 01FC,F4,6C33, 01FC,04,AC34, 0004,04,EC34, 01FC,FC,2C34, 0004,FC,6C34
$93:B992             dx 0008, 01FF,07,AC33, 0007,07,EC33, 01FF,FF,2C33, 0007,FF,6C33, 01F1,F9,AC34, 01F9,F9,EC34, 01F1,F1,2C34, 01F9,F1,6C34
$93:B9BC             dx 0008, 01FF,07,AC34, 0007,07,EC34, 01FF,FF,2C34, 0007,FF,6C34, 01F1,F9,AC33, 01F9,F9,EC33, 01F1,F1,2C33, 01F9,F1,6C33
$93:B9E6             dx 0008, 0001,09,AC33, 0009,09,EC33, 0001,01,2C33, 0009,01,6C33, 01EF,F7,AC34, 01F7,F7,EC34, 01EF,EF,2C34, 01F7,EF,6C34
$93:BA10             dx 0008, 0001,09,AC34, 0009,09,EC34, 0001,01,2C34, 0009,01,6C34, 01EF,F7,AC33, 01F7,F7,EC33, 01EF,EF,2C33, 01F7,EF,6C33
$93:BA3A             dx 0008, 0002,0A,AC33, 000A,0A,EC33, 0002,02,2C33, 000A,02,6C33, 01EE,F6,AC34, 01F6,F6,EC34, 01EE,EE,2C34, 01F6,EE,6C34
$93:BA64             dx 0008, 0002,0A,AC34, 000A,0A,EC34, 0002,02,2C34, 000A,02,6C34, 01EE,F6,AC33, 01F6,F6,EC33, 01EE,EE,2C33, 01F6,EE,6C33
$93:BA8E             dx 0004, 0000,F8,6C34, 0000,00,EC34, 01F8,00,AC34, 01F8,F8,2C34 ; Unused
$93:BAA4             dx 0004, 0000,F8,6C33, 0000,00,EC33, 01F8,00,AC33, 01F8,F8,2C33 ; Unused
$93:BABA             dx 0008, 01F8,F8,6C34, 01F8,00,EC34, 01F0,00,AC34, 01F0,F8,2C34, 0008,00,EC33, 0000,00,AC33, 0008,F8,6C33, 0000,F8,2C33
$93:BAE4             dx 0008, 01F8,F8,6C33, 01F8,00,EC33, 01F0,00,AC33, 01F0,F8,2C33, 0008,00,EC34, 0000,00,AC34, 0008,F8,6C34, 0000,F8,2C34
$93:BB0E             dx 0008, 01F3,F8,6C34, 01F3,00,EC34, 01EB,00,AC34, 01EB,F8,2C34, 000D,00,EC33, 0005,00,AC33, 000D,F8,6C33, 0005,F8,2C33
$93:BB38             dx 0008, 01F3,F8,6C33, 01F3,00,EC33, 01EB,00,AC33, 01EB,F8,2C33, 000D,00,EC34, 0005,00,AC34, 000D,F8,6C34, 0005,F8,2C34
$93:BB62             dx 0008, 01F1,F8,6C34, 01F1,00,EC34, 01E9,00,AC34, 01E9,F8,2C34, 000F,00,EC33, 0007,00,AC33, 000F,F8,6C33, 0007,F8,2C33
$93:BB8C             dx 0008, 01F1,F8,6C33, 01F1,00,EC33, 01E9,00,AC33, 01E9,F8,2C33, 000F,00,EC34, 0007,00,AC34, 000F,F8,6C34, 0007,F8,2C34
$93:BBB6             dx 0008, 01F0,F8,6C34, 01F0,00,EC34, 01E8,00,AC34, 01E8,F8,2C34, 0010,00,EC33, 0008,00,AC33, 0010,F8,6C33, 0008,F8,2C33
$93:BBE0             dx 0008, 01F0,F8,6C33, 01F0,00,EC33, 01E8,00,AC33, 01E8,F8,2C33, 0010,00,EC34, 0008,00,AC34, 0010,F8,6C34, 0008,F8,2C34

; (Charged) plasma + wave / plasma + ice + wave
$93:BC0A             dx 0004, 0008,FC,2C30, 0000,FC,2C30, 01F8,FC,2C30, 01F0,FC,2C30
$93:BC20             dx 0008, 0008,04,2C30, 0000,04,2C30, 01F8,04,2C30, 01F0,04,2C30, 0008,F4,2C30, 0000,F4,2C30, 01F8,F4,2C30, 01F0,F4,2C30
$93:BC4A             dx 0008, 0008,09,2C30, 0000,09,2C30, 01F8,09,2C30, 01F0,09,2C30, 0008,EF,2C30, 0000,EF,2C30, 01F8,EF,2C30, 01F0,EF,2C30
$93:BC74             dx 0008, 0008,0B,2C30, 0000,0B,2C30, 01F8,0B,2C30, 01F0,0B,2C30, 0008,ED,2C30, 0000,ED,2C30, 01F8,ED,2C30, 01F0,ED,2C30
$93:BC9E             dx 0008, 0008,0C,2C30, 0000,0C,2C30, 01F8,0C,2C30, 01F0,0C,2C30, 0008,EC,2C30, 0000,EC,2C30, 01F8,EC,2C30, 01F0,EC,2C30
$93:BCC8             dx 0007, 0014,FC,2C30, 01E4,FC,2C30, 000C,FC,2C30, 0004,FC,2C30, 01FC,FC,2C30, 01F4,FC,2C30, 01EC,FC,2C30
$93:BCED             dx 000E, 0014,04,2C30, 0014,F4,2C30, 000C,04,2C30, 01E4,04,2C30, 01E4,F4,2C30, 000C,F4,2C30, 0004,04,2C30, 01FC,04,2C30, 01F4,04,2C30, 01EC,04,2C30, 0004,F4,2C30, 01FC,F4,2C30, 01F4,F4,2C30, 01EC,F4,2C30
$93:BD35             dx 000E, 0014,09,2C30, 0014,EF,2C30, 000C,09,2C30, 01E4,09,2C30, 01E4,EF,2C30, 000C,EF,2C30, 0004,09,2C30, 01FC,09,2C30, 01F4,09,2C30, 01EC,09,2C30, 0004,EF,2C30, 01FC,EF,2C30, 01F4,EF,2C30, 01EC,EF,2C30
$93:BD7D             dx 000E, 0014,0B,2C30, 0014,ED,2C30, 000C,0B,2C30, 01E4,0B,2C30, 01E4,ED,2C30, 000C,ED,2C30, 0004,0B,2C30, 01FC,0B,2C30, 01F4,0B,2C30, 01EC,0B,2C30, 0004,ED,2C30, 01FC,ED,2C30, 01F4,ED,2C30, 01EC,ED,2C30
$93:BDC5             dx 000E, 0014,0C,2C30, 0014,EC,2C30, 000C,0C,2C30, 01E4,0C,2C30, 01E4,EC,2C30, 000C,EC,2C30, 0004,0C,2C30, 01FC,0C,2C30, 01F4,0C,2C30, 01EC,0C,2C30, 0004,EC,2C30, 01FC,EC,2C30, 01F4,EC,2C30, 01EC,EC,2C30
$93:BE0D             dx 0006, 0008,04,2C32, 0000,04,2C31, 01F8,F4,2C32, 01F0,F4,2C31, 0000,FC,2C32, 01F8,FC,2C31
$93:BE2D             dx 000C, 000F,FE,2C32, 0007,FE,2C31, 01FF,EE,2C32, 01F7,EE,2C31, 0007,F6,2C32, 01FF,F6,2C31, 0002,0A,2C32, 01FA,0A,2C31, 01F2,FA,2C32, 01EA,FA,2C31, 01FA,02,2C32, 01F2,02,2C31
$93:BE6B             dx 000C, 0012,FB,2C32, 000A,FB,2C31, 0002,EB,2C32, 01FA,EB,2C31, 000A,F3,2C32, 0002,F3,2C31, 01FF,0D,2C32, 01F7,0D,2C31, 01EF,FD,2C32, 01E7,FD,2C31, 01F7,05,2C32, 01EF,05,2C31
$93:BEA9             dx 000C, 0014,F9,2C32, 000C,F9,2C31, 0004,E9,2C32, 01FC,E9,2C31, 000C,F1,2C32, 0004,F1,2C31, 01FD,0F,2C32, 01F5,0F,2C31, 01ED,FF,2C32, 01E5,FF,2C31, 01F5,07,2C32, 01ED,07,2C31
$93:BEE7             dx 000C, 0015,F8,2C32, 000D,F8,2C31, 0005,E8,2C32, 01FD,E8,2C31, 000D,F0,2C32, 0005,F0,2C31, 01FC,10,2C32, 01F4,10,2C31, 01EC,00,2C32, 01E4,00,2C31, 01F4,08,2C32, 01EC,08,2C31
$93:BF25             dx 000A, 01F0,EC,2C32, 01E8,EC,2C31, 0010,0C,2C32, 0008,0C,2C31, 0008,04,2C32, 0000,04,2C31, 01F8,F4,2C32, 01F0,F4,2C31, 0000,FC,2C32, 01F8,FC,2C31
$93:BF59             dx 0014, 01F7,E6,2C32, 01EF,E6,2C31, 01EA,F2,2C32, 01E2,F2,2C31, 000A,12,2C32, 0002,12,2C31, 0017,06,2C32, 000F,06,2C31, 000F,FE,2C32, 0007,FE,2C31, 01FF,EE,2C32, 01F7,EE,2C31, 0007,F6,2C32, 01FF,F6,2C31, 0002,0A,2C32, 01FA,0A,2C31, 01F2,FA,2C32, 01EA,FA,2C31, 01FA,02,2C32, 01F2,02,2C31
$93:BFBF             dx 0014, 01FA,E3,2C32, 01F2,E3,2C31, 001A,03,2C32, 0012,03,2C31, 01E7,F5,2C32, 01DF,F5,2C31, 0007,15,2C32, 01FF,15,2C31, 0012,FB,2C32, 000A,FB,2C31, 0002,EB,2C32, 01FA,EB,2C31, 000A,F3,2C32, 0002,F3,2C31, 01FF,0D,2C32, 01F7,0D,2C31, 01EF,FD,2C32, 01E7,FD,2C31, 01F7,05,2C32, 01EF,05,2C31
$93:C025             dx 0014, 01E5,F7,2C32, 01DD,F7,2C31, 01FC,E1,2C32, 01F4,E1,2C31, 0005,17,2C32, 01FD,17,2C31, 001B,00,2C32, 0013,00,2C31, 0014,F9,2C32, 000C,F9,2C31, 0004,E9,2C32, 01FC,E9,2C31, 000C,F1,2C32, 0004,F1,2C31, 01FD,0F,2C32, 01F5,0F,2C31, 01ED,FF,2C32, 01E5,FF,2C31, 01F5,07,2C32, 01ED,07,2C31
$93:C08B             dx 0014, 01E4,F8,2C32, 01DC,F8,2C31, 01FD,E0,2C32, 01F5,E0,2C31, 0004,18,2C32, 01FC,18,2C31, 001D,00,2C32, 0015,00,2C31, 0015,F8,2C32, 000D,F8,2C31, 0005,E8,2C32, 01FD,E8,2C31, 000D,F0,2C32, 0005,F0,2C31, 01FC,10,2C32, 01F4,10,2C31, 01EC,00,2C32, 01E4,00,2C31, 01F4,08,2C32, 01EC,08,2C31
$93:C0F1             dx 0004, 01FC,08,2C33, 01FC,00,2C33, 01FC,F0,2C33, 01FC,F8,2C33
$93:C107             dx 0008, 0004,08,2C33, 0004,00,2C33, 0004,F0,2C33, 0004,F8,2C33, 01F5,08,2C33, 01F5,00,2C33, 01F5,F0,2C33, 01F5,F8,2C33
$93:C131             dx 0008, 0009,08,2C33, 0009,00,2C33, 0009,F0,2C33, 0009,F8,2C33, 01EF,08,2C33, 01EF,00,2C33, 01EF,F0,2C33, 01EF,F8,2C33
$93:C15B             dx 0008, 000B,08,2C33, 000B,00,2C33, 000B,F0,2C33, 000B,F8,2C33, 01EE,08,2C33, 01EE,00,2C33, 01EE,F0,2C33, 01EE,F8,2C33
$93:C185             dx 0008, 000C,08,2C33, 000C,00,2C33, 000C,F0,2C33, 000C,F8,2C33, 01ED,08,2C33, 01ED,00,2C33, 01ED,F0,2C33, 01ED,F8,2C33
$93:C1AF             dx 0007, 01FC,14,2C33, 01FC,0C,2C33, 01FC,E4,2C33, 01FC,04,2C33, 01FC,FC,2C33, 01FC,EC,2C33, 01FC,F4,2C33
$93:C1D4             dx 000E, 0004,14,2C33, 0004,0C,2C33, 01F5,14,2C33, 01F5,0C,2C33, 01F5,E4,2C33, 0004,E4,2C33, 0004,04,2C33, 0004,FC,2C33, 0004,EC,2C33, 0004,F4,2C33, 01F5,04,2C33, 01F5,FC,2C33, 01F5,EC,2C33, 01F5,F4,2C33
$93:C21C             dx 000E, 01EF,14,2C33, 01EF,0C,2C33, 0009,14,2C33, 0009,0C,2C33, 0009,E4,2C33, 01EF,E4,2C33, 0009,04,2C33, 0009,FC,2C33, 0009,EC,2C33, 0009,F4,2C33, 01EF,04,2C33, 01EF,FC,2C33, 01EF,EC,2C33, 01EF,F4,2C33
$93:C264             dx 000E, 01EE,14,2C33, 01EE,0C,2C33, 000B,14,2C33, 000B,0C,2C33, 000B,E4,2C33, 01EE,E4,2C33, 000B,04,2C33, 000B,FC,2C33, 000B,EC,2C33, 000B,F4,2C33, 01EE,04,2C33, 01EE,FC,2C33, 01EE,EC,2C33, 01EE,F4,2C33
$93:C2AC             dx 000E, 01ED,14,2C33, 01ED,0C,2C33, 000C,14,2C33, 000C,0C,2C33, 000C,E4,2C33, 01ED,E4,2C33, 000C,04,2C33, 000C,FC,2C33, 000C,EC,2C33, 000C,F4,2C33, 01ED,04,2C33, 01ED,FC,2C33, 01ED,EC,2C33, 01ED,F4,2C33
$93:C2F4             dx 0004, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34 ; Unused
$93:C30A             dx 0008, 0008,04,2C34, 0000,04,2C34, 01F8,04,2C34, 01F0,04,2C34, 0008,F4,2C34, 0000,F4,2C34, 01F8,F4,2C34, 01F0,F4,2C34 ; Unused
$93:C334             dx 0008, 0008,09,2C34, 0000,09,2C34, 01F8,09,2C34, 01F0,09,2C34, 0008,EF,2C34, 0000,EF,2C34, 01F8,EF,2C34, 01F0,EF,2C34 ; Unused
$93:C35E             dx 0008, 0008,0B,2C34, 0000,0B,2C34, 01F8,0B,2C34, 01F0,0B,2C34, 0008,ED,2C34, 0000,ED,2C34, 01F8,ED,2C34, 01F0,ED,2C34 ; Unused
$93:C388             dx 0008, 0008,0C,2C34, 0000,0C,2C34, 01F8,0C,2C34, 01F0,0C,2C34, 0008,EC,2C34, 0000,EC,2C34, 01F8,EC,2C34, 01F0,EC,2C34 ; Unused
$93:C3B2             dx 0007, 0014,FC,2C34, 01E4,FC,2C34, 000C,FC,2C34, 0004,FC,2C34, 01FC,FC,2C34, 01F4,FC,2C34, 01EC,FC,2C34
$93:C3D7             dx 000E, 0014,04,2C34, 0014,F4,2C34, 000C,04,2C34, 01E4,04,2C34, 01E4,F4,2C34, 000C,F4,2C34, 0004,04,2C34, 01FC,04,2C34, 01F4,04,2C34, 01EC,04,2C34, 0004,F4,2C34, 01FC,F4,2C34, 01F4,F4,2C34, 01EC,F4,2C34
$93:C41F             dx 000E, 0014,09,2C34, 0014,EF,2C34, 000C,09,2C34, 01E4,09,2C34, 01E4,EF,2C34, 000C,EF,2C34, 0004,09,2C34, 01FC,09,2C34, 01F4,09,2C34, 01EC,09,2C34, 0004,EF,2C34, 01FC,EF,2C34, 01F4,EF,2C34, 01EC,EF,2C34
$93:C467             dx 000E, 0014,0B,2C34, 0014,ED,2C34, 000C,0B,2C34, 01E4,0B,2C34, 01E4,ED,2C34, 000C,ED,2C34, 0004,0B,2C34, 01FC,0B,2C34, 01F4,0B,2C34, 01EC,0B,2C34, 0004,ED,2C34, 01FC,ED,2C34, 01F4,ED,2C34, 01EC,ED,2C34
$93:C4AF             dx 000E, 0014,0C,2C34, 0014,EC,2C34, 000C,0C,2C34, 01E4,0C,2C34, 01E4,EC,2C34, 000C,EC,2C34, 0004,0C,2C34, 01FC,0C,2C34, 01F4,0C,2C34, 01EC,0C,2C34, 0004,EC,2C34, 01FC,EC,2C34, 01F4,EC,2C34, 01EC,EC,2C34
$93:C4F7             dx 0008, 0008,0C,EC36, 01F0,EC,2C36, 0008,04,EC35, 0000,FC,EC35, 01F8,F4,EC35, 0000,04,2C35, 01F0,F4,2C35, 01F8,FC,2C35 ; Unused
$93:C521             dx 0010, 000F,06,EC36, 0002,12,EC36, 01F7,E6,2C36, 01EA,F2,2C36, 01FF,EE,EC35, 0007,F6,EC35, 000F,FE,EC35, 0002,0A,EC35, 01FA,02,EC35, 01F2,FA,EC35, 0007,FE,2C35, 01F7,EE,2C35, 01FF,F6,2C35, 01FA,0A,2C35, 01EA,FA,2C35, 01F2,02,2C35 ; Unused
$93:C573             dx 0010, 01FF,15,EC36, 0012,03,EC36, 01E7,F5,2C36, 01FA,E3,2C36, 0012,FB,EC35, 000A,F3,EC35, 0002,EB,EC35, 01FF,0D,EC35, 01F7,05,EC35, 01EF,FD,EC35, 000A,FB,2C35, 01FA,EB,2C35, 0002,F3,2C35, 01F7,0D,2C35, 01E7,FD,2C35, 01EF,05,2C35 ; Unused
$93:C5C5             dx 0010, 01FD,17,EC36, 0014,01,EC36, 01E5,F7,2C36, 01FC,E1,2C36, 0014,F9,EC35, 000C,F1,EC35, 0004,E9,EC35, 01FD,0F,EC35, 01F5,07,EC35, 01ED,FF,EC35, 000C,F9,2C35, 01FC,E9,2C35, 0004,F1,2C35, 01F5,0F,2C35, 01E5,FF,2C35, 01ED,07,2C35 ; Unused
$93:C617             dx 0010, 01FC,18,EC36, 0015,00,EC36, 01FD,E0,2C36, 01E4,F8,2C36, 0015,F8,EC35, 000D,F0,EC35, 0005,E8,EC35, 01FC,10,EC35, 01F4,08,EC35, 01EC,00,EC35, 000D,F8,2C35, 01FD,E8,2C35, 0005,F0,2C35, 01F4,10,2C35, 01E4,00,2C35, 01EC,08,2C35 ; Unused
$93:C669             dx 000C, 0010,14,EC36, 01E8,E4,2C36, 0010,0C,EC35, 0008,04,EC35, 0000,FC,EC35, 01F8,F4,EC35, 01F0,EC,EC35, 01E8,EC,2C35, 0008,0C,2C35, 0000,04,2C35, 01F0,F4,2C35, 01F8,FC,2C35
$93:C6A7             dx 0018, 000A,1A,EC36, 0017,0E,EC36, 01E2,EA,2C36, 01EF,DE,2C36, 01F7,E6,EC35, 01FF,EE,EC35, 0007,F6,EC35, 000F,FE,EC35, 0017,06,EC35, 000A,12,EC35, 0002,0A,EC35, 01FA,02,EC35, 01F2,FA,EC35, 01EA,F2,EC35, 01EF,E6,2C35, 01E2,F2,2C35, 0002,12,2C35, 000F,06,2C35, 0007,FE,2C35, 01F7,EE,2C35, 01FF,F6,2C35, 01FA,0A,2C35, 01EA,FA,2C35, 01F2,02,2C35
$93:C721             dx 0018, 01DF,ED,2C36, 01F2,DB,2C36, 0007,1D,EC36, 001A,0B,EC36, 01FA,E3,EC35, 0002,EB,EC35, 000A,F3,EC35, 0012,FB,EC35, 001A,03,EC35, 0007,15,EC35, 01FF,0D,EC35, 01F7,05,EC35, 01EF,FD,EC35, 01E7,F5,EC35, 01F2,E3,2C35, 0012,03,2C35, 01DF,F5,2C35, 01FF,15,2C35, 000A,FB,2C35, 01FA,EB,2C35, 0002,F3,2C35, 01F7,0D,2C35, 01E7,FD,2C35, 01EF,05,2C35
$93:C79B             dx 0018, 01DD,EF,2C36, 01F4,D9,2C36, 0005,1F,EC36, 001B,08,EC36, 01FC,E1,EC35, 0004,E9,EC35, 000C,F1,EC35, 0014,F9,EC35, 001B,00,EC35, 0005,17,EC35, 01FD,0F,EC35, 01F5,07,EC35, 01ED,FF,EC35, 01E5,F7,EC35, 01DD,F7,2C35, 01F4,E1,2C35, 01FD,17,2C35, 0013,00,2C35, 000C,F9,2C35, 01FC,E9,2C35, 0004,F1,2C35, 01F5,0F,2C35, 01E5,FF,2C35, 01ED,07,2C35
$93:C815             dx 0018, 0004,20,EC36, 001D,08,EC36, 01DC,F0,2C36, 01F5,D8,2C36, 01E4,F8,EC35, 01EC,00,EC35, 01F4,08,EC35, 01FC,10,EC35, 0004,18,EC35, 001D,00,EC35, 0015,F8,EC35, 000D,F0,EC35, 0005,E8,EC35, 01FD,E0,EC35, 01DC,F8,2C35, 01F5,E0,2C35, 01FC,18,2C35, 0015,00,2C35, 000D,F8,2C35, 01FD,E8,2C35, 0005,F0,2C35, 01F4,10,2C35, 01E4,00,2C35, 01EC,08,2C35
$93:C88F             dx 0004, 01FC,08,2C37, 01FC,00,2C37, 01FC,F0,2C37, 01FC,F8,2C37 ; Unused
$93:C8A5             dx 0008, 0004,08,2C37, 0004,00,2C37, 0004,F0,2C37, 0004,F8,2C37, 01F5,08,2C37, 01F5,00,2C37, 01F5,F0,2C37, 01F5,F8,2C37 ; Unused
$93:C8CF             dx 0008, 0009,08,2C37, 0009,00,2C37, 0009,F0,2C37, 0009,F8,2C37, 01EF,08,2C37, 01EF,00,2C37, 01EF,F0,2C37, 01EF,F8,2C37 ; Unused
$93:C8F9             dx 0008, 000B,08,2C37, 000B,00,2C37, 000B,F0,2C37, 000B,F8,2C37, 01EE,08,2C37, 01EE,00,2C37, 01EE,F0,2C37, 01EE,F8,2C37 ; Unused
$93:C923             dx 0008, 000C,08,2C37, 000C,00,2C37, 000C,F0,2C37, 000C,F8,2C37, 01ED,08,2C37, 01ED,00,2C37, 01ED,F0,2C37, 01ED,F8,2C37 ; Unused
$93:C94D             dx 0007, 01FC,14,2C37, 01FC,0C,2C37, 01FC,E4,2C37, 01FC,04,2C37, 01FC,FC,2C37, 01FC,EC,2C37, 01FC,F4,2C37
$93:C972             dx 000E, 0004,14,2C37, 0004,0C,2C37, 01F5,14,2C37, 01F5,0C,2C37, 01F5,E4,2C37, 0004,E4,2C37, 0004,04,2C37, 0004,FC,2C37, 0004,EC,2C37, 0004,F4,2C37, 01F5,04,2C37, 01F5,FC,2C37, 01F5,EC,2C37, 01F5,F4,2C37
$93:C9BA             dx 000E, 01EF,14,2C37, 01EF,0C,2C37, 0009,14,2C37, 0009,0C,2C37, 0009,E4,2C37, 01EF,E4,2C37, 0009,04,2C37, 0009,FC,2C37, 0009,EC,2C37, 0009,F4,2C37, 01EF,04,2C37, 01EF,FC,2C37, 01EF,EC,2C37, 01EF,F4,2C37
$93:CA02             dx 000E, 01EE,14,2C37, 01EE,0C,2C37, 000B,14,2C37, 000B,0C,2C37, 000B,E4,2C37, 01EE,E4,2C37, 000B,04,2C37, 000B,FC,2C37, 000B,EC,2C37, 000B,F4,2C37, 01EE,04,2C37, 01EE,FC,2C37, 01EE,EC,2C37, 01EE,F4,2C37
$93:CA4A             dx 000E, 01ED,14,2C37, 01ED,0C,2C37, 000C,14,2C37, 000C,0C,2C37, 000C,E4,2C37, 01ED,E4,2C37, 000C,04,2C37, 000C,FC,2C37, 000C,EC,2C37, 000C,F4,2C37, 01ED,04,2C37, 01ED,FC,2C37, 01ED,EC,2C37, 01ED,F4,2C37
$93:CA92             dx 0008, 01F0,0C,AC36, 0008,EC,6C36, 01F0,04,AC35, 01F8,FC,AC35, 0000,F4,AC35, 01F8,04,6C35, 0008,F4,6C35, 0000,FC,6C35 ; Unused
$93:CABC             dx 0010, 01E9,06,AC36, 01F6,12,AC36, 0001,E6,6C36, 000E,F2,6C36, 01F9,EE,AC35, 01F1,F6,AC35, 01E9,FE,AC35, 01F6,0A,AC35, 01FE,02,AC35, 0006,FA,AC35, 01F1,FE,6C35, 0001,EE,6C35, 01F9,F6,6C35, 01FE,0A,6C35, 000E,FA,6C35, 0006,02,6C35 ; Unused
$93:CB0E             dx 0010, 01F9,15,AC36, 01E6,03,AC36, 0011,F5,6C36, 01FE,E3,6C36, 01E6,FB,AC35, 01EE,F3,AC35, 01F6,EB,AC35, 01F9,0D,AC35, 0001,05,AC35, 0009,FD,AC35, 01EE,FB,6C35, 01FE,EB,6C35, 01F6,F3,6C35, 0001,0D,6C35, 0011,FD,6C35, 0009,05,6C35 ; Unused
$93:CB60             dx 0010, 01FB,17,AC36, 01E4,01,AC36, 0013,F7,6C36, 01FC,E1,6C36, 01E4,F9,AC35, 01EC,F1,AC35, 01F4,E9,AC35, 01FB,0F,AC35, 0003,07,AC35, 000B,FF,AC35, 01EC,F9,6C35, 01FC,E9,6C35, 01F4,F1,6C35, 0003,0F,6C35, 0013,FF,6C35, 000B,07,6C35 ; Unused
$93:CBB2             dx 0010, 01FC,18,AC36, 01E3,00,AC36, 01FB,E0,6C36, 0014,F8,6C36, 01E3,F8,AC35, 01EB,F0,AC35, 01F3,E8,AC35, 01FC,10,AC35, 0004,08,AC35, 000C,00,AC35, 01EB,F8,6C35, 01FB,E8,6C35, 01F3,F0,6C35, 0004,10,6C35, 0014,00,6C35, 000C,08,6C35 ; Unused
$93:CC04             dx 000C, 01E8,14,AC36, 0010,E4,6C36, 01E8,0C,AC35, 01F0,04,AC35, 01F8,FC,AC35, 0000,F4,AC35, 0008,EC,AC35, 0010,EC,6C35, 01F0,0C,6C35, 01F8,04,6C35, 0008,F4,6C35, 0000,FC,6C35
$93:CC42             dx 0018, 01EE,1A,AC36, 01E1,0E,AC36, 0016,EA,6C36, 0009,DE,6C36, 0001,E6,AC35, 01F9,EE,AC35, 01F1,F6,AC35, 01E9,FE,AC35, 01E1,06,AC35, 01EE,12,AC35, 01F6,0A,AC35, 01FE,02,AC35, 0006,FA,AC35, 000E,F2,AC35, 0009,E6,6C35, 0016,F2,6C35, 01F6,12,6C35, 01E9,06,6C35, 01F1,FE,6C35, 0001,EE,6C35, 01F9,F6,6C35, 01FE,0A,6C35, 000E,FA,6C35, 0006,02,6C35
$93:CCBC             dx 0018, 0019,ED,6C36, 0006,DB,6C36, 01F1,1D,AC36, 01DE,0B,AC36, 01FE,E3,AC35, 01F6,EB,AC35, 01EE,F3,AC35, 01E6,FB,AC35, 01DE,03,AC35, 01F1,15,AC35, 01F9,0D,AC35, 0001,05,AC35, 0009,FD,AC35, 0011,F5,AC35, 0006,E3,6C35, 01E6,03,6C35, 0019,F5,6C35, 01F9,15,6C35, 01EE,FB,6C35, 01FE,EB,6C35, 01F6,F3,6C35, 0001,0D,6C35, 0011,FD,6C35, 0009,05,6C35
$93:CD36             dx 0018, 001B,EF,6C36, 0004,D9,6C36, 01F3,1F,AC36, 01DD,08,AC36, 01FC,E1,AC35, 01F4,E9,AC35, 01EC,F1,AC35, 01E4,F9,AC35, 01DD,00,AC35, 01F3,17,AC35, 01FB,0F,AC35, 0003,07,AC35, 000B,FF,AC35, 0013,F7,AC35, 001B,F7,6C35, 0004,E1,6C35, 01FB,17,6C35, 01E5,00,6C35, 01EC,F9,6C35, 01FC,E9,6C35, 01F4,F1,6C35, 0003,0F,6C35, 0013,FF,6C35, 000B,07,6C35
$93:CDB0             dx 0018, 01F4,20,AC36, 01DB,08,AC36, 001C,F0,6C36, 0003,D8,6C36, 0014,F8,AC35, 000C,00,AC35, 0004,08,AC35, 01FC,10,AC35, 01F4,18,AC35, 01DB,00,AC35, 01E3,F8,AC35, 01EB,F0,AC35, 01F3,E8,AC35, 01FB,E0,AC35, 001C,F8,6C35, 0003,E0,6C35, 01FC,18,6C35, 01E3,00,6C35, 01EB,F8,6C35, 01FB,E8,6C35, 01F3,F0,6C35, 0004,10,6C35, 0014,00,6C35, 000C,08,6C35
$93:CE2A             dx 0006, 01F0,04,6C32, 01F8,04,6C31, 0000,F4,6C32, 0008,F4,6C31, 01F8,FC,6C32, 0000,FC,6C31
$93:CE4A             dx 000C, 01E9,FE,6C32, 01F1,FE,6C31, 01F9,EE,6C32, 0001,EE,6C31, 01F1,F6,6C32, 01F9,F6,6C31, 01F6,0A,6C32, 01FE,0A,6C31, 0006,FA,6C32, 000E,FA,6C31, 01FE,02,6C32, 0006,02,6C31
$93:CE88             dx 000C, 01E6,FB,6C32, 01EE,FB,6C31, 01F6,EB,6C32, 01FE,EB,6C31, 01EE,F3,6C32, 01F6,F3,6C31, 01F9,0D,6C32, 0001,0D,6C31, 0009,FD,6C32, 0011,FD,6C31, 0001,05,6C32, 0009,05,6C31
$93:CEC6             dx 000C, 01E4,F9,6C32, 01EC,F9,6C31, 01F4,E9,6C32, 01FC,E9,6C31, 01EC,F1,6C32, 01F4,F1,6C31, 01FB,0F,6C32, 0003,0F,6C31, 000B,FF,6C32, 0013,FF,6C31, 0003,07,6C32, 000B,07,6C31
$93:CF04             dx 000C, 01E3,F8,6C32, 01EB,F8,6C31, 01F3,E8,6C32, 01FB,E8,6C31, 01EB,F0,6C32, 01F3,F0,6C31, 01FC,10,6C32, 0004,10,6C31, 000C,00,6C32, 0014,00,6C31, 0004,08,6C32, 000C,08,6C31
$93:CF42             dx 000A, 0008,EC,6C32, 0010,EC,6C31, 01E8,0C,6C32, 01F0,0C,6C31, 01F0,04,6C32, 01F8,04,6C31, 0000,F4,6C32, 0008,F4,6C31, 01F8,FC,6C32, 0000,FC,6C31
$93:CF76             dx 0014, 0001,E6,6C32, 0009,E6,6C31, 000E,F2,6C32, 0016,F2,6C31, 01EE,12,6C32, 01F6,12,6C31, 01E1,06,6C32, 01E9,06,6C31, 01E9,FE,6C32, 01F1,FE,6C31, 01F9,EE,6C32, 0001,EE,6C31, 01F1,F6,6C32, 01F9,F6,6C31, 01F6,0A,6C32, 01FE,0A,6C31, 0006,FA,6C32, 000E,FA,6C31, 01FE,02,6C32, 0006,02,6C31
$93:CFDC             dx 0014, 01FE,E3,6C32, 0006,E3,6C31, 01DE,03,6C32, 01E6,03,6C31, 0011,F5,6C32, 0019,F5,6C31, 01F1,15,6C32, 01F9,15,6C31, 01E6,FB,6C32, 01EE,FB,6C31, 01F6,EB,6C32, 01FE,EB,6C31, 01EE,F3,6C32, 01F6,F3,6C31, 01F9,0D,6C32, 0001,0D,6C31, 0009,FD,6C32, 0011,FD,6C31, 0001,05,6C32, 0009,05,6C31
$93:D042             dx 0014, 0013,F7,6C32, 001B,F7,6C31, 01FC,E1,6C32, 0004,E1,6C31, 01F3,17,6C32, 01FB,17,6C31, 01DD,00,6C32, 01E5,00,6C31, 01E4,F9,6C32, 01EC,F9,6C31, 01F4,E9,6C32, 01FC,E9,6C31, 01EC,F1,6C32, 01F4,F1,6C31, 01FB,0F,6C32, 0003,0F,6C31, 000B,FF,6C32, 0013,FF,6C31, 0003,07,6C32, 000B,07,6C31
$93:D0A8             dx 0014, 0014,F8,6C32, 001C,F8,6C31, 01FB,E0,6C32, 0003,E0,6C31, 01F4,18,6C32, 01FC,18,6C31, 01DB,00,6C32, 01E3,00,6C31, 01E3,F8,6C32, 01EB,F8,6C31, 01F3,E8,6C32, 01FB,E8,6C31, 01EB,F0,6C32, 01F3,F0,6C31, 01FC,10,6C32, 0004,10,6C31, 000C,00,6C32, 0014,00,6C31, 0004,08,6C32, 000C,08,6C31

; Spazer / spazer + ice / spazer + wave / spazer + ice + wave
$93:D10E             dx 0004, 01F2,00,6C32, 01FA,00,6C31, 01FA,F8,6C32, 0002,F8,6C31
$93:D124             dx 000C, 01F2,00,6C32, 01FA,00,6C31, 01FA,F8,6C32, 0002,F8,6C31, 01EC,FA,6C32, 01F4,FA,6C31, 01F4,F2,6C32, 01FC,F2,6C31, 01F8,06,6C32, 0000,06,6C31, 0000,FE,6C32, 0008,FE,6C31
$93:D162             dx 000C, 01F2,00,6C32, 01FA,00,6C31, 01FA,F8,6C32, 0002,F8,6C31, 01E9,F7,6C32, 01F1,F7,6C31, 01F1,EF,6C32, 01F9,EF,6C31, 01FB,09,6C32, 0003,09,6C31, 0003,01,6C32, 000B,01,6C31
$93:D1A0             dx 000C, 01F2,00,6C32, 01FA,00,6C31, 01FA,F8,6C32, 0002,F8,6C31, 01E7,F5,6C32, 01EF,F5,6C31, 01EF,ED,6C32, 01F7,ED,6C31, 01FD,0B,6C32, 0005,0B,6C31, 0005,03,6C32, 000D,03,6C31
$93:D1DE             dx 000C, 01F2,00,6C32, 01FA,00,6C31, 01FA,F8,6C32, 0002,F8,6C31, 01E6,F4,6C32, 01EE,F4,6C31, 01EE,EC,6C32, 01F6,EC,6C31, 01FE,0C,6C32, 0006,0C,6C31, 0006,04,6C32, 000E,04,6C31
$93:D21C             dx 000C, 01EF,FE,6C32, 01F7,FE,6C31, 01F7,F6,6C32, 01FF,F6,6C31, 01F4,03,6C32, 01FC,03,6C31, 01FC,FB,6C32, 0004,FB,6C31, 01F2,00,6C32, 01FA,00,6C31, 01FA,F8,6C32, 0002,F8,6C31
$93:D25A             dx 0004, 01F2,F8,EC32, 01FA,F8,EC31, 01FA,00,EC32, 0002,00,EC31
$93:D270             dx 000C, 01F2,F8,EC32, 01FA,F8,EC31, 01FA,00,EC32, 0002,00,EC31, 01EC,FE,EC32, 01F4,FE,EC31, 01F4,06,EC32, 01FC,06,EC31, 01F8,F2,EC32, 0000,F2,EC31, 0000,FA,EC32, 0008,FA,EC31
$93:D2AE             dx 000C, 01F2,F8,EC32, 01FA,F8,EC31, 01FA,00,EC32, 0002,00,EC31, 01E9,01,EC32, 01F1,01,EC31, 01F1,09,EC32, 01F9,09,EC31, 01FB,EF,EC32, 0003,EF,EC31, 0003,F7,EC32, 000B,F7,EC31
$93:D2EC             dx 000C, 01F2,F8,EC32, 01FA,F8,EC31, 01FA,00,EC32, 0002,00,EC31, 01E7,03,EC32, 01EF,03,EC31, 01EF,0B,EC32, 01F7,0B,EC31, 01FD,ED,EC32, 0005,ED,EC31, 0005,F5,EC32, 000D,F5,EC31
$93:D32A             dx 000C, 01F2,F8,EC32, 01FA,F8,EC31, 01FA,00,EC32, 0002,00,EC31, 01E6,04,EC32, 01EE,04,EC31, 01EE,0C,EC32, 01F6,0C,EC31, 01FE,EC,EC32, 0006,EC,EC31, 0006,F4,EC32, 000E,F4,EC31
$93:D368             dx 000C, 01EF,FA,EC32, 01F7,FA,EC31, 01F7,02,EC32, 01FF,02,EC31, 01F4,F5,EC32, 01FC,F5,EC31, 01FC,FD,EC32, 0004,FD,EC31, 01F2,F8,EC32, 01FA,F8,EC31, 01FA,00,EC32, 0002,00,EC31
$93:D3A6             dx 0004, 0006,F8,AC32, 01FE,F8,AC31, 01FE,00,AC32, 01F6,00,AC31
$93:D3BC             dx 000C, 0006,F8,AC32, 01FE,F8,AC31, 01FE,00,AC32, 01F6,00,AC31, 000C,FE,AC32, 0004,FE,AC31, 0004,06,AC32, 01FC,06,AC31, 0000,F2,AC32, 01F8,F2,AC31, 01F8,FA,AC32, 01F0,FA,AC31
$93:D3FA             dx 000C, 0006,F8,AC32, 01FE,F8,AC31, 01FE,00,AC32, 01F6,00,AC31, 000F,01,AC32, 0007,01,AC31, 0007,09,AC32, 01FF,09,AC31, 01FD,EF,AC32, 01F5,EF,AC31, 01F5,F7,AC32, 01ED,F7,AC31
$93:D438             dx 000C, 0006,F8,AC32, 01FE,F8,AC31, 01FE,00,AC32, 01F6,00,AC31, 0011,03,AC32, 0009,03,AC31, 0009,0B,AC32, 0001,0B,AC31, 01FB,ED,AC32, 01F3,ED,AC31, 01F3,F5,AC32, 01EB,F5,AC31
$93:D476             dx 000C, 0006,F8,AC32, 01FE,F8,AC31, 01FE,00,AC32, 01F6,00,AC31, 0012,04,AC32, 000A,04,AC31, 000A,0C,AC32, 0002,0C,AC31, 01FA,EC,AC32, 01F2,EC,AC31, 01F2,F4,AC32, 01EA,F4,AC31
$93:D4B4             dx 000C, 0009,FA,AC32, 0001,FA,AC31, 0001,02,AC32, 01F9,02,AC31, 0004,F5,AC32, 01FC,F5,AC31, 01FC,FD,AC32, 01F4,FD,AC31, 0006,F8,AC32, 01FE,F8,AC31, 01FE,00,AC32, 01F6,00,AC31 ; Unused
$93:D4F2             dx 0004, 0006,00,2C32, 01FE,00,2C31, 01FE,F8,2C32, 01F6,F8,2C31
$93:D508             dx 000C, 0006,00,2C32, 01FE,00,2C31, 01FE,F8,2C32, 01F6,F8,2C31, 000C,FA,2C32, 0004,FA,2C31, 0004,F2,2C32, 01FC,F2,2C31, 0000,06,2C32, 01F8,06,2C31, 01F8,FE,2C32, 01F0,FE,2C31
$93:D546             dx 000C, 0006,00,2C32, 01FE,00,2C31, 01FE,F8,2C32, 01F6,F8,2C31, 000F,F7,2C32, 0007,F7,2C31, 0007,EF,2C32, 01FF,EF,2C31, 01FD,09,2C32, 01F5,09,2C31, 01F5,01,2C32, 01ED,01,2C31
$93:D584             dx 000C, 0006,00,2C32, 01FE,00,2C31, 01FE,F8,2C32, 01F6,F8,2C31, 0011,F5,2C32, 0009,F5,2C31, 0009,ED,2C32, 0001,ED,2C31, 01FB,0B,2C32, 01F3,0B,2C31, 01F3,03,2C32, 01EB,03,2C31
$93:D5C2             dx 000C, 0006,00,2C32, 01FE,00,2C31, 01FE,F8,2C32, 01F6,F8,2C31, 0012,F4,2C32, 000A,F4,2C31, 000A,EC,2C32, 0002,EC,2C31, 01FA,0C,2C32, 01F2,0C,2C31, 01F2,04,2C32, 01EA,04,2C31
$93:D600             dx 000C, 0009,FE,2C32, 0001,FE,2C31, 0001,F6,2C32, 01F9,F6,2C31, 0004,03,2C32, 01FC,03,2C31, 01FC,FB,2C32, 01F4,FB,2C31, 0006,00,2C32, 01FE,00,2C31, 01FE,F8,2C32, 01F6,F8,2C31
$93:D63E             dx 0002, 01FC,F8,AC33, 01FC,00,AC33
$93:D64A             dx 0006, 0000,F8,AC33, 0000,00,AC33, 01F8,F8,AC33, 01F8,00,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:D66A             dx 0006, 0004,F8,AC33, 0004,00,AC33, 01F4,F8,AC33, 01F4,00,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:D68A             dx 0006, 0009,F8,AC33, 0009,00,AC33, 01EF,F8,AC33, 01EF,00,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:D6AA             dx 0006, 000B,F8,AC33, 000B,00,AC33, 01ED,F8,AC33, 01ED,00,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:D6CA             dx 0006, 000C,F8,AC33, 000C,00,AC33, 01EC,F8,AC33, 01EC,00,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:D6EA             dx 0002, 0000,FC,2C30, 01F8,FC,2C30
$93:D6F6             dx 0006, 0000,00,2C30, 01F8,00,2C30, 0000,FC,2C30, 01F8,FC,2C30, 0000,F8,2C30, 01F8,F8,2C30
$93:D716             dx 0006, 0000,F4,2C30, 0000,FC,2C30, 0000,04,2C30, 01F8,04,2C30, 01F8,FC,2C30, 01F8,F4,2C30
$93:D736             dx 0006, 0000,EF,2C30, 0000,FC,2C30, 0000,09,2C30, 01F8,09,2C30, 01F8,FC,2C30, 01F8,EF,2C30
$93:D756             dx 0006, 0000,ED,2C30, 0000,FC,2C30, 0000,0B,2C30, 01F8,0B,2C30, 01F8,FC,2C30, 01F8,ED,2C30
$93:D776             dx 0006, 0000,EC,2C30, 0000,FC,2C30, 0000,0C,2C30, 01F8,0C,2C30, 01F8,FC,2C30, 01F8,EC,2C30
$93:D796             dx 0002, 01FC,00,2C33, 01FC,F8,2C33
$93:D7A2             dx 0006, 0000,00,2C33, 0000,F8,2C33, 01F8,00,2C33, 01F8,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:D7C2             dx 0006, 0004,00,2C33, 0004,F8,2C33, 01F4,00,2C33, 01F4,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:D7E2             dx 0006, 0009,00,2C33, 0009,F8,2C33, 01EF,00,2C33, 01EF,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:D802             dx 0006, 000B,00,2C33, 000B,F8,2C33, 01ED,00,2C33, 01ED,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:D822             dx 0006, 000C,00,2C33, 000C,F8,2C33, 01EC,00,2C33, 01EC,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:D842             dx 0002, 01F8,FC,6C30, 0000,FC,6C30
$93:D84E             dx 0006, 0000,00,2C30, 01F8,00,2C30, 0000,FC,2C30, 01F8,FC,2C30, 0000,F8,2C30, 01F8,F8,2C30
$93:D86E             dx 0006, 01F8,F4,6C30, 01F8,FC,6C30, 01F8,04,6C30, 0000,04,6C30, 0000,FC,6C30, 0000,F4,6C30
$93:D88E             dx 0006, 01F8,EF,6C30, 01F8,FC,6C30, 01F8,09,6C30, 0000,09,6C30, 0000,FC,6C30, 0000,EF,6C30
$93:D8AE             dx 0006, 01F8,ED,6C30, 01F8,FC,6C30, 01F8,0B,6C30, 0000,0B,6C30, 0000,FC,6C30, 0000,ED,6C30
$93:D8CE             dx 0006, 01F8,EC,6C30, 01F8,FC,6C30, 01F8,0C,6C30, 0000,0C,6C30, 0000,FC,6C30, 0000,EC,6C30

; Charged spazer / spazer + ice / spazer + wave / spazer + ice + wave
$93:D8EE             dx 0004, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34
$93:D904             dx 000C, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34, 0008,00,2C34, 0000,00,2C34, 01F8,00,2C34, 01F0,00,2C34, 0008,F8,2C34, 0000,F8,2C34, 01F8,F8,2C34, 01F0,F8,2C34
$93:D942             dx 000C, 0008,04,2C34, 0000,04,2C34, 01F8,04,2C34, 01F0,04,2C34, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34, 0008,F4,2C34, 0000,F4,2C34, 01F8,F4,2C34, 01F0,F4,2C34
$93:D980             dx 000C, 0008,09,2C34, 0000,09,2C34, 01F8,09,2C34, 01F0,09,2C34, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34, 0008,EF,2C34, 0000,EF,2C34, 01F8,EF,2C34, 01F0,EF,2C34
$93:D9BE             dx 000C, 0008,0B,2C34, 0000,0B,2C34, 01F8,0B,2C34, 01F0,0B,2C34, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34, 0008,ED,2C34, 0000,ED,2C34, 01F8,ED,2C34, 01F0,ED,2C34
$93:D9FC             dx 000C, 0008,0C,2C34, 0000,0C,2C34, 01F8,0C,2C34, 01F0,0C,2C34, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34, 0008,EC,2C34, 0000,EC,2C34, 01F8,EC,2C34, 01F0,EC,2C34
$93:DA3A             dx 0004, 01FC,F0,2C37, 01FC,08,2C37, 01FC,00,2C37, 01FC,F8,2C37
$93:DA50             dx 000C, 01FC,F0,2C37, 01FC,F8,2C37, 01FC,00,2C37, 01FC,08,2C37, 0000,08,2C37, 0000,00,2C37, 0000,F8,2C37, 0000,F0,2C37, 01F8,F0,2C37, 01F8,08,2C37, 01F8,00,2C37, 01F8,F8,2C37
$93:DA8E             dx 000C, 0008,08,2C37, 0008,00,2C37, 0008,F8,2C37, 0008,F0,2C37, 01F0,08,2C37, 01F0,00,2C37, 01F0,F8,2C37, 01F0,F0,2C37, 01FC,08,2C37, 01FC,00,2C37, 01FC,F8,2C37, 01FC,F0,2C37
$93:DACC             dx 000C, 000D,08,2C37, 000D,00,2C37, 000D,F8,2C37, 000D,F0,2C37, 01EB,08,2C37, 01EB,00,2C37, 01EB,F8,2C37, 01EB,F0,2C37, 01FC,08,2C37, 01FC,00,2C37, 01FC,F8,2C37, 01FC,F0,2C37
$93:DB0A             dx 000C, 000F,08,2C37, 000F,00,2C37, 000F,F8,2C37, 000F,F0,2C37, 01E9,08,2C37, 01E9,00,2C37, 01E9,F8,2C37, 01E9,F0,2C37, 01FC,08,2C37, 01FC,00,2C37, 01FC,F8,2C37, 01FC,F0,2C37
$93:DB48             dx 000C, 0010,08,2C37, 0010,00,2C37, 0010,F8,2C37, 0010,F0,2C37, 01E8,08,2C37, 01E8,00,2C37, 01E8,F8,2C37, 01E8,F0,2C37, 01FC,08,2C37, 01FC,00,2C37, 01FC,F8,2C37, 01FC,F0,2C37
$93:DB86             dx 0006, 0004,08,EC36, 01F4,F0,2C36, 01FC,F8,EC35, 0004,00,EC35, 01FC,00,2C35, 01F4,F8,2C35
$93:DBA6             dx 0012, 0004,08,EC36, 01F4,F0,2C36, 01FC,F8,EC35, 0004,00,EC35, 01FC,00,2C35, 01F4,F8,2C35, 0006,05,EC36, 01F6,ED,2C36, 01FE,F5,EC35, 0006,FD,EC35, 01FE,FD,2C35, 01F6,F5,2C35, 0002,0B,EC36, 01F2,F3,2C36, 01FA,FB,EC35, 0002,03,EC35, 01FA,03,2C35, 01F2,FB,2C35
$93:DC02             dx 0012, 0004,08,EC36, 01F4,F0,2C36, 01FC,F8,EC35, 0004,00,EC35, 01FC,00,2C35, 01F4,F8,2C35, 01FE,0F,EC36, 01EE,F7,2C36, 01F6,FF,EC35, 01FE,07,EC35, 01F6,07,2C35, 01EE,FF,2C35, 000A,01,EC36, 01FA,E9,2C36, 0002,F1,EC35, 000A,F9,EC35, 0002,F9,2C35, 01FA,F1,2C35
$93:DC5E             dx 0012, 0004,08,EC36, 01F4,F0,2C36, 01FC,F8,EC35, 0004,00,EC35, 01FC,00,2C35, 01F4,F8,2C35, 01FB,12,EC36, 01EB,FA,2C36, 01F3,02,EC35, 01FB,0A,EC35, 01F3,0A,2C35, 01EB,02,2C35, 000D,FE,EC36, 01FD,E6,2C36, 0005,EE,EC35, 000D,F6,EC35, 0005,F6,2C35, 01FD,EE,2C35
$93:DCBA             dx 0012, 0004,08,EC36, 01F4,F0,2C36, 01FC,F8,EC35, 0004,00,EC35, 01FC,00,2C35, 01F4,F8,2C35, 01F7,17,EC36, 01E7,FF,2C36, 01EF,07,EC35, 01F7,0F,EC35, 01EF,0F,2C35, 01E7,07,2C35, 0011,F9,EC36, 0001,E1,2C36, 0009,E9,EC35, 0011,F1,EC35, 0009,F1,2C35, 0001,E9,2C35
$93:DD16             dx 0012, 0004,08,EC36, 01F4,F0,2C36, 01FC,F8,EC35, 0004,00,EC35, 01FC,00,2C35, 01F4,F8,2C35, 01F6,17,EC36, 01E6,FF,2C36, 01EE,07,EC35, 01F6,0F,EC35, 01EE,0F,2C35, 01E6,07,2C35, 0012,F9,EC36, 0002,E1,2C36, 000A,E9,EC35, 0012,F1,EC35, 000A,F1,2C35, 0002,E9,2C35
$93:DD72             dx 0006, 01F4,08,AC36, 0004,F0,6C36, 01FC,F8,AC35, 01F4,00,AC35, 01FC,00,6C35, 0004,F8,6C35
$93:DD92             dx 0012, 01F4,08,AC36, 0004,F0,6C36, 01FC,F8,AC35, 01F4,00,AC35, 01FC,00,6C35, 0004,F8,6C35, 01F2,06,AC36, 0002,EE,6C36, 01FA,F6,AC35, 01F2,FE,AC35, 01FA,FE,6C35, 0002,F6,6C35, 01F6,0B,AC36, 0006,F3,6C36, 01FE,FB,AC35, 01F6,03,AC35, 01FE,03,6C35, 0006,FB,6C35
$93:DDEE             dx 0012, 01F4,08,AC36, 0004,F0,6C36, 01FC,F8,AC35, 01F4,00,AC35, 01FC,00,6C35, 0004,F8,6C35, 01FA,0F,AC36, 000A,F7,6C36, 0002,FF,AC35, 01FA,07,AC35, 0002,07,6C35, 000A,FF,6C35, 01EE,01,AC36, 01FE,E9,6C36, 01F6,F1,AC35, 01EE,F9,AC35, 01F6,F9,6C35, 01FE,F1,6C35
$93:DE4A             dx 0012, 01F4,08,AC36, 0004,F0,6C36, 01FC,F8,AC35, 01F4,00,AC35, 01FC,00,6C35, 0004,F8,6C35, 01FD,12,AC36, 000D,FA,6C36, 0005,02,AC35, 01FD,0A,AC35, 0005,0A,6C35, 000D,02,6C35, 01EB,FE,AC36, 01FB,E6,6C36, 01F3,EE,AC35, 01EB,F6,AC35, 01F3,F6,6C35, 01FB,EE,6C35
$93:DEA6             dx 0012, 01F4,08,AC36, 0004,F0,6C36, 01FC,F8,AC35, 01F4,00,AC35, 01FC,00,6C35, 0004,F8,6C35, 0001,16,AC36, 0011,FE,6C36, 0009,06,AC35, 0001,0E,AC35, 0009,0E,6C35, 0011,06,6C35, 01E7,FA,AC36, 01F7,E2,6C36, 01EF,EA,AC35, 01E7,F2,AC35, 01EF,F2,6C35, 01F7,EA,6C35
$93:DF02             dx 0012, 01F4,08,AC36, 0004,F0,6C36, 01FC,F8,AC35, 01F4,00,AC35, 01FC,00,6C35, 0004,F8,6C35, 0002,17,AC36, 0012,FF,6C36, 000A,07,AC35, 0002,0F,AC35, 000A,0F,6C35, 0012,07,6C35, 01E6,F9,AC36, 01F6,E1,6C36, 01EE,E9,AC35, 01E6,F1,AC35, 01EE,F1,6C35, 01F6,E9,6C35
$93:DF5E             dx 0006, 01FE,F4,6C32, 0006,F4,6C31, 01EE,04,6C32, 01F6,04,6C31, 01F6,FC,6C32, 01FE,FC,6C31
$93:DF7E             dx 0012, 01F8,EE,6C32, 0000,EE,6C31, 01FE,F4,6C32, 0006,F4,6C31, 0004,FA,6C32, 000C,FA,6C31, 01EE,04,6C32, 01F6,04,6C31, 01F6,FC,6C32, 01FE,FC,6C31, 01E8,FE,6C32, 01F0,FE,6C31, 01F0,F6,6C32, 01F8,F6,6C31, 01F4,0A,6C32, 01FC,0A,6C31, 01FC,02,6C32, 0004,02,6C31
$93:DFDA             dx 0012, 0007,FD,6C32, 000F,FD,6C31, 01FE,F4,6C32, 0006,F4,6C31, 01F5,EB,6C32, 01FD,EB,6C31, 01EE,04,6C32, 01F6,04,6C31, 01F6,FC,6C32, 01FE,FC,6C31, 01E5,FB,6C32, 01ED,FB,6C31, 01ED,F3,6C32, 01F5,F3,6C31, 01F7,0D,6C32, 01FF,0D,6C31, 01FF,05,6C32, 0007,05,6C31
$93:E036             dx 0012, 0009,FF,6C32, 0011,FF,6C31, 01F3,E9,6C32, 01FB,E9,6C31, 01FE,F4,6C32, 0006,F4,6C31, 01EE,04,6C32, 01F6,04,6C31, 01F6,FC,6C32, 01FE,FC,6C31, 01E3,F9,6C32, 01EB,F9,6C31, 01EB,F1,6C32, 01F3,F1,6C31, 01F9,0F,6C32, 0001,0F,6C31, 0001,07,6C32, 0009,07,6C31
$93:E092             dx 0012, 01F2,E8,6C32, 01FA,E8,6C31, 000A,00,6C32, 0012,00,6C31, 01FE,F4,6C32, 0006,F4,6C31, 01EE,04,6C32, 01F6,04,6C31, 01F6,FC,6C32, 01FE,FC,6C31, 01E2,F8,6C32, 01EA,F8,6C31, 01EA,F0,6C32, 01F2,F0,6C31, 01FA,10,6C32, 0002,10,6C31, 0002,08,6C32, 000A,08,6C31
$93:E0EE             dx 0012, 0000,F7,6C32, 0008,F7,6C31, 01FE,F4,6C32, 0006,F4,6C31, 01FB,F2,6C32, 0003,F2,6C31, 01EB,02,6C32, 01F3,02,6C31, 01F3,FA,6C32, 01FB,FA,6C31, 01F0,07,6C32, 01F8,07,6C31, 01F8,FF,6C32, 0000,FF,6C31, 01EE,04,6C32, 01F6,04,6C31, 01F6,FC,6C32, 01FE,FC,6C31
$93:E14A             dx 0006, 01FE,04,EC32, 0006,04,EC31, 01EE,F4,EC32, 01F6,F4,EC31, 01F6,FC,EC32, 01FE,FC,EC31
$93:E16A             dx 0012, 0004,FE,EC32, 000C,FE,EC31, 01FE,04,EC32, 0006,04,EC31, 01F8,0A,EC32, 0000,0A,EC31, 01EE,F4,EC32, 01F6,F4,EC31, 01F6,FC,EC32, 01FE,FC,EC31, 01E8,FA,EC32, 01F0,FA,EC31, 01F0,02,EC32, 01F8,02,EC31, 01F4,EE,EC32, 01FC,EE,EC31, 01FC,F6,EC32, 0004,F6,EC31
$93:E1C6             dx 0012, 01F5,0D,EC32, 01FD,0D,EC31, 0007,FB,EC32, 000F,FB,EC31, 01FE,04,EC32, 0006,04,EC31, 01EE,F4,EC32, 01F6,F4,EC31, 01F6,FC,EC32, 01FE,FC,EC31, 01E5,FD,EC32, 01ED,FD,EC31, 01ED,05,EC32, 01F5,05,EC31, 01F7,EB,EC32, 01FF,EB,EC31, 01FF,F3,EC32, 0007,F3,EC31
$93:E222             dx 0012, 01F3,0F,EC32, 01FB,0F,EC31, 0009,F9,EC32, 0011,F9,EC31, 01FE,04,EC32, 0006,04,EC31, 01EE,F4,EC32, 01F6,F4,EC31, 01F6,FC,EC32, 01FE,FC,EC31, 01E3,FF,EC32, 01EB,FF,EC31, 01EB,07,EC32, 01F3,07,EC31, 01F9,E9,EC32, 0001,E9,EC31, 0001,F1,EC32, 0009,F1,EC31
$93:E27E             dx 0012, 01F2,10,EC32, 01FA,10,EC31, 01FE,04,EC32, 0006,04,EC31, 000A,F8,EC32, 0012,F8,EC31, 01EE,F4,EC32, 01F6,F4,EC31, 01F6,FC,EC32, 01FE,FC,EC31, 01E2,00,EC32, 01EA,00,EC31, 01EA,08,EC32, 01F2,08,EC31, 01FA,E8,EC32, 0002,E8,EC31, 0002,F0,EC32, 000A,F0,EC31
$93:E2DA             dx 0012, 01FE,04,EC32, 0006,04,EC31, 0000,01,EC32, 0008,01,EC31, 01FB,06,EC32, 0003,06,EC31, 01EB,F6,EC32, 01F3,F6,EC31, 01F3,FE,EC32, 01FB,FE,EC31, 01F0,F1,EC32, 01F8,F1,EC31, 01F8,F9,EC32, 0000,F9,EC31, 01EE,F4,EC32, 01F6,F4,EC31, 01F6,FC,EC32, 01FE,FC,EC31
$93:E336             dx 0006, 01FA,04,AC32, 01F2,04,AC31, 000A,F4,AC32, 0002,F4,AC31, 0002,FC,AC32, 01FA,FC,AC31
$93:E356             dx 0012, 01F4,FE,AC32, 01EC,FE,AC31, 01FA,04,AC32, 01F2,04,AC31, 0000,0A,AC32, 01F8,0A,AC31, 000A,F4,AC32, 0002,F4,AC31, 0002,FC,AC32, 01FA,FC,AC31, 0010,FA,AC32, 0008,FA,AC31, 0008,02,AC32, 0000,02,AC31, 0004,EE,AC32, 01FC,EE,AC31, 01FC,F6,AC32, 01F4,F6,AC31
$93:E3B2             dx 0012, 0003,0D,AC32, 01FB,0D,AC31, 01FA,04,AC32, 01F2,04,AC31, 01F1,FB,AC32, 01E9,FB,AC31, 000A,F4,AC32, 0002,F4,AC31, 0002,FC,AC32, 01FA,FC,AC31, 0013,FD,AC32, 000B,FD,AC31, 000B,05,AC32, 0003,05,AC31, 0001,EB,AC32, 01F9,EB,AC31, 01F9,F3,AC32, 01F1,F3,AC31
$93:E40E             dx 0012, 0005,0F,AC32, 01FD,0F,AC31, 01FA,04,AC32, 01F2,04,AC31, 01EF,F9,AC32, 01E7,F9,AC31, 000A,F4,AC32, 0002,F4,AC31, 0002,FC,AC32, 01FA,FC,AC31, 0015,FF,AC32, 000D,FF,AC31, 000D,07,AC32, 0005,07,AC31, 01FF,E9,AC32, 01F7,E9,AC31, 01F7,F1,AC32, 01EF,F1,AC31
$93:E46A             dx 0012, 01EE,F8,AC32, 01E6,F8,AC31, 0006,10,AC32, 01FE,10,AC31, 01FA,04,AC32, 01F2,04,AC31, 000A,F4,AC32, 0002,F4,AC31, 0002,FC,AC32, 01FA,FC,AC31, 0016,00,AC32, 000E,00,AC31, 000E,08,AC32, 0006,08,AC31, 01FE,E8,AC32, 01F6,E8,AC31, 01F6,F0,AC32, 01EE,F0,AC31
$93:E4C6             dx 0012, 01F8,01,AC32, 01F0,01,AC31, 01FA,04,AC32, 01F2,04,AC31, 01FD,06,AC32, 01F5,06,AC31, 000D,F6,AC32, 0005,F6,AC31, 0005,FE,AC32, 01FD,FE,AC31, 0008,F1,AC32, 0000,F1,AC31, 0000,F9,AC32, 01F8,F9,AC31, 000A,F4,AC32, 0002,F4,AC31, 0002,FC,AC32, 01FA,FC,AC31
$93:E522             dx 0006, 000A,04,2C32, 0002,04,2C31, 0002,FC,2C32, 01FA,FC,2C31, 01FA,F4,2C32, 01F2,F4,2C31
$93:E542             dx 0012, 0004,0A,2C32, 01FC,0A,2C31, 000A,04,2C32, 0002,04,2C31, 0010,FE,2C32, 0008,FE,2C31, 0002,FC,2C32, 01FA,FC,2C31, 01FA,F4,2C32, 01F2,F4,2C31, 0008,F6,2C32, 0000,F6,2C31, 0000,EE,2C32, 01F8,EE,2C31, 01FC,02,2C32, 01F4,02,2C31, 01F4,FA,2C32, 01EC,FA,2C31
$93:E59E             dx 0012, 0001,0D,2C32, 01F9,0D,2C31, 000A,04,2C32, 0002,04,2C31, 0013,FB,2C32, 000B,FB,2C31, 0002,FC,2C32, 01FA,FC,2C31, 01FA,F4,2C32, 01F2,F4,2C31, 000B,F3,2C32, 0003,F3,2C31, 0003,EB,2C32, 01FB,EB,2C31, 01F9,05,2C32, 01F1,05,2C31, 01F1,FD,2C32, 01E9,FD,2C31
$93:E5FA             dx 0012, 01FF,0F,2C32, 01F7,0F,2C31, 000A,04,2C32, 0002,04,2C31, 0015,F9,2C32, 000D,F9,2C31, 0002,FC,2C32, 01FA,FC,2C31, 01FA,F4,2C32, 01F2,F4,2C31, 000D,F1,2C32, 0005,F1,2C31, 0005,E9,2C32, 01FD,E9,2C31, 01F7,07,2C32, 01EF,07,2C31, 01EF,FF,2C32, 01E7,FF,2C31
$93:E656             dx 0012, 0016,F8,2C32, 000E,F8,2C31, 01FE,10,2C32, 01F6,10,2C31, 000A,04,2C32, 0002,04,2C31, 0002,FC,2C32, 01FA,FC,2C31, 01FA,F4,2C32, 01F2,F4,2C31, 000E,F0,2C32, 0006,F0,2C31, 0006,E8,2C32, 01FE,E8,2C31, 01F6,08,2C32, 01EE,08,2C31, 01EE,00,2C32, 01E6,00,2C31
$93:E6B2             dx 0012, 000D,02,2C32, 0005,02,2C31, 000A,04,2C32, 0002,04,2C31, 0008,07,2C32, 0000,07,2C31, 0005,FA,2C32, 01FD,FA,2C31, 01FD,F2,2C32, 01F5,F2,2C31, 0000,FF,2C32, 01F8,FF,2C31, 01F8,F7,2C32, 01F0,F7,2C31, 0002,FC,2C32, 01FA,FC,2C31, 01FA,F4,2C32, 01F2,F4,2C31
$93:E70E             dx 0004, 01FC,F0,AC33, 01FC,08,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:E724             dx 000C, 01FC,F0,AC33, 0000,F0,AC33, 01F8,F0,AC33, 01F8,08,AC33, 0000,08,AC33, 01FC,08,AC33, 0000,F8,AC33, 0000,00,AC33, 01F8,F8,AC33, 01F8,00,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:E762             dx 000C, 01F4,08,AC33, 01F4,F0,AC33, 01F4,F8,AC33, 01F4,00,AC33, 0004,F0,AC33, 0004,08,AC33, 0004,F8,AC33, 0004,00,AC33, 01FC,08,AC33, 01FC,F0,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:E7A0             dx 000C, 0009,F0,AC33, 0009,08,AC33, 01FC,08,AC33, 01EF,08,AC33, 01EF,F0,AC33, 01FC,F0,AC33, 0009,F8,AC33, 0009,00,AC33, 01EF,F8,AC33, 01EF,00,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:E7DE             dx 000C, 000B,F0,AC33, 01ED,F0,AC33, 01FC,F0,AC33, 000B,08,AC33, 01ED,08,AC33, 01FC,08,AC33, 000B,F8,AC33, 000B,00,AC33, 01ED,F8,AC33, 01ED,00,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:E81C             dx 000C, 000C,08,AC33, 01EC,08,AC33, 01FC,08,AC33, 000C,F0,AC33, 01EC,F0,AC33, 01FC,F0,AC33, 000C,F8,AC33, 000C,00,AC33, 01EC,F8,AC33, 01EC,00,AC33, 01FC,F8,AC33, 01FC,00,AC33
$93:E85A             dx 0004, 01F0,FC,2C30, 0008,FC,2C30, 0000,FC,2C30, 01F8,FC,2C30
$93:E870             dx 000C, 01F0,00,2C30, 01F0,FC,2C30, 01F0,F8,2C30, 0008,00,2C30, 0008,FC,2C30, 0008,F8,2C30, 0000,00,2C30, 01F8,00,2C30, 0000,FC,2C30, 01F8,FC,2C30, 0000,F8,2C30, 01F8,F8,2C30
$93:E8AE             dx 000C, 01F0,FC,2C30, 01F0,04,2C30, 01F0,F4,2C30, 0008,04,2C30, 0008,FC,2C30, 0008,F4,2C30, 0000,F4,2C30, 0000,FC,2C30, 0000,04,2C30, 01F8,04,2C30, 01F8,FC,2C30, 01F8,F4,2C30
$93:E8EC             dx 000C, 01F0,EF,2C30, 01F0,FC,2C30, 01F0,09,2C30, 0008,EF,2C30, 0008,FC,2C30, 0008,09,2C30, 0000,EF,2C30, 0000,FC,2C30, 0000,09,2C30, 01F8,09,2C30, 01F8,FC,2C30, 01F8,EF,2C30
$93:E92A             dx 000C, 0008,0B,2C30, 01F0,0B,2C30, 0008,ED,2C30, 0008,FC,2C30, 01F0,FC,2C30, 01F0,ED,2C30, 0000,ED,2C30, 0000,FC,2C30, 0000,0B,2C30, 01F8,0B,2C30, 01F8,FC,2C30, 01F8,ED,2C30
$93:E968             dx 000C, 01F0,EC,2C30, 01F0,FC,2C30, 01F0,0C,2C30, 0008,EC,2C30, 0008,FC,2C30, 0008,0C,2C30, 0000,EC,2C30, 0000,FC,2C30, 0000,0C,2C30, 01F8,0C,2C30, 01F8,FC,2C30, 01F8,EC,2C30
$93:E9A6             dx 0004, 01FC,08,2C33, 01FC,F0,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:E9BC             dx 000C, 01FC,08,2C33, 01FC,F0,2C33, 0000,08,2C33, 01F8,08,2C33, 0000,F0,2C33, 01F8,F0,2C33, 0000,00,2C33, 0000,F8,2C33, 01F8,00,2C33, 01F8,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:E9FA             dx 000C, 0004,08,2C33, 01F4,08,2C33, 01FC,08,2C33, 0004,F0,2C33, 01F4,F0,2C33, 01FC,F0,2C33, 0004,00,2C33, 0004,F8,2C33, 01F4,00,2C33, 01F4,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:EA38             dx 000C, 0009,08,2C33, 01EF,08,2C33, 01FC,08,2C33, 0009,F0,2C33, 01EF,F0,2C33, 01FC,F0,2C33, 0009,00,2C33, 0009,F8,2C33, 01EF,00,2C33, 01EF,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:EA76             dx 000C, 000B,08,2C33, 01ED,08,2C33, 01FC,08,2C33, 000B,F0,2C33, 01ED,F0,2C33, 01FC,F0,2C33, 000B,00,2C33, 000B,F8,2C33, 01ED,00,2C33, 01ED,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:EAB4             dx 000C, 01EC,08,2C33, 01FC,08,2C33, 000C,08,2C33, 000C,F0,2C33, 01FC,F0,2C33, 01EC,F0,2C33, 000C,00,2C33, 000C,F8,2C33, 01EC,00,2C33, 01EC,F8,2C33, 01FC,00,2C33, 01FC,F8,2C33
$93:EAF2             dx 0004, 01F0,FC,6C30, 0008,FC,6C30, 01F8,FC,6C30, 0000,FC,6C30
$93:EB08             dx 000C, 01F0,00,2C30, 01F0,FC,2C30, 01F0,F8,2C30, 0008,00,2C30, 0008,FC,2C30, 0008,F8,2C30, 0000,00,2C30, 01F8,00,2C30, 0000,FC,2C30, 01F8,FC,2C30, 0000,F8,2C30, 01F8,F8,2C30
$93:EB46             dx 000C, 01F0,04,6C30, 01F0,FC,6C30, 01F0,F4,6C30, 0008,04,6C30, 0008,FC,6C30, 0008,F4,6C30, 01F8,F4,6C30, 01F8,FC,6C30, 01F8,04,6C30, 0000,04,6C30, 0000,FC,6C30, 0000,F4,6C30
$93:EB84             dx 000C, 01F0,09,6C30, 01F0,FC,6C30, 01F0,EF,6C30, 0008,09,6C30, 0008,FC,6C30, 0008,EF,6C30, 01F8,EF,6C30, 01F8,FC,6C30, 01F8,09,6C30, 0000,09,6C30, 0000,FC,6C30, 0000,EF,6C30
$93:EBC2             dx 000C, 01F0,0B,6C30, 01F0,FC,6C30, 01F0,ED,6C30, 0008,0B,6C30, 0008,FC,6C30, 0008,ED,6C30, 01F8,ED,6C30, 01F8,FC,6C30, 01F8,0B,6C30, 0000,0B,6C30, 0000,FC,6C30, 0000,ED,6C30
$93:EC00             dx 000C, 01F0,0C,6C30, 01F0,FC,6C30, 01F0,EC,6C30, 0008,0C,6C30, 0008,FC,6C30, 0008,EC,6C30, 01F8,EC,6C30, 01F8,FC,6C30, 01F8,0C,6C30, 0000,0C,6C30, 0000,FC,6C30, 0000,EC,6C30

; Charged power
$93:EC3E             dx 0004, 0000,F8,6C33, 0000,00,EC33, 01F8,00,AC33, 01F8,F8,2C33
$93:EC54             dx 0004, 0000,00,EC33, 0000,F8,6C33, 01F8,00,AC33, 01F8,F8,2C33
$93:EC6A             dx 0004, 0000,00,EC33, 0000,F8,6C33, 01F8,00,AC33, 01F8,F8,2C33
$93:EC80             dx 0004, 0000,00,EC33, 0000,F8,6C33, 01F8,00,AC33, 01F8,F8,2C33
$93:EC96             dx 0004, 0000,00,EC33, 0000,F8,6C33, 01F8,00,AC33, 01F8,F8,2C33
$93:ECAC             dx 0004, 0000,00,EC33, 0000,F8,6C33, 01F8,00,AC33, 01F8,F8,2C33
$93:ECC2             dx 0004, 0000,00,EC33, 0000,F8,6C33, 01F8,00,AC33, 01F8,F8,2C33
$93:ECD8             dx 0004, 0000,00,EC33, 0000,F8,6C33, 01F8,00,AC33, 01F8,F8,2C33
$93:ECEE             dx 0004, 0000,00,EC34, 0000,F8,6C34, 01F8,00,AC34, 01F8,F8,2C34
$93:ED04             dx 0004, 0000,00,EC34, 0000,F8,6C34, 01F8,00,AC34, 01F8,F8,2C34
$93:ED1A             dx 0004, 0000,00,EC34, 0000,F8,6C34, 01F8,00,AC34, 01F8,F8,2C34
$93:ED30             dx 0004, 0000,00,EC34, 0000,F8,6C34, 01F8,00,AC34, 01F8,F8,2C34
$93:ED46             dx 0004, 0000,00,EC34, 0000,F8,6C34, 01F8,00,AC34, 01F8,F8,2C34
$93:ED5C             dx 0004, 0000,00,EC34, 0000,F8,6C34, 01F8,00,AC34, 01F8,F8,2C34
$93:ED72             dx 0004, 0000,00,EC34, 0000,F8,6C34, 01F8,00,AC34, 01F8,F8,2C34
$93:ED88             dx 0004, 0000,00,EC34, 0000,F8,6C34, 01F8,00,AC34, 01F8,F8,2C34

; Charged ice
$93:ED9E             dx 0004, 0000,00,EC33, 01F8,00,AC33, 0000,F8,6C33, 01F8,F8,2C33
$93:EDB4             dx 0004, 0000,00,EC34, 01F8,00,AC34, 0000,F8,6C34, 01F8,F8,2C34
$93:EDCA             dx 0004, 0000,00,EC33, 01F8,00,AC33, 0000,F8,6C33, 01F8,F8,2C33
$93:EDE0             dx 0004, 0000,00,EC34, 01F8,00,AC34, 0000,F8,6C34, 01F8,F8,2C34

; Ice
$93:EDF6             dx 0001, 01FC,FC,2C30
$93:EDFD             dx 0001, 01FC,FC,2C31
$93:EE04             dx 0001, 01FC,FC,2C32
$93:EE0B             dx 0001, 01FC,FC,6C31

; Charged spazer / spazer + ice / spazer + wave / spazer + ice + wave
$93:EE12             dx 0001, 01FC,FC,2C30
$93:EE19             dx 0002, 01F8,FC,2C30, 0000,FC,2C30
$93:EE25             dx 0003, 01F4,FC,2C30, 01FC,FC,2C30, 0004,FC,2C30 ; Unused
$93:EE36             dx 0004, 0008,FC,2C30, 0000,FC,2C30, 01F8,FC,2C30, 01F0,FC,2C30 ; Unused
$93:EE4C             dx 0002, 0002,FC,2C32, 01FA,FC,2C31
$93:EE58             dx 0004, 0006,00,2C32, 01FE,00,2C31, 01FE,F8,2C32, 01F6,F8,2C31
$93:EE6E             dx 0006, 000A,04,2C32, 0002,04,2C31, 0002,FC,2C32, 01FA,FC,2C31, 01FA,F4,2C32, 01F2,F4,2C31 ; Unused
$93:EE8E             dx 0001, 01FC,FC,2C33
$93:EE95             dx 0002, 01FC,00,2C33, 01FC,F8,2C33
$93:EEA1             dx 0003, 01FC,F4,2C33, 01FC,04,2C33, 01FC,FC,2C33 ; Unused
$93:EEB2             dx 0004, 01FC,F0,2C33, 01FC,08,2C33, 01FC,00,2C33, 01FC,F8,2C33 ; Unused
$93:EEC8             dx 0002, 01F6,FC,6C32, 01FE,FC,6C31
$93:EED4             dx 0004, 01F2,00,6C32, 01FA,00,6C31, 01FA,F8,6C32, 0002,F8,6C31
$93:EEEA             dx 0006, 01EE,04,6C32, 01F6,04,6C31, 01F6,FC,6C32, 01FE,FC,6C31, 01FE,F4,6C32, 0006,F4,6C31 ; Unused
$93:EF0A             dx 0001, 01FC,FC,6C30
$93:EF11             dx 0002, 0000,FC,6C30, 01F8,FC,6C30
$93:EF1D             dx 0003, 0004,FC,6C30, 01FC,FC,6C30, 01F4,FC,6C30 ; Unused
$93:EF2E             dx 0004, 01F0,FC,6C30, 01F8,FC,6C30, 0000,FC,6C30, 0008,FC,6C30 ; Unused
$93:EF44             dx 0002, 01F6,FC,EC32, 01FE,FC,EC31
$93:EF50             dx 0004, 01F2,F8,EC32, 01FA,F8,EC31, 01FA,00,EC32, 0002,00,EC31
$93:EF66             dx 0006, 01EE,F4,EC32, 01F6,F4,EC31, 01F6,FC,EC32, 01FE,FC,EC31, 01FE,04,EC32, 0006,04,EC31 ; Unused
$93:EF86             dx 0001, 01FC,FC,AC33
$93:EF8D             dx 0002, 01FC,F8,AC33, 01FC,00,AC33
$93:EF99             dx 0003, 01FC,04,AC33, 01FC,F4,AC33, 01FC,FC,AC33 ; Unused
$93:EFAA             dx 0004, 01FC,08,AC33, 01FC,F0,AC33, 01FC,F8,AC33, 01FC,00,AC33 ; Unused
$93:EFC0             dx 0002, 01F6,FC,EC32, 01FE,FC,EC31 ; Unused
$93:EFCC             dx 0004, 01F2,F8,EC32, 01FA,F8,EC31, 01FA,00,EC32, 0002,00,EC31 ; Unused
$93:EFE2             dx 0006, 01EE,F4,EC32, 01F6,F4,EC31, 01F6,FC,EC32, 01FE,FC,EC31, 01FE,04,EC32, 0006,04,EC31 ; Unused
$93:F002             dx 0001, 01FC,FC,2C34
$93:F009             dx 0002, 01F8,FC,2C34, 0000,FC,2C34
$93:F015             dx 0003, 01F4,FC,2C34, 01FC,FC,2C34, 0004,FC,2C34 ; Unused
$93:F026             dx 0004, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34 ; Unused
$93:F03C             dx 0002, 01FC,F8,2C36, 01FC,00,EC36
$93:F048             dx 0004, 0000,FC,EC35, 0000,04,EC36, 01F8,F4,2C36, 01F8,FC,2C35
$93:F05E             dx 0006, 0004,08,EC36, 01F4,F0,2C36, 0004,00,EC35, 01FC,00,2C35, 01FC,F8,EC35, 01F4,F8,2C35 ; Unused
$93:F07E             dx 0001, 01FC,FC,2C37
$93:F085             dx 0002, 01FC,00,2C37, 01FC,F8,2C37
$93:F091             dx 0003, 01FC,04,2C37, 01FC,FC,2C37, 01FC,F4,2C37 ; Unused
$93:F0A2             dx 0004, 01FC,08,2C37, 01FC,00,2C37, 01FC,F8,2C37, 01FC,F0,2C37 ; Unused
$93:F0B8             dx 0002, 01FC,F8,6C36, 01FC,00,AC36
$93:F0C4             dx 0004, 01F8,FC,AC35, 01F8,04,AC36, 0000,F4,6C36, 0000,FC,6C35
$93:F0DA             dx 0006, 01F4,08,AC36, 0004,F0,6C36, 01F4,00,AC35, 01FC,00,6C35, 01FC,F8,AC35, 0004,F8,6C35 ; Unused

; Charged plasma / plasma + ice / plasma + wave / plasma + ice + wave
$93:F0FA             dx 0001, 01FC,FC,2C30
$93:F101             dx 0002, 01F8,FC,2C30, 0000,FC,2C30 ; Unused
$93:F10D             dx 0003, 01F4,FC,2C30, 01FC,FC,2C30, 0004,FC,2C30
$93:F11E             dx 0004, 01F0,FC,2C30, 01F8,FC,2C30, 0000,FC,2C30, 0008,FC,2C30 ; Unused
$93:F134             dx 0005, 000C,FC,2C30, 0004,FC,2C30, 01FC,FC,2C30, 01F4,FC,2C30, 01EC,FC,2C30 ; Unused
$93:F14F             dx 0006, 0010,FC,2C30, 0008,FC,2C30, 0000,FC,2C30, 01F8,FC,2C30, 01F0,FC,2C30, 01E8,FC,2C30
$93:F16F             dx 0007, 0014,FC,2C30, 000C,FC,2C30, 0004,FC,2C30, 01FC,FC,2C30, 01F4,FC,2C30, 01EC,FC,2C30, 01E4,FC,2C30
$93:F194             dx 0001, 01FC,FC,2C33
$93:F19B             dx 0002, 01FC,00,2C33, 01FC,F8,2C33 ; Unused
$93:F1A7             dx 0003, 01FC,04,2C33, 01FC,FC,2C33, 01FC,F4,2C33
$93:F1B8             dx 0004, 01FC,08,2C33, 01FC,00,2C33, 01FC,F8,2C33, 01FC,F0,2C33 ; Unused
$93:F1CE             dx 0005, 01FC,0C,2C33, 01FC,04,2C33, 01FC,FC,2C33, 01FC,F4,2C33, 01FC,EC,2C33 ; Unused
$93:F1E9             dx 0006, 01FC,10,2C33, 01FC,08,2C33, 01FC,00,2C33, 01FC,F8,2C33, 01FC,F0,2C33, 01FC,E8,2C33
$93:F209             dx 0007, 01FC,14,2C33, 01FC,0C,2C33, 01FC,04,2C33, 01FC,FC,2C33, 01FC,F4,2C33, 01FC,EC,2C33, 01FC,E4,2C33
$93:F22E             dx 0002, 0000,FC,2C32, 01F8,FC,2C31
$93:F23A             dx 0004, 0004,00,2C32, 01FC,00,2C31, 01FC,F8,2C32, 01F4,F8,2C31
$93:F250             dx 0006, 0008,04,2C32, 0000,04,2C31, 0000,FC,2C32, 01F8,FC,2C31, 01F8,F4,2C32, 01F0,F4,2C31 ; Unused
$93:F270             dx 0008, 000C,08,2C32, 0004,08,2C31, 0004,00,2C32, 01FC,00,2C31, 01FC,F8,2C32, 01F4,F8,2C31, 01F4,F0,2C32, 01EC,F0,2C31
$93:F29A             dx 000A, 0010,0C,2C32, 0008,0C,2C31, 0008,04,2C32, 0000,04,2C31, 0000,FC,2C32, 01F8,FC,2C31, 01F8,F4,2C32, 01F0,F4,2C31, 01F0,EC,2C32, 01E8,EC,2C31
$93:F2CE             dx 0002, 01F8,FC,6C32, 0000,FC,6C31
$93:F2DA             dx 0004, 01F4,00,6C32, 01FC,00,6C31, 01FC,F8,6C32, 0004,F8,6C31
$93:F2F0             dx 0006, 01F0,04,6C32, 01F8,04,6C31, 01F8,FC,6C32, 0000,FC,6C31, 0000,F4,6C32, 0008,F4,6C31 ; Unused
$93:F310             dx 0008, 01EC,08,6C32, 01F4,08,6C31, 01F4,00,6C32, 01FC,00,6C31, 01FC,F8,6C32, 0004,F8,6C31, 0004,F0,6C32, 000C,F0,6C31
$93:F33A             dx 000A, 01E8,0C,6C32, 01F0,0C,6C31, 01F0,04,6C32, 01F8,04,6C31, 01F8,FC,6C32, 0000,FC,6C31, 0000,F4,6C32, 0008,F4,6C31, 0008,EC,6C32, 0010,EC,6C31
$93:F36E             dx 0001, 01FC,FC,2C34
$93:F375             dx 0002, 0000,FC,2C34, 01F8,FC,2C34 ; Unused
$93:F381             dx 0003, 0004,FC,2C34, 01FC,FC,2C34, 01F4,FC,2C34
$93:F392             dx 0004, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34 ; Unused
$93:F3A8             dx 0005, 000C,FC,2C34, 0004,FC,2C34, 01FC,FC,2C34, 01F4,FC,2C34, 01EC,FC,2C34 ; Unused
$93:F3C3             dx 0006, 0010,FC,2C34, 0008,FC,2C34, 0000,FC,2C34, 01F8,FC,2C34, 01F0,FC,2C34, 01E8,FC,2C34
$93:F3E3             dx 0007, 0014,FC,2C34, 000C,FC,2C34, 0004,FC,2C34, 01FC,FC,2C34, 01F4,FC,2C34, 01EC,FC,2C34, 01E4,FC,2C34
$93:F408             dx 0001, 01FC,FC,2C37
$93:F40F             dx 0002, 01FC,00,2C37, 01FC,F8,2C37 ; Unused
$93:F41B             dx 0003, 01FC,04,2C37, 01FC,FC,2C37, 01FC,F4,2C37
$93:F42C             dx 0004, 01FC,08,2C37, 01FC,00,2C37, 01FC,F8,2C37, 01FC,F0,2C37 ; Unused
$93:F442             dx 0005, 01FC,0C,2C37, 01FC,04,2C37, 01FC,FC,2C37, 01FC,F4,2C37, 01FC,EC,2C37 ; Unused
$93:F45D             dx 0006, 01FC,10,2C37, 01FC,08,2C37, 01FC,00,2C37, 01FC,F8,2C37, 01FC,F0,2C37, 01FC,E8,2C37
$93:F47D             dx 0007, 01FC,14,2C37, 01FC,0C,2C37, 01FC,04,2C37, 01FC,FC,2C37, 01FC,F4,2C37, 01FC,EC,2C37, 01FC,E4,2C37
$93:F4A2             dx 0002, 01FC,F8,2C36, 01FC,00,EC36
$93:F4AE             dx 0004, 0000,04,EC36, 0000,FC,EC35, 01F8,F4,2C36, 01F8,FC,2C35
$93:F4C4             dx 0006, 01FC,F8,EC35, 0004,00,EC35, 0004,08,EC36, 01F4,F0,2C36, 01FC,00,2C35, 01F4,F8,2C35 ; Unused
$93:F4E4             dx 0008, 0008,04,EC35, 01F8,F4,EC35, 0000,FC,EC35, 0008,0C,EC36, 01F0,EC,2C36, 0000,04,2C35, 01F8,FC,2C35, 01F0,F4,2C35
$93:F50E             dx 000A, 000C,10,EC36, 01EC,E8,2C36, 000C,08,EC35, 0004,00,EC35, 01FC,F8,EC35, 01F4,F0,EC35, 0004,08,2C35, 01FC,00,2C35, 01F4,F8,2C35, 01EC,F0,2C35
$93:F542             dx 0002, 01FC,F8,6C36, 01FC,00,AC36
$93:F54E             dx 0004, 01F8,04,AC36, 01F8,FC,AC35, 0000,F4,6C36, 0000,FC,6C35
$93:F564             dx 0006, 01FC,F8,AC35, 01F4,00,AC35, 01F4,08,AC36, 0004,F0,6C36, 01FC,00,6C35, 0004,F8,6C35 ; Unused
$93:F584             dx 0008, 01F0,04,AC35, 0000,F4,AC35, 01F8,FC,AC35, 01F0,0C,AC36, 0008,EC,6C36, 01F8,04,6C35, 0000,FC,6C35, 0008,F4,6C35
$93:F5AE             dx 000A, 01EC,10,AC36, 000C,E8,6C36, 01EC,08,AC35, 01F4,00,AC35, 01FC,F8,AC35, 0004,F0,AC35, 01F4,08,6C35, 01FC,00,6C35, 0004,F8,6C35, 000C,F0,6C35
}


;;; $F5E2: Unused. Draw shinespark windup effect sprite ;;;
{
$93:F5E2 08          PHP
$93:F5E3 8B          PHB
$93:F5E4 4B          PHK                    ;\
$93:F5E5 AB          PLB                    ;} DB = $93
$93:F5E6 C2 30       REP #$30
$93:F5E8 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$93:F5EB C9 C7 00    CMP #$00C7             ;|
$93:F5EE F0 05       BEQ $05    [$F5F5]     ;} If [Samus pose] != vertical shinespark windup: return
$93:F5F0 C9 C8 00    CMP #$00C8             ;|
$93:F5F3 D0 25       BNE $25    [$F61A]     ;/

$93:F5F5 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$93:F5F8 89 01 00    BIT #$0001             ;} If [frame counter] % 2 != 0: return
$93:F5FB D0 1D       BNE $1D    [$F61A]     ;/
$93:F5FD AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$93:F600 38          SEC                    ;|
$93:F601 ED 11 09    SBC $0911  [$7E:0911]  ;} $14 = [Samus X position] - [layer 1 X position]
$93:F604 85 14       STA $14    [$7E:0014]  ;/
$93:F606 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$93:F609 38          SEC                    ;|
$93:F60A ED 15 09    SBC $0915  [$7E:0915]  ;} $12 = [Samus Y position] - [layer 1 Y position]
$93:F60D 85 12       STA $12    [$7E:0012]  ;/
$93:F60F A9 3C 00    LDA #$003C             ;\
$93:F612 18          CLC                    ;} A = 3Eh
$93:F613 69 02 00    ADC #$0002             ;/
$93:F616 22 37 8A 81 JSL $818A37[$81:8A37]  ; Add spritemap from $93:A1A1 table to OAM

$93:F61A AB          PLB
$93:F61B 28          PLP
$93:F61C 6B          RTL
}


;;; $F61D: Free space ;;;
{
$93:F61D             fillto $948000, $FF
}
