; "Complement" below means bitwise NOT

$70:0000: Slot 0 checksum
$70:0002: Slot 1 checksum
$70:0004: Slot 2 checksum
$70:0006: Unused
$70:0008: Slot 0 checksum complement
$70:000A: Slot 1 checksum complement
$70:000C: Slot 2 checksum complement
$70:000E: Unused

; These three save slots have identical layout
$70:0010..066B: Slot 0. Copied from $7E:D7C0..DE1B
{
    $70:0010..6F: Samus data and game options. Copied from $09A2..0A01
    {
        $70:0010: Equipped items
        $70:0012: Collected items
        {
            1: Varia suit
            2: Spring ball
            4: Morph ball
            8: Screw attack
            20h: Gravity suit
            100h: Hi-jump boots
            200h: Space jump
            1000h: Bombs
            2000h: Speed booster
            4000h: Grapple
            8000h: X-Ray
        }
        $70:0014: Equipped beams
        $70:0016: Collected beams
        {
            1: Wave
            2: Ice
            4: Spazer
            8: Plasma
            1000h: Charge
        }
        $70:0018: Up binding. D-pad bindings are only used by x-ray
        {
            8000h: B
            4000h: Y
            2000h: Select
            1000h: Start
            800h: Up
            400h: Down
            200h: Left
            100h: Right
            80h: A
            40h: X
            20h: L
            10h: R
        }
        $70:001A: Down binding
        $70:001C: Left binding
        $70:001E: Right binding
        $70:0020: Shoot binding
        $70:0022: Jump binding
        $70:0024: Run binding
        $70:0026: Item cancel binding
        $70:0028: Item select binding
        $70:002A: Aim down binding
        $70:002C: Aim up binding
        $70:002E: Reserve health mode
        {
            0: Not obtained
            1: Auto
            2: Manual
        }
        $70:0030: Samus health
        $70:0032: Samus max health
        $70:0034: Samus missiles
        $70:0036: Samus max missiles
        $70:0038: Samus super missiles
        $70:003A: Samus max super missiles
        $70:003C: Samus power bombs
        $70:003E: Samus max power bombs
        $70:0040: HUD item index. HUD item index is set to 0 when loading Samus, so this SRAM value has no effect
        {
            0: Nothing
            1: Missiles
            2: Super missiles
            3: Power bombs
            4: Grapple beam
            5: X-ray
        }
        $70:0042: Samus max reserve health
        $70:0044: Samus reserve health
        $70:0046: Samus reserve missiles. Only used by missile pickup routine ($91:DF80)
        $70:0048: Game time, frames
        $70:004A: Game time, seconds
        $70:004C: Game time, minutes
        $70:004E: Game time, hours (capped at 99:59:59.59)
        $70:0050: Japanese text flag
        $70:0052: Moonwalk flag
        $70:0054: Debug. Disable Samus placement mode flag. 0: Allows positioning Samus in demo recorder. Set to 1
        $70:0056: Unused. Set to 1
        $70:0058: Icon cancel flag (cancel HUD item on door transition)
        $70:005A..6F: Unused
    }
    $70:0070..77: Event bit array. Bytes 3..7 are unused
    {
        $70:0070:
        {
            1:   Event 0 - Zebes is awake
            2:   Event 1 - Shitroid ate sidehopper
            4:   Event 2 - Mother Brain's glass is broken
            8:   Event 3 - zebetite destroyed bit 0 (true if 1 or 3 zebetites are destroyed)
            10h: Event 4 - zebetite destroyed bit 1 (true if 2 or 3 zebetites are destroyed)
            20h: Event 5 - zebetite destroyed bit 2 (true if all 4 zebetites are destroyed)
            40h: Event 6 - Phantoon statue is grey
            80h: Event 7 - Ridley statue is grey
        }
        $70:0071:
        {
            1:   Event 8  - Draygon statue is grey
            2:   Event 9  - Kraid statue is grey
            4:   Event Ah - entrance to Tourian is unlocked
            8:   Event Bh - Maridia noobtube is broken
            10h: Event Ch - Lower Norfair chozo has lowered the acid
            20h: Event Dh - Shaktool cleared a path
            40h: Event Eh - Zebes timebomb set
            80h: Event Fh - critters escaped
        }
        $70:0072:
        {
            1:   Event 10h - 1st metroid hall cleared
            2:   Event 11h - 1st metroid shaft cleared
            4:   Event 12h - 2nd metroid hall cleared
            8:   Event 13h - 2nd metroid shaft cleared
            10h: Event 14h - unused
            20h: Event 15h - outran speed booster lavaquake
        }
    }
    $70:0078..7F: Boss bits
    {
        $70:0078: Crateria boss bits
        {
            4: Bomb Torizo
        }
        $70:0079: Brinstar boss bits
        {
            1: Kraid
            2: Spore Spawn
        }
        $70:007A: Norfair boss bits
        {
            1: Ridley
            2: Crocomire
            4: Golden Torizo
        }
        $70:007B: Wrecked Ship boss bits
        {
            1: Phantoon
        }
        $70:007C: Maridia boss bits
        {
            1: Draygon
            2: Botwoon
        }
        $70:007D: Tourian boss bits
        {
            2: Mother Brain
        }
        $70:007E: Ceres boss bits
        {
            1: Ceres Ridley
        }
        $70:007F: Debug boss bits
    }
    $70:0080..BF: Unused. Chozo block destroyed bit array. Used by unused chozo block PLMs $D700/D708. Cleared on new save file
    $70:00C0..FF: Item collected bit array. Bytes 14h..3Fh are unused. See "Item PLMs.asm"
    {
        $00      $01      $02      $03      $04      $05      $06      $07      $08      $09      $0A       $10      $11      $12      $13
        01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567  01234567 01234567 01234567 01234567
        CCCCCCCC CCCCCBBB BBBB BBB BBBBBBBB  BBBBBBB BBBBB    BNNNNNNN NNNNNNNN NNNNN NN  NNNNNNN N         WWWWWWWW MMMMMMMM MMMMMMMM M M      ; Area (Crateria / Brinstar / Norfair / Wrecked Ship / Maridia)
        PMMMMEMI EMMSMPSM SRMM MMB PMIPMEES  EMEMMIP PMBEM    IMBMEIMM EPMMIRMM MMIMB MS  MMPPMEI E         MRMMESSI MSEMSMMB MRMPMSIM E I      ; Item (Energy / Reserve / Missile / Super / Power bomb / Item / Beam)
    }
    $70:0100..3F: Opened door bit array. Bytes 16h..3Fh are unused. See "Door PLMs.asm"
    {
        $00      $01      $02      $03      $04      $05      $06      $07      $08      $09      $0A      $0B      $0C       $10      $11      $12      $13      $14      $15
        01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567  01234567 01234567 01234567 01234567 01234567 01234567
        CCCCCCCC CCCCCCCC CCCCCCCC CCCCCCCB BBBBBBBB BBBBBBBB BBBBBBBB BBBBBBBB BBBBBBBB CNNNNNNN NNNNNNNN NNNNNNNN N         WWWWWWWW WWWWMMMM MMMMMMMM MMMMMMMM TTTTTTTT TTTTT    ; Area (Crateria / Brinstar / Norfair / Wrecked Ship / Maridia / Tourian)
        GYgggRgg ggggGYYY YggYgggg gggggRRR RRRRggRG YGRRggGg YgRGGGgg GYRGYGgG ggggGEgg gGRGYRGg gRRGGRRR YgggEgYG g         ggggGEgg gggRRRRG RgRgGGRg RGGEgggg gggggggR ERggg    ; Door (grey / Red / Green / Yellow / Eye)
    }
    $70:0140..47: Unused. Cleared in new save file
    $70:0148..57: Used save stations and debug elevators
    {
        $70:0148: Used Crateria save stations
        {
            1: Landing site
            2: Crateria save station
        }
        $70:0149: Used Crateria debug elevators
        $70:014A: Used Brinstar save stations
        {
            1: Spore Spawn save station
            2: Green Brinstar mainstreet save station
            4: Brinstar false floor save station
            8: Kraid save station
            10h: Red Brinstar save station
        }
        $70:014B: Used Brinstar debug elevators
        $70:014C: Used Norfair save stations
        {
            1: Post Crocomire save station
            2: Bubble Norfair save station
            4: Rock Norfair save station
            8: Pre Crocomire save station
            10h: Pre Lower Norfair save station
            20h: Lower Norfair save station
        }
        $70:014D: Used Norfair debug elevators
        $70:014E: Used Wrecked Ship save stations
        {
            1: Wrecked Ship save station
        }
        $70:014F: Used Wrecked Ship debug elevators
        $70:0150: Used Maridia save stations
        {
            1: n00b tube save station
            2: Forgotten highway save station
            4: Snail room save station
            8: Draygon save station
        }
        $70:0151: Used Maridia debug elevators
        $70:0152: Used Tourian save stations
        {
            1: Mother Brain save station
            2: Tourian entrance save station
        }
        $70:0153: Used Tourian debug elevators
        $70:0154: Used Ceres save stations
        $70:0155: Used Ceres debug elevators
        $70:0156: Used debug save stations
        $70:0157: Used debug debug elevators
    }
    $70:0158..5F: Map collected bit array
    {
        $70:0158: Crateria map collected flag
        $70:0159: Brinstar map collected flag
        $70:015A: Norfair map collected flag
        $70:015B: Wrecked Ship map collected flag
        $70:015C: Maridia map collected flag
        $70:015D: Tourian map collected flag
        $70:015E: Ceres map collected flag
        $70:015F: Debug map collected flag
    }
    $70:0160..63: Unused
    $70:0164: Loading game state
    {
        0: Intro
        5: Main
        1Fh: Starting at Ceres
        22h: Escaping Ceres / landing on Zebes
    }
    $70:0166: SRAM save station index
    $70:0168: SRAM area index
    {
        0: Crateria
        1: Brinstar
        2: Norfair
        3: Wrecked Ship
        4: Maridia
        5: Tourian
        6: Ceres
        7: Debug
    }
    $70:016A: Global number of items loaded counter
    $70:016C..066B: Exported map data. Bytes 147h..4FFh are unused. See $81:8131
    {
        $70:016C..B5: Crateria
        $70:01B6..FD: Brinstar
        $70:01FE..0249: Norfair
        $70:024A..5B: Wrecked Ship
        $70:025C..9D: Maridia
        $70:029E..B2: Tourian
    }
}
$70:066C..0CC7: Slot 1. Copied from $7E:D7C0..DE1B
{
    $70:066C..CB: Samus data and game options. Copied from $09A2..0A01
    {
        $70:066C: Equipped items
        $70:066E: Collected items
        {
            1: Varia suit
            2: Spring ball
            4: Morph ball
            8: Screw attack
            20h: Gravity suit
            100h: Hi-jump boots
            200h: Space jump
            1000h: Bombs
            2000h: Speed booster
            4000h: Grapple
            8000h: X-Ray
        }
        $70:0670: Equipped beams
        $70:0672: Collected beams
        {
            1: Wave
            2: Ice
            4: Spazer
            8: Plasma
            1000h: Charge
        }
        $70:0674: Up binding. D-pad bindings are only used by x-ray
        {
            8000h: B
            4000h: Y
            2000h: Select
            1000h: Start
            800h: Up
            400h: Down
            200h: Left
            100h: Right
            80h: A
            40h: X
            20h: L
            10h: R
        }
        $70:0676: Down binding
        $70:0678: Left binding
        $70:067A: Right binding
        $70:067C: Shoot binding
        $70:067E: Jump binding
        $70:0680: Run binding
        $70:0682: Item cancel binding
        $70:0684: Item select binding
        $70:0686: Aim down binding
        $70:0688: Aim up binding
        $70:068A: Reserve health mode
        {
            0: Not obtained
            1: Auto
            2: Manual
        }
        $70:068C: Samus health
        $70:068E: Samus max health
        $70:0690: Samus missiles
        $70:0692: Samus max missiles
        $70:0694: Samus super missiles
        $70:0696: Samus max super missiles
        $70:0698: Samus power bombs
        $70:069A: Samus max power bombs
        $70:069C: HUD item index. HUD item index is set to 0 when loading Samus, so this SRAM value has no effect
        {
            0: Nothing
            1: Missiles
            2: Super missiles
            3: Power bombs
            4: Grapple beam
            5: X-ray
        }
        $70:069E: Samus max reserve health
        $70:06A0: Samus reserve health
        $70:06A2: Samus reserve missiles. Only used by missile pickup routine ($91:DF80)
        $70:06A4: Game time, frames
        $70:06A6: Game time, seconds
        $70:06A8: Game time, minutes
        $70:06AA: Game time, hours (capped at 99:59:59.59)
        $70:06AC: Japanese text flag
        $70:06AE: Moonwalk flag
        $70:06B0: Debug. Disable Samus placement mode flag. 0: Allows positioning Samus in demo recorder. Set to 1
        $70:06B2: Unused. Set to 1
        $70:06B4: Icon cancel flag (cancel HUD item on door transition)
        $70:06B6..CB: Unused
    }
    $70:06CC..D3: Event bit array. Bytes 3..7 are unused
    {
        $70:06CC:
        {
            1:   Event 0 - Zebes is awake
            2:   Event 1 - Shitroid ate sidehopper
            4:   Event 2 - Mother Brain's glass is broken
            8:   Event 3 - zebetite destroyed bit 0 (true if 1 or 3 zebetites are destroyed)
            10h: Event 4 - zebetite destroyed bit 1 (true if 2 or 3 zebetites are destroyed)
            20h: Event 5 - zebetite destroyed bit 2 (true if all 4 zebetites are destroyed)
            40h: Event 6 - Phantoon statue is grey
            80h: Event 7 - Ridley statue is grey
        }
        $70:06CD:
        {
            1:   Event 8  - Draygon statue is grey
            2:   Event 9  - Kraid statue is grey
            4:   Event Ah - entrance to Tourian is unlocked
            8:   Event Bh - Maridia noobtube is broken
            10h: Event Ch - Lower Norfair chozo has lowered the acid
            20h: Event Dh - Shaktool cleared a path
            40h: Event Eh - Zebes timebomb set
            80h: Event Fh - critters escaped
        }
        $70:06CE:
        {
            1:   Event 10h - 1st metroid hall cleared
            2:   Event 11h - 1st metroid shaft cleared
            4:   Event 12h - 2nd metroid hall cleared
            8:   Event 13h - 2nd metroid shaft cleared
            10h: Event 14h - unused
            20h: Event 15h - outran speed booster lavaquake
        }
    }
    $70:06D4..DB: Boss bits
    {
        $70:06D4: Crateria boss bits
        {
            4: Bomb Torizo
        }
        $70:06D5: Brinstar boss bits
        {
            1: Kraid
            2: Spore Spawn
        }
        $70:06D6: Norfair boss bits
        {
            1: Ridley
            2: Crocomire
            4: Golden Torizo
        }
        $70:06D7: Wrecked Ship boss bits
        {
            1: Phantoon
        }
        $70:06D8: Maridia boss bits
        {
            1: Draygon
            2: Botwoon
        }
        $70:06D9: Tourian boss bits
        {
            2: Mother Brain
        }
        $70:06DA: Ceres boss bits
        {
            1: Ceres Ridley
        }
        $70:06DB: Debug boss bits
    }
    $70:06DC..071B: Unused. Chozo block destroyed bit array. Used by unused chozo block PLMs $D700/D708. Cleared on new save file
    $70:071C..5B: Item collected bit array. Bytes 14h..3Fh are unused. See "Item PLMs.asm"
    {
        $00      $01      $02      $03      $04      $05      $06      $07      $08      $09      $0A       $10      $11      $12      $13
        01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567  01234567 01234567 01234567 01234567
        CCCCCCCC CCCCCBBB BBBB BBB BBBBBBBB  BBBBBBB BBBBB    BNNNNNNN NNNNNNNN NNNNN NN  NNNNNNN N         WWWWWWWW MMMMMMMM MMMMMMMM M M      ; Area (Crateria / Brinstar / Norfair / Wrecked Ship / Maridia)
        PMMMMEMI EMMSMPSM SRMM MMB PMIPMEES  EMEMMIP PMBEM    IMBMEIMM EPMMIRMM MMIMB MS  MMPPMEI E         MRMMESSI MSEMSMMB MRMPMSIM E I      ; Item (Energy / Reserve / Missile / Super / Power bomb / Item / Beam)
    }
    $70:075C..9B: Opened door bit array. Bytes 16h..3Fh are unused. See "Door PLMs.asm"
    {
        $00      $01      $02      $03      $04      $05      $06      $07      $08      $09      $0A      $0B      $0C       $10      $11      $12      $13      $14      $15
        01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567  01234567 01234567 01234567 01234567 01234567 01234567
        CCCCCCCC CCCCCCCC CCCCCCCC CCCCCCCB BBBBBBBB BBBBBBBB BBBBBBBB BBBBBBBB BBBBBBBB CNNNNNNN NNNNNNNN NNNNNNNN N         WWWWWWWW WWWWMMMM MMMMMMMM MMMMMMMM TTTTTTTT TTTTT    ; Area (Crateria / Brinstar / Norfair / Wrecked Ship / Maridia / Tourian)
        GYgggRgg ggggGYYY YggYgggg gggggRRR RRRRggRG YGRRggGg YgRGGGgg GYRGYGgG ggggGEgg gGRGYRGg gRRGGRRR YgggEgYG g         ggggGEgg gggRRRRG RgRgGGRg RGGEgggg gggggggR ERggg    ; Door (grey / Red / Green / Yellow / Eye)
    }
    $70:079C..A3: Unused. Cleared in new save file
    $70:07A4..B3: Used save stations and debug elevators
    {
        $70:07A4: Used Crateria save stations
        {
            1: Landing site
            2: Crateria save station
        }
        $70:07A5: Used Crateria debug elevators
        $70:07A6: Used Brinstar save stations
        {
            1: Spore Spawn save station
            2: Green Brinstar mainstreet save station
            4: Brinstar false floor save station
            8: Kraid save station
            10h: Red Brinstar save station
        }
        $70:07A7: Used Brinstar debug elevators
        $70:07A8: Used Norfair save stations
        {
            1: Post Crocomire save station
            2: Bubble Norfair save station
            4: Rock Norfair save station
            8: Pre Crocomire save station
            10h: Pre Lower Norfair save station
            20h: Lower Norfair save station
        }
        $70:07A9: Used Norfair debug elevators
        $70:07AA: Used Wrecked Ship save stations
        {
            1: Wrecked Ship save station
        }
        $70:07AB: Used Wrecked Ship debug elevators
        $70:07AC: Used Maridia save stations
        {
            1: n00b tube save station
            2: Forgotten highway save station
            4: Snail room save station
            8: Draygon save station
        }
        $70:07AD: Used Maridia debug elevators
        $70:07AE: Used Tourian save stations
        {
            1: Mother Brain save station
            2: Tourian entrance save station
        }
        $70:07AF: Used Tourian debug elevators
        $70:07B0: Used Ceres save stations
        $70:07B1: Used Ceres debug elevators
        $70:07B2: Used debug save stations
        $70:07B3: Used debug debug elevators
    }
    $70:07B4..BB: Map collected bit array
    {
        $70:07B4: Crateria map collected flag
        $70:07B5: Brinstar map collected flag
        $70:07B6: Norfair map collected flag
        $70:07B7: Wrecked Ship map collected flag
        $70:07B8: Maridia map collected flag
        $70:07B9: Tourian map collected flag
        $70:07BA: Ceres map collected flag
        $70:07BB: Debug map collected flag
    }
    $70:07BC..BF: Unused
    $70:07C0: Loading game state
    {
        0: Intro
        5: Main
        1Fh: Starting at Ceres
        22h: Escaping Ceres / landing on Zebes
    }
    $70:07C2: SRAM save station index
    $70:07C4: SRAM area index
    {
        0: Crateria
        1: Brinstar
        2: Norfair
        3: Wrecked Ship
        4: Maridia
        5: Tourian
        6: Ceres
        7: Debug
    }
    $70:07C6: Global number of items loaded counter
    $70:07C8..0CC7: Exported map data. Bytes 147h..4FFh are unused. See $81:8131
    {
        $70:07C8..0811: Crateria
        $70:0812..59: Brinstar
        $70:085A..A5: Norfair
        $70:08A6..B7: Wrecked Ship
        $70:08B8..F9: Maridia
        $70:08FA..090E: Tourian
    }
}
$70:0CC8..1323: Slot 2. Copied from $7E:D7C0..DE1B
{
    $70:0CC8..0D27: Samus data and game options. Copied from $09A2..0A01
    {
        $70:0CC8: Equipped items
        $70:0CCA: Collected items
        {
            1: Varia suit
            2: Spring ball
            4: Morph ball
            8: Screw attack
            20h: Gravity suit
            100h: Hi-jump boots
            200h: Space jump
            1000h: Bombs
            2000h: Speed booster
            4000h: Grapple
            8000h: X-Ray
        }
        $70:0CCC: Equipped beams
        $70:0CCE: Collected beams
        {
            1: Wave
            2: Ice
            4: Spazer
            8: Plasma
            1000h: Charge
        }
        $70:0CD0: Up binding. D-pad bindings are only used by x-ray
        {
            8000h: B
            4000h: Y
            2000h: Select
            1000h: Start
            800h: Up
            400h: Down
            200h: Left
            100h: Right
            80h: A
            40h: X
            20h: L
            10h: R
        }
        $70:0CD2: Down binding
        $70:0CD4: Left binding
        $70:0CD6: Right binding
        $70:0CD8: Shoot binding
        $70:0CDA: Jump binding
        $70:0CDC: Run binding
        $70:0CDE: Item cancel binding
        $70:0CE0: Item select binding
        $70:0CE2: Aim down binding
        $70:0CE4: Aim up binding
        $70:0CE6: Reserve health mode
        {
            0: Not obtained
            1: Auto
            2: Manual
        }
        $70:0CE8: Samus health
        $70:0CEA: Samus max health
        $70:0CEC: Samus missiles
        $70:0CEE: Samus max missiles
        $70:0CF0: Samus super missiles
        $70:0CF2: Samus max super missiles
        $70:0CF4: Samus power bombs
        $70:0CF6: Samus max power bombs
        $70:0CF8: HUD item index. HUD item index is set to 0 when loading Samus, so this SRAM value has no effect
        {
            0: Nothing
            1: Missiles
            2: Super missiles
            3: Power bombs
            4: Grapple beam
            5: X-ray
        }
        $70:0CFA: Samus max reserve health
        $70:0CFC: Samus reserve health
        $70:0CFE: Samus reserve missiles. Only used by missile pickup routine ($91:DF80)
        $70:0D00: Game time, frames
        $70:0D02: Game time, seconds
        $70:0D04: Game time, minutes
        $70:0D06: Game time, hours (capped at 99:59:59.59)
        $70:0D08: Japanese text flag
        $70:0D0A: Moonwalk flag
        $70:0D0C: Debug. Disable Samus placement mode flag. 0: Allows positioning Samus in demo recorder. Set to 1
        $70:0D0E: Unused. Set to 1
        $70:0D10: Icon cancel flag (cancel HUD item on door transition)
        $70:0D12..27: Unused
    }
    $70:0D28..2F: Event bit array. Bytes 3..7 are unused
    {
        $70:0D28:
        {
            1:   Event 0 - Zebes is awake
            2:   Event 1 - Shitroid ate sidehopper
            4:   Event 2 - Mother Brain's glass is broken
            8:   Event 3 - zebetite destroyed bit 0 (true if 1 or 3 zebetites are destroyed)
            10h: Event 4 - zebetite destroyed bit 1 (true if 2 or 3 zebetites are destroyed)
            20h: Event 5 - zebetite destroyed bit 2 (true if all 4 zebetites are destroyed)
            40h: Event 6 - Phantoon statue is grey
            80h: Event 7 - Ridley statue is grey
        }
        $70:0D29:
        {
            1:   Event 8  - Draygon statue is grey
            2:   Event 9  - Kraid statue is grey
            4:   Event Ah - entrance to Tourian is unlocked
            8:   Event Bh - Maridia noobtube is broken
            10h: Event Ch - Lower Norfair chozo has lowered the acid
            20h: Event Dh - Shaktool cleared a path
            40h: Event Eh - Zebes timebomb set
            80h: Event Fh - critters escaped
        }
        $70:0D2A:
        {
            1:   Event 10h - 1st metroid hall cleared
            2:   Event 11h - 1st metroid shaft cleared
            4:   Event 12h - 2nd metroid hall cleared
            8:   Event 13h - 2nd metroid shaft cleared
            10h: Event 14h - unused
            20h: Event 15h - outran speed booster lavaquake
        }
    }
    $70:0D30..37: Boss bits
    {
        $70:0D30: Crateria boss bits
        {
            4: Bomb Torizo
        }
        $70:0D31: Brinstar boss bits
        {
            1: Kraid
            2: Spore Spawn
        }
        $70:0D32: Norfair boss bits
        {
            1: Ridley
            2: Crocomire
            4: Golden Torizo
        }
        $70:0D33: Wrecked Ship boss bits
        {
            1: Phantoon
        }
        $70:0D34: Maridia boss bits
        {
            1: Draygon
            2: Botwoon
        }
        $70:0D35: Tourian boss bits
        {
            2: Mother Brain
        }
        $70:0D36: Ceres boss bits
        {
            1: Ceres Ridley
        }
        $70:0D37: Debug boss bits
    }
    $70:0D38..77: Unused. Chozo block destroyed bit array. Used by unused chozo block PLMs $D700/D708. Cleared on new save file
    $70:0D78..B7: Item collected bit array. Bytes 14h..3Fh are unused. See "Item PLMs.asm"
    {
        $00      $01      $02      $03      $04      $05      $06      $07      $08      $09      $0A       $10      $11      $12      $13
        01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567  01234567 01234567 01234567 01234567
        CCCCCCCC CCCCCBBB BBBB BBB BBBBBBBB  BBBBBBB BBBBB    BNNNNNNN NNNNNNNN NNNNN NN  NNNNNNN N         WWWWWWWW MMMMMMMM MMMMMMMM M M      ; Area (Crateria / Brinstar / Norfair / Wrecked Ship / Maridia)
        PMMMMEMI EMMSMPSM SRMM MMB PMIPMEES  EMEMMIP PMBEM    IMBMEIMM EPMMIRMM MMIMB MS  MMPPMEI E         MRMMESSI MSEMSMMB MRMPMSIM E I      ; Item (Energy / Reserve / Missile / Super / Power bomb / Item / Beam)
    }
    $70:0DB8..F7: Opened door bit array. Bytes 16h..3Fh are unused. See "Door PLMs.asm"
    {
        $00      $01      $02      $03      $04      $05      $06      $07      $08      $09      $0A      $0B      $0C       $10      $11      $12      $13      $14      $15
        01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567  01234567 01234567 01234567 01234567 01234567 01234567
        CCCCCCCC CCCCCCCC CCCCCCCC CCCCCCCB BBBBBBBB BBBBBBBB BBBBBBBB BBBBBBBB BBBBBBBB CNNNNNNN NNNNNNNN NNNNNNNN N         WWWWWWWW WWWWMMMM MMMMMMMM MMMMMMMM TTTTTTTT TTTTT    ; Area (Crateria / Brinstar / Norfair / Wrecked Ship / Maridia / Tourian)
        GYgggRgg ggggGYYY YggYgggg gggggRRR RRRRggRG YGRRggGg YgRGGGgg GYRGYGgG ggggGEgg gGRGYRGg gRRGGRRR YgggEgYG g         ggggGEgg gggRRRRG RgRgGGRg RGGEgggg gggggggR ERggg    ; Door (grey / Red / Green / Yellow / Eye)
    }
    $70:0DF8..FF: Unused. Cleared in new save file
    $70:0E00..0F: Used save stations and debug elevators
    {
        $70:0E00: Used Crateria save stations
        {
            1: Landing site
            2: Crateria save station
        }
        $70:0E01: Used Crateria debug elevators
        $70:0E02: Used Brinstar save stations
        {
            1: Spore Spawn save station
            2: Green Brinstar mainstreet save station
            4: Brinstar false floor save station
            8: Kraid save station
            10h: Red Brinstar save station
        }
        $70:0E03: Used Brinstar debug elevators
        $70:0E04: Used Norfair save stations
        {
            1: Post Crocomire save station
            2: Bubble Norfair save station
            4: Rock Norfair save station
            8: Pre Crocomire save station
            10h: Pre Lower Norfair save station
            20h: Lower Norfair save station
        }
        $70:0E05: Used Norfair debug elevators
        $70:0E06: Used Wrecked Ship save stations
        {
            1: Wrecked Ship save station
        }
        $70:0E07: Used Wrecked Ship debug elevators
        $70:0E08: Used Maridia save stations
        {
            1: n00b tube save station
            2: Forgotten highway save station
            4: Snail room save station
            8: Draygon save station
        }
        $70:0E09: Used Maridia debug elevators
        $70:0E0A: Used Tourian save stations
        {
            1: Mother Brain save station
            2: Tourian entrance save station
        }
        $70:0E0B: Used Tourian debug elevators
        $70:0E0C: Used Ceres save stations
        $70:0E0D: Used Ceres debug elevators
        $70:0E0E: Used debug save stations
        $70:0E0F: Used debug debug elevators
    }
    $70:0E10..17: Map collected bit array
    {
        $70:0E10: Crateria map collected flag
        $70:0E11: Brinstar map collected flag
        $70:0E12: Norfair map collected flag
        $70:0E13: Wrecked Ship map collected flag
        $70:0E14: Maridia map collected flag
        $70:0E15: Tourian map collected flag
        $70:0E16: Ceres map collected flag
        $70:0E17: Debug map collected flag
    }
    $70:0E18..1B: Unused
    $70:0E1C: Loading game state
    {
        0: Intro
        5: Main
        1Fh: Starting at Ceres
        22h: Escaping Ceres / landing on Zebes
    }
    $70:0E1E: SRAM save station index
    $70:0E20: SRAM area index
    {
        0: Crateria
        1: Brinstar
        2: Norfair
        3: Wrecked Ship
        4: Maridia
        5: Tourian
        6: Ceres
        7: Debug
    }
    $70:0E22: Global number of items loaded counter
    $70:0E24..1323: Exported map data. Bytes 147h..4FFh are unused. See $81:8131
    {
        $70:0E24..6D: Crateria
        $70:0E6E..B5: Brinstar
        $70:0EB6..0F01: Norfair
        $70:0F02..13: Wrecked Ship
        $70:0F14..55: Maridia
        $70:0F56..6A: Tourian
    }
}

$70:1324..1FDF: Unused
$70:1FE0..EB: Game completion flag (ASCII). "supermetroid" if completed, "madadameyohn" otherwise
$70:1FEC: Save slot selected. Range 0..2
$70:1FEE: Save slot selected complement
$70:1FF0: Slot 0 checksum
$70:1FF2: Slot 1 checksum
$70:1FF4: Slot 2 checksum
$70:1FF6: Unused
$70:1FF8: Slot 0 checksum complement
$70:1FFA: Slot 1 checksum complement
$70:1FFC: Slot 2 checksum complement
$70:1FFE: Unused
