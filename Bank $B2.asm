;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687: Palette - enemy $F353/$F4D3/$F653 (Old Tourian grey wall space pirate) ;;;
{
$B2:8687             dw 3800, 5755, 4A4F, 1CE4, 0C60, 56B2, 3E0D, 2D68, 2526, 5EBB, 3DB3, 292E, 1486, 033B, 0216, 0113
}


;;; $86A7: Palette - enemy $F393 (Brinstar green wall space pirate) ;;;
{
$B2:86A7             dw 3800, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 5EBB, 3DB3, 292E, 1486, 033B, 0216, 0113
}


;;; $86C7: Palette - enemy $F453 (Maridia magenta wall space pirate) ;;;
{
$B2:86C7             dw 3800, 4EBF, 4D9E, 1009, 0C04, 49DE, 555D, 30B0, 1C4D, 5EBB, 3DB3, 292E, 1486, 033B, 0216, 0113
}


;;; $86E7: Palette - enemy $F3D3 (Norfair red wall space pirate) ;;;
{
$B2:86E7             dw 3800, 02FD, 013E, 006C, 0066, 021E, 005F, 0059, 0073, 5EBB, 3DB3, 292E, 1486, 033B, 0216, 0113
}


;;; $8707: Palette - enemy $F493 (escape silver wall space pirate) ;;;
{
$B2:8707             dw 3800, 6BFF, 4ED6, 14A4, 0420, 5B7B, 3E52, 31CD, 2149, 5EBB, 3DB3, 292E, 1486, 033B, 0216, 0113
}


;;; $8727: Palette - enemy $F413 (Lower Norfair gold wall space pirate) ;;;
{
$B2:8727             dw 3800, 4BBE, 06B9, 00EA, 0065, 173A, 0276, 01F2, 014D, 5EBB, 3DB3, 292E, 1486, 033B, 0216, 0113
}


;;; $8747: Unused. Palette ;;;
{
$B2:8747             dw 3800, 6BFF, 4ED6, 14A4, 0420, 5B7B, 3E52, 31CD, 2149, 5EBB, 3DB3, 292E, 1486, 033B, 0216, 0113
}


;;; $8767: Power bomb reaction - enemy $F353/$F4D3/$F513/$F553/$F593/$F5D3/$F613/$F653/$F693/$F6D3/$F713/$F753/$F793 (Old Tourian grey wall space pirate / ninja space pirates / walking space pirates) ;;;
{
$B2:8767 22 97 A5 A0 JSL $A0A597[$A0:A597]  ; Normal enemy power bomb AI
$B2:876B 6B          RTL
}


;;; $876C: Enemy touch - enemy $F353/$F393/$F3D3/$F413/$F453/$F493/$F4D3/$F513/$F553/$F593/$F5D3/$F613/$F653/$F693/$F6D3/$F713/$F753/$F793 (space pirates) ;;;
{
$B2:876C AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:876F BD 9E 0F    LDA $0F9E,x[$7E:11DE]  ;\
$B2:8772 D0 04       BNE $04    [$8778]     ;} If [frozen timer] = 0:
$B2:8774 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI

$B2:8778 6B          RTL
}


;;; $8779: Enemy shot - space pirate - normal ;;;
{
$B2:8779 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:877C BD 78 0F    LDA $0F78,x[$7E:0FB8]  ;\
$B2:877F C9 93 F5    CMP #$F593             ;} If Lower Norfair pirate: go to normal pirate shot
$B2:8782 F0 05       BEQ $05    [$8789]     ;/
$B2:8784 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
$B2:8788 6B          RTL
}


;;; $8789: Normal pirate shot ;;;
{
$B2:8789 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:878C BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$B2:878F 8F 34 F4 7E STA $7EF434[$7E:F434]  ;} Special death item drop X origin position = [enemy X position]
$B2:8793 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$B2:8796 8F 36 F4 7E STA $7EF436[$7E:F436]  ;} Special death item drop Y origin position = [enemy Y position]
$B2:879A 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$B2:879E BD 8C 0F    LDA $0F8C,x[$7E:100C]  ;\
$B2:87A1 D0 19       BNE $19    [$87BC]     ;} If [enemy health] != 0: return
$B2:87A3 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:87A6 BD 78 0F    LDA $0F78,x[$7E:0FF8]  ;\
$B2:87A9 C9 93 F5    CMP #$F593             ;} If Lower Norfair pirate:
$B2:87AC D0 0F       BNE $0F    [$87BD]     ;/
$B2:87AE 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy $0FAA = 0
$B2:87B1 A9 04 00    LDA #$0004             ; A = 4 (big explosion)
$B2:87B4 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death
$B2:87B8 22 2B B9 A0 JSL $A0B92B[$A0:B92B]  ; Lower Norfair space pirate death item drop routine
$B2:87BC 6B          RTL                    ; Return

$B2:87BD 9E AA 0F    STZ $0FAA,x[$7E:102A]  ; Enemy $0FAA = 0
$B2:87C0 A9 04 00    LDA #$0004             ; A = 4 (big explosion)
$B2:87C3 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death
$B2:87C7 6B          RTL
}


;;; $87C8: Enemy shot - space pirate - Lower Norfair pirate is vulnerable ;;;
{
; Note how the vulnerability check here doesn't take beam charge into account
$B2:87C8 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:87CB BD 78 0F    LDA $0F78,x[$7E:0FF8]  ;\
$B2:87CE C9 93 F5    CMP #$F593             ;} If not Lower Norfair pirate:
$B2:87D1 F0 03       BEQ $03    [$87D6]     ;/
$B2:87D3 4C 89 87    JMP $8789  [$B2:8789]  ; Go to normal pirate shot

$B2:87D6 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$B2:87D9 0A          ASL A                  ;} Collided projectile index
$B2:87DA A8          TAY                    ;/
$B2:87DB B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$B2:87DE 85 12       STA $12    [$7E:0012]  ;} $12 = [projectile type]
$B2:87E0 29 00 0F    AND #$0F00             ;\
$B2:87E3 C9 00 03    CMP #$0300             ;} If projectile is not beam / missile / super missile:
$B2:87E6 30 01       BMI $01    [$87E9]     ;/
$B2:87E8 6B          RTL                    ; Return

$B2:87E9 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:87EC BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$B2:87EF AA          TAX                    ;} $14 = [$A0:003C + [enemy id]] (enemy vulnerabilities)
$B2:87F0 BF 3C 00 A0 LDA $A0003C,x[$A0:F5CF];/
$B2:87F4 D0 03       BNE $03    [$87F9]     ; If [$14] = 0:
$B2:87F6 A9 1C EC    LDA #$EC1C             ; $14 = $EC1C

$B2:87F9 85 14       STA $14    [$7E:0014]
$B2:87FB A5 12       LDA $12    [$7E:0012]  ;\
$B2:87FD 89 00 0F    BIT #$0F00             ;} If projectile is not a beam: go to BRANCH_NOT_BEAM
$B2:8800 D0 1A       BNE $1A    [$881C]     ;/
$B2:8802 A5 12       LDA $12    [$7E:0012]  ;\
$B2:8804 29 0F 00    AND #$000F             ;|
$B2:8807 18          CLC                    ;|
$B2:8808 65 14       ADC $14    [$7E:0014]  ;|
$B2:880A AA          TAX                    ;} If [$B4:0000 + [$14] + (beam type)] & Fh = 0: go to $883E (0 damage)
$B2:880B BF 00 00 B4 LDA $B40000,x[$B4:EC7D];|
$B2:880F 29 0F 00    AND #$000F             ;|
$B2:8812 F0 2A       BEQ $2A    [$883E]     ;/
$B2:8814 C9 0F 00    CMP #$000F             ;\
$B2:8817 F0 25       BEQ $25    [$883E]     ;} If [$B4:0000 + [$14] + (beam type)] & Fh = Fh: go to $883E (freeze)

$B2:8819 4C 89 87    JMP $8789  [$B2:8789]  ; Go to normal pirate shot

; BRANCH_NOT_BEAM
$B2:881C 29 00 0F    AND #$0F00             ;\
$B2:881F C9 00 01    CMP #$0100             ;} If projectile is not missile:
$B2:8822 F0 05       BEQ $05    [$8829]     ;/
$B2:8824 C9 00 02    CMP #$0200             ;\
$B2:8827 D0 F0       BNE $F0    [$8819]     ;} If projectile is not super missile: go to normal pirate shot

$B2:8829 EB          XBA                    ;\
$B2:882A 18          CLC                    ;|
$B2:882B 65 14       ADC $14    [$7E:0014]  ;|
$B2:882D AA          TAX                    ;} If [$B4:000B + [$14] + (projectile type)] & Fh = 0: go to $883E (0 damage)
$B2:882E BF 0B 00 B4 LDA $B4000B,x          ;|
$B2:8832 29 0F 00    AND #$000F             ;|
$B2:8835 F0 07       BEQ $07    [$883E]     ;/
$B2:8837 C9 0F 00    CMP #$000F             ;\
$B2:883A F0 02       BEQ $02    [$883E]     ;} If [$B4:000B + [$14] + (projectile type)] & Fh = 0: go to $883E (freeze???)
$B2:883C 80 DB       BRA $DB    [$8819]     ; Go to normal pirate shot
}


;;; $883E: Enemy shot - space pirate - Lower Norfair pirate is invincible ;;;
{
$B2:883E AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:8841 BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$B2:8844 C9 93 F5    CMP #$F593             ;} If not Lower Norfair pirate:
$B2:8847 F0 03       BEQ $03    [$884C]     ;/
$B2:8849 4C 89 87    JMP $8789  [$B2:8789]  ; Go to normal pirate shot

$B2:884C AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:884F AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$B2:8852 0A          ASL A                  ;} Y = (collided projectile index)
$B2:8853 A8          TAY                    ;/
$B2:8854 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$B2:8857 85 12       STA $12    [$7E:0012]  ;} $12 = [projectile type]
$B2:8859 29 00 0F    AND #$0F00             ;\
$B2:885C C9 00 02    CMP #$0200             ;} If projectile is super missile: go to BRANCH_SUPER
$B2:885F F0 06       BEQ $06    [$8867]     ;/
$B2:8861 C9 00 03    CMP #$0300             ;\
$B2:8864 30 06       BMI $06    [$886C]     ;} If projectile is beam or missile: go to BRANCH_REFLECT
$B2:8866 6B          RTL                    ; Return

; BRANCH_SUPER
$B2:8867 B9 7C 0C    LDA $0C7C,y            ;\
$B2:886A F0 33       BEQ $33    [$889F]     ;} If super missile link: return

; BRANCH_REFLECT
$B2:886C A9 0A 00    LDA #$000A             ;\
$B2:886F 9D A0 0F    STA $0FA0,x[$7E:0FE0]  ;} Enemy invincibility timer = Ah
$B2:8872 B9 04 0C    LDA $0C04,y[$7E:0C04]  ;\
$B2:8875 29 0F 00    AND #$000F             ;|
$B2:8878 C9 07 00    CMP #$0007             ;} If [projectile direction] = left:
$B2:887B D0 05       BNE $05    [$8882]     ;/
$B2:887D A9 01 00    LDA #$0001             ; Projectile direction = up-right
$B2:8880 80 0D       BRA $0D    [$888F]     ; Go to BRANCH_MERGE

$B2:8882 C9 02 00    CMP #$0002             ;\
$B2:8885 D0 05       BNE $05    [$888C]     ;} If [projectile direction] = right:
$B2:8887 A9 08 00    LDA #$0008             ; Projectile direction = up-left
$B2:888A 80 03       BRA $03    [$888F]     ; Go to BRANCH_MERGE

$B2:888C A9 05 00    LDA #$0005             ; Projectile direction = down, facing left

; BRANCH_MERGE
$B2:888F 99 04 0C    STA $0C04,y[$7E:0C04]
$B2:8892 84 14       STY $14    [$7E:0014]  ; $14 = [Y] (projectile index)
$B2:8894 22 00 BE 90 JSL $90BE00[$90:BE00]  ; Projectile reflection
$B2:8898 A9 66 00    LDA #$0066             ;\
$B2:889B 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)

$B2:889F 6B          RTL
}


;;; $88A0: Extended spritemaps ;;;
{
; [n entries] [[X offset] [Y offset] [p spritemap] [p hitbox]]...

; Wall space pirates
$B2:88A0             dx 0002, 0000,0000,AAB6,970E, 0000,0000,A8E2,9690
$B2:88B2             dx 0002, 0000,0000,AA78,9700, 0000,0000,A90C,969E
$B2:88C4             dx 0002, 0000,0000,AA3A,96F2, 0000,0000,A93B,96AC
$B2:88D6             dx 0002, 0000,0000,A965,96BA, 0000,0000,A9FC,96E4
$B2:88E8             dx 0002, 0000,0000,A999,96C8, 0000,0000,A9C8,96D6
$B2:88FA             dx 0002, 0000,FFFE,AB50,972A, 0000,0000,AAB6,970E
$B2:890C             dx 0002, 0001,FFFE,AB93,9738, 0000,0000,A9C8,96D6
$B2:891E             dx 0001, 0000,0000,ABDB,9746
$B2:8928             dx 0001, 0000,0000,AC41,9754
$B2:8932             dx 0002, 0000,0000,AE67,97E0, 0000,0000,AC93,9762
$B2:8944             dx 0002, 0000,0000,AE29,97D2, 0000,0000,ACBD,9770
$B2:8956             dx 0002, 0000,0000,ADEB,97C4, 0000,0000,ACEC,977E
$B2:8968             dx 0002, 0000,0000,AD16,978C, 0000,0000,ADAD,97B6
$B2:897A             dx 0002, 0000,0000,AD4A,979A, 0000,0000,AD79,97A8
$B2:898C             dx 0002, 0000,0000,AE9B,97EE, 0000,0002,AD79,97A8
$B2:899E             dx 0002, 0000,0000,AEDE,97FC, 0000,0002,AD79,97A8
$B2:89B0             dx 0001, 0000,0000,AF26,980A
$B2:89BA             dx 0001, 0000,0000,AF8C,9818

; Walking space pirates
$B2:89C4             dx 0002, FFFB,0003,B918,9B60, 0000,0000,AFDE,9826
$B2:89D6             dx 0002, FFFB,0003,B947,9B7C, 0000,0000,B012,9834
$B2:89E8             dx 0002, FFFB,0003,B976,9B8A, 0000,0000,B04B,9842
$B2:89FA             dx 0002, FFFB,0003,B9A0,9B98, 0002,0000,B089,9850
$B2:8A0C             dx 0002, FFFB,0003,B9A0,9B98, 0002,0000,B0C2,985E
$B2:8A1E             dx 0002, FFFB,0003,B976,9B8A, 0002,0000,B0F6,986C
$B2:8A30             dx 0002, FFFB,0003,B947,9B7C, 0000,0000,B12F,987A
$B2:8A42             dx 0002, FFFB,0003,B918,9B60, 0000,0000,B16D,9888

; Ninja space pirates
$B2:8A54             dx 0002, 0000,0005,B918,9B6E, 0000,0003,B20E,9922
$B2:8A66             dx 0002, 0000,0005,B9CA,9BA6, 0000,0003,B1A6,9896
$B2:8A78             dx 0002, 0000,0005,B9EF,9BB4, 0000,0003,B1A6,9896
$B2:8A8A             dx 0002, 0000,0004,BA14,9BC2, 0000,0003,B1A6,9896
$B2:8A9C             dx 0002, 0000,0003,BA43,9BD0, 0000,0003,B1A6,9896
$B2:8AAE             dx 0002, 0000,0005,BA14,9BC2, 0000,0003,B1A6,9896
$B2:8AC0             dx 0002, 0000,0005,B9CA,9BA6, 0000,0003,B1A6,9896
$B2:8AD2             dx 0002, 0000,0006,B9A0,9B98, 0000,0003,B1A6,9896
$B2:8AE4             dx 0002, 0000,0007,BD8B,9C5C, 0000,0003,B20E,9922

; Walking space pirates
$B2:8AF6             dx 0002, 0005,0003,C117,9D5E, 0000,0000,B278,994C
$B2:8B08             dx 0002, 0005,0003,C146,9D7A, 0000,0000,B2AC,995A
$B2:8B1A             dx 0002, 0005,0003,C175,9D88, 0000,0000,B2E5,9968
$B2:8B2C             dx 0002, 0005,0003,C19F,9D96, 0000,0000,B323,9976
$B2:8B3E             dx 0002, 0005,0003,C19F,9D96, FFFF,0000,B35C,9984
$B2:8B50             dx 0002, 0005,0003,C175,9D88, 0000,0000,B390,9992
$B2:8B62             dx 0002, 0005,0003,C146,9D7A, 0001,0000,B3C9,99A0
$B2:8B74             dx 0002, 0005,0003,C117,9D5E, 0001,0000,B407,99AE

; Ninja space pirates
$B2:8B86             dx 0002, 0000,0005,C117,9D6C, 0000,0003,B4A8,9A3A
$B2:8B98             dx 0002, 0000,0005,C1C9,9DA4, 0000,0003,B440,99BC
$B2:8BAA             dx 0002, 0000,0005,C1EE,9DB2, 0000,0003,B440,99BC
$B2:8BBC             dx 0002, 0000,0004,C213,9DC0, 0000,0003,B440,99BC
$B2:8BCE             dx 0002, 0000,0003,C242,9DCE, 0000,0003,B440,99BC
$B2:8BE0             dx 0002, 0000,0005,C213,9DC0, 0000,0003,B440,99BC
$B2:8BF2             dx 0002, 0000,0005,C19F,9D96, 0000,0003,B440,99BC
$B2:8C04             dx 0002, 0000,0006,C58A,9E5A, 0000,0003,B440,99BC ; Unused
$B2:8C16             dx 0002, 0000,0007,C58A,9E5A, 0000,0003,B4A8,9A3A

; Walking space pirates
$B2:8C28             dx 0002, 0000,0003,B508,9A48, 0000,0003,B1A6,9896
$B2:8C3A             dx 0002, 0000,0003,B537,9A56, 0000,0003,B1A6,9896
$B2:8C4C             dx 0002, 0000,0003,B566,9A64, 0000,0003,B1A6,9896
$B2:8C5E             dx 0002, 0000,0003,B59A,9A72, 0000,0003,B1A6,9896
$B2:8C70             dx 0002, FFFF,0004,B5C9,9A80, 0000,0003,B1A6,9896
$B2:8C82             dx 0002, FFFE,0006,B5F8,9A8E, 0000,0003,B20E,9922
$B2:8C94             dx 0002, 0000,0003,B627,9A9C, 0000,0003,B440,99BC
$B2:8CA6             dx 0002, 0000,0003,B656,9AAA, 0000,0003,B440,99BC
$B2:8CB8             dx 0002, 0000,0003,B685,9AB8, 0000,0003,B440,99BC
$B2:8CCA             dx 0002, 0000,0003,B6B9,9AC6, 0000,0003,B440,99BC
$B2:8CDC             dx 0002, 0001,0004,B6E8,9AD4, 0000,0003,B440,99BC
$B2:8CEE             dx 0002, 0002,0006,B717,9AE2, 0000,0003,B4A8,9A3A
$B2:8D00             dx 0003, FFFB,FFF4,B4DC,9A48, 0000,0003,B242,9930, 0000,0003,B1A6,9896
$B2:8D1A             dx 0002, 0000,0003,B508,9A48, 0000,0003,B1A6,9896
$B2:8D2C             dx 0003, FFFB,FFF5,B4F2,9A48, 0000,0003,B242,9930, 0000,0003,B1A6,9896
$B2:8D46             dx 0003, 0005,FFF4,B4DC,9A48, 0000,0003,B25D,993E, 0000,0003,B440,99BC
$B2:8D60             dx 0002, 0000,0003,B627,9A9C, 0000,0003,B440,99BC
$B2:8D72             dx 0003, 0005,FFF5,B4F2,9A48, 0000,0003,B25D,993E, 0000,0003,B440,99BC
$B2:8D8C             dx 0001, 0000,0001,AAEA,971C

; Ninja space pirates
$B2:8D96             dx 0001, 0000,0000,C733,9EDE
$B2:8DA0             dx 0001, 0000,0000,C749,9EEC
$B2:8DAA             dx 0001, 0000,0000,C769,9EFA
$B2:8DB4             dx 0001, 0000,0000,C784,9F08
$B2:8DBE             dx 0001, 0000,0000,C7A9,9F16
$B2:8DC8             dx 0001, 0000,0000,C7BF,9F24
$B2:8DD2             dx 0001, 0000,0000,C7DF,9F32
$B2:8DDC             dx 0001, 0000,0000,C7FA,9F40
$B2:8DE6             dx 0001, 0000,0000,C910,9F78
$B2:8DF0             dx 0001, 0000,0000,C926,9F86
$B2:8DFA             dx 0001, 0000,0000,C946,9F94
$B2:8E04             dx 0001, 0000,0000,C961,9FA2
$B2:8E0E             dx 0001, 0000,0000,C986,9FB0
$B2:8E18             dx 0001, 0000,0000,C99C,9FBE
$B2:8E22             dx 0001, 0000,0000,C9BC,9FCC
$B2:8E2C             dx 0001, 0000,0000,C9D7,9FDA
$B2:8E36             dx 0002, FFFB,0001,B918,9B60, 0000,FFFE,B746,9AF0
$B2:8E48             dx 0002, FFFB,0003,B947,9B7C, FFFF,0000,B77A,9AFE
$B2:8E5A             dx 0002, FFFB,0004,B976,9B8A, 0000,0000,B7B8,9B0C
$B2:8E6C             dx 0002, FFFB,0002,B9A0,9B98, FFFF,0000,B7F6,9B1A
$B2:8E7E             dx 0002, FFFB,0001,B9A0,9B98, 0002,FFFE,B82F,9B28
$B2:8E90             dx 0002, FFFB,0003,B976,9B8A, 0002,0000,B863,9B36
$B2:8EA2             dx 0002, FFFB,0003,B947,9B7C, 0000,0000,B8A1,9B44
$B2:8EB4             dx 0002, FFFB,0001,B918,9B60, 0000,0000,B8DF,9B52
$B2:8EC6             dx 0002, 0005,0001,C117,9D5E, 0000,FFFE,BF45,9CEE
$B2:8ED8             dx 0002, 0005,0003,C146,9D7A, 0000,0000,BF79,9CFC
$B2:8EEA             dx 0002, 0005,0004,C175,9D88, 0000,0000,BFB7,9D0A
$B2:8EFC             dx 0002, 0005,0002,C19F,9D96, 0000,0000,BFF5,9D18
$B2:8F0E             dx 0002, 0005,0001,C19F,9D96, FFFF,FFFF,C02E,9D26
$B2:8F20             dx 0002, 0005,0003,C175,9D88, 0000,0000,C062,9D34
$B2:8F32             dx 0002, 0005,0003,C146,9D7A, 0001,0000,C0A0,9D42
$B2:8F44             dx 0002, 0005,0001,C117,9D5E, 0001,0000,C0DE,9D50
$B2:8F56             dx 0001, 0000,0003,BA77,9BDE
$B2:8F60             dx 0001, 0000,0003,BADD,9BEC
$B2:8F6A             dx 0001, 0000,0003,BB3E,9BFA
$B2:8F74             dx 0001, 0000,0003,C276,9DDC
$B2:8F7E             dx 0001, 0000,0003,C2DC,9DEA
$B2:8F88             dx 0001, 0000,0003,C33D,9DF8

; Walking space pirates
$B2:8F92             dx 0001, 0000,0008,BDCB,9C78

; Ninja space pirates
$B2:8F9C             dx 0001, 0000,0008,BDCB,9C92

; Walking space pirates
$B2:8FA6             dx 0001, 0000,0008,C5B9,9E68

; Ninja space pirates
$B2:8FB0             dx 0001, 0000,0008,C5B9,9E82

; Unused
$B2:8FBA             dx 0001, 0000,0000,DEBA,A57C
$B2:8FC4             dx 0001, 0000,0000,DF20,A58A
$B2:8FCE             dx 0001, 0000,0000,DF6D,A598
$B2:8FD8             dx 0001, 0000,0000,DFB5,A5A6
$B2:8FE2             dx 0001, 0000,0000,E71A,A760
$B2:8FEC             dx 0001, 0000,0000,E780,A76E
$B2:8FF6             dx 0001, 0000,0000,E7CD,A77C
$B2:9000             dx 0001, 0000,0000,E815,A78A

; Ninja space pirates
$B2:900A             dx 0001, 0000,0000,DDEE,A560
$B2:9014             dx 0001, 0000,0000,E147,A612
$B2:901E             dx 0001, 0000,0000,E64E,A744
$B2:9028             dx 0001, 0000,0000,E996,A7E8
$B2:9032             dx 0001, 0005,0000,E08F,A5EA
$B2:903C             dx 0001, FFFB,0001,E0E6,A5F8
$B2:9046             dx 0001, FFFB,0000,E8DE,A7C0
$B2:9050             dx 0001, 0005,0001,E935,A7CE

; Unused
$B2:905A             dx 0001, 0000,0000,C9FC,9FE8
$B2:9064             dx 0001, 0000,0000,C9FC,9FE8
$B2:906E             dx 0002, FFFB,0003,DB1A,A4B8, 0000,0000,D0F8,A17E
$B2:9080             dx 0002, FFFB,0003,DB49,A4C6, 0000,0000,D12C,A18C
$B2:9092             dx 0002, FFFB,0003,DB78,A4D4, 0000,0000,D165,A19A
$B2:90A4             dx 0002, FFFB,0003,DBA2,A4E2, 0002,0000,D1A3,A1A8
$B2:90B6             dx 0002, FFFB,0003,DBA2,A4E2, 0002,0000,D1DC,A1B6
$B2:90C8             dx 0002, FFFB,0003,DB78,A4D4, 0002,0000,D210,A1C4
$B2:90DA             dx 0002, FFFB,0003,DB49,A4C6, 0000,0000,D249,A1D2
$B2:90EC             dx 0002, FFFB,0003,DB1A,A4B8, 0000,0000,D287,A1E0

; Ninja space pirates
$B2:90FE             dx 0002, 0000,0005,DB1A,A4B8, 0000,0003,D39C,A27A

; Unused
$B2:9110             dx 0002, 0000,0005,DBCC,A4F0, 0000,0003,D2C0,A1EE
$B2:9122             dx 0002, 0000,0005,DBF1,A4FE, 0000,0003,D2C0,A1EE
$B2:9134             dx 0002, 0000,0004,DC16,A50C, 0000,0003,D2C0,A1EE
$B2:9146             dx 0002, 0000,0003,DC45,A51A, 0000,0003,D2C0,A1EE
$B2:9158             dx 0002, 0000,0005,DC16,A50C, 0000,0003,D2C0,A1EE
$B2:916A             dx 0002, 0000,0005,DBCC,A4F0, 0000,0003,D2C0,A1EE
$B2:917C             dx 0002, 0000,0006,DBA2,A4E2, 0000,0003,D2C0,A1EE
$B2:918E             dx 0002, 0000,0007,DFFD,A5B4, 0000,0003,D39C,A27A
$B2:91A0             dx 0001, 0000,0003,D328,A20A
$B2:91AA             dx 0001, 0000,0003,D339,A218
$B2:91B4             dx 0001, 0000,0003,D345,A226
$B2:91BE             dx 0001, 0000,0003,D356,A234
$B2:91C8             dx 0001, 0000,0003,D362,A242
$B2:91D2             dx 0001, 0000,0003,D373,A250
$B2:91DC             dx 0001, 0000,0003,D37F,A25E
$B2:91E6             dx 0001, 0000,0003,D390,A26C
$B2:91F0             dx 0002, 0005,0003,E37A,A69C, 0000,0000,D406,A2A4
$B2:9202             dx 0002, 0005,0003,E3A9,A6AA, 0000,0000,D43A,A2B2
$B2:9214             dx 0002, 0005,0003,E3D8,A6B8, 0000,0000,D473,A2C0
$B2:9226             dx 0002, 0005,0003,E402,A6C6, 0000,0000,D4B1,A2CE
$B2:9238             dx 0002, 0005,0003,E402,A6C6, FFFF,0000,D4EA,A2DC
$B2:924A             dx 0002, 0005,0003,E3D8,A6B8, 0000,0000,D51E,A2EA
$B2:925C             dx 0002, 0005,0003,E3A9,A6AA, 0001,0000,D557,A2F8
$B2:926E             dx 0002, 0005,0003,E37A,A69C, 0001,0000,D595,A306

; Ninja space pirates
$B2:9280             dx 0002, 0000,0005,E37A,A69C, 0000,0003,D6AA,A392

; Unused
$B2:9292             dx 0002, 0000,0005,E42C,A6D4, 0000,0003,D5CE,A314
$B2:92A4             dx 0002, 0000,0005,E451,A6E2, 0000,0003,D5CE,A314
$B2:92B6             dx 0002, 0000,0004,E476,A6F0, 0000,0003,D5CE,A314
$B2:92C8             dx 0002, 0000,0003,E4A5,A6FE, 0000,0003,D5CE,A314
$B2:92DA             dx 0002, 0000,0005,E476,A6F0, 0000,0003,D5CE,A314
$B2:92EC             dx 0002, 0000,0005,E402,A6C6, 0000,0003,D5CE,A314
$B2:92FE             dx 0002, 0000,0006,E85D,A798, 0000,0003,D5CE,A314
$B2:9310             dx 0002, 0000,0007,E85D,A798, 0000,0003,D6AA,A392
$B2:9322             dx 0001, 0000,0000,D636,A322
$B2:932C             dx 0001, 0000,0000,D647,A330
$B2:9336             dx 0001, 0000,0000,D653,A33E
$B2:9340             dx 0001, 0000,0000,D664,A34C
$B2:934A             dx 0001, 0000,0000,D670,A35A
$B2:9354             dx 0001, 0000,0000,D681,A368
$B2:935E             dx 0001, 0000,0000,D68D,A376
$B2:9368             dx 0001, 0000,0004,D69E,A384

; Ninja space pirates
$B2:9372             dx 0001, 0002,0000,DE4A,A56E
$B2:937C             dx 0001, FFFE,0000,E6AA,A752

; Unused
$B2:9386             dx 0001, 0000,0003,C9FC,9FE8
$B2:9390             dx 0001, 0000,0003,C9FC,9FE8
$B2:939A             dx 0001, FFFF,0004,C9FC,9FE8
$B2:93A4             dx 0001, FFFE,0006,C9FC,9FE8
$B2:93AE             dx 0001, 0000,0003,C9FC,9FE8
$B2:93B8             dx 0001, 0000,0003,C9FC,9FE8
$B2:93C2             dx 0001, 0000,0003,C9FC,9FE8
$B2:93CC             dx 0001, 0000,0003,C9FC,9FE8
$B2:93D6             dx 0001, 0001,0004,C9FC,9FE8
$B2:93E0             dx 0001, 0002,0006,C9FC,9FE8

; Ninja space pirates
$B2:93EA             dx 0003, FFFB,FFF4,D6DE,A3A0, 0000,0003,D3D0,A288, 0000,0003,D2C0,A1EE
$B2:9404             dx 0002, 0000,0003,D70A,A3A0, 0000,0003,D2C0,A1EE
$B2:9416             dx 0003, FFFB,FFF5,D6F4,A3A0, 0000,0003,D3D0,A288, 0000,0003,D2C0,A1EE
$B2:9430             dx 0003, 0005,FFF4,D6DE,A3A0, 0000,0003,D3EB,A296, 0000,0003,D5CE,A314
$B2:944A             dx 0002, 0000,0003,D829,A3F4, 0000,0003,D5CE,A314
$B2:945C             dx 0003, 0005,FFF5,D6F4,A3A0, 0000,0003,D3EB,A296, 0000,0003,D5CE,A314
$B2:9476             dx 0001, 0000,0001,CC04,A074

; Unused
$B2:9480             dx 0001, 0000,0000,E9F7,A802
$B2:948A             dx 0001, 0000,0000,EA0D,A810
$B2:9494             dx 0001, 0000,0000,EA2D,A81E
$B2:949E             dx 0001, 0000,0000,EA48,A82C
$B2:94A8             dx 0001, 0000,0000,EA6D,A83A
$B2:94B2             dx 0001, 0000,0000,EA83,A848
$B2:94BC             dx 0001, 0000,0000,EAA3,A856
$B2:94C6             dx 0001, 0000,0000,EABE,A864
$B2:94D0             dx 0001, 0000,0000,EBD4,A872
$B2:94DA             dx 0001, 0000,0000,EBEA,A880
$B2:94E4             dx 0001, 0000,0000,EC0A,A88E
$B2:94EE             dx 0001, 0000,0000,EC25,A89C
$B2:94F8             dx 0001, 0000,0000,EC4A,A8AA
$B2:9502             dx 0001, 0000,0000,EC60,A8B8
$B2:950C             dx 0001, 0000,0000,EC80,A8C6
$B2:9516             dx 0001, 0000,0000,EC9B,A8D4
$B2:9520             dx 0002, FFFB,0001,DB1A,A4B8, 0000,FFFE,D948,A448
$B2:9532             dx 0002, FFFB,0003,DB49,A4C6, FFFF,0000,D97C,A456
$B2:9544             dx 0002, FFFB,0004,DB78,A4D4, 0000,0000,D9BA,A464
$B2:9556             dx 0002, FFFB,0002,DBA2,A4E2, FFFF,0000,D9F8,A472
$B2:9568             dx 0002, FFFB,0001,DBA2,A4E2, 0002,FFFE,DA31,A480
$B2:957A             dx 0002, FFFB,0003,DB78,A4D4, 0002,0000,DA65,A48E
$B2:958C             dx 0002, FFFB,0003,DB49,A4C6, 0000,0000,DAA3,A49C
$B2:959E             dx 0002, FFFB,0001,DB1A,A4B8, 0000,0000,DAE1,A4AA
$B2:95B0             dx 0002, 0005,0001,E37A,A69C, 0000,FFFE,E1A8,A62C
$B2:95C2             dx 0002, 0005,0003,E3A9,A6AA, 0000,0000,E1DC,A63A
$B2:95D4             dx 0002, 0005,0004,E3D8,A6B8, 0000,0000,E21A,A648
$B2:95E6             dx 0002, 0005,0002,E402,A6C6, 0000,0000,E258,A656
$B2:95F8             dx 0002, 0005,0001,E402,A6C6, FFFF,FFFF,E291,A664
$B2:960A             dx 0002, 0005,0003,E3D8,A6B8, 0000,0000,E2C5,A672
$B2:961C             dx 0002, 0005,0003,E3A9,A6AA, 0001,0000,E303,A680
$B2:962E             dx 0002, 0005,0001,E37A,A69C, 0001,0000,E341,A68E
$B2:9640             dx 0001, 0000,0003,DC79,A528
$B2:964A             dx 0001, 0000,0003,DCDF,A536
$B2:9654             dx 0001, 0000,0003,DD40,A544
$B2:965E             dx 0001, 0000,0003,E4D9,A70C
$B2:9668             dx 0001, 0000,0003,E53F,A71A
$B2:9672             dx 0001, 0000,0003,E5A0,A728
$B2:967C             dx 0001, 0000,0008,E03D,A5D0
$B2:9686             dx 0001, 0000,0008,E88C,A7A6
}


;;; $9690: Hitboxes ;;;
{
; [n entries] [[left offset] [top offset] [right offset] [bottom offset] [p touch] [p shot]]...

; Wall space pirates
$B2:9690             dx 0001, FFEE,FFED,0006,0000,876C,8779
$B2:969E             dx 0001, FFEE,FFED,0006,0000,876C,8779
$B2:96AC             dx 0001, FFEE,FFED,0006,0000,876C,8779
$B2:96BA             dx 0001, FFEE,FFED,0006,0000,876C,8779
$B2:96C8             dx 0001, FFEE,FFED,0006,0000,876C,8779
$B2:96D6             dx 0001, FFF2,0000,0004,001E,876C,8779
$B2:96E4             dx 0001, FFF1,0000,FFFF,001E,876C,8779
$B2:96F2             dx 0001, FFF1,FFFA,0000,0017,876C,8779
$B2:9700             dx 0001, FFF0,FFFB,FFFF,0019,876C,8779
$B2:970E             dx 0001, FFEF,FFF8,0000,001E,876C,8779

; Walking space pirates
$B2:971C             dx 0001, FFF3,FFED,000A,001E,876C,8779 ; Unused

; Wall space pirates
$B2:972A             dx 0001, FFF1,FFED,000E,0006,876C,8779
$B2:9738             dx 0001, FFF0,FFED,000E,0003,876C,8779
$B2:9746             dx 0001, FFF6,FFEB,0013,0016,876C,8779
$B2:9754             dx 0001, FFF8,FFED,0012,0010,876C,8779
$B2:9762             dx 0001, FFF7,FFE9,0011,0000,876C,8779
$B2:9770             dx 0001, FFF7,FFED,0010,0000,876C,8779
$B2:977E             dx 0001, FFF7,FFED,0011,0000,876C,8779
$B2:978C             dx 0001, FFF7,FFED,0010,0000,876C,8779
$B2:979A             dx 0001, FFF7,FFED,0011,0000,876C,8779
$B2:97A8             dx 0001, FFF9,0000,000F,001E,876C,8779
$B2:97B6             dx 0001, FFFE,0000,000F,001E,876C,8779
$B2:97C4             dx 0001, FFFE,0000,000F,0017,876C,8779
$B2:97D2             dx 0001, 0000,0000,000F,0019,876C,8779
$B2:97E0             dx 0001, FFFF,0000,000F,001E,876C,8779
$B2:97EE             dx 0001, FFF1,FFED,000F,0000,876C,8779
$B2:97FC             dx 0001, FFF1,FFED,000E,0003,876C,8779
$B2:980A             dx 0001, FFEC,FFED,000A,0019,876C,8779
$B2:9818             dx 0001, FFEC,FFED,0006,0010,876C,8779

; Walking space pirates
$B2:9826             dx 0001, FFF5,0000,0008,001E,876C,8779
$B2:9834             dx 0001, FFF5,0000,0008,001E,876C,8779
$B2:9842             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9850             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:985E             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:986C             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:987A             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9888             dx 0001, FFF9,0000,0006,001E,876C,8779

; Walking / ninja space pirates
$B2:9896             dx 0001, FFF9,0000,0006,001E,876C,883E

$B2:98A4             dx 0001, FFF9,0000,0006,0010,876C,8779
$B2:98B2             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:98C0             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:98CE             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:98DC             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:98EA             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:98F8             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:9906             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:9914             dx 0001, FFF9,FFF7,0006,0006,876C,8779

; Walking / ninja space pirates
$B2:9922             dx 0001, FFF9,0000,0006,001E,876C,883E

; Walking space pirates
$B2:9930             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:993E             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:994C             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:995A             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9968             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9976             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9984             dx 0001, FFF9,FFFF,0006,001E,876C,8779
$B2:9992             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:99A0             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:99AE             dx 0001, FFF9,0000,0006,001E,876C,8779

; Walking / ninja space pirates
$B2:99BC             dx 0001, FFF9,0000,0006,001E,876C,883E

$B2:99CA             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:99D8             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:99E6             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:99F4             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:9A02             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:9A10             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:9A1E             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:9A2C             dx 0001, FFF9,FFF7,0006,0006,876C,8779

; Walking / ninja space pirates
$B2:9A3A             dx 0001, FFF9,0000,0006,001E,876C,883E

; Walking space pirates
$B2:9A48             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9A56             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9A64             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9A72             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9A80             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9A8E             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9A9C             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9AAA             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9AB8             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9AC6             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9AD4             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9AE2             dx 0001, FFF9,FFED,0006,0000,876C,8779

; Ninja space pirates
$B2:9AF0             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9AFE             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9B0C             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9B1A             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9B28             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9B36             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9B44             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9B52             dx 0001, FFF9,0000,0006,001E,876C,8779

; Walking / ninja space pirates
$B2:9B60             dx 0001, FFF9,FFED,0006,0000,876C,87C8
$B2:9B6E             dx 0001, FFF9,FFED,0006,0000,876C,883E ; Ninja space pirates only
$B2:9B7C             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9B8A             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9B98             dx 0001, FFF9,FFED,0006,0000,876C,883E

; Ninja space pirates
$B2:9BA6             dx 0001, FFF9,FFED,0006,0000,876C,883E
$B2:9BB4             dx 0001, FFF9,FFED,0006,0000,876C,883E
$B2:9BC2             dx 0001, FFF9,FFED,0006,0000,876C,883E
$B2:9BD0             dx 0001, FFF9,FFED,0006,0000,876C,883E
$B2:9BDE             dx 0001, FFF9,FFED,0006,001E,876C,883E
$B2:9BEC             dx 0001, FFF9,FFED,0006,001E,876C,883E
$B2:9BFA             dx 0001, FFF9,FFED,0006,001E,876C,883E

; Unused
$B2:9C08             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:9C16             dx 0001, FFF1,FFED,000B,0019,876C,8779
$B2:9C24             dx 0001, FFEE,FFED,0008,0018,876C,8779
$B2:9C32             dx 0001, FFF1,FFED,000B,0010,876C,8779
$B2:9C40             dx 0001, FFF0,FFED,000C,0010,876C,8779
$B2:9C4E             dx 0001, FFF0,FFED,000B,0010,876C,8779

; Ninja space pirates
$B2:9C5C             dx 0001, FFF9,FFED,0006,0000,876C,883E

; Unused
$B2:9C6A             dx 0001, FFF9,FFF7,0006,0006,876C,8779

; Walking space pirates
$B2:9C78             dx 0002, FFF9,FFED,0006,0017,876C,8779, FFEE,FFEE,FFF9,0002,876C,87C8

; Ninja space pirates
$B2:9C92             dx 0002, FFF9,FFED,0006,0017,876C,883E, FFEE,FFEE,FFF9,0002,876C,883E

; Unused
$B2:9CAC             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:9CBA             dx 0002, FFF9,FFED,0006,001E,876C,8779, FFDE,FFFB,0003,0003,876C,8779
$B2:9CD4             dx 0002, FFF9,FFED,0006,0010,876C,8779, FFE0,FFFA,FFFE,0004,876C,8779

; Ninja space pirates
$B2:9CEE             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9CFC             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9D0A             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9D18             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9D26             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9D34             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9D42             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:9D50             dx 0001, FFF9,0000,0006,001E,876C,8779

; Walking / ninja space pirates
$B2:9D5E             dx 0001, FFF9,FFED,0006,0000,876C,87C8
$B2:9D6C             dx 0001, FFF9,FFED,0006,0000,876C,883E ; Ninja space pirates only
$B2:9D7A             dx 0001, FFF9,FFED,0006,0000,876C,87C8
$B2:9D88             dx 0001, FFF9,FFED,0006,0000,876C,87C8
$B2:9D96             dx 0001, FFF9,FFED,0006,0000,876C,87C8

; Ninja space pirates
$B2:9DA4             dx 0001, FFF9,FFED,0006,0000,876C,883E
$B2:9DB2             dx 0001, FFF9,FFED,0006,0000,876C,883E
$B2:9DC0             dx 0001, FFF9,FFED,0006,0000,876C,883E
$B2:9DCE             dx 0001, FFF9,FFED,0006,0000,876C,883E
$B2:9DDC             dx 0001, FFF9,FFED,0006,001E,876C,883E
$B2:9DEA             dx 0001, FFF9,FFED,0006,001E,876C,883E
$B2:9DF8             dx 0001, FFF9,FFED,0006,001E,876C,883E

; Unused
$B2:9E06             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:9E14             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:9E22             dx 0001, FFF7,FFED,0010,0014,876C,8779
$B2:9E30             dx 0001, FFF5,FFED,000E,0010,876C,8779
$B2:9E3E             dx 0001, FFF5,FFED,000F,0010,876C,8779
$B2:9E4C             dx 0001, FFF5,FFED,000E,0010,876C,8779

; Ninja space pirates
$B2:9E5A             dx 0001, FFF9,FFED,0006,0000,876C,883E

; Walking space pirates
$B2:9E68             dx 0002, FFF9,FFED,0006,0017,876C,8779, 0006,FFED,0011,0001,876C,87C8

; Ninja space pirates
$B2:9E82             dx 0002, FFF9,FFED,0006,0017,876C,883E, 0006,FFED,0011,0001,876C,883E

; Unused
$B2:9E9C             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:9EAA             dx 0002, FFF9,FFED,0006,001E,876C,8779, 0006,FFFB,0020,0004,876C,8779
$B2:9EC4             dx 0002, FFF9,FFED,0006,0010,876C,8779, 0006,FFFA,001F,0004,876C,8779

; Ninja space pirates
$B2:9EDE             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9EEC             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9EFA             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9F08             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9F16             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9F24             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9F32             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9F40             dx 0001, FFF5,FFF3,000A,000A,876C,883E

; Unused
$B2:9F4E             dx 0001, FFF3,FFEC,000C,0006,876C,8779
$B2:9F5C             dx 0001, FFF1,FFEC,000D,0006,876C,8779
$B2:9F6A             dx 0001, FFF8,FFEA,000C,0019,876C,8779

; Ninja space pirates
$B2:9F78             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9F86             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9F94             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9FA2             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9FB0             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9FBE             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9FCC             dx 0001, FFF5,FFF3,000A,000A,876C,883E
$B2:9FDA             dx 0001, FFF5,FFF3,000A,000A,876C,883E

; Unused
$B2:9FE8             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:9FF6             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A004             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A012             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A020             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A02E             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A03C             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A04A             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A058             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A066             dx 0001, FFF9,0000,0006,001E,876C,8779

; Ninja space pirates
$B2:A074             dx 0001, FFF9,FFED,0006,001E,876C,883E

; Unused
$B2:A082             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A090             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A09E             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A0AC             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A0BA             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A0C8             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A0D6             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A0E4             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A0F2             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A100             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A10E             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A11C             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A12A             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A138             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A146             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A154             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A162             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A170             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A17E             dx 0001, FFF9,FFFF,0006,001E,876C,8779
$B2:A18C             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A19A             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A1A8             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A1B6             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A1C4             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A1D2             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A1E0             dx 0001, FFF9,0000,0006,001E,876C,8779

; Ninja space pirates
$B2:A1EE             dx 0001, FFF9,0000,0006,001E,876C,883E

; Unused
$B2:A1FC             dx 0001, FFF9,0000,0006,0010,876C,8779
$B2:A20A             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A218             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A226             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A234             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A242             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A250             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A25E             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A26C             dx 0001, FFF9,FFF7,0006,0006,876C,8779

; Ninja space pirates
$B2:A27A             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A288             dx 0001, FFF9,FFED,0006,0000,876C,883E
$B2:A296             dx 0001, FFF9,FFED,0006,0000,876C,883E

; Unused
$B2:A2A4             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A2B2             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A2C0             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A2CE             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A2DC             dx 0001, FFF9,FFFF,0006,001E,876C,8779
$B2:A2EA             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A2F8             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A306             dx 0001, FFF9,0000,0006,001E,876C,8779

; Ninja space pirates
$B2:A314             dx 0001, FFF9,0000,0006,001E,876C,883E

; Unused
$B2:A322             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A330             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A33E             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A34C             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A35A             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A368             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A376             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A384             dx 0001, FFF9,FFF7,0006,0006,876C,8779

; Ninja space pirates
$B2:A392             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A3A0             dx 0001, FFF9,FFED,0006,0000,876C,883E

; Unused
$B2:A3AE             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A3BC             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A3CA             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A3D8             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A3E6             dx 0001, FFF9,FFED,0006,0000,876C,8779

; Ninja space pirates
$B2:A3F4             dx 0001, FFF9,FFED,0006,0000,876C,883E

; Unused
$B2:A402             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A410             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A41E             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A42C             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A43A             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A448             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A456             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A464             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A472             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A480             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A48E             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A49C             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A4AA             dx 0001, FFF9,0000,0006,001E,876C,8779

; Ninja space pirates
$B2:A4B8             dx 0001, FFF9,FFED,0006,0000,876C,8779

; Unused
$B2:A4C6             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A4D4             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A4E2             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A4F0             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A4FE             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A50C             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A51A             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A528             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:A536             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:A544             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:A552             dx 0001, FFF9,FFED,0006,001E,876C,8779

; Ninja space pirates
$B2:A560             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A56E             dx 0001, FFF9,FFED,0006,001E,876C,883E

; Unused
$B2:A57C             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A58A             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A598             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A5A6             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A5B4             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A5C2             dx 0001, FFF9,FFF7,0006,0006,876C,8779
$B2:A5D0             dx 0002, FFF9,FFED,0006,0017,876C,8779, FFEE,FFEE,FFF9,0002,876C,8779

; Ninja space pirates
$B2:A5EA             dx 0001, FFF9,FFED,0006,001E,876C,883E
$B2:A5F8             dx 0002, FFF9,FFED,0006,001E,876C,883E, FFDE,FFFB,0003,001E,876C,883E
$B2:A612             dx 0002, FFF9,FFED,0006,0010,876C,8779, FFDF,0003,FFF9,0010,876C,8779

; Unused
$B2:A62C             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A63A             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A648             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A656             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A664             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A672             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A680             dx 0001, FFF9,0000,0006,001E,876C,8779
$B2:A68E             dx 0001, FFF9,0000,0006,001E,876C,8779

; Ninja space pirates
$B2:A69C             dx 0001, FFF9,FFED,0006,0000,876C,8779

; Unused
$B2:A6AA             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A6B8             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A6C6             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A6D4             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A6E2             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A6F0             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A6FE             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A70C             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:A71A             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:A728             dx 0001, FFF9,FFED,0006,001E,876C,8779
$B2:A736             dx 0001, FFF9,FFED,0006,001E,876C,8779

; Ninja space pirates
$B2:A744             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A752             dx 0001, FFF9,FFED,0006,001E,876C,883E

; Unused
$B2:A760             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A76E             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A77C             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A78A             dx 0001, FFF9,FFED,0006,0010,876C,8779
$B2:A798             dx 0001, FFF9,FFED,0006,0000,876C,8779
$B2:A7A6             dx 0002, FFF9,FFED,0006,0017,876C,8779, 0006,FFED,0011,0001,876C,8779

; Ninja space pirates
$B2:A7C0             dx 0001, FFF9,FFED,0006,001E,876C,883E
$B2:A7CE             dx 0002, FFF9,FFED,0006,001E,876C,883E, 0006,FFFA,0020,001E,876C,883E
$B2:A7E8             dx 0002, FFF9,FFED,0006,0010,876C,8779, 0006,0003,001F,0010,876C,8779

; Unused
$B2:A802             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A810             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A81E             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A82C             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A83A             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A848             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A856             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A864             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A872             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A880             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A88E             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A89C             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A8AA             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A8B8             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A8C6             dx 0001, FFF5,FFF3,000A,000A,876C,8779
$B2:A8D4             dx 0001, FFF5,FFF3,000A,000A,876C,8779
}


;;; $A8E2: Spritemaps ;;;
{
; Wall space pirates
$B2:A8E2             dx 0008, 01EF,FD,214D, 01EF,F5,213D, 01EF,ED,212D, 81F4,F3,2100, 81F8,F0,212E, 81F1,EA,210E, 01EF,E6,213D, 01EF,DE,212D
$B2:A90C             dx 0009, 01FC,F3,214F, 01F4,F4,214E, 01EF,F9,214D, 01EF,F1,213D, 01EF,E9,212D, 81F8,F0,212E, 81F1,EA,210E, 01EF,EA,213D, 01EF,E2,212D
$B2:A93B             dx 0008, 01EF,F3,214D, 01EF,EB,213D, 01EF,E3,212D, 01FB,F3,214F, 01F3,F3,214E, 81F8,F0,212E, 81F1,EA,210E, 01EF,E1,212D
$B2:A965             dx 000A, 01FB,F1,214F, 01F3,F0,214E, 01EF,ED,214D, 01EF,E5,213D, 01EF,DD,212D, 81F8,F0,212E, 81F1,EA,210E, 01EF,EF,213D, 01EF,F7,214D, 81F1,F0,2100
$B2:A999             dx 0009, 81F4,EB,E105, 01EF,EB,214D, 01EF,E3,213D, 01EF,DB,212D, 81F8,F0,212E, 81F1,EA,210E, 01EF,F1,213D, 01EF,F9,214D, 81F1,F2,2100
$B2:A9C8             dx 000A, 01F4,19,2146, 01F7,13,2119, 01F7,0B,2109, 81F9,FE,2107, 01EC,19,2145, 01F5,FE,2131, 01F5,F6,2121, 81F6,F5,E10C, 01F4,05,2146, 01EC,05,2145
$B2:A9FC             dx 000C, 0000,FD,2149, 01F8,FF,2148, 01F4,14,2146, 01EC,14,2145, 0000,FB,2149, 01F8,F9,2148, 01F5,0D,211A, 01F5,05,210A, 01F5,02,2131, 01F5,FA,2121, 01F4,09,2146, 01EC,09,2145
$B2:AA3A             dx 000C, 0000,F9,2149, 01F8,FB,2148, 01F4,10,2146, 01EC,10,2145, 0000,FB,2149, 01F8,F9,2148, 01F5,09,211A, 01F5,01,210A, 01F5,06,2131, 01F5,FE,2121, 01F4,0D,2146, 01EC,0D,2145
$B2:AA78             dx 000C, 01F3,03,2131, 01F3,FB,2121, 01F4,0A,2146, 01EC,0A,2145, 0000,FC,2149, 01F8,FA,2148, 0000,FE,2149, 01F8,00,2148, 01F4,12,2146, 01EC,12,2145, 01F5,0C,211A, 01F5,04,210A
$B2:AAB6             dx 000A, 01F5,00,2131, 01F5,F8,2121, 81F7,F6,E10C, 01F4,07,2146, 01EC,07,2145, 01F4,16,2146, 01F6,10,2119, 01F6,08,2109, 81F8,FD,2107, 01EC,16,2145

; Walking space pirates
$B2:AAEA             dx 0014, 0007,FE,615D, 0007,F6,615C, 0007,EE,615B, 01FF,14,615A, 01FF,FE,6157, 01FF,0C,6159, 01FF,06,6158, 01FF,F8,6156, 01FF,F0,6155, 01FF,E8,6154, 01F0,00,215D, 01F0,F8,215C, 01F0,F0,215B, 01F8,18,215A, 01F8,00,2157, 01F8,10,2159, 01F8,08,2158, 01F8,F8,2156, 01F8,F0,2155, 01F8,E8,2154

; Wall space pirates
$B2:AB50             dx 000D, 81F9,FC,2127, 8001,FC,2128, 01F1,F7,214D, 01F1,EF,213D, 01F1,E7,212D, 0006,FB,6112, 0006,F3,6102, 81FA,EB,210E, 0003,F9,6142, 01FB,F1,6141, 0003,F1,6140, 01FB,F9,6147, 81F1,F0,2100
$B2:AB93             dx 000E, 01F0,F7,214D, 01F0,EF,213D, 01F0,E7,212D, 81FE,EB,610E, 81F1,F0,2100, 0003,F9,6142, 01FB,F1,6141, 0003,F1,6140, 01FB,F9,6147, 0008,FD,A14D, 0008,05,A13D, 0008,0D,A12D, 0006,FB,6112, 0006,F3,6102
$B2:ABDB             dx 0014, 0000,F2,614F, 0008,F1,614E, 000C,EE,614D, 000C,E6,613D, 000C,DE,612D, 81FB,F1,612E, 8002,EB,610E, 000C,F0,613D, 000C,F8,614D, 8002,F1,6100, 81F9,FF,6107, 01F4,11,6144, 01F4,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143
$B2:AC41             dx 0010, 0008,FC,614D, 0009,F4,613D, 000A,EC,612D, 000B,FD,614D, 000C,F5,613D, 000D,ED,612D, 81FD,F3,6100, 81F9,F0,612E, 8000,EA,610E, 01FA,0B,6144, 01FA,03,6143, 01FE,09,6146, 0006,09,6145, 01FB,FE,6149, 0003,FD,6148, 81FD,FF,6122
$B2:AC93             dx 0008, 0009,FD,614D, 0009,F5,613D, 0009,ED,612D, 81FC,F3,6100, 81F8,F0,612E, 81FF,EA,610E, 0009,E6,613D, 0009,DE,612D
$B2:ACBD             dx 0009, 01FC,F3,614F, 0004,F4,614E, 0009,F9,614D, 0009,F1,613D, 0009,E9,612D, 81F8,F0,612E, 81FF,EA,610E, 0009,EA,613D, 0009,E2,612D
$B2:ACEC             dx 0008, 0009,F3,614D, 0009,EB,613D, 0009,E3,612D, 01FD,F3,614F, 0005,F3,614E, 81F8,F0,612E, 81FF,EA,610E, 0009,E1,612D
$B2:AD16             dx 000A, 01FD,F1,614F, 0005,F0,614E, 0009,ED,614D, 0009,E5,613D, 0009,DD,612D, 81F8,F0,612E, 81FF,EA,610E, 0009,EF,613D, 0009,F7,614D, 81FF,F0,6100
$B2:AD4A             dx 0009, 81FC,EB,A105, 0009,EB,614D, 0009,E3,613D, 0009,DB,612D, 81F8,F0,612E, 81FF,EA,610E, 0009,F1,613D, 0009,F9,614D, 81FF,F2,6100
$B2:AD79             dx 000A, 0004,19,6146, 0001,13,6119, 0001,0B,6109, 81F7,FE,6107, 000C,19,6145, 0003,FE,6131, 0003,F6,6121, 81FA,F5,A10C, 0004,05,6146, 000C,05,6145
$B2:ADAD             dx 000C, 01F8,FD,6149, 0000,FF,6148, 0004,14,6146, 000C,14,6145, 01F8,FB,6149, 0000,F9,6148, 0003,0D,611A, 0003,05,610A, 0003,02,6131, 0003,FA,6121, 0004,09,6146, 000C,09,6145
$B2:ADEB             dx 000C, 01F8,F9,6149, 0000,FB,6148, 0004,10,6146, 000C,10,6145, 01F8,FB,6149, 0000,F9,6148, 0003,09,611A, 0003,01,610A, 0003,06,6131, 0003,FE,6121, 0004,0D,6146, 000C,0D,6145
$B2:AE29             dx 000C, 0005,03,6131, 0005,FB,6121, 0004,0A,6146, 000C,0A,6145, 01F8,FC,6149, 0000,FA,6148, 01F8,FE,6149, 0000,00,6148, 0004,12,6146, 000C,12,6145, 0003,0C,611A, 0003,04,610A
$B2:AE67             dx 000A, 0003,00,6131, 0003,F8,6121, 81F9,F6,A10C, 0004,07,6146, 000C,07,6145, 0004,16,6146, 0002,10,6119, 0002,08,6109, 81F8,FD,6107, 000C,16,6145
$B2:AE9B             dx 000D, 81F7,FC,6127, 81EF,FC,6128, 0007,F7,614D, 0007,EF,613D, 0007,E7,612D, 01F2,FB,2112, 01F2,F3,2102, 81F6,EB,610E, 01F5,F9,2142, 01FD,F1,2141, 01F5,F1,2140, 01FD,F9,2147, 81FF,F0,6100
$B2:AEDE             dx 000E, 0008,F7,614D, 0008,EF,613D, 0008,E7,612D, 81F2,EB,210E, 81FF,F0,6100, 01F5,F9,2142, 01FD,F1,2141, 01F5,F1,2140, 01FD,F9,2147, 01F0,FD,E14D, 01F0,05,E13D, 01F0,0D,E12D, 01F2,FB,2112, 01F2,F3,2102
$B2:AF26             dx 0014, 01F8,F2,214F, 01F0,F1,214E, 01EC,EE,214D, 01EC,E6,213D, 01EC,DE,212D, 81F5,F1,212E, 81EE,EB,210E, 01EC,F0,213D, 01EC,F8,214D, 81EE,F1,2100, 81F7,FF,2107, 0004,11,2144, 0004,09,2143, 01F7,09,E149, 01FF,09,E148, 81F4,FF,2107, 01F5,0B,E149, 01FD,0B,E148, 01FE,13,2144, 01FE,0B,2143
$B2:AF8C             dx 0010, 01F0,FC,214D, 01EF,F4,213D, 01EE,EC,212D, 01ED,FD,214D, 01EC,F5,213D, 01EB,ED,212D, 81F3,F3,2100, 81F7,F0,212E, 81F0,EA,210E, 01FE,0B,2144, 01FE,03,2143, 01FA,09,2146, 01F2,09,2145, 01FD,FE,2149, 01F5,FD,2148, 81F3,FF,2122

; Walking space pirates
$B2:AFDE             dx 000A, 01F5,13,2130, 01F4,0B,2120, 01F2,18,2136, 01EB,18,2135, 81F5,00,2107, 0006,18,2144, 0006,10,2143, 81FE,0B,2122, 01FD,08,211B, 01FD,00,210B
$B2:B012             dx 000B, 01F9,12,2131, 01F9,0A,2121, 01F7,18,2126, 01EF,18,2125, 01FA,06,2119, 01FA,FE,2109, 0005,17,2144, 0005,0F,2143, 81FA,08,2122, 01FB,06,211A, 01FB,FE,210A
$B2:B04B             dx 000C, 01FD,18,2126, 01F5,18,2125, 01FE,14,2131, 01FE,0C,2121, 01FC,06,211A, 01FC,FE,210A, 0004,18,2144, 0004,10,2143, 01FD,10,211B, 01FD,08,210B, 01FB,04,2119, 01FB,FC,2109
$B2:B089             dx 000B, 01FA,16,2126, 01F2,16,2125, 0004,18,2146, 01FC,18,2145, 0001,13,2134, 0001,0B,2124, 01FC,07,211B, 01FD,FF,210B, 81F4,00,2107, 01F8,12,2134, 01F8,0A,2124
$B2:B0C2             dx 000A, 01FA,00,210A, 01F2,18,2136, 01EB,18,2135, 0006,18,2144, 0006,10,2143, 81FB,0A,2122, 01F9,08,211B, 01F4,13,2130, 01F3,0B,2120, 81F4,00,2107
$B2:B0F6             dx 000B, 01F7,13,2131, 01F7,0B,2121, 0005,17,2144, 0005,0F,2143, 81FA,08,2122, 01FB,06,211A, 01FB,FE,210A, 01F6,18,2126, 01EE,18,2125, 01F8,07,2119, 01F8,FF,2109
$B2:B12F             dx 000C, 01FB,06,2119, 01FB,FE,2109, 0002,19,2144, 0002,11,2143, 01FC,11,211B, 01FC,09,210B, 01FD,18,2126, 01F5,18,2125, 01FE,15,2131, 01FE,0D,2121, 01FC,08,211A, 01FC,00,210A
$B2:B16D             dx 000B, 01FA,16,2126, 01F2,16,2125, 81F6,00,2107, 01F8,12,2134, 01F8,0A,2124, 0004,18,2146, 01FC,18,2145, 0001,13,2134, 0001,0B,2124, 01FC,07,211B, 01FD,FF,210B

; Walking / ninja space pirates
$B2:B1A6             dx 000A, 01F8,11,2134, 01FC,FE,2109, 01FC,06,2119, 0003,15,2126, 01FC,15,2125, 81F5,FF,2107, 81FB,0A,2122, 01FA,15,2126, 01F2,15,2125, 01F8,09,2124
$B2:B1DA             dx 000A, 81F7,FF,2107, 0004,11,2144, 0004,09,2143, 01F7,09,E149, 01FF,09,E148, 81F4,FF,2107, 01F5,0B,E149, 01FD,0B,E148, 01FE,13,2144, 01FE,0B,2143 ; Unused
$B2:B20E             dx 000A, 01FC,08,2119, 01FC,00,2109, 81F4,01,2107, 01F6,09,2124, 01F7,11,2134, 0002,15,2126, 01FC,15,2125, 81FA,0B,2122, 01F9,15,2126, 01F2,15,2125

; Walking space pirates
$B2:B242             dx 0005, 81EA,00,2127, 81F2,00,2128, 01FB,FB,2113, 01FB,F3,2103, 81F8,F0,212E
$B2:B25D             dx 0005, 8006,00,6127, 81FE,00,6128, 01FD,FB,6113, 01FD,F3,6103, 81F8,F0,612E
$B2:B278             dx 000A, 0003,13,6130, 0004,0B,6120, 0006,18,6136, 000D,18,6135, 81FB,00,6107, 01F2,18,6144, 01F2,10,6143, 81F2,0B,6122, 01FB,08,611B, 01FB,00,610B
$B2:B2AC             dx 000B, 01FF,12,6131, 01FF,0A,6121, 0001,18,6126, 0009,18,6125, 01FE,06,6119, 01FE,FE,6109, 01F3,17,6144, 01F3,0F,6143, 81F6,08,6122, 01FD,06,611A, 01FD,FE,610A
$B2:B2E5             dx 000C, 01FB,18,6126, 0003,18,6125, 01FA,14,6131, 01FA,0C,6121, 01FC,06,611A, 01FC,FE,610A, 01F4,18,6144, 01F4,10,6143, 01FB,10,611B, 01FB,08,610B, 01FD,04,6119, 01FD,FC,6109
$B2:B323             dx 000B, 01FE,16,6126, 0006,16,6125, 01F4,18,6146, 01FC,18,6145, 01F7,13,6134, 01F7,0B,6124, 01FC,07,611B, 01FB,FF,610B, 81FC,00,6107, 0000,12,6134, 0000,0A,6124
$B2:B35C             dx 000A, 01FE,00,610A, 0006,18,6136, 000D,18,6135, 01F2,18,6144, 01F2,10,6143, 81F5,0A,6122, 01FF,08,611B, 0004,13,6130, 0005,0B,6120, 81FC,00,6107
$B2:B390             dx 000B, 0001,13,6131, 0001,0B,6121, 01F3,17,6144, 01F3,0F,6143, 81F6,08,6122, 01FD,06,611A, 01FD,FE,610A, 0002,18,6126, 000A,18,6125, 0000,07,6119, 0000,FF,6109
$B2:B3C9             dx 000C, 01FD,06,6119, 01FD,FE,6109, 01F6,19,6144, 01F6,11,6143, 01FC,11,611B, 01FC,09,610B, 01FB,18,6126, 0003,18,6125, 01FA,15,6131, 01FA,0D,6121, 01FC,08,611A, 01FC,00,610A
$B2:B407             dx 000B, 01FE,16,6126, 0006,16,6125, 81FA,00,6107, 0000,12,6134, 0000,0A,6124, 01F4,18,6146, 01FC,18,6145, 01F7,13,6134, 01F7,0B,6124, 01FC,07,611B, 01FB,FF,610B

; Walking / ninja space pirates
$B2:B440             dx 000A, 0000,11,6134, 01FC,FE,6109, 01FC,06,6119, 01F5,15,6126, 01FC,15,6125, 81FB,FF,6107, 81F5,0A,6122, 01FE,15,6126, 0006,15,6125, 0000,09,6124
$B2:B474             dx 000A, 81F9,FF,6107, 01F4,11,6144, 01F4,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143 ; Unused
$B2:B4A8             dx 000A, 01FC,08,6119, 01FC,00,6109, 81FC,01,6107, 0002,09,6124, 0001,11,6134, 01F6,15,6126, 01FC,15,6125, 81F6,0B,6122, 01FF,15,6126, 0006,15,6125

; Walking space pirates
$B2:B4DC             dx 0004, 0000,00,6151, 01F8,00,2151, 0000,F8,6150, 01F8,F8,2150
$B2:B4F2             dx 0004, 0000,00,6153, 0000,F8,6152, 01F8,00,2153, 01F8,F8,2152
$B2:B508             dx 0009, 01FB,FB,2113, 01FB,F3,2103, 0000,F8,213F, 01F8,F8,213E, 01FF,F0,212F, 01F7,F0,212E, 81EA,00,2127, 81F2,00,2128, 81F0,EB,210E
$B2:B537             dx 0009, 01FA,FB,2113, 01FA,F3,2103, 0000,F8,213F, 01F8,F8,213E, 01FE,F0,212F, 01F6,F0,212E, 81E9,00,2127, 81F1,00,2128, 81EE,EC,210E
$B2:B566             dx 000A, 01F8,00,214C, 01F0,00,214B, 01E8,00,214A, 01F9,FB,2113, 01F9,F3,2103, 01FF,F8,213F, 01F7,F8,213E, 01FD,F0,212F, 01F5,F0,212E, 81EC,ED,210E
$B2:B59A             dx 0009, 81EE,F8,212B, 81E6,F8,212A, 01F8,FB,2113, 01F8,F3,2103, 01FF,F8,213F, 01F7,F8,213E, 01FD,F0,212F, 01F5,F0,212E, 81EB,EE,210E
$B2:B5C9             dx 0009, 81EE,FA,212B, 81E6,FA,212A, 01F7,FA,2113, 01F7,F3,2103, 01FE,F8,213F, 01F6,F8,213E, 01FC,F0,212F, 01F4,F0,212E, 81EA,EF,210E
$B2:B5F8             dx 0009, 81EE,FB,212B, 81E6,FB,212A, 01F7,FB,2113, 01F6,F4,2103, 01FE,F8,213F, 01F5,F9,213E, 01FB,F1,212F, 01F3,F1,212E, 81EA,F0,210E
$B2:B627             dx 0009, 01FD,FB,6113, 01FD,F3,6103, 01F8,F8,613F, 0000,F8,613E, 01F9,F0,612F, 0001,F0,612E, 8006,00,6127, 81FE,00,6128, 8000,EB,610E
$B2:B656             dx 0009, 01FE,FB,6113, 01FE,F3,6103, 01F8,F8,613F, 0000,F8,613E, 01FA,F0,612F, 0002,F0,612E, 8007,00,6127, 81FF,00,6128, 8002,EC,610E
$B2:B685             dx 000A, 0000,00,614C, 0008,00,614B, 0010,00,614A, 01FF,FB,6113, 01FF,F3,6103, 01F9,F8,613F, 0001,F8,613E, 01FB,F0,612F, 0003,F0,612E, 8004,ED,610E
$B2:B6B9             dx 0009, 8002,F8,612B, 800A,F8,612A, 0000,FB,6113, 0000,F3,6103, 01F9,F8,613F, 0001,F8,613E, 01FB,F0,612F, 0003,F0,612E, 8005,EE,610E
$B2:B6E8             dx 0009, 8002,FA,612B, 800A,FA,612A, 0001,FA,6113, 0001,F3,6103, 01FA,F8,613F, 0002,F8,613E, 01FC,F0,612F, 0004,F0,612E, 8006,EF,610E
$B2:B717             dx 0009, 8002,FB,612B, 800A,FB,612A, 0001,FB,6113, 0002,F4,6103, 01FA,F8,613F, 0003,F9,613E, 01FD,F1,612F, 0005,F1,612E, 8006,F0,610E

; Ninja space pirates
$B2:B746             dx 000A, 81F4,00,2107, 01FD,08,211B, 01FD,00,210B, 01ED,16,2136, 8000,08,217E, 01F1,13,2130, 01F1,0B,2120, 01E6,16,2135, 000D,16,2144, 000C,0E,2143
$B2:B77A             dx 000C, 000B,10,218D, 000B,08,217D, 0008,09,216D, 0000,09,216C, 01F9,12,2131, 01F9,0A,2121, 01F7,18,2126, 01EF,18,2125, 01FA,06,2119, 01FA,FE,2109, 01FC,06,211A, 01FC,FE,210A
$B2:B7B8             dx 000C, 01FC,06,211A, 01FC,FE,210A, 01F9,05,2119, 01FD,18,2126, 01FE,14,2131, 01FE,0C,2121, 01F9,FD,2109, 01F5,18,2125, 0001,09,216F, 01F9,09,216E, 0005,11,2144, 0005,09,2143
$B2:B7F6             dx 000B, 01FA,14,2146, 01F2,14,2145, 0006,18,2146, 01FE,18,2145, 0003,13,2134, 0003,0B,2124, 01FE,07,211B, 01FF,FF,210B, 81F5,FD,2107, 01F9,0F,2134, 01F9,07,2124
$B2:B82F             dx 000A, 01FC,08,211B, 01FC,00,210A, 01F0,12,2130, 81FF,08,217E, 01EB,16,2136, 01E4,16,2135, 000D,16,2144, 000C,0E,2143, 01F0,0A,2120, 81F3,FF,2107
$B2:B863             dx 000C, 000A,0F,218D, 000A,07,217D, 01F5,18,2126, 01ED,18,2125, 0006,09,216D, 01FE,09,216C, 01F6,13,2131, 01F7,0B,2121, 01FB,06,211A, 01FB,FE,210A, 01F8,07,2119, 01F8,FF,2109
$B2:B8A1             dx 000C, 0007,12,2144, 0007,0A,2143, 0002,0A,216F, 01FA,0A,216E, 01FA,06,2119, 01FB,FE,2109, 01FD,18,2126, 01F5,18,2125, 01FE,15,2131, 01FE,0D,2121, 01FC,08,211A, 01FC,00,210A
$B2:B8DF             dx 000B, 01FA,14,2146, 01F2,14,2145, 81F6,FC,2107, 01F8,0E,2134, 01F8,06,2124, 0004,18,2146, 01FC,18,2145, 0001,13,2134, 0001,0B,2124, 01FC,07,211B, 01FD,FF,210B

; Walking / ninja space pirates
$B2:B918             dx 0009, 01FC,FC,6112, 01FC,F4,6102, 81EC,01,2127, 81F4,01,2128, 81F8,F0,212E, 81F1,EA,210E, 01F6,FE,214C, 01EE,FE,214B, 01E6,FE,214A
$B2:B947             dx 0009, 81EB,00,2127, 81F3,00,2128, 01FB,FB,2113, 01FA,F3,2103, 81F8,EF,212E, 81F1,EA,210E, 01F8,FD,214C, 01F0,FD,214B, 01E8,FD,214A
$B2:B976             dx 0008, 81E9,FE,2127, 81F1,FE,2128, 01FA,F8,2113, 01FA,F0,2103, 81F8,EE,212E, 81F1,E8,210E, 01F3,FC,214B, 01EB,FD,214A
$B2:B9A0             dx 0008, 81E8,00,2127, 81F0,00,2128, 01FA,FA,2113, 01FA,F2,2103, 81F8,EF,212E, 81F1,E9,210E, 01F5,FE,214B, 01ED,FF,214A

; Ninja space pirates
$B2:B9CA             dx 0007, 01F6,FC,214C, 01EE,FC,214B, 01E6,FC,214A, 01FB,FA,2112, 01FB,F2,2102, 81F8,EF,212E, 81F1,E9,210E
$B2:B9EF             dx 0007, 81F4,F2,2100, 01E2,F3,212A, 81EA,F3,212B, 81F8,EF,212E, 81F1,E9,210E, 01F2,FD,214B, 01EA,FD,214A
$B2:BA14             dx 0009, 01F1,FD,214B, 01E9,FD,214A, 01E0,E9,212A, 81E8,E9,212B, 01FB,F1,214F, 01F3,F1,214E, 81F8,EF,212E, 81F1,E9,210E, 01F6,FD,214C
$B2:BA43             dx 000A, 01F0,FD,214B, 01E8,FD,214A, 01FA,E4,214D, 01FA,DC,213D, 01FA,D4,212D, 01FB,E8,E113, 01FB,F0,E103, 81F8,F0,212E, 81F1,EA,210E, 01F6,FD,214C
$B2:BA77             dx 0014, 01F6,12,2134, 01F6,0A,2124, 01F7,15,2126, 01E2,F4,212A, 81EA,F4,212B, 01F7,FA,2112, 01F8,F2,2102, 0002,12,2134, 01FD,16,2125, 01FD,07,211A, 01FE,FF,210A, 0001,0A,2124, 81F6,F0,212E, 81F0,EA,210E, 01EF,16,2145, 81F3,FF,2107, 01F6,FE,214C, 01EE,FE,214B, 01E6,FE,214A, 0005,15,2126
$B2:BADD             dx 0013, 01F7,08,2124, 0007,16,2146, 01FF,05,211A, 01FF,FD,210A, 01E2,F3,212A, 81EA,F3,212B, 81F2,F1,2100, 81F6,EF,212E, 81EF,EA,210E, 01F8,16,2146, 01F0,15,2145, 01FF,15,2145, 0003,10,2134, 0002,08,2124, 81F4,FE,2107, 01F7,10,2134, 01F5,FD,214C, 01ED,FD,214B, 01E5,FD,214A
$B2:BB3E             dx 0014, 01F7,09,2124, 01F7,06,2119, 01F7,FF,2109, 01E0,F5,212A, 81E8,F5,212B, 81F1,F3,2100, 81F5,F0,212E, 81EE,EB,210E, 01F8,16,2146, 01F0,16,2145, 0006,16,2146, 01FE,16,2145, 0003,11,2134, 0003,09,2124, 01FF,07,211B, 01FF,FF,210B, 01F8,11,2134, 01F4,FE,214C, 01EC,FE,214B, 01E4,FE,214A

; Unused
$B2:BBA4             dx 000E, 81F4,FF,2128, 81EC,FF,2127, 0003,15,2126, 81FA,0B,2122, 01FB,FC,2113, 01FB,F4,2103, 81F2,EB,210E, 81F7,F2,212E, 01FB,15,2125, 81F7,FF,2107, 81F3,FF,2107, 81F4,0A,2122, 01FB,15,2126, 01F3,15,2125
$B2:BBEC             dx 0012, 81F3,EC,210E, 0008,FC,E14D, 0009,04,E13D, 0009,0C,E12D, 81FE,F2,2105, 81F9,F1,212E, 81EE,F3,212B, 81E6,F3,212A, 81F7,FF,2107, 0002,11,2144, 0002,09,2143, 01F7,09,E149, 01FF,09,E148, 81F4,FF,2107, 01F5,0B,E149, 01FD,0B,E148, 01FE,13,2144, 01FE,0B,2143
$B2:BC48             dx 0014, 01F8,F2,214F, 01F0,F1,214E, 01EC,EE,214D, 01EC,E6,213D, 01EC,DE,212D, 81F5,F1,212E, 81EE,EB,210E, 01EC,F0,213D, 01EC,F8,214D, 81EE,F1,2100, 81F7,FF,2107, 0004,11,2144, 0004,09,2143, 01F7,09,E149, 01FF,09,E148, 81F4,FF,2107, 01F5,0B,E149, 01FD,0B,E148, 01FE,13,2144, 01FE,0B,2143
$B2:BCAE             dx 000F, 01E8,F7,212A, 81F0,F7,212B, 81F7,F6,2100, 81FB,F2,212E, 81F4,EC,210E, 01FE,0B,2146, 01F6,0B,2145, 0001,00,2149, 01F9,FF,2148, 81F7,01,2122, 01EF,F9,214D, 01EE,F1,213D, 01ED,E9,212D, 0002,0D,2144, 0002,05,2143
$B2:BCFB             dx 000E, 01F0,05,E18D, 01F0,0D,E17D, 01F6,0B,2130, 01F6,03,2120, 01E9,F4,212A, 81F1,F4,212B, 81F8,F3,2100, 81FC,F0,212E, 81F5,EA,210E, 0001,FE,2149, 01F9,FE,2148, 01F1,F6,214D, 01F0,EE,213D, 01EF,E6,212D
$B2:BD43             dx 000E, 01F0,05,E18D, 01F0,0D,E17D, 01F5,0B,2130, 01F5,03,2120, 01E8,F3,212A, 81F0,F3,212B, 81F8,F2,2100, 81FC,F1,212E, 81F5,EB,210E, 0001,FF,2149, 01F9,FE,2148, 01F0,F7,214D, 01EF,EF,213D, 01EE,E7,212D

; Ninja space pirates
$B2:BD8B             dx 0009, 01F9,00,E14D, 01F9,08,E13D, 01F9,10,E12D, 01FA,FA,2113, 01FA,F2,2103, 81F8,EF,212E, 81F1,E9,210E, 01F5,FD,214B, 01ED,FE,214A

; Unused
$B2:BDBA             dx 0003, 01FC,04,214D, 01FC,FC,213D, 01FC,F4,212D

; Walking / ninja space pirates
$B2:BDCB             dx 0010, 81F9,FE,2107, 01E4,F3,212A, 81EC,F3,212B, 81F6,F1,2100, 81F2,EB,210E, 81F9,F1,212E, 01ED,F9,214D, 01EC,F1,213D, 01EB,E9,212D, 81F4,FE,2107, 01FC,10,2125, 81F3,05,2122, 0004,10,2126, 81FB,07,2122, 01FA,10,2126, 01F2,10,2125

; Unused
$B2:BE1D             dx 0011, 81F3,FB,2127, 81FB,FB,2128, 01FE,0D,2121, 01FE,15,2131, 01FD,18,2126, 01F5,18,2125, 01FC,08,211A, 01FC,00,210A, 0007,12,2144, 0007,0A,2143, 01FA,06,2119, 01FB,FE,2109, 01FA,0A,216E, 81FA,F0,2105, 81F1,E6,210E, 81F7,EF,212E, 0002,0A,216F
$B2:BE74             dx 0013, 01FE,FF,210A, 01E3,F0,212A, 81EB,F0,212B, 81F3,F1,2100, 0006,F5,E14D, 0007,FD,E13D, 0008,05,E12D, 81F3,E9,210E, 81F7,F1,212E, 01FD,07,211A, 01E3,FD,E16F, 01EB,FD,E16E, 01FB,FE,219F, 01F3,FE,219E, 0008,16,2126, 0000,17,2125, 81FE,0A,2122, 01DE,F4,E18D, 01DD,FC,E17D
$B2:BED5             dx 0016, 0009,F4,E14D, 000A,FC,E13D, 000A,04,E12D, 0006,F3,215F, 01FE,F4,215E, 01FF,00,610A, 81F3,EC,210E, 81F9,F2,212E, 01EF,10,618D, 01EF,08,617D, 01F4,08,616F, 01FC,09,616E, 0000,08,611A, 01F5,EA,214D, 01F4,E2,213D, 01F4,DA,212D, 01E5,FD,E16F, 01ED,FD,E16E, 01FB,FD,219F, 01F3,FD,219E, 01DE,F5,E18D, 01DE,FD,E17D

; Ninja space pirates
$B2:BF45             dx 000A, 81FC,00,6107, 01FB,08,611B, 01FB,00,610B, 000B,16,6136, 81F0,08,617E, 0007,13,6130, 0007,0B,6120, 0012,16,6135, 01EB,16,6144, 01EC,0E,6143
$B2:BF79             dx 000C, 01ED,10,618D, 01ED,08,617D, 01F0,09,616D, 01F8,09,616C, 01FF,12,6131, 01FF,0A,6121, 0001,18,6126, 0009,18,6125, 01FE,06,6119, 01FE,FE,6109, 01FC,06,611A, 01FC,FE,610A
$B2:BFB7             dx 000C, 01FC,06,611A, 01FC,FE,610A, 01FF,05,6119, 01FB,18,6126, 01FA,14,6131, 01FA,0C,6121, 01FF,FD,6109, 0003,18,6125, 01F7,09,616F, 01FF,09,616E, 01F3,11,6144, 01F3,09,6143
$B2:BFF5             dx 000B, 01FE,14,6146, 0006,14,6145, 01F2,18,6146, 01FA,18,6145, 01F5,13,6134, 01F5,0B,6124, 01FA,07,611B, 01F9,FF,610B, 81FB,FD,6107, 01FF,0F,6134, 01FF,07,6124
$B2:C02E             dx 000A, 01FC,08,611B, 01FC,00,610A, 0008,12,6130, 81F1,08,617E, 000D,16,6136, 0014,16,6135, 01EB,16,6144, 01EC,0E,6143, 0008,0A,6120, 81FD,FF,6107
$B2:C062             dx 000C, 01EE,0F,618D, 01EE,07,617D, 0003,18,6126, 000B,18,6125, 01F2,09,616D, 01FA,09,616C, 0002,13,6131, 0001,0B,6121, 01FD,06,611A, 01FD,FE,610A, 0000,07,6119, 0000,FF,6109
$B2:C0A0             dx 000C, 01F1,12,6144, 01F1,0A,6143, 01F6,0A,616F, 01FE,0A,616E, 01FE,06,6119, 01FD,FE,6109, 01FB,18,6126, 0003,18,6125, 01FA,15,6131, 01FA,0D,6121, 01FC,08,611A, 01FC,00,610A
$B2:C0DE             dx 000B, 01FE,14,6146, 0006,14,6145, 81FA,FC,6107, 0000,0E,6134, 0000,06,6124, 01F4,18,6146, 01FC,18,6145, 01F7,13,6134, 01F7,0B,6124, 01FC,07,611B, 01FB,FF,610B

; Walking / ninja space pirates
$B2:C117             dx 0009, 01FC,FC,2112, 01FC,F4,2102, 8004,01,6127, 81FC,01,6128, 81F8,F0,612E, 81FF,EA,610E, 0002,FE,614C, 000A,FE,614B, 0012,FE,614A
$B2:C146             dx 0009, 8005,00,6127, 81FD,00,6128, 01FD,FB,6113, 01FE,F3,6103, 81F8,EF,612E, 81FF,EA,610E, 0000,FD,614C, 0008,FD,614B, 0010,FD,614A
$B2:C175             dx 0008, 8007,FE,6127, 81FF,FE,6128, 01FE,F8,6113, 01FE,F0,6103, 81F8,EE,612E, 81FF,E8,610E, 0005,FC,614B, 000D,FD,614A
$B2:C19F             dx 0008, 8008,00,6127, 8000,00,6128, 01FE,FA,6113, 01FE,F2,6103, 81F8,EF,612E, 81FF,E9,610E, 0003,FE,614B, 000B,FF,614A

; Ninja space pirates
$B2:C1C9             dx 0007, 0002,FC,614C, 000A,FC,614B, 0012,FC,614A, 01FD,FA,6112, 01FD,F2,6102, 81F8,EF,612E, 81FF,E9,610E
$B2:C1EE             dx 0007, 81FC,F2,6100, 0016,F3,612A, 8006,F3,612B, 81F8,EF,612E, 81FF,E9,610E, 0006,FD,614B, 000E,FD,614A
$B2:C213             dx 0009, 0007,FD,614B, 000F,FD,614A, 0018,E9,612A, 8008,E9,612B, 01FD,F1,614F, 0005,F1,614E, 81F8,EF,612E, 81FF,E9,610E, 0002,FD,614C
$B2:C242             dx 000A, 0008,FD,614B, 0010,FD,614A, 01FE,E4,614D, 01FE,DC,613D, 01FE,D4,612D, 01FD,E8,A113, 01FD,F0,A103, 81F8,F0,612E, 81FF,EA,610E, 0002,FD,614C
$B2:C276             dx 0014, 0002,12,6134, 0002,0A,6124, 0001,15,6126, 0016,F4,612A, 8006,F4,612B, 0001,FA,6112, 0000,F2,6102, 01F6,12,6134, 01FB,16,6125, 01FB,07,611A, 01FA,FF,610A, 01F7,0A,6124, 81FA,F0,612E, 8000,EA,610E, 0009,16,6145, 81FD,FF,6107, 0002,FE,614C, 000A,FE,614B, 0012,FE,614A, 01F3,15,6126
$B2:C2DC             dx 0013, 0001,08,6124, 01F1,16,6146, 01F9,05,611A, 01F9,FD,610A, 0016,F3,612A, 8006,F3,612B, 81FE,F1,6100, 81FA,EF,612E, 8001,EA,610E, 0000,16,6146, 0008,15,6145, 01F9,15,6145, 01F5,10,6134, 01F6,08,6124, 81FC,FE,6107, 0001,10,6134, 0003,FD,614C, 000B,FD,614B, 0013,FD,614A
$B2:C33D             dx 0014, 0001,09,6124, 0001,06,6119, 0001,FF,6109, 0018,F5,612A, 8008,F5,612B, 81FF,F3,6100, 81FB,F0,612E, 8002,EB,610E, 0000,16,6146, 0008,16,6145, 01F2,16,6146, 01FA,16,6145, 01F5,11,6134, 01F5,09,6124, 01F9,07,611B, 01F9,FF,610B, 0000,11,6134, 0004,FE,614C, 000C,FE,614B, 0014,FE,614A

; Unused
$B2:C3A3             dx 000E, 81FC,FF,6128, 8004,FF,6127, 01F5,15,6126, 81F6,0B,6122, 01FD,FC,6113, 01FD,F4,6103, 81FE,EB,610E, 81F9,F2,612E, 01FD,15,6125, 81F9,FF,6107, 81FD,FF,6107, 81FC,0A,6122, 01FD,15,6126, 0005,15,6125
$B2:C3EB             dx 0012, 81FD,EC,610E, 01F0,FC,A14D, 01EF,04,A13D, 01EF,0C,A12D, 81F2,F2,6105, 81F7,F1,612E, 8002,F3,612B, 800A,F3,612A, 81F9,FF,6107, 01F6,11,6144, 01F6,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143
$B2:C447             dx 0014, 0000,F2,614F, 0008,F1,614E, 000C,EE,614D, 000C,E6,613D, 000C,DE,612D, 81FB,F1,612E, 8002,EB,610E, 000C,F0,613D, 000C,F8,614D, 8002,F1,6100, 81F9,FF,6107, 01F4,11,6144, 01F4,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143
$B2:C4AD             dx 000F, 0010,F7,612A, 8000,F7,612B, 81F9,F6,6100, 81F5,F2,612E, 81FC,EC,610E, 01FA,0B,6146, 0002,0B,6145, 01F7,00,6149, 01FF,FF,6148, 81F9,01,6122, 0009,F9,614D, 000A,F1,613D, 000B,E9,612D, 01F6,0D,6144, 01F6,05,6143
$B2:C4FA             dx 000E, 0008,05,A18D, 0008,0D,A17D, 0002,0B,6130, 0002,03,6120, 000F,F4,612A, 81FF,F4,612B, 81F8,F3,6100, 81F4,F0,612E, 81FB,EA,610E, 01F7,FE,6149, 01FF,FE,6148, 0007,F6,614D, 0008,EE,613D, 0009,E6,612D
$B2:C542             dx 000E, 0008,05,A18D, 0008,0D,A17D, 0003,0B,6130, 0003,03,6120, 0010,F3,612A, 8000,F3,612B, 81F8,F2,6100, 81F4,F1,612E, 81FB,EB,610E, 01F7,FF,6149, 01FF,FE,6148, 0008,F7,614D, 0009,EF,613D, 000A,E7,612D

; Ninja space pirates
$B2:C58A             dx 0009, 01FF,00,A14D, 01FF,08,A13D, 01FF,10,A12D, 01FE,FA,6113, 01FE,F2,6103, 81F8,EF,612E, 81FF,E9,610E, 0003,FD,614B, 000B,FE,614A

; Walking space pirates
$B2:C5B9             dx 0010, 81F7,FE,6107, 0014,F3,612A, 8004,F3,612B, 81FA,F1,6100, 81FE,EB,610E, 81F7,F1,612E, 000B,F9,614D, 000C,F1,613D, 000D,E9,612D, 81FC,FE,6107, 01FC,10,6125, 81FD,05,6122, 01F4,10,6126, 81F5,07,6122, 01FE,10,6126, 0006,10,6125

; Unused
$B2:C60B             dx 0011, 81FD,FB,6127, 81F5,FB,6128, 01FA,0D,6121, 01FA,15,6131, 01FB,18,6126, 0003,18,6125, 01FC,08,611A, 01FC,00,610A, 01F1,12,6144, 01F1,0A,6143, 01FE,06,6119, 01FD,FE,6109, 01FE,0A,616E, 81F6,F0,6105, 81FF,E6,610E, 81F9,EF,612E, 01F6,0A,616F
$B2:C662             dx 0013, 01FA,FF,610A, 0015,F0,612A, 8005,F0,612B, 81FD,F1,6100, 01F2,F5,A14D, 01F1,FD,A13D, 01F0,05,A12D, 81FD,E9,610E, 81F9,F1,612E, 01FB,07,611A, 0015,FD,A16F, 000D,FD,A16E, 01FD,FE,619F, 0005,FE,619E, 01F0,16,6126, 01F8,17,6125, 81F2,0A,6122, 001A,F4,A18D, 001B,FC,A17D
$B2:C6C3             dx 0016, 01EF,F4,A14D, 01EE,FC,A13D, 01EE,04,A12D, 01F2,F3,615F, 01FA,F4,615E, 01F9,00,210A, 81FD,EC,610E, 81F7,F2,612E, 0009,10,218D, 0009,08,217D, 0004,08,216F, 01FC,09,216E, 01F8,08,211A, 0003,EA,614D, 0004,E2,613D, 0004,DA,612D, 0013,FD,A16F, 000B,FD,A16E, 01FD,FD,619F, 0005,FD,619E, 001A,F5,A18D, 001A,FD,A17D

; Ninja space pirates
$B2:C733             dx 0004, 81FA,00,2182, 81EA,00,2180, 81FA,F0,2162, 81EA,F0,2160
$B2:C749             dx 0006, 01F5,10,21A5, 01FD,10,21A6, 81FD,00,2186, 81ED,00,2184, 81FD,F0,2166, 81ED,F0,2164
$B2:C769             dx 0005, 000C,FE,217C, 81FC,06,218A, 81EC,06,2188, 81FC,F6,216A, 81EC,F6,2168
$B2:C784             dx 0007, 0010,FA,E1A7, 81F0,F2,E1AA, 8000,F2,E1A8, 01F0,02,E1B4, 0008,02,E1B1, 0010,02,E1B0, 81F8,02,E1A2
$B2:C7A9             dx 0004, 81F6,F0,E182, 8006,F0,E180, 81F6,00,E162, 8006,00,E160
$B2:C7BF             dx 0006, 0004,E8,E1A5, 01FC,E8,E1A6, 81F4,F0,E186, 8004,F0,E184, 81F4,00,E166, 8004,00,E164
$B2:C7DF             dx 0005, 01EC,FA,E17C, 81F4,EA,E18A, 8004,EA,E188, 81F4,FA,E16A, 8004,FA,E168
$B2:C7FA             dx 0007, 01E9,FE,21A7, 8001,FE,21AA, 81F1,FE,21A8, 0009,F6,21B4, 01F1,F6,21B1, 01E9,F6,21B0, 81F9,EE,21A2

; Unused
$B2:C81F             dx 000D, 81F9,FC,2127, 8001,FC,2128, 01F1,F7,214D, 01F1,EF,213D, 01F1,E7,212D, 0006,FB,6112, 0006,F3,6102, 81FA,EB,210E, 0003,F9,6142, 01FB,F1,6141, 0003,F1,6140, 01FB,F9,6147, 81F1,F0,2100
$B2:C862             dx 000E, 01F0,F7,214D, 01F0,EF,213D, 01F0,E7,212D, 81FE,EB,610E, 81F1,F0,2100, 0003,F9,6142, 01FB,F1,6141, 0003,F1,6140, 01FB,F9,6147, 0008,FD,A14D, 0008,05,A13D, 0008,0D,A12D, 0006,FB,6112, 0006,F3,6102
$B2:C8AA             dx 0014, 0000,F2,614F, 0008,F1,614E, 000C,EE,614D, 000C,E6,613D, 000C,DE,612D, 81FB,F1,612E, 8002,EB,610E, 000C,F0,613D, 000C,F8,614D, 8002,F1,6100, 81F9,FF,6107, 01F4,11,6144, 01F4,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143

; Ninja space pirates
$B2:C910             dx 0004, 81F6,00,6182, 8006,00,6180, 81F6,F0,6162, 8006,F0,6160
$B2:C926             dx 0006, 0003,10,61A5, 01FB,10,61A6, 81F3,00,6186, 8003,00,6184, 81F3,F0,6166, 8003,F0,6164
$B2:C946             dx 0005, 01EC,FE,617C, 81F4,06,618A, 8004,06,6188, 81F4,F6,616A, 8004,F6,6168
$B2:C961             dx 0007, 01E8,FA,A1A7, 8000,F2,A1AA, 81F0,F2,A1A8, 0008,02,A1B4, 01F0,02,A1B1, 01E8,02,A1B0, 81F8,02,A1A2
$B2:C986             dx 0004, 81FA,F0,A182, 81EA,F0,A180, 81FA,00,A162, 81EA,00,A160
$B2:C99C             dx 0006, 01F4,E8,A1A5, 01FC,E8,A1A6, 81FC,F0,A186, 81EC,F0,A184, 81FC,00,A166, 81EC,00,A164
$B2:C9BC             dx 0005, 000C,FA,A17C, 81FC,EA,A18A, 81EC,EA,A188, 81FC,FA,A16A, 81EC,FA,A168
$B2:C9D7             dx 0007, 000F,FE,61A7, 81EF,FE,61AA, 81FF,FE,61A8, 01EF,F6,61B4, 0007,F6,61B1, 000F,F6,61B0, 81F7,EE,61A2

; Unused
$B2:C9FC             dx 0008, 01EF,FD,214D, 01EF,F5,213D, 01EF,ED,212D, 81F4,F3,2100, 81F8,F0,212E, 81F1,EA,210E, 01EF,E6,213D, 01EF,DE,212D
$B2:CA26             dx 0009, 01FC,F3,214F, 01F4,F4,214E, 01EF,F9,214D, 01EF,F1,213D, 01EF,E9,212D, 81F8,F0,212E, 81F1,EA,210E, 01EF,EA,213D, 01EF,E2,212D
$B2:CA55             dx 0008, 01EF,F3,214D, 01EF,EB,213D, 01EF,E3,212D, 01FB,F3,214F, 01F3,F3,214E, 81F8,F0,212E, 81F1,EA,210E, 01EF,E1,212D
$B2:CA7F             dx 000A, 01FB,F1,214F, 01F3,F0,214E, 01EF,ED,214D, 01EF,E5,213D, 01EF,DD,212D, 81F8,F0,212E, 81F1,EA,210E, 01EF,EF,213D, 01EF,F7,214D, 81F1,F0,2100
$B2:CAB3             dx 0009, 81F4,EB,E105, 01EF,EB,214D, 01EF,E3,213D, 01EF,DB,212D, 81F8,F0,212E, 81F1,EA,210E, 01EF,F1,213D, 01EF,F9,214D, 81F1,F2,2100
$B2:CAE2             dx 000A, 01F4,19,2146, 01F7,13,2119, 01F7,0B,2109, 81F9,FE,2107, 01EC,19,2145, 01F5,FE,2131, 01F5,F6,2121, 81F6,F5,E10C, 01F4,05,2146, 01EC,05,2145
$B2:CB16             dx 000C, 0000,FD,2149, 01F8,FF,2148, 01F4,14,2146, 01EC,14,2145, 0000,FB,2149, 01F8,F9,2148, 01F5,0D,211A, 01F5,05,210A, 01F5,02,2131, 01F5,FA,2121, 01F4,09,2146, 01EC,09,2145
$B2:CB54             dx 000C, 0000,F9,2149, 01F8,FB,2148, 01F4,10,2146, 01EC,10,2145, 0000,FB,2149, 01F8,F9,2148, 01F5,09,211A, 01F5,01,210A, 01F5,06,2131, 01F5,FE,2121, 01F4,0D,2146, 01EC,0D,2145
$B2:CB92             dx 000C, 01F3,03,2131, 01F3,FB,2121, 01F4,0A,2146, 01EC,0A,2145, 0000,FC,2149, 01F8,FA,2148, 0000,FE,2149, 01F8,00,2148, 01F4,12,2146, 01EC,12,2145, 01F5,0C,211A, 01F5,04,210A
$B2:CBD0             dx 000A, 01F5,00,2131, 01F5,F8,2121, 81F7,F6,E10C, 01F4,07,2146, 01EC,07,2145, 01F4,16,2146, 01F6,10,2119, 01F6,08,2109, 81F8,FD,2107, 01EC,16,2145

; Ninja space pirates
$B2:CC04             dx 0014, 0007,FE,615D, 0007,F6,615C, 0007,EE,615B, 01FF,14,615A, 01FF,FE,6157, 01FF,0C,6159, 01FF,06,6158, 01FF,F8,6156, 01FF,F0,6155, 01FF,E8,6154, 01F0,00,215D, 01F0,F8,215C, 01F0,F0,215B, 01F8,18,215A, 01F8,00,2157, 01F8,10,2159, 01F8,08,2158, 01F8,F8,2156, 01F8,F0,2155, 01F8,E8,2154

; Unused
$B2:CC6A             dx 000D, 81F9,FC,2127, 8001,FC,2128, 01F1,F7,214D, 01F1,EF,213D, 01F1,E7,212D, 0006,FB,6112, 0006,F3,6102, 81FA,EB,210E, 0003,F9,6142, 01FB,F1,6141, 0003,F1,6140, 01FB,F9,6147, 81F1,F0,2100
$B2:CCAD             dx 000E, 01F0,F7,214D, 01F0,EF,213D, 01F0,E7,212D, 81FE,EB,610E, 81F1,F0,2100, 0003,F9,6142, 01FB,F1,6141, 0003,F1,6140, 01FB,F9,6147, 0008,FD,A14D, 0008,05,A13D, 0008,0D,A12D, 0006,FB,6112, 0006,F3,6102
$B2:CCF5             dx 0014, 0000,F2,614F, 0008,F1,614E, 000C,EE,614D, 000C,E6,613D, 000C,DE,612D, 81FB,F1,612E, 8002,EB,610E, 000C,F0,613D, 000C,F8,614D, 8002,F1,6100, 81F9,FF,6107, 01F4,11,6144, 01F4,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143
$B2:CD5B             dx 0010, 0008,FC,614D, 0009,F4,613D, 000A,EC,612D, 000B,FD,614D, 000C,F5,613D, 000D,ED,612D, 81FD,F3,6100, 81F9,F0,612E, 8000,EA,610E, 01FA,0B,6144, 01FA,03,6143, 01FE,09,6146, 0006,09,6145, 01FB,FE,6149, 0003,FD,6148, 81FD,FF,6122
$B2:CDAD             dx 0008, 0009,FD,614D, 0009,F5,613D, 0009,ED,612D, 81FC,F3,6100, 81F8,F0,612E, 81FF,EA,610E, 0009,E6,613D, 0009,DE,612D
$B2:CDD7             dx 0009, 01FC,F3,614F, 0004,F4,614E, 0009,F9,614D, 0009,F1,613D, 0009,E9,612D, 81F8,F0,612E, 81FF,EA,610E, 0009,EA,613D, 0009,E2,612D
$B2:CE06             dx 0008, 0009,F3,614D, 0009,EB,613D, 0009,E3,612D, 01FD,F3,614F, 0005,F3,614E, 81F8,F0,612E, 81FF,EA,610E, 0009,E1,612D
$B2:CE30             dx 000A, 01FD,F1,614F, 0005,F0,614E, 0009,ED,614D, 0009,E5,613D, 0009,DD,612D, 81F8,F0,612E, 81FF,EA,610E, 0009,EF,613D, 0009,F7,614D, 81FF,F0,6100
$B2:CE64             dx 0009, 81FC,EB,A105, 0009,EB,614D, 0009,E3,613D, 0009,DB,612D, 81F8,F0,612E, 81FF,EA,610E, 0009,F1,613D, 0009,F9,614D, 81FF,F2,6100
$B2:CE93             dx 000A, 0004,19,6146, 0001,13,6119, 0001,0B,6109, 81F7,FE,6107, 000C,19,6145, 0003,FE,6131, 0003,F6,6121, 81FA,F5,A10C, 0004,05,6146, 000C,05,6145
$B2:CEC7             dx 000C, 01F8,FD,6149, 0000,FF,6148, 0004,14,6146, 000C,14,6145, 01F8,FB,6149, 0000,F9,6148, 0003,0D,611A, 0003,05,610A, 0003,02,6131, 0003,FA,6121, 0004,09,6146, 000C,09,6145
$B2:CF05             dx 000C, 01F8,F9,6149, 0000,FB,6148, 0004,10,6146, 000C,10,6145, 01F8,FB,6149, 0000,F9,6148, 0003,09,611A, 0003,01,610A, 0003,06,6131, 0003,FE,6121, 0004,0D,6146, 000C,0D,6145
$B2:CF43             dx 000C, 0005,03,6131, 0005,FB,6121, 0004,0A,6146, 000C,0A,6145, 01F8,FC,6149, 0000,FA,6148, 01F8,FE,6149, 0000,00,6148, 0004,12,6146, 000C,12,6145, 0003,0C,611A, 0003,04,610A
$B2:CF81             dx 000A, 0003,00,6131, 0003,F8,6121, 81F9,F6,A10C, 0004,07,6146, 000C,07,6145, 0004,16,6146, 0002,10,6119, 0002,08,6109, 81F8,FD,6107, 000C,16,6145
$B2:CFB5             dx 000D, 81F7,FC,6127, 81EF,FC,6128, 0007,F7,614D, 0007,EF,613D, 0007,E7,612D, 01F2,FB,2112, 01F2,F3,2102, 81F6,EB,610E, 01F5,F9,2142, 01FD,F1,2141, 01F5,F1,2140, 01FD,F9,2147, 81FF,F0,6100
$B2:CFF8             dx 000E, 0008,F7,614D, 0008,EF,613D, 0008,E7,612D, 81F2,EB,210E, 81FF,F0,6100, 01F5,F9,2142, 01FD,F1,2141, 01F5,F1,2140, 01FD,F9,2147, 01F0,FD,E14D, 01F0,05,E13D, 01F0,0D,E12D, 01F2,FB,2112, 01F2,F3,2102
$B2:D040             dx 0014, 01F8,F2,214F, 01F0,F1,214E, 01EC,EE,214D, 01EC,E6,213D, 01EC,DE,212D, 81F5,F1,212E, 81EE,EB,210E, 01EC,F0,213D, 01EC,F8,214D, 81EE,F1,2100, 81F7,FF,2107, 0004,11,2144, 0004,09,2143, 01F7,09,E149, 01FF,09,E148, 81F4,FF,2107, 01F5,0B,E149, 01FD,0B,E148, 01FE,13,2144, 01FE,0B,2143
$B2:D0A6             dx 0010, 01F0,FC,214D, 01EF,F4,213D, 01EE,EC,212D, 01ED,FD,214D, 01EC,F5,213D, 01EB,ED,212D, 81F3,F3,2100, 81F7,F0,212E, 81F0,EA,210E, 01FE,0B,2144, 01FE,03,2143, 01FA,09,2146, 01F2,09,2145, 01FD,FE,2149, 01F5,FD,2148, 81F3,FF,2122
$B2:D0F8             dx 000A, 01F5,13,2130, 01F4,0B,2120, 01F2,18,2136, 01EB,18,2135, 81F5,00,2107, 0006,18,2144, 0006,10,2143, 81FE,0B,2122, 01FD,08,211B, 01FD,00,210B
$B2:D12C             dx 000B, 01F9,12,2131, 01F9,0A,2121, 01F7,18,2126, 01EF,18,2125, 01FA,06,2119, 01FA,FE,2109, 0005,17,2144, 0005,0F,2143, 81FA,08,2122, 01FB,06,211A, 01FB,FE,210A
$B2:D165             dx 000C, 01FD,18,2126, 01F5,18,2125, 01FE,14,2131, 01FE,0C,2121, 01FC,06,211A, 01FC,FE,210A, 0004,18,2144, 0004,10,2143, 01FD,10,211B, 01FD,08,210B, 01FB,04,2119, 01FB,FC,2109
$B2:D1A3             dx 000B, 01FA,16,2126, 01F2,16,2125, 0004,18,2146, 01FC,18,2145, 0001,13,2134, 0001,0B,2124, 01FC,07,211B, 01FD,FF,210B, 81F4,00,2107, 01F8,12,2134, 01F8,0A,2124
$B2:D1DC             dx 000A, 01FA,00,210A, 01F2,18,2136, 01EB,18,2135, 0006,18,2144, 0006,10,2143, 81FB,0A,2122, 01F9,08,211B, 01F4,13,2130, 01F3,0B,2120, 81F4,00,2107
$B2:D210             dx 000B, 01F7,13,2131, 01F7,0B,2121, 0005,17,2144, 0005,0F,2143, 81FA,08,2122, 01FB,06,211A, 01FB,FE,210A, 01F6,18,2126, 01EE,18,2125, 01F8,07,2119, 01F8,FF,2109
$B2:D249             dx 000C, 01FB,06,2119, 01FB,FE,2109, 0002,19,2144, 0002,11,2143, 01FC,11,211B, 01FC,09,210B, 01FD,18,2126, 01F5,18,2125, 01FE,15,2131, 01FE,0D,2121, 01FC,08,211A, 01FC,00,210A
$B2:D287             dx 000B, 01FA,16,2126, 01F2,16,2125, 81F6,00,2107, 01F8,12,2134, 01F8,0A,2124, 0004,18,2146, 01FC,18,2145, 0001,13,2134, 0001,0B,2124, 01FC,07,211B, 01FD,FF,210B

; Ninja space pirates
$B2:D2C0             dx 000A, 01F8,11,2134, 01FC,FE,2109, 01FC,06,2119, 0003,15,2126, 01FC,15,2125, 81F5,FF,2107, 81FB,0A,2122, 01FA,15,2126, 01F2,15,2125, 01F8,09,2124

; Unused
$B2:D2F4             dx 000A, 81F7,FF,2107, 0004,11,2144, 0004,09,2143, 01F7,09,E149, 01FF,09,E148, 81F4,FF,2107, 01F5,0B,E149, 01FD,0B,E148, 01FE,13,2144, 01FE,0B,2143
$B2:D328             dx 0003, 0004,FC,214C, 01FC,FC,214B, 01F4,FC,214A
$B2:D339             dx 0002, 81FC,F8,2128, 81F4,F8,2127
$B2:D345             dx 0003, 01FC,F4,E14D, 01FC,FC,E13D, 01FC,04,E12D
$B2:D356             dx 0002, 81F4,F8,E12B, 81FC,F8,E12A
$B2:D362             dx 0003, 01F4,FC,E14C, 01FC,FC,E14B, 0004,FC,E14A
$B2:D373             dx 0002, 81F4,F8,E128, 81FC,F8,E127
$B2:D37F             dx 0003, 01FC,04,214D, 01FC,FC,213D, 01FC,F4,212D
$B2:D390             dx 0002, 81FC,F8,212B, 81F4,F8,212A

; Ninja space pirates
$B2:D39C             dx 000A, 01FC,08,2119, 01FC,00,2109, 81F4,01,2107, 01F6,09,2124, 01F7,11,2134, 0002,15,2126, 01FC,15,2125, 81FA,0B,2122, 01F9,15,2126, 01F2,15,2125
$B2:D3D0             dx 0005, 81EA,00,2127, 81F2,00,2128, 01FB,FB,2113, 01FB,F3,2103, 81F8,F0,212E
$B2:D3EB             dx 0005, 8006,00,6127, 81FE,00,6128, 01FD,FB,6113, 01FD,F3,6103, 81F8,F0,612E

; Unused
$B2:D406             dx 000A, 0003,13,6130, 0004,0B,6120, 0006,18,6136, 000D,18,6135, 81FB,00,6107, 01F2,18,6144, 01F2,10,6143, 81F2,0B,6122, 01FB,08,611B, 01FB,00,610B
$B2:D43A             dx 000B, 01FF,12,6131, 01FF,0A,6121, 0001,18,6126, 0009,18,6125, 01FE,06,6119, 01FE,FE,6109, 01F3,17,6144, 01F3,0F,6143, 81F6,08,6122, 01FD,06,611A, 01FD,FE,610A
$B2:D473             dx 000C, 01FB,18,6126, 0003,18,6125, 01FA,14,6131, 01FA,0C,6121, 01FC,06,611A, 01FC,FE,610A, 01F4,18,6144, 01F4,10,6143, 01FB,10,611B, 01FB,08,610B, 01FD,04,6119, 01FD,FC,6109
$B2:D4B1             dx 000B, 01FE,16,6126, 0006,16,6125, 01F4,18,6146, 01FC,18,6145, 01F7,13,6134, 01F7,0B,6124, 01FC,07,611B, 01FB,FF,610B, 81FC,00,6107, 0000,12,6134, 0000,0A,6124
$B2:D4EA             dx 000A, 01FE,00,610A, 0006,18,6136, 000D,18,6135, 01F2,18,6144, 01F2,10,6143, 81F5,0A,6122, 01FF,08,611B, 0004,13,6130, 0005,0B,6120, 81FC,00,6107
$B2:D51E             dx 000B, 0001,13,6131, 0001,0B,6121, 01F3,17,6144, 01F3,0F,6143, 81F6,08,6122, 01FD,06,611A, 01FD,FE,610A, 0002,18,6126, 000A,18,6125, 0000,07,6119, 0000,FF,6109
$B2:D557             dx 000C, 01FD,06,6119, 01FD,FE,6109, 01F6,19,6144, 01F6,11,6143, 01FC,11,611B, 01FC,09,610B, 01FB,18,6126, 0003,18,6125, 01FA,15,6131, 01FA,0D,6121, 01FC,08,611A, 01FC,00,610A
$B2:D595             dx 000B, 01FE,16,6126, 0006,16,6125, 81FA,00,6107, 0000,12,6134, 0000,0A,6124, 01F4,18,6146, 01FC,18,6145, 01F7,13,6134, 01F7,0B,6124, 01FC,07,611B, 01FB,FF,610B

; Ninja space pirates
$B2:D5CE             dx 000A, 0000,11,6134, 01FC,FE,6109, 01FC,06,6119, 01F5,15,6126, 01FC,15,6125, 81FB,FF,6107, 81F5,0A,6122, 01FE,15,6126, 0006,15,6125, 0000,09,6124

; Unused
$B2:D602             dx 000A, 81F9,FF,6107, 01F4,11,6144, 01F4,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143
$B2:D636             dx 0003, 01F4,FC,614C, 01FC,FC,614B, 0004,FC,614A
$B2:D647             dx 0002, 81F4,F8,6128, 81FC,F8,6127
$B2:D653             dx 0003, 01FC,F4,A14D, 01FC,FC,A13D, 01FC,04,A12D
$B2:D664             dx 0002, 81FC,F8,A12B, 81F4,F8,A12A
$B2:D670             dx 0003, 0004,FC,A14C, 01FC,FC,A14B, 01F4,FC,A14A
$B2:D681             dx 0002, 81FC,F8,A128, 81F4,F8,A127
$B2:D68D             dx 0003, 01FC,04,614D, 01FC,FC,613D, 01FC,F4,612D
$B2:D69E             dx 0002, 81F4,F8,612B, 81FC,F8,612A

; Ninja space pirates
$B2:D6AA             dx 000A, 01FC,08,6119, 01FC,00,6109, 81FC,01,6107, 0002,09,6124, 0001,11,6134, 01F6,15,6126, 01FC,15,6125, 81F6,0B,6122, 01FF,15,6126, 0006,15,6125
$B2:D6DE             dx 0004, 0000,00,6151, 01F8,00,2151, 0000,F8,6150, 01F8,F8,2150
$B2:D6F4             dx 0004, 0000,00,6153, 0000,F8,6152, 01F8,00,2153, 01F8,F8,2152
$B2:D70A             dx 0009, 01FB,FB,2113, 01FB,F3,2103, 0000,F8,213F, 01F8,F8,213E, 01FF,F0,212F, 01F7,F0,212E, 81EA,00,2127, 81F2,00,2128, 81F0,EB,210E

; Unused
$B2:D739             dx 0009, 01FA,FB,2113, 01FA,F3,2103, 0000,F8,213F, 01F8,F8,213E, 01FE,F0,212F, 01F6,F0,212E, 81E9,00,2127, 81F1,00,2128, 81EE,EC,210E
$B2:D768             dx 000A, 01F8,00,214C, 01F0,00,214B, 01E8,00,214A, 01F9,FB,2113, 01F9,F3,2103, 01FF,F8,213F, 01F7,F8,213E, 01FD,F0,212F, 01F5,F0,212E, 81EC,ED,210E
$B2:D79C             dx 0009, 81EE,F8,212B, 81E6,F8,212A, 01F8,FB,2113, 01F8,F3,2103, 01FF,F8,213F, 01F7,F8,213E, 01FD,F0,212F, 01F5,F0,212E, 81EB,EE,210E
$B2:D7CB             dx 0009, 81EE,FA,212B, 81E6,FA,212A, 01F7,FA,2113, 01F7,F3,2103, 01FE,F8,213F, 01F6,F8,213E, 01FC,F0,212F, 01F4,F0,212E, 81EA,EF,210E
$B2:D7FA             dx 0009, 81EE,FB,212B, 81E6,FB,212A, 01F7,FB,2113, 01F6,F4,2103, 01FE,F8,213F, 01F5,F9,213E, 01FB,F1,212F, 01F3,F1,212E, 81EA,F0,210E

; Ninja space pirates
$B2:D829             dx 0009, 01FD,FB,6113, 01FD,F3,6103, 01F8,F8,613F, 0000,F8,613E, 01F9,F0,612F, 0001,F0,612E, 8006,00,6127, 81FE,00,6128, 8000,EB,610E

; Unused
$B2:D858             dx 0009, 01FE,FB,6113, 01FE,F3,6103, 01F8,F8,613F, 0000,F8,613E, 01FA,F0,612F, 0002,F0,612E, 8007,00,6127, 81FF,00,6128, 8002,EC,610E
$B2:D887             dx 000A, 0000,00,614C, 0008,00,614B, 0010,00,614A, 01FF,FB,6113, 01FF,F3,6103, 01F9,F8,613F, 0001,F8,613E, 01FB,F0,612F, 0003,F0,612E, 8004,ED,610E
$B2:D8BB             dx 0009, 8002,F8,612B, 800A,F8,612A, 0000,FB,6113, 0000,F3,6103, 01F9,F8,613F, 0001,F8,613E, 01FB,F0,612F, 0003,F0,612E, 8005,EE,610E
$B2:D8EA             dx 0009, 8002,FA,612B, 800A,FA,612A, 0001,FA,6113, 0001,F3,6103, 01FA,F8,613F, 0002,F8,613E, 01FC,F0,612F, 0004,F0,612E, 8006,EF,610E
$B2:D919             dx 0009, 8002,FB,612B, 800A,FB,612A, 0001,FB,6113, 0002,F4,6103, 01FA,F8,613F, 0003,F9,613E, 01FD,F1,612F, 0005,F1,612E, 8006,F0,610E
$B2:D948             dx 000A, 81F4,00,2107, 01FD,08,211B, 01FD,00,210B, 01ED,16,2136, 8000,08,217E, 01F1,13,2130, 01F1,0B,2120, 01E6,16,2135, 000D,16,2144, 000C,0E,2143
$B2:D97C             dx 000C, 000B,10,218D, 000B,08,217D, 0008,09,216D, 0000,09,216C, 01F9,12,2131, 01F9,0A,2121, 01F7,18,2126, 01EF,18,2125, 01FA,06,2119, 01FA,FE,2109, 01FC,06,211A, 01FC,FE,210A
$B2:D9BA             dx 000C, 01FC,06,211A, 01FC,FE,210A, 01F9,05,2119, 01FD,18,2126, 01FE,14,2131, 01FE,0C,2121, 01F9,FD,2109, 01F5,18,2125, 0001,09,216F, 01F9,09,216E, 0005,11,2144, 0005,09,2143
$B2:D9F8             dx 000B, 01FA,14,2146, 01F2,14,2145, 0006,18,2146, 01FE,18,2145, 0003,13,2134, 0003,0B,2124, 01FE,07,211B, 01FF,FF,210B, 81F5,FD,2107, 01F9,0F,2134, 01F9,07,2124
$B2:DA31             dx 000A, 01FC,08,211B, 01FC,00,210A, 01F0,12,2130, 81FF,08,217E, 01EB,16,2136, 01E4,16,2135, 000D,16,2144, 000C,0E,2143, 01F0,0A,2120, 81F3,FF,2107
$B2:DA65             dx 000C, 000A,0F,218D, 000A,07,217D, 01F5,18,2126, 01ED,18,2125, 0006,09,216D, 01FE,09,216C, 01F6,13,2131, 01F7,0B,2121, 01FB,06,211A, 01FB,FE,210A, 01F8,07,2119, 01F8,FF,2109
$B2:DAA3             dx 000C, 0007,12,2144, 0007,0A,2143, 0002,0A,216F, 01FA,0A,216E, 01FA,06,2119, 01FB,FE,2109, 01FD,18,2126, 01F5,18,2125, 01FE,15,2131, 01FE,0D,2121, 01FC,08,211A, 01FC,00,210A
$B2:DAE1             dx 000B, 01FA,14,2146, 01F2,14,2145, 81F6,FC,2107, 01F8,0E,2134, 01F8,06,2124, 0004,18,2146, 01FC,18,2145, 0001,13,2134, 0001,0B,2124, 01FC,07,211B, 01FD,FF,210B

; Ninja space pirates
$B2:DB1A             dx 0009, 01FC,FC,6112, 01FC,F4,6102, 81EC,01,2127, 81F4,01,2128, 81F8,F0,212E, 81F1,EA,210E, 01F6,FE,214C, 01EE,FE,214B, 01E6,FE,214A

; Unused
$B2:DB49             dx 0009, 81EB,00,2127, 81F3,00,2128, 01FB,FB,2113, 01FA,F3,2103, 81F8,EF,212E, 81F1,EA,210E, 01F8,FD,214C, 01F0,FD,214B, 01E8,FD,214A
$B2:DB78             dx 0008, 81E9,FE,2127, 81F1,FE,2128, 01FA,F8,2113, 01FA,F0,2103, 81F8,EE,212E, 81F1,E8,210E, 01F3,FC,214B, 01EB,FD,214A
$B2:DBA2             dx 0008, 81E8,00,2127, 81F0,00,2128, 01FA,FA,2113, 01FA,F2,2103, 81F8,EF,212E, 81F1,E9,210E, 01F5,FE,214B, 01ED,FF,214A
$B2:DBCC             dx 0007, 01F6,FC,214C, 01EE,FC,214B, 01E6,FC,214A, 01FB,FA,2112, 01FB,F2,2102, 81F8,EF,212E, 81F1,E9,210E
$B2:DBF1             dx 0007, 81F4,F2,2100, 01E2,F3,212A, 81EA,F3,212B, 81F8,EF,212E, 81F1,E9,210E, 01F2,FD,214B, 01EA,FD,214A
$B2:DC16             dx 0009, 01F1,FD,214B, 01E9,FD,214A, 01E0,E9,212A, 81E8,E9,212B, 01FB,F1,214F, 01F3,F1,214E, 81F8,EF,212E, 81F1,E9,210E, 01F6,FD,214C
$B2:DC45             dx 000A, 01F0,FD,214B, 01E8,FD,214A, 01FA,E4,214D, 01FA,DC,213D, 01FA,D4,212D, 01FB,E8,E113, 01FB,F0,E103, 81F8,F0,212E, 81F1,EA,210E, 01F6,FD,214C
$B2:DC79             dx 0014, 01F6,12,2134, 01F6,0A,2124, 01F7,15,2126, 01E2,F4,212A, 81EA,F4,212B, 01F7,FA,2112, 01F8,F2,2102, 0002,12,2134, 01FD,16,2125, 01FD,07,211A, 01FE,FF,210A, 0001,0A,2124, 81F6,F0,212E, 81F0,EA,210E, 01EF,16,2145, 81F3,FF,2107, 01F6,FE,214C, 01EE,FE,214B, 01E6,FE,214A, 0005,15,2126
$B2:DCDF             dx 0013, 01F7,08,2124, 0007,16,2146, 01FF,05,211A, 01FF,FD,210A, 01E2,F3,212A, 81EA,F3,212B, 81F2,F1,2100, 81F6,EF,212E, 81EF,EA,210E, 01F8,16,2146, 01F0,15,2145, 01FF,15,2145, 0003,10,2134, 0002,08,2124, 81F4,FE,2107, 01F7,10,2134, 01F5,FD,214C, 01ED,FD,214B, 01E5,FD,214A
$B2:DD40             dx 0014, 01F7,09,2124, 01F7,06,2119, 01F7,FF,2109, 01E0,F5,212A, 81E8,F5,212B, 81F1,F3,2100, 81F5,F0,212E, 81EE,EB,210E, 01F8,16,2146, 01F0,16,2145, 0006,16,2146, 01FE,16,2145, 0003,11,2134, 0003,09,2124, 01FF,07,211B, 01FF,FF,210B, 01F8,11,2134, 01F4,FE,214C, 01EC,FE,214B, 01E4,FE,214A
$B2:DDA6             dx 000E, 81F4,FF,2128, 81EC,FF,2127, 0003,15,2126, 81FA,0B,2122, 01FB,FC,2113, 01FB,F4,2103, 81F2,EB,210E, 81F7,F2,212E, 01FB,15,2125, 81F7,FF,2107, 81F3,FF,2107, 81F4,0A,2122, 01FB,15,2126, 01F3,15,2125

; Ninja space pirates
$B2:DDEE             dx 0012, 81F3,EC,210E, 0008,FC,E14D, 0009,04,E13D, 0009,0C,E12D, 81FE,F2,2105, 81F9,F1,212E, 81EE,F3,212B, 81E6,F3,212A, 81F7,FF,2107, 0002,11,2144, 0002,09,2143, 01F7,09,E149, 01FF,09,E148, 81F4,FF,2107, 01F5,0B,E149, 01FD,0B,E148, 01FE,13,2144, 01FE,0B,2143
$B2:DE4A             dx 0016, 01FE,15,2134, 01FD,0D,2124, 01FA,FB,214C, 01F2,FB,214B, 01EA,FB,214A, 01FC,F9,2113, 01FC,F1,2103, 0000,18,2126, 01F8,18,2125, 01FB,08,211A, 01FC,00,210A, 81F3,E6,210E, 81F9,EF,212E, 01FA,FD,2149, 01F2,FD,2148, 01F4,0D,2146, 01EC,0D,2145, 01F3,09,2134, 01F3,01,2124, 0004,F9,E14D, 0005,01,E13D, 0006,09,E12D

; Unused
$B2:DEBA             dx 0014, 01F8,F2,214F, 01F0,F1,214E, 01EC,EE,214D, 01EC,E6,213D, 01EC,DE,212D, 81F5,F1,212E, 81EE,EB,210E, 01EC,F0,213D, 01EC,F8,214D, 81EE,F1,2100, 81F7,FF,2107, 0004,11,2144, 0004,09,2143, 01F7,09,E149, 01FF,09,E148, 81F4,FF,2107, 01F5,0B,E149, 01FD,0B,E148, 01FE,13,2144, 01FE,0B,2143
$B2:DF20             dx 000F, 01E8,F7,212A, 81F0,F7,212B, 81F7,F6,2100, 81FB,F2,212E, 81F4,EC,210E, 01FE,0B,2146, 01F6,0B,2145, 0001,00,2149, 01F9,FF,2148, 81F7,01,2122, 01EF,F9,214D, 01EE,F1,213D, 01ED,E9,212D, 0002,0D,2144, 0002,05,2143
$B2:DF6D             dx 000E, 01F0,05,E18D, 01F0,0D,E17D, 01F6,0B,2130, 01F6,03,2120, 01E9,F4,212A, 81F1,F4,212B, 81F8,F3,2100, 81FC,F0,212E, 81F5,EA,210E, 0001,FE,2149, 01F9,FE,2148, 01F1,F6,214D, 01F0,EE,213D, 01EF,E6,212D
$B2:DFB5             dx 000E, 01F0,05,E18D, 01F0,0D,E17D, 01F5,0B,2130, 01F5,03,2120, 01E8,F3,212A, 81F0,F3,212B, 81F8,F2,2100, 81FC,F1,212E, 81F5,EB,210E, 0001,FF,2149, 01F9,FE,2148, 01F0,F7,214D, 01EF,EF,213D, 01EE,E7,212D
$B2:DFFD             dx 0009, 01F9,00,E14D, 01F9,08,E13D, 01F9,10,E12D, 01FA,FA,2113, 01FA,F2,2103, 81F8,EF,212E, 81F1,E9,210E, 01F5,FD,214B, 01ED,FE,214A
$B2:E02C             dx 0003, 01FC,04,214D, 01FC,FC,213D, 01FC,F4,212D
$B2:E03D             dx 0010, 81F9,FE,2107, 01E4,F3,212A, 81EC,F3,212B, 81F6,F1,2100, 81F2,EB,210E, 81F9,F1,212E, 01ED,F9,214D, 01EC,F1,213D, 01EB,E9,212D, 81F4,FE,2107, 01FC,10,2125, 81F3,05,2122, 0004,10,2126, 81FB,07,2122, 01FA,10,2126, 01F2,10,2125

; Ninja space pirates
$B2:E08F             dx 0011, 81F3,FB,2127, 81FB,FB,2128, 01FE,0D,2121, 01FE,15,2131, 01FD,18,2126, 01F5,18,2125, 01FC,08,211A, 01FC,00,210A, 0007,12,2144, 0007,0A,2143, 01FA,06,2119, 01FB,FE,2109, 01FA,0A,216E, 81FA,F0,2105, 81F1,E6,210E, 81F7,EF,212E, 0002,0A,216F
$B2:E0E6             dx 0013, 01FE,FF,210A, 01E8,EE,212A, 81EE,ED,212B, 81F6,EF,2100, 000A,F5,E14D, 000B,FD,E13D, 000C,05,E12D, 81F7,E9,210E, 81FB,F1,212E, 01FD,07,211A, 01E3,FD,E16F, 01EB,FE,E16E, 01FB,FE,219F, 01F3,FD,219E, 0008,16,2126, 0000,17,2125, 81FE,0A,2122, 01DE,F4,E18D, 01DD,FC,E17D
$B2:E147             dx 0013, 01DE,0A,219D, 81E2,01,21AC, 81EF,FB,21AE, 0009,F4,E14D, 000A,FC,E13D, 000A,04,E12D, 0006,F3,215F, 01FE,F4,215E, 01FF,00,610A, 81F3,EC,210E, 81F9,F2,212E, 01EF,10,618D, 01EF,08,617D, 01F4,08,616F, 01FC,09,616E, 0000,08,611A, 01F5,EA,214D, 01F4,E2,213D, 01F4,DA,212D

; Unused
$B2:E1A8             dx 000A, 81FC,00,6107, 01FB,08,611B, 01FB,00,610B, 000B,16,6136, 81F0,08,617E, 0007,13,6130, 0007,0B,6120, 0012,16,6135, 01EB,16,6144, 01EC,0E,6143
$B2:E1DC             dx 000C, 01ED,10,618D, 01ED,08,617D, 01F0,09,616D, 01F8,09,616C, 01FF,12,6131, 01FF,0A,6121, 0001,18,6126, 0009,18,6125, 01FE,06,6119, 01FE,FE,6109, 01FC,06,611A, 01FC,FE,610A
$B2:E21A             dx 000C, 01FC,06,611A, 01FC,FE,610A, 01FF,05,6119, 01FB,18,6126, 01FA,14,6131, 01FA,0C,6121, 01FF,FD,6109, 0003,18,6125, 01F7,09,616F, 01FF,09,616E, 01F3,11,6144, 01F3,09,6143
$B2:E258             dx 000B, 01FE,14,6146, 0006,14,6145, 01F2,18,6146, 01FA,18,6145, 01F5,13,6134, 01F5,0B,6124, 01FA,07,611B, 01F9,FF,610B, 81FB,FD,6107, 01FF,0F,6134, 01FF,07,6124
$B2:E291             dx 000A, 01FC,08,611B, 01FC,00,610A, 0008,12,6130, 81F1,08,617E, 000D,16,6136, 0014,16,6135, 01EB,16,6144, 01EC,0E,6143, 0008,0A,6120, 81FD,FF,6107
$B2:E2C5             dx 000C, 01EE,0F,618D, 01EE,07,617D, 0003,18,6126, 000B,18,6125, 01F2,09,616D, 01FA,09,616C, 0002,13,6131, 0001,0B,6121, 01FD,06,611A, 01FD,FE,610A, 0000,07,6119, 0000,FF,6109
$B2:E303             dx 000C, 01F1,12,6144, 01F1,0A,6143, 01F6,0A,616F, 01FE,0A,616E, 01FE,06,6119, 01FD,FE,6109, 01FB,18,6126, 0003,18,6125, 01FA,15,6131, 01FA,0D,6121, 01FC,08,611A, 01FC,00,610A
$B2:E341             dx 000B, 01FE,14,6146, 0006,14,6145, 81FA,FC,6107, 0000,0E,6134, 0000,06,6124, 01F4,18,6146, 01FC,18,6145, 01F7,13,6134, 01F7,0B,6124, 01FC,07,611B, 01FB,FF,610B

; Ninja space pirates
$B2:E37A             dx 0009, 01FC,FC,2112, 01FC,F4,2102, 8004,01,6127, 81FC,01,6128, 81F8,F0,612E, 81FF,EA,610E, 0002,FE,614C, 000A,FE,614B, 0012,FE,614A

; Unused
$B2:E3A9             dx 0009, 8005,00,6127, 81FD,00,6128, 01FD,FB,6113, 01FE,F3,6103, 81F8,EF,612E, 81FF,EA,610E, 0000,FD,614C, 0008,FD,614B, 0010,FD,614A
$B2:E3D8             dx 0008, 8007,FE,6127, 81FF,FE,6128, 01FE,F8,6113, 01FE,F0,6103, 81F8,EE,612E, 81FF,E8,610E, 0005,FC,614B, 000D,FD,614A
$B2:E402             dx 0008, 8008,00,6127, 8000,00,6128, 01FE,FA,6113, 01FE,F2,6103, 81F8,EF,612E, 81FF,E9,610E, 0003,FE,614B, 000B,FF,614A
$B2:E42C             dx 0007, 0002,FC,614C, 000A,FC,614B, 0012,FC,614A, 01FD,FA,6112, 01FD,F2,6102, 81F8,EF,612E, 81FF,E9,610E
$B2:E451             dx 0007, 81FC,F2,6100, 0016,F3,612A, 8006,F3,612B, 81F8,EF,612E, 81FF,E9,610E, 0006,FD,614B, 000E,FD,614A
$B2:E476             dx 0009, 0007,FD,614B, 000F,FD,614A, 0018,E9,612A, 8008,E9,612B, 01FD,F1,614F, 0005,F1,614E, 81F8,EF,612E, 81FF,E9,610E, 0002,FD,614C
$B2:E4A5             dx 000A, 0008,FD,614B, 0010,FD,614A, 01FE,E4,614D, 01FE,DC,613D, 01FE,D4,612D, 01FD,E8,A113, 01FD,F0,A103, 81F8,F0,612E, 81FF,EA,610E, 0002,FD,614C
$B2:E4D9             dx 0014, 0002,12,6134, 0002,0A,6124, 0001,15,6126, 0016,F4,612A, 8006,F4,612B, 0001,FA,6112, 0000,F2,6102, 01F6,12,6134, 01FB,16,6125, 01FB,07,611A, 01FA,FF,610A, 01F7,0A,6124, 81FA,F0,612E, 8000,EA,610E, 0009,16,6145, 81FD,FF,6107, 0002,FE,614C, 000A,FE,614B, 0012,FE,614A, 01F3,15,6126
$B2:E53F             dx 0013, 0001,08,6124, 01F1,16,6146, 01F9,05,611A, 01F9,FD,610A, 0016,F3,612A, 8006,F3,612B, 81FE,F1,6100, 81FA,EF,612E, 8001,EA,610E, 0000,16,6146, 0008,15,6145, 01F9,15,6145, 01F5,10,6134, 01F6,08,6124, 81FC,FE,6107, 0001,10,6134, 0003,FD,614C, 000B,FD,614B, 0013,FD,614A
$B2:E5A0             dx 0014, 0001,09,6124, 0001,06,6119, 0001,FF,6109, 0018,F5,612A, 8008,F5,612B, 81FF,F3,6100, 81FB,F0,612E, 8002,EB,610E, 0000,16,6146, 0008,16,6145, 01F2,16,6146, 01FA,16,6145, 01F5,11,6134, 01F5,09,6124, 01F9,07,611B, 01F9,FF,610B, 0000,11,6134, 0004,FE,614C, 000C,FE,614B, 0014,FE,614A
$B2:E606             dx 000E, 81FC,FF,6128, 8004,FF,6127, 01F5,15,6126, 81F6,0B,6122, 01FD,FC,6113, 01FD,F4,6103, 81FE,EB,610E, 81F9,F2,612E, 01FD,15,6125, 81F9,FF,6107, 81FD,FF,6107, 81FC,0A,6122, 01FD,15,6126, 0005,15,6125

; Ninja space pirates
$B2:E64E             dx 0012, 81FD,EC,610E, 01F0,FC,A14D, 01EF,04,A13D, 01EF,0C,A12D, 81F2,F2,6105, 81F7,F1,612E, 8002,F3,612B, 800A,F3,612A, 81F9,FF,6107, 01F6,11,6144, 01F6,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143
$B2:E6AA             dx 0016, 01FA,15,6134, 01FB,0D,6124, 01FE,FB,614C, 0006,FB,614B, 000E,FB,614A, 01FC,F9,6113, 01FC,F1,6103, 01F8,18,6126, 0000,18,6125, 01FD,08,611A, 01FC,00,610A, 81FD,E6,610E, 81F7,EF,612E, 01FE,FD,6149, 0006,FD,6148, 0004,0D,6146, 000C,0D,6145, 0005,09,6134, 0005,01,6124, 01F4,F9,A14D, 01F3,01,A13D, 01F2,09,A12D

; Unused
$B2:E71A             dx 0014, 0000,F2,614F, 0008,F1,614E, 000C,EE,614D, 000C,E6,613D, 000C,DE,612D, 81FB,F1,612E, 8002,EB,610E, 000C,F0,613D, 000C,F8,614D, 8002,F1,6100, 81F9,FF,6107, 01F4,11,6144, 01F4,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143
$B2:E780             dx 000F, 0010,F7,612A, 8000,F7,612B, 81F9,F6,6100, 81F5,F2,612E, 81FC,EC,610E, 01FA,0B,6146, 0002,0B,6145, 01F7,00,6149, 01FF,FF,6148, 81F9,01,6122, 0009,F9,614D, 000A,F1,613D, 000B,E9,612D, 01F6,0D,6144, 01F6,05,6143
$B2:E7CD             dx 000E, 0008,05,A18D, 0008,0D,A17D, 0002,0B,6130, 0002,03,6120, 000F,F4,612A, 81FF,F4,612B, 81F8,F3,6100, 81F4,F0,612E, 81FB,EA,610E, 01F7,FE,6149, 01FF,FE,6148, 0007,F6,614D, 0008,EE,613D, 0009,E6,612D
$B2:E815             dx 000E, 0008,05,A18D, 0008,0D,A17D, 0003,0B,6130, 0003,03,6120, 0010,F3,612A, 8000,F3,612B, 81F8,F2,6100, 81F4,F1,612E, 81FB,EB,610E, 01F7,FF,6149, 01FF,FE,6148, 0008,F7,614D, 0009,EF,613D, 000A,E7,612D
$B2:E85D             dx 0009, 01FF,00,A14D, 01FF,08,A13D, 01FF,10,A12D, 01FE,FA,6113, 01FE,F2,6103, 81F8,EF,612E, 81FF,E9,610E, 0003,FD,614B, 000B,FE,614A
$B2:E88C             dx 0010, 81F7,FE,6107, 0014,F3,612A, 8004,F3,612B, 81FA,F1,6100, 81FE,EB,610E, 81F7,F1,612E, 000B,F9,614D, 000C,F1,613D, 000D,E9,612D, 81FC,FE,6107, 01FC,10,6125, 81FD,05,6122, 01F4,10,6126, 81F5,07,6122, 01FE,10,6126, 0006,10,6125

; Ninja space pirates
$B2:E8DE             dx 0011, 81FD,FB,6127, 81F5,FB,6128, 01FA,0D,6121, 01FA,15,6131, 01FB,18,6126, 0003,18,6125, 01FC,08,611A, 01FC,00,610A, 01F1,12,6144, 01F1,0A,6143, 01FE,06,6119, 01FD,FE,6109, 01FE,0A,616E, 81F6,F0,6105, 81FF,E6,610E, 81F9,EF,612E, 01F6,0A,616F
$B2:E935             dx 0013, 01FA,FF,610A, 0010,EE,612A, 8002,ED,612B, 81FA,EF,6100, 01EE,F5,A14D, 01ED,FD,A13D, 01EC,05,A12D, 81F9,E9,610E, 81F5,F1,612E, 01FB,07,611A, 0015,FD,A16F, 000D,FE,A16E, 01FD,FE,619F, 0005,FD,619E, 01F0,16,6126, 01F8,17,6125, 81F2,0A,6122, 001A,F4,A18D, 001B,FC,A17D
$B2:E996             dx 0013, 001A,0A,619D, 800E,01,61AC, 8001,FB,61AE, 01EF,F4,A14D, 01EE,FC,A13D, 01EE,04,A12D, 01F2,F3,615F, 01FA,F4,615E, 01F9,00,210A, 81FD,EC,610E, 81F7,F2,612E, 0009,10,218D, 0009,08,217D, 0004,08,216F, 01FC,09,216E, 01F8,08,211A, 0003,EA,614D, 0004,E2,613D, 0004,DA,612D

; Unused
$B2:E9F7             dx 0004, 81FA,00,2182, 81EA,00,2180, 81FA,F0,2162, 81EA,F0,2160
$B2:EA0D             dx 0006, 01F5,10,21A5, 01FD,10,21A6, 81FD,00,2186, 81ED,00,2184, 81FD,F0,2166, 81ED,F0,2164
$B2:EA2D             dx 0005, 000C,FE,217C, 81FC,06,218A, 81EC,06,2188, 81FC,F6,216A, 81EC,F6,2168
$B2:EA48             dx 0007, 0010,FA,E1A7, 81F0,F2,E1AA, 8000,F2,E1A8, 01F0,02,E1B4, 0008,02,E1B1, 0010,02,E1B0, 81F8,02,E1A2
$B2:EA6D             dx 0004, 81F6,F0,E182, 8006,F0,E180, 81F6,00,E162, 8006,00,E160
$B2:EA83             dx 0006, 0004,E8,E1A5, 01FC,E8,E1A6, 81F4,F0,E186, 8004,F0,E184, 81F4,00,E166, 8004,00,E164
$B2:EAA3             dx 0005, 01EC,FA,E17C, 81F4,EA,E18A, 8004,EA,E188, 81F4,FA,E16A, 8004,FA,E168
$B2:EABE             dx 0007, 01E9,FE,21A7, 8001,FE,21AA, 81F1,FE,21A8, 0009,F6,21B4, 01F1,F6,21B1, 01E9,F6,21B0, 81F9,EE,21A2
$B2:EAE3             dx 000D, 81F9,FC,2127, 8001,FC,2128, 01F1,F7,214D, 01F1,EF,213D, 01F1,E7,212D, 0006,FB,6112, 0006,F3,6102, 81FA,EB,210E, 0003,F9,6142, 01FB,F1,6141, 0003,F1,6140, 01FB,F9,6147, 81F1,F0,2100
$B2:EB26             dx 000E, 01F0,F7,214D, 01F0,EF,213D, 01F0,E7,212D, 81FE,EB,610E, 81F1,F0,2100, 0003,F9,6142, 01FB,F1,6141, 0003,F1,6140, 01FB,F9,6147, 0008,FD,A14D, 0008,05,A13D, 0008,0D,A12D, 0006,FB,6112, 0006,F3,6102
$B2:EB6E             dx 0014, 0000,F2,614F, 0008,F1,614E, 000C,EE,614D, 000C,E6,613D, 000C,DE,612D, 81FB,F1,612E, 8002,EB,610E, 000C,F0,613D, 000C,F8,614D, 8002,F1,6100, 81F9,FF,6107, 01F4,11,6144, 01F4,09,6143, 0001,09,A149, 01F9,09,A148, 81FC,FF,6107, 0003,0B,A149, 01FB,0B,A148, 01FA,13,6144, 01FA,0B,6143
$B2:EBD4             dx 0004, 81F6,00,6182, 8006,00,6180, 81F6,F0,6162, 8006,F0,6160
$B2:EBEA             dx 0006, 0003,10,61A5, 01FB,10,61A6, 81F3,00,6186, 8003,00,6184, 81F3,F0,6166, 8003,F0,6164
$B2:EC0A             dx 0005, 01EC,FE,617C, 81F4,06,618A, 8004,06,6188, 81F4,F6,616A, 8004,F6,6168
$B2:EC25             dx 0007, 01E8,FA,A1A7, 8000,F2,A1AA, 81F0,F2,A1A8, 0008,02,A1B4, 01F0,02,A1B1, 01E8,02,A1B0, 81F8,02,A1A2
$B2:EC4A             dx 0004, 81FA,F0,A182, 81EA,F0,A180, 81FA,00,A162, 81EA,00,A160
$B2:EC60             dx 0006, 01F4,E8,A1A5, 01FC,E8,A1A6, 81FC,F0,A186, 81EC,F0,A184, 81FC,00,A166, 81EC,00,A164
$B2:EC80             dx 0005, 000C,FA,A17C, 81FC,EA,A18A, 81EC,EA,A188, 81FC,FA,A16A, 81EC,FA,A168
$B2:EC9B             dx 0007, 000F,FE,61A7, 81EF,FE,61AA, 81FF,FE,61A8, 01EF,F6,61B4, 0007,F6,61B1, 000F,F6,61B0, 81F7,EE,61A2
}


;;; $ECC0..F15B: Wall space pirates ;;;
{
;;; $ECC0..EE3F: Instruction lists ;;;
{
;;; $ECC0: Instruction list - fire laser and wall-jump left ;;;
{
$B2:ECC0             dx EF83,F0E3,  ; Enemy function = RTS
                        0009,898C,
                        000F,899E,
                        EF2A,       ; Fire laser left
                        813A,0020,  ; Wait 20h frames
                        EEFD,       ; Prepare wall-jump to left
                        EF83,F0E4,  ; Enemy function = $F0E4 (wall-jumping left)
                        EF93,       ; Queue space pirate attack sound effect
                        000A,89B0,
                        0001,89BA,
                        812F        ; Sleep
}


;;; $ECE4: Instruction list - landed on left wall ;;;
{
$B2:ECE4             dw EF83,F034,  ; Enemy function = $F034 (climbing left wall)
                        000A,89B0
}


;;; $ECEC: Instruction list - moving up left wall ;;;
{
$B2:ECEC             dw EF83,F034,  ; Enemy function = $F034 (climbing left wall)
                        8123,0004   ; Timer = 4
$B2:ECF4             dx 000A,88A0,
                        EE40,FFFD,  ; Move enemy -3 pixels down and change direction on collision - left wall
                        0008,88B2,
                        EE40,FFFD,  ; Move enemy -3 pixels down and change direction on collision - left wall
                        0005,88C4,
                        EE40,FFFD,  ; Move enemy -3 pixels down and change direction on collision - left wall
                        0008,88D6,
                        EE40,FFFD,  ; Move enemy -3 pixels down and change direction on collision - left wall
                        000A,88E8,
                        EE40,FFFD,  ; Move enemy -3 pixels down and change direction on collision - left wall
                        0008,88D6,
                        EE40,FFFD,  ; Move enemy -3 pixels down and change direction on collision - left wall
                        0005,88C4,
                        EE40,FFFD,  ; Move enemy -3 pixels down and change direction on collision - left wall
                        0008,88B2,
                        8110,ECF4,  ; Decrement timer and go to $ECF4 if non-zero
                        EEA4        ; Randomly choose a direction - left wall
}


;;; $ED36: Instruction list - moving down left wall ;;;
{
$B2:ED36             dx EF83,F034,  ; Enemy function = $F034 (climbing left wall)
                        8123,0004   ; Timer = 4
$B2:ED3E             dx 000A,88A0,
                        EE40,0003,  ; Move enemy 3 pixels down and change direction on collision - left wall
                        0008,88B2,
                        EE40,0003,  ; Move enemy 3 pixels down and change direction on collision - left wall
                        0005,88C4,
                        EE40,0003,  ; Move enemy 3 pixels down and change direction on collision - left wall
                        0008,88D6,
                        EE40,0003,  ; Move enemy 3 pixels down and change direction on collision - left wall
                        000A,88E8,
                        EE40,0003,  ; Move enemy 3 pixels down and change direction on collision - left wall
                        0008,88D6,
                        EE40,0003,  ; Move enemy 3 pixels down and change direction on collision - left wall
                        0005,88C4,
                        EE40,0003,  ; Move enemy 3 pixels down and change direction on collision - left wall
                        0008,88B2,
                        8110,ED3E,  ; Decrement timer and go to $ED3E if non-zero
                        EEA4        ; Randomly choose a direction - left wall
}


;;; $ED80: Instruction list - fire laser and wall-jump right ;;;
{
$B2:ED80             dx EF83,F04F,  ; Enemy function = RTS
                        0009,88FA,
                        0001,890C,
                        EF5D,       ; Fire laser right
                        813A,0020,  ; Wait 20h frames
                        EED4,       ; Prepare wall-jump to right
                        EF83,F050,  ; Enemy function = $F050 (wall-jumping right)
                        EF93,       ; Queue space pirate attack sound effect
                        000A,891E,
                        0001,8928,
                        812F        ; Sleep
}


;;; $EDA4: Instruction list - landed on right wall ;;;
{
$B2:EDA4             dw EF83,F0C8,  ; Enemy function = $F0C8 (climbing right wall)
                        000A,891E
}


;;; $EDAC: Instruction list - moving down right wall ;;;
{
$B2:EDAC             dw EF83,F0C8,  ; Enemy function = $F0C8 (climbing right wall)
                        8123,0004   ; Timer = 4
$B2:EDB4             dx 000A,8932,
                        EE72,0003,  ; Move enemy 3 pixels down and change direction on collision - right wall
                        0008,8944,
                        EE72,0003,  ; Move enemy 3 pixels down and change direction on collision - right wall
                        0005,8956,
                        EE72,0003,  ; Move enemy 3 pixels down and change direction on collision - right wall
                        0008,8968,
                        EE72,0003,  ; Move enemy 3 pixels down and change direction on collision - right wall
                        000A,897A,
                        EE72,0003,  ; Move enemy 3 pixels down and change direction on collision - right wall
                        0008,8968,
                        EE72,0003,  ; Move enemy 3 pixels down and change direction on collision - right wall
                        0005,8956,
                        EE72,0003,  ; Move enemy 3 pixels down and change direction on collision - right wall
                        0008,8944,
                        8110,EDB4,  ; Decrement timer and go to $EDB4 if non-zero
                        EEBC        ; Randomly choose a direction - right wall
}


;;; $EDF6: Instruction list - moving up right wall ;;;
{
$B2:EDF6             dx EF83,F0C8,  ; Enemy function = $F0C8 (climbing right wall)
                        8123,0004   ; Timer = 4
$B2:EDFE             dx 000A,8932,
                        EE72,FFFD,  ; Move enemy -3 pixels down and change direction on collision - right wall
                        0008,8944,
                        EE72,FFFD,  ; Move enemy -3 pixels down and change direction on collision - right wall
                        0005,8956,
                        EE72,FFFD,  ; Move enemy -3 pixels down and change direction on collision - right wall
                        0008,8968,
                        EE72,FFFD,  ; Move enemy -3 pixels down and change direction on collision - right wall
                        000A,897A,
                        EE72,FFFD,  ; Move enemy -3 pixels down and change direction on collision - right wall
                        0008,8968,
                        EE72,FFFD,  ; Move enemy -3 pixels down and change direction on collision - right wall
                        0005,8956,
                        EE72,FFFD,  ; Move enemy -3 pixels down and change direction on collision - right wall
                        0008,8944,
                        8110,EDFE,  ; Decrement timer and go to $EDFE if non-zero
                        EEBC        ; Randomly choose a direction - right wall
}
}


;;; $EE40..EF9E: Instructions ;;;
{
;;; $EE40: Instruction - move [[Y]] pixels down and change direction on collision - left wall ;;;
{
$B2:EE40 DA          PHX
$B2:EE41 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EE44 A9 00 00    LDA #$0000             ;\
$B2:EE47 85 12       STA $12    [$7E:0012]  ;|
$B2:EE49 B9 00 00    LDA $0000,y[$B2:ED44]  ;|
$B2:EE4C 85 14       STA $14    [$7E:0014]  ;|
$B2:EE4E 5A          PHY                    ;} Move enemy down by [[Y]]
$B2:EE4F DA          PHX                    ;|
$B2:EE50 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;|
$B2:EE54 FA          PLX                    ;|
$B2:EE55 7A          PLY                    ;/
$B2:EE56 90 16       BCC $16    [$EE6E]     ; If not collided with block: go to BRANCH_NO_COLLISION
$B2:EE58 BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$B2:EE5B 49 01 00    EOR #$0001             ;} Enemy direction ^= up
$B2:EE5E 9D AC 0F    STA $0FAC,x[$7E:106C]  ;/
$B2:EE61 A0 36 ED    LDY #$ED36             ; Y = $ED36 (moving down left wall)
$B2:EE64 BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$B2:EE67 F0 03       BEQ $03    [$EE6C]     ;} If [enemy direction] != down:
$B2:EE69 A0 EC EC    LDY #$ECEC             ; Y = $ECEC (moving up left wall)

$B2:EE6C FA          PLX
$B2:EE6D 6B          RTL                    ; Return

; BRANCH_NO_COLLISION
$B2:EE6E FA          PLX
$B2:EE6F C8          INY                    ;\
$B2:EE70 C8          INY                    ;} Y += 2
$B2:EE71 6B          RTL
}


;;; $EE72: Instruction - move enemy [[Y]] pixels down and change direction on collision - right wall ;;;
{
$B2:EE72 DA          PHX
$B2:EE73 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EE76 A9 00 00    LDA #$0000             ;\
$B2:EE79 85 12       STA $12    [$7E:0012]  ;|
$B2:EE7B B9 00 00    LDA $0000,y[$B2:EDBA]  ;|
$B2:EE7E 85 14       STA $14    [$7E:0014]  ;|
$B2:EE80 5A          PHY                    ;} Move enemy down by [[Y]]
$B2:EE81 DA          PHX                    ;|
$B2:EE82 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;|
$B2:EE86 FA          PLX                    ;|
$B2:EE87 7A          PLY                    ;/
$B2:EE88 90 16       BCC $16    [$EEA0]     ; If not collided with block: go to BRANCH_NO_COLLISION
$B2:EE8A BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$B2:EE8D 49 01 00    EOR #$0001             ;} Enemy direction ^= up
$B2:EE90 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;/
$B2:EE93 A0 AC ED    LDY #$EDAC             ; Y = $EDAC (moving down right wall)
$B2:EE96 BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$B2:EE99 F0 03       BEQ $03    [$EE9E]     ;} If [enemy direction] != down:
$B2:EE9B A0 F6 ED    LDY #$EDF6             ; Y = $EDF6 (moving up right wall)

$B2:EE9E FA          PLX
$B2:EE9F 6B          RTL                    ; Return

; BRANCH_NO_COLLISION
$B2:EEA0 FA          PLX
$B2:EEA1 C8          INY                    ;\
$B2:EEA2 C8          INY                    ;} Y += 2
$B2:EEA3 6B          RTL
}


;;; $EEA4: Instruction - randomly choose a direction - left wall ;;;
{
$B2:EEA4 DA          PHX
$B2:EEA5 A0 36 ED    LDY #$ED36             ; Y = $ED36 (moving down left wall)
$B2:EEA8 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EEAB 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B2:EEAF 29 01 00    AND #$0001             ;\
$B2:EEB2 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy direction = [random number] & 1
$B2:EEB5 F0 03       BEQ $03    [$EEBA]     ; If [enemy direction] != down:
$B2:EEB7 A0 EC EC    LDY #$ECEC             ; Y = $ECEC (moving up left wall)

$B2:EEBA FA          PLX
$B2:EEBB 6B          RTL
}


;;; $EEBC: Instruction - randomly choose a direction - right wall ;;;
{
$B2:EEBC DA          PHX
$B2:EEBD A0 AC ED    LDY #$EDAC             ; Y = $EDAC (moving down right wall)
$B2:EEC0 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EEC3 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B2:EEC7 29 01 00    AND #$0001             ;\
$B2:EECA 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;} Enemy direction = [random number] & 1
$B2:EECD F0 03       BEQ $03    [$EED2]     ; If [enemy direction] != down:
$B2:EECF A0 F6 ED    LDY #$EDF6             ; Y = $EDF6 (moving up right wall)

$B2:EED2 FA          PLX
$B2:EED3 6B          RTL
}


;;; $EED4: Instruction - prepare wall-jump to right ;;;
{
$B2:EED4 DA          PHX
$B2:EED5 5A          PHY
$B2:EED6 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EED9 BD B6 0F    LDA $0FB6,x[$7E:1236]  ;\
$B2:EEDC 18          CLC                    ;|
$B2:EEDD 7D 7A 0F    ADC $0F7A,x[$7E:11FA]  ;} Enemy $0FAA = [enemy X position] + [enemy parameter 2] (never read)
$B2:EEE0 9D AA 0F    STA $0FAA,x[$7E:122A]  ;/
$B2:EEE3 BD B6 0F    LDA $0FB6,x[$7E:1236]  ;\
$B2:EEE6 4A          LSR A                  ;|
$B2:EEE7 18          CLC                    ;} Enemy wall-jump arc centre X position = [enemy X position] + [enemy parameter 2] / 2
$B2:EEE8 7D 7A 0F    ADC $0F7A,x[$7E:11FA]  ;|
$B2:EEEB 9D AE 0F    STA $0FAE,x[$7E:122E]  ;/
$B2:EEEE BD 7E 0F    LDA $0F7E,x[$7E:11FE]  ;\
$B2:EEF1 9D B0 0F    STA $0FB0,x[$7E:1230]  ;} Enemy wall-jump arc centre Y position = [enemy Y position]
$B2:EEF4 A9 40 00    LDA #$0040             ;\
$B2:EEF7 9D B2 0F    STA $0FB2,x[$7E:1232]  ;} Enemy wall-jump arc angle = 40h
$B2:EEFA 7A          PLY
$B2:EEFB FA          PLX
$B2:EEFC 6B          RTL
}


;;; $EEFD: Instruction - prepare wall-jump to left ;;;
{
$B2:EEFD DA          PHX
$B2:EEFE 5A          PHY
$B2:EEFF AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EF02 BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;\
$B2:EF05 38          SEC                    ;|
$B2:EF06 FD B6 0F    SBC $0FB6,x[$7E:11F6]  ;} Enemy $0FAA = [enemy X position] - [enemy parameter 2] (never read)
$B2:EF09 9D AA 0F    STA $0FAA,x[$7E:11EA]  ;/
$B2:EF0C BD B6 0F    LDA $0FB6,x[$7E:11F6]  ;\
$B2:EF0F 4A          LSR A                  ;|
$B2:EF10 85 12       STA $12    [$7E:0012]  ;|
$B2:EF12 BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;} Enemy wall-jump arc centre X position = [enemy X position] - [enemy parameter 2] / 2
$B2:EF15 38          SEC                    ;|
$B2:EF16 E5 12       SBC $12    [$7E:0012]  ;|
$B2:EF18 9D AE 0F    STA $0FAE,x[$7E:11EE]  ;/
$B2:EF1B BD 7E 0F    LDA $0F7E,x[$7E:11BE]  ;\
$B2:EF1E 9D B0 0F    STA $0FB0,x[$7E:11F0]  ;} Enemy wall-jump arc centre Y position = [enemy Y position]
$B2:EF21 A9 C0 00    LDA #$00C0             ;\
$B2:EF24 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;} Enemy wall-jump arc angle = C0h
$B2:EF27 7A          PLY
$B2:EF28 FA          PLX
$B2:EF29 6B          RTL
}


;;; $EF2A: Instruction - fire laser left ;;;
{
$B2:EF2A DA          PHX
$B2:EF2B 5A          PHY
$B2:EF2C AC 54 0E    LDY $0E54  [$7E:0E54]
$B2:EF2F BE 78 0F    LDX $0F78,y[$7E:1078]  ;\
$B2:EF32 BF 06 00 A0 LDA $A00006,x[$A0:F359];} Enemy projectile initialisation parameter = (enemy damage), this is actually ignored >_>
$B2:EF36 8D 93 19    STA $1993  [$7E:1993]  ;/
$B2:EF39 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EF3C BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;\
$B2:EF3F 38          SEC                    ;|
$B2:EF40 E9 18 00    SBC #$0018             ;} $12 = [enemy X position] - 18h
$B2:EF43 85 12       STA $12    [$7E:0012]  ;/
$B2:EF45 BD 7E 0F    LDA $0F7E,x[$7E:107E]  ;\
$B2:EF48 38          SEC                    ;|
$B2:EF49 E9 10 00    SBC #$0010             ;} $14 = [enemy Y position] - 10h
$B2:EF4C 85 14       STA $14    [$7E:0014]  ;/
$B2:EF4E A9 00 00    LDA #$0000             ;\
$B2:EF51 85 16       STA $16    [$7E:0016]  ;} $16 = 0
$B2:EF53 A0 7B A1    LDY #$A17B             ;\
$B2:EF56 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn laser enemy projectile
$B2:EF5A 7A          PLY
$B2:EF5B FA          PLX
$B2:EF5C 6B          RTL
}


;;; $EF5D: Instruction - fire laser right ;;;
{
$B2:EF5D DA          PHX
$B2:EF5E 5A          PHY
$B2:EF5F AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EF62 BD 7A 0F    LDA $0F7A,x[$7E:11FA]  ;\
$B2:EF65 18          CLC                    ;|
$B2:EF66 69 18 00    ADC #$0018             ;} $12 = [enemy X position] + 18h
$B2:EF69 85 12       STA $12    [$7E:0012]  ;/
$B2:EF6B BD 7E 0F    LDA $0F7E,x[$7E:11FE]  ;\
$B2:EF6E 38          SEC                    ;|
$B2:EF6F E9 10 00    SBC #$0010             ;} $14 = [enemy Y position] - 10h
$B2:EF72 85 14       STA $14    [$7E:0014]  ;/
$B2:EF74 A9 01 00    LDA #$0001             ;\
$B2:EF77 85 16       STA $16    [$7E:0016]  ;} $16 = 1
$B2:EF79 A0 7B A1    LDY #$A17B             ;\
$B2:EF7C 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn laser enemy projectile
$B2:EF80 7A          PLY
$B2:EF81 FA          PLX
$B2:EF82 6B          RTL
}


;;; $EF83: Instruction - enemy function = [[Y]] ;;;
{
$B2:EF83 5A          PHY
$B2:EF84 DA          PHX
$B2:EF85 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EF88 B9 00 00    LDA $0000,y[$B2:EDAE]  ;\
$B2:EF8B 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = [[Y]]
$B2:EF8E FA          PLX
$B2:EF8F 7A          PLY
$B2:EF90 C8          INY                    ;\
$B2:EF91 C8          INY                    ;} Y += 2
$B2:EF92 6B          RTL
}


;;; $EF93: Instruction - queue space pirate attack sound effect ;;;
{
$B2:EF93 DA          PHX
$B2:EF94 5A          PHY
$B2:EF95 A9 66 00    LDA #$0066             ;\
$B2:EF98 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
$B2:EF9C 7A          PLY
$B2:EF9D FA          PLX
$B2:EF9E 6B          RTL
}
}


;;; $EF9F: Initialisation AI - enemy $F353/$F393/$F3D3/$F413/$F453/$F493 (wall space pirates) ;;;
{
$B2:EF9F AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:EFA2 A0 36 ED    LDY #$ED36             ; Enemy instruction list pointer = $ED36 (moving down left wall)
$B2:EFA5 BD B4 0F    LDA $0FB4,x[$7E:0FF4]  ;\
$B2:EFA8 89 01 00    BIT #$0001             ;} If [enemy parameter 1] & 1 != 0:
$B2:EFAB F0 03       BEQ $03    [$EFB0]     ;/
$B2:EFAD A0 AC ED    LDY #$EDAC             ; Enemy instruction list pointer = $EDAC (moving down right wall)

$B2:EFB0 98          TYA
$B2:EFB1 9D 92 0F    STA $0F92,x[$7E:0FD2]
$B2:EFB4 A9 BE 00    LDA #$00BE             ;\
$B2:EFB7 9F 00 80 7E STA $7E8000,x[$7E:8040];} Enemy wall-jump arc right target angle = BEh
$B2:EFBB A9 42 00    LDA #$0042             ;\
$B2:EFBE 9F 02 80 7E STA $7E8002,x[$7E:8042];} Enemy wall-jump arc left target angle = 42h
$B2:EFC2 A9 02 00    LDA #$0002             ;\
$B2:EFC5 9F 04 80 7E STA $7E8004,x[$7E:8044];} Enemy wall-jump arc angle delta = 2
$B2:EFC9 BD B4 0F    LDA $0FB4,x[$7E:0FF4]  ;\
$B2:EFCC 89 00 80    BIT #$8000             ;} If [enemy parameter 1] & 8000h = 0 (fast jump):
$B2:EFCF D0 24       BNE $24    [$EFF5]     ;/
$B2:EFD1 BF 00 80 7E LDA $7E8000,x[$7E:8040];\
$B2:EFD5 18          CLC                    ;|
$B2:EFD6 69 02 00    ADC #$0002             ;} Enemy wall-jump arc right target angle = C0h
$B2:EFD9 9F 00 80 7E STA $7E8000,x[$7E:8040];/
$B2:EFDD BF 02 80 7E LDA $7E8002,x[$7E:8042];\
$B2:EFE1 38          SEC                    ;|
$B2:EFE2 E9 02 00    SBC #$0002             ;} Enemy wall-jump arc left target angle = 40h
$B2:EFE5 9F 02 80 7E STA $7E8002,x[$7E:8042];/
$B2:EFE9 BF 04 80 7E LDA $7E8004,x[$7E:8044];\
$B2:EFED 18          CLC                    ;|
$B2:EFEE 69 02 00    ADC #$0002             ;} Enemy wall-jump arc angle delta = 4
$B2:EFF1 9F 04 80 7E STA $7E8004,x[$7E:8044];/

$B2:EFF5 A0 34 F0    LDY #$F034             ; Enemy function = $F034 (climbing left wall)
$B2:EFF8 BD B4 0F    LDA $0FB4,x[$7E:0FF4]  ;\
$B2:EFFB 89 01 00    BIT #$0001             ;} If [enemy parameter 1] & 1 != 0:
$B2:EFFE F0 03       BEQ $03    [$F003]     ;/
$B2:F000 A0 C8 F0    LDY #$F0C8             ; Enemy function = $F0C8 (climbing right wall)

$B2:F003 98          TYA
$B2:F004 9D A8 0F    STA $0FA8,x[$7E:0FE8]
$B2:F007 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F00A 29 0F 00    AND #$000F             ;|
$B2:F00D C9 0B 00    CMP #$000B             ;} If [enemy X position] % 10h >= Bh:
$B2:F010 30 0F       BMI $0F    [$F021]     ;/
$B2:F012 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F015 29 F0 FF    AND #$FFF0             ;|
$B2:F018 18          CLC                    ;} Enemy X position = [enemy X position] - [enemy X position] % 10h + 10h
$B2:F019 69 10 00    ADC #$0010             ;|
$B2:F01C 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$B2:F01F 80 0B       BRA $0B    [$F02C]     ; Return

$B2:F021 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:F024 29 F8 FF    AND #$FFF8             ;} Enemy X position -= [enemy X position] % 8
$B2:F027 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$B2:F02A 80 00       BRA $00    [$F02C]

$B2:F02C 6B          RTL
}


;;; $F02D: Main AI - enemy $F353/$F393/$F3D3/$F413/$F453/$F493 (wall space pirates) ;;;
{
$B2:F02D AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F030 FC A8 0F    JSR ($0FA8,x)[$B2:F0C8]; Execute [enemy function]
$B2:F033 6B          RTL
}


;;; $F034: Wall space pirate function - climbing left wall ;;;
{
$B2:F034 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F037 A9 20 00    LDA #$0020             ;\
$B2:F03A 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;} If Samus is within 20h pixel rows of enemy:
$B2:F03E F0 0D       BEQ $0D    [$F04D]     ;/
$B2:F040 A9 80 ED    LDA #$ED80             ;\
$B2:F043 9D 92 0F    STA $0F92,x[$7E:1212]  ;} Enemy instruction list pointer = $ED80 (fire laser and wall-jump right)
$B2:F046 A9 01 00    LDA #$0001             ;\
$B2:F049 9D 94 0F    STA $0F94,x[$7E:1214]  ;} Enemy instruction timer = 1
$B2:F04C 60          RTS

$B2:F04D 60          RTS
}


;;; $F04E: Unused. RTS ;;;
{
$B2:F04E 60          RTS
}


;;; $F04F: RTS ;;;
{
$B2:F04F 60          RTS
}


;;; $F050: Wall space pirate function - wall-jumping right ;;;
{
$B2:F050 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F053 BD B6 0F    LDA $0FB6,x[$7E:1236]  ;\
$B2:F056 4A          LSR A                  ;|
$B2:F057 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$B2:F05A BD B2 0F    LDA $0FB2,x[$7E:1232]  ;|
$B2:F05D 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;} Enemy X position = [enemy wall-jump arc centre X position] + [enemy parameter 2] / 2 * -sin([enemy wall-jump arc angle] * pi / 80h) * FFh / 100h
$B2:F061 18          CLC                    ;|
$B2:F062 7D AE 0F    ADC $0FAE,x[$7E:122E]  ;|
$B2:F065 9D 7A 0F    STA $0F7A,x[$7E:11FA]  ;/
$B2:F068 BD B6 0F    LDA $0FB6,x[$7E:1236]  ;\
$B2:F06B 4A          LSR A                  ;|
$B2:F06C 4A          LSR A                  ;|
$B2:F06D 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$B2:F070 BD B2 0F    LDA $0FB2,x[$7E:1232]  ;|
$B2:F073 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Enemy Y position = [enemy wall-jump arc centre Y position] - [enemy parameter 2] / 4 * cos([enemy wall-jump arc angle] * pi / 80h) * FFh / 100h
$B2:F077 49 FF FF    EOR #$FFFF             ;|
$B2:F07A 1A          INC A                  ;|
$B2:F07B 18          CLC                    ;|
$B2:F07C 7D B0 0F    ADC $0FB0,x[$7E:1230]  ;|
$B2:F07F 9D 7E 0F    STA $0F7E,x[$7E:11FE]  ;/
$B2:F082 BD B2 0F    LDA $0FB2,x[$7E:1232]  ;\
$B2:F085 38          SEC                    ;|
$B2:F086 FF 04 80 7E SBC $7E8004,x[$7E:8284];} Enemy wall-jump arc angle = ([enemy wall-jump arc angle] - [enemy wall-jump arc angle delta]) % 100h
$B2:F08A 29 FF 00    AND #$00FF             ;|
$B2:F08D 9D B2 0F    STA $0FB2,x[$7E:1232]  ;/
$B2:F090 DF 00 80 7E CMP $7E8000,x[$7E:8280];\
$B2:F094 D0 31       BNE $31    [$F0C7]     ;} If [enemy wall-jump arc angle] != [enemy wall-jump arc right target angle]: return
$B2:F096 A9 A4 ED    LDA #$EDA4             ;\
$B2:F099 9D 92 0F    STA $0F92,x[$7E:1212]  ;} Enemy instruction list pointer = $EDA4 (landed on right wall)
$B2:F09C A9 01 00    LDA #$0001             ;\
$B2:F09F 9D 94 0F    STA $0F94,x[$7E:1214]  ;} Enemy instruction timer = 1
$B2:F0A2 BD 7A 0F    LDA $0F7A,x[$7E:11FA]  ;\
$B2:F0A5 29 0F 00    AND #$000F             ;|
$B2:F0A8 C9 0B 00    CMP #$000B             ;} If [enemy X position] % 10h >= Bh:
$B2:F0AB 30 0F       BMI $0F    [$F0BC]     ;/
$B2:F0AD BD 7A 0F    LDA $0F7A,x[$7E:11FA]  ;\
$B2:F0B0 29 F0 FF    AND #$FFF0             ;|
$B2:F0B3 18          CLC                    ;} Enemy X position = [enemy X position] - [enemy X position] % 10h + 10h
$B2:F0B4 69 10 00    ADC #$0010             ;|
$B2:F0B7 9D 7A 0F    STA $0F7A,x[$7E:11FA]  ;/
$B2:F0BA 80 0B       BRA $0B    [$F0C7]     ; Return

$B2:F0BC BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:F0BF 29 F8 FF    AND #$FFF8             ;} Enemy X position -= [enemy X position] % 8
$B2:F0C2 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$B2:F0C5 80 00       BRA $00    [$F0C7]

$B2:F0C7 60          RTS
}


;;; $F0C8: Wall space pirate function - climbing right wall ;;;
{
$B2:F0C8 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F0CB A9 20 00    LDA #$0020             ;\
$B2:F0CE 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;} If Samus is within 20h pixel rows of enemy:
$B2:F0D2 F0 0D       BEQ $0D    [$F0E1]     ;/
$B2:F0D4 A9 C0 EC    LDA #$ECC0             ;\
$B2:F0D7 9D 92 0F    STA $0F92,x[$7E:1092]  ;} Enemy instruction list pointer = $ECC0 (fire laser and wall-jump left)
$B2:F0DA A9 01 00    LDA #$0001             ;\
$B2:F0DD 9D 94 0F    STA $0F94,x[$7E:1094]  ;} Enemy instruction timer = 1
$B2:F0E0 60          RTS

$B2:F0E1 60          RTS
}


;;; $F0E2: Unused. RTS ;;;
{
$B2:F0E2 60          RTS
}


;;; $F0E3: RTS ;;;
{
$B2:F0E3 60          RTS
}


;;; $F0E4: Wall space pirate function - wall-jumping left ;;;
{
$B2:F0E4 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F0E7 BD B6 0F    LDA $0FB6,x[$7E:11F6]  ;\
$B2:F0EA 4A          LSR A                  ;|
$B2:F0EB 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$B2:F0EE BD B2 0F    LDA $0FB2,x[$7E:11F2]  ;|
$B2:F0F1 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;} Enemy X position = [enemy wall-jump arc centre X position] + [enemy parameter 2] / 2 * -sin([enemy wall-jump arc angle] * pi / 80h) * FFh / 100h
$B2:F0F5 18          CLC                    ;|
$B2:F0F6 7D AE 0F    ADC $0FAE,x[$7E:11EE]  ;|
$B2:F0F9 9D 7A 0F    STA $0F7A,x[$7E:11BA]  ;/
$B2:F0FC BD B6 0F    LDA $0FB6,x[$7E:11F6]  ;\
$B2:F0FF 4A          LSR A                  ;|
$B2:F100 4A          LSR A                  ;|
$B2:F101 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$B2:F104 BD B2 0F    LDA $0FB2,x[$7E:11F2]  ;|
$B2:F107 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Enemy Y position = [enemy wall-jump arc centre Y position] - [enemy parameter 2] / 4 * cos([enemy wall-jump arc angle] * pi / 80h) * FFh / 100h
$B2:F10B 49 FF FF    EOR #$FFFF             ;|
$B2:F10E 1A          INC A                  ;|
$B2:F10F 18          CLC                    ;|
$B2:F110 7D B0 0F    ADC $0FB0,x[$7E:11F0]  ;|
$B2:F113 9D 7E 0F    STA $0F7E,x[$7E:11BE]  ;/
$B2:F116 BD B2 0F    LDA $0FB2,x[$7E:11F2]  ;\
$B2:F119 18          CLC                    ;|
$B2:F11A 7F 04 80 7E ADC $7E8004,x[$7E:8244];} Enemy wall-jump arc angle = ([enemy wall-jump arc angle] + [enemy wall-jump arc angle delta]) % 100h
$B2:F11E 29 FF 00    AND #$00FF             ;|
$B2:F121 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;/
$B2:F124 DF 02 80 7E CMP $7E8002,x[$7E:8242];\
$B2:F128 D0 31       BNE $31    [$F15B]     ;} If [enemy wall-jump arc angle] != [enemy wall-jump arc left target angle]: return
$B2:F12A A9 E4 EC    LDA #$ECE4             ;\
$B2:F12D 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $ECE4 (landed on left wall)
$B2:F130 A9 01 00    LDA #$0001             ;\
$B2:F133 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$B2:F136 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F139 29 0F 00    AND #$000F             ;|
$B2:F13C C9 0B 00    CMP #$000B             ;} If [enemy X position] % 10h >= Bh:
$B2:F13F 30 0F       BMI $0F    [$F150]     ;/
$B2:F141 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:F144 29 F0 FF    AND #$FFF0             ;|
$B2:F147 18          CLC                    ;} Enemy X position = [enemy X position] - [enemy X position] % 10h + 10h
$B2:F148 69 10 00    ADC #$0010             ;|
$B2:F14B 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$B2:F14E 80 0B       BRA $0B    [$F15B]     ; Return

$B2:F150 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F153 29 F8 FF    AND #$FFF8             ;} Enemy X position -= [enemy X position] % 8
$B2:F156 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$B2:F159 80 00       BRA $00    [$F15B]     ; >_<;

$B2:F15B 60          RTS
}
}


;;; $F15C..FB4B: Ninja space pirates ;;;
{
;;; $F15C..F535: Instruction lists ;;;
{
;;; $F15C: Instruction list - projectile claw attack left ;;;
{
$B2:F15C             dx EF83,804B,          ; Enemy function = RTS
                        0005,8A54,
                        0005,8A66,
                        0005,8A78,
                        0005,8A8A,
                        0005,8A9C,
                        0002,8AAE,
                        F564,0000,FFE0,FFF8,; Spawn space pirate claw enemy projectile thrown left with offset (-20h, -8)
                        F546,0066,          ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0002,8AC0,
                        0002,8AD2,
                        0002,8AE4,
                        0005,8A54,
                        0005,8A66,
                        0005,8A78,
                        0005,8A8A,
                        0005,8A9C,
                        0002,8AAE,
                        F564,0000,FFF0,0008,; Spawn space pirate claw enemy projectile thrown left with offset (-10h, 8)
                        F546,0066,          ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0002,8AC0,
                        0002,8AD2,
                        0002,8AE4,
                        80ED,F22E           ; Go to $F22E (active - facing left)
}


;;; $F1C4: Instruction list - spin jump left ;;;
{
$B2:F1C4             dx EF83,804B,          ; Enemy function = RTS
                        0005,8A54,
                        0005,8A66,
                        0005,8A78,
                        0005,8A8A,
                        0005,8A9C,
                        0002,8AAE,
                        F564,0000,FFE0,FFF8,; Spawn space pirate claw enemy projectile thrown left with offset (-20h, -8)
                        F546,0066,          ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0002,8AC0,
                        0002,8AD2,
                        0002,8AE4,
                        F5D6,               ; Enemy speed = 0
                        EF83,804B,          ; Enemy function = RTS
                        0008,8A54,
                        EF83,F817           ; Enemy function = $F817 (spin jump left - rising)
$B2:F206             dx F546,003F,          ; Queue sound 3Fh, sound library 2, max queued sounds allowed = 6 (ninja pirate spin jump)
                        0001,8D96,
                        0001,8DA0,
                        0001,8DAA,
                        0001,8DB4,
                        0001,8DBE,
                        0001,8DC8,
                        0001,8DD2,
                        0001,8DDC,
                        80ED,F206           ; Go to $F206
}


;;; $F22E: Instruction list - active - facing left ;;;
{
$B2:F22E             dx EF83,F6E4   ; Enemy function = $F6E4 (active)
$B2:F232             dx 000A,8F56,
                        000A,8F60,
                        000A,8F6A,
                        000A,8F60,
                        EF83,804B,  ; Enemy function = RTS
                        F590,       ; Set enemy $0FAC
                        80ED,F232   ; Go to $F232
}


;;; $F24C: Unused. Instruction list - walking left ;;;
{
$B2:F24C             dx 0005,8E36,
                        0005,8E48,
                        0005,8E5A,
                        0005,8E6C,
                        0005,8E7E,
                        0005,8E90,
                        0005,8EA2,
                        0005,8EB4,
                        80ED,F24C   ; Go to $F24C
}


;;; $F270: Instruction list - flinch - facing left ;;;
{
$B2:F270             dx EF83,804B,  ; Enemy function = RTS
                        0010,8F9C,
                        80ED,F22E   ; Go to $F22E (active - facing left)
}


;;; $F27C: Instruction list - divekick left - jump ;;;
{
$B2:F27C             dx EF83,804B,  ; Enemy function = RTS
                        0008,90FE,
                        F969,       ; Set left divekick jump initial Y speed
                        EF83,F985   ; Enemy function = $F985 (divekick left - jump)
$B2:F28A             dx F536,0200,  ; Enemy palette index = 200h (palette 1)
                        0004,900A,
                        F536,0E00,  ; Enemy palette index = E00h (palette 7)
                        0004,900A,
                        80ED,F28A,  ; Go to $F28A
                        812F        ; Sleep
}


;;; $F2A0: Instruction list - divekick left - divekick ;;;
{
$B2:F2A0             dx F536,0E00,  ; Enemy palette index = E00h (palette 7)
                        EF83,F9C1,  ; Enemy function = $F9C1 (divekick left - divekick)
                        F546,0066,  ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0001,9014,
                        812F        ; Sleep
}


;;; $F2B2: Instruction list - divekick left - walk to left post ;;;
{
$B2:F2B2             dx EF83,FA15,  ; Enemy function = $FA15 (divekick left - walk to left post)
                        0005,8E36,
                        0005,8E48,
                        0005,8E5A,
                        0005,8E6C,
                        0005,8E7E,
                        0005,8E90,
                        0005,8EA2,
                        0005,8EB4,
                        80ED,F2B6   ; Go to $F2B6
}


;;; $F2DA: Instruction list - initial - facing left ;;;
{
$B2:F2DA             dx EF83,F6A9,  ; Enemy function = $F6A9 (initial)
                        0020,93EA,
                        000A,9404,
                        0020,9416,
                        000A,9404,
                        0020,93EA,
                        80ED,F2DE,  ; Go to $F2DE
                        812F        ; Sleep
}


;;; $F2F8: Instruction list - land - facing left ;;;
{
$B2:F2F8             dx F536,0200,  ; Enemy palette index = 200h (palette 1)
                        EF83,804B,  ; Enemy function = RTS
                        0004,9404,
                        0008,93EA,
                        0004,9476,
                        0004,944A,
                        EF83,F909   ; Enemy function = $F909 (ready to divekick)
$B2:F314             dx 000A,8F74,
                        000A,8F7E,
                        000A,8F88,
                        000A,8F7E,
                        80ED,F314   ; Go to $F314
}


;;; $F328: Unused. Instruction list - facing forward ;;;
{
$B2:F328             dx 0008,9476,
                        812F        ; Sleep
}


;;; $F32E: Instruction list - standing kick - facing left ;;;
{
$B2:F32E             dx EF83,804B,  ; Enemy function = RTS
                        0004,9032,
                        F546,0066,  ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0004,9372,
                        0020,903C,
                        0004,9372,
                        80ED,F22E   ; Go to $F22E (active - facing left)
}


;;; $F34A: Instruction list - projectile claw attack right ;;;
{
$B2:F34A             dx EF83,804B,          ; Enemy function = RTS
                        0005,8B86,
                        0005,8B98,
                        0005,8BAA,
                        0005,8BBC,
                        0005,8BCE,
                        0002,8BE0,
                        F564,0001,0020,FFF8,; Spawn space pirate claw enemy projectile thrown right with offset (20h, -8)
                        F546,0066,          ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0002,8B98,
                        0002,8BF2,
                        0002,8C16,
                        0005,8B86,
                        0005,8B98,
                        0005,8BAA,
                        0005,8BBC,
                        0005,8BCE,
                        0002,8BE0,
                        F564,0001,0010,0008,; Spawn space pirate claw enemy projectile thrown right with offset (10h, 8)
                        0002,8B98,
                        F546,0066,          ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0002,8BF2,
                        0002,8C16,
                        80ED,F420           ; Go to $F420 (active - facing right)
}


;;; $F3B2: Instruction list - spin jump right ;;;
{
$B2:F3B2             dx EF83,804B,          ; Enemy function = RTS
                        0005,8B86,
                        0005,8B98,
                        0005,8BAA,
                        0005,8BBC,
                        0005,8BCE,
                        0002,8BE0,
                        F564,0001,0020,FFF8,; Spawn space pirate claw enemy projectile thrown right with offset (20h, -8)
                        F546,0066,          ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0002,8B98,
                        0002,8BF2,
                        0002,8C16,
                        F5D6,               ; Enemy speed = 0
                        EF83,804B,          ; Enemy function = RTS
                        0008,8B86,
                        EF83,F890           ; Enemy function = $F890 (spin jump right - rising)
$B2:F3F4             dx F546,003F,          ; Queue sound 3Fh, sound library 2, max queued sounds allowed = 6 (ninja pirate spin jump)
                        0001,8DE6,
                        0001,8DF0,
                        0001,8DFA,
                        0001,8E04,
                        0001,8E0E,
                        0001,8E18,
                        0001,8E22,
                        0001,8E2C,
                        80ED,F3F4           ; Go to $F3F4
}


;;; $F41C: Unused. Instruction list ;;;
{
$B2:F41C             dx 0010,8B86
}


;;; $F420: Instruction list - active - facing right ;;;
{
$B2:F420             dx EF83,F6E4   ; Enemy function = $F6E4 (active)
$B2:F424             dx 000A,8F74,
                        000A,8F7E,
                        000A,8F88,
                        000A,8F7E,
                        EF83,804B,  ; Enemy function = RTS
                        F590,       ; Set enemy $0FAC
                        80ED,F424   ; Go to $F424
}


;;; $F43E: Unused. Instruction list - walking right ;;;
{
$B2:F43E             dx 0005,8EC6,
                        0005,8ED8,
                        0005,8EEA,
                        0005,8EFC,
                        0005,8F0E,
                        0005,8F20,
                        0005,8F32,
                        0005,8F44,
                        80ED,F43E   ; Go to $F43E
}


;;; $F462: Instruction list - flinch - facing right ;;;
{
$B2:F462             dx EF83,804B,  ; Enemy function = RTS
                        0010,8FB0,
                        80ED,F420   ; Go to $F420 (active - facing right)
}


;;; $F46E: Instruction list - divekick right - jump ;;;
{
$B2:F46E             dx EF83,804B,  ; Enemy function = RTS
                        0008,9280,
                        FA3D,       ; Set right divekick jump initial Y speed
                        EF83,FA59   ; Enemy function = $FA59 (divekick right - jump)
$B2:F47C             dx F536,0200,  ; Enemy palette index = 200h (palette 1)
                        0004,901E,
                        F536,0E00,  ; Enemy palette index = E00h (palette 7)
                        0004,901E,
                        80ED,F47C,  ; Go to $F47C
                        812F        ; Sleep
}


;;; $F492: Instruction list - divekick right - divekick ;;;
{
$B2:F492             dx F536,0E00,  ; Enemy palette index = E00h (palette 7)
                        EF83,FA95,  ; Enemy function = $FA95 (divekick right - divekick)
                        F546,0066,  ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0001,9028,
                        812F        ; Sleep
}


;;; $F4A4: Instruction list - divekick right - walk to right post ;;;
{
$B2:F4A4             dx EF83,FAE9,  ; Enemy function = $FAE9 (divekick right - walk to right post)
                        0005,8EC6,
                        0005,8ED8,
                        0005,8EEA,
                        0005,8EFC,
                        0005,8F0E,
                        0005,8F20,
                        0005,8F32,
                        0005,8F44,
                        80ED,F4A8   ; Go to $F4A8
}


;;; $F4CC: Instruction list - initial - facing right ;;;
{
$B2:F4CC             dx EF83,F6A9,  ; Enemy function = $F6A9 (initial)
                        0020,9430,
                        000A,944A,
                        0020,945C,
                        000A,944A,
                        0020,9430,
                        80ED,F4D0,  ; Go to $F4D0
                        812F        ; Sleep
}


;;; $F4EA: Instruction list - land - facing right ;;;
{
$B2:F4EA             dx F536,0200,  ; Enemy palette index = 200h (palette 1)
                        EF83,804B,  ; Enemy function = RTS
                        0004,944A,
                        0008,9430,
                        0004,9476,
                        0004,9404,
                        EF83,F909   ; Enemy function = $F909 (ready to divekick)
$B2:F506             dx 000A,8F56,
                        000A,8F60,
                        000A,8F6A,
                        000A,8F60,
                        80ED,F506   ; Go to $F506
}


;;; $F51A: Instruction list - standing kick - facing right ;;;
{
$B2:F51A             dx EF83,804B,  ; Enemy function = RTS
                        0004,9046,
                        F546,0066,  ; Queue sound 66h, sound library 2, max queued sounds allowed = 6 (space pirate attack)
                        0004,937C,
                        0020,9050,
                        0004,937C,
                        80ED,F420   ; Go to $F420 (active - facing right)
}
}


;;; $F536..DC: Instructions ;;;
{
;;; $F536: Instruction - enemy palette index = [[Y]] ;;;
{
$B2:F536 DA          PHX
$B2:F537 5A          PHY
$B2:F538 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F53B B9 00 00    LDA $0000,y[$B2:F2FA]
$B2:F53E 9D 96 0F    STA $0F96,x[$7E:0FD6]
$B2:F541 7A          PLY
$B2:F542 FA          PLX
$B2:F543 C8          INY
$B2:F544 C8          INY
$B2:F545 6B          RTL
}


;;; $F546: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 6 ;;;
{
$B2:F546 DA          PHX
$B2:F547 5A          PHY
$B2:F548 B9 00 00    LDA $0000,y[$B2:F370]
$B2:F54B 22 CB 90 80 JSL $8090CB[$80:90CB]
$B2:F54F 7A          PLY
$B2:F550 FA          PLX
$B2:F551 C8          INY
$B2:F552 C8          INY
$B2:F553 6B          RTL
}


;;; $F554: Unused. Instruction - go to [enemy $0FAC] ;;;
{
$B2:F554 DA          PHX
$B2:F555 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F558 A9 01 00    LDA #$0001             ;\
$B2:F55B 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$B2:F55E BD AC 0F    LDA $0FAC,x            ;\
$B2:F561 A8          TAY                    ;} Y = [enemy $0FAC]
$B2:F562 FA          PLX
$B2:F563 6B          RTL
}


;;; $F564: Instruction - spawn space pirate claw enemy projectile with throw direction [[Y]] and spawn offset ([[Y] + 2], [[Y] + 4]) ;;;
{
$B2:F564 DA          PHX
$B2:F565 5A          PHY
$B2:F566 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F569 B9 02 00    LDA $0002,y[$B2:F36A]  ;\
$B2:F56C 85 16       STA $16    [$7E:0016]  ;} $16 = [[Y] + 2] (spawn X offset)
$B2:F56E B9 04 00    LDA $0004,y[$B2:F36C]  ;\
$B2:F571 85 18       STA $18    [$7E:0018]  ;} $18 = [[Y] + 4] (spawn Y offset)
$B2:F573 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F576 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$B2:F578 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$B2:F57B 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$B2:F57D B9 00 00    LDA $0000,y[$B2:F368]  ; A = [[Y]] (throw direction, 0 = left)
$B2:F580 A0 89 A1    LDY #$A189             ;\
$B2:F583 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn space pirate claw enemy projectile
$B2:F587 7A          PLY
$B2:F588 FA          PLX
$B2:F589 C8          INY                    ;\
$B2:F58A C8          INY                    ;|
$B2:F58B C8          INY                    ;|
$B2:F58C C8          INY                    ;} Y += 6
$B2:F58D C8          INY                    ;|
$B2:F58E C8          INY                    ;/
$B2:F58F 6B          RTL
}


;;; $F590: Instruction - set enemy $0FAC - active ;;;
{
$B2:F590 DA          PHX
$B2:F591 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F594 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F597 38          SEC                    ;|
$B2:F598 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} $12 = [enemy X position] - [Samus X position]
$B2:F59B 85 12       STA $12    [$7E:0012]  ;/
$B2:F59D A9 01 00    LDA #$0001             ;\
$B2:F5A0 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$B2:F5A3 A0 2E F2    LDY #$F22E             ; Enemy $0FAC = $F22E (active - facing left) (never read)
$B2:F5A6 A5 12       LDA $12    [$7E:0012]  ;\
$B2:F5A8 10 03       BPL $03    [$F5AD]     ;} If [enemy X position] < [Samus X position]:
$B2:F5AA A0 20 F4    LDY #$F420             ; Enemy $0FAC = $F420 (active - facing right) (never read)

$B2:F5AD 98          TYA
$B2:F5AE 9D AC 0F    STA $0FAC,x[$7E:0FEC]
$B2:F5B1 FA          PLX
$B2:F5B2 6B          RTL
}


;;; $F5B3: Unused. Instruction - set enemy $0FAC - standing kick ;;;
{
$B2:F5B3 DA          PHX
$B2:F5B4 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F5B7 BD 7A 0F    LDA $0F7A,x            ;\
$B2:F5BA 38          SEC                    ;|
$B2:F5BB ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} $12 = [enemy X position] - [Samus X position]
$B2:F5BE 85 12       STA $12    [$7E:0012]  ;/
$B2:F5C0 A9 01 00    LDA #$0001             ;\
$B2:F5C3 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$B2:F5C6 A0 2E F3    LDY #$F32E             ; Enemy $0FAC = $F32E (standing kick - facing left) (never read)
$B2:F5C9 A5 12       LDA $12    [$7E:0012]  ;\
$B2:F5CB 10 03       BPL $03    [$F5D0]     ;} If [enemy X position] < [Samus X position]:
$B2:F5CD A0 1A F5    LDY #$F51A             ; Enemy $0FAC = $F51A (standing kick - facing right) (never read)

$B2:F5D0 98          TYA
$B2:F5D1 9D AC 0F    STA $0FAC,x
$B2:F5D4 FA          PLX
$B2:F5D5 6B          RTL
}


;;; $F5D6: Instruction - enemy speed = 0 ;;;
{
$B2:F5D6 A9 00 00    LDA #$0000
$B2:F5D9 9F 00 78 7E STA $7E7800,x[$7E:7840]
$B2:F5DD 6B          RTL
}
}


;;; $F5DE: Initialisation AI - enemy $F4D3/$F513/$F553/$F593/$F5D3/$F613 (ninja space pirates) ;;;
{
$B2:F5DE AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F5E1 A0 DA F2    LDY #$F2DA             ; Enemy instruction list pointer = $F2DA (initial - facing left)
$B2:F5E4 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$B2:F5E7 89 01 00    BIT #$0001             ;} If [enemy parameter 1] & 1 != 0:
$B2:F5EA F0 03       BEQ $03    [$F5EF]     ;/
$B2:F5EC A0 CC F4    LDY #$F4CC             ; Enemy instruction list pointer = $F4CC (initial - facing right)

$B2:F5EF 98          TYA
$B2:F5F0 9D 92 0F    STA $0F92,x[$7E:0F92]
$B2:F5F3 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ; Enemy $0FAC = [enemy instruction list pointer] (never read)
$B2:F5F6 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$B2:F5F9 89 01 00    BIT #$0001             ;} If [enemy parameter 1] & 1 != 0:
$B2:F5FC F0 0F       BEQ $0F    [$F60D]     ;/
$B2:F5FE BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:F601 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy left post X position = [enemy X position]
$B2:F604 18          CLC                    ;\
$B2:F605 7D B6 0F    ADC $0FB6,x[$7E:0FB6]  ;} Enemy right post X position = [enemy X position] + [enemy parameter 2]
$B2:F608 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;/
$B2:F60B 80 0D       BRA $0D    [$F61A]

$B2:F60D BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\ Else ([enemy parameter 1] & 1 = 0):
$B2:F610 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy right post X position = [enemy X position]
$B2:F613 38          SEC                    ;\
$B2:F614 FD B6 0F    SBC $0FB6,x[$7E:0FF6]  ;} Enemy left post X position = [enemy X position] - [enemy parameter 2]
$B2:F617 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;/

$B2:F61A BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$B2:F61D 38          SEC                    ;|
$B2:F61E FD B0 0F    SBC $0FB0,x[$7E:0FB0]  ;} $14 = ([enemy right post X position] - [enemy left post X position]) / 2
$B2:F621 4A          LSR A                  ;|
$B2:F622 85 14       STA $14    [$7E:0014]  ;/
$B2:F624 18          CLC                    ;\
$B2:F625 7D B0 0F    ADC $0FB0,x[$7E:0FB0]  ;} Enemy posts midpoint X position = midpoint([enemy left post X position], [enemy right post X position])
$B2:F628 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;/
$B2:F62B BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ; >_<;
$B2:F62E 64 12       STZ $12    [$7E:0012]  ;\
$B2:F630 64 16       STZ $16    [$7E:0016]  ;|
$B2:F632 A5 14       LDA $14    [$7E:0014]  ;|
$B2:F634 29 FF 00    AND #$00FF             ;|
$B2:F637 EB          XBA                    ;|
$B2:F638 85 14       STA $14    [$7E:0014]  ;|
                                            ;|
$B2:F63A A9 20 00    LDA #$0020             ;} $12 = ceil(sqrt([$14] * 2 / 0.20h)) (time to travel distance [$14] with acceleration 0.20h)
$B2:F63D 18          CLC                    ;} $16 = [$12] * ([$12] + 1) / 2 * 20h (distance travelled with acceleration 20h after [$14] frames)
$B2:F63E 65 12       ADC $12    [$7E:0012]  ;|
$B2:F640 85 12       STA $12    [$7E:0012]  ;|
$B2:F642 18          CLC                    ;|
$B2:F643 65 16       ADC $16    [$7E:0016]  ;|
$B2:F645 85 16       STA $16    [$7E:0016]  ;|
$B2:F647 C5 14       CMP $14    [$7E:0014]  ;|
$B2:F649 30 EF       BMI $EF    [$F63A]     ;/
$B2:F64B A5 12       LDA $12    [$7E:0012]  ;\
$B2:F64D 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy $0FAA = [$12] (never read)
$B2:F650 A5 16       LDA $16    [$7E:0016]  ;\
$B2:F652 29 00 FF    AND #$FF00             ;|
$B2:F655 EB          XBA                    ;} $18 = [$16] / 100h
$B2:F656 85 18       STA $18    [$7E:0018]  ;/
$B2:F658 18          CLC                    ;\
$B2:F659 7D AE 0F    ADC $0FAE,x[$7E:0FAE]  ;} Enemy right post X position = [enemy posts midpoint X position] + [$18]
$B2:F65C 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;/
$B2:F65F BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$B2:F662 38          SEC                    ;|
$B2:F663 E5 18       SBC $18    [$7E:0018]  ;} Enemy left post X position = [enemy posts midpoint X position] - [$18]
$B2:F665 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;/
$B2:F668 BC B0 0F    LDY $0FB0,x[$7E:0FB0]  ; Enemy X position = [enemy left post X position]
$B2:F66B BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$B2:F66E 89 01 00    BIT #$0001             ;} If [enemy parameter 1] & 1 = 0:
$B2:F671 D0 03       BNE $03    [$F676]     ;/
$B2:F673 BC B2 0F    LDY $0FB2,x[$7E:0FF2]  ; Enemy X position = [enemy right post X position]

$B2:F676 98          TYA
$B2:F677 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$B2:F67A A9 4B 80    LDA #$804B             ;\
$B2:F67D 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = RTS
$B2:F680 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B2:F683 9F 10 78 7E STA $7E7810,x[$7E:7810];} Enemy spawn Y position = [enemy Y position]
$B2:F687 A0 00 00    LDY #$0000             ;\
$B2:F68A A2 00 00    LDX #$0000             ;|
$B2:F68D A9 0F 00    LDA #$000F             ;|
$B2:F690 85 12       STA $12    [$7E:0012]  ;|
                                            ;|
$B2:F692 B9 27 87    LDA $8727,y[$B2:8727]  ;|
$B2:F695 9F E0 C3 7E STA $7EC3E0,x[$7E:C3E0];} Target sprite palette 7 = [$8727..46] (gold space pirate)
$B2:F699 C8          INY                    ;|
$B2:F69A C8          INY                    ;|
$B2:F69B E8          INX                    ;|
$B2:F69C E8          INX                    ;|
$B2:F69D C6 12       DEC $12    [$7E:0012]  ;|
$B2:F69F 10 F1       BPL $F1    [$F692]     ;/
$B2:F6A1 6B          RTL
}


;;; $F6A2: Main AI - enemy $F4D3/$F513/$F553/$F593/$F5D3/$F613 (ninja space pirates) ;;;
{
$B2:F6A2 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F6A5 FC A8 0F    JSR ($0FA8,x)[$B2:804B]; Execute [enemy function]
$B2:F6A8 6B          RTL
}


;;; $F6A9: Ninja space pirate function - initial ;;;
{
$B2:F6A9 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F6AC BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:F6AF 38          SEC                    ;|
$B2:F6B0 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$B2:F6B3 10 04       BPL $04    [$F6B9]     ;|
$B2:F6B5 49 FF FF    EOR #$FFFF             ;|
$B2:F6B8 1A          INC A                  ;} If |[enemy X position] - [Samus X position]| >= 80h: go to BRANCH_TOO_FAR
                                            ;|
$B2:F6B9 38          SEC                    ;|
$B2:F6BA E9 80 00    SBC #$0080             ;|
$B2:F6BD 10 21       BPL $21    [$F6E0]     ;/
$B2:F6BF BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:F6C2 38          SEC                    ;|
$B2:F6C3 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} $12 = [enemy X position] - [Samus X position]
$B2:F6C6 85 12       STA $12    [$7E:0012]  ;/
$B2:F6C8 A0 2E F2    LDY #$F22E             ; Enemy instruction list pointer = $F22E (active - facing left)
$B2:F6CB A5 12       LDA $12    [$7E:0012]  ;\
$B2:F6CD 10 03       BPL $03    [$F6D2]     ;} If [enemy X position] < [Samus X position]:
$B2:F6CF A0 20 F4    LDY #$F420             ; Enemy instruction list pointer = $F420 (active - facing right)

$B2:F6D2 98          TYA
$B2:F6D3 9D 92 0F    STA $0F92,x[$7E:0F92]
$B2:F6D6 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ; Enemy $0FAC = [enemy instruction list pointer] (never read)
$B2:F6D9 A9 01 00    LDA #$0001             ;\
$B2:F6DC 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$B2:F6DF 60          RTS                    ; Return

; BRANCH_TOO_FAR
$B2:F6E0 20 2E F7    JSR $F72E  [$B2:F72E]  ; Ninja space pirate flinch trigger
$B2:F6E3 60          RTS
}


;;; $F6E4: Ninja space pirate function - active ;;;
{
$B2:F6E4 20 2E F7    JSR $F72E  [$B2:F72E]  ; Ninja space pirate flinch trigger
$B2:F6E7 D0 0D       BNE $0D    [$F6F6]     ; If flinch triggered: return
$B2:F6E9 20 C6 F7    JSR $F7C6  [$B2:F7C6]  ; Ninja space pirate standing kick trigger
$B2:F6EC D0 08       BNE $08    [$F6F6]     ; If kick triggered: return
$B2:F6EE 20 8D F7    JSR $F78D  [$B2:F78D]  ; Ninja space pirate spin jump trigger
$B2:F6F1 D0 03       BNE $03    [$F6F6]     ; If spin jump triggered: return
$B2:F6F3 20 F7 F6    JSR $F6F7  [$B2:F6F7]  ; Ninja space pirate projectile claw attack trigger

$B2:F6F6 60          RTS
}


;;; $F6F7: Ninja space pirate projectile claw attack trigger ;;;
{
$B2:F6F7 BD A4 0F    LDA $0FA4,x[$7E:0FE4]  ;\
$B2:F6FA 29 3F 00    AND #$003F             ;} If [enemy frame counter] % 40h != 0: return
$B2:F6FD D0 2E       BNE $2E    [$F72D]     ;/
$B2:F6FF BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F702 DD B0 0F    CMP $0FB0,x[$7E:0FF0]  ;} If [enemy X position] != [enemy left post X position]:
$B2:F705 F0 11       BEQ $11    [$F718]     ;/
$B2:F707 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F70A 38          SEC                    ;|
$B2:F70B ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} If [enemy X position] >= [Samus X position]: return
$B2:F70E 10 1D       BPL $1D    [$F72D]     ;/
$B2:F710 A9 4A F3    LDA #$F34A             ;\
$B2:F713 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $F34A (projectile claw attack right)
$B2:F716 80 0F       BRA $0F    [$F727]

$B2:F718 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\ Else ([enemy X position] = [enemy left post X position]):
$B2:F71B 38          SEC                    ;|
$B2:F71C ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} If [enemy X position] < [Samus X position]: return
$B2:F71F 30 0C       BMI $0C    [$F72D]     ;/
$B2:F721 A9 5C F1    LDA #$F15C             ;\
$B2:F724 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $F15C (projectile claw attack left)

$B2:F727 A9 01 00    LDA #$0001             ;\
$B2:F72A 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1

$B2:F72D 60          RTS
}


;;; $F72E: Ninja space pirate flinch trigger ;;;
{
;; Returns:
;;     A: 1 if flinch triggered, 0 otherwise
$B2:F72E DA          PHX
$B2:F72F AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F732 A0 08 00    LDY #$0008             ; Y = 8 (projectile index)

; LOOP
$B2:F735 B9 18 0C    LDA $0C18,y[$7E:0C20]  ;\
$B2:F738 D0 06       BNE $06    [$F740]     ;} If [projectile type] = 0:
$B2:F73A 88          DEY                    ;\
$B2:F73B 88          DEY                    ;} Y -= 2
$B2:F73C 10 F7       BPL $F7    [$F735]     ; If [Y] >= 0: go to LOOP
$B2:F73E 80 48       BRA $48    [$F788]     ; Return A = 0

$B2:F740 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$B2:F743 38          SEC                    ;|
$B2:F744 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$B2:F747 10 04       BPL $04    [$F74D]     ;|
$B2:F749 49 FF FF    EOR #$FFFF             ;|
$B2:F74C 1A          INC A                  ;} If |[projectile X position] - [enemy X position]| >= 20h: return A = 0
                                            ;|
$B2:F74D 38          SEC                    ;|
$B2:F74E E9 20 00    SBC #$0020             ;|
$B2:F751 10 35       BPL $35    [$F788]     ;/
$B2:F753 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$B2:F756 38          SEC                    ;|
$B2:F757 FD 7E 0F    SBC $0F7E,x[$7E:0FBE]  ;|
$B2:F75A 10 04       BPL $04    [$F760]     ;|
$B2:F75C 49 FF FF    EOR #$FFFF             ;|
$B2:F75F 1A          INC A                  ;} If |[projectile Y position] - [enemy Y position]| >= 20h: return A = 0
                                            ;|
$B2:F760 38          SEC                    ;|
$B2:F761 E9 20 00    SBC #$0020             ;|
$B2:F764 10 22       BPL $22    [$F788]     ;/
$B2:F766 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F769 38          SEC                    ;|
$B2:F76A ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} $12 = [enemy X position] - [Samus X position]
$B2:F76D 85 12       STA $12    [$7E:0012]  ;/
$B2:F76F A0 70 F2    LDY #$F270             ; Enemy instruction list pointer = $F270 (flinch - facing left)
$B2:F772 A5 12       LDA $12    [$7E:0012]  ;\
$B2:F774 10 03       BPL $03    [$F779]     ;} If [enemy X position] < [Samus X position]:
$B2:F776 A0 62 F4    LDY #$F462             ; Enemy instruction list pointer = $F462 (flinch - facing right)

$B2:F779 98          TYA
$B2:F77A 9D 92 0F    STA $0F92,x[$7E:0FD2]
$B2:F77D A9 01 00    LDA #$0001             ;\
$B2:F780 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:F783 FA          PLX
$B2:F784 A9 01 00    LDA #$0001             ;\
$B2:F787 60          RTS                    ;} Return A = 1

$B2:F788 FA          PLX
$B2:F789 A9 00 00    LDA #$0000
$B2:F78C 60          RTS
}


;;; $F78D: Ninja space pirate spin jump trigger ;;;
{
;; Returns:
;;     A: 1 if spin jump triggered, 0 otherwise
$B2:F78D DA          PHX
$B2:F78E AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F791 BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;\
$B2:F794 38          SEC                    ;|
$B2:F795 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$B2:F798 10 04       BPL $04    [$F79E]     ;|
$B2:F79A 49 FF FF    EOR #$FFFF             ;|
$B2:F79D 1A          INC A                  ;} If |[enemy posts midpoint X position] - [Samus X position]| >= 20h: return A = 0
                                            ;|
$B2:F79E 38          SEC                    ;|
$B2:F79F E9 20 00    SBC #$0020             ;|
$B2:F7A2 10 1D       BPL $1D    [$F7C1]     ;/
$B2:F7A4 A0 C4 F1    LDY #$F1C4             ; Enemy instruction list pointer = $F1C4 (spin jump left)
$B2:F7A7 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F7AA DD B0 0F    CMP $0FB0,x[$7E:0FF0]  ;} If [enemy X position] = [enemy left post X position]:
$B2:F7AD D0 03       BNE $03    [$F7B2]     ;/
$B2:F7AF A0 B2 F3    LDY #$F3B2             ; Enemy instruction list pointer = $F3B2 (spin jump right)

$B2:F7B2 98          TYA
$B2:F7B3 9D 92 0F    STA $0F92,x[$7E:0FD2]
$B2:F7B6 A9 01 00    LDA #$0001             ;\
$B2:F7B9 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:F7BC FA          PLX
$B2:F7BD A9 01 00    LDA #$0001             ;\
$B2:F7C0 60          RTS                    ;} Return A = 1

$B2:F7C1 FA          PLX
$B2:F7C2 A9 00 00    LDA #$0000
$B2:F7C5 60          RTS
}


;;; $F7C6: Ninja space pirate standing kick trigger ;;;
{
;; Returns:
;;     A: 1 if kick triggered, 0 otherwise
$B2:F7C6 DA          PHX
$B2:F7C7 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F7CA AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$B2:F7CD 38          SEC                    ;|
$B2:F7CE FD 7A 0F    SBC $0F7A,x[$7E:0FBA]  ;|
$B2:F7D1 10 04       BPL $04    [$F7D7]     ;|
$B2:F7D3 49 FF FF    EOR #$FFFF             ;|
$B2:F7D6 1A          INC A                  ;} If |[Samus X position] - [enemy X position]| >= 28h: return A = 0
                                            ;|
$B2:F7D7 38          SEC                    ;|
$B2:F7D8 E9 28 00    SBC #$0028             ;|
$B2:F7DB 10 35       BPL $35    [$F812]     ;/
$B2:F7DD AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$B2:F7E0 38          SEC                    ;|
$B2:F7E1 FD 7E 0F    SBC $0F7E,x[$7E:0FBE]  ;|
$B2:F7E4 10 04       BPL $04    [$F7EA]     ;|
$B2:F7E6 49 FF FF    EOR #$FFFF             ;|
$B2:F7E9 1A          INC A                  ;} If |[Samus Y position] - [enemy Y position]| >= 28h: return A = 0
                                            ;|
$B2:F7EA 38          SEC                    ;|
$B2:F7EB E9 28 00    SBC #$0028             ;|
$B2:F7EE 10 22       BPL $22    [$F812]     ;/
$B2:F7F0 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F7F3 38          SEC                    ;|
$B2:F7F4 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} $12 = [enemy X position] - [Samus X position]
$B2:F7F7 85 12       STA $12    [$7E:0012]  ;/
$B2:F7F9 A0 2E F3    LDY #$F32E             ; Enemy instruction list pointer = $F32E (standing kick - facing left)
$B2:F7FC A5 12       LDA $12    [$7E:0012]  ;\
$B2:F7FE 10 03       BPL $03    [$F803]     ;} If [enemy X position] < [Samus X position]:
$B2:F800 A0 1A F5    LDY #$F51A             ; Enemy instruction list pointer = $F51A (standing kick - facing right)

$B2:F803 98          TYA
$B2:F804 9D 92 0F    STA $0F92,x[$7E:0FD2]
$B2:F807 A9 01 00    LDA #$0001             ;\
$B2:F80A 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:F80D FA          PLX
$B2:F80E A9 01 00    LDA #$0001             ;\
$B2:F811 60          RTS                    ;} Return A = 1

$B2:F812 FA          PLX
$B2:F813 A9 00 00    LDA #$0000
$B2:F816 60          RTS
}


;;; $F817: Ninja space pirate function - spin jump left - rising ;;;
{
$B2:F817 BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:F81B 29 00 FF    AND #$FF00             ;|
$B2:F81E EB          XBA                    ;|
$B2:F81F 85 12       STA $12    [$7E:0012]  ;|
$B2:F821 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;} Enemy X position -= [enemy speed] / 100h
$B2:F824 38          SEC                    ;|
$B2:F825 E5 12       SBC $12    [$7E:0012]  ;|
$B2:F827 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$B2:F82A DE 7E 0F    DEC $0F7E,x[$7E:0FBE]  ;\
$B2:F82D DE 7E 0F    DEC $0F7E,x[$7E:0FBE]  ;} Enemy Y position -= 2
$B2:F830 BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:F834 18          CLC                    ;|
$B2:F835 69 20 00    ADC #$0020             ;} Enemy speed += 20h
$B2:F838 9F 00 78 7E STA $7E7800,x[$7E:7840];/
$B2:F83C BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F83F DD AE 0F    CMP $0FAE,x[$7E:0FEE]  ;} If [enemy X position] >= [enemy posts midpoint X position]:
$B2:F842 30 01       BMI $01    [$F845]     ;/
$B2:F844 60          RTS                    ; Return

$B2:F845 A9 4C F8    LDA #$F84C             ;\
$B2:F848 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $F84C (spin jump left - falling)
$B2:F84B 60          RTS
}


;;; $F84C: Ninja space pirate function - spin jump left - falling ;;;
{
$B2:F84C BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:F850 29 00 FF    AND #$FF00             ;|
$B2:F853 EB          XBA                    ;|
$B2:F854 85 12       STA $12    [$7E:0012]  ;|
$B2:F856 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;} Enemy X position -= [enemy speed] / 100h
$B2:F859 38          SEC                    ;|
$B2:F85A E5 12       SBC $12    [$7E:0012]  ;|
$B2:F85C 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$B2:F85F FE 7E 0F    INC $0F7E,x[$7E:0FBE]  ;\
$B2:F862 FE 7E 0F    INC $0F7E,x[$7E:0FBE]  ;} Enemy Y position += 2
$B2:F865 BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:F869 38          SEC                    ;|
$B2:F86A E9 20 00    SBC #$0020             ;} Enemy speed -= 20h
$B2:F86D 9F 00 78 7E STA $7E7800,x[$7E:7840];/
$B2:F871 F0 01       BEQ $01    [$F874]     ; If [enemy speed] != 0:
$B2:F873 60          RTS                    ; Return

$B2:F874 A9 4B 80    LDA #$804B             ;\
$B2:F877 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = RTS
$B2:F87A A9 F8 F2    LDA #$F2F8             ;\
$B2:F87D 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $F2F8 (land - facing left)
$B2:F880 A9 01 00    LDA #$0001             ;\
$B2:F883 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:F886 BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;\
$B2:F889 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [enemy left post X position]
$B2:F88C 20 11 FB    JSR $FB11  [$B2:FB11]  ; Spawn ninja space pirate landing dust cloud
$B2:F88F 60          RTS
}


;;; $F890: Ninja space pirate function - spin jump right - rising ;;;
{
$B2:F890 BF 00 78 7E LDA $7E7800,x[$7E:7800];\
$B2:F894 29 00 FF    AND #$FF00             ;|
$B2:F897 EB          XBA                    ;|
$B2:F898 85 12       STA $12    [$7E:0012]  ;|
$B2:F89A BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;} Enemy X position += [enemy speed] / 100h
$B2:F89D 18          CLC                    ;|
$B2:F89E 65 12       ADC $12    [$7E:0012]  ;|
$B2:F8A0 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$B2:F8A3 DE 7E 0F    DEC $0F7E,x[$7E:0F7E]  ;\
$B2:F8A6 DE 7E 0F    DEC $0F7E,x[$7E:0F7E]  ;} Enemy Y position -= 2
$B2:F8A9 BF 00 78 7E LDA $7E7800,x[$7E:7800];\
$B2:F8AD 18          CLC                    ;|
$B2:F8AE 69 20 00    ADC #$0020             ;} Enemy speed += 20h
$B2:F8B1 9F 00 78 7E STA $7E7800,x[$7E:7800];/
$B2:F8B5 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:F8B8 DD AE 0F    CMP $0FAE,x[$7E:0FAE]  ;} If [enemy X position] < [enemy posts midpoint X position]:
$B2:F8BB 10 01       BPL $01    [$F8BE]     ;/
$B2:F8BD 60          RTS                    ; Return
                                            
$B2:F8BE A9 C5 F8    LDA #$F8C5             ;\
$B2:F8C1 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F84C (spin jump right - falling)
$B2:F8C4 60          RTS
}


;;; $F8C5: Ninja space pirate function - spin jump right - falling ;;;
{
$B2:F8C5 BF 00 78 7E LDA $7E7800,x[$7E:7800];\
$B2:F8C9 29 00 FF    AND #$FF00             ;|
$B2:F8CC EB          XBA                    ;|
$B2:F8CD 85 12       STA $12    [$7E:0012]  ;|
$B2:F8CF BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;} Enemy X position += [enemy speed] / 100h
$B2:F8D2 18          CLC                    ;|
$B2:F8D3 65 12       ADC $12    [$7E:0012]  ;|
$B2:F8D5 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$B2:F8D8 FE 7E 0F    INC $0F7E,x[$7E:0F7E]  ;\
$B2:F8DB FE 7E 0F    INC $0F7E,x[$7E:0F7E]  ;} Enemy Y position += 2
$B2:F8DE BF 00 78 7E LDA $7E7800,x[$7E:7800];\
$B2:F8E2 38          SEC                    ;|
$B2:F8E3 E9 20 00    SBC #$0020             ;} Enemy speed -= 20h
$B2:F8E6 9F 00 78 7E STA $7E7800,x[$7E:7800];/
$B2:F8EA F0 01       BEQ $01    [$F8ED]     ; If [enemy speed] != 0:
$B2:F8EC 60          RTS                    ; Return
                                            
$B2:F8ED A9 4B 80    LDA #$804B             ;\
$B2:F8F0 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = RTS
$B2:F8F3 A9 EA F4    LDA #$F4EA             ;\
$B2:F8F6 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $F4EA (land - facing right)
$B2:F8F9 A9 01 00    LDA #$0001             ;\
$B2:F8FC 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction list timer = 1
$B2:F8FF BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$B2:F902 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy X position = [enemy right post X position]
$B2:F905 20 11 FB    JSR $FB11  [$B2:FB11]  ; Spawn ninja space pirate landing dust cloud
$B2:F908 60          RTS
}


;;; $F909: Ninja space pirate function - ready to divekick ;;;
{
$B2:F909 20 2E F7    JSR $F72E  [$B2:F72E]  ; Ninja space pirate flinch trigger
$B2:F90C D0 08       BNE $08    [$F916]     ; If flinch triggered: return
$B2:F90E 20 C6 F7    JSR $F7C6  [$B2:F7C6]  ; Ninja space pirate standing kick trigger
$B2:F911 D0 03       BNE $03    [$F916]     ; If kick triggered: return
$B2:F913 20 17 F9    JSR $F917  [$B2:F917]  ; Ninja space pirate divekick trigger

$B2:F916 60          RTS
}


;;; $F917: Ninja space pirate divekick trigger ;;;
{
$B2:F917 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:F91A BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;\
$B2:F91D 38          SEC                    ;|
$B2:F91E ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$B2:F921 10 04       BPL $04    [$F927]     ;|
$B2:F923 49 FF FF    EOR #$FFFF             ;|
$B2:F926 1A          INC A                  ;} If |[enemy posts midpoint X position] - [Samus X position]| >= 20h: return
                                            ;|
$B2:F927 38          SEC                    ;|
$B2:F928 E9 20 00    SBC #$0020             ;|
$B2:F92B 10 2B       BPL $2B    [$F958]     ;/

; LOOP
$B2:F92D 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$B2:F931 29 03 00    AND #$0003             ;\
$B2:F934 F0 F7       BEQ $F7    [$F92D]     ;} If [random number] & 3 = 0: go to LOOP
$B2:F936 85 12       STA $12    [$7E:0012]
$B2:F938 A0 00 00    LDY #$0000             ; Enemy instruction list pointer = $F27C (divekick left - jump)
$B2:F93B BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F93E DD B0 0F    CMP $0FB0,x[$7E:0FF0]  ;} If [enemy X position] = [enemy left post X position]:
$B2:F941 D0 03       BNE $03    [$F946]     ;/
$B2:F943 A0 04 00    LDY #$0004             ; Enemy instruction list pointer = $F46E (divekick right - jump)

$B2:F946 98          TYA
$B2:F947 18          CLC
$B2:F948 65 12       ADC $12    [$7E:0012]
$B2:F94A 0A          ASL A
$B2:F94B A8          TAY
$B2:F94C B9 59 F9    LDA $F959,y[$B2:F963]
$B2:F94F 9D 92 0F    STA $0F92,x[$7E:0FD2]
$B2:F952 A9 01 00    LDA #$0001             ;\
$B2:F955 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1

$B2:F958 60          RTS

$B2:F959             dw 0000, F27C, F27C, F27C,
                        0000, F46E, F46E, F46E
}


;;; $F969: Instruction - set left divekick jump initial Y speed ;;;
{
$B2:F969 DA          PHX
$B2:F96A 5A          PHY
$B2:F96B A9 00 06    LDA #$0600             ;\
$B2:F96E 9F 00 78 7E STA $7E7800,x[$7E:7840];} Enemy speed = 600h
$B2:F972 BD B2 0F    LDA $0FB2,x[$7E:0FF2]  ;\
$B2:F975 38          SEC                    ;|
$B2:F976 FD AE 0F    SBC $0FAE,x[$7E:0FEE]  ;|
$B2:F979 4A          LSR A                  ;} Enemy $7E:7806 = midpoint([enemy posts midpoint X position], [enemy right post X position]) (never read)
$B2:F97A 18          CLC                    ;|
$B2:F97B 7D AE 0F    ADC $0FAE,x[$7E:0FEE]  ;|
$B2:F97E 9F 06 78 7E STA $7E7806,x[$7E:7846];/
$B2:F982 7A          PLY
$B2:F983 FA          PLX
$B2:F984 6B          RTL
}


;;; $F985: Ninja space pirate function - divekick left - jump ;;;
{
$B2:F985 BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:F989 29 00 FF    AND #$FF00             ;|
$B2:F98C EB          XBA                    ;|
$B2:F98D 85 12       STA $12    [$7E:0012]  ;|
$B2:F98F BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;} Enemy Y position -= [enemy speed] / 100h
$B2:F992 38          SEC                    ;|
$B2:F993 E5 12       SBC $12    [$7E:0012]  ;|
$B2:F995 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$B2:F998 BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:F99C 38          SEC                    ;|
$B2:F99D E9 40 00    SBC #$0040             ;} Enemy speed -= 40h
$B2:F9A0 9F 00 78 7E STA $7E7800,x[$7E:7840];/
$B2:F9A4 30 01       BMI $01    [$F9A7]     ; If [enemy speed] >= 0:
$B2:F9A6 60          RTS                    ; Return

$B2:F9A7 A9 C1 F9    LDA #$F9C1             ;\
$B2:F9AA 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $F9C1 (divekick left - divekick)
$B2:F9AD A9 A0 F2    LDA #$F2A0             ;\
$B2:F9B0 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $F2A0 (divekick left - divekick)
$B2:F9B3 A9 01 00    LDA #$0001             ;\
$B2:F9B6 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:F9B9 A9 00 06    LDA #$0600             ;\
$B2:F9BC 9F 00 78 7E STA $7E7800,x[$7E:7840];} Enemy speed = 600h
$B2:F9C0 60          RTS
}


;;; $F9C1: Ninja space pirate function - divekick left - divekick ;;;
{
$B2:F9C1 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:F9C4 38          SEC                    ;|
$B2:F9C5 E9 05 00    SBC #$0005             ;} Enemy X position -= 5
$B2:F9C8 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$B2:F9CB BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:F9CF 29 00 FF    AND #$FF00             ;|
$B2:F9D2 EB          XBA                    ;|
$B2:F9D3 85 14       STA $14    [$7E:0014]  ;|
$B2:F9D5 BF 00 78 7E LDA $7E7800,x[$7E:7840];} Move enemy down by [enemy Y velocity] / 100h
$B2:F9D9 29 FF 00    AND #$00FF             ;|
$B2:F9DC 85 12       STA $12    [$7E:0012]  ;|
$B2:F9DE 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$B2:F9E2 B0 14       BCS $14    [$F9F8]     ; If not collided with block:
$B2:F9E4 BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:F9E8 38          SEC                    ;|
$B2:F9E9 E9 40 00    SBC #$0040             ;} Enemy speed -= 40h
$B2:F9EC 9F 00 78 7E STA $7E7800,x[$7E:7840];/
$B2:F9F0 30 06       BMI $06    [$F9F8]     ;\
$B2:F9F2 89 00 FF    BIT #$FF00             ;} If [enemy speed] >= 100h:
$B2:F9F5 F0 01       BEQ $01    [$F9F8]     ;/
$B2:F9F7 60          RTS                    ; Return

$B2:F9F8 A9 15 FA    LDA #$FA15             ;\
$B2:F9FB 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $FA15 (divekick left - walk to left post)
$B2:F9FE A9 B2 F2    LDA #$F2B2             ;\
$B2:FA01 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $F2B2 (divekick left - walk to left post)
$B2:FA04 A9 01 00    LDA #$0001             ;\
$B2:FA07 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:FA0A BF 10 78 7E LDA $7E7810,x[$7E:7850];\
$B2:FA0E 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = [enemy spawn Y position]
$B2:FA11 20 11 FB    JSR $FB11  [$B2:FB11]  ; Spawn ninja space pirate landing dust cloud
$B2:FA14 60          RTS
}


;;; $FA15: Ninja space pirate function - divekick left - walk to left post ;;;
{
$B2:FA15 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:FA18 18          CLC                    ;|
$B2:FA19 69 FE FF    ADC #$FFFE             ;} Enemy X position -= 2
$B2:FA1C 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$B2:FA1F DD B0 0F    CMP $0FB0,x[$7E:0FF0]  ;\
$B2:FA22 10 18       BPL $18    [$FA3C]     ;} If [enemy X position] >= [enemy left post X position]: return
$B2:FA24 BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;\
$B2:FA27 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [enemy left post X position]
$B2:FA2A A9 F8 F2    LDA #$F2F8             ;\
$B2:FA2D 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $F2F8 (land - facing left)
$B2:FA30 A9 01 00    LDA #$0001             ;\
$B2:FA33 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:FA36 A9 4B 80    LDA #$804B             ;\
$B2:FA39 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = RTS

$B2:FA3C 60          RTS
}


;;; $FA3D: Instruction - set right divekick jump initial Y speed ;;;
{
$B2:FA3D DA          PHX
$B2:FA3E 5A          PHY
$B2:FA3F A9 00 06    LDA #$0600             ;\
$B2:FA42 9F 00 78 7E STA $7E7800,x[$7E:7840];} Enemy speed = 600h
$B2:FA46 BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;\
$B2:FA49 38          SEC                    ;|
$B2:FA4A FD B0 0F    SBC $0FB0,x[$7E:0FF0]  ;|
$B2:FA4D 4A          LSR A                  ;} Enemy $7E:7806 = midpoint([enemy posts midpoint X position], [enemy left post X position]) (never read)
$B2:FA4E 18          CLC                    ;|
$B2:FA4F 7D B0 0F    ADC $0FB0,x[$7E:0FF0]  ;|
$B2:FA52 9F 06 78 7E STA $7E7806,x[$7E:7846];/
$B2:FA56 7A          PLY
$B2:FA57 FA          PLX
$B2:FA58 6B          RTL
}


;;; $FA59: Ninja space pirate function - divekick right - jump ;;;
{
$B2:FA59 BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:FA5D 29 00 FF    AND #$FF00             ;|
$B2:FA60 EB          XBA                    ;|
$B2:FA61 85 12       STA $12    [$7E:0012]  ;|
$B2:FA63 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;} Enemy Y position -= [enemy speed] / 100h
$B2:FA66 38          SEC                    ;|
$B2:FA67 E5 12       SBC $12    [$7E:0012]  ;|
$B2:FA69 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$B2:FA6C BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:FA70 38          SEC                    ;|
$B2:FA71 E9 40 00    SBC #$0040             ;} Enemy speed -= 40h
$B2:FA74 9F 00 78 7E STA $7E7800,x[$7E:7840];/
$B2:FA78 30 01       BMI $01    [$FA7B]     ; If [enemy speed] >= 0:
$B2:FA7A 60          RTS                    ; Return
                                            
$B2:FA7B A9 95 FA    LDA #$FA95             ;\
$B2:FA7E 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $FA95 (divekick right - divekick)
$B2:FA81 A9 92 F4    LDA #$F492             ;\
$B2:FA84 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $F492 (divekick right - divekick)
$B2:FA87 A9 01 00    LDA #$0001             ;\
$B2:FA8A 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:FA8D A9 00 06    LDA #$0600             ;\
$B2:FA90 9F 00 78 7E STA $7E7800,x[$7E:7840];} Enemy speed = 600h
$B2:FA94 60          RTS
}


;;; $FA95: Ninja space pirate function - divekick right - divekick ;;;
{
$B2:FA95 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:FA98 18          CLC                    ;|
$B2:FA99 69 05 00    ADC #$0005             ;} Enemy X position += 5
$B2:FA9C 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$B2:FA9F BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:FAA3 29 00 FF    AND #$FF00             ;|
$B2:FAA6 EB          XBA                    ;|
$B2:FAA7 85 14       STA $14    [$7E:0014]  ;|
$B2:FAA9 BF 00 78 7E LDA $7E7800,x[$7E:7840];} Move enemy down by [enemy Y velocity] / 100h
$B2:FAAD 29 FF 00    AND #$00FF             ;|
$B2:FAB0 85 12       STA $12    [$7E:0012]  ;|
$B2:FAB2 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$B2:FAB6 B0 14       BCS $14    [$FACC]     ; If not collided with block:
$B2:FAB8 BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$B2:FABC 38          SEC                    ;|
$B2:FABD E9 40 00    SBC #$0040             ;} Enemy speed -= 40h
$B2:FAC0 9F 00 78 7E STA $7E7800,x[$7E:7840];/
$B2:FAC4 30 06       BMI $06    [$FACC]     ;\
$B2:FAC6 89 00 FF    BIT #$FF00             ;} If [enemy speed] >= 100h:
$B2:FAC9 F0 01       BEQ $01    [$FACC]     ;/
$B2:FACB 60          RTS                    ; Return
                                            
$B2:FACC A9 E9 FA    LDA #$FAE9             ;\
$B2:FACF 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $FAE9 (divekick right - walk to right post)
$B2:FAD2 A9 A4 F4    LDA #$F4A4             ;\
$B2:FAD5 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $F4A4 (divekick right - walk to right post)
$B2:FAD8 A9 01 00    LDA #$0001             ;\
$B2:FADB 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:FADE BF 10 78 7E LDA $7E7810,x[$7E:7850];\
$B2:FAE2 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = [enemy spawn Y position]
$B2:FAE5 20 11 FB    JSR $FB11  [$B2:FB11]  ; Spawn ninja space pirate landing dust cloud
$B2:FAE8 60          RTS
}


;;; $FAE9: Ninja space pirate function - divekick right - walk to right post ;;;
{
$B2:FAE9 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:FAEC 18          CLC                    ;|
$B2:FAED 69 02 00    ADC #$0002             ;} Enemy X position += 2
$B2:FAF0 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$B2:FAF3 DD B2 0F    CMP $0FB2,x[$7E:0FF2]  ;\
$B2:FAF6 30 18       BMI $18    [$FB10]     ;} If [enemy X position] >= [enemy right post X position]: return
$B2:FAF8 BD B2 0F    LDA $0FB2,x[$7E:0FF2]  ;\
$B2:FAFB 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [enemy right post X position]
$B2:FAFE A9 EA F4    LDA #$F4EA             ;\
$B2:FB01 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $F4EA (land - facing right)
$B2:FB04 A9 01 00    LDA #$0001             ;\
$B2:FB07 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction list timer = 1
$B2:FB0A A9 4B 80    LDA #$804B             ;\
$B2:FB0D 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = RTS

$B2:FB10 60          RTS
}


;;; $FB11: Spawn ninja space pirate landing dust cloud ;;;
{
$B2:FB11 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:FB14 38          SEC                    ;|
$B2:FB15 E9 08 00    SBC #$0008             ;| $12 = [enemy X position] - 8
$B2:FB18 85 12       STA $12    [$7E:0012]  ;/
$B2:FB1A BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$B2:FB1D 18          CLC                    ;|
$B2:FB1E 69 1C 00    ADC #$001C             ;} $14 = [enemy Y position] + 1Ch
$B2:FB21 85 14       STA $14    [$7E:0014]  ;/
$B2:FB23 A9 0A 00    LDA #$000A             ;\
$B2:FB26 85 16       STA $16    [$7E:0016]  ;|
$B2:FB28 64 18       STZ $18    [$7E:0018]  ;} Create sprite object Ah (ninja space pirate landing dust cloud) at position ([$12], [$14])
$B2:FB2A 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$B2:FB2E BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$B2:FB31 18          CLC                    ;|
$B2:FB32 69 08 00    ADC #$0008             ;| $12 = [enemy X position] + 8
$B2:FB35 85 12       STA $12    [$7E:0012]  ;/
$B2:FB37 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$B2:FB3A 18          CLC                    ;|
$B2:FB3B 69 1C 00    ADC #$001C             ;} $14 = [enemy Y position] + 1Ch
$B2:FB3E 85 14       STA $14    [$7E:0014]  ;/
$B2:FB40 A9 0A 00    LDA #$000A             ;\
$B2:FB43 85 16       STA $16    [$7E:0016]  ;|
$B2:FB45 64 18       STZ $18    [$7E:0018]  ;} Create sprite object Ah (ninja space pirate landing dust cloud) at position ([$12], [$14])
$B2:FB47 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$B2:FB4B 60          RTS
}
}


;;; $FB4C..FEA9: Walking space pirates ;;;
{
;;; $FB4C..FC67: Instruction lists ;;;
{
;;; $FB4C: Instruction list - flinch - facing left ;;;
{
$B2:FB4C             dx FCB8,804B,  ; Enemy function = RTS
                        0010,8F92,
                        80ED,FB64   ; Go to walking left
}


;;; $FB58: Instruction list - flinch - facing right ;;;
{
$B2:FB58             dx FCB8,804B,  ; Enemy function = RTS
                        0010,8FA6,
                        80ED,FBE6   ; Go to walking right
}


;;; $FB64: Instruction list - walking left ;;;
{
$B2:FB64             dx FCB8,FD44   ; Enemy function = $FD44 (walking left)
$B2:FB68             dx 000A,89C4,
                        000A,89D6,
                        000A,89E8,
                        000A,89FA,
                        000A,8A0C,
                        000A,8A1E,
                        000A,8A30,
                        000A,8A42,
                        80ED,FB68   ; Go to $FB68
}


;;; $FB8C: Instruction list - fire lasers left ;;;
{
$B2:FB8C             dx FCB8,FE4A,  ; Enemy function = RTS
                        0018,8C28,
                        0008,8C3A,
                        0008,8C4C,
                        0008,8C5E,
                        FC68,0008,  ; Fire laser left with Y offset 8
                        0008,8C70,
                        FC68,0002,  ; Fire laser left with Y offset 2
                        0018,8C82,
                        FC68,FFF8,  ; Fire laser left with Y offset -8
                        0008,8C70,
                        0008,8C5E,
                        0008,8C4C,
                        0008,8C3A,
                        FCC8        ; Choose a movement
}


;;; $FBC6: Instruction list - look around - facing left ;;;
{
$B2:FBC6             dx FCB8,FE4A,  ; Enemy function = RTS
                        0020,8D00,
                        000A,8D1A,
                        0020,8D2C,
                        000A,8D1A,
                        0020,8D00,
                        0008,8D8C,
                        80ED,FBE6   ; Go to walking right
}


;;; $FBE6: Instruction list - walking right ;;;
{
$B2:FBE6             dx FCB8,FDCE   ; Enemy function = $FDCE (walking right)
$B2:FBEA             dx 000A,8AF6,
                        000A,8B08,
                        000A,8B1A,
                        000A,8B2C,
                        000A,8B3E,
                        000A,8B50,
                        000A,8B62,
                        000A,8B74,
                        80ED,FBEA   ; Go to $FBEA
}


;;; $FC0E: Instruction list - fire lasers right ;;;
{
$B2:FC0E             dx FCB8,FE4A,  ; Enemy function = RTS
                        0018,8C94,
                        0008,8CA6,
                        0008,8CB8,
                        0008,8CCA,
                        FC90,0008,  ; Fire laser right with Y offset 8
                        0008,8CDC,
                        FC90,0002,  ; Fire laser right with Y offset 2
                        0018,8CEE,
                        FC90,FFF8,  ; Fire laser right with Y offset -8
                        0008,8CDC,
                        0008,8CCA,
                        0008,8CB8,
                        0008,8CA6,
                        FCC8        ; Choose a movement
}


;;; $FC48: Instruction list - look around - facing right ;;;
{
$B2:FC48             dx FCB8,FE4A,  ; Enemy function = RTS
                        0020,8D46,
                        000A,8D60,
                        0020,8D72,
                        000A,8D60,
                        0020,8D46,
                        0008,8D8C,
                        80ED,FB64   ; Go to walking left
}
}


;;; $FC68..FD01: Instructions ;;;
{
;;; $FC68: Instruction - fire laser left with Y offset [[Y]] ;;;
{
$B2:FC68 DA          PHX
$B2:FC69 5A          PHY
$B2:FC6A AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FC6D BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:FC70 38          SEC                    ;|
$B2:FC71 E9 18 00    SBC #$0018             ;} $12 = [enemy X position] - 18h
$B2:FC74 85 12       STA $12    [$7E:0012]  ;/
$B2:FC76 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$B2:FC79 38          SEC                    ;|
$B2:FC7A F9 00 00    SBC $0000,y[$B2:FBA2]  ;} $14 = [enemy Y position] - [[Y]]
$B2:FC7D 85 14       STA $14    [$7E:0014]  ;/
$B2:FC7F A9 00 00    LDA #$0000             ;\
$B2:FC82 85 16       STA $16    [$7E:0016]  ;} $16 = 0
$B2:FC84 A0 7B A1    LDY #$A17B             ;\
$B2:FC87 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn laser enemy projectile
$B2:FC8B 7A          PLY
$B2:FC8C FA          PLX
$B2:FC8D C8          INY                    ;\
$B2:FC8E C8          INY                    ;} Y += 2
$B2:FC8F 6B          RTL
}


;;; $FC90: Instruction - fire laser right with Y offset [[Y]] ;;;
{
$B2:FC90 DA          PHX
$B2:FC91 5A          PHY
$B2:FC92 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FC95 BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$B2:FC98 18          CLC                    ;|
$B2:FC99 69 18 00    ADC #$0018             ;} $12 = [enemy X position] + 18h
$B2:FC9C 85 12       STA $12    [$7E:0012]  ;/
$B2:FC9E BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$B2:FCA1 38          SEC                    ;|
$B2:FCA2 F9 00 00    SBC $0000,y[$B2:FC24]  ;} $14 = [enemy Y position] - [[Y]]
$B2:FCA5 85 14       STA $14    [$7E:0014]  ;/
$B2:FCA7 A9 01 00    LDA #$0001             ;\
$B2:FCAA 85 16       STA $16    [$7E:0016]  ;} $16 = 1
$B2:FCAC A0 7B A1    LDY #$A17B             ;\
$B2:FCAF 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn laser enemy projectile
$B2:FCB3 7A          PLY
$B2:FCB4 FA          PLX
$B2:FCB5 C8          INY                    ;\
$B2:FCB6 C8          INY                    ;} Y += 2
$B2:FCB7 6B          RTL
}


;;; $FCB8: Instruction - enemy function = [[Y]] ;;;
{
$B2:FCB8 5A          PHY
$B2:FCB9 DA          PHX
$B2:FCBA AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FCBD B9 00 00    LDA $0000,y[$B2:FBE8]  ;\
$B2:FCC0 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = [[Y]]
$B2:FCC3 FA          PLX
$B2:FCC4 7A          PLY
$B2:FCC5 C8          INY                    ;\
$B2:FCC6 C8          INY                    ;} Y += 2
$B2:FCC7 6B          RTL
}


;;; $FCC8: Instruction - choose a movement ;;;
{
$B2:FCC8 DA          PHX
$B2:FCC9 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FCCC A9 10 00    LDA #$0010             ;\
$B2:FCCF 5A          PHY                    ;|
$B2:FCD0 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;|
$B2:FCD4 7A          PLY                    ;} If Samus is within 10h pixel rows of enemy: go to BRANCH_VERTICAL_CLOSE
$B2:FCD5 29 FF FF    AND #$FFFF             ;|
$B2:FCD8 D0 14       BNE $14    [$FCEE]     ;/
$B2:FCDA AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FCDD A0 E6 FB    LDY #$FBE6             ; Y = $FBE6 (walking right)
$B2:FCE0 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$B2:FCE3 38          SEC                    ;|
$B2:FCE4 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;} If [Samus X position] >= [enemy X position]:
$B2:FCE7 30 03       BMI $03    [$FCEC]     ;/
$B2:FCE9 A0 64 FB    LDY #$FB64             ; Y = $FB64 (walking left)

$B2:FCEC FA          PLX
$B2:FCED 6B          RTL                    ; Return

; BRANCH_VERTICAL_CLOSE
$B2:FCEE AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FCF1 A0 8C FB    LDY #$FB8C             ; Y = $FB8C (fire lasers left)
$B2:FCF4 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$B2:FCF7 38          SEC                    ;|
$B2:FCF8 FD 7A 0F    SBC $0F7A,x[$7E:107A]  ;} If [Samus X position] >= [enemy X position]:
$B2:FCFB 30 03       BMI $03    [$FD00]     ;/
$B2:FCFD A0 0E FC    LDY #$FC0E             ; Y = $FC0E (fire lasers right)

$B2:FD00 FA          PLX
$B2:FD01 6B          RTL
}
}


;;; $FD02: Initialisation AI - enemy $F653/$F693/$F6D3/$F713/$F753/$F793 (walking space pirates) ;;;
{
$B2:FD02 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FD05 A0 64 FB    LDY #$FB64             ; Enemy instruction list pointer = $FB64 (walking left)
$B2:FD08 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$B2:FD0B 89 01 00    BIT #$0001             ;} If [enemy parameter 1] & 1 != 0:
$B2:FD0E F0 03       BEQ $03    [$FD13]     ;/
$B2:FD10 A0 E6 FB    LDY #$FBE6             ; Enemy instruction list pointer = $FBE6 (walking right)

$B2:FD13 98          TYA
$B2:FD14 9D 92 0F    STA $0F92,x[$7E:0F92]
$B2:FD17 A9 4B 80    LDA #$804B             ;\
$B2:FD1A 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = RTS
$B2:FD1D BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:FD20 18          CLC                    ;|
$B2:FD21 7D B6 0F    ADC $0FB6,x[$7E:0FB6]  ;} Enemy right post X position = [enemy X position] + [enemy parameter 2]
$B2:FD24 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;/
$B2:FD27 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:FD2A 38          SEC                    ;|
$B2:FD2B FD B6 0F    SBC $0FB6,x[$7E:0FB6]  ;} Enemy left post X position = [enemy X position] - [enemy parameter 2]
$B2:FD2E 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;/
$B2:FD31 6B          RTL
}


;;; $FD32: Main AI - enemy $F653/$F693/$F6D3/$F713/$F753/$F793 (walking space pirates) ;;;
{
$B2:FD32 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FD35 FC A8 0F    JSR ($0FA8,x)[$B2:804B]; Execute [enemy function]
$B2:FD38 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$B2:FD3B 89 00 80    BIT #$8000             ;} If [enemy parameter 1] & 8000h != 0:
$B2:FD3E F0 03       BEQ $03    [$FD43]     ;/
$B2:FD40 20 4B FE    JSR $FE4B  [$B2:FE4B]  ; Walking space pirate flinch trigger

$B2:FD43 6B          RTL
}


;;; $FD44: Walking space pirate function - walking left ;;;
{
$B2:FD44 AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FD47 A9 10 00    LDA #$0010             ;\
$B2:FD4A 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;} If Samus is not within 10h pixel rows of enemy: go to BRANCH_WALK
$B2:FD4E F0 1A       BEQ $1A    [$FD6A]     ;/
$B2:FD50 A0 8C FB    LDY #$FB8C             ; Enemy instruction list pointer = $FB8C (fire lasers left)
$B2:FD53 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$B2:FD56 38          SEC                    ;|
$B2:FD57 FD 7A 0F    SBC $0F7A,x[$7E:0FFA]  ;} If [Samus X position] >= [enemy X position]:
$B2:FD5A 30 03       BMI $03    [$FD5F]     ;/
$B2:FD5C A0 0E FC    LDY #$FC0E             ; Enemy instruction list pointer = $FC0E (fire lasers right)

$B2:FD5F 98          TYA
$B2:FD60 9D 92 0F    STA $0F92,x[$7E:1012]
$B2:FD63 A9 01 00    LDA #$0001             ;\
$B2:FD66 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$B2:FD69 60          RTS                    ; Return

; BRANCH_WALK
$B2:FD6A A9 01 00    LDA #$0001             ;\
$B2:FD6D 85 14       STA $14    [$7E:0014]  ;|
$B2:FD6F 64 12       STZ $12    [$7E:0012]  ;} Move enemy down by 1.0
$B2:FD71 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$B2:FD75 90 56       BCC $56    [$FDCD]     ; If not collided with block: return
$B2:FD77 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$B2:FD7A 9F 00 78 7E STA $7E7800,x[$7E:7880];} Enemy X position backup = [enemy X position]
$B2:FD7E 18          CLC                    ;\
$B2:FD7F 69 EF FF    ADC #$FFEF             ;} Enemy X position -= 11h
$B2:FD82 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$B2:FD85 A9 01 00    LDA #$0001             ;\
$B2:FD88 85 14       STA $14    [$7E:0014]  ;|
$B2:FD8A 64 12       STZ $12    [$7E:0012]  ;} Move enemy down by 1.0
$B2:FD8C 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$B2:FD90 08          PHP                    ;\
$B2:FD91 BF 00 78 7E LDA $7E7800,x[$7E:7880];|
$B2:FD95 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;} Enemy X position = [enemy X position backup]
$B2:FD98 28          PLP                    ;/
$B2:FD99 90 26       BCC $26    [$FDC1]     ; If collided with block:
$B2:FD9B A9 00 00    LDA #$0000             ;\
$B2:FD9E 85 12       STA $12    [$7E:0012]  ;|
$B2:FDA0 A9 F7 FF    LDA #$FFF7             ;} $14.$12 = -9.0
$B2:FDA3 85 14       STA $14    [$7E:0014]  ;/
$B2:FDA5 22 BF BB A0 JSL $A0BBBF[$A0:BBBF]  ; Check for horizontal "solid" block collision... and discard the result
$B2:FDA9 A9 FF C7    LDA #$C7FF             ;\
$B2:FDAC 85 12       STA $12    [$7E:0012]  ;|
$B2:FDAE A9 FF FF    LDA #$FFFF             ;} Move enemy left by 0.3801h
$B2:FDB1 85 14       STA $14    [$7E:0014]  ;|
$B2:FDB3 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$B2:FDB7 B0 08       BCS $08    [$FDC1]     ; If not collided with wall:
$B2:FDB9 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$B2:FDBC DD B0 0F    CMP $0FB0,x[$7E:1030]  ;} If [enemy X position] >= [enemy left post X position]: return
$B2:FDBF 10 0C       BPL $0C    [$FDCD]     ;/

$B2:FDC1 A9 C6 FB    LDA #$FBC6             ;\
$B2:FDC4 9D 92 0F    STA $0F92,x[$7E:1092]  ;} Enemy instruction list pointer = $FBC6 (look around - facing left)
$B2:FDC7 A9 01 00    LDA #$0001             ;\
$B2:FDCA 9D 94 0F    STA $0F94,x[$7E:1094]  ;} Enemy instruction timer = 1

$B2:FDCD 60          RTS
}


;;; $FDCE: Walking space pirate function - walking right ;;;
{
$B2:FDCE AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FDD1 A9 10 00    LDA #$0010             ;\
$B2:FDD4 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;} If Samus is not within 10h pixel rows of enemy: go to BRANCH_WALK
$B2:FDD8 F0 1A       BEQ $1A    [$FDF4]     ;/
$B2:FDDA A0 8C FB    LDY #$FB8C             ; Enemy instruction list pointer = $FB8C (fire lasers left)
$B2:FDDD AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$B2:FDE0 38          SEC                    ;|
$B2:FDE1 FD 7A 0F    SBC $0F7A,x[$7E:103A]  ;} If [Samus X position] >= [enemy X position]:
$B2:FDE4 30 03       BMI $03    [$FDE9]     ;/
$B2:FDE6 A0 0E FC    LDY #$FC0E             ; Enemy instruction list pointer = $FC0E (fire lasers right)

$B2:FDE9 98          TYA
$B2:FDEA 9D 92 0F    STA $0F92,x[$7E:1052]
$B2:FDED A9 01 00    LDA #$0001             ;\
$B2:FDF0 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Enemy instruction timer = 1
$B2:FDF3 60          RTS                    ; Return

; BRANCH_WALK
$B2:FDF4 A9 01 00    LDA #$0001             ;\
$B2:FDF7 85 14       STA $14    [$7E:0014]  ;|
$B2:FDF9 64 12       STZ $12    [$7E:0012]  ;} Move enemy down by 1.0
$B2:FDFB 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$B2:FDFF 90 48       BCC $48    [$FE49]     ; If not collided with block: return
$B2:FE01 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:FE04 9F 00 78 7E STA $7E7800,x[$7E:7800];} Enemy X position backup = [enemy X position]
$B2:FE08 18          CLC                    ;\
$B2:FE09 69 10 00    ADC #$0010             ;} Enemy X position += 10h
$B2:FE0C 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$B2:FE0F A9 01 00    LDA #$0001             ;\
$B2:FE12 85 14       STA $14    [$7E:0014]  ;|
$B2:FE14 64 12       STZ $12    [$7E:0012]  ;} Move enemy down by 1.0
$B2:FE16 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$B2:FE1A 08          PHP                    ;\
$B2:FE1B BF 00 78 7E LDA $7E7800,x[$7E:7800];|
$B2:FE1F 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy X position = [enemy X position backup]
$B2:FE22 28          PLP                    ;/
$B2:FE23 90 18       BCC $18    [$FE3D]     ; If collided with block:
$B2:FE25 A9 00 38    LDA #$3800             ;\
$B2:FE28 85 12       STA $12    [$7E:0012]  ;|
$B2:FE2A A9 00 00    LDA #$0000             ;} Move enemy right by 0.3800h
$B2:FE2D 85 14       STA $14    [$7E:0014]  ;|
$B2:FE2F 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$B2:FE33 B0 08       BCS $08    [$FE3D]     ; If not collided with wall:
$B2:FE35 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:FE38 DD B2 0F    CMP $0FB2,x[$7E:0FB2]  ;} If [enemy X position] < [enemy right post X position]: return
$B2:FE3B 30 0C       BMI $0C    [$FE49]     ;/

$B2:FE3D A9 48 FC    LDA #$FC48             ;\
$B2:FE40 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $FC48 (look around - facing right)
$B2:FE43 A9 01 00    LDA #$0001             ;\
$B2:FE46 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Enemy instruction timer = 1

$B2:FE49 60          RTS
}


;;; $FE4A: RTS ;;;
{
$B2:FE4A 60          RTS
}


;;; $FE4B: Walking space pirate flinch trigger ;;;
{
; Return value is ignored by caller. Probably left over from $F72E copy+paste
$B2:FE4B DA          PHX
$B2:FE4C AE 54 0E    LDX $0E54  [$7E:0E54]
$B2:FE4F A0 08 00    LDY #$0008             ; Y = 8 (projectile index)

; LOOP
$B2:FE52 B9 18 0C    LDA $0C18,y[$7E:0C20]  ;\
$B2:FE55 D0 06       BNE $06    [$FE5D]     ;} If [projectile type] = 0:
$B2:FE57 88          DEY                    ;\
$B2:FE58 88          DEY                    ;} Y -= 2
$B2:FE59 10 F7       BPL $F7    [$FE52]     ; If [Y] >= 0: go to LOOP
$B2:FE5B 80 48       BRA $48    [$FEA5]     ; Return A = 0

$B2:FE5D B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$B2:FE60 38          SEC                    ;|
$B2:FE61 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$B2:FE64 10 04       BPL $04    [$FE6A]     ;|
$B2:FE66 49 FF FF    EOR #$FFFF             ;|
$B2:FE69 1A          INC A                  ;} If |[projectile X position] - [enemy X position]| >= 20h: return A = 0
                                            ;|
$B2:FE6A 38          SEC                    ;|
$B2:FE6B E9 20 00    SBC #$0020             ;|
$B2:FE6E 10 35       BPL $35    [$FEA5]     ;/
$B2:FE70 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$B2:FE73 38          SEC                    ;|
$B2:FE74 FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;|
$B2:FE77 10 04       BPL $04    [$FE7D]     ;|
$B2:FE79 49 FF FF    EOR #$FFFF             ;|
$B2:FE7C 1A          INC A                  ;} If |[projectile Y position] - [enemy Y position]| >= 20h: return A = 0
                                            ;|
$B2:FE7D 38          SEC                    ;|
$B2:FE7E E9 20 00    SBC #$0020             ;|
$B2:FE81 10 22       BPL $22    [$FEA5]     ;/
$B2:FE83 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$B2:FE86 38          SEC                    ;|
$B2:FE87 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} $12 = [enemy X position] - [Samus X position]
$B2:FE8A 85 12       STA $12    [$7E:0012]  ;/
$B2:FE8C A0 4C FB    LDY #$FB4C             ; Enemy instruction list pointer = $FB4C (flinch - facing left)
$B2:FE8F A5 12       LDA $12    [$7E:0012]  ;\
$B2:FE91 10 03       BPL $03    [$FE96]     ;} If [enemy X position] < [Samus X position]:
$B2:FE93 A0 58 FB    LDY #$FB58             ; Enemy instruction list pointer = $FB58 (flinch - facing right)

$B2:FE96 98          TYA
$B2:FE97 9D 92 0F    STA $0F92,x[$7E:0F92]
$B2:FE9A A9 01 00    LDA #$0001             ;\
$B2:FE9D 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction list timer = 1
$B2:FEA0 FA          PLX
$B2:FEA1 A9 01 00    LDA #$0001             ;\
$B2:FEA4 60          RTS                    ;} Return A = 1

$B2:FEA5 FA          PLX
$B2:FEA6 A9 00 00    LDA #$0000
$B2:FEA9 60          RTS
}
}


;;; $FEAA: Free space ;;;
{
$B2:FEAA             fillto $B38000, $FF        ; Free space
}
