$0F78: ID (TK_Num in enemy debugger)
$0F7A: X position
$0F7C: X subposition
$0F7E: Y position
$0F80: Y subposition
$0F82: X radius
$0F84: Y radius
$0F86: Properties (Special in SMILE, Properties 1 in SMART, Switch in enemy debugger). Sometimes used as another initialisation parameter (creepy crawlies)
{
    8000h: Hitbox solid to Samus
    4000h: Respawns if killed
    2000h: Process instructions
    1000h: Block plasma beam
    800h: Process whilst off-screen
    400h: Intangible
    200h: Delete
    100h: Invisible
}
$0F88: Extra properties (Special GFX in SMILE, Graphics in RF, Properties 2 in SMART, Switch2 in enemy debugger). Sometimes used as another initialisation parameter (shutters, up/down movers)
{
    8000h: Processed a new enemy instruction with $0F92, update graphics
    4: Enable extended spritemap format
    1: Paralysed (by grapple beam). Enemy AI isn't run (unless intangible), enemy dies when flash timer (or frozen timer) reaches 1
}
$0F8A: AI handler (TK_Stat in enemy debugger). Lowest bit set determines which AI pointer in enemy data to use
{
    0: Main AI
    1: Grapple AI
    2: Hurt AI
    4: Frozen AI
}
$0F8C: Health
$0F8E: Spritemap pointer (Patern in enemy debugger)
{
    Extended spritemap format:
        [word] Number of entries (top byte ignored)
        [entries]

        Entry format:
            [word] X offset
            [word] Y offset
            [word] Spritemap pointer (see bank $81), or extended tilemap if [spritemap pointer] = FFFEh
            [word] Hitbox pointer

            Extended tilemap format (used by Phantoon, Draygon, Croc and MB):
            {
                [word] FFFEh
                [entries]
                [word] FFFFh

                Entry format:
                    [word] Destination (in bank $7E)
                    [word] Number of tiles (size of tilemap / 2)
                    [tilemap]
            }
            Hitbox format:
            {
                [word] Number of entries
                [entries]

                Entry format:
                    [word] Left offset
                    [word] Top offset
                    [word] Right offset
                    [word] Bottom offset
                    [word] Touch AI pointer (Samus collision)
                    [word] Shot AI pointer (projectile collision)
            }
}
$0F90: Timer (LpCnt in enemy debugger) (according to $A0:8123 and associated instructions)
$0F92: Initialisation parameter (Orientation in SMILE, Tilemaps in RF, Tilemap Parameter in SMART) / instruction list pointer (PoseAdr in enemy debugger). Positive instructions set delay timer and $0F8E, and highest bit of $0F88
$0F94: Instruction timer (WaitTim in enemy debugger)
$0F96: Palette index (ColorPa in enemy debugger). Multiple of 200h
$0F98: VRAM tiles index (CharaOf in enemy debugger). Range 0..1FFh
$0F9A: Layer
{
    Order of drawing:
        Sprite objects
        Bombs and projectile explosions
        High priority enemy projectiles
        Layer 0
        Layer 1
        Layer 2
        Samus
        Projectiles
        Layer 3
        Layer 4
        Layer 5
        Low priority enemy projectiles
        Layer 6
        Layer 7
}
$0F9C: Flash timer (FlashCo in enemy debugger). Graphical effect only. Hurt AI is disabled when less than 8
$0F9E: Frozen timer (IceCoun in enemy debugger)
$0FA0: Invincibility timer (HitCoun in enemy debugger). Decrements even during x-ray. Set to Ah when frozen, set to 10h when hit by plasma, set to 30h by power bomb
$0FA2: Shake timer (PlplCou in enemy debugger)
$0FA4: Frame counter (TK_UPTM in enemy debugger). Number of frames processed from when the enemy comes on screen, counting every frame for enemies who process off screen and otherwise pause when the enemy goes offscreen
$0FA6: Bank (TK_Bank in enemy debugger)
$0FA8: AI variable (Pwork0 in enemy debugger), frequently function pointer
$0FAA: AI variable (Pwork1 in enemy debugger)
$0FAC: AI variable (Pwork2 in enemy debugger)
$0FAE: AI variable (Pwork3 in enemy debugger)
$0FB0: AI variable (Pwork4 in enemy debugger)
$0FB2: AI variable (Pwork5 in enemy debugger). Function pointer for enemies that use instruction $806B(?)
$0FB4: Parameter 1 (Speed in SMILE, InitOP0 in enemy debugger)
$0FB6: Parameter 2 (Speed 2 in SMILE, InitOP1 in enemy debugger)

; All AI variables are cleared on enemy spawn

Enemy header:
0: Tile data size
2: Palette
4: Health
6: Damage
8: Width
Ah: Height
Ch: Bank
Dh: Hurt AI time
Eh: Cry
10h: Boss ID
12h: Initialisation AI
14h: Number of parts
18h: Main AI
1Ah: Grapple AI
1Ch: Hurt AI
1Eh: Frozen AI
20h: Time is frozen AI
22h: Death animation
28h: Power bomb reaction
2Ah: Sidehopper variant index. Unused proto instruction list (see $A0:AE7C) for flies, (multi)viola, ripper (ii), Ceres door
30h: Enemy touch
32h: Enemy shot
36h: Tile data
39h: Layer
3Ah: Drop chances ($B4)
3Ch: Vulnerabilities ($B4)
3Eh: Enemy name ($B4)
