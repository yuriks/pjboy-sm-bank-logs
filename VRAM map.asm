VRAM (in word addressing)

Gameplay
{
    $0000..3FFF: BG1/2 tiles (4-bit) / mode 7 graphics
    {
        $0000..27FF: Room tiles. Only $0000..23FF used by non-Kraid tilesets
        {
            $00E0..EF: Animated tiles - Wrecked Ship treadmill

            $0410..7F: Animated tiles - Brinstar mouth

            $0840..5F: Animated tiles - Tourian statue - Kraid

            $0CA0..DF: Animated tiles - Tourian statue - Draygon

            $1000..1F: Animated tiles - Maridia sand ceiling
            $1020..27: Animated tiles - Maridia sand falling

            $19C0..FF: Animated tiles - Wrecked Ship screen

            $1B00..FF: Animated tiles - Crateria lake
        }
        $2800..3FFF: CRE tiles / extended room tiles
        {
            $3380..8F: Transparent tile
        
            $3880..BF: Animated tiles - vertical spikes

            $3D60..9F: Animated tiles - horizontal spikes

            $3E00..FF: Room item PLM tiles
            {
                $3E00..3F: Item PLM 0 - frame 0
                $3E40..7F: Item PLM 0 - frame 1
                $3E80..BF: Item PLM 1 - frame 0
                $3EC0..FF: Item PLM 1 - frame 1
                $3F00..3F: Item PLM 2 - frame 0
                $3F40..7F: Item PLM 2 - frame 1
                $3F80..BF: Item PLM 3 - frame 0
                $3FC0..FF: Item PLM 3 - frame 1
            }
        }
    }
    $4000..47FF: BG3 tiles. (2-bit). Standard BG3 tiles are $9A:B200..C1FF
    {
        $4000..4F: HUD digits. "1".."9", "0" (one tile per character)
        $4050..57: HUD '%'
        $4058..6F: First three tiles of HUD 'ENERGY'
        $4070..7F: Transparent tile (unknown use)
        $4078..7F: Blank tile (for HUD)

        $4180..87: Empty energy tank
        $4188..8F: Non-empty energy tank
        $4190..97: Last tile of HUD 'ENERGY'
        $4198..9F: Reserve auto icon arrow point
        $41A0..AF: HUD super missile icon
        $41B0..BF: HUD power bomb icon
        $41C0..CF: HUD grapple icon
        $41D0..DF: HUD x-ray icon
        $41E0..422F: Digits "1".."9", "0" (unknown use, outline / fill colours swapped compared to $4000..4F)
        $4230..37: Reserve auto icon arrow turn
        $4238..47: Reserve auto icon 'AUTO'
        $4248..67: HUD missile icon
        $4268..6F: Map save room
        $4270..77: Blank tile (for FX)

        $4280..A7: Animated tiles
        {
            $4280..97: Spores
            $4280..9F: Lava/acid
            $4280..A7: Rain
        }

        $4400..67: Fog

        $4480..457F: Water
        {
            $4480..FF: Surface (two rows of four tiles each)
            $4500..7F: Depths (two rows of four tiles each, repeated indefinitely)
        }
        $4580..97: Message box "press"
        $4598..A7: Message box "hold"
        $45A8..BF: Message box "utton"

        $45C8..DF: Message box "select"
        $45E0..EF: Message box "run"
        $45F0..FF: Message box "with"
        $4600..0F: Message box " the"
        $4610..17: Message box "to"
        $4618..27: Message box "for"
        $4628..37: Message box "set"
        $4638..3F: Message box "it"
        $4640..47: Message box "&"
        $4648..4F: Message box morph ball icon

        $4658..5F: Message box "."
        $4660..6F: Message box option select arrow

        $4678..7F: Message box "-"

        $4688..8F: Message box " " (end of "the ", contains a fragment of the "e")

        $4698..9F: Message box "b" (for "button")

        $46E0..FF: Samus (for the bombs acquired message box)
        $4700..FF: Message box characters. "A".."Z", ".,`'?!" (one tile per character). Used for save dialog and controller buttons
    }
    $4800..4FFF: BG2 tilemap
    $5000..57FF: BG1 tilemap
    $5800..5FFF: BG3 tilemap
    {
        $5800..587F: HUD (4 rows, first row is blank tiles)
        $5880..5BDF: FX padding (1Bh rows of transparent tiles)
        {
            $5880..5B9F: Region displayed on screen (under normal circumstance)
            $5BA0..BF: Never displayed
            $5BC0..DF: Displayed above lava/acid tilemap (for some reason)
        }
        $5BE0..5FFF: FX (21h rows)
        {
            $5C00: Liquid hitbox starts here
        }
    }
    $6000..7FFF: Sprite tiles (4-bit). Used for BG1/2 tiles in Ceres Ridley's room. Standard sprite tiles are $9A:D200..F1FF, initially loaded to $6000..6FFF, of which only $6200..6CFF is non "X" tiles
    {
        $6000..61FF: Samus graphics
        {
            $6000..7F: Samus top 1 graphics
            $6080..FF: Samus bottom 1 graphics
            $6100..7F: Samus top 2 graphics
            $6180..FF: Samus bottom 2 graphics
            {
                $61F0..FF: Arm cannon when not closed
            }
        }
        $6200..4F: Grapple beam
        {
            $6200..0F: Grapple beam end
            $6210..4F: Four grapple beam segments
        }
        $6200..0F: Used as black tiles for Ceres elevator platform for some reason
        $6210..1F: Left part of Samus' chest when facing forward in power suit (gets overwritten by grapple beam)
        
        $6250..5F: Samus air bubbles
        $6260..7F: Power bomb frames 1-2
        $6280..BF: Debris from screw attack explosion
        $62C0..FF: Water from Samus' footsteps
        $6300..7F: Beam
        $6380..BF: Beam trail
        $63C0..CF: Wave beam trail
        $63D0..EF: Small energy pickup Frames 1 and 4
        $63F0..FF: Wave beam trail
        $6400..0F: Air bubbles
        $640F..2F: Small energy pickup Frames 2-3
        $6430..3F: Air bubbles
        $6440..6F: Large energy pickup
        $6470..7F: Unused
        $6480..BF: Dust clouds from footsteps and Missile smoke trail
        $64C0..FF: Bomb sprites
        $6500..3F: Charge beam / grapple beam flare
        $6540..AF: Missile (2 horizontal, 3 diagonal, 2 vertical)
        $65B0..DF: Flare sparks (charge beam / hyper beam)
        $65E0..EF: Splash from water surface Frame 1
        $65F0..663F: Explosions, medium - small
        $6640..AF: Super missile (2 horizontal, 3 diagonal, 2 vertical)
        $66B0..BF: Save Station energy / space pirate beam projectile Left/Right End tile
        $66C0..EF: Elevator Sprites (Tile One x 4 = Frame 1, Tile Two/Three 2332 = Frame 2)
        $66F0..FF: Save Station energy / space pirate beam projectile Left/Right Middle tile
        $6700..6CFF: If not otherwise stated, explosions of various colors, shapes, and sizes (4 bit, pal 208)
        {
            $67B0..BF: Power bomb

            $6BA0..AF: Top half of Water burst from surface Frame 2

            $6BE0..FF: Top half of gate

            $6C70..7F: Air bubbles

            $6CA0..AF: Bottom half of Water burst from surface Frame 2

            $6CD0..DF: Save Station energy / space pirate beam Left/Right Joining tile

            $6CE0..FF: Bottom half of gate
        }
        $6B00..6FFF: Enemy debugger tiles
        $6D00..6FFF: Extra enemy tiles. Also used for BG2 tiles in Ceres Ridley's room
        {
            $6D00..6FFF: Used by enemies $DDBF (Crocomire), $E23F (Ceres door), $EC7F (Mother Brain's body) and $F03F (Tourian entrance statue ghost). Also used for mini-Draygon in Draygon fight
            $6E00..6FFF: Used by enemy $E1BF (Ridley's explosion), enemy projectile function $86:AA3D (torizo)
        }
        $7000..7FFF: Enemy and enemy projectile tiles
        {
            $7220..3F: Animated tiles - Tourian statue - Ridley

            $7800..3F: Animated tiles - Tourian statue - Phantoon
        }
    }
}

Kraid
{
    $0000..3FFF: BG1/2 tiles
    {
        $2000..27FF: BG3 tiles
        
        $3E00..3FFF: BG1/2 tiles that need reloading after pause screen
        {
            $3F00..3FFF: Room background
        }
    }
    $4000..4FFF: BG2 tilemap
    $5000..57FF: BG1 tilemap
    $5800..5FFF: BG3 tilemap
    $6000..7FFF: Sprite tiles
}

Pause screen
{
    $0000..1FFF: BG1/2 tiles
    $2000..2FFF: Sprite tiles
    $3000..37FF: BG1 tilemap (map data, equipment screen)
    $3800..3BFF: BG2 tilemap (map screen background + frame, buttons)
    $4000..47FF: BG3 tiles. Standard BG3 tiles ($9A:B200..C1FF)
    $4800..4FFF: Cleared and then unused! Gameplay BG2 tilemap is backed up to $7E:DF5C..EF5B
    $5800..5BFF: BG3 tilemap (HUD)
    $5C00..7FFF: Unused (preserved for gameplay)
}

Menu
{
    $0000..3FFF: BG1/2 tiles
    {
        $0000..2AFF: Menu tiles
    
        $3000..3FFF: Pause screen tiles
    }
    $4000..42FF: BG3 tiles (beta minimap tiles)
    
    $5000..57FF: BG1 tilemap
    $5800..5BFF: BG2 tilemap
    $5C00..5FFF: BG3 tilemap
    $6000..6FFF: Sprite tiles
}

Nintendo logo
{
    $6000..7FFF: Sprite tiles
}

Anti-piracy screens
{
    $0000..1FFF: BG1 tiles
    
    $4000..47FF: BG1 tilemap
}

Title sequence
{
    $0000..3FFF: Mode 7 BG
    {
        $3800..FF: Baby metroid
    }
    
    $6000..7FFF: Sprite tiles
}

Intro
{
    $0000..3FFF: BG1/2 tiles
    $4000..447F: BG3 tiles (font 1)
    {
        $4180..447F: Japanese text (font 2)
    }
    $4800..4BFF: BG2 tilemap (Samus head)
    $4C00..4FFF: BG3 tilemap (text)
    $5000..5FFF: BG1 tilemaps
    {
        $5000..53FF: Old Mother Brain's room
        $5400..57FF: Baby metroid discovery
        $5800..5BFF: Baby metroid being delivered
        $5C00..5FFF: Baby metroid being examined
    }
    $6000..7FFF: Sprite tiles
    {
        $6000..6DFF: Standard sprite tiles
        $6E00..7FFF: Intro sprite tiles
    }
}

Ceres / Samus goes to Zebes cutscene
{
    $0000..3FFF: Mode 7 BG (gunship)
    
    $5C00..5FFF: BG1 tilemap (space colony text, Zebes during mosaic effect)
    $6000..7FFF: BG1/sprite tiles
}

Zebes destruction cutscene
{
    $0000..3FFF: Mode 7 BG (Zebes / grey clouds)
    $4000..5FFF: BG1/2 tiles
    
    $6000..7FFF: Sprite tiles (yellow clouds)
    
    $7000..77FF: BG1 tilemaps
    {
        $7000..73FF: Wide part of Zebes explosion
        $7400..77FF: Concentric wide part of Zebes explosion
    }
    $7800..7FFF: BG2 tilemaps
    {
        $7800..7BFF: Eclipse of Zebes during explosion
        $7C00..7FFF: Blank
    }
}

Credits
{
    $0000..1FFF: Sprite tiles (post-credits ending Samus)
    $2000..207F: BG3 tiles
    $2400..27FF: BG3 tilemap (post-credits Samus transformation effect)
    $4000..47FF: BG1 tiles (font 3)
    $4800..4BFF: BG1 tilemap (text)
    $4C00..4FFF: BG2 tilemap (post-credits suited Samus)
    $5000..5FFF: BG2 tiles
}

Samus shooting the screen / Super Metroid icon
{
    $0000..3FFF: Mode 7 BG (post-credits Samus beam)
    $4000..47FF: BG1 tiles
    {
        $4000..47FF: Font 3
        $4800..49FF: Item percentage Japanese text
    }
    
    $5400..57FF: BG2 tilemap. Super Metroid icon tilemap
    
    $6000..7FFF: BG2/sprite tiles (post-credits Samus shooting the screen, Super Metroid icon)
}
