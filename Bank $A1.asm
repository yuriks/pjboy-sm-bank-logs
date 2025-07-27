;;; $8000: Enemy populations ;;;
{
; Enemy population format is:
;  ________________________________________ Enemy ID
; |      __________________________________ X position
; |     |     _____________________________ Y position
; |     |    |      _______________________ Initialisation parameter (Orientation in SMILE, Tilemaps in RF, Tilemap Parameter in SMART)
; |     |    |     |      _________________ Properties (Special in SMILE, Properties 1 in SMART)
; |     |    |     |     |     ____________ Extra properties (Special GFX in SMILE, Graphics in RF, Properties 2 in SMART)
; |     |    |     |     |    |      ______ Parameter 1 (Speed in SMILE)
; |     |    |     |     |    |     |     _ Parameter 2 (Speed 2 in SMILE)
; |     |    |     |     |    |     |    |
; iiii, xxxx,yyyy, oooo, pppp,gggg, aaaa,bbbb

;  _______ Terminator
; |      _ Number of enemy deaths needed to clear current room
; |     |
; FFFF, nn

; Room $DA60, state $DA8C. Draygon - main area boss is dead
; Room $DD58, state $DDA2. Mother Brain - main area boss is dead
$A1:8000             dw FFFF

; Room $94FD. Wrecked Ship back door
$A1:8002             dw D3BF, 0150,054C, 0000, 2000,0000, 0203,0010, ; Choot
                        D3BF, 0190,050C, 0000, 2000,0000, 0203,0010, ; Choot
                        D3BF, 0214,053C, 0000, 2000,0000, 0203,0010, ; Choot
                        D3BF, 05C8,05BE, 0000, 2000,0000, 0203,0010, ; Choot
                        D3BF, 00B0,051C, 0000, 2000,0000, 0203,0010, ; Choot
                        D6FF, 00FC,0563, 0000, 2000,0000, 0110,0210, ; Skultera
                        D6FF, 01D5,0571, 0000, 2000,0000, 0010,0210, ; Skultera
                        D6FF, 0314,0587, 0000, 2000,0000, 0110,0210, ; Skultera
                        D6FF, 03C4,056B, 0000, 2800,0000, 0010,0210, ; Skultera
                        D6FF, 04D5,0577, 0000, 2800,0000, 0010,0210, ; Skultera
                        D83F, 04C0,04F0, 0000, A000,0000, 0000,2800, ; Suspensor platform
                        D83F, 03C0,04F0, 0000, A000,0000, 0000,2800, ; Suspensor platform
                        D83F, 02C8,04F0, 0000, A000,0000, 0000,2800, ; Suspensor platform
                        FFFF, 0A

; Room $93AA. Landing site power bombs cave
$A1:80D5             dw E9BF, 0088,00D8, 0000, 2800,0000, 0000,0000, ; Alcoon
                        E9BF, 0108,00D8, 0000, 2800,0000, 0000,0000, ; Alcoon
                        E9BF, 0178,00D8, 0000, 2800,0000, 0000,0000, ; Alcoon
                        FFFF, 03

; Room $990D. Crateria slope
$A1:8108             dw D63F, 0316,015C, 0000, 2800,0000, 0001,0000, ; Waver
                        D63F, 0213,01E0, 0000, 2800,0000, 0000,0000, ; Waver
                        D63F, 0102,0262, 0000, 2800,0000, 0001,0000, ; Waver
                        DCFF, 0378,0130, 0003, 2800,0000, 0002,0000, ; Zoomer
                        DCFF, 0498,00A0, 0003, 2001,0000, 0002,0000, ; Zoomer
                        DCFF, 02E9,01D6, 0003, 2001,0000, 0002,0000, ; Zoomer
                        DCFF, 0207,024A, 0003, 2000,0000, 0002,0000, ; Zoomer
                        DCFF, 0178,0230, 0003, 2800,0000, 0002,0000, ; Zoomer
                        DCFF, 0298,01A0, 0003, 2001,0000, 0002,0000, ; Zoomer
                        FFFF, 09

; Room $9A44, state $9A70. Crateria bomb block hall - event "Zebes is awake" is set
$A1:819B             dw EA7F, 0100,0048, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0080,0048, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0180,0048, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0080,00B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0100,00B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0180,00B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        FFFF, 00

; Room $9A44, state $9A56. Crateria bomb block hall - default
$A1:81FE             dw EA7F, 0100,0048, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0080,0048, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0180,0048, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0080,00B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0100,00B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0180,00B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        FFFF, 00

; Room $92FD, state $932E. Crateria mainstreet - event "Zebes is awake" is set
$A1:8261             dw DCFF, 0498,0040, 0002, 2801,0000, 0001,0000, ; Zoomer
                        DCFF, 041F,0088, 0003, 2801,0000, 0001,0000, ; Zoomer
                        DCFF, 0448,00B8, 0003, 2001,0000, 0001,0000, ; Zoomer
                        DB7F, 02FE,003B, 0000, 2000,0000, 0000,0000, ; Skree
                        DB7F, 02BE,005B, 0000, 2000,0000, 0000,0000, ; Skree
                        DB7F, 027E,003B, 0000, 2000,0000, 0000,0000, ; Skree
                        DCFF, 01A0,0178, 0003, 2001,0000, 0001,0000, ; Zoomer
                        D47F, 01B8,0228, 0000, 2000,0000, 0010,0000, ; Ripper
                        DCFF, 0128,0438, 0000, 2003,0000, 0001,0000, ; Zoomer
                        DCFF, 01D4,0438, 0003, 2000,0000, 0001,0000, ; Zoomer
                        DCFF, 0180,0408, 0003, 2001,0000, 0001,0000, ; Zoomer
                        DCFF, 0168,0328, 0000, 2002,0000, 0001,0000, ; Zoomer
                        DCFF, 01EA,02EA, 0001, 2003,0000, 0001,0000, ; Zoomer
                        DCFF, 01C8,0278, 0003, 2001,0000, 0001,0000, ; Zoomer
                        DCFF, 0181,0115, 0002, 2001,0000, 0001,0000, ; Zoomer
                        D47F, 03AD,01E8, 0000, 2000,0000, 0010,0000, ; Ripper
                        FFFF, 10

; Room $9879, state $9890. Pre Bomb Torizo hall - default
; Room $9879, state $98AA. Pre Bomb Torizo hall - area torizo is dead
$A1:8364             dw D0FF, 00ED,0061, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 015E,005C, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 011B,0060, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 0132,0049, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 013A,0065, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 00EA,0042, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 01CA,006B, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 0100,0076, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 019A,0058, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 0190,007E, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 017F,003E, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 01C2,0041, 0000, 2000,0000, 0000,0000, ; Mellow
                        FFFF, 00

; Room $975C, state $9787. Old Mother Brain room - morph ball and missiles have been collected
$A1:8427             dw F653, 0268,0070, 0000, 2000,0004, 8001,0010, ; Grey walking space pirate
                        F353, 02CD,003F, 0000, 2000,0004, 0001,0020, ; Grey wall space pirate
                        F653, 01F9,0070, 0000, 2000,0004, 8000,0010, ; Grey walking space pirate
                        F653, 0178,0070, 0000, 2000,0004, 8001,0010, ; Grey walking space pirate
                        F653, 0068,0080, 0000, 2000,0004, 8001,0020, ; Grey walking space pirate
                        FFFF, 05

; Room $92B3. Gauntlet east
$A1:847A             dw E7BF, 0408,0038, 0000, 2000,0000, 0070,0000, ; Yapping maw
                        E7BF, 02F8,00C8, 0000, 2000,0000, 0070,0001, ; Yapping maw
                        E7BF, 01F8,0038, 0000, 2000,0000, 0070,0000, ; Yapping maw
                        D63F, 0371,0065, 0000, 2000,0000, 0000,0000, ; Waver
                        D63F, 023A,007D, 0000, 2800,0000, 0001,0000, ; Waver
                        D63F, 0166,0077, 0000, 2000,0000, 0000,0000, ; Waver
                        E7BF, 0108,00C8, 0000, 2000,0000, 0070,0001, ; Yapping maw
                        FFFF, 03

; Room $9804, state $981B. Bomb Torizo - default
; Room $9804, state $9835. Bomb Torizo - area torizo is dead
$A1:84ED             dw EEFF, 00DB,00B3, 0000, 2000,0000, 0000,0000, ; Bomb Torizo
                        FFFF, 00

; Room $99BD. Crateria space pirate shaft
$A1:8500             dw F693, 0080,04D0, 0000, 2000,0004, 8000,0018, ; Green walking space pirate
                        F693, 008D,0520, 0000, 2000,0004, 8001,0018, ; Green walking space pirate
                        F693, 008B,0570, 0000, 2000,0004, 8000,0018, ; Green walking space pirate
                        F693, 0084,05C0, 0000, 2000,0004, 8001,0018, ; Green walking space pirate
                        F693, 0096,0610, 0000, 2000,0004, 8000,0018, ; Green walking space pirate
                        E87F, 00B8,03D8, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0048,03D8, 0000, 2000,0000, 0000,0000, ; Beetom
                        FFFF, 07

; Room $9938. Crateria -> Green Brinstar elevator
$A1:8573             dw D73F, 0080,00A2, 0000, 2C00,0000, 0000,0140, ; Elevator
                        FFFF, 00

; Room $9A90, state $9AA2. Crateria chozo missile - default
$A1:8586             dw E6BF, 0032,0078, 0000, 2C00,0000, 0000,8000, ; Morph ball eye
                        E6BF, 0032,0078, 0000, 2C00,0000, 0000,0000, ; Morph ball eye
                        FFFF, 00

; Room $9994. Crateria map station
$A1:85A9             dw FFFF, 00

; Unused
$A1:85AC             dw FFFF, 00

; Room $9A90, state $9ABC. Crateria chozo missile - event "Zebes is awake" is set
$A1:85AF             dw FFFF, 00

; Room $96BA, state $9705. Old Tourian escape shaft - event "Zebes timebomb set" is set
$A1:85B2             dw F613, 0080,0880, 0000, 2800,0004, 0000,0000, ; Silver ninja space pirate
                        F613, 00C0,0880, 0000, 2800,0004, 0000,0000, ; Silver ninja space pirate
                        FFFF, 02

; Unused
$A1:85D5             dw FFFF, 00

; Room $93D5. Crateria save station
$A1:85D8             dw FFFF, 00

; Room $95A8. Forgotten highway elbow
$A1:85DB             dw FFFF, 00

; Room $95FF. Moat
$A1:85DE             dw FFFF, 00

; Room $96BA, state $96D1. Old Tourian escape shaft - default
$A1:85E1             dw D87F, 0114,004C, 0000, 2400,0000, 5003,0050, ; Roach
                        D87F, 0110,0058, 0000, 2400,0000, 9002,0050, ; Roach
                        D87F, 010D,0072, 0000, 2400,0000, AC03,0050, ; Roach
                        D87F, 01EB,0096, 0000, 2400,0000, C804,0050, ; Roach
                        D87F, 01F3,009A, 0000, 2400,0000, C303,0050, ; Roach
                        D87F, 0115,0126, 0000, 2400,0000, 9203,0050, ; Roach
                        D87F, 0114,0123, 0000, 2400,0000, 6003,0050, ; Roach
                        D87F, 0111,0128, 0000, 2400,0000, 9C02,0050, ; Roach
                        D87F, 01EE,0217, 0000, 2400,0000, F004,0050, ; Roach
                        D87F, 0116,06B9, 0000, 2400,0000, BC02,0050, ; Roach
                        FFFF, 00

; Room $93FE. Wrecked Ship entrance
$A1:8684             dw D6FF, 04A4,0570, 0000, 2000,0000, 0010,0210, ; Skultera
                        D6FF, 03CB,057A, 0000, 2000,0000, 0110,0210, ; Skultera
                        F193, 0278,02C0, 0000, 6900,0000, 0000,0000, ; Zeb
                        D3FF, 0590,0430, 0010, 2800,0000, 0560,05C0, ; Gripper
                        D7FF, 0150,00D8, 0000, A000,0000, 0000,0010, ; Tripper
                        D7FF, 0388,0058, 0000, A000,0000, 0000,0010, ; Tripper
                        D7FF, 0370,0160, 0000, A000,0000, 0001,0010, ; Tripper
                        FFFF, 07

; Unused
$A1:86F7             dw FFFF, 00

; Room $92FD, state $9314. Crateria mainstreet - default
$A1:86FA             dw D87F, 04BE,00C0, 0000, 2400,0000, AA02,0050, ; Roach
                        D87F, 04A4,00C9, 0000, 2400,0000, B502,0050, ; Roach
                        D87F, 04BB,00CF, 0000, 2400,0000, D003,0050, ; Roach
                        D87F, 04E4,0041, 0000, 2400,0000, 4804,0080, ; Roach
                        D87F, 0455,002A, 0000, 2400,0000, 6003,00A0, ; Roach
                        D87F, 043F,002E, 0000, 2400,0000, 6C03,00A0, ; Roach
                        D87F, 046F,0027, 0000, 2400,0000, 7802,00A0, ; Roach
                        D87F, 03D8,00C3, 0000, 2400,0000, CA03,0050, ; Roach
                        D87F, 03D2,00C9, 0000, 2400,0000, C803,0050, ; Roach
                        D87F, 03DB,00CE, 0000, 2400,0000, E202,0050, ; Roach
                        D87F, 011B,00BC, 0000, 2400,0000, A002,0050, ; Roach
                        D87F, 0112,00C4, 0000, 2400,0000, AB02,0050, ; Roach
                        D87F, 012C,0229, 0000, 2400,0000, 7C03,0080, ; Roach
                        D87F, 0124,022D, 0000, 2400,0000, 9403,0080, ; Roach
                        D87F, 0143,023F, 0000, 2400,0000, 8402,0080, ; Roach
                        D87F, 013F,02BF, 0000, 2400,0000, A102,0040, ; Roach
                        D87F, 0145,02BA, 0000, 2400,0000, 9103,0040, ; Roach
                        D87F, 013D,02C3, 0000, 2400,0000, 8C02,0040, ; Roach
                        D87F, 010D,02DB, 0000, 2400,0000, AC03,0080, ; Roach
                        D87F, 01A5,04E0, 0000, 2400,0000, E804,0020, ; Roach
                        FFFF, 00

; Room $91F8, state $9213. Landing site - default
; Room $91F8, state $922D. Landing site - event "Zebes is awake" is set
; Room $91F8, state $9247. Landing site - power bombs have been collected
$A1:883D             dw D07F, 0480,0478, 0000, 2400,0000, 0000,0000, ; Gunship top
                        D0BF, 0480,0478, 0000, 2400,0000, 0000,0000, ; Gunship bottom / entrance pad
                        D0BF, 0480,0478, 0000, 2400,0000, 0000,0001, ; Gunship bottom / entrance pad
                        FFFF, 00

; Room $99F9. Crateria spike floor room
$A1:8870             dw CEBF, 0258,07A8, 0000, 2000,0000, 0103,0020, ; Boyon
                        CEBF, 0278,07A8, 0000, 2000,0000, 0103,0020, ; Boyon
                        CEBF, 0298,07A8, 0000, 2000,0000, 0103,0020, ; Boyon
                        CEBF, 02B8,07A8, 0000, 2000,0000, 0103,0020, ; Boyon
                        FFFF, 00

; Unused
$A1:88B3             dw FFFF, 00

; Room $968F. Orange zoomer hall
$A1:88B6             dw DC3F, 0080,0048, 0003, 2001,0000, 0001,0000, ; Wrecked Ship orange zoomer
                        FFFF, 01

; Room $96BA, state $96EB. Old Tourian escape shaft - event "Zebes is awake" is set
$A1:88C9             dw F353, 0130,00D8, 0000, 2000,0004, 8000,00A0, ; Grey wall space pirate
                        F353, 01D0,0128, 0000, 2000,0004, 8001,00A0, ; Grey wall space pirate
                        F353, 0130,01D8, 0000, 2000,0004, 8000,00A0, ; Grey wall space pirate
                        F353, 0130,0338, 0000, 2000,0004, 8000,00A0, ; Grey wall space pirate
                        F353, 01D0,03D8, 0000, 2000,0004, 8001,00A0, ; Grey wall space pirate
                        F353, 0130,04B8, 0000, 2000,0004, 8000,00A0, ; Grey wall space pirate
                        F353, 01D0,05A8, 0000, 2000,0004, 8001,00A0, ; Grey wall space pirate
                        F353, 012D,0698, 0000, 2000,0004, 8000,00A0, ; Grey wall space pirate
                        F353, 01D0,0278, 0000, 2000,0004, 8001,00A0, ; Grey wall space pirate
                        F353, 01D0,0708, 0000, 2000,0004, 8001,00A0, ; Grey wall space pirate
                        F353, 0130,07C8, 0000, 2000,0004, 8000,00A0, ; Grey wall space pirate
                        FFFF, 0B

; Room $9461. Pre orange zoomer hall
$A1:897C             dw D3BF, 0070,00CC, 0000, 2000,0000, 0204,0000, ; Choot
                        D3BF, 00E0,00CC, 0000, 2000,0000, 0204,0000, ; Choot
                        D3BF, 0150,00CC, 0000, 2000,0000, 0204,0000, ; Choot
                        D63F, 00AA,005D, 0000, 2800,0000, 0000,0000, ; Waver
                        D63F, 00E9,0075, 0000, 2800,0000, 0001,0000, ; Waver
                        D63F, 0136,0063, 0000, 2800,0000, 0000,0000, ; Waver
                        FFFF, 06

; Room $962A. Crateria -> Red Brinstar elevator
$A1:89DF             dw D73F, 0080,00C2, 0000, 2C00,0000, 0000,0140, ; Elevator
                        FFFF, 00

; Room $965B. Gauntlet west
$A1:89F2             dw E7BF, 0088,0038, 0000, 2000,0000, 0070,0000, ; Yapping maw
                        F1D3, 0088,00B8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        FFFF, 01

; Room $975C, state $976D. Old Mother Brain room - default
$A1:8A15             dw D87F, 006B,0038, 0000, 2400,0000, 2802,0050, ; Roach
                        D87F, 0070,0034, 0000, 2400,0000, 7803,0050, ; Roach
                        D87F, 005A,002D, 0000, 2400,0000, 7C02,0050, ; Roach
                        D87F, 0073,00AD, 0000, 2400,0000, 9402,0050, ; Roach
                        D87F, 007A,00B7, 0000, 2400,0000, C403,0050, ; Roach
                        D87F, 006C,00C3, 0000, 2400,0000, 7C03,0050, ; Roach
                        D87F, 007F,00B2, 0000, 2400,0000, C203,0050, ; Roach
                        D87F, 00BD,00CA, 0000, 2400,0000, C103,0050, ; Roach
                        D87F, 02C9,00A6, 0000, 2400,0000, F002,0050, ; Roach
                        D87F, 02CC,00AB, 0000, 2400,0000, EC04,0050, ; Roach
                        FFFF, 00

; Room $957D. Crab maze
$A1:8AB8             dw D77F, 0278,00AC, 0003, 2000,0000, 0002,0000, ; Sciser
                        D77F, 0015,0098, 0003, 2001,0000, 0002,0000, ; Sciser
                        D77F, 00D1,00C8, 0003, 2000,0000, 0002,0000, ; Sciser
                        D77F, 0202,0068, 0003, 2000,0000, 0001,0000, ; Sciser
                        D77F, 011E,01D8, 0003, 2801,0000, 0003,0000, ; Sciser
                        D77F, 0118,0158, 0003, 2001,0000, 0001,0000, ; Sciser
                        D77F, 00B2,01B8, 0003, 2001,0000, 0001,0000, ; Sciser
                        D77F, 02A8,01C4, 0003, 2800,0000, 0003,0000, ; Sciser
                        FFFF, 08

; Room $95D4. Crateria tube
$A1:8B3B             dw FFFF, 00

; Room $9552. Forgotten highway kago shaft
$A1:8B3E             dw E7FF, 0050,0340, 0000, A000,0000, 000A,0000, ; Kago
                        E7FF, 00A8,0200, 0000, A000,0000, 000A,0000, ; Kago
                        FFFF, 02

; Room $97B5. Crateria -> Blue Brinstar elevator
$A1:8B61             dw D73F, 0080,00A2, 0000, 2C00,0000, 0000,0140, ; Elevator
                        FFFF, 00

; Room $94CC. Crateria -> Maridia elevator
$A1:8B74             dw D73F, 0080,00C0, 0000, 2C00,0000, 0000,0140, ; Elevator
                        FFFF, 00

; Room $98E2. Pre Crateria map station hall
$A1:8B87             dw D0FF, 014C,006E, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 00FB,0059, 0000, 2000,0000, 0000,0000, ; Mellow
                        D0FF, 01A7,005A, 0000, 2000,0000, 0000,0000, ; Mellow
                        D27F, 014B,0045, 0000, 2000,0000, 0000,0000, ; Rio
                        FFFF, 01

; Room $9969. West Crateria kago hall
$A1:8BCA             dw E7FF, 0100,00A0, 0000, A000,0000, 000A,0000, ; Kago
                        E7FF, 0210,00B0, 0000, A000,0000, 000A,0000, ; Kago
                        DD3F, 02F8,0070, 0003, 2000,0000, 0002,0000, ; Stone zoomer
                        DD3F, 01A8,0070, 0003, 2001,0000, 0002,0000, ; Stone zoomer
                        FFFF, 04

; Room $91F8, state $9261. Landing site - event "Zebes timebomb set" is set
$A1:8C0D             dw D07F, 0480,0478, 0000, 2400,0000, 0000,0000, ; Gunship top
                        D0BF, 0480,0478, 0000, 2400,0000, 0000,0000, ; Gunship bottom / entrance pad
                        D0BF, 0480,0478, 0000, 2400,0000, 0000,0001, ; Gunship bottom / entrance pad
                        E1FF, 0051,04AA, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0080,04BC, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 00A1,04D0, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 00E5,04D7, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 015B,04D7, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 019D,04D5, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 01C0,04C9, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0222,04C8, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0243,04C4, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 027C,04CE, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0317,04D7, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 033F,04C9, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 036C,04B6, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0390,04A9, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 03D9,04B7, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 041A,04D9, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 049C,04D8, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 04F9,04CA, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0525,04BB, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0557,04C9, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 05C6,04D4, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0624,04D4, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        FFFF, 00

; Room $92FD, state $9348. Crateria mainstreet - event "Zebes timebomb set" is set
$A1:8DA0             dw E1FF, 0145,00B5, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 01B9,00BA, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 01DE,00A9, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0227,00B1, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 023D,00B9, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 026F,00C0, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 02B1,00D0, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 02D1,00C8, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 030B,00C0, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 032F,00A0, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 035E,0088, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0384,0077, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 03DC,0079, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 03FE,008E, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 041F,00A1, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 045C,00C4, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 047F,00B3, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 04AA,00AE, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 04CC,00A6, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        FFFF, 00

; Room $9804, state $984F. Bomb Torizo - event "Zebes timebomb set" is set
$A1:8ED3             dw F313, 00E0,00B8, 0000, 2400,0000, 0000,0000, ; Escape dachora
                        F2D3, 00E0,00B8, 0000, 2000,0000, 0000,0000, ; Escape etecoon
                        F2D3, 00E0,00B8, 0000, 2000,0000, 0002,0000, ; Escape etecoon
                        F2D3, 00E0,00B8, 0000, 2000,0000, 0004,0000, ; Escape etecoon
                        FFFF, 04

; Room $9879, state $98C4. Pre Bomb Torizo hall - event "Zebes timebomb set" is set
$A1:8F16             dw FFFF, 00

; Room $948C. Pre moat room
$A1:8F19             dw EABF, 0264,0073, 0000, 2800,0000, 0000,0000, ; Green ki-hunter
                        EAFF, 0264,0073, 0000, 2C00,0000, 0020,0000, ; Green ki-hunter wings
                        EABF, 00A8,0087, 0000, 2800,0000, 0000,0000, ; Green ki-hunter
                        EAFF, 00A8,0087, 0000, 2C00,0000, 0020,0000, ; Green ki-hunter wings
                        D77F, 0198,01D8, 0003, 2801,0000, 0001,0000, ; Sciser
                        D77F, 0165,021A, 0003, 2000,0000, 0001,0000, ; Sciser
                        FFFF, 04

; Room $9B9D. Pre Brinstar map room hall
$A1:8F7C             dw D93F, 0244,003B, 0000, 2000,0000, 0001,0000, ; Sidehopper
                        DC7F, 0178,0058, 0003, 2001,0000, 0001,0002, ; Zeela
                        DC7F, 01A8,0058, 0003, 2801,0000, 0001,0002, ; Zeela
                        DC7F, 0049,0040, 0001, 2000,0000, 0000,0002, ; Zeela
                        FFFF, 04

; Room $9C35. Brinstar map station
$A1:8FBF             dw FFFF, 00

; Room $9C89. Green Brinstar missile station
$A1:8FC2             dw FFFF, 00

; Room $9D9C. Pre Spore Spawn hall
$A1:8FC5             dw EABF, 00D9,0068, 0000, 2800,0000, 003C,0000, ; Green ki-hunter
                        EAFF, 00D9,0068, 0000, 2C00,0000, 0020,0000, ; Green ki-hunter wings
                        EABF, 02D5,0062, 0000, 2800,0000, 003C,0000, ; Green ki-hunter
                        EAFF, 02D5,0062, 0000, 2C00,0000, 0020,0000, ; Green ki-hunter wings
                        EABF, 03D7,0068, 0000, 2800,0000, 003C,0000, ; Green ki-hunter
                        EAFF, 03D7,0068, 0000, 2C00,0000, 0020,0000, ; Green ki-hunter wings
                        FFFF, 03

; Room $A051. Etecoon area super missiles
$A1:9028             dw FFFF, 00

; Room $A07B. Dachora energy station
$A1:902B             dw FFFF, 00

; Room $A0A4. Post Spore Spawn supers hall
$A1:902E             dw F193, 0180,00B8, 0000, 6900,0000, 0000,0000, ; Zeb
                        F193, 0110,00B8, 0000, 6900,0000, 0000,0000, ; Zeb
                        F193, 00E0,00B8, 0000, 6900,0000, 0000,0000, ; Zeb
                        DC7F, 0080,0042, 0002, 2001,0000, 00FF,0002, ; Zeela
                        DC7F, 00B0,0042, 0002, 2001,0000, 00FF,0002, ; Zeela
                        FFFF, 05

; Room $A66A. Tourian entrance
$A1:9081             dw D73F, 0080,01B0, 0000, 2C00,0000, 0000,0240, ; Elevator
                        EFFF, 0078,00B8, 0000, 2000,0000, 0000,0000, ; Tourian entrance statue
                        EFFF, 008E,0055, 0000, 2000,0000, 0002,0000, ; Tourian entrance statue
                        EFFF, 0084,0088, 0000, 2000,0000, 0004,0000, ; Tourian entrance statue
                        FFFF, 00

; Room $A15B. Brinstar wave-gate energy tank
$A1:90C4             dw FFFF, 00

; Room $A37C. Red Brinstar power bomb floor room
$A1:90C7             dw E7BF, 0170,00D0, 0000, 2000,0000, 0036,0001, ; Yapping maw
                        E7BF, 00F0,00D0, 0000, 2000,0000, 0036,0001, ; Yapping maw
                        D9BF, 00F0,0058, 0000, 2000,0000, 8000,0000, ; Super-sidehopper
                        D9BF, 0170,0058, 0000, 2000,0000, 8000,0000, ; Super-sidehopper
                        D9BF, 0078,0058, 0000, 2000,0000, 8000,0000, ; Super-sidehopper
                        FFFF, 03

; Room $A0D2. Pink Brinstar flooded hall
$A1:911A             dw D6FF, 0140,00AE, 0000, 2800,0000, 0010,1001, ; Skultera
                        CFBF, 0169,00B3, 0000, 2000,0000, 0002,0001, ; Puyo
                        CFBF, 01F7,00B3, 0000, 2000,0000, 0002,0001, ; Puyo
                        CFBF, 0224,00B5, 0000, 2000,0000, 0002,0001, ; Puyo
                        D6FF, 024B,00AE, 0000, 2000,0000, 0010,1001, ; Skultera
                        D7BF, 0430,00B8, 0003, 2001,0000, 0000,0000, ; Zero
                        D7BF, 05F0,0058, 0002, 2001,0000, 0000,0000, ; Zero
                        FFFF, 07

; Room $9F11, state $9F3D. Old Kraid entrance - event "Zebes is awake" is set
$A1:918D             dw DCFF, 0058,0078, 0003, 2001,0000, 0002,0000, ; Zoomer
                        DCFF, 00A8,0094, 0002, 2001,0000, 0002,0000, ; Zoomer
                        EA7F, 0048,0088, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 00B8,0088, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 00E8,0116, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 00E8,0166, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0018,0116, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        FFFF, 02

; Room $9F64, state $9F90. Blue Brinstar ceiling e-tank hall - event "Zebes is awake" is set
$A1:9200             dw DCFF, 00A8,02C8, 0003, 2800,0000, 0002,0000, ; Zoomer
                        DCFF, 00D8,02C8, 0003, 2000,0000, 0002,0000, ; Zoomer
                        DB7F, 00DE,024B, 0000, 2000,0000, 0000,0000, ; Skree
                        DB7F, 00FE,023B, 0000, 2000,0000, 0000,0000, ; Skree
                        D27F, 01F0,0240, 0000, 2000,0000, 0000,0000, ; Rio
                        EA7F, 0038,0228, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0038,02A8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 02E8,02B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0268,0088, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0288,0088, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        FFFF, 05

; Room $9FBA. n00b bridge
$A1:92A3             dw CFFF, 00C0,00B3, 0000, 2000,0000, 0100,0301, ; Cacatac
                        CFFF, 01B0,00B3, 0000, 2000,0000, 0100,0301, ; Cacatac
                        CFFF, 0570,00B3, 0000, 2000,0000, 0101,0301, ; Cacatac
                        CFFF, 03D0,00B3, 0000, 2000,0000, 0100,0301, ; Cacatac
                        DC7F, 0248,0076, 0002, 2801,0000, 0000,0002, ; Zeela
                        DC7F, 02A8,0076, 0002, 2801,0000, 0000,0002, ; Zeela
                        DC7F, 0300,0076, 0002, 2801,0000, 0000,0002, ; Zeela
                        DC7F, 0368,0076, 0002, 2801,0000, 0000,0002, ; Zeela
                        FFFF, 08

; Room $9E9F, state $9ECB. Morph ball room - event "Zebes is awake" is set
$A1:9326             dw D73F, 0580,02C2, 0000, 2C00,0000, 0001,0018, ; Elevator
                        D9BF, 0098,02A6, 0000, 2000,0000, 0000,0000, ; Super-sidehopper
                        D9BF, 017C,02A6, 0000, 2000,0000, 0000,0000, ; Super-sidehopper
                        D9BF, 0107,026C, 0000, 2000,0000, 8000,0000, ; Super-sidehopper
                        EA7F, 0548,0240, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 05B8,0240, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0488,02B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0428,02B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        FFFF, 03

; Room $A70B. Kraid's lair save station
$A1:93A9             dw FFFF, 00

; Room $9E9F, state $9EB1. Morph ball room - default
$A1:93AC             dw E6BF, 0408,0248, 0000, 2C00,0000, 0000,8000, ; Morph ball eye
                        E6BF, 0408,0248, 0000, 2C00,0000, 0001,0000, ; Morph ball eye
                        D73F, 0580,02C2, 0000, 2C00,0000, 0001,0018, ; Elevator
                        EA7F, 0548,0240, 0000, A000,0000, 0040,0001, ; Blue Brinstar face block
                        EA7F, 05B8,0240, 0000, A000,0000, 0040,0000, ; Blue Brinstar face block
                        EA7F, 0488,02B8, 0000, A000,0000, 0040,0000, ; Blue Brinstar face block
                        EA7F, 0428,02B8, 0000, A000,0000, 0040,0001, ; Blue Brinstar face block
                        FFFF, 00

; Room $A471. Kraid's lair zeela room
$A1:941F             dw DC7F, 006A,0040, 0001, 2800,0000, 0002,0002, ; Zeela
                        DC7F, 006A,0068, 0001, 2800,0000, 0002,0002, ; Zeela
                        DC7F, 002B,00E8, 0003, 2800,0000, 0002,0002, ; Zeela
                        FFFF, 03

; Room $A253. Red Brinstar mainstreet
$A1:9452             dw D47F, 0098,0208, 0000, 2000,0000, 0010,0000, ; Ripper
                        D47F, 0060,00E8, 0000, 2000,0000, 0010,0001, ; Ripper
                        D47F, 0098,0140, 0000, 2000,0000, 0010,0000, ; Ripper
                        D47F, 0068,01A0, 0000, 2000,0000, 0010,0001, ; Ripper
                        E87F, 00CF,0658, 0000, 2000,0000, 0000,0000, ; Beetom
                        D47F, 0098,0948, 0000, 2000,0000, 0010,0000, ; Ripper
                        D47F, 005F,08E8, 0000, 2000,0000, 0010,0001, ; Ripper
                        D47F, 009D,0888, 0000, 2000,0000, 0010,0000, ; Ripper
                        D47F, 0068,0800, 0000, 2000,0000, 0010,0001, ; Ripper
                        F253, 0018,0530, 0000, 6100,0000, 0000,0020, ; Geega
                        F253, 00C8,0550, 0000, 6100,0000, 0001,0020, ; Geega
                        FFFF, 0B

; Room $A1AD. Blue Brinstar boulder room
$A1:9505             dw DFBF, 0158,00C0, 0080, 2000,0000, 0200,A050, ; Boulder
                        DFBF, 00F0,00C0, 0080, 2000,0000, 0200,A050, ; Boulder
                        DFBF, 0090,00C0, 0080, 2000,0000, 0200,A050, ; Boulder
                        FFFF, 00

; Room $A1D8. Blue Brinstar double missile room
$A1:9538             dw FFFF, 00

; Room $A184. Spore Spawn save station
$A1:953B             dw FFFF, 00

; Room $9D19. Charge beam room
$A1:953E             dw D27F, 02E8,0478, 0000, 2000,0000, 0000,0000, ; Rio
                        D27F, 0328,0478, 0000, 2800,0000, 0000,0000, ; Rio
                        D27F, 0335,05A9, 0000, 2000,0000, 0000,0000, ; Rio
                        D93F, 0239,00FC, 0000, 2000,0000, 0001,0000, ; Sidehopper
                        D93F, 02F8,00ED, 0000, 2000,0000, 0001,0000, ; Sidehopper
                        D93F, 0250,0418, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        D93F, 02B0,0418, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        F193, 02C0,0098, 0000, 6900,0000, 0000,0000, ; Zeb
                        F193, 02B0,0228, 0000, 6900,0000, 0000,0000, ; Zeb
                        F193, 0320,0549, 0000, 6900,0000, 0000,0000, ; Zeb
                        FFFF, 0A

; Room $A22A. Etecoon area save station
$A1:95E1             dw FFFF, 00

; Room $A408. Pre spazer room
$A1:95E4             dw E7BF, 0190,01C8, 0000, 2000,0000, 0030,0001, ; Yapping maw
                        E7BF, 0080,01C8, 0000, 2000,0000, 0030,0001, ; Yapping maw
                        CFFF, 0108,0193, 0000, 2000,0000, 0100,0200, ; Cacatac
                        FFFF, 01

; Room $A201. Green Brinstar mainstreet save station
$A1:9617             dw FFFF, 00

; Room $A447. Spazer room
$A1:961A             dw FFFF, 00

; Room $9E11. Brinstar super-sidehopper power bomb room
$A1:961D             dw D53F, 0038,0190, 0008, A800,FFFF, 6004,0000, ; Shootable shutter
                        D53F, 0198,01F0, 0008, A800,FFFF, 4004,0000, ; Shootable shutter
                        D9BF, 00F1,00A6, 0000, 2000,0000, 0000,0000, ; Super-sidehopper
                        D9BF, 0068,0064, 0000, 2000,0000, 8000,0000, ; Super-sidehopper
                        FFFF, 02

; Room $A618. Red Brinstar energy station
$A1:9660             dw FFFF, 00

; Room $A641. Kraid's lair refill station
$A1:9663             dw FFFF, 00

; Room $A6E2. Varia suit room
$A1:9666             dw FFFF, 00

; Room $A734. Red Brinstar save station
$A1:9669             dw FFFF, 00

; Unused
$A1:966C             dw FFFF, 00

; Room $9F64, state $9F76. Blue Brinstar ceiling e-tank hall - default
$A1:966F             dw E6BF, 0228,0268, 0000, 2C00,0000, 0000,8001, ; Morph ball eye
                        E6BF, 0228,0268, 0000, 2C00,0000, 0000,0000, ; Morph ball eye
                        EA7F, 0038,0228, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0038,02A8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 02E8,02B8, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0268,0088, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0288,0088, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        FFFF, 00

; Room $9C5E. Fireflea room
$A1:96E2             dw D6BF, 0180,005F, 0000, 2000,0000, 0002,0210, ; Fireflea
                        D6BF, 00E1,006A, 0000, 2000,0000, 0003,0210, ; Fireflea
                        D6BF, 0045,005B, 0000, 2000,0000, 0002,0210, ; Fireflea
                        D6BF, 0070,0118, 0000, 2000,0000, 0000,0308, ; Fireflea
                        D6BF, 00A0,0138, 0000, 2000,0000, 0000,0408, ; Fireflea
                        FFFF, 05

; Room $9FE5. Etecoon area beetom room
$A1:9735             dw E87F, 0050,00B8, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0070,00B8, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0090,00B8, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 00B0,00B8, 0000, 2000,0000, 0000,0000, ; Beetom
                        FFFF, 04

; Room $A011. Etecoon area spike hall
$A1:9778             dw F1D3, 0250,01D8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 02F0,01D8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0430,01D8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        E87F, 01D8,0198, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0278,0198, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0360,01A8, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 03D8,01A8, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0458,01A8, 0000, 2000,0000, 0000,0000, ; Beetom
                        FFFF, 08

; Room $A130. Brinstar wave-gate sidehopper room
$A1:97FB             dw D9BF, 00B5,01B5, 0000, 2000,0000, 0000,0000, ; Super-sidehopper
                        D93F, 00F8,01A0, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        D93F, 006A,01C1, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        D53F, 0158,01E0, 0008, A800,00FF, 4003,0000, ; Shootable shutter
                        D53F, 0158,01E0, 0008, A800,00FF, 8003,0000, ; Shootable shutter
                        D53F, 0158,01E0, 0008, A800,00FF, C003,0000, ; Shootable shutter
                        D53F, 0158,01E0, 0008, A800,00FF, F003,0000, ; Shootable shutter
                        D53F, 0148,01E0, 0000, A800,0000, 0000,0000, ; Shootable shutter
                        D53F, 0168,01E0, 0000, A800,0000, 0000,0000, ; Shootable shutter
                        FFFF, 03

; Room $A4B1. Kraid's lair beetom room
$A1:988E             dw E87F, 002D,0098, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0047,0098, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 008B,00A8, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0060,0098, 0000, 2000,0000, 0000,0000, ; Beetom
                        FFFF, 04

; Unused
$A1:98D1             dw D73F, 0080,00A0, 0000, 2C00,0000, 0000,0140, ; Elevator
                        FFFF, 00

; Room $A6A1. Kraid's lair entrance
$A1:98E4             dw D73F, 0080,00A0, 0000, 2C00,0000, 0000,0140, ; Elevator
                        FFFF, 00

; Room $A4DA. Kraid's lair kihunter hall
$A1:98F7             dw EABF, 0169,0070, 0000, 2800,0000, 0000,0000, ; Green ki-hunter
                        EAFF, 0169,0070, 0000, 2C00,0000, 0020,0000, ; Green ki-hunter wings
                        EABF, 0289,0059, 0000, 2800,0000, 0000,0000, ; Green ki-hunter
                        EAFF, 0289,0059, 0000, 2C00,0000, 0020,0000, ; Green ki-hunter wings
                        EABF, 01FE,0063, 0000, 2800,0000, 0000,0000, ; Green ki-hunter
                        EAFF, 01FE,0063, 0000, 2C00,0000, 0020,0000, ; Green ki-hunter wings
                        EABF, 0242,007A, 0000, 2800,0000, 0000,0000, ; Green ki-hunter
                        EAFF, 0242,007A, 0000, 2C00,0000, 0020,0000, ; Green ki-hunter wings
                        FFFF, 04

; Room $9AD9. Green Brinstar mainstreet
$A1:997A             dw D73F, 0080,02C2, 0000, 2C00,0000, 0001,0018, ; Elevator
                        DC7F, 00DA,02CB, 0001, 2803,0000, 0001,0002, ; Zeela
                        DC7F, 0070,0398, 0003, 2001,0000, 0001,0002, ; Zeela
                        D43F, 006C,03F6, 0000, 2000,0000, 0018,0001, ; Ripper ii
                        DC7F, 0079,06E8, 0003, 2000,0000, 0001,0002, ; Zeela
                        D43F, 0043,0548, 0000, 2000,0000, 0018,0001, ; Ripper ii
                        DC7F, 007B,05F8, 0001, 2002,0000, 0001,0002, ; Zeela
                        DC7F, 0027,03CC, 0000, 2003,0000, 0001,0002, ; Zeela
                        E5BF, 025F,0B98, 0000, 0C00,0000, 0000,0000, ; Etecoon
                        E5BF, 026F,0B98, 0000, 0C00,0000, 0000,0001, ; Etecoon
                        E5BF, 027F,0B98, 0000, 0C00,0000, 0000,0002, ; Etecoon
                        FFFF, 07

; Room $9B5B. Spore Spawn's super missile shaft
$A1:9A2D             dw F193, 00C0,00B8, 0000, 6900,0000, 0000,0000, ; Zeb
                        FFFF, 01

; Room $9BC8. Early supers room
$A1:9A40             dw D93F, 01BA,01A8, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        D93F, 0200,01A8, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        D4FF, 0198,0128, 0001, A800,0000, 0090,0010, ; Timed shutter
                        D4FF, 0228,0128, 0001, A800,0000, 0090,0010, ; Timed shutter
                        D4FF, 0288,0128, 0001, A800,0000, 0090,0010, ; Timed shutter
                        D63F, 00AB,004B, 0000, 2000,0000, 0000,0000, ; Waver
                        D63F, 0108,006B, 0000, 2800,0000, 0001,0000, ; Waver
                        D63F, 0211,0065, 0000, 2000,0000, 0001,0000, ; Waver
                        D63F, 0141,0056, 0000, 2800,0000, 0001,0000, ; Waver
                        F193, 0090,01B8, 0000, 6900,0000, 0000,0000, ; Zeb
                        D93F, 0142,0085, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        D93F, 01C3,0084, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        D93F, 0183,003D, 0000, 2000,0000, 0001,0000, ; Sidehopper
                        FFFF, 0A

; Room $A293. Pre x-ray spike hall
$A1:9B13             dw D6BF, 06D0,0090, 0000, 2000,0000, 0000,0306, ; Fireflea
                        D6BF, 0710,0070, 0000, 2000,0000, 0002,0518, ; Fireflea
                        D6BF, 0688,0060, 0000, 2000,0000, 0003,0418, ; Fireflea
                        D6BF, 04E0,00A8, 0000, 2000,0000, 0002,0210, ; Fireflea
                        D6BF, 0630,0080, 0000, 2000,0000, 0003,0220, ; Fireflea
                        D63F, 0745,0050, 0000, 2800,0000, 0000,0000, ; Waver
                        D63F, 0690,0060, 0000, 2800,0000, 0000,0000, ; Waver
                        D63F, 0600,0060, 0000, 2800,0000, 0001,0000, ; Waver
                        E7BF, 0198,00C8, 0000, 2000,0000, 0050,0001, ; Yapping maw
                        E7BF, 0258,00C0, 0000, 2000,0000, 0050,0001, ; Yapping maw
                        E7BF, 03A8,00C0, 0000, 2000,0000, 0050,0001, ; Yapping maw
                        FFFF, 08

; Room $9F11, state $9F23. Old Kraid entrance - default
$A1:9BC6             dw D87F, 002E,00C0, 0000, 2400,0000, 8A03,0050, ; Roach
                        D87F, 00DE,00B3, 0000, 2400,0000, C803,0050, ; Roach
                        D87F, 00DB,00B7, 0000, 2400,0000, F802,0050, ; Roach
                        D87F, 00D9,00B1, 0000, 2400,0000, EC02,0050, ; Roach
                        D87F, 00D7,00C1, 0000, 2400,0000, F403,0050, ; Roach
                        D87F, 00B3,01D3, 0000, 2400,0000, C402,0050, ; Roach
                        D87F, 00B9,01DB, 0000, 2400,0000, D003,0050, ; Roach
                        D87F, 00BB,01EA, 0000, 2400,0000, DC03,0050, ; Roach
                        D87F, 00AE,01DC, 0000, 2400,0000, BB02,0050, ; Roach
                        D87F, 00D5,01F0, 0000, 2400,0000, 0303,0080, ; Roach
                        EA7F, 0048,0088, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 00B8,0088, 0000, A000,0000, 0000,0001, ; Blue Brinstar face block
                        EA7F, 00E8,0116, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 00E8,0166, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        EA7F, 0018,0116, 0000, A000,0000, 0000,0000, ; Blue Brinstar face block
                        FFFF, 00

; Room $9E52. Brinstar diagonal room
$A1:9CB9             dw D93F, 0400,02A0, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        D93F, 0500,0300, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        D93F, 0687,03B6, 0000, 2000,0000, 0000,0000, ; Sidehopper
                        F253, 0170,0120, 0000, 6100,0000, 0001,0024, ; Geega
                        F253, 0230,01E0, 0000, 6100,0000, 0000,0024, ; Geega
                        F253, 0380,0220, 0000, 6100,0000, 0001,0024, ; Geega
                        F253, 0560,02E0, 0000, 6100,0000, 0001,0024, ; Geega
                        F253, 0500,0340, 0000, 6100,0000, 0000,0024, ; Geega
                        D93F, 06D0,0350, 0000, 2000,0000, 0001,0000, ; Sidehopper
                        D93F, 0718,0350, 0000, 2000,0000, 0001,0000, ; Sidehopper
                        FFFF, 0A

; Room $9CB3. Dachora room
$A1:9D5C             dw DC7F, 00E0,00B8, 0000, 2803,0000, 0002,0002, ; Zeela
                        DC7F, 0108,00B8, 0000, 2003,0000, 0002,0002, ; Zeela
                        D67F, 062D,006C, 0000, 2000,0000, 0000,0000, ; Metaree
                        D67F, 0658,004C, 0000, 2000,0000, 0000,0000, ; Metaree
                        D67F, 0673,004C, 0000, 2000,0000, 0000,0000, ; Metaree
                        D27F, 0130,0060, 0000, 2000,0000, 0000,0000, ; Rio
                        D27F, 01B0,0060, 0000, 2000,0000, 0000,0000, ; Rio
                        D27F, 02E8,0060, 0000, 2000,0000, 0000,0000, ; Rio
                        E5FF, 0060,06A8, 0000, 0C00,0000, 0001,0000, ; Dachora
                        E5FF, 0060,06A8, 0000, 0D00,0000, 8001,0000, ; Dachora
                        E5FF, 0060,06A8, 0000, 0D00,0000, 8001,0000, ; Dachora
                        E5FF, 0060,06A8, 0000, 0D00,0000, 8001,0000, ; Dachora
                        E5FF, 0060,06A8, 0000, 0D00,0000, 8001,0000, ; Dachora
                        FFFF, 08

; Room $A2F7. Red Brinstar damage boost hall
$A1:9E2F             dw DC7F, 00A0,0098, 0003, 2000,0000, 0002,0002, ; Zeela
                        DC7F, 0127,0088, 0003, 2001,0000, 0002,0002, ; Zeela
                        DC7F, 0170,0098, 0003, 2000,0000, 0002,0002, ; Zeela
                        DC7F, 01BF,0098, 0003, 2001,0000, 0002,0002, ; Zeela
                        F1D3, 01A0,00D8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0100,00D8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 01E0,00D8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0080,00D8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        FFFF, 08

; Room $A107. Blue Brinstar missile room
$A1:9EB2             dw FFFF, 00

; Room $A59F. Kraid
$A1:9EB5             dw E2BF, 0100,0218, 0000, 0D00,0004, 0000,0000, ; Kraid
                        E2FF, 00E8,01E8, 0000, 2800,0004, 0000,0001, ; Kraid arm
                        E33F, 00C8,0210, 0000, A800,0000, 0000,0000, ; Kraid top lint
                        E37F, 00B0,0250, 0000, A800,0000, 0000,0001, ; Kraid middle lint
                        E3BF, 00B2,0288, 0000, A800,0000, 0000,0002, ; Kraid bottom lint
                        E3FF, 0100,0278, 0000, 2C00,0004, 0000,0003, ; Kraid foot
                        E43F, 00E8,01E8, 0000, 6800,0000, 0000,0000, ; Kraid good fingernail
                        E47F, 00E8,01E8, 0000, 6800,0000, 0000,0000, ; Kraid bad fingernail
                        FFFF, 00

; Room $9C07. Brinstar reserve tank room
$A1:9F38             dw FFFF, 00

; Room $A2CE. X-ray room
$A1:9F3B             dw D53F, 0168,00A0, 0008, A800,FFFF, 4004,0000, ; Shootable shutter
                        D53F, 00B8,00E0, 0008, A800,FFFF, 4004,0000, ; Shootable shutter
                        FFFF, 00

; Room $A5ED. Pre Tourian entrance hall
$A1:9F5E             dw FFFF, 00

; Room $A3AE. Red Brinstar power bomb wall room
$A1:9F61             dw CEBF, 0258,00A8, 0000, 2000,0000, 0003,0020, ; Boyon
                        CEBF, 0268,00A8, 0000, 2000,0000, 0003,0020, ; Boyon
                        CEBF, 01F8,00A8, 0000, 2000,0000, 0003,0020, ; Boyon
                        CEBF, 0208,00A8, 0000, 2000,0000, 0003,0020, ; Boyon
                        FFFF, 00

; Room $A56B. Pre Kraid room
$A1:9FA4             dw F193, 0090,01C8, 0000, 6900,0000, 0000,0000, ; Zeb
                        D87F, 0136,019D, 0000, 2400,0000, C803,0030, ; Roach
                        D87F, 0137,01A4, 0000, 2400,0000, BA03,0030, ; Roach
                        D87F, 013D,01AB, 0000, 2400,0000, A802,0030, ; Roach
                        D87F, 0133,01AC, 0000, 2400,0000, B403,0030, ; Roach
                        D87F, 013B,019E, 0000, 2400,0000, CA02,0030, ; Roach
                        D87F, 0142,01A4, 0000, 2400,0000, C903,0030, ; Roach
                        D87F, 0145,01A7, 0000, 2400,0000, BE02,0030, ; Roach
                        D87F, 0143,01AF, 0000, 2400,0000, C203,0030, ; Roach
                        D87F, 0137,01B0, 0000, 2400,0000, 9003,0030, ; Roach
                        D87F, 014E,01AC, 0000, 2400,0000, C802,0020, ; Roach
                        FFFF, 01

; Room $A322. Red Brinstar -> Crateria elevator
$A1:A057             dw D73F, 0080,02C2, 0000, 2C00,0000, 0001,0018, ; Elevator
                        D7BF, 005F,0788, 0003, 2001,0000, 0000,0000, ; Zero
                        D7BF, 0017,06DE, 0000, 2002,0000, 0000,0000, ; Zero
                        D7BF, 0078,068F, 0001, 2002,0000, 0000,0000, ; Zero
                        CFFF, 0071,0473, 0000, 2000,0000, 0101,0300, ; Cacatac
                        CFFF, 00C0,0503, 0000, 2000,0000, 0100,0300, ; Cacatac
                        FFFF, 05

; Room $A521. Fake Kraid's room
$A1:A0BA             dw F693, 00D9,00A0, 0000, 2000,0004, 8000,0050, ; Green walking space pirate
                        F693, 0120,00A0, 0000, 2000,0004, 8000,0050, ; Green walking space pirate
                        F693, 01F4,00A0, 0000, 2000,0004, 8000,0050, ; Green walking space pirate
                        E0FF, 0530,00A0, 0000, 2800,0000, 0000,0000, ; Fake Kraid
                        FFFF, 04

; Room $9DC7. Spore Spawn
$A1:A0FD             dw DF3F, 0080,0270, 0000, 2800,0004, 0000,0000, ; Spore Spawn
                        FFFF, 00

; Room $A3DD. Red Brinstar skree-duo hall
$A1:A110             dw DB7F, 0148,003C, 0000, 2000,0000, 0000,0000, ; Skree
                        DB7F, 0170,003C, 0000, 2000,0000, 0000,0000, ; Skree
                        FFFF, 02

; Room $AB64. Double lake grapple practice room
$A1:A133             dw F213, 00D0,0168, 0000, 6800,0000, 0000,3030, ; Gamet
                        F213, 00D0,0168, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 00D0,0168, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 00D0,0168, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 00D0,0168, 0000, 6800,0000, 0000,3000, ; Gamet
                        CFBF, 01CD,014C, 0000, 2000,0000, 0000,0000, ; Puyo
                        CFBF, 01BA,0114, 0000, 2000,0000, 0000,0000, ; Puyo
                        CFBF, 0208,01A2, 0000, 2000,0000, 0000,0000, ; Puyo
                        CFBF, 023C,01A7, 0000, 2000,0000, 0000,0000, ; Puyo
                        CFBF, 0270,01A1, 0000, 2000,0000, 0000,0000, ; Puyo
                        FFFF, 06

; Room $AB07. Post Crocomire shaft
$A1:A1D6             dw DABF, 0077,0348, 0003, 2001,0000, 0002,0006, ; Viola
                        DABF, 0060,03A8, 0003, 2000,0000, 0002,0006, ; Viola
                        DABF, 0093,03F8, 0003, 2001,0000, 0002,0006, ; Viola
                        DABF, 007D,0478, 0003, 2000,0000, 0002,0006, ; Viola
                        FFFF, 04

; Room $B62B. Ninja space pirate hall
$A1:A219             dw F593, 00E8,00B0, 0000, 2800,0004, 0001,00C0, ; Gold ninja space pirate
                        F593, 0218,00B0, 0000, 2800,0004, 0000,00C0, ; Gold ninja space pirate
                        FFFF, 02

; Room $B1E5. Lower Norfair chozo room
$A1:A23C             dw F0FF, 002C,009A, 0000, 2000,0000, 0000,0002, ; Chozo statue
                        E83F, 01D8,02D8, 0000, 2800,0000, 0000,20F0, ; Magdollite
                        E83F, 01D8,02D8, 0000, 2C00,0000, 0001,0000, ; Magdollite
                        E83F, 01D8,02D8, 0000, 2C00,0000, 0002,0000, ; Magdollite
                        D33F, 0200,0268, 0000, 2000,0000, 0000,0000, ; Holtz
                        D33F, 0200,0268, 0006, 2400,0000, 8000,0000, ; Holtz
                        D33F, 01B0,0250, 0000, 2000,0000, 0000,0000, ; Holtz
                        D33F, 01B0,0250, 0006, 2400,0000, 8000,0000, ; Holtz
                        D33F, 0254,024D, 0000, 2000,0000, 0000,0000, ; Holtz
                        D33F, 0254,024D, 0006, 2400,0000, 8000,0000, ; Holtz
                        FFFF, 04

; Room $B051. Purple farming room
$A1:A2DF             dw F213, 0080,00B8, 0000, 6800,0000, 0000,3030, ; Gamet
                        F213, 0080,00B8, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 0080,00B8, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 0080,00B8, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 0080,00B8, 0000, 6800,0000, 0000,3000, ; Gamet
                        FFFF, 01

; Room $A815. Ice beam mockball hall
$A1:A332             dw D4FF, 0408,0258, 0001, A800,0000, 00F0,000D, ; Timed shutter
                        D4FF, 0608,0258, 0001, A800,0000, 0068,0010, ; Timed shutter
                        D97F, 0104,03AF, 0000, 2000,0000, 0000,0000, ; Desgeega
                        D97F, 0195,035F, 0000, 2000,0000, 0001,0000, ; Desgeega
                        D97F, 0222,03B2, 0000, 2000,0000, 0000,0000, ; Desgeega
                        D13F, 0139,0374, 0000, 2000,0000, 0000,0000, ; Mella
                        D13F, 0196,03A7, 0000, 2000,0000, 0000,0000, ; Mella
                        D13F, 01FC,0371, 0000, 2000,0000, 0000,0000, ; Mella
                        D13F, 0254,0379, 0000, 2000,0000, 0000,0000, ; Mella
                        D13F, 0281,039E, 0000, 2000,0000, 0000,0000, ; Mella
                        D13F, 00B0,0362, 0000, 2000,0000, 0000,0000, ; Mella
                        DCBF, 05C8,0238, 0003, 2800,0000, 0003,0004, ; Sova
                        FFFF, 04

; Room $AFFB. Norfair lava-spike hall
$A1:A3F5             dw E7BF, 0188,00D8, 0000, 2000,0000, 0080,0001, ; Yapping maw
                        E7BF, 0219,00D7, 0000, 2000,0000, 0080,0001, ; Yapping maw
                        E7BF, 02F8,00D8, 0000, 2000,0000, 0080,0001, ; Yapping maw
                        FFFF, 00

; Room $B585. Lower Norfair south kihunter shaft
$A1:A428             dw EBBF, 00B9,01D6, 0000, 2800,0000, 0050,0000, ; Red ki-hunter
                        EBFF, 00B9,01D6, 0000, 2C00,0000, 0020,0000, ; Red ki-hunter wings
                        EBBF, 004D,023A, 0000, 2800,0000, 0050,0000, ; Red ki-hunter
                        EBFF, 004D,023A, 0000, 2C00,0000, 0020,0000, ; Red ki-hunter wings
                        EBBF, 0087,02F2, 0000, 2800,0000, 0050,0000, ; Red ki-hunter
                        EBFF, 0087,02F2, 0000, 2C00,0000, 0020,0000, ; Red ki-hunter wings
                        FFFF, 03

; Room $B2DA. Ripper ii room
$A1:A48B             dw D43F, 01D8,0078, 0000, 2800,0000, 0040,0000, ; Ripper ii
                        D43F, 01D8,0058, 0000, 2800,0000, 0040,0000, ; Ripper ii
                        D43F, 0268,0068, 0000, 2800,0000, 0040,0000, ; Ripper ii
                        D43F, 0268,0088, 0000, 2800,0000, 0040,0000, ; Ripper ii
                        D43F, 0268,0048, 0000, 2800,0000, 0040,0000, ; Ripper ii
                        D43F, 0158,0098, 0000, 2800,0000, 0040,0000, ; Ripper ii
                        FFFF, 06

; Room $ADDE. Wave beam room
$A1:A4EE             dw FFFF, 00

; Room $B3A5. Pre pillars hall
$A1:A4F1             dw F413, 00D1,0138, 0000, 2000,0004, 0001,00A0, ; Gold wall space pirate
                        F413, 002D,00B8, 0000, 2000,0004, 0000,00A0, ; Gold wall space pirate
                        F713, 00B0,0180, 0000, 2000,0004, 8000,00A0, ; Gold walking space pirate
                        DABF, 0078,0237, 0002, 2000,0000, 0001,0006, ; Viola
                        DABF, 0088,0237, 0002, 2001,0000, 0001,0006, ; Viola
                        FFFF, 05

; Room $AF3F. Norfair -> Lower Norfair elevator
$A1:A544             dw D73F, 0080,00A0, 0000, 2C00,0000, 0000,0140, ; Elevator
                        FFFF, 00

; Room $B741. Lower Norfair save station
$A1:A557             dw FFFF, 00

; Room $B026. Norfair energy station
$A1:A55A             dw FFFF, 00

; Room $B0B4. Norfair map station
$A1:A55D             dw FFFF, 00

; Room $B40A. Lower Norfair multi-level one-way shaft
$A1:A560             dw DA3F, 03C0,038B, 0000, 2000,0000, 0000,0000, ; Super-desgeega
                        DA3F, 0357,038A, 0000, 2000,0000, 0000,0000, ; Super-desgeega
                        DA3F, 01B1,038B, 0000, 2000,0000, 0000,0000, ; Super-desgeega
                        DA3F, 0105,0380, 0000, 2000,0000, 8000,0000, ; Super-desgeega
                        DA3F, 026A,0381, 0000, 2000,0000, 8000,0000, ; Super-desgeega
                        D1BF, 0095,0377, 0000, 2000,0000, 000E,0006, ; Multiviola
                        D1BF, 0161,0390, 0000, 2000,0000, 00A8,0006, ; Multiviola
                        D1BF, 0396,0316, 0000, 2000,0000, 0000,0007, ; Multiviola
                        D1BF, 0349,02FB, 0000, 2000,0000, 0050,0007, ; Multiviola
                        D1BF, 0373,02A9, 0000, 2000,0000, 00C8,0006, ; Multiviola
                        D1BF, 0358,0238, 0000, 2000,0000, 00F0,0006, ; Multiviola
                        D1BF, 03CB,0214, 0000, 2000,0000, 0048,0005, ; Multiviola
                        FFFF, 05

; Room $B305. Lower Norfair energy station
$A1:A623             dw FFFF, 00

; Room $B32E. Ridley
$A1:A626             dw E17F, 0030,FFF0, 0000, 2800,0000, 0000,0000, ; Ridley
                        FFFF, 00

; Room $AADE. Post Crocomire power bombs room
$A1:A639             dw FFFF, 00

; Room $A890. Ice beam room
$A1:A63C             dw FFFF, 00

; Room $A9E5. Hi-jump room
$A1:A63F             dw FFFF, 00

; Room $AAB5. Post Crocomire save station
$A1:A642             dw FFFF, 00

; Room $B106. Norfair speed blockade hall
$A1:A645             dw E87F, 02B8,0098, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 02E8,0098, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0310,0098, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0390,0098, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0400,0098, 0000, 2000,0000, 0000,0000, ; Beetom
                        E87F, 0460,0098, 0000, 2000,0000, 0000,0000, ; Beetom
                        FFFF, 06

; Room $AFA3. Norfair long lavaquake hall
$A1:A6A8             dw D2BF, 00E8,00F0, 0000, 2000,0000, 0000,0000, ; Squeept
                        D2BF, 00E8,00F0, 0002, 2400,0000, 8000,0000, ; Squeept
                        DCBF, 01E8,0098, 0003, 2000,0000, 0001,0004, ; Sova
                        DCBF, 03E8,00A8, 0003, 2000,0000, 0002,0004, ; Sova
                        DCBF, 0178,00A0, 0003, 2001,0000, 0002,0004, ; Sova
                        DCBF, 02C8,00AB, 0001, 2002,0000, 0001,0004, ; Sova
                        DCBF, 0288,00A8, 0000, 2003,0000, 0001,0004, ; Sova
                        D4BF, 0238,00F0, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0238,00F0, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 0338,00F0, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0338,00F0, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 0468,00F0, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0468,00F0, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 03B8,00F0, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 03B8,00F0, 0002, 2400,0000, 0001,0000, ; Dragon
                        D2BF, 0168,00F0, 0000, 2000,0000, 0000,0000, ; Squeept
                        D2BF, 0168,00F0, 0002, 2400,0000, 8000,0000, ; Squeept
                        FFFF, 0B

; Room $AA82. Post Crocomire room
$A1:A7BB             dw F213, 0130,01C8, 0000, 6800,0000, 0000,3030, ; Gamet
                        F213, 0130,01C8, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 0130,01C8, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 0130,01C8, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 0130,01C8, 0000, 6800,0000, 0000,3000, ; Gamet
                        D3FF, 0100,0050, 0010, 2800,0000, 00E8,0130, ; Gripper
                        D83F, 0158,0148, 0000, A800,0000, 0000,2800, ; Suspensor platform
                        FFFF, 02

; Room $B4AD. Lower Norfair wall space pirates shaft
$A1:A82E             dw E73F, 00DA,0577, 0000, A000,0000, 1001,4007, ; Namihe
                        F413, 00D0,04F8, 0000, 2000,0004, 0001,00A0, ; Gold wall space pirate
                        F413, 0030,0490, 0000, 2000,0004, 0000,00A0, ; Gold wall space pirate
                        F413, 00D0,0440, 0000, 2000,0004, 0001,00A0, ; Gold wall space pirate
                        E73F, 0027,0320, 0000, A000,0000, 1011,4007, ; Namihe
                        F713, 0030,02B0, 0000, 2000,0004, 0000,0001, ; Gold walking space pirate
                        E73F, 00DA,0388, 0000, A000,0000, 1001,4007, ; Namihe
                        F713, 00D0,02E0, 0000, 2000,0004, 0000,0000, ; Gold walking space pirate
                        E73F, 00DA,0240, 0000, A000,0000, 1001,4007, ; Namihe
                        E73F, 0027,01E0, 0000, A000,0000, 1011,4007, ; Namihe
                        F713, 0080,0170, 0000, 2000,0004, 0000,0010, ; Gold walking space pirate
                        FFFF, 0B

; Room $ADAD. Pre wave beam room
$A1:A8E1             dw E6FF, 0030,00D0, 0000, A000,0000, 5010,F007, ; Fune
                        E6FF, 01C0,00D8, 0000, A000,0000, 5000,F007, ; Fune
                        D5FF, 0088,00A8, 0108, A800,0404, 4001,0020, ; Rising and falling platform
                        D5FF, 00D0,00E8, 0008, A800,0808, 3001,0030, ; Rising and falling platform
                        D5FF, 0110,00A8, 0108, A800,0202, 6001,0030, ; Rising and falling platform
                        D5FF, 0178,00A8, 0108, A800,0303, 5001,0030, ; Rising and falling platform
                        E7FF, 02F0,01D0, 0000, A000,0000, 000A,0000, ; Kago
                        D3FF, 02E8,00F0, 0010, 2000,0000, 0298,0338, ; Gripper
                        FFFF, 04

; Room $AC2B. Grapple room
$A1:A964             dw FFFF, 00

; Room $B139. Norfair stone zoomer shaft
$A1:A967             dw F6D3, 0050,0200, 0000, 2000,0004, 8001,0008, ; Red walking space pirate
                        F6D3, 00B0,0180, 0000, 2000,0004, 8000,0008, ; Red walking space pirate
                        F6D3, 0050,0100, 0000, 2000,0004, 8001,0008, ; Red walking space pirate
                        DD3F, 0080,0268, 0003, 2000,0000, 0002,0000, ; Stone zoomer
                        DD3F, 0080,01D8, 0003, 2001,0000, 0002,0000, ; Stone zoomer
                        DD3F, 0080,0158, 0003, 2000,0000, 0002,0000, ; Stone zoomer
                        DD3F, 0080,00D8, 0003, 2001,0000, 0002,0000, ; Stone zoomer
                        FFFF, 07

; Room $A923. Norfair slope
$A1:A9DA             dw F6D3, 08B8,0270, 0000, 2000,0004, 8000,0000, ; Red walking space pirate
                        D1BF, 0413,00CC, 0000, 2000,0000, 00F0,0003, ; Multiviola
                        F6D3, 02F4,00B0, 0000, 2000,0004, 8000,0030, ; Red walking space pirate
                        D1BF, 048D,0116, 0000, 2000,0000, 0030,0003, ; Multiviola
                        F6D3, 039A,00E0, 0000, 2000,0004, 8000,0020, ; Red walking space pirate
                        D1BF, 050C,0158, 0000, 2000,0000, 0068,0003, ; Multiviola
                        D1BF, 05AF,01C8, 0000, 2000,0000, 00D0,0003, ; Multiviola
                        F6D3, 09FB,0270, 0000, 2000,0004, 8000,0000, ; Red walking space pirate
                        F6D3, 06E7,0290, 0000, 2000,0004, 8000,0010, ; Red walking space pirate
                        CFFF, 0C58,01E3, 0000, 2000,0000, 0100,0000, ; Cacatac
                        CFFF, 0CA8,01E3, 0000, 2000,0000, 0100,0000, ; Cacatac
                        FFFF, 07

; Room $B482. Lower Norfair holtz room
$A1:AA8D             dw D33F, 0258,0058, 0000, 2000,0000, 0000,0000, ; Holtz
                        D33F, 0258,0058, 0006, 2400,0000, 8000,0000, ; Holtz
                        D33F, 0288,0058, 0000, 2000,0000, 0000,0000, ; Holtz
                        D33F, 0288,0058, 0006, 2400,0000, 8000,0000, ; Holtz
                        D33F, 0118,0058, 0000, 2000,0000, 0000,0000, ; Holtz
                        D33F, 0118,0058, 0006, 2400,0000, 8000,0000, ; Holtz
                        D33F, 01C8,0058, 0000, 2000,0000, 0000,0000, ; Holtz
                        D33F, 01C8,0058, 0006, 2400,0000, 8000,0000, ; Holtz
                        D33F, 0068,0058, 0000, 2000,0000, 0000,0000, ; Holtz
                        D33F, 0068,0058, 0006, 2400,0000, 8000,0000, ; Holtz
                        D33F, 0098,0058, 0000, 2000,0000, 0000,0000, ; Holtz
                        D33F, 0098,0058, 0006, 2400,0000, 8000,0000, ; Holtz
                        F1D3, 00C0,00B8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0180,00B8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0240,00B8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        FFFF, 09

; Room $B6EE. Norfair rolling boulder shaft
$A1:AB80             dw E6FF, 01F0,02D0, 0000, A000,0000, 0100,0F07, ; Fune
                        E6FF, 0110,01E8, 0000, A000,0000, 0110,0F07, ; Fune
                        E6FF, 01F0,01B0, 0000, A000,0000, 0100,0F07, ; Fune
                        E6FF, 01D0,00D8, 0000, A000,0000, 0100,0F07, ; Fune
                        E6FF, 01F0,0380, 0000, A000,0000, 0100,0F07, ; Fune
                        DFBF, 0150,0130, 0050, 2000,0000, 0000,0080, ; Boulder
                        DFBF, 01B8,01D0, 0050, 2800,0000, 0100,0080, ; Boulder
                        DFBF, 0128,0260, 0050, 2800,0000, 0000,0080, ; Boulder
                        D6BF, 0156,0558, 0000, 2000,0000, 0002,0520, ; Fireflea
                        D6BF, 01C8,0538, 0000, 2000,0000, 0003,0518, ; Fireflea
                        D6BF, 0238,0558, 0000, 2000,0000, 0002,0520, ; Fireflea
                        D6BF, 02A8,0538, 0000, 2000,0000, 0003,0518, ; Fireflea
                        D6BF, 0170,0476, 0000, 2000,0000, 0002,0720, ; Fireflea
                        FFFF, 0A

; Room $AEB4. Magdollite multiviola hall
$A1:AC53             dw E83F, 00F8,00B8, 0000, 2800,0000, 0000,3A60, ; Magdollite
                        E83F, 00F8,00B8, 0000, 2C00,0000, 0001,0000, ; Magdollite
                        E83F, 00F8,00B8, 0000, 2C00,0000, 0002,0000, ; Magdollite
                        E83F, 01E8,00B8, 0000, 2800,0000, 0000,3A60, ; Magdollite
                        E83F, 01E8,00B8, 0000, 2C00,0000, 0001,0000, ; Magdollite
                        E83F, 01E8,00B8, 0000, 2C00,0000, 0002,0000, ; Magdollite
                        E83F, 0248,00B8, 0000, 2800,0000, 0000,3A60, ; Magdollite
                        E83F, 0248,00B8, 0000, 2C00,0000, 0001,0000, ; Magdollite
                        E83F, 0248,00B8, 0000, 2C00,0000, 0002,0000, ; Magdollite
                        D1BF, 0078,0058, 0000, 2000,0000, 0060,0002, ; Multiviola
                        D1BF, 023C,005D, 0000, 2000,0000, 0030,0002, ; Multiviola
                        FFFF, 03

; Room $B3E1. Unused room
$A1:AD06             dw FFFF, 00

; Room $AF14. Lava dive room
$A1:AD09             dw E73F, 01F0,0108, 0000, A000,0000, 1001,8005, ; Namihe
                        E73F, 0120,01D0, 0000, A000,0000, 1011,8005, ; Namihe
                        E73F, 0120,0248, 0000, A000,0000, 1011,8005, ; Namihe
                        E73F, 027F,0238, 0000, A000,0000, 1001,8005, ; Namihe
                        E73F, 0390,0118, 0000, A000,0000, 1001,8005, ; Namihe
                        E73F, 0340,0198, 0000, A000,0000, 1001,8005, ; Namihe
                        FFFF, 06

; Room $B457. Pillars hall
$A1:AD6C             dw E0BF, 0190,00D0, 0000, 2000,0000, 4010,2001, ; Fire arc
                        E0BF, 02D0,00D0, 0000, 2000,0000, 4010,2001, ; Fire arc
                        FFFF, 00

; Room $AA0E. Norfair grapple ceiling room
$A1:AD8F             dw D4BF, 0380,01E8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0380,01E8, 0002, 2400,0000, 0001,0000, ; Dragon
                        D2FF, 0396,007F, 0000, 2000,0000, 0000,0000, ; Geruta
                        D2FF, 0396,007F, 0005, 2400,0000, 8000,0000, ; Geruta
                        D4BF, 02C0,01E8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 02C0,01E8, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 0200,01E8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0200,01E8, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 0140,01E8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0140,01E8, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 0080,01E8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0080,01E8, 0002, 2400,0000, 0001,0000, ; Dragon
                        FFFF, 06

; Room $B510. Lower Norfair spring ball maze room
$A1:AE52             dw E9BF, 0100,0200, 0000, 2800,0000, 0000,0000, ; Alcoon
                        E9BF, 0151,0200, 0000, 2800,0000, 0000,0000, ; Alcoon
                        E9BF, 0060,0200, 0000, 2800,0000, 0000,0000, ; Alcoon
                        E9BF, 0198,00D8, 0000, 2800,0000, 0000,0000, ; Alcoon
                        E9BF, 03FB,04C9, 0000, 2800,0000, 0000,0000, ; Alcoon
                        FFFF, 05

; Room $B55A. Lower Norfair escape power bomb room
$A1:AEA5             dw FFFF, 00

; Room $AEDF. Purple shaft
$A1:AEA8             dw FFFF, 00

; Room $B698. Ridley's energy tank
$A1:AEAB             dw FFFF, 00

; Room $B6C1. Screw attack room
$A1:AEAE             dw FFFF, 00

; Room $AC83. Pre Bubble Norfair reserve tank room
$A1:AEB1             dw D53F, 0128,0100, 0008, A800,FFFF, 4003,0000, ; Shootable shutter
                        D53F, 0128,0100, 0008, A800,FFFF, 8003,0000, ; Shootable shutter
                        D2FF, 0184,0060, 0000, 2000,0000, 0000,0000, ; Geruta
                        D2FF, 0184,0060, 0005, 2400,0000, 8000,0000, ; Geruta
                        FFFF, 01

; Room $B4E5. Lower Norfair rising acid room
$A1:AEF4             dw F713, 01C0,00D0, 0000, 2000,0004, 8000,0010, ; Gold walking space pirate
                        F713, 02C0,00B0, 0000, 2000,0004, 8000,0008, ; Gold walking space pirate
                        F713, 02B8,0230, 0000, 2000,0004, 8000,0008, ; Gold walking space pirate
                        F713, 0158,0120, 0000, 2000,0004, 8001,0008, ; Gold walking space pirate
                        F713, 01D0,0440, 0000, 2000,0004, 8000,0010, ; Gold walking space pirate
                        F713, 00C5,0450, 0000, 2000,0004, 8000,00A0, ; Gold walking space pirate
                        F713, 037D,039D, 0000, 2000,0004, 8000,0010, ; Gold walking space pirate
                        F713, 03C0,0310, 0000, 2000,0004, 8000,0010, ; Gold walking space pirate
                        F713, 0238,01A0, 0000, 2000,0004, 8000,0008, ; Gold walking space pirate
                        FFFF, 09

; Room $A7B3. First hot room
$A1:AF87             dw DCBF, 0028,0100, 0000, 2000,0000, 0003,0004, ; Sova
                        DCBF, 0018,0138, 0000, 2800,0000, 0003,0004, ; Sova
                        DCBF, 00F8,0098, 0003, 2001,0000, 0003,0004, ; Sova
                        DCBF, 00B0,00D8, 0003, 2000,0000, 0003,0004, ; Sova
                        D97F, 0188,019F, 0000, 2000,0000, 0000,0000, ; Desgeega
                        D97F, 022F,019E, 0000, 2000,0000, 0000,0000, ; Desgeega
                        FFFF, 06

; Room $B236. Lower Norfair mainstreet
$A1:AFEA             dw D73F, 0480,02A2, 0000, 2C00,0000, 0001,0018, ; Elevator
                        D4BF, 02D0,02F8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 02D0,02F8, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 0330,02F8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0330,02F8, 0002, 2400,0000, 0001,0000, ; Dragon
                        E07F, 0197,02B8, 0000, 2500,0000, 0050,0000, ; Fire pillar
                        E07F, 0197,02B8, 0000, 2100,0000, 0000,0001, ; Fire pillar
                        E07F, 0117,02A8, 0000, 2500,0000, 0060,0000, ; Fire pillar
                        E07F, 0117,02A8, 0000, 2100,0000, 0000,0001, ; Fire pillar
                        E07F, 0097,0288, 0000, 2500,0000, 0060,0000, ; Fire pillar
                        E07F, 0097,0288, 0000, 2100,0000, 0000,0001, ; Fire pillar
                        E07F, 0217,02B8, 0000, 2500,0000, 0050,0000, ; Fire pillar
                        E07F, 0217,02B8, 0000, 2100,0000, 0000,0001, ; Fire pillar
                        D4BF, 0238,02F8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0238,02F8, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 0138,02F8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0138,02F8, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 01B8,02F8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 01B8,02F8, 0002, 2400,0000, 0001,0000, ; Dragon
                        FFFF, 05

; Room $AB8F. Huge jump room
$A1:B11D             dw D13F, 05C3,0253, 0000, 2000,0000, 0000,0000, ; Mella
                        D13F, 0599,0268, 0000, 2000,0000, 0000,0000, ; Mella
                        D13F, 05F1,0272, 0000, 2000,0000, 0000,0000, ; Mella
                        D13F, 0552,025C, 0000, 2000,0000, 0000,0000, ; Mella
                        D13F, 057B,027D, 0000, 2000,0000, 0000,0000, ; Mella
                        D3FF, 00D1,009B, 0010, 2000,0000, 00B1,0111, ; Gripper
                        D3FF, 0198,0068, 0120, 2800,0000, 0168,01C8, ; Gripper
                        D3FF, 0228,0098, 0020, 2800,0000, 0210,0268, ; Gripper
                        D3FF, 0360,0058, 0110, 2800,0000, 0300,03C0, ; Gripper
                        D83F, 00B0,0298, 0000, A000,0000, 0000,2800, ; Suspensor platform
                        D83F, 0110,0298, 0000, A000,0000, 0000,2800, ; Suspensor platform
                        D83F, 0170,0298, 0000, A000,0000, 0000,2800, ; Suspensor platform
                        D83F, 01D0,0298, 0000, A000,0000, 0000,2800, ; Suspensor platform
                        FFFF, 04

; Room $B167. Rock Norfair save station
$A1:B1F0             dw FFFF, 00

; Room $B192. Pre Crocomire save station
$A1:B1F3             dw FFFF, 00

; Room $A8F8. Crumble block platform shaft
$A1:B1F6             dw DCBF, 0078,0106, 0002, 2001,0000, 0001,0004, ; Sova
                        DCBF, 0038,0138, 0003, 2000,0000, 0001,0004, ; Sova
                        DCBF, 00C0,01D8, 0003, 2000,0000, 0001,0004, ; Sova
                        DCBF, 0080,0256, 0002, 2000,0000, 0001,0004, ; Sova
                        DCBF, 0080,02F6, 0002, 2000,0000, 0001,0004, ; Sova
                        DCBF, 00C0,0346, 0002, 2001,0000, 0001,0004, ; Sova
                        FFFF, 06

; Room $B5D5. Lower Norfair spike platform room
$A1:B259             dw E07F, 05C0,00E0, 0000, 2500,0000, 0008,0000, ; Fire pillar
                        E07F, 05C0,00E0, 0000, 2100,0000, 0000,0001, ; Fire pillar
                        DA3F, 0288,005A, 0000, 2000,0000, 8000,0000, ; Super-desgeega
                        DA3F, 0228,00A8, 0000, 2000,0000, 0000,0000, ; Super-desgeega
                        DA3F, 02F0,00A8, 0000, 2000,0000, 0000,0000, ; Super-desgeega
                        DA3F, 0138,0058, 0000, 2000,0000, 8000,0000, ; Super-desgeega
                        E07F, 0540,00E0, 0000, 2500,0000, 0000,0000, ; Fire pillar
                        E07F, 0540,00E0, 0000, 2100,0000, 0000,0001, ; Fire pillar
                        D53F, 0528,00E0, 0008, A800,00FF, 2003,0000, ; Shootable shutter
                        DFFF, 0180,025C, 0000, A000,0000, 0040,5070, ; Spike platform top
                        E03F, 0180,0264, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 0180,015C, 0000, A000,0000, 0040,8070, ; Spike platform top
                        E03F, 0180,0164, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        FFFF, 04

; Room $AFCE. Norfair metal floor hall
$A1:B32C             dw F213, 0110,00E8, 0000, 6800,0000, 0000,3030, ; Gamet
                        F213, 0110,00E8, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 0110,00E8, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 0110,00E8, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 0110,00E8, 0000, 6800,0000, 0000,3000, ; Gamet
                        D4BF, 0200,00F0, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0200,00F0, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 02F0,00F0, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 02F0,00F0, 0002, 2400,0000, 0001,0000, ; Dragon
                        FFFF, 03

; Room $AC00. Single lake grapple practice room
$A1:B3BF             dw FFFF, 00

; Room $B0DD. Bubble Norfair save station
$A1:B3C2             dw FFFF, 00

; Room $AA41. Pre hi-jump room
$A1:B3C5             dw DCBF, 0177,00B5, 0002, 2801,0000, 0004,0004, ; Sova
                        FFFF, 01

; Room $ACB3. Bubble Norfair mainstreet
$A1:B3D8             dw D43F, 0178,0370, 0000, 2800,0000, 0020,0000, ; Ripper ii
                        DCBF, 0118,0380, 0001, 2002,0000, 0002,0004, ; Sova
                        DCBF, 0151,02DA, 0003, 2000,0000, 0002,0004, ; Sova
                        DCBF, 0048,0329, 0003, 2000,0000, 0002,0004, ; Sova
                        D63F, 00B9,01B8, 0000, 2800,0000, 0000,0000, ; Waver
                        D63F, 01C0,0220, 0000, 2000,0000, 0001,0000, ; Waver
                        D63F, 0093,00DE, 0000, 2800,0000, 0000,0000, ; Waver
                        CFFF, 010C,0095, 0000, 2000,0000, 0100,0000, ; Cacatac
                        FFFF, 08

; Room $A75D. Ice beam tripper hall
$A1:B45B             dw D7FF, 0190,00A8, 0000, A000,0000, 0000,1010, ; Tripper
                        D7FF, 0100,00A8, 0000, A000,0000, 0000,1010, ; Tripper
                        D7FF, 0070,00A8, 0000, A000,0000, 0000,1010, ; Tripper
                        FFFF, 03

; Room $A865. Ice beam practice room
$A1:B48E             dw CEBF, 0078,00D9, 0000, 2000,0000, 0103,0040, ; Boyon
                        CEBF, 00A8,00D9, 0000, 2000,0000, 0103,0040, ; Boyon
                        CEBF, 00D8,00D9, 0000, 2000,0000, 0203,0040, ; Boyon
                        D43F, 0158,00A8, 0000, 2800,0000, 0018,0000, ; Ripper ii
                        FFFF, 01

; Room $AB3B. Post Crocomire tidal acid cave
$A1:B4D1             dw D67F, 0118,0038, 0000, 2000,0000, 0000,0000, ; Metaree
                        D67F, 00F8,0040, 0000, 2000,0000, 0000,0000, ; Metaree
                        F213, 02B0,00E0, 0000, 6800,0000, 0000,3030, ; Gamet
                        F213, 02B0,00E0, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 02B0,00E0, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 02B0,00E0, 0000, 6800,0000, 0000,3000, ; Gamet
                        F213, 02B0,00E0, 0000, 6800,0000, 0000,3000, ; Gamet
                        FFFF, 03

; Room $A788. Lava missile room
$A1:B544             dw D2FF, 00A1,0053, 0000, 2000,0000, 0000,0000, ; Geruta
                        D2FF, 00A1,0053, 0005, 2400,0000, 8000,0000, ; Geruta
                        D2FF, 01DE,0141, 0000, 2000,0000, 0000,0000, ; Geruta
                        D2FF, 01DE,0141, 0005, 2400,0000, 8000,0000, ; Geruta
                        D2FF, 0224,007D, 0000, 2000,0000, 0000,0000, ; Geruta
                        D2FF, 0224,007D, 0005, 2400,0000, 8000,0000, ; Geruta
                        DCBF, 0140,00E5, 0003, 2000,0000, 0002,0004, ; Sova
                        DCBF, 006E,0116, 0003, 2000,0000, 0002,0004, ; Sova
                        DCBF, 00D8,00B8, 0000, 2002,0000, 0002,0004, ; Sova
                        DCBF, 029C,00F4, 0003, 2001,0000, 0002,0004, ; Sova
                        FFFF, 07

; Room $AC5A. Bubble Norfair reserve tank room
$A1:B5E7             dw D4BF, 0158,00F8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0158,00F8, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 00D8,00F8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 00D8,00F8, 0002, 2400,0000, 0001,0000, ; Dragon
                        D4BF, 0098,00F8, 0000, 2000,0000, 0000,0000, ; Dragon
                        D4BF, 0098,00F8, 0002, 2400,0000, 0001,0000, ; Dragon
                        DCBF, 0078,0045, 0002, 2001,0000, 0006,0004, ; Sova
                        DCBF, 00F8,0050, 0002, 2001,0000, 0006,0004, ; Sova
                        DCBF, 0187,003A, 0002, 2001,0000, 0006,0004, ; Sova
                        FFFF, 06

; Room $ABD2. Grapple practice shaft
$A1:B67A             dw E6FF, 00F0,0290, 0000, A000,0000, 2000,A007, ; Fune
                        E6FF, 0010,01B0, 0000, A000,0000, 2010,A007, ; Fune
                        E6FF, 00F0,0210, 0000, A000,0000, 2000,A007, ; Fune
                        FFFF, 03

; Room $A8B9. Pre ice beam shaft
$A1:B6AD             dw DCBF, 0158,01B8, 0003, 2800,0000, 0001,0004, ; Sova
                        DCBF, 0198,01B8, 0003, 2800,0000, 0001,0004, ; Sova
                        DCBF, 0178,01B8, 0003, 2800,0000, 0001,0004, ; Sova
                        E6FF, 00B0,01C4, 0000, A000,0000, 5000,5007, ; Fune
                        E6FF, 0020,0100, 0000, A000,0000, 5010,5007, ; Fune
                        E6FF, 00B0,0144, 0000, A000,0000, 5000,5007, ; Fune
                        E6FF, 0020,0290, 0000, A000,0000, 5010,5007, ; Fune
                        FFFF, 07

; Room $B283. Golden Torizo
$A1:B720             dw EF7F, 0080,0180, 0000, 2000,0000, 0000,0000, ; Golden Torizo
                        FFFF, 00

; Room $AE07. Norfair sinking tripper hall
$A1:B733             dw D7FF, 0280,00A8, 0000, A800,0000, 0001,0018, ; Tripper
                        D7FF, 0180,00A8, 0000, A800,0000, 0000,0718, ; Tripper
                        D53F, 0200,0008, 0110, A800,0303, 4002,0030, ; Shootable shutter
                        FFFF, 02

; Room $AD1B. Speed booster room
$A1:B766             dw FFFF, 00

; Room $B37A. Pre Ridley hall
$A1:B769             dw DABF, 0228,0088, 0003, 2001,0000, 0002,0006, ; Viola
                        DABF, 0238,00D8, 0002, 2001,0000, 0002,0006, ; Viola
                        DABF, 0168,0088, 0003, 2000,0000, 0002,0006, ; Viola
                        DABF, 0168,00D8, 0002, 2000,0000, 0002,0006, ; Viola
                        DABF, 00D8,0098, 0003, 2001,0000, 0002,0006, ; Viola
                        F1D3, 0298,00F0, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0258,00F0, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0208,00F0, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 01C8,00F0, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0148,00F0, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 00F8,00F0, 0000, 6900,0000, 0002,0000, ; Zebbo
                        FFFF, 0B

; Room $AD5E. Alcoon shaft
$A1:B81C             dw D1BF, 003C,0356, 0000, 2800,0000, 00D0,0002, ; Multiviola
                        D1BF, 0099,01E3, 0000, 2000,0000, 0058,0002, ; Multiviola
                        D1BF, 00CF,00D2, 0000, 2800,0000, 0088,0002, ; Multiviola
                        E9BF, 0080,0338, 0000, 2800,0000, 0000,0000, ; Alcoon
                        E9BF, 0080,0238, 0000, 2800,0000, 0000,0000, ; Alcoon
                        E9BF, 00D8,0138, 0000, 2800,0000, 0000,0000, ; Alcoon
                        E9BF, 0088,0138, 0000, 2800,0000, 0000,0000, ; Alcoon
                        FFFF, 04

; Room $ACF0. Speed booster lavaquake
$A1:B88F             dw D2FF, 0388,0128, 0000, 2000,0000, 0000,0000, ; Geruta
                        D2FF, 0388,0128, 0005, 2400,0000, 8000,0000, ; Geruta
                        D2FF, 0488,0128, 0000, 2000,0000, 0000,0000, ; Geruta
                        D2FF, 0488,0128, 0005, 2400,0000, 8000,0000, ; Geruta
                        D2FF, 062C,0188, 0000, 2000,0000, 0000,0000, ; Geruta
                        D2FF, 062C,0188, 0005, 2400,0000, 8000,0000, ; Geruta
                        D67F, 0120,0064, 0000, 2000,0000, 0000,0000, ; Metaree
                        D67F, 00F0,0056, 0000, 2000,0000, 0000,0000, ; Metaree
                        FFFF, 05

; Room $B07A. Speed booster lavaquake room
$A1:B912             dw F213, 0060,00B0, 0000, 6800,0000, 0000,2020, ; Gamet
                        F213, 0060,00B0, 0000, 6800,0000, 0000,2000, ; Gamet
                        F213, 0060,00B0, 0000, 6800,0000, 0000,2000, ; Gamet
                        F213, 0060,00B0, 0000, 6800,0000, 0000,2000, ; Gamet
                        F213, 0060,00B0, 0000, 6800,0000, 0000,2000, ; Gamet
                        DB7F, 00C8,0148, 0000, 2000,0000, 0000,0000, ; Skree
                        DB7F, 00A8,0140, 0000, 2000,0000, 0000,0000, ; Skree
                        DB7F, 0080,0138, 0000, 2000,0000, 0000,0000, ; Skree
                        FFFF, 04

; Room $AE74. Pre lava dive shaft
$A1:B995             dw DABF, 0188,00A8, 0003, 2000,0000, 0002,0006, ; Viola
                        DABF, 0160,01C8, 0003, 2000,0000, 0002,0006, ; Viola
                        DABF, 01A0,0208, 0003, 2001,0000, 0002,0006, ; Viola
                        DABF, 0180,0258, 0003, 2000,0000, 0002,0006, ; Viola
                        FFFF, 04

; Room $A7DE. Norfair mainstreet
$A1:B9D8             dw D73F, 0080,02C2, 0000, 2C00,0000, 0001,0018, ; Elevator
                        DCBF, 007B,0358, 0003, 2001,0000, 0001,0004, ; Sova
                        DCBF, 0090,03E8, 0003, 2000,0000, 0001,0004, ; Sova
                        DCBF, 0061,0438, 0003, 2001,0000, 0001,0004, ; Sova
                        DCBF, 00A0,0518, 0003, 2000,0000, 0001,0004, ; Sova
                        DCBF, 0060,0548, 0000, 2000,0000, 0000,0004, ; Sova
                        DCBF, 0081,05E8, 0003, 2000,0000, 0001,0004, ; Sova
                        FFFF, 06

; Room $B656. Lower Norfair north kihunter shaft
$A1:BA4B             dw E07F, 0297,0280, 0000, 2500,0000, 0030,0000, ; Fire pillar
                        E07F, 0297,0280, 0000, 2100,0000, 0000,0001, ; Fire pillar
                        E07F, 0337,0280, 0000, 2500,0000, 0030,0000, ; Fire pillar
                        E07F, 0337,0280, 0000, 2100,0000, 0000,0001, ; Fire pillar
                        EBBF, 0155,01F2, 0000, 2800,0000, 0384,0000, ; Red ki-hunter
                        EBFF, 0155,01F2, 0000, 2C00,0000, 0020,0000, ; Red ki-hunter wings
                        EBBF, 0165,0174, 0000, 2800,0000, 0384,0000, ; Red ki-hunter
                        EBFF, 0165,0174, 0000, 2C00,0000, 0020,0000, ; Red ki-hunter wings
                        EBBF, 014A,0108, 0000, 2800,0000, 0384,0000, ; Red ki-hunter
                        EBFF, 014A,0108, 0000, 2C00,0000, 0020,0000, ; Red ki-hunter wings
                        D53F, 02E8,025A, 0108, A800,FF00, 4003,0000, ; Shootable shutter
                        D53F, 0388,023A, 0108, A800,FF00, 4003,0000, ; Shootable shutter
                        FFFF, 03

; Room $A98D. Crocomire
$A1:BB0E             dw DDBF, 0480,0078, BD2A, A800,0004, 0000,0000, ; Crocomire
                        DDFF, 0480,0078, BD2A, A800,0004, 0000,0000, ; Crocomire tongue
                        FFFF, 00

; Room $B1BB. Pre Lower Norfair save station
$A1:BB31             dw FFFF, 00

; Room $AE32. Volcano room
$A1:BB34             dw E6FF, 01D0,0280, 0000, A000,0000, 8000,8005, ; Fune
                        E6FF, 02E0,0210, 0000, A000,0000, 8000,0007, ; Fune
                        E6FF, 0220,01C8, 0000, A000,0000, 8010,0007, ; Fune
                        E6FF, 02E0,0178, 0000, A000,0000, 8000,0007, ; Fune
                        E6FF, 0220,0128, 0000, A000,0000, 8010,0007, ; Fune
                        E6FF, 02E0,00D8, 0000, A000,0000, 8000,0007, ; Fune
                        D1FF, 00F8,02C8, 0000, 2500,0000, 0000,0000, ; Polyp
                        D1FF, 0080,02C8, 0000, 2500,0000, 0000,0000, ; Polyp
                        D1FF, 0088,02C8, 0000, 2500,0000, 0000,0000, ; Polyp
                        D1FF, 0108,02C8, 0000, 2500,0000, 0000,0000, ; Polyp
                        FFFF, 0A

; Room $AF72. Norfair wave gate room
$A1:BBD7             dw E6FF, 01F0,0190, 0000, A000,0000, 2000,2007, ; Fune
                        F213, 0130,01C0, 0000, 6800,0000, 0000,4050, ; Gamet
                        F213, 0130,01C0, 0000, 6800,0000, 0000,4000, ; Gamet
                        F213, 0130,01C0, 0000, 6800,0000, 0000,4000, ; Gamet
                        F213, 0130,01C0, 0000, 6800,0000, 0000,4000, ; Gamet
                        F213, 0130,01C0, 0000, 6800,0000, 0000,4000, ; Gamet
                        FFFF, 02

; Room $CD5C, state $CD88. Wrecked Ship first flooded room - main area boss is dead
$A1:BC3A             dw E97F, 00F0,0088, 0000, 2800,0000, 0003,0003, ; Bull
                        FFFF, 01

; Room $CC27, state $CC53. Wrecked Ship chozo energy tank room - main area boss is dead
$A1:BC4D             dw D6FF, 00AD,0176, 0000, 2000,0000, 0010,0210, ; Skultera
                        D6FF, 0240,012C, 0000, 2000,0000, 0110,0210, ; Skultera
                        D83F, 0118,00A8, 0000, A800,0000, 0000,2000, ; Suspensor platform
                        D83F, 0180,00A8, 0000, A800,0000, 0000,2000, ; Suspensor platform
                        D83F, 01F0,00A8, 0000, A800,0000, 0000,2000, ; Suspensor platform
                        FFFF, 02

; Room $CAF6, state $CB08. Wrecked Ship mainstreet - default
$A1:BCA0             dw E77F, 0038,03D8, 0000, 6800,0000, 0000,0000, ; Coven
                        D87F, 0442,034A, 0000, 2400,0000, 7002,0050, ; Roach
                        D87F, 044D,0351, 0000, 2400,0000, 7C02,0050, ; Roach
                        D87F, 04C8,03CC, 0000, 2400,0000, CC03,0050, ; Roach
                        D87F, 04C5,03D3, 0000, 2400,0000, D804,0080, ; Roach
                        D87F, 04CE,03D9, 0000, 2400,0000, D003,00A0, ; Roach
                        D87F, 04CB,04CB, 0000, 2400,0000, 2003,00A0, ; Roach
                        D87F, 04CC,04D6, 0000, 2400,0000, FF02,00A0, ; Roach
                        D87F, 04C4,04D1, 0000, 2400,0000, 0A03,0050, ; Roach
                        D87F, 04DE,04BE, 0000, 2400,0000, D003,0050, ; Roach
                        D87F, 03A7,0521, 0000, 2400,0000, 7A02,0050, ; Roach
                        D87F, 03B9,052C, 0000, 2400,0000, 7E02,0050, ; Roach
                        D87F, 04C4,027D, 0000, 2400,0000, FC02,0050, ; Roach
                        D87F, 04CA,028A, 0000, 2400,0000, 0803,0080, ; Roach
                        D87F, 04DB,0278, 0000, 2400,0000, E003,0080, ; Roach
                        D87F, 0425,0210, 0000, 2400,0000, 8402,0080, ; Roach
                        D87F, 0424,0206, 0000, 2400,0000, 7802,0040, ; Roach
                        D87F, 0145,02BA, 0000, 2400,0000, 9103,0040, ; Roach
                        D87F, 013D,02C3, 0000, 2400,0000, 8C02,0040, ; Roach
                        D87F, 010D,02DB, 0000, 2400,0000, AC03,0080, ; Roach
                        D87F, 01AD,04E8, 0000, 2400,0000, E804,0020, ; Roach
                        DFFF, 0260,0558, 0000, A000,0000, 0000,0000, ; Spike platform top
                        E03F, 0260,0560, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 01C0,0558, 0000, A000,0000, 0000,0000, ; Spike platform top
                        E03F, 01C0,0560, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 0120,0558, 0000, A000,0000, 0000,0000, ; Spike platform top
                        E03F, 0120,0560, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 0080,0558, 0000, A000,0000, 0000,0000, ; Spike platform top
                        E03F, 0080,0560, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        E9FF, 0430,07D0, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 04D0,07D0, 0000, 2000,0000, 0000,0000, ; Atomic
                        FFFF, 03

; Room $C98E, state $C9A0. Wrecked Ship chozo room - default
$A1:BE93             dw F0FF, 04C8,018A, 0000, 2000,0000, 0000,0000, ; Chozo statue
                        D87F, 04CB,0189, 0000, 2400,0000, C203,0080, ; Roach
                        D87F, 04CC,017C, 0000, 2400,0000, DC04,0080, ; Roach
                        D87F, 04C5,0184, 0000, 2400,0000, DE03,0080, ; Roach
                        D87F, 04D1,0191, 0000, 2400,0000, C402,0080, ; Roach
                        D87F, 04CC,019D, 0000, 2400,0000, D803,0080, ; Roach
                        D87F, 0026,01D2, 0000, 2400,0000, 8802,0080, ; Roach
                        D87F, 009D,01EA, 0000, 2400,0000, 8C03,0080, ; Roach
                        D87F, 00CE,01D2, 0000, 2400,0000, 9802,0080, ; Roach
                        D87F, 00D3,01CF, 0000, 2400,0000, 9004,0080, ; Roach
                        D87F, 0025,01B0, 0000, 2400,0000, 8802,0080, ; Roach
                        D87F, 002D,01B9, 0000, 2400,0000, 9802,0080, ; Roach
                        D87F, 0030,01BF, 0000, 2400,0000, 9202,0080, ; Roach
                        D87F, 01E2,01DA, 0000, 2400,0000, B802,0080, ; Roach
                        D87F, 01DD,01E3, 0000, 2400,0000, 8803,0080, ; Roach
                        D87F, 01F8,01E3, 0000, 2400,0000, E003,0080, ; Roach
                        D87F, 0275,01E1, 0000, 2400,0000, D003,0080, ; Roach
                        D87F, 035D,01D2, 0000, 2400,0000, C802,0080, ; Roach
                        D87F, 0332,01E7, 0000, 2400,0000, D002,0080, ; Roach
                        D87F, 035F,01D9, 0000, 2400,0000, C804,0080, ; Roach
                        D87F, 0324,01E2, 0000, 2400,0000, C402,0080, ; Roach
                        FFFF, 00

; Room $CA52, state $CA7E. Wrecked Ship attic - main area boss is dead
$A1:BFE6             dw EB3F, 0419,00C8, 0000, 2800,0000, FFFF,0000, ; Yellow ki-hunter
                        EB7F, 0419,00C8, 0000, 2C00,0000, 0020,0000, ; Yellow ki-hunter wings
                        EB3F, 01FF,008E, 0000, 2800,0000, 0000,0000, ; Yellow ki-hunter
                        EB7F, 01FF,008E, 0000, 2C00,0000, 0020,0000, ; Yellow ki-hunter wings
                        EB3F, 05D5,0076, 0000, 2800,0000, 0000,0000, ; Yellow ki-hunter
                        EB7F, 05D5,0076, 0000, 2C00,0000, 0020,0000, ; Yellow ki-hunter wings
                        E9FF, 058F,005A, 0000, 2000,0000, 0001,0008, ; Atomic
                        E9FF, 0352,0061, 0000, 2000,0000, 0001,0008, ; Atomic
                        E9FF, 022C,0060, 0000, 2000,0000, 0001,0008, ; Atomic
                        E9FF, 0093,007C, 0000, 2000,0000, 0000,0008, ; Atomic
                        EB3F, 04E8,00C8, 0000, 2800,0000, FFFF,0000, ; Yellow ki-hunter
                        EB7F, 04E8,00C8, 0000, 2C00,0000, 0020,0000, ; Yellow ki-hunter wings
                        EA3F, 00E0,0058, 0000, 2000,0000, 0002,0090, ; Wrecked Ship spark
                        EA3F, 0130,00B8, 0000, 2000,0000, 0001,0050, ; Wrecked Ship spark
                        EA3F, 0290,00B8, 0000, 2000,0000, 0001,0020, ; Wrecked Ship spark
                        EA3F, 02F0,0068, 0000, 2000,0000, 0002,0080, ; Wrecked Ship spark
                        EA3F, 0370,00D8, 0000, 2000,0000, 0001,0030, ; Wrecked Ship spark
                        EA3F, 0430,0088, 0000, 2000,0000, 0002,0080, ; Wrecked Ship spark
                        EA3F, 04D0,0088, 0000, 2000,0000, 0002,0070, ; Wrecked Ship spark
                        EA3F, 05D0,00B8, 0000, 2000,0000, 0001,0010, ; Wrecked Ship spark
                        EA3F, 0630,0078, 0000, 2000,0000, 0002,0060, ; Wrecked Ship spark
                        FFFF, 08

; Room $CC6F, state $CC9B. Pre Phantoon hall - main area boss is dead
$A1:C139             dw E8FF, 004D,00B0, 0000, 2800,0000, 0000,0000, ; Work robot
                        E8FF, 0370,00B0, 0000, 2800,0000, 0000,0000, ; Work robot
                        E9FF, 0098,004D, 0000, 2000,0000, 0000,0008, ; Atomic
                        E9FF, 027E,00A8, 0000, 2000,0000, 0002,0008, ; Atomic
                        E9FF, 0354,0049, 0000, 2000,0000, 0002,0008, ; Atomic
                        EA3F, 0479,006A, 0000, 2000,0000, 0001,0020, ; Wrecked Ship spark
                        FFFF, 05

; Room $CCCB, state $CCF7. Wrecked Ship map station - main area boss is dead
$A1:C19C             dw FFFF, 00

; Room $CDA8, state $CDBA. Wrecked Ship west super missile room - default
$A1:C19F             dw FFFF, 00

; Room $CB8B, state $CB9D. Wrecked Ship spike platform hall - default
$A1:C1A2             dw FFFF, 00

; Room $CD5C, state $CD6E. Wrecked Ship first flooded room - default
$A1:C1A5             dw FFFF, 00

; Room $CA08, state $CA34. Wrecked Ship entrance treadmill - main area boss is dead
$A1:C1A8             dw FFFF, 00

; Room $CBD5, state $CBE7. Wrecked Ship east exit - default
$A1:C1AB             dw FFFF, 00

; Room $C98E, state $C9BA. Wrecked Ship chozo room - main area boss is dead
$A1:C1AE             dw F0FF, 04C8,018A, 0000, 2000,0000, 0000,0000, ; Chozo statue
                        E8FF, 02F0,0270, 0000, 2800,0000, 0000,0000, ; Work robot
                        E8FF, 0370,0270, 0000, 2800,0000, 0000,0000, ; Work robot
                        FFFF, 02

; Room $CAAE, state $CAC0. Wrecked Ship attic missile tank room - default
$A1:C1E1             dw FFFF, 00

; Room $CD13, state $CD3F. Phantoon - main area boss is dead
$A1:C1E4             dw FFFF, 00

; Room $CC27, state $CC39. Wrecked Ship chozo energy tank room - default
$A1:C1E7             dw FFFF, 00

; Room $CE40, state $CE52. Gravity suit room - default
$A1:C1EA             dw FFFF, 00

; Room $CCCB, state $CCDD. Wrecked Ship map station - default
$A1:C1ED             dw E77F, 0088,0088, 0000, 6800,0000, 0000,0000, ; Coven
                        D87F, 0058,00B8, 0000, 2400,0000, B802,0050, ; Roach
                        D87F, 0050,00A8, 0000, 2400,0000, C402,0050, ; Roach
                        D87F, 004D,00CF, 0000, 2400,0000, FA03,0050, ; Roach
                        D87F, 00CD,00B8, 0000, 2400,0000, B004,0080, ; Roach
                        D87F, 00C8,00B0, 0000, 2400,0000, B803,00A0, ; Roach
                        D87F, 00D0,00B8, 0000, 2400,0000, D003,00A0, ; Roach
                        D87F, 008B,0027, 0000, 2400,0000, 7802,00A0, ; Roach
                        D87F, 008D,0008, 0000, 2400,0000, 8A02,0050, ; Roach
                        FFFF, 01

; Room $CE40, state $CE6C. Gravity suit room - main area boss is dead
$A1:C280             dw FFFF, 00

; Room $CC6F, state $CC81. Pre Phantoon hall - default
$A1:C283             dw D87F, 036B,00BB, 0000, 2400,0000, C203,0080, ; Roach
                        D87F, 0370,00B8, 0000, 2400,0000, DC04,0080, ; Roach
                        D87F, 0370,00BC, 0000, 2400,0000, DE03,0080, ; Roach
                        D87F, 0368,00C3, 0000, 2400,0000, C402,0080, ; Roach
                        D87F, 0372,00C9, 0000, 2400,0000, D803,0080, ; Roach
                        D87F, 004E,00AA, 0000, 2400,0000, 8802,0080, ; Roach
                        D87F, 0051,00AD, 0000, 2400,0000, 8C03,0080, ; Roach
                        D87F, 0048,00C8, 0000, 2400,0000, 7002,0080, ; Roach
                        D87F, 0052,00C2, 0000, 2400,0000, 9004,0080, ; Roach
                        D87F, 0029,00AA, 0000, 2400,0000, 8802,0080, ; Roach
                        D87F, 002D,00B9, 0000, 2400,0000, 9802,0080, ; Roach
                        D87F, 0030,00BF, 0000, 2400,0000, 9202,0080, ; Roach
                        D87F, 01E2,00DA, 0000, 2400,0000, B802,0080, ; Roach
                        D87F, 01DD,00E3, 0000, 2400,0000, 8803,0080, ; Roach
                        D87F, 01F8,00E3, 0000, 2400,0000, E003,0080, ; Roach
                        D87F, 03F3,00AF, 0000, 2400,0000, D003,0080, ; Roach
                        D87F, 03EF,00B3, 0000, 2400,0000, C802,0080, ; Roach
                        D87F, 03EA,00CB, 0000, 2400,0000, D002,0080, ; Roach
                        D87F, 03CC,00DE, 0000, 2400,0000, C804,0080, ; Roach
                        D87F, 03CE,00DE, 0000, 2400,0000, C402,0080, ; Roach
                        E93F, 004D,00C0, 0000, A800,0000, 0001,0000, ; Work robot deactivated
                        E93F, 0370,00C0, 0000, A800,0000, 0000,0000, ; Work robot deactivated
                        FFFF, 02

; Room $CA08, state $CA1A. Wrecked Ship entrance treadmill - default
$A1:C3E6             dw D87F, 0074,0040, 0000, 2400,0000, 1802,0050, ; Roach
                        D87F, 007C,00BD, 0000, 2400,0000, E002,0050, ; Roach
                        D87F, 0096,00C5, 0000, 2400,0000, B803,0050, ; Roach
                        D87F, 0073,004A, 0000, 2400,0000, 7804,0080, ; Roach
                        D87F, 00BA,0042, 0000, 2400,0000, 3003,00A0, ; Roach
                        D87F, 00B4,00C8, 0000, 2400,0000, 9803,00A0, ; Roach
                        D87F, 0041,0049, 0000, 2400,0000, 7802,00A0, ; Roach
                        D87F, 0082,00BC, 0000, 2400,0000, D803,0050, ; Roach
                        D87F, 0044,004B, 0000, 2400,0000, 5803,0050, ; Roach
                        D87F, 0257,0041, 0000, 2400,0000, 1802,0050, ; Roach
                        D87F, 011B,00BC, 0000, 2400,0000, E802,0050, ; Roach
                        D87F, 0112,00C4, 0000, 2400,0000, F802,0050, ; Roach
                        D87F, 012D,021E, 0000, 2400,0000, 7C03,0080, ; Roach
                        D87F, 0125,0226, 0000, 2400,0000, 9403,0080, ; Roach
                        D87F, 0143,023F, 0000, 2400,0000, 8402,0080, ; Roach
                        D87F, 013F,02BF, 0000, 2400,0000, A102,0040, ; Roach
                        D87F, 0145,02BA, 0000, 2400,0000, 9103,0040, ; Roach
                        D87F, 013D,02C3, 0000, 2400,0000, 8C02,0040, ; Roach
                        D87F, 010D,02DB, 0000, 2400,0000, AC03,0080, ; Roach
                        D87F, 01AD,04E8, 0000, 2400,0000, E804,0020, ; Roach
                        D87F, 0261,0042, 0000, 2400,0000, 5002,0050, ; Roach
                        D87F, 0293,0037, 0000, 2400,0000, 4802,0050, ; Roach
                        D87F, 027A,00B5, 0000, 2400,0000, CC02,0050, ; Roach
                        D87F, 028B,00BE, 0000, 2400,0000, DD02,0050, ; Roach
                        D87F, 0261,00CB, 0000, 2400,0000, 8802,0050, ; Roach
                        D87F, 03E9,00B3, 0000, 2400,0000, D802,0050, ; Roach
                        D87F, 03D9,00C0, 0000, 2400,0000, D802,0050, ; Roach
                        D87F, 03EB,00C4, 0000, 2400,0000, D802,0050, ; Roach
                        D87F, 03DE,0051, 0000, 2400,0000, 7D02,0050, ; Roach
                        D87F, 03EF,004C, 0000, 2400,0000, 3C02,0050, ; Roach
                        D87F, 036B,004B, 0000, 2400,0000, 7002,0050, ; Roach
                        D87F, 0317,00B0, 0000, 2400,0000, F802,0050, ; Roach
                        FFFF, 00

; Room $CAAE, state $CADA. Wrecked Ship attic missile tank room - main area boss is dead
$A1:C5E9             dw EA3F, 01D0,005D, 0000, 2000,0000, 0002,0098, ; Wrecked Ship spark
                        EA3F, 0270,005B, 0000, 2000,0000, 0001,0040, ; Wrecked Ship spark
                        EA3F, 0090,0058, 0000, 2000,0000, 0002,00A0, ; Wrecked Ship spark
                        EA3F, 00F0,0058, 0000, 2000,0000, 0001,0030, ; Wrecked Ship spark
                        EA3F, 012D,0058, 0000, 2000,0000, 0001,0010, ; Wrecked Ship spark
                        EA3F, 0190,0058, 0000, 2000,0000, 0002,0080, ; Wrecked Ship spark
                        EA3F, 0230,0058, 0000, 2000,0000, 0001,0028, ; Wrecked Ship spark
                        EA3F, 02D8,0048, 0000, 2000,0000, 0001,0020, ; Wrecked Ship spark
                        E8FF, 0250,0080, 0000, 2800,0000, 0000,0000, ; Work robot
                        E8FF, 0110,0080, 0000, 2800,0000, 0000,0000, ; Work robot
                        E8FF, 01B0,0080, 0000, 2800,0000, 0000,0000, ; Work robot
                        FFFF, 03

; Room $CE8A, state $CEB6. Wrecked Ship save station - main area boss is dead
$A1:C69C             dw FFFF, 00

; Room $CDA8, state $CDD4. Wrecked Ship west super missile room - main area boss is dead
$A1:C69F             dw EA3F, 009A,003A, 0000, 2000,0000, 0001,0030, ; Wrecked Ship spark
                        EA3F, 0034,003B, 0000, 2000,0000, 0001,0020, ; Wrecked Ship spark
                        EA3F, 0097,00B8, 0000, 2000,0000, 0001,0028, ; Wrecked Ship spark
                        EA3F, 0067,00C8, 0000, 2000,0000, 0001,0030, ; Wrecked Ship spark
                        EA3F, 00B2,00C8, 0000, 2000,0000, 0001,0018, ; Wrecked Ship spark
                        FFFF, 00

; Room $CA52, state $CA64. Wrecked Ship attic - default
$A1:C6F2             dw E77F, 02D7,0098, 0000, 6800,0000, 0000,0000, ; Coven
                        D87F, 06A9,00BA, 0000, 2400,0000, AA02,0050, ; Roach
                        D87F, 06AF,00BD, 0000, 2400,0000, D403,0550, ; Roach
                        D87F, 06AD,00C5, 0000, 2400,0000, D002,0050, ; Roach
                        D87F, 06B9,00B2, 0000, 2400,0000, F002,0080, ; Roach
                        D87F, 0028,00B9, 0000, 2400,0000, 7403,00A0, ; Roach
                        D87F, 0025,00BE, 0000, 2400,0000, 8803,05A0, ; Roach
                        D87F, 001B,00C6, 0000, 2400,0000, A002,00A0, ; Roach
                        D87F, 0033,0052, 0000, 2400,0000, 7803,0050, ; Roach
                        D87F, 0028,0043, 0000, 2400,0000, 5002,0550, ; Roach
                        D87F, 040E,00E6, 0000, 2400,0000, 8203,0050, ; Roach
                        D87F, 011E,00EA, 0000, 2400,0000, 8402,0050, ; Roach
                        D87F, 0114,00E6, 0000, 2400,0000, 8203,0050, ; Roach
                        D87F, 001A,0049, 0000, 2400,0000, 9803,0580, ; Roach
                        D87F, 0431,00E9, 0000, 2400,0000, B802,0080, ; Roach
                        D87F, 043D,00ED, 0000, 2400,0000, BA04,0580, ; Roach
                        D87F, 05C3,00E3, 0000, 2400,0000, C401,0540, ; Roach
                        D87F, 05D2,00D7, 0000, 2400,0000, B802,0040, ; Roach
                        D87F, 01A7,0094, 0000, 2400,0000, 4003,0540, ; Roach
                        D87F, 06D5,00C5, 0000, 2400,0000, E002,0080, ; Roach
                        E9FF, 00E0,004E, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 02F0,005E, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 0630,006E, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 05D0,00BE, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 0290,00BE, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 0130,00BE, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 0370,00DE, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 04D0,007E, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 0430,007E, 0000, 2000,0000, 0000,0000, ; Atomic
                        FFFF, 0A

; Room $CDF1, state $CE03. Wrecked Ship east super missile hall - default
$A1:C8C5             dw E77F, 0088,0088, 0000, 6800,0000, 0000,0000, ; Coven
                        D87F, 034F,009A, 0000, 2400,0000, C203,0080, ; Roach
                        D87F, 00FF,00E9, 0000, 2400,0000, FC04,0080, ; Roach
                        D87F, 0354,00A6, 0000, 2400,0000, DE02,0080, ; Roach
                        D87F, 0354,00A4, 0000, 2400,0000, C402,0080, ; Roach
                        D87F, 0347,00A6, 0000, 2400,0000, D802,0080, ; Roach
                        D87F, 0175,00D1, 0000, 2400,0000, 8802,0080, ; Roach
                        D87F, 0051,00AD, 0000, 2400,0000, 8C03,0080, ; Roach
                        D87F, 0048,00C8, 0000, 2400,0000, 7002,0080, ; Roach
                        D87F, 02DE,0099, 0000, 2400,0000, 3003,0080, ; Roach
                        D87F, 02CB,008F, 0000, 2400,0000, B802,0080, ; Roach
                        D87F, 002D,00B9, 0000, 2400,0000, 9803,0080, ; Roach
                        D87F, 0030,00BF, 0000, 2400,0000, 9202,0080, ; Roach
                        D87F, 02C9,008A, 0000, 2400,0000, B802,0080, ; Roach
                        D87F, 02E3,0073, 0000, 2400,0000, A804,0080, ; Roach
                        D87F, 02E7,00AA, 0000, 2400,0000, E002,0080, ; Roach
                        D87F, 03F3,00AF, 0000, 2400,0000, D004,0080, ; Roach
                        D87F, 03EF,00B3, 0000, 2400,0000, C802,0080, ; Roach
                        D87F, 03EA,00CB, 0000, 2400,0000, D002,0080, ; Roach
                        D87F, 0184,00D8, 0000, 2400,0000, C802,0080, ; Roach
                        D87F, 00F0,00E5, 0000, 2400,0000, 8202,0080, ; Roach
                        E93F, 0178,0090, 0000, A800,0000, 0000,0000, ; Work robot deactivated
                        E93F, 02C4,0090, 0000, A800,0000, 0002,0000, ; Work robot deactivated
                        E9FF, 00A0,0050, 0000, 2000,0000, 0000,0000, ; Atomic
                        E9FF, 0120,0050, 0000, 2000,0000, 0001,0000, ; Atomic
                        E9FF, 01D0,0050, 0000, 2000,0000, 0002,0000, ; Atomic
                        E9FF, 0250,0050, 0000, 2000,0000, 0003,0000, ; Atomic
                        FFFF, 07

; Room $CE8A, state $CE9C. Wrecked Ship save station - default
$A1:CA78             dw E77F, 0088,0088, 0000, 6800,0000, 0000,0000, ; Coven
                        D87F, 0083,00BA, 0000, 2400,0000, B002,0030, ; Roach
                        D87F, 007B,00B5, 0000, 2400,0000, CA02,0030, ; Roach
                        D87F, 008E,00C0, 0000, 2400,0000, FA02,0030, ; Roach
                        D87F, 0074,00C4, 0000, 2400,0000, 8302,0030, ; Roach
                        D87F, 00B9,002E, 0000, 2400,0000, 7B02,0050, ; Roach
                        D87F, 00C1,0035, 0000, 2400,0000, E002,0050, ; Roach
                        D87F, 00BA,0036, 0000, 2400,0000, F802,0050, ; Roach
                        D87F, 00CB,0040, 0000, 2400,0000, 1802,0050, ; Roach
                        D87F, 00C5,0046, 0000, 2400,0000, FD02,0050, ; Roach
                        D87F, 0033,00AB, 0000, 2400,0000, 8802,0130, ; Roach
                        D87F, 0038,00AC, 0000, 2400,0000, 9002,0030, ; Roach
                        FFFF, 01

; Room $CBD5, state $CC01. Wrecked Ship east exit - main area boss is dead
$A1:CB3B             dw EA3F, 0068,0258, 0000, 2000,0000, 0002,0080, ; Wrecked Ship spark
                        EA3F, 002A,0227, 0000, 2000,0000, 0001,0080, ; Wrecked Ship spark
                        EA3F, 00C8,01DD, 0000, 2000,0000, 0001,0010, ; Wrecked Ship spark
                        EA3F, 0086,018A, 0000, 2000,0000, 0002,0090, ; Wrecked Ship spark
                        EA3F, 004F,0033, 0000, 2000,0000, 0002,0090, ; Wrecked Ship spark
                        EA3F, 0035,00DA, 0000, 2000,0000, 0001,0010, ; Wrecked Ship spark
                        EA3F, 005C,0098, 0000, 2000,0000, 0002,00A0, ; Wrecked Ship spark
                        FFFF, 00

; Room $CB8B, state $CBB7. Wrecked Ship spike platform hall - main area boss is dead
$A1:CBAE             dw DFFF, 0050,0060, 0000, A800,0000, 0040,6810, ; Spike platform top
                        E03F, 0050,0068, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 00A0,0060, 0000, A000,0000, 0040,680C, ; Spike platform top
                        E03F, 00A0,0068, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 0100,0060, 0000, A800,0000, 0040,6811, ; Spike platform top
                        E03F, 0100,0068, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 0160,0060, 0000, A000,0000, 0040,680A, ; Spike platform top
                        E03F, 0160,0068, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 01B0,0060, 0000, A800,0000, 0040,6814, ; Spike platform top
                        E03F, 01B0,0068, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        FFFF, 00

; Room $CDF1, state $CE1D. Wrecked Ship east super missile hall - main area boss is dead
$A1:CC51             dw E8FF, 0178,0080, 0000, 2800,0000, 0000,0000, ; Work robot
                        E8FF, 02C0,0080, 0000, 2800,0000, 0000,0000, ; Work robot
                        E97F, 00E0,0078, 0000, 2800,0000, 0003,0003, ; Bull
                        E97F, 0210,0075, 0000, 2800,0000, 0003,0003, ; Bull
                        EA3F, 00A0,0050, 0000, 2000,0000, 0001,0080, ; Wrecked Ship spark
                        EA3F, 0120,0050, 0000, 2000,0000, 0001,0010, ; Wrecked Ship spark
                        EA3F, 01D0,0050, 0000, 2000,0000, 0001,00A0, ; Wrecked Ship spark
                        EA3F, 0250,0050, 0000, 2000,0000, 0001,0080, ; Wrecked Ship spark
                        FFFF, 04

; Room $CD13, state $CD25. Phantoon - default
$A1:CCD4             dw E4BF, 0080,0060, 0000, 2800,0004, 0000,0000, ; Phantoon body
                        E4FF, 0080,0060, 0000, 2C00,0004, 0000,0001, ; Phantoon eye
                        E53F, 0080,0060, 0000, 2C00,0004, 0000,0002, ; Phantoon tentacles
                        E57F, 0080,0060, 0000, 2C00,0004, 0000,0003, ; Phantoon mouth
                        FFFF, 00

; Room $CAF6, state $CB22. Wrecked Ship mainstreet - main area boss is dead
$A1:CD17             dw EA3F, 0498,02A8, 0000, 2000,0000, 0001,0030, ; Wrecked Ship spark
                        EA3F, 0470,0359, 0000, 2000,0000, 0001,0028, ; Wrecked Ship spark
                        EA3F, 0420,048C, 0000, 2000,0000, 0001,0020, ; Wrecked Ship spark
                        EA3F, 04C8,0508, 0000, 2000,0000, 0001,0020, ; Wrecked Ship spark
                        EA3F, 0488,05BC, 0000, 2000,0000, 0001,0018, ; Wrecked Ship spark
                        EA3F, 0469,071A, 0000, 2000,0000, 0000,0000, ; Wrecked Ship spark
                        EA3F, 0418,0788, 0000, 2000,0000, 0002,0030, ; Wrecked Ship spark
                        E9FF, 0478,0252, 0000, 2000,0000, 0000,0008, ; Atomic
                        E9FF, 04D5,02AB, 0000, 2000,0000, 0001,0008, ; Atomic
                        E9FF, 04C0,0507, 0000, 2000,0000, 0002,0008, ; Atomic
                        E9FF, 0426,05B9, 0000, 2000,0000, 0002,0008, ; Atomic
                        DFFF, 0260,0558, 0000, A000,0000, 0020,5030, ; Spike platform top
                        E03F, 0260,0560, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 01C0,0558, 0000, A000,0000, 0020,5030, ; Spike platform top
                        E03F, 01C0,0560, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 0120,0558, 0000, A000,0000, 0020,5030, ; Spike platform top
                        E03F, 0120,0560, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        DFFF, 0080,0558, 0000, A000,0000, 0020,5030, ; Spike platform top
                        E03F, 0080,0560, 0000, 0100,0000, 0000,0000, ; Spike platform bottom
                        EA3F, 04D0,07C8, 0000, 2000,0000, 0001,0030, ; Wrecked Ship spark
                        EA3F, 0430,07C8, 0000, 2000,0000, 0001,0020, ; Wrecked Ship spark
                        FFFF, 04

; Room $D0B9. Mt. Doom
$A1:CE6A             dw E8BF, 0200,0180, 0000, 2C00,0000, 0001,0070, ; Powamp
                        E8BF, 0200,0180, 0000, 2800,0000, 0000,0000, ; Powamp
                        E8BF, 0308,0200, 0000, 2C00,0000, 0001,0120, ; Powamp
                        E8BF, 0308,0200, 0000, 2800,0000, 0000,0000, ; Powamp
                        E8BF, 0400,0230, 0000, 2C00,0000, 0001,0030, ; Powamp
                        E8BF, 0400,0230, 0000, 2800,0000, 0000,0000, ; Powamp
                        D77F, 02F0,0387, 0002, 2000,0000, 0001,0000, ; Sciser
                        D77F, 0228,3B60, 0002, 2000,0000, 0004,0000, ; Sciser
                        D77F, 0168,0240, 0000, 2000,0000, 0002,0000, ; Sciser
                        D77F, 03C0,03B8, 0003, 2001,0000, 0002,0000, ; Sciser
                        D77F, 0268,02A0, 0000, 2000,0000, 0004,0000, ; Sciser
                        D77F, 0499,0358, 0001, 2000,0000, 0002,0000, ; Sciser
                        FFFF, 09

; Room $D913. Maridia grapple wall shaft
$A1:CF2D             dw D37F, 0250,0260, 0000, A800,0004, 0000,0000, ; Oum
                        D37F, 02D0,0260, 0000, A800,0004, 0000,0000, ; Oum
                        D37F, 0370,0260, 0000, A800,0004, 0000,0000, ; Oum
                        D8FF, 00A0,0238, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0050,0190, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0060,0080, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        FFFF, 06

; Room $D13B. Sandy Maridia missile and super missile room
$A1:CF90             dw D3BF, 0078,01E0, 0000, 2000,0000, 0005,0008, ; Choot
                        F193, 0110,00CC, 0000, 6900,0000, 0000,0000, ; Zeb
                        F193, 0190,00CC, 0000, 6900,0000, 0000,0000, ; Zeb
                        FFFF, 03

; Room $D1A3. Maridia crab shaft
$A1:CFC3             dw D77F, 0170,0367, 0002, 2801,0000, 0003,0000, ; Sciser
                        D77F, 0030,03B8, 0003, 2000,0000, 0001,0000, ; Sciser
                        D77F, 00E0,0367, 0002, 2000,0000, 0001,0000, ; Sciser
                        D77F, 0080,00B8, 0003, 2800,0000, 0004,0000, ; Sciser
                        FFFF, 04

; Room $D30B. Maridia -> Crateria elevator
$A1:D006             dw D73F, 0080,02C0, 0000, 2C00,0000, 0001,0018, ; Elevator
                        D47F, 00D0,0314, 0000, 2000,0000, 0010,0000, ; Ripper
                        D47F, 0070,0384, 0000, 2000,0000, 0010,0001, ; Ripper
                        D47F, 0080,03F4, 0000, 2000,0000, 0010,0000, ; Ripper
                        D47F, 0090,0454, 0000, 2000,0000, 0010,0000, ; Ripper
                        D47F, 0040,04C8, 0000, 2000,0000, 0010,0000, ; Ripper
                        D47F, 0038,02D0, 0000, 2000,0000, 0010,0000, ; Ripper
                        D03F, 0098,05C8, 0000, 2000,0000, 0300,0104, ; Owtch
                        FFFF, 07

; Room $D72A. Maridia grapple room
$A1:D089             dw D8FF, 0080,0078, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0290,0068, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0450,00B0, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0490,0060, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0660,0088, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 00A8,01A0, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0168,0158, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0630,01A0, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        FFFF, 08

; Room $D765. Snail room save station
$A1:D10C             dw FFFF, 00

; Room $D78F. Pre Draygon room
$A1:D10F             dw FFFF, 00

; Room $D7E4. Maridia speed blockade hall
$A1:D112             dw CFBF, 0120,0080, 0000, 2000,0000, 0000,0016, ; Puyo
                        CFBF, 0190,0070, 0000, 2000,0000, 0000,0016, ; Puyo
                        CFBF, 01F0,0080, 0000, 2000,0000, 0000,0016, ; Puyo
                        CFBF, 0250,0080, 0000, 2000,0000, 0000,0016, ; Puyo
                        CFBF, 03F0,00AC, 0000, 2000,0000, 0010,0016, ; Puyo
                        DA7F, 0560,00D8, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 0560,00E0, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 0560,00E8, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 0560,00F0, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 0560,00F8, 0000, 6100,0000, 0000,0000, ; Zoa
                        FFFF, 0A

; Room $D81A. Draygon save station
$A1:D1B5             dw FFFF, 00

; Room $D845. Maridia missile station
$A1:D1B8             dw FFFF, 00

; Room $D86E. Sandy Maridia quicksand fall
$A1:D1BB             dw E97F, 0020,0038, 0000, 2800,0000, 0001,0000, ; Bull
                        E97F, 00E0,0078, 0000, 2800,0000, 0001,0001, ; Bull
                        E97F, 0058,00C8, 0000, 2800,0000, 0005,0007, ; Bull
                        FFFF, 03

; Room $D898. Maridia speed blockade quicksand fall
$A1:D1EE             dw E97F, 0048,0020, 0000, 2800,0000, 0001,0001, ; Bull
                        E97F, 0048,0068, 0000, 2800,0000, 0003,0002, ; Bull
                        E97F, 00F0,0090, 0000, 2800,0000, 0005,0006, ; Bull
                        E97F, 0048,00D0, 0000, 2800,0000, 0001,0007, ; Bull
                        E97F, 0100,0038, 0000, 2800,0000, 0002,0002, ; Bull
                        E97F, 01B8,0028, 0000, 2800,0000, 0001,0001, ; Bull
                        E97F, 01C8,0068, 0000, 2800,0000, 0003,0002, ; Bull
                        E97F, 01E0,00C0, 0000, 2800,0000, 0001,0007, ; Bull
                        E97F, 0100,00E0, 0000, 2800,0000, 0002,0007, ; Bull
                        FFFF, 09

; Room $D8C5. Shaktool
$A1:D281             dw F07F, 00A8,00B8, 0000, 2000,0000, 0000,0000, ; Shaktool
                        F07F, 00A8,00B8, 0000, 2000,0000, 0000,0002, ; Shaktool
                        F07F, 00A8,00B8, 0000, 2000,0000, 0000,0004, ; Shaktool
                        F07F, 00A8,00B8, 0000, 2000,0000, 0000,0006, ; Shaktool
                        F07F, 00A8,00B8, 0000, 2000,0000, 0000,0008, ; Shaktool
                        F07F, 00A8,00B8, 0000, 2000,0000, 0000,000A, ; Shaktool
                        F07F, 00A8,00B8, 0000, 2000,0000, 0000,000C, ; Shaktool
                        DBBF, 0398,00B8, 0006, A000,0000, 0001,0000, ; Yard
                        DBBF, 03D8,0050, 0002, A000,0000, 0001,0000, ; Yard
                        FFFF, 03

; Room $DA60, state $DA72. Draygon - default
$A1:D314             dw DE3F, FFB0,FFB0, 0000, 2800,0004, 0000,0000, ; Draygon body
                        DE7F, FFB0,FFB0, 0000, 2C00,0004, 0000,0000, ; Draygon eye
                        DEBF, FFB0,FFB0, 0000, 2C00,0004, 0000,0000, ; Draygon tail
                        DEFF, FFB0,FFB0, 0000, 2C00,0004, 0000,0000, ; Draygon arms
                        FFFF, 00

; Room $D5A7. Snail room
$A1:D357             dw DBBF, 0544,01D8, 0007, A800,0000, 0004,0000, ; Yard
                        DBBF, 0220,0294, 0006, A800,0000, 0003,0000, ; Yard
                        DBBF, 0420,0264, 0004, A800,0000, 0005,0000, ; Yard
                        DBBF, 01D8,0130, 0003, A800,0000, 0007,0000, ; Yard
                        DBBF, 0550,02B8, 0004, A000,0000, 0002,0000, ; Yard
                        FFFF, 05

; Room $D104. Maridia -> Red Brinstar room
$A1:D3AA             dw D6FF, 02C0,01B0, 0000, 2000,0000, 0008,1001, ; Skultera
                        F1D3, 0088,00CC, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0088,00D4, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0088,00DC, 0000, 6900,0000, 0002,0000, ; Zebbo
                        FFFF, 04

; Room $D2AA. Plasma beam room
$A1:D3ED             dw F753, 0100,0080, 0000, 2000,0004, 8001,0020, ; Magenta walking space pirate
                        F753, 0080,01D0, 0000, 2000,0004, 8000,0030, ; Magenta walking space pirate
                        F753, 01B0,01D0, 0000, 2000,0004, 8001,0030, ; Magenta walking space pirate
                        F453, 0030,0180, 0000, 2000,0004, 0000,01A0, ; Magenta wall space pirate
                        F453, 01D0,0130, 0000, 2000,0004, 0001,01A0, ; Magenta wall space pirate
                        F753, 0078,0280, 0000, 2000,0004, 8001,0080, ; Magenta walking space pirate
                        FFFF, 06

; Room $D9AA. Space jump room
$A1:D450             dw FFFF, 00

; Room $D646. Pants room
$A1:D453             dw D17F, 0050,0050, 0000, 2000,0000, 0000,0000, ; Memu
                        D17F, 0030,0078, 0000, 2000,0000, 0000,0000, ; Memu
                        D17F, 00B8,0050, 0000, 2000,0000, 0000,0000, ; Memu
                        CFBF, 0170,029C, 0000, 2000,0000, 0080,0016, ; Puyo
                        CFBF, 0160,01FC, 0000, 2000,0000, 0080,0016, ; Puyo
                        D17F, 0170,0078, 0000, 2000,0000, 0000,0000, ; Memu
                        D17F, 0198,0070, 0000, 2000,0000, 0000,0000, ; Memu
                        D17F, 0090,0070, 0000, 2000,0000, 0000,0000, ; Memu
                        CFBF, 01C0,02DC, 0000, 2000,0000, 0020,0016, ; Puyo
                        CFBF, 0180,032C, 0000, 2000,0000, 0030,0016, ; Puyo
                        CFBF, 01A0,019C, 0000, 2000,0000, 0040,0016, ; Puyo
                        CFBF, 0150,03F0, 0000, 2000,0000, 0010,0008, ; Puyo
                        CFBF, 01B0,03F0, 0000, 2000,0000, 0008,0008, ; Puyo
                        FFFF, 07

; Room $CED2. n00b tube save station
$A1:D526             dw FFFF, 00

; Room $CEFB. n00b tube
$A1:D529             dw F0BF, 0080,0100, 0000, 2200,0000, 0000,0000, ; n00b tube cracks
                        FFFF, 00

; Room $CF54. n00b tube west
$A1:D53C             dw FFFF, 00

; Room $CF80. n00b tube east
$A1:D53F             dw CEBF, 0088,00C0, 0000, 2000,0000, 0104,0008, ; Boyon
                        CEBF, 01E8,00D0, 0000, 2000,0000, 0004,0008, ; Boyon
                        CEBF, 0218,00D0, 0000, 2000,0000, 0104,0020, ; Boyon
                        CEBF, 0278,00D0, 0000, 2000,0000, 0304,0008, ; Boyon
                        CEBF, 02D8,00D0, 0000, 2000,0000, 0306,0008, ; Boyon
                        CEBF, 0308,00D0, 0000, 2000,0000, 0304,0008, ; Boyon
                        CEBF, 0368,00D0, 0000, 2000,0000, 0004,0008, ; Boyon
                        F1D3, 00B8,00C8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 02A8,00C8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        F1D3, 0248,00C8, 0000, 6900,0000, 0002,0000, ; Zebbo
                        FFFF, 03

; Room $D055. Tatori room
$A1:D5E2             dw CF3F, 01D8,03CD, 0000, A800,0000, 0000,0000, ; Tatori
                        CF7F, 01B0,03CD, 0000, A800,0000, FFFF,0000, ; Mini-tatori
                        CF7F, 01D8,03CD, 0000, A800,0000, FFFF,0000, ; Mini-tatori
                        CF7F, 01E8,03CD, 0000, A800,0000, 0001,0000, ; Mini-tatori
                        CF7F, 0218,03CD, 0000, A800,0000, 0001,0000, ; Mini-tatori
                        FFFF, 01

; Room $D08A. Maridia green gate hall
$A1:D635             dw D77F, 0080,0047, 0002, 2001,0000, 0001,0000, ; Sciser
                        D77F, 0130,0087, 0002, 2000,0000, 0002,0000, ; Sciser
                        D77F, 01C0,00C8, 0003, 2800,0000, 0003,0000, ; Sciser
                        D77F, 0200,0047, 0002, 2800,0000, 0001,0000, ; Sciser
                        D77F, 02B0,00C8, 0003, 2000,0000, 0002,0000, ; Sciser
                        D77F, 0370,0047, 0002, 2000,0000, 0001,0000, ; Sciser
                        FFFF, 06

; Room $D16D. Sandy Maridia memu room
$A1:D698             dw D03F, 0040,01C8, 0000, 2000,0000, 0101,0004, ; Owtch
                        D03F, 00B8,01C8, 0000, 2000,0000, 0100,0108, ; Owtch
                        D03F, 0170,01C8, 0000, 2000,0000, 0100,0308, ; Owtch
                        D03F, 0198,01C8, 0000, 2000,0000, 0301,0104, ; Owtch
                        D03F, 0290,01B8, 0000, 2000,0000, 0101,0008, ; Owtch
                        D03F, 0308,01C8, 0000, 2000,0000, 0500,0104, ; Owtch
                        D03F, 0378,01C8, 0000, 2000,0000, 0501,0108, ; Owtch
                        D17F, 0020,0110, 0000, 2000,0000, 0000,0000, ; Memu
                        D17F, 0018,0140, 0000, 2000,0000, 0000,0000, ; Memu
                        D17F, 0010,0170, 0000, 2000,0000, 0000,0000, ; Memu
                        D17F, 02F0,0160, 0000, 2000,0000, 0000,0000, ; Memu
                        D17F, 0360,0140, 0000, 2000,0000, 0000,0000, ; Memu
                        FFFF, 07

; Room $D1DD. Beach
$A1:D75B             dw D03F, 0180,02B8, 0000, 2000,0000, 0101,0208, ; Owtch
                        D3BF, 00F0,01A4, 0000, 2000,0000, 0203,0002, ; Choot
                        D3BF, 0210,017C, 0000, 2000,0000, 0004,0004, ; Choot
                        D3BF, 02A8,013C, 0000, 2000,0000, 0102,0010, ; Choot
                        D3BF, 0310,00DC, 0000, 2000,0000, 0002,0008, ; Choot
                        D3BF, 0368,009C, 0000, 2000,0000, 0002,0004, ; Choot
                        D6FF, 0070,0258, 0000, 2800,0000, 0010,0210, ; Skultera
                        D6FF, 01C0,0280, 0000, 2800,0000, 0110,0210, ; Skultera
                        D3BF, 03B8,01E0, 0000, 2000,0000, 0005,0008, ; Choot
                        FFFF, 09

; Room $D252. Maridia broken glass tube room east
$A1:D7EE             dw D77F, 0088,0067, 0002, 2000,0000, 0004,0000, ; Sciser
                        FFFF, 01

; Room $D27E. Plasma beam puyo room
$A1:D801             dw CFBF, 0057,009C, 0000, 2000,0000, 0F00,0000, ; Puyo
                        CFBF, 0062,009C, 0000, 2000,0000, 0F00,0000, ; Puyo
                        CFBF, 0069,009C, 0000, 2000,0000, 0F00,0000, ; Puyo
                        CFBF, 005B,0098, 0000, 2000,0000, 0E00,0000, ; Puyo
                        CFBF, 0065,0098, 0000, 2000,0000, 0E00,0000, ; Puyo
                        CFBF, 0061,0094, 0000, 2000,0000, 0D00,0000, ; Puyo
                        FFFF, 06

; Room $D2D9. Sandy Maridia choot-puyo hall
$A1:D864             dw CFBF, 0118,008C, 0000, 2000,0000, 0020,0016, ; Puyo
                        CFBF, 0144,00AC, 0000, 2000,0000, 0020,0016, ; Puyo
                        CFBF, 02C4,008C, 0000, 2000,0000, 0040,0016, ; Puyo
                        CFBF, 05F8,006C, 0000, 2000,0000, 0030,0016, ; Puyo
                        CFBF, 0410,006C, 0000, 2000,0000, 0020,0016, ; Puyo
                        CFBF, 0470,008C, 0000, 2000,0000, 0040,0016, ; Puyo
                        CFBF, 0440,005C, 0000, 2000,0000, 0010,0016, ; Puyo
                        D3BF, 00D8,008C, 0000, 2000,0000, 0201,0000, ; Choot
                        D3BF, 01B0,00AC, 0000, 2000,0000, 0202,0000, ; Choot
                        D3BF, 0318,006C, 0000, 2000,0000, 0201,0000, ; Choot
                        D3BF, 0518,00AC, 0000, 2000,0000, 0202,0000, ; Choot
                        D3BF, 05A8,008C, 0000, 2000,0000, 0102,0000, ; Choot
                        D3BF, 0278,00AC, 0000, 2000,0000, 0003,0000, ; Choot
                        D3BF, 03A8,00AC, 0000, 2000,0000, 0003,0000, ; Choot
                        D3BF, 065C,00AC, 0000, 2000,0000, 0202,0000, ; Choot
                        FFFF, 0F

; Room $D340. Sandy Maridia mainstreet
$A1:D957             dw D03F, 0350,04F8, 0000, 2000,0000, 0100,0304, ; Owtch
                        D03F, 0338,04F8, 0000, 2000,0000, 0101,0204, ; Owtch
                        D03F, 0170,0568, 0000, 2000,0000, 0301,0002, ; Owtch
                        D03F, 01A0,05C8, 0000, 2000,0000, 0501,0204, ; Owtch
                        D3BF, 0100,029C, 0000, 2000,0000, 0001,0010, ; Choot
                        D3BF, 0230,039C, 0000, 2000,0000, 0005,0000, ; Choot
                        D3BF, 0300,03A4, 0000, 2000,0000, 0207,0000, ; Choot
                        D3BF, 01E0,00AC, 0000, 2000,0000, 0001,0010, ; Choot
                        D3BF, 0270,00EC, 0000, 2000,0000, 0001,0010, ; Choot
                        D6FF, 0300,0420, 0000, 2800,0000, 0010,0210, ; Skultera
                        D6FF, 0270,0488, 0000, 2800,0000, 0110,0210, ; Skultera
                        FFFF, 0B

; Room $D408. Maridia elevatube
$A1:DA0A             dw D8FF, 00A0,0388, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        CFBF, 0064,0358, 0000, 2000,0000, 0010,0004, ; Puyo
                        DBBF, 0030,0698, 0006, A000,0000, 0002,0000, ; Yard
                        FFFF, 03

; Room $D461. Evir hall west
$A1:DA3D             dw E63F, 01F8,00A0, 0000, 2000,0000, 0000,F808, ; Evir
                        E63F, 01F8,00A0, 0000, 2400,0000, 0001,0000, ; Evir
                        E67F, 01F8,00A0, 0000, 2800,0000, 0002,0000, ; Evir projectile
                        E63F, 02E0,0078, 0000, 2000,0000, 0000,D00C, ; Evir
                        E63F, 02E0,0078, 0000, 2400,0000, 0001,0000, ; Evir
                        E67F, 02E0,0078, 0000, 2800,0000, 0002,0000, ; Evir projectile
                        E63F, 0340,00A0, 0000, 2000,0000, 0000,F808, ; Evir
                        E63F, 0340,00A0, 0000, 2400,0000, 0001,0000, ; Evir
                        E67F, 0340,00A0, 0000, 2800,0000, 0002,0000, ; Evir projectile
                        FFFF, 03

; Room $D48E. Elevatube south
$A1:DAD0             dw FFFF, 00

; Room $D4C2. Evir hall east
$A1:DAD3             dw E63F, 00A8,00A0, 0000, 2000,0000, 0000,F808, ; Evir
                        E63F, 00A8,00A0, 0000, 2400,0000, 0001,0000, ; Evir
                        E67F, 00A8,00A0, 0000, 2800,0000, 0002,0000, ; Evir projectile
                        E63F, 0100,0078, 0000, 2000,0000, 0000,D00C, ; Evir
                        E63F, 0100,0078, 0000, 2400,0000, 0001,0000, ; Evir
                        E67F, 0100,0078, 0000, 2800,0000, 0002,0000, ; Evir projectile
                        E63F, 0220,0078, 0000, 2000,0000, 0000,D00C, ; Evir
                        E63F, 0220,0078, 0000, 2400,0000, 0001,0000, ; Evir
                        E67F, 0220,0078, 0000, 2800,0000, 0002,0000, ; Evir projectile
                        FFFF, 03

; Room $D54D. Snail room quicksand fall west
$A1:DB66             dw E97F, 0028,00B8, 0000, 2800,0000, 0008,0001, ; Bull
                        E97F, 0048,0138, 0000, 2800,0000, 0008,0001, ; Bull
                        E97F, 00B8,0118, 0000, 2800,0000, 0006,0000, ; Bull
                        E97F, 00A8,0178, 0000, 2800,0000, 0007,0002, ; Bull
                        E97F, 00D8,0068, 0000, 2800,0000, 000A,0000, ; Bull
                        E97F, 0028,0038, 0000, 2800,0000, 000A,0000, ; Bull
                        E97F, 0070,01B8, 0000, 2800,0000, 0007,0002, ; Bull
                        FFFF, 07

; Room $D57A. Snail room quicksand fall east
$A1:DBD9             dw E97F, 0038,00D8, 0000, 2800,0000, 0009,0001, ; Bull
                        E97F, 00D8,0098, 0000, 2800,0000, 000A,0001, ; Bull
                        E97F, 0058,0178, 0000, 2800,0000, 0007,0002, ; Bull
                        E97F, 00B8,0138, 0000, 2800,0000, 0008,0002, ; Bull
                        E97F, 0028,0028, 0000, 2800,0000, 000A,0000, ; Bull
                        E97F, 0098,01C8, 0000, 2800,0000, 0007,0002, ; Bull
                        FFFF, 06

; Room $D5EC. Sandy Maridia quicksand bottom
$A1:DC3C             dw DA7F, 0098,00D8, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 0068,00D8, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 0098,00E0, 0000, 6100,0000, 0000,0000, ; Zoa
                        FFFF, 03

; Room $D617. Mochtroid room
$A1:DC6F             dw D8FF, 0030,0048, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 00C0,0090, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0170,0048, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 0298,0098, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        D8FF, 02F0,0780, 0000, 2000,0000, 0000,0000, ; Mochtroid
                        CFBF, 0260,0058, 0000, 2000,0000, 0020,0008, ; Puyo
                        CFBF, 0360,0058, 0000, 2000,0000, 0020,0008, ; Puyo
                        FFFF, 07

; Room $D69A. Pants room section
$A1:DCE2             dw CFBF, 0080,022C, 0000, 2000,0000, 0030,0016, ; Puyo
                        CFBF, 00C0,01DC, 0000, 2000,0000, 0020,0016, ; Puyo
                        CFBF, 0070,019C, 0000, 2000,0000, 0080,0016, ; Puyo
                        CFBF, 0050,02F0, 0000, 2000,0000, 0010,0008, ; Puyo
                        CFBF, 00B0,02F0, 0000, 2000,0000, 0008,0008, ; Puyo
                        FFFF, 05

; Room $D6D0. Spring ball room
$A1:DD35             dw FFFF, 00

; Room $D6FD. Maridia speed blockade quicksand bottom
$A1:DD38             dw DA7F, 02B8,00C8, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 01C8,00D0, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 01C8,00D8, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 03B8,00D8, 0000, 6100,0000, 0000,0000, ; Zoa
                        DA7F, 01C8,00E0, 0000, 6100,0000, 0000,0000, ; Zoa
                        D03F, 00C0,00A8, 0000, 2000,0000, 0101,031C, ; Owtch
                        FFFF, 06

; Room $D387. Pre plasma beam shaft
$A1:DD9B             dw D3BF, 0070,00BC, 0000, 2000,0000, 0203,0010, ; Choot
                        D3BF, 0090,01DC, 0000, 2000,0000, 0202,0010, ; Choot
                        D3BF, 0060,02CC, 0000, 2000,0000, 0104,0010, ; Choot
                        CFBF, 00D8,02BC, 0000, 2000,0000, 0040,0008, ; Puyo
                        CFBF, 0038,01CC, 0000, 2000,0000, 0040,0008, ; Puyo
                        CFBF, 00D4,037C, 0000, 2000,0000, 0040,0008, ; Puyo
                        CFBF, 00A8,03AC, 0000, 2000,0000, 0040,0008, ; Puyo
                        FFFF, 07

; Room $D3DF. Sandy Maridia save station
$A1:DE0E             dw FFFF, 00

; Room $D9D4. Maridia energy station
$A1:DE11             dw FFFF, 00

; Room $D3B6. Maridia map station
$A1:DE14             dw FFFF, 00

; Room $D21C. Maridia broken glass tube room
$A1:DE17             dw D77F, 0060,0037, 0002, 2800,0000, 0001,0000, ; Sciser
                        D77F, 0076,00E8, 0000, 2801,0000, 0004,0000, ; Sciser
                        D77F, 0076,0100, 0000, 2801,0000, 0002,0000, ; Sciser
                        D77F, 0080,01B8, 0003, 2800,0000, 0002,0000, ; Sciser
                        FFFF, 04

; Room $D95E. Botwoon
$A1:DE5A             dw F293, 0080,0080, 0000, 2800,0000, 0000,0000, ; Botwoon
                        FFFF, 01

; Room $CFC9. Maridia mainstreet
$A1:DE6D             dw D6FF, 0100,01A0, 0000, 2000,0000, 0010,0210, ; Skultera
                        D6FF, 00F0,03D8, 0000, 2800,0000, 0010,0210, ; Skultera
                        D6FF, 0120,04F0, 0000, 2000,0000, 0010,0210, ; Skultera
                        D6FF, 00D0,05A0, 0000, 2000,0000, 0010,0210, ; Skultera
                        D6FF, 0100,0724, 0000, 2000,0000, 0010,0210, ; Skultera
                        D77F, 0090,0118, 0003, 2001,0000, 0002,0000, ; Sciser
                        D77F, 00F0,0298, 0003, 2000,0000, 0003,0000, ; Sciser
                        D77F, 00F8,0487, 0002, 2001,0000, 0001,0000, ; Sciser
                        D77F, 0108,0658, 0003, 2001,0000, 0001,0000, ; Sciser
                        D77F, 0168,0257, 0002, 2000,0000, 0001,0000, ; Sciser
                        D77F, 0160,0047, 0002, 2000,0000, 0002,0000, ; Sciser
                        D77F, 0097,07A0, 0000, 2800,0000, 0001,0000, ; Sciser
                        FFFF, 0C

; Room $D433. Sandy Maridia quicksand top
$A1:DF30             dw E7BF, 00B0,00F0, 0000, 2000,0000, 0040,0001, ; Yapping maw
                        DA7F, 0080,00DC, 0000, 6100,0000, 0000,0000, ; Zoa
                        E7BF, 004D,00F0, 0000, 2000,0000, 0040,0001, ; Yapping maw
                        FFFF, 01

; Room $D51E. Snail room quicksand items east
$A1:DF63             dw DFBF, 0190,00A0, 0072, 2800,0000, 0200,7204, ; Boulder
                        DFBF, 0150,00C0, 0098, 2800,0000, 0200,A204, ; Boulder
                        DFBF, 00D0,00D0, 00C0, 2800,0000, 0200,A204, ; Boulder
                        FFFF, 00

; Room $D4EF. Snail room quicksand items west
$A1:DF96             dw DFBF, 01D0,0090, 0050, 2800,0000, 0200,6204, ; Boulder
                        DFBF, 00B0,0140, 0080, 2800,0000, 0200,A004, ; Boulder
                        DFBF, 00F0,0160, 00F0, 2800,0000, 0200,F004, ; Boulder
                        DFBF, 0030,0090, 0040, 2800,0000, 0200,5204, ; Boulder
                        FFFF, 00

; Room $D9FE. Maridia cacatac room west
$A1:DFD9             dw CFFF, 0048,00B4, 0000, 2000,0000, 0101,0000, ; Cacatac
                        CFFF, 00B0,0134, 0000, 2000,0000, 0101,0000, ; Cacatac
                        CFFF, 0068,01B4, 0000, 2000,0000, 0100,0000, ; Cacatac
                        CFFF, 00A0,004A, 0000, 2000,0000, 0000,0000, ; Cacatac
                        FFFF, 04

; Room $DA2B. Maridia cacatac room east
$A1:E01C             dw CFFF, 0180,0094, 0000, 2000,0000, 0101,0000, ; Cacatac
                        CFFF, 0290,00A4, 0000, 2000,0000, 0100,0000, ; Cacatac
                        CFFF, 0390,0104, 0000, 2000,0000, 0101,0000, ; Cacatac
                        CFFF, 02D0,01B4, 0000, 2000,0000, 0100,0000, ; Cacatac
                        CFFF, 00F0,015A, 0000, 2000,0000, 0001,0000, ; Cacatac
                        CFFF, 02D0,016A, 0000, 2000,0000, 0000,0201, ; Cacatac
                        FFFF, 06

; Room $D017. Maridia space pirate room
$A1:E07F             dw D6FF, 0070,0098, 0000, 2800,0000, 0110,0210, ; Skultera
                        D6FF, 00B8,02A8, 0000, 2000,0000, 0010,0210, ; Skultera
                        D6FF, 0190,00F0, 0000, 2800,0000, 0010,0210, ; Skultera
                        F753, 01A8,02A0, 0000, 2000,0004, 8000,0018, ; Magenta walking space pirate
                        F753, 0190,0140, 0000, 2000,0004, 8001,0008, ; Magenta walking space pirate
                        F753, 02A0,00D0, 0000, 2000,0004, 8000,0008, ; Magenta walking space pirate
                        F753, 0378,01B0, 0000, 2000,0004, 8001,0028, ; Magenta walking space pirate
                        D6FF, 0368,00B8, 0000, 2000,0000, 0010,0210, ; Skultera
                        FFFF, 08

; Room $DEDE. Escape room 4
$A1:E102             dw F493, 002B,04D0, 0000, 2000,0004, 0000,0084, ; Silver wall space pirate
                        F493, 00B2,0428, 0000, 2000,0004, 0001,0084, ; Silver wall space pirate
                        F493, 002B,0308, 0000, 2000,0004, 0000,0084, ; Silver wall space pirate
                        F493, 00B2,0278, 0000, 2000,0004, 0001,0084, ; Silver wall space pirate
                        F493, 002B,01E8, 0000, 2000,0004, 0000,0084, ; Silver wall space pirate
                        F493, 00B2,0158, 0000, 2000,0004, 0001,0084, ; Silver wall space pirate
                        F793, 0270,0180, 0000, 2000,0004, 0000,0020, ; Silver walking space pirate
                        F793, 01D0,0180, 0000, 2000,0004, 0000,0020, ; Silver walking space pirate
                        F793, 01C8,02D0, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        F793, 0140,0200, 0000, 2000,0004, 0000,0020, ; Silver walking space pirate
                        F793, 01B8,03B0, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        F793, 0168,0500, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        F793, 0278,0450, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        FFFF, 0D

; Room $DE23. Mother Brain save station
$A1:E1D5             dw FFFF, 00

; Room $DAE1, state $DAF3. Metroid room 1 - default
$A1:E1D8             dw DD7F, 010C,006A, 0000, 2000,0000, 0000,0005, ; Metroid
                        DD7F, 027D,0074, 0000, 2000,0000, 0000,0005, ; Metroid
                        DD7F, 036D,0092, 0000, 2000,0000, 0000,0005, ; Metroid
                        DD7F, 04AD,008C, 0000, 2000,0000, 0000,0005, ; Metroid
                        D23F, 0028,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0218,00D8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0498,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0468,00D8, 0000, 6000,0000, 0000,0000, ; Rinka
                        FFFF, 04

; Room $DC65. Torizo corpse room
$A1:E25B             dw ED3F, 0120,0094, 0000, 2800,0000, 0000,0000, ; Torizo corpse
                        FFFF, 00

; Room $DCB1. Shitroid room
$A1:E26E             dw EEBF, 0180,0040, 0000, 2800,0000, 0000,0000, ; Shitroid
                        ED7F, 0228,00A0, 0000, A000,0000, 0000,0000, ; Sidehopper corpse
                        ED7F, 00A0,0040, 0000, A000,0000, 0002,0000, ; Sidehopper corpse
                        EDFF, 00F0,0040, 0000, A000,0000, 0000,0000, ; Zoomer corpse
                        EDFF, 0298,00C8, 0000, A000,0000, 0002,0000, ; Zoomer corpse
                        EDFF, 0108,0036, 0000, A000,0000, 0004,0000, ; Zoomer corpse
                        EE3F, 0320,00A8, 0000, A000,0000, 0000,0000, ; Ripper corpse
                        EE3F, 00C2,00C8, 0000, A000,0000, 0002,0000, ; Ripper corpse
                        EE7F, 0380,0047, 0000, A000,0000, 0000,0000, ; Skree corpse
                        EE7F, 0260,0047, 0000, A000,0000, 0002,0000, ; Skree corpse
                        EE7F, 0180,0047, 0000, A000,0000, 0004,0000, ; Skree corpse
                        FFFF, 00

; Room $DD58, state $DD6E. Mother Brain - default
; Room $DD58, state $DD88. Mother Brain - event "Mother Brain's glass is broken" is set
$A1:E321             dw EC7F, 0081,006F, 0000, 2800,0004, 0000,0000, ; Mother Brain body
                        EC3F, 0081,006F, 0000, 2800,0004, 0000,0000, ; Mother Brain brain
                        E27F, 0000,0000, 0000, 2000,0000, 0000,0000, ; Zebetites
                        D23F, 0337,0036, 0000, 6000,0000, 0001,0000, ; Rinka
                        D23F, 0337,00A6, 0000, 6000,0000, 0002,0000, ; Rinka
                        D23F, 0277,001C, 0000, 6000,0000, 0003,0000, ; Rinka
                        FFFF, 00

; Room $DDC4. Tourian eye-door room
$A1:E384             dw FFFF, 00

; Room $DC19. Tourian super-sidehopper room
$A1:E387             dw D9FF, 00F8,0061, 0000, 2000,0000, 8000,0000, ; Tourian super-sidehopper
                        D9FF, 0086,00A9, 0000, 2000,0000, 0000,0000, ; Tourian super-sidehopper
                        FFFF, 02

; Room $DE4D. Escape room 1
$A1:E3AA             dw D5BF, 01B8,0040, 0108, A800,FF00, 2000,0010, ; Destroyable timed shutter
                        D5BF, 01B8,00C0, 0008, A800,00FF, 2000,0010, ; Destroyable timed shutter
                        D5BF, 0168,0040, 0108, A800,FF00, 2000,0010, ; Destroyable timed shutter
                        D5BF, 0168,00C0, 0008, A800,00FF, 2000,0010, ; Destroyable timed shutter
                        D5BF, 0118,0040, 0108, A800,FF00, 2000,0018, ; Destroyable timed shutter
                        D5BF, 0118,00C0, 0008, A800,00FF, 2000,0018, ; Destroyable timed shutter
                        D5BF, 00C8,0040, 0108, A800,FF00, 2000,0020, ; Destroyable timed shutter
                        D5BF, 00C8,00C0, 0008, A800,00FF, 2000,0020, ; Destroyable timed shutter
                        FFFF, 00

; Room $DAAE. Tourian -> Crateria elevator
$A1:E42D             dw D73F, 0080,02C2, 0000, 2C00,0000, 0001,0018, ; Elevator
                        FFFF, 00

; Room $DB31, state $DB43. Metroid room 2 - default
$A1:E440             dw DD7F, 0098,0115, 0000, 2000,0000, 0000,0005, ; Metroid
                        D23F, 0098,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 00D8,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 00D8,01B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0008,0148, 0000, 6000,0000, 0000,0000, ; Rinka
                        DD7F, 0056,018A, 0000, 2000,0000, 0000,0005, ; Metroid
                        FFFF, 02

; Room $DBCD, state $DBDF. Metroid room 4 - default
$A1:E4A3             dw DD7F, 00C4,0152, 0000, 2000,0000, 0000,0005, ; Metroid
                        DD7F, 003E,00FB, 0000, 2000,0000, 0000,0005, ; Metroid
                        D23F, 0098,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0098,0188, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0068,0128, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 00F8,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        DD7F, 0046,01BE, 0000, 2000,0000, 0000,0005, ; Metroid
                        FFFF, 03

; Room $DAE1, state $DB0D. Metroid room 1 - event "1st metroid hall cleared" is set
$A1:E516             dw D23F, 0028,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0218,00D8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0498,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0468,00D8, 0000, 6000,0000, 0000,0000, ; Rinka
                        FFFF, 00

; Room $DB31, state $DB5D. Metroid room 2 - event "1st metroid shaft cleared" is set
$A1:E559             dw D23F, 0098,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 00D8,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 00D8,01B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0008,0148, 0000, 6000,0000, 0000,0000, ; Rinka
                        FFFF, 00

; Room $DE7A. Escape room 2
$A1:E59C             dw F493, 002B,00D8, 0000, 2000,0004, 0000,00A0, ; Silver wall space pirate
                        F493, 00D0,0128, 0000, 2000,0004, 0001,00A0, ; Silver wall space pirate
                        FFFF, 02

; Room $DB7D, state $DBA9. Metroid room 3 - event "2nd metroid hall cleared" is set
$A1:E5BF             dw D23F, 0108,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0018,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0028,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 00E8,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 01B8,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0268,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0268,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 05D8,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 05B8,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        FFFF, 00

; Room $DBCD, state $DBF9. Metroid room 4 - event "2nd metroid shaft cleared" is set
$A1:E652             dw D23F, 0098,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0098,0188, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0068,0128, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 00F8,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        FFFF, 00

; Room $DEA7. Escape room 3
$A1:E695             dw F793, 00C0,0160, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        F793, 0538,0160, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        F793, 0488,0160, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        F793, 03D8,0160, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        F793, 0478,0050, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        F793, 04E0,0050, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        F793, 0560,0050, 0000, 2000,0004, 0000,0010, ; Silver walking space pirate
                        FFFF, 07

; Room $DCFF. Post Shitroid room
$A1:E708             dw FFFF, 00

; Room $DD2E. Tourian refill station
$A1:E70B             dw FFFF, 00

; Unused
$A1:E70E             dw EDFF, 00F0,0040, 0000, A000,0000, 0000,0000, ; Zoomer corpse
                        EDFF, 0298,00C8, 0000, A000,0000, 0002,0000, ; Zoomer corpse
                        EDFF, 0108,0036, 0000, A000,0000, 0004,0000, ; Zoomer corpse
                        EE3F, 0320,00A8, 0000, A000,0000, 0000,0000, ; Ripper corpse
                        EE3F, 00C2,00C8, 0000, A000,0000, 0002,0000, ; Ripper corpse
                        EE7F, 0380,0047, 0000, A000,0000, 0000,0000, ; Skree corpse
                        EE7F, 0260,0047, 0000, A000,0000, 0002,0000, ; Skree corpse
                        EE7F, 0180,0047, 0000, A000,0000, 0004,0000, ; Skree corpse
                        FFFF, 00

; Room $DF1B. Tourian elevator save station
$A1:E791             dw FFFF, 00

; Room $DB7D, state $DB8F. Metroid room 3 - default
$A1:E794             dw DD7F, 018A,0081, 0000, 2000,0000, 0000,0005, ; Metroid
                        DD7F, 0367,0077, 0000, 2000,0000, 0000,0005, ; Metroid
                        DD7F, 046A,0073, 0000, 2000,0000, 0000,0005, ; Metroid
                        D23F, 0108,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0018,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0028,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 00E8,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 01B8,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0268,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0268,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 05D8,0048, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 05B8,00B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        FFFF, 03

; Room $DDF3. Pre Mother Brain shaft
$A1:E857             dw D23F, 00E8,01B8, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 00E8,0208, 0000, 6000,0000, 0000,0000, ; Rinka
                        D23F, 0008,0248, 0000, 6000,0000, 0000,0000, ; Rinka
                        FFFF, 00

; Room $DF45, state $DF57. Ceres elevator shaft - default
$A1:E88A             dw E23F, 00E8,0277, 0002, A800,0000, 0002,0000, ; Ceres door
                        E23F, 00E0,027F, 0001, A800,0000, 0001,0000, ; Ceres door
                        FFFF, 00

; Room $DF8D, state $DF9F. Ceres pre elevator hall - default
$A1:E8AD             dw E23F, 0020,007F, 0000, A800,0000, 0000,0000, ; Ceres door
                        E23F, 01E0,007F, 0001, A800,0000, 0001,0000, ; Ceres door
                        FFFF, 00

; Room $DFD7, state $DFE9. Ceres stairs - default
$A1:E8D0             dw E23F, 0020,007F, 0000, A800,0000, 0000,0000, ; Ceres door
                        E23F, 00E0,017F, 0001, A800,0000, 0001,0000, ; Ceres door
                        FFFF, 00

; Room $E021, state $E033. Ceres baby metroid hall - default
$A1:E8F3             dw E23F, 0020,007F, 0000, A800,0000, 0000,0000, ; Ceres door
                        E23F, 01E0,007F, 0001, A800,0000, 0001,0000, ; Ceres door
                        FFFF, 00

; Room $E06B, state $E07D. Pre Ceres Ridley hall - default
$A1:E916             dw E23F, 0020,007F, 0000, A800,0000, 0000,0000, ; Ceres door
                        E23F, 01E0,007F, 0001, A800,0000, 0001,0000, ; Ceres door
                        FFFF, 00

; Room $E0B5, state $E0C7. Ceres Ridley - default
$A1:E939             dw E13F, 00BA,00AB, 0000, 2800,0000, 0000,0000, ; Ceres Ridley
                        E23F, 0010,007F, 0003, A800,0000, 0003,0000, ; Ceres door
                        FFFF, 00

; Room $DF45, state $DF71. Ceres elevator shaft - main area boss is dead
$A1:E95C             dw E23F, 00E8,0277, 0002, A800,0000, 0002,0000, ; Ceres door
                        E23F, 00E0,027F, 0004, A800,0000, 0004,0000, ; Ceres door
                        E1FF, 005E,006C, 0000, 2000,0000, 0004,0000, ; Ceres steam
                        E1FF, 00A2,006C, 0000, 2000,0000, 0005,0000, ; Ceres steam
                        E1FF, 009E,00C8, 0000, 2000,0000, 0004,0000, ; Ceres steam
                        E1FF, 0062,00C8, 0000, 2000,0000, 0005,0000, ; Ceres steam
                        E1FF, 005E,0128, 0000, 2000,0000, 0004,0000, ; Ceres steam
                        E1FF, 00A2,0128, 0000, 2000,0000, 0005,0000, ; Ceres steam
                        E1FF, 009E,0188, 0000, 2000,0000, 0004,0000, ; Ceres steam
                        E1FF, 0062,0198, 0000, 2000,0000, 0005,0000, ; Ceres steam
                        E1FF, 005E,01F8, 0000, 2000,0000, 0004,0000, ; Ceres steam
                        E1FF, 00A2,01F8, 0000, 2000,0000, 0005,0000, ; Ceres steam
                        E1FF, 0072,0258, 0000, 2000,0000, 0005,0000, ; Ceres steam
                        FFFF, 00

; Room $DF8D, state $DFB9. Ceres pre elevator hall - main area boss is dead
$A1:EA2F             dw E1FF, 00A0,00CC, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 00E0,00BC, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0120,00BC, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 0160,00CC, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 01B8,00A8, 0000, 2000,0000, 0001,0000, ; Ceres steam
                        E1FF, 0080,0042, 0000, 2000,0000, 0002,0000, ; Ceres steam
                        E1FF, 00C0,0042, 0000, 2000,0000, 0002,0000, ; Ceres steam
                        E1FF, 0100,0042, 0000, 2000,0000, 0002,0000, ; Ceres steam
                        E1FF, 0140,0042, 0000, 2000,0000, 0002,0000, ; Ceres steam
                        E1FF, 0180,0042, 0000, 2000,0000, 0002,0000, ; Ceres steam
                        E1FF, 0048,00A8, 0000, 2000,0000, 0003,0000, ; Ceres steam
                        E23F, 0020,007F, 0000, A800,0000, 0000,0000, ; Ceres door
                        E23F, 01E0,007F, 0001, A800,0000, 0001,0000, ; Ceres door
                        FFFF, 00

; Room $DFD7, state $E003. Ceres stairs - main area boss is dead
$A1:EB02             dw E23F, 0020,007F, 0000, A800,0000, 0000,0000, ; Ceres door
                        E23F, 00E0,017F, 0001, A800,0000, 0001,0000, ; Ceres door
                        E1FF, 0070,009C, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 00C2,00B0, 0000, 2000,0000, 0003,0000, ; Ceres steam
                        E1FF, 0078,0116, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        E1FF, 003E,0130, 0000, 2000,0000, 0001,0000, ; Ceres steam
                        E1FF, 0088,0194, 0000, 2000,0000, 0000,0000, ; Ceres steam
                        FFFF, 00

; Room $E021, state $E04D. Ceres baby metroid hall - main area boss is dead
$A1:EB75             dw E23F, 0020,007F, 0000, A800,0000, 0000,0000, ; Ceres door
                        E23F, 01E0,007F, 0001, A800,0000, 0001,0000, ; Ceres door
                        FFFF, 00

; Room $E06B, state $E097. Pre Ceres Ridley hall - main area boss is dead
$A1:EB98             dw E23F, 0020,007F, 0000, A800,0000, 0000,0000, ; Ceres door
                        E23F, 01E0,007F, 0001, A800,0000, 0001,0000, ; Ceres door
                        FFFF, 00

; Room $E0B5, state $E0E1. Ceres Ridley - main area boss is dead
$A1:EBBB             dw E23F, 0010,007F, 0003, A800,0000, 0003,0000, ; Ceres door
                        FFFF, 00

; Room $E82C. Debug room
$A1:EBCE             dw FFFF, 00
}


;;; $EBD1: Free space ;;;
{
$A1:EBD1             fillto $A28000, $FF
}
