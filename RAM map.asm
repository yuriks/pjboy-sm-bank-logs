.*(\[\$....\]|RT[LS]|JM[LP]).*

$00..50: Miscellaneous temporary variables
{
    $0E: Unused (one byte)

    $11: Unused (one byte)

    $36: Long address of blocks to update in $80:A9DE/AB78
    $39..3B: Unused
    $3C: Samus tiles definition in $80:9376 (copy of $071F/$0721)
    $3E..43: Unused
    $44: Pointer to return address relative parameter in $80:B0FF
    $47: Decompression source parameter for $80:B0FF/B119/B271
    $4A: Decompression variable (size/command byte, word fill value, dictionary copy source address) in $80:B119/B271
    $4C: Decompression destination parameter for $80:B119/B271
    $4F: Decompression dictionary copy inversion bit in $80:B119/B271
}
$51..86: Regular IO registers (according to $81:8D0F)
{
    $51: Forced blank and screen brightness ($2100). Updated during NMI
    {
        v = f000bbbb
        If b = 0:
            Brightness = 0
        Else:
            Brightness = (b + 1) / 10h
        f: Forced blank
    }
    $52: Sprite size and sprite tiles base address ($2101). Updated during NMI
    {
        v = sssggbbb
        Base address for sprite tiles 0..FFh = b * 2000h
        Base address for sprite tiles 100..1FFh = b * 2000h + (g + 1) * 1000h
        s: Sprite sizes
                Small  Large
             0: 8x8,   16x16
             1: 8x8,   32x32
             2: 8x8,   64x64
             3: 16x16, 32x32
             4: 16x16, 64x64
             5: 32x32, 64x64
    }
    $53: OAM address and OAM priority rotation ($2102). Updated during NMI
    {
        To set the OAM priority rotation:
            Write 80h to $54
            Write the highest priority OAM index (0..7Fh) << 1 to $53
        To set the OAM address:
            Write the (word) address ($00..$01FF) to $53
    }
    $55: Mode and BG tile size ($2105). Updated during NMI
    {
        v = dcbapmmm
        mmm: Mode (0..7)
        p: BG3 priority in mode 1
        a: BG1 tile size. 0: 8x8, 1: 16x16
        b: BG2 tile size. 0: 8x8, 1: 16x16
        c: BG3 tile size. 0: 8x8, 1: 16x16
        d: BG4 tile size. 0: 8x8, 1: 16x16
    }
    $56: Fake mode and BG tile size. Checked by $80:91EE to update mode 7 registers and during NMI to process mode 7 transfers. Value for $07EC. Updated during NMI. Written to by Ceres elevator shaft door ASM and Ceres Ridley
    $57: Mosaic size and enable ($2106). Updated during NMI
    {
        v = ssssdcba
        a: BG1 enable
        b: BG2 enable
        c: BG3 enable
        d: BG4 enable
        s: Block size = (s+1)x(s+1)
    }
    $58: BG1 tilemap base address and size ($2107). Updated during NMI
    $59: BG2 tilemap base address and size ($2108). Updated during NMI
    $5A: BG3 tilemap base address and size ($2109). Updated during NMI
    $5B: Gameplay BG3 tilemap base address and size ($2109). Updated during IRQ 6/Eh (gameplay, status bar drawn)
    $5C: BG4 tilemap base address and size ($210A). Updated during NMI
    {
        v = bbbbbbss
        s: BG tilemap size
            0: 32x32
            1: 64x32
            2: 32x64
            3: 64x64
        BG tilemap base address = b * 400h = v * 100h & FC00h
    }
    $5D: BG tiles base address ($210B). Updated during NMI
    {
        v = ddddccccbbbbaaaa
        BG1 tiles base address = a * 1000h
        BG2 tiles base address = b * 1000h
        BG3 tiles base address = c * 1000h
        BG4 tiles base address = d * 1000h
    }
    $5F: Mode 7 settings ($211A). Updated during NMI
    {
        v = oo0000yx
        x: Screen X flip
        y: Screen Y flip
        o: BG map overflow
            0/1: Wrap within 128x128 tile area
            2: Overflowing tiles are transparent
            3: Overflowing tiles are tile 0
    }
    $60: Window BG1/BG2 mask settings ($2123). Updated during NMI
    {
        v = ddccbbaa
        a: BG1 window 1 mask
        b: BG1 window 2 mask
        c: BG2 window 1 mask
        d: BG2 window 2 mask
        a/b/c/d:
            0/1: Disable mask
            2: Enable inclusive mask
            3: Enable exclusive mask
    }
    $61: Window BG3/BG4 mask settings ($2124). Updated during NMI
    {
        v = ddccbbaa
        a: BG3 window 1 mask
        b: BG3 window 2 mask
        c: BG4 window 1 mask
        d: BG4 window 2 mask
        a/b/c/d:
            0/1: Disable mask
            2: Enable inclusive mask
            3: Enable exclusive mask
    }
    $62: Window sprites/math mask settings ($2125). Updated during NMI
    {
        v = ddccbbaa
        a: Sprite window 1 mask
        b: Sprite window 2 mask
        c: Colour math window 1 mask
        d: Colour math window 2 mask
        a/b/c/d:
            0/1: Disable mask
            2: Enable inclusive mask
            3: Enable exclusive mask
    }
    $63: Window 1 left position ($2126). Updated during NMI
    $64: Window 1 right position ($2127). Updated during NMI
    $65: Window 2 left position ($2128). Updated during NMI
    $66: Window 2 right position ($2129). Updated during NMI
    $67: Window 1/2 BG mask logic ($212A). Updated during NMI
    {
        v = ddccbbaa
        a: Window 1/2 BG1 mask logic
        b: Window 1/2 BG2 mask logic
        c: Window 1/2 BG3 mask logic
        d: Window 1/2 BG4 mask logic
        a/b/c/d:
            0: OR (mask is enabled anywhere window 1 or 2 or both is)
            1: AND (mask is enabled only where both window 1 and 2 are)
            2: XOR (mask is enabled only where either window 1 or 2 is, but not both)
            3: XNOR (mask is enabled where both or neither of window 1 and 2 are)
    }
    $68: Window 1/2 sprites/colour math mask logic ($212B). Updated during NMI
    {
        v = 0000bbaa
        a: Window 1/2 sprites mask logic
        b: Window 1/2 colour math mask logic
        a/b:
            0: OR (mask is enabled anywhere window 1 or 2 or both is)
            1: AND (mask is enabled only where both window 1 and 2 are)
            2: XOR (mask is enabled only where either window 1 or 2 is, but not both)
            3: XNOR (mask is enabled where both or neither of window 1 and 2 are)
    }
    $69: Main screen layers ($212C and $6A). Updated during NMI
    $6A: Gameplay main screen layers ($212C). Updated during IRQ 6 (main gameplay, status bar drawn). Used exclusively by message boxes (which short-circuit the NMI handler)
    $6B: Subscreen layers ($212D). Updated during NMI
    {
        v = 000edcba
        a: Enable BG1
        b: Enable BG2
        c: Enable BG3
        d: Enable BG4
        e: Enable sprites
    }
    $6C: Window area main screen disable ($212E). Updated during NMI
    $6D: Window area subscreen disable ($212F). Updated during NMI
    {
        v = 000edcba
        a: Disable BG1 in window area
        b: Disable BG2 in window area
        c: Disable BG3 in window area
        d: Disable BG4 in window area
        e: Disable sprites in window area
    }
    $6E: Next gameplay colour math control register A ($70). Updated during NMI
    $6F: Colour math control register A ($2130). Updated during NMI
    $70: Gameplay colour math control register A ($2130). Updated during IRQ 6/Eh (gameplay, status bar drawn)
    {
        v = ffcc00sd
        d: Direct colour for 8bpp backgrounds
        s: Enable subscreen layers (0 is backdrop only, 1 is BG + sprites too)
        c: Colour math mask logic
            0: Enable colour math everywhere
            1: Restrict colour math to inside window
            2: Restrict colour math to outside window
            3: Disable colour math
        f: Force main screen black
            0: Disabled
            1: Force main screen black outside window
            2: Force main screen black inside window
            3: Force main screen black everywhere
    }
    $71: Next gameplay colour math control register B ($73). Updated during NMI
    $72: Colour math control register B ($2131). Updated during NMI
    $73: Gameplay colour math control register B ($2131). Updated during IRQ 6/Eh (gameplay, status bar drawn)
    {
        v = ohfedcba
        a: Enable colour math on BG1
        b: Enable colour math on BG2
        c: Enable colour math on BG3
        d: Enable colour math on BG4
        e: Enable colour math on sprite palettes 4..7
        f: Enable colour math on backdrop
        h: Halve result (if not forced black)
        o:
            0: Add subscreen to main screen
            1: Subtract subscreen from main screen
    }
    $74: Colour math subscreen backdrop colour 0 ($2132). Updated during NMI
    $75: Colour math subscreen backdrop colour 1 ($2132). Updated during NMI
    $76: Colour math subscreen backdrop colour 2 ($2132). Updated during NMI
    {
        v = bgriiiii
        i: Intensity (0..1Fh)
        r: Apply intensity as red (otherwise, no change)
        g: Apply intensity as green (otherwise, no change)
        b: Apply intensity as blue (otherwise, no change)
    }
    $77: Display resolution ($2133). Updated during NMI. Always 0
    {
        v = ex00gbsi
        i: Interlacing
        s: High Y resolution sprites
        b: PAL Y resolution (0: 224, 1: 239)
        g: Pseudo high X resolution mode
        x: External background mode
        e: External synchronisation
    }
    $78: Mode 7 transformation matrix parameter A. 1/100h pixels ($211B). Updated during NMI
    $7A: Mode 7 transformation matrix parameter B. 1/100h pixels ($211C). Updated during NMI
    $7C: Mode 7 transformation matrix parameter C. 1/100h pixels ($211D). Updated during NMI
    $7E: Mode 7 transformation matrix parameter D. 1/100h pixels ($211E). Updated during NMI
    $80: Mode 7 transformation origin co-ordinate X ($211F). Updated during NMI
    $82: Mode 7 transformation origin co-ordinate Y ($2120). Updated during NMI
    $84: Interrupt and auto-joypad enable ($4200). Updated during NMI
    {
        v = n0ii000j
        n: Enable NMI
        i: IRQ mode
            0: Disable IRQ
            1: Enable h-count IRQ
            2: Enable v-count IRQ
            3: Enable v-count/h-count IRQ
        j: Enable auto-joypad read
    }
    $85: HDMA channels to enable ($420C). Updated during NMI
    $86: ROM access speed ($420D). Never read
}
$87: Auto-press initial delay. Never written
$89: Auto-press subsequent delay. Never written
$8B: Controller 1 input ($4218)
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
$8D: Debug. Controller 2 input ($421A)
$8F: Newly pressed controller 1 input
$91: Debug. Newly pressed controller 2 input
$93: Fake newly pressed controller 1 input. Never read. Overwritten by controller 1 input if held initially for [$87] frames, then subsequently every [$89] frames
$95: Debug. Fake newly pressed controller 2 input. Never read. Overwritten by controller 2 input if held initially for [$87] frames, then subsequently every [$89] frames
$97: Previous controller 1 input (during controller input processing)
$99: Debug. Previous controller 2 input (during controller input processing)
$9B..A2: Unused
$A3: Controller 1 auto-press timer
$A5: Debug. Controller 2 auto-press timer
$A7: Next interrupt command (after screen is drawn)
$A9: Room loading interrupt command
$AB: Interrupt command
{
    0: Nothing
    2: Disable h/v-counter interrupts
    4: Main gameplay - begin HUD drawing
    6: Main gameplay - end HUD drawing
    8: Start of door transition - begin HUD drawing
    Ah: Start of door transition - end HUD drawing
    Ch: Draygon's room - begin HUD drawing
    Eh: Draygon's room - end HUD drawing
    10h: Vertical door transition - begin HUD drawing
    12h: Vertical door transition - end HUD drawing
    14h: Vertical door transition - end drawing
    16h: Horizontal door transition - begin HUD drawing
    18h: Horizontal door transition - end HUD drawing
    1Ah: Horizontal door transition - end drawing
}
$AD: Pointer to return address relative parameters in $82:E039
$AF: Current region FX palette FX / animated tiles object table in $89:AB82
$B1: BG1 X scroll ($210D). Updated during NMI. Origin X position in the BG1 layer to draw to screen. Positive direction pans camera rightwards over BG1, or equivalently moves BG1 leftwards on the camera
$B3: BG1 Y scroll ($210E). Updated during NMI. Origin Y position in the BG1 layer to draw to screen. Positive direction pans camera downwards over BG1, or equivalently moves BG1 upwards on the camera
$B5: BG2 X scroll ($210F). Updated during NMI
$B7: BG2 Y scroll ($2110). Updated during NMI
$B9: BG3 X scroll ($2111). Updated during NMI
$BB: BG3 Y scroll ($2112). Updated during NMI
$BD: BG4 X scroll ($2113). Updated during NMI. Pretty pointless, BG4 is never used. Used as backup of BG1 X scroll during equipment screen (strangely...)
$BF: BG4 Y scroll ($2114). Updated during NMI. Pretty pointless, BG4 is never used. Used as backup of BG1 Y scroll during equipment screen (strangely...)
$C1..CF: Unused
$D0..02CF: VRAM write table. 7 byte entries. 2 byte zero-terminator. Table size >= 1FCh bytes = 49h entries according to PLM drawing ($84:8DAA) routine
{
    + 0: Size
    + 2: Source address
    + 5: Destination address. If [destination address] & 8000h: DMA transfer uses 32-byte increment mode (for writing a column in a tilemap)
}
$02D0..032F: Mode 7 transfers. 7 or 9 byte entries. 1 byte zero-terminator. No enforced upper limit (even in mode 7 object handling)
{
    + 0: Control
        DMA control = [control] & 1Fh (transfer unit selection and address increment direction)
        DMA target = [control] & C0h:
            40h: CGRAM data write
            80h: VRAM data write low (tilemap)
            C0h: VRAM data write high (tiles)
    + 1: Source address
    + 4: Size
    + 6: Destination address (1 byte for CGRAM transfers, 2 bytes for VRAM transfers)
    + 8: VRAM address increment mode (for VRAM transfers only). 0 for tilemap, 2 for tilemap column, 80h for tiles
}
$0330: VRAM write table stack pointer
$0332: Unused
$0334: Mode 7 transfers stack pointer
$0336..3F: Unused
$0340..5C: VRAM read table. 9 byte entries. 2 byte zero-terminator. No enforced upper limit, but only enough space for 3 entries (only 1 ever used in practice). Used by Kraid pausing code ($A7:C325) and x-ray ($91:CB1C/CB57/CB8E/D0D3)
{
    + 0: Source address
    + 2: DMA control (usually 81h)
    + 3: DMA target (usually 39h)
    + 4: Destination address
    + 7: Size
}

$0360: VRAM read table stack pointer
$0362..6F: Unused
$0370..058F: OAM (updated during NMI by $80:933A). 80h entries
{
    $0370..056F: Low OAM. 4 byte entries
    {
        v = xxxxxxxx yyyyyyyy YXPPpppttttttttt
        x: X position (lower 8 bits)
        y: Y position
        t: Tile number
        p: Palette
        P: Priority
        X: X flip
        Y: Y flip
    }
    $0570..8F: High OAM. 2 bit entries
    {
        ddccbbsx
        x: X position (upper 1 bit)
        s: Size
        b: sx for sprite 4n+1
        c: sx for sprite 4n+2
        d: sx for sprite 4n+3
    }
}
$0590: OAM stack pointer
$0592: Power bomb explosion status
{
    4000h: Power bomb explosion is pending (due to Samus dying(?) or auto reserve tanks being active)
    8000h: Power bomb is exploding or first part of crystal flash
}
$0594: Unused
$0596: BG3 X scroll HDMA data table size for unused FX type 22h in $88:A673
$0598: Y position on screen in $88:A81C
$059A: Set to E0h by scrolling sky and never read. (Unused) expanding and contracting effect HDMA table update counter, table is updated in 4 parts and this tracks which part is next
$059C: Set to 0 by scrolling sky, otherwise unused
$059E: HUD BG2 X position during scrolling sky (never written to / always zero)
$05A0: Contracting flag. Used by an unused expanding and contracting HDMA effect ($88:B17F)
{
    0: Expanding
    1: Contracting
}

$05A2..AB: Message box animation variables
{
    $05A2: Message box animation Y radius (in units of 1/100h px)
    $05A4: Message box animation variable - bottom half. At line y: $05A4 = y + [message box animation Y radius] / 100h
    $05A6: Message box animation variable - bottom half. At line y: $05A6 = y + 18h
    $05A8: Message box animation variable - top half. At line y: $05A8 = y - [message box animation Y radius] / 100h
    $05AA: Message box animation variable - top half. At line y: $05AA = y - 18h
}
$05A2..AB: (Unused) expanding and contracting effect variables. See $88:B17F
{
    $05A2: Expansion factor. Scale factor = 1 + [expansion factor] / 8000h
    $05A4: HDMA table update destination top base position
    $05A6: HDMA table update source top base position
    $05A8: HDMA table update destination bottom base position
    $05AA: HDMA table update source bottom base position
}

$05A6: Adjusted source Y offset during Crocomire melting. [$0694] + y

$05AC: Map min X scroll
$05AE: Map max X scroll
$05B0: Map min Y scroll
$05B2: Map max Y scroll
$05B4: NMI request flag
$05B5: 8-bit frame counter. Does not include lag frames. Set to 0 during door transitions by a (likely erroneous) 16-bit write to $05B4. Not sure why this exists...
$05B6: Frame counter. Does not include lag frames
$05B8: NMI counter. Includes lag frames (used exclusively by message boxes)
$05BA: Lag counter
$05BB: Maximum lag. Capped at FFh, which happens very quickly if a message box appears. Only useful for measuring the load time of the title sequence (which is 26h frames, or up to 28h frames if returning from the file select screen, guessing audio sync/flush).
$05BC: Door transition VRAM update flag
$05BE: Door transition VRAM update destination
$05C0: Door transition VRAM update source
$05C3: Door transition VRAM update size
$05C5: Debug. Debug input L. Newly pressed controller 1 input when select + L is pressed. Clears $05C7 if non-zero (L has priority over R)
$05C7: Debug. Debug input R. Newly pressed controller 1 input when select + R is pressed
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
$05C9: Debug. Missiles swap
$05CB: Debug. Super missiles swap
$05CD: Debug. Power bombs swap
$05CF: Debug. Debug options
{
    v & 1F40h != 0: draw 3 digits of super missiles. There is no code that sets this
    2000h: Toggled when X is pressed whilst select + R is held ($80:9459). There is no code that checks this
    4000h: Debug controller input processing is disabled ($80:9459). There is no code that sets this
    8000h: Ammo is swapped (B is pressed whilst select + R is held) ($80:9459). Used to show morphed Samus' position in the demo recorder ($90:ED26) and in-game time in unused routine ($90:ED6C)
}
$05D1: Debug. Debug mode. Set to [$80:8004] during boot / soft reset
$05D3: Debug. Saved layer 1 position flag. Toggle with X on controller 2 if $80:8006 is set
$05D5: Debug. Saved layer 1 X position
$05D7: Debug. Saved layer 1 Y position
$05D9: Previous held input
$05DB: Timed held input timer
$05DD: Timed held input timer reset value. Set to 3 (meaning "timed held input" is input held for 4+ frames)
$05DF: Timed held input
$05E1: Newly held down timed held input. This variable is the useful one (used by pause menu). The rest of $05D9..E4 is all helper variables exclusively used in the update routine
$05E3: Previous timed held input
$05E5: Random number. Seeded with 61h during boot / soft reset. Generated by $80:8111. Reseeded by a few enemies
$05E7: Bitmask. In particular, the bitmask result of $80:818E (change nth bit index to byte index and bitmask). Also written by related boss/event set/clear functions in bank $80
$05E9: 16-bit multiplier A. Used by $80:82D6
$05EB: 16-bit multiplier B. Used by $80:82D6
$05ED..F0: Unused
$05F1: 16-bit * 16-bit result registers. Used by routine $80:82D6
$05F5: Disable sounds
$05F7: Disable mini-map
$05F9: Save confirmation selection
{
    0: Yes
    2: No
}
$05FB: Map scrolling gear switch timer. 0 = free scrolling (hold), 1+ = number of "scrolls" until free scrolling
$05FD: Map scrolling direction
{
    0: None
    1: Left
    2: Right
    3: Up
    4: Down
}
$05FF: Map scrolling speed index. Indexes the map scrolling speed table $82:92E4
$0601: Pause hook. Executed after fade out is complete and HDMA disabled, but before gameplay state is backed up. Set to $A7:C325 by Kraid, $8F:C8F6 by Draygon
$0604: Unpause hook. Executed after gameplay state is restored, but before HDMAs and screen fade in are enabled. Set to $A7:C24E by Kraid, $8F:C8FC by Draygon, $A9:8763 by Mother Brain
$0607: Earthquake sound effect index
$0609: Earthquake sound effect timer. Earthquake sound effect disabled if negative. Used with rising lava/acid and Tourian entrance reveal FX
$060B:
{
    Number of remaining enemy spritemap entries in $A0:944A/9A5A/9B7F/9D23
    Loop counter in enemy death item drop routines
    Botwoon's spit enemy projectile angle parameter
    ; Other stuff. TODO
}
$060D:
{
    Number of remaining enemy hitbox entries in $A0:9A5A/9B7F/9D23
    Number of tiles in $A0:96CA
    Loop counter in $B3:9EE0/9F34
}
$060F: Projectile counter is mirrored here in $A0:9B7F. Never read
$0611..16: Unused
$0617: Uploading to APU flag (disables debug soft reset)
$0619..28: Music queue entries. List of words. See $063D
$0629..38: Music queue timers. List of words. Minimum of 8
$0639: Music queue next index. Index of next available queue entry to write to (write position)
$063B: Music queue start index. Index of next queue entry to process (read position)
$063D: Music entry. Processed when the music timer is decremented to 0
{
    0: Stop music
    1: Samus fanfare
    2: Item fanfare
    3: Elevator
    4: Pre-statue hall (also Ridley pre-fight and game over)
    5: Song 0
    6: Song 1
    7: Song 2
    8: Song 3
    FF00h: SPC engine
    FF03h: Title sequence
    {
        Song 0: Intro
        Song 1: Main theme
        Song 2: Unused intro variation
    }
    FF06h: Empty Crateria
    {
        Song 0: With thunder (landing site - default, Crateria -> Blue Brinstar elevator - default)
        Song 1: Thunder (landing site - Zebes is awake)
        Song 2: Without thunder (morph ball room - default)
    }
    FF09h: Lower Crateria
    {
        Song 0: Main theme
        Song 1: Tourian entrance
    }
    FF0Ch: Upper Crateria (landing site - power bombs, Wrecked Ship entrances)
    FF0Fh: Green Brinstar
    FF12h: Red Brinstar
    FF15h: Upper Norfair
    FF18h: Lower Norfair
    FF1Bh: Maridia
    {
        Song 0: Sandy
        Song 1: Sandless
    }
    FF1Eh: Tourian
    {
        Song 0: Tourian
        Song 1: No music
    }
    FF21h: Mother Brain
    FF24h: Boss fight 1 (and escape music)
    {
        Song 0: Ridley / Draygon / torizos
        Song 1: Pre-fight (Bomb Torizo)
        Song 2: Escape music
    }
    FF27h: Boss fight 2
    {
        Song 0: Kraid / Phantoon / Crocomire
        Song 1: Pre-fight (Kraid / Phantoon / fake Kraid) / post-fight (Crocomire)
    }
    FF2Ah: Miniboss fight (Spore Spawn / Botwoon)
    FF2Dh: Ceres
    {
        Song 0: Flying to Ceres
        Song 1: Ceres
        Song 2: Flying to Zebes
        Song 3: Ceres time up
    }
    FF30h: Wrecked Ship
    {
        Song 0: Power off
        Song 1: Power on
    }
    FF33h: Zebes boom
    FF36h: Intro
    FF39h: Death
    FF3Ch: Credits
    FF3Fh: "The last Metroid is in captivity"
    FF42h: "The galaxy is at peace"
    FF45h: Shitroid (same as boss fight 2)
    {
        Song 0: Boss music
        Song 1: Pre-boss music
        Song 2: No music
    }
    FF48h: Samus theme (same as upper Crateria)
}
$063F: Music timer
$0641: Number of remaining attempts to poll APU for upload request acknowledgement
$0643: Sound queue start index, sound library 1
$0644: Sound queue start index, sound library 2
$0645: Sound queue start index, sound library 3
$0646: Sound queue next index, sound library 1
$0647: Sound queue next index, sound library 2
$0648: Sound queue next index, sound library 3
$0649: Sound state, sound library 1
$064A: Sound state, sound library 2
$064B: Sound state, sound library 3
{
    0: Send APU sound request from queue
    1: Wait for APU sound request acknowledgement
    2: Clear sound request
    3: Wait for APU clear request acknowledgement
    4: Unused. Reset sound state
}
$064C: Current music track. Never read (see $07F5 instead). FFh means new music data is being uploaded
$064D: Current sound, sound library 1
$064E: Current sound, sound library 2
$064F: Current sound, sound library 3
$0650: Delay before clearing sound, sound library 1
$0651: Delay before clearing sound, sound library 2
$0652: Delay before clearing sound, sound library 3
$0653: Max queued sounds allowed, sound library 1
$0654: Max queued sounds allowed, sound library 2
$0655: Max queued sounds allowed, sound library 3
$0656..65: Sound queue, sound library 1
$0666..75: Sound queue, sound library 2
$0676..85: Sound queue, sound library 3
$0686: Sound handler downtime (set to 8 by music queue handler when music changes)
$0688: Crocomire skeleton loading index. Target number of pixels to erase per column (30h) during Crocomire melting
$068A: Crocomire melting tiles loading table (sub)index
$068C: Number of pixels to erase per column per frame (30h) during Crocomire melting
$068E: Number of words to load (200h) when loading Crocomire melting tiles. Used immediately to initialise a loop counter, no reason for this value to be stored to RAM
$0690: Crocomire melting X offset table index. Index for $A4:9697
$0692: Crocomire melting displacement coefficient. Displacement = y * [$0692] / 10000h. Initialised to 100h. Incremented by 180h up to 5000h, finishing the melting
$0694: Initial adjusted destination Y offset during melting. Initialised to 58h. Decremented by 3 until 10h
$0696: Set to 30h when loading Crocomire melting tiles. Never read
$0698: Max adjusted destination Y offset (58h) during Crocomire melting. HDMA data table is processed until [$0694] + y - displacement(y) >= [$0698]
$069A: Crocomire melting tiles loading table (base) index
$069C..071D: Crocomire melting Y offsets. Only $069C..CC used. Indexed by [$9697 + [$0690]] (melting X offset). Pretty useless, could be replaced by a simple loop counter in $96C8
$071C: Unused. Block timer for $80:8577 (block for [A] frames)
$071D: Flag. Transfer Samus' top half tiles to VRAM
$071E: Flag. Transfer Samus' bottom half tiles to VRAM
$071F: Samus' top half tiles definition. Pointer to DMA data (bank 92) for Samus' top sprites (3 byte address, 2 byte part 1 size, 2 byte part 2 size)
$0721: Samus' bottom half tiles definition. Pointer to DMA data (bank 92) for Samus' bottom sprites (3 byte address, 2 byte part 1 size, 2 byte part 2 size)
$0723: Screen fade delay
$0725: Screen fade counter
$0727: Menu index
{
    Debug game over menu:
    {
        0: Fade out and configure graphics for menu
        1: Initialise
        2: Fade in to main
        3: Main
        4: Fade in to continue
        5: Continue
    }

    Game over menu:
    {
        0: Fade out and configure graphics for menu
        1: Initialise
        2: Play pre-statue hall music track
        3: Fade in to main
        4: Main
        5: Fade out into game map view
        6: Load game map view
        7: Fade out into soft reset
    }

    File select menu:
    {
        0: Title sequence to main - fade out and configure graphics
        1: Title sequence to main - load BG2
        2: Title sequence to main - initialise
        3: Title sequence to main - fade in
        4: Main
        5: Main to file copy - fade out
        6: Main to file copy - initialise
        7: Main to file copy - fade in
        8: File copy - select source
        9: File copy - initialise select destination
        Ah: File copy - select destination
        Bh: File copy - initialise confirmation
        Ch: File copy - confirmation
        Dh: File copy - do file copy
        Eh: File copy - copy completed
        Fh: File copy to main - fade out
        10h: File copy to main - reload main
        11h: File copy to main - fade in
        12h: File copy to main - menu index = main
        13h: Main to file clear - fade out
        14h: Main to file clear - initialise
        15h: Main to file clear - fade in
        16h: File clear - select slot
        17h: File clear - initialise confirmation
        18h: File clear - confirmation
        19h: File clear - do file clear
        1Ah: File clear - clear completed
        1Bh: File clear to main - fade out
        1Ch: File clear to main - reload main
        1Dh: File clear to main - fade in
        1Eh: File clear to main - menu index = main
        1Fh: Main to options menu - turn Samus helmet
        20h: Main to options menu - fade out
        21h: Main to title sequence
    }

    File select map:
    {
        0: Game options to area select map - clear BG2 and set up fade out
        1: Game options to area select map - fade out and load area palettes
        2: Game options to area select map - load foreground tilemap
        3: Game options to area select map - load background tilemap
        4: Game options to area select map - prepare expanding/contracting square transition
        5: Game options to area select map - expanding square transition
        6: Area select map
        7: Area select map to room select map - prepare expanding square transition
        8: Area select map to room select map - expanding square transition
        9: Area select map to room select map - initialise
        Ah: Room select map
        Bh: Room select map to loading game data - wait 2 frames before fade out
        Ch: Room select map to loading game data - wait 1 frame before fade out
        Dh: Room select map to loading game data - fade out
        Eh: Room select map to loading game data - wait
        Fh: Room select map to area select map - clear BG1 tilemap
        10h: Room select map to area select map - load palettes
        11h: Room select map to area select map - load foreground tilemap
        12h: Room select map to area select map - load background tilemap
        13h: Room select map to area select map - prepare expanding/contracting square transition
        14h: Room select map to area select map - prepare contracting square transition
        15h: Room select map to area select map - contracting square transition
        16h: Area select map to game options
    }

    Pause menu:
    {
        0: Map screen
        1: Equipment screen
        2: Map screen to equipment screen - fading out
        3: Map screen to equipment screen - load equipment screen
        4: Map screen to equipment screen - fading in
        5: Equipment screen to map screen - fading out
        6: Equipment screen to map screen - load map screen
        7: Equipment screen to map screen - fading in
    }
}
$0729..62: Pause menu data
{
    $0729: Start / L/R button pressed highlight timer
    $072B: L/R highlight animation timer
    $072D: Item selector animation timer
    $072F: Reserve tank animation timer
    $0731: Unused animation timer
    $0733: Map scroll up arrow animation timer
    $0735: Map scroll down arrow animation timer
    $0737: Map scroll right arrow animation timer
    $0739: Map scroll left arrow animation timer
    $073B: Pause menu palette animation timer
    $073D: Unused animation timer
    $073F: L/R highlight animation frame
    $0741: Item selector animation frame
    $0743: Reserve tank animation frame
    $0745: Unused animation frame
    $0747: Map scroll up arrow animation frame
    $0749: Map scroll down arrow animation frame
    $074B: Map scroll right arrow animation frame
    $074D: Map scroll left arrow animation frame
    $074F: Pause menu palette animation frame
    $0751: Shoulder button pressed highlight
    {
        0: None
        1: L
        2: R
    }
    $0753: Pause menu button label mode
    {
        0: Map screen (SAMUS on the right)
        1: Unpausing (nothing)
        2: Equipment screen (MAP on the left)
    }
    $0755: Equipment screen category index
    {
        0: Tanks
        1: Weapons
        2: Suit/misc
        3: Boots
    }
    $0756: Equipment screen item index
    {
        Tanks:
            0: Mode
            1: Reserve tank
        Weapons:
            0: Charge
            1: Ice
            2: Wave
            3: Spazer
            4: Plasma
        Suit/misc:
            0: Varia suit
            1: Gravity suit
            2: Morph ball
            3: Bombs
            4: Spring ball
            5: Screw attack
        Boots:
            0: Hi-jump boots
            1: Space jump
            2: Speed booster
    }
    $0757: Reserve tank sound delay counter
    $0759: Unused animation mode (always 0)
    $075B: Map scroll up arrow animation mode (always 0)
    $075D: Map scroll down arrow animation mode (always 0)
    $075F: Map scroll right arrow animation mode (always 0)
    $0761: Map scroll left arrow animation mode (always 0)
}
$0763: Pause menu mode
{
    0: Map screen
    1: Equipment screen
}
$0765: Backup of $58 during pause menu (BG1 tilemap base address and size)
$0766: Backup of $59 during pause menu (BG2 tilemap base address and size)
$0767: Backup of $5A during pause menu (BG3 tilemap base address and size)
$0768: Backup of $5D during pause menu (BG tiles base address)
$076A: Backup of $52 during pause menu (sprite size and sprite tiles base address)
$076B: Backup of $B1 during pause menu (BG1 X scroll)
$076C: Backup of $B5 during pause menu (BG2 X scroll)
$076D: Backup of $B9 during pause menu (BG3 X scroll)
$076E: Backup of $B3 during pause menu (BG1 Y scroll)
$076F: Backup of $B7 during pause menu (BG2 Y scroll)
$0770: Backup of $BB during pause menu (BG3 Y scroll)
$0771: Backup of $55 during pause menu (mode and BG tile size)
$0772: Backup of $091B during pause menu (layer 2 scroll X)
$0773: Backup of $091C during pause menu (layer 2 scroll Y)
$0774: Backup of $57 during pause menu (mosaic size and enable)
$0775: Backup of $71 during pause menu (next gameplay colour math control register B)
$0776: Samus position indicator animation frame
$0778: Samus position indicator animation timer
$077A: Samus position indicator animation loop counter. Bit 0 is used to toggle Samus icon display in file select map
$077C..0997: Main gameplay RAM (according to $82:8593)
{
    $077C: HUD item tilemap palette bits in $80:9CEA

    $0783: Mode 7 flag
    $0785: Unused. Mode 7 rotation angle in $80:B032/B0C2 (in units of 2pi/100h radians)
    $0787: Set to 0 when loading file select map foreground tilemap. Never read
    $0789: Current area map collected flag. Effectively a mirror of the $7E:D908 byte for the current area, some code checks this variable, some code checks the other one
    $078B: Load station index
    $078D: Door pointer
    $078F: Door BTS
    $0791: Door direction
    {
        0: Right
        1: Left
        2: Down
        3: Up
        +4: Close a door on next screen
    }
    $0793: Elevator door properties. The high byte is incidentally set to door direction, but never read
    {
        0ih: Marks debug elevator index i as used (always 0)
        40h: Switch map to new area
        80h: Door is an elevator
    }
    $0795: Door transition flag (used by elevators and zebetites)
    $0797: Door transition flag (used by other enemies and pause check)
    $0799: Elevator direction
    {
        0: Down
        8000h: Up
    }
    $079B: Room pointer
    $079D: Room index
    $079F: Area index
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
    $07A1: Room X co-ordinate (on map)
    $07A3: Room Y co-ordinate (on map)
    $07A5: Room width in blocks
    $07A7: Room height in blocks
    $07A9: Room width in scrolls (XBA to get room width in pixels)
    $07AB: Room height in scrolls (XBA to get room height in pixels)
    $07AD: Up scroller
    $07AF: Down scroller
    $07B1: Previous CRE bitset
    $07B3: CRE bitset
    {
        1: Disable BG1 during door transitions both into and out of the room
        2: Reload CRE (decompress CRE tiles and CRE tile table, transfer CRE tiles and BG3 tiles to VRAM)
        4: Load extra large tileset (transfer custom tiles and BG3 tiles to VRAM)
    }
    $07B5: Door list pointer
    $07B7: State condition (used when testing room state conditions)
    $07B9: Level data size
    $07BB: Room state pointer
    $07BD: Level data pointer
    $07C0: Tileset tile table pointer
    $07C3: Tileset tiles pointer
    $07C6: Tileset palette pointer
    $07C9: Room music track index
    $07CB: Room music data index
    $07CD: FX pointer
    $07CF: Enemy population pointer
    $07D1: Enemy set pointer
    $07D3..DE: Unused
    $07DF: Room main ASM pointer
    $07E1..E8: Room main ASM variables
    {
        $07E1:
        {
            Diagonal quake timer for escape room 2/4
            Elevatube subposition
            Rotation matrix index for Ceres escape elevator shaft
            Debris delay timer for Ceres pre-elevator hall
        }
        $07E3:
        {
            Earthquake type for escape room 2/4
            Elevatube position
            Rotation matrix timer for Ceres escape elevator shaft
        }
        $07E5: Elevatube velocity. Unit 1/100h px/frame
        $07E7: Elevatube acceleration. Unit 1/100h px/frame²
    }
    $07E9: Scrolling finished hook. Bank $90. Set to $9589 during the Spore Spawn fight to keep the camera from moving up
    $07EB..EC: HDMA data table during Ceres elevator and Ceres Ridley mode 7 sections
    {
        $07EB: Video mode for HUD and floor (mode 1)
        $07EC: Video mode for mode 7 section (mode 7)
    }
    $07ED..F2: Unused
    $07F3: Music data index. Used to compare with new room music track index in door transition for loading music
    $07F5: Music track index. Used as music track to restore after item/Samus fanfare, and to compare with new room music track index in door transition for loading music
    $07F7..08F6: Map tiles explored (for current area). One bit per room. Laid out like a 64x32 1bpp VRAM tilemap: 2x1 pages of 32x32 map tiles (80h bytes per page, 4 bytes per row, 1 bit per tile), each byte is 8 map tiles where the most significant bit is the leftmost tile. The first row is padding and skipped during index calculation ($90:A8A6), that is, room (0, 0) maps to $07FB rather than $07F7
    $08F7: Layer 1 X block (layer 1 X position / 10h)
    $08F9: Layer 1 Y block
    $08FB: Layer 2 X block
    $08FD: Layer 2 Y block
    $08FF: Previous layer 1 X block
    $0901: Previous layer 1 Y block
    $0903: Previous layer 2 X block
    $0905: Previous layer 2 Y block
    $0907: BG1 X block
    $0909: BG1 Y block
    $090B: BG2 X block
    $090D: BG2 Y block
    $090F: Layer 1 X subposition
    $0911: Layer 1 X position
    $0913: Layer 1 Y subposition
    $0915: Layer 1 Y position
    $0917: Layer 2 X position
    $0919: Layer 2 Y position
    $091B: Layer 2 scroll X (bit 0 set means library background is used)
    $091C: Layer 2 scroll Y (bit 0 set means library background is used)
    $091D: BG1 X offset. Base translation between BG and layer positions, [BG1 X scroll] = [layer 1 X position] + [BG1 X offset]. Doesn't account for earthquake or layer 2 bosses
    $091F: BG1 Y offset. Base translation between BG and layer positions, [BG1 Y scroll] = [layer 1 Y position] + [BG1 Y offset]. Doesn't account for earthquake or layer 2 bosses
    $0921: BG2 X offset. Base translation between BG and layer positions, [BG2 X scroll] = [layer 2 X position] + [BG2 X offset]. Doesn't account for earthquake or layer 2 bosses
    $0923: BG2 Y offset. Base translation between BG and layer positions, [BG2 Y scroll] = [layer 2 Y position] + [BG2 Y offset]. Doesn't account for earthquake or layer 2 bosses
    $0925: Door transition frame counter. Stops at 40h for horizontal doors, 39h for vertical doors
    $0927: Door destination X position. Multiple of 100h (screens)
    $0929: Door destination Y position. Multiple of 100h (screens). Adjusted by 20h when moving up
    $092B: Samus subspeed during door transition
    $092D: Samus speed during door transition. Defaults to 0.C8h for horizontal and 1.80h for vertical, but can be overridden by "distance from door" in door header
    $092F: Downwards elevator delay timer. Initialised to 30h. This is what lets Samus scroll off-screen before performing door transition on downwards elevators
    $0931: Flag. 8000h = door transition has finished scrolling
    $0933:
    {
        Position of right/left scroll boundary in $80:A528
        VRAM offset of blocks to update in $80:A9DE/$80:AB75
        [VRAM blocks to update X block] & Fh in $80:AB75
    }
    $0935: X block of VRAM blocks to update (after masking with 1Fh) in $80:A9DE/$80:AB75
    $0937:
    {
        Base address of VRAM tilemap screen in $80:A9DE
        Index of VRAM tilemap source data in $80:A9DE
        Base address of wrapped VRAM tilemap screen in $80:AB75
    }
    $0939:
    {
        Proposed scrolled layer 1 X position in $80:A528/A641/A6BB. [layer 1 X position] ± (X distance Samus moved + 3)
        Proposed scrolled layer 1 Y position in $80:A731/A893/A936. [layer 1 Y position] ± (Y distance Samus moved + 3)
        Loop counter in $80:A9DE
    }
    $093B: Block to update (in $7F) in $80:A9DE/$80:AB75
    $093D: Unused
    $093F: Ceres status
    {
        0: Before Ridley escape
        1: During Ridley escape cutscene
        2: During escape sequence
        8000h: When elevator room rotates
    }
    $0941: Camera distance index
    {
        0: Normal (camera is 60h pixels behind Samus)
        2: Kraid/Crocomire (camera is 40h/50h pixels to the left of Samus when she's facing right/left)
        4: Camera is 20h pixels to the left of Samus. Unused
        6: Camera is E0h pixels to the left of Samus. Set by Crocomire when camera is locked on the spike wall during the death sequence (though the camera is locked, so the camera distance index has no effect)
    }
    $0943: Timer status. Upper byte is set to 80h sometimes, but never read
    {
        0: Inactive
        1: Ceres start
        2: Mother Brain start
        3: Initial delay
        4: Timer running, movement delayed
        5: Timer running, moving into place
        6: Timer running, moved into place
    }
    $0945: Timer, centiseconds (in decimal)
    $0946: Timer, seconds (in decimal)
    $0947: Timer, minutes (in decimal)
    $0948: Timer X subposition. Also timer status counter before timer moves
    $0949: Timer X position (pixels)
    $094A: Timer Y subposition
    $094B: Timer Y position (pixels)
    $094C..4F: Unused
    $0950: File select map area index / game over menu selection
    $0952: Save slot selected (0..2) / file select menu selection (0..5)
    $0954: Non-empty save slots
    {
        1: Slot A
        2: Slot B
        4: Slot C
    }
    $0956: Unwrapped tilemap VRAM update size               - BG1 column update
    $0958: Wrapped tilemap VRAM update size                 - BG1 column update
    $095A: Unwrapped tilemap VRAM update destination        - BG1 column update
    $095C: Wrapped tilemap VRAM update destination          - BG1 column update
    $095E: Wrapped tilemap VRAM update left halves source   - BG1 column update
    $0960: Wrapped tilemap VRAM update right halves source  - BG1 column update
    $0962: Flag to update VRAM tilemap                      - BG1 column update
    $0964: Unwrapped tilemap VRAM update size               - BG1 row update
    $0966: Wrapped tilemap VRAM update size                 - BG1 row update
    $0968: Unwrapped tilemap VRAM update destination        - BG1 row update
    $096A: Wrapped tilemap VRAM update destination          - BG1 row update
    $096C: Wrapped tilemap VRAM update top halves source    - BG1 row update
    $096E: Wrapped tilemap VRAM update bottom halves source - BG1 row update
    $0970: Flag to update VRAM tilemap                      - BG1 row update
    $0972: Unwrapped tilemap VRAM update size               - BG2 column update
    $0974: Wrapped tilemap VRAM update size                 - BG2 column update
    $0976: Unwrapped tilemap VRAM update destination        - BG2 column update
    $0978: Wrapped tilemap VRAM update destination          - BG2 column update
    $097A: Wrapped tilemap VRAM update left halves source   - BG2 column update
    $097C: Wrapped tilemap VRAM update right halves source  - BG2 column update
    $097E: Flag to update VRAM tilemap                      - BG2 column update
    $0980: Unwrapped tilemap VRAM update size               - BG2 row update
    $0982: Wrapped tilemap VRAM update size                 - BG2 row update
    $0984: Unwrapped tilemap VRAM update destination        - BG2 row update
    $0986: Wrapped tilemap VRAM update destination          - BG2 row update
    $0988: Wrapped tilemap VRAM update top halves source    - BG2 row update
    $098A: Wrapped tilemap VRAM update bottom halves source - BG2 row update
    $098C: Flag to update VRAM tilemap                      - BG2 row update
    $098E: Size of BG2
    $0990: Blocks to update X block
    $0992: Blocks to update Y block
    $0994: VRAM blocks to update X block
    $0996: VRAM blocks to update Y block
}
$0998: Game state
{
    0: Reset/start.                                                                     Set by $82:893D (main game loop)
    1: Opening (title sequence). Cinematic.                                             Set by $82:85FB (transition from demo), $82:8AE4 (reset/start)
    2: Game options menu.                                                               Set by $81:94A3 (file select menu, file selected), $81:9E7B (file select map, back)
    3: Unused. Nothing (RTS)
    4: File select menus.                                                               Set by $82:EE6A (game options menu - transition back to file select), $8B:9F52 (cinematic function - transition to file select menu)
    5: File select map.                                                                 Set by $81:9116 (game over menu "no", not starting from Ceres), $82:EEB4 (start game, main / debug)
    6: Loading game data.                                                               Set by $8B:CADF (cinematic function - load game data)
    7: Main gameplay fading in.                                                         Set by $82:8000 (loading game data / set up new game)
    8: Main gameplay.                                                                   Set by $82:8B20 (main gameplay fading in), $82:93A1 (game state 12h), $82:DC10 (reserve tank auto), $82:E737 (finish door transition)
    9: Hit a door block.                                                                Set by $94:938B (horizontal door collision), $94:93CE (vertical door collision)
    Ah: Loading next room.                                                              Set by $82:E169 (hit a door block)
    Bh: Loading next room.                                                              Set by $82:E1B7 (game state Ah)
    Ch: Pausing, normal gameplay but darkening.                                         Set by $85:80FA (map data access completed), $90:EA45 (pause check)
    Dh: Pausing, loading pause menu.                                                    Set by $82:8CCF (game state Ch)
    Eh: Paused, loading pause menu.                                                     Set by $82:8CEF (game state Dh)
    Fh: Paused, map and item screens.                                                   Set by $82:90C8 (game state Eh)
    10h: Unpausing, loading normal gameplay.                                            Set by $81:907E (debug game over menu continue), $82:A5B7 (pause menu, start)
    11h: Unpausing, loading normal gameplay.                                            Set by $82:9324 (game state 10h)
    12h: Unpausing, normal gameplay but brightening.                                    Set by $82:9367 (game state 11h)
    13h: Death sequence, start                                                          Set by $82:DB69 (Samus ran out of health, no reserves)
    14h: Death sequence, black out surroundings.                                        Set by $82:DC80 (game state 13h)
    15h: Death sequence, wait for music.                                                Set by $82:DCE0 (game state 14h)
    16h: Death sequence, pre-flashing.                                                  Set by $82:DD71 (game state 15h)
    17h: Death sequence, flashing.                                                      Set by $82:DD87 (game state 16h)
    18h: Death sequence, explosion white out.                                           Set by $82:DD9A (game state 17h)
    19h: Death sequence, black out.                                                     Set by $82:8431 (whiting out from time up), $82:DDAF (game state 18h), $8B:C627
    1Ah: Game over menu.                                                                Set by $82:DDC7 (game state 19h)
    1Bh: Reserve tanks auto.                                                            Set by $82:DB69 (Samus ran out of non-reserve health)
    1Ch: Unused. Does JMP ($0DEA) ($0DEA is never set to a pointer)
    1Dh: Debug game over menu (end/continue).                                           Set by $B4:9961 (debug controller 2 start)
    1Eh: Intro. Cinematic. Set up entirely new game with cutscenes.                     Set by $82:EEB4 (start game, intro)
    1Fh: Set up new game. Post-intro.                                                   Set by $81:912B (game over menu "no", starting from Ceres), $82:EEB4 (start game, starting at Ceres), $8B:C100
    20h: Made it to Ceres elevator.                                                     Set by $89:ACC3 (Ceres elevator shaft main ASM)
    21h: Blackout from Ceres.                                                           Set by $82:8367 (made it to Ceres elevator)
    22h: Ceres goes boom, Samus goes to Zebes. Cinematic.                               Set by $82:8388 (blackout from Ceres), $82:EEB4 (start game, landing on Zebes)
    23h: Time up.                                                                       Set by $90:E0E6, $90:E8AA, $90:F576 (Zebes timebomb expired)
    24h: Whiting out from time up.                                                      Set by $82:8411 (time up)
    25h: Ceres goes boom with Samus. Cinematic.                                         Set by $82:8431 (whiting out from time up)
    26h: Samus escapes from Zebes. Transition from main gameplay to ending and credits. Set by $A2:AD0E (gunship liftoff)
    27h: Ending and credits. Cinematic.                                                 Set by $82:84BD (Samus escapes from Zebes)
    28h: Load demo game data.                                                           Set by $82:85FB (transition from demo), $8B:9FAE (cinematic function - transition to demos)
    29h: Transition to demo.                                                            Set by $82:8000 (load demo game data)
    2Ah: Playing demo.                                                                  Set by $82:852D (transition to demo)
    2Bh: Unload game data.                                                              Set by $82:8548 (playing demo)
    2Ch: Transition from demo.                                                          Set by $82:8593 (unload game data)
}
$099A: Unused
$099C: Door transition function
{
    $E17D: Handle elevator
    $E19F: Wait 48 frames for down elevator
    $E29E: Wait for sounds to finish
    $E2DB: Fade out the screen
    $E2F7: Load door header, clear DMA, and set interrupt command
    $E310: Scroll screen to alignment
    $E353: Fix doors moving up
    $E36E: Load room header; set up map; decompress level, scroll, and CRE data
    $E38E: Set up scrolling
    $E3C0: Place Samus, load tiles
    $E4A9: Load sprites, background, PLMs, audio; execute custom door and room ASM; and wait for scrolling to end
    $E659: Handle animated tiles
    $E664: Wait for music queue to clear and possibly load new music
    $E6A2: Positions Samus to avoid collision with the door (kinda useless), and enables some Layer 2 and Layer 3 stuff
    $E737: Fade in the screen and run enemies; finish room transition

    $E17D..E19F is a chain of functions whose initial value is written by door block collision
    $E29E..E737 is a chain of functions whose initial value is written by game state Ah (loading next room)
    $E737 is also written by $80:A07B (start gameplay) and checked for by $88:DE18 (Ceres haze HDMA object)
    $E2DB is checked for by $88:DE74 (Ceres haze HDMA object)
}
$099E: Menu option index (in options menu and submenus)
$09A0: Unused
$09A2..0A01: Samus data and game options. Saved to SRAM
{
    $09A2: Equipped items
    $09A4: Collected items
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
        8000h: X-ray
    }
    $09A6: Equipped beams. Note for additional custom beams, the fire beam routines ($91:B887/B986) set projectile type ($0C18) directly to [equipped beams] | 8000h/8010h (possibly masked with 100Fh), which in turn is masked with Fh to extract beam type.
    $09A8: Collected beams
    {
        1: Wave
        2: Ice
        4: Spazer
        8: Plasma
        1000h: Charge
    }
    $09AA: Up binding. D-pad bindings are only used by x-ray
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
    $09AC: Down binding
    $09AE: Left binding
    $09B0: Right binding
    $09B2: Shoot binding
    $09B4: Jump binding
    $09B6: Run binding
    $09B8: Item cancel binding
    $09BA: Item select binding
    $09BC: Aim down binding
    $09BE: Aim up binding
    $09C0: Reserve health mode
    {
        0: Not obtained
        1: Auto
        2: Manual
    }
    $09C2: Samus health
    $09C4: Samus max health
    $09C6: Samus missiles
    $09C8: Samus max missiles
    $09CA: Samus super missiles
    $09CC: Samus max super missiles
    $09CE: Samus power bombs
    $09D0: Samus max power bombs
    $09D2: HUD item index
    {
        0: Nothing
        1: Missiles
        2: Super missiles
        3: Power bombs
        4: Grapple beam
        5: X-ray
    }
    $09D4: Samus max reserve health
    $09D6: Samus reserve health
    $09D8: Samus reserve missiles. Only used by missile pickup routine ($91:DF80)
    $09DA: Game time, frames
    $09DC: Game time, seconds
    $09DE: Game time, minutes
    $09E0: Game time, hours (capped at 99:59:59.59)
    $09E2: Japanese text flag. 1 = on
    $09E4: Moonwalk flag. 1 = on
    $09E6: Debug. Disable Samus placement mode flag. 0: Allows positioning Samus in demo recorder. Toggled by B on controller 2. Allows A on controller 2 to freeze time. Set to 1 by when loading demo data or making new save file after setting controller bindings etc.
    $09E8: Set to 1 when loading demo data or making new save file after setting controller bindings etc.. Otherwise unused
    $09EA: Icon cancel flag (cancel HUD item on door transition). 1 = on
    $09EC..0A01: Unused. Saved to SRAM via 7E:D80A..1F
}
$0A02..0E0B: Samus RAM (according to $91:E018)
{
    $0A02: Unused
    $0A04: Auto-cancel HUD item index
    $0A06: Samus HUD health
    $0A08: Samus HUD missiles
    $0A0A: Samus HUD supers missiles
    $0A0C: Samus HUD power bombs
    $0A0E: Previous HUD item index. Used for check to update HUD item highlight
    $0A10: Samus previous pose X direction. Never read. See $0A22
    $0A11: Samus previous movement type. Used only for an x-ray and sound effect check. See $0A23. TODO: research and rename
    $0A12: Samus previous health. Used to check to make hurt sound and flash.
    $0A14: Backup of controller 1 input ($8B) during demo (actual hardware buttons, not game generated demo input)
    $0A16: Backup of newly pressed controller 1 input ($8F) during demo (actual hardware buttons, not game generated demo input)
    $0A18: Cleared in a few places in bank $91, never read
    $0A1A: Unused
    $0A1C: Samus pose. See "Pose definitions.asm"
    {
        0: Facing forward - power suit
        1: Facing right - normal
        2: Facing left  - normal
        3: Facing right - aiming up
        4: Facing left  - aiming up
        5: Facing right - aiming up-right
        6: Facing left  - aiming up-left
        7: Facing right - aiming down-right
        8: Facing left  - aiming down-left
        9: Moving right - not aiming
        Ah: Moving left  - not aiming
        Bh: Moving right - gun extended
        Ch: Moving left  - gun extended
        Dh: Moving right - aiming up (unused)
        Eh: Moving left  - aiming up (unused)
        Fh: Moving right - aiming up-right
        10h: Moving left  - aiming up-left
        11h: Moving right - aiming down-right
        12h: Moving left  - aiming down-left
        13h: Facing right - normal jump - not aiming - not moving - gun extended
        14h: Facing left  - normal jump - not aiming - not moving - gun extended
        15h: Facing right - normal jump - aiming up
        16h: Facing left  - normal jump - aiming up
        17h: Facing right - normal jump - aiming down
        18h: Facing left  - normal jump - aiming down
        19h: Facing right - spin jump
        1Ah: Facing left  - spin jump
        1Bh: Facing right - space jump
        1Ch: Facing left  - space jump
        1Dh: Facing right - morph ball - no springball - on ground
        1Eh: Moving right - morph ball - no springball - on ground
        1Fh: Moving left  - morph ball - no springball - on ground
        20h: Unused
        21h: Unused
        22h: Unused
        23h: Unused
        24h: Unused
        25h: Facing right - turning - standing
        26h: Facing left  - turning - standing
        27h: Facing right - crouching
        28h: Facing left  - crouching
        29h: Facing right - falling
        2Ah: Facing left  - falling
        2Bh: Facing right - falling - aiming up
        2Ch: Facing left  - falling - aiming up
        2Dh: Facing right - falling - aiming down
        2Eh: Facing left  - falling - aiming down
        2Fh: Facing right - turning - jumping
        30h: Facing left  - turning - jumping
        31h: Facing right - morph ball - no springball - in air
        32h: Facing left  - morph ball - no springball - in air
        33h: Unused
        34h: Unused
        35h: Facing right - crouching transition
        36h: Facing left  - crouching transition
        37h: Facing right - morphing transition
        38h: Facing left  - morphing transition
        39h: Unused
        3Ah: Unused
        3Bh: Facing right - standing transition
        3Ch: Facing left  - standing transition
        3Dh: Facing right - unmorphing transition
        3Eh: Facing left  - unmorphing transition
        3Fh: Unused
        40h: Unused
        41h: Facing left  - morph ball - no springball - on ground
        42h: Unused
        43h: Facing right - turning - crouching
        44h: Facing left  - turning - crouching
        45h: Unused
        46h: Unused
        47h: Unused
        48h: Unused
        49h: Facing left  - moonwalk
        4Ah: Facing right - moonwalk
        4Bh: Facing right - normal jump transition
        4Ch: Facing left  - normal jump transition
        4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
        4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended
        4Fh: Facing left  - damage boost
        50h: Facing right - damage boost
        51h: Facing right - normal jump - not aiming - moving forward
        52h: Facing left  - normal jump - not aiming - moving forward
        53h: Facing right - knockback
        54h: Facing left  - knockback
        55h: Facing right - normal jump transition - aiming up
        56h: Facing left  - normal jump transition - aiming up
        57h: Facing right - normal jump transition - aiming up-right
        58h: Facing left  - normal jump transition - aiming up-left
        59h: Facing right - normal jump transition - aiming down-right
        5Ah: Facing left  - normal jump transition - aiming down-left
        5Bh: Unused
        5Ch: Unused
        5Dh: Unused
        5Eh: Unused
        5Fh: Unused
        60h: Unused
        61h: Unused
        62h: Unused
        63h: Unused
        64h: Unused
        65h: Unused
        66h: Unused
        67h: Facing right - falling - gun extended
        68h: Facing left  - falling - gun extended
        69h: Facing right - normal jump - aiming up-right
        6Ah: Facing left  - normal jump - aiming up-left
        6Bh: Facing right - normal jump - aiming down-right
        6Ch: Facing left  - normal jump - aiming down-left
        6Dh: Facing right - falling - aiming up-right
        6Eh: Facing left  - falling - aiming up-left
        6Fh: Facing right - falling - aiming down-right
        70h: Facing left  - falling - aiming down-left
        71h: Facing right - crouching - aiming up-right
        72h: Facing left  - crouching - aiming up-left
        73h: Facing right - crouching - aiming down-right
        74h: Facing left  - crouching - aiming down-left
        75h: Facing left  - moonwalk - aiming up-left
        76h: Facing right - moonwalk - aiming up-right
        77h: Facing left  - moonwalk - aiming down-left
        78h: Facing right - moonwalk - aiming down-right
        79h: Facing right - morph ball - spring ball - on ground
        7Ah: Facing left  - morph ball - spring ball - on ground
        7Bh: Moving right - morph ball - spring ball - on ground
        7Ch: Moving left  - morph ball - spring ball - on ground
        7Dh: Facing right - morph ball - spring ball - falling
        7Eh: Facing left  - morph ball - spring ball - falling
        7Fh: Facing right - morph ball - spring ball - in air
        80h: Facing left  - morph ball - spring ball - in air
        81h: Facing right - screw attack
        82h: Facing left  - screw attack
        83h: Facing right - wall jump
        84h: Facing left  - wall jump
        85h: Facing right - crouching - aiming up
        86h: Facing left  - crouching - aiming up
        87h: Facing right - turning - falling
        88h: Facing left  - turning - falling
        89h: Facing right - ran into a wall
        8Ah: Facing left  - ran into a wall
        8Bh: Facing right - turning - standing - aiming up
        8Ch: Facing left  - turning - standing - aiming up
        8Dh: Facing right - turning - standing - aiming down-right
        8Eh: Facing left  - turning - standing - aiming down-left
        8Fh: Facing right - turning - in air - aiming up
        90h: Facing left  - turning - in air - aiming up
        91h: Facing right - turning - in air - aiming down/down-right
        92h: Facing left  - turning - in air - aiming down/down-left
        93h: Facing right - turning - falling - aiming up
        94h: Facing left  - turning - falling - aiming up
        95h: Facing right - turning - falling - aiming down/down-right
        96h: Facing left  - turning - falling - aiming down/down-left
        97h: Facing right - turning - crouching - aiming up
        98h: Facing left  - turning - crouching - aiming up
        99h: Facing right - turning - crouching - aiming down/down-right
        9Ah: Facing left  - turning - crouching - aiming down/down-left
        9Bh: Facing forward - varia/gravity suit
        9Ch: Facing right - turning - standing - aiming up-right
        9Dh: Facing left  - turning - standing - aiming up-left
        9Eh: Facing right - turning - in air - aiming up-right
        9Fh: Facing left  - turning - in air - aiming up-left
        A0h: Facing right - turning - falling - aiming up-right
        A1h: Facing left  - turning - falling - aiming up-left
        A2h: Facing right - turning - crouching - aiming up-right
        A3h: Facing left  - turning - crouching - aiming up-left
        A4h: Facing right - landing from normal jump
        A5h: Facing left  - landing from normal jump
        A6h: Facing right - landing from spin jump
        A7h: Facing left  - landing from spin jump
        A8h: Facing right - grappling
        A9h: Facing left  - grappling
        AAh: Facing right - grappling - aiming down-right
        ABh: Facing left  - grappling - aiming down-left
        ACh: Unused. Facing right - grappling - in air
        ADh: Unused. Facing left  - grappling - in air
        AEh: Unused. Facing right - grappling - in air - aiming down
        AFh: Unused. Facing left  - grappling - in air - aiming down
        B0h: Unused. Facing right - grappling - in air - aiming down-right
        B1h: Unused. Facing left  - grappling - in air - aiming down-left
        B2h: Facing clockwise     - grapple swinging
        B3h: Facing anticlockwise - grapple swinging
        B4h: Facing right - grappling - crouching
        B5h: Facing left  - grappling - crouching
        B6h: Facing right - grappling - crouching - aiming down-right
        B7h: Facing left  - grappling - crouching - aiming down-left
        B8h: Facing left  - grapple wall jump pose
        B9h: Facing right - grapple wall jump pose
        BAh: Facing left  - grabbed by Draygon - not moving - not aiming
        BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left
        BCh: Facing left  - grabbed by Draygon - firing
        BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left
        BEh: Facing left  - grabbed by Draygon - moving
        BFh: Facing right - moonwalking - turn/jump left
        C0h: Facing left  - moonwalking - turn/jump right
        C1h: Facing right - moonwalking - turn/jump left  - aiming up-right
        C2h: Facing left  - moonwalking - turn/jump right - aiming up-left
        C3h: Facing right - moonwalking - turn/jump left  - aiming down-right
        C4h: Facing left  - moonwalking - turn/jump right - aiming down-left
        C5h: Unused
        C6h: Unused
        C7h: Facing right - vertical shinespark windup
        C8h: Facing left  - vertical shinespark windup
        C9h: Facing right - shinespark - horizontal
        CAh: Facing left  - shinespark - horizontal
        CBh: Facing right - shinespark - vertical
        CCh: Facing left  - shinespark - vertical
        CDh: Facing right - shinespark - diagonal
        CEh: Facing left  - shinespark - diagonal
        CFh: Facing right - ran into a wall - aiming up-right
        D0h: Facing left  - ran into a wall - aiming up-left
        D1h: Facing right - ran into a wall - aiming down-right
        D2h: Facing left  - ran into a wall - aiming down-left
        D3h: Facing right - crystal flash
        D4h: Facing left  - crystal flash
        D5h: Facing right - x-ray - standing
        D6h: Facing left  - x-ray - standing
        D7h: Facing right - crystal flash ending
        D8h: Facing left  - crystal flash ending
        D9h: Facing right - x-ray - crouching
        DAh: Facing left  - x-ray - crouching
        DBh: Unused
        DCh: Unused
        DDh: Unused
        DEh: Unused
        DFh: Unused
        E0h: Facing right - landing from normal jump - aiming up
        E1h: Facing left  - landing from normal jump - aiming up
        E2h: Facing right - landing from normal jump - aiming up-right
        E3h: Facing left  - landing from normal jump - aiming up-left
        E4h: Facing right - landing from normal jump - aiming down-right
        E5h: Facing left  - landing from normal jump - aiming down-left
        E6h: Facing right - landing from normal jump - firing
        E7h: Facing left  - landing from normal jump - firing
        E8h: Facing right - Samus drained - crouching/falling
        E9h: Facing left  - Samus drained - crouching/falling
        EAh: Facing right - Samus drained - standing
        EBh: Facing left  - Samus drained - standing
        ECh: Facing right - grabbed by Draygon - not moving - not aiming
        EDh: Facing right - grabbed by Draygon - not moving - aiming up-right
        EEh: Facing right - grabbed by Draygon - firing
        EFh: Facing right - grabbed by Draygon - not moving - aiming down-right
        F0h: Facing right - grabbed by Draygon - moving
        F1h: Facing right - crouching transition - aiming up
        F2h: Facing left  - crouching transition - aiming up
        F3h: Facing right - crouching transition - aiming up-right
        F4h: Facing left  - crouching transition - aiming up-left
        F5h: Facing right - crouching transition - aiming down-right
        F6h: Facing left  - crouching transition - aiming down-left
        F7h: Facing right - standing transition - aiming up
        F8h: Facing left  - standing transition - aiming up
        F9h: Facing right - standing transition - aiming up-right
        FAh: Facing left  - standing transition - aiming up-left
        FBh: Facing right - standing transition - aiming down-right
        FCh: Facing left  - standing transition - aiming down-left
    }
    $0A1E: Samus pose X direction
    {
        0: Facing forward
        1: Unused pose 21h
        2: Unused pose 22h
        4: Facing left
        8: Facing right
    }
    $0A1F: Samus movement type. See "Pose definitions.asm"
    {
        0: Standing
        1: Running
        2: Normal jumping
        3: Spin jumping
        4: Morph ball - on ground
        5: Crouching
        6: Falling
        7: Unused
        8: Morph ball - falling
        9: Unused
        Ah: Knockback / crystal flash ending
        Bh: Unused
        Ch: Unused
        Dh: Unused
        Eh: Turning around - on ground
        Fh: Crouching/standing/morphing/unmorphing transition
        10h: Moonwalking
        11h: Spring ball - on ground
        12h: Spring ball - in air
        13h: Spring ball - falling
        14h: Wall jumping
        15h: Ran into a wall
        16h: Grappling
        17h: Turning around - jumping
        18h: Turning around - falling
        19h: Damage boost
        1Ah: Grabbed by Draygon
        1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
    }
    $0A20: Samus previous pose
    $0A22: Samus previous pose X direction
    $0A23: Samus previous movement type
    $0A24: Samus last different pose
    $0A26: Samus last different pose X direction
    $0A27: Samus last different pose movement type
    $0A28: Prospective pose due to player input. Set according to transition table or solid vertical collision
    $0A2A: Special prospective pose due to interaction. Set according to grapple, bomb jump, knockback, or shinespark windup
    $0A2C: Super special prospective pose due to action finish. Set according to animation finish, shinespark crash finish, grapple finish, or knockback finish
    $0A2E: Prospective pose change command
    {
        0: None
        1: Decelerate
        2: Stop
        5: Solid vertical collision (bounce / fall / land / wall-jump)
        6: Kill X speed
        7: Start transition animation (crouching/standing/morphing/unmorphing)
        8: Kill run speed
    }
    $0A30: Special prospective pose change command
    {
        0: None
        1: Start knockback
        3: Start bomb jump
        4: Set by unused Samus pose input handler code $91:80BE
        5: X-ray
        9: Connecting grapple - swinging
        Ah: Connecting grapple - stuck in place
    }
    $0A32: Super special prospective pose change command
    {
        0: None
        1: Knockback finished
        2: Shinespark finished
        3: Transition animation finished (crouching/standing/morphing/unmorphing)
        6: Start grapple wall-jump
        7: Start release from grapple swing
        8: Knockback and transition animation both finished
    }
    $0A34: Solid enemy collision flags                   in $91:FDAE (called if pose is changed to [$0A2A] or [$0A28])
    $0A36: Block collision flags                         in $91:FDAE (called if pose is changed to [$0A2A] or [$0A28])
    $0A38: Space to move Samus up   (due to blocks)      in $91:FDAE (called if pose is changed to [$0A2A] or [$0A28])
    $0A3A: Samus Y radius difference                     in $91:FDAE (called if pose is changed to [$0A2A] or [$0A28])
    $0A3C: Space to move Samus down (due to blocks)      in $91:FDAE (called if pose is changed to [$0A2A] or [$0A28])
    $0A3E: Space to move Samus up   (due to solid enemy) in $91:FDAE (called if pose is changed to [$0A2A] or [$0A28])
    $0A40: Space to move Samus down (due to solid enemy) in $91:FDAE (called if pose is changed to [$0A2A] or [$0A28])
    $0A42: Samus current state handler. Sets Samus' radius, runs pose input handler, determines suit palette index and Y acceleration, runs Samus block inside handling, handle projectiles
    {
        $E695: Normal
        $E6C9: Demo
        $E713: Samus is locked
        $E8CD: RTL
    }
    $0A44: Samus new state handler. Move and animate Samus, then process hit interruption, then handle pose change. Handle Samus' palette, periodic damage, pause check and low health check
    {
        $E725: Normal. Contains demo recorder
        $E7D2: Debug. Do nothing until controller 2 presses A
        $E7F5: Title demo
        $E833: Intro demo
        $E86A: Samus appearance
        $E8AA: Ceres
        $E8CD: RTL. Generic RTL, not checked for by anything
        $E8D6: RTL. Samus is locked into (map/energy/missile) station. Checked for by $90:F29E (unlock Samus from map station)
        $E8D9: RTL. Samus is being drained (rainbow beam). Checked for by $90:F2E0 (Samus command 10h: unlock Samus from reserve tank) / $90:F411 (Samus command 1Bh: lock Samus for reserve tank) / $91:D8A5 (handle misc. Samus palette)
        $E8DC: Samus is locked
        $E8EC: Riding elevator
        $E902: Entering/exiting gunship
    }
    $0A46: If v & 2 != 0, enables $94:87F4 (Samus horizontal slope collision). Always 3. Set to 0/1 by unused solid vertical collision code ($91:F2F0) if collided with solid enemy and previous movement type = 9 (unused)
    $0A48: Samus hurt flash counter
    $0A4A: Super special Samus palette flags. 0: normal. 8000h: acquiring hyper beam. Otherwise treated as counter, blue if v & 1 (drained by metroid)
    $0A4C: Samus' subunit health? Only affected by environmental damage (0A4E)
    $0A4E: Periodic subdamage (to Samus)
    $0A50: Periodic damage (to Samus). Adjusted by suit divisors. Used by Brinstar floor/ceiling plant inside reaction, Draygon's broken turret grappled reaction, unused FX type 22h top row, Samus in heat/lava/acid, spike collision reaction, air spike inside reaction
    $0A52: Knockback direction
    {
        0: None
        1: Up left
        2: Up right
        4: Down left
        5: Down right
    }
    $0A54: Knockback X direction. 0 = left, 1 = right
    $0A56: Bomb jump direction
    {
        0: None
        1: Left
        2: Straight
        3: Right

        + 800h: Bomb jump active(?)
    }
    $0A58: Samus movement handler. Bank $90. Called by $0A44 handlers $E725/$E7F5/$E833/$E8EC
    {
        $946E: Released from grapple swing
        $94CB: Samus drained - falling
        $A337: Normal
        $D068: Shinespark windup
        $D0AB: Vertical shinespark
        $D0D7: Diagonal shinespark
        $D106: Horizontal shinespark
        $D346: Shinespark crash - echoes circle Samus
        $D3F3: Shinespark crash - echoes finished circling Samus
        $D40D: Shinespark crash - finish
        $D678: Crystal flash - start
        $D6CE: Crystal flash - main
        $D75B: Crystal flash - finish
        $DF38: Knockback
        $E025: Bomb jump - start
        $E032: Bomb jump - main
        $E90E: RTS
        $E94F: X-ray
        $F04B: Unused. Shinespark beam related?
        $F072: Unused. Shinespark beam related?
    }
    $0A5A: Timer / Samus hack handler. Bank $90. Called by $0A44 handler $E725
    {
        $E09B: Handle letting Samus up from being drained
        $E0C5: Handle letting Samus fail to stand up from being drained
        $E0E6: Handle timer
        $E114: Draw timer
        $E12E: Push Samus out of Ceres Ridley's way
        $E1C8: Pushing Samus out of Ceres Ridley's way
        $E2A1: Grabbed by Draygon
        $E37E: RTS
        $E3A3: Unused. Pushing morph ball Samus out of Ceres Ridley's way
        $E41B: Unused. Special falling. Accelerates Samus Y speed up to 5, then sets her animation frame to 4 (invisible) if she's falling
        $E90E: RTS. Normal
    }
    $0A5C: Samus drawing handler. Bank $90
    {
        $EB52: Default
        $EB86: Firing grapple beam
        $EBF2: RTS. Set by unused code timer / Samus hack handler $90:E35A
        $EBF3: Shinespark crash echo circle
        $EC14: Using elevator
        $EC1D: Inanimate Samus. Set by death sequence and suit pickup
    }
    $0A5E: Unused. Debug command handler. Bank $90. Only ever set to $F534 (RTS)
    {
        $F534: RTS
        $F535: Give Samus a shinespark if Y is newly pressed
        $F54C: Disable rainbow Samus and stand her up if controller 2 Y is newly pressed
        $F561: Release Samus from drained pose if Y newly pressed
    }
    $0A60: Samus pose input handler. Bank $90. Called by $0A42 handlers $E695/$E6C9
    {
        $E90E: RTS. Shinespark / crystal flash / bomb jump / yapping maw
        $E913: Normal
        $E918: X-ray
        $E91D: Demo
        $E926: Auto-jump hack (used when e.g. landing from jump, turning around)
    }
    $0A62: Samus push direction (for Ceres Ridley escape)
    {
        0: None
        1: Left
        2: Right
    }
    $0A64: Grapple connected flags
    {
        1: Samus is connected
        2: Samus released from Draygon
    }
    $0A66: Samus X speed divisor. Halves Samus X speed this many times, up to 4 times. Also slows down animations linearly, no limit. Incremented/decremented by Draygon gunk. Set to 2 by Shitroid
    $0A68: Special Samus palette timer. Used for speed booster shine, shinesparking, crystal flash bubble, but not speed boosting or x-ray
    $0A6A: Samus health warning is on
    $0A6C: Samus X speed table pointer. Used for base speed ($0B46). Pointer to table of Ch byte entries, indexed by Samus movement type
    {
        AAAA aaaa MMMM mmmm DDDD dddd

        A.a: X acceleration
        M.m: Max X speed
        D.d: X deceleration

        $9F55: Normal. Set by most block inside reactions
        $A08D: Water
        $A1DD: Acid/lava
    }
    $0A6E: Samus contact damage index. The lower number is used when Samus is in many of these states
    {
        0: Normal
        1: Speed boosting
        2: Shinesparking
        3: Screw attacking
        4: Pseudo screw attacking
    }
    $0A70: Unused
    $0A72: Samus visor palette timer
    $0A73: Samus visor palette index. Multiple of 2. Colour math backdrop rooms use 6..Ah. 0..4 *would* be used for x-ray, but x-ray uses $0ACE for the palette index instead
    $0A74: Samus suit palette index. Updated by $90:ECB6
    {
        0: No suit
        2: Varia suit
        4: Gravity suit
    }
    $0A76: Hyper beam flag
    $0A78: Time is frozen flag. Although two different bits are written, the variable is only ever checked for non-zero
    {
        1: X-ray is active
        8000h: Samus is dying or auto reserve tanks are active
    }

    $0A7A..93: X-ray RAM
    {
        $0A7A: X-ray state
        {
            0: No beam
            1: Beam is widening
            2: Full beam
            3..5: Various stages of deactivating beam (one frame each)
        }
        $0A7C: X-ray angular width delta
        $0A7E: X-ray angular subwidth delta
        $0A80: X-ray palette mode
        {
            0: Beam widening (palette transition)
            1: Full beam (palette cycle)
            FFFFh: Stop
        }
        $0A82: X-ray angle (clockwise, 40h = right, C0h = left)
        $0A84: X-ray angular width
        $0A86: X-ray angular subwidth
        $0A88..92: X-ray indirect HDMA table
    }
    $0A7A..93: Demo input RAM
    {
        $0A7A: Demo input pre-instruction
        $0A7C: Demo input instruction timer
        $0A7E: Demo input instruction list pointer
        $0A80: Demo input timer
        $0A82: Demo input initialisation parameter. Unused, as all demo input object initialisation functions are RTS
        $0A84: Demo input
        $0A86: Demo newly pressed input
        $0A88: Flag. 8000h enables demo input
        $0A8A: Recorded demo duration. If negative, demo is not being recorded. Number of frames of input recorded to bank $B8
        $0A8C: Previous demo input (during demo input processing)
        $0A8E: Previous demo newly pressed input (during demo input processing)
        $0A90: Backup of previous controller 1 input ($0DFE) during demo (actual hardware buttons, not game generated demo input)
        $0A92: Backup of previous newly pressed controller 1 input ($0E00) during demo (actual hardware buttons, not game generated demo input)
    }
    $0A88..92: Suit pickup indirect HDMA table. E4h,$9800, E4h,$98C8, 98h,$9990, 00h,00h

    $0A94: Samus animation frame timer
    $0A96: Samus animation frame. Indexes animation delay data ([$91:B010 + [Samus pose] * 2]), Samus spritemap table ($92:808D + [$92:9263/945D + [Samus pose] * 2]), tiles animation definitions ([$92:D94E + [Samus pose] * 2]), arm cannon drawing data ([$90:C7DF + [Samus pose] * 2] + 2/4)
    $0A98: Unused
    $0A9A: New pose Samus animation frame. If positive: Samus animation frame to use when Samus pose changes. If negative: Samus animation frame is preserved when Samus pose changes
    $0A9C: Samus animation frame buffer (added to $09A4 to get total animation delay). Used when Samus is in liquid (without gravity suit). 2 in lava/acid, 3 in water
    $0A9E: Grapple walljump timer. 30 frames
    $0AA0: Reached Ceres elevator fade timer. 60 frames
    $0AA2: Shinespark windup/crash timer. Crystal flash raise Samus timer
    $0AA4: Unused. Cleared by $90:A672 (enable horizontal slope detection), called only by unused transition poses 39h/3Ah/3Fh/40h. Never read
    $0AA6: Flag. Arm cannon is open / opening (else arm cannon is closed / closing)
    $0AA7: Flag. Arm cannon is opening/closing
    $0AA8: Arm cannon frame (0 = closed/none, 3 = fully open)
    $0AAA: Arm cannon toggle flag. 1 = toggle (set if HUD item changed this frame), 2 = otherwise
    $0AAC: Arm cannon drawing mode. Second byte of $90:C7DF table entries
    {
        0: Arm cannon isn't drawn
        1: Arm cannon is drawn normally
        2: Arm cannon is drawn behind Samus. Used by Samus is facing forward poses
    }
    $0AAE..CB: Speed echo variables
    {
        ; Speed boosting / shinesparking / speed echo projectiles
        {
            $0AAE: Speed echoes index (0/2). FFFFh when echoes merge back into Samus
            $0AB0: Speed echo 0 X position
            $0AB2: Speed echo 1 X position
            $0AB4: Speed echo 2 X position (speed echo projectiles)
            $0AB6: Speed echo 3 X position (speed echo projectiles)
            $0AB8: Speed echo 0 Y position
            $0ABA: Speed echo 1 Y position
            $0ABC: Speed echo 2 Y position (speed echo projectiles)
            $0ABE: Speed echo 3 Y position (speed echo projectiles)
            $0AC0: Speed echo 0 X speed
            $0AC2: Speed echo 1 X speed
            $0AC4: Draw speed echo 2 flag (speed echo projectiles)
            $0AC6: Draw speed echo 3 flag (speed echo projectiles)
            $0AC8: Samus' top half spritemap index
            $0ACA: Samus' bottom half spritemap index
        }

        ; Shinespark crash echo circle
        {
            $0AAE: Distance from Samus
            $0AAF: Shinespark crash echo circle phase
            $0AB0: Speed echo 0 X position
            $0AB2: Speed echo 1 X position
            $0AB4: Speed echo angle delta

            $0AB8: Speed echo 0 Y position
            $0ABA: Speed echo 1 Y position
            $0ABC: Shinespark crash echo circle timer

            $0AC0: Speed echo 0 angle during shinespark crash echo circle
            $0AC2: Speed echo 1 angle during shinespark crash echo circle
        }
    }
    $0ACC: Special Samus palette type. Index for $91:D72D.
    {
        0: Screw attacking / speed boosting
        1: Speed booster shine
        2: Unused. Causes misc. Samus palette handler to run twice
        6: Shinesparking
        7: Crystal flash
        8: X-ray
        9: Unused. Causes visor palette handler to take priority over beam effects
        Ah: Unused. Nothing
    }
    $0ACE:
    {
        Special Samus palette frame. Index used to get current Samus palette. Used for screw attack, speed boosting, speed booster shine, shinespark, crystal flash bubble
        X-ray palette index. Indexes $9B:A3C0 for Samus visor colour
        Rainbow Samus palette timer reset value
    }
    $0AD0:
    {
        X-ray palette timer
        Speed boosting palette timer
        Rainbow Samus palette timer
        Crystal flash Samus palette frame
    }
    $0AD2: Liquid physics type
    {
        0: Air
        1: Water
        2: Lava/acid
    }
    $0AD4..DB: Atmospheric graphics animation timers. 8000h behaves like 0. Otherwise, negative means "do nothing"
    $0ADC..E3: Atmospheric graphics X positions
    $0AE4..EB: Atmospheric graphics Y positions
    $0AEC..F3: Low byte: Atmospheric graphics animation frames. High byte: Atmospheric graphics types
    {
        1/2: Footstep splashes (uses slots 0/1 when running, uses slots 2/3 when landing)
        3: Diving splash (uses slot 0)
        4: Lava/acid surface damage (uses all slots)
        5: Bubbles (uses slot 2)
        6: Dust due to landing (uses slots 2/3). Also used for wall jump (slot 3 only)
        7: Dust due to speed boosting (uses slots 0/1)
    }
    $0AF4: Auto-jump timer. Counts the number of frames Jump is held, if Samus lands and 0 < timer < 9, the game adds the jump button as part of the changed input for the duration of $90:E926, which calls $91:8000 causing an auto-jump
    $0AF6: Samus X position
    $0AF8: Samus X subposition
    $0AFA: Samus Y position
    $0AFC: Samus Y subposition
    $0AFE: Samus X radius. Samus left boundary = [$0AF6] - [$0AFE], Samus right boundary = [$0AF6] + [$0AFE] - 1
    $0B00: Samus Y radius. Samus top boundary = [$0AFA] - [$0B00], Samus bottom boundary = [$0AFA] + [$0B00] - 1
    $0B02: Collision direction (direction of movement that causes collision)
    {
        0: Left
        1: Right
        2: Up
        3: Down

        Fh: Disables special air/block collisions. Used for wall-jump check (and collision detection due to change of pose for some reason)
    }
    $0B04: Samus spritemap X position ([$0AF6] adjusted for Ceres elevator - [$0911])
    $0B06: Samus spritemap Y position (([$0AFA] adjusted for Ceres elevator - [$0915]) adjusted for pose). High byte ignored
    $0B08: Unused
    $0B0A: Ideal layer 1 X position. [Samus' X position] - (camera distance)
    $0B0C: Unused
    $0B0E: Ideal layer 1 Y position. [Samus' Y position] - [up/down scroller]
    $0B10: Samus previous X position.    Updated at end of scrolling routine ($90:94EC). Used to calculate camera X speed
    $0B12: Samus previous X subposition. Updated at end of scrolling routine ($90:94EC)
    $0B14: Samus previous Y position.    Updated at end of scrolling routine ($90:94EC). Used to calculate camera Y speed
    $0B16: Samus previous Y subposition. Updated at end of scrolling routine ($90:94EC)
    $0B18: Charged shot glow timer
    $0B1A: Cleared when Samus lands, hits her head on the ceiling, or she hits a block while shinesparking. Never read
    $0B1C..1F: Unused
    $0B20: Morph ball bounce state
    {
        0: Not bouncing
        1: Morph ball - first bounce
        2: Morph ball - second bounce
        601h: Spring ball - first bounce
        602h: Spring ball - second bounce
    }
    $0B22: Flag. Samus is falling. Never read
    $0B24: Temporary in $92:8000 (set Samus tiles definitions for current animation). [[$D94E + [Samus pose] * 2] + [Samus animation frame] * 4 + 1]
    $0B26: Temporary in $92:8000 (set Samus tiles definitions for current animation). [[$D94E + [Samus pose] * 2] + [Samus animation frame] * 4 + 3]
    $0B28: Unused
    $0B2A: Set to 0 sometimes. Never read
    $0B2C: Samus Y subspeed
    $0B2E: Samus Y speed. Samus Y velocity for jump in ending sequence ($8B:F651). Allowed to become -1 via deceleration, which must be handled specially (e.g. bomb jump movement in $90:8F1B)
    $0B30: Unused
    $0B32: Samus Y subacceleration / shinespark Y subacceleration delta / shinespark X subacceleration
    $0B34: Samus Y acceleration (i.e. gravity) / shinespark Y acceleration delta / shinespark X acceleration
    $0B36: Samus Y direction
    {
        0: None. Set when grounded and in a handful of special cases (e.g. shinespark crash)
        1: Up
        2: Down
    }
    $0B38: Cleared when Samus lands after jumping or falling. If Samus is morphed and bounces, it only clears on the last bounce. Never read
    $0B3A: Unused
    $0B3C: Samus running momentum flag. Set when pressed run whilst running, cleared when releasing forward while running or stopped. Checked for speed boost counter processing, checked by snail collision, some other stuff
    $0B3E: Speed boost timer. If [speed boost counter] < 4: reset to 1, number of Samus run cycles before incrementing speed boost counter and playing speed booster sound effect. If [speed boost counter] = 4, reset to 2, AFAIK nothing special happens in this case
    $0B3F: Speed boost counter. 4 = speed boosting
    $0B40: Flag, Samus' echoes sound is playing.
    $0B42: Samus X extra run speed (due to holding the run button) / shinespark X speed. Set for vertical shinesparks too, but never read
    $0B44: Samus X extra run subspeed / shinespark X subspeed
    $0B46: Samus X base speed (due to general movement). A.k.a. 'momentum' (because it slows down gradually when you let go of forward when running and from grapple swing, but other times it doesn't work this way, like with damage boosting, wall jumping, failing mockball)
    $0B48: Samus X base subspeed. A.k.a. 'submomentum'
    $0B4A: Samus X acceleration mode
    {
        0: Accelerating (accelerating in the direction Samus is facing and moving)
        1: Turning around (accelerating in direction Samus is facing, but opposite the direction she's moving)
        2: Decelerating (accelerating opposite the direction Samus is facing/moving)
    }
    $0B4C: Samus X deceleration multiplier. Multiply deceleration by v/100h, 0 is treated as 100h. Set to 10h by unused ice physics air, otherwise always 0
    $0B4E..55: Unused
    $0B56: Extra Samus X subdisplacement
    $0B58: Extra Samus X displacement. Added after speed calculations ($0DBC)
    $0B5A: Extra Samus Y subdisplacement
    $0B5C: Extra Samus Y displacement. If non-zero: running on slopes doesn't push Samus down, bouncing Y movement doesn't happen
    $0B5E: Pose transition shot direction. High byte set indicates that a shot should be fired, low byte is as with $0C04. Set when turning out of moonwalk or pressing shoot while spin jumping with charge beam equipped
    $0B60: SBA angle delta. Used by ice/plasma SBA
    $0B62: Samus' charge palette index. Includes pseudo screw attack
    $0B64..77: Projectile X positions
    $0B78..8B: Projectile Y positions
    $0B8C..9F: Projectile X subpositions
    $0BA0..B3: Projectile Y subpositions
    $0BB4..C7: Projectile X radii
    $0BC8..DB: Projectile Y radii
    $0BDC..E5: Projectile X velocities (unit 1/100h px/frame). Distance from Samus for speed echoes / spazer/plasma SBA / end of ice SBA
    $0BE6..EF: Bomb X velocities (unit 1/100h px/frame). Uses sign-magnitude(!), i.e. MSb is used for direction, set = left, clear = right
    $0BF0..F9: Projectile Y velocities (unit 1/100h px/frame). SBA timer for wave/ice SBA. Angle delta for spazer SBA. Phase for plasma SBA
    $0BFA..0C03: Bomb Y velocities (unit px/frame). Standard twos complement unlike X velocity(!)
    $0C04..0D: Projectile directions
    {
        0: Up, facing right
        1: Up-right
        2: Right
        3: Down-right
        4: Down, facing right
        5: Down, facing left
        6: Down-left
        7: Left
        8: Up-left
        9: Up, facing left
        10h+: Delete projectile

        Graphically:
            9 0
          8     1
        7    #    2
          6     3
            5 4
    }
    $0C0E..17: Bomb directions. Cleared on bomb drop, checked by bomb spread (where it's always 0)
    $0C18..2B: Projectile types
    {
        $0C22: Main bomb in bomb spread

        ; Masked with Fh for beam type (corresponds to [equipped beams])
        ; Masked with 3Fh for cooldown table index in fire beam code and trail instruction list table index in spawn projectile code
        ; Masked with 20h in beam trail code to check for spazer SBA
        ; Masked with F00h for projectile type

        1: Wave / normal bomb explosion
        2: Ice
        4: Spazer
        8: Plasma
        10h: Charged

        24h: Spazer SBA trail
        25h: Unused projectile. Uses the ice + wave/spazer beam trail, has a hitbox half as wide as shinespark echo, damage = F000h...
        26h: Unused clone of 24h. Would occasionally have ice properties
        27h: Unused projectile (shinespark beam?)
        29h: Shinespark echo (behaves like plasma + wave sometimes)

        100h: Missile (corresponds to [HUD item index] * 100h)
        200h: Super missile (corresponds to [HUD item index] * 100h)
        300h: Power bomb
        400h: (Reserved for grapple beam according to $7E:7002)
        500h: Bomb
        600h: (Reserved for Samus contact according to $7E:7002)
        700h: Beam explosion
        800h: (Super) missile explosion

        1000h: Charge beam equipped
        8000h: Don't interact with Samus (bomb spread sets this bit, reflec/bang clear this bit)
    }
    $0C2C..3F: Projectile damages
    $0C40..53: Projectile instruction pointers
    {
        Instruction format:
            If t & 8000h = 0:
                tttt ssss xx yy ffff
                t: Timer
                s: Spritemap pointer
                x: X radius
                y: Y radius
                f: Projectile trail frame. Used to index beam trail offset table, see $9B:A4B3
            If p & 8000h != 0:
                pppp
                p: Pointer to function
    }
    $0C54..67: Projectile instruction timers
    $0C68..7B: Projectile pre-instructions
    {
        $0C72: Main bomb in bomb spread
    }
    $0C7C..85: Projectile variables
    {
        (Super) missile: High: projectile initialised flag. Low: if not initialised, extra base speed (set to F0h by projectile reflection)
        Super missile: Low: if initialised, super missile link index
        Super missile link: 0 (Lower Norfair pirate checks this)
        Ice/spazer/plasma SBA / speed echo: angle of projectile from Samus (unit 2pi / 100h radians, clockwise, 0 = up)
        Wave SBA: projectile Y velocity
    }
    $0C86..8F: Bomb timers. Set to FFFFh by power bomb when explosion is spawned
    $0C90..99: Projectile trail timers
    $0C9A..A3: Bomb Y subvelocities
    $0CA4..AD: Projectile phases. Used by spazer SBA
    {
        0: Circling
        2: Flying up towards point
        4: Flying up away from point
    }
    $0CAE..B7: Bomb bounce Y velocities
    $0CB8..CB: Projectile spritemap pointers
    $0CCC: Cooldown timer
    $0CCE: Projectile counter
    $0CD0: Flare counter (charging beam / firing hyper beam, firing grapple beam). Maxes out at 78h in both cases. Set to 8000h when firing hyper beam (which allows for hyper beam instant bomb spread)
    $0CD2: Bomb counter
    $0CD4: Bomb spread charge timeout counter. Bomb spread is automatically released after C0h frames (see $90:C0AB)
    $0CD6: Flare animation frame (charge beam / hyper beam / grapple beam)
    $0CD8: Flare slow sparks animation frame (charge beam / hyper beam)
    $0CDA: Flare fast sparks animation frame (charge beam / hyper beam)
    $0CDC: Flare animation timer (charge beam / hyper beam / grapple beam)
    $0CDE: Flare slow sparks animation timer (charge beam / hyper beam)
    $0CE0: Flare fast sparks animation timer (charge beam / hyper beam)
    $0CE2: Power bomb explosion X position (including when used to blow up Ceres station)
    $0CE4: Power bomb explosion Y position (including when used to blow up Ceres station)
    $0CE6: 100h + X position of power bomb on screen. High byte used to decide on-screen-ness: 0 = left of screen, 1 = on screen, 2 = right of screen, otherwise completely off-screen
    $0CE8: Power bomb explosion HDMA table index. 1FFh + Y position of screen on power bomb. Used to index indirect HDMA tables ($89:9800/A101)
    $0CEA: Power bomb explosion radius. Specifically X radius, Y radius is this * 3/4. Units of 1/100h px. Starts on 400h, ends on FA00h / 20B0h (for power bomb / crystal flash respectively)
    $0CEC: Power bomb pre-explosion flash radius. Specifically X radius, Y radius is this * 3/4. Units of 1/100h px. Starts on 400h, ends on F000h
    $0CEE: Power bomb flag (includes both unexploded bomb and explosion)
    {
        0: Power bomb is not active
        FFFFh: Power bomb is active
    }
    $0CF0: Power bomb (pre-)explosion radius speed. [$88:8DE7] = 30h is main radius acceleration, [$88:90DD] = 80h is pre explosion radius acceleration
    $0CF2: Pre-scaled power bomb explosion shape definition pointer. See $88:9246/9F06
    $0CF4: Grapple beam flags
    {
        1: Grapple beam liquid physics
        8000h: Grappling enemy
    }
    $0CF6: Grapple pose change auto-fire timer. Set to Ah upon firing
    $0CF8: Slow grapple scrolling flag. Screen scrolls at 3 pixels per frame. Enabled during grappling when speed is very low, disabled when grapple beam is newly shot.
    $0CFA: Grapple beam end angle. Angle to Samus from grapple beam. Unit pi/8000h radians. 0 = up, 4000h = right, 8000h = down, C000h = left
    $0CFC: Grapple beam end angle. Mirror of $0CFA. Used to index grapple swing Samus X/Y offsets table ($9B:C1C2)
    $0CFE: Grapple beam length. Unconnected grapple beam is cancelled after 80h. Connected grapple beam max length is 3Fh
    $0D00: Grapple beam length delta
    $0D02: Grapple beam origin X offset (relative to Samus' X position)
    $0D04: Grapple beam origin Y offset (relative to Samus' Y position)
    $0D06: Grapple beam end X subposition
    $0D08: Grapple beam end X position
    $0D0A: Grapple beam end Y subposition
    $0D0C: Grapple beam end Y position
    $0D0E: Grapple beam end X suboffset
    $0D10: Grapple beam end X offset (relative to grapple beam X origin)
    $0D12: Grapple beam end Y suboffset
    $0D14: Grapple beam end Y offset (relative to grapple beam Y origin)
    $0D16: Grapple beam start X position
    $0D18: Grapple beam start Y position
    $0D1A: Grapple beam flare X position
    $0D1C: Grapple beam flare Y position
    $0D1E: Off-screen x-ray / morph ball eye beam HDMA data table index in $91:C54B for beams that aim up-right / down-right. Cleared in grapple beam RAM clearing routines, never read
    $0D20: Cleared in grapple beam RAM clearing routines, never read
    $0D22: Grapple beam extension X subvelocity
    $0D23: Grapple beam extension X velocity
    $0D24: Grapple beam extension Y subvelocity
    $0D25: Grapple beam extension Y velocity
    $0D26: Grapple swing angular velocity. Unit pi/8000h radians. Positive = clockwise, negative = anticlockwise. Capped at ±480h
    $0D28: Grapple swing angular acceleration due to angle of swing (up-right = 6, down-right = 24, up-left = -6, down-left = -24, halved if liquid physics)
    $0D2A: Grapple swing angular acceleration due to button input (left = Ch, right = -Ch, halved if liquid physics)
    $0D2C: Grapple swing angular deceleration (due to angle of swing), applied to speed only when Samus is rising (up-right = 1, down-right = 5, up-left = -1, down-left = -5)
    $0D2E: Extra grapple swing angular velocity. Does not participate in the 480h speed cap. Unit pi/8000h radians. Positive = clockwise, negative = anticlockwise. Starts at ±300h
    $0D30: Grapple kick cooldown timer. Set to 10h when bouncing off a wall/ceiling
    $0D32: Grapple beam function
    {
        $C4F0: Inactive
        $C51E: Fire / go to cancel
        $C703: Firing
        $C759: Unused. Unfiring
        $C77E: Connected - locked in place
        $C79D: Connected - swinging
        $C814: Wallgrab
        $C832: Wallgrab release

        ; $C856+ are drawn without grapple beam (see $90:EB86)
        $C856: Cancel
        $C8C5: Dropped
        $C9CE: Walljumping
        $CB8B: Released from swing
    }
    $0D34: Direction grapple is fired
    {
        0: Up, facing right
        1: Up-right
        2: Right
        3: Down-right
        4: Down, facing right
        5: Down, facing left
        6: Down-left
        7: Left
        8: Up-left
        9: Up, facing left

        Graphically:
            9 0
          8     1
        7    #    2
          6     3
            5 4
    }
    $0D36: Special grapple beam angle handling flag. 8000h = enabled
    $0D38: Failed grapple swing movement counter in unused branch of $94:ACFE
    $0D3A: Set to 2 when starting grapple beam. Never read
    $0D3C: Cleared when starting grapple beam. Never read
    $0D3E: Grapple beam start animation timer
    $0D40: Grapple beam start animation tile pointer. Bank $9A. Set to $8200 when starting grapple beam
    $0D42..61: Grapple segment animation instruction timers
    $0D62..81: Grapple segment animation instruction list pointers
    {
        Instruction format:
            If t & 8000h = 0:
                tttt aaaa
                t: Timer
                a: Tile number and attributes
            If p & 8000h != 0:
                pppp
                p: Pointer to function
    }

    $0D82..9D: Grapple beam collision temporaries
    {
        $0D82:
        {
            Grapple beam X quarter-subvelocity in $94:A85B
            Jump address in $9B:B97C
            Grapple beam end angle * 2 parameter to $94:A957
        }
        $0D84:
        {
            Grapple beam X quarter-velocity in $94:A85B
            Distance from grapple beam end parameter to $94:A957
        }
        $0D86:
        {
            Grapple beam Y quarter-subvelocity in $94:A85B
            New grapple beam end angle * 2 in $94:ACFE
        }
        $0D88:
        {
            Grapple beam Y quarter-velocity in $94:A85B
            Target grapple beam end angle * 2 in $94:ACFE
        }
        $0D8A:
        {
            Loop counter in $94:A85B
            New grapple beam length in $94:AC31
        }
        $0D8C: Target grapple beam length in $94:AC31
        $0D8E: Samus front boundary offset from grapple beam start in $94:AC31
        $0D90: X position calculated by $94:A957
        $0D92: Y position calculated by $94:A957
        $0D94: X block calculated by $94:A957
        $0D96: Y block calculated by $94:A957
        $0D98: Distance of grapple swing collision from Samus' feet per $94:ABE6. Unit 8px

        $0D9C: Total grapple swing angular velocity in $94:ACFE
    }
    $0D82..8F: Wavy Samus BG3 X scroll indirect HDMA table
    $0D82..8F: Backup of controller bindings during intro

    $0D82: Backup of Samus X position in $90:8C1F when drawing Samus
    $0D84: Backup of Samus Y position in $90:8C1F when drawing Samus

    $0D9C..A1: Wavy Samus variables
    {
        $0D9C: Wavy Samus enable flag
        $0D9E: Wavy Samus amplitude
        $0DA0: Wavy Samus phase delta
    }
    $0DA0: Loop counter for transferring enemy tiles to VRAM

    $0DA2: Camera X speed (used only when camera is moving). Calculated from the absolute difference from Samus' previous and current position + 1 (but can be zero, see $90:96C0)
    $0DA4: Camera X subspeed
    $0DA6: Camera Y speed (used only when camera is moving). Calculated from the absolute difference from Samus' previous and current position + 1 (but can be zero, see $90:96FF)
    $0DA8: Camera Y subspeed. Absolute Y subdistance Samus moved last frame
    $0DAA: Distance Samus moved left (negative).    Used for projectile initial speed. Zero if moved right
    $0DAC: Subdistance Samus moved left (negative). Used for projectile initial speed. Zero if moved right
    $0DAE: Distance Samus moved right.              Used for projectile initial speed. Zero if moved left
    $0DB0: Subdistance Samus moved right.           Used for projectile initial speed. Zero if moved left
    $0DB2: Distance Samus moved up (negative).      Used for projectile initial speed. Zero if moved down
    $0DB4: Subdistance Samus moved up (negative).   Used for projectile initial speed. Zero if moved down
    $0DB6: Distance Samus moved down.               Used for projectile initial speed. Zero if moved up
    $0DB8: Subdistance Samus moved down. Never read (see $90:B1F3). Zero if moved up
    $0DBA: Flag. Samus position was adjusted by a slope. If set, Samus does *not* add $0DBC to the distance moved down when grounded (see $90:923F)
    $0DBC: Total Samus X speed. (base speed + run speed) / 2^(speed divisor), doesn't include distance moved due to $0B58
    $0DBE: Total Samus X subspeed
    $0DC0: Resume charging beam sound effect flag. If set, $90:F576 plays resume charging beam sound effect. Set when landing from damage boost
    $0DC2: Previous beam charge counter
    $0DC4: Current block index (nth block of the room)
    $0DC6: Samus solid vertical collision result. Something for setting Samus prospective pose ($0A28/$0A2E)
    {
        0: No change
        1: Landed. Samus collided with block or solid enemy during down movement ("down movement" as in $90:9440)
        2: Falling. Samus didn't collide with a block or solid enemy during down movement
        3: Unused. Hit a ceiling but don't kill Y speed?
        4: Hit ceiling. Samus collided with block or solid enemy during up movement ("up movement" as in $90:93EC)
        5: Wall jump triggered
        6: Unused
    }
    $0DC7: Samus downwards movement solid collision result. Used with $0DC6 = 1/2
    {
        If [$0DC6] = landed:
            0: Grounded (standing / running / crouching / knockback / moonwalking / ran into a wall)
            1: Morph ball grounded
            2: Unused (unused movement type 9)
            3: Spring ball grounded
            4: No change
            5: Unused

        If [$0DC6] = falling:
            0: Airborne (normal/spin/wall jumping / falling / knockback / damage boost)
            1: Morph ball airborne
            2: Unused (unused movement type 7)
            3: Spring ball airborne
            4: No change
    }
    $0DC8..CD: Unused
    $0DCE: Flag. Samus X speed killed due to collision (with block or solid enemy). 4 if collision direction is left, 8 if right, but only checked for non-zero
    $0DD0: Samus solid collision flag. Set to 0 in a bunch of places for no reason. Only checked for zero, but block and solid enemy collision are given distinct values
    {
        0: No collision
        1: Block collision (set by $94:971E/9763), checked to end shinespark
        FFFFh: Solid enemy collision (set by $90:9350/93B1/93EC/9440), checked to finish Samus drained movement / knockback / bomb jump / Ceres Ridley pushing, to kill Samus X speed, to set solid vertical collision result
    }
    $0DD2: Projectile proto type. Loaded from a proto weapon constants table at $90:C37B. Used in (power) bomb explosion block collision detection to determine if projectile is bomb or power bomb
    {
        0: Normal
        1: Wave beam
        2: Bomb
        3: Power bomb
        FFh: Invalid
    }
    $0DD4: Collision variable
    {
        Solid slope definition table base index in $86:85C2/8676 / $94:81B8/8230/8D2B/A66A/A71A / $A0:C32E/C3B2
        Samus left/right X offset in $94:8000
        Samus bottom/top Y offset in $94:80E0
        Target bottom/top Y offset in $86:874E / $94:86FE / $A0:C51F
        Y distance into slope in $94:87F4 / $A0:C8AD
        Multiplication counter in $86:853C / $94:9447
        Projectile Y offset in $94:A58F
    }
    $0DD6: Slope collision variable
    {
        Slope flip flags in $86:85C2/8676 / $94:81B8/8230/8D2B/A66A/A71A / $A0:C32E/C3B2
        Slope definition table base index in $86:874E / $94:8000/80E0/86FE/87F4/A58F / $A0:C51F/C8AD
    }
    $0DD8..DB: Unused
    $0DDC: Suit pickup light beam widening speed (or narrowing speed). Unit 1/100h px/frame
    $0DDE: Projectile index (FFFE for grapple)
    $0DE0: Debug invincibility. 7 = invincible. See debug.txt
    $0DE2..E9: Death animation variables
    {
        $0DE2: Death animation timer
        $0DE4: Death animation index
        $0DE6: Death animation counter
        $0DE8: Death animation pre-flashing timer
    }
    $0DE2: Game options menu index. On-boot Nintendo logo timer
    {
        0: Finish fading out
        1: Loading options menu
        2: Fading in options menu
        3: Options menu
        4: Start game
        5: Dissolve out screen
        6: Dissolve in screen
        7: Controller settings
        8: Special settings
        9: Scroll controller settings down
        Ah: Scroll controller settings up
        Bh: Transition back to file selection
        Ch: Fading out options menu to start game
    }

    $0DEA: Crystal flash ammo decrementing index. Used as jump target for unused game state 1Ch (see $91:D4DA), never set to a pointer by anything though
    {
        0: Missiles
        1: Super missiles
        2: Power bombs
    }

    $0DEC..F3: Ending clear time digits. Calculated by $8B:F3CE
    {
        $0DEC: Hours tens digit
        $0DEE: Hours units digit
        $0DF0: Minutes tens digit
        $0DF2: Minutes units digit
    }
    $0DEC..F3: Suit pickup variables
    {
        $0DEC: Suit pickup stage
        $0DEE:
        {
            Suit pickup light beam height (when appearing)
            Suit pickup light beam left/right positions. Low byte = left position, high byte = right position
            Suit pickup light beam top position (when shrinking)
        }
        $0DF0: Suit pickup colour math subscreen backdrop red component
        $0DF1: Suit pickup colour math subscreen backdrop green component
        $0DF2: Suit pickup colour math subscreen backdrop blue component
        $0DF3: Suit pickup palette transition colour. 0 = orange, 1 = blue
    }
    $0DEC..F3: Crystal flash variables
    {
        $0DEC: Crystal flash ammo decrementing timer (from 10 to 0)
        $0DEE: Cleared and then unused
        $0DF0: Crystal flash Samus Y position (after she's raised 14h pixels). Unsure of purpose
        $0DF2: Crystal flash Samus palette timer
    }

    $0DEC:
    {
        Shinespark Y acceleration
        Draygon-escape button counter (target is 60)
        Samus appears fanfare timer
        Debug death animation flag. Disables the white-out so that Samus suit explosion animation is unobscured
        Demo control flags
        {
            Set to 1 if pressed button to exit demos
            Set to 8000h if demo set has another scene remaining
        }
    }
    $0DEE:
    {
        Shinespark Y subacceleration
        Draygon-escape previous d-pad input
    }

    $0DF4: Debug. Spare CPU display flag. Toggled by Y whilst select + L is held
    $0DF6: Debug. Samus tile viewer flag. Toggled by B whilst select + L is held
    $0DF8: Unknown. Cleared at start. Read in $91:F50C (initialise Samus pose - running) for turning if in unused poses 45h/46h, otherwise unused.
    $0DFA: Cleared at start. OR'd with 1 sometimes, related to Samus' speed, shifted left by 8 every frame. Never read meaningfully
    $0DFC: Cleared at start. Cleared again when loading demo data. Never read
    $0DFE: Previous controller 1 input. Updated by $90:EAB3 (part of draw Samus / projectiles routine)
    $0E00: Previous newly pressed controller 1 input. Updated by $90:EAB3 (part of draw Samus / projectiles routine) and also $82:8AB0 (end of main game loop)
    $0E02: Samus bottom boundary position in $94:9B60 ([Samus Y position] + [Samus Y radius] - 1)
    $0E04: Distance to eject Samus left due to post grapple block collision. Never read
    $0E06: Distance to eject Samus right due to post grapple block collision. Never read
    $0E08: Distance to eject Samus up due to post grapple block collision. Used by $90:EF22 (post grapple collision detection)
    $0E0A: Distance to eject Samus down due to post grapple block collision. Tested by $90:EF22 (post grapple collision detection), never used for ejection
}
$0E0C..108B: Ending shooting stars. 10h byte entries
{
    + 0: Star index
    + 1: Animation frame. Range 0..26h, 8+ are all the same. If 80h, star isn't drawn and doesn't move, i.e. a delay period
    + 2: X position
    + 4: X subposition
    + 6: Y position
    + 8: Y subposition
    + Ah: Animation timer
    + Ch: X velocity. Unit 1/100h px/frame
    + Eh: Y velocity. Unit 1/100h px/frame
}

$0E0C..11: Unused
$0E12: Debug. Disable sprite interactions (bomb jumps, enemy and enemy projectile collision (including power bombs))
$0E14: Unused
$0E16: Elevator properties
{
    1: Samus is standing on elevator
    80h: Door is an elevator (same as $0793)
}
$0E18: Elevator status
{
    0: Inactive
    1: Leaving the room
    2: Room transition
    3: Entering the room
}
$0E1A: Health drop bias flag. Set if drop at health below 30, cleared if health at least 50.
$0E1C: Enemy index to shake (due to walljump whilst frozen). FFFFh = no enemy to shake
$0E1E: Flag. Request enemy BG2 tilemap VRAM transfer. BG2 tilemap is at $7E:2000, also see extended tilemap format in "Enemy RAM.asm"
$0E20..41: Enemy temporaries
{
    $0E20:
    {
        Demo recorder frame counter X position
        Enemy projectile position on screen in $86:E6E0
        Enemy projectile X radius in $86:EFE0 / $A0:9894
        Enemy bank in $A0:8D64
        Enemy population data pointer in $A0:92DB
        Enemy Y position on screen in $A0:944A
        Enemy death explosion type in $A0:A3AF/A410
        Absolute X distance from enemy to Samus in $A0:ACA8
        Threshold in $A0:AEED/AF0B
        Angle in $A0:B691
        Enemy debugger hex value X position in $B4:9F7E
    }
    $0E22:
    {
        Demo recorder frame counter Y position
        Enemy projectile Y radius in $86:EFE0 / $A0:9894
        Loop counter in $A0:9275
        Enemy X position on screen in $A0:944A
        Absolute Y distance from enemy to Samus in $A0:ACA8
        Swoop Y speed in $A5:8817
        Enemy debugger hex value Y position in $B4:9F7E
    }
    $0E24:
    {
        Demo recorder frame counter
        Enemy header pointer in $86:EF29
        Angle from enemy to Samus reflected to down-right quadrant in $A0:ACA8
        X speed in $A0:B691
        X velocity in $A3:89F3/C716
        Swoop Y position in $A5:8817
        Possibly erroneous X velocity in $A5:9FE0
        Enemy debugger hex value in $B4:9F7E
    }
    $0E26:
    {
        Number of enemy parts to spawn in $A0:92DB
        x²/r in $A0:ACA8
        X subspeed in $A0:B691
        Swoop Y position index in $A5:8817
        Enemy set entry pointer in $B4:94D5/9758
    }
    $0E28:
    {
        Enemy header pointer in $86:F106 (never read)
        Y speed in $A0:B691
        180h in $A5:8817 (never read)
    }
    $0E2A:
    {
        Y subspeed in $A0:B691
        [Enemy projectile $7E:F410] & 7FFFh in $86:F106. Never read
        Metaree particle VRAM tiles index in $A3:8B0F
        Row Y position in $B4:94D5/9758
    }
    $0E2C:
    {
        Metaree particle palette index in $A3:8B0F
        Rows of VRAM in $B4:9758
    }
    $0E2E:
    {
        Enemy hit flag in normal enemy shot AI
        Loop counter in $A0:8D64
    }
    $0E30: Unused
    $0E32:
    {
        Enemy layer in $A0:884D
        Enemy damage multiplier in $A0:A4A1/A5C1/A6DE
        Right/bottom boundary position + 1 in $A0:A8F0
        Enemy X position in $A0:ACA8
        Operand in $A0:AFEA/B07D
        Absolute value in $A0:B067
        Magnitude in $A0:B0DA / $A8:89D4
        Some index in $A3:DC1C
        Target Y position in $A3:EB98/EDEB/EECE/EF07
        Something in $A8:A742
        Spit projectile speed in $B3:9EE0/9F34
    }
    $0E34:
    {
        Enemy drawing queue index in $A0:9423
        Enemy Y position in $A0:ACA8
        Absolute difference in $A0:B07D
        Angle in $A0:B0DA
    }
    $0E36:
    {
        Enemy drawing queue size backup in $A0:884D
        Samus X position in $A0:ACA8
        Sine product in $A0:B0DA
        Target position in $A3:DC1C
    }
    $0E38:
    {
        Enemy drawing queue index in $A0:884D
        Samus Y position in $A0:ACA8
        Sine product fractional part in $A0:B0DA
    }
    $0E3A:
    {
        Enemy drawing queue address in $A0:884D
        Angle from enemy to Samus in $A0:ACA8
    }
    $0E3C: X distance from enemy to Samus in $A0:ACA8
    $0E3E: Y distance from enemy to Samus in $A0:ACA8
    $0E40:
    {
        Enemy beam vulnerability in $A0:A6DE
        Enemy contact vulnerability in $A0:A4A1
    }
}
$0E42: Unused
$0E44: Number of times main enemy routine has been executed. Actually used by some enemies (e.g. mochtroid / Crocomire uses it for hurt timing, so does Mother Brain during rainbow beam)
$0E46: Number of times $A0:8EB6 (determine which enemies to process) has been executed. Never read
$0E48: Set to 0 when enemies are initialised (if there are enemies in the room). Never read
$0E4A: New enemy index (when spawning an enemy)
$0E4C: First unused enemy index. Written as an enemy index by enemy initialisation routine ($A0:8A9E), but only checked for non-zero by main enemy routine ($A0:8FD4). If zero, main enemy routine skips enemy processing
$0E4E: Number of enemies in the room. Never read
$0E50: Number of enemies killed in the current room.
$0E52: Number of enemy deaths needed to clear current room
$0E54: Enemy index
$0E56: Backup of enemy index when spawning new enemy
$0E58: Enemy data pointer ($0F78 + [enemy index]). Never read
$0E5A..75: Enemy tile data loading data. 7 byte slots. Used by $A0:8C6C (load enemy tile data) when loading game
{
    + 0: Enemy tile data size & 7FFFh
    + 2: Enemy tile data pointer
    + 5: Offset into $7E:7000 to load enemy tile data
}
$0E76..79: Unused
$0E7A: Stack pointer for enemy tile data loading data
$0E7C: Enemy tiles VRAM update source address. Bank $7E
$0E7E: Enemy tiles VRAM update destination address
$0E80..83: Unused
$0E84..0F67: Enemy drawing queues (list of enemy indices), increasing priority
{
    $0E84..A3: Layer 0 (enemies from here onwards are drawn over sprite objects, projectile explosions, and low priority enemy projectiles)
    $0EA4: Layer 1
    $0EA6..C5: Layer 2
    $0EC6: Layer 3 (enemies from here onwards are drawn over Samus and projectiles)
    $0EC8..E7: Layer 4
    $0EE8..0F27: Layer 5
    $0F28..47: Layer 6 (enemies from here onwards are drawn over high priority enemy projectiles)
    $0F48..67: Layer 7
}
$0F68..77: Sizes of enemy drawing queues
$0F78..1777: Enemy data. See "enemy data.txt" from lua repo, "Enemy RAM.asm"
{
	$0F78..B7: Enemy 0
    {
        $0F78: ID
        $0F7A: X position
        $0F7C: X subposition
        $0F7E: Y position
        $0F80: Y subposition
        $0F82: X radius
        $0F84: Y radius
        $0F86: Properties (Special in SMILE)
        $0F88: Extra properties (special GFX bitflag in SMILE)
        $0F8A: AI handler
        $0F8C: Health
        $0F8E: Spritemap pointer
        $0F90: Timer
        $0F92: Initialisation parameter (Orientation in SMILE, Tilemaps in RF) / instruction list pointer
        $0F94: Instruction timer
        $0F96: Palette index
        $0F98: VRAM tiles index
        $0F9A: Layer
        $0F9C: Flash timer
        $0F9E: Frozen timer
        $0FA0: Invincibility timer
        $0FA2: Shake timer
        $0FA4: Frame counter
        $0FA6: Bank
        $0FA8: AI variable, frequently function pointer
        $0FAA: AI variable
        $0FAC: AI variable
        $0FAE: AI variable
        $0FB0: AI variable
        $0FB2: AI variable
        $0FB4: Parameter 1 (Speed in SMILE)
        $0FB6: Parameter 2 (Speed2 in SMILE)
    }
	$0FB8..F7: Enemy 1
	$0FF8..1037: Enemy 2
	$1038..77: Enemy 3
	$1078..B7: Enemy 4
	$10B8..F7: Enemy 5
	$10F8..1137: Enemy 6
	$1138..77: Enemy 7
	$1178..B7: Enemy 8
	$11B8..F7: Enemy 9
	$11F8..1237: Enemy Ah
	$1238..77: Enemy Bh
	$1278..B7: Enemy Ch
	$12B8..F7: Enemy Dh
	$12F8..1337: Enemy Eh
	$1338..77: Enemy Fh
	$1378..B7: Enemy 10h
	$13B8..F7: Enemy 11h
	$13F8..1437: Enemy 12h
	$1438..77: Enemy 13h
	$1478..B7: Enemy 14h
	$14B8..F7: Enemy 15h
	$14F8..1537: Enemy 16h
	$1538..77: Enemy 17h
	$1578..B7: Enemy 18h
	$15B8..F7: Enemy 19h
	$15F8..1637: Enemy 1Ah
	$1638..77: Enemy 1Bh
	$1678..B7: Enemy 1Ch
	$16B8..F7: Enemy 1Dh
	$16F8..1737: Enemy 1Eh
	$1738..77: Enemy 1Fh
}
$1778: Fireflea flashing timer. Reset to 6
$177A: Fireflea flashing index. Cycles within range 0..Bh
$177C: Initialised to 0 by fireflea FX. Otherwise unused
$177E: Fireflea darkness level. Multiple of 2, range 0..Ah. Value of Ah stops the flashing
$1780: Initialised to 18h by fireflea FX. Otherwise unused
$1782: Initialised to 0 by fireflea FX. Otherwise unused
$1784: Enemy AI pointer (3 bytes)
$1788: Backup of enemy AI pointer when spawning new enemy
$178C: Enemy graphics drawn hook (3 bytes). Executed after drawing Samus, projectiles, enemies and enemy projectiles
{
    Set to $A3:DB0C by reflec (periodically cycle between palettes)
    Set to $A5:9342 by Draygon (set BG2 X/Y scroll)
    Set to $A6:A2F2 by Ceres Ridley (draw Baby Metroid and door)
    Set to $A8:B0B2 by magdollite (periodically cycle between palettes)
    Set to $A8:CC67 by work robot (periodically cycle between palettes)
    Set to $A8:E86E by blue Brinstar face block when Samus has morph ball (periodically cycle between palettes)
    Set to $A9:87C9/87DD by Mother Brain (draw brain and neck)
    Set to $A9:D39A by torizo corpse
}
$1790: 3 byte pointer. Set to RTL when loading enemies, otherwise unused
$1794: Enemy palette cycle enemy palette index. Multiple of 20h. Reflec and blue Brinstar face block use base address $7E:C100, magdollite uses $7E:C000...
$1796: Enemy palette cycle colour set index
$1798: Enemy palette cycle timer
$179A: Enemy BG2 tilemap size
$179C: Boss ID. Used by $90:A7E2 for table that determines how to mark boss room as explored. Used in $91:D143 to check if x-ray should be disabled
{
    0: None
    1: Ceres Ridley
    2: Torizo
    3: Kraid
    4: Spore Spawn
    5: Ridley
    6: Crocomire
    7: Phantoon
    8: Draygon
    9: Botwoon
    Ah: Mother Brain
}
$179E: Cleared when loading enemies, set to 10h by Crocomire, otherwise unused
$17A0: Cleared when loading enemies, otherwise unused
$17A2: Disables drawing of enemies. Cleared during main enemy routine, never set
$17A4: Active enemy indices stack pointer
$17A6: Interactive enemy indices stack pointer
$17A8: Active enemy indices index
$17AA: Interactive enemy indices index
$17AC..EB: Active enemy indices, FFFFh terminated
$17EC..182B: Interactive enemy indices, FFFFh terminated
$182C: Enemy index when Samus moving left collides with solid enemy. FFFFh for no collision. Used by shutters and corpse enemies
$182E: Enemy index when Samus moving right collides with solid enemy
$1830: Enemy index when Samus moving up collides with solid enemy
$1832: Enemy index when Samus moving down collides with solid enemy
$1834: Distance between Samus and enemy when Samus moving left collides with solid enemy. Never read
$1836: Distance between Samus and enemy when Samus moving right collides with solid enemy. Never read
$1838: Distance between Samus and enemy when Samus moving up collides with solid enemy. Never read
$183A: Distance between Samus and enemy when Samus moving down collides with solid enemy. Never read
$183C: Global off-screen enemy processing flag. Set by Draygon and Spore Spawn for some reason
$183E: Earthquake type. Range 0..23h. 14h (BG1, BG2 and enemies, 1 pixel displacement, diagonal) knocks small enemies off walls (set by super missiles ($93:8125), also during Ceres escape ($A6:F76B))
{
    Earthquake type = d + 3i + 9l where:
        d (direction):
            0: Horizontal shaking. Enemy shaking is always horizontal (unlike enemy projectiles)
            1: Vertical shaking
            2: Diagonal shaking
        i (intensity):
            0: 1 pixel displacement. Enemy shaking is always 1 pixel displacement (unlike enemy projectiles)
            1: 2 pixel displacement
            2: 3 pixel displacement
        l (layers):
            0: BG1 only
            1: BG1 and BG2
            2: BG1, BG2 and enemies. Includes enemy projectiles
            3: BG2 only and enemies. Includes enemy projectiles

    Python snippet:
        ; print(f'Earthquake type = {["BG1 only", "BG1 and BG2", "BG1, BG2 and enemies", "BG2 only and enemies"][t // 9]}, {t // 3 % 3 + 1} pixel displacement, {["horizontal", "vertical", "diagonal"][t % 3]}')
}
$1840: Earthquake timer
$1842: Number of times $A0:8687 (handle room shaking) has been executed. Never read
$1844: Sprite object index
$1846: Debug enemy index (for enemy debugger)
$1848: Debug enemy log index for unused function $A0:918B
$184A: Samus X position when Samus collides with solid enemy. Never read
$184C: Samus X subposition when Samus collides with solid enemy. Never read
$184E: Enemy X position when Samus collides with solid enemy. Never read
$1850: Enemy X subposition when Samus collides with solid enemy. Never read
$1852: Samus position delta when Samus collides with solid enemy. Never read
$1854: Samus subposition delta when Samus collides with solid enemy. Never read
$1856: Samus Y position when Samus collides with solid enemy. Never read
$1858: Samus Y subposition when Samus collides with solid enemy. Never read
$185A: Solid enemy collision type. Never read. Debug spritemap palette bits in sprite tiles viewer (0 means use palette defined in spritemap)
{
    1: Samus and the enemy were touching (Samus [$0B02] boundary = opposite enemy boundary)
    2: Samus and the enemy were not touching
    3: Unused. Samus and the enemy were overlapping. Set by unused branch $A0:AB84. Enable by NOPing $A0:AB81, has glitchy effects when freezing enemy whilst inside hitbox.
}
$185C: Debug index (bank $B4). See "debug.txt"
{
    0: Default
    1: Palette viewer - sprite palettes
    2: Palette viewer - BG palettes. Overwrites/destroys sprite palettes and sprite tiles $7000..77FF
    3: Sprite tiles viewer - 2nd half
    4: Sprite tiles viewer - 1st half
    5: Enemy debugger - initialise. Loads debugger font and moves on to debug index 6
    6: Enemy debugger - enemy mover
    7: Enemy debugger - enemy spawn data editor
    8: Enemy debugger - respawn enemy. Moves on to debug index 0
    9: Enemy debugger - enemy spawner
    Ah: Enemy debugger - RAM viewer - page 0
    Bh: Enemy debugger - RAM viewer - page 1
    Ch: Enemy debugger - RAM viewer - page 2
    Dh: Enemy debugger - RAM viewer - page 3
    Eh: Enemy debugger - RAM viewer - page 4
    Fh: Enemy debugger - RAM viewer - page 5
    10h: Enemy debugger - enemy allocation viewer
}
$185E: Debug. Time is frozen for enemies (a la $0A78)
$1860: Debug. Text cursor X position
$1862: Debug. Text cursor Y position
$1864: Debug enemy set entry index
$1866: Debug enemy population pointer / previous controller 2 input for debug Draygon mover
$1868: Debug enemy spawn X position
$186A: Debug enemy spawn Y position
$186C: Unused
$186E: Enemy spritemap entry pointer during enemy collision handling with Samus/projectiles
$1870: Enemy left boundary for enemy / projectile collisions
$1872: Enemy bottom boundary for enemy / projectile collisions. Direction of Samus from enemy in a bang subroutine ($A3:BBEB)
$1874: Enemy right boundary for enemy / projectile collisions
$1876: Enemy top boundary for enemy / projectile collisions
$1878: Enemy hitbox entry pointer during enemy collision handling with Samus/projectiles
$187A: Enemy spritemap entry X position during enemy collision handling with Samus/projectiles. Power bomb damage in normal enemy power bomb AI. Projectile damage in normal enemy shot AI
$187C: Enemy spritemap entry Y position during enemy collision handling with Samus/projectiles.
$187E: Samus right boundary for enemy / Samus collisions
$1880: Samus left boundary for enemy / Samus collisions
$1882: Samus bottom boundary for enemy / Samus collisions
$1884: Samus top boundary for enemy / Samus collisions
$1886..99: Unused
$189A: Samus' target X position in $A0:A8F0 (Samus / solid enemy collision detection). [Samus X position] adjusted by [$12].[$14] (+ 1 if new X subposition is 0(!))
$189C: Samus' target X subposition in $A0:A8F0 (Samus / solid enemy collision detection)
$189E: Samus' target Y position in $A0:A8F0 (Samus / solid enemy collision detection). [Samus Y position] adjusted by [$12].[$14] (+ 1 if new Y subposition is 0(!))
$18A0: Samus' target Y subposition in $A0:A8F0 (Samus / solid enemy collision detection)
$18A2: Mirror of Samus' X radius ($0AFE) during Samus / solid enemy collision detection
$18A4: Mirror of Samus' Y radius ($0B00) during Samus / solid enemy collision detection
$18A6: Collision index. Used notably for collided projectile index in enemy shot reaction, and otherwise for loop variables
{
    Projectile index / 2 in projectile / enemy collision handling (including Kraid's mouth's custom collision detection)
    Projectile index / 2 in projectile / Samus interaction
    Enemy projectile index in enemy projectile / Samus collision handling
    Enemy projectile index in enemy projectile / projectile collision handling
    Enemy index in solid enemy / Samus collision detection
}
$18A8: Samus invincibility timer
$18AA: Samus knockback timer
$18AC: Projectile invincibility timer (prevents bomb jump and damage from reflected projectiles). Set to 10 by shooting beam, 20 by shooting missile
$18AE: Flag. Disable Samus / projectile interaction if non-zero. Always 0
$18B0: HDMA objects enable flag. 8000h = enabled. Power bombs not affected
$18B2: HDMA object index
$18B4..BF: HDMA object channel bitflags. 1 << HDMA channel, (HDMA channels start at 2)
$18C0..CB: Low bytes: HDMA object channel indices. HDMA channel * 10h, (HDMA channels start at 2). High bytes: HDMA object banks
$18CC..D7: HDMA object instruction list pointers
$18D8..E3: HDMA object table pointers
$18E4..EF: HDMA object instruction timers
$18F0..FB: HDMA object pre-instructions
$18FC..1907: Low bytes: HDMA object pre-instruction banks
$1908..13: Low bytes: HDMA object timers
$1914..1F: HDMA object variables. Cleared when HDMA object spawned
{
    Wave phase for wavy Phantoon. Multiple of 2
    Wave phase for wavy Samus. Multiple of 2
    BG3 Y offset for rain. Unit 1/100h px
    BG3 Y offset for fog. Unit 1/100h px
    Backup BG2 X scroll for x-ray
    Wave phase for wavy lava/acid. Multiple of 2
    Wave phase for water. Multiple of 2
    Unused wave phase for spores. Multiple of 2
    BG2 Y suboffset for Tourian entrance statue
    Max colour intensity for haze
    Colour index for rainbow beam
    Red/green colour components for morph ball eye beam
}
$1920..2B: HDMA object variables. Cleared when HDMA object spawned
{
    Phase increase timer for wavy Phantoon
    Phase increase timer for wavy Samus
    BG3 X offset for rain. Unit 1/100h px
    BG3 X offset for fog. Unit 1/100h px
    Backup BG2 Y scroll for x-ray
    Phase decrease timer for wavy lava/acid
    Phase increase timer for water
    Unused phase increase timer for spores
    BG2 Y offset for Tourian entrance statue
    Colour component flags for haze
    Blue colour component for morph ball eye beam
}
$192C..37: HDMA object variables. Cleared when HDMA object spawned
{
    Backup BG2 tilemap base address and size for x-ray
    BG3 X offset for water. Unit 1/100h px
    BG3 Y offset for spores. Unit 1/100h px
    Descent delay timer for Tourian entrance statue
    Angular width for morph ball eye beam
}
$1938..43: HDMA object variables. Cleared when HDMA object spawned
{
    BG3 X velocity for rain
    Power bomb explosion after-glow animation frame
    BG3 X offset for spores. Unit 1/100h px
    Angular subwidth for morph ball eye beam
}
$1944..4F: HDMA object variables. *Not* cleared when HDMA object spawned
{
    Previous layer 1 Y position for rain
}
$1950..5B: HDMA object variables. *Not* cleared when HDMA object spawned
{
    Previous layer 1 X position for rain
}
$195C: FX Y subposition
$195E: FX Y position. Negative = disabled. Used as water Y position if water physics are enabled ($197E)
$1960: Lava/acid Y subposition
$1962: Lava/acid Y position. Negative = disabled
$1964: FX tilemap pointer (bank $8A)
$1966: Current FX entry pointer
$1968: Current FX entry offset ([$07CD] + [$1968] = [$1966])
$196A: Current FX palette FX / animated tiles bitset (LSR'd out during FX loading). See "Palette FX by room.asm" / "Animated tiles by room.asm"
$196C: FX rising function. Bank $88
{
    $B343: Used by lava / acid, handles lavaquake
    $C428: Used by water / Tourian entrance statue
}
$196E: FX type
{
    0: None
    2: Lava
    4: Acid
    6: Water
    8: Spores
    Ah: Rain
    Ch: Fog
    20h: Unused. Scrolling sky
    22h: Unused
    24h: Fireflea
    26h: Tourian entrance statue
    28h: Ceres Ridley
    2Ah: Ceres elevator
    2Ch: Haze (used in Ceres via room setup ASM)
}
$1970: FX Y suboffset ([$195C] = [$1976] + [$1970])
$1972: FX Y offset ([$195E] = [$1978] + [$1972])
$1974: Tide phase (units of pi/8000h radians)
$1976: FX base Y subposition
$1978: FX base Y position. Same as lava/acid Y position for lava/acid
$197A: FX target Y position
$197C: FX Y subvelocity
$197D: FX Y velocity
$197E: FX liquid options (FX C)
{
    1: Liquid flows (leftwards)
    2: If acid/lava: layer 2 is vertically wavy. If water: layer 2 is horizontally wavy
    4: If acid/lava: layer 2 is horizontally wavy (unused). If water: liquid physics are disabled (used in n00b tube room and elevatube)
    8: Used by a bunch of rooms (see "FX entries by FX C.asm") but has no effect
    40h: Big tide (liquid fluctuates up and down, a la the gauntlet)
    80h: Small tide (liquid fluctuates up and down)
}
$1980: FX timer
$1982: Default layer blending configuration (FX A)
$1984: FX layer 3 layer blending configuration (FX B)
$1986: Layer blending configuration
{
    0/2/Eh/20h: Normal
    4: Phantoon - hidden (BG2 disabled)
    6: Semi-transparent sprites on BG1/BG2 (unused)
    8: Coven (semi-transparent sprites on BG2)
    Ah: Spores (BG3 hidden by BG1)
    Ch: Fireflea (BG3 disabled, BG2 dimmed by subscreen backdrop)
    10h/12h: Subscreen backdrop window (BG3 disabled, colour math disabled outside window 1)
    14h/22h: Water - dimmed by BG3
    16h: Water - background waterfalls (dimmed by BG2/BG3)
    18h/1Eh/30h: Colour math affects all sprite palettes (semi-transparent BG1/BG2/sprites on BG3)
    1Ah: Phantoon - semi-transparent (semi-transparent BG2 on BG1)
    1Ch: Semi-transparent BG2 on semi-transparent BG1/BG3/sprites (unused)
    24h: Mother Brain rainbow beam (BG3 disabled, colour math disabled outside window 1)
    26h: Semi-transparent BG3 on semi-transparent BG1/BG2/sprites (unused)
    28h: Red desaturation (BG3 disabled, dimmed by red subscreen backdrop)
    2Ah: Orange desaturation (BG3 disabled, dimmed by orange subscreen backdrop)
    2Ch: Haze (BG3 disabled)
    2Eh: Dimmed by BG3 (unused)
    32h: Dimmed by BG3, BG3 hidden by BG1 (unused)
    34h: Mother Brain phase 2 (power bomb explosion doesn't affect BG2)
}
$1987: Layer blending window 2 configuration
{
    0: None
    10h: X-ray active and FX type = fireflea
    20h: X-ray active and can't show blocks (and FX type != fireflea)
    40h: X-ray active and can show blocks (and FX type != fireflea)
    80h: Power bomb explosion active
}
$1988: Phantoon semi-transparency flag. If 4000h bit set, changes layer blending configuration to 1Ah (semi-transparent BG2 on BG1)
$198A..8C: Unused
$198D..1C1E: Enemy projectile data. 12h enemy projectiles max
{
    $198D: Flag. 8000h enables enemy projectiles

    $1991: Enemy projectile index
    $1993: Enemy projectile initialisation parameter 0
    $1995: Enemy projectile initialisation parameter 1. Used by Draygon's gunk, Ridley's fireball, and polyp
    $1997..BA: Enemy projectile IDs
    $19BB..DE: Enemy projectile graphics indices. Low: VRAM graphics index. High: palette index (OR'd with spritemap palette)
    $19DF..1A02: Enemy projectile timers (according to instructions $81C6/$81CE/$81D5)
    {
        Used as target Y position in $86:8A7D
        Shot gate segment distance moved. Unit 1/100h px
    }
    $1A03..26: Enemy projectile pre-instructions
    $1A27..4A: Enemy projectile X subpositions
    {
        Mother Brain's room turrets allowed rotations pointer
        Mother Brain's bomb number of afterburn enemy projectiles
    }
    $1A4B..6E: Enemy projectile X positions
    $1A6F..92: Enemy projectile Y subpositions
    {
        Low: Mother Brain's room turrets direction index
        High: Mother Brain's room turrets direction index delta
    }
    $1A93..B6: Enemy projectile Y positions
    $1AB7..DA: Enemy projectile X velocity (unit 1/100h px/frame) for enemy projectiles that move with $86:88B6
    {
        Crocomire spike wall pieces / dragon fireball / Tourian statue unlocking particle / polyp X velocity (unit 1/100h px/frame)
        Phantoon flame rain fall timer
        Phantoon starting flame contract timer
        Phantoon destroyable enraged flame angle delta
        Botwoon's body function
        Botwoon spit X speed
        Draygon goop X speed
        Mini-Crocomire projectile / namihe/fune fireball / lava thrown by magdollite right X velocity (unit 1/100h px/frame)
        Mother Brain's room turrets rotation timer
        Mother Brain's rainbow beam explosion X offset
        n00b tube shard / released air bubbles falling angle * 2
        Cacatac spike speed (unit 1/100h px/frame)
        Falling spark Y subvelocity
    }
    $1ADB..FE: Enemy projectile Y velocity (unit 1/100h px/frame) for enemy projectiles that move with $86:897B
    {
        Dragon fireball / Tourian statue's soul / Tourian statue unlocking particle / shot gate Y velocity (unit 1/100h px/frame)
        Botwoon's body falling time counter
        Botwoon spit Y speed
        Phantoon flame radius from Phantoon
        Draygon goop Y speed
        Mini-Crocomire projectile / namihe/fune fireball / lava thrown by magdollite left X velocity (unit 1/100h px/frame)
        Crocomire spike wall pieces / falling spark Y velocity (unit px/frame)
        Polyp Y speed table index
        Mother Brain's room turrets cooldown timer
        Mother Brain's rainbow beam explosion Y offset
        Cacatac spike negated speed (unit 1/100h px/frame)
    }
    $1AFF..1B22: Enemy projectile variables
    {
        Eye door projectile angle to Samus * 2
        Botwoon's body instruction list table index
        Botwoon's body pre-fall wait counter
        n00b tube crack on-screen X position
        n00b tube shard / released air bubbles on-screen X subposition
        Phantoon flame angle from Phantoon
        Phantoon destroyable flame function timer
        Phantoon destroyable casual flame bounce counter
        Ceres elevator pad timer
        Botwoon spit X subspeed
        Draygon goop X subspeed / life timer
        Mini-Crocomire projectile function
        Crocomire spike wall pieces X acceleration (unit 1/10000h px/frame^2)
        Unused enemy projectile $9634 movement delay timer
        Afterburn remaining afterburn enemy projectiles
        Space pirate / Mother Brain laser half-speed flag
        Space pirate claw X speed
        Bomb Torizo explosion / torizo sonic boom / Tourian statue dust clouds reset X position
        Old Tourian escape shaft fake wall explosion reset X position (unused)
        Golden Torizo egg direction. 8000h = rightwards, 0 = leftwards
        Golden Torizo super missile enemy index
        Tourian statue unlocking particle angle * 2
        Tourian statue - Ridley / Phantoon / base decoration X position mirror
        Polyp rocks function
        Mother Brain's room turret bullets direction index
        Mother Brain's blue ring lasers initial delay timer
        Mother Brain's bomb post-bounce X speed
        Mother Brain's drool attached position offset index
        Mother Brain's exploded escape door particles delete timer
        Mother Brain's tube falling function
        Mother Brain's glass shattering - shard angle * 2
        Kago bug sound effect timer
        Powamp spike / cacatac spike direction
        Spore movement table index
        Namihe/fune fireball / lava thrown by magdollite function
        Shot gate PLM block index
        Falling spark X subvelocity
        Pickup type. 2 = small health, 4 = big health, 6 = power bombs, 8 = missiles, Ah = super missiles
    }
    $1B23..46: Enemy projectile variables
    {
        n00b tube shard / released air bubbles on-screen X position
        Botwoon's body instruction list
        Botwoon spit Y subspeed
        Bomb Torizo statue breaking Y acceleration (unit 1/100h px/frame²)
        Draygon goop Y subspeed / Y offset
        Crocomire spike wall pieces Y subvelocity
        Ridley's fireball afterburn flag. 0 = spawn afterburn
        Afterburn next projectile ID
        Space pirate claw deceleration flag
        Bomb Torizo explosion / torizo sonic boom / Tourian statue dust clouds reset Y position
        Old Tourian escape shaft fake wall explosion reset Y position (unused)
        Golden Torizo egg hatch timer
        Eye door projectile PLM room argument
        Tourian statue - Ridley / Phantoon / base decoration Y offset
        Polyp rocks Y (sub)velocity. Used only as a temporary
        Mother Brain's bomb bounce counter
        Kago bug enemy index
        Spore spawn X position
        Spore spawner spore spawn timer
        Falling spark X velocity (unit px/frame)
        Pickup expiration timer
    }
    $1B47..6A: Enemy projectile instruction list pointers
    $1B6B..8E: Enemy projectile spritemap pointers
    $1B8F..B2: Enemy projectile instruction timers
    $1BB3..D6: Enemy projectile radii. Low: X radius. High: Y radius. If either one is 0, intangible.
    $1BD7..FA: Enemy projectile properties
    {
        v & FFFh: Damage
        8000h: Enable collisions with projectiles
        4000h: Don't die on contact
        2000h: Disable collisions with Samus
        1000h: High priority (drawn over enemies/Samus/projectiles)
    }
    $1BFB..1C1E: Enemy projectile collided projectile type. Written as part of enemy projectile / projectile collision handling ($A0:99F9), but never read by anything
    {
        Kago bug jump timer
    }
}
$198D..1C1E: Non-gameplay use
{
    $198D: Mode 7 transformation angle. Unit pi/80h radians
    $198F: Mode 7 transformation zoom level. Scale factor = 100h / [$198F]
    $1991: Cinematic BG1 X subposition
    $1993: Cinematic BG1 X position
    $1995: Cinematic BG1 Y subposition
    $1997: Cinematic BG1 Y position
    $1999: Cinematic BG1 X subspeed
    $199B: Cinematic BG1 X speed
    $199D: Cinematic BG1 Y subspeed
    $199F: Cinematic BG1 Y speed

    ; Mode 7 object definitions are at:
    ;     $8B:A355: Baby metroid in title sequence
    ;     $8B:D401..42: Japanese intro text (runs dummy mode 7 transfers, used only for ASM instructions...)

    $19A1..A4: Mode 7 object instruction list pointers
    $19A5..A8: Mode 7 object pre-instructions
    $19A9..AC: Mode 7 object instruction timers
    $19AD..B0: Mode 7 object timers
    $19B1: Mode 7 object index
    $19B3: Mode 7 object initialisation parameter. Never read

    ; Cinematic BG object definitions are at:
    ;     $8B:CF3F..CF74: Intro
    ;     $8B:F748..EF53: Ending

    $19B5..BC: Cinematic BG object indirect instruction pointers (bank $8C)

    $19CD..D4: Cinematic BG object instruction list pointers
    $19D5..DC: Cinematic BG object pre-instructions
    $19DD..E4: Cinematic BG object instruction timers
    $19E5..EC: Cinematic BG object timers
    $19ED: Cinematic BG object index

    $19F1: Cinematic BG objects enable flag
    $19F3: Cinematic BG tilemap update flag
    $19F5: Cinematic BG VRAM address

    ; Intro
    {
        ; Text glow is spawned by the intro text cinematic BG objects via indirect instruction function $884D
        $19F7..1A06: Text glow object indirect instruction pointers (bank $8C), see $19B5. Used only for the size parameters (which are both always 1)
        $1A07..16: Text glow object timers
        $1A17..26: Text glow object X positions
        $1A27..36: Text glow object Y positions
        $1A37..46: Text glow object palette indices (multiple of 400h)
        $1A47: Text glow object index
    }

    ; Ending
    {
        $19F7: Credits object instruction list pointer
        $19F9: Credits object instruction timer
        $19FB: Credits object timer
        $19FD: Credits object pre-instruction
        $19FF: Credits object enable flag. Negative = enabled
        $1A01: Cinematic BG tilemap row index
        $1A03: Last credits update Y position
        $1A05: Shooting stars enable flag
    }

    $1A49: Cinematic function timer
    $1A4B:
    {
        Intro cross-fade timer (used only for transition out of cutscene)
        Ceres explosion 2 offset index
        Zebes explosion afterglow timer
        Ending gunship X velocity
        Post-credits Samus beam VRAM transfer index
    }
    $1A4D:
    {
        Intro baby metroid X velocity (unit 1/100h px/frame)
        Intro baby metroid idle timer
        Ending gunship shake index
        Ending gunship X subvelocity
        Post-credits stars fade timer
        Post-credits Super Metroid icon VRAM transfer index
    }
    $1A4F:
    {
        Intro baby metroid Y velocity (unit 1/100h px/frame)
        Post-credits Samus fade timer
    }
    $1A51: Cinematic frame counter
    $1A53: Skip to title screen index
    {
        0: Inactive
        1: Fade out
        2: Prepare title screen
        3: Fade in
    }

    ; Cinematic sprite object definitions are at:
    ;     $8B:A0EF..A12A: Title sequence
    ;     $8B:CE55..CF3E: Intro, Ceres, Zebes
    ;     $8B:EE9D..EF98: Ending

    $1A57: Intro Samus display flag
    {
        0: Samus/projectiles not displayed
        1: Samus/projectiles displayed under cinematic sprite objects
        FFFFh: Samus/projectiles displayed over cinematic sprite objects
    }
    $1A59: Cinematic sprite object index

    $1A5D..7C: Cinematic sprite object spritemap pointers (bank $8C)
    $1A7D..9C: Cinematic sprite object X positions
    $1A9D..BC: Cinematic sprite object Y positions
    $1ABD..DC: Cinematic sprite object palette indices
    $1ADD..FC: Cinematic sprite object X subposition
    {
        Intro Mother Brain flash timer
    }
    $1AFD..1B1C: Cinematic sprite object Y subposition
    {
        Zebes explosion stars X subvelocity
    }
    $1B1D..3C: Cinematic sprite object instruction list pointers
    $1B3D..5C: Cinematic sprite object pre-instructions
    $1B5D..7C: Cinematic sprite object instruction timers
    $1B7D..9C: Cinematic sprite object timers (according to instructions $94C3, $94CD, $94D6)
    {
        Super Metroid icon speed. Unit px/frame
        Zebes explosion stars X velocity
        Low: Metroid egg particle index. High: Metroid egg particle counter
        Low: Metroid egg slime drops index. High: Metroid egg slime drops counter
        Intro Mother Brain hit counter / shake timer
        Intro rinka index
        Confused baby metroid sound effect timer
        Ceres stars velocity. Unit 1/100h px/frame
        Zebes Y velocity. Unit 1/100h px/frame
        Zebes stars Y velocity. Unit 1/100h px/frame
    }
    $1B9D: Cinematic sprite object initialisation parameter

    $1B9F: Intro/ending frame counter. Only incremented if positive. Not used for anything
    $1BA1: Intro text click flag
    $1BA3: Intro Japanese text timer
}
$198D..BC Menus
{
    $198D: Menu selection missile animation timer
    $198F: File copy arrow palette timer
    $1991: Slot A Samus helmet animation timer. 0 = not animating
    $1993: Slot B Samus helmet animation timer. 0 = not animating
    $1995: Slot C Samus helmet animation timer. 0 = not animating
    $1997: Menu selection missile animation frame
    $1999: Cleared by menu initialisation/reload code. Never read
    $199B: Slot A Samus helmet animation frame
    $199D: Slot B Samus helmet animation frame
    $199F: Slot C Samus helmet animation frame
    $19A1: Menu selection missile X position
    $19A3: Cleared by menu initialisation/reload code. Never read
    $19A5: Slot A Samus helmet X position
    $19A7: Slot B Samus helmet X position
    $19A9: Slot C Samus helmet X position
    $19AB: Menu selection missile Y position
    $19AD: Cleared by menu initialisation/reload code. Never read
    $19AF: Slot A Samus helmet Y position
    $19B1: Slot B Samus helmet Y position
    $19B3: Slot C Samus helmet Y position
    $19B5: File copy/clear menu selection
    $19B7: File copy source slot / file clear slot
    $19B9: File copy destination slot
}
$1A8F..1B4A: Game options menu
{
    $1A8F: Game options menu object index

    $1A93: Game options menu object initialisation parameter

    $1A9D..AC: Game options menu object spritemap pointers
    $1AAD..BC: Game options menu object X positions
    $1ABD..CC: Game options menu object Y positions
    $1ACD..DC: Game options menu object palette indices. Multiple of 200h
    $1ADD..EC: Game options menu object variables. Initialised to zero, otherwise unused
    $1AED..FC: Game options menu object variables. Initialised to zero, otherwise unused
    $1AFD..1B0C: Game options menu object instruction list pointers
    $1B0D..1C: Game options menu object pre-instructions
    $1B1D..2C: Game options menu object instruction timers
    $1B2D..3C: Game options menu object timers
    $1B3D..4A: Game options menu controller bindings. Shoot, jump, run, item switch, item cancel, aim up, aim down
    {
        0: X
        1: A
        2: B
        3: Select
        4: Y
        5: L
        6: R
    }
}

$1C1F: Message box index
{
    1: Energy tank
    2: Missile
    3: Super missile
    4: Power bomb
    5: Grappling beam
    6: X-ray scope
    7: Varia suit
    8: Spring ball
    9: Morphing ball
    Ah: Screw attack
    Bh: Hi-jump boots
    Ch: Space jump
    Dh: Speed booster
    Eh: Charge beam
    Fh: Ice beam
    10h: Wave beam
    11h: Spazer
    12h: Plasma beam
    13h: Bomb
    14h: Map data access completed
    15h: Energy recharge completed
    16h: Missile reload completed
    17h: Would you like to save?
    18h: Save completed
    19h: Reserve tank
    1Ah: Gravity suit
    1Bh: Terminator
    1Ch: Would you like to save? (Used by gunship)
    1Dh: Terminator (save completed, unused)
}
$1C21: Unused

; Also see $7E:DE1C..DF5B for more PLM RAM
$1C23: PLM flag. Set to negative to enable PLMs.
$1C25: PLM draw tilemap index (into $7E:C6C8)
$1C27: PLM index
$1C29: PLM X block (calculated by $84:8290)
$1C2B: PLM Y block (calculated by $84:8290)
$1C2D: PLM item GFX index (into $1C2F and some tables in $84:8764)
$1C2F..36: Item PLM GFX pointers (bank $89, 100h bytes)
$1C37..86: PLM IDs
$1C87..D6: PLM block indices (into $7F:0002)
$1CD7..1D26: PLM pre-instructions
$1D27..76: PLM instruction list pointers
$1D77..C6: PLM timers (according to instructions $873F, $8747, $874E, $875A)
{
    Used as advancement stage ($84:B876 table index) by lavaquake PLM ($84:B846)
    Used as trigger flag by gates and item collision detection
    Used as shot status by doors and Mother Brain's glass
}
$1DC7..1E16: PLM room arguments
{
    Used as shot counter by Mother Brain's glass ($84:D1E6)
    Used as door hit counter by Dragon cannon with shield ($84:DB64)
}
$1E17..66: PLM variables
{
    Respawn block (drawn by $84:8B17)
    Scroll PLM triggered flag ($84:B393)
    Samus X position for Brinstar plants (used by $84:AC89, set by $84:B0DC/B113)
    Grey door type ($84:BE3F)
    Draygon turret damaged flag address ($84:DB8E)
}
$1E67..6C: Custom draw instruction
{
    $1E67: Number of blocks (must be 1)
    $1E69: PLM block
    $1E6B: Zero-terminator
}
$1E6D: Tourian entrance statue finished processing flag. 8000h = finished
$1E6F: Tourian entrance statue animation state
{
    1: Phantoon is being processed
    2: Ridley is being processed
    4: Kraid is being processed
    8: Draygon is being processed
    8000h: Busy releasing lock of a boss
}
$1E71: Samus is in quicksand flag. Fakes collision with floor. Setting this flag only has an effect during vertical collision
$1E73: Inside block reaction Samus point. Used by Maridia quicksand surface and scroll PLM trigger
{
    0: Bottom
    1: Centre
    2: Top
}
$1E75: Save station lockout flag. Set when triggering save station. Cleared when leaving the room.
$1E77: Current slope BTS (non-square slopes only). Upper byte is set to next block's BTS during vertical slope collision
$1E79: Flag. 8000h enables palette FX objects
$1E7B: Palette FX object index
$1E7D..8C: Palette FX object IDs
$1E8D..9C: Palette FX object colour indices
$1E9D..AC: Palette FX object variables
$1EAD..BC: Palette FX object pre-instructions
$1EBD..CC: Palette FX object instruction list pointers
$1ECD..DC: Palette FX object instruction timers
$1EDD..EC: Palette FX object timers
$1EED: Samus in heat palette FX index. Used to keep track of where in the $E45E/E68A/E8B6 instruction list the game is so that switching suits doesn't desynch the Samus heat glow from the environmental heat glow
$1EEF: Previous Samus in heat palette FX index
$1EF1: Animated tiles object enable flag. 8000h = enabled
$1EF3: Animated tiles object index
$1EF5..1F00: Animated tiles object IDs
$1F01..0C: Animated tiles object timers
$1F0D..18: Animated tiles object instruction list pointers
$1F19..24: Animated tiles object instruction timers
$1F25..30: Animated tiles object source address (in $87)
$1F31..3C: Animated tiles object sizes
$1F3D..48: Animated tiles object VRAM addresses
$1F49: Animated tiles object instruction
$1F51: Cinematic function. Bank $8B. Used for game states 1/1Eh/22h/25h/27h (opening / intro / Ceres goes boom, Samus goes to Zebes / Ceres goes boom with Samus / ending and credits)
$1F53: Demo timer. Demo scene timer when demo is playing, 15 second delay before transitioning to demos when title screen is active
$1F55: Demo set
$1F57: Demo scene
$1F59: Number of demo sets (4 if beaten game, otherwise 3)

$1F??..FF: Stack. Lowest observed is $1FB7 where IRQ fired during random drop routine ($86:F106) as part of fake Kraid death item drop routine ($A0:B8EE) in Cpadolf's snes9x 100% TAS

$7E:2000..9FFF: Room tiles. Decompressed here temporarily then transferred to VRAM $0000..3FFF
{
    $7E:7000..9FFF: CRE tiles, or extended part of room tiles if [CRE bitset] & 4 != 0
}
$7E:2000..5FFF: Grey clouds during Zebes explosion tilemap
$7E:2000..2FFF: Enemy BG2 tilemap. Transfer is flagged via $0E1E, also see extended tilemap format in "Enemy RAM.asm". Used by Kraid, Phantoon, Draygon, Mother Brain, Crocomire
{
    Kraid:
    {
        $7E:2000..27FF: Kraid top half. Transferred to VRAM BG2 tilemap when unpausing. Also decompression buffer for Kraid's bottom half BG2 tilemap
        $7E:2800..2DFF: Kraid bottom half

        $7E:2FC0..FF: Used to clear rows of Kraid's tilemap when he's dying
    }

    Phantoon:
    {
        $21C6..0D: Eye - row 0

        $2206..0D: Eye - row 1
        {
            $2208..0B: Eyeball - row 0
        }

        $2246..0D: Eye - row 2
        {
            $2248..4B: Eyeball - row 1
        }

        $2286..0D: Eye - row 3

        $2304..05: Left tentacle - row 0
        $2306..0D: Mouth - row 0
        $230E..0F: Right tentacle - row 0

        $2344..45: Left tentacle - row 1
        $2346..4D: Mouth - row 1
        $234E..4F: Right tentacle - row 1
    }
}
$7E:2000..2FFF: Fading palette data
{
    $7E:2000..21FF: Fading palettes
    $7E:2200..23FF: Initial palettes
    $7E:2400..25FF: Fading palettes - red component.   Values are * 100h (range 0..1F00h)
    $7E:2600..27FF: Fading palettes - green component. Values are * 100h (range 0..1F00h)
    $7E:2800..29FF: Fading palettes - blue component.  Values are * 100h (range 0..1F00h)
    $7E:2A00..2BFF: Fading palettes delta - red component.   Initialised to initial / 20h. Values are * 100h (range 0..1F00h)
    $7E:2C00..2DFF: Fading palettes delta - green component. Initialised to initial / 20h. Values are * 100h (range 0..1F00h)
    $7E:2E00..2FFF: Fading palettes delta - blue component.  Initialised to initial / 20h. Values are * 100h (range 0..1F00h)
}
$7E:2000..2CFF: Corpse rotting graphics
{
    $7E:2000..2EFF: Torizo
    $7E:2000..231F: Sidehopper - enemy parameter 1 = 0
    $7E:2320..263F: Sidehopper - enemy parameter 1 = 2
    $7E:2640..273F: Skree - enemy parameter 1 = 0
    $7E:2740..283F: Skree - enemy parameter 1 = 2
    $7E:2840..293F: Skree - enemy parameter 1 = 4
    $7E:2940..29FF: Zoomer - enemy parameter 1 = 0
    $7E:2A00..2ABF: Zoomer - enemy parameter 1 = 2
    $7E:2AC0..2B7F: Zoomer - enemy parameter 1 = 4
    $7E:2B80..2C3F: Ripper - enemy parameter 1 = 0
    $7E:2C40..2CFF: Ripper - enemy parameter 1 = 2
}

$7E:3000..37FF: Game options menu tilemap
$7E:3000..37FF: Pause menu map tilemap
$7E:3000..37FF: Cinematic BG tilemap
{
    Intro text:
    {
        $7E:3000..FF: Top margin / initial Japanese text
        $7E:3100..35FF: English text region
        $7E:3600..FF: Japanese text region
        $7E:3700..FF: Bottom margin
    }
}
$7E:3000..31DF: Message box BG3 Y scroll HDMA data table
{
    $7E:30BC..30F7: -(18h - [message box animation Y radius] / 100h)
    $7E:30F8..3133: 18h - [message box animation Y radius] / 100h
    $7E:3134..31DF: 0
}
$7E:31D8..33E7: Dummy Samus wireframe tilemap during pause menu. Unsure of purpose, bug possibly, see $82:8EDA

$7E:3200..337F: Message box tilemap. Transferred to $59A0/$59C0 (depending on message box size). Message tilemap begins at $7E:3240, save confirmation yes/no begins at $7E:3300
$7E:3380..86: Message box BG3 Y scroll indirect HDMA table

$7E:3300..34FF: Backup of palettes during menu

$7E:33EA: Backup of HDMA channels to enable ($85) during message boxes
$7E:33EB: Backup of BG3 tilemap base address and size ($5B) during message boxes

$7E:3400..37FF: Lower half of pause menu map BG2 tilemap. Presumably transferred to VRAM $3A00..3BFF

$7E:3500..35: Backup of regular IO registers ($51..86) during game over menu

$7E:3600..3DFF: Menu tilemap. BG1 for game over menu, BG2 (Zebes and stars) for file select menu in $81:9E93, then used for BG1 thereafter

$7E:3800..3FFF: Cinematic BG tilemap. (Samus' head during intro)
{
    $7E:3B40..BF: Samus' eyes
}
$7E:3800..3FFF: Room select map BG1 tilemap
$7E:3800..3FFF: Equipment screen BG1 tilemap. Transferred to VRAM $3000..33FF
{
    $7E:3900..3DFF: Non blank part. Transferred to VRAM $3080..32FF
}
$7E:3800..3FFF: Debug game over menu tilemap. Only used to fill with 000Fh for initial blank tilemap, not updated afterwards
$7E:3800..3EFF: Cleared message box BG3 tilemap (see $85:81F3)

$7E:4000..6FFF: X-ray tilemaps
{
    $7E:4000..4FFF: X-ray BG2 tilemap
    $7E:5000..5FFF: Backup of BG2 tilemap during x-ray
    $7E:6000..6FFF: Backup of BG1 tilemap during x-ray
}
$7E:4000..4FFF: BG2 tilemap. Set to blank (0338h) or decompressed here temporarily, then transferred to VRAM $4800..4FFF
$7E:4000..4FFF: Crocomire melting BG2 tiles
$7E:4000..4EFF: FX tilemap when clearing FX tilemap
$7E:4000..47FF: Decompression buffer for Kraid's top half BG2 tilemap
$7E:4000..47FF: BG2 room select map tilemap
$7E:4000..45FF: Intro Japanese text tiles (BG3)

$7E:4100..47FF: Backup of VRAM $5880..5BFF during message boxes

$7E:5000..53FF: Copy of VRAM $3E00..3FFF during pause menu in Kraid's room

$7E:6000..9FFF: Big Zebes during Zebes explosion tilemap
$7E:6000..87FF: Post-credits Super Metroid icon
{
    $7E:6000..7FFF: Tiles
    $7E:8000..87FF: Tilemap
}

$7E:7000..97FF: Mostly extra enemy RAM. Cleared by enemy initialisation ($A0:8A9E)
{
    $7E:7000..97FF: Enemy tile data. Transferred to VRAM $6C00..7FFF by $A0:8CD7 when loading game. The first 200h bytes are initialised to the last 10h non-X standard sprite tiles and are never overwritten by any enemies, so it's basically wasted memory
    $7E:7000..77FF: Enemy spawn data. 40h byte slots
    {
        + 0: If not 0/8, then if enemy is respawning enemy placeholder, it can still interact with Samus, although it won't because its enemy touch is $804C. Never written
        + 2: Cause of death. Never read
        {
            0 when grapple paralysis killed
            3 when power bomb killed
            4 when grapple killed
            6 when Samus contact killed
            Projectile type when shot dead
        }

        ; Used for enemy respawn
        + 6: VRAM tiles index
        + 8: Palette index

        + 10h: Graphical X offset. Used by Ceres steam in Ceres elevator room when rotating
        + 12h: Graphical Y offset. Used by Ceres steam in Ceres elevator room when rotating

        ; Used for debug enemy spawner
        + 1Eh: ID
        + 20h: X position. Used by rinka
        + 22h: Y position. Used by rinka
        + 24h: Initialisation parameter (orientation in SMILE)
        + 26h: Properties (special in SMILE)
        + 28h: Extra properties (special GFX bitflag in SMILE)
        + 2Ah: Parameter 1
        + 2Ch: Parameter 2
        + 2Eh..39h: Name
    }
    $7E:7800..7FFF: Extra enemy RAM (40h bytes each). See "enemy data.txt" from lua repo, "Kraid.asm", "Draygon.asm", "Crocomire.asm", "Mother Brain.asm"
    {
        Botwoon:
        {
            $7E:7800..19: Enemy projectile indices. Dh entries. First entry is the tail

            $7E:7820..39: Body hidden flags. Dh entries. First entry is the tail
        }
    }
    $7E:8000..87FF: Extra enemy RAM (40h bytes each). See "enemy data.txt" from lua repo, "Draygon.asm", "Crocomire.asm", "Mother Brain.asm"
    {
        Typewriter text:
        {
            $7E:8036: Typewriter instruction list pointer
            $7E:8038: Typewriter VRAM tilemap address
            $7E:803A: Typewriter instruction timer
            $7E:803C: Typewriter instruction timer reset value
            $7E:803E: Typewriter stroke timer
        }

        Botwoon:
        {
            $7E:8000: Initialisation timer. Initialised to 100h, Botwoon waits until it decrements to zero before first moving
            $7E:8002: Spit timer
            $7E:8004: Pre-death counter. Counts up to 100h before starting death sequence falling
            $7E:8006: Death counter. Counts up to C0h before deleting enemy, setting boss bit, and changing music
            $7E:8008: Large wall explosion timer. Spawns a large explosion sprite every 13 frames for the crumbling wall
            $7E:800A: Wall smoke timer. Spawns two smoke sprites every 5 frames for the crumbling wall
            $7E:800C: Decremented when reached target hole. Never read

            $7E:8010: Falling Y speed table index

            $7E:801C: Set by unused routine $967B, read by unused routine $9696
            $7E:801E: Death flag
            $7E:8020: Body death flag

            $7E:8026: Head hidden flag
            $7E:8028: Previous head hidden flag
            $7E:802A: Hole collision disabled flag
            $7E:802C: Target position history index. Set when Botwoon's head reaches target hole, body projectiles disappear when they reach this
            $7E:802E: Target hole index. 0 = left, 8 = bottom, 10h = top, 18h = right
            $7E:8030: Speed. Used as number of movement data entries to move or px/frame depending on movement function
            $7E:8032: Target hole angle using the usual SM angle convention (never read)
            $7E:8034: Target hole angle using the common maths angle convention
            $7E:8036: Instruction list
            $7E:8038: Going through hole flag
            $7E:803A: Spit angle
            $7E:803C: Tail showing flag
            $7E:803E: Speed table index. Used for both Botwoon movement and spit projectile movement, although Botwoon only spits when this index is 0
        }

        Ridley:
        {
            $7E:800A: Ridley's final attack swoop counter?
        }
    }
    $7E:8800..8FFF: Extra enemy RAM (40h bytes each). Includes variables for corpse rotting effect. See "enemy data.txt" from lua repo, "Draygon.asm"
    {
        Corpse rotting:
        {
            $7E:8802: Corpse rotting rot entry Y offset
            $7E:8804..13: Working copy of enemy $7E:8828..37. Not enemy indexed, absolute addresses
            {
                $7E:8804: Corpse rotting rot entry copy function
                $7E:8806: Corpse rotting rot entry move function
                $7E:8808: Corpse rotting tile data row offsets pointer
                $7E:880A: Corpse rotting sprite height
                $7E:880C: Corpse rotting sprite height - 1
                $7E:880E: Corpse rotting sprite height - 2
                $7E:8810: Tile data offset to get from pixel row 6 of current tile row to pixel row 0 of next tile row
                $7E:8812: Corpse rotting rot entry finished hook
            }

            $7E:8824: Corpse rotting rot table pointer. Format: yyyy,tttt, ... where y is the Y offset of sprite to rot and t is rot activation timer
            $7E:8826: Corpse rotting VRAM transfers pointer. Format: size, source bank, source address, VRAM address (all 16 bit)
            $7E:8828: Corpse rotting rot entry copy function
            $7E:882A: Corpse rotting rot entry move function
            $7E:882C: Corpse rotting tile data row offsets pointer
            $7E:882E: Corpse rotting sprite height
            $7E:8830: Corpse rotting sprite height - 1
            $7E:8832: Corpse rotting sprite height - 2
            $7E:8834: Tile data offset to get from pixel row 6 of current tile row to pixel row 0 of next tile row
            $7E:8836: Corpse rotting rot entry finished hook
        }

        Botwoon:
        {
            $7E:8800: Movement table index
            $7E:8802: Set to 0 when Botwoon reaches end of movement data
            $7E:8804: Movement data pointer

            $7E:8808: Movement direction. 0 = forwards, FFFFh = backwards

            $7E:8816: Set to 0 sometimes, never read
            $7E:8818: Previous health during enemy shot

            $7E:881C: Palette data offset (should be 1E0h)
            $7E:881E: Health-based palette index. Multiple of 2
            $7E:8820: X position 1 frame ago
            $7E:8822: Y position 1 frame ago
            $7E:8824: X position 2 frames ago
            $7E:8826: Y position 2 frames ago
            $7E:8828: X position 3 frames ago
            $7E:882A: Y position 3 frames ago
            $7E:882C: X position 4 frames ago
            $7E:882E: Y position 4 frames ago

            $7E:8832: Initial leave hole action flag. Initialised to 1, set to 0 after leave hole action determined, makes the initial action movement (as opposed to spitting)
            $7E:8834: Spitting flag
            $7E:8836: Max health. Never read
            $7E:8838: Max health * 1/2
            $7E:883A: Max health * 1/4

            $7E:883E: Body death flag
        }

        Rinka:
        {
            $7E:8800..15: Rinka spawn point availability table (for Mother Brain's room only). 0 = available
        }
    }

    $7E:9000..97FF: Debug enemy log for unused function $A0:918B
    $7E:9000..953F: Mother Brain corpse rotting graphics
    $7E:9000..93FF: Botwoon position history. Previous 100h X/Y positions. Circular buffer with stack index $0FAA
    $7E:9000..19: Crocomire death sequence variables
    {
        $7E:9000: Pre-bridge block dust cloud spawned flag
        $7E:9002: Bridge part 1 crumbled flag

        $7E:9006: Bridge part 2 crumbled flag

        $7E:900A: Set to 0, never read

        $7E:9016: Death sequence crumbling bridge index
        $7E:9018: Acid damage smoke timer
    }
    $7E:9000..19: Wavy Phantoon BG2 X scroll indirect HDMA table
    {
        If Phantoon wavelength doubled:
            C0h,$9100, C0h,$9180, C0h,$9100, C0h,$9180, 00,00
        Else:
            A0h,$9100, A0h,$9140, A0h,$9100, A0h,$9140, A0h,$9100, A0h,$9140, A0h,$9100, A0h,$9140, 00,00
    }
    $7E:9000..0A: Morph ball eye beam window 1 indirect HDMA table

    $7E:9000:
    {
        Kraid death sequence quake sound timer
        Used by Spore Spawn as flag to disable spore generation
    }

    $7E:9002..97FF: Draygon swoop Y positions. Entries are 4 bytes apart (even though only 2 bytes are used). Iterate backwards for downwards movement, forwards for upwards movement

    $7E:9032: Phantoon materialisation sound effect index

    $7E:9080: Morph ball eye beam angular width delta
    $7E:9082: Morph ball eye beam angular subwidth delta

    $7E:9090: Morph ball eye beam colour index

    $7E:9100..92FF: Morph ball eye beam window 1 HDMA data table (only $7E:9100..92BF used). List of 8-bit pairs (left position, right position)
    $7E:9100..FF: Wavy Phantoon BG2 X scroll HDMA data table

    $7E:9700..BF: Mother Brain corpse rotting rot table

    $7E:97DC..FF: Enemy projectile angles. Used for Botwoon spit, Draygon turrets, and Draygon's gunk
}
$7E:9800..99FF: X-ray window 2 HDMA data table (only $7E:9800..99BF used). List of 8-bit pairs (left position, right position)
$7E:9800..99FF: Suit pickup window 1 HDMA data table (only $7E:9800..99BF used). List of 8-bit pairs (left position, right position)
$7E:9800..FF: Wavy Samus BG3 X scroll HDMA data table
$7E:9800..41: Title screen gradient colour math subscreen backdrop colour HDMA table

; Note that $7E:9C00..9FFF is cleared by door transition (see $82:E6A2)

$7E:9C00..9DBF: Expanding and contracting effect BG2 Y scroll indirect HDMA data table
$7E:9C00..2B: FX type 22h BG3 Y scroll HDMA table
$7E:9C00..0D: Mother Brain rainbow beam window 1 indirect HDMA table
$7E:9C00..03: Lava/acid BG3 Y scroll HDMA data table

$7E:9C00: Above surface water BG3 X scroll HDMA data entry (zero)

$7E:9C04..23: Water BG3 X scroll HDMA data table (and would-be spores BG3 X scroll HDMA data table in unused code)

$7E:9C44: Unused HDMA data table entry, set to [BG2 Y scroll]. See $88:BDB1
$7E:9C46..65: Lava/acid BG2 Y scroll HDMA data table (used also for X scroll by unused wavy effect)

$7E:9C48..67: Water BG2 X scroll HDMA data table

$7E:9D00..??: Mother Brain rainbow beam window 1 HDMA data table. List of 8-bit pairs (left position, right position)
$7E:9D00..0F: Haze colour math subscreen backdrop colour HDMA data table. List of 8-bit values

$7E:9E00..0B: Expanding square transition window 1 left position indirect HDMA table. 3 byte entries
{
    ; v = hh,aaaa
    ; h: Height. Max 7Fh
    ; a: Left position address:
    ;     $9E22: Top/bottom margin
    ;     $9E32: Square
}
$7E:9E00..07: Expanding and contracting effect BG2 Y scroll indirect HDMA table
$7E:9E00: Tourian entrance statue BG2 Y scroll

$7E:9E02..??: FX type 22h BG3 X scroll indirect HDMA table

$7E:9E10..1B: Expanding square transition window 1 right position indirect HDMA table. 3 byte entries
{
    ; v = hh,aaaa
    ; h: Height. Max 7Fh
    ; a: Right position address:
    ;     $9E20: Top/bottom margin
    ;     $9E36: Square
}

$7E:9E20: Expanding square top/bottom margin right position. Always 0
$7E:9E22: Expanding square top/bottom margin left position. Always FFFFh

$7E:9E30: Expanding square left subposition
$7E:9E32: Expanding square left position
$7E:9E34: Expanding square right subposition
$7E:9E36: Expanding square right position
$7E:9E38: Expanding square top subposition
$7E:9E3A: Expanding square top position
$7E:9E3C: Expanding square bottom subposition
$7E:9E3E: Expanding square bottom position
$7E:9E40: Expanding square left position subvelocity
$7E:9E42: Expanding square left position velocity
$7E:9E44: Expanding square right subvelocity
$7E:9E46: Expanding square right velocity
$7E:9E48: Expanding square top subvelocity
$7E:9E4A: Expanding square top velocity
$7E:9E4C: Expanding square bottom subvelocity
$7E:9E4E: Expanding square bottom velocity
$7E:9E50: Expanding square timer

$7E:9E80..??: FX type 22h BG3 X scroll HDMA data table

$7E:9F00..7F: Scrolling sky BG2 X scroll indirect HDMA table
$7E:9F02..??: FX type 22h BG1 X scroll indirect HDMA table
$7E:9F80..DB: Scrolling sky BG2 X scroll HDMA data table. Two word entries
{
    + 0: Subscroll (used for calculations only)
    + 2: Scroll (pointed to by indirect HDMA table)
}

$7E:A000..BFFF: Tile table. 8 byte entries. Indexed by the tile index of level data / custom background. Tilemap values for four 8x8 tiles
{
    + 0: Top left
    + 2: Top right
    + 4: Bottom left
    + 6: Bottom right

    $7E:A000..A7FF: CRE (tile table indices 0..FFh). Decompressed from $B9:A09D if not in Ceres
    {
        $A470..AF: Item PLMs. Two frames each, four items
    }
    $7E:A800..BFFF: SCE (tile table indices 100h..3FFh). Decompressed from tileset. If in Ceres, SCE starts at $7E:A000 instead
}
$7E:A000..AFFF: Ending font 3 tiles

$7E:C000..C1FF: Palettes, copied straight to CGRAM. First colour ($7E:C000) is main screen backdrop colour
{
	$7E:C000..1F: BG1/2 palette 0 (4bpp) - SCE/CRE / BG3 palettes 0..3 (2bpp)
    {
        $7E:C000..07: BG3 palette 0
        {
            $7E:C002: Acid highlight (02DFh)
            $7E:C004: Acid bubbles (01D7h)
            $7E:C006: Acid background (00ACh)
        }
        $7E:C008..0F: BG3 palette 1
        $7E:C010..17: BG3 palette 2
        {
            $7E:C012: Mini-map explored room / non-empty energy tank / message box header text / message box A button (48FBh)
            $7E:C014: Mini-map explored room feature / non-empty energy tank outline / message box body text (7FFFh)
            $7E:C016: Mini-map explored room background / non-empty energy tank background / message box background (0000h)
        }
        $7E:C018..1F: BG3 palette 3
        {
            $7E:C01A: Mini-map unexplored room / HUD text outline / empty reserve auto icon / message box X button / unselected save dialog option (44E5h)
            $7E:C01C: Mini-map unexplored room feature / HUD text / mini-map grid (7FFFh)
            $7E:C01E: Mini-map unexplored room background / HUD background (0000h)
        }
    }
	$7E:C020..3F: BG1/2 palette 1 (4bpp) - SCE/CRE / BG3 palettes 4..7 (2bpp)
    {
        $7E:C020..27: BG3 palette 4
        {
            $7E:C022: Highlighted HUD item background outline (0BB1h)
            $7E:C024: Highlighted HUD item background (1EA9h)
            $7E:C026: Highlighted HUD item outline (0145h)
        }
        $7E:C028..2F: BG3 palette 5
        {
            $7E:C02A: HUD item background outline / empty energy tank outline (3DB3h. 3D46h/3E0Dh in blue/white Ceres)
            $7E:C02C: HUD item background / empty energy tank (292Eh. 28C1h/2526h in blue/white Ceres)
            $7E:C02E: HUD item outline / empty energy tank background (1486h. 1420h/0C60h in blue/white Ceres)
        }
        $7E:C030..37: BG3 palette 6
        {
            $7E:C032: FX primary (palette blend colour 0)
            $7E:C034: FX secondary (palette blend colour 1)
            $7E:C036: FX background (palette blend colour 2)
        }
        $7E:C038..3F: BG3 palette 7
        {
            $7E:C03A: Mini-map room highlight / non-empty reserve auto icon / save dialog text / message box B button colour / message box Samus suit (02DFh)
            $7E:C03C: Mini-map room feature highlight / message box Samus suit shading (001Fh. 7FFFh in Crocomire's room)
            $7E:C03E: Mini-map background / non-empty reserve auto icon background / save dialog background / message box Samus background (0000h)
        }
    }
	$7E:C040..5F: BG1/2 palette 2 (4bpp) - SCE/CRE
	$7E:C060..7F: BG1/2 palette 3 (4bpp) - SCE/CRE
	$7E:C080..9F: BG1/2 palette 4 (4bpp) - SCE
	$7E:C0A0..BF: BG1/2 palette 5 (4bpp) - SCE
	$7E:C0C0..DF: BG1/2 palette 6 (4bpp) - SCE
	$7E:C0E0..FF: BG1/2 palette 7 (4bpp) - SCE
	$7E:C100..1F: Sprite palette 0 - white palette for flashing enemies
	$7E:C120..3F: Sprite palette 1 - enemies
	$7E:C140..5F: Sprite palette 2 - enemies
	$7E:C160..7F: Sprite palette 3 - enemies
	$7E:C180..9F: Sprite palette 4 - Samus
    {
        $7E:C182: Colour 1. Abdomen - dark
        $7E:C184: Colour 2. Main suit - light
        $7E:C186: Colour 3. Outline
        $7E:C188: Colour 4. Visor / electricity
        $7E:C18A: Colour 5. Arm cannon - medium dark
        $7E:C18C: Colour 6. Gleam
        $7E:C18E: Colour 7. Arm cannon - light
        $7E:C190: Colour 8. Arm cannon - medium light
        $7E:C192: Colour 9. Helmet - light
        $7E:C194: Colour Ah. Main suit - medium
        $7E:C196: Colour Bh. Main suit - dark
        $7E:C198: Colour Ch. Abdomen - light
        $7E:C19A: Colour Dh. Arm cannon - dark
        $7E:C19C: Colour Eh. Helmet - medium
        $7E:C19E: Colour Fh. Helmet - dark
    }
	$7E:C1A0..BF: Sprite palette 5 - most common sprites (item drops, smoke, explosions, bombs, power bombs, missiles, gates (wall part), water splashes, grapple beam, timer)
	$7E:C1C0..DF: Sprite palette 6 - beams. Crystal flash uses this palette for some reason
	$7E:C1E0..FF: Sprite palette 7 - enemies
}
$7E:C200..C3FF: Target palettes
{
	$7E:C200..1F: BG palette 0 - SCE/CRE
	$7E:C220..3F: BG palette 1 - SCE/CRE
	$7E:C240..5F: BG palette 2 - SCE/CRE
	$7E:C260..7F: BG palette 3 - SCE/CRE
	$7E:C280..9F: BG palette 4 - SCE
	$7E:C2A0..BF: BG palette 5 - SCE
	$7E:C2C0..DF: BG palette 6 - SCE
	$7E:C2E0..FF: BG palette 7 - SCE
	$7E:C300..1F: Sprite palette 0 - white palette for flashing enemies
	$7E:C320..3F: Sprite palette 1 - enemies
	$7E:C340..5F: Sprite palette 2 - enemies
	$7E:C360..7F: Sprite palette 3 - enemies
	$7E:C380..9F: Sprite palette 4 - Samus. Set to palette data from bank $9B during room transitions by $91:DDD7
	$7E:C3A0..BF: Sprite palette 5 - most common sprites (item drops, smoke, explosions, bombs, power bombs, missiles, gates (wall part), water splashes, grapple beam)
	$7E:C3C0..DF: Sprite palette 6 - beams
	$7E:C3E0..FF: Sprite palette 7 - enemies
}
$7E:C400: Palette change numerator
$7E:C402: Palette change denominator
$7E:C404: Colour index in palette change routines
$7E:C406..C5: Power bomb explosion window 2 left HDMA data table
$7E:C4C6..C505: Unused
$7E:C506..C5: Power bomb explosion window 2 right HDMA data table
$7E:C5C6..C605: Unused
$7E:C606: Off-screen power bomb explosion window 2 left HDMA data entry
$7E:C607: Off-screen power bomb explosion window 2 right HDMA data entry
$7E:C608..C7: HUD tilemap. Not including top-most row (row 0)
{
    $7E:C608..47: Row 1
    {
        $7E:C60A..17: Energy tanks
        $7E:C618..1B: Auto reserve
        $7E:C61C..21: Missiles

        $7E:C624..27: Super missiles

        $7E:C62A..2D: Power bombs

        $7E:C630..33: Grapple

        $7E:C636..39: X-ray

        $7E:C63C..45: Mini-map
    }
    $7E:C648..87: Row 2
    {
        $7E:C64A..57: Energy tanks
        $7E:C658..5B: Auto reserve
        $7E:C65C..61: Missiles

        $7E:C664..67: Super missiles

        $7E:C66A..6D: Power bombs

        $7E:C670..73: Grapple

        $7E:C676..79: X-ray

        $7E:C67C..85: Mini-map
        {
            $7E:C680: Samus' position in mini-map
        }
    }
    $7E:C688..C7: Row 3
    {
        $7E:C694..97: Sub-tank health
        $7E:C698..9B: Auto reserve
        $7E:C69C..A1: Missile count

        $7E:C6A4..A7: Super missile count
        $7E:C6A8..A9: Debug. Extra super missile count digit
        $7E:C6AA..AD: Power bomb count

        $7E:C6BC..C5: Mini-map
    }
}
$7E:C6C8..C8C7: PLM draw tilemap
$7E:C8C8..C907: BG1 column update tilemap left halves
$7E:C908..47: BG1 column update tilemap right halves
$7E:C948..8B: BG1 row update tilemap top halves
$7E:C98C..CF: BG1 row update tilemap bottom halves
$7E:C9D0..CA0F: BG2 column update tilemap left halves
$7E:CA10..4F: BG2 column update tilemap right halves
$7E:CA50..93: BG2 row update tilemap top halves
$7E:CA94..D7: BG2 row update tilemap bottom halves
$7E:CAD8: HUD BG3 X position
$7E:CADA: HUD BG3 Y position
$7E:CADC: BG3 X position (after HUD is drawn), except during door transition whilst the screen is scrolling
$7E:CADE: BG3 Y position (after HUD is drawn), except during door transition whilst the screen is scrolling
$7E:CAE0..E7: Crocomire BG2 Y scroll indirect HDMA table. FFh,$CAF0, E1h,$CBEE, 00h,00h
$7E:CAE8..EF: Unused
$7E:CAF0..CCEF: Crocomire BG2 Y scroll HDMA data table
$7E:CCF0..CD1F: Unused
$7E:CD20..51: Scrolls
{
    0: Red. Cannot scroll into this area
    1: Blue. Hides the bottom 2 rows of the area
    2: Green. Unrestricted
}
$7E:CD52..CE51: Explored map tiles - Crateria.     See current area map tiles explored at $07F7
$7E:CE52..CF51: Explored map tiles - Brinstar.     See current area map tiles explored at $07F7
$7E:CF52..D051: Explored map tiles - Norfair.      See current area map tiles explored at $07F7
$7E:D052..D151: Explored map tiles - Wrecked Ship. See current area map tiles explored at $07F7
$7E:D152..D251: Explored map tiles - Maridia.      See current area map tiles explored at $07F7
$7E:D252..D351: Explored map tiles - Tourian.      See current area map tiles explored at $07F7
$7E:D352..D451: Explored map tiles - Ceres.        See current area map tiles explored at $07F7
$7E:D452..D551: Explored map tiles - Debug.        See current area map tiles explored at $07F7
$7E:D552..58: Debug. Enemy set name. Never read
$7E:D559..F1: Debug. Enemy set data. Never read. Ch byte slots. 99h bytes according to $A0:896F, enough space for Ch entries (with 9 bytes spare...). In practice, only 4 palettes can be loaded.
{
    + 0..9: Enemy name
    + Ah: Enemy palette index
}
$7E:D5F2..D651: Unused
$7E:D652: Work robot palette animation palette index. Multiple of 200h
$7E:D654: Work robot palette animation timer
$7E:D656: Work robot palette animation table index
$7E:D658..D7BF: Projectile trail data
{
    ; Some projectile trails (mostly ice beams) use two sets of data dubbed left and right (left is top if you shoot right, bottom if shoot left, etc)
    $7E:D658..7B: Left instruction timer
    $7E:D67C..9F: Right instruction timer
    $7E:D6A0..C3: Left instruction list pointer. Initialised from $90:B5BB table
    $7E:D6C4..E7: Right instruction list pointer. Initialised from $90:B609 table
    $7E:D6E8..D70B: Left tile number and attributes
    $7E:D70C..2F: Right tile number and attributes
    {
        v = YXPPpppttttttttt
        t: Tile number
        p: Palette
        P: Priority
        X: X flip
        Y: Y flip
    }
    $7E:D730..53: Left X position
    $7E:D754..77: Right X position
    $7E:D778..9B: Left Y position
    $7E:D79C..BF: Right Y position
}
$7E:D7C0..DE1B: RAM that is saved to SRAM
{
    $7E:D7C0..D81F: Copy of $09A2..0A01 when saving
    $7E:D820..27: Event bit array. Bytes 3..7 are unused
    {
        $7E:D820:
        {
            1:   Event 0 - Zebes is awake
            2:   Event 1 - Shitroid ate sidehopper
            4:   Event 2 - Mother Brain's glass is broken
            8:   Event 3 - zebetite destroyed bit 0 (set if 1 or 3 zebetites are destroyed)
            10h: Event 4 - zebetite destroyed bit 1 (set if 2 or 3 zebetites are destroyed)
            20h: Event 5 - zebetite destroyed bit 2 (set if all 4 zebetites are destroyed)
            40h: Event 6 - Phantoon statue is grey
            80h: Event 7 - Ridley statue is grey
        }
        $7E:D821:
        {
            1:   Event 8  - Draygon statue is grey
            2:   Event 9  - Kraid statue is grey
            4:   Event Ah - entrance to Tourian is unlocked
            8:   Event Bh - n00b tube is broken
            10h: Event Ch - Lower Norfair chozo has lowered the acid
            20h: Event Dh - Shaktool cleared a path
            40h: Event Eh - Zebes timebomb set
            80h: Event Fh - critters escaped
        }
        $7E:D822:
        {
            1:   Event 10h - 1st metroid hall cleared
            2:   Event 11h - 1st metroid shaft cleared
            4:   Event 12h - 2nd metroid hall cleared
            8:   Event 13h - 2nd metroid shaft cleared
            10h: Event 14h - unused
            20h: Event 15h - outran speed booster lavaquake
        }

    }
    $7E:D828..2F: Boss bits. Indexed by area
    {
        1: Area boss (Kraid, Phantoon, Draygon, both Ridleys)
        2: Area mini-boss (Spore Spawn, Botwoon, Crocomire, Mother Brain)
        4: Area torizo (Bomb Torizo, Golden Torizo)
    }
    $7E:D830..6F: Unused. Chozo block destroyed bit array. Used by unused chozo block PLMs $D700/D708. Cleared on new save file, FFh filled by demo playback
    $7E:D870..AF: Item collected bit array. Bytes 14h..3Fh are unused. See "Item PLMs.asm"
    {
        $00      $01      $02      $03      $04      $05      $06      $07      $08      $09      $0A       $10      $11      $12      $13
        01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567  01234567 01234567 01234567 01234567
        CCCCCCCC CCCCCBBB BBBB BBB BBBBBBBB  BBBBBBB BBBBB    BNNNNNNN NNNNNNNN NNNNN NN  NNNNNNN N         WWWWWWWW MMMMMMMM MMMMMMMM M M      ; Area (Crateria / Brinstar / Norfair / Wrecked Ship / Maridia)
        PMMMMEMI EMMSMPSM SRMM MMB PMIPMEES  EMEMMIP PMBEM    IMBMEIMM EPMMIRMM MMIMB MS  MMPPMEI E         MRMMESSI MSEMSMMB MRMPMSIM E I      ; Item (Energy / Reserve / Missile / Super / Power bomb / Item / Beam)
    }
    $7E:D8B0..EF: Opened door bit array. Bytes 16h..3Fh are unused. See "Door PLMs.asm"
    {
        $00      $01      $02      $03      $04      $05      $06      $07      $08      $09      $0A      $0B      $0C       $10      $11      $12      $13      $14      $15
        01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567 01234567  01234567 01234567 01234567 01234567 01234567 01234567
        CCCCCCCC CCCCCCCC CCCCCCCC CCCCCCCB BBBBBBBB BBBBBBBB BBBBBBBB BBBBBBBB BBBBBBBB CNNNNNNN NNNNNNNN NNNNNNNN N         WWWWWWWW WWWWMMMM MMMMMMMM MMMMMMMM TTTTTTTT TTTTT    ; Area (Crateria / Brinstar / Norfair / Wrecked Ship / Maridia / Tourian)
        GYgggRgg ggggGYYY YggYgggg gggggRRR RRRRggRG YGRRggGg YgRGGGgg GYRGYGgG ggggGEgg gGRGYRGg gRRGGRRR YgggEgYG g         ggggGEgg gggRRRRG RgRgGGRg RGGEgggg gggggggR ERggg    ; Door (grey / Red / Green / Yellow / Eye)
    }
    $7E:D8F0..F7: Unused. Cleared on new save file, FFh filled by demo playback
    $7E:D8F8..D907: Low: used save stations. High: used debug elevators. Indexed by area
    $7E:D908..0F: Map station byte array. Indexed by area
    $7E:D910..13: Unused
    $7E:D914: Loading game state. Used in some initialisation routines to decide what to do. Used by gunship to decide if it should do the landing sequence, if so, sets this to 5 afterwards. Used by game over screen to decide where to reload Samus to. Used by game options menu to decide what "start game" does
    {
        0: Intro
        5: Main
        1Fh: Starting at Ceres
        22h: Escaping Ceres / landing on Zebes
    }
    $7E:D916: SRAM save station index
    $7E:D918: SRAM area index
    $7E:D91A: Global number of items loaded counter
    $7E:D91C..DE1B: Exported map data. Bytes 147h..4FFh are unused. See $81:8131
    {
        $7E:D91C..65: Crateria
        $7E:D966..AD: Brinstar
        $7E:D9AE..F9: Norfair
        $7E:D9FA..DA0B: Wrecked Ship
        $7E:DA0C..4D: Maridia
        $7E:DA4E..62: Tourian
    }
}
$7E:DE1C..6B: PLM instruction timers
$7E:DE6C..BB: PLM draw instruction pointers
$7E:DEBC..DF0B: PLM link instructions (instructions $8A24, $8A2E, $8A3A)
$7E:DF0C..5B: PLM variables
{
    PLM item GFX index for item PLMs ($84:831A)
    PLM door hit counter for door PLMs ($84:8A91)
    Samus Y position for Brinstar plants (used by $84:AC89, set by $84:B0DC/B113)
}
$7E:DF5C..EF5B: Backup of BG2 tilemap during pause menu. The first word is actually read incorrectly and ends up being a copy of the second word (see $82:8D51)
$7E:EF5C..73: Enemy GFX data. 4 slots. Used by $A0:92DB (spawn enemy parts)
{
    $7E:EF5C..63: Enemy IDs (2-byte slots)
    $7E:EF64..6B: Enemy tiles index (in units of tiles) (2-byte slots)
    $7E:EF6C..73: Enemy palette indices (from enemy set) (2-byte slots)
}
$7E:EF74: Enemy GFX data stack pointer
$7E:EF76: Next enemy tiles index
$7E:EF78..F377: Sprite object RAM
{
    $7E:EF78..B7: Sprite object instruction list pointers

    $7E:EFF8..F037: Sprite object instructions/timers

    $7E:F078..F0F7: Sprite object palettes / VRAM indices
    $7E:F0F8..F137: Sprite object X positions

    $7E:F178..F1F7: Sprite object X subpositions. Used only for evir
    $7E:F1F8..F237: Sprite object Y positions

    $7E:F278..F2F7: Sprite object Y subpositions. Used only for evir
    $7E:F2F8..F337: Sprite object disable flags. Set only by metroid for electricity and shell sprite objects when frozen
}
$7E:F378: Enemy processing stage. Never read, presumably used for debugging or performance profiling
{
    1: Adding enemy spritemap to OAM (not including extended spritemap)
    2: Processing enemy instructions
    3: Enemy / projectile collision handler - extended spritemap
    4: Enemy / bomb collision handler - extended spritemap
    5: Processing enemy power bomb interaction
    6: Enemy / Samus collision handler - extended spritemap
    7: Enemy / projectile collision handler
    8: Enemy / bomb collision handler
    9: Enemy / Samus collision handler
    Ah: Processing bomb jump
    Bh: Enemy projectile / Samus collision detection
    Ch: Enemy projectile / projectile collision detection
}
$7E:F37A: Set to [enemy instruction pointer] for non multi-hitbox enemies in $A0:944A (write enemy OAM). Never read
$7E:F37C: Set to [enemy index] for non multi-hitbox enemies in $A0:944A (write enemy OAM). Never read
$7E:F37E: Set to [enemy ID] for non multi-hitbox enemies in $A0:944A (write enemy OAM). Never read
$7E:F380..F49F: Enemy projectile data. Cleared in enemy initialisation ($A0:8A9E)
{
    $7E:F380..A3: Enemy projectile projectile collision options
    {
        1: Enable buggy dud shot for projectile collision. Usually fails to spawn dud shot graphics (see $A0:99F9), but the sound effect works. Shot instruction list is ignored. Used by fire arc body and Botwoon
        2: Disable interaction with projectiles. Used by Botwoon's body when in the background
    }
    $7E:F3A4..C7: Unused
    $7E:F3C8..EB: Enemy projectile enemy header pointer. Set by pickup / enemy death explosion init. Used by random drop routine ($86:F106)
    $7E:F3EC..F40F: Unused
    $7E:F410..33: Enemy projectile killed enemy index, if highest bit set, enemy respawns ($86:EF10). FFFFh = no enemy. Initialised to FFFFh
    $7E:F434: Special death item drop X origin position
    $7E:F436: Special death item drop Y origin position
    $7E:F438..9F: Unused
}
$7E:F4A0..FFFF: Unused

; Gameplay
{
$7F:0000: Size of level data in bytes (and size of custom background, and 2x size of BTS)
$7F:0002..6401: Level data (layer 1). Word per block: ttttyxnnnnnnnnnn. t = block type (see "Special blocks.asm"), yx are Y/X flips, n = tile table index (see $7E:A000)
$7F:6402..9601: BTS. Byte per block. See "Special blocks.asm"
$7F:9602..FA01: Custom background (layer 2). Word per block: 0000yxnnnnnnnnnn. yx are Y/X flips, n = block index (into tile table, see $7E:A000)
}

; Non-gameplay
{
    $7F:0000..3FFF: Ending gunship tiles
    $7F:0000..1FFF: Credits tilemap

    $7F:4000..BFFF: Post-credits Samus beam (interleaved tiles/tilemap)
    $7F:4000..7FFF: Ending gunship tilemap
    $7F:4000..48FF: Ceres cutscene gunship/Ceres tilemap
    {
        $7F:4000..42FF: Gunship front
        $7F:4300..45FF: Gunship back
        $7F:4600..4BFF: Ceres
        $7E:4C00..4FFF: Clear tilemap (with tile 8Ch). Only first 300h bytes used
    }

    $7F:8000..DFFF: Zebes explosion tiles
    $7F:8000..88FF: Intro font 1 tiles

    $7F:9000..93FF: Title baby metroid tiles. 4 frames of 100h bytes, the last of which is seemingly unused

    $7F:A000..B1FF: Intro font 2 tiles

    $7F:C000..D7FF: Credits / post-credits font 3
    {
        $7F:D000..D3FF: Item percentage Japanese text (loaded only for the post-credits)
    }

    $7F:C000..C7FF: Game options menu tilemap - options screen
    $7F:C800..CFFF: Game options menu tilemap - controller settings - English
    $7F:D000..D7FF: Game options menu tilemap - controller settings - Japanese
    $7F:D800..DFFF: Game options menu tilemap - special settings - English

    $7F:E000..E7FF: Game options menu tilemap - special settings - Japanese
    $7F:E000..E7FF: Wide part of Zebes explosion tilemap

    $7F:E800..EFFF: Concentric wide part of Zebes explosion tilemap
    $7F:F000..F7FF: Eclipse of Zebes during explosion tilemap
    $7F:F800..FFFF: Ending blank tilemap
}
