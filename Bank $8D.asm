;;; $8000: Enemy projectile spritemaps ;;;
{
; See $81:8A5F for spritemap format

; Blank spritemap (default)
$8D:8000             dx 0000, 0000,00,00DF

; Enemy projectile $B743 (eye door projectile)
$8D:8007             dx 0001, C3F8,F8,2A76
$8D:800E             dx 0001, C3F8,F8,2A78
$8D:8015             dx 0001, C3F8,F8,2A98
$8D:801C             dx 0001, C3F8,F8,2A9E

; Enemy projectile $8BC2/$8BD0/$8BDE/$8BEC (skree particle)
$8D:8023             dx 0001, 01FC,FC,2115

; Enemy projectile $8F8F (Crocomire's projectile)
$8D:802A             dx 0004, 0000,F8,70D0, 0000,00,F0D0, 01F8,00,B0D0, 01F8,F8,30D0
$8D:8040             dx 0004, 0000,F8,70D1, 0000,00,F0D1, 01F8,00,B0D1, 01F8,F8,30D1
$8D:8056             dx 0004, 0000,00,F0D2, 0000,F8,70D2, 01F8,00,B0D2, 01F8,F8,30D2
$8D:806C             dx 0004, 0000,00,F0D3, 0000,F8,70D3, 01F8,00,B0D3, 01F8,F8,30D3

; Unused. Instruction list $8FC3
$8D:8082             dx 0004, 0000,00,E3C2, 01F8,00,A3C2, 0000,F8,63C2, 01F8,F8,23C2
$8D:8098             dx 0004, 0000,F8,63D2, 0000,00,E3D2, 01F8,00,A3D2, 01F8,F8,23D2

; Unused. Instruction list $958C
$8D:80AE             dx 0001, 01F8,F8,3177
$8D:80B5             dx 0001, 01F8,F8,F17B
$8D:80BC             dx 0001, 01F8,F8,F177
$8D:80C3             dx 0001, 01F8,F8,317B

; Enemy projectile $9634/$9642 (Ridley's fireball)
$8D:80CA             dx 0001, C3F8,F8,31C8
$8D:80D1             dx 0001, C3F8,F8,F1CA
$8D:80D8             dx 0001, C3F8,F8,F1C8
$8D:80DF             dx 0001, C3F8,F8,31CA

; Enemy projectile $9650/$965E/$966C/$967A/$9688/$9696 (Ridley's fireball / Mother Brain's bomb explosion)
$8D:80E6             dx 0001, 01FC,FC,3A5F
$8D:80ED             dx 0001, C3F8,F7,3A76
$8D:80F4             dx 0001, C3F8,F6,3A78
$8D:80FB             dx 0001, C3F8,F5,3A98
$8D:8102             dx 0001, C3F8,F4,3A9E

; Enemy projectile $8F9D (Crocomire bridge crumbling)
$8D:8109             dx 0001, C3FC,FC,21CC

; Enemy projectile $90C1 (Crocomire spike wall pieces)
$8D:8110             dx 0002, C208,F8,27EE, C3F8,F8,65CC

; Unused
$8D:811C             dx 0004, 0000,00,21F1, 01F8,00,21F0, 0000,F8,21E1, 01F8,F8,21E0

; Unused. Instruction list $8FFB
$8D:8132             dx 0002, 0000,10,61E0, 01F8,10,21E0
$8D:813E             dx 0006, 0004,08,61DB, 0004,00,61CB, 01FC,08,21DC, 01F4,08,21DB, 01FC,00,21CC, 01F4,00,21CB
$8D:815E             dx 000C, 0000,F0,61DF, 0008,F0,61CF, 0000,00,61DE, 0008,00,61DD, 0000,F8,61CE, 0008,F8,61CD, 01F8,F0,21DF, 01F0,F0,21CF, 01F8,00,21DE, 01F0,00,21DD, 01F8,F8,21CE, 01F0,F8,21CD

; Enemy projectile $9C29 (Phantoon destroyable flames) / enemy projectile $9C37 (Phantoon starting flames)
$8D:819C             dx 0002, C3F8,00,3F06, C3F8,F0,3F00
$8D:81A8             dx 0002, C3F8,00,3F08, C3F8,F0,3F02
$8D:81B4             dx 0002, C3F8,00,3F0A, C3F8,F0,3F04
$8D:81C0             dx 0002, C200,F8,3F0E, C3F0,F8,3F0C
$8D:81CC             dx 0002, C3F8,FE,3F28, C3F8,EE,3F20
$8D:81D8             dx 0002, C3F8,FC,3F2A, C3F8,EC,3F22
$8D:81E4             dx 0002, C3F8,FA,3F2C, C3F8,EA,3F24
$8D:81F0             dx 0002, C3F8,F8,3F2E, C3F8,E8,3F26
$8D:81FC             dx 0002, C3F8,F0,3F00, C3F8,00,3F40
$8D:8208             dx 0002, C3F8,F0,3F02, C3F8,00,3F42
$8D:8214             dx 0002, C3F8,F0,3F04, C3F8,00,3F44

; Enemy projectile $9C37 (Phantoon starting flames)
$8D:8220             dx 0002, C3F8,00,3F46, C3F8,F0,3F00
$8D:822C             dx 0002, C3F8,00,3F48, C3F8,F0,3F02
$8D:8238             dx 0002, C3F8,00,3F4A, C3F8,F0,3F04
$8D:8244             dx 0002, C3F8,00,3F4C, C3F8,F0,3F00
$8D:8250             dx 0002, C3F8,00,3F4E, C3F8,F0,3F02
$8D:825C             dx 0002, C3F8,00,3F4A, C3F8,F0,3F04

; Enemy projectile $9C45/$9C53/$9C61/$D02E (Kraid rocks / Kago's bugs)
$8D:8268             dx 0001, 81F8,F8,31D0

; Enemy projectile $9C6F (rocks when Kraid rises - right)
$8D:826F             dx 0001, 01FC,FC,31D2

; Enemy projectile $CB4B (Mother Brain's blue ring lasers)
$8D:8276             dx 0001, 01FC,FC,35AD
$8D:827D             dx 0001, C3F8,F8,35A7
$8D:8284             dx 0004, C3FB,FB,F5A9, C3F5,FB,B5A9, C3FB,F5,75A9, C3F5,F5,35A9
$8D:829A             dx 0004, C3FC,FC,F5A9, C3F4,FC,B5A9, C3FC,F4,75A9, C3F4,F4,35A9
$8D:82B0             dx 0004, C3FF,FF,F5AB, C3F1,FF,B5AB, C3FF,F1,75AB, C3F1,F1,35AB
$8D:82C6             dx 0004, C200,00,F5AB, C3F0,00,B5AB, C200,F0,75AB, C3F0,F0,35AB

; Enemy projectile $CB59 (Mother Brain's bomb)
$8D:82DC             dx 0002, C3F8,F8,35CE, 01FC,FC,35AE
$8D:82E8             dx 0002, C3F8,F8,35CE, 01FC,FC,35AF
$8D:82F4             dx 0002, C3F8,F8,35CE, 01FC,FC,35BD
$8D:8300             dx 0002, C3F8,F8,35CE, 01FC,FC,35BE
$8D:830C             dx 0002, C3F8,F8,35CE, 01FC,FC,35BF
$8D:8318             dx 0002, C3F8,F8,35CE, 01FC,FC,75BF
$8D:8324             dx 0002, C3F8,F8,35CE, 01FC,FC,75BE
$8D:8330             dx 0002, C3F8,F8,35CE, 01FC,FC,75BD
$8D:833C             dx 0002, C3F8,F8,35CE, 01FC,FC,75AF

; Unused
$8D:8348             dx 0001, 01FC,FC,35E0
$8D:834F             dx 0001, 01FC,FC,35E1
$8D:8356             dx 0001, 01FC,FC,35E2

; Enemy projectile $CB67/$CB75 (Mother Brain's death beam)
$8D:835D             dx 0001, 01FC,FC,35E3
$8D:8364             dx 0001, C3F8,F8,35E4
$8D:836B             dx 0001, C3F8,F8,35E6
$8D:8372             dx 0001, C3F8,F8,35E8
$8D:8379             dx 0001, C3F8,F8,35EA
$8D:8380             dx 0001, C3F8,F8,35EC
$8D:8387             dx 0001, C3F8,F8,35EE

; Enemy projectile $CC5B (Mother Brain's top-right tube falling)
$8D:838E             dx 0004, C3FC,E8,AF5E, 0000,F8,2F51, 01F8,F8,2F50, C3F8,00,EF42

; Enemy projectile $CC69 (Mother Brain's top-left tube falling)
$8D:83A4             dx 0004, C3F4,E8,EF5E, 01F8,F8,6F51, 0000,F8,6F50, C3F8,00,AF42

; Enemy projectile $CC77 (Mother Brain's top-middle-left tube falling)
$8D:83BA             dx 0007, C3FA,DC,AF5E, C3F8,1C,2F5E, C3F8,14,2F4E, C3F8,04,AF40, C3F8,F4,2F4B, 0000,EC,2F6D, 01F8,EC,2F6D

; Enemy projectile $CC85 (Mother Brain's top-middle-right tube falling)
$8D:83DF             dx 0007, C3F6,DC,EF5E, C3F8,1C,6F5E, C3F8,14,6F4E, C3F8,04,EF40, C3F8,F4,2F4B, 01F8,EC,6F6D, 0000,EC,6F6D

; Enemy projectile $9E90 (alcoon fireball)
$8D:8404             dx 0001, 01FC,FC,212C
$8D:840B             dx 0001, 01FC,FC,A12D
$8D:8412             dx 0001, 01FC,FC,E12C
$8D:8419             dx 0001, 01FC,FC,612D

; Enemy projectile $9DB0 (fake Kraid spit)
$8D:8420             dx 0001, 01FD,FD,231F

; Enemy projectile $9DBE (fake Kraid spikes - left)
$8D:8427             dx 0001, 01FC,FC,230F

; Enemy projectile $9DCC (fake Kraid spikes - right)
$8D:842E             dx 0001, 01FC,FC,630F

; Enemy projectile $8BFA/$8C08/$8C16/$8C24 (metaree particle)
$8D:8435             dx 0001, 01FC,FC,312B

; Unused
$8D:843C             dx 0001, C3F8,F8,3A7C
$8D:8443             dx 0001, C3F8,F6,3A7E
$8D:844A             dx 0001, C3F8,F4,3A9A
$8D:8451             dx 0001, C3F8,F2,3A9C

; Enemy projectile $D02E (Kago's bugs)
$8D:8458             dx 0001, 01FC,FC,2128
$8D:845F             dx 0001, 01FC,FC,2129
$8D:8466             dx 0001, 01FC,FC,212A

; Enemy projectile $A395 (Ceres elevator pad level data concealer)
$8D:846D             dx 0004, 0008,FC,3A20, 0000,FC,3A20, 01F8,FC,3A20, 01F0,FC,3A20

; Enemy projectile $A379 (gunship liftoff dust clouds)
$8D:8483             dx 0001, C3F8,F8,3B68
$8D:848A             dx 0003, C202,EE,3B68, C3F2,E6,3B68, C3FA,F6,3B6A
$8D:849B             dx 0004, C204,E4,3B68, C3F4,E3,3B6A, C204,EB,3B6A, C3FC,F3,3B6C
$8D:84B1             dx 0005, C3FE,D6,3B68, C206,E2,3B6A, C3F6,E0,3B6C, C206,E8,3B6C, C3FE,F0,3B6E
$8D:84CC             dx 0005, C200,D4,3B6A, C208,E0,3B6C, C208,E5,3B6E, C3F8,DD,3B6E, C200,ED,3BE4
$8D:84E7             dx 0004, C202,D2,3B6C, C20A,DE,3B6E, C20A,E2,3BE4, C3FA,DA,3BE4
$8D:84FD             dx 0002, C204,D0,3B6E, C20C,DC,3BE4
$8D:8509             dx 0001, C206,CE,3BE4
$8D:8510             dx 0001, C3F8,F8,3BC4
$8D:8517             dx 0003, C3FA,F6,3BC6, C202,EE,3BC4, C3F2,E6,3BC4
$8D:8528             dx 0004, C3FC,F4,3BC8, C204,EC,3BC6, C3F4,E4,3BC6, C204,E4,3BC4
$8D:853E             dx 0005, C3FE,F2,3BCA, C3F6,E2,3BC8, C206,E2,3BC6, C3FE,D6,3BC4, C206,EA,3B6C
$8D:8559             dx 0005, C200,F0,3BCC, C208,E8,3BCA, C3F8,E0,3BCA, C208,E0,3BC8, C200,D4,3BC6
$8D:8574             dx 0004, C3FA,DE,3BCC, C20A,E6,3BCC, C20A,DE,3BCA, C202,D2,3BC8
$8D:858A             dx 0002, C20C,DC,3BCC, C204,D0,3BCA
$8D:8596             dx 0001, C206,CE,3BCC
$8D:859D             dx 0006, 01FC,04,3BA1, 01F4,04,3BA0, 0004,04,3BA2, 0004,FC,3B92, 0004,F4,3B82, C3F4,F4,3B80
$8D:85BD             dx 000A, 01F0,F2,3BA1, 01E8,F2,3BA0, 01F8,F2,3BA2, 01F8,EA,3B92, 01F8,E2,3B82, C3E8,E2,3B80, C204,FE,3BA5, C3F4,FE,3BA3, C204,EE,3B85, C3F4,EE,3B83
$8D:85F1             dx 000E, 0014,F8,3BA1, 000C,F8,3BA0, 001C,F8,3BA2, 001C,F0,3B92, 001C,E8,3B82, C20C,E8,3B80, C3F8,EC,3BA5, C3E8,EC,3BA3, C3F8,DC,3B85, C3E8,DC,3B83, C208,FC,3BA9, C3F8,FC,3BA7, C208,EC,3B89, C3F8,EC,3B87
$8D:8639             dx 000C, C3FC,EA,3BA9, C3EC,EA,3BA7, C3FC,DA,3B89, C3EC,DA,3B87, C21C,F2,3BA5, C20C,F2,3BA3, C21C,E2,3B85, C20C,E2,3B83, C20C,FA,3BAD, C3FC,FA,3BAB, C20C,EA,3B8D, C3FC,EA,3B8B
$8D:8677             dx 000C, C220,F0,3BA9, C210,F0,3BA7, C220,E0,3B89, C210,E0,3B87, C200,E8,3BAD, C3F0,E8,3BAB, C200,D8,3B8D, C3F0,D8,3B8B, C210,F8,3BE2, C200,F8,3BE0, C210,E8,3BC2, C200,E8,3BC0
$8D:86B5             dx 0008, C204,E6,3BE2, C3F4,E6,3BE0, C204,D6,3BC2, C3F4,D6,3BC0, C224,EE,3BAD, C214,EE,3BAB, C224,DE,3B8D, C214,DE,3B8B
$8D:86DF             dx 0004, C228,EC,3BE2, C218,EC,3BE0, C228,DC,3BC2, C218,DC,3BC0
$8D:86F5             dx 0001, C3F8,F8,7B68
$8D:86FC             dx 0003, C3EE,EE,7B68, C3FE,E6,7B68, C3F6,F6,7B6A
$8D:870D             dx 0004, C3EC,E4,7B68, C3FC,E3,7B6A, C3EC,EB,7B6A, C3F4,F3,7B6C
$8D:8723             dx 0005, C3F2,D6,7B68, C3EA,E2,7B6A, C3FA,E0,7B6C, C3EA,E8,7B6C, C3F2,F0,7B6E
$8D:873E             dx 0005, C3F0,D4,7B6A, C3E8,E0,7B6C, C3E8,E5,7B6E, C3F8,DD,7B6E, C3F0,ED,7BE4
$8D:8759             dx 0004, C3EE,D2,7B6C, C3E6,DE,7B6E, C3E6,E2,7BE4, C3F6,DA,7BE4
$8D:876F             dx 0002, C3EC,D0,7B6E, C3E4,DC,7BE4
$8D:877B             dx 0001, C3EA,CE,7BE4
$8D:8782             dx 0001, C3F8,F8,7BC4
$8D:8789             dx 0003, C3F6,F6,7BC6, C3EE,EE,7BC4, C3FE,E6,7BC4
$8D:879A             dx 0004, C3F4,F4,7BC8, C3EC,EC,7BC6, C3FC,E4,7BC6, C3EC,E4,7BC4
$8D:87B0             dx 0005, C3F2,F2,7BCA, C3FA,E2,7BC8, C3EA,E2,7BC6, C3F2,D6,7BC4, C3EA,EA,7B6C
$8D:87CB             dx 0005, C3F0,F0,7BCC, C3E8,E8,7BCA, C3F8,E0,7BCA, C3E8,E0,7BC8, C3F0,D4,7BC6
$8D:87E6             dx 0004, C3F6,DE,7BCC, C3E6,E6,7BCC, C3E6,DE,7BCA, C3EE,D2,7BC8
$8D:87FC             dx 0002, C3E4,DC,7BCC, C3EC,D0,7BCA
$8D:8808             dx 0001, C3EA,CE,7BCC
$8D:880F             dx 0006, 01FC,04,7BA1, 0004,04,7BA0, 01F4,04,7BA2, 01F4,FC,7B92, 01F4,F4,7B82, C3FC,F4,7B80
$8D:882F             dx 000A, 0008,F2,7BA1, 0010,F2,7BA0, 0000,F2,7BA2, 0000,EA,7B92, 0000,E2,7B82, C208,E2,7B80, C3EC,FE,7BA5, C3FC,FE,7BA3, C3EC,EE,7B85, C3FC,EE,7B83
$8D:8863             dx 000E, 01E4,F8,7BA1, 01EC,F8,7BA0, 01DC,F8,7BA2, 01DC,F0,7B92, 01DC,E8,7B82, C3E4,E8,7B80, C3F8,EC,7BA5, C208,EC,7BA3, C3F8,DC,7B85, C208,DC,7B83, C3E8,FC,7BA9, C3F8,FC,7BA7, C3E8,EC,7B89, C3F8,EC,7B87
$8D:88AB             dx 000C, C3F4,EA,7BA9, C204,EA,7BA7, C3F4,DA,7B89, C204,DA,7B87, C3D4,F2,7BA5, C3E4,F2,7BA3, C3D4,E2,7B85, C3E4,E2,7B83, C3E4,FA,7BAD, C3F4,FA,7BAB, C3E4,EA,7B8D, C3F4,EA,7B8B
$8D:88E9             dx 000C, C3D0,F0,7BA9, C3E0,F0,7BA7, C3D0,E0,7B89, C3E0,E0,7B87, C3F0,E8,7BAD, C200,E8,7BAB, C3F0,D8,7B8D, C200,D8,7B8B, C3E0,F8,7BE2, C3F0,F8,7BE0, C3E0,E8,7BC2, C3F0,E8,7BC0
$8D:8927             dx 0008, C3EC,E6,7BE2, C3FC,E6,7BE0, C3EC,D6,7BC2, C3FC,D6,7BC0, C3CC,EE,7BAD, C3DC,EE,7BAB, C3CC,DE,7B8D, C3DC,DE,7B8B
$8D:8951             dx 0004, C3C8,EC,7BE2, C3D8,EC,7BE0, C3C8,DC,7BC2, C3D8,DC,7BC0

; Enemy projectile $8E6C (unused. Uses unused evir tiles)
$8D:8967             dx 0001, 01FC,FC,3100
$8D:896E             dx 0001, 01FC,FC,3101
$8D:8975             dx 0001, 01FC,FC,3102

; Unused. Instruction list $8EF3
$8D:897C             dx 0001, 01FC,FC,3103
$8D:8983             dx 0001, 01FC,FC,3104
$8D:898A             dx 0001, 01FC,FC,3105

; Unused. Instruction list $8F07
$8D:8991             dx 0001, 01FC,FC,3106
$8D:8998             dx 0001, 01FC,FC,3107
$8D:899F             dx 0001, 01FC,FC,3108

; Unused. Instruction list $8F1B
$8D:89A6             dx 0001, 01FC,FC,B103
$8D:89AD             dx 0001, 01FC,FC,B104
$8D:89B4             dx 0001, 01FC,FC,B105

; Unused. Instruction list $8F2F
$8D:89BB             dx 0001, 01FC,FC,B100
$8D:89C2             dx 0001, 01FC,FC,B101
$8D:89C9             dx 0001, 01FC,FC,B102

; Unused. Instruction list $8F43
$8D:89D0             dx 0001, 01FC,FC,F103
$8D:89D7             dx 0001, 01FC,FC,F104
$8D:89DE             dx 0001, 01FC,FC,F105

; Unused. Instruction list $8F57
$8D:89E5             dx 0001, 01FC,FC,7106
$8D:89EC             dx 0001, 01FC,FC,7107
$8D:89F3             dx 0001, 01FC,FC,7108

; Unused. Instruction list $8F6B
$8D:89FA             dx 0001, 01FC,FC,7103
$8D:8A01             dx 0001, 01FC,FC,7104
$8D:8A08             dx 0001, 01FC,FC,7105

; Unused. Instruction list $8C32
$8D:8A0F             dx 0001, 81F8,F8,2164

; Enemy projectile $8E50 (Draygon goop)
$8D:8A16             dx 0001, 81F8,F8,116A
$8D:8A1D             dx 0001, 81F8,F8,115E
$8D:8A24             dx 0001, 81F8,F8,115C
$8D:8A2B             dx 0001, 81F8,F8,114A

; Unused. Instruction list $8C7E
$8D:8A32             dx 0001, 01FC,FC,217E
$8D:8A39             dx 0001, 01FC,FC,217D
$8D:8A40             dx 0001, 01FC,FC,217C
$8D:8A47             dx 0001, 81F8,F8,218A
$8D:8A4E             dx 0001, 01FC,FC,217F
$8D:8A55             dx 0001, 01FC,FC,2177
$8D:8A5C             dx 0001, 01FC,FC,2176

; Unused
$8D:8A63             dx 0001, 81F8,F8,218C
$8D:8A6A             dx 0001, 81F8,F8,218E

; Enemy projectile $8E5E/$8E6C (Draygon's wall turret projectiles / ???)
$8D:8A71             dx 0001, 01FC,FC,3B7E
$8D:8A78             dx 0001, 01FC,FC,3B7D
$8D:8A7F             dx 0001, 01FC,FC,3B7C
$8D:8A86             dx 0001, 81F8,F8,3B8A

; Enemy projectile $8E50 (Draygon goop)
$8D:8A8D             dx 0001, 81F8,F8,338C
$8D:8A94             dx 0004, 0002,02,339F, 01F6,02,339E, 0002,F6,338F, 01F6,F6,338E

; Enemy projectile $8E5E/$8E6C (Draygon's wall turret projectiles / ???)
$8D:8AAA             dx 0001, 81F8,F8,3BCA
$8D:8AB1             dx 0001, 81F8,F8,3BCC
$8D:8AB8             dx 0001, 81F8,F8,3BCE

; Enemy projectile $9734 (Ceres falling debris - light coloured)
$8D:8ABF             dx 0001, C3F8,F8,20EA

; Enemy projectile $9742 (Ceres falling debris - dark coloured)
$8D:8AC6             dx 0001, C3F8,F8,20EC

; Enemy projectile $A189 (pirate claw)
$8D:8ACD             dx 0003, 0004,FC,314C, 01FC,FC,314B, 01F4,FC,314A
$8D:8ADE             dx 0002, 81FC,F8,3128, 81F4,F8,3127
$8D:8AEA             dx 0003, 01FC,F4,F14D, 01FC,FC,F13D, 01FC,04,F12D
$8D:8AFB             dx 0002, 81F4,F8,F12B, 81FC,F8,F12A
$8D:8B07             dx 0003, 01F4,FC,F14C, 01FC,FC,F14B, 0004,FC,F14A
$8D:8B18             dx 0002, 81F4,F8,F128, 81FC,F8,F127
$8D:8B24             dx 0003, 01FC,04,314D, 01FC,FC,313D, 01FC,F4,312D
$8D:8B35             dx 0002, 81FC,F8,312B, 81F4,F8,312A
$8D:8B41             dx 0003, 01F4,FC,714C, 01FC,FC,714B, 0004,FC,714A
$8D:8B52             dx 0002, 81F4,F8,7128, 81FC,F8,7127
$8D:8B5E             dx 0003, 01FC,F4,B14D, 01FC,FC,B13D, 01FC,04,B12D
$8D:8B6F             dx 0002, 81FC,F8,B12B, 81F4,F8,B12A
$8D:8B7B             dx 0003, 0004,FC,B14C, 01FC,FC,B14B, 01F4,FC,B14A
$8D:8B8C             dx 0002, 81FC,F8,B128, 81F4,F8,B127
$8D:8B98             dx 0003, 01FC,04,714D, 01FC,FC,713D, 01FC,F4,712D
$8D:8BA9             dx 0002, 81F4,F8,712B, 81FC,F8,712A

; Enemy projectile $A17B (pirate / Mother Brain laser)
$8D:8BB5             dx 0001, 01FC,FC,3A6F
$8D:8BBC             dx 0001, 01FC,FC,3A6B
$8D:8BC3             dx 0002, 0000,FC,7A6F, 01F8,FC,3A6F
$8D:8BCF             dx 0002, 0000,FC,7A6B, 01F8,FC,3A6B
$8D:8BDB             dx 0003, 0004,FC,7ACD, 01FC,FC,7A6F, 01F4,FC,3A6F
$8D:8BEC             dx 0003, 0004,FC,7A6B, 01FC,FC,3A6B, 01F4,FC,3A6B
$8D:8BFD             dx 0004, 0008,FC,7ACD, 01F0,FC,3ACD, 0000,FC,7A6F, 01F8,FC,3A6F
$8D:8C13             dx 0004, 0008,FC,FA6B, 0000,FC,FA6B, 01F8,FC,BA6B, 01F0,FC,BA6B
$8D:8C29             dx 0001, 01FC,FC,3A53
$8D:8C30             dx 0001, 01FC,FC,3A51
$8D:8C37             dx 0004, 0000,00,FA60, 0000,F8,7A60, 01F8,00,BA60, 01F8,F8,3A60

; Enemy projectile $AB07 (unused. Question mark)
$8D:8C4D             dx 0001, C3F8,F8,2AE0

; Enemy projectile $A95B/$A969 (Bomb Torizo low-health drool) / enemy projectile $A977 (spawned by unused PLM $B743)
$8D:8C54             dx 0001, 01FC,FC,6B70
$8D:8C5B             dx 0001, 01FC,FC,6B63
$8D:8C62             dx 0001, 01FC,FC,6B67
$8D:8C69             dx 0001, 01FC,FC,6B6A

; Enemy projectile $AD5E/$AD6C/$AD7A (torizo chozo orbs)
$8D:8C70             dx 0001, C3F8,F8,672C
$8D:8C77             dx 0001, C3F8,F8,272C

; Enemy projectile $AD5E/$AD6C/$AD7A (torizo chozo orbs) / enemy projectile $B428 (Golden Torizo eye beam)
$8D:8C7E             dx 0001, C3F8,F8,6B2E
$8D:8C85             dx 0002, 01F8,00,2B80, 0000,00,6B80
$8D:8C91             dx 0004, 01F8,00,2B90, 01F8,F8,2B80, 0000,00,6B90, 0000,F8,6B80
$8D:8CA7             dx 0003, C3F8,F0,6B80, 01F8,00,2B99, 0000,00,6B99
$8D:8CB8             dx 0003, 0000,00,6B80, 01F8,00,2B80, C3F8,EC,2B2E
$8D:8CC9             dx 0006, 01F8,00,EB52, 0000,00,AB52, 01F8,F0,2B92, 01F8,E8,2B82, 0000,F0,6B92, 0000,E8,6B82

; Enemy projectile $AEA8/$AEB6 (torizo sonic boom)
$8D:8CE9             dx 0004, 0000,00,AB5E, 01F8,00,AB5D, 0000,F8,2B5E, 01F8,F8,2B5D
$8D:8CFF             dx 0006, 01F8,00,ABBE, 0000,08,ABBD, 01F8,08,ABBC, 01F8,F8,2BBE, 0000,F0,2BBD, 01F8,F0,2BBC
$8D:8D1F             dx 0006, 01FC,00,ABBF, 01FC,08,AB65, 01FC,10,AB49, 01FC,F8,2BBF, 01FC,F0,2B65, 01FC,E8,2B49
$8D:8D3F             dx 0004, 01F8,00,EB5E, 0000,00,EB5D, 01F8,F8,6B5E, 0000,F8,6B5D
$8D:8D55             dx 0006, 0000,00,EBBE, 01F8,08,EBBD, 0000,08,EBBC, 0000,F8,6BBE, 01F8,F0,6BBD, 0000,F0,6BBC
$8D:8D75             dx 0006, 01FC,00,EBBF, 01FC,08,EB65, 01FC,10,EB49, 01FC,F8,6BBF, 01FC,F0,6B65, 01FC,E8,6B49

; Unused
$8D:8D95             dx 0001, 01FC,FC,2A5E

; Enemy projectile $8F8F (Crocomire's projectile)
; Enemy projectile $9C45 (rocks Kraid spits at you)
; Enemy projectile $A9A1 (Bomb Torizo low-health explosion)
; Enemy projectile $A985 (Bomb Torizo explosive swipe)
; Enemy projectile $B1C0 (Golden Torizo egg)
; Enemy projectile $AD5E/$AD6C/$AD7A (torizo chozo orbs)
; Enemy projectile $B428 (Golden Torizo eye beam)
; Enemy projectile $D02E (Kago's bugs)
$8D:8D9C             dx 0001, 01FC,FC,2A5F
$8D:8DA3             dx 0004, 0000,00,EA60, 0000,F8,6A60, 01F8,00,AA60, 01F8,F8,2A60
$8D:8DB9             dx 0004, 0000,00,EA61, 0000,F8,6A61, 01F8,00,AA61, 01F8,F8,2A61
$8D:8DCF             dx 0004, 0000,00,EA62, 0000,F8,6A62, 01F8,00,AA62, 01F8,F8,2A62
$8D:8DE5             dx 0004, 0000,00,EA63, 0000,F8,6A63, 01F8,00,AA63, 01F8,F8,2A63

; Enemy projectile $A993 (Bomb Torizo statue breaking)
$8D:8DFB             dx 0001, C3F8,F8,2EE0
$8D:8E02             dx 0001, C3F8,F8,2EE2
$8D:8E09             dx 0001, C3F8,F8,2EE4
$8D:8E10             dx 0001, C3F8,F8,2EE6
$8D:8E17             dx 0001, C3F8,F8,2EE8
$8D:8E1E             dx 0001, C3F8,F8,2EEA
$8D:8E25             dx 0001, C3F8,F8,2EEC
$8D:8E2C             dx 0001, C3F8,F8,2EEE
$8D:8E33             dx 0001, C3F8,F8,6EE0
$8D:8E3A             dx 0001, C3F8,F8,6EE2
$8D:8E41             dx 0001, C3F8,F8,6EE4
$8D:8E48             dx 0001, C3F8,F8,6EE6
$8D:8E4F             dx 0001, C3F8,F8,6EE8
$8D:8E56             dx 0001, C3F8,F8,6EEA
$8D:8E5D             dx 0001, C3F8,F8,6EEC
$8D:8E64             dx 0001, C3F8,F8,6EEE

; Enemy projectile $B31A (Golden Torizo super missile)
$8D:8E6B             dx 0002, 0000,FC,2A65, 01F8,FC,2A64
$8D:8E77             dx 0003, 0003,FF,2A68, 01FB,FF,2A67, 01FB,F7,2A66
$8D:8E88             dx 0002, 01FC,00,2A6A, 01FC,F8,2A69
$8D:8E94             dx 0003, 01F5,FF,6A68, 01FD,FF,6A67, 01FD,F7,6A66
$8D:8EA5             dx 0002, 01F8,FC,6A65, 0000,FC,6A64
$8D:8EB1             dx 0003, 01F5,F9,EA68, 01FD,F9,EA67, 01FD,01,EA66
$8D:8EC2             dx 0002, 01FC,F8,AA6A, 01FC,00,AA69
$8D:8ECE             dx 0003, 0003,F9,AA68, 01FB,F9,AA67, 01FB,01,AA66

; Enemy projectile $AFE5 (Torizo landing dust cloud - right foot)
$8D:8EDF             dx 0001, 01FC,FC,2A48
$8D:8EE6             dx 0001, 01FC,FC,2A49
$8D:8EED             dx 0001, 01FC,FC,2A4A
$8D:8EF4             dx 0001, 01FC,FC,2A4B

; Enemy projectile $AFF3 (Torizo landing dust cloud - left foot)
$8D:8EFB             dx 0001, 01FC,FC,6A48
$8D:8F02             dx 0001, 01FC,FC,6A49
$8D:8F09             dx 0001, 01FC,FC,6A4A
$8D:8F10             dx 0001, 01FC,FC,6A4B

; Enemy projectile $B1C0 (Golden Torizo egg)
$8D:8F17             dx 0001, C3F8,F8,2B04
$8D:8F1E             dx 0001, C3F8,F8,2B8C
$8D:8F25             dx 0001, C3F8,F8,2BCC
$8D:8F2C             dx 0001, C3F8,F8,2AD0
$8D:8F33             dx 0001, C3F8,F6,22D2
$8D:8F3A             dx 0001, C3F8,F6,22D4
$8D:8F41             dx 0001, C3F8,F6,22D6
$8D:8F48             dx 0001, C3F8,F6,22D8
$8D:8F4F             dx 0001, C3F8,F6,22DA
$8D:8F56             dx 0001, C3F8,F6,22DC
$8D:8F5D             dx 0002, 0000,FE,22EF, 01F8,FE,22EE
$8D:8F69             dx 0002, 0000,FE,22DF, 01F8,FE,22DE
$8D:8F75             dx 0001, C3F8,F8,6B04
$8D:8F7C             dx 0001, C3F8,F8,6B8C
$8D:8F83             dx 0001, C3F8,F8,6BCC
$8D:8F8A             dx 0001, C3F8,F8,6AD0
$8D:8F91             dx 0001, C3F8,F6,62D2
$8D:8F98             dx 0001, C3F8,F6,62D4
$8D:8F9F             dx 0001, C3F8,F6,62D6
$8D:8FA6             dx 0001, C3F8,F6,62D8
$8D:8FAD             dx 0001, C3F8,F6,62DA
$8D:8FB4             dx 0001, C3F8,F6,62DC
$8D:8FBB             dx 0002, 0000,FE,62EF, 01F8,FE,62EE
$8D:8FC7             dx 0002, 0000,FE,62DF, 01F8,FE,62DE

; Enemy projectile $B5CB (dragon fireball)
$8D:8FD3             dx 0001, 01FC,FC,2122
$8D:8FDA             dx 0001, 01FC,FC,2123
$8D:8FE1             dx 0001, 01FC,FC,A122
$8D:8FE8             dx 0001, 01FC,FC,A123
$8D:8FEF             dx 0001, 01FC,FC,6122
$8D:8FF6             dx 0001, 01FC,FC,6123
$8D:8FFD             dx 0001, 01FC,FC,E122
$8D:9004             dx 0001, 01FC,FC,E123

; Enemy projectile $B743 (eye door projectile)
$8D:900B             dx 0004, 01F8,F8,2C63, 0000,F8,6C63, 01F8,00,AC63, 0000,00,EC63
$8D:9021             dx 0004, 01F8,F8,2C62, 0000,F8,6C62, 01F8,00,AC62, 0000,00,EC62
$8D:9037             dx 0004, 01F8,F8,2C61, 0000,F8,6C61, 01F8,00,AC61, 0000,00,EC61
$8D:904D             dx 0004, 01F8,F8,2C60, 0000,F8,6C60, 01F8,00,AC60, 0000,00,EC60

; Enemy projectile $B751 (eye door sweat)
$8D:9063             dx 0001, 01FC,FC,2A43
$8D:906A             dx 0001, 01FC,FC,2A2C
$8D:9071             dx 0001, 01FC,FC,2A2D
$8D:9078             dx 0001, 01FC,FC,2A2E

; Unused
$8D:907F             dx 0001, 01FC,FC,2A2F

; Enemy projectile $BA5C (Tourian entrance statue unlocking particle water splash)
$8D:9086             dx 0001, 01FC,FC,7E2C
$8D:908D             dx 0001, 01FC,FC,7E2D
$8D:9094             dx 0001, 01FC,FC,7E2E
$8D:909B             dx 0001, 01FC,FC,7E2F

; Enemy projectile $BA86 (Tourian entrance statue unlocking particle tail)
$8D:90A2             dx 0001, 01FC,FC,3EDA
$8D:90A9             dx 0001, 01FC,FC,3EDB
$8D:90B0             dx 0001, 01FC,FC,3EDC
$8D:90B7             dx 0001, 01FC,FC,3EDD

; Enemy projectile $BA6A (Tourian entrance statue eye glow)
$8D:90BE             dx 0001, 01FC,FC,3ED0
$8D:90C5             dx 0001, 01FC,FC,3ED1
$8D:90CC             dx 0001, 01FC,FC,3ED2
$8D:90D3             dx 0001, C3F8,F8,3EE2
$8D:90DA             dx 0001, C3F8,F8,3EE4
$8D:90E1             dx 0001, C3F8,F8,3EE6
$8D:90E8             dx 0001, C3F8,F8,3EE8
$8D:90EF             dx 0006, 0003,04,FEEA, 0003,FC,7EFA, 0003,F4,7EEA, 01FC,04,BEEB, 01F4,04,BEEA, C3F4,F4,3EEA
$8D:910F             dx 0004, C200,00,7EEE, C3F0,00,3EEE, C200,F0,7EEC, C3F0,F0,3EEC

; Enemy projectile $BA78 (Tourian entrance statue unlocking particle)
$8D:9125             dx 0001, 01FC,FC,3ED3
$8D:912C             dx 0001, 01FC,FC,7ED3
$8D:9133             dx 0001, 01FC,FC,BED3
$8D:913A             dx 0001, 01FC,FC,FED3

; Enemy projectile $BA94 (Tourian entrance statue's soul)
$8D:9141             dx 0004, 0000,00,3ED6, 01F8,00,3ED5, 01FC,08,3ED4, C3F8,F8,3EE0
$8D:9157             dx 0004, 01FC,08,3ED9, 0000,00,3ED8, 01F8,00,3ED7, C3F8,F8,3EE0

; Enemy projectile $BABE (Tourian entrance statue - base decoration)
$8D:916D             dx 0007, C228,F8,1F9C, C218,F8,1F9A, C208,F8,1F98, C3F8,F8,1F96, C3E8,F8,1F94, C3D8,F8,1F92, C3C8,F8,1F90

; Enemy projectile $BAA2 (Tourian entrance statue - Ridley)
$8D:9192             dx 0017, C3E5,18,2344, C3E5,08,232C, C3F5,18,2346, 000D,20,237D, 000D,18,236D, 0005,18,2348, C215,08,2342, C205,08,2340, C3F5,08,232E, C3D5,08,232A, C215,F8,2328, C205,F8,2326, C3F5,F8,2324, C3E5,F8,2322, C3D5,F8,2320, C215,E8,230E, C205,E8,230C, C3F5,E8,230A, C3E5,E8,2308, C215,D8,2306, C205,D8,2304, C3F5,D8,2302, C3E5,D8,2300

; Enemy projectile $BAB0 (Tourian entrance statue - Phantoon)
$8D:9207             dx 0013, 0008,1C,2587, 0000,1C,2586, 01F8,1C,2585, 01F0,1C,2584, 0000,04,2583, 0000,FC,2581, 01F8,04,2582, 01F8,FC,2580, C208,EC,2561, C3E8,EC,254D, C208,FC,2565, C208,0C,256B, C3F8,0C,2569, C3E8,0C,2567, C3E8,FC,2563, C200,EC,2560, C3F0,EC,254E, C200,DC,254B, C3F0,DC,2549

; Enemy projectile $BB50 (unused)
$8D:9268             dx 0001, 81F9,F9,230E
$8D:926F             dx 0001, 81FD,F5,2320
$8D:9276             dx 0001, 8003,EE,2304
$8D:927D             dx 0001, 8005,EC,2308
$8D:9284             dx 0001, 8005,EC,230C
$8D:928B             dx 0001, 8005,EC,2326
$8D:9292             dx 0001, 8005,EC,232E
$8D:9299             dx 0001, 81F8,F9,630E
$8D:92A0             dx 0001, 81F4,F5,6320
$8D:92A7             dx 0001, 81EE,EE,6304
$8D:92AE             dx 0001, 81EC,EC,6308
$8D:92B5             dx 0001, 81EC,EC,630C
$8D:92BC             dx 0001, 81EC,EC,6326
$8D:92C3             dx 0001, 81EB,EC,232E
$8D:92CA             dx 0002, 01F1,F8,6334, 0008,F8,2334
$8D:92D6             dx 0002, 01F1,F8,6324, 0008,F8,2324
$8D:92E2             dx 0002, 81E9,F0,6328, 8008,F0,2328
$8D:92EE             dx 0002, 81E9,F0,632C, 8008,F0,232C ; Unused
$8D:92FA             dx 0002, 81E8,F0,632A, 8009,F0,232A

; Enemy projectile $BBC7 (fire arc body)
$8D:9306             dx 0001, 81F9,F8,230A
$8D:930D             dx 0001, 81F9,F8,2308
$8D:9314             dx 0001, 81F8,F8,E30A
$8D:931B             dx 0001, 81F8,F8,E308
$8D:9322             dx 0001, 81F9,F8,2306
$8D:9329             dx 0001, 81F9,F8,2322
$8D:9330             dx 0001, 81F8,F8,E306
$8D:9337             dx 0001, 81F8,F8,E322

; Unused
$8D:933E             dx 0000

; Enemy projectile $BD5A (polyp rock)
$8D:9340             dx 0001, 01FC,FC,210A

; Enemy projectile $BE25/$BE33/$BE41 (Shaktool's attack)
$8D:9347             dx 0001, 01FC,FC,2053

; Enemy projectile $BE25/$BE33 (Shaktool's attack - front/middle circle)
$8D:934E             dx 0001, 01FC,FC,2051

; Enemy projectile $BE25 (Shaktool's attack - front circle)
$8D:9355             dx 0004, 0000,00,E060, 0000,F8,6060, 01F8,00,A060, 01F8,F8,2060

; Enemy projectile $C17E (Mother Brain's room turrets)
$8D:936B             dx 0001, 01EF,F3,259A ; Pointing left
$8D:9372             dx 0001, 01F2,FD,258B ; Pointing down-left
$8D:9379             dx 0001, 01FC,FF,259B ; Pointing down
$8D:9380             dx 0001, 0006,FD,658B ; Pointing down-right
$8D:9387             dx 0001, 0009,F3,659A ; Pointing right
$8D:938E             dx 0001, 0006,EB,E58B ; Pointing up-right
$8D:9395             dx 0001, 01FC,E7,A59B ; Pointing up
$8D:939C             dx 0001, 01F2,EB,A58B ; Pointing up-left

; Enemy projectile $C18C (Mother Brain's room turret bullets)
$8D:93A3             dx 0001, 01FC,FC,25A8 ; Pointing left
$8D:93AA             dx 0001, 01FC,FC,25A6 ; Pointing down-left
$8D:93B1             dx 0001, 01FC,FC,25A7 ; Pointing down
$8D:93B8             dx 0001, 01FC,FC,65A6 ; Pointing down-right
$8D:93BF             dx 0001, 01FC,FC,65A8 ; Pointing right
$8D:93C6             dx 0001, 01FC,FC,E5A6 ; Pointing up-right
$8D:93CD             dx 0001, 01FC,FC,A5A7 ; Pointing up
$8D:93D4             dx 0001, 01FC,FC,A5A6 ; Pointing up-left

; Enemy projectile $CB83 (Mother Brain's rainbow beam charging)
$8D:93DB             dx 000B, 01FC,E5,3AED, 000E,EF,3AFC, 01EA,EF,7AFC, 0025,F8,3AEC, 001A,D6,3AEC, 01DF,D6,3AEC, 01D3,F8,3AEC, 01ED,F8,3AEB, 000C,F8,3AEB, 0004,ED,3AEB, 01F5,ED,3AEB
$8D:9414             dx 0007, 01FC,E1,3AEE, 0011,ED,3AFD, 01E7,ED,7AFD, 01F0,E8,7AFC, 01E8,F8,7ADD, 0010,F8,3ADD, 0008,E8,3AFC
$8D:9439             dx 0007, 01FC,DE,3AEF, 0018,E8,3AFE, 01E0,E8,7AFE, 01E5,F8,7ADE, 0014,F8,3ADE, 000A,E6,3AFD, 01EE,E6,7AFD
$8D:945E             dx 0007, 01FC,DA,3AFF, 001D,E6,3AFF, 01DC,E6,7AFF, 01DE,F8,7ADF, 001B,F8,3ADF, 0010,E0,3AFE, 01E8,E0,7AFE
$8D:9483             dx 000A, 000A,F3,3AEA, 01FC,EC,3AEA, 01FC,D4,3AEC, 0020,E4,3AEC, 01F0,F3,3AEA, 01DA,E4,3AEC, 01D8,F8,7AFF, 0020,F8,3AFF, 0014,DC,3AFF, 01E4,DC,7AFF
$8D:94B7             dx 000E, 01FC,EA,3AEB, 0022,E3,3AEC, 000A,F3,3AEB, 01EF,F3,3AEB, 01D8,E3,3AEC, 01E1,D8,3AEC, 01EC,F8,3AEA, 01F4,EC,3AEA, 0005,EC,3AEA, 000C,F8,3AEA, 0023,F8,3AEC, 0018,D8,3AEC, 01FC,D1,3AEC, 01D5,F8,3AEC

; Enemy projectile $CB91/$CB9F (Mother Brain's drool)
$8D:94FF             dx 0001, 01FC,FA,3AF0
$8D:9506             dx 0001, 01FC,FB,3AF1
$8D:950D             dx 0001, 01FC,FC,3AF2
$8D:9514             dx 0001, 01FC,FC,3AF3
$8D:951B             dx 0001, 01FC,FC,3AF4
$8D:9522             dx 0001, 01FC,FC,3AF5
$8D:9529             dx 0001, 01FC,FC,3AF6
$8D:9530             dx 0001, 01FC,FC,3ADA
$8D:9537             dx 0002, 01FC,00,3ADC, 01FC,FC,3ADB
$8D:9543             dx 0002, 01FC,04,3ADC, 01FC,FC,3ADB

; Enemy projectile $CB2F (Mother Brain's purple breath - big)
$8D:954F             dx 0002, 01EE,F2,3AF7, C3F8,F8,3AD0
$8D:955B             dx 0004, 01EC,EE,3AF7, 01EE,F1,3AF8, C200,00,7AD0, C3F8,F7,3AD2
$8D:9571             dx 0007, 01E8,E8,3AF9, 01EE,EA,3AF7, 01EC,ED,3AF8, 01EE,F0,3AF9, C208,08,FAD0, C200,01,3AD2, C3F8,F6,3AD4
$8D:9596             dx 0008, 01E8,E6,3AF7, 01EE,E9,3AF8, 01EC,EC,3AF9, 01EE,EF,3AFA, C210,0E,7AD0, C208,07,3AD2, C200,00,3AD4, C3F8,F4,3AD6
$8D:95C0             dx 0007, 01E8,E5,3AF8, 01EE,E8,3AF9, 01EC,EB,3AFA, C213,0D,3AD2, C208,06,3AD4, C200,FE,3AD6, C3F8,F1,3AD8
$8D:95E5             dx 0006, 01E8,E4,3AF9, 01EF,E7,3AFA, 01EC,EA,3AFB, C212,0C,3AD4, C208,02,3AD6, C200,FB,3AD8
$8D:9605             dx 0004, 01E8,E3,3AFA, 01F0,E6,3AFB, C212,0A,3AD6, C208,FF,3AD8
$8D:961B             dx 0002, 01E8,E3,3AFB, C212,07,3AD8

; Enemy projectile $CB3D (Mother Brain's purple breath - small)
$8D:9627             dx 0001, 01FC,F8,3AF7
$8D:962E             dx 0002, 01FA,F4,3AF7, 01FC,F7,3AF8
$8D:963A             dx 0004, 01F6,EE,3AF9, 01FC,F0,3AF7, 01FA,F3,3AF8, 01FC,F6,3AF9
$8D:9650             dx 0004, 01F6,EC,3AF7, 01FC,EF,3AF8, 01FA,F2,3AF9, 01FC,F5,3AFA
$8D:9666             dx 0003, 01F6,EB,3AF8, 01FC,EE,3AF9, 01FA,F1,3AFA
$8D:9677             dx 0003, 01F6,EA,3AF9, 01FD,ED,3AFA, 01FA,F0,3AFB
$8D:9688             dx 0002, 01F6,E9,3AFA, 01FE,EC,3AFB
$8D:9694             dx 0001, 01F6,E9,3AFB

; Enemy projectile $CB21 (Mother Brain's exploded escape door particles)
$8D:969B             dx 0001, 01FC,FC,3302
$8D:96A2             dx 0001, C3F8,F8,3303
$8D:96A9             dx 0001, 01FC,FC,3312
$8D:96B0             dx 0001, C3F8,F8,3305
$8D:96B7             dx 0001, 01FC,FC,3307
$8D:96BE             dx 0001, C3F8,F8,3308
$8D:96C5             dx 0001, 01FC,FC,3317
$8D:96CC             dx 0001, C3F8,F8,330A

; Unused. Instruction list $CA46
$8D:96D3             dx 0001, 01FC,FC,330C
$8D:96DA             dx 0001, 01FC,FC,330D
$8D:96E1             dx 0001, 01FC,FC,330E
$8D:96E8             dx 0001, 01FC,FC,330F
$8D:96EF             dx 0001, 01FC,FC,331C
$8D:96F6             dx 0001, 01FC,FC,331D
$8D:96FD             dx 0001, 01FC,FC,331E
$8D:9704             dx 0001, 01FC,FC,331F

; Enemy projectile $CBBB (time bomb set Japanese text)
$8D:970B             dx 000C, 0008,08,35C9, 0008,00,35C8, 0000,08,35C7, 01F8,08,35C6, 0000,00,35C5, 01F8,00,35C4, C3E8,00,35AD, 0018,F8,35C9, 0018,F0,35C8, C208,F0,35A6, C3F8,F0,35A2, C3E8,F0,35A0

; Enemy projectile $CEFC (Mother Brain's glass shattering - shard)
$8D:9749             dx 0001, 01FC,FD,3121
$8D:9750             dx 0001, 01FC,FC,3122
$8D:9757             dx 0001, 01FC,FB,3123
$8D:975E             dx 0001, 01FC,FD,3124
$8D:9765             dx 0001, 01FC,FE,B121
$8D:976C             dx 0001, 01FC,FD,3125
$8D:9773             dx 0001, 01FC,FB,3126
$8D:977A             dx 0001, 01FC,FD,3127
$8D:9781             dx 0001, 01FB,FC,3131
$8D:9788             dx 0001, 01FC,FC,3132
$8D:978F             dx 0001, 01FE,FC,3133
$8D:9796             dx 0001, 01FB,FC,3134
$8D:979D             dx 0001, 01FA,FC,7131
$8D:97A4             dx 0001, 01FB,FC,3135
$8D:97AB             dx 0001, 01FC,FC,3136
$8D:97B2             dx 0001, 01FB,FC,3137
$8D:97B9             dx 0001, 01FC,FC,3138
$8D:97C0             dx 0001, 01FC,FB,3139
$8D:97C7             dx 0001, 01FC,FC,313A
$8D:97CE             dx 0001, 01FC,FC,313B
$8D:97D5             dx 0001, 01FC,FC,F138
$8D:97DC             dx 0001, 01FB,FD,313C
$8D:97E3             dx 0001, 01FD,FB,313D
$8D:97EA             dx 0001, 01FC,FC,313E
$8D:97F1             dx 0001, 01FC,FC,B138
$8D:97F8             dx 0001, 01FC,FB,B139
$8D:97FF             dx 0001, 01FC,FC,B13A
$8D:9806             dx 0001, 01FC,FC,B13B
$8D:980D             dx 0001, 01FC,FC,7138
$8D:9814             dx 0001, 01FB,FD,B13C
$8D:981B             dx 0001, 01FD,FB,B13D
$8D:9822             dx 0001, 01FC,FC,B13E
$8D:9829             dx 0001, 01FC,FB,B121
$8D:9830             dx 0001, 01FC,FC,B122
$8D:9837             dx 0001, 01FC,FB,B123
$8D:983E             dx 0001, 01FC,FC,B124
$8D:9845             dx 0001, 01FC,FC,3121
$8D:984C             dx 0001, 01FC,FC,B125
$8D:9853             dx 0001, 01FC,FC,B126
$8D:985A             dx 0001, 01FC,FB,B127
$8D:9861             dx 0001, 01FC,FC,7131
$8D:9868             dx 0001, 01FD,FC,7132
$8D:986F             dx 0001, 01FC,FC,7133
$8D:9876             dx 0001, 01FC,FC,7134
$8D:987D             dx 0001, 01FB,FC,3131
$8D:9884             dx 0001, 01FC,FC,7135
$8D:988B             dx 0001, 01FC,FC,7136
$8D:9892             dx 0001, 01FC,FC,7137
$8D:9899             dx 0001, 01FC,FC,F138
$8D:98A0             dx 0001, 01FC,FC,F139
$8D:98A7             dx 0001, 01FC,FC,F13A
$8D:98AE             dx 0001, 01FC,FC,F13B
$8D:98B5             dx 0001, 01FC,FD,3138
$8D:98BC             dx 0001, 01FC,FC,F13C
$8D:98C3             dx 0001, 01FC,FC,F13D
$8D:98CA             dx 0001, 01FB,FD,F13E
$8D:98D1             dx 0001, 01FC,FC,7138
$8D:98D8             dx 0001, 01FC,FC,7139
$8D:98DF             dx 0001, 01FC,FC,713A
$8D:98E6             dx 0001, 01FD,FD,713B
$8D:98ED             dx 0001, 01FC,FC,B138
$8D:98F4             dx 0001, 01FC,FD,713C
$8D:98FB             dx 0001, 01FC,FC,B13D
$8D:9902             dx 0001, 01FC,FC,B13E

; Enemy projectile $CF0A (Mother Brain's glass shattering - sparkle)
$8D:9909             dx 0001, 01FC,FC,3528
$8D:9910             dx 0001, 01FC,FC,3529
$8D:9917             dx 0001, 01FC,FC,352A
$8D:991E             dx 0001, 01FC,FC,352B

; Enemy projectile $CF18 (ki hunter acid spit - left)
$8D:9925             dx 0001, 01F8,FC,3165
$8D:992C             dx 0002, 01F0,FC,3174, 01F8,FC,3175
$8D:9938             dx 0001, C3F0,F8,3166
$8D:993F             dx 0002, C3E8,F8,314B, C3F0,F8,314C
$8D:994B             dx 0002, 01F8,FC,3164, C3E8,F8,312A
$8D:9957             dx 0001, C3F8,F8,312A

; Enemy projectile $CF18/$CF26 (ki hunter acid spit)
$8D:995E             dx 0001, C3F9,F8,316C
$8D:9965             dx 0003, 0004,00,317B, 01F4,00,3179, 01FC,00,317A
$8D:9976             dx 0004, 01F2,00,316A, 0006,00,316B, 01FE,00,316A, 01FA,00,316B
$8D:998C             dx 0004, 01FE,00,3168, 0006,00,3169, 01FA,00,3169, 01F2,00,3168
$8D:99A2             dx 0002, 0002,00,3178, 01F6,00,3178

; Enemy projectile $CF26 (ki hunter acid spit - right)
$8D:99AE             dx 0001, 0000,FC,7165
$8D:99B5             dx 0002, 0008,FC,7174, 0000,FC,7175
$8D:99C1             dx 0001, C200,F8,7166
$8D:99C8             dx 0002, C208,F8,714B, C200,F8,714C
$8D:99D4             dx 0002, 0000,FC,7164, C208,F8,712A
$8D:99E0             dx 0001, C3F8,F8,712A

; Enemy projectile $D298 (powamp spikes)
$8D:99E7             dx 0001, 01FC,FC,210F
$8D:99EE             dx 0001, 01FC,FC,211B
$8D:99F5             dx 0001, 01FC,FC,211C

; Enemy projectile $D2A6/$D2B4/$D2C2/$D2D0/$D2DE (work robot laser)
$8D:99FC             dx 0001, 01FC,FC,2A53
$8D:9A03             dx 0001, 01FC,FC,2A51
$8D:9A0A             dx 0004, 0000,00,EA60, 0000,F8,6A60, 01F8,00,AA60, 01F8,F8,2A60
$8D:9A20             dx 0004, 0000,00,EA61, 0000,F8,6A61, 01F8,00,AA61, 01F8,F8,2A61
$8D:9A36             dx 0004, 0000,00,EA62, 0000,F8,6A62, 01F8,00,AA62, 01F8,F8,2A62
$8D:9A4C             dx 0004, 0000,00,EA63, 0000,F8,6A63, 01F8,00,AA63, 01F8,F8,2A63

; Enemy projectile $D904 (n00b tube crack)
$8D:9A62             dx 0008, 0000,00,734D, 0008,00,734C, 0000,F8,7359, 0000,F0,7349, 01F9,08,335D, 01F9,00,334D, 01F9,F8,3359, 01F1,F8,3358
$8D:9A8C             dx 000E, 01F9,18,3371, 01F1,10,3360, 01F9,10,3361, 0010,08,735B, 0018,08,735A, 0010,00,734B, 0008,E0,7328, 0000,E8,7339, 0008,E8,7338, C3E1,F0,3346, C200,00,734C, C200,F0,7348, C3F1,00,334C, C3F1,F0,3348
$8D:9AD4             dx 001E, 0008,10,7360, 0000,10,7361, 0020,F8,7355, 0020,00,730F, 01E1,08,335A, 01E1,E8,3336, 01E9,E8,3337, 01F9,E0,3329, 01F1,E8,3338, 01F9,E8,3339, 0028,18,733E, 0020,10,732F, 0010,10,734F, 0018,10,734E, 01E1,10,334E, 01E9,10,334F, 01E9,08,335B, 01E9,00,334B, 0010,D8,7317, C210,F0,7346, C200,D0,7308, C3D1,E8,3334, C3F1,10,3360, C3E1,F0,3346, C210,00,734A, C200,E0,7328, C200,00,734C, C200,F0,7348, C3F1,00,334C, C3F1,F0,3348
$8D:9B6C             dx 0027, 01E1,D8,3316, 01D1,F8,3354, 01D9,F8,3355, 01D9,18,333F, C230,00,730C, C230,10,732C, C220,F0,7344, C220,00,730E, 01D1,18,333E, 01D9,10,332F, 0020,E8,7335, 01D9,00,330F, 0020,D8,7315, 01D9,E0,3325, 01E9,D8,3317, 01C9,F0,3343, 01C1,E8,3332, 01C9,E8,3333, C3D1,E8,3334, C3F1,D0,3308, C210,D0,7306, C210,E0,7326, C3E1,10,334E, C210,F0,7346, C3F1,E0,3328, C3E1,E0,3326, C220,10,732E, C3E1,00,334A, C210,10,734E, C200,D0,7308, C200,10,7360, C3F1,10,3360, C3E1,F0,3346, C210,00,734A, C200,E0,7328, C200,00,734C, C200,F0,7348, C3F1,00,334C, C3F1,F0,3348
$8D:9C31             dx 0032, C3B1,F0,3340, 01C1,E0,3322, 01C9,E0,3323, 0030,D8,7313, 01C1,10,332C, 01B9,08,331B, 01D9,E0,3325, C3D1,E8,3334, C3C1,E8,3332, 0040,F0,7341, 0030,E8,7333, 0038,E8,7332, C230,F0,7342, C240,08,731A, C240,10,732A, C230,00,730C, C3C1,00,330C, C3C9,10,332D, C3D1,00,330E, C3C1,F0,3342, C3E1,D0,3306, C3D1,D0,3304, C3B1,E0,3320, C220,E0,7324, C220,D0,7304, C220,00,730E, C3F1,D0,3308, C210,D0,7306, C220,F0,7344, C210,E0,7326, C230,10,732C, C3D1,10,332E, C3E1,10,334E, C3D1,F0,3344, C210,F0,7346, C3F1,E0,3328, C3E1,E0,3326, C220,10,732E, C3E1,00,334A, C210,10,734E, C200,D0,7308, C200,10,7360, C3F1,10,3360, C3E1,F0,3346, C210,00,734A, C200,E0,7328, C200,00,734C, C200,F0,7348, C3F1,00,334C, C3F1,F0,3348
$8D:9D2D             dx 0032, C210,10,734E, C200,10,7360, C200,00,734C, C210,00,734A, C220,10,732E, C230,10,732C, C240,10,732A, C220,00,730E, C230,00,730C, C240,00,730A, C200,F0,7348, C210,F0,7346, C220,F0,7344, C230,F0,7342, C240,F0,7340, C200,E0,7328, C210,E0,7326, C220,E0,7324, C230,E0,7322, C240,E0,7320, C200,D0,7308, C210,D0,7306, C220,D0,7304, C230,D0,7302, C240,D0,7300, C3E1,10,334E, C3F1,10,3360, C3F1,00,334C, C3E1,00,334A, C3D1,10,332E, C3C1,10,332C, C3B1,10,332A, C3D1,00,330E, C3C1,00,330C, C3B1,00,330A, C3F1,F0,3348, C3E1,F0,3346, C3D1,F0,3344, C3C1,F0,3342, C3B1,F0,3340, C3F1,E0,3328, C3E1,E0,3326, C3D1,E0,3324, C3C1,E0,3322, C3B1,E0,3320, C3F1,D0,3308, C3E1,D0,3306, C3D1,D0,3304, C3C1,D0,3302, C3B1,D0,3300

; Unused
$8D:9E29             dx 000E, C200,EF,7363, C208,EF,7362, C200,00,736B, C208,00,736A, C200,F9,7368, C208,F9,7367, C218,F9,7365, C3F1,EF,3363, C3E9,EF,3362, C3F1,00,336B, C3E9,00,336A, C3F1,F9,3368, C3E9,F9,3367, C3D9,F9,3365

; Enemy projectile $D904 (n00b tube crack)
$8D:9E71             dx 000E, C20C,E7,7363, C214,E7,7362, C20C,08,736B, C214,08,736A, C210,F9,7368, C218,F9,7367, C228,F9,7365, C3E5,E7,3363, C3DD,E7,3362, C3E5,08,336B, C3DD,08,336A, C3E1,F9,3368, C3D9,F9,3367, C3C9,F9,3365
$8D:9EB9             dx 000E, C218,DF,7363, C220,DF,7362, C218,10,736B, C220,10,736A, C220,F9,7368, C228,F9,7367, C238,F9,7365, C3D9,DF,3363, C3D1,DF,3362, C3D9,10,336B, C3D1,10,336A, C3D1,F9,3368, C3C9,F9,3367, C3B9,F9,3365
$8D:9F01             dx 000E, C230,F9,7368, C238,F9,7367, C248,F9,7365, C224,D7,7363, C22C,D7,7362, C228,18,736B, C230,18,736A, C3CD,D7,3363, C3C5,D7,3362, C3C9,18,336B, C3C1,18,336A, C3C1,F9,3368, C3B9,F9,3367, C3A9,F9,3365
$8D:9F49             dx 000E, C240,F9,7368, C248,F9,7367, C258,F9,7365, C230,CF,7363, C238,CF,7362, C238,20,736B, C240,20,736A, C3C1,CF,3363, C3B9,CF,3362, C3B9,20,336B, C3B1,20,336A, C3B1,F9,3368, C3A9,F9,3367, C399,F9,3365
$8D:9F91             dx 000E, C248,F9,7368, C250,F9,7367, C260,F9,7365, C234,CD,7363, C23C,CD,7362, C23C,22,736B, C244,22,736A, C3BD,CD,3363, C3B5,CD,3362, C3B1,24,336B, C3A9,24,336A, C3A9,F9,3368, C3A1,F9,3367, C391,F9,3365
$8D:9FD9             dx 000E, C24E,F9,7368, C256,F9,7367, C266,F9,7365, C236,CC,7363, C23E,CC,7362, C23E,23,736B, C246,23,736A, C3BB,CC,3363, C3B3,CC,3362, C3AB,27,336B, C3A3,27,336A, C3A3,F9,3368, C39B,F9,3367, C38B,F9,3365
$8D:A021             dx 000E, C252,F9,7368, C25A,F9,7367, C26A,F9,7365, C237,CD,7363, C23F,CD,7362, C23E,24,736B, C246,24,736A, C3B9,CD,3363, C3B1,CD,3362, C3AC,28,336B, C3A4,28,336A, C39F,F9,3368, C397,F9,3367, C387,F9,3365
$8D:A069             dx 000E, C254,F9,7368, C25C,F9,7367, C26C,F9,7365, C238,CE,7363, C240,CE,7362, C23D,25,736B, C245,25,736A, C3B8,CE,3363, C3B0,CE,3362, C3AB,2A,336B, C3A3,2A,336A, C39D,F9,3368, C395,F9,3367, C385,F9,3365
$8D:A0B1             dx 000E, C256,FB,7368, C25E,FB,7367, C26E,FB,7365, C239,D0,7363, C241,D0,7362, C23E,26,736B, C246,26,736A, C3B7,D0,3363, C3AF,D0,3362, C3AA,2C,336B, C3A2,2C,336A, C39B,FA,3368, C393,FA,3367, C383,FA,3365
$8D:A0F9             dx 000E, C258,FD,7368, C260,FD,7367, C270,FD,7365, C239,D1,7363, C241,D1,7362, C23F,27,736B, C247,27,736A, C3B8,D2,3363, C3B0,D2,3362, C3AB,2E,336B, C3A3,2E,336A, C399,FB,3368, C391,FB,3367, C381,FB,3365
$8D:A141             dx 000E, C3AC,30,336B, C3A4,30,336A, C258,00,7368, C260,00,7367, C270,00,7365, C238,D2,7363, C240,D2,7362, C23E,28,736B, C246,28,736A, C3B7,D4,3363, C3AF,D4,3362, C399,FC,3368, C391,FC,3367, C381,FC,3365
$8D:A189             dx 000E, C3AB,32,336B, C3A3,32,336A, C257,03,7368, C25F,03,7367, C26F,03,7365, C239,D3,7363, C241,D3,7362, C23D,29,736B, C245,29,736A, C3B6,D6,3363, C3AE,D6,3362, C39A,FD,3368, C392,FD,3367, C382,FD,3365
$8D:A1D1             dx 000E, C3AA,34,336B, C3A2,34,336A, C258,06,7368, C260,06,7367, C270,06,7365, C23A,D4,7363, C242,D4,7362, C23E,2A,736B, C246,2A,736A, C3B7,D8,3363, C3AF,D8,3362, C399,FE,3368, C391,FE,3367, C381,FE,3365
$8D:A219             dx 000E, C3AB,36,336B, C3A3,36,336A, C257,09,7368, C25F,09,7367, C26F,09,7365, C239,D5,7363, C241,D5,7362, C23F,2B,736B, C247,2B,736A, C3B8,DA,3363, C3B0,DA,3362, C39A,FF,3368, C392,FF,3367, C382,FF,3365
$8D:A261             dx 000E, C3AC,38,336B, C3A4,38,336A, C258,0C,7368, C260,0C,7367, C270,0C,7365, C238,D6,7363, C240,D6,7362, C23E,2C,736B, C246,2C,736A, C3B7,DC,3363, C3AF,DC,3362, C399,00,3368, C391,00,3367, C381,00,3365
$8D:A2A9             dx 000E, C3AB,3A,336B, C3A3,3A,336A, C39A,01,3368, C392,01,3367, C382,01,3365, C257,0F,7368, C25F,0F,7367, C26F,0F,7365, C239,D7,7363, C241,D7,7362, C23D,2D,736B, C245,2D,736A, C3B6,DE,3363, C3AE,DE,3362
$8D:A2F1             dx 000E, C3AA,3C,336B, C3A2,3C,336A, C399,02,3368, C391,02,3367, C381,02,3365, C258,12,7368, C260,12,7367, C270,12,7365, C23A,D8,7363, C242,D8,7362, C23E,2E,736B, C246,2E,736A, C3B7,E0,3363, C3AF,E0,3362
$8D:A339             dx 000E, C3AB,3E,336B, C3A3,3E,336A, C39A,03,3368, C392,03,3367, C382,03,3365, C257,15,7368, C25F,15,7367, C26F,15,7365, C239,D9,7363, C241,D9,7362, C23F,2F,736B, C247,2F,736A, C3B8,E2,3363, C3B0,E2,3362
$8D:A381             dx 000E, C3AC,40,336B, C3A4,40,336A, C399,04,3368, C391,04,3367, C381,04,3365, C258,18,7368, C260,18,7367, C270,18,7365, C238,DA,7363, C240,DA,7362, C23E,30,736B, C246,30,736A, C3B7,E4,3363, C3AF,E4,3362
$8D:A3C9             dx 000E, C3AB,42,336B, C3A3,42,336A, C39A,05,3368, C392,05,3367, C382,05,3365, C257,1B,7368, C25F,1B,7367, C26F,1B,7365, C239,DB,7363, C241,DB,7362, C23D,31,736B, C245,31,736A, C3B6,E6,3363, C3AE,E6,3362
$8D:A411             dx 000E, C3AA,44,336B, C3A2,44,336A, C399,06,3368, C391,06,3367, C381,06,3365, C258,1E,7368, C260,1E,7367, C270,1E,7365, C23A,DC,7363, C242,DC,7362, C23E,32,736B, C246,32,736A, C3B7,E8,3363, C3AF,E8,3362
$8D:A459             dx 000E, C3AB,46,336B, C3A3,46,336A, C39A,07,3368, C392,07,3367, C382,07,3365, C257,21,7368, C25F,21,7367, C26F,21,7365, C239,DD,7363, C241,DD,7362, C23F,33,736B, C247,33,736A, C3B8,EA,3363, C3B0,EA,3362
$8D:A4A1             dx 000E, C3AC,48,336B, C3A4,48,336A, C399,08,3368, C391,08,3367, C381,08,3365, C258,24,7368, C260,24,7367, C270,24,7365, C238,DE,7363, C240,DE,7362, C23E,34,736B, C246,34,736A, C3B7,EC,3363, C3AF,EC,3362
$8D:A4E9             dx 000E, C3AB,4A,336B, C3A3,4A,336A, C257,27,7368, C25F,27,7367, C26F,27,7365, C239,DF,7363, C241,DF,7362, C23D,35,736B, C245,35,736A, C3B6,EE,3363, C3AE,EE,3362, C39A,09,3368, C392,09,3367, C382,09,3365
$8D:A531             dx 000E, C3AA,4C,336B, C3A2,4C,336A, C258,2A,7368, C260,2A,7367, C270,2A,7365, C23A,E0,7363, C242,E0,7362, C23E,36,736B, C246,36,736A, C3B7,F0,3363, C3AF,F0,3362, C399,0A,3368, C391,0A,3367, C381,0A,3365
$8D:A579             dx 000E, C3AB,4E,336B, C3A3,4E,336A, C257,2D,7368, C25F,2D,7367, C26F,2D,7365, C239,E1,7363, C241,E1,7362, C23F,37,736B, C247,37,736A, C3B8,F2,3363, C3B0,F2,3362, C39A,0B,3368, C392,0B,3367, C382,0B,3365
$8D:A5C1             dx 000E, C3AC,50,336B, C3A4,50,336A, C258,30,7368, C260,30,7367, C270,30,7365, C238,E2,7363, C240,E2,7362, C23E,38,736B, C246,38,736A, C3B7,F4,3363, C3AF,F4,3362, C399,0C,3368, C391,0C,3367, C381,0C,3365
$8D:A609             dx 000E, C3AB,52,336B, C3A3,52,336A, C257,33,7368, C25F,33,7367, C26F,33,7365, C239,E3,7363, C241,E3,7362, C23D,39,736B, C245,39,736A, C3B6,F6,3363, C3AE,F6,3362, C39A,0D,3368, C392,0D,3367, C382,0D,3365
$8D:A651             dx 000E, C3AA,54,336B, C3A2,54,336A, C399,0E,3368, C391,0E,3367, C381,0E,3365, C258,36,7368, C260,36,7367, C270,36,7365, C23A,E4,7363, C242,E4,7362, C23E,3A,736B, C246,3A,736A, C3B7,F8,3363, C3AF,F8,3362
$8D:A699             dx 000E, C3AB,54,336B, C3A3,54,336A, C39A,0E,3368, C392,0E,3367, C382,0E,3365, C257,36,7368, C25F,36,7367, C26F,36,7365, C239,E4,7363, C241,E4,7362, C23F,3A,736B, C247,3A,736A, C3B8,F8,3363, C3B0,F8,3362

; Enemy projectile $D912 (n00b tube shards)
$8D:A6E1             dx 0002, C3F3,FA,F3A2, C203,FA,F3A0
$8D:A6ED             dx 0002, C3FE,FA,B3A2, C3EE,FA,B3A0
$8D:A6F9             dx 0002, C3FD,FD,33A6, C3F5,F5,33A4
$8D:A705             dx 0002, C3F4,FD,73A6, C3FC,F5,73A4
$8D:A711             dx 0001, C3F7,F8,33A8
$8D:A718             dx 0001, C3FA,F8,73A8
$8D:A71F             dx 0002, C3EC,F9,73AC, C3FC,F9,73AA
$8D:A72B             dx 0002, C205,F9,33AC, C3F5,F9,33AA
$8D:A737             dx 0002, C3F3,FB,73AE, C203,FB,738E
$8D:A743             dx 0002, C3FE,FB,33AE, C3EE,FB,338E
$8D:A74F             dx 0002, C3F3,F6,F3AE, C203,F6,F38E
$8D:A75B             dx 0002, C3FE,F6,B3AE, C3EE,F6,B38E
$8D:A767             dx 0002, C200,F8,3388, C3F0,F8,3386
$8D:A773             dx 0002, C3F1,F8,7388, C201,F8,7386
$8D:A77F             dx 0002, C201,F8,338C, C3F1,F8,338A
$8D:A78B             dx 0002, C3F0,F8,738C, C200,F8,738A
$8D:A797             dx 0002, C3F8,F4,3382, C3F8,FC,3384
$8D:A7A3             dx 0002, C3F4,F0,336D, C3F4,00,3380
$8D:A7AF             dx 0002, C3FC,00,7380, C3FC,F0,736D

; Enemy projectile $D920 (n00b tube released air bubbles)
$8D:A7BB             dx 0001, C3F8,F8,3A7C
$8D:A7C2             dx 0002, C3F8,F8,3A7C, C3F8,00,3A7E
$8D:A7CE             dx 0003, C3F8,F8,3A7C, C3F8,00,3A7E, C3F8,08,3A9A
$8D:A7DF             dx 0004, C3F8,F8,3A7C, C3F8,00,3A7E, C3F8,08,3A9A, C3F8,10,3A9C

$8D:A7F5             dx C3F8,C0,3A9C ; Unused spritemap entry

; Enemy projectile $D920 (n00b tube released air bubbles)
$8D:A7FA             dx 0007, 01FD,F2,3A43, 01FF,F3,3A43, 01FA,F4,3A43, 01FA,F9,3A43, C3F8,F8,3A7E, C3F8,00,3A9A, C3F8,08,3A9C
$8D:A81F             dx 0007, 01FE,F2,3A43, 0000,F3,3A43, 01FB,F4,3A43, 01FB,F9,3A43, C3F8,F8,3A7E, C3F8,00,3A9A, C3F8,08,3A9C
$8D:A844             dx 0006, 01FA,F4,3A25, 01FD,F2,3A25, 01FA,F9,3A25, 01FF,F3,3A25, C3F8,F8,3A9A, C3F8,00,3A9C
$8D:A864             dx 0006, 01FC,EC,3A25, 01F8,F2,3A25, 01FC,F5,3A25, 0000,F0,3A25, C3F8,F8,3A9A, C3F8,00,3A9C
$8D:A884             dx 0005, 01FC,E8,3A25, 01F7,EF,3A25, 01FB,F5,3A25, 0001,EE,3A25, C3F8,F8,3A9C
$8D:A89F             dx 0005, 01FC,E8,3A25, 01F8,F0,3A25, 01FD,F5,3A25, 0002,EE,3A25, C3F8,F8,3A9C
$8D:A8BA             dx 0004, 01FC,E8,3A25, 01F8,F0,3A25, 01FD,F5,3A25, 0002,ED,3A25
$8D:A8D0             dx 0004, 0002,ED,3A25, 01FC,E8,3A25, 01FD,F5,3A43, 01F8,F0,3A43
$8D:A8E6             dx 0004, 0002,ED,3A43, 01FC,E8,3A43, 01FD,F5,3A40, 01F8,F0,3A40
$8D:A8FC             dx 0002, 0002,ED,3A40, 01FC,E8,3A40

; Enemy projectile $DAFE (cacatac spikes)
$8D:A908             dx 0001, 01FC,FC,311B
$8D:A90F             dx 0001, 01FC,FC,310E
$8D:A916             dx 0001, 01FC,FC,310F
$8D:A91D             dx 0001, 01FC,FC,710E
$8D:A924             dx 0001, 01FC,FC,711B
$8D:A92B             dx 0001, 01FC,FC,B11B
$8D:A932             dx 0001, 01FC,FC,B10E
$8D:A939             dx 0001, 01FC,FC,B10F
$8D:A940             dx 0001, 01FC,FC,F10E
$8D:A947             dx 0001, 01FC,FC,F11B

; Enemy projectile $DBF2 (mini-Crocomire projectile)
$8D:A94E             dx 0001, 01FC,FC,311E
$8D:A955             dx 0001, 01FC,FC,311D

; Unused
$8D:A95C             dx 0001, C3F8,F8,3126
$8D:A963             dx 0001, C3F8,F8,3128
$8D:A96A             dx 0001, C3F8,F8,310C
$8D:A971             dx 0001, C3F8,F8,310E
$8D:A978             dx 0001, C3F8,F8,312C
$8D:A97F             dx 0001, 01FC,FC,313E
$8D:A986             dx 0001, 01FC,FC,312F
$8D:A98D             dx 0001, 01FC,FC,312E

; Enemy projectile $DE6C (Spore Spawn's stalk)
$8D:A994             dx 0001, 81F8,F8,3340

; Enemy projectile $DE88 (spore spawners)
$8D:A99B             dx 0001, 81F8,F8,210C
$8D:A9A2             dx 0001, 81F8,F8,210E
$8D:A9A9             dx 0001, 81F8,F8,212C

; Enemy projectile $DE7A (spores)
$8D:A9B0             dx 0001, 01FC,FC,2F3E
$8D:A9B7             dx 0001, 01FC,FC,2F2F
$8D:A9BE             dx 0001, 01FC,FC,2F2E

; Unused
$8D:A9C5             dx 0018, 8000,26,614E, 8010,26,614C, 8020,26,614A, 8000,16,6148, 8010,16,6146, 8020,16,6144, 81F0,26,214E, 81E0,26,214C, 81D0,26,214A, 81F0,16,2148, 81E0,16,2146, 81D0,16,2144, 8000,DA,6124, 8010,DA,6122, 8020,DA,6120, 8000,CA,6104, 8010,CA,6102, 8020,CA,6100, 81F0,DA,2124, 81E0,DA,2122, 81D0,DA,2120, 81F0,CA,2104, 81E0,CA,2102, 81D0,CA,2100
$8D:AA3F             dx 0018, 8000,28,614E, 8010,28,614C, 8020,28,614A, 8000,18,6148, 8010,18,6146, 8020,18,6144, 81F0,28,214E, 81E0,28,214C, 81D0,28,214A, 81F0,18,2148, 81E0,18,2146, 81D0,18,2144, 8000,D8,6124, 8010,D8,6122, 8020,D8,6120, 8000,C8,6104, 8010,C8,6102, 8020,C8,6100, 81F0,D8,2124, 81E0,D8,2122, 81D0,D8,2120, 81F0,C8,2104, 81E0,C8,2102, 81D0,C8,2100

; Enemy projectile $DFBC/$DFCA (namihe/fune fireball)
$8D:AAB9             dx 0001, 81F8,F8,210A
$8D:AAC0             dx 0001, 81F8,F8,210C
$8D:AAC7             dx 0001, 81F8,F8,210E
$8D:AACE             dx 0001, 81F8,F8,610A
$8D:AAD5             dx 0001, 81F8,F8,610C
$8D:AADC             dx 0001, 81F8,F8,610E

; Unused
$8D:AAE3             dx 0004, 01F8,00,612F, 0000,00,612E, 01F8,F8,612D, 0000,F8,612C
$8D:AAF9             dx 0004, 0000,00,212F, 01F8,00,212E, 0000,F8,212D, 01F8,F8,212C

; Enemy projectile $E0E0 (lava thrown by magdollite)
$8D:AB0F             dx 0004, 0000,00,212F, 01F8,00,212E, 0000,F8,212D, 01F8,F8,212C
$8D:AB25             dx 0004, 01F8,00,612F, 0000,00,612E, 01F8,F8,612D, 0000,F8,612C

; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:AB3B             dx 0004, 0000,F8,7A2B, 0000,00,7A2B, 01F8,00,3A2B, 01F8,F8,3A2B
$8D:AB51             dx 0004, 0002,F3,7A2B, 0001,FF,7A2B, 01F7,FF,3A2B, 01F6,F3,3A2B
$8D:AB67             dx 0004, 0005,EE,7A2B, 0003,FD,7A2B, 01F5,FD,3A2B, 01F3,EE,3A2B
$8D:AB7D             dx 0004, 0007,EC,7A2B, 0005,FB,7A2B, 01F3,FB,3A2B, 01F1,EC,3A2B
$8D:AB93             dx 0004, 0009,EA,7A2B, 0007,FA,7A2B, 01F1,FA,3A2B, 01EF,EA,3A2B
$8D:ABA9             dx 0004, 000A,EA,7A2B, 0008,F9,7A2B, 01F0,F9,3A2B, 01EE,EA,3A2B
$8D:ABBF             dx 0004, 000C,EB,7A2A, 0009,FA,7A2A, 01EF,FA,3A2A, 01EC,EB,3A2A
$8D:ABD5             dx 0004, 000E,EC,7A2A, 000A,FC,7A2A, 01EE,FC,3A2A, 01EA,EC,3A2A
$8D:ABEB             dx 0004, 0010,ED,7A29, 000B,FE,7A29, 01ED,FE,3A29, 01E8,ED,3A29
$8D:AC01             dx 0004, 0012,EE,7A29, 000C,00,7A29, 01EC,00,3A29, 01E6,EE,3A29
$8D:AC17             dx 0004, 0013,F0,7A28, 000D,02,7A28, 01E5,F0,3A28, 01EB,02,3A28
$8D:AC2D             dx 0004, 0014,F2,7A28, 000E,04,7A28, 01E4,F2,3A28, 01EA,04,3A28
$8D:AC43             dx 0004, 0015,F5,7A28, 000F,07,7A28, 01E3,F5,3A28, 01E9,07,3A28
$8D:AC59             dx 0004, 0016,F9,7A28, 0010,0B,7A28, 01E2,F9,3A28, 01E8,0B,3A28
$8D:AC6F             dx 0004, 0017,03,7A28, 0011,11,7A28, 01E1,03,3A28, 01E7,11,3A28
$8D:AC85             dx 0004, 0018,0A,7A28, 0012,18,7A28, 01E0,0A,3A28, 01E6,18,3A28

; Big dust cloud
; Enemy projectile $AF68 (Wrecked Ship chozo spike clearing footsteps)
; Enemy projectile $AF84 (Tourian entrance statue dust clouds)
; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:AC9B             dx 0001, 01F7,F7,3A48
$8D:ACA2             dx 0002, 0001,01,3A48, 81F3,F3,3A7C
$8D:ACAE             dx 0003, 81FD,FD,3A7C, 01F7,01,3A48, 81F3,F3,3A7E
$8D:ACBF             dx 0004, 0001,F7,3A48, 81FD,FD,3A7E, 81F3,FD,3A7C, 81F3,F3,3A9A

; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:ACD5             dx 0004, 81FD,F3,3A7C, 81FD,FD,3A9A, 81F3,FD,3A7E, 81F3,F3,3A9C
$8D:ACEB             dx 0003, 81FD,F3,3A7E, 81FD,FD,3A9C, 81F3,FD,3A9A
$8D:ACFC             dx 0002, 81FD,F3,3A9A, 81F3,FD,3A9C
$8D:AD08             dx 0001, 81FD,F3,3A9C
$8D:AD0F             dx 0001, 01FC,FC,3A6B
$8D:AD16             dx 0001, 01FC,FC,3A6C
$8D:AD1D             dx 0002, 01F8,FC,3A6B, 0000,FC,3A6B
$8D:AD29             dx 0002, 01F8,FC,3A6C, 0000,FC,3A6C
$8D:AD35             dx 0003, 01F4,FC,3A6C, 0004,FC,3A6C, 01FC,FC,3A6C
$8D:AD46             dx 0003, 0004,FC,3A6B, 01F4,FC,3A6B, 01FC,FC,3A6B
$8D:AD57             dx 0004, 0008,FC,3A6C, 0000,FC,3A6C, 01F8,FC,3A6C, 01F0,FC,3A6C
$8D:AD6D             dx 0004, 0008,FC,3A6B, 0000,FC,3A6B, 01F8,FC,3A6B, 01F0,FC,3A6B

; Long Draygon breath bubbles
; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:AD83             dx 0001, 01FC,FC,3A25
$8D:AD8A             dx 0003, 0000,F8,3A25, 01FA,F6,3A25, 01FC,FB,3A25
$8D:AD9B             dx 0003, 0001,F7,3A25, 01F9,F4,3A25, 01FB,FA,3A25
$8D:ADAC             dx 0003, 0001,F5,3A43, 01FC,F8,3A43, 01FA,F1,3A43
$8D:ADBD             dx 0003, 0001,F3,3A43, 01FC,F5,3A43, 01FA,EE,3A43
$8D:ADCE             dx 0003, 0000,F0,3A40, 01FC,F4,3A40, 01FA,ED,3A40
$8D:ADDF             dx 0003, 0000,EE,3A40, 01FC,F2,3A40, 01FA,EC,3A40
$8D:ADF0             dx 0002, 0000,EC,3A40, 01FC,F0,3A40
$8D:ADFC             dx 0001, 01FC,EE,3A40

; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:AE03             dx 0004, 0008,E0,3A6F, 0000,E0,3A6F, 01F8,E0,3A6F, 01F0,E0,3A6F
$8D:AE19             dx 0004, 0008,E8,3A6F, 0000,E8,3A6F, 01F8,E8,3A6F, 01F0,E8,3A6F
$8D:AE2F             dx 0004, 0008,F0,3A6F, 0000,F0,3A6F, 01F8,F0,3A6F, 01F0,F0,3A6F
$8D:AE45             dx 0004, 0008,F8,3A6F, 0000,F8,3A6F, 01F8,F8,3A6F, 01F0,F8,3A6F
$8D:AE5B             dx 0004, 0008,00,3A6F, 0000,00,3A6F, 01F8,00,3A6F, 01F0,00,3A6F
$8D:AE71             dx 0004, 0008,08,3A6F, 0000,08,3A6F, 01F8,08,3A6F, 01F0,08,3A6F
$8D:AE87             dx 0004, 0008,10,3A6F, 0000,10,3A6F, 01F8,10,3A6F, 01F0,10,3A6F
$8D:AE9D             dx 0004, 0008,18,3A6F, 0000,18,3A6F, 01F8,18,3A6F, 01F0,18,3A6F
$8D:AEB3             dx 0002, 0000,FC,3ABF, 01F8,FC,3ABE
$8D:AEBF             dx 0001, 81F8,F8,3ABE
$8D:AEC6             dx 0002, 81F8,FC,3ABE, 81F8,F4,3ABE
$8D:AED2             dx 0002, 81F8,00,3ABE, 81F8,F0,3ABE
$8D:AEDE             dx 0003, 81F8,04,3ABE, 81F8,F8,3ABE, 81F8,EC,3ABE
$8D:AEEF             dx 0003, 81F8,08,3ABE, 81F8,F8,3ABE, 81F8,E8,3ABE
$8D:AF00             dx 0004, 81F8,0C,3ABE, 81F8,00,3ABE, 81F8,F0,3ABE, 81F8,E4,3ABE
$8D:AF16             dx 0004, 81F8,10,3ABE, 81F8,00,3ABE, 81F8,F0,3ABE, 81F8,E0,3ABE
$8D:AF2C             dx 0001, 01FC,FC,3C53
$8D:AF33             dx 0001, 01FC,FC,3C52
$8D:AF3A             dx 0001, 01FC,FC,3C51
$8D:AF41             dx 0004, 01F8,00,BC50, 0000,00,FC50, 0000,F8,7C50, 01F8,F8,3C50

; Enemy projectile $8E5E/$8E6C (Draygon's wall turret projectiles / ???) / enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:AF57             dx 0003, 0000,0C,3A5B, 0008,EC,3A5B, 01F0,F4,3A5B
$8D:AF68             dx 0003, 01FD,0A,3A5C, 0006,EE,3A5C, 01F2,F6,3A5C
$8D:AF79             dx 0003, 01FC,08,3A5C, 0004,F0,3A5C, 01F4,F8,3A5C
$8D:AF8A             dx 0003, 0002,F2,3A5D, 01FB,06,3A5D, 01F6,FA,3A5D
$8D:AF9B             dx 0003, 01FB,04,3A5D, 01F8,FB,3A5D, 0000,F4,3A5D
$8D:AFAC             dx 0003, 01FB,02,3A5D, 01FA,FA,3A5D, 0000,F6,3A5D
$8D:AFBD             dx 0003, 0000,EC,BA5B, 0008,0C,BA5B, 01F0,04,BA5B
$8D:AFCE             dx 0003, 01FE,EE,BA5C, 0006,0A,BA5C, 01F2,02,BA5C
$8D:AFDF             dx 0003, 0004,08,BA5C, 01F4,00,BA5C, 01FD,F0,BA5C
$8D:AFF0             dx 0003, 0002,06,BA5D, 01FC,F2,BA5D, 01F6,FE,BA5D
$8D:B001             dx 0003, 01FC,F4,BA5D, 01F8,FC,BA5D, 0000,04,BA5D
$8D:B012             dx 0003, 01FC,F6,BA5D, 01FA,FD,BA5D, 0000,02,BA5D

; Small explosion
; Enemy projectile $A9AF (Torizo death explosion)
; Enemy projectile $B4B1 (old Tourian escape shaft fake wall explosion)
; Enemy projectile $DE7A (spores)
; Enemy projectile $E509/$E525 (dust cloud / explosion)
; Enemy projectile $E517/$E525 (eye door smoke)
$8D:B023             dx 0001, 01FC,FC,3A5F
$8D:B02A             dx 0004, 0000,00,FA8A, 01F8,00,BA8A, 0000,F8,7A8A, 01F8,F8,3A8A
$8D:B040             dx 0004, 8000,00,FA90, 81F0,00,BA90, 8000,F0,7A90, 81F0,F0,3A90
$8D:B056             dx 0004, 8000,00,FA92, 81F0,00,BA92, 8000,F0,7A92, 81F0,F0,3A92
$8D:B06C             dx 0004, 8000,00,FA94, 81F0,00,BA94, 8000,F0,7A94, 81F0,F0,3A94
$8D:B082             dx 0004, 8000,00,FA96, 81F0,00,BA96, 8000,F0,7A96, 81F0,F0,3A96

; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:B098             dx 0004, 0000,00,FA8B, 01F8,00,BA8B, 0000,F8,7A8B, 01F8,F8,3A8B
$8D:B0AE             dx 0004, 0000,00,FA7A, 01F8,00,BA7A, 0000,F8,7A7A, 01F8,F8,3A7A
$8D:B0C4             dx 0004, 8000,00,FA70, 81F0,00,BA70, 8000,F0,7A70, 81F0,F0,3A70
$8D:B0DA             dx 0004, 8000,00,FA72, 81F0,00,BA72, 8000,F0,7A72, 81F0,F0,3A72
$8D:B0F0             dx 0004, 8000,00,FA74, 81F0,00,BA74, 8000,F0,7A74, 81F0,F0,3A74

; Unused
$8D:B106             dx 0004, 01F8,00,3A5E, 0000,00,3A5E, 0000,F8,3A5E, 01F8,F8,3A5E

; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:B11C             dx 0001, 01FC,FC,3C38
$8D:B123             dx 0001, 01FC,FC,3C39
$8D:B12A             dx 0001, 01FC,FC,3C3A
$8D:B131             dx 0001, 01FC,FC,3C3B
$8D:B138             dx 0001, 01FC,FC,3A26
$8D:B13F             dx 0001, 01FC,FC,3A27
$8D:B146             dx 0001, 01FC,FC,3A7B

; Unused
$8D:B14D             dx 0001, 01FC,FC,3A5F

; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:B154             dx 0001, 01FC,FC,3A53
$8D:B15B             dx 0001, 01FC,FC,3A51
$8D:B162             dx 0004, 0000,00,FA60, 0000,F8,7A60, 01F8,00,BA60, 01F8,F8,3A60
$8D:B178             dx 0004, 0000,00,FA61, 0000,F8,7A61, 01F8,00,BA61, 01F8,F8,3A61
$8D:B18E             dx 0004, 0000,00,FA62, 0000,F8,7A62, 01F8,00,BA62, 01F8,F8,3A62
$8D:B1A4             dx 0004, 0000,00,FA63, 0000,F8,7A63, 01F8,00,BA63, 01F8,F8,3A63

; Enemy projectile $A387 (Ceres elevator pad) / enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:B1BA             dx 0004, 01F2,FC,7A6C, 0006,FC,7A6C, 0000,FC,7A6C, 01F8,FC,3A6C
$8D:B1D0             dx 0004, 0000,FC,7A6E, 0008,FC,7A6D, 01F8,FC,3A6E, 01F0,FC,3A6D

; Unused
$8D:B1E6             dx 0004, 01F0,FE,3A6F, 0008,FE,3A6F, 0000,FE,3A6F, 01F8,FE,3A6F

; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:B1FC             dx 0001, 81F8,F8,3A7C
$8D:B203             dx 0001, 81F8,F6,3A7E
$8D:B20A             dx 0001, 81F8,F4,3A9A
$8D:B211             dx 0001, 81F8,F2,3A9C
$8D:B218             dx 0001, 01FC,FC,3A48
$8D:B21F             dx 0001, 01FC,FA,3A49
$8D:B226             dx 0001, 01FC,F8,3A4A
$8D:B22D             dx 0001, 01FC,F6,3A4B
$8D:B234             dx 0001, 01FC,FC,3A2C
$8D:B23B             dx 0001, 01FC,FC,3A2D
$8D:B242             dx 0001, 01FC,FC,3A2E
$8D:B249             dx 0001, 01FC,FC,3A2F

; Smoke
; Enemy projectile $A9AF (Torizo death explosion)
; Enemy projectile $AB07 (unused. Question mark)
; Enemy projectile $C18C (Mother Brain's room turret bullets)
; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:B250             dx 0001, 81F8,F6,3A76
$8D:B257             dx 0001, 81F8,F4,3A78
$8D:B25E             dx 0001, 81F8,F2,3A98
$8D:B265             dx 0001, 81F8,F0,3A9E

; Unused
$8D:B26C             dx 0001, 01FC,FC,3A25
$8D:B273             dx 0001, 01FC,FC,3A43

; Enemy projectile $C18C (Mother Brain's room turret bullets)
$8D:B27A             dx 0001, 01FC,FC,3A40

; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:B281             dx 0001, 01FC,FC,3A3E
$8D:B288             dx 0001, 01FC,FC,3A3D
$8D:B28F             dx 0001, 01FC,FC,3A41
$8D:B296             dx 0001, 01FC,FC,3A42
$8D:B29D             dx 0004, 0000,00,FA44, 01F8,00,BA44, 0000,F8,7A44, 01F8,F8,3A44
$8D:B2B3             dx 0004, 0000,00,FA45, 0000,F8,7A45, 01F8,00,BA45, 01F8,F8,3A45
$8D:B2C9             dx 0004, 01F8,00,BA46, 0000,00,FA46, 0000,F8,7A46, 01F8,F8,3A46
$8D:B2DF             dx 0001, 01FC,FC,3A42
$8D:B2E6             dx 0001, 01FC,FC,3A4C
$8D:B2ED             dx 0001, 01FC,FC,3A4D
$8D:B2F4             dx 0001, 01FC,FC,3A4E
$8D:B2FB             dx 0001, 01FC,FC,3A4F

; Unused
$8D:B302             dx 0002, 01FF,FC,3A55, 01F7,FC,3A54
$8D:B30E             dx 0003, 01FA,F5,3A56, 0002,FD,3A58, 01FA,FD,3A57
$8D:B31F             dx 0002, 01FD,F7,3A59, 01FD,FF,3A5A
$8D:B32B             dx 0003, 01FE,F5,7A56, 01F6,FD,7A58, 01FE,FD,7A57
$8D:B33C             dx 0002, 01F9,FC,7A55, 0001,FC,7A54
$8D:B348             dx 0003, 01FE,03,FA56, 01F6,FB,FA58, 01FE,FB,FA57
$8D:B359             dx 0002, 01FD,01,BA59, 01FD,F9,BA5A
$8D:B365             dx 0003, 01FA,03,BA56, 0002,FB,BA58, 01FA,FB,BA57
$8D:B376             dx 0002, 0000,FC,3A65, 01F8,FC,3A64
$8D:B382             dx 0003, 0002,FE,3A68, 01FA,FE,3A67, 01FA,F6,3A66
$8D:B393             dx 0002, 01FC,F8,3A69, 01FC,00,3A6A
$8D:B39F             dx 0003, 01F6,FE,7A68, 01FE,FE,7A67, 01FE,F6,7A66
$8D:B3B0             dx 0002, 01F8,FC,7A65, 0000,FC,7A64
$8D:B3BC             dx 0003, 01F6,FA,FA68, 01FE,FA,FA67, 01FE,02,FA66
$8D:B3CD             dx 0002, 01FC,00,BA69, 01FC,F8,BA6A
$8D:B3D9             dx 0003, 0002,FA,BA68, 01FA,FA,BA67, 01FA,02,BA66

; Enemy projectile $E509/$E525 (dust cloud / explosion)
$8D:B3EA             dx 0001, 01FC,FC,3A3C
$8D:B3F1             dx 0001, 01FC,FC,3A3D
$8D:B3F8             dx 0001, 01FC,FC,3A3E

; Unused
$8D:B3FF             dx 0001, 01FC,FC,3A3F

; Big explosion
; Enemy projectile $AF76 (unused)
; Enemy projectile $B31A (Golden Torizo super missile)
; Enemy projectile $CB4B (Mother Brain's blue ring lasers)
; Enemy projectile $E509/$E525 (dust cloud / explosion)
; Enemy projectile $F345 (enemy death explosion)
$8D:B406             dx 0004, 0000,00,FA8A, 01F8,00,BA8A, 0000,F8,7A8A, 01F8,F8,3A8A
$8D:B41C             dx 0004, C200,00,FA90, C200,F0,7A90, C3F0,00,BA90, C3F0,F0,3A90
$8D:B432             dx 0004, C200,00,FA92, C3F0,00,BA92, C200,F0,7A92, C3F0,F0,3A92
$8D:B448             dx 000C, 0010,00,FAC2, 0010,F8,7AC2, 0000,10,FAB2, 01F8,10,BAB2, 01E8,00,BAC2, 01E8,F8,3AC2, 0000,E8,7AB2, 01F8,E8,3AB2, C200,00,FAB0, C200,F0,7AB0, C3F0,00,BAB0, C3F0,F0,3AB0
$8D:B486             dx 0008, C208,00,FAB5, C200,08,FAB3, C3E8,00,BAB5, C3F0,08,BAB3, C208,F0,7AB5, C200,E8,7AB3, C3E8,F0,3AB5, C3F0,E8,3AB3
$8D:B4B0             dx 000C, 0000,10,FABB, 01F8,10,BABB, 0000,E8,7ABB, 01F8,E8,3ABB, 0010,00,FAB7, 0010,F8,7AB7, 01E8,00,BAB7, 01E8,F8,3AB7, C208,08,FAB8, C3E8,08,BAB8, C208,E8,7AB8, C3E8,E8,3AB8

; Enemy projectile $E64B/$E659 (downwards shot gate)
$8D:B4EE             dx 0001, C200,00,2ABE
$8D:B4F5             dx 0002, C200,00,2ABE, C200,F0,2ABE
$8D:B501             dx 0003, C200,00,2ABE, C200,F0,2ABE, C200,E0,2ABE
$8D:B512             dx 0004, C200,00,2ABE, C200,F0,2ABE, C200,E0,2ABE, C200,D0,2ABE

; Enemy projectile $E667/$E675 (upwards shot gate)
$8D:B528             dx 0001, C200,FF,2ABE
$8D:B52F             dx 0002, C200,0F,2ABE, C200,FF,2ABE
$8D:B53B             dx 0003, C200,1F,2ABE, C200,0F,2ABE, C200,FF,2ABE
$8D:B54C             dx 0004, C200,2F,2ABE, C200,1F,2ABE, C200,0F,2ABE, C200,FF,2ABE

; Enemy projectile $E6D2 (save station electricity)
$8D:B562             dx 0004, 0008,E0,7ACD, 0000,E0,7A6F, 01F0,E0,3ACD, 01F8,E0,3A6F
$8D:B578             dx 0004, 0008,E8,7ACD, 0000,E8,7A6F, 01F0,E8,3ACD, 01F8,E8,3A6F
$8D:B58E             dx 0004, 0008,F0,7ACD, 0000,F0,7A6F, 01F0,F0,3ACD, 01F8,F0,3A6F
$8D:B5A4             dx 0004, 0008,F8,7ACD, 0000,F8,7A6F, 01F0,F8,3ACD, 01F8,F8,3A6F
$8D:B5BA             dx 0004, 0008,00,7ACD, 0000,00,7A6F, 01F0,00,3ACD, 01F8,00,3A6F
$8D:B5D0             dx 0004, 0008,08,7ACD, 0000,08,7A6F, 01F0,08,3ACD, 01F8,08,3A6F
$8D:B5E6             dx 0004, 0008,10,7ACD, 0000,10,7A6F, 01F0,10,3ACD, 01F8,10,3A6F
$8D:B5FC             dx 0004, 0008,18,7ACD, 0000,18,7A6F, 01F0,18,3ACD, 01F8,18,3A6F

; Unused. Instruction list $E7FB
$8D:B612             dx 0001, 81F8,F8,2128
$8D:B619             dx 0001, 81F8,F8,212A
$8D:B620             dx 0001, 81F8,F8,212C
$8D:B627             dx 0001, 81F8,F8,212E

; Enemy projectile $EBA0 (Botwoon's body)
$8D:B62E             dx 0001, 81F8,F8,2148
$8D:B635             dx 0001, 81F8,F8,214A
$8D:B63C             dx 0001, 81F8,F8,214C
$8D:B643             dx 0001, 81F8,F8,214E
$8D:B64A             dx 0001, 81F8,F8,2140
$8D:B651             dx 0001, 81F8,F8,2142
$8D:B658             dx 0001, 81F8,F8,2144
$8D:B65F             dx 0001, 81F8,F8,2146
$8D:B666             dx 0001, 81F8,F8,2160
$8D:B66D             dx 0001, 81F8,F8,2162
$8D:B674             dx 0001, 81F8,F8,2164
$8D:B67B             dx 0001, 81F8,F8,2166

; Unused. Instruction list $E84B
$8D:B682             dx 0001, 81F8,F8,2168
$8D:B689             dx 0001, 81F8,F8,216A
$8D:B690             dx 0001, 81F8,F8,216C
$8D:B697             dx 0001, 81F8,F8,216E

; Enemy projectile $EBA0 (Botwoon's body)
$8D:B69E             dx 0001, 81F8,F8,6168
$8D:B6A5             dx 0001, 81F8,F8,616A
$8D:B6AC             dx 0001, 81F8,F8,616C
$8D:B6B3             dx 0001, 81F8,F8,616E
$8D:B6BA             dx 0001, 81F8,F8,6160
$8D:B6C1             dx 0001, 81F8,F8,6162
$8D:B6C8             dx 0001, 81F8,F8,6164
$8D:B6CF             dx 0001, 81F8,F8,6166
$8D:B6D6             dx 0001, 81F8,F8,6140
$8D:B6DD             dx 0001, 81F8,F8,6142
$8D:B6E4             dx 0001, 81F8,F8,6144
$8D:B6EB             dx 0001, 81F8,F8,6146
$8D:B6F2             dx 0001, 81F8,F8,6148
$8D:B6F9             dx 0001, 81F8,F8,614A
$8D:B700             dx 0001, 81F8,F8,614C
$8D:B707             dx 0001, 81F8,F8,614E
$8D:B70E             dx 0001, 81F8,F8,6128
$8D:B715             dx 0001, 81F8,F8,612A
$8D:B71C             dx 0001, 81F8,F8,612C
$8D:B723             dx 0001, 81F8,F8,612E
$8D:B72A             dx 0001, 81F8,F8,21A4
$8D:B731             dx 0001, 81F8,F8,21A2
$8D:B738             dx 0001, 81F8,F8,21A0
$8D:B73F             dx 0001, 81F8,F8,A1A2
$8D:B746             dx 0001, 81F8,F8,A1A4
$8D:B74D             dx 0001, 81F8,F8,E1A2
$8D:B754             dx 0001, 81F8,F8,61A0
$8D:B75B             dx 0001, 81F8,F8,61A2

; Unused. Instruction list $E8F9
$8D:B762             dx 0001, 81F8,F8,0128
$8D:B769             dx 0001, 81F8,F8,012A
$8D:B770             dx 0001, 81F8,F8,012C
$8D:B777             dx 0001, 81F8,F8,012E

; Unused. Instruction list $E90D
$8D:B77E             dx 0001, 81F8,F8,0148
$8D:B785             dx 0001, 81F8,F8,014A
$8D:B78C             dx 0001, 81F8,F8,014C
$8D:B793             dx 0001, 81F8,F8,014E

; Unused. Instruction list $E921
$8D:B79A             dx 0001, 81F8,F8,0140
$8D:B7A1             dx 0001, 81F8,F8,0142
$8D:B7A8             dx 0001, 81F8,F8,0144
$8D:B7AF             dx 0001, 81F8,F8,0146

; Unused. Instruction list $E935
$8D:B7B6             dx 0001, 81F8,F8,0160
$8D:B7BD             dx 0001, 81F8,F8,0162
$8D:B7C4             dx 0001, 81F8,F8,0164
$8D:B7CB             dx 0001, 81F8,F8,0166

; Unused. Instruction list $E949
$8D:B7D2             dx 0001, 81F8,F8,0168
$8D:B7D9             dx 0001, 81F8,F8,016A
$8D:B7E0             dx 0001, 81F8,F8,016C
$8D:B7E7             dx 0001, 81F8,F8,016E

; Unused. Instruction list $E95D
$8D:B7EE             dx 0001, 81F8,F8,4168
$8D:B7F5             dx 0001, 81F8,F8,416A
$8D:B7FC             dx 0001, 81F8,F8,416C
$8D:B803             dx 0001, 81F8,F8,416E

; Unused. Instruction list $E971
$8D:B80A             dx 0001, 81F8,F8,4160
$8D:B811             dx 0001, 81F8,F8,4162
$8D:B818             dx 0001, 81F8,F8,4164
$8D:B81F             dx 0001, 81F8,F8,4166

; Unused. Instruction list $E985
$8D:B826             dx 0001, 81F8,F8,4140
$8D:B82D             dx 0001, 81F8,F8,4142
$8D:B834             dx 0001, 81F8,F8,4144
$8D:B83B             dx 0001, 81F8,F8,4146

; Unused. Instruction list $E999
$8D:B842             dx 0001, 81F8,F8,4148
$8D:B849             dx 0001, 81F8,F8,414A
$8D:B850             dx 0001, 81F8,F8,414C
$8D:B857             dx 0001, 81F8,F8,414E

; Unused. Instruction list $E9AD
$8D:B85E             dx 0001, 81F8,F8,4128
$8D:B865             dx 0001, 81F8,F8,412A
$8D:B86C             dx 0001, 81F8,F8,412C
$8D:B873             dx 0001, 81F8,F8,412E

; Unused. Instruction list $E9C1
$8D:B87A             dx 0001, 81F8,F8,01A4

; Unused. Instruction list $E9C7
$8D:B881             dx 0001, 81F8,F8,01A2

; Unused. Instruction list $E9CD
$8D:B888             dx 0001, 81F8,F8,01A0

; Unused. Instruction list $E9D3
$8D:B88F             dx 0001, 81F8,F8,81A2

; Unused. Instruction list $E9D9
$8D:B896             dx 0001, 81F8,F8,81A4

; Unused. Instruction list $E9DF
$8D:B89D             dx 0001, 81F8,F8,C1A2

; Unused. Instruction list $E9E5
$8D:B8A4             dx 0001, 81F8,F8,41A0

; Unused. Instruction list $E9EB
$8D:B8AB             dx 0001, 81F8,F8,41A2

; Enemy projectile $EBA0 (Botwoon's body)
$8D:B8B2             dx 0000

; Enemy projectile $EC48 (Botwoon's spit)
$8D:B8B4             dx 0001, 01FC,FC,33A8
$8D:B8BB             dx 0001, 01FC,FC,33A9
$8D:B8C2             dx 0001, 01FC,FC,33AA
$8D:B8C9             dx 0001, 01FC,FC,33AB
$8D:B8D0             dx 0001, 01FC,FC,33AC

; Enemy projectile $EC95 (yapping maw's body)
$8D:B8D7             dx 0001, 81F8,F8,210A
$8D:B8DE             dx 0001, 81F8,F8,A10A

; Unused. Instruction list $EE45
$8D:B8E5             dx 0003, 81F0,00,3A76, 81F0,F0,3A76, 8000,F8,3A76
$8D:B8F6             dx 0003, 8004,F8,7A78, 81EC,04,FA78, 81EC,EC,3A78
$8D:B907             dx 0007, 01EB,E2,3A2B, 800C,F8,7A98, 81E8,08,BA98, 81E8,E8,3A98, 000D,E2,7A2B, 0003,03,7A2B, 01F5,03,3A2B
$8D:B92C             dx 0007, 01E5,DC,3A2B, 8010,F8,7A9E, 81E4,0C,BA9E, 81E4,E4,3A9E, 0013,DC,7A2B, 0007,FD,7A2B, 01F1,FD,3A2B
$8D:B951             dx 0007, 01E3,DA,3A2B, 81E0,E0,3A9A, 8014,F8,7A9A, 81E0,10,BA9A, 0015,DA,7A2B, 000B,FA,7A2B, 01ED,FA,3A2B
$8D:B976             dx 0007, 01E2,DA,3A2B, 8018,F8,7A9C, 81DC,14,BA9C, 81DC,DC,3A9C, 0016,DA,7A2B, 000E,F9,7A2B, 01EA,F9,3A2B
$8D:B99B             dx 0004, 0018,DB,7A2A, 0011,FC,7A2A, 01E7,FC,3A2A, 01E0,DB,3A2A
$8D:B9B1             dx 0004, 001A,DC,7A2A, 0012,FC,7A2A, 01E6,FC,3A2A, 01DE,DC,3A2A
$8D:B9C7             dx 0004, 001C,DD,7A29, 0013,FE,7A29, 01E5,FE,3A29, 01DC,DD,3A29
$8D:B9DD             dx 0004, 001E,DE,7A29, 0014,00,7A29, 01E4,00,3A29, 01DA,DE,3A29
$8D:B9F3             dx 0004, 001F,E0,7A28, 0015,02,7A28, 01D9,E0,3A28, 01E3,02,3A28
$8D:BA09             dx 0004, 0020,E2,7A28, 0016,04,7A28, 01D8,E2,3A28, 01E2,04,3A28
$8D:BA1F             dx 0004, 0021,E9,3A28, 0017,0B,3A28, 01E1,0B,3A28, 01D7,E9,3A28
$8D:BA35             dx 0004, 0022,F1,3A28, 0018,13,3A28, 01E0,13,3A28, 01D6,F1,3A28
$8D:BA4B             dx 0004, 0023,FB,3A28, 0019,19,3A28, 01DF,19,3A28, 01D5,FB,3A28
$8D:BA61             dx 0004, 01D4,06,3A28, 01DE,24,3A28, 001A,24,3A28, 0024,06,3A28

; Unused
$8D:BA77             dx 0001, 01F7,F7,3A48
$8D:BA7E             dx 0002, 0001,01,3A48, 81F3,F3,3A7C
$8D:BA8A             dx 0003, 81FD,FD,3A7C, 01F7,01,3A48, 81F3,F3,3A7E
$8D:BA9B             dx 0004, 0001,F7,3A48, 81FD,FD,3A7E, 81F3,FD,3A7C, 81F3,F3,3A9A
$8D:BAB1             dx 0004, 81FD,F3,3A7C, 81FD,FD,3A9A, 81F3,FD,3A7E, 81F3,F3,3A9C
$8D:BAC7             dx 0003, 81FD,F3,3A7E, 81FD,FD,3A9C, 81F3,FD,3A9A
$8D:BAD8             dx 0002, 81FD,F3,3A9A, 81F3,FD,3A9C
$8D:BAE4             dx 0001, 81FD,F3,3A9C
$8D:BAEB             dx 0001, 01FC,FC,3A6B
$8D:BAF2             dx 0001, 01FC,FC,3A6C
$8D:BAF9             dx 0002, 01F8,FC,3A6B, 0000,FC,3A6B
$8D:BB05             dx 0002, 01F8,FC,3A6C, 0000,FC,3A6C
$8D:BB11             dx 0003, 01F4,FC,3A6C, 0004,FC,3A6C, 01FC,FC,3A6C
$8D:BB22             dx 0003, 0004,FC,3A6B, 01F4,FC,3A6B, 01FC,FC,3A6B
$8D:BB33             dx 0004, 0008,FC,3A6C, 0000,FC,3A6C, 01F8,FC,3A6C, 01F0,FC,3A6C
$8D:BB49             dx 0004, 0008,FC,3A6B, 0000,FC,3A6B, 01F8,FC,3A6B, 01F0,FC,3A6B
$8D:BB5F             dx 0001, 01FC,FC,3A25
$8D:BB66             dx 0003, 0000,F8,3A25, 01FA,F6,3A25, 01FC,FB,3A25
$8D:BB77             dx 0003, 0001,F7,3A25, 01F9,F4,3A25, 01FB,FA,3A25
$8D:BB88             dx 0003, 0001,F5,3A43, 01FC,F8,3A43, 01FA,F1,3A43
$8D:BB99             dx 0003, 0001,F3,3A43, 01FC,F5,3A43, 01FA,EE,3A43
$8D:BBAA             dx 0003, 0000,F0,3A40, 01FC,F4,3A40, 01FA,ED,3A40
$8D:BBBB             dx 0003, 0000,EE,3A40, 01FC,F2,3A40, 01FA,EC,3A40
$8D:BBCC             dx 0002, 0000,EC,3A40, 01FC,F0,3A40
$8D:BBD8             dx 0001, 01FC,EE,3A40
$8D:BBDF             dx 0004, 0008,E0,3A6F, 0000,E0,3A6F, 01F8,E0,3A6F, 01F0,E0,3A6F
$8D:BBF5             dx 0004, 0008,E8,3A6F, 0000,E8,3A6F, 01F8,E8,3A6F, 01F0,E8,3A6F
$8D:BC0B             dx 0004, 0008,F0,3A6F, 0000,F0,3A6F, 01F8,F0,3A6F, 01F0,F0,3A6F
$8D:BC21             dx 0004, 0008,F8,3A6F, 0000,F8,3A6F, 01F8,F8,3A6F, 01F0,F8,3A6F
$8D:BC37             dx 0004, 0008,00,3A6F, 0000,00,3A6F, 01F8,00,3A6F, 01F0,00,3A6F
$8D:BC4D             dx 0004, 0008,08,3A6F, 0000,08,3A6F, 01F8,08,3A6F, 01F0,08,3A6F
$8D:BC63             dx 0004, 0008,10,3A6F, 0000,10,3A6F, 01F8,10,3A6F, 01F0,10,3A6F
$8D:BC79             dx 0004, 0008,18,3A6F, 0000,18,3A6F, 01F8,18,3A6F, 01F0,18,3A6F
$8D:BC8F             dx 0002, 0000,FC,3ABF, 01F8,FC,3ABE
$8D:BC9B             dx 0001, 81F8,F8,3ABE
$8D:BCA2             dx 0002, 81F8,FC,3ABE, 81F8,F4,3ABE
$8D:BCAE             dx 0002, 81F8,00,3ABE, 81F8,F0,3ABE
$8D:BCBA             dx 0003, 81F8,04,3ABE, 81F8,F8,3ABE, 81F8,EC,3ABE
$8D:BCCB             dx 0003, 81F8,08,3ABE, 81F8,F8,3ABE, 81F8,E8,3ABE
$8D:BCDC             dx 0004, 81F8,0C,3ABE, 81F8,00,3ABE, 81F8,F0,3ABE, 81F8,E4,3ABE
$8D:BCF2             dx 0004, 81F8,10,3ABE, 81F8,00,3ABE, 81F8,F0,3ABE, 81F8,E0,3ABE
$8D:BD08             dx 0001, 01FC,FC,3C53
$8D:BD0F             dx 0001, 01FC,FC,3C52
$8D:BD16             dx 0001, 01FC,FC,3C51
$8D:BD1D             dx 0004, 01F8,00,BC50, 0000,00,FC50, 0000,F8,7C50, 01F8,F8,3C50
$8D:BD33             dx 0003, 0000,0C,3A5B, 0008,EC,3A5B, 01F0,F4,3A5B
$8D:BD44             dx 0003, 01FD,0A,3A5C, 0006,EE,3A5C, 01F2,F6,3A5C
$8D:BD55             dx 0003, 01FC,08,3A5C, 0004,F0,3A5C, 01F4,F8,3A5C
$8D:BD66             dx 0003, 0002,F2,3A5D, 01FB,06,3A5D, 01F6,FA,3A5D
$8D:BD77             dx 0003, 01FB,04,3A5D, 01F8,FB,3A5D, 0000,F4,3A5D
$8D:BD88             dx 0003, 01FB,02,3A5D, 01FA,FA,3A5D, 0000,F6,3A5D
$8D:BD99             dx 0003, 0000,EC,BA5B, 0008,0C,BA5B, 01F0,04,BA5B
$8D:BDAA             dx 0003, 01FE,EE,BA5C, 0006,0A,BA5C, 01F2,02,BA5C
$8D:BDBB             dx 0003, 0004,08,BA5C, 01F4,00,BA5C, 01FD,F0,BA5C
$8D:BDCC             dx 0003, 0002,06,BA5D, 01FC,F2,BA5D, 01F6,FE,BA5D
$8D:BDDD             dx 0003, 01FC,F4,BA5D, 01F8,FC,BA5D, 0000,04,BA5D
$8D:BDEE             dx 0003, 01FC,F6,BA5D, 01FA,FD,BA5D, 0000,02,BA5D

; Enemy projectile $F345 (enemy death explosion)
$8D:BDFF             dx 0001, 01FC,FC,3A5F
$8D:BE06             dx 0004, 0000,00,FA8A, 01F8,00,BA8A, 0000,F8,7A8A, 01F8,F8,3A8A
$8D:BE1C             dx 0004, 8000,00,FA90, 81F0,00,BA90, 8000,F0,7A90, 81F0,F0,3A90
$8D:BE32             dx 0004, 8000,00,FA92, 81F0,00,BA92, 8000,F0,7A92, 81F0,F0,3A92
$8D:BE48             dx 0004, 8000,00,FA94, 81F0,00,BA94, 8000,F0,7A94, 81F0,F0,3A94
$8D:BE5E             dx 0004, 8000,00,FA96, 81F0,00,BA96, 8000,F0,7A96, 81F0,F0,3A96

; Unused
$8D:BE74             dx 0004, 0000,00,FA8B, 01F8,00,BA8B, 0000,F8,7A8B, 01F8,F8,3A8B
$8D:BE8A             dx 0004, 0000,00,FA7A, 01F8,00,BA7A, 0000,F8,7A7A, 01F8,F8,3A7A
$8D:BEA0             dx 0004, 8000,00,FA70, 81F0,00,BA70, 8000,F0,7A70, 81F0,F0,3A70
$8D:BEB6             dx 0004, 8000,00,FA72, 81F0,00,BA72, 8000,F0,7A72, 81F0,F0,3A72
$8D:BECC             dx 0004, 8000,00,FA74, 81F0,00,BA74, 8000,F0,7A74, 81F0,F0,3A74
$8D:BEE2             dx 0004, 01F8,00,3A5E, 0000,00,3A5E, 0000,F8,3A5E, 01F8,F8,3A5E
$8D:BEF8             dx 0001, 01FC,FC,3C38
$8D:BEFF             dx 0001, 01FC,FC,3C39
$8D:BF06             dx 0001, 01FC,FC,3C3A
$8D:BF0D             dx 0001, 01FC,FC,3C3B

; Enemy projectile $F337/$F345 (pickup / enemy death explosion)
$8D:BF14             dx 0001, 01FC,FC,3A26
$8D:BF1B             dx 0001, 01FC,FC,3A27
$8D:BF22             dx 0001, 01FC,FC,3A7B
$8D:BF29             dx 0001, 01FC,FC,307B

; Unused
$8D:BF30             dx 0001, 01FC,FC,3A5F
$8D:BF37             dx 0001, 01FC,FC,3C53
$8D:BF3E             dx 0001, 01FC,FC,3C51
$8D:BF45             dx 0004, 0000,00,FC60, 0000,F8,7C60, 01F8,00,BC60, 01F8,F8,3C60
$8D:BF5B             dx 0004, 0000,00,FC61, 0000,F8,7C61, 01F8,00,BC61, 01F8,F8,3C61
$8D:BF71             dx 0004, 0000,00,FC62, 0000,F8,7C62, 01F8,00,BC62, 01F8,F8,3C62
$8D:BF87             dx 0004, 0000,00,FC63, 0000,F8,7C63, 01F8,00,BC63, 01F8,F8,3C63
$8D:BF9D             dx 0004, 01F2,FC,7A6C, 0006,FC,7A6C, 0000,FC,7A6C, 01F8,FC,3A6C
$8D:BFB3             dx 0004, 0000,FC,7A6E, 0008,FC,7A6D, 01F8,FC,3A6E, 01F0,FC,3A6D
$8D:BFC9             dx 0004, 01F0,FE,3A6F, 0008,FE,3A6F, 0000,FE,3A6F, 01F8,FE,3A6F
$8D:BFDF             dx 0001, 81F8,F8,3A7C
$8D:BFE6             dx 0001, 81F8,F6,3A7E
$8D:BFED             dx 0001, 81F8,F4,3A9A
$8D:BFF4             dx 0001, 81F8,F2,3A9C
$8D:BFFB             dx 0001, 01FC,FC,3A48
$8D:C002             dx 0001, 01FC,FA,3A49
$8D:C009             dx 0001, 01FC,F8,3A4A
$8D:C010             dx 0001, 01FC,F6,3A4B
$8D:C017             dx 0001, 01FC,FC,3A2C
$8D:C01E             dx 0001, 01FC,FC,3A2D
$8D:C025             dx 0001, 01FC,FC,3A2E
$8D:C02C             dx 0001, 01FC,FC,3A2F
$8D:C033             dx 0001, 81F8,F6,3A76
$8D:C03A             dx 0001, 81F8,F4,3A78
$8D:C041             dx 0001, 81F8,F2,3A98
$8D:C048             dx 0001, 81F8,F0,3A9E
$8D:C04F             dx 0001, 01FC,FC,3A25
$8D:C056             dx 0001, 01FC,FC,3A43
$8D:C05D             dx 0001, 01FC,FC,3A40

; Enemy projectile $F337/$F345 (pickup / enemy death explosion)
$8D:C064             dx 0001, 01FC,FC,3A3E
$8D:C06B             dx 0001, 01FC,FC,3A3D
$8D:C072             dx 0001, 01FC,FC,3A41
$8D:C079             dx 0001, 01FC,FC,3A42

; Enemy projectile $F337/$F345 (pickup / enemy death explosion)
$8D:C080             dx 0004, 0000,00,FA44, 01F8,00,BA44, 0000,F8,7A44, 01F8,F8,3A44
$8D:C096             dx 0004, 0000,00,FA45, 0000,F8,7A45, 01F8,00,BA45, 01F8,F8,3A45
$8D:C0AC             dx 0004, 01F8,00,BA46, 0000,00,FA46, 0000,F8,7A46, 01F8,F8,3A46
$8D:C0C2             dx 0001, 01FC,FC,3A42

; Unused. Instruction list $EDC7
$8D:C0C9             dx 0001, 01FC,FC,3A4C
$8D:C0D0             dx 0001, 01FC,FC,3A4D
$8D:C0D7             dx 0001, 01FC,FC,3A4E
$8D:C0DE             dx 0001, 01FC,FC,3A4F

; Unused
$8D:C0E5             dx 0002, 01FF,FC,3A55, 01F7,FC,3A54
$8D:C0F1             dx 0003, 01FA,F5,3A56, 0002,FD,3A58, 01FA,FD,3A57

; Enemy projectile $F337/$F345 (pickup / enemy death explosion)
$8D:C102             dx 0002, 01FD,F7,3A59, 01FD,FF,3A5A
$8D:C10E             dx 0002, 01FD,F7,3059, 01FD,FF,305A

; Unused
$8D:C11A             dx 0003, 01FE,F5,7A56, 01F6,FD,7A58, 01FE,FD,7A57
$8D:C12B             dx 0002, 01F9,FC,7A55, 0001,FC,7A54
$8D:C137             dx 0003, 01FE,03,FA56, 01F6,FB,FA58, 01FE,FB,FA57
$8D:C148             dx 0002, 01FD,01,BA59, 01FD,F9,BA5A
$8D:C154             dx 0003, 01FA,03,BA56, 0002,FB,BA58, 01FA,FB,BA57
$8D:C165             dx 0002, 0000,FC,3A65, 01F8,FC,3A64
$8D:C171             dx 0003, 0002,FE,3A68, 01FA,FE,3A67, 01FA,F6,3A66

; Enemy projectile $F337/$F345 (pickup / enemy death explosion)
$8D:C182             dx 0002, 01FC,F8,3A69, 01FC,00,3A6A
$8D:C18E             dx 0002, 01FC,F8,3069, 01FC,00,306A

; Unused
$8D:C19A             dx 0003, 01F6,FE,7A68, 01FE,FE,7A67, 01FE,F6,7A66
$8D:C1AB             dx 0002, 01F8,FC,7A65, 0000,FC,7A64
$8D:C1B7             dx 0003, 01F6,FA,FA68, 01FE,FA,FA67, 01FE,02,FA66
$8D:C1C8             dx 0002, 01FC,00,BA69, 01FC,F8,BA6A
$8D:C1D4             dx 0003, 0002,FA,BA68, 01FA,FA,BA67, 01FA,02,BA66
$8D:C1E5             dx 0001, 01FC,FC,3A3C
$8D:C1EC             dx 0001, 01FC,FC,3A3D
$8D:C1F3             dx 0001, 01FC,FC,3A3E
$8D:C1FA             dx 0001, 01FC,FC,3A3F
$8D:C201             dx 0004, 0000,00,FA8A, 01F8,00,BA8A, 0000,F8,7A8A, 01F8,F8,3A8A
$8D:C217             dx 0004, C200,00,FA90, C200,F0,7A90, C3F0,00,BA90, C3F0,F0,3A90
$8D:C22D             dx 0004, C200,00,FA92, C3F0,00,BA92, C200,F0,7A92, C3F0,F0,3A92
$8D:C243             dx 000C, 0010,00,FAC2, 0010,F8,7AC2, 0000,10,FAB2, 01F8,10,BAB2, 01E8,00,BAC2, 01E8,F8,3AC2, 0000,E8,7AB2, 01F8,E8,3AB2, C200,00,FAB0, C200,F0,7AB0, C3F0,00,BAB0, C3F0,F0,3AB0
$8D:C281             dx 0008, C208,00,FAB5, C200,08,FAB3, C3E8,00,BAB5, C3F0,08,BAB3, C208,F0,7AB5, C200,E8,7AB3, C3E8,F0,3AB5, C3F0,E8,3AB3
$8D:C2AB             dx 000C, 0000,10,FABB, 01F8,10,BABB, 0000,E8,7ABB, 01F8,E8,3ABB, 0010,00,FAB7, 0010,F8,7AB7, 01E8,00,BAB7, 01E8,F8,3AB7, C208,08,FAB8, C3E8,08,BAB8, C208,E8,7AB8, C3E8,E8,3AB8

; Enemy projectile $F345 (enemy death explosion)
$8D:C2E9             dx 0004, 8000,00,FA90, 81F0,00,BA90, 8000,F0,7A90, 81F0,F0,3A90
$8D:C2FF             dx 0008, 81EB,EB,3A76, 81EB,05,BA76, 8005,05,FA76, 8006,EB,7A76, 8000,00,FA92, 81FF,F0,7A92, 81F0,00,BA92, 81F0,F0,3A92
$8D:C329             dx 0008, 8000,00,FA94, 81F0,00,BA94, 8000,F0,7A94, 81F0,F0,3A94, 81E2,E2,3A78, 800E,E2,7A78, 81E2,0E,BA78, 800E,0E,FA78
$8D:C353             dx 0008, 8000,00,FA96, 8000,F0,7A96, 81F0,00,BA96, 81F0,F0,3A96, 8014,DC,7A98, 81DC,DC,3A98, 81DC,14,BA98, 8014,14,FA98
$8D:C37D             dx 0008, 01EF,FA,3A2B, 0009,FA,3A2B, 000C,EC,3A2B, 01EC,EC,3A2B, 81D8,D8,3A9E, 81D8,18,BA9E, 8018,18,FA9E, 8018,D8,7A9E
$8D:C3A7             dx 0008, 81D6,D6,3A9C, 801A,D6,7A9C, 81D6,1A,BA9C, 801A,1A,FA9C, 0012,E8,3A2B, 000C,F9,3A2B, 01EC,F9,3A2B, 01E6,E8,3A2B
$8D:C3D1             dx 0004, 0017,E7,7A2A, 000D,FA,7A2A, 01EB,FA,3A2A, 01E1,E7,3A2A
$8D:C3E7             dx 0004, 001B,E8,7A2A, 000E,FC,7A2A, 01EA,FC,3A2A, 01DD,E8,3A2A
$8D:C3FD             dx 0004, 001E,E9,7A29, 000F,FE,7A29, 01E9,FE,3A29, 01DA,E9,3A29
$8D:C413             dx 0004, 0020,EA,7A29, 0010,00,7A29, 01E8,00,3A29, 01D8,EA,3A29
$8D:C429             dx 0004, 0023,EC,7A28, 0011,02,7A28, 01D5,EC,3A28, 01E7,02,3A28
$8D:C43F             dx 0004, 0027,EE,7A28, 0012,04,7A28, 01D1,EE,3A28, 01E6,04,3A28
$8D:C455             dx 0004, 0029,F1,7A28, 0013,07,7A28, 01CF,F1,3A28, 01E5,07,3A28
$8D:C46B             dx 0004, 002D,F5,7A28, 0014,0B,7A28, 01CB,F5,3A28, 01E4,0B,3A28
$8D:C481             dx 0004, 0033,FF,7A28, 0015,11,7A28, 01C5,FF,3A28, 01E3,11,3A28
$8D:C497             dx 0004, 0039,0A,7A28, 0018,22,7A28, 01BF,0A,3A28, 01E0,22,3A28

; Enemy projectile $F498 (sparks)
$8D:C4AD             dx 0001, 01FC,FC,210B
$8D:C4B4             dx 0001, 01FC,FC,210C
$8D:C4BB             dx 0001, 01FC,FC,210D
}


;;; $C4C2: Enable palette FX objects ;;;
{
$8D:C4C2 08          PHP
$8D:C4C3 C2 20       REP #$20
$8D:C4C5 A9 00 80    LDA #$8000
$8D:C4C8 0C 79 1E    TSB $1E79  [$7E:1E79]
$8D:C4CB 28          PLP
$8D:C4CC 6B          RTL
}


;;; $C4CD: Disable palette FX objects ;;;
{
$8D:C4CD 08          PHP
$8D:C4CE C2 20       REP #$20
$8D:C4D0 A9 00 80    LDA #$8000
$8D:C4D3 1C 79 1E    TRB $1E79  [$7E:1E79]
$8D:C4D6 28          PLP
$8D:C4D7 6B          RTL
}


;;; $C4D8: Clear palette FX objects ;;;
{
$8D:C4D8 08          PHP
$8D:C4D9 C2 30       REP #$30
$8D:C4DB DA          PHX
$8D:C4DC A2 0E 00    LDX #$000E             ;\
                                            ;|
$8D:C4DF 9E 7D 1E    STZ $1E7D,x[$7E:1E8B]  ;|
$8D:C4E2 CA          DEX                    ;} Palette FX object IDs = 0
$8D:C4E3 CA          DEX                    ;|
$8D:C4E4 10 F9       BPL $F9    [$C4DF]     ;/
$8D:C4E6 FA          PLX
$8D:C4E7 28          PLP
$8D:C4E8 6B          RTL
}


;;; $C4E9: Spawn palette FX object ;;;
{
;; Parameter:
;;     Y: Palette FX object ID
;; Returns:
;;     Y: Palette FX object index if carry clear
$8D:C4E9 08          PHP
$8D:C4EA 8B          PHB
$8D:C4EB DA          PHX
$8D:C4EC 4B          PHK                    ;\
$8D:C4ED AB          PLB                    ;} DB = $8D
$8D:C4EE A2 0E 00    LDX #$000E             ; X = Eh (palette FX object index)

; LOOP
$8D:C4F1 BD 7D 1E    LDA $1E7D,x[$7E:1E8B]  ;\
$8D:C4F4 F0 09       BEQ $09    [$C4FF]     ;} If [palette FX object ID] != 0:
$8D:C4F6 CA          DEX                    ;\
$8D:C4F7 CA          DEX                    ;} X -= 2
$8D:C4F8 10 F7       BPL $F7    [$C4F1]     ; If [X] >= 0: go to LOOP
$8D:C4FA FA          PLX
$8D:C4FB AB          PLB
$8D:C4FC 28          PLP
$8D:C4FD 38          SEC                    ;\
$8D:C4FE 6B          RTL                    ;} Return carry set

$8D:C4FF 98          TYA                    ;\
$8D:C500 9D 7D 1E    STA $1E7D,x[$7E:1E8B]  ;} Palette FX object ID = [Y]
$8D:C503 9E 8D 1E    STZ $1E8D,x[$7E:1E9B]  ; Palette FX object colour index = 0
$8D:C506 A9 26 C5    LDA #$C526             ;\
$8D:C509 9D AD 1E    STA $1EAD,x[$7E:1EBB]  ;} Palette FX object pre-instruction = RTS
$8D:C50C B9 02 00    LDA $0002,y[$8D:E1A2]  ;\
$8D:C50F 9D BD 1E    STA $1EBD,x[$7E:1ECB]  ;} Palette FX object instruction list pointer = [[Y] + 2]
$8D:C512 A9 01 00    LDA #$0001             ;\
$8D:C515 9D CD 1E    STA $1ECD,x[$7E:1EDB]  ;} Palette FX object instruction timer = 1
$8D:C518 9E DD 1E    STZ $1EDD,x[$7E:1EEB]  ; Palette FX object timer = 0
$8D:C51B 8A          TXA                    ;\
$8D:C51C BB          TYX                    ;} X = [palette FX object ID], Y = (palette FX object index)
$8D:C51D A8          TAY                    ;/
$8D:C51E FC 00 00    JSR ($0000,x)[$8D:C685]; Execute [[X]]
$8D:C521 FA          PLX
$8D:C522 AB          PLB
$8D:C523 28          PLP
$8D:C524 18          CLC                    ;\
$8D:C525 6B          RTL                    ;} Return carry clear
}


;;; $C526: RTS ;;;
{
$8D:C526 60          RTS
}


;;; $C527: Palette FX object handler ;;;
{
$8D:C527 08          PHP
$8D:C528 8B          PHB
$8D:C529 4B          PHK                    ;\
$8D:C52A AB          PLB                    ;} DB = $8D
$8D:C52B C2 30       REP #$30
$8D:C52D 2C 79 1E    BIT $1E79  [$7E:1E79]  ;\
$8D:C530 10 15       BPL $15    [$C547]     ;} If palette FX objects not enabled: return
$8D:C532 A2 0E 00    LDX #$000E             ; X = Eh (palette FX object index)

; LOOP
$8D:C535 8E 7B 1E    STX $1E7B  [$7E:1E7B]  ; Palette FX object index = [X]
$8D:C538 BD 7D 1E    LDA $1E7D,x[$7E:1E8B]  ;\
$8D:C53B F0 06       BEQ $06    [$C543]     ;} If [palette FX object ID] != 0:
$8D:C53D 20 4A C5    JSR $C54A  [$8D:C54A]  ; Process palette FX object
$8D:C540 AE 7B 1E    LDX $1E7B  [$7E:1E7B]  ; X = [palette FX object index]

$8D:C543 CA          DEX                    ;\
$8D:C544 CA          DEX                    ;} X -= 2
$8D:C545 10 EE       BPL $EE    [$C535]     ; If [X] >= 0: go to LOOP

$8D:C547 AB          PLB
$8D:C548 28          PLP
$8D:C549 6B          RTL
}


;;; $C54A: Process palette FX object ;;;
{
;; Parameters:
;;     X: Palette FX object index

; Some instructions pop the return address pushed to the stack by $C578 (marked "terminate processing palette FX object")
; The delete instruction does so to return out of *this* routine
; The done instruction does so to exit the write colours loop
$8D:C54A C2 30       REP #$30
$8D:C54C FC AD 1E    JSR ($1EAD,x)[$8D:C526]; Execute [palette FX object pre-instruction]
$8D:C54F AE 7B 1E    LDX $1E7B  [$7E:1E7B]  ; X = [palette FX object index]
$8D:C552 DE CD 1E    DEC $1ECD,x[$7E:1EDB]  ; Decrement palette FX object instruction timer
$8D:C555 D0 3D       BNE $3D    [$C594]     ; If [palette FX object instruction timer] != 0: return
$8D:C557 BD BD 1E    LDA $1EBD,x[$7E:1ECB]  ;\
$8D:C55A A8          TAY                    ;} Y = [palette FX object instruction list pointer]

; LOOP_DETERMINE_COLOUR_INDEX
$8D:C55B B9 00 00    LDA $0000,y[$8D:C7FA]  ;\
$8D:C55E 10 0A       BPL $0A    [$C56A]     ;} If [[Y]] is negative:
$8D:C560 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]] (ASM instruction pointer)
$8D:C562 C8          INY                    ;\
$8D:C563 C8          INY                    ;} Y += 2
$8D:C564 F4 5A C5    PEA $C55A              ; Return to LOOP_DETERMINE_COLOUR_INDEX
$8D:C567 6C 12 00    JMP ($0012)[$8D:C655]  ; Execute ASM instruction

$8D:C56A 9D CD 1E    STA $1ECD,x[$7E:1EDB]  ; Palette FX object instruction timer = [[Y]]
$8D:C56D BD 8D 1E    LDA $1E8D,x[$7E:1E9B]  ;\
$8D:C570 AA          TAX                    ;} X = [palette FX object colour index] (colour index)

; LOOP_WRITE_COLOURS
$8D:C571 B9 02 00    LDA $0002,y[$8D:C800]  ;\
$8D:C574 10 08       BPL $08    [$C57E]     ;} If [[Y] + 2] is negative:
$8D:C576 85 12       STA $12    [$7E:0012]  ; $12 = [[Y] + 2] (ASM instruction pointer)
$8D:C578 F4 70 C5    PEA $C570              ; Return to LOOP_WRITE_COLOURS
$8D:C57B 6C 12 00    JMP ($0012)[$8D:C595]  ; Execute ASM instruction

$8D:C57E 9F 00 C0 7E STA $7EC000,x[$7E:C054]; $7E:C000 + [colour index] = [[Y] + 2]
$8D:C582 E8          INX                    ;\
$8D:C583 E8          INX                    ;} Colour index += 2
$8D:C584 C8          INY                    ;\
$8D:C585 C8          INY                    ;} Y += 2
$8D:C586 4C 71 C5    JMP $C571  [$8D:C571]  ; Go to LOOP_WRITE_COLOURS

; Eventually, the ASM processing will jump here (via $C595)
$8D:C589 AE 7B 1E    LDX $1E7B  [$7E:1E7B]  ;\
$8D:C58C 98          TYA                    ;|
$8D:C58D 18          CLC                    ;} Palette FX object instruction list pointer = [Y] + 4
$8D:C58E 69 04 00    ADC #$0004             ;|
$8D:C591 9D BD 1E    STA $1EBD,x[$7E:1ECB]  ;/

$8D:C594 60          RTS
}


;;; $C595..C684: Instructions ;;;
{
;;; $C595: Instruction - done ;;;
{
$8D:C595 68          PLA                    ; Terminate processing palette FX object
$8D:C596 4C 89 C5    JMP $C589  [$8D:C589]  ; Go to $C589 (break out of instruction loop)
}


;;; $C599: Instruction - colour index += 4 ;;;
{
;; Parameters:
;;     X: Colour index
;;     Y: Pointer to this instruction - 2
;; Returns:
;;     X: Colour index
;;     Y: Pointer to next instruction - 2
$8D:C599 8A          TXA
$8D:C59A 18          CLC
$8D:C59B 69 04 00    ADC #$0004
$8D:C59E AA          TAX
$8D:C59F C8          INY
$8D:C5A0 C8          INY
$8D:C5A1 60          RTS
}


;;; $C5A2: Instruction - colour index += 6 ;;;
{
;; Parameters:
;;     X: Colour index
;;     Y: Pointer to this instruction - 2
;; Returns:
;;     X: Colour index
;;     Y: Pointer to next instruction - 2
$8D:C5A2 8A          TXA
$8D:C5A3 18          CLC
$8D:C5A4 69 06 00    ADC #$0006
$8D:C5A7 AA          TAX
$8D:C5A8 C8          INY
$8D:C5A9 C8          INY
$8D:C5AA 60          RTS
}


;;; $C5AB: Instruction - colour index += 8 ;;;
{
;; Parameters:
;;     X: Colour index
;;     Y: Pointer to this instruction - 2
;; Returns:
;;     X: Colour index
;;     Y: Pointer to next instruction - 2
$8D:C5AB 8A          TXA
$8D:C5AC 18          CLC
$8D:C5AD 69 08 00    ADC #$0008
$8D:C5B0 AA          TAX
$8D:C5B1 C8          INY
$8D:C5B2 C8          INY
$8D:C5B3 60          RTS
}


;;; $C5B4: Instruction - colour index += 10h ;;;
{
;; Parameters:
;;     X: Colour index
;;     Y: Pointer to this instruction - 2
;; Returns:
;;     X: Colour index
;;     Y: Pointer to next instruction - 2
$8D:C5B4 8A          TXA
$8D:C5B5 18          CLC
$8D:C5B6 69 10 00    ADC #$0010
$8D:C5B9 AA          TAX
$8D:C5BA C8          INY
$8D:C5BB C8          INY
$8D:C5BC 60          RTS
}


;;; $C5BD: Instruction - colour index += 12h ;;;
{
;; Parameters:
;;     X: Colour index
;;     Y: Pointer to this instruction - 2
;; Returns:
;;     X: Colour index
;;     Y: Pointer to next instruction - 2
$8D:C5BD 8A          TXA
$8D:C5BE 18          CLC
$8D:C5BF 69 12 00    ADC #$0012
$8D:C5C2 AA          TAX
$8D:C5C3 C8          INY
$8D:C5C4 C8          INY
$8D:C5C5 60          RTS
}


;;; $C5C6: Unused. Instruction - colour index += 1Eh ;;;
{
;; Parameters:
;;     X: Colour index
;;     Y: Pointer to this instruction - 2
;; Returns:
;;     X: Colour index
;;     Y: Pointer to next instruction - 2
$8D:C5C6 8A          TXA
$8D:C5C7 18          CLC
$8D:C5C8 69 1E 00    ADC #$001E
$8D:C5CB AA          TAX
$8D:C5CC C8          INY
$8D:C5CD C8          INY
$8D:C5CE 60          RTS
}


;;; $C5CF: Instruction - delete ;;;
{
;; Parameters:
;;     X: Palette FX object index
$8D:C5CF 9E 7D 1E    STZ $1E7D,x[$7E:1E8B]  ; Palette FX object ID = 0
$8D:C5D2 68          PLA                    ; Terminate processing palette FX object
$8D:C5D3 60          RTS
}


;;; $C5D4: Instruction - pre-instruction = [[Y]] ;;;
{
;; Parameters:
;;     X: Palette FX object index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C5D4 B9 00 00    LDA $0000,y[$8D:EB3D]
$8D:C5D7 9D AD 1E    STA $1EAD,x[$7E:1EBB]
$8D:C5DA C8          INY
$8D:C5DB C8          INY
$8D:C5DC 60          RTS
}


;;; $C5DD: Unused. Instruction - clear pre-instruction ;;;
{
;; Parameters:
;;     X: Palette FX object index
$8D:C5DD A9 E3 C5    LDA #$C5E3
$8D:C5E0 9D AD 1E    STA $1EAD,x
$8D:C5E3 60          RTS
}


;;; $C5E4: Unused. Instruction - call external function [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C5E4 B9 00 00    LDA $0000,y
$8D:C5E7 85 12       STA $12    [$7E:0012]
$8D:C5E9 B9 01 00    LDA $0001,y
$8D:C5EC 85 13       STA $13    [$7E:0013]
$8D:C5EE 5A          PHY
$8D:C5EF 22 FB C5 8D JSL $8DC5FB[$8D:C5FB]
$8D:C5F3 7A          PLY
$8D:C5F4 AE 7B 1E    LDX $1E7B  [$7E:1E7B]
$8D:C5F7 C8          INY
$8D:C5F8 C8          INY
$8D:C5F9 C8          INY
$8D:C5FA 60          RTS

$8D:C5FB DC 12 00    JML [$0012]
}


;;; $C5FE: Unused. Instruction - call external function [[Y]] with A = [[Y] + 3] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C5FE B9 00 00    LDA $0000,y
$8D:C601 85 12       STA $12    [$7E:0012]
$8D:C603 B9 01 00    LDA $0001,y
$8D:C606 85 13       STA $13    [$7E:0013]
$8D:C608 B9 03 00    LDA $0003,y
$8D:C60B 5A          PHY
$8D:C60C 22 1B C6 8D JSL $8DC61B[$8D:C61B]
$8D:C610 7A          PLY
$8D:C611 AE 7B 1E    LDX $1E7B  [$7E:1E7B]
$8D:C614 98          TYA
$8D:C615 18          CLC
$8D:C616 69 05 00    ADC #$0005
$8D:C619 A8          TAY
$8D:C61A 60          RTS

$8D:C61B DC 12 00    JML [$0012]
}


;;; $C61E: Instruction - go to [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C61E B9 00 00    LDA $0000,y[$8D:C878]
$8D:C621 A8          TAY
$8D:C622 60          RTS
}


;;; $C623: Unused. Instruction - go to [Y] + ±[[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C623 84 12       STY $12    [$7E:0012]
$8D:C625 88          DEY
$8D:C626 B9 00 00    LDA $0000,y
$8D:C629 EB          XBA
$8D:C62A 30 05       BMI $05    [$C631]
$8D:C62C 29 FF 00    AND #$00FF
$8D:C62F 80 03       BRA $03    [$C634]

$8D:C631 09 00 FF    ORA #$FF00

$8D:C634 18          CLC
$8D:C635 65 12       ADC $12    [$7E:0012]
$8D:C637 A8          TAY
$8D:C638 60          RTS
}


;;; $C639: Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
;; Parameters:
;;     X: Palette FX object index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C639 DE DD 1E    DEC $1EDD,x[$7E:1EEB]
$8D:C63C D0 E0       BNE $E0    [$C61E]
$8D:C63E C8          INY
$8D:C63F C8          INY
$8D:C640 60          RTS
}


;;; $C641: Unused. Instruction - decrement timer and go to [Y] + ±[[Y]] if non-zero ;;;
{
;; Parameters:
;;     X: Palette FX object index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C641 DE DD 1E    DEC $1EDD,x
$8D:C644 D0 DD       BNE $DD    [$C623]
$8D:C646 C8          INY
$8D:C647 60          RTS
}


;;; $C648: Instruction - timer = [[Y]] ;;;
{
;; Parameters:
;;     X: Palette FX object index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C648 E2 20       SEP #$20
$8D:C64A B9 00 00    LDA $0000,y[$8D:EB59]
$8D:C64D 9D DD 1E    STA $1EDD,x[$7E:1EEB]
$8D:C650 C2 20       REP #$20
$8D:C652 C8          INY
$8D:C653 60          RTS
}


;;; $C654: Unused. RTS ;;;
{
$8D:C654 60          RTS
}


;;; $C655: Instruction - palette FX object colour index = [[Y]] ;;;
{
;; Parameters:
;;     X: Palette FX object index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C655 B9 00 00    LDA $0000,y[$8D:C7FC]
$8D:C658 9D 8D 1E    STA $1E8D,x[$7E:1E9B]
$8D:C65B C8          INY
$8D:C65C C8          INY
$8D:C65D 60          RTS
}


;;; $C65E: Unused. Instruction - queue music track [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C65E B9 00 00    LDA $0000,y
$8D:C661 29 FF 00    AND #$00FF
$8D:C664 22 C1 8F 80 JSL $808FC1[$80:8FC1]
$8D:C668 C8          INY
$8D:C669 60          RTS
}


;;; $C66A: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 6 ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C66A B9 00 00    LDA $0000,y
$8D:C66D 22 49 90 80 JSL $809049[$80:9049]
$8D:C671 C8          INY
$8D:C672 60          RTS
}


;;; $C673: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 6 ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C673 B9 00 00    LDA $0000,y[$8D:F051]
$8D:C676 22 CB 90 80 JSL $8090CB[$80:90CB]
$8D:C67A C8          INY
$8D:C67B 60          RTS
}


;;; $C67C: Unused. Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 6 ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:C67C B9 00 00    LDA $0000,y
$8D:C67F 22 4D 91 80 JSL $80914D[$80:914D]
$8D:C683 C8          INY
$8D:C684 60          RTS
}
}


;;; $C685: RTS ;;;
{
$8D:C685 60          RTS
}


;;; $C686: Unused ;;;
{
; Looks like garbage data
$8D:C686             dw 1000, C690, C595, C61E, C686, 0180, 0000, 0000
}


;;; $C696..E193: Instruction lists - misc. ;;;
{
;;; $C696: Instruction list - palette FX object $E194 (fade in Super Metroid title logo) ;;;
{
$8D:C696             dx C655,0142,  ; Palette FX object colour index = 0142h
                        0003,
                            0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0003,
                            1084,0084,0064,0064,0044,0024,0004,0004,0003,0002,0401,0400,0C63,0421,0000,
                            C595,       ; Done
                        0003,
                            2108,0508,00E8,00C8,0088,0048,0028,0008,0006,0405,0803,0C01,18C6,0C42,0400,
                            C595,       ; Done
                        0003,
                            35AD,05AD,056D,052D,00CD,008D,004D,000D,000A,0407,0C05,1422,2529,1484,0400,
                            C595,       ; Done
                        0003,
                            4631,0A31,05D1,0591,0531,00B1,0051,0011,000D,080A,1026,1823,318C,1CA5,0800,
                            C595,       ; Done
                        0003,
                            5AD6,0AD6,0A56,09F6,0576,00F6,0076,0016,0011,080C,1428,2044,3DEF,24E7,0800,
                            C595,       ; Done
                        0003,
                            6B5A,0F5A,0ADA,0A5A,05BA,011A,009A,001A,0014,0C0F,182A,2845,4A52,2D08,0C00,
                            C595,       ; Done
                        0003,
                            7FFF,13FF,0F5F,0EBF,0A1F,055F,04BF,001F,0018,1032,204C,3066,5AB5,354A,1000,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $C7AC: Instruction list - palette FX object $E198 (fade in Nintendo boot logo) ;;;
{
$8D:C7AC             dx C655,0132,  ; Palette FX object colour index = 0132h
}


;;; $C7B0: Instruction list - common section of $C7AC / $C7F2 ;;;
{
$8D:C7B0             dx 0003,
                            0C63,0C20,
                            C595,       ; Done
                        0003,
                            1CE7,1C60,
                            C595,       ; Done
                        0003,
                            2D6B,2C80,
                            C595,       ; Done
                        0003,
                            3DEF,3CC0,
                            C595,       ; Done
                        0003,
                            4E73,4CE0,
                            C595,       ; Done
                        0003,
                            5EF7,5D20,
                            C595,       ; Done
                        0003,
                            6F7B,6D40,
                            C595,       ; Done
                        0003,
                            7FFF,7D80,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $C7F2: Instruction list - palette FX object $E19C (fade in Nintendo copyright) ;;;
{
$8D:C7F2             dx C655,0192,  ; Palette FX object colour index = 0192h
                        C61E,C7B0   ; Go to $C7B0
}


;;; $C7FA: Instruction list - palette FX object $E1A0 (title screen baby metroid tube light) ;;;
{
$8D:C7FA             dx C655,0054,  ; Palette FX object colour index = 0054h
$8D:C7FE             dx 000A,
                            0113,000F,175C,0299,
                            C595,       ; Done
                        000A,
                            00B0,000C,0AF9,0236,
                            C595,       ; Done
                        000A,
                            006D,0009,0296,01D3,
                            C595,       ; Done
                        000A,
                            000A,0006,0233,0170,
                            C595,       ; Done
                        000A,
                            0007,0003,01D0,010D,
                            C595,       ; Done
                        000A,
                            000A,0006,0233,0170,
                            C595,       ; Done
                        000A,
                            006D,0009,0296,01D3,
                            C595,       ; Done
                        000A,
                            00B0,000C,0AF9,0236,
                            C595,       ; Done
                        C61E,C7FE   ; Go to $C7FE
}


;;; $C862: Instruction list - palette FX object $E1A4 (title screen flickering displays) ;;;
{
$8D:C862             dx C655,005C,  ; Palette FX object colour index = 005Ch
$8D:C866             dx 0001,
                            13FF,0BB1,
                            C595,       ; Done
                        0001,
                            00AC,0145,
                            C595,       ; Done
                        C61E,C866   ; Go to $C866
}


;;; $C87A: Instruction list - palette FX object $E1A8 (cutscene gunship engine flicker) ;;;
{
$8D:C87A             dx C655,00BE,  ; Palette FX object colour index = 00BEh
$8D:C87E             dx 0001,
                            7FFF,
                            C595,       ; Done
                        0001,
                            0000,
                            C595,       ; Done
                        C61E,C87E   ; Go to $C87E
}


;;; $C88E: Instruction list - palette FX object $E1AC (cutscene Ceres navigation lights - sprite Ceres) ;;;
{
$8D:C88E             dx C655,01DA,  ; Palette FX object colour index = 01DAh
}


;;; $C892: Instruction list - common section of $C88E / $C906 ;;;
{
$8D:C892             dx 0004,
                            001F,0000,
                            C595,       ; Done
                        0004,
                            001B,0004,
                            C595,       ; Done
                        0004,
                            0016,0009,
                            C595,       ; Done
                        0004,
                            0012,000D,
                            C595,       ; Done
                        0004,
                            000D,0012,
                            C595,       ; Done
                        0004,
                            0009,0016,
                            C595,       ; Done
                        0004,
                            0004,001B,
                            C595,       ; Done
                        0004,
                            0000,001F,
                            C595,       ; Done
                        0004,
                            0004,001B,
                            C595,       ; Done
                        0004,
                            0009,0016,
                            C595,       ; Done
                        0004,
                            000D,0012,
                            C595,       ; Done
                        0004,
                            0012,000D,
                            C595,       ; Done
                        0004,
                            0016,0009,
                            C595,       ; Done
                        0004,
                            001B,0004,
                            C595,       ; Done
                        C61E,C892   ; Go to $C892
}


;;; $C906: Instruction list - palette FX object $E1B8 (cutscene Ceres navigation lights - BG Ceres) ;;;
{
$8D:C906             dx C655,00DA,  ; Palette FX object colour index = 00DAh
                        C61E,C892   ; Go to $C892
}


;;; $C90E: Instruction list - palette FX object $E1B0 (fade in PLANET ZEBES text) ;;;
{
$8D:C90E             dx C655,0102,  ; Palette FX object colour index = 0102h
                        0003,
                            0000,0000,0000,
                            C595,       ; Done
                        0003,
                            1084,0C63,0421,
                            C595,       ; Done
                        0003,
                            2529,1CE7,0C63,
                            C595,       ; Done
                        0003,
                            35AD,294A,1084,
                            C595,       ; Done
                        0003,
                            4A52,39CE,18C6,
                            C595,       ; Done
                        0003,
                            5AD6,4631,1CE7,
                            C595,       ; Done
                        0003,
                            6F7B,56B5,2529,
                            C595,       ; Done
                        0003,
                            7FFF,6318,294A,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $C964: Instruction list - palette FX object $E1B4 (fade out PLANET ZEBES text) ;;;
{
$8D:C964             dx C655,0102,  ; Palette FX object colour index = 0102h
                        0003,
                            7FFF,6318,294A,
                            C595,       ; Done
                        0003,
                            6F7B,56B5,2529,
                            C595,       ; Done
                        0003,
                            5AD6,4631,1CE7,
                            C595,       ; Done
                        0003,
                            4A52,39CE,18C6,
                            C595,       ; Done
                        0003,
                            35AD,294A,1084,
                            C595,       ; Done
                        0003,
                            2529,1CE7,0C63,
                            C595,       ; Done
                        0003,
                            1084,0C63,0421,
                            C595,       ; Done
                        0003,
                            0000,0000,0000,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $C9BA: Instruction list - palette FX object $E1BC (old Mother Brain fight background lights) ;;;
{
$8D:C9BA             dx C655,0028,  ; Palette FX object colour index = 0028h
$8D:C9BE             dx 0006,
                            7FFF,6318,294A,
                            C595,       ; Done
                        0006,
                            6F7B,56B5,2529,
                            C595,       ; Done
                        0006,
                            5AD6,4631,1CE7,
                            C595,       ; Done
                        0006,
                            4A52,39CE,18C6,
                            C595,       ; Done
                        0006,
                            35AD,294A,1084,
                            C595,       ; Done
                        0006,
                            2529,1CE7,0C63,
                            C595,       ; Done
                        0006,
                            1084,0C63,0421,
                            C595,       ; Done
                        0006,
                            0000,0000,0000,
                            C595,       ; Done
                        0006,
                            1084,0C63,0421,
                            C595,       ; Done
                        0006,
                            2529,1CE7,0C63,
                            C595,       ; Done
                        0006,
                            35AD,294A,1084,
                            C595,       ; Done
                        0006,
                            4A52,39CE,18C6,
                            C595,       ; Done
                        0006,
                            5AD6,4631,1CE7,
                            C595,       ; Done
                        0006,
                            6F7B,56B5,2529,
                            C595,       ; Done
                        C61E,C9BE   ; Go to $C9BE
}


;;; $CA4E: Instruction list - palette FX object $E1C0 (gunship glow) ;;;
{
$8D:CA4E             dx C655,01FE,  ; Palette FX object colour index = 01FEh
$8D:CA52             dx 0005,
                            0000,
                            C595,       ; Done
                        0005,
                            0402,
                            C595,       ; Done
                        0005,
                            0404,
                            C595,       ; Done
                        0005,
                            0806,
                            C595,       ; Done
                        0005,
                            0C08,
                            C595,       ; Done
                        0005,
                            0C0A,
                            C595,       ; Done
                        0005,
                            100C,
                            C595,       ; Done
                        0005,
                            180E,
                            C595,       ; Done
                        0005,
                            100C,
                            C595,       ; Done
                        0005,
                            0C0A,
                            C595,       ; Done
                        0005,
                            0C08,
                            C595,       ; Done
                        0005,
                            0806,
                            C595,       ; Done
                        0005,
                            0404,
                            C595,       ; Done
                        0005,
                            0402,
                            C595,       ; Done
                        C61E,CA52   ; Go to $CA52
}


;;; $CAAA: Instruction list - palette FX object $E1C4 (fade out zoomed out exploding Zebes) ;;;
{
$8D:CAAA             dx C655,01E0,  ; Palette FX object colour index = 01E0h
                        0008,
                            2003,0E9A,05F9,0596,0133,008E,0009,0005,
                            C595,       ; Done
                        0008,
                            2003,01F5,0154,00F0,008E,0009,0004,0000,
                            C595,       ; Done
                        0008,
                            0000,0150,00AF,004B,0009,0004,0000,0000,
                            C595,       ; Done
                        0008,
                            0000,00AB,000A,0006,0004,0000,0000,0000,
                            C595,       ; Done
                        0008,
                            0000,0006,0005,0001,0000,0000,0000,0000,
                            C595,       ; Done
                        0008,
                            0000,0001,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0008,
                            0000,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $CB3C: Instruction list - palette FX object $E1C8 (wide part of Zebes explosion - foreground) ;;;
{
$8D:CB3C             dx C655,0002,  ; Palette FX object colour index = 0002h
                        0004,
                            7C00,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0004,
                            7CA0,7CA0,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0004,
                            7DE0,7DE0,7DE0,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        003C,
                            7DE0,7DE0,7DE0,7DE0,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0006,
                            7E80,7E80,7E80,7E80,7E80,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0006,
                            7F20,7F20,7F20,7F20,7F20,7F20,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0006,
                            7FFD,7FE9,7FE9,7FE9,7FE9,7FE9,7FE9,0000,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0006,
                            7FFD,7FFD,7FF3,7FF3,7FF3,7FF3,7FF3,7FE9,0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0006,
                            7FFD,7FFD,7FFD,7FF8,7FF8,7FF8,7FF8,7FE9,2940,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0006,
                            7FFD,7FFD,7FFD,7FFD,7FFD,7FFD,7FF8,7FF8,7FE9,2940,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0006,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FE9,2940,0000,0000,0000,0000,
                            C595,       ; Done
                        0006,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FE9,2940,0000,0000,0000,
                            C595,       ; Done
                        0006,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FE9,2940,0000,0000,
                            C595,       ; Done
                        0006,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FE9,2940,0000,
                            C595,       ; Done
                        0006,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FE9,6B40,
                            C595,       ; Done
                        0006,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FF7,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $CD62: Instruction list - palette FX object $E1CC (Zebes explosion finale) ;;;
{
$8D:CD62             dx C655,0002,  ; Palette FX object colour index = 2
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,
                            C595,       ; Done
                        0002,
                            7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,0842,
                            C595,       ; Done
                        0002,
                            7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,0842,0000,
                            C595,       ; Done
                        0009,
                            7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,0842,0000,
                            C595,       ; Done
                        0009,
                            0000,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,0842,
                            C595,       ; Done
                        0009,
                            0842,0000,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,
                            C595,       ; Done
                        0009,
                            14A5,0842,0000,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,
                            C595,       ; Done
                        0009,
                            1CE7,14A5,0842,0000,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,
                            C595,       ; Done
                        0009,
                            2529,1CE7,14A5,0842,0000,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,
                            C595,       ; Done
                        0009,
                            2D6B,2529,1CE7,14A5,0842,0000,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,
                            C595,       ; Done
                        0009,
                            35AD,2D6B,2529,1CE7,14A5,0842,0000,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,
                            C595,       ; Done
                        0009,
                            4A52,35AD,2D6B,2529,1CE7,14A5,0842,0000,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,
                            C595,       ; Done
                        0009,
                            5294,4A52,35AD,2D6B,2529,1CE7,14A5,0842,0000,7FFF,77BD,6F7B,6318,5AD6,5294,
                            C595,       ; Done
                        0009,
                            5AD6,5294,4A52,35AD,2D6B,2529,1CE7,14A5,0842,0000,7FFF,77BD,6F7B,6318,5AD6,
                            C595,       ; Done
                        0009,
                            6318,5AD6,5294,4A52,35AD,2D6B,2529,1CE7,14A5,0842,0000,7FFF,77BD,6F7B,6318,
                            C595,       ; Done
                        0009,
                            6F7B,6318,5AD6,5294,4A52,35AD,2D6B,2529,1CE7,14A5,0842,0000,7FFF,77BD,6F7B,
                            C595,       ; Done
                        0009,
                            77BD,6F7B,6318,5AD6,5294,4A52,35AD,2D6B,2529,1CE7,14A5,0842,0000,7FFF,77BD,
                            C595,       ; Done
                        0009,
                            7FFF,77BD,6F7B,6318,5AD6,5294,4A52,35AD,2D6B,2529,1CE7,14A5,0842,0000,7FFF,
                            C595,       ; Done
                        0009,
                            7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,0842,0000,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,0842,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,5294,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,5AD6,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,6318,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,6F7B,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,77BD,
                            C595,       ; Done
                        0009,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $D362: Instruction list - palette FX object $E1E8 (wide part of Zebes explosion - background) ;;;
{
$8D:D362             dx C655,0022,  ; Palette FX object colour index = 0022h
                        C61E,D36E   ; Go to $D36E
}


;;; $D36A: Instruction list - palette FX object $E1D0 (white out space during Zebes explosion) ;;;
{
$8D:D36A             dx C655,0000,  ; Palette FX object colour index = 0000h
}


;;; $D36E: Instruction list - common section of $D362 / $D36A ;;;
{
$8D:D36E             dx 000E,
                            0000,
                            C595,       ; Done
                        000E,
                            0842,
                            C595,       ; Done
                        000E,
                            1084,
                            C595,       ; Done
                        000E,
                            1CE7,
                            C595,       ; Done
                        000E,
                            2529,
                            C595,       ; Done
                        000E,
                            2D6B,
                            C595,       ; Done
                        000E,
                            35AD,
                            C595,       ; Done
                        000E,
                            3DEF,
                            C595,       ; Done
                        000E,
                            4A52,
                            C595,       ; Done
                        000E,
                            5294,
                            C595,       ; Done
                        000E,
                            5AD6,
                            C595,       ; Done
                        000E,
                            6318,
                            C595,       ; Done
                        000E,
                            6B5A,
                            C595,       ; Done
                        000E,
                            77BD,
                            C595,       ; Done
                        000E,
                            7FFF,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $D3CA: Instruction list - palette FX object $E1D4 (Zebes explosion planet afterglow) ;;;
{
$8D:D3CA             dx C655,01C2,  ; Palette FX object colour index = 01C2h
$8D:D3CE             dx 0010,
                            6B9C,5EBB,49FA,3D58,2CD4,408F,288A,1C47,
                            C595,       ; Done
                        0010,
                            77FF,6B1E,565D,49BB,3516,44B0,288B,1C48,
                            C595,       ; Done
                        0010,
                            7FFF,777F,62BF,561E,3937,48D1,288C,1C49,
                            C595,       ; Done
                        0010,
                            7FFF,7FDF,7F7F,6ABF,3D58,5113,2CAE,206B,
                            C595,       ; Done
                        0010,
                            7FFF,777F,62BF,561E,3937,48D1,288C,1C49,
                            C595,       ; Done
                        0010,
                            77FF,6B1E,565D,49BB,3516,44B0,288B,1C48,
                            C595,       ; Done
                        C61E,D3CE   ; Go to $D3CE
}


;;; $D44A: Instruction list - palette FX object $E1D8 (exploding Zebes lava) ;;;
{
$8D:D44A             dx C655,0080,  ; Palette FX object colour index = 0080h
$8D:D44E             dx 0009,
                            0012,
                            C595,       ; Done
                        0008,
                            000F,
                            C595,       ; Done
                        0007,
                            000C,
                            C595,       ; Done
                        0006,
                            0009,
                            C595,       ; Done
                        0005,
                            0006,
                            C595,       ; Done
                        0005,
                            0003,
                            C595,       ; Done
                        0006,
                            0006,
                            C595,       ; Done
                        0007,
                            0009,
                            C595,       ; Done
                        0008,
                            000C,
                            C595,       ; Done
                        0009,
                            000F,
                            C595,       ; Done
                        C61E,D44E   ; Go to $D44E
}


;;; $D48E: Instruction list - palette FX object $E1DC (fade out exploding Zebes crust) ;;;
{
$8D:D48E             dx C655,0082,  ; Palette FX object colour index = 0082h
                        0014,
                            0864,0884,0CA6,10C7,0CC8,0D07,0D0A,0CEC,0D2C,112C,118E,0D70,11F4,1633,1698,
                            C595,       ; Done
                        0014,
                            0443,0463,0885,0CA6,08A7,08E6,08E8,08CA,08EA,0CEA,0D4C,092E,0DB1,11D0,1235,
                            C595,       ; Done
                        0014,
                            0443,0463,0864,0C85,0886,08C5,08C7,08A9,08C9,0CC9,0D2A,090C,0D6F,0D8E,0DF2,
                            C595,       ; Done
                        0014,
                            0422,0442,0463,0864,0465,04A4,04A6,0487,04A7,08A7,08E8,04CA,092C,0D4B,0D8F,
                            C595,       ; Done
                        0014,
                            0422,0442,0443,0863,0464,0483,0485,0466,0486,0886,08C7,04A8,08EA,0909,094C,
                            C595,       ; Done
                        0014,
                            0021,0021,0422,0442,0443,0462,0463,0444,0464,0464,0485,0486,04A7,04C7,04E9,
                            C595,       ; Done
                        0014,
                            0001,0021,0021,0421,0022,0041,0042,0023,0043,0443,0463,0044,0465,0484,04A6,
                            C595,       ; Done
                        0014,
                            0000,0000,0000,0000,0001,0020,0021,0001,0021,0021,0021,0022,0022,0042,0043,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $D5A4: Instruction list - palette FX object $E1E0 (fade out exploding Zebes grey clouds) ;;;
{
$8D:D5A4             dx C655,00A2,  ; Palette FX object colour index = 00A2h
                        000E,
                            0842,0C63,1084,14A5,18C6,1CE7,2108,2529,2D6B,318C,39CE,4631,4A52,5294,6318,
                            C595,       ; Done
                        000E,
                            0421,0842,0C63,1084,14A5,18C6,1CE7,1CE7,2529,294A,318C,39CE,3DEF,4631,56B5,
                            C595,       ; Done
                        000E,
                            0421,0842,0C63,0C63,1084,14A5,18C6,18C6,2108,2529,294A,318C,35AD,3DEF,4A52,
                            C595,       ; Done
                        000E,
                            0421,0421,0842,0C63,0C63,1084,14A5,14A5,18C6,1CE7,2108,294A,2D6B,318C,3DEF,
                            C595,       ; Done
                        000E,
                            0421,0421,0842,0842,0C63,0C63,1084,1084,14A5,18C6,1CE7,2108,2529,294A,318C,
                            C595,       ; Done
                        000E,
                            0000,0421,0421,0421,0842,0842,0C63,0C63,1084,1084,14A5,18C6,18C6,1CE7,2529,
                            C595,       ; Done
                        000E,
                            0000,0000,0421,0421,0421,0421,0842,0842,0842,0C63,0C63,1084,1084,14A5,18C6,
                            C595,       ; Done
                        000E,
                            0000,0000,0000,0000,0000,0000,0421,0421,0421,0421,0421,0842,0842,0842,0C63,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $D6BA: Instruction list - palette FX object $E1E4 (gunship emerging from Zebes explosion) ;;;
{
$8D:D6BA             dx C655,00A0,  ; Palette FX object colour index = 00A0h
                        0018,
                            0000,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,
                            C595,       ; Done
                        0018,
                            0000,6F7B,6B7B,6B5A,6B5A,6B7B,6B7B,6B7B,6B5B,6F7A,6B7A,6B7A,6F7B,6F5A,6B5A,6B5B,
                            C595,       ; Done
                        0018,
                            0000,5F18,5AF8,5AD6,5AD6,5B18,5AF7,5AF7,5AD7,5F16,5AF6,5AF6,5EF7,5ED6,5AD6,5AD7,
                            C595,       ; Done
                        0018,
                            0000,4EB5,4694,4652,4631,4A94,4674,4673,4653,4EB1,4A71,4A71,4E73,4E52,4A52,4A33,
                            C595,       ; Done
                        0018,
                            0000,4231,3611,35CE,35AD,3631,3610,35F0,35CF,3E2D,3A0D,35ED,41EF,3DCE,39AD,35AF,
                            C595,       ; Done
                        0018,
                            0000,31CE,21AD,214A,2108,25AD,218D,216C,214B,2DC8,2988,2568,316B,2D4A,2929,250B,
                            C595,       ; Done
                        0018,
                            0000,216B,112A,10C6,1084,154A,1109,10E8,10C7,1D64,1904,14E4,20E7,1CC6,18A5,1487,
                            C595,       ; Done
                        0018,
                            0000,1508,00C7,0042,0000,04E7,00A6,0085,0043,1100,08A0,0460,1484,0C42,0821,0404,
                            C595,       ; Done
                        0018,
                            0000,1508,00C7,0042,0000,04E7,00A6,0085,0043,1100,08A0,0460,1484,0C42,0821,0000,
                            C595,       ; Done
                        0018,
                            0000,1D6B,010A,0063,0000,094A,00E8,00C7,0064,1560,0CE0,0880,1CC6,1063,0C42,0000,
                            C595,       ; Done
                        0018,
                            0000,25CE,014C,0064,0000,098C,012B,00E9,0086,1DE0,1120,08C0,24E7,1884,1042,0000,
                            C595,       ; Done
                        0018,
                            0000,2E31,018F,0085,0000,0DEF,016D,012B,00A7,2240,1560,0CE0,2D29,1CA5,1463,0000,
                            C595,       ; Done
                        0018,
                            0000,3295,05F1,00A7,0000,0E32,01AF,014C,00E9,2AA0,19C0,0D00,314A,20C6,1463,0000,
                            C595,       ; Done
                        0018,
                            0000,3AF8,0634,00C8,0000,1295,01F1,018E,010A,2F00,1E00,1120,398C,24E7,1884,0000,
                            C595,       ; Done
                        0018,
                            0000,435B,0676,00C9,0000,12D7,0234,01B0,012C,3780,2240,1160,41AD,2D08,1C84,0000,
                            C595,       ; Done
                        0018,
                            0000,4BBE,06B9,00EA,0000,173A,0276,01F2,014D,3BE0,2680,1580,49EF,3129,20A5,0000,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $D900: Instruction list - palette FX object $E1F0 (hyper beam) ;;;
{
$8D:D900             dx C655,01C2,  ; Palette FX object colour index = 1C2h
$8D:D904             dx 0002,
                            7FFF,661F,351F,001F,673F,4E7F,319F,18DF,
                            C595,       ; Done
                        0002,
                            7FFF,36BD,1D9B,00D9,6B9F,4F3F,2EDF,0E7F,
                            C595,       ; Done
                        0002,
                            7FFF,033B,0216,0173,6BFF,4BFF,2BFF,03FF,
                            C595,       ; Done
                        0002,
                            7FFF,1F8E,164B,0D8A,6BFD,4BF9,2BF5,03F0,
                            C595,       ; Done
                        0002,
                            7FFF,3BE0,2680,1580,6BFA,4BF2,2BEA,03E0,
                            C595,       ; Done
                        0002,
                            7FFF,5F60,4A40,3540,77B4,5F8E,4B28,3301,
                            C595,       ; Done
                        0002,
                            7FFF,7EC0,6DE0,54E0,7F6E,730A,6665,5E22,
                            C595,       ; Done
                        0002,
                            7FFF,7D70,650B,4486,7F37,7A75,71B2,652E,
                            C595,       ; Done
                        0002,
                            7FFF,7C1F,5816,300C,7EDF,7DDF,7CDF,681A,
                            C595,       ; Done
                        0002,
                            7FFF,711F,489B,1816,731F,663F,593F,407D,
                            C595,       ; Done
                        C61E,D904   ; Go to $D904
}


;;; $D9D0: Instruction list - palette FX object $E1EC (unused) ;;;
{
$8D:D9D0             dx C655,00A0,  ; Palette FX object colour index = 00A0h
                        0002,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,
                            C595,       ; Done
                        0002,
                            739C,77BD,73BD,73BD,739C,77BD,73BD,73BD,73BD,77BC,77BC,77BC,77BD,77BD,77BD,77BD,
                            C595,       ; Done
                        0002,
                            6B5A,6F9C,6B7B,6B7B,6B5A,6F7B,6B7B,6B7B,6B7B,6F9A,6F7A,6F7A,6F7B,6F7B,6F7B,739C,
                            C595,       ; Done
                        0002,
                            6318,675A,635A,6339,6318,675A,635A,6339,6339,6758,6758,6738,6739,6739,6739,6B5A,
                            C595,       ; Done
                        0002,
                            5AD6,6339,5B18,5AF7,5AD6,5F18,5B18,5AF8,5AF7,5F36,5F16,5EF6,62F7,5EF7,5EF7,6739,
                            C595,       ; Done
                        0002,
                            5294,5AF7,52D7,52B5,5294,56F7,52D7,52D6,52B6,5AF4,56D4,56B4,5AD6,56B5,56B5,5EF7,
                            C595,       ; Done
                        0002,
                            4A52,52D6,4AB5,4A73,4A52,4EB5,4AB5,4A94,4A74,52D2,4EB2,4E72,5294,4E73,4E73,5AD6,
                            C595,       ; Done
                        0002,
                            4210,4A94,4274,4231,4210,4694,4273,4252,4232,4A90,4670,4630,4A52,4631,4631,5294,
                            C595,       ; Done
                        0002,
                            39CE,4673,3A32,39F0,39CE,3E52,3A32,3A11,3A10,426E,3E2E,3E0E,4610,41EF,3DEF,4E73,
                            C595,       ; Done
                        0002,
                            318C,3E31,3211,31AE,318C,3631,3210,31CF,31CE,3A2C,360C,35CC,3DCE,39AD,35AD,4631,
                            C595,       ; Done
                        0002,
                            294A,3610,29CF,296C,294A,2DEF,29CF,29AD,298D,360A,2DCA,2D8A,35AD,316B,2D6B,4210,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $DB62: Instruction list - palette FX object $E1F4 (Samus loading - power suit) ;;;
{
$8D:DB62             dx C655,0180,  ; Palette FX object colour index = 0180h
                        C648,24,    ; Timer = 24h
$8D:DB69             dx 0003,
                            3800,0108,03BD,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,02B5,016B,0252,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            0000,52AE,5FBD,65E5,7FE0,7388,7FFF,7FF2,7FEE,569B,5F55,5E0B,53F6,62E4,5254,51ED,
                            C595,       ; Done
                        C639,DB69,  ; Decrement timer and go to $DB69 if non-zero
                        C648,03,    ; Timer = 03h
$8D:DBB8             dx 0003,
                            3800,0108,03BD,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,02B5,016B,0252,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            0000,52AE,5FBD,65E5,7FE0,7388,7FFF,7FF2,7FEE,569B,5F55,5E0B,53F6,62E4,5254,51ED,
                            C595,       ; Done
                        C639,DBB8,  ; Decrement timer and go to $DBB8 if non-zero
                        C648,03,    ; Timer = 03h
$8D:DC07             dx 0003,
                            3800,0108,03BD,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,02B5,016B,0252,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            2003,516E,4BBD,64A5,7FE0,7248,7FFF,7F72,7EEE,555B,4AB5,496B,52B6,61A4,5114,50AD,
                            C595,       ; Done
                        C639,DC07,  ; Decrement timer and go to $DC07 if non-zero
                        C648,02,    ; Timer = 02h
$8D:DC56             dx 0003,
                            3800,0108,03BD,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,02B5,016B,0252,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            2003,28CE,37BD,3C05,63E0,49A8,7F9F,72D2,624E,28BB,36B5,356B,2A16,3904,2874,280D,
                            C595,       ; Done
                        C639,DC56,  ; Decrement timer and go to $DC56 if non-zero
                        0001,
                            3800,0108,03BD,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,02B5,016B,0252,1104,0074,000D,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $DCC8: Instruction list - palette FX object $E1F8 (Samus loading - varia suit) ;;;
{
$8D:DCC8             dx C655,0180,  ; Palette FX object colour index = 0180h
                        C648,24,    ; Timer = 24h
$8D:DCCF             dx 0003,
                            0000,0108,02FF,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,01BE,008E,0252,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            0000,79A8,7B9F,65E5,7FE0,7388,7FFF,7FF2,7FEE,569B,765E,752E,524D,62E4,5254,51ED,
                            C595,       ; Done
                        C639,DCCF,  ; Decrement timer and go to $DCCF if non-zero
                        C648,03,    ; Timer = 03h
$8D:DD1E             dx 0003,
                            0000,0108,02FF,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,01BE,008E,0252,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            0000,79A8,7B9F,65E5,7FE0,7388,7FFF,7FF2,7FEE,569B,765E,752E,524D,62E4,5254,51ED,
                            C595,       ; Done
                        C639,DD1E,  ; Decrement timer and go to $DD1E if non-zero
                        C648,03,    ; Timer = 03h
$8D:DD6D             dx 0003,
                            0000,0108,02FF,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,01BE,008E,0252,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            2003,5108,52FF,64A5,7FE0,7248,7FFF,7F72,7EEE,555B,51BE,508E,3E4D,61A4,5114,50AD,
                            C595,       ; Done
                        C639,DD6D,  ; Decrement timer and go to $DD6D if non-zero
                        C648,02,    ; Timer = 02h
$8D:DDBC             dx 0003,
                            0000,0108,02FF,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,01BE,008E,0252,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            2003,2908,2AFF,3C05,63E0,49A8,7F9F,72D2,624E,28BB,29BE,288E,2A4D,3904,2874,280D,
                            C595,       ; Done
                        C639,DDBC,  ; Decrement timer and go to $DDBC if non-zero
                        0001,
                            0000,0108,02FF,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,01BE,008E,0252,1104,0074,000D,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $DE2E: Instruction list - palette FX object $E1FC (Samus loading - gravity suit) ;;;
{
$8D:DE2E             dx C655,0180,  ; Palette FX object colour index = 0180h
                        C648,24,    ; Timer = 24h
$8D:DE35             dx 0003,
                            3800,0108,421F,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,5914,30AA,0274,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            0000,52AE,7FFF,65E5,7FE0,7388,7FFF,7FF2,7FEE,569B,7EF4,7E8A,53F6,62E4,5254,51ED,
                            C595,       ; Done
                        C639,DE35,  ; Decrement timer and go to $DE35 if non-zero
                        C648,03,    ; Timer = 03h
$8D:DE84             dx 0003,
                            3800,0108,421F,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,5914,30AA,0274,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            0000,52AE,7FFF,65E5,7FE0,7388,7FFF,7FF2,7FEE,569B,7EF4,7E8A,53F6,62E4,5254,51ED,
                            C595,       ; Done
                        C639,DE84,  ; Decrement timer and go to $DE84 if non-zero
                        C648,03,    ; Timer = 03h
$8D:DED3             dx 0003,
                            3800,0108,421F,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,5914,30AA,0274,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            2003,516E,7EBF,64A5,7FE0,7248,7FFF,7F72,7EEE,555B,7DB4,7D4A,52B6,61A4,5114,50AD,
                            C595,       ; Done
                        C639,DED3,  ; Decrement timer and go to $DED3 if non-zero
                        C648,02,    ; Timer = 02h
$8D:DF22             dx 0003,
                            3800,0108,421F,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,5914,30AA,0274,1104,0074,000D,
                            C595,       ; Done
                        0003,
                            2003,28CE,6E1F,3C05,63E0,49A8,7F9F,72D2,624E,28BB,7D14,58AA,2A16,3904,2874,280D,
                            C595,       ; Done
                        C639,DF22,  ; Decrement timer and go to $DF22 if non-zero
                        0001,
                            3800,0108,421F,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,5914,30AA,0274,1104,0074,000D,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $DF94: Instruction list - palette FX object $E200 (post-credits Super Metroid icon glare) ;;;
{
$8D:DF94             dx C655,01E0,  ; Palette FX object colour index = 01E0h
                        0001,
                            2DEB,119F,10B2,1088,127F,1153,10AC,135F,11D3,10EC,7BE4,79C4,4C84,4BFF,13FF,28E7,
                            C595,       ; Done
                        0001,
                            3A4E,21FF,2134,210C,22BF,21B5,212F,237F,2235,216F,7BE8,7A28,5508,53FF,23FF,356B,
                            C595,       ; Done
                        0001,
                            4691,365F,35B6,35B0,36FF,3637,35B2,379F,3697,35F2,7BED,7A8D,5DAD,5BFF,37FF,45EF,
                            C595,       ; Done
                        0001,
                            56F5,46BF,4658,4633,473F,4699,4655,479F,46D9,4675,7BF1,7AD1,6631,63FF,47FF,5273,
                            C595,       ; Done
                        0001,
                            6338,5B1F,5ADA,5AD7,5B7F,5B1B,5AD8,5BBF,5B3B,5AF8,7BF6,7B36,6ED6,6BFF,5BFF,62F7,
                            C595,       ; Done
                        0001,
                            6F9B,6B7F,6B5C,6B5B,6BBF,6B7D,6B5B,6BDF,6B9D,6B7B,7BFA,7B9A,775A,73FF,6BFF,6F7B,
                            C595,       ; Done
                        0001,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,
                            C595,       ; Done
                        0001,
                            6F9B,6B7F,6B5C,6B5B,6BBF,6B7D,6B5B,6BDF,6B9D,6B7B,7BFA,7B9A,775A,73FF,6BFF,6F7B,
                            C595,       ; Done
                        0001,
                            6338,5B1F,5ADA,5AD7,5B7F,5B1B,5AD8,5BBF,5B3B,5AF8,7BF6,7B36,6ED6,6BFF,5BFF,62F7,
                            C595,       ; Done
                        0001,
                            56F5,46BF,4658,4633,473F,4699,4655,479F,46D9,4675,7BF1,7AD1,6631,63FF,47FF,5273,
                            C595,       ; Done
                        0001,
                            4691,365F,35B6,35B0,36FF,3637,35B2,379F,3697,35F2,7BED,7A8D,5DAD,5BFF,37FF,45EF,
                            C595,       ; Done
                        0001,
                            3A4E,21FF,2134,210C,22BF,21B5,212F,237F,2235,216F,7BE8,7A28,5508,53FF,23FF,356B,
                            C595,       ; Done
                        0001,
                            2DEB,119F,10B2,1088,127F,1153,10AC,135F,11D3,10EC,7BE4,79C4,4C84,4BFF,13FF,28E7,
                            C595,       ; Done
                        0001,
                            21A8,013F,0030,0005,025F,00F2,0029,035F,0192,0089,7BE0,7980,4400,43FF,03FF,1C84,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $E192: Instruction list - delete ;;;
{
$8D:E192             dx C5CF        ; Delete
}
}


;;; $E194: Palette FX objects - misc. ;;;
{
$8D:E194             dw C685,C696 ; Fade in Super Metroid title logo
$8D:E198             dw C685,C7AC ; Fade in Nintendo boot logo (for unused code)
$8D:E19C             dw C685,C7F2 ; Fade in Nintendo copyright
$8D:E1A0             dw C685,C7FA ; Title screen baby metroid tube light
$8D:E1A4             dw C685,C862 ; Title screen flickering displays
$8D:E1A8             dw C685,C87A ; Cutscene gunship engine flicker
$8D:E1AC             dw C685,C88E ; Cutscene Ceres navigation lights - sprite Ceres
$8D:E1B0             dw C685,C90E ; Fade in PLANET ZEBES text
$8D:E1B4             dw C685,C964 ; Fade out PLANET ZEBES text
$8D:E1B8             dw C685,C906 ; Cutscene Ceres navigation lights - BG Ceres
$8D:E1BC             dw E204,C9BA ; Old Mother Brain fight background lights
$8D:E1C0             dw C685,CA4E ; Gunship glow
$8D:E1C4             dw C685,CAAA ; Fade out zoomed out exploding Zebes
$8D:E1C8             dw C685,CB3C ; Wide part of Zebes explosion - foreground
$8D:E1CC             dw C685,CD62 ; Zebes explosion finale
$8D:E1D0             dw C685,D36A ; White out space during Zebes explosion
$8D:E1D4             dw C685,D3CA ; Zebes explosion planet afterglow
$8D:E1D8             dw C685,D44A ; Exploding Zebes lava
$8D:E1DC             dw C685,D48E ; Fade out exploding Zebes crust
$8D:E1E0             dw C685,D5A4 ; Fade out exploding Zebes grey clouds
$8D:E1E4             dw C685,D6BA ; Gunship emerging from Zebes explosion
$8D:E1E8             dw C685,D362 ; Wide part of Zebes explosion - background
$8D:E1EC             dw C685,D9D0 ; Unused
$8D:E1F0             dw C685,D900 ; Hyper beam
$8D:E1F4             dw C685,DB62 ; Samus loading - power suit
$8D:E1F8             dw C685,DCC8 ; Samus loading - varia suit
$8D:E1FC             dw C685,DE2E ; Samus loading - gravity suit
$8D:E200             dw C685,DF94 ; Post-credits Super Metroid icon
}


;;; $E204: Setup - palette FX object $E1BC (old Mother Brain fight background lights) ;;;
{
;; Parameters:
;;     Y: Palette FX object index
$8D:E204 A9 0B E2    LDA #$E20B             ;\
$8D:E207 99 AD 1E    STA $1EAD,y[$7E:1EBB]  ;} Palette FX object pre-instruction = $E20B (delete if intro page 2 is active)
$8D:E20A 60          RTS
}


;;; $E20B: Pre-instruction - delete if intro page 2 is active ;;;
{
;; Parameters:
;;     X: Palette FX object index
$8D:E20B AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$8D:E20E C9 5F B3    CMP #$B35F             ;} If [cinematic function] = $B35F (intro - page 2):
$8D:E211 D0 0C       BNE $0C    [$E21F]     ;/
$8D:E213 A9 92 E1    LDA #$E192             ;\
$8D:E216 9D BD 1E    STA $1EBD,x[$7E:1ECB]  ;} Palette FX object instruction list pointer = $E192 (delete)
$8D:E219 A9 01 00    LDA #$0001             ;\
$8D:E21C 9D CD 1E    STA $1ECD,x[$7E:1EDB]  ;} Palette FX object instruction timer = 1

$8D:E21F 60          RTS
}


;;; $E220..E378: Tourian entrance statue / torizo belly ;;;
{
;;; $E220: Instruction list - palette FX object $F745 (nothing) ;;;
{
$8D:E220             dx C5CF        ; Delete
}


;;; $E222: Instruction list - palette FX object $F749 (grey out Tourian entrance statue - Draygon) ;;;
{
$8D:E222             dx C655,00C0,  ; Palette FX object colour index = 00C0h
                        C61E,E23E   ; Go to $E23E
}


;;; $E22A: Instruction list - palette FX object $F74D (grey out Tourian entrance statue - Kraid) ;;;
{
$8D:E22A             dx C655,00E0,  ; Palette FX object colour index = 00E0h
                        C61E,E23E   ; Go to $E23E
}


;;; $E232: Instruction list - palette FX object $F751 (grey out Tourian entrance statue - Ridley) ;;;
{
$8D:E232             dx C655,0120,  ; Palette FX object colour index = 0120h
                        C61E,E23E   ; Go to $E23E
}


;;; $E23A: Instruction list - palette FX object $F755 (grey out Tourian entrance statue - Phantoon) ;;;
{
$8D:E23A             dx C655,0140,  ; Palette FX object colour index = 0140h
}


;;; $E23E: Instruction list - common section of above instruction lists ;;;
{
$8D:E23E             dx 0008,
                            0000,57FF,2BFF,1F3C,0278,01B0,010B,0087,
                            C595,       ; Done
                        0008,
                            3800,5BDE,33DE,271A,0E57,09AF,050A,0486,
                            C595,       ; Done
                        0008,
                            3800,63DD,3F9C,2EF9,1655,118E,0D0A,0486,
                            C595,       ; Done
                        0008,
                            3800,67BC,477B,36D7,2234,198D,1109,0885,
                            C595,       ; Done
                        0008,
                            3800,6F9B,5359,42D6,2A32,1D8D,14E9,0885,
                            C595,       ; Done
                        0008,
                            3800,737A,5B38,4AB4,3611,258C,18E8,0C84,
                            C595,       ; Done
                        0008,
                            3800,7B79,66F6,5293,3E0F,2D6B,20E8,0C84,
                            C595,       ; Done
                        0008,
                            3800,7F58,6ED5,5A71,49EE,356A,24E7,1083,
                            C595,       ; Done
                        C5CF        ; Delete
}


;;; $E2E0: Pre-instruction - delete if enemy 0 died ;;;
{
;; Parameters:
;;     X: Palette FX object index
$8D:E2E0 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$8D:E2E3 D0 03       BNE $03    [$E2E8]     ;} If [enemy 0 health] = 0:
$8D:E2E5 9E 7D 1E    STZ $1E7D,x[$7E:1E8B]  ; Palette FX object ID = 0

$8D:E2E8 60          RTS
}


;;; $E2E9: Instruction list - palette FX object $F759 (Bomb Torizo belly) ;;;
{
$8D:E2E9             dx C655,0132,  ; Palette FX object colour index = 0132h
                        C5D4,E2E0,  ; Pre-instruction = $E2E0 (delete if enemy 0 died)
$8D:E2F1             dx 000A,
                            6F7F,51F8,410E,
                            C595,       ; Done
                        0008,
                            56BC,3935,284B,
                            C595,       ; Done
                        0008,
                            4639,28B2,1828,
                            C595,       ; Done
                        000A,
                            2D74,100D,0403,
                            C595,       ; Done
                        0008,
                            4639,28B2,1828,
                            C595,       ; Done
                        0008,
                            56BC,3935,284B,
                            C595,       ; Done
                        C61E,E2F1   ; Go to $E2F1
}


;;; $E331: Instruction list - palette FX object $F75D (Golden Torizo belly) ;;;
{
$8D:E331             dx C655,0132,  ; Palette FX object colour index = 0132h
                        C5D4,E2E0,  ; Pre-instruction = $E2E0 (delete if enemy 0 died)
$8D:E339             dx 000A,
                            73E0,4F20,2A20,
                            C595,       ; Done
                        0008,
                            5380,2E20,0920,
                            C595,       ; Done
                        0008,
                            3AC0,1560,0480,
                            C595,       ; Done
                        000A,
                            2200,00A0,0020,
                            C595,       ; Done
                        0008,
                            3AC0,1560,0480,
                            C595,       ; Done
                        0008,
                            5380,2E20,0920,
                            C595,       ; Done
                        C61E,E339   ; Go to $E339
}
}


;;; $E379..F744: FX ;;;
{
;;; $E379: Pre-instruction - Samus in heat ;;;
{
;; Parameters:
;;     X: Palette FX object index

; Contains heat damage check
$8D:E379 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$8D:E37C 29 21 00    AND #$0021             ;} If varia/gravity suit not equipped:
$8D:E37F D0 2A       BNE $2A    [$E3AB]     ;/
$8D:E381 AD 4E 0A    LDA $0A4E  [$7E:0A4E]  ;\
$8D:E384 18          CLC                    ;|
$8D:E385 69 00 40    ADC #$4000             ;|
$8D:E388 8D 4E 0A    STA $0A4E  [$7E:0A4E]  ;} Periodic damage += 0.4000h
$8D:E38B AD 50 0A    LDA $0A50  [$7E:0A50]  ;|
$8D:E38E 69 00 00    ADC #$0000             ;|
$8D:E391 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$8D:E394 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$8D:E397 89 07 00    BIT #$0007             ;} If [frame counter] % 8 = 0:
$8D:E39A D0 0F       BNE $0F    [$E3AB]     ;/
$8D:E39C A9 46 00    LDA #$0046             ;\
$8D:E39F CD C2 09    CMP $09C2  [$7E:09C2]  ;} If [Samus health] > 70:
$8D:E3A2 B0 07       BCS $07    [$E3AB]     ;/
$8D:E3A4 A9 2D 00    LDA #$002D             ;\
$8D:E3A7 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2Dh, sound library 3, max queued sounds allowed = 6 (gaining/losing incremental health)

$8D:E3AB AD ED 1E    LDA $1EED  [$7E:1EED]  ;\
$8D:E3AE CD EF 1E    CMP $1EEF  [$7E:1EEF]  ;} If [Samus in heat palette FX index] = [previous Samus in heat palette FX index]: return
$8D:E3B1 F0 2C       BEQ $2C    [$E3DF]     ;/
$8D:E3B3 8D EF 1E    STA $1EEF  [$7E:1EEF]  ; Previous Samus in heat palette FX index = [Samus in heat palette FX index]
$8D:E3B6 0A          ASL A                  ;\
$8D:E3B7 A8          TAY                    ;} Y = [Samus in heat palette FX index] * 2
$8D:E3B8 A9 01 00    LDA #$0001             ;\
$8D:E3BB 9D CD 1E    STA $1ECD,x[$7E:1EDB]  ;} Palette FX object instruction timer = 1
$8D:E3BE AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$8D:E3C1 89 20 00    BIT #$0020             ;} If gravity suit equipped:
$8D:E3C4 F0 05       BEQ $05    [$E3CB]     ;/
$8D:E3C6 A9 E0 E3    LDA #$E3E0             ; A = $E3E0
$8D:E3C9 80 0D       BRA $0D    [$E3D8]     ; Go to BRANCH_SET_INSTRUCTION_LIST_POINTER

$8D:E3CB 89 01 00    BIT #$0001             ;\
$8D:E3CE F0 05       BEQ $05    [$E3D5]     ;} If varia suit equipped:
$8D:E3D0 A9 00 E4    LDA #$E400             ; A = $E400
$8D:E3D3 80 03       BRA $03    [$E3D8]     ; Go to BRANCH_SET_INSTRUCTION_LIST_POINTER

$8D:E3D5 A9 20 E4    LDA #$E420             ; A = $E420

; BRANCH_SET_INSTRUCTION_LIST_POINTER
$8D:E3D8 85 12       STA $12    [$7E:0012]  ;\
$8D:E3DA B1 12       LDA ($12),y[$8D:E402]  ;} Palette FX object instruction list pointer = [[A] + [Samus in heat palette FX index] * 2]
$8D:E3DC 9D BD 1E    STA $1EBD,x[$7E:1ECB]  ;/

$8D:E3DF 60          RTS

; Instruction list pointers
$8D:E3E0             dw E8BE, E8E0, E902, E924, E946, E968, E98A, E9AC, E9CE, E9F0, EA12, EA34, EA56, EA78, EA9A, EABC ; Gravity suit
$8D:E400             dw E692, E6B4, E6D6, E6F8, E71A, E73C, E75E, E780, E7A2, E7C4, E7E6, E808, E82A, E84C, E86E, E890 ; Varia suit
$8D:E420             dw E466, E488, E4AA, E4CC, E4EE, E510, E532, E554, E576, E598, E5BA, E5DC, E5FE, E620, E642, E664 ; Power suit
}


;;; $E440: Setup - palette FX object $F761 (Norfair 1 / Tourian 1) ;;;
{
;; Parameters:
;;     Y: Palette FX object index
$8D:E440 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$8D:E443 89 20 00    BIT #$0020             ;} If gravity suit equipped:
$8D:E446 F0 05       BEQ $05    [$E44D]     ;/
$8D:E448 A9 B6 E8    LDA #$E8B6             ; Palette FX object instruction list pointer = $E8B6
$8D:E44B 80 0D       BRA $0D    [$E45A]     ; Return

$8D:E44D 89 01 00    BIT #$0001             ;\
$8D:E450 F0 05       BEQ $05    [$E457]     ;} If varia suit equipped:
$8D:E452 A9 8A E6    LDA #$E68A             ; Palette FX object instruction list pointer = $E68A
$8D:E455 80 03       BRA $03    [$E45A]     ; Return

$8D:E457 A9 5E E4    LDA #$E45E             ; Palette FX object instruction list pointer = $E45E

$8D:E45A 99 BD 1E    STA $1EBD,y[$7E:1ECB]
$8D:E45D 60          RTS
}


;;; $E45E: Instruction list - Samus in heat - power suit ;;;
{
$8D:E45E             dx C5D4,E379,  ; Pre-instruction = $E379 (heat damage)
                        C655,0182   ; Palette FX object colour index = 182h
$8D:E466             dx 0010,
                            0108,03BD,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,02B5,016B,0252,1104,0074,000D,
                            C595        ; Done
$8D:E488             dx 0004,
                            0109,03BD,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,02B6,016C,0253,1105,0075,000E,
                            C595        ; Done
$8D:E4AA             dx 0004,
                            0109,03BD,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,02B6,016C,0253,1105,0075,000E,
                            C595        ; Done
$8D:E4CC             dx 0005,
                            010A,03BE,1407,3BE2,25CC,579F,4AD4,3A50,00BC,02B7,016D,0254,1106,0076,000F,
                            C595        ; Done
$8D:E4EE             dx 0006,
                            010A,03BE,1407,3BE2,25CC,579F,4AD4,3A50,00BC,02B7,016D,0254,1106,0076,000F,
                            C595        ; Done
$8D:E510             dx 0007,
                            010B,03BE,1408,3BE3,29EE,579F,4AD5,3A51,00BD,02B8,016E,0255,1107,0077,0010,
                            C595        ; Done
$8D:E532             dx 0008,
                            010B,03BE,1408,3BE3,29EE,579F,4AD5,3A51,00BD,02B8,016E,0255,1107,0077,0010,
                            C595        ; Done
$8D:E554             dx 0008,
                            010D,03BE,140A,3BE5,2E0F,579F,4AD7,3A53,00BD,02BA,0170,0257,1109,0079,0012,
                            C595        ; Done
$8D:E576             dx 0008,
                            010D,03BE,140A,3BE5,2E0F,579F,4AD7,3A53,00BD,02BA,0170,0257,1109,0079,0012,
                            C595        ; Done
$8D:E598             dx 0008,
                            010B,03BE,1408,3BE3,29EE,579F,4AD5,3A51,00BD,02B8,016E,0255,1107,0077,0010,
                            C595        ; Done
$8D:E5BA             dx 0007,
                            010B,03BE,1408,3BE3,29EE,579F,4AD5,3A51,00BD,02B8,016E,0255,1107,0077,0010,
                            C595        ; Done
$8D:E5DC             dx 0006,
                            010A,03BE,1407,3BE2,25CC,579F,4AD4,3A50,00BC,02B7,016D,0254,1106,0076,000F,
                            C595        ; Done
$8D:E5FE             dx 0005,
                            010A,03BE,1407,3BE2,25CC,579F,4AD4,3A50,00BC,02B7,016D,0254,1106,0076,000F,
                            C595        ; Done
$8D:E620             dx 0004,
                            0109,03BD,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,02B6,016C,0253,1105,0075,000E,
                            C595        ; Done
$8D:E642             dx 0004,
                            0109,03BD,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,02B6,016C,0253,1105,0075,000E,
                            C595        ; Done
$8D:E664             dx 0003,
                            0109,03BD,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,02B6,016C,0253,1105,0075,000E,
                            C595,       ; Done
                        C61E,E466   ; Go to $E466
}


;;; $E68A: Instruction list - Samus in heat - varia suit ;;;
{
$8D:E68A             dx C5D4,E379,  ; Pre-instruction = $E379 (heat damage)
$8D:E68E             dx C655,0182,  ; Palette FX object colour index = 182h
$8D:E692             dx 0010,
                            0108,02FF,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,01BE,008E,0252,1104,0074,000D,
                            C595        ; Done
$8D:E6B4             dx 0004,
                            0109,02FF,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,01BE,008F,0253,1105,0075,000E,
                            C595        ; Done
$8D:E6D6             dx 0004,
                            0109,02FF,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,01BE,008F,0253,1105,0075,000E,
                            C595        ; Done
$8D:E6F8             dx 0005,
                            010A,02FF,1407,3BE2,25CC,579F,4AD4,3A50,00BC,01BE,0090,0254,1106,0076,000F,
                            C595        ; Done
$8D:E71A             dx 0006,
                            010A,02FF,1407,3BE2,25CC,579F,4AD4,3A50,00BC,01BE,0090,0254,1106,0076,000F,
                            C595        ; Done
$8D:E73C             dx 0007,
                            010B,02FF,1408,3BE3,29EE,579F,4AD5,3A51,00BD,01BE,0091,0255,1107,0077,0010,
                            C595        ; Done
$8D:E75E             dx 0008,
                            010B,02FF,1408,3BE3,29EE,579F,4AD5,3A51,00BD,01BE,0091,0255,1107,0077,0010,
                            C595        ; Done
$8D:E780             dx 0008,
                            010D,02FF,140A,3BE5,2E0F,579F,4AD7,3A53,00BD,01BF,0093,0257,1109,0079,0012,
                            C595        ; Done
$8D:E7A2             dx 0008,
                            010D,02FF,140A,3BE5,2E0F,579F,4AD7,3A53,00BD,01BF,0093,0257,1109,0079,0012,
                            C595        ; Done
$8D:E7C4             dx 0008,
                            010B,02FF,1408,3BE3,29EE,579F,4AD5,3A51,00BD,01BE,0091,0255,1107,0077,0010,
                            C595        ; Done
$8D:E7E6             dx 0007,
                            010B,02FF,1408,3BE3,29EE,579F,4AD5,3A51,00BD,01BE,0091,0255,1107,0077,0010,
                            C595        ; Done
$8D:E808             dx 0006,
                            010A,02FF,1407,3BE2,25CC,579F,4AD4,3A50,00BC,01BE,0090,0254,1106,0076,000F,
                            C595        ; Done
$8D:E82A             dx 0005,
                            010A,02FF,1407,3BE2,25CC,579F,4AD4,3A50,00BC,01BE,0090,0254,1106,0076,000F,
                            C595        ; Done
$8D:E84C             dx 0004,
                            0109,02FF,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,01BE,008F,0253,1105,0075,000E,
                            C595        ; Done
$8D:E86E             dx 0004,
                            0109,02FF,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,01BE,008F,0253,1105,0075,000E,
                            C595        ; Done
$8D:E890             dx 0010,
                            0108,02FF,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,01BE,008E,0252,1104,0074,000D,
                            C595,       ; Done
                        C61E,E692   ; Go to $E692
}


;;; $E8B6: Instruction list - Samus in heat - gravity suit ;;;
{
$8D:E8B6             dx C5D4,E379,  ; Pre-instruction = $E379 (heat damage)
$8D:E8BA             dx C655,0182,  ; Palette FX object colour index = 182h
$8D:E8BE             dx 0010,
                            0108,421F,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,5914,30AA,0274,1104,0074,000D,
                            C595        ; Done
$8D:E8E0             dx 0004,
                            0109,421F,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,5915,30AB,0253,1105,0075,000E,
                            C595        ; Done
$8D:E902             dx 0004,
                            0109,421F,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,5915,30AB,0253,1105,0075,000E,
                            C595        ; Done
$8D:E924             dx 0005,
                            010A,421F,1407,3BE2,25CC,579F,4AD4,3A50,00BC,5916,30AC,0254,1106,0076,000F,
                            C595        ; Done
$8D:E946             dx 0006,
                            010A,421F,1407,3BE2,25CC,579F,4AD4,3A50,00BC,5916,30AC,0254,1106,0076,000F,
                            C595        ; Done
$8D:E968             dx 0007,
                            010B,421F,1408,3BE3,29EE,579F,4AD5,3A51,00BD,5917,30AD,0255,1107,0077,0010,
                            C595        ; Done
$8D:E98A             dx 0008,
                            010B,421F,1408,3BE3,29EE,579F,4AD5,3A51,00BD,5917,30AD,0255,1107,0077,0010,
                            C595        ; Done
$8D:E9AC             dx 0008,
                            010D,421F,140A,3BE5,2E0F,579F,4AD7,3A53,00BD,5919,30AF,0257,1109,0079,0012,
                            C595        ; Done
$8D:E9CE             dx 0008,
                            010D,421F,140A,3BE5,2E0F,579F,4AD7,3A53,00BD,5919,30AF,0257,1109,0079,0012,
                            C595        ; Done
$8D:E9F0             dx 0008,
                            010B,421F,1408,3BE3,29EE,579F,4AD5,3A51,00BD,5917,30AD,0255,1107,0077,0010,
                            C595        ; Done
$8D:EA12             dx 0007,
                            010B,421F,1408,3BE3,29EE,579F,4AD5,3A51,00BD,5917,30AD,0255,1107,0077,0010,
                            C595        ; Done
$8D:EA34             dx 0006,
                            010A,421F,1407,3BE2,25CC,579F,4AD4,3A50,00BC,5916,30AC,0254,1106,0076,000F,
                            C595        ; Done
$8D:EA56             dx 0005,
                            010A,421F,1407,3BE2,25CC,579F,4AD4,3A50,00BC,5916,30AC,0254,1106,0076,000F,
                            C595        ; Done
$8D:EA78             dx 0004,
                            0109,421F,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,5915,30AB,0253,1105,0075,000E,
                            C595        ; Done
$8D:EA9A             dx 0004,
                            0109,421F,1406,3BE1,25CA,579F,4AD3,3A4F,00BC,5915,30AB,0253,1105,0075,000E,
                            C595        ; Done
$8D:EABC             dx 0010,
                            0108,421F,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,5914,30AA,0274,1104,0074,000D,
                            C595,       ; Done
                        C61E,E8BE   ; Go to $E8BE
}


;;; $EAE2: Instruction list - palette FX object $F76D/$F771 (Wrecked Ship 1 - green lights) ;;;
{
; Green lights (BG1/2 palette 4 colours Ch..Dh)
; Used by most Wrecked Ship rooms in powered on state
$8D:EAE2             dx C655,0098,  ; Palette FX object colour index = 98h
$8D:EAE6             dx 000A,
                            1EA9,0BB1,
                            C595,       ; Done
                        000A,
                            1667,034E,
                            C595,       ; Done
                        000A,
                            0E25,02EB,
                            C595,       ; Done
                        000A,
                            05E3,0288,
                            C595,       ; Done
                        000A,
                            01A1,0225,
                            C595,       ; Done
                        000A,
                            05E3,0288,
                            C595,       ; Done
                        000A,
                            0E25,02EB,
                            C595,       ; Done
                        000A,
                            1667,034E,
                            C595,       ; Done
                        C61E,EAE6   ; Go to $EAE6
}


;;; $EB2A: Unused. Pre-instruction - wait until area boss is dead ;;;
{
;; Parameters:
;;     X: Palette FX object index
$8D:EB2A A9 01 00    LDA #$0001             ;\
$8D:EB2D 22 DC 81 80 JSL $8081DC[$80:81DC]  ;} If area boss is not dead:
$8D:EB31 B0 07       BCS $07    [$EB3A]     ;/
$8D:EB33 68          PLA                    ; End instruction list processing
$8D:EB34 A9 01 00    LDA #$0001             ;\
$8D:EB37 9D CD 1E    STA $1ECD,x            ;} Palette FX object instruction timer = 1

$8D:EB3A 60          RTS
}


;;; $EB3B: Instruction list - palette FX object $F765 (Crateria 1 - lightning) ;;;
{
; Lightning (BG1/2 palette 5 colours 4..Bh)
; Used by landing site prior to acquiring power bombs
$8D:EB3B             dx C5D4,EC59,  ; Pre-instruction = $EC59 (restart Crateria 1 instruction list if Samus isn't low enough)
                        C655,00A8,  ; Palette FX object colour index = A8h
$8D:EB43             dx 00F0,
                            2D6C,294B,252A,2109,1CE8,18C7,14A6,1085,
                            C595,       ; Done
                        C648,02,    ; Timer = 2
$8D:EB5A             dx 0002,
                            4632,4211,3DF0,39CF,35AE,318D,2D6C,294B,
                            C595,       ; Done
                        0001,
                            5EF8,5AD7,56B6,5295,4E74,4A53,4632,4211,
                            C595,       ; Done
                        0001,
                            77BE,739D,6F7C,6B5B,673A,6319,5EF8,5AD7,
                            C595,       ; Done
                        0001,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,
                            C595,       ; Done
                        0001,
                            77BE,739D,6F7C,6B5B,673A,6319,5EF8,5AD7,
                            C595,       ; Done
                        0001,
                            5EF8,5AD7,56B6,5295,4E74,4A53,4632,4211,
                            C595,       ; Done
                        0002,
                            4632,4211,3DF0,39CF,35AE,318D,2D6C,294B,
                            C595,       ; Done
                        C639,EB5A,  ; Decrement timer and go to $EB5A if non-zero
                        00F0,
                            2D6C,294B,252A,2109,1CE8,18C7,14A6,1085,
                            C595,       ; Done
                        C648,01,    ; Timer = 1
$8D:EC01             dx 0001,
                            7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,
                            C595,       ; Done
                        0001,
                            77BE,739D,6F7C,6B5B,673A,6319,5EF8,5AD7,
                            C595,       ; Done
                        0001,
                            5EF8,5AD7,56B6,5295,4E74,4A53,4632,4211,
                            C595,       ; Done
                        0002,
                            4632,4211,3DF0,39CF,35AE,318D,2D6C,294B,
                            C595,       ; Done
                        C639,EC01,  ; Decrement timer and go to $EC01 if non-zero
                        C61E,EB43   ; Go to $EB43
}


;;; $EC59: Pre-instruction - restart Crateria 1 instruction list if Samus isn't low enough ;;;
{
;; Parameters:
;;     X: Palette FX object index
$8D:EC59 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$8D:EC5C C9 80 03    CMP #$0380             ;} If [Samus Y position] < 380h:
$8D:EC5F B0 0C       BCS $0C    [$EC6D]     ;/
$8D:EC61 A9 01 00    LDA #$0001             ;\
$8D:EC64 9D CD 1E    STA $1ECD,x[$7E:1EDB]  ;} Palette FX object instruction timer = 1
$8D:EC67 A9 43 EB    LDA #$EB43             ;\
$8D:EC6A 9D BD 1E    STA $1EBD,x[$7E:1ECB]  ;} Palette FX object instruction list pointer = $EB43

$8D:EC6D 60          RTS
}


;;; $EC6E: Instruction list - palette FX object $F769 (unused. Dark lightning) ;;;
{
$8D:EC6E             dx C5D4,ED84,  ; Pre-instruction = $ED84 (restart dark lightning instruction list if Samus isn't low enough)
                        C655,0082,  ; Palette FX object colour index = 0082h
$8D:EC76             dx 00F0,
                            262B,1548,08E5,1594,14ED,10A9,0C86,
                            C595,       ; Done
                        C648,02,    ; Timer = 02h
$8D:EC8B             dx 0002,
                            1186,00A3,0040,00EF,0048,0004,0001,
                            C595,       ; Done
                        0001,
                            00E1,0000,0000,004A,0003,0000,0000,
                            C595,       ; Done
                        0001,
                            0040,0000,0000,0005,0000,0000,0000,
                            C595,       ; Done
                        0001,
                            0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0001,
                            0040,0000,0000,0005,0000,0000,0000,
                            C595,       ; Done
                        0001,
                            00E1,0000,0000,004A,0003,0000,0000,
                            C595,       ; Done
                        0002,
                            1186,00A3,0040,00EF,0048,0004,0001,
                            C595,       ; Done
                        C639,EC8B,  ; Decrement timer and go to $EC8B if non-zero
                        00F0,
                            262B,1548,08E5,1594,14ED,10A9,0C86,
                            C595,       ; Done
                        00F0,
                            262B,1548,08E5,1594,14ED,10A9,0C86,
                            C595,       ; Done
                        C648,01,    ; Timer = 01h
$8D:ED34             dx 0001,
                            0000,0000,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        0001,
                            0040,0000,0000,0005,0000,0000,0000,
                            C595,       ; Done
                        0001,
                            00E1,0000,0000,004A,0003,0000,0000,
                            C595,       ; Done
                        0002,
                            1186,00A3,0040,00EF,0048,0004,0001,
                            C595,       ; Done
                        C639,ED34,  ; Decrement timer and go to $ED34 if non-zero
                        C61E,EC76   ; Go to $EC76
}


;;; $ED84: Pre-instruction - restart dark lightning instruction list if Samus isn't low enough ;;;
{
;; Parameters:
;;     X: Palette FX object index
$8D:ED84 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$8D:ED87 C9 80 03    CMP #$0380             ;} If [Samus Y position] < 380h:
$8D:ED8A B0 0C       BCS $0C    [$ED98]     ;/
$8D:ED8C A9 01 00    LDA #$0001             ;\
$8D:ED8F 9D CD 1E    STA $1ECD,x            ;} Palette FX object instruction timer = 1
$8D:ED92 A9 76 EC    LDA #$EC76             ;\
$8D:ED95 9D BD 1E    STA $1EBD,x            ;} Palette FX object instruction list pointer = $EC76

$8D:ED98 60          RTS
}


;;; $ED99: Instruction list - palette FX object $F775 (Brinstar 1 - blue background spores) ;;;
{
; Blue background spores (BG1/2 palette 7 colours 1..3)
; Used by Brinstar rooms with the blue spores background (e.g. Green Brinstar mainstreet, n00b bridge)
$8D:ED99             dx C655,00E2,  ; Palette FX object colour index = E2h
$8D:ED9D             dx 000A,
                            5D22,4463,1840,
                            C595,       ; Done
                        000A,
                            5901,4042,1420,
                            C595,       ; Done
                        000A,
                            54E0,3C21,1000,
                            C595,       ; Done
                        000A,
                            50C0,3C21,1000,
                            C595,       ; Done
                        000A,
                            4CA0,3800,0C00,
                            C595,       ; Done
                        000A,
                            4880,3800,0C00,
                            C595,       ; Done
                        000A,
                            4460,3400,0800,
                            C595,       ; Done
                        000A,
                            4040,3400,0800,
                            C595,       ; Done
                        000A,
                            4460,3400,0800,
                            C595,       ; Done
                        000A,
                            4880,3800,0C00,
                            C595,       ; Done
                        000A,
                            4CA0,3800,0C00,
                            C595,       ; Done
                        000A,
                            50C0,3C21,1000,
                            C595,       ; Done
                        000A,
                            54E0,3C21,1000,
                            C595,       ; Done
                        000A,
                            5901,4042,1420,
                            C595,       ; Done
                        C61E,ED9D   ; Go to $ED9D
}


;;; $EE2D: Instruction list - palette FX object $F779 (Brinstar 8 - Spore Spawn blue background spores) ;;;
{
; Spore Spawn blue background spores (BG1/2 palette 7 colours 1..3)
; Used by Spore Spawn's room
; Clone of Brinstar 1 except pre-instruction is set
$8D:EE2D             dx C5D4,EEC5,  ; Pre-instruction = $EEC5 (delete palette FX object if area mini-boss is dead)
                        C655,00E2,  ; Palette FX object colour index = 00E2h
$8D:EE35             dx 000A,
                            5D22,4463,1840,
                            C595,       ; Done
                        000A,
                            5901,4042,1420,
                            C595,       ; Done
                        000A,
                            54E0,3C21,1000,
                            C595,       ; Done
                        000A,
                            50C0,3C21,1000,
                            C595,       ; Done
                        000A,
                            4CA0,3800,0C00,
                            C595,       ; Done
                        000A,
                            4880,3800,0C00,
                            C595,       ; Done
                        000A,
                            4460,3400,0800,
                            C595,       ; Done
                        000A,
                            4040,3400,0800,
                            C595,       ; Done
                        000A,
                            4460,3400,0800,
                            C595,       ; Done
                        000A,
                            4880,3800,0C00,
                            C595,       ; Done
                        000A,
                            4CA0,3800,0C00,
                            C595,       ; Done
                        000A,
                            50C0,3C21,1000,
                            C595,       ; Done
                        000A,
                            54E0,3C21,1000,
                            C595,       ; Done
                        000A,
                            5901,4042,1420,
                            C595,       ; Done
                        C61E,EE35   ; Go to $EE35
}


;;; $EEC5: Pre-instruction - delete palette FX object if area mini-boss is dead ;;;
{
;; Parameters:
;;     X: Palette FX object index
$8D:EEC5 DA          PHX                    ;\
$8D:EEC6 AE 9F 07    LDX $079F  [$7E:079F]  ;|
$8D:EEC9 BF 28 D8 7E LDA $7ED828,x[$7E:D829];|
$8D:EECD FA          PLX                    ;} If area mini-boss is dead:
$8D:EECE 29 02 00    AND #$0002             ;|
$8D:EED1 F0 03       BEQ $03    [$EED6]     ;/
$8D:EED3 9E 7D 1E    STZ $1E7D,x[$7E:1E8B]  ; Delete palette FX object

$8D:EED6 60          RTS
}


;;; $EED7: Instruction list - palette FX object $F77D (Brinstar 2 - red background glow) ;;;
{
; Red background glow (BG1/2 palette 6 colours 4..Bh)
; Used by Red Brinstar rooms with red background (mainstreet, damage boost hall, -> Crateria elevator)
$8D:EED7             dx C655,00C8,  ; Palette FX object colour index = C8h
$8D:EEDB             dx 000A,
                            4C17,280F,2409,1C07,1405,0C03,0802,0401,
                            C595,       ; Done
                        000A,
                            4816,240E,2008,1806,1004,0802,0401,0000,
                            C595,       ; Done
                        000A,
                            4415,200D,1C07,1405,0C03,0401,0000,0000,
                            C595,       ; Done
                        000A,
                            4014,1C0C,1806,1004,0802,0000,0000,0000,
                            C595,       ; Done
                        000A,
                            3C13,180B,1405,0C03,0401,0000,0000,0000,
                            C595,       ; Done
                        000A,
                            3812,140A,1004,0802,0000,0000,0000,0000,
                            C595,       ; Done
                        000A,
                            3411,1009,0C03,0401,0000,0000,0000,0000,
                            C595,       ; Done
                        000A,
                            3010,0C08,0802,0000,0000,0000,0000,0000,
                            C595,       ; Done
                        000A,
                            3411,1009,0C03,0401,0000,0000,0000,0000,
                            C595,       ; Done
                        000A,
                            3812,140A,1004,0802,0000,0000,0000,0000,
                            C595,       ; Done
                        000A,
                            3C13,180B,1405,0C03,0401,0000,0000,0000,
                            C595,       ; Done
                        000A,
                            4014,1C0C,1806,1004,0802,0000,0000,0000,
                            C595,       ; Done
                        000A,
                            4415,200D,1C07,1405,0C03,0401,0000,0000,
                            C595,       ; Done
                        000A,
                            4816,240E,2008,1806,1004,0802,0401,0000,
                            C595,       ; Done
                        C61E,EEDB   ; Go to $EEDB
}


;;; $EFF7: Instruction list - palette FX object $F781 (Crateria 80h / Brinstar 4 - beacon flashing) ;;;
{
; Beacon flashing (BG1/2 palette 7 colours 1..3 / Dh)
; Used by pre Tourian hall, red Brinstar mainstreet, red Brinstar -> Crateria elevator and the first three rooms of Kraid's lair
$8D:EFF7             dx C655,00E2,  ; Palette FX object colour index = E2h
$8D:EFFB             dx 000A,
                            02BF,017F,0015,
                            C5BD,       ; Colour index += 12h
                            7FFF,
                            C595,       ; Done
                        000A,
                            023B,00FB,0011,
                            C5BD,       ; Colour index += 12h
                            739C,
                            C595,       ; Done
                        000A,
                            01D8,0098,000E,
                            C5BD,       ; Colour index += 12h
                            5AD6,
                            C595,       ; Done
                        000A,
                            0154,0055,000B,
                            C5BD,       ; Colour index += 12h
                            4E73,
                            C595,       ; Done
                        000A,
                            00D0,0010,0007,
                            C5BD,       ; Colour index += 12h
                            4631,
                            C595,       ; Done
                        000A,
                            00AA,000B,0004,
                            C5BD,       ; Colour index += 12h
                            3DEF,
                            C595,       ; Done
                        C673,18,    ; Queue sound 18h, sound library 2, max queued sounds allowed = 6 (beacon)
                        000A,
                            00D0,0010,0007,
                            C5BD,       ; Colour index += 12h
                            4631,
                            C595,       ; Done
                        000A,
                            0154,0055,000B,
                            C5BD,       ; Colour index += 12h
                            4E73,
                            C595,       ; Done
                        000A,
                            01D8,0098,000E,
                            C5BD,       ; Colour index += 12h
                            5AD6,
                            C595,       ; Done
                        000A,
                            023B,00FB,0011,
                            C5BD,       ; Colour index += 12h
                            739C,
                            C595,       ; Done
                        C61E,EFFB   ; Go to $EFFB
}


;;; $F08E: Instruction list - palette FX object $F785 (Norfair 2) ;;;
{
$8D:F08E             dx C655,006A,  ; Palette FX object colour index = 6Ah
$8D:F092             dx F1C6,00,    ; Samus in heat palette FX index = 0
                        0010,
                            09FD,093B,0459,
                            C5AB,       ; Colour index += 8
                            09FD,4A52,
                            C595,       ; Done
                        F1C6,01,    ; Samus in heat palette FX index = 1
                        0004,
                            0E3D,0D7C,089A,
                            C5AB,       ; Colour index += 8
                            0E3D,4214,
                            C595,       ; Done
                        F1C6,02,    ; Samus in heat palette FX index = 2
                        0004,
                            165E,0DBC,08FB,
                            C5AB,       ; Colour index += 8
                            165E,39F5,
                            C595,       ; Done
                        F1C6,03,    ; Samus in heat palette FX index = 3
                        0005,
                            1A9E,11FD,0D3C,
                            C5AB,       ; Colour index += 8
                            1A9E,31D7,
                            C595,       ; Done
                        F1C6,04,    ; Samus in heat palette FX index = 4
                        0006,
                            1EBE,161D,119C,
                            C5AB,       ; Colour index += 8
                            1EBE,29D9,
                            C595,       ; Done
                        F1C6,05,    ; Samus in heat palette FX index = 5
                        0007,
                            22FE,1A5E,15DD,
                            C5AB,       ; Colour index += 8
                            22FE,21BA,
                            C595,       ; Done
                        F1C6,06,    ; Samus in heat palette FX index = 6
                        0008,
                            2B1F,1A9E,163E,
                            C5AB,       ; Colour index += 8
                            2B1F,199C,
                            C595,       ; Done
                        F1C6,07,    ; Samus in heat palette FX index = 7
                        0008,
                            2F5F,1EDF,1A7F,
                            C5AB,       ; Colour index += 8
                            2F5F,0D7F,
                            C595,       ; Done
                        F1C6,08,    ; Samus in heat palette FX index = 8
                        0008,
                            2F5F,1EDF,1A7F,
                            C5AB,       ; Colour index += 8
                            2F5F,0D7F,
                            C595,       ; Done
                        F1C6,09,    ; Samus in heat palette FX index = 9
                        0008,
                            2B1F,1A9E,163E,
                            C5AB,       ; Colour index += 8
                            2B1F,199C,
                            C595,       ; Done
                        F1C6,0A,    ; Samus in heat palette FX index = Ah
                        0007,
                            22FE,1A5E,15DD,
                            C5AB,       ; Colour index += 8
                            22FE,21BA,
                            C595,       ; Done
                        F1C6,0B,    ; Samus in heat palette FX index = Bh
                        0006,
                            1EBE,161D,119C,
                            C5AB,       ; Colour index += 8
                            1EBE,29D9,
                            C595,       ; Done
                        F1C6,0C,    ; Samus in heat palette FX index = Ch
                        0005,
                            1A9E,11FD,0D3C,
                            C5AB,       ; Colour index += 8
                            1A9E,31D7,
                            C595,       ; Done
                        F1C6,0D,    ; Samus in heat palette FX index = Dh
                        0004,
                            165E,0DBC,08FB,
                            C5AB,       ; Colour index += 8
                            165E,39F5,
                            C595,       ; Done
                        F1C6,0E,    ; Samus in heat palette FX index = Eh
                        0004,
                            0E3D,0D7C,089A,
                            C5AB,       ; Colour index += 8
                            0E3D,4214,
                            C595,       ; Done
                        F1C6,0F,    ; Samus in heat palette FX index = Fh
                        0010,
                            09FD,093B,0459,
                            C5AB,       ; Colour index += 8
                            09FD,4A52,
                            C595,       ; Done
                        C61E,F092   ; Go to $F092
}


;;; $F1C6: Instruction - Samus in heat palette FX index = [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$8D:F1C6 B9 00 00    LDA $0000,y[$8D:F094]
$8D:F1C9 29 FF 00    AND #$00FF
$8D:F1CC 8D ED 1E    STA $1EED  [$7E:1EED]
$8D:F1CF C8          INY
$8D:F1D0 60          RTS
}


;;; $F1D1: Instruction list - palette FX object $F789 (Norfair 4) ;;;
{
$8D:F1D1             dx C655,0082,  ; Palette FX object colour index = 82h
$8D:F1D5             dx 0010,
                            09FD,093B,0459,
                            C5B4,       ; Colour index += 10h
                            4309,0C77,
                            C595,       ; Done
                        0004,
                            0E3D,0D7C,089A,
                            C5B4,       ; Colour index += 10h
                            36AC,0CB8,
                            C595,       ; Done
                        0004,
                            165E,0DBC,08FB,
                            C5B4,       ; Colour index += 10h
                            328F,1119,
                            C595,       ; Done
                        0005,
                            1A9E,11FD,0D3C,
                            C5B4,       ; Colour index += 10h
                            2A52,157A,
                            C595,       ; Done
                        0006,
                            1EBE,161D,119C,
                            C5B4,       ; Colour index += 10h
                            2214,15BB,
                            C595,       ; Done
                        0007,
                            22FE,1A5E,15DD,
                            C5B4,       ; Colour index += 10h
                            1DF7,1A1C,
                            C595,       ; Done
                        0008,
                            2B1F,1A9E,163E,
                            C5B4,       ; Colour index += 10h
                            15BA,1E7D,
                            C595,       ; Done
                        0008,
                            2F5F,1EDF,1A7F,
                            C5B4,       ; Colour index += 10h
                            0D7F,22FF,
                            C595,       ; Done
                        0008,
                            2F5F,1EDF,1A7F,
                            C5B4,       ; Colour index += 10h
                            0D7F,22FF,
                            C595,       ; Done
                        0008,
                            2B1F,1A9E,163E,
                            C5B4,       ; Colour index += 10h
                            15BA,1E7D,
                            C595,       ; Done
                        0007,
                            22FE,1A5E,15DD,
                            C5B4,       ; Colour index += 10h
                            1DF7,1A1C,
                            C595,       ; Done
                        0006,
                            1EBE,161D,119C,
                            C5B4,       ; Colour index += 10h
                            2214,15BB,
                            C595,       ; Done
                        0005,
                            1A9E,11FD,0D3C,
                            C5B4,       ; Colour index += 10h
                            2A52,157A,
                            C595,       ; Done
                        0004,
                            165E,0DBC,08FB,
                            C5B4,       ; Colour index += 10h
                            328F,1119,
                            C595,       ; Done
                        0004,
                            0E3D,0D7C,089A,
                            C5B4,       ; Colour index += 10h
                            36AC,0CB8,
                            C595,       ; Done
                        0010,
                            09FD,093B,0459,
                            C5B4,       ; Colour index += 10h
                            4309,0C77,
                            C595,       ; Done
                        C61E,F1D5   ; Go to $F1D5
}


;;; $F2D9: Instruction list - palette FX object $F78D (Norfair 8) ;;;
{
$8D:F2D9             dx C655,00A2,  ; Palette FX object colour index = A2h
$8D:F2DD             dx 0010,
                            09FD,093B,0459,
                            C5B4,       ; Colour index += 10h
                            2DB3,38CF,
                            C595,       ; Done
                        0004,
                            0E3D,0D7C,089A,
                            C5B4,       ; Colour index += 10h
                            2594,30D1,
                            C595,       ; Done
                        0004,
                            165E,0DBC,08FB,
                            C5B4,       ; Colour index += 10h
                            2176,28D3,
                            C595,       ; Done
                        0005,
                            1A9E,11FD,0D3C,
                            C5B4,       ; Colour index += 10h
                            1D57,24D5,
                            C595,       ; Done
                        0006,
                            1EBE,161D,119C,
                            C5B4,       ; Colour index += 10h
                            1959,20F7,
                            C595,       ; Done
                        0007,
                            22FE,1A5E,15DD,
                            C5B4,       ; Colour index += 10h
                            153B,18F9,
                            C595,       ; Done
                        0008,
                            2B1F,1A9E,163E,
                            C5B4,       ; Colour index += 10h
                            111C,14FB,
                            C595,       ; Done
                        0008,
                            2F5F,1EDF,1A7F,
                            C5B4,       ; Colour index += 10h
                            0D1F,0D1F,
                            C595,       ; Done
                        0008,
                            2F5F,1EDF,1A7F,
                            C5B4,       ; Colour index += 10h
                            0D1F,0D1F,
                            C595,       ; Done
                        0008,
                            2B1F,1A9E,163E,
                            C5B4,       ; Colour index += 10h
                            111C,14FB,
                            C595,       ; Done
                        0007,
                            22FE,1A5E,15DD,
                            C5B4,       ; Colour index += 10h
                            153B,18F9,
                            C595,       ; Done
                        0006,
                            1EBE,161D,119C,
                            C5B4,       ; Colour index += 10h
                            1959,20F7,
                            C595,       ; Done
                        0005,
                            1A9E,11FD,0D3C,
                            C5B4,       ; Colour index += 10h
                            1D57,24D5,
                            C595,       ; Done
                        0004,
                            165E,0DBC,08FB,
                            C5B4,       ; Colour index += 10h
                            2176,28D3,
                            C595,       ; Done
                        0004,
                            0E3D,0D7C,089A,
                            C5B4,       ; Colour index += 10h
                            2594,30D1,
                            C595,       ; Done
                        0010,
                            09FD,093B,0459,
                            C5B4,       ; Colour index += 10h
                            2DB3,38CF,
                            C595,       ; Done
                        C61E,F2DD   ; Go to $F2DD
}


;;; $F3E1: Instruction list - palette FX object $F791 (Norfair 10h) ;;;
{
$8D:F3E1             dx C655,00C2,  ; Palette FX object colour index = C2h
$8D:F3E5             dx 0010,
                            09DA,091A,087A,
                            C5B4,       ; Colour index += 10h
                            08A8,0C05,
                            C595,       ; Done
                        0004,
                            0DDA,093A,089A,
                            C5B4,       ; Colour index += 10h
                            08AA,0828,
                            C595,       ; Done
                        0004,
                            0DFA,0D5A,08BA,
                            C5B4,       ; Colour index += 10h
                            08AC,084A,
                            C595,       ; Done
                        0005,
                            11FA,0D7A,08FA,
                            C5B4,       ; Colour index += 10h
                            08CF,086D,
                            C595,       ; Done
                        0006,
                            161A,119A,0D1A,
                            C5B4,       ; Colour index += 10h
                            08D1,0890,
                            C595,       ; Done
                        0007,
                            1A1A,11BA,0D3A,
                            C5B4,       ; Colour index += 10h
                            08F4,08B3,
                            C595,       ; Done
                        0008,
                            1A3A,15DA,0D7A,
                            C5B4,       ; Colour index += 10h
                            08F6,08D5,
                            C595,       ; Done
                        0008,
                            225A,1A1A,11BA,
                            C5B4,       ; Colour index += 10h
                            091A,091A,
                            C595,       ; Done
                        0008,
                            225A,1A1A,11BA,
                            C5B4,       ; Colour index += 10h
                            091A,091A,
                            C595,       ; Done
                        0008,
                            1A3A,15DA,0D7A,
                            C5B4,       ; Colour index += 10h
                            08F6,08D5,
                            C595,       ; Done
                        0007,
                            1A1A,11BA,0D3A,
                            C5B4,       ; Colour index += 10h
                            08F4,08B3,
                            C595,       ; Done
                        0006,
                            161A,119A,0D1A,
                            C5B4,       ; Colour index += 10h
                            08D1,0890,
                            C595,       ; Done
                        0005,
                            11FA,0D7A,08FA,
                            C5B4,       ; Colour index += 10h
                            08CF,086D,
                            C595,       ; Done
                        0004,
                            0DFA,0D5A,08BA,
                            C5B4,       ; Colour index += 10h
                            08AC,084A,
                            C595,       ; Done
                        0004,
                            0DDA,093A,089A,
                            C5B4,       ; Colour index += 10h
                            08AA,0828,
                            C595,       ; Done
                        0010,
                            09DA,091A,087A,
                            C5B4,       ; Colour index += 10h
                            08A8,0C05,
                            C595,       ; Done
                        C61E,F3E5   ; Go to $F3E5
}


;;; $F4E9: Instruction list - palette FX object $F795 (Maridia 1 - sand pits) ;;;
{
; Sand pits (BG1/2 palette 2 colours 4..Bh)
; Used by rooms with sand pits
$8D:F4E9             dx C655,0048,  ; Palette FX object colour index = 48h
$8D:F4ED             dx 000A,
                            3ED9,2E57,2A35,25F3,25D2,1DB0,196E,112E,
                            C595,       ; Done
                        000A,
                            2E57,2A35,25F3,3ED9,1DB0,196E,112E,25D2,
                            C595,       ; Done
                        000A,
                            2A35,25F3,3ED9,2E57,196E,112E,25D2,1DB0,
                            C595,       ; Done
                        000A,
                            25F3,3ED9,2E57,2A35,112E,25D2,1DB0,196E,
                            C595,       ; Done
                        C61E,F4ED   ; Go to $F4ED
}


;;; $F541: Instruction list - palette FX object $F799 (Maridia 2 - sand falls) ;;;
{
; Sand falls (BG1/2 palette 2 colours 8..Bh)
; Used by sand fall rooms, snail room save station and Botwoon's room
$8D:F541             dx C655,0050,  ; Palette FX object colour index = 50h
$8D:F545             dx 000A,
                            25D2,1DB0,196E,112E,
                            C595,       ; Done
                        000A,
                            1DB0,196E,112E,25D2,
                            C595,       ; Done
                        000A,
                            196E,112E,25D2,1DB0,
                            C595,       ; Done
                        000A,
                            112E,25D2,1DB0,196E,
                            C595,       ; Done
                        C61E,F545   ; Go to $F545
}


;;; $F579: Instruction list - palette FX object $F79D (Maridia 4 - background waterfalls) ;;;
{
; Background waterfalls (BG1/2 palette 3 colours 8..Fh)
; Used by the spike room and two grapple rooms near Draygon
$8D:F579             dx C655,0068,  ; Palette FX object colour index = 68h
$8D:F57D             dx 0002,
                            0400,0C22,1864,2086,2CC9,1C65,1043,0821,
                            C595,       ; Done
                        0002,
                            0C22,1864,2086,2CC9,1C65,1043,0821,0400,
                            C595,       ; Done
                        0002,
                            1864,2086,2CC9,1C65,1043,0821,0400,0C22,
                            C595,       ; Done
                        0002,
                            2086,2CC9,1C65,1043,0821,0400,0C22,1864,
                            C595,       ; Done
                        0002,
                            2CC9,1C65,1043,0821,0400,0C22,1864,2086,
                            C595,       ; Done
                        0002,
                            1C65,1043,0821,0400,0C22,1864,2086,2CC9,
                            C595,       ; Done
                        0002,
                            1043,0821,0400,0C22,1864,2086,2CC9,1C65,
                            C595,       ; Done
                        0002,
                            0821,0400,0C22,1864,2086,2CC9,1C65,1043,
                            C595,       ; Done
                        C61E,F57D   ; Go to $F57D
}


;;; $F621: Pre-instruction - delete if two more palette FX objects are spawned ;;;
{
;; Parameters:
;;     X: Palette FX object index

; Huh. Weird...
$8D:F621 BD 79 1E    LDA $1E79,x[$7E:1E87]  ;\
$8D:F624 F0 03       BEQ $03    [$F629]     ;} If [palette FX object ([X] - 2) ID] != 0:
$8D:F626 9E 7D 1E    STZ $1E7D,x[$7E:1E8B]  ; Palette FX object ID = 0

$8D:F629 60          RTS
}


;;; $F62A: Instruction list - palette FX object $F7A5 (Tourian 4 - unused clone of Tourian 2) ;;;
{
; Clone of Tourian 2
$8D:F62A             dx C655,00E8,  ; Palette FX object colour index = E8h
                        C61E,F636   ; Go to $F636
}


;;; $F632: Instruction list - palette FX object $F7A1 (Tourian 2 - glowing arkanoid blocks and red orbs) ;;;
{
; Glowing arkanoid blocks and red orbs (BG1/2 palette 7 colours 4 / 8..Eh)
; Used by most Tourian rooms
$8D:F632             dx C655,00E8,  ; Palette FX object colour index = E8h
}


;;; $F636: Instruction list - common section of Tourian 2 / 4 ;;;
{
$8D:F636             dx C5D4,F621,  ; Pre-instruction = $F621 (delete if two more palette FX objects are spawned)
$8D:F63A             dx 000A,
                            5294,
                            C5A2,       ; Colour index += 6
                            0019,0012,5C00,4000,1084,197F,7FFF,
                            C595,       ; Done
                        000A,
                            4A52,
                            C5A2,       ; Colour index += 6
                            0016,000F,5000,3400,1084,0D1C,739C,
                            C595,       ; Done
                        000A,
                            4210,
                            C5A2,       ; Colour index += 6
                            0013,000C,4400,2800,1084,00B9,6739,
                            C595,       ; Done
                        000A,
                            39CE,
                            C5A2,       ; Colour index += 6
                            0010,0009,3800,1C00,1084,0056,5AD6,
                            C595,       ; Done
                        000A,
                            318C,
                            C5A2,       ; Colour index += 6
                            000D,0006,2C00,1000,1084,0013,4E73,
                            C595,       ; Done
                        000A,
                            294A,
                            C5A2,       ; Colour index += 6
                            000A,0003,2000,0400,1084,0010,4210,
                            C595,       ; Done
                        000A,
                            294A,
                            C5A2,       ; Colour index += 6
                            000A,0003,2000,0400,1084,0010,4210,
                            C595,       ; Done
                        000A,
                            318C,
                            C5A2,       ; Colour index += 6
                            000D,0006,2C00,1000,1084,0013,4E73,
                            C595,       ; Done
                        000A,
                            39CE,
                            C5A2,       ; Colour index += 6
                            0010,0009,3800,1C00,1084,0056,5AD6,
                            C595,       ; Done
                        000A,
                            4210,
                            C5A2,       ; Colour index += 6
                            0013,000C,4400,2800,1084,00B9,6739,
                            C595,       ; Done
                        000A,
                            4A52,
                            C5A2,       ; Colour index += 6
                            0016,000F,5000,3400,1084,0D1C,739C,
                            C595,       ; Done
                        C61E,F63A   ; Go to $F63A
}


;;; $F730: Setup - palette FX object $F779 (Brinstar 8 - Spore Spawn blue background spores) ;;;
{
;; Parameters:
;;     Y: Palette FX object index
$8D:F730 DA          PHX                    ;\
$8D:F731 AE 9F 07    LDX $079F  [$7E:079F]  ;|
$8D:F734 BF 28 D8 7E LDA $7ED828,x[$7E:D829];|
$8D:F738 FA          PLX                    ;} If area mini-boss is dead:
$8D:F739 29 02 00    AND #$0002             ;|
$8D:F73C F0 06       BEQ $06    [$F744]     ;/
$8D:F73E A9 00 00    LDA #$0000             ;\
$8D:F741 99 7D 1E    STA $1E7D,y            ;} Delete palette FX object

$8D:F744 60          RTS
}
}


;;; $F745: Palette FX objects - Tourian entrance statue / torizo belly ;;;
{
$8D:F745             dw C685,E220 ; Nothing
$8D:F749             dw C685,E222 ; Grey out Tourian entrance statue - Draygon
$8D:F74D             dw C685,E22A ; Grey out Tourian entrance statue - Kraid
$8D:F751             dw C685,E232 ; Grey out Tourian entrance statue - Ridley
$8D:F755             dw C685,E23A ; Grey out Tourian entrance statue - Phantoon
$8D:F759             dw C685,E2E9 ; Bomb Torizo belly
$8D:F75D             dw C685,E331 ; Golden Torizo belly
}


;;; $F761: Palette FX objects - FX - non escape sequence ;;;
{
$8D:F761             dw E440,E45E ; Norfair 1 / Tourian 1
$8D:F765             dw C685,EB3B ; Crateria 1 - lightning
$8D:F769             dw C685,EC6E ; Unused. Dark lightning
$8D:F76D             dw C685,EAE2 ; Wrecked Ship 1 - green lights
$8D:F771             dw C685,EAE2 ; Unused clone of Wrecked Ship 1
$8D:F775             dw C685,ED99 ; Brinstar 1 - blue background spores
$8D:F779             dw F730,EE2D ; Brinstar 8 - Spore Spawn blue background spores
$8D:F77D             dw C685,EED7 ; Brinstar 2 - red background glow
$8D:F781             dw C685,EFF7 ; Crateria 80h / Brinstar 4 - beacon flashing
$8D:F785             dw C685,F08E ; Norfair 2
$8D:F789             dw C685,F1D1 ; Norfair 4
$8D:F78D             dw C685,F2D9 ; Norfair 8
$8D:F791             dw C685,F3E1 ; Norfair 10h
$8D:F795             dw C685,F4E9 ; Maridia 1 - sand pits
$8D:F799             dw C685,F541 ; Maridia 2 - sand falls
$8D:F79D             dw C685,F579 ; Maridia 4 - background waterfalls
$8D:F7A1             dw C685,F632 ; Tourian 2 - glowing arkanoid blocks and red orbs
$8D:F7A5             dw C685,F62A ; Tourian 4 - unused clone of Tourian 2
}


;;; $F7A9..FFC8: Instruction lists - FX - escape sequence ;;;
{
;;; $F7A9: Instruction list - palette FX object $FFC9 (Tourian 8 - shutter red flashing) ;;;
{
; Shutter red flashing (sprite palette 1 colours 9..Eh)
; Used by escape room 1
$8D:F7A9             dx C655,0132   ; Palette FX object colour index = 132h
$8D:F7AD             dx 0002,
                            5294,4210,318C,2108,1084,7FFF,
                            C595,       ; Done
                        0002,
                            4E75,3DF1,2D6D,1CE8,0C64,77BF,
                            C595,       ; Done
                        0002,
                            4A55,39D1,2D6D,1CE8,0C64,739F,
                            C595,       ; Done
                        0002,
                            4636,35B2,294D,18C9,0844,6B5F,
                            C595,       ; Done
                        0002,
                            3DF6,3192,252D,14A9,0844,673F,
                            C595,       ; Done
                        0002,
                            39D7,2D72,210E,1089,0424,5EFF,
                            C595,       ; Done
                        0002,
                            35B7,2952,1CEE,1089,0424,5ADF,
                            C595,       ; Done
                        0002,
                            3198,2533,18CE,0C69,0004,529F,
                            C595,       ; Done
                        0002,
                            35B7,2952,1CEE,1089,0424,5ADF,
                            C595,       ; Done
                        0002,
                            39D7,2D72,210E,1089,0424,5EFF,
                            C595,       ; Done
                        0002,
                            3DF6,3192,252D,14A9,0844,673F,
                            C595,       ; Done
                        0002,
                            4636,35B2,294D,18C9,0844,6B5F,
                            C595,       ; Done
                        0002,
                            4A55,39D1,2D6D,1CE8,0C64,739F,
                            C595,       ; Done
                        0002,
                            4E75,3DF1,2D6D,1CE8,0C64,77BF,
                            C595,       ; Done
                        C61E,F7AD   ; Go to $F7AD
}


;;; $F891: Instruction list - palette FX object $FFCD (Tourian 10h - background red flashing) ;;;
{
; Background red flashing (BG1/2 palette 3 colours 8..Bh)
$8D:F891             dx C655,0070,  ; Palette FX object colour index = 70h
$8D:F895             dx 0004,
                            081A,0812,042B,0423,
                            C595,       ; Done
                        0004,
                            0C37,0C30,042A,0423,
                            C595,       ; Done
                        0004,
                            1054,0C2E,0849,0422,
                            C595,       ; Done
                        0004,
                            1471,104C,0848,0422,
                            C595,       ; Done
                        0004,
                            148E,106A,0C66,0842,
                            C595,       ; Done
                        0004,
                            18AB,1488,0C65,0842,
                            C595,       ; Done
                        0004,
                            1CC8,1486,1084,0841,
                            C595,       ; Done
                        0004,
                            20E5,18A4,1083,0841,
                            C595,       ; Done
                        0004,
                            1CC8,1486,1084,0841,
                            C595,       ; Done
                        0004,
                            18AB,1488,0C65,0842,
                            C595,       ; Done
                        0004,
                            148E,106A,0C66,0842,
                            C595,       ; Done
                        0004,
                            1471,104C,0848,0422,
                            C595,       ; Done
                        0004,
                            1054,0C2E,0849,0422,
                            C595,       ; Done
                        0004,
                            0C37,0C30,042A,0423,
                            C595,       ; Done
                        C61E,F895   ; Go to $F895
}


;;; $F941: Instruction list - palette FX object $FFD1 (Tourian 20h - general level red flashing) ;;;
{
; General level red flashing (BG1/2 palette 5 colours 4..9 / Eh)
; Used by Tourian escape rooms
$8D:F941             dx C655,00A8,  ; Palette FX object colour index = A8h
                        C61E,F94D   ; Go to $F94D
}


;;; $F949: Instruction list - palette FX object $FFD5 (Tourian 40h - red flashing arkanoid blocks and red orbs) ;;;
{
; Red flashing arkanoid blocks and red orbs (BG1/2 palette 7 colours 4..9 / Eh)
; Used by Tourian escape rooms
$8D:F949             dx C655,00E8,  ; Palette FX object colour index = E8h
}


;;; $F94D: Instruction list - common section of Tourian 20h / 40h ;;;
{
$8D:F94D             dx 0002,
                            5294,39CE,2108,1084,0019,0012,
                            C5AB,       ; Colour index += 8
                            7FFF,
                            C595,       ; Done
                        0002,
                            4E75,35AF,1CE8,0C64,080D,0809,
                            C5AB,       ; Colour index += 8
                            77BF,
                            C595,       ; Done
                        0002,
                            4A55,318F,1CE9,0C64,1000,1000,
                            C5AB,       ; Colour index += 8
                            739F,
                            C595,       ; Done
                        0002,
                            4636,2D70,18C9,0844,080D,0809,
                            C5AB,       ; Colour index += 8
                            6B5F,
                            C595,       ; Done
                        0002,
                            3DF6,2D70,18CA,0844,0019,0012,
                            C5AB,       ; Colour index += 8
                            673F,
                            C595,       ; Done
                        0002,
                            39D7,2951,14AA,0424,080D,0809,
                            C5AB,       ; Colour index += 8
                            5EFF,
                            C595,       ; Done
                        0002,
                            35B7,2531,14AB,0424,1000,1000,
                            C5AB,       ; Colour index += 8
                            5ADF,
                            C595,       ; Done
                        0002,
                            3198,2112,108B,0004,080D,0809,
                            C5AB,       ; Colour index += 8
                            529F,
                            C595,       ; Done
                        0002,
                            35B7,2531,14AB,0424,1000,1000,
                            C5AB,       ; Colour index += 8
                            5ADF,
                            C595,       ; Done
                        0002,
                            39D7,2951,14AA,0424,080D,0809,
                            C5AB,       ; Colour index += 8
                            5EFF,
                            C595,       ; Done
                        0002,
                            3DF6,2D70,18CA,0844,0019,0012,
                            C5AB,       ; Colour index += 8
                            673F,
                            C595,       ; Done
                        0002,
                            4636,2D70,18C9,0844,080D,0809,
                            C5AB,       ; Colour index += 8
                            6B5F,
                            C595,       ; Done
                        0002,
                            4A55,318F,1CE9,0C64,1000,1000,
                            C5AB,       ; Colour index += 8
                            739F,
                            C595,       ; Done
                        0002,
                            4E75,35AF,1CE8,0C64,080D,0809,
                            C5AB,       ; Colour index += 8
                            77BF,
                            C595,       ; Done
                        C61E,F94D   ; Go to $F94D
}


;;; $FA69: Instruction list - palette FX object $FFD9 (Crateria 8 - old Tourian red flashing) ;;;
{
; Old Tourian red flashing (BG1/2 palette 5 colours 1..3 / 8..Bh / Eh)
; Used by old Tourian escape shaft during escape
$8D:FA69             dx C655,00A2,  ; Palette FX object colour index = A2h
$8D:FA6D             dx 0003,
                            5A73,41AD,28E7,
                            C5AB,       ; Colour index += 8
                            0019,0012,3460,0C20,
                            C599,       ; Colour index += 4
                            7F9C,
                            C595,       ; Done
                        0003,
                            4E14,396E,24C8,
                            C5AB,       ; Colour index += 8
                            0014,000E,4900,1C60,
                            C599,       ; Colour index += 4
                            6F3C,
                            C595,       ; Done
                        0003,
                            41D5,312E,1CA8,
                            C5AB,       ; Colour index += 8
                            000F,000A,5980,2CA0,
                            C599,       ; Colour index += 4
                            62FD,
                            C595,       ; Done
                        0003,
                            3576,28EF,1889,
                            C5AB,       ; Colour index += 8
                            000A,0005,6E20,38C0,
                            C599,       ; Colour index += 4
                            529D,
                            C595,       ; Done
                        0003,
                            2D17,20D0,1489,
                            C5AB,       ; Colour index += 8
                            0005,0001,7EA0,4900,
                            C599,       ; Colour index += 4
                            423E,
                            C595,       ; Done
                        0003,
                            20B8,1891,106A,
                            C5AB,       ; Colour index += 8
                            000A,0005,6E20,38C0,
                            C599,       ; Colour index += 4
                            31DE,
                            C595,       ; Done
                        0003,
                            1479,1051,084A,
                            C5AB,       ; Colour index += 8
                            000F,000A,5980,2CA0,
                            C599,       ; Colour index += 4
                            259F,
                            C595,       ; Done
                        0003,
                            081A,0812,042B,
                            C5AB,       ; Colour index += 8
                            0014,000E,4900,1C60,
                            C599,       ; Colour index += 4
                            153F,
                            C595,       ; Done
                        0003,
                            1479,1051,084A,
                            C5AB,       ; Colour index += 8
                            000F,000A,5980,2CA0,
                            C599,       ; Colour index += 4
                            259F,
                            C595,       ; Done
                        0003,
                            20B8,1891,106A,
                            C5AB,       ; Colour index += 8
                            000A,0005,6E20,38C0,
                            C599,       ; Colour index += 4
                            31DE,
                            C595,       ; Done
                        0003,
                            2D17,20D0,1489,
                            C5AB,       ; Colour index += 8
                            0005,0001,7EA0,4900,
                            C599,       ; Colour index += 4
                            423E,
                            C595,       ; Done
                        0003,
                            3576,28EF,1889,
                            C5AB,       ; Colour index += 8
                            000A,0005,6E20,38C0,
                            C599,       ; Colour index += 4
                            529D,
                            C595,       ; Done
                        0003,
                            41D5,312E,1CA8,
                            C5AB,       ; Colour index += 8
                            000F,000A,5980,2CA0,
                            C599,       ; Colour index += 4
                            62FD,
                            C595,       ; Done
                        0003,
                            4E14,396E,24C8,
                            C5AB,       ; Colour index += 8
                            0014,000E,4900,1C60,
                            C599,       ; Colour index += 4
                            6F3C,
                            C595,       ; Done
                        C61E,FA6D   ; Go to $FA6D
}


;;; $FBC1: Instruction list - palette FX object $FFDD (Crateria 10h - old Tourian background railings flash orange) ;;;
{
; Old Tourian background railings flash orange (BG1/2 palette 6 colours 9..Bh)
; Used by old Tourian escape shaft during escape
$8D:FBC1             dx C655,00D2,  ; Palette FX object colour index = D2h
$8D:FBC5             dx 0010,
                            35AD,1CE7,0C63,
                            C595,       ; Done
                        0001,
                            29D0,150A,0885,
                            C595,       ; Done
                        0001,
                            1E14,114D,08A7,
                            C595,       ; Done
                        0002,
                            0E37,096F,04A8,
                            C595,       ; Done
                        0001,
                            025A,0192,00CA,
                            C595,       ; Done
                        0002,
                            35AD,1CE7,0C63,
                            C595,       ; Done
                        0001,
                            29D0,150A,0885,
                            C595,       ; Done
                        0001,
                            1E14,114D,08A7,
                            C595,       ; Done
                        0001,
                            0E37,096F,04A8,
                            C595,       ; Done
                        0001,
                            025A,0192,00CA,
                            C595,       ; Done
                        0020,
                            35AD,1CE7,0C63,
                            C595,       ; Done
                        0002,
                            29D0,150A,0885,
                            C595,       ; Done
                        0001,
                            1E14,114D,08A7,
                            C595,       ; Done
                        0001,
                            0E37,096F,04A8,
                            C595,       ; Done
                        0001,
                            025A,0192,00CA,
                            C595,       ; Done
                        C61E,FBC5   ; Go to $FBC5
}


;;; $FC5F: Instruction list - palette FX object $FFE1 (Crateria 20h - old Tourian background panels flash yellow) ;;;
{
; Used by old Tourian escape shaft during escape
$8D:FC5F             dx C655,00AA,  ; Palette FX object colour index = AAh
$8D:FC63             dx 0010,
                            28C8,2484,1C61,
                            C595,       ; Done
                        0001,
                            398E,296B,1549,
                            C595,       ; Done
                        0001,
                            4A74,2E52,1230,
                            C595,       ; Done
                        0002,
                            5739,3318,0B18,
                            C595,       ; Done
                        0001,
                            67FF,43FF,03FF,
                            C595,       ; Done
                        0002,
                            28C8,2484,1C61,
                            C595,       ; Done
                        0001,
                            398E,296B,1549,
                            C595,       ; Done
                        0001,
                            4A74,2E52,1230,
                            C595,       ; Done
                        0001,
                            5739,3318,0B18,
                            C595,       ; Done
                        0001,
                            67FF,43FF,03FF,
                            C595,       ; Done
                        0020,
                            28C8,2484,1C61,
                            C595,       ; Done
                        0002,
                            398E,296B,1549,
                            C595,       ; Done
                        0001,
                            4A74,2E52,1230,
                            C595,       ; Done
                        0001,
                            5739,3318,0B18,
                            C595,       ; Done
                        0001,
                            67FF,43FF,03FF,
                            C595,       ; Done
                        C61E,FC63   ; Go to $FC63
}


;;; $FCFD: Instruction list - palette FX object $FFE5 (Crateria 2 - upper Crateria red flashing) ;;;
{
; Upper Crateria red flashing (BG1/2 palette 4 colours 1..7)
; Used by landing site and Crateria mainstreet during escape
$8D:FCFD             dx C655,0082,  ; Palette FX object colour index = 82h
$8D:FD01             dx 0008,
                            1D89,0D06,0CA3,2D0E,2D09,28C5,0C81,
                            C595,       ; Done
                        0007,
                            1D8A,0D07,0CA4,2D0E,2D09,28C5,0421,
                            C595,       ; Done
                        0006,
                            1D8A,0D28,0CC4,2D0F,2D0A,28C6,0423,
                            C595,       ; Done
                        0005,
                            1D8B,0D29,0CC5,2D0F,2D0A,28C6,0424,
                            C595,       ; Done
                        0004,
                            1DAB,1149,10C5,2D0F,2D0B,28C7,0845,
                            C595,       ; Done
                        0003,
                            1DAC,114A,10C6,2D0F,2D0B,28C7,0846,
                            C595,       ; Done
                        0002,
                            1DAC,116B,10E6,2D10,2D0C,28C8,0848,
                            C595,       ; Done
                        0001,
                            1DAD,116C,10E7,2D10,2D0C,28C8,0015,
                            C595,       ; Done
                        0002,
                            1DAC,116B,10E6,2D10,2D0C,28C8,0848,
                            C595,       ; Done
                        0003,
                            1DAC,114A,10C6,2D0F,2D0B,28C7,0846,
                            C595,       ; Done
                        0004,
                            1DAB,1149,10C5,2D0F,2D0B,28C7,0845,
                            C595,       ; Done
                        0005,
                            1D8B,0D29,0CC5,2D0F,2D0A,28C6,0424,
                            C595,       ; Done
                        0006,
                            1D8A,0D28,0CC4,2D0F,2D0A,28C6,0423,
                            C595,       ; Done
                        0007,
                            1D8A,0D07,0CA4,2D0E,2D09,28C5,0421,
                            C595,       ; Done
                        C61E,FD01   ; Go to $FD01
}


;;; $FE01: Instruction list - palette FX object $FFE9 (Crateria 4 - yellow lightning) ;;;
{
; Yellow lightning (BG1/2 palette 5 colours 1..Bh)
; Used by landing site during escape
$8D:FE01             dx C655,00A2,  ; Palette FX object colour index = A2h
$8D:FE05             dx 0031,
                            48D5,38B0,286A,2488,2067,1846,1425,1024,0C23,0C03,0802,
                            C595,       ; Done
                        0001,
                            3DD8,31D5,2991,25B0,218F,1D8E,0C23,0C23,0822,0802,0401,
                            C595,       ; Done
                        0001,
                            32FC,2EDA,26D8,26D7,26D7,22B7,0802,0401,0401,0401,0401,
                            C595,       ; Done
                        0001,
                            27FF,27FF,27FF,27FF,27FF,27FF,0000,0000,0401,0000,0000,
                            C595,       ; Done
                        0001,
                            32FC,2EDA,26D8,26D7,26D7,22B7,0802,0401,0401,0401,0401,
                            C595,       ; Done
                        0011,
                            48D5,38B0,286A,2488,2067,1846,1425,1024,0C23,0C03,0802,
                            C595,       ; Done
                        0001,
                            32FC,2EDA,26D8,26D7,26D7,22B7,0802,0401,0401,0401,0401,
                            C595,       ; Done
                        0018,
                            48D5,38B0,286A,2488,2067,1846,1425,1024,0C23,0C03,0802,
                            C595,       ; Done
                        0001,
                            32FC,2EDA,26D8,26D7,26D7,22B7,0802,0401,0401,0401,0401,
                            C595,       ; Done
                        0001,
                            27FF,27FF,27FF,27FF,27FF,27FF,0000,0000,0401,0000,0000,
                            C595,       ; Done
                        0001,
                            32FC,2EDA,26D8,26D7,26D7,22B7,0802,0401,0401,0401,0401,
                            C595,       ; Done
                        C61E,FE05   ; Go to $FE05
}


;;; $FF27: Instruction list - palette FX object $FFED (Crateria 40h - slightly modifies an unnoticeable pixel in a CRE block) ;;;
{
; Slightly modifies an unnoticeable pixel in a CRE block (BG1/2 palette 5 colours 7..Bh)
; Used by Crateria mainstreet during escape
$8D:FF27             dx C655,00AE,  ; Palette FX object colour index = AEh
$8D:FF2B             dx 0031,
                            1425,1024,0C23,0C03,0802,
                            C595,       ; Done
                        0001,
                            0C23,0C23,0822,0802,0401,
                            C595,       ; Done
                        0001,
                            0802,0401,0401,0401,0401,
                            C595,       ; Done
                        0001,
                            0000,0000,0401,0000,0000,
                            C595,       ; Done
                        0001,
                            0802,0401,0401,0401,0401,
                            C595,       ; Done
                        0011,
                            1425,1024,0C23,0C03,0802,
                            C595,       ; Done
                        0001,
                            0802,0401,0401,0401,0401,
                            C595,       ; Done
                        0018,
                            1425,1024,0C23,0C03,0802,
                            C595,       ; Done
                        0001,
                            0802,0401,0401,0401,0401,
                            C595,       ; Done
                        0001,
                            0000,0000,0401,0000,0000,
                            C595,       ; Done
                        0001,
                            0802,0401,0401,0401,0401,
                            C595,       ; Done
                        C61E,FF2B   ; Go to $FF2B
}
}


;;; $FFC9: Palette FX objects - FX - escape sequence ;;;
{
$8D:FFC9             dw C685,F7A9 ; Tourian 8 - shutter red flashing
$8D:FFCD             dw C685,F891 ; Tourian 10h - background red flashing
$8D:FFD1             dw C685,F941 ; Tourian 20h - general level red flashing
$8D:FFD5             dw C685,F949 ; Tourian 40h - red flashing arkanoid blocks and red orbs
$8D:FFD9             dw C685,FA69 ; Crateria 8 - old Tourian red flashing
$8D:FFDD             dw C685,FBC1 ; Crateria 10h - old Tourian background railings flash orange
$8D:FFE1             dw C685,FC5F ; Crateria 20h - old Tourian background panels flash yellow
$8D:FFE5             dw C685,FCFD ; Crateria 2 - upper Crateria red flashing
$8D:FFE9             dw C685,FE01 ; Crateria 4 - yellow lightning
$8D:FFED             dw C685,FF27 ; Crateria 40h - slightly modifies an unnoticeable pixel in a CRE block
}


;;; $FFF1: Free space ;;;
{
$8D:FFF1             fillto $8E8000, $FF        ; Free space
}
