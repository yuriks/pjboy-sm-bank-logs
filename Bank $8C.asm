;;; $8000..8BFF: Title sequence spritemaps ;;;
{
;;; $8000: Unused. Beta Metroid logo ;;;
{
; The "4 METROID" title logo
$8C:8000             dx 0025,
                        0050,E8,31C0,
                        0050,10,31B6,
                        0050,08,31A6,
                        0050,00,3196,
                        0050,F8,3186,
                        C240,08,31A4,
                        C230,08,31A2,
                        C220,08,31A0,
                        C240,F8,3184,
                        C230,F8,3182,
                        C220,F8,3180,
                        C240,E8,3164,
                        C230,E8,3162,
                        C220,E8,3160,
                        C210,E8,310E,
                        C200,E8,310C,
                        C3F0,E8,310A,
                        C3E0,E8,3108,
                        C3D0,E8,3106,
                        C3C0,E8,3104,
                        C3B0,E8,3102,
                        C210,08,314E,
                        C200,08,314C,
                        C3F0,08,314A,
                        C3E0,08,3148,
                        C3D0,08,3146,
                        C3C0,08,3144,
                        C3B0,08,3142,
                        C3A0,08,3140,
                        C210,F8,312E,
                        C200,F8,312C,
                        C3F0,F8,312A,
                        C3E0,F8,3128,
                        C3D0,F8,3126,
                        C3C0,F8,3124,
                        C3B0,F8,3122,
                        C3A0,F8,3120
}


;;; $80BB: Nintendo boot logo ;;;
{
;  _________
; (Nintendo®️)
;  ¯¯¯¯¯¯¯¯¯
$8C:80BB             dx 000E,
                        C230,00,30CC,
                        C220,00,30CA,
                        C210,00,30C8,
                        C200,00,30C6,
                        C3F0,00,30C4,
                        C3E0,00,30C2,
                        C3D0,00,30C0,
                        C230,F0,30AC,
                        C220,F0,30AA,
                        C210,F0,30A8,
                        C200,F0,30A6,
                        C3F0,F0,30A4,
                        C3E0,F0,30A2,
                        C3D0,F0,30A0
}


;;; $8103: Nintendo copyright ;;;
{
; '©️ 1994 Nintendo'
$8C:8103             dx 000A,
                        0020,FC,31CA,
                        0018,FC,31C9,
                        0010,FC,31C8,
                        0008,FC,31C7,
                        0000,FC,31C6,
                        01F8,FC,31C5,
                        01F0,FC,31C4,
                        01E8,FC,31C3,
                        01E0,FC,31C2,
                        01D8,FC,31C1
}


;;; $8137: Unused. '1993 R&D1 PRODUCE' ;;;
{
$8C:8137             dx 001E,
                        01D4,00,3311,
                        01D4,F8,3301,
                        003C,00,337B,
                        003C,F8,336B,
                        0034,00,3379,
                        0034,F8,3369,
                        002C,00,33B9,
                        002C,F8,33A9,
                        0024,00,337A,
                        0024,F8,336A,
                        001C,00,339C,
                        001C,F8,338C,
                        0014,00,339F,
                        0014,F8,338F,
                        000C,00,339D,
                        000C,F8,338D,
                        01FC,00,3310,
                        01FC,F8,3300,
                        01F4,00,337A,
                        01F4,F8,336A,
                        01EC,00,33BF,
                        01EC,F8,33AF,
                        01E4,00,339F,
                        01E4,F8,338F,
                        01CC,00,3376,
                        01CC,F8,3366,
                        01C4,00,3376,
                        01C4,F8,3366,
                        01BC,00,3310,
                        01BC,F8,3300
}


;;; $81CF: Unused. 'PROJECT SAMUS FEATURED IN' ;;;
{
$8C:81CF             dx 002C,
                        004F,F8,337A,
                        004F,F0,336A,
                        0048,F8,337B,
                        0048,F0,336B,
                        0040,F8,339F,
                        0040,F0,338F,
                        0038,F8,33B9,
                        0038,F0,33A9,
                        0030,F8,33B8,
                        0030,F0,33A8,
                        002A,F8,3377,
                        002A,F0,3367,
                        0023,F8,337B,
                        0023,F0,336B,
                        001C,F8,337C,
                        001C,F0,336C,
                        01FF,10,339B,
                        01FF,08,338B,
                        01F9,10,337F,
                        01F9,08,336F,
                        000C,F8,33B7,
                        000C,F0,33A7,
                        0004,F8,33B9,
                        0004,F0,33A9,
                        01FC,F8,339A,
                        01FC,F0,338A,
                        01F4,F8,3377,
                        01F4,F0,3367,
                        01EC,F8,33B7,
                        01EC,F0,33A7,
                        01DC,F8,33B8,
                        01DC,F0,33A8,
                        01D5,F8,3379,
                        01D5,F0,3369,
                        01CE,F8,337B,
                        01CE,F0,336B,
                        01C6,F8,3397,
                        01C6,F0,3387,
                        01BF,F8,339C,
                        01BF,F0,338C,
                        01B7,F8,339F,
                        01B7,F0,338F,
                        01AF,F8,339D,
                        01AF,F0,338D
}


;;; $82AD: Unused. 'METROID 3' ;;;
{
$8C:82AD             dx 0010,
                        0018,00,3311,
                        0018,F8,3301,
                        0009,00,337A,
                        0009,F8,336A,
                        0003,00,337F,
                        0003,F8,336F,
                        01FC,00,339C,
                        01FC,F8,338C,
                        01F4,00,339F,
                        01F4,F8,338F,
                        01EC,00,33B8,
                        01EC,F8,33A8,
                        01E6,00,337B,
                        01E6,F8,336B,
                        01DE,00,339A,
                        01DE,F8,338A
}


;;; $82FF: Unused. '-Nintendo- presents' ;;;
{
$8C:82FF             dx 000C,
                        0018,F8,31CF,
                        01E0,F8,31CF,
                        0008,00,31CE,
                        0000,00,31CD,
                        01F8,00,31CC,
                        01F0,00,31CB,
                        0010,F8,31CA,
                        0008,F8,31C9,
                        0000,F8,31C8,
                        01F8,F8,31C7,
                        01F0,F8,31C6,
                        01E8,F8,31C5
}


;;; $833D: Unused. Incomplete Super Metroid title logo ;;;
{
; Almost identical to $879D, except there's a blank tile placed by the top of the D instead of the TM by the bottom
$8C:833D             dx 0026,
                        C248,F0,340E,
                        C238,F0,340C,
                        C248,10,348A,
                        C238,10,3488,
                        C228,10,3486,
                        C250,00,3484,
                        C240,00,3482,
                        C230,00,3480,
                        C218,10,346E,
                        C208,10,346C,
                        C3F8,10,346A,
                        C3E8,10,3468,
                        C3D8,10,3466,
                        C3C8,10,3464,
                        C3B8,10,3462,
                        C3A8,10,3460,
                        C220,00,344E,
                        C210,00,344C,
                        C200,00,344A,
                        C3F0,00,3448,
                        C3E0,00,3446,
                        C3D0,00,3444,
                        C3C0,00,3442,
                        C3B0,00,3440,
                        C228,F0,342E,
                        C218,F0,342C,
                        C208,F0,342A,
                        C3F8,F0,3428,
                        C3E8,F0,3426,
                        C3D8,F0,3424,
                        C3C8,F0,3422,
                        C3B8,F0,3420,
                        C220,E0,340A,
                        C210,E0,3408,
                        C200,E0,3406,
                        C3F0,E0,3404,
                        C3E0,E0,3402,
                        C3D0,E0,3400
}


;;; $83FD: Unused. 2x2 tile region ;;;
{
; Uses the blank rows of the title screen graphics
$8C:83FD             dx 0004,
                        0000,00,36F1,
                        01F8,00,36F0,
                        0000,F8,36E1,
                        01F8,F8,36E0
}


;;; $8413: Unused. 2x2 tile region ;;;
{
; Uses the blank rows of the title screen graphics
$8C:8413             dx 0004,
                        0000,00,36F3,
                        01F8,00,36F2,
                        0000,F8,36E3,
                        01F8,F8,36E2
}


;;; $8429: Unused. 2x2 tile region ;;;
{
; Uses the blank rows of the title screen graphics
$8C:8429             dx 0004,
                        0000,00,36F5,
                        01F8,00,36F4,
                        0000,F8,36E5,
                        01F8,F8,36E4
}


;;; $843F: Unused. 5x5 tile region ;;;
{
; If title screen graphics are loaded, co-incidentally overlaps with the right half of the Nintendo boot logo,
; but almost certainly referring to removed graphics
$8C:843F             dx 0019,
                        0010,08,34FB,
                        0008,08,34FA,
                        0000,08,34F9,
                        01F8,08,34F8,
                        01F0,08,34F7,
                        0010,00,34EB,
                        0008,00,34EA,
                        0000,00,34E9,
                        01F8,00,34E8,
                        01F0,00,34E7,
                        0010,F8,34DB,
                        0008,F8,34DA,
                        0000,F8,34D9,
                        01F8,F8,34D8,
                        01F0,F8,34D7,
                        0010,F0,34CB,
                        0008,F0,34CA,
                        0000,F0,34C9,
                        01F8,F0,34C8,
                        01F0,F0,34C7,
                        0010,E8,34BB,
                        0008,E8,34BA,
                        0000,E8,34B9,
                        01F8,E8,34B8,
                        01F0,E8,34B7
}


;;; $84BE: Unused. 4x5 tile region ;;;
{
; Uses the blank columns of the title screen graphics
$8C:84BE             dx 0014,
                        0008,08,34FF,
                        0000,08,34FE,
                        01F8,08,34FD,
                        01F0,08,34FC,
                        0008,00,34EF,
                        0000,00,34EE,
                        01F8,00,34ED,
                        01F0,00,34EC,
                        0008,F8,34DF,
                        0000,F8,34DE,
                        01F8,F8,34DD,
                        01F0,F8,34DC,
                        0008,F0,34CF,
                        0000,F0,34CE,
                        01F8,F0,34CD,
                        01F0,F0,34CC,
                        0008,E8,34BF,
                        0000,E8,34BE,
                        01F8,E8,34BD,
                        01F0,E8,34BC
}


;;; $8524: Unused. 4x4 tile region ;;;
{
; If title screen graphics are loaded, co-incidentally overlaps with some of the Super Metroid logo tiles,
; but almost certainly referring to removed graphics
$8C:8524             dx 0010,
                        0008,08,3493,
                        0000,08,3492,
                        01F8,08,3491,
                        01F0,08,3490,
                        0008,00,3483,
                        0000,00,3482,
                        01F8,00,3481,
                        01F0,00,3480,
                        0008,F8,3473,
                        0000,F8,3472,
                        01F8,F8,3471,
                        01F0,F8,3470,
                        0008,F0,3463,
                        0000,F0,3462,
                        01F8,F0,3461,
                        01F0,F0,3460
}


;;; $8576: Unused. 4x4 tile region ;;;
{
; If title screen graphics are loaded, co-incidentally overlaps with the left half of the Nintendo boot logo,
; but almost certainly referring to removed graphics
$8C:8576             dx 0010,
                        0008,08,34D3,
                        0000,08,34D2,
                        01F8,08,34D1,
                        01F0,08,34D0,
                        0008,00,34C3,
                        0000,00,34C2,
                        01F8,00,34C1,
                        01F0,00,34C0,
                        0008,F8,34B3,
                        0000,F8,34B2,
                        01F8,F8,34B1,
                        01F0,F8,34B0,
                        0008,F0,34A3,
                        0000,F0,34A2,
                        01F8,F0,34A1,
                        01F0,F0,34A0
}


;;; $85C8: '     METR' ;;;
{
$8C:85C8             dx 0008,
                        001C,00,339F,
                        001C,F8,338F,
                        0014,00,33B8,
                        0014,F8,33A8,
                        000C,00,337B,
                        000C,F8,336B,
                        0004,00,339A,
                        0004,F8,338A
}


;;; $85F2: '    METRO' ;;;
{
$8C:85F2             dx 000A,
                        001C,00,339C,
                        001C,F8,338C,
                        0014,00,339F,
                        0014,F8,338F,
                        000C,00,33B8,
                        000C,F8,33A8,
                        0004,00,337B,
                        0004,F8,336B,
                        01FC,00,339A,
                        01FC,F8,338A
}


;;; $8626: Unused. Debug Nintendo copyright ;;;
{
; '©️ 1994 Nintendo'
;    'Ver. 2.00'
$8C:8626             dx 0011,
                        0003,08,31F6,
                        0015,08,31F4,
                        000D,08,31F4,
                        0008,08,31F3,
                        01F4,08,31F2,
                        01EC,08,31F1,
                        01E4,08,31F0,
                        0020,FC,31CA,
                        0018,FC,31C9,
                        0010,FC,31C8,
                        0008,FC,31C7,
                        0000,FC,31C6,
                        01F8,FC,31C5,
                        01F0,FC,31C4,
                        01E8,FC,31C3,
                        01E0,FC,31C2,
                        01D8,FC,31C1
}


;;; $867D: '   METROI' ;;;
{
$8C:867D             dx 000C,
                        001C,00,337F,
                        001C,F8,336F,
                        0014,00,339C,
                        0014,F8,338C,
                        000C,00,339F,
                        000C,F8,338F,
                        0004,00,33B8,
                        0004,F8,33A8,
                        01FC,00,337B,
                        01FC,F8,336B,
                        01F4,00,339A,
                        01F4,F8,338A
}


;;; $86BB: '  METROID' ;;;
{
$8C:86BB             dx 000E,
                        001C,00,337A,
                        001C,F8,336A,
                        0014,00,337F,
                        0014,F8,336F,
                        000C,00,339C,
                        000C,F8,338C,
                        0004,00,339F,
                        0004,F8,338F,
                        01FC,00,33B8,
                        01FC,F8,33A8,
                        01F4,00,337B,
                        01F4,F8,336B,
                        01EC,00,339A,
                        01EC,F8,338A
}


;;; $8703: ' METROID ' ;;;
{
$8C:8703             dx 000E,
                        0014,00,337A,
                        0014,F8,336A,
                        000C,00,337F,
                        000C,F8,336F,
                        0004,00,339C,
                        0004,F8,338C,
                        01FC,00,339F,
                        01FC,F8,338F,
                        01F4,00,33B8,
                        01F4,F8,33A8,
                        01EC,00,337B,
                        01EC,F8,336B,
                        01E4,00,339A,
                        01E4,F8,338A
}


;;; $874B: 'METROID 3' ;;;
{
$8C:874B             dx 0010,
                        001C,00,3311,
                        001C,F8,3301,
                        000C,00,337A,
                        000C,F8,336A,
                        0004,00,337F,
                        0004,F8,336F,
                        01FC,00,339C,
                        01FC,F8,338C,
                        01F4,00,339F,
                        01F4,F8,338F,
                        01EC,00,33B8,
                        01EC,F8,33A8,
                        01E4,00,337B,
                        01E4,F8,336B,
                        01DC,00,339A,
                        01DC,F8,338A
}


;;; $879D: Super Metroid title logo ;;;
{
$8C:879D             dx 0027,
                        0058,18,349C,
                        0048,F8,341E,
                        C238,F0,340C,
                        C248,10,348A,
                        C238,10,3488,
                        C228,10,3486,
                        C250,00,3484,
                        C240,00,3482,
                        C230,00,3480,
                        C218,10,346E,
                        C208,10,346C,
                        C3F8,10,346A,
                        C3E8,10,3468,
                        C3D8,10,3466,
                        C3C8,10,3464,
                        C3B8,10,3462,
                        C3A8,10,3460,
                        C220,00,344E,
                        C210,00,344C,
                        C200,00,344A,
                        C3F0,00,3448,
                        C3E0,00,3446,
                        C3D0,00,3444,
                        C3C0,00,3442,
                        C3B0,00,3440,
                        C228,F0,342E,
                        C218,F0,342C,
                        C208,F0,342A,
                        C3F8,F0,3428,
                        C3E8,F0,3426,
                        C3D8,F0,3424,
                        C3C8,F0,3422,
                        C3B8,F0,3420,
                        C220,E0,340A,
                        C210,E0,3408,
                        C200,E0,3406,
                        C3F0,E0,3404,
                        C3E0,E0,3402,
                        C3D0,E0,3400
}


;;; $8862: '   1' ;;;
{
$8C:8862             dx 0002,
                        0008,00,3310,
                        0008,F8,3300
}


;;; $886E: '  19' ;;;
{
$8C:886E             dx 0004,
                        0008,00,3376,
                        0008,F8,3366,
                        0000,00,3310,
                        0000,F8,3300
}


;;; $8884: ' 199' ;;;
{
$8C:8884             dx 0006,
                        01F8,00,3310,
                        01F8,F8,3300,
                        0000,00,3376,
                        0000,F8,3366,
                        0008,00,3376,
                        0008,F8,3366
}


;;; $88A4: '1994' ;;;
{
$8C:88A4             dx 0008,
                        0008,00,3330,
                        0008,F8,3320,
                        01F8,00,3376,
                        01F8,F8,3366,
                        01F0,00,3310,
                        01F0,F8,3300,
                        0000,00,3376,
                        0000,F8,3366
}


;;; $88CE: '       N' ;;;
{
$8C:88CE             dx 0002,
                        0018,00,339B,
                        0018,F8,338B
}


;;; $88DA: '      NI' ;;;
{
$8C:88DA             dx 0004,
                        0018,00,337F,
                        0018,F8,336F,
                        0010,00,339B,
                        0010,F8,338B
}


;;; $88F0: '     NIN' ;;;
{
$8C:88F0             dx 0006,
                        0018,00,339B,
                        0018,F8,338B,
                        0010,00,337F,
                        0010,F8,336F,
                        0008,00,339B,
                        0008,F8,338B
}


;;; $8910: '    NINT' ;;;
{
$8C:8910             dx 0008,
                        0018,00,33B8,
                        0018,F8,33A8,
                        0010,00,339B,
                        0010,F8,338B,
                        0008,00,337F,
                        0008,F8,336F,
                        0000,00,339B,
                        0000,F8,338B
}


;;; $893A: '   NINTE' ;;;
{
$8C:893A             dx 000A,
                        0018,00,337B,
                        0018,F8,336B,
                        0010,00,33B8,
                        0010,F8,33A8,
                        0008,00,339B,
                        0008,F8,338B,
                        0000,00,337F,
                        0000,F8,336F,
                        01F8,00,339B,
                        01F8,F8,338B
}


;;; $896E: '  NINTEN' ;;;
{
$8C:896E             dx 000C,
                        0018,00,339B,
                        0018,F8,338B,
                        0010,00,337B,
                        0010,F8,336B,
                        0008,00,33B8,
                        0008,F8,33A8,
                        0000,00,339B,
                        0000,F8,338B,
                        01F8,00,337F,
                        01F8,F8,336F,
                        01F0,00,339B,
                        01F0,F8,338B
}


;;; $89AC: ' NINTEND' ;;;
{
$8C:89AC             dx 000E,
                        0018,00,337A,
                        0018,F8,336A,
                        0010,00,339B,
                        0010,F8,338B,
                        0008,00,337B,
                        0008,F8,336B,
                        0000,00,33B8,
                        0000,F8,33A8,
                        01F8,00,339B,
                        01F8,F8,338B,
                        01F0,00,337F,
                        01F0,F8,336F,
                        01E8,00,339B,
                        01E8,F8,338B
}


;;; $89F4: 'NINTENDO' ;;;
{
$8C:89F4             dx 0010,
                        0018,00,339C,
                        0018,F8,338C,
                        0010,00,337A,
                        0010,F8,336A,
                        0008,00,339B,
                        0008,F8,338B,
                        0000,00,337B,
                        0000,F8,336B,
                        01F8,00,33B8,
                        01F8,F8,33A8,
                        01F0,00,339B,
                        01F0,F8,338B,
                        01E8,00,337F,
                        01E8,F8,336F,
                        01E0,00,339B,
                        01E0,F8,338B
}


;;; $8A46: '       P' ;;;
{
$8C:8A46             dx 0002,
                        0018,00,339D,
                        0018,F8,338D
}


;;; $8A52: '      PR' ;;;
{
$8C:8A52             dx 0004,
                        0018,00,339F,
                        0018,F8,338F,
                        0010,00,339D,
                        0010,F8,338D
}


;;; $8A68: '     PRE' ;;;
{
$8C:8A68             dx 0006,
                        0018,00,337B,
                        0018,F8,336B,
                        0010,00,339F,
                        0010,F8,338F,
                        0008,00,339D,
                        0008,F8,338D
}


;;; $8A88: '    PRES' ;;;
{
$8C:8A88             dx 0008,
                        0018,00,33B7,
                        0018,F8,33A7,
                        0010,00,337B,
                        0010,F8,336B,
                        0008,00,339F,
                        0008,F8,338F,
                        0000,00,339D,
                        0000,F8,338D
}


;;; $8AB2: '   PRESE' ;;;
{
$8C:8AB2             dx 000A,
                        0018,00,337B,
                        0018,F8,336B,
                        0010,00,33B7,
                        0010,F8,33A7,
                        0008,00,337B,
                        0008,F8,336B,
                        0000,00,339F,
                        0000,F8,338F,
                        01F8,00,339D,
                        01F8,F8,338D
}


;;; $8AE6: '  PRESEN' ;;;
{
$8C:8AE6             dx 000C,
                        0018,00,339B,
                        0018,F8,338B,
                        0010,00,337B,
                        0010,F8,336B,
                        0008,00,33B7,
                        0008,F8,33A7,
                        0000,00,337B,
                        0000,F8,336B,
                        01F8,00,339F,
                        01F8,F8,338F,
                        01F0,00,339D,
                        01F0,F8,338D
}


;;; $8B24: ' PRESENT' ;;;
{
$8C:8B24             dx 000E,
                        0018,00,33B8,
                        0018,F8,33A8,
                        0010,00,339B,
                        0010,F8,338B,
                        0008,00,337B,
                        0008,F8,336B,
                        0000,00,33B7,
                        0000,F8,33A7,
                        01F8,00,337B,
                        01F8,F8,336B,
                        01F0,00,339F,
                        01F0,F8,338F,
                        01E8,00,339D,
                        01E8,F8,338D
}


;;; $8B6C: 'PRESENTS' ;;;
{
$8C:8B6C             dx 0010,
                        0018,00,33B7,
                        0018,F8,33A7,
                        0010,00,33B8,
                        0010,F8,33A8,
                        0008,00,339B,
                        0008,F8,338B,
                        0000,00,337B,
                        0000,F8,336B,
                        01F8,00,33B7,
                        01F8,F8,33A7,
                        01F0,00,337B,
                        01F0,F8,336B,
                        01E8,00,339F,
                        01E8,F8,338F,
                        01E0,00,339D,
                        01E0,F8,338D
}


;;; $8BBE: '        M' ;;;
{
$8C:8BBE             dx 0002,
                        001C,00,339A,
                        001C,F8,338A
}


;;; $8BCA: '       ME' ;;;
{
$8C:8BCA             dx 0004,
                        001C,00,337B,
                        001C,F8,336B,
                        0014,00,339A,
                        0014,F8,338A
}


;;; $8BE0: '      MET' ;;;
{
$8C:8BE0             dx 0006,
                        001C,00,33B8,
                        001C,F8,33A8,
                        0014,00,337B,
                        0014,F8,336B,
                        000C,00,339A,
                        000C,F8,338A
}
}


;;; $8C00..99D5: Intro / Ceres explosion spritemaps ;;;
{
;;; $8C00: Intro Mother Brain (frame 1) ;;;
{
$8C:8C00             dx 0009,
                        C208,08,3F94,
                        C3F8,08,3F92,
                        C3E8,08,3F90,
                        C208,F8,3F74,
                        C3F8,F8,3F72,
                        C3E8,F8,3F70,
                        C208,E8,3F54,
                        C3F8,E8,3F52,
                        C3E8,E8,3F50
}


;;; $8C2F: Intro Mother Brain (frame 2) ;;;
{
$8C:8C2F             dx 0009,
                        C208,F8,3F7A,
                        C3E8,F8,3F76,
                        C208,E8,3F5A,
                        C3F8,E8,3F58,
                        C3E8,E8,3F56,
                        C208,08,3F94,
                        C3F8,08,3F92,
                        C3E8,08,3F90,
                        C3F8,F8,3F72
}


;;; $8C5E: Intro Mother Brain (frame 3) ;;;
{
$8C:8C5E             dx 0009,
                        C208,E8,3F78,
                        C208,F8,3F7E,
                        C3E8,F8,3F7C,
                        C3F8,E8,3F5E,
                        C3E8,E8,3F5C,
                        C208,08,3F94,
                        C3F8,08,3F92,
                        C3E8,08,3F90,
                        C3F8,F8,3F72
}


;;; $8C8D: Intro rinka (frame 1) ;;;
{
$8C:8C8D             dx 0004,
                        0000,00,FF96,
                        01F8,00,BF96,
                        0000,F8,7F96,
                        01F8,F8,3F96
}


;;; $8CA3: Intro rinka (frame 2) ;;;
{
$8C:8CA3             dx 0004,
                        0000,00,FF97,
                        01F8,00,BF97,
                        0000,F8,7F97,
                        01F8,F8,3F97
}


;;; $8CB9: Intro rinka (frame 3) ;;;
{
$8C:8CB9             dx 0004,
                        0000,00,FF98,
                        01F8,00,BF98,
                        0000,F8,7F98,
                        01F8,F8,3F98
}


;;; $8CCF: Intro Japanese text next-page arrow (frame 1) ;;;
{
$8C:8CCF             dx 0002,
                        01FF,00,7DA8,
                        01F8,00,3DA8
}


;;; $8CDB: Intro Japanese text next-page arrow (frame 2) ;;;
{
$8C:8CDB             dx 0002,
                        01FF,00,7D9F,
                        01F8,00,3D9F
}


;;; $8CE7: Intro Japanese text next-page arrow (frame 3) ;;;
{
$8C:8CE7             dx 0002,
                        01FF,00,7DAF,
                        01F8,00,3DAF
}


;;; $8CF3: Baby metroid being delivered (frame 1) ;;;
{
$8C:8CF3             dx 0006,
                        0004,F4,3CEB,
                        01FC,F4,3CEA,
                        01F4,F4,3CE9,
                        0004,04,3CF2,
                        0004,FC,3CE2,
                        C3F4,FC,3CE0
}


;;; $8D13: Baby metroid being delivered (frame 2) ;;;
{
$8C:8D13             dx 0006,
                        0004,F4,3CEE,
                        01FC,F4,3CED,
                        01F4,F4,3CEC,
                        01F4,04,3CF3,
                        01F4,FC,3CE3,
                        C3FC,FC,3CE4
}


;;; $8D33: Baby metroid being delivered (frame 3) ;;;
{
$8C:8D33             dx 0006,
                        0004,F4,3CFB,
                        01FC,F4,3CFA,
                        01F4,F4,3CF9,
                        0004,04,3CF8,
                        0004,FC,3CE8,
                        C3F4,FC,3CE6
}


;;; $8D53: Baby metroid being examined (frame 1) ;;;
{
$8C:8D53             dx 0001,
                        C3F8,F8,3D99
}


;;; $8D5A: Baby metroid being examined (frame 2) ;;;
{
$8C:8D5A             dx 0001,
                        C3F8,F8,3D9B
}


;;; $8D61: Baby metroid being examined (frame 3) ;;;
{
$8C:8D61             dx 0001,
                        C3F8,F8,3D9D
}


;;; $8D68: The blinking typewriter block ;;;
{
$8C:8D68             dx 0001,
                        0000,FF,3CFC
}


;;; $8D6F: Metroid egg hatching (frame 1) ;;;
{
$8C:8D6F             dx 0006,
                        0004,F4,3F24,
                        01FC,F4,3F23,
                        01F4,F4,3F22,
                        C3F4,FC,3F10,
                        0004,04,3F01,
                        0004,FC,3F00
}


;;; $8D8F: Metroid egg hatching (frame 2) ;;;
{
$8C:8D8F             dx 0009,
                        0001,F4,3F24,
                        01F9,F4,3F23,
                        01F1,F4,3F22,
                        0003,04,3F01,
                        0002,FC,3F00,
                        01FB,04,3F21,
                        01F3,04,3F20,
                        01FA,FC,3F11,
                        01F2,FC,3F10
}


;;; $8DBE: Metroid egg hatching (frame 3) ;;;
{
$8C:8DBE             dx 0009,
                        0007,F4,3F24,
                        01FF,F4,3F23,
                        01F7,F4,3F22,
                        0005,04,3F01,
                        0006,FC,3F00,
                        01FD,04,3F21,
                        01F5,04,3F20,
                        01FE,FC,3F11,
                        01F6,FC,3F10
}


;;; $8DED: Metroid egg hatching (frame 4) ;;;
{
$8C:8DED             dx 0009,
                        01F4,F4,3F02,
                        0004,04,3F01,
                        0004,FC,3F00,
                        0004,F4,3F24,
                        01FC,F4,3F23,
                        01FC,04,3F21,
                        01F4,04,3F20,
                        01FC,FC,3F11,
                        01F4,FC,3F10
}


;;; $8E1C: Metroid egg hatching (frame 5) ;;;
{
$8C:8E1C             dx 0009,
                        01F4,F4,3F02,
                        01FC,F4,3F03,
                        0004,04,3F01,
                        0004,FC,3F00,
                        0004,F4,3F24,
                        01FC,04,3F21,
                        01F4,04,3F20,
                        01FC,FC,3F11,
                        01F4,FC,3F10
}


;;; $8E4B: Metroid egg hatching (frame 6) ;;;
{
$8C:8E4B             dx 0009,
                        01F4,FC,3F12,
                        01F4,F4,3F02,
                        01FC,F4,3F03,
                        0004,04,3F01,
                        0004,FC,3F00,
                        0004,F4,3F24,
                        01FC,04,3F21,
                        01F4,04,3F20,
                        01FC,FC,3F11
}


;;; $8E7A: Metroid egg hatching (frame 7) ;;;
{
$8C:8E7A             dx 0009,
                        0004,F4,3F04,
                        01F4,FC,3F12,
                        01F4,F4,3F02,
                        01FC,F4,3F03,
                        0004,04,3F01,
                        0004,FC,3F00,
                        01FC,04,3F21,
                        01F4,04,3F20,
                        01FC,FC,3F11
}


;;; $8EA9: Metroid egg hatching (frame 8) ;;;
{
$8C:8EA9             dx 0009,
                        01FC,FC,3F11,
                        0004,FC,3F14,
                        0004,F4,3F04,
                        01F4,FC,3F12,
                        01F4,F4,3F02,
                        01FC,F4,3F03,
                        0004,04,3F01,
                        01FC,04,3F21,
                        01F4,04,3F20
}


;;; $8ED8: Metroid egg hatching (frame 9) ;;;
{
$8C:8ED8             dx 0009,
                        01FC,FC,3F13,
                        0004,FC,3F14,
                        0004,F4,3F04,
                        01F4,FC,3F12,
                        01F4,F4,3F02,
                        01FC,F4,3F03,
                        0004,04,3F01,
                        01FC,04,3F21,
                        01F4,04,3F20
}


;;; $8F07: Metroid egg hatched (frame 1) ;;;
{
$8C:8F07             dx 0003,
                        0004,04,3F08,
                        0004,FC,3F07,
                        C3F4,FC,3F17
}


;;; $8F18: Metroid egg hatched (frame 2) ;;;
{
$8C:8F18             dx 0003,
                        0004,04,3F08,
                        0004,FC,3F09,
                        C3F4,FC,3F19
}


;;; $8F29: Metroid egg hatched (frame 3) ;;;
{
$8C:8F29             dx 0003,
                        0004,04,3F0C,
                        0004,FC,3F0B,
                        C3F4,FC,3F1B
}


;;; $8F3A: Metroid egg hatched (frame 4) ;;;
{
$8C:8F3A             dx 0003,
                        0004,04,3F42,
                        0004,FC,3F32,
                        C3F4,FC,3F30
}


;;; $8F4B: Metroid egg hatched (frame 5) ;;;
{
$8C:8F4B             dx 0003,
                        0004,04,3F45,
                        0004,FC,3F35,
                        C3F4,FC,3F33
}


;;; $8F5C: Metroid egg hatched (frame 6) ;;;
{
$8C:8F5C             dx 0003,
                        0004,04,3F48,
                        0004,FC,3F38,
                        C3F4,FC,3F36
}


;;; $8F6D: Metroid egg hatched (frame 7) ;;;
{
$8C:8F6D             dx 0003,
                        0004,04,3F4B,
                        0004,FC,3F3B,
                        C3F4,FC,3F39
}


;;; $8F7E: Metroid egg's particle 1 ;;;
{
$8C:8F7E             dx 0001,
                        01FC,FC,3F05
}


;;; $8F85: Metroid egg's particle 2 ;;;
{
$8C:8F85             dx 0001,
                        01FC,FC,3F06
}


;;; $8F8C: Metroid egg's particle 3 ;;;
{
$8C:8F8C             dx 0001,
                        01FC,FC,3F15
}


;;; $8F93: Metroid egg's particle 4 ;;;
{
$8C:8F93             dx 0001,
                        01FC,FC,3F16
}


;;; $8F9A: Metroid egg's particle 5 ;;;
{
$8C:8F9A             dx 0001,
                        01FC,FC,3F25
}


;;; $8FA1: Metroid egg's particle 6 ;;;
{
$8C:8FA1             dx 0001,
                        01FC,FC,3F26
}


;;; $8FA8: Metroid egg's slime drops (frame 1) ;;;
{
$8C:8FA8             dx 0001,
                        01FC,FC,3F0D
}


;;; $8FAF: Metroid egg's slime drops (frame 2) ;;;
{
$8C:8FAF             dx 0001,
                        01FC,FC,3F0E
}


;;; $8FB6: Metroid egg's slime drops (frame 3) ;;;
{
$8C:8FB6             dx 0001,
                        01FC,FC,3F0F
}


;;; $8FBD: Metroid egg's slime drops (frame 4) ;;;
{
$8C:8FBD             dx 0001,
                        01FC,FC,3F1D
}


;;; $8FC4: Metroid egg's slime drops (frame 5) ;;;
{
$8C:8FC4             dx 0001,
                        01FC,FC,3F2D
}


;;; $8FCB: Confused baby metroid (frame 1) ;;;
{
$8C:8FCB             dx 0001,
                        C3F8,F8,3F1E
}


;;; $8FD2: Confused baby metroid (frame 2) ;;;
{
$8C:8FD2             dx 0001,
                        C3F8,F8,3F3C
}


;;; $8FD9: Confused baby metroid (frame 3) ;;;
{
$8C:8FD9             dx 0001,
                        C3F8,F8,3F3E
}


;;; $8FE0: Metroid egg projectile ;;;
{
$8C:8FE0             dx 0001,
                        01FC,FC,3F0A
}
}


;;; $8FE7..99D5: Space spritemaps ;;;
{
;;; $8FE7: Ceres purple space vortex (frame 1) ;;;
{
$8C:8FE7             dx 0024,
                        006E,E0,09E6,
                        0066,E0,09E6,
                        01E9,34,09EA,
                        0010,F4,09EA,
                        0056,FB,09E8,
                        0022,B4,09E8,
                        01B8,79,09E8,
                        003C,E7,09EC,
                        0075,22,09EC,
                        0076,6F,09E8,
                        0197,6C,09E9,
                        01D3,50,09E9,
                        006C,5E,09E8,
                        004E,5D,09EA,
                        01E1,C0,09E8,
                        004C,4A,09E9,
                        01BB,B9,09E9,
                        01C1,69,09E8,
                        C256,E0,09E4,
                        C246,E0,09E2,
                        C266,D0,09E0,
                        C256,D0,09CE,
                        C246,D0,09CC,
                        C266,C0,09CA,
                        C256,C0,09C8,
                        C246,C0,09C6,
                        C266,B0,09C4,
                        C256,B0,09C2,
                        C246,B0,09C0,
                        002F,23,09EA,
                        0046,7A,09EA,
                        0000,E4,09EB,
                        006C,2E,09EB,
                        01D3,E6,09E9,
                        0003,CD,09EA,
                        01B1,E2,09E8
}


;;; $909D: Ceres under attack large asteroids ;;;
{
$8C:909D             dx 0013,
                        C3A7,CF,3983,
                        C3A7,BF,3963,
                        C39F,CF,3982,
                        C38F,CF,3980,
                        C39F,BF,3962,
                        C38F,BF,3960,
                        0058,FC,39A9,
                        C260,F4,399A,
                        C270,DC,396C,
                        C268,EC,398B,
                        C258,EC,3989,
                        C268,DC,396B,
                        C258,DC,3969,
                        C210,28,39A7,
                        C200,28,39A5,
                        C210,18,3987,
                        C200,18,3985,
                        C210,08,3967,
                        C200,08,3965
}


;;; $90FE: Ceres small asteroids ;;;
{
$8C:90FE             dx 0010,
                        C380,E2,897E,
                        C380,EA,896E,
                        C3DE,05,097E,
                        C3DE,FD,096E,
                        C20B,22,09A1,
                        C203,22,09A0,
                        0063,FB,099D,
                        C26B,FB,099E,
                        C263,03,09AD,
                        C236,EC,897E,
                        C236,F4,896E,
                        C3A4,14,09A1,
                        C39C,14,09A0,
                        0016,EF,899D,
                        C21E,E7,899E,
                        C216,DF,89AD
}


;;; $9150: Ceres under attack ;;;
{
$8C:9150             dx 0029,
                        01E6,D8,0CF4,
                        C3EE,D0,0CE5,
                        C216,10,0D49,
                        002E,00,0CF0,
                        0016,20,0CF2,
                        000E,20,0CF1,
                        01FE,28,0CF3,
                        0006,20,0D5C,
                        01FE,20,0D5B,
                        01E6,28,0D5D,
                        01E6,20,0D4D,
                        01DE,20,0D4C,
                        01D6,20,0D4B,
                        C3EE,20,0D4E,
                        C20E,10,0D48,
                        C3FE,10,0D46,
                        C3EE,10,0D44,
                        C3DE,10,0D42,
                        C3CE,10,0D40,
                        C21E,00,0D2E,
                        C20E,00,0D2C,
                        C3FE,00,0D2A,
                        C3EE,00,0D28,
                        C3DE,00,0D26,
                        C3CE,00,0D24,
                        C226,F0,0D22,
                        C216,F0,0D20,
                        C206,F0,0D0E,
                        C3FE,F0,0D0D,
                        C3EE,F0,0D0B,
                        C3DE,F0,0D09,
                        C3CE,F0,0D07,
                        C21E,E0,0D05,
                        C216,E0,0D04,
                        C206,E0,0D02,
                        C3F6,E0,0D00,
                        C3E6,E0,0CEE,
                        C3D6,E0,0CEC,
                        C216,D0,0CEA,
                        C206,D0,0CE8,
                        C3F6,D0,0CE6
}


;;; $921F: Unused. 'SPACE COLONY' ;;;
{
$8C:921F             dx 000B,
                        0028,FC,31B9,
                        0020,FC,31FB,
                        0018,FC,31F9,
                        0010,FC,31FA,
                        0008,FC,31F9,
                        0000,FC,31F7,
                        01F0,FC,31F8,
                        01E8,FC,31F7,
                        01E0,FC,31EF,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $9258: Unused. 'スペースコロニー' ;;;
{
$8C:9258             dx 0010,
                        01FC,00,30E2,
                        01FC,F8,31BA,
                        001C,00,31B4,
                        001C,F8,31B3,
                        0014,00,31A4,
                        0014,F8,30E1,
                        000C,F8,30E0,
                        000C,00,31A3,
                        0004,00,30E4,
                        0004,F8,31BC,
                        01EC,00,30E3,
                        01E4,00,30E2,
                        01F4,00,31B4,
                        01F4,F8,31B3,
                        01EC,F8,31BB,
                        01E4,F8,31BA
}


;;; $92AA: Unused. 'S' ;;;
{
$8C:92AA             dx 0001,
                        01D0,FC,31ED
}


;;; $92B1: Unused. 'SP' ;;;
{
$8C:92B1             dx 0002,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $92BD: Unused. 'SPA' ;;;
{
$8C:92BD             dx 0003,
                        01E0,FC,31EF,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $92CE: Unused. 'SPAC' ;;;
{
$8C:92CE             dx 0004,
                        01E8,FC,31F7,
                        01E0,FC,31EF,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $92E4: Unused. 'SPACE' ;;;
{
$8C:92E4             dx 0005,
                        01F0,FC,31F8,
                        01E8,FC,31F7,
                        01E0,FC,31EF,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $92FF: Unused. 'SPACE C' ;;;
{
$8C:92FF             dx 0006,
                        0000,FC,31F7,
                        01F0,FC,31F8,
                        01E8,FC,31F7,
                        01E0,FC,31EF,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $931F: Unused. 'SPACE CO' ;;;
{
$8C:931F             dx 0007,
                        0008,FC,31F9,
                        0000,FC,31F7,
                        01F0,FC,31F8,
                        01E8,FC,31F7,
                        01E0,FC,31EF,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $9344: Unused. 'SPACE COL' ;;;
{
$8C:9344             dx 0008,
                        0010,FC,31FA,
                        0008,FC,31F9,
                        0000,FC,31F7,
                        01F0,FC,31F8,
                        01E8,FC,31F7,
                        01E0,FC,31EF,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $936E: Unused. 'SPACE COLO' ;;;
{
$8C:936E             dx 0009,
                        0018,FC,31F9,
                        0010,FC,31FA,
                        0008,FC,31F9,
                        0000,FC,31F7,
                        01F0,FC,31F8,
                        01E8,FC,31F7,
                        01E0,FC,31EF,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $939D: Unused. 'SPACE COLON' ;;;
{
$8C:939D             dx 000A,
                        0020,FC,31FB,
                        0018,FC,31F9,
                        0010,FC,31FA,
                        0008,FC,31F9,
                        0000,FC,31F7,
                        01F0,FC,31F8,
                        01E8,FC,31F7,
                        01E0,FC,31EF,
                        01D8,FC,31EE,
                        01D0,FC,31ED
}


;;; $93D1: Ceres purple space vortex (frame 2) ;;;
{
$8C:93D1             dx 0021,
                        0010,E4,09E8,
                        01B1,C6,09EA,
                        01CD,CB,09EA,
                        006E,E0,09E6,
                        0066,E0,09E6,
                        01AA,66,09EC,
                        0192,52,09E8,
                        0035,5B,09E8,
                        01A3,E8,09EA,
                        0194,B8,09E8,
                        01B0,59,09E9,
                        01E7,A5,09E8,
                        C256,E0,09E4,
                        C246,E0,09E2,
                        C266,D0,09E0,
                        C256,D0,09CE,
                        C246,D0,09CC,
                        C266,C0,09CA,
                        C256,C0,09C8,
                        C246,C0,09C6,
                        C266,B0,09C4,
                        C256,B0,09C2,
                        C246,B0,09C0,
                        01EC,CC,09E8,
                        006E,07,09EA,
                        01BF,3A,09EB,
                        0038,34,09E8,
                        002E,44,09E9,
                        0049,29,09E9,
                        01B8,FF,09EA,
                        019E,12,09E8,
                        01D0,24,09EA,
                        01E0,04,09E9
}


;;; $9478: Ceres stars ;;;
{
$8C:9478             dx 0019,
                        0192,D0,49EB,
                        01A2,B0,49E8,
                        000F,34,49EA,
                        01E8,F4,49EA,
                        01A2,FB,49E8,
                        01D6,B4,49E8,
                        0040,79,49E8,
                        01BC,E7,49EC,
                        0183,22,49EC,
                        0182,6F,49E8,
                        0061,6C,49E9,
                        0025,50,49E9,
                        018C,5E,49E8,
                        01AA,5D,49EA,
                        0017,C0,49E8,
                        01AC,4A,49E9,
                        003D,B9,49E9,
                        0037,69,49E8,
                        01C9,23,49EA,
                        01B2,7A,49EA,
                        01F8,E4,49EB,
                        018C,2E,49EB,
                        0025,E6,49E9,
                        01F5,CD,49EA,
                        0047,E2,49E8
}


;;; $94F7: Ceres explosion large asteroids ;;;
{
$8C:94F7             dx 0013,
                        C3A7,CF,0983,
                        C3A7,BF,0963,
                        C39F,CF,0982,
                        C38F,CF,0980,
                        C39F,BF,0962,
                        C38F,BF,0960,
                        0058,FC,09A9,
                        C260,F4,099A,
                        C270,DC,096C,
                        C268,EC,098B,
                        C258,EC,0989,
                        C268,DC,096B,
                        C258,DC,0969,
                        C210,28,09A7,
                        C200,28,09A5,
                        C210,18,0987,
                        C200,18,0985,
                        C210,08,0967,
                        C200,08,0965
}


;;; $9558: Zebes ;;;
{
$8C:9558             dx 0032,
                        01C8,10,0E6D,
                        01D8,C8,0E11,
                        01D0,C8,0E10,
                        01D8,C0,0E01,
                        01C0,D8,0E19,
                        0008,20,0E8E,
                        0000,20,0E8D,
                        01F8,20,0E8C,
                        01F0,20,0E8B,
                        01E8,20,0E8A,
                        01E0,20,0E89,
                        01D8,20,0E88,
                        0010,18,0E96,
                        0018,10,0E87,
                        0010,10,0E86,
                        C200,10,0E84,
                        C3F0,10,0E82,
                        C3E0,10,0E80,
                        C3D0,10,0E6E,
                        C218,00,0E6B,
                        C210,00,0E6A,
                        C200,00,0E68,
                        C3F0,00,0E66,
                        C3E0,00,0E64,
                        C3D0,00,0E62,
                        C3C0,00,0E60,
                        C218,F0,0E4E,
                        C210,F0,0E4D,
                        C200,F0,0E4B,
                        C3F0,F0,0E49,
                        C3E0,F0,0E47,
                        C3D0,F0,0E45,
                        C3C0,F0,0E43,
                        C218,E0,0E41,
                        C210,E0,0E2E, ; <-- Tiling error when flying to Zebes, tile index should be 2Fh
                        C200,E0,0E2D,
                        C3F0,E0,0E2B,
                        C3E0,E0,0E29,
                        C3D0,E0,0E27,
                        C3C0,E0,0E25,
                        0010,C8,0E18,
                        C210,D0,0E23,
                        C208,D0,0E22,
                        C3F8,D0,0E20,
                        C3E8,D0,0E0E,
                        C3D8,D0,0E0C,
                        C3C8,D0,0E0A,
                        C200,C0,0E06,
                        C3F0,C0,0E04,
                        C3E0,C0,0E02
}


;;; $9654: 'Planet Zebes' ;;;
{
$8C:9654             dx 000B,
                        0028,F8,009E,
                        0020,F8,009A,
                        0018,F8,009D,
                        0010,F8,009A,
                        0008,F8,009C,
                        01F8,F8,009B,
                        01F0,F8,009A,
                        01E8,F8,0099,
                        01E0,F8,0098,
                        01D8,F8,0097,
                        01D0,F8,008F
}


;;; $968D: '惑星ゼーベス' ;;;
{
$8C:968D             dx 000C,
                        0010,00,00AA,
                        0008,00,00A9,
                        0000,00,00A8,
                        01F8,00,00A7,
                        01F0,00,00A6,
                        01E8,00,00A5,
                        0010,F8,00A4,
                        0008,F8,00A3,
                        0000,F8,00A2,
                        01F8,F8,00A1,
                        01F0,F8,00A0,
                        01E8,F8,009F
}


;;; $96CB: Unused. Zebes stars 1 ;;;
{
$8C:96CB             dx 001D,
                        01F0,38,0809,
                        0000,50,0809,
                        0060,48,0809,
                        0030,48,0808,
                        0038,20,0808,
                        0048,30,0850,
                        0070,28,0800,
                        0070,10,0808,
                        0050,F0,0840,
                        0068,D8,08AB,
                        0038,B8,0808,
                        0060,A8,0850,
                        0048,88,0800,
                        0070,88,0809,
                        01B8,20,0840,
                        0190,38,0809,
                        01E8,88,0840,
                        01F0,98,0809,
                        01D8,A8,0809,
                        01C8,90,0809,
                        0188,10,0800,
                        0198,E8,0809,
                        01B0,D8,0808,
                        0188,D8,0840,
                        01B0,B8,08AB,
                        01A8,A0,0800,
                        0198,A8,0840,
                        0188,B0,0809,
                        0190,88,0800
}


;;; $975E: Zebes stars 2 ;;;
{
$8C:975E             dx 000C,
                        0038,D8,0840,
                        0040,E8,0809,
                        0028,F8,0809,
                        0018,E0,0809,
                        01E8,38,0809,
                        0000,28,0808,
                        01D8,28,0840,
                        0000,08,08AB,
                        01F8,F0,0800,
                        01E8,F8,0840,
                        01D8,00,0809,
                        01E0,D8,0800
}


;;; $979C: Zebes stars 3 ;;;
{
$8C:979C             dx 0006,
                        0000,40,0840,
                        0018,28,08AB,
                        01E8,08,0808,
                        0010,F8,0850,
                        01F8,D8,0800,
                        0020,D8,0809
}


;;; $97BC: Zebes stars 4 ;;;
{
$8C:97BC             dx 0004,
                        0040,E8,0809,
                        0008,D0,0840,
                        01E0,E8,0809,
                        01D8,C0,0800
}


;;; $97D2: Zebes stars 5 ;;;
{
$8C:97D2             dx 0007,
                        01B0,00,0809,
                        0010,F8,0809,
                        01E0,F8,0808,
                        01E8,D0,0808,
                        01F8,E0,0850,
                        0020,D8,0800,
                        0020,C0,0808
}


;;; $97F7: Intro Mother Brain explosion - small (frame 1) ;;;
{
$8C:97F7             dx 0001,
                        01FC,FC,3A53
}


;;; $97FE: Intro Mother Brain explosion - small (frame 2) ;;;
{
$8C:97FE             dx 0001,
                        01FC,FC,3A51
}


;;; $9805: Intro Mother Brain explosion - small (frame 3) ;;;
{
$8C:9805             dx 0004,
                        0000,00,FA60,
                        0000,F8,7A60,
                        01F8,00,BA60,
                        01F8,F8,3A60
}


;;; $981B: Intro Mother Brain explosion - small (frame 4) ;;;
{
$8C:981B             dx 0004,
                        0000,00,FA61,
                        0000,F8,7A61,
                        01F8,00,BA61,
                        01F8,F8,3A61
}


;;; $9831: Intro Mother Brain explosion - small (frame 5) ;;;
{
$8C:9831             dx 0004,
                        0000,00,FA62,
                        0000,F8,7A62,
                        01F8,00,BA62,
                        01F8,F8,3A62
}


;;; $9847: Intro Mother Brain explosion - small (frame 6) ;;;
{
$8C:9847             dx 0004,
                        0000,00,FA63,
                        0000,F8,7A63,
                        01F8,00,BA63,
                        01F8,F8,3A63
}


;;; $985D: Intro Mother Brain explosion - big (frame 1) ;;;
{
$8C:985D             dx 0001,
                        01FC,FC,3A5F
}


;;; $9864: Intro Mother Brain explosion - big (frame 2) ;;;
{
$8C:9864             dx 0004,
                        0000,00,FA8A,
                        01F8,00,BA8A,
                        0000,F8,7A8A,
                        01F8,F8,3A8A
}


;;; $987A: Intro Mother Brain explosion - big (frame 3) ;;;
{
$8C:987A             dx 0004,
                        C200,00,FA90,
                        C3F0,00,BA90,
                        C200,F0,7A90,
                        C3F0,F0,3A90
}


;;; $9890: Intro Mother Brain explosion - big (frame 4) ;;;
{
$8C:9890             dx 0004,
                        C200,00,FA92,
                        C3F0,00,BA92,
                        C200,F0,7A92,
                        C3F0,F0,3A92
}


;;; $98A6: Intro Mother Brain explosion - big (frame 5) ;;;
{
$8C:98A6             dx 0004,
                        C200,00,FA94,
                        C3F0,00,BA94,
                        C200,F0,7A94,
                        C3F0,F0,3A94
}


;;; $98BC: Intro Mother Brain explosion - big (frame 6) ;;;
{
$8C:98BC             dx 0004,
                        C200,00,FA96,
                        C3F0,00,BA96,
                        C200,F0,7A96,
                        C3F0,F0,3A96
}


;;; $98D2: Ceres explosion 3 frame 1 ;;;
{
$8C:98D2             dx 0001,
                        C3F8,F6,3A76
}


;;; $98D9: Ceres explosion 3 frame 2 ;;;
{
$8C:98D9             dx 0001,
                        C3F8,F4,3A78
}


;;; $98E0: Ceres explosion 3 frame 3 ;;;
{
$8C:98E0             dx 0001,
                        C3F8,F2,3A98
}


;;; $98E7: Ceres explosion 3 frame 4 ;;;
{
$8C:98E7             dx 0001,
                        C3F8,F0,3A9E
}


;;; $98EE: Ceres final explosion (frame 1) ;;;
{
$8C:98EE             dx 0004,
                        0000,00,FA8A,
                        01F8,00,BA8A,
                        0000,F8,7A8A,
                        01F8,F8,3A8A
}


;;; $9904: Ceres final explosion (frame 2) ;;;
{
$8C:9904             dx 0004,
                        C200,00,FA90,
                        C200,F0,7A90,
                        C3F0,00,BA90,
                        C3F0,F0,3A90
}


;;; $991A: Ceres final explosion (frame 3) ;;;
{
$8C:991A             dx 0004,
                        C200,00,FA92,
                        C3F0,00,BA92,
                        C200,F0,7A92,
                        C3F0,F0,3A92
}


;;; $9930: Ceres final explosion (frame 4) ;;;
{
$8C:9930             dx 000C,
                        0010,00,FAC2,
                        0010,F8,7AC2,
                        0000,10,FAB2,
                        01F8,10,BAB2,
                        01E8,00,BAC2,
                        01E8,F8,3AC2,
                        0000,E8,7AB2,
                        01F8,E8,3AB2,
                        C200,00,FAB0,
                        C200,F0,7AB0,
                        C3F0,00,BAB0,
                        C3F0,F0,3AB0
}


;;; $996E: Ceres final explosion (frame 5) ;;;
{
$8C:996E             dx 0008,
                        C208,00,FAB5,
                        C200,08,FAB3,
                        C3E8,00,BAB5,
                        C3F0,08,BAB3,
                        C208,F0,7AB5,
                        C200,E8,7AB3,
                        C3E8,F0,3AB5,
                        C3F0,E8,3AB3
}


;;; $9998: Ceres final explosion (frame 6) ;;;
{
$8C:9998             dx 000C,
                        0000,10,FABB,
                        01F8,10,BABB,
                        0000,E8,7ABB,
                        01F8,E8,3ABB,
                        0010,00,FAB7,
                        0010,F8,7AB7,
                        01E8,00,BAB7,
                        01E8,F8,3AB7,
                        C208,08,FAB8,
                        C3E8,08,BAB8,
                        C208,E8,7AB8,
                        C3E8,E8,3AB8
}
}


;;; $99D6..BC5C: Ending sequence spritemaps ;;;
{
;;; $99D6: Large Samus from ending (standing) ;;;
{
$8C:99D6             dx 0022,
                        C210,08,3CBE,
                        C210,F8,3C9E,
                        C210,E8,3C7E,
                        C210,D8,3C5E,
                        0018,38,3CE6,
                        0018,30,3CD6,
                        C208,30,3CD4,
                        0018,D8,3C26,
                        0018,D0,3C16,
                        0018,C8,3C06,
                        01F0,10,3C91,
                        01F0,08,3C81,
                        01E8,08,3C80,
                        01F0,28,3CC1,
                        C3F8,30,3CD2,
                        C3E8,30,3CD0,
                        C208,28,3CC4,
                        C3F8,28,3CC2,
                        C208,18,3CA4,
                        C3F8,18,3CA2,
                        C208,08,3C84,
                        C3F8,08,3C82,
                        C208,F8,3C64,
                        C3F8,F8,3C62,
                        C3E8,F8,3C60,
                        C208,E8,3C44,
                        C3F8,E8,3C42,
                        C3E8,E8,3C40,
                        C208,D8,3C24,
                        C3F8,D8,3C22,
                        C3E8,D8,3C20,
                        C208,C8,3C04,
                        C3F8,C8,3C02,
                        C3E8,C8,3C00
}


;;; $9A82: Large Samus from ending (preparing to jump) ;;;
{
$8C:9A82             dx 0016,
                        01DA,DD,3D00,
                        C3DA,E5,3D10,
                        0012,D5,3CF7,
                        000A,D5,3CF6,
                        01F2,D5,3CF3,
                        01EA,D5,3CF2,
                        01E2,D5,3CF1,
                        01EA,ED,3D22,
                        C212,ED,3D27,
                        C202,2D,3DA5,
                        C202,1D,3D85,
                        C3F2,1D,3D83,
                        C202,0D,3D65,
                        C3F2,0D,3D63,
                        C202,FD,3D45,
                        C3F2,FD,3D43,
                        C202,ED,3D25,
                        C3F2,ED,3D23,
                        C212,DD,3D07,
                        C202,DD,3D05,
                        C3F2,DD,3D03,
                        C3E2,DD,3D01
}


;;; $9AF2: Large Samus from ending (jumping) ;;;
{
$8C:9AF2             dx 0014,
                        C3FC,CB,3C1B,
                        C213,D3,3C2E,
                        C213,C3,3C0E,
                        C3E5,C2,3C08,
                        C3DC,D4,3C27,
                        C3DC,CC,3C17,
                        C20C,DB,3C3D,
                        C3FC,DB,3C3B,
                        C3EC,DB,3C39,
                        C20C,CB,3C1D,
                        C3EC,CB,3C19,
                        C200,EB,3C5C,
                        C3F0,EB,3C5A,
                        0000,33,3CEC,
                        C200,23,3CCC,
                        C200,13,3CAC,
                        C200,03,3C8C,
                        C3F0,03,3C8A,
                        C200,F3,3C6C,
                        C3F0,F3,3C6A
}


;;; $9B58: Large Samus helmet from ending (frame 1) ;;;
{
$8C:9B58             dx 0005,
                        0004,03,3C98,
                        01FC,03,3C97,
                        01F4,03,3C96,
                        C3F4,F3,3C76,
                        C3FC,F3,3C77
}


;;; $9B73: Large Samus helmet from ending (frame 2) ;;;
{
$8C:9B73             dx 0005,
                        C3FC,FA,3C57,
                        0004,F2,3C48,
                        01FC,F2,3C47,
                        01F4,F2,3C46,
                        C3F4,FA,3C56
}


;;; $9B8E: Jumping Samus head from ending ;;;
{
$8C:9B8E             dx 0003,
                        0000,F2,3B48,
                        01F8,F2,3B47,
                        C3F8,FA,3B57
}


;;; $9B9F: Samus arm from ending (frame 1) ;;;
{
$8C:9B9F             dx 0005,
                        C20C,F5,3CEE,
                        C211,ED,3CE9,
                        C210,DE,3D59,
                        0018,D6,3D4A,
                        0010,D6,3D49
}


;;; $9BBA: Samus arm from ending (frame 2) ;;;
{
$8C:9BBA             dx 0006,
                        0008,F4,3D1D,
                        0008,EC,3D0D,
                        C210,EC,3D0E,
                        C210,DF,3D59,
                        0018,D7,3D4A,
                        0010,D7,3D49
}


;;; $9BDA: Samus arm from ending (frame 3) ;;;
{
$8C:9BDA             dx 0005,
                        C209,E8,3D29,
                        C213,E8,3D09,
                        C210,DF,3D59,
                        0018,D7,3D4A,
                        0010,D7,3D49
}


;;; $9BF5: Samus arm from ending (frame 4) ;;;
{
$8C:9BF5             dx 0005,
                        C20A,E6,3D29,
                        C214,E7,3D09,
                        C211,DF,3D59,
                        0019,D7,3D4A,
                        0011,D7,3D49
}


;;; $9C10: Samus arm from ending (frame 5) ;;;
{
$8C:9C10             dx 0005,
                        C20D,E5,3D29,
                        C214,E8,3D09,
                        C211,DF,3D59,
                        0019,D7,3D4A,
                        0011,D7,3D49
}


;;; $9C2B: Samus arm from ending (frame 6) ;;;
{
$8C:9C2B             dx 0005,
                        C20E,E4,3D2B,
                        C213,E7,3D0B,
                        C211,DF,3D59,
                        0019,D7,3D4A,
                        0011,D7,3D49
}


;;; $9C46: Samus arm from ending (frame 7) ;;;
{
$8C:9C46             dx 0005,
                        C20E,E8,3D2B,
                        C213,E9,3D0B,
                        C211,DF,3D59,
                        0019,D7,3D4A,
                        0011,D7,3D49
}


;;; $9C61: Samus arm from ending (frame 8) ;;;
{
$8C:9C61             dx 0005,
                        C20E,E9,3D2B,
                        C213,E9,3D0B,
                        C211,DF,3D59,
                        0019,D7,3D4A,
                        0011,D7,3D49
}


;;; $9C7C: Samus head from ending (frame 1) ;;;
{
$8C:9C7C             dx 0002,
                        C3F8,F8,3B88,
                        C3F8,F0,3B78
}


;;; $9C88: Samus head from ending (frame 2) ;;;
{
$8C:9C88             dx 0002,
                        C3F8,F8,3B8A,
                        C3F8,F0,3B78
}


;;; $9C94: Samus head from ending (frame 3) ;;;
{
$8C:9C94             dx 0002,
                        C3F8,F8,3B8C,
                        C3F8,F0,3B78
}


;;; $9CA0: Samus head from ending (frame 4) ;;;
{
$8C:9CA0             dx 0002,
                        C3F8,F8,3B8E,
                        C3F8,F0,3B78
}


;;; $9CAC: Samus head with helmet from ending ;;;
{
$8C:9CAC             dx 0004,
                        01FC,04,3DC9,
                        01F4,04,3DC8,
                        C3FC,F4,3DA9,
                        C3F4,F4,3DA8
}


;;; $9CC2: Headless, armless, suited Samus ;;;
{
$8C:9CC2             dx 001E,
                        0018,38,3CE6,
                        0018,30,3CD6,
                        C208,30,3CD4,
                        0018,D8,3C26,
                        0018,D0,3C16,
                        0018,C8,3C06,
                        01F0,10,3C91,
                        01F0,08,3C81,
                        01E8,08,3C80,
                        01F0,28,3CC1,
                        C3F8,30,3CD2,
                        C3E8,30,3CD0,
                        C208,28,3CC4,
                        C3F8,28,3CC2,
                        C208,18,3CA4,
                        C3F8,18,3CA2,
                        C208,08,3C84,
                        C3F8,08,3C82,
                        C208,F8,3C64,
                        C3F8,F8,3C62,
                        C3E8,F8,3C60,
                        C208,E8,3C44,
                        C3F8,E8,3C42,
                        C3E8,E8,3C40,
                        C208,D8,3C24,
                        C3F8,D8,3C22,
                        C3E8,D8,3C20,
                        C208,C8,3C04,
                        C3F8,C8,3C02,
                        C3E8,C8,3C00
}


;;; $9D5A: Samus - falling ;;;
{
$8C:9D5A             dx 000F,
                        0008,08,0C54,
                        0008,00,0C44,
                        0008,F8,0C34,
                        0000,20,0C83,
                        0000,18,0C73,
                        0000,10,0C63,
                        01F0,F0,0C21,
                        01E8,F0,0C20,
                        0010,F0,0C25,
                        0008,F0,0C24,
                        C3E8,E0,0C00,
                        C208,E0,0C04,
                        C3F8,00,0C42,
                        C3F8,F0,0C22,
                        C3F8,E0,0C02
}


;;; $9DA7: Samus - landing ;;;
{
$8C:9DA7             dx 000D,
                        01F8,17,0C78,
                        0008,1F,0C8A,
                        0000,1F,0C89,
                        C200,0F,0C69,
                        C200,FF,0C49,
                        0010,F7,0C3B,
                        0008,F7,0C3A,
                        C3E8,EF,0C26,
                        01F0,E7,0C17,
                        C208,E7,0C1A,
                        C3F8,07,0C58,
                        C3F8,F7,0C38,
                        C3F8,E7,0C18
}


;;; $9DEA: Samus - landed ;;;
{
$8C:9DEA             dx 0015,
                        01E8,E8,0CB0,
                        01E8,E0,0CA0,
                        0010,D8,0C95,
                        C208,E0,0CA4,
                        01F8,20,0D22,
                        01F0,20,0D21,
                        0010,20,0D25,
                        0008,20,0D24,
                        0000,20,0D23,
                        C200,10,0D03,
                        C3F0,10,0D01,
                        0008,08,0CF4,
                        0000,08,0CF3,
                        01F8,08,0CF2,
                        01F0,08,0CF1,
                        C200,F8,0CD3,
                        C3F0,F8,0CD1,
                        C200,E8,0CB3,
                        C3F0,E8,0CB1,
                        C200,D8,0C93,
                        C3F0,D8,0C91
}


;;; $9E55: Samus - shooting ;;;
{
$8C:9E55             dx 000F,
                        0014,20,0D2C,
                        C204,18,0D1A,
                        01F4,18,0D18,
                        C3E4,18,0D16,
                        01EC,08,0CF7,
                        C204,10,0D0A,
                        C3EC,10,0D07,
                        C204,00,0CEA,
                        C3F4,00,0CE8,
                        C204,E0,0CAA,
                        000C,F0,0CCB,
                        C3FC,F0,0CC9,
                        C3EC,F0,0CC7,
                        C3FC,E0,0CA9,
                        C3EC,E0,0CA7
}


;;; $9EA2: Suitless Samus - standing ;;;
{
$8C:9EA2             dx 001C,
                        0010,28,32A4,
                        01F0,E0,3210,
                        01F0,40,32D0,
                        0008,D8,3203,
                        0008,E0,3213,
                        C208,00,332E,
                        01F0,18,335D,
                        01F0,10,334D,
                        01F0,08,333D,
                        01F0,00,332D,
                        C208,F0,3233,
                        0010,30,32B4,
                        0018,40,32D5,
                        C208,38,32C3,
                        C200,28,32A2,
                        C200,18,3282,
                        C200,08,3262,
                        01F0,F8,3240,
                        01F0,F0,3230,
                        01F0,E8,3220,
                        C208,E8,3223,
                        C3F8,38,32C1,
                        C3F8,28,32A1,
                        C3F8,18,3281,
                        C3F8,08,3261,
                        C3F8,F8,3241,
                        C3F8,E8,3221,
                        C3F8,D8,3201
}


;;; $9F30: Suitless Samus - preparing to jump ;;;
{
$8C:9F30             dx 0014,
                        01F0,08,3256,
                        01F0,00,3246,
                        01F0,F8,3236,
                        01F0,F0,3226,
                        01F0,E8,3216,
                        0008,E8,3219,
                        01F0,20,3286,
                        C200,40,32C8,
                        C200,30,32A8,
                        C200,20,3288,
                        C208,10,3269,
                        C3E8,10,3265,
                        C208,00,3249,
                        C208,F0,3229,
                        C3F8,30,32A7,
                        C3F8,20,3287,
                        C3F8,10,3267,
                        C3F8,00,3247,
                        C3F8,F0,3227,
                        C3F8,E0,3207
}


;;; $9F96: Suitless Samus - jumping ;;;
{
$8C:9F96             dx 0013,
                        0010,F0,32BB,
                        0010,E8,32AB,
                        0010,E0,329B,
                        0010,D8,328B,
                        01E8,E8,322B,
                        01E8,E0,321B,
                        01E8,D8,320B,
                        C200,38,32CE,
                        C200,28,32AE,
                        C200,18,328E,
                        C3F0,18,328C,
                        C200,08,326E,
                        C3F0,08,326C,
                        C200,F8,324E,
                        C3F0,F8,324C,
                        C200,E8,322E,
                        C3F0,E8,322C,
                        C200,D8,320E,
                        C3F0,D8,320C
}


;;; $9FF7: Suitless Samus - standing, arms straight ;;;
{
$8C:9FF7             dx 001C,
                        0009,E0,3393,
                        0008,18,33B5,
                        0008,10,33A5,
                        0008,08,3395,
                        0008,00,3385,
                        0008,18,3283,
                        0008,10,3273,
                        0008,08,3263,
                        01F0,40,32D0,
                        0018,40,32D5,
                        C3F8,38,32C1,
                        C208,38,32C3,
                        C208,30,32B3,
                        C208,20,3293,
                        C3F8,30,32B1,
                        C3F8,20,3291,
                        C3F8,10,3271,
                        C3F8,00,3251,
                        01F1,E8,33A0,
                        0009,E8,33A3,
                        C3F9,E8,33A1,
                        01F3,18,33B4,
                        01F3,10,33A4,
                        01F3,08,3394,
                        01F3,00,3384,
                        C201,F0,33B2,
                        C3F1,F0,33B0,
                        C3F9,D8,3381
}


;;; $A085: Suitless Samus opening hair (frame 1) ;;;
{
$8C:A085             dx 0009,
                        0009,E0,3393,
                        0009,E8,33A3,
                        0001,D8,3382,
                        01F9,D8,3381,
                        C3F9,E0,3391,
                        0008,00,33A9,
                        01F0,00,33A6,
                        C200,F0,3388,
                        C3F0,F0,3386
}


;;; $A0B4: Suitless Samus opening hair (frame 2) ;;;
{
$8C:A0B4             dx 000A,
                        C3F8,D8,32E1,
                        0008,E0,32F3,
                        C3EF,E8,33B6,
                        C202,E7,33B8,
                        0008,D8,32E3,
                        C3F0,E8,3300,
                        C200,E8,3302,
                        0008,F8,3323,
                        0000,F8,3322,
                        01F8,F8,3321
}


;;; $A0E8: Suitless Samus opening hair (frame 3) ;;;
{
$8C:A0E8             dx 000A,
                        0008,E0,32F3,
                        C3F8,D8,32E1,
                        C3EE,E8,33B6,
                        C203,E7,33B8,
                        0008,D8,32E3,
                        C3F0,E8,3300,
                        C200,E8,3302,
                        0008,F8,3323,
                        0000,F8,3322,
                        01F8,F8,3321
}


;;; $A11C: Suitless Samus opening hair (frame 4) ;;;
{
$8C:A11C             dx 000A,
                        C3F8,D8,32E1,
                        0008,E0,32F3,
                        C3EE,E7,33B6,
                        C203,E6,33B8,
                        0008,D8,32E3,
                        C3F0,E8,3300,
                        C200,E8,3302,
                        0008,F8,3323,
                        0000,F8,3322,
                        01F8,F8,3321
}


;;; $A150: Suitless Samus opening hair (frame 5) ;;;
{
$8C:A150             dx 0009,
                        01F0,E8,3304,
                        C208,E8,3307,
                        C200,D8,32E6,
                        0008,F8,3327,
                        0000,F8,3326,
                        01F8,F8,3325,
                        C3F0,F0,3314,
                        C3F8,E8,3305,
                        C3F8,D8,32E5
}


;;; $A17F: Suitless Samus opening hair (frame 6) ;;;
{
$8C:A17F             dx 000A,
                        01F0,00,3329,
                        01F0,F8,3319,
                        01F0,F0,3309,
                        C208,F0,330C,
                        C208,E0,32EC,
                        01F0,E8,32F9,
                        01F0,E0,32E9,
                        C3F8,D8,32DA,
                        C3F8,F0,330A,
                        C3F8,E0,32EA
}


;;; $A1B3: Suitless Samus opening hair (frame 7) ;;;
{
$8C:A1B3             dx 000F,
                        01F0,18,335D,
                        01F0,10,334D,
                        01F0,08,333D,
                        01F0,00,332D,
                        0010,F8,3374,
                        0020,F0,3366,
                        0020,E8,3356,
                        0020,E0,3346,
                        C210,E8,3354,
                        C210,D8,3334,
                        C3F8,D8,3331,
                        C200,F0,3362,
                        C3F0,F0,3360,
                        C200,E0,3342,
                        C3F0,E0,3340
}


;;; $A200: Suitless Samus opening hair (frame 8) ;;;
{
$8C:A200             dx 000D,
                        01F0,18,335D,
                        01F0,10,334D,
                        01F0,08,333D,
                        01F0,00,332D,
                        0008,D8,333A,
                        0000,D8,3339,
                        01F8,D8,3338,
                        C210,F0,336B,
                        C210,E0,334B,
                        C200,F0,3369,
                        C3F0,F0,3367,
                        C200,E0,3349,
                        C3F0,E0,3347
}


;;; $A243: Suitless Samus lower body ;;;
{
$8C:A243             dx 000E,
                        0008,00,3253,
                        01F0,40,32D0,
                        0018,40,32D5,
                        C3F8,38,32C1,
                        C208,38,32C3,
                        0008,18,3283,
                        0008,10,3273,
                        0008,08,3263,
                        C208,30,32B3,
                        C208,20,3293,
                        C3F8,30,32B1,
                        C3F8,20,3291,
                        C3F8,10,3271,
                        C3F8,00,3251
}


;;; $A28B: Zebes boom starry background ;;;
{
$8C:A28B             dx 0035,
                        C3AB,3C,0EED,
                        C3BB,D3,0EED,
                        C25C,4E,0EED,
                        0075,C6,0EFA,
                        0068,DB,0EF9,
                        0042,CA,0EF9,
                        001E,D7,0EF9,
                        01CD,CE,0EF9,
                        01FE,54,0EFB,
                        01A7,30,0EF8,
                        01EC,D2,0EF8,
                        0014,29,0EFA,
                        0016,F4,0EFA,
                        01A2,58,0EFA,
                        019E,12,0EFB,
                        01ED,74,0EFA,
                        0022,61,0EFA,
                        0038,34,0EFA,
                        0049,29,0EFA,
                        01D0,5C,0EFA,
                        01BA,33,0EFA,
                        019A,40,0EFA,
                        01AA,20,0EFA,
                        0194,B8,0EFB,
                        01AC,A6,0EF9,
                        0059,9D,0EF9,
                        005E,B7,0EF9,
                        01E7,A5,0EFB,
                        01B8,FF,0EFB,
                        002E,44,0EFB,
                        01E0,04,0EF9,
                        01D0,24,0EFC,
                        01E9,34,0EFA,
                        0056,FB,0EF8,
                        0022,B4,0EF8,
                        01B8,79,0EF8,
                        003C,E7,0EFC,
                        0075,22,0EFC,
                        0076,6F,0EF8,
                        01D3,50,0EF9,
                        006C,5E,0EF8,
                        004E,5D,0EFA,
                        01E1,C0,0EF8,
                        004C,4A,0EF9,
                        01BB,B9,0EF9,
                        01C1,69,0EF8,
                        002F,23,0EFA,
                        0046,7A,0EFA,
                        0000,E7,0EFB,
                        006C,2E,0EFB,
                        01D3,E6,0EF9,
                        0003,CD,0EFA,
                        01B1,E2,0EF8
}


;;; $A396: Exploding Planet Zebes (frame 1) ;;;
{
$8C:A396             dx 0004,
                        C200,00,0E22,
                        C3F0,00,0E20,
                        C200,F0,0E02,
                        C3F0,F0,0E00
}


;;; $A3AC: Exploding Planet Zebes (frame 2) ;;;
{
$8C:A3AC             dx 0004,
                        C200,00,0E26,
                        C3F0,00,0E24,
                        C200,F0,0E06,
                        C3F0,F0,0E04
}


;;; $A3C2: Exploding Planet Zebes (frame 3) ;;;
{
$8C:A3C2             dx 0004,
                        C200,00,0E2A,
                        C3F0,00,0E28,
                        C200,F0,0E0A,
                        C3F0,F0,0E08
}


;;; $A3D8: Exploding Planet Zebes (frame 4) ;;;
{
$8C:A3D8             dx 0004,
                        C200,00,0E2E,
                        C3F0,00,0E2C,
                        C200,F0,0E0E,
                        C3F0,F0,0E0C
}


;;; $A3EE: Exploding Planet Zebes (frame 5) ;;;
{
$8C:A3EE             dx 0004,
                        C200,00,0E62,
                        C3F0,00,0E60,
                        C200,F0,0E42,
                        C3F0,F0,0E40
}


;;; $A404: Exploding Planet Zebes (frame 6) ;;;
{
$8C:A404             dx 0004,
                        C200,00,0E66,
                        C3F0,00,0E64,
                        C200,F0,0E46,
                        C3F0,F0,0E44
}


;;; $A41A: Exploding Planet Zebes (frame 7) ;;;
{
$8C:A41A             dx 0004,
                        C200,00,0E6A,
                        C3F0,00,0E68,
                        C200,F0,0E4A,
                        C3F0,F0,0E48
}


;;; $A430: Exploding Planet Zebes (frame 8) ;;;
{
$8C:A430             dx 0004,
                        C200,00,0E6E,
                        C3F0,00,0E6C,
                        C200,F0,0E4E,
                        C3F0,F0,0E4C
}


;;; $A446: Exploding Planet Zebes core (frame 1) ;;;
{
$8C:A446             dx 0004,
                        C200,00,CA99,
                        C3F0,00,8A99,
                        C200,F0,4A99,
                        C3F0,F0,0A99
}


;;; $A45C: Exploding Planet Zebes core (frame 2) ;;;
{
$8C:A45C             dx 0004,
                        C200,00,CA9B,
                        C200,F0,4A9B,
                        C3F0,00,8A9B,
                        C3F0,F0,0A9B
}


;;; $A472: Exploding Planet Zebes glow ;;;
{
$8C:A472             dx 000C,
                        C200,E8,4E81,
                        C208,F0,4E90,
                        C200,F0,4E91,
                        C200,08,CE81,
                        C208,00,CE90,
                        C200,00,CE91,
                        C3F0,08,8E81,
                        C3E8,00,8E90,
                        C3F0,00,8E91,
                        C3F0,E8,0E81,
                        C3E8,F0,0E90,
                        C3F0,F0,0E91
}


;;; $A4B0: The Zebes Supernova (part 1) ;;;
{
$8C:A4B0             dx 0014,
                        0010,F8,4EA3,
                        0010,F0,4E93,
                        0000,E8,4E85,
                        0008,E8,4E84,
                        C200,F0,4E94,
                        0010,00,CEA3,
                        0010,08,CE93,
                        0000,10,CE85,
                        0008,10,CE84,
                        C200,00,CE94,
                        01E8,00,8EA3,
                        01E8,08,8E93,
                        01F8,10,8E85,
                        01F0,10,8E84,
                        C3F0,00,8E94,
                        01E8,F8,0EA3,
                        01E8,F0,0E93,
                        01F8,E8,0E85,
                        01F0,E8,0E84,
                        C3F0,F0,0E94
}


;;; $A516: The Zebes Supernova (part 2) ;;;
{
$8C:A516             dx 0014,
                        01E8,F8,0EA6,
                        01E8,F0,0E96,
                        01F8,E8,0E88,
                        01F0,E8,0E87,
                        C3F0,F0,0E97,
                        0010,F8,4EA6,
                        0010,F0,4E96,
                        0000,E8,4E88,
                        0008,E8,4E87,
                        C200,F0,4E97,
                        0010,00,CEA6,
                        0010,08,CE96,
                        0000,10,CE88,
                        0008,10,CE87,
                        C200,00,CE97,
                        01E8,00,8EA6,
                        01E8,08,8E96,
                        01F8,10,8E88,
                        01F0,10,8E87,
                        C3F0,00,8E97
}


;;; $A57C: The Zebes Supernova (part 3) ;;;
{
$8C:A57C             dx 0014,
                        C200,08,3ACC,
                        C210,08,3ACE,
                        0000,18,3AEC,
                        C3E0,10,3AD8,
                        C210,00,3ABE,
                        C200,00,3ABC,
                        C3F0,00,3ABA,
                        C3E0,00,3AB8,
                        C210,F0,3AE6,
                        C200,F0,3AE4,
                        C3F0,F0,3AE2,
                        C3E0,F0,3AE0,
                        C210,E8,3AD6,
                        C200,E8,3AD4,
                        C3F0,E8,3AD2,
                        C3E0,E8,3AD0,
                        C210,D8,3AB6,
                        C200,D8,3AB4,
                        C3F0,D8,3AB2,
                        C3E0,D8,3AB0
}


;;; $A5E2: The Zebes Supernova (part 4) ;;;
{
$8C:A5E2             dx 0025,
                        01F0,20,0D8C,
                        0008,20,0D8F,
                        0000,20,0D8E,
                        01F8,20,0D8D,
                        01E0,18,0DE4,
                        0010,18,0DEA,
                        01E8,18,0DE5,
                        C200,10,0DD8,
                        C3F0,10,0DD6,
                        0008,E0,0D83,
                        0000,E0,0D82,
                        01F8,E0,0D81,
                        01F0,E0,0D80,
                        C230,00,0DBE,
                        C3C0,00,0DB0,
                        01D8,F0,0D93,
                        01D0,F0,0D92,
                        0028,F0,0D9D,
                        0020,F0,0D9C,
                        C210,E8,0D8A,
                        C200,E8,0D88,
                        C3F0,E8,0D86,
                        C3E0,E8,0D84,
                        C220,08,0DCC,
                        C210,08,0DCA,
                        C200,08,0DC8,
                        C3F0,08,0DC6,
                        C3E0,08,0DC4,
                        C3D0,08,0DC2,
                        C230,F8,0DAE,
                        C220,F8,0DAC,
                        C210,F8,0DAA,
                        C200,F8,0DA8,
                        C3F0,F8,0DA6,
                        C3E0,F8,0DA4,
                        C3D0,F8,0DA2,
                        C3C0,F8,0DA0
}


;;; $A69D: 'T' ;;;
{
$8C:A69D             dx 0002,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A6A9: 'TH' ;;;
{
$8C:A6A9             dx 0004,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A6BF: 'THE' ;;;
{
$8C:A6BF             dx 0006,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A6DF: 'THE O' ;;;
{
$8C:A6DF             dx 0008,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A709: 'THE OP' ;;;
{
$8C:A709             dx 000A,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A73D: 'THE OPE' ;;;
{
$8C:A73D             dx 000C,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A77B: 'THE OPER' ;;;
{
$8C:A77B             dx 000E,
                        01F0,00,3151,
                        01F0,F8,3141,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A7C3: 'THE OPERA' ;;;
{
$8C:A7C3             dx 0010,
                        01F8,00,3130,
                        01F8,F8,3120,
                        01F0,00,3151,
                        01F0,F8,3141,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A815: 'THE OPERAT' ;;;
{
$8C:A815             dx 0012,
                        0000,00,3153,
                        0000,F8,3143,
                        01F8,00,3130,
                        01F8,F8,3120,
                        01F0,00,3151,
                        01F0,F8,3141,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A871: 'THE OPERATI' ;;;
{
$8C:A871             dx 0014,
                        0008,00,3138,
                        0008,F8,3128,
                        0000,00,3153,
                        0000,F8,3143,
                        01F8,00,3130,
                        01F8,F8,3120,
                        01F0,00,3151,
                        01F0,F8,3141,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A8D7: 'THE OPERATIO ;;;
{
$8C:A8D7             dx 0016,
                        0010,00,313E,
                        0010,F8,312E,
                        0008,00,3138,
                        0008,F8,3128,
                        0000,00,3153,
                        0000,F8,3143,
                        01F8,00,3130,
                        01F8,F8,3120,
                        01F0,00,3151,
                        01F0,F8,3141,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A947: 'THE OPERATION' ;;;
{
$8C:A947             dx 0018,
                        0018,00,313D,
                        0018,F8,312D,
                        0010,00,313E,
                        0010,F8,312E,
                        0008,00,3138,
                        0008,F8,3128,
                        0000,00,3153,
                        0000,F8,3143,
                        01F8,00,3130,
                        01F8,F8,3120,
                        01F0,00,3151,
                        01F0,F8,3141,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $A9C1: 'THE OPERATION W' ;;;
{
$8C:A9C1             dx 001A,
                        0028,00,3156,
                        0028,F8,3146,
                        0018,00,313D,
                        0018,F8,312D,
                        0010,00,313E,
                        0010,F8,312E,
                        0008,00,3138,
                        0008,F8,3128,
                        0000,00,3153,
                        0000,F8,3143,
                        01F8,00,3130,
                        01F8,F8,3120,
                        01F0,00,3151,
                        01F0,F8,3141,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $AA45: 'THE OPERATION WA' ;;;
{
$8C:AA45             dx 001C,
                        0030,00,3130,
                        0030,F8,3120,
                        0028,00,3156,
                        0028,F8,3146,
                        0018,00,313D,
                        0018,F8,312D,
                        0010,00,313E,
                        0010,F8,312E,
                        0008,00,3138,
                        0008,F8,3128,
                        0000,00,3153,
                        0000,F8,3143,
                        01F8,00,3130,
                        01F8,F8,3120,
                        01F0,00,3151,
                        01F0,F8,3141,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $AAD3: 'THE OPERATION WAS' ;;;
{
$8C:AAD3             dx 001E,
                        0038,00,3152,
                        0038,F8,3142,
                        0030,00,3130,
                        0030,F8,3120,
                        0028,00,3156,
                        0028,F8,3146,
                        0018,00,313D,
                        0018,F8,312D,
                        0010,00,313E,
                        0010,F8,312E,
                        0008,00,3138,
                        0008,F8,3128,
                        0000,00,3153,
                        0000,F8,3143,
                        01F8,00,3130,
                        01F8,F8,3120,
                        01F0,00,3151,
                        01F0,F8,3141,
                        01E8,00,3134,
                        01E8,F8,3124,
                        01E0,00,313F,
                        01E0,F8,312F,
                        01D8,00,313E,
                        01D8,F8,312E,
                        01C8,00,3134,
                        01C8,F8,3124,
                        01C0,00,3137,
                        01C0,F8,3127,
                        01B8,00,3153,
                        01B8,F8,3143
}


;;; $AB6B: 'C' ;;;
{
$8C:AB6B             dx 0002,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AB77: 'CO' ;;;
{
$8C:AB77             dx 0004,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AB8D: 'COM' ;;;
{
$8C:AB8D             dx 0006,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $ABAD: 'COMP' ;;;
{
$8C:ABAD             dx 0008,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $ABD7: 'COMPL' ;;;
{
$8C:ABD7             dx 000A,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AC0B: 'COMPLE' ;;;
{
$8C:AC0B             dx 000C,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AC49: 'COMPLET' ;;;
{
$8C:AC49             dx 000E,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AC91: 'COMPLETE' ;;;
{
$8C:AC91             dx 0010,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $ACE3: 'COMPLETED' ;;;
{
$8C:ACE3             dx 0012,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AD3F: 'COMPLETED S' ;;;
{
$8C:AD3F             dx 0014,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $ADA5: 'COMPLETED SU' ;;;
{
$8C:ADA5             dx 0016,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AE15: 'COMPLETED SUC' ;;;
{
$8C:AE15             dx 0018,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AE8F: 'COMPLETED SUCC' ;;;
{
$8C:AE8F             dx 001A,
                        0010,18,3132,
                        0010,10,3122,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AF13: 'COMPLETED SUCCE' ;;;
{
$8C:AF13             dx 001C,
                        0018,18,3134,
                        0018,10,3124,
                        0010,18,3132,
                        0010,10,3122,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $AFA1: 'COMPLETED SUCCES' ;;;
{
$8C:AFA1             dx 001E,
                        0020,18,3152,
                        0020,10,3142,
                        0018,18,3134,
                        0018,10,3124,
                        0010,18,3132,
                        0010,10,3122,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $B039: 'COMPLETED SUCCESS' ;;;
{
$8C:B039             dx 0020,
                        0028,18,3152,
                        0028,10,3142,
                        0020,18,3152,
                        0020,10,3142,
                        0018,18,3134,
                        0018,10,3124,
                        0010,18,3132,
                        0010,10,3122,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $B0DB: 'COMPLETED SUCCESSF' ;;;
{
$8C:B0DB             dx 0022,
                        0030,18,3135,
                        0030,10,3125,
                        0028,18,3152,
                        0028,10,3142,
                        0020,18,3152,
                        0020,10,3142,
                        0018,18,3134,
                        0018,10,3124,
                        0010,18,3132,
                        0010,10,3122,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $B187: 'COMPLETED SUCCESSFU' ;;;
{
$8C:B187             dx 0024,
                        0038,18,3154,
                        0038,10,3144,
                        0030,18,3135,
                        0030,10,3125,
                        0028,18,3152,
                        0028,10,3142,
                        0020,18,3152,
                        0020,10,3142,
                        0018,18,3134,
                        0018,10,3124,
                        0010,18,3132,
                        0010,10,3122,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $B23D: 'COMPLETED SUCCESSFUL' ;;;
{
$8C:B23D             dx 0026,
                        0040,18,313B,
                        0040,10,312B,
                        0038,18,3154,
                        0038,10,3144,
                        0030,18,3135,
                        0030,10,3125,
                        0028,18,3152,
                        0028,10,3142,
                        0020,18,3152,
                        0020,10,3142,
                        0018,18,3134,
                        0018,10,3124,
                        0010,18,3132,
                        0010,10,3122,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $B2FD: 'COMPLETED SUCCESSFULL' ;;;
{
$8C:B2FD             dx 0028,
                        0048,18,313B,
                        0048,10,312B,
                        0040,18,313B,
                        0040,10,312B,
                        0038,18,3154,
                        0038,10,3144,
                        0030,18,3135,
                        0030,10,3125,
                        0028,18,3152,
                        0028,10,3142,
                        0020,18,3152,
                        0020,10,3142,
                        0018,18,3134,
                        0018,10,3124,
                        0010,18,3132,
                        0010,10,3122,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $B3C7: 'COMPLETED SUCCESSFULLY' ;;;
{
$8C:B3C7             dx 002A,
                        0050,18,3158,
                        0050,10,3148,
                        0048,18,313B,
                        0048,10,312B,
                        0040,18,313B,
                        0040,10,312B,
                        0038,18,3154,
                        0038,10,3144,
                        0030,18,3135,
                        0030,10,3125,
                        0028,18,3152,
                        0028,10,3142,
                        0020,18,3152,
                        0020,10,3142,
                        0018,18,3134,
                        0018,10,3124,
                        0010,18,3132,
                        0010,10,3122,
                        0008,18,3132,
                        0008,10,3122,
                        0000,18,3154,
                        0000,10,3144,
                        01F8,18,3152,
                        01F8,10,3142,
                        01E8,18,3133,
                        01E8,10,3123,
                        01E0,18,3134,
                        01E0,10,3124,
                        01D8,18,3153,
                        01D8,10,3143,
                        01D0,18,3134,
                        01D0,10,3124,
                        01C8,18,313B,
                        01C8,10,312B,
                        01C0,18,313F,
                        01C0,10,312F,
                        01B8,18,313C,
                        01B8,10,312C,
                        01B0,18,313E,
                        01B0,10,312E,
                        01A8,18,3132,
                        01A8,10,3122
}


;;; $B49B: 'C' ;;;
{
$8C:B49B             dx 0002,
                        01C0,00,3132,
                        01C0,F8,3122
}


;;; $B4A7: 'CL' ;;;
{
$8C:B4A7             dx 0004,
                        01C8,00,313B,
                        01C8,F8,312B,
                        01C0,00,3132,
                        01C0,F8,3122
}


;;; $B4BD: 'CLE' ;;;
{
$8C:B4BD             dx 0006,
                        01D0,00,3134,
                        01D0,F8,3124,
                        01C8,00,313B,
                        01C8,F8,312B,
                        01C0,00,3132,
                        01C0,F8,3122
}


;;; $B4DD: 'CLEA' ;;;
{
$8C:B4DD             dx 0008,
                        01D8,00,3130,
                        01D8,F8,3120,
                        01D0,00,3134,
                        01D0,F8,3124,
                        01C8,00,313B,
                        01C8,F8,312B,
                        01C0,00,3132,
                        01C0,F8,3122
}


;;; $B507: 'CLEAR' ;;;
{
$8C:B507             dx 000A,
                        01E0,00,3151,
                        01E0,F8,3141,
                        01D8,00,3130,
                        01D8,F8,3120,
                        01D0,00,3134,
                        01D0,F8,3124,
                        01C8,00,313B,
                        01C8,F8,312B,
                        01C0,00,3132,
                        01C0,F8,3122
}


;;; $B53B: 'CLEAR T' ;;;
{
$8C:B53B             dx 000C,
                        01F0,00,3153,
                        01F0,F8,3143,
                        01E0,00,3151,
                        01E0,F8,3141,
                        01D8,00,3130,
                        01D8,F8,3120,
                        01D0,00,3134,
                        01D0,F8,3124,
                        01C8,00,313B,
                        01C8,F8,312B,
                        01C0,00,3132,
                        01C0,F8,3122
}


;;; $B579: 'CLEAR TI' ;;;
{
$8C:B579             dx 000E,
                        01F8,00,3138,
                        01F8,F8,3128,
                        01F0,00,3153,
                        01F0,F8,3143,
                        01E0,00,3151,
                        01E0,F8,3141,
                        01D8,00,3130,
                        01D8,F8,3120,
                        01D0,00,3134,
                        01D0,F8,3124,
                        01C8,00,313B,
                        01C8,F8,312B,
                        01C0,00,3132,
                        01C0,F8,3122
}


;;; $B5C1: 'CLEAR TIM' ;;;
{
$8C:B5C1             dx 0010,
                        0000,00,313C,
                        0000,F8,312C,
                        01F8,00,3138,
                        01F8,F8,3128,
                        01F0,00,3153,
                        01F0,F8,3143,
                        01E0,00,3151,
                        01E0,F8,3141,
                        01D8,00,3130,
                        01D8,F8,3120,
                        01D0,00,3134,
                        01D0,F8,3124,
                        01C8,00,313B,
                        01C8,F8,312B,
                        01C0,00,3132,
                        01C0,F8,3122
}


;;; $B613: 'CLEAR TIME' ;;;
{
$8C:B613             dx 0012,
                        0008,00,3134,
                        0008,F8,3124,
                        0000,00,313C,
                        0000,F8,312C,
                        01F8,00,3138,
                        01F8,F8,3128,
                        01F0,00,3153,
                        01F0,F8,3143,
                        01E0,00,3151,
                        01E0,F8,3141,
                        01D8,00,3130,
                        01D8,F8,3120,
                        01D0,00,3134,
                        01D0,F8,3124,
                        01C8,00,313B,
                        01C8,F8,312B,
                        01C0,00,3132,
                        01C0,F8,3122
}


;;; $B66F: ':' ;;;
{
$8C:B66F             dx 0002,
                        01FC,00,B15A,
                        01FC,F8,315A
}


;;; $B67B: '0' ;;;
{
$8C:B67B             dx 0002,
                        01FC,00,3170,
                        01FC,F8,3160
}


;;; $B687: '1' ;;;
{
$8C:B687             dx 0002,
                        01FC,00,3171,
                        01FC,F8,3161
}


;;; $B693: '2' ;;;
{
$8C:B693             dx 0002,
                        01FC,00,3172,
                        01FC,F8,3162
}


;;; $B69F: '3' ;;;
{
$8C:B69F             dx 0002,
                        01FC,00,3173,
                        01FC,F8,3163
}


;;; $B6AB: '4' ;;;
{
$8C:B6AB             dx 0002,
                        01FC,00,3174,
                        01FC,F8,3164
}


;;; $B6B7: '5' ;;;
{
$8C:B6B7             dx 0002,
                        01FC,00,3175,
                        01FC,F8,3165
}


;;; $B6C3: '6' ;;;
{
$8C:B6C3             dx 0002,
                        01FC,00,3176,
                        01FC,F8,3166
}


;;; $B6CF: '7' ;;;
{
$8C:B6CF             dx 0002,
                        01FC,00,3177,
                        01FC,F8,3167
}


;;; $B6DB: '8' ;;;
{
$8C:B6DB             dx 0002,
                        01FC,00,3178,
                        01FC,F8,3168
}


;;; $B6E7: '9' ;;;
{
$8C:B6E7             dx 0002,
                        01FC,00,3179,
                        01FC,F8,3169
}


;;; $B6F3: Ending cutscene - bottom clouds pattern ;;;
{
$8C:B6F3             dx 0010,
                        0060,00,3ACC,
                        0040,00,3AC8,
                        0020,00,3AC4,
                        0000,00,3AC0,
                        0060,E0,3A8C,
                        0040,E0,3A88,
                        0020,E0,3A84,
                        0000,E0,3A80,
                        01E0,00,3ACC,
                        01C0,00,3AC8,
                        01A0,00,3AC4,
                        0180,00,3AC0,
                        01E0,E0,3A8C,
                        01C0,E0,3A88,
                        01A0,E0,3A84,
                        0180,E0,3A80
}


;;; $B745: Ending cutscene - top clouds pattern ;;;
{
$8C:B745             dx 0010,
                        0180,E0,FACC,
                        01A0,E0,FAC8,
                        01C0,E0,FAC4,
                        01E0,E0,FAC0,
                        0180,00,FA8C,
                        01A0,00,FA88,
                        01C0,00,FA84,
                        01E0,00,FA80,
                        0000,E0,FACC,
                        0020,E0,FAC8,
                        0040,E0,FAC4,
                        0060,E0,FAC0,
                        0000,00,FA8C,
                        0020,00,FA88,
                        0040,00,FA84,
                        0060,00,FA80
}


;;; $B797: Ending cutscene - bottom clouds edge ;;;
{
$8C:B797             dx 0010,
                        0060,00,3A4C,
                        0040,00,3A48,
                        0020,00,3A44,
                        0000,00,3A40,
                        0060,E0,3A0C,
                        0040,E0,3A08,
                        0020,E0,3A04,
                        0000,E0,3A00,
                        01E0,00,3A4C,
                        01C0,00,3A48,
                        01A0,00,3A44,
                        0180,00,3A40,
                        01E0,E0,3A0C,
                        01C0,E0,3A08,
                        01A0,E0,3A04,
                        0180,E0,3A00
}


;;; $B7E9: Ending cutscene - top clouds edge ;;;
{
$8C:B7E9             dx 0010,
                        0180,E0,FA4C,
                        01A0,E0,FA48,
                        01C0,E0,FA44,
                        01E0,E0,FA40,
                        0180,00,FA0C,
                        01A0,00,FA08,
                        01C0,00,FA04,
                        01E0,00,FA00,
                        0000,E0,FA4C,
                        0020,E0,FA48,
                        0040,E0,FA44,
                        0060,E0,FA40,
                        0000,00,FA0C,
                        0020,00,FA08,
                        0040,00,FA04,
                        0060,00,FA00
}


;;; $B83B: Ending cutscene - right clouds ;;;
{
$8C:B83B             dx 0020,
                        0060,60,3BCC,
                        0040,60,3BC8,
                        0020,60,3BC4,
                        0000,60,3BC0,
                        0060,40,3B8C,
                        0040,40,3B88,
                        0020,40,3B84,
                        0000,40,3B80,
                        0060,20,3B4C,
                        0040,20,3B48,
                        0020,20,3B44,
                        0000,20,3B40,
                        0060,00,3B0C,
                        0040,00,3B08,
                        0020,00,3B04,
                        0000,00,3B00,
                        0060,E0,3BCC,
                        0040,E0,3BC8,
                        0020,E0,3BC4,
                        0000,E0,3BC0,
                        0060,C0,3B8C,
                        0040,C0,3B88,
                        0020,C0,3B84,
                        0000,C0,3B80,
                        0060,A0,3B4C,
                        0040,A0,3B48,
                        0020,A0,3B44,
                        0000,A0,3B40,
                        0060,80,3B0C,
                        0040,80,3B08,
                        0020,80,3B04,
                        0000,80,3B00
}


;;; $B8DD: Ending cutscene - left clouds ;;;
{
$8C:B8DD             dx 0020,
                        0180,60,7BCC,
                        01A0,60,7BC8,
                        01C0,60,7BC4,
                        01E0,60,7BC0,
                        0180,40,7B8C,
                        01A0,40,7B88,
                        01C0,40,7B84,
                        01E0,40,7B80,
                        0180,20,7B4C,
                        01A0,20,7B48,
                        01C0,20,7B44,
                        01E0,20,7B40,
                        0180,00,7B0C,
                        01A0,00,7B08,
                        01C0,00,7B04,
                        01E0,00,7B00,
                        0180,E0,7BCC,
                        01A0,E0,7BC8,
                        01C0,E0,7BC4,
                        01E0,E0,7BC0,
                        0180,C0,7B8C,
                        01A0,C0,7B88,
                        01C0,C0,7B84,
                        01E0,C0,7B80,
                        0180,A0,7B4C,
                        01A0,A0,7B48,
                        01C0,A0,7B44,
                        01E0,A0,7B40,
                        0180,80,7B0C,
                        01A0,80,7B08,
                        01C0,80,7B04,
                        01E0,80,7B00
}


;;; $B97F: Ending screw attack symbol - upper part ;;;
{
$8C:B97F             dx 000E,
                        C3EA,09,3E64,
                        C3DA,09,3E62,
                        001A,D1,3E18,
                        001A,C9,3E08,
                        C3FA,F9,3E82,
                        C3EA,F9,3E80,
                        C20A,C9,3E06,
                        C20A,D9,3E26,
                        C3FA,D9,3E24,
                        C3EA,D9,3E22,
                        C3FA,E9,3E44,
                        C3EA,E9,3E42,
                        C3DA,F9,3E60,
                        C3DA,E9,3E40
}


;;; $B9C7: Ending screw attack symbol - lower part ;;;
{
$8C:B9C7             dx 000E,
                        C206,E7,FE64,
                        C216,E7,FE62,
                        01DE,27,FE18,
                        01DE,2F,FE08,
                        C3F6,F7,FE82,
                        C206,F7,FE80,
                        C3E6,27,FE06,
                        C3E6,17,FE26,
                        C3F6,17,FE24,
                        C206,17,FE22,
                        C3F6,07,FE44,
                        C206,07,FE42,
                        C216,F7,FE60,
                        C216,07,FE40
}


;;; $BA0F: Ending screw attack symbol - right wrap frame 1 ;;;
{
$8C:BA0F             dx 000C,
                        C218,E0,3E49,
                        C210,E0,3E48,
                        0008,E8,3E48,
                        C200,F0,3E4C,
                        C210,F0,3E4E,
                        01F8,F8,3E5B,
                        0000,00,3E6B,
                        01F8,00,3E6A,
                        0028,F8,3E79,
                        0020,F8,3E78,
                        0028,F0,3E69,
                        0020,F0,3E68
}


;;; $BA4D: Ending screw attack symbol - right wrap frame 2 ;;;
{
$8C:BA4D             dx 0012,
                        C218,E0,3E49,
                        C210,E0,3E48,
                        0008,E8,3E48,
                        C200,F0,3E4C,
                        C210,F0,3E4E,
                        01F8,F8,3E5B,
                        0000,00,3E6B,
                        01F8,00,3E6A,
                        0028,F8,3E79,
                        0020,F8,3E78,
                        0028,F0,3E69,
                        0020,F0,3E68,
                        C220,18,3E20,
                        0018,08,3E6C,
                        0018,00,3E10,
                        0018,F8,3E00,
                        C220,08,3E6D,
                        C220,F8,3E01
}


;;; $BAA9: Ending screw attack symbol - right wrap frame 3 ;;;
{
$8C:BAA9             dx 0019,
                        0007,21,FE2C,
                        01EF,31,FE0F,
                        C217,29,FE09,
                        C3F7,29,FE0D,
                        C207,29,FE0B,
                        000F,21,FE2B,
                        C217,19,FE29,
                        C218,E0,3E49,
                        C210,E0,3E48,
                        0008,E8,3E48,
                        C200,F0,3E4C,
                        C210,F0,3E4E,
                        01F8,F8,3E5B,
                        0000,00,3E6B,
                        01F8,00,3E6A,
                        0028,F8,3E79,
                        0020,F8,3E78,
                        0028,F0,3E69,
                        0020,F0,3E68,
                        C220,18,3E20,
                        0018,08,3E6C,
                        0018,00,3E10,
                        0018,F8,3E00,
                        C220,08,3E6D,
                        C220,F8,3E01
}


;;; $BB28: Ending screw attack symbol - left wrap frame 1 ;;;
{
$8C:BB28             dx 000C,
                        C3D8,10,FE49,
                        C3E0,10,FE48,
                        01F0,10,FE48,
                        C3F0,00,FE4C,
                        C3E0,00,FE4E,
                        0000,00,FE5B,
                        01F8,F8,FE6B,
                        0000,F8,FE6A,
                        01D0,00,FE79,
                        01D8,00,FE78,
                        01D0,08,FE69,
                        01D8,08,FE68
}


;;; $BB66: Ending screw attack symbol - left wrap frame 2 ;;;
{
$8C:BB66             dx 0012,
                        C3D8,10,FE49,
                        C3E0,10,FE48,
                        01F0,10,FE48,
                        C3F0,00,FE4C,
                        C3E0,00,FE4E,
                        0000,00,FE5B,
                        01F8,F8,FE6B,
                        0000,F8,FE6A,
                        01D0,00,FE79,
                        01D8,00,FE78,
                        01D0,08,FE69,
                        01D8,08,FE68,
                        C3D0,D8,FE20,
                        01E0,F0,FE6C,
                        01E0,F8,FE10,
                        01E0,00,FE00,
                        C3D0,E8,FE6D,
                        C3D0,F8,FE01
}


;;; $BBC2: Ending screw attack symbol - left wrap frame 3 ;;;
{
$8C:BBC2             dx 0019,
                        01F1,D7,3E2C,
                        0009,C7,3E0F,
                        C3D9,C7,3E09,
                        C3F9,C7,3E0D,
                        C3E9,C7,3E0B,
                        01E9,D7,3E2B,
                        C3D9,D7,3E29,
                        C3D8,10,FE49,
                        C3E0,10,FE48,
                        01F0,10,FE48,
                        C3F0,00,FE4C,
                        C3E0,00,FE4E,
                        0000,00,FE5B,
                        01F8,F8,FE6B,
                        0000,F8,FE6A,
                        01D0,00,FE79,
                        01D8,00,FE78,
                        01D0,08,FE69,
                        01D8,08,FE68,
                        C3D0,D8,FE20,
                        01E0,F0,FE6C,
                        01E0,F8,FE10,
                        01E0,00,FE00,
                        C3D0,E8,FE6D,
                        C3D0,F8,FE01
}


;;; $BC41: Critters escape pod (frame 1) ;;;
{
$8C:BC41             dx 0001,
                        01FC,FC,3FE0
}


;;; $BC48: Critters escape pod (frame 2) ;;;
{
$8C:BC48             dx 0001,
                        01FC,FC,3FE1
}


;;; $BC4F: Critters escape pod (frame 3) ;;;
{
$8C:BC4F             dx 0001,
                        01FC,FC,3FE2
}


;;; $BC56: Critters escape pod (frame 4) ;;;
{
$8C:BC56             dx 0001,
                        01FC,FC,3FE3
}
}


;;; $BC5D: Title sequence HDMA tables ;;;
{
; Pointer to HDMA tables for colour math subscreen backdrop colour
; Table entries correspond to title sequence zoom level: later entries => more zoomed out (see $198F)
$8C:BC5D             dw BC7D, BC7D, BC7D, BC7D, BCBF, BCE5, BD0B, BD31, BD57, BD81, BDAB, BDD5, BDFF, BE2D, BE5B, BE8F

; Colour math subscreen backdrop colour HDMA tables, first 7Ah lines are subtractive, remaining 80h lines are additive, (given here as two separate lines)
$8C:BC7D             db 04,EF, 04,EE, 04,ED, 04,EC, 04,EB, 04,EA, 04,E9, 04,E8, 04,E7, 04,E6, 05,E5, 06,E4, 08,E3, 09,E2, 09,E1, 33,E0,
                        04,C0, 0C,C1, 0A,C2, 0A,C3, 07,C4, 06,C5, 05,C6, 05,C7, 05,C8, 05,C9, 06,CA, 05,CB, 05,CC, 05,CD, 05,CE, 01,CF,
                        00,00

$8C:BCBF             db 40,C0, 40,C0,
                        10,C0, 30,C1, 28,C2, 28,C3, 1C,C4, 18,C5, 14,C6, 14,C7, 14,C8, 14,C9, 18,CA, 14,CB, 14,CC, 14,CD, 14,CE, 04,CF,
                        00,00

$8C:BCE5             db 40,C0, 40,C0,
                        0E,C0, 2A,C1, 23,C2, 23,C3, 19,C4, 15,C5, 12,C6, 12,C7, 12,C8, 12,C9, 15,CA, 12,CB, 12,CC, 12,CD, 12,CE, 04,CF,
                        00,00

$8C:BD0B             db 40,C0, 40,C0,
                        0C,C0, 24,C1, 1E,C2, 1E,C3, 15,C4, 12,C5, 0F,C6, 0F,C7, 0F,C8, 0F,C9, 12,CA, 0F,CB, 0F,CC, 0F,CD, 0F,CE, 03,CF,
                        00,00

$8C:BD31             db 40,C0, 40,C0,
                        0A,C0, 1E,C1, 19,C2, 19,C3, 12,C4, 0F,C5, 0D,C6, 0D,C7, 0D,C8, 0D,C9, 0F,CA, 0D,CB, 0D,CC, 0D,CD, 0D,CE, 03,CF,
                        00,00

$8C:BD57             db 08,E2, 12,E1, 64,E0,
                        02,E0, 08,C0, 18,C1, 14,C2, 14,C3, 0E,C4, 0C,C5, 0A,C6, 0A,C7, 0A,C8, 0A,C9, 0C,CA, 0A,CB, 0A,CC, 0A,CD, 0A,CE, 02,CF,
                        00,00

$8C:BD81             db 08,E2, 12,E1, 64,E0,
                        02,E0, 08,C0, 17,C1, 13,C2, 13,C3, 0E,C4, 0C,C5, 0A,C6, 0A,C7, 0A,C8, 0A,C9, 0C,CA, 0A,CB, 0A,CC, 0A,CD, 0A,CE, 02,CF,
                        00,00

$8C:BDAB             db 06,E3, 10,E2, 10,E1, 5A,E0,
                        07,C0, 15,C1, 12,C2, 12,C3, 0D,C4, 0B,C5, 09,C6, 09,C7, 09,C8, 09,C9, 0B,CA, 09,CB, 09,CC, 09,CD, 09,CE, 02,CF,
                        00,00

$8C:BDD5             db 06,E3, 10,E2, 10,E1, 5A,E0,
                        07,C0, 14,C1, 11,C2, 11,C3, 0C,C4, 0A,C5, 09,C6, 09,C7, 09,C8, 09,C9, 0A,CA, 09,CB, 09,CC, 09,CD, 09,CE, 02,CF,
                        00,00

$8C:BDFF             db 02,E5, 09,E4, 0C,E3, 0E,E2, 0E,E1, 4D,E0,
                        06,C0, 12,C1, 0F,C2, 0F,C3, 0B,C4, 09,C5, 08,C6, 08,C7, 08,C8, 08,C9, 09,CA, 08,CB, 08,CC, 08,CD, 08,CE, 02,CF,
                        00,00

$8C:BE2D             db 02,E5, 09,E4, 0C,E3, 0E,E2, 0E,E1, 4D,E0,
                        06,C0, 11,C1, 0E,C2, 0E,C3, 0A,C4, 09,C5, 08,C6, 08,C7, 08,C8, 08,C9, 09,CA, 08,CB, 08,CC, 08,CD, 08,CE, 02,CF,
                        00,00

$8C:BE5B             db 05,E8, 05,E7, 05,E6, 07,E5, 08,E4, 0A,E3, 0C,E2, 0C,E1, 40,E0,
                        05,C0, 0F,C1, 0D,C2, 0D,C3, 09,C4, 08,C5, 07,C6, 07,C7, 07,C8, 07,C9, 08,CA, 07,CB, 07,CC, 07,CD, 07,CE, 02,CF,
                        00,00

$8C:BE8F             db 05,E8, 05,E7, 05,E6, 07,E5, 08,E4, 0A,E3, 0C,E2, 0C,E1, 40,E0,
                        05,C0, 0E,C1, 0C,C2, 0C,C3, 08,C4, 07,C5, 06,C6, 06,C7, 06,C8, 06,C9, 07,CA, 06,CB, 06,CC, 06,CD, 06,CE, 02,CF,
                        00,00
}


;;; $BEC3: Level data - old Mother Brain room from cutscene ;;;
{
$8C:BEC3             dx 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000,
                        8000, 8000, 8000, 8000, 8000, 8000, 0000, 0000, 0000, 8000, 0000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 8000, 8000, 0000, 0000, 8000, 8000, 8000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 8000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 8000, 8000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 0000, 0000, 0000, 0000, 0000, 1000, 0000, 0000, 1000, 1000, 1000, 1000,
                        8000, 8000, 8000, 8000, 8000, 8000, 0000, 0000, 0000, 8000, 0000, 0000, 8000, 8000, 8000, 8000,
                        8000, 8000, 8000, 8000, 8000, 8000, 8000, 0000, 0000, 8000, 0000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 8000, 8000, 8000, 0000, 0000, 8000, 0000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 8000, 8000, 8000, 0000, 0000, 8000, 8000, 0000, 0000, 0000, 0000, 0000,
                        8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000
}


;;; $C083: Level data - room with Baby Metroid hatching from cutscene ;;;
{
$8C:C083             dw 0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,
                        8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000,8000
}


;;; $C383..D67C: Cinematic BG object instruction lists - intro text ;;;
{
;;; $C383: Intro text - page 1 ;;;
{
; I FIRST BATTLED THE METROIDS
; ON PLANET ZEBES. IT WAS THERE
; THAT I FOILED THE PLANS OF
; THE SPACE PIRATE LEADER
; MOTHER BRAIN TO USE THE
; CREATURES TO ATTACK
; GALACTIC CIVILIZATION...

$8C:C383             dx AE43, ; Handle creating Japanese text - page 1
{
                        0001,01,01,D683, ; Nothing
                        0005,01,04,D6B5, ; "I"
                        0005,02,04,D67D, ; " "
                        0005,03,04,D6A3, ; "F"
                        0005,04,04,D6B5, ; "I"
                        0005,05,04,D6EB, ; "R"
                        0005,06,04,D6F1, ; "S"
                        0005,07,04,D6F7, ; "T"
                        0005,08,04,D67D, ; " "
                        0005,09,04,D68B, ; "B"
                        0005,0A,04,D685, ; "A"
                        0005,0B,04,D6F7, ; "T"
                        0005,0C,04,D6F7, ; "T"
                        0005,0D,04,D6C7, ; "L"
                        0005,0E,04,D69D, ; "E"
                        0005,0F,04,D697, ; "D"
                        0005,10,04,D67D, ; " "
                        0005,11,04,D6F7, ; "T"
                        0005,12,04,D6AF, ; "H"
                        0005,13,04,D69D, ; "E"
                        0005,14,04,D67D, ; " "
                        0005,15,04,D6CD, ; "M"
                        0005,16,04,D69D, ; "E"
                        0005,17,04,D6F7, ; "T"
                        0005,18,04,D6EB, ; "R"
                        0005,19,04,D6D9, ; "O"
                        0005,1A,04,D6B5, ; "I"
                        0005,1B,04,D697, ; "D"
                        0005,1C,04,D6F1, ; "S"
                        0005,01,06,D6D9, ; "O"
                        0005,02,06,D6D3, ; "N"
                        0005,03,06,D67D, ; " "
                        0005,04,06,D6DF, ; "P"
                        0005,05,06,D6C7, ; "L"
                        0005,06,06,D685, ; "A"
                        0005,07,06,D6D3, ; "N"
                        0005,08,06,D69D, ; "E"
                        0005,09,06,D6F7, ; "T"
                        0005,0A,06,D67D, ; " "
                        0005,0B,06,D71B, ; "Z"
                        0005,0C,06,D69D, ; "E"
                        0005,0D,06,D68B, ; "B"
                        0005,0E,06,D69D, ; "E"
                        0005,0F,06,D6F1, ; "S"
                        0005,10,06,D75D, ; "."
                        0005,11,06,D67D, ; " "
                        0005,12,06,D6B5, ; "I"
                        0005,13,06,D6F7, ; "T"
                        0005,14,06,D67D, ; " "
                        0005,15,06,D709, ; "W"
                        0005,16,06,D685, ; "A"
                        0005,17,06,D6F1, ; "S"
                        0005,18,06,D67D, ; " "
                        0005,19,06,D6F7, ; "T"
                        0005,1A,06,D6AF, ; "H"
                        0005,1B,06,D69D, ; "E"
                        0005,1C,06,D6EB, ; "R"
                        0005,1D,06,D69D, ; "E"
                        0005,01,08,D6F7, ; "T"
                        0005,02,08,D6AF, ; "H"
                        0005,03,08,D685, ; "A"
                        0005,04,08,D6F7, ; "T"
                        0005,05,08,D67D, ; " "
                        0005,06,08,D6B5, ; "I"
                        0005,07,08,D67D, ; " "
                        0005,08,08,D6A3, ; "F"
                        0005,09,08,D6D9, ; "O"
                        0005,0A,08,D6B5, ; "I"
                        0005,0B,08,D6C7, ; "L"
                        0005,0C,08,D69D, ; "E"
                        0005,0D,08,D697, ; "D"
                        0005,0E,08,D67D, ; " "
                        0005,0F,08,D6F7, ; "T"
                        0005,10,08,D6AF, ; "H"
                        0005,11,08,D69D, ; "E"
                        0005,12,08,D67D, ; " "
                        0005,13,08,D6DF, ; "P"
                        0005,14,08,D6C7, ; "L"
                        0005,15,08,D685, ; "A"
                        0005,16,08,D6D3, ; "N"
                        0005,17,08,D6F1, ; "S"
                        0005,18,08,D67D, ; " "
                        0005,19,08,D6D9, ; "O"
                        0005,1A,08,D6A3, ; "F"
                        0005,01,0A,D6F7, ; "T"
                        0005,02,0A,D6AF, ; "H"
                        0005,03,0A,D69D, ; "E"
                        0005,04,0A,D67D, ; " "
                        0005,05,0A,D6F1, ; "S"
                        0005,06,0A,D6DF, ; "P"
                        0005,07,0A,D685, ; "A"
                        0005,08,0A,D691, ; "C"
                        0005,09,0A,D69D, ; "E"
                        0005,0A,0A,D67D, ; " "
                        0005,0B,0A,D6DF, ; "P"
                        0005,0C,0A,D6B5, ; "I"
                        0005,0D,0A,D6EB, ; "R"
                        0005,0E,0A,D685, ; "A"
                        0005,0F,0A,D6F7, ; "T"
                        0005,10,0A,D69D, ; "E"
                        0005,11,0A,D67D, ; " "
                        0005,12,0A,D6C7, ; "L"
                        0005,13,0A,D69D, ; "E"
                        0005,14,0A,D685, ; "A"
                        0005,15,0A,D697, ; "D"
                        0005,16,0A,D69D, ; "E"
                        0005,17,0A,D6EB, ; "R"
                        0005,01,0C,D6CD, ; "M"
                        0005,02,0C,D6D9, ; "O"
                        0005,03,0C,D6F7, ; "T"
                        0005,04,0C,D6AF, ; "H"
                        0005,05,0C,D69D, ; "E"
                        0005,06,0C,D6EB, ; "R"
                        0005,07,0C,D67D, ; " "
                        0005,08,0C,D68B, ; "B"
                        0005,09,0C,D6EB, ; "R"
                        0005,0A,0C,D685, ; "A"
                        0005,0B,0C,D6B5, ; "I"
                        0005,0C,0C,D6D3, ; "N"
                        0005,0D,0C,D67D, ; " "
                        0005,0E,0C,D6F7, ; "T"
                        0005,0F,0C,D6D9, ; "O"
                        0005,10,0C,D67D, ; " "
                        0005,11,0C,D6FD, ; "U"
                        0005,12,0C,D6F1, ; "S"
                        0005,13,0C,D69D, ; "E"
                        0005,14,0C,D67D, ; " "
                        0005,15,0C,D6F7, ; "T"
                        0005,16,0C,D6AF, ; "H"
                        0005,17,0C,D69D, ; "E"
                        0005,01,0E,D691, ; "C"
                        0005,02,0E,D6EB, ; "R"
                        0005,03,0E,D69D, ; "E"
                        0005,04,0E,D685, ; "A"
                        0005,05,0E,D6F7, ; "T"
                        0005,06,0E,D6FD, ; "U"
                        0005,07,0E,D6EB, ; "R"
                        0005,08,0E,D69D, ; "E"
                        0005,09,0E,D6F1, ; "S"
                        0005,0A,0E,D67D, ; " "
                        0005,0B,0E,D6F7, ; "T"
                        0005,0C,0E,D6D9, ; "O"
                        0005,0D,0E,D67D, ; " "
                        0005,0E,0E,D685, ; "A"
                        0005,0F,0E,D6F7, ; "T"
                        0005,10,0E,D6F7, ; "T"
                        0005,11,0E,D685, ; "A"
                        0005,12,0E,D691, ; "C"
                        0005,13,0E,D6C1, ; "K"
                        0005,01,10,D6A9, ; "G"
                        0005,02,10,D685, ; "A"
                        0005,03,10,D6C7, ; "L"
                        0005,04,10,D685, ; "A"
                        0005,05,10,D691, ; "C"
                        0005,06,10,D6F7, ; "T"
                        0005,07,10,D6B5, ; "I"
                        0005,08,10,D691, ; "C"
                        0005,09,10,D67D, ; " "
                        0005,0A,10,D691, ; "C"
                        0005,0B,10,D6B5, ; "I"
                        0005,0C,10,D703, ; "V"
                        0005,0D,10,D6B5, ; "I"
                        0005,0E,10,D6C7, ; "L"
                        0005,0F,10,D6B5, ; "I"
                        0005,10,10,D71B, ; "Z"
                        0005,11,10,D685, ; "A"
                        0005,12,10,D6F7, ; "T"
                        0005,13,10,D6B5, ; "I"
                        0005,14,10,D6D9, ; "O"
                        0005,15,10,D6D3, ; "N"
                        0005,16,10,D75D, ; "."
                        0005,17,10,D75D, ; "."
                        0005,18,10,D75D, ; "."
}
                        AE5B, ; Spawn blinking cursors and wait for input - page 1
                        9698  ; Delete
}


;;; $C797: Intro text - page 2 ;;;
{
; I NEXT FOUGHT THE METROIDS ON
; THEIR HOMEWORLD, SR388. I
; COMPLETELY ERADICATED THEM
; EXCEPT FOR A LARVA, WHICH
; AFTER HATCHING FOLLOWED ME
; LIKE A CONFUSED CHILD...

$8C:C797             dx AE79, ; Handle creating Japanese text - page 2
{
                        0001,01,01,D683,
                        0005,01,04,D6B5, ; "I"
                        0005,02,04,D67D, ; " "
                        0005,03,04,D6D3, ; "N"
                        0005,04,04,D69D, ; "E"
                        0005,05,04,D70F, ; "X"
                        0005,06,04,D6F7, ; "T"
                        0005,07,04,D67D, ; " "
                        0005,08,04,D6A3, ; "F"
                        0005,09,04,D6D9, ; "O"
                        0005,0A,04,D6FD, ; "U"
                        0005,0B,04,D6A9, ; "G"
                        0005,0C,04,D6AF, ; "H"
                        0005,0D,04,D6F7, ; "T"
                        0005,0E,04,D67D, ; " "
                        0005,0F,04,D6F7, ; "T"
                        0005,10,04,D6AF, ; "H"
                        0005,11,04,D69D, ; "E"
                        0005,12,04,D67D, ; " "
                        0005,13,04,D6CD, ; "M"
                        0005,14,04,D69D, ; "E"
                        0005,15,04,D6F7, ; "T"
                        0005,16,04,D6EB, ; "R"
                        0005,17,04,D6D9, ; "O"
                        0005,18,04,D6B5, ; "I"
                        0005,19,04,D697, ; "D"
                        0005,1A,04,D6F1, ; "S"
                        0005,1B,04,D67D, ; " "
                        0005,1C,04,D6D9, ; "O"
                        0005,1D,04,D6D3, ; "N"
                        0005,01,06,D6F7, ; "T"
                        0005,02,06,D6AF, ; "H"
                        0005,03,06,D69D, ; "E"
                        0005,04,06,D6B5, ; "I"
                        0005,05,06,D6EB, ; "R"
                        0005,06,06,D67D, ; " "
                        0005,07,06,D6AF, ; "H"
                        0005,08,06,D6D9, ; "O"
                        0005,09,06,D6CD, ; "M"
                        0005,0A,06,D69D, ; "E"
                        0005,0B,06,D709, ; "W"
                        0005,0C,06,D6D9, ; "O"
                        0005,0D,06,D6EB, ; "R"
                        0005,0E,06,D6C7, ; "L"
                        0005,0F,06,D697, ; "D"
                        0005,10,06,D763, ; ","
                        0005,11,06,D67D, ; " "
                        0005,12,06,D6F1, ; "S"
                        0005,13,06,D6EB, ; "R"
                        0005,14,06,D733, ; "3"
                        0005,15,06,D751, ; "8"
                        0005,16,06,D751, ; "8"
                        0005,17,06,D75D, ; "."
                        0005,18,06,D67D, ; " "
                        0005,19,06,D6B5, ; "I"
                        0005,01,08,D691, ; "C"
                        0005,02,08,D6D9, ; "O"
                        0005,03,08,D6CD, ; "M"
                        0005,04,08,D6DF, ; "P"
                        0005,05,08,D6C7, ; "L"
                        0005,06,08,D69D, ; "E"
                        0005,07,08,D6F7, ; "T"
                        0005,08,08,D69D, ; "E"
                        0005,09,08,D6C7, ; "L"
                        0005,0A,08,D715, ; "Y"
                        0005,0B,08,D67D, ; " "
                        0005,0C,08,D69D, ; "E"
                        0005,0D,08,D6EB, ; "R"
                        0005,0E,08,D685, ; "A"
                        0005,0F,08,D697, ; "D"
                        0005,10,08,D6B5, ; "I"
                        0005,11,08,D691, ; "C"
                        0005,12,08,D685, ; "A"
                        0005,13,08,D6F7, ; "T"
                        0005,14,08,D69D, ; "E"
                        0005,15,08,D697, ; "D"
                        0005,16,08,D67D, ; " "
                        0005,17,08,D6F7, ; "T"
                        0005,18,08,D6AF, ; "H"
                        0005,19,08,D69D, ; "E"
                        0005,1A,08,D6CD, ; "M"
                        0005,01,0A,D69D, ; "E"
                        0005,02,0A,D70F, ; "X"
                        0005,03,0A,D691, ; "C"
                        0005,04,0A,D69D, ; "E"
                        0005,05,0A,D6DF, ; "P"
                        0005,06,0A,D6F7, ; "T"
                        0005,07,0A,D67D, ; " "
                        0005,08,0A,D6A3, ; "F"
                        0005,09,0A,D6D9, ; "O"
                        0005,0A,0A,D6EB, ; "R"
                        0005,0B,0A,D67D, ; " "
                        0005,0C,0A,D685, ; "A"
                        0005,0D,0A,D67D, ; " "
                        0005,0E,0A,D6C7, ; "L"
                        0005,0F,0A,D685, ; "A"
                        0005,10,0A,D6EB, ; "R"
                        0005,11,0A,D703, ; "V"
                        0005,12,0A,D685, ; "A"
                        0005,13,0A,D763, ; ","
                        0005,14,0A,D67D, ; " "
                        0005,15,0A,D709, ; "W"
                        0005,16,0A,D6AF, ; "H"
                        0005,17,0A,D6B5, ; "I"
                        0005,18,0A,D691, ; "C"
                        0005,19,0A,D6AF, ; "H"
                        0005,01,0C,D685, ; "A"
                        0005,02,0C,D6A3, ; "F"
                        0005,03,0C,D6F7, ; "T"
                        0005,04,0C,D69D, ; "E"
                        0005,05,0C,D6EB, ; "R"
                        0005,06,0C,D67D, ; " "
                        0005,07,0C,D6AF, ; "H"
                        0005,08,0C,D685, ; "A"
                        0005,09,0C,D6F7, ; "T"
                        0005,0A,0C,D691, ; "C"
                        0005,0B,0C,D6AF, ; "H"
                        0005,0C,0C,D6B5, ; "I"
                        0005,0D,0C,D6D3, ; "N"
                        0005,0E,0C,D6A9, ; "G"
                        0005,0F,0C,D67D, ; " "
                        0005,10,0C,D6A3, ; "F"
                        0005,11,0C,D6D9, ; "O"
                        0005,12,0C,D6C7, ; "L"
                        0005,13,0C,D6C7, ; "L"
                        0005,14,0C,D6D9, ; "O"
                        0005,15,0C,D709, ; "W"
                        0005,16,0C,D69D, ; "E"
                        0005,17,0C,D697, ; "D"
                        0005,18,0C,D67D, ; " "
                        0005,19,0C,D6CD, ; "M"
                        0005,1A,0C,D69D, ; "E"
                        0005,01,0E,D6C7, ; "L"
                        0005,02,0E,D6B5, ; "I"
                        0005,03,0E,D6C1, ; "K"
                        0005,04,0E,D69D, ; "E"
                        0005,05,0E,D67D, ; " "
                        0005,06,0E,D685, ; "A"
                        0005,07,0E,D67D, ; " "
                        0005,08,0E,D691, ; "C"
                        0005,09,0E,D6D9, ; "O"
                        0005,0A,0E,D6D3, ; "N"
                        0005,0B,0E,D6A3, ; "F"
                        0005,0C,0E,D6FD, ; "U"
                        0005,0D,0E,D6F1, ; "S"
                        0005,0E,0E,D69D, ; "E"
                        0005,0F,0E,D697, ; "D"
                        0005,10,0E,D67D, ; " "
                        0005,11,0E,D691, ; "C"
                        0005,12,0E,D6AF, ; "H"
                        0005,13,0E,D6B5, ; "I"
                        0005,14,0E,D6C7, ; "L"
                        0005,15,0E,D697, ; "D"
                        0005,16,0E,D75D, ; "."
                        0005,17,0E,D75D, ; "."
                        0005,18,0E,D75D, ; "."
}
                        AE91, ; Spawn blinking cursors and wait for input - page 2
                        9698  ; Delete
}


;;; $CB45: Intro text - page 3 ;;;
{
; I PERSONALLY DELIVERED IT TO
; THE GALACTIC RESEARCH STATION
; AT CERES SO SCIENTISTS COULD
; STUDY ITS ENERGY PRODUCING
; QUALITIES...

$8C:CB45             dx B074, ; Handle creating Japanese text - page 3
{
                        0001,01,01,D683,
                        0005,01,04,D6B5, ; "I"
                        0005,02,04,D67D, ; " "
                        0005,03,04,D6DF, ; "P"
                        0005,04,04,D69D, ; "E"
                        0005,05,04,D6EB, ; "R"
                        0005,06,04,D6F1, ; "S"
                        0005,07,04,D6D9, ; "O"
                        0005,08,04,D6D3, ; "N"
                        0005,09,04,D685, ; "A"
                        0005,0A,04,D6C7, ; "L"
                        0005,0B,04,D6C7, ; "L"
                        0005,0C,04,D715, ; "Y"
                        0005,0D,04,D67D, ; " "
                        0005,0E,04,D697, ; "D"
                        0005,0F,04,D69D, ; "E"
                        0005,10,04,D6C7, ; "L"
                        0005,11,04,D6B5, ; "I"
                        0005,12,04,D703, ; "V"
                        0005,13,04,D69D, ; "E"
                        0005,14,04,D6EB, ; "R"
                        0005,15,04,D69D, ; "E"
                        0005,16,04,D697, ; "D"
                        0005,17,04,D67D, ; " "
                        0005,18,04,D6B5, ; "I"
                        0005,19,04,D6F7, ; "T"
                        0005,1A,04,D67D, ; " "
                        0005,1B,04,D6F7, ; "T"
                        0005,1C,04,D6D9, ; "O"
                        0005,01,06,D6F7, ; "T"
                        0005,02,06,D6AF, ; "H"
                        0005,03,06,D69D, ; "E"
                        0005,04,06,D67D, ; " "
                        0005,05,06,D6A9, ; "G"
                        0005,06,06,D685, ; "A"
                        0005,07,06,D6C7, ; "L"
                        0005,08,06,D685, ; "A"
                        0005,09,06,D691, ; "C"
                        0005,0A,06,D6F7, ; "T"
                        0005,0B,06,D6B5, ; "I"
                        0005,0C,06,D691, ; "C"
                        0005,0D,06,D67D, ; " "
                        0005,0E,06,D6EB, ; "R"
                        0005,0F,06,D69D, ; "E"
                        0005,10,06,D6F1, ; "S"
                        0005,11,06,D69D, ; "E"
                        0005,12,06,D685, ; "A"
                        0005,13,06,D6EB, ; "R"
                        0005,14,06,D691, ; "C"
                        0005,15,06,D6AF, ; "H"
                        0005,16,06,D67D, ; " "
                        0005,17,06,D6F1, ; "S"
                        0005,18,06,D6F7, ; "T"
                        0005,19,06,D685, ; "A"
                        0005,1A,06,D6F7, ; "T"
                        0005,1B,06,D6B5, ; "I"
                        0005,1C,06,D6D9, ; "O"
                        0005,1D,06,D6D3, ; "N"
                        0005,01,08,D685, ; "A"
                        0005,02,08,D6F7, ; "T"
                        0005,03,08,D67D, ; " "
                        0005,04,08,D691, ; "C"
                        0005,05,08,D69D, ; "E"
                        0005,06,08,D6EB, ; "R"
                        0005,07,08,D69D, ; "E"
                        0005,08,08,D6F1, ; "S"
                        0005,09,08,D67D, ; " "
                        0005,0A,08,D6F1, ; "S"
                        0005,0B,08,D6D9, ; "O"
                        0005,0C,08,D67D, ; " "
                        0005,0D,08,D6F1, ; "S"
                        0005,0E,08,D691, ; "C"
                        0005,0F,08,D6B5, ; "I"
                        0005,10,08,D69D, ; "E"
                        0005,11,08,D6D3, ; "N"
                        0005,12,08,D6F7, ; "T"
                        0005,13,08,D6B5, ; "I"
                        0005,14,08,D6F1, ; "S"
                        0005,15,08,D6F7, ; "T"
                        0005,16,08,D6F1, ; "S"
                        0005,17,08,D67D, ; " "
                        0005,18,08,D691, ; "C"
                        0005,19,08,D6D9, ; "O"
                        0005,1A,08,D6FD, ; "U"
                        0005,1B,08,D6C7, ; "L"
                        0005,1C,08,D697, ; "D"
                        0005,01,0A,D6F1, ; "S"
                        0005,02,0A,D6F7, ; "T"
                        0005,03,0A,D6FD, ; "U"
                        0005,04,0A,D697, ; "D"
                        0005,05,0A,D715, ; "Y"
                        0005,06,0A,D67D, ; " "
                        0005,07,0A,D6B5, ; "I"
                        0005,08,0A,D6F7, ; "T"
                        0005,09,0A,D6F1, ; "S"
                        0005,0A,0A,D67D, ; " "
                        0005,0B,0A,D69D, ; "E"
                        0005,0C,0A,D6D3, ; "N"
                        0005,0D,0A,D69D, ; "E"
                        0005,0E,0A,D6EB, ; "R"
                        0005,0F,0A,D6A9, ; "G"
                        0005,10,0A,D715, ; "Y"
                        0005,11,0A,D67D, ; " "
                        0005,12,0A,D6DF, ; "P"
                        0005,13,0A,D6EB, ; "R"
                        0005,14,0A,D6D9, ; "O"
                        0005,15,0A,D697, ; "D"
                        0005,16,0A,D6FD, ; "U"
                        0005,17,0A,D691, ; "C"
                        0005,18,0A,D6B5, ; "I"
                        0005,19,0A,D6D3, ; "N"
                        0005,1A,0A,D6A9, ; "G"
                        0005,01,0C,D6E5, ; "Q"
                        0005,02,0C,D6FD, ; "U"
                        0005,03,0C,D685, ; "A"
                        0005,04,0C,D6C7, ; "L"
                        0005,05,0C,D6B5, ; "I"
                        0005,06,0C,D6F7, ; "T"
                        0005,07,0C,D6B5, ; "I"
                        0005,08,0C,D69D, ; "E"
                        0005,09,0C,D6F1, ; "S"
                        0005,0A,0C,D75D, ; "."
                        0005,0B,0C,D75D, ; "."
                        0005,0C,0C,D75D, ; "."
}
                        B08C, ; Spawn blinking cursors and wait for input - page 3
                        9698  ; Delete
}


;;; $CE33: Intro text - page 4 ;;;
{
; THE SCIENTISTS' FINDINGS WERE
; ASTOUNDING! THEY DISCOVERED
; THAT THE POWERS OF THE
; METROID MIGHT BE HARNESSED
; FOR THE GOOD OF CIVILIZATION!

$8C:CE33             dx B0B3, ; Handle creating Japanese text - page 4
{
                        0001,01,01,D683,
                        0005,01,04,D6F7, ; "T"
                        0005,02,04,D6AF, ; "H"
                        0005,03,04,D69D, ; "E"
                        0005,04,04,D67D, ; " "
                        0005,05,04,D6F1, ; "S"
                        0005,06,04,D691, ; "C"
                        0005,07,04,D6B5, ; "I"
                        0005,08,04,D69D, ; "E"
                        0005,09,04,D6D3, ; "N"
                        0005,0A,04,D6F7, ; "T"
                        0005,0B,04,D6B5, ; "I"
                        0005,0C,04,D6F1, ; "S"
                        0005,0D,04,D6F7, ; "T"
                        0005,0E,04,D6F1, ; "S"
                        0005,0F,04,D76F, ; "'"
                        0005,10,04,D67D, ; " "
                        0005,11,04,D6A3, ; "F"
                        0005,12,04,D6B5, ; "I"
                        0005,13,04,D6D3, ; "N"
                        0005,14,04,D697, ; "D"
                        0005,15,04,D6B5, ; "I"
                        0005,16,04,D6D3, ; "N"
                        0005,17,04,D6A9, ; "G"
                        0005,18,04,D6F1, ; "S"
                        0005,19,04,D67D, ; " "
                        0005,1A,04,D709, ; "W"
                        0005,1B,04,D69D, ; "E"
                        0005,1C,04,D6EB, ; "R"
                        0005,1D,04,D69D, ; "E"
                        0005,01,06,D685, ; "A"
                        0005,02,06,D6F1, ; "S"
                        0005,03,06,D6F7, ; "T"
                        0005,04,06,D6D9, ; "O"
                        0005,05,06,D6FD, ; "U"
                        0005,06,06,D6D3, ; "N"
                        0005,07,06,D697, ; "D"
                        0005,08,06,D6B5, ; "I"
                        0005,09,06,D6D3, ; "N"
                        0005,0A,06,D6A9, ; "G"
                        0005,0B,06,D77B, ; "!"
                        0005,0C,06,D67D, ; " "
                        0005,0D,06,D6F7, ; "T"
                        0005,0E,06,D6AF, ; "H"
                        0005,0F,06,D69D, ; "E"
                        0005,10,06,D715, ; "Y"
                        0005,11,06,D67D, ; " "
                        0005,12,06,D697, ; "D"
                        0005,13,06,D6B5, ; "I"
                        0005,14,06,D6F1, ; "S"
                        0005,15,06,D691, ; "C"
                        0005,16,06,D6D9, ; "O"
                        0005,17,06,D703, ; "V"
                        0005,18,06,D69D, ; "E"
                        0005,19,06,D6EB, ; "R"
                        0005,1A,06,D69D, ; "E"
                        0005,1B,06,D697, ; "D"
                        0005,01,08,D6F7, ; "T"
                        0005,02,08,D6AF, ; "H"
                        0005,03,08,D685, ; "A"
                        0005,04,08,D6F7, ; "T"
                        0005,05,08,D67D, ; " "
                        0005,06,08,D6F7, ; "T"
                        0005,07,08,D6AF, ; "H"
                        0005,08,08,D69D, ; "E"
                        0005,09,08,D67D, ; " "
                        0005,0A,08,D6DF, ; "P"
                        0005,0B,08,D6D9, ; "O"
                        0005,0C,08,D709, ; "W"
                        0005,0D,08,D69D, ; "E"
                        0005,0E,08,D6EB, ; "R"
                        0005,0F,08,D6F1, ; "S"
                        0005,10,08,D67D, ; " "
                        0005,11,08,D6D9, ; "O"
                        0005,12,08,D6A3, ; "F"
                        0005,13,08,D67D, ; " "
                        0005,14,08,D6F7, ; "T"
                        0005,15,08,D6AF, ; "H"
                        0005,16,08,D69D, ; "E"
                        0005,01,0A,D6CD, ; "M"
                        0005,02,0A,D69D, ; "E"
                        0005,03,0A,D6F7, ; "T"
                        0005,04,0A,D6EB, ; "R"
                        0005,05,0A,D6D9, ; "O"
                        0005,06,0A,D6B5, ; "I"
                        0005,07,0A,D697, ; "D"
                        0005,08,0A,D67D, ; " "
                        0005,09,0A,D6CD, ; "M"
                        0005,0A,0A,D6B5, ; "I"
                        0005,0B,0A,D6A9, ; "G"
                        0005,0C,0A,D6AF, ; "H"
                        0005,0D,0A,D6F7, ; "T"
                        0005,0E,0A,D67D, ; " "
                        0005,0F,0A,D68B, ; "B"
                        0005,10,0A,D69D, ; "E"
                        0005,11,0A,D67D, ; " "
                        0005,12,0A,D6AF, ; "H"
                        0005,13,0A,D685, ; "A"
                        0005,14,0A,D6EB, ; "R"
                        0005,15,0A,D6D3, ; "N"
                        0005,16,0A,D69D, ; "E"
                        0005,17,0A,D6F1, ; "S"
                        0005,18,0A,D6F1, ; "S"
                        0005,19,0A,D69D, ; "E"
                        0005,1A,0A,D697, ; "D"
                        0005,01,0C,D6A3, ; "F"
                        0005,02,0C,D6D9, ; "O"
                        0005,03,0C,D6EB, ; "R"
                        0005,04,0C,D67D, ; " "
                        0005,05,0C,D6F7, ; "T"
                        0005,06,0C,D6AF, ; "H"
                        0005,07,0C,D69D, ; "E"
                        0005,08,0C,D67D, ; " "
                        0005,09,0C,D6A9, ; "G"
                        0005,0A,0C,D6D9, ; "O"
                        0005,0B,0C,D6D9, ; "O"
                        0005,0C,0C,D697, ; "D"
                        0005,0D,0C,D67D, ; " "
                        0005,0E,0C,D6D9, ; "O"
                        0005,0F,0C,D6A3, ; "F"
                        0005,10,0C,D67D, ; " "
                        0005,11,0C,D691, ; "C"
                        0005,12,0C,D6B5, ; "I"
                        0005,13,0C,D703, ; "V"
                        0005,14,0C,D6B5, ; "I"
                        0005,15,0C,D6C7, ; "L"
                        0005,16,0C,D6B5, ; "I"
                        0005,17,0C,D71B, ; "Z"
                        0005,18,0C,D685, ; "A"
                        0005,19,0C,D6F7, ; "T"
                        0005,1A,0C,D6B5, ; "I"
                        0005,1B,0C,D6D9, ; "O"
                        0005,1C,0C,D6D3, ; "N"
                        0005,1D,0C,D77B, ; "!"
}
                        B0CB, ; Spawn blinking cursors and wait for input - page 4
                        9698  ; Delete
}


;;; $D15D: Intro text - page 5 ;;;
{
; SATISFIED THAT ALL WAS WELL,
; I LEFT THE STATION TO SEEK A
; NEW BOUNTY TO HUNT. BUT, I
; HAD HARDLY GONE BEYOND THE
; ASTEROID BELT WHEN I PICKED
; UP A DISTRESS SIGNAL!

$8C:D15D             dx B19B, ; Handle creating Japanese text - page 5
{
                        0001,01,01,D683,
                        0005,01,04,D6F1, ; "S"
                        0005,02,04,D685, ; "A"
                        0005,03,04,D6F7, ; "T"
                        0005,04,04,D6B5, ; "I"
                        0005,05,04,D6F1, ; "S"
                        0005,06,04,D6A3, ; "F"
                        0005,07,04,D6B5, ; "I"
                        0005,08,04,D69D, ; "E"
                        0005,09,04,D697, ; "D"
                        0005,0A,04,D67D, ; " "
                        0005,0B,04,D6F7, ; "T"
                        0005,0C,04,D6AF, ; "H"
                        0005,0D,04,D685, ; "A"
                        0005,0E,04,D6F7, ; "T"
                        0005,0F,04,D67D, ; " "
                        0005,10,04,D685, ; "A"
                        0005,11,04,D6C7, ; "L"
                        0005,12,04,D6C7, ; "L"
                        0005,13,04,D67D, ; " "
                        0005,14,04,D709, ; "W"
                        0005,15,04,D685, ; "A"
                        0005,16,04,D6F1, ; "S"
                        0005,17,04,D67D, ; " "
                        0005,18,04,D709, ; "W"
                        0005,19,04,D69D, ; "E"
                        0005,1A,04,D6C7, ; "L"
                        0005,1B,04,D6C7, ; "L"
                        0005,1C,04,D763, ; ","
                        0005,01,06,D6B5, ; "I"
                        0005,02,06,D67D, ; " "
                        0005,03,06,D6C7, ; "L"
                        0005,04,06,D69D, ; "E"
                        0005,05,06,D6A3, ; "F"
                        0005,06,06,D6F7, ; "T"
                        0005,07,06,D67D, ; " "
                        0005,08,06,D6F7, ; "T"
                        0005,09,06,D6AF, ; "H"
                        0005,0A,06,D69D, ; "E"
                        0005,0B,06,D67D, ; " "
                        0005,0C,06,D6F1, ; "S"
                        0005,0D,06,D6F7, ; "T"
                        0005,0E,06,D685, ; "A"
                        0005,0F,06,D6F7, ; "T"
                        0005,10,06,D6B5, ; "I"
                        0005,11,06,D6D9, ; "O"
                        0005,12,06,D6D3, ; "N"
                        0005,13,06,D67D, ; " "
                        0005,14,06,D6F7, ; "T"
                        0005,15,06,D6D9, ; "O"
                        0005,16,06,D67D, ; " "
                        0005,17,06,D6F1, ; "S"
                        0005,18,06,D69D, ; "E"
                        0005,19,06,D69D, ; "E"
                        0005,1A,06,D6C1, ; "K"
                        0005,1B,06,D67D, ; " "
                        0005,1C,06,D685, ; "A"
                        0005,01,08,D6D3, ; "N"
                        0005,02,08,D69D, ; "E"
                        0005,03,08,D709, ; "W"
                        0005,04,08,D67D, ; " "
                        0005,05,08,D68B, ; "B"
                        0005,06,08,D6D9, ; "O"
                        0005,07,08,D6FD, ; "U"
                        0005,08,08,D6D3, ; "N"
                        0005,09,08,D6F7, ; "T"
                        0005,0A,08,D715, ; "Y"
                        0005,0B,08,D67D, ; " "
                        0005,0C,08,D6F7, ; "T"
                        0005,0D,08,D6D9, ; "O"
                        0005,0E,08,D67D, ; " "
                        0005,0F,08,D6AF, ; "H"
                        0005,10,08,D6FD, ; "U"
                        0005,11,08,D6D3, ; "N"
                        0005,12,08,D6F7, ; "T"
                        0005,13,08,D75D, ; "."
                        0005,14,08,D67D, ; " "
                        0005,15,08,D68B, ; "B"
                        0005,16,08,D6FD, ; "U"
                        0005,17,08,D6F7, ; "T"
                        0005,18,08,D763, ; ","
                        0005,19,08,D67D, ; " "
                        0005,1A,08,D6B5, ; "I"
                        0005,01,0A,D6AF, ; "H"
                        0005,02,0A,D685, ; "A"
                        0005,03,0A,D697, ; "D"
                        0005,04,0A,D67D, ; " "
                        0005,05,0A,D6AF, ; "H"
                        0005,06,0A,D685, ; "A"
                        0005,07,0A,D6EB, ; "R"
                        0005,08,0A,D697, ; "D"
                        0005,09,0A,D6C7, ; "L"
                        0005,0A,0A,D715, ; "Y"
                        0005,0B,0A,D67D, ; " "
                        0005,0C,0A,D6A9, ; "G"
                        0005,0D,0A,D6D9, ; "O"
                        0005,0E,0A,D6D3, ; "N"
                        0005,0F,0A,D69D, ; "E"
                        0005,10,0A,D67D, ; " "
                        0005,11,0A,D68B, ; "B"
                        0005,12,0A,D69D, ; "E"
                        0005,13,0A,D715, ; "Y"
                        0005,14,0A,D6D9, ; "O"
                        0005,15,0A,D6D3, ; "N"
                        0005,16,0A,D697, ; "D"
                        0005,17,0A,D67D, ; " "
                        0005,18,0A,D6F7, ; "T"
                        0005,19,0A,D6AF, ; "H"
                        0005,1A,0A,D69D, ; "E"
                        0005,01,0C,D685, ; "A"
                        0005,02,0C,D6F1, ; "S"
                        0005,03,0C,D6F7, ; "T"
                        0005,04,0C,D69D, ; "E"
                        0005,05,0C,D6EB, ; "R"
                        0005,06,0C,D6D9, ; "O"
                        0005,07,0C,D6B5, ; "I"
                        0005,08,0C,D697, ; "D"
                        0005,09,0C,D67D, ; " "
                        0005,0A,0C,D68B, ; "B"
                        0005,0B,0C,D69D, ; "E"
                        0005,0C,0C,D6C7, ; "L"
                        0005,0D,0C,D6F7, ; "T"
                        0005,0E,0C,D67D, ; " "
                        0005,0F,0C,D709, ; "W"
                        0005,10,0C,D6AF, ; "H"
                        0005,11,0C,D69D, ; "E"
                        0005,12,0C,D6D3, ; "N"
                        0005,13,0C,D67D, ; " "
                        0005,14,0C,D6B5, ; "I"
                        0005,15,0C,D67D, ; " "
                        0005,16,0C,D6DF, ; "P"
                        0005,17,0C,D6B5, ; "I"
                        0005,18,0C,D691, ; "C"
                        0005,19,0C,D6C1, ; "K"
                        0005,1A,0C,D69D, ; "E"
                        0005,1B,0C,D697, ; "D"
                        0005,01,0E,D6FD, ; "U"
                        0005,02,0E,D6DF, ; "P"
                        0005,03,0E,D67D, ; " "
                        0005,04,0E,D685, ; "A"
                        0005,05,0E,D67D, ; " "
                        0005,06,0E,D697, ; "D"
                        0005,07,0E,D6B5, ; "I"
                        0005,08,0E,D6F1, ; "S"
                        0005,09,0E,D6F7, ; "T"
                        0005,0A,0E,D6EB, ; "R"
                        0005,0B,0E,D69D, ; "E"
                        0005,0C,0E,D6F1, ; "S"
                        0005,0D,0E,D6F1, ; "S"
                        0005,0E,0E,D67D, ; " "
                        0005,0F,0E,D6F1, ; "S"
                        0005,10,0E,D6B5, ; "I"
                        0005,11,0E,D6A9, ; "G"
                        0005,12,0E,D6D3, ; "N"
                        0005,13,0E,D685, ; "A"
                        0005,14,0E,D6C7, ; "L"
                        0005,15,0E,D77B, ; "!"
}
                        B1B3, ; Spawn blinking cursors and wait for input - page
                        9698  ; Delete
}


;;; $D511: Intro text - page 6 ;;;
{
; CERES STATION WAS UNDER
; ATTACK!!

$8C:D511             dx B228, ; Handle creating Japanese text - page 6
{
                        0001,01,01,D683,
                        0005,01,04,D691, ; "C"
                        0005,02,04,D69D, ; "E"
                        0005,03,04,D6EB, ; "R"
                        0005,04,04,D69D, ; "E"
                        0005,05,04,D6F1, ; "S"
                        0005,06,04,D67D, ; " "
                        0005,07,04,D6F1, ; "S"
                        0005,08,04,D6F7, ; "T"
                        0005,09,04,D685, ; "A"
                        0005,0A,04,D6F7, ; "T"
                        0005,0B,04,D6B5, ; "I"
                        0005,0C,04,D6D9, ; "O"
                        0005,0D,04,D6D3, ; "N"
                        0005,0E,04,D67D, ; " "
                        0005,0F,04,D709, ; "W"
                        0005,10,04,D685, ; "A"
                        0005,11,04,D6F1, ; "S"
                        0005,12,04,D67D, ; " "
                        0005,13,04,D6FD, ; "U"
                        0005,14,04,D6D3, ; "N"
                        0005,15,04,D697, ; "D"
                        0005,16,04,D69D, ; "E"
                        0005,17,04,D6EB, ; "R"
                        0005,01,06,D685, ; "A"
                        0005,02,06,D6F7, ; "T"
                        0005,03,06,D6F7, ; "T"
                        0005,04,06,D685, ; "A"
                        0005,05,06,D691, ; "C"
                        0005,06,06,D6C1, ; "K"
                        0005,07,06,D77B, ; "!"
                        0005,08,06,D77B, ; "!"
}
                        ADD4, ; Set cursor to blink
                        0080,01,01,D683,
                        B240, ; Finish intro
                        9698  ; Delete
}


;;; $D5DF: Samus blinking ;;;
{
; Pages 1..5
$8C:D5DF             dx 0080,11,0D,D781, ; Samus eyes open
                        000A,11,0D,D791, ; Samus eyes half open
                        000A,11,0D,D7A1, ; Samus eyes closed
                        000A,11,0D,D791, ; Samus eyes half open
                        0050,11,0D,D781, ; Samus eyes open
                        0008,11,0D,D791, ; Samus eyes half open
                        0008,11,0D,D7A1, ; Samus eyes closed
                        0008,11,0D,D791, ; Samus eyes half open
                        971E,D5DF        ; Go to $D5DF

; Page 6
$8C:D613             dx 0040,11,0D,D7A1, ; Samus eyes closed
                        0008,11,0D,D791  ; Samus eyes half open
$8C:D61F             dx 0010,11,0D,D7B1, ; Samus eyes deadpan
                        971E,D61F        ; Go to $D61F
}


;;; $D629: Space colony ;;;
{
$8C:D629             dx 0010,0A,18,D7C1, ; "S"
                        0010,0B,18,D7C7, ; "P"
                        0010,0C,18,D7CD, ; "A"
                        0010,0D,18,D7D3, ; "C"
                        0010,0E,18,D7D9, ; "E"
                        0010,10,18,D7D3, ; "C"
                        0010,11,18,D7DF, ; "O"
                        0010,12,18,D7E5, ; "L"
                        0010,13,18,D7DF, ; "O"
                        0010,14,18,D7EB, ; "N"
                        0010,15,18,D7F1, ; "Y"
                        C096,            ; Skip next instruction if English text
                        0001,0C,1A,D7F7, ; "スペースコロニー"
                        0080,01,01,D683,
                        C0A2,            ; Finish intro
                        9698             ; Delete
}
}


;;; $D67D: Indirect instructions - intro text ;;;
{
$8C:D67D             dx 884D,01,01,002F ; " "
$8C:D683             dx 8849            ; Nothing
$8C:D685             dx 884D,01,01,2000 ; "A"
$8C:D68B             dx 884D,01,01,2001 ; "B"
$8C:D691             dx 884D,01,01,2002 ; "C"
$8C:D697             dx 884D,01,01,2003 ; "D"
$8C:D69D             dx 884D,01,01,2004 ; "E"
$8C:D6A3             dx 884D,01,01,2005 ; "F"
$8C:D6A9             dx 884D,01,01,2006 ; "G"
$8C:D6AF             dx 884D,01,01,2007 ; "H"
$8C:D6B5             dx 884D,01,01,2008 ; "I"
$8C:D6BB             dx 884D,01,01,2009 ; "J"
$8C:D6C1             dx 884D,01,01,200A ; "K"
$8C:D6C7             dx 884D,01,01,200B ; "L"
$8C:D6CD             dx 884D,01,01,200C ; "M"
$8C:D6D3             dx 884D,01,01,200D ; "N"
$8C:D6D9             dx 884D,01,01,200E ; "O"
$8C:D6DF             dx 884D,01,01,200F ; "P"
$8C:D6E5             dx 884D,01,01,2010 ; "Q"
$8C:D6EB             dx 884D,01,01,2011 ; "R"
$8C:D6F1             dx 884D,01,01,2012 ; "S"
$8C:D6F7             dx 884D,01,01,2013 ; "T"
$8C:D6FD             dx 884D,01,01,2014 ; "U"
$8C:D703             dx 884D,01,01,2015 ; "V"
$8C:D709             dx 884D,01,01,2016 ; "W"
$8C:D70F             dx 884D,01,01,2017 ; "X"
$8C:D715             dx 884D,01,01,2018 ; "Y"
$8C:D71B             dx 884D,01,01,2019 ; "Z"
$8C:D721             dx 884D,01,01,201A ; "0"
$8C:D727             dx 884D,01,01,201B ; "1"
$8C:D72D             dx 884D,01,01,201C ; "2"
$8C:D733             dx 884D,01,01,201D ; "3"
$8C:D739             dx 884D,01,01,201E ; "4"
$8C:D73F             dx 884D,01,01,201F ; "5"
$8C:D745             dx 884D,01,01,2020 ; "6"
$8C:D74B             dx 884D,01,01,2021 ; "7"
$8C:D751             dx 884D,01,01,2022 ; "8"
$8C:D757             dx 884D,01,01,2023 ; "9"
$8C:D75D             dx 884D,01,01,2024 ; "." (full stop)
$8C:D763             dx 884D,01,01,2025 ; ","
$8C:D769             dx 884D,01,01,2026 ; "." (decimal point)
$8C:D76F             dx 884D,01,01,2027 ; "'"
$8C:D775             dx 884D,01,01,2028 ; ":"
$8C:D77B             dx 884D,01,01,202A ; "!"

$8C:D781             dx 88FD,03,02,0F89,0F8A,0F8B,0F99,0F9A,0F9B ; Samus eyes open
$8C:D791             dx 88FD,03,02,0F1D,0F1E,0F1F,0F2D,0F2E,0F2F ; Samus eyes half open
$8C:D7A1             dx 88FD,03,02,0F3A,0F3B,0F3C,0F4A,0F4B,0F4C ; Samus eyes closed
$8C:D7B1             dx 88FD,03,02,0F3D,0F3E,0F3F,0F4D,0F4E,0F4F ; Samus eyes deadpan

$8C:D7C1             dx 88B7,01,01,21ED ; "S"
$8C:D7C7             dx 88B7,01,01,21EE ; "P"
$8C:D7CD             dx 88B7,01,01,21EF ; "A"
$8C:D7D3             dx 88B7,01,01,21F7 ; "C"
$8C:D7D9             dx 88B7,01,01,21F8 ; "E"
$8C:D7DF             dx 88B7,01,01,21F9 ; "O"
$8C:D7E5             dx 88B7,01,01,21FA ; "L"
$8C:D7EB             dx 88B7,01,01,21FB ; "N"
$8C:D7F1             dx 88B7,01,01,21B9 ; "Y"

; "スペースコロニー" (space colony)
$8C:D7F7             dx 88B7,08,02,21BA,21BB,21B3,21BA,21BC,20E0,20E1,21B3,20E2,20E3,21B4,20E2,20E4,21A3,21A4,21B4
}


;;; $D81B: Initial intro Japanese text tilemap ;;;
{
; 最後のメトロイドが 獲えられ (the last metroid was captured)
; 銀河宇宙に平和が訪れた... (peace came to the Milky Way...)
$8C:D81B             dw 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 105A, 105B, 105C, 105D, 105E, 105F, 1070, 1071, 1072, 002F, 1073, 1074, 1075, 1076, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F,
                        002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 106A, 106B, 106C, 106D, 106E, 106F, 1080, 1081, 1082, 002F, 1083, 1084, 1085, 1086, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F,
                        002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 1077, 1078, 1079, 107A, 107B, 107C, 107D, 1072, 107E, 1076, 107F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F,
                        002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 1087, 1088, 1089, 108A, 108B, 108C, 108D, 1082, 108E, 1086, 108F, 1026, 1026, 1026, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F, 002F
}


;;; $D91B: Instruction list - credits scrolling ;;;
{
$8C:D91B             dx 9A17,0008   ; Timer = 8
$8C:D91F             dx 0000,1FC0,
                        9A0D,D91F,  ; Decrement timer and go to $D91F if non-zero
                        0000,0000,
                        9A17,0010   ; Timer = 10h
$8C:D92F             dx 0000,1FC0,
                        9A0D,D92F,  ; Decrement timer and go to $D92F if non-zero
                        0000,0100,
                        0000,1FC0,
                        0000,01C0,
                        0000,0200,
                        9A17,0010   ; Timer = 10h
$8C:D94B             dx 0000,1FC0,
                        9A0D,D94B,  ; Decrement timer and go to $D94B if non-zero
                        0000,0240,
                        0000,1FC0,
                        0000,0280,
                        0000,02C0,
                        9A17,0010   ; Timer = 10h
$8C:D967             dx 0000,1FC0,
                        9A0D,D967,  ; Decrement timer and go to $D967 if non-zero
                        0000,0300,
                        0000,1FC0,
                        0000,0340,
                        0000,0380,
                        0000,1FC0,
                        0000,03C0,
                        0000,0400,
                        0000,1FC0,
                        0000,0440,
                        0000,0480,
                        9A17,0010   ; Timer = 10h
$8C:D99B             dx 0000,1FC0,
                        9A0D,D99B,  ; Decrement timer and go to $D99B if non-zero
                        0000,04C0,
                        0000,1FC0,
                        0000,0500,
                        0000,0540,
                        0000,1FC0,
                        0000,0580,
                        0000,05C0,
                        9A17,0010   ; Timer = 10h
$8C:D9C3             dx 0000,1FC0,
                        9A0D,D9C3,  ; Decrement timer and go to $D9C3 if non-zero
                        0000,0600,
                        0000,1FC0,
                        0000,0640,
                        0000,0680,
                        9A17,0010   ; Timer = 10h
$8C:D9DF             dx 0000,1FC0,
                        9A0D,D9DF,  ; Decrement timer and go to $D9DF if non-zero
                        0000,06C0,
                        0000,1FC0,
                        0000,0700,
                        0000,0740,
                        9A17,0010   ; Timer = 10h
$8C:D9FB             dx 0000,1FC0,
                        9A0D,D9FB,  ; Decrement timer and go to $D9FB if non-zero
                        0000,14C0,
                        0000,1AC0,
                        0000,1FC0,
                        0000,1500,
                        0000,1540,
                        9A17,0010   ; Timer = 10h
$8C:DA1B             dx 0000,1FC0,
                        9A0D,DA1B,  ; Decrement timer and go to $DA1B if non-zero
                        0000,1580,
                        0000,1FC0,
                        0000,1500,
                        0000,1540,
                        0000,1FC0,
                        0000,15C0,
                        0000,1600,
                        9A17,0010   ; Timer = 10h
$8C:DA43             dx 0000,1FC0,
                        9A0D,DA43,  ; Decrement timer and go to $DA43 if non-zero
                        0000,0780,
                        0000,1FC0,
                        0000,07C0,
                        0000,1000,
                        9A17,0010   ; Timer = 10h
$8C:DA5F             dx 0000,1FC0,
                        9A0D,DA5F,  ; Decrement timer and go to $DA5F if non-zero
                        0000,1040,
                        0000,1FC0,
                        0000,1080,
                        0000,10C0,
                        9A17,0010   ; Timer = 10h
$8C:DA7B             dx 0000,1FC0,
                        9A0D,DA7B,  ; Decrement timer and go to $DA7B if non-zero
                        0000,1100,
                        0000,1FC0,
                        0000,1140,
                        0000,1180,
                        9A17,0010   ; Timer = 10h
$8C:DA97             dx 0000,1FC0,
                        9A0D,DA97,  ; Decrement timer and go to $DA97 if non-zero
                        0000,11C0,
                        0000,1FC0,
                        0000,1200,
                        0000,1240,
                        9A17,0010   ; Timer = 10h
$8C:DAB3             dx 0000,1FC0,
                        9A0D,DAB3,  ; Decrement timer and go to $DAB3 if non-zero
                        0000,1280,
                        0000,1FC0,
                        0000,12C0,
                        0000,1300,
                        9A17,0010   ; Timer = 10h
$8C:DACF             dx 0000,1FC0,
                        9A0D,DACF,  ; Decrement timer and go to $DACF if non-zero
                        0000,1340,
                        0000,1FC0,
                        0000,1380,
                        0000,13C0,
                        9A17,0010   ; Timer = 10h
$8C:DAEB             dx 0000,1FC0,
                        9A0D,DAEB,  ; Decrement timer and go to $DAEB if non-zero
                        0000,1400,
                        0000,1FC0,
                        0000,1440,
                        0000,1480,
                        9A17,0010   ; Timer = 10h
$8C:DB07             dx 0000,1FC0,
                        9A0D,DB07,  ; Decrement timer and go to $DB07 if non-zero
                        0000,1940,
                        0000,1FC0,
                        0000,1980,
                        0000,19C0,
                        9A17,0010   ; Timer = 10h
$8C:DB23             dx 0000,1FC0,
                        9A0D,DB23,  ; Decrement timer and go to $DB23 if non-zero
                        0000,1A00,
                        0000,1FC0,
                        0000,1A40,
                        0000,1A80,
                        0000,1FC0,
                        0000,0FC0,
                        0000,1800,
                        9A17,0010   ; Timer = 10h
$8C:DB4B             dx 0000,1FC0,
                        9A0D,DB4B,  ; Decrement timer and go to $DB4B if non-zero
                        0000,1640,
                        0000,1FC0,
                        0000,1680,
                        0000,16C0,
                        0000,1FC0,
                        0000,1700,
                        0000,1740,
                        0000,1FC0,
                        0000,1780,
                        0000,17C0,
                        0000,1FC0,
                        0000,18C0,
                        0000,1900,
                        0000,1FC0,
                        0000,1B00,
                        0000,1B40,
                        0000,1FC0,
                        0000,1B80,
                        0000,1BC0,
                        9A17,0010   ; Timer = 10h
$8C:DBA3             dx 0000,1FC0,
                        9A0D,DBA3,  ; Decrement timer and go to $DBA3 if non-zero
                        0000,0800,
                        0000,1FC0,
                        0000,0840,
                        0000,0880,
                        0000,1FC0,
                        0000,08C0,
                        0000,0900,
                        0000,1FC0,
                        0000,09C0,
                        0000,0A00,
                        0000,1FC0,
                        0000,0AC0,
                        0000,0B00,
                        0000,1FC0,
                        0000,0BC0,
                        0000,0C00,
                        0000,1FC0,
                        0000,0C40,
                        0000,0C80,
                        0000,1FC0,
                        0000,0CC0,
                        0000,0D00,
                        0000,1FC0,
                        0000,0D40,
                        0000,0D80,
                        0000,1FC0,
                        0000,0E40,
                        0000,0E80,
                        0000,1FC0,
                        0000,0EC0,
                        0000,0F00,
                        0000,1FC0,
                        0000,0F40,
                        0000,0F80,
                        0000,1FC0,
                        0000,1840,
                        0000,1880,
                        0000,1FC0,
                        0000,1E80,
                        0000,1EC0,
                        0000,1FC0,
                        0000,1F00,
                        0000,1F40,
                        0000,1FC0,
                        0000,0B40,
                        0000,0B80,
                        0000,1FC0,
                        0000,1C00,
                        0000,1C40,
                        9A17,0010   ; Timer = 10h
$8C:DC73             dx 0000,1FC0,
                        9A0D,DC73,  ; Decrement timer and go to $DC73 if non-zero
                        0000,1C80,
                        0000,1FC0,
                        0000,0140,
                        0000,0180,
                        9A17,0023   ; Timer = 23h
$8C:DC8F             dx 0000,1FC0,
                        9A0D,DC8F,  ; Decrement timer and go to $DC8F if non-zero
                        F6FE        ; End credits
                        99FE        ; Delete
}


;;; $DC9B: Tilemap - credits - Deer Force ;;;
{
$8C:DC9B             dw 004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,000F,0011,000E,0003,0014,0002,0004,0003,004F,0001,0018,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,
                        004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,
                        004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,1823,1824,1824,1841,004F,1825,182E,1841,1822,1824,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,
                        004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,1833,1834,1834,1851,004F,1835,183E,1851,1832,1834,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,
                        004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,
                        004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,000E,0005,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,
                        004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,
                        004F,004F,004F,004F,004F,004F,004F,004F,004F,1C43,1C24,1C20,1C2C,004F,1C42,1C27,1C28,1C2A,1C20,1C2C,1C20,1C41,1C44,004F,004F,004F,004F,004F,004F,004F,004F,004F,
                        004F,004F,004F,004F,004F,004F,004F,004F,004F,1C53,1C34,1C30,1C3C,004F,1C52,1C37,1C38,1C3A,1C30,1C3C,1C30,1C51,1C54,004F,004F,004F,004F,004F,004F,004F,004F,004F
}


;;; $DEDB: Tilemap - credits - 1994 Nintendo ;;;
{
$8C:DEDB             dw 007F,007F,007F,007F,007F,007F,007F,007F,007F,0061,0069,0069,0064,007F,007F,002D,0028,002D,0043,0024,002D,0023,002E,007F,007F,007F,007F,007F,007F,007F,007F,007F,
                        007F,007F,007F,007F,007F,007F,007F,007F,007F,0071,0079,0079,0074,007F,007F,003D,0038,003D,0053,0034,003D,0033,003E,007F,007F,007F,007F,007F,007F,007F,007F,007F
}


;;; $DF5B: Tilemap - credits - item percentage Japanese text ;;;
{
; アイテム発見パーセンテージ (percentage of items discovered)
$8C:DF5B             dw 004F,004F,004F,004F,004F,004F,004F,004F,004F,005B,005C,005D,005E,005F,0080,0081,0082,0083,0084,0085,0086,0087,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F,
                        004F,004F,004F,004F,004F,004F,004F,004F,004F,006B,006C,006D,006E,006F,0090,0091,0092,0093,0094,0095,0096,0097,004F,004F,004F,004F,004F,004F,004F,004F,004F,004F
}


;;; $DFDB..E12E: Cinematic BG object instruction lists - ending ;;;
{
;;; $DFDB: Item percentage ;;;
{
;    YOUR RATE FOR
; COLLECTING ITEMS IS
$8C:DFDB             dx 0040,00,00,E12F, ; Nothing
                        0004,09,0A,E1DD, ; "Y"
                        0004,0A,0A,E1BF, ; "O"
                        0004,0B,0A,E1D7, ; "U"
                        0004,0C,0A,E1C5, ; "R"
                        0004,0D,0A,E1E3, ; " "
                        0004,0E,0A,E1C5, ; "R"
                        0004,0F,0A,E189, ; "A"
                        0004,10,0A,E1D1, ; "T"
                        0004,11,0A,E195, ; "E"
                        0004,12,0A,E1E3, ; " "
                        0004,13,0A,E19B, ; "F"
                        0004,14,0A,E1BF, ; "O"
                        0004,15,0A,E1C5, ; "R"
                        0004,06,0C,E18F, ; "C"
                        0004,07,0C,E1BF, ; "O"
                        0004,08,0C,E1AD, ; "L"
                        0004,09,0C,E1AD, ; "L"
                        0004,0A,0C,E195, ; "E"
                        0004,0B,0C,E18F, ; "C"
                        0004,0C,0C,E1D1, ; "T"
                        0004,0D,0C,E1A7, ; "I"
                        0004,0E,0C,E1B9, ; "N"
                        0004,0F,0C,E1A1, ; "G"
                        0004,10,0C,E1E3, ; " "
                        0004,11,0C,E1A7, ; "I"
                        0004,12,0C,E1D1, ; "T"
                        0004,13,0C,E195, ; "E"
                        0004,14,0C,E1B3, ; "M"
                        0004,15,0C,E1CB, ; "S"
                        0004,16,0C,E1E3, ; " "
                        0004,17,0C,E1A7, ; "I"
                        0004,18,0C,E1CB, ; "S"
                        E627,            ; Item percentage count
                        E769,            ; Handle creating Japanese text
                        0080,00,00,E12F, ; Nothing
                        E780,
                        9698             ; Delete
}


;;; $E0AF: See you next mission ;;;
{
$8C:E0AF             dx 0040,00,00,E12F, ; Nothing
                        0004,06,02,E139, ; "S"
                        0004,07,02,E141, ; "E"
                        0004,08,02,E141, ; "E"
                        0004,09,02,E131, ; " "
                        0004,0A,02,E149, ; "Y"
                        0004,0B,02,E151, ; "O"
                        0004,0C,02,E159, ; "U"
                        0004,0D,02,E131, ; " "
                        0004,0E,02,E161, ; "N"
                        0004,0F,02,E141, ; "E"
                        0004,10,02,E169, ; "X"
                        0004,11,02,E171, ; "T"
                        0004,12,02,E131, ; " "
                        0004,13,02,E179, ; "M"
                        0004,14,02,E181, ; "I"
                        0004,15,02,E139, ; "S"
                        0004,16,02,E139, ; "S"
                        0004,17,02,E181, ; "I"
                        0004,18,02,E151, ; "O"
                        0004,19,02,E161, ; "N"
                        9698             ; Delete
}
}


;;; $E12F: Indirect instructions - ending ;;;
{
$8C:E12F             dx 8849 ; Nothing

$8C:E131             dx 88B7,01,02,207F,207F ; " "
$8C:E139             dx 88B7,01,02,2042,2052 ; "S"
$8C:E141             dx 88B7,01,02,2024,2034 ; "E"
$8C:E149             dx 88B7,01,02,2048,2058 ; "Y"
$8C:E151             dx 88B7,01,02,202E,203E ; "O"
$8C:E159             dx 88B7,01,02,2044,2054 ; "U"
$8C:E161             dx 88B7,01,02,202D,203D ; "N"
$8C:E169             dx 88B7,01,02,2047,2057 ; "X"
$8C:E171             dx 88B7,01,02,2043,2053 ; "T"
$8C:E179             dx 88B7,01,02,202C,203C ; "M"
$8C:E181             dx 88B7,01,02,2028,2038 ; "I"

$8C:E189             dx 88B7,01,01,3C00 ; "A"
$8C:E18F             dx 88B7,01,01,3C02 ; "C"
$8C:E195             dx 88B7,01,01,3C04 ; "E"
$8C:E19B             dx 88B7,01,01,3C05 ; "F"
$8C:E1A1             dx 88B7,01,01,3C06 ; "G"
$8C:E1A7             dx 88B7,01,01,3C08 ; "I"
$8C:E1AD             dx 88B7,01,01,3C0B ; "L"
$8C:E1B3             dx 88B7,01,01,3C0C ; "M"
$8C:E1B9             dx 88B7,01,01,3C0D ; "N"
$8C:E1BF             dx 88B7,01,01,3C0E ; "O"
$8C:E1C5             dx 88B7,01,01,3C11 ; "R"
$8C:E1CB             dx 88B7,01,01,3C12 ; "S"
$8C:E1D1             dx 88B7,01,01,3C13 ; "T"
$8C:E1D7             dx 88B7,01,01,3C14 ; "U"
$8C:E1DD             dx 88B7,01,01,3C18 ; "Y"
$8C:E1E3             dx 88B7,01,01,207F ; " "
}


;;; $E1E9: Palettes - title screen ;;;
{
$8C:E1E9             dw 0000,02DF,01D7,00AC,5EBB,3DB3,292E,1486,48FB,48FB,7FFF,0000,7FFF,44E5,7FFF,0000,
                        1000,0BB1,1EA9,0145,5EBB,3DB3,292E,1486,6318,4A52,318C,0000,6318,02DF,7FFF,0000,
                        1000,7E20,6560,2060,1000,7940,5D00,4CA0,3CA0,7FFF,0113,000F,175C,0299,13FF,0BB1,
                        1000,6BF5,2E41,2DA1,2D01,5E5F,183F,1014,080A,0404,4F9F,3ED8,2E12,6F70,7FFF,5EE0,
                        1000,7C00,5800,3400,1000,6C00,4800,2400,0000,0000,0000,0000,0000,0000,0000,0000,
                        1000,3570,24CB,0402,0401,312E,1889,1026,0C04,43FF,0118,0014,16FF,023E,017B,5EE0,
                        1000,72F2,6A4D,4524,1400,5E5F,2C3F,2414,1C0A,6B5E,4E78,2991,6A99,4174,400F,0040,
                        1000,033B,001F,0174,080A,7FFF,0D66,00E2,0299,0000,0000,0000,0000,0000,7FFF,0000,
                        1000,7FFF,13FF,131D,121F,093F,00BF,0017,0C8C,7FFF,7D80,6F5A,5AB5,4A10,354A,1000,
                        1000,7FFF,13FF,131D,121F,093F,00BF,0017,0C8C,001F,2000,6F5A,5AB5,4A10,354A,1000,
                        1000,7FFF,13FF,0F5F,0EBF,0A1F,055F,04BF,001F,0018,1032,204C,3066,5AB5,354A,1000,
                        1000,6BF5,2E41,2DA1,2D01,5E5F,183F,1014,080A,0404,4F9F,3ED8,2E12,6F70,7FFF,5EE0,
                        1000,7C00,5800,3400,1000,6C00,4800,2400,0000,0000,0000,0000,0000,0000,0000,0000,
                        1000,3570,24CB,0402,0401,312E,1889,1026,0C04,43FF,0118,0014,16FF,023E,017B,5EE0,
                        1000,72F2,6A4D,4524,1400,5E5F,2C3F,2414,1C0A,6B5E,4E78,2991,0299,0174,000F,0040,
                        1000,033B,001F,0174,080A,7FFF,0D66,00E2,0299,0000,0000,0000,0000,0000,7FFF,0000
}


;;; $E3E9: Palettes - intro ;;;
{
$8C:E3E9             dw 0000,03E0,6318,0340,3BE0,03E0,6318,0280,2680,03E0,6318,0200,1580,03E0,6318,0160,
                        0000,7FFF,0000,294A,7FFF,6318,294A,6318,6318,6318,6318,6318,6318,6318,0000,6318,
                        0000,77FF,677B,52D6,4252,2DAD,1908,10C6,0884,6318,6318,6318,6318,6318,6318,0000,
                        0000,1400,15AA,0000,5B80,2501,14A2,568D,3DC7,14B8,1840,3140,1C42,24A0,146D,1405,
                        0000,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,77BD,4252,18E7,1084,5318,2DCE,2529,18C6,5318,2DEF,194A,10C6,77FF,77FF,0000,
                        3800,7FFF,7BDE,77BD,739C,7FFF,7BDE,77BD,739C,7FFF,7BDE,77BD,739C,7FFF,7BDE,77BD,
                        3800,5318,2DCE,1929,10C6,5318,2DCE,1929,10C6,0404,5318,2DCE,1929,5318,77FF,5318,
                        3800,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        3800,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        3800,2DAD,52D6,1084,77FF,2DAD,677B,52D6,4252,4252,4252,1908,4252,1908,2DAD,1908,
                        3800,77FF,4294,2DCE,1908,4294,2DCE,1908,4294,2DCE,1908,4294,2DCE,1908,1084,77FF,
                        3800,77FF,677B,52D6,4252,2DAD,1908,10C6,0884,7C00,5800,3400,1000,03E0,15C0,0000,
                        3800,77FF,4252,1084,0842,5739,2DCE,2108,14A5,5318,2DEF,194A,10C6,77FF,77FF,0000
}


;;; $E5E9: Palettes - space/gunship/Ceres ;;;
{
$8C:E5E9             dw 0000,7FFF,6318,294A,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        1580,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        1580,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        1580,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        1580,373F,2E9E,2E3B,25D8,1D33,14AE,144A,0803,7DFF,6819,5413,340A,2004,1403,0000,
                        1580,4BBE,06B9,00EA,0000,173A,0276,01F2,014D,3BE0,2680,1580,49EF,3129,20A5,7FFF,
                        1580,631F,56BB,4E36,41D2,354D,28E9,2064,1400,1580,1580,1580,1580,001F,001F,0000,
                        1580,233F,1A9E,1A3B,11D8,0933,00AE,004A,0001,7DFF,6819,5413,340A,2004,0404,0000,
                        3800,7FFF,6318,294A,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        3800,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        3800,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        3800,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        3800,373F,2E9E,2E3B,25D8,1D33,14AE,144A,0803,7DFF,6819,5413,340A,2004,1403,0000,
                        3800,7F5A,033B,0216,0113,7C1D,5814,300A,3BE0,2680,1580,5294,39CE,2108,2484,03E0,
                        3800,631F,56BB,4E36,41D2,354D,28E9,2064,1400,1580,1580,1580,1580,001F,001F,0000,
                        3800,233F,1A9E,1A3B,11D8,0933,00AE,004A,0001,7F20,75A0,5500,3840,2020,0404,0000
}


;;; $E7E9: Palettes - post-credits ;;;
{
$8C:E7E9             dw 0420,7FFF,7FFF,7FFF,7FFF,03E0,001F,7C00,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,
                        2003,02FF,0217,0150,0089,5F9F,3A9F,2A19,1DB4,114F,090B,0457,4E73,3106,24A3,0842,
                        2003,00CE,421F,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,5914,30AA,0216,1104,0074,000D,
                        0000,701C,0C03,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,061F,0063,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,7FDF,7319,5A32,51AD,4529,3884,2C00,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,039C,00C6,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,4380,0060,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        3800,7FFF,6F7B,5AD6,4A52,35AD,2529,1084,0C20,0420,0420,0420,0420,0420,0420,0420,
                        3800,0420,0420,0420,0420,7E3F,5816,300A,3BE0,2680,1580,5294,39CE,2108,2484,7C1F,
                        3800,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,
                        3800,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,0420,
                        3800,7F5A,033B,0216,0113,7FE0,7E00,7CA0,3BE0,2680,1580,5294,39CE,2108,2484,7EA0,
                        3800,02FF,0217,0150,0089,5F9F,3A9F,2A19,1DB4,114F,090B,0457,4E73,3106,24A3,0842,
                        3800,00CE,421F,1405,3BE0,21A8,579F,4AD2,3A4E,00BB,5914,30AA,0216,1104,0074,000D,
                        3800,28E7,76F7,1405,63E0,28E7,579F,66D6,4D8C,62B5,454A,1C84,6273,28E7,354A,1C84
}


;;; $E9E9: Palettes - credits ;;;
{
$8C:E9E9             dw 0000,739C,28C6,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,039C,00C6,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,7380,0C60,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,4380,0060,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,701C,0C03,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,7E00,0420,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,061F,0063,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        0000,7D34,0C03,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        3800,7FFF,7BDE,77BD,739C,7FFF,7BDE,77BD,739C,7FFF,7BDE,77BD,739C,7FFF,7BDE,77BD,
                        3800,5318,2DCE,1929,10C6,5318,2DCE,1929,10C6,0404,5318,2DCE,1929,5318,77FF,5318,
                        3800,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        3800,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,
                        3800,2DAD,52D6,1084,77FF,2DAD,677B,52D6,4252,4252,4252,1908,4252,1908,2DAD,1908,
                        3800,77FF,4294,2DCE,1908,4294,2DCE,1908,4294,2DCE,1908,4294,2DCE,1908,1084,77FF,
                        3800,77FF,677B,52D6,4252,2DAD,1908,10C6,0884,7C00,5800,3400,1000,03E0,15C0,0000,
                        3800,77FF,4252,1084,0842,5739,2DCE,2108,14A5,5318,2DEF,194A,10C6,77FF,77FF,0000
}


;;; $EBE9: Palettes - Zebes explosion scene ;;;
{
$8C:EBE9             dw 0000,7FFF,77BD,6F7B,6318,5AD6,5294,4A52,4210,35AD,2D6B,2529,1CE7,14A5,0842,0000,
                        1580,7FFF,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        1580,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        1580,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        1580,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0800,
                        1580,4BBE,06B9,00EA,0000,173A,0276,01F2,014D,3BE0,2680,1580,49EF,3129,20A5,7FFF,
                        1580,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0800,
                        1580,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0800,
                        3800,7FFF,2108,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,
                        3800,039C,00C6,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,
                        3800,4380,0060,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,
                        3800,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,
                        3800,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,3DEF,
                        3800,029F,017D,0055,0010,000A,0005,0000,0001,2108,35AD,4631,5AD6,6B5A,0000,0000,
                        3800,6B9C,5EBB,45B8,3D58,2CD4,408F,288A,1C47,4E73,4E73,0800,4E73,2003,1002,0800,
                        3800,233F,1A9E,1A3B,11D8,0933,00AE,004A,0001,7DFF,6819,5413,340A,2004,1403,0000
}


;;; $EDE9: Palettes - cloud sprites in Zebes explosion scene ;;;
{
$8C:EDE9             dw 0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        2823,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        2823,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        2823,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        2823,0864,0884,0CA6,10C7,0CC8,0D07,0D0A,0CEC,0D2C,112C,118E,0D70,11F4,1633,1698,
                        2823,0842,0C63,1084,14A5,18C6,1CE7,2108,2529,2D6B,318C,39CE,4631,4A52,5294,6318,
                        2823,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        2823,233F,1A9E,1A3B,11D8,0933,00AE,004A,0001,7DFF,6819,5413,340A,2004,0404,0000,
                        3800,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        3800,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        3800,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        3800,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        3800,0023,0465,0CA7,10E9,190A,1D4C,258E,29D0,3212,3654,3E96,42B7,46F9,4F3B,537D,
                        3800,0CA7,10E9,190A,1D4C,258D,29CF,2DF1,3632,3A74,4295,46D7,4B19,535A,577C,5BBD,
                        3800,0842,0C63,1084,14A5,18C6,1CE7,2108,2529,2D6B,318C,39CE,4631,4A52,5294,6318,
                        3800,233F,1A9E,1A3B,11D8,0933,00AE,004A,0001,7DFF,6819,5413,340A,2004,1403,0000
}


;;; $EFE9: Palettes - ending Super Metroid icon glare ;;;
{
$8C:EFE9             dw 0000,013F,0030,0005,025F,00F2,0029,035F,0192,0089,7BE0,7980,4400,43FF,03FF,1C84,
                        0000,011D,002F,0004,021D,00D0,0028,031D,0170,0068,73A0,7160,3C00,3FBD,03BD,1863,
                        0000,00FA,000D,0004,01FA,00CF,0007,02DA,014F,0067,6B40,6940,3800,375A,035A,1863,
                        0000,00F8,000C,0004,01D8,00AE,0007,0298,012E,0067,6300,6120,3400,3318,0318,1463,
                        0000,00D6,000B,0003,01B6,00AD,0006,0276,010D,0066,5AC0,5900,3000,2ED6,02D6,1463,
                        0000,00D4,000A,0003,0194,008C,0006,0234,010C,0046,5280,5100,2C00,2A94,0294,1042,
                        0000,00B2,0009,0003,0152,008A,0005,01F2,00EA,0045,4A40,48E0,2800,2652,0252,1042,
                        0000,0090,0008,0002,0130,0069,0004,01B0,00C9,0044,4200,40C0,2400,2210,0210,0C42,
                        0000,008E,0007,0002,010E,0068,0004,018E,00A8,0024,39C0,38A0,2000,1DCE,01CE,0C21,
                        0000,006C,0006,0002,00EC,0047,0003,014C,0087,0023,3180,3080,1800,198C,018C,0821,
                        0000,006A,0005,0001,00CA,0046,0003,010A,0086,0023,2940,2880,1400,154A,014A,0821,
                        0000,0048,0004,0001,0088,0024,0002,00E8,0064,0022,2100,2060,1000,1108,0108,0421,
                        0000,0026,0003,0001,0066,0023,0001,00A6,0043,0001,18C0,1840,0C00,0CC6,00C6,0400,
                        0000,0024,0002,0000,0044,0022,0001,0064,0022,0001,1080,1020,0800,0884,0084,0400,
                        0000,0002,0001,0000,0022,0001,0000,0022,0001,0000,0840,0800,0400,0442,0042,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000
}


;;; $F1E9: Palettes - ending Super Metroid icon fading to grey ;;;
{
$8C:F1E9             dw 0000,6B5A,5EF7,5294,4631,35AD,294A,1CE7,1084,0000,0000,0000,0000,0000,0000,0000,
                        0000,6318,56B5,4A52,3DEF,318C,2529,18C6,0C63,0000,0000,0000,0000,0000,0000,0000,
                        0000,5AD6,5294,4631,39CE,2D6B,2108,18C6,0C63,0000,0000,0000,0000,0000,0000,0000,
                        0000,5294,4A52,4210,35AD,294A,2108,14A5,0C63,0000,0000,0000,0000,0000,0000,0000,
                        0000,4E73,4210,39CE,318C,2529,1CE7,14A5,0C63,0000,0000,0000,0000,0000,0000,0000,
                        0000,4631,3DEF,35AD,2D6B,2108,18C6,1084,0842,0000,0000,0000,0000,0000,0000,0000,
                        0000,3DEF,35AD,318C,294A,1CE7,18C6,1084,0842,0000,0000,0000,0000,0000,0000,0000,
                        0000,35AD,318C,294A,2529,1CE7,14A5,0C63,0842,0000,0000,0000,0000,0000,0000,0000,
                        0000,318C,294A,2529,2108,18C6,1084,0C63,0421,0000,0000,0000,0000,0000,0000,0000,
                        0000,294A,2529,2108,18C6,14A5,1084,0842,0421,0000,0000,0000,0000,0000,0000,0000,
                        0000,2108,1CE7,18C6,14A5,1084,0C63,0842,0421,0000,0000,0000,0000,0000,0000,0000,
                        0000,1CE7,18C6,14A5,1084,0C63,0842,0421,0421,0000,0000,0000,0000,0000,0000,0000,
                        0000,14A5,1084,1084,0C63,0842,0842,0421,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0C63,0C63,0842,0842,0421,0421,0421,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0421,0421,0421,0421,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
                        0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000
}


;;; $F3E9: Free space ;;;
{
$8C:F3E9             fillto $8D8000, $FF
}
