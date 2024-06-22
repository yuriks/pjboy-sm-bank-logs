;;; $8000:  ;;;
{
$DF:8000             db FF, E0, B8, 07, A0
}


;;; $8005: Unused. Boss fight 2 / Shitroid - alternate ;;;
{
; Note length table
$DF:8005             dw 0018, 5800,
                        32,65,7F,98,B2,CB,E5,FC,
                        19,32,4C,65,72,7F,8C,98,A5,B2,BF,CB,D8,E5,F2,FC

; Trackers
{
$DF:8021             dw 04EA, 5828

; Tracker pointers
$DF:8029/$582C       dw 582C, 5C2C

; Tracker 0 commands
$DF:8029/$582C       dw 5838,
                        5848,
                        5858,
                        00FF,582C,
                        0000

; Track pointers
$DF:8035/$5838       dw 5868, 58C9, 5924, 596C, 59C7, 0000, 0000, 0000
$DF:8045/$5848       dw 5A21, 5A5B, 5A90, 5ACE, 5B0C, 0000, 0000, 0000
$DF:8055/$5858       dw 5B33, 5B6C, 5B99, 5BC6, 5BDA, 0000, 0000, 0000

; Tracker 0, track set $5838, track 0 commands
{
$DF:8065/$5868       db FA,25,       ; Percussion instruments base index = 25h
                        EF,5C11,01,  ; Repeat subsection $5C11 1 time
                        E0,1B,       ; Select instrument 1Bh
                        F4,28,       ; Set subtranspose of 28h / 100h semitones
                        EA,00,       ; Set transpose of 0 semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8C,          ; Note C_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        ED,AA,       ; Static volume with volume multiplier = AAh / 100h
                        30,          ; Note length = 30h tics
                        97,          ; Note B_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        96,          ; Note Bb_2
                        90,          ; Note E_2
                        95,          ; Note A_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        0C,          ; Note length = Ch tics
                        8D,          ; Note Db_2
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8C,          ; Note C_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        ED,AA,       ; Static volume with volume multiplier = AAh / 100h
                        30,          ; Note length = 30h tics
                        97,          ; Note B_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        96,          ; Note Bb_2
                        90,          ; Note E_2
                        95,          ; Note A_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        0C,          ; Note length = Ch tics
                        8D,          ; Note Db_2
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8D,          ; Note Db_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        ED,AA,       ; Static volume with volume multiplier = AAh / 100h
                        30,          ; Note length = 30h tics
                        98,          ; Note C_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        97,          ; Note B_2
                        91,          ; Note F_2
                        96,          ; Note Bb_2
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        0C,          ; Note length = Ch tics
                        8E,          ; Note D_2
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8E,          ; Note D_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        ED,AA,       ; Static volume with volume multiplier = AAh / 100h
                        30,          ; Note length = 30h tics
                        99,          ; Note Db_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        98,          ; Note C_3
                        92,          ; Note Gb_2
                        97,          ; Note B_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        0C,          ; Note length = Ch tics
                        8F,          ; Note Eb_2
                        00
}

; Tracker 0, track set $5838, track 1 commands
{
$DF:80C6/$58C9       db E0,19,       ; Select instrument 19h
                        EA,FE,       ; Set transpose of FEh semitones
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,AC,BE,    ; Dynamic volume over ACh tics with target volume multiplier BEh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        24,7F,       ; Note length = 24h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        99,          ; Note Db_3
                        99,          ; Note Db_3
                        18,          ; Note length = 18h tics
                        99,          ; Note Db_3
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        24,          ; Note length = 24h tics
                        99,          ; Note Db_3
                        18,          ; Note length = 18h tics
                        99,          ; Note Db_3
                        0C,          ; Note length = Ch tics
                        99,          ; Note Db_3
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        EE,AC,C8,    ; Dynamic volume over ACh tics with target volume multiplier C8h / 100h
                        24,          ; Note length = 24h tics
                        9A,          ; Note D_3
                        9A,          ; Note D_3
                        18,          ; Note length = 18h tics
                        9A,          ; Note D_3
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        24,          ; Note length = 24h tics
                        9A,          ; Note D_3
                        18,          ; Note length = 18h tics
                        9A,          ; Note D_3
                        0C,          ; Note length = Ch tics
                        9A,          ; Note D_3
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        E2,FF,03,    ; Dynamic panning over FFh tics with target panning bias 3 / 14h
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        EE,AC,D2,    ; Dynamic volume over ACh tics with target volume multiplier D2h / 100h
                        24,          ; Note length = 24h tics
                        9B,          ; Note Eb_3
                        9B,          ; Note Eb_3
                        18,          ; Note length = 18h tics
                        9B,          ; Note Eb_3
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        24,          ; Note length = 24h tics
                        9B,          ; Note Eb_3
                        18,          ; Note length = 18h tics
                        9B,          ; Note Eb_3
                        0C,          ; Note length = Ch tics
                        9B,          ; Note Eb_3
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        EE,56,DC,    ; Dynamic volume over 56h tics with target volume multiplier DCh / 100h
                        24,          ; Note length = 24h tics
                        9C,          ; Note E_3
                        9C,          ; Note E_3
                        18,          ; Note length = 18h tics
                        9C,          ; Note E_3
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        EE,4A,FA,    ; Dynamic volume over 4Ah tics with target volume multiplier FAh / 100h
                        24,          ; Note length = 24h tics
                        9C,          ; Note E_3
                        18,          ; Note length = 18h tics
                        9C,          ; Note E_3
                        0C,          ; Note length = Ch tics
                        9C,          ; Note E_3
}

; Tracker 0, track set $5838, track 2 commands
{
$DF:8121/$5924       db E0,19,       ; Select instrument 19h
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        EA,FE,       ; Set transpose of FEh semitones
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        9F,          ; Note G_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A0,          ; Note Ab_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A1,          ; Note A_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
}

; Tracker 0, track set $5838, track 3 commands
{
$DF:8169/$596C       db E0,19,       ; Select instrument 19h
                        EA,FE,       ; Set transpose of FEh semitones
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,AC,BE,    ; Dynamic volume over ACh tics with target volume multiplier BEh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        24,7F,       ; Note length = 24h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        91,          ; Note F_2
                        91,          ; Note F_2
                        18,          ; Note length = 18h tics
                        91,          ; Note F_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        24,          ; Note length = 24h tics
                        91,          ; Note F_2
                        18,          ; Note length = 18h tics
                        91,          ; Note F_2
                        0C,          ; Note length = Ch tics
                        91,          ; Note F_2
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        EE,AC,C8,    ; Dynamic volume over ACh tics with target volume multiplier C8h / 100h
                        24,          ; Note length = 24h tics
                        92,          ; Note Gb_2
                        92,          ; Note Gb_2
                        18,          ; Note length = 18h tics
                        92,          ; Note Gb_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        24,          ; Note length = 24h tics
                        92,          ; Note Gb_2
                        18,          ; Note length = 18h tics
                        92,          ; Note Gb_2
                        0C,          ; Note length = Ch tics
                        92,          ; Note Gb_2
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        E2,FF,11,    ; Dynamic panning over FFh tics with target panning bias 11h / 14h
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        EE,AC,D2,    ; Dynamic volume over ACh tics with target volume multiplier D2h / 100h
                        24,          ; Note length = 24h tics
                        93,          ; Note G_2
                        93,          ; Note G_2
                        18,          ; Note length = 18h tics
                        93,          ; Note G_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        24,          ; Note length = 24h tics
                        93,          ; Note G_2
                        18,          ; Note length = 18h tics
                        93,          ; Note G_2
                        0C,          ; Note length = Ch tics
                        93,          ; Note G_2
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        EE,56,E6,    ; Dynamic volume over 56h tics with target volume multiplier E6h / 100h
                        24,          ; Note length = 24h tics
                        94,          ; Note Ab_2
                        94,          ; Note Ab_2
                        18,          ; Note length = 18h tics
                        94,          ; Note Ab_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        EE,4A,FA,    ; Dynamic volume over 4Ah tics with target volume multiplier FAh / 100h
                        24,          ; Note length = 24h tics
                        94,          ; Note Ab_2
                        18,          ; Note length = 18h tics
                        94,          ; Note Ab_2
                        0C,          ; Note length = Ch tics
                        94,          ; Note Ab_2
}

; Tracker 0, track set $5838, track 4 commands
{
$DF:81C4/$59C7       db E0,18,       ; Select instrument 18h
                        F4,32,       ; Set subtranspose of 32h / 100h semitones
                        EA,00,       ; Set transpose of 0 semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8C,          ; Note C_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        30,          ; Note length = 30h tics
                        97,          ; Note B_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        96,          ; Note Bb_2
                        90,          ; Note E_2
                        95,          ; Note A_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        0C,          ; Note length = Ch tics
                        8D,          ; Note Db_2
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8C,          ; Note C_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        30,          ; Note length = 30h tics
                        97,          ; Note B_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        96,          ; Note Bb_2
                        90,          ; Note E_2
                        95,          ; Note A_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        0C,          ; Note length = Ch tics
                        8D,          ; Note Db_2
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8D,          ; Note Db_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        30,          ; Note length = 30h tics
                        98,          ; Note C_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        97,          ; Note B_2
                        91,          ; Note F_2
                        96,          ; Note Bb_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        0C,          ; Note length = Ch tics
                        8E,          ; Note D_2
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8E,          ; Note D_2
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        30,          ; Note length = 30h tics
                        99,          ; Note Db_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        98,          ; Note C_3
                        92,          ; Note Gb_2
                        97,          ; Note B_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        0C,          ; Note length = Ch tics
                        8F,          ; Note Eb_2
}

; Tracker 0, track set $5848, track 0 commands
{
$DF:821E/$5A21       db EF,5C11,01,  ; Repeat subsection $5C11 1 time
                        E0,1B,       ; Select instrument 1Bh
                        F4,28,       ; Set subtranspose of 28h / 100h semitones
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        EA,00,       ; Set transpose of 0 semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        98,          ; Note C_3
                        8C,          ; Note C_2
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        0C,          ; Note length = Ch tics
                        98,          ; Note C_3
                        8C,          ; Note C_2
                        C8,          ; Tie
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        EE,3C,F5,    ; Dynamic volume over 3Ch tics with target volume multiplier F5h / 100h
                        98,          ; Note C_3
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        8C,          ; Note C_2
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        98,          ; Note C_3
                        E1,0E,       ; Panning bias = Eh / 14h with no phase inversion
                        8C,          ; Note C_2
                        E1,06,       ; Panning bias = 6 / 14h with no phase inversion
                        98,          ; Note C_3
                        E1,10,       ; Panning bias = 10h / 14h with no phase inversion
                        18,          ; Note length = 18h tics
                        8C,          ; Note C_2
                        E1,04,       ; Panning bias = 4 / 14h with no phase inversion
                        0C,          ; Note length = Ch tics
                        98,          ; Note C_3
                        E1,11,       ; Panning bias = 11h / 14h with no phase inversion
                        8C,          ; Note C_2
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        00
}

; Tracker 0, track set $5848, track 1 commands
{
$DF:8258/$5A5B       db E0,1A,       ; Select instrument 1Ah
                        EA,00,       ; Set transpose of 0 semitones
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        BA,          ; Note Bb_5
                        B9,          ; Note A_5
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        0C,          ; Note length = Ch tics
                        B2,          ; Note D_5
                        B1,          ; Note Db_5
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,78,FA,    ; Dynamic volume over 78h tics with target volume multiplier FAh / 100h
                        E0,19,       ; Select instrument 19h
                        EA,FE,       ; Set transpose of FEh semitones
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        24,          ; Note length = 24h tics
                        A5,          ; Note Db_4
                        A6,          ; Note D_4
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        A8,          ; Note E_4
                        E0,1A,       ; Select instrument 1Ah
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        EA,00,       ; Set transpose of 0 semitones
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        0C,          ; Note length = Ch tics
                        A7,          ; Note Eb_4
                        A8,          ; Note E_4
                        A9,          ; Note F_4
                        AA,          ; Note Gb_4
                        A9,          ; Note F_4
                        A8,          ; Note E_4
}

; Tracker 0, track set $5848, track 2 commands
{
$DF:828D/$5A90       db E0,1A,       ; Select instrument 1Ah
                        EA,00,       ; Set transpose of 0 semitones
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        E1,03,       ; Panning bias = 3 / 14h with no phase inversion
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B4,          ; Note E_5
                        B3,          ; Note Eb_5
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        E1,07,       ; Panning bias = 7 / 14h with no phase inversion
                        0C,          ; Note length = Ch tics
                        AC,          ; Note Ab_4
                        AB,          ; Note G_4
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        ED,A0,       ; Static volume with volume multiplier = A0h / 100h
                        EE,78,F5,    ; Dynamic volume over 78h tics with target volume multiplier F5h / 100h
                        E0,19,       ; Select instrument 19h
                        EA,FE,       ; Set transpose of FEh semitones
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        E2,78,03,    ; Dynamic panning over 78h tics with target panning bias 3 / 14h
                        24,          ; Note length = 24h tics
                        9F,          ; Note G_3
                        A0,          ; Note Ab_3
                        18,          ; Note length = 18h tics
                        A1,          ; Note A_3
                        A2,          ; Note Bb_3
                        ED,AA,       ; Static volume with volume multiplier = AAh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        E0,1A,       ; Select instrument 1Ah
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        EA,00,       ; Set transpose of 0 semitones
                        0C,          ; Note length = Ch tics
                        A1,          ; Note A_3
                        A2,          ; Note Bb_3
                        A3,          ; Note B_3
                        A4,          ; Note C_4
                        A3,          ; Note B_3
                        A2,          ; Note Bb_3
}

; Tracker 0, track set $5848, track 3 commands
{
$DF:82CB/$5ACE       db E0,1A,       ; Select instrument 1Ah
                        EA,00,       ; Set transpose of 0 semitones
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        E1,11,       ; Panning bias = 11h / 14h with no phase inversion
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B2,          ; Note D_5
                        B1,          ; Note Db_5
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        E1,0D,       ; Panning bias = Dh / 14h with no phase inversion
                        0C,          ; Note length = Ch tics
                        AA,          ; Note Gb_4
                        A9,          ; Note F_4
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        ED,A0,       ; Static volume with volume multiplier = A0h / 100h
                        EE,78,F5,    ; Dynamic volume over 78h tics with target volume multiplier F5h / 100h
                        E0,19,       ; Select instrument 19h
                        EA,FE,       ; Set transpose of FEh semitones
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        E2,78,11,    ; Dynamic panning over 78h tics with target panning bias 11h / 14h
                        24,          ; Note length = 24h tics
                        9D,          ; Note F_3
                        9E,          ; Note Gb_3
                        18,          ; Note length = 18h tics
                        9F,          ; Note G_3
                        A0,          ; Note Ab_3
                        ED,AA,       ; Static volume with volume multiplier = AAh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        E0,1A,       ; Select instrument 1Ah
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        EA,00,       ; Set transpose of 0 semitones
                        0C,          ; Note length = Ch tics
                        9F,          ; Note G_3
                        A0,          ; Note Ab_3
                        A1,          ; Note A_3
                        A2,          ; Note Bb_3
                        A1,          ; Note A_3
                        A0,          ; Note Ab_3
}

; Tracker 0, track set $5848, track 4 commands
{
$DF:8309/$5B0C       db E0,18,       ; Select instrument 18h
                        EA,00,       ; Set transpose of 0 semitones
                        F4,32,       ; Set subtranspose of 32h / 100h semitones
                        ED,A5,       ; Static volume with volume multiplier = A5h / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        98,          ; Note C_3
                        8C,          ; Note C_2
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        0C,          ; Note length = Ch tics
                        98,          ; Note C_3
                        8C,          ; Note C_2
                        C8,          ; Tie
                        ED,9B,       ; Static volume with volume multiplier = 9Bh / 100h
                        EE,3C,F0,    ; Dynamic volume over 3Ch tics with target volume multiplier F0h / 100h
                        98,          ; Note C_3
                        8C,          ; Note C_2
                        98,          ; Note C_3
                        8C,          ; Note C_2
                        98,          ; Note C_3
                        18,          ; Note length = 18h tics
                        8C,          ; Note C_2
                        0C,          ; Note length = Ch tics
                        98,          ; Note C_3
                        8C,          ; Note C_2
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
}

; Tracker 0, track set $5858, track 0 commands
{
$DF:8330/$5B33       db EF,5C11,01,  ; Repeat subsection $5C11 1 time
                        E0,18,       ; Select instrument 18h
                        F4,32,       ; Set subtranspose of 32h / 100h semitones
                        ED,A5,       ; Static volume with volume multiplier = A5h / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9E,          ; Note Gb_3
                        97,          ; Note B_2
                        98,          ; Note C_3
                        30,          ; Note length = 30h tics
                        8F,          ; Note Eb_2
                        EF,5C1E,04,  ; Repeat subsection $5C1E 4 times
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        ED,A5,       ; Static volume with volume multiplier = A5h / 100h
                        EE,AC,C8,    ; Dynamic volume over ACh tics with target volume multiplier C8h / 100h
                        93,          ; Note G_2
                        95,          ; Note A_2
                        97,          ; Note B_2
                        30,          ; Note length = 30h tics
                        8F,          ; Note Eb_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        93,          ; Note G_2
                        95,          ; Note A_2
                        97,          ; Note B_2
                        30,          ; Note length = 30h tics
                        8F,          ; Note Eb_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        EE,3C,F5,    ; Dynamic volume over 3Ch tics with target volume multiplier F5h / 100h
                        93,          ; Note G_2
                        95,          ; Note A_2
                        97,          ; Note B_2
                        30,          ; Note length = 30h tics
                        8F,          ; Note Eb_2
                        00
}

; Tracker 0, track set $5858, track 1 commands
{
$DF:8369/$5B6C       db E0,1A,       ; Select instrument 1Ah
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EA,00,       ; Set transpose of 0 semitones
                        E1,06,       ; Panning bias = 6 / 14h with no phase inversion
                        60,7F,       ; Note length = 60h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A7,          ; Note Eb_4
                        C8,          ; Tie
                        A8,          ; Note E_4
                        C8,          ; Tie
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,FA,A0,    ; Dynamic volume over FAh tics with target volume multiplier A0h / 100h
                        A9,          ; Note F_4
                        C8,          ; Tie
                        AA,          ; Note Gb_4
                        ED,A0,       ; Static volume with volume multiplier = A0h / 100h
                        EE,28,B4,    ; Dynamic volume over 28h tics with target volume multiplier B4h / 100h
                        3C,          ; Note length = 3Ch tics
                        C8,          ; Tie
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,14,FA,    ; Dynamic volume over 14h tics with target volume multiplier FAh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        E2,24,04,    ; Dynamic panning over 24h tics with target panning bias 4 / 14h
                        0C,          ; Note length = Ch tics
                        AB,          ; Note G_4
                        AC,          ; Note Ab_4
                        AD,          ; Note A_4
}

; Tracker 0, track set $5858, track 2 commands
{
$DF:8396/$5B99       db E0,1A,       ; Select instrument 1Ah
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EA,00,       ; Set transpose of 0 semitones
                        E1,0E,       ; Panning bias = Eh / 14h with no phase inversion
                        60,7F,       ; Note length = 60h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9F,          ; Note G_3
                        C8,          ; Tie
                        A0,          ; Note Ab_3
                        C8,          ; Tie
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,FA,A0,    ; Dynamic volume over FAh tics with target volume multiplier A0h / 100h
                        A1,          ; Note A_3
                        C8,          ; Tie
                        A2,          ; Note Bb_3
                        ED,A0,       ; Static volume with volume multiplier = A0h / 100h
                        EE,28,B4,    ; Dynamic volume over 28h tics with target volume multiplier B4h / 100h
                        3C,          ; Note length = 3Ch tics
                        C8,          ; Tie
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,14,FA,    ; Dynamic volume over 14h tics with target volume multiplier FAh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        E2,24,10,    ; Dynamic panning over 24h tics with target panning bias 10h / 14h
                        0C,          ; Note length = Ch tics
                        A3,          ; Note B_3
                        A4,          ; Note C_4
                        A5,          ; Note Db_4
}

; Tracker 0, track set $5858, track 3 commands
{
$DF:83C3/$5BC6       db E0,19,       ; Select instrument 19h
                        EA,FE,       ; Set transpose of FEh semitones
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        24,7F,       ; Note length = 24h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        93,          ; Note G_2
                        93,          ; Note G_2
                        18,          ; Note length = 18h tics
                        93,          ; Note G_2
                        EF,5C26,07,  ; Repeat subsection $5C26 7 times
}

; Tracker 0, track set $5858, track 4 commands
{
$DF:83D7/$5BDA       db E0,1B,       ; Select instrument 1Bh
                        F4,28,       ; Set subtranspose of 28h / 100h semitones
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        EA,00,       ; Set transpose of 0 semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9E,          ; Note Gb_3
                        97,          ; Note B_2
                        98,          ; Note C_3
                        30,          ; Note length = 30h tics
                        8F,          ; Note Eb_2
                        EF,5C1E,04,  ; Repeat subsection $5C1E 4 times
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        EE,AC,DC,    ; Dynamic volume over ACh tics with target volume multiplier DCh / 100h
                        93,          ; Note G_2
                        95,          ; Note A_2
                        97,          ; Note B_2
                        30,          ; Note length = 30h tics
                        8F,          ; Note Eb_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        93,          ; Note G_2
                        95,          ; Note A_2
                        97,          ; Note B_2
                        30,          ; Note length = 30h tics
                        8F,          ; Note Eb_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        EE,3C,FA,    ; Dynamic volume over 3Ch tics with target volume multiplier FAh / 100h
                        93,          ; Note G_2
                        95,          ; Note A_2
                        97,          ; Note B_2
                        30,          ; Note length = 30h tics
                        8F,          ; Note Eb_2
                        00
}

; Repeated subsection
{
$DF:840E/$5C11       db E7,23,       ; Music tempo = 68.359375 tics per second
                        E5,C8,       ; Music volume multiplier = C8h / 100h
                        F5,0E,32,32, ; Static echo on voices 1/2/3 with echo volume left = 32h and echo volume right = 32h
                        F7,02,3C,00, ; Set echo parameters: echo delay = 2, echo feedback volume = 3Ch, echo FIR filter index = 0
                        00
}

; Repeated subsection
{
$DF:841B/$5C1E       db 0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        93,          ; Note G_2
                        95,          ; Note A_2
                        97,          ; Note B_2
                        30,          ; Note length = 30h tics
                        8F,          ; Note Eb_2
                        00
}

; Repeated subsection
{
$DF:8423/$5C26       db 24,          ; Note length = 24h tics
                        93,          ; Note G_2
                        93,          ; Note G_2
                        18,          ; Note length = 18h tics
                        93,          ; Note G_2
                        00
}

; Tracker 1 commands
$DF:8429/$5C2C       dw 5C3A,
                        5C3A,
                        5C4A,
                        5C4A,
                        00FF,5C2C,
                        0000

; Track pointers
$DF:8437/$5C3A       dw 5C5A, 5C70, 5C7C, 0000, 0000, 0000, 0000, 0000
$DF:8447/$5C4A       dw 5C80, 5C94, 5CA0, 5CA4, 5CB0, 0000, 0000, 0000

; Tracker 1, track set $5C3A, track 0 commands
{
$DF:8457/$5C5A       db FA,25,       ; Percussion instruments base index = 25h
                        E7,19,       ; Music tempo = 48.828125 tics per second
                        E5,C8,       ; Music volume multiplier = C8h / 100h
                        F5,01,0A,0A, ; Static echo on voices 0 with echo volume left = Ah and echo volume right = Ah
                        F7,02,0A,0A, ; Set echo parameters: echo delay = 2, echo feedback volume = Ah, echo FIR filter index = Ah
                        EF,5CBD,01,  ; Repeat subsection $5CBD 1 time
                        C8,          ; Tie
                        9A,          ; Note D_3
                        C8,          ; Tie
                        00
}

; Tracker 1, track set $5C3A, track 1 commands
{
$DF:846D/$5C70       db E0,1A,       ; Select instrument 1Ah
                        EA,00,       ; Set transpose of 0 semitones
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        EF,5CCB,01,  ; Repeat subsection $5CCB 1 time
}

; Tracker 1, track set $5C3A, track 2 commands
{
$DF:8479/$5C7C       db EF,5CE6,01,  ; Repeat subsection $5CE6 1 time
}

; Tracker 1, track set $5C4A, track 0 commands
{
$DF:847D/$5C80       db E7,19,       ; Music tempo = 48.828125 tics per second
                        E5,C8,       ; Music volume multiplier = C8h / 100h
                        F5,01,0A,0A, ; Static echo on voices 0 with echo volume left = Ah and echo volume right = Ah
                        F7,02,0A,00, ; Set echo parameters: echo delay = 2, echo feedback volume = Ah, echo FIR filter index = 0
                        EF,5CBD,01,  ; Repeat subsection $5CBD 1 time
                        C8,          ; Tie
                        9A,          ; Note D_3
                        C8,          ; Tie
                        00
}

; Tracker 1, track set $5C4A, track 1 commands
{
$DF:8491/$5C94       db E0,1A,       ; Select instrument 1Ah
                        EA,00,       ; Set transpose of 0 semitones
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        EF,5CCB,01,  ; Repeat subsection $5CCB 1 time
}

; Tracker 1, track set $5C4A, track 2 commands
{
$DF:849D/$5CA0       db EF,5CE6,01,  ; Repeat subsection $5CE6 1 time
}

; Tracker 1, track set $5C4A, track 3 commands
{
$DF:84A1/$5CA4       db E0,1A,       ; Select instrument 1Ah
                        EA,0C,       ; Set transpose of Ch semitones
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        EF,5CCB,01,  ; Repeat subsection $5CCB 1 time
}

; Tracker 1, track set $5C4A, track 4 commands
{
$DF:84AD/$5CB0       db E0,1A,       ; Select instrument 1Ah
                        EA,06,       ; Set transpose of 6 semitones
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        EF,5CCB,01,  ; Repeat subsection $5CCB 1 time
                        00
}

; Repeated subsection
{
$DF:84BA/$5CBD       db E0,1A,       ; Select instrument 1Ah
                        EA,00,       ; Set transpose of 0 semitones
                        F4,50,       ; Set subtranspose of 50h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,8C,       ; Static volume with volume multiplier = 8Ch / 100h
                        60,7F,       ; Note length = 60h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        99,          ; Note Db_3
                        00
}

; Repeated subsection
{
$DF:84C8/$5CCB       db ED,38,       ; Static volume with volume multiplier = 38h / 100h
                        EE,60,82,    ; Dynamic volume over 60h tics with target volume multiplier 82h / 100h
                        60,7F,       ; Note length = 60h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A9,          ; Note F_4
                        ED,82,       ; Static volume with volume multiplier = 82h / 100h
                        EE,18,32,    ; Dynamic volume over 18h tics with target volume multiplier 32h / 100h
                        C8,          ; Tie
                        ED,38,       ; Static volume with volume multiplier = 38h / 100h
                        EE,60,82,    ; Dynamic volume over 60h tics with target volume multiplier 82h / 100h
                        AA,          ; Note Gb_4
                        ED,82,       ; Static volume with volume multiplier = 82h / 100h
                        EE,18,32,    ; Dynamic volume over 18h tics with target volume multiplier 32h / 100h
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:84E3/$5CE6       db E0,1C,       ; Select instrument 1Ch
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        EA,FA,       ; Set transpose of FAh semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        EE,60,D2,    ; Dynamic volume over 60h tics with target volume multiplier D2h / 100h
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        93,          ; Note G_2
                        94,          ; Note Ab_2
                        95,          ; Note A_2
                        93,          ; Note G_2
                        94,          ; Note Ab_2
                        95,          ; Note A_2
                        93,          ; Note G_2
                        06,          ; Note length = 6 tics
                        94,          ; Note Ab_2
                        94,          ; Note Ab_2
                        60,          ; Note length = 60h tics
                        C9,          ; Rest
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        EE,28,D2,    ; Dynamic volume over 28h tics with target volume multiplier D2h / 100h
                        0C,          ; Note length = Ch tics
                        94,          ; Note Ab_2
                        95,          ; Note A_2
                        96,          ; Note Bb_2
                        06,          ; Note length = 6 tics
                        94,          ; Note Ab_2
                        94,          ; Note Ab_2
                        30,          ; Note length = 30h tics
                        C9,          ; Rest
                        60,          ; Note length = 60h tics
                        C9,          ; Rest
                        00
}
}

; EOF
$DF:850F             dw 0000, 1500
}


;;; $8513: Unused. Upper Crateria / Samus theme - higher pitched version ;;;
{
; Sample table
$DF:8513             dw 0040, 6D60,
                        B516,BA9B, C326,C353, D49F,DDE7, DDE7,E6CC, DDE7,E6CC, DDE7,E6CC, DDE7,E6CC, DDE7,E6CC
                        DDE7,E6CC, DDE7,E6CC, DDE7,E6CC, DDE7,E6CC, DDE7,E6CC, E6CC,F45E, FFFF,FFFF, FFFF,FFFF

; Sample data
$DF:8557             dw 3F4A, B516
$DF:855B             db 02,00,00,00,00,00,00,00,00, 4A,E3,60,0E,C3,2E,32,35,01, 5A,11,10,0F,EF,DE,EB,CD,CE, 5A,12,34,66,11,0F,DD,DF,0F, 4A,E2,33,54,66,34,22,40,CF, 6A,FE,FE,DE,EE,DE,F3,43,43, 5A,51,DD,DC,EE,D0,10,31,44, 5A,25,32,10,F1,ED,EF,C9,BB, 6A,DE,DF,13,55,31,1F,EF,EE, 5A,C0,01,23,33,44,33,22,00, 5A,0F,ED,ED,DC,AC,DC,CE,13, 6A,23,32,11,FD,EF,F0,F1,21, 5A,33,44,42,00,10,0F,00,EC, 6A,FF,FD,DE,ED,CF,12,45,52, 5A,01,DC,BD,20,01,22,23,42, 5A,12,21,F1,11,FE,EE,EE,AA, 7A,FE,DD,F2,23,33,11,0F,EE, 5A,BE,21,10,14,34,52,22,00, 6A,01,10,FF,FF,EF,FD,ED,CD, 6A,DE,03,75,44,0F,FE,DC,F3, 5A,30,21,35,22,12,10,01,12, 7A,00,00,F0,0F,EE,ED,DD,F1, 7A,34,32,11,1F,EE,01,0F,00, 5A,43,21,22,21,12,54,13,1F, 7A,0F,FF,0F,FD,EE,DD,EE,04, 7A,74,32,1E,EF,0F,F0,F0,01, 5A,43,24,13,44,23,33,0F,ED, 8A,0F,F0,0F,FF,FF,EC,E1,65, 7A,52,0E,00,ED,EF,F0,00,12, 5A,63,43,66,11,10,12,0D,AD, 9A,00,F0,00,FF,FF,FF,23,20, 7A,F2,4E,DC,E0,FF,01,21,01, 5A,66,43,3F,04,1E,DF,FC,BF, 9A,00,0F,FF,FE,F2,31,01,10, 6A,CC,FA,D0,EF,12,22,22,22, 5A,32,F0,76,0D,FF,DC,DA,CB, 8A,FE,FE,DE,45,1F,13,1F,F0, 5A,99,BF,13,22,34,33,30,14, 7A,10,11,0F,FF,FF,FE,EE,DC, 8A,DF,55,1E,01,20,FE,01,FF, 6A,14,20,22,02,20,F1,32,10, 7A,00,0F,EE,FD,DD,DD,13,75, 6A,1C,C3,40,ED,C0,10,11,32, 5A,10,43,33,EE,66,1E,CE,1D, 8A,F0,0F,EE,DD,04,53,0F,E0, 6A,53,DD,EF,FF,11,33,10,21, 6A,21,00,23,20,FC,FF,BC,0C, 8A,FF,ED,F3,43,10,EE,12,1F, 5A,9C,CB,14,66,31,14,30,21, 7A,11,20,FF,FF,EF,FE,EE,CA, 8A,E1,44,20,FE,02,2F,F0,0F, 6A,D0,13,32,01,22,2F,F3,50, 8A,00,0F,FF,00,FE,EF,DD,16, 8A,41,0F,E1,30,FF,00,F0,01, 6A,00,03,23,30,E0,44,0F,0F, 8A,0F,F0,0F,EF,EE,DE,16,50, 8A,E0,32,F0,EF,00,F0,10,00, 6A,31,33,2F,15,2F,00,EE,DF, 8A,0F,FF,FE,EE,EF,56,0D,24, 7A,4C,EE,EE,00,F0,21,01,01, 5A,44,36,62,EE,D0,DB,FF,BA, 8A,0E,DF,0E,D0,64,E2,41,FF, 6A,E9,C1,FF,10,02,21,10,25, 7A,30,F0,00,0F,F0,FE,E0,CA, 8A,01,FC,F5,30,33,1F,EF,F0, 6A,1E,E2,E1,21,11,13,64,FD, 7A,10,FF,F1,1F,DD,DC,E1,2E, 7A,BE,35,75,11,1E,DE,00,F0, 6A,1E,12,10,11,55,2E,F1,0F, 7A,FF,00,0D,EB,CE,21,DB,15, 8A,34,20,0F,FF,F0,00,00,00, 6A,10,22,45,40,E0,10,DB,F2, 8A,0F,FE,EF,0E,E0,42,F3,41, 6A,EF,DA,AF,00,10,F1,30,02, 6A,54,42,F0,0F,DD,DF,DF,FD, 8A,EE,0F,FD,13,11,53,0F,FF, 6A,BD,0F,11,FE,42,01,33,55, 7A,0F,00,0F,EE,FF,FF,DC,EF, 8A,FE,03,1F,35,2F,FF,FF,00, 6A,01,0D,02,21,23,54,2F,10, 7A,F0,FF,EE,EE,FF,DD,FF,DE, 8A,20,16,30,00,EE,F1,00,00, 6A,E2,F1,45,23,41,F0,FF,0F, 7A,FF,ED,E0,EB,F0,EA,14,07, 8A,61,F0,0F,EF,00,10,F0,10, 6A,F5,64,21,F1,0E,10,EF,DC, 8A,E0,0E,E0,0E,CF,33,64,0F, 6A,0B,B9,11,E0,0E,01,16,63, 6A,23,1E,00,F1,EE,FE,BA,DE, 9A,F0,00,FE,E1,43,10,00,FF, 7A,D0,10,0E,01,01,43,02,2F, 6A,D1,10,ED,EF,EB,CF,BA,E5, 9A,0E,DE,35,30,F0,0F,F0,00, 7A,1F,EF,11,34,10,11,F1,00, 8A,00,FF,F0,FF,FF,F0,1F,CB, 9A,E4,62,FF,00,FF,00,00,00, 7A,00,14,30,02,0F,01,0F,FF, 9A,0F,00,0E,F0,11,FD,C1,65, 7A,EB,E2,EC,E0,11,FE,F1,23, 6A,61,02,2E,F1,21,DD,FE,CC, 9A,00,FF,F1,1E,CE,46,20,FF, 7A,00,CD,12,1D,EF,24,42,F1, 7A,10,F0,01,0F,FF,EE,F0,DC, 9A,00,0F,ED,06,41,FF,00,FF, 7A,12,1E,DF,13,44,0F,12,EF, 6A,23,0D,E0,DB,B0,EA,AE,34, 9A,FC,D3,72,F0,00,FF,F1,10, 7A,AC,13,45,2E,02,1E,01,11, 9A,F0,00,FF,00,FF,01,0E,CE, 9A,56,2F,F0,0F,FF,11,FF,01, 7A,04,32,F1,2F,E1,11,FF,0F, AA,0F,00,0F,00,10,ED,04,30, 7A,BB,1E,CD,F2,2E,CF,35,41, 7A,F0,21,E0,11,1F,E0,0E,BE, A6,FF,FF,F0,0E,BD,24,44,43, 7A,CC,2F,20,CD,24,43,1F,02, 6A,0E,11,21,DD,0E,A9,FF,CC, AA,00,0F,FE,14,2F,F0,10,FF, 7A,04,1B,E4,54,2F,E1,3F,F1, 7A,11,FE,01,EB,E1,ED,F0,20, AA,FE,F2,31,00,F0,00,F0,00, 7A,E4,22,41,E0,21,E0,11,1F, 8A,F0,0F,E0,0F,EF,11,EB,AF, 9A,46,2E,F0,1F,FF,00,00,01, 7A,34,0F,02,FE,03,1F,E0,0F, 9A,F0,00,FF,00,0F,EE,04,52, 7A,9C,D0,FE,EF,0F,03,34,2F, 6A,E3,3C,D2,42,DD,0F,BB,31, 9A,FF,00,0F,EE,02,43,0F,00, 7A,DC,FF,E0,02,34,21,F0,10, 6A,EF,23,1D,DF,EB,E3,F9,9C, 9A,00,FE,E0,35,3F,E0,0F,F0, 7A,0F,10,23,32,00,01,0E,01, 7A,20,E0,FE,D0,1F,DD,F0,E9, 9A,DF,25,40,FF,0F,00,0F,F1, 7A,13,24,00,01,0F,F1,12,FF, 8A,0F,EF,11,EE,F1,FE,CB,E6, 9A,54,FF,00,FF,F0,01,F0,12, 7A,1E,F1,11,FF,02,1F,00,EB, 9A,00,0F,0F,00,0D,D0,45,2F, 7A,E0,DE,DE,F0,21,02,42,0F, 7A,10,00,00,21,F0,FD,CF,10, 9A,F0,00,FE,DF,33,32,F0,F0, 7A,DD,D0,22,01,22,12,0F,01, 7A,0F,12,00,0E,CD,01,FE,DF, 8A,0E,CC,23,27,5F,FE,FF,FF, 6A,02,51,15,41,10,01,10,F2, 8A,00,10,EE,F1,0F,FF,FF,EC, 8A,F4,2E,67,0E,EF,FE,01,11, 6A,F0,53,11,F0,11,00,31,01, 8A,FE,F0,00,0E,E0,FC,D3,5E, 9A,F4,3F,FF,00,0F,00,10,10, 7A,00,2F,01,0F,11,01,0C,C0, 9A,10,FF,0F,0F,E0,31,D0,52, 7A,AE,EE,F0,0E,23,00,21,10, 7A,F0,11,F0,11,1E,BD,23,FE, 9A,FF,00,EE,13,0E,15,1E,F0
$DF:8AE0             db 6A,1C,F0,D5,5E,33,22,1E,F1, 7A,1F,21,0F,DC,F2,2F,ED,DD, 9A,FE,F3,3E,D3,50,EF,00,00, 7A,FE,41,01,21,1F,0F,10,02, 8A,00,FF,E0,11,FF,EF,FD,B0, 9A,32,EF,43,FE,00,00,0F,01, 6A,40,40,31,FE,F1,22,20,FD, 9A,FF,11,FF,00,FF,EE,14,0D, 9A,15,2E,FF,00,10,F0,10,00, 7A,21,2F,F0,20,01,1F,CC,E3, 9A,10,FF,F0,FE,E2,3F,E3,40, 8A,DF,F0,00,F1,10,F1,10,10, 7A,FE,32,1F,F1,FD,CF,32,FE, 9A,FF,0F,DF,42,DE,54,FE,00, 6A,2E,DD,36,EC,44,23,FD,16, 7A,20,E0,1E,CD,13,1F,DB,ED, 9A,EE,24,0C,E5,5F,EF,10,0F, 6A,F5,7B,E4,13,4E,D5,31,FE, 8A,00,FE,F2,2F,EE,FF,DC,F6, 9A,3F,CF,54,FE,00,00,00,01, 7A,DF,02,22,EF,32,0E,01,0C, 96,EE,F0,00,FE,DD,CD,14,2E, 9A,06,3E,F0,1F,0F,01,1F,00, 7A,22,1C,24,0F,F0,0E,CE,44, 9A,0F,FF,FF,F0,13,1D,C2,61, 8A,CF,11,FE,00,20,F0,11,1F, 7A,E2,30,FF,0F,EC,15,2E,DD, 9A,FF,EF,13,2F,CE,45,FF,00, 7A,F0,FD,14,1E,F2,31,EF,22, 8A,0F,00,FE,F2,21,EF,FE,CC, 9A,01,32,EC,F5,4F,F0,00,F0, 6A,E6,4E,B3,65,FD,04,30,CE, 8A,0E,F0,31,0E,FE,EC,D0,46, 9A,0D,D2,52,FF,00,0F,00,10, 7A,CF,34,3E,E2,21,FE,FF,DD, 9A,11,00,0F,EF,FE,03,3F,CE, 9A,45,0F,F0,00,F0,11,FF,01, 7A,23,F0,12,0F,EF,EC,F5,40, 9A,0F,FF,FE,E1,42,EC,F5,40, 7A,9E,01,EE,F4,3C,D2,32,1F, 7A,03,20,DE,FE,D1,52,FE,ED, 9A,FE,EF,33,1D,C0,63,FF,00, 7A,ED,01,41,CE,22,21,F0,32, 7A,0E,DE,EF,34,1E,DE,D9,9C, 9A,12,30,CB,27,3E,F0,0F,00, 7A,23,0C,F2,12,10,12,00,ED, 8A,FF,12,20,EE,FE,DC,F3,73, 9A,EC,D3,62,FF,F0,00,00,00, 6A,2F,12,41,E2,51,DB,CC,F5, 9A,10,00,FF,EF,E1,23,0E,CE, 9A,45,1F,F0,0F,01,00,00,F0, 7A,54,EE,22,0E,DD,F2,42,2F, 9A,FF,FF,EF,22,2F,EC,F5,50, 7A,AD,0F,F0,02,2F,D1,22,0F, 7A,02,2F,DC,E1,42,21,EC,DC, 9A,EE,03,21,FD,C1,63,FF,00, 6A,DC,00,54,BB,36,4F,E1,41, 8A,FF,EF,12,11,0F,EE,DC,E3, 9A,31,0E,DD,36,2E,F0,00,00, 7A,F3,0C,F3,32,FF,12,0D,DD, 8A,01,21,1F,FE,ED,CF,45,1F, 9A,ED,E4,51,F0,F0,F1,00,00, 7A,DF,33,10,01,10,DD,D0,44, 9A,00,00,FF,DE,03,21,FE,CF, 9A,55,0F,F0,00,00,00,0F,00, 7A,53,1F,11,FD,BD,26,30,0F, 9A,FF,FE,E1,32,0F,DC,16,30, 7A,BE,D1,01,03,0C,D1,12,31, 7A,01,1F,DB,E4,42,1F,EC,DA, 9A,EF,13,10,FE,C1,63,FF,00, 7A,DF,12,2F,CE,11,33,10,10, 8A,FE,E0,32,0F,0F,EE,DC,05, 9A,20,0F,DC,36,2F,F0,F0,01, 7A,11,DC,F1,13,31,00,0E,BC, 8A,23,1F,00,EE,EC,C3,73,EF, 9A,FC,D4,61,FF,00,00,00,00, 7A,DE,03,32,01,1E,CC,F5,51, 9A,00,FF,FF,D0,23,10,FE,CE, 9A,46,1F,F0,00,00,00,F0,00, 7A,25,2E,01,EC,C2,53,00,1E, 9A,FF,ED,04,30,E0,EC,F5,50, 7A,CD,00,01,F0,1E,C0,24,40, 8A,F0,0E,E0,22,00,01,FD,DC, 9A,F1,32,0E,FE,D0,54,0F,F0, 6A,25,0A,01,CB,06,75,0D,1D, 8A,EE,03,20,F1,0E,DD,C0,45, 9A,1F,FF,DD,36,1F,00,F0,10, 7A,C1,0D,F2,33,1F,00,CC,03, 8A,21,00,0F,EE,CC,16,40,FE, 9A,EC,F5,51,FF,F0,01,00,0F, 7A,C2,33,20,00,EB,E2,43,10, 9A,00,FF,FE,E1,42,FF,FD,C2, 9A,63,F0,F0,00,00,00,F0,01, 7A,22,F0,FD,C0,43,11,11,FC, 9A,FE,EF,23,10,FE,CE,46,1F, 7A,DF,E0,20,F0,FE,00,15,1E, 8A,00,EF,11,11,10,0F,DD,DC, 9A,03,30,FF,EC,06,4F,F0,00, 6A,D1,F4,FA,C1,27,6F,DF,EA, 8A,01,21,0F,01,ED,DD,D3,63, 9A,0F,FC,D2,72,FF,00,00,00, 7A,0D,E0,01,42,F0,FD,F3,21, 8A,10,00,FD,DE,DF,56,1E,EC, 9A,CE,65,0F,00,0F,00,10,FF, 6A,04,57,FC,FF,D3,62,12,0F, 96,11,FD,CC,D0,22,21,EA,D4, 8A,5D,F1,0E,F1,00,0F,F0,02, 7A,3F,E0,0F,13,10,00,00,DA, 9A,EE,F3,31,FF,ED,E4,51,F0, 6A,0E,93,00,0D,BE,17,61,BD, 8A,00,12,0F,00,00,0E,DD,C0, 9A,33,0F,EE,D0,54,1F,FF,00, 6A,3F,20,BC,22,45,0B,C1,34, 8A,10,00,F0,1F,DD,DD,26,40, 9A,FE,DD,35,20,0F,F0,01,00, 6A,99,F6,43,2D,BE,45,41,F0, 8A,00,00,ED,DD,E4,63,ED,CA, 9A,F4,51,FF,00,F0,01,0F,F1, 6A,50,32,BA,27,41,E1,2D,12, 9A,0F,EE,E1,32,00,ED,D2,53, 6A,EC,BE,AF,21,1F,BE,33,43, 7A,FD,F3,31,F0,10,E1,1E,AA, 9A,EF,13,20,EE,DF,45,00,F0, 6A,BF,D2,21,DB,13,24,1B,B4, 8A,21,00,00,F0,1F,ED,EC,F5, 9A,30,FF,EC,16,3F,00,0F,F0, 7A,22,FD,F2,21,1F,DF,54,0F, 8A,F1,0F,01,FD,DE,D1,54,0E, 9A,ED,E4,51,F0,0F,F0,10,00, 7A,DF,12,20,DE,35,10,FF,1F, 8A,00,0E,ED,DE,35,3F,DB,A1, 9A,53,00,0F,F0,10,0F,F0,10, 7A,23,EC,06,30,FF,00,E0,2F, 9A,FF,EE,03,20,FF,DD,36,2F, 6A,9F,DA,E1,13,EA,04,22,0B, 7A,F4,51,FF,F1,FE,11,EA,BA, 9A,F1,22,0F,DD,05,30,00,0F, 7A,E0,10,1D,E2,10,1F,E2,63, 8A,F0,00,FF,01,0E,DE,DE,35, 9A,10,ED,D3,52,00,FF,00,0F, 7A,21,FF,11,10,D0,55,0F,0F, 8A,0F,F1,1F,DD,ED,14,40,EC, 9A,DF,54,0F,00,0F,00,00,0F, 7A,03,2F,FF,36,2E,F0,00,D0, 96,00,FE,DC,CE,01,10,EC,F4, 8A,40,FF,FF,F0,01,0F,F1,01, 7A,FE,16,4F,F0,F0,FE,11,EC, 9A,FF,E0,22,0F,ED,F5,41,F0, 7A,DE,C0,01,2F,D0,20,0F,04, 7A,61,EF,00,0D,02,0C,BD,BB, 9A,12,10,FD,D2,52,00,00,FF, 7A,F0,21,EE,11,00,02,54,FE, 8A,0F,00,00,0F,EF,EC,F3,42, 9A,FE,DF,44,10,0F,FF,01,00, 7A,EF,F2,0F,02,44,1E,0F,F0, 8A,00,0F,FE,FD,E0,43,0D,BB, 9A,15,30,0F,0F,0F,00,10,F0, 7A,11,F1,34,3F,F0,FF,0E,01, 9A,0F,FF,FF,11,10,FD,E4,51, 7A,AE,0F,CF,01,20,DF,10,F1, 7A,34,41,EF,FF,1F,E0,1E,CE, 9A,FE,02,10,FF,D0,53,00,0F, 7A,BF,00,12,EE,00,F2,33,32, 7A,FE,00,0F,E0,1F,DD,DA,C2, 9A,21,FF,EE,35,1F,00,FF,00, 7A,12,0D,F0,00,33,32,1E,00, 7A,F0,FF,00,ED,DD,AE,37,2C, 9A,EE,05,30,F0,0F,F0,01,00, 7A,B0,F1,24,32,2F,E0,00,0E, 8A,00,0E,FF,ED,02,20,EC,C5, 9A,52,FF,00,FF,01,00,F0,00, 7A,13,42,20,FF,0F,1F,F0,0E, 9A,F0,FF,F1,10,FE,F0,43,10, 7A,DC,ED,00,11,FD,00,03,52, 6A,23,0C,F0,10,DE,1F,BA,C9, 9A,F0,11,FE,EF,35,2F,F0,0F, 7A,D0,11,0E,E0,02,43,22,1E, 7A,E1,00,FF,00,FD,DE,CC,06, 9A,1F,ED,04,50,F0,1F,E0,00, 7A,21,CE,11,44,10,31,EF,00, 8A,0F,00,0F,FE,FE,F0,31,EA, 9A,D2,63,FF,00,FF,01,00,F0, 7A,D0,37,2F,13,FE,00,00,FF, 9A,00,FF,00,FF,02,0E,CF,55, 7A,3C,F0,EC,D0,22,FC,E1,24, 7A,41,02,1E,E1,10,EF,00,FD, 9A,0F,FF,01,1F,DD,26,3F,00, 7A,EA,D0,12,1D,DF,23,53,00, 7A,10,E0,01,0F,FF,FE,FF,CB, 9A,00,10,ED,F4,51,F0,00,FF, 7A,D3,3E,CE,13,54,1F,11,FF, 7A,00,1F,FF,0E,EF,EC,C0,34, 9A,FD,D1,64,0F,F0,0F,F0,10, 7A,EC,02,45,2F,02,1D,01,10, 9A,0F,00,0F,0F,FF,01,1F,CD, 9A,46,2F,00,FF,00,F0,10,FF, 7A,46,50,F1,2F,E1,11,FE,F0, 9A,0F,F0,0F,F1,10,DC,F6,51, 7A,DC,FF,DD,01,2E,CE,35,52, 7A,FF,21,EF,12,1E,E0,0F,CD, AA,00,F0,10,FF,E0,42,0F,00, 7A,0A,E0,20,CD,24,44,1E,03, 6A,FC,12,20,CE,1F,A9,EE,BB, AA,00,1F,EE,24,1F,F0,10,F0, 7A,F0,DF,E3,54,3F,E1,3F,E1, 7A,11,FF,00,DD,F0,DD,E0,40, 9A,EC,E4,72,EF,01,FF,F0,10, 7A,AF,55,31,F0,11,E0,12,0F, 8A,F0,0F,E0,0F,EF,01,FC,AF, 9A,45,2F,FF,00,0F,00,0F,01, 7A,54,0F,11,FE,11,2F,EF,1F, 9A,F0,00,FF,F1,0F,DF,14,41, 7A,BD,FF,FD,EF,0F,04,33,20, 6A,E2,2D,D2,32,DE,0F,BC,11, 9A,FF,00,0F,EE,02,53,FF,00, 7A,CE,EF,F0,01,44,20,F0,21, 6A,CD,34,0C,E0,EB,D2,FA,9C, 9A,00,FE,E0,35,3F,E0,0F,F0, 7A,0F,00,24,42,FF,01,0F,01, 7A,20,EF,0D,D0,3E,CD,F0,F9, 9A,DF,25,40,E0,00,FF,00,00, 7A,02,44,00,00,1F,F0,22,FE, 8A,00,EE,11,FE,F0,FF,CA,E7, 9A,53,0F,0F,FF,00,00,00,11, 7A,3E,F1,20,FF,02,2E,F1,EC, 9A,F1,0F,F0,00,FD,D1,45,2F, 7A,CF,EF,CE,F1,11,03,32,00, 7A,00,01,0F,11,00,FD,CF,10, 9A,F0,00,FE,DF,23,42,F0,0F, 7A,BC,F1,22,F0,33,11,0F,01, 7A,1F,02,00,0E,CD,11,ED,EF, 8A,0E,DC,13,27,5F,FE,FF,FF, 6A,04,50,05,42,10,F1,10,F2, 8A,10,0F,EF,00,0F,FE,00,EB, 8A,E5,2E,67,0E,EF,FE,01,11, 6A,0F,43,21,F0,21,FF,32,01, 8A,FE,F0,00,0E,E0,FC,D3,5E, 9A,F4,3F,FF,00,0F,00,10,10, 7A,00,2F,01,0F,11,01,0C,C0, 9A,10,FF,0F,0F,E0,31,D0,52, 7A,AE,EE,F0,0E,23,00,21,10, 7A,F0,11,F0,11,1E,BD,23,FE, 9B,FF,00,EE,13,0E,15,1E,F0
$DF:936B             db 02,00,00,00,00,00,00,00,00, 9A,24,2E,13,CA,13,FA,D0,14, 9A,3E,F2,EF,2F,16,0C,DF,00, 96,01,21,02,1C,C1,43,13,2B, 9A,E3,1C,BE,13,41,D1,1D,01
$DF:9398             db 9A,F5,5C,CF,FF,02,31,F1,1C, 9A,E6,41,E0,2D,B0,20,CB,F3, AA,21,FF,10,F1,F0,41,DF,0F, 96,FF,01,33,3F,AD,34,21,31, 9A,AE,21,EC,B3,42,0E,02,EF, 9A,1E,57,CA,00,E1,2F,23,1F, 9A,CE,65,0E,11,CC,01,0E,BE, 9A,53,00,E1,1D,10,07,2A,E1, 96,20,1F,E3,53,FB,D3,53,11, 9A,FC,E1,0F,DC,25,0F,0F,2F, 9A,E2,F3,5E,C0,0D,11,E3,51, 9A,DD,F5,41,FF,0E,EE,0F,FD, 9A,E5,2E,00,01,E1,1F,43,DE, 96,52,11,ED,36,3E,CF,24,41, 9A,F0,ED,F0,0E,D1,5F,F0,F1, 9A,1E,11,13,FF,0E,E2,FD,36, 9A,2C,D2,41,30,DF,0D,E0,FF, 8A,DD,66,CF,FE,40,E3,13,2E, 9A,0F,E1,0C,16,4E,C0,41,23, 9A,DD,2F,CF,0E,FF,13,0E,1F, 8A,F3,F1,32,0F,11,BF,4A,B7, 9A,52,DD,42,03,1C,01,CE,FF, 8A,D1,04,2C,F1,E1,20,24,FD, 9A,03,FD,10,C1,43,1D,04,01, 9A,3E,D2,EC,F0,EF,12,1F,E0, 8A,0F,32,04,1A,F6,3B,F3,9B, 8A,67,5F,D5,3E,62,AF,1A,BE, 8A,ED,05,3D,EF,0F,05,00,6D, 9A,C2,30,E1,FC,13,22,00,2F, 9A,13,FE,0E,EF,EF,F1,30,EF, 9A,F1,F1,3F,22,BE,41,F1,0D, 8A,C4,43,41,20,15,FC,2E,9D, 9A,FF,FF,32,EF,FF,00,41,E3, 9A,FB,23,F2,1D,D0,21,23,1F, 9A,03,0E,10,CE,0E,FF,24,ED, 9A,0F,1E,14,01,2B,D4,11,3D, 9A,C0,21,02,31,F2,2D,F2,FC, 9A,FE,F0,F3,3D,EF,00,F3,3E, 9A,3F,B1,3F,31,CE,12,00,34, 9A,FF,30,D0,1E,EF,D0,F1,40, 9A,DE,F1,F1,41,F2,CD,31,13, 9A,FC,F2,2F,04,3F,02,0E,FF, 9A,E0,EE,0F,33,DE,E1,0E,34, 8A,E2,F9,F2,16,3C,CF,32,E4, 9A,41,F1,10,EF,EF,FE,F0,14, 9A,FD,FE,00,15,1E,0F,E0,03, 9A,20,FE,F3,0F,42,00,11,0D, 8A,DF,EB,D1,F5,3D,CC,F1,D6, 9A,40,FF,FF,F2,30,0F,E1,2E, 9A,24,10,00,2E,D0,0E,DF,01, 9A,4F,EE,E1,F0,52,FF,F0,E0, 8A,62,E3,EE,40,E5,41,30,31, 9A,CD,10,ED,01,21,EF,EF,0F, 9A,34,1E,E0,0E,23,E1,1F,11, 9A,E0,31,21,02,EB,F2,FD,E0, 9A,23,FE,EE,00,04,30,DE,3E, 9A,E4,0F,20,F2,0F,21,01,13, 9A,1B,D0,0F,EF,02,1F,FE,E0, 9A,02,32,FD,11,C2,3D,13,F1, 9A,1E,12,00,13,2D,C0,F0,FD, 8A,F5,3E,EE,DD,E4,52,3D,B5, 9A,FE,30,E3,00,3F,F2,1F,F1, 9A,61,AF,0D,00,D1,20,F0,EE, 8A,E2,52,22,BF,4C,04,C2,4E, 9A,32,D0,21,FE,36,DC,1D,E2, 8A,CA,65,BD,0D,EF,34,02,0D, 9A,10,F1,0F,20,04,0F,11,0D, 9A,F7,2B,F1,CF,2D,F3,1D,0F, 8A,C1,02,30,10,E1,11,EE,33, 9A,F2,3F,F2,2E,B3,6F,D1,ED, 8A,00,A4,6B,B2,DE,2F,22,02, 8A,0D,14,EC,24,FF,66,DE,45, 9A,CC,53,E0,0D,E0,FF,31,CF, 8A,1C,22,F1,00,30,C3,5A,E6, 9A,0F,14,0F,04,0A,F5,00,1D, 9A,E0,FE,13,ED,1F,E3,0F,00, 9A,02,FF,40,B2,3F,E3,30,F2, 9A,3E,A1,20,40,BF,0D,03,1C, 9A,F1,E0,3F,FF,02,2D,14,DD, 9A,41,D0,43,FF,33,BB,30,14, 9A,EC,0E,F3,1D,D1,0F,22,ED, 9A,F1,41,D2,2C,04,FE,23,00, 9A,13,1A,E1,F4,4B,D1,D0,30, 9A,DF,FF,13,1D,D0,23,FF,3F, 9A,C3,3E,F3,20,01,4E,A0,0F, 9A,61,BF,FF,21,DF,0E,F2,41, 9A,AC,24,2E,12,DE,41,D2,40, 9A,F0,24,CB,2E,05,FE,FE,12, 9A,ED,00,F0,23,FA,E3,40,F1, 9A,0E,03,0F,32,E0,23,1A,E1, 9A,E2,3E,0E,F3,FC,01,EF,13, 9A,2D,AF,53,F0,10,FF,20,04, 9A,1E,02,4F,AF,0F,21,0F,D2, 9A,4B,D2,FE,02,30,CB,14,21, 9A,0E,10,02,F1,4E,E3,41,BD, AA,00,01,F0,F0,30,CF,2F,F0, 9A,52,DB,D3,32,1E,F3,E0,2F, 9A,33,DF,43,EC,F0,F0,00,1E, 9A,24,CA,21,EF,23,0D,CE,33, 9A,21,D1,1E,12,04,0C,15,1D, 9A,E0,E0,FF,11,F3,2B,C1,1F, 9A,02,2E,DE,F1,44,EC,31,E2, 9A,02,4E,D3,3E,E1,FE,0F,E0, 9A,23,2D,CE,11,F1,3F,CF,0E, 9A,16,2C,F3,E0,3F,34,CE,41, 9A,C1,2E,E0,ED,14,4E,DF,E0, 9A,0F,32,EC,1F,D2,70,C1,2E, 9A,11,15,0B,23,DE,31,EE,FD, 9A,E2,53,DF,ED,01,13,0B,E3, 9A,EC,56,ED,21,E1,22,4E,C4, 9A,0C,12,1F,ED,DF,35,0E,0E, AA,E0,12,1E,D1,1E,F4,1F,F1, 9A,00,02,42,B0,4C,E4,0F,1E, 9A,BD,15,3E,F1,ED,02,30,BC, AA,21,D0,41,EF,11,00,12,0E, 9A,2F,B4,3E,12,BA,F2,41,F1, 9A,0D,D1,43,D9,05,EB,46,FD, 9A,02,1F,04,5D,D3,BE,61,D3, 9A,0A,B1,22,01,10,DD,25,0A, 9A,C3,3C,E5,3F,E1,10,F2,62, AA,E0,FD,23,E0,2F,CF,11,F1, 9A,21,FE,E2,4E,9F,50,D0,32, AA,0F,01,00,22,0E,0D,04,1D, 9A,12,EA,F3,FE,23,1F,D0,42, AA,DD,21,F0,00,20,F1,1E,04, AA,2E,FF,D2,4F,E1,0E,F0,0E, 9A,14,21,EE,32,EA,E4,FF,2F, AA,02,0F,10,F1,40,FF,DF,42, 9A,A0,2D,D1,1D,C2,32,2E,F4, 9A,FB,B2,4E,01,E2,4E,F3,FD, AA,33,FF,FD,05,0D,10,E0,2E, 9A,BF,41,13,F0,3D,AE,31,F3, AA,FE,23,FF,1F,04,2E,EE,E4, 9A,6C,E3,BB,44,CB,F3,20,31, 9A,10,BB,22,F0,3D,E5,3D,02, AA,F1,40,EE,E0,50,E1,0C,03, 9A,FB,D0,40,04,20,09,C3,1F, 9A,31,C0,51,C2,1F,66,BC,EA, AA,35,ED,2F,D1,2F,FE,F2,01, 9A,61,DF,AF,2F,13,FD,15,0D, AA,10,04,1D,FE,E5,3D,01,CF, AA,3F,F0,EF,3F,14,0E,EE,11, 9A,E2,1E,E3,4F,D2,12,7E,AE, A6,CC,12,FF,DB,CD,BC,EC,CE, AA,02,4E,EF,E0,11,1F,F0,21, AA,FF,11,22,DE,0E,34,FE,0D, AA,02,FE,10,E0,10,33,DF,FF, 9A,F2,11,EF,22,1E,03,14,1A, A6,FD,C0,3F,ED,CD,EB,BC,ED, AA,F0,14,2D,E0,F0,11,FF,02, A6,22,01,22,43,FD,BD,32,EE, 9A,EF,3C,D1,01,FC,16,6F,BE, 9A,0F,12,FD,F4,20,FF,32,13, AA,EE,FF,45,DD,0F,10,E0,0F, 9A,00,E2,54,FD,D0,01,1F,D0, A6,22,11,12,22,20,EC,C2,3F, 8A,BF,E4,BA,1E,F1,0F,36,51, 9A,DD,02,00,ED,35,FD,04,4E, A6,11,FD,BE,32,EE,DD,DC,CC, 9A,F0,11,00,13,2C,D2,2F,0C, A6,F1,32,00,33,11,1E,CC,03, 9A,BC,F0,0D,E1,0E,F1,31,D0, 9A,62,AE,40,FF,C1,52,DD,56, A6,20,10,DB,D2,3F,DD,EE,CC, AA,00,F0,02,0E,04,0D,12,E0, AA,FF,12,0E,04,1D,02,EE,03, AA,4F,DF,00,FF,00,F0,01,10, AA,E1,3E,F2,1F,FE,01,11,F0, AA,4F,D2,1D,E2,42,DE,00,FF, 9A,00,FF,01,20,DE,64,B0,40, AA,FE,F1,11,0F,23,DE,3F,D1, 9A,65,FB,E1,EE,F0,0F,F1,20, 9A,EF,14,0F,22,FC,D1,10,41, AA,F2,1D,12,CE,33,2F,D0,0F, 8A,BF,0F,FF,53,D9,06,31,41, AA,10,DE,10,12,00,2F,D3,0C, AA,13,20,EF,1E,F0,0F,00,11, 9A,FC,E3,3E,34,F1,EA,01,E3, 9A,60,F2,CF,5B,B6,53,FC,FF, 9A,DF,0F,F0,12,1E,C0,40,F6, 9A,2E,1C,C1,0E,56,0D,FE,41, AA,C0,32,1F,FF,FF,0F,00,01, 9A,2F,CE,22,F3,50,F0,BE,1F, 9A,F6,6F,BE,23,DB,36,3F,EF, 8A,AB,FF,FE,F3,51,AA,13,E3, AA,31,F0,0E,F0,F1,42,ED,11, 9A,0B,05,5F,F0,EC,FF,00,F0, 9A,22,EC,F3,0E,46,1E,FE,EF, AA,FF,34,1C,E2,1E,F1,31,F0, 9A,0B,E0,F0,FF,23,FC,E2,1D, AA,04,3F,EF,00,FE,14,3E,C1, 9A,5D,C1,44,FF,3D,BF,F0,0F, AA,01,1F,E0,10,E1,43,FE,F0, AA,FE,F3,41,DE,21,DF,13,2F, 9A,00,AE,0F,0F,F3,3E,CF,30, AA,EF,35,1D,E1,0E,E1,42,FD, 9A,14,EB,14,4F,F4,D9,10,E0, AA,F1,20,EE,11,0F,F2,51,DE, AA,1F,EF,33,1E,F0,1E,F1,31, AA,F0,1D,F0,F0,00,11,FE,F2, AA,1F,E0,44,FC,02,EE,03,20, AA,FF,00,FF,22,0F,2F,D0,0F, 9A,0F,13,FD,E2,10,EF,17,6E, 9A,91,2B,D4,51,F0,EF,0D,25, 9A,2D,23,AC,1E,F1,02,1D,D1, 9A,20,0E,F3,65,DA,10,C0,52, AA,00,0E,00,01,20,F2,0C,F1, 9A,FF,F2,3E,CF,21,1F,E1,44, 9A,3C,D0,EF,32,01,1D,F0,E1, 9A,43,E0,4C,A0,0F,01,20,CE, 9A,21,01,FE,23,51,CE,0F,02, 9A,00,3F,E0,DE,55,0D,22,AD, 8A,1E,01,22,BA,14,F2,1C,14, 9A,33,0D,E0,10,00,21,D1,FC, 9A,16,3E,E4,FA,FF,F1,20,FD, 8A,E4,01,4D,D3,35,50,CB,22, 9A,FF,13,E0,2B,C5,62,CF,4D, 9A,B0,F0,21,EE,E2,0F,31,D1, 9A,20,22,0E,F2,FD,14,0C,31, AA,C0,42,FE,12,DE,00,11,FE, 8A,D4,3D,26,CE,40,14,30,E1, AA,0F,F1,1F,03,EB,24,2F,E1, 9A,0B,E1,02,0E,D0,10,04,FD, 9A,22,F0,21,02,1D,B1,50,C3, AA,2B,E5,3F,FF,1F,FF,01,1F, 9A,CE,12,F2,2E,02,0F,02,12, AA,1F,DF,22,FF,20,A1,52,FE, 9A,03,CC,02,20,CD,02,F1,40, 9A,D1,2F,E1,32,32,AA,14,1D, AA,03,DC,44,0E,F1,1D,F0,11, 9A,EC,E2,00,42,DF,21,EE,24, AA,12,FC,F1,11,F1,1B,F6,2E, 9A,D0,3E,CF,22,FC,D2,1F,23, 9A,EF,21,FD,05,33,1B,AF,24, AA,0F,2E,C2,50,FF,10,EE,12, 9A,0B,C1,2F,14,0E,02,0D,D4, AA,31,1F,ED,F2,3F,00,DE,53, 9A,EB,02,0D,D2,3E,BE,30,F3, 9A,2F,F2,1E,C0,65,2F,EC,91, AA,40,F1,FD,05,1E,F1,00,E0, 9A,21,BD,01,03,3F,E0,30,CD, AA,23,20,FF,DD,33,F0,0E,E2, 96,33,FF,FF,FD,E1,EB,BC,CF, AA,20,FF,12,FD,04,30,E0,FC, AA,F5,1F,F0,FF,23,FF,1F,0F, 9A,F2,0B,E1,00,32,0E,03,0B, AA,F2,41,FF,0E,D1,31,FF,FF, 9A,27,2B,00,F2,FF,0C,E1,FF, AA,21,0F,01,1E,E1,42,0F,FE, 9A,CF,46,FC,EF,04,5F,E0,D1, 9A,3E,FE,C0,1E,24,1E,F1,3E, 9A,CF,65,2F,FB,DF,05,3D,C0, 9A,02,41,E1,FD,32,DE,CF,2F, 9A,F3,21,FE,22,DD,35,30,0D, 9A,BF,F2,60,AE,11,33,E0,2D, 9A,F4,FD,DD,10,F3,20,0E,13, 9A,EC,26,20,1F,AD,10,44,CC, 9A,0F,26,0D,20,C3,3C,DD,00, 9A,F1,31,1E,F3,0C,05,31,10, 9A,BC,00,24,FC,0F,F5,4C,04, 96,0F,44,EB,BC,BB,F2,33,13, 9A,1E,F4,30,12,DB,E0,14,3C, AA,E0,01,3F,E2,1E,12,ED,F0, 9A,0F,32,10,EF,30,E2,40,03, 9A,EB,D0,13,4E,B0,0D,57,CE, 96,31,F5,5E,AC,CB,CF,13,20, 9A,21,F1,40,F3,0C,DF,F1,53, AA,DF,1E,04,1D,12,E1,1E,D0, 8A,1E,14,12,1C,F4,10,63,E4, 9A,1C,EE,F0,35,EB,0F,E5,6D, 96,E3,42,44,EB,CB,BD,F1,31, 9A,D2,30,12,01,1D,FF,DF,15, 9A,3B,D1,E0,63,C0,4E,F3,DA, 8A,E1,F3,21,3F,B0,54,23,01, 9A,1E,E0,EE,02,5F,CF,FF,35, 9A,0D,23,EF,0C,D0,F1,20,11, 9A,EE,24,10,01,2E,D0,0E,E0, 9A,43,EE,ED,24,4F,D4,2D,EF, 9A,DF,E0,31,01,FD,14,30,00, 9A,1F,EF,0F,EF,32,01,EA,04, 9A,33,EF,5F,CF,FD,E0,31,F1, 9A,0D,F5,5F,F1,2E,EF,F0,FE, A6,EF,F0,0C,BE,F1,31,24,20, 9A,0F,DF,12,01,0E,E3,61,E0, AA,10,FF,F0,1F,00,01,2E,C1, 9A,41,50,E4,09,E2,FC,03,10, 9A,FF,E2,63,D0,3F,D0,FE,1F, AA,01,0E,22,CF,20,03,01,1D, 9A,A2,2C,E3,1F,00,E0,55,EF, AA,10,F0,FF,01,F0,0F,14,EB, 9A,24,F5,4F,1E,9F,4F,B1,20, 9A,00,EF,46,0D,31,DF,0E,E1, AA,00,1F,E3,2C,F2,F0,42,FF, 9A,BD,12,DE,21,0F,FF,36,1D, 9A,21,D0,1D,D0,30,0F,D2,6D, 9A,A2,2D,47,2E,BB,02,0E,00, 9A,0F,00,24,3D,12,EF,1E,DE, AA,11,00,FF,21,EF,1F,04,30, 9A,A9,F2,00,F0,0F,F1,23,3F, 8A,F3,EF,1D,BB,15,1F,ED,37, AA,FE,10,F2,41,EC,F2,F0,0F, 8A,03,D0,44,52,F1,FF,1E,CA, AA,F2,1F,F1,00,1F,F0,F1,42, 9A,FB,A1,0E,30,D0,F0,32,21, 9A,00,00,0F,EE,E1,30,E1,FF, AA,20,E0,0F,33,1F,CE,2F,01, 9A,EF,0F,32,02,2F,F1,00,FD, A6,DD,F0,EE,FE,E0,00,0E,F4, 9A,3F,BA,10,E4,0B,01,33,F0, 9A,3F,F1,1F,0D,DE,25,FD,2F, AA,F2,0F,0F,F4,3F,FE,E0,01, 9A,2C,D2,43,EF,40,D2,1F,0F, 9A,DD,F5,2D,21,A1,5E,0F,C3, AA,50,E0,EE,10,10,EF,23,FF, 9A,32,C1,2F,1F,DD,E3,4E,03, AA,DF,30,F1,EF,43,EF,0D,F1, 9A,12,EC,36,0D,22,D0,20,0F, 9A,DF,E0,50,D4,FA,33,D2,1C, AA,14,FE,2E,C2,2F,0F,02,1F, 9A,12,EF,20,00,EE,EF,42,D2, AA,1D,02,F0,1F,F3,2D,11,CF, 96,0D,CF,E0,31,02,10,23,21, 9A,FE,DE,35,E0,2C,C5,2E,01, 96,01,75,16,4C,DE,BE,10,22, 9A,F0,0F,12,0F,FE,EE,14,1F, 96,20,BD,22,13,20,25,34,6F, 96,CE,CC,23,11,1F,00,01,20, 9A,0F,ED,04,2F,10,BE,52,E1, 96,42,02,32,43,ED,DD,04,11, 8A,3C,E3,D2,4E,FF,DB,D4,61, 96,12,0C,E3,32,33,0F,33,23, 96,2D,CE,03,31,20,E0,FE,00, 9A,0F,FE,E0,32,10,FC,E4,2F, 9A,11,EC,24,E0,2D,C3,21,30, 8A,DC,D4,FD,43,EE,EE,C0,34, 96,22,20,CF,33,35,4E,C2,40, 96,22,EE,21,24,3F,EF,FD,E0, 96,FE,ED,BB,CF,22,23,ED,23, 9A,02,FC,C4,4D,03,EF,30,F3, 9A,1C,F1,0F,01,1F,FF,0F,F2, 96,32,13,0C,03,46,50,BC,32, 9A,C3,3F,00,F2,2E,D1,0F,F2, 96,FE,DD,DD,CD,12,14,3D,E2, 9A,12,0D,BE,54,B0,52,FE,02, 8A,1F,CD,20,C2,3F,FE,01,DD, 9A,42,D2,2A,D4,22,1D,CD,15, 9A,EF,54,0D,E1,01,2C,E2,E0, 96,DD,DD,DE,EC,F3,12,52,DF, 9A,33,2C,BE,03,1E,46,2C,C2, 9A,0F,3F,B2,FF,21,E0,02,FC, 9A,15,0E,20,BE,43,2F,AD,F1, 9A,30,26,4D,B0,1F,11,DF,1E, 9A,11,F0,01,0E,F4,0F,13,CA, 9A,24,41,AA,00,22,24,5F,DE, 8A,D0,13,FB,EF,13,EE,14,1A, 9A,E3,20,02,FA,F3,43,C9,F0, 9A,F4,43,31,EF,DF,10,1F,EF, 9A,01,0F,02,2E,D1,21,02,0A, AA,F1,22,FC,F1,E1,41,11,0F, 8A,AD,20,01,CB,22,FE,13,5D, 9A,DF,23,10,1C,B1,44,19,B1, AA,FF,53,00,1F,FF,00,00,0E, 9A,F3,0E,12,2F,DF,13,10,2E, AA,DF,22,1E,C0,0F,35,0F,10, 8A,BD,D1,1B,20,A2,2C,04,51, 96,FC,D2,54,56,1E,02,54,D9, A6,EC,E3,43,44,33,1F,0F,EE, 9A,EF,2E,F3,31,EC,F3,40,F1, AA,FE,01,11,DD,10,04,20,10, 8A,A0,0A,20,91,3C,F0,E3,64, 96,1D,BF,46,56,5F,E1,23,1B, 9A,F1,05,51,10,F1,FE,F1,DE, 9A,20,E0,01,22,0C,D3,41,F0, 9A,1B,D3,10,1B,C2,31,33,3E, 8A,F4,FC,C0,FA,F4,FD,F1,45, 9A,2C,B1,52,0F,2D,A1,30,0E, 9A,B1,41,04,4E,F2,0E,0F,FE, 9A,D1,2F,F1,12,2D,B1,43,FF, 9A,20,AE,30,F0,DF,42,D3,60, 8A,C3,2C,FF,BF,CD,42,C1,22, 9A,3F,BF,33,1F,11,CB,21,FF, 9A,0E,23,F1,50,F1,2F,E0,EF, 8A,FA,F6,FE,32,31,AB,26,40, 9A,F2,EB,02,DF,20,F2,10,41, 9A,F0,21,E0,0C,FF,E1,3F,00, 9A,21,FD,01,22,00,0C,E1,DE, 8A,67,DE,41,23,22,03,FD,2B, 9A,C0,FF,32,FF,02,0F,E1,22, 9A,F0,2D,C1,ED,25,FD,23,00, 9A,12,01,1E,00,BF,0E,14,1E, 9A,F1,10,EF,23,0F,10,CF,EC, 96,B2,4F,F3,42,35,65,54,22, 9A,DD,0F,E3,4F,D0,31,ED,04, A6,32,22,10,0D,D0,20,02,20, 9A,14,2F,F2,0F,0C,D0,01,31, 9A,DF,22,FE,E3,3F,01,EE,FB, 9A,D6,7D,C3,4D,F1,31,F0,2F, 9A,0E,BF,10,33,EC,13,0F,D1, AA,20,F1,0F,FE,E2,40,D0,30, 9A,DF,33,FF,30,E0,BD,21,12, 9A,0D,03,1E,DF,42,F1,1E,DD, 9A,C1,64,DE,31,FE,14,1E,12, 9A,E0,EA,04,10,0F,F2,1F,EF, 9A,13,00,10,DD,DF,35,1E,01, 9A,1E,F2,30,F2,0F,FC,C4,30, 8A,DD,03,21,DC,E5,5F,11,CC, 9A,DD,05,50,DF,30,D0,41,F1, 9A,2E,FF,B0,41,EF,12,F0,0F, 9A,E0,31,01,EF,ED,F2,43,ED, 9A,32,DF,22,00,21,DE,DF,42, 8A,BB,16,1D,00,CC,55,12,EC, 9A,FD,E0,26,2B,04,ED,13,10, 9A,12,EC,FF,23,ED,03,2E,F0, 9A,FD,13,21,0E,FD,E0,F4,6E, 96,14,51,F1,22,24,4F,CC,CE, 9A,0D,E2,30,D1,1D,E2,21,2F, 96,31,FE,CE,57,33,42,F0,22, 9A,11,2D,B2,20,0E,D1,32,EF, 9A,1D,D1,42,1F,EF,FF,DF,65, 96,53,44,0E,01,33,43,DB,FF, 8A,DE,D0,44,EC,1E,AF,45,51, 9A,EF,0E,DE,36,1E,F1,0D,11, 9A,12,11,CC,53,DD,00,11,0F, 9A,00,ED,03,41,EF,1E,DE,04, 96,56,43,31,F0,02,34,2C,C2, 9A,FB,F1,21,FF,0F,FF,E1,43, 9A,FE,10,DD,E3,43,0D,00,EF, 96,02,33,3E,B1,3D,AC,DE,DD, 9A,1F,D0,E0,34,1E,00,ED,E1, 8A,66,5E,A0,0D,04,52,0C,A6, 9A,5C,B2,20,FF,10,DF,0F,13, 8A,5E,F3,E9,AF,55,73,9B,4E, 96,EF,23,21,ED,22,CB,EE,EC, 8A,03,DA,FE,24,53,F1,FB,AD, 9A,12,34,FB,02,DF,43,0F,FF, 9A,22,DE,11,1F,E1,0D,E0,01, 8A,47,2E,FE,BB,E5,56,39,B4, 86,1A,D4,52,0F,02,0B,AB,CC, 9A,EF,1F,DF,20,02,40,FF,FD, 9A,D2,31,30,C0,1E,F4,20,E0, 8A,41,EF,00,00,ED,F1,CB,22, 9A,F1,52,EF,0F,BF,41,32,DD, 86,20,AF,42,F0,42,DD,FF,CA, 9A,1F,D0,0E,01,FF,45,FE,F1, 9A,CD,32,03,0E,F0,E1,31,F0, 8A,43,AD,54,FA,F2,BD,2D,D1, 9A,0F,26,1D,F1,EC,12,03,2E, 96,10,0E,F1,0F,14,1C,E1,2F, 9A,D2,FD,F0,F0,00,04,4F,E1, 9A,EC,03,F1,20,FF,00,02,0F, 9A,14,0B,04,2F,C0,1D,E0,00, 9A,E0,13,40,E1,0C,E2,1F,21, 9A,1E,E0,11,10,03,1C,E5,20, 9A,DE,0F,EF,F1,E0,11,43,D0, 8A,3A,93,3F,02,31,BE,20,12, 9A,02,3E,C2,40,FD,F0,FE,E1, 9A,FE,22,23,FF,2E,C1,2F,F1, 9A,21,FD,11,F1,11,30,CF,52, 8A,EC,BD,0D,C0,0B,26,34,0D, 9A,30,BF,30,FF,02,3D,E2,F0, 8A,51,14,DC,56,EE,EA,E0,CD, 9A,0E,03,31,0E,23,CC,32,FE, 9A,F2,3F,D2,0D,33,00,0E,14, 8A,2C,FB,A0,FD,ED,E4,74,0C, 9A,04,FB,14,FD,E1,42,CF,3D, 9A,F5,2E,01,02,2E,F0,DE,0F, 9A,EE,01,33,1D,F3,2D,E3,1E, 96,10,14,30,21,CE,31,E0,10, 9A,21,F0,DC,F2,FC,E2,33,2D, 9A,E2,4E,D0,40,DD,F4,3E,01, 9A,DF,62,CF,31,21,EF,0D,D0, 9A,1D,C1,33,3F,C0,41,EE,32, 96,51,F0,43,12,0C,E4,1C,F3, 9A,F1,0F,FE,DF,1F,BE,34,32, 9A,CD,32,FF,13,FC,E0,22,02, 96,2D,C2,4D,C2,32,31,EC,CA, 9A,E0,EC,14,31,0C,13,FF,03, 9A,2D,CE,13,11,1D,E3,5D,C5, 9A,4E,11,ED,F0,FE,ED,E4,51, 9A,1D,D2,20,01,3F,BD,12,11, 96,31,EF,21,CD,33,13,2E,BC, 9A,0C,D0,D1,62,F1,DF,20,02, 9A,21,DC,E1,22,20,D0,31,DF, 9A,54,E0,2D,CF,3F,BD,FF,54, 9A,F1,FD,11,F2,40,ED,EF,11, 9A,22,FE,31,DF,45,FE,21,BC, 9A,23,CA,F0,26,0E,10,D1,00, 9A,53,EC,DF,10,23,1D,03,EE, 9A,25,2E,03,CB,04,EA,D1,04, 9A,4E,E2,FE,2F,25,0C,EE,00, 96,01,32,02,1C,C1,43,13,2B, 9B,D3,2D,AE,13,41,D0,2D,01
$DF:A4E4             db 00,00,00,00,00,00,00,00,00, B8,00,0D,34,EE,F1,00,10,10, A8,02,EC,E1,00,C2,4F,E1,11, A8,00,E2,00,EF,40,E2,F1,1F, 98,FE,4F,91,2E,02,20,EF,07, A8,3C,D1,11,0E,01,E1,E0,2E, A8,20,25,CA,E1,21,02,1D,13, A8,FE,C1,72,BF,01,EF,3F,F0, 98,D5,5C,03,0E,D1,FF,1E,32, 98,21,A0,41,FC,B2,0D,52,EC, A8,04,30,ED,02,EE,1F,41,E4, A4,3F,FD,CE,11,00,EF,FE,02, A8,01,01,DF,4C,F0,02,D0,21, A4,1D,D1,20,EE,22,F0,25,43, 98,EC,43,02,FE,11,FC,F2,F4, 98,4C,D0,E2,4F,0E,F3,BD,3E, 98,04,11,2D,FD,D2,0E,12,2F, A8,00,10,21,F0,FF,1E,04,0C, 88,44,05,CF,50,BB,E1,AE,60, 98,F1,03,0C,31,DC,03,10,FF, 98,F1,35,5C,C3,DF,1C,44,E0, 98,21,CB,25,FF,00,0C,FF,02, 98,0F,1F,30,CF,60,B2,0E,F0, 98,23,0E,52,E1,FE,1E,21,FC, A8,F5,0D,12,0F,0F,0F,0F,E3, 98,1F,DD,10,30,12,DF,1D,E3, 98,3E,F7,2D,0F,20,F3,1D,E2, 98,EE,13,1E,10,0F,F0,0F,DD, 98,02,11,00,3D,A3,32,FE,F1, 98,4C,B5,30,1F,4F,F1,01,FC, 98,A3,62,F0,31,BF,1E,01,0D, 98,E0,2F,0F,E4,F0,01,0E,F0, 98,E0,40,25,EF,3C,F4,00,01, 98,CC,62,01,EE,0E,03,20,CA, 98,22,C0,44,0C,E2,F0,0E,4D, 98,32,B2,EE,21,42,DE,36,EC, 98,01,C0,22,3E,F1,02,DF,2C, 88,DF,26,99,2F,47,01,CA,4D, 98,E1,E1,21,F2,41,FC,06,DC, 98,54,EB,E5,2E,E3,2B,22,F0, 98,BD,D1,53,FD,14,EE,F0,EE, 98,11,32,EE,3E,F1,14,FD,21, 94,41,AA,E3,0E,1F,DE,13,EE, 98,1D,E3,2F,C0,1E,F4,F0,2D, 98,E0,E4,EC,32,5F,E2,01,FF, 98,20,20,E1,DE,45,CF,1F,40, 98,BF,1F,FF,11,EE,14,3E,D0, 98,D0,10,20,ED,F6,4F,D1,3F, 94,F0,1F,EF,FF,21,CC,00,D1, 98,3C,FE,F0,01,ED,21,03,0E, 88,FC,FE,C2,40,D2,72,FC,15, 88,1D,5F,F1,9F,55,4E,E0,ED, 98,12,0E,0D,14,BB,42,E2,30, 98,CF,0F,21,0E,E1,02,10,3E, 84,F2,42,AA,27,5B,D2,DE,EC, 98,2F,02,0E,E1,1D,F2,0C,04, 98,2D,C0,52,DD,1F,D2,21,0F, 88,53,34,BD,DF,03,60,F1,FE, 88,22,EF,D1,1C,22,DD,F4,0C, 98,E0,32,00,EF,EE,00,53,D0, 94,32,24,1E,0C,B0,11,34,2E, 94,DD,F3,0E,FF,EC,D1,0E,FF, 98,F0,E0,0F,12,2D,C1,32,FF, 98,0C,05,10,23,DC,21,E0,23, 88,0D,F3,FD,DE,21,6E,A2,EE, 88,1F,D1,64,DC,CF,11,20,D2, 98,2F,D0,42,F1,DE,20,F2,3F, 88,C3,2F,06,29,CE,F3,D0,51, 98,1E,01,FC,D3,4D,C2,40,D2, 98,2B,C3,50,E2,4E,CF,11,11, 88,34,0F,DB,02,2E,02,EC,14, 88,ED,44,BB,EF,43,E0,FD,31, 88,C0,00,52,EE,02,EE,34,2E, 88,F0,CE,67,29,F6,0A,F2,1B, 88,D5,5D,DE,42,BD,00,0F,E1, 88,4F,C1,5E,D4,2B,F6,60,BE, 88,F2,30,EF,35,FF,10,FD,D0, 88,ED,65,BD,51,DC,04,0A,B1, 88,52,F1,20,D0,0D,12,33,0D, 88,C0,00,66,EB,E2,22,31,CB, 98,F1,2F,E2,3E,CF,31,ED,13, 88,FA,F3,14,0B,0F,F1,43,0D, 88,12,0E,24,FD,F1,1F,33,10, 88,DD,00,ED,12,FD,34,0F,CC, 88,34,E0,0D,C0,44,1E,E3,1D, 88,F0,01,23,2F,EF,E1,33,00, 78,BC,57,E9,BE,D0,42,03,31, 88,DA,CF,33,03,4E,CE,E1,2E, 88,33,FE,33,F1,2F,EE,01,13, 88,2E,CE,30,01,FD,22,EC,01, 88,EE,45,FE,DD,12,FF,11,10, 78,05,D9,05,43,0F,10,F4,1C, 88,FE,05,5F,C0,0C,D1,52,0B, 88,E3,FE,00,0E,F2,EF,21,21, 88,00,EF,20,E0,53,ED,12,02, 88,3E,CD,14,0E,F2,10,0E,01, 88,CC,12,31,FC,C3,3F,E1,21, 88,E3,2D,BF,41,D2,32,F1,10, 88,FF,FF,1F,34,1D,D0,01,3D, 88,EF,F0,21,FD,FF,D0,55,0C, 88,D0,01,10,12,11,EC,F1,23, 88,51,DE,11,E0,20,DE,02,2F, 78,D1,0B,0F,D2,43,DB,0B,D6, 78,2E,52,E4,3A,B2,0D,E0,35, 88,22,1F,01,2E,C0,20,FE,04, 88,2C,02,EE,30,DD,D1,64,CB, 78,E0,21,04,70,BC,F0,34,FE, 88,23,10,EE,02,40,DD,03,1D, 88,E0,22,0E,D0,1E,02,21,EC, 78,C3,1F,53,ED,CF,55,23,3B, 88,BE,12,32,22,DE,12,EF,20, 88,C0,20,F1,30,FE,E1,1F,EE, 88,01,DE,35,1E,FF,FF,13,41, 88,DD,00,02,11,21,EF,20,E0, 78,20,9D,27,5F,DC,9F,43,FB, 78,E1,21,E2,4A,93,42,24,2D, 74,2F,FF,DE,F1,21,CC,FD,D2, 78,5F,CE,FD,22,EF,FF,E0,52, 78,DD,BB,26,2B,D3,2F,01,F1, 78,20,1F,E3,62,BA,04,40,05, 88,21,DE,EF,01,12,1E,C0,1F, 78,01,0F,F0,01,20,FE,F2,4E, 78,B0,42,FE,E2,11,63,EC,F4, 74,31,CB,11,BA,D0,EC,EE,CC, 78,10,ED,DC,37,1A,06,0B,FF, 88,EF,21,F3,3F,E2,3E,D0,21, 88,01,20,EE,E0,23,10,DC,E2, 78,41,F1,0F,0E,DF,00,F1,31, 78,E0,02,0F,20,DC,15,64,0C, 78,AD,46,2E,E0,10,CE,34,1F, 88,F1,0F,0F,D0,2F,DE,02,53, 88,FC,E0,F0,31,EF,01,14,4E, 78,A1,2F,DC,04,3F,E1,31,EC, 78,15,1C,AC,03,1E,D2,41,DE, 78,20,D1,11,33,ED,E0,02,22, 78,ED,23,20,02,0C,C2,71,AE, 78,63,CB,13,FC,24,EA,CD,03, 78,40,E2,0E,25,2D,AE,FF,35, 78,11,0F,26,4F,AB,04,1E,F1, 78,1D,03,3F,CB,D2,50,CD,F2, 78,40,DE,23,2F,DF,11,FD,24, 78,2D,C0,33,33,0B,C1,23,21, 78,0C,CF,36,1A,C2,10,E1,0E, 78,F0,DE,12,12,12,EA,C0,46, 78,2F,E0,1F,14,42,EB,E1,55, 88,FC,E1,F0,22,00,FE,E1,1F, 78,D1,52,EC,BF,34,2F,E0,32, 78,0F,DD,E2,43,41,CF,3F,C0, 88,10,00,10,01,1F,DE,24,0D, 78,D1,0D,CF,33,F0,2F,DF,01, 78,12,30,DD,15,42,FF,ED,E3, 78,54,DD,DF,24,4E,BE,0F,EF, 68,F1,45,11,D9,AF,74,DC,1F, 78,E3,63,DC,F3,2F,DF,1F,03, 74,11,ED,35,1E,FF,F0,0F,03, 78,0E,DC,D1,41,EC,E1,44,0E, 78,DE,13,FE,F3,2F,14,2D,E1, 78,31,01,1D,CE,05,31,00,ED, 68,CD,9D,24,20,10,04,42,0B, 78,BA,06,41,1F,C0,21,03,2F, 78,EE,DF,23,31,11,FE,02,0D, 88,FF,01,10,0F,11,EC,F2,21, 78,0E,DE,F2,33,0E,C0,32,02, 78,41,FF,EF,13,1F,EF,EF,34, 78,FD,F1,EF,F1,10,DE,F1,24, 78,40,DB,C0,34,1C,D2,10,35, 68,2B,AE,21,DF,35,2B,AF,24, 78,55,0A,A1,3F,F0,FF,00,FE, 78,23,DC,01,F3,4F,DF,FF,23, 78,32,1F,DD,14,40,FD,E1,0F, 78,11,00,22,DB,D2,2F,11,EC, 78,03,32,DB,F4,2F,02,2E,DF, 68,4F,E2,51,F0,20,EE,14,0C, 68,F6,50,CF,1F,F1,2E,C2,3D, 68,AB,BF,36,40,DD,04,2A,A2, 78,31,11,0E,F1,34,2F,DD,E1, 78,33,1E,CF,21,F0,1F,FF,FD, 78,E1,33,2F,FE,0F,00,1F,01, 68,20,12,FD,E0,12,EE,26,20, 78,12,EC,E3,41,D0,1E,D0,22, 78,10,0F,CD,01,10,FF,01,00, 68,45,D9,F6,3B,C6,52,32,DE, 68,43,FD,CB,D1,65,1E,DE,01, 68,CC,01,13,00,F0,00,D0,43, 68,DC,EF,25,20,0F,D1,51,DB, 78,F1,21,00,11,12,0D,BE,34, 68,1D,01,FC,E0,20,0F,DC,DE, 78,01,31,FF,12,21,FD,E1,22, 68,2F,C0,76,E9,DE,03,2E,CF, 78,22,1F,DD,02,0F,02,0F,F1, 68,31,EC,E0,44,1F,EF,00,EF, 68,23,0F,21,EF,22,FF,03,41, 68,EF,0D,BD,45,1E,DD,D0,33, 68,0D,EF,EF,01,23,30,CE,35, 78,21,0E,CE,23,31,0E,EF,11, 68,FF,21,BC,01,02,21,FD,C1, 68,42,00,FD,F0,01,22,0E,E0, 58,44,0B,C1,0F,17,71,E0,20, 68,EF,20,DE,33,0F,10,DA,D1, 68,43,0E,EE,DF,44,0E,EF,00, 78,01,23,2E,CE,23,30,ED,E0, 58,56,54,FB,BD,EF,33,FC,EF, 68,F0,04,53,BA,E1,FF,33,10, 58,0D,BF,36,2D,CE,13,2F,E0, 58,37,6F,BF,2F,CD,0F,14,50, 68,EE,0F,EC,F2,30,0F,01,0E, 68,01,00,12,22,0D,D0,55,2D, 68,AC,14,3F,DD,03,30,EF,10, 58,EB,CE,22,23,40,DF,0F,01, 58,0D,C1,30,E3,63,EA,B0,41, 58,F1,23,20,23,CB,25,FB,02, 58,1D,E0,1D,F1,2F,DE,FE,BE, 68,45,2E,CE,03,21,F1,0F,F1, 58,55,1C,AE,33,E0,00,EE,EE, 68,F2,42,FD,DE,12,21,0D,DF, 58,66,51,EA,AC,26,4E,C0,32, 48,F1,4E,AF,72,E1,44,3C,B3, 48,4D,AD,34,FB,D0,0F,EA,B1, 58,23,31,DB,BF,56,42,FC,C0, 58,46,4F,BC,F1,33,1F,DE,F1, 68,00,00,00,00,FE,02,41,FC, 58,BE,34,40,DD,F1,32,1F,FE, 58,DE,12,11,22,10,00,FE,01, 48,3F,02,2D,B1,52,DC,EE,FF, 58,FE,D1,42,FF,00,13,0E,DE, 58,03,43,20,ED,E0,23,1F,DE, 48,04,31,EC,D1,31,ED,E1,24, 48,2F,CE,23,2D,AB,06,71,AA, 48,05,54,DA,D0,11,20,13,20, 48,21,22,FA,9E,25,41,FD,EF, 48,21,DB,D0,21,F0,00,12,31, 48,ED,E2,63,EA,D3,65,1F,DE, 48,FF,E1,1F,01,10,10,0C,CF, 48,34,20,EF,F0,21,FC,F2,30, 48,DD,02,32,1D,DE,02,43,0E, 38,BE,05,63,21,0A,A0,31,EE, 38,02,1E,D0,2F,EE,DA,C4,73, 38,00,1F,F1,31,23,FC,D1,11, 38,02,22,20,BD,0E,02,30,DD, 38,01,01,32,DB,E3,53,1C,AD, 38,25,0C,C1,44,FE,F0,10,1F, 38,F0,22,1F,23,0D,E2,3F,CE, 38,24,30,CB,DE,04,40,DD,00, 38,00,21,0E,D0,33,22,0F,EF, 38,01,21,1F,EE,E0,25,3F,DE, 28,CE,E2,54,DA,E2,43,30,FC, 28,B0,03,30,C9,E6,62,FC,E1, 28,2F,DF,46,3C,F0,02,32,0F, 28,CB,F2,43,0D,EE,42,0D,DC, 28,DD,25,62,0D,DD,F1,36,1E, 18,9E,23,53,0E,DE,ED,27,5D, 28,DE,F2,34,0E,CF,FF,02,30, 18,D0,06,FF,DE,ED,C3,62,00, 18,0B,F4,40,1D,0E,D3,4F,53, 18,EF,EE,F1,31,0C,E3,E1,3F, 18,FD,0F,00,10,F0,01,30,D1, 08,2E,00,E1,01,40,3F,B0,F3, 18,10,3B,F2,F1,00,00,2F,00, 04,10,00,00,00,24,22,00,0D, 00,10,00,00,FF,00,00,00,00, 10,00,12,23,33,33,21,00,00, 00,00,00,FF,EE,FE,EF,01,00, 00,00,00,00,00,00,00,00,00, 01,00,00,00,00,00,00,00,00
$DF:AE2C             db 00,00,00,00,00,00,00,00,00, A0,31,DD,DE,22,12,55,2B,AB, B4,01,12,20,FD,D1,F1,11,20, B0,22,2E,EC,CF,02,22,33,EF, B0,DD,E0,35,42,2C,DD,D0,21, B0,43,33,CB,DE,FF,13,43,0A, B4,10,41,13,0F,FB,E4,D3,01, B0,44,13,FB,EA,E2,36,53,3A, B0,AC,AF,33,42,11,9B,DD,22, B8,10,00,F9,60,F6,FF,0F,0E, C0,EE,EC,E1,23,23,30,EE,DF, C4,20,2F,10,DE,1D,13,22,F0, B4,FA,E2,A1,51,6F,20,AB,1B, C0,DF,F3,33,2F,1D,DF,23,31, C0,12,1D,DE,E0,02,23,31,CE, C0,CE,12,54,32,DC,FB,F1,12, C0,12,2F,1F,CD,EF,44,31,10, C4,BF,51,04,0D,F1,E0,D0,23, C0,41,F4,2D,FC,F0,02,24,3D, C0,F2,BE,E0,53,21,F1,CC,0E, B4,66,EF,0A,CF,F7,05,01,4C, C0,C2,CC,FE,24,44,0B,3B,EF, C0,D4,34,40,0B,AD,D0,43,44, C0,1E,DA,BE,14,23,5F,DE,BE, C4,2F,40,3F,B0,C0,20,25,01, C4,EE,AF,3E,33,11,0E,EC,3C, C0,D1,14,43,12,AC,BE,23,33, C4,D0,B0,4F,42,F1,EE,FB,3F, C4,05,10,1F,EB,1F,24,21,2D, C0,10,AC,C0,24,45,3F,AC,DF, C0,20,33,45,FA,CA,E1,33,32, C0,0D,AC,E1,23,21,3D,BF,EE, C0,02,F5,0D,09,F2,EF,5F,10, C0,DE,0F,31,6D,FF,B1,04,21, C4,0E,D3,D1,13,13,0E,BE,E1, C4,25,02,FD,F1,A4,E1,6E,3E, C0,20,FA,CC,23,36,1E,4A,D0, C0,E2,43,15,BD,1A,11,F5,2D, C0,0D,CE,04,04,3D,3F,B1,EF, C0,53,D2,0B,3E,F6,C5,FE,E2, C0,D3,E6,00,2A,F0,C2,33,53, C4,BF,1D,50,13,E2,CB,00,14, C0,34,33,2B,DC,C0,33,54,1F, C8,F2,10,4F,D1,DC,24,F4,F1, C8,D1,FB,13,03,1E,1E,E1,E0, C4,2D,44,02,0D,CE,F2,12,40, C0,41,EB,BE,F2,44,23,BC,F9, C0,04,25,1B,CD,B2,33,33,0D, C0,BB,D3,24,42,E3,AC,FC,54, C4,02,AB,3C,35,02,2F,DB,F0, C0,F2,24,31,1E,AF,0C,41,25, C0,FC,0B,03,04,3D,FE,D2,31, C0,60,FE,CE,32,33,2C,2B,D1, C0,32,50,1F,AD,0D,43,33,3A, C4,3D,15,4E,3D,A3,B2,35,D4, C0,4E,0A,BF,11,53,10,BE,C1, C0,04,53,1A,EB,20,64,51,CC, C0,BE,F3,34,52,BB,BD,25,46, C0,5E,CD,9F,31,65,2C,1A,EE, C0,F4,43,2B,AE,D0,53,35,CD, C0,FC,14,14,3D,EF,C3,34,43, C0,BE,CC,3F,54,0C,FB,D2,05, C4,FE,E0,B1,23,4F,1C,CF,0F, C0,11,44,10,CC,C1,15,33,FD, C0,DC,00,55,31,CC,F1,34,20, C0,FD,2C,20,F2,FD,4E,E3,B1, C0,1D,23,E6,DD,0E,F6,22,4B, C0,FD,E0,62,60,CC,DC,32,44, C0,0F,AC,F3,05,11,AC,A1,13, C0,44,FD,BC,10,63,00,AC,1F, C0,44,21,BB,00,53,30,BC,FF, C0,44,41,9B,FF,53,2F,AE,22, C0,51,BF,AF,42,22,AC,01,34, C0,FB,0C,05,12,3A,F0,C5,33, C0,5E,DF,B1,D5,15,2D,CE,B4, C0,04,2B,0B,E5,35,3D,FB,D1, C0,16,34,FB,EE,E5,02,0A,E0, C0,35,5F,BB,D1,64,50,BF,F3, C0,32,A0,A0,54,42,BB,DF,54, C0,5F,CD,C3,41,6E,C4,D3,40, C0,E1,AF,11,34,0E,E9,DE,15, C0,31,FB,DC,33,43,DF,1E,3D, C0,FC,12,64,2B,AB,D3,46,4D, C0,BD,F4,33,1F,A0,B5,F5,F2, C0,E0,EF,D2,04,20,DE,E2,24, C0,E1,D1,34,0F,BD,14,65,3C, C0,BC,F5,56,3C,9C,B3,55,4D, C0,DB,03,04,CB,10,45,FD,BB, C4,51,21,EC,EE,31,50,2D,AF, C0,C1,44,4E,EA,E3,45,FC,FB, C0,31,33,EE,D0,F1,31,2C,CD, C0,24,50,0A,DE,25,54,2A,DC, C0,F3,13,21,BD,AD,13,44,DD, C0,B0,25,1F,FD,F5,05,EA,D1, C0,E6,13,E2,B2,EE,0F,06,25, C0,EA,DC,34,52,EF,B0,4D,6B, C0,C1,35,51,AB,BF,54,42,CB, C0,EE,54,40,B0,F1,4E,3A,03, C0,16,EA,EA,25,54,2A,BF,35, C0,54,FA,CD,55,51,AC,F2,6F, C0,49,DE,24,31,AB,DF,54,54, C0,BE,AF,D3,34,4D,AB,B2,25, C0,00,B1,22,2A,BC,15,55,DB, C0,AC,06,35,EA,BE,15,31,DA, C0,0B,51,33,AF,D1,33,10,E2, C0,A5,B4,1C,1C,E3,04,FD,2A, C0,51,05,B0,02,43,EA,3B,35, C0,C4,BF,05,13,0E,FF,0F,6E, C0,01,B3,E2,40,3A,2C,15,D5, C0,DF,E1,E4,10,D0,C4,23,4C, C0,DF,13,51,DD,0C,41,12,1C, C0,3D,E1,2D,4E,F2,2D,2C,A0, C0,31,62,BC,CA,23,15,1E,CE, C0,A2,12,50,D2,EF,1B,EE,33, C0,33,CC,EB,31,23,F2,A2,A3, C0,1F,2D,1E,4E,F2,A2,21,5E, C0,FA,E0,15,E4,00,0F,A2,D2, C4,0F,E2,1D,1E,B6,F4,3E,DD, C0,AE,E5,03,4D,51,C2,B0,2D, C0,20,41,E4,AF,FC,51,40,BD, C0,C1,F3,2F,2F,D5,C5,C2,C4, C0,F0,3B,01,F4,F2,BF,F3,41, C0,0B,CC,31,64,0E,DE,42,2D, C0,1F,35,F2,CC,F1,45,32,AD, C0,A0,42,33,B2,BE,23,14,D2, C0,12,0C,F2,F6,14,EB,DD,14, C0,34,D0,AD,F3,E3,ED,3F,20, C0,EC,E1,04,23,CD,BC,21,50, C0,1D,B1,04,4C,EC,F3,32,EB, C0,CF,42,32,A1,CF,5F,01,CF, C0,11,22,2B,F1,16,2F,4B,E2, C0,16,24,A3,CD,5B,31,33,E0, C0,BF,FF,25,55,3B,CC,B2,35, C0,35,DE,DB,12,45,52,AF,BF, C4,5C,21,E4,DC,0E,F6,3F,03, C0,CF,CA,10,54,42,B0,90,3E, C0,41,F6,EE,FE,D3,22,14,B4, C0,EC,3F,33,30,0D,E2,FE,3F, C0,32,2D,2B,E3,14,E5,EC,39, C0,01,F5,32,DE,ED,5B,31,23, C0,2D,1A,CE,20,34,1C,49,D0, C0,F3,32,CF,0B,5B,32,E5,F2, C0,2B,FD,4E,14,C0,2A,31,2F, C0,21,CF,2D,5A,11,F5,F2,FB, C0,CD,41,44,2C,1A,E1,43,51, C0,CA,D0,5C,4B,23,16,B1,FB, C0,4C,6C,1F,E4,B0,5C,5C,1D, C0,CE,54,D1,C3,E5,F0,5A,0E, C0,F2,C5,E4,CC,21,6F,12,BF, C0,46,E0,B3,F4,2B,4A,A1,06, C0,E6,BF,FA,03,51,F2,AF,C5, C0,3D,1D,4F,40,E2,A0,24,1E, C0,3A,2C,C3,43,10,ED,1B,54, C0,FE,40,B3,D1,5C,22,23,A1, C0,E1,DC,6E,5D,E5,C0,93,4C, C0,3C,1D,02,F6,DC,31,10,C5, C0,CD,EF,5F,E2,D4,CC,61,FD, C0,E5,DF,0C,5A,F1,F6,B1,6E, C0,FC,E4,D3,E0,6C,E6,3C,B3, C0,1F,60,E4,9C,E3,1A,35,1C, C0,BF,13,E1,4D,EB,34,A2,10, C0,E1,4F,5C,C3,06,D2,3B,0A, C0,31,E1,15,DD,D3,FC,54,0B, C0,F2,25,BF,31,FF,42,CB,04, C0,F0,D4,1D,E0,4C,C5,20,B3, C0,F2,2A,F4,2B,15,FD,B3,3B, C0,3F,5E,02,E5,BF,6F,EF,41, C0,FD,B3,52,B4,3B,BD,52,B2, C0,16,EE,31,1A,F4,FA,14,02, C0,AD,33,0B,50,BD,06,CD,32, C0,3C,44,0B,D5,50,D5,1F,CD, C0,30,5C,01,DC,B4,2F,EF,4B, C0,36,1B,A2,4D,C3,12,BD,30, C0,5F,D3,C4,CE,6D,00,02,A2, C0,31,0B,22,00,5F,F0,FE,33, C0,1C,14,2F,B2,2E,2D,50,04, C0,D4,BD,21,52,4E,B1,FF,4E, C0,10,14,1B,A2,3C,E3,4C,E6, C4,FA,C1,64,0E,A0,C6,21,0C, C0,4F,14,BB,F5,12,53,DA,C3, C0,4E,A1,4E,04,3B,C3,F4,2D, C0,2B,24,ED,C2,54,EF,FA,14, C0,60,AF,E0,54,1B,F1,E6,5C, C0,CD,15,2E,AE,3F,21,AD,F5, C0,3E,BD,25,14,0B,E2,43,DB, C0,02,13,F1,BE,4F,22,CD,D3, C0,4D,B1,F1,F2,52,DE,22,CD, C0,42,E4,0D,FB,F4,33,ED,BD, C0,34,2C,C0,F4,54,CC,11,4F, C0,02,E4,0E,DD,13,32,1B,C3, C0,54,F0,FB,05,52,AD,01,20, C0,22,DF,00,2D,04,12,DB,F2, C0,01,42,CC,1D,33,0D,F2,CE, C0,3F,1A,F3,F5,E2,5C,E1,0D, C0,15,2E,D1,CC,34,0D,11,E1, C0,04,C0,1D,4F,B2,30,FF,0F, C0,E3,0E,5C,F2,C1,2E,40,EC, C0,B2,31,32,BB,0F,33,BE,40, C0,3D,F3,D0,4D,01,D4,3E,BC, C0,03,44,2C,C0,B2,4D,12,E4, C0,DC,34,02,D2,0B,14,0F,DF, C0,4F,21,C0,FF,E3,30,22,C1, C0,2B,13,E3,F2,FB,E4,FF,10, C0,2C,B2,4E,C4,CF,4D,20,CF, C0,0F,42,02,D1,4D,E4,ED,40, C0,0F,C2,3F,5F,E4,FE,4D,D4, C0,DD,41,13,D2,4D,D3,00,4D, C0,D2,C0,10,40,C0,E4,0F,0D, C0,4C,E4,E3,FD,3F,C1,00,4E, C0,13,DE,2B,F2,CD,0F,3E,F4, C0,FD,E2,22,FE,30,CE,3D,23, C0,C0,3E,D1,E0,3C,F3,F5,FE, C0,3E,D2,1D,3F,C2,FD,3F,E4, B0,EA,5F,6E,92,3E,17,DF,7B, B0,A1,7D,B6,42,2A,A5,59,35, C0,D0,2F,24,EE,32,11,C0,1D, B0,6D,D6,FB,25,90,6B,44,AF, B0,6D,B5,F0,6C,C5,3E,EB,24, B0,A3,5D,4C,E5,30,B4,FE,61, B0,FA,12,A6,2F,10,E0,6A,E5, B0,A3,39,F2,1D,33,C1,2C,24, B0,A1,0F,DD,5F,F3,AE,51,B3, B0,5B,C5,BD,4E,F2,4F,01,B1, B0,43,E1,2A,04,A3,31,E2,00, B0,0C,20,14,CD,42,CE,4C,13, B0,BF,5F,B0,5E,14,DF,20,CE, B0,4E,D4,0D,D4,FE,4E,C3,0E, B0,E4,FE,5C,D3,E0,E3,1C,30, B0,C2,3D,E3,D1,2E,04,1D,E4, B0,FF,11,4F,2D,E5,1E,30,FE, B0,3F,F4,CD,42,0E,0D,03,C0, B0,4E,00,0F,20,C1,41,E0,3C, B0,13,D2,3F,01,1C,12,C1,3F, B0,F2,1C,13,C0,3E,04,0D,14, B0,E1,40,F0,1D,F4,FD,32,E3, B4,CD,34,DD,42,A2,4A,15,CD, A0,06,FB,7B,F7,FA,06,0B,5D, A0,D6,E9,05,09,30,D6,4C,D5, A0,19,32,A4,4A,B5,3B,15,B2, A0,6B,B5,4B,D5,DD,61,B2,5E, A0,B4,FB,52,BE,43,E4,0B,43, A0,CD,34,DB,3E,E4,0C,14,FB, A0,03,E0,1D,E3,3C,E5,1C,01, A0,C1,40,C4,3C,E4,01,4F,D3, A0,3F,E3,2D,14,ED,30,DF,21, 90,D3,1C,64,C9,E7,12,29,15, 90,0D,D3,3F,3D,D3,20,C1,5C, 94,13,E2,03,DE,30,C3,2F,C2, 80,7E,C5,1A,26,CD,5F,05,1B, 80,D2,3C,F2,12,1F,C0,4F,E0, 70,44,DD,0E,44,DC,24,0C,20, 74,C6,0C,22,FD,13,D1,2E,F3, 65,1C,D3,1C,22,EF,21,FF,1F
$DF:B711             db 00,00,00,00,00,00,00,00,00, B0,DC,E0,35,31,ED,DF,20,FE, B4,05,40,A9,F2,66,0A,91,46, C4,1C,D1,22,2F,CD,13,31,FD, C0,DD,03,41,DD,03,3F,CD,F2, C8,FC,E3,30,0E,0E,02,30,DD, C4,D0,33,0C,D1,32,1F,ED,01, C4,22,1E,C0,33,0D,CF,44,1C, C0,BC,04,4E,BF,1F,14,1D,CF, C0,34,1C,E2,41,CB,E2,41,DE, B0,FC,16,5D,A0,44,EC,D0,31, B0,DA,05,61,AC,22,BC,16,5F, B0,BC,F0,30,AA,E3,52,23,CA, C0,01,ED,F1,43,FB,D1,41,CD, C0,F1,1C,F3,EE,34,2D,C0,43, C0,EC,F4,51,CD,03,1B,C1,21, C8,1F,00,F4,2C,C1,33,0C,D1, C0,F2,41,CC,04,4F,D0,12,30, C4,FF,F4,3F,CE,14,2D,CF,34, C0,51,CD,14,30,ED,E2,42,EC, C0,E2,42,EC,E2,42,DC,05,50, C0,CD,14,3E,CD,04,41,CC,04, C8,CC,04,40,CC,15,3D,BE,44, C4,41,DC,03,41,DB,F4,50,BC, C0,E3,52,DB,D2,53,DA,D2,53, C0,EC,F3,41,ED,04,40,CC,04, C4,0C,D0,33,0D,D0,43,DC,02, C0,25,3E,BD,14,3F,CD,24,2E, C0,DE,35,1C,C0,44,0C,CF,33, C0,FC,DE,24,0D,E0,10,CE,0F, C0,34,1C,BE,23,0E,CE,33,FD, C0,E0,44,FC,E1,54,FC,E2,53, C0,DA,E2,40,BE,22,34,0C,CF, C8,1F,CC,35,2E,BE,23,5E,BD, C0,BD,03,3F,BC,02,54,FC,D0, C0,35,2D,DF,24,FC,12,12,FB, C0,E1,F1,22,1D,CF,24,3F,CD, B0,15,2C,05,39,E4,DD,E2,66, C4,CD,01,53,EB,E2,40,D0,20, C4,D1,30,DD,24,30,BB,15,40, C4,CB,05,4F,BC,24,3F,CD,04, C4,4F,BE,31,12,0B,C2,43,0C, C4,C1,53,FB,D2,51,CC,45,0C, C0,CD,F3,40,BC,24,30,BB,04, C0,4E,BF,35,4D,BE,05,4D,CD, C0,15,0C,E2,64,CB,E3,62,BB, C0,E4,5F,BD,26,3B,BE,35,0D, C0,BC,45,1C,AE,42,0D,C4,43, C0,1B,E2,33,EA,F2,F0,E0,20, C0,2E,E3,20,0E,14,FC,EF,30, C0,DF,02,2D,DF,F4,3B,D1,34, C0,DD,13,51,CD,04,5E,B0,22, C0,DC,12,2E,CF,23,41,BE,11, B0,FB,35,1F,CD,02,23,D0,0B, C0,2E,F3,DF,23,2D,B3,52,FB, C0,E2,35,1B,B0,42,DD,E0,32, C4,FE,D2,51,BA,35,30,BD,33, C0,22,FE,22,0D,C1,41,EF,34, C0,2D,CC,16,2B,B0,66,0B,CF, C0,54,0B,B1,52,FC,05,3F,CB, C0,05,50,BD,35,4D,AE,13,4F, C0,D1,10,CD,41,ED,13,C1,5E, C0,B2,64,EA,E3,5F,AD,E3,63, C0,DD,36,2B,D3,62,AC,F2,63, C0,ED,D2,6F,FF,C0,D3,4D,DE, C0,F4,FA,22,30,B0,D1,5F,FD, C0,D5,53,E9,F6,51,AD,51,30, C0,AF,BF,62,F3,CC,11,6E,AE, C0,F5,4C,0F,C6,3D,DB,42,B2, C0,2D,EC,45,CE,31,1C,26,CE, C0,2F,2F,12,A0,62,FE,E3,FE, C0,5B,C3,23,BB,52,E1,03,2B, C0,30,B2,F2,2C,22,EF,DE,41, C0,22,AC,F0,5F,D0,D2,3F,1F, C0,B0,F1,4D,03,04,CC,41,0C, C0,07,3B,D3,50,B4,4C,CF,53, C0,AD,43,EB,35,BA,14,3D,E7, C0,2A,D4,6D,B4,6F,AD,12,F3, C0,6F,CB,17,0B,C1,52,B2,3D, D0,0F,31,CE,02,2D,F3,FD,E0, D0,30,D0,12,1D,22,E0,12,FC, C0,04,EB,F4,71,F1,9F,31,3A, C0,C4,34,EB,33,24,BB,1E,3F, C0,D7,0F,5E,EC,C5,3B,CE,23, C0,A0,53,2C,34,9E,1F,F0,34, C0,DD,2B,11,25,BC,01,50,A1, C0,DB,43,2E,A3,22,4B,E3,05, C0,19,03,10,9E,53,6E,01,9C, C0,F2,7F,9F,54,FA,46,00,A3, D0,2D,03,20,F1,3F,E1,E1,00, C0,3A,06,FB,DF,51,B4,FB,00, C0,61,B3,52,EA,F4,21,EA,F1, C0,23,C3,63,1C,EF,AD,45,3D, C0,90,01,0A,45,2E,B1,50,F5, C0,0D,CD,60,AD,06,41,42,AC, C0,14,5E,BD,C2,56,3C,C1,53, C0,CB,D1,25,2F,FA,05,60,9B, C0,05,1B,E4,32,52,DA,D4,4F, C0,AE,60,AF,66,0A,16,0D,0D, C0,CF,45,D9,DD,02,36,0B,F0, C0,46,3E,AD,46,2B,A1,55,0A, C0,B4,5F,BC,EF,E1,43,4D,F4, C0,04,0A,DB,D3,55,EA,F4,30, C0,91,50,0C,B0,CF,63,1D,C6, C4,AA,60,33,B2,DA,5F,34,A1, C0,0A,00,D4,02,7F,D1,06,FA, C0,12,53,AC,FF,61,C2,C1,72, C0,3C,A4,10,1B,25,D5,2C,1C, C0,14,D3,2E,3D,E3,9F,1C,4E, C0,06,D1,4D,50,B3,CE,2E,64, C0,F5,DF,5A,F0,B5,EE,6F,33, C0,D6,FA,2A,E1,C5,3F,5F,25, C0,A0,0A,1C,04,D5,5F,2C,D3, C0,D1,1C,51,06,E0,19,10,E2, C0,BF,40,42,F5,F1,2A,FF,06, C0,DC,1C,1E,A2,D0,4D,35,06, C0,EB,0B,DF,D4,30,4F,16,DF, C0,FA,2F,E2,D2,51,62,B2,DD, C0,1A,F2,24,F2,60,CE,C2,1C, C0,30,F0,C3,51,EC,C0,01,64, C0,41,BF,20,CA,EF,FF,24,52, C4,E3,FF,EF,0C,21,32,B3,40, C4,FD,C1,20,0C,12,32,C2,4D, C4,CF,FF,12,2F,01,32,DD,0C, C0,F2,2D,A3,61,BB,13,FD,2E, C0,01,36,ED,EE,4E,C4,0B,E0, C0,52,AE,03,61,1F,B3,FC,0B, C0,E1,F3,FE,6F,13,D5,4D,ED, C0,E4,DC,0E,52,05,E1,7C,E3, C0,CF,DA,11,46,20,CE,73,CC, C0,AE,1F,34,45,FC,CC,44,F0, C0,CD,2D,E2,13,1F,30,44,BF, C4,20,4A,B1,23,1C,41,22,AF, C0,DA,F3,31,CC,31,FE,26,FA, C0,BC,25,30,F0,3F,CC,B0,02, C4,3B,14,DD,C3,5F,FE,24,EE, C0,2C,C0,F3,F1,3F,20,D1,01, C0,6D,B2,25,EB,4F,EE,B3,40, C0,2C,E6,43,FA,42,D0,A1,2A, C0,FF,D4,11,4D,34,03,BD,0C, C0,0F,C2,20,4C,04,F1,AB,11, C0,41,B2,3C,1D,06,EE,DC,54, C0,22,D1,3B,F0,E5,FF,5F,21, C0,B1,DE,3E,24,C2,30,6F,C0, C0,AF,1D,30,06,FD,3E,31,9F, C0,23,3B,16,DE,0B,4F,C4,BF, C0,51,5F,F7,EC,2E,30,92,FF, C0,61,FD,A2,43,4D,E2,A0,1C, C0,51,05,CF,1B,1E,D5,04,5B, C0,F1,06,DE,5E,FD,B2,02,5D, C0,35,E2,CE,6F,EE,C4,0E,2A, C0,05,E3,EC,60,CE,C3,0C,3F, C0,27,03,1A,1C,CF,D5,51,0D, C0,F6,11,1C,2E,B0,F4,41,41, C0,F0,AD,FD,45,31,CE,1F,0C, C0,BF,E2,2D,34,22,CD,01,1D, C0,E2,11,0B,02,12,CD,12,3D, C0,E4,13,2C,12,DF,CE,31,2F, C0,D3,F0,4D,15,F0,EA,FC,E2, C0,05,3E,1C,C4,CE,3C,22,F4, C0,B0,3C,41,A1,DF,4A,E2,E5, C0,11,70,21,90,DA,2D,F3,F5, C0,4F,4E,D0,A0,1E,3E,E6,03, C0,4C,20,E3,C0,3D,31,E5,DF, C0,4B,00,D4,EF,3C,34,E6,1E, C0,4A,D0,B2,EE,5F,35,C2,E9, C0,2B,D3,06,2B,2F,15,A1,2B, C0,3C,D5,14,0C,52,F4,BF,19, C0,2F,E5,DF,0C,54,02,C0,5D, C0,10,E6,0D,0B,12,03,FE,4D, C0,C1,C2,30,50,E5,00,EB,3F, C0,C3,E1,60,42,AE,EF,1D,26, C0,24,1C,4F,AF,AE,22,3E,05, C0,41,FC,F0,BD,DF,32,3F,D0, B0,13,1E,06,1A,CD,30,0F,A0, C0,24,2E,DE,10,00,FF,44,FF, C0,DF,1B,D0,24,FE,2F,03,CE, C0,20,4F,A0,02,3D,23,E1,1B, C0,00,C3,DD,41,12,E1,0B,12, C0,E3,10,6E,F5,D0,FA,20,F6, C0,1D,3F,04,A0,2C,4F,E5,DF, C0,5C,04,C2,1C,60,F4,B1,3A, C0,11,D5,1F,6E,B2,D2,5D,2F, C0,C6,0C,2D,F5,DF,3E,52,A1, C0,0F,5D,E4,C1,29,E1,E5,FE, C0,6E,04,A0,2C,43,E4,FE,6D, C0,F4,C2,0A,2E,C3,E0,5E,24, C0,B2,1D,5E,D4,CE,2D,04,23, C0,3D,10,C2,DC,1E,F4,2F,3E, C0,C3,CE,2D,41,C4,0D,4D,C3, C0,CE,3C,10,B4,0C,3E,17,EC, C0,2E,05,EE,0E,31,C3,21,5F, C0,B2,FC,3E,E4,E1,4B,01,C4, C0,1B,1F,F6,EF,5E,24,B1,FB, C0,3E,E4,F1,5D,15,D0,0A,1F, C0,D3,FF,5F,15,EE,1B,F2,D3, C0,3F,51,E4,DC,3D,E3,D1,4D, C0,33,E5,FC,2B,E4,CF,3C,33, C0,C4,0E,5C,C1,A0,4E,13,D4, C0,3B,1F,E5,DC,3F,06,ED,5E, C0,F4,B0,3D,42,C5,2F,4B,F5, C0,B0,1B,31,D5,1E,61,14,CD, C0,1C,E2,0F,41,F6,FF,5C,03, C0,A1,2D,53,D5,0B,3D,F4,C2, C0,3C,31,A3,2C,3F,E4,CC,1D, C0,23,C1,2D,44,E0,0E,21,D2, C0,1F,4E,D5,EE,5D,F5,DF,2A, C0,12,C3,EC,5E,05,CF,2B,24, C0,E3,1C,21,E5,2D,43,C1,0B, C0,4F,C5,DE,4B,04,B2,2B,40, C0,C5,ED,5D,04,B1,2D,4F,C3, C0,EE,3F,01,E1,0D,DE,12,0E, B0,04,F0,3E,D2,1F,DF,21,44, C0,D0,1F,0F,01,E1,2D,13,F4, C0,1E,2E,1F,B3,FE,40,12,D2, C0,FE,5D,E3,D0,20,2F,04,E0, C0,0C,3E,03,B2,3B,31,A2,FF, C0,4C,03,C2,2B,25,0E,31,C2, C0,0E,4C,E3,C3,3B,22,B1,1D, B0,3E,F1,C5,EB,61,FE,A5,CF, C0,5D,04,D1,2D,2F,F5,CD,2F, C0,31,03,C2,2B,40,C4,01,4D, C0,23,C2,2C,F1,EC,11,C2,31, C0,3F,E2,DE,3D,05,ED,3F,F3, C0,F1,2D,E0,F1,3F,F5,2D,30, C0,D3,F0,4D,F3,F3,2C,E2,1B, C0,04,D1,2C,42,B3,0E,6E,D6, C0,FC,4F,E6,FC,4E,D4,F0,6F, C0,D4,0B,32,D5,1C,40,D5,0E, C0,4C,C4,1C,13,E4,3A,21,C5, C0,EB,5E,C3,CD,52,21,1D,F4, C0,D0,1C,41,A2,2D,42,D3,1F, C0,FF,1F,13,32,EE,30,E5,FD, C0,5F,C3,10,0C,13,DF,1F,03, C0,2C,13,C3,4B,01,D4,EA,22, C0,F0,3E,E6,DD,6D,D4,C0,4A, C0,04,B2,5B,04,BE,50,04,F1, C0,5C,E5,CF,4B,F4,EE,43,0D, C0,01,03,DE,4F,05,CC,4D,D5, C0,DE,5E,D4,EF,5D,F4,BE,4F, C0,DF,01,01,1D,32,B3,1B,30, C0,B4,0B,51,D5,FC,6F,C4,EF, C0,5C,C4,0C,12,E3,3C,F3,FE, C0,21,01,EE,43,B1,2B,30,B3, C0,1C,3F,E3,CE,4F,DF,31,E2, C0,EE,3F,F2,F2,3C,F2,ED,23, C0,D2,3B,15,C0,4C,14,D2,3C, B0,A5,49,E2,A2,5D,03,04,54, C0,EE,1B,E2,E0,1D,34,34,D0, C0,2C,40,B3,FB,24,3F,F4,D0, C0,4A,F2,B0,40,12,2D,E5,1C, C0,20,A4,2B,03,D1,6E,E5,DD, C0,60,C0,DF,02,3D,14,D2,4B, C0,15,BD,53,DF,2E,14,EF,40, C0,D3,3C,03,EF,5F,C3,0C,12, C0,10,FF,D2,3D,22,B2,5E,F2, C0,ED,23,0E,0D,E3,1D,23,C2, C0,5D,14,BC,43,DC,1F,F5,EC, C0,5E,D6,EB,4F,C1,22,E0,2E, C0,45,E0,FC,22,DD,F1,FE,41, C0,C2,2C,21,B0,1D,12,D0,1E, C0,10,35,ED,1D,E4,0E,10,E2, C0,2D,13,CF,4F,E1,FF,02,1E, C0,12,E3,3C,13,CD,2F,D0,0F, C0,F3,3E,D1,0F,4F,C3,0C,31, C0,C1,1D,03,2F,E3,0D,30,B2, C0,2D,35,DC,20,C2,3D,E3,EE, C0,30,E1,FE,23,0E,F0,C1,5E, C0,B0,2F,33,CF,2D,15,DC,00, C0,03,4F,B2,2B,11,B1,3D,F4, C0,1F,13,DD,6F,B2,2D,23,F1, B0,3B,F6,2D,F5,2C,55,CC,6A, C0,C4,1C,F0,E1,3E,D4,1C,32, C0,C1,2E,12,1F,E3,FD,3F,D3, C0,FC,34,0D,13,D0,5F,D3,FC, C0,11,F0,2F,F5,1B,F3,EE,31, C0,CF,4D,D4,0D,30,B3,5E,D1, C0,0C,35,DD,51,B2,3C,02,C0, C0,5E,D3,0C,14,1D,F2,EE,31, C0,D1,1D,34,DE,2F,D2,4F,D3, C0,3C,04,ED,20,E3,2C,E3,0E, B0,56,BD,6F,D5,1B,11,BF,31, B0,F0,ED,32,E0,1E,D1,2C,D5, B0,0B,33,C1,3B,F5,ED,42,CD, B0,54,9F,7B,D5,DE,50,B1,3D, C0,F3,2D,00,D0,10,11,D1,4E, B0,D5,CB,4F,15,0B,C1,0C,55, C0,CE,1F,00,EF,01,00,1E,E1, B0,11,21,1D,03,E1,EE,1B,15, C0,02,0C,12,F1,00,1F,12,F0, A0,3B,05,EF,72,A0,10,5C,F6, B0,E2,39,F4,E1,1C,23,EF,01, B0,1E,F2,2F,03,DB,4F,B3,0F, B0,4F,E0,F3,FB,30,B5,4C,12, B0,D2,2F,2E,D4,0D,3F,B3,1E, B0,30,DF,D2,3C,F1,D3,3F,10, B0,FF,D0,32,10,FC,F5,0C,11, B0,E2,2E,E3,FC,22,D1,3D,D1, A0,10,FF,1F,56,9C,3C,F4,F1, A0,62,BF,41,EE,EF,11,2E,F2, A0,E1,30,C0,5D,E0,C0,3E,E2, B0,F1,2F,00,E3,4E,01,E4,3A, B0,F3,CE,3F,F3,0E,F0,0E,12, B0,DF,40,D1,2E,15,0E,30,D0, A0,01,3F,00,E2,2E,03,DB,45, B0,DF,3E,04,E0,1D,10,F5,EB, B0,4E,D6,FA,32,E2,21,EF,2D, B0,E3,FF,2F,00,11,E2,3F,03, B0,F0,4F,E2,10,0F,21,C1,3F, B0,11,F0,24,0D,1E,E5,FF,5E, B0,D1,D1,1E,41,F2,C1,4A,14, B0,A3,6B,03,C1,2D,1F,03,D0, B0,3C,13,C2,1D,4F,B4,1B,21, B0,C2,3D,02,0F,01,F0,31,01, A0,2E,D0,20,03,CD,60,B2,10, 90,1C,03,3C,F3,23,BF,4F,0F, A0,FF,FF,11,DF,30,E3,FC,41, A0,C3,2B,E3,0E,22,EF,2E,E4, A0,0C,21,D1,30,C1,1E,41,C2, B0,0F,1F,13,D0,3E,14,CF,2C, A0,14,C5,1A,41,B5,FB,62,BF, A0,32,D0,3F,03,F9,17,CD,6E, A0,A4,2B,24,DF,4E,B2,2E,3F, A0,E6,11,09,25,D0,00,3E,10, A0,A4,4A,01,D4,2F,FE,6F,B7, B0,0E,2F,E0,11,DF,3D,E5,EB, A0,51,92,3B,D5,2B,03,F0,42, B0,D0,3E,E1,0F,00,FD,13,CE, B0,5E,D3,EB,11,EF,10,F1,1E, A0,E5,1B,12,CF,3F,C1,4E,C0, A0,FE,31,D1,20,F1,3D,C5,FA, A0,52,D4,0C,20,02,B1,4E,22, A0,B0,6D,E4,BD,31,0F,01,FF, A0,2F,04,DF,2F,30,D2,FF,3D, A0,D1,EE,0F,21,D2,1C,13,DF, A0,3E,D3,3D,03,E0,6E,B4,2D, 90,12,DE,46,CD,7E,E5,DC,45, 90,E0,5E,B0,32,F3,3B,F2,15, 90,0B,21,16,BD,7E,F5,EE,61, 90,D0,E1,4F,FE,D5,3B,31,B2, A0,0F,1D,E4,00,2D,03,D0,1C, A0,34,E0,1E,15,0C,01,F1,10, 90,22,21,04,3A,D4,3F,F2,E3, A0,2D,F1,F1,0F,20,02,D0,40, A0,F0,2E,B3,3C,32,A3,5D,03, A0,1F,03,FE,50,B2,2F,02,EF, A0,51,E2,2E,EF,F0,23,ED,21, 90,0E,E4,0E,30,B1,1B,04,CC, A0,50,A3,3C,F3,0D,12,DF,3D, A0,F6,DC,40,E1,11,F0,2E,F1, A0,F2,1F,1E,E2,DD,40,D2,0E, 90,41,C1,2F,EE,1F,D2,0E,2E, 90,B5,39,22,B0,12,0D,1F,D6, 90,09,41,F4,EC,11,2F,D3,2C, 90,23,BF,3F,D0,FF,26,0A,03, A0,00,1E,04,0E,2E,E1,E1,40, 90,21,BF,11,31,D0,31,0F,DE, 90,03,40,B0,4C,D3,E2,6D,E2, 90,01,5F,BF,41,D1,F1,7F,C3, 90,FE,4E,D5,2F,FE,02,34,DF, 90,5D,E5,EB,32,04,0E,20,11, 90,D3,6E,01,B2,40,0F,12,E1, 80,6D,0E,B4,62,DA,27,02,3B, 80,D5,21,0C,20,B1,24,6E,AF, 90,12,FF,3F,D4,3B,F3,DE,50, 90,B4,3A,02,D0,FF,20,F2,EF, 90,2D,D2,2F,D0,0E,23,FC,05, 90,EC,6F,A7,3A,35,CE,2F,D3, 90,5C,C6,2C,01,EF,42,C2,3D, 80,01,01,BF,2E,16,EE,21,1F, 90,10,F3,1D,12,00,03,2E,F0, 90,E0,41,C0,2C,15,DF,2C,04, 90,F0,1E,32,C0,2E,FF,01,F1, 90,1F,32,BF,3F,02,00,0E,00, 90,E1,1E,22,CF,30,F1,20,F2, 90,0C,24,DD,0F,F0,10,F2,2E, 80,04,DF,50,C2,4E,D3,2E,13, 80,EE,51,B3,2C,20,C3,0D,2E, 80,F4,EF,2E,12,E1,1F,31,E1, 70,F1,5D,E3,E2,59,C5,EF,5D, 70,D5,1B,F4,FC,20,A3,4A,05, 70,E0,3D,D1,20,F2,1E,23,DF, 60,4B,F7,0D,21,F1,11,FE,20, 50,94,39,14,B2,5D,F0,F0,02, 40,49,F5,FF,F1,2D,02,E0,30, 31,EF,F3,31,3B,C6,1E,32,F0
$DF:C4A3             db FF,FF

; Instrument table
$DF:C4A5             dw 0054, 6C90,
                        18,E0FF,B8,C002, 19,E0F8,B8,0005, 1A,E0FF,B8,2003, 1B,F2FF,B8,D002
                        1C,F2FF,B8,D002, 1D,F2FF,B8,D002, 1E,F2FF,B8,D002, 1F,F2FF,B8,D002
                        20,F2FF,B8,D002, 21,F2FF,B8,D002, 22,F2FF,B8,D002, 23,F2FF,B8,D002
                        24,E0FF,B8,D002, 25,E0FF,B8,0006

; Note length table
$DF:C4FD             dw 0018, 5800,
                        32,65,7F,98,B2,CB,E5,FC,
                        19,32,4C,65,72,7F,8C,98,A5,B2,BF,CB,D8,E5,F2,FC

; Trackers
{
$DF:C519             dw 0FBE, 5828

; Tracker pointers
$DF:C51F/$582A       dw 582A

; Tracker 0 commands
$DF:C51F/$582A       dw 5842,
                        5852,
                        5882,
                        58A2,
                        5892,
                        58D2,
                        58B2,
                        58C2,
                        58E2,
                        00FF,582A,
                        0000

; Track pointers
$DF:C537/$5842       dw 58F2, 5920, 594D, 5965, 598C, 59A8, 0000, 0000
$DF:C547/$5852       dw 59BF, 5A1F, 5A2E, 5A51, 5A71, 5A91, 5ABD, 0000
$DF:C557/$5862       dw 5ADB, 5B29, 5B6D, 5BAB, 5BEC, 0000, 0000, 0000
$DF:C567/$5872       dw 5C13, 5C39, 5C48, 5C58, 5C99, 5CDA, 5CED, 0000
$DF:C577/$5882       dw 5D04, 5D3E, 5D80, 5DE9, 5E23, 5E66, 0000, 0000
$DF:C587/$5892       dw 5E8B, 5EC5, 5EE5, 5F3A, 5F77, 5FB4, 0000, 0000
$DF:C597/$58A2       dw 5FD9, 6000, 6042, 609D, 60DE, 6120, 0000, 0000
$DF:C5A7/$58B2       dw 6145, 6156, 6161, 616C, 6177, 0000, 0000, 0000
$DF:C5B7/$58C2       dw 6183, 61A1, 61BC, 61E6, 6210, 6228, 0000, 0000
$DF:C5C7/$58D2       dw 6254, 627D, 62BE, 631F, 6362, 639F, 0000, 0000
$DF:C5D7/$58E2       dw 63C4, 63EA, 63F9, 6409, 6428, 6447, 645A, 0000

; Tracker 0, track set $5842, track 0 commands
{
$DF:C5E7/$58F2       db FA,26,       ; Percussion instruments base index = 26h
                        E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        80,          ; Note C_1
                        C8,          ; Tie
                        EF,646E,01,  ; Repeat subsection $646E 1 time
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,3C,D2,    ; Dynamic volume over 3Ch tics with target volume multiplier D2h / 100h
                        88,          ; Note Ab_1
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        80,          ; Note C_1
                        C8,          ; Tie
                        EF,646E,01,  ; Repeat subsection $646E 1 time
                        00
}

; Tracker 0, track set $5842, track 1 commands
{
$DF:C615/$5920       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        98,          ; Note C_3
                        0C,          ; Note length = Ch tics
                        9D,          ; Note F_3
                        C9,          ; Rest
                        60,          ; Note length = 60h tics
                        9F,          ; Note G_3
                        18,2F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 7Fh / 100h
                        98,          ; Note C_3
                        9D,          ; Note F_3
                        EF,647D,01,  ; Repeat subsection $647D 1 time
                        60,          ; Note length = 60h tics
                        C9,          ; Rest
                        0C,2F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 7Fh / 100h
                        98,          ; Note C_3
                        C9,          ; Rest
                        9D,          ; Note F_3
                        C9,          ; Rest
                        60,7F,       ; Note length = 60h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9F,          ; Note G_3
                        18,2F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 7Fh / 100h
                        98,          ; Note C_3
                        9D,          ; Note F_3
                        EF,647D,01,  ; Repeat subsection $647D 1 time
}

; Tracker 0, track set $5842, track 2 commands
{
$DF:C642/$594D       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        EF,648A,01,  ; Repeat subsection $648A 1 time
                        A4,          ; Note C_4
                        A9,          ; Note F_4
                        B0,          ; Note C_5
                        48,6F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = E5h / 100h
                        AB,          ; Note G_4
                        EF,648A,01,  ; Repeat subsection $648A 1 time
}

; Tracker 0, track set $5842, track 3 commands
{
$DF:C65A/$5965       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        87,          ; Note G_1
                        C8,          ; Tie
                        EF,64A5,01,  ; Repeat subsection $64A5 1 time
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,3C,D2,    ; Dynamic volume over 3Ch tics with target volume multiplier D2h / 100h
                        8F,          ; Note Eb_2
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        87,          ; Note G_1
                        C8,          ; Tie
                        EF,64A5,01,  ; Repeat subsection $64A5 1 time
}

; Tracker 0, track set $5842, track 4 commands
{
$DF:C681/$598C       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        82,          ; Note D_1
                        83,          ; Note Eb_1
                        82,          ; Note D_1
                        0C,          ; Note length = Ch tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        18,          ; Note length = 18h tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        EF,64B4,03,  ; Repeat subsection $64B4 3 times
}

; Tracker 0, track set $5842, track 5 commands
{
$DF:C69D/$59A8       db E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8E,          ; Note D_2
                        8F,          ; Note Eb_2
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        48,          ; Note length = 48h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        EF,64C9,03,  ; Repeat subsection $64C9 3 times
}

; Tracker 0, track set $5852, track 0 commands
{
$DF:C6B4/$59BF       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,0A,       ; Static volume with volume multiplier = Ah / 100h
                        EE,FF,64,    ; Dynamic volume over FFh tics with target volume multiplier 64h / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BC,          ; Note C_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B7,          ; Note G_5
                        B7,          ; Note G_5
                        BC,          ; Note C_6
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        B7,          ; Note G_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B7,          ; Note G_5
                        EF,64D6,02,  ; Repeat subsection $64D6 2 times
                        EF,64E7,02,  ; Repeat subsection $64E7 2 times
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        B3,          ; Note Eb_5
                        18,          ; Note length = 18h tics
                        B8,          ; Note Ab_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        BF,          ; Note Eb_6
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        0C,2F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 7Fh / 100h
                        B3,          ; Note Eb_5
                        B3,          ; Note Eb_5
                        18,          ; Note length = 18h tics
                        B8,          ; Note Ab_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        BF,          ; Note Eb_6
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        C9,          ; Rest
                        C9,          ; Rest
                        00
}

; Tracker 0, track set $5852, track 1 commands
{
$DF:C714/$5A1F       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        EF,64F6,02,  ; Repeat subsection $64F6 2 times
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $5852, track 2 commands
{
$DF:C723/$5A2E       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A4,          ; Note C_4
                        A9,          ; Note F_4
                        B0,          ; Note C_5
                        48,6F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = E5h / 100h
                        AB,          ; Note G_4
                        EF,6512,01,  ; Repeat subsection $6512 1 time
                        A7,          ; Note Eb_4
                        AC,          ; Note Ab_4
                        B3,          ; Note Eb_5
                        48,6F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = E5h / 100h
                        AE,          ; Note Bb_4
                        EF,6512,01,  ; Repeat subsection $6512 1 time
                        A7,          ; Note Eb_4
                        AC,          ; Note Ab_4
                        B3,          ; Note Eb_5
                        48,          ; Note length = 48h tics
                        AE,          ; Note Bb_4
}

; Tracker 0, track set $5852, track 3 commands
{
$DF:C746/$5A51       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8A,          ; Note Bb_1
                        C8,          ; Tie
                        EF,652D,01,  ; Repeat subsection $652D 1 time
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,14,D2,    ; Dynamic volume over 14h tics with target volume multiplier D2h / 100h
                        8B,          ; Note B_1
                        C8,          ; Tie
                        EF,652D,01,  ; Repeat subsection $652D 1 time
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $5852, track 4 commands
{
$DF:C766/$5A71       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8F,          ; Note Eb_2
                        C8,          ; Tie
                        EF,6543,01,  ; Repeat subsection $6543 1 time
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,14,D2,    ; Dynamic volume over 14h tics with target volume multiplier D2h / 100h
                        92,          ; Note Gb_2
                        C8,          ; Tie
                        EF,6543,01,  ; Repeat subsection $6543 1 time
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $5852, track 5 commands
{
$DF:C786/$5A91       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        82,          ; Note D_1
                        0C,          ; Note length = Ch tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        18,          ; Note length = 18h tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        85,          ; Note F_1
                        0C,          ; Note length = Ch tics
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        18,          ; Note length = 18h tics
                        85,          ; Note F_1
                        85,          ; Note F_1
                        86,          ; Note Gb_1
                        EF,6559,03,  ; Repeat subsection $6559 3 times
                        85,          ; Note F_1
                        0C,          ; Note length = Ch tics
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        18,          ; Note length = 18h tics
                        85,          ; Note F_1
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $5852, track 6 commands
{
$DF:C7B2/$5ABD       db E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        82,          ; Note D_1
                        82,          ; Note D_1
                        91,          ; Note F_2
                        18,          ; Note length = 18h tics
                        91,          ; Note F_2
                        91,          ; Note F_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        92,          ; Note Gb_2
                        EF,656E,03,  ; Repeat subsection $656E 3 times
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        48,          ; Note length = 48h tics
                        91,          ; Note F_2
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        91,          ; Note F_2
}

; Tracker 0, track set $5862, track 0 commands
{
$DF:C7D0/$5ADB       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        F5,01,0A,0A, ; Static echo on voices 0 with echo volume left = Ah and echo volume right = Ah
                        F7,02,0A,0A, ; Set echo parameters: echo delay = 2, echo feedback volume = Ah, echo FIR filter index = Ah
                        60,          ; Note length = 60h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,64,AA,    ; Dynamic volume over 64h tics with target volume multiplier AAh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        82,          ; Note D_1
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,3C,AA,    ; Dynamic volume over 3Ch tics with target volume multiplier AAh / 100h
                        87,          ; Note G_1
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        90,          ; Note E_2
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        8A,          ; Note Bb_1
                        C8,          ; Tie
                        ED,46,       ; Static volume with volume multiplier = 46h / 100h
                        EE,64,BE,    ; Dynamic volume over 64h tics with target volume multiplier BEh / 100h
                        82,          ; Note D_1
                        C8,          ; Tie
                        ED,46,       ; Static volume with volume multiplier = 46h / 100h
                        EE,3C,BE,    ; Dynamic volume over 3Ch tics with target volume multiplier BEh / 100h
                        87,          ; Note G_1
                        C8,          ; Tie
                        ED,46,       ; Static volume with volume multiplier = 46h / 100h
                        EE,50,BE,    ; Dynamic volume over 50h tics with target volume multiplier BEh / 100h
                        90,          ; Note E_2
                        C8,          ; Tie
                        00
}

; Tracker 0, track set $5862, track 1 commands
{
$DF:C81E/$5B29       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        60,          ; Note length = 60h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,30,DC,    ; Dynamic volume over 30h tics with target volume multiplier DCh / 100h
                        0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        9A,          ; Note D_3
                        C9,          ; Rest
                        9A,          ; Note D_3
                        C9,          ; Rest
                        9A,          ; Note D_3
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        9A,          ; Note D_3
                        98,          ; Note C_3
                        9F,          ; Note G_3
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9A,          ; Note D_3
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        EE,30,F0,    ; Dynamic volume over 30h tics with target volume multiplier F0h / 100h
                        0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        A1,          ; Note A_3
                        C9,          ; Rest
                        A1,          ; Note A_3
                        C9,          ; Rest
                        A1,          ; Note A_3
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A1,          ; Note A_3
                        9F,          ; Note G_3
                        A6,          ; Note D_4
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A1,          ; Note A_3
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
}

; Tracker 0, track set $5862, track 2 commands
{
$DF:C862/$5B6D       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        60,          ; Note length = 60h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,8B,       ; Static volume with volume multiplier = 8Bh / 100h
                        EE,30,96,    ; Dynamic volume over 30h tics with target volume multiplier 96h / 100h
                        0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        A6,          ; Note D_4
                        C9,          ; Rest
                        A6,          ; Note D_4
                        C9,          ; Rest
                        A6,          ; Note D_4
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A6,          ; Note D_4
                        A4,          ; Note C_4
                        AB,          ; Note G_4
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A6,          ; Note D_4
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        EE,30,AA,    ; Dynamic volume over 30h tics with target volume multiplier AAh / 100h
                        0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        AD,          ; Note A_4
                        C9,          ; Rest
                        AD,          ; Note A_4
                        C9,          ; Rest
                        AD,          ; Note A_4
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AD,          ; Note A_4
                        AB,          ; Note G_4
                        B2,          ; Note D_5
}

; Tracker 0, track set $5862, track 3 commands
{
$DF:C8A0/$5BAB       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        60,          ; Note length = 60h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,64,AA,    ; Dynamic volume over 64h tics with target volume multiplier AAh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        89,          ; Note A_1
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,3C,AA,    ; Dynamic volume over 3Ch tics with target volume multiplier AAh / 100h
                        8E,          ; Note D_2
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        95,          ; Note A_2
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        91,          ; Note F_2
                        C8,          ; Tie
                        ED,46,       ; Static volume with volume multiplier = 46h / 100h
                        EE,64,BE,    ; Dynamic volume over 64h tics with target volume multiplier BEh / 100h
                        89,          ; Note A_1
                        C8,          ; Tie
                        ED,46,       ; Static volume with volume multiplier = 46h / 100h
                        EE,3C,BE,    ; Dynamic volume over 3Ch tics with target volume multiplier BEh / 100h
                        8E,          ; Note D_2
                        C8,          ; Tie
                        ED,46,       ; Static volume with volume multiplier = 46h / 100h
                        EE,50,BE,    ; Dynamic volume over 50h tics with target volume multiplier BEh / 100h
                        95,          ; Note A_2
                        C8,          ; Tie
}

; Tracker 0, track set $5862, track 4 commands
{
$DF:C8E1/$5BEC       db E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        60,          ; Note length = 60h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8E,          ; Note D_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,          ; Note length = 18h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        48,          ; Note length = 48h tics
                        8E,          ; Note D_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,          ; Note length = 18h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        8F,          ; Note Eb_2
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        48,          ; Note length = 48h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        EF,657B,03,  ; Repeat subsection $657B 3 times
}

; Tracker 0, track set $5872, track 0 commands
{
$DF:C908/$5C13       db E5,B4,       ; Music volume multiplier = B4h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,0A,       ; Static volume with volume multiplier = Ah / 100h
                        EE,FF,64,    ; Dynamic volume over FFh tics with target volume multiplier 64h / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BC,          ; Note C_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B7,          ; Note G_5
                        B7,          ; Note G_5
                        BC,          ; Note C_6
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        B7,          ; Note G_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B7,          ; Note G_5
                        EF,64D6,02,  ; Repeat subsection $64D6 2 times
                        EF,6588,01,  ; Repeat subsection $6588 1 time
                        00
}

; Tracker 0, track set $5872, track 1 commands
{
$DF:C92E/$5C39       db EF,65E7,01,  ; Repeat subsection $65E7 1 time
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        EF,6604,01,  ; Repeat subsection $6604 1 time
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
}

; Tracker 0, track set $5872, track 2 commands
{
$DF:C93D/$5C48       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,A0,       ; Static volume with volume multiplier = A0h / 100h
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AD,          ; Note A_4
                        C8,          ; Tie
                        EF,6616,01,  ; Repeat subsection $6616 1 time
}

; Tracker 0, track set $5872, track 3 commands
{
$DF:C94D/$5C58       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        ED,46,       ; Static volume with volume multiplier = 46h / 100h
                        EE,50,BE,    ; Dynamic volume over 50h tics with target volume multiplier BEh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        87,          ; Note G_1
                        C8,          ; Tie
                        ED,50,       ; Static volume with volume multiplier = 50h / 100h
                        EE,64,C8,    ; Dynamic volume over 64h tics with target volume multiplier C8h / 100h
                        83,          ; Note Eb_1
                        C8,          ; Tie
                        ED,50,       ; Static volume with volume multiplier = 50h / 100h
                        EE,3C,C8,    ; Dynamic volume over 3Ch tics with target volume multiplier C8h / 100h
                        88,          ; Note Ab_1
                        C8,          ; Tie
                        ED,50,       ; Static volume with volume multiplier = 50h / 100h
                        EE,50,C8,    ; Dynamic volume over 50h tics with target volume multiplier C8h / 100h
                        91,          ; Note F_2
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        8B,          ; Note B_1
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,64,D2,    ; Dynamic volume over 64h tics with target volume multiplier D2h / 100h
                        83,          ; Note Eb_1
                        C8,          ; Tie
                        ED,64,       ; Static volume with volume multiplier = 64h / 100h
                        EE,3C,D2,    ; Dynamic volume over 3Ch tics with target volume multiplier D2h / 100h
                        88,          ; Note Ab_1
                        C8,          ; Tie
                        ED,64,       ; Static volume with volume multiplier = 64h / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        91,          ; Note F_2
                        C8,          ; Tie
                        C9,          ; Rest
}

; Tracker 0, track set $5872, track 4 commands
{
$DF:C98E/$5C99       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        ED,46,       ; Static volume with volume multiplier = 46h / 100h
                        EE,50,BE,    ; Dynamic volume over 50h tics with target volume multiplier BEh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        90,          ; Note E_2
                        C8,          ; Tie
                        ED,50,       ; Static volume with volume multiplier = 50h / 100h
                        EE,64,C8,    ; Dynamic volume over 64h tics with target volume multiplier C8h / 100h
                        8A,          ; Note Bb_1
                        C8,          ; Tie
                        ED,50,       ; Static volume with volume multiplier = 50h / 100h
                        EE,3C,C8,    ; Dynamic volume over 3Ch tics with target volume multiplier C8h / 100h
                        8F,          ; Note Eb_2
                        C8,          ; Tie
                        ED,50,       ; Static volume with volume multiplier = 50h / 100h
                        EE,50,C8,    ; Dynamic volume over 50h tics with target volume multiplier C8h / 100h
                        96,          ; Note Bb_2
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        92,          ; Note Gb_2
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,64,D2,    ; Dynamic volume over 64h tics with target volume multiplier D2h / 100h
                        8A,          ; Note Bb_1
                        C8,          ; Tie
                        ED,64,       ; Static volume with volume multiplier = 64h / 100h
                        EE,3C,D2,    ; Dynamic volume over 3Ch tics with target volume multiplier D2h / 100h
                        8F,          ; Note Eb_2
                        C8,          ; Tie
                        ED,64,       ; Static volume with volume multiplier = 64h / 100h
                        EE,50,D2,    ; Dynamic volume over 50h tics with target volume multiplier D2h / 100h
                        96,          ; Note Bb_2
                        C8,          ; Tie
                        C9,          ; Rest
}

; Tracker 0, track set $5872, track 5 commands
{
$DF:C9CF/$5CDA       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        EF,6644,01,  ; Repeat subsection $6644 1 time
                        EF,6559,03,  ; Repeat subsection $6559 3 times
                        85,          ; Note F_1
                        30,          ; Note length = 30h tics
                        C9,          ; Rest
}

; Tracker 0, track set $5872, track 6 commands
{
$DF:C9E2/$5CED       db EF,6654,01,  ; Repeat subsection $6654 1 time
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        91,          ; Note F_2
                        0C,          ; Note length = Ch tics
                        91,          ; Note F_2
                        91,          ; Note F_2
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        18,          ; Note length = 18h tics
                        91,          ; Note F_2
                        92,          ; Note Gb_2
                        EF,6661,03,  ; Repeat subsection $6661 3 times
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        48,          ; Note length = 48h tics
                        91,          ; Note F_2
}

; Tracker 0, track set $5882, track 0 commands
{
$DF:C9F9/$5D04       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        93,          ; Note G_2
                        94,          ; Note Ab_2
                        96,          ; Note Bb_2
                        98,          ; Note C_3
                        99,          ; Note Db_3
                        9B,          ; Note Eb_3
                        9D,          ; Note F_3
                        9E,          ; Note Gb_3
                        A0,          ; Note Ab_3
                        A2,          ; Note Bb_3
                        A4,          ; Note C_4
                        A5,          ; Note Db_4
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        EF,6672,02,  ; Repeat subsection $6672 2 times
                        EF,6685,01,  ; Repeat subsection $6685 1 time
                        00
}

; Tracker 0, track set $5882, track 1 commands
{
$DF:CA33/$5D3E       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        B1,          ; Note Db_5
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B1,          ; Note Db_5
                        18,          ; Note length = 18h tics
                        B1,          ; Note Db_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B1,          ; Note Db_5
                        AE,          ; Note Bb_4
                        B1,          ; Note Db_5
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AE,          ; Note Bb_4
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B1,          ; Note Db_5
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B1,          ; Note Db_5
                        18,          ; Note length = 18h tics
                        B1,          ; Note Db_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B1,          ; Note Db_5
                        AE,          ; Note Bb_4
                        B1,          ; Note Db_5
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AE,          ; Note Bb_4
                        C8,          ; Tie
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $5882, track 2 commands
{
$DF:CA75/$5D80       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A9,          ; Note F_4
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A9,          ; Note F_4
                        18,          ; Note length = 18h tics
                        A9,          ; Note F_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A9,          ; Note F_4
                        A7,          ; Note Eb_4
                        A9,          ; Note F_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        EE,3C,B4,    ; Dynamic volume over 3Ch tics with target volume multiplier B4h / 100h
                        B3,          ; Note Eb_5
                        B8,          ; Note Ab_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BF,          ; Note Eb_6
                        BA,          ; Note Bb_5
                        B8,          ; Note Ab_5
                        B3,          ; Note Eb_5
                        B8,          ; Note Ab_5
                        BF,          ; Note Eb_6
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        BA,          ; Note Bb_5
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,90,64,    ; Dynamic volume over 90h tics with target volume multiplier 64h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A9,          ; Note F_4
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A9,          ; Note F_4
                        18,          ; Note length = 18h tics
                        A9,          ; Note F_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A9,          ; Note F_4
                        A7,          ; Note Eb_4
                        A9,          ; Note F_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        EE,3C,B4,    ; Dynamic volume over 3Ch tics with target volume multiplier B4h / 100h
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        AE,          ; Note Bb_4
                        AE,          ; Note Bb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B7,          ; Note G_5
                        B5,          ; Note F_5
                        B1,          ; Note Db_5
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B3,          ; Note Eb_5
                        48,          ; Note length = 48h tics
                        C8,          ; Tie
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        EE,90,64,    ; Dynamic volume over 90h tics with target volume multiplier 64h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $5882, track 3 commands
{
$DF:CADE/$5DE9       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        AC,          ; Note Ab_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        AE,          ; Note Bb_4
                        AC,          ; Note Ab_4
                        A7,          ; Note Eb_4
                        AC,          ; Note Ab_4
                        B3,          ; Note Eb_5
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        EE,90,96,    ; Dynamic volume over 90h tics with target volume multiplier 96h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AE,          ; Note Bb_4
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AB,          ; Note G_4
                        A9,          ; Note F_4
                        A5,          ; Note Db_4
}

; Tracker 0, track set $5882, track 4 commands
{
$DF:CB18/$5E23       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A0,          ; Note Ab_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A0,          ; Note Ab_3
                        18,          ; Note length = 18h tics
                        A0,          ; Note Ab_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A0,          ; Note Ab_3
                        9D,          ; Note F_3
                        A0,          ; Note Ab_3
                        48,          ; Note length = 48h tics
                        9F,          ; Note G_3
                        C8,          ; Tie
                        48,78,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = FCh / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A0,          ; Note Ab_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A0,          ; Note Ab_3
                        18,          ; Note length = 18h tics
                        A0,          ; Note Ab_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A0,          ; Note Ab_3
                        9D,          ; Note F_3
                        A0,          ; Note Ab_3
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9F,          ; Note G_3
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
}

; Tracker 0, track set $5882, track 5 commands
{
$DF:CB5B/$5E66       db E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8D,          ; Note Db_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        8D,          ; Note Db_2
                        18,          ; Note length = 18h tics
                        8D,          ; Note Db_2
                        91,          ; Note F_2
                        8D,          ; Note Db_2
                        91,          ; Note F_2
                        EF,66BC,02,  ; Repeat subsection $66BC 2 times
                        EF,66C6,01,  ; Repeat subsection $66C6 1 time
                        EF,66BC,02,  ; Repeat subsection $66BC 2 times
                        8F,          ; Note Eb_2
                        87,          ; Note G_1
                        8F,          ; Note Eb_2
                        8F,          ; Note Eb_2
                        87,          ; Note G_1
                        8F,          ; Note Eb_2
}

; Tracker 0, track set $5892, track 0 commands
{
$DF:CB80/$5E8B       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        96,          ; Note Bb_2
                        97,          ; Note B_2
                        99,          ; Note Db_3
                        9B,          ; Note Eb_3
                        9C,          ; Note E_3
                        9E,          ; Note Gb_3
                        A0,          ; Note Ab_3
                        A1,          ; Note A_3
                        A3,          ; Note B_3
                        A5,          ; Note Db_4
                        A7,          ; Note Eb_4
                        A8,          ; Note E_4
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        EF,66D6,02,  ; Repeat subsection $66D6 2 times
                        EF,66E9,01,  ; Repeat subsection $66E9 1 time
                        00
}

; Tracker 0, track set $5892, track 1 commands
{
$DF:CBBA/$5EC5       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        EF,6720,01,  ; Repeat subsection $6720 1 time
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        EE,90,64,    ; Dynamic volume over 90h tics with target volume multiplier 64h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        EF,6720,01,  ; Repeat subsection $6720 1 time
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        EE,90,64,    ; Dynamic volume over 90h tics with target volume multiplier 64h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $5892, track 2 commands
{
$DF:CBDA/$5EE5       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AC,          ; Note Ab_4
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        AC,          ; Note Ab_4
                        18,          ; Note length = 18h tics
                        AC,          ; Note Ab_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AC,          ; Note Ab_4
                        AA,          ; Note Gb_4
                        AA,          ; Note Gb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AA,          ; Note Gb_4
                        AA,          ; Note Gb_4
                        AF,          ; Note B_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B6,          ; Note Gb_5
                        B1,          ; Note Db_5
                        AF,          ; Note B_4
                        AA,          ; Note Gb_4
                        AF,          ; Note B_4
                        B6,          ; Note Gb_5
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B1,          ; Note Db_5
                        48,18,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = 65h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AC,          ; Note Ab_4
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        AC,          ; Note Ab_4
                        18,          ; Note length = 18h tics
                        AC,          ; Note Ab_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AC,          ; Note Ab_4
                        AA,          ; Note Gb_4
                        AC,          ; Note Ab_4
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AA,          ; Note Gb_4
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AA,          ; Note Gb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AE,          ; Note Bb_4
                        AC,          ; Note Ab_4
                        A8,          ; Note E_4
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AA,          ; Note Gb_4
                        48,          ; Note length = 48h tics
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $5892, track 3 commands
{
$DF:CC2F/$5F3A       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        ED,82,       ; Static volume with volume multiplier = 82h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A7,          ; Note Eb_4
                        48,08,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = 32h / 100h
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B6,          ; Note Gb_5
                        BB,          ; Note B_5
                        C2,          ; Note Gb_6
                        BD,          ; Note Db_6
                        BB,          ; Note B_5
                        B6,          ; Note Gb_5
                        BB,          ; Note B_5
                        C2,          ; Note Gb_6
                        ED,78,       ; Static volume with volume multiplier = 78h / 100h
                        EE,C8,50,    ; Dynamic volume over C8h tics with target volume multiplier 50h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        BD,          ; Note Db_6
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B6,          ; Note Gb_5
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B1,          ; Note Db_5
                        B1,          ; Note Db_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B6,          ; Note Gb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        B8,          ; Note Ab_5
                        B4,          ; Note E_5
}

; Tracker 0, track set $5892, track 4 commands
{
$DF:CC6C/$5F77       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A3,          ; Note B_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A3,          ; Note B_3
                        18,          ; Note length = 18h tics
                        A3,          ; Note B_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A3,          ; Note B_3
                        A0,          ; Note Ab_3
                        A3,          ; Note B_3
                        48,          ; Note length = 48h tics
                        A2,          ; Note Bb_3
                        C8,          ; Tie
                        48,78,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = FCh / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A3,          ; Note B_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A3,          ; Note B_3
                        18,          ; Note length = 18h tics
                        A3,          ; Note B_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A3,          ; Note B_3
                        A0,          ; Note Ab_3
                        A3,          ; Note B_3
                        A2,          ; Note Bb_3
                        48,          ; Note length = 48h tics
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        48,78,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = FCh / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $5892, track 5 commands
{
$DF:CCA9/$5FB4       db E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        90,          ; Note E_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        90,          ; Note E_2
                        18,          ; Note length = 18h tics
                        90,          ; Note E_2
                        94,          ; Note Ab_2
                        90,          ; Note E_2
                        94,          ; Note Ab_2
                        EF,6736,02,  ; Repeat subsection $6736 2 times
                        EF,6740,01,  ; Repeat subsection $6740 1 time
                        EF,6736,02,  ; Repeat subsection $6736 2 times
                        92,          ; Note Gb_2
                        8A,          ; Note Bb_1
                        92,          ; Note Gb_2
                        92,          ; Note Gb_2
                        8A,          ; Note Bb_1
                        92,          ; Note Gb_2
}

; Tracker 0, track set $58A2, track 0 commands
{
$DF:CCCE/$5FD9       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        EF,6685,01,  ; Repeat subsection $6685 1 time
                        EF,6672,04,  ; Repeat subsection $6672 4 times
                        00
}

; Tracker 0, track set $58A2, track 1 commands
{
$DF:CCF5/$6000       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B1,          ; Note Db_5
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B1,          ; Note Db_5
                        18,          ; Note length = 18h tics
                        B1,          ; Note Db_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B1,          ; Note Db_5
                        AE,          ; Note Bb_4
                        B1,          ; Note Db_5
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AE,          ; Note Bb_4
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B1,          ; Note Db_5
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B1,          ; Note Db_5
                        18,          ; Note length = 18h tics
                        B1,          ; Note Db_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B1,          ; Note Db_5
                        AE,          ; Note Bb_4
                        B1,          ; Note Db_5
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AE,          ; Note Bb_4
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
}

; Tracker 0, track set $58A2, track 2 commands
{
$DF:CD37/$6042       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A9,          ; Note F_4
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A9,          ; Note F_4
                        18,          ; Note length = 18h tics
                        A9,          ; Note F_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A9,          ; Note F_4
                        A7,          ; Note Eb_4
                        A9,          ; Note F_4
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        AE,          ; Note Bb_4
                        AE,          ; Note Bb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        B5,          ; Note F_5
                        B1,          ; Note Db_5
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B3,          ; Note Eb_5
                        48,18,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = 65h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A9,          ; Note F_4
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A9,          ; Note F_4
                        18,          ; Note length = 18h tics
                        A9,          ; Note F_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A9,          ; Note F_4
                        A7,          ; Note Eb_4
                        A9,          ; Note F_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        AE,          ; Note Bb_4
                        AE,          ; Note Bb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B7,          ; Note G_5
                        B5,          ; Note F_5
                        B1,          ; Note Db_5
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B3,          ; Note Eb_5
                        48,18,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = 65h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $58A2, track 3 commands
{
$DF:CD92/$609D       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A7,          ; Note Eb_4
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AE,          ; Note Bb_4
                        A9,          ; Note F_4
                        A5,          ; Note Db_4
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A7,          ; Note Eb_4
                        48,18,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = 65h / 100h
                        C8,          ; Tie
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        EE,90,64,    ; Dynamic volume over 90h tics with target volume multiplier 64h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AB,          ; Note G_4
                        A9,          ; Note F_4
                        A5,          ; Note Db_4
}

; Tracker 0, track set $58A2, track 4 commands
{
$DF:CDD3/$60DE       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A0,          ; Note Ab_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A0,          ; Note Ab_3
                        18,          ; Note length = 18h tics
                        A0,          ; Note Ab_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A0,          ; Note Ab_3
                        9D,          ; Note F_3
                        A0,          ; Note Ab_3
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9F,          ; Note G_3
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A0,          ; Note Ab_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A0,          ; Note Ab_3
                        18,          ; Note length = 18h tics
                        A0,          ; Note Ab_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A0,          ; Note Ab_3
                        9D,          ; Note F_3
                        A0,          ; Note Ab_3
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9F,          ; Note G_3
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
}

; Tracker 0, track set $58A2, track 5 commands
{
$DF:CE15/$6120       db E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8D,          ; Note Db_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        8D,          ; Note Db_2
                        18,          ; Note length = 18h tics
                        8D,          ; Note Db_2
                        91,          ; Note F_2
                        8D,          ; Note Db_2
                        91,          ; Note F_2
                        EF,66BC,02,  ; Repeat subsection $66BC 2 times
                        EF,66C6,01,  ; Repeat subsection $66C6 1 time
                        EF,66BC,02,  ; Repeat subsection $66BC 2 times
                        8F,          ; Note Eb_2
                        87,          ; Note G_1
                        8F,          ; Note Eb_2
                        8F,          ; Note Eb_2
                        87,          ; Note G_1
                        8F,          ; Note Eb_2
}

; Tracker 0, track set $58B2, track 0 commands
{
$DF:CE3A/$6145       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        92,          ; Note Gb_2
                        92,          ; Note Gb_2
                        00
}

; Tracker 0, track set $58B2, track 1 commands
{
$DF:CE4B/$6156       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $58B2, track 2 commands
{
$DF:CE56/$6161       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $58B2, track 3 commands
{
$DF:CE61/$616C       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $58B2, track 4 commands
{
$DF:CE6C/$6177       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        48,1F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AA,          ; Note Gb_4
                        C9,          ; Rest
}

; Tracker 0, track set $58C2, track 0 commands
{
$DF:CE78/$6183       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        EF,6750,01,  ; Repeat subsection $6750 1 time
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        EF,6750,01,  ; Repeat subsection $6750 1 time
                        C8,          ; Tie
                        C8,          ; Tie
                        00
}

; Tracker 0, track set $58C2, track 1 commands
{
$DF:CE96/$61A1       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        EF,6769,01,  ; Repeat subsection $6769 1 time
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A6,          ; Note D_4
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        EF,6769,01,  ; Repeat subsection $6769 1 time
}

; Tracker 0, track set $58C2, track 2 commands
{
$DF:CEB1/$61BC       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,64,AA,    ; Dynamic volume over 64h tics with target volume multiplier AAh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        80,          ; Note C_1
                        C8,          ; Tie
                        EF,677E,01,  ; Repeat subsection $677E 1 time
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        88,          ; Note Ab_1
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,64,AA,    ; Dynamic volume over 64h tics with target volume multiplier AAh / 100h
                        80,          ; Note C_1
                        C8,          ; Tie
                        EF,677E,01,  ; Repeat subsection $677E 1 time
}

; Tracker 0, track set $58C2, track 3 commands
{
$DF:CEDB/$61E6       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,64,AA,    ; Dynamic volume over 64h tics with target volume multiplier AAh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        87,          ; Note G_1
                        C8,          ; Tie
                        EF,678D,01,  ; Repeat subsection $678D 1 time
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        8F,          ; Note Eb_2
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,64,AA,    ; Dynamic volume over 64h tics with target volume multiplier AAh / 100h
                        87,          ; Note G_1
                        C8,          ; Tie
                        EF,678D,01,  ; Repeat subsection $678D 1 time
}

; Tracker 0, track set $58C2, track 4 commands
{
$DF:CF05/$6210       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        82,          ; Note D_1
                        0C,          ; Note length = Ch tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        18,          ; Note length = 18h tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        EF,64B4,04,  ; Repeat subsection $64B4 4 times
}

; Tracker 0, track set $58C2, track 5 commands
{
$DF:CF1D/$6228       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8E,          ; Note D_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,          ; Note length = 18h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        8F,          ; Note Eb_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        48,          ; Note length = 48h tics
                        8E,          ; Note D_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,          ; Note length = 18h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        8F,          ; Note Eb_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        48,          ; Note length = 48h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        EF,679C,03,  ; Repeat subsection $679C 3 times
}

; Tracker 0, track set $58D2, track 0 commands
{
$DF:CF49/$6254       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        EF,66E9,01,  ; Repeat subsection $66E9 1 time
                        EF,66D6,04,  ; Repeat subsection $66D6 4 times
                        00
}

; Tracker 0, track set $58D2, track 1 commands
{
$DF:CF72/$627D       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B4,          ; Note E_5
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B4,          ; Note E_5
                        18,          ; Note length = 18h tics
                        B4,          ; Note E_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B4,          ; Note E_5
                        B1,          ; Note Db_5
                        B4,          ; Note E_5
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B1,          ; Note Db_5
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B4,          ; Note E_5
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B4,          ; Note E_5
                        18,          ; Note length = 18h tics
                        B4,          ; Note E_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B4,          ; Note E_5
                        B1,          ; Note Db_5
                        B4,          ; Note E_5
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B1,          ; Note Db_5
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $58D2, track 2 commands
{
$DF:CFB3/$62BE       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AC,          ; Note Ab_4
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        AC,          ; Note Ab_4
                        18,          ; Note length = 18h tics
                        AC,          ; Note Ab_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AC,          ; Note Ab_4
                        AA,          ; Note Gb_4
                        AC,          ; Note Ab_4
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B6,          ; Note Gb_5
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B1,          ; Note Db_5
                        B1,          ; Note Db_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B6,          ; Note Gb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BD,          ; Note Db_6
                        B8,          ; Note Ab_5
                        B4,          ; Note E_5
                        ED,A0,       ; Static volume with volume multiplier = A0h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B6,          ; Note Gb_5
                        48,18,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = 65h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AC,          ; Note Ab_4
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        AC,          ; Note Ab_4
                        18,          ; Note length = 18h tics
                        AC,          ; Note Ab_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AC,          ; Note Ab_4
                        AA,          ; Note Gb_4
                        AC,          ; Note Ab_4
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B6,          ; Note Gb_5
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B1,          ; Note Db_5
                        B1,          ; Note Db_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B6,          ; Note Gb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        B8,          ; Note Ab_5
                        B4,          ; Note E_5
                        ED,A0,       ; Static volume with volume multiplier = A0h / 100h
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B6,          ; Note Gb_5
                        48,18,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = 65h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $58D2, track 3 commands
{
$DF:D014/$631F       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        ED,78,       ; Static volume with volume multiplier = 78h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B6,          ; Note Gb_5
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AA,          ; Note Gb_4
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AA,          ; Note Gb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B1,          ; Note Db_5
                        AC,          ; Note Ab_4
                        A8,          ; Note E_4
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AA,          ; Note Gb_4
                        48,18,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = 65h / 100h
                        C8,          ; Tie
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        EE,90,64,    ; Dynamic volume over 90h tics with target volume multiplier 64h / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AA,          ; Note Gb_4
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AA,          ; Note Gb_4
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        AE,          ; Note Bb_4
                        AC,          ; Note Ab_4
                        A8,          ; Note E_4
}

; Tracker 0, track set $58D2, track 4 commands
{
$DF:D057/$6362       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A3,          ; Note B_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A3,          ; Note B_3
                        18,          ; Note length = 18h tics
                        A3,          ; Note B_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A3,          ; Note B_3
                        A0,          ; Note Ab_3
                        A3,          ; Note B_3
                        48,          ; Note length = 48h tics
                        A2,          ; Note Bb_3
                        C8,          ; Tie
                        48,78,       ; Note length = 48h tics, note volume multiplier = A5h / 100h, note ring length multiplier = FCh / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        EE,90,3C,    ; Dynamic volume over 90h tics with target volume multiplier 3Ch / 100h
                        C8,          ; Tie
                        C8,          ; Tie
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A3,          ; Note B_3
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        A3,          ; Note B_3
                        18,          ; Note length = 18h tics
                        A3,          ; Note B_3
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A3,          ; Note B_3
                        A0,          ; Note Ab_3
                        A3,          ; Note B_3
                        48,          ; Note length = 48h tics
                        A2,          ; Note Bb_3
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
}

; Tracker 0, track set $58D2, track 5 commands
{
$DF:D094/$639F       db E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        90,          ; Note E_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        90,          ; Note E_2
                        18,          ; Note length = 18h tics
                        90,          ; Note E_2
                        94,          ; Note Ab_2
                        90,          ; Note E_2
                        94,          ; Note Ab_2
                        EF,6736,02,  ; Repeat subsection $6736 2 times
                        EF,6740,01,  ; Repeat subsection $6740 1 time
                        EF,6736,02,  ; Repeat subsection $6736 2 times
                        92,          ; Note Gb_2
                        8A,          ; Note Bb_1
                        92,          ; Note Gb_2
                        92,          ; Note Gb_2
                        8A,          ; Note Bb_1
                        92,          ; Note Gb_2
}

; Tracker 0, track set $58E2, track 0 commands
{
$DF:D0B9/$63C4       db E5,C8,       ; Music volume multiplier = C8h / 100h
                        E7,2F,       ; Music tempo = 91.796875 tics per second
                        E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,0A,       ; Static volume with volume multiplier = Ah / 100h
                        EE,FF,64,    ; Dynamic volume over FFh tics with target volume multiplier 64h / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BC,          ; Note C_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B7,          ; Note G_5
                        B7,          ; Note G_5
                        BC,          ; Note C_6
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        B7,          ; Note G_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B7,          ; Note G_5
                        EF,64D6,02,  ; Repeat subsection $64D6 2 times
                        EF,6588,01,  ; Repeat subsection $6588 1 time
                        00
}

; Tracker 0, track set $58E2, track 1 commands
{
$DF:D0DF/$63EA       db EF,65E7,01,  ; Repeat subsection $65E7 1 time
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        EF,6604,01,  ; Repeat subsection $6604 1 time
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
}

; Tracker 0, track set $58E2, track 2 commands
{
$DF:D0EE/$63F9       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,A0,       ; Static volume with volume multiplier = A0h / 100h
                        E1,08,       ; Panning bias = 8 / 14h with no phase inversion
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A6,          ; Note D_4
                        C8,          ; Tie
                        EF,6616,01,  ; Repeat subsection $6616 1 time
}

; Tracker 0, track set $58E2, track 3 commands
{
$DF:D0FE/$6409       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,05,       ; Panning bias = 5 / 14h with no phase inversion
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        88,          ; Note Ab_1
                        C8,          ; Tie
                        EF,67AB,01,  ; Repeat subsection $67AB 1 time
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        8B,          ; Note B_1
                        C8,          ; Tie
                        EF,67AB,01,  ; Repeat subsection $67AB 1 time
                        C9,          ; Rest
}

; Tracker 0, track set $58E2, track 4 commands
{
$DF:D11D/$6428       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        E1,0F,       ; Panning bias = Fh / 14h with no phase inversion
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        8F,          ; Note Eb_2
                        C8,          ; Tie
                        EF,67C1,01,  ; Repeat subsection $67C1 1 time
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        92,          ; Note Gb_2
                        C8,          ; Tie
                        EF,67C1,01,  ; Repeat subsection $67C1 1 time
                        C9,          ; Rest
}

; Tracker 0, track set $58E2, track 5 commands
{
$DF:D13C/$6447       db E0,19,       ; Select instrument 19h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        EF,6644,01,  ; Repeat subsection $6644 1 time
                        EF,6559,03,  ; Repeat subsection $6559 3 times
                        85,          ; Note F_1
                        30,          ; Note length = 30h tics
                        C9,          ; Rest
}

; Tracker 0, track set $58E2, track 6 commands
{
$DF:D14F/$645A       db EF,6654,01,  ; Repeat subsection $6654 1 time
                        91,          ; Note F_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,          ; Note length = 18h tics
                        91,          ; Note F_2
                        91,          ; Note F_2
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        92,          ; Note Gb_2
                        EF,67D7,03,  ; Repeat subsection $67D7 3 times
                        48,          ; Note length = 48h tics
                        91,          ; Note F_2
                        00
}

; Repeated subsection
{
$DF:D163/$646E       db ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,28,D2,    ; Dynamic volume over 28h tics with target volume multiplier D2h / 100h
                        85,          ; Note F_1
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,3C,D2,    ; Dynamic volume over 3Ch tics with target volume multiplier D2h / 100h
                        8E,          ; Note D_2
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D172/$647D       db A4,          ; Note C_4
                        9F,          ; Note G_3
                        9D,          ; Note F_3
                        98,          ; Note C_3
                        9D,          ; Note F_3
                        A4,          ; Note C_4
                        60,7F,       ; Note length = 60h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9F,          ; Note G_3
                        18,          ; Note length = 18h tics
                        C8,          ; Tie
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D17F/$648A       db 18,          ; Note length = 18h tics
                        C9,          ; Rest
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A4,          ; Note C_4
                        C9,          ; Rest
                        A9,          ; Note F_4
                        C9,          ; Rest
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AB,          ; Note G_4
                        18,          ; Note length = 18h tics
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A4,          ; Note C_4
                        A9,          ; Note F_4
                        B0,          ; Note C_5
                        AB,          ; Note G_4
                        A9,          ; Note F_4
                        00
}

; Repeated subsection
{
$DF:D19A/$64A5       db ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,28,D2,    ; Dynamic volume over 28h tics with target volume multiplier D2h / 100h
                        8C,          ; Note C_2
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,3C,D2,    ; Dynamic volume over 3Ch tics with target volume multiplier D2h / 100h
                        93,          ; Note G_2
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D1A9/$64B4       db 82,          ; Note D_1
                        0C,          ; Note length = Ch tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        18,          ; Note length = 18h tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        83,          ; Note Eb_1
                        82,          ; Note D_1
                        0C,          ; Note length = Ch tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        18,          ; Note length = 18h tics
                        82,          ; Note D_1
                        82,          ; Note D_1
                        82,          ; Note D_1
                        00
}

; Repeated subsection
{
$DF:D1BE/$64C9       db 8E,          ; Note D_2
                        18,          ; Note length = 18h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        8F,          ; Note Eb_2
                        ED,D2,       ; Static volume with volume multiplier = D2h / 100h
                        48,          ; Note length = 48h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        00
}

; Repeated subsection
{
$DF:D1CB/$64D6       db 18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        B3,          ; Note Eb_5
                        18,          ; Note length = 18h tics
                        B8,          ; Note Ab_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        BF,          ; Note Eb_6
                        00
}

; Repeated subsection
{
$DF:D1DC/$64E7       db 18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        00
}

; Repeated subsection
{
$DF:D1EB/$64F6       db 60,          ; Note length = 60h tics
                        C9,          ; Rest
                        0C,2F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 7Fh / 100h
                        9B,          ; Note Eb_3
                        C9,          ; Rest
                        A0,          ; Note Ab_3
                        C9,          ; Rest
                        60,7F,       ; Note length = 60h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A2,          ; Note Bb_3
                        18,2F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 7Fh / 100h
                        9B,          ; Note Eb_3
                        A0,          ; Note Ab_3
                        A7,          ; Note Eb_4
                        A2,          ; Note Bb_3
                        A0,          ; Note Ab_3
                        9B,          ; Note Eb_3
                        A5,          ; Note Db_4
                        A7,          ; Note Eb_4
                        60,7F,       ; Note length = 60h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        C8,          ; Tie
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D207/$6512       db 18,          ; Note length = 18h tics
                        C9,          ; Rest
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        C9,          ; Rest
                        AC,          ; Note Ab_4
                        C9,          ; Rest
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AE,          ; Note Bb_4
                        18,          ; Note length = 18h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A7,          ; Note Eb_4
                        AC,          ; Note Ab_4
                        B3,          ; Note Eb_5
                        AE,          ; Note Bb_4
                        AC,          ; Note Ab_4
                        00
}

; Repeated subsection
{
$DF:D222/$652D       db ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,28,D2,    ; Dynamic volume over 28h tics with target volume multiplier D2h / 100h
                        83,          ; Note Eb_1
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,14,D2,    ; Dynamic volume over 14h tics with target volume multiplier D2h / 100h
                        88,          ; Note Ab_1
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,14,D2,    ; Dynamic volume over 14h tics with target volume multiplier D2h / 100h
                        91,          ; Note F_2
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D238/$6543       db ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,28,D2,    ; Dynamic volume over 28h tics with target volume multiplier D2h / 100h
                        8A,          ; Note Bb_1
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,14,D2,    ; Dynamic volume over 14h tics with target volume multiplier D2h / 100h
                        8F,          ; Note Eb_2
                        C8,          ; Tie
                        ED,5A,       ; Static volume with volume multiplier = 5Ah / 100h
                        EE,14,D2,    ; Dynamic volume over 14h tics with target volume multiplier D2h / 100h
                        96,          ; Note Bb_2
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D24E/$6559       db 85,          ; Note F_1
                        0C,          ; Note length = Ch tics
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        18,          ; Note length = 18h tics
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        0C,          ; Note length = Ch tics
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        18,          ; Note length = 18h tics
                        85,          ; Note F_1
                        85,          ; Note F_1
                        86,          ; Note Gb_1
                        00
}

; Repeated subsection
{
$DF:D263/$656E       db ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        48,          ; Note length = 48h tics
                        91,          ; Note F_2
                        91,          ; Note F_2
                        91,          ; Note F_2
                        18,          ; Note length = 18h tics
                        91,          ; Note F_2
                        91,          ; Note F_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        92,          ; Note Gb_2
                        00
}

; Repeated subsection
{
$DF:D270/$657B       db 8E,          ; Note D_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,          ; Note length = 18h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        8F,          ; Note Eb_2
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        48,          ; Note length = 48h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        00
}

; Repeated subsection
{
$DF:D27D/$6588       db 18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        ED,64,       ; Static volume with volume multiplier = 64h / 100h
                        EE,D8,3C,    ; Dynamic volume over D8h tics with target volume multiplier 3Ch / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        ED,3C,       ; Static volume with volume multiplier = 3Ch / 100h
                        EE,C0,64,    ; Dynamic volume over C0h tics with target volume multiplier 64h / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        B3,          ; Note Eb_5
                        18,          ; Note length = 18h tics
                        B8,          ; Note Ab_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        BF,          ; Note Eb_6
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        0C,2F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 7Fh / 100h
                        B3,          ; Note Eb_5
                        B3,          ; Note Eb_5
                        18,          ; Note length = 18h tics
                        B8,          ; Note Ab_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BA,          ; Note Bb_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B3,          ; Note Eb_5
                        BF,          ; Note Eb_6
                        ED,64,       ; Static volume with volume multiplier = 64h / 100h
                        EE,96,3C,    ; Dynamic volume over 96h tics with target volume multiplier 3Ch / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        BF,          ; Note Eb_6
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        BA,          ; Note Bb_5
                        BA,          ; Note Bb_5
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        BF,          ; Note Eb_6
                        30,          ; Note length = 30h tics
                        C9,          ; Rest
                        00
}

; Repeated subsection
{
$DF:D2DC/$65E7       db E0,18,       ; Select instrument 18h
                        F4,46,       ; Set subtranspose of 46h / 100h semitones
                        ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        E1,0C,       ; Panning bias = Ch / 14h with no phase inversion
                        48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        9D,          ; Note F_3
                        C9,          ; Rest
                        9D,          ; Note F_3
                        C9,          ; Rest
                        9D,          ; Note F_3
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        9D,          ; Note F_3
                        9B,          ; Note Eb_3
                        A2,          ; Note Bb_3
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9D,          ; Note F_3
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D2F9/$6604       db 0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        A2,          ; Note Bb_3
                        C9,          ; Rest
                        A2,          ; Note Bb_3
                        C9,          ; Rest
                        A2,          ; Note Bb_3
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A2,          ; Note Bb_3
                        A0,          ; Note Ab_3
                        A7,          ; Note Eb_4
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A2,          ; Note Bb_3
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D30B/$6616       db C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        C9,          ; Rest
                        0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        A9,          ; Note F_4
                        C9,          ; Rest
                        A9,          ; Note F_4
                        C9,          ; Rest
                        A9,          ; Note F_4
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A9,          ; Note F_4
                        A7,          ; Note Eb_4
                        AE,          ; Note Bb_4
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        A9,          ; Note F_4
                        C8,          ; Tie
                        C8,          ; Tie
                        C8,          ; Tie
                        C9,          ; Rest
                        C9,          ; Rest
                        ED,B4,       ; Static volume with volume multiplier = B4h / 100h
                        0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        AE,          ; Note Bb_4
                        C9,          ; Rest
                        AE,          ; Note Bb_4
                        C9,          ; Rest
                        AE,          ; Note Bb_4
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AE,          ; Note Bb_4
                        AC,          ; Note Ab_4
                        B3,          ; Note Eb_5
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        AE,          ; Note Bb_4
                        30,          ; Note length = 30h tics
                        C9,          ; Rest
                        00
}

; Repeated subsection
{
$DF:D339/$6644       db 48,          ; Note length = 48h tics
                        C9,          ; Rest
                        C9,          ; Rest
                        18,7F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        85,          ; Note F_1
                        0C,          ; Note length = Ch tics
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        85,          ; Note F_1
                        18,          ; Note length = 18h tics
                        85,          ; Note F_1
                        85,          ; Note F_1
                        86,          ; Note Gb_1
                        00
}

; Repeated subsection
{
$DF:D349/$6654       db E0,1A,       ; Select instrument 1Ah
                        F4,00,       ; Set subtranspose of 0 / 100h semitones
                        E1,0A,       ; Panning bias = Ah / 14h with no phase inversion
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        82,          ; Note D_1
                        82,          ; Note D_1
                        00
}

; Repeated subsection
{
$DF:D356/$6661       db ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        48,          ; Note length = 48h tics
                        91,          ; Note F_2
                        91,          ; Note F_2
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        91,          ; Note F_2
                        0C,          ; Note length = Ch tics
                        91,          ; Note F_2
                        91,          ; Note F_2
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        18,          ; Note length = 18h tics
                        91,          ; Note F_2
                        92,          ; Note Gb_2
                        00
}

; Repeated subsection
{
$DF:D367/$6672       db 18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        00
}

; Repeated subsection
{
$DF:D37A/$6685       db ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        93,          ; Note G_2
                        94,          ; Note Ab_2
                        96,          ; Note Bb_2
                        98,          ; Note C_3
                        99,          ; Note Db_3
                        9B,          ; Note Eb_3
                        9D,          ; Note F_3
                        9E,          ; Note Gb_3
                        A0,          ; Note Ab_3
                        A2,          ; Note Bb_3
                        A4,          ; Note C_4
                        A5,          ; Note Db_4
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A7,          ; Note Eb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A2,          ; Note Bb_3
                        A2,          ; Note Bb_3
                        18,          ; Note length = 18h tics
                        A7,          ; Note Eb_4
                        00
}

; Repeated subsection
{
$DF:D3B1/$66BC       db 8F,          ; Note Eb_2
                        0C,          ; Note length = Ch tics
                        87,          ; Note G_1
                        87,          ; Note G_1
                        18,          ; Note length = 18h tics
                        8F,          ; Note Eb_2
                        8F,          ; Note Eb_2
                        87,          ; Note G_1
                        8F,          ; Note Eb_2
                        00
}

; Repeated subsection
{
$DF:D3BB/$66C6       db 8F,          ; Note Eb_2
                        87,          ; Note G_1
                        8F,          ; Note Eb_2
                        8F,          ; Note Eb_2
                        87,          ; Note G_1
                        8F,          ; Note Eb_2
                        8D,          ; Note Db_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        8D,          ; Note Db_2
                        18,          ; Note length = 18h tics
                        8D,          ; Note Db_2
                        91,          ; Note F_2
                        8D,          ; Note Db_2
                        91,          ; Note F_2
                        00
}

; Repeated subsection
{
$DF:D3CB/$66D6       db 18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        00
}

; Repeated subsection
{
$DF:D3DE/$66E9       db ED,FA,       ; Static volume with volume multiplier = FAh / 100h
                        0C,7F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        96,          ; Note Bb_2
                        97,          ; Note B_2
                        99,          ; Note Db_3
                        9B,          ; Note Eb_3
                        9C,          ; Note E_3
                        9E,          ; Note Gb_3
                        A0,          ; Note Ab_3
                        A1,          ; Note A_3
                        A3,          ; Note B_3
                        A5,          ; Note Db_4
                        A7,          ; Note Eb_4
                        A8,          ; Note E_4
                        ED,BE,       ; Static volume with volume multiplier = BEh / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        AA,          ; Note Gb_4
                        0C,1F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        A5,          ; Note Db_4
                        A5,          ; Note Db_4
                        18,          ; Note length = 18h tics
                        AA,          ; Note Gb_4
                        00
}

; Repeated subsection
{
$DF:D415/$6720       db ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        B4,          ; Note E_5
                        0C,          ; Note length = Ch tics
                        C9,          ; Rest
                        0C,0F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 32h / 100h
                        B4,          ; Note E_5
                        18,          ; Note length = 18h tics
                        B4,          ; Note E_5
                        18,1F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = 65h / 100h
                        B4,          ; Note E_5
                        B1,          ; Note Db_5
                        B4,          ; Note E_5
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        B1,          ; Note Db_5
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D42B/$6736       db 92,          ; Note Gb_2
                        0C,          ; Note length = Ch tics
                        8A,          ; Note Bb_1
                        8A,          ; Note Bb_1
                        18,          ; Note length = 18h tics
                        92,          ; Note Gb_2
                        92,          ; Note Gb_2
                        8A,          ; Note Bb_1
                        92,          ; Note Gb_2
                        00
}

; Repeated subsection
{
$DF:D435/$6740       db 92,          ; Note Gb_2
                        8A,          ; Note Bb_1
                        92,          ; Note Gb_2
                        92,          ; Note Gb_2
                        8A,          ; Note Bb_1
                        92,          ; Note Gb_2
                        90,          ; Note E_2
                        0C,          ; Note length = Ch tics
                        C8,          ; Tie
                        90,          ; Note E_2
                        18,          ; Note length = 18h tics
                        90,          ; Note E_2
                        94,          ; Note Ab_2
                        90,          ; Note E_2
                        94,          ; Note Ab_2
                        00
}

; Repeated subsection
{
$DF:D445/$6750       db ED,C8,       ; Static volume with volume multiplier = C8h / 100h
                        EE,30,FA,    ; Dynamic volume over 30h tics with target volume multiplier FAh / 100h
                        0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        9A,          ; Note D_3
                        C9,          ; Rest
                        9A,          ; Note D_3
                        C9,          ; Rest
                        9A,          ; Note D_3
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        9A,          ; Note D_3
                        98,          ; Note C_3
                        9F,          ; Note G_3
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        48,7F,       ; Note length = 48h tics, note volume multiplier = FCh / 100h, note ring length multiplier = FCh / 100h
                        9A,          ; Note D_3
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D45E/$6769       db C9,          ; Rest
                        C9,          ; Rest
                        ED,96,       ; Static volume with volume multiplier = 96h / 100h
                        EE,30,B4,    ; Dynamic volume over 30h tics with target volume multiplier B4h / 100h
                        0C,3F,       ; Note length = Ch tics, note volume multiplier = FCh / 100h, note ring length multiplier = 98h / 100h
                        A6,          ; Note D_4
                        C9,          ; Rest
                        A6,          ; Note D_4
                        C9,          ; Rest
                        A6,          ; Note D_4
                        C9,          ; Rest
                        18,4F,       ; Note length = 18h tics, note volume multiplier = FCh / 100h, note ring length multiplier = B2h / 100h
                        A6,          ; Note D_4
                        A4,          ; Note C_4
                        AB,          ; Note G_4
                        00
}

; Repeated subsection
{
$DF:D473/$677E       db ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,3C,AA,    ; Dynamic volume over 3Ch tics with target volume multiplier AAh / 100h
                        85,          ; Note F_1
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        8E,          ; Note D_2
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D482/$678D       db ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,3C,AA,    ; Dynamic volume over 3Ch tics with target volume multiplier AAh / 100h
                        8C,          ; Note C_2
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        93,          ; Note G_2
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D491/$679C       db 8E,          ; Note D_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,          ; Note length = 18h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        8F,          ; Note Eb_2
                        ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        48,          ; Note length = 48h tics
                        8E,          ; Note D_2
                        8E,          ; Note D_2
                        00
}

; Repeated subsection
{
$DF:D4A0/$67AB       db ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,64,AA,    ; Dynamic volume over 64h tics with target volume multiplier AAh / 100h
                        83,          ; Note Eb_1
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,3C,AA,    ; Dynamic volume over 3Ch tics with target volume multiplier AAh / 100h
                        88,          ; Note Ab_1
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        91,          ; Note F_2
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D4B6/$67C1       db ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,64,AA,    ; Dynamic volume over 64h tics with target volume multiplier AAh / 100h
                        8A,          ; Note Bb_1
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,3C,AA,    ; Dynamic volume over 3Ch tics with target volume multiplier AAh / 100h
                        8F,          ; Note Eb_2
                        C8,          ; Tie
                        ED,32,       ; Static volume with volume multiplier = 32h / 100h
                        EE,50,AA,    ; Dynamic volume over 50h tics with target volume multiplier AAh / 100h
                        96,          ; Note Bb_2
                        C8,          ; Tie
                        00
}

; Repeated subsection
{
$DF:D4CC/$67D7       db ED,E6,       ; Static volume with volume multiplier = E6h / 100h
                        48,          ; Note length = 48h tics
                        91,          ; Note F_2
                        91,          ; Note F_2
                        91,          ; Note F_2
                        ED,DC,       ; Static volume with volume multiplier = DCh / 100h
                        18,          ; Note length = 18h tics
                        91,          ; Note F_2
                        91,          ; Note F_2
                        ED,F0,       ; Static volume with volume multiplier = F0h / 100h
                        92,          ; Note Gb_2
                        00
}
}

; EOF
$DF:D4DB             dw 0000, 1500
}


;;; $D4DF: Free space ;;;
{
$DF:D4DF             fillto $E08000, $FF	   ; Free space
}
