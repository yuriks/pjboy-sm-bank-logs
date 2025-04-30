;;; $8000: FX ;;;
{
;                        __________________________________________________ 0: Door pointer
;                       |      ____________________________________________ 2: Base Y position
;                       |     |     _______________________________________ 4: Target Y position
;                       |     |    |      _________________________________ 6: Y velocity
;                       |     |    |     |      ___________________________ 8: Timer
;                       |     |    |     |     |    _______________________ 9: Type (foreground layer 3)
;                       |     |    |     |     |   |    ___________________ Ah: Default layer blending configuration (FX A)
;                       |     |    |     |     |   |   |   ________________ Bh: FX layer 3 layer blending configuration (FX B)
;                       |     |    |     |     |   |   |  |    ____________ Ch: Liquid options (FX C)
;                       |     |    |     |     |   |   |  |   |    ________ Dh: Palette FX bitset
;                       |     |    |     |     |   |   |  |   |   |   _____ Eh: Animated tiles bitset
;                       |     |    |     |     |   |   |  |   |   |  |    _ Fh: Palette blend
;                       |     |    |     |     |   |   |  |   |   |  |   |
;                       dddd, bbbb,tttt, vvvv, tt, ff, AA,BB, CC, pp,aa, bb

; Room $91F8, state $9261. Landing site - event "Zebes timebomb set" is set
$83:8000             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 06,00, 00

; Room $92FD, state $9348. Crateria mainstreet - event "Zebes timebomb set" is set
$83:8010             dx 0000, 04E8,0010, FF98, 00, 00, 02,02, 00, 42,00, 00

; Room $96BA, state $9705. Old Tourian escape shaft - event "Zebes timebomb set" is set
$83:8020             dx 0000, 08E8,0010, FF98, 28, 04, 02,1E, 01, 38,00, 00

; Room $9804, state $984F. Bomb Torizo - event "Zebes timebomb set" is set
$83:8030             dx 0000, 00F0,00B8, FFF0, 30, 04, 02,1E, 00, 00,00, 00

; Room $9879, state $98C4. Pre Bomb Torizo hall - event "Zebes timebomb set" is set
$83:8040             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $92FD, state $932E. Crateria mainstreet - event "Zebes is awake" is set
$83:8050             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $96BA, state $96EB. Old Tourian escape shaft - event "Zebes is awake" is set
$83:8060             dx AB34, 0908,0000, FF80, 20, 02, 02,1E, 0B, 1F,01, 02, ; Escape room 4 - door 1
                        0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $975C, state $9787. Old Mother Brain room - morph ball and missiles have been collected
$83:8080             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $97B5, state $97E0. Crateria -> Blue Brinstar elevator - morph ball and missiles have been collected
$83:8090             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $9A44, state $9A70. Crateria bomb block hall - event "Zebes is awake" is set
$83:80A0             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $9A90, state $9ABC. Crateria chozo missile - event "Zebes is awake" is set
$83:80B0             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $91F8, state $9213. Landing site - default
; Room $91F8, state $922D. Landing site - event "Zebes is awake" is set
$83:80C0             dx 0000, FFFF,FFFF, 0000, 00, 0A, 02,0E, 00, 01,00, 22

; Room $91F8, state $9247. Landing site - power bombs have been collected
$83:80D0             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $92B3. Gauntlet east
$83:80E0             dx 0000, 00C8,FFFF, 0000, 00, 04, 02,1E, 42, 00,00, 00

; Room $92FD, state $9314. Crateria mainstreet - default
$83:80F0             dx 0000, FFFF,FFFF, 0000, 00, 00, 28,02, 00, 00,00, 62

; Room $93AA. Landing site power bombs cave
$83:8100             dx 0000, 00C0,FFFF, 0000, 00, 04, 02,1E, 42, 00,02, 48

; Room $93D5. Crateria save station
$83:8110             dx FFFF

; Room $93FE. Wrecked Ship entrance
$83:8112             dx 0000, 04F0,FFFF, 0000, 00, 06, 02,18, 01, 00,06, 48

; Room $9461. Pre orange zoomer hall
$83:8122             dx 0000, 00B0,FFFF, 0000, 00, 06, 02,18, 83, 00,00, 48

; Room $948C. Pre moat room
$83:8132             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $94CC. Crateria -> Maridia elevator
$83:8142             dx FFFF

; Room $94FD. Wrecked Ship back door
$83:8144             dx 0000, 04F0,FFFF, 0000, 00, 06, 02,18, 01, 00,04, 48

; Room $9552. Forgotten highway kago shaft
$83:8154             dx FFFF

; Room $957D. Crab maze
$83:8156             dx 0000, 01B0,FFFF, 0000, 00, 06, 02,18, 03, 00,00, 48

; Room $95A8. Forgotten highway elbow
$83:8166             dx FFFF

; Room $95D4. Crateria tube
$83:8168             dx FFFF

; Room $95FF. Moat
$83:816A             dx 0000, 00B0,FFFF, 0000, 00, 06, 02,18, 01, 00,06, 48

; Room $962A. Crateria -> Red Brinstar elevator
$83:817A             dx FFFF

; Room $965B. Gauntlet west
$83:817C             dx 0000, 00C8,FFFF, 0000, 00, 04, 02,1E, 42, 00,02, 00

; Room $968F. Orange zoomer hall
$83:818C             dx FFFF

; Room $96BA, state $96D1. Old Tourian escape shaft - default
$83:818E             dx 0000, FFFF,FFFF, 0000, 00, 0C, 02,30, 00, 00,00, 62

; Room $975C, state $976D. Old Mother Brain room - default
$83:819E             dx 0000, FFFF,FFFF, 0000, 00, 0C, 02,30, 00, 00,00, 62

; Room $97B5, state $97C6. Crateria -> Blue Brinstar elevator - default
$83:81AE             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 00,00, 00

; Room $9804, state $981B. Bomb Torizo - default
; Room $9804, state $9835. Bomb Torizo - area torizo is dead
$83:81BE             dx FFFF

; Room $9879, state $9890. Pre Bomb Torizo hall - default
; Room $9879, state $98AA. Pre Bomb Torizo hall - area torizo is dead
$83:81C0             dx FFFF

; Room $98E2. Pre Crateria map station hall
; Room $990D. Crateria slope
; Room $9938. Crateria -> Green Brinstar elevator
; Room $9969. West Crateria kago hall
; Room $9994. Crateria map station
; Room $99BD. Crateria space pirate shaft
$83:81C2             dx FFFF

; Room $99F9. Crateria spike floor room
$83:81C4             dx 0000, 07E0,FFFF, 0000, 00, 04, 02,1E, 40, 00,02, 48

; Room $9A44, state $9A56. Crateria bomb block hall - default
$83:81D4             dx 0000, FFFF,FFFF, 0000, 00, 00, 28,02, 00, 00,00, 62

; Room $9A90, state $9AA2. Crateria chozo missile - default
$83:81E4             dx 0000, FFFF,FFFF, 0000, 00, 00, 28,02, 00, 00,00, 62

; Room $9E9F, state $9ECB. Morph ball room - event "Zebes is awake" is set
; Room $9F11, state $9F3D. Old Kraid entrance - event "Zebes is awake" is set
; Room $9F64, state $9F90. Blue Brinstar ceiling e-tank hall - event "Zebes is awake" is set
$83:81F4             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $9AD9. Green Brinstar mainstreet
$83:8204             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,00, 00

; Room $9B5B. Spore Spawn's super missile shaft
$83:8214             dx 0000, FFFF,FFFF, 0000, 00, 08, 02,0A, 00, 00,00, 00

; Room $9B9D. Pre Brinstar map room hall
$83:8224             dx FFFF

; Room $9BC8. Early supers room
$83:8226             dx FFFF

; Room $9C07. Brinstar reserve tank room
$83:8228             dx FFFF

; Room $9C35. Brinstar map station
$83:822A             dx FFFF

; Room $9C5E. Fireflea room
$83:822C             dx 0000, FFFF,FFFF, 0000, 00, 24, 02,02, 00, 00,00, 00

; Room $9C89. Green Brinstar missile station
$83:823C             dx FFFF

; Room $9CB3. Dachora room
$83:823E             dx 0000, FFFF,FFFF, 0000, 00, 08, 02,0A, 00, 00,00, 00

; Room $9D19. Charge beam room
$83:824E             dx 0000, FFFF,FFFF, 0000, 00, 08, 02,0A, 00, 00,01, 00

; Room $9D9C. Pre Spore Spawn hall
$83:825E             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,00, 00

; Room $9DC7. Spore Spawn
$83:826E             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 08,00, 00

; Room $9E11. Brinstar super-sidehopper power bomb room
$83:827E             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,02, 00

; Room $9E52. Brinstar diagonal room
$83:828E             dx FFFF

; Room $9E9F, state $9EB1. Morph ball room - default
$83:8290             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 00,00, 00

; Room $9F11, state $9F23. Old Kraid entrance - default
$83:82A0             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 00,00, 00

; Room $9F64, state $9F76. Blue Brinstar ceiling e-tank hall - default
$83:82B0             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 00,00, 00

; Room $9FBA. n00b bridge
$83:82C0             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,02, 00

; Room $9FE5. Etecoon area beetom room
$83:82D0             dx FFFF

; Room $A011. Etecoon area spike hall
$83:82D2             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,00, 00

; Room $A051. Etecoon area super missiles
$83:82E2             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,00, 00

; Room $A07B. Dachora energy station
$83:82F2             dx FFFF

; Room $A0A4. Post Spore Spawn supers hall
$83:82F4             dx 0000, FFFF,FFFF, 0000, 00, 08, 02,0A, 00, 00,00, 00

; Room $A0D2. Pink Brinstar flooded hall
$83:8304             dx 0000, 00A8,FFFF, 0000, 00, 06, 02,18, 03, 00,00, 48

; Room $A107. Blue Brinstar missile room
$83:8314             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $A130. Brinstar wave-gate sidehopper room
$83:8324             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,03, 00

; Room $A15B. Brinstar wave-gate energy tank
$83:8334             dx FFFF

; Room $A184. Spore Spawn save station
$83:8336             dx FFFF

; Room $A1AD. Blue Brinstar boulder room
$83:8338             dx 0000, 00B0,FFFF, 0000, 00, 06, 02,18, 83, 00,02, 48

; Room $A1D8. Blue Brinstar double missile room
$83:8348             dx FFFF

; Room $A201. Green Brinstar mainstreet save station
$83:834A             dx FFFF

; Room $A22A. Etecoon area save station
$83:834C             dx FFFF

; Room $A253. Red Brinstar mainstreet
$83:834E             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 06,03, 00

; Room $A293. Pre x-ray spike hall
$83:835E             dx 0000, FFFF,FFFF, 0000, 00, 24, 02,02, 00, 00,02, 00

; Room $A2CE. X-ray room
$83:836E             dx FFFF

; Room $A2F7. Red Brinstar damage boost hall
$83:8370             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 02,04, 00

; Room $A322. Red Brinstar -> Crateria elevator
$83:8380             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 06,00, 00

; Room $A37C. Red Brinstar power bomb floor room
$83:8390             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,04, 00

; Room $A3AE. Red Brinstar power bomb wall room
$83:83A0             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,04, 00

; Room $A3DD. Red Brinstar skree-duo hall
$83:83B0             dx 0000, 00BE,FFFF, 0000, 00, 06, 02,18, 03, 00,00, 48

; Room $A408. Pre spazer room
$83:83C0             dx 0000, 01BE,FFFF, 0000, 00, 06, 02,18, 03, 00,01, 48

; Room $A447. Spazer room
$83:83D0             dx FFFF

; Room $A471. Kraid's lair zeela room
; Room $A4B1. Kraid's lair beetom room
; Room $A4DA. Kraid's lair kihunter hall
$83:83D2             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 04,00, 00

; Room $A521. Fake Kraid's room
$83:83E2             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,02, 00

; Room $A56B. Pre Kraid room
$83:83F2             dx FFFF

; Room $A59F. Kraid
$83:83F4             dx FFFF

; Room $A5ED. Pre Tourian entrance hall
$83:83F6             dx 0000, FFFF,FFFF, 0000, 00, 0C, 02,30, 00, 80,00, 62

; Room $A618. Red Brinstar energy station
$83:8406             dx FFFF

; Room $A641. Kraid's lair refill station
$83:8408             dx FFFF

; Room $A66A. Tourian entrance
$83:840A             dx 0000, 00B0,01FF, 0000, 00, 26, 02,18, 01, 00,00, 48

; Room $A6A1. Kraid's lair entrance
$83:841A             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 00,00, 00

; Room $A6E2. Varia suit room
$83:842A             dx FFFF

; Room $A70B. Kraid's lair save station
$83:842C             dx FFFF

; Room $A734. Red Brinstar save station
$83:842E             dx FFFF

; Room $A75D. Ice beam tripper hall
$83:8430             dx 0000, 00B8,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,02, 02

; Room $A788. Lava missile room
$83:8440             dx 0000, 01B1,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $A7B3. First hot room
$83:8450             dx 0000, 01D0,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,03, 02

; Room $A7DE. Norfair mainstreet
$83:8460             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 00, 00,00, 02

; Room $A815. Ice beam mockball hall
$83:8470             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $A865. Ice beam practice room
$83:8480             dx 0000, 00B2,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $A890. Ice beam room
$83:8490             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 00, 00,00, 02

; Room $A8B9. Pre ice beam shaft
$83:84A0             dx 0000, 02B8,FFFF, 0000, 00, 02, 02,1E, 03, 1F,03, 02

; Room $A8F8. Crumble block platform shaft
$83:84B0             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 03, 1F,00, 02

; Room $A923. Norfair slope
$83:84C0             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,02, 02

; Room $A98D. Crocomire
$83:84D0             dx 0000, 00C6,FFFF, 0000, 00, 04, 02,1E, 81, 00,01, 02

; Room $A9E5. Hi-jump room
$83:84E0             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 01, 00,00, 02

; Room $AA0E. Norfair grapple ceiling room
$83:84F0             dx 0000, 01B8,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $AA41. Pre hi-jump room
$83:8500             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 01, 00,00, 02

; Room $AA82. Post Crocomire room
$83:8510             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 03, 00,00, 02

; Room $AAB5. Post Crocomire save station
$83:8520             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 01, 00,00, 02

; Room $AADE. Post Crocomire power bombs room
$83:8530             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 03, 1F,00, 02

; Room $AB07. Post Crocomire shaft
$83:8540             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $AB3B. Post Crocomire tidal acid cave
$83:8550             dx 0000, 00C8,FFFF, 0000, 00, 04, 02,1E, 41, 00,02, 00

; Room $AB64. Double lake grapple practice room
$83:8560             dx 0000, 00B8,FFFF, 0000, 00, 06, 02,18, 83, 00,00, 48

; Room $AB8F. Huge jump room
$83:8570             dx 0000, 02B4,FFFF, 0000, 00, 04, 02,1E, 80, 00,00, 00

; Room $ABD2. Grapple practice shaft
$83:8580             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $AC00. Single lake grapple practice room
$83:8590             dx 0000, 00C0,FFFF, 0000, 00, 06, 02,18, 83, 00,00, 48

; Room $AC2B. Grapple room
$83:85A0             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,03, 00

; Room $AC5A. Bubble Norfair reserve tank room
$83:85B0             dx 0000, 00C7,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $AC83. Pre Bubble Norfair reserve tank room
$83:85C0             dx 0000, 00C6,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $ACB3. Bubble Norfair mainstreet
$83:85D0             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 03, 00,02, 02

; Room $ACF0. Speed booster lavaquake
$83:85E0             dx 95BE, 01DA,00B0, 0000, F0, 02, 02,1E, 0B, 1F,02, 02, ; Speed booster room - door 0
                        0000, 01DA,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,02, 02

; Room $AD1B. Speed booster room
$83:8600             dx 0000, 00DA,0000, 0000, 20, 02, 02,1E, 0B, 1F,00, 02

; Room $AD5E. Alcoon shaft
$83:8610             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 03, 1F,02, 02

; Room $ADAD. Pre wave beam room
$83:8620             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 03, 1F,02, 02

; Room $ADDE. Wave beam room
$83:8630             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 01, 00,00, 02

; Room $AE07. Norfair sinking tripper hall
$83:8640             dx 0000, 00C0,FFFF, 0000, 00, 02, 02,1E, 03, 1F,02, 02

; Room $AE32. Volcano room
$83:8650             dx 9672, 02E0,0260, FFF6, 40, 02, 02,1E, 0B, 1F,00, 02, ; Pre lava dive shaft - door 1
                        0000, 0268,FFFF, 0000, 00, 02, 02,1E, 01, 00,00, 02

; Room $AE74. Pre lava dive shaft
$83:8670             dx 0000, 02D4,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $AEB4. Magdollite multiviola hall
$83:8680             dx 0000, 00BE,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $AEDF. Purple shaft
$83:8690             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 03, 1F,03, 02

; Room $AF14. Lava dive room
$83:86A0             dx 0000, 00D0,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,03, 02

; Room $AF3F. Norfair -> Lower Norfair elevator
$83:86B0             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 03, 1F,00, 02

; Room $AF72. Norfair wave gate room
$83:86C0             dx 0000, 01C0,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $AFA3. Norfair long lavaquake hall
$83:86D0             dx 929A, 0108,00C0, FFE0, 40, 02, 02,1E, 0B, 1F,00, 02, ; Lava missile room - door 1
                        0000, 00C8,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $AFCE. Norfair metal floor hall
$83:86F0             dx 0000, 00C5,FFFF, 0000, 00, 02, 02,1E, 0B, 1F,00, 02

; Room $AFFB. Norfair lava-spike hall
$83:8700             dx 0000, 00C6,FFFF, 0000, 00, 02, 02,1E, 03, 1F,02, 02

; Room $B026. Norfair energy station
$83:8710             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 01, 00,00, 02

; Room $B051. Purple farming room
$83:8720             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 03, 1F,00, 02

; Room $B07A. Speed booster lavaquake room
$83:8730             dx 0000, 01B4,FFFF, 0000, 00, 02, 02,1E, 03, 1F,00, 02

; Room $B0B4. Norfair map station
$83:8740             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 01, 00,00, 02

; Room $B0DD. Bubble Norfair save station
$83:8750             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 01, 00,00, 02

; Room $B106. Norfair speed blockade hall
$83:8760             dx FFFF

; Room $B139. Norfair stone zoomer shaft
$83:8762             dx FFFF

; Room $B167. Rock Norfair save station
$83:8764             dx FFFF

; Room $B192. Pre Crocomire save station
$83:8766             dx FFFF

; Room $B1BB. Pre Lower Norfair save station
$83:8768             dx FFFF

; Room $B1E5. Lower Norfair chozo room
$83:876A             dx 9876, 02D2,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00, ; Golden Torizo - door 0
                        0000, 00C8,02D2, 0000, 00, 04, 02,1E, 02, 1F,00, 00

; Room $B236. Lower Norfair mainstreet
$83:878A             dx 0000, 02C1,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00

; Room $B283. Golden Torizo
$83:879A             dx 0000, 02C6,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00

; Room $B2DA. Ripper ii room
$83:87AA             dx 0000, 00B8,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00

; Room $B305. Lower Norfair energy station
$83:87BA             dx FFFF

; Room $B32E. Ridley
$83:87BC             dx 0000, 0210,01D0, 0000, 00, 04, 02,1E, 82, 1F,00, 00

; Room $B37A. Pre Ridley hall
$83:87CC             dx 0000, 00D0,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00

; Room $B3A5. Pre pillars hall
$83:87DC             dx 0000, FFFF,FFFF, 0000, 00, 04, 02,1E, 02, 1F,00, 00

; Room $B3E1. Unused room
$83:87EC             dx 0000, FFFF,FFFF, 0000, 00, 04, 02,1E, 02, 1F,00, 00

; Room $B40A. Lower Norfair multi-level one-way shaft
$83:87FC             dx 0000, FFFF,FFFF, 0000, 00, 04, 02,1E, 02, 1F,00, 00

; Room $B457. Pillars hall
$83:880C             dx 0000, 00E8,0010, FFE0, 50, 04, 02,1E, 82, 1F,00, 00

; Room $B482. Lower Norfair holtz room
$83:881C             dx 0000, 00CD,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00

; Room $B4AD. Lower Norfair wall space pirates shaft
$83:882C             dx 0000, FFFF,FFFF, 0000, 20, 04, 02,1E, 02, 1F,02, 00

; Room $B4E5. Lower Norfair rising acid room
$83:883C             dx 99F6, 00D0,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00, ; Lower Norfair south kihunter shaft - door 1
                        0000, 04E8,00D0, FF80, 60, 04, 02,1E, 82, 1F,02, 00

; Room $B510. Lower Norfair spring ball maze room
$83:885C             dx 0000, FFFF,FFFF, 0000, 00, 04, 02,1E, 02, 1F,02, 00

; Room $B55A. Lower Norfair escape power bomb room
$83:886C             dx 0000, 00B3,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00

; Room $B585. Lower Norfair south kihunter shaft
$83:887C             dx 0000, FFFF,FFFF, 0000, 00, 04, 02,1E, 02, 1F,00, 00

; Room $B5D5. Lower Norfair spike platform room
$83:888C             dx 0000, 02C0,FFFF, 0000, 00, 04, 02,1E, 02, 1F,03, 00

; Room $B62B. Ninja space pirate hall
$83:889C             dx 0000, FFFF,FFFF, 0000, 00, 04, 02,1E, 02, 1F,00, 00

; Room $B656. Lower Norfair north kihunter shaft
$83:88AC             dx 0000, 02D0,FFFF, 0000, 00, 04, 02,1E, 42, 1F,00, 00

; Room $B698. Ridley's energy tank
$83:88BC             dx 0000, 00DD,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00

; Room $B6C1. Screw attack room
$83:88CC             dx 0000, 02DD,FFFF, 0000, 00, 04, 02,1E, 82, 1F,00, 00

; Room $B6EE. Norfair rolling boulder shaft
$83:88DC             dx 0000, FFFF,FFFF, 0000, 00, 24, 02,02, 00, 00,02, 00

; Room $B741. Lower Norfair save station
$83:88EC             dx 0000, FFFF,FFFF, 0000, 00, 02, 02,1E, 01, 00,00, 02
}


;;; $88FC: Door headers ;;;
{
;                        _____________________________________ 0: Destination room header pointer (bank $8F)
;                       |      _______________________________ 2: Elevator properties
;                       |     |    ___________________________ 3: Direction
;                       |     |   |    _______________________ 4: Doorcap X position in blocks
;                       |     |   |   |   ____________________ 5: Doorcap Y position in blocks
;                       |     |   |   |  |    ________________ 6: X screen
;                       |     |   |   |  |   |   _____________ 7: Y screen
;                       |     |   |   |  |   |  |    _________ 8: Distance from door to spawn Samus
;                       |     |   |   |  |   |  |   |      ___ Ah: Custom door ASM to execute (bank $8F)
;                       |     |   |   |  |   |  |   |     |
;                       rrrr, ee, oo, xx,yy, XX,YY, dddd, aaaa

; Room $94CC, door 2. Crateria -> Maridia elevator
; Room $962A, door 2. Crateria -> Red Brinstar elevator
; Room $97B5, door 2. Crateria -> Blue Brinstar elevator
; Room $9938, door 2. Crateria -> Green Brinstar elevator
; Room $9AD9, door 9. Green Brinstar mainstreet
; Room $9E9F, door 3. Morph ball room
; Room $A322, door 5. Red Brinstar -> Crateria elevator
; Room $A66A, door 2. Tourian entrance
; Room $A6A1, door 3. Kraid's lair entrance
; Room $A7DE, door 5. Norfair mainstreet
; Room $AF3F, door 2. Norfair -> Lower Norfair elevator
; Room $B236, door 3. Lower Norfair mainstreet
$83:88FC             dw 0000

; Zebes landing cutscene
; Crateria load station 12h
$83:88FE             dx 91F8, 00, 03, 00,00, 04,00, 8000, 0000 ; Landing site

; Demo set 3, demos 0,2,4
$83:890A             dx 91F8, 00, 03, 00,00, 04,02, 8000, 0000 ; Landing site

; Room $91F8, door 0. Landing site
$83:8916             dx 92FD, 00, 05, 4E,06, 04,00, 8000, 0000 ; Crateria mainstreet

; Room $91F8, door 1. Landing site
$83:8922             dx 95D4, 00, 00, 00,00, 00,00, 8000, 0000 ; Crateria tube

; Room $91F8, door 2. Landing site
$83:892E             dx 92B3, 00, 05, 4E,06, 04,00, 8000, 0000 ; Gauntlet east

; Room $91F8, door 3. Landing site
$83:893A             dx 93AA, 00, 04, 01,06, 00,00, 8000, 0000 ; Landing site power bombs cave

; Room $92B3, door 0. Gauntlet east
$83:8946             dx 91F8, 00, 04, 01,26, 00,02, 8000, B997 ; Landing site

; Room $92B3, door 1. Gauntlet east
$83:8952             dx 965B, 00, 05, 5E,06, 05,00, 8000, 0000 ; Gauntlet west

; Room $92FD, door 0. Crateria mainstreet
$83:895E             dx 990D, 00, 05, 5E,06, 05,00, 8000, 0000 ; Crateria slope

; Crateria load station 0/10h
; Room $92FD, door 1. Crateria mainstreet
$83:896A             dx 91F8, 00, 04, 01,46, 00,04, 8000, 0000 ; Landing site

; Room $92FD, door 2. Crateria mainstreet
$83:8976             dx 98E2, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Crateria map station hall

; Room $92FD, door 3. Crateria mainstreet
$83:8982             dx 9879, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Bomb Torizo hall

; Room $92FD, door 4. Crateria mainstreet
$83:898E             dx 96BA, 00, 06, 16,02, 01,00, 8000, 0000 ; Old Tourian escape shaft

; Crateria load station 1
; Room $92FD, door 5. Crateria mainstreet
$83:899A             dx 93D5, 00, 05, 0E,06, 00,00, 8000, 0000 ; Crateria save station

; Room $92FD, door 6. Crateria mainstreet
$83:89A6             dx 9A44, 00, 05, 1E,06, 01,00, 8000, 0000 ; Crateria bomb block hall

; Room $93AA, door 0. Landing site power bombs cave
$83:89B2             dx 91F8, 00, 05, 8E,16, 08,01, 8000, 0000 ; Landing site

; Room $93D5, door 0. Crateria save station
$83:89BE             dx 92FD, 00, 04, 11,26, 01,02, 8000, B981 ; Crateria mainstreet

; Room $93FE, door 0. Wrecked Ship entrance
$83:89CA             dx 95FF, 00, 05, 1E,06, 01,00, 8000, 0000 ; Moat

; Room $93FE, door 1. Wrecked Ship entrance
$83:89D6             dx CA08, 50, 04, 01,06, 00,00, 8000, B971 ; Wrecked Ship entrance treadmill

; Room $93FE, door 2. Wrecked Ship entrance
$83:89E2             dx 9461, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre orange zoomer hall

; Room $93FE, door 3. Wrecked Ship entrance
$83:89EE             dx CA52, 40, 04, 01,06, 00,00, 8000, 0000 ; Wrecked Ship attic

; Room $93FE, door 4. Wrecked Ship entrance
$83:89FA             dx C98E, 40, 04, 21,06, 02,00, 8000, B9B3 ; Wrecked Ship chozo room

; Room $93FE, door 5. Wrecked Ship entrance
$83:8A06             dx CE40, 40, 04, 01,06, 00,00, 8000, 0000 ; Gravity suit room

; Room $9461, door 0. Pre orange zoomer hall
$83:8A12             dx 93FE, 00, 05, 2E,26, 02,02, 8000, 0000 ; Wrecked Ship entrance

; Room $9461, door 1. Pre orange zoomer hall
$83:8A1E             dx 968F, 00, 04, 01,06, 00,00, 8000, 0000 ; Orange zoomer hall

; Room $948C, door 0. Pre moat room
$83:8A2A             dx 95D4, 00, 01, 00,00, 00,00, 8000, 0000 ; Crateria tube

; Room $948C, door 1. Pre moat room
$83:8A36             dx 95FF, 00, 04, 01,06, 00,00, 8000, 0000 ; Moat

; Crateria load station 9
; Room $948C, door 2. Pre moat room
$83:8A42             dx 962A, 00, 06, 06,02, 00,00, 8000, 0000 ; Crateria -> Red Brinstar elevator

; Room $94CC, door 0. Crateria -> Maridia elevator
$83:8A4E             dx 95A8, 00, 07, 06,0D, 00,00, 01C0, 0000 ; Forgotten highway elbow

; Room $94CC, door 1. Crateria -> Maridia elevator
$83:8A5A             dx D30B, D0, 02, 00,00, 00,00, 0000, 0000 ; Maridia -> Crateria elevator

; Room $94FD, door 0. Wrecked Ship back door
$83:8A66             dx CBD5, 40, 05, 0E,16, 00,01, 8000, 0000 ; Wrecked Ship east exit

; Room $94FD, door 1. Wrecked Ship back door
$83:8A72             dx 9552, 00, 04, 01,06, 00,00, 8000, 0000 ; Forgotten highway kago shaft

; Crateria load station 11h
; Room $9552, door 0. Forgotten highway kago shaft
$83:8A7E             dx 94FD, 00, 05, 6E,46, 06,04, 8000, 0000 ; Wrecked Ship back door

; Room $9552, door 1. Forgotten highway kago shaft
$83:8A8A             dx 957D, 00, 06, 36,02, 03,00, 8000, 0000 ; Crab maze

; Room $957D, door 0. Crab maze
$83:8A96             dx 9552, 00, 07, 06,3D, 00,03, 01C0, 0000 ; Forgotten highway kago shaft

; Room $95A8, door 0. Forgotten highway elbow
$83:8AA2             dx 957D, 00, 04, 01,16, 00,01, 8000, 0000 ; Crab maze

; Room $957D, door 1. Crab maze
$83:8AAE             dx 95A8, 00, 05, 0E,06, 00,00, 8000, 0000 ; Forgotten highway elbow

; Crateria load station 8
; Room $95A8, door 1. Forgotten highway elbow
$83:8ABA             dx 94CC, 00, 06, 06,02, 00,00, 8000, 0000 ; Crateria -> Maridia elevator

; Room $95D4, door 0. Crateria tube
$83:8AC6             dx 91F8, 00, 05, 8E,46, 08,04, 8000, 0000 ; Landing site

; Room $95D4, door 1. Crateria tube
$83:8AD2             dx 948C, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre moat room

; Room $95FF, door 0. Moat
$83:8ADE             dx 948C, 00, 05, 2E,06, 02,00, 8000, 0000 ; Pre moat room

; Room $95FF, door 1. Moat
$83:8AEA             dx 93FE, 00, 04, 01,46, 00,04, 8000, 0000 ; Wrecked Ship entrance

; Room $962A, door 0. Crateria -> Red Brinstar elevator
$83:8AF6             dx 948C, 00, 07, 16,2D, 01,02, 01C0, B9F1 ; Pre moat room

; Room $962A, door 1. Crateria -> Red Brinstar elevator
$83:8B02             dx A322, E0, 02, 00,00, 00,00, 0000, BA21 ; Red Brinstar -> Crateria elevator

; Room $965B, door 0. Gauntlet west
$83:8B0E             dx 92B3, 00, 04, 01,06, 00,00, 8000, 0000 ; Gauntlet east

; Room $965B, door 1. Gauntlet west
$83:8B1A             dx 99BD, 00, 05, 0E,06, 00,00, 8000, BA2C ; Crateria space pirate shaft

; Room $968F, door 0. Orange zoomer hall
$83:8B26             dx 9461, 00, 05, 1E,06, 01,00, 8000, 0000 ; Pre orange zoomer hall

; Room $968F, door 1. Orange zoomer hall
$83:8B32             dx C98E, 40, 04, 01,16, 00,01, 00A0, B9CA ; Wrecked Ship chozo room

; Room $96BA, door 0. Old Tourian escape shaft
$83:8B3E             dx 92FD, 00, 07, 16,4D, 01,04, 01C0, B981 ; Crateria mainstreet

; Room $96BA, door 1. Old Tourian escape shaft
$83:8B4A             dx 99F9, 00, 04, 01,06, 00,00, 8000, 0000 ; Crateria spike floor room

; Room $96BA, door 2. Old Tourian escape shaft
$83:8B56             dx 99F9, 00, 04, 01,76, 00,07, 8000, 0000 ; Crateria spike floor room

; Room $96BA, door 3. Old Tourian escape shaft
$83:8B62             dx 975C, 00, 04, 01,06, 00,00, 8000, 0000 ; Old Mother Brain room

; Room $96BA, door 4. Old Tourian escape shaft
$83:8B6E             dx DEDE, 00, 05, 2E,16, 02,01, 8000, 0000 ; Escape room 4

; Room $975C, door 0. Old Mother Brain room
$83:8B7A             dx 96BA, 00, 05, 1E,86, 01,08, 8000, 0000 ; Old Tourian escape shaft

; Crateria load station Ah
; Room $975C, door 1. Old Mother Brain room
$83:8B86             dx 97B5, 00, 04, 01,06, 00,00, 8000, 0000 ; Crateria -> Blue Brinstar elevator

; Room $97B5, door 0. Crateria -> Blue Brinstar elevator
$83:8B92             dx 975C, 00, 05, 2E,06, 02,00, 8000, 0000 ; Old Mother Brain room

; Room $97B5, door 1. Crateria -> Blue Brinstar elevator
$83:8B9E             dx 9E9F, F0, 02, 00,00, 05,00, 0000, 0000 ; Morph ball room

; Room $9804, door 0. Bomb Torizo
$83:8BAA             dx 9879, 00, 05, 2E,06, 02,00, 8000, 0000 ; Pre Bomb Torizo hall

; Room $9879, door 0. Pre Bomb Torizo hall
$83:8BB6             dx 92FD, 00, 05, 3E,26, 03,02, 8000, B9A2 ; Crateria mainstreet

; Room $9879, door 1. Pre Bomb Torizo hall
$83:8BC2             dx 9804, 00, 04, 01,06, 00,00, 8000, 0000 ; Bomb Torizo

; Room $98E2, door 0. Pre Crateria map station hall
$83:8BCE             dx 92FD, 00, 05, 1E,36, 01,03, 8000, B981 ; Crateria mainstreet

; Room $98E2, door 1. Pre Crateria map station hall
$83:8BDA             dx 9994, 00, 04, 01,06, 00,00, 8000, 0000 ; Crateria map station

; Room $990D, door 0. Crateria slope
$83:8BE6             dx 99BD, 00, 05, 0E,46, 00,04, 8000, 0000 ; Crateria space pirate shaft

; Room $990D, door 1. Crateria slope
$83:8BF2             dx 92FD, 00, 04, 01,06, 00,00, 8000, B98C ; Crateria mainstreet

; Room $9938, door 0. Crateria -> Green Brinstar elevator
$83:8BFE             dx 9969, 00, 04, 01,06, 00,00, 8000, 0000 ; West Crateria kago hall

; Room $9938, door 1. Crateria -> Green Brinstar elevator
$83:8C0A             dx 9AD9, C0, 02, 00,00, 00,00, 0000, BD25 ; Green Brinstar mainstreet

; Room $9969, door 0. West Crateria kago hall
$83:8C16             dx 99BD, 00, 04, 01,66, 00,06, 8000, 0000 ; Crateria space pirate shaft

; Crateria load station Bh
; Room $9969, door 1. West Crateria kago hall
$83:8C22             dx 9938, 00, 05, 0E,06, 00,00, 8000, 0000 ; Crateria -> Green Brinstar elevator

; Room $9994, door 0. Crateria map station
$83:8C2E             dx 98E2, 00, 05, 2E,06, 02,00, 8000, 0000 ; Pre Crateria map station hall

; Room $99BD, door 0. Crateria space pirate shaft
$83:8C3A             dx 990D, 00, 04, 01,26, 00,02, 8000, 0000 ; Crateria slope

; Room $99BD, door 1. Crateria space pirate shaft
$83:8C46             dx 9969, 00, 05, 3E,06, 03,00, 8000, 0000 ; West Crateria kago hall

; Room $99BD, door 2. Crateria space pirate shaft
$83:8C52             dx A5ED, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Tourian entrance hall

; Room $99BD, door 3. Crateria space pirate shaft
$83:8C5E             dx 965B, 00, 04, 01,06, 00,00, 8000, BA16 ; Gauntlet west

; Room $99F9, door 0. Crateria spike floor room
$83:8C6A             dx 96BA, 00, 05, 2E,06, 02,00, 8000, BA00 ; Old Tourian escape shaft

; Room $99F9, door 1. Crateria spike floor room
$83:8C76             dx 96BA, 00, 05, 2E,76, 02,07, 8000, BA0B ; Old Tourian escape shaft

; Room $9A44, door 0. Crateria bomb block hall
$83:8C82             dx 9A90, 00, 05, 0E,06, 00,00, 8000, 0000 ; Crateria chozo missile

; Room $9A44, door 1. Crateria bomb block hall
$83:8C8E             dx 92FD, 00, 04, 11,36, 01,03, 8000, B981 ; Crateria mainstreet

; Room $9A90, door 0. Crateria chozo missile
$83:8C9A             dx 9A44, 00, 04, 01,06, 00,00, 8000, 0000 ; Crateria bomb block hall

; Room $9AD9, door 0. Green Brinstar mainstreet
$83:8CA6             dx 9938, D0, 03, 00,00, 00,00, 0000, BE36 ; Crateria -> Green Brinstar elevator

; Room $9AD9, door 1. Green Brinstar mainstreet
$83:8CB2             dx 9B9D, 00, 05, 2E,06, 02,00, 8000, 0000 ; Pre Brinstar map room hall

; Room $9AD9, door 2. Green Brinstar mainstreet
$83:8CBE             dx 9FE5, 00, 05, 0E,06, 00,00, 8000, 0000 ; Etecoon area beetom room

; Room $9AD9, door 3. Green Brinstar mainstreet
$83:8CCA             dx 9C5E, 00, 05, 2E,06, 02,00, 8000, 0000 ; Fireflea room

; Room $9AD9, door 4. Green Brinstar mainstreet
$83:8CD6             dx 9BC8, 00, 04, 01,16, 00,01, 8000, 0000 ; Early supers room

; Room $9AD9, door 5. Green Brinstar mainstreet
$83:8CE2             dx 9CB3, 00, 04, 01,06, 00,00, 8000, BD6C ; Dachora room

; Room $9AD9, door 6. Green Brinstar mainstreet
; The doorcap X position is wrong (which doesn't matter because this door is behind a grey doorcap)
$83:8CEE             dx 9AD9, 00, 04, 01,76, 01,07, 8000, BD25 ; Green Brinstar mainstreet

; Room $9AD9, door 7. Green Brinstar mainstreet
$83:8CFA             dx A011, 00, 05, 4E,16, 04,01, 8000, BD16 ; Etecoon area spike hall

; Room $9AD9, door 8. Green Brinstar mainstreet
$83:8D06             dx 9AD9, 00, 05, 0E,76, 00,07, 8000, BD07 ; Green Brinstar mainstreet

; Brinstar load station 1
; Room $9AD9, door Ah. Green Brinstar mainstreet
$83:8D12             dx A201, 00, 05, 0E,06, 00,00, 8000, 0000 ; Green Brinstar mainstreet save station

; Room $9B5B, door 0. Spore Spawn's super missile shaft
$83:8D1E             dx A0A4, 00, 05, 2E,06, 02,00, 8000, 0000 ; Post Spore Spawn supers hall

; Room $9B5B, door 1. Spore Spawn's super missile shaft
$83:8D2A             dx 9DC7, 00, 05, 0E,06, 00,00, 8000, 0000 ; Spore Spawn

; Room $9B9D, door 0. Pre Brinstar map room hall
$83:8D36             dx 9C35, 00, 05, 0E,06, 00,00, 8000, 0000 ; Brinstar map station

; Brinstar load station 8 / 10h
; Room $9B9D, door 1. Pre Brinstar map room hall
$83:8D42             dx 9AD9, 00, 04, 01,46, 00,04, 8000, 0000 ; Green Brinstar mainstreet

; Room $9BC8, door 0. Early supers room
$83:8D4E             dx 9AD9, 00, 05, 0E,46, 00,04, 8000, 0000 ; Green Brinstar mainstreet

; Room $9BC8, door 1. Early supers room
$83:8D5A             dx 9C07, 00, 04, 01,06, 00,00, 8000, 0000 ; Brinstar reserve tank room

; Room $9C07, door 0. Brinstar reserve tank room
$83:8D66             dx 9BC8, 00, 05, 2E,16, 02,01, 8000, 0000 ; Early supers room

; Room $9C35, door 0. Brinstar map station
$83:8D72             dx 9B9D, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Brinstar map room hall

; Room $9C5E, door 0. Fireflea room
$83:8D7E             dx 9C89, 00, 05, 0E,06, 00,00, 8000, 0000 ; Green Brinstar missile station

; Room $9C5E, door 1. Fireflea room
$83:8D8A             dx 9AD9, 00, 04, 01,66, 00,06, 8000, 0000 ; Green Brinstar mainstreet

; Room $9C89, door 0. Green Brinstar missile station
$83:8D96             dx 9C5E, 00, 04, 01,16, 00,01, 8000, 0000 ; Fireflea room

; Room $9CB3, door 0. Dachora room
$83:8DA2             dx 9AD9, 00, 05, 0E,66, 00,06, 8000, 0000 ; Green Brinstar mainstreet

; Room $9CB3, door 1. Dachora room
$83:8DAE             dx 9D19, 00, 04, 21,26, 02,02, 8000, 0000 ; Charge beam room

; Room $9CB3, door 2. Dachora room
$83:8DBA             dx A07B, 00, 05, 0E,06, 00,00, 8000, 0000 ; Dachora energy station

; Room $9D19, door 0. Charge beam room
$83:8DC6             dx 9D9C, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Spore Spawn hall

; Room $9D19, door 1. Charge beam room
$83:8DD2             dx 9CB3, 00, 05, 6E,06, 06,00, 8000, 0000 ; Dachora room

; Room $9D19, door 2. Charge beam room
$83:8DDE             dx 9E11, 00, 05, 1E,16, 01,01, 8000, BD30 ; Brinstar super-sidehopper power bomb room

; Room $9D19, door 3. Charge beam room
$83:8DEA             dx 9E52, 00, 04, 01,06, 00,00, 8000, 0000 ; Brinstar diagonal room

; Brinstar load station 0
; Room $9D19, door 4. Charge beam room
$83:8DF6             dx A184, 00, 05, 0E,06, 00,00, 8000, 0000 ; Spore Spawn save station

; Room $9D19, door 5. Charge beam room
$83:8E02             dx 9E11, 00, 01, 1E,06, 01,00, 8000, 0000 ; Brinstar super-sidehopper power bomb room

; Room $9D19, door 6. Charge beam room
$83:8E0E             dx A0D2, 00, 05, 6E,06, 06,00, 8000, 0000 ; Pink Brinstar flooded hall

; Room $9D19, door 7. Charge beam room
$83:8E1A             dx A130, 00, 04, 01,16, 00,01, 8000, 0000 ; Brinstar wave-gate sidehopper room

; Room $9D19, door 8. Charge beam room
$83:8E26             dx A0A4, 00, 04, 01,06, 00,00, 8000, 0000 ; Post Spore Spawn supers hall

; Room $9D9C, door 0. Pre Spore Spawn hall
$83:8E32             dx 9D19, 00, 05, 3E,06, 03,00, 8000, 0000 ; Charge beam room

; Room $9D9C, door 1. Pre Spore Spawn hall
$83:8E3E             dx 9DC7, 00, 07, 06,2E, 00,02, 8000, 0000 ; Spore Spawn

; Room $9DC7, door 0. Spore Spawn
$83:8E4A             dx 9B5B, 00, 04, 01,06, 00,00, 8000, BDC0 ; Spore Spawn's super missile shaft

; Room $9DC7, door 1. Spore Spawn
$83:8E56             dx 9D9C, 00, 06, 36,03, 03,00, 8000, 0000 ; Pre Spore Spawn hall

; Brinstar load station 12h
; Room $9E11, door 0. Brinstar super-sidehopper power bomb room
$83:8E62             dx 9D19, 00, 00, 00,00, 02,03, 8000, 0000 ; Charge beam room

; Room $9E11, door 1. Brinstar super-sidehopper power bomb room
$83:8E6E             dx 9D19, 00, 04, 21,46, 02,04, 8000, 0000 ; Charge beam room

; Room $9E52, door 0. Brinstar diagonal room
$83:8E7A             dx 9D19, 00, 05, 3E,66, 03,06, 8000, 0000 ; Charge beam room

; Brinstar load station 9
; Room $9E52, door 1. Brinstar diagonal room
$83:8E86             dx 9E9F, 00, 04, 01,26, 00,02, 8000, 0000 ; Morph ball room

; Room $9E52, door 2. Brinstar diagonal room
$83:8E92             dx 9FBA, 00, 04, 01,06, 00,00, 8000, 0000 ; n00b bridge

; Room $9E9F, door 0. Morph ball room
$83:8E9E             dx 9E52, 00, 05, 1E,06, 01,00, 8000, 0000 ; Brinstar diagonal room

; Room $9E9F, door 1. Morph ball room
$83:8EAA             dx 9F11, 00, 04, 01,06, 00,00, 8000, 0000 ; Old Kraid entrance

; Room $9E9F, door 2. Morph ball room
$83:8EB6             dx 97B5, E0, 03, 00,00, 00,00, 0000, 0000 ; Crateria -> Blue Brinstar elevator

; Room $9F11, door 0. Old Kraid entrance
$83:8EC2             dx 9E9F, 00, 05, 7E,26, 07,02, 8000, 0000 ; Morph ball room

; Room $9F11, door 1. Old Kraid entrance
$83:8ECE             dx 9F64, 00, 04, 01,26, 00,02, 8000, 0000 ; Blue Brinstar ceiling e-tank hall

; Room $9F11, door 2. Old Kraid entrance
$83:8EDA             dx A107, 00, 05, 0E,06, 00,00, 8000, 0000 ; Blue Brinstar missile room

; Room $9F64, door 0. Blue Brinstar ceiling e-tank hall
$83:8EE6             dx 9F11, 00, 05, 0E,06, 00,00, 8000, 0000 ; Old Kraid entrance

; Room $9F64, door 1. Blue Brinstar ceiling e-tank hall
$83:8EF2             dx A1AD, 00, 05, 1E,06, 01,00, 8000, 0000 ; Blue Brinstar boulder room

; Room $9FBA, door 0. n00b bridge
$83:8EFE             dx 9E52, 00, 05, 7E,36, 07,03, 8000, 0000 ; Brinstar diagonal room

; Room $9FBA, door 1. n00b bridge
$83:8F0A             dx A253, 00, 04, 01,46, 00,04, 8000, 0000 ; Red Brinstar mainstreet

; Room $9FE5, door 0. Etecoon area beetom room
$83:8F16             dx 9AD9, 00, 04, 01,A6, 00,0A, 8000, BD07 ; Green Brinstar mainstreet

; Room $9FE5, door 1. Etecoon area beetom room
$83:8F22             dx A011, 00, 05, 1E,06, 01,00, 8000, 0000 ; Etecoon area spike hall

; Room $A011, door 0. Etecoon area spike hall
$83:8F2E             dx 9FE5, 00, 04, 01,06, 00,00, 8000, 0000 ; Etecoon area beetom room

; Room $A011, door 1. Etecoon area spike hall
$83:8F3A             dx A051, 00, 05, 0E,06, 00,00, 8000, 0000 ; Etecoon area super missiles

; Room $A011, door 2. Etecoon area spike hall
$83:8F46             dx 9AD9, 00, 04, 21,B6, 02,0B, 8000, BD25 ; Green Brinstar mainstreet

; Brinstar load station 2
; Room $A011, door 3. Etecoon area spike hall
$83:8F52             dx A22A, 00, 05, 0E,06, 00,00, 8000, 0000 ; Etecoon area save station

; Room $A051, door 0. Etecoon area super missiles
$83:8F5E             dx A011, 00, 04, 01,06, 00,00, 8000, 0000 ; Etecoon area spike hall

; Room $A07B, door 0. Dachora energy station
$83:8F6A             dx 9CB3, 00, 04, 01,66, 00,06, 8000, BD50 ; Dachora room

; Room $A0A4, door 0. Post Spore Spawn supers hall
$83:8F76             dx 9B5B, 00, 04, 01,86, 00,08, 8000, 0000 ; Spore Spawn's super missile shaft

; Room $A0A4, door 1. Post Spore Spawn supers hall
$83:8F82             dx 9D19, 00, 05, 4E,56, 04,05, 8000, BD5B ; Charge beam room

; Room $A0D2, door 0. Pink Brinstar flooded hall
$83:8F8E             dx 9D19, 00, 04, 01,96, 00,09, 8000, BD77 ; Charge beam room

; Unused. Room $A0D2, door 1. Pink Brinstar flooded hall
$83:8F9A             dx A641, 00, 06, 16,03, 01,00, 8000, 0000 ; Kraid's lair refill station

; Room $A107, door 0. Blue Brinstar missile room
$83:8FA6             dx 9F11, 00, 04, 01,16, 00,01, 8000, BE25 ; Old Kraid entrance

; Room $A130, door 0. Brinstar wave-gate sidehopper room
$83:8FB2             dx 9D19, 00, 05, 3E,46, 03,04, 8000, 0000 ; Charge beam room

; Room $A130, door 1. Brinstar wave-gate sidehopper room
$83:8FBE             dx A15B, 00, 04, 01,06, 00,00, 8000, 0000 ; Brinstar wave-gate energy tank

; Room $A15B, door 0. Brinstar wave-gate energy tank
$83:8FCA             dx A130, 00, 05, 1E,16, 01,01, 8000, 0000 ; Brinstar wave-gate sidehopper room

; Room $A184, door 0. Spore Spawn save station
$83:8FD6             dx 9D19, 00, 04, 11,06, 01,00, 8000, BE00 ; Charge beam room

; Room $A1AD, door 0. Blue Brinstar boulder room
$83:8FE2             dx 9F64, 00, 04, 21,06, 02,00, 8000, BD8A ; Blue Brinstar ceiling e-tank hall

; Room $A1AD, door 1. Blue Brinstar boulder room
$83:8FEE             dx A1D8, 00, 05, 0E,06, 00,00, 8000, 0000 ; Blue Brinstar double missile room

; Room $A1D8, door 0. Blue Brinstar double missile room
$83:8FFA             dx A1AD, 00, 04, 01,06, 00,00, 8000, 0000 ; Blue Brinstar boulder room

; Room $A201, door 0. Green Brinstar mainstreet save station
$83:9006             dx 9AD9, 00, 04, 01,56, 00,05, 8000, 0000 ; Green Brinstar mainstreet

; Room $A22A, door 0. Etecoon area save station
$83:9012             dx A011, 00, 04, 01,16, 00,01, 8000, BD16 ; Etecoon area spike hall

; Room $A253, door 0. Red Brinstar mainstreet
$83:901E             dx A2F7, 00, 04, 01,06, 00,00, 8000, 0000 ; Red Brinstar damage boost hall

; Room $A253, door 1. Red Brinstar mainstreet
$83:902A             dx 9FBA, 00, 05, 5E,06, 05,00, 8000, 0000 ; n00b bridge

; Room $A253, door 2. Red Brinstar mainstreet
$83:9036             dx A293, 00, 05, 7E,06, 07,00, 8000, 0000 ; Pre x-ray spike hall

; Room $A253, door 3. Red Brinstar mainstreet
$83:9042             dx A3DD, 00, 04, 01,06, 00,00, 8000, 0000 ; Red Brinstar skree-duo hall

; Room $A253, door 4. Red Brinstar mainstreet
$83:904E             dx A618, 00, 05, 0E,06, 00,00, 8000, 0000 ; Red Brinstar energy station

; Room $A293, door 0. Pre x-ray spike hall
$83:905A             dx A2CE, 00, 05, 1E,06, 01,00, 8000, 0000 ; X-ray room

; Room $A293, door 1. Pre x-ray spike hall
$83:9066             dx A253, 00, 04, 01,66, 00,06, 8000, 0000 ; Red Brinstar mainstreet

; Room $A2CE, door 0. X-ray room
$83:9072             dx A293, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre x-ray spike hall

; Room $A2F7, door 0. Red Brinstar damage boost hall
$83:907E             dx A253, 00, 05, 0E,06, 00,00, 8000, 0000 ; Red Brinstar mainstreet

; Brinstar load station Ah
; Room $A2F7, door 1. Red Brinstar damage boost hall
$83:908A             dx A322, 00, 04, 01,56, 00,05, 8000, BE1A ; Red Brinstar -> Crateria elevator

; Room $A322, door 0. Red Brinstar -> Crateria elevator
$83:9096             dx A3AE, 00, 05, 2E,06, 02,00, 8000, 0000 ; Red Brinstar power bomb wall room

; Room $A322, door 1. Red Brinstar -> Crateria elevator
$83:90A2             dx A37C, 00, 05, 1E,06, 01,00, 8000, 0000 ; Red Brinstar power bomb floor room

; Room $A322, door 2. Red Brinstar -> Crateria elevator
$83:90AE             dx A2F7, 00, 05, 2E,06, 02,00, 8000, 0000 ; Red Brinstar damage boost hall

; Room $A322, door 3. Red Brinstar -> Crateria elevator
$83:90BA             dx 962A, F0, 03, 00,00, 00,00, 0000, 0000 ; Crateria -> Red Brinstar elevator

; Room $A322, door 4. Red Brinstar -> Crateria elevator
$83:90C6             dx D104, 40, 04, 01,06, 00,00, 8000, BDAF ; Maridia -> Red Brinstar room

; Brinstar load station 4
; Room $A322, door 6. Red Brinstar -> Crateria elevator
$83:90D2             dx A734, 00, 04, 01,06, 00,00, 8000, 0000 ; Red Brinstar save station

; Room $A37C, door 0. Red Brinstar power bomb floor room
$83:90DE             dx A322, 00, 04, 01,36, 00,03, 8000, 0000 ; Red Brinstar -> Crateria elevator

; Room $A3AE, door 0. Red Brinstar power bomb wall room
$83:90EA             dx A322, 00, 04, 01,76, 00,07, 8000, BE0B ; Red Brinstar -> Crateria elevator

; Room $A3DD, door 0. Red Brinstar skree-duo hall
$83:90F6             dx A253, 00, 05, 0E,96, 00,09, 8000, BDA0 ; Red Brinstar mainstreet

; Room $A3DD, door 1. Red Brinstar skree-duo hall
$83:9102             dx A408, 00, 04, 01,16, 00,01, 8000, 0000 ; Pre spazer room

; Room $A408, door 0. Pre spazer room
$83:910E             dx A3DD, 00, 05, 1E,06, 01,00, 8000, 0000 ; Red Brinstar skree-duo hall

; Room $A408, door 1. Pre spazer room
$83:911A             dx CF54, 40, 04, 01,06, 00,00, 8000, 0000 ; n00b tube west

; Room $A408, door 2. Pre spazer room
$83:9126             dx A447, 00, 04, 01,06, 00,00, 8000, 0000 ; Spazer room

; Room $A447, door 0. Spazer room
$83:9132             dx A408, 00, 05, 1E,06, 01,00, 8000, BDF1 ; Pre spazer room

; Room $A471, door 0. Kraid's lair zeela room
$83:913E             dx A6A1, 00, 05, 2E,06, 02,00, 8000, BD3F ; Kraid's lair entrance

; Room $A471, door 1. Kraid's lair zeela room
$83:914A             dx A4B1, 00, 05, 0E,06, 00,00, 8000, 0000 ; Kraid's lair beetom room

; Room $A471, door 2. Kraid's lair zeela room
$83:9156             dx A4DA, 00, 07, 06,0C, 00,00, 0240, 0000 ; Kraid's lair kihunter hall

; Room $A4B1, door 0. Kraid's lair beetom room
$83:9162             dx A471, 00, 04, 01,16, 00,01, 8000, 0000 ; Kraid's lair zeela room

; Room $A4DA, door 0. Kraid's lair kihunter hall
$83:916E             dx A471, 00, 06, 16,13, 01,01, 01C0, 0000 ; Kraid's lair zeela room

; Room $A4DA, door 1. Kraid's lair kihunter hall
$83:917A             dx A521, 00, 04, 01,06, 00,00, 8000, 0000 ; Fake Kraid's room

; Brinstar load station 3
; Room $A4DA, door 2. Kraid's lair kihunter hall
$83:9186             dx A70B, 00, 04, 01,06, 00,00, 8000, 0000 ; Kraid's lair save station

; Room $A521, door 0. Fake Kraid's room
$83:9192             dx A4DA, 00, 05, 1E,16, 01,01, 8000, 0000 ; Kraid's lair kihunter hall

; Room $A521, door 1. Fake Kraid's room
$83:919E             dx A56B, 00, 04, 01,16, 00,01, 8000, 0000 ; Pre Kraid room

; Room $A56B, door 0. Pre Kraid room
$83:91AA             dx A521, 00, 05, 5E,06, 05,00, 8000, 0000 ; Fake Kraid's room

; Room $A56B, door 1. Pre Kraid room
$83:91B6             dx A59F, 00, 04, 01,16, 00,01, 8000, 0000 ; Kraid

; Room $A56B, door 2. Pre Kraid room
$83:91C2             dx A641, 00, 04, 01,06, 00,00, 8000, 0000 ; Kraid's lair refill station

; Brinstar load station 11h
; Room $A59F, door 0. Kraid
$83:91CE             dx A56B, 00, 05, 1E,16, 01,01, 8000, 0000 ; Pre Kraid room

; Room $A59F, door 1. Kraid
$83:91DA             dx A6E2, 00, 04, 01,06, 00,00, 8000, 0000 ; Varia suit room

; Room $A5ED, door 0. Pre Tourian entrance hall
$83:91E6             dx 99BD, 00, 05, 0E,66, 00,06, 8000, 0000 ; Crateria space pirate shaft

; Crateria load station Ch
; Room $A5ED, door 1. Pre Tourian entrance hall
$83:91F2             dx A66A, 00, 04, 01,06, 00,00, 8000, 0000 ; Tourian entrance

; Room $A618, door 0. Red Brinstar energy station
$83:91FE             dx A253, 00, 04, 01,96, 00,09, 8000, BDA0 ; Red Brinstar mainstreet

; Room $A641, door 0. Kraid's lair refill station
$83:920A             dx A56B, 00, 05, 0E,06, 00,00, 8000, BD95 ; Pre Kraid room

; Room $A66A, door 0. Tourian entrance
$83:9216             dx A5ED, 00, 05, 4E,06, 04,00, 8000, 0000 ; Pre Tourian entrance hall

; Room $A66A, door 1. Tourian entrance
$83:9222             dx DAAE, D0, 02, 00,00, 00,00, 0000, 0000 ; Tourian -> Crateria elevator

; Room $A6A1, door 0. Kraid's lair entrance
$83:922E             dx CF80, 40, 05, 0E,16, 00,01, 8000, BDD1 ; n00b tube east

; Room $A6A1, door 1. Kraid's lair entrance
$83:923A             dx A471, 00, 04, 01,06, 00,00, 8000, 0000 ; Kraid's lair zeela room

; Room $A6A1, door 2. Kraid's lair entrance
$83:9246             dx A7DE, C0, 02, 00,00, 00,00, 0000, 0000 ; Norfair mainstreet

; Room $A6E2, door 0. Varia suit room
$83:9252             dx A59F, 00, 05, 1E,16, 01,01, 8000, 0000 ; Kraid

; Room $A70B, door 0. Kraid's lair save station
$83:925E             dx A4DA, 00, 05, 3E,06, 03,00, 8000, BDE2 ; Kraid's lair kihunter hall

; Room $A734, door 0. Red Brinstar save station
$83:926A             dx A322, 00, 05, 0E,46, 00,04, 8000, 0000 ; Red Brinstar -> Crateria elevator

; Room $A75D, door 0. Ice beam tripper hall
$83:9276             dx A815, 00, 04, 31,26, 03,02, 8000, 0000 ; Ice beam mockball hall

; Room $A75D, door 1. Ice beam tripper hall
$83:9282             dx A8B9, 00, 05, 0E,26, 00,02, 8000, 0000 ; Pre ice beam shaft

; Room $A788, door 0. Lava missile room
$83:928E             dx A7B3, 00, 05, 2E,06, 02,00, 8000, 0000 ; First hot room

; Room $A788, door 1. Lava missile room
$83:929A             dx AFA3, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair long lavaquake hall

; Norfair load station 8
; Room $A7B3, door 0. First hot room
$83:92A6             dx A7DE, 00, 05, 0E,36, 00,03, 8000, 0000 ; Norfair mainstreet

; Room $A7B3, door 1. First hot room
$83:92B2             dx A788, 00, 04, 01,06, 00,00, 8000, 0000 ; Lava missile room

; Room $A7DE, door 0. Norfair mainstreet
$83:92BE             dx A815, 00, 05, 6E,26, 06,02, 8000, 0000 ; Ice beam mockball hall

; Room $A7DE, door 1. Norfair mainstreet
$83:92CA             dx A7B3, 00, 04, 01,06, 00,00, 8000, 0000 ; First hot room

; Room $A7DE, door 2. Norfair mainstreet
$83:92D6             dx AA41, 00, 05, 1E,06, 01,00, 8000, 0000 ; Pre hi-jump room

; Room $A7DE, door 3. Norfair mainstreet
$83:92E2             dx AA0E, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair grapple ceiling room

; Room $A7DE, door 4. Norfair mainstreet
$83:92EE             dx A6A1, D0, 03, 00,00, 00,00, 0000, 0000 ; Kraid's lair entrance

; Room $A7DE, door 6. Norfair mainstreet
$83:92FA             dx B167, 00, 04, 01,06, 00,00, 8000, 0000 ; Rock Norfair save station

; Room $A7DE, door 7. Norfair mainstreet
$83:9306             dx B0B4, 00, 05, 0E,06, 00,00, 8000, 0000 ; Norfair map station

; Room $A815, door 0. Ice beam mockball hall
$83:9312             dx A865, 00, 05, 1E,06, 01,00, 8000, 0000 ; Ice beam practice room

; Room $A815, door 1. Ice beam mockball hall
$83:931E             dx A75D, 00, 05, 1E,06, 01,00, 8000, 0000 ; Ice beam tripper hall

; Norfair load station 10h
; Room $A815, door 2. Ice beam mockball hall
$83:932A             dx A7DE, 00, 04, 01,36, 00,03, 8000, 0000 ; Norfair mainstreet

; Room $A815, door 3. Ice beam mockball hall
$83:9336             dx A8F8, 00, 05, 0E,06, 00,00, 8000, 0000 ; Crumble block platform shaft

; Room $A865, door 0. Ice beam practice room
$83:9342             dx A8B9, 00, 05, 0E,06, 00,00, 8000, 0000 ; Pre ice beam shaft

; Room $A865, door 1. Ice beam practice room
$83:934E             dx A815, 00, 04, 31,06, 03,00, 8000, BFFA ; Ice beam mockball hall

; Room $A890, door 0. Ice beam room
$83:935A             dx A8B9, 00, 05, 1E,16, 01,01, 8000, C03A ; Pre ice beam shaft

; Room $A8B9, door 0. Pre ice beam shaft
$83:9366             dx A75D, 00, 04, 01,06, 00,00, 8000, 0000 ; Ice beam tripper hall

; Room $A8B9, door 1. Pre ice beam shaft
$83:9372             dx A865, 00, 04, 01,06, 00,00, 8000, 0000 ; Ice beam practice room

; Room $A8B9, door 2. Pre ice beam shaft
$83:937E             dx A890, 00, 04, 01,06, 00,00, 8000, 0000 ; Ice beam room

; Room $A8F8, door 0. Crumble block platform shaft
$83:938A             dx A815, 00, 04, 01,36, 00,03, 8000, C0EF ; Ice beam mockball hall

; Room $A8F8, door 1. Crumble block platform shaft
$83:9396             dx A923, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair slope

; Room $A923, door 0. Norfair slope
$83:93A2             dx A8F8, 00, 05, 0E,36, 00,03, 8000, 0000 ; Crumble block platform shaft

; Room $A923, door 1. Norfair slope
$83:93AE             dx AA0E, 00, 05, 3E,16, 03,01, 8000, 0000 ; Norfair grapple ceiling room

; Norfair load station 3
; Room $A923, door 2. Norfair slope
$83:93BA             dx B192, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Crocomire save station

; Room $A923, door 3. Norfair slope
$83:93C6             dx AFCE, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair metal floor hall

; Room $A923, door 4. Norfair slope
$83:93D2             dx A98D, 00, 06, 36,02, 03,00, 8000, 0000 ; Crocomire

; Room $A98D, door 0. Crocomire
$83:93DE             dx AA82, 00, 05, 1E,06, 01,00, 8000, 0000 ; Post Crocomire room

; Norfair load station 11h
; Room $A98D, door 1. Crocomire
$83:93EA             dx A923, 00, 07, C6,2D, 0C,02, 01C0, 0000 ; Norfair slope

; Room $A9E5, door 0. Hi-jump room
$83:93F6             dx AA41, 00, 04, 01,16, 00,01, 8000, C016 ; Pre hi-jump room

; Room $AA0E, door 0. Norfair grapple ceiling room
$83:9402             dx A7DE, 00, 05, 0E,66, 00,06, 8000, 0000 ; Norfair mainstreet

; Room $AA0E, door 1. Norfair grapple ceiling room
$83:940E             dx A923, 00, 04, C1,06, 0C,00, 8000, 0000 ; Norfair slope

; Room $AA41, door 0. Pre hi-jump room
$83:941A             dx A7DE, 00, 04, 01,56, 00,05, 8000, 0000 ; Norfair mainstreet

; Room $AA41, door 1. Pre hi-jump room
$83:9426             dx A9E5, 00, 05, 0E,06, 00,00, 8000, 0000 ; Hi-jump room

; Room $AA82, door 0. Post Crocomire room
$83:9432             dx A98D, 00, 04, 01,06, 00,00, 8000, BFDA ; Crocomire

; Room $AA82, door 1. Post Crocomire room
$83:943E             dx AADE, 00, 05, 0E,06, 00,00, 8000, 0000 ; Post Crocomire power bombs room

; Room $AA82, door 2. Post Crocomire room
$83:944A             dx AB07, 00, 06, 06,02, 00,00, 8000, 0000 ; Post Crocomire shaft

; Norfair load station 0
; Room $AA82, door 3. Post Crocomire room
$83:9456             dx AAB5, 00, 04, 01,06, 00,00, 8000, 0000 ; Post Crocomire save station

; Room $AAB5, door 0. Post Crocomire save station
$83:9462             dx AA82, 00, 05, 1E,16, 01,01, 8000, 0000 ; Post Crocomire room

; Norfair load station 13h
; Room $AADE, door 0. Post Crocomire power bombs room
$83:946E             dx AA82, 00, 04, 01,06, 00,00, 8000, 0000 ; Post Crocomire room

; Room $AB07, door 0. Post Crocomire shaft
$83:947A             dx AA82, 00, 07, 06,1D, 00,01, 01C0, 0000 ; Post Crocomire room

; Room $AB07, door 1. Post Crocomire shaft
$83:9486             dx AB64, 00, 05, 2E,06, 02,00, 8000, 0000 ; Double lake grapple practice room

; Room $AB07, door 2. Post Crocomire shaft
$83:9492             dx AB3B, 00, 04, 01,06, 00,00, 8000, 0000 ; Post Crocomire tidal acid cave

; Room $AB07, door 3. Post Crocomire shaft
$83:949E             dx AB8F, 00, 06, 66,22, 06,02, 0140, 0000 ; Huge jump room

; Room $AB3B, door 0. Post Crocomire tidal acid cave
$83:94AA             dx AB07, 00, 05, 0E,36, 00,03, 8000, 0000 ; Post Crocomire shaft

; Room $AB64, door 0. Double lake grapple practice room
$83:94B6             dx ABD2, 00, 05, 0E,06, 00,00, 8000, 0000 ; Grapple practice shaft

; Room $AB64, door 1. Double lake grapple practice room
$83:94C2             dx AB07, 00, 04, 01,06, 00,00, 8000, 0000 ; Post Crocomire shaft

; Room $AB8F, door 0. Huge jump room
$83:94CE             dx AB07, 00, 07, 06,4D, 00,04, 01C0, 0000 ; Post Crocomire shaft

; Room $AB8F, door 1. Huge jump room
$83:94DA             dx AC2B, 00, 05, 0E,26, 00,02, 8000, 0000 ; Grapple room

; Room $ABD2, door 0. Grapple practice shaft
$83:94E6             dx AC00, 00, 05, 1E,06, 01,00, 8000, 0000 ; Single lake grapple practice room

; Room $ABD2, door 1. Grapple practice shaft
$83:94F2             dx AB64, 00, 04, 01,06, 00,00, 8000, 0000 ; Double lake grapple practice room

; Room $AC00, door 0. Single lake grapple practice room
$83:94FE             dx AC2B, 00, 05, 0E,06, 00,00, 8000, 0000 ; Grapple room

; Room $AC00, door 1. Single lake grapple practice room
$83:950A             dx ABD2, 00, 04, 01,26, 00,02, 8000, 0000 ; Grapple practice shaft

; Room $AC2B, door 0. Grapple room
$83:9516             dx AB8F, 00, 04, 01,16, 00,01, 8000, 0000 ; Huge jump room

; Room $AC2B, door 1. Grapple room
$83:9522             dx AC00, 00, 04, 01,06, 00,00, 8000, 0000 ; Single lake grapple practice room

; Room $AC5A, door 0. Bubble Norfair reserve tank room
$83:952E             dx AC83, 00, 04, 01,06, 00,00, 8000, C0D3 ; Pre Bubble Norfair reserve tank room

; Room $AC83, door 0. Pre Bubble Norfair reserve tank room
$83:953A             dx ACB3, 00, 04, 01,06, 00,00, 8000, 0000 ; Bubble Norfair mainstreet

; Room $AC83, door 1. Pre Bubble Norfair reserve tank room
$83:9546             dx AC5A, 00, 05, 1E,06, 01,00, 8000, 0000 ; Bubble Norfair reserve tank room

; Room $ACB3, door 0. Bubble Norfair mainstreet
$83:9552             dx AC83, 00, 05, 1E,06, 01,00, 8000, 0000 ; Pre Bubble Norfair reserve tank room

; Room $ACB3, door 1. Bubble Norfair mainstreet
$83:955E             dx AFA3, 00, 05, 4E,06, 04,00, 8000, 0000 ; Norfair long lavaquake hall

; Room $ACB3, door 2. Bubble Norfair mainstreet
$83:956A             dx AF72, 00, 05, 1E,06, 01,00, 8000, 0000 ; Norfair wave gate room

; Room $ACB3, door 3. Bubble Norfair mainstreet
$83:9576             dx AEDF, 00, 06, 06,02, 00,00, 8000, C0DE ; Purple shaft

; Room $ACB3, door 4. Bubble Norfair mainstreet
$83:9582             dx AD5E, 00, 04, 01,06, 00,00, 8000, 0000 ; Alcoon shaft

; Room $ACB3, door 5. Bubble Norfair mainstreet
$83:958E             dx B07A, 00, 04, 01,16, 00,01, 8000, 0000 ; Speed booster lavaquake room

; Norfair load station 1
; Room $ACB3, door 6. Bubble Norfair mainstreet
$83:959A             dx B0DD, 00, 05, 0E,06, 00,00, 8000, 0000 ; Bubble Norfair save station

; Room $ACF0, door 0. Speed booster lavaquake
$83:95A6             dx B07A, 00, 05, 0E,06, 00,00, 8000, BFE9 ; Speed booster lavaquake room

; Room $ACF0, door 1. Speed booster lavaquake
$83:95B2             dx AD1B, 00, 04, 01,06, 00,00, 8000, 0000 ; Speed booster room

; Room $AD1B, door 0. Speed booster room
$83:95BE             dx ACF0, 00, 05, BE,16, 0B,01, 8000, 0000 ; Speed booster lavaquake

; Room $AD5E, door 0. Alcoon shaft
$83:95CA             dx ACB3, 00, 05, 1E,16, 01,01, 8000, 0000 ; Bubble Norfair mainstreet

; Room $AD5E, door 1. Alcoon shaft
$83:95D6             dx ADAD, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre wave beam room

; Room $AD5E, door 2. Alcoon shaft
$83:95E2             dx ADAD, 00, 04, 01,16, 00,01, 8000, 0000 ; Pre wave beam room

; Room $AD5E, door 3. Alcoon shaft
$83:95EE             dx AE07, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair sinking tripper hall

; Room $AD5E, door 4. Alcoon shaft
$83:95FA             dx B656, 00, 04, 11,06, 01,00, 8000, 0000 ; Lower Norfair north kihunter shaft

; Room $ADAD, door 0. Pre wave beam room
$83:9606             dx AD5E, 00, 05, 0E,16, 00,01, 8000, 0000 ; Alcoon shaft

; Room $ADAD, door 1. Pre wave beam room
$83:9612             dx AD5E, 00, 05, 0E,26, 00,02, 8000, 0000 ; Alcoon shaft

; Room $ADAD, door 2. Pre wave beam room
$83:961E             dx ADDE, 00, 04, 01,06, 00,00, 8000, 0000 ; Wave beam room

; Room $ADDE, door 0. Wave beam room
$83:962A             dx ADAD, 00, 05, 3E,06, 03,00, 8000, 0000 ; Pre wave beam room

; Room $AE07, door 0. Norfair sinking tripper hall
$83:9636             dx AD5E, 00, 05, 0E,36, 00,03, 8000, 0000 ; Alcoon shaft

; Room $AE07, door 1. Norfair sinking tripper hall
$83:9642             dx AE32, 00, 04, 21,06, 02,00, 8000, 0000 ; Volcano room

; Room $AE32, door 0. Volcano room
$83:964E             dx AE07, 00, 05, 3E,06, 03,00, 8000, 0000 ; Norfair sinking tripper hall

; Room $AE32, door 1. Volcano room
$83:965A             dx AE74, 00, 05, 1E,06, 01,00, 8000, 0000 ; Pre lava dive shaft

; Room $AE74, door 0. Pre lava dive shaft
$83:9666             dx AEB4, 00, 05, 2E,06, 02,00, 8000, 0000 ; Magdollite multiviola hall

; Room $AE74, door 1. Pre lava dive shaft
$83:9672             dx AE32, 00, 04, 01,26, 00,02, 8000, C025 ; Volcano room

; Room $AE74, door 2. Pre lava dive shaft
$83:967E             dx AF14, 00, 05, 3E,06, 03,00, 8000, 0000 ; Lava dive room

; Room $AE74, door 3. Pre lava dive shaft
$83:968A             dx AFFB, 00, 05, 3E,06, 03,00, 8000, 0000 ; Norfair lava-spike hall

; Room $AEB4, door 0. Magdollite multiviola hall
$83:9696             dx AEDF, 00, 05, 0E,26, 00,02, 8000, 0000 ; Purple shaft

; Room $AEB4, door 1. Magdollite multiviola hall
$83:96A2             dx AE74, 00, 04, 11,06, 01,00, 8000, 0000 ; Pre lava dive shaft

; Room $AEDF, door 0. Purple shaft
$83:96AE             dx ACB3, 00, 07, 06,3D, 00,03, 01C0, 0000 ; Bubble Norfair mainstreet

; Room $AEDF, door 1. Purple shaft
$83:96BA             dx AEB4, 00, 04, 01,06, 00,00, 8000, 0000 ; Magdollite multiviola hall

; Room $AEDF, door 2. Purple shaft
$83:96C6             dx B051, 00, 04, 01,06, 00,00, 8000, 0000 ; Purple farming room

; Room $AF14, door 0. Lava dive room
$83:96D2             dx AE74, 00, 04, 11,26, 01,02, 8000, 0000 ; Pre lava dive shaft

; Norfair load station 9
; Room $AF14, door 1. Lava dive room
$83:96DE             dx AF3F, 00, 05, 0E,06, 00,00, 8000, 0000 ; Norfair -> Lower Norfair elevator

; Room $AF3F, door 0. Norfair -> Lower Norfair elevator
$83:96EA             dx AF14, 00, 04, 01,06, 00,00, 8000, 0000 ; Lava dive room

; Room $AF3F, door 1. Norfair -> Lower Norfair elevator
$83:96F6             dx B236, A0, 02, 00,00, 04,00, 0000, 0000 ; Lower Norfair mainstreet

; Norfair load station 4
; Room $AF3F, door 3. Norfair -> Lower Norfair elevator
$83:9702             dx B1BB, 00, 05, 0E,06, 00,00, 8000, 0000 ; Pre Lower Norfair save station

; Room $AF72, door 0. Norfair wave gate room
$83:970E             dx B106, 00, 05, 7E,06, 07,00, 8000, 0000 ; Norfair speed blockade hall

; Room $AF72, door 1. Norfair wave gate room
$83:971A             dx ACB3, 00, 04, 01,36, 00,03, 8000, 0000 ; Bubble Norfair mainstreet

; Room $AF72, door 2. Norfair wave gate room
$83:9726             dx B139, 00, 05, 0E,06, 00,00, 8000, 0000 ; Norfair stone zoomer shaft

; Room $AFA3, door 0. Norfair long lavaquake hall
$83:9732             dx A788, 00, 05, 2E,16, 02,01, 8000, 0000 ; Lava missile room

; Room $AFA3, door 1. Norfair long lavaquake hall
$83:973E             dx ACB3, 00, 04, 01,26, 00,02, 8000, 0000 ; Bubble Norfair mainstreet

; Room $AFCE, door 0. Norfair metal floor hall
$83:974A             dx A923, 00, 05, CE,26, 0C,02, 8000, 0000 ; Norfair slope

; Room $AFCE, door 1. Norfair metal floor hall
$83:9756             dx B026, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair energy station

; Room $AFCE, door 2. Norfair metal floor hall
$83:9762             dx B139, 00, 07, 06,2D, 00,02, 0200, 0000 ; Norfair stone zoomer shaft

; Room $AFFB, door 0. Norfair lava-spike hall
$83:976E             dx B026, 00, 05, 0E,06, 00,00, 8000, 0000 ; Norfair energy station

; Room $AFFB, door 1. Norfair lava-spike hall
$83:977A             dx AE74, 00, 04, 01,16, 00,01, 8000, C0FA ; Pre lava dive shaft

; Room $B026, door 0. Norfair energy station
$83:9786             dx AFCE, 00, 05, 3E,06, 03,00, 8000, 0000 ; Norfair metal floor hall

; Room $B026, door 1. Norfair energy station
$83:9792             dx AFFB, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair lava-spike hall

; Room $B051, door 0. Purple farming room
$83:979E             dx AEDF, 00, 05, 0E,16, 00,01, 8000, 0000 ; Purple shaft

; Room $B07A, door 0. Speed booster lavaquake room
$83:97AA             dx ACB3, 00, 05, 1E,06, 01,00, 8000, 0000 ; Bubble Norfair mainstreet

; Room $B07A, door 1. Speed booster lavaquake room
$83:97B6             dx ACF0, 00, 04, 01,06, 00,00, 8000, 0000 ; Speed booster lavaquake

; Room $B0B4, door 0. Norfair map station
$83:97C2             dx A7DE, 00, 04, 01,46, 00,04, 8000, 0000 ; Norfair mainstreet

; Room $B0DD, door 0. Bubble Norfair save station
$83:97CE             dx ACB3, 00, 04, 01,16, 00,01, 8000, 0000 ; Bubble Norfair mainstreet

; Norfair load station 2
; Room $B106, door 0. Norfair speed blockade hall
$83:97DA             dx B167, 00, 05, 0E,06, 00,00, 8000, 0000 ; Rock Norfair save station

; Room $B106, door 1. Norfair speed blockade hall
$83:97E6             dx AF72, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair wave gate room

; Room $B139, door 0. Norfair stone zoomer shaft
$83:97F2             dx AF72, 00, 04, 01,16, 00,01, 8000, 0000 ; Norfair wave gate room

; Room $B139, door 1. Norfair stone zoomer shaft
$83:97FE             dx AFCE, 00, 06, 36,02, 03,00, 0140, 0000 ; Norfair metal floor hall

; Room $B167, door 0. Rock Norfair save station
$83:980A             dx B106, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair speed blockade hall

; Room $B167, door 1. Rock Norfair save station
$83:9816             dx A7DE, 00, 05, 0E,56, 00,05, 8000, 0000 ; Norfair mainstreet

; Room $B192, door 0. Pre Crocomire save station
$83:9822             dx A923, 00, 05, AE,16, 0C,01, 8000, 0000 ; Norfair slope

; Room $B1BB, door 0. Pre Lower Norfair save station
$83:982E             dx AF3F, 00, 04, 01,06, 00,00, 8000, 0000 ; Norfair -> Lower Norfair elevator

; Norfair load station 16h
; Room $B1E5, door 0. Lower Norfair chozo room
$83:983A             dx B283, 00, 04, 01,06, 00,00, 8000, C089 ; Golden Torizo

; Norfair load station Ah / 14h
; Room $B1E5, door 1. Lower Norfair chozo room
$83:9846             dx B236, 00, 04, 01,26, 00,02, 8000, 0000 ; Lower Norfair mainstreet

; Room $B236, door 0. Lower Norfair mainstreet
$83:9852             dx B1E5, 00, 05, 1E,06, 01,00, 8000, 0000 ; Lower Norfair chozo room

; Room $B236, door 1. Lower Norfair mainstreet
$83:985E             dx B3A5, 00, 04, 01,16, 00,01, 8000, 0000 ; Pre pillars hall

; Room $B236, door 2. Lower Norfair mainstreet
$83:986A             dx AF3F, B0, 03, 00,00, 00,00, 0000, 0000 ; Norfair -> Lower Norfair elevator

; Room $B283, door 0. Golden Torizo
$83:9876             dx B1E5, 00, 05, 2E,26, 02,02, 8000, BF9E ; Lower Norfair chozo room

; Room $B283, door 1. Golden Torizo
$83:9882             dx B6C1, 00, 04, 01,26, 00,02, 8000, 0000 ; Screw attack room

; Room $B2DA, door 0. Ripper ii room
$83:988E             dx B6C1, 00, 05, 0E,06, 00,00, 8000, 0000 ; Screw attack room

; Room $B2DA, door 1. Ripper ii room
$83:989A             dx B3A5, 00, 04, 01,26, 00,02, 8000, C056 ; Pre pillars hall

; Norfair load station 15h
; Room $B305, door 0. Lower Norfair energy station
$83:98A6             dx B6C1, 00, 05, 0E,16, 00,01, 8000, 0000 ; Screw attack room

; Room $B32E, door 0. Ridley
$83:98B2             dx B698, 00, 05, 0E,06, 00,00, 8000, 0000 ; Ridley's energy tank

; Room $B32E, door 1. Ridley
$83:98BE             dx B37A, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Ridley hall

; Room $B37A, door 0. Pre Ridley hall
$83:98CA             dx B32E, 00, 05, 0E,06, 00,00, 8000, 0000 ; Ridley

; Room $B37A, door 1. Pre Ridley hall
$83:98D6             dx B482, 00, 04, 01,06, 00,00, 8000, 0000 ; Lower Norfair holtz room

; Room $B3A5, door 0. Pre pillars hall
$83:98E2             dx B236, 00, 05, 7E,26, 07,02, 8000, 0000 ; Lower Norfair mainstreet

; Room $B3A5, door 1. Pre pillars hall
$83:98EE             dx B40A, 00, 04, 01,36, 00,03, 8000, 0000 ; Lower Norfair multi-level one-way shaft

; Room $B3A5, door 2. Pre pillars hall
$83:98FA             dx B236, 00, 05, 7E,26, 07,02, 8000, 0000 ; Lower Norfair mainstreet

; Room $B3A5, door 3. Pre pillars hall
$83:9906             dx B2DA, 00, 05, 3E,06, 03,00, 8000, 0000 ; Ripper ii room

; Room $B3A5, door 4. Pre pillars hall
$83:9912             dx B457, 00, 04, 01,06, 00,00, 8000, 0000 ; Pillars hall

; Room $B3E1, door 0. Unused room
$83:991E             dx B3A5, 00, 05, 0E,06, 00,00, 8000, 0000 ; Pre pillars hall

; Room $B40A, door 0. Lower Norfair multi-level one-way shaft
$83:992A             dx B3A5, 00, 05, 0E,06, 00,00, 8000, 0000 ; Pre pillars hall

; Room $B40A, door 1. Lower Norfair multi-level one-way shaft
$83:9936             dx B4AD, 00, 04, 01,06, 00,00, 8000, C0A2 ; Lower Norfair wall space pirates shaft

; Room $B457, door 0. Pillars hall
$83:9942             dx B3A5, 00, 05, 0E,26, 00,02, 8000, C056 ; Pre pillars hall

; Room $B457, door 1. Pillars hall
$83:994E             dx B4AD, 00, 04, 01,56, 00,05, 8000, 0000 ; Lower Norfair wall space pirates shaft

; Norfair load station 12h
; Room $B482, door 0. Lower Norfair holtz room
$83:995A             dx B37A, 00, 05, 2E,06, 02,00, 8000, 0000 ; Pre Ridley hall

; Room $B482, door 1. Lower Norfair holtz room
$83:9966             dx B62B, 00, 04, 01,06, 00,00, 8000, 0000 ; Ninja space pirate hall

; Room $B4AD, door 0. Lower Norfair wall space pirates shaft
$83:9972             dx B40A, 00, 05, 3E,06, 03,00, 8000, C10B ; Lower Norfair multi-level one-way shaft

; Room $B4AD, door 1. Lower Norfair wall space pirates shaft
$83:997E             dx B4E5, 00, 04, 01,16, 00,01, 8000, 0000 ; Lower Norfair rising acid room

; Room $B4AD, door 2. Lower Norfair wall space pirates shaft
$83:998A             dx B457, 00, 05, 3E,06, 03,00, 8000, 0000 ; Pillars hall

; Room $B4E5, door 0. Lower Norfair rising acid room
$83:9996             dx B4AD, 00, 05, 0E,16, 00,01, 8000, 0000 ; Lower Norfair wall space pirates shaft

; Room $B4E5, door 1. Lower Norfair rising acid room
$83:99A2             dx B585, 00, 04, 01,06, 00,00, 8000, C067 ; Lower Norfair south kihunter shaft

; Room $B510, door 0. Lower Norfair spring ball maze room
$83:99AE             dx B656, 00, 05, 3E,26, 03,02, 8000, 0000 ; Lower Norfair north kihunter shaft

; Room $B510, door 1. Lower Norfair spring ball maze room
$83:99BA             dx B6EE, 00, 04, 01,06, 00,00, 8000, C0AD ; Norfair rolling boulder shaft

; Room $B510, door 2. Lower Norfair spring ball maze room
$83:99C6             dx B55A, 00, 06, 06,02, 00,00, 8000, 0000 ; Lower Norfair escape power bomb room

; Room $B55A, door 0. Lower Norfair escape power bomb room
$83:99D2             dx B6EE, 00, 05, 1E,06, 01,00, 8000, C078 ; Norfair rolling boulder shaft

; Room $B55A, door 1. Lower Norfair escape power bomb room
$83:99DE             dx B510, 00, 07, 46,0D, 04,00, 01C0, BFBB ; Lower Norfair spring ball maze room

; Room $B585, door 0. Lower Norfair south kihunter shaft
$83:99EA             dx B5D5, 00, 06, 56,02, 05,00, 8000, 0000 ; Lower Norfair spike platform room

; Room $B585, door 1. Lower Norfair south kihunter shaft
$83:99F6             dx B4E5, 00, 05, 3E,06, 03,00, 8000, 0000 ; Lower Norfair rising acid room

; Room $B585, door 2. Lower Norfair south kihunter shaft
$83:9A02             dx B6EE, 00, 04, 11,36, 01,03, 8000, 0000 ; Norfair rolling boulder shaft

; Norfair load station 5
; Room $B585, door 3. Lower Norfair south kihunter shaft
$83:9A0E             dx B741, 00, 04, 01,06, 00,00, 8000, 0000 ; Lower Norfair save station

; Room $B5D5, door 0. Lower Norfair spike platform room
$83:9A1A             dx B62B, 00, 05, 2E,06, 02,00, 8000, 0000 ; Ninja space pirate hall

; Room $B5D5, door 1. Lower Norfair spike platform room
$83:9A26             dx B585, 00, 07, 26,4D, 02,04, 0200, 0000 ; Lower Norfair south kihunter shaft

; Room $B62B, door 0. Ninja space pirate hall
$83:9A32             dx B482, 00, 05, 2E,06, 02,00, 8000, 0000 ; Lower Norfair holtz room

; Room $B62B, door 1. Ninja space pirate hall
$83:9A3E             dx B5D5, 00, 04, 11,26, 01,02, 8000, C04B ; Lower Norfair spike platform room

; Room $B656, door 0. Lower Norfair north kihunter shaft
$83:9A4A             dx AD5E, 00, 05, 5E,06, 05,00, 8000, 0000 ; Alcoon shaft

; Room $B656, door 1. Lower Norfair north kihunter shaft
$83:9A56             dx B510, 00, 04, 01,06, 00,00, 8000, 0000 ; Lower Norfair spring ball maze room

; Room $B698, door 0. Ridley's energy tank
$83:9A62             dx B32E, 00, 04, 01,16, 00,01, 8000, 0000 ; Ridley

; Room $B6C1, door 0. Screw attack room
$83:9A6E             dx B2DA, 00, 04, 01,06, 00,00, 8000, 0000 ; Ripper ii room

; Room $B6C1, door 1. Screw attack room
$83:9A7A             dx B305, 00, 04, 01,06, 00,00, 8000, 0000 ; Lower Norfair energy station

; Room $B6C1, door 2. Screw attack room
$83:9A86             dx B283, 00, 05, 1E,16, 01,01, 8000, 0000 ; Golden Torizo

; Room $B6EE, door 0. Norfair rolling boulder shaft
$83:9A92             dx B510, 00, 05, 1E,16, 01,01, 8000, 0000 ; Lower Norfair spring ball maze room

; Room $B6EE, door 1. Norfair rolling boulder shaft
$83:9A9E             dx B55A, 00, 04, 01,06, 00,00, 8000, 0000 ; Lower Norfair escape power bomb room

; Room $B6EE, door 2. Norfair rolling boulder shaft
$83:9AAA             dx B585, 00, 05, 0E,06, 00,00, 8000, C0C2 ; Lower Norfair south kihunter shaft

; Room $B741, door 0. Lower Norfair save station
$83:9AB6             dx B585, 00, 05, 0E,36, 00,03, 8000, 0000 ; Lower Norfair south kihunter shaft
}


;;; $9AC2: FX ;;;
{
;                        __________________________________________________ 0: Door pointer
;                       |      ____________________________________________ 2: Base Y position
;                       |     |     _______________________________________ 4: Target Y position
;                       |     |    |      _________________________________ 6: Y velocity
;                       |     |    |     |      ___________________________ 8: Timer
;                       |     |    |     |     |    _______________________ 9: Type (foreground layer 3)
;                       |     |    |     |     |   |    ___________________ Ah: Default layer blending configuration (FX A)
;                       |     |    |     |     |   |   |   ________________ Bh: FX layer 3 layer blending configuration (FX B)
;                       |     |    |     |     |   |   |  |    ____________ Ch: Liquid options (FX C)
;                       |     |    |     |     |   |   |  |   |    ________ Dh: Palette FX bitset
;                       |     |    |     |     |   |   |  |   |   |   _____ Eh: Animated tiles bitset
;                       |     |    |     |     |   |   |  |   |   |  |    _ Fh: Palette blend
;                       |     |    |     |     |   |   |  |   |   |  |   |
;                       dddd, bbbb,tttt, vvvv, tt, ff, AA,BB, CC, pp,aa, bb

; Room $C98E, state $C9BA. Wrecked Ship chozo room - main area boss is dead
$83:9AC2             dx 0000, 01B0,FFFF, 0000, 00, 00, 02,02, 00, 01,0B, 00

; Room $CA08, state $CA34. Wrecked Ship entrance treadmill - main area boss is dead
$83:9AD2             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,00, 00

; Room $CA52, state $CA7E. Wrecked Ship attic - main area boss is dead
$83:9AE2             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,10, 00

; Room $CAAE, state $CADA. Wrecked Ship attic missile tank room - main area boss is dead
$83:9AF2             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,18, 00

; Room $CAF6, state $CB22. Wrecked Ship mainstreet - main area boss is dead
$83:9B02             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,06, 00

; Room $CB8B, state $CBB7. Wrecked Ship spike platform hall - main area boss is dead
$83:9B12             dx 0000, 00A8,FFFF, 0000, 00, 06, 02,18, 03, 01,0A, 48

; Room $CBD5, state $CC01. Wrecked Ship east exit - main area boss is dead
$83:9B22             dx 0000, 02A8,FFFF, 0000, 00, 06, 02,18, 03, 01,02, 48

; Room $CC27, state $CC53. Wrecked Ship chozo energy tank room - main area boss is dead
$83:9B32             dx 0000, 00B0,FFFF, 0000, 00, 06, 02,18, 83, 01,06, 48

; Room $CC6F, state $CC9B. Pre Phantoon hall - main area boss is dead
$83:9B42             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,00, 00

; Room $CCCB, state $CCF7. Wrecked Ship map station - main area boss is dead
$83:9B52             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CD13, state $CD3F. Phantoon - main area boss is dead
$83:9B62             dx FFFF

; Room $CD5C, state $CD88. Wrecked Ship first flooded room - main area boss is dead
$83:9B64             dx 0000, 00A8,FFFF, 0000, 00, 06, 02,18, 03, 00,00, 48

; Room $CDA8, state $CDD4. Wrecked Ship west super missile room - main area boss is dead
$83:9B74             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,00, 00

; Room $CDF1, state $CE1D. Wrecked Ship easy super missile hall - main area boss is dead
$83:9B84             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,09, 00

; Room $CE40, state $CE6C. Gravity suit room - main area boss is dead
; Room $CE8A, state $CEB6. Wrecked Ship save station - main area boss is dead
$83:9B94             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 01,00, 00

; Room $C98E, state $C9A0. Wrecked Ship chozo room - default
$83:9BA4             dx 0000, FFFF,FFFF, 0000, 00, 00, 28,02, 00, 00,00, 00

; Room $CA08, state $CA1A. Wrecked Ship entrance treadmill - default
$83:9BB4             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CA52, state $CA64. Wrecked Ship attic - default
$83:9BC4             dx 0000, FFFF,FFFF, 0000, 00, 00, 08,02, 00, 00,00, 00

; Room $CAAE, state $CAC0. Wrecked Ship attic missile tank room - default
$83:9BD4             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CAF6, state $CB08. Wrecked Ship mainstreet - default
$83:9BE4             dx 0000, FFFF,FFFF, 0000, 00, 00, 08,02, 00, 00,00, 00

; Room $CB8B, state $CB9D. Wrecked Ship spike platform hall - default
$83:9BF4             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CBD5, state $CBE7. Wrecked Ship east exit - default
$83:9C04             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CC27, state $CC39. Wrecked Ship chozo energy tank room - default
$83:9C14             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CC6F, state $CC81. Pre Phantoon hall - default
$83:9C24             dx 0000, FFFF,FFFF, 0000, 00, 00, 28,02, 00, 00,00, 00

; Room $CCCB, state $CCDD. Wrecked Ship map station - default
$83:9C34             dx 0000, FFFF,FFFF, 0000, 00, 00, 08,02, 00, 00,00, 00

; Room $CD13, state $CD25. Phantoon - default
$83:9C44             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CD5C, state $CD6E. Wrecked Ship first flooded room - default
$83:9C54             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CDA8, state $CDBA. Wrecked Ship west super missile room - default
$83:9C64             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CDF1, state $CE03. Wrecked Ship easy super missile hall - default
; Room $CE40, state $CE52. Gravity suit room - default
; Room $CE8A, state $CE9C. Wrecked Ship save station - default
$83:9C74             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $CED2. n00b tube save station
$83:9C84             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 82, 00,00, E2

; Room $CEFB. n00b tube
$83:9C94             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 84, 00,00, E2

; Room $CF54. n00b tube west
$83:9CA4             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 00,00, 00

; Room $CF80. n00b tube east
$83:9CB4             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 00,00, 00

; Room $CFC9. Maridia mainstreet
$83:9CC4             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 83, 00,00, E2

; Room $D017. Maridia space pirate room
$83:9CD4             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 83, 00,00, E2

; Room $D055. Tatori room
$83:9CE4             dx 0000, 02BA,FFFF, 0000, 00, 06, 02,14, 80, 00,00, E2

; Room $D08A. Maridia green gate hall
$83:9CF4             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 80, 00,00, E2

; Room $D0B9. Mt. Doom
$83:9D04             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 83, 00,00, E2

; Room $D104. Maridia -> Red Brinstar room
$83:9D14             dx 0000, 0180,FFFF, 0000, 00, 06, 02,14, 81, 00,00, E2

; Room $D13B. Sandy Maridia missile and super missile room
$83:9D24             dx 0000, 01B5,FFFF, 0000, 00, 06, 02,14, 83, 00,00, 42

; Room $D16D. Sandy Maridia memu room
$83:9D34             dx 0000, 01B5,FFFF, 0000, 00, 06, 02,14, 83, 00,00, 42

; Room $D1A3. Maridia crab shaft
$83:9D44             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 81, 00,00, E2

; Room $D1DD. Beach
$83:9D54             dx 0000, 01B5,FFFF, 0000, 00, 06, 02,14, 83, 00,00, 42

; Room $D21C. Maridia broken glass tube room
$83:9D64             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 80, 00,00, E2

; Room $D252. Maridia broken glass tube room east
$83:9D74             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 80, 00,00, E2

; Room $D27E. Plasma beam puyo room
$83:9D84             dx 0000, FFFF,FFFF, 0000, 00, 00, 28,02, 00, 00,00, 42

; Room $D2AA. Plasma beam room
$83:9D94             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 00,00, 42

; Room $D2D9. Sandy Maridia choot-puyo hall
$83:9DA4             dx 0000, 00B5,FFFF, 0000, 00, 06, 02,14, 83, 00,00, 42

; Room $D30B. Maridia -> Crateria elevator
$83:9DB4             dx 0000, 05B5,FFFF, 0000, 00, 06, 02,14, 83, 00,02, 42

; Room $D340. Sandy Maridia mainstreet
$83:9DC4             dx 0000, 03B4,FFFF, 0000, 00, 06, 02,14, 83, 00,00, 42

; Room $D387. Pre plasma beam shaft
$83:9DD4             dx 0000, FFFF,FFFF, 0000, 00, 00, 28,02, 00, 00,00, 42

; Room $D3B6. Maridia map station
$83:9DE4             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 82, 00,00, E2

; Room $D3DF. Sandy Maridia save station
$83:9DF4             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 42

; Room $D408. Maridia elevatube
$83:9E04             dx A5AC, 0080,FFFF, 0000, 00, 06, 02,14, 85, 00,00, E8, ; Sandy Maridia mainstreet - door 1
                        A678, 0080,FFFF, 0000, 00, 06, 02,14, 85, 00,00, E8, ; Elevatube south - door 2
                        0000, 0080,FFFF, 0000, 00, 06, 02,14, 81, 00,00, E8

; Room $D433. Sandy Maridia quicksand top
$83:9E34             dx 0000, 00B5,FFFF, 0000, 00, 06, 02,14, 83, 01,00, 42

; Room $D461. Evir hall west
$83:9E44             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 82, 01,0C, E8

; Room $D48E. Elevatube south
$83:9E54             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 82, 01,00, E8

; Room $D4C2. Evir hall east
$83:9E64             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 82, 01,0C, E8

; Room $D4EF. Snail room quicksand items west
$83:9E74             dx 0000, 00D6,FFFF, 0000, 00, 06, 02,14, 03, 01,0C, EE

; Room $D51E. Snail room quicksand items east
$83:9E84             dx 0000, 00D6,FFFF, 0000, 00, 06, 02,14, 03, 01,0C, EE

; Room $D54D. Snail room quicksand fall west
; Room $D57A. Snail room quicksand fall east
$83:9E94             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 02,00, 00

; Room $D5A7. Snail room
$83:9EA4             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 83, 01,00, EE

; Room $D5EC. Sandy Maridia quicksand bottom
$83:9EB4             dx 0000, 0049,FFFF, 0000, 00, 06, 02,14, 83, 01,0C, 42

; Room $D617. Mochtroid room
$83:9EC4             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 83, 00,00, EE

; Room $D646. Pants room
$83:9ED4             dx 0000, 02B0,FFFF, 0000, 00, 06, 02,14, 82, 01,00, E8

; Room $D69A. Pants room section
$83:9EE4             dx 0000, 00B0,FFFF, 0000, 00, 06, 02,14, 82, 01,00, E8

; Room $D6D0. Spring ball room
$83:9EF4             dx 0000, 00B0,FFFF, 0000, 00, 06, 02,14, 82, 01,00, E8

; Room $D6FD. Maridia speed blockade quicksand bottom
$83:9F04             dx 0000, 0048,FFFF, 0000, 00, 06, 02,14, 03, 01,0C, EE

; Room $D72A. Maridia grapple room
$83:9F14             dx 0000, 0117,FFFF, 0000, 00, 06, 02,16, 01, 05,02, EE

; Room $D765. Snail room save station
$83:9F24             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 82, 02,00, 42

; Room $D78F. Pre Draygon room
$83:9F34             dx 0000, 00BF,FFFF, 0000, 00, 06, 02,14, 83, 00,00, EE

; Room $D7E4. Maridia speed blockade hall
$83:9F44             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 83, 01,00, EE

; Room $D81A. Draygon save station
$83:9F54             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, EE

; Room $D845. Maridia missile station
$83:9F64             dx 0000, 0000,FFFF, 0000, 00, 06, 02,14, 03, 00,00, EE

; Room $D86E. Sandy Maridia quicksand fall
; Room $D898. Maridia speed blockade quicksand fall
$83:9F74             dx 0000, FFFF,FFFF, 0000, 00, 00, 2A,02, 00, 02,00, 00

; Room $D8C5. Shaktool
$83:9F84             dx 0000, 00B0,FFFF, 0000, 00, 06, 02,14, 82, 00,00, E8

; Room $D913. Maridia grapple wall shaft
$83:9F94             dx 0000, 0135,FFFF, 0000, 00, 06, 02,16, 03, 04,02, EE

; Room $D95E. Botwoon
$83:9FA4             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 83, 02,00, EE

; Room $D9AA. Space jump room
$83:9FB4             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 83, 00,00, EE

; Room $D9D4. Maridia energy station
$83:9FC4             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, EE

; Room $D9FE. Maridia cacatac room west
$83:9FD4             dx 0000, 00B9,FFFF, 0000, 00, 06, 02,14, 83, 00,00, EE

; Room $DA2B. Maridia cacatac room east
$83:9FE4             dx 0000, 0135,FFFF, 0000, 00, 06, 02,16, 01, 04,02, EE

; Room $DA60. Draygon
$83:9FF4             dx 0000, 0010,FFFF, 0000, 00, 06, 02,14, 81, 00,00, 42

; Room $DAAE. Tourian -> Crateria elevator
$83:A004             dx 0000, 03BC,FFFF, 0000, 00, 04, 02,1E, 01, 02,00, 02

; Room $DAE1. Metroid room 1
$83:A014             dx 0000, 00D0,FFFF, 0000, 10, 04, 02,1E, 01, 02,00, 02

; Room $DB31. Metroid room 2
$83:A024             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 02,00, 00

; Room $DB7D. Metroid room 3
$83:A034             dx 0000, 00D0,FFFF, 0000, 10, 04, 02,1E, 01, 02,00, 02

; Room $DBCD. Metroid room 4
$83:A044             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 02,00, 00

; Room $DC19. Tourian super-sidehopper room
$83:A054             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 02,00, 00

; Room $DC65. Torizo corpse room
$83:A064             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 02,00, 00

; Room $DCB1. Shitroid room
$83:A074             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 02,00, 00

; Room $DCFF. Post Shitroid room
$83:A084             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 02,00, 00

; Room $DD2E. Tourian refill station
$83:A094             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $DD58, state $DD6E. Mother Brain - default
; Room $DD58, state $DD88. Mother Brain - event "Mother Brain's glass is broken" is set
$83:A0A4             dx 0000, 00E8,FFFF, 0000, 10, 04, 02,1E, 01, 02,00, 02

; FX set by Mother Brain to raise acid
$83:A0B4             dx 0000, 00E8,00B8, FFF0, 10, 04, 02,1E, 01, 02,00, 02

; FX set by Mother Brain to lower acid
$83:A0C4             dx 0000, 00B8,00E8, 0030, 10, 04, 02,1E, 01, 02,00, 02

; Room $DDC4. Tourian eye-door room
$83:A0D4             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 02,00, 00

; Room $DDF3. Pre Mother Brain shaft
$83:A0E4             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 02,00, 00

; Room $DE23. Mother Brain save station
$83:A0F4             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 00,00, 00

; Room $DE4D. Escape room 1
$83:A104             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 78,00, 00

; Room $DE7A. Escape room 2
$83:A114             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 70,00, 00

; Room $DEA7. Escape room 3
$83:A124             dx 0000, FFFF,FFFF, 0000, 00, 00, 02,02, 00, 70,00, 00

; Room $DEDE. Escape room 4
$83:A134             dx 0000, 05E0,0010, 0000, 40, 04, 02,1E, 01, 70,02, 00

; Room $DF1B. Tourian elevator save station
$83:A144             dx FFFF

; Room $DF45. Ceres elevator shaft
$83:A146             dx 0000, FFFF,FFFF, 0000, 00, 2A, 02,02, 00, 00,00, 00

; Room $DF8D, state $DF9F. Ceres pre elevator hall - default
$83:A156             dx FFFF

; Room $DFD7, state $DFE9. Ceres stairs - default
$83:A158             dx FFFF

; Room $E021, state $E033. Ceres baby metroid hall - default
$83:A15A             dx FFFF

; Room $E06B, state $E07D. Pre Ceres Ridley hall - default
$83:A15C             dx FFFF

; Room $E0B5, state $E0C7. Ceres Ridley - default
$83:A15E             dx 0000, FFFF,FFFF, 0000, 00, 28, 02,02, 00, 00,00, 00

; Unused FX. Clone of $A146
$83:A16E             dx 0000, FFFF,FFFF, 0000, 00, 2A, 02,02, 00, 00,00, 00

; Room $DF8D, state $DFB9. Ceres pre elevator hall - main area boss is dead
$83:A17E             dx FFFF

; Room $DFD7, state $E003. Ceres stairs - main area boss is dead
$83:A180             dx FFFF

; Room $E021, state $E04D. Ceres baby metroid hall - main area boss is dead
$83:A182             dx FFFF

; Room $E06B, state $E097. Pre Ceres Ridley hall - main area boss is dead
$83:A184             dx FFFF

; Room $E0B5, state $E0E1. Ceres Ridley - main area boss is dead
$83:A186             dx FFFF

; Room $DD58, state $DDA2. Mother Brain - main area boss is dead
; Room $E82C. Debug room
$83:A188             dx FFFF
}


;;; $A18A: Door headers ;;;
{
;                        _____________________________________ 0: Destination room header pointer (bank $8F)
;                       |      _______________________________ 2: Elevator properties
;                       |     |    ___________________________ 3: Direction
;                       |     |   |    _______________________ 4: Doorcap X position in blocks
;                       |     |   |   |   ____________________ 5: Doorcap Y position in blocks
;                       |     |   |   |  |    ________________ 6: X screen
;                       |     |   |   |  |   |   _____________ 7: Y screen
;                       |     |   |   |  |   |  |    _________ 8: Distance from door to spawn Samus
;                       |     |   |   |  |   |  |   |      ___ Ah: Custom door ASM to execute (bank $8F)
;                       |     |   |   |  |   |  |   |     |
;                       rrrr  ee  oo  xx yy  XX YY  dddd  aaaa

; Room $D30B, door 3. Maridia -> Crateria elevator
; Room $DAAE, door 2. Tourian -> Crateria elevator
$83:A18A             dw 0000

; Room $C98E, door 0. Wrecked Ship chozo room
$83:A18C             dx 93FE, 40, 05, 7E,16, 07,01, 8000, 0000 ; Wrecked Ship entrance

; Room $C98E, door 1. Wrecked Ship chozo room
$83:A198             dx 968F, 40, 05, 0E,06, 00,00, 8000, 0000 ; Orange zoomer hall

; Room $C98E, door 2. Wrecked Ship chozo room
$83:A1A4             dx CE40, 00, 05, 0E,06, 00,00, 8000, 0000 ; Gravity suit room

; Room $CA08, door 0. Wrecked Ship entrance treadmill
$83:A1B0             dx 93FE, 40, 05, 7E,46, 07,04, 8000, 0000 ; Wrecked Ship entrance

; Room $CA08, door 1. Wrecked Ship entrance treadmill
$83:A1BC             dx CAF6, 00, 04, 41,36, 04,03, 8000, 0000 ; Wrecked Ship mainstreet

; Room $CA52, door 0. Wrecked Ship attic
$83:A1C8             dx CAF6, 00, 06, 46,02, 04,00, 8000, 0000 ; Wrecked Ship mainstreet

; Room $CA52, door 1. Wrecked Ship attic
$83:A1D4             dx CAAE, 00, 04, 01,06, 00,00, 8000, 0000 ; Wrecked Ship attic missile tank room

; Room $CA52, door 2. Wrecked Ship attic
$83:A1E0             dx 93FE, 40, 05, 7E,06, 07,00, 8000, 0000 ; Wrecked Ship entrance

; Room $CAAE, door 0. Wrecked Ship attic missile tank room
$83:A1EC             dx CA52, 00, 05, 6E,06, 06,00, 8000, 0000 ; Wrecked Ship attic

; Wrecked Ship load station 10h
; Room $CAF6, door 0. Wrecked Ship mainstreet
$83:A1F8             dx CA08, 00, 05, 3E,06, 03,00, 8000, E1D8 ; Wrecked Ship entrance treadmill

; Room $CAF6, door 1. Wrecked Ship mainstreet
$83:A204             dx CD5C, 00, 04, 01,06, 00,00, 8000, 0000 ; Wrecked Ship first flooded room

; Room $CAF6, door 2. Wrecked Ship mainstreet
$83:A210             dx CDA8, 00, 05, 0E,06, 00,00, 8000, 0000 ; Wrecked Ship west super missile room

; Room $CAF6, door 3. Wrecked Ship mainstreet
$83:A21C             dx CC6F, 00, 06, 26,02, 02,00, 8000, 0000 ; Pre Phantoon hall

; Room $CAF6, door 4. Wrecked Ship mainstreet
$83:A228             dx CA52, 00, 07, 46,0E, 04,00, 01C0, 0000 ; Wrecked Ship attic

; Room $CAF6, door 5. Wrecked Ship mainstreet
$83:A234             dx CDF1, 00, 04, 01,06, 00,00, 8000, 0000 ; Wrecked Ship easy super missile hall

; Wrecked Ship load station 0
; Room $CAF6, door 6. Wrecked Ship mainstreet
$83:A240             dx CE8A, 00, 04, 01,06, 00,00, 8000, 0000 ; Wrecked Ship save station

; Room $CB8B, door 0. Wrecked Ship spike platform hall
$83:A24C             dx CD5C, 00, 05, 1E,06, 01,00, 8000, E1E8 ; Wrecked Ship first flooded room

; Room $CB8B, door 1. Wrecked Ship spike platform hall
$83:A258             dx CBD5, 00, 04, 01,26, 00,02, 8000, 0000 ; Wrecked Ship east exit

; Room $CBD5, door 0. Wrecked Ship east exit
$83:A264             dx 94FD, 40, 04, 01,46, 00,04, 8000, 0000 ; Wrecked Ship back door

; Room $CBD5, door 1. Wrecked Ship east exit
$83:A270             dx CB8B, 00, 05, 1E,06, 01,00, 8000, 0000 ; Wrecked Ship spike platform hall

; Room $CBD5, door 2. Wrecked Ship east exit
$83:A27C             dx CC27, 00, 05, 2E,06, 02,00, 8000, 0000 ; Wrecked Ship chozo energy tank room

; Room $CC27, door 0. Wrecked Ship chozo energy tank room
$83:A288             dx CBD5, 00, 04, 01,06, 00,00, 8000, E1F3 ; Wrecked Ship east exit

; Room $CC6F, door 0. Pre Phantoon hall
$83:A294             dx CAF6, 00, 07, 46,7D, 04,07, 01C0, E21A ; Wrecked Ship mainstreet

; Room $CC6F, door 1. Pre Phantoon hall
$83:A2A0             dx CCCB, 00, 05, 0E,06, 00,00, 8000, 0000 ; Wrecked Ship map station

; Room $CC6F, door 2. Pre Phantoon hall
$83:A2AC             dx CD13, 00, 04, 01,06, 00,00, 8000, 0000 ; Phantoon

; Wrecked Ship load station 11h
; Room $CCCB, door 0. Wrecked Ship map station
$83:A2B8             dx CC6F, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Phantoon hall

; Room $CD13, door 0. Phantoon
$83:A2C4             dx CC6F, 00, 05, 4E,06, 04,00, 8000, E1FE ; Pre Phantoon hall

; Room $CD5C, door 0. Wrecked Ship first flooded room
$83:A2D0             dx CAF6, 00, 05, 4E,46, 04,04, 8000, 0000 ; Wrecked Ship mainstreet

; Room $CD5C, door 1. Wrecked Ship first flooded room
$83:A2DC             dx CB8B, 00, 04, 01,06, 00,00, 8000, 0000 ; Wrecked Ship spike platform hall

; Room $CDA8, door 0. Wrecked Ship west super missile room
$83:A2E8             dx CAF6, 00, 04, 41,66, 04,06, 8000, 0000 ; Wrecked Ship mainstreet

; Room $CDF1, door 0. Wrecked Ship easy super missile hall
$83:A2F4             dx CAF6, 00, 05, 5E,66, 05,06, 8000, E20F ; Wrecked Ship mainstreet

; Room $CE40, door 0. Gravity suit room
$83:A300             dx 93FE, 40, 05, 5E,36, 05,03, 8000, 0000 ; Wrecked Ship entrance

; Room $CE40, door 1. Gravity suit room
$83:A30C             dx C98E, 00, 04, 11,26, 01,02, 8000, E229 ; Wrecked Ship chozo room

; Room $CE8A, door 0. Wrecked Ship save station
$83:A318             dx CAF6, 00, 05, 4E,36, 04,03, 8000, 0000 ; Wrecked Ship mainstreet

; Room $CED2, door 0. n00b tube save station
$83:A324             dx CEFB, 00, 05, 0E,26, 00,02, 8000, 0000 ; n00b tube

; Room $CEFB, door 0. n00b tube
$83:A330             dx CFC9, 00, 07, 16,7D, 01,07, 0200, 0000 ; Maridia mainstreet

; Room $CEFB, door 1. n00b tube
$83:A33C             dx CF54, 00, 05, 0E,06, 00,00, 8000, 0000 ; n00b tube west

; Room $CEFB, door 2. n00b tube
$83:A348             dx CF80, 00, 04, 01,16, 00,01, 8000, E345 ; n00b tube east

; Maridia load station 0
; Room $CEFB, door 3. n00b tube
$83:A354             dx CED2, 00, 04, 01,06, 00,00, 8000, 0000 ; n00b tube save station

; Room $CF54, door 0. n00b tube west
$83:A360             dx CEFB, 00, 00, 00,00, 00,01, 8000, E378 ; n00b tube

; Room $CF54, door 1. n00b tube west
$83:A36C             dx A408, 40, 05, 1E,16, 01,01, 8000, 0000 ; Pre spazer room

; Room $CF80, door 0. n00b tube east
$83:A378             dx CEFB, 00, 01, 00,00, 00,01, 8000, E378 ; n00b tube

; Brinstar load station Bh
; Room $CF80, door 1. n00b tube east
$83:A384             dx A6A1, 40, 04, 01,06, 00,00, 8000, 0000 ; Kraid's lair entrance

; Room $CF80, door 2. n00b tube east
$83:A390             dx D21C, 00, 04, 01,16, 00,01, 8000, E356 ; Maridia broken glass tube room

; Room $CFC9, door 0. Maridia mainstreet
$83:A39C             dx CEFB, 00, 06, 06,02, 00,00, 0170, 0000 ; n00b tube

; Room $CFC9, door 1. Maridia mainstreet
$83:A3A8             dx D08A, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia green gate hall

; Room $CFC9, door 2. Maridia mainstreet
$83:A3B4             dx D017, 00, 04, 01,26, 00,02, 8000, 0000 ; Maridia space pirate room

; Room $CFC9, door 3. Maridia mainstreet
$83:A3C0             dx D0B9, 00, 04, 01,06, 00,00, 8000, 0000 ; Mt. Doom

; Room $CFC9, door 4. Maridia mainstreet
$83:A3CC             dx D0B9, 00, 00, 00,00, 01,02, 8000, 0000 ; Mt. Doom

; Room $D017, door 0. Maridia space pirate room
$83:A3D8             dx CFC9, 00, 05, 2E,66, 02,06, 8000, 0000 ; Maridia mainstreet

; Room $D017, door 1. Maridia space pirate room
$83:A3E4             dx D055, 00, 04, 01,36, 00,03, 8000, 0000 ; Tatori room

; Room $D017, door 2. Maridia space pirate room
$83:A3F0             dx D0B9, 00, 07, 16,3D, 01,03, 01C0, 0000 ; Mt. Doom

; Room $D017, door 3. Maridia space pirate room
$83:A3FC             dx D0B9, 00, 07, 46,3D, 04,03, 01C0, 0000 ; Mt. Doom

; Room $D055, door 0. Tatori room
$83:A408             dx D017, 00, 05, 3E,26, 03,02, 8000, 0000 ; Maridia space pirate room

; Room $D08A, door 0. Maridia green gate hall
$83:A414             dx CFC9, 00, 05, 1E,76, 01,07, 8000, 0000 ; Maridia mainstreet

; Room $D08A, door 1. Maridia green gate hall
$83:A420             dx D21C, 00, 00, 00,00, 00,00, 8000, 0000 ; Maridia broken glass tube room

; Room $D0B9, door 0. Mt. Doom
$83:A42C             dx D104, 00, 07, 26,1D, 02,01, 01C0, 0000 ; Maridia -> Red Brinstar room

; Room $D0B9, door 1. Mt. Doom
$83:A438             dx CFC9, 00, 05, 1E,06, 01,00, 8000, 0000 ; Maridia mainstreet

; Room $D0B9, door 2. Mt. Doom
$83:A444             dx D017, 00, 06, 06,02, 00,00, 8000, 0000 ; Maridia space pirate room

; Room $D0B9, door 3. Mt. Doom
$83:A450             dx D017, 00, 06, 36,02, 03,00, 8000, 0000 ; Maridia space pirate room

; Room $D0B9, door 4. Mt. Doom
$83:A45C             dx CFC9, 00, 01, 00,00, 02,02, 8000, 0000 ; Maridia mainstreet

; Room $D0B9, door 5. Mt. Doom
$83:A468             dx D1A3, 00, 04, 01,26, 00,02, 8000, 0000 ; Maridia crab shaft

; Room $D104, door 0. Maridia -> Red Brinstar room
$83:A474             dx D0B9, 00, 06, 26,02, 02,00, 8000, 0000 ; Mt. Doom

; Room $D104, door 1. Maridia -> Red Brinstar room
$83:A480             dx A322, 40, 05, 2E,36, 02,03, 8000, E367 ; Red Brinstar -> Crateria elevator

; Room $D13B, door 0. Sandy Maridia missile and super missile room
$83:A48C             dx D16D, 00, 04, 01,06, 00,00, 0140, 0000 ; Sandy Maridia memu room

; Room $D16D, door 0. Sandy Maridia memu room
$83:A498             dx D13B, 00, 05, 1E,06, 01,00, 8000, 0000 ; Sandy Maridia missile and super missile room

; Maridia load station 10h
; Room $D16D, door 1. Sandy Maridia memu room
$83:A4A4             dx D1DD, 00, 04, 01,16, 00,01, 8000, 0000 ; Beach

; Room $D1A3, door 0. Maridia crab shaft
$83:A4B0             dx D0B9, 00, 05, 5E,06, 05,00, 8000, 0000 ; Mt. Doom

; Room $D1A3, door 1. Maridia crab shaft
$83:A4BC             dx D1DD, 00, 07, 06,2D, 00,02, 01C0, 0000 ; Beach

; Room $D1A3, door 2. Maridia crab shaft
$83:A4C8             dx D5A7, 00, 04, 01,16, 00,01, 8000, 0000 ; Snail room

; Room $D1DD, door 0. Beach
$83:A4D4             dx D16D, 00, 05, 3E,16, 03,01, 8000, 0000 ; Sandy Maridia memu room

; Room $D1DD, door 1. Beach
$83:A4E0             dx D1A3, 00, 06, 06,02, 00,00, 8000, 0000 ; Maridia crab shaft

; Room $D1DD, door 2. Beach
$83:A4EC             dx D340, 00, 00, 00,00, 00,02, 8000, 0000 ; Sandy Maridia mainstreet

; Room $D21C, door 0. Maridia broken glass tube room
$83:A4F8             dx D08A, 00, 05, 3E,06, 03,00, 8000, 0000 ; Maridia green gate hall

; Room $D21C, door 1. Maridia broken glass tube room
$83:A504             dx D252, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia broken glass tube room east

; Room $D21C, door 2. Maridia broken glass tube room
$83:A510             dx CF80, 00, 05, 3E,06, 03,00, 8000, 0000 ; n00b tube east

; Room $D21C, door 3. Maridia broken glass tube room
$83:A51C             dx D3B6, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia map station

; Room $D252, door 0. Maridia broken glass tube room east
$83:A528             dx D21C, 00, 01, 00,00, 00,00, 8000, 0000 ; Maridia broken glass tube room

; Room $D252, door 1. Maridia broken glass tube room east
$83:A534             dx D461, 00, 04, 01,06, 00,00, 8000, 0000 ; Evir hall west

; Room $D27E, door 0. Plasma beam puyo room
$83:A540             dx D387, 00, 05, 0E,06, 00,00, 8000, 0000 ; Pre plasma beam shaft

; Room $D27E, door 1. Plasma beam puyo room
$83:A54C             dx D2AA, 00, 04, 01,06, 00,00, 8000, 0000 ; Plasma beam room

; Room $D2AA, door 0. Plasma beam room
$83:A558             dx D27E, 00, 05, 0E,06, 00,00, 8000, 0000 ; Plasma beam puyo room

; Room $D2D9, door 0. Sandy Maridia choot-puyo hall
$83:A564             dx D433, 00, 05, 0E,06, 00,00, 8000, 0000 ; Sandy Maridia quicksand top

; Maridia load station 8
; Room $D2D9, door 1. Sandy Maridia choot-puyo hall
$83:A570             dx D30B, 00, 04, 01,56, 00,05, 8000, 0000 ; Maridia -> Crateria elevator

; Room $D30B, door 0. Maridia -> Crateria elevator
$83:A57C             dx D2D9, 00, 05, 6E,06, 06,00, 8000, 0000 ; Sandy Maridia choot-puyo hall

; Maridia load station 1
; Room $D30B, door 1. Maridia -> Crateria elevator
$83:A588             dx D3DF, 00, 04, 01,06, 00,00, 8000, 0000 ; Sandy Maridia save station

; Room $D30B, door 2. Maridia -> Crateria elevator
$83:A594             dx 94CC, D0, 03, 00,00, 00,00, 0000, 0000 ; Crateria -> Maridia elevator

; Room $D340, door 0. Sandy Maridia mainstreet
$83:A5A0             dx D5EC, 00, 04, 01,06, 00,00, 8000, 0000 ; Sandy Maridia quicksand bottom

; Room $D340, door 1. Sandy Maridia mainstreet
$83:A5AC             dx D408, 00, 02, 00,00, 00,00, 8000, E291 ; Maridia elevatube

; Room $D340, door 2. Sandy Maridia mainstreet
$83:A5B8             dx D387, 00, 04, 01,36, 00,03, 8000, 0000 ; Pre plasma beam shaft

; Room $D340, door 3. Sandy Maridia mainstreet
$83:A5C4             dx D433, 00, 04, 01,06, 00,00, 8000, 0000 ; Sandy Maridia quicksand top

; Room $D387, door 0. Pre plasma beam shaft
$83:A5D0             dx D340, 00, 05, 2E,16, 02,01, 8000, 0000 ; Sandy Maridia mainstreet

; Room $D387, door 1. Pre plasma beam shaft
$83:A5DC             dx D27E, 00, 04, 01,06, 00,00, 8000, 0000 ; Plasma beam puyo room

; Room $D3B6, door 0. Maridia map station
$83:A5E8             dx D21C, 00, 05, 0E,16, 00,01, 8000, E356 ; Maridia broken glass tube room

; Room $D3DF, door 0. Sandy Maridia save station
$83:A5F4             dx D30B, 00, 05, 0E,46, 00,04, 8000, 0000 ; Maridia -> Crateria elevator

; Room $D408, door 0. Maridia elevatube
$83:A600             dx D48E, 00, 06, 06,02, 00,00, 8000, E309 ; Elevatube south

; Room $D408, door 1. Maridia elevatube
$83:A60C             dx D340, 00, 07, 06,2D, 00,02, 0200, E301 ; Sandy Maridia mainstreet

; Room $D433, door 0. Sandy Maridia quicksand top
$83:A618             dx D2D9, 00, 04, 01,06, 00,00, 8000, 0000 ; Sandy Maridia choot-puyo hall

; Room $D433, door 1. Sandy Maridia quicksand top
$83:A624             dx D86E, 00, 02, 00,00, 00,00, 8000, 0000 ; Sandy Maridia quicksand fall

; Room $D433, door 2. Sandy Maridia quicksand top
$83:A630             dx D340, 00, 05, 3E,36, 03,03, 8000, 0000 ; Sandy Maridia mainstreet

; Room $D461, door 0. Evir hall west
$83:A63C             dx D252, 00, 05, 0E,06, 00,00, 8000, 0000 ; Maridia broken glass tube room east

; Maridia load station 13h
; Room $D461, door 1. Evir hall west
$83:A648             dx D48E, 00, 04, 01,16, 00,01, 8000, 0000 ; Elevatube south

; Unused. Room $D461, door 2. Evir hall west
$83:A654             dx D4EF, 00, 03, 00,00, 00,01, 8000, 0000 ; Snail room quicksand items west

; Room $D48E, door 0. Elevatube south
$83:A660             dx D461, 00, 05, 3E,06, 03,00, 8000, 0000 ; Evir hall west

; Room $D48E, door 1. Elevatube south
$83:A66C             dx D4C2, 00, 04, 01,06, 00,00, 8000, 0000 ; Evir hall east

; Room $D48E, door 2. Elevatube south
$83:A678             dx D408, 00, 03, 00,00, 00,09, 8000, E26C ; Maridia elevatube

; Room $D4C2, door 0. Evir hall east
$83:A684             dx D48E, 00, 05, 0E,16, 00,01, 8000, 0000 ; Elevatube south

; Room $D4C2, door 1. Evir hall east
$83:A690             dx D646, 00, 04, 01,36, 00,03, 8000, E3A3 ; Pants room

; Unused. Room $D4C2, door 2. Evir hall east
$83:A69C             dx D51E, 00, 03, 00,00, 01,01, 8000, 0000 ; Snail room quicksand items east

; Room $D4EF, door 0. Snail room quicksand items west
$83:A6A8             dx D54D, 00, 03, 00,00, 00,01, 8000, 0000 ; Snail room quicksand fall west

; Room $D4EF, door 1. Snail room quicksand items west
$83:A6B4             dx D461, 00, 02, 00,00, 02,00, 8000, 0000 ; Evir hall west

; Room $D51E, door 0. Snail room quicksand items east
$83:A6C0             dx D57A, 00, 03, 00,00, 00,01, 8000, 0000 ; Snail room quicksand fall east

; Room $D51E, door 1. Snail room quicksand items east
$83:A6CC             dx D4C2, 00, 02, 00,00, 01,00, 8000, 0000 ; Evir hall east

; Room $D54D, door 0. Snail room quicksand fall west
$83:A6D8             dx D5A7, 00, 03, 00,00, 01,02, 8000, 0000 ; Snail room

; Room $D54D, door 1. Snail room quicksand fall west
$83:A6E4             dx D4EF, 00, 02, 00,00, 01,00, 8000, 0000 ; Snail room quicksand items west

; Room $D57A, door 0. Snail room quicksand fall east
$83:A6F0             dx D5A7, 00, 03, 00,00, 03,02, 8000, 0000 ; Snail room

; Room $D57A, door 1. Snail room quicksand fall east
$83:A6FC             dx D51E, 00, 02, 00,00, 00,00, 8000, 0000 ; Snail room quicksand items east

; Room $D5A7, door 0. Snail room
$83:A708             dx D1A3, 00, 05, 1E,36, 01,03, 8000, E398 ; Maridia crab shaft

; Room $D5A7, door 1. Snail room
$83:A714             dx D54D, 00, 02, 00,00, 00,00, 8000, 0000 ; Snail room quicksand fall west

; Room $D5A7, door 2. Snail room
$83:A720             dx D57A, 00, 02, 00,00, 00,00, 8000, 0000 ; Snail room quicksand fall east

; Maridia load station 12h
; Room $D5A7, door 3. Snail room
$83:A72C             dx D617, 00, 07, 06,0D, 00,00, 01C0, 0000 ; Mochtroid room

; Room $D5A7, door 4. Snail room
$83:A738             dx D6FD, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia speed blockade quicksand bottom

; Maridia load station 2
; Room $D5A7, door 5. Snail room
$83:A744             dx D765, 00, 05, 0E,06, 00,00, 8000, 0000 ; Snail room save station

; Room $D5EC, door 0. Sandy Maridia quicksand bottom
$83:A750             dx D340, 00, 05, 3E,56, 03,05, 8000, 0000 ; Sandy Maridia mainstreet

; Room $D5EC, door 1. Sandy Maridia quicksand bottom
$83:A75C             dx D9FE, 00, 04, 01,16, 00,01, 8000, 0000 ; Maridia cacatac room west

; Room $D617, door 0. Mochtroid room
$83:A768             dx D5A7, 00, 06, 06,02, 00,00, 8000, 0000 ; Snail room

; Room $D617, door 1. Mochtroid room
$83:A774             dx D95E, 00, 04, 01,06, 00,00, 8000, 0000 ; Botwoon

; Room $D646, door 0. Pants room
$83:A780             dx D4C2, 00, 05, 2E,06, 02,00, 8000, 0000 ; Evir hall east

; Room $D646, door 1. Pants room
$83:A78C             dx D69A, 00, 04, 01,26, 00,02, 8000, 0000 ; Pants room section

; Room $D646, door 2. Pants room
$83:A798             dx D8C5, 00, 04, 01,06, 00,00, 8000, 0000 ; Shaktool

; Room $D646, door 3. Pants room
$83:A7A4             dx D646, 00, 05, 0E,36, 00,03, 8000, E3B9 ; Pants room

; Room $D69A, door 0. Pants room section
$83:A7B0             dx D646, 00, 05, 0E,36, 00,03, 8000, E3A3 ; Pants room

; Room $D69A, door 1. Pants room section
$83:A7BC             dx D8C5, 00, 04, 01,06, 00,00, 8000, 0000 ; Shaktool

; Room $D6D0, door 0. Spring ball room
$83:A7C8             dx D8C5, 00, 05, 3E,06, 03,00, 8000, 0000 ; Shaktool

; Room $D6FD, door 0. Maridia speed blockade quicksand bottom
$83:A7D4             dx D5A7, 00, 05, 5E,16, 05,01, 8000, 0000 ; Snail room

; Room $D72A, door 0. Maridia grapple room
$83:A7E0             dx D913, 00, 01, 00,00, 00,00, 8000, 0000 ; Maridia grapple wall shaft

; Maridia load station 3
; Room $D72A, door 1. Maridia grapple room
$83:A7EC             dx D81A, 00, 04, 01,06, 00,00, 8000, 0000 ; Draygon save station

; Room $D72A, door 2. Maridia grapple room
$83:A7F8             dx D78F, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Draygon room

; Unused
$83:A804             dx D913, 00, 01, 00,00, 00,02, 8000, 0000 ; Maridia grapple wall shaft

; Unused. Clone of $A8F4
$83:A810             dx D845, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia missile station

; Maridia load station 11h
$83:A81C             dx D78F, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Draygon room

; Room $D765, door 0. Snail room save station
$83:A828             dx D5A7, 00, 04, 01,26, 00,02, 8000, 0000 ; Snail room

; Room $D78F, door 0. Pre Draygon room
$83:A834             dx D72A, 00, 05, 6E,16, 06,01, 8000, 0000 ; Maridia grapple room

; Room $D78F, door 1. Pre Draygon room
$83:A840             dx DA60, 00, 05, 1E,06, 01,00, 8000, 0000 ; Draygon

; Room $D7E4, door 0. Maridia speed blockade hall
$83:A84C             dx D95E, 00, 05, 1E,06, 01,00, 8000, E38D ; Botwoon

; Room $D7E4, door 1. Maridia speed blockade hall
$83:A858             dx D898, 00, 02, 00,00, 01,00, 8000, 0000 ; Maridia speed blockade quicksand fall

; Room $D7E4, door 2. Maridia speed blockade hall
$83:A864             dx D898, 00, 02, 00,00, 00,00, 8000, 0000 ; Maridia speed blockade quicksand fall

; Room $D7E4, door 3. Maridia speed blockade hall
$83:A870             dx D913, 00, 04, 01,26, 00,02, 8000, 0000 ; Maridia grapple wall shaft

; Room $D81A, door 0. Draygon save station
$83:A87C             dx D9D4, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia energy station

; Room $D81A, door 1. Draygon save station
$83:A888             dx D72A, 00, 05, 6E,06, 06,00, 8000, 0000 ; Maridia grapple room

; Room $D845, door 0. Maridia missile station
$83:A894             dx D913, 00, 05, 4E,26, 04,02, 8000, E318 ; Maridia grapple wall shaft

; Room $D86E, door 0. Sandy Maridia quicksand fall
$83:A8A0             dx D5EC, 00, 02, 00,00, 00,00, 8000, 0000 ; Sandy Maridia quicksand bottom

; Room $D898, door 0. Maridia speed blockade quicksand fall
$83:A8AC             dx D6FD, 00, 02, 00,00, 02,00, 8000, 0000 ; Maridia speed blockade quicksand bottom

; Room $D898, door 1. Maridia speed blockade quicksand fall
$83:A8B8             dx D6FD, 00, 02, 00,00, 03,00, 8000, 0000 ; Maridia speed blockade quicksand bottom

; Room $D8C5, door 0. Shaktool
$83:A8C4             dx D69A, 00, 05, 0E,16, 00,01, 8000, E3C8 ; Pants room section

; Room $D8C5, door 1. Shaktool
$83:A8D0             dx D6D0, 00, 04, 01,06, 00,00, 8000, 0000 ; Spring ball room

; Room $D913, door 0. Maridia grapple wall shaft
$83:A8DC             dx D7E4, 00, 05, 6E,06, 06,00, 8000, 0000 ; Maridia speed blockade hall

; Room $D913, door 1. Maridia grapple wall shaft
$83:A8E8             dx D72A, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia grapple room

; Room $D913, door 2. Maridia grapple wall shaft
$83:A8F4             dx D845, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia missile station

; Room $D913, door 3. Maridia grapple wall shaft
$83:A900             dx DA2B, 00, 05, 4E,16, 04,01, 8000, 0000 ; Maridia cacatac room east

; Room $D95E, door 0. Botwoon
$83:A90C             dx D617, 00, 05, 3E,06, 03,00, 8000, 0000 ; Mochtroid room

; Room $D95E, door 1. Botwoon
$83:A918             dx D7E4, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia speed blockade hall

; Room $D9AA, door 0. Space jump room
$83:A924             dx DA60, 00, 04, 01,16, 00,01, 8000, 0000 ; Draygon

; Room $D9D4, door 0. Maridia energy station
$83:A930             dx D81A, 00, 05, 0E,06, 00,00, 8000, 0000 ; Draygon save station

; Room $D9FE, door 0. Maridia cacatac room west
$83:A93C             dx D5EC, 00, 05, 0E,06, 00,00, 8000, 0000 ; Sandy Maridia quicksand bottom

; Room $D9FE, door 1. Maridia cacatac room west
$83:A948             dx DA2B, 00, 04, 01,06, 00,00, 8000, 0000 ; Maridia cacatac room east

; Room $DA2B, door 0. Maridia cacatac room east
$83:A954             dx D9FE, 00, 05, 0E,06, 00,00, 8000, 0000 ; Maridia cacatac room west

; Room $DA2B, door 1. Maridia cacatac room east
$83:A960             dx D913, 00, 04, 01,16, 00,01, 8000, 0000 ; Maridia grapple wall shaft

; Room $DA60, door 0. Draygon
$83:A96C             dx D78F, 00, 04, 01,26, 00,02, 8000, E3D9 ; Pre Draygon room

; Room $DA60, door 1. Draygon
$83:A978             dx D9AA, 00, 05, 0E,06, 00,00, 8000, 0000 ; Space jump room

; Room $DAAE, door 0. Tourian -> Crateria elevator
$83:A984             dx DAE1, 00, 05, 5E,06, 05,00, 8000, 0000 ; Metroid room 1

; Room $DAAE, door 1. Tourian -> Crateria elevator
$83:A990             dx A66A, D0, 03, 00,00, 00,01, 0000, E4C0 ; Tourian entrance

; Tourian load station 1
; Room $DAAE, door 3. Tourian -> Crateria elevator
$83:A99C             dx DF1B, 00, 04, 01,06, 00,00, 8000, 0000 ; Tourian elevator save station

; Tourian load station 8
; Room $DAE1, door 0. Metroid room 1
$83:A9A8             dx DAAE, 00, 04, 01,36, 00,03, 8000, 0000 ; Tourian -> Crateria elevator

; Room $DAE1, door 1. Metroid room 1
$83:A9B4             dx DB31, 00, 05, 0E,06, 00,00, 8000, 0000 ; Metroid room 2

; Room $DB31, door 0. Metroid room 2
$83:A9C0             dx DAE1, 00, 04, 01,06, 00,00, 8000, 0000 ; Metroid room 1

; Room $DB31, door 1. Metroid room 2
$83:A9CC             dx DB7D, 00, 04, 01,06, 00,00, 8000, 0000 ; Metroid room 3

; Room $DB7D, door 0. Metroid room 3
$83:A9D8             dx DB31, 00, 05, 0E,16, 00,01, 8000, 0000 ; Metroid room 2

; Room $DB7D, door 1. Metroid room 3
$83:A9E4             dx DBCD, 00, 04, 01,06, 00,00, 8000, 0000 ; Metroid room 4

; Room $DBCD, door 0. Metroid room 4
$83:A9F0             dx DB7D, 00, 05, 5E,06, 05,00, 8000, 0000 ; Metroid room 3

; Room $DBCD, door 1. Metroid room 4
$83:A9FC             dx DC19, 00, 06, 16,03, 01,00, 8000, 0000 ; Tourian super-sidehopper room

; Room $DC19, door 0. Tourian super-sidehopper room
$83:AA08             dx DBCD, 00, 07, 06,1E, 00,01, 01C0, 0000 ; Metroid room 4

; Room $DC19, door 1. Tourian super-sidehopper room
$83:AA14             dx DC65, 00, 05, 1E,06, 01,00, 8000, 0000 ; Torizo corpse room

; Room $DC65, door 0. Torizo corpse room
$83:AA20             dx DC19, 00, 04, 01,06, 00,00, 8000, 0000 ; Tourian super-sidehopper room

; Room $DC65, door 1. Torizo corpse room
$83:AA2C             dx DCB1, 00, 05, 3E,06, 03,00, 8000, 0000 ; Shitroid room

; Tourian load station 11h
; Room $DCB1, door 0. Shitroid room
$83:AA38             dx DC65, 00, 04, 01,06, 00,00, 8000, 0000 ; Torizo corpse room

; Room $DCB1, door 1. Shitroid room
$83:AA44             dx DCFF, 00, 01, 00,00, 00,00, 8000, 0000 ; Post Shitroid room

; Room $DCFF, door 0. Post Shitroid room
$83:AA50             dx DCB1, 00, 00, 00,00, 00,00, 8000, 0000 ; Shitroid room

; Room $DCFF, door 1. Post Shitroid room
$83:AA5C             dx DDC4, 00, 04, 01,06, 00,00, 8000, 0000 ; Tourian eye-door room

; Room $DCFF, door 2. Post Shitroid room
$83:AA68             dx DD2E, 00, 05, 0E,06, 00,00, 8000, 0000 ; Tourian refill station

; Room $DD2E, door 0. Tourian refill station
$83:AA74             dx DCFF, 00, 04, 01,16, 00,01, 8000, 0000 ; Post Shitroid room

; Room $DD58, door 0. Mother Brain
$83:AA80             dx DDF3, 00, 04, 01,26, 00,02, 8000, 0000 ; Pre Mother Brain shaft

; Room $DD58, door 1. Mother Brain
$83:AA8C             dx DE4D, 00, 09, 1F,06, 01,00, 8000, 0000 ; Escape room 1

; Room $DDC4, door 0. Tourian eye-door room
$83:AA98             dx DCFF, 00, 05, 0E,16, 00,01, 8000, 0000 ; Post Shitroid room

; Tourian load station 10h
; Room $DDC4, door 1. Tourian eye-door room
$83:AAA4             dx DDF3, 00, 04, 01,06, 00,00, 8000, 0000 ; Pre Mother Brain shaft

; Room $DDF3, door 0. Pre Mother Brain shaft
$83:AAB0             dx DDC4, 00, 05, 3E,06, 03,00, 8000, 0000 ; Tourian eye-door room

; Tourian load station 0
; Room $DDF3, door 1. Pre Mother Brain shaft
$83:AABC             dx DE23, 00, 05, 0E,06, 00,00, 8000, 0000 ; Mother Brain save station

; Room $DDF3, door 2. Pre Mother Brain shaft
$83:AAC8             dx DD58, 00, 05, 3E,06, 03,00, 8000, 0000 ; Mother Brain

; Room $DE23, door 0. Mother Brain save station
$83:AAD4             dx DDF3, 00, 04, 01,16, 00,01, 8000, 0000 ; Pre Mother Brain shaft

; Room $DE4D, door 0. Escape room 1
$83:AAE0             dx DD58, 00, 04, 01,06, 00,00, 8000, 0000 ; Mother Brain

; Room $DE4D, door 1. Escape room 1
$83:AAEC             dx DE7A, 00, 06, 06,03, 00,00, 8000, 0000 ; Escape room 2

; Room $DE7A, door 0. Escape room 2
$83:AAF8             dx DE4D, 00, 07, 06,0C, 00,00, 0200, 0000 ; Escape room 1

; Room $DE7A, door 1. Escape room 2
$83:AB04             dx DEA7, 00, 04, 01,16, 00,01, 8000, 0000 ; Escape room 3

; Room $DEA7, door 0. Escape room 3
$83:AB10             dx DE7A, 00, 05, 0E,16, 00,01, 8000, 0000 ; Escape room 2

; Room $DEA7, door 1. Escape room 3
$83:AB1C             dx DEDE, 00, 04, 01,36, 00,03, 8000, 0000 ; Escape room 4

; Room $DEDE, door 0. Escape room 4
$83:AB28             dx DEA7, 00, 05, 5E,06, 05,00, 8000, 0000 ; Escape room 3

; Room $DEDE, door 1. Escape room 4
$83:AB34             dx 96BA, 40, 04, 01,86, 00,08, 8000, E4CF ; Old Tourian escape shaft

; Room $DF1B, door 0. Tourian elevator save station
$83:AB40             dx DAAE, 00, 05, 0E,36, 00,03, 8000, 0000 ; Tourian -> Crateria elevator

; Room $DF45, door 0. Ceres elevator shaft
$83:AB4C             dx DF8D, 00, 00, 00,00, 00,00, 8000, E513 ; Ceres pre elevator hall

; Ceres load station
; Room $DF8D, door 0. Ceres pre elevator hall
$83:AB58             dx DF45, 00, 01, 00,00, 00,02, 8000, E4E0 ; Ceres elevator shaft

; Room $DF8D, door 1. Ceres pre elevator hall
$83:AB64             dx DFD7, 00, 00, 00,00, 00,00, 8000, 0000 ; Ceres stairs

; Room $DFD7, door 0. Ceres stairs
$83:AB70             dx DF8D, 00, 01, 00,00, 01,00, 8000, 0000 ; Ceres pre elevator hall

; Room $DFD7, door 1. Ceres stairs
$83:AB7C             dx E021, 00, 00, 00,00, 00,00, 8000, 0000 ; Ceres baby metroid hall

; Room $E021, door 0. Ceres baby metroid hall
$83:AB88             dx DFD7, 00, 01, 00,00, 00,01, 8000, 0000 ; Ceres stairs

; Room $E021, door 1. Ceres baby metroid hall
$83:AB94             dx E06B, 00, 00, 00,00, 00,00, 8000, 0000 ; Pre Ceres Ridley hall

; Room $E06B, door 0. Pre Ceres Ridley hall
$83:ABA0             dx E021, 00, 01, 00,00, 01,00, 8000, 0000 ; Ceres baby metroid hall

; Room $E06B, door 1. Pre Ceres Ridley hall
$83:ABAC             dx E0B5, 00, 00, 00,00, 00,00, 8000, 0000 ; Ceres Ridley

; Room $E0B5, door 0. Ceres Ridley
$83:ABB8             dx E06B, 00, 01, 00,00, 01,00, 8000, 0000 ; Pre Ceres Ridley hall

; These four doors appear to be missing the elevator properties byte
; Unused. Room $E82C, door 0. Debug room
; Debug load station
$83:ABC4             dx E82C, 05, 00,00, 01,00, 0100, 0000 ; Debug room

; Unused. Room $E82C, door 1. Debug room
$83:ABCF             dx E82C, 05, 00,00, 01,01, 0100, 0000 ; Debug room

; Unused. Room $E82C, door 2. Debug room
$83:ABDA             dx E82C, 04, 00,00, 00,00, 0100, 0000 ; Debug room

; Unused. Room $E82C, door 3. Debug room
$83:ABE5             dx E82C, 04, 00,00, 00,01, 0100, 0000 ; Debug room
}


;;; $ABF0: FX type tilemap pointers ;;;
{
; This table is too short, it's missing the entries for 28h/2Ah/2Ch (Ceres Ridley/elevator / haze)
; This is fine, because those rooms disabled layer 3 anyway, but it does mean garbage is loaded to VRAM from pointers in the following table

; In bank $8A
$83:ABF0             dw 0000, ; 0: None
                        8000, ; 2: Lava
                        8840, ; 4: Acid
                        9080, ; 6: Water
                        98C0, ; 8: Spores
                        A100, ; Ah: Rain
                        A940, ; Ch: Fog
                        0000,
                        0000,
                        0000,
                        0000,
                        0000,
                        0000,
                        0000,
                        0000,
                        0000,
                        0000, ; 20h: Scrolling sky
                        0000, ; 22h: Unused
                        0000, ; 24h: Fireflea
                        9080  ; 26h: Tourian entrance statue
}


;;; $AC18: FX type function pointers ;;;
{
; In bank $88
$83:AC18             dw B278, ; 0: None
                        B279, ; 2: Lava
                        B2A1, ; 4: Acid
                        C3FF, ; 6: Water
                        DA11, ; 8: Spores
                        D950, ; Ah: Rain
                        DB08, ; Ch: Fog
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        B278,
                        A7D8, ; 20h: Scrolling sky
                        A61B, ; 22h: Unused
                        B07C, ; 24h: Fireflea
                        DB8A, ; 26h: Tourian entrance statue
                        D8DE, ; 28h: Ceres Ridley
                        D928, ; 2Ah: Ceres elevator
                        DDC7  ; 2Ch: Ceres haze
}


;;; $AC46: Area specific palette FX / animated tiles object list pointers ;;;
{
; Loaded by $89:AB82
; Indexed by area index
$83:AC46             dw AC66, AC86, ACA6, ACC6, ACE6, AD06, AD26, AD46 ; Palette FX
$83:AC56             dw AC76, AC96, ACB6, ACD6, ACF6, AD16, AD36, AD56 ; Animated tiles
}


;;; $AC66: Area specific palette FX / animated tiles object lists ;;;
{
; Loaded by $89:AB82
; Indexed by bit index of set bits in FX palette FX / animated tiles bitset
$83:AC66             dw F765, FFE5, FFE9, FFD9, FFDD, FFE1, FFED, F781 ; Crateria palette FX
$83:AC76             dw 8257, 8251, 825D, 8263, 824B, 824B, 824B, 824B ; Crateria animated tiles

$83:AC86             dw F775, F77D, F781, F779, F745, F745, F745, F745 ; Brinstar palette FX
$83:AC96             dw 8257, 8251, 8281, 824B, 824B, 824B, 824B, 824B ; Brinstar animated tiles

$83:ACA6             dw F761, F785, F789, F78D, F791, F745, F745, F745 ; Norfair palette FX
$83:ACB6             dw 8257, 8251, 824B, 824B, 824B, 824B, 824B, 824B ; Norfair animated tiles

$83:ACC6             dw F76D, F745, F745, F745, F745, F745, F745, F745 ; Wrecked Ship palette FX
$83:ACD6             dw 8257, 8251, 8275, 827B, 826F, 824B, 824B, 824B ; Wrecked Ship animated tiles

$83:ACE6             dw F795, F799, F79D, F745, F745, F745, F745, F745 ; Maridia palette FX
$83:ACF6             dw 8257, 8251, 8287, 828D, 824B, 824B, 824B, 824B ; Maridia animated tiles

$83:AD06             dw F761, F7A1, F7A5, FFC9, FFCD, FFD1, FFD5, F745 ; Tourian palette FX
$83:AD16             dw 8257, 8251, 824B, 824B, 824B, 824B, 824B, 824B ; Tourian animated tiles

$83:AD26             dw F745, F745, F745, F745, F745, F745, F745, F745 ; Ceres palette FX
$83:AD36             dw 8257, 8251, 824B, 824B, 824B, 824B, 824B, 824B ; Ceres animated tiles

$83:AD46             dw F745, F745, F745, F745, F745, F745, F745, F745 ; Debug palette FX
$83:AD56             dw 8257, 8251, 824B, 824B, 824B, 824B, 824B, 824B ; Debug animated tiles
}


;;; $AD66: Free space ;;;
{
$83:AD66             fillto $848000, $FF
}
