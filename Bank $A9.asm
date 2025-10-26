;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687..C70F: Mother Brain ;;;
{
;;; $8687: Initialisation AI - enemy $EC7F (Mother Brain body) ;;;
{
$A9:8687 8B          PHB                    ;\
$A9:8688 F4 7E 7E    PEA $7E7E              ;|
$A9:868B AB          PLB                    ;|
$A9:868C AB          PLB                    ;|
$A9:868D A9 38 03    LDA #$0338             ;|
$A9:8690 A2 FE 0F    LDX #$0FFE             ;|
                                            ;} $7E:2000..2FFF = 0338h (BG2 tilemap)
$A9:8693 9D 00 20    STA $2000,x[$7E:2FFE]  ;|
$A9:8696 CA          DEX                    ;|
$A9:8697 CA          DEX                    ;|
$A9:8698 10 F9       BPL $F9    [$8693]     ;|
$A9:869A AB          PLB                    ;/
$A9:869B A9 13 9C    LDA #$9C13             ;\
$A9:869E 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to $9C13
$A9:86A1 9C 98 0F    STZ $0F98  [$7E:0F98]  ; Mother Brain body VRAM tiles index = 0
$A9:86A4 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:86A7 09 00 15    ORA #$1500             ;} Set Mother Brain body to block plasma beam, be intangible and invisible
$A9:86AA 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A9:86AD A9 00 00    LDA #$0000             ;\
$A9:86B0 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Mother Brain body palette index = 0
$A9:86B3 A0 14 95    LDY #$9514             ;\
$A9:86B6 A2 62 01    LDX #$0162             ;|
$A9:86B9 A9 0F 00    LDA #$000F             ;} Sprite target palette 3 colours 1..Fh = [$9514..31] (glass shards)
$A9:86BC 22 F6 D2 A9 JSL $A9D2F6[$A9:D2F6]  ;/
$A9:86C0 A0 F4 94    LDY #$94F4             ;\
$A9:86C3 A2 E2 01    LDX #$01E2             ;|
$A9:86C6 A9 0F 00    LDA #$000F             ;} Sprite target palette 7 colours 1..Fh = [$94F4..9511] (tube enemy projectiles)
$A9:86C9 22 F6 D2 A9 JSL $A9D2F6[$A9:D2F6]  ;/
$A9:86CD A9 00 00    LDA #$0000             ;\
$A9:86D0 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Mother Brain's form = first phase
$A9:86D4 8F 44 78 7E STA $7E7844[$7E:7844]  ; Disable unpause hook
$A9:86D8 A9 02 00    LDA #$0002             ;\
$A9:86DB 8F 08 78 7E STA $7E7808[$7E:7808]  ;} Mother Brain hitboxes enabled = Mother Brain brain
$A9:86DF A9 D0 87    LDA #$87D0             ;\
$A9:86E2 8D E8 0F    STA $0FE8  [$7E:0FE8]  ;} Mother Brain brain function = $87D0 (set up brain to be drawn)
$A9:86E5 A9 E1 87    LDA #$87E1             ;\
$A9:86E8 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $87E1 (first phase)
$A9:86EB A9 01 00    LDA #$0001             ;\
$A9:86EE 22 02 AB 89 JSL $89AB02[$89:AB02]  ;} Load FX entry index 1
$A9:86F2 A9 00 00    LDA #$0000             ;\
                                            ;|
$A9:86F5 48          PHA                    ;|
$A9:86F6 A0 7E C1    LDY #$C17E             ;|
$A9:86F9 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Ch Mother Brain's room turret enemy projectiles
$A9:86FD 68          PLA                    ;|
$A9:86FE 1A          INC A                  ;|
$A9:86FF C9 0C 00    CMP #$000C             ;|
$A9:8702 90 F1       BCC $F1    [$86F5]     ;/
$A9:8704 6B          RTL
}


;;; $8705: Initialisation AI - enemy $EC3F (Mother Brain brain) ;;;
{
$A9:8705 A2 40 00    LDX #$0040             ; X = (Mother Brain brain enemy index)
$A9:8708 A0 08 DE    LDY #$DE08             ; Y = $DE08
$A9:870B 20 5F DC    JSR $DC5F  [$A9:DC5F]  ; Initialise Mother Brain corpse rotting
$A9:870E A9 B8 0B    LDA #$0BB8             ;\
$A9:8711 8D CC 0F    STA $0FCC  [$7E:0FCC]  ;} Mother Brain brain health = 3000
$A9:8714 A9 13 9C    LDA #$9C13             ;\
$A9:8717 20 3A C4    JSR $C43A  [$A9:C43A]  ;} Set Mother Brain brain unused instruction list to $9C13
$A9:871A 9C D8 0F    STZ $0FD8  [$7E:0FD8]  ; Mother Brain brain VRAM tiles index = 0
$A9:871D AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A9:8720 09 00 11    ORA #$1100             ;} Set Mother Brain brain to block plasma beam and be invisible
$A9:8723 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A9:8726 A9 00 02    LDA #$0200             ;\
$A9:8729 8D D6 0F    STA $0FD6  [$7E:0FD6]  ;} Mother Brain brain palette index = 200h (palette 1)
$A9:872C 8F 18 78 7E STA $7E7818[$7E:7818]  ; Mother Brain's neck palette index = 200h
$A9:8730 8F 1A 78 7E STA $7E781A[$7E:781A]  ; Mother Brain brain palette index = 200h
$A9:8734 A9 21 9C    LDA #$9C21             ;\
$A9:8737 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C21 (initial)
$A9:873A 20 F8 D1    JSR $D1F8  [$A9:D1F8]  ; Set up Mother Brain brain normal palette
$A9:873D 6B          RTL
}


;;; $873E: Main AI / hurt AI - enemy $EC7F (Mother Brain body) ;;;
{
$A9:873E 20 1C D0    JSR $D01C  [$A9:D01C]  ; Handle room palette
$A9:8741 F4 46 87    PEA $8746              ;\
$A9:8744 6C A8 0F    JMP ($0FA8)[$A9:87E1]  ;} Execute [Mother Brain body function]

$A9:8747 20 E4 D1    JSR $D1E4  [$A9:D1E4]  ; Handle Mother Brain's palette
$A9:874A 20 B6 B3    JSR $B3B6  [$A9:B3B6]  ; Mother Brain / Samus collision detection
$A9:874D 20 D4 CF    JSR $CFD4  [$A9:CFD4]  ; Process Mother Brain invincibility palette
$A9:8750 AF 44 78 7E LDA $7E7844[$7E:7844]  ;\
$A9:8754 F0 0C       BEQ $0C    [$8762]     ;} If unpause hook enabled:
$A9:8756 A9 00 A9    LDA #$A900             ;\
$A9:8759 8D 05 06    STA $0605  [$7E:0605]  ;|
$A9:875C A9 63 87    LDA #$8763             ;} Unpause hook = unpause hook - Mother Brain body
$A9:875F 8D 04 06    STA $0604  [$7E:0604]  ;/

$A9:8762 6B          RTL
}


;;; $8763: Unpause hook - Mother Brain body ;;;
{
$A9:8763 AF 2C 78 7E LDA $7E782C[$7E:782C]  ;\
$A9:8767 F0 07       BEQ $07    [$8770]     ;} If Mother Brain rainbow beam sound effect is playing:
$A9:8769 A9 40 00    LDA #$0040             ;\
$A9:876C 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 40h, sound library 1, max queued sounds allowed = 6 (Mother Brain's rainbow beam)

$A9:8770 AD 88 0F    LDA $0F88  [$7E:0F88]  ;\
$A9:8773 29 04 00    AND #$0004             ;} If Mother Brain body extended spritemap format enabled:
$A9:8776 F0 0C       BEQ $0C    [$8784]     ;/
$A9:8778 A9 00 08    LDA #$0800             ;\
$A9:877B 8D 9A 17    STA $179A  [$7E:179A]  ;} Enemy BG2 tilemap size = 800h
$A9:877E A9 01 00    LDA #$0001             ;\
$A9:8781 8D 1E 0E    STA $0E1E  [$7E:0E1E]  ;} Request enemy BG2 tilemap VRAM transfer

$A9:8784 6B          RTL
}


;;; $8785: RTS ;;;
{
$A9:8785 60          RTS
}


;;; $8786: RTL ;;;
{
$A9:8786 6B          RTL
}


;;; $8787: Power bomb reaction - enemy $EC3F/$EC7F (Mother Brain) ;;;
{
$A9:8787 22 B7 A5 A0 JSL $A0A5B7[$A0:A5B7]  ; Normal enemy power bomb AI - no death check
}


;;; $878B: Main AI / hurt AI - enemy $EC3F (Mother Brain brain) ;;;
{
; Power bomb reaction for enemy $EC7F falls through into here, possible bug?

; If set to invisible, then process a function that may set enemy graphics drawn hook to a function that draws Mother Brain.
; Why use the enemy graphics drawn hook instead of doing the work here?
$A9:878B A9 00 A9    LDA #$A900             ;\
$A9:878E 8D 8D 17    STA $178D  [$7E:178D]  ;|
$A9:8791 A9 86 87    LDA #$8786             ;} Enemy graphics drawn hook = RTL
$A9:8794 8D 8C 17    STA $178C  [$7E:178C]  ;/
$A9:8797 AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A9:879A 29 00 01    AND #$0100             ;} If Mother Brain brain is not invisible: return
$A9:879D F0 E7       BEQ $E7    [$8786]     ;/
$A9:879F 6C E8 0F    JMP ($0FE8)[$A9:87D0]  ; Go to [Mother Brain brain function]
}


;;; $87A2: Mother Brain brain function - set up brain and neck to be drawn ;;;
{
$A9:87A2 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$A9:87A5 D0 03       BNE $03    [$87AA]     ;} If time is not frozen:
$A9:87A7 20 B8 91    JSR $91B8  [$A9:91B8]  ; Handle Mother Brain's neck

$A9:87AA AF 5C 80 7E LDA $7E805C[$7E:805C]  ;\
$A9:87AE 8D BA 0F    STA $0FBA  [$7E:0FBA]  ;} Mother Brain brain X position = [Mother Brain's neck hitbox segment 4 X position]
$A9:87B1 A9 EB FF    LDA #$FFEB             ;\
$A9:87B4 18          CLC                    ;|
$A9:87B5 6F 5E 80 7E ADC $7E805E[$7E:805E]  ;} Mother Brain brain Y position = [Mother Brain's neck hitbox segment 4 Y position] - 15h
$A9:87B9 8D BE 0F    STA $0FBE  [$7E:0FBE]  ;/
$A9:87BC A9 00 A9    LDA #$A900             ;\
$A9:87BF 8D 8D 17    STA $178D  [$7E:178D]  ;|
$A9:87C2 A9 C9 87    LDA #$87C9             ;} Enemy graphics drawn hook = $A9:87C9 (draw brain and neck)
$A9:87C5 8D 8C 17    STA $178C  [$7E:178C]  ;/
$A9:87C8 6B          RTL
}


;;; $87C9: Enemy graphics drawn hook - Mother Brain - draw brain and neck ;;;
{
$A9:87C9 20 57 93    JSR $9357  [$A9:9357]  ; Draw Mother Brain brain
$A9:87CC 20 03 93    JSR $9303  [$A9:9303]  ; Draw Mother Brain's neck
$A9:87CF 6B          RTL
}


;;; $87D0: Mother Brain brain function - set up brain to be drawn ;;;
{
$A9:87D0 A9 00 A9    LDA #$A900             ;\
$A9:87D3 8D 8D 17    STA $178D  [$7E:178D]  ;|
$A9:87D6 A9 DD 87    LDA #$87DD             ;} Enemy graphics drawn hook = $A9:87DD (draw brain)
$A9:87D9 8D 8C 17    STA $178C  [$7E:178C]  ;/
$A9:87DC 6B          RTL
}


;;; $87DD: Enemy graphics drawn hook - Mother Brain - draw brain ;;;
{
$A9:87DD 20 57 93    JSR $9357  [$A9:9357]  ; Draw Mother Brain brain
$A9:87E0 6B          RTL
}


;;; $87E1: Mother Brain body function - first phase ;;;
{
$A9:87E1 A9 02 00    LDA #$0002             ;\
$A9:87E4 22 33 82 80 JSL $808233[$80:8233]  ;} If Mother Brain's glass is destroyed:
$A9:87E8 90 2E       BCC $2E    [$8818]     ;/
$A9:87EA AD 40 18    LDA $1840  [$7E:1840]  ;\
$A9:87ED 8F 40 78 7E STA $7E7840[$7E:7840]  ;} Mother Brain brain main shake timer = [earthquake timer]
$A9:87F1 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:87F4 C9 EC 00    CMP #$00EC             ;} If [Samus X position] < ECh:
$A9:87F7 10 1F       BPL $1F    [$8818]     ;/
$A9:87F9 AD CC 0F    LDA $0FCC  [$7E:0FCC]  ;\
$A9:87FC D0 1A       BNE $1A    [$8818]     ;} If [Mother Brain brain health] = 0:
$A9:87FE A9 01 00    LDA #$0001             ;\
$A9:8801 8F 3A 78 7E STA $7E783A[$7E:783A]  ;} Flag turrets and rinkas to be deleted
$A9:8805 8F 00 78 7E STA $7E7800[$7E:7800]  ; Mother Brain form = fake death
$A9:8809 22 E2 A7 90 JSL $90A7E2[$90:A7E2]  ; Disable mini-map and mark boss room map tiles as explored
$A9:880D A9 06 00    LDA #$0006             ;\
$A9:8810 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 1 music track
$A9:8814 22 96 E3 AD JSL $ADE396[$AD:E396]  ; Seal Mother Brain's wall, function = $881D (fake death)

$A9:8818 20 B6 B3    JSR $B3B6  [$A9:B3B6]  ; Mother Brain / Samus collision detection
$A9:881B 68          PLA
$A9:881C 6B          RTL
}


;;; $881D..8F8E: Mother Brain - fake death ;;;
{
;;; $881D: Mother Brain body function - fake death - descent - initial pause ;;;
{
$A9:881D A9 29 88    LDA #$8829             ;\
$A9:8820 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8829
$A9:8823 A9 40 00    LDA #$0040             ;\
$A9:8826 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 40h
}


;;; $8829: Mother Brain body function - fake death - descent - lock Samus and set scroll region ;;;
{
$A9:8829 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:882C 30 01       BMI $01    [$882F]     ; If [Mother Brain body function timer] >= 0:
$A9:882E 60          RTS                    ; Return

$A9:882F A9 00 00    LDA #$0000             ;\
$A9:8832 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus
$A9:8836 AF 20 CD 7E LDA $7ECD20[$7E:CD20]  ;\
$A9:883A 29 FF 00    AND #$00FF             ;} Scroll 1 = red
$A9:883D 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;/
$A9:8841 A9 4D 88    LDA #$884D             ;\
$A9:8844 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $884D
$A9:8847 A9 20 00    LDA #$0020             ;\
$A9:884A 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 20h
}


;;; $884D: Mother Brain body function - fake death - descent - queue Mother Brain music ;;;
{
$A9:884D CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:8850 10 5F       BPL $5F    [$88B1]     ; If [Mother Brain body function timer] >= 0: return
$A9:8852 A9 00 00    LDA #$0000             ;\
$A9:8855 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$A9:8859 A9 21 FF    LDA #$FF21             ;\
$A9:885C 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue Mother Brain music data
$A9:8860 A9 6C 88    LDA #$886C             ;\
$A9:8863 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $886C
$A9:8866 A9 0C 00    LDA #$000C             ;\
$A9:8869 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = Ch
}


;;; $886C: Mother Brain body function - fake death - descent - unlock Samus ;;;
{
$A9:886C CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:886F 10 40       BPL $40    [$88B1]     ; If [Mother Brain body function timer] >= 0: return
$A9:8871 A9 01 00    LDA #$0001             ;\
$A9:8874 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$A9:8878 A9 84 88    LDA #$8884             ;\
$A9:887B 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8884
$A9:887E A9 08 00    LDA #$0008             ;\
$A9:8881 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 8
}


;;; $8884: Mother Brain body function - fake death - descent - begin screen flashing and lower acid ;;;
{
$A9:8884 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:8887 10 28       BPL $28    [$88B1]     ; If [Mother Brain body function timer] >= 0: return
$A9:8889 20 FD CF    JSR $CFFD  [$A9:CFFD]  ; Begin screen flashing
$A9:888C A9 02 00    LDA #$0002             ;\
$A9:888F 22 02 AB 89 JSL $89AB02[$89:AB02]  ;} Load FX entry index 2 (lower acid)
$A9:8893 A9 49 89    LDA #$8949             ;\
$A9:8896 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8949 (wait until there are less than 4 enemy projectiles alive and spawn tubes falling enemy 0)
$A9:8899 A9 B2 88    LDA #$88B2             ;\
$A9:889C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $88B2
$A9:889F 9C B2 0F    STZ $0FB2  [$7E:0FB2]  ; Mother Brain body function timer = 0
$A9:88A2 A9 00 00    LDA #$0000             ;\
$A9:88A5 8F 2E 80 7E STA $7E802E[$7E:802E]  ;} Mother Brain grey transition counter = 0
$A9:88A9 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:88AD             dx 0E,02,B6B3          ;} Spawn PLM to clear ceiling block

$A9:88B1 60          RTS
}


;;; $88B2: Mother Brain body function - fake death - descent - transition Mother Brain palette to grey ;;;
{
$A9:88B2 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:88B5 10 1C       BPL $1C    [$88D3]     ; If [Mother Brain body function timer] < 0:
$A9:88B7 A9 08 00    LDA #$0008             ;\
$A9:88BA 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 8
$A9:88BD AF 2E 80 7E LDA $7E802E[$7E:802E]  ; A = [Mother Brain grey transition counter]
$A9:88C1 1A          INC A                  ;\
$A9:88C2 8F 2E 80 7E STA $7E802E[$7E:802E]  ;} Increment Mother Brain grey transition counter
$A9:88C6 3A          DEC A                  ;/
$A9:88C7 22 DE EE AD JSL $ADEEDE[$AD:EEDE]  ; Transition Mother Brain palette to grey
$A9:88CB 90 06       BCC $06    [$88D3]     ; If finished transition:
$A9:88CD A9 D3 88    LDA #$88D3             ;\
$A9:88D0 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $88D3
}


;;; $88D3: Mother Brain body function - fake death - descent - collapse tubes ;;;
{
$A9:88D3 F4 D8 88    PEA $88D8              ;\
$A9:88D6 6C F0 0F    JMP ($0FF0)[$A9:8949]  ;} Execute [Mother Brain body subfunction]

$A9:88D9 20 DD 88    JSR $88DD  [$A9:88DD]  ; Handle fake death explosions
$A9:88DC 60          RTS
}


;;; $88DD: Handle fake death explosions ;;;
{
$A9:88DD AF 30 80 7E LDA $7E8030[$7E:8030]  ;\
$A9:88E1 3A          DEC A                  ;} If [Mother Brain fake death explosion timer] > 0:
$A9:88E2 30 05       BMI $05    [$88E9]     ;/
$A9:88E4 8F 30 80 7E STA $7E8030[$7E:8030]  ; Decrement Mother Brain fake death explosion timer
$A9:88E8 60          RTS                    ; Return

$A9:88E9 A9 08 00    LDA #$0008             ;\
$A9:88EC 8F 30 80 7E STA $7E8030[$7E:8030]  ;} Mother Brain fake death explosion timer = 8
$A9:88F0 AF 32 80 7E LDA $7E8032[$7E:8032]  ;\
$A9:88F4 3A          DEC A                  ;|
$A9:88F5 10 03       BPL $03    [$88FA]     ;|
$A9:88F7 A9 07 00    LDA #$0007             ;} Mother Brain fake death explosion index = ([Mother Brain fake death explosion index] - 1) % 8
                                            ;|
$A9:88FA 8F 32 80 7E STA $7E8032[$7E:8032]  ;/
$A9:88FE 0A          ASL A                  ;\
$A9:88FF 0A          ASL A                  ;} X = [Mother Brain fake death explosion index] * 4
$A9:8900 AA          TAX                    ;/
$A9:8901 BD 29 89    LDA $8929,x[$A9:8945]  ;\
$A9:8904 85 12       STA $12    [$7E:0012]  ;} $12 = [$8929 + [X]]
$A9:8906 BD 2B 89    LDA $892B,x[$A9:8947]  ;\
$A9:8909 85 14       STA $14    [$7E:0014]  ;} $14 = [$8929 + [X] + 2]
$A9:890B A0 03 00    LDY #$0003             ; A = 3 (small explosion)
$A9:890E AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:8911 C9 00 40    CMP #$4000             ;} If [random number] < 4000h:
$A9:8914 B0 03       BCS $03    [$8919]     ;/
$A9:8916 A0 0C 00    LDY #$000C             ; A = Ch (smoke)

$A9:8919 98          TYA
$A9:891A A0 09 E5    LDY #$E509             ;\
$A9:891D 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:8921 A9 24 00    LDA #$0024             ;\
$A9:8924 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 24h, sound library 2, max queued sounds allowed = 3 (small explosion)
$A9:8928 60          RTS

;                        ________ Explosion X position
;                       |     ___ Explosion Y position
;                       |    |
$A9:8929             dw 0088,0074,
                        0078,0084,
                        007C,005A,
                        008A,0092,
                        0078,0034,
                        007C,00AA,
                        008A,0048,
                        0078,00CE
}


;;; $8949..8AE4: Mother brain body subfunctions ;;;
{
;;; $8949: Mother brain body subfunction - wait until there are less than 4 enemy projectiles alive and spawn tubes falling enemy 0 ;;;
{
$A9:8949 A0 00 00    LDY #$0000             ; Y = 0 (enemy projectile index)
$A9:894C BB          TYX                    ; X = 0 (number of enemy projectiles)

; LOOP
$A9:894D B9 97 19    LDA $1997,y[$7E:1997]  ;\
$A9:8950 D0 01       BNE $01    [$8953]     ;} If [enemy projectile ID] = 0:
$A9:8952 E8          INX                    ; Increment X

$A9:8953 C8          INY                    ;\
$A9:8954 C8          INY                    ;} Y += 2
$A9:8955 C0 24 00    CPY #$0024             ;\
$A9:8958 30 F3       BMI $F3    [$894D]     ;} If [Y] < 24h: go to LOOP
$A9:895A E0 04 00    CPX #$0004             ;\
$A9:895D 10 01       BPL $01    [$8960]     ;} If [X] < 4:
$A9:895F 60          RTS                    ; Return

$A9:8960 A2 E5 8A    LDX #$8AE5             ;\
$A9:8963 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Mother Brain tubes falling enemy 0
$A9:8967 A9 6E 89    LDA #$896E             ;\
$A9:896A 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $896E
$A9:896D 60          RTS
}


;;; $896E: Mother brain body subfunction - clear bottom-left tube ;;;
{
$A9:896E 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8972             dx 05,09,B6C3          ;} Spawn PLM to clear Mother Brain's bottom-left tube
$A9:8976 A9 83 89    LDA #$8983             ;\
$A9:8979 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8983
$A9:897C A9 20 00    LDA #$0020             ;\
$A9:897F 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Mother Brain body subfunction timer = 20
$A9:8982 60          RTS
}


;;; $8983: Mother brain body subfunction - spawn top-right tube falling enemy projectile ;;;
{
$A9:8983 CE F2 0F    DEC $0FF2  [$7E:0FF2]  ; Decrement Mother Brain body subfunction timer
$A9:8986 10 17       BPL $17    [$899F]     ; If [Mother Brain body subfunction timer] >= 0: return
$A9:8988 A9 98 00    LDA #$0098             ;\
$A9:898B 85 12       STA $12    [$7E:0012]  ;} $12 = 98h
$A9:898D A9 2F 00    LDA #$002F             ;\
$A9:8990 85 14       STA $14    [$7E:0014]  ;} $14 = 2Fh
$A9:8992 A0 5B CC    LDY #$CC5B             ;\
$A9:8995 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's top-right tube falling enemy projectile
$A9:8999 A9 A0 89    LDA #$89A0             ;\
$A9:899C 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $89A0

$A9:899F 60          RTS
}


;;; $89A0: Mother brain body subfunction - clear ceiling block column 9 ;;;
{
$A9:89A0 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:89A4             dx 09,02,B6B3          ;} Spawn PLM to clear ceiling block
$A9:89A8 A9 B5 89    LDA #$89B5             ;\
$A9:89AB 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $89B5
$A9:89AE A9 20 00    LDA #$0020             ;\
$A9:89B1 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Mother Brain body subfunction timer = 20h
$A9:89B4 60          RTS
}


;;; $89B5: Mother brain body subfunction - spawn top-left tube falling enemy projectile ;;;
{
$A9:89B5 CE F2 0F    DEC $0FF2  [$7E:0FF2]  ; Decrement Mother Brain body subfunction timer
$A9:89B8 10 17       BPL $17    [$89D1]     ; If [Mother Brain body subfunction timer] >= 0: return
$A9:89BA A9 68 00    LDA #$0068             ;\
$A9:89BD 85 12       STA $12    [$7E:0012]  ;} $12 = 68h
$A9:89BF A9 2F 00    LDA #$002F             ;\
$A9:89C2 85 14       STA $14    [$7E:0014]  ;} $14 = 2Fh
$A9:89C4 A0 69 CC    LDY #$CC69             ;\
$A9:89C7 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's top-left tube falling enemy projectile
$A9:89CB A9 D2 89    LDA #$89D2             ;\
$A9:89CE 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $89D2

$A9:89D1 60          RTS
}


;;; $89D2: Mother brain body subfunction - clear ceiling block column 6 ;;;
{
$A9:89D2 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:89D6             dx 06,02,B6B3          ;} Spawn PLM to clear ceiling block
$A9:89DA A9 E7 89    LDA #$89E7             ;\
$A9:89DD 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $89E7
$A9:89E0 A9 20 00    LDA #$0020             ;\
$A9:89E3 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Mother Brain body subfunction timer = 20h
$A9:89E6 60          RTS
}


;;; $89E7: Mother brain body subfunction - spawn tubes falling enemy 1 ;;;
{
$A9:89E7 CE F2 0F    DEC $0FF2  [$7E:0FF2]  ; Decrement Mother Brain body subfunction timer
$A9:89EA 10 0D       BPL $0D    [$89F9]     ; If [Mother Brain body subfunction timer] >= 0: return
$A9:89EC A2 F5 8A    LDX #$8AF5             ;\
$A9:89EF 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Mother Brain tubes falling enemy 1
$A9:89F3 A9 FA 89    LDA #$89FA             ;\
$A9:89F6 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $89FA

$A9:89F9 60          RTS
}


;;; $89FA: Mother brain body subfunction - clear bottom-right tube ;;;
{
$A9:89FA 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:89FE             dx 0A,09,B6C7          ;} Spawn PLM to clear Mother Brain's bottom-right tube
$A9:8A02 A9 0F 8A    LDA #$8A0F             ;\
$A9:8A05 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8A0F
$A9:8A08 A9 20 00    LDA #$0020             ;\
$A9:8A0B 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Mother Brain body subfunction timer = 20h
$A9:8A0E 60          RTS
}


;;; $8A0F: Mother brain body subfunction - spawn tubes falling enemy 2 ;;;
{
$A9:8A0F CE F2 0F    DEC $0FF2  [$7E:0FF2]  ; Decrement Mother Brain body subfunction timer
$A9:8A12 10 0D       BPL $0D    [$8A21]     ; If [Mother Brain body subfunction timer] >= 0: return
$A9:8A14 A2 05 8B    LDX #$8B05             ;\
$A9:8A17 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Mother Brain tubes falling enemy 2
$A9:8A1B A9 22 8A    LDA #$8A22             ;\
$A9:8A1E 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8A22

$A9:8A21 60          RTS
}


;;; $8A22: Mother brain body subfunction - clear bottom-middle-left tube ;;;
{
$A9:8A22 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8A26             dx 06,0A,B6BB          ;} Spawn PLM to clear Mother Brain's bottom-middle-side tube
$A9:8A2A A9 37 8A    LDA #$8A37             ;\
$A9:8A2D 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8A37
$A9:8A30 A9 20 00    LDA #$0020             ;\
$A9:8A33 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Mother Brain body subfunction timer = 20h
$A9:8A36 60          RTS
}


;;; $8A37: Mother brain body subfunction - spawn top-middle-left tube falling enemy projectile ;;;
{
$A9:8A37 CE F2 0F    DEC $0FF2  [$7E:0FF2]  ; Decrement Mother Brain body subfunction timer
$A9:8A3A 10 17       BPL $17    [$8A53]     ; If [Mother Brain body subfunction timer] >= 0: return
$A9:8A3C A9 78 00    LDA #$0078             ;\
$A9:8A3F 85 12       STA $12    [$7E:0012]  ;} $12 = 78h
$A9:8A41 A9 3B 00    LDA #$003B             ;\
$A9:8A44 85 14       STA $14    [$7E:0014]  ;} $14 = 3Bh
$A9:8A46 A0 77 CC    LDY #$CC77             ;\
$A9:8A49 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's top-middle-left tube falling enemy projectile
$A9:8A4D A9 54 8A    LDA #$8A54             ;\
$A9:8A50 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8A54

$A9:8A53 60          RTS
}


;;; $8A54: Mother brain body subfunction - clear ceiling tube column 7 ;;;
{
$A9:8A54 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8A58             dx 07,02,B6B7          ;} Spawn PLM to clear ceiling tube
$A9:8A5C A9 69 8A    LDA #$8A69             ;\
$A9:8A5F 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8A69
$A9:8A62 A9 20 00    LDA #$0020             ;\
$A9:8A65 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Mother Brain body subfunction timer = 20h
$A9:8A68 60          RTS
}


;;; $8A69: Mother brain body subfunction - spawn top-middle-right tube falling enemy projectile ;;;
{
$A9:8A69 CE F2 0F    DEC $0FF2  [$7E:0FF2]  ; Decrement Mother Brain body subfunction timer
$A9:8A6C 10 17       BPL $17    [$8A85]     ; If [Mother Brain body subfunction timer] >= 0: return
$A9:8A6E A9 88 00    LDA #$0088             ;\
$A9:8A71 85 12       STA $12    [$7E:0012]  ;} $12 = 88h
$A9:8A73 A9 3B 00    LDA #$003B             ;\
$A9:8A76 85 14       STA $14    [$7E:0014]  ;} $14 = 3Bh
$A9:8A78 A0 85 CC    LDY #$CC85             ;\
$A9:8A7B 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's top-middle-right tube falling enemy projectile
$A9:8A7F A9 86 8A    LDA #$8A86             ;\
$A9:8A82 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8A86

$A9:8A85 60          RTS
}


;;; $8A86: Mother brain body subfunction - clear ceiling tube column 8 ;;;
{
$A9:8A86 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8A8A             dx 08,02,B6B7          ;} Spawn PLM to clear ceiling tube
$A9:8A8E A9 9B 8A    LDA #$8A9B             ;\
$A9:8A91 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8A9B
$A9:8A94 A9 20 00    LDA #$0020             ;\
$A9:8A97 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Mother Brain body subfunction timer = 20h
$A9:8A9A 60          RTS
}


;;; $8A9B: Mother brain body subfunction - spawn tubes falling enemy 3 ;;;
{
$A9:8A9B CE F2 0F    DEC $0FF2  [$7E:0FF2]  ; Decrement Mother Brain body subfunction timer
$A9:8A9E 10 0D       BPL $0D    [$8AAD]     ; If [Mother Brain body subfunction timer] >= 0: return
$A9:8AA0 A2 15 8B    LDX #$8B15             ;\
$A9:8AA3 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Mother Brain tubes falling enemy 3
$A9:8AA7 A9 AE 8A    LDA #$8AAE             ;\
$A9:8AAA 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8AAE

$A9:8AAD 60          RTS
}


;;; $8AAE: Mother brain body subfunction - clear bottom-middle-right tube ;;;
{
$A9:8AAE 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8AB2             dx 09,0A,B6BB          ;} Spawn PLM to clear Mother Brain's bottom-middle-side tube
$A9:8AB6 A9 C3 8A    LDA #$8AC3             ;\
$A9:8AB9 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8AC3
$A9:8ABC A9 02 00    LDA #$0002             ;\
$A9:8ABF 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Mother Brain body subfunction timer = 20h
$A9:8AC2 60          RTS
}


;;; $8AC3: Mother brain body subfunction - spawn tubes falling enemy 4 ;;;
{
$A9:8AC3 CE F2 0F    DEC $0FF2  [$7E:0FF2]  ; Decrement Mother Brain body subfunction timer
$A9:8AC6 10 0D       BPL $0D    [$8AD5]     ; If [Mother Brain body subfunction timer] >= 0: return
$A9:8AC8 A2 25 8B    LDX #$8B25             ;\
$A9:8ACB 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Mother Brain tubes falling enemy 4
$A9:8ACF A9 D6 8A    LDA #$8AD6             ;\
$A9:8AD2 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8AD6

$A9:8AD5 60          RTS
}


;;; $8AD6: Mother brain body subfunction - clear bottom-middle tubes ;;;
{
$A9:8AD6 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8ADA             dx 07,07,B6BF          ;} Spawn PLM to clear Mother Brain's bottom-middle tubes
$A9:8ADE A9 E4 8A    LDA #$8AE4             ;\
$A9:8AE1 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Mother Brain body subfunction = $8AE4
$A9:8AE4 60          RTS
}
}


;;; $8AE5: Mother Brain tubes falling enemy population entries ;;;
{
;                        ____________________________________ Enemy ID
;                       |     _______________________________ X position
;                       |    |     __________________________ Y position
;                       |    |    |     _____________________ Initialisation list pointer
;                       |    |    |    |     ________________ Properties
;                       |    |    |    |    |     ___________ Extra properties
;                       |    |    |    |    |    |     ______ Parameter 1
;                       |    |    |    |    |    |    |     _ Parameter 2
;                       |    |    |    |    |    |    |    |
$A9:8AE5             dw ECFF,0060,00B3,8C69,A000,0000,0000,0000 ; Bottom left
$A9:8AF5             dw ECFF,00A0,00B3,8C6F,A000,0000,0002,0000 ; Bottom right
$A9:8B05             dw ECFF,0068,00BB,8C75,A000,0000,0004,0000 ; Bottom-middle-left
$A9:8B15             dw ECFF,0098,00BB,8C7B,A000,0000,0006,0000 ; Bottom-middle-right
$A9:8B25             dw ECFF,0080,00A7,8C81,A800,0000,0008,0020 ; Main tube
}


;;; $8B35..8C86: Mother Brain tubes falling ;;;
{
;;; $8B35: Initialisation AI - enemy $ECFF (Mother Brain tubes falling) ;;;
{
$A9:8B35 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:8B38 BC B4 0F    LDY $0FB4,x[$7E:1034]  ; Y = [enemy parameter 1]
$A9:8B3B B9 5D 8B    LDA $8B5D,y[$A9:8B5D]  ;\
$A9:8B3E 9D 82 0F    STA $0F82,x[$7E:1002]  ;} Enemy X radius = [$8B5D + [Y]]
$A9:8B41 B9 67 8B    LDA $8B67,y[$A9:8B67]  ;\
$A9:8B44 9D 84 0F    STA $0F84,x[$7E:1004]  ;} Enemy Y radius = [$8B67 + [Y]]
$A9:8B47 B9 71 8B    LDA $8B71,y[$A9:8B71]  ;\
$A9:8B4A 9D AA 0F    STA $0FAA,x[$7E:102A]  ;} Enemy Y position threshold = [$8B71 + [Y]]
$A9:8B4D 9E AE 0F    STZ $0FAE,x[$7E:102E]  ; Enemy smoke timer = 0
$A9:8B50 9E B0 0F    STZ $0FB0,x[$7E:1030]  ; Enemy smoke counter = 0
$A9:8B53 9E AC 0F    STZ $0FAC,x[$7E:102C]  ; Enemy Y velocity = 0
$A9:8B56 B9 7B 8B    LDA $8B7B,y[$A9:8B7B]  ;\
$A9:8B59 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = [$8B7B + [Y]]
$A9:8B5C 6B          RTL

$A9:8B5D             dw 0010, 0010, 0008, 0008, 0010 ; X radius
$A9:8B67             dw 0020, 0020, 0018, 0018, 0020 ; Y radius
$A9:8B71             dw 00F8, 00F8, 00F0, 00F0, 00F6 ; Y position threshold
$A9:8B7B             dw 8B88, 8B88, 8B88, 8B88, 8BCB ; Function
}


;;; $8B85: Main AI - enemy $ECFF (Mother Brain tubes falling) ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:8B85 7C A8 0F    JMP ($0FA8,x)[$A9:8B88]; Go to [enemy function]
}


;;; $8B88: Mother Brain tubes falling function - non-main tube ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:8B88 BD AC 0F    LDA $0FAC,x[$7E:102C]  ;\
$A9:8B8B 18          CLC                    ;|
$A9:8B8C 69 06 00    ADC #$0006             ;} Enemy Y velocity += 6
$A9:8B8F 9D AC 0F    STA $0FAC,x[$7E:102C]  ;/
$A9:8B92 20 A9 C4    JSR $C4A9  [$A9:C4A9]  ; Enemy Y position += [enemy Y velocity] / 100h
$A9:8B95 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A9:8B98 DD AA 0F    CMP $0FAA,x[$7E:102A]  ;} If [enemy Y position] >= [enemy Y position threshold]: go to explode Mother Brain tube
$A9:8B9B 10 09       BPL $09    [$8BA6]     ;/
}


;;; $8B9D: Handle falling tube smoke ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:8B9D DE AE 0F    DEC $0FAE,x[$7E:102E]  ; Decrement enemy smoke timer
$A9:8BA0 10 03       BPL $03    [$8BA5]     ; If [enemy smoke timer] < 0:
$A9:8BA2 20 36 8C    JSR $8C36  [$A9:8C36]  ; Spawn falling tube smoke

$A9:8BA5 6B          RTL
}


;;; $8BA6: Explode Mother Brain tube ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:8BA6 BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A9:8BA9 09 00 02    ORA #$0200             ;} Flag enemy for deletion
$A9:8BAC 9D 86 0F    STA $0F86,x[$7E:1006]  ;/
$A9:8BAF BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A9:8BB2 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$A9:8BB4 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A9:8BB7 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$A9:8BB9 A9 03 00    LDA #$0003             ; A = 3 (small explosion)
$A9:8BBC A0 09 E5    LDY #$E509             ;\
$A9:8BBF 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:8BC3 A9 24 00    LDA #$0024             ;\
$A9:8BC6 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 24h, sound library 2, max queued sounds allowed = 3 (small explosion)
$A9:8BCA 6B          RTL
}


;;; $8BCB: Mother Brain tubes falling function - main tube - waiting to fall ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:8BCB DE B6 0F    DEC $0FB6,x[$7E:1076]  ; Decrement enemy parameter 2
$A9:8BCE 10 D5       BPL $D5    [$8BA5]     ; If [enemy parameter 2] >= 0: return
$A9:8BD0 A9 D6 8B    LDA #$8BD6             ;\
$A9:8BD3 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $8BD6 (falling)
}


;;; $8BD6: Mother Brain tubes falling function - main tube - falling ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:8BD6 BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A9:8BD9 18          CLC                    ;|
$A9:8BDA 69 06 00    ADC #$0006             ;} Enemy Y velocity += 6
$A9:8BDD 9D AC 0F    STA $0FAC,x[$7E:106C]  ;/
$A9:8BE0 20 A9 C4    JSR $C4A9  [$A9:C4A9]  ; Enemy Y position += [A] / 100h
$A9:8BE3 48          PHA
$A9:8BE4 C9 F4 00    CMP #$00F4             ;\
$A9:8BE7 30 09       BMI $09    [$8BF2]     ;} If [enemy Y position] >= F4h:
$A9:8BE9 BD 86 0F    LDA $0F86,x[$7E:1046]  ;\
$A9:8BEC 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A9:8BEF 9D 86 0F    STA $0F86,x[$7E:1046]  ;/

$A9:8BF2 68          PLA
$A9:8BF3 38          SEC                    ;\
$A9:8BF4 E9 38 00    SBC #$0038             ;|
$A9:8BF7 C9 C4 00    CMP #$00C4             ;} Mother Brain brain Y position = [enemy Y position] - 38h
$A9:8BFA 8D BE 0F    STA $0FBE  [$7E:0FBE]  ;/
$A9:8BFD 10 03       BPL $03    [$8C02]     ; If [Mother Brain brain Y position] < C4h:
$A9:8BFF 4C 9D 8B    JMP $8B9D  [$A9:8B9D]  ; Go to handle falling tube smoke

$A9:8C02 20 0C D0    JSR $D00C  [$A9:D00C]  ; End screen flashing
$A9:8C05 A9 19 00    LDA #$0019             ;\
$A9:8C08 22 0B F4 AD JSL $ADF40B[$AD:F40B]  ;} Enable earthquake type 19h for 20 frames (BG1, BG2 and enemies, 3 pixel displacement, vertical)
$A9:8C0C 9C B4 18    STZ $18B4  [$7E:18B4]  ; Delete HDMA object 0
$A9:8C0F 9C B6 18    STZ $18B6  [$7E:18B6]  ; Delete HDMA object 1
$A9:8C12 9E AC 0F    STZ $0FAC,x[$7E:10AA]  ; Enemy Y velocity = 0
$A9:8C15 A9 C4 00    LDA #$00C4             ;\
$A9:8C18 8D BE 0F    STA $0FBE  [$7E:0FBE]  ;} Mother Brain brain Y position = C4h
$A9:8C1B A9 3B 00    LDA #$003B             ;\
$A9:8C1E 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Mother Brain body X position = 3Bh
$A9:8C21 A9 17 01    LDA #$0117             ;\
$A9:8C24 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Mother Brain body Y position = 117h
$A9:8C27 20 3F 90    JSR $903F  [$A9:903F]  ; Set up Mother Brain's neck for fake death ascent
$A9:8C2A A9 87 8C    LDA #$8C87             ;\
$A9:8C2D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8C87 (fake death - ascent)
$A9:8C30 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:8C33 4C A6 8B    JMP $8BA6  [$A9:8BA6]  ; Go to explode Mother Brain tube
}


;;; $8C36: Spawn falling tube smoke ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:8C36 A9 08 00    LDA #$0008             ;\
$A9:8C39 9D AE 0F    STA $0FAE,x[$7E:102E]  ;} Enemy smoke timer = 8
$A9:8C3C BD B0 0F    LDA $0FB0,x[$7E:1030]  ;\
$A9:8C3F 1A          INC A                  ;|
$A9:8C40 29 03 00    AND #$0003             ;} Enemy smoke counter = ([enemy smoke counter] + 1) % 4
$A9:8C43 9D B0 0F    STA $0FB0,x[$7E:1030]  ;/
$A9:8C46 0A          ASL A                  ;\
$A9:8C47 A8          TAY                    ;|
$A9:8C48 B9 61 8C    LDA $8C61,y[$A9:8C63]  ;|
$A9:8C4B 18          CLC                    ;} $12 = [enemy X position] + [$8C61 + [enemy smoke counter] * 2]
$A9:8C4C 7D 7A 0F    ADC $0F7A,x[$7E:0FFA]  ;|
$A9:8C4F 85 12       STA $12    [$7E:0012]  ;/
$A9:8C51 A9 D0 00    LDA #$00D0             ;\
$A9:8C54 85 14       STA $14    [$7E:0014]  ;} $14 = D0h
$A9:8C56 A9 09 00    LDA #$0009             ; A = 9 (small dust cloud)
$A9:8C59 A0 09 E5    LDY #$E509             ;\
$A9:8C5C 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:8C60 60          RTS

$A9:8C61             dw FFF8, 0002, FFFC, 0006
}


;;; $8C69: Instruction list - Mother Brain tubes falling 0 ;;;
{
$A9:8C69             dx 0001,ADA1,
                        812F        ; Sleep
}


;;; $8C6F: Instruction list - Mother Brain tubes falling 1 ;;;
{
$A9:8C6F             dx 0001,ADD5,
                        812F        ; Sleep
}


;;; $8C75: Instruction list - Mother Brain tubes falling 2 ;;;
{
$A9:8C75             dx 0001,AE09,
                        812F        ; Sleep
}


;;; $8C7B: Instruction list - Mother Brain tubes falling 3 ;;;
{
$A9:8C7B             dx 0001,AE33,
                        812F        ; Sleep
}


;;; $8C81: Instruction list - Mother Brain tubes falling 4 ;;;
{
$A9:8C81             dx 0001,AE5D,
                        812F        ; Sleep
}
}


;;; $8C87: Mother Brain body function - fake death - ascent - draw room background on BG1 - rows 2/3 ;;;
{
$A9:8C87 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8C8B             dx 02,02,B67B          ;} Spawn Mother Brain's background row 2 PLM
$A9:8C8F 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8C93             dx 02,03,B67F          ;} Spawn Mother Brain's background row 3 PLM
$A9:8C97 A9 9E 8C    LDA #$8C9E             ;\
$A9:8C9A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8C9E
$A9:8C9D 60          RTS
}


;;; $8C9E: Mother Brain body function - fake death - ascent - draw room background on BG1 - rows 4/5 ;;;
{
$A9:8C9E 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8CA2             dx 02,04,B683          ;} Spawn Mother Brain's background row 4 PLM
$A9:8CA6 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8CAA             dx 02,05,B687          ;} Spawn Mother Brain's background row 5 PLM
$A9:8CAE A9 B5 8C    LDA #$8CB5             ;\
$A9:8CB1 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8CB5
$A9:8CB4 60          RTS
}


;;; $8CB5: Mother Brain body function - fake death - ascent - draw room background on BG1 - rows 6/7 ;;;
{
$A9:8CB5 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8CB9             dx 02,06,B68B          ;} Spawn Mother Brain's background row 6 PLM
$A9:8CBD 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8CC1             dx 02,07,B68F          ;} Spawn Mother Brain's background row 7 PLM
$A9:8CC5 A9 CC 8C    LDA #$8CCC             ;\
$A9:8CC8 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8CCC
$A9:8CCB 60          RTS
}


;;; $8CCC: Mother Brain body function - fake death - ascent - draw room background on BG1 - rows 8/9 ;;;
{
$A9:8CCC 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8CD0             dx 02,08,B693          ;} Spawn Mother Brain's background row 8 PLM
$A9:8CD4 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8CD8             dx 02,09,B697          ;} Spawn Mother Brain's background row 9 PLM
$A9:8CDC A9 E3 8C    LDA #$8CE3             ;\
$A9:8CDF 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8CE3
$A9:8CE2 60          RTS
}


;;; $8CE3: Mother Brain body function - fake death - ascent - draw room background on BG1 - rows Ah/Bh ;;;
{
$A9:8CE3 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8CE7             dx 02,0A,B69B          ;} Spawn Mother Brain's background row Ah PLM
$A9:8CEB 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8CEF             dx 02,0B,B69F          ;} Spawn Mother Brain's background row Bh PLM
$A9:8CF3 A9 FA 8C    LDA #$8CFA             ;\
$A9:8CF6 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8CFA
$A9:8CF9 60          RTS
}


;;; $8CFA: Mother Brain body function - fake death - ascent - draw room background on BG1 - rows Ch/Dh ;;;
{
$A9:8CFA 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8CFE             dx 02,0C,B6A3          ;} Spawn Mother Brain's background row Ch PLM
$A9:8D02 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:8D06             dx 02,0D,B6A7          ;} Spawn Mother Brain's background row Dh PLM
$A9:8D0A A9 11 8D    LDA #$8D11             ;\
$A9:8D0D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8D11
$A9:8D10 60          RTS
}


;;; $8D11: Mother Brain body function - fake death - ascent - set up Mother Brain phase 2 graphics ;;;
{
$A9:8D11 A9 01 01    LDA #$0101             ;\
$A9:8D14 8D 1B 09    STA $091B  [$7E:091B]  ;} Layer 2 scroll X = layer 2 scroll Y = 1 (library background, no scrolling)
$A9:8D17 A5 59       LDA $59    [$7E:0059]  ;\
$A9:8D19 29 FC FF    AND #$FFFC             ;} BG2 tilemap size = 32x32
$A9:8D1C 85 59       STA $59    [$7E:0059]  ;/
$A9:8D1E A0 B4 94    LDY #$94B4             ;\
$A9:8D21 A2 42 01    LDX #$0142             ;|
$A9:8D24 A9 0F 00    LDA #$000F             ;} Sprite palette 2 colours 1..Fh = [$94B4..D1] (Mother Brain's attacks)
$A9:8D27 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:8D2B A0 94 94    LDY #$9494             ;\
$A9:8D2E A2 62 01    LDX #$0162             ;|
$A9:8D31 A9 0F 00    LDA #$000F             ;} Sprite palette 3 colours 1..Fh = [$9494..B1] (Mother Brain's back leg)
$A9:8D34 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:8D38 A9 49 8D    LDA #$8D49             ;\
$A9:8D3B 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8D49
$A9:8D3E A9 01 00    LDA #$0001             ;\
$A9:8D41 8D 1E 0E    STA $0E1E  [$7E:0E1E]  ;} Request enemy BG2 tilemap VRAM transfer
$A9:8D44 8F 44 78 7E STA $7E7844[$7E:7844]  ; Enable unpause hook
$A9:8D48 60          RTS
}


;;; $8D49: Mother Brain body function - fake death - ascent - set up Mother Brain phase 2 brain ;;;
{
$A9:8D49 A9 34 00    LDA #$0034             ;\
$A9:8D4C 8D 82 19    STA $1982  [$7E:1982]  ;} Default layer blending configuration = 34h (disables colour math on BG2/BG3)
$A9:8D4F A9 A2 87    LDA #$87A2             ;\
$A9:8D52 8D E8 0F    STA $0FE8  [$7E:0FE8]  ;} Mother Brain brain function = $87A2 (set up brain and neck to be drawn)
$A9:8D55 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:8D58 29 FF FB    AND #$FBFF             ;} Set Mother Brain body as tangible
$A9:8D5B 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A9:8D5E AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A9:8D61 29 FF FB    AND #$FBFF             ;} Set Mother Brain brain as tangible
$A9:8D64 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A9:8D67 A9 50 46    LDA #$4650             ;\
$A9:8D6A 8D CC 0F    STA $0FCC  [$7E:0FCC]  ;} Mother Brain brain health = 18,000
$A9:8D6D A9 79 8D    LDA #$8D79             ;\
$A9:8D70 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8D79
$A9:8D73 A9 80 00    LDA #$0080             ;\
$A9:8D76 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 80h
}


;;; $8D79: Mother Brain body function - fake death - ascent - pause for suspense ;;;
{
$A9:8D79 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:8D7C 30 01       BMI $01    [$8D7F]     ; If [Mother Brain body function timer] >= 0:
$A9:8D7E 60          RTS                    ; Return

$A9:8D7F A9 8B 8D    LDA #$8D8B             ;\
$A9:8D82 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8D8B
$A9:8D85 A9 20 00    LDA #$0020             ;\
$A9:8D88 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 20h
}


;;; $8D8B: Mother Brain body function - fake death - ascent - prepare Mother Brain for rising ;;;
{
$A9:8D8B CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:8D8E 30 01       BMI $01    [$8D91]     ; If [Mother Brain body function timer] >= 0:
$A9:8D90 60          RTS                    ; Return

$A9:8D91 22 1E E7 88 JSL $88E71E[$88:E71E]  ; Spawn Mother Brain rising HDMA object
$A9:8D95 8F 12 78 7E STA $7E7812[$7E:7812]  ; Mother Brain HDMA object index = HDMA object index
$A9:8D99 AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A9:8D9C 09 00 01    ORA #$0100             ;} Set Mother Brain brain as invisible
$A9:8D9F 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A9:8DA2 A9 21 9C    LDA #$9C21             ;\
$A9:8DA5 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C21 (initial)
$A9:8DA8 A9 B4 8D    LDA #$8DB4             ;\
$A9:8DAB 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8DB4
$A9:8DAE A9 00 01    LDA #$0100             ;\
$A9:8DB1 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 100h
}


;;; $8DB4: Mother Brain body function - fake death - ascent - load Mother Brain's legs tiles ;;;
{
$A9:8DB4 A2 8F 8F    LDX #$8F8F             ;\
$A9:8DB7 20 BE C5    JSR $C5BE  [$A9:C5BE]  ;} Load Mother Brain's legs tiles
$A9:8DBA B0 01       BCS $01    [$8DBD]     ; If not finished loading:
$A9:8DBC 60          RTS                    ; Return

$A9:8DBD A9 C3 8D    LDA #$8DC3             ;\
$A9:8DC0 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8DC3
}


;;; $8DC3: Mother Brain body function - fake death - ascent - continue pausing for suspense ;;;
{
$A9:8DC3 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:8DC6 10 23       BPL $23    [$8DEB]     ; If [Mother Brain body function timer] >= 0: return
$A9:8DC8 A9 3B 00    LDA #$003B             ;\
$A9:8DCB 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Mother Brain body X position = 3Bh
$A9:8DCE A9 17 01    LDA #$0117             ;\
$A9:8DD1 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Mother Brain body Y position = 117h
$A9:8DD4 A9 E5 FF    LDA #$FFE5             ;\
$A9:8DD7 85 B5       STA $B5    [$7E:00B5]  ;} BG2 X scroll = -1Bh
$A9:8DD9 A9 27 FF    LDA #$FF27             ;\
$A9:8DDC 85 B7       STA $B7    [$7E:00B7]  ;} BG2 Y scroll = -D9h
$A9:8DDE A9 07 00    LDA #$0007             ;\
$A9:8DE1 8F 08 78 7E STA $7E7808[$7E:7808]  ;} Enable all Mother Brain hitboxes
$A9:8DE5 A9 EC 8D    LDA #$8DEC             ;\
$A9:8DE8 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8DEC

$A9:8DEB 60          RTS
}


;;; $8DEC: Mother Brain body function - fake death - ascent - start music and earthquake ;;;
{
$A9:8DEC A9 02 9A    LDA #$9A02             ;\
$A9:8DEF 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to $9A02 (crouched)
$A9:8DF2 A9 01 00    LDA #$0001             ;\
$A9:8DF5 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Mother Brain brain instruction timer = 1
$A9:8DF8 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:8DFB 29 FF FE    AND #$FEFF             ;} Set Mother Brain body as visible
$A9:8DFE 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A9:8E01 A9 3B 00    LDA #$003B             ;\
$A9:8E04 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Mother Brain body X position = 3Bh
$A9:8E07 A9 17 01    LDA #$0117             ;\
$A9:8E0A 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Mother Brain body Y position = 117h
$A9:8E0D A9 E5 FF    LDA #$FFE5             ;\
$A9:8E10 85 B5       STA $B5    [$7E:00B5]  ;} BG2 X scroll = -1Bh
$A9:8E12 A9 27 FF    LDA #$FF27             ;\
$A9:8E15 85 B7       STA $B7    [$7E:00B7]  ;} BG2 Y scroll = -D9h
$A9:8E17 A9 05 00    LDA #$0005             ;\
$A9:8E1A 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track
$A9:8E1E A9 02 00    LDA #$0002             ;\
$A9:8E21 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 1 pixel displacement, diagonal
$A9:8E24 A9 00 01    LDA #$0100             ;\
$A9:8E27 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 100h
$A9:8E2A A9 50 00    LDA #$0050             ;\
$A9:8E2D 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 50h
$A9:8E31 A9 01 00    LDA #$0001             ;\
$A9:8E34 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:8E38 A9 08 00    LDA #$0008             ;\
$A9:8E3B 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 8 (raise)
$A9:8E3F A9 06 00    LDA #$0006             ;\
$A9:8E42 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 6 (lower)
$A9:8E46 A9 4D 8E    LDA #$8E4D             ;\
$A9:8E49 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8E4D
$A9:8E4C 60          RTS
}


;;; $8E4D: Mother Brain body function - fake death - ascent - raise Mother Brain ;;;
{
$A9:8E4D AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A9:8E50 29 03 00    AND #$0003             ;} If [frame counter] % 4 != 0: return
$A9:8E53 D0 46       BNE $46    [$8E9B]     ;/
$A9:8E55 20 46 8F    JSR $8F46  [$A9:8F46]  ; Spawn dust clouds for Mother Brain's ascent
$A9:8E58 A9 02 00    LDA #$0002             ;\
$A9:8E5B 85 12       STA $12    [$7E:0012]  ;} $12 = 2
$A9:8E5D A5 B7       LDA $B7    [$7E:00B7]  ;\
$A9:8E5F 18          CLC                    ;|
$A9:8E60 65 12       ADC $12    [$7E:0012]  ;} BG2 Y scroll += 2
$A9:8E62 85 B7       STA $B7    [$7E:00B7]  ;/
$A9:8E64 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A9:8E67 38          SEC                    ;|
$A9:8E68 E5 12       SBC $12    [$7E:0012]  ;} Mother Brain body Y position -= 2
$A9:8E6A 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A9:8E6D C9 BD 00    CMP #$00BD             ;\
$A9:8E70 B0 29       BCS $29    [$8E9B]     ;} If [Mother Brain body Y position] >= BDh: return
$A9:8E72 A9 40 01    LDA #$0140             ;\
$A9:8E75 8D 9A 17    STA $179A  [$7E:179A]  ;} Enemy BG2 tilemap size = 140h
$A9:8E78 A9 BC 00    LDA #$00BC             ;\
$A9:8E7B 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Mother Brain body Y position = BCh
$A9:8E7E 9C 40 18    STZ $1840  [$7E:1840]  ; Earthquake timer = 0
$A9:8E81 AF 12 78 7E LDA $7E7812[$7E:7812]  ;\
$A9:8E85 AA          TAX                    ;} Delete Mother Brain HDMA object
$A9:8E86 9E B4 18    STZ $18B4,x[$7E:18B4]  ;/
$A9:8E89 A9 AA 99    LDA #$99AA             ;\
$A9:8E8C 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to $99AA (standing up after crouching - slow)
$A9:8E8F A9 95 8E    LDA #$8E95             ;\
$A9:8E92 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8E95
}


;;; $8E95: Mother Brain body function - fake death - ascent - wait until Mother Brain has finished uncrouching ;;;
{
$A9:8E95 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:8E99 F0 01       BEQ $01    [$8E9C]     ;} If [Mother Brain's pose] != standing:
$A9:8E9B 60          RTS                    ; Return

$A9:8E9C 8F 2E 80 7E STA $7E802E[$7E:802E]  ; Mother Brain grey transition counter = 0
$A9:8EA0 A9 AA 8E    LDA #$8EAA             ;\
$A9:8EA3 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8EAA
$A9:8EA6 9C B2 0F    STZ $0FB2  [$7E:0FB2]  ; Mother Brain body function timer = 0
$A9:8EA9 60          RTS
}


;;; $8EAA: Mother Brain body function - fake death - ascent - transition Mother Brain from grey and lower her head ;;;
{
$A9:8EAA CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:8EAD 10 45       BPL $45    [$8EF4]     ; If [Mother Brain body function timer] >= 0: return
$A9:8EAF A9 04 00    LDA #$0004             ;\
$A9:8EB2 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 4
$A9:8EB5 AF 2E 80 7E LDA $7E802E[$7E:802E]  ;\
$A9:8EB9 1A          INC A                  ;} Increment Mother Brain grey transition counter
$A9:8EBA 8F 2E 80 7E STA $7E802E[$7E:802E]  ;/
$A9:8EBE 3A          DEC A                  ; A = [Mother Brain grey transition counter] - 1
$A9:8EBF 22 EA EE AD JSL $ADEEEA[$AD:EEEA]  ; Transition Mother Brain palette from grey
$A9:8EC3 90 2F       BCC $2F    [$8EF4]     ; If not finished transition: return
$A9:8EC5 A9 01 00    LDA #$0001             ;\
$A9:8EC8 8F 60 78 7E STA $7E7860[$7E:7860]  ;} Enable Mother Brain brain palette handling
$A9:8ECC 1A          INC A                  ;\
$A9:8ECD 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Mother Brain's form = second phase
$A9:8ED1 3A          DEC A                  ;\
$A9:8ED2 8F 64 78 7E STA $7E7864[$7E:7864]  ;} Enable Mother Brain's drool generation
$A9:8ED6 A9 06 00    LDA #$0006             ;\
$A9:8ED9 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 6 (lower)
$A9:8EDD 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 6 (lower)
$A9:8EE1 A9 00 05    LDA #$0500             ;\
$A9:8EE4 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 500h
$A9:8EE8 A9 F5 8E    LDA #$8EF5             ;\
$A9:8EEB 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8EF5
$A9:8EEE A9 17 00    LDA #$0017             ;\
$A9:8EF1 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 17h

$A9:8EF4 60          RTS
}


;;; $8EF5: Mother Brain body function - second phase - stretching - shake head menacingly ;;;
{
$A9:8EF5 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:8EF8 30 01       BMI $01    [$8EFB]     ; If [Mother Brain body function timer] >= 0:
$A9:8EFA 60          RTS                    ; Return

$A9:8EFB A9 7F 9B    LDA #$9B7F             ;\
$A9:8EFE 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9B7F (stretching)
$A9:8F01 A9 14 8F    LDA #$8F14             ;\
$A9:8F04 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8F14
$A9:8F07 A9 40 00    LDA #$0040             ;\
$A9:8F0A 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 40h
$A9:8F0E A9 00 01    LDA #$0100             ;\
$A9:8F11 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 100h
}


;;; $8F14: Mother Brain body function - second phase - stretching - bring head back up ;;;
{
$A9:8F14 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:8F17 10 2C       BPL $2C    [$8F45]     ; If [Mother Brain body function timer] >= 0: return
$A9:8F19 A9 02 00    LDA #$0002             ;\
$A9:8F1C 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 2 (bob down)
$A9:8F20 A9 04 00    LDA #$0004             ;\
$A9:8F23 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 4 (bob up)
$A9:8F27 A9 33 8F    LDA #$8F33             ;\
$A9:8F2A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $8F33
$A9:8F2D A9 40 00    LDA #$0040             ;\
$A9:8F30 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 40h
}


;;; $8F33: Mother Brain body function - second phase - stretching - finish stretching ;;;
{
$A9:8F33 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:8F36 10 0D       BPL $0D    [$8F45]     ; If [Mother Brain body function timer] >= 0: return
$A9:8F38 A9 01 00    LDA #$0001             ;\
$A9:8F3B 8F 68 78 7E STA $7E7868[$7E:7868]  ;} Enable Mother Brain's small purple breath generation
$A9:8F3F A9 05 B6    LDA #$B605             ;\
$A9:8F42 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B605

$A9:8F45 60          RTS
}


;;; $8F46: Spawn dust clouds for Mother Brain's ascent ;;;
{
$A9:8F46 CE F2 0F    DEC $0FF2  [$7E:0FF2]  ;\
$A9:8F49 10 06       BPL $06    [$8F51]     ;|
$A9:8F4B A9 07 00    LDA #$0007             ;} Mother Brain body subfunction timer = ([Mother Brain body subfunction timer] - 1) % 8
$A9:8F4E 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;/

$A9:8F51 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A9:8F54 0A          ASL A                  ;|
$A9:8F55 AA          TAX                    ;} $12 = [$8F7F + [Mother Brain body subfunction timer] * 2]
$A9:8F56 BD 7F 8F    LDA $8F7F,x[$A9:8F8D]  ;|
$A9:8F59 85 12       STA $12    [$7E:0012]  ;/
$A9:8F5B A9 D4 00    LDA #$00D4             ;\
$A9:8F5E 85 14       STA $14    [$7E:0014]  ;} $14 = D4h
$A9:8F60 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:8F63 29 00 01    AND #$0100             ;|
$A9:8F66 EB          XBA                    ;|
$A9:8F67 AA          TAX                    ;} A = [$8F7D + ([random number] >> 8) % 2]
$A9:8F68 BD 7D 8F    LDA $8F7D,x[$A9:8F7D]  ;|
$A9:8F6B 29 FF 00    AND #$00FF             ;/
$A9:8F6E A0 09 E5    LDY #$E509             ;\
$A9:8F71 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile with parameter [A]
$A9:8F75 A9 29 00    LDA #$0029             ;\
$A9:8F78 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 29h, sound library 2, max queued sounds allowed = 3 (Mother Brain rising into phase 2)
$A9:8F7C 60          RTS

; Explosion type. 9 = small dust cloud, Ch = smoke
$A9:8F7D             db 09, 12

; Explosion X positions
$A9:8F7F             dw 003D, 0054, 0020, 0035, 005A, 0043, 0067, 0029
}
}


;;; $8F8F: Mother Brain fight sprite tile transfer entries ;;;
{
;                        _______________ Size. Zero terminator
;                       |     __________ Source address
;                       |    |       ___ VRAM address
;                       |    |      |
; Mother Brain's legs
$A9:8F8F             dx 0200,B79000,7400,
                        0200,B79200,7500,
                        0200,B79400,7600,
                        0200,B79600,7700,
                        0200,B79800,7800,
                        0200,B79A00,7900,
                        0200,B79C00,7A00,
                        0200,B79E00,7B00

; Bomb shells, death beam, unused graphics
$A9:8FC7             dx 0200,B7A000,7C00,
                        0200,B7A200,7D00,
                        0200,B7A400,7E00,
                        0200,B7A600,7F00,
                        0000

; Shitroid
$A9:8FE5             dx 0200,B18800,7C00,
                        0200,B18A00,7D00,
                        0200,B18C00,7E00,
                        0200,B18E00,7F00,
                        0000

; Mother Brain's corpse
$A9:9003             dx 01C0,B7CE00,7A00,
                        01C0,B7D000,7B00,
                        01C0,B7D200,7C00,
                        01C0,B7D400,7D00,
                        01C0,B7D600,7E00,
                        01C0,B7D800,7F00,
                        0000

; Exploded escape door particles
$A9:902F             dx 0200,ABF400,7000,
                        0200,ABF600,7100,
                        0000
}


;;; $903F: Set up Mother Brain's neck for fake death ascent ;;;
{
$A9:903F A9 02 00    LDA #$0002             ;\
$A9:9042 8F 48 80 7E STA $7E8048[$7E:8048]  ;} Mother Brain's neck segment 0 distance = 2
$A9:9046 A9 0A 00    LDA #$000A             ;\
$A9:9049 8F 4E 80 7E STA $7E804E[$7E:804E]  ;} Mother Brain's neck segment 1/3 distance = 10
$A9:904D 8F 5A 80 7E STA $7E805A[$7E:805A]  ;/
$A9:9051 A9 14 00    LDA #$0014             ;\
$A9:9054 8F 54 80 7E STA $7E8054[$7E:8054]  ;} Mother Brain's neck segment 2/4 distance = 20
$A9:9058 8F 60 80 7E STA $7E8060[$7E:8060]  ;/
$A9:905C A9 00 48    LDA #$4800             ;\
$A9:905F 8F 40 80 7E STA $7E8040[$7E:8040]  ;} Mother Brain's lower neck angle = 4800h
$A9:9063 A9 00 50    LDA #$5000             ;\
$A9:9066 8F 42 80 7E STA $7E8042[$7E:8042]  ;} Mother Brain's upper neck angle = 5000h
$A9:906A A9 00 01    LDA #$0100             ;\
$A9:906D 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 100h
$A9:9071 60          RTS
}


;;; $9072: Handle Mother Brain's neck - lower ;;;
{
$A9:9072 AF 64 80 7E LDA $7E8064[$7E:8064]  ;\
$A9:9076 AA          TAX                    ;} Go to [$907A + [Mother Brain lower neck movement index]]
$A9:9077 7C 7A 90    JMP ($907A,x)[$A9:90EC];/

$A9:907A             dw 9084, 9085, 90A2, 90CF, 90EC
}


;;; $9084: RTS. Handle Mother Brain's neck - lower - movement index = 0: nothing ;;;
{
$A9:9084 60          RTS
}


;;; $9085: Handle Mother Brain's neck - lower - movement index = 2: bob down ;;;
{
$A9:9085 AF 40 80 7E LDA $7E8040[$7E:8040]  ;\
$A9:9089 38          SEC                    ;} Mother Brain's lower neck angle -= [Mother Brain neck angle delta]
$A9:908A EF 68 80 7E SBC $7E8068[$7E:8068]  ;/
$A9:908E C9 00 28    CMP #$2800             ;\
$A9:9091 B0 0A       BCS $0A    [$909D]     ;} If [Mother Brain's lower neck angle] < 2800h:
$A9:9093 A9 04 00    LDA #$0004             ;\
$A9:9096 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 4 (bob up)
$A9:909A A9 00 28    LDA #$2800             ; Mother Brain's lower neck angle = 2800h

$A9:909D 8F 40 80 7E STA $7E8040[$7E:8040]
$A9:90A1 60          RTS
}


;;; $90A2: Handle Mother Brain's neck - lower - movement index = 4: bob up ;;;
{
$A9:90A2 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:90A5 C9 3C 00    CMP #$003C             ;} If [Mother Brain brain Y position] < 3Ch: go to BRANCH_BOB_DOWN
$A9:90A8 30 1D       BMI $1D    [$90C7]     ;/
$A9:90AA AF 40 80 7E LDA $7E8040[$7E:8040]  ;\
$A9:90AE 18          CLC                    ;} Mother Brain's lower neck angle += [Mother Brain neck angle delta]
$A9:90AF 6F 68 80 7E ADC $7E8068[$7E:8068]  ;/
$A9:90B3 C9 00 90    CMP #$9000             ;\
$A9:90B6 90 0A       BCC $0A    [$90C2]     ;} If [Mother Brain's lower neck angle] >= 9000h:
$A9:90B8 A9 02 00    LDA #$0002             ;\
$A9:90BB 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 2 (bob down)
$A9:90BF A9 00 90    LDA #$9000             ; Mother Brain's lower neck angle = 9000h

$A9:90C2 8F 40 80 7E STA $7E8040[$7E:8040]
$A9:90C6 60          RTS                    ; Return

; BRANCH_BOB_DOWN
$A9:90C7 A9 02 00    LDA #$0002             ;\
$A9:90CA 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 2 (bob down)
$A9:90CE 60          RTS
}


;;; $90CF: Handle Mother Brain's neck - lower - movement index = 6: lower ;;;
{
$A9:90CF AF 40 80 7E LDA $7E8040[$7E:8040]  ;\
$A9:90D3 38          SEC                    ;} Mother Brain's lower neck angle -= [Mother Brain neck angle delta]
$A9:90D4 EF 68 80 7E SBC $7E8068[$7E:8068]  ;/
$A9:90D8 C9 00 30    CMP #$3000             ;\
$A9:90DB B0 0A       BCS $0A    [$90E7]     ;} If [Mother Brain's lower neck angle] < 3000h:
$A9:90DD A9 00 00    LDA #$0000             ;\
$A9:90E0 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 0 (nothing)
$A9:90E4 A9 00 30    LDA #$3000             ; Mother Brain's lower neck angle = 3000h

$A9:90E7 8F 40 80 7E STA $7E8040[$7E:8040]
$A9:90EB 60          RTS
}


;;; $90EC: Handle Mother Brain's neck - lower - movement index = 8: raise ;;;
{
$A9:90EC AF 40 80 7E LDA $7E8040[$7E:8040]  ;\
$A9:90F0 18          CLC                    ;} Mother Brain's lower neck angle += [Mother Brain neck angle delta]
$A9:90F1 6F 68 80 7E ADC $7E8068[$7E:8068]  ;/
$A9:90F5 C9 00 90    CMP #$9000             ;\
$A9:90F8 90 0A       BCC $0A    [$9104]     ;} If [Mother Brain's lower neck angle] >= 9000h:
$A9:90FA A9 00 00    LDA #$0000             ;\
$A9:90FD 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 0 (nothing)
$A9:9101 A9 00 90    LDA #$9000             ; Mother Brain's lower neck angle = 9000h

$A9:9104 8F 40 80 7E STA $7E8040[$7E:8040]
$A9:9108 60          RTS
}


;;; $9109: Handle Mother Brain's neck - upper ;;;
{
$A9:9109 AF 66 80 7E LDA $7E8066[$7E:8066]  ;\
$A9:910D AA          TAX                    ;} Go to [$9111 + [Mother Brain upper neck movement index]]
$A9:910E 7C 11 91    JMP ($9111,x)[$A9:9176];/

$A9:9111             dw 911B, 911C, 9151, 9176, 9193
}


;;; $911B: RTS. Handle Mother Brain's neck - upper - movement index = 0: nothing ;;;
{
$A9:911B 60          RTS
}


;;; $911C: Handle Mother Brain's neck - upper - movement index = 2: bob down ;;;
{
$A9:911C AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:911F 18          CLC                    ;|
$A9:9120 69 04 00    ADC #$0004             ;} If [Mother Brain brain Y position] + 4 >= [Samus Y position]:
$A9:9123 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;|
$A9:9126 30 0C       BMI $0C    [$9134]     ;/
$A9:9128 A9 04 00    LDA #$0004             ;\
$A9:912B 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 4 (bob up)
$A9:912F 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 4 (bob up)
$A9:9133 60          RTS                    ; Return

$A9:9134 AF 42 80 7E LDA $7E8042[$7E:8042]  ;\
$A9:9138 38          SEC                    ;} Mother Brain's upper neck angle -= [Mother Brain neck angle delta]
$A9:9139 EF 68 80 7E SBC $7E8068[$7E:8068]  ;/
$A9:913D C9 00 20    CMP #$2000             ;\
$A9:9140 B0 0A       BCS $0A    [$914C]     ;} If [Mother Brain's upper neck angle] < 2000h:
$A9:9142 A9 04 00    LDA #$0004             ;\
$A9:9145 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 4 (bob up)
$A9:9149 A9 00 20    LDA #$2000             ; Mother Brain's upper neck angle = 2000h

$A9:914C 8F 42 80 7E STA $7E8042[$7E:8042]
$A9:9150 60          RTS
}


;;; $9151: Handle Mother Brain's neck - upper - movement index = 4: bob up ;;;
{
$A9:9151 AF 40 80 7E LDA $7E8040[$7E:8040]  ;\
$A9:9155 18          CLC                    ;|
$A9:9156 69 00 08    ADC #$0800             ;} $12 = [Mother Brain's lower neck angle] + 800h
$A9:9159 85 12       STA $12    [$7E:0012]  ;/
$A9:915B AF 42 80 7E LDA $7E8042[$7E:8042]  ;\
$A9:915F 18          CLC                    ;} Mother Brain's upper neck angle += [Mother Brain neck angle delta]
$A9:9160 6F 68 80 7E ADC $7E8068[$7E:8068]  ;/
$A9:9164 C5 12       CMP $12    [$7E:0012]  ;\
$A9:9166 90 09       BCC $09    [$9171]     ;} If [Mother Brain's upper neck angle] >= [$12]:
$A9:9168 A9 02 00    LDA #$0002             ;\
$A9:916B 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 2 (bob down)
$A9:916F A5 12       LDA $12    [$7E:0012]  ; Mother Brain's upper neck angle = [$12]

$A9:9171 8F 42 80 7E STA $7E8042[$7E:8042]
$A9:9175 60          RTS
}


;;; $9176: Handle Mother Brain's neck - upper - movement index = 6: lower ;;;
{
$A9:9176 AF 42 80 7E LDA $7E8042[$7E:8042]  ;\
$A9:917A 38          SEC                    ;} Mother Brain's upper neck angle -= [Mother Brain neck angle delta]
$A9:917B EF 68 80 7E SBC $7E8068[$7E:8068]  ;/
$A9:917F C9 00 20    CMP #$2000             ;\
$A9:9182 B0 0A       BCS $0A    [$918E]     ;} If [Mother Brain's upper neck angle] < 2000h:
$A9:9184 A9 00 00    LDA #$0000             ;\
$A9:9187 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 0 (nothing)
$A9:918B A9 00 20    LDA #$2000             ; Mother Brain's upper neck angle = 2000h

$A9:918E 8F 42 80 7E STA $7E8042[$7E:8042]
$A9:9192 60          RTS
}


;;; $9193: Handle Mother Brain's neck - upper - movement index = 8: raise ;;;
{
$A9:9193 AF 40 80 7E LDA $7E8040[$7E:8040]  ;\
$A9:9197 18          CLC                    ;|
$A9:9198 69 00 08    ADC #$0800             ;} $12 = [Mother Brain's lower neck angle] + 800h
$A9:919B 85 12       STA $12    [$7E:0012]  ;/
$A9:919D AF 42 80 7E LDA $7E8042[$7E:8042]  ;\
$A9:91A1 18          CLC                    ;} Mother Brain's upper neck angle += [Mother Brain neck angle delta]
$A9:91A2 6F 68 80 7E ADC $7E8068[$7E:8068]  ;/
$A9:91A6 C5 12       CMP $12    [$7E:0012]  ;\
$A9:91A8 90 09       BCC $09    [$91B3]     ;} If [Mother Brain's upper neck angle] >= [$12]:
$A9:91AA A9 00 00    LDA #$0000             ;\
$A9:91AD 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 0 (nothing)
$A9:91B1 A5 12       LDA $12    [$7E:0012]  ; Mother Brain's upper neck angle = [$12]

$A9:91B3 8F 42 80 7E STA $7E8042[$7E:8042]
$A9:91B7 60          RTS
}


;;; $91B8: Handle Mother Brain's neck ;;;
{
; See "MB reference point.png" about $7E:7814/16

$A9:91B8 A9 B0 FF    LDA #$FFB0             ;\
$A9:91BB 18          CLC                    ;|
$A9:91BC 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;} $7E:7814 = [Mother Brain body X position] - 50h
$A9:91BF 8F 14 78 7E STA $7E7814[$7E:7814]  ;/
$A9:91C3 A9 2E 00    LDA #$002E             ;\
$A9:91C6 18          CLC                    ;|
$A9:91C7 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;} $7E:7816 = [Mother Brain body Y position] + 2Eh
$A9:91CA 8F 16 78 7E STA $7E7816[$7E:7816]  ;/
$A9:91CE AF 62 80 7E LDA $7E8062[$7E:8062]  ;\
$A9:91D2 F0 06       BEQ $06    [$91DA]     ;} If Mother Brain neck movement enabled:
$A9:91D4 20 72 90    JSR $9072  [$A9:9072]  ; Handle Mother Brain's neck - lower
$A9:91D7 20 09 91    JSR $9109  [$A9:9109]  ; Handle Mother Brain's neck - upper

$A9:91DA AF 41 80 7E LDA $7E8041[$7E:8041]  ;\
$A9:91DE 29 FF 00    AND #$00FF             ;} $12 = [Mother Brain's lower neck angle] / 100h
$A9:91E1 85 12       STA $12    [$7E:0012]  ;/
$A9:91E3 AF 48 80 7E LDA $7E8048[$7E:8048]  ;\
$A9:91E7 22 60 C4 A9 JSL $A9C460[$A9:C460]  ;|
$A9:91EB 18          CLC                    ;|
$A9:91EC 6F 14 78 7E ADC $7E7814[$7E:7814]  ;} Mother Brain's neck segment 0 X position = [$7E:7814] + 70h + ±[Mother Brain's neck segment 0 distance] * sin([$12] * pi / 80h)
$A9:91F0 18          CLC                    ;|
$A9:91F1 69 70 00    ADC #$0070             ;|
$A9:91F4 8F 44 80 7E STA $7E8044[$7E:8044]  ;/
$A9:91F8 AF 48 80 7E LDA $7E8048[$7E:8048]  ;\
$A9:91FC 22 65 C4 A9 JSL $A9C465[$A9:C465]  ;|
$A9:9200 18          CLC                    ;|
$A9:9201 6F 16 78 7E ADC $7E7816[$7E:7816]  ;} Mother Brain's neck segment 0 Y position = [$7E:7816] - 60h + ±[Mother Brain's neck segment 0 distance] * cos([$12] * pi / 80h)
$A9:9205 18          CLC                    ;|
$A9:9206 69 A0 FF    ADC #$FFA0             ;|
$A9:9209 8F 46 80 7E STA $7E8046[$7E:8046]  ;/
$A9:920D AF 4E 80 7E LDA $7E804E[$7E:804E]  ;\
$A9:9211 22 60 C4 A9 JSL $A9C460[$A9:C460]  ;|
$A9:9215 18          CLC                    ;|
$A9:9216 6F 14 78 7E ADC $7E7814[$7E:7814]  ;} Mother Brain's neck segment 1 X position = [$7E:7814] + 70h + ±[Mother Brain's neck segment 1 distance] * sin([$12] * pi / 80h)
$A9:921A 18          CLC                    ;|
$A9:921B 69 70 00    ADC #$0070             ;|
$A9:921E 8F 4A 80 7E STA $7E804A[$7E:804A]  ;/
$A9:9222 AF 4E 80 7E LDA $7E804E[$7E:804E]  ;\
$A9:9226 22 65 C4 A9 JSL $A9C465[$A9:C465]  ;|
$A9:922A 18          CLC                    ;|
$A9:922B 6F 16 78 7E ADC $7E7816[$7E:7816]  ;} Mother Brain's neck segment 1 Y position = [$7E:7816] - 60h + ±[Mother Brain's neck segment 1 distance] * cos([$12] * pi / 80h)
$A9:922F 18          CLC                    ;|
$A9:9230 69 A0 FF    ADC #$FFA0             ;|
$A9:9233 8F 4C 80 7E STA $7E804C[$7E:804C]  ;/
$A9:9237 AF 54 80 7E LDA $7E8054[$7E:8054]  ;\
$A9:923B 22 60 C4 A9 JSL $A9C460[$A9:C460]  ;|
$A9:923F 18          CLC                    ;|
$A9:9240 6F 14 78 7E ADC $7E7814[$7E:7814]  ;} Mother Brain's neck segment 2 X position = [$7E:7814] + 70h + ±[Mother Brain's neck segment 2 distance] * sin([$12] * pi / 80h)
$A9:9244 18          CLC                    ;|
$A9:9245 69 70 00    ADC #$0070             ;|
$A9:9248 8F 50 80 7E STA $7E8050[$7E:8050]  ;/
$A9:924C AF 54 80 7E LDA $7E8054[$7E:8054]  ;\
$A9:9250 22 65 C4 A9 JSL $A9C465[$A9:C465]  ;|
$A9:9254 18          CLC                    ;|
$A9:9255 6F 16 78 7E ADC $7E7816[$7E:7816]  ;} Mother Brain's neck segment 2 Y position = [$7E:7816] - 60h + ±[Mother Brain's neck segment 2 distance] * cos([$12] * pi / 80h)
$A9:9259 18          CLC                    ;|
$A9:925A 69 A0 FF    ADC #$FFA0             ;|
$A9:925D 8F 52 80 7E STA $7E8052[$7E:8052]  ;/
$A9:9261 AF 43 80 7E LDA $7E8043[$7E:8043]  ;\
$A9:9265 29 FF 00    AND #$00FF             ;} $12 = [Mother Brain's upper neck angle] / 100h
$A9:9268 85 12       STA $12    [$7E:0012]  ;/
$A9:926A AF 5A 80 7E LDA $7E805A[$7E:805A]  ;\
$A9:926E 22 60 C4 A9 JSL $A9C460[$A9:C460]  ;|
$A9:9272 18          CLC                    ;} Mother Brain's neck segment 3 X position = [Mother Brain's neck segment 2 X position] + ±[Mother Brain's neck segment 3 distance] * sin([$12] * pi / 80h)
$A9:9273 6F 50 80 7E ADC $7E8050[$7E:8050]  ;|
$A9:9277 8F 56 80 7E STA $7E8056[$7E:8056]  ;/
$A9:927B AF 5A 80 7E LDA $7E805A[$7E:805A]  ;\
$A9:927F 22 65 C4 A9 JSL $A9C465[$A9:C465]  ;|
$A9:9283 18          CLC                    ;} Mother Brain's neck segment 3 Y position = [Mother Brain's neck segment 2 Y position] + ±[Mother Brain's neck segment 3 distance] * cos([$12] * pi / 80h)
$A9:9284 6F 52 80 7E ADC $7E8052[$7E:8052]  ;|
$A9:9288 8F 58 80 7E STA $7E8058[$7E:8058]  ;/
$A9:928C AF 60 80 7E LDA $7E8060[$7E:8060]  ;\
$A9:9290 22 60 C4 A9 JSL $A9C460[$A9:C460]  ;|
$A9:9294 18          CLC                    ;} Mother Brain's neck segment 4 X position = [Mother Brain's neck segment 2 X position] + ±[Mother Brain's neck segment 4 distance] * sin([$12] * pi / 80h)
$A9:9295 6F 50 80 7E ADC $7E8050[$7E:8050]  ;|
$A9:9299 8F 5C 80 7E STA $7E805C[$7E:805C]  ;/
$A9:929D AF 60 80 7E LDA $7E8060[$7E:8060]  ;\
$A9:92A1 22 65 C4 A9 JSL $A9C465[$A9:C465]  ;|
$A9:92A5 18          CLC                    ;} Mother Brain's neck segment 4 Y position = [Mother Brain's neck segment 2 Y position] + ±[Mother Brain's neck segment 4 distance] * cos([$12] * pi / 80h)
$A9:92A6 6F 52 80 7E ADC $7E8052[$7E:8052]  ;|
$A9:92AA 8F 5E 80 7E STA $7E805E[$7E:805E]  ;/
$A9:92AE 60          RTS
}


;;; $92AF: Y = Mother Brain brain spritemap pointer ;;;
{
$A9:92AF AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$A9:92B2 D0 08       BNE $08    [$92BC]     ;} If time is frozen: go to BRANCH_FROZEN_TIME
$A9:92B4 AF 02 80 7E LDA $7E8002[$7E:8002]  ;\
$A9:92B8 30 0D       BMI $0D    [$92C7]     ;} If [Mother Brain brain instruction list pointer] & 8000h != 0: go to BRANCH_PROCESS_INSTRUCTION_LIST

; BRANCH_NO_DRAW
$A9:92BA 68          PLA                    ; Set return to caller's return
$A9:92BB 60          RTS                    ; Return

; BRANCH_FROZEN_TIME
$A9:92BC AF 02 80 7E LDA $7E8002[$7E:8002]  ;\
$A9:92C0 10 F8       BPL $F8    [$92BA]     ;} If [Mother Brain brain instruction list pointer] & 8000h = 0: go to BRANCH_NO_DRAW
$A9:92C2 AA          TAX                    ;\
$A9:92C3 BC 02 00    LDY $0002,x            ;} Y = [[Mother Brain brain instruction list pointer] + 2]
$A9:92C6 60          RTS                    ; Return

; BRANCH_PROCESS_INSTRUCTION_LIST
$A9:92C7 AA          TAX                    ; X = [Mother Brain brain instruction list pointer]
$A9:92C8 BD 00 00    LDA $0000,x[$A9:9C21]  ;\
$A9:92CB 30 0F       BMI $0F    [$92DC]     ;} If [[X]] & 8000h != 0: go to BRANCH_ASM_INSTRUCTION
$A9:92CD CF 00 80 7E CMP $7E8000[$7E:8000]  ;\
$A9:92D1 10 23       BPL $23    [$92F6]     ;} If [[X]] >= [Mother Brain brain instruction timer]: go to BRANCH_TICK
$A9:92D3 E8          INX                    ;\
$A9:92D4 E8          INX                    ;|
$A9:92D5 E8          INX                    ;} X += 4
$A9:92D6 E8          INX                    ;/

; LOOP
$A9:92D7 BD 00 00    LDA $0000,x[$A9:9C25]  ;\
$A9:92DA 10 0A       BPL $0A    [$92E6]     ;} If [[X]] & 8000h = 0: go to BRANCH_SPECIAL_INSTRUCTION

; BRANCH_ASM_INSTRUCTION
$A9:92DC 85 00       STA $00    [$7E:0000]
$A9:92DE E8          INX                    ;\
$A9:92DF E8          INX                    ;} X += 2
$A9:92E0 F4 D6 92    PEA $92D6              ; Return to LOOP
$A9:92E3 6C 00 00    JMP ($0000)[$A9:9B0F]  ; Go to [A]

; BRANCH_SPECIAL_INSTRUCTION
$A9:92E6 A9 01 00    LDA #$0001             ;\
$A9:92E9 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Mother Brain brain instruction timer = 1
$A9:92ED 8A          TXA                    ;\
$A9:92EE 8F 02 80 7E STA $7E8002[$7E:8002]  ;} Mother Brain brain instruction list pointer = [X]
$A9:92F2 BC 02 00    LDY $0002,x[$A9:9C23]  ; Y = [[X] + 2]
$A9:92F5 60          RTS                    ; Return

; BRANCH_TICK
$A9:92F6 AF 00 80 7E LDA $7E8000[$7E:8000]  ;\
$A9:92FA 1A          INC A                  ;} Increment Mother Brain brain instruction timer
$A9:92FB 8F 00 80 7E STA $7E8000[$7E:8000]  ;/
$A9:92FF BC 02 00    LDY $0002,x[$A9:9C23]  ; Y = [[X] + 2]
$A9:9302 60          RTS
}


;;; $9303: Draw Mother Brain's neck ;;;
{
$A9:9303 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:9306 29 00 01    AND #$0100             ;} If Mother Brain body is invisible:
$A9:9309 F0 01       BEQ $01    [$930C]     ;/
$A9:930B 60          RTS                    ; Return

$A9:930C AF 5C 80 7E LDA $7E805C[$7E:805C]  ;\
$A9:9310 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain's neck segment 4 X position]
$A9:9312 AF 5E 80 7E LDA $7E805E[$7E:805E]  ;\
$A9:9316 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain's neck segment 4 Y position]
$A9:9318 20 CB 93    JSR $93CB  [$A9:93CB]  ; Draw Mother Brain neck segment
$A9:931B AF 56 80 7E LDA $7E8056[$7E:8056]  ;\
$A9:931F 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain's neck segment 3 X position]
$A9:9321 AF 58 80 7E LDA $7E8058[$7E:8058]  ;\
$A9:9325 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain's neck segment 3 Y position]
$A9:9327 20 CB 93    JSR $93CB  [$A9:93CB]  ; Draw Mother Brain neck segment
$A9:932A AF 50 80 7E LDA $7E8050[$7E:8050]  ;\
$A9:932E 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain's neck segment 2 X position]
$A9:9330 AF 52 80 7E LDA $7E8052[$7E:8052]  ;\
$A9:9334 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain's neck segment 2 Y position]
$A9:9336 20 CB 93    JSR $93CB  [$A9:93CB]  ; Draw Mother Brain neck segment
$A9:9339 AF 4A 80 7E LDA $7E804A[$7E:804A]  ;\
$A9:933D 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain's neck segment 1 X position]
$A9:933F AF 4C 80 7E LDA $7E804C[$7E:804C]  ;\
$A9:9343 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain's neck segment 1 Y position]
$A9:9345 20 CB 93    JSR $93CB  [$A9:93CB]  ; Draw Mother Brain neck segment
$A9:9348 AF 44 80 7E LDA $7E8044[$7E:8044]  ;\
$A9:934C 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain's neck segment 0 X position]
$A9:934E AF 46 80 7E LDA $7E8046[$7E:8046]  ;\
$A9:9352 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain's neck segment 0 Y position]
$A9:9354 4C CB 93    JMP $93CB  [$A9:93CB]  ; Go to draw Mother Brain neck segment
}


;;; $9357: Draw Mother Brain brain ;;;
{
; Note that the call to $92AF can return out of *this* routine if no spritemap is to be drawn,
; and is assuming that nothing gets pushed to the stack by this routine
; (and also assuming this routine returns by RTS)
$A9:9357 AF 68 78 7E LDA $7E7868[$7E:7868]  ;\
$A9:935B F0 12       BEQ $12    [$936F]     ;} If Mother Brain's small purple breath generation is enabled:
$A9:935D AF 6A 78 7E LDA $7E786A[$7E:786A]  ;\
$A9:9361 D0 0C       BNE $0C    [$936F]     ;} If Mother Brain's small purple breath is not active:
$A9:9363 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:9366 30 07       BMI $07    [$936F]     ;} If [random number] & 8000h = 0:
$A9:9368 A0 3D CB    LDY #$CB3D             ;\
$A9:936B 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's purple breath - small enemy projectile

$A9:936F 20 AF 92    JSR $92AF  [$A9:92AF]  ; Y = Mother Brain brain spritemap pointer
$A9:9372 AF 1A 78 7E LDA $7E781A[$7E:781A]  ;\
$A9:9376 AA          TAX                    ;} $16 = [Mother Brain brain palette index]
$A9:9377 AD DC 0F    LDA $0FDC  [$7E:0FDC]  ;\
$A9:937A 4A          LSR A                  ;} If [Mother Brain brain invincibility timer] & 1 != 0:
$A9:937B 90 03       BCC $03    [$9380]     ;/
$A9:937D A2 00 00    LDX #$0000             ; $16 = 0

$A9:9380 86 16       STX $16    [$7E:0016]
$A9:9382 AF 40 78 7E LDA $7E7840[$7E:7840]  ;\
$A9:9386 F0 07       BEQ $07    [$938F]     ;} If [Mother Brain brain main shake timer] != 0:
$A9:9388 3A          DEC A                  ;\
$A9:9389 8F 40 78 7E STA $7E7840[$7E:7840]  ;} Decrement Mother Brain brain main shake timer
$A9:938D 80 08       BRA $08    [$9397]
                                            ; Else ([Mother Brain brain main shake timer] = 0):
$A9:938F AD DC 0F    LDA $0FDC  [$7E:0FDC]  ; A = [Mother Brain brain invincibility timer]
$A9:9392 D0 03       BNE $03    [$9397]     ; If [Mother Brain brain invincibility timer] = 0:
$A9:9394 AD E2 0F    LDA $0FE2  [$7E:0FE2]  ; A = [Mother Brain brain shake timer]

$A9:9397 29 06 00    AND #$0006             ;\
$A9:939A AA          TAX                    ;} X = [A] & 6
$A9:939B BD BB 93    LDA $93BB,x[$A9:93BB]  ;\
$A9:939E 18          CLC                    ;|
$A9:939F 6D BA 0F    ADC $0FBA  [$7E:0FBA]  ;} $12 = [Mother Brain brain X position] + [$93BB + [X]] (shake X offset)
$A9:93A2 85 12       STA $12    [$7E:0012]  ;/
$A9:93A4 18          CLC                    ;\
$A9:93A5 69 20 00    ADC #$0020             ;|
$A9:93A8 38          SEC                    ;} If [$12] + 20h - [layer 1 X position] < 0: return
$A9:93A9 ED 11 09    SBC $0911  [$7E:0911]  ;|
$A9:93AC 30 0C       BMI $0C    [$93BA]     ;/
$A9:93AE BD C3 93    LDA $93C3,x[$A9:93C5]  ;\
$A9:93B1 18          CLC                    ;|
$A9:93B2 6D BE 0F    ADC $0FBE  [$7E:0FBE]  ;} $14 = [Mother Brain brain Y position] + [$93C3 + [X]] (shake Y offset)
$A9:93B5 85 14       STA $14    [$7E:0014]  ;/
$A9:93B7 4C EE 93    JMP $93EE  [$A9:93EE]  ; Go to add spritemap to OAM

$A9:93BA 60          RTS
}


;;; $93BB: Shaking offsets ;;;
{
; Used for Mother Brain brain shaking and when Shitroid shakes
$A9:93BB             dw 0000, FFFF, 0000, 0001  ; X offsets
$A9:93C3             dw 0000, 0001, FFFF, 0001  ; Y offsets
}


;;; $93CB: Draw Mother Brain neck segment ;;;
{
;; Parameters:
;;     $12: Neck segment X position
;;     $14: Neck segment Y position
$A9:93CB AD DC 0F    LDA $0FDC  [$7E:0FDC]  ;\
$A9:93CE 29 06 00    AND #$0006             ;} X = [Mother Brain brain invincibility timer] & 6
$A9:93D1 AA          TAX                    ;/
$A9:93D2 BD BB 93    LDA $93BB,x[$A9:93BB]  ;\
$A9:93D5 18          CLC                    ;|
$A9:93D6 65 12       ADC $12    [$7E:0012]  ;} $12 += [$93BB + [X]] (shake X offset)
$A9:93D8 85 12       STA $12    [$7E:0012]  ;/
$A9:93DA BD C3 93    LDA $93C3,x[$A9:93C3]  ;\
$A9:93DD 18          CLC                    ;|
$A9:93DE 65 14       ADC $14    [$7E:0014]  ;} $14 += [$93C3 + [X]] (shake Y offset)
$A9:93E0 85 14       STA $14    [$7E:0014]  ;/
$A9:93E2 AF 18 78 7E LDA $7E7818[$7E:7818]  ;\
$A9:93E6 85 16       STA $16    [$7E:0016]  ;} $16 = [Mother Brain's neck palette index]
$A9:93E8 A0 94 A6    LDY #$A694             ; Y = $A694 (neck segment)
$A9:93EB 4C EE 93    JMP $93EE  [$A9:93EE]  ; Go to add spritemap to OAM
}


;;; $93EE: Add spritemap to OAM ;;;
{
;; Parameters:
;;     DB:Y: Address of first entry in spritemap
;;     $12: Spritemap Y origin
;;     $14: Spritemap X origin
;;     $16: Palette bits of sprite (palette * 200h)

; Compared to the usual 'add spritemap to OAM' routine,
; this one's X/Y position parameters ($12/14) are room co-ordinates rather than screen co-ordinates,
; and this one doesn't draw sprites that start above the screen (and otherwise has no off-screen handling)

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

$A9:93EE B9 00 00    LDA $0000,y[$A9:D761]  ; $18 = [[Y]] (number of entries)
$A9:93F1 C8          INY                    ;\
$A9:93F2 C8          INY                    ;} Y += 2
$A9:93F3 85 18       STA $18    [$7E:0018]
$A9:93F5 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$A9:93F8 18          CLC

; LOOP
$A9:93F9 B9 01 00    LDA $0001,y[$A9:D764]  ;\
$A9:93FC 29 00 FF    AND #$FF00             ;|
$A9:93FF 10 03       BPL $03    [$9404]     ;|
$A9:9401 09 FF 00    ORA #$00FF             ;|
                                            ;|
$A9:9404 EB          XBA                    ;} $1A = ±[[Y] + 2] + [$14] - [layer 1 Y position]
$A9:9405 18          CLC                    ;|
$A9:9406 65 14       ADC $14    [$7E:0014]  ;|
$A9:9408 38          SEC                    ;|
$A9:9409 ED 15 09    SBC $0915  [$7E:0915]  ;/
$A9:940C 30 4A       BMI $4A    [$9458]     ; If [$1A] < 0: go to BRANCH_NEXT
$A9:940E 85 1A       STA $1A    [$7E:001A]
$A9:9410 B9 00 00    LDA $0000,y[$A9:D763]  ;\
$A9:9413 65 12       ADC $12    [$7E:0012]  ;|
$A9:9415 38          SEC                    ;} OAM entry X position = [[Y]] + [$12] - [layer 1 X position]
$A9:9416 ED 11 09    SBC $0911  [$7E:0911]  ;|
$A9:9419 9D 70 03    STA $0370,x[$7E:03FC]  ;/
$A9:941C 29 00 01    AND #$0100             ;\
$A9:941F F0 0E       BEQ $0E    [$942F]     ;} If [OAM entry X position] & 100h:
$A9:9421 BF 9F 85 81 LDA $81859F,x[$81:869B];\
$A9:9425 85 1C       STA $1C    [$7E:001C]  ;|
$A9:9427 B2 1C       LDA ($1C)  [$7E:057E]  ;} Set OAM entry high X position bit
$A9:9429 1F 9F 83 81 ORA $81839F,x[$81:849B];|
$A9:942D 92 1C       STA ($1C)  [$7E:057E]  ;/

$A9:942F B9 00 00    LDA $0000,y[$A9:D763]  ;\
$A9:9432 10 0E       BPL $0E    [$9442]     ;} If [[Y]] & 8000h (size bit) != 0:
$A9:9434 BF 9F 85 81 LDA $81859F,x[$81:862F];\
$A9:9438 85 1C       STA $1C    [$7E:001C]  ;|
$A9:943A B2 1C       LDA ($1C)  [$7E:0578]  ;} Set OAM entry size bit
$A9:943C 1F A1 83 81 ORA $8183A1,x[$81:8431];|
$A9:9440 92 1C       STA ($1C)  [$7E:0578]  ;/

$A9:9442 A5 1A       LDA $1A    [$7E:001A]  ;\
$A9:9444 9D 71 03    STA $0371,x[$7E:03FD]  ;} OAM entry Y position = [$1A]
$A9:9447 B9 03 00    LDA $0003,y[$A9:D766]  ;\
$A9:944A 05 16       ORA $16    [$7E:0016]  ;} OAM entry tile number and attributes = [[Y] + 3] | [$16]
$A9:944C 9D 72 03    STA $0372,x[$7E:03FE]  ;/
$A9:944F 8A          TXA                    ;\
$A9:9450 18          CLC                    ;|
$A9:9451 69 04 00    ADC #$0004             ;} X = ([X] + 4) % 200h (next OAM index)
$A9:9454 29 FF 01    AND #$01FF             ;|
$A9:9457 AA          TAX                    ;/

; BRANCH_NEXT
$A9:9458 98          TYA                    ;\
$A9:9459 18          CLC                    ;|
$A9:945A 69 05 00    ADC #$0005             ;} Y += 5 (next sprite map entry)
$A9:945D A8          TAY                    ;/
$A9:945E C6 18       DEC $18    [$7E:0018]  ; Decrement $18 (number of entries)
$A9:9460 D0 97       BNE $97    [$93F9]     ; If [$18] != 0: go to LOOP
$A9:9462 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$A9:9465 60          RTS
}


;;; $9466: Calculate Mother Brain rainbow beam HDMA tables ;;;
{
$A9:9466 8B          PHB
$A9:9467 F4 00 AD    PEA $AD00              ;\
$A9:946A AB          PLB                    ;} DB = $AD
$A9:946B AB          PLB                    ;/
$A9:946C 22 00 DE AD JSL $ADDE00[$AD:DE00]  ; Calculate Mother Brain rainbow beam HDMA tables
$A9:9470 AB          PLB
$A9:9471 6B          RTL
}


;;; $9472: Palette - enemy $EC3F/$EC7F/$ECFF (Mother Brain) ;;;
{
$A9:9472             dw 3800, 269F, 0159, 004C, 0004, 5739, 4273, 2DAD, 14C6, 367F, 29F9, 2173, 150C, 0C86, 7FFF, 0000
}


;;; $9492: Mother Brain palettes ;;;
{
; Colour 0 is never read

; Sprite palette 3 - Mother Brain's back leg
$A9:9492             dw 3800, 0000, 0000, 0000, 0024, 29AD, 214A, 14E7, 0C63, 0000, 0000, 0000, 0000, 0000, 29AD, 0000

; Sprite palette 2 - Mother Brain's attacks
$A9:94B2             dw 3800, 7FE0, 6B20, 5640, 03FF, 02BF, 015F, 001F, 29F9, 2173, 150C, 6318, 4631, 294A, 7FFF, 0C63

; Sprite palette 7 - Shitroid
$A9:94D2             dw 3800, 57B8, 0B11, 1646, 00E3, 72FF, 2CDF, 24B9, 1CAF, 18A9, 4F9F, 3ED8, 2E12, 08CD, 7FFF, 0000

; Sprite palette 7 - tube enemy projectiles
$A9:94F2             dw 3800, 6318, 6318, 0802, 5294, 39CE, 2108, 1084, 0019, 0012, 5C00, 4000, 1084, 197F, 7FFF, 0000

; Sprite palette 3 - glass shards
$A9:9512             dw 3800, 5294, 39CE, 2108, 7F8B, 6F0A, 5E88, 4E07, 3986, 2905, 1883, 0802, 1084, 6318, 7FFF, 0000

; Sprite palette 1 - exploded escape door particles
$A9:9532             dw 3800, 4D1F, 38B6, 246E, 1448, 47FF, 2EFA, 1616, 0132, 5294, 4210, 318C, 2108, 1084, 7FFF, 0000
}


;;; $9552: Move Mother Brain body down by [A], scroll it left by [X] ;;;
{
; This function expects X to have been pushed
$A9:9552 48          PHA                    ;\
$A9:9553 18          CLC                    ;|
$A9:9554 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;} Mother Brain body Y position += [A]
$A9:9557 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;|
$A9:955A 68          PLA                    ;/
$A9:955B 49 FF FF    EOR #$FFFF             ;\
$A9:955E 1A          INC A                  ;|
$A9:955F 18          CLC                    ;} BG2 Y scroll -= [A]
$A9:9560 65 B7       ADC $B7    [$7E:00B7]  ;|
$A9:9562 85 B7       STA $B7    [$7E:00B7]  ;/
$A9:9564 8A          TXA                    ;\
$A9:9565 18          CLC                    ;|
$A9:9566 69 22 00    ADC #$0022             ;|
$A9:9569 85 14       STA $14    [$7E:0014]  ;|
$A9:956B AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A9:956E 49 FF FF    EOR #$FFFF             ;} BG2 X scroll = 22h - [Mother Brain body X position] + [X]
$A9:9571 1A          INC A                  ;|
$A9:9572 18          CLC                    ;|
$A9:9573 65 14       ADC $14    [$7E:0014]  ;|
$A9:9575 85 B5       STA $B5    [$7E:00B5]  ;/
$A9:9577 FA          PLX
$A9:9578 6B          RTL
}


;;; $9579: Move Mother Brain body down by [A] ;;;
{
$A9:9579 48          PHA                    ;\
$A9:957A 18          CLC                    ;|
$A9:957B 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;} Mother Brain body Y position += [A]
$A9:957E 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;|
$A9:9581 68          PLA                    ;/
$A9:9582 49 FF FF    EOR #$FFFF             ;\
$A9:9585 1A          INC A                  ;|
$A9:9586 18          CLC                    ;} BG2 Y scroll -= [A]
$A9:9587 65 B7       ADC $B7    [$7E:00B7]  ;|
$A9:9589 85 B7       STA $B7    [$7E:00B7]  ;/
$A9:958B A9 00 00    LDA #$0000             ;\
$A9:958E 38          SEC                    ;|
$A9:958F ED 7A 0F    SBC $0F7A  [$7E:0F7A]  ;|
$A9:9592 18          CLC                    ;} BG2 X scroll = 22h - [Mother Brain body X position]
$A9:9593 69 22 00    ADC #$0022             ;|
$A9:9596 85 B5       STA $B5    [$7E:00B5]  ;/
$A9:9598 6B          RTL
}


;;; $9599: Mother Brain footstep effect ;;;
{
; Callers are setting A before calling this routine... Oh well
; The sound effect (that doesn't play) is a crunchy footstep that plays when Mother Brain is being attacked by Shitroid
$A9:9599 A9 01 00    LDA #$0001             ;\
$A9:959C 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 1 pixel displacement, vertical
$A9:959F A9 04 00    LDA #$0004             ;\
$A9:95A2 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 4
$A9:95A5 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A9:95A9 C9 03 00    CMP #$0003             ;} If [Mother Brain's form] = drained by Shitroid:
$A9:95AC D0 07       BNE $07    [$95B5]     ;/
$A9:95AE A9 16 00    LDA #$0016             ;\
$A9:95B1 8F 4D 91 80 STA $80914D[$80:914D]  ;} Typo. Should be JSL for queue sound 16h, sound library 3, max queued sounds allowed = 6

$A9:95B5 60          RTS
}


;;; $95B6..972F: Instructions - Mother Brain body ;;;
{
;;; $95B6: Instruction - move Mother Brain body up by 10px, scroll it left by 4px ;;;
{
$A9:95B6 DA          PHX
$A9:95B7 A2 04 00    LDX #$0004
$A9:95BA A9 F6 FF    LDA #$FFF6
$A9:95BD 4C 52 95    JMP $9552  [$A9:9552]
}


;;; $95C0: Instruction - move Mother Brain body up by 16px, scroll it left by 4px ;;;
{
$A9:95C0 DA          PHX
$A9:95C1 A2 04 00    LDX #$0004
$A9:95C4 A9 F0 FF    LDA #$FFF0
$A9:95C7 4C 52 95    JMP $9552  [$A9:9552]
}


;;; $95CA: Instruction - move Mother Brain body up by 12px, scroll it right by 2px ;;;
{
$A9:95CA DA          PHX
$A9:95CB A2 FE FF    LDX #$FFFE
$A9:95CE A9 F4 FF    LDA #$FFF4
$A9:95D1 4C 52 95    JMP $9552  [$A9:9552]
}


;;; $95D4: Unused. Instruction - scroll Mother Brain body right by 2px ;;;
{
$A9:95D4 DA          PHX
$A9:95D5 A2 FE FF    LDX #$FFFE
$A9:95D8 A9 00 00    LDA #$0000
$A9:95DB 4C 52 95    JMP $9552  [$A9:9552]
}


;;; $95DE: Instruction - move Mother Brain body down by 12px, scroll it left by 4px ;;;
{
$A9:95DE DA          PHX
$A9:95DF A2 04 00    LDX #$0004
$A9:95E2 A9 0C 00    LDA #$000C
$A9:95E5 4C 52 95    JMP $9552  [$A9:9552]
}


;;; $95E8: Instruction - move Mother Brain body down by 16px, scroll it right by 2px ;;;
{
$A9:95E8 DA          PHX
$A9:95E9 A2 FE FF    LDX #$FFFE
$A9:95EC A9 10 00    LDA #$0010
$A9:95EF 4C 52 95    JMP $9552  [$A9:9552]
}


;;; $95F2: Instruction - move Mother Brain body down by 10px, scroll it right by 2px ;;;
{
$A9:95F2 DA          PHX
$A9:95F3 A2 FE FF    LDX #$FFFE
$A9:95F6 A9 0A 00    LDA #$000A
$A9:95F9 4C 52 95    JMP $9552  [$A9:9552]
}


;;; $95FC: Instruction - move Mother Brain body up by 2px and right by 1px ;;;
{
$A9:95FC AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:95FF 18          CLC                    ;|
$A9:9600 69 01 00    ADC #$0001             ;} Mother Brain body X position += 1
$A9:9603 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:9606 A9 FE FF    LDA #$FFFE             ;\
$A9:9609 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 2
}


;;; $960C: Instruction - move Mother Brain body right by 2px ;;;
{
$A9:960C AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:960F 18          CLC                    ;|
$A9:9610 69 02 00    ADC #$0002             ;} Mother Brain body X position += 2
$A9:9613 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:9616 A9 00 00    LDA #$0000             ;\
$A9:9619 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 0
}


;;; $961C: Instruction - move Mother Brain body up by 1px ;;;
{
$A9:961C A9 01 00    LDA #$0001             ;\
$A9:961F 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 1
}


;;; $9622: Instruction - move Mother Brain body up by 1px and right by 3px, do footstep effect ;;;
{
$A9:9622 A9 22 00    LDA #$0022
$A9:9625 20 99 95    JSR $9599  [$A9:9599]  ; Mother Brain footstep effect
$A9:9628 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:962B 18          CLC                    ;|
$A9:962C 69 03 00    ADC #$0003             ;} Mother Brain body X position += 3
$A9:962F 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:9632 A9 01 00    LDA #$0001             ;\
$A9:9635 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 1
}


;;; $9638: Instruction - move Mother Brain body down by 2px and right by 15px ;;;
{
$A9:9638 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:963B 18          CLC                    ;|
$A9:963C 69 0F 00    ADC #$000F             ;} Mother Brain body X position += 15
$A9:963F 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:9642 A9 FE FF    LDA #$FFFE             ;\
$A9:9645 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body down by 2
}


;;; $9648: Instruction - move Mother Brain body down by 4px and right by 6px ;;;
{
$A9:9648 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:964B 18          CLC                    ;|
$A9:964C 69 06 00    ADC #$0006             ;} Mother Brain body X position += 6
$A9:964F 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:9652 A9 FC FF    LDA #$FFFC             ;\
$A9:9655 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body down by 4
}


;;; $9658: Instruction - move Mother Brain body up by 4px and left by 2px ;;;
{
$A9:9658 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:965B 18          CLC                    ;|
$A9:965C 69 FE FF    ADC #$FFFE             ;} Mother Brain body X position -= 2
$A9:965F 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:9662 A9 04 00    LDA #$0004             ;\
$A9:9665 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 4
}


;;; $9668: Instruction - move Mother Brain body up by 2px and left by 1px, do footstep effect ;;;
{
$A9:9668 A9 EF FF    LDA #$FFEF
$A9:966B 20 99 95    JSR $9599  [$A9:9599]  ; Mother Brain footstep effect
$A9:966E AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:9671 18          CLC                    ;|
$A9:9672 69 FF FF    ADC #$FFFF             ;} Mother Brain body X position -= 1
$A9:9675 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:9678 A9 02 00    LDA #$0002             ;\
$A9:967B 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 2
}


;;; $967E: Instruction - move Mother Brain body up by 2px and left by 1px, do footstep effect ;;;
{
$A9:967E A9 0B 00    LDA #$000B
$A9:9681 20 99 95    JSR $9599  [$A9:9599]  ; Mother Brain footstep effect
$A9:9684 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:9687 38          SEC                    ;|
$A9:9688 E9 01 00    SBC #$0001             ;} Mother Brain body X position -= 1
$A9:968B 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:968E A9 02 00    LDA #$0002             ;\
$A9:9691 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 2
}


;;; $9694: Instruction - move Mother Brain body left by 2px ;;;
{
$A9:9694 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:9697 38          SEC                    ;|
$A9:9698 E9 02 00    SBC #$0002             ;} Mother Brain body X position -= 2
$A9:969B 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:969E A9 00 00    LDA #$0000             ;\
$A9:96A1 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 0
}


;;; $96A4: Instruction - move Mother Brain body down by 1px ;;;
{
$A9:96A4 A9 FF FF    LDA #$FFFF             ;\
$A9:96A7 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body down by 1
}


;;; $96AA: Instruction - move Mother Brain body down by 1px and left by 3px ;;;
{
$A9:96AA AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:96AD 38          SEC                    ;|
$A9:96AE E9 03 00    SBC #$0003             ;} Mother Brain body X position -= 3
$A9:96B1 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:96B4 A9 FF FF    LDA #$FFFF             ;\
$A9:96B7 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body down by 1
}


;;; $96BA: Instruction - move Mother Brain body up by 2px and left by 15px, do footstep effect ;;;
{
$A9:96BA A9 DB FF    LDA #$FFDB
$A9:96BD 20 99 95    JSR $9599  [$A9:9599]  ; Mother Brain footstep effect
$A9:96C0 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:96C3 38          SEC                    ;|
$A9:96C4 E9 0F 00    SBC #$000F             ;} Mother Brain body X position -= 15
$A9:96C7 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:96CA A9 02 00    LDA #$0002             ;\
$A9:96CD 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 2
}


;;; $96D0: Instruction - move Mother Brain body up by 4px and left by 6px ;;;
{
$A9:96D0 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:96D3 38          SEC                    ;|
$A9:96D4 E9 06 00    SBC #$0006             ;} Mother Brain body X position -= 6
$A9:96D7 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:96DA A9 04 00    LDA #$0004             ;\
$A9:96DD 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body up by 4
}


;;; $96E0: Instruction - move Mother Brain body down by 4px and right by 2px ;;;
{
$A9:96E0 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:96E3 38          SEC                    ;|
$A9:96E4 E9 FE FF    SBC #$FFFE             ;} Mother Brain body X position += 2
$A9:96E7 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:96EA A9 FC FF    LDA #$FFFC             ;\
$A9:96ED 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body down by 4
}


;;; $96F0: Instruction - move Mother Brain body down by 2px and right by 1px ;;;
{
$A9:96F0 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:96F3 38          SEC                    ;|
$A9:96F4 E9 FF FF    SBC #$FFFF             ;} Mother Brain body X position += 1
$A9:96F7 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A9:96FA A9 FE FF    LDA #$FFFE             ;\
$A9:96FD 4C 79 95    JMP $9579  [$A9:9579]  ;} Go to move Mother Brain body down by 2
}


;;; $9700: Instruction - Mother Brain's pose = standing ;;;
{
$A9:9700 A9 00 00    LDA #$0000
$A9:9703 8F 04 78 7E STA $7E7804[$7E:7804]
$A9:9707 6B          RTL
}


;;; $9708: Instruction - Mother Brain's pose = walking ;;;
{
$A9:9708 A9 01 00    LDA #$0001
$A9:970B 8F 04 78 7E STA $7E7804[$7E:7804]
$A9:970F 6B          RTL
}


;;; $9710: Instruction - Mother Brain's pose = crouched ;;;
{
$A9:9710 A9 03 00    LDA #$0003
$A9:9713 8F 04 78 7E STA $7E7804[$7E:7804]
$A9:9717 6B          RTL
}


;;; $9718: Instruction - Mother Brain's pose = crouching transition ;;;
{
$A9:9718 A9 02 00    LDA #$0002
$A9:971B 8F 04 78 7E STA $7E7804[$7E:7804]
$A9:971F 6B          RTL
}


;;; $9720: Instruction - Mother Brain's pose = death beam mode ;;;
{
$A9:9720 A9 04 00    LDA #$0004
$A9:9723 8F 04 78 7E STA $7E7804[$7E:7804]
$A9:9727 6B          RTL
}


;;; $9728: Instruction - Mother Brain's pose = leaning down ;;;
{
$A9:9728 A9 06 00    LDA #$0006
$A9:972B 8F 04 78 7E STA $7E7804[$7E:7804]
$A9:972F 6B          RTL
}
}


;;; $9730..9AC7: Instruction lists - Mother Brain body ;;;
{
;;; $9730: Instruction list - Mother Brain body - walking forwards - really fast ;;;
{
$A9:9730             dx 9708,       ; Mother Brain's pose = walking
                        0002,9FA0,
                        95FC,       ; Move Mother Brain body up by 2px and right by 1px
                        0002,9FEA,
                        960C,       ; Move Mother Brain body right by 2px
                        0002,A03C,
                        961C,       ; Move Mother Brain body up by 1px
                        0002,A08E,
                        9622,       ; Move Mother Brain body up by 1px and right by 3px, do footstep effect
                        0002,A0E0,
                        9638,       ; Move Mother Brain body down by 2px and right by 15px
                        0002,A12A,
                        9648,       ; Move Mother Brain body down by 4px and right by 6px
                        0002,A174,
                        9658,       ; Move Mother Brain body up by 4px and left by 2px
                        0002,A1BE,
                        9668,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        0002,A208,
                        812F        ; Sleep
}


;;; $976A: Instruction list - Mother Brain body - walking forwards - fast ;;;
{
$A9:976A             dx 9708,       ; Mother Brain's pose = walking
                        0004,9FA0,
                        95FC,       ; Move Mother Brain body up by 2px and right by 1px
                        0004,9FEA,
                        960C,       ; Move Mother Brain body right by 2px
                        0004,A03C,
                        961C,       ; Move Mother Brain body up by 1px
                        0004,A08E,
                        9622,       ; Move Mother Brain body up by 1px and right by 3px, do footstep effect
                        0004,A0E0,
                        9638,       ; Move Mother Brain body down by 2px and right by 15px
                        0004,A12A,
                        9648,       ; Move Mother Brain body down by 4px and right by 6px
                        0004,A174,
                        9658,       ; Move Mother Brain body up by 4px and left by 2px
                        0004,A1BE,
                        9668,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        0004,A208,
                        812F        ; Sleep
}


;;; $97A4: Instruction list - Mother Brain body - walking forwards - medium ;;;
{
$A9:97A4             dx 9708,       ; Mother Brain's pose = walking
                        0006,9FA0,
                        95FC,       ; Move Mother Brain body up by 2px and right by 1px
                        0006,9FEA,
                        960C,       ; Move Mother Brain body right by 2px
                        0006,A03C,
                        961C,       ; Move Mother Brain body up by 1px
                        0006,A08E,
                        9622,       ; Move Mother Brain body up by 1px and right by 3px, do footstep effect
                        0006,A0E0,
                        9638,       ; Move Mother Brain body down by 2px and right by 15px
                        0006,A12A,
                        9648,       ; Move Mother Brain body down by 4px and right by 6px
                        0006,A174,
                        9658,       ; Move Mother Brain body up by 4px and left by 2px
                        0006,A1BE,
                        9668,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        0006,A208,
                        812F        ; Sleep
}


;;; $97DE: Instruction list - Mother Brain body - walking forwards - slow ;;;
{
$A9:97DE             dx 9708,       ; Mother Brain's pose = walking
                        0008,9FA0,
                        95FC,       ; Move Mother Brain body up by 2px and right by 1px
                        0008,9FEA,
                        960C,       ; Move Mother Brain body right by 2px
                        0008,A03C,
                        961C,       ; Move Mother Brain body up by 1px
                        0008,A08E,
                        9622,       ; Move Mother Brain body up by 1px and right by 3px, do footstep effect
                        0008,A0E0,
                        9638,       ; Move Mother Brain body down by 2px and right by 15px
                        0008,A12A,
                        9648,       ; Move Mother Brain body down by 4px and right by 6px
                        0008,A174,
                        9658,       ; Move Mother Brain body up by 4px and left by 2px
                        0008,A1BE,
                        9668,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        0008,A208,
                        812F        ; Sleep
}


;;; $9818: Instruction list - Mother Brain body - walking forwards - really slow ;;;
{
$A9:9818             dx 9708,       ; Mother Brain's pose = walking
                        000A,9FA0,
                        95FC,       ; Move Mother Brain body up by 2px and right by 1px
                        000A,9FEA,
                        960C,       ; Move Mother Brain body right by 2px
                        000A,A03C,
                        961C,       ; Move Mother Brain body up by 1px
                        000A,A08E,
                        9622,       ; Move Mother Brain body up by 1px and right by 3px, do footstep effect
                        000A,A0E0,
                        9638,       ; Move Mother Brain body down by 2px and right by 15px
                        000A,A12A,
                        9648,       ; Move Mother Brain body down by 4px and right by 6px
                        000A,A174,
                        9658,       ; Move Mother Brain body up by 4px and left by 2px
                        000A,A1BE,
                        9668,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        000A,A208,
                        812F        ; Sleep
}


;;; $9852: Instruction list - Mother Brain body - walking backwards - slow ;;;
{
$A9:9852             dx 9708,       ; Mother Brain's pose = walking
                        0008,A208,
                        96F0,       ; Move Mother Brain body down by 2px and right by 1px
                        0008,A1BE,
                        96E0,       ; Move Mother Brain body down by 4px and right by 2px
                        0008,A174,
                        96D0,       ; Move Mother Brain body up by 4px and left by 6px
                        0008,A12A,
                        96BA,       ; Move Mother Brain body up by 2px and left by 15px, do footstep effect
                        0008,A0E0,
                        96AA,       ; Move Mother Brain body down by 1px and left by 3px
                        0008,A08E,
                        96A4,       ; Move Mother Brain body down by 1px
                        0008,A03C,
                        9694,       ; Move Mother Brain body left by 2px
                        0008,9FEA,
                        967E,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        0008,9FA0,
                        812F        ; Sleep
}


;;; $988C: Instruction list - Mother Brain body - walking backwards - really fast ;;;
{
$A9:988C             dx 9708,       ; Mother Brain's pose = walking
                        0002,A208,
                        96F0,       ; Move Mother Brain body down by 2px and right by 1px
                        0002,A1BE,
                        96E0,       ; Move Mother Brain body down by 4px and right by 2px
                        0002,A174,
                        96D0,       ; Move Mother Brain body up by 4px and left by 6px
                        0002,A12A,
                        96BA,       ; Move Mother Brain body up by 2px and left by 15px, do footstep effect
                        0002,A0E0,
                        96AA,       ; Move Mother Brain body down by 1px and left by 3px
                        0002,A08E,
                        96A4,       ; Move Mother Brain body down by 1px
                        0002,A03C,
                        9694,       ; Move Mother Brain body left by 2px
                        0002,9FEA,
                        967E,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        0002,9FA0,
                        812F        ; Sleep
}


;;; $98C6: Instruction list - Mother Brain body - walking backwards - fast ;;;
{
$A9:98C6             dx 9708,       ; Mother Brain's pose = walking
                        0004,A208,
                        96F0,       ; Move Mother Brain body down by 2px and right by 1px
                        0004,A1BE,
                        96E0,       ; Move Mother Brain body down by 4px and right by 2px
                        0004,A174,
                        96D0,       ; Move Mother Brain body up by 4px and left by 6px
                        0004,A12A,
                        96BA,       ; Move Mother Brain body up by 2px and left by 15px, do footstep effect
                        0004,A0E0,
                        96AA,       ; Move Mother Brain body down by 1px and left by 3px
                        0004,A08E,
                        96A4,       ; Move Mother Brain body down by 1px
                        0004,A03C,
                        9694,       ; Move Mother Brain body left by 2px
                        0004,9FEA,
                        967E,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        0004,9FA0,
                        812F        ; Sleep
}


;;; $9900: Instruction list - Mother Brain body - walking backwards - medium ;;;
{
$A9:9900             dx 9708,       ; Mother Brain's pose = walking
                        0006,A208,
                        96F0,       ; Move Mother Brain body down by 2px and right by 1px
                        0006,A1BE,
                        96E0,       ; Move Mother Brain body down by 4px and right by 2px
                        0006,A174,
                        96D0,       ; Move Mother Brain body up by 4px and left by 6px
                        0006,A12A,
                        96BA,       ; Move Mother Brain body up by 2px and left by 15px, do footstep effect
                        0006,A0E0,
                        96AA,       ; Move Mother Brain body down by 1px and left by 3px
                        0006,A08E,
                        96A4,       ; Move Mother Brain body down by 1px
                        0006,A03C,
                        9694,       ; Move Mother Brain body left by 2px
                        0006,9FEA,
                        967E,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        0006,9FA0,
                        812F        ; Sleep
}


;;; $993A: Instruction list - Mother Brain body - walking backwards - really slow ;;;
{
$A9:993A             dx 9708,       ; Mother Brain's pose = walking
                        000A,A208,
                        96F0,       ; Move Mother Brain body down by 2px and right by 1px
                        000A,A1BE,
                        96E0,       ; Move Mother Brain body down by 4px and right by 2px
                        000A,A174,
                        96D0,       ; Move Mother Brain body up by 4px and left by 6px
                        000A,A12A,
                        96BA,       ; Move Mother Brain body up by 2px and left by 15px, do footstep effect
                        000A,A0E0,
                        96AA,       ; Move Mother Brain body down by 1px and left by 3px
                        000A,A08E,
                        96A4,       ; Move Mother Brain body down by 1px
                        000A,A03C,
                        9694,       ; Move Mother Brain body left by 2px
                        000A,9FEA,
                        967E,       ; Move Mother Brain body up by 2px and left by 1px, do footstep effect
                        9700,       ; Mother Brain's pose = standing
                        000A,9FA0,
                        812F        ; Sleep
}


;;; $9974: Instruction list - Mother Brain body - crouch and then stand up ;;;
{
$A9:9974             dx 9718,       ; Mother Brain's pose = crouching transition
                        0008,9FA0,
                        95DE,       ; Move Mother Brain body down by 12px, scroll it left by 4px
                        0008,A2D6,
                        95E8,       ; Move Mother Brain body down by 16px, scroll it right by 2px
                        0008,A28C,
                        95F2,       ; Move Mother Brain body down by 10px, scroll it right by 2px
                        9710,       ; Mother Brain's pose = crouched
                        0008,A252,
                        0008,A252,
                        95B6,       ; Move Mother Brain body up by 10px, scroll it left by 4px
                        9718,       ; Mother Brain's pose = crouching transition
                        0008,A28C,
                        95C0,       ; Move Mother Brain body up by 16px, scroll it left by 4px
                        0008,A2D6,
                        95CA,       ; Move Mother Brain body up by 12px, scroll it right by 2px
                        0008,9FA0,
                        9700,       ; Mother Brain's pose = standing
                        812F        ; Sleep
}


;;; $99AA: Instruction list - Mother Brain body - standing up after crouching - slow ;;;
{
$A9:99AA             dx 9718,       ; Mother Brain's pose = crouching transition
                        0010,A252,
                        95B6,       ; Move Mother Brain body up by 10px, scroll it left by 4px
                        0010,A28C,
                        95C0,       ; Move Mother Brain body up by 16px, scroll it left by 4px
                        0010,A2D6,
                        95CA,       ; Move Mother Brain body up by 12px, scroll it right by 2px
                        0010,9FA0,
                        9700,       ; Mother Brain's pose = standing
                        812F        ; Sleep
}


;;; $99C6: Instruction list - Mother Brain body - standing up after crouching - fast ;;;
{
$A9:99C6             dx 9718,       ; Mother Brain's pose = crouching transition
                        0008,A252,
                        95B6,       ; Move Mother Brain body up by 10px, scroll it left by 4px
                        0008,A28C,
                        95C0,       ; Move Mother Brain body up by 16px, scroll it left by 4px
                        0008,A2D6,
                        95CA,       ; Move Mother Brain body up by 12px, scroll it right by 2px
                        0008,9FA0,
                        9700,       ; Mother Brain's pose = standing
                        812F        ; Sleep
}


;;; $99E2: Instruction list - Mother Brain body - standing up after leaning down ;;;
{
$A9:99E2             dx 9718,       ; Mother Brain's pose = crouching transition
                        0008,A2D6,
                        95CA,       ; Move Mother Brain body up by 12px, scroll it right by 2px
                        0008,9FA0,
                        9700,       ; Mother Brain's pose = standing
                        812F        ; Sleep
}


;;; $99F2: Instruction list - Mother Brain body - leaning down ;;;
{
$A9:99F2             dx 9718,       ; Mother Brain's pose = crouching transition
                        0008,9FA0,
                        95DE,       ; Move Mother Brain body down by 12px, scroll it left by 4px
                        9728,       ; Mother Brain's pose = leaning down
                        0008,A2D6,
                        812F        ; Sleep
}


;;; $9A02: Instruction list - Mother Brain body - crouched ;;;
{
$A9:9A02             dx 9710,       ; Mother Brain's pose = crouched
                        0008,A252,
                        812F        ; Sleep
}


;;; $9A0A: Instruction list - Mother Brain body - crouch - slow ;;;
{
$A9:9A0A             dx 9718,       ; Mother Brain's pose = crouching transition
                        0008,9FA0,
                        95DE,       ; Move Mother Brain body down by 12px, scroll it left by 4px
                        0008,A2D6,
                        95E8,       ; Move Mother Brain body down by 16px, scroll it right by 2px
                        0008,A28C,
                        95F2,       ; Move Mother Brain body down by 10px, scroll it right by 2px
                        9710,       ; Mother Brain's pose = crouched
                        0008,A252,
                        812F        ; Sleep
}


;;; $9A26: Instruction list - Mother Brain body - crouch - fast ;;;
{
$A9:9A26             dx 9718,       ; Mother Brain's pose = crouching transition
                        0008,9FA0,
                        95DE,       ; Move Mother Brain body down by 12px, scroll it left by 4px
                        0002,A2D6,
                        95E8,       ; Move Mother Brain body down by 16px, scroll it right by 2px
                        0002,A28C,
                        95F2,       ; Move Mother Brain body down by 10px, scroll it right by 2px
                        9710,       ; Mother Brain's pose = crouched
                        0008,A252,
                        812F        ; Sleep
}


;;; $9A42: Instruction list - Mother Brain body - death beam mode ;;;
{
$A9:9A42             dx 9720,                   ; Mother Brain's pose = death beam mode
                        0001,9FA0,
                        0001,A384,
                        0001,A3CE,
                        9AC8,0024,FFD8,0001,    ; Spawn enemy projectile $E509 to offset (24h, -28h) with parameter 1 (Mother Brain elbow charge particles)
                        0001,A3CE,
                        9AC8,0022,FFD6,0002,    ; Spawn enemy projectile $E509 to offset (22h, -2Ah) with parameter 2 (Mother Brain elbow charge energy)
                        0001,A3CE,
                        9AC8,0024,FFD8,0001,    ; Spawn enemy projectile $E509 to offset (24h, -28h) with parameter 1 (Mother Brain elbow charge particles)
                        0001,A3CE,
                        9AC8,0022,FFD6,0002,    ; Spawn enemy projectile $E509 to offset (22h, -2Ah) with parameter 2 (Mother Brain elbow charge energy)
                        0001,A3CE,
                        9AC8,0024,FFD8,0001,    ; Spawn enemy projectile $E509 to offset (24h, -28h) with parameter 1 (Mother Brain elbow charge particles)
                        0001,A3CE,
                        9AC8,0022,FFD6,0002,    ; Spawn enemy projectile $E509 to offset (22h, -2Ah) with parameter 2 (Mother Brain elbow charge energy)
                        0001,A3CE,
                        9AC8,0024,FFD8,0001,    ; Spawn enemy projectile $E509 to offset (24h, -28h) with parameter 1 (Mother Brain elbow charge particles)
                        0001,A3CE,
                        9AC8,0022,FFD6,0002,    ; Spawn enemy projectile $E509 to offset (22h, -2Ah) with parameter 2 (Mother Brain elbow charge energy)
                        0001,A3CE,
                        0001,A3CE,
                        9AEF,                   ; Spawn death beam enemy projectile
                        0001,A418,
                        0001,A462,
                        00F0,9FA0,
                        9B05,                   ; Increment Mother Brain death beam attack phase
                        9700,                   ; Mother Brain's pose = standing
                        812F                    ; Sleep
}
}


;;; $9AC8..9B0E: Instructions - Mother Brain body - death beam mode ;;;
{
;;; $9AC8: Instruction - spawn enemy projectile $E509 to offset ([[Y]], [[Y] + 2]) with parameter [[Y] + 4] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction

; Offset is relative to Mother Brain body position
$A9:9AC8 5A          PHY
$A9:9AC9 DA          PHX
$A9:9ACA B9 00 00    LDA $0000,y[$A9:9A52]
$A9:9ACD 18          CLC
$A9:9ACE 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A9:9AD1 85 12       STA $12    [$7E:0012]
$A9:9AD3 B9 02 00    LDA $0002,y[$A9:9A54]
$A9:9AD6 18          CLC
$A9:9AD7 6D 7E 0F    ADC $0F7E  [$7E:0F7E]
$A9:9ADA 85 14       STA $14    [$7E:0014]
$A9:9ADC B9 04 00    LDA $0004,y[$A9:9A56]
$A9:9ADF A0 09 E5    LDY #$E509             ;\
$A9:9AE2 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:9AE6 FA          PLX
$A9:9AE7 7A          PLY
$A9:9AE8 C8          INY
$A9:9AE9 C8          INY
$A9:9AEA C8          INY
$A9:9AEB C8          INY
$A9:9AEC C8          INY
$A9:9AED C8          INY
$A9:9AEE 6B          RTL
}


;;; $9AEF: Instruction - spawn death beam enemy projectile ;;;
{
$A9:9AEF DA          PHX
$A9:9AF0 5A          PHY
$A9:9AF1 A9 63 00    LDA #$0063             ;\
$A9:9AF4 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 63h, sound library 2, max queued sounds allowed = 6 (Mother Brain's death beam)
$A9:9AF8 A2 40 00    LDX #$0040             ;\
$A9:9AFB A0 67 CB    LDY #$CB67             ;} Spawn Mother Brain's death beam - charging enemy projectile using Mother Brain brain graphics
$A9:9AFE 22 27 80 86 JSL $868027[$86:8027]  ;/
$A9:9B02 7A          PLY
$A9:9B03 FA          PLX
$A9:9B04 6B          RTL
}


;;; $9B05: Instruction - increment Mother Brain death beam attack phase ;;;
{
$A9:9B05 AF 2E 78 7E LDA $7E782E[$7E:782E]
$A9:9B09 1A          INC A
$A9:9B0A 8F 2E 78 7E STA $7E782E[$7E:782E]
$A9:9B0E 6B          RTL
}
}


;;; $9B0F: Instruction - go to [[X]] ;;;
{
;; Parameters:
;;     X: Pointer to instruction arguments
;; Returns:
;;     X: Pointer to next instruction
$A9:9B0F BD 00 00    LDA $0000,x[$A9:9C27]
$A9:9B12 AA          TAX
$A9:9B13 60          RTS
}


;;; $9B14..9F9F: Instruction lists and instructions - Mother Brain brain ;;;
{
;;; $9B14: Instruction - enable Mother Brain neck movement and go to [[X]] ;;;
{
;; Parameters:
;;     X: Pointer to instruction arguments
;; Returns:
;;     X: Pointer to next instruction
$A9:9B14 A9 01 00    LDA #$0001             ;\
$A9:9B17 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:9B1B BD 00 00    LDA $0000,x[$A9:9EFE]  ;\
$A9:9B1E AA          TAX                    ;} X = [[X]]
$A9:9B1F 60          RTS
}


;;; $9B20: Instruction - disable Mother Brain neck movement ;;;
{
$A9:9B20 A9 00 00    LDA #$0000
$A9:9B23 8F 62 80 7E STA $7E8062[$7E:8062]
$A9:9B27 60          RTS
}


;;; $9B28: Instruction - queue sound [[X]], sound library 2, max queued sounds allowed = 6 ;;;
{
;; Parameters:
;;     X: Pointer to instruction arguments
;; Returns:
;;     X: Pointer to next instruction
$A9:9B28 BD 00 00    LDA $0000,x[$A9:9B93]
$A9:9B2B 22 CB 90 80 JSL $8090CB[$80:90CB]
$A9:9B2F E8          INX
$A9:9B30 E8          INX
$A9:9B31 60          RTS
}


;;; $9B32: Instruction - queue sound [[X]], sound library 3, max queued sounds allowed = 6 ;;;
{
;; Parameters:
;;     X: Pointer to instruction arguments
;; Returns:
;;     X: Pointer to next instruction
$A9:9B32 BD 00 00    LDA $0000,x[$A9:9D55]
$A9:9B35 22 4D 91 80 JSL $80914D[$80:914D]
$A9:9B39 E8          INX
$A9:9B3A E8          INX
$A9:9B3B 60          RTS
}


;;; $9B3C: Instruction - spawn Mother Brain's drool enemy projectile ;;;
{
$A9:9B3C AF 64 78 7E LDA $7E7864[$7E:7864]  ;\
$A9:9B40 F0 2A       BEQ $2A    [$9B6C]     ;} If Mother Brain's drool generation is disabled: return
$A9:9B42 5A          PHY
$A9:9B43 AF 66 78 7E LDA $7E7866[$7E:7866]  ;\
$A9:9B47 1A          INC A                  ;|
$A9:9B48 C9 06 00    CMP #$0006             ;|
$A9:9B4B 30 03       BMI $03    [$9B50]     ;} Mother Brain's drool enemy projectile parameter = ([Mother Brain's drool enemy projectile parameter] + 1) % 6
$A9:9B4D A9 00 00    LDA #$0000             ;|
                                            ;|
$A9:9B50 8F 66 78 7E STA $7E7866[$7E:7866]  ;/
$A9:9B54 A0 91 CB    LDY #$CB91             ; Y = $CB91 (Mother Brain's drool)
$A9:9B57 AF 68 80 7E LDA $7E8068[$7E:8068]  ;\
$A9:9B5B C9 80 00    CMP #$0080             ;} If [Mother Brain neck angle delta] >= 80h:
$A9:9B5E 30 03       BMI $03    [$9B63]     ;/
$A9:9B60 A0 9F CB    LDY #$CB9F             ; Y = $CB9F (Mother Brain's dying drool)

$A9:9B63 AF 66 78 7E LDA $7E7866[$7E:7866]  ;\
$A9:9B67 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn enemy projectile [Y] with parameter [Mother Brain's drool enemy projectile parameter]
$A9:9B6B 7A          PLY

$A9:9B6C 60          RTS
}


;;; $9B6D: Instruction - spawn Mother Brain's purple breath - big enemy projectile ;;;
{
$A9:9B6D 5A          PHY
$A9:9B6E A0 2F CB    LDY #$CB2F             ;\
$A9:9B71 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's purple breath - big enemy projectile
$A9:9B75 7A          PLY
$A9:9B76 60          RTS
}


;;; $9B77: Instruction - Mother Brain brain main shake timer = 50 ;;;
{
$A9:9B77 A9 32 00    LDA #$0032
$A9:9B7A 8F 40 78 7E STA $7E7840[$7E:7840]
$A9:9B7E 60          RTS
}


;;; $9B7F: Instruction list - Mother Brain brain - stretching - phase 2 ;;;
{
$A9:9B7F             dx 9B77,       ; Mother Brain brain main shake timer = 50
                        0002,A5F8,
                        0002,A62C,
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0002,A62C,
                        9B6D,       ; Spawn Mother Brain's purple breath - big enemy projectile
                        9B28,007E,  ; Queue sound 7Eh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - high pitch)
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0010,A660,
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0010,A660,
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0020,A660,
                        0004,A62C
$A9:9BAB             dx 0001,A5F8,
                        9B0F,9BAB   ; Go to $9BAB
}


;;; $9BB3: Instruction list - Mother Brain brain - stretching - phase 3 ;;;
{
$A9:9BB3             dx 9B77,       ; Mother Brain brain main shake timer = 50
                        0002,A717,
                        0002,A750,
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0002,A750,
                        9B6D,       ; Spawn Mother Brain's purple breath - big enemy projectile
                        9B28,007E,  ; Queue sound 7Eh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - high pitch)
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0010,A789,
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0010,A789,
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0020,A789,
                        0004,A750
$A9:9BDF             dx 0001,A717,
                        9B0F,9BDF   ; Go to $9BDF
}


;;; $9BE7: Instruction list - Mother Brain brain - hyper beam recoil ;;;
{
$A9:9BE7             dx 9B77,       ; Mother Brain brain main shake timer = 50
                        0002,A717,
                        0002,A750,
                        0002,A750,
                        9B6D,       ; Spawn Mother Brain's purple breath - big enemy projectile
                        9B28,007E,  ; Queue sound 7Eh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - high pitch)
                        0010,A789,
                        0010,A789,
                        0020,A789,
                        0004,A750
$A9:9C0B             dx 0001,A717,
                        9B0F,9C0B   ; Go to $9C0B
}


;;; $9C13: Instruction list - Mother Brain body - initial (dummy) ;;;
{
$A9:9C13             dx 0000,A320,
                        812F        ; Sleep
}


;;; $9C19: Unused. Instruction list - Mother Brain brain ;;;
{
$A9:9C19             dx 0008,A5F8,
                        0004,A5BF
}


;;; $9C21: Instruction list - Mother Brain brain - initial ;;;
{
$A9:9C21             dx 0004,A586,
                        9B0F,9C21   ; Go to $9C21
}


;;; $9C29: Instruction list - Mother Brain brain - decapitated ;;;
{
$A9:9C29             dx 0008,A717,
                        0004,A6D9
$A9:9C31             dx 0004,A69B,
                        9B0F,9C31   ; Go to $9C31
}


;;; $9C39: Instruction list - Mother Brain brain - dying drool ;;;
{
$A9:9C39             dx 9B77,       ; Mother Brain brain main shake timer = 50
                        0004,A717,
                        0004,A750,
                        9B28,007E   ; Queue sound 7Eh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - high pitch)
$A9:9C47             dx 0002,A789,
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0002,A789,
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0002,A789,
                        9B3C,       ; Spawn Mother Brain's drool enemy projectile
                        0002,A789,
                        9B3C        ; Spawn Mother Brain's drool enemy projectile
$A9:9C5F             dx 0002,A789,
                        9C65        ; Go to $9C5F or occasionally $9C47
}


;;; $9C65: Instruction - go to $9C5F or occasionally $9C47 ;;;
{
;; Returns:
;;     X: Pointer to next instruction
$A9:9C65 A2 5F 9C    LDX #$9C5F             ; X = $9C5F
$A9:9C68 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:9C6B 29 FF 0F    AND #$0FFF             ;|
$A9:9C6E C9 E0 0F    CMP #$0FE0             ;} If [random number] & FFFh >= FE0h:
$A9:9C71 90 03       BCC $03    [$9C76]     ;/
$A9:9C73 A2 47 9C    LDX #$9C47             ; X = $9C47

$A9:9C76 60          RTS
}


;;; $9C77: Instruction list - Mother Brain brain - firing rainbow beam ;;;
{
$A9:9C77             dx 0001,A5F8,
                        9B0F,9C77   ; Go to $9C77
}


;;; $9C7F: Unused. Instruction list - Mother Brain brain ;;;
{
$A9:9C7F             dx 0001,A717,
                        9B0F,9C7F   ; Go to $9C7F
}


;;; $9C87: Instruction list - Mother Brain brain - neutral - phase 2 ;;;
{
; Includes firing death beam (which is done by body)
$A9:9C87             dx 0004,A586,
                        0004,A5BF,
                        0008,A5F8,
                        0004,A5BF,
                        0004,A586,
                        0004,A5BF
$A9:9C9F             dx 0008,A5F8,
                        9CAD,       ; Likely go to $9C9F
                        0004,A5BF,
                        9B0F,9C87   ; Go to $9C87
}


;;; $9CAD: Instruction - likely go to $9C9F ;;;
{
;; Parameters:
;;     X: Pointer to after this instruction
;; Returns:
;;     X: Pointer to next instruction
$A9:9CAD AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:9CB0 C9 00 F0    CMP #$F000             ;} If [random number] < F000h:
$A9:9CB3 B0 03       BCS $03    [$9CB8]     ;/
$A9:9CB5 A2 9F 9C    LDX #$9C9F             ; X = $9C9F

$A9:9CB8 60          RTS
}


;;; $9CB9: Instruction list - Mother Brain brain - neutral - phase 3 ;;;
{
; When Shitroid is making its final stand
$A9:9CB9             dx 0004,A69B,
                        0004,A6D9,
                        0008,A717,
                        0004,A6D9,
                        0004,A69B,
                        0004,A6D9
$A9:9CD1             dx 0008,A717,
                        0008,A6D9,
                        9D0D,       ; Likely go to $9CD1
                        0004,A69B,
                        9B0F,9CB9   ; Go to $9CB9

; Unused branch
$A9:9CE3             dx 0004,A717,
                        0004,A750,
                        0002,A789,
                        9B28,006F,  ; Queue sound 6Fh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - low pitch)
                        0002,A789,
                        0002,A789,
                        0002,A789,
                        0002,A789,
                        0004,A750,
                        0004,A717,
                        9D21        ; Go to $9CD1
}


;;; $9D0D: Instruction - likely go to $9CD1 ;;;
{
;; Parameters:
;;     X: Pointer to after this instruction
;; Returns:
;;     X: Pointer to next instruction

; If [random number] & FFFh < EC0h:
;     X = $9CD1

; If $9D16 were a BCC, Mother Brain would do a cry sound effect occasionally whilst Shitroid makes its final stand
$A9:9D0D AD E5 05    LDA $05E5  [$7E:05E5]
$A9:9D10 29 FF 0F    AND #$0FFF
$A9:9D13 C9 40 0F    CMP #$0F40
$A9:9D16 80 04       BRA $04    [$9D1C]     ; <-- looks like this was supposed to be BCC
$A9:9D18 A2 E3 9C    LDX #$9CE3
$A9:9D1B 60          RTS

$A9:9D1C C9 C0 0E    CMP #$0EC0
$A9:9D1F B0 03       BCS $03    [$9D24]
}


;;; $9D21: Instruction - go to $9CD1 ;;;
{
;; Returns:
;;     X: Pointer to next instruction
$A9:9D21 A2 D1 9C    LDX #$9CD1
$A9:9D24 60          RTS
}


;;; $9D25: Instruction list - Mother Brain brain - corpse ;;;
{
$A9:9D25             dx 0002,A69B,
                        0002,A6D9,
                        0040,A717,
                        0040,AD3E,
$A9:9D35             dx 0002,AD6D,
                        9B0F,9D35   ; Go to $9D35
}


;;; $9D3D: Instruction list - Mother Brain brain - attacking - four blue rings - phase 2 ;;;
{
$A9:9D3D             dx 9B20,       ; Disable Mother Brain neck movement
                        0004,A5F8,
                        0004,A62C,
                        9B28,006F,  ; Queue sound 6Fh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - low pitch)
                        0008,A660,
                        9E5B,       ; Aim Mother Brain blue rings at Samus
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        9B32,0017,  ; Queue sound 17h, sound library 3, max queued sounds allowed = 6 (Mother Brain's blue rings)
                        0003,A660,
                        9E5B,       ; Aim Mother Brain blue rings at Samus
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        0003,A660,
                        9E5B,       ; Aim Mother Brain blue rings at Samus
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        0003,A660,
                        9E5B,       ; Aim Mother Brain blue rings at Samus
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        0010,A660,
                        0004,A62C,
                        0010,A5F8,
                        9B14,9C87   ; Enable Mother Brain neck movement and go to $9C87 (neutral - phase 2)
}


;;; $9D7F: Instruction list - Mother Brain brain - attacking - two blue rings - phase 2 ;;;
{
$A9:9D7F             dx 9B20,       ; Disable Mother Brain neck movement
                        0004,A5F8,
                        0004,A62C,
                        9B28,006F,  ; Queue sound 6Fh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - low pitch)
                        0008,A660,
                        9E5B,       ; Aim Mother Brain blue rings at Samus
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        9B32,0017,  ; Queue sound 17h, sound library 3, max queued sounds allowed = 6 (Mother Brain's blue rings)
                        0003,A660,
                        9E5B,       ; Aim Mother Brain blue rings at Samus
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        0010,A660,
                        0004,A62C,
                        0010,A5F8,
                        9B14,9C87   ; Enable Mother Brain neck movement and go to $9C87 (neutral - phase 2)
}


;;; $9DB1: Instruction list - Mother Brain brain - attacking Shitroid ;;;
{
$A9:9DB1             dx 9EA3,       ; Increment Mother Brain Shitroid attack counter
                        9B20,       ; Disable Mother Brain neck movement
                        9E37,       ; Aim Mother Brain blue rings at Shitroid
                        9B0F,9DC1   ; Go to $9DC1 (attacking - four blue rings - phase 3)
}


;;; $9DBB: Instruction list - Mother Brain brain - attacking Samus - four blue rings - phase 3 ;;;
{
$A9:9DBB             dx 9EB5,       ; Mother Brain Shitroid attack counter = 0
                        9B20,       ; Disable Mother Brain neck movement
                        9E5B        ; Aim Mother Brain blue rings at Samus
}


;;; $9DC1: Instruction list - Mother Brain brain - attacking - four blue rings - phase 3 ;;;
{
$A9:9DC1             dx 0004,A717,
                        0004,A750,
                        9DF7,       ; Queue Shitroid attack sound effect
                        0008,A789,
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        9B32,0017,  ; Queue sound 17h, sound library 3, max queued sounds allowed = 6 (Mother Brain's blue rings)
                        0003,A789,
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        0003,A789,
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        0003,A789,
                        9E29,       ; Spawn Mother Brain blue ring enemy projectile
                        0010,A789,
                        0004,A750,
                        0010,A717,
                        9B14,9CB9   ; Enable Mother Brain neck movement and go to $9CB9 (neutral - phase 3)
}


;;; $9DF7: Instruction - queue Shitroid attack sound effect ;;;
{
$A9:9DF7 5A          PHY
$A9:9DF8 AF 26 78 7E LDA $7E7826[$7E:7826]  ;\
$A9:9DFC C9 0B 00    CMP #$000B             ;} If [Mother Brain Shitroid attack counter] = Bh: return
$A9:9DFF F0 0C       BEQ $0C    [$9E0D]     ;/
$A9:9E01 A9 00 00    LDA #$0000             ;\
$A9:9E04 0A          ASL A                  ;|
$A9:9E05 A8          TAY                    ;} Queue sound 6Fh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - low pitch)
$A9:9E06 B9 0F 9E    LDA $9E0F,y[$A9:9E0F]  ;|
$A9:9E09 22 CB 90 80 JSL $8090CB[$80:90CB]  ;/

$A9:9E0D 7A          PLY
$A9:9E0E 60          RTS

; (Should be) indexed by [Mother Brain Shitroid attack counter]
; 6Fh: Mother Brain's cry - low pitch
; 7Eh: Mother Brain's cry - high pitch
$A9:9E0F             dw 006F, 006F, 006F, 007E, 006F, 006F, 007E, 006F, 006F, 007E, 007E, 006F, 006F
}


;;; $9E29: Instruction - spawn Mother Brain blue ring enemy projectile ;;;
{
$A9:9E29 5A          PHY
$A9:9E2A A0 4B CB    LDY #$CB4B             ;\
$A9:9E2D AF 34 78 7E LDA $7E7834[$7E:7834]  ;} Spawn Mother Brain's blue ring enemy projectile with parameter [Mother Brain blue rings target angle]
$A9:9E31 22 97 80 86 JSL $868097[$86:8097]  ;/
$A9:9E35 7A          PLY
$A9:9E36 60          RTS
}


;;; $9E37: Instruction - aim Mother Brain blue rings at Shitroid ;;;
{
$A9:9E37 DA          PHX
$A9:9E38 5A          PHY
$A9:9E39 AF 54 78 7E LDA $7E7854[$7E:7854]  ;\
$A9:9E3D AA          TAX                    ;} X = [Shitroid enemy index]
$A9:9E3E BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A9:9E41 38          SEC                    ;|
$A9:9E42 ED BA 0F    SBC $0FBA  [$7E:0FBA]  ;|
$A9:9E45 38          SEC                    ;} $12 = [Shitroid X position] - Ah - [Mother Brain brain X position]
$A9:9E46 E9 0A 00    SBC #$000A             ;|
$A9:9E49 85 12       STA $12    [$7E:0012]  ;/
$A9:9E4B BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A9:9E4E 38          SEC                    ;|
$A9:9E4F ED BE 0F    SBC $0FBE  [$7E:0FBE]  ;|
$A9:9E52 38          SEC                    ;} $14 = [Shitroid Y position] - 10h - [Mother Brain brain Y position]
$A9:9E53 E9 10 00    SBC #$0010             ;|
$A9:9E56 85 14       STA $14    [$7E:0014]  ;/
$A9:9E58 4C 77 9E    JMP $9E77  [$A9:9E77]  ; Go to aim Mother Brain blue rings
}


;;; $9E5B: Instruction - aim Mother Brain blue rings at Samus ;;;
{
$A9:9E5B DA          PHX
$A9:9E5C 5A          PHY
$A9:9E5D AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:9E60 38          SEC                    ;|
$A9:9E61 ED BA 0F    SBC $0FBA  [$7E:0FBA]  ;|
$A9:9E64 38          SEC                    ;} $12 = [Samus X position] - Ah - [Mother Brain brain X position]
$A9:9E65 E9 0A 00    SBC #$000A             ;|
$A9:9E68 85 12       STA $12    [$7E:0012]  ;/
$A9:9E6A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A9:9E6D 38          SEC                    ;|
$A9:9E6E ED BE 0F    SBC $0FBE  [$7E:0FBE]  ;|
$A9:9E71 38          SEC                    ;} $14 = [Samus Y position] - 10h - [Mother Brain brain Y position]
$A9:9E72 E9 10 00    SBC #$0010             ;|
$A9:9E75 85 14       STA $14    [$7E:0014]  ;/
}


;;; $9E77: Aim Mother Brain blue rings ;;;
{
;; Parameters:
;;     $12: X offset
;;     $14: Y offset

; $7E:7834 = clamp(80h - (angle of ([$12], [$14]) offset), 10h, 40h)

$A9:9E77 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ; A = angle of ([$12], [$14]) offset
$A9:9E7B 38          SEC                    ;\
$A9:9E7C E9 80 00    SBC #$0080             ;|
$A9:9E7F 49 FF FF    EOR #$FFFF             ;} A = 80h - [A] (Y flip of angle)
$A9:9E82 1A          INC A                  ;/
$A9:9E83 29 FF 00    AND #$00FF
$A9:9E86 E2 20       SEP #$20
$A9:9E88 C9 10       CMP #$10               ;\
$A9:9E8A 10 08       BPL $08    [$9E94]     ;} If -70h <= [A] < 10h: (70h < angle <= F0h)
$A9:9E8C C9 C0       CMP #$C0               ;\
$A9:9E8E 30 08       BMI $08    [$9E98]     ;} If -70h <= [A] < -40h: (C0h < angle <= F0h) go to BRANCH_UPPER_HALF
$A9:9E90 A9 10       LDA #$10               ; A = 10h (70h < angle <= C0h)
$A9:9E92 80 06       BRA $06    [$9E9A]     ; Go to BRANCH_MERGE

; 10h <= [A] < 90h (-10h < angle <= 70h)
$A9:9E94 C9 48       CMP #$48               ;\
$A9:9E96 90 02       BCC $02    [$9E9A]     ;} If 10h <= [A] < 48h: (38h < angle <= 70h) go to BRANCH_MERGE

; BRANCH_UPPER_HALF
$A9:9E98 A9 48       LDA #$48               ; A = 48h

; BRANCH_MERGE
$A9:9E9A C2 20       REP #$20
$A9:9E9C 8F 34 78 7E STA $7E7834[$7E:7834]  ; Mother Brain blue rings target angle = [A]
$A9:9EA0 7A          PLY
$A9:9EA1 FA          PLX
$A9:9EA2 60          RTS
}


;;; $9EA3: Instruction - increment Mother Brain Shitroid attack counter ;;;
{
; 12 is the max due to the $A9:9E0F table
$A9:9EA3 AF 26 78 7E LDA $7E7826[$7E:7826]
$A9:9EA7 1A          INC A
$A9:9EA8 C9 0C 00    CMP #$000C
$A9:9EAB 90 03       BCC $03    [$9EB0]
$A9:9EAD A9 0C 00    LDA #$000C

$A9:9EB0 8F 26 78 7E STA $7E7826[$7E:7826]
$A9:9EB4 60          RTS
}


;;; $9EB5: Instruction - Mother Brain Shitroid attack counter = 0 ;;;
{
$A9:9EB5 A9 00 00    LDA #$0000
$A9:9EB8 8F 26 78 7E STA $7E7826[$7E:7826]
$A9:9EBC 60          RTS
}


;;; $9EBD: Instruction - spawn Mother Brain bomb enemy projectile with parameter [[X]] ;;;
{
;; Parameters:
;;     X: Pointer to instruction arguments
;; Returns:
;;     X: Pointer to next instruction
$A9:9EBD 5A          PHY
$A9:9EBE BD 00 00    LDA $0000,x[$A9:9EEC]
$A9:9EC1 A0 59 CB    LDY #$CB59             ;\
$A9:9EC4 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's bomb enemy projectile
$A9:9EC8 7A          PLY
$A9:9EC9 E8          INX
$A9:9ECA E8          INX
$A9:9ECB 60          RTS
}


;;; $9ECC: Instruction list - Mother Brain brain - attacking - bomb - phase 2 ;;;
{
$A9:9ECC             dx 0004,A586,
                        0004,A5BF,
                        0008,A5F8,
                        9B20,       ; Disable Mother Brain neck movement
                        0004,A5F8,
                        0004,A62C,
                        9B28,006F,  ; Queue sound 6Fh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - low pitch)
                        0008,A660,
                        9EBD,0007,  ; Spawn Mother Brain bomb enemy projectile with parameter 7
                        9B6D,       ; Spawn Mother Brain's purple breath - big enemy projectile
                        0020,A660,
                        0004,A62C,
                        0010,A5F8,
                        9B14,9C87   ; Enable Mother Brain neck movement and go to $9C87 (neutral - phase 2)
}


;;; $9F00: Instruction list - Mother Brain brain - attacking - bomb - phase 3 ;;;
{
$A9:9F00             dx 0004,A69B,
                        0004,A6D9,
                        0008,A717,
                        9B20,       ; Disable Mother Brain neck movement
                        0004,A717,
                        0004,A750,
                        9B28,006F,  ; Queue sound 6Fh, sound library 2, max queued sounds allowed = 6 (Mother Brain's cry - low pitch)
                        0008,A789,
                        9EBD,0001,  ; Spawn Mother Brain bomb enemy projectile with parameter 1
                        9B6D,       ; Spawn Mother Brain's purple breath - big enemy projectile
                        0020,A789,
                        0004,A750,
                        0010,A717,
                        9B14,9CB9   ; Enable Mother Brain neck movement and go to $9CB9 (neutral - phase 3)
}


;;; $9F34: Instruction list - Mother Brain brain - attacking - laser ;;;
{
$A9:9F34             dx 0010,A5BF,
                        0004,A5F8,
                        9F46,       ; Spawn Mother Brain laser enemy projectile
                        0020,A5F8,
                        9B14,9C87   ; Enable Mother Brain neck movement and go to $9C87 (neutral - phase 2)
}


;;; $9F46: Instruction - spawn Mother Brain laser enemy projectile ;;;
{
$A9:9F46 A9 00 00    LDA #$0000             ;\
$A9:9F49 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Disable Mother Brain neck movement
$A9:9F4D 5A          PHY
$A9:9F4E AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A9:9F51 18          CLC                    ;|
$A9:9F52 69 10 00    ADC #$0010             ;} $12 = [Mother Brain brain X position] + 10h
$A9:9F55 85 12       STA $12    [$7E:0012]  ;/
$A9:9F57 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:9F5A 18          CLC                    ;|
$A9:9F5B 69 04 00    ADC #$0004             ;} $14 = [Mother Brain brain Y position] + 4
$A9:9F5E 85 14       STA $14    [$7E:0014]  ;/
$A9:9F60 A9 01 00    LDA #$0001             ;\
$A9:9F63 A0 7B A1    LDY #$A17B             ;} Spawn laser enemy projectile with parameter 1
$A9:9F66 22 97 80 86 JSL $868097[$86:8097]  ;/
$A9:9F6A 7A          PLY
$A9:9F6B 60          RTS
}


;;; $9F6C: Instruction list - Mother Brain brain - charging rainbow beam ;;;
{
$A9:9F6C             dx 9F8E,       ; Set up effects for Mother Brain charging rainbow beam
                        0004,A5F8,
                        0004,A5BF,
                        0002,A586
$A9:9F7A             dx 9F84,       ; Spawn Mother Brain's rainbow beam charging enemy projectile
                        001E,A586,
                        9B0F,9F7A   ; Go to $9F7A
}


;;; $9F84: Instruction - spawn Mother Brain's rainbow beam charging enemy projectile ;;;
{
$A9:9F84 5A          PHY
$A9:9F85 A0 83 CB    LDY #$CB83             ;\
$A9:9F88 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's rainbow beam charging enemy projectile
$A9:9F8C 7A          PLY
$A9:9F8D 60          RTS
}


;;; $9F8E: Instruction - set up effects for Mother Brain charging rainbow beam ;;;
{
$A9:9F8E A9 00 00    LDA #$0000             ;\
$A9:9F91 8F 68 78 7E STA $7E7868[$7E:7868]  ;} Disable Mother Brain's small purple breath generation
$A9:9F95 20 FF D1    JSR $D1FF  [$A9:D1FF]  ; Set up Mother Brain brain palette for charging her laser
$A9:9F98 A9 7F 00    LDA #$007F             ;\
$A9:9F9B 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 7Fh, sound library 2, max queued sounds allowed = 6 (Mother Brain charging her rainbow)
$A9:9F9F 60          RTS
}
}


;;; $9FA0: Extended spritemap entries - Mother Brain body ;;;
{
; Standing
$A9:9FA0             dx 0009, 0012,003A,A890,A4CA, 001E,001D,A85B,A4C8, 0019,001E,A86E,A4C8, 0000,FFFC,A7C2,A4C8, 0000,0000,A98A,A4E8, 0000,0000,AAEA,A504, FFF6,0038,A974,A4DA, 0007,001C,A93F,A4D8, 0002,001D,A95E,A4D8

; Walking
$A9:9FEA             dx 000A, 001C,002F,A890,A4CA, 0026,0013,A85B,A4C8, 0021,0013,A86E,A4C8, 0000,FFFD,A7F1,A4C8, 0000,0002,A98A,A4E8, 0000,0000,AAEA,A504, FFF5,003A,A974,A4DA, 0006,001F,A93F,A4D8, 0001,0021,A95E,A4D8, FFE7,FFFD,A8A6,A4D8
$A9:A03C             dx 000A, 0028,0030,A890,A4CA, 0026,0013,A85B,A4C8, 0023,0013,A862,A4C8, 0000,FFFD,A7F1,A4C8, 0000,0002,A98A,A4E8, 0000,0000,AAEA,A504, FFF3,003A,A974,A4DA, 0005,001F,A93F,A4D8, FFFF,0021,A95E,A4D8, FFE6,FFFD,A8A6,A4D8
$A9:A08E             dx 000A, 0028,0033,A890,A4CA, 0026,0015,A85B,A4C8, 0023,0016,A862,A4C8, FFFF,FFFE,A7F1,A4C8, 0000,0001,A98A,A4E8, 0000,0000,AAEA,A504, FFF3,0039,A974,A4DA, 0005,001E,A93F,A4D8, FFFF,0020,A95E,A4D8, FFE6,FFFC,A8A6,A4D8
$A9:A0E0             dx 0009, 0024,003A,A890,A4CA, 0021,001D,A85B,A4C8, 001F,001E,A862,A4C8, 0001,FFFC,A7C2,A4C8, 0000,0000,A98A,A4E8, 0000,0000,AAEA,A504, FFF0,0038,A974,A4DA, 0003,001C,A93F,A4D8, FFFC,001E,A95E,A4D8
$A9:A12A             dx 0009, 0015,003C,A890,A4CA, 001D,001F,A85B,A4C8, 001B,0020,A86E,A4C8, FFFE,FFFE,A7C2,A4C8, 0000,0002,A98A,A4E8, 0000,0000,AAEA,A504, FFF0,0034,A974,A4DA, 0000,001A,A93F,A4D8, FFFB,001C,A95E,A4D8
$A9:A174             dx 0009, 000F,0040,A890,A4CA, 001E,0023,A85B,A4C8, 001A,0025,A87A,A4C8, FFFE,FFFF,A7C2,A4C8, 0000,0006,A98A,A4E8, 0000,0000,AAEA,A504, FFF6,002F,A974,A4DA, 0004,0016,A93F,A4D8, FFFF,0018,A95E,A4D8
$A9:A1BE             dx 0009, 0011,003C,A890,A4CA, 001E,0020,A85B,A4C8, 0018,0020,A86E,A4C8, FFFF,FFFE,A7C2,A4C8, 0000,0002,A98A,A4E8, 0000,0000,AAEA,A504, FFF8,002F,A974,A4DA, 0007,0015,A93F,A4D8, 0003,0017,A95E,A4D8
$A9:A208             dx 0009, 0012,003A,A890,A4CA, 001F,001E,A85B,A4C8, 0019,001E,A86E,A4C8, FFFF,FFFD,A7C2,A4C8, 0000,0000,A98A,A4E8, 0000,0000,AAEA,A504, FFF6,0038,A974,A4DA, 0007,001C,A93F,A4D8, 0002,001F,A95E,A4D8

; Crouched
$A9:A252             dx 0007, 0012,0014,A890,A4CA, 0022,FFF7,A85B,A4C8, 001F,FFFA,A87A,A4C8, FFFB,0003,A83B,A4C8, 0000,FFDA,A98A,A4E8, 0004,0000,AAEA,A504, FFF6,0012,A974,A4DA

; Uncrouching
$A9:A28C             dx 0009, 0012,001E,A890,A4CA, 0024,0002,A85B,A4C8, 001F,0004,A87A,A4C8, FFFB,FFFE,A811,A4C8, 0000,FFE4,A98A,A4E8, FFFE,0000,AAEA,A504, FFF6,001C,A974,A4DA, 0007,0000,A93F,A4D8, 0002,0001,A95E,A4D8

; Leaning down
$A9:A2D6             dx 0009, 0012,002E,A890,A4CA, 001F,0011,A85B,A4C8, 001A,0012,A86E,A4C8, FFFB,FFFC,A7F1,A4C8, 0000,FFF4,A98A,A4E8, FFFE,0000,AAEA,A504, FFF6,002C,A974,A4DA, 0007,0010,A93F,A4D8, 0002,0011,A95E,A4D8

; Unused. Brain
$A9:A320             dx 0001, 0000,0000,A586,A4AC ; Used as initial dummy for body and initial for unused instruction system by brain
$A9:A32A             dx 0001, 0000,0000,A5BF,A4AC ; Unused
$A9:A334             dx 0001, 0000,0000,A5F8,A4AC ; Unused
$A9:A33E             dx 0001, 0000,0000,A62C,A4AC ; Unused
$A9:A348             dx 0001, 0000,0000,A660,A4AC ; Unused
$A9:A352             dx 0001, 0000,0000,A69B,A4BA ; Unused
$A9:A35C             dx 0001, 0000,0000,A6D9,A4BA ; Unused
$A9:A366             dx 0001, 0000,0000,A717,A4BA ; Unused
$A9:A370             dx 0001, 0000,0000,A750,A4BA ; Unused
$A9:A37A             dx 0001, 0000,0000,A789,A4BA ; Unused

; Death beam mode
$A9:A384             dx 0009, 0012,003A,A890,A4CA, 001E,001D,A85B,A4C8, 0019,001E,A86E,A4C8, 0000,FFFC,A7C2,A4C8, 0000,0000,A98A,A4E8, 0000,0000,AB70,A51E, FFF6,0038,A974,A4DA, 0007,001C,A93F,A4D8, 0002,001D,A95E,A4D8
$A9:A3CE             dx 0009, 0012,003A,A890,A4CA, 001E,001D,A85B,A4C8, 0019,001E,A86E,A4C8, 0000,FFFC,A7C2,A4C8, 0000,0000,A98A,A4E8, 0000,0000,ABF6,A538, FFF6,0038,A974,A4DA, 0007,001C,A93F,A4D8, 0002,001D,A95E,A4D8
$A9:A418             dx 0009, 0012,003A,A890,A4CA, 001E,001D,A85B,A4C8, 0019,001E,A86E,A4C8, 0000,FFFC,A7C2,A4C8, 0000,0000,A98A,A4E8, 0000,0000,AC76,A552, FFF6,0038,A974,A4DA, 0007,001C,A93F,A4D8, 0002,001D,A95E,A4D8
$A9:A462             dx 0009, 0012,003A,A890,A4CA, 001E,001D,A85B,A4C8, 0019,001E,A86E,A4C8, 0000,FFFC,A7C2,A4C8, 0000,0000,A98A,A4E8, 0000,0000,ACE4,A56C, FFF6,0038,A974,A4DA, 0007,001C,A93F,A4D8, 0002,001D,A95E,A4D8
}


;;; $A4AC: Hitboxes - Mother Brain body ;;;
{
$A9:A4AC             dx 0001, FFEC,FFEB,0010,0017,B5C6,B507
$A9:A4BA             dx 0001, FFEC,FFEB,0013,0017,B5C6,B507
$A9:A4C8             dx 0000
$A9:A4CA             dx 0001, FFE9,FFFF,0017,0007,B5C5,B503
$A9:A4D8             dx 0000
$A9:A4DA             dx 0001, FFE9,FFFE,0017,0007,B5C5,B503
$A9:A4E8             dx 0002, FFE0,FFE8,0014,0034,B5C5,B503, FFE8,FFD6,000D,FFE7,B5C5,B503
$A9:A502             dx 0000
$A9:A504             dx 0002, 0004,FFC5,001C,FFE8,B5C5,B503, 001C,FFD7,0039,FFE2,B5C5,B503
$A9:A51E             dx 0002, 0004,FFC5,001C,FFE8,B5C5,B503, 001C,FFD7,0036,FFE2,B5C5,B503
$A9:A538             dx 0002, 0004,FFC5,001C,FFE8,B5C5,B503, 001D,FFD5,002D,FFE8,B5C5,B503
$A9:A552             dx 0002, 0004,FFC5,001C,FFE8,B5C5,B503, 001D,FFD0,0044,FFD8,B5C5,B503
$A9:A56C             dx 0002, 0004,FFC5,001C,FFE8,B5C5,B503, 001C,FFD7,003A,FFE1,B5C5,B503
}


;;; $A586: Mother Brain spritemaps ;;;
{
$A9:A586             dx 000B, 000C,01,2133, 8002,09,2100, 81E8,04,2108, 81F8,04,2102, 81F8,F4,2120, 8008,00,2104, 8008,F0,211E, 8008,E8,210E, 81F8,E4,210A, 01F0,EC,2122, 81E8,F4,2106
$A9:A5BF             dx 000B, 000C,01,2132, 8002,09,2100, 81E8,04,2108, 81F8,04,2102, 81F8,F4,2120, 8008,00,2104, 8008,F0,211E, 8008,E8,210E, 81F8,E4,210A, 01F0,EC,2122, 81E8,F4,2106
$A9:A5F8             dx 000A, 8002,09,2100, 81E8,04,2108, 81F8,04,2102, 81F8,F4,2120, 8008,00,2104, 8008,F0,211E, 8008,E8,210E, 81F8,E4,210A, 01F0,EC,2122, 81E8,F4,2106
$A9:A62C             dx 000A, 81FF,0E,2124, 81E8,04,2108, 81F8,04,2102, 81F8,F4,2120, 8008,00,2104, 8008,F0,211E, 8008,E8,210E, 81F8,E4,210A, 01F0,EC,2122, 81E8,F4,2106
$A9:A660             dx 000A, 81FC,10,2126, 81E8,04,2108, 81F8,04,2102, 81F8,F4,2120, 8008,00,2104, 8008,F0,211E, 8008,E8,210E, 81F8,E4,210A, 01F0,EC,2122, 81E8,F4,2106
$A9:A694             dx 0001, 81F8,F8,212A
$A9:A69B             dx 000C, 000C,01,2133, 8002,09,2100, 8008,00,2104, 0008,E8,2123, 8008,F0,213E, 81F8,E4,213C, 81F8,F4,2128, 81F8,04,2102, 01F0,0C,214B, 01F0,EC,214A, 81E8,F4,210C, 81E8,FC,211C
$A9:A6D9             dx 000C, 000C,01,2132, 8002,09,2100, 8008,00,2104, 0008,E8,2123, 8008,F0,213E, 81F8,E4,213C, 81F8,F4,2128, 81F8,04,2102, 01F0,0C,214B, 01F0,EC,214A, 81E8,F4,210C, 81E8,FC,211C
$A9:A717             dx 000B, 8002,09,2100, 8008,00,2104, 0008,E8,2123, 8008,F0,213E, 81F8,E4,213C, 81F8,F4,2128, 81F8,04,2102, 01F0,0C,214B, 01F0,EC,214A, 81E8,F4,210C, 81E8,FC,211C
$A9:A750             dx 000B, 81FF,0E,2124, 8008,00,2104, 0008,E8,2123, 8008,F0,213E, 81F8,E4,213C, 81F8,F4,2128, 81F8,04,2102, 01F0,0C,214B, 01F0,EC,214A, 81E8,F4,210C, 81E8,FC,211C
$A9:A789             dx 000B, 81FC,10,2126, 8008,00,2104, 0008,E8,2123, 8008,F0,213E, 81F8,E4,213C, 81F8,F4,2128, 81F8,04,2102, 01F0,0C,214B, 01F0,EC,214A, 81E8,F4,210C, 81E8,FC,211C
$A9:A7C2             dx 0009, 001C,1C,337B, 8014,0C,335A, 800C,14,3369, 000C,0C,3366, 0014,04,F378, 0004,14,3378, 01FC,FC,3347, 81FC,04,3357, 8004,FC,3348
$A9:A7F1             dx 0006, 801D,03,335E, 801D,0B,336E, 800D,0B,3362, 800D,FB,3360, 81FD,03,336C, 81FD,FB,335C
$A9:A811             dx 0008, 0028,00,B377, 0028,F8,3377, 8018,00,B343, 8018,F0,3343, 8010,00,B342, 8000,00,B340, 8010,F0,3342, 8000,F0,3340
$A9:A83B             dx 0006, 801D,ED,B35E, 801D,E5,B36E, 800D,E5,B362, 800D,F5,B360, 81FD,ED,B36C, 81FD,F5,B35C
$A9:A85B             dx 0001, 81F8,F8,3364
$A9:A862             dx 0002, 81F8,10,3388, 81F8,00,3345
$A9:A86E             dx 0002, 81F3,10,338A, 81F7,00,3381
$A9:A87A             dx 0004, 01FB,0E,3376, 81EB,0E,3386, 81FB,FE,3384, 81F3,FE,3383
$A9:A890             dx 0004, 0010,00,3390, 0008,00,3380, 81F8,F8,338E, 81E8,F8,338C
$A9:A8A6             dx 0009, 001C,1C,277B, 8014,0C,275A, 800C,14,2769, 000C,0C,2766, 0014,04,E778, 0004,14,2778, 01FC,FC,2747, 81FC,04,2757, 8004,FC,2748
$A9:A8D5             dx 0006, 801D,03,275E, 801D,0B,276E, 800D,0B,2762, 800D,FB,2760, 81FD,03,276C, 81FD,FB,275C ; Unused
$A9:A8F5             dx 0008, 0028,00,A777, 0028,F8,2777, 8018,00,A743, 8018,F0,2743, 8010,00,A742, 8000,00,A740, 8010,F0,2742, 8000,F0,2740 ; Unused
$A9:A91F             dx 0006, 801D,ED,A75E, 801D,E5,A76E, 800D,E5,A762, 800D,F5,A760, 81FD,ED,A76C, 81FD,F5,A75C ; Unused
$A9:A93F             dx 0001, 81F8,F8,2764
$A9:A946             dx 0002, 81F8,10,2788, 81F8,00,2745 ; Unused
$A9:A952             dx 0002, 81F3,10,278A, 81F7,00,2781 ; Unused
$A9:A95E             dx 0004, 01FB,0E,2776, 81EB,0E,2786, 81FB,FE,2784, 81F3,FE,2783
$A9:A974             dx 0004, 0010,00,2790, 0008,00,2780, 81F8,F8,278E, 81E8,F8,278C

$A9:A98A             dx FFFE,
                        2080,0004, 2338,2338,31B7,31B8,
                        20C0,0004, 2338,31B9,31BA,31BB,
                        2100,0004, 2338,31BC,31BD,31BE,
                        2140,000A, 31BF,31C0,31C1,31C2,31C3,31C4,31C5,31C6,31C7,31C8,
                        2180,000A, 31CA,31CB,31CC,31CD,31CE,31CF,31D0,2338,2338,2338,
                        21C0,000A, 31D1,31D2,31D3,31D4,31D5,31D6,31D7,31D8,2338,2338,
                        2200,000A, 31D9,31DA,31DB,31DC,31DD,31DE,31DF,31E0,2338,2338,
                        2240,000A, 31E1,31E2,31E3,31E4,31E5,31E6,31E7,2338,2338,2338,
                        2280,000A, 2338,31E8,31E9,31EA,31EB,31EC,31ED,2338,2338,2338,
                        22C0,0004, 2338,2338,31EE,31EF,
                        FFFF

; Unused
$A9:AA4E             dx FFFE,
                        2084,0002, 2338,2338,
                        20C2,0003, 2338,2338,2338,
                        2102,0003, 2338,2338,2338,
                        2140,000A, 2338,2338,2338,2338,2338,2338,2338,2338,2338,2338,
                        2180,0007, 2338,2338,2338,2338,2338,2338,2338,
                        21C0,0008, 2338,2338,2338,2338,2338,2338,2338,2338,
                        2200,0008, 2338,2338,2338,2338,2338,2338,2338,2338,
                        2240,0007, 2338,2338,2338,2338,2338,2338,2338,
                        2282,0006, 2338,2338,2338,2338,2338,2338,
                        22C4,0002, 2338,2338,
                        FFFF

$A9:AAEA             dx FFFE,
                        2006,000B, 2338,2338,3167,3168,3169,2338,2338,2338,2338,2338,2338,
                        2046,000B, 2338,316A,316B,316C,316D,316E,2338,2338,2338,2338,2338,
                        2086,000B, 31B8,316F,3170,3171,3172,3173,3174,3186,3187,2338,2338,
                        20C6,000B, 31BB,3177,3178,3179,317A,317B,317C,3188,3189,2338,2338,
                        2106,000B, 31BE,317F,3180,3181,3182,3183,3184,3185,2338,2338,2338,
                        FFFF

$A9:AB70             dx FFFE,
                        2006,000B, 2338,2338,3167,3168,3169,2338,2338,2338,2338,2338,2338,
                        2046,000B, 2338,316A,316B,316C,316D,316E,2338,2338,2338,2338,2338,
                        2086,000B, 31B8,316F,3170,3171,3172,3173,3174,3175,3176,2338,2338,
                        20C6,000B, 31BB,3177,3178,3179,317A,317B,317C,317D,317E,2338,2338,
                        2106,000B, 31BE,317F,3180,3181,3182,3183,3184,3185,2338,2338,2338,
                        FFFF

$A9:ABF6             dx FFFE,
                        2006,0001, 2338,
                        200A,0002, 318A,318B,
                        2018,0002, 2338,2338,
                        2046,0001, 2338,
                        204A,0003, 318C,318D,318E,
                        2058,0002, 2338,2338,
                        2086,000B, 31B8,318F,3190,3191,3192,3193,3194,2338,2338,2338,2338,
                        20C6,000B, 31BB,3195,3196,3197,3198,3199,319A,319B,2338,2338,2338,
                        2106,0001, 31BE,
                        210C,0004, 319C,319D,319E,319F,
                        2118,0002, 2338,2338,
                        FFFF

$A9:AC76             dx FFFE,
                        200A,0003, 3167,31A0,31A1,
                        2046,0001, 31B6,
                        204A,0004, 31A2,31A3,31A4,31A5,
                        2056,0003, 31A6,31A7,31A8,
                        2088,000A, 316F,31A9,31AA,31AB,31AC,31AD,31AE,31AF,31B0,31B1,
                        20C8,0007, 3177,3178,3178,31B2,31B3,31B4,31B5,
                        2106,0001, 31BE,
                        210C,0004, 319C,319D,319E,319F,
                        2118,0002, 2338,2338,
                        FFFF

$A9:ACE4             dx FFFE,
                        200C,0002, 3168,3169,
                        2046,0001, 2338,
                        204A,0004, 316B,316C,316D,316E,
                        2056,0003, 2338,2338,2338,
                        208A,0009, 3170,3171,3172,3173,3174,3186,3187,2338,2338,
                        20CC,0006, 3179,317A,317B,317C,3188,3189,
                        210C,0004, 3181,3182,3183,3184,
                        FFFF

$A9:AD3E             dx 0009, 8008,08,21E4, 81F8,08,21E2, 81E8,08,21E0, 8008,F8,21C4, 81F8,F8,21C2, 81E8,F8,21C0, 8008,E8,21A4, 81F8,E8,21A2, 81E8,E8,21A0
$A9:AD6D             dx 000A, 8014,08,21EC, 8004,08,21EA, 81F4,08,21E8, 81E4,08,21E6, 8004,F8,21CA, 81F4,F8,21C8, 81E4,F8,21C6, 8004,E8,21AA, 81F4,E8,21A8, 81E4,E8,21A6

; Mother Brain tubes falling 0
$A9:ADA1             dx 000A, 0008,E4,2F5D, 0008,DC,2F4D, 0000,E4,2F5D, 0000,DC,2F4D, C3F0,DC,2F42, 01F8,1C,2F51, 01F0,1C,2F50, C3F0,FC,2F47, C3F0,EC,AF40, C3F0,0C,2F40

; Mother Brain tubes falling 1
$A9:ADD5             dx 000A, 01F0,E4,6F5D, 01F0,DC,6F4D, 01F8,E4,6F5D, 01F8,DC,6F4D, C200,DC,6F42, 0000,1C,6F51, 0008,1C,6F50, C200,FC,6F47, C200,EC,EF40, C200,0C,6F40

; Mother Brain tubes falling 2
$A9:AE09             dx 0008, C3F8,E4,2F44, 0000,14,2F51, 01F8,14,2F50, C3F8,04,2F4B, 0000,FC,2F51, 01F8,FC,2F50, 0000,F4,2F51, 01F8,F4,2F50

; Mother Brain tubes falling 3
$A9:AE33             dx 0008, C3F8,E4,6F44, 01F8,14,6F51, 0000,14,6F50, C3F8,04,2F4B, 01F8,FC,6F51, 0000,FC,6F50, 01F8,F4,6F51, 0000,F4,6F50

; Mother Brain tubes falling 4
$A9:AE5D             dx 001A, 0000,E0,6F70, 01F8,E0,2F70, 0000,D8,6F60, 01F8,D8,2F60, 0008,28,2F6D, 0000,28,2F6D, 01F8,28,2F6D, 01F0,28,2F6D, 0008,20,2F6D, 0000,20,2F6D, 01F8,20,2F6D, 01F0,20,2F6D, 0008,18,2F6C, 0000,18,2F6C, 01F8,18,2F6C, 01F0,18,2F6C, C200,F8,6F49, C3F0,F8,2F49, C200,08,6F46, C3F0,08,2F46, C200,E8,2F40, C3F0,E8,2F40, C200,D8,EF4E, C3F0,D8,AF4E, C200,D0,EF5E, C3F0,D0,AF5E
}


;;; $AEE1..B3B5: Mother Brain death sequence ;;;
{
;;; $AEE1: Mother Brain body function - third phase - death sequence - move to back of room ;;;
{
$A9:AEE1 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:AEE4 09 00 04    ORA #$0400             ;} Set Mother Brain body as intangible
$A9:AEE7 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A9:AEEA AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A9:AEED 09 00 04    ORA #$0400             ;} Set Mother Brain brain as intangible
$A9:AEF0 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A9:AEF3 A9 00 00    LDA #$0000             ;\
$A9:AEF6 8F 08 78 7E STA $7E7808[$7E:7808]  ;} Disable all Mother Brain hitboxes
$A9:AEFA A0 06 00    LDY #$0006             ;\
$A9:AEFD A9 28 00    LDA #$0028             ;} Make Mother Brain walk backwards medium towards X position 28h
$A9:AF00 20 47 C6    JSR $C647  [$A9:C647]  ;/
$A9:AF03 B0 01       BCS $01    [$AF06]     ; If not reached X position 28h:
$A9:AF05 60          RTS                    ; Return

$A9:AF06 A9 12 AF    LDA #$AF12             ;\
$A9:AF09 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $AF12
$A9:AF0C A9 80 00    LDA #$0080             ;\
$A9:AF0F 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 80h
}


;;; $AF12: Mother Brain body function - third phase - death sequence - idle whilst exploding ;;;
{
$A9:AF12 20 22 B0    JSR $B022  [$A9:B022]  ; Generate smoky explosions around Mother Brain body
$A9:AF15 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:AF18 10 06       BPL $06    [$AF20]     ; If [Mother Brain body function timer] >= 0: return
$A9:AF1A A9 21 AF    LDA #$AF21             ;\
$A9:AF1D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $AF21

$A9:AF20 60          RTS
}


;;; $AF21: Mother Brain body function - third phase - death sequence - stumble to middle of room and drool ;;;
{
$A9:AF21 20 22 B0    JSR $B022  [$A9:B022]  ; Generate smoky explosions around Mother Brain body
$A9:AF24 A0 02 00    LDY #$0002             ;\
$A9:AF27 A9 60 00    LDA #$0060             ;} Make Mother Brain walk forwards really fast towards X position 60h
$A9:AF2A 20 01 C6    JSR $C601  [$A9:C601]  ;/
$A9:AF2D 90 F1       BCC $F1    [$AF20]     ; If not reached X position 60h: return
$A9:AF2F A9 39 9C    LDA #$9C39             ;\
$A9:AF32 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C39 (dying drool)
$A9:AF35 A9 06 00    LDA #$0006             ;\
$A9:AF38 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 6 (lower)
$A9:AF3C 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 6 (lower)
$A9:AF40 A9 00 05    LDA #$0500             ;\
$A9:AF43 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 500h
$A9:AF47 A9 54 AF    LDA #$AF54             ;\
$A9:AF4A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $AF54
$A9:AF4D A9 20 00    LDA #$0020             ;\
$A9:AF50 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 20h
$A9:AF53 60          RTS
}


;;; $AF54: Mother Brain body function - third phase - death sequence - disable brain effects ;;;
{
$A9:AF54 20 22 B0    JSR $B022  [$A9:B022]  ; Generate smoky explosions around Mother Brain body
$A9:AF57 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:AF5A 10 C4       BPL $C4    [$AF20]     ; If [Mother Brain body function timer] >= 0: return
$A9:AF5C A9 00 00    LDA #$0000             ;\
$A9:AF5F 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 0 (nothing)
$A9:AF63 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 0 (nothing)
$A9:AF67 8F 64 78 7E STA $7E7864[$7E:7864]  ; Disable Mother Brain drool generation
$A9:AF6B 8F 68 78 7E STA $7E7868[$7E:7868]  ; Disable Mother Brain small purple breath generation
$A9:AF6F 8F 60 78 7E STA $7E7860[$7E:7860]  ; Disable Mother Brain brain palette handling
$A9:AF73 8F 62 78 7E STA $7E7862[$7E:7862]  ; Disable Mother Brain health-based palette handling
$A9:AF77 A2 1C 00    LDX #$001C             ;\
                                            ;|
$A9:AF7A BF 22 C1 7E LDA $7EC122,x[$7E:C13E];|
$A9:AF7E 9F E2 C1 7E STA $7EC1E2,x[$7E:C1FE];} Sprite palettes 7 colours 1..Eh = [sprite palettes 1 colours 1..Eh]
$A9:AF82 CA          DEX                    ;|
$A9:AF83 CA          DEX                    ;|
$A9:AF84 10 F4       BPL $F4    [$AF7A]     ;/
$A9:AF86 22 D5 E3 AD JSL $ADE3D5[$AD:E3D5]  ; Mother Brain health-based palette handling
$A9:AF8A A9 00 0E    LDA #$0E00             ;\
$A9:AF8D 8F 1A 78 7E STA $7E781A[$7E:781A]  ;} Mother Brain brain palette index = E00h (palette 7)
$A9:AF91 9C F0 0F    STZ $0FF0  [$7E:0FF0]  ; Mother Brain death explosion interval timer = 0
$A9:AF94 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Mother Brain death explosion index = 0
$A9:AF97 A9 9D AF    LDA #$AF9D             ;\
$A9:AF9A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $AF9D
}


;;; $AF9D: Mother Brain body function - third phase - death sequence - set up body fade out ;;;
{
; Function timer is already negative coming into this function...
$A9:AF9D 20 31 B0    JSR $B031  [$A9:B031]  ; Generate mixed explosions around Mother Brain body
$A9:AFA0 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:AFA3 30 01       BMI $01    [$AFA6]     ; If [Mother Brain body function timer] >= 0:
$A9:AFA5 60          RTS                    ; Return

$A9:AFA6 A9 00 00    LDA #$0000             ;\
$A9:AFA9 8F 2E 80 7E STA $7E802E[$7E:802E]  ;} Mother Brain grey transition counter = 0
$A9:AFAD A9 B6 AF    LDA #$AFB6             ;\
$A9:AFB0 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $AFB6
$A9:AFB3 9C B2 0F    STZ $0FB2  [$7E:0FB2]  ; Mother Brain body function timer = 0
}


;;; $AFB6: Mother Brain body function - third phase - death sequence - fade out body ;;;
{
$A9:AFB6 22 1C F4 AD JSL $ADF41C[$AD:F41C]  ; Handle Mother Brain body flickering
$A9:AFBA 20 31 B0    JSR $B031  [$A9:B031]  ; Generate mixed explosions around Mother Brain body
$A9:AFBD CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:AFC0 10 16       BPL $16    [$AFD8]     ; If [Mother Brain body function timer] >= 0: return
$A9:AFC2 A9 10 00    LDA #$0010             ;\
$A9:AFC5 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h
$A9:AFC8 AF 2E 80 7E LDA $7E802E[$7E:802E]  ;\
$A9:AFCC 1A          INC A                  ;} Increment Mother Brain grey transition counter
$A9:AFCD 8F 2E 80 7E STA $7E802E[$7E:802E]  ;/
$A9:AFD1 3A          DEC A                  ; A = [Mother Brain grey transition counter] - 1
$A9:AFD2 22 B4 E9 AD JSL $ADE9B4[$AD:E9B4]  ; Fade Mother Brain palette to black
$A9:AFD6 B0 01       BCS $01    [$AFD9]     ; If finished fading to black: go to BRANCH_FADED_TO_BLACK

$A9:AFD8 60          RTS                    ; Return

; BRANCH_FADED_TO_BLACK
$A9:AFD9 A9 C6 02    LDA #$02C6             ;\
$A9:AFDC 8D 9A 17    STA $179A  [$7E:179A]  ;} Enemy BG2 tilemap size = 2C6h
$A9:AFDF AA          TAX                    ;\
$A9:AFE0 8B          PHB                    ;|
$A9:AFE1 F4 7E 7E    PEA $7E7E              ;|
$A9:AFE4 AB          PLB                    ;|
$A9:AFE5 AB          PLB                    ;|
$A9:AFE6 A9 38 03    LDA #$0338             ;|
                                            ;} $7E:2000..22C7 = 0338h (harmless off by one error)
$A9:AFE9 9D 00 20    STA $2000,x[$7E:22C6]  ;|
$A9:AFEC CA          DEX                    ;|
$A9:AFED CA          DEX                    ;|
$A9:AFEE 10 F9       BPL $F9    [$AFE9]     ;|
$A9:AFF0 AB          PLB                    ;/
$A9:AFF1 A9 01 00    LDA #$0001             ;\
$A9:AFF4 8D 1E 0E    STA $0E1E  [$7E:0E1E]  ;} Request enemy BG2 tilemap VRAM transfer
$A9:AFF7 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:AFFA 09 00 01    ORA #$0100             ;|
$A9:AFFD 29 FF DF    AND #$DFFF             ;} Set Mother Brain body as invisible and disable processing instructions
$A9:B000 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A9:B003 9C 88 0F    STZ $0F88  [$7E:0F88]  ; Mother Brain body extra properties = 0
$A9:B006 A9 13 B0    LDA #$B013             ;\
$A9:B009 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B013
$A9:B00C A9 10 00    LDA #$0010             ;\
$A9:B00F 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h

$A9:B012 60          RTS
}


;;; $B013: Mother Brain body function - third phase - death sequence - final few explosions ;;;
{
$A9:B013 20 31 B0    JSR $B031  [$A9:B031]  ; Generate mixed explosions around Mother Brain body
$A9:B016 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B019 10 F7       BPL $F7    [$B012]     ; If [Mother Brain body function timer] >= 0: return
$A9:B01B A9 15 B1    LDA #$B115             ;\
$A9:B01E 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B115
$A9:B021 60          RTS
}


;;; $B022: Generate smoky explosions around Mother Brain body ;;;
{
$A9:B022 A9 0F B1    LDA #$B10F             ;\
$A9:B025 85 16       STA $16    [$7E:0016]  ;} $16 = $B10F
$A9:B027 A9 02 00    LDA #$0002             ;\
$A9:B02A 85 18       STA $18    [$7E:0018]  ;} $18 = 2 (number of simultaneous explosions)
$A9:B02C A9 10 00    LDA #$0010             ; A = 10h (Mother Brain death explosion interval length)
$A9:B02F 80 0D       BRA $0D    [$B03E]     ; Go to generate explosions around Mother Brain body
}


;;; $B031: Generate mixed explosions around Mother Brain body ;;;
{
$A9:B031 A9 09 B1    LDA #$B109             ;\
$A9:B034 85 16       STA $16    [$7E:0016]  ;} $16 = $B109
$A9:B036 A9 04 00    LDA #$0004             ;\
$A9:B039 85 18       STA $18    [$7E:0018]  ;} $18 = 4 (number of simultaneous explosions)
$A9:B03B A9 08 00    LDA #$0008             ; A = 8 (Mother Brain death explosion interval length)
}


;;; $B03E: Generate explosions around Mother Brain body ;;;
{
;; Parameters:
;;     A: Mother Brain death explosion interval length
;;     $16: Explosion type set pointer
;;     $18: Number of simultaneous explosions
$A9:B03E CE F0 0F    DEC $0FF0  [$7E:0FF0]  ; Decrement Mother Brain death explosion interval timer
$A9:B041 10 CF       BPL $CF    [$B012]     ; If [Mother Brain death explosion interval timer] >= 0: return
$A9:B043 8D F0 0F    STA $0FF0  [$7E:0FF0]  ; Mother Brain death explosion interval timer = [A]
$A9:B046 CE F2 0F    DEC $0FF2  [$7E:0FF2]  ; Decrement Mother Brain death explosion index
$A9:B049 10 06       BPL $06    [$B051]     ; If [Mother Brain death explosion index] < 0:
$A9:B04B A9 06 00    LDA #$0006             ;\
$A9:B04E 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Mother Brain death explosion index = 6

$A9:B051 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A9:B054 0A          ASL A                  ;|
$A9:B055 0A          ASL A                  ;|
$A9:B056 0A          ASL A                  ;} X = [Mother Brain death explosion index] * 10h
$A9:B057 0A          ASL A                  ;|
$A9:B058 AA          TAX                    ;/
$A9:B059 A5 18       LDA $18    [$7E:0018]  ; A = [$18] (loop counter)

; LOOP
$A9:B05B 48          PHA
$A9:B05C DA          PHX
$A9:B05D BD 99 B0    LDA $B099,x[$A9:B0A9]  ;\
$A9:B060 85 12       STA $12    [$7E:0012]  ;} $12 = [$B099 + [X]] (X offset from Mother Brain body)
$A9:B062 BD 9B B0    LDA $B09B,x[$A9:B0AB]  ;\
$A9:B065 85 14       STA $14    [$7E:0014]  ;} $14 = [$B099 + [X] + 2] (Y offset from Mother Brain body)
$A9:B067 A6 16       LDX $16    [$7E:0016]  ;\
$A9:B069 BC 00 00    LDY $0000,x[$A9:B10F]  ;} Y = [[$16]]
$A9:B06C 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A9:B070 C9 00 40    CMP #$4000             ;\
$A9:B073 90 0B       BCC $0B    [$B080]     ;} If [random number] >= 4000h:
$A9:B075 BC 02 00    LDY $0002,x[$A9:B111]  ; Y = [[$16] + 2]
$A9:B078 C9 00 E0    CMP #$E000             ;\
$A9:B07B 90 03       BCC $03    [$B080]     ;} If [random number] >= E000h:
$A9:B07D BC 04 00    LDY $0004,x[$A9:B113]  ; Y = [[$16] + 4]

$A9:B080 98          TYA                    ;\
$A9:B081 A0 13 CB    LDY #$CB13             ;} Spawn Mother Brain's death explosion enemy projectile with parameter [Y]
$A9:B084 22 97 80 86 JSL $868097[$86:8097]  ;/
$A9:B088 FA          PLX
$A9:B089 68          PLA
$A9:B08A E8          INX                    ;\
$A9:B08B E8          INX                    ;|
$A9:B08C E8          INX                    ;} X += 4
$A9:B08D E8          INX                    ;/
$A9:B08E 3A          DEC A                  ; Decrement A
$A9:B08F D0 CA       BNE $CA    [$B05B]     ; If [A] != 0: go to LOOP
$A9:B091 A9 13 00    LDA #$0013             ;\
$A9:B094 22 39 91 80 JSL $809139[$80:9139]  ;} Queue sound 13h, sound library 3, max queued sounds allowed = 3 (Mother Brain exploding)
$A9:B098 60          RTS

$A9:B099             dw 0024,FFDB, FFED,FFF1, FFFC,000D, 001D,0019,
                        0011,FFC9, 001E,FFEA, FFFD,FFFB, 0000,0028,
                        0034,FFDE, FFFD,FFF1, 000C,0013, 0019,002C,
                        0004,FFD5, FFF4,FFEA, 000D,FFFE, FFF8,0034,
                        FFFE,FFDF, 000A,FFF6, FFF2,0010, 0006,003B,
                        0014,FFD7, 0004,FFEA, FFEC,0003, FFE5,0039,
                        000A,FFE1, FFEC,FFF8, 0000,0017, 001E,003D

; Enemy projectile parameters
;     0: small explosion
;     1: smoke
;     2: big explosion
;                        _____________ 25% chance
;                       |     ________ 62.5% chance
;                       |    |     ___ 12.5% chance
;                       |    |    |
$A9:B109             dw 0000,0001,0002
$A9:B10F             dw 0001,0001,0001
}


;;; $B115: Mother Brain body function - third phase - death sequence - realise decapitation ;;;
{
$A9:B115 A9 29 9C    LDA #$9C29             ;\
$A9:B118 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C29 (decapitated)
$A9:B11B A9 D0 87    LDA #$87D0             ;\
$A9:B11E 8D E8 0F    STA $0FE8  [$7E:0FE8]  ;} Mother Brain brain function = $87D0 (stop drawing neck)
$A9:B121 A9 00 00    LDA #$0000             ;\
$A9:B124 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 0
$A9:B127 A9 2D B1    LDA #$B12D             ;\
$A9:B12A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B12D
}


;;; $B12D: Mother Brain body function - third phase - death sequence - brain falls to ground ;;;
{
$A9:B12D AD B2 0F    LDA $0FB2  [$7E:0FB2]  ;\
$A9:B130 18          CLC                    ;|
$A9:B131 69 20 00    ADC #$0020             ;} Mother Brain body function timer += 20h
$A9:B134 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;/
$A9:B137 EB          XBA                    ;\
$A9:B138 29 FF 00    AND #$00FF             ;|
$A9:B13B 18          CLC                    ;} Mother Brain brain Y position += [Mother Brain body function timer] / 100h
$A9:B13C 6D BE 0F    ADC $0FBE  [$7E:0FBE]  ;/
$A9:B13F C9 C4 00    CMP #$00C4             ;\
$A9:B142 90 16       BCC $16    [$B15A]     ;} If [Mother Brain brain Y position] >= C4h:
$A9:B144 A9 02 00    LDA #$0002             ;\
$A9:B147 22 0B F4 AD JSL $ADF40B[$AD:F40B]  ;} Enable earthquake type 2 for 20 frames (BG1 only, 1 pixel displacement, diagonal)
$A9:B14B A9 5E B1    LDA #$B15E             ;\
$A9:B14E 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B15E
$A9:B151 A9 00 01    LDA #$0100             ;\
$A9:B154 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 100h (no effect)
$A9:B157 A9 C4 00    LDA #$00C4             ; Mother Brain brain Y position = C4h

$A9:B15A 8D BE 0F    STA $0FBE  [$7E:0FBE]
$A9:B15D 60          RTS
}


;;; $B15E: Mother Brain body function - third phase - death sequence - load corpse tiles ;;;
{
$A9:B15E A2 03 90    LDX #$9003             ;\
$A9:B161 20 BE C5    JSR $C5BE  [$A9:C5BE]  ;} Load Mother Brain's corpse tiles
$A9:B164 90 0C       BCC $0C    [$B172]     ; If not finished loading: return
$A9:B166 A9 73 B1    LDA #$B173             ;\
$A9:B169 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B173
$A9:B16C A9 20 00    LDA #$0020             ;\
$A9:B16F 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 20h

$A9:B172 60          RTS
}


;;; $B173: Mother Brain body function - third phase - death sequence - set up fade to grey ;;;
{
$A9:B173 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B176 10 FA       BPL $FA    [$B172]     ; If [Mother Brain body function timer] >= 0: return
$A9:B178 A9 00 00    LDA #$0000             ;\
$A9:B17B 8F 2E 80 7E STA $7E802E[$7E:802E]  ;} Mother Brain grey transition counter = 0
$A9:B17F A9 89 B1    LDA #$B189             ;\
$A9:B182 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B189
$A9:B185 9C B2 0F    STZ $0FB2  [$7E:0FB2]  ; Mother Brain body function timer = 0
$A9:B188 60          RTS
}


;;; $B189: Mother Brain body function - third phase - death sequence - fade to grey ;;;
{
$A9:B189 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B18C 10 16       BPL $16    [$B1A4]     ; If [Mother Brain body function timer] >= 0: return
$A9:B18E AF 2E 80 7E LDA $7E802E[$7E:802E]  ;\
$A9:B192 1A          INC A                  ;} Increment Mother Brain grey transition counter
$A9:B193 8F 2E 80 7E STA $7E802E[$7E:802E]  ;/
$A9:B197 3A          DEC A                  ; A = [Mother Brain grey transition counter] - 1
$A9:B198 22 E9 F0 AD JSL $ADF0E9[$AD:F0E9]  ; Transition Mother Brain palette to grey - real death
$A9:B19C B0 07       BCS $07    [$B1A5]     ; If finished transitioning: go to BRANCH_FINISHED_TRAMSITION
$A9:B19E A9 10 00    LDA #$0010             ;\
$A9:B1A1 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h

$A9:B1A4 60          RTS                    ; Return

; BRANCH_FINISHED_TRAMSITION
$A9:B1A5 A9 25 9D    LDA #$9D25             ;\
$A9:B1A8 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9D25 (corpse)
$A9:B1AB A9 B8 B1    LDA #$B1B8             ;\
$A9:B1AE 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B1B8
$A9:B1B1 A9 00 01    LDA #$0100             ;\
$A9:B1B4 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 100h
$A9:B1B7 60          RTS
}


;;; $B1B8: Mother Brain body function - third phase - death sequence - corpse tips over ;;;
{
$A9:B1B8 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B1BB 30 01       BMI $01    [$B1BE]     ; If [Mother Brain body function timer] >= 0:
$A9:B1BD 60          RTS                    ; Return

$A9:B1BE A9 D5 B1    LDA #$B1D5             ;\
$A9:B1C1 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B1D5
$A9:B1C4 AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A9:B1C7 09 00 04    ORA #$0400             ;} Set Mother Brain brain as intangible
$A9:B1CA 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A9:B1CD A9 00 00    LDA #$0000             ;\
$A9:B1D0 8F 08 78 7E STA $7E7808[$7E:7808]  ;} Disable all Mother Brain hitboxes
$A9:B1D4 60          RTS
}


;;; $B1D5: Mother Brain body function - third phase - death sequence - corpse rots away ;;;
{
$A9:B1D5 A2 40 00    LDX #$0040             ;\
$A9:B1D8 20 12 DB    JSR $DB12  [$A9:DB12]  ;} Process Mother Brain brain corpse rotting
$A9:B1DB 90 0B       BCC $0B    [$B1E8]     ; If not finished rotting:
$A9:B1DD A2 40 00    LDX #$0040             ;\
$A9:B1E0 BF 26 88 7E LDA $7E8826,x[$7E:8866];|
$A9:B1E4 AA          TAX                    ;} Process Mother Brain brain corpse rotting VRAM transfers
$A9:B1E5 4C B9 DC    JMP $DCB9  [$A9:DCB9]  ;/

$A9:B1E8 AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A9:B1EB 09 00 01    ORA #$0100             ;|
$A9:B1EE 29 FF DF    AND #$DFFF             ;} Set Mother Brain brain as invisible and disable processing instructions
$A9:B1F1 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A9:B1F4 9C C8 0F    STZ $0FC8  [$7E:0FC8]  ; Mother Brain brain extra properties = 0
$A9:B1F7 A9 00 00    LDA #$0000             ;\
$A9:B1FA 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$A9:B1FE A9 24 FF    LDA #$FF24             ;\
$A9:B201 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue boss fight 1 music data
$A9:B205 A9 11 B2    LDA #$B211             ;\
$A9:B208 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B211
$A9:B20B A9 14 00    LDA #$0014             ;\
$A9:B20E 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 14h
}


;;; $B211: Mother Brain body function - third phase - death sequence - 20 frame delay ;;;
{
$A9:B211 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B214 10 0C       BPL $0C    [$B222]     ; If [Mother Brain body function timer] >= 0: return
$A9:B216 9C BA 0F    STZ $0FBA  [$7E:0FBA]  ; Mother Brain brain X position = 0
$A9:B219 9C BE 0F    STZ $0FBE  [$7E:0FBE]  ; Mother Brain brain Y position = 0
$A9:B21C A9 58 B2    LDA #$B258             ;\
$A9:B21F 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B258

$A9:B222 60          RTS
}


;;; $B223: Corpse rotting rot entry finished hook - Mother Brain ;;;
{
$A9:B223 DA          PHX
$A9:B224 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:B227 29 1F 00    AND #$001F             ;|
$A9:B22A 18          CLC                    ;|
$A9:B22B 6D BA 0F    ADC $0FBA  [$7E:0FBA]  ;} $12 = [Mother Brain brain X position] - 10h + [random number] % 1Fh
$A9:B22E 18          CLC                    ;|
$A9:B22F 69 F0 FF    ADC #$FFF0             ;|
$A9:B232 85 12       STA $12    [$7E:0012]  ;/
$A9:B234 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:B237 18          CLC                    ;|
$A9:B238 69 10 00    ADC #$0010             ;} $14 = [Mother Brain brain Y position] + 10h
$A9:B23B 85 14       STA $14    [$7E:0014]  ;/
$A9:B23D A9 0A 00    LDA #$000A             ; A = Ah (corpse dust cloud)
$A9:B240 A0 09 E5    LDY #$E509             ;\
$A9:B243 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:B247 AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A9:B24A 29 07 00    AND #$0007             ;} If [number of times main enemy routine has been executed] % 8 = 0:
$A9:B24D D0 07       BNE $07    [$B256]     ;/
$A9:B24F A9 10 00    LDA #$0010             ;\
$A9:B252 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 10h, sound library 2, max queued sounds allowed = 3 (lava/acid damaging Samus)

$A9:B256 FA          PLX
$A9:B257 60          RTS
}


;;; $B258: Mother Brain body function - third phase - death sequence - load escape timer tiles ;;;
{
$A9:B258 8B          PHB                    ;\
$A9:B259 F4 00 A6    PEA $A600              ;|
$A9:B25C AB          PLB                    ;|
$A9:B25D AB          PLB                    ;|
$A9:B25E A2 CB C4    LDX #$C4CB             ;} Load escape timer tiles
$A9:B261 20 BE C5    JSR $C5BE  [$A9:C5BE]  ;|
$A9:B264 AB          PLB                    ;|
$A9:B265 90 69       BCC $69    [$B2D0]     ;/
$A9:B267 A9 6D B2    LDA #$B26D             ;\
$A9:B26A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B26D
}


;;; $B26D: Mother Brain body function - third phase - death sequence - start escape sequence ;;;
{
$A9:B26D A2 2F 90    LDX #$902F             ;\
$A9:B270 20 BE C5    JSR $C5BE  [$A9:C5BE]  ;} Load exploded escape door particles tiles
$A9:B273 90 5B       BCC $5B    [$B2D0]     ; If not finished loading: return
$A9:B275 A0 34 95    LDY #$9534             ;\
$A9:B278 A2 22 01    LDX #$0122             ;|
$A9:B27B A9 0E 00    LDA #$000E             ;} Sprite palette 1 colours 1..Fh = [$9534..51] (exploded escape door particles)
$A9:B27E 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:B282 A9 07 00    LDA #$0007             ;\
$A9:B285 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 2 music track (escape music)
$A9:B289 A9 05 00    LDA #$0005             ;\
$A9:B28C 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 2 pixel displacement, diagonal
$A9:B28F A9 FF FF    LDA #$FFFF             ;\
$A9:B292 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = FFFFh
$A9:B295 A0 C9 FF    LDY #$FFC9             ;\
$A9:B298 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $FFC9 (Tourian 8 - shutter red flashing)
$A9:B29C A0 CD FF    LDY #$FFCD             ;\
$A9:B29F 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $FFCD (Tourian 10h - background red flashing)
$A9:B2A3 A0 D1 FF    LDY #$FFD1             ;\
$A9:B2A6 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $FFD1 (Tourian 20h - general level red flashing)
$A9:B2AA A0 D5 FF    LDY #$FFD5             ;\
$A9:B2AD 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $FFD5 (Tourian 40h - red flashing arkanoid blocks and red orbs)
$A9:B2B1 A9 00 00    LDA #$0000             ;\
$A9:B2B4 8F 44 78 7E STA $7E7844[$7E:7844]  ;} Disable unpause hook
$A9:B2B8 22 3F C2 A6 JSL $A6C23F[$A6:C23F]  ; Set up Zebes escape typewriter
$A9:B2BC A9 20 00    LDA #$0020             ;\
$A9:B2BF 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 20h
$A9:B2C2 A0 D1 B2    LDY #$B2D1             ; Mother Brain body function = $B2D1
$A9:B2C5 AD E2 09    LDA $09E2  [$7E:09E2]  ;\
$A9:B2C8 D0 03       BNE $03    [$B2CD]     ;} If Japanese text is disabled:
$A9:B2CA A0 E3 B2    LDY #$B2E3             ; Mother Brain body function = $B2E3

$A9:B2CD 8C A8 0F    STY $0FA8  [$7E:0FA8]

$A9:B2D0 60          RTS
}


;;; $B2D1: Mother Brain body function - third phase - death sequence - spawn time bomb set Japanese text ;;;
{
$A9:B2D1 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B2D4 10 0D       BPL $0D    [$B2E3]     ; If [Mother Brain body function timer] < 0:
$A9:B2D6 A9 E3 B2    LDA #$B2E3             ;\
$A9:B2D9 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B2E3
$A9:B2DC A0 BB CB    LDY #$CBBB             ;\
$A9:B2DF 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn enemy projectile $CBBB (time bomb set Japanese text)
}


;;; $B2E3: Mother Brain body function - third phase - death sequence - type out Zebes escape text ;;;
{
$A9:B2E3 A9 10 26    LDA #$2610             ; A = 2610h
$A9:B2E6 22 A7 C2 A6 JSL $A6C2A7[$A6:C2A7]  ; Handle typewriter text
$A9:B2EA 90 0C       BCC $0C    [$B2F8]     ; If not finished typing: return
$A9:B2EC A9 F9 B2    LDA #$B2F9             ;\
$A9:B2EF 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B2F9
$A9:B2F2 A9 20 00    LDA #$0020             ;\
$A9:B2F5 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 20h

$A9:B2F8 60          RTS
}


;;; $B2F9: Mother Brain body function - third phase - death sequence - escape door is exploding, start escape timer ;;;
{
$A9:B2F9 22 46 B3 A9 JSL $A9B346[$A9:B346]  ; Generate escape door explosion
$A9:B2FD CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B300 10 27       BPL $27    [$B329]     ; If [Mother Brain body function timer] >= 0: return
$A9:B302 A9 0F 00    LDA #$000F             ;\
$A9:B305 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - enable timer handling
$A9:B309 A9 02 00    LDA #$0002             ;\
$A9:B30C 8D 43 09    STA $0943  [$7E:0943]  ;} Timer status = Mother Brain start
$A9:B30F 22 A6 81 80 JSL $8081A6[$80:81A6]  ; Set mini-boss bit for current area
$A9:B313 A9 0E 00    LDA #$000E             ;\
$A9:B316 22 FA 81 80 JSL $8081FA[$80:81FA]  ;} Mark event Eh (Zebes timebomb set)
$A9:B31A A9 2A B3    LDA #$B32A             ;\
$A9:B31D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B32A
$A9:B320 A9 00 00    LDA #$0000             ;\
$A9:B323 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Escape door explosion interval timer = 0
$A9:B326 8D F2 0F    STA $0FF2  [$7E:0FF2]  ; Escape door index = 0

$A9:B329 60          RTS
}


;;; $B32A: Mother Brain body function - third phase - death sequence - blow up escape door ;;;
{
$A9:B32A 20 A3 B3    JSR $B3A3  [$A9:B3A3]  ; Explode Mother Brain escape door
$A9:B32D A9 3C B3    LDA #$B33C             ;\
$A9:B330 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B33C
$A9:B333 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:B337             dx  00, 06, B677       ;} Spawn Mother Brain's room escape door
$A9:B33B 60          RTS
}


;;; $B33C: Mother Brain body function - third phase - death sequence - keep earthquake going ;;;
{
; Final MB body function
$A9:B33C AD 40 18    LDA $1840  [$7E:1840]  ;\
$A9:B33F D0 04       BNE $04    [$B345]     ;} If [earthquake timer] = 0:
$A9:B341 3A          DEC A                  ;\
$A9:B342 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = FFFFh

$A9:B345 60          RTS
}


;;; $B346: Generate escape door explosion ;;;
{
$A9:B346 AD F0 0F    LDA $0FF0  [$7E:0FF0]  ;\
$A9:B349 3A          DEC A                  ;} Decrement escape door explosion interval timer
$A9:B34A 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;/
$A9:B34D 10 43       BPL $43    [$B392]     ; If [escape door explosion interval timer] >= 0: return
$A9:B34F A9 04 00    LDA #$0004             ;\
$A9:B352 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Escape door explosion interval timer = 4
$A9:B355 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A9:B358 3A          DEC A                  ;|
$A9:B359 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;|
$A9:B35C 10 06       BPL $06    [$B364]     ;} Escape door index = ([escape door index] - 1) % 4
$A9:B35E A9 03 00    LDA #$0003             ;|
$A9:B361 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;/

$A9:B364 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A9:B367 0A          ASL A                  ;|
$A9:B368 0A          ASL A                  ;} Y = [escape door index] * 4
$A9:B369 A8          TAY                    ;/
$A9:B36A B9 93 B3    LDA $B393,y[$A9:B397]  ;\
$A9:B36D 85 12       STA $12    [$7E:0012]  ;} $12 = [$B393 + [Y]]
$A9:B36F B9 95 B3    LDA $B395,y[$A9:B399]  ;\
$A9:B372 85 14       STA $14    [$7E:0014]  ;} $14 = [$B393 + [Y] + 2]
$A9:B374 A0 03 00    LDY #$0003             ; A = 3 (small explosion)
$A9:B377 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A9:B37B C9 00 40    CMP #$4000             ;\
$A9:B37E B0 03       BCS $03    [$B383]     ;} If [random number] < 4000h:
$A9:B380 A0 0C 00    LDY #$000C             ; A = Ch (smoke)

$A9:B383 98          TYA
$A9:B384 A0 09 E5    LDY #$E509             ;\
$A9:B387 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:B38B A9 24 00    LDA #$0024             ;\
$A9:B38E 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 24h, sound library 2, max queued sounds allowed = 3 (small explosion)

$A9:B392 6B          RTL

$A9:B393             dw 0008,006C, 0018,0080, 0009,0090, 0018,0074
}


;;; $B3A3: Explode Mother Brain escape door ;;;
{
$A9:B3A3 A9 00 00    LDA #$0000             ; A = 0

; LOOP
$A9:B3A6 48          PHA
$A9:B3A7 A0 21 CB    LDY #$CB21             ;\
$A9:B3AA 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's exploded escape door particles enemy projectile
$A9:B3AE 68          PLA
$A9:B3AF 1A          INC A                  ; Increment A
$A9:B3B0 C9 08 00    CMP #$0008             ;\
$A9:B3B3 90 F1       BCC $F1    [$B3A6]     ;} If [A] < 8: go to LOOP
$A9:B3B5 60          RTS
}
}


;;; $B3B6..B604: Mother Brain contact reactions ;;;
{
;;; $B3B6: Mother Brain / Samus collision detection ;;;
{
$A9:B3B6 AF 08 78 7E LDA $7E7808[$7E:7808]  ;\
$A9:B3BA 85 1A       STA $1A    [$7E:001A]  ;|
$A9:B3BC 46 1A       LSR $1A    [$7E:001A]  ;} If Mother Brain body hitbox enabled:
$A9:B3BE 90 12       BCC $12    [$B3D2]     ;/
$A9:B3C0 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:B3C3 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain body X position]
$A9:B3C5 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A9:B3C8 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain body Y position]
$A9:B3CA A2 27 B4    LDX #$B427             ; X = $B427
$A9:B3CD 20 55 B4    JSR $B455  [$A9:B455]  ; Mother Brain part / Samus collision detection
$A9:B3D0 B0 54       BCS $54    [$B426]     ; If carry set: return

$A9:B3D2 46 1A       LSR $1A    [$7E:001A]  ;\
$A9:B3D4 90 12       BCC $12    [$B3E8]     ;} If Mother Brain brain hitbox enabled:
$A9:B3D6 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A9:B3D9 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain brain X position]
$A9:B3DB AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:B3DE 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain brain Y position]
$A9:B3E0 A2 39 B4    LDX #$B439             ; X = $B439
$A9:B3E3 20 55 B4    JSR $B455  [$A9:B455]  ; Mother Brain part / Samus collision detection
$A9:B3E6 B0 3E       BCS $3E    [$B426]     ; If carry set: return

$A9:B3E8 46 1A       LSR $1A    [$7E:001A]  ;\
$A9:B3EA 90 3A       BCC $3A    [$B426]     ;} If Mother Brain's neck hitbox disabled: return
$A9:B3EC AF 4A 80 7E LDA $7E804A[$7E:804A]  ;\
$A9:B3F0 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain's neck segment 1 X position]
$A9:B3F2 AF 4C 80 7E LDA $7E804C[$7E:804C]  ;\
$A9:B3F6 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain's neck segment 1 Y position]
$A9:B3F8 A2 4B B4    LDX #$B44B             ; X = $B44B
$A9:B3FB 20 55 B4    JSR $B455  [$A9:B455]  ; Mother Brain part / Samus collision detection
$A9:B3FE B0 26       BCS $26    [$B426]     ; If carry set: return
$A9:B400 AF 50 80 7E LDA $7E8050[$7E:8050]  ;\
$A9:B404 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain's neck segment 2 X position]
$A9:B406 AF 52 80 7E LDA $7E8052[$7E:8052]  ;\
$A9:B40A 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain's neck segment 2 Y position]
$A9:B40C A2 4B B4    LDX #$B44B             ; X = $B44B
$A9:B40F 20 55 B4    JSR $B455  [$A9:B455]  ; Mother Brain part / Samus collision detection
$A9:B412 B0 12       BCS $12    [$B426]     ; If carry set: return
$A9:B414 AF 56 80 7E LDA $7E8056[$7E:8056]  ;\
$A9:B418 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain's neck segment 3 X position]
$A9:B41A AF 58 80 7E LDA $7E8058[$7E:8058]  ;\
$A9:B41E 85 14       STA $14    [$7E:0014]  ;} $14 = [Mother Brain's neck segment 3 Y position]
$A9:B420 A2 4B B4    LDX #$B44B             ; X = $B44B
$A9:B423 20 55 B4    JSR $B455  [$A9:B455]  ; Mother Brain part / Samus collision detection

$A9:B426 60          RTS
}


;;; $B427: Mother Brain hitbox definitions ;;;
{
; Used to detect collision with Samus

; Hitbox format is:
;      ________________________ Number of entries
;     |      __________________ Left offset
;     |     |     _____________ Top offset
;     |     |    |     ________ Right offset
;     |     |    |    |     ___ Bottom offset
;     |     |    |    |    |
;     nnnn, llll,tttt,rrrr,bbbb, ...
$A9:B427             dw 0002, FFE0,FFE8,002A,0038, FFE8,FFD6,001C,FFE7 ; Mother Brain body
$A9:B439             dw 0002, FFE8,FFEA,0016,0000, FFEA,0001,0010,0014 ; Mother Brain brain
$A9:B44B             dw 0001, FFF8,FFF8,0008,0008 ; Mother Brain's neck
}


;;; $B455: Mother Brain part / Samus collision detection ;;;
{
;; Parameters:
;;     X: Hitbox definition
;;     $12: Hitbox X position
;;     $14: Hitbox Y position
;; Returns:
;;     Carry: Set if collision
$A9:B455 BD 00 00    LDA $0000,x[$A9:B439]  ;\
$A9:B458 F0 5F       BEQ $5F    [$B4B9]     ;} If [[X]] = 0: return carry clear
$A9:B45A 85 16       STA $16    [$7E:0016]  ; $16 = [[X]]
$A9:B45C E8          INX                    ;\
$A9:B45D E8          INX                    ;} X += 2

; LOOP
$A9:B45E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A9:B461 38          SEC                    ;|
$A9:B462 E5 14       SBC $14    [$7E:0014]  ;} If [Samus Y position] < [hitbox Y position]:
$A9:B464 10 0B       BPL $0B    [$B471]     ;/
$A9:B466 49 FF FF    EOR #$FFFF             ;\
$A9:B469 1A          INC A                  ;} $18 = [hitbox Y position] - [Samus Y position]
$A9:B46A 85 18       STA $18    [$7E:0018]  ;/
$A9:B46C BD 02 00    LDA $0002,x[$A9:B43D]  ; A = [[X] + 2]
$A9:B46F 80 05       BRA $05    [$B476]

                                            ; Else ([Samus Y position] >= [hitbox Y position]):
$A9:B471 85 18       STA $18    [$7E:0018]  ; $18 = [Samus Y position] - [hitbox Y position]
$A9:B473 BD 06 00    LDA $0006,x[$A9:B441]  ; A = [[X] + 6]

$A9:B476 10 04       BPL $04    [$B47C]     ;\
$A9:B478 49 FF FF    EOR #$FFFF             ;} A = |[A]|
$A9:B47B 1A          INC A                  ;/

$A9:B47C 18          CLC                    ;\
$A9:B47D 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$A9:B480 38          SEC                    ;} If [A] + [Samus Y radius] < [$18]: go to BRANCH_NEXT
$A9:B481 E5 18       SBC $18    [$7E:0018]  ;|
$A9:B483 30 27       BMI $27    [$B4AC]     ;/
$A9:B485 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:B488 38          SEC                    ;|
$A9:B489 E5 12       SBC $12    [$7E:0012]  ;} If [Samus X position] < [hitbox X position]:
$A9:B48B 10 0B       BPL $0B    [$B498]     ;/
$A9:B48D 49 FF FF    EOR #$FFFF             ;\
$A9:B490 1A          INC A                  ;} $18 = [hitbox X position] - [Samus X position]
$A9:B491 85 18       STA $18    [$7E:0018]  ;/
$A9:B493 BD 00 00    LDA $0000,x            ; A = [[X]]
$A9:B496 80 05       BRA $05    [$B49D]
                                            ; Else ([Samus X position] >= [hitbox X position]):
$A9:B498 85 18       STA $18    [$7E:0018]  ; $18 = [Samus X position] - [hitbox X position]
$A9:B49A BD 04 00    LDA $0004,x[$A9:B447]  ; A = [[X] + 4]

$A9:B49D 10 04       BPL $04    [$B4A3]     ;\
$A9:B49F 49 FF FF    EOR #$FFFF             ;} A = |[A]|
$A9:B4A2 1A          INC A                  ;/

$A9:B4A3 18          CLC                    ;\
$A9:B4A4 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;|
$A9:B4A7 38          SEC                    ;} If [A] + [Samus X radius] >= [$18]: go to BRANCH_HIT
$A9:B4A8 E5 18       SBC $18    [$7E:0018]  ;|
$A9:B4AA 10 0F       BPL $0F    [$B4BB]     ;/

; BRANCH_NEXT
$A9:B4AC C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$A9:B4AE F0 09       BEQ $09    [$B4B9]     ; If [$16] = 0: return carry clear
$A9:B4B0 8A          TXA                    ;\
$A9:B4B1 18          CLC                    ;|
$A9:B4B2 69 08 00    ADC #$0008             ;} X += 8 (next hitbox entry)
$A9:B4B5 AA          TAX                    ;/
$A9:B4B6 4C 5E B4    JMP $B45E  [$A9:B45E]  ; Go to LOOP

$A9:B4B9 18          CLC
$A9:B4BA 60          RTS

; BRANCH_HIT
$A9:B4BB C9 04 00    CMP #$0004             ;\
$A9:B4BE 10 03       BPL $03    [$B4C3]     ;|
$A9:B4C0 A9 04 00    LDA #$0004             ;} Extra Samus X displacement = max(4, [A])
                                            ;|
$A9:B4C3 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A9:B4C6 A9 04 00    LDA #$0004             ;\
$A9:B4C9 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;} Extra Samus Y displacement = 4
$A9:B4CC 9C 56 0B    STZ $0B56  [$7E:0B56]  ; Extra Samus X subdisplacement = 0
$A9:B4CF 9C 5A 0B    STZ $0B5A  [$7E:0B5A]  ; Extra Samus Y subdisplacement = 0
$A9:B4D2 A9 60 00    LDA #$0060             ;\
$A9:B4D5 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 60h
$A9:B4D8 A9 05 00    LDA #$0005             ;\
$A9:B4DB 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = 5
$A9:B4DE A9 01 00    LDA #$0001             ;\
$A9:B4E1 8D 54 0A    STA $0A54  [$7E:0A54]  ;} Knockback X direction = right
$A9:B4E4 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A9:B4E7 C9 C0 00    CMP #$00C0             ;} If [Samus Y position] < C0h:
$A9:B4EA 10 06       BPL $06    [$B4F2]     ;/
$A9:B4EC A9 02 00    LDA #$0002             ;\
$A9:B4EF 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down

$A9:B4F2 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:B4F5 18          CLC                    ;|
$A9:B4F6 69 18 00    ADC #$0018             ;} If [Mother Brain body X position] + 18h < [Samus X position]:
$A9:B4F9 CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;|
$A9:B4FC 10 03       BPL $03    [$B501]     ;/
$A9:B4FE 20 E1 B5    JSR $B5E1  [$A9:B5E1]  ; Hurt Samus

$A9:B501 38          SEC                    ;\
$A9:B502 60          RTS                    ;} Return carry set
}


;;; $B503: Enemy shot - enemy $EC7F (Mother Brain body) ;;;
{
$A9:B503 5C BC A8 A0 JML $A0A8BC[$A0:A8BC]  ; Go to creates a dud shot
}


;;; $B507: Enemy shot - enemy $EC3F (Mother Brain brain) ;;;
{
; This code assumes that Mother Brain's glass is the first spawned PLM (index 4Eh)
$A9:B507 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A9:B50B D0 41       BNE $41    [$B54E]     ;} If [Mother Brain's form] != first phase: go to BRANCH_NOT_FIRST_PHASE
$A9:B50D AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A9:B510 0A          ASL A                  ;} Y = [collided projectile index] * 2
$A9:B511 A8          TAY                    ;/
$A9:B512 B9 19 0C    LDA $0C19,y[$7E:0C1D]  ;\
$A9:B515 29 07 00    AND #$0007             ;|
$A9:B518 A8          TAY                    ;|
$A9:B519 B9 46 B5    LDA $B546,y[$A9:B547]  ;} If [$B546 + (projectile type)] = 0: return
$A9:B51C 29 FF 00    AND #$00FF             ;|
$A9:B51F F0 24       BEQ $24    [$B545]     ;/
$A9:B521 A2 4E 00    LDX #$004E             ;\
$A9:B524 18          CLC                    ;|
$A9:B525 7D C7 1D    ADC $1DC7,x[$7E:1E15]  ;} Mother Brain's glass PLM room argument += 1
$A9:B528 9D C7 1D    STA $1DC7,x[$7E:1E15]  ;/
$A9:B52B A9 6E 00    LDA #$006E             ;\
$A9:B52E 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 6Eh, sound library 2, max queued sounds allowed = 6 (shot Mother Brain phase 1)
$A9:B532 A0 0D 00    LDY #$000D             ; Y = Dh
$A9:B535 AD DC 0F    LDA $0FDC  [$7E:0FDC]  ;\
$A9:B538 F0 04       BEQ $04    [$B53E]     ;} If [Mother Brain brain invincibility timer] != 0:
$A9:B53A 4A          LSR A                  ;\
$A9:B53B 90 01       BCC $01    [$B53E]     ;} If [Mother Brain brain invincibility timer] % 2 != 0:
$A9:B53D C8          INY                    ; Y = Eh

$A9:B53E 8C DC 0F    STY $0FDC  [$7E:0FDC]  ; Mother Brain brain invincibility timer = [Y]
$A9:B541 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI - no death check, no enemy shot graphic

$A9:B545 6B          RTL

$A9:B546             db 00, ; Beam
                        01, ; Missile
                        01, ; Super missile
                        00, ; Power bomb
                        00, ; Unused
                        00, ; Bomb
                        00, ; Unused
                        00  ; Beam explosion

; BRANCH_NOT_FIRST_PHASE
$A9:B54E 20 62 B5    JSR $B562  [$A9:B562]  ; Mother Brain second/third phase shot reaction
$A9:B551 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A9:B555 C9 01 00    CMP #$0001             ;} If [Mother Brain's form] = fake death:
$A9:B558 D0 04       BNE $04    [$B55E]     ;/
$A9:B55A 5C BC A8 A0 JML $A0A8BC[$A0:A8BC]  ; Go to creates a dud shot

$A9:B55E 5C A7 A6 A0 JML $A0A6A7[$A0:A6A7]  ; Go to normal enemy shot AI - no death check, no enemy shot graphic
}


;;; $B562: Mother Brain second/third phase shot reaction ;;;
{
$A9:B562 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A9:B566 C9 04 00    CMP #$0004             ;} If [Mother Brain's form] = third phase:
$A9:B569 D0 0B       BNE $0B    [$B576]     ;/
$A9:B56B 20 8E B5    JSR $B58E  [$A9:B58E]  ;\
$A9:B56E C9 02 00    CMP #$0002             ;} If shot with beam:
$A9:B571 D0 03       BNE $03    [$B576]     ;/
$A9:B573 4C A9 B5    JMP $B5A9  [$A9:B5A9]  ; Go to Mother Brain third phase beam shot reaction

$A9:B576 20 8E B5    JSR $B58E  [$A9:B58E]  ;\
$A9:B579 3A          DEC A                  ;} If shot with (super) missile: Mother Brain walk counter = 0
$A9:B57A F0 0A       BEQ $0A    [$B586]     ;/
$A9:B57C AF 0E 78 7E LDA $7E780E[$7E:780E]  ;\ Else (not shot with (super) missile):
$A9:B580 38          SEC                    ;|
$A9:B581 E9 00 01    SBC #$0100             ;|
$A9:B584 10 03       BPL $03    [$B589]     ;|
                                            ;} Mother Brain walk counter = max(0, [Mother Brain walk counter] - 100h)
$A9:B586 A9 00 00    LDA #$0000             ;|
                                            ;|
$A9:B589 8F 0E 78 7E STA $7E780E[$7E:780E]  ;/
$A9:B58D 60          RTS
}


;;; $B58E: Determine Mother Brain shot reaction type ;;;
{
; Return [$B5A1 + (collided projectile type)]
$A9:B58E AD A6 18    LDA $18A6  [$7E:18A6]
$A9:B591 0A          ASL A
$A9:B592 A8          TAY
$A9:B593 B9 19 0C    LDA $0C19,y[$7E:0C19]
$A9:B596 29 07 00    AND #$0007
$A9:B599 A8          TAY
$A9:B59A B9 A1 B5    LDA $B5A1,y[$A9:B5A2]
$A9:B59D 29 FF 00    AND #$00FF
$A9:B5A0 60          RTS

$A9:B5A1             db 02, ; Beam
                        01, ; Missile
                        01, ; Super missile
                        00, ; Power bomb
                        00,
                        00, ; Bomb
                        00,
                        00  ; Beam explosion
}


;;; $B5A9: Mother Brain third phase beam shot reaction ;;;
{
$A9:B5A9 AF 0E 78 7E LDA $7E780E[$7E:780E]  ;\
$A9:B5AD 38          SEC                    ;|
$A9:B5AE E9 0A 01    SBC #$010A             ;} If [Mother Brain walk counter] < 10Ah:
$A9:B5B1 10 0D       BPL $0D    [$B5C0]     ;/
$A9:B5B3 A9 95 C3    LDA #$C395             ;\
$A9:B5B6 8F 70 78 7E STA $7E7870[$7E:7870]  ;} Mother Brain neck function = $C395 (set up hyper beam recoil)
$A9:B5BA A9 00 00    LDA #$0000             ;\
$A9:B5BD 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 0

$A9:B5C0 8F 0E 78 7E STA $7E780E[$7E:780E]  ; Mother Brain walk counter = max(0, [Mother Brain walk counter] - 10Ah)
$A9:B5C4 60          RTS
}


;;; $B5C5: RTL. Enemy touch - enemy $EC7F (Mother Brain body) ;;;
{
$A9:B5C5 6B          RTL
}


;;; $B5C6: Enemy touch - enemy $EC3F (Mother Brain brain) ;;;
{
; I'm pretty sure it's impossible to touch Mother Brain brain due to the custom hitboxes
$A9:B5C6 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$A9:B5C9 29 FF 00    AND #$00FF             ;|
$A9:B5CC C9 03 00    CMP #$0003             ;} If [Samus movement type] != spin jumping: return
$A9:B5CF D0 0F       BNE $0F    [$B5E0]     ;/
$A9:B5D1 A0 0D 00    LDY #$000D             ; Y = Dh
$A9:B5D4 AD DC 0F    LDA $0FDC  [$7E:0FDC]  ;\
$A9:B5D7 F0 04       BEQ $04    [$B5DD]     ;} If [Mother Brain brain invincibility timer] != 0:
$A9:B5D9 4A          LSR A                  ;\
$A9:B5DA 90 01       BCC $01    [$B5DD]     ;} If [Mother Brain brain invincibility timer] % 2 != 0:
$A9:B5DC C8          INY                    ; Y = Eh

$A9:B5DD 8C DC 0F    STY $0FDC  [$7E:0FDC]  ; Mother Brain brain invincibility timer = [Y]

$A9:B5E0 6B          RTL
}


;;; $B5E1: Hurt Samus ;;;
{
$A9:B5E1 22 53 D4 A6 JSL $A6D453[$A6:D453]  ; Deal suit-adjusted enemy damage to Samus
$A9:B5E5 A9 60 00    LDA #$0060             ;\
$A9:B5E8 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 60h
$A9:B5EB A9 05 00    LDA #$0005             ;\
$A9:B5EE 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = 5
$A9:B5F1 A0 00 00    LDY #$0000             ; Knockback X direction = left
$A9:B5F4 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A9:B5F7 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$A9:B5FA 38          SEC                    ;} If [Samus X position] >= [enemy X position]:
$A9:B5FB FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$A9:B5FE 30 01       BMI $01    [$B601]     ;/
$A9:B600 C8          INY                    ; Knockback X direction = right

$A9:B601 8C 54 0A    STY $0A54  [$7E:0A54]
$A9:B604 60          RTS
}
}


;;; $B605..B780: Mother Brain - main second phase ;;;
{
;;; $B605: Mother Brain body function - second phase - thinking ;;;
{
; 4500 is a quarter of full health
$A9:B605 AD CC 0F    LDA $0FCC  [$7E:0FCC]  ;\
$A9:B608 D0 09       BNE $09    [$B613]     ;} If [Mother Brain brain health] = 0:
$A9:B60A A9 EB B8    LDA #$B8EB             ;\
$A9:B60D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B8EB (second phase - firing rainbow beam - extend neck)
$A9:B610 4C EB B8    JMP $B8EB  [$A9:B8EB]  ; Go to second phase - firing rainbow beam - extend neck

$A9:B613 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:B617 F0 01       BEQ $01    [$B61A]     ;} If [Mother Brain's pose] != standing:
$A9:B619 60          RTS                    ; Return

$A9:B61A AD CC 0F    LDA $0FCC  [$7E:0FCC]  ;\
$A9:B61D C9 94 11    CMP #$1194             ;} If [Mother Brain brain health] < 4500: go to BRANCH_LOW_HEALTH
$A9:B620 30 12       BMI $12    [$B634]     ;/
$A9:B622 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:B625 C9 00 10    CMP #$1000             ;} If [random number] >= 1000h:
$A9:B628 90 03       BCC $03    [$B62D]     ;/
$A9:B62A 4C B8 C6    JMP $C6B8  [$A9:C6B8]  ; Go to handle Mother Brain walking

; BRANCH_TRY_ATTACK
$A9:B62D A9 4B B6    LDA #$B64B             ;\
$A9:B630 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B64B (try attack)
$A9:B633 60          RTS                    ; Return

; BRANCH_LOW_HEALTH
$A9:B634 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:B637 C9 00 20    CMP #$2000             ;} If [random number] < 2000h:
$A9:B63A B0 03       BCS $03    [$B63F]     ;/
$A9:B63C 4C B8 C6    JMP $C6B8  [$A9:C6B8]  ; Go to handle Mother Brain walking

$A9:B63F C9 00 A0    CMP #$A000             ;\
$A9:B642 B0 E9       BCS $E9    [$B62D]     ;} If [random number] >= A000h: go to BRANCH_TRY_ATTACK
$A9:B644 A9 7D B8    LDA #$B87D             ;\
$A9:B647 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B87D (firing death beam)
$A9:B64A 60          RTS
}


;;; $B64B: Mother Brain body function - second phase - try attack ;;;
{
$A9:B64B AF 30 78 7E LDA $7E7830[$7E:7830]  ;\
$A9:B64F 0A          ASL A                  ;|
$A9:B650 AA          TAX                    ;} Go to [$B654 + [Mother Brain attack phase] * 2]
$A9:B651 7C 54 B6    JMP ($B654,x)[$A9:B65A];/

$A9:B654             dw B65A, B764, B773
}


;;; $B65A: Try Mother Brain phase 2 attack - try attack ;;;
{
; [Mother Brain attack phase] = 0
; Call to $B6E2 returns from *this* routine if it decided a particular attack,
; must have nothing pushed to the stack
; The call to $B6E2 always returns from this routine if Samus is in (almost) any in-air movement type,
; hence the Y proximity condition to use RNG thresholds pointer $B6DF is (almost) never true
$A9:B65A A9 40 00    LDA #$0040             ;\
$A9:B65D 8D B4 0F    STA $0FB4  [$7E:0FB4]  ;} Mother Brain attack cooldown = 40h
$A9:B660 AF 30 78 7E LDA $7E7830[$7E:7830]  ;\
$A9:B664 1A          INC A                  ;} Mother Brain attack phase = 1 (cooldown)
$A9:B665 8F 30 78 7E STA $7E7830[$7E:7830]  ;/
$A9:B669 20 E2 B6    JSR $B6E2  [$A9:B6E2]  ; Decide Mother Brain phase 2 attack strategy
$A9:B66C A2 DC B6    LDX #$B6DC             ; X = $B6DC
$A9:B66F AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:B672 18          CLC                    ;|
$A9:B673 69 04 00    ADC #$0004             ;|
$A9:B676 38          SEC                    ;|
$A9:B677 ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$A9:B67A 10 04       BPL $04    [$B680]     ;} If |[Mother Brain brain Y position] + 4 - [Samus Y position]| < 20h:
$A9:B67C 49 FF FF    EOR #$FFFF             ;|
$A9:B67F 1A          INC A                  ;|
                                            ;|
$A9:B680 C9 20 00    CMP #$0020             ;|
$A9:B683 B0 03       BCS $03    [$B688]     ;/
$A9:B685 A2 DF B6    LDX #$B6DF             ; X = $B6DF

$A9:B688 E2 20       SEP #$20
$A9:B68A A0 00 00    LDY #$0000             ; Y = 0
$A9:B68D AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:B690 DD 00 00    CMP $0000,x[$A9:B6DC]  ;} If [random number] & FFh >= [[X]]:
$A9:B693 90 10       BCC $10    [$B6A5]     ;/
$A9:B695 C8          INY                    ;\
$A9:B696 C8          INY                    ;} Y += 2
$A9:B697 DD 01 00    CMP $0001,x[$A9:B6DD]  ;\
$A9:B69A 90 09       BCC $09    [$B6A5]     ;} If [random number] & FFh >= [[X] + 1]:
$A9:B69C C8          INY                    ;\
$A9:B69D C8          INY                    ;} Y += 2
$A9:B69E DD 02 00    CMP $0002,x            ;\
$A9:B6A1 90 02       BCC $02    [$B6A5]     ;} If [random number] & FFh >= [[X] + 2]:
$A9:B6A3 C8          INY                    ;\
$A9:B6A4 C8          INY                    ;} Y += 2

$A9:B6A5 BB          TYX                    ;\
$A9:B6A6 C2 20       REP #$20               ;|
$A9:B6A8 BD D4 B6    LDA $B6D4,x[$A9:B6D4]  ;} If [$B6D4 + [Y]] = $9ECC: go to BRANCH_BOMB
$A9:B6AB C9 CC 9E    CMP #$9ECC             ;|
$A9:B6AE F0 09       BEQ $09    [$B6B9]     ;/
$A9:B6B0 C9 34 9F    CMP #$9F34             ;\
$A9:B6B3 F0 16       BEQ $16    [$B6CB]     ;} If [$B6D4 + [Y]] = $9F34: go to BRANCH_LASER
$A9:B6B5 20 47 C4    JSR $C447  [$A9:C447]  ; Set Mother Brain brain instruction list to [$B6D4 + [Y]]

$A9:B6B8 60          RTS                    ; Return

; BRANCH_BOMB
$A9:B6B9 AF 4A 78 7E LDA $7E784A[$7E:784A]  ;\
$A9:B6BD C9 01 00    CMP #$0001             ;} If [Mother Brain bomb counter] >= 1: return
$A9:B6C0 10 F6       BPL $F6    [$B6B8]     ;/
$A9:B6C2 A9 81 B7    LDA #$B781             ;\
$A9:B6C5 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B781 (firing bomb)
$A9:B6C8 4C 81 B7    JMP $B781  [$A9:B781]  ; Go to firing bomb

; BRANCH_LASER
$A9:B6CB A9 0E B8    LDA #$B80E             ;\
$A9:B6CE 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B80E (firing laser)
$A9:B6D1 4C 0E B8    JMP $B80E  [$A9:B80E]  ; Go to firing laser

; Mother Brain brain instruction list pointers
$A9:B6D4             dw 9C87, ; Neutral
                        9D3D, ; Attacking - blue rings
                        9F34, ; Attacking - laser
                        9ECC  ; Attacking - bomb

; RNG thresholds
$A9:B6DC             db 40, 80, C0  ; Default
$A9:B6DF             db 10, 20, D0  ; Samus Y position is within 2 rows of Mother Brain's Y position + 4
}


;;; $B6E2: Decide Mother Brain phase 2 attack strategy ;;;
{
; If Samus is in the air, 50/50 for blue rings or laser
; Else, 50% chance to do bomb
$A9:B6E2 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$A9:B6E5 29 FF 00    AND #$00FF             ;|
$A9:B6E8 0A          ASL A                  ;|
$A9:B6E9 AA          TAX                    ;} If [$B72C + [Samus movement type] * 2] != 0: go to BRANCH_AIM_AT_GROUND
$A9:B6EA BD 2C B7    LDA $B72C,x[$A9:B72C]  ;|
$A9:B6ED D0 1D       BNE $1D    [$B70C]     ;/
$A9:B6EF AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:B6F2 29 FF 00    AND #$00FF             ;|
$A9:B6F5 C9 80 00    CMP #$0080             ;} If [random number] & FFh >= 80h:
$A9:B6F8 30 08       BMI $08    [$B702]     ;/
$A9:B6FA A9 3D 9D    LDA #$9D3D             ;\
$A9:B6FD 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9D3D (attacking - blue rings)
$A9:B700 68          PLA                    ; Set return to caller's return
$A9:B701 60          RTS                    ; Return

$A9:B702 68          PLA                    ; Set return to caller's return
$A9:B703 A9 0E B8    LDA #$B80E             ;\
$A9:B706 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B80E (firing laser)
$A9:B709 4C 0E B8    JMP $B80E  [$A9:B80E]  ; Go to firing laser

; BRANCH_AIM_AT_GROUND
$A9:B70C AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:B70F 29 FF 00    AND #$00FF             ;|
$A9:B712 C9 80 00    CMP #$0080             ;} If [random number] & FFh < 80h:
$A9:B715 10 01       BPL $01    [$B718]     ;/
$A9:B717 60          RTS                    ; Return (do a random attack)

$A9:B718 AF 4A 78 7E LDA $7E784A[$7E:784A]  ;\
$A9:B71C C9 01 00    CMP #$0001             ;} If [Mother Brain bomb counter] >= 1: return
$A9:B71F 10 0A       BPL $0A    [$B72B]     ;/
$A9:B721 A9 81 B7    LDA #$B781             ;\
$A9:B724 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B781 (firing bomb)
$A9:B727 68          PLA                    ; Set return to caller's return
$A9:B728 4C 81 B7    JMP $B781  [$A9:B781]  ; Go to firing bomb

$A9:B72B 60          RTS

$A9:B72C             dw FFFF, ; 0: Standing
                        FFEF, ; 1: Running
                        0000, ; 2: Normal jumping
                        0000, ; 3: Spin jumping
                        FFFF, ; 4: Morph ball - on ground
                        FFFF, ; 5: Crouching
                        0000, ; 6: Falling
                        FFFF, ; 7: Unused
                        0000, ; 8: Morph ball - falling
                        0000, ; 9: Unused
                        FFFF, ; Ah: Knockback / crystal flash ending
                        0000, ; Bh: Unused
                        0000, ; Ch: Unused
                        0000, ; Dh: Unused
                        FFEF, ; Eh: Turning around - on ground
                        FFFF, ; Fh: Crouching/standing/morphing/unmorphing transition
                        FFFF, ; 10h: Moonwalking
                        FFFF, ; 11h: Spring ball - on ground
                        0000, ; 12h: Spring ball - in air
                        0000, ; 13h: Spring ball - falling
                        0000, ; 14h: Wall jumping
                        FFEF, ; 15h: Ran into a wall
                        FFFF, ; 16h: Grappling
                        FFFF, ; 17h: Turning around - jumping
                        FFFF, ; 18h: Turning around - falling
                        FFFF, ; 19h: Damage boost
                        FFFF, ; 1Ah: Grabbed by Draygon
                        FFFF  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $B764: Try Mother Brain phase 2 attack - cooldown ;;;
{
; [Mother Brain attack phase] = 1
$A9:B764 CE B4 0F    DEC $0FB4  [$7E:0FB4]  ; Decrement Mother Brain attack cooldown
$A9:B767 D0 09       BNE $09    [$B772]     ; If [Mother Brain attack cooldown] != 0: return
$A9:B769 AF 30 78 7E LDA $7E7830[$7E:7830]  ;\
$A9:B76D 1A          INC A                  ;} Mother Brain attack phase = 2 (reset attack phase)
$A9:B76E 8F 30 78 7E STA $7E7830[$7E:7830]  ;/

$A9:B772 60          RTS
}


;;; $B773: Try Mother Brain phase 2 attack - end attack ;;;
{
; [Mother Brain attack phase] = 2
$A9:B773 A9 00 00    LDA #$0000             ;\
$A9:B776 8F 30 78 7E STA $7E7830[$7E:7830]  ;} Mother Brain attack phase = 0 (try attack)
$A9:B77A A9 05 B6    LDA #$B605             ;\
$A9:B77D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B605 (thinking)
$A9:B780 60          RTS
}
}


;;; $B781..B80D: Mother Brain - firing bomb ;;;
{
;;; $B781: Mother Brain body function - firing bomb - decide on walking ;;;
{
$A9:B781 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:B784 C9 80 FF    CMP #$FF80             ;} If [random number] >= FF80h: go to decide on crouching
$A9:B787 B0 2E       BCS $2E    [$B7B7]     ;/
$A9:B789 A2 40 00    LDX #$0040             ; X = 40h (target X position)
$A9:B78C C9 00 60    CMP #$6000             ;\
$A9:B78F B0 03       BCS $03    [$B794]     ;} If [random number] < 6000h:
$A9:B791 A2 60 00    LDX #$0060             ; X = 60h (target X position)

$A9:B794 8A          TXA                    ;\
$A9:B795 CD 7A 0F    CMP $0F7A  [$7E:0F7A]  ;} If [Mother Brain body X position] <= [X]: go to decide on crouching
$A9:B798 10 1D       BPL $1D    [$B7B7]     ;/
$A9:B79A 8D B2 0F    STA $0FB2  [$7E:0FB2]  ; $0FB2 = [X]
$A9:B79D A0 06 00    LDY #$0006             ;\
$A9:B7A0 20 47 C6    JSR $C647  [$A9:C647]  ;} Make Mother Brain walk backwards medium towards X position [$0FB2]
$A9:B7A3 B0 12       BCS $12    [$B7B7]     ; If reached X position [$0FB2]: go to decide on crouching
$A9:B7A5 A9 AC B7    LDA #$B7AC             ;\
$A9:B7A8 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B7AC (walking backwards)

$A9:B7AB 60          RTS
}


;;; $B7AC: Mother Brain body function - firing bomb - walking backwards ;;;
{
$A9:B7AC A0 06 00    LDY #$0006             ;\
$A9:B7AF AD B2 0F    LDA $0FB2  [$7E:0FB2]  ;} Make Mother Brain walk backwards medium towards X position [$0FB2]
$A9:B7B2 20 47 C6    JSR $C647  [$A9:C647]  ;/
$A9:B7B5 90 F4       BCC $F4    [$B7AB]     ; If not reached X position [$0FB2]: return
}


;;; $B7B7: Mother Brain firing bomb - decide on crouching ;;;
{
$A9:B7B7 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A9:B7BB C9 00 80    CMP #$8000             ;\
$A9:B7BE 90 0B       BCC $0B    [$B7CB]     ;} If [random number] < 8000h: go to fire bomb
$A9:B7C0 A9 C6 B7    LDA #$B7C6             ;\
$A9:B7C3 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B7C6 (crouch)
}


;;; $B7C6: Mother Brain body function - firing bomb - crouch ;;;
{
$A9:B7C6 20 8E C6    JSR $C68E  [$A9:C68E]  ; Make Mother Brain crouch
$A9:B7C9 90 E0       BCC $E0    [$B7AB]     ; If not crouching: return
}


;;; $B7CB: Mother Brain firing bomb - fire bomb ;;;
{
$A9:B7CB A0 CC 9E    LDY #$9ECC             ; Y = $9ECC (attacking - bomb - phase 2)
$A9:B7CE AF 3E 78 7E LDA $7E783E[$7E:783E]  ;\
$A9:B7D2 F0 03       BEQ $03    [$B7D7]     ;} If have been turned into a corpse by Shitroid:
$A9:B7D4 A0 00 9F    LDY #$9F00             ; Y = $9F00 (attacking - bomb - phase 3)

$A9:B7D7 98          TYA                    ;\
$A9:B7D8 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to [Y]
$A9:B7DB A9 E8 B7    LDA #$B7E8             ;\
$A9:B7DE 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B7E8 (fired bomb)
$A9:B7E1 A9 2C 00    LDA #$002C             ;\
$A9:B7E4 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 60
$A9:B7E7 60          RTS
}


;;; $B7E8: Mother Brain body function - firing bomb - fired bomb ;;;
{
$A9:B7E8 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B7EB 10 20       BPL $20    [$B80D]     ; If [Mother Brain body function timer] >= 0: return
$A9:B7ED 20 70 C6    JSR $C670  [$A9:C670]  ; Make Mother Brain stand up
$A9:B7F0 B0 0B       BCS $0B    [$B7FD]     ; If standing: go to finish firing bomb
$A9:B7F2 A9 F8 B7    LDA #$B7F8             ;\
$A9:B7F5 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B7F8 (stand up)
}


;;; $B7F8: Mother Brain body function - firing bomb - stand up ;;;
{
$A9:B7F8 20 70 C6    JSR $C670  [$A9:C670]  ; Make Mother Brain stand up
$A9:B7FB 90 10       BCC $10    [$B80D]     ; If not standing: return
}


;;; $B7FD: Mother Brain firing bomb - finish firing bomb ;;;
{
$A9:B7FD A0 05 B6    LDY #$B605             ; Y = $B605 (second phase - thinking)
$A9:B800 AF 3E 78 7E LDA $7E783E[$7E:783E]  ;\
$A9:B804 F0 03       BEQ $03    [$B809]     ;} If have been turned into a corpse by Shitroid:
$A9:B806 A0 5C C1    LDY #$C15C             ; Y = $C15C (second phase - murder Shitroid)

$A9:B809 98          TYA                    ;\
$A9:B80A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = [Y]

$A9:B80D 60          RTS
}
}


;;; $B80E..B87C: Mother Brain - firing laser ;;;
{
;;; $B80E: Mother Brain body function - second phase - firing laser - position head quickly ;;;
{
$A9:B80E A2 08 00    LDX #$0008             ; X = 8 (raise head)
$A9:B811 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:B814 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;} If [Mother Brain brain Y position] < [Samus Y position]:
$A9:B817 10 03       BPL $03    [$B81C]     ;/
$A9:B819 A2 06 00    LDX #$0006             ; X = 6 (lower head)

$A9:B81C 8A          TXA                    ;\
$A9:B81D 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = [X]
$A9:B821 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = [X]
$A9:B825 A9 00 02    LDA #$0200             ;\
$A9:B828 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 200h
$A9:B82C A9 39 B8    LDA #$B839             ;\
$A9:B82F 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B839
$A9:B832 A9 04 00    LDA #$0004             ;\
$A9:B835 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 4
$A9:B838 60          RTS
}


;;; $B839: Mother Brain body function - second phase - firing laser - position head slowly and fire ;;;
{
$A9:B839 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B83C 30 01       BMI $01    [$B83F]     ; If [Mother Brain body function timer] >= 0:
$A9:B83E 60          RTS                    ; Return

$A9:B83F A0 00 01    LDY #$0100             ;\
$A9:B842 AF 68 80 7E LDA $7E8068[$7E:8068]  ;|
$A9:B846 10 03       BPL $03    [$B84B]     ;|
$A9:B848 A0 00 FF    LDY #$FF00             ;} Mother Brain neck angle delta = 100h * sgn([Mother Brain neck angle delta])
                                            ;|
$A9:B84B 98          TYA                    ;|
$A9:B84C 8F 68 80 7E STA $7E8068[$7E:8068]  ;/
$A9:B850 A9 34 9F    LDA #$9F34             ;\
$A9:B853 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9F34 (attacking - laser)
$A9:B856 A9 63 B8    LDA #$B863             ;\
$A9:B859 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B863
$A9:B85C A9 10 00    LDA #$0010             ;\
$A9:B85F 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h
$A9:B862 60          RTS
}


;;; $B863: Mother Brain body function - second phase - firing laser - finish attack ;;;
{
$A9:B863 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B866 30 01       BMI $01    [$B869]     ; If [Mother Brain body function timer] >= 0:
$A9:B868 60          RTS                    ; Return

$A9:B869 A9 04 00    LDA #$0004             ;\
$A9:B86C 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 4 (bob up)
$A9:B870 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 4 (bob up)
$A9:B874 A9 05 B6    LDA #$B605             ;\
$A9:B877 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B605 (thinking)
$A9:B87A 4C 05 B6    JMP $B605  [$A9:B605]  ; Go to thinking
}
}


;;; $B87D..B8EA: Mother Brain - firing death beam ;;;
{
;;; $B87D: Mother Brain body function - second phase - firing death beam ;;;
{
$A9:B87D AF 2E 78 7E LDA $7E782E[$7E:782E]  ;\
$A9:B881 0A          ASL A                  ;|
$A9:B882 AA          TAX                    ;} Execute [$B887 + [Mother Brain death beam attack phase] * 2]
$A9:B883 FC 87 B8    JSR ($B887,x)[$A9:B88F];/
$A9:B886 60          RTS

$A9:B887             dw B88F, B8B2, B8C8, B8C9
}


;;; $B88F: Mother Brain second phase - firing death beam - back up ;;;
{
; [Mother Brain death beam attack phase] = 0
$A9:B88F A0 08 00    LDY #$0008             ;\
$A9:B892 A9 28 00    LDA #$0028             ;} Make Mother Brain walk backwards slow towards X position 28h
$A9:B895 20 47 C6    JSR $C647  [$A9:C647]  ;/
$A9:B898 90 17       BCC $17    [$B8B1]     ; If not reached X position 28h: return
$A9:B89A A9 08 00    LDA #$0008             ;\
$A9:B89D 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 8 (raise)
$A9:B8A1 A9 06 00    LDA #$0006             ;\
$A9:B8A4 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 6 (lower)
$A9:B8A8 AF 2E 78 7E LDA $7E782E[$7E:782E]  ;\
$A9:B8AC 1A          INC A                  ;} Mother Brain death beam attack phase = 1
$A9:B8AD 8F 2E 78 7E STA $7E782E[$7E:782E]  ;/

$A9:B8B1 60          RTS
}


;;; $B8B2: Mother Brain second phase - firing death beam - wait for any active bombs ;;;
{
; [Mother Brain death beam attack phase] = 1
$A9:B8B2 AF 4A 78 7E LDA $7E784A[$7E:784A]  ;\
$A9:B8B6 D0 0F       BNE $0F    [$B8C7]     ;} If [Mother Brain bomb counter] != 0: return
$A9:B8B8 A9 42 9A    LDA #$9A42             ;\
$A9:B8BB 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to $9A42 (death beam mode)
$A9:B8BE AF 2E 78 7E LDA $7E782E[$7E:782E]  ;\
$A9:B8C2 1A          INC A                  ;} Mother Brain death beam attack phase = 2
$A9:B8C3 8F 2E 78 7E STA $7E782E[$7E:782E]  ;/

$A9:B8C7 60          RTS
}


;;; $B8C8: RTS ;;;
{
; [Mother Brain death beam attack phase] = 2
$A9:B8C8 60          RTS
}


;;; $B8C9: Mother Brain second phase - firing death beam - finish ;;;
{
; [Mother Brain death beam attack phase] = 4
$A9:B8C9 A9 87 9C    LDA #$9C87             ;\
$A9:B8CC 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C87 (neutral)
$A9:B8CF A9 02 00    LDA #$0002             ;\
$A9:B8D2 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 2 (bob down)
$A9:B8D6 A9 04 00    LDA #$0004             ;\
$A9:B8D9 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 4 (bob up)
$A9:B8DD A9 00 00    LDA #$0000             ;\
$A9:B8E0 8F 2E 78 7E STA $7E782E[$7E:782E]  ;} Mother Brain death beam attack phase = 0
$A9:B8E4 A9 05 B6    LDA #$B605             ;\
$A9:B8E7 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B605 (thinking)
$A9:B8EA 60          RTS
}
}


;;; $B8EB..BCCD: Mother Brain - firing rainbow beam ;;;
{
;;; $B8EB: Mother Brain body function - second phase - firing rainbow beam - extend neck ;;;
{
$A9:B8EB A9 87 9C    LDA #$9C87             ;\
$A9:B8EE 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C87 (neutral)
$A9:B8F1 A9 40 00    LDA #$0040             ;\
$A9:B8F4 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 40h
$A9:B8F8 A9 01 00    LDA #$0001             ;\
$A9:B8FB 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:B8FF A9 02 00    LDA #$0002             ;\
$A9:B902 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 2 (bob down)
$A9:B906 A9 04 00    LDA #$0004             ;\
$A9:B909 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 4 (bob up)
$A9:B90D A9 1A B9    LDA #$B91A             ;\
$A9:B910 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B91A
$A9:B913 A9 00 01    LDA #$0100             ;\
$A9:B916 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 100h

$A9:B919 60          RTS
}


;;; $B91A: Mother Brain body function - second phase - firing rainbow beam - start charging rainbow beam ;;;
{
$A9:B91A CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B91D 10 FA       BPL $FA    [$B919]     ; If [Mother Brain body function timer] >= 0: return
$A9:B91F A9 6C 9F    LDA #$9F6C             ;\
$A9:B922 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9F6C (charging rainbow beam)
$A9:B925 A9 2B B9    LDA #$B92B             ;\
$A9:B928 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B92B
}


;;; $B92B: Mother Brain body function - second phase - firing rainbow beam - retract neck ;;;
{
$A9:B92B A9 28 00    LDA #$0028             ;\
$A9:B92E 20 48 BB    JSR $BB48  [$A9:BB48]  ;} Make Mother Brain walk backwards really slow towards X position 28h and retract head
$A9:B931 90 E6       BCC $E6    [$B919]     ; If not reached X position 28h: return
$A9:B933 A9 3F B9    LDA #$B93F             ;\
$A9:B936 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B93F
$A9:B939 A9 00 01    LDA #$0100             ;\
$A9:B93C 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 100h
}


;;; $B93F: Mother Brain body function - second phase - firing rainbow beam - wait for beam to charge ;;;
{
$A9:B93F CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B942 10 D5       BPL $D5    [$B919]     ; If [Mother Brain body function timer] >= 0: return
$A9:B944 A9 71 00    LDA #$0071             ;\
$A9:B947 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 6 (silence)
$A9:B94B A9 51 B9    LDA #$B951             ;\
$A9:B94E 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B951
}


;;; $B951: Mother Brain body function - second phase - firing rainbow beam - extend neck down ;;;
{
$A9:B951 A9 08 00    LDA #$0008             ;\
$A9:B954 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 8
$A9:B957 A9 06 00    LDA #$0006             ;\
$A9:B95A 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 6 (lower)
$A9:B95E 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 6 (lower)
$A9:B962 A9 00 05    LDA #$0500             ;\
$A9:B965 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 500h
$A9:B969 A9 75 B9    LDA #$B975             ;\
$A9:B96C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B975
$A9:B96F A9 10 00    LDA #$0010             ;\
$A9:B972 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h
}


;;; $B975: Mother Brain body function - second phase - firing rainbow beam - start firing rainbow beam ;;;
{
$A9:B975 20 6E BB    JSR $BB6E  [$A9:BB6E]  ; Aim Mother Brain rainbow beam and increase width (beam widening is pointless)
$A9:B978 AD EE 0C    LDA $0CEE  [$7E:0CEE]  ;\
$A9:B97B D0 05       BNE $05    [$B982]     ;} If power bomb active: return
$A9:B97D CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:B980 30 01       BMI $01    [$B983]     ; If [Mother Brain body function timer] >= 0:
$A9:B982 60          RTS                    ; Return

$A9:B983 AD EE 0C    LDA $0CEE  [$7E:0CEE]  ;\
$A9:B986 D0 FA       BNE $FA    [$B982]     ;} >_<
$A9:B988 9C CC 0C    STZ $0CCC  [$7E:0CCC]  ; Cooldown timer = 0
$A9:B98B 20 C6 BC    JSR $BCC6  [$A9:BCC6]  ; Mother Brain body rainbow beam palette animation index = 0
$A9:B98E A9 77 9C    LDA #$9C77             ;\
$A9:B991 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C77 (firing rainbow beam)
$A9:B994 A9 00 02    LDA #$0200             ;\
$A9:B997 8F 26 80 7E STA $7E8026[$7E:8026]  ;} Mother Brain rainbow beam angular width = 200h
$A9:B99B 22 48 E7 88 JSL $88E748[$88:E748]  ; Spawn Mother Brain rainbow beam HDMA object
$A9:B99F 8F 12 78 7E STA $7E7812[$7E:7812]  ; Mother Brain HDMA object index = [A]
$A9:B9A3 A9 40 00    LDA #$0040             ;\
$A9:B9A6 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 40h
$A9:B9AA A9 01 00    LDA #$0001             ;\
$A9:B9AD 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:B9B1 A9 02 00    LDA #$0002             ;\
$A9:B9B4 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 2 (bob down)
$A9:B9B8 A9 04 00    LDA #$0004             ;\
$A9:B9BB 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 4 (bob up)
$A9:B9BF 9C B4 0F    STZ $0FB4  [$7E:0FB4]  ; Mother Brain rainbow beam explosion index = 0
$A9:B9C2 9C B6 0F    STZ $0FB6  [$7E:0FB6]  ; Mother Brain rainbow beam explosion timer = 0
$A9:B9C5 A9 05 00    LDA #$0005             ; A = 5 (set up Samus for being drained - able to stand)
$A9:B9C8 AC C2 09    LDY $09C2  [$7E:09C2]  ;\
$A9:B9CB C0 BC 02    CPY #$02BC             ;} If [Samus health] < 700:
$A9:B9CE 10 03       BPL $03    [$B9D3]     ;/
$A9:B9D0 A9 18 00    LDA #$0018             ; A = 18h (set up Samus for being drained - unable to stand)

$A9:B9D3 22 84 F0 90 JSL $90F084[$90:F084]  ; Run Samus command
$A9:B9D7 A9 06 00    LDA #$0006             ;\
$A9:B9DA 8F 2A 78 7E STA $7E782A[$7E:782A]  ;} Number of times to queue rainbow beam sound effect = 6 (seems excessive...)
$A9:B9DE A9 E5 B9    LDA #$B9E5             ;\
$A9:B9E1 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B9E5
$A9:B9E4 60          RTS
}


;;; $B9E5: Mother Brain body function - second phase - firing rainbow beam - move Samus towards wall ;;;
{
$A9:B9E5 20 2E BB    JSR $BB2E  [$A9:BB2E]  ; Play Mother Brain rainbow beam sound effect
$A9:B9E8 20 FD BC    JSR $BCFD  [$A9:BCFD]  ; Handle Mother Brain body rainbow beam palette
$A9:B9EB 20 6E BB    JSR $BB6E  [$A9:BB6E]  ; Aim Mother Brain rainbow beam and increase width
$A9:B9EE 20 76 BC    JSR $BC76  [$A9:BC76]  ; Handle Mother Brain rainbow beam explosions
$A9:B9F1 20 B5 BB    JSR $BBB5  [$A9:BBB5]  ; Move Samus towards wall due to rainbow beam
$A9:B9F4 90 09       BCC $09    [$B9FF]     ; If not reached wall: return
$A9:B9F6 A9 00 BA    LDA #$BA00             ;\
$A9:B9F9 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BA00
$A9:B9FC 9C B2 0F    STZ $0FB2  [$7E:0FB2]  ; Mother Brain body function timer = 0

$A9:B9FF 60          RTS
}


;;; $BA00: Mother Brain body function - second phase - firing rainbow beam - 1 frame delay ;;;
{
$A9:BA00 20 2E BB    JSR $BB2E  [$A9:BB2E]  ; Play Mother Brain rainbow beam sound effect
$A9:BA03 20 FD BC    JSR $BCFD  [$A9:BCFD]  ; Handle Mother Brain body rainbow beam palette
$A9:BA06 20 6E BB    JSR $BB6E  [$A9:BB6E]  ; Aim Mother Brain rainbow beam and increase width
$A9:BA09 20 76 BC    JSR $BC76  [$A9:BC76]  ; Handle Mother Brain rainbow beam explosions
$A9:BA0C 20 B5 BB    JSR $BBB5  [$A9:BBB5]  ; Move Samus towards wall due to rainbow beam
$A9:BA0F CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:BA12 10 12       BPL $12    [$BA26]     ; If [Mother Brain body function timer] >= 0: return
$A9:BA14 A9 08 00    LDA #$0008             ;\
$A9:BA17 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 3 pixel displacement, diagonal
$A9:BA1A A9 08 00    LDA #$0008             ;\
$A9:BA1D 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 8
$A9:BA20 A9 27 BA    LDA #$BA27             ;\
$A9:BA23 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BA27

$A9:BA26 60          RTS
}


;;; $BA27: Mother Brain body function - second phase - firing rainbow beam - start draining Samus ;;;
{
$A9:BA27 A9 3C BA    LDA #$BA3C             ;\
$A9:BA2A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BA3C
$A9:BA2D A9 2B 01    LDA #$012B             ;\
$A9:BA30 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 299
$A9:BA33 8D 40 18    STA $1840  [$7E:1840]  ; Earthquake timer = 299
$A9:BA36 A9 08 00    LDA #$0008             ;\
$A9:BA39 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 3 pixel displacement, diagonal
}


;;; $BA3C: Mother Brain body function - second phase - firing rainbow beam - draining Samus ;;;
{
$A9:BA3C 20 2E BB    JSR $BB2E  [$A9:BB2E]  ; Play Mother Brain rainbow beam sound effect
$A9:BA3F 20 FD BC    JSR $BCFD  [$A9:BCFD]  ; Handle Mother Brain body rainbow beam palette
$A9:BA42 20 6E BB    JSR $BB6E  [$A9:BB6E]  ; Aim Mother Brain rainbow beam and increase width
$A9:BA45 20 76 BC    JSR $BC76  [$A9:BC76]  ; Handle Mother Brain rainbow beam explosions
$A9:BA48 22 7D C5 A9 JSL $A9C57D[$A9:C57D]  ; Damage Samus due to rainbow beam
$A9:BA4C 20 C4 C4    JSR $C4C4  [$A9:C4C4]  ; Decrement ammo due to rainbow beam
$A9:BA4F 20 CF BB    JSR $BBCF  [$A9:BBCF]  ; Move Samus towards middle of wall
$A9:BA52 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:BA55 10 6C       BPL $6C    [$BAC3]     ; If [Mother Brain body function timer] >= 0: return
$A9:BA57 A9 5E BA    LDA #$BA5E             ;\
$A9:BA5A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BA5E
$A9:BA5D 60          RTS
}


;;; $BA5E: Mother Brain body function - second phase - firing rainbow beam - finish firing rainbow beam ;;;
{
$A9:BA5E 20 2E BB    JSR $BB2E  [$A9:BB2E]  ; Play Mother Brain rainbow beam sound effect
$A9:BA61 20 FD BC    JSR $BCFD  [$A9:BCFD]  ; Handle Mother Brain body rainbow beam palette
$A9:BA64 20 82 BB    JSR $BB82  [$A9:BB82]  ; Aim Mother Brain rainbow beam
$A9:BA67 20 76 BC    JSR $BC76  [$A9:BC76]  ; Handle Mother Brain rainbow beam explosions
$A9:BA6A AF 26 80 7E LDA $7E8026[$7E:8026]  ;\
$A9:BA6E 38          SEC                    ;|
$A9:BA6F E9 80 01    SBC #$0180             ;} Mother Brain rainbow beam angular width -= 180h
$A9:BA72 8F 26 80 7E STA $7E8026[$7E:8026]  ;/
$A9:BA76 C9 00 02    CMP #$0200             ;\
$A9:BA79 10 48       BPL $48    [$BAC3]     ;} If [Mother Brain rainbow beam angular width] >= 200h: return
$A9:BA7B A9 00 02    LDA #$0200             ;\
$A9:BA7E 8F 26 80 7E STA $7E8026[$7E:8026]  ;} Mother Brain rainbow beam angular width = 200h
$A9:BA82 A9 00 FF    LDA #$FF00             ;\
$A9:BA85 8D B4 0F    STA $0FB4  [$7E:0FB4]  ;} Custom Samus X velocity = -100h
$A9:BA88 9C B6 0F    STZ $0FB6  [$7E:0FB6]  ; Custom Samus Y velocity = 0
$A9:BA8B AF 12 78 7E LDA $7E7812[$7E:7812]  ;\
$A9:BA8F AA          TAX                    ;} Delete Mother Brain HDMA object
$A9:BA90 9E B4 18    STZ $18B4,x[$7E:18B4]  ;/
$A9:BA93 9C 40 18    STZ $1840  [$7E:1840]  ; Earthquake timer = 0
$A9:BA96 A9 87 9C    LDA #$9C87             ;\
$A9:BA99 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C87 (neutral)
$A9:BA9C 20 F8 D1    JSR $D1F8  [$A9:D1F8]  ; Set up Mother Brain brain normal palette
$A9:BA9F 20 CE BC    JSR $BCCE  [$A9:BCCE]  ; Write Mother Brain default palette
$A9:BAA2 A9 02 00    LDA #$0002             ;\
$A9:BAA5 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 6 (silence)
$A9:BAA9 A9 00 00    LDA #$0000             ;\
$A9:BAAC 8F 2C 78 7E STA $7E782C[$7E:782C]  ;} Set Mother Brain rainbow beam sound effect as not playing
$A9:BAB0 A9 01 00    LDA #$0001             ;\
$A9:BAB3 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$A9:BAB7 A9 08 00    LDA #$0008             ;\
$A9:BABA 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 8
$A9:BABD A9 C4 BA    LDA #$BAC4             ;\
$A9:BAC0 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BAC4

$A9:BAC3 60          RTS
}


;;; $BAC4: Mother Brain body function - second phase - firing rainbow beam - let Samus fall ;;;
{
$A9:BAC4 A9 00 00    LDA #$0000             ;\
$A9:BAC7 22 AD E4 91 JSL $91E4AD[$91:E4AD]  ;} Let drained Samus fall
$A9:BACB A9 D1 BA    LDA #$BAD1             ;\
$A9:BACE 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BAD1
}


;;; $BAD1: Mother Brain body function - second phase - firing rainbow beam - wait for Samus to hit ground ;;;
{
$A9:BAD1 20 E1 BB    JSR $BBE1  [$A9:BBE1]  ; Move Samus for falling after rainbow beam
$A9:BAD4 90 06       BCC $06    [$BADC]     ; If not reached floor: return
$A9:BAD6 A9 DD BA    LDA #$BADD             ;\
$A9:BAD9 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BADD

$A9:BADC 60          RTS
}


;;; $BADD: Mother Brain body function - second phase - firing rainbow beam - lower head ;;;
{
$A9:BADD A9 40 00    LDA #$0040             ;\
$A9:BAE0 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 40h
$A9:BAE4 A9 01 00    LDA #$0001             ;\
$A9:BAE7 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:BAEB A9 02 00    LDA #$0002             ;\
$A9:BAEE 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 6 (lower)
$A9:BAF2 A9 04 00    LDA #$0004             ;\
$A9:BAF5 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 4 (bob up)
$A9:BAF9 A9 06 BB    LDA #$BB06             ;\
$A9:BAFC 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BB06
$A9:BAFF A9 80 00    LDA #$0080             ;\
$A9:BB02 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 80h

$A9:BB05 60          RTS
}


;;; $BB06: Mother Brain body function - second phase - firing rainbow beam - decide next action ;;;
{
$A9:BB06 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:BB09 10 FA       BPL $FA    [$BB05]     ; If [Mother Brain body function timer] >= 0: return
$A9:BB0B AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$A9:BB0E C9 90 01    CMP #$0190             ;} If [Samus health] >= 400:
$A9:BB11 30 07       BMI $07    [$BB1A]     ;/
$A9:BB13 A9 EB B8    LDA #$B8EB             ;\
$A9:BB16 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $B8EB (firing rainbow beam)
$A9:BB19 60          RTS                    ; Return

$A9:BB1A A0 0A 00    LDY #$000A             ;\
$A9:BB1D AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A9:BB20 18          CLC                    ;} Make Mother Brain walk forwards really slow 10h pixels
$A9:BB21 69 10 00    ADC #$0010             ;|
$A9:BB24 20 01 C6    JSR $C601  [$A9:C601]  ;/
$A9:BB27 A9 45 BD    LDA #$BD45             ;\
$A9:BB2A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BD45 (finish Samus off)
$A9:BB2D 60          RTS
}


;;; $BB2E: Play Mother Brain rainbow beam sound effect ;;;
{
$A9:BB2E AF 2A 78 7E LDA $7E782A[$7E:782A]  ;\
$A9:BB32 30 13       BMI $13    [$BB47]     ;} If [number of times to queue rainbow beam sound effect] < 0: return
$A9:BB34 3A          DEC A                  ;\
$A9:BB35 8F 2A 78 7E STA $7E782A[$7E:782A]  ;} Decrement number of times to queue rainbow beam sound effect
$A9:BB39 A9 40 00    LDA #$0040             ;\
$A9:BB3C 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 40h, sound library 1, max queued sounds allowed = 6 (Mother Brain's rainbow beam)
$A9:BB40 A9 01 00    LDA #$0001             ;\
$A9:BB43 8F 2C 78 7E STA $7E782C[$7E:782C]  ;} Set Mother Brain rainbow beam sound effect as playing

$A9:BB47 60          RTS
}


;;; $BB48: Make Mother Brain walk backwards really slow towards X position [A] and retract head ;;;
{
$A9:BB48 A0 0A 00    LDY #$000A             ;\
$A9:BB4B 20 47 C6    JSR $C647  [$A9:C647]  ;} Make Mother Brain walk backwards really slow towards X position [A]
$A9:BB4E B0 01       BCS $01    [$BB51]     ; If not reached X position [A]:
$A9:BB50 60          RTS                    ; Return
}


;;; $BB51: Retract Mother Brain's head ;;;
{
$A9:BB51 A9 50 00    LDA #$0050             ;\
$A9:BB54 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 50h
$A9:BB58 A9 01 00    LDA #$0001             ;\
$A9:BB5B 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:BB5F A9 08 00    LDA #$0008             ;\
$A9:BB62 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 8 (raise)
$A9:BB66 A9 06 00    LDA #$0006             ;\
$A9:BB69 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 6 (lower)
$A9:BB6D 60          RTS
}


;;; $BB6E: Aim Mother Brain rainbow beam and increase width ;;;
{
$A9:BB6E AF 26 80 7E LDA $7E8026[$7E:8026]  ;\
$A9:BB72 18          CLC                    ;|
$A9:BB73 69 80 01    ADC #$0180             ;|
$A9:BB76 C9 00 0C    CMP #$0C00             ;|
$A9:BB79 30 03       BMI $03    [$BB7E]     ;} Mother Brain rainbow beam angular width = min(C00h, [Mother Brain rainbow beam angular width] + 180h)
$A9:BB7B A9 00 0C    LDA #$0C00             ;|
                                            ;|
$A9:BB7E 8F 26 80 7E STA $7E8026[$7E:8026]  ;/
}


;;; $BB82: Aim Mother Brain rainbow beam ;;;
{
$A9:BB82 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:BB85 38          SEC                    ;|
$A9:BB86 ED BA 0F    SBC $0FBA  [$7E:0FBA]  ;|
$A9:BB89 38          SEC                    ;|
$A9:BB8A E9 10 00    SBC #$0010             ;|
$A9:BB8D 85 12       STA $12    [$7E:0012]  ;|
$A9:BB8F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} A = angle from Mother Brain brain - (10h, 4) to Samus
$A9:BB92 38          SEC                    ;|
$A9:BB93 ED BE 0F    SBC $0FBE  [$7E:0FBE]  ;|
$A9:BB96 38          SEC                    ;|
$A9:BB97 E9 04 00    SBC #$0004             ;|
$A9:BB9A 85 14       STA $14    [$7E:0014]  ;|
$A9:BB9C 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A9:BBA0 38          SEC                    ;\
$A9:BBA1 E9 80 00    SBC #$0080             ;|
$A9:BBA4 49 FF FF    EOR #$FFFF             ;|
$A9:BBA7 1A          INC A                  ;} Mother Brain rainbow beam angle = 80h - [A] & FFh (Y flip)
$A9:BBA8 29 FF 00    AND #$00FF             ;|
$A9:BBAB 8F 22 80 7E STA $7E8022[$7E:8022]  ;/
$A9:BBAF 60          RTS
}


;;; $BBB0: Unused. Calculate Mother Brain rainbow beam HDMA tables ;;;
{
$A9:BBB0 22 66 94 A9 JSL $A99466[$A9:9466]  ; Calculate Mother Brain rainbow beam HDMA tables
$A9:BBB4 60          RTS
}


;;; $BBB5: Move Samus towards wall due to rainbow beam ;;;
{
;; Returns:
;;     Carry: Set if reached wall (X position EBh), clear otherwise
$A9:BBB5 A9 00 10    LDA #$1000             ;\
$A9:BBB8 20 3F BC    JSR $BC3F  [$A9:BC3F]  ;} Move Samus 10h px horizontally towards wall
$A9:BBBB B0 11       BCS $11    [$BBCE]     ; If reached wall: return carry set
$A9:BBBD AF 22 80 7E LDA $7E8022[$7E:8022]  ;\
$A9:BBC1 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain rainbow beam angle]
$A9:BBC3 A9 00 10    LDA #$1000             ;\
$A9:BBC6 22 72 C2 86 JSL $86C272[$86:C272]  ;} A = 1000h * cos([$12] * pi / 80h)
$A9:BBCA 20 FD BB    JSR $BBFD  [$A9:BBFD]  ; Move Samus [A] px vertically towards ceiling/floor
$A9:BBCD 18          CLC                    ; Return carry clear

$A9:BBCE 60          RTS
}


;;; $BBCF: Move Samus towards middle of wall ;;;
{
$A9:BBCF A9 40 00    LDA #$0040             ; A = 40h
$A9:BBD2 A0 7C 00    LDY #$007C             ;\
$A9:BBD5 CC FA 0A    CPY $0AFA  [$7E:0AFA]  ;} If [Samus Y position] > 7Ch:
$A9:BBD8 10 04       BPL $04    [$BBDE]     ;/
$A9:BBDA 49 FF FF    EOR #$FFFF             ;\
$A9:BBDD 1A          INC A                  ;} A = -40h

$A9:BBDE 4C FD BB    JMP $BBFD  [$A9:BBFD]  ; Go to move Samus [A] / 100h px vertically towards ceiling/floor
}


;;; $BBE1: Move Samus for falling after rainbow beam ;;;
{
;; Returns:
;;     Carry: Set if reached floor (not in Y position range 30h..BFh), clear otherwise
$A9:BBE1 AD B4 0F    LDA $0FB4  [$7E:0FB4]  ;\
$A9:BBE4 18          CLC                    ;|
$A9:BBE5 69 02 00    ADC #$0002             ;|
$A9:BBE8 30 03       BMI $03    [$BBED]     ;} Custom Samus X velocity = min(0, [custom Samus X velocity] + 2)
$A9:BBEA A9 00 00    LDA #$0000             ;|
                                            ;|
$A9:BBED 8D B4 0F    STA $0FB4  [$7E:0FB4]  ;/
$A9:BBF0 20 3F BC    JSR $BC3F  [$A9:BC3F]  ; Move Samus [custom Samus X velocity] / 100h px horizontally towards wall
$A9:BBF3 AD B6 0F    LDA $0FB6  [$7E:0FB6]  ;\
$A9:BBF6 18          CLC                    ;|
$A9:BBF7 69 18 00    ADC #$0018             ;} A = custom Samus Y velocity += 18h
$A9:BBFA 8D B6 0F    STA $0FB6  [$7E:0FB6]  ;/
}


;;; $BBFD: Move Samus vertically towards ceiling/floor ;;;
{
;; Parameters:
;;     A: Y velocity. Units of 1/100h px
;; Returns:
;;     Carry: Set if reached ceiling/floor (not in Y position range 30h..BFh), clear otherwise
$A9:BBFD E2 20       SEP #$20
$A9:BBFF 18          CLC
$A9:BC00 6D FD 0A    ADC $0AFD  [$7E:0AFD]
$A9:BC03 8D FD 0A    STA $0AFD  [$7E:0AFD]
$A9:BC06 8D 17 0B    STA $0B17  [$7E:0B17]
$A9:BC09 C2 20       REP #$20
$A9:BC0B 29 00 FF    AND #$FF00
$A9:BC0E EB          XBA
$A9:BC0F 10 03       BPL $03    [$BC14]
$A9:BC11 09 00 FF    ORA #$FF00

$A9:BC14 6D FA 0A    ADC $0AFA  [$7E:0AFA]
$A9:BC17 C9 30 00    CMP #$0030
$A9:BC1A 30 0D       BMI $0D    [$BC29]
$A9:BC1C C9 C0 00    CMP #$00C0
$A9:BC1F 10 0D       BPL $0D    [$BC2E]
$A9:BC21 8D FA 0A    STA $0AFA  [$7E:0AFA]
$A9:BC24 8D 14 0B    STA $0B14  [$7E:0B14]
$A9:BC27 18          CLC
$A9:BC28 60          RTS

$A9:BC29 A9 30 00    LDA #$0030
$A9:BC2C 80 03       BRA $03    [$BC31]

$A9:BC2E A9 C0 00    LDA #$00C0

$A9:BC31 8D FA 0A    STA $0AFA  [$7E:0AFA]
$A9:BC34 8D 14 0B    STA $0B14  [$7E:0B14]
$A9:BC37 9C FC 0A    STZ $0AFC  [$7E:0AFC]
$A9:BC3A 9C 16 0B    STZ $0B16  [$7E:0B16]
$A9:BC3D 38          SEC
$A9:BC3E 60          RTS
}


;;; $BC3F: Move Samus horizontally towards wall ;;;
{
;; Parameters:
;;     A: X velocity. Units of 1/100h px
;; Returns:
;;     Carry: Set if reached wall (X position EBh), clear otherwise
$A9:BC3F E2 20       SEP #$20
$A9:BC41 18          CLC
$A9:BC42 6D F9 0A    ADC $0AF9  [$7E:0AF9]
$A9:BC45 8D F9 0A    STA $0AF9  [$7E:0AF9]
$A9:BC48 8D 13 0B    STA $0B13  [$7E:0B13]
$A9:BC4B C2 20       REP #$20
$A9:BC4D 29 00 FF    AND #$FF00
$A9:BC50 EB          XBA
$A9:BC51 10 03       BPL $03    [$BC56]
$A9:BC53 09 00 FF    ORA #$FF00

$A9:BC56 6D F6 0A    ADC $0AF6  [$7E:0AF6]
$A9:BC59 C9 EB 00    CMP #$00EB
$A9:BC5C 10 07       BPL $07    [$BC65]
$A9:BC5E 8D F6 0A    STA $0AF6  [$7E:0AF6]
$A9:BC61 8D 10 0B    STA $0B10  [$7E:0B10]
$A9:BC64 60          RTS

$A9:BC65 A9 EB 00    LDA #$00EB
$A9:BC68 8D F6 0A    STA $0AF6  [$7E:0AF6]
$A9:BC6B 8D 10 0B    STA $0B10  [$7E:0B10]
$A9:BC6E 9C F8 0A    STZ $0AF8  [$7E:0AF8]
$A9:BC71 9C 12 0B    STZ $0B12  [$7E:0B12]
$A9:BC74 38          SEC
$A9:BC75 60          RTS
}


;;; $BC76: Handle Mother Brain rainbow beam explosions ;;;
{
$A9:BC76 CE B6 0F    DEC $0FB6  [$7E:0FB6]  ; Decrement Mother Brain rainbow beam explosion timer
$A9:BC79 30 01       BMI $01    [$BC7C]     ; If [Mother Brain rainbow beam explosion timer] >= 0:
$A9:BC7B 60          RTS                    ; Return

$A9:BC7C A9 08 00    LDA #$0008             ;\
$A9:BC7F 8D B6 0F    STA $0FB6  [$7E:0FB6]  ;} Mother Brain rainbow beam explosion timer = 8
$A9:BC82 EE B4 0F    INC $0FB4  [$7E:0FB4]  ; Increment Mother Brain rainbow beam explosion index
$A9:BC85 AD B4 0F    LDA $0FB4  [$7E:0FB4]  ;\
$A9:BC88 29 07 00    AND #$0007             ;|
$A9:BC8B 0A          ASL A                  ;} X = [Mother Brain rainbow beam explosion index] % 8 * 2
$A9:BC8C AA          TAX                    ;/
$A9:BC8D BD A6 BC    LDA $BCA6,x[$A9:BCA8]  ;\
$A9:BC90 85 12       STA $12    [$7E:0012]  ;} $12 = [$BCA6 + [X]]
$A9:BC92 BD B6 BC    LDA $BCB6,x[$A9:BCB8]  ;\
$A9:BC95 85 14       STA $14    [$7E:0014]  ;} $14 = [$BCB6 + [X]]
$A9:BC97 A0 AD CB    LDY #$CBAD             ;\
$A9:BC9A 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain rainbow beam explosion enemy projectile
$A9:BC9E A9 24 00    LDA #$0024             ;\
$A9:BCA1 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
$A9:BCA5 60          RTS

$A9:BCA6             dw FFF8, 0006, FFFC, 0002, 0003, FFFA, 0008, 0000
$A9:BCB6             dw FFF9, 0002, 0005, FFFC, 0006, FFFE, FFFA, 0007
}


;;; $BCC6: Mother Brain body rainbow beam palette animation index = 0 ;;;
{
$A9:BCC6 A9 00 00    LDA #$0000             ;\
$A9:BCC9 8F 42 78 7E STA $7E7842[$7E:7842]  ;} Mother Brain body rainbow beam palette animation index = 0
$A9:BCCD 60          RTS
}
}


;;; $BCCE: Write Mother Brain default palette ;;;
{
; DB should be set to $A9
$A9:BCCE A0 74 94    LDY #$9474             ;\
$A9:BCD1 A2 82 00    LDX #$0082             ;|
$A9:BCD4 A9 0F 00    LDA #$000F             ;} BG1/2 palette 4 colours 1..Fh = [$9474..93] (Mother Brain body)
$A9:BCD7 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:BCDB A0 74 94    LDY #$9474             ;\
$A9:BCDE A2 22 01    LDX #$0122             ;|
$A9:BCE1 A9 0F 00    LDA #$000F             ;} Sprite palette 1 colours 1..Fh = [$9474..93] (Mother Brain)
$A9:BCE4 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:BCE8 A0 94 94    LDY #$9494             ;\
$A9:BCEB A2 62 01    LDX #$0162             ;|
$A9:BCEE A9 0F 00    LDA #$000F             ;} Sprite palette 3 colours 1..Fh = [$9494..B1] (Mother Brain's back leg)
$A9:BCF1 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:BCF5 60          RTS
}


;;; $BCF6: Write Mother Brain second phase death palette ;;;
{
$A9:BCF6 AF 40 E4 AD LDA $ADE440[$AD:E440]  ;\
$A9:BCFA A8          TAY                    ;} Y = $E5B2
$A9:BCFB 80 20       BRA $20    [$BD1D]     ; Go to write Mother Brain palette
}


;;; $BCFD: Handle Mother Brain body rainbow beam palette ;;;
{
$A9:BCFD AD A4 0F    LDA $0FA4  [$7E:0FA4]  ;\
$A9:BD00 29 02 00    AND #$0002             ;} If [Mother Brain body frame counter] & 2 = 0:
$A9:BD03 D0 01       BNE $01    [$BD06]     ;/
$A9:BD05 60          RTS                    ; Return

$A9:BD06 AF 42 78 7E LDA $7E7842[$7E:7842]  ; A = [Mother Brain body rainbow beam palette animation index]

; BRANCH_RESTART
$A9:BD0A AA          TAX                    ;\
$A9:BD0B BF 34 E4 AD LDA $ADE434,x[$AD:E434];} A = [$AD:E434 + [A]]
$A9:BD0F F0 F9       BEQ $F9    [$BD0A]     ; If [A] = 0: go to BRANCH_RESTART
$A9:BD11 E8          INX                    ;\
$A9:BD12 E8          INX                    ;|
$A9:BD13 8A          TXA                    ;} Mother Brain body rainbow beam palette animation index = [A] + 2
$A9:BD14 8F 42 78 7E STA $7E7842[$7E:7842]  ;/
$A9:BD18 BF 32 E4 AD LDA $ADE432,x[$AD:E434];\
$A9:BD1C A8          TAY                    ;} Y = [$AD:E434 + [Mother Brain body rainbow beam palette animation index] - 2]
}


;;; $BD1D: Write Mother Brain palette ;;;
{
;; Parameters:
;;     Y: Palette address. Bank $AD
$A9:BD1D 8B          PHB
$A9:BD1E F4 00 AD    PEA $AD00              ;\
$A9:BD21 AB          PLB                    ;} DB = $AD
$A9:BD22 AB          PLB                    ;/
$A9:BD23 5A          PHY                    ;\
$A9:BD24 A2 82 00    LDX #$0082             ;|
$A9:BD27 A9 0F 00    LDA #$000F             ;} BG1/2 palette 4 colours 1..Fh = 1Eh bytes from $AD:[Y] (Mother Brain body)
$A9:BD2A 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;|
$A9:BD2E 7A          PLY                    ;/
$A9:BD2F A2 22 01    LDX #$0122             ;\
$A9:BD32 A9 0F 00    LDA #$000F             ;} Sprite palette 1 colours 1..Fh = 1Eh bytes from $AD:[Y] (Mother Brain)
$A9:BD35 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:BD39 A2 62 01    LDX #$0162             ;\
$A9:BD3C A9 0F 00    LDA #$000F             ;} Sprite palette 3 colours 1..Fh = 1Eh bytes from $AD:[Y] + 1Eh (Mother Brain's back leg)
$A9:BD3F 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:BD43 AB          PLB
$A9:BD44 60          RTS
}


;;; $BD45..C1CE: Mother Brain - end of second phase cutscene ;;;
{
;;; $BD45: Mother Brain body function - second phase - finish Samus off - get Samus to low health ;;;
{
; NOPing the branch at $A9:BD5F counter-intuitively causes MB to never effectively launch an attack,
; I guess she never gets the chance to spawn a projectile when she's constantly switching attacks
$A9:BD45 A9 50 00    LDA #$0050             ;\
$A9:BD48 22 5E A4 A0 JSL $A0A45E[$A0:A45E]  ;|
$A9:BD4C 0A          ASL A                  ;|
$A9:BD4D 0A          ASL A                  ;} If [Samus' health] - (320 suit-adjusted damage) <= 20: go to BRANCH_DONE
$A9:BD4E 69 14 00    ADC #$0014             ;|
$A9:BD51 CD C2 09    CMP $09C2  [$7E:09C2]  ;|
$A9:BD54 10 3B       BPL $3B    [$BD91]     ;/
$A9:BD56 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:BD59 29 FF 0F    AND #$0FFF             ;|
$A9:BD5C C9 A0 0F    CMP #$0FA0             ;} If [random number] & FFFh < FA0h: go to BRANCH_NO_ATTACK
$A9:BD5F 90 25       BCC $25    [$BD86]     ;/
$A9:BD61 A9 A0 00    LDA #$00A0             ;\
$A9:BD64 22 5E A4 A0 JSL $A0A45E[$A0:A45E]  ;|
$A9:BD68 18          CLC                    ;|
$A9:BD69 69 14 00    ADC #$0014             ;} If [Samus' health] - (160 suit-adjusted damage) <= 20: go to BRANCH_BLUE_RINGS
$A9:BD6C CD C2 09    CMP $09C2  [$7E:09C2]  ;|
$A9:BD6F 10 0E       BPL $0E    [$BD7F]     ;/
$A9:BD71 A0 CC 9E    LDY #$9ECC             ; Y = $9ECC (attacking - bomb)
$A9:BD74 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:BD77 29 FF 0F    AND #$0FFF             ;|
$A9:BD7A C9 F0 0F    CMP #$0FF0             ;} If [random number] & FFFh >= FF0h: go to BRANCH_DO_ATTACK
$A9:BD7D B0 03       BCS $03    [$BD82]     ;/

; BRANCH_BLUE_RINGS
$A9:BD7F A0 7F 9D    LDY #$9D7F             ; Y = $9D7F (attacking - two blue rings)

; BRANCH_DO_ATTACK
$A9:BD82 98          TYA                    ;\
$A9:BD83 4C 47 C4    JMP $C447  [$A9:C447]  ;} Go to set Mother Brain brain instruction list to [Y]

; BRANCH_NO_ATTACK
$A9:BD86 AD A4 0F    LDA $0FA4  [$7E:0FA4]  ;\
$A9:BD89 29 1F 00    AND #$001F             ;} If [Mother Brain body frame counter] % 20h != 0: return
$A9:BD8C D0 09       BNE $09    [$BD97]     ;/
$A9:BD8E 4C A7 C1    JMP $C1A7  [$A9:C1A7]  ; Go to maybe make Mother Brain stand up or lean down

; BRANCH_DONE
$A9:BD91 A9 98 BD    LDA #$BD98             ;\
$A9:BD94 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BD98

$A9:BD97 60          RTS
}


;;; $BD98: Mother Brain body function - second phase - finish Samus off - stand up ;;;
{
$A9:BD98 20 70 C6    JSR $C670  [$A9:C670]  ; Make Mother Brain stand up
$A9:BD9B 90 4F       BCC $4F    [$BDEC]     ; If not standing: return
$A9:BD9D A9 A9 BD    LDA #$BDA9             ;\
$A9:BDA0 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BDA9
$A9:BDA3 A9 10 00    LDA #$0010             ;\
$A9:BDA6 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h
}


;;; $BDA9: Mother Brain body function - second phase - finish Samus off - admire job well done ;;;
{
$A9:BDA9 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:BDAC 10 3E       BPL $3E    [$BDEC]     ; If [Mother Brain body function timer] >= 0: return
$A9:BDAE A9 7F 9B    LDA #$9B7F             ;\
$A9:BDB1 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9B7F (stretching)
$A9:BDB4 A9 C1 BD    LDA #$BDC1             ;\
$A9:BDB7 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BDC1
$A9:BDBA A9 00 01    LDA #$0100             ;\
$A9:BDBD 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 100h
$A9:BDC0 60          RTS
}


;;; $BDC1: Mother Brain body function - second phase - finish Samus off - charge final rainbow beam ;;;
{
$A9:BDC1 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:BDC4 10 26       BPL $26    [$BDEC]     ; If [Mother Brain body function timer] >= 0: return
$A9:BDC6 A9 6C 9F    LDA #$9F6C             ;\
$A9:BDC9 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9F6C (charging rainbow beam)
$A9:BDCC A9 D2 BD    LDA #$BDD2             ;\
$A9:BDCF 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BDD2
}


;;; $BDD2: Mother Brain body function - second phase - finish Samus off - charge final rainbow beam / load Shitroid ;;;
{
$A9:BDD2 A2 E5 8F    LDX #$8FE5             ;\
$A9:BDD5 20 BE C5    JSR $C5BE  [$A9:C5BE]  ;} Load Shitroid tiles
$A9:BDD8 90 12       BCC $12    [$BDEC]     ; If not finished loading: return
$A9:BDDA 20 51 BB    JSR $BB51  [$A9:BB51]  ; Retract Mother Brain's head
$A9:BDDD 20 1B BE    JSR $BE1B  [$A9:BE1B]  ; Spawn Shitroid in cutscene
$A9:BDE0 A9 ED BD    LDA #$BDED             ;\
$A9:BDE3 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BDED
$A9:BDE6 A9 00 01    LDA #$0100             ;\
$A9:BDE9 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 100h

$A9:BDEC 60          RTS
}


;;; $BDED: Mother Brain body function - second phase - finish Samus off - fire final rainbow beam ;;;
{
$A9:BDED CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:BDF0 10 FA       BPL $FA    [$BDEC]     ; If [Mother Brain body function timer] >= 0: return
$A9:BDF2 20 C6 BC    JSR $BCC6  [$A9:BCC6]  ; Mother Brain body rainbow beam palette animation index = 0
$A9:BDF5 A9 77 9C    LDA #$9C77             ;\
$A9:BDF8 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C77 (firing rainbow beam)
$A9:BDFB A9 06 00    LDA #$0006             ;\
$A9:BDFE 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 6 (lower)
$A9:BE02 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 6 (lower)
$A9:BE06 A9 00 05    LDA #$0500             ;\
$A9:BE09 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 500h
$A9:BE0D A9 71 00    LDA #$0071             ;\
$A9:BE10 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 6 (silence)
$A9:BE14 A9 1A BE    LDA #$BE1A             ;\
$A9:BE17 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = RTS

$A9:BE1A 60          RTS
}


;;; $BE1B: Spawn Shitroid in cutscene ;;;
{
$A9:BE1B A2 28 BE    LDX #$BE28             ;\
$A9:BE1E 22 75 92 A0 JSL $A09275[$A0:9275]  ;} Spawn Shitroid in cutscene
$A9:BE22 8A          TXA                    ;\
$A9:BE23 8F 54 78 7E STA $7E7854[$7E:7854]  ;} Shitroid enemy index = [X]
$A9:BE27 60          RTS

;                        ____________________________________ Enemy ID
;                       |     _______________________________ X position
;                       |    |     __________________________ Y position
;                       |    |    |     _____________________ Initialisation parameter
;                       |    |    |    |     ________________ Properties
;                       |    |    |    |    |     ___________ Extra properties
;                       |    |    |    |    |    |     ______ Parameter 1
;                       |    |    |    |    |    |    |     _ Parameter 2
;                       |    |    |    |    |    |    |    |
$A9:BE28             dw ECBF,0180,0040,CFA2,2800,0000,0000,0000
}


;;; $BE38: Mother Brain body function - drained by Shitroid - taken aback by Shitroid ;;;
{
$A9:BE38 A9 03 00    LDA #$0003             ;\
$A9:BE3B 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Mother Brain's form = drained by Shitroid
$A9:BE3F A9 08 00    LDA #$0008             ;\
$A9:BE42 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 8 (raise)
$A9:BE46 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 8 (raise)
$A9:BE4A A9 00 07    LDA #$0700             ;\
$A9:BE4D 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 700h
$A9:BE51 A9 5D BE    LDA #$BE5D             ;\
$A9:BE54 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BE5D
$A9:BE57 A9 30 00    LDA #$0030             ;\
$A9:BE5A 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 30h
}


;;; $BE5D: Mother Brain body function - drained by Shitroid - regain balance ;;;
{
$A9:BE5D 20 FD BC    JSR $BCFD  [$A9:BCFD]  ; Handle Mother Brain body rainbow beam palette
$A9:BE60 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:BE63 10 30       BPL $30    [$BE95]     ; If [Mother Brain body function timer] >= 0: return
$A9:BE65 A9 96 BE    LDA #$BE96             ;\
$A9:BE68 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BE96
$A9:BE6B A9 D0 BF    LDA #$BFD0             ;\
$A9:BE6E 8F 50 78 7E STA $7E7850[$7E:7850]  ;} Mother Brain painful walking function = $BFD0 (walk forwards)
$A9:BE72 A9 00 00    LDA #$0000             ;\
$A9:BE75 8F 4C 78 7E STA $7E784C[$7E:784C]  ;} Mother Brain painful walking stage = 0
$A9:BE79 A9 02 00    LDA #$0002             ;\
$A9:BE7C 8F 4E 78 7E STA $7E784E[$7E:784E]  ;} Mother Brain painful walking walk animation delay = 2 (really fast)
$A9:BE80 A9 01 00    LDA #$0001
$A9:BE83 AF 62 80 7E LDA $7E8062[$7E:8062]  ; <-- typo, should be enabling neck movement, fortunately this is already enabled anyway
$A9:BE87 A9 02 00    LDA #$0002             ;\
$A9:BE8A 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 2 (bob down)
$A9:BE8E A9 04 00    LDA #$0004             ;\
$A9:BE91 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 4 (bob up)

$A9:BE95 60          RTS
}


;;; $BE96: Mother Brain body function - drained by Shitroid - firing rainbow beam ;;;
{
$A9:BE96 AF 40 78 7E LDA $7E7840[$7E:7840]  ;\
$A9:BE9A D0 07       BNE $07    [$BEA3]     ;} If [Mother Brain brain main shake timer] = 0:
$A9:BE9C A9 32 00    LDA #$0032             ;\
$A9:BE9F 8F 40 78 7E STA $7E7840[$7E:7840]  ;} Mother Brain brain main shake timer = 50

$A9:BEA3 20 FD BC    JSR $BCFD  [$A9:BCFD]  ; Handle Mother Brain body rainbow beam palette
$A9:BEA6 AF 50 78 7E LDA $7E7850[$7E:7850]  ;\
$A9:BEAA 85 12       STA $12    [$7E:0012]  ;|
$A9:BEAC F4 B1 BE    PEA $BEB1              ;} Execute [Mother Brain painful walking function]
$A9:BEAF 6C 12 00    JMP ($0012)[$A9:BFD0]  ;/

$A9:BEB2 AF 4C 78 7E LDA $7E784C[$7E:784C]  ;\
$A9:BEB6 0A          ASL A                  ;} Y = [Mother Brain painful walking stage] * 2
$A9:BEB7 A8          TAY                    ;/
$A9:BEB8 B9 EE BE    LDA $BEEE,y[$A9:BEEE]  ;\
$A9:BEBB 29 FF 00    AND #$00FF             ;} Mother Brain painful walking walk animation delay = [$BEEE + [Y]]
$A9:BEBE 8F 4E 78 7E STA $7E784E[$7E:784E]  ;/
$A9:BEC2 B9 FE BE    LDA $BEFE,y[$A9:BEFE]  ;\
$A9:BEC5 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = [$BEFE + [Y]]
$A9:BEC9 AF 4C 78 7E LDA $7E784C[$7E:784C]  ;\
$A9:BECD C9 06 00    CMP #$0006             ;} If [Mother Brain painful walking stage] != 6: return
$A9:BED0 D0 1B       BNE $1B    [$BEED]     ;/
$A9:BED2 A9 00 00    LDA #$0000             ;\
$A9:BED5 8F 2C 78 7E STA $7E782C[$7E:782C]  ;} Set Mother Brain rainbow beam sound effect as not playing
$A9:BED9 8F 60 78 7E STA $7E7860[$7E:7860]  ; Disable Mother Brain brain palette handling
$A9:BEDD 20 F6 BC    JSR $BCF6  [$A9:BCF6]  ; Write Mother Brain second phase death palette
$A9:BEE0 A9 02 00    LDA #$0002             ;\
$A9:BEE3 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 6 (silence)
$A9:BEE7 A9 0E BF    LDA #$BF0E             ;\
$A9:BEEA 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BF0E

$A9:BEED 60          RTS

$A9:BEEE             dw 0002, 0002, 0006, 0006, 0008, 0008, 000A, 000A ; Walking animation delays
$A9:BEFE             dw 0500, 0500, 0200, 0200, 00C0, 00C0, 0040, 0040 ; Neck angle deltas
}


;;; $BF0E: Mother Brain body function - drained by Shitroid - rainbow beam has run out ;;;
{
$A9:BF0E AF 50 78 7E LDA $7E7850[$7E:7850]  ;\
$A9:BF12 85 12       STA $12    [$7E:0012]  ;|
$A9:BF14 F4 19 BF    PEA $BF19              ;} Execute [Mother Brain painful walking function]
$A9:BF17 6C 12 00    JMP ($0012)[$A9:BFD0]  ;/

$A9:BF1A AF 4C 78 7E LDA $7E784C[$7E:784C]  ;\
$A9:BF1E C9 08 00    CMP #$0008             ;} If [Mother Brain painful walking stage] < 8: return
$A9:BF21 30 59       BMI $59    [$BF7C]     ;/
$A9:BF23 A9 40 00    LDA #$0040             ;\
$A9:BF26 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 40h
$A9:BF2A A9 08 00    LDA #$0008             ;\
$A9:BF2D 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 8 (raise)
$A9:BF31 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 8 (raise)
$A9:BF35 A9 39 9C    LDA #$9C39             ;\
$A9:BF38 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9C39 (dying drool)
$A9:BF3B A9 41 BF    LDA #$BF41             ;\
$A9:BF3E 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BF41
}


;;; $BF41: Mother Brain body function - drained by Shitroid - move to back of room ;;;
{
$A9:BF41 A9 28 00    LDA #$0028             ;\
$A9:BF44 20 47 C6    JSR $C647  [$A9:C647]  ;} Make Mother Brain walk backwards towards X position 28h with animation delay [Y]
$A9:BF47 90 33       BCC $33    [$BF7C]     ; If not reached X position 28h: return
$A9:BF49 A9 56 BF    LDA #$BF56             ;\
$A9:BF4C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BF56
$A9:BF4F A9 00 00    LDA #$0000             ;\
$A9:BF52 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 0 (nothing)
}


;;; $BF56: Mother Brain body function - drained by Shitroid - go into low power mode ;;;
{
$A9:BF56 AF 64 80 7E LDA $7E8064[$7E:8064]  ;\
$A9:BF5A 0F 66 80 7E ORA $7E8066[$7E:8066]  ;} If not finished raising neck: return
$A9:BF5E D0 1C       BNE $1C    [$BF7C]     ;/
$A9:BF60 8F 64 78 7E STA $7E7864[$7E:7864]  ; Disable Mother Brain's drool generation
$A9:BF64 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:BF68 D0 12       BNE $12    [$BF7C]     ;} If [Mother Brain pose] != standing: return
$A9:BF6A A9 26 9A    LDA #$9A26             ;\
$A9:BF6D 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to $9A26 (crouch - fast)
$A9:BF70 A9 7D BF    LDA #$BF7D             ;\
$A9:BF73 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BF7D
$A9:BF76 A9 40 00    LDA #$0040             ;\
$A9:BF79 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 40h

$A9:BF7C 60          RTS
}


;;; $BF7D: Mother Brain body function - drained by Shitroid - prepare transition to grey ;;;
{
$A9:BF7D CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:BF80 10 FA       BPL $FA    [$BF7C]     ; If [Mother Brain body function timer] >= 0: return
$A9:BF82 A9 00 00    LDA #$0000             ;\
$A9:BF85 8F 2E 80 7E STA $7E802E[$7E:802E]  ;} Mother Brain grey transition counter = 0
$A9:BF89 A9 95 BF    LDA #$BF95             ;\
$A9:BF8C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BF95
$A9:BF8F A9 10 00    LDA #$0010             ;\
$A9:BF92 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h
}


;;; $BF95: Mother Brain body function - drained by Shitroid - transition to grey ;;;
{
$A9:BF95 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:BF98 10 E2       BPL $E2    [$BF7C]     ; If [Mother Brain body function timer] >= 0: return
$A9:BF9A A9 10 00    LDA #$0010             ;\
$A9:BF9D 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h <-- this doesn't get used
$A9:BFA0 AF 2E 80 7E LDA $7E802E[$7E:802E]  ;\
$A9:BFA4 1A          INC A                  ;} Increment Mother Brain grey transition counter
$A9:BFA5 8F 2E 80 7E STA $7E802E[$7E:802E]  ;/
$A9:BFA9 3A          DEC A                  ; A = [Mother Brain grey transition counter] - 1
$A9:BFAA 22 4A EF AD JSL $ADEF4A[$AD:EF4A]  ; Transition Mother Brain palette to grey
$A9:BFAE 90 CC       BCC $CC    [$BF7C]     ; If not finished transitioning: return
$A9:BFB0 A9 A0 8C    LDA #$8CA0             ;\
$A9:BFB3 8D CC 0F    STA $0FCC  [$7E:0FCC]  ;} Mother Brain brain health = 36,000
$A9:BFB6 A9 01 00    LDA #$0001             ;\
$A9:BFB9 8F 3E 78 7E STA $7E783E[$7E:783E]  ;} Mother Brain phase 2 corpse state = turned into corpse by Shitroid
$A9:BFBD 3A          DEC A                  ;\
$A9:BFBE 8F 68 78 7E STA $7E7868[$7E:7868]  ;} Disable Mother Brain's small purple breath generation
$A9:BFC2 A9 02 00    LDA #$0002             ;\
$A9:BFC5 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Mother Brain's form = second phase
$A9:BFC9 A9 59 C0    LDA #$C059             ;\
$A9:BFCC 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C059 (revive self)
$A9:BFCF 60          RTS
}


;;; $BFD0: Mother Brain painful walking function - walk forwards  ;;;
{
$A9:BFD0 AF 4E 78 7E LDA $7E784E[$7E:784E]  ;\
$A9:BFD4 A8          TAY                    ;|
$A9:BFD5 A9 48 00    LDA #$0048             ;} Make Mother Brain walk forwards towards X position 48h with animation delay [$7E:784E]
$A9:BFD8 20 01 C6    JSR $C601  [$A9:C601]  ;/
$A9:BFDB 90 0A       BCC $0A    [$BFE7]     ; If not reached X position 48h: return
$A9:BFDD A9 E8 BF    LDA #$BFE8             ;\
$A9:BFE0 8F 50 78 7E STA $7E7850[$7E:7850]  ;} Mother Brain painful walking function = $BFE8
$A9:BFE4 20 38 C0    JSR $C038  [$A9:C038]  ; Set Mother Brain painful walking function timer

$A9:BFE7 60          RTS
}


;;; $BFE8: Mother Brain painful walking function - walking forwards ;;;
{
$A9:BFE8 AF 52 78 7E LDA $7E7852[$7E:7852]  ;\
$A9:BFEC 3A          DEC A                  ;} Decrement Mother Brain painful walking function timer
$A9:BFED 8F 52 78 7E STA $7E7852[$7E:7852]  ;/
$A9:BFF1 D0 10       BNE $10    [$C003]     ; If [Mother Brain painful walking function timer] != 0: return
$A9:BFF3 AF 4C 78 7E LDA $7E784C[$7E:784C]  ;\
$A9:BFF7 1A          INC A                  ;} Increment Mother Brain painful walking stage
$A9:BFF8 8F 4C 78 7E STA $7E784C[$7E:784C]  ;/
$A9:BFFC A9 04 C0    LDA #$C004             ;\
$A9:BFFF 8F 50 78 7E STA $7E7850[$7E:7850]  ;} Mother Brain painful walking function = $C004

$A9:C003 60          RTS
}


;;; $C004: Mother Brain painful walking function - walk backwards ;;;
{
$A9:C004 AF 4E 78 7E LDA $7E784E[$7E:784E]  ;\
$A9:C008 A8          TAY                    ;|
$A9:C009 A9 28 00    LDA #$0028             ;} Make Mother Brain walk backwards towards X position 28h with animation delay [Mother Brain painful walking walk animation delay]
$A9:C00C 20 47 C6    JSR $C647  [$A9:C647]  ;/
$A9:C00F 90 0A       BCC $0A    [$C01B]     ; If not reached X position 28h: return
$A9:C011 A9 1C C0    LDA #$C01C             ;\
$A9:C014 8F 50 78 7E STA $7E7850[$7E:7850]  ;} Mother Brain painful walking function = $C01C
$A9:C018 20 38 C0    JSR $C038  [$A9:C038]  ; Set Mother Brain painful walking function timer

$A9:C01B 60          RTS
}


;;; $C01C: Mother Brain painful walking function - walking backwards ;;;
{
$A9:C01C AF 52 78 7E LDA $7E7852[$7E:7852]  ;\
$A9:C020 3A          DEC A                  ;} Mother Brain painful walking function timer
$A9:C021 8F 52 78 7E STA $7E7852[$7E:7852]  ;/
$A9:C025 D0 10       BNE $10    [$C037]     ; If [Mother Brain painful walking function timer] != 0: return
$A9:C027 AF 4C 78 7E LDA $7E784C[$7E:784C]  ;\
$A9:C02B 1A          INC A                  ;} Increment Mother Brain painful walking stage
$A9:C02C 8F 4C 78 7E STA $7E784C[$7E:784C]  ;/
$A9:C030 A9 D0 BF    LDA #$BFD0             ;\
$A9:C033 8F 50 78 7E STA $7E7850[$7E:7850]  ;} Mother Brain painful walking function = $BFD0 (walk forwards)

$A9:C037 60          RTS
}


;;; $C038: Set Mother Brain painful walking function timer ;;;
{
$A9:C038 AF 4C 78 7E LDA $7E784C[$7E:784C]  ;\
$A9:C03C 0A          ASL A                  ;|
$A9:C03D A8          TAY                    ;|
$A9:C03E B9 49 C0    LDA $C049,y[$A9:C049]  ;} Mother Brain painful walking function timer = [$C049 + [Mother Brain painful walking stage] * 2]
$A9:C041 29 FF 00    AND #$00FF             ;|
$A9:C044 8F 52 78 7E STA $7E7852[$7E:7852]  ;/
$A9:C048 60          RTS

$A9:C049             dw 0010, 0010, 0020, 0020, 0030, 0030, 0040, 0040
}


;;; $C059: Mother Brain body function - second phase - revive self - inanimate grey ;;;
{
$A9:C059 A9 66 C0    LDA #$C066             ;\
$A9:C05C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C066
$A9:C05F A9 00 03    LDA #$0300             ;\
$A9:C062 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 300h

$A9:C065 60          RTS
}


;;; $C066: Mother Brain body function - second phase - revive self - show signs of life ;;;
{
$A9:C066 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:C069 10 FA       BPL $FA    [$C065]     ; If [Mother Brain body function timer] >= 0: return
$A9:C06B A9 01 00    LDA #$0001             ;\
$A9:C06E 8F 68 78 7E STA $7E7868[$7E:7868]  ;} Enable Mother Brain's small purple breath generation
$A9:C072 8F 64 78 7E STA $7E7864[$7E:7864]  ; Enable Mother Brain's drool generation
$A9:C076 A9 82 C0    LDA #$C082             ;\
$A9:C079 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C082
$A9:C07C A9 E0 00    LDA #$00E0             ;\
$A9:C07F 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = E0h
}


;;; $C082: Mother Brain body function - second phase - revive self - prepare transition from grey ;;;
{
$A9:C082 A9 8F C0    LDA #$C08F             ;\
$A9:C085 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C08F
$A9:C088 A9 00 00    LDA #$0000             ;\
$A9:C08B 8F 2E 80 7E STA $7E802E[$7E:802E]  ;} Mother Brain grey transition counter = 0
}


;;; $C08F: Mother Brain body function - second phase - revive self - transition from grey ;;;
{
$A9:C08F CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:C092 10 D1       BPL $D1    [$C065]     ; If [Mother Brain body function timer] >= 0: return
$A9:C094 A9 10 00    LDA #$0010             ;\
$A9:C097 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h <-- this doesn't get used
$A9:C09A AF 2E 80 7E LDA $7E802E[$7E:802E]  ;\
$A9:C09E 1A          INC A                  ;} Increment Mother Brain grey transition counter
$A9:C09F 8F 2E 80 7E STA $7E802E[$7E:802E]  ;/
$A9:C0A3 3A          DEC A                  ; A = [Mother Brain grey transition counter] - 1
$A9:C0A4 22 0D EF AD JSL $ADEF0D[$AD:EF0D]  ; Transition Mother Brain palette from grey
$A9:C0A8 90 BB       BCC $BB    [$C065]     ; If not finished transitioning: return
$A9:C0AA A9 BA C0    LDA #$C0BA             ;\
$A9:C0AD 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C0BA
$A9:C0B0 A9 01 00    LDA #$0001             ;\
$A9:C0B3 8F 60 78 7E STA $7E7860[$7E:7860]  ;} Enable Mother Brain brain palette handling
$A9:C0B7 20 F8 D1    JSR $D1F8  [$A9:D1F8]  ; Set up Mother Brain brain normal palette
}


;;; $C0BA: Mother Brain body function - second phase - revive self - wake up ;;;
{
$A9:C0BA 20 70 C6    JSR $C670  [$A9:C670]  ; Make Mother Brain stand up
$A9:C0BD 90 A6       BCC $A6    [$C065]     ; If not standing: return
$A9:C0BF A9 06 00    LDA #$0006             ;\
$A9:C0C2 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 6 (lower)
$A9:C0C6 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 6 (lower)
$A9:C0CA A9 00 05    LDA #$0500             ;\
$A9:C0CD 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 500h
$A9:C0D1 A9 01 00    LDA #$0001             ;\
$A9:C0D4 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:C0D8 A9 E4 C0    LDA #$C0E4             ;\
$A9:C0DB 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C0E4
$A9:C0DE A9 10 00    LDA #$0010             ;\
$A9:C0E1 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 10h
}


;;; $C0E4: Mother Brain body function - second phase - revive self - wake-up stretch ;;;
{
$A9:C0E4 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:C0E7 10 34       BPL $34    [$C11D]     ; If [Mother Brain body function timer] >= 0: return
$A9:C0E9 A9 B3 9B    LDA #$9BB3             ;\
$A9:C0EC 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9BB3 (stretching - phase 3)
$A9:C0EF A9 FB C0    LDA #$C0FB             ;\
$A9:C0F2 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C0FB
$A9:C0F5 A9 80 00    LDA #$0080             ;\
$A9:C0F8 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 80h
}


;;; $C0FB: Mother Brain body function - second phase - revive self - walk up to Shitroid ;;;
{
$A9:C0FB CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:C0FE 10 1D       BPL $1D    [$C11D]     ; If [Mother Brain body function timer] >= 0: return
$A9:C100 A0 04 00    LDY #$0004             ;\
$A9:C103 A9 50 00    LDA #$0050             ;} Make Mother Brain walk forwards fast towards X position 50h
$A9:C106 20 01 C6    JSR $C601  [$A9:C601]  ;/
$A9:C109 90 12       BCC $12    [$C11D]     ; If not reached X position 50h: return
$A9:C10B A9 1E C1    LDA #$C11E             ;\
$A9:C10E 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C11E
$A9:C111 A9 02 00    LDA #$0002             ;\
$A9:C114 8F 3E 78 7E STA $7E783E[$7E:783E]  ;} Mother Brain phase 2 corpse state = recovered from being a corpse
$A9:C118 3A          DEC A                  ;\
$A9:C119 8F 62 78 7E STA $7E7862[$7E:7862]  ;} Enable Mother Brain health-based palette handling

$A9:C11D 60          RTS
}


;;; $C11E: Mother Brain body function - second phase - revive self - prepare neck for Shitroid murder ;;;
{
$A9:C11E A9 00 00    LDA #$0000             ;\
$A9:C121 8F 26 78 7E STA $7E7826[$7E:7826]  ;} Mother Brain Shitroid attack counter = 0
$A9:C125 A9 01 00    LDA #$0001             ;\
$A9:C128 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:C12C A9 02 00    LDA #$0002             ;\
$A9:C12F 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 2 (bob down)
$A9:C133 A9 04 00    LDA #$0004             ;\
$A9:C136 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 4 (bob up)
$A9:C13A A9 40 00    LDA #$0040             ;\
$A9:C13D 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 40h
$A9:C141 A9 47 C1    LDA #$C147             ;\
$A9:C144 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C147
}


;;; $C147: Mother Brain body function - second phase - revive self - finish preparing for Shitroid murder ;;;
{
$A9:C147 20 70 C6    JSR $C670  [$A9:C670]  ; Make Mother Brain stand up
$A9:C14A B0 01       BCS $01    [$C14D]     ; If not standing:
$A9:C14C 60          RTS                    ; Return

$A9:C14D A9 5C C1    LDA #$C15C             ;\
$A9:C150 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C15C (murder Shitroid)
$A9:C153 A0 0A 00    LDY #$000A             ;\
$A9:C156 A9 50 00    LDA #$0050             ;} Make Mother Brain walk forwards really slow towards X position 50h
$A9:C159 20 01 C6    JSR $C601  [$A9:C601]  ;/
}


;;; $C15C: Mother Brain body function - second phase - murder Shitroid - attack Shitroid ;;;
{
$A9:C15C 20 A7 C1    JSR $C1A7  [$A9:C1A7]  ; Maybe make Mother Brain stand up or lean down
$A9:C15F AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:C162 30 01       BMI $01    [$C165]     ;} If [random number] & 8000h = 0:
$A9:C164 60          RTS                    ; Return

$A9:C165 A0 BB 9D    LDY #$9DBB             ; Y = $9DBB (attacking Samus - four blue rings)
$A9:C168 AF 54 78 7E LDA $7E7854[$7E:7854]  ;\
$A9:C16C F0 03       BEQ $03    [$C171]     ;} If [Shitroid enemy index] != 0:
$A9:C16E A0 B1 9D    LDY #$9DB1             ; Y = $9DB1 (attacking Shitroid)

$A9:C171 98          TYA                    ;\
$A9:C172 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to [Y]
$A9:C175 A9 82 C1    LDA #$C182             ;\
$A9:C178 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C182
$A9:C17B A9 40 00    LDA #$0040             ;\
$A9:C17E 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 40h

$A9:C181 60          RTS
}


;;; $C182: Mother Brain body function - second phase - murder Shitroid - Shitroid attack cooldown ;;;
{
$A9:C182 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:C185 10 FA       BPL $FA    [$C181]     ; If [Mother Brain body function timer] >= 0: return
$A9:C187 A9 5C C1    LDA #$C15C             ;\
$A9:C18A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C15C (attack Shitroid)
$A9:C18D 60          RTS
}


;;; $C18E: Mother Brain body function - second phase - prepare for final Shitroid attack ;;;
{
; This isn't waiting for Mother Brain to finish standing up (bug?)
$A9:C18E 20 70 C6    JSR $C670  [$A9:C670]  ; Make Mother Brain stand up
$A9:C191 A0 04 00    LDY #$0004             ;\
$A9:C194 A9 40 00    LDA #$0040             ;} Make Mother Brain walk backwards fast towards X position 40h
$A9:C197 4C 47 C6    JMP $C647  [$A9:C647]  ;/
}


;;; $C19A: Mother Brain body function - second phase - execute final Shitroid attack ;;;
{
$A9:C19A A9 B1 9D    LDA #$9DB1             ;\
$A9:C19D 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9DB1 (attacking Shitroid)
$A9:C1A0 A9 A6 C1    LDA #$C1A6             ;\
$A9:C1A3 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = RTS

$A9:C1A6 60          RTS
}


;;; $C1A7: Maybe make Mother Brain stand up or lean down ;;;
{
$A9:C1A7 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C1AB F0 13       BEQ $13    [$C1C0]     ;} If [Mother Brain pose] != standing:
$A9:C1AD C9 06 00    CMP #$0006             ;\
$A9:C1B0 D0 1C       BNE $1C    [$C1CE]     ;} If [Mother Brain pose] != leaning down: return
$A9:C1B2 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:C1B5 29 FF 00    AND #$00FF             ;|
$A9:C1B8 C9 C0 00    CMP #$00C0             ;} If [random number] & FFh < C0h: return
$A9:C1BB 90 11       BCC $11    [$C1CE]     ;/
$A9:C1BD 4C 70 C6    JMP $C670  [$A9:C670]  ; Go to make Mother Brain stand up

$A9:C1C0 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:C1C3 29 FF 00    AND #$00FF             ;|
$A9:C1C6 C9 C0 00    CMP #$00C0             ;} If [random number] & FFh < C0h: return
$A9:C1C9 90 03       BCC $03    [$C1CE]     ;/
$A9:C1CB 4C A3 C6    JMP $C6A3  [$A9:C6A3]  ; Go to make Mother Brain lean down

$A9:C1CE 60          RTS
}
}


;;; $C1CF..C3EE: Mother Brain - third phase ;;;
{
;;; $C1CF: Mother Brain body function - third phase - recover from cutscene - make some distance ;;;
{
$A9:C1CF A9 04 00    LDA #$0004             ;\
$A9:C1D2 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Mother Brain's form = third phase
$A9:C1D6 A9 F0 C1    LDA #$C1F0             ;\
$A9:C1D9 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C1F0
$A9:C1DC A9 20 00    LDA #$0020             ;\
$A9:C1DF 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 20h
$A9:C1E2 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C1E5 38          SEC                    ;|
$A9:C1E6 E9 0E 00    SBC #$000E             ;} Make Mother Brain walk backwards Eh pixels really fast
$A9:C1E9 A0 02 00    LDY #$0002             ;|
$A9:C1EC 20 47 C6    JSR $C647  [$A9:C647]  ;/
$A9:C1EF 60          RTS
}


;;; $C1F0: Mother Brain body function - third phase - recover from cutscene - set up for fighting ;;;
{
$A9:C1F0 CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:C1F3 10 FA       BPL $FA    [$C1EF]     ; If [Mother Brain body function timer] >= 0: return
$A9:C1F5 A9 09 C2    LDA #$C209             ;\
$A9:C1F8 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C209
$A9:C1FB A9 30 C3    LDA #$C330             ;\
$A9:C1FE 8F 70 78 7E STA $7E7870[$7E:7870]  ;} Mother Brain neck function = $C330 (normal)
$A9:C202 A9 6A C2    LDA #$C26A             ;\
$A9:C205 8F 74 78 7E STA $7E7874[$7E:7874]  ;} Mother Brain walking function = $C26A (try to inch forward)
}


;;; $C209: Mother Brain body function - third phase - fighting - main ;;;
{
$A9:C209 AD CC 0F    LDA $0FCC  [$7E:0FCC]  ;\
$A9:C20C D0 07       BNE $07    [$C215]     ;} If [Mother Brain brain health] = 0:
$A9:C20E A9 E1 AE    LDA #$AEE1             ;\
$A9:C211 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $AEE1 (death sequence)
$A9:C214 60          RTS                    ; Return

$A9:C215 20 27 C3    JSR $C327  [$A9:C327]  ; Mother Brain third phase neck handler
$A9:C218 20 5A C2    JSR $C25A  [$A9:C25A]  ; Mother Brain third phase walking handler
$A9:C21B AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C21F D0 F3       BNE $F3    [$C214]     ;} If [Mother Brain pose] != standing: return
$A9:C221 AF 0C 78 7E LDA $7E780C[$7E:780C]  ;\
$A9:C225 D0 ED       BNE $ED    [$C214]     ;} If attacks are disabled: return
$A9:C227 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:C22A 10 E8       BPL $E8    [$C214]     ;} If [random number] & 8000h = 0: return
$A9:C22C A0 00 9F    LDY #$9F00             ; Y = $9F00 (attacking - bomb - phase 3)
$A9:C22F AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:C232 29 FF 00    AND #$00FF             ;|
$A9:C235 C9 80 00    CMP #$0080             ;} If [random number] & FFh >= 80h:
$A9:C238 90 03       BCC $03    [$C23D]     ;/
$A9:C23A A0 BB 9D    LDY #$9DBB             ; Y = $9DBB (attacking Samus - four blue rings - phase 3)

$A9:C23D 98          TYA                    ;\
$A9:C23E 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to [Y]
$A9:C241 A9 4E C2    LDA #$C24E             ;\
$A9:C244 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C24E
$A9:C247 A9 40 00    LDA #$0040             ;\
$A9:C24A 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Mother Brain body function timer = 40h
$A9:C24D 60          RTS
}


;;; $C24E: Mother Brain body function - third phase - fighting - attack cooldown ;;;
{
$A9:C24E CE B2 0F    DEC $0FB2  [$7E:0FB2]  ; Decrement Mother Brain body function timer
$A9:C251 10 C1       BPL $C1    [$C214]     ; If [Mother Brain body function timer] >= 0: return
$A9:C253 A9 09 C2    LDA #$C209             ;\
$A9:C256 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C209 (main)
$A9:C259 60          RTS
}


;;; $C25A: Mother Brain third phase walking handler ;;;
{
$A9:C25A AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C25E F0 01       BEQ $01    [$C261]     ;} If [Mother Brain pose] != standing:
$A9:C260 60          RTS                    ; Return

$A9:C261 AF 74 78 7E LDA $7E7874[$7E:7874]  ;\
$A9:C265 85 12       STA $12    [$7E:0012]  ;} Go to [Mother Brain walking function]
$A9:C267 6C 12 00    JMP ($0012)[$A9:C26A]  ;/
}


;;; $C26A: Mother Brain walking function - try to inch forward ;;;
{
$A9:C26A AF 0E 78 7E LDA $7E780E[$7E:780E]  ;\
$A9:C26E F0 31       BEQ $31    [$C2A1]     ;} If [Mother Brain walk counter] = 0: go to BRANCH_WALK_LEFT
$A9:C270 18          CLC                    ;\
$A9:C271 69 20 00    ADC #$0020             ;} Mother Brain walk counter += 20h
$A9:C274 8F 0E 78 7E STA $7E780E[$7E:780E]  ;/
$A9:C278 C9 00 01    CMP #$0100             ;\
$A9:C27B 90 23       BCC $23    [$C2A0]     ;} If [Mother Brain walk counter] < 100h: return
$A9:C27D AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C280 1A          INC A                  ;} Mother Brain target X position = [Mother Brain body X position] + 1
$A9:C281 8F 76 78 7E STA $7E7876[$7E:7876]  ;/
$A9:C285 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:C288 29 02 00    AND #$0002             ;|
$A9:C28B 18          CLC                    ;|
$A9:C28C 69 04 00    ADC #$0004             ;} Make Mother Brain walk forwards towards target X position with animation delay 4 + ([random number] & 2)
$A9:C28F A8          TAY                    ;|
$A9:C290 AF 76 78 7E LDA $7E7876[$7E:7876]  ;|
$A9:C294 20 01 C6    JSR $C601  [$A9:C601]  ;/
$A9:C297 90 07       BCC $07    [$C2A0]     ; If not reached target X position: return
$A9:C299 A9 80 00    LDA #$0080             ;\
$A9:C29C 8F 0E 78 7E STA $7E780E[$7E:780E]  ;} Mother Brain walk counter = 80h

$A9:C2A0 60          RTS                    ; Return

; BRANCH_WALK_LEFT
$A9:C2A1 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C2A4 38          SEC                    ;|
$A9:C2A5 E9 0E 00    SBC #$000E             ;} Mother Brain target X position = [Mother Brain body X position] - Eh
$A9:C2A8 8F 76 78 7E STA $7E7876[$7E:7876]  ;/
$A9:C2AC A9 B3 C2    LDA #$C2B3             ;\
$A9:C2AF 8F 74 78 7E STA $7E7874[$7E:7874]  ;} Mother Brain walking function = $C2B3
}


;;; $C2B3: Mother Brain walking function - retreat quickly ;;;
{
$A9:C2B3 AF 76 78 7E LDA $7E7876[$7E:7876]  ;\
$A9:C2B7 A0 02 00    LDY #$0002             ;} Make Mother Brain walk backwards really fast towards Mother Brain target X position
$A9:C2BA 20 47 C6    JSR $C647  [$A9:C647]  ;/
$A9:C2BD 90 12       BCC $12    [$C2D1]     ; If not reached Mother Brain target X position: return
$A9:C2BF AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C2C2 38          SEC                    ;|
$A9:C2C3 E9 0E 00    SBC #$000E             ;} Mother Brain target X position = [Mother Brain body X position] - Eh
$A9:C2C6 8F 76 78 7E STA $7E7876[$7E:7876]  ;/
$A9:C2CA A9 D2 C2    LDA #$C2D2             ;\
$A9:C2CD 8F 74 78 7E STA $7E7874[$7E:7874]  ;} Mother Brain walking function = $C2D2

$A9:C2D1 60          RTS
}


;;; $C2D2: Mother Brain walking function - retreat slowly ;;;
{
$A9:C2D2 AF 76 78 7E LDA $7E7876[$7E:7876]  ;\
$A9:C2D6 A0 04 00    LDY #$0004             ;} Make Mother Brain walk backwards fast towards target X position
$A9:C2D9 20 47 C6    JSR $C647  [$A9:C647]  ;/
$A9:C2DC B0 01       BCS $01    [$C2DF]     ; If not reached target X position:
$A9:C2DE 60          RTS                    ; Return

$A9:C2DF A9 40 00    LDA #$0040             ; Mother Brain walk counter = A0h
$A9:C2E2 4C 13 C3    JMP $C313  [$A9:C313]  ; Go to set Mother Brain walking function to try to inch forward
}


;;; $C2E5: Unused. Mother Brain walking function - crouch ;;;
{
$A9:C2E5 20 8E C6    JSR $C68E  [$A9:C68E]  ; Make Mother Brain crouch
$A9:C2E8 90 0E       BCC $0E    [$C2F8]     ; If not crouching: return
$A9:C2EA A9 F9 C2    LDA #$C2F9             ;\
$A9:C2ED 8F 74 78 7E STA $7E7874[$7E:7874]  ;} Mother Brain walking function = $C2F9
$A9:C2F1 A9 40 00    LDA #$0040             ;\
$A9:C2F4 8F 78 78 7E STA $7E7878[$7E:7878]  ;} Mother Brain crouch timer = 40h
$A9:C2F8 60          RTS
}


;;; $C2F9: Unused. Mother Brain walking function - crouching ;;;
{
$A9:C2F9 AF 78 78 7E LDA $7E7878[$7E:7878]  ;\
$A9:C2FD 3A          DEC A                  ;} Decrement Mother Brain crouch timer
$A9:C2FE 8F 78 78 7E STA $7E7878[$7E:7878]  ;/
$A9:C302 10 F4       BPL $F4    [$C2F8]     ; If [Mother Brain crouch timer] >= 0: return
$A9:C304 A9 0B C3    LDA #$C30B             ;\
$A9:C307 8F 74 78 7E STA $7E7874[$7E:7874]  ;} Mother Brain walking function = $C30B
}


;;; $C30B: Unused. Mother Brain walking function - stand up ;;;
{
$A9:C30B 20 70 C6    JSR $C670  [$A9:C670]  ; Make Mother Brain stand up
$A9:C30E 90 E8       BCC $E8    [$C2F8]     ; If not standing: return
$A9:C310 A9 C0 00    LDA #$00C0             ; Mother Brain walk counter = C0h
}


;;; $C313: Set Mother Brain walking function to try to inch forward ;;;
{
;; Parameters:
;;     A: Walk counter
$A9:C313 8F 0E 78 7E STA $7E780E[$7E:780E]  ; Mother Brain walk counter = [A]
$A9:C317 A9 6A C2    LDA #$C26A             ;\
$A9:C31A 8F 74 78 7E STA $7E7874[$7E:7874]  ;} Mother Brain walking function = $C26A
$A9:C31E AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C321 1A          INC A                  ;} Mother Brain target X position = [Mother Brain body X position] + 1 (gets ignored)
$A9:C322 8F 76 78 7E STA $7E7876[$7E:7876]  ;/
$A9:C326 60          RTS
}


;;; $C327: Mother Brain third phase neck handler ;;;
{
$A9:C327 AF 70 78 7E LDA $7E7870[$7E:7870]  ;\
$A9:C32B 85 12       STA $12    [$7E:0012]  ;} Go to [Mother Brain neck function]
$A9:C32D 6C 12 00    JMP ($0012)[$A9:C330]  ;/
}


;;; $C330: Mother Brain neck function - normal ;;;
{
$A9:C330 A9 01 00    LDA #$0001             ;\
$A9:C333 8F 64 80 7E STA $7E8064[$7E:8064]  ;} >_<;
$A9:C337 A9 80 00    LDA #$0080             ;\
$A9:C33A 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 80h
$A9:C33E A9 02 00    LDA #$0002             ;\
$A9:C341 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 2 (bob down)
$A9:C345 A9 04 00    LDA #$0004             ;\
$A9:C348 8F 66 80 7E STA $7E8066[$7E:8066]  ;} Mother Brain upper neck movement index = 4 (bob up)
$A9:C34C A9 53 C3    LDA #$C353             ;\
$A9:C34F 8F 70 78 7E STA $7E7870[$7E:7870]  ;} Mother Brain neck function = RTS

$A9:C353 60          RTS
}


;;; $C354: Mother Brain neck function - set up recoil recovery ;;;
{
$A9:C354 A9 01 00    LDA #$0001             ;\
$A9:C357 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:C35B A9 00 05    LDA #$0500             ;\
$A9:C35E 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 500h
$A9:C362 A9 06 00    LDA #$0006             ;\
$A9:C365 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 6 (lower)
$A9:C369 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 6 (lower)
$A9:C36D A9 7B C3    LDA #$C37B             ;\
$A9:C370 8F 70 78 7E STA $7E7870[$7E:7870]  ;} Mother Brain neck function = $C37B
$A9:C374 A9 10 00    LDA #$0010             ;\
$A9:C377 8F 72 78 7E STA $7E7872[$7E:7872]  ;} Mother Brain neck function timer = 10h
}


;;; $C37B: Mother Brain neck function - recoil recovery ;;;
{
$A9:C37B AF 72 78 7E LDA $7E7872[$7E:7872]  ;\
$A9:C37F 3A          DEC A                  ;} If [Mother Brain neck function timer] > 0:
$A9:C380 30 05       BMI $05    [$C387]     ;/
$A9:C382 8F 72 78 7E STA $7E7872[$7E:7872]  ; Decrement Mother Brain neck function timer
$A9:C386 60          RTS                    ; Return

$A9:C387 A9 BB 9D    LDA #$9DBB             ;\
$A9:C38A 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9DBB (attacking Samus - four blue rings - phase 3)
$A9:C38D A9 30 C3    LDA #$C330             ;\
$A9:C390 8F 70 78 7E STA $7E7870[$7E:7870]  ;} Mother Brain neck function = $C330
$A9:C394 60          RTS
}


;;; $C395: Mother Brain neck function - set up hyper beam recoil ;;;
{
; Set by shot reaction if far enough left
$A9:C395 A9 01 00    LDA #$0001             ;\
$A9:C398 8F 62 80 7E STA $7E8062[$7E:8062]  ;} Enable Mother Brain neck movement
$A9:C39C 8F 0C 78 7E STA $7E780C[$7E:780C]  ; Disable attacks
$A9:C3A0 A9 E7 9B    LDA #$9BE7             ;\
$A9:C3A3 20 47 C4    JSR $C447  [$A9:C447]  ;} Set Mother Brain brain instruction list to $9BE7 (hyper beam recoil)
$A9:C3A6 A9 32 00    LDA #$0032             ;\
$A9:C3A9 8F 40 78 7E STA $7E7840[$7E:7840]  ;} Mother Brain brain main shake timer = 50
$A9:C3AD A9 00 09    LDA #$0900             ;\
$A9:C3B0 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 900h
$A9:C3B4 A9 08 00    LDA #$0008             ;\
$A9:C3B7 8F 64 80 7E STA $7E8064[$7E:8064]  ;} Mother Brain lower neck movement index = 8 (raise)
$A9:C3BB 8F 66 80 7E STA $7E8066[$7E:8066]  ; Mother Brain upper neck movement index = 8 (raise)
$A9:C3BF A9 CD C3    LDA #$C3CD             ;\
$A9:C3C2 8F 70 78 7E STA $7E7870[$7E:7870]  ;} Mother Brain neck function = $C3CD
$A9:C3C6 A9 0B 00    LDA #$000B             ;\
$A9:C3C9 8F 72 78 7E STA $7E7872[$7E:7872]  ;} Mother Brain neck function timer = Bh
}


;;; $C3CD: Mother Brain neck function - hyper beam recoil ;;;
{
$A9:C3CD AF 72 78 7E LDA $7E7872[$7E:7872]  ;\
$A9:C3D1 3A          DEC A                  ;} If [Mother Brain neck function timer] > 0:
$A9:C3D2 30 05       BMI $05    [$C3D9]     ;/
$A9:C3D4 8F 72 78 7E STA $7E7872[$7E:7872]  ; Decrement Mother Brain neck function timer
$A9:C3D8 60          RTS                    ; Return

$A9:C3D9 A9 80 00    LDA #$0080             ;\
$A9:C3DC 8F 68 80 7E STA $7E8068[$7E:8068]  ;} Mother Brain neck angle delta = 80h
$A9:C3E0 A9 00 00    LDA #$0000             ;\
$A9:C3E3 8F 0C 78 7E STA $7E780C[$7E:780C]  ;} Enable attacks
$A9:C3E7 A9 54 C3    LDA #$C354             ;\
$A9:C3EA 8F 70 78 7E STA $7E7870[$7E:7870]  ;} Mother Brain neck function = $C354 (set up recoil recovery)
$A9:C3EE 60          RTS
}
}


;;; $C3EF: Move enemy according to enemy velocity ;;;
{
$A9:C3EF AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:C3F2 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A9:C3F5 E2 20       SEP #$20               ;|
$A9:C3F7 18          CLC                    ;|
$A9:C3F8 7D 7D 0F    ADC $0F7D,x[$7E:0FBD]  ;|
$A9:C3FB 9D 7D 0F    STA $0F7D,x[$7E:0FBD]  ;|
$A9:C3FE C2 20       REP #$20               ;|
$A9:C400 29 00 FF    AND #$FF00             ;} Enemy X position += [enemy $0FAA] / 100h
$A9:C403 EB          XBA                    ;|
$A9:C404 10 03       BPL $03    [$C409]     ;|
$A9:C406 09 00 FF    ORA #$FF00             ;|
                                            ;|
$A9:C409 7D 7A 0F    ADC $0F7A,x[$7E:0FBA]  ;|
$A9:C40C 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$A9:C40F BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$A9:C412 E2 20       SEP #$20               ;|
$A9:C414 18          CLC                    ;|
$A9:C415 7D 81 0F    ADC $0F81,x[$7E:0FC1]  ;|
$A9:C418 9D 81 0F    STA $0F81,x[$7E:0FC1]  ;|
$A9:C41B C2 20       REP #$20               ;|
$A9:C41D 29 00 FF    AND #$FF00             ;} Enemy Y position += [enemy $0FAC] / 100h
$A9:C420 EB          XBA                    ;|
$A9:C421 10 03       BPL $03    [$C426]     ;|
$A9:C423 09 00 FF    ORA #$FF00             ;|
                                            ;|
$A9:C426 7D 7E 0F    ADC $0F7E,x[$7E:0FBE]  ;|
$A9:C429 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A9:C42C 6B          RTL
}


;;; $C42D: Set Mother Brain body instruction list ;;;
{
;; Parameters:
;;     A: Instruction list pointer
$A9:C42D 8D 92 0F    STA $0F92  [$7E:0F92]  ; Mother Brain body instruction list pointer = [A]
$A9:C430 A9 01 00    LDA #$0001             ;\
$A9:C433 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Mother Brain body instruction timer = 1
$A9:C436 9C 90 0F    STZ $0F90  [$7E:0F90]  ; Mother Brain body timer = 0
$A9:C439 60          RTS
}


;;; $C43A: Set Mother Brain brain unused instruction list ;;;
{
;; Parameters:
;;     A: Instruction list pointer
$A9:C43A 8D D2 0F    STA $0FD2  [$7E:0FD2]  ; Mother Brain brain instruction list pointer = [A]
$A9:C43D A9 01 00    LDA #$0001             ;\
$A9:C440 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Mother Brain brain instruction timer = 1
$A9:C443 9C D0 0F    STZ $0FD0  [$7E:0FD0]  ; Mother Brain brain timer = 0
$A9:C446 60          RTS
}


;;; $C447: Set Mother Brain brain instruction list ;;;
{
;; Parameters:
;;     A: Instruction list pointer
$A9:C447 8F 02 80 7E STA $7E8002[$7E:8002]
$A9:C44B A9 01 00    LDA #$0001
$A9:C44E 8F 00 80 7E STA $7E8000[$7E:8000]
$A9:C452 60          RTS
}


;;; $C453: Set enemy instruction list ;;;
{
;; Parameters:
;;     A: Instruction list pointer
;;     X: Enemy index
$A9:C453 9D 92 0F    STA $0F92,x[$7E:0FD2]  ; Enemy instruction list pointer = [A]
$A9:C456 A9 01 00    LDA #$0001             ;\
$A9:C459 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A9:C45C 9E 90 0F    STZ $0F90,x[$7E:0FD0]  ; Enemy timer = 0
$A9:C45F 6B          RTL
}


;;; $C460: A = sin([$12] * pi / 80h) * ±[A] ;;;
{
$A9:C460 A8          TAY
$A9:C461 A5 12       LDA $12    [$7E:0012]
$A9:C463 80 07       BRA $07    [$C46C]
}


;;; $C465: A = cos([$12] * pi / 80h) * ±[A] ;;;
{
$A9:C465 A8          TAY
$A9:C466 A5 12       LDA $12    [$7E:0012]
$A9:C468 18          CLC
$A9:C469 69 40 00    ADC #$0040
}


;;; $C46C: A = sin([A] * pi / 80h) * ±[Y] ;;;
{
; Uses the fast (signed) multiplication registers(!)
$A9:C46C DA          PHX
$A9:C46D 0A          ASL A
$A9:C46E 29 FE 01    AND #$01FE
$A9:C471 AA          TAX
$A9:C472 BF 43 B4 A0 LDA $A0B443,x[$A0:B641]
$A9:C476 E2 20       SEP #$20
$A9:C478 8F 1B 21 00 STA $00211B
$A9:C47C EB          XBA
$A9:C47D 8F 1B 21 00 STA $00211B
$A9:C481 98          TYA
$A9:C482 8F 1C 21 00 STA $00211C
$A9:C486 C2 20       REP #$20
$A9:C488 AF 35 21 00 LDA $002135
$A9:C48C FA          PLX
$A9:C48D 6B          RTL
}


;;; $C48E: Unused. Enemy X position += [A] / 100h ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C48E E2 20       SEP #$20
$A9:C490 18          CLC
$A9:C491 7D 7D 0F    ADC $0F7D,x
$A9:C494 9D 7D 0F    STA $0F7D,x
$A9:C497 C2 20       REP #$20
$A9:C499 29 00 FF    AND #$FF00
$A9:C49C EB          XBA
$A9:C49D 10 03       BPL $03    [$C4A2]
$A9:C49F 09 00 FF    ORA #$FF00

$A9:C4A2 7D 7A 0F    ADC $0F7A,x
$A9:C4A5 9D 7A 0F    STA $0F7A,x
$A9:C4A8 60          RTS
}


;;; $C4A9: Enemy Y position += [A] / 100h ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C4A9 E2 20       SEP #$20
$A9:C4AB 18          CLC
$A9:C4AC 7D 81 0F    ADC $0F81,x[$7E:1001]
$A9:C4AF 9D 81 0F    STA $0F81,x[$7E:1001]
$A9:C4B2 C2 20       REP #$20
$A9:C4B4 29 00 FF    AND #$FF00
$A9:C4B7 EB          XBA
$A9:C4B8 10 03       BPL $03    [$C4BD]
$A9:C4BA 09 00 FF    ORA #$FF00

$A9:C4BD 7D 7E 0F    ADC $0F7E,x[$7E:0FFE]
$A9:C4C0 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A9:C4C3 60          RTS
}


;;; $C4C4: Decrement ammo due to rainbow beam ;;;
{
$A9:C4C4 AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A9:C4C7 29 03 00    AND #$0003             ;} If [number of times main enemy routine has been executed] % 4 != 0: go to BRANCH_SUPER_MISSILES
$A9:C4CA D0 25       BNE $25    [$C4F1]     ;/
$A9:C4CC AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$A9:C4CF F0 20       BEQ $20    [$C4F1]     ;} If [Samus missiles] = 0: go to BRANCH_SUPER_MISSILES
$A9:C4D1 38          SEC                    ;\
$A9:C4D2 ED 44 C5    SBC $C544  [$A9:C544]  ;} A = [Samus missiles] - 1
$A9:C4D5 C9 01 00    CMP #$0001             ;\
$A9:C4D8 10 14       BPL $14    [$C4EE]     ;} If [A] >= 1: go to BRANCH_WRITE_MISSILES
$A9:C4DA AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$A9:C4DD C9 01 00    CMP #$0001             ;} If [HUD item index] = missiles:
$A9:C4E0 D0 06       BNE $06    [$C4E8]     ;/
$A9:C4E2 A9 00 00    LDA #$0000             ;\
$A9:C4E5 8D D2 09    STA $09D2  [$7E:09D2]  ;} HUD item index = nothing

$A9:C4E8 A9 00 00    LDA #$0000             ; A = 0
$A9:C4EB 8D 04 0A    STA $0A04  [$7E:0A04]  ; Auto-cancel HUD item index = nothing

; BRANCH_WRITE_MISSILES
$A9:C4EE 8D C6 09    STA $09C6  [$7E:09C6]  ; Samus missiles = [A]

; BRANCH_SUPER_MISSILES
$A9:C4F1 AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A9:C4F4 29 03 00    AND #$0003             ;} If [number of times main enemy routine has been executed] % 4 != 0: go to BRANCH_POWER_BOMBS
$A9:C4F7 D0 25       BNE $25    [$C51E]     ;/
$A9:C4F9 AD CA 09    LDA $09CA  [$7E:09CA]  ;\
$A9:C4FC F0 20       BEQ $20    [$C51E]     ;} If [Samus super missiles] = 0: go to BRANCH_POWER_BOMBS
$A9:C4FE 38          SEC                    ;\
$A9:C4FF ED 44 C5    SBC $C544  [$A9:C544]  ;} A = [Samus super missiles] - 1
$A9:C502 C9 01 00    CMP #$0001             ;\
$A9:C505 10 14       BPL $14    [$C51B]     ;} If [A] >= 1: go to BRANCH_WRITE_SUPER_MISSILES
$A9:C507 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$A9:C50A C9 02 00    CMP #$0002             ;} If [HUD item index] = super missiles:
$A9:C50D D0 06       BNE $06    [$C515]     ;/
$A9:C50F A9 00 00    LDA #$0000             ;\
$A9:C512 8D D2 09    STA $09D2  [$7E:09D2]  ;} HUD item index = nothing

$A9:C515 A9 00 00    LDA #$0000             ; A = 0
$A9:C518 8D 04 0A    STA $0A04  [$7E:0A04]  ; Auto-cancel HUD item index = nothing

; BRANCH_WRITE_SUPER_MISSILES
$A9:C51B 8D CA 09    STA $09CA  [$7E:09CA]  ; Samus super missiles = [A]

; BRANCH_POWER_BOMBS
$A9:C51E AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$A9:C521 F0 20       BEQ $20    [$C543]     ;} If [Samus power bombs] = 0: return
$A9:C523 38          SEC                    ;\
$A9:C524 ED 44 C5    SBC $C544  [$A9:C544]  ;} A = [Samus power bombs] - 1
$A9:C527 C9 01 00    CMP #$0001             ;\
$A9:C52A 10 14       BPL $14    [$C540]     ;} If [A] >= 1: go to BRANCH_WRITE_POWER_BOMBS
$A9:C52C AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$A9:C52F C9 03 00    CMP #$0003             ;} If [HUD item index] = power bombs:
$A9:C532 D0 06       BNE $06    [$C53A]     ;/
$A9:C534 A9 00 00    LDA #$0000             ;\
$A9:C537 8D D2 09    STA $09D2  [$7E:09D2]  ;} HUD item index = nothing

$A9:C53A A9 00 00    LDA #$0000             ; A = 0
$A9:C53D 8D 04 0A    STA $0A04  [$7E:0A04]  ; Auto-cancel HUD item index = nothing

; BRANCH_WRITE_POWER_BOMBS
$A9:C540 8D CE 09    STA $09CE  [$7E:09CE]  ; Samus power bombs = [A]

$A9:C543 60          RTS

; Amount of ammo to decrement
$A9:C544             dw 0001
}


;;; $C546: Handle playing gaining/losing incremental health sound effect ;;;
{
$A9:C546 48          PHA
$A9:C547 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$A9:C54A C9 51 00    CMP #$0051             ;} If [Samus health] < 81: return
$A9:C54D 30 0F       BMI $0F    [$C55E]     ;/
$A9:C54F AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A9:C552 29 07 00    AND #$0007             ;} If [number of times main enemy routine has been executed] % 8 != 0: return
$A9:C555 D0 07       BNE $07    [$C55E]     ;/
$A9:C557 A9 2D 00    LDA #$002D             ;\
$A9:C55A 22 39 91 80 JSL $809139[$80:9139]  ;} Queue sound 2Dh, sound library 3, max queued sounds allowed = 3 (gaining/losing incremental health)

$A9:C55E 68          PLA
$A9:C55F 60          RTS
}


;;; $C560: Damage Samus due to Shitroid ;;;
{
$A9:C560 A0 FC FF    LDY #$FFFC             ; Y = -4
$A9:C563 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$A9:C566 4A          LSR A                  ;} Set carry if varia suit equipped
$A9:C567 90 03       BCC $03    [$C56C]     ; If carry set:
$A9:C569 A0 FD FF    LDY #$FFFD             ; Y = -3

$A9:C56C 98          TYA                    ;\
$A9:C56D 6D C2 09    ADC $09C2  [$7E:09C2]  ;} Samus health = [Samus health] + [Y] + carry
$A9:C570 C9 02 00    CMP #$0002             ;\
$A9:C573 10 04       BPL $04    [$C579]     ;} If [Samus health] < 2: (else carry is set)
$A9:C575 18          CLC                    ; Clear carry
$A9:C576 A9 01 00    LDA #$0001             ; Samus health = 1

$A9:C579 8D C2 09    STA $09C2  [$7E:09C2]
$A9:C57C 6B          RTL
}


;;; $C57D: Damage Samus due to rainbow beam ;;;
{
;; Returns:
;;     Carry: Set if Samus' health has reached zero, clear otherwise
$A9:C57D A0 FE FF    LDY #$FFFE             ; Y = -2
$A9:C580 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$A9:C583 4A          LSR A                  ;} Set carry if varia suit equipped
$A9:C584 90 03       BCC $03    [$C589]     ;/
$A9:C586 A0 FE FF    LDY #$FFFE

$A9:C589 98          TYA                    ;\
$A9:C58A 6D C2 09    ADC $09C2  [$7E:09C2]  ;} Samus health = [Samus health] - 2 + carry
$A9:C58D C9 01 00    CMP #$0001             ;\
$A9:C590 10 04       BPL $04    [$C596]     ;} If [Samus health] < 1: (else carry is set)
$A9:C592 18          CLC                    ; Clear carry
$A9:C593 A9 00 00    LDA #$0000             ; Samus health = 0

$A9:C596 8D C2 09    STA $09C2  [$7E:09C2]
$A9:C599 08          PHP                    ;\
$A9:C59A 20 46 C5    JSR $C546  [$A9:C546]  ;} Handle playing gaining/losing incremental health sound effect
$A9:C59D 28          PLP                    ;/
$A9:C59E 6B          RTL
}


;;; $C59F: Heal Samus due to Shitroid ;;;
{
;; Returns:
;;     Carry: Clear if Samus' health has reached max, set otherwise
$A9:C59F A9 01 00    LDA #$0001             ;\
$A9:C5A2 18          CLC                    ;|
$A9:C5A3 6D C2 09    ADC $09C2  [$7E:09C2]  ;} If [Samus health] + 1 >= [Samus max health]:
$A9:C5A6 CD C4 09    CMP $09C4  [$7E:09C4]  ;|
$A9:C5A9 30 0B       BMI $0B    [$C5B6]     ;/
$A9:C5AB AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$A9:C5AE 8D C2 09    STA $09C2  [$7E:09C2]  ;} Samus health = [Samus max health]
$A9:C5B1 20 46 C5    JSR $C546  [$A9:C546]  ; Handle playing gaining/losing incremental health sound effect
$A9:C5B4 18          CLC                    ;\
$A9:C5B5 6B          RTL                    ;} Return carry clear

$A9:C5B6 8D C2 09    STA $09C2  [$7E:09C2]  ; Samus health += 1
$A9:C5B9 20 46 C5    JSR $C546  [$A9:C546]  ; Handle playing gaining/losing incremental health sound effect
$A9:C5BC 38          SEC                    ;\
$A9:C5BD 6B          RTL                    ;} Return carry set
}


;;; $C5BE: Process sprite tiles transfers ;;;
{
;; Parameters:
;;     X: Pointer to start of a list of sprite tiles transfers, one entry processed per call
;; Returns:
;;     Carry: Set if finished list

; When not currently processing a list, $7E:8004 is 0;
; otherwise, $7E:8004 is the pointer to the next entry to process from the list initially passed in X
; (X is only used by the call initiating the list processing)

; This routine is being used to spread large VRAM transfers over multiple frames (as 1C0h or 200h byte chunks),
; but it could just as easily be called for doing small animations

$A9:C5BE AF 04 80 7E LDA $7E8004[$7E:8004]  ;\
$A9:C5C2 D0 01       BNE $01    [$C5C5]     ;|
$A9:C5C4 8A          TXA                    ;} If [sprite tiles transfer entry pointer] != 0:
                                            ;} X = [sprite tiles transfer entry pointer]
$A9:C5C5 AA          TAX                    ;/
$A9:C5C6 AC 30 03    LDY $0330  [$7E:0330]  ; Y = [VRAM write table stack pointer]
$A9:C5C9 BD 00 00    LDA $0000,x[$A9:8F8F]  ;\
$A9:C5CC F0 2D       BEQ $2D    [$C5FB]     ;} If [[X]] != 0:
$A9:C5CE 99 D0 00    STA $00D0,y[$7E:00D0]  ;\
$A9:C5D1 BD 03 00    LDA $0003,x[$A9:8F92]  ;|
$A9:C5D4 99 D3 00    STA $00D3,y[$7E:00D3]  ;|
$A9:C5D7 BD 02 00    LDA $0002,x[$A9:8F91]  ;|
$A9:C5DA 99 D2 00    STA $00D2,y[$7E:00D2]  ;|
$A9:C5DD BD 05 00    LDA $0005,x[$A9:8F94]  ;} Queue transfer of [[X]] bytes from [[X] + 2] to VRAM [[X] + 5]
$A9:C5E0 99 D5 00    STA $00D5,y[$7E:00D5]  ;|
$A9:C5E3 98          TYA                    ;|
$A9:C5E4 18          CLC                    ;|
$A9:C5E5 69 07 00    ADC #$0007             ;|
$A9:C5E8 8D 30 03    STA $0330  [$7E:0330]  ;/
$A9:C5EB 8A          TXA                    ;\
$A9:C5EC 69 07 00    ADC #$0007             ;} Sprite tiles transfer entry pointer = [X] + 7
$A9:C5EF 8F 04 80 7E STA $7E8004[$7E:8004]  ;/
$A9:C5F3 AA          TAX                    ;\
$A9:C5F4 BD 00 00    LDA $0000,x[$A9:8F96]  ;} If [[sprite tiles transfer entry pointer]] != 0: (not zero terminator)
$A9:C5F7 F0 02       BEQ $02    [$C5FB]     ;/
$A9:C5F9 18          CLC                    ;\
$A9:C5FA 60          RTS                    ;} Return carry clear

$A9:C5FB 8F 04 80 7E STA $7E8004[$7E:8004]  ; Sprite tiles transfer entry pointer = 0
$A9:C5FF 38          SEC                    ;\
$A9:C600 60          RTS                    ;} Return carry set
}


;;; $C601: Make Mother Brain walk forwards ;;;
{
;; Parameters:
;;     A: Target X position. Maximum of 7Fh
;;     Y: Animation delay
;; Returns:
;;     Carry: Set if reached target, clear otherwise
$A9:C601 CD 7A 0F    CMP $0F7A  [$7E:0F7A]  ;\
$A9:C604 30 16       BMI $16    [$C61C]     ;} If [Mother Brain body X position] > [A]: return carry set
$A9:C606 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C60A D0 0E       BNE $0E    [$C61A]     ;} If [Mother Brain's pose] != standing: return return carry clear
$A9:C60C AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C60F C9 80 00    CMP #$0080             ;} If [Mother Brain body X position] >= 80h: return carry set
$A9:C612 10 08       BPL $08    [$C61C]     ;/
$A9:C614 B9 1E C6    LDA $C61E,y[$A9:C628]  ;\
$A9:C617 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to [$C61E + [Y]]

$A9:C61A 18          CLC                    ;\
$A9:C61B 60          RTS                    ;} Return carry clear

$A9:C61C 38          SEC
$A9:C61D 60          RTS

$A9:C61E             dw C61E,
                        9730, ; 2: Walking forwards - really fast
                        976A, ; 4: Walking forwards - fast
                        97A4, ; 6: Walking forwards - medium
                        97DE, ; 8: Walking forwards - slow
                        9818  ; Ah: Walking forwards - really slow
}


;;; $C62A: Unused. Make Mother Brain walk backwards ;;;
{
;; Parameters:
;;     A: Target X position. Minimum of Fh
;;     Y: Animation delay
;; Returns:
;;     Carry: Set if reached target, clear otherwise

; Allows her to go back further than $C647 does
$A9:C62A CD 7A 0F    CMP $0F7A  [$7E:0F7A]  ;\
$A9:C62D 10 16       BPL $16    [$C645]     ;} If [Mother Brain body X position] <= [A]: return carry set
$A9:C62F AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C633 D0 0E       BNE $0E    [$C643]     ;} If [Mother Brain's pose] != standing: return return carry clear
$A9:C635 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C638 C9 10 00    CMP #$0010             ;} If [Mother Brain body X position] < 10h: return carry set
$A9:C63B 30 08       BMI $08    [$C645]     ;/
$A9:C63D B9 64 C6    LDA $C664,y            ;\
$A9:C640 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to [$C664 + [Y]]

$A9:C643 18          CLC                    ;\
$A9:C644 60          RTS                    ;} Return carry clear

$A9:C645 38          SEC
$A9:C646 60          RTS
}


;;; $C647: Make Mother Brain walk backwards ;;;
{
;; Parameters:
;;     A: Target X position. Minimum of 2Fh
;;     Y: Animation delay
;; Returns:
;;     Carry: Set if reached target, clear otherwise
$A9:C647 CD 7A 0F    CMP $0F7A  [$7E:0F7A]  ;\
$A9:C64A 10 16       BPL $16    [$C662]     ;} If [Mother Brain body X position] <= [A]: return carry set
$A9:C64C AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C650 D0 0E       BNE $0E    [$C660]     ;} If [Mother Brain's pose] != standing: return return carry clear
$A9:C652 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C655 C9 30 00    CMP #$0030             ;} If [Mother Brain body X position] < 30h: return carry set
$A9:C658 30 08       BMI $08    [$C662]     ;/
$A9:C65A B9 64 C6    LDA $C664,y[$A9:C666]  ;\
$A9:C65D 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to [$C664 + [Y]]

$A9:C660 18          CLC                    ;\
$A9:C661 60          RTS                    ;} Return carry clear

$A9:C662 38          SEC
$A9:C663 60          RTS

$A9:C664             dw C664,
                        988C, ; 2: Walking backwards - really fast
                        98C6, ; 4: Walking backwards - fast
                        9900, ; 6: Walking backwards - medium
                        9852, ; 8: Walking backwards - slow
                        993A  ; Ah: Walking backwards - really slow
}


;;; $C670: Make Mother Brain stand up ;;;
{
;; Returns:
;;     Carry: Set if standing, clear otherwise
$A9:C670 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C674 F0 16       BEQ $16    [$C68C]     ;} If [Mother Brain pose] = standing: return carry set
$A9:C676 A0 C6 99    LDY #$99C6             ; Y = $99C6 (standing up after crouching - fast)
$A9:C679 C9 03 00    CMP #$0003             ;\
$A9:C67C F0 08       BEQ $08    [$C686]     ;} If [Mother Brain pose] != crouched:
$A9:C67E C9 06 00    CMP #$0006             ;\
$A9:C681 D0 07       BNE $07    [$C68A]     ;} If [Mother Brain pose] != leaning down: return carry clear
$A9:C683 A0 E2 99    LDY #$99E2             ; Y = $99E2 (standing up after leaning down)

$A9:C686 98          TYA                    ;\
$A9:C687 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to [Y]

$A9:C68A 18          CLC                    ;\
$A9:C68B 60          RTS                    ;} Return carry clear

$A9:C68C 38          SEC
$A9:C68D 60          RTS
}


;;; $C68E: Make Mother Brain crouch ;;;
{
;; Returns:
;;     Carry: Set if crouched, clear otherwise
$A9:C68E AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C692 F0 07       BEQ $07    [$C69B]     ;} If [Mother Brain pose] != standing:
$A9:C694 C9 03 00    CMP #$0003             ;\
$A9:C697 D0 08       BNE $08    [$C6A1]     ;} If [Mother Brain pose] != crouched: return carry clear
$A9:C699 38          SEC                    ;\
$A9:C69A 60          RTS                    ;} Return carry set

$A9:C69B A9 0A 9A    LDA #$9A0A             ;\
$A9:C69E 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to $9A0A (crouch - slow)

$A9:C6A1 18          CLC
$A9:C6A2 60          RTS
}


;;; $C6A3: Make Mother Brain lean down ;;;
{
;; Returns:
;;     Carry: Set if leaning down, clear otherwise
$A9:C6A3 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C6A7 F0 07       BEQ $07    [$C6B0]     ;} If [Mother Brain pose] != standing:
$A9:C6A9 C9 06 00    CMP #$0006             ;\
$A9:C6AC D0 08       BNE $08    [$C6B6]     ;} If [Mother Brain pose] != leaning down: return carry clear
$A9:C6AE 38          SEC                    ;\
$A9:C6AF 60          RTS                    ;} Return carry set

$A9:C6B0 A9 F2 99    LDA #$99F2             ;\
$A9:C6B3 20 2D C4    JSR $C42D  [$A9:C42D]  ;} Set Mother Brain body instruction list to $99F2 (leaning down)

$A9:C6B6 18          CLC
$A9:C6B7 60          RTS
}


;;; $C6B8: Handle Mother Brain walking ;;;
{
$A9:C6B8 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:C6BC F0 01       BEQ $01    [$C6BF]     ;} If [Mother Brain's pose] != standing:
$A9:C6BE 60          RTS                    ; Return

$A9:C6BF AF 0E 78 7E LDA $7E780E[$7E:780E]  ;\
$A9:C6C3 F0 22       BEQ $22    [$C6E7]     ;} If [Mother Brain walk counter] = 0: go to BRANCH_WALK_BACKWARDS
$A9:C6C5 18          CLC                    ;\
$A9:C6C6 69 06 00    ADC #$0006             ;} Mother Brain walk counter += 6
$A9:C6C9 8F 0E 78 7E STA $7E780E[$7E:780E]  ;/
$A9:C6CD C9 00 01    CMP #$0100             ;\
$A9:C6D0 90 2A       BCC $2A    [$C6FC]     ;} If [Mother Brain walk counter] < 100h: go to BRANCH_MAYBE_WALK_FORWARDS_IF_FAR_LEFT

; BRANCH_WALK_FORWARDS
$A9:C6D2 A9 80 00    LDA #$0080             ;\
$A9:C6D5 8F 0E 78 7E STA $7E780E[$7E:780E]  ;} Mother Brain walk counter = 80h
$A9:C6D9 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C6DC C9 80 00    CMP #$0080             ;} If [Mother Brain body X position] >= 80h: return
$A9:C6DF 10 2E       BPL $2E    [$C70F]     ;/
$A9:C6E1 A9 A4 97    LDA #$97A4             ;\
$A9:C6E4 4C 2D C4    JMP $C42D  [$A9:C42D]  ;} Go to set Mother Brain body instruction list to $97A4 (walking forwards - medium)

; BRANCH_WALK_BACKWARDS
$A9:C6E7 A9 01 00    LDA #$0001             ;\
$A9:C6EA 8F 0E 78 7E STA $7E780E[$7E:780E]  ;} Mother Brain walk counter = 1
$A9:C6EE AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C6F1 C9 30 00    CMP #$0030             ;} If [Mother Brain body X position] < 30h: go to BRANCH_MAYBE_WALK_FORWARDS
$A9:C6F4 30 0E       BMI $0E    [$C704]     ;/
$A9:C6F6 A9 C6 98    LDA #$98C6             ;\
$A9:C6F9 4C 2D C4    JMP $C42D  [$A9:C42D]  ;} Go to set Mother Brain body instruction list to $98C6 (walking backwards - fast)

; BRANCH_MAYBE_WALK_FORWARDS_IF_FAR_LEFT
$A9:C6FC AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:C6FF C9 30 00    CMP #$0030             ;} If [Mother Brain body X position] >= 30h: return
$A9:C702 10 0B       BPL $0B    [$C70F]     ;/

; BRANCH_MAYBE_WALK_FORWARDS
$A9:C704 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:C707 29 FF 0F    AND #$0FFF             ;|
$A9:C70A C9 C0 0F    CMP #$0FC0             ;} If [random number] & FFFh >= FC0h: go to BRANCH_WALK_FORWARDS
$A9:C70D 10 C3       BPL $C3    [$C6D2]     ;/

$A9:C70F 60          RTS
}
}


;;; $C710..CFD3: Shitroid in cutscene ;;;
{
;;; $C710: Initialisation AI - enemy $ECBF (Shitroid in cutscene) ;;;
{
$A9:C710 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:C713 BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A9:C716 09 00 30    ORA #$3000             ;} Set enemy to process instructions and block plasma beam
$A9:C719 9D 86 0F    STA $0F86,x[$7E:1006]  ;/
$A9:C71C A9 00 0E    LDA #$0E00             ;\
$A9:C71F 9D 96 0F    STA $0F96,x[$7E:1016]  ;} Enemy palette index = E00h (palette 7)
$A9:C722 A9 A2 CF    LDA #$CFA2             ;\
$A9:C725 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = $CFA2 (initial)
$A9:C728 A9 01 00    LDA #$0001             ;\
$A9:C72B 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$A9:C72E 9F 08 78 7E STA $7E7808,x[$7E:7888]; Enable Shitroid cry sound effect
$A9:C732 9E 90 0F    STZ $0F90,x[$7E:1010]  ; Enemy timer = 0
$A9:C735 A9 0A 00    LDA #$000A             ;\
$A9:C738 9D B0 0F    STA $0FB0,x[$7E:1030]  ;} Enemy palette handler delay = Ah
$A9:C73B A9 A0 00    LDA #$00A0             ;\
$A9:C73E 9D 98 0F    STA $0F98,x[$7E:1018]  ;} Enemy VRAM tiles index = A0h
$A9:C741 A9 40 01    LDA #$0140             ;\
$A9:C744 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;} Enemy X position = 140h
$A9:C747 A9 60 00    LDA #$0060             ;\
$A9:C74A 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;} Enemy Y position = 60h
$A9:C74D 9E AA 0F    STZ $0FAA,x[$7E:102A]  ; Enemy X velocity = 0
$A9:C750 9E AC 0F    STZ $0FAC,x[$7E:102C]  ; Enemy Y velocity = 0
$A9:C753 A9 00 00    LDA #$0000             ;\
$A9:C756 9F 12 78 7E STA $7E7812,x[$7E:7892];} Disable health based palette
$A9:C75A A9 CC C7    LDA #$C7CC             ;\
$A9:C75D 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C7CC (dash onto screen)
$A9:C760 A9 F8 00    LDA #$00F8             ;\
$A9:C763 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = F8h
$A9:C766 A9 83 F6    LDA #$F683             ;\
$A9:C769 9F 1E 78 7E STA $7E781E,x[$7E:789E];} Enemy palette function = $F683 (handle Shitroid in cutscene palette - normal)
$A9:C76D A0 D4 94    LDY #$94D4             ;\
$A9:C770 A2 E2 01    LDX #$01E2             ;|
$A9:C773 A9 0F 00    LDA #$000F             ;} Go to set sprite palette 7 colours 1..Fh = [$94D4..F1]
$A9:C776 4C E4 D2    JMP $D2E4  [$A9:D2E4]  ;/
}


;;; $C779: Main AI - enemy $ECBF (Shitroid in cutscene) ;;;
{
$A9:C779 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:C77C 9E A2 0F    STZ $0FA2,x[$7E:1022]  ; Enemy shake timer = 0
$A9:C77F FC A8 0F    JSR ($0FA8,x)[$A9:C7CC]; Execute [enemy function]
$A9:C782 22 EF C3 A9 JSL $A9C3EF[$A9:C3EF]  ; Move enemy according to enemy velocity
$A9:C786 20 9C C7    JSR $C79C  [$A9:C79C]  ; Handle Shitroid flashing
$A9:C789 20 69 CE    JSR $CE69  [$A9:CE69]  ; Handle Shitroid health-based palette
$A9:C78C AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:C78F BF 1E 78 7E LDA $7E781E,x[$7E:789E];\
$A9:C793 85 12       STA $12    [$7E:0012]  ;|
$A9:C795 F4 9A C7    PEA $C79A              ;} Execute [enemy palette function]
$A9:C798 6C 12 00    JMP ($0012)[$A9:F683]  ;/

$A9:C79B 6B          RTL
}


;;; $C79C: Handle Shitroid flashing ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C79C A0 00 0E    LDY #$0E00             ; Y = E00h (palette 7)
$A9:C79F BF 0C 78 7E LDA $7E780C,x[$7E:788C];\
$A9:C7A3 F0 0D       BEQ $0D    [$C7B2]     ;} If [enemy flash timer] != 0:
$A9:C7A5 3A          DEC A                  ;\
$A9:C7A6 9F 0C 78 7E STA $7E780C,x[$7E:788C];} Decrement enemy flash timer
$A9:C7AA 29 02 00    AND #$0002             ;\
$A9:C7AD F0 03       BEQ $03    [$C7B2]     ;} If [enemy flash timer] & 2 != 0:
$A9:C7AF A0 00 00    LDY #$0000             ; Y = 0 (palette 0)

$A9:C7B2 98          TYA                    ;\
$A9:C7B3 9D 96 0F    STA $0F96,x[$7E:1016]  ;} Enemy palette index = [Y]
$A9:C7B6 60          RTS
}


;;; $C7B7: Handle playing Shitroid cry ;;;
{
$A9:C7B7 AF 28 78 7E LDA $7E7828[$7E:7828]  ;\
$A9:C7BB F0 0E       BEQ $0E    [$C7CB]     ;} If [play Shitroid cry flag] = 0: return
$A9:C7BD A9 00 00    LDA #$0000             ;\
$A9:C7C0 8F 28 78 7E STA $7E7828[$7E:7828]  ;} Disable Shitroid cry sound effect
$A9:C7C4 A9 72 00    LDA #$0072             ;\
$A9:C7C7 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 72h, sound library 2, max queued sounds allowed = 6 (Shitroid's cry)

$A9:C7CB 60          RTS
}


;;; $C7CC: Shitroid function - dash onto screen ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C7CC DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement function timer
$A9:C7CF 30 01       BMI $01    [$C7D2]     ; If [function timer] >= 0:
$A9:C7D1 60          RTS                    ; Return

$A9:C7D2 A9 00 D8    LDA #$D800             ;\
$A9:C7D5 9F 14 78 7E STA $7E7814,x[$7E:7894];} Enemy angle = -2800h
$A9:C7D9 A9 00 0A    LDA #$0A00             ;\
$A9:C7DC 9F 16 78 7E STA $7E7816,x[$7E:7896];} Enemy speed = A00h
$A9:C7E0 A9 EC C7    LDA #$C7EC             ;\
$A9:C7E3 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C7EC
$A9:C7E6 A9 0A 00    LDA #$000A             ;\
$A9:C7E9 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = Ah
}


;;; $C7EC: Shitroid function - curve towards Mother Brain brain ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C7EC A9 80 FE    LDA #$FE80             ;\
$A9:C7EF 85 12       STA $12    [$7E:0012]  ;} $12 = -180h (angle delta)
$A9:C7F1 A9 00 B0    LDA #$B000             ;\
$A9:C7F4 85 14       STA $14    [$7E:0014]  ;} $14 = -5000h (target angle)
$A9:C7F6 A9 00 0A    LDA #$0A00             ;\
$A9:C7F9 85 16       STA $16    [$7E:0016]  ;} $16 = A00h (target speed)
$A9:C7FB 20 31 CF    JSR $CF31  [$A9:CF31]  ; Update Shitroid speed and angle
$A9:C7FE DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement function timer
$A9:C801 30 01       BMI $01    [$C804]     ; If [function timer] >= 0:
$A9:C803 60          RTS                    ; Return

$A9:C804 A9 11 C8    LDA #$C811             ;\
$A9:C807 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C811
$A9:C80A A9 09 00    LDA #$0009             ;\
$A9:C80D 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = 9
$A9:C810 60          RTS
}


;;; $C811: Shitroid function - get right up in Mother Brain's face ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C811 A9 00 FA    LDA #$FA00             ;\
$A9:C814 85 12       STA $12    [$7E:0012]  ;} $12 = -500h (angle delta)
$A9:C816 A9 00 82    LDA #$8200             ;\
$A9:C819 85 14       STA $14    [$7E:0014]  ;} $14 = -7800h (target angle)
$A9:C81B A9 00 0E    LDA #$0E00             ;\
$A9:C81E 85 16       STA $16    [$7E:0016]  ;} $16 = E00h (target speed)
$A9:C820 20 31 CF    JSR $CF31  [$A9:CF31]  ; Update Shitroid speed and angle
$A9:C823 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A9:C826 85 12       STA $12    [$7E:0012]  ;|
$A9:C828 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;|
$A9:C82B 85 14       STA $14    [$7E:0014]  ;|
$A9:C82D A9 04 00    LDA #$0004             ;} Check for enemy collision with 8x8 px^2 region around Mother Brain brain position
$A9:C830 85 16       STA $16    [$7E:0016]  ;|
$A9:C832 85 18       STA $18    [$7E:0018]  ;|
$A9:C834 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:C838 90 06       BCC $06    [$C840]     ; If no collision:
$A9:C83A DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement function timer
$A9:C83D 30 01       BMI $01    [$C840]     ; If [function timer] >= 0:
$A9:C83F 60          RTS                    ; Return

$A9:C840 9D A8 0F    STA $0FA8,x[$7E:1028]  ; >_<;
$A9:C843 A9 51 C8    LDA #$C851             ;\
$A9:C846 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C851
$A9:C849 A9 01 00    LDA #$0001             ;\
$A9:C84C 22 AD E4 91 JSL $91E4AD[$91:E4AD]  ;} Put Samus into standing drained pose
$A9:C850 60          RTS
}


;;; $C851: Shitroid function - latch onto Mother Brain ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C851 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A9:C854 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain brain X position]
$A9:C856 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:C859 18          CLC                    ;|
$A9:C85A 69 E8 FF    ADC #$FFE8             ;} $14 = [Mother Brain brain Y position] - 18h
$A9:C85D 85 14       STA $14    [$7E:0014]  ;/
$A9:C85F A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:C862 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:C865 A9 08 00    LDA #$0008             ;\
$A9:C868 85 16       STA $16    [$7E:0016]  ;|
$A9:C86A 85 18       STA $18    [$7E:0018]  ;} Check for enemy collision with 16x16 px^2 region around ([$12], [$14])
$A9:C86C 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:C870 B0 06       BCS $06    [$C878]     ; If collision:
$A9:C872 A9 79 C8    LDA #$C879             ;\
$A9:C875 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C879

$A9:C878 60          RTS
}


;;; $C879: Shitroid function - set Mother Brain to stumble back ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C879 A0 02 00    LDY #$0002             ;\
$A9:C87C AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A9:C87F 3A          DEC A                  ;} Make Mother Brain walk backwards 1 pixel really fast
$A9:C880 20 47 C6    JSR $C647  [$A9:C647]  ;/
$A9:C883 A9 89 C8    LDA #$C889             ;\
$A9:C886 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C889
}


;;; $C889: Shitroid function - activate rainbow beam and Mother Brain body ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C889 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A9:C88C 18          CLC                    ;|
$A9:C88D 69 00 00    ADC #$0000             ;} $12 = [Mother Brain brain X position]
$A9:C890 85 12       STA $12    [$7E:0012]  ;/
$A9:C892 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:C895 18          CLC                    ;|
$A9:C896 69 E8 FF    ADC #$FFE8             ;} $14 = [Mother Brain brain Y position] - 18h
$A9:C899 85 14       STA $14    [$7E:0014]  ;/
$A9:C89B A9 00 02    LDA #$0200             ; A = 200h (acceleration)
$A9:C89E 20 A6 F5    JSR $F5A6  [$A9:F5A6]  ; Accelerate Shitroid towards ([$12], [$14])
$A9:C8A1 B0 01       BCS $01    [$C8A4]     ; If not reached target:
$A9:C8A3 60          RTS                    ; Return

$A9:C8A4 9E AA 0F    STZ $0FAA,x[$7E:102A]  ; Enemy X velocity = 0
$A9:C8A7 9E AC 0F    STZ $0FAC,x[$7E:102C]  ; Enemy Y velocity = 0
$A9:C8AA AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A9:C8AD 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;} Enemy X position = [Mother Brain brain X position]
$A9:C8B0 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:C8B3 18          CLC                    ;|
$A9:C8B4 69 E8 FF    ADC #$FFE8             ;} Enemy Y position = [Mother Brain brain Y position] - 18h
$A9:C8B7 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A9:C8BA A9 B8 CF    LDA #$CFB8             ;\
$A9:C8BD 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;} Set enemy instruction list to $CFB8 (draining Mother Brain)
$A9:C8C1 A9 E2 C8    LDA #$C8E2             ;\
$A9:C8C4 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C8E2
$A9:C8C7 A9 01 00    LDA #$0001             ;\
$A9:C8CA 9D B0 0F    STA $0FB0,x[$7E:1030]  ;} Enemy palette handler delay = 1
$A9:C8CD A9 38 BE    LDA #$BE38             ;\
$A9:C8D0 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $BE38 (drained by Shitroid)
$A9:C8D3 A9 40 00    LDA #$0040             ;\
$A9:C8D6 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 40h, sound library 1, max queued sounds allowed = 6 (Mother Brain's rainbow beam)
$A9:C8DA A9 01 00    LDA #$0001             ;\
$A9:C8DD 8F 2C 78 7E STA $7E782C[$7E:782C]  ;} Set Mother Brain rainbow beam sound effect as playing
$A9:C8E1 60          RTS
}


;;; $C8E2: Shitroid function - wait for Mother Brain to turn to corpse ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C8E2 BD A4 0F    LDA $0FA4,x[$7E:1024]  ;\
$A9:C8E5 29 06 00    AND #$0006             ;} Y = [enemy frame timer] & 6
$A9:C8E8 A8          TAY                    ;/
$A9:C8E9 B9 BB 93    LDA $93BB,y[$A9:93BB]  ;\
$A9:C8EC 18          CLC                    ;|
$A9:C8ED 6D BA 0F    ADC $0FBA  [$7E:0FBA]  ;} Enemy X position = [Mother Brain brain X position] + [$93BB + [Y]] (shake X offset)
$A9:C8F0 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A9:C8F3 B9 C3 93    LDA $93C3,y[$A9:93C3]  ;\
$A9:C8F6 18          CLC                    ;|
$A9:C8F7 6D BE 0F    ADC $0FBE  [$7E:0FBE]  ;|
$A9:C8FA 18          CLC                    ;} Enemy Y position = [Mother Brain brain Y position] - 18h + [$93C3 + [Y]] (shake Y offset)
$A9:C8FB 69 E8 FF    ADC #$FFE8             ;|
$A9:C8FE 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A9:C901 AF 3E 78 7E LDA $7E783E[$7E:783E]  ;\
$A9:C905 D0 01       BNE $01    [$C908]     ;} If Mother Brain not yet turned to corpse:
$A9:C907 60          RTS                    ; Return

$A9:C908 A9 15 C9    LDA #$C915             ;\
$A9:C90B 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C915
$A9:C90E A9 40 00    LDA #$0040             ;\
$A9:C911 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = 40h
$A9:C914 60          RTS
}


;;; $C915: Shitroid function - stop draining ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C915 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A9:C918 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;} Enemy X position = [Mother Brain brain X position]
$A9:C91B AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A9:C91E 18          CLC                    ;|
$A9:C91F 69 E8 FF    ADC #$FFE8             ;} Enemy Y position = [Mother Brain brain Y position] - 18h
$A9:C922 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A9:C925 DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement enemy function timer
$A9:C928 30 01       BMI $01    [$C92B]     ; If [enemy function timer] >= 0:
$A9:C92A 60          RTS                    ; Return

$A9:C92B A9 A2 CF    LDA #$CFA2             ;\
$A9:C92E 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;} Set enemy instruction list to $CFA2 (initial)
$A9:C932 A9 0A 00    LDA #$000A             ;\
$A9:C935 9D B0 0F    STA $0FB0,x[$7E:1030]  ;} Enemy palette handler delay = Ah
$A9:C938 A9 4B C9    LDA #$C94B             ;\
$A9:C93B 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C94B
$A9:C93E A9 20 00    LDA #$0020             ;\
$A9:C941 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = 20h
$A9:C944 9E AA 0F    STZ $0FAA,x[$7E:102A]  ; Enemy X velocity = 0
$A9:C947 9E AC 0F    STZ $0FAC,x[$7E:102C]  ; Enemy Y velocity = 0
$A9:C94A 60          RTS
}


;;; $C94B: Shitroid function - let go and spawn dust clouds ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C94B DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement enemy function timer
$A9:C94E 10 09       BPL $09    [$C959]     ; If [enemy function timer] < 0:
$A9:C950 20 8C C9    JSR $C98C  [$A9:C98C]  ; Spawn three dust clouds on Mother Brain brain
$A9:C953 A9 59 C9    LDA #$C959             ;\
$A9:C956 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C959
}


;;; $C959: Shitroid function - move up to ceiling ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:C959 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A9:C95C 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain brain X position]
$A9:C95E A9 00 00    LDA #$0000             ;\
$A9:C961 85 14       STA $14    [$7E:0014]  ;} $14 = 0
$A9:C963 A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:C966 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:C969 A9 04 00    LDA #$0004             ;\
$A9:C96C 85 16       STA $16    [$7E:0016]  ;|
$A9:C96E 85 18       STA $18    [$7E:0018]  ;} Check for enemy collision with 8x8 px^2 region around ([$12], [$14])
$A9:C970 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:C974 90 01       BCC $01    [$C977]     ; If no collision:
$A9:C976 60          RTS                    ; Return

$A9:C977 A9 04 00    LDA #$0004             ;\
$A9:C97A 22 AD E4 91 JSL $91E4AD[$91:E4AD]  ;} Put Samus into crouching/falling drained pose
$A9:C97E A9 C3 C9    LDA #$C9C3             ;\
$A9:C981 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $C9C3
$A9:C984 A9 24 CA    LDA #$CA24             ;\
$A9:C987 9F 1C 78 7E STA $7E781C,x[$7E:789C];} Enemy movement table pointer = $CA24
$A9:C98B 60          RTS
}


;;; $C98C: Spawn three dust clouds on Mother Brain brain ;;;
{
$A9:C98C A9 F8 FF    LDA #$FFF8             ;\
$A9:C98F 85 14       STA $14    [$7E:0014]  ;} $14 = -8
$A9:C991 A9 F0 FF    LDA #$FFF0             ; A = -10h
$A9:C994 20 AA C9    JSR $C9AA  [$A9:C9AA]  ; Spawn dust cloud at Mother Brain brain position offset by ([A], [$14])
$A9:C997 A9 F0 FF    LDA #$FFF0             ;\
$A9:C99A 85 14       STA $14    [$7E:0014]  ;} $14 = -10h
$A9:C99C A9 00 00    LDA #$0000             ; A = 0
$A9:C99F 20 AA C9    JSR $C9AA  [$A9:C9AA]  ; Spawn dust cloud at Mother Brain brain position offset by ([A], [$14])
$A9:C9A2 A9 F8 FF    LDA #$FFF8             ;\
$A9:C9A5 85 14       STA $14    [$7E:0014]  ;} $14 = -8
$A9:C9A7 A9 10 00    LDA #$0010             ; A = 10h
}


;;; $C9AA: Spawn dust cloud at Mother Brain brain position offset by ([A], [$14]) ;;;
{
$A9:C9AA 18          CLC                    ;\
$A9:C9AB 6D BA 0F    ADC $0FBA  [$7E:0FBA]  ;} $12 = [Mother Brain brain X position] + [A]
$A9:C9AE 85 12       STA $12    [$7E:0012]  ;/
$A9:C9B0 A5 14       LDA $14    [$7E:0014]  ;\
$A9:C9B2 18          CLC                    ;|
$A9:C9B3 6D BE 0F    ADC $0FBE  [$7E:0FBE]  ;} $14 += [Mother Brain brain Y position]
$A9:C9B6 85 14       STA $14    [$7E:0014]  ;/
$A9:C9B8 A9 09 00    LDA #$0009             ; A = 9 (small dust cloud)
$A9:C9BB A0 09 E5    LDY #$E509             ;\
$A9:C9BE 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:C9C2 60          RTS
}


;;; $C9C3: Shitroid function - move to Samus ;;;
{
;; Parameters:
;;     X: Enemy index

; Is this used for the sidehopper attack too?! Note the enemy index being 80h instead of C0h
$A9:C9C3 A9 00 00    LDA #$0000             ;\
$A9:C9C6 9F 08 78 7E STA $7E7808,x[$7E:7888];} Disable Shitroid cry sound effect
$A9:C9CA 1A          INC A                  ;\
$A9:C9CB 9F 12 78 7E STA $7E7812,x[$7E:7892];} Enable health based palette
$A9:C9CF AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:C9D2 29 FF 0F    AND #$0FFF             ;|
$A9:C9D5 C9 A0 0F    CMP #$0FA0             ;} If [random number] & FFFh >= FA0h:
$A9:C9D8 90 07       BCC $07    [$C9E1]     ;/
$A9:C9DA A9 52 00    LDA #$0052             ;\
$A9:C9DD 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 52h, sound library 2, max queued sounds allowed = 6 (Shitroid feels remorse)

$A9:C9E1 BF 1C 78 7E LDA $7E781C,x[$7E:789C];\
$A9:C9E5 A8          TAY                    ;} Y = [enemy movement table pointer]
$A9:C9E6 B9 00 00    LDA $0000,y[$A9:CA24]  ;\
$A9:C9E9 85 12       STA $12    [$7E:0012]  ;} $12 = [[Y]] (target X position)
$A9:C9EB B9 02 00    LDA $0002,y[$A9:CA26]  ;\
$A9:C9EE 85 14       STA $14    [$7E:0014]  ;} $14 = [[Y] + 2] (target Y position)
$A9:C9F0 B9 06 00    LDA $0006,y[$A9:CA2A]  ;\
$A9:C9F3 85 16       STA $16    [$7E:0016]  ;} $16 = [[Y] + 6] (acceleration function)
$A9:C9F5 B9 04 00    LDA $0004,y[$A9:CA28]  ;\
$A9:C9F8 5A          PHY                    ;} Y = [[Y] + 4] (acceleration divisor table index)
$A9:C9F9 A8          TAY                    ;/
$A9:C9FA F4 FF C9    PEA $C9FF              ;\
$A9:C9FD 6C 16 00    JMP ($0016)[$A9:F466]  ;} Execute [$16]

$A9:CA00 7A          PLY                    ; Y = [enemy movement table pointer]
$A9:CA01 A9 04 00    LDA #$0004             ;\
$A9:CA04 85 16       STA $16    [$7E:0016]  ;|
$A9:CA06 85 18       STA $18    [$7E:0018]  ;} Check for enemy collision with 8x8 px^2 region around ([$12], [$14])
$A9:CA08 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:CA0C B0 11       BCS $11    [$CA1F]     ; If collision:
$A9:CA0E B9 08 00    LDA $0008,y[$A9:CA2C]  ;\
$A9:CA11 30 0D       BMI $0D    [$CA20]     ;} If [[Y] + 8] & 8000h != 0: go to BRANCH_FUNCTION
$A9:CA13 BF 1C 78 7E LDA $7E781C,x[$7E:789C];\
$A9:CA17 18          CLC                    ;|
$A9:CA18 69 08 00    ADC #$0008             ;} Enemy movement table pointer += 8
$A9:CA1B 9F 1C 78 7E STA $7E781C,x[$7E:789C];/

$A9:CA1F 60          RTS                    ; Return

; BRANCH_FUNCTION
$A9:CA20 9D A8 0F    STA $0FA8,x[$7E:1028]  ; Enemy function = [[Y] + 8]
$A9:CA23 60          RTS
}


;;; $CA24: Shitroid movement table - ceiling -> Samus ;;;
{
; $F45F: Gradually accelerate towards point - $1A = 8
; $F466: Gradually accelerate towards point - $1A = 10h (faster off-screen movement)

;                        __________________ Target X position (or next enemy function if $8000+)
;                       |     _____________ Target Y position
;                       |    |     ________ Acceleration divisor table index (0 is slowest acceleration)
;                       |    |    |     ___ Acceleration function
;                       |    |    |    |
$A9:CA24             dw 00A0,0078,0000,F466,
                        0130,007A,0000,F466,
                        00C0,0040,0000,F466,
                        00C0,0070,0000,F466,
                        00E0,0080,0000,F466,
                        00CD,0090,0000,F45F,
                        00CC,00A0,0000,F45F,
                        00CB,00B0,0000,F45F,
                        CA66
}


;;; $CA66: Shitroid function - latch onto Samus ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CA66 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:CA69 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus X position]
$A9:CA6B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A9:CA6E 38          SEC                    ;|
$A9:CA6F E9 14 00    SBC #$0014             ;} $14 = [Samus Y position] - 20
$A9:CA72 85 14       STA $14    [$7E:0014]  ;/
$A9:CA74 A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:CA77 4C 51 F4    JMP $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
}


;;; $CA7A: Shitroid function - heal Samus up to full health ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CA7A A9 00 00    LDA #$0000             ;\
$A9:CA7D 9F 08 78 7E STA $7E7808,x[$7E:7888];} Disable Shitroid cry sound effect
$A9:CA81 20 B7 C7    JSR $C7B7  [$A9:C7B7]  ; Handle playing Shitroid cry
$A9:CA84 BD A4 0F    LDA $0FA4,x[$7E:1024]  ;\
$A9:CA87 29 06 00    AND #$0006             ;} Y = [enemy frame counter] & 6
$A9:CA8A A8          TAY                    ;/
$A9:CA8B B9 BB 93    LDA $93BB,y[$A9:93BB]  ;\
$A9:CA8E 18          CLC                    ;|
$A9:CA8F 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;} Enemy X position = [Samus X position] + [$93BB + [Y]] (shake X offset)
$A9:CA92 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A9:CA95 B9 C3 93    LDA $93C3,y[$A9:93C3]  ;\
$A9:CA98 18          CLC                    ;|
$A9:CA99 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;|
$A9:CA9C 38          SEC                    ;} Enemy Y position = [Samus Y position] - 20 + [$93C3 + [Y]] (shake Y offset)
$A9:CA9D E9 14 00    SBC #$0014             ;|
$A9:CAA0 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A9:CAA3 22 9F C5 A9 JSL $A9C59F[$A9:C59F]  ; Heal Samus due to Shitroid
$A9:CAA7 B0 13       BCS $13    [$CABC]     ; If reached max health:
$A9:CAA9 AD D4 09    LDA $09D4  [$7E:09D4]  ;\
$A9:CAAC 8D D6 09    STA $09D6  [$7E:09D6]  ;} Samus reserve health = [Samus max reserve health]
$A9:CAAF A9 BD CA    LDA #$CABD             ;\
$A9:CAB2 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CABD
$A9:CAB5 A9 BC CA    LDA #$CABC             ;\
$A9:CAB8 9F 1E 78 7E STA $7E781E,x[$7E:789E];} Enemy palette function = RTS

$A9:CABC 60          RTS
}


;;; $CABD: Shitroid function - idle until run out of health ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CABD 20 B7 C7    JSR $C7B7  [$A9:C7B7]  ; Handle playing Shitroid cry
$A9:CAC0 BF 0C 78 7E LDA $7E780C,x[$7E:788C];\
$A9:CAC4 F0 1E       BEQ $1E    [$CAE4]     ;} If [enemy flash timer] != 0:
$A9:CAC6 29 06 00    AND #$0006             ;\
$A9:CAC9 A8          TAY                    ;} Y = [enemy flash timer] & 6
$A9:CACA B9 BB 93    LDA $93BB,y[$A9:93BB]  ;\
$A9:CACD 0A          ASL A                  ;|
$A9:CACE 18          CLC                    ;} Enemy X position = [Samus X position] + [$93BB + [Y]] * 2 (shake X offset * 2)
$A9:CACF 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;|
$A9:CAD2 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A9:CAD5 B9 C3 93    LDA $93C3,y[$A9:93C3]  ;\
$A9:CAD8 0A          ASL A                  ;|
$A9:CAD9 18          CLC                    ;|
$A9:CADA 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;} Enemy Y position = [Samus Y position] - 20 + [$93C3 + [Y]] * 2 (shake Y offset * 2)
$A9:CADD 38          SEC                    ;|
$A9:CADE E9 14 00    SBC #$0014             ;|
$A9:CAE1 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/

$A9:CAE4 BD 8C 0F    LDA $0F8C,x[$7E:100C]  ;\
$A9:CAE7 F0 01       BEQ $01    [$CAEA]     ;} If [enemy health] != 0:
$A9:CAE9 60          RTS                    ; Return

$A9:CAEA A9 40 01    LDA #$0140             ;\
$A9:CAED 9D 8C 0F    STA $0F8C,x[$7E:100C]  ;} Enemy health = 320
$A9:CAF0 A9 13 CB    LDA #$CB13             ;\
$A9:CAF3 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CB13
$A9:CAF6 A9 0A 00    LDA #$000A             ;\
$A9:CAF9 9D B0 0F    STA $0FB0,x[$7E:1030]  ;} Enemy palette handler delay = Ah
$A9:CAFC 9E AE 0F    STZ $0FAE,x[$7E:102E]  ; Enemy palette frame timer = enemy palette handler timer = 0
$A9:CAFF A9 8F F6    LDA #$F68F             ;\
$A9:CB02 9F 1E 78 7E STA $7E781E,x[$7E:789E];} Enemy palette function = $F68F (low health)
$A9:CB06 A9 01 00    LDA #$0001             ;\
$A9:CB09 9F 08 78 7E STA $7E7808,x[$7E:7888];} Enable Shitroid cry sound effect
$A9:CB0D 3A          DEC A                  ;\
$A9:CB0E 9F 12 78 7E STA $7E7812,x[$7E:7892];} Disable health based palette
$A9:CB12 60          RTS
}


;;; $CB13: Shitroid function - release Samus ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CB13 A9 72 00    LDA #$0072             ;\
$A9:CB16 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 72h, sound library 2, max queued sounds allowed = 6 (Shitroid's cry)
$A9:CB1A A9 01 00    LDA #$0001             ;\
$A9:CB1D 8F 56 78 7E STA $7E7856[$7E:7856]  ;} $7E:7856 = 1 (never read)
$A9:CB21 A9 2D CB    LDA #$CB2D             ;\
$A9:CB24 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CB2D
$A9:CB27 A9 8E C1    LDA #$C18E             ;\
$A9:CB2A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C18E (prepare for final Shitroid attack)
}


;;; $CB2D: Shitroid function - stare down Mother Brain ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CB2D AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:CB30 38          SEC                    ;|
$A9:CB31 E9 04 00    SBC #$0004             ;} $12 = [Samus X position] - 4
$A9:CB34 85 12       STA $12    [$7E:0012]  ;/
$A9:CB36 A9 60 00    LDA #$0060             ;\
$A9:CB39 85 14       STA $14    [$7E:0014]  ;} $14 = 60h
$A9:CB3B A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:CB3E 20 66 F4    JSR $F466  [$A9:F466]  ; Gradually accelerate towards point ([$12], [$14])
$A9:CB41 A9 04 00    LDA #$0004             ;\
$A9:CB44 85 16       STA $16    [$7E:0016]  ;|
$A9:CB46 85 18       STA $18    [$7E:0018]  ;} Check for enemy collision with 8x8 px^2 region around ([$12], [$14])
$A9:CB48 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:CB4C 90 01       BCC $01    [$CB4F]     ; If no collision:
$A9:CB4E 60          RTS                    ; Return

$A9:CB4F A9 56 CB    LDA #$CB56             ;\
$A9:CB52 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CB56
$A9:CB55 60          RTS
}


;;; $CB56: Shitroid function - fly off-screen ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CB56 A9 10 01    LDA #$0110             ;\
$A9:CB59 85 12       STA $12    [$7E:0012]  ;} $12 = 110h
$A9:CB5B A9 40 00    LDA #$0040             ;\
$A9:CB5E 85 14       STA $14    [$7E:0014]  ;} $14 = 40h
$A9:CB60 A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:CB63 20 66 F4    JSR $F466  [$A9:F466]  ; Gradually accelerate towards point ([$12], [$14])
$A9:CB66 A9 04 00    LDA #$0004             ;\
$A9:CB69 85 16       STA $16    [$7E:0016]  ;|
$A9:CB6B 85 18       STA $18    [$7E:0018]  ;} Check for enemy collision with 8x8 px^2 region around ([$12], [$14])
$A9:CB6D 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:CB71 90 01       BCC $01    [$CB74]     ; If no collision:
$A9:CB73 60          RTS                    ; Return

$A9:CB74 A9 7B CB    LDA #$CB7B             ;\
$A9:CB77 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CB7B
$A9:CB7A 60          RTS
}


;;; $CB7B: Shitroid function - move to final charge start position ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CB7B A9 31 01    LDA #$0131             ;\
$A9:CB7E 85 12       STA $12    [$7E:0012]  ;} $12 = 131h
$A9:CB80 A9 A0 00    LDA #$00A0             ;\
$A9:CB83 85 14       STA $14    [$7E:0014]  ;} $14 = A0h
$A9:CB85 A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:CB88 20 66 F4    JSR $F466  [$A9:F466]  ; Gradually accelerate towards point ([$12], [$14])
$A9:CB8B A9 04 00    LDA #$0004             ;\
$A9:CB8E 85 16       STA $16    [$7E:0016]  ;|
$A9:CB90 85 18       STA $18    [$7E:0018]  ;} Check for enemy collision with 8x8 px^2 region around ([$12], [$14])
$A9:CB92 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:CB96 90 01       BCC $01    [$CB99]     ; If no collision:
$A9:CB98 60          RTS                    ; Return

$A9:CB99 A9 4F 00    LDA #$004F             ;\
$A9:CB9C 9D 8C 0F    STA $0F8C,x[$7E:100C]  ;} Enemy health = 4Fh
$A9:CB9F A9 00 00    LDA #$0000             ;\
$A9:CBA2 8F 56 78 7E STA $7E7856[$7E:7856]  ;} $7E:7856 = 0
$A9:CBA6 A9 9A C1    LDA #$C19A             ;\
$A9:CBA9 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C19A (execute final Shitroid attack)
$A9:CBAC A9 B3 CB    LDA #$CBB3             ;\
$A9:CBAF 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CBB3
$A9:CBB2 60          RTS
}


;;; $CBB3: Shitroid function - initiate final charge ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CBB3 A9 22 01    LDA #$0122             ;\
$A9:CBB6 85 12       STA $12    [$7E:0012]  ;} $12 = 122h
$A9:CBB8 A9 80 00    LDA #$0080             ;\
$A9:CBBB 85 14       STA $14    [$7E:0014]  ;} $14 = 80h
$A9:CBBD A0 0A 00    LDY #$000A             ; Y = Ah (fast acceleration)
$A9:CBC0 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:CBC3 A9 04 00    LDA #$0004             ;\
$A9:CBC6 85 16       STA $16    [$7E:0016]  ;|
$A9:CBC8 85 18       STA $18    [$7E:0018]  ;} Check for enemy collision with 8x8 px^2 region around ([$12], [$14])
$A9:CBCA 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:CBCE 90 01       BCC $01    [$CBD1]     ; If no collision:
$A9:CBD0 60          RTS                    ; Return

$A9:CBD1 A9 D8 CB    LDA #$CBD8             ;\
$A9:CBD4 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CBD8
$A9:CBD7 60          RTS
}


;;; $CBD8: Shitroid function - final charge ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CBD8 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A9:CBDB 85 12       STA $12    [$7E:0012]  ;} $12 = [Mother Brain brain X position]
$A9:CBDD A9 E0 FF    LDA #$FFE0             ;\
$A9:CBE0 18          CLC                    ;|
$A9:CBE1 6D BE 0F    ADC $0FBE  [$7E:0FBE]  ;} $14 = [Mother Brain brain Y position] - 20h
$A9:CBE4 85 14       STA $14    [$7E:0014]  ;/
$A9:CBE6 A0 0C 00    LDY #$000C             ; Y = Ch (very fast acceleration)
$A9:CBE9 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:CBEC BD 8C 0F    LDA $0F8C,x[$7E:100C]  ;\
$A9:CBEF F0 01       BEQ $01    [$CBF2]     ;} If [enemy health] != 0:
$A9:CBF1 60          RTS                    ; Return

$A9:CBF2 A9 98 CC    LDA #$CC98             ;\
$A9:CBF5 9F 1E 78 7E STA $7E781E,x[$7E:789E];} Enemy palette function = RTS
$A9:CBF9 A9 A0 10    LDA #$10A0             ;\
$A9:CBFC 9D 98 0F    STA $0F98,x[$7E:1018]  ;} Enemy VRAM tiles index = A0h, priority = 1
$A9:CBFF A9 19 00    LDA #$0019             ;\
$A9:CC02 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 19h, sound library 3, max queued sounds allowed = 6 (Shitroid dies)
$A9:CC06 22 09 F2 AD JSL $ADF209[$AD:F209]  ; Turn off lights for Shitroid death sequence
$A9:CC0A A9 CE CF    LDA #$CFCE             ;\
$A9:CC0D 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;} Set enemy instruction list to $CFCE (took fatal blow)
$A9:CC11 9E AA 0F    STZ $0FAA,x[$7E:102A]  ; Enemy X velocity = 0
$A9:CC14 9E AC 0F    STZ $0FAC,x[$7E:102C]  ; Enemy Y velocity = 0
$A9:CC17 A9 8D C1    LDA #$C18D             ;\
$A9:CC1A 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = RTS
$A9:CC1D A9 00 00    LDA #$0000             ;\
$A9:CC20 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue music stop
$A9:CC24 A9 3E CC    LDA #$CC3E             ;\
$A9:CC27 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CC3E
$A9:CC2A A9 10 00    LDA #$0010             ;\
$A9:CC2D 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = 10h
$A9:CC30 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A9:CC33 9F 20 78 7E STA $7E7820,x[$7E:78A0];} Enemy shaking origin X position = [enemy X position]
$A9:CC37 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A9:CC3A 9F 22 78 7E STA $7E7822,x[$7E:78A2];} Enemy shaking origin Y position = [enemy Y position]
}


;;; $CC3E: Shitroid function - Shitroid takes fatal blow ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CC3E 20 DB CE    JSR $CEDB  [$A9:CEDB]  ; Shake Shitroid
$A9:CC41 DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement enemy function timer
$A9:CC44 10 52       BPL $52    [$CC98]     ; If [enemy function timer] >= 0: return
$A9:CC46 BF 20 78 7E LDA $7E7820,x[$7E:78A0];\
$A9:CC4A 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;} Enemy X position = [enemy shaking origin X position]
$A9:CC4D BF 22 78 7E LDA $7E7822,x[$7E:78A2];\
$A9:CC51 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;} Enemy Y position = [enemy shaking origin Y position]
$A9:CC54 A9 60 CC    LDA #$CC60             ;\
$A9:CC57 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CC60
$A9:CC5A A9 38 00    LDA #$0038             ;\
$A9:CC5D 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = 38h
}


;;; $CC60: Shitroid function - play Samus theme ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CC60 DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement enemy function timer
$A9:CC63 10 33       BPL $33    [$CC98]     ; If [enemy function timer] >= 0: return
$A9:CC65 A9 48 FF    LDA #$FF48             ;\
$A9:CC68 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue Samus theme music data
$A9:CC6C A9 05 00    LDA #$0005             ;\
$A9:CC6F 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track
$A9:CC73 A9 7F CC    LDA #$CC7F             ;\
$A9:CC76 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CC7F
$A9:CC79 A9 0C 00    LDA #$000C             ;\
$A9:CC7C 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = Ch
}


;;; $CC7F: Shitroid function - prepare Samus for hyper beam acquisition ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CC7F DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement enemy function timer
$A9:CC82 10 14       BPL $14    [$CC98]     ; If [enemy function timer] >= 0: return
$A9:CC84 A9 19 00    LDA #$0019             ;\
$A9:CC87 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - freeze drained Samus animation
$A9:CC8B A9 30 CD    LDA #$CD30             ;\
$A9:CC8E 8F 6C 78 7E STA $7E786C[$7E:786C]  ;} Samus rainbow palette function = $CD30 (activate rainbow when enemy is low enough)
$A9:CC92 A9 99 CC    LDA #$CC99             ;\
$A9:CC95 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CC99

$A9:CC98 60          RTS
}


;;; $CC99: Shitroid function - death sequence ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CC99 20 27 CD    JSR $CD27  [$A9:CD27]  ; Handle Samus rainbow palette animation
$A9:CC9C 20 40 CE    JSR $CE40  [$A9:CE40]  ; Accelerate Shitroid downwards
$A9:CC9F 20 69 CD    JSR $CD69  [$A9:CD69]  ; Fade Shitroid to black
$A9:CCA2 B0 06       BCS $06    [$CCAA]     ; If not faded to black:
$A9:CCA4 20 B1 CD    JSR $CDB1  [$A9:CDB1]  ; Handle death explosions
$A9:CCA7 4C 24 CE    JMP $CE24  [$A9:CE24]  ; Go to handle enemy blinking

$A9:CCAA BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A9:CCAD 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A9:CCB0 9D 86 0F    STA $0F86,x[$7E:1006]  ;/
$A9:CCB3 A9 C0 CC    LDA #$CCC0             ;\
$A9:CCB6 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CCC0
$A9:CCB9 A9 80 00    LDA #$0080             ;\
$A9:CCBC 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = 80h
$A9:CCBF 60          RTS
}


;;; $CCC0: Shitroid function - unload Shitroid tiles ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CCC0 20 27 CD    JSR $CD27  [$A9:CD27]  ; Handle Samus rainbow palette animation
$A9:CCC3 DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement enemy function timer
$A9:CCC6 10 F7       BPL $F7    [$CCBF]     ; If [enemy function timer] >= 0: return
$A9:CCC8 DA          PHX                    ;\
$A9:CCC9 A2 C7 8F    LDX #$8FC7             ;|
$A9:CCCC 20 BE C5    JSR $C5BE  [$A9:C5BE]  ;} Load Mother Brain attack tiles (bomb, death beam)
$A9:CCCF FA          PLX                    ;/
$A9:CCD0 90 ED       BCC $ED    [$CCBF]     ; If not finished loading: return
$A9:CCD2 A9 DE CC    LDA #$CCDE             ;\
$A9:CCD5 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CCDE
$A9:CCD8 A9 B0 00    LDA #$00B0             ;\
$A9:CCDB 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function timer = B0h
}


;;; $CCDE: Shitroid function - let Samus rainbow some more ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CCDE DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement enemy function timer
$A9:CCE1 10 DC       BPL $DC    [$CCBF]     ; If [enemy function timer] >= 0: return
$A9:CCE3 A9 F0 CC    LDA #$CCF0             ;\
$A9:CCE6 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CCF0
$A9:CCE9 A9 00 00    LDA #$0000             ;\
$A9:CCEC 8F 2E 80 7E STA $7E802E[$7E:802E]  ;} Room lights transition counter = 0
}


;;; $CCF0: Shitroid function - finish cutscene ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CCF0 AF 2E 80 7E LDA $7E802E[$7E:802E]  ;\
$A9:CCF4 1A          INC A                  ;} Increment room lights transition counter
$A9:CCF5 8F 2E 80 7E STA $7E802E[$7E:802E]  ;/
$A9:CCF9 3A          DEC A                  ; A = [room lights transition counter] - 1
$A9:CCFA DA          PHX                    ;\
$A9:CCFB 22 4B F2 AD JSL $ADF24B[$AD:F24B]  ;} Transition lights back on for Mother Brain phase 3
$A9:CCFF FA          PLX                    ;/
$A9:CD00 90 BD       BCC $BD    [$CCBF]     ; If not finished transition: return
$A9:CD02 A9 CF C1    LDA #$C1CF             ;\
$A9:CD05 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Mother Brain body function = $C1CF (third phase - recover from cutscene)
$A9:CD08 A9 17 00    LDA #$0017             ;\
$A9:CD0B 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - disable rainbow Samus and stand her up
$A9:CD0F A9 03 00    LDA #$0003             ;\
$A9:CD12 22 AD E4 91 JSL $91E4AD[$91:E4AD]  ;} Enable hyper beam
$A9:CD16 BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A9:CD19 09 00 02    ORA #$0200             ;} Flag enemy for deletion
$A9:CD1C 9D 86 0F    STA $0F86,x[$7E:1006]  ;/
$A9:CD1F A9 00 00    LDA #$0000             ;\
$A9:CD22 8F 54 78 7E STA $7E7854[$7E:7854]  ;} Shitroid enemy index = 0
$A9:CD26 60          RTS
}


;;; $CD27: Handle Samus rainbow palette animation ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CD27 AF 6C 78 7E LDA $7E786C[$7E:786C]  ;\
$A9:CD2B 85 12       STA $12    [$7E:0012]  ;} Execute [Samus rainbow palette function]
$A9:CD2D 6C 12 00    JMP ($0012)[$A9:CD30]  ;/
}


;;; $CD30: Samus rainbow palette function - activate rainbow when enemy is low enough ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CD30 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A9:CD33 18          CLC                    ;|
$A9:CD34 69 10 00    ADC #$0010             ;} If [enemy Y position] + 10h >= [Samus Y position]:
$A9:CD37 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;|
$A9:CD3A 30 0E       BMI $0E    [$CD4A]     ;/
$A9:CD3C A9 16 00    LDA #$0016             ;\
$A9:CD3F 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - enable rainbow Samus
$A9:CD43 A9 4B CD    LDA #$CD4B             ;\
$A9:CD46 8F 6C 78 7E STA $7E786C[$7E:786C]  ;} Samus rainbow palette function = $CD4B

$A9:CD4A 60          RTS
}


;;; $CD4B: Samus rainbow palette function - gradually slow animation down ;;;
{
; This Samus rainbow palette animation counter thing is dumb
$A9:CD4B AF 7A 78 7E LDA $7E787A[$7E:787A]  ;\
$A9:CD4F 18          CLC                    ;|
$A9:CD50 69 00 03    ADC #$0300             ;} Samus rainbow palette animation counter += 300h
$A9:CD53 8F 7A 78 7E STA $7E787A[$7E:787A]  ;/
$A9:CD57 90 0F       BCC $0F    [$CD68]     ; If not overflowed: return
$A9:CD59 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;\
$A9:CD5C 1A          INC A                  ;|
$A9:CD5D C9 0A 00    CMP #$000A             ;|
$A9:CD60 30 03       BMI $03    [$CD65]     ;} Special Samus palette delay = min(Ah, [Special Samus palette delay] + 1)
$A9:CD62 A9 0A 00    LDA #$000A             ;|
                                            ;|
$A9:CD65 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;/

$A9:CD68 60          RTS
}


;;; $CD69: Fade Shitroid to black ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Carry: Set if faded to black, clear otherwise
$A9:CD69 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A9:CD6C C9 80 00    CMP #$0080             ;} If [enemy Y position] >= 80h:
$A9:CD6F 30 12       BMI $12    [$CD83]     ;/
$A9:CD71 8B          PHB
$A9:CD72 F4 00 AD    PEA $AD00              ;\
$A9:CD75 AB          PLB                    ;} DB = $AD
$A9:CD76 AB          PLB                    ;/
$A9:CD77 BF 18 78 7E LDA $7E7818,x[$7E:7898];\
$A9:CD7B 3A          DEC A                  ;} If [enemy fade to black palette timer] - 1 < 0: go to BRANCH_ADVANCE_PALETTE
$A9:CD7C 30 07       BMI $07    [$CD85]     ;/
$A9:CD7E 9F 18 78 7E STA $7E7818,x[$7E:7898]; Decrement enemy fade to black palette timer
$A9:CD82 AB          PLB

$A9:CD83 18          CLC                    ;\
$A9:CD84 60          RTS                    ;} Return carry clear

; BRANCH_ADVANCE_PALETTE
$A9:CD85 A9 08 00    LDA #$0008             ;\
$A9:CD88 9F 18 78 7E STA $7E7818,x[$7E:7898];} Enemy fade to black palette timer = 8
$A9:CD8C BF 1A 78 7E LDA $7E781A,x[$7E:789A];\
$A9:CD90 1A          INC A                  ;|
$A9:CD91 C9 07 00    CMP #$0007             ;} If [enemy fade to black palette index] >= 6:
$A9:CD94 30 03       BMI $03    [$CD99]     ;/
$A9:CD96 AB          PLB
$A9:CD97 38          SEC                    ;\
$A9:CD98 60          RTS                    ;} Return carry set

$A9:CD99 DA          PHX
$A9:CD9A 9F 1A 78 7E STA $7E781A,x[$7E:789A]; Increment enemy fade to black palette index
$A9:CD9E 0A          ASL A                  ;\
$A9:CD9F AA          TAX                    ;} Y = [$E8E2 + [enemy fade to black palette index] * 2]
$A9:CDA0 BC E2 E8    LDY $E8E2,x[$AD:E8E4]  ;/
$A9:CDA3 A2 E2 01    LDX #$01E2             ;\
$A9:CDA6 A9 0E 00    LDA #$000E             ;} Sprite palette 7 colours 1..Eh = 1Ch bytes from [Y]
$A9:CDA9 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:CDAD FA          PLX
$A9:CDAE AB          PLB
$A9:CDAF 18          CLC                    ;\
$A9:CDB0 60          RTS                    ;} Return carry clear
}


;;; $CDB1: Handle Shitroid death explosions ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CDB1 BF 10 78 7E LDA $7E7810,x[$7E:7890];\
$A9:CDB5 3A          DEC A                  ;} If [enemy death explosion timer] > 0:
$A9:CDB6 30 05       BMI $05    [$CDBD]     ;/
$A9:CDB8 9F 10 78 7E STA $7E7810,x[$7E:7890]; Decrement enemy death explosion timer
$A9:CDBC 60          RTS                    ; Return

$A9:CDBD A9 04 00    LDA #$0004             ;\
$A9:CDC0 9F 10 78 7E STA $7E7810,x[$7E:7890];} Enemy death explosion timer = 4
$A9:CDC4 BF 0E 78 7E LDA $7E780E,x[$7E:788E];\
$A9:CDC8 1A          INC A                  ;|
$A9:CDC9 C9 0A 00    CMP #$000A             ;|
$A9:CDCC 30 03       BMI $03    [$CDD1]     ;} Enemy death explosion index = ([enemy death explosion index] + 1) % Ah
$A9:CDCE A9 00 00    LDA #$0000             ;|
                                            ;|
$A9:CDD1 9F 0E 78 7E STA $7E780E,x[$7E:788E];/
$A9:CDD5 0A          ASL A                  ;\
$A9:CDD6 0A          ASL A                  ;} Y = [enemy death explosion index] * 4
$A9:CDD7 A8          TAY                    ;/
$A9:CDD8 B9 FC CD    LDA $CDFC,y[$A9:CE00]  ;\
$A9:CDDB 18          CLC                    ;|
$A9:CDDC 7D 7A 0F    ADC $0F7A,x[$7E:0FFA]  ;} $12 = [enemy X position] + [$CDFC + [Y]]
$A9:CDDF 85 12       STA $12    [$7E:0012]  ;/
$A9:CDE1 B9 FE CD    LDA $CDFE,y[$A9:CE02]  ;\
$A9:CDE4 18          CLC                    ;|
$A9:CDE5 7D 7E 0F    ADC $0F7E,x[$7E:0FFE]  ;} $14 = [enemy Y position] + [$CDFC + [Y] + 2]
$A9:CDE8 85 14       STA $14    [$7E:0014]  ;/
$A9:CDEA A9 03 00    LDA #$0003             ; A = 3 (small explosion)
$A9:CDED A0 09 E5    LDY #$E509             ;\
$A9:CDF0 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:CDF4 A9 13 00    LDA #$0013             ;\
$A9:CDF7 22 39 91 80 JSL $809139[$80:9139]  ;} Queue sound 13h, sound library 3, max queued sounds allowed = 3 (Shitroid exploding)
$A9:CDFB 60          RTS

; Explosion offset table
;                        _________ X offset
;                       |     ____ Y offset
;                       |    |
$A9:CDFC             dw FFE8,FFE8,
                        FFEC,0014,
                        0010,FFE2,
                        001E,FFFD,
                        000E,FFF3,
                        FFFE,0012,
                        FFFE,FFE0,
                        FFE1,0008,
                        FFFC,FFF6,
                        0013,0013
}


;;; $CE24: Handle enemy blinking ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CE24 BD A4 0F    LDA $0FA4,x[$7E:1024]  ;\
$A9:CE27 29 01 00    AND #$0001             ;} If [enemy frame counter] % 2 != 0:
$A9:CE2A F0 0A       BEQ $0A    [$CE36]     ;/
$A9:CE2C BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A9:CE2F 29 FF FE    AND #$FEFF             ;} Set enemy as visible
$A9:CE32 9D 86 0F    STA $0F86,x[$7E:1006]  ;/
$A9:CE35 60          RTS                    ; Return

$A9:CE36 BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A9:CE39 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A9:CE3C 9D 86 0F    STA $0F86,x[$7E:1006]  ;/
$A9:CE3F 60          RTS
}


;;; $CE40: Accelerate Shitroid downwards ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CE40 BD AA 0F    LDA $0FAA,x[$7E:102A]  ;\
$A9:CE43 10 04       BPL $04    [$CE49]     ;|
$A9:CE45 49 FF FF    EOR #$FFFF             ;|
$A9:CE48 1A          INC A                  ;|
                                            ;|
$A9:CE49 38          SEC                    ;|
$A9:CE4A E9 20 00    SBC #$0020             ;|
$A9:CE4D 10 03       BPL $03    [$CE52]     ;|
$A9:CE4F A9 00 00    LDA #$0000             ;} Enemy X velocity = max(0, |[enemy X velocity]| - 20h) * sgn([enemy X velocity])
                                            ;|
$A9:CE52 3C AA 0F    BIT $0FAA,x[$7E:102A]  ;|
$A9:CE55 10 04       BPL $04    [$CE5B]     ;|
$A9:CE57 49 FF FF    EOR #$FFFF             ;|
$A9:CE5A 1A          INC A                  ;|
                                            ;|
$A9:CE5B 9D AA 0F    STA $0FAA,x[$7E:102A]  ;/
$A9:CE5E BD AC 0F    LDA $0FAC,x[$7E:102C]  ;\
$A9:CE61 18          CLC                    ;|
$A9:CE62 69 02 00    ADC #$0002             ;} Enemy Y velocity += 2
$A9:CE65 9D AC 0F    STA $0FAC,x[$7E:102C]  ;/
$A9:CE68 60          RTS
}


;;; $CE69: Handle Shitroid health-based palette ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:CE69 BF 12 78 7E LDA $7E7812,x[$7E:7892];\
$A9:CE6D F0 08       BEQ $08    [$CE77]     ;} If health based palette enabled:
$A9:CE6F BD 8C 0F    LDA $0F8C,x[$7E:100C]  ;\
$A9:CE72 C9 00 0A    CMP #$0A00             ;} If [enemy health] < A00h: go to BRANCH_80%
$A9:CE75 30 01       BMI $01    [$CE78]     ;/

$A9:CE77 60          RTS                    ; Return

; BRANCH_80%
$A9:CE78 A0 02 00    LDY #$0002             ; Y = 2
$A9:CE7B C9 C0 08    CMP #$08C0             ;\
$A9:CE7E 10 2B       BPL $2B    [$CEAB]     ;} If [enemy health] < 8C0h:
$A9:CE80 A0 04 00    LDY #$0004             ; Y = 4
$A9:CE83 C9 80 07    CMP #$0780             ;\
$A9:CE86 10 23       BPL $23    [$CEAB]     ;} If [enemy health] < 780h:
$A9:CE88 A0 06 00    LDY #$0006             ; Y = 6
$A9:CE8B C9 40 06    CMP #$0640             ;\
$A9:CE8E 10 1B       BPL $1B    [$CEAB]     ;} If [enemy health] < 640h:
$A9:CE90 A0 08 00    LDY #$0008             ; Y = 8
$A9:CE93 C9 00 05    CMP #$0500             ;\
$A9:CE96 10 13       BPL $13    [$CEAB]     ;} If [enemy health] < 500h:
$A9:CE98 A0 0A 00    LDY #$000A             ; Y = Ah
$A9:CE9B C9 C0 03    CMP #$03C0             ;\
$A9:CE9E 10 0B       BPL $0B    [$CEAB]     ;} If [enemy health] < 3C0h:
$A9:CEA0 A0 0C 00    LDY #$000C             ; Y = Ch
$A9:CEA3 C9 80 02    CMP #$0280             ;\
$A9:CEA6 10 03       BPL $03    [$CEAB]     ;} If [enemy health] < 280h:
$A9:CEA8 A0 0E 00    LDY #$000E             ; Y = Eh

$A9:CEAB 8B          PHB
$A9:CEAC F4 00 AD    PEA $AD00              ;\
$A9:CEAF AB          PLB                    ;} DB = $AD
$A9:CEB0 AB          PLB                    ;/
$A9:CEB1 5A          PHY
$A9:CEB2 B9 E2 E7    LDA $E7E2,y[$AD:E7E4]  ;\
$A9:CEB5 A8          TAY                    ;|
$A9:CEB6 A2 E2 01    LDX #$01E2             ;} Sprite palette 7 colours 1..4 = 8 bytes from [$E7E2 + [Y]]
$A9:CEB9 A9 04 00    LDA #$0004             ;|
$A9:CEBC 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:CEC0 A2 F4 01    LDX #$01F4             ;\
$A9:CEC3 A9 05 00    LDA #$0005             ;} Sprite palette 7 colours Ah..Eh = Ah bytes from [$E7E2 + [Y]] + 8
$A9:CEC6 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:CECA 7A          PLY
$A9:CECB B9 82 E8    LDA $E882,y[$AD:E884]  ;\
$A9:CECE A8          TAY                    ;|
$A9:CECF A2 EA 01    LDX #$01EA             ;} Sprite palette 7 colours 5..9 = Ah bytes from [$E882 + [Y]]
$A9:CED2 A9 05 00    LDA #$0005             ;|
$A9:CED5 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:CED9 AB          PLB
$A9:CEDA 60          RTS
}


;;; $CEDB: Shake Shitroid ;;;
{
;; Parameters:
;;     X: Enemy index

; Decrementing velocity might be setting up initial velocity for the later calls to $CE40, pretty weird stuff...
$A9:CEDB BD AC 0F    LDA $0FAC,x[$7E:102C]  ;\
$A9:CEDE 18          CLC                    ;|
$A9:CEDF 69 FF FF    ADC #$FFFF             ;} Enemy Y velocity -= 1
$A9:CEE2 9D AC 0F    STA $0FAC,x[$7E:102C]  ;/
$A9:CEE5 BD A4 0F    LDA $0FA4,x[$7E:1024]  ;\
$A9:CEE8 29 06 00    AND #$0006             ;} Y = [enemy frame counter] & 6
$A9:CEEB A8          TAY                    ;/
$A9:CEEC B9 BB 93    LDA $93BB,y[$A9:93BB]  ;\
$A9:CEEF 18          CLC                    ;|
$A9:CEF0 7F 20 78 7E ADC $7E7820,x[$7E:78A0];} Enemy X position = [enemy shaking origin X position] + [$93BB + [Y]] (shake X offset)
$A9:CEF4 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A9:CEF7 B9 C3 93    LDA $93C3,y[$A9:93C3]  ;\
$A9:CEFA 18          CLC                    ;|
$A9:CEFB 7F 22 78 7E ADC $7E7822,x[$7E:78A2];} Enemy Y position = [enemy shaking origin Y position] + [$93C3 + [Y]] (shake Y offset)
$A9:CEFF 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A9:CF02 60          RTS
}


;;; $CF03: Enemy touch - enemy $ECBF (Shitroid in cutscene) ;;;
{
$A9:CF03 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:CF06 BD A8 0F    LDA $0FA8,x[$7E:1028]  ;\
$A9:CF09 C9 66 CA    CMP #$CA66             ;} If [enemy function] != $CA66: return
$A9:CF0C D0 22       BNE $22    [$CF30]     ;/
$A9:CF0E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:CF11 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus X position]
$A9:CF13 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A9:CF16 38          SEC                    ;|
$A9:CF17 E9 14 00    SBC #$0014             ;} $12 = [Samus Y position] - 20
$A9:CF1A 85 14       STA $14    [$7E:0014]  ;/
$A9:CF1C A9 10 00    LDA #$0010             ; A = 10h (acceleration)
$A9:CF1F 20 A6 F5    JSR $F5A6  [$A9:F5A6]  ; Accelerate Shitroid towards ([$12], [$14])
$A9:CF22 90 0C       BCC $0C    [$CF30]     ; If not reached target: return
$A9:CF24 9E AA 0F    STZ $0FAA,x[$7E:102A]  ; Enemy X velocity = 0
$A9:CF27 9E AC 0F    STZ $0FAC,x[$7E:102C]  ; Enemy Y velocity = 0
$A9:CF2A A9 7A CA    LDA #$CA7A             ;\
$A9:CF2D 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $CA7A (heal Samus up to full health)

$A9:CF30 6B          RTL
}


;;; $CF31: Update Shitroid speed and angle ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $12: Angle delta
;;     $14: Target angle
;;     $16: Target speed
$A9:CF31 A5 16       LDA $16    [$7E:0016]  ;\
$A9:CF33 DF 16 78 7E CMP $7E7816,x[$7E:7896];} If [$16] = [enemy speed]: go to BRANCH_SPEED_CALCULATED
$A9:CF37 F0 28       BEQ $28    [$CF61]     ;/
$A9:CF39 10 14       BPL $14    [$CF4F]     ; If [$16] < [enemy speed]:
$A9:CF3B BF 16 78 7E LDA $7E7816,x          ;\
$A9:CF3F 38          SEC                    ;|
$A9:CF40 E9 20 00    SBC #$0020             ;|
$A9:CF43 C5 16       CMP $16    [$7E:0016]  ;|
$A9:CF45 10 02       BPL $02    [$CF49]     ;} Enemy speed = max([enemy speed] - 20h, [$16])
$A9:CF47 A5 16       LDA $16    [$7E:0016]  ;|
                                            ;|
$A9:CF49 9F 16 78 7E STA $7E7816,x          ;/
$A9:CF4D 80 12       BRA $12    [$CF61]

$A9:CF4F BF 16 78 7E LDA $7E7816,x[$7E:7896];\ Else ([$16] > [enemy speed]):
$A9:CF53 18          CLC                    ;|
$A9:CF54 69 20 00    ADC #$0020             ;|
$A9:CF57 C5 16       CMP $16    [$7E:0016]  ;|
$A9:CF59 30 02       BMI $02    [$CF5D]     ;} Enemy speed = min([enemy speed] + 20h, [$16])
$A9:CF5B A5 16       LDA $16    [$7E:0016]  ;|
                                            ;|
$A9:CF5D 9F 16 78 7E STA $7E7816,x[$7E:7896];/

; BRANCH_SPEED_CALCULATED
$A9:CF61 A5 12       LDA $12    [$7E:0012]  ;\
$A9:CF63 30 0B       BMI $0B    [$CF70]     ;} If [$12] >= 0:
$A9:CF65 18          CLC                    ;\
$A9:CF66 7F 14 78 7E ADC $7E7814,x          ;|
$A9:CF6A C5 14       CMP $14    [$7E:0014]  ;} Enemy angle = min([enemy angle] + [$12], [$14])
$A9:CF6C 30 0D       BMI $0D    [$CF7B]     ;|
$A9:CF6E 80 09       BRA $09    [$CF79]     ;/

$A9:CF70 18          CLC                    ;\ Else ([$12] < 0):
$A9:CF71 7F 14 78 7E ADC $7E7814,x[$7E:7894];|
$A9:CF75 C5 14       CMP $14    [$7E:0014]  ;} Enemy angle = max([enemy angle] + [$12], [$14])
$A9:CF77 10 02       BPL $02    [$CF7B]     ;/

$A9:CF79 A5 14       LDA $14    [$7E:0014]

$A9:CF7B 9F 14 78 7E STA $7E7814,x[$7E:7894]
$A9:CF7F EB          XBA                    ;\
$A9:CF80 29 FF 00    AND #$00FF             ;} $12 = [enemy angle] / 100h
$A9:CF83 85 12       STA $12    [$7E:0012]  ;/
$A9:CF85 BF 16 78 7E LDA $7E7816,x[$7E:7896];\
$A9:CF89 22 6C C2 86 JSL $86C26C[$86:C26C]  ;|
$A9:CF8D AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Enemy X velocity = [enemy speed] * sin([$12] * pi / 80h)
$A9:CF90 9D AA 0F    STA $0FAA,x[$7E:102A]  ;/
$A9:CF93 BF 16 78 7E LDA $7E7816,x[$7E:7896];\
$A9:CF97 22 72 C2 86 JSL $86C272[$86:C272]  ;|
$A9:CF9B AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Enemy Y velocity = [enemy speed] * cos([$12] * pi / 80h)
$A9:CF9E 9D AC 0F    STA $0FAC,x[$7E:102C]  ;/
$A9:CFA1 60          RTS
}


;;; $CFA2: Instruction list - Shitroid - initial ;;;
{
$A9:CFA2             dx 0010,F9A8,
                        0010,FA40,
                        0010,FAD8,
                        0010,FA40,
                        CFB4        ; Go to $CFA2
}


;;; $CFB4: Instruction - go to $CFA2 ;;;
{
;; Returns:
;;     Y: Pointer to next instruction
$A9:CFB4 A0 A2 CF    LDY #$CFA2
$A9:CFB7 6B          RTL
}


;;; $CFB8: Instruction list - Shitroid - draining Mother Brain ;;;
{
$A9:CFB8             dx 0008,F9A8,
                        0008,FA40,
                        0005,FAD8,
                        0002,FA40,
                        CFCA        ; Go to $CFB8
}


;;; $CFCA: Instruction - go to $CFB8 ;;;
{
;; Returns:
;;     Y: Pointer to next instruction
$A9:CFCA A0 B8 CF    LDY #$CFB8
$A9:CFCD 6B          RTL
}


;;; $CFCE: Instruction list - Shitroid - took fatal blow ;;;
{
$A9:CFCE             dx 0080,FAD8,
                        812F        ; Sleep
}
}


;;; $CFD4..D307: Mother Brain palette handling ;;;
{
;;; $CFD4: Process Mother Brain invincibility palette ;;;
{
$A9:CFD4 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A9:CFD8 C9 04 00    CMP #$0004             ;} If [Mother Brain's form] != third phase: return
$A9:CFDB D0 1F       BNE $1F    [$CFFC]     ;/
$A9:CFDD AD DC 0F    LDA $0FDC  [$7E:0FDC]  ;\
$A9:CFE0 4A          LSR A                  ;} If [Mother Brain brain invincibility timer] < 2: return
$A9:CFE1 F0 19       BEQ $19    [$CFFC]     ;/
$A9:CFE3 B0 17       BCS $17    [$CFFC]     ; If [Mother Brain brain invincibility timer] % 2 != 0: return
$A9:CFE5 A2 1C 00    LDX #$001C             ;\
                                            ;|
$A9:CFE8 BF 02 C1 7E LDA $7EC102,x[$7E:C11E];|
$A9:CFEC 9F 22 C1 7E STA $7EC122,x[$7E:C13E];|
$A9:CFF0 9F 62 C1 7E STA $7EC162,x[$7E:C17E];} Sprite palette 1/3 / BG1/2 palette 4 colours 1..Fh = [sprite palette 0 colours 1..Fh]
$A9:CFF4 9F 82 C0 7E STA $7EC082,x[$7E:C09E];|
$A9:CFF8 CA          DEX                    ;|
$A9:CFF9 CA          DEX                    ;|
$A9:CFFA 10 EC       BPL $EC    [$CFE8]     ;/

$A9:CFFC 60          RTS
}


;;; $CFFD: Begin screen flashing ;;;
{
; Called on end of MB first phase
$A9:CFFD A9 46 D0    LDA #$D046             ;\
$A9:D000 8F 1C 78 7E STA $7E781C[$7E:781C]  ;} Room palette instruction list pointer = $D046
$A9:D004 A9 01 00    LDA #$0001             ;\
$A9:D007 8F 1E 78 7E STA $7E781E[$7E:781E]  ;} Room palette instruction timer = 1
$A9:D00B 60          RTS
}


;;; $D00C: End screen flashing ;;;
{
; DB must be $A9
$A9:D00C A9 00 00    LDA #$0000
$A9:D00F 8F 1C 78 7E STA $7E781C[$7E:781C]  ; Room palette instruction list pointer = 0
$A9:D013 8F 1E 78 7E STA $7E781E[$7E:781E]  ; Room palette instruction timer = 0
$A9:D017 A0 82 D0    LDY #$D082             ; Y = $D082
$A9:D01A 80 09       BRA $09    [$D025]     ; Go to write room palette
}


;;; $D01C: Handle room palette ;;;
{
; DB must be $A9
$A9:D01C A9 1C 78    LDA #$781C             ;\
$A9:D01F 20 92 D1    JSR $D192  [$A9:D192]  ;} Handle palette instruction list
$A9:D022 B0 01       BCS $01    [$D025]     ; If palette doesn't need updating:
$A9:D024 60          RTS                    ; Return
}


;;; $D025: Write room palette ;;;
{
;; Parameters:
;;     DB:Y: Palette address

; BG palette 3: Room background
; BG palette 5: Room level graphics
; BG palette 7: ???
$A9:D025 A2 68 00    LDX #$0068             ;\
$A9:D028 A9 0C 00    LDA #$000C             ;} BG1/2 palette 3 colours 4..Fh = 18h bytes from [DB]:[Y]
$A9:D02B 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:D02F 5A          PHY                    ;\
$A9:D030 A2 A6 00    LDX #$00A6             ;|
$A9:D033 A9 0C 00    LDA #$000C             ;} BG1/2 palette 5 colours 3..Eh = 18h bytes from [DB]:[Y] + 18h
$A9:D036 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;|
$A9:D03A 7A          PLY                    ;/
$A9:D03B A2 E6 00    LDX #$00E6             ;\
$A9:D03E A9 0C 00    LDA #$000C             ;} BG1/2 palette 7 colours 3..Eh = 18h bytes from [DB]:[Y] + 18h
$A9:D041 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:D045 60          RTS
}


;;; $D046: Room palette instruction list - first phase ended ;;;
{
$A9:D046             dx 0002,D082,
                        0002,D0B2,
                        0002,D0E2,
                        0002,D112,
                        0002,D082,
                        0002,D0B2,
                        0002,D082,
                        0002,D112,
                        0002,D0B2,
                        0002,D082,
                        0002,D112,
                        0002,D0E2,
                        0002,D082,
                        0002,D0E2,
                        9B0F,D046   ; Go to $D046
}


;;; $D082: Room palettes - first phase ended ;;;
{
; Line 0: Room background (BG1/2 palette 3 colours 4..Fh)
; Line 1: Room level graphics (BG1/2 palette 5/7 colours 3..Eh)
$A9:D082             dw 4A16,3991,2D2C,1CA7,20E5,18A4,1083,0841,0000,0000,02DF,0000,
                        0802,5294,39CE,2108,1084,0019,0012,5C00,4000,1084,197F,7FFF

$A9:D0B2             dw 4EB9,4656,3E12,31CF,35EE,2DCD,29AC,258B,1D4A,1D4A,1F3F,1D4A,
                        254C,3DEF,2D6B,18C6,0C63,0013,000E,4400,3000,0C63,1517,5EF7

$A9:D0E2             dw 575C,4F3A,4B19,46D7,46F6,46D6,42D6,3EB5,3EB5,3EB5,3F9F,3EB5,
                        3EB5,294A,1CE7,1084,0842,000D,0009,3000,2000,0842,0CD0,4210

$A9:D112             dw 5BFF,5BFF,5BFF,5BFF,5BFF,5BFF,5BFF,5BFF,5BFF,5BFF,5BFF,5BFF,
                        5BFF,14A5,1084,0842,0421,0006,0005,1800,1000,0421,0868,2108
}


;;; $D142: Unused. Set invalid room palette instruction list ;;;
{
$A9:D142 A9 8A ED    LDA #$ED8A
$A9:D145 8F 1C 78 7E STA $7E781C[$7E:781C]
$A9:D149 A9 01 00    LDA #$0001
$A9:D14C 8F 1E 78 7E STA $7E781E[$7E:781E]
$A9:D150 60          RTS
}


;;; $D151: Unused. Set invalid room palette instruction list ;;;
{
$A9:D151 A9 9C ED    LDA #$ED9C
$A9:D154 8F 1C 78 7E STA $7E781C[$7E:781C]
$A9:D158 A9 01 00    LDA #$0001
$A9:D15B 8F 1E 78 7E STA $7E781E[$7E:781E]
$A9:D15F 60          RTS
}


;;; $D160: Unused. Handle Mother Brain's palette ;;;
{
$A9:D160 A9 1C 78    LDA #$781C             ;\
$A9:D163 20 92 D1    JSR $D192  [$A9:D192]  ;} Handle palette instruction list
$A9:D166 90 29       BCC $29    [$D191]     ; If palette doesn't need updating: return
$A9:D168 5A          PHY                    ;\
$A9:D169 A2 82 00    LDX #$0082             ;|
$A9:D16C A9 0D 00    LDA #$000D             ;} BG1/2 palette 4 colours 1..Dh = 1Ah bytes from [DB]:[Y]
$A9:D16F 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;|
$A9:D173 7A          PLY                    ;/
$A9:D174 A2 22 01    LDX #$0122             ;\
$A9:D177 A9 0D 00    LDA #$000D             ;} Sprite palette 1 colours 1..Dh = 1Ah bytes from [DB]:[Y]
$A9:D17A 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:D17E A2 68 01    LDX #$0168             ;\
$A9:D181 A9 05 00    LDA #$0005             ;} Sprite palette 3 colours 4..8 = Ah bytes from [DB]:[Y] + 1Ah
$A9:D184 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:D188 A2 7C 01    LDX #$017C             ;\
$A9:D18B B9 00 00    LDA $0000,y            ;} <-- Bug. Should be writing to $7E:C17C
$A9:D18E 9D 00 00    STA $0000,x            ;/

$A9:D191 60          RTS
}


;;; $D192: Handle room palette instruction list ;;;
{
;; Parameter:
;;     A: $781C. Mother Brain's room palette instruction list pointer
;; Returns:
;;     Carry: Set if palette data should be updated
;;     Y: If carry set. Pointer to room palette data. 18h bytes for background, 18h bytes for level graphics
$A9:D192 85 00       STA $00    [$7E:0000]  ;\
$A9:D194 1A          INC A                  ;|
$A9:D195 1A          INC A                  ;|
$A9:D196 85 03       STA $03    [$7E:0003]  ;|
$A9:D198 E2 20       SEP #$20               ;} $00 = room palette instruction list pointer
$A9:D19A A9 7E       LDA #$7E               ;} $03 = room palette instruction timer
$A9:D19C 85 02       STA $02    [$7E:0002]  ;|
$A9:D19E 85 05       STA $05    [$7E:0005]  ;|
$A9:D1A0 C2 20       REP #$20               ;/
$A9:D1A2 A7 00       LDA [$00]  [$7E:781C]  ;\
$A9:D1A4 30 02       BMI $02    [$D1A8]     ;} If [room palette instruction list pointer] & 8000h = 0:
$A9:D1A6 18          CLC                    ;\
$A9:D1A7 60          RTS                    ;} Return carry clear

$A9:D1A8 AA          TAX                    ;\
$A9:D1A9 BD 00 00    LDA $0000,x[$A9:D046]  ;} If [[room palette instruction list pointer]] & 8000h = 0:
$A9:D1AC 30 0F       BMI $0F    [$D1BD]     ;/
$A9:D1AE C7 03       CMP [$03]  [$7E:781E]  ;\
$A9:D1B0 D0 22       BNE $22    [$D1D4]     ;} If [room palette instruction timer] != [[room palette instruction list pointer]]: go to BRANCH_TICK
$A9:D1B2 E8          INX                    ;\
$A9:D1B3 E8          INX                    ;|
$A9:D1B4 E8          INX                    ;} X = [room palette instruction list pointer] + 4
$A9:D1B5 E8          INX                    ;/

; LOOP
$A9:D1B6 BD 00 00    LDA $0000,x[$A9:D04A]  ;\
$A9:D1B9 F0 23       BEQ $23    [$D1DE]     ;} If [[X]] = 0: go to BRANCH_TERMINATOR
$A9:D1BB 10 0A       BPL $0A    [$D1C7]     ; If [[X]] & 8000h = 0: go to BRANCH_SPECIAL_INSTRUCTION

$A9:D1BD 85 06       STA $06    [$7E:0006]  ; $06 = [[X]]
$A9:D1BF E8          INX                    ;\
$A9:D1C0 E8          INX                    ;} X += 2
$A9:D1C1 F4 B5 D1    PEA $D1B5              ; Return to LOOP
$A9:D1C4 6C 06 00    JMP ($0006)[$A9:9B0F]  ; Go to [$06]

; BRANCH_SPECIAL_INSTRUCTION
$A9:D1C7 A9 01 00    LDA #$0001             ;\
$A9:D1CA 87 03       STA [$03]  [$7E:781E]  ;} Room palette instruction timer = 1
$A9:D1CC 8A          TXA                    ;\
$A9:D1CD 87 00       STA [$00]  [$7E:781C]  ;} Room palette instruction list pointer = [X]
$A9:D1CF BC 02 00    LDY $0002,x[$A9:D04C]  ; Y = [[X] + 2]
$A9:D1D2 38          SEC                    ;\
$A9:D1D3 60          RTS                    ;} Return carry set

; BRANCH_TICK
$A9:D1D4 A7 03       LDA [$03]  [$7E:781E]  ;\
$A9:D1D6 1A          INC A                  ;} Increment room palette instruction timer
$A9:D1D7 87 03       STA [$03]  [$7E:781E]  ;/
$A9:D1D9 BC 02 00    LDY $0002,x[$A9:D048]  ; Y = [[room palette instruction list pointer] + 2]
$A9:D1DC 38          SEC                    ;\
$A9:D1DD 60          RTS                    ;} Return carry set

; BRANCH_TERMINATOR
$A9:D1DE 87 00       STA [$00]              ; Room palette instruction list pointer = 0
$A9:D1E0 87 03       STA [$03]              ; Room palette instruction timer = 0
$A9:D1E2 18          CLC                    ;\
$A9:D1E3 60          RTS                    ;} Return carry clear
}


;;; $D1E4: Handle Mother Brain's palette ;;;
{
$A9:D1E4 AF 60 78 7E LDA $7E7860[$7E:7860]  ;\
$A9:D1E8 F0 03       BEQ $03    [$D1ED]     ;} If Mother Brain brain palette handling enabled:
$A9:D1EA 20 06 D2    JSR $D206  [$A9:D206]  ; Handle Mother Brain brain palette

$A9:D1ED AF 62 78 7E LDA $7E7862[$7E:7862]  ;\
$A9:D1F1 F0 04       BEQ $04    [$D1F7]     ;} If Mother Brain health-based palette handling enabled:
$A9:D1F3 22 D5 E3 AD JSL $ADE3D5[$AD:E3D5]  ; Mother Brain health-based palette handling

$A9:D1F7 60          RTS
}


;;; $D1F8: Set up Mother Brain brain normal palette ;;;
{
; Mother Brain brain palette timer reset value = Ah
; Mother Brain brain palette set = 0
$A9:D1F8 A9 0A 00    LDA #$000A
$A9:D1FB 8D B0 0F    STA $0FB0  [$7E:0FB0]
$A9:D1FE 60          RTS
}


;;; $D1FF: Set up Mother Brain brain palette for charging her laser ;;;
{
; Mother Brain brain palette timer reset value = 2
; Mother Brain brain palette set = 2
$A9:D1FF A9 02 02    LDA #$0202
$A9:D202 8D B0 0F    STA $0FB0  [$7E:0FB0]
$A9:D205 60          RTS
}


;;; $D206: Handle Mother Brain brain palette ;;;
{
$A9:D206 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A9:D20A 3A          DEC A                  ;} If [Mother Brain's form] = fake death: return
$A9:D20B F0 0B       BEQ $0B    [$D218]     ;/
$A9:D20D E2 20       SEP #$20
$A9:D20F AD AF 0F    LDA $0FAF  [$7E:0FAF]  ;\
$A9:D212 F0 07       BEQ $07    [$D21B]     ;} If [Mother Brain brain palette timer] = 0: go to BRANCH_ZERO
$A9:D214 3A          DEC A                  ;\
$A9:D215 8D AF 0F    STA $0FAF  [$7E:0FAF]  ;} Decrement Mother Brain brain palette timer

$A9:D218 C2 20       REP #$20
$A9:D21A 60          RTS                    ; Return

; BRANCH_ZERO
$A9:D21B EB          XBA                    ; >_<;
$A9:D21C AD B1 0F    LDA $0FB1  [$7E:0FB1]  ;\
$A9:D21F AA          TAX                    ;|
$A9:D220 BC 60 D2    LDY $D260,x[$A9:D260]  ;} $12 = [$D260 + [Mother Brain brain palette set]]
$A9:D223 84 12       STY $12    [$7E:0012]  ;/
$A9:D225 AD B0 0F    LDA $0FB0  [$7E:0FB0]  ;\
$A9:D228 8D AF 0F    STA $0FAF  [$7E:0FAF]  ;} Mother Brain brain palette timer = [Mother Brain brain palette timer reset value]
$A9:D22B AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A9:D22E D0 08       BNE $08    [$D238]     ;} If [Mother Brain brain palette counter] = 0:
$A9:D230 AC E8 0F    LDY $0FE8  [$7E:0FE8]  ;\
$A9:D233 C0 A2 87    CPY #$87A2             ;} If [Mother Brain brain function] != $87A2 (if neck is not being drawn): return
$A9:D236 D0 E0       BNE $E0    [$D218]     ;/

$A9:D238 1A          INC A                  ;\
$A9:D239 29 07       AND #$07               ;} Mother Brain brain palette counter = ([Mother Brain brain palette counter] + 1) % 8
$A9:D23B 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;/
$A9:D23E C2 20       REP #$20
$A9:D240 29 FF 00    AND #$00FF             ;\
$A9:D243 0A          ASL A                  ;|
$A9:D244 0A          ASL A                  ;|
$A9:D245 0A          ASL A                  ;} Y = [$12] + [Mother Brain brain palette counter] * 8
$A9:D246 65 12       ADC $12    [$7E:0012]  ;|
$A9:D248 A8          TAY                    ;/
$A9:D249 A2 22 01    LDX #$0122             ; X = 122h (sprite palette 1 colour 1)
$A9:D24C AF 1A 78 7E LDA $7E781A[$7E:781A]  ;\
$A9:D250 C9 00 02    CMP #$0200             ;} If [Mother Brain brain palette index] != 200h:
$A9:D253 F0 03       BEQ $03    [$D258]     ;/
$A9:D255 A2 E2 01    LDX #$01E2             ; X = 1E2h (sprite palette 7 colour 1)

$A9:D258 A9 03 00    LDA #$0003             ;\
$A9:D25B 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;} Write 3 colours from [Y] to colour index [X]
$A9:D25F 60          RTS

$A9:D260             dw D264, D2A4

; Normal palette set
$A9:D264             dw 2EDF,019B,008E, 0006,
                        269F,0159,004C, 0004,
                        1E5D,0117,000A, 0002,
                        161B,00D5,0008, 0000,
                        161B,00D5,0008, 0000,
                        1E5D,0117,000A, 0002,
                        269F,0159,004C, 0004,
                        2EDF,019B,008E, 0006

; Charging her laser palette set
$A9:D2A4             dw 269F,0159,004C, 0004,
                        229F,0179,008E, 0067,
                        1A9F,01BA,00F1, 00CB,
                        16BF,01FB,0153, 012E,
                        16BF,01FB,0153, 012E,
                        1A9F,01BA,00F1, 00CB,
                        229F,0179,008E, 0067,
                        269F,0159,004C, 0004
}


;;; $D2E4: Write [A] colours from [DB]:[Y] to colour index [X] ;;;
{
$A9:D2E4 85 12       STA $12    [$7E:0012]

$A9:D2E6 B9 00 00    LDA $0000,y[$A6:F881]
$A9:D2E9 9F 00 C0 7E STA $7EC000,x[$7E:C052]
$A9:D2ED E8          INX
$A9:D2EE E8          INX
$A9:D2EF C8          INY
$A9:D2F0 C8          INY
$A9:D2F1 C6 12       DEC $12    [$7E:0012]
$A9:D2F3 D0 F1       BNE $F1    [$D2E6]
$A9:D2F5 6B          RTL
}


;;; $D2F6: Write [A] colours from [DB]:[Y] to target colour index [X] ;;;
{
$A9:D2F6 85 12       STA $12    [$7E:0012]

$A9:D2F8 B9 00 00    LDA $0000,y[$A6:F4EE]
$A9:D2FB 9F 00 C2 7E STA $7EC200,x[$7E:C3E2]
$A9:D2FF E8          INX
$A9:D300 E8          INX
$A9:D301 C8          INY
$A9:D302 C8          INY
$A9:D303 C6 12       DEC $12    [$7E:0012]
$A9:D305 D0 F1       BNE $F1    [$D2F8]
$A9:D307 6B          RTL
}
}


;;; $D308..EEBE: Dead monsters / corpse handling ;;;
{
;;; $D308..D7B5: Torizo corpse ;;;
{
;;; $D308: Initialisation AI - enemy $ED3F (torizo corpse) ;;;
{
$A9:D308 8B          PHB                    ;\
$A9:D309 F4 7E 7E    PEA $7E7E              ;|
$A9:D30C AB          PLB                    ;|
$A9:D30D AB          PLB                    ;|
$A9:D30E A9 00 00    LDA #$0000             ;|
$A9:D311 A2 FE 0F    LDX #$0FFE             ;|
                                            ;} $7E:2000..2FFF = 0 (corpse rotting graphics)
$A9:D314 9D 00 20    STA $2000,x[$7E:2FFE]  ;|
$A9:D317 CA          DEX                    ;|
$A9:D318 CA          DEX                    ;|
$A9:D319 10 F9       BPL $F9    [$D314]     ;|
$A9:D31B AB          PLB                    ;/
$A9:D31C A9 AD D3    LDA #$D3AD             ;\
$A9:D31F 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Torizo corpse function = $D3AD (wait for Samus collision)
$A9:D322 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:D325 09 00 A0    ORA #$A000             ;} Set torizo corpse to process instructions and have solid hitbox
$A9:D328 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A9:D32B A9 DC D6    LDA #$D6DC             ;\
$A9:D32E 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Torizo corpse instruction list pointer = $D6DC (torizo corpse)
$A9:D331 A9 01 00    LDA #$0001             ;\
$A9:D334 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Torizo corpse instruction list timer = 1
$A9:D337 9C 90 0F    STZ $0F90  [$7E:0F90]  ; Torizo corpse timer = 0
$A9:D33A A9 00 02    LDA #$0200             ;\
$A9:D33D 8D 96 0F    STA $0F96  [$7E:0F96]  ;} Torizo corpse palette index = 200h (palette 1)
$A9:D340 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ; Torizo corpse X velocity = 0
$A9:D343 A9 08 00    LDA #$0008             ;\
$A9:D346 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Torizo corpse Y velocity = 8
$A9:D349 A9 00 00    LDA #$0000             ;\
$A9:D34C 8F 08 78 7E STA $7E7808[$7E:7808]  ;} Pre-rot delay timer = 0
$A9:D350 A9 0F 00    LDA #$000F             ;\
$A9:D353 8F 04 78 7E STA $7E7804[$7E:7804]  ;} Sand heap Y pixel row to copy = Fh
$A9:D357 A9 00 00    LDA #$0000             ;\
$A9:D35A 8F 06 78 7E STA $7E7806[$7E:7806]  ;} Sand heap formation timer = 0
$A9:D35E A2 00 00    LDX #$0000             ; X = (torizo corpse enemy index)
$A9:D361 A0 58 DD    LDY #$DD58             ; Y = $DD58
$A9:D364 20 5F DC    JSR $DC5F  [$A9:DC5F]  ; Initialise torizo corpse corpse rotting
$A9:D367 6B          RTL
}


;;; $D368: Main AI - enemy $ED3F (torizo corpse) ;;;
{
$A9:D368 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:D36B 29 00 04    AND #$0400             ;} If torizo corpse is tangible:
$A9:D36E D0 14       BNE $14    [$D384]     ;/
$A9:D370 20 43 D4    JSR $D443  [$A9:D443]  ; Torizo corpse / Samus collision detection
$A9:D373 90 0F       BCC $0F    [$D384]     ; If collision:
$A9:D375 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:D378 09 00 04    ORA #$0400             ;} Set torizo corpse as intangible
$A9:D37B 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A9:D37E A9 E6 D3    LDA #$D3E6             ;\
$A9:D381 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Torizo corpse function = $D3E6 (rotting)

$A9:D384 A9 00 A9    LDA #$A900             ;\
$A9:D387 8D 8D 17    STA $178D  [$7E:178D]  ;|
$A9:D38A A9 9A D3    LDA #$D39A             ;} Enemy graphics drawn hook = $A9:D39A
$A9:D38D 8D 8C 17    STA $178C  [$7E:178C]  ;/
$A9:D390 A2 00 00    LDX #$0000             ;\
$A9:D393 FC A8 0F    JSR ($0FA8,x)[$A9:D3AD];} Execute [torizo corpse function]
$A9:D396 20 CF D4    JSR $D4CF  [$A9:D4CF]  ; Process torizo corpse corpse rotting VRAM transfers
$A9:D399 6B          RTL
}


;;; $D39A: Enemy graphics drawn hook - torizo corpse ;;;
{
$A9:D39A 64 16       STZ $16    [$7E:0016]  ;\
$A9:D39C A9 28 01    LDA #$0128             ;|
$A9:D39F 85 12       STA $12    [$7E:0012]  ;|
$A9:D3A1 A9 BB 00    LDA #$00BB             ;} Add spritemap $D761 (sand heap) to OAM at room position (128h, BBh) with palette 0
$A9:D3A4 85 14       STA $14    [$7E:0014]  ;|
$A9:D3A6 A0 61 D7    LDY #$D761             ;|
$A9:D3A9 20 EE 93    JSR $93EE  [$A9:93EE]  ;/
$A9:D3AC 6B          RTL
}


;;; $D3AD: Torizo corpse function - wait for Samus collision ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:D3AD EC 2C 18    CPX $182C  [$7E:182C]  ;\
$A9:D3B0 F0 0F       BEQ $0F    [$D3C1]     ;|
$A9:D3B2 EC 2E 18    CPX $182E  [$7E:182E]  ;|
$A9:D3B5 F0 0A       BEQ $0A    [$D3C1]     ;|
$A9:D3B7 EC 30 18    CPX $1830  [$7E:1830]  ;} If Samus didn't collided with torizo corpse (enemy index 0): return
$A9:D3BA F0 05       BEQ $05    [$D3C1]     ;|
$A9:D3BC EC 32 18    CPX $1832  [$7E:1832]  ;|
$A9:D3BF D0 06       BNE $06    [$D3C7]     ;/

$A9:D3C1 A9 C8 D3    LDA #$D3C8             ;\
$A9:D3C4 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Torizo corpse function = $D3C8 (pre-rot delay)

$A9:D3C7 60          RTS
}


;;; $D3C8: Torizo corpse function - pre-rot delay ;;;
{
$A9:D3C8 AF 08 78 7E LDA $7E7808[$7E:7808]  ;\
$A9:D3CC 1A          INC A                  ;} Increment pre-rot delay timer
$A9:D3CD 8F 08 78 7E STA $7E7808[$7E:7808]  ;/
$A9:D3D1 C9 10 00    CMP #$0010             ;\
$A9:D3D4 B0 01       BCS $01    [$D3D7]     ;} If [pre-rot delay timer] < 10h:
$A9:D3D6 60          RTS                    ; Return

$A9:D3D7 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:D3DA 09 00 04    ORA #$0400             ;} Set enemy as intangible
$A9:D3DD 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A9:D3E0 A9 E6 D3    LDA #$D3E6             ;\
$A9:D3E3 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Torizo corpse function = $D3E6 (rotting)
}


;;; $D3E6: Torizo corpse function - rotting ;;;
{
$A9:D3E6 AF 06 78 7E LDA $7E7806[$7E:7806]  ;\
$A9:D3EA 1A          INC A                  ;} Increment sand heap formation timer
$A9:D3EB 8F 06 78 7E STA $7E7806[$7E:7806]  ;/
$A9:D3EF C9 0F 00    CMP #$000F             ;\
$A9:D3F2 90 19       BCC $19    [$D40D]     ;} If [sand heap formation timer] >= Fh:
$A9:D3F4 A9 00 00    LDA #$0000             ;\
$A9:D3F7 8F 06 78 7E STA $7E7806[$7E:7806]  ;} Sand heap formation timer = 0
$A9:D3FB AF 04 78 7E LDA $7E7804[$7E:7804]  ; A = [sand heap Y pixel row to copy]
$A9:D3FF F0 0C       BEQ $0C    [$D40D]     ; If [sand heap Y pixel row to copy] != 0:
$A9:D401 20 EA D5    JSR $D5EA  [$A9:D5EA]  ; Copy line of sand heap tile data
$A9:D404 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A9:D408 3A          DEC A                  ;} Decrement sand heap Y pixel row to copy
$A9:D409 8F 04 78 7E STA $7E7804[$7E:7804]  ;/

$A9:D40D AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A9:D410 18          CLC                    ;|
$A9:D411 69 01 00    ADC #$0001             ;} Torizo corpse Y velocity += 1
$A9:D414 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;/
$A9:D417 A2 00 00    LDX #$0000
$A9:D41A 22 EF C3 A9 JSL $A9C3EF[$A9:C3EF]  ; Move torizo corpse according to torizo corpse velocity
$A9:D41E 20 12 DB    JSR $DB12  [$A9:DB12]  ; Process torizo corpse corpse rotting
$A9:D421 B0 06       BCS $06    [$D429]     ; If finished rotting:
$A9:D423 A9 C7 D3    LDA #$D3C7             ;\
$A9:D426 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Torizo corpse function = RTS

$A9:D429 60          RTS
}


;;; $D42A: Power bomb reaction - enemy $ED3F (torizo corpse) ;;;
{
$A9:D42A AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:D42D 29 00 04    AND #$0400             ;} If torizo corpse is intangible:
$A9:D430 F0 01       BEQ $01    [$D433]     ;/
$A9:D432 6B          RTL                    ; Return
}


;;; $D433: Enemy touch / enemy shot - enemy $ED3F (torizo corpse) ;;;
{
$A9:D433 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:D436 09 00 04    ORA #$0400             ;} Set torizo corpse as intangible
$A9:D439 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A9:D43C A9 E6 D3    LDA #$D3E6             ;\
$A9:D43F 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Torizo corpse function = $D3E6 (rotting)
$A9:D442 6B          RTL
}


;;; $D443: Torizo corpse / Samus collision detection ;;;
{
;; Returns:
;;     Carry: Set if collision, otherwise clear
$A9:D443 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A9:D446 85 12       STA $12    [$7E:0012]  ;} $12 = [torizo corpse X position]
$A9:D448 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A9:D44B 85 14       STA $14    [$7E:0014]  ;} $14 = [torizo corpse Y position]
$A9:D44D A2 7C D7    LDX #$D77C             ; X = $D77C (torizo corpse hitbox definition)
$A9:D450 BD 00 00    LDA $0000,x[$A9:D77C]  ;\
$A9:D453 F0 5F       BEQ $5F    [$D4B4]     ;} If 7 = 0: return carry clear >_<;
$A9:D455 85 16       STA $16    [$7E:0016]  ; $16 = 7 (number of hitbox entries)
$A9:D457 E8          INX                    ;\
$A9:D458 E8          INX                    ;} X += 2 (first hitbox entry)

; LOOP
$A9:D459 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A9:D45C 38          SEC                    ;|
$A9:D45D E5 14       SBC $14    [$7E:0014]  ;} If [Samus Y position] < [torizo corpse Y position]:
$A9:D45F 10 0B       BPL $0B    [$D46C]     ;/
$A9:D461 49 FF FF    EOR #$FFFF             ;\
$A9:D464 1A          INC A                  ;} $18 = [torizo corpse Y position] - [Samus Y position]
$A9:D465 85 18       STA $18    [$7E:0018]  ;/
$A9:D467 BD 02 00    LDA $0002,x[$A9:D780]  ; A = [[X] + 2] (top offset)
$A9:D46A 80 05       BRA $05    [$D471]
                                            ; Else ([Samus Y position] >= [torizo corpse Y position]):
$A9:D46C 85 18       STA $18    [$7E:0018]  ; $18 = [Samus Y position] - [torizo corpse Y position]
$A9:D46E BD 06 00    LDA $0006,x[$A9:D784]  ; A = [[X] + 6] (bottom offset)

$A9:D471 10 04       BPL $04    [$D477]     ;\
$A9:D473 49 FF FF    EOR #$FFFF             ;|
$A9:D476 1A          INC A                  ;|
                                            ;|
$A9:D477 18          CLC                    ;} If |[A]| + [Samus Y radius] < |[torizo corpse Y position] - [Samus Y position]|: go to BRANCH_NEXT
$A9:D478 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$A9:D47B 38          SEC                    ;|
$A9:D47C E5 18       SBC $18    [$7E:0018]  ;|
$A9:D47E 30 27       BMI $27    [$D4A7]     ;/
$A9:D480 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:D483 38          SEC                    ;|
$A9:D484 E5 12       SBC $12    [$7E:0012]  ;} If [Samus X position] < [torizo corpse X position]:
$A9:D486 10 0B       BPL $0B    [$D493]     ;/
$A9:D488 49 FF FF    EOR #$FFFF             ;\
$A9:D48B 1A          INC A                  ;} $18 = [torizo corpse X position] - [Samus X position]
$A9:D48C 85 18       STA $18    [$7E:0018]  ;/
$A9:D48E BD 00 00    LDA $0000,x            ; A = [[X]] (left offset)
$A9:D491 80 05       BRA $05    [$D498]
                                            ; Else ([Samus X position] >= [torizo corpse X position]):
$A9:D493 85 18       STA $18    [$7E:0018]  ; $18 = [Samus X position] - [torizo corpse X position]
$A9:D495 BD 04 00    LDA $0004,x[$A9:D782]  ; A = [[X] + 4] (right offset)

$A9:D498 10 04       BPL $04    [$D49E]     ;\
$A9:D49A 49 FF FF    EOR #$FFFF             ;|
$A9:D49D 1A          INC A                  ;|
                                            ;|
$A9:D49E 18          CLC                    ;} If |[A]| + [Samus X radius] >= |[torizo corpse X position] - [Samus X position]|: go to BRANCH_COLLISION
$A9:D49F 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;|
$A9:D4A2 38          SEC                    ;|
$A9:D4A3 E5 18       SBC $18    [$7E:0018]  ;|
$A9:D4A5 10 0F       BPL $0F    [$D4B6]     ;/

; BRANCH_NEXT
$A9:D4A7 C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$A9:D4A9 F0 09       BEQ $09    [$D4B4]     ; If [$16] != 0:
$A9:D4AB 8A          TXA                    ;\
$A9:D4AC 18          CLC                    ;|
$A9:D4AD 69 08 00    ADC #$0008             ;} X += 8 (next hitbox entry)
$A9:D4B0 AA          TAX                    ;/
$A9:D4B1 4C 59 D4    JMP $D459  [$A9:D459]  ; Go to LOOP

$A9:D4B4 18          CLC                    ;\
$A9:D4B5 60          RTS                    ;} Return carry clear

; BRANCH_COLLISION
$A9:D4B6 C9 04 00    CMP #$0004             ;\
$A9:D4B9 10 03       BPL $03    [$D4BE]     ;|
$A9:D4BB A9 04 00    LDA #$0004             ;} Extra Samus X displacement = max(4, |[A]|)
                                            ;|
$A9:D4BE 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A9:D4C1 A9 04 00    LDA #$0004             ;\
$A9:D4C4 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;} Extra Samus Y displacement = 4
$A9:D4C7 9C 56 0B    STZ $0B56  [$7E:0B56]  ; Extra Samus X subdisplacement = 0
$A9:D4CA 9C 5A 0B    STZ $0B5A  [$7E:0B5A]  ; Extra Samus Y subdisplacement = 0
$A9:D4CD 38          SEC                    ;\
$A9:D4CE 60          RTS                    ;} Return carry set
}


;;; $D4CF: Process torizo corpse corpse rotting VRAM transfers ;;;
{
$A9:D4CF AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A9:D4D3 1A          INC A                  ;} Increment $7E:7800
$A9:D4D4 8F 00 78 7E STA $7E7800[$7E:7800]  ;/
$A9:D4D8 4A          LSR A                  ;\
$A9:D4D9 B0 37       BCS $37    [$D512]     ;} If [$7E:7800] % 2 != 0: go to BRANCH_ODD
$A9:D4DB A2 00 00    LDX #$0000             ; X = 0
$A9:D4DE AC 30 03    LDY $0330  [$7E:0330]  ; Y = [VRAM write table stack pointer]
$A9:D4E1 BD 49 D5    LDA $D549,x[$A9:D549]

; LOOP_EVEN
$A9:D4E4 99 D0 00    STA $00D0,y[$7E:00D0]  ;\
$A9:D4E7 BD 4B D5    LDA $D54B,x[$A9:D54B]  ;|
$A9:D4EA 99 D3 00    STA $00D3,y[$7E:00D3]  ;|
$A9:D4ED BD 4D D5    LDA $D54D,x[$A9:D54D]  ;} Queue transfer of [$D549 + [X]] bytes from $7E:0000 + [$D549 + [X] + 4] to VRAM [$D549 + [X] + 6]
$A9:D4F0 99 D2 00    STA $00D2,y[$7E:00D2]  ;|
$A9:D4F3 BD 4F D5    LDA $D54F,x[$A9:D54F]  ;|
$A9:D4F6 99 D5 00    STA $00D5,y[$7E:00D5]  ;/
$A9:D4F9 98          TYA                    ;\
$A9:D4FA 18          CLC                    ;|
$A9:D4FB 69 07 00    ADC #$0007             ;} Y += 7 (next VRAM write table entry)
$A9:D4FE A8          TAY                    ;/
$A9:D4FF 8A          TXA                    ;\
$A9:D500 69 08 00    ADC #$0008             ;} X += 8 (next corpse rotting VRAM transfer)
$A9:D503 AA          TAX                    ;/
$A9:D504 BD 49 D5    LDA $D549,x[$A9:D551]  ;\
$A9:D507 D0 DB       BNE $DB    [$D4E4]     ;} If [$D549 + [X]] != 0: go to LOOP_EVEN
$A9:D509 8F 04 80 7E STA $7E8004[$7E:8004]  ; $7E:8004 = 0 (unused copy+paste residue of sprite tiles transfer entry pointer)
$A9:D50D 98          TYA                    ;\
$A9:D50E 8D 30 03    STA $0330  [$7E:0330]  ;} VRAM write table stack pointer = [Y]
$A9:D511 60          RTS                    ; Return

; BRANCH_ODD
$A9:D512 A2 00 00    LDX #$0000             ; X = 0
$A9:D515 AC 30 03    LDY $0330  [$7E:0330]  ; Y = [VRAM write table stack pointer]
$A9:D518 BD 83 D5    LDA $D583,x[$A9:D583]

; LOOP_ODD
$A9:D51B 99 D0 00    STA $00D0,y[$7E:00D0]  ;\
$A9:D51E BD 85 D5    LDA $D585,x[$A9:D585]  ;|
$A9:D521 99 D3 00    STA $00D3,y[$7E:00D3]  ;|
$A9:D524 BD 87 D5    LDA $D587,x[$A9:D587]  ;} Queue transfer of [$D583 + [X]] bytes from $7E:0000 + [$D583 + [X] + 4] to VRAM [$D583 + [X] + 6]
$A9:D527 99 D2 00    STA $00D2,y[$7E:00D2]  ;|
$A9:D52A BD 89 D5    LDA $D589,x[$A9:D589]  ;|
$A9:D52D 99 D5 00    STA $00D5,y[$7E:00D5]  ;/
$A9:D530 98          TYA                    ;\
$A9:D531 18          CLC                    ;|
$A9:D532 69 07 00    ADC #$0007             ;} Y += 7 (next VRAM write table entry)
$A9:D535 A8          TAY                    ;/
$A9:D536 8A          TXA                    ;\
$A9:D537 69 08 00    ADC #$0008             ;} X += 8 (next corpse rotting VRAM transfer)
$A9:D53A AA          TAX                    ;/
$A9:D53B BD 83 D5    LDA $D583,x[$A9:D58B]  ;\
$A9:D53E D0 DB       BNE $DB    [$D51B]     ;} If [$D583 + [X]] != 0: go to LOOP_ODD
$A9:D540 8F 04 80 7E STA $7E8004[$7E:8004]  ; $7E:8004 = 0 (unused copy+paste residue of sprite tiles transfer entry pointer)
$A9:D544 98          TYA                    ;\
$A9:D545 8D 30 03    STA $0330  [$7E:0330]  ;} VRAM write table stack pointer = [Y]
$A9:D548 60          RTS

; Corpse rotting VRAM transfers
;                        __________________ Size
;                       |     _____________ Source bank * 100h
;                       |    |     ________ Source address
;                       |    |    |     ___ VRAM address
;                       |    |    |    |
$A9:D549             dw 00C0,7E00,2060,7090,
                        00C0,7E00,21A0,7190,
                        0100,7E00,22C0,7280,
                        0100,7E00,2400,7380,
                        0100,7E00,2540,7480,
                        0100,7E00,2680,7580,
                        0120,7E00,9620,7100,
                        0000

$A9:D583             dw 0100,7E00,27C0,7680,
                        0100,7E00,2900,7780,
                        0100,7E00,2A40,7880,
                        0120,7E00,2B60,7970,
                        0140,7E00,2C80,7A60,
                        0140,7E00,2DC0,7B60,
                        0100,7E00,9500,7000,
                        0000
}


;;; $D5BD: Corpse rotting rot entry finished hook - torizo corpse ;;;
{
$A9:D5BD DA          PHX
$A9:D5BE AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:D5C1 29 1F 00    AND #$001F             ;|
$A9:D5C4 18          CLC                    ;} $12 = 110h + [random number] % 20h (X position)
$A9:D5C5 69 10 01    ADC #$0110             ;|
$A9:D5C8 85 12       STA $12    [$7E:0012]  ;/
$A9:D5CA A9 BC 00    LDA #$00BC             ;\
$A9:D5CD 85 14       STA $14    [$7E:0014]  ;} $14 = BCh (Y position)
$A9:D5CF A9 0A 00    LDA #$000A             ; A = Ah (corpse dust cloud)
$A9:D5D2 A0 09 E5    LDY #$E509             ;\
$A9:D5D5 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:D5D9 AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A9:D5DC 29 07 00    AND #$0007             ;} If [number of times main enemy routine has been executed] % 8 = 0:
$A9:D5DF D0 07       BNE $07    [$D5E8]     ;/
$A9:D5E1 A9 10 00    LDA #$0010             ;\
$A9:D5E4 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 10h, sound library 2, max queued sounds allowed = 6 (lava/acid damaging Samus)

$A9:D5E8 FA          PLX
$A9:D5E9 60          RTS
}


;;; $D5EA: Copy line of sand heap tile data ;;;
{
;; Parameters:
;;     A: Y pixel row to copy

; Tile data calculations:
;     Tiles are 20h bytes
;     Each sand heap graphics row is 9 tiles = 120h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:D5EA 0A          ASL A                  ;\
$A9:D5EB 48          PHA                    ;|
$A9:D5EC AA          TAX                    ;|
$A9:D5ED BD 7C D6    LDA $D67C,x[$A9:D69A]  ;} Y = [$D67C + [A] * 2]
$A9:D5F0 A8          TAY                    ;|
$A9:D5F1 FA          PLX                    ;/
$A9:D5F2 BD 9C D6    LDA $D69C,x[$A9:D6BA]  ;\
$A9:D5F5 AA          TAX                    ;} X = [$D69C + [A] * 2]
$A9:D5F6 8B          PHB
$A9:D5F7 F4 7E 7E    PEA $7E7E              ;\
$A9:D5FA AB          PLB                    ;} DB = $7E
$A9:D5FB AB          PLB                    ;/
$A9:D5FC BF 00 A8 B7 LDA $B7A800,x[$B7:AA0E];\
$A9:D600 99 00 95    STA $9500,y[$7E:962E]  ;} $9500 + [Y] = [$B7:A800 + [X]]
$A9:D603 BF 10 A8 B7 LDA $B7A810,x[$B7:AA1E];\
$A9:D607 99 10 95    STA $9510,y[$7E:963E]  ;} $9500 + [Y] + 10h = [$B7:A800 + [X] + 10h] (tile 0)
$A9:D60A BF 20 A8 B7 LDA $B7A820,x[$B7:AA2E];\
$A9:D60E 99 20 95    STA $9520,y[$7E:964E]  ;} $9520 + [Y] = [$B7:A820 + [X]]
$A9:D611 BF 30 A8 B7 LDA $B7A830,x[$B7:AA3E];\
$A9:D615 99 30 95    STA $9530,y[$7E:965E]  ;} $9520 + [Y] + 10h = [$B7:A820 + [X] + 10h] (tile 1)
$A9:D618 BF 40 A8 B7 LDA $B7A840,x[$B7:AA4E];\
$A9:D61C 99 40 95    STA $9540,y[$7E:966E]  ;} $9540 + [Y] = [$B7:A840 + [X]]
$A9:D61F BF 50 A8 B7 LDA $B7A850,x[$B7:AA5E];\
$A9:D623 99 50 95    STA $9550,y[$7E:967E]  ;} $9540 + [Y] + 10h = [$B7:A840 + [X] + 10h] (tile 2)
$A9:D626 BF 60 A8 B7 LDA $B7A860,x[$B7:AA6E];\
$A9:D62A 99 60 95    STA $9560,y[$7E:968E]  ;} $9560 + [Y] = [$B7:A860 + [X]]
$A9:D62D BF 70 A8 B7 LDA $B7A870,x[$B7:AA7E];\
$A9:D631 99 70 95    STA $9570,y[$7E:969E]  ;} $9560 + [Y] + 10h = [$B7:A860 + [X] + 10h] (tile 3)
$A9:D634 BF 80 A8 B7 LDA $B7A880,x[$B7:AA8E];\
$A9:D638 99 80 95    STA $9580,y[$7E:96AE]  ;} $9580 + [Y] = [$B7:A880 + [X]]
$A9:D63B BF 90 A8 B7 LDA $B7A890,x[$B7:AA9E];\
$A9:D63F 99 90 95    STA $9590,y[$7E:96BE]  ;} $9580 + [Y] + 10h = [$B7:A880 + [X] + 10h] (tile 4)
$A9:D642 BF A0 A8 B7 LDA $B7A8A0,x[$B7:AAAE];\
$A9:D646 99 A0 95    STA $95A0,y[$7E:96CE]  ;} $95A0 + [Y] = [$B7:A8A0 + [X]]
$A9:D649 BF B0 A8 B7 LDA $B7A8B0,x[$B7:AABE];\
$A9:D64D 99 B0 95    STA $95B0,y[$7E:96DE]  ;} $95A0 + [Y] + 10h = [$B7:A8A0 + [X] + 10h] (tile 5)
$A9:D650 BF C0 A8 B7 LDA $B7A8C0,x[$B7:AACE];\
$A9:D654 99 C0 95    STA $95C0,y[$7E:96EE]  ;} $95C0 + [Y] = [$B7:A8C0 + [X]]
$A9:D657 BF D0 A8 B7 LDA $B7A8D0,x[$B7:AADE];\
$A9:D65B 99 D0 95    STA $95D0,y[$7E:96FE]  ;} $95C0 + [Y] + 10h = [$B7:A8C0 + [X] + 10h] (tile 6)
$A9:D65E BF E0 A8 B7 LDA $B7A8E0,x[$B7:AAEE];\
$A9:D662 99 E0 95    STA $95E0,y[$7E:970E]  ;} $95E0 + [Y] = [$B7:A8E0 + [X]]
$A9:D665 BF F0 A8 B7 LDA $B7A8F0,x[$B7:AAFE];\
$A9:D669 99 F0 95    STA $95F0,y[$7E:971E]  ;} $95E0 + [Y] + 10h = [$B7:A8E0 + [X] + 10h] (tile 7)
$A9:D66C BF 00 A9 B7 LDA $B7A900,x[$B7:AB0E];\
$A9:D670 99 00 96    STA $9600,y[$7E:972E]  ;} $9600 + [Y] = [$B7:A900 + [X]]
$A9:D673 BF 10 A9 B7 LDA $B7A910,x[$B7:AB1E];\
$A9:D677 99 10 96    STA $9610,y[$7E:973E]  ;} $9600 + [Y] + 10h = [$B7:A900 + [X] + 10h] (tile 8)
$A9:D67A AB          PLB
$A9:D67B 60          RTS

$A9:D67C             dw 0000, 0002, 0004, 0006, 0008, 000A, 000C, 000E, 0120, 0122, 0124, 0126, 0128, 012A, 012C, 012E ; Destination offsets
$A9:D69C             dw 0000, 0002, 0004, 0006, 0008, 000A, 000C, 000E, 0200, 0202, 0204, 0206, 0208, 020A, 020C, 020E ; Source offsets
}


;;; $D6BC: Palette - enemy $ED3F (torizo corpse) ;;;
{
$A9:D6BC             dw 3800, 4F38, 3A52, 0CA5, 0042, 42D5, 2DEF, 218B, 1528, 4F38, 42B4, 3631, 29CD, 1949, 0CC6, 0042
}


;;; $D6DC: Instruction list - torizo corpse ;;;
{
$A9:D6DC             dx 0001,D6E2,
                        812F        ; Sleep
}


;;; $D6E2: Torizo corpse spritemaps ;;;
{
; Torizo corpse
$A9:D6E2             dx 0019, 01E8,14,2397, C218,CC,230D, C208,CC,230B, C3F8,CC,2309, C220,DC,232E, C210,DC,232C, C200,DC,232A, C3F0,DC,2328, C220,EC,234E, C210,EC,234C, C200,EC,234A, C3F0,EC,2348, C220,FC,236E, C210,FC,236C, C200,FC,236A, C3F0,FC,2368, C220,0C,238E, C210,0C,238C, C200,0C,238A, C3F0,0C,2388, C220,1C,23AE, C210,1C,23AC, C200,1C,23AA, C3F0,1C,23A8, C3E0,1C,23A6

; Sand heap
$A9:D761             dx 0005, 0018,FE,2318, C208,F6,2306, C3F8,F6,2304, C3E8,F6,2302, C3D8,F6,2300
}


;;; $D77C: Torizo corpse hitbox definition ;;;
{
; [word] Number of entries
; [entries]
;
; Entry format:
;     [word] Left offset
;     [word] Top offset
;     [word] Right offset
;     [word] Bottom offset

$A9:D77C             dw 0007,
                        FFE1,0025,FFF5,002B,
                        0010,0025,0026,002B,
                        FFE8,0012,FFF3,0024,
                        000B,001A,0019,0024,
                        FFF6,FFE2,0010,0018,
                        FFF9,FFD4,0022,FFE1,
                        0011,FFE1,0028,FFF9
}
}


;;; $D7B6..DB11: Dead monsters AI ;;;
{
;;; $D7B6: Initialisation AI - enemy $ED7F/$EDBF (sidehopper corpse) ;;;
{
$A9:D7B6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:D7B9 BD B4 0F    LDA $0FB4,x[$7E:0FF4]  ;\
$A9:D7BC AA          TAX                    ;} Go to [$D7C0 + [enemy parameter 1]]
$A9:D7BD 7C C0 D7    JMP ($D7C0,x)[$A9:D7C4];/

$A9:D7C0             dw D7C4, D825
}


;;; $D7C4: Sidehopper corpse initialisation - enemy parameter 1 = 0 (initially alive) ;;;
{
; Palette 1 is loaded by Shitroid from $F8C6
$A9:D7C4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:D7C7 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A9:D7CA 29 FF 7F    AND #$7FFF             ;|
$A9:D7CD 09 00 08    ORA #$0800             ;} Set enemy to process off-screen and have non-solid hitbox
$A9:D7D0 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A9:D7D3 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A9:D7D6 29 00 01    AND #$0100             ;} If enemy is invisible:
$A9:D7D9 F0 09       BEQ $09    [$D7E4]     ;/
$A9:D7DB BD 86 0F    LDA $0F86,x            ;\
$A9:D7DE 09 00 02    ORA #$0200             ;} Mark enemy for deletion
$A9:D7E1 9D 86 0F    STA $0F86,x            ;/

$A9:D7E4 A9 00 00    LDA #$0000             ;\
$A9:D7E7 9F 10 78 7E STA $7E7810,x[$7E:7850];} Enemy drained palette index = 0
$A9:D7EB A9 60 00    LDA #$0060             ;\
$A9:D7EE 9F 14 78 7E STA $7E7814,x[$7E:7854];} Enemy X velocity = 60h
$A9:D7F2 A9 00 01    LDA #$0100             ;\
$A9:D7F5 9F 16 78 7E STA $7E7816,x[$7E:7856];} Enemy Y velocity = 100h
$A9:D7F9 A9 E8 01    LDA #$01E8             ;\
$A9:D7FC 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = 1E8h
$A9:D7FF A9 B8 00    LDA #$00B8             ;\
$A9:D802 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = B8h
$A9:D805 A9 E2 D8    LDA #$D8E2             ;\
$A9:D808 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $D8E2 (waiting for activation)
$A9:D80B A9 00 02    LDA #$0200             ;\
$A9:D80E 9D 96 0F    STA $0F96,x[$7E:0FD6]  ;} Enemy palette index = 200h (palette 1)
$A9:D811 A9 15 00    LDA #$0015             ;\
$A9:D814 9D 84 0F    STA $0F84,x[$7E:0FC4]  ;} Enemy Y radius = 15h
$A9:D817 A9 E3 EC    LDA #$ECE3             ;\
$A9:D81A 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;} Set enemy instruction list to $ECE3 (idle)
$A9:D81E A0 68 DD    LDY #$DD68             ; Y = $DD68
$A9:D821 20 5F DC    JSR $DC5F  [$A9:DC5F]  ; Initialise enemy corpse rotting
$A9:D824 6B          RTL
}


;;; $D825: Sidehopper corpse initialisation - enemy parameter 1 = 2 (initially dead) ;;;
{
; Palette 7 is loaded by Shitroid from $F8A6
$A9:D825 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:D828 A9 FF FF    LDA #$FFFF             ;\
$A9:D82B 9F 10 78 7E STA $7E7810,x[$7E:7890];} Enemy drained palette index = FFFFh
$A9:D82F A9 64 DA    LDA #$DA64             ;\
$A9:D832 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $DA64 (dead - wait for Samus collision)
$A9:D835 A9 00 0E    LDA #$0E00             ;\
$A9:D838 9D 96 0F    STA $0F96,x[$7E:1016]  ;} Enemy palette index = E00h (palette 7)
$A9:D83B A9 EF EC    LDA #$ECEF             ;\
$A9:D83E 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;} Set enemy instruction list to $ECEF (dead)
$A9:D842 A0 78 DD    LDY #$DD78             ; Y = $DD78
$A9:D845 20 5F DC    JSR $DC5F  [$A9:DC5F]  ; Initialise enemy corpse rotting
$A9:D848 6B          RTL
}


;;; $D849: Initialisation AI - enemy $EDFF (zoomer corpse) ;;;
{
$A9:D849 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:D84C A9 00 0E    LDA #$0E00             ;\
$A9:D84F 9D 96 0F    STA $0F96,x[$7E:1056]  ;} Enemy palette index = E00h (palette 7)
$A9:D852 A9 69 DA    LDA #$DA69             ;\
$A9:D855 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $DA69 (wait for Samus collision)
$A9:D858 BC B4 0F    LDY $0FB4,x[$7E:1074]  ;\
$A9:D85B B9 6A D8    LDA $D86A,y[$A9:D86A]  ;} Set enemy instruction list to [$D86A + [enemy parameter 1]]
$A9:D85E 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;/
$A9:D862 B9 70 D8    LDA $D870,y[$A9:D870]  ;\
$A9:D865 A8          TAY                    ;} Y = [$D870 + [enemy parameter 1]]
$A9:D866 20 5F DC    JSR $DC5F  [$A9:DC5F]  ; Initialise enemy corpse rotting
$A9:D869 6B          RTL

; Enemy instruction list pointers
$A9:D86A             dw ECF5, ECFB, ED01

; Corpse rotting definition pointers
$A9:D870             dw DD88, DD98, DDA8
}


;;; $D876: Initialisation AI - enemy $EE3F (ripper corpse) ;;;
{
$A9:D876 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:D879 A9 00 0E    LDA #$0E00             ;\
$A9:D87C 9D 96 0F    STA $0F96,x[$7E:1116]  ;} Enemy palette index = E00h (palette 7)
$A9:D87F A9 73 DA    LDA #$DA73             ;\
$A9:D882 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Enemy function = $DA73 (wait for Samus collision)
$A9:D885 BC B4 0F    LDY $0FB4,x[$7E:1134]  ;\
$A9:D888 B9 97 D8    LDA $D897,y[$A9:D897]  ;} Set enemy instruction list to [$D897 + [enemy parameter 1]]
$A9:D88B 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;/
$A9:D88F B9 9B D8    LDA $D89B,y[$A9:D89B]  ;\
$A9:D892 A8          TAY                    ;} Y = [$D89B + [enemy parameter 1]]
$A9:D893 20 5F DC    JSR $DC5F  [$A9:DC5F]  ; Initialise enemy corpse rotting
$A9:D896 6B          RTL

; Enemy instruction list pointers
$A9:D897             dw ED07, ED0D

; Corpse rotting definition pointers
$A9:D89B             dw DDB8, DDC8
}


;;; $D89F: Initialisation AI - enemy $EE7F (skree corpse) ;;;
{
$A9:D89F AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:D8A2 A9 00 0E    LDA #$0E00             ;\
$A9:D8A5 9D 96 0F    STA $0F96,x[$7E:1196]  ;} Enemy palette index = E00h (palette 7)
$A9:D8A8 A9 6E DA    LDA #$DA6E             ;\
$A9:D8AB 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;} Enemy function = $DA6E (wait for Samus collision)
$A9:D8AE BC B4 0F    LDY $0FB4,x[$7E:11B4]  ;\
$A9:D8B1 B9 C0 D8    LDA $D8C0,y[$A9:D8C0]  ;} Set enemy instruction list to [$D8C0 + [enemy parameter 1]]
$A9:D8B4 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;/
$A9:D8B8 B9 C6 D8    LDA $D8C6,y[$A9:D8C6]  ;\
$A9:D8BB A8          TAY                    ;} Y = [$D8C6 + [enemy parameter 1]]
$A9:D8BC 20 5F DC    JSR $DC5F  [$A9:DC5F]  ; Initialise enemy corpse rotting
$A9:D8BF 6B          RTL

; Enemy instruction list pointers
$A9:D8C0             dw ED13, ED19, ED1F

; Corpse rotting definition pointers
$A9:D8C6             dw DDD8, DDE8, DDF8
}


;;; $D8CC: Power bomb reaction - enemy $ED7F (sidehopper corpse) ;;;
{
$A9:D8CC AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:D8CF BF 10 78 7E LDA $7E7810,x          ;\
$A9:D8D3 C9 08 00    CMP #$0008             ;} If [enemy drained palette index] >= 8:
$A9:D8D6 90 03       BCC $03    [$D8DB]     ;/
$A9:D8D8 4C 1D DD    JMP $DD1D  [$A9:DD1D]  ; Go to enemy shot - sidehopper corpse
}


;;; $D8DB: Main AI / hurt AI - enemy $ED7F/$EDBF/$EDFF/$EE3F/$EE7F (dead monsters) ;;;
{
$A9:D8DB AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:D8DE FC A8 0F    JSR ($0FA8,x)[$A9:D8E2]; Execute [enemy function]
$A9:D8E1 6B          RTL
}


;;; $D8E2: Sidehopper corpse function - alive - waiting for activation ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:D8E2 AD 11 09    LDA $0911  [$7E:0911]  ;\
$A9:D8E5 C9 01 02    CMP #$0201             ;} If [layer 1 X position] <= 200h:
$A9:D8E8 30 01       BMI $01    [$D8EB]     ;/
$A9:D8EA 60          RTS                    ; Return

$A9:D8EB A9 F1 D8    LDA #$D8F1             ;\
$A9:D8EE 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $D8F1 (hopping)
}


;;; $D8F1: Sidehopper corpse function - hopping ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:D8F1 20 61 D9    JSR $D961  [$A9:D961]  ; Sidehopper corpse movement
$A9:D8F4 90 19       BCC $19    [$D90F]     ; If collision:
$A9:D8F6 BF 0C 78 7E LDA $7E780C,x[$7E:784C];\
$A9:D8FA 1A          INC A                  ;|
$A9:D8FB 29 03 00    AND #$0003             ;} Enemy hop index = ([enemy hop index] + 1) % 4
$A9:D8FE 9F 0C 78 7E STA $7E780C,x[$7E:784C];/
$A9:D902 A9 AC EC    LDA #$ECAC             ;\
$A9:D905 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;} Set enemy instruction list to $ECAC (hopping)
$A9:D909 A9 0F D9    LDA #$D90F             ;\
$A9:D90C 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = RTS

$A9:D90F 60          RTS
}


;;; $D910: Sidehopper corpse function - start idling ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:D910 A9 1D D9    LDA #$D91D             ;\
$A9:D913 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $D91D (idling)
$A9:D916 A9 40 00    LDA #$0040             ;\
$A9:D919 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function timer = 40h
$A9:D91C 60          RTS
}


;;; $D91D: Sidehopper corpse function - idling ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:D91D DE B2 0F    DEC $0FB2,x[$7E:0FF2]  ; Decrement enemy function timer
$A9:D920 10 2E       BPL $2E    [$D950]     ; If [enemy function timer] >= 0: return
$A9:D922 BF 10 78 7E LDA $7E7810,x[$7E:7850];\
$A9:D926 F0 07       BEQ $07    [$D92F]     ;} If [enemy drained palette index] != 0:
$A9:D928 A9 08 DA    LDA #$DA08             ;\
$A9:D92B 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $DA08 (being drained)
$A9:D92E 60          RTS                    ; Return

$A9:D92F A9 F1 D8    LDA #$D8F1             ;\
$A9:D932 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $D8F1 (hopping)
$A9:D935 A9 E3 EC    LDA #$ECE3             ;\
$A9:D938 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;} Set enemy instruction list to $ECE3 (idle)
$A9:D93C BF 0C 78 7E LDA $7E780C,x[$7E:784C];\
$A9:D940 0A          ASL A                  ;} Y = [enemy hop index] * 2
$A9:D941 A8          TAY                    ;/
$A9:D942 B9 51 D9    LDA $D951,y[$A9:D953]  ;\
$A9:D945 9F 16 78 7E STA $7E7816,x[$7E:7856];} Enemy Y velocity = [$D951 + [Y]]
$A9:D949 B9 59 D9    LDA $D959,y[$A9:D95B]  ;\
$A9:D94C 9F 14 78 7E STA $7E7814,x[$7E:7854];} Enemy X velocity = [$D959 + [Y]]

$A9:D950 60          RTS

; Hop initial velocities
$A9:D951             dw FE00, FE00, FE00, FC00 ; Y velocity
$A9:D959             dw 01C0, 0120, 0120, 0300 ; X velocity
}


;;; $D961: Sidehopper corpse movement ;;;
{
;; Parameters:
;;     X: Enemy index
;; Returns:
;;     Carry: Set if collision, clear otherwise
$A9:D961 BF 14 78 7E LDA $7E7814,x[$7E:7854]; A = [enemy X velocity]
$A9:D965 20 C7 D9    JSR $D9C7  [$A9:D9C7]  ; Sidehopper corpse horizontal movement
$A9:D968 A0 20 00    LDY #$0020             ; Y = 20h
$A9:D96B BF 16 78 7E LDA $7E7816,x[$7E:7856];\
$A9:D96F 30 03       BMI $03    [$D974]     ;} If [enemy Y velocity] >= 0:
$A9:D971 A0 80 00    LDY #$0080             ; Y = 80h

$A9:D974 98          TYA                    ;\
$A9:D975 18          CLC                    ;|
$A9:D976 7F 16 78 7E ADC $7E7816,x[$7E:7856];} Enemy Y velocity += [Y]
$A9:D97A 9F 16 78 7E STA $7E7816,x[$7E:7856];/
$A9:D97E 85 12       STA $12    [$7E:0012]
$A9:D980 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A9:D983 C9 20 02    CMP #$0220             ;} If [enemy X position] >= 220h:
$A9:D986 30 1A       BMI $1A    [$D9A2]     ;/
$A9:D988 A5 12       LDA $12    [$7E:0012]
$A9:D98A E2 20       SEP #$20               ;\
$A9:D98C 85 13       STA $13    [$7E:0013]  ;|
$A9:D98E 64 12       STZ $12    [$7E:0012]  ;|
$A9:D990 C2 20       REP #$20               ;|
$A9:D992 29 00 FF    AND #$FF00             ;|
$A9:D995 10 03       BPL $03    [$D99A]     ;} $14.$12 = ±[enemy Y velocity] / 100h
$A9:D997 09 FF 00    ORA #$00FF             ;|
                                            ;|
$A9:D99A EB          XBA                    ;|
$A9:D99B 85 14       STA $14    [$7E:0014]  ;/
$A9:D99D 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A9:D9A1 60          RTS                    ; Return

$A9:D9A2 A5 12       LDA $12    [$7E:0012]
$A9:D9A4 E2 20       SEP #$20               ;\
$A9:D9A6 18          CLC                    ;|
$A9:D9A7 7D 81 0F    ADC $0F81,x[$7E:0FC1]  ;|
$A9:D9AA 9D 81 0F    STA $0F81,x[$7E:0FC1]  ;|
$A9:D9AD C2 20       REP #$20               ;|
$A9:D9AF 29 00 FF    AND #$FF00             ;|
$A9:D9B2 EB          XBA                    ;} Enemy Y position += ±[enemy Y velocity] / 100h
$A9:D9B3 10 03       BPL $03    [$D9B8]     ;|
$A9:D9B5 09 00 FF    ORA #$FF00             ;|
                                            ;|
$A9:D9B8 7D 7E 0F    ADC $0F7E,x[$7E:0FBE]  ;|
$A9:D9BB 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A9:D9BE C9 B8 00    CMP #$00B8             ;\
$A9:D9C1 30 02       BMI $02    [$D9C5]     ;} If [enemy Y position] >= B8h:
$A9:D9C3 38          SEC                    ;\
$A9:D9C4 60          RTS                    ;} Return carry set

$A9:D9C5 18          CLC                    ;\
$A9:D9C6 60          RTS                    ;} Return carry clear
}


;;; $D9C7: Sidehopper corpse horizontal movement ;;;
{
;; Parameters:
;;     A: Distance to move (signed)
;;     X: Enemy index
$A9:D9C7 85 12       STA $12    [$7E:0012]
$A9:D9C9 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A9:D9CC C9 20 02    CMP #$0220             ;} If [enemy X position] >= 220h:
$A9:D9CF 30 1A       BMI $1A    [$D9EB]     ;/
$A9:D9D1 A5 12       LDA $12    [$7E:0012]
$A9:D9D3 E2 20       SEP #$20               ;\
$A9:D9D5 85 13       STA $13    [$7E:0013]  ;|
$A9:D9D7 64 12       STZ $12    [$7E:0012]  ;|
$A9:D9D9 C2 20       REP #$20               ;|
$A9:D9DB 29 00 FF    AND #$FF00             ;|
$A9:D9DE 10 03       BPL $03    [$D9E3]     ;} $14.$12 = ±[A] / 100h
$A9:D9E0 09 FF 00    ORA #$00FF             ;|
                                            ;|
$A9:D9E3 EB          XBA                    ;|
$A9:D9E4 85 14       STA $14    [$7E:0014]  ;/
$A9:D9E6 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [$14].[$12]
$A9:D9EA 60          RTS                    ; Return

$A9:D9EB A5 12       LDA $12    [$7E:0012]
$A9:D9ED E2 20       SEP #$20               ;\
$A9:D9EF 18          CLC                    ;|
$A9:D9F0 7D 7D 0F    ADC $0F7D,x[$7E:0FBD]  ;|
$A9:D9F3 9D 7D 0F    STA $0F7D,x[$7E:0FBD]  ;|
$A9:D9F6 C2 20       REP #$20               ;|
$A9:D9F8 29 00 FF    AND #$FF00             ;|
$A9:D9FB EB          XBA                    ;} Enemy X position += ±[A] / 100h
$A9:D9FC 10 03       BPL $03    [$DA01]     ;|
$A9:D9FE 09 00 FF    ORA #$FF00             ;|
                                            ;|
$A9:DA01 7D 7A 0F    ADC $0F7A,x[$7E:0FBA]  ;|
$A9:DA04 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$A9:DA07 60          RTS
}


;;; $DA08: Sidehopper corpse function - being drained ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DA08 BF 0E 78 7E LDA $7E780E,x[$7E:784E];\
$A9:DA0C 1A          INC A                  ;} Increment enemy drained palette timer
$A9:DA0D 9F 0E 78 7E STA $7E780E,x[$7E:784E];/
$A9:DA11 C9 08 00    CMP #$0008             ;\
$A9:DA14 90 4C       BCC $4C    [$DA62]     ;} If [enemy drained palette timer] >= 8:
$A9:DA16 A9 00 00    LDA #$0000             ;\
$A9:DA19 9F 0E 78 7E STA $7E780E,x[$7E:784E];} Enemy drained palette timer = 0
$A9:DA1D BF 10 78 7E LDA $7E7810,x[$7E:7850];\
$A9:DA21 3A          DEC A                  ;|
$A9:DA22 0A          ASL A                  ;|
$A9:DA23 0A          ASL A                  ;|
$A9:DA24 0A          ASL A                  ;} Y = $EBCC + ([enemy drained palette index] - 1) * 20h
$A9:DA25 0A          ASL A                  ;|
$A9:DA26 0A          ASL A                  ;|
$A9:DA27 69 CC EB    ADC #$EBCC             ;|
$A9:DA2A A8          TAY                    ;/
$A9:DA2B A2 22 01    LDX #$0122             ;\
$A9:DA2E A9 0F 00    LDA #$000F             ;} Sprite palette 1 colours 1..Fh = 1Eh bytes from [Y]
$A9:DA31 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:DA35 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A9:DA38 BF 10 78 7E LDA $7E7810,x[$7E:7850];|
$A9:DA3C 1A          INC A                  ;} Increment enemy drained palette index
$A9:DA3D 9F 10 78 7E STA $7E7810,x[$7E:7850];/
$A9:DA41 C9 08 00    CMP #$0008             ;\
$A9:DA44 90 1C       BCC $1C    [$DA62]     ;} If [enemy drained palette index] >= 8:
$A9:DA46 A9 E9 EC    LDA #$ECE9             ;\
$A9:DA49 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;} Set enemy instruction list to $ECE9 (corpse)
$A9:DA4D A9 64 DA    LDA #$DA64             ;\
$A9:DA50 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $DA64 (dead - wait for Samus collision)
$A9:DA53 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A9:DA56 09 00 80    ORA #$8000             ;} Make enemy solid
$A9:DA59 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A9:DA5C A9 0C 00    LDA #$000C             ;\
$A9:DA5F 9D 84 0F    STA $0F84,x[$7E:0FC4]  ;} Enemy Y radius = Ch

$A9:DA62 60          RTS
}


;;; $DA63: RTS ;;;
{
$A9:DA63 60          RTS
}


;;; $DA64: Sidehopper corpse function - dead - wait for Samus collision ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DA64 A0 8F DA    LDY #$DA8F             ; Y = $DA8F (pre-rot delay)
$A9:DA67 80 0D       BRA $0D    [$DA76]     ; Go to dead enemies shared AI - wait for Samus collision
}


;;; $DA69: Zoomer corpse function - wait for Samus collision ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DA69 A0 94 DA    LDY #$DA94             ; Y = $DA94 (pre-rot delay)
$A9:DA6C 80 08       BRA $08    [$DA76]     ; Go to dead enemies shared AI - wait for Samus collision
}


;;; $DA6E: Skree corpse function - wait for Samus collision ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DA6E A0 9E DA    LDY #$DA9E             ; Y = $DA9E (pre-rot delay)
$A9:DA71 80 03       BRA $03    [$DA76]     ; Go to dead enemies shared AI - wait for Samus collision
}


;;; $DA73: Ripper corpse function - wait for Samus collision ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DA73 A0 99 DA    LDY #$DA99             ; Y = $DA99 (pre-rot delay)
}


;;; $DA76: Dead monsters shared AI - wait for Samus collision ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: New enemy function if collision occurred
$A9:DA76 EC 2C 18    CPX $182C  [$7E:182C]  ;\
$A9:DA79 F0 0F       BEQ $0F    [$DA8A]     ;|
$A9:DA7B EC 2E 18    CPX $182E  [$7E:182E]  ;|
$A9:DA7E F0 0A       BEQ $0A    [$DA8A]     ;|
$A9:DA80 EC 30 18    CPX $1830  [$7E:1830]  ;} If Samus collided with solid enemy:
$A9:DA83 F0 05       BEQ $05    [$DA8A]     ;|
$A9:DA85 EC 32 18    CPX $1832  [$7E:1832]  ;|
$A9:DA88 D0 04       BNE $04    [$DA8E]     ;/
$A9:DA8A 98          TYA                    ;\
$A9:DA8B 9D A8 0F    STA $0FA8,x            ;} Enemy function = [Y]

$A9:DA8E 60          RTS
}


;;; $DA8F: Sidehopper corpse function - pre-rot delay ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DA8F A0 BA DA    LDY #$DABA             ; Y = $DABA (rotting)
$A9:DA92 80 0D       BRA $0D    [$DAA1]     ; Go to dead enemies shared AI - pre-rot delay
}


;;; $DA94: Zoomer corpse function - pre-rot delay ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DA94 A0 D0 DA    LDY #$DAD0             ; Y = $DAD0 (rotting)
$A9:DA97 80 08       BRA $08    [$DAA1]     ; Go to dead enemies shared AI - pre-rot delay
}


;;; $DA99: Ripper corpse function - pre-rot delay ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DA99 A0 E6 DA    LDY #$DAE6             ; Y = $DAE6 (rotting)
$A9:DA9C 80 03       BRA $03    [$DAA1]     ; Go to dead enemies shared AI - pre-rot delay
}


;;; $DA9E: Skree corpse function - pre-rot delay ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DA9E A0 FC DA    LDY #$DAFC             ; Y = $DAFC (rotting)
}


;;; $DAA1: Dead monsters shared AI - pre-rot delay ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Rotting enemy function
$A9:DAA1 FE AA 0F    INC $0FAA,x[$7E:10AA]  ; Increment enemy pre-rot timer
$A9:DAA4 BD AA 0F    LDA $0FAA,x[$7E:10AA]  ;\
$A9:DAA7 C9 10 00    CMP #$0010             ;} If [enemy pre-rot timer] >= 10h:
$A9:DAAA 90 0D       BCC $0D    [$DAB9]     ;/
$A9:DAAC 98          TYA                    ;\
$A9:DAAD 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Enemy function = [Y]
$A9:DAB0 BD 86 0F    LDA $0F86,x[$7E:1086]  ;\
$A9:DAB3 09 00 04    ORA #$0400             ;} Set enemy as intangible
$A9:DAB6 9D 86 0F    STA $0F86,x[$7E:1086]  ;/

$A9:DAB9 60          RTS
}


;;; $DABA: Sidehopper corpse function - rotting ;;;
{
;; Parameters:
;;     X: Enemy index

; The LDA at $DAC2 looks like it was supposed to be for $DA63 (RTS), but since the sidehopper is intangible at this point, it doesn't really matter

$A9:DABA 20 12 DB    JSR $DB12  [$A9:DB12]  ; Process corpse rotting
$A9:DABD AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DAC0 B0 06       BCS $06    [$DAC8]     ; If finished rotting:
$A9:DAC2 A9 64 DA    LDA #$DA64             ;\
$A9:DAC5 9D A8 0F    STA $0FA8,x            ;} Enemy function = sidehopper corpse function - dead - wait for Samus collision

$A9:DAC8 BF 26 88 7E LDA $7E8826,x          ;\
$A9:DACC AA          TAX                    ;} Go to process enemy corpse rotting VRAM transfers
$A9:DACD 4C B9 DC    JMP $DCB9  [$A9:DCB9]  ;/
}


;;; $DAD0: Zoomer corpse function - rotting ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DAD0 20 12 DB    JSR $DB12  [$A9:DB12]  ; Process corpse rotting
$A9:DAD3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DAD6 B0 06       BCS $06    [$DADE]     ; If finished rotting:
$A9:DAD8 A9 63 DA    LDA #$DA63             ;\
$A9:DADB 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Enemy function = RTS

$A9:DADE BF 26 88 7E LDA $7E8826,x[$7E:8926];\
$A9:DAE2 AA          TAX                    ;} Go to process enemy corpse rotting VRAM transfers
$A9:DAE3 4C B9 DC    JMP $DCB9  [$A9:DCB9]  ;/
}


;;; $DAE6: Ripper corpse function - rotting ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DAE6 20 12 DB    JSR $DB12  [$A9:DB12]  ; Process corpse rotting
$A9:DAE9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DAEC B0 06       BCS $06    [$DAF4]     ; If finished rotting:
$A9:DAEE A9 63 DA    LDA #$DA63             ;\
$A9:DAF1 9D A8 0F    STA $0FA8,x[$7E:1168]  ;} Enemy function = RTS

$A9:DAF4 BF 26 88 7E LDA $7E8826,x[$7E:89E6];\
$A9:DAF8 AA          TAX                    ;} Go to process enemy corpse rotting VRAM transfers
$A9:DAF9 4C B9 DC    JMP $DCB9  [$A9:DCB9]  ;/
}


;;; $DAFC: Skree corpse function - rotting ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:DAFC 20 12 DB    JSR $DB12  [$A9:DB12]  ; Process corpse rotting
$A9:DAFF AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DB02 B0 06       BCS $06    [$DB0A]     ; If finished rotting:
$A9:DB04 A9 63 DA    LDA #$DA63             ;\
$A9:DB07 9D A8 0F    STA $0FA8,x[$7E:11E8]  ;} Enemy function = RTS

$A9:DB0A BF 26 88 7E LDA $7E8826,x[$7E:8A66];\
$A9:DB0E AA          TAX                    ;} Go to process enemy corpse rotting VRAM transfers
$A9:DB0F 4C B9 DC    JMP $DCB9  [$A9:DCB9]  ;/
}
}


;;; $DB12: Process corpse rotting ;;;
{
;; Parameters:
;;     X: Enemy index

{
; n_entries = [$880A]
; for (i_entry = 0; i_entry < n_entries; ++i_entry):
; {
;     p_entries = [enemy $8824]
;     y = [[p_entries]]
;     t = [[p_entries] + 2]
;
;     If y < 0:
;         next
;
;     If t != 0:
;     {
;         Decrement t
;         If t >= 4:
;             next
;     }
;
;     $8802 = y
;     y_tile = y / 8
;     y_pixel = y % 8
;
;     X = [$A9:0000 + [$8808] + y_tile * 2] + y_pixel * 2 (tile data offset of pixel row y)
;     If y_pixel < 6:
;         Y = [X]
;     Else:
;         Y = [X] + (tile row size - Ch) (tile data offset of pixel row y - 6 of next tile row)
;
;     If t != 0:
;     {
;         If i_entry < (height - 2):
;             Execute [$8804] (copy pixel row down)
;         Else:
;             Execute [$8806] (move pixel row down)
;     }
;     Else:
;     {
;         Execute [$8806] (move pixel row down)
;         If y + 2 < (height - 1):
;             y += 2
;         Else:
;         {
;             Execute [$8812] (rot entry finished hook)
;             If i_entry >= (height - 1):
;                 Return carry clear (finished rotting)
;
;             y = -1
;         }
;     }
; }
;
; Return carry set
}

$A9:DB12 8B          PHB
$A9:DB13 F4 7E 7E    PEA $7E7E              ;\
$A9:DB16 AB          PLB                    ;} DB = $7E
$A9:DB17 AB          PLB                    ;/
$A9:DB18 BD 2E 88    LDA $882E,x[$7E:882E]  ;\
$A9:DB1B 8D 0A 88    STA $880A  [$7E:880A]  ;|
$A9:DB1E BD 30 88    LDA $8830,x[$7E:8830]  ;|
$A9:DB21 8D 0C 88    STA $880C  [$7E:880C]  ;|
$A9:DB24 BD 32 88    LDA $8832,x[$7E:8832]  ;|
$A9:DB27 8D 0E 88    STA $880E  [$7E:880E]  ;|
$A9:DB2A BD 34 88    LDA $8834,x[$7E:8834]  ;|
$A9:DB2D 8D 10 88    STA $8810  [$7E:8810]  ;|
$A9:DB30 BD 36 88    LDA $8836,x[$7E:8836]  ;} $8804..13 = [enemy $8828..37] (make working copy of corpse rotting variables)
$A9:DB33 8D 12 88    STA $8812  [$7E:8812]  ;|
$A9:DB36 BD 2C 88    LDA $882C,x[$7E:882C]  ;|
$A9:DB39 8D 08 88    STA $8808  [$7E:8808]  ;|
$A9:DB3C BD 28 88    LDA $8828,x[$7E:8828]  ;|
$A9:DB3F 8D 04 88    STA $8804  [$7E:8804]  ;|
$A9:DB42 BD 2A 88    LDA $882A,x[$7E:882A]  ;|
$A9:DB45 8D 06 88    STA $8806  [$7E:8806]  ;/
$A9:DB48 BD 24 88    LDA $8824,x[$7E:8824]  ;\
$A9:DB4B AA          TAX                    ;} X = [enemy corpse rotting rot table pointer]
$A9:DB4C A9 00 00    LDA #$0000             ; A = 0 (loop counter)

; LOOP
$A9:DB4F 48          PHA
$A9:DB50 BD 00 00    LDA $0000,x[$7E:9000]  ;\
$A9:DB53 30 75       BMI $75    [$DBCA]     ;} If [[X]] < 0: go to BRANCH_NEXT
$A9:DB55 BD 02 00    LDA $0002,x[$7E:9002]  ;\
$A9:DB58 F0 2E       BEQ $2E    [$DB88]     ;} If [[X] + 2] = 0: go to BRANCH_TIMER_EXPIRED
$A9:DB5A 3A          DEC A                  ;\
$A9:DB5B 9D 02 00    STA $0002,x[$7E:9006]  ;} Decrement [X] + 2
$A9:DB5E C9 04 00    CMP #$0004             ;\
$A9:DB61 B0 67       BCS $67    [$DBCA]     ;} If [[X] + 2] >= 4: go to BRANCH_NEXT
$A9:DB63 AD 04 88    LDA $8804  [$7E:8804]  ;\
$A9:DB66 85 12       STA $12    [$7E:0012]  ;} $12 = [corpse rotting rot entry copy function]
$A9:DB68 A3 01       LDA $01,s  [$7E:1FED]  ;\
$A9:DB6A CD 0E 88    CMP $880E  [$7E:880E]  ;} If (loop counter) >= [corpse rotting sprite height] - 2:
$A9:DB6D 90 05       BCC $05    [$DB74]     ;/
$A9:DB6F AD 06 88    LDA $8806  [$7E:8806]  ;\
$A9:DB72 85 12       STA $12    [$7E:0012]  ;} $12 = [corpse rotting rot entry move function]

$A9:DB74 AD 08 88    LDA $8808  [$7E:8808]  ;\
$A9:DB77 85 14       STA $14    [$7E:0014]  ;|
$A9:DB79 A9 A9 00    LDA #$00A9             ;} $14 = $A9:0000 + [corpse rotting tile data row offsets pointer]
$A9:DB7C 85 16       STA $16    [$7E:0016]  ;/
$A9:DB7E DA          PHX
$A9:DB7F BD 00 00    LDA $0000,x[$7E:9004]  ; A = [[X]]
$A9:DB82 20 E0 DB    JSR $DBE0  [$A9:DBE0]  ; Copy/move corpse rotting rot entry
$A9:DB85 FA          PLX
$A9:DB86 80 42       BRA $42    [$DBCA]     ; Go to BRANCH_NEXT

; BRANCH_TIMER_EXPIRED
$A9:DB88 DA          PHX
$A9:DB89 AD 06 88    LDA $8806  [$7E:8806]  ;\
$A9:DB8C 85 12       STA $12    [$7E:0012]  ;} $12 = [corpse rotting rot entry move function]
$A9:DB8E AD 08 88    LDA $8808  [$7E:8808]  ;\
$A9:DB91 85 14       STA $14    [$7E:0014]  ;|
$A9:DB93 A9 A9 00    LDA #$00A9             ;} $14 = $A9:0000 + [corpse rotting tile data row offsets pointer]
$A9:DB96 85 16       STA $16    [$7E:0016]  ;/
$A9:DB98 BD 00 00    LDA $0000,x[$7E:9000]  ; A = [[X]]
$A9:DB9B 20 E0 DB    JSR $DBE0  [$A9:DBE0]  ; Copy/move corpse rotting rot entry
$A9:DB9E FA          PLX
$A9:DB9F BD 00 00    LDA $0000,x[$7E:9000]  ;\
$A9:DBA2 18          CLC                    ;} A = [[X]] + 2
$A9:DBA3 69 02 00    ADC #$0002             ;/
$A9:DBA6 CD 0C 88    CMP $880C  [$7E:880C]  ;\
$A9:DBA9 90 1C       BCC $1C    [$DBC7]     ;} If [A] >= [corpse rotting sprite height] - 1:
$A9:DBAB AD 12 88    LDA $8812  [$7E:8812]  ;\
$A9:DBAE 85 12       STA $12    [$7E:0012]  ;|
$A9:DBB0 4B          PHK                    ;|
$A9:DBB1 AB          PLB                    ;|
$A9:DBB2 F4 B7 DB    PEA $DBB7              ;} Execute [corpse rotting rot entry finished hook]
$A9:DBB5 6C 12 00    JMP ($0012)[$A9:D5BD]  ;|
$A9:DBB8 F4 7E 7E    PEA $7E7E              ;|
$A9:DBBB AB          PLB                    ;|
$A9:DBBC AB          PLB                    ;/
$A9:DBBD A3 01       LDA $01,s  [$7E:1FED]  ;\
$A9:DBBF CD 0C 88    CMP $880C  [$7E:880C]  ;} If (loop counter) >= [corpse rotting sprite height] - 1: return carry clear
$A9:DBC2 B0 18       BCS $18    [$DBDC]     ;/
$A9:DBC4 A9 FF FF    LDA #$FFFF             ; A = FFFFh

$A9:DBC7 9D 00 00    STA $0000,x[$7E:9000]  ; [X] = [A]

; BRANCH_NEXT
$A9:DBCA 8A          TXA                    ;\
$A9:DBCB 18          CLC                    ;|
$A9:DBCC 69 04 00    ADC #$0004             ;} X += 4
$A9:DBCF AA          TAX                    ;/
$A9:DBD0 68          PLA
$A9:DBD1 1A          INC A                  ; Increment (loop counter)
$A9:DBD2 CD 0A 88    CMP $880A  [$7E:880A]  ;\
$A9:DBD5 10 03       BPL $03    [$DBDA]     ;} If (loop counter) < [corpse rotting sprite height]:
$A9:DBD7 4C 4F DB    JMP $DB4F  [$A9:DB4F]  ; Go to LOOP

$A9:DBDA AB          PLB
$A9:DBDB 60          RTS                    ; Return carry set (set by CMP)

$A9:DBDC 68          PLA
$A9:DBDD AB          PLB
$A9:DBDE 18          CLC                    ;\
$A9:DBDF 60          RTS                    ;} Return carry clear
}


;;; $DBE0: Copy/move corpse rotting rot entry ;;;
{
;; Parameters:
;;     A: Corpse rotting rot entry Y offset
;;     $12: Corpse rotting rot entry copy/move function
;;     $14: Corpse rotting tile data row offsets pointer

; DB must be $7E

$A9:DBE0 8D 02 88    STA $8802  [$7E:8802]  ; Corpse rotting rot entry Y offset = [A]
$A9:DBE3 A8          TAY                    ;\
$A9:DBE4 29 F8 FF    AND #$FFF8             ;|
$A9:DBE7 4A          LSR A                  ;|
$A9:DBE8 4A          LSR A                  ;} X = [A] / 8 * 2
$A9:DBE9 AA          TAX                    ;|
$A9:DBEA 98          TYA                    ;/
$A9:DBEB 29 07 00    AND #$0007             ;\
$A9:DBEE C9 06 00    CMP #$0006             ;} If [A] % 8 < 6:
$A9:DBF1 B0 09       BCS $09    [$DBFC]     ;/
$A9:DBF3 9B          TXY                    ;\
$A9:DBF4 0A          ASL A                  ;|
$A9:DBF5 77 14       ADC [$14],y[$A9:E23C]  ;} X = [[$14] + [A] / 8 * 2] + [A] % 8 * 2 (source)
$A9:DBF7 AA          TAX                    ;/
$A9:DBF8 A8          TAY                    ; Y = [X] (dest)
$A9:DBF9 6C 12 00    JMP ($0012)[$A9:E38B]  ; Go to [$12]

$A9:DBFC 9B          TXY                    ;\
$A9:DBFD 0A          ASL A                  ;|
$A9:DBFE 77 14       ADC [$14],y[$A9:E23C]  ;} X = [[$14] + [A] / 8 * 2] + [A] % 8 * 2
$A9:DC00 AA          TAX                    ;/
$A9:DC01 6D 10 88    ADC $8810  [$7E:8810]  ;\
$A9:DC04 A8          TAY                    ;} Y = [X] + [$8810] (tile data offset to get from pixel row 6 of current tile row to pixel row 0 of next tile row)
$A9:DC05 6C 12 00    JMP ($0012)[$A9:E272]  ; Go to [$12]
}


;;; $DC08: Corpse rotting rot entry finished hook - normal ;;;
{
$A9:DC08 DA          PHX
$A9:DC09 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:DC0C 29 1A 00    AND #$001A             ;|
$A9:DC0F AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A9:DC12 18          CLC                    ;|
$A9:DC13 7D 7A 0F    ADC $0F7A,x[$7E:107A]  ;} $12 = [enemy X position] - Eh + ([random number] & 1Ah)
$A9:DC16 18          CLC                    ;|
$A9:DC17 69 F2 FF    ADC #$FFF2             ;|
$A9:DC1A 85 12       STA $12    [$7E:0012]  ;/
$A9:DC1C BD 7E 0F    LDA $0F7E,x[$7E:107E]  ;\
$A9:DC1F 18          CLC                    ;|
$A9:DC20 69 10 00    ADC #$0010             ;} $14 = [enemy Y position] + 10h
$A9:DC23 85 14       STA $14    [$7E:0014]  ;/
$A9:DC25 A9 0A 00    LDA #$000A             ; A = Ah (corpse dust cloud)
$A9:DC28 A0 09 E5    LDY #$E509             ;\
$A9:DC2B 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A9:DC2F AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A9:DC32 29 07 00    AND #$0007             ;} If [number of times main enemy routine has been executed] % 8 = 0:
$A9:DC35 D0 07       BNE $07    [$DC3E]     ;/
$A9:DC37 A9 10 00    LDA #$0010             ;\
$A9:DC3A 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 10h, sound library 2, max queued sounds allowed = 3 (lava/acid damaging Samus)

$A9:DC3E FA          PLX
$A9:DC3F 60          RTS
}


;;; $DC40: Initialise corpse rotting data table ;;;
{
;; Parameters:
;;     A: Height
;;     X: Corpse rotting data table pointer

; Make table of decreasing Y offsets with increasing timers

$A9:DC40 3A          DEC A                  ; Decrement A
$A9:DC41 64 12       STZ $12    [$7E:0012]  ; $12 = 0

; LOOP
$A9:DC43 48          PHA
$A9:DC44 9F 00 00 7E STA $7E0000,x[$7E:9000]; $7E:0000 + [X] = [A]
$A9:DC48 A5 12       LDA $12    [$7E:0012]  ;\
$A9:DC4A E8          INX                    ;|
$A9:DC4B E8          INX                    ;} $7E:0000 + [X] + 2 = [$12]
$A9:DC4C 9F 00 00 7E STA $7E0000,x[$7E:9002];/
$A9:DC50 E8          INX                    ;\
$A9:DC51 E8          INX                    ;} X += 4
$A9:DC52 A5 12       LDA $12    [$7E:0012]  ;\
$A9:DC54 18          CLC                    ;|
$A9:DC55 69 02 00    ADC #$0002             ;} $12 += 2
$A9:DC58 85 12       STA $12    [$7E:0012]  ;/
$A9:DC5A 68          PLA
$A9:DC5B 3A          DEC A                  ; Decrement A
$A9:DC5C 10 E5       BPL $E5    [$DC43]     ; If [A] >= 0: go to LOOP
$A9:DC5E 60          RTS
}


;;; $DC5F: Initialise enemy corpse rotting ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Corpse rotting definition pointer

$A9:DC5F B9 00 00    LDA $0000,y[$A9:DD58]  ;\
$A9:DC62 9F 24 88 7E STA $7E8824,x[$7E:8824];} Enemy corpse rotting rot table pointer = [[Y]]
$A9:DC66 B9 02 00    LDA $0002,y[$A9:DD5A]  ;\
$A9:DC69 9F 26 88 7E STA $7E8826,x[$7E:8826];} Enemy corpse rotting VRAM transfers pointer = [[Y] + 2]
$A9:DC6D B9 04 00    LDA $0004,y[$A9:DD5C]  ;\
$A9:DC70 9F 28 88 7E STA $7E8828,x[$7E:8828];} Enemy corpse rotting rot entry copy function = [[Y] + 4]
$A9:DC74 B9 06 00    LDA $0006,y[$A9:DD5E]  ;\
$A9:DC77 9F 2A 88 7E STA $7E882A,x[$7E:882A];} Enemy corpse rotting rot entry move function = [[Y] + 6]
$A9:DC7B B9 0E 00    LDA $000E,y[$A9:DD66]  ;\
$A9:DC7E 9F 36 88 7E STA $7E8836,x[$7E:8836];} Enemy corpse rotting rot entry finished hook = [[Y] + Eh]
$A9:DC82 B9 0C 00    LDA $000C,y[$A9:DD64]  ;\
$A9:DC85 9F 2C 88 7E STA $7E882C,x[$7E:882C];} Enemy corpse rotting tile data row offsets pointer = [[Y] + Ch]
$A9:DC89 5A          PHY                    ;\
$A9:DC8A A8          TAY                    ;|
$A9:DC8B B9 02 00    LDA $0002,y[$A9:E228]  ;|
$A9:DC8E 38          SEC                    ;} Enemy $7E:8834 = [[enemy corpse rotting VRAM transfers pointer] + 2] - Ch (tile data offset to get from pixel row 6 of current tile row to pixel row 0 of next tile row)
$A9:DC8F E9 0C 00    SBC #$000C             ;|
$A9:DC92 9F 34 88 7E STA $7E8834,x[$7E:8834];|
$A9:DC96 7A          PLY                    ;/
$A9:DC97 B9 08 00    LDA $0008,y[$A9:DD60]  ;\
$A9:DC9A 9F 2E 88 7E STA $7E882E,x[$7E:882E];} Enemy corpse rotting sprite height = [[Y] + 8]
$A9:DC9E 3A          DEC A                  ;\
$A9:DC9F 9F 30 88 7E STA $7E8830,x[$7E:8830];} Enemy $7E:8830 = [enemy corpse rotting sprite height] - 1
$A9:DCA3 3A          DEC A                  ;\
$A9:DCA4 9F 32 88 7E STA $7E8832,x[$7E:8832];} Enemy $7E:8832 = [enemy corpse rotting sprite height] - 2
$A9:DCA8 BE 00 00    LDX $0000,y[$A9:DD58]  ; X = [enemy corpse rotting rot table pointer]
$A9:DCAB B9 08 00    LDA $0008,y[$A9:DD60]  ; A = [enemy corpse rotting sprite height]
$A9:DCAE 20 40 DC    JSR $DC40  [$A9:DC40]  ; Initialise corpse rotting data table
$A9:DCB1 B9 0A 00    LDA $000A,y[$A9:DD62]  ;\
$A9:DCB4 85 12       STA $12    [$7E:0012]  ;} Go to [[Y] + Ah]
$A9:DCB6 6C 12 00    JMP ($0012)[$A9:DE18]  ;/
}


;;; $DCB9: Process corpse rotting VRAM transfers ;;;
{
;; Parameters:
;;     X: Corpse rotting VRAM transfers pointer. Format: size, source bank, source address, VRAM address (all 16 bit)
$A9:DCB9 AC 30 03    LDY $0330  [$7E:0330]  ; Y = [VRAM write table stack pointer]
$A9:DCBC BD 00 00    LDA $0000,x[$A9:E146]

; LOOP
$A9:DCBF 99 D0 00    STA $00D0,y[$7E:00D0]  ;\
$A9:DCC2 BD 02 00    LDA $0002,x[$A9:E148]  ;|
$A9:DCC5 99 D3 00    STA $00D3,y[$7E:00D3]  ;|
$A9:DCC8 BD 04 00    LDA $0004,x[$A9:E14A]  ;} Queue transfer of [[X]] bytes from [[X] + 2] to VRAM [[X] + 6]
$A9:DCCB 99 D2 00    STA $00D2,y[$7E:00D2]  ;|
$A9:DCCE BD 06 00    LDA $0006,x[$A9:E14C]  ;|
$A9:DCD1 99 D5 00    STA $00D5,y[$7E:00D5]  ;/
$A9:DCD4 98          TYA                    ;\
$A9:DCD5 18          CLC                    ;|
$A9:DCD6 69 07 00    ADC #$0007             ;} Y += 7 (next VRAM write table entry)
$A9:DCD9 A8          TAY                    ;/
$A9:DCDA 8A          TXA                    ;\
$A9:DCDB 69 08 00    ADC #$0008             ;} X += 8 (next corpse rotting VRAM transfer)
$A9:DCDE AA          TAX                    ;/
$A9:DCDF BD 00 00    LDA $0000,x[$A9:E14E]  ;\
$A9:DCE2 D0 DB       BNE $DB    [$DCBF]     ;} If [[X]] != 0: go to LOOP
$A9:DCE4 8F 04 80 7E STA $7E8004[$7E:8004]  ; Sprite tiles transfer entry pointer = 0
$A9:DCE8 98          TYA                    ;\
$A9:DCE9 8D 30 03    STA $0330  [$7E:0330]  ;} VRAM write table stack pointer = [Y]
$A9:DCEC 60          RTS
}


;;; $DCED..DD57: Dead monster contact reactions ;;;
{
;;; $DCED: Power bomb reaction - enemy $EDFF (zoomer corpse) ;;;
{
$A9:DCED AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DCF0 BD 86 0F    LDA $0F86,x            ;\
$A9:DCF3 29 00 04    AND #$0400             ;} If enemy is intangible: return
$A9:DCF6 D0 4B       BNE $4B    [$DD43]     ;/
}


;;; $DCF8: Enemy touch / enemy shot - enemy $EDFF (zoomer corpse) ;;;
{
$A9:DCF8 A9 D0 DA    LDA #$DAD0             ; Enemy function = $DAD0 (rotting)
$A9:DCFB 80 37       BRA $37    [$DD34]     ; Dead enemies shared contact reaction
}


;;; $DCFD: Power bomb reaction - enemy $EE3F (ripper corpse) ;;;
{
$A9:DCFD AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DD00 BD 86 0F    LDA $0F86,x            ;\
$A9:DD03 29 00 04    AND #$0400             ;} If enemy is intangible: return
$A9:DD06 D0 3B       BNE $3B    [$DD43]     ;/
}


;;; $DD08: Enemy touch / enemy shot - enemy $EE3F (ripper corpse) ;;;
{
$A9:DD08 A9 E6 DA    LDA #$DAE6             ; Enemy function = $DAE6 (rotting)
$A9:DD0B 80 27       BRA $27    [$DD34]     ; Dead enemies shared contact reaction
}


;;; $DD0D: Power bomb reaction - enemy $EE7F (skree corpse) ;;;
{
$A9:DD0D AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DD10 BD 86 0F    LDA $0F86,x            ;\
$A9:DD13 29 00 04    AND #$0400             ;} If enemy is intangible: return
$A9:DD16 D0 2B       BNE $2B    [$DD43]     ;/
}


;;; $DD18: Enemy touch / enemy shot - enemy $EE7F (skree corpse) ;;;
{
$A9:DD18 A9 FC DA    LDA #$DAFC             ; Enemy function = $DAFC (rotting)
$A9:DD1B 80 17       BRA $17    [$DD34]     ; Dead enemies shared contact reaction
}


;;; $DD1D: Enemy shot - enemy $ED7F (sidehopper corpse) ;;;
{
; Also power bomb reaction / enemy touch / enemy shot - enemy $EDBF (sidehopper corpse, part 2)
$A9:DD1D AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DD20 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A9:DD23 29 00 04    AND #$0400             ;} If enemy is intangible: return
$A9:DD26 D0 1B       BNE $1B    [$DD43]     ;/
$A9:DD28 BF 10 78 7E LDA $7E7810,x[$7E:7850];\
$A9:DD2C C9 08 00    CMP #$0008             ;} If [enemy drained palette index] < 8: return
$A9:DD2F 90 12       BCC $12    [$DD43]     ;/
}


;;; $DD31: Sidehopper corpse contact reaction - rottable ;;;
{
$A9:DD31 A9 BA DA    LDA #$DABA             ; Enemy function = $DABA (rotting)
}


;;; $DD34: Dead enemies shared contact reaction ;;;
{
;; Parameters:
;;     A: Rotting enemy function
$A9:DD34 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DD37 9D A8 0F    STA $0FA8,x[$7E:11E8]  ; Enemy function = [A]
$A9:DD3A BD 86 0F    LDA $0F86,x[$7E:11C6]  ;\
$A9:DD3D 09 00 0C    ORA #$0C00             ;} Set enemy as intangible and process off-screen
$A9:DD40 9D 86 0F    STA $0F86,x[$7E:11C6]  ;/

$A9:DD43 6B          RTL
}


;;; $DD44: Enemy touch - enemy $ED7F (sidehopper corpse) ;;;
{
$A9:DD44 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DD47 BF 10 78 7E LDA $7E7810,x[$7E:7850];\
$A9:DD4B C9 08 00    CMP #$0008             ;} If [enemy drained palette index] >= 8: go to sidehopper corpse contact reaction - rottable
$A9:DD4E B0 E1       BCS $E1    [$DD31]     ;/
$A9:DD50 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:DD53 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal enemy touch AI - no death check
$A9:DD57 6B          RTL
}
}


;;; $DD58: Corpse rotting definitions ;;;
{
;                        ______________________________________ 0: Corpse rotting rot table pointer (bank $7E)
;                       |     _________________________________ 2: Corpse rotting VRAM transfers pointer
;                       |    |     ____________________________ 4: Corpse rotting rot entry copy function
;                       |    |    |     _______________________ 6: Corpse rotting rot entry move function
;                       |    |    |    |     __________________ 8: Height
;                       |    |    |    |    |     _____________ Ah: Initialisation function pointer
;                       |    |    |    |    |    |     ________ Ch: Tile data row offsets pointer
;                       |    |    |    |    |    |    |     ___ Eh: Corpse rotting rot entry finished hook
;                       |    |    |    |    |    |    |    |
$A9:DD58             dw 9000,0000,E38B,E272,0060,DE18,E226,D5BD ; Torizo
$A9:DD68             dw 9000,E0E0,E4F5,E468,0028,DEC1,E240,DC08 ; Sidehopper - enemy parameter 1 = 0
$A9:DD78             dw 90A0,E10A,E5F6,E564,0028,DF08,E240,DC08 ; Sidehopper - enemy parameter 1 = 2
$A9:DD88             dw 92C0,E134,E6B9,E66A,0010,DF4F,E24C,DC08 ; Zoomer - enemy parameter 1 = 0
$A9:DD98             dw 9300,E146,E745,E6F6,0010,DF6C,E24C,DC08 ; Zoomer - enemy parameter 1 = 2
$A9:DDA8             dw 9340,E158,E7D1,E782,0010,DF89,E24C,DC08 ; Zoomer - enemy parameter 1 = 4
$A9:DDB8             dw 9380,E16A,E85D,E80E,0010,DFA6,E252,DC08 ; Ripper - enemy parameter 1 = 0
$A9:DDC8             dw 93C0,E17C,E8E9,E89A,0010,DFC3,E252,DC08 ; Ripper - enemy parameter 1 = 2
$A9:DDD8             dw 9140,E18E,E95B,E926,0020,DFE0,E258,DC08 ; Skree - enemy parameter 1 = 0
$A9:DDE8             dw 91C0,E1B0,E9B9,E984,0020,E019,E258,DC08 ; Skree - enemy parameter 1 = 2
$A9:DDF8             dw 9240,E1D2,EA17,E9E2,0020,E052,E258,DC08 ; Skree - enemy parameter 1 = 4
$A9:DE08             dw 9700,E1F4,EB0B,EA40,0030,E08B,E262,B223 ; Mother Brain
}


;;; $DE18..E0DF: Corpse rotting initialisation functions ;;;
{
;;; $DE18: Corpse rotting initialisation function - torizo ;;;
{
; $7E:2000..213F: Row 0
; $7E:2140..227F: Row 1
; $7E:2280..23BF: Row 2
; $7E:23C0..24FF: Row 3
; $7E:2500..263F: Row 4
; $7E:2640..277F: Row 5
; $7E:2780..28BF: Row 6
; $7E:28C0..29FF: Row 7
; $7E:2A00..2B3F: Row 8
; $7E:2B40..2C7F: Row 9
; $7E:2C80..2DBF: Row Ah
; $7E:2DC0..2EFF: Row Bh
$A9:DE18 8B          PHB
$A9:DE19 A2 20 A9    LDX #$A920  ;\
$A9:DE1C A0 60 20    LDY #$2060  ;|
$A9:DE1F A9 BF 00    LDA #$00BF  ;} $7E:2060..211F = [$B7:A920..A9DF]
$A9:DE22 54 7E B7    MVN B7 7E   ;/
$A9:DE25 AB          PLB
$A9:DE26 8B          PHB
$A9:DE27 A2 20 AB    LDX #$AB20  ;\
$A9:DE2A A0 A0 21    LDY #$21A0  ;|
$A9:DE2D A9 BF 00    LDA #$00BF  ;} $7E:21A0..225F = [$B7:AB20..ABDF]
$A9:DE30 54 7E B7    MVN B7 7E   ;/
$A9:DE33 AB          PLB
$A9:DE34 8B          PHB
$A9:DE35 A2 00 AD    LDX #$AD00  ;\
$A9:DE38 A0 C0 22    LDY #$22C0  ;|
$A9:DE3B A9 FF 00    LDA #$00FF  ;} $7E:22C0..23BF = [$B7:AD00..ADFF]
$A9:DE3E 54 7E B7    MVN B7 7E   ;/
$A9:DE41 AB          PLB
$A9:DE42 8B          PHB
$A9:DE43 A2 00 AF    LDX #$AF00  ;\
$A9:DE46 A0 00 24    LDY #$2400  ;|
$A9:DE49 A9 FF 00    LDA #$00FF  ;} $7E:2400..24FF = [$B7:AF00..AFFF]
$A9:DE4C 54 7E B7    MVN B7 7E   ;/
$A9:DE4F AB          PLB
$A9:DE50 8B          PHB
$A9:DE51 A2 00 B1    LDX #$B100  ;\
$A9:DE54 A0 40 25    LDY #$2540  ;|
$A9:DE57 A9 FF 00    LDA #$00FF  ;} $7E:2540..263F = [$B7:B100..B1FF]
$A9:DE5A 54 7E B7    MVN B7 7E   ;/
$A9:DE5D AB          PLB
$A9:DE5E 8B          PHB
$A9:DE5F A2 00 B3    LDX #$B300  ;\
$A9:DE62 A0 80 26    LDY #$2680  ;|
$A9:DE65 A9 FF 00    LDA #$00FF  ;} $7E:2680..277F = [$B7:B300..B3FF]
$A9:DE68 54 7E B7    MVN B7 7E   ;/
$A9:DE6B AB          PLB
$A9:DE6C 8B          PHB
$A9:DE6D A2 00 B5    LDX #$B500  ;\
$A9:DE70 A0 C0 27    LDY #$27C0  ;|
$A9:DE73 A9 FF 00    LDA #$00FF  ;} $7E:27C0..28BF = [$B7:B500..B5FF]
$A9:DE76 54 7E B7    MVN B7 7E   ;/
$A9:DE79 AB          PLB
$A9:DE7A 8B          PHB
$A9:DE7B A2 00 B7    LDX #$B700  ;\
$A9:DE7E A0 00 29    LDY #$2900  ;|
$A9:DE81 A9 FF 00    LDA #$00FF  ;} $7E:2900..29FF = [$B7:B700..B7FF]
$A9:DE84 54 7E B7    MVN B7 7E   ;/
$A9:DE87 AB          PLB
$A9:DE88 8B          PHB
$A9:DE89 A2 00 B9    LDX #$B900  ;\
$A9:DE8C A0 40 2A    LDY #$2A40  ;|
$A9:DE8F A9 FF 00    LDA #$00FF  ;} $7E:2A40..2B3F = [$B7:B900..B9FF]
$A9:DE92 54 7E B7    MVN B7 7E   ;/
$A9:DE95 AB          PLB
$A9:DE96 8B          PHB
$A9:DE97 A2 E0 BA    LDX #$BAE0  ;\
$A9:DE9A A0 60 2B    LDY #$2B60  ;|
$A9:DE9D A9 1F 01    LDA #$011F  ;} $7E:2B60..2C7F = [$B7:BAE0..BBFF]
$A9:DEA0 54 7E B7    MVN B7 7E   ;/
$A9:DEA3 AB          PLB
$A9:DEA4 8B          PHB
$A9:DEA5 A2 C0 BC    LDX #$BCC0  ;\
$A9:DEA8 A0 80 2C    LDY #$2C80  ;|
$A9:DEAB A9 3F 01    LDA #$013F  ;} $7E:2C80..2DBF = [$B7:BCC0..BDFF]
$A9:DEAE 54 7E B7    MVN B7 7E   ;/
$A9:DEB1 AB          PLB
$A9:DEB2 8B          PHB
$A9:DEB3 A2 C0 BE    LDX #$BEC0  ;\
$A9:DEB6 A0 C0 2D    LDY #$2DC0  ;|
$A9:DEB9 A9 3F 01    LDA #$013F  ;} $7E:2DC0..2EFF = [$B7:BEC0..BFFF]
$A9:DEBC 54 7E B7    MVN B7 7E   ;/
$A9:DEBF AB          PLB
$A9:DEC0 60          RTS
}


;;; $DEC1: Corpse rotting initialisation function - sidehopper - enemy parameter 1 = 0 ;;;
{
; $7E:2000..209F: Row 0
; $7E:20A0..213F: Row 1
; $7E:2140..21DF: Row 2
; $7E:21E0..227F: Row 3
; $7E:2280..231F: Row 4
$A9:DEC1 8B          PHB
$A9:DEC2 A2 40 C0    LDX #$C040  ;\
$A9:DEC5 A0 40 20    LDY #$2040  ;|
$A9:DEC8 A9 5F 00    LDA #$005F  ;} $7E:2040..209F = [$B7:C040..C09F]
$A9:DECB 54 7E B7    MVN B7 7E   ;/
$A9:DECE AB          PLB
$A9:DECF 8B          PHB
$A9:DED0 A2 00 C2    LDX #$C200  ;\
$A9:DED3 A0 A0 20    LDY #$20A0  ;|
$A9:DED6 A9 9F 00    LDA #$009F  ;} $7E:20A0..213F = [$B7:C200..C29F]
$A9:DED9 54 7E B7    MVN B7 7E   ;/
$A9:DEDC AB          PLB
$A9:DEDD 8B          PHB
$A9:DEDE A2 00 C4    LDX #$C400  ;\
$A9:DEE1 A0 40 21    LDY #$2140  ;|
$A9:DEE4 A9 9F 00    LDA #$009F  ;} $7E:2140..21DF = [$B7:C400..C49F]
$A9:DEE7 54 7E B7    MVN B7 7E   ;/
$A9:DEEA AB          PLB
$A9:DEEB 8B          PHB
$A9:DEEC A2 00 C6    LDX #$C600  ;\
$A9:DEEF A0 E0 21    LDY #$21E0  ;|
$A9:DEF2 A9 9F 00    LDA #$009F  ;} $7E:21E0..227F = [$B7:C600..C69F]
$A9:DEF5 54 7E B7    MVN B7 7E   ;/
$A9:DEF8 AB          PLB
$A9:DEF9 8B          PHB
$A9:DEFA A2 00 C8    LDX #$C800  ;\
$A9:DEFD A0 80 22    LDY #$2280  ;|
$A9:DF00 A9 9F 00    LDA #$009F  ;} $7E:2280..231F = [$B7:C800..C89F]
$A9:DF03 54 7E B7    MVN B7 7E   ;/
$A9:DF06 AB          PLB
$A9:DF07 60          RTS
}


;;; $DF08: Corpse rotting initialisation function - sidehopper - enemy parameter 1 = 2 ;;;
{
; $7E:2320..23BF: Row 0
; $7E:23C0..245F: Row 1
; $7E:2460..24FF: Row 2
; $7E:2500..259F: Row 3
; $7E:25A0..263F: Row 4
$A9:DF08 8B          PHB
$A9:DF09 A2 20 C1    LDX #$C120  ;\
$A9:DF0C A0 20 23    LDY #$2320  ;|
$A9:DF0F A9 3F 00    LDA #$003F  ;} $7E:2320..235F = [$B7:C120..C15F]
$A9:DF12 54 7E B7    MVN B7 7E   ;/
$A9:DF15 AB          PLB
$A9:DF16 8B          PHB
$A9:DF17 A2 20 C3    LDX #$C320  ;\
$A9:DF1A A0 C0 23    LDY #$23C0  ;|
$A9:DF1D A9 9F 00    LDA #$009F  ;} $7E:23C0..245F = [$B7:C320..C3BF]
$A9:DF20 54 7E B7    MVN B7 7E   ;/
$A9:DF23 AB          PLB
$A9:DF24 8B          PHB
$A9:DF25 A2 20 C5    LDX #$C520  ;\
$A9:DF28 A0 60 24    LDY #$2460  ;|
$A9:DF2B A9 9F 00    LDA #$009F  ;} $7E:2460..24FF = [$B7:C520..C5BF]
$A9:DF2E 54 7E B7    MVN B7 7E   ;/
$A9:DF31 AB          PLB
$A9:DF32 8B          PHB
$A9:DF33 A2 20 C7    LDX #$C720  ;\
$A9:DF36 A0 00 25    LDY #$2500  ;|
$A9:DF39 A9 9F 00    LDA #$009F  ;} $7E:2500..259F = [$B7:C720..C7BF]
$A9:DF3C 54 7E B7    MVN B7 7E   ;/
$A9:DF3F AB          PLB
$A9:DF40 8B          PHB
$A9:DF41 A2 20 C9    LDX #$C920  ;\
$A9:DF44 A0 A0 25    LDY #$25A0  ;|
$A9:DF47 A9 9F 00    LDA #$009F  ;} $7E:25A0..263F = [$B7:C920..C9BF]
$A9:DF4A 54 7E B7    MVN B7 7E   ;/
$A9:DF4D AB          PLB
$A9:DF4E 60          RTS
}


;;; $DF4F: Corpse rotting initialisation function - zoomer - enemy parameter 1 = 0 ;;;
{
; $7E:2940..99
; $7E:29A0..FF
$A9:DF4F 8B          PHB
$A9:DF50 A2 60 CA    LDX #$CA60  ;\
$A9:DF53 A0 40 29    LDY #$2940  ;|
$A9:DF56 A9 5F 00    LDA #$005F  ;} $7E:2940..299F = [$B7:CA60..CABF]
$A9:DF59 54 7E B7    MVN B7 7E   ;/
$A9:DF5C AB          PLB
$A9:DF5D 8B          PHB
$A9:DF5E A2 60 CC    LDX #$CC60  ;\
$A9:DF61 A0 A0 29    LDY #$29A0  ;|
$A9:DF64 A9 5F 00    LDA #$005F  ;} $7E:29A0..29FF = [$B7:CC60..CCBF]
$A9:DF67 54 7E B7    MVN B7 7E   ;/
$A9:DF6A AB          PLB
$A9:DF6B 60          RTS
}


;;; $DF6C: Corpse rotting initialisation function - zoomer - enemy parameter 1 = 2 ;;;
{
; $7E:2A00..5F: Row 0
; $7E:2A60..BF: Row 1
$A9:DF6C 8B          PHB
$A9:DF6D A2 C0 CA    LDX #$CAC0  ;\
$A9:DF70 A0 00 2A    LDY #$2A00  ;|
$A9:DF73 A9 5F 00    LDA #$005F  ;} $7E:2A00..2A5F = [$B7:CAC0..CB1F]
$A9:DF76 54 7E B7    MVN B7 7E   ;/
$A9:DF79 AB          PLB
$A9:DF7A 8B          PHB
$A9:DF7B A2 C0 CC    LDX #$CCC0  ;\
$A9:DF7E A0 60 2A    LDY #$2A60  ;|
$A9:DF81 A9 5F 00    LDA #$005F  ;} $7E:2A60..2ABF = [$B7:CCC0..CD1F]
$A9:DF84 54 7E B7    MVN B7 7E   ;/
$A9:DF87 AB          PLB
$A9:DF88 60          RTS
}


;;; $DF89: Corpse rotting initialisation function - zoomer - enemy parameter 1 = 4 ;;;
{
; $7E:2AC0..2B1F: Row 0
; $7E:2B20..2B7F: Row 1
$A9:DF89 8B          PHB
$A9:DF8A A2 20 CB    LDX #$CB20  ;\
$A9:DF8D A0 C0 2A    LDY #$2AC0  ;|
$A9:DF90 A9 5F 00    LDA #$005F  ;} $7E:2AC0..2B1F = [$B7:CB20..CB7F]
$A9:DF93 54 7E B7    MVN B7 7E   ;/
$A9:DF96 AB          PLB
$A9:DF97 8B          PHB
$A9:DF98 A2 20 CD    LDX #$CD20  ;\
$A9:DF9B A0 20 2B    LDY #$2B20  ;|
$A9:DF9E A9 5F 00    LDA #$005F  ;} $7E:2B20..2B7F = [$B7:CD20..CD7F]
$A9:DFA1 54 7E B7    MVN B7 7E   ;/
$A9:DFA4 AB          PLB
$A9:DFA5 60          RTS
}


;;; $DFA6: Corpse rotting initialisation function - ripper - enemy parameter 1 = 0 ;;;
{
; $7E:2B80..2BDF: Row 0
; $7E:2BE0..2C3F: Row 1
$A9:DFA6 8B          PHB
$A9:DFA7 A2 00 CA    LDX #$CA00  ;\
$A9:DFAA A0 80 2B    LDY #$2B80  ;|
$A9:DFAD A9 5F 00    LDA #$005F  ;} $7E:2B80..2BDF = [$B7:CA00..CA5F]
$A9:DFB0 54 7E B7    MVN B7 7E   ;/
$A9:DFB3 AB          PLB
$A9:DFB4 8B          PHB
$A9:DFB5 A2 00 CC    LDX #$CC00  ;\
$A9:DFB8 A0 E0 2B    LDY #$2BE0  ;|
$A9:DFBB A9 5F 00    LDA #$005F  ;} $7E:2BE0..2C3F = [$B7:CC00..CC5F]
$A9:DFBE 54 7E B7    MVN B7 7E   ;/
$A9:DFC1 AB          PLB
$A9:DFC2 60          RTS
}


;;; $DFC3: Corpse rotting initialisation function - ripper - enemy parameter 1 = 2 ;;;
{
; $7E:2C40..2C9F: Row 0
; $7E:2CA0..2CFF: Row 1
$A9:DFC3 8B          PHB
$A9:DFC4 A2 80 CB    LDX #$CB80  ;\
$A9:DFC7 A0 40 2C    LDY #$2C40  ;|
$A9:DFCA A9 5F 00    LDA #$005F  ;} $7E:2C40..2C9F = [$B7:CB80..CBDF]
$A9:DFCD 54 7E B7    MVN B7 7E   ;/
$A9:DFD0 AB          PLB
$A9:DFD1 8B          PHB
$A9:DFD2 A2 80 CD    LDX #$CD80  ;\
$A9:DFD5 A0 A0 2C    LDY #$2CA0  ;|
$A9:DFD8 A9 5F 00    LDA #$005F  ;} $7E:2CA0..2CFF = [$B7:CD80..CDDF]
$A9:DFDB 54 7E B7    MVN B7 7E   ;/
$A9:DFDE AB          PLB
$A9:DFDF 60          RTS
}


;;; $DFE0: Corpse rotting initialisation function - skree - enemy parameter 1 = 0 ;;;
{
; $7E:2640..267F: Row 0
; $7E:2680..26BF: Row 1
; $7E:26C0..26FF: Row 2
; $7E:2700..273F: Row 3
$A9:DFE0 8B          PHB
$A9:DFE1 A2 A0 C2    LDX #$C2A0  ;\
$A9:DFE4 A0 40 26    LDY #$2640  ;|
$A9:DFE7 A9 3F 00    LDA #$003F  ;} $7E:2640..267F = [$B7:C2A0..C2DF]
$A9:DFEA 54 7E B7    MVN B7 7E   ;/
$A9:DFED AB          PLB
$A9:DFEE 8B          PHB
$A9:DFEF A2 A0 C4    LDX #$C4A0  ;\
$A9:DFF2 A0 80 26    LDY #$2680  ;|
$A9:DFF5 A9 3F 00    LDA #$003F  ;} $7E:2680..26BF = [$B7:C4A0..C4DF]
$A9:DFF8 54 7E B7    MVN B7 7E   ;/
$A9:DFFB AB          PLB
$A9:DFFC 8B          PHB
$A9:DFFD A2 A0 C6    LDX #$C6A0  ;\
$A9:E000 A0 C0 26    LDY #$26C0  ;|
$A9:E003 A9 3F 00    LDA #$003F  ;} $7E:26C0..26FF = [$B7:C6A0..C6DF]
$A9:E006 54 7E B7    MVN B7 7E   ;/
$A9:E009 AB          PLB
$A9:E00A 8B          PHB
$A9:E00B A2 A0 C8    LDX #$C8A0  ;\
$A9:E00E A0 00 27    LDY #$2700  ;|
$A9:E011 A9 3F 00    LDA #$003F  ;} $7E:2700..273F = [$B7:C8A0..C8DF]
$A9:E014 54 7E B7    MVN B7 7E   ;/
$A9:E017 AB          PLB
$A9:E018 60          RTS
}


;;; $E019: Corpse rotting initialisation function - skree - enemy parameter 1 = 2 ;;;
{
; $7E:2740..277F: Row 0
; $7E:2780..27BF: Row 1
; $7E:27C0..27FF: Row 2
; $7E:2800..283F: Row 3
$A9:E019 8B          PHB
$A9:E01A A2 E0 C0    LDX #$C0E0  ;\
$A9:E01D A0 40 27    LDY #$2740  ;|
$A9:E020 A9 3F 00    LDA #$003F  ;} $7E:2740..277F = [$B7:C0E0..C11F]
$A9:E023 54 7E B7    MVN B7 7E   ;/
$A9:E026 AB          PLB
$A9:E027 8B          PHB
$A9:E028 A2 E0 C2    LDX #$C2E0  ;\
$A9:E02B A0 80 27    LDY #$2780  ;|
$A9:E02E A9 3F 00    LDA #$003F  ;} $7E:2780..27BF = [$B7:C2E0..C31F]
$A9:E031 54 7E B7    MVN B7 7E   ;/
$A9:E034 AB          PLB
$A9:E035 8B          PHB
$A9:E036 A2 E0 C4    LDX #$C4E0  ;\
$A9:E039 A0 C0 27    LDY #$27C0  ;|
$A9:E03C A9 3F 00    LDA #$003F  ;} $7E:27C0..27FF = [$B7:C4E0..C51F]
$A9:E03F 54 7E B7    MVN B7 7E   ;/
$A9:E042 AB          PLB
$A9:E043 8B          PHB
$A9:E044 A2 E0 C6    LDX #$C6E0  ;\
$A9:E047 A0 00 28    LDY #$2800  ;|
$A9:E04A A9 3F 00    LDA #$003F  ;} $7E:2800..283F = [$B7:C6E0..C71F]
$A9:E04D 54 7E B7    MVN B7 7E   ;/
$A9:E050 AB          PLB
$A9:E051 60          RTS
}


;;; $E052: Corpse rotting initialisation function - skree - enemy parameter 1 = 4 ;;;
{
; $7E:2840..287F: Row 0
; $7E:2880..28BF: Row 1
; $7E:28C0..28FF: Row 2
; $7E:2900..293F: Row 3
$A9:E052 8B          PHB
$A9:E053 A2 C0 C1    LDX #$C1C0  ;\
$A9:E056 A0 40 28    LDY #$2840  ;|
$A9:E059 A9 3F 00    LDA #$003F  ;} $7E:2840..287F = [$B7:C1C0..C1FF]
$A9:E05C 54 7E B7    MVN B7 7E   ;/
$A9:E05F AB          PLB
$A9:E060 8B          PHB
$A9:E061 A2 C0 C3    LDX #$C3C0  ;\
$A9:E064 A0 80 28    LDY #$2880  ;|
$A9:E067 A9 3F 00    LDA #$003F  ;} $7E:2880..28BF = [$B7:C3C0..C3FF]
$A9:E06A 54 7E B7    MVN B7 7E   ;/
$A9:E06D AB          PLB
$A9:E06E 8B          PHB
$A9:E06F A2 C0 C5    LDX #$C5C0  ;\
$A9:E072 A0 C0 28    LDY #$28C0  ;|
$A9:E075 A9 3F 00    LDA #$003F  ;} $7E:28C0..28FF = [$B7:C5C0..C5FF]
$A9:E078 54 7E B7    MVN B7 7E   ;/
$A9:E07B AB          PLB
$A9:E07C 8B          PHB
$A9:E07D A2 C0 C7    LDX #$C7C0  ;\
$A9:E080 A0 00 29    LDY #$2900  ;|
$A9:E083 A9 3F 00    LDA #$003F  ;} $7E:2900..293F = [$B7:C7C0..C7FF]
$A9:E086 54 7E B7    MVN B7 7E   ;/
$A9:E089 AB          PLB
$A9:E08A 60          RTS
}


;;; $E08B: Corpse rotting initialisation function - Mother Brain ;;;
{
; $7E:9000..90DF: Row 0
; $7E:90E0..91BF: Row 1
; $7E:91C0..929F: Row 2
; $7E:92A0..937F: Row 3
; $7E:9380..945F: Row 4
; $7E:9460..953F: Row 5

; $B7:CE00 is the two frames of Mother Brain's corpse side-by-side, this function extracts only the right-side frame (the gaps are blank tiles)
$A9:E08B 8B          PHB
$A9:E08C A2 C0 CE    LDX #$CEC0  ;\
$A9:E08F A0 00 90    LDY #$9000  ;|
$A9:E092 A9 BF 00    LDA #$00BF  ;} $7E:9000..90BF = [$B7:CEC0..CF7F]
$A9:E095 54 7E B7    MVN B7 7E   ;/
$A9:E098 AB          PLB
$A9:E099 8B          PHB
$A9:E09A A2 C0 D0    LDX #$D0C0  ;\
$A9:E09D A0 E0 90    LDY #$90E0  ;|
$A9:E0A0 A9 BF 00    LDA #$00BF  ;} $7E:90E0..919F = [$B7:D0C0..D17F]
$A9:E0A3 54 7E B7    MVN B7 7E   ;/
$A9:E0A6 AB          PLB
$A9:E0A7 8B          PHB
$A9:E0A8 A2 C0 D2    LDX #$D2C0  ;\
$A9:E0AB A0 C0 91    LDY #$91C0  ;|
$A9:E0AE A9 BF 00    LDA #$00BF  ;} $7E:91C0..927F = [$B7:D2C0..D37F]
$A9:E0B1 54 7E B7    MVN B7 7E   ;/
$A9:E0B4 AB          PLB
$A9:E0B5 8B          PHB
$A9:E0B6 A2 C0 D4    LDX #$D4C0  ;\
$A9:E0B9 A0 A0 92    LDY #$92A0  ;|
$A9:E0BC A9 BF 00    LDA #$00BF  ;} $7E:92A0..935F = [$B7:D4C0..D57F]
$A9:E0BF 54 7E B7    MVN B7 7E   ;/
$A9:E0C2 AB          PLB
$A9:E0C3 8B          PHB
$A9:E0C4 A2 C0 D6    LDX #$D6C0  ;\
$A9:E0C7 A0 80 93    LDY #$9380  ;|
$A9:E0CA A9 DF 00    LDA #$00DF  ;} $7E:9380..945F = [$B7:D6C0..D79F]
$A9:E0CD 54 7E B7    MVN B7 7E   ;/
$A9:E0D0 AB          PLB
$A9:E0D1 8B          PHB
$A9:E0D2 A2 C0 D8    LDX #$D8C0  ;\
$A9:E0D5 A0 60 94    LDY #$9460  ;|
$A9:E0D8 A9 DF 00    LDA #$00DF  ;} $7E:9460..953F = [$B7:D8C0..D99F]
$A9:E0DB 54 7E B7    MVN B7 7E   ;/
$A9:E0DE AB          PLB
$A9:E0DF 60          RTS
}
}


;;; $E0E0: Corpse rotting VRAM transfer definitions ;;;
{
; Size, source bank, source address, VRAM address

; Sidehopper - enemy parameter 1 = 0
$A9:E0E0             dw 0060,7E00,2040,7020,
                        00A0,7E00,20A0,7100,
                        00A0,7E00,2140,7200,
                        00A0,7E00,21E0,7300,
                        00A0,7E00,2280,7400,
                        0000

; Sidehopper - enemy parameter 1 = 2
$A9:E10A             dw 0040,7E00,2320,7090,
                        00A0,7E00,23C0,7190,
                        00A0,7E00,2460,7290,
                        00A0,7E00,2500,7390,
                        00A0,7E00,25A0,7490,
                        0000

; Zoomer - enemy parameter 1 = 0
$A9:E134             dw 0060,7E00,2940,7530,
                        0060,7E00,29A0,7630,
                        0000

; Zoomer - enemy parameter 1 = 2
$A9:E146             dw 0060,7E00,2A00,7560,
                        0060,7E00,2A60,7660,
                        0000

; Zoomer - enemy parameter 1 = 4
$A9:E158             dw 0060,7E00,2AC0,7590,
                        0060,7E00,2B20,7690,
                        0000

; Ripper - enemy parameter 1 = 0
$A9:E16A             dw 0060,7E00,2B80,7500,
                        0060,7E00,2BE0,7600,
                        0000

; Ripper - enemy parameter 1 = 2
$A9:E17C             dw 0060,7E00,2C40,75C0,
                        0060,7E00,2CA0,76C0,
                        0000

; Skree - enemy parameter 1 = 0
$A9:E18E             dw 0040,7E00,2640,7150,
                        0040,7E00,2680,7250,
                        0040,7E00,26C0,7350,
                        0040,7E00,2700,7450,
                        0000

; Skree - enemy parameter 1 = 2
$A9:E1B0             dw 0040,7E00,2740,7070,
                        0040,7E00,2780,7170,
                        0040,7E00,27C0,7270,
                        0040,7E00,2800,7370,
                        0000

; Skree - enemy parameter 1 = 4
$A9:E1D2             dw 0040,7E00,2840,70E0,
                        0040,7E00,2880,71E0,
                        0040,7E00,28C0,72E0,
                        0040,7E00,2900,73E0,
                        0000

; Mother Brain
$A9:E1F4             dw 0060,7E00,9040,7A80,
                        00A0,7E00,9100,7B70,
                        00C0,7E00,91C0,7C60,
                        00C0,7E00,92A0,7D60,
                        00E0,7E00,9380,7E60,
                        00E0,7E00,9460,7F60,
                        0000
}


;;; $E226: Corpse rotting tile row offsets ;;;
{
; Torizo
$A9:E226             dw 0000, 0140, 0280, 03C0, 0500, 0640, 0780, 08C0, 0A00, 0B40, 0C80, 0DC0, 0F00

; Sidehopper
$A9:E240             dw 0000, 00A0, 0140, 01E0, 0280, 0320

; Zoomer
$A9:E24C             dw 0000, 0060, 00C0

; Ripper
$A9:E252             dw 0000, 0060, 00C0

; Skree
$A9:E258             dw 0000, 0040, 0080, 00C0, 0100

; Mother Brain
$A9:E262             dw 0000, 00E0, 01C0, 02A0, 0380, 0460, 0540, 0620
}


;;; $E272..EBAB: Corpse rotting rot entry copy/move functions ;;;
{
;;; $E272: Corpse rotting rot entry move function - torizo ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

; Column 0 is only used by rows Ah..Bh
; Column 1 is only used by rows 9..Bh
; Column 2 is only used by rows 2..Bh
; Column 9 is only used by rows 2..Bh
; (See $B7:A800)

$A9:E272 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E275 C9 50 00    CMP #$0050             ;} If [corpse rotting rot entry Y offset] < 50h (tile row Ah): go to BRANCH_COLUMN_1
$A9:E278 90 17       BCC $17    [$E291]     ;/
$A9:E27A C9 5E 00    CMP #$005E             ;\
$A9:E27D 10 0C       BPL $0C    [$E28B]     ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E27F BD 00 20    LDA $2000,x[$7E:2DCA]  ;\
$A9:E282 99 02 20    STA $2002,y[$7E:2DCC]  ;|
$A9:E285 BD 10 20    LDA $2010,x[$7E:2DDA]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E288 99 12 20    STA $2012,y[$7E:2DDC]  ;/

$A9:E28B 9E 00 20    STZ $2000,x[$7E:2DCE]  ;\
$A9:E28E 9E 10 20    STZ $2010,x[$7E:2DDE]  ;} Pixel row at [X] = 0

; BRANCH_COLUMN_1
$A9:E291 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E294 C9 48 00    CMP #$0048             ;} If [corpse rotting rot entry Y offset] < 48h (tile row 9): go to BRANCH_COLUMN_2
$A9:E297 90 17       BCC $17    [$E2B0]     ;/
$A9:E299 C9 5E 00    CMP #$005E             ;\
$A9:E29C 10 0C       BPL $0C    [$E2AA]     ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E29E BD 20 20    LDA $2020,x[$7E:2DEA]  ;\
$A9:E2A1 99 22 20    STA $2022,y[$7E:2DEC]  ;|
$A9:E2A4 BD 30 20    LDA $2030,x[$7E:2DFA]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E2A7 99 32 20    STA $2032,y[$7E:2DFC]  ;/

$A9:E2AA 9E 20 20    STZ $2020,x[$7E:2DEE]  ;\
$A9:E2AD 9E 30 20    STZ $2030,x[$7E:2DFE]  ;} Pixel row at [X] + (1 tile) = 0

; BRANCH_COLUMN_2
$A9:E2B0 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E2B3 C9 10 00    CMP #$0010             ;} If [corpse rotting rot entry Y offset] < 10h (tile row 2): go to BRANCH_COLUMN_3
$A9:E2B6 90 17       BCC $17    [$E2CF]     ;/
$A9:E2B8 C9 5E 00    CMP #$005E             ;\
$A9:E2BB 10 0C       BPL $0C    [$E2C9]     ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E2BD BD 40 20    LDA $2040,x[$7E:2E0A]  ;\
$A9:E2C0 99 42 20    STA $2042,y[$7E:2E0C]  ;|
$A9:E2C3 BD 50 20    LDA $2050,x[$7E:2E1A]  ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E2C6 99 52 20    STA $2052,y[$7E:2E1C]  ;/

$A9:E2C9 9E 40 20    STZ $2040,x[$7E:2E0E]  ;\
$A9:E2CC 9E 50 20    STZ $2050,x[$7E:2E1E]  ;} Pixel row at [X] + (2 tiles) = 0

; BRANCH_COLUMN_3
$A9:E2CF AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E2D2 C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E2D5 10 0C       BPL $0C    [$E2E3]     ;/
$A9:E2D7 BD 60 20    LDA $2060,x[$7E:2E2A]  ;\
$A9:E2DA 99 62 20    STA $2062,y[$7E:2E2C]  ;|
$A9:E2DD BD 70 20    LDA $2070,x[$7E:2E3A]  ;} Pixel row at [Y] + (3 tiles) + (1 pixel row) = pixel row at [X] + (3 tiles)
$A9:E2E0 99 72 20    STA $2072,y[$7E:2E3C]  ;/

$A9:E2E3 9E 60 20    STZ $2060,x[$7E:2E2E]  ;\
$A9:E2E6 9E 70 20    STZ $2070,x[$7E:2E3E]  ;} Pixel row at [X] + (3 tiles) = 0
$A9:E2E9 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E2EC C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E2EF 10 0C       BPL $0C    [$E2FD]     ;/
$A9:E2F1 BD 80 20    LDA $2080,x[$7E:2E4A]  ;\
$A9:E2F4 99 82 20    STA $2082,y[$7E:2E4C]  ;|
$A9:E2F7 BD 90 20    LDA $2090,x[$7E:2E5A]  ;} Pixel row at [Y] + (4 tiles) + (1 pixel row) = pixel row at [X] + (4 tiles)
$A9:E2FA 99 92 20    STA $2092,y[$7E:2E5C]  ;/

$A9:E2FD 9E 80 20    STZ $2080,x[$7E:2E4E]  ;\
$A9:E300 9E 90 20    STZ $2090,x[$7E:2E5E]  ;} Pixel row at [X] + (4 tiles) = 0
$A9:E303 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E306 C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E309 10 0C       BPL $0C    [$E317]     ;/
$A9:E30B BD A0 20    LDA $20A0,x[$7E:2E6A]  ;\
$A9:E30E 99 A2 20    STA $20A2,y[$7E:2E6C]  ;|
$A9:E311 BD B0 20    LDA $20B0,x[$7E:2E7A]  ;} Pixel row at [Y] + (5 tiles) + (1 pixel row) = pixel row at [X] + (5 tiles)
$A9:E314 99 B2 20    STA $20B2,y[$7E:2E7C]  ;/

$A9:E317 9E A0 20    STZ $20A0,x[$7E:2E6E]  ;\
$A9:E31A 9E B0 20    STZ $20B0,x[$7E:2E7E]  ;} Pixel row at [X] + (5 tiles) = 0
$A9:E31D AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E320 C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E323 10 0C       BPL $0C    [$E331]     ;/
$A9:E325 BD C0 20    LDA $20C0,x[$7E:2E8A]  ;\
$A9:E328 99 C2 20    STA $20C2,y[$7E:2E8C]  ;|
$A9:E32B BD D0 20    LDA $20D0,x[$7E:2E9A]  ;} Pixel row at [Y] + (6 tiles) + (1 pixel row) = pixel row at [X] + (6 tiles)
$A9:E32E 99 D2 20    STA $20D2,y[$7E:2E9C]  ;/

$A9:E331 9E C0 20    STZ $20C0,x[$7E:2E8E]  ;\
$A9:E334 9E D0 20    STZ $20D0,x[$7E:2E9E]  ;} Pixel row at [X] + (6 tiles) = 0
$A9:E337 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E33A C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E33D 10 0C       BPL $0C    [$E34B]     ;/
$A9:E33F BD E0 20    LDA $20E0,x[$7E:2EAA]  ;\
$A9:E342 99 E2 20    STA $20E2,y[$7E:2EAC]  ;|
$A9:E345 BD F0 20    LDA $20F0,x[$7E:2EBA]  ;} Pixel row at [Y] + (7 tiles) + (1 pixel row) = pixel row at [X] + (7 tiles)
$A9:E348 99 F2 20    STA $20F2,y[$7E:2EBC]  ;/

$A9:E34B 9E E0 20    STZ $20E0,x[$7E:2EAE]  ;\
$A9:E34E 9E F0 20    STZ $20F0,x[$7E:2EBE]  ;} Pixel row at [X] + (7 tiles) = 0
$A9:E351 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E354 C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E357 10 0C       BPL $0C    [$E365]     ;/
$A9:E359 BD 00 21    LDA $2100,x[$7E:2ECA]  ;\
$A9:E35C 99 02 21    STA $2102,y[$7E:2ECC]  ;|
$A9:E35F BD 10 21    LDA $2110,x[$7E:2EDA]  ;} Pixel row at [Y] + (8 tiles) + (1 pixel row) = pixel row at [X] + (8 tiles)
$A9:E362 99 12 21    STA $2112,y[$7E:2EDC]  ;/

$A9:E365 9E 00 21    STZ $2100,x[$7E:2ECE]  ;\
$A9:E368 9E 10 21    STZ $2110,x[$7E:2EDE]  ;} Pixel row at [X] + (8 tiles) = 0
$A9:E36B AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E36E C9 10 00    CMP #$0010             ;} If [corpse rotting rot entry Y offset] < 10h (tile row 2): return
$A9:E371 90 17       BCC $17    [$E38A]     ;/
$A9:E373 C9 5E 00    CMP #$005E             ;\
$A9:E376 10 0C       BPL $0C    [$E384]     ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E378 BD 20 21    LDA $2120,x[$7E:2EEA]  ;\
$A9:E37B 99 22 21    STA $2122,y[$7E:2EEC]  ;|
$A9:E37E BD 30 21    LDA $2130,x[$7E:2EFA]  ;} Pixel row at [Y] + (9 tiles) + (1 pixel row) = pixel row at [X] + (9 tiles)
$A9:E381 99 32 21    STA $2132,y[$7E:2EFC]  ;/

$A9:E384 9E 20 21    STZ $2120,x[$7E:2EEE]  ;\
$A9:E387 9E 30 21    STZ $2130,x[$7E:2EFE]  ;} Pixel row at [X] + (9 tiles) = 0

$A9:E38A 60          RTS
}


;;; $E38B: Corpse rotting rot entry copy function - torizo ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

; Column 0 is only used by rows Ah..Bh
; Column 1 is only used by rows 9..Bh
; Column 2 is only used by rows 2..Bh
; Column 9 is only used by rows 2..Bh
; (See $B7:A800)

$A9:E38B AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E38E C9 50 00    CMP #$0050             ;} If [corpse rotting rot entry Y offset] >= 50h (tile row Ah):
$A9:E391 90 11       BCC $11    [$E3A4]     ;/
$A9:E393 C9 5E 00    CMP #$005E             ;\
$A9:E396 10 0C       BPL $0C    [$E3A4]     ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E398 BD 00 20    LDA $2000,x[$7E:2DCA]  ;\
$A9:E39B 99 02 20    STA $2002,y[$7E:2DCC]  ;|
$A9:E39E BD 10 20    LDA $2010,x[$7E:2DDA]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E3A1 99 12 20    STA $2012,y[$7E:2DDC]  ;/

$A9:E3A4 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E3A7 C9 48 00    CMP #$0048             ;} If [corpse rotting rot entry Y offset] >= 48h (tile row 9):
$A9:E3AA 90 11       BCC $11    [$E3BD]     ;/
$A9:E3AC C9 5E 00    CMP #$005E             ;\
$A9:E3AF 10 0C       BPL $0C    [$E3BD]     ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E3B1 BD 20 20    LDA $2020,x[$7E:2DEA]  ;\
$A9:E3B4 99 22 20    STA $2022,y[$7E:2DEC]  ;|
$A9:E3B7 BD 30 20    LDA $2030,x[$7E:2DFA]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E3BA 99 32 20    STA $2032,y[$7E:2DFC]  ;/

$A9:E3BD AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E3C0 C9 10 00    CMP #$0010             ;} If [corpse rotting rot entry Y offset] >= 10h (tile row 2):
$A9:E3C3 90 11       BCC $11    [$E3D6]     ;/
$A9:E3C5 C9 5E 00    CMP #$005E             ;\
$A9:E3C8 10 0C       BPL $0C    [$E3D6]     ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E3CA BD 40 20    LDA $2040,x[$7E:2E0A]  ;\
$A9:E3CD 99 42 20    STA $2042,y[$7E:2E0C]  ;|
$A9:E3D0 BD 50 20    LDA $2050,x[$7E:2E1A]  ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E3D3 99 52 20    STA $2052,y[$7E:2E1C]  ;/

$A9:E3D6 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E3D9 C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E3DC 10 0C       BPL $0C    [$E3EA]     ;/
$A9:E3DE BD 60 20    LDA $2060,x[$7E:2E2A]  ;\
$A9:E3E1 99 62 20    STA $2062,y[$7E:2E2C]  ;|
$A9:E3E4 BD 70 20    LDA $2070,x[$7E:2E3A]  ;} Pixel row at [Y] + (3 tiles) + (1 pixel row) = pixel row at [X] + (3 tiles)
$A9:E3E7 99 72 20    STA $2072,y[$7E:2E3C]  ;/

$A9:E3EA AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E3ED C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E3F0 10 0C       BPL $0C    [$E3FE]     ;/
$A9:E3F2 BD 80 20    LDA $2080,x[$7E:2E4A]  ;\
$A9:E3F5 99 82 20    STA $2082,y[$7E:2E4C]  ;|
$A9:E3F8 BD 90 20    LDA $2090,x[$7E:2E5A]  ;} Pixel row at [Y] + (4 tiles) + (1 pixel row) = pixel row at [X] + (4 tiles)
$A9:E3FB 99 92 20    STA $2092,y[$7E:2E5C]  ;/

$A9:E3FE AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E401 C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E404 10 0C       BPL $0C    [$E412]     ;/
$A9:E406 BD A0 20    LDA $20A0,x[$7E:2E6A]  ;\
$A9:E409 99 A2 20    STA $20A2,y[$7E:2E6C]  ;|
$A9:E40C BD B0 20    LDA $20B0,x[$7E:2E7A]  ;} Pixel row at [Y] + (5 tiles) + (1 pixel row) = pixel row at [X] + (5 tiles)
$A9:E40F 99 B2 20    STA $20B2,y[$7E:2E7C]  ;/

$A9:E412 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E415 C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E418 10 0C       BPL $0C    [$E426]     ;/
$A9:E41A BD C0 20    LDA $20C0,x[$7E:2E8A]  ;\
$A9:E41D 99 C2 20    STA $20C2,y[$7E:2E8C]  ;|
$A9:E420 BD D0 20    LDA $20D0,x[$7E:2E9A]  ;} Pixel row at [Y] + (6 tiles) + (1 pixel row) = pixel row at [X] + (6 tiles)
$A9:E423 99 D2 20    STA $20D2,y[$7E:2E9C]  ;/

$A9:E426 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E429 C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E42C 10 0C       BPL $0C    [$E43A]     ;/
$A9:E42E BD E0 20    LDA $20E0,x[$7E:2EAA]  ;\
$A9:E431 99 E2 20    STA $20E2,y[$7E:2EAC]  ;|
$A9:E434 BD F0 20    LDA $20F0,x[$7E:2EBA]  ;} Pixel row at [Y] + (7 tiles) + (1 pixel row) = pixel row at [X] + (7 tiles)
$A9:E437 99 F2 20    STA $20F2,y[$7E:2EBC]  ;/

$A9:E43A AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E43D C9 5E 00    CMP #$005E             ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E440 10 0C       BPL $0C    [$E44E]     ;/
$A9:E442 BD 00 21    LDA $2100,x[$7E:2ECA]  ;\
$A9:E445 99 02 21    STA $2102,y[$7E:2ECC]  ;|
$A9:E448 BD 10 21    LDA $2110,x[$7E:2EDA]  ;} Pixel row at [Y] + (8 tiles) + (1 pixel row) = pixel row at [X] + (8 tiles)
$A9:E44B 99 12 21    STA $2112,y[$7E:2EDC]  ;/

$A9:E44E AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E451 C9 10 00    CMP #$0010             ;} If [corpse rotting rot entry Y offset] >= 10h (tile row 2):
$A9:E454 90 11       BCC $11    [$E467]     ;/
$A9:E456 C9 5E 00    CMP #$005E             ;\
$A9:E459 10 0C       BPL $0C    [$E467]     ;} If [corpse rotting rot entry Y offset] < 5Eh:
$A9:E45B BD 20 21    LDA $2120,x[$7E:2EEA]  ;\
$A9:E45E 99 22 21    STA $2122,y[$7E:2EEC]  ;|
$A9:E461 BD 30 21    LDA $2130,x[$7E:2EFA]  ;} Pixel row at [Y] + (9 tiles) + (1 pixel row) = pixel row at [X] + (9 tiles)
$A9:E464 99 32 21    STA $2132,y[$7E:2EFC]  ;/

$A9:E467 60          RTS
}


;;; $E468: Corpse rotting rot entry move function - sidehopper - enemy parameter 1 = 0 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E468 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E46B C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] < 8 (tile row 1): go to BRANCH_COLUMN_1
$A9:E46E 90 17       BCC $17    [$E487]     ;/
$A9:E470 C9 26 00    CMP #$0026             ;\
$A9:E473 10 0C       BPL $0C    [$E481]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E475 BD 00 20    LDA $2000,x            ;\
$A9:E478 99 02 20    STA $2002,y            ;|
$A9:E47B BD 10 20    LDA $2010,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E47E 99 12 20    STA $2012,y            ;/

$A9:E481 9E 00 20    STZ $2000,x            ;\
$A9:E484 9E 10 20    STZ $2010,x            ;} Pixel row at [X] = 0

; BRANCH_COLUMN_1
$A9:E487 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E48A C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] < 8 (tile row 1): go to BRANCH_COLUMN_2
$A9:E48D 90 17       BCC $17    [$E4A6]     ;/
$A9:E48F C9 26 00    CMP #$0026             ;\
$A9:E492 10 0C       BPL $0C    [$E4A0]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E494 BD 20 20    LDA $2020,x            ;\
$A9:E497 99 22 20    STA $2022,y            ;|
$A9:E49A BD 30 20    LDA $2030,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E49D 99 32 20    STA $2032,y            ;/

$A9:E4A0 9E 20 20    STZ $2020,x            ;\
$A9:E4A3 9E 30 20    STZ $2030,x            ;} Pixel row at [X] + (1 tile) = 0

; BRANCH_COLUMN_2
$A9:E4A6 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E4A9 C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E4AC 10 0C       BPL $0C    [$E4BA]     ;/
$A9:E4AE BD 40 20    LDA $2040,x            ;\
$A9:E4B1 99 42 20    STA $2042,y            ;|
$A9:E4B4 BD 50 20    LDA $2050,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E4B7 99 52 20    STA $2052,y            ;/

$A9:E4BA 9E 40 20    STZ $2040,x            ;\
$A9:E4BD 9E 50 20    STZ $2050,x            ;} Pixel row at [X] + (2 tiles) = 0
$A9:E4C0 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E4C3 C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E4C6 10 0C       BPL $0C    [$E4D4]     ;/
$A9:E4C8 BD 60 20    LDA $2060,x            ;\
$A9:E4CB 99 62 20    STA $2062,y            ;|
$A9:E4CE BD 70 20    LDA $2070,x            ;} Pixel row at [Y] + (3 tiles) + (1 pixel row) = pixel row at [X] + (3 tiles)
$A9:E4D1 99 72 20    STA $2072,y            ;/

$A9:E4D4 9E 60 20    STZ $2060,x            ;\
$A9:E4D7 9E 70 20    STZ $2070,x            ;} Pixel row at [X] + (3 tiles) = 0
$A9:E4DA AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E4DD C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E4E0 10 0C       BPL $0C    [$E4EE]     ;/
$A9:E4E2 BD 80 20    LDA $2080,x            ;\
$A9:E4E5 99 82 20    STA $2082,y            ;|
$A9:E4E8 BD 90 20    LDA $2090,x            ;} Pixel row at [Y] + (4 tiles) + (1 pixel row) = pixel row at [X] + (4 tiles)
$A9:E4EB 99 92 20    STA $2092,y            ;/

$A9:E4EE 9E 80 20    STZ $2080,x            ;\
$A9:E4F1 9E 90 20    STZ $2090,x            ;} Pixel row at [X] + (4 tiles) = 0
$A9:E4F4 60          RTS
}


;;; $E4F5: Corpse rotting rot entry copy function - sidehopper - enemy parameter 1 = 0 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E4F5 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E4F8 C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] >= 8 (tile row 1):
$A9:E4FB 90 11       BCC $11    [$E50E]     ;/
$A9:E4FD C9 26 00    CMP #$0026             ;\
$A9:E500 10 0C       BPL $0C    [$E50E]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E502 BD 00 20    LDA $2000,x            ;\
$A9:E505 99 02 20    STA $2002,y            ;|
$A9:E508 BD 10 20    LDA $2010,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E50B 99 12 20    STA $2012,y            ;/

$A9:E50E AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E511 C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] >= 8 (tile row 1):
$A9:E514 90 11       BCC $11    [$E527]     ;/
$A9:E516 C9 26 00    CMP #$0026             ;\
$A9:E519 10 0C       BPL $0C    [$E527]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E51B BD 20 20    LDA $2020,x            ;\
$A9:E51E 99 22 20    STA $2022,y            ;|
$A9:E521 BD 30 20    LDA $2030,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E524 99 32 20    STA $2032,y            ;/

$A9:E527 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E52A C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E52D 10 0C       BPL $0C    [$E53B]     ;/
$A9:E52F BD 40 20    LDA $2040,x            ;\
$A9:E532 99 42 20    STA $2042,y            ;|
$A9:E535 BD 50 20    LDA $2050,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E538 99 52 20    STA $2052,y            ;/

$A9:E53B AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E53E C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E541 10 0C       BPL $0C    [$E54F]     ;/
$A9:E543 BD 60 20    LDA $2060,x            ;\
$A9:E546 99 62 20    STA $2062,y            ;|
$A9:E549 BD 70 20    LDA $2070,x            ;} Pixel row at [Y] + (3 tiles) + (1 pixel row) = pixel row at [X] + (3 tiles)
$A9:E54C 99 72 20    STA $2072,y            ;/

$A9:E54F AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E552 C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E555 10 0C       BPL $0C    [$E563]     ;/
$A9:E557 BD 80 20    LDA $2080,x            ;\
$A9:E55A 99 82 20    STA $2082,y            ;|
$A9:E55D BD 90 20    LDA $2090,x            ;} Pixel row at [Y] + (4 tiles) + (1 pixel row) = pixel row at [X] + (4 tiles)
$A9:E560 99 92 20    STA $2092,y            ;/

$A9:E563 60          RTS
}


;;; $E564: Corpse rotting rot entry move function - sidehopper - enemy parameter 1 = 2 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E564 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E567 C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E56A 10 0C       BPL $0C    [$E578]     ;/
$A9:E56C BD 20 23    LDA $2320,x            ;\
$A9:E56F 99 22 23    STA $2322,y            ;|
$A9:E572 BD 30 23    LDA $2330,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E575 99 32 23    STA $2332,y            ;/

$A9:E578 9E 20 23    STZ $2320,x            ;\
$A9:E57B 9E 30 23    STZ $2330,x            ;} Pixel row at [X] = 0
$A9:E57E AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E581 C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E584 10 0C       BPL $0C    [$E592]     ;/
$A9:E586 BD 40 23    LDA $2340,x            ;\
$A9:E589 99 42 23    STA $2342,y            ;|
$A9:E58C BD 50 23    LDA $2350,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E58F 99 52 23    STA $2352,y            ;/

$A9:E592 9E 40 23    STZ $2340,x            ;\
$A9:E595 9E 50 23    STZ $2350,x            ;} Pixel row at [X] + (1 tile) = 0
$A9:E598 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E59B C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] < 8 (tile row 1): go to BRANCH_COLUMN_3
$A9:E59E 90 17       BCC $17    [$E5B7]     ;/
$A9:E5A0 C9 26 00    CMP #$0026             ;\
$A9:E5A3 10 0C       BPL $0C    [$E5B1]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E5A5 BD 60 23    LDA $2360,x            ;\
$A9:E5A8 99 62 23    STA $2362,y            ;|
$A9:E5AB BD 70 23    LDA $2370,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E5AE 99 72 23    STA $2372,y            ;/

$A9:E5B1 9E 60 23    STZ $2360,x            ;\
$A9:E5B4 9E 70 23    STZ $2370,x            ;} Pixel row at [X] + (2 tiles) = 0

; BRANCH_COLUMN_3
$A9:E5B7 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E5BA C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] < 8 (tile row 1): go to BRANCH_COLUMN_4
$A9:E5BD 90 17       BCC $17    [$E5D6]     ;/
$A9:E5BF C9 26 00    CMP #$0026             ;\
$A9:E5C2 10 0C       BPL $0C    [$E5D0]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E5C4 BD 80 23    LDA $2380,x            ;\
$A9:E5C7 99 82 23    STA $2382,y            ;|
$A9:E5CA BD 90 23    LDA $2390,x            ;} Pixel row at [Y] + (3 tiles) + (1 pixel row) = pixel row at [X] + (3 tiles)
$A9:E5CD 99 92 23    STA $2392,y            ;/

$A9:E5D0 9E 80 23    STZ $2380,x            ;\
$A9:E5D3 9E 90 23    STZ $2390,x            ;} Pixel row at [X] + (3 tiles) = 0

; BRANCH_COLUMN_4
$A9:E5D6 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E5D9 C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] >= 8 (tile row 1):
$A9:E5DC 90 17       BCC $17    [$E5F5]     ;/
$A9:E5DE C9 26 00    CMP #$0026             ;\
$A9:E5E1 10 0C       BPL $0C    [$E5EF]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E5E3 BD A0 23    LDA $23A0,x            ;\
$A9:E5E6 99 A2 23    STA $23A2,y            ;|
$A9:E5E9 BD B0 23    LDA $23B0,x            ;} Pixel row at [Y] + (4 tiles) + (1 pixel row) = pixel row at [X] + (4 tiles)
$A9:E5EC 99 B2 23    STA $23B2,y            ;/

$A9:E5EF 9E A0 23    STZ $23A0,x            ;\
$A9:E5F2 9E B0 23    STZ $23B0,x            ;} Pixel row at [X] + (4 tiles) = 0

$A9:E5F5 60          RTS
}


;;; $E5F6: Corpse rotting rot entry copy function - sidehopper - enemy parameter 1 = 2 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E5F6 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E5F9 C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E5FC 10 0C       BPL $0C    [$E60A]     ;/
$A9:E5FE BD 20 23    LDA $2320,x            ;\
$A9:E601 99 22 23    STA $2322,y            ;|
$A9:E604 BD 30 23    LDA $2330,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E607 99 32 23    STA $2332,y            ;/

$A9:E60A AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E60D C9 26 00    CMP #$0026             ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E610 10 0C       BPL $0C    [$E61E]     ;/
$A9:E612 BD 40 23    LDA $2340,x            ;\
$A9:E615 99 42 23    STA $2342,y            ;|
$A9:E618 BD 50 23    LDA $2350,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E61B 99 52 23    STA $2352,y            ;/

$A9:E61E AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E621 C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] >= 8 (tile row 1):
$A9:E624 90 11       BCC $11    [$E637]     ;/
$A9:E626 C9 26 00    CMP #$0026             ;\
$A9:E629 10 0C       BPL $0C    [$E637]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E62B BD 60 23    LDA $2360,x            ;\
$A9:E62E 99 62 23    STA $2362,y            ;|
$A9:E631 BD 70 23    LDA $2370,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E634 99 72 23    STA $2372,y            ;/

$A9:E637 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E63A C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] >= 8 (tile row 1):
$A9:E63D 90 11       BCC $11    [$E650]     ;/
$A9:E63F C9 26 00    CMP #$0026             ;\
$A9:E642 10 0C       BPL $0C    [$E650]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E644 BD 80 23    LDA $2380,x            ;\
$A9:E647 99 82 23    STA $2382,y            ;|
$A9:E64A BD 90 23    LDA $2390,x            ;} Pixel row at [Y] + (3 tiles) + (1 pixel row) = pixel row at [X] + (3 tiles)
$A9:E64D 99 92 23    STA $2392,y            ;/

$A9:E650 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E653 C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] >= 8 (tile row 1):
$A9:E656 90 11       BCC $11    [$E669]     ;/
$A9:E658 C9 26 00    CMP #$0026             ;\
$A9:E65B 10 0C       BPL $0C    [$E669]     ;} If [corpse rotting rot entry Y offset] < 26h:
$A9:E65D BD A0 23    LDA $23A0,x            ;\
$A9:E660 99 A2 23    STA $23A2,y            ;|
$A9:E663 BD B0 23    LDA $23B0,x            ;} Pixel row at [Y] + (4 tiles) + (1 pixel row) = pixel row at [X] + (4 tiles)
$A9:E666 99 B2 23    STA $23B2,y            ;/

$A9:E669 60          RTS
}


;;; $E66A: Corpse rotting rot entry move function - zoomer - enemy parameter 1 = 0 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E66A AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E66D C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E670 10 0C       BPL $0C    [$E67E]     ;/
$A9:E672 BD 40 29    LDA $2940,x            ;\
$A9:E675 99 42 29    STA $2942,y            ;|
$A9:E678 BD 50 29    LDA $2950,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E67B 99 52 29    STA $2952,y            ;/

$A9:E67E 9E 40 29    STZ $2940,x            ;\
$A9:E681 9E 50 29    STZ $2950,x            ;} Pixel row at [X] = 0
$A9:E684 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E687 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E68A 10 0C       BPL $0C    [$E698]     ;/
$A9:E68C BD 60 29    LDA $2960,x            ;\
$A9:E68F 99 62 29    STA $2962,y            ;|
$A9:E692 BD 70 29    LDA $2970,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E695 99 72 29    STA $2972,y            ;/

$A9:E698 9E 60 29    STZ $2960,x            ;\
$A9:E69B 9E 70 29    STZ $2970,x            ;} Pixel row at [X] + (1 tile) = 0
$A9:E69E AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E6A1 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E6A4 10 0C       BPL $0C    [$E6B2]     ;/
$A9:E6A6 BD 80 29    LDA $2980,x            ;\
$A9:E6A9 99 82 29    STA $2982,y            ;|
$A9:E6AC BD 90 29    LDA $2990,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E6AF 99 92 29    STA $2992,y            ;/

$A9:E6B2 9E 80 29    STZ $2980,x            ;\
$A9:E6B5 9E 90 29    STZ $2990,x            ;} Pixel row at [X] + (2 tiles) = 0
$A9:E6B8 60          RTS
}


;;; $E6B9: Corpse rotting rot entry copy function - zoomer - enemy parameter 1 = 0 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E6B9 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E6BC C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E6BF 10 0C       BPL $0C    [$E6CD]     ;/
$A9:E6C1 BD 40 29    LDA $2940,x            ;\
$A9:E6C4 99 42 29    STA $2942,y            ;|
$A9:E6C7 BD 50 29    LDA $2950,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E6CA 99 52 29    STA $2952,y            ;/

$A9:E6CD AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E6D0 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E6D3 10 0C       BPL $0C    [$E6E1]     ;/
$A9:E6D5 BD 60 29    LDA $2960,x            ;\
$A9:E6D8 99 62 29    STA $2962,y            ;|
$A9:E6DB BD 70 29    LDA $2970,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E6DE 99 72 29    STA $2972,y            ;/

$A9:E6E1 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E6E4 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E6E7 10 0C       BPL $0C    [$E6F5]     ;/
$A9:E6E9 BD 80 29    LDA $2980,x            ;\
$A9:E6EC 99 82 29    STA $2982,y            ;|
$A9:E6EF BD 90 29    LDA $2990,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E6F2 99 92 29    STA $2992,y            ;/

$A9:E6F5 60          RTS
}


;;; $E6F6: Corpse rotting rot entry move function - zoomer - enemy parameter 1 = 2 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E6F6 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E6F9 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E6FC 10 0C       BPL $0C    [$E70A]     ;/
$A9:E6FE BD 00 2A    LDA $2A00,x[$7E:2A6A]  ;\
$A9:E701 99 02 2A    STA $2A02,y[$7E:2A6C]  ;|
$A9:E704 BD 10 2A    LDA $2A10,x[$7E:2A7A]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E707 99 12 2A    STA $2A12,y[$7E:2A7C]  ;/

$A9:E70A 9E 00 2A    STZ $2A00,x[$7E:2A6E]  ;\
$A9:E70D 9E 10 2A    STZ $2A10,x[$7E:2A7E]  ;} Pixel row at [X] = 0
$A9:E710 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E713 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E716 10 0C       BPL $0C    [$E724]     ;/
$A9:E718 BD 20 2A    LDA $2A20,x[$7E:2A8A]  ;\
$A9:E71B 99 22 2A    STA $2A22,y[$7E:2A8C]  ;|
$A9:E71E BD 30 2A    LDA $2A30,x[$7E:2A9A]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E721 99 32 2A    STA $2A32,y[$7E:2A9C]  ;/

$A9:E724 9E 20 2A    STZ $2A20,x[$7E:2A8E]  ;\
$A9:E727 9E 30 2A    STZ $2A30,x[$7E:2A9E]  ;} Pixel row at [X] + (1 tile) = 0
$A9:E72A AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E72D C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E730 10 0C       BPL $0C    [$E73E]     ;/
$A9:E732 BD 40 2A    LDA $2A40,x[$7E:2AAA]  ;\
$A9:E735 99 42 2A    STA $2A42,y[$7E:2AAC]  ;|
$A9:E738 BD 50 2A    LDA $2A50,x[$7E:2ABA]  ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E73B 99 52 2A    STA $2A52,y[$7E:2ABC]  ;/

$A9:E73E 9E 40 2A    STZ $2A40,x[$7E:2AAE]  ;\
$A9:E741 9E 50 2A    STZ $2A50,x[$7E:2ABE]  ;} Pixel row at [X] + (2 tiles) = 0
$A9:E744 60          RTS
}


;;; $E745: Corpse rotting rot entry copy function - zoomer - enemy parameter 1 = 2 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E745 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E748 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E74B 10 0C       BPL $0C    [$E759]     ;/
$A9:E74D BD 00 2A    LDA $2A00,x[$7E:2A6A]  ;\
$A9:E750 99 02 2A    STA $2A02,y[$7E:2A6C]  ;|
$A9:E753 BD 10 2A    LDA $2A10,x[$7E:2A7A]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E756 99 12 2A    STA $2A12,y[$7E:2A7C]  ;/

$A9:E759 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E75C C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E75F 10 0C       BPL $0C    [$E76D]     ;/
$A9:E761 BD 20 2A    LDA $2A20,x[$7E:2A8A]  ;\
$A9:E764 99 22 2A    STA $2A22,y[$7E:2A8C]  ;|
$A9:E767 BD 30 2A    LDA $2A30,x[$7E:2A9A]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E76A 99 32 2A    STA $2A32,y[$7E:2A9C]  ;/

$A9:E76D AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E770 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E773 10 0C       BPL $0C    [$E781]     ;/
$A9:E775 BD 40 2A    LDA $2A40,x[$7E:2AAA]  ;\
$A9:E778 99 42 2A    STA $2A42,y[$7E:2AAC]  ;|
$A9:E77B BD 50 2A    LDA $2A50,x[$7E:2ABA]  ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E77E 99 52 2A    STA $2A52,y[$7E:2ABC]  ;/

$A9:E781 60          RTS
}


;;; $E782: Corpse rotting rot entry move function - zoomer - enemy parameter 1 = 4 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E782 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E785 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E788 10 0C       BPL $0C    [$E796]     ;/
$A9:E78A BD C0 2A    LDA $2AC0,x            ;\
$A9:E78D 99 C2 2A    STA $2AC2,y            ;|
$A9:E790 BD D0 2A    LDA $2AD0,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E793 99 D2 2A    STA $2AD2,y            ;/

$A9:E796 9E C0 2A    STZ $2AC0,x            ;\
$A9:E799 9E D0 2A    STZ $2AD0,x            ;} Pixel row at [X] = 0
$A9:E79C AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E79F C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E7A2 10 0C       BPL $0C    [$E7B0]     ;/
$A9:E7A4 BD E0 2A    LDA $2AE0,x            ;\
$A9:E7A7 99 E2 2A    STA $2AE2,y            ;|
$A9:E7AA BD F0 2A    LDA $2AF0,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E7AD 99 F2 2A    STA $2AF2,y            ;/

$A9:E7B0 9E E0 2A    STZ $2AE0,x            ;\
$A9:E7B3 9E F0 2A    STZ $2AF0,x            ;} Pixel row at [X] + (1 tile) = 0
$A9:E7B6 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E7B9 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E7BC 10 0C       BPL $0C    [$E7CA]     ;/
$A9:E7BE BD 00 2B    LDA $2B00,x            ;\
$A9:E7C1 99 02 2B    STA $2B02,y            ;|
$A9:E7C4 BD 10 2B    LDA $2B10,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E7C7 99 12 2B    STA $2B12,y            ;/

$A9:E7CA 9E 00 2B    STZ $2B00,x            ;\
$A9:E7CD 9E 10 2B    STZ $2B10,x            ;} Pixel row at [X] + (2 tiles) = 0
$A9:E7D0 60          RTS
}


;;; $E7D1: Corpse rotting rot entry copy function - zoomer - enemy parameter 1 = 4 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E7D1 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E7D4 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E7D7 10 0C       BPL $0C    [$E7E5]     ;/
$A9:E7D9 BD C0 2A    LDA $2AC0,x            ;\
$A9:E7DC 99 C2 2A    STA $2AC2,y            ;|
$A9:E7DF BD D0 2A    LDA $2AD0,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E7E2 99 D2 2A    STA $2AD2,y            ;/

$A9:E7E5 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E7E8 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E7EB 10 0C       BPL $0C    [$E7F9]     ;/
$A9:E7ED BD E0 2A    LDA $2AE0,x            ;\
$A9:E7F0 99 E2 2A    STA $2AE2,y            ;|
$A9:E7F3 BD F0 2A    LDA $2AF0,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E7F6 99 F2 2A    STA $2AF2,y            ;/

$A9:E7F9 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E7FC C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E7FF 10 0C       BPL $0C    [$E80D]     ;/
$A9:E801 BD 00 2B    LDA $2B00,x            ;\
$A9:E804 99 02 2B    STA $2B02,y            ;|
$A9:E807 BD 10 2B    LDA $2B10,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E80A 99 12 2B    STA $2B12,y            ;/

$A9:E80D 60          RTS
}


;;; $E80E: Corpse rotting rot entry move function - ripper - enemy parameter 1 = 0 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E80E AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E811 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E814 10 0C       BPL $0C    [$E822]     ;/
$A9:E816 BD 80 2B    LDA $2B80,x            ;\
$A9:E819 99 82 2B    STA $2B82,y            ;|
$A9:E81C BD 90 2B    LDA $2B90,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E81F 99 92 2B    STA $2B92,y            ;/

$A9:E822 9E 80 2B    STZ $2B80,x            ;\
$A9:E825 9E 90 2B    STZ $2B90,x            ;} Pixel row at [X] = 0
$A9:E828 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E82B C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E82E 10 0C       BPL $0C    [$E83C]     ;/
$A9:E830 BD A0 2B    LDA $2BA0,x            ;\
$A9:E833 99 A2 2B    STA $2BA2,y            ;|
$A9:E836 BD B0 2B    LDA $2BB0,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E839 99 B2 2B    STA $2BB2,y            ;/

$A9:E83C 9E A0 2B    STZ $2BA0,x            ;\
$A9:E83F 9E B0 2B    STZ $2BB0,x            ;} Pixel row at [X] + (1 tile) = 0
$A9:E842 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E845 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E848 10 0C       BPL $0C    [$E856]     ;/
$A9:E84A BD C0 2B    LDA $2BC0,x            ;\
$A9:E84D 99 C2 2B    STA $2BC2,y            ;|
$A9:E850 BD D0 2B    LDA $2BD0,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E853 99 D2 2B    STA $2BD2,y            ;/

$A9:E856 9E C0 2B    STZ $2BC0,x            ;\
$A9:E859 9E D0 2B    STZ $2BD0,x            ;} Pixel row at [X] + (2 tiles) = 0
$A9:E85C 60          RTS
}


;;; $E85D: Corpse rotting rot entry copy function - ripper - enemy parameter 1 = 0 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E85D AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E860 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E863 10 0C       BPL $0C    [$E871]     ;/
$A9:E865 BD 80 2B    LDA $2B80,x            ;\
$A9:E868 99 82 2B    STA $2B82,y            ;|
$A9:E86B BD 90 2B    LDA $2B90,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E86E 99 92 2B    STA $2B92,y            ;/

$A9:E871 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E874 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E877 10 0C       BPL $0C    [$E885]     ;/
$A9:E879 BD A0 2B    LDA $2BA0,x            ;\
$A9:E87C 99 A2 2B    STA $2BA2,y            ;|
$A9:E87F BD B0 2B    LDA $2BB0,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E882 99 B2 2B    STA $2BB2,y            ;/

$A9:E885 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E888 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E88B 10 0C       BPL $0C    [$E899]     ;/
$A9:E88D BD C0 2B    LDA $2BC0,x            ;\
$A9:E890 99 C2 2B    STA $2BC2,y            ;|
$A9:E893 BD D0 2B    LDA $2BD0,x            ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E896 99 D2 2B    STA $2BD2,y            ;/

$A9:E899 60          RTS
}


;;; $E89A: Corpse rotting rot entry move function - ripper - enemy parameter 1 = 2 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E89A AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E89D C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E8A0 10 0C       BPL $0C    [$E8AE]     ;/
$A9:E8A2 BD 40 2C    LDA $2C40,x[$7E:2CAA]  ;\
$A9:E8A5 99 42 2C    STA $2C42,y[$7E:2CAC]  ;|
$A9:E8A8 BD 50 2C    LDA $2C50,x[$7E:2CBA]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E8AB 99 52 2C    STA $2C52,y[$7E:2CBC]  ;/

$A9:E8AE 9E 40 2C    STZ $2C40,x[$7E:2CAE]  ;\
$A9:E8B1 9E 50 2C    STZ $2C50,x[$7E:2CBE]  ;} Pixel row at [X] = 0
$A9:E8B4 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E8B7 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E8BA 10 0C       BPL $0C    [$E8C8]     ;/
$A9:E8BC BD 60 2C    LDA $2C60,x[$7E:2CCA]  ;\
$A9:E8BF 99 62 2C    STA $2C62,y[$7E:2CCC]  ;|
$A9:E8C2 BD 70 2C    LDA $2C70,x[$7E:2CDA]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E8C5 99 72 2C    STA $2C72,y[$7E:2CDC]  ;/

$A9:E8C8 9E 60 2C    STZ $2C60,x[$7E:2CCE]  ;\
$A9:E8CB 9E 70 2C    STZ $2C70,x[$7E:2CDE]  ;} Pixel row at [X] + (1 tile) = 0
$A9:E8CE AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E8D1 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E8D4 10 0C       BPL $0C    [$E8E2]     ;/
$A9:E8D6 BD 80 2C    LDA $2C80,x[$7E:2CEA]  ;\
$A9:E8D9 99 82 2C    STA $2C82,y[$7E:2CEC]  ;|
$A9:E8DC BD 90 2C    LDA $2C90,x[$7E:2CFA]  ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E8DF 99 92 2C    STA $2C92,y[$7E:2CFC]  ;/

$A9:E8E2 9E 80 2C    STZ $2C80,x[$7E:2CEE]  ;\
$A9:E8E5 9E 90 2C    STZ $2C90,x[$7E:2CFE]  ;} Pixel row at [X] + (2 tiles) = 0
$A9:E8E8 60          RTS
}


;;; $E8E9: Corpse rotting rot entry copy function - ripper - enemy parameter 1 = 2 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E8E9 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E8EC C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E8EF 10 0C       BPL $0C    [$E8FD]     ;/
$A9:E8F1 BD 40 2C    LDA $2C40,x[$7E:2CAA]  ;\
$A9:E8F4 99 42 2C    STA $2C42,y[$7E:2CAC]  ;|
$A9:E8F7 BD 50 2C    LDA $2C50,x[$7E:2CBA]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E8FA 99 52 2C    STA $2C52,y[$7E:2CBC]  ;/

$A9:E8FD AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E900 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E903 10 0C       BPL $0C    [$E911]     ;/
$A9:E905 BD 60 2C    LDA $2C60,x[$7E:2CCA]  ;\
$A9:E908 99 62 2C    STA $2C62,y[$7E:2CCC]  ;|
$A9:E90B BD 70 2C    LDA $2C70,x[$7E:2CDA]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E90E 99 72 2C    STA $2C72,y[$7E:2CDC]  ;/

$A9:E911 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E914 C9 0E 00    CMP #$000E             ;} If [corpse rotting rot entry Y offset] < Eh:
$A9:E917 10 0C       BPL $0C    [$E925]     ;/
$A9:E919 BD 80 2C    LDA $2C80,x[$7E:2CEA]  ;\
$A9:E91C 99 82 2C    STA $2C82,y[$7E:2CEC]  ;|
$A9:E91F BD 90 2C    LDA $2C90,x[$7E:2CFA]  ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:E922 99 92 2C    STA $2C92,y[$7E:2CFC]  ;/

$A9:E925 60          RTS
}


;;; $E926: Corpse rotting rot entry move function - skree - enemy parameter 1 = 0 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E926 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E929 C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:E92C 10 0C       BPL $0C    [$E93A]     ;/
$A9:E92E BD 40 26    LDA $2640,x            ;\
$A9:E931 99 42 26    STA $2642,y            ;|
$A9:E934 BD 50 26    LDA $2650,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E937 99 52 26    STA $2652,y            ;/

$A9:E93A 9E 40 26    STZ $2640,x            ;\
$A9:E93D 9E 50 26    STZ $2650,x            ;} Pixel row at [X] = 0
$A9:E940 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E943 C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:E946 10 0C       BPL $0C    [$E954]     ;/
$A9:E948 BD 60 26    LDA $2660,x            ;\
$A9:E94B 99 62 26    STA $2662,y            ;|
$A9:E94E BD 70 26    LDA $2670,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E951 99 72 26    STA $2672,y            ;/

$A9:E954 9E 60 26    STZ $2660,x            ;\
$A9:E957 9E 70 26    STZ $2670,x            ;} Pixel row at [X] + (1 tile) = 0
$A9:E95A 60          RTS
}


;;; $E95B: Corpse rotting rot entry copy function - skree - enemy parameter 1 = 0 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E95B AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E95E C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:E961 10 0C       BPL $0C    [$E96F]     ;/
$A9:E963 BD 40 26    LDA $2640,x            ;\
$A9:E966 99 42 26    STA $2642,y            ;|
$A9:E969 BD 50 26    LDA $2650,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E96C 99 52 26    STA $2652,y            ;/

$A9:E96F AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E972 C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:E975 10 0C       BPL $0C    [$E983]     ;/
$A9:E977 BD 60 26    LDA $2660,x            ;\
$A9:E97A 99 62 26    STA $2662,y            ;|
$A9:E97D BD 70 26    LDA $2670,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E980 99 72 26    STA $2672,y            ;/

$A9:E983 60          RTS
}


;;; $E984: Corpse rotting rot entry move function - skree - enemy parameter 1 = 2 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E984 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E987 C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:E98A 10 0C       BPL $0C    [$E998]     ;/
$A9:E98C BD 40 27    LDA $2740,x[$7E:280A]  ;\
$A9:E98F 99 42 27    STA $2742,y[$7E:280C]  ;|
$A9:E992 BD 50 27    LDA $2750,x[$7E:281A]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E995 99 52 27    STA $2752,y[$7E:281C]  ;/

$A9:E998 9E 40 27    STZ $2740,x[$7E:280E]  ;\
$A9:E99B 9E 50 27    STZ $2750,x[$7E:281E]  ;} Pixel row at [X] = 0
$A9:E99E AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E9A1 C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:E9A4 10 0C       BPL $0C    [$E9B2]     ;/
$A9:E9A6 BD 60 27    LDA $2760,x[$7E:282A]  ;\
$A9:E9A9 99 62 27    STA $2762,y[$7E:282C]  ;|
$A9:E9AC BD 70 27    LDA $2770,x[$7E:283A]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E9AF 99 72 27    STA $2772,y[$7E:283C]  ;/

$A9:E9B2 9E 60 27    STZ $2760,x[$7E:282E]  ;\
$A9:E9B5 9E 70 27    STZ $2770,x[$7E:283E]  ;} Pixel row at [X] + (1 tile) = 0
$A9:E9B8 60          RTS
}


;;; $E9B9: Corpse rotting rot entry copy function - skree - enemy parameter 1 = 2 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E9B9 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E9BC C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:E9BF 10 0C       BPL $0C    [$E9CD]     ;/
$A9:E9C1 BD 40 27    LDA $2740,x[$7E:280A]  ;\
$A9:E9C4 99 42 27    STA $2742,y[$7E:280C]  ;|
$A9:E9C7 BD 50 27    LDA $2750,x[$7E:281A]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E9CA 99 52 27    STA $2752,y[$7E:281C]  ;/

$A9:E9CD AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:E9D0 C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:E9D3 10 0C       BPL $0C    [$E9E1]     ;/
$A9:E9D5 BD 60 27    LDA $2760,x[$7E:282A]  ;\
$A9:E9D8 99 62 27    STA $2762,y[$7E:282C]  ;|
$A9:E9DB BD 70 27    LDA $2770,x[$7E:283A]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:E9DE 99 72 27    STA $2772,y[$7E:283C]  ;/

$A9:E9E1 60          RTS
}


;;; $E9E2: Corpse rotting rot entry move function - skree - enemy parameter 1 = 4 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:E9E2 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E9E5 C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:E9E8 10 0C       BPL $0C    [$E9F6]     ;/
$A9:E9EA BD 40 28    LDA $2840,x            ;\
$A9:E9ED 99 42 28    STA $2842,y            ;|
$A9:E9F0 BD 50 28    LDA $2850,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:E9F3 99 52 28    STA $2852,y            ;/

$A9:E9F6 9E 40 28    STZ $2840,x            ;\
$A9:E9F9 9E 50 28    STZ $2850,x            ;} Pixel row at [X] = 0
$A9:E9FC AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:E9FF C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:EA02 10 0C       BPL $0C    [$EA10]     ;/
$A9:EA04 BD 60 28    LDA $2860,x            ;\
$A9:EA07 99 62 28    STA $2862,y            ;|
$A9:EA0A BD 70 28    LDA $2870,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:EA0D 99 72 28    STA $2872,y            ;/

$A9:EA10 9E 60 28    STZ $2860,x            ;\
$A9:EA13 9E 70 28    STZ $2870,x            ;} Pixel row at [X] + (1 tile) = 0
$A9:EA16 60          RTS
}


;;; $EA17: Corpse rotting rot entry copy function - skree - enemy parameter 1 = 4 ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

$A9:EA17 AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:EA1A C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:EA1D 10 0C       BPL $0C    [$EA2B]     ;/
$A9:EA1F BD 40 28    LDA $2840,x            ;\
$A9:EA22 99 42 28    STA $2842,y            ;|
$A9:EA25 BD 50 28    LDA $2850,x            ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:EA28 99 52 28    STA $2852,y            ;/

$A9:EA2B AD 02 88    LDA $8802  [$A9:8802]  ;\
$A9:EA2E C9 1E 00    CMP #$001E             ;} If [corpse rotting rot entry Y offset] < 1Eh:
$A9:EA31 10 0C       BPL $0C    [$EA3F]     ;/
$A9:EA33 BD 60 28    LDA $2860,x            ;\
$A9:EA36 99 62 28    STA $2862,y            ;|
$A9:EA39 BD 70 28    LDA $2870,x            ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:EA3C 99 72 28    STA $2872,y            ;/

$A9:EA3F 60          RTS
}


;;; $EA40: Corpse rotting rot entry move function - Mother Brain ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Clears pixel row in dest and copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

; Column 0 is only used by rows 2..5
; Column 1 is only used by rows 1..5
; Column 5 is only used by rows 1..5
; Column 6 is only used by rows 4..5
; (See $B7:CE00 right side)

$A9:EA40 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EA43 C9 10 00    CMP #$0010             ;} If [corpse rotting rot entry Y offset] < 10h (tile row 2): go to BRANCH_COLUMN_1
$A9:EA46 90 17       BCC $17    [$EA5F]     ;/
$A9:EA48 C9 2E 00    CMP #$002E             ;\
$A9:EA4B 10 0C       BPL $0C    [$EA59]     ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EA4D BD 00 90    LDA $9000,x[$7E:946A]  ;\
$A9:EA50 99 02 90    STA $9002,y[$7E:946C]  ;|
$A9:EA53 BD 10 90    LDA $9010,x[$7E:947A]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:EA56 99 12 90    STA $9012,y[$7E:947C]  ;/

$A9:EA59 9E 00 90    STZ $9000,x[$7E:946E]  ;\
$A9:EA5C 9E 10 90    STZ $9010,x[$7E:947E]  ;} Pixel row at [X] = 0

; BRANCH_COLUMN_1
$A9:EA5F AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EA62 C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] < 8 (tile row 1): go to BRANCH_COLUMN_2
$A9:EA65 90 17       BCC $17    [$EA7E]     ;/
$A9:EA67 C9 2E 00    CMP #$002E             ;\
$A9:EA6A 10 0C       BPL $0C    [$EA78]     ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EA6C BD 20 90    LDA $9020,x[$7E:948A]  ;\
$A9:EA6F 99 22 90    STA $9022,y[$7E:948C]  ;|
$A9:EA72 BD 30 90    LDA $9030,x[$7E:949A]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:EA75 99 32 90    STA $9032,y[$7E:949C]  ;/

$A9:EA78 9E 20 90    STZ $9020,x[$7E:948E]  ;\
$A9:EA7B 9E 30 90    STZ $9030,x[$7E:949E]  ;} Pixel row at [X] + (1 tile) = 0

; BRANCH_COLUMN_2
$A9:EA7E AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EA81 C9 2E 00    CMP #$002E             ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EA84 10 0C       BPL $0C    [$EA92]     ;/
$A9:EA86 BD 40 90    LDA $9040,x[$7E:94AA]  ;\
$A9:EA89 99 42 90    STA $9042,y[$7E:94AC]  ;|
$A9:EA8C BD 50 90    LDA $9050,x[$7E:94BA]  ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:EA8F 99 52 90    STA $9052,y[$7E:94BC]  ;/

$A9:EA92 9E 40 90    STZ $9040,x[$7E:94AE]  ;\
$A9:EA95 9E 50 90    STZ $9050,x[$7E:94BE]  ;} Pixel row at [X] + (2 tiles) = 0
$A9:EA98 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EA9B C9 2E 00    CMP #$002E             ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EA9E 10 0C       BPL $0C    [$EAAC]     ;/
$A9:EAA0 BD 60 90    LDA $9060,x[$7E:94CA]  ;\
$A9:EAA3 99 62 90    STA $9062,y[$7E:94CC]  ;|
$A9:EAA6 BD 70 90    LDA $9070,x[$7E:94DA]  ;} Pixel row at [Y] + (3 tiles) + (1 pixel row) = pixel row at [X] + (3 tiles)
$A9:EAA9 99 72 90    STA $9072,y[$7E:94DC]  ;/

$A9:EAAC 9E 60 90    STZ $9060,x[$7E:94CE]  ;\
$A9:EAAF 9E 70 90    STZ $9070,x[$7E:94DE]  ;} Pixel row at [X] + (3 tiles) = 0
$A9:EAB2 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EAB5 C9 2E 00    CMP #$002E             ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EAB8 10 0C       BPL $0C    [$EAC6]     ;/
$A9:EABA BD 80 90    LDA $9080,x[$7E:94EA]  ;\
$A9:EABD 99 82 90    STA $9082,y[$7E:94EC]  ;|
$A9:EAC0 BD 90 90    LDA $9090,x[$7E:94FA]  ;} Pixel row at [Y] + (4 tiles) + (1 pixel row) = pixel row at [X] + (4 tiles)
$A9:EAC3 99 92 90    STA $9092,y[$7E:94FC]  ;/

$A9:EAC6 9E 80 90    STZ $9080,x[$7E:94EE]  ;\
$A9:EAC9 9E 90 90    STZ $9090,x[$7E:94FE]  ;} Pixel row at [X] + (4 tiles) = 0
$A9:EACC AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EACF C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] < 8 (tile row 1): go to BRANCH_COLUMN_6
$A9:EAD2 90 17       BCC $17    [$EAEB]     ;/
$A9:EAD4 C9 2E 00    CMP #$002E             ;\
$A9:EAD7 10 0C       BPL $0C    [$EAE5]     ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EAD9 BD A0 90    LDA $90A0,x[$7E:950A]  ;\
$A9:EADC 99 A2 90    STA $90A2,y[$7E:950C]  ;|
$A9:EADF BD B0 90    LDA $90B0,x[$7E:951A]  ;} Pixel row at [Y] + (5 tiles) + (1 pixel row) = pixel row at [X] + (5 tiles)
$A9:EAE2 99 B2 90    STA $90B2,y[$7E:951C]  ;/

$A9:EAE5 9E A0 90    STZ $90A0,x[$7E:950E]  ;\
$A9:EAE8 9E B0 90    STZ $90B0,x[$7E:951E]  ;} Pixel row at [X] + (5 tiles) = 0

; BRANCH_COLUMN_6
$A9:EAEB AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EAEE C9 20 00    CMP #$0020             ;} If [corpse rotting rot entry Y offset] < 20h (tile row 4): return
$A9:EAF1 90 17       BCC $17    [$EB0A]     ;/
$A9:EAF3 C9 2E 00    CMP #$002E             ;\
$A9:EAF6 10 0C       BPL $0C    [$EB04]     ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EAF8 BD C0 90    LDA $90C0,x[$7E:952A]  ;\
$A9:EAFB 99 C2 90    STA $90C2,y[$7E:952C]  ;|
$A9:EAFE BD D0 90    LDA $90D0,x[$7E:953A]  ;} Pixel row at [Y] + (6 tiles) + (1 pixel row) = pixel row at [X] + (6 tiles)
$A9:EB01 99 D2 90    STA $90D2,y[$7E:953C]  ;/

$A9:EB04 9E C0 90    STZ $90C0,x[$7E:952E]  ;\
$A9:EB07 9E D0 90    STZ $90D0,x[$7E:953E]  ;} Pixel row at [X] + (6 tiles) = 0

$A9:EB0A 60          RTS
}


;;; $EB0B: Corpse rotting rot entry copy function - Mother Brain ;;;
{
;; Parameters:
;;     X: Source pixel row tile data offset
;;     Y: Destination pixel row tile data offset

; DB must be $7E
; Copies a pixel row from source to one pixel down in dest

; Tile data calculations:
;     Tiles are 20h bytes
;
;     Pixel (x, y) of tile at pointer p is:
;           ([p + y * 2]       >> 7 - x & 1)
;         | ([p + y * 2 + 1]   >> 7 - x & 1) << 1
;         | ([p + y * 2 + 10h] >> 7 - x & 1) << 2
;         | ([p + y * 2 + 11h] >> 7 - x & 1) << 3
;
;     Hence, pixel row y of tile at pointer p is the bytes
;         [p + y * 2], [p + y * 2 + 1], [p + y * 2 + 10h], [p + y * 2 + 11h]

; Column 0 is only used by rows 2..5
; Column 1 is only used by rows 1..5
; Column 5 is only used by rows 1..5
; Column 6 is only used by rows 4..5
; (See $B7:CE00 right side)

$A9:EB0B AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EB0E C9 10 00    CMP #$0010             ;} If [corpse rotting rot entry Y offset] >= 10h (tile row 2):
$A9:EB11 90 11       BCC $11    [$EB24]     ;/
$A9:EB13 C9 2E 00    CMP #$002E             ;\
$A9:EB16 10 0C       BPL $0C    [$EB24]     ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EB18 BD 00 90    LDA $9000,x[$7E:946A]  ;\
$A9:EB1B 99 02 90    STA $9002,y[$7E:946C]  ;|
$A9:EB1E BD 10 90    LDA $9010,x[$7E:947A]  ;} Pixel row at [Y] + (1 pixel row) = pixel row at [X]
$A9:EB21 99 12 90    STA $9012,y[$7E:947C]  ;/

$A9:EB24 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EB27 C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] >= 8 (tile row 1):
$A9:EB2A 90 11       BCC $11    [$EB3D]     ;/
$A9:EB2C C9 2E 00    CMP #$002E             ;\
$A9:EB2F 10 0C       BPL $0C    [$EB3D]     ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EB31 BD 20 90    LDA $9020,x[$7E:948A]  ;\
$A9:EB34 99 22 90    STA $9022,y[$7E:948C]  ;|
$A9:EB37 BD 30 90    LDA $9030,x[$7E:949A]  ;} Pixel row at [Y] + (1 tile) + (1 pixel row) = pixel row at [X] + (1 tile)
$A9:EB3A 99 32 90    STA $9032,y[$7E:949C]  ;/

$A9:EB3D AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EB40 C9 2E 00    CMP #$002E             ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EB43 10 0C       BPL $0C    [$EB51]     ;/
$A9:EB45 BD 40 90    LDA $9040,x[$7E:94AA]  ;\
$A9:EB48 99 42 90    STA $9042,y[$7E:94AC]  ;|
$A9:EB4B BD 50 90    LDA $9050,x[$7E:94BA]  ;} Pixel row at [Y] + (2 tiles) + (1 pixel row) = pixel row at [X] + (2 tiles)
$A9:EB4E 99 52 90    STA $9052,y[$7E:94BC]  ;/

$A9:EB51 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EB54 C9 2E 00    CMP #$002E             ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EB57 10 0C       BPL $0C    [$EB65]     ;/
$A9:EB59 BD 60 90    LDA $9060,x[$7E:94CA]  ;\
$A9:EB5C 99 62 90    STA $9062,y[$7E:94CC]  ;|
$A9:EB5F BD 70 90    LDA $9070,x[$7E:94DA]  ;} Pixel row at [Y] + (3 tiles) + (1 pixel row) = pixel row at [X] + (3 tiles)
$A9:EB62 99 72 90    STA $9072,y[$7E:94DC]  ;/

$A9:EB65 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EB68 C9 2E 00    CMP #$002E             ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EB6B 10 0C       BPL $0C    [$EB79]     ;/
$A9:EB6D BD 80 90    LDA $9080,x[$7E:94EA]  ;\
$A9:EB70 99 82 90    STA $9082,y[$7E:94EC]  ;|
$A9:EB73 BD 90 90    LDA $9090,x[$7E:94FA]  ;} Pixel row at [Y] + (4 tiles) + (1 pixel row) = pixel row at [X] + (4 tiles)
$A9:EB76 99 92 90    STA $9092,y[$7E:94FC]  ;/

$A9:EB79 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EB7C C9 08 00    CMP #$0008             ;} If [corpse rotting rot entry Y offset] >= 8 (tile row 1):
$A9:EB7F 90 11       BCC $11    [$EB92]     ;/
$A9:EB81 C9 2E 00    CMP #$002E             ;\
$A9:EB84 10 0C       BPL $0C    [$EB92]     ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EB86 BD A0 90    LDA $90A0,x[$7E:950A]  ;\
$A9:EB89 99 A2 90    STA $90A2,y[$7E:950C]  ;|
$A9:EB8C BD B0 90    LDA $90B0,x[$7E:951A]  ;} Pixel row at [Y] + (5 tiles) + (1 pixel row) = pixel row at [X] + (5 tiles)
$A9:EB8F 99 B2 90    STA $90B2,y[$7E:951C]  ;/

$A9:EB92 AD 02 88    LDA $8802  [$7E:8802]  ;\
$A9:EB95 C9 20 00    CMP #$0020             ;} If [corpse rotting rot entry Y offset] >= 20h (tile row 4):
$A9:EB98 90 11       BCC $11    [$EBAB]     ;/
$A9:EB9A C9 2E 00    CMP #$002E             ;\
$A9:EB9D 10 0C       BPL $0C    [$EBAB]     ;} If [corpse rotting rot entry Y offset] < 2Eh:
$A9:EB9F BD C0 90    LDA $90C0,x[$7E:952A]  ;\
$A9:EBA2 99 C2 90    STA $90C2,y[$7E:952C]  ;|
$A9:EBA5 BD D0 90    LDA $90D0,x[$7E:953A]  ;} Pixel row at [Y] + (6 tiles) + (1 pixel row) = pixel row at [X] + (6 tiles)
$A9:EBA8 99 D2 90    STA $90D2,y[$7E:953C]  ;/

$A9:EBAB 60          RTS
}
}


;;; $EBAC: Palette - enemy $EDBF (sidehopper, part 2) ;;;
{
; This palette is loaded by the enemy set of the Shitroid room, but that palette is overwritten by Shitroid init AI, making this effectively unused
$A9:EBAC             dw 3800, 4EDA, 3A35, 2990, 14EB, 77E9, 5706, 3A44, 1D62, 2FBA, 22F6, 1A33, 1170, 08CD, 639F, 0446
}


;;; $EBCC: Palettes - sidehopper corpse being drained ;;;
{
$A9:EBCC             dw 3800,7FFF,56E0,3180,18C0,6BC0,5EC0,4A20,35A0,7FFF,039C,0237,00D1,03FF,0237,00D1
$A9:EBEC             dw 3800,77DF,52C5,2962,14A1,67A5,56A4,4203,3182,77FF,0F7B,01F4,00CF,037B,01F3,00AF
$A9:EC0C             dw 3800,6FBF,4ECA,2544,10A2,5F8B,4E88,3DE6,2D85,6FFF,1B5A,05D1,00CC,06D6,0190,00AC
$A9:EC2C             dw 3800,6BBF,4AAE,1D05,0C83,5B50,466C,35EA,2567,67FF,2B39,058F,00AA,0652,014C,048A
$A9:EC4C             dw 3800,639F,46B3,18E7,0884,5336,3E50,31CD,216A,5FFF,3718,096C,00A7,09AD,00E9,0487
$A9:EC6C             dw 3800,5B7F,4298,10C9,0465,4F1B,3634,29B0,1D4C,57FF,42F7,0929,00A5,0929,00A5,0465
$A9:EC8C             dw 3800,57FF,42F7,0929,00A5,7FFF,4231,0043,4B3F,42DB,3678,2E14,2190,192C,0CC9,0465
}


;;; $ECAC..ED24: Dead monster instruction lists ;;;
{
;;; $ECAC: Instruction list - sidehopper corpse - alive - hopping ;;;
{
$A9:ECAC             dx 0002,EE3C,
                        0004,EE61,
                        0005,EE3C,
                        0030,EE61,
                        0005,EE3C,
                        0004,EE61,
                        0005,EE3C,
                        0004,EE61,
                        ECD0,       ; End hop
                        812F        ; Sleep
}


;;; $ECD0: Instruction - end hop ;;;
{
;; Parameters:
;;     X: Enemy index
$A9:ECD0 5A          PHY
$A9:ECD1 A0 10 D9    LDY #$D910             ; Enemy function = $D910 (start idling)
$A9:ECD4 BF 10 78 7E LDA $7E7810,x[$7E:7850];\
$A9:ECD8 F0 03       BEQ $03    [$ECDD]     ;} If [enemy drained palette index] != 0:
$A9:ECDA A0 08 DA    LDY #$DA08             ; Enemy function = $DA08 (being drained)

$A9:ECDD 98          TYA
$A9:ECDE 9D A8 0F    STA $0FA8,x[$7E:0FE8]
$A9:ECE1 7A          PLY
$A9:ECE2 6B          RTL
}


;;; $ECE3: Instruction list - sidehopper corpse - alive - idle ;;;
{
$A9:ECE3             dx 0001,EE86,
                        812F        ; Sleep
}


;;; $ECE9: Instruction list - sidehopper corpse - alive - corpse ;;;
{
$A9:ECE9             dx 0001,ED25,
                        812F        ; Sleep
}


;;; $ECEF: Instruction list - sidehopper corpse - dead ;;;
{
$A9:ECEF             dx 0001,ED4F,
                        812F        ; Sleep
}


;;; $ECF5: Instruction list - zoomer corpse - enemy parameter 1 = 0 ;;;
{
$A9:ECF5             dx 0001,ED79,
                        812F        ; Sleep
}


;;; $ECFB: Instruction list - zoomer corpse - enemy parameter 1 = 2 ;;;
{
$A9:ECFB             dx 0001,ED85,
                        812F        ; Sleep
}


;;; $ED01: Instruction list - zoomer corpse - enemy parameter 1 = 4 ;;;
{
$A9:ED01             dx 0001,ED91,
                        812F        ; Sleep
}


;;; $ED07: Instruction list - ripper corpse - enemy parameter 1 = 0 ;;;
{
$A9:ED07             dx 0001,ED9D,
                        812F        ; Sleep
}


;;; $ED0D: Instruction list - ripper corpse - enemy parameter 1 = 2 ;;;
{
$A9:ED0D             dx 0001,EDA9,
                        812F        ; Sleep
}


;;; $ED13: Instruction list - skree corpse - enemy parameter 1 = 0 ;;;
{
$A9:ED13             dx 0001,EDB5,
                        812F        ; Sleep
}


;;; $ED19: Instruction list - skree corpse - enemy parameter 1 = 2 ;;;
{
$A9:ED19             dx 0001,EDCB,
                        812F        ; Sleep
}


;;; $ED1F: Instruction list - skree corpse - enemy parameter 1 = 4 ;;;
{
$A9:ED1F             dx 0001,EDE1,
                        812F        ; Sleep
}
}


;;; $ED25: Dead monster spritemaps ;;;
{
; Sidehopper corpse - corpse
$A9:ED25             dx 0008, C20C,02,6130, C20C,F2,6110, C3FC,FA,2123, C3FC,EA,2103, C3F4,FA,2122, C3F4,EA,2102, C3E4,02,2130, C3E4,F2,2110
$A9:ED4F             dx 0008, C20C,FE,6129, C20C,EE,6109, C3F4,06,213B, C3F4,F6,211B, C3FC,06,213C, C3FC,F6,211C, C3E4,FE,2129, C3E4,EE,2109

; Zoomer corpse
$A9:ED79             dx 0002, C3FC,F8,2154, C3F4,F8,2153
$A9:ED85             dx 0002, C3FC,F8,2157, C3F4,F8,2156
$A9:ED91             dx 0002, C3FC,F8,215A, C3F4,F8,2159

; Ripper corpse
$A9:ED9D             dx 0002, C3FC,F8,2151, C3F4,F8,2150
$A9:EDA9             dx 0002, C3FC,F8,215D, C3F4,F8,215C

; Skree corpse
$A9:EDB5             dx 0004, C3FC,04,7135, C3FC,F4,7115, C3F4,04,3135, C3F4,F4,3115
$A9:EDCB             dx 0004, C3FC,04,7127, C3FC,F4,7107, C3F4,04,3127, C3F4,F4,3107
$A9:EDE1             dx 0004, C3FC,04,712E, C3FC,F4,710E, C3F4,04,312E, C3F4,F4,310E

; Unused
$A9:EDF7             dx 000A, 000C,FC,2F0C, 0014,FC,2F0D, 0004,FC,2F0B, 01F4,FC,2F0D, 01EC,FC,2F0C, 01E4,FC,2F0B, 0008,FC,2F06, 0000,FC,2F05, 01F8,FC,2F01, 01F0,FC,2F00
$A9:EE2B             dx 0003, 0004,FA,2F0D, 01FC,FA,2F0C, 01F4,FA,2F0B

; Sidehopper corpse - alive
$A9:EE3C             dx 0007, 0000,EC,2171, 01F8,EC,2170, C20C,04,6176, C3E4,04,2176, C208,F4,6174, C3E8,F4,2174, C3F8,F4,2180
$A9:EE61             dx 0007, C3F8,F6,2182, C20D,04,617A, C3E3,04,217A, C208,F4,6178, C3E8,F4,2178, 0000,EE,2171, 01F8,EE,2170
$A9:EE86             dx 000B, 0010,0C,6172, 0008,0C,6173, 01F0,0C,2173, 01E8,0C,2172, C208,FC,617E, C3E8,FC,217E, C208,EC,617C, C3E8,EC,217C, 0000,E3,2171, 01F8,E3,2170, C3F8,EB,2180
}
}


;;; $EEBF: Unused. A = [Y] / [A] ;;;
{
$A9:EEBF 8C 04 42    STY $4204
$A9:EEC2 E2 20       SEP #$20
$A9:EEC4 8D 06 42    STA $4206
$A9:EEC7 C2 20       REP #$20
$A9:EEC9 EB          XBA
$A9:EECA EB          XBA
$A9:EECB EA          NOP
$A9:EECC EA          NOP
$A9:EECD AD 14 42    LDA $4214
$A9:EED0 60          RTS
}


;;; $EED1..FB6F: Shitroid ;;;
{
;;; $EED1: Check for enemy collision with enemy ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Other enemy index
;; Returns:
;;     Carry: Clear if collision, set otherwise
$A9:EED1 B9 82 0F    LDA $0F82,y[$7E:0FC2]  ;\
$A9:EED4 18          CLC                    ;|
$A9:EED5 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;|
$A9:EED8 1A          INC A                  ;|
$A9:EED9 85 12       STA $12    [$7E:0012]  ;|
$A9:EEDB B9 7A 0F    LDA $0F7A,y[$7E:0FBA]  ;|
$A9:EEDE 38          SEC                    ;|
$A9:EEDF FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;} If |[enemy [Y] X position] - [enemy [X] X position]| > [enemy [Y] X radius] + [enemy [X] X radius]: return carry set
$A9:EEE2 10 04       BPL $04    [$EEE8]     ;|
$A9:EEE4 49 FF FF    EOR #$FFFF             ;|
$A9:EEE7 1A          INC A                  ;|
                                            ;|
$A9:EEE8 C5 12       CMP $12    [$7E:0012]  ;|
$A9:EEEA B0 19       BCS $19    [$EF05]     ;/
$A9:EEEC B9 84 0F    LDA $0F84,y[$7E:0FC4]  ;\
$A9:EEEF 18          CLC                    ;|
$A9:EEF0 7D 84 0F    ADC $0F84,x[$7E:0F84]  ;|
$A9:EEF3 1A          INC A                  ;|
$A9:EEF4 85 12       STA $12    [$7E:0012]  ;|
$A9:EEF6 B9 7E 0F    LDA $0F7E,y[$7E:0FBE]  ;|
$A9:EEF9 38          SEC                    ;} If |[enemy [Y] Y position] - [enemy [X] Y position]| > [enemy [Y] Y radius] + [enemy [X] Y radius]: return carry set
$A9:EEFA FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;} Else: return carry clear
$A9:EEFD 10 04       BPL $04    [$EF03]     ;|
$A9:EEFF 49 FF FF    EOR #$FFFF             ;|
$A9:EF02 1A          INC A                  ;|
                                            ;|
$A9:EF03 C5 12       CMP $12    [$7E:0012]  ;/

$A9:EF05 6B          RTL
}


;;; $EF06: Check for enemy collision with rectangle ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $12: Rectangle centre X position
;;     $14: Rectangle centre Y position
;;     $16: Rectangle X radius
;;     $18: Rectangle Y radius
;; Returns:
;;     Carry: Clear if collision, set otherwise
$A9:EF06 A5 16       LDA $16    [$7E:0016]  ;\
$A9:EF08 18          CLC                    ;|
$A9:EF09 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;} $1A = [$16] + [enemy X radius] + 1
$A9:EF0C 1A          INC A                  ;|
$A9:EF0D 85 1A       STA $1A    [$7E:001A]  ;/
$A9:EF0F A5 12       LDA $12    [$7E:0012]  ;\
$A9:EF11 38          SEC                    ;|
$A9:EF12 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$A9:EF15 10 04       BPL $04    [$EF1B]     ;|
$A9:EF17 49 FF FF    EOR #$FFFF             ;} If |[$12] - [enemy X position]| >= [$1A]: return carry set
$A9:EF1A 1A          INC A                  ;|
                                            ;|
$A9:EF1B C5 1A       CMP $1A    [$7E:001A]  ;|
$A9:EF1D B0 17       BCS $17    [$EF36]     ;/
$A9:EF1F A5 18       LDA $18    [$7E:0018]  ;\
$A9:EF21 18          CLC                    ;|
$A9:EF22 7D 84 0F    ADC $0F84,x[$7E:0F84]  ;} $1A = [$18] + [enemy Y radius] + 1
$A9:EF25 1A          INC A                  ;|
$A9:EF26 85 1A       STA $1A    [$7E:001A]  ;/
$A9:EF28 A5 14       LDA $14    [$7E:0014]  ;\
$A9:EF2A 38          SEC                    ;|
$A9:EF2B FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;|
$A9:EF2E 10 04       BPL $04    [$EF34]     ;|
$A9:EF30 49 FF FF    EOR #$FFFF             ;} If |[$14] - [enemy Y position]| >= [$1A]: set carry, else clear carry
$A9:EF33 1A          INC A                  ;|
                                            ;|
$A9:EF34 C5 1A       CMP $1A    [$7E:001A]  ;/

$A9:EF36 6B          RTL
}


;;; $EF37: Initialisation AI - enemy $EEBF (Shitroid) ;;;
{
$A9:EF37 8B          PHB                    ;\
$A9:EF38 F4 7E 7E    PEA $7E7E              ;|
$A9:EF3B AB          PLB                    ;|
$A9:EF3C AB          PLB                    ;|
$A9:EF3D A9 00 00    LDA #$0000             ;|
$A9:EF40 A2 FE 0F    LDX #$0FFE             ;|
                                            ;} $7E:2000..2FFF = 0 (corpse rotting graphics)
$A9:EF43 9D 00 20    STA $2000,x[$7E:2FFE]  ;|
$A9:EF46 CA          DEX                    ;|
$A9:EF47 CA          DEX                    ;|
$A9:EF48 10 F9       BPL $F9    [$EF43]     ;|
$A9:EF4A AB          PLB                    ;|
$A9:EF4B AE 54 0E    LDX $0E54  [$7E:0E54]  ;/
$A9:EF4E BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A9:EF51 09 00 30    ORA #$3000             ;} Set enemy to process instructions and block plasma beam
$A9:EF54 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A9:EF57 A9 00 04    LDA #$0400             ;\
$A9:EF5A 9D 96 0F    STA $0F96,x[$7E:0F96]  ;} Enemy palette index = 400h (palette 2)
$A9:EF5D A9 0E F9    LDA #$F90E             ;\
$A9:EF60 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $F90E (normal)
$A9:EF63 A9 01 00    LDA #$0001             ;\
$A9:EF66 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A9:EF69 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A9:EF6C A9 E6 EF    LDA #$EFE6             ; Enemy function = $EFE6 (wait for camera)
$A9:EF6F 2C 11 09    BIT $0911  [$7E:0911]  ;\
$A9:EF72 10 0C       BPL $0C    [$EF80]     ;} If [layer 1 X position] < 0 (door transition from the left):
$A9:EF74 BD 86 0F    LDA $0F86,x            ;\
$A9:EF77 09 00 05    ORA #$0500             ;} Set enemy as intangible and invisible
$A9:EF7A 9D 86 0F    STA $0F86,x            ;/
$A9:EF7D A9 DF EF    LDA #$EFDF             ; Enemy function = $EFDF (disappeared)

$A9:EF80 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A9:EF83 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy X velocity = 0
$A9:EF86 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ; Enemy Y velocity = 0
$A9:EF89 A9 0A 00    LDA #$000A             ;\
$A9:EF8C 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy palette handler delay = Ah
$A9:EF8F 9E B6 0F    STZ $0FB6,x[$7E:0FB6]  ; Disable Shitroid contact reaction
$A9:EF92 A0 C6 F8    LDY #$F8C6             ;\
$A9:EF95 A2 20 01    LDX #$0120             ;|
$A9:EF98 A9 10 00    LDA #$0010             ;} Sprite target palette 1 = [$F8C6..E5] (sidehopper)
$A9:EF9B 22 F6 D2 A9 JSL $A9D2F6[$A9:D2F6]  ;/
$A9:EF9F A0 E6 F8    LDY #$F8E6             ;\
$A9:EFA2 A2 40 01    LDX #$0140             ;|
$A9:EFA5 A9 10 00    LDA #$0010             ;} Sprite target palette 2 = [$F8E6..F905] (Shitroid)
$A9:EFA8 22 F6 D2 A9 JSL $A9D2F6[$A9:D2F6]  ;/
$A9:EFAC A0 A6 F8    LDY #$F8A6             ;\
$A9:EFAF A2 E0 01    LDX #$01E0             ;|
$A9:EFB2 A9 10 00    LDA #$0010             ;} Sprite target palette 7 = [$F8A6..C5] (dead monsters)
$A9:EFB5 22 F6 D2 A9 JSL $A9D2F6[$A9:D2F6]  ;/
$A9:EFB9 6B          RTL
}


;;; $EFBA: Power bomb reaction - enemy $EEBF (Shitroid) ;;;
{
$A9:EFBA AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:EFBD BD B6 0F    LDA $0FB6,x            ;\
$A9:EFC0 F0 03       BEQ $03    [$EFC5]     ;} If contact reaction enabled:
$A9:EFC2 20 CB F3    JSR $F3CB  [$A9:F3CB]  ; Signal Shitroid to leave
}


;;; $EFC5: Main AI - enemy $EEBF (Shitroid) ;;;
{
$A9:EFC5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:EFC8 A9 FF 7F    LDA #$7FFF             ;\
$A9:EFCB 9D 8C 0F    STA $0F8C,x[$7E:0F8C]  ;} Enemy health = 7FFFh
$A9:EFCE FC A8 0F    JSR ($0FA8,x)[$A9:EFE6]; Execute [enemy function]
$A9:EFD1 22 EF C3 A9 JSL $A9C3EF[$A9:C3EF]  ; Move enemy according to enemy velocity
$A9:EFD5 AF 00 C4 7E LDA $7EC400[$7E:C400]  ;\
$A9:EFD9 D0 03       BNE $03    [$EFDE]     ;} If [palette change numerator] = 0:
$A9:EFDB 20 77 F6    JSR $F677  [$A9:F677]  ; Handle normal Shitroid palette

$A9:EFDE 6B          RTL
}


;;; $EFDF: Shitroid function - disappeared ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:EFDF 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy X velocity = 0
$A9:EFE2 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ; Enemy Y velocity = 0
$A9:EFE5 60          RTS
}


;;; $EFE6: Shitroid function - wait for camera ;;;
{
$A9:EFE6 AD 11 09    LDA $0911  [$7E:0911]  ;\
$A9:EFE9 C9 01 02    CMP #$0201             ;} If [layer 1 X position] <= 200h:
$A9:EFEC 10 3C       BPL $3C    [$F02A]     ;/
$A9:EFEE A9 00 02    LDA #$0200             ;\
$A9:EFF1 8D 11 09    STA $0911  [$7E:0911]  ;} Layer 1 X position = 200h
$A9:EFF4 AF 20 CD 7E LDA $7ECD20[$7E:CD20]  ;\
$A9:EFF8 29 FF 00    AND #$00FF             ;} Scroll 1 = red
$A9:EFFB 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;/
$A9:EFFF AF 22 CD 7E LDA $7ECD22[$7E:CD22]  ;\
$A9:F003 29 FF 00    AND #$00FF             ;} Scroll 3 = red
$A9:F006 8F 22 CD 7E STA $7ECD22[$7E:CD22]  ;/
$A9:F00A 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:F00E             dx 30,03,B767          ;} Create Shitroid invisible wall at block (30h, 3)
$A9:F012 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:F016             dx 1F,03,B767          ;} Create Shitroid invisible wall at block (1Fh, 3)
$A9:F01A AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F01D A9 2B F0    LDA #$F02B             ;\
$A9:F020 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F02B
$A9:F023 A9 01 00    LDA #$0001             ;\
$A9:F026 9F 08 78 7E STA $7E7808,x[$7E:7808];} Enable Shitroid cry sound effect

$A9:F02A 60          RTS
}


;;; $F02B: Shitroid function - let sidehopper live for a bit ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F02B A9 37 F0    LDA #$F037             ;\
$A9:F02E 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F037
$A9:F031 A9 D0 01    LDA #$01D0             ;\
$A9:F034 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function timer = 1D0h
}


;;; $F037: Shitroid function - queue battle music ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F037 DE B2 0F    DEC $0FB2,x[$7E:0FB2]  ; Decrement enemy function timer
$A9:F03A 10 30       BPL $30    [$F06C]     ; If [enemy function timer] < 0:
$A9:F03C A9 05 00    LDA #$0005             ;\
$A9:F03F 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track
$A9:F043 A9 49 F0    LDA #$F049             ;\
$A9:F046 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F049
}


;;; $F049: Shitroid function - rush to middle of room ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F049 A9 48 02    LDA #$0248             ;\
$A9:F04C 85 12       STA $12    [$7E:0012]  ;} $12 = 248h
$A9:F04E A9 4A 00    LDA #$004A             ;\
$A9:F051 85 14       STA $14    [$7E:0014]  ;} $14 = 4Ah
$A9:F053 A0 0F 00    LDY #$000F             ; Y = Fh (fastest acceleration)
$A9:F056 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:F059 A9 01 00    LDA #$0001             ;\
$A9:F05C 85 16       STA $16    [$7E:0016]  ;|
$A9:F05E 85 18       STA $18    [$7E:0018]  ;} Check for enemy collision with 1x1 px^2 region around ([$12], [$14])
$A9:F060 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:F064 B0 06       BCS $06    [$F06C]     ; If collision:
$A9:F066 A9 6D F0    LDA #$F06D             ;\
$A9:F069 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F06D

$A9:F06C 60          RTS
}


;;; $F06D: Shitroid function - rush to sidehopper ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F06D BD BA 0F    LDA $0FBA,x[$7E:0FBA]  ;\
$A9:F070 85 12       STA $12    [$7E:0012]  ;} $12 = [sidehopper X position]
$A9:F072 BD BE 0F    LDA $0FBE,x[$7E:0FBE]  ;\
$A9:F075 18          CLC                    ;|
$A9:F076 69 E0 FF    ADC #$FFE0             ;} $14 = [sidehopper Y position] - 20h
$A9:F079 85 14       STA $14    [$7E:0014]  ;/
$A9:F07B A0 0F 00    LDY #$000F             ; Y = Fh (fastest acceleration)
$A9:F07E 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:F081 8A          TXA                    ;\
$A9:F082 18          CLC                    ;|
$A9:F083 69 40 00    ADC #$0040             ;} Check for enemy collision with sidehopper
$A9:F086 A8          TAY                    ;|
$A9:F087 22 D1 EE A9 JSL $A9EED1[$A9:EED1]  ;/
$A9:F08B B0 06       BCS $06    [$F093]     ; If collision:
$A9:F08D A9 94 F0    LDA #$F094             ;\
$A9:F090 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F094

$A9:F093 60          RTS
}


;;; $F094: Shitroid function - latch onto sidehopper ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F094 BD BA 0F    LDA $0FBA,x[$7E:0FBA]  ;\
$A9:F097 85 12       STA $12    [$7E:0012]  ;} $12 = [sidehopper X position]
$A9:F099 BD BE 0F    LDA $0FBE,x[$7E:0FBE]  ;\
$A9:F09C 18          CLC                    ;|
$A9:F09D 69 E0 FF    ADC #$FFE0             ;} $14 = [sidehopper Y position] - 20h
$A9:F0A0 85 14       STA $14    [$7E:0014]  ;/
$A9:F0A2 A9 00 02    LDA #$0200             ; A = 200h (acceleration)
$A9:F0A5 20 A6 F5    JSR $F5A6  [$A9:F5A6]  ; Accelerate Shitroid towards ([$12], [$14])
$A9:F0A8 B0 01       BCS $01    [$F0AB]     ; If not reached target:
$A9:F0AA 60          RTS                    ; Return

$A9:F0AB 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy X velocity = 0
$A9:F0AE 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ; Enemy Y velocity = 0
$A9:F0B1 BD BA 0F    LDA $0FBA,x[$7E:0FBA]  ;\
$A9:F0B4 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy X position = [side hopper X position]
$A9:F0B7 BD BE 0F    LDA $0FBE,x[$7E:0FBE]  ;\
$A9:F0BA 18          CLC                    ;|
$A9:F0BB 69 E0 FF    ADC #$FFE0             ;} Enemy Y position = [side hopper Y position] - 20h
$A9:F0BE 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A9:F0C1 A9 24 F9    LDA #$F924             ;\
$A9:F0C4 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $F924 (latched on)
$A9:F0C7 A9 01 00    LDA #$0001             ;\
$A9:F0CA 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A9:F0CD 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A9:F0D0 A9 E6 F0    LDA #$F0E6             ;\
$A9:F0D3 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F0E6
$A9:F0D6 A9 01 00    LDA #$0001             ;\
$A9:F0D9 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy palette handler delay = 1
$A9:F0DC 9E B6 0F    STZ $0FB6,x[$7E:0FB6]  ; Disable Shitroid contact reaction
$A9:F0DF A9 40 01    LDA #$0140             ;\
$A9:F0E2 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function timer = 140h
$A9:F0E5 60          RTS
}


;;; $F0E6: Shitroid function - draining sidehopper ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F0E6 BD A4 0F    LDA $0FA4,x[$7E:0FA4]  ;\
$A9:F0E9 29 06 00    AND #$0006             ;} Y = [enemy frame counter] / 2 % 4 * 2
$A9:F0EC A8          TAY                    ;/
$A9:F0ED B9 BB 93    LDA $93BB,y[$A9:93BB]  ;\
$A9:F0F0 7D BA 0F    ADC $0FBA,x[$7E:0FBA]  ;} Enemy X position = [sidehopper X position] + [$93BB + [Y]] (shake X offset)
$A9:F0F3 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A9:F0F6 B9 C3 93    LDA $93C3,y[$A9:93C3]  ;\
$A9:F0F9 18          CLC                    ;|
$A9:F0FA 7D BE 0F    ADC $0FBE,x[$7E:0FBE]  ;|
$A9:F0FD 18          CLC                    ;} Enemy Y position = [sidehopper Y position] + [$93C3 + [Y]] (shake Y offset)
$A9:F0FE 69 E0 FF    ADC #$FFE0             ;|
$A9:F101 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A9:F104 DE B2 0F    DEC $0FB2,x[$7E:0FB2]  ; Decrement enemy function timer
$A9:F107 D0 1B       BNE $1B    [$F124]     ; If [enemy function timer] = 0:
$A9:F109 A9 25 F1    LDA #$F125             ;\
$A9:F10C 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F125
$A9:F10F A9 06 F9    LDA #$F906             ;\
$A9:F112 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $F906 (finish draining)
$A9:F115 A9 01 00    LDA #$0001             ;\
$A9:F118 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A9:F11B 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A9:F11E A9 0A 00    LDA #$000A             ;\
$A9:F121 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy palette handler delay = Ah

$A9:F124 60          RTS
}


;;; $F125: Shitroid function - make sidehopper rottable ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F125 A9 01 00    LDA #$0001             ;\
$A9:F128 8F 50 78 7E STA $7E7850[$7E:7850]  ;} Sidehopper drained palette index = 1
$A9:F12C A9 38 F1    LDA #$F138             ;\
$A9:F12F 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F138
$A9:F132 A9 C0 00    LDA #$00C0             ;\
$A9:F135 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function timer = C0h
}


;;; $F138: Shitroid function - move up and unlock camera ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F138 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A9:F13B 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$A9:F13D A9 68 00    LDA #$0068             ;\
$A9:F140 85 14       STA $14    [$7E:0014]  ;} $14 = 68h
$A9:F142 A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:F145 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:F148 DE B2 0F    DEC $0FB2,x[$7E:0FB2]  ; Decrement enemy function timer
$A9:F14B 10 32       BPL $32    [$F17F]     ; If [enemy function timer] < 0:
$A9:F14D A9 80 F1    LDA #$F180             ;\
$A9:F150 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F180
$A9:F153 A9 01 00    LDA #$0001             ;\
$A9:F156 9D B6 0F    STA $0FB6,x[$7E:0FB6]  ;} Enable Shitroid contact reaction
$A9:F159 AF 20 CD 7E LDA $7ECD20[$7E:CD20]  ;\
$A9:F15D 09 00 01    ORA #$0100             ;} Scroll 1 = blue
$A9:F160 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;/
$A9:F164 AF 22 CD 7E LDA $7ECD22[$7E:CD22]  ;\
$A9:F168 09 00 01    ORA #$0100             ;} Scroll 3 = blue
$A9:F16B 8F 22 CD 7E STA $7ECD22[$7E:CD22]  ;/
$A9:F16F 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:F173             dx 30,03,B763          ;} Clear Shitroid invisible wall at block (30h, 3)
$A9:F177 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A9:F17B             dx 1F,03,B763          ;} Clear Shitroid invisible wall at block (1Fh, 3)

$A9:F17F 60          RTS
}


;;; $F180: Shitroid function - stare down Samus ;;;
{
;; Parameters:
;;     X: 0. Enemy index

; Shitroid moves towards Samus' X position and usually Y position 50h
; With a 0.78125% chance, Shitroid will move towards Samus' Y position instead for 20h frames
; 0.78125% chance per frame ~= 37.5% chance per second
; Shitroid will latch onto Samus when one of:
;     their X positions have been close for a while
;     they touch and Samus wasn't spin jumping (see enemy touch)
;     Samus X position < 200h
$A9:F180 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A9:F183 38          SEC                    ;|
$A9:F184 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$A9:F187 10 04       BPL $04    [$F18D]     ;|
$A9:F189 49 FF FF    EOR #$FFFF             ;} If |[enemy X position] - [Samus X position]| < 8:
$A9:F18C 1A          INC A                  ;|
                                            ;|
$A9:F18D C9 08 00    CMP #$0008             ;|
$A9:F190 B0 09       BCS $09    [$F19B]     ;/
$A9:F192 BF 04 78 7E LDA $7E7804,x          ;\
$A9:F196 69 02 00    ADC #$0002             ;} Enemy proximity counter += 2
$A9:F199 80 0F       BRA $0F    [$F1AA]

$A9:F19B BF 04 78 7E LDA $7E7804,x[$7E:7804];\ Else (|[enemy X position] - [Samus X position]| >= 8):
$A9:F19F F0 09       BEQ $09    [$F1AA]     ;|
$A9:F1A1 38          SEC                    ;|
$A9:F1A2 E9 01 00    SBC #$0001             ;} Enemy proximity counter = max(0, [enemy proximity counter] - 1)
$A9:F1A5 10 03       BPL $03    [$F1AA]     ;|
$A9:F1A7 A9 00 00    LDA #$0000             ;/

$A9:F1AA 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A9:F1AE C9 00 01    CMP #$0100             ;\
$A9:F1B1 B0 3D       BCS $3D    [$F1F0]     ;} If [enemy proximity counter] >= 100h: go to BRANCH_DONE
$A9:F1B3 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F1B6 C9 00 02    CMP #$0200             ;} If [Samus X position] < 200h: go to BRANCH_DONE
$A9:F1B9 30 35       BMI $35    [$F1F0]     ;/
$A9:F1BB BF 02 78 7E LDA $7E7802,x[$7E:7802];\
$A9:F1BF F0 0A       BEQ $0A    [$F1CB]     ;} If [enemy aggro timer] != 0:
$A9:F1C1 3A          DEC A                  ;\
$A9:F1C2 9F 02 78 7E STA $7E7802,x          ;} Decrement enemy aggro timer
$A9:F1C6 AC FA 0A    LDY $0AFA  [$7E:0AFA]  ; Y = [Samus Y position]
$A9:F1C9 80 15       BRA $15    [$F1E0]
                                            ; Else ([enemy aggro timer] = 0):
$A9:F1CB A0 50 00    LDY #$0050             ; Y = 50h
$A9:F1CE AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:F1D1 29 FF 0F    AND #$0FFF             ;|
$A9:F1D4 C9 E0 0F    CMP #$0FE0             ;} If [random number] & FFFh >= FE0h:
$A9:F1D7 90 07       BCC $07    [$F1E0]     ;/
$A9:F1D9 A9 20 00    LDA #$0020             ;\
$A9:F1DC 9F 02 78 7E STA $7E7802,x          ;} Enemy aggro timer = 20h

$A9:F1E0 84 14       STY $14    [$7E:0014]  ; $14 = [Y]
$A9:F1E2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F1E5 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus X position]
$A9:F1E7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F1EA A0 0A 00    LDY #$000A             ; Y = Ah (fast acceleration)
$A9:F1ED 4C 51 F4    JMP $F451  [$A9:F451]  ; Go to gradually accelerate towards point ([$12], [$14])

; BRANCH_DONE
$A9:F1F0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F1F3 A9 FA F1    LDA #$F1FA             ;\
$A9:F1F6 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F1FA
$A9:F1F9 60          RTS
}


;;; $F1FA: Shitroid function - latch onto Samus ;;;
{
;; Parameters:
;;     X: 0. Enemy index

; See enemy touch
$A9:F1FA AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F1FD 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus X position]
$A9:F1FF AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A9:F202 38          SEC                    ;|
$A9:F203 E9 20 00    SBC #$0020             ;} $14 = [Samus Y position] - 20h
$A9:F206 85 14       STA $14    [$7E:0014]  ;/
$A9:F208 A0 0F 00    LDY #$000F             ; Y = Fh (fastest acceleration)
$A9:F20B 4C 51 F4    JMP $F451  [$A9:F451]  ; Go to gradually accelerate towards point ([$12], [$14])
}


;;; $F20E: Shitroid function - start draining Samus ;;;
{
$A9:F20E A9 12 00    LDA #$0012             ;\
$A9:F211 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - enable Samus blue flashing
$A9:F215 A9 1B F2    LDA #$F21B             ;\
$A9:F218 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Enemy function = $F21B
}


;;; $F21B: Shitroid function - draining Samus ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F21B AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$A9:F21E C9 02 00    CMP #$0002             ;} If [Samus health] < 2: go to BRANCH_DONE
$A9:F221 90 43       BCC $43    [$F266]     ;/
$A9:F223 A9 08 00    LDA #$0008             ;\
$A9:F226 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 8
$A9:F229 A9 05 00    LDA #$0005             ;\
$A9:F22C 8D D2 0C    STA $0CD2  [$7E:0CD2]  ;} Bomb counter = 5
$A9:F22F A9 02 00    LDA #$0002             ;\
$A9:F232 8D 66 0A    STA $0A66  [$7E:0A66]  ;} Samus X speed divisor = 2
$A9:F235 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$A9:F238 C9 04 00    CMP #$0004             ;} If [Samus Y speed] >= 4:
$A9:F23B 30 06       BMI $06    [$F243]     ;/
$A9:F23D A9 02 00    LDA #$0002             ;\
$A9:F240 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;} Samus Y speed = 2

$A9:F243 BD A4 0F    LDA $0FA4,x[$7E:0FA4]  ;\
$A9:F246 29 06 00    AND #$0006             ;} Y = [enemy frame counter] / 2 % 4 * 2
$A9:F249 A8          TAY                    ;/
$A9:F24A B9 BB 93    LDA $93BB,y[$A9:93BD]  ;\
$A9:F24D 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;} Enemy X position = [Samus X position] + [$93BB + [Y]] (shake X offset)
$A9:F250 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A9:F253 B9 C3 93    LDA $93C3,y[$A9:93C5]  ;\
$A9:F256 18          CLC                    ;|
$A9:F257 69 EC FF    ADC #$FFEC             ;|
$A9:F25A 18          CLC                    ;} Enemy Y position = [Samus Y position] - 14h + [$93C3 + [Y]] (shake Y offset)
$A9:F25B 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;|
$A9:F25E 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A9:F261 22 60 C5 A9 JSL $A9C560[$A9:C560]  ; Damage Samus due to Shitroid
$A9:F265 60          RTS                    ; Return

; BRANCH_DONE
$A9:F266 9C 66 0A    STZ $0A66  [$7E:0A66]  ; Samus X speed divisor = 0
$A9:F269 9C D2 0C    STZ $0CD2  [$7E:0CD2]  ; Bomb counter = 0
$A9:F26C A9 A2 F2    LDA #$F2A2             ;\
$A9:F26F 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F2A2
$A9:F272 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy X velocity = 0
$A9:F275 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ; Enemy Y velocity = 0
$A9:F278 A9 06 F9    LDA #$F906             ;\
$A9:F27B 22 53 C4 A9 JSL $A9C453[$A9:C453]  ;} Set enemy instruction list to $F906 (finish draining)
$A9:F27F A9 0A 00    LDA #$000A             ;\
$A9:F282 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy palette handler delay = Ah
$A9:F285 A9 13 00    LDA #$0013             ;\
$A9:F288 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - disable Samus blue flashing
$A9:F28C A9 00 00    LDA #$0000             ;\
$A9:F28F 22 AD E4 91 JSL $91E4AD[$91:E4AD]  ;} Let drained Samus fall
$A9:F293 A9 00 00    LDA #$0000             ;\
$A9:F296 9F 08 78 7E STA $7E7808,x[$7E:7808];} Disable Shitroid cry sound effect
$A9:F29A A9 07 00    LDA #$0007             ;\
$A9:F29D 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 2 music track
$A9:F2A1 60          RTS
}


;;; $F2A2: Shitroid function - start heel realisation ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F2A2 A9 AE F2    LDA #$F2AE             ;\
$A9:F2A5 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F2AE
$A9:F2A8 A9 78 00    LDA #$0078             ;\
$A9:F2AB 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function timer = 120
}


;;; $F2AE: Shitroid function - heel realisation ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F2AE DE B2 0F    DEC $0FB2,x[$7E:0FB2]  ; Decrement enemy function timer
$A9:F2B1 30 01       BMI $01    [$F2B4]     ; If [enemy function timer] >= 0:
$A9:F2B3 60          RTS                    ; Return

$A9:F2B4 A9 C0 F2    LDA #$F2C0             ;\
$A9:F2B7 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F2C0
$A9:F2BA A9 C0 00    LDA #$00C0             ;\
$A9:F2BD 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function timer = C0h
}


;;; $F2C0: Shitroid function - back off guiltily ;;;
{
$A9:F2C0 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F2C3 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus X position]
$A9:F2C5 A9 68 00    LDA #$0068             ;\
$A9:F2C8 85 14       STA $14    [$7E:0014]  ;} $14 = 68h
$A9:F2CA AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F2CD A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:F2D0 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:F2D3 DE B2 0F    DEC $0FB2,x[$7E:0FB2]  ; Decrement enemy function timer
$A9:F2D6 30 01       BMI $01    [$F2D9]     ; If [enemy function timer] >= 0:
$A9:F2D8 60          RTS                    ; Return

$A9:F2D9 A9 7D 00    LDA #$007D             ;\
$A9:F2DC 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 7Dh, sound library 2, max queued sounds allowed = 6 (Shitroid feels guilty)
$A9:F2E0 A9 FB F2    LDA #$F2FB             ;\
$A9:F2E3 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F2FB
$A9:F2E6 A9 58 00    LDA #$0058             ;\
$A9:F2E9 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function timer = 58h
$A9:F2EC A9 24 F9    LDA #$F924             ;\
$A9:F2EF 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $F924 (latched on)
$A9:F2F2 A9 01 00    LDA #$0001             ;\
$A9:F2F5 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A9:F2F8 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
}


;;; $F2FB: Shitroid function - go left guiltily ;;;
{
$A9:F2FB AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F2FE 18          CLC                    ;|
$A9:F2FF 69 C0 FF    ADC #$FFC0             ;} $12 = [Samus X position] - 40h
$A9:F302 85 12       STA $12    [$7E:0012]  ;/
$A9:F304 A9 64 00    LDA #$0064             ;\
$A9:F307 85 14       STA $14    [$7E:0014]  ;} $14 = 64h
$A9:F309 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F30C A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:F30F 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:F312 DE B2 0F    DEC $0FB2,x[$7E:0FB2]  ; Decrement enemy function timer
$A9:F315 30 01       BMI $01    [$F318]     ; If [enemy function timer] >= 0:
$A9:F317 60          RTS                    ; Return

$A9:F318 A9 24 F3    LDA #$F324             ;\
$A9:F31B 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F324
$A9:F31E A9 58 00    LDA #$0058             ;\
$A9:F321 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function timer = 58h
}


;;; $F324: Shitroid function - go right guiltily ;;;
{
$A9:F324 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F327 18          CLC                    ;|
$A9:F328 69 60 00    ADC #$0060             ;} $12 = [Samus X position] + 60h
$A9:F32B 85 12       STA $12    [$7E:0012]  ;/
$A9:F32D A9 68 00    LDA #$0068             ;\
$A9:F330 85 14       STA $14    [$7E:0014]  ;} $14 = 68h
$A9:F332 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F335 A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:F338 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:F33B DE B2 0F    DEC $0FB2,x[$7E:0FB2]  ; Decrement enemy function timer
$A9:F33E 30 01       BMI $01    [$F341]     ; If [enemy function timer] >= 0:
$A9:F340 60          RTS                    ; Return

$A9:F341 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F344 A9 A3 F3    LDA #$F3A3             ;\
$A9:F347 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F3A3
$A9:F34A A9 00 01    LDA #$0100             ;\
$A9:F34D 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function timer = 100h
$A9:F350 A9 3A F9    LDA #$F93A             ;\
$A9:F353 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $F93A (remorse)
$A9:F356 A9 01 00    LDA #$0001             ;\
$A9:F359 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A9:F35C 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A9:F35F 60          RTS
}


;;; $F360: Shitroid function - flee remorsefully ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F360 A9 52 00    LDA #$0052             ;\
$A9:F363 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 52h, sound library 2, max queued sounds allowed = 6 (Shitroid feels remorse)
$A9:F367 A9 6D F3    LDA #$F36D             ;\
$A9:F36A 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F36D
}


;;; $F36D: Shitroid function - fleeing ;;;
{
$A9:F36D A9 80 FF    LDA #$FF80             ;\
$A9:F370 85 12       STA $12    [$7E:0012]  ;} $12 = -80h
$A9:F372 A9 40 00    LDA #$0040             ;\
$A9:F375 85 14       STA $14    [$7E:0014]  ;} $14 = 40h
$A9:F377 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F37A A0 00 00    LDY #$0000             ; Y = 0 (slowest acceleration)
$A9:F37D 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:F380 A9 08 00    LDA #$0008             ;\
$A9:F383 85 16       STA $16    [$7E:0016]  ;|
$A9:F385 85 18       STA $18    [$7E:0018]  ;} Check for enemy collision with 8x8 px^2 region around ([$12], [$14])
$A9:F387 22 06 EF A9 JSL $A9EF06[$A9:EF06]  ;/
$A9:F38B B0 15       BCS $15    [$F3A2]     ; If collision:
$A9:F38D 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy X velocity = 0
$A9:F390 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ; Enemy Y velocity = 0
$A9:F393 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A9:F396 29 FF DE    AND #$DEFF             ;} Set enemy to not process instructions and visible
$A9:F399 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A9:F39C A9 DF EF    LDA #$EFDF             ;\
$A9:F39F 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $EFDF (disappeared)

$A9:F3A2 60          RTS
}


;;; $F3A3: Shitroid function - Samus recovering ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F3A3 DE B2 0F    DEC $0FB2,x[$7E:0FB2]  ; Decrement enemy function timer
$A9:F3A6 30 03       BMI $03    [$F3AB]     ; If [enemy function timer] >= 0:
$A9:F3A8 4C D4 F3    JMP $F3D4  [$A9:F3D4]  ; Go to gradually accelerate towards Samus

$A9:F3AB A9 02 00    LDA #$0002             ;\
$A9:F3AE 22 AD E4 91 JSL $91E4AD[$91:E4AD]  ;} Release Samus from drained pose
$A9:F3B2 A9 01 00    LDA #$0001             ;\
$A9:F3B5 9D B6 0F    STA $0FB6,x[$7E:0FB6]  ;} Enable Shitroid contact reaction
$A9:F3B8 A9 BE F3    LDA #$F3BE             ;\
$A9:F3BB 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F3BE
}


;;; $F3BE: Shitroid function - remorse ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F3BE 20 D4 F3    JSR $F3D4  [$A9:F3D4]  ; Gradually accelerate towards Samus
$A9:F3C1 B0 01       BCS $01    [$F3C4]     ; If not ready to flee:
$A9:F3C3 60          RTS                    ; Return
}


;;; $F3C4: Make Shitroid flee ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F3C4 A9 60 F3    LDA #$F360             ;\
$A9:F3C7 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F360
$A9:F3CA 60          RTS
}


;;; $F3CB: Signal Shitroid to leave ;;;
{
;; Parameters:
;;     X: 0. Enemy index
$A9:F3CB BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$A9:F3CE C9 BE F3    CMP #$F3BE             ;} If [Shitroid function] = $F3BE (remorse): go to make Shitroid flee
$A9:F3D1 F0 F1       BEQ $F1    [$F3C4]     ;/
$A9:F3D3 60          RTS
}


;;; $F3D4: Gradually accelerate towards Samus ;;;
{
;; Parameters:
;;     X: 0. Enemy index
;; Returns:
;;     Carry: Set if ready to flee, clear otherwise

; Similar to $F180
$A9:F3D4 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A9:F3D7 38          SEC                    ;|
$A9:F3D8 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$A9:F3DB 10 04       BPL $04    [$F3E1]     ;|
$A9:F3DD 49 FF FF    EOR #$FFFF             ;} If |[enemy X position] - [Samus X position]| < 2:
$A9:F3E0 1A          INC A                  ;|
                                            ;|
$A9:F3E1 C9 02 00    CMP #$0002             ;|
$A9:F3E4 B0 09       BCS $09    [$F3EF]     ;/
$A9:F3E6 BF 04 78 7E LDA $7E7804,x[$7E:7804];\
$A9:F3EA 69 02 00    ADC #$0002             ;} Enemy proximity counter += 2
$A9:F3ED 80 0F       BRA $0F    [$F3FE]

$A9:F3EF BF 04 78 7E LDA $7E7804,x[$7E:7804];\ Else (|[enemy X position] - [Samus X position]| >= 8):
$A9:F3F3 F0 09       BEQ $09    [$F3FE]     ;|
$A9:F3F5 38          SEC                    ;|
$A9:F3F6 E9 01 00    SBC #$0001             ;} Enemy proximity counter = max(0, [enemy proximity counter] - 1)
$A9:F3F9 10 03       BPL $03    [$F3FE]     ;|
$A9:F3FB A9 00 00    LDA #$0000             ;/

$A9:F3FE 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A9:F402 BF 02 78 7E LDA $7E7802,x[$7E:7802];\
$A9:F406 F0 0F       BEQ $0F    [$F417]     ;} If [enemy aggro timer] != 0:
$A9:F408 3A          DEC A                  ;\
$A9:F409 9F 02 78 7E STA $7E7802,x[$7E:7802];} Decrement enemy aggro timer
$A9:F40D AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A9:F410 18          CLC                    ;|
$A9:F411 69 EE FF    ADC #$FFEE             ;} Y = [Samus Y position] - 12h
$A9:F414 A8          TAY                    ;/
$A9:F415 80 15       BRA $15    [$F42C]
                                            ; Else ([enemy aggro timer] = 0):
$A9:F417 A0 50 00    LDY #$0050             ; Y = 50h
$A9:F41A AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:F41D 29 FF 0F    AND #$0FFF             ;|
$A9:F420 C9 E0 0F    CMP #$0FE0             ;} If [random number] & FFFh >= FE0h:
$A9:F423 90 07       BCC $07    [$F42C]     ;/
$A9:F425 A9 20 00    LDA #$0020             ;\
$A9:F428 9F 02 78 7E STA $7E7802,x[$7E:7802];} Enemy aggro timer = 20h

$A9:F42C 84 14       STY $14    [$7E:0014]  ; $14 = [Y]
$A9:F42E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F431 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus X position]
$A9:F433 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F436 A0 08 00    LDY #$0008             ; Y = 8 (medium acceleration)
$A9:F439 20 51 F4    JSR $F451  [$A9:F451]  ; Gradually accelerate towards point ([$12], [$14])
$A9:F43C BF 04 78 7E LDA $7E7804,x[$7E:7804];\
$A9:F440 C9 00 04    CMP #$0400             ;} If [enemy proximity counter] >= 400h: return carry set
$A9:F443 B0 0A       BCS $0A    [$F44F]     ;/
$A9:F445 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F448 C9 80 00    CMP #$0080             ;} If [Samus X position] < 80h: return carry set
$A9:F44B 30 02       BMI $02    [$F44F]     ;/
$A9:F44D 18          CLC                    ;\
$A9:F44E 60          RTS                    ;} Return carry clear

$A9:F44F 38          SEC                    ;\
$A9:F450 60          RTS                    ;} Return carry set
}


;;; $F451: Gradually accelerate towards point - $1A = 400h ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Acceleration divisor table index. Range 0..Fh, lower = slower
;;     $12: Target X position
;;     $14: Target Y position
$A9:F451 A9 00 04    LDA #$0400
$A9:F454 85 1A       STA $1A    [$7E:001A]
$A9:F456 80 13       BRA $13    [$F46B]
}


;;; $F458: Gradually accelerate towards point - $1A = 4 ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Acceleration divisor table index. Range 0..Fh, lower = slower
;;     $12: Target X position
;;     $14: Target Y position
$A9:F458 A9 04 00    LDA #$0004
$A9:F45B 85 1A       STA $1A    [$7E:001A]
$A9:F45D 80 0C       BRA $0C    [$F46B]
}


;;; $F45F: Gradually accelerate towards point - $1A = 8 ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Acceleration divisor table index. Range 0..Fh, lower = slower
;;     $12: Target X position
;;     $14: Target Y position
$A9:F45F A9 08 00    LDA #$0008
$A9:F462 85 1A       STA $1A    [$7E:001A]
$A9:F464 80 05       BRA $05    [$F46B]
}


;;; $F466: Gradually accelerate towards point - $1A = 10h ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Acceleration divisor table index. Range 0..Fh, lower = slower
;;     $12: Target X position
;;     $14: Target Y position
$A9:F466 A9 10 00    LDA #$0010
$A9:F469 85 1A       STA $1A    [$7E:001A]
}


;;; $F46B: Gradually accelerate towards point ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Acceleration divisor table index. Range 0..Fh, lower = slower
;;     $12: Target X position
;;     $14: Target Y position
;;     $1A: Extra X speed if enemy is moving the wrong way and is horizontally off-screen. Unit is 1/100h px/frame
$A9:F46B B9 6A F5    LDA $F56A,y[$A9:F579]  ;\
$A9:F46E 29 FF 00    AND #$00FF             ;} $18 = 10h - [Y]
$A9:F471 85 18       STA $18    [$7E:0018]  ;/
$A9:F473 20 E6 F4    JSR $F4E6  [$A9:F4E6]  ; Gradually accelerate horizontally
$A9:F476 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A9:F479 38          SEC                    ;|
$A9:F47A E5 14       SBC $14    [$7E:0014]  ;} If [enemy Y position] = [$14]: return
$A9:F47C F0 36       BEQ $36    [$F4B4]     ;/
$A9:F47E 10 35       BPL $35    [$F4B5]     ; If [enemy Y position] > [$14]: go to BRANCH_UP
$A9:F480 49 FF FF    EOR #$FFFF             ;\
$A9:F483 1A          INC A                  ;|
$A9:F484 8D 04 42    STA $4204              ;|
$A9:F487 E2 20       SEP #$20               ;|
$A9:F489 A5 18       LDA $18    [$7E:0018]  ;|
$A9:F48B 8D 06 42    STA $4206              ;|
$A9:F48E C2 20       REP #$20               ;|
$A9:F490 EB          XBA                    ;|
$A9:F491 EB          XBA                    ;} $16 = max(1, ([$14] - [enemy Y position]) / [$18])
$A9:F492 EA          NOP                    ;|
$A9:F493 EA          NOP                    ;|
$A9:F494 AD 14 42    LDA $4214              ;|
$A9:F497 D0 01       BNE $01    [$F49A]     ;|
$A9:F499 1A          INC A                  ;|
                                            ;|
$A9:F49A 85 16       STA $16    [$7E:0016]  ;/
$A9:F49C BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A9:F49F 10 06       BPL $06    [$F4A7]     ;} If [enemy Y velocity] >= 0: go to BRANCH_MOVING_DOWN
$A9:F4A1 18          CLC                    ;\
$A9:F4A2 69 08 00    ADC #$0008             ;} Enemy Y velocity += 8 + [$16]
$A9:F4A5 65 16       ADC $16    [$7E:0016]  ;/

; BRANCH_MOVING_DOWN
$A9:F4A7 65 16       ADC $16    [$7E:0016]  ; Enemy Y velocity += [$16]
$A9:F4A9 C9 00 05    CMP #$0500             ;\
$A9:F4AC 30 03       BMI $03    [$F4B1]     ;} Enemy Y velocity = min([enemy Y velocity], 500h)
$A9:F4AE A9 00 05    LDA #$0500             ;/

$A9:F4B1 9D AC 0F    STA $0FAC,x[$7E:0FAC]

$A9:F4B4 60          RTS                    ; Return

; BRANCH_UP
$A9:F4B5 8D 04 42    STA $4204              ;\
$A9:F4B8 E2 20       SEP #$20               ;|
$A9:F4BA A5 18       LDA $18    [$7E:0018]  ;|
$A9:F4BC 8D 06 42    STA $4206              ;|
$A9:F4BF C2 20       REP #$20               ;|
$A9:F4C1 EB          XBA                    ;|
$A9:F4C2 EB          XBA                    ;|
$A9:F4C3 EA          NOP                    ;} $16 = max(1, ([enemy Y position] - [$14]) / [$18])
$A9:F4C4 EA          NOP                    ;|
$A9:F4C5 AD 14 42    LDA $4214              ;|
$A9:F4C8 D0 01       BNE $01    [$F4CB]     ;|
$A9:F4CA 1A          INC A                  ;|
                                            ;|
$A9:F4CB 85 16       STA $16    [$7E:0016]  ;/
$A9:F4CD BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A9:F4D0 30 06       BMI $06    [$F4D8]     ;} If [enemy Y velocity] < 0: go to BRANCH_MOVING_UP
$A9:F4D2 38          SEC                    ;\
$A9:F4D3 E9 08 00    SBC #$0008             ;} Enemy Y velocity -= 8 + [$16]
$A9:F4D6 E5 16       SBC $16    [$7E:0016]  ;/

; BRANCH_MOVING_UP
$A9:F4D8 E5 16       SBC $16    [$7E:0016]  ; Enemy Y velocity -= [$16]
$A9:F4DA C9 00 FB    CMP #$FB00             ;\
$A9:F4DD 10 03       BPL $03    [$F4E2]     ;} Enemy Y velocity = max([enemy Y velocity], -500h)
$A9:F4DF A9 00 FB    LDA #$FB00             ;/

$A9:F4E2 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A9:F4E5 60          RTS
}


;;; $F4E6: Gradually accelerate horizontally ;;;
{
;; Parameters:
;;     X: 0. Enemy index
;;     $12: Target X position
;;     $18: Acceleration divisor
;;     $1A: Extra speed if enemy is moving the wrong way and is off-screen. Unit is 1/100h px/frame

; Given initial X position x_0 and assuming initial X velocity 0, solving
;     x''(t) = (8 + ([$12] - x(t)) / [$18]) / 100h
; gives
;     x(t) = [$12] + 8 * [$18] - ([$12] + 8 * [$18] - x_0) cos(t / (10h * sqrt([$18])))

; Which takes 10h * sqrt([$18]) arccos(8 * [$18] / ([$12] + 8 * [$18] - x_0)) frames to reach the target position,
;     with [$18] = 10h, that's 40h arccos(80h / ([$12] + 80h - x_0)) frames (range 0..78)
;     with [$18] = 1, that's 10h arccos(8 / ([$12] + 8 - x_0)) frames (range 0..24)

$A9:F4E6 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A9:F4E9 38          SEC                    ;|
$A9:F4EA E5 12       SBC $12    [$7E:0012]  ;} If [enemy X position] = [$12]: return
$A9:F4EC F0 40       BEQ $40    [$F52E]     ;/
$A9:F4EE 10 3F       BPL $3F    [$F52F]     ; If [$12] < [enemy X position]: go to BRANCH_LEFT
$A9:F4F0 49 FF FF    EOR #$FFFF             ;\
$A9:F4F3 1A          INC A                  ;|
$A9:F4F4 8D 04 42    STA $4204              ;|
$A9:F4F7 E2 20       SEP #$20               ;|
$A9:F4F9 A5 18       LDA $18    [$7E:0018]  ;|
$A9:F4FB 8D 06 42    STA $4206              ;|
$A9:F4FE C2 20       REP #$20               ;|
$A9:F500 EB          XBA                    ;|
$A9:F501 EB          XBA                    ;} $16 = max(1, ([$12] - [enemy X position]) / [$18])
$A9:F502 EA          NOP                    ;|
$A9:F503 EA          NOP                    ;|
$A9:F504 AD 14 42    LDA $4214              ;|
$A9:F507 D0 01       BNE $01    [$F50A]     ;|
$A9:F509 1A          INC A                  ;|
                                            ;|
$A9:F50A 85 16       STA $16    [$7E:0016]  ;/
$A9:F50C BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A9:F50F 10 10       BPL $10    [$F521]     ;} If [enemy X velocity] >= 0: go to BRANCH_MOVING_RIGHT
$A9:F511 48          PHA                    ;\
$A9:F512 22 7A F5 A9 JSL $A9F57A[$A9:F57A]  ;|
$A9:F516 68          PLA                    ;} If enemy is off-screen:
$A9:F517 90 02       BCC $02    [$F51B]     ;/
$A9:F519 65 1A       ADC $1A    [$7E:001A]  ; Enemy X velocity += [$1A] + 1

$A9:F51B 18          CLC                    ;\
$A9:F51C 69 08 00    ADC #$0008             ;} Enemy X velocity += 8 + [$16]
$A9:F51F 65 16       ADC $16    [$7E:0016]  ;/

; BRANCH_MOVING_RIGHT
$A9:F521 65 16       ADC $16    [$7E:0016]  ; Enemy X velocity += [$16]
$A9:F523 C9 00 08    CMP #$0800             ;\
$A9:F526 30 03       BMI $03    [$F52B]     ;} Enemy X velocity = min([enemy X velocity], 800h)
$A9:F528 A9 00 08    LDA #$0800             ;/

$A9:F52B 9D AA 0F    STA $0FAA,x[$7E:0FAA]

$A9:F52E 60          RTS                    ; Return

; BRANCH_LEFT
$A9:F52F 8D 04 42    STA $4204              ;\
$A9:F532 E2 20       SEP #$20               ;|
$A9:F534 A5 18       LDA $18    [$7E:0018]  ;|
$A9:F536 8D 06 42    STA $4206              ;|
$A9:F539 C2 20       REP #$20               ;|
$A9:F53B EB          XBA                    ;|
$A9:F53C EB          XBA                    ;|
$A9:F53D EA          NOP                    ;} $16 = max(1, ([enemy X position] - [$12]) / [$18])
$A9:F53E EA          NOP                    ;|
$A9:F53F AD 14 42    LDA $4214              ;|
$A9:F542 D0 01       BNE $01    [$F545]     ;|
$A9:F544 1A          INC A                  ;|
                                            ;|
$A9:F545 85 16       STA $16    [$7E:0016]  ;/
$A9:F547 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A9:F54A 30 10       BMI $10    [$F55C]     ;} If [enemy X velocity] < 0: go to BRANCH_MOVING_LEFT
$A9:F54C 48          PHA                    ;\
$A9:F54D 22 7A F5 A9 JSL $A9F57A[$A9:F57A]  ;|
$A9:F551 68          PLA                    ;} If enemy is off-screen:
$A9:F552 90 02       BCC $02    [$F556]     ;/
$A9:F554 E5 1A       SBC $1A    [$7E:001A]  ; Enemy X velocity -= [$1A]

$A9:F556 38          SEC                    ;\
$A9:F557 E9 08 00    SBC #$0008             ;} Enemy X velocity -= 8 + [$16]
$A9:F55A E5 16       SBC $16    [$7E:0016]  ;/

; BRANCH_MOVING_LEFT
$A9:F55C E5 16       SBC $16    [$7E:0016]  ; Enemy X velocity -= [$16]
$A9:F55E C9 00 F8    CMP #$F800             ;\
$A9:F561 10 03       BPL $03    [$F566]     ;} Enemy X velocity = max([enemy X velocity], -800h)
$A9:F563 A9 00 F8    LDA #$F800             ;/

$A9:F566 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A9:F569 60          RTS
}


;;; $F56A: Gradual acceleration divisor table ;;;
{
$A9:F56A             db 10, 0F, 0E, 0D, 0C, 0B, 0A, 09, 08, 07, 06, 05, 04, 03, 02, 01
}


;;; $F57A: Check if enemy is vaguely on screen ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Carry: Set if off-screen, otherwise clear
$A9:F57A BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A9:F57D 30 25       BMI $25    [$F5A4]     ;} If [enemy Y position] < 0: return carry set
$A9:F57F 18          CLC                    ;\
$A9:F580 69 60 00    ADC #$0060             ;|
$A9:F583 38          SEC                    ;|
$A9:F584 ED 15 09    SBC $0915  [$7E:0915]  ;} If not [layer 1 Y position] - 60h <= [enemy Y position] < [layer 1 Y position] + 140h: return carry set
$A9:F587 30 1B       BMI $1B    [$F5A4]     ;|
$A9:F589 C9 A0 01    CMP #$01A0             ;|
$A9:F58C 10 16       BPL $16    [$F5A4]     ;/
$A9:F58E BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A9:F591 30 11       BMI $11    [$F5A4]     ;} If [enemy X position] < 0: return carry set
$A9:F593 18          CLC                    ;\
$A9:F594 69 10 00    ADC #$0010             ;|
$A9:F597 38          SEC                    ;|
$A9:F598 ED 11 09    SBC $0911  [$7E:0911]  ;} If not [layer 1 X position] - 10h <= [enemy X position] < [layer 1 X position] + 110h: return carry set
$A9:F59B 30 07       BMI $07    [$F5A4]     ;|
$A9:F59D C9 20 01    CMP #$0120             ;|
$A9:F5A0 10 02       BPL $02    [$F5A4]     ;/
$A9:F5A2 18          CLC                    ;\
$A9:F5A3 6B          RTL                    ;} Return carry clear

$A9:F5A4 38          SEC
$A9:F5A5 6B          RTL
}


;;; $F5A6: Accelerate Shitroid towards point ;;;
{
;; Parameters:
;;     A: Acceleration. Unit is 1/100h px/frame^2
;;     X: 0. Enemy index
;;     $12: Target X position
;;     $14: Target Y position
;; Returns:
;;     Carry: Set if reached target position
$A9:F5A6 85 16       STA $16    [$7E:0016]  ; $16 = [A]
$A9:F5A8 64 1C       STZ $1C    [$7E:001C]  ; $1C = 0
$A9:F5AA 20 15 F6    JSR $F615  [$A9:F615]  ;\
$A9:F5AD 20 B5 F5    JSR $F5B5  [$A9:F5B5]  ;} Accelerate Shitroid towards ([$12], [$14])
$A9:F5B0 46 1C       LSR $1C    [$7E:001C]  ;\
$A9:F5B2 46 1C       LSR $1C    [$7E:001C]  ;} Set carry if reached target position
$A9:F5B4 60          RTS
}


;;; $F5B5: Accelerate Shitroid towards Y position ;;;
{
;; Parameters:
;;     X: 0. Enemy index
;;     $14: Target Y position
;;     $16: Acceleration. Unit is 1/100h px/frame^2

; Increments $1C if reached target position
$A9:F5B5 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A9:F5B8 38          SEC                    ;|
$A9:F5B9 E5 14       SBC $14    [$7E:0014]  ;} If [enemy Y position] = [$14]: go to BRANCH_REACHED_TARGET
$A9:F5BB F0 29       BEQ $29    [$F5E6]     ;/
$A9:F5BD 10 2A       BPL $2A    [$F5E9]     ; If [enemy Y position] > [$14]: go to BRANCH_UP
$A9:F5BF BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A9:F5C2 18          CLC                    ;|
$A9:F5C3 65 16       ADC $16    [$7E:0016]  ;|
$A9:F5C5 C9 00 05    CMP #$0500             ;|
$A9:F5C8 30 03       BMI $03    [$F5CD]     ;} Enemy Y velocity = min(500h, [enemy Y velocity] + [$16])
$A9:F5CA A9 00 05    LDA #$0500             ;|
                                            ;|
$A9:F5CD 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;/
$A9:F5D0 29 00 FF    AND #$FF00             ;\
$A9:F5D3 EB          XBA                    ;|
$A9:F5D4 10 03       BPL $03    [$F5D9]     ;|
$A9:F5D6 09 00 FF    ORA #$FF00             ;|
                                            ;} If [enemy Y position] + [enemy Y velocity] / 100h < [$14]: return
$A9:F5D9 18          CLC                    ;|
$A9:F5DA 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]  ;|
$A9:F5DD C5 14       CMP $14    [$7E:0014]  ;|
$A9:F5DF 30 07       BMI $07    [$F5E8]     ;/
$A9:F5E1 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ; Enemy Y velocity = 0
$A9:F5E4 A5 14       LDA $14    [$7E:0014]  ; >_<;

; BRANCH_REACHED_TARGET
$A9:F5E6 E6 1C       INC $1C    [$7E:001C]  ; Increment $1C

$A9:F5E8 60          RTS                    ; Return

; BRANCH_UP
$A9:F5E9 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A9:F5EC 38          SEC                    ;|
$A9:F5ED E5 16       SBC $16    [$7E:0016]  ;|
$A9:F5EF C9 00 FB    CMP #$FB00             ;|
$A9:F5F2 10 03       BPL $03    [$F5F7]     ;} Enemy Y velocity = max(-500h, [enemy Y velocity] - [$16])
$A9:F5F4 A9 00 FB    LDA #$FB00             ;|
                                            ;|
$A9:F5F7 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;/
$A9:F5FA 29 00 FF    AND #$FF00             ;\
$A9:F5FD EB          XBA                    ;|
$A9:F5FE 10 03       BPL $03    [$F603]     ;|
$A9:F600 09 00 FF    ORA #$FF00             ;|
                                            ;|
$A9:F603 18          CLC                    ;} If [enemy Y position] + [enemy Y velocity] / 100h > [$14]: return
$A9:F604 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]  ;|
$A9:F607 C5 14       CMP $14    [$7E:0014]  ;|
$A9:F609 F0 02       BEQ $02    [$F60D]     ;|
$A9:F60B 10 07       BPL $07    [$F614]     ;/

$A9:F60D 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ; Enemy Y velocity = 0
$A9:F610 A5 14       LDA $14    [$7E:0014]  ; >_<;
$A9:F612 E6 1C       INC $1C    [$7E:001C]  ; Increment $1C

$A9:F614 60          RTS
}


;;; $F615: Accelerate Shitroid towards X position ;;;
{
;; Parameters:
;;     X: 0. Enemy index
;;     $12: Target X position
;;     $16: Acceleration. Unit is 1/100h px/frame^2

; Increments $1C if reached target position
$A9:F615 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A9:F618 38          SEC                    ;|
$A9:F619 E5 12       SBC $12    [$7E:0012]  ;} If [enemy X position] >= [$12]: go to BRANCH_LEFT
$A9:F61B 10 2E       BPL $2E    [$F64B]     ;/
$A9:F61D 49 FF FF    EOR #$FFFF             ;\
$A9:F620 1A          INC A                  ;} >_<;
$A9:F621 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A9:F624 18          CLC                    ;|
$A9:F625 65 16       ADC $16    [$7E:0016]  ;|
$A9:F627 C9 00 05    CMP #$0500             ;|
$A9:F62A 30 03       BMI $03    [$F62F]     ;} Enemy X velocity = min(500h, [enemy X velocity] + [$16])
$A9:F62C A9 00 05    LDA #$0500             ;|
                                            ;|
$A9:F62F 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A9:F632 29 00 FF    AND #$FF00             ;\
$A9:F635 EB          XBA                    ;|
$A9:F636 10 03       BPL $03    [$F63B]     ;|
$A9:F638 09 00 FF    ORA #$FF00             ;|
                                            ;} If [enemy X position] + [enemy X velocity] / 100h >= [$12]:
$A9:F63B 18          CLC                    ;|
$A9:F63C 7D 7A 0F    ADC $0F7A,x[$7E:0F7A]  ;|
$A9:F63F C5 12       CMP $12    [$7E:0012]  ;|
$A9:F641 30 07       BMI $07    [$F64A]     ;/
$A9:F643 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy X velocity = 0
$A9:F646 A5 12       LDA $12    [$7E:0012]  ; >_<;
$A9:F648 E6 1C       INC $1C    [$7E:001C]  ; Increment $1C

$A9:F64A 60          RTS                    ; Return

; BRANCH_LEFT
$A9:F64B BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A9:F64E 38          SEC                    ;|
$A9:F64F E5 16       SBC $16    [$7E:0016]  ;|
$A9:F651 C9 00 FB    CMP #$FB00             ;|
$A9:F654 10 03       BPL $03    [$F659]     ;} Enemy X velocity = max(-500h, [enemy X velocity] - [$16])
$A9:F656 A9 00 FB    LDA #$FB00             ;|
                                            ;|
$A9:F659 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A9:F65C 29 00 FF    AND #$FF00             ;\
$A9:F65F EB          XBA                    ;|
$A9:F660 10 03       BPL $03    [$F665]     ;|
$A9:F662 09 00 FF    ORA #$FF00             ;|
                                            ;|
$A9:F665 18          CLC                    ;} If [enemy X position] + [enemy X velocity] / 100h > [$12]: return
$A9:F666 7D 7A 0F    ADC $0F7A,x[$7E:0F7A]  ;|
$A9:F669 C5 12       CMP $12    [$7E:0012]  ;|
$A9:F66B F0 02       BEQ $02    [$F66F]     ;|
$A9:F66D 10 07       BPL $07    [$F676]     ;/

$A9:F66F 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy X velocity = 0
$A9:F672 A5 12       LDA $12    [$7E:0012]  ; >_<;
$A9:F674 E6 1C       INC $1C    [$7E:001C]  ; Increment $1C

$A9:F676 60          RTS
}


;;; $F677: Handle normal Shitroid palette ;;;
{
$A9:F677 A9 4A 01    LDA #$014A             ;\
$A9:F67A 85 12       STA $12    [$7E:0012]  ;} $12 = 14Ah (sprite palette 2 colour 5)
$A9:F67C A9 D1 F6    LDA #$F6D1             ;\
$A9:F67F 85 16       STA $16    [$7E:0016]  ;} $16 = $F6D1
$A9:F681 80 16       BRA $16    [$F699]     ; Go to handle Shitroid palette
}


;;; $F683: Handle Shitroid in cutscene palette - normal ;;;
{
$A9:F683 A9 EA 01    LDA #$01EA             ;\
$A9:F686 85 12       STA $12    [$7E:0012]  ;} $12 = 1EAh (sprite palette 7 colour 5)
$A9:F688 A9 D1 F6    LDA #$F6D1             ;\
$A9:F68B 85 16       STA $16    [$7E:0016]  ;} $16 = $F6D1
$A9:F68D 80 0A       BRA $0A    [$F699]     ; Go to handle Shitroid palette
}


;;; $F68F: Handle Shitroid in cutscene palette - low health ;;;
{
$A9:F68F A9 EA 01    LDA #$01EA             ;\
$A9:F692 85 12       STA $12    [$7E:0012]  ;} $12 = 1EAh (sprite palette 7 colour 5)
$A9:F694 A9 11 F7    LDA #$F711             ;\
$A9:F697 85 16       STA $16    [$7E:0016]  ;} $16 = $F711
}


;;; $F699: Handle Shitroid palette ;;;
{
;; Parameters:
;;     $12: Colour index
;;     $16: Colour table pointer

; Also handles Shitroid cry sound effect
$A9:F699 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F69C E2 20       SEP #$20
$A9:F69E BD AF 0F    LDA $0FAF,x[$7E:0FAF]  ;\
$A9:F6A1 F0 07       BEQ $07    [$F6AA]     ;} If [enemy palette handler timer] != 0:
$A9:F6A3 3A          DEC A                  ;\
$A9:F6A4 9D AF 0F    STA $0FAF,x[$7E:0FAF]  ;} Decrement enemy palette handler timer
$A9:F6A7 C2 20       REP #$20
$A9:F6A9 60          RTS                    ; Return

$A9:F6AA BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A9:F6AD 9D AF 0F    STA $0FAF,x[$7E:0FAF]  ;} Enemy palette handler timer = [enemy palette handler delay]
$A9:F6B0 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A9:F6B3 1A          INC A                  ;|
$A9:F6B4 29 07       AND #$07               ;} Enemy palette frame timer = ([enemy palette frame timer] + 1) % 8
$A9:F6B6 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;/
$A9:F6B9 C2 20       REP #$20
$A9:F6BB 29 FF 00    AND #$00FF
$A9:F6BE 20 51 F7    JSR $F751  [$A9:F751]  ; Handle Shitroid cry sound effect
$A9:F6C1 0A          ASL A                  ;\
$A9:F6C2 0A          ASL A                  ;|
$A9:F6C3 0A          ASL A                  ;|
$A9:F6C4 65 16       ADC $16    [$7E:0016]  ;|
$A9:F6C6 A8          TAY                    ;} Write 4 colours from [$16] + [enemy palette frame timer] * 8 to colour index [$12]
$A9:F6C7 A6 12       LDX $12    [$7E:0012]  ;|
$A9:F6C9 A9 04 00    LDA #$0004             ;|
$A9:F6CC 22 E4 D2 A9 JSL $A9D2E4[$A9:D2E4]  ;/
$A9:F6D0 60          RTS
}


;;; $F6D1: Shitroid colours - normal ;;;
{
$A9:F6D1             dw 72FF,2CDF,24B9,1CAF,
                        5E5F,183F,1014,080A,
                        49BA,041A,000F,0005,
                        3515,0015,000A,0005,
                        3515,0015,000A,0005,
                        49BA,041A,000F,0005,
                        5E5F,183F,1014,080A,
                        72FF,2CDF,24B9,1CAF
}


;;; $F711: Shitroid colours - low health ;;;
{
$A9:F711             dw 5990,3870,346D,3068,
                        494D,306D,284A,2446,
                        3D0B,244B,2048,1844,
                        2CC8,1C48,1425,0C22,
                        2CC8,1C48,1425,0C22,
                        3D0B,244B,2048,1844,
                        494D,306D,284A,2446,
                        5990,3870,346D,3068
}


;;; $F751: Handle Shitroid cry sound effect ;;;
{
;; Parameters:
;;     A: Enemy palette frame timer
;;     X: 0. Enemy index
$A9:F751 C9 05 00    CMP #$0005             ;\
$A9:F754 F0 01       BEQ $01    [$F757]     ;} If [enemy palette frame timer] != 0:
$A9:F756 60          RTS                    ; Return

$A9:F757 48          PHA
$A9:F758 5A          PHY
$A9:F759 BF 08 78 7E LDA $7E7808,x[$7E:7808];\
$A9:F75D F0 27       BEQ $27    [$F786]     ;} If cry sound effect disabled: return
$A9:F75F BF 0A 78 7E LDA $7E780A,x[$7E:780A];\
$A9:F763 1A          INC A                  ;} Increment enemy cry sound effect timer
$A9:F764 9F 0A 78 7E STA $7E780A,x[$7E:780A];/
$A9:F768 C9 04 00    CMP #$0004             ;\
$A9:F76B 90 19       BCC $19    [$F786]     ;} If [enemy cry sound effect timer] < 4: return
$A9:F76D A9 00 00    LDA #$0000             ;\
$A9:F770 9F 0A 78 7E STA $7E780A,x[$7E:780A];} Enemy cry sound effect timer = 0
$A9:F774 A9 72 00    LDA #$0072             ; A = 72h (Shitroid's cry)
$A9:F777 BC B0 0F    LDY $0FB0,x[$7E:0FB0]  ;\
$A9:F77A C0 0A 00    CPY #$000A             ;} If [enemy palette handler delay] < Ah:
$A9:F77D B0 03       BCS $03    [$F782]     ;/
$A9:F77F A9 78 00    LDA #$0078             ; A = 78h (Shitroid draining)

$A9:F782 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound [A], sound library 2, max queued sounds allowed = 6

$A9:F786 7A          PLY
$A9:F787 68          PLA
$A9:F788 60          RTS
}


;;; $F789: Enemy touch - enemy $EEBF (Shitroid) ;;;
{
$A9:F789 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F78C BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$A9:F78F F0 29       BEQ $29    [$F7BA]     ;} If contact reaction disabled: return
$A9:F791 20 CB F3    JSR $F3CB  [$A9:F3CB]  ; Signal Shitroid to leave
$A9:F794 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$A9:F797 29 FF 00    AND #$00FF             ;|
$A9:F79A C9 03 00    CMP #$0003             ;} If [Samus movement type] = spin jumping:
$A9:F79D D0 08       BNE $08    [$F7A7]     ;/
$A9:F79F AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F7A2 C9 00 02    CMP #$0200             ;} If [Samus X position] >= 200h: go to BRANCH_REPELLED
$A9:F7A5 10 52       BPL $52    [$F7F9]     ;/

$A9:F7A7 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$A9:F7AA C9 FA F1    CMP #$F1FA             ;} If [enemy function] = $F1FA (latch onto Samus): go to BRANCH_LATCH_ONTO_SAMUS
$A9:F7AD F0 0C       BEQ $0C    [$F7BB]     ;/
$A9:F7AF C9 80 F1    CMP #$F180             ;\
$A9:F7B2 D0 06       BNE $06    [$F7BA]     ;} If [enemy function] = $F180 (stare down Samus):
$A9:F7B4 A9 FA F1    LDA #$F1FA             ;\
$A9:F7B7 9D A8 0F    STA $0FA8,x            ;} Enemy function = $F1FA (latch onto Samus)

$A9:F7BA 6B          RTL                    ; Return

; BRANCH_LATCH_ONTO_SAMUS
$A9:F7BB AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F7BE 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus X position]
$A9:F7C0 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A9:F7C3 38          SEC                    ;|
$A9:F7C4 E9 20 00    SBC #$0020             ;} $14 = [Samus Y position] - 20h
$A9:F7C7 85 14       STA $14    [$7E:0014]  ;/
$A9:F7C9 A9 00 02    LDA #$0200             ; A = 200h (acceleration)
$A9:F7CC 20 A6 F5    JSR $F5A6  [$A9:F5A6]  ; Accelerate Shitroid towards ([$12], [$14])
$A9:F7CF 90 E9       BCC $E9    [$F7BA]     ; If not reached target: return
$A9:F7D1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F7D4 A9 24 F9    LDA #$F924             ;\
$A9:F7D7 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $F924 (latched on)
$A9:F7DA A9 01 00    LDA #$0001             ;\
$A9:F7DD 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A9:F7E0 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A9:F7E3 A9 01 00    LDA #$0001             ;\
$A9:F7E6 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy palette handler delay = 1
$A9:F7E9 9E B6 0F    STZ $0FB6,x[$7E:0FB6]  ; Disable Shitroid contact reaction
$A9:F7EC 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Enemy X velocity = 0
$A9:F7EF 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ; Enemy Y velocity = 0
$A9:F7F2 A9 0E F2    LDA #$F20E             ;\
$A9:F7F5 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F20E (start draining Samus)
$A9:F7F8 6B          RTL                    ; Return

; BRANCH_REPELLED
$A9:F7F9 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A9:F7FC 38          SEC                    ;|
$A9:F7FD FD 7A 0F    SBC $0F7A,x            ;|
$A9:F800 85 12       STA $12    [$7E:0012]  ;|
$A9:F802 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} A = angle from enemy to Samus
$A9:F805 38          SEC                    ;|
$A9:F806 FD 7E 0F    SBC $0F7E,x            ;|
$A9:F809 85 14       STA $14    [$7E:0014]  ;|
$A9:F80B 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A9:F80F 38          SEC                    ;\
$A9:F810 E9 80 00    SBC #$0080             ;|
$A9:F813 49 FF FF    EOR #$FFFF             ;|
$A9:F816 1A          INC A                  ;|
$A9:F817 18          CLC                    ;} $12 = -[A] & FFh (X flip of angle)
$A9:F818 69 80 00    ADC #$0080             ;|
$A9:F81B 29 FF 00    AND #$00FF             ;|
$A9:F81E 85 12       STA $12    [$7E:0012]  ;/
$A9:F820 A9 40 00    LDA #$0040             ;\
$A9:F823 48          PHA                    ;|
$A9:F824 22 6C C2 86 JSL $86C26C[$86:C26C]  ;|
$A9:F828 AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A9:F82B 18          CLC                    ;} Enemy X velocity += 40h * sin([$12] * pi / 80h)
$A9:F82C 7D AA 0F    ADC $0FAA,x            ;|
$A9:F82F 9D AA 0F    STA $0FAA,x            ;|
$A9:F832 68          PLA                    ;/
$A9:F833 22 72 C2 86 JSL $86C272[$86:C272]  ;\
$A9:F837 AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A9:F83A 18          CLC                    ;} Enemy Y velocity += 40h * cos([$12] * pi / 80h)
$A9:F83B 7D AC 0F    ADC $0FAC,x            ;|
$A9:F83E 9D AC 0F    STA $0FAC,x            ;/
$A9:F841 6B          RTL
}


;;; $F842: Enemy shot - enemy $EEBF (Shitroid) ;;;
{
$A9:F842 AE 54 0E    LDX $0E54  [$7E:0E54]
$A9:F845 BD B6 0F    LDA $0FB6,x            ;\
$A9:F848 F0 5B       BEQ $5B    [$F8A5]     ;} If contact reaction disabled: return
$A9:F84A 20 CB F3    JSR $F3CB  [$A9:F3CB]  ; Signal Shitroid to leave
$A9:F84D AD 64 0B    LDA $0B64  [$7E:0B64]  ;\
$A9:F850 38          SEC                    ;|
$A9:F851 FD 7A 0F    SBC $0F7A,x            ;|
$A9:F854 85 12       STA $12    [$7E:0012]  ;|
$A9:F856 AD 78 0B    LDA $0B78  [$7E:0B78]  ;} A = angle from enemy to projectile 0
$A9:F859 38          SEC                    ;|
$A9:F85A FD 7E 0F    SBC $0F7E,x            ;|
$A9:F85D 85 14       STA $14    [$7E:0014]  ;|
$A9:F85F 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A9:F863 38          SEC                    ;\
$A9:F864 E9 80 00    SBC #$0080             ;|
$A9:F867 49 FF FF    EOR #$FFFF             ;|
$A9:F86A 1A          INC A                  ;|
$A9:F86B 18          CLC                    ;} $12 = -[A] & FFh (X flip of angle)
$A9:F86C 69 80 00    ADC #$0080             ;|
$A9:F86F 29 FF 00    AND #$00FF             ;|
$A9:F872 85 12       STA $12    [$7E:0012]  ;/
$A9:F874 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A9:F877 0A          ASL A                  ;} X = [collided projectile index] * 2
$A9:F878 AA          TAX                    ;/
$A9:F879 BD 2C 0C    LDA $0C2C,x            ;\
$A9:F87C 0A          ASL A                  ;|
$A9:F87D 0A          ASL A                  ;|
$A9:F87E 0A          ASL A                  ;} A = min(F0h, [projectile damage] * 8)
$A9:F87F C9 F0 00    CMP #$00F0             ;|
$A9:F882 90 03       BCC $03    [$F887]     ;|
$A9:F884 A9 F0 00    LDA #$00F0             ;/

$A9:F887 48          PHA                    ;\
$A9:F888 22 6C C2 86 JSL $86C26C[$86:C26C]  ;|
$A9:F88C AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A9:F88F 18          CLC                    ;} Enemy X velocity += [A] * sin([$12] * pi / 80h)
$A9:F890 7D AA 0F    ADC $0FAA,x            ;|
$A9:F893 9D AA 0F    STA $0FAA,x            ;|
$A9:F896 68          PLA                    ;/
$A9:F897 22 72 C2 86 JSL $86C272[$86:C272]  ;|
$A9:F89B AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A9:F89E 18          CLC                    ;} Enemy Y velocity += [A] * cos([$12] * pi / 80h)
$A9:F89F 7D AC 0F    ADC $0FAC,x            ;|
$A9:F8A2 9D AC 0F    STA $0FAC,x            ;/

$A9:F8A5 6B          RTL
}


;;; $F8A6: Palette - enemy $ED7F/$EDFF/$EE3F/$EE7F (dead monsters) ;;;
{
$A9:F8A6             dw 3800, 57FF, 42F7, 0929, 00A5, 7FFF, 4231, 0043, 4B3F, 42DB, 3678, 2E14, 2190, 192C, 0CC9, 0465
}


;;; $F8C6: Palette - Shitroid's sidehopper ;;;
{
$A9:F8C6             dw 3800, 7FFF, 56E0, 3180, 18C0, 6BC0, 5EC0, 4A20, 35A0, 7FFF, 039C, 0237, 00D1, 03FF, 0237, 00D1
}


;;; $F8E6: Palette - enemy $ECBF/$EEBF (Shitroid) ;;;
{
$A9:F8E6             dw 3800, 57B8, 0B11, 1646, 00E3, 72FF, 2CDF, 24B9, 1CAF, 18A9, 4F9F, 3ED8, 2E12, 08CD, 7FFF, 0000
}


;;; $F906: Instruction list - finish draining ;;;
{
$A9:F906             dx 0080,FAD8,
                        0010,FA40
}


;;; $F90E: Instruction list - normal ;;;
{
$A9:F90E             dx 0010,F9A8,
                        0010,FA40,
                        0010,FAD8,
                        0010,FA40,
                        F920        ; Go to $F90E
}


;;; $F920: Instruction - go to $F90E ;;;
{
;; Returns:
;;     Y: Pointer to next instruction
$A9:F920 A0 0E F9    LDY #$F90E
$A9:F923 6B          RTL
}


;;; $F924: Instruction list - latched on ;;;
{
$A9:F924             dx 0008,F9A8,
                        0008,FA40,
                        0005,FAD8,
                        0002,FA40,
                        F936        ; Go to $F924
}


;;; $F936: Instruction - go to $F924 ;;;
{
;; Returns:
;;     Y: Pointer to next instruction
$A9:F936 A0 24 F9    LDY #$F924
$A9:F939 6B          RTL
}


;;; $F93A: Instruction list - remorse ;;;
{
$A9:F93A             dx 000A,F9A8,
                        000A,FA40,
                        000A,FAD8,
                        000A,FA40,
                        000A,F9A8,
                        000A,FA40,
                        000A,FAD8,
                        000A,FA40,
                        F994,F93A,  ; Go to $F93A or queue Shitroid feels remorse sound effect
                        0006,F9A8,
                        0005,FA40,
                        0004,FAD8,
                        0003,FA40,
                        0002,F9A8,
                        0003,FA40,
                        0004,FAD8,
                        0005,FA40,
                        0006,F9A8,
                        0007,FA40,
                        0008,FAD8,
                        0009,FA40,
                        F990        ; Go to $F93A
}


;;; $F990: Instruction - go to $F93A ;;;
{
;; Returns:
;;     Y: Pointer to next instruction
$A9:F990 A0 3A F9    LDY #$F93A
$A9:F993 6B          RTL
}


;;; $F994: Instruction - go to [[Y]] or queue Shitroid feels remorse sound effect ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A9:F994 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A9:F997 10 0A       BPL $0A    [$F9A3]     ;} If [random number] & 8000h != 0:
$A9:F999 A9 52 00    LDA #$0052             ;\
$A9:F99C 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 52h, sound library 2, max queued sounds allowed = 6 (Shitroid feels remorse)
$A9:F9A0 C8          INY                    ;\
$A9:F9A1 C8          INY                    ;} Y += 2
$A9:F9A2 6B          RTL                    ; Return

$A9:F9A3 B9 00 00    LDA $0000,y            ;\
$A9:F9A6 A8          TAY                    ;} Y = [[Y]]
$A9:F9A7 6B          RTL
}


;;; $F9A8: Shitroid spritemaps ;;;
{
$A9:F9A8             dx 001E, 0000,18,6120, 01F8,18,2120, C208,18,6105, C3E8,18,2105, C210,18,6104, C3E0,18,2104, C200,08,6148, C3F0,08,2148, C208,08,6147, C218,08,6145, C3E8,08,2147, C3D8,08,2145, C218,F8,6125, C208,F8,6127, C200,F8,6128, C3F0,F8,2128, C3E8,F8,2127, C3D8,F8,2125, 0018,E0,6131, C218,E8,6140, C208,E8,6142, C208,D8,6122, C200,D8,6123, C200,E8,6143, C3F0,E8,2143, C3F0,D8,2123, 01E0,E0,2131, C3D8,E8,2140, C3E8,E8,2142, C3E8,D8,2122
$A9:FA40             dx 001E, C200,08,614E, C3F0,08,214E, C218,08,6145, C210,08,612E, C3E0,08,212E, C3D8,08,2145, 000D,28,6130, 01EB,28,2130, C200,18,6102, C210,18,6100, C3F0,18,2102, C3E0,18,2100, C200,F8,6128, C3F0,F8,2128, C208,F8,6127, C218,F8,6125, C3E8,F8,2127, C3D8,F8,2125, C200,E8,6143, C200,D8,6123, C3F0,E8,2143, C3F0,D8,2123, C218,E8,6140, C208,E8,6142, C208,D8,6122, C3E8,E8,2142, C3E8,D8,2122, C3D8,E8,2140, 0018,E0,6131, 01E0,E0,2131
$A9:FAD8             dx 001E, C208,F8,6127, C3E8,F8,2127, 0015,28,6121, 01E3,28,2121, C200,18,614C, C210,18,614A, C200,08,612C, C210,08,612A, C3F0,18,214C, C3E0,18,214A, C3F0,08,212C, C3E0,08,212A, C218,08,6145, C3D8,08,2145, C200,F8,6128, C3F0,F8,2128, C218,F8,6125, C3D8,F8,2125, 0018,E0,6131, 01E0,E0,2131, C200,E8,6143, C200,D8,6123, C3F0,E8,2143, C3F0,D8,2123, C208,E8,6142, C208,D8,6122, C3E8,E8,2142, C3E8,D8,2122, C218,E8,6140, C3D8,E8,2140
}
}


;;; $FB70: Free space ;;;
{
$A9:FB70             fillto $AA8000, $FF
}
