;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687..CA00: Kraid ;;;
{
;;; $8687..A929: Kraid data ;;;
{
;;; $8687: Palette - enemy $E2BF/$E2FF/$E33F/$E37F/$E3BF/$E3FF/$E43F/$E47F (Kraid) ;;;
{
$A7:8687             dw 3800, 559D, 1816, 100D, 4B9F, 3F37, 36D0, 2E69, 2608, 1DA6, 1125, 08C5, 0003, 6318, 7FFF, 0000
}


;;; $86A7: Unused. Palette ;;;
{
; Clone of $8687
$A7:86A7             dw 3800, 559D, 1816, 100D, 4B9F, 3F37, 36D0, 2E69, 2608, 1DA6, 1125, 08C5, 0003, 6318, 7FFF, 0000
}


;;; $86C7: Kraid room background palette ;;;
{
; BG palette 6
$A7:86C7             dw 0400, 2D6B, 2D6B, 2D6B, 1986, 14C2, 0840, 0400, 31ED, 18C6, 10C3, 0420, 0252, 2D6B, 4A52, 0000
}


;;; $86E7..A715: Instruction lists et al ;;;
{
;;; $86E7..8B2D: Instruction lists ;;;
{
;;; $86E7: Instruction list - Kraid foot - initial ;;;
{
$A7:86E7             dx 7FFF,A565,
                        812F        ; Sleep
}


;;; $86ED: Instruction list - Kraid foot - Kraid is big - neutral ;;;
{
$A7:86ED             dx 7FFF,8CE3,
                        812F        ; Sleep
}


;;; $86F3: Instruction list - Kraid foot - Kraid is big - walking forwards ;;;
{
$A7:86F3             dw B633,       ; NOP
                        0004,8CE3,
                        0004,8CF5,
                        0004,8D07,
                        0004,8D19,
                        0004,8D2B,
                        0004,8D3D,
                        0004,8D4F,
                        0004,8D61,
                        0004,8D73,
                        0004,8D85,
                        0004,8D97,
                        0003,8DA9,
                        0001,8DBB,
                        0001,8DCD,
                        0001,8DDF,
                        0001,8DF1,
                        0001,8E03,
                        0010,8E15,
                        B636,       ; Decrement Kraid Y position
                        B65A,       ; Kraid X position -= 3
                        0001,8E27,
                        B636,       ; Decrement Kraid Y position
                        B65A,       ; Kraid X position -= 3
                        0001,8E39,
                        B633,       ; NOP
                        0003,8E39,
                        B636,       ; Decrement Kraid Y position
                        B65A,       ; Kraid X position -= 3
                        0001,8E39,
                        B633,       ; NOP
                        0003,8E39,
                        B636,       ; Decrement Kraid Y position
                        B65A,       ; Kraid X position -= 3
                        0001,8E5D,
                        B633,       ; NOP
                        0003,8E5D,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B65A,       ; Kraid X position -= 3
                        0001,8E6F,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B65A,       ; Kraid X position -= 3
                        0001,8E81,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B65A,       ; Kraid X position -= 3
                        0001,8E93,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B65A,       ; Kraid X position -= 3
                        B64E,       ; Queue sound 76h, sound library 2, max queued sounds allowed = 6 (quake)
                        0001,8EA5,
                        B633,       ; NOP
                        B65A,       ; Kraid X position -= 3
                        0001,8EB7,
                        B65A,       ; Kraid X position -= 3
                        0001,8EC9,
                        B65A,       ; Kraid X position -= 3
                        0001,8EDB,
                        B65A,       ; Kraid X position -= 3
                        0001,8EED,
                        B65A,       ; Kraid X position -= 3
                        0001,8EFF,
                        B65A,       ; Kraid X position -= 3
                        0001,8F11,
                        0001,8CE3
$A7:87BB             dw 812F        ; Sleep
}


;;; $87BD: Instruction list - Kraid foot - lunge forward ;;;
{
; This is just $86F3 but faster
$A7:87BD             dw B633,       ; NOP
                        0001,8CE3,
                        0001,8CF5,
                        0001,8D07,
                        0001,8D19,
                        0001,8D2B,
                        0001,8D3D,
                        0001,8D4F,
                        0001,8D61,
                        0001,8D73,
                        0001,8D85,
                        0001,8D97,
                        0001,8DA9,
                        0001,8DBB,
                        0001,8DCD,
                        0001,8DDF,
                        0001,8DF1,
                        0001,8E03,
                        0004,8E15,
                        B636,       ; Decrement Kraid Y position
                        B667,       ; Kraid X position -= 3
                        0001,8E27,
                        B636,       ; Decrement Kraid Y position
                        B667,       ; Kraid X position -= 3
                        0001,8E39,
                        B633,       ; NOP
                        0001,8E39,
                        B636,       ; Decrement Kraid Y position
                        B667,       ; Kraid X position -= 3
                        0001,8E39,
                        B633,       ; NOP
                        0001,8E39,
                        B636,       ; Decrement Kraid Y position
                        B667,       ; Kraid X position -= 3
                        0001,8E5D,
                        B633,       ; NOP
                        0001,8E5D,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B667,       ; Kraid X position -= 3
                        0001,8E6F,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B667,       ; Kraid X position -= 3
                        0001,8E81,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B667,       ; Kraid X position -= 3
                        0001,8E93,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B667,       ; Kraid X position -= 3
                        B64E,       ; Queue sound 76h, sound library 2, max queued sounds allowed = 6 (quake)
                        0001,8EA5,
                        B633,       ; NOP
                        B667,       ; Kraid X position -= 3
                        0001,8EB7,
                        B667,       ; Kraid X position -= 3
                        0001,8EC9,
                        B667,       ; Kraid X position -= 3
                        0001,8EDB,
                        B667,       ; Kraid X position -= 3
                        0001,8EED,
                        B667,       ; Kraid X position -= 3
                        0001,8EFF,
                        0001,8F11,
                        B667,       ; Kraid X position -= 3
                        0001,8CE3
$A7:8885             dw 812F        ; Sleep
}


;;; $8887: Instruction list - Kraid foot - Kraid is big - walking backwards ;;;
{
$A7:8887             dw B633,       ; NOP
                        B674,       ; Kraid X position += 3
                        0004,8F47,
                        B674,       ; Kraid X position += 3
                        0001,8F23,
                        B674,       ; Kraid X position += 3
                        0001,8EFF,
                        B674,       ; Kraid X position += 3
                        0001,8EED,
                        B674,       ; Kraid X position += 3
                        0001,8EDB,
                        B674,       ; Kraid X position += 3
                        0001,8EC9,
                        B674,       ; Kraid X position += 3
                        0001,8EB7,
                        B636,       ; Decrement Kraid Y position
                        B674,       ; Kraid X position += 3
                        0001,8EA5,
                        B636,       ; Decrement Kraid Y position
                        B674,       ; Kraid X position += 3
                        0001,8E93,
                        B636,       ; Decrement Kraid Y position
                        B674,       ; Kraid X position += 3
                        0001,8E81,
                        B636,       ; Decrement Kraid Y position
                        B674,       ; Kraid X position += 3
                        0001,8E6F,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B674,       ; Kraid X position += 3
                        0001,8E5D,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B674,       ; Kraid X position += 3
                        0001,8E4B,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B674,       ; Kraid X position += 3
                        0001,8E39,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B64E,       ; Queue sound 76h, sound library 2, max queued sounds allowed = 6 (quake)
                        0001,8E27,
                        B633,       ; NOP
                        0014,8E15,
                        0004,8E03,
                        0004,8DF1,
                        0004,8DDF,
                        0004,8DCD,
                        0004,8DBB,
                        0004,8DA9,
                        0004,8D97,
                        0004,8D85,
                        0001,8D73,
                        0001,8D61,
                        0001,8D4F,
                        0001,8D3D,
                        0001,8D2B,
                        0001,8D19,
                        0001,8D07,
                        0001,8CF5 
$A7:8939             dw 80ED,8887   ; Go to $8887
}


;;; $893D: Unused. Instruction list - Kraid foot - walking backwards - fast ;;;
{
$A7:893D             dx B633,       ; NOP
                        B683,       ; Move Kraid right
                        0004,8F47,
                        B683,       ; Move Kraid right
                        0001,8F23,
                        B683,       ; Move Kraid right
                        0001,8EFF,
                        B683,       ; Move Kraid right
                        0001,8EED,
                        B683,       ; Move Kraid right
                        0001,8EDB,
                        B683,       ; Move Kraid right
                        0001,8EC9,
                        B683,       ; Move Kraid right
                        0001,8EB7,
                        B636,       ; Decrement Kraid Y position
                        B683,       ; Move Kraid right
                        0001,8EA5,
                        B636,       ; Decrement Kraid Y position
                        B683,       ; Move Kraid right
                        0001,8E93,
                        B636,       ; Decrement Kraid Y position
                        B683,       ; Move Kraid right
                        0001,8E81,
                        B636,       ; Decrement Kraid Y position
                        B683,       ; Move Kraid right
                        0001,8E6F,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B683,       ; Move Kraid right
                        0001,8E5D,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B683,       ; Move Kraid right
                        0001,8E4B,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B683,       ; Move Kraid right
                        0001,8E39,
                        B63C,       ; Increment Kraid Y position, set screen shaking
                        B64E,       ; Queue sound 76h, sound library 2, max queued sounds allowed = 6 (quake)
                        0001,8E27,
                        B633,       ; NOP
                        0014,8E15,
                        0004,8E03,
                        0004,8DF1,
                        0004,8DDF,
                        0004,8DCD,
                        0004,8DBB,
                        0004,8DA9,
                        0004,8D97,
                        0004,8D85,
                        0001,8D73,
                        0001,8D61,
                        0001,8D4F,
                        0001,8D3D,
                        0001,8D2B,
                        0001,8D19,
                        0001,8D07,
                        0001,8CF5,
                        80ED,893D,  ; Go to $893D
}


;;; $89F3: Instruction list - Kraid arm - normal ;;;
{
$A7:89F3             dw 0006,8F59,
                        0006,8F83,
                        0006,8FAD,
                        0006,8FD7,
                        0006,9001,
                        0006,902B,
                        0006,9055,
                        0006,907F,
                        0006,90A9,
                        0006,90D3,
                        0006,907F,
                        0006,9055,
                        0006,902B,
                        0006,9001,
                        0006,8FD7,
                        0006,8FAD,
                        0006,8F83
$A7:8A37             dw 0020,8F59,
                        8A8F,       ; Slow Kraid arm if Kraid has less than half health
                        80ED,89F3   ; Go to $89F3
}


;;; $8A41: Instruction list - Kraid arm - slow ;;;
{
$A7:8A41             dw 0008,8F59,
                        0008,8F83,
                        0008,8FAD,
                        0008,8FD7,
                        0008,9001,
                        0008,902B,
                        0008,9055,
                        0008,907F,
                        0008,90A9,
                        0008,90D3,
                        0008,907F,
                        0008,9055,
                        0008,902B,
                        0008,9001,
                        0008,8FD7,
                        0008,8FAD,
                        0008,8F83,
                        0030,8F59,
                        8A8F,       ; Slow Kraid arm if Kraid has less than half health (effectively just "go to $8A41")
                        80ED,8A41   ; Go to $8A41
}


;;; $8A8F: Instruction - slow Kraid arm if Kraid has less than half health ;;;
{
$A7:8A8F AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:8A92 CF 12 78 7E CMP $7E7812[$7E:7812]  ;} If [Kraid's HP] < [1/2 Kraid health]:
$A7:8A96 10 0B       BPL $0B    [$8AA3]     ;/
$A7:8A98 AD D2 0F    LDA $0FD2  [$7E:0FD2]  ;\
$A7:8A9B C9 41 8A    CMP #$8A41             ;} If [Kraid arm instruction list pointer] < $8A41 (normal):
$A7:8A9E 10 03       BPL $03    [$8AA3]     ;/
$A7:8AA0 A0 41 8A    LDY #$8A41             ; Y = Kraid arm - slow

$A7:8AA3 6B          RTL
}


;;; $8AA4: Instruction list - Kraid arm - rising/sinking ;;;
{
; Same as $89F3 (normal), but the spritemaps all have lower priority sprites
$A7:8AA4             dx 0006,90FD,
                        0006,9127,
                        0006,9151,
                        0006,917B,
                        0006,91A5,
                        0006,91CF,
                        0006,91F9,
                        0006,9223,
                        0006,924D,
                        0006,9277,
                        0006,9223,
                        0006,91F9,
                        0006,91CF,
                        0006,91A5,
                        0006,917B,
                        0006,9151,
                        0006,9127,
                        0020,90FD,
                        80ED,8AA4   ; Go to $8AA4
}


;;; $8AF0: Instruction list - Kraid arm - dying / preparing to lunge forward ;;;
{
$A7:8AF0             dx 0006,8F59,
                        0006,92A1,
                        7FFF,92AB,
                        812F        ; Sleep
}


;;; $8AFE: Instruction list - Kraid lint - initial ;;;
{
$A7:8AFE             dx 7FFF,A5DF,
                        812F        ; Sleep
}


;;; $8B04: Instruction list - Kraid lint - Kraid is big ;;;
{
$A7:8B04             dx 7FFF,8C6C,
                        812F        ; Sleep
}


;;; $8B0A: Instruction list - fingernail ;;;
{
$A7:8B0A             dw 0003,A617,
                        0003,A623,
                        0003,A639,
                        0003,A645,
                        0003,A65B,
                        0003,A667,
                        0003,A67D,
                        0003,A689,
                        80ED,8B0A   ; Go to $8B0A
}
}


;;; $8B2E..948A: (Extended) spritemaps ;;;
{
;;; $8B2E: Unused. Extended spritemaps - Kraid arm ;;;
{
$A7:8B2E             dw 0002, 0000,0000,9572,93F7, FFF7,FFF6,94E1,92D1
$A7:8B40             dw 0002, FFF9,FFF8,94E8,92EB, 0001,0000,9572,93F7
$A7:8B52             dw 0002, FFF8,FFF8,94F4,92F9, 0000,0000,9572,93F7
$A7:8B64             dw 0002, FFF8,FFF8,94FB,9313, 0000,0000,9572,93F7
$A7:8B76             dw 0002, FFF6,0001,94E8,92EB, 0000,0000,952D,9371
$A7:8B88             dw 0002, FFF6,0000,94F4,92F9, 0000,0000,952D,9371
$A7:8B9A             dw 0002, FFF6,0000,94FB,9313, 0000,0000,952D,9371
$A7:8BAC             dw 0002, FFF6,0000,9507,9321, 0000,0000,952D,9371
$A7:8BBE             dw 0002, FFFA,0006,94F4,92F9, 0000,0000,9539,937F
$A7:8BD0             dw 0002, FFFA,0006,94FB,9313, 0000,0000,9539,937F
$A7:8BE2             dw 0002, FFF8,0006,9507,9321, 0000,0000,9539,937F
$A7:8BF4             dw 0002, FFF8,0006,950E,933B, 0000,0000,9539,937F
$A7:8C06             dw 0002, 0001,000A,94FB,9313, 0000,0000,9540,9399
$A7:8C18             dw 0002, 0000,000A,9507,9321, 0000,0000,9540,9399
$A7:8C2A             dw 0002, FFFF,000C,950E,933B, 0000,0000,9540,9399
$A7:8C3C             dw 0002, 0000,000B,951A,9349, 0000,0000,9540,9399
$A7:8C4E             dw 0001, 0000,0000,95B4,9439
$A7:8C58             dw 0001, 0000,0000,958A,941F
$A7:8C62             dw 0001, 0000,0000,9579,9411
}


;;; $8C6C: Spritemap - Kraid lint - Kraid is big ;;;
{
$A7:8C6C             dx 0005, 01F4,08,21C2, 81E4,00,21B0, 81F4,F8,21A2, 81E4,F8,21A0, 8004,F8,21A9
}


;;; $8C87: Unused. Extended spritemaps - Kraid foot ;;;
{
$A7:8C87             dw 0001, 0000,0000,94DA,92C3
$A7:8C91             dw 0002, 0000,0000,95DE,92C3, 000C,0030,9686,92C3
$A7:8CA3             dw 0002, 0000,0000,9608,92C3, 0000,0039,9686,92C3
$A7:8CB5             dw 0002, 0000,0000,9632,92C3, FFF0,003F,9686,92C3
$A7:8CC7             dw 0002, 0000,0000,965C,92C3, FFDF,003D,9686,92C3
$A7:8CD9             dw 0001, 0000,0000,96CB,9461
}


;;; $8CE3: Extended spritemaps - Kraid foot ;;;
{
$A7:8CE3             dw 0002, 0008,0028,9686,9453, 0000,0000,95DE,9453
$A7:8CF5             dw 0002, 0006,0027,9686,9453, FFFE,FFFF,95DE,9453
$A7:8D07             dw 0002, 0004,0026,9686,9453, FFFC,FFFE,95DE,9453
$A7:8D19             dw 0002, 0002,0025,9686,9453, FFFA,FFFD,95DE,9453
$A7:8D2B             dw 0002, 0000,0024,9686,9453, FFF8,FFFC,95DE,9453
$A7:8D3D             dw 0002, FFFE,0023,9686,9453, 0005,FFF1,9608,9453
$A7:8D4F             dw 0002, FFFC,0022,9686,9453, 0003,FFF0,9608,9453
$A7:8D61             dw 0002, FFFA,0021,9686,9453, 0001,FFEF,9608,9453
$A7:8D73             dw 0002, FFF8,0020,9686,9453, FFFF,FFEE,9608,9453
$A7:8D85             dw 0002, FFF6,001F,9686,9453, FFFD,FFED,9608,9453
$A7:8D97             dw 0002, FFF4,001D,9686,9453, 000C,FFE6,9632,9453
$A7:8DA9             dw 0002, FFF2,001C,9686,9453, 001A,FFE9,965C,9453
$A7:8DBB             dw 0002, FFF0,001E,9686,9453, 0018,FFEB,965C,9453
$A7:8DCD             dw 0002, FFEE,0020,9686,9453, 0016,FFED,965C,9453
$A7:8DDF             dw 0002, FFEC,0022,9686,9453, 0014,FFEF,965C,9453
$A7:8DF1             dw 0002, FFEA,0024,9686,9453, 0012,FFF1,965C,9453
$A7:8E03             dw 0002, FFE8,0026,9686,9453, 0010,FFF3,965C,9453
$A7:8E15             dw 0002, FFE6,0028,9686,9453, 000E,FFF5,965C,9453
$A7:8E27             dw 0002, FFE8,0028,9686,9453, 0010,FFF6,965C,9453
$A7:8E39             dw 0002, FFEA,0028,9686,9453, 0012,FFF6,965C,9453
$A7:8E4B             dw 0002, FFEC,0028,9686,9453, 0014,FFF6,965C,9453
$A7:8E5D             dw 0002, FFEE,0028,9686,9453, 0006,FFF1,9632,9453
$A7:8E6F             dw 0002, FFF0,0028,9686,9453, 0008,FFF1,9632,9453
$A7:8E81             dw 0002, FFF2,0028,9686,9453, FFF9,FFF6,9608,9453
$A7:8E93             dw 0002, FFF4,0028,9686,9453, FFFB,FFF6,9608,9453
$A7:8EA5             dw 0002, FFF6,0028,9686,9453, FFFD,FFF6,9608,9453
$A7:8EB7             dw 0002, FFF8,0028,9686,9453, FFFF,FFF6,9608,9453
$A7:8EC9             dw 0002, FFFA,0028,9686,9453, 0001,FFF6,9608,9453
$A7:8EDB             dw 0002, FFFC,0028,9686,9453, 0003,FFF6,9608,9453
$A7:8EED             dw 0002, FFFE,0028,9686,9453, 0005,FFF6,9608,9453
$A7:8EFF             dw 0002, 0000,0028,9686,9453, 0007,FFF6,9608,9453
$A7:8F11             dw 0002, 0002,0028,9686,9453, FFFA,0000,95DE,9453
$A7:8F23             dw 0002, 0004,0028,9686,9453, FFFC,0000,95DE,9453
$A7:8F35             dw 0002, 0006,0028,9686,9453, FFFE,0000,95DE,9453 ; <-- Unused
$A7:8F47             dw 0002, 0008,0028,9686,9453, 0000,0000,95DE,9453
}


;;; $8F59: Extended spritemaps - Kraid arm ;;;
{
; General
$A7:8F59             dw 0005, FFDC,FFDF,94E1,92D1, FFE4,FFE8,9572,93F7, 0000,0000,95B4,9439, FFDC,FFD8,94E1,92D1, FFE4,FFE1,9572,93F7
$A7:8F83             dw 0005, FFDA,FFDF,94E8,92EB, FFE2,FFE6,9572,93F7, 0000,0000,95B4,9439, FFDC,FFD8,94E1,92D1, FFE4,FFE1,9572,93F7
$A7:8FAD             dw 0005, FFD0,FFF3,94F4,92F9, FFDA,FFF3,952D,9371, 0000,0000,958A,941F, FFD3,FFE5,94E8,92EB, FFDB,FFED,9572,93F7
$A7:8FD7             dw 0005, FFD2,FFF3,94FB,9313, FFDB,FFF3,952D,9371, 0000,0000,958A,941F, FFD3,FFED,94F4,92F9, FFDC,FFEE,952D,9371
$A7:9001             dw 0005, FFD3,0008,9507,9321, FFDA,0002,9539,937F, 0000,0000,9579,9411, FFD2,0003,94FB,9313, FFD9,FFFD,9539,937F
$A7:902B             dw 0005, FFD4,0008,9507,9321, FFDB,0002,9539,937F, 0000,0000,9579,9411, FFD2,0004,9507,9321, FFD9,FFFE,9539,937F
$A7:9055             dw 0005, FFD9,000A,950E,933B, FFDA,0000,9540,9399, 0000,0000,9579,9411, FFD5,000A,950E,933B, FFD7,FFFE,9540,9399
$A7:907F             dw 0005, FFD9,000A,950E,933B, FFDA,0000,9540,9399, 0000,0000,9579,9411, FFD5,0009,950E,933B, FFD7,FFFE,9540,9399
$A7:90A9             dw 0005, FFD9,000A,951A,9349, FFDA,0000,9540,9399, 0000,0000,9579,9411, FFD5,0009,950E,933B, FFD7,FFFE,9540,9399
$A7:90D3             dw 0005, FFD9,000A,951A,9349, FFDA,0000,9540,9399, 0000,0000,9579,9411, FFD6,0009,951A,9349, FFD6,FFFE,9540,9399

; Rising/sinking
$A7:90FD             dw 0005, FFDC,FFDF,A47C,92D1, FFE4,FFE8,A4DB,93F7, 0000,0000,A53B,9439, FFDC,FFD8,A47C,92D1, FFE4,FFE1,A4DB,93F7
$A7:9127             dw 0005, FFDA,FFDF,A483,92EB, FFE2,FFE6,A4DB,93F7, 0000,0000,A53B,9439, FFDC,FFD8,A47C,92D1, FFE4,FFE1,A4DB,93F7
$A7:9151             dw 0005, FFD0,FFF3,A48F,92F9, FFDA,FFF3,A4BC,9371, 0000,0000,A511,941F, FFD3,FFE5,A483,92EB, FFDB,FFED,A4DB,93F7
$A7:917B             dw 0005, FFD2,FFF3,A496,9313, FFDB,FFF3,A4BC,9371, 0000,0000,A511,941F, FFD3,FFED,A48F,92F9, FFDC,FFEE,A4BC,9371
$A7:91A5             dw 0005, FFD3,0008,A4A2,9321, FFDA,0002,A4C8,937F, 0000,0000,A500,9411, FFD2,0003,A496,9313, FFD9,FFFD,A4C8,937F
$A7:91CF             dw 0005, FFD4,0008,A4A2,9321, FFDB,0002,A4C8,937F, 0000,0000,A500,9411, FFD2,0004,A4A2,9321, FFD9,FFFE,A4C8,937F
$A7:91F9             dw 0005, FFD9,000A,A4A9,933B, FFDA,0000,A4CF,9399, 0000,0000,A500,9411, FFD5,000A,A4A9,933B, FFD7,FFFE,A4CF,9399
$A7:9223             dw 0005, FFD9,000A,A4A9,933B, FFDA,0000,A4CF,9399, 0000,0000,A500,9411, FFD5,0009,A4A9,933B, FFD7,FFFE,A4CF,9399
$A7:924D             dw 0005, FFD9,000A,A4B5,9349, FFDA,0000,A4CF,9399, 0000,0000,A500,9411, FFD5,0009,A4A9,933B, FFD7,FFFE,A4CF,9399
$A7:9277             dw 0005, FFD9,000A,A4B5,9349, FFDA,0000,A4CF,9399, 0000,0000,A500,9411, FFD6,0009,A4B5,9349, FFD6,FFFE,A4CF,9399

; Dying / preparing to lunge forward
$A7:92A1             dw 0001, 0000,0000,A69F,946F
$A7:92AB             dw 0001, 0000,0000,A6DD,947D
}


;;; $92B5: Hitbox - Kraid lint ;;;
{
; Used by $B96A
$A7:92B5             dw 0001, FFE8,FFFC,0004,0006,948B,94B5
}


;;; $92C3: Unused. Hitbox - Kraid foot ;;;
{
$A7:92C3             dw 0001, FFF8,FFF8,0007,0007,948B,94B5
}


;;; $92D1: Hitboxes - Kraid arm ;;;
{
$A7:92D1             dx 0002, FFF3,FFF5,FFFD,FFFB,9490,94B6, FFF7,FFFB,0001,0002,9490,94B6
$A7:92EB             dx 0001, FFF0,FFFB,0001,0002,9490,94B6
$A7:92F9             dx 0002, FFF7,FFFE,0001,0007,9490,94B6, FFF4,0003,FFFA,000C,9490,94B6
$A7:9313             dx 0001, FFFA,FFFF,0001,000E,9490,94B6
$A7:9321             dx 0002, FFFD,FFFE,0006,0009,9490,94B6, 0002,0007,000B,000B,9490,94B6
$A7:933B             dx 0001, FFFF,FFFC,000E,0004,9490,94B6
$A7:9349             dx 0002, FFFD,FFF9,0006,0002,9490,94B6, 0004,FFF4,000A,FFFF,9490,94B6
$A7:9363             dx 0001, FFFC,FFF2,0003,0001,948B,94B6
$A7:9371             dx 0001, FFF1,FFFB,0002,0004,9490,94B6
$A7:937F             dx 0002, FFF5,0002,FFFC,000A,9490,94B6, FFFA,FFFD,0003,0005,9490,94B6
$A7:9399             dx 0001, FFFC,FFFE,0003,000D,9490,94B6
$A7:93A7             dx 0002, 0003,0002,000A,000B,948B,94B6, FFFD,FFFD,0005,0005,948B,94B6
$A7:93C1             dx 0001, FFFD,FFFB,000E,0004,948B,94B6
$A7:93CF             dx 0002, 0002,FFF4,000B,FFFC,948B,94B6, FFFD,FFF9,0004,0002,948B,94B6
$A7:93E9             dx 0001, FFFC,FFF1,0005,0002,948B,94B6
$A7:93F7             dx 0002, FFF4,FFF4,FFFD,FFFD,9490,94B6, FFFA,FFFA,0003,0002,9490,94B6
$A7:9411             dx 0001, FFD3,FFF7,0004,0008,948B,94B6
$A7:941F             dx 0002, FFE4,FFEF,FFF4,0000,948B,94B6, FFD6,FFE9,FFE4,FFFA,948B,94B6
$A7:9439             dx 0002, FFEA,FFE7,FFF8,FFFB,948B,94B6, FFDD,FFDD,FFED,FFEF,948B,94B6
}


;;; $9453: Hitbox - Kraid foot ;;;
{
$A7:9453             dw 0001, FFFA,FFFA,0006,0006,948B,94B5
}


;;; $9461: Unused. Hitbox - Kraid foot ;;;
{
$A7:9461             dw 0001, FFFE,FFFD,0002,0003,948B,94B5
}


;;; $946F: Hitboxes - Kraid arm - dying / preparing to lunge forward ;;;
{
$A7:946F             dw 0001, FFC0,FFD0,FFE0,FFF0,948B,94B6
$A7:947D             dw 0001, FFC0,FFFC,0000,0004,948B,94B6
}
}


;;; $948B: Enemy touch - Kraid arm/foot - normal ;;;
{
$A7:948B 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI
$A7:948F 6B          RTL
}


;;; $9490: Enemy touch - enemy $E2FF (Kraid arm) ;;;
{
$A7:9490 AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$A7:9493 F0 01       BEQ $01    [$9496]     ;} If [Samus invincibility timer] != 0:
$A7:9495 6B          RTL                    ; Return

$A7:9496 20 A4 94    JSR $94A4  [$A7:94A4]  ; Push Samus back
$A7:9499 A9 9B B8    LDA #$B89B             ;\
$A7:949C 8D A8 10    STA $10A8  [$7E:10A8]  ;} Kraid bottom lint function = $B89B (fire lint)
}


;;; $949F: Enemy touch - enemy $E2BF (Kraid) ;;;
{
$A7:949F 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal enemy touch AI - no death check
$A7:94A3 6B          RTL
}


;;; $94A4: Push Samus back ;;;
{
$A7:94A4 A9 04 00    LDA #$0004             ;\
$A7:94A7 8D 58 0B    STA $0B58  [$7E:0B58]  ;} Extra Samus X displacement = 4
$A7:94AA A9 F8 FF    LDA #$FFF8             ;\
$A7:94AD 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;} Extra Samus Y displacement = -8
$A7:94B0 60          RTS
}


;;; $94B1: Normal enemy shot ;;;
{
$A7:94B1 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
$A7:94B5 6B          RTL
}


;;; $94B6: Enemy shot - Kraid arm ;;;
{
$A7:94B6 BB          TYX
$A7:94B7 20 CB B0    JSR $B0CB  [$A7:B0CB]  ; Spawn explosion enemy projectile
$A7:94BA B9 04 0C    LDA $0C04,y[$A7:F10D]  ;\
$A7:94BD 09 10 00    ORA #$0010             ;} Mark projectile for deletion
$A7:94C0 99 04 0C    STA $0C04,y[$A7:F10D]  ;/
$A7:94C3 6B          RTL
}


;;; $94C4..96D1: Spritemaps ;;;
{
;;; $94C4: Unused. Spritemap - Kraid lint ;;;
{
$A7:94C4             dx 0004, 0000,08,21C2, 81F0,00,21B0, 8000,F8,21A2, 81F0,F8,21A0
}


;;; $94DA: Unused. Spritemap - Kraid foot ;;;
{
$A7:94DA             dx 0001, 81F8,F8,21A9
}


;;; $94E1: Spritemaps - Kraid arm - general ;;;
{
$A7:94E1             dx 0001, 81F2,F4,3126
$A7:94E8             dx 0002, 01F9,FB,3129, 01F1,FB,3128
$A7:94F4             dx 0001, 81F2,FD,312A
$A7:94FB             dx 0002, 01FA,07,3139, 01FA,FF,3138
$A7:9507             dx 0001, 81FD,FD,F126
$A7:950E             dx 0002, 01FF,FD,F129, 0007,FD,F128
$A7:951A             dx 0001, 81FD,F4,F12A
$A7:9521             dx 0002, 01FC,F2,F139, 01FC,FA,F138 ; <-- Unused

$A7:952D             dx 0002, 01FA,FC,F12E, 01F2,FC,B12E
$A7:9539             dx 0001, 81F4,FC,B12C
$A7:9540             dx 0002, 01FC,06,B13E, 01FC,FE,313E
$A7:954C             dx 0001, 81FC,FC,312C               ; <-- Unused
$A7:9553             dx 0002, 0006,FC,712E, 01FE,FC,312E ; <-- Unused
$A7:955F             dx 0001, 81FC,F4,712C               ; <-- Unused
$A7:9566             dx 0002, 01FD,FA,F13E, 01FD,F2,713E ; <-- Unused
$A7:9572             dx 0001, 81F4,F4,312C

$A7:9579             dx 0003, 81F4,F8,3104, 81E4,F8,3102, 81D4,F8,3100
$A7:958A             dx 0008, 01EC,00,311C, 01FC,F0,310F, 01F4,F0,310E, 01E4,E8,310D, 01DC,F8,310C, 81F4,F8,310A, 81E4,F0,3108, 81D4,E8,3106
$A7:95B4             dx 0008, 01FC,ED,313F, 01EC,FD,312F, 01EC,F5,311F, 01EC,DD,311E, 01E4,ED,311D, 81F4,F5,3124, 81EC,E5,3122, 81DC,DD,3120
}


;;; $95DE: Spritemaps - Kraid foot ;;;
{
$A7:95DE             dx 0008, 8020,1C,315A, 8020,14,314A, 8010,1C,3148, 01F8,0C,314C, 8010,0C,3146, 8000,0C,3144, 8008,FC,3142, 81F8,FC,3140
$A7:9608             dx 0008, 8012,28,3168, 800A,28,3167, 8010,18,3182, 8000,18,3180, 8008,08,3165, 81F8,08,3163, 8000,F8,3161, 81F8,F8,3160
$A7:9632             dx 0008, 81F9,2C,31AD, 81F8,1C,318D, 81F8,0C,316D, 81F8,FC,314D, 8001,2C,31AE, 8000,1C,318E, 8000,0C,316E, 8000,FC,314E
$A7:965C             dx 0008, 81F0,2C,31A5, 81E8,2C,31A4, 81F8,1C,31CE, 81E8,1C,31CC, 8000,0C,317A, 81F0,0C,3188, 8000,FC,3186, 81F0,FC,3184

$A7:9686             dx 000C, 01D8,F4,31C3, 0018,F4,319A, 8000,F4,31C8, 81F0,F4,31C6, 81E0,F4,31C4, 81D0,FC,31A7, 8020,FC,31AB, 8020,F4,319B, 8010,FC,31DA, 8000,FC,31D8, 81F0,FC,31D6, 81E0,FC,31D4
}


;;; $96C4: Unused. Spritemaps - Kraid foot ;;;
{
$A7:96C4             dx 0001, 81F8,F8,21D0
$A7:96CB             dx 0001, 01FC,FC,21D2
}
}


;;; $96D2..9787: Kraid instruction lists ;;;
{
;;; $96D2: Kraid instruction list - roar ;;;
{
;                        ________________ Timer
;                       |     ___________ Tilemap
;                       |    |     ______ Vulnerable mouth hitbox
;                       |    |    |     _ Invulnerable mouth hitbox
;                       |    |    |    |
$A7:96D2             dw 000A,97C8,9788,FFFF
$A7:96DA             dw 000A,9AC8,9790,97B0
$A7:96E2             dw 000A,9DC8,9798,97B8
$A7:96EA             dw AF94                 ; Play Kraid roar sound effect
$A7:96EC             dw 0040,A0C8,97A0,97C0  ; <-- Mouth is fully open
$A7:96F4             dw 000A,9DC8,9798,97B8
$A7:96FC             dw 000A,9AC8,9790,97B0
$A7:9704             dw 000A,97C8,9788,FFFF
$A7:970C             dw FFFF
}


;;; $970E: Kraid instruction list - dying roar ;;;
{
$A7:970E             dw 0014,97C8,9788,FFFF
$A7:9716             dw 0014,9AC8,9790,97B0,
                        0014,9DC8,9798,97B8,
                        AF94                 ; Play Kraid roar sound effect
                        00C0,A0C8,97A0,97C0,
                        0014,9DC8,9798,97B8,
                        0014,9AC8,9790,97B0,
                        0014,97C8,9788,FFFF,
                        FFFF
}


;;; $974A: Kraid instruction list - eye glowing ;;;
{
;                        ________________ Timer
;                       |     ___________ Tilemap
;                       |    |     ______ Vulnerable mouth hitbox
;                       |    |    |     _ Invulnerable mouth hitbox
;                       |    |    |    |
$A7:974A             dw 0005,97C8,9788,FFFF
$A7:9752             dw 000A,9AC8,9790,97B0,
                        0005,97C8,9788,FFFF,
                        FFFF
}


;;; $9764: Kraid instruction list - dying ;;;
{
;                        ________________ Timer
;                       |     ___________ Tilemap
;                       |    |     ______ Vulnerable mouth hitbox
;                       |    |    |     _ Invulnerable mouth hitbox
;                       |    |    |    |
$A7:9764             dw 0019,97C8,9788,FFFF,
$A7:976C             dw 0019,9AC8,9790,97B0,
                        0019,9DC8,9798,97B8,
                        AF9F,                ; Play Kraid dying sound effect
                        0040,A0C8,97A0,97C0,
                        FFFF
}
}


;;; $9788: Kraid mouth hitboxes ;;;
{
;                        __________________ Left
;                       |     _____________ Top
;                       |    |     ________ Right
;                       |    |    |     ___ Bottom
;                       |    |    |    |
$A7:9788             dw 0010,FF88,0028,FFA8
$A7:9790             dw 0010,FF88,0028,FF98
$A7:9798             dw 0010,FF80,0028,FF90
$A7:97A0             dw 0010,FF80,0028,FF88
$A7:97A8             dw 0000,0000,0000,0000 ; <-- Unused
$A7:97B0             dw 0006,FFA0,0020,FFB0
$A7:97B8             dw 0000,FF98,0020,FFB0
$A7:97C0             dw 0000,FF90,0020,FFB0
}


;;; $97C8: Kraid head tilemaps ;;;
{
; The last row of each of these tilemaps isn't actually drawn

$A7:97C8             dw 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C00, 3C01, 3C02, 3C03, 3C04, 3C05, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C06, 3C07, 3C08, 3C09, 3C0A, 3C0B, 3C0C, 3C0D, 3C0E, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C0F, 3C10, 3C11, 3C12, 3C13, 3C14, 3C15, 3C16, 3C17, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C18, 3C19, 3C1A, 3C1B, 3C1C, 3C1D, 3C1E, 3C1F, 3C20, 3C21, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C22, 3C23, 3C24, 3C25, 3C26, 3C27, 3C28, 3C29, 3C2A, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C2B, 3C2C, 3C2D, 3C2E, 3C2F, 3C30, 3C31, 3C32, 3C33, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C34, 3C35, 3C36, 3C37, 3C38, 3C39, 3C3A, 3C3B, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C3C, 3C3D, 3C3E, 3C3F, 3C40, 3C41, 3C42, 3C43, 3C44, 3C45, 3C46, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C47, 3C48, 3C49, 3C4A, 3C4B, 3C4C, 3C4D, 3C4E, 3C4F, 3C50, 3C51, 3C52, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C53, 3C54, 3C55, 3C56, 3C57, 3C58, 3C59, 3C5A, 3C5B, 3C5C, 3C5D, 3C5E, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C5F, 3C60, 3C61, 3D50, 3D50, 3C62, 3C63, 3C64, 3C65, 3C66, 3C67, 3C68, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 3C69, 3C6A, 3D50, 3D50, 3D50, 3C6B, 3C6C, 3C6D, 3C6E, 3C6F, 3C70, 3C71, 3C72, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338

$A7:9AC8             dw 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C73, 3C74, 3C75, 3C76, 3C77, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C78, 3C79, 3C7A, 3C7B, 3C7C, 3C7D, 3C7E, 3C7F, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C80, 3C81, 3C82, 3C83, 3C84, 3C85, 3C86, 3C87, 3C88, 3C89, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C8A, 3C8B, 3C8C, 3C8D, 3C8E, 3C8F, 3C90, 3C91, 3C92, 3C93, 3C94, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C95, 0338, 3C96, 3C97, 3C98, 3C99, 3C9A, 3C9B, 3C9C, 3C9D, 3C9E, 3C9F, 3CA0, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CA1, 3CA2, 3CA3, 3CA4, 3CA5, 3CA6, 3CA7, 3CA8, 3CA9, 3CAA, 3CAB, 3CAC, 3CAD, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CAE, 3CAF, 3CB0, 3CB1, 3CB2, 3CB3, 3CB4, 3C43, 3C44, 3C45, 3C46, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CB5, 3CB6, 3CB7, 3CB8, 3C4C, 3C4D, 3C4E, 3C4F, 3C50, 3C51, 3C52, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CB9, 3CBA, 3CBB, 3C56, 3C57, 3C58, 3C59, 3C5A, 3C5B, 3C5C, 3C5D, 3C5E, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C5F, 3C60, 3C61, 3D50, 3D50, 3C62, 3C63, 3C64, 3C65, 3C66, 3C67, 3C68, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 3C69, 3C6A, 3D50, 3D50, 3D50, 3C6B, 3C6C, 3C6D, 3C6E, 3C6F, 3C70, 3C71, 3C72, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338

$A7:9DC8             dw 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CBC, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CBD, 3CBE, 3CBF, 3CC0, 3CC1, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CC2, 3CC3, 3CC4, 3CC5, 3CC6, 3CC7, 3CC8, 3CC9, 3CCA, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CCB, 3CCC, 3CCD, 3CCE, 3CCF, 3CD0, 3CD1, 3CD2, 3CD3, 3CD4, 3D43, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CD5, 3CD6, 3CD7, 3CD8, 3CD9, 3CDA, 3CDB, 3CDC, 3CDD, 3CDE, 3CDF, 3CE0, 3CE1, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CE2, 3CE3, 3CE4, 3CE5, 3CE6, 3CE7, 3CE8, 3CE9, 3CEA, 3CEB, 3CEC, 3CED, 3CEE, 3CEF, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CF0, 3CF1, 3CF2, 3CF3, 3CF4, 3CF5, 3CF6, 3CF7, 3CF8, 3CF9, 3CFA, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CFB, 3CFC, 3CB7, 3CFD, 3CFE, 3C4D, 3C4E, 3C4F, 3C50, 3C51, 3CFF, 3D00, 3D44, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CB9, 3CBA, 3CBB, 3C56, 3C57, 3C58, 3C59, 3C5A, 3C5B, 3C5C, 3C5D, 3C5E, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C5F, 3C60, 3C61, 3D50, 3D50, 3C62, 3C63, 3C64, 3C65, 3C66, 3C67, 3C68, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 3C69, 3C6A, 3D50, 3D50, 3D50, 3C6B, 3C6C, 3C6D, 3C6E, 3C6F, 3C70, 3C71, 3C72, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338

$A7:A0C8             dw 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3D01, 3D02, 0338, 3D03, 3D04, 3D05, 3D06, 3D07, 3D08, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3D09, 3D0A, 3D0B, 3D0C, 3D0D, 3D0E, 3D0F, 3D10, 3D11, 3D12, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3D13, 3D14, 3D15, 3D16, 3D17, 3D18, 3D19, 3D1A, 3D1B, 3D1C, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3D1D, 3D1E, 3D1F, 3D20, 3D21, 3D22, 3D23, 3D24, 3D25, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3D26, 3D27, 3D28, 3D29, 3D2A, 3D2B, 3D2C, 3D2D, 3D2E, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 3D2F, 3D30, 3CB7, 3D31, 3D32, 3D33, 3D34, 3D35, 3D36, 3C51, 3D37, 3D38, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3CB9, 3CBA, 3CBB, 3C56, 3C57, 3C58, 3C59, 3D39, 3D3A, 3D3B, 3D3C, 3D3D, 3D3E, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 0338, 3C5F, 3C60, 3C61, 3D50, 3D50, 3C62, 3C63, 3C64, 3C65, 3C66, 3D3F, 3D40, 3D41, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338,
                        0338, 0338, 0338, 0338, 0338, 0338, 3C69, 3C6A, 3D50, 3D50, 3D50, 3C6B, 3C6C, 3C6D, 3C6E, 3C6F, 3C70, 3C71, 3D42, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338, 0338
}


;;; $A3C8..A715: (Extended) spritemaps ;;;
{
;;; $A3C8: Unused. Extended spritemaps - Kraid arm ;;;
{
$A7:A3C8             dw 0002, 0000,0000,A4DB,93F7, FFF7,FFF6,A47C,92D1
$A7:A3DA             dw 0002, FFF9,FFF8,A483,92EB, 0001,0000,A4DB,93F7
$A7:A3EC             dw 0002, FFF6,0001,A483,92EB, 0000,0000,A4BC,9371
$A7:A3FE             dw 0002, FFF6,0000,A48F,92F9, 0000,0000,A4BC,9371
$A7:A410             dw 0002, FFF6,0000,A496,9313, 0000,0000,A4BC,9371
$A7:A422             dw 0002, FFFA,0006,A496,9313, 0000,0000,A4C8,937F
$A7:A434             dw 0002, FFF8,0006,A4A2,9321, 0000,0000,A4C8,937F
$A7:A446             dw 0002, FFF8,0006,A4A9,933B, 0000,0000,A4C8,937F
$A7:A458             dw 0002, FFFF,000C,A4A9,933B, 0000,0000,A4CF,9399
$A7:A46A             dw 0002, 0000,000B,A4B5,9349, 0000,0000,A4CF,9399
}


;;; $A47C: Spritemaps - Kraid arm - rising/sinking ;;;
{
$A7:A47C             dx 0001, 81F2,F4,2126
$A7:A483             dx 0002, 01F9,FB,2129, 01F1,FB,2128
$A7:A48F             dx 0001, 81F2,FD,212A
$A7:A496             dx 0002, 01FA,07,2139, 01FA,FF,2138
$A7:A4A2             dx 0001, 81FD,FD,E126
$A7:A4A9             dx 0002, 01FF,FD,E129, 0007,FD,E128
$A7:A4B5             dx 0001, 81FD,F4,E12A

$A7:A4BC             dx 0002, 01FA,FC,E12E, 01F2,FC,A12E
$A7:A4C8             dx 0001, 81F4,FC,A12C
$A7:A4CF             dx 0002, 01FC,06,A13E, 01FC,FE,213E
$A7:A4DB             dx 0001, 81F4,F4,212C
}


;;; $A4E2: Unused. Extended spritemaps - Kraid arm ;;;
{
$A7:A4E2             dw 0001, 0000,0000,A53B,9439
$A7:A4EC             dw 0001, 0000,0000,A511,941F
$A7:A4F6             dw 0001, 0000,0000,A500,9411
}


;;; $A500: Spritemaps - Kraid arm - rising/sinking ;;;
{
$A7:A500             dx 0003, 81F4,F8,2104, 81E4,F8,2102, 81D4,F8,2100
$A7:A511             dx 0008, 01EC,00,211C, 01FC,F0,210F, 01F4,F0,210E, 01E4,E8,210D, 01DC,F8,210C, 81F4,F8,210A, 81E4,F0,2108, 81D4,E8,2106
$A7:A53B             dx 0008, 01FC,ED,213F, 01EC,FD,212F, 01EC,F5,211F, 01EC,DD,211E, 01E4,ED,211D, 81F4,F5,2124, 81EC,E5,2122, 81DC,DD,2120
}


;;; $A565: Extended spritemap - Kraid foot - initial ;;;
{
$A7:A565             dw 0002, 0008,0028,A5A1,9453, 0000,0000,A577,9453
}


;;; $A577: Spritemaps - Kraid foot ;;;
{
$A7:A577             dx 0008, 8020,1C,215A, 8020,14,214A, 8010,1C,2148, 01F8,0C,214C, 8010,0C,2146, 8000,0C,2144, 8008,FC,2142, 81F8,FC,2140
$A7:A5A1             dx 000C, 01D8,F4,21C3, 0018,F4,219A, 8000,F4,21C8, 81F0,F4,21C6, 81E0,F4,21C4, 81D0,FC,21A7, 8020,FC,21AB, 8020,F4,219B, 8010,FC,21DA, 8000,FC,21D8, 81F0,FC,21D6, 81E0,FC,21D4
}


;;; $A5DF: Spritemap - Kraid lint - initial ;;;
{
$A7:A5DF             dx 0005, 0000,08,11C2, 81F0,00,11B0, 8000,F8,11A2, 81F0,F8,11A0, 8000,08,11A9
}


;;; $A5FA: Unused. Spritemaps - Kraid lint ;;;
{
$A7:A5FA             dx 0004, 0000,08,11C2, 81F0,00,11B0, 8000,F8,11A2, 81F0,F8,11A0
$A7:A610             dx 0001, 81F8,F8,11A9
}


;;; $A617: Spritemaps - Kraid fingernail ;;;
{
$A7:A617             dx 0002, C3F4,F8,212A, C3FC,F8,212C
$A7:A623             dx 0004, 01F9,FB,2138, 01F9,03,2139, 0002,F9,612E, 01FA,F9,212E
$A7:A639             dx 0002, C3F9,FB,E126, C3F9,F4,612C
$A7:A645             dx 0004, 01FC,FF,E129, 0004,FF,E128, 01F9,FE,E13E, 01F9,F6,613E
$A7:A65B             dx 0002, C3FC,F8,E12A, C3F4,F8,212C
$A7:A667             dx 0004, 01FF,FD,E138, 01FF,F5,E139, 01FD,FF,E12E, 01F5,FF,A12E
$A7:A67D             dx 0002, C3F7,F4,2126, C3F7,FC,A12C
$A7:A689             dx 0004, 01FD,F9,2129, 01F5,F9,2128, 01FF,03,A13E, 01FF,FB,213E
}


;;; $A69F: Spritemaps - Kraid arm - dying / preparing to lunge ;;;
{
$A7:A69F             dx 000C, C3C1,D8,3326, C3CE,E3,332C, C3C2,D2,3326, C3CF,DD,332C, 01FF,EF,330F, 01F7,EF,330E, 01EF,FF,331C, 01DF,F7,330C, 01E7,E7,330D, C3F7,F7,330A, C3E7,EF,3308, C3D7,E7,3306
$A7:A6DD             dx 000B, 01BD,FE,3328, 01C5,FE,3329, 01D4,FE,732E, 01CC,FE,332E, 01B9,F9,3328, 01C1,F9,3329, 01D0,F9,732E, 01C8,F9,332E, C3F4,F8,3304, C3E4,F8,3302, C3D4,F8,3300
}
}
}


;;; $A716: Kraid's room background ;;;
{
; |--------|--------|--------|--------|
; |AABBBBBB|BBBBBB77|6666677B|BBBBB55B|
; |AB665566|66777B77|7666777B|66666BB5|
; |AB655995|56667777|777777B6|666566BB|
; |BB665499|65667776|777777B6|6656566B|
; |B6559449|5556677B|77777777|B655556B|
; |B6669995|555677B7|7B777B77|7B65656B|
; |B6556556|5566BB77|BBBB6776|77B6666B|
; |B6556665|666B7BBB|BB666677|67B6666B|
; |--------|--------|--------|--------|
; |B6665565|66B7BBB6|55566667|77B6666B|
; |A6665655|667BBB56|55565566|767666BB|
; |BBB66666|67BBB555|69955656|777BBB66|
; |6666BBBB|77BB5655|9C495556|677B6666|
; |5556677B|B7BB5669|94499665|67766666|
; |65655677|BB765559|99999555|67B66556|
; |56556566|7BB66565|59995556|67666655|
; |55995566|77B66655|75555666|67665595|
; |--------|--------|--------|--------|
; |69C49556|67766556|55565566|77665599|
; |59449556|677B6665|65565666|7BB65559|
; |55995666|67BB6666|65666667|BBB66655|
; |56556566|77BB7B66|6666667B|BBB66656|
; |5655666B|76666777|7666B777|7BBB6665|
; |665666B7|66666677|77777776|666666B6|
; |666666B6|66495567|77777666|555656B6|
; |6666BBB7|66995556|77776665|5C45556B|
; |--------|--------|--------|--------|
; |66BBBBB7|65556566|77B76655|9449556B|
; |BBBBBBB7|76555667|77B76656|5999656B|
; |BB66655B|77666667|67BBB665|5655566B|
; |B6655555|777BB677|BBBBB667|556566BB|
; |B6659555|BB7BB777|77BBB666|76566BBB|
; |B6665556|B66B7777|777BBB66|6666BBBB|
; |BB6666BB|BBBB7776|66777BBB|666BB55B|
; |5BBBBBBB|66B77766|6666BB5B|BBB5BBBB|
; |--------|--------|--------|--------|

$A7:A716             db 3F, FF, 4C, F3, 5F, E0, CB, F0, B9, C0, 8F, F0, B6, C9, B1, CE, 00, FF, 3F, C0, 39, C6, 3C, C3, 76, 89, 71, 8E, 7F, 80, 7F, 80,
                        FF, FF, 3F, FF, 8F, 7F, 4E, BF, E7, 1F, EF, 1F, CF, 3F, 1F, FF, 03, FC, FB, 04, FF, 00, FF, 00, FE, 01, FD, 02, F3, 0C, E8, 17,
                        07, FF, 8F, FF, FE, FF, FE, FF, FF, FF, FF, FF, F6, FF, C3, FF, FE, 01, FE, 01, FD, 02, FD, 02, FF, 00, BB, 44, 0F, F0, 3F, C0,
                        FF, F9, 07, FE, 13, EF, 29, D7, BD, C3, D5, EB, E1, FF, 61, FF, 06, F9, F9, 06, FC, 03, FE, 01, 7E, 81, BE, 41, DE, 21, DE, 21,
                        8D, F2, 0B, F4, E0, FF, 0F, FF, E7, 1F, 5B, A7, B4, 4B, FC, 03, 7F, 80, 7F, 80, 1F, E0, F0, 0F, FE, 01, FF, 00, FF, 00, CF, 30,
                        3E, FF, 3E, FD, 7F, F8, FB, F4, F9, F6, EF, F0, E5, FA, E3, FC, D1, 2E, E3, 1C, C7, 38, CF, 30, 4E, B1, 3E, C1, 9F, 60, DF, 20,
                        E1, 1F, EC, 13, 7A, 85, 9E, 01, 99, 06, FF, 00, FE, 01, F8, 87, FF, 00, FF, 00, 9F, 60, 6F, D0, 67, 98, 07, F8, 8F, 70, FF, 00,
                        E1, FF, A3, FF, FC, FF, 70, FF, 60, FF, 66, F9, 43, FC, 4F, F0, DE, 21, FC, 03, E3, 1C, EF, 10, FF, 00, DF, 20, FF, 00, FD, 02,
                        4E, 81, CE, 01, F8, 07, B4, 4B, B1, 4F, 23, DF, 02, FF, 0F, FF, B7, 68, B7, 48, CF, 30, FF, 00, FE, 01, FD, 02, FD, 02, F1, 0E,
                        66, F9, 71, FE, 70, FF, FC, FF, 87, FF, 03, FF, 1D, C3, 3E, C1, FF, 00, EF, 10, CF, 30, CB, 34, FF, 00, FF, 00, EF, 10, CF, 30,
                        EC, 13, 68, 97, 41, BF, 03, FF, 8F, FF, FE, FF, F8, FF, F1, FE, FF, 00, FF, 00, FF, 00, FE, 01, F7, 08, FF, 00, FF, 00, FF, 00,
                        CF, F0, EF, F0, E3, FC, E2, FD, F1, FE, 02, FF, EA, 17, 9D, 03, FC, 03, 9E, 61, 1F, E0, 1F, E0, 8F, 70, FD, 02, FD, 02, FE, 41,
                        3F, FF, FF, FF, C7, F9, 9F, E0, 9F, E0, 8E, F1, C3, FF, FF, 7F, C1, 3E, 01, FE, 3E, C1, 7F, 80, 77, 88, 7F, 80, 3C, C3, 80, 7F,
                        74, 8B, B9, C7, C1, FF, FB, FF, FF, FF, 9F, FF, FE, FF, 3C, FF, FF, 00, FF, 00, FF, 00, E7, 18, 27, D8, 6F, 90, 0F, F0, DF, 20,
                        F3, FC, F2, FD, 79, FE, F9, FF, F8, FF, FC, FF, 3F, FF, 0F, FD, DF, 20, DF, 20, C7, 38, 07, F8, C7, 38, E3, 1C, F8, 07, F2, 0D,
                        9D, 03, F5, 0B, B9, 47, D3, 2F, A7, DF, 0F, FF, 1F, F9, FF, EF, 6E, 91, 8E, 71, FE, 01, FC, 03, F8, 07, F0, 0F, E6, 19, 10, EF
}


;;; $A916: Kraid constants ;;;
{
; Initial Kraid lint function timers
$A7:A916             dw 0120, ; Top lint
                        00A0, ; Middle lint
                        0040  ; Bottom lint

; Kraid forwards speed
$A7:A91C             dw 0003

; Unused
$A7:A91E             dw 0005

; Kraid backwards speed
$A7:A920             dw 0003

; Unused. Kraid backwards fast speed
$A7:A922             dw 0004

; Unused
$A7:A924             dw 0110

; Kraid lint X speed
$A7:A926             dw 8000, ; Subspeed
                        0003  ; Speed
}
}


;;; $A92A: Unused. REP #$30 ;;;
{
$A7:A92A C2 30       REP #$30
}


;;; $A92C: Check if Kraid has died ;;;
{
;; Returns:
;;     A: 0 if Kraid is alive, 1 if Kraid is dead
$A7:A92C DA          PHX
$A7:A92D AE 9F 07    LDX $079F  [$7E:079F]
$A7:A930 BF 28 D8 7E LDA $7ED828,x[$7E:D829]
$A7:A934 89 01 00    BIT #$0001
$A7:A937 F0 05       BEQ $05    [$A93E]
$A7:A939 FA          PLX
$A7:A93A A9 01 00    LDA #$0001
$A7:A93D 60          RTS

$A7:A93E FA          PLX
$A7:A93F A9 00 00    LDA #$0000
$A7:A942 60          RTS
}


;;; $A943: Set enemy properties to dead ;;;
{
; Set enemy as intangible, flagged for deletion, invisible,
; not processed off-screen, not processing instructions and non-solid hitbox
$A7:A943 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:A946 BD 86 0F    LDA $0F86,x[$7E:0FC6]
$A7:A949 09 00 07    ORA #$0700
$A7:A94C 29 FF F7    AND #$F7FF
$A7:A94F 29 FF DF    AND #$DFFF
$A7:A952 29 FF 7F    AND #$7FFF
$A7:A955 9D 86 0F    STA $0F86,x[$7E:0FC6]
$A7:A958 60          RTS
}


;;; $A959: Initialisation AI - enemy $E2BF (Kraid) ;;;
{
; Note that BG1 tiles base address = ([$5D] & Fh) * 1000h, whereas this routine is using ([$5D] & Fh) * 100h,
; i.e. this routine only works because BG1 tiles base address = $0000
$A7:A959 E2 20       SEP #$20
$A7:A95B A9 A7       LDA #$A7               ;\
$A7:A95D 8D 06 06    STA $0606  [$7E:0606]  ;|
$A7:A960 A9 A7       LDA #$A7               ;|
$A7:A962 8D 03 06    STA $0603  [$7E:0603]  ;|
$A7:A965 C2 20       REP #$20               ;} Pause hook = pause hook - Kraid
$A7:A967 A9 4E C2    LDA #$C24E             ;} Unpause hook = unpause hook - Kraid is alive
$A7:A96A 8D 04 06    STA $0604  [$7E:0604]  ;|
$A7:A96D A9 25 C3    LDA #$C325             ;|
$A7:A970 8D 01 06    STA $0601  [$7E:0601]  ;/
$A7:A973 20 2C A9    JSR $A92C  [$A7:A92C]  ;\
$A7:A976 D0 03       BNE $03    [$A97B]     ;} If Kraid is not dead: go to BRANCH_ALIVE
$A7:A978 4C DC A9    JMP $A9DC  [$A7:A9DC]  ;/

$A7:A97B A2 C0 00    LDX #$00C0             ;\
$A7:A97E A0 00 00    LDY #$0000             ;|
                                            ;|
$A7:A981 B9 C7 86    LDA $86C7,y[$A7:86C7]  ;|
$A7:A984 9F 00 C2 7E STA $7EC200,x[$7E:C2C0];|
$A7:A988 E8          INX                    ;} BG target palette 6 = [$86C7..E6] (Kraid room background palette)
$A7:A989 E8          INX                    ;|
$A7:A98A C8          INY                    ;|
$A7:A98B C8          INY                    ;|
$A7:A98C C0 20 00    CPY #$0020             ;|
$A7:A98F 30 F0       BMI $F0    [$A981]     ;/
$A7:A991 A2 FE 07    LDX #$07FE             ;\
$A7:A994 A9 38 03    LDA #$0338             ;|
                                            ;|
$A7:A997 9F 00 20 7E STA $7E2000,x[$7E:27FE];} Clear Kraid BG2 tilemap top half
$A7:A99B CA          DEX                    ;|
$A7:A99C CA          DEX                    ;|
$A7:A99D 10 F8       BPL $F8    [$A997]     ;/
$A7:A99F A9 00 00    LDA #$0000             ;\
$A7:A9A2 8F 04 78 7E STA $7E7804[$7E:7804]  ;} $7E:7804 = 0 (never read)
$A7:A9A6 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A7:A9A9 A9 00 02    LDA #$0200             ;|
$A7:A9AC 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:A9AE A9 16 A7    LDA #$A716             ;|
$A7:A9B1 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:A9B3 E2 20       SEP #$20               ;|
$A7:A9B5 A9 A7       LDA #$A7               ;|
$A7:A9B7 95 D4       STA $D4,x  [$7E:00D4]  ;|
$A7:A9B9 C2 20       REP #$20               ;|
$A7:A9BB A5 5D       LDA $5D    [$7E:005D]  ;} Queue transfer of $A7:A716..A915 to VRAM $3F00..FF (Kraid's room background)
$A7:A9BD 29 0F 00    AND #$000F             ;|
$A7:A9C0 EB          XBA                    ;|
$A7:A9C1 18          CLC                    ;|
$A7:A9C2 69 00 3F    ADC #$3F00             ;|
$A7:A9C5 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:A9C7 8A          TXA                    ;|
$A7:A9C8 18          CLC                    ;|
$A7:A9C9 69 07 00    ADC #$0007             ;|
$A7:A9CC 8D 30 03    STA $0330  [$7E:0330]  ;/
$A7:A9CF 20 68 C1    JSR $C168  [$A7:C168]  ; Clear ceiling
$A7:A9D2 20 71 C1    JSR $C171  [$A7:C171]  ; Clear spikes
$A7:A9D5 A9 15 C7    LDA #$C715             ;\
$A7:A9D8 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = fade in regular background
$A7:A9DB 6B          RTL                    ; Return

; BRANCH_ALIVE
$A7:A9DC E2 20       SEP #$20
$A7:A9DE A9 43       LDA #$43               ;\
$A7:A9E0 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4000, size = 64x64
$A7:A9E2 C2 20       REP #$20
$A7:A9E4 A9 02 00    LDA #$0002             ;\
$A7:A9E7 8D 41 09    STA $0941  [$7E:0941]  ;} Camera distance index = 2 (keeps Samus to the left side of the screen)
$A7:A9EA A9 00 00    LDA #$0000             ;\
$A7:A9ED 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;|
$A7:A9F1 A9 01 00    LDA #$0001             ;} Scrolls 0,1,3 = red, 2 = blue
$A7:A9F4 8F 22 CD 7E STA $7ECD22[$7E:CD22]  ;/
$A7:A9F8 A9 44 01    LDA #$0144             ;\
$A7:A9FB 8F 08 78 7E STA $7E7808[$7E:7808]  ;} $7E:7808 = 144h (minimum Y position to which Kraid will eject Samus)
$A7:A9FF A2 00 00    LDX #$0000             ;\
$A7:AA02 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;|
$A7:AA05 4A          LSR A                  ;|
$A7:AA06 4A          LSR A                  ;|
$A7:AA07 4A          LSR A                  ;|
$A7:AA08 85 12       STA $12    [$7E:0012]  ;|
                                            ;} $7E:780C + i*2 = [Kraid health] / 8 * (i + 1)
$A7:AA0A 9F 0C 78 7E STA $7E780C,x[$7E:780C];} i = 0..7
$A7:AA0E 18          CLC                    ;|
$A7:AA0F 65 12       ADC $12    [$7E:0012]  ;|
$A7:AA11 E8          INX                    ;|
$A7:AA12 E8          INX                    ;|
$A7:AA13 E0 10 00    CPX #$0010             ;|
$A7:AA16 30 F2       BMI $F2    [$AA0A]     ;/
$A7:AA18 A9 FF DF    LDA #$DFFF             ;\
$A7:AA1B 85 12       STA $12    [$7E:0012]  ;|
$A7:AA1D AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Set up Kraid graphics with the tile priority cleared
$A7:AA20 20 C6 AA    JSR $AAC6  [$A7:AAC6]  ;/
$A7:AA23 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:AA26 4A          LSR A                  ;|
$A7:AA27 4A          LSR A                  ;|
$A7:AA28 8F 20 78 7E STA $7E7820[$7E:7820]  ;|
$A7:AA2C 18          CLC                    ;|
$A7:AA2D 6F 20 78 7E ADC $7E7820[$7E:7820]  ;|
$A7:AA31 8F 22 78 7E STA $7E7822[$7E:7822]  ;} $7E:7820 + i*2 = [Kraid health] / 4 * (i + 1)
$A7:AA35 18          CLC                    ;} i = 0..3
$A7:AA36 6F 20 78 7E ADC $7E7820[$7E:7820]  ;|
$A7:AA3A 8F 24 78 7E STA $7E7824[$7E:7824]  ;|
$A7:AA3E 18          CLC                    ;|
$A7:AA3F 6F 20 78 7E ADC $7E7820[$7E:7820]  ;|
$A7:AA43 8F 26 78 7E STA $7E7826[$7E:7826]  ;/
$A7:AA47 A9 00 00    LDA #$0000             ;\
$A7:AA4A 8F 3E 78 7E STA $7E783E[$7E:783E]  ;} $7E:783E = 0 (never read)
$A7:AA4E A9 B0 00    LDA #$00B0             ;\
$A7:AA51 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Kraid X position = B0h
$A7:AA54 A9 50 02    LDA #$0250             ;\
$A7:AA57 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Kraid Y position = 250h
$A7:AA5A AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:AA5D 09 00 04    ORA #$0400             ;} Set Kraid as intangible
$A7:AA60 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:AA63 A9 65 C8    LDA #$C865             ;\
$A7:AA66 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = restrict Samus X position to first screen
$A7:AA69 A9 2C 01    LDA #$012C             ;\
$A7:AA6C 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Kraid function timer = 300
$A7:AA6F A9 6B C8    LDA #$C86B             ;\
$A7:AA72 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Kraid next function = raise Kraid through floor
$A7:AA76 A9 40 00    LDA #$0040             ;\
$A7:AA79 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Kraid instruction timer = 40h
$A7:AA7C 22 E2 A7 90 JSL $90A7E2[$90:A7E2]  ; Disable mini-map and mark boss room map tiles as explored
$A7:AA80 A2 3E 00    LDX #$003E             ;\
$A7:AA83 A9 38 03    LDA #$0338             ;|
                                            ;|
$A7:AA86 9F C0 2F 7E STA $7E2FC0,x[$7E:2FFE];} $7E:2FC0..FF = 338h (used to gradually delete Kraid's GFX)
$A7:AA8A CA          DEX                    ;|
$A7:AA8B CA          DEX                    ;|
$A7:AA8C 10 F8       BPL $F8    [$AA86]     ;/
$A7:AA8E A9 05 00    LDA #$0005             ;\
$A7:AA91 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 2 pixel displacement, diagonal
$A7:AA94 A2 00 00    LDX #$0000             ;\
                                            ;|
$A7:AA97 BD A6 AA    LDA $AAA6,x[$A7:AAA6]  ;|
$A7:AA9A 9F 60 C3 7E STA $7EC360,x[$7E:C360];|
$A7:AA9E E8          INX                    ;} Sprite target palette 3 = [$AAA6..C5] (Kraid rocks)
$A7:AA9F E8          INX                    ;|
$A7:AAA0 E0 20 00    CPX #$0020             ;|
$A7:AAA3 30 F2       BMI $F2    [$AA97]     ;/
$A7:AAA5 6B          RTL

; Sprite palette 3 - Kraid rocks
$A7:AAA6             dw 0000, 0000, 0000, 0000, 0000, 0DF6, 0D92, 0CEC, 0CA9, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $AAC6: Set up Kraid graphics with the tile priority cleared ;;;
{
; $7E:2000..27FF = BG2 tilemap - Kraid top half
; $7E:2800..2DFF = BG2 tilemap - Kraid bottom half
$A7:AAC6 E2 20       SEP #$20
$A7:AAC8 A9 38       LDA #$38               ;\
$A7:AACA 8F 47 00 00 STA $000047[$7E:0047]  ;|
$A7:AACE A9 FA       LDA #$FA               ;|
$A7:AAD0 8F 48 00 00 STA $000048[$7E:0048]  ;|
$A7:AAD4 A9 B9       LDA #$B9               ;|
$A7:AAD6 8F 49 00 00 STA $000049[$7E:0049]  ;} Decompress $B9:FA38 to $7E:4000 (Kraid top half)
$A7:AADA A9 00       LDA #$00               ;|
$A7:AADC 8F 4C 00 00 STA $00004C[$7E:004C]  ;|
$A7:AAE0 A9 40       LDA #$40               ;|
$A7:AAE2 8F 4D 00 00 STA $00004D[$7E:004D]  ;|
$A7:AAE6 22 19 B1 80 JSL $80B119[$80:B119]  ;/
$A7:AAEA A9 3E       LDA #$3E               ;\
$A7:AAEC 8F 47 00 00 STA $000047[$7E:0047]  ;|
$A7:AAF0 A9 FE       LDA #$FE               ;|
$A7:AAF2 8F 48 00 00 STA $000048[$7E:0048]  ;|
$A7:AAF6 A9 B9       LDA #$B9               ;|
$A7:AAF8 8F 49 00 00 STA $000049[$7E:0049]  ;} Decompress $B9:FE3E to $7E:2000 (Kraid bottom half)
$A7:AAFC A9 00       LDA #$00               ;|
$A7:AAFE 8F 4C 00 00 STA $00004C[$7E:004C]  ;|
$A7:AB02 A9 20       LDA #$20               ;|
$A7:AB04 8F 4D 00 00 STA $00004D[$7E:004D]  ;|
$A7:AB08 22 19 B1 80 JSL $80B119[$80:B119]  ;/
$A7:AB0C C2 20       REP #$20
$A7:AB0E A9 00 00    LDA #$0000             ;\
$A7:AB11 8F 2A 78 7E STA $7E782A[$7E:782A]  ;} Kraid hurt frame = 0
$A7:AB15 8F 2C 78 7E STA $7E782C[$7E:782C]  ; Kraid hurt frame timer = 0
$A7:AB19 A2 00 00    LDX #$0000             ;\
                                            ;|
$A7:AB1C BF 00 20 7E LDA $7E2000,x[$7E:2000];|
$A7:AB20 29 FF DF    AND #$DFFF             ;|
$A7:AB23 9F 00 28 7E STA $7E2800,x[$7E:2800];} $7E:2800..2DFF = [$7E:2000..25FF] & DFFFh (copy tilemap with tile priorities cleared)
$A7:AB27 E8          INX                    ;|
$A7:AB28 E8          INX                    ;|
$A7:AB29 E0 00 06    CPX #$0600             ;|
$A7:AB2C 30 EE       BMI $EE    [$AB1C]     ;/
$A7:AB2E A2 00 00    LDX #$0000             ;\
                                            ;|
$A7:AB31 BF 00 40 7E LDA $7E4000,x[$7E:4000];|
$A7:AB35 25 12       AND $12    [$7E:0012]  ;|
$A7:AB37 9F 00 20 7E STA $7E2000,x[$7E:2000];} $7E:2000..27FF = [$7E:4000..47FF] & [$12] (copy tilemap with tile priorities cleared, $12 is always DFFFh)
$A7:AB3B E8          INX                    ;|
$A7:AB3C E8          INX                    ;|
$A7:AB3D E0 00 08    CPX #$0800             ;|
$A7:AB40 30 EF       BMI $EF    [$AB31]     ;/
$A7:AB42 60          RTS
}


;;; $AB43: Initialisation AI - enemy $E2FF (Kraid's arm) ;;;
{
$A7:AB43 20 2C A9    JSR $A92C  [$A7:A92C]  ;\
$A7:AB46 D0 1C       BNE $1C    [$AB64]     ;} If Kraid not dead:
$A7:AB48 AD 96 0F    LDA $0F96  [$7E:0F96]  ;\
$A7:AB4B 8D D6 0F    STA $0FD6  [$7E:0FD6]  ;} Kraid arm palette = [Kraid palette]
$A7:AB4E A9 2D BA    LDA #$BA2D             ;\
$A7:AB51 8D E8 0F    STA $0FE8  [$7E:0FE8]  ;} Kraid arm function = RTL
$A7:AB54 A9 A4 8A    LDA #$8AA4             ;\
$A7:AB57 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Kraid arm instruction list pointer = $8AA4 (rising/sinking)
$A7:AB5A A9 01 00    LDA #$0001             ;\
$A7:AB5D 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Kraid arm instruction timer = 1
$A7:AB60 9C EA 0F    STZ $0FEA  [$7E:0FEA]  ; Kraid arm $0FAA = 0
$A7:AB63 6B          RTL                    ; Return

$A7:AB64 20 43 A9    JSR $A943  [$A7:A943]  ; Set enemy properties to dead
$A7:AB67 6B          RTL
}


;;; $AB68: Initialisation AI - enemy $E33F (Kraid top lint) ;;;
{
$A7:AB68 20 2C A9    JSR $A92C  [$A7:A92C]  ;\
$A7:AB6B D0 2B       BNE $2B    [$AB98]     ;} If Kraid not dead:
$A7:AB6D AD 96 0F    LDA $0F96  [$7E:0F96]  ;\
$A7:AB70 8D 16 10    STA $1016  [$7E:1016]  ;} Kraid top lint palette = [Kraid palette]
$A7:AB73 A9 FF 7F    LDA #$7FFF             ;\
$A7:AB76 8D 14 10    STA $1014  [$7E:1014]  ;} Kraid top lint instruction timer = 7FFFh
$A7:AB79 A9 FE 8A    LDA #$8AFE             ;\
$A7:AB7C 8D 12 10    STA $1012  [$7E:1012]  ;} Kraid top lint instruction list pointer = $8AFE (initial)
$A7:AB7F A9 DF A5    LDA #$A5DF             ;\
$A7:AB82 8D 0E 10    STA $100E  [$7E:100E]  ;} Kraid top lint spritemap pointer = $A5DF
$A7:AB85 A9 31 B8    LDA #$B831             ;\
$A7:AB88 8D 28 10    STA $1028  [$7E:1028]  ;} Kraid top lint function = RTL
$A7:AB8B A9 FF 7F    LDA #$7FFF             ;\
$A7:AB8E 8D 32 10    STA $1032  [$7E:1032]  ;} Kraid top lint function timer = 7FFFh
$A7:AB91 A9 00 00    LDA #$0000             ;\
$A7:AB94 8D 2C 10    STA $102C  [$7E:102C]  ;} Kraid lint X additional spawning velocity = 0
$A7:AB97 6B          RTL                    ; Return

$A7:AB98 20 43 A9    JSR $A943  [$A7:A943]  ; Set enemy properties to dead
$A7:AB9B 6B          RTL
}


;;; $AB9C: Initialisation AI - enemy $E37F (Kraid middle lint) ;;;
{
$A7:AB9C 20 2C A9    JSR $A92C  [$A7:A92C]  ;\
$A7:AB9F D0 25       BNE $25    [$ABC6]     ;} If Kraid not dead:
$A7:ABA1 AD 96 0F    LDA $0F96  [$7E:0F96]  ;\
$A7:ABA4 8D 56 10    STA $1056  [$7E:1056]  ;} Kraid middle lint palette = [Kraid palette]
$A7:ABA7 A9 FF 7F    LDA #$7FFF             ;\
$A7:ABAA 8D 54 10    STA $1054  [$7E:1054]  ;} Kraid middle lint instruction timer = 7FFFh
$A7:ABAD A9 FE 8A    LDA #$8AFE             ;\
$A7:ABB0 8D 52 10    STA $1052  [$7E:1052]  ;} Kraid middle lint instruction list pointer = $8AFE (initial)
$A7:ABB3 A9 DF A5    LDA #$A5DF             ;\
$A7:ABB6 8D 4E 10    STA $104E  [$7E:104E]  ;} Kraid middle lint spritemap pointer = $A5DF
$A7:ABB9 A9 31 B8    LDA #$B831             ;\
$A7:ABBC 8D 68 10    STA $1068  [$7E:1068]  ;} Kraid middle lint function = RTL
$A7:ABBF A9 F0 FF    LDA #$FFF0             ;\
$A7:ABC2 8D 6C 10    STA $106C  [$7E:106C]  ;} Kraid lint X additional spawning velocity = -10h
$A7:ABC5 6B          RTL                    ; Return

$A7:ABC6 20 43 A9    JSR $A943  [$A7:A943]  ; Set enemy properties to dead
$A7:ABC9 6B          RTL
}


;;; $ABCA: Initialisation AI - enemy $E3BF (Kraid bottom lint) ;;;
{
$A7:ABCA 20 2C A9    JSR $A92C  [$A7:A92C]  ;\
$A7:ABCD D0 25       BNE $25    [$ABF4]     ;} If Kraid not dead:
$A7:ABCF AD 96 0F    LDA $0F96  [$7E:0F96]  ;\
$A7:ABD2 8D 96 10    STA $1096  [$7E:1096]  ;} Kraid bottom lint palette = [Kraid palette]
$A7:ABD5 A9 FF 7F    LDA #$7FFF             ;\
$A7:ABD8 8D 94 10    STA $1094  [$7E:1094]  ;} Kraid bottom lint instruction timer = 7FFFh
$A7:ABDB A9 FE 8A    LDA #$8AFE             ;\
$A7:ABDE 8D 92 10    STA $1092  [$7E:1092]  ;} Kraid bottom lint instruction list pointer = $8AFE (initial)
$A7:ABE1 A9 DF A5    LDA #$A5DF             ;\
$A7:ABE4 8D 8E 10    STA $108E  [$7E:108E]  ;} Kraid bottom lint spritemap pointer = $A5DF
$A7:ABE7 A9 31 B8    LDA #$B831             ;\
$A7:ABEA 8D A8 10    STA $10A8  [$7E:10A8]  ;} Kraid bottom lint function = RTL
$A7:ABED A9 F0 FF    LDA #$FFF0             ;\
$A7:ABF0 8D AC 10    STA $10AC  [$7E:10AC]  ;} Kraid lint X additional spawning velocity = -10h
$A7:ABF3 6B          RTL                    ; Return

$A7:ABF4 20 43 A9    JSR $A943  [$A7:A943]  ; Set enemy properties to dead
$A7:ABF7 6B          RTL
}


;;; $ABF8: Initialisation AI - enemy $E3FF (Kraid's foot) ;;;
{
$A7:ABF8 20 2C A9    JSR $A92C  [$A7:A92C]  ;\
$A7:ABFB D0 20       BNE $20    [$AC1D]     ;} If Kraid not dead:
$A7:ABFD AD 96 0F    LDA $0F96  [$7E:0F96]  ;\
$A7:AC00 8D D6 10    STA $10D6  [$7E:10D6]  ;} Kraid foot palette = [Kraid palette]
$A7:AC03 A9 E7 86    LDA #$86E7             ;\
$A7:AC06 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86E7 (initial)
$A7:AC09 A9 01 00    LDA #$0001             ;\
$A7:AC0C 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:AC0F A9 2D BA    LDA #$BA2D             ;\
$A7:AC12 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = RTL
$A7:AC15 A9 00 00    LDA #$0000             ;\
$A7:AC18 8F 40 79 7E STA $7E7940[$7E:7940]  ;} Kraid foot next function = 0
$A7:AC1C 6B          RTL                    ; Return

$A7:AC1D 20 43 A9    JSR $A943  [$A7:A943]  ; Set enemy properties to dead
$A7:AC20 6B          RTL
}


;;; $AC21: Main AI - enemy $E2BF (Kraid) ;;;
{
$A7:AC21 20 AA AF    JSR $AFAA  [$A7:AFAA]  ; Kraid's mouth / projectile collision handling
$A7:AC24 20 37 B3    JSR $B337  [$A7:B337]  ; Kraid palette handling
$A7:AC27 20 81 B1    JSR $B181  [$A7:B181]  ; Kraid body / projectile collision handling
$A7:AC2A 20 F3 B0    JSR $B0F3  [$A7:B0F3]  ; Kraid body / Samus collision handling
$A7:AC2D AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A7:AC30 A5 B1       LDA $B1    [$7E:00B1]  ;\
$A7:AC32 38          SEC                    ;|
$A7:AC33 ED 1D 09    SBC $091D  [$7E:091D]  ;|
$A7:AC36 ED 7A 0F    SBC $0F7A  [$7E:0F7A]  ;} BG2 X scroll = [BG1 X scroll] - [BG1 X scroll offset] - (Kraid left boundary)
$A7:AC39 6D 82 0F    ADC $0F82  [$7E:0F82]  ;|
$A7:AC3C 85 B5       STA $B5    [$7E:00B5]  ;/
$A7:AC3E AD 15 09    LDA $0915  [$7E:0915]  ;\
$A7:AC41 38          SEC                    ;|
$A7:AC42 ED 7E 0F    SBC $0F7E  [$7E:0F7E]  ;} BG2 Y scroll = [BG1 Y position] - [Kraid Y position] + 98h
$A7:AC45 69 98 00    ADC #$0098             ;|
$A7:AC48 85 B7       STA $B7    [$7E:00B7]  ;/
$A7:AC4A 6C A8 0F    JMP ($0FA8)[$A7:C865]  ; Execute [Kraid function]
}


;;; $AC4D: Kraid function - Kraid gets big - break ceiling into platforms ;;;
{
$A7:AC4D AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A7:AC50 29 07 00    AND #$0007             ;} If [frame counter] % 8 = 0:
$A7:AC53 D0 03       BNE $03    [$AC58]     ;/
$A7:AC55 20 95 C9    JSR $C995  [$A7:C995]  ; Spawn random earthquake projectile

$A7:AC58 A0 01 00    LDY #$0001             ; Y = 1
$A7:AC5B AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A7:AC5E 89 02 00    BIT #$0002             ;} If [Kraid Y position] % 4 < 2:
$A7:AC61 F0 03       BEQ $03    [$AC66]     ;/
$A7:AC63 A0 FF FF    LDY #$FFFF             ; Y = -1

$A7:AC66 84 12       STY $12    [$7E:0012]  ;\
$A7:AC68 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A7:AC6B 18          CLC                    ;} Kraid X position += [Y]
$A7:AC6C 65 12       ADC $12    [$7E:0012]  ;|
$A7:AC6E 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A7:AC71 CE 7E 0F    DEC $0F7E  [$7E:0F7E]  ; Kraid Y position -= 1
$A7:AC74 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A7:AC77 29 03 00    AND #$0003             ;} If [Kraid Y position] % 4 != 0: go to BRANCH_RETURN
$A7:AC7A D0 28       BNE $28    [$ACA4]     ;/
$A7:AC7C AE B2 0F    LDX $0FB2  [$7E:0FB2]  ;\
$A7:AC7F E0 12 00    CPX #$0012             ;} If [Kraid ceiling break index] >= 12h: go to BRANCH_RETURN
$A7:AC82 10 20       BPL $20    [$ACA4]     ;/
$A7:AC84 BD B3 AC    LDA $ACB3,x[$A7:ACB3]  ;\
$A7:AC87 A0 53 9C    LDY #$9C53             ;|
$A7:AC8A AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn falling rocks enemy projectile at X position [$ACB3 + [Kraid ceiling break index]]
$A7:AC8D 22 27 80 86 JSL $868027[$86:8027]  ;/
$A7:AC91 AE B2 0F    LDX $0FB2  [$7E:0FB2]  ;\
$A7:AC94 BD C5 AC    LDA $ACC5,x[$A7:ACC5]  ;|
$A7:AC97 85 12       STA $12    [$7E:0012]  ;} Go to [$ACC5 + [Kraid ceiling break index]] (spawn PLM)
$A7:AC99 6C 12 00    JMP ($0012)            ;/

; Manual return point for PLM spawning functions
$A7:AC9C AE B2 0F    LDX $0FB2  [$7E:0FB2]  ;\
$A7:AC9F E8          INX                    ;|
$A7:ACA0 E8          INX                    ;} Kraid ceiling break index += 2
$A7:ACA1 8E B2 0F    STX $0FB2  [$7E:0FB2]  ;/

; BRANCH_RETURN
$A7:ACA4 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A7:ACA7 C9 28 01    CMP #$0128             ;} If [Kraid Y position] < 128h
$A7:ACAA 10 06       BPL $06    [$ACB2]     ;/
$A7:ACAC A9 3A AD    LDA #$AD3A             ;\
$A7:ACAF 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = set BG2 tilemap priority bits

$A7:ACB2 6B          RTL

$A7:ACB3             dw 0068, 00D8, 0028, 00A8, 0058, 00C8, 0038, 00B8, 0048 ; Falling rocks X positions
$A7:ACC5             dw AD03, AD2F, ACD7, AD0E, ACF8, AD24, ACE2, AD19, ACED ; Ceiling break PLM spawning function pointers

$A7:ACD7 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:ACDB             dx 02, 12, B7A3
$A7:ACDF 4C 9C AC    JMP $AC9C  [$A7:AC9C]

$A7:ACE2 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:ACE6             dx 03, 12, B7AB
$A7:ACEA 4C 9C AC    JMP $AC9C  [$A7:AC9C]

$A7:ACED 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:ACF1             dx 04, 12, B7B3
$A7:ACF5 4C 9C AC    JMP $AC9C  [$A7:AC9C]

$A7:ACF8 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:ACFC             dx 05, 12, B7AB
$A7:AD00 4C 9C AC    JMP $AC9C  [$A7:AC9C]

$A7:AD03 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:AD07             dx 06, 12, B7B3
$A7:AD0B 4C 9C AC    JMP $AC9C  [$A7:AC9C]

$A7:AD0E 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:AD12             dx 0A, 12, B7B3
$A7:AD16 4C 9C AC    JMP $AC9C  [$A7:AC9C]

$A7:AD19 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:AD1D             dx 0B, 12, B7AB
$A7:AD21 4C 9C AC    JMP $AC9C  [$A7:AC9C]

$A7:AD24 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:AD28             dx 0C, 12, B7B3
$A7:AD2C 4C 9C AC    JMP $AC9C  [$A7:AC9C]

$A7:AD2F 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:AD33             dx 0D, 12, B7AB
$A7:AD37 4C 9C AC    JMP $AC9C  [$A7:AC9C]
}


;;; $AD3A: Kraid function - Kraid gets big - set BG2 tilemap priority bits ;;;
{
$A7:AD3A A2 00 00    LDX #$0000             ;\
                                            ;|
$A7:AD3D BF 00 20 7E LDA $7E2000,x[$7E:2000];|
$A7:AD41 09 00 20    ORA #$2000             ;|
$A7:AD44 9F 00 20 7E STA $7E2000,x[$7E:2000];} Kraid tilemap |= 2000h (priority bits)
$A7:AD48 E8          INX                    ;|
$A7:AD49 E8          INX                    ;|
$A7:AD4A E0 00 10    CPX #$1000             ;|
$A7:AD4D 30 EE       BMI $EE    [$AD3D]     ;/
$A7:AD4F AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A7:AD52 29 FF FB    AND #$FBFF             ;} Set Kraid arm as tangible
$A7:AD55 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A7:AD58 A9 61 AD    LDA #$AD61             ;\
$A7:AD5B 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = finish updating BG2 tilemap
$A7:AD5E 4C 74 C8    JMP $C874  [$A7:C874]  ; Go to update BG2 tilemap top half
}


;;; $AD61: Kraid function - Kraid gets big - finish updating BG2 tilemap ;;;
{
$A7:AD61 A9 8E AD    LDA #$AD8E             ;\
$A7:AD64 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = draw room background
$A7:AD67 A9 01 00    LDA #$0001             ;\
$A7:AD6A 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:AD6D A9 ED 86    LDA #$86ED             ;\
$A7:AD70 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86ED (Kraid is big - neutral)
$A7:AD73 A9 04 8B    LDA #$8B04             ;\
$A7:AD76 8D 12 10    STA $1012  [$7E:1012]  ;|
$A7:AD79 8D 52 10    STA $1052  [$7E:1052]  ;} Kraid lints instruction list pointer = $8B04 (Kraid is big)
$A7:AD7C 8D 92 10    STA $1092  [$7E:1092]  ;/
$A7:AD7F A9 6C 8C    LDA #$8C6C             ;\
$A7:AD82 8D 0E 10    STA $100E  [$7E:100E]  ;|
$A7:AD85 8D 4E 10    STA $104E  [$7E:104E]  ;} Kraid lints spritemap pointer = $8C6C
$A7:AD88 8D 8E 10    STA $108E  [$7E:108E]  ;/
$A7:AD8B 4C B6 C8    JMP $C8B6  [$A7:C8B6]  ; Go to update BG2 tilemap bottom half
}


;;; $AD8E: Kraid function - Kraid gets big - draw room background ;;;
{
; Note that BG1 tiles base address = ([$5D] & Fh) * 1000h, whereas this routine is using ([$5D] & Fh) * 100h,
; i.e. this routine only works because BG1 tiles base address = $0000
$A7:AD8E A9 23 AE    LDA #$AE23             ;\
$A7:AD91 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = fade in room background
$A7:AD94 9C B0 0F    STZ $0FB0  [$7E:0FB0]  ; $0FB0 = 0
$A7:AD97 9C B2 0F    STZ $0FB2  [$7E:0FB2]  ; Kraid function timer = 0
}


;;; $AD9A: Draw Kraid's room background ;;;
{
$A7:AD9A A2 C0 00    LDX #$00C0             ;\
$A7:AD9D A0 00 00    LDY #$0000             ;|
                                            ;|
$A7:ADA0 B9 C7 86    LDA $86C7,y[$A7:86C7]  ;|
$A7:ADA3 9F 00 C2 7E STA $7EC200,x[$7E:C2C0];|
$A7:ADA7 E8          INX                    ;} BG target palette 6 = [$86C7..E6] (Kraid room background palette)
$A7:ADA8 E8          INX                    ;|
$A7:ADA9 C8          INY                    ;|
$A7:ADAA C8          INY                    ;|
$A7:ADAB C0 20 00    CPY #$0020             ;|
$A7:ADAE 30 F0       BMI $F0    [$ADA0]     ;/
$A7:ADB0 A9 00 00    LDA #$0000             ;\
$A7:ADB3 8F 00 C4 7E STA $7EC400[$7E:C400]  ;} Colour palette change fraction numerator = 0
$A7:ADB7 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A7:ADBA A9 00 02    LDA #$0200             ;|
$A7:ADBD 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:ADBF A9 16 A7    LDA #$A716             ;|
$A7:ADC2 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:ADC4 E2 20       SEP #$20               ;|
$A7:ADC6 A9 A7       LDA #$A7               ;|
$A7:ADC8 95 D4       STA $D4,x  [$7E:00D4]  ;|
$A7:ADCA C2 20       REP #$20               ;|
$A7:ADCC A5 5D       LDA $5D    [$7E:005D]  ;} Queue transfer of $A7:A716..A915 (room background) to VRAM $3F00..FF
$A7:ADCE 29 0F 00    AND #$000F             ;|
$A7:ADD1 EB          XBA                    ;|
$A7:ADD2 18          CLC                    ;|
$A7:ADD3 69 00 3F    ADC #$3F00             ;|
$A7:ADD6 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:ADD8 8A          TXA                    ;|
$A7:ADD9 18          CLC                    ;|
$A7:ADDA 69 07 00    ADC #$0007             ;|
$A7:ADDD 8D 30 03    STA $0330  [$7E:0330]  ;/
$A7:ADE0 6B          RTL
}


;;; $ADE1: Set up Kraid gets big - thinking ;;;
{
$A7:ADE1 A9 C4 AE    LDA #$AEC4             ;\
$A7:ADE4 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = Kraid gets big - thinking
$A7:ADE7 80 06       BRA $06    [$ADEF]     ; Go to set lint Y positions and random thinking time
}


;;; $ADE9: Set up Kraid main loop - thinking ;;;
{
$A7:ADE9 A9 A4 AE    LDA #$AEA4             ;\
$A7:ADEC 8D A8 0F    STA $0FA8  [$8C:0FA8]  ;} Kraid function = Kraid main loop
}


;;; $ADEF: Set lint Y positions and random thinking timer ;;;
{
$A7:ADEF AD 7E 0F    LDA $0F7E  [$8C:0F7E]  ;\
$A7:ADF2 38          SEC                    ;|
$A7:ADF3 E9 14 00    SBC #$0014             ;} Kraid top lint Y position = [Kraid Y position] - 14h
$A7:ADF6 8D FE 0F    STA $0FFE  [$8C:0FFE]  ;/
$A7:ADF9 AD 7E 0F    LDA $0F7E  [$8C:0F7E]  ;\
$A7:ADFC 18          CLC                    ;|
$A7:ADFD 69 2E 00    ADC #$002E             ;} Kraid middle lint Y position = [Kraid Y position] + 2Eh
$A7:AE00 8D 3E 10    STA $103E  [$8C:103E]  ;/
$A7:AE03 AD 7E 0F    LDA $0F7E  [$8C:0F7E]  ;\
$A7:AE06 18          CLC                    ;|
$A7:AE07 69 70 00    ADC #$0070             ;} Kraid bottom lint Y position = [Kraid Y position] + 70h
$A7:AE0A 8D 7E 10    STA $107E  [$8C:107E]  ;/
$A7:AE0D AD E5 05    LDA $05E5  [$8C:05E5]  ;\
$A7:AE10 29 07 00    AND #$0007             ;} A = [random number] % 8
$A7:AE13 D0 03       BNE $03    [$AE18]     ; If [A] = 0:
$A7:AE15 A9 02 00    LDA #$0002             ; A = 2

$A7:AE18 0A          ASL A                  ;\
$A7:AE19 0A          ASL A                  ;|
$A7:AE1A 0A          ASL A                  ;|
$A7:AE1B 0A          ASL A                  ;} Kraid thinking timer = [A] * 40h
$A7:AE1C 0A          ASL A                  ;|
$A7:AE1D 0A          ASL A                  ;|
$A7:AE1E 8F 06 78 7E STA $7E7806[$7E:7806]  ;/
$A7:AE22 60          RTS
}


;;; $AE23: Kraid function - Kraid gets big - fade in room background ;;;
{
$A7:AE23 C2 30       REP #$30
$A7:AE25 22 6C D9 82 JSL $82D96C[$82:D96C]  ; Advance gradual colour change of BG palette 6
$A7:AE29 B0 01       BCS $01    [$AE2C]     ; If not reached target colour:
$A7:AE2B 6B          RTL                    ; Return

$A7:AE2C 20 E1 AD    JSR $ADE1  [$A7:ADE1]  ; Set up Kraid gets big - thinking
$A7:AE2F A2 80 00    LDX #$0080             ;\
$A7:AE32 AD 16 A9    LDA $A916  [$A7:A916]  ;|
$A7:AE35 20 90 AE    JSR $AE90  [$A7:AE90]  ;|
$A7:AE38 A2 C0 00    LDX #$00C0             ;|
$A7:AE3B AD 18 A9    LDA $A918  [$A7:A918]  ;} Set Kraid lint functions and timers
$A7:AE3E 20 90 AE    JSR $AE90  [$A7:AE90]  ;|
$A7:AE41 A2 00 01    LDX #$0100             ;|
$A7:AE44 AD 1A A9    LDA $A91A  [$A7:A91A]  ;|
$A7:AE47 20 90 AE    JSR $AE90  [$A7:AE90]  ;/
$A7:AE4A A9 60 BD    LDA #$BD60             ;\
$A7:AE4D 8F 80 79 7E STA $7E7980[$7E:7980]  ;} Kraid fingernail next function = initialise fingernail
$A7:AE51 8F C0 79 7E STA $7E79C0[$7E:79C0]  ;/
$A7:AE55 A9 2D B9    LDA #$B92D             ;\
$A7:AE58 8D 28 11    STA $1128  [$7E:1128]  ;} Kraid fingernail function = handle Kraid enemy function timer
$A7:AE5B 8D 68 11    STA $1168  [$7E:1168]  ;/
$A7:AE5E A9 40 00    LDA #$0040             ;\
$A7:AE61 8D 32 11    STA $1132  [$7E:1132]  ;} Kraid good fingernail function timer = 40h
$A7:AE64 A9 80 00    LDA #$0080             ;\
$A7:AE67 8D 72 11    STA $1172  [$7E:1172]  ;} Kraid bad fingernail function timer = 80h
$A7:AE6A A9 01 00    LDA #$0001             ;\
$A7:AE6D 8D EC 0F    STA $0FEC  [$7E:0FEC]  ;} Kraid arm instruction timer = 1
$A7:AE70 A9 DA 96    LDA #$96DA             ;\
$A7:AE73 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Kraid instruction list pointer = $96D2 + 8 (roar)
$A7:AE76 A9 20 01    LDA #$0120             ;\
$A7:AE79 8F 1E 78 7E STA $7E781E[$7E:781E]  ;} Kraid target X position = 120h
$A7:AE7D A9 6E BB    LDA #$BB6E             ;\
$A7:AE80 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = second phase setup
$A7:AE83 A9 01 00    LDA #$0001             ;\
$A7:AE86 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:AE89 A9 87 88    LDA #$8887             ;\
$A7:AE8C 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $8887 (Kraid is big - walking backwards)
$A7:AE8F 6B          RTL
}


;;; $AE90: Enable Kraid lints ;;;
{
$A7:AE90 9D B2 0F    STA $0FB2,x[$7E:1032]  ; Kraid enemy function timer = [A]
$A7:AE93 A9 23 B9    LDA #$B923             ;\
$A7:AE96 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Kraid enemy function = horizontally align enemy to Kraid
$A7:AE99 A9 32 B8    LDA #$B832             ;\
$A7:AE9C 9F 00 78 7E STA $7E7800,x[$7E:7880];} Kraid enemy next function = produce lint
$A7:AEA0 9E AA 0F    STZ $0FAA,x[$7E:102A]  ; Kraid enemy spawning X speed = 0
$A7:AEA3 60          RTS
}


;;; $AEA4: Kraid function - Kraid main loop - thinking ;;;
{
; This is the function for which Kraid can be shot to trigger his mouth opening
$A7:AEA4 AF 06 78 7E LDA $7E7806[$7E:7806]  ;\
$A7:AEA8 F0 19       BEQ $19    [$AEC3]     ;} If [Kraid thinking timer] = 0: return
$A7:AEAA 3A          DEC A                  ;\
$A7:AEAB 8F 06 78 7E STA $7E7806[$7E:7806]  ;} Decrement Kraid thinking timer
$A7:AEAF D0 12       BNE $12    [$AEC3]     ; If [Kraid thinking timer] != 0: return
$A7:AEB1 A9 EA BB    LDA #$BBEA             ;\
$A7:AEB4 8D A8 0F    STA $0FA8  [$A7:0FA8]  ;} Kraid function = attacking with mouth open
$A7:AEB7 A9 DA 96    LDA #$96DA             ;\
$A7:AEBA 8D AA 0F    STA $0FAA  [$A7:0FAA]  ;} Kraid instruction list pointer = $96D2 + 8 (roar)
$A7:AEBD AD D2 96    LDA $96D2  [$A7:96D2]  ;\
$A7:AEC0 8D AC 0F    STA $0FAC  [$A7:0FAC]  ;} Kraid instruction timer = 10

$A7:AEC3 6B          RTL
}


;;; $AEC4: Kraid function - Kraid gets big - thinking ;;;
{
$A7:AEC4 AF 06 78 7E LDA $7E7806[$7E:7806]  ;\
$A7:AEC8 F0 19       BEQ $19    [$AEE3]     ;} If [Kraid thinking timer] = 0: return
$A7:AECA 3A          DEC A                  ;\
$A7:AECB 8F 06 78 7E STA $7E7806[$7E:7806]  ;} Decrement Kraid thinking timer
$A7:AECF D0 12       BNE $12    [$AEE3]     ; If [Kraid thinking timer] != 0: return
$A7:AED1 A9 E4 AE    LDA #$AEE4             ;\
$A7:AED4 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = Kraid shot - Kraid's mouth is open
$A7:AED7 A9 DA 96    LDA #$96DA             ;\
$A7:AEDA 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Kraid instruction list pointer = $96D2 + 8 (roar)
$A7:AEDD AD D2 96    LDA $96D2  [$A7:96D2]  ;\
$A7:AEE0 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Kraid instruction timer = 10

$A7:AEE3 6B          RTL
}


;;; $AEE4: Kraid function - Kraid shot - Kraid's mouth is open ;;;
{
$A7:AEE4 20 32 AF    JSR $AF32  [$A7:AF32]  ; Kraid instruction list handling
$A7:AEE7 C9 FF FF    CMP #$FFFF             ;\
$A7:AEEA D0 3C       BNE $3C    [$AF28]     ;} If [A] != FFFFh: return

$A7:AEEC A9 A4 AE    LDA #$AEA4             ;\
$A7:AEEF 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = Kraid main loop
$A7:AEF2 A9 5A 00    LDA #$005A             ;\
$A7:AEF5 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Kraid instruction timer = 90
$A7:AEF8 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A7:AEFC 89 04 00    BIT #$0004             ;} If not set to reopen mouth: go to BRANCH_RETURN
$A7:AEFF F0 28       BEQ $28    [$AF29]     ;/
$A7:AF01 38          SEC                    ;\
$A7:AF02 E9 00 01    SBC #$0100             ;} Decrement Kraid mouth reopen counter
$A7:AF05 8F 0A 78 7E STA $7E780A[$7E:780A]  ;/
$A7:AF09 29 00 FF    AND #$FF00             ;\
$A7:AF0C F0 1B       BEQ $1B    [$AF29]     ;} If [Kraid mouth reopen counter] = 0: go to BRANCH_RETURN
$A7:AF0E A9 2D B9    LDA #$B92D             ;\
$A7:AF11 8D A8 0F    STA $0FA8  [$80:0FA8]  ;} Kraid function = handle Kraid enemy function timer
$A7:AF14 A9 40 00    LDA #$0040             ;\
$A7:AF17 8D B2 0F    STA $0FB2  [$80:0FB2]  ;} Kraid function timer = 40h
$A7:AF1A A9 BF B6    LDA #$B6BF             ;\
$A7:AF1D 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Kraid next function = Kraid shot
$A7:AF21 A9 02 00    LDA #$0002             ;\
$A7:AF24 8F 02 78 7E STA $7E7802[$7E:7802]  ;} $7E:7802 = 2 (never read)

$A7:AF28 6B          RTL                    ; Return

; BRANCH_RETURN
$A7:AF29 A9 00 00    LDA #$0000             ;\
$A7:AF2C 8F 0A 78 7E STA $7E780A[$7E:780A]  ;} Kraid mouth reopen flags = 0
$A7:AF30 80 F6       BRA $F6    [$AF28]     ; Return
}


;;; $AF32: Kraid instruction list handling ;;;
{
$A7:AF32 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ; A = [Kraid instruction timer]
$A7:AF35 F0 05       BEQ $05    [$AF3C]     ; If [Kraid instruction timer] = 0: return
$A7:AF37 CE AC 0F    DEC $0FAC  [$7E:0FAC]  ; Decrement Kraid instruction timer
$A7:AF3A F0 01       BEQ $01    [$AF3D]     ; If [Kraid instruction timer] = 0: go to process Kraid instruction list

$A7:AF3C 60          RTS
}


;;; $AF3D: Process Kraid instruction list ;;;
{
; Kraid instruction format
; If t & 8000h = 0:
;     tttt TTTT pppp mmmm
;     t: Timer
;     T: Tilemap pointer, fixed 2C0h bytes
;     p: Kraid projectile hitbox
;     m: Kraid's mouth projectile hitbox
; If p & 8000h != 0:
;     pppp
;     p: If FFFFh, terminator, otherwise pointer to function

$A7:AF3D AE AA 0F    LDX $0FAA  [$7E:0FAA]  ; X = [Kraid instruction list pointer]
$A7:AF40 BD 00 00    LDA $0000,x[$A7:9752]  ;|
$A7:AF43 C9 FF FF    CMP #$FFFF             ;} If [[X]] = FFFFh: return A = FFFFh
$A7:AF46 F0 3A       BEQ $3A    [$AF82]     ;/
$A7:AF48 30 39       BMI $39    [$AF83]     ; If [[X]] >= 7FFFh: go to BRANCH_ASM_INSTRUCTION
$A7:AF4A 8D AC 0F    STA $0FAC  [$7E:0FAC]  ; Kraid instruction timer = [[X]]
$A7:AF4D 8A          TXA                    ;\
$A7:AF4E 18          CLC                    ;|
$A7:AF4F 69 08 00    ADC #$0008             ;} Kraid instruction list pointer += 8
$A7:AF52 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A7:AF55 BD 02 00    LDA $0002,x[$A7:9754]  ;\
$A7:AF58 A8          TAY                    ;|
$A7:AF59 DA          PHX                    ;|
$A7:AF5A AE 30 03    LDX $0330  [$7E:0330]  ;|
$A7:AF5D A9 C0 02    LDA #$02C0             ;|
$A7:AF60 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:AF62 E8          INX                    ;|
$A7:AF63 E8          INX                    ;|
$A7:AF64 94 D0       STY $D0,x  [$7E:00D2]  ;|
$A7:AF66 E8          INX                    ;|
$A7:AF67 E8          INX                    ;|
$A7:AF68 E2 20       SEP #$20               ;|
$A7:AF6A A9 A7       LDA #$A7               ;} Queue transfer of 2C0h bytes from $A7:0000 + [[X] + 2] to VRAM BG2 tilemap base
$A7:AF6C 95 D0       STA $D0,x  [$7E:00D4]  ;|
$A7:AF6E C2 20       REP #$20               ;|
$A7:AF70 E8          INX                    ;|
$A7:AF71 A5 59       LDA $59    [$7E:0059]  ;|
$A7:AF73 29 FC 00    AND #$00FC             ;|
$A7:AF76 EB          XBA                    ;|
$A7:AF77 95 D0       STA $D0,x  [$7E:00D5]  ;|
$A7:AF79 E8          INX                    ;|
$A7:AF7A E8          INX                    ;|
$A7:AF7B 8E 30 03    STX $0330  [$7E:0330]  ;|
$A7:AF7E FA          PLX                    ;/
$A7:AF7F A9 01 00    LDA #$0001             ; Return A = 1

$A7:AF82 60          RTS

; BRANCH_ASM_INSTRUCTION
$A7:AF83 85 12       STA $12    [$7E:0012]  ;\
$A7:AF85 6C 12 00    JMP ($0012)[$A7:AF94]  ;} Execute [[Kraid instruction list pointer]]
}


;;; $AF88: Process next Kraid instruction ;;;
{
$A7:AF88 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:AF8B 18          CLC                    ;|
$A7:AF8C 69 02 00    ADC #$0002             ;} Kraid instruction list pointer += 2
$A7:AF8F 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A7:AF92 80 A9       BRA $A9    [$AF3D]     ; Go to process Kraid instruction list
}


;;; $AF94: Kraid instruction - play Kraid roar sound effect ;;;
{
$A7:AF94 DA          PHX
$A7:AF95 A9 2D 00    LDA #$002D             ;\
$A7:AF98 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 2Dh, sound library 2, max queued sounds allowed = 6 (Kraid's roar)
$A7:AF9C FA          PLX
$A7:AF9D 80 E9       BRA $E9    [$AF88]     ; Go to process next Kraid instruction
}


;;; $AF9F: Kraid instruction - play Kraid dying sound effect ;;;
{
$A7:AF9F DA          PHX
$A7:AFA0 A9 2E 00    LDA #$002E             ;\
$A7:AFA3 22 A3 90 80 JSL $8090A3[$80:90CB]  ;} Queue sound 2Eh, sound library 2, max queued sounds allowed = 6 (Kraid's dying cry)
$A7:AFA7 FA          PLX
$A7:AFA8 80 DE       BRA $DE    [$AF88]     ; Go to process next Kraid instruction
}


;;; $AFAA: Kraid's mouth / projectile collision handling ;;;
{
; The loop over projectiles is pretty wrong
; Just because there are n active projectiles, that doesn't mean they're in the first n slots,
; so it is possible for Kraid to detect a collision with an early slot inactive projectile and miss a collision with a late slot active projectile
; The initial index is one slot beyond the supposed last projectile,
; so even if using the projectile counter made sense, this would erroneously consider an inactive projectile
; This routine has no handling for bombs, but if all 5 projectile slots are active, this will read the first bomb slot,
; making it technically possible to get a bomb interaction from Kraid (trigger mouth to open and kill projectile)
$A7:AFAA C2 30       REP #$30
$A7:AFAC DA          PHX
$A7:AFAD AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:AFB0 C9 37 C5    CMP #$C537             ;} If [Kraid function] >= $C537 (dying):
$A7:AFB3 30 02       BMI $02    [$AFB7]     ;/
$A7:AFB5 FA          PLX
$A7:AFB6 60          RTS                    ; Return

$A7:AFB7 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:AFBA 38          SEC                    ;|
$A7:AFBB E9 08 00    SBC #$0008             ;} A = [[Kraid instruction list pointer] - 2] (vulnerable mouth projectile hitbox)
$A7:AFBE AA          TAX                    ;|
$A7:AFBF BD 06 00    LDA $0006,x[$A7:96D8]  ;/
$A7:AFC2 C9 FF FF    CMP #$FFFF             ;\
$A7:AFC5 D0 06       BNE $06    [$AFCD]     ;|
$A7:AFC7 A0 00 00    LDY #$0000             ;} If [A] = FFFFh: return
$A7:AFCA 4C 50 B0    JMP $B050  [$A7:B050]  ;/

$A7:AFCD AA          TAX                    ; X = (vulnerable mouth projectile hitbox)
$A7:AFCE A9 01 00    LDA #$0001             ;\
$A7:AFD1 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} $0FB0 = 1
$A7:AFD4 A0 00 00    LDY #$0000             ; Y = 0
$A7:AFD7 BD 00 00    LDA $0000,x[$A7:97B0]  ;\
$A7:AFDA 18          CLC                    ;|
$A7:AFDB 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;} $16 = [Kraid X position] + [[X]] (Kraid left boundary)
$A7:AFDE 85 16       STA $16    [$7E:0016]  ;/
$A7:AFE0 BD 02 00    LDA $0002,x[$A7:97B2]  ;\
$A7:AFE3 18          CLC                    ;|
$A7:AFE4 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;} $14 = [Kraid Y position] + [[X] + 2] (Kraid top boundary)
$A7:AFE7 85 14       STA $14    [$7E:0014]  ;/
$A7:AFE9 BD 06 00    LDA $0006,x[$A7:97B6]  ;\
$A7:AFEC 18          CLC                    ;|
$A7:AFED 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;} $12 = [Kraid Y position] + [[X] + 6] (Kraid bottom boundary)
$A7:AFF0 85 12       STA $12    [$7E:0012]  ;/
$A7:AFF2 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$A7:AFF5 F0 59       BEQ $59    [$B050]     ;} If [projectile counter] = 0: return
$A7:AFF7 0A          ASL A                  ;\
$A7:AFF8 AA          TAX                    ;} X = [projectile counter] * 2 (projectile index)

; LOOP
$A7:AFF9 BD 78 0B    LDA $0B78,x[$7E:0B7C]  ;\
$A7:AFFC 38          SEC                    ;|
$A7:AFFD FD C8 0B    SBC $0BC8,x[$7E:0BCC]  ;|
$A7:B000 3A          DEC A                  ;} If (projectile top boundary) > (Kraid bottom boundary): go to BRANCH_NEXT
$A7:B001 C5 12       CMP $12    [$7E:0012]  ;|
$A7:B003 10 47       BPL $47    [$B04C]     ;/
$A7:B005 BD 78 0B    LDA $0B78,x[$7E:0B7C]  ;\
$A7:B008 18          CLC                    ;|
$A7:B009 7D C8 0B    ADC $0BC8,x[$7E:0BCC]  ;} If (projectile bottom boundary) + 1 < (Kraid top boundary): go to BRANCH_NEXT
$A7:B00C C5 14       CMP $14    [$7E:0014]  ;|
$A7:B00E 30 3C       BMI $3C    [$B04C]     ;/
$A7:B010 BD 64 0B    LDA $0B64,x[$7E:0B66]  ;\
$A7:B013 18          CLC                    ;|
$A7:B014 7D B4 0B    ADC $0BB4,x[$7E:0BB6]  ;} If (projectile right boundary) + 1 < (Kraid left boundary): go to BRANCH_NEXT
$A7:B017 C5 16       CMP $16    [$7E:0016]  ;|
$A7:B019 30 31       BMI $31    [$B04C]     ;/
$A7:B01B BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$A7:B01E 89 00 0F    BIT #$0F00             ;} If projectile is a beam:
$A7:B021 D0 10       BNE $10    [$B033]     ;/
$A7:B023 89 10 00    BIT #$0010             ;\
$A7:B026 F0 24       BEQ $24    [$B04C]     ;} If projectile is a charged beam:
$A7:B028 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A7:B02C 09 01 00    ORA #$0001             ;} Kraid mouth reopen flags |= 1 (has no effect)
$A7:B02F 8F 0A 78 7E STA $7E780A[$7E:780A]  ;/

$A7:B033 DA          PHX
$A7:B034 8A          TXA                    ;\
$A7:B035 4A          LSR A                  ;} Collided projectile index = [X] / 2
$A7:B036 8D A6 18    STA $18A6  [$7E:18A6]  ;/
$A7:B039 08          PHP
$A7:B03A 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A7:B03E 28          PLP
$A7:B03F FA          PLX
$A7:B040 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$A7:B043 09 10 00    ORA #$0010             ;} Kill projectile
$A7:B046 9D 04 0C    STA $0C04,x[$7E:0C04]  ;/
$A7:B049 A0 01 00    LDY #$0001             ; Y = 1

; BRANCH_NEXT
$A7:B04C CA          DEX                    ;\
$A7:B04D CA          DEX                    ;} X -= 2 (next projectile)
$A7:B04E 10 A9       BPL $A9    [$AFF9]     ; If [X] >= 0: go to LOOP

$A7:B050 FA          PLX
$A7:B051 C0 00 00    CPY #$0000             ;\
$A7:B054 D0 01       BNE $01    [$B057]     ;} If [Y] = 0 (no collision):
$A7:B056 60          RTS                    ; Return

$A7:B057 A9 06 00    LDA #$0006             ;\
$A7:B05A 8F 2A 78 7E STA $7E782A[$7E:782A]  ;} Kraid hurt frame = 6
$A7:B05E A9 02 00    LDA #$0002             ;\
$A7:B061 8F 2C 78 7E STA $7E782C[$7E:782C]  ;} Kraid hurt frame timer = 2
$A7:B065 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A7:B069 89 02 00    BIT #$0002             ;} If shot with charged beam:
$A7:B06C F0 07       BEQ $07    [$B075]     ;/
$A7:B06E 09 04 00    ORA #$0004             ;\
$A7:B071 8F 0A 78 7E STA $7E780A[$7E:780A]  ;} Set mouth to reopen

$A7:B075 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:B078 C9 01 00    CMP #$0001             ;} If [Kraid health] >= 1: return
$A7:B07B 30 01       BMI $01    [$B07E]     ;/
$A7:B07D 60          RTS                    ; Return

$A7:B07E AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:B081 C9 60 C3    CMP #$C360             ;} If [Kraid function] >= $C360 (Kraid death): return
$A7:B084 10 44       BPL $44    [$B0CA]     ;/
$A7:B086 A9 60 C3    LDA #$C360             ;\
$A7:B089 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = $C360 (Kraid death)
$A7:B08C A9 00 00    LDA #$0000             ;\
$A7:B08F 8F 0A 78 7E STA $7E780A[$7E:780A]  ;} Kraid mouth reopen flags = 0
$A7:B093 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:B096 09 00 04    ORA #$0400             ;} Set Kraid as intangible
$A7:B099 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:B09C A9 FF DF    LDA #$DFFF             ;\
$A7:B09F 85 12       STA $12    [$7E:0012]  ;} Set up Kraid graphics with the tile priority cleared
$A7:B0A1 20 C6 AA    JSR $AAC6  [$A7:AAC6]  ;/
$A7:B0A4 A2 00 00    LDX #$0000             ;\
                                            ;|
$A7:B0A7 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;|
$A7:B0AA 09 00 04    ORA #$0400             ;|
$A7:B0AD 9D 86 0F    STA $0F86,x[$7E:0F86]  ;|
$A7:B0B0 8A          TXA                    ;} Set Kraid arm, lint and foot as intangible
$A7:B0B1 18          CLC                    ;|
$A7:B0B2 69 40 00    ADC #$0040             ;|
$A7:B0B5 AA          TAX                    ;|
$A7:B0B6 E0 80 01    CPX #$0180             ;|
$A7:B0B9 30 EC       BMI $EC    [$B0A7]     ;/
$A7:B0BB AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:B0BE C9 0E 97    CMP #$970E             ;} If [Kraid instruction list pointer] < $970E (roar):
$A7:B0C1 10 07       BPL $07    [$B0CA]     ;/
$A7:B0C3 18          CLC                    ;\
$A7:B0C4 69 3C 00    ADC #$003C             ;} Kraid instruction list pointer += $970E (dying roar) - $96D2 (roar)
$A7:B0C7 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/

$A7:B0CA 60          RTS
}


;;; $B0CB: Spawn explosion enemy projectile ;;;
{
$A7:B0CB BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$A7:B0CE 85 12       STA $12    [$7E:0012]  ;} $12 = [projectile X position]
$A7:B0D0 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$A7:B0D3 85 14       STA $14    [$7E:0014]  ;} $14 = [projectile Y position]
$A7:B0D5 BD 18 0C    LDA $0C18,x[$7E:0C18]
$A7:B0D8 A0 1D 00    LDY #$001D             ; A = 1Dh (big explosion)
$A7:B0DB 89 00 02    BIT #$0200             ;\
$A7:B0DE D0 03       BNE $03    [$B0E3]     ;} If projectile is not super missile:
$A7:B0E0 A0 06 00    LDY #$0006             ; A = 6 (dud shot)

$A7:B0E3 98          TYA
$A7:B0E4 A0 09 E5    LDY #$E509             ;\
$A7:B0E7 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A7:B0EB A9 3D 00    LDA #$003D             ;\
$A7:B0EE 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Dh, sound library 1, max queued sounds allowed = 6 (dud shot)
$A7:B0F2 60          RTS
}


;;; $B0F3: Kraid body / Samus collision handling ;;;
{
$A7:B0F3 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:B0F6 C9 60 C3    CMP #$C360             ;} If [Kraid function] >= $C360 (Kraid death): return
$A7:B0F9 10 64       BPL $64    [$B15F]     ;/
$A7:B0FB AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A7:B0FE 18          CLC                    ;|
$A7:B0FF 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;} $12 = (Samus right boundary) + 1
$A7:B102 85 12       STA $12    [$7E:0012]  ;/
$A7:B104 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A7:B107 38          SEC                    ;} A = [Samus Y position] - [Kraid Y position]
$A7:B108 ED 7E 0F    SBC $0F7E  [$7E:0F7E]  ;/
$A7:B10B A2 00 00    LDX #$0000             ; X = 0 (body hitbox definition index)

; LOOP
$A7:B10E DD 61 B1    CMP $B161,x[$A7:B161]  ;\
$A7:B111 10 0B       BPL $0B    [$B11E]     ;} If [Samus Y position] < [Kraid Y position] + [$B161 + [X]]:
$A7:B113 DD 65 B1    CMP $B165,x[$A7:B165]  ;\
$A7:B116 10 06       BPL $06    [$B11E]     ;} If [Samus Y position] < [Kraid Y position] + [$B161 + [X] + 4]:
$A7:B118 E8          INX                    ;\
$A7:B119 E8          INX                    ;|
$A7:B11A E8          INX                    ;} X += 4 (next body hitbox definition)
$A7:B11B E8          INX                    ;/
$A7:B11C 80 F0       BRA $F0    [$B10E]     ; Go to LOOP

$A7:B11E BD 63 B1    LDA $B163,x[$A7:B173]  ;\
$A7:B121 18          CLC                    ;|
$A7:B122 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;|
$A7:B125 38          SEC                    ;} If (Samus right boundary) < [Kraid X position] + [$B163 + [X]]: return
$A7:B126 E5 12       SBC $12    [$7E:0012]  ;|
$A7:B128 10 36       BPL $36    [$B160]     ;/
$A7:B12A AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A7:B12D C9 28 00    CMP #$0028             ;} If [Samus X position] >= 28h:
$A7:B130 30 0A       BMI $0A    [$B13C]     ;/
$A7:B132 38          SEC                    ;\
$A7:B133 E9 08 00    SBC #$0008             ;} Samus X position -= 8
$A7:B136 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$A7:B139 8D 10 0B    STA $0B10  [$7E:0B10]  ; Previous Samus X position = [Samus X position]

$A7:B13C AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A7:B13F 38          SEC                    ;|
$A7:B140 E9 08 00    SBC #$0008             ;|
$A7:B143 CF 08 78 7E CMP $7E7808[$7E:7808]  ;} A = max([$7E:7808], [Samus Y position] - 8)
$A7:B147 10 04       BPL $04    [$B14D]     ;|
$A7:B149 AF 08 78 7E LDA $7E7808[$7E:7808]  ;/

$A7:B14D 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;\
$A7:B150 8D 14 0B    STA $0B14  [$7E:0B14]  ;} Samus Y position = previous Samus Y position = [A]
$A7:B153 20 A4 94    JSR $94A4  [$A7:94A4]  ; Push Samus back
$A7:B156 AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$A7:B159 D0 05       BNE $05    [$B160]     ;} If [Samus invincibility timer] = 0:
$A7:B15B 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI

$A7:B15F 60          RTS

$A7:B160 60          RTS
}


;;; $B161: Kraid body hitbox definition table ;;;
{
;                        ________ Bottom boundary offset (following entry used as top)
;                       |     ___ Left boundary offset
;                       |    |
$A7:B161             dw 03FF,FFD0,
                        0010,FFD0,
                        0000,FFE0,
                        FFE0,FFE8,
                        FFD0,FFF8,
                        FFB0,0000,
                        FF90,0008,
                        8000,0008
}


;;; $B181: Kraid body / projectile collision handling ;;;
{
; See projectile loop note in $AFAA
$A7:B181 DA          PHX
$A7:B182 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:B185 C9 37 C5    CMP #$C537             ;} If [Kraid function] >= $C537 (fade in regular background or Kraid sinks through floor): return
$A7:B188 30 02       BMI $02    [$B18C]     ;/
$A7:B18A FA          PLX
$A7:B18B 60          RTS                    ; Return

$A7:B18C 9C B0 0F    STZ $0FB0  [$7E:0FB0]  ; $0FB0 = 0
$A7:B18F AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A7:B193 29 FE FF    AND #$FFFE             ;} Kraid mouth reopen flags &= ~1
$A7:B196 8F 0A 78 7E STA $7E780A[$7E:780A]  ;/
$A7:B19A 64 30       STZ $30    [$7E:0030]  ; $30 = 0
$A7:B19C AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:B19F 38          SEC                    ;|
$A7:B1A0 E9 08 00    SBC #$0008             ;|
$A7:B1A3 AA          TAX                    ;} X = [[Kraid instruction list pointer] - 4] (invulnerable mouth projectile hitbox)
$A7:B1A4 BD 04 00    LDA $0004,x[$A7:96D6]  ;|
$A7:B1A7 AA          TAX                    ;/
$A7:B1A8 BD 00 00    LDA $0000,x[$A7:9788]  ;\
$A7:B1AB 18          CLC                    ;|
$A7:B1AC 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;} $16 = [Kraid X position] + [[X]] (Kraid left boundary)
$A7:B1AF 85 16       STA $16    [$7E:0016]  ;/
$A7:B1B1 BD 02 00    LDA $0002,x[$A7:978A]  ;\
$A7:B1B4 18          CLC                    ;|
$A7:B1B5 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;} $14 = [Kraid Y position] + [[X] + 2] (Kraid top boundary)
$A7:B1B8 85 14       STA $14    [$7E:0014]  ;/
$A7:B1BA BD 06 00    LDA $0006,x[$A7:978E]  ;\
$A7:B1BD 18          CLC                    ;|
$A7:B1BE 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;} $12 = [Kraid Y position] + [[X] + 6] (Kraid bottom boundary)
$A7:B1C1 85 12       STA $12    [$7E:0012]  ;/
$A7:B1C3 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$A7:B1C6 F0 49       BEQ $49    [$B211]     ;} If [projectile counter] = 0: return
$A7:B1C8 0A          ASL A                  ;\
$A7:B1C9 AA          TAX                    ;} X = [projectile counter] * 2 (projectile index)

; LOOP
$A7:B1CA BD 78 0B    LDA $0B78,x[$7E:0B7A]  ;\
$A7:B1CD 38          SEC                    ;|
$A7:B1CE FD C8 0B    SBC $0BC8,x[$7E:0BCA]  ;|
$A7:B1D1 3A          DEC A                  ;} If (projectile top boundary) > (Kraid bottom boundary): go to BRANCH_BODY
$A7:B1D2 C5 12       CMP $12    [$7E:0012]  ;|
$A7:B1D4 10 62       BPL $62    [$B238]     ;/
$A7:B1D6 BD 78 0B    LDA $0B78,x[$7E:0B7A]  ;\
$A7:B1D9 18          CLC                    ;|
$A7:B1DA 7D C8 0B    ADC $0BC8,x[$7E:0BCA]  ;} If (projectile bottom boundary) + 1 < (Kraid top boundary): go to BRANCH_NEXT
$A7:B1DD C5 14       CMP $14    [$7E:0014]  ;|
$A7:B1DF 30 2C       BMI $2C    [$B20D]     ;/
$A7:B1E1 BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$A7:B1E4 18          CLC                    ;|
$A7:B1E5 7D B4 0B    ADC $0BB4,x[$7E:0BB4]  ;} If (projectile right boundary) + 1 < (Kraid left boundary): go to BRANCH_NEXT
$A7:B1E8 C5 16       CMP $16    [$7E:0016]  ;|
$A7:B1EA 30 21       BMI $21    [$B20D]     ;/

; BRANCH_HIT
$A7:B1EC 20 CB B0    JSR $B0CB  [$A7:B0CB]  ; Spawn explosion enemy projectile
$A7:B1EF BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$A7:B1F2 09 10 00    ORA #$0010             ;} Kill beam
$A7:B1F5 9D 04 0C    STA $0C04,x[$7E:0C04]  ;/
$A7:B1F8 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$A7:B1FB 89 10 00    BIT #$0010             ;} If charged beam:
$A7:B1FE F0 0B       BEQ $0B    [$B20B]     ;/
$A7:B200 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A7:B204 09 01 00    ORA #$0001             ;} Kraid mouth reopen flags |= 1
$A7:B207 8F 0A 78 7E STA $7E780A[$7E:780A]  ;/

$A7:B20B E6 30       INC $30    [$7E:0030]  ; Increment $30

; BRANCH_NEXT
$A7:B20D CA          DEX                    ;\
$A7:B20E CA          DEX                    ;} X -= 2
$A7:B20F 10 B9       BPL $B9    [$B1CA]     ; If [X] >= 0: go to LOOP

$A7:B211 FA          PLX
$A7:B212 A4 30       LDY $30    [$7E:0030]  ;\
$A7:B214 C0 00 00    CPY #$0000             ;} If [$30] = 0 (no collision): return
$A7:B217 F0 1E       BEQ $1E    [$B237]     ;/
$A7:B219 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:B21C C9 A4 AE    CMP #$AEA4             ;} If [Kraid function] != $AEA4 (Kraid main loop - thinking): return
$A7:B21F D0 16       BNE $16    [$B237]     ;/
$A7:B221 A9 BF B6    LDA #$B6BF             ;\
$A7:B224 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = Kraid shot
$A7:B227 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A7:B22B 89 01 00    BIT #$0001             ;} If [Kraid mouth reopen flags] & 1 = 0: return
$A7:B22E F0 07       BEQ $07    [$B237]     ;/
$A7:B230 09 02 03    ORA #$0302             ;\
$A7:B233 8F 0A 78 7E STA $7E780A[$7E:780A]  ;} Set mouth to reopen, Kraid mouth reopen counter = 3

$A7:B237 60          RTS                    ; Return

; BRANCH_BODY
$A7:B238 BD 64 0B    LDA $0B64,x[$7E:0B66]  ;\
$A7:B23B 18          CLC                    ;|
$A7:B23C 7D B4 0B    ADC $0BB4,x[$7E:0BB6]  ;} $12 = (projectile right boundary) + 1
$A7:B23F 85 12       STA $12    [$7E:0012]  ;/
$A7:B241 BD 78 0B    LDA $0B78,x[$7E:0B7A]  ;\
$A7:B244 38          SEC                    ;} A = [projectile Y position] - [Kraid Y position]
$A7:B245 ED 7E 0F    SBC $0F7E  [$7E:0F7E]  ;/
$A7:B248 A0 00 00    LDY #$0000             ; Y = 0 (body hitbox definition index)

; LOOP_BODY
$A7:B24B D9 61 B1    CMP $B161,y[$A7:B161]  ;\
$A7:B24E 10 0B       BPL $0B    [$B25B]     ;} If [projectile Y position] < [Kraid Y position] + [$B161 + [Y]]:
$A7:B250 D9 65 B1    CMP $B165,y[$A7:B165]  ;\
$A7:B253 10 06       BPL $06    [$B25B]     ;} If [projectile Y position] < [Kraid Y position] + [$B161 + [Y] + 4]:
$A7:B255 C8          INY                    ;\
$A7:B256 C8          INY                    ;|
$A7:B257 C8          INY                    ;} Y += 4 (next body hitbox definition)
$A7:B258 C8          INY                    ;/
$A7:B259 80 F0       BRA $F0    [$B24B]     ; Go to LOOP_BODY

$A7:B25B B9 63 B1    LDA $B163,y[$A7:B177]  ;\
$A7:B25E 18          CLC                    ;|
$A7:B25F 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;|
$A7:B262 38          SEC                    ;} If (projectile right boundary) < [Kraid X position] + [$B163 + [Y]]: go to BRANCH_NEXT
$A7:B263 E5 12       SBC $12    [$7E:0012]  ;|
$A7:B265 10 A6       BPL $A6    [$B20D]     ;/
$A7:B267 80 83       BRA $83    [$B1EC]     ; Go to BRANCH_HIT
}


;;; $B269: Unused. Handle projectile damage and sound ;;;
{
; This is like a cut-down or custom version of $A0:A6DE (handles beam damage, freezing, and sound) for enemy 0 (probably Kraid) specifically.
; There's no freeze handling, bomb and power bomb vulnerabilities are swapped, and $0FB0 is a triple damage flag
$A7:B269 DA          PHX
$A7:B26A 5A          PHY
$A7:B26B 9B          TXY                    ; Y = [X]
$A7:B26C AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:B26F B9 2C 0C    LDA $0C2C,y            ;\
$A7:B272 8D 7A 18    STA $187A  [$7E:187A]  ;} $187A = [projectile damage]
$A7:B275 B9 18 0C    LDA $0C18,y            ;\
$A7:B278 85 12       STA $12    [$7E:0012]  ;} $12 = [projectile type]
$A7:B27A B9 18 0C    LDA $0C18,y            ;\
$A7:B27D 89 18 00    BIT #$0018             ;} If plasma or charged beam:
$A7:B280 F0 06       BEQ $06    [$B288]     ;/
$A7:B282 A9 10 00    LDA #$0010             ;\
$A7:B285 8D A0 0F    STA $0FA0  [$7E:0FA0]  ;} Enemy 0 invincibility timer = 10h

$A7:B288 AE 78 0F    LDX $0F78  [$7E:0F78]  ;\
$A7:B28B BF 3C 00 A0 LDA $A0003C,x          ;} $14 = (enemy 0 vulnerabilities)
$A7:B28F D0 03       BNE $03    [$B294]     ; If [$14] = 0:
$A7:B291 A9 1C EC    LDA #$EC1C             ; $14 = $EC1C

$A7:B294 85 14       STA $14    [$7E:0014]
$A7:B296 A5 12       LDA $12    [$7E:0012]  ;\
$A7:B298 89 00 0F    BIT #$0F00             ;} If beam:
$A7:B29B D0 0D       BNE $0D    [$B2AA]     ;/
$A7:B29D 29 FF 00    AND #$00FF             ;\
$A7:B2A0 18          CLC                    ;|
$A7:B2A1 65 14       ADC $14    [$7E:0014]  ;} $0E32 = [$B4:0000 + [$14] + (beam type)]
$A7:B2A3 AA          TAX                    ;|
$A7:B2A4 BF 00 00 B4 LDA $B40000,x          ;/
$A7:B2A8 80 30       BRA $30    [$B2DA]     ; Go to BRANCH_DETERMINED_VULNERABILITY

$A7:B2AA 29 00 0F    AND #$0F00             ;\
$A7:B2AD C9 00 01    CMP #$0100             ;|
$A7:B2B0 F0 05       BEQ $05    [$B2B7]     ;} If not (super) missile: go to BRANCH_MISSILE_END
$A7:B2B2 C9 00 02    CMP #$0200             ;|
$A7:B2B5 D0 0B       BNE $0B    [$B2C2]     ;/

$A7:B2B7 EB          XBA                    ;\
$A7:B2B8 18          CLC                    ;|
$A7:B2B9 65 14       ADC $14    [$7E:0014]  ;} $0E32 = [$B4:0000 + [$14] + Bh + (missile type)]
$A7:B2BB AA          TAX                    ;|
$A7:B2BC BF 0B 00 B4 LDA $B4000B,x          ;/
$A7:B2C0 80 18       BRA $18    [$B2DA]     ; Go to BRANCH_DETERMINED_VULNERABILITY

; BRANCH_MISSILE_END
$A7:B2C2 C9 00 03    CMP #$0300             ;\
$A7:B2C5 D0 08       BNE $08    [$B2CF]     ;} If power bomb:
$A7:B2C7 A6 14       LDX $14    [$7E:0014]  ;\
$A7:B2C9 BF 0E 00 B4 LDA $B4000E,x          ;} $0E32 = [$B4:0000 + [$14] + Eh]
$A7:B2CD 80 0B       BRA $0B    [$B2DA]     ; Go to BRANCH_DETERMINED_VULNERABILITY

$A7:B2CF C9 00 05    CMP #$0500             ;\
$A7:B2D2 D0 60       BNE $60    [$B334]     ;} If bomb:
$A7:B2D4 A6 14       LDX $14    [$7E:0014]  ;\
$A7:B2D6 BF 0F 00 B4 LDA $B4000F,x          ;} $0E32 = [$B4:0000 + [$14] + Fh]

; BRANCH_DETERMINED_VULNERABILITY
$A7:B2DA 29 FF 00    AND #$00FF
$A7:B2DD 8D 32 0E    STA $0E32  [$7E:0E32]
$A7:B2E0 F0 52       BEQ $52    [$B334]     ; If [$0E32] = 0: return
$A7:B2E2 AD 7A 18    LDA $187A  [$7E:187A]  ;\
$A7:B2E5 4A          LSR A                  ;|
$A7:B2E6 8D 02 42    STA $4202  [$7E:4202]  ;|
$A7:B2E9 E2 20       SEP #$20               ;|
$A7:B2EB AD 32 0E    LDA $0E32  [$7E:0E32]  ;|
$A7:B2EE 8D 03 42    STA $4203  [$7E:4203]  ;|
$A7:B2F1 EA          NOP                    ;} A = [projectile damage] * [$0E32] / 2
$A7:B2F2 EA          NOP                    ;|
$A7:B2F3 EA          NOP                    ;|
$A7:B2F4 EA          NOP                    ;|
$A7:B2F5 EA          NOP                    ;|
$A7:B2F6 C2 20       REP #$20               ;|
$A7:B2F8 AD 16 42    LDA $4216  [$7E:4216]  ;/
$A7:B2FB F0 37       BEQ $37    [$B334]     ; If [A] = 0: return
$A7:B2FD 8D 7A 18    STA $187A  [$7E:187A]  ; $187A = [A]
$A7:B300 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:B303 38          SEC                    ;} >_<
$A7:B304 ED 7A 18    SBC $187A  [$7E:187A]  ;/
$A7:B307 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:B30A 38          SEC                    ;|
$A7:B30B ED 7A 18    SBC $187A  [$7E:187A]  ;} Enemy 0 health -= [$187A]
$A7:B30E 8D 8C 0F    STA $0F8C  [$7E:0F8C]  ;/
$A7:B311 AD B0 0F    LDA $0FB0  [$7E:0FB0]  ;\
$A7:B314 F0 13       BEQ $13    [$B329]     ;} If [$0FB0] = 0: go to BRANCH_TRIPLE_DAMAGE_END
$A7:B316 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:B319 38          SEC                    ;|
$A7:B31A ED 7A 18    SBC $187A  [$7E:187A]  ;|
$A7:B31D 38          SEC                    ;|
$A7:B31E ED 7A 18    SBC $187A  [$7E:187A]  ;} Enemy health = max(0, [enemy health] - [$187A] * 2)
$A7:B321 10 03       BPL $03    [$B326]     ;|
$A7:B323 A9 00 00    LDA #$0000             ;|
                                            ;|
$A7:B326 8D 8C 0F    STA $0F8C  [$7E:0F8C]  ;/

; BRANCH_TRIPLE_DAMAGE_END
$A7:B329 AE 78 0F    LDX $0F78  [$7E:0F78]  ;\
$A7:B32C BF 0E 00 A0 LDA $A0000E,x          ;} A = (enemy 0 cry)
$A7:B330 22 CB 90 80 JSL $8090CB[$80:90CB]  ; Queue sound [A], sound library 2, max queued sounds allowed = 6

$A7:B334 7A          PLY
$A7:B335 FA          PLX
$A7:B336 60          RTS
}


;;; $B337: Kraid palette handling ;;;
{
$A7:B337 DA          PHX
$A7:B338 5A          PHY
$A7:B339 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:B33C C9 01 00    CMP #$0001             ;} If [Kraid health] < 1:
$A7:B33F 10 06       BPL $06    [$B347]     ;/
$A7:B341 8F 2A 78 7E STA $7E782A[$7E:782A]  ; Kraid hurt frame = 0
$A7:B345 80 21       BRA $21    [$B368]

$A7:B347 AF 2A 78 7E LDA $7E782A[$7E:782A]  ;\ Else ([Kraid health] >= 1):
$A7:B34B F0 21       BEQ $21    [$B36E]     ;} If [Kraid hurt frame] = 0: return
$A7:B34D AF 2C 78 7E LDA $7E782C[$7E:782C]  ;\
$A7:B351 3A          DEC A                  ;} Decrement Kraid hurt frame timer
$A7:B352 8F 2C 78 7E STA $7E782C[$7E:782C]  ;/
$A7:B356 D0 16       BNE $16    [$B36E]     ; If [Kraid hurt frame timer] != 0: return
$A7:B358 A9 02 00    LDA #$0002             ;\
$A7:B35B 8F 2C 78 7E STA $7E782C[$7E:782C]  ;} Kraid hurt frame timer = 2
$A7:B35F AF 2A 78 7E LDA $7E782A[$7E:782A]  ;\
$A7:B363 3A          DEC A                  ;} Decrement Kraid hurt frame
$A7:B364 8F 2A 78 7E STA $7E782A[$7E:782A]  ;/

$A7:B368 20 71 B3    JSR $B371  [$A7:B371]  ; Kraid hurt flash handling
$A7:B36B 20 94 B3    JSR $B394  [$A7:B394]  ; Kraid health-based palette handling

$A7:B36E 7A          PLY
$A7:B36F FA          PLX
$A7:B370 60          RTS
}


;;; $B371: Kraid hurt flash handling ;;;
{
; This routine is redundant/incorrect, $B394 handles the flash frames properly
$A7:B371 A0 00 00    LDY #$0000             ; Y = 0
$A7:B374 AF 2A 78 7E LDA $7E782A[$7E:782A]  ;\
$A7:B378 89 01 00    BIT #$0001             ;} If [Kraid hurt frame] % 2 = 0:
$A7:B37B D0 03       BNE $03    [$B380]     ;/
$A7:B37D A0 20 00    LDY #$0020             ; Y = 20h

$A7:B380 A2 00 00    LDX #$0000             ;\
                                            ;|
$A7:B383 B9 13 B5    LDA $B513,y[$A7:B513]  ;|
$A7:B386 9F E0 C1 7E STA $7EC1E0,x[$7E:C1E0];|
$A7:B38A E8          INX                    ;|
$A7:B38B E8          INX                    ;} Copy 20h bytes from $B513 + [Y] to sprite palette 7
$A7:B38C C8          INY                    ;|
$A7:B38D C8          INY                    ;|
$A7:B38E E0 20 00    CPX #$0020             ;|
$A7:B391 30 F0       BMI $F0    [$B383]     ;/
$A7:B393 60          RTS
}


;;; $B394: Kraid health-based palette handling ;;;
{
$A7:B394 A0 00 00    LDY #$0000             ; Y = 0
$A7:B397 AF 2A 78 7E LDA $7E782A[$7E:782A]  ;\
$A7:B39B 89 01 00    BIT #$0001             ;} If [Kraid hurt frame] % 2 != 0: go to BRANCH_HURT_FLASH_FRAME
$A7:B39E D0 18       BNE $18    [$B3B8]     ;/
$A7:B3A0 A2 0E 00    LDX #$000E             ;\
$A7:B3A3 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;|
                                            ;|
$A7:B3A6 DF 0C 78 7E CMP $7E780C,x[$7E:781A];|
$A7:B3AA 10 04       BPL $04    [$B3B0]     ;|
$A7:B3AC CA          DEX                    ;|
$A7:B3AD CA          DEX                    ;|
$A7:B3AE D0 F6       BNE $F6    [$B3A6]     ;|
                                            ;} Y = max(1, [Kraid health] * 8 / (Kraid max health)) * 20h
$A7:B3B0 E8          INX                    ;|
$A7:B3B1 E8          INX                    ;|
$A7:B3B2 8A          TXA                    ;|
$A7:B3B3 0A          ASL A                  ;|
$A7:B3B4 0A          ASL A                  ;|
$A7:B3B5 0A          ASL A                  ;|
$A7:B3B6 0A          ASL A                  ;|
$A7:B3B7 A8          TAY                    ;/

; BRANCH_HURT_FLASH_FRAME
$A7:B3B8 A2 00 00    LDX #$0000             ;\
                                            ;|
$A7:B3BB B9 D3 B3    LDA $B3D3,y[$A7:B3D3]  ;|
$A7:B3BE 9F E0 C0 7E STA $7EC0E0,x[$7E:C0E0];|
$A7:B3C2 B9 13 B5    LDA $B513,y[$A7:B513]  ;|
$A7:B3C5 9F E0 C1 7E STA $7EC1E0,x[$7E:C1E0];} Copy 20h bytes from $B3D3 + [Y] to BG palette 7
$A7:B3C9 C8          INY                    ;} Copy 20h bytes from $B513 + [Y] to sprite palette 7
$A7:B3CA C8          INY                    ;|
$A7:B3CB E8          INX                    ;|
$A7:B3CC E8          INX                    ;|
$A7:B3CD E0 20 00    CPX #$0020             ;|
$A7:B3D0 30 E9       BMI $E9    [$B3BB]     ;/
$A7:B3D2 60          RTS
}


;;; $B3D3: Kraid BG palette 7 ;;;
{
$A7:B3D3             dw 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF ; [Kraid hurt frame] is odd
$A7:B3F3             dw 0000, 559D, 1816, 100D, 127A, 0E17, 0DD3, 0970, 092D, 04CA, 0486, 0023, 0443, 3E52, 4AD5, 0000 ; [Kraid health] < [Kraid max health * 2/8]
$A7:B413             dw 3800, 559D, 1816, 100D, 1A9B, 1637, 11F3, 0D8F, 0D4C, 08E9, 04A6, 0043, 0443, 4273, 52F6, 0000 ; [Kraid health] >= [Kraid max health * 2/8]
$A7:B433             dw 3800, 559D, 1816, 100D, 22DB, 1A77, 1A12, 15AE, 116C, 0D09, 08A6, 0444, 0423, 4A94, 5B38, 0000 ; [Kraid health] >= [Kraid max health * 3/8]
$A7:B453             dw 3800, 559D, 1816, 100D, 2AFC, 2297, 1E32, 19CD, 158B, 1128, 08C6, 0464, 0423, 4EB5, 6359, 0000 ; [Kraid health] >= [Kraid max health * 4/8]
$A7:B473             dw 3800, 559D, 1816, 100D, 331D, 2AB7, 2A91, 1E0C, 19AA, 1148, 0CE5, 0484, 0023, 52B5, 677B, 0000 ; [Kraid health] >= [Kraid max health * 5/8]
$A7:B493             dw 3800, 559D, 1816, 100D, 3B3E, 32D7, 32B0, 222B, 1DC9, 1567, 0D05, 04A4, 0023, 56D6, 6F9C, 0000 ; [Kraid health] >= [Kraid max health * 6/8]
$A7:B4B3             dw 3800, 559D, 1816, 100D, 437E, 3717, 32B0, 2A4A, 21E9, 1987, 1105, 08A5, 0003, 5EF7, 77DE, 0000 ; [Kraid health] >= [Kraid max health * 7/8]
$A7:B4D3             dw 3800, 559D, 1816, 100D, 4B9F, 3F37, 36D0, 2E69, 2608, 1DA6, 1125, 08C5, 0003, 6318, 7FFF, 0000 ; [Kraid health] >= [Kraid max health * 8/8]

; Kraid death
$A7:B4F3             dw 3800, 0807, 0404, 0000, 127A, 0E17, 0DD3, 0970, 092D, 04CA, 0486, 0023, 0443, 3E52, 4AD5, 0000
}


;;; $B513: Kraid sprite palette 7 ;;;
{
$A7:B513             dw 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF, 7FFF ; [Kraid hurt frame] is odd
$A7:B533             dw 0000, 559D, 1816, 100D, 127A, 0E17, 0DD3, 0970, 092D, 04CA, 0486, 0023, 0443, 3E52, 4AD5, 0000 ; [Kraid health] < [Kraid max health * 2/8]
$A7:B553             dw 3800, 559D, 1816, 100D, 1A9B, 1637, 11F3, 0D8F, 0D4C, 08E9, 04A6, 0043, 0443, 4273, 52F6, 0000 ; [Kraid health] >= [Kraid max health * 2/8]
$A7:B573             dw 3800, 559D, 1816, 100D, 22DB, 1A77, 1A12, 15AE, 116C, 0D09, 08A6, 0444, 0423, 4A94, 5B38, 0000 ; [Kraid health] >= [Kraid max health * 3/8]
$A7:B593             dw 3800, 559D, 1816, 100D, 2AFC, 2297, 1E32, 19CD, 158B, 1128, 08C6, 0464, 0423, 4EB5, 6359, 0000 ; [Kraid health] >= [Kraid max health * 4/8]
$A7:B5B3             dw 3800, 559D, 1816, 100D, 331D, 2AB7, 2A91, 1E0C, 19AA, 1148, 0CE5, 0484, 0023, 52B5, 677B, 0000 ; [Kraid health] >= [Kraid max health * 5/8]
$A7:B5D3             dw 3800, 559D, 1816, 100D, 3B3E, 32D7, 32B0, 222B, 1DC9, 1567, 0D05, 04A4, 0023, 56D6, 6F9C, 0000 ; [Kraid health] >= [Kraid max health * 6/8]
$A7:B5F3             dw 3800, 559D, 1816, 100D, 437E, 3717, 32B0, 2A4A, 21E9, 1987, 1105, 08A5, 0003, 5EF7, 77DE, 0000 ; [Kraid health] >= [Kraid max health * 7/8]
$A7:B613             dw 3800, 559D, 1816, 100D, 4B9F, 3F37, 36D0, 2E69, 2608, 1DA6, 1125, 08C5, 0003, 6318, 7FFF, 0000 ; [Kraid health] >= [Kraid max health * 8/8]
}


;;; $B633: Instruction - NOP ;;;
{
$A7:B633 DA          PHX
$A7:B634 FA          PLX
$A7:B635 6B          RTL
}


;;; $B636: Instruction - decrement Kraid Y position ;;;
{
$A7:B636 DA          PHX
$A7:B637 CE 7E 0F    DEC $0F7E  [$7E:0F7E]
$A7:B63A FA          PLX
$A7:B63B 6B          RTL
}


;;; $B63C: Instruction - increment Kraid Y position, set screen shaking ;;;
{
$A7:B63C DA          PHX
$A7:B63D EE 7E 0F    INC $0F7E  [$7E:0F7E]  ; Increment Kraid Y position
$A7:B640 A9 01 00    LDA #$0001             ;\
$A7:B643 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 1 pixel displacement, vertical
$A7:B646 A9 0A 00    LDA #$000A             ;\
$A7:B649 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = Ah
$A7:B64C FA          PLX
$A7:B64D 6B          RTL
}


;;; $B64E: Instruction - queue sound 76h, sound library 2, max queued sounds allowed = 6 (quake) ;;;
{
$A7:B64E DA          PHX
$A7:B64F 5A          PHY
$A7:B650 A9 76 00    LDA #$0076             ;\
$A7:B653 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 76h, sound library 2, max queued sounds allowed = 6 (quake)
$A7:B657 7A          PLY
$A7:B658 FA          PLX
$A7:B659 6B          RTL
}


;;; $B65A: Instruction - Kraid X position -= 3 ;;;
{
$A7:B65A DA          PHX
$A7:B65B AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A7:B65E 38          SEC
$A7:B65F ED 1C A9    SBC $A91C  [$A7:A91C]
$A7:B662 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A7:B665 FA          PLX
$A7:B666 6B          RTL
}


;;; $B667: Instruction - Kraid X position -= 3 ;;;
{
; Clone of $B65A
$A7:B667 DA          PHX
$A7:B668 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A7:B66B 38          SEC
$A7:B66C ED 1C A9    SBC $A91C  [$A7:A91C]
$A7:B66F 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A7:B672 FA          PLX
$A7:B673 6B          RTL
}


;;; $B674: Instruction - Kraid X position += 3 ;;;
{
$A7:B674 DA          PHX
$A7:B675 5A          PHY
$A7:B676 AD 20 A9    LDA $A920  [$A7:A920]
$A7:B679 18          CLC
$A7:B67A 6D 7A 0F    ADC $0F7A  [$7E:0F7A]
$A7:B67D 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A7:B680 7A          PLY
$A7:B681 FA          PLX
$A7:B682 6B          RTL
}


;;; $B683: Instruction - move Kraid right ;;;
{
$A7:B683 DA          PHX
$A7:B684 5A          PHY
$A7:B685 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:B688 C9 40 01    CMP #$0140             ;} If [Kraid X position] >= 140h:
$A7:B68B 30 0B       BMI $0B    [$B698]     ;/
$A7:B68D AF 1E 78 7E LDA $7E781E[$7E:781E]  ;\
$A7:B691 3A          DEC A                  ;} Decrement Kraid target X position
$A7:B692 8F 1E 78 7E STA $7E781E[$7E:781E]  ;/
$A7:B696 D0 10       BNE $10    [$B6A8]     ; If [Kraid target X position] != 0: return

$A7:B698 A2 00 00    LDX #$0000             ;\
$A7:B69B 64 12       STZ $12    [$7E:0012]  ;|
$A7:B69D AD 22 A9    LDA $A922  [$82:A922]  ;} Move Kraid right 4.0
$A7:B6A0 85 14       STA $14    [$7E:0014]  ;|
$A7:B6A2 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A7:B6A6 B0 03       BCS $03    [$B6AB]     ;} If collided with wall: go to BRANCH_COLLISION

$A7:B6A8 7A          PLY
$A7:B6A9 FA          PLX
$A7:B6AA 6B          RTL                    ; Return

; BRANCH_COLLISION
$A7:B6AB A9 00 00    LDA #$0000             ;\
$A7:B6AE 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 1 pixel displacement, horizontal
$A7:B6B1 A9 07 00    LDA #$0007             ;\
$A7:B6B4 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 7
$A7:B6B7 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:B6BA 8D BA 10    STA $10BA  [$7E:10BA]  ;} Kraid foot X position = [Kraid X position]
$A7:B6BD 80 E9       BRA $E9    [$B6A8]
}


;;; $B6BF: Kraid function - Kraid shot - initialise Kraid eye glowing ;;;
{
$A7:B6BF A9 E4 AE    LDA #$AEE4             ;\
$A7:B6C2 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} >_<;
$A7:B6C5 A9 D7 B6    LDA #$B6D7             ;\
$A7:B6C8 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = Kraid shot - glow Kraid's eye
$A7:B6CB A9 52 97    LDA #$9752             ;\
$A7:B6CE 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Kraid instruction list pointer = $974A + 8 (eye glowing)
$A7:B6D1 AD 4A 97    LDA $974A  [$A7:974A]  ;\
$A7:B6D4 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Kraid instruction timer = 5
}


;;; $B6D7: Kraid function - Kraid shot - glow Kraid's eye ;;;
{
$A7:B6D7 DA          PHX
$A7:B6D8 5A          PHY
$A7:B6D9 20 32 AF    JSR $AF32  [$A7:AF32]  ; Kraid instruction list handling
$A7:B6DC C9 FF FF    CMP #$FFFF             ;\
$A7:B6DF D0 06       BNE $06    [$B6E7]     ;} If [A] = FFFFh:
$A7:B6E1 A9 00 01    LDA #$0100             ;\
$A7:B6E4 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;} Typo (should be `Kraid instruction timer = 100h`, has no effect anyway)

$A7:B6E7 A2 E2 00    LDX #$00E2             ;\
$A7:B6EA A0 00 00    LDY #$0000             ;|
                                            ;|
$A7:B6ED BF 00 C0 7E LDA $7EC000,x[$7E:C0E2];|
$A7:B6F1 29 1F 00    AND #$001F             ;|
$A7:B6F4 18          CLC                    ;|
$A7:B6F5 69 01 00    ADC #$0001             ;|
$A7:B6F8 C9 1F 00    CMP #$001F             ;|
$A7:B6FB 30 04       BMI $04    [$B701]     ;|
$A7:B6FD C8          INY                    ;|
$A7:B6FE A9 1F 00    LDA #$001F             ;|
                                            ;|
$A7:B701 85 12       STA $12    [$7E:0012]  ;|
$A7:B703 BF 00 C0 7E LDA $7EC000,x[$7E:C0E2];|
$A7:B707 29 E0 03    AND #$03E0             ;|
$A7:B70A 18          CLC                    ;} Increment yellow component of BG palette 7 colours 1..3
$A7:B70B 69 20 00    ADC #$0020             ;} Y = number of maximum intensities of green and red
$A7:B70E C9 E0 03    CMP #$03E0             ;|
$A7:B711 30 04       BMI $04    [$B717]     ;|
$A7:B713 C8          INY                    ;|
$A7:B714 A9 E0 03    LDA #$03E0             ;|
                                            ;|
$A7:B717 85 14       STA $14    [$7E:0014]  ;|
$A7:B719 BF 00 C0 7E LDA $7EC000,x[$7E:C0E2];|
$A7:B71D 29 00 FC    AND #$FC00             ;|
$A7:B720 05 12       ORA $12    [$7E:0012]  ;|
$A7:B722 05 14       ORA $14    [$7E:0014]  ;|
$A7:B724 9F 00 C0 7E STA $7EC000,x[$7E:C0E2];|
$A7:B728 E8          INX                    ;|
$A7:B729 E8          INX                    ;|
$A7:B72A E0 E8 00    CPX #$00E8             ;|
$A7:B72D 30 BE       BMI $BE    [$B6ED]     ;/
$A7:B72F C0 06 00    CPY #$0006             ;\
$A7:B732 30 06       BMI $06    [$B73A]     ;} If maximum yellow:
$A7:B734 A9 3D B7    LDA #$B73D             ;\
$A7:B737 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = unglow Kraid's eye

$A7:B73A 7A          PLY
$A7:B73B FA          PLX
$A7:B73C 6B          RTL
}


;;; $B73D: Kraid function - Kraid shot - unglow Kraid's eye ;;;
{
$A7:B73D DA          PHX
$A7:B73E 5A          PHY
$A7:B73F A2 0E 00    LDX #$000E             ;\
$A7:B742 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;|
                                            ;|
$A7:B745 DF 0C 78 7E CMP $7E780C,x[$7E:781A];|
$A7:B749 10 04       BPL $04    [$B74F]     ;|
$A7:B74B CA          DEX                    ;|
$A7:B74C CA          DEX                    ;|
$A7:B74D D0 F6       BNE $F6    [$B745]     ;|
                                            ;} Y = max(1, [Kraid health] * 8 / (Kraid max health)) * 20h
$A7:B74F E8          INX                    ;|
$A7:B750 E8          INX                    ;|
$A7:B751 8A          TXA                    ;|
$A7:B752 0A          ASL A                  ;|
$A7:B753 0A          ASL A                  ;|
$A7:B754 0A          ASL A                  ;|
$A7:B755 0A          ASL A                  ;|
$A7:B756 A8          TAY                    ;/
$A7:B757 A2 E2 00    LDX #$00E2             ;\
$A7:B75A 64 14       STZ $14    [$7E:0014]  ;|
                                            ;|
$A7:B75C BF 00 C0 7E LDA $7EC000,x[$7E:C0E2];|
$A7:B760 29 1F 00    AND #$001F             ;|
$A7:B763 85 12       STA $12    [$7E:0012]  ;|
$A7:B765 B9 D5 B3    LDA $B3D5,y[$A7:B4D5]  ;|
$A7:B768 29 1F 00    AND #$001F             ;|
$A7:B76B C5 12       CMP $12    [$7E:0012]  ;|
$A7:B76D F0 0B       BEQ $0B    [$B77A]     ;|
$A7:B76F E6 14       INC $14    [$7E:0014]  ;|
$A7:B771 BF 00 C0 7E LDA $7EC000,x[$7E:C0E2];|
$A7:B775 3A          DEC A                  ;|
$A7:B776 9F 00 C0 7E STA $7EC000,x[$7E:C0E2];|
                                            ;|
$A7:B77A BF 00 C0 7E LDA $7EC000,x[$7E:C0E2];|
$A7:B77E 29 E0 03    AND #$03E0             ;} Decrement yellow component of BG palette 7 colours 1..3 down to colours 1..3 of $B3D3 + [Y]
$A7:B781 85 12       STA $12    [$7E:0012]  ;} $14 = number of green and red components that reached their destination
$A7:B783 B9 D5 B3    LDA $B3D5,y[$A7:B4D5]  ;|
$A7:B786 29 E0 03    AND #$03E0             ;|
$A7:B789 C5 12       CMP $12    [$7E:0012]  ;|
$A7:B78B F0 0E       BEQ $0E    [$B79B]     ;|
$A7:B78D E6 14       INC $14    [$7E:0014]  ;|
$A7:B78F BF 00 C0 7E LDA $7EC000,x[$7E:C0E2];|
$A7:B793 38          SEC                    ;|
$A7:B794 E9 20 00    SBC #$0020             ;|
$A7:B797 9F 00 C0 7E STA $7EC000,x[$7E:C0E2];|
                                            ;|
$A7:B79B E8          INX                    ;|
$A7:B79C E8          INX                    ;|
$A7:B79D C8          INY                    ;|
$A7:B79E C8          INY                    ;|
$A7:B79F E0 E8 00    CPX #$00E8             ;|
$A7:B7A2 30 B8       BMI $B8    [$B75C]     ;/
$A7:B7A4 A5 14       LDA $14    [$7E:0014]  ;\
$A7:B7A6 D0 12       BNE $12    [$B7BA]     ;} If [$14] = 0:
$A7:B7A8 A9 E4 AE    LDA #$AEE4             ;\
$A7:B7AB 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = Kraid's mouth is open
$A7:B7AE A9 DA 96    LDA #$96DA             ;\
$A7:B7B1 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Kraid instruction list pointer = $96D2 + 8 (roar)
$A7:B7B4 AD D2 96    LDA $96D2  [$A7:96D2]  ;\
$A7:B7B7 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Kraid instruction timer = Ah

$A7:B7BA 7A          PLY
$A7:B7BB FA          PLX
$A7:B7BC 6B          RTL
}


;;; $B7BD: Main AI - enemy $E2FF (Kraid's arm) ;;;
{
$A7:B7BD AD 15 09    LDA $0915  [$7E:0915]  ;\
$A7:B7C0 18          CLC                    ;|
$A7:B7C1 69 E0 00    ADC #$00E0             ;} $12 = [layer 1 Y position] + E0h
$A7:B7C4 85 12       STA $12    [$7E:0012]  ;/
$A7:B7C6 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A7:B7C9 38          SEC                    ;|
$A7:B7CA E9 2C 00    SBC #$002C             ;} Kraid arm Y position = [Kraid Y position] - 2Ch
$A7:B7CD 8D BE 0F    STA $0FBE  [$7E:0FBE]  ;/
$A7:B7D0 A8          TAY
$A7:B7D1 AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A7:B7D4 09 00 01    ORA #$0100             ;} Set Kraid arm as invisible
$A7:B7D7 CC 15 09    CPY $0915  [$7E:0915]  ;\
$A7:B7DA 30 07       BMI $07    [$B7E3]     ;|
$A7:B7DC C4 12       CPY $12    [$7E:0012]  ;} If [layer 1 Y position] <= [Kraid arm Y position] < [layer 1 Y position] + E0h:
$A7:B7DE 10 03       BPL $03    [$B7E3]     ;/
$A7:B7E0 29 FF FE    AND #$FEFF             ; Set Kraid arm visible

$A7:B7E3 8D C6 0F    STA $0FC6  [$7E:0FC6]
$A7:B7E6 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:B7E9 18          CLC                    ;|
$A7:B7EA 69 00 00    ADC #$0000             ;} Kraid arm X position = [Kraid X position]
$A7:B7ED 8D BA 0F    STA $0FBA  [$7E:0FBA]  ;/
$A7:B7F0 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A7:B7F4 89 00 FF    BIT #$FF00             ;} If [Kraid mouth reopen counter] != 0: (if shot with charge beam)
$A7:B7F7 F0 07       BEQ $07    [$B800]     ;/
$A7:B7F9 AD D4 0F    LDA $0FD4  [$82:0FD4]  ;\
$A7:B7FC 1A          INC A                  ;} Increment Kraid arm instruction timer (freeze arm)
$A7:B7FD 8D D4 0F    STA $0FD4  [$82:0FD4]  ;/

$A7:B800 6B          RTL
}


;;; $B801: Main AI - enemy $E33F (Kraid top lint) ;;;
{
$A7:B801 A2 80 00    LDX #$0080             ; X = Kraid top lint enemy index
$A7:B804 A9 FF 7F    LDA #$7FFF             ;\
$A7:B807 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Kraid top lint instruction timer = 7FFFh
$A7:B80A 4C 22 B8    JMP $B822  [$A7:B822]  ; Kraid lint main AI
}


;;; $B80D: Main AI - enemy $E37F (Kraid middle lint) ;;;
{
$A7:B80D A2 C0 00    LDX #$00C0             ; X = Kraid middle lint enemy index
$A7:B810 A9 FF 7F    LDA #$7FFF             ;\
$A7:B813 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Kraid top lint instruction timer = 7FFFh
$A7:B816 4C 22 B8    JMP $B822  [$A7:B822]  ; Kraid lint main AI
}


;;; $B819: Main AI - enemy $E3BF (Kraid bottom lint) ;;;
{
$A7:B819 A2 00 01    LDX #$0100             ; X = Kraid bottom lint enemy index
$A7:B81C A9 FF 7F    LDA #$7FFF             ;\
$A7:B81F 9D 94 0F    STA $0F94,x[$7E:1094]  ;} Kraid top lint instruction timer = 7FFFh
}


;;; $B822: Kraid lint main AI ;;;
{
$A7:B822 20 6A B9    JSR $B96A  [$A7:B96A]  ; Kraid lint / Samus collision handling
$A7:B825 AD 15 09    LDA $0915  [$7E:0915]  ;\
$A7:B828 18          CLC                    ;|
$A7:B829 69 E0 00    ADC #$00E0             ;} $12 = [layer 1 Y position] + E0h (unused)
$A7:B82C 85 12       STA $12    [$7E:0012]  ;/
$A7:B82E 7C A8 0F    JMP ($0FA8,x)[$A7:B831]; Execute [enemy function]
$A7:B831 6B          RTL
}


;;; $B832: Kraid lint function - produce lint ;;;
{
$A7:B832 BD 86 0F    LDA $0F86,x[$7E:1086]  ;\
$A7:B835 29 FF FE    AND #$FEFF             ;|
$A7:B838 29 FF FB    AND #$FBFF             ;} Make enemy visible and tangible
$A7:B83B 9D 86 0F    STA $0F86,x[$7E:1086]  ;/
$A7:B83E AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:B841 18          CLC                    ;|
$A7:B842 7D AC 0F    ADC $0FAC,x[$7E:10AC]  ;|
$A7:B845 38          SEC                    ;} Enemy X position += [Kraid lint X additional spawning velocity] - [Kraid lint spawning X speed]
$A7:B846 FD AA 0F    SBC $0FAA,x[$7E:10AA]  ;|
$A7:B849 9D 7A 0F    STA $0F7A,x[$7E:107A]  ;/
$A7:B84C BD AA 0F    LDA $0FAA,x[$7E:10AA]  ;\
$A7:B84F 18          CLC                    ;|
$A7:B850 69 01 00    ADC #$0001             ;} Increment Kraid lint spawning X speed
$A7:B853 9D AA 0F    STA $0FAA,x[$7E:10AA]  ;/
$A7:B856 C9 20 00    CMP #$0020             ;\
$A7:B859 30 0C       BMI $0C    [$B867]     ;} If [Kraid lint spawning X speed] >= 20h:
$A7:B85B A9 68 B8    LDA #$B868             ;\
$A7:B85E 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Kraid enemy function = charge lint
$A7:B861 A9 1E 00    LDA #$001E             ;\
$A7:B864 9D B2 0F    STA $0FB2,x[$7E:10B2]  ;} Kraid enemy function timer = 1Eh

$A7:B867 6B          RTL
}


;;; $B868: Kraid lint function - charge lint ;;;
{
$A7:B868 A0 00 00    LDY #$0000             ; Y = 0 (palette 0)
$A7:B86B BD B2 0F    LDA $0FB2,x[$7E:10B2]  ;\
$A7:B86E 89 01 00    BIT #$0001             ;} If [Kraid enemy function timer] % 2 != 0:
$A7:B871 F0 03       BEQ $03    [$B876]     ;/
$A7:B873 A0 00 0E    LDY #$0E00             ; Y = E00h (palette 7)

$A7:B876 98          TYA                    ;\
$A7:B877 9D 96 0F    STA $0F96,x[$7E:1096]  ;} Enemy palette index = [Y]
$A7:B87A AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:B87D 18          CLC                    ;|
$A7:B87E 7D AC 0F    ADC $0FAC,x[$7E:10AC]  ;|
$A7:B881 38          SEC                    ;} Enemy X position += [Kraid lint X additional spawning velocity] - [Kraid lint spawning X speed]
$A7:B882 FD AA 0F    SBC $0FAA,x[$7E:10AA]  ;|
$A7:B885 9D 7A 0F    STA $0F7A,x[$7E:107A]  ;/
$A7:B888 DE B2 0F    DEC $0FB2,x[$7E:10B2]  ; Decrement Kraid enemy function timer
$A7:B88B D0 0D       BNE $0D    [$B89A]     ; If [Kraid enemy function timer] = 0:
$A7:B88D A9 9B B8    LDA #$B89B             ;\
$A7:B890 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Kraid enemy function = fire lint
$A7:B893 A9 1F 00    LDA #$001F             ;\
$A7:B896 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1Fh, sound library 3, max queued sounds allowed = 6 (Kraid fires lint)

$A7:B89A 6B          RTL
}


;;; $B89B: Kraid lint function - fire lint ;;;
{
$A7:B89B BD 7C 0F    LDA $0F7C,x[$7E:107C]  ;\
$A7:B89E 38          SEC                    ;|
$A7:B89F ED 26 A9    SBC $A926  [$A7:A926]  ;|
$A7:B8A2 9D 7C 0F    STA $0F7C,x[$7E:107C]  ;} Enemy X position -= 3.8000h
$A7:B8A5 BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;|
$A7:B8A8 ED 28 A9    SBC $A928  [$A7:A928]  ;|
$A7:B8AB 9D 7A 0F    STA $0F7A,x[$7E:107A]  ;/
$A7:B8AE C9 38 00    CMP #$0038             ;\
$A7:B8B1 10 0B       BPL $0B    [$B8BE]     ;} If [enemy X position] < 38h:
$A7:B8B3 48          PHA                    ;\
$A7:B8B4 BD 86 0F    LDA $0F86,x[$7E:1086]  ;|
$A7:B8B7 09 00 04    ORA #$0400             ;} Set enemy as intangible
$A7:B8BA 9D 86 0F    STA $0F86,x[$7E:1086]  ;|
$A7:B8BD 68          PLA                    ;/

$A7:B8BE C9 20 00    CMP #$0020             ;\
$A7:B8C1 10 1F       BPL $1F    [$B8E2]     ;} If [enemy X position] < 20h:
$A7:B8C3 BD 86 0F    LDA $0F86,x[$7E:1086]  ;\
$A7:B8C6 09 00 01    ORA #$0100             ;} Set enemy properties to invisible
$A7:B8C9 9D 86 0F    STA $0F86,x[$7E:1086]  ;/
$A7:B8CC A9 23 B9    LDA #$B923             ;\
$A7:B8CF 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Kraid enemy function = horizontally align enemy to Kraid
$A7:B8D2 A9 2C 01    LDA #$012C             ;\
$A7:B8D5 9D B2 0F    STA $0FB2,x[$7E:10B2]  ;} Kraid enemy function timer = 300
$A7:B8D8 A9 32 B8    LDA #$B832             ;\
$A7:B8DB 9F 00 78 7E STA $7E7800,x[$7E:7900];} Kraid enemy next function = produce lint
$A7:B8DF 9E AA 0F    STZ $0FAA,x[$7E:10AA]  ; Kraid lint spawning X speed = 0

$A7:B8E2 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A7:B8E6 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below: return
$A7:B8E9 F0 1B       BEQ $1B    [$B906]     ;/
$A7:B8EB AD 56 0B    LDA $0B56  [$7E:0B56]  ;\
$A7:B8EE 38          SEC                    ;|
$A7:B8EF ED 26 A9    SBC $A926  [$A7:A926]  ;} Extra Samus X subdisplacement -= 8000h
$A7:B8F2 8D 56 0B    STA $0B56  [$7E:0B56]  ;/
$A7:B8F5 AD 58 0B    LDA $0B58  [$7E:0B58]  ;\
$A7:B8F8 ED 28 A9    SBC $A928  [$A7:A928]  ;}
$A7:B8FB C9 F0 FF    CMP #$FFF0             ;|
$A7:B8FE 10 03       BPL $03    [$B903]     ;} Extra Samus X displacement = max(-10h, [extra Samus X displacement] - 3)
$A7:B900 A9 F0 FF    LDA #$FFF0             ;|
                                            ;|
$A7:B903 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A7:B906 6B          RTL
}


;;; $B907: Kraid fingernail function - wait until top lint X position >= 100h ;;;
{
$A7:B907 AD FA 0F    LDA $0FFA  [$7E:0FFA]  ;\
$A7:B90A C9 00 01    CMP #$0100             ;} If [top lint X position] >= 100h:
$A7:B90D 30 13       BMI $13    [$B922]     ;/
$A7:B90F BF 00 78 7E LDA $7E7800,x[$7E:7980];\
$A7:B913 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Enemy function = [enemy next function]
$A7:B916 BD 86 0F    LDA $0F86,x[$7E:1106]  ;\
$A7:B919 29 FF FE    AND #$FEFF             ;|
$A7:B91C 29 FF FB    AND #$FBFF             ;} Set enemy as visible and tangible
$A7:B91F 9D 86 0F    STA $0F86,x[$7E:1106]  ;/

$A7:B922 6B          RTL
}


;;; $B923: Kraid lint function - horizontally align enemy to Kraid ;;;
{
$A7:B923 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:B926 38          SEC                    ;|
$A7:B927 FD 82 0F    SBC $0F82,x[$7E:1002]  ;} Enemy X position = [Kraid X position] - [enemy X radius]
$A7:B92A 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
}


;;; $B92D: Kraid enemy function - handle Kraid enemy function timer ;;;
{
$A7:B92D BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$A7:B930 F0 0C       BEQ $0C    [$B93E]     ;} If [enemy function timer] = 0: return
$A7:B932 DE B2 0F    DEC $0FB2,x[$7E:0FB2]  ; Decrement enemy function timer
$A7:B935 D0 07       BNE $07    [$B93E]     ; If [enemy function timer] = 0:
$A7:B937 BF 00 78 7E LDA $7E7800,x[$7E:7980];\
$A7:B93B 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Enemy function = [next enemy function]

$A7:B93E 6B          RTL
}


;;; $B93F: Kraid foot function - start retreat ;;;
{
$A7:B93F AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:B942 BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;\
$A7:B945 F0 18       BEQ $18    [$B95F]     ;} If [enemy function timer] != 0:
$A7:B947 DE B2 0F    DEC $0FB2,x[$7E:10F2]  ; Decrement enemy function timer
$A7:B94A D0 13       BNE $13    [$B95F]     ; If [enemy function] = 0:
$A7:B94C BF 00 78 7E LDA $7E7800,x[$7E:7940];\
$A7:B950 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy function = [next enemy function]
$A7:B953 A9 87 88    LDA #$8887             ;\
$A7:B956 9D 92 0F    STA $0F92,x[$7E:10D2]  ;} Enemy instruction list pointer = $8887 (Kraid is big - walking backwards)
$A7:B959 A9 01 00    LDA #$0001             ;\
$A7:B95C 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1

$A7:B95F 6B          RTL
}


;;; $B960: Kraid foot function - first phase - thinking ;;;
{
$A7:B960 20 05 C0    JSR $C005  [$A7:C005]  ; Handle Kraid's first phase
$A7:B963 80 C8       BRA $C8    [$B92D]     ; Handle Kraid enemy function timer
}


;;; $B965: Kraid function - process Kraid instruction ;;;
{
$A7:B965 20 32 AF    JSR $AF32  [$A7:AF32]  ; Kraid instruction list handling
$A7:B968 80 C3       BRA $C3    [$B92D]     ; Handle Kraid enemy function timer
}


;;; $B96A: Kraid lint / Samus collision handling ;;;
{
$A7:B96A BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A7:B96D 89 00 04    BIT #$0400             ;|
$A7:B970 F0 01       BEQ $01    [$B973]     ;} If enemy is intangible: return
$A7:B972 60          RTS                    ;/

$A7:B973 AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$A7:B976 D0 7D       BNE $7D    [$B9F5]     ;} If [Samus invincibility timer] != 0: return
$A7:B978 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A7:B97B 18          CLC                    ;|
$A7:B97C 6D B7 92    ADC $92B7  [$A7:92B7]  ;|
$A7:B97F 38          SEC                    ;|
$A7:B980 E9 02 00    SBC #$0002             ;|
$A7:B983 85 12       STA $12    [$7E:0012]  ;|
$A7:B985 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$A7:B988 18          CLC                    ;|
$A7:B989 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;} If not (Samus left boundary) < (Kraid lint left boundary) - 2 <= (Samus right boundary) + 1: return
$A7:B98C C5 12       CMP $12    [$7E:0012]  ;|
$A7:B98E 30 65       BMI $65    [$B9F5]     ;|
$A7:B990 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$A7:B993 38          SEC                    ;|
$A7:B994 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$A7:B997 C5 12       CMP $12    [$7E:0012]  ;|
$A7:B999 10 5A       BPL $5A    [$B9F5]     ;/
$A7:B99B BD 7E 0F    LDA $0F7E,x[$7E:107E]  ;\
$A7:B99E 18          CLC                    ;|
$A7:B99F 6D B9 92    ADC $92B9  [$A7:92B9]  ;|
$A7:B9A2 18          CLC                    ;|
$A7:B9A3 69 02 00    ADC #$0002             ;|
$A7:B9A6 85 16       STA $16    [$7E:0016]  ;} If (Samus bottom boundary) <= (Kraid lint top boundary): return
$A7:B9A8 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A7:B9AB 18          CLC                    ;|
$A7:B9AC 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$A7:B9AF C5 16       CMP $16    [$7E:0016]  ;|
$A7:B9B1 30 42       BMI $42    [$B9F5]     ;/
$A7:B9B3 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A7:B9B6 18          CLC                    ;|
$A7:B9B7 6D BD 92    ADC $92BD  [$A7:92BD]  ;|
$A7:B9BA 38          SEC                    ;|
$A7:B9BB E9 02 00    SBC #$0002             ;|
$A7:B9BE 85 18       STA $18    [$7E:0018]  ;} If (Samus top boundary) >= (Kraid lint bottom boundary) - 2: return
$A7:B9C0 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A7:B9C3 38          SEC                    ;|
$A7:B9C4 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$A7:B9C7 C5 18       CMP $18    [$7E:0018]  ;|
$A7:B9C9 10 2A       BPL $2A    [$B9F5]     ;/
$A7:B9CB AD FE 0A    LDA $0AFE  [$7E:0AFE]  ;\
$A7:B9CE 18          CLC                    ;|
$A7:B9CF 69 10 00    ADC #$0010             ;|
$A7:B9D2 49 FF FF    EOR #$FFFF             ;|
$A7:B9D5 18          CLC                    ;} Extra Samus X displacement = min(10h, [extra Samus X displacement] - [Samus radius X] - 11h)
$A7:B9D6 6D 58 0B    ADC $0B58  [$7E:0B58]  ;|
$A7:B9D9 C9 10 00    CMP #$0010             ;|
$A7:B9DC 30 03       BMI $03    [$B9E1]     ;|
$A7:B9DE A9 10 00    LDA #$0010             ;|
                                            ;|
$A7:B9E1 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A7:B9E4 DA          PHX
$A7:B9E5 08          PHP
$A7:B9E6 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI
$A7:B9EA 28          PLP
$A7:B9EB FA          PLX
$A7:B9EC BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A7:B9EF 09 00 04    ORA #$0400             ;} Set enemy as intangible
$A7:B9F2 9D 86 0F    STA $0F86,x[$7E:1006]  ;/

$A7:B9F5 60          RTS
}


;;; $B9F6: Main AI - enemy $E3FF (Kraid's foot) ;;;
{
$A7:B9F6 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:B9F9 8D BA 10    STA $10BA  [$7E:10BA]  ;} Kraid foot X position = [Kraid X position]
$A7:B9FC AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A7:B9FF 18          CLC                    ;|
$A7:BA00 69 64 00    ADC #$0064             ;} Kraid foot Y position = [Kraid Y position] + 64h
$A7:BA03 8D BE 10    STA $10BE  [$7E:10BE]  ;/
$A7:BA06 A8          TAY                    ; Y = [Kraid foot Y position]
$A7:BA07 38          SEC                    ;\
$A7:BA08 E9 E0 00    SBC #$00E0             ;} X = [Kraid foot Y position] - E0h
$A7:BA0B AA          TAX                    ;/
$A7:BA0C AD C6 10    LDA $10C6  [$7E:10C6]  ;\
$A7:BA0F 29 FF FE    AND #$FEFF             ;} Set Kraid foot visible
$A7:BA12 CC 15 09    CPY $0915  [$7E:0915]  ;\
$A7:BA15 10 05       BPL $05    [$BA1C]     ;} If [Kraid foot Y position] < [layer 1 Y position]:
$A7:BA17 09 00 01    ORA #$0100             ; Set Kraid foot invisible
$A7:BA1A 80 08       BRA $08    [$BA24]

$A7:BA1C EC 15 09    CPX $0915  [$7E:0915]  ;\ Else ([Kraid foot Y position] >= [layer 1 Y position]):
$A7:BA1F 30 03       BMI $03    [$BA24]     ;} If [Kraid foot Y position] >= [layer 1 Y position] + E0h:
$A7:BA21 09 00 01    ORA #$0100             ; Set Kraid foot invisible

$A7:BA24 8D C6 10    STA $10C6  [$7E:10C6]
$A7:BA27 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [Kraid foot index]
$A7:BA2A 6C E8 10    JMP ($10E8)[$A7:BA2D]  ; Execute [Kraid foot function]
}


;;; $BA2D: RTL. Kraid foot function ;;;
{
$A7:BA2D 6B          RTL
}


;;; $BA2E: Kraid foot function - second phase - thinking ;;;
{
$A7:BA2E AF 40 79 7E LDA $7E7940[$7E:7940]  ;\
$A7:BA32 3A          DEC A                  ;} Decrement Kraid foot thinking timer
$A7:BA33 8F 40 79 7E STA $7E7940[$7E:7940]  ;/
$A7:BA37 D0 43       BNE $43    [$BA7C]     ; If [Kraid foot thinking timer] != 0: return
$A7:BA39 A2 00 00    LDX #$0000             ; X = 0 (movement table index)

; LOOP
$A7:BA3C AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:BA3F DD 7D BA    CMP $BA7D,x[$A7:BA7D]  ;} If [$BA7D + [X]] != [Kraid X position]:
$A7:BA42 F0 0C       BEQ $0C    [$BA50]     ;/
$A7:BA44 E8          INX                    ;\
$A7:BA45 E8          INX                    ;|
$A7:BA46 E8          INX                    ;} X += 4
$A7:BA47 E8          INX                    ;/
$A7:BA48 E0 18 00    CPX #$0018             ;\
$A7:BA4B 30 EF       BMI $EF    [$BA3C]     ;} If [X] < 18h: go to LOOP
$A7:BA4D A2 04 00    LDX #$0004             ; X = 4

$A7:BA50 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A7:BA53 29 1C 00    AND #$001C             ;|
$A7:BA56 C9 10 00    CMP #$0010             ;|
$A7:BA59 30 03       BMI $03    [$BA5E]     ;|
$A7:BA5B A9 10 00    LDA #$0010             ;} X = [$BA7D + [X] + 2] + min(4, [random number] / 4 % 8) * 4 (movement data pointer)
                                            ;|
$A7:BA5E 18          CLC                    ;|
$A7:BA5F 7D 7F BA    ADC $BA7F,x[$A7:BA83]  ;|
$A7:BA62 AA          TAX                    ;/
$A7:BA63 BD 02 00    LDA $0002,x[$A7:BABB]  ;\
$A7:BA66 A8          TAY                    ;} Y = [[X] + 2] (thinking timer)
$A7:BA67 BD 00 00    LDA $0000,x[$A7:BAB9]  ; A = [[X]] (target X position)
$A7:BA6A CD 7A 0F    CMP $0F7A  [$7E:0F7A]  ;\
$A7:BA6D 10 07       BPL $07    [$BA76]     ;} If (target X position) < [Kraid X position]:
$A7:BA6F BD 00 00    LDA $0000,x[$A7:BAF9]  ;\
$A7:BA72 20 29 BB    JSR $BB29  [$A7:BB29]  ;} Set Kraid walking forwards
$A7:BA75 6B          RTL                    ; Return

$A7:BA76 BD 00 00    LDA $0000,x[$A7:BAB9]  ;\ Else ((target X position) >= [Kraid X position]):
$A7:BA79 20 0D BB    JSR $BB0D  [$A7:BB0D]  ;} Set Kraid walking backwards

$A7:BA7C 6B          RTL

; Movement table
; If Kraid is at a listed X position, that entry is used, otherwise the default entry is used
; One of 5 corresponding movements is selected at random with chances 1/8, 1/8, 1/8, 1/8, 1/2

;                        ________ Kraid X position
;                       |     ___ Kraid movement data
;                       |    |
$A7:BA7D             dw 00F0,BA95,
                        0160,BAA9, ; Default
                        0180,BABD,
                        00D0,BAD1,
                        0140,BAE5,
                        0170,BAF9

;                        ________ Kraid target X position
;                       |     ___ Thinking timer
;                       |    |
$A7:BA95             dw 0180,0158, 0180,0158, 00D0,002C, 0170,002C, 0170,002C
$A7:BAA9             dw 00F0,0100, 0180,0158, 00D0,002C, 0140,002C, 0170,002C
$A7:BABD             dw 00F0,0100, 0160,0158, 00D0,002C, 0140,002C, 0170,002C
$A7:BAD1             dw 00F0,0100, 0160,0158, 0180,0158, 0140,002C, 0170,002C
$A7:BAE5             dw 00F0,0100, 0160,0158, 0180,0158, 00D0,002C, 0170,002C
$A7:BAF9             dw 00F0,0100, 0180,0158, 0170,0158, 00D0,002C, 0140,002C
}


;;; $BB0D: Set Kraid walking backwards ;;;
{
$A7:BB0D 8F 1E 78 7E STA $7E781E[$7E:781E]  ; Kraid target X position = [A]
$A7:BB11 98          TYA                    ;\
$A7:BB12 8F 40 79 7E STA $7E7940[$7E:7940]  ;} Kraid foot thinking timer = [Y]
$A7:BB16 A9 45 BB    LDA #$BB45             ;\
$A7:BB19 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = $BB45 (second phase - walking backwards)
$A7:BB1C A9 01 00    LDA #$0001             ;\
$A7:BB1F 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BB22 A9 87 88    LDA #$8887             ;\
$A7:BB25 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $8887 (Kraid is big - walking backwards)
$A7:BB28 60          RTS
}


;;; $BB29: Set Kraid walking forwards ;;;
{
$A7:BB29 8F 1E 78 7E STA $7E781E[$7E:781E]  ; Kraid target X position = [A]
$A7:BB2D 98          TYA                    ;\
$A7:BB2E 8F 40 79 7E STA $7E7940[$7E:7940]  ;} Kraid foot thinking timer = [Y]
$A7:BB32 A9 AE BB    LDA #$BBAE             ;\
$A7:BB35 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = $BBAE (second phase - walking forwards)
$A7:BB38 A9 01 00    LDA #$0001             ;\
$A7:BB3B 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BB3E A9 F3 86    LDA #$86F3             ;\
$A7:BB41 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86F3 (Kraid is big - walking forwards)
$A7:BB44 60          RTS
}


;;; $BB45: Kraid foot function - second phase - walking backwards ;;;
{
$A7:BB45 AF 1E 78 7E LDA $7E781E[$7E:781E]  ;\
$A7:BB49 CD 7A 0F    CMP $0F7A  [$7E:0F7A]  ;|
$A7:BB4C F0 05       BEQ $05    [$BB53]     ;} If [Kraid target X position] > [Kraid X position]: return
$A7:BB4E 10 1D       BPL $1D    [$BB6D]     ;/
$A7:BB50 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ; Kraid X position = [Kraid target X position]

$A7:BB53 AD D2 10    LDA $10D2  [$7E:10D2]  ;\
$A7:BB56 C9 39 89    CMP #$8939             ;} If [Kraid foot instruction list pointer] >= $8939 (last frame of walking backwards animation):
$A7:BB59 30 12       BMI $12    [$BB6D]     ;/
$A7:BB5B A9 2E BA    LDA #$BA2E             ;\
$A7:BB5E 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = thinking
$A7:BB61 A9 01 00    LDA #$0001             ;\
$A7:BB64 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BB67 A9 ED 86    LDA #$86ED             ;\
$A7:BB6A 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86ED (Kraid is big - neutral)

$A7:BB6D 6B          RTL
}


;;; $BB6E: Kraid foot function - second phase setup - walk to starting spot ;;;
{
$A7:BB6E AF 1E 78 7E LDA $7E781E[$7E:781E]  ;\
$A7:BB72 CD 7A 0F    CMP $0F7A  [$7E:0F7A]  ;|
$A7:BB75 F0 05       BEQ $05    [$BB7C]     ;} If [Kraid target X position] > [Kraid X position]: return
$A7:BB77 10 2A       BPL $2A    [$BBA3]     ;/
$A7:BB79 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ; Kraid X position = [Kraid target X position]

$A7:BB7C AD D2 10    LDA $10D2  [$7E:10D2]  ;\
$A7:BB7F C9 39 89    CMP #$8939             ;} If [Kraid foot instruction list pointer] >= $8939 (last frame of walking backwards animation):
$A7:BB82 30 1F       BMI $1F    [$BBA3]     ;/
$A7:BB84 A9 2D B9    LDA #$B92D             ;\
$A7:BB87 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = decrement enemy function timer
$A7:BB8A A9 B4 00    LDA #$00B4             ;\
$A7:BB8D 8D F2 10    STA $10F2  [$7E:10F2]  ;} Kraid foot function timer = 180
$A7:BB90 A9 A4 BB    LDA #$BBA4             ;\
$A7:BB93 8F 40 79 7E STA $7E7940[$7E:7940]  ;} Kraid foot next function = initialise second phase
$A7:BB97 A9 01 00    LDA #$0001             ;\
$A7:BB9A 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BB9D A9 ED 86    LDA #$86ED             ;\
$A7:BBA0 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86ED (Kraid is big - neutral)

$A7:BBA3 6B          RTL
}


;;; $BBA4: Kraid foot function - second phase setup - initialise second phase ;;;
{
$A7:BBA4 A9 60 01    LDA #$0160             ; A = 160h (Kraid target X position)
$A7:BBA7 A0 B4 00    LDY #$00B4             ; Y = 180 (Kraid foot thinking timer)
$A7:BBAA 20 0D BB    JSR $BB0D  [$A7:BB0D]  ; Set Kraid walking backwards
$A7:BBAD 6B          RTL
}


;;; $BBAE: Kraid foot function - second phase - walking forwards ;;;
{
$A7:BBAE AF 1E 78 7E LDA $7E781E[$7E:781E]  ;\
$A7:BBB2 CD 7A 0F    CMP $0F7A  [$7E:0F7A]  ;} If [Kraid target X position] < [Kraid X position]: go to BRANCH_FORWARDS
$A7:BBB5 30 1E       BMI $1E    [$BBD5]     ;/
$A7:BBB7 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ; Kraid X position = [Kraid target X position]
$A7:BBBA AD D2 10    LDA $10D2  [$7E:10D2]  ;\
$A7:BBBD C9 BB 87    CMP #$87BB             ;} If [Kraid foot instruction list pointer] = $87BB (last frame of walking forwards animation):
$A7:BBC0 D0 12       BNE $12    [$BBD4]     ;/
$A7:BBC2 A9 2E BA    LDA #$BA2E             ;\
$A7:BBC5 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = thinking
$A7:BBC8 A9 01 00    LDA #$0001             ;\
$A7:BBCB 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BBCE A9 ED 86    LDA #$86ED             ;\
$A7:BBD1 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86ED (Kraid is big - neutral)

$A7:BBD4 6B          RTL                    ; Return

; BRANCH_FORWARDS
$A7:BBD5 AD D2 10    LDA $10D2  [$7E:10D2]  ;\
$A7:BBD8 C9 BB 87    CMP #$87BB             ;} If [Kraid foot instruction list pointer] = $87BB (last frame of walking forwards animation):
$A7:BBDB D0 F7       BNE $F7    [$BBD4]     ;/
$A7:BBDD A9 F3 86    LDA #$86F3             ;\
$A7:BBE0 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86F3 (Kraid is big - walking forwards)
$A7:BBE3 A9 01 00    LDA #$0001             ;\
$A7:BBE6 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BBE9 6B          RTL
}


;;; $BBEA: Kraid function - Kraid main loop - attacking with mouth open ;;;
{
$A7:BBEA 20 32 AF    JSR $AF32  [$A7:AF32]  ; Kraid instruction list handling
$A7:BBED C9 FF FF    CMP #$FFFF             ;\
$A7:BBF0 F0 31       BEQ $31    [$BC23]     ;} If [A] = FFFFh: go to BRANCH_FINISHED_INSTRUCTIONS
$A7:BBF2 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:BBF5 38          SEC                    ;|
$A7:BBF6 E9 08 00    SBC #$0008             ;|
$A7:BBF9 AA          TAX                    ;} If [[Kraid instruction list pointer] - 6] = $A0C8 (mouth fully open):
$A7:BBFA BD 02 00    LDA $0002,x[$A7:96D4]  ;|
$A7:BBFD C9 C8 A0    CMP #$A0C8             ;|
$A7:BC00 D0 20       BNE $20    [$BC22]     ;/
$A7:BC02 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A7:BC05 29 0F 00    AND #$000F             ;} If [Kraid instruction timer] % 10h = 0:
$A7:BC08 D0 18       BNE $18    [$BC22]     ;/
$A7:BC0A A0 45 9C    LDY #$9C45             ;\
$A7:BC0D AD E5 05    LDA $05E5  [$7E:05E5]  ;|
$A7:BC10 29 0E 00    AND #$000E             ;|
$A7:BC13 AA          TAX                    ;} Spawn Kraid rock spit enemy projectile with random X velocity -4.C0h/-4.80h/-4.00h/-3.C0h
$A7:BC14 BD 65 BC    LDA $BC65,x[$A7:BC65]  ;|
$A7:BC17 22 27 80 86 JSL $868027[$86:8027]  ;/
$A7:BC1B A9 1E 00    LDA #$001E             ;\
$A7:BC1E 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1Eh, sound library 3, max queued sounds allowed = 6 (Kraid's earthquake)

$A7:BC22 6B          RTL                    ; Return

; BRANCH_FINISHED_INSTRUCTIONS
$A7:BC23 20 E9 AD    JSR $ADE9  [$A7:ADE9]  ; Set up Kraid main loop - thinking
$A7:BC26 A9 5A 00    LDA #$005A             ;\
$A7:BC29 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Kraid instruction timer = 90
$A7:BC2C AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A7:BC30 89 04 00    BIT #$0004             ;} If not set to reopen mouth: go to BRANCH_RETURN
$A7:BC33 F0 28       BEQ $28    [$BC5D]     ;/
$A7:BC35 38          SEC                    ;\
$A7:BC36 E9 00 01    SBC #$0100             ;} Decrement Kraid mouth reopen counter
$A7:BC39 8F 0A 78 7E STA $7E780A[$7E:780A]  ;/
$A7:BC3D 29 00 FF    AND #$FF00             ;\
$A7:BC40 F0 1B       BEQ $1B    [$BC5D]     ;} If [Kraid mouth reopen counter] = 0: go to BRANCH_RETURN
$A7:BC42 A9 2D B9    LDA #$B92D             ;\
$A7:BC45 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = handle Kraid enemy function timer
$A7:BC48 A9 40 00    LDA #$0040             ;\
$A7:BC4B 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Kraid function timer = 40h
$A7:BC4E A9 BF B6    LDA #$B6BF             ;\
$A7:BC51 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Kraid next function = $B6BF (Kraid shot)
$A7:BC55 A9 02 00    LDA #$0002             ;\
$A7:BC58 8F 02 78 7E STA $7E7802[$7E:7802]  ;} $7E:7802 = 2 (never read)
$A7:BC5C 6B          RTL                    ; Return

; BRANCH_RETURN
$A7:BC5D A9 00 00    LDA #$0000             ;\
$A7:BC60 8F 0A 78 7E STA $7E780A[$7E:780A]  ;} Kraid mouth reopen flags = 0
$A7:BC64 6B          RTL

; Rock spit X velocities. Unit 1/100h px/frame
$A7:BC65             dw FC00, FC40, FB40, FB80, FB40, FC00, FB80, FC40
}


;;; $BC75: Unused. Lunge forward if Samus is not invincible ;;;
{
; Possibly an old Samus / Kraid foot collision reaction
$A7:BC75 AD D2 10    LDA $10D2  [$7E:10D2]  ;\
$A7:BC78 C9 85 88    CMP #$8885             ;} If [Kraid foot instruction list pointer] < $8885 (last frame of lunge forward): return
$A7:BC7B 30 2A       BMI $2A    [$BCA7]     ;/
$A7:BC7D AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$A7:BC80 F0 26       BEQ $26    [$BCA8]     ;} If [Samus invincibility timer] = 0: go to BRANCH_LUNGE
$A7:BC82 A9 45 BB    LDA #$BB45             ;\
$A7:BC85 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = $BB45 (second phase - walking backwards)
$A7:BC88 AD 11 09    LDA $0911  [$7E:0911]  ;\
$A7:BC8B 18          CLC                    ;|
$A7:BC8C 69 20 01    ADC #$0120             ;|
$A7:BC8F C9 20 01    CMP #$0120             ;|
$A7:BC92 30 03       BMI $03    [$BC97]     ;} Kraid target X position = min(0, [layer 1 X position]) + 120h
$A7:BC94 A9 20 01    LDA #$0120             ;|
                                            ;|
$A7:BC97 8F 1E 78 7E STA $7E781E[$7E:781E]  ;/
$A7:BC9B A9 01 00    LDA #$0001             ;\
$A7:BC9E 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BCA1 A9 87 88    LDA #$8887             ;\
$A7:BCA4 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $8887 (Kraid is big - walking backwards)

$A7:BCA7 6B          RTL                    ; Return

; BRANCH_LUNGE
$A7:BCA8 A9 01 00    LDA #$0001             ;\
$A7:BCAB 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BCAE A9 BD 87    LDA #$87BD             ;\
$A7:BCB1 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $87BD (lunge forward)
$A7:BCB4 6B          RTL
}


;;; $BCB5: Unused. Fire lint after [A] frames ;;;
{
$A7:BCB5 9D B2 0F    STA $0FB2,x            ; Kraid enemy function timer = [A]
$A7:BCB8 A9 23 B9    LDA #$B923             ;\
$A7:BCBB 9D A8 0F    STA $0FA8,x            ;} Kraid enemy function = horizontally align enemy to Kraid
$A7:BCBE A9 9B B8    LDA #$B89B             ;\
$A7:BCC1 9F 00 78 7E STA $7E7800,x          ;} Kraid enemy next function = fire lint
$A7:BCC5 BD 86 0F    LDA $0F86,x            ;\
$A7:BCC8 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A7:BCCB 9D 86 0F    STA $0F86,x            ;/
$A7:BCCE 60          RTS
}


;;; $BCCF: Enemy touch - enemy $E43F (Kraid good fingernail) ;;;
{
$A7:BCCF 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI
$A7:BCD3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:BCD6 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death (with garbage in A)
$A7:BCDA AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:BCDD 6B          RTL
}


;;; $BCDE: Enemy touch - enemy $E47F (Kraid bad fingernail) ;;;
{
$A7:BCDE 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI
$A7:BCE2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:BCE5 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death (with garbage in A)
$A7:BCE9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:BCEC 6B          RTL
}


;;; $BCED: RTL ;;;
{
$A7:BCED 6B          RTL
}


;;; $BCEE: RTL ;;;
{
$A7:BCEE 6B          RTL
}


;;; $BCEF: Initialisation AI - enemy $E43F (Kraid good fingernail) ;;;
{
$A7:BCEF AE 54 0E    LDX $0E54  [$7E:0E54]
}


;;; $BCF2: Kraid's fingernails initialisation AI ;;;
{
$A7:BCF2 AD 96 0F    LDA $0F96  [$7E:0F96]  ;\
$A7:BCF5 9D 96 0F    STA $0F96,x[$7E:1116]  ;} Enemy palette = [Kraid palette]
$A7:BCF8 A9 28 00    LDA #$0028             ;\
$A7:BCFB 9D AA 0F    STA $0FAA,x[$7E:112A]  ;} Enemy X subvelocity = 28h
$A7:BCFE BD 86 0F    LDA $0F86,x[$7E:1106]  ;\
$A7:BD01 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A7:BD04 9D 86 0F    STA $0F86,x[$7E:1106]  ;/
$A7:BD07 A9 FF 7F    LDA #$7FFF             ;\
$A7:BD0A 9D 94 0F    STA $0F94,x[$7E:1114]  ;} Enemy instruction timer = 7FFFh
$A7:BD0D A9 0A 8B    LDA #$8B0A             ;\
$A7:BD10 9D 92 0F    STA $0F92,x[$7E:1112]  ;} Enemy instruction list pointer = $8B0A (fingernail)
$A7:BD13 AD 0C 8B    LDA $8B0C  [$A7:8B0C]  ;\
$A7:BD16 9D 8E 0F    STA $0F8E,x[$7E:110E]  ;} Enemy spritemap pointer = $A617 (first fingernail frame)
$A7:BD19 A9 60 BD    LDA #$BD60             ;\
$A7:BD1C 9F 00 78 7E STA $7E7800,x[$7E:7980];} Enemy next function = initialise fingernail
$A7:BD20 A9 2D B9    LDA #$B92D             ;\
$A7:BD23 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Enemy function = decrement enemy function timer
$A7:BD26 A9 40 00    LDA #$0040             ;\
$A7:BD29 9D B2 0F    STA $0FB2,x[$7E:1132]  ;} Enemy function timer = 40h
$A7:BD2C 6B          RTL
}


;;; $BD2D: Initialisation AI - enemy $E47F (Kraid bad fingernail) ;;;
{
$A7:BD2D AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:BD30 80 C0       BRA $C0    [$BCF2]     ; Go to Kraid's fingernails initialisation AI
}


;;; $BD32: Main AI - enemy $E43F (Kraid good fingernail) ;;;
{
$A7:BD32 C2 30       REP #$30
$A7:BD34 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:BD37 C9 01 00    CMP #$0001             ;} If [Kraid health] >= 1:
$A7:BD3A 30 03       BMI $03    [$BD3F]     ;/
$A7:BD3C 6C 28 11    JMP ($1128)[$A7:B92D]  ; Execute [Kraid good fingernail instruction]

$A7:BD3F AD 06 11    LDA $1106  [$A0:1106]  ;\
$A7:BD42 09 00 03    ORA #$0300             ;} Set Kraid good fingernail as invisible and mark for deletion
$A7:BD45 8D 06 11    STA $1106  [$A0:1106]  ;/
$A7:BD48 6B          RTL
}


;;; $BD49: Main AI - enemy $E47F (Kraid bad fingernail) ;;;
{
$A7:BD49 C2 30       REP #$30
$A7:BD4B AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:BD4E C9 01 00    CMP #$0001             ;} If [Kraid health] >= 1:
$A7:BD51 30 03       BMI $03    [$BD56]     ;/
$A7:BD53 6C 68 11    JMP ($1168)[$A7:B92D]  ; Execute [Kraid bad fingernail instruction]

$A7:BD56 AD 46 11    LDA $1146  [$A0:1146]  ;\
$A7:BD59 09 00 03    ORA #$0300             ;} Set Kraid bad fingernail as invisible and mark for deletion
$A7:BD5C 8D 46 11    STA $1146  [$A0:1146]  ;/
$A7:BD5F 6B          RTL
}


;;; $BD60: Kraid fingernail function - initialise fingernail ;;;
{
$A7:BD60 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A7:BD63 29 06 00    AND #$0006             ;} Y = [random number] & 6
$A7:BD66 A8          TAY                    ;/
$A7:BD67 AD 30 11    LDA $1130  [$7E:1130]  ;\
$A7:BD6A AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A7:BD6D E0 80 01    CPX #$0180             ;|
$A7:BD70 D0 03       BNE $03    [$BD75]     ;|
$A7:BD72 AD 70 11    LDA $1170  [$7E:1170]  ;} If [Kraid fingernail Y velocity] < 0:
                                            ;|
$A7:BD75 C9 00 00    CMP #$0000             ;|
$A7:BD78 10 05       BPL $05    [$BD7F]     ;/
$A7:BD7A B9 3E BE    LDA $BE3E,y[$A7:BE42]  ; A = [$BE3E + [Y]]
$A7:BD7D 80 03       BRA $03    [$BD82]
                                            ; Else ([Kraid fingernail Y velocity] >= 0):
$A7:BD7F B9 46 BE    LDA $BE46,y[$A7:BE4A]  ; A = [$BE46 + [Y]]

$A7:BD82 A8          TAY                    ; Y = [A]
$A7:BD83 B9 00 00    LDA $0000,y[$A7:BE76]  ;\
$A7:BD86 9D AA 0F    STA $0FAA,x[$7E:112A]  ;} Kraid fingernail X subvelocity = [[Y]]
$A7:BD89 B9 02 00    LDA $0002,y[$A7:BE78]  ;\
$A7:BD8C 9D AC 0F    STA $0FAC,x[$7E:112C]  ;} Kraid fingernail X velocity = [[Y] + 2]
$A7:BD8F B9 04 00    LDA $0004,y[$A7:BE7A]  ;\
$A7:BD92 9D AE 0F    STA $0FAE,x[$7E:112E]  ;} Kraid fingernail Y subvelocity = [[Y] + 4]
$A7:BD95 B9 06 00    LDA $0006,y[$A7:BE7C]  ;\
$A7:BD98 9D B0 0F    STA $0FB0,x[$7E:1130]  ;} Kraid fingernail Y velocity = [[Y] + 6]
$A7:BD9B A9 01 00    LDA #$0001             ;\
$A7:BD9E 9D B4 0F    STA $0FB4,x[$7E:1134]  ;} Enemy $0FB4 = 1 (no effect)
$A7:BDA1 BD 86 0F    LDA $0F86,x[$7E:1106]  ;\
$A7:BDA4 29 FF FE    AND #$FEFF             ;|
$A7:BDA7 29 FF FB    AND #$FBFF             ;} Set enemy as tangible and visible
$A7:BDAA 9D 86 0F    STA $0F86,x[$7E:1106]  ;/
$A7:BDAD A9 01 00    LDA #$0001             ;\
$A7:BDB0 9D 94 0F    STA $0F94,x[$7E:1114]  ;} Enemy instruction timer = 1
$A7:BDB3 A9 0A 8B    LDA #$8B0A             ;\
$A7:BDB6 9D 92 0F    STA $0F92,x[$7E:1112]  ;} Enemy instruction list pointer = $8B0A (fingernail)
$A7:BDB9 A9 8E BE    LDA #$BE8E             ;\
$A7:BDBC 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Kraid enemy function = (fire fingernail)
$A7:BDBF AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A7:BDC2 89 01 00    BIT #$0001             ;} If [random number] % 2 != 0: go to BRANCH_HORIZONTAL
$A7:BDC5 D0 23       BNE $23    [$BDEA]     ;/

; BRANCH_DIAGONAL
$A7:BDC7 A9 00 00    LDA #$0000             ;\
$A7:BDCA 9F 0E 78 7E STA $7E780E,x[$7E:798E];} Kraid fingernail orientation = diagonal
$A7:BDCE AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:BDD1 38          SEC                    ;|
$A7:BDD2 ED 82 0F    SBC $0F82  [$7E:0F82]  ;|
$A7:BDD5 38          SEC                    ;} Enemy X position = Kraid left boundary - [enemy X radius] rounded down to block left boundary
$A7:BDD6 FD 82 0F    SBC $0F82,x[$7E:1102]  ;|
$A7:BDD9 29 F0 FF    AND #$FFF0             ;|
$A7:BDDC 9D 7A 0F    STA $0F7A,x[$7E:10FA]  ;/
$A7:BDDF AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A7:BDE2 18          CLC                    ;|
$A7:BDE3 69 80 00    ADC #$0080             ;} Enemy Y position = [Kraid arm Y position] + 80h
$A7:BDE6 9D 7E 0F    STA $0F7E,x[$7E:10FE]  ;/
$A7:BDE9 6B          RTL                    ; Return

; BRANCH_HORIZONTAL
$A7:BDEA AF 8E 79 7E LDA $7E798E[$7E:798E]  ; A = [Kraid good fingernail orientation]
$A7:BDEE E0 C0 01    CPX #$01C0             ;\
$A7:BDF1 F0 04       BEQ $04    [$BDF7]     ;} If not the bad fingernail:
$A7:BDF3 AF CE 79 7E LDA $7E79CE[$7E:79CE]  ; A = [Kraid bad fingernail orientation]

$A7:BDF7 C9 01 00    CMP #$0001             ;\
$A7:BDFA F0 CB       BEQ $CB    [$BDC7]     ;} If [A] = horizontal: go to BRANCH_DIAGONAL
$A7:BDFC A9 01 00    LDA #$0001             ;\
$A7:BDFF 9F 0E 78 7E STA $7E780E,x[$7E:798E];} Kraid fingernail orientation = horizontal
$A7:BE03 A9 32 00    LDA #$0032             ;\
$A7:BE06 9D 7A 0F    STA $0F7A,x[$7E:10FA]  ;} Enemy X position = 32h
$A7:BE09 A9 F0 00    LDA #$00F0             ;\
$A7:BE0C 9D 7E 0F    STA $0F7E,x[$7E:10FE]  ;} Enemy Y position = F0h
$A7:BE0F A9 00 00    LDA #$0000             ;\
$A7:BE12 9D AA 0F    STA $0FAA,x[$7E:112A]  ;|
$A7:BE15 A9 01 00    LDA #$0001             ;} Kraid fingernail X velocity = 1.0
$A7:BE18 9D AC 0F    STA $0FAC,x[$7E:112C]  ;/
$A7:BE1B A9 00 00    LDA #$0000             ;\
$A7:BE1E 9D AE 0F    STA $0FAE,x[$7E:112E]  ;|
$A7:BE21 A9 00 00    LDA #$0000             ;} Kraid fingernail Y velocity = 0.0
$A7:BE24 9D B0 0F    STA $0FB0,x[$7E:1130]  ;/
$A7:BE27 A9 07 B9    LDA #$B907             ;\
$A7:BE2A 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Kraid enemy function = wait until top lint X position >= 100h
$A7:BE2D A9 8E BE    LDA #$BE8E             ;\
$A7:BE30 9F 00 78 7E STA $7E7800,x[$7E:7980];} Kraid enemy next function = fire fingernail
$A7:BE34 BD 86 0F    LDA $0F86,x[$7E:1106]  ;\
$A7:BE37 09 00 05    ORA #$0500             ;} Set enemy as intangible and invisible
$A7:BE3A 9D 86 0F    STA $0F86,x[$7E:1106]  ;/
$A7:BE3D 6B          RTL

; Table of Kraid fingernail upwards velocities
$A7:BE3E             dw BE4E, BE5E, BE6E, BE7E

; Table of Kraid fingernail downwards velocities
$A7:BE46             dw BE56, BE66, BE76, BE86

;                        _____________________ X subvelocity
;                       |      _______________ X velocity
;                       |     |      _________ Y subvelocity
;                       |     |     |      ___ Y velocity
;                       |     |     |     |
$A7:BE4E             dw 0000, FFFF, 0000, 0001
$A7:BE56             dw 0000, FFFF, 0000, FFFF
$A7:BE5E             dw 0000, FFFF, 0000, 0001
$A7:BE66             dw 0000, FFFF, 0000, FFFF
$A7:BE6E             dw 0000, FFFF, 0000, 0001
$A7:BE76             dw 0000, FFFF, 0000, FFFF
$A7:BE7E             dw 0000, FFFF, 0000, 0001
$A7:BE86             dw 0000, FFFF, 0000, FFFF
}


;;; $BE8E: Kraid fingernail function - fire fingernail ;;;
{
; Note the three fixed point negation operations at $BE9E, $BEE2 and $BF06 are off by 1.0 when the low word is zero
$A7:BE8E BD AA 0F    LDA $0FAA,x[$7E:112A]  ;\
$A7:BE91 85 12       STA $12    [$7E:0012]  ;|
$A7:BE93 BD AC 0F    LDA $0FAC,x[$7E:112C]  ;} Move enemy right by [enemy X velocity]
$A7:BE96 85 14       STA $14    [$7E:0014]  ;|
$A7:BE98 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A7:BE9C 90 16       BCC $16    [$BEB4]     ; If collided with wall:
$A7:BE9E BD AA 0F    LDA $0FAA,x[$7E:112A]  ;\
$A7:BEA1 49 FF FF    EOR #$FFFF             ;|
$A7:BEA4 1A          INC A                  ;} Negate enemy subspeed
$A7:BEA5 9D AA 0F    STA $0FAA,x[$7E:112A]  ;/
$A7:BEA8 BD AC 0F    LDA $0FAC,x[$7E:112C]  ;\
$A7:BEAB 49 FF FF    EOR #$FFFF             ;|
$A7:BEAE 1A          INC A                  ;} Negate enemy speed
$A7:BEAF 9D AC 0F    STA $0FAC,x[$7E:112C]  ;/
$A7:BEB2 80 42       BRA $42    [$BEF6]     ; Go to BRANCH_BOUNCED

$A7:BEB4 A0 00 00    LDY #$0000             ; Y = 0

; LOOP
$A7:BEB7 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A7:BEBA 18          CLC                    ;|
$A7:BEBB 79 1F BF    ADC $BF1F,y[$A7:BF1F]  ;} If [enemy Y position] <= [Kraid Y position] + [$BF1D + [Y] + 2]:
$A7:BEBE DD 7E 0F    CMP $0F7E,x[$7E:10FE]  ;|
$A7:BEC1 30 06       BMI $06    [$BEC9]     ;/
$A7:BEC3 C8          INY                    ;\
$A7:BEC4 C8          INY                    ;|
$A7:BEC5 C8          INY                    ;} Y += 4
$A7:BEC6 C8          INY                    ;/
$A7:BEC7 80 EE       BRA $EE    [$BEB7]     ; Go to LOOP

$A7:BEC9 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:BECC 18          CLC                    ;|
$A7:BECD 79 1D BF    ADC $BF1D,y[$A7:BF1D]  ;|
$A7:BED0 85 12       STA $12    [$7E:0012]  ;|
$A7:BED2 BD 7A 0F    LDA $0F7A,x[$7E:10FA]  ;} If (enemy right boundary) + 1 >= [Kraid X position] + [$BF1D + [Y]]:
$A7:BED5 18          CLC                    ;|
$A7:BED6 7D 82 0F    ADC $0F82,x[$7E:1102]  ;|
$A7:BED9 C5 12       CMP $12    [$7E:0012]  ;|
$A7:BEDB 30 19       BMI $19    [$BEF6]     ;/
$A7:BEDD BD AC 0F    LDA $0FAC,x[$7E:112C]  ;\
$A7:BEE0 30 14       BMI $14    [$BEF6]     ;} And moving right:
$A7:BEE2 BD AA 0F    LDA $0FAA,x[$7E:116A]  ;\
$A7:BEE5 49 FF FF    EOR #$FFFF             ;|
$A7:BEE8 1A          INC A                  ;} Negate enemy X subspeed
$A7:BEE9 9D AA 0F    STA $0FAA,x[$7E:116A]  ;/
$A7:BEEC BD AC 0F    LDA $0FAC,x[$7E:116C]  ;\
$A7:BEEF 49 FF FF    EOR #$FFFF             ;|
$A7:BEF2 1A          INC A                  ;} Negate enemy X speed
$A7:BEF3 9D AC 0F    STA $0FAC,x[$7E:116C]  ;/

; BRANCH_BOUNCED
$A7:BEF6 BD AE 0F    LDA $0FAE,x[$7E:112E]  ;\
$A7:BEF9 85 12       STA $12    [$7E:0012]  ;|
$A7:BEFB BD B0 0F    LDA $0FB0,x[$7E:1130]  ;} Move enemy down by [enemy Y velocity]
$A7:BEFE 85 14       STA $14    [$7E:0014]  ;|
$A7:BF00 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A7:BF04 90 16       BCC $16    [$BF1C]     ; If returned carry set:
$A7:BF06 BD AE 0F    LDA $0FAE,x[$7E:116E]  ;\
$A7:BF09 49 FF FF    EOR #$FFFF             ;|
$A7:BF0C 1A          INC A                  ;} Negate enemy Y subspeed
$A7:BF0D 9D AE 0F    STA $0FAE,x[$7E:116E]  ;/
$A7:BF10 BD B0 0F    LDA $0FB0,x[$7E:1170]  ;\
$A7:BF13 49 FF FF    EOR #$FFFF             ;|
$A7:BF16 69 00 00    ADC #$0000             ;} Negate enemy Y speed
$A7:BF19 9D B0 0F    STA $0FB0,x[$7E:1170]  ;/

$A7:BF1C 6B          RTL

;                        ________ Left boundary offset
;                       |     ___ Top boundary offset
;                       |    |
$A7:BF1D             dw FFC0,0010,
                        FFD8,FFD8,
                        FFF0,FFA0,
                        0008,FF80
}


;;; $BF2D: Kraid foot function - first phase - prepare to lunge forward ;;;
{
$A7:BF2D 20 05 C0    JSR $C005  [$A7:C005]  ; Handle Kraid's first phase
$A7:BF30 AD D2 0F    LDA $0FD2  [$7E:0FD2]  ;\
$A7:BF33 C9 37 8A    CMP #$8A37             ;} If [Kraid arm instruction list pointer] >= $8A37 (penultimate animation frame of normal animation):
$A7:BF36 30 24       BMI $24    [$BF5C]     ;/
$A7:BF38 A9 F0 8A    LDA #$8AF0             ;\
$A7:BF3B 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Kraid arm instruction list pointer = $8AF0 (dying / preparing to lunge forward)
$A7:BF3E A9 01 00    LDA #$0001             ;\
$A7:BF41 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Kraid arm instruction timer = 1
$A7:BF44 A9 01 00    LDA #$0001             ;\
$A7:BF47 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BF4A A9 BD 87    LDA #$87BD             ;\
$A7:BF4D 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $87BD (lunge forward)
$A7:BF50 A9 5D BF    LDA #$BF5D             ;\
$A7:BF53 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = $BF5D (lunge forward)
$A7:BF56 A9 00 00    LDA #$0000             ;\
$A7:BF59 8D F2 10    STA $10F2  [$7E:10F2]  ;} Kraid foot function timer = 0

$A7:BF5C 6B          RTL
}


;;; $BF5D: Kraid foot function - first phase - lunge forward ;;;
{
$A7:BF5D 20 05 C0    JSR $C005  [$A7:C005]  ; Handle Kraid's first phase
$A7:BF60 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:BF63 C9 5C 00    CMP #$005C             ;|
$A7:BF66 10 06       BPL $06    [$BF6E]     ;} Kraid X position = max(5Ch, [Kraid X position])
$A7:BF68 A9 5C 00    LDA #$005C             ;|
$A7:BF6B 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/

$A7:BF6E AD D2 10    LDA $10D2  [$7E:10D2]  ;\
$A7:BF71 C9 85 88    CMP #$8885             ;} If [Kraid foot instruction list pointer] != $8885 (last frame of lunge forward): return
$A7:BF74 D0 34       BNE $34    [$BFAA]     ;/
$A7:BF76 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:BF79 C9 5C 00    CMP #$005C             ;} If [Kraid X position] != 5Ch:
$A7:BF7C F0 0D       BEQ $0D    [$BF8B]     ;/
$A7:BF7E A9 01 00    LDA #$0001             ;\
$A7:BF81 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BF84 A9 BD 87    LDA #$87BD             ;\
$A7:BF87 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $87BD (lunge forward)
$A7:BF8A 6B          RTL                    ; Return

$A7:BF8B A9 AB BF    LDA #$BFAB             ;\
$A7:BF8E 8F 40 79 7E STA $7E7940[$7E:7940]  ;} Kraid foot next function = retreat from lunge
$A7:BF92 A9 3F B9    LDA #$B93F             ;\
$A7:BF95 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = start retreat
$A7:BF98 A9 01 00    LDA #$0001             ;\
$A7:BF9B 8D F2 10    STA $10F2  [$7E:10F2]  ;} Kraid foot function delay = 1
$A7:BF9E A9 01 00    LDA #$0001             ;\
$A7:BFA1 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BFA4 A9 ED 86    LDA #$86ED             ;\
$A7:BFA7 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86ED (Kraid is big - neutral)

$A7:BFAA 6B          RTL
}


;;; $BFAB: Kraid foot function - first phase - retreat from lunge ;;;
{
$A7:BFAB 20 05 C0    JSR $C005  [$A7:C005]  ; Handle Kraid's first phase
$A7:BFAE AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:BFB1 C9 B0 00    CMP #$00B0             ;|
$A7:BFB4 30 06       BMI $06    [$BFBC]     ;} Kraid X position = min(B0h, [Kraid X position])
$A7:BFB6 A9 B0 00    LDA #$00B0             ;|
$A7:BFB9 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/

$A7:BFBC AD D2 10    LDA $10D2  [$7E:10D2]  ;\
$A7:BFBF C9 39 89    CMP #$8939             ;} If [Kraid foot instruction list pointer] < $8939 (last frame of walking backwards animation): return
$A7:BFC2 30 40       BMI $40    [$C004]     ;/
$A7:BFC4 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:BFC7 C9 B0 00    CMP #$00B0             ;} If [Kraid X position] != B0h:
$A7:BFCA F0 0D       BEQ $0D    [$BFD9]     ;/
$A7:BFCC A9 87 88    LDA #$8887             ;\
$A7:BFCF 9D 92 0F    STA $0F92,x[$7E:10D2]  ;} Enemy instruction list pointer = $8887 (Kraid is big - walking backwards)
$A7:BFD2 A9 01 00    LDA #$0001             ;\
$A7:BFD5 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1
$A7:BFD8 6B          RTL                    ; Return

$A7:BFD9 A9 F3 89    LDA #$89F3             ;\
$A7:BFDC 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Kraid arm instruction list pointer = $89F3 (normal)
$A7:BFDF A9 01 00    LDA #$0001             ;\
$A7:BFE2 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Kraid arm instruction timer = 1
$A7:BFE5 A9 01 00    LDA #$0001             ;\
$A7:BFE8 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:BFEB A9 ED 86    LDA #$86ED             ;\
$A7:BFEE 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86ED (Kraid is big - neutral)
$A7:BFF1 A9 60 B9    LDA #$B960             ;\
$A7:BFF4 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = thinking
$A7:BFF7 A9 2C 01    LDA #$012C             ;\
$A7:BFFA 8D F2 10    STA $10F2  [$7E:10F2]  ;} Kraid foot function timer = 300
$A7:BFFD A9 2D BF    LDA #$BF2D             ;\
$A7:C000 8F 40 79 7E STA $7E7940[$7E:7940]  ;} Kraid foot next function = $BF2D (prepare to lunge forward)

$A7:C004 6B          RTL
}


;;; $C005: Handle Kraid's first phase ;;;
{
; This routine contains the cause of the Kraid quick kill.

; In order to close Kraid's mouth once he's sustained enough damage,
; this routine is setting Kraid's instruction list pointer to one of his roar instructions where his mouth is closing
; ($96F4/$96FC/$9704/$970C) depending on what tilemap pointer he's set to have.

; When Kraid is shot and his instruction list pointer is $96EA/$96EC (the magic animation frame),
; his instruction list pointer is set to $96F4 accordingly,
; the instruction timer being set to 40h (as specified by the previous instruction),
; which is the cause of the animation freeze that allows Samus to quickly kill Kraid.

; The 40h frame delay makes sense in the usual context of the roar instruction list,
; as $96EC is the instruction list pointer used for keeping Kraid's mouth open during the roar sound effect.

; Easiest way to fix this is to set the Kraid instruction timer to Ah unconditionally (instead of hoping it's Ah from instruction list lookup).
; I.e. $C04C = LDA #$000A
$A7:C005 AD 8C 0F    LDA $0F8C  [$7E:0F8C]  ;\
$A7:C008 CF 18 78 7E CMP $7E7818[$7E:7818]  ;} If [Kraid health] >= [Kraid max health * 7/8]:
$A7:C00C 30 01       BMI $01    [$C00F]     ;/
$A7:C00E 60          RTS                    ; Return

$A7:C00F A9 65 B9    LDA #$B965             ;\
$A7:C012 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = process Kraid instruction
$A7:C015 A9 B4 00    LDA #$00B4             ;\
$A7:C018 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Kraid function timer = 180
$A7:C01B A9 A1 C0    LDA #$C0A1             ;\
$A7:C01E 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Kraid next function = Kraid gets big
$A7:C022 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:C025 AA          TAX                    ;} A = [[Kraid instruction list pointer] + 2]
$A7:C026 BD 02 00    LDA $0002,x[$A7:96F6]  ;/
$A7:C029 A0 32 00    LDY #$0032             ; Y = 32h
$A7:C02C C9 C8 97    CMP #$97C8             ;\
$A7:C02F F0 13       BEQ $13    [$C044]     ;} If [A] != $97C8:
$A7:C031 A0 2A 00    LDY #$002A             ; Y = 2Ah
$A7:C034 C9 C8 9A    CMP #$9AC8             ;\
$A7:C037 F0 0B       BEQ $0B    [$C044]     ;} If [A] != $9AC8:
$A7:C039 A0 22 00    LDY #$0022             ; Y = 22h
$A7:C03C C9 C8 9D    CMP #$9DC8             ;\
$A7:C03F F0 03       BEQ $03    [$C044]     ;} If [A] != $9DC8:
$A7:C041 A0 1A 00    LDY #$001A             ; Y = 1Ah

$A7:C044 98          TYA                    ;\
$A7:C045 18          CLC                    ;|
$A7:C046 69 DA 96    ADC #$96DA             ;} Kraid instruction list pointer = $96D2 + 8 (roar) + [Y]
$A7:C049 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A7:C04C B9 D2 96    LDA $96D2,y[$A7:96F4]  ;\
$A7:C04F 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Kraid instruction timer = [$96D2 + [Y]]
$A7:C052 A9 04 00    LDA #$0004             ;\
$A7:C055 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 2 pixel displacement, vertical
$A7:C058 A9 54 01    LDA #$0154             ;\
$A7:C05B 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 340
$A7:C05E A9 E7 86    LDA #$86E7             ;\
$A7:C061 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86E7 (initial)
$A7:C064 A9 01 00    LDA #$0001             ;\
$A7:C067 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:C06A A9 2D BA    LDA #$BA2D             ;\
$A7:C06D 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = RTS
$A7:C070 A9 F3 89    LDA #$89F3             ;\
$A7:C073 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Kraid arm instruction list pointer = $89F3 (normal)
$A7:C076 A9 01 00    LDA #$0001             ;\
$A7:C079 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Kraid arm instruction timer = 1
$A7:C07C AD 06 10    LDA $1006  [$7E:1006]  ;\
$A7:C07F 09 00 01    ORA #$0100             ;|
$A7:C082 8D 06 10    STA $1006  [$7E:1006]  ;|
$A7:C085 AD 46 10    LDA $1046  [$7E:1046]  ;|
$A7:C088 09 00 01    ORA #$0100             ;} Set Kraid lint as invisible
$A7:C08B 8D 46 10    STA $1046  [$7E:1046]  ;|
$A7:C08E AD 86 10    LDA $1086  [$7E:1086]  ;|
$A7:C091 09 00 01    ORA #$0100             ;|
$A7:C094 8D 86 10    STA $1086  [$7E:1086]  ;/
$A7:C097 AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A7:C09A 09 00 04    ORA #$0400             ;} Set Kraid arm as intangible
$A7:C09D 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A7:C0A0 60          RTS
}


;;; $C0A1: Kraid function - Kraid gets big - release camera ;;;
{
$A7:C0A1 A9 4D AC    LDA #$AC4D             ;\
$A7:C0A4 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = break ceiling into platforms
$A7:C0A7 A9 02 02    LDA #$0202             ;\
$A7:C0AA 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;|
$A7:C0AE A9 01 01    LDA #$0101             ;} Scrolls 0..1 = green, 2..3 = blue
$A7:C0B1 8F 22 CD 7E STA $7ECD22[$7E:CD22]  ;/
$A7:C0B5 A9 A4 00    LDA #$00A4             ;\
$A7:C0B8 8F 08 78 7E STA $7E7808[$7E:7808]  ;} $7E:7808 = A4h (minimum Y position to which Kraid will eject Samus)
$A7:C0BC 6B          RTL
}


;;; $C0BD: Unused. Crumble first section of Kraid's spike floor ;;;
{
; Assuming $B7BF used to be a PLM that only crumbled one block
$A7:C0BD 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C0C1             dx 06,1B,B7BF
$A7:C0C5 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C0C9             dx 07,1B,B7BF
$A7:C0CD 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C0D1             dx 08,1B,B7BF
$A7:C0D5 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C0D9             dx 09,1B,B7BF
$A7:C0DD 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C0E1             dx 0A,1B,B7BF
$A7:C0E5 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C0E9             dx 0B,1B,B7BF
$A7:C0ED 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C0F1             dx 0C,1B,B7BF
$A7:C0F5 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C0F9             dx 0D,1B,B7BF
$A7:C0FD 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C101             dx 0E,1B,B7BF
$A7:C105 60          RTS
}


;;; $C106: Unused. Crumble second section of Kraid's spike floor ;;;
{
; Assuming $B7BF used to be a PLM that only crumbled one block
$A7:C106 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C10A             dx 0F,1B,B7BF
$A7:C10E 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C112             dx 10,1B,B7BF
$A7:C116 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C11A             dx 11,1B,B7BF
$A7:C11E 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C122             dx 12,1B,B7BF
$A7:C126 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C12A             dx 13,1B,B7BF
$A7:C12E 60          RTS
}


;;; $C12F: Unused. Crumble third section of Kraid's spike floor ;;;
{
; Assuming $B7BF used to be a PLM that only crumbled one block
$A7:C12F 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C133             dx 14,1B,B7BF
$A7:C137 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C13B             dx 15,1B,B7BF
$A7:C13F 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C143             dx 16,1B,B7BF
$A7:C147 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C14B             dx 17,1B,B7BF
$A7:C14F 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C153             dx 18,1B,B7BF
$A7:C157 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C15B             dx 19,1B,B7BF
$A7:C15F 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C163             dx 1A,1B,B7BF
$A7:C167 60          RTS
}


;;; $C168: Spawn PLM to clear the ceiling ;;;
{
$A7:C168 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C16C             dx  02, 12, B7B7
$A7:C170 60          RTS
}


;;; $C171: Spawn PLM to clear the spikes ;;;
{
$A7:C171 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C175             dx  05, 1B, B7BB
$A7:C179 60          RTS
}


;;; $C17A: Unused. Clear some of the spikes ;;;
{
; Assuming $B7BB used to be a PLM that only crumbled one block
$A7:C17A 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C17E             dx 0B,1B,B7BB
$A7:C182 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C186             dx 0C,1B,B7BB
$A7:C18A 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C18E             dx 0D,1B,B7BB
$A7:C192 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C196             dx 0E,1B,B7BB
$A7:C19A 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C19E             dx 0F,1B,B7BB
$A7:C1A2 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1A6             dx 10,1B,B7BB
$A7:C1AA 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1AE             dx 11,1B,B7BB
$A7:C1B2 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1B6             dx 12,1B,B7BB
$A7:C1BA 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1BE             dx 13,1B,B7BB
$A7:C1C2 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1C6             dx 14,1B,B7BB
$A7:C1CA 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1CE             dx 15,1B,B7BB
$A7:C1D2 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1D6             dx 16,1B,B7BB
$A7:C1DA 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1DE             dx 17,1B,B7BB
$A7:C1E2 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1E6             dx 18,1B,B7BB
$A7:C1EA 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1EE             dx 19,1B,B7BB
$A7:C1F2 22 D7 83 84 JSL $8483D7[$84:83D7]
$A7:C1F6             dx 1A,1B,B7BB
$A7:C1FA 60          RTS
}


;;; $C1FB: Unpause hook - Kraid is dead ;;;
{
$A7:C1FB 08          PHP
$A7:C1FC E2 20       SEP #$20
$A7:C1FE 22 6F 83 80 JSL $80836F[$80:836F]  ; Set force blank and wait for NMI
$A7:C202 A9 00       LDA #$00               ;\
$A7:C204 8D 16 21    STA $2116  [$80:2116]  ;|
$A7:C207 A5 5D       LDA $5D    [$7E:005D]  ;|
$A7:C209 29 0F       AND #$0F               ;|
$A7:C20B 0A          ASL A                  ;|
$A7:C20C 0A          ASL A                  ;|
$A7:C20D 0A          ASL A                  ;|
$A7:C20E 0A          ASL A                  ;|
$A7:C20F 18          CLC                    ;} Transfer $A7:A716..A915 to VRAM $3F00..FF (room background)
$A7:C210 69 3F       ADC #$3F               ;|
$A7:C212 8D 17 21    STA $2117  [$80:2117]  ;|
$A7:C215 A9 80       LDA #$80               ;|
$A7:C217 8D 15 21    STA $2115  [$80:2115]  ;|
$A7:C21A 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$A7:C21E             dx 01,01,18,A7A716,0200;|
$A7:C226 A9 02       LDA #$02               ;|
$A7:C228 8D 0B 42    STA $420B  [$7E:420B]  ;/
$A7:C22B A9 00       LDA #$00               ;\
$A7:C22D 8D 16 21    STA $2116  [$7E:2116]  ;|
$A7:C230 A9 40       LDA #$40               ;|
$A7:C232 8D 17 21    STA $2117  [$7E:2117]  ;|
$A7:C235 A9 80       LDA #$80               ;|
$A7:C237 8D 15 21    STA $2115  [$7E:2115]  ;} Transfer standard BG3 tiles to VRAM $4000..47FF
$A7:C23A 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$A7:C23E             dx 01,01,18,9AB200,0800;|
$A7:C246 A9 02       LDA #$02               ;|
$A7:C248 8D 0B 42    STA $420B  [$7E:420B]  ;/
$A7:C24B 4C 78 C2    JMP $C278  [$A7:C278]  ; Go to transfer Kraid top half tilemap to VRAM
}


;;; $C24E: Unpause hook - Kraid is alive ;;;
{
; $5D isn't being masked, so this code only works because BG1 tiles base address = $0000
$A7:C24E 08          PHP
$A7:C24F E2 20       SEP #$20
$A7:C251 22 6F 83 80 JSL $80836F[$80:836F]  ; Set force blank and wait for NMI
$A7:C255 A9 00       LDA #$00               ;\
$A7:C257 8D 16 21    STA $2116  [$7E:2116]  ;|
$A7:C25A A5 5D       LDA $5D    [$7E:005D]  ;|
$A7:C25C 18          CLC                    ;|
$A7:C25D 69 3E       ADC #$3E               ;|
$A7:C25F 8D 17 21    STA $2117  [$7E:2117]  ;|
$A7:C262 A9 80       LDA #$80               ;} Transfer $7E:5000..53FF to VRAM BG2 tiles base + $3E00
$A7:C264 8D 15 21    STA $2115  [$7E:2115]  ;|
$A7:C267 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$A7:C26B             dx 01,01,18,7E5000,0400;|
$A7:C273 A9 02       LDA #$02               ;|
$A7:C275 8D 0B 42    STA $420B  [$7E:420B]  ;/
}


;;; $C278: Transfer Kraid top half tilemap to VRAM ;;;
{
$A7:C278 A9 00       LDA #$00               ;\
$A7:C27A 8D 16 21    STA $2116  [$7E:2116]  ;|
$A7:C27D A5 59       LDA $59    [$7E:0059]  ;|
$A7:C27F 29 FC       AND #$FC               ;|
$A7:C281 8D 17 21    STA $2117  [$7E:2117]  ;|
$A7:C284 A9 80       LDA #$80               ;} Transfer $7E:2000..27FF to VRAM BG2 tilemap base (Kraid top half)
$A7:C286 8D 15 21    STA $2115  [$7E:2115]  ;|
$A7:C289 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$A7:C28D             dx 01,01,18,7E2000,0800;|
$A7:C295 A9 02       LDA #$02               ;|
$A7:C297 8D 0B 42    STA $420B  [$7E:420B]  ;/
$A7:C29A 22 82 83 80 JSL $808382[$80:8382]  ; Clear force blank and wait for NMI
$A7:C29E 28          PLP
$A7:C29F 6B          RTL
}


;;; $C2A0: Unpause hook - Kraid is sinking ;;;
{
; $5D isn't being masked, so this code only works because BG1 tiles base address = $0000
; Note that this routine is spending a frame on each row of Kraid it erases (worst case, 28 frames),
; the forced blank isn't even being used to transfer the tilemap on demand... and only one transfer is being queued per frame...
; Also note that $0330 is being loaded for no reason (guaranteed to be 0), in fact, if it wasn't guaranteed to be 0,
; this loading procedure would end up repeating every transfer that was requested before this routine was started.

$A7:C2A0 08          PHP
$A7:C2A1 E2 20       SEP #$20
$A7:C2A3 22 6F 83 80 JSL $80836F[$80:836F]  ; Set force blank and wait for NMI
$A7:C2A7 A9 00       LDA #$00               ;\
$A7:C2A9 8D 16 21    STA $2116  [$7E:2116]  ;|
$A7:C2AC A5 5D       LDA $5D    [$7E:005D]  ;|
$A7:C2AE 18          CLC                    ;|
$A7:C2AF 69 3E       ADC #$3E               ;|
$A7:C2B1 8D 17 21    STA $2117  [$7E:2117]  ;|
$A7:C2B4 A9 80       LDA #$80               ;} Transfer $7E:5000..53FF to VRAM BG2 tiles base
$A7:C2B6 8D 15 21    STA $2115  [$7E:2115]  ;|
$A7:C2B9 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$A7:C2BD             dx 01,01,18,7E5000,0400;|
$A7:C2C5 A9 02       LDA #$02               ;|
$A7:C2C7 8D 0B 42    STA $420B  [$7E:420B]  ;/
$A7:C2CA C2 30       REP #$30
$A7:C2CC 8B          PHB
$A7:C2CD 4B          PHK                    ;\
$A7:C2CE AB          PLB                    ;} DB = $A7
$A7:C2CF AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A7:C2D2 CD E7 C5    CMP $C5E7  [$A7:C5E7]  ;} If [Kraid Y position] < [$C5E7]: go to BRANCH_RETURN
$A7:C2D5 30 47       BMI $47    [$C31E]     ;/
$A7:C2D7 A0 00 00    LDY #$0000             ; Y = 0 (sinking Kraid table index)
$A7:C2DA AE 30 03    LDX $0330  [$7E:0330]  ; X = [VRAM write table stack pointer] (will be 0 due to NMI)

; LOOP
$A7:C2DD C2 30       REP #$30
$A7:C2DF B9 E7 C5    LDA $C5E7,y[$A7:C5E7]  ;\
$A7:C2E2 C9 FF FF    CMP #$FFFF             ;} If [$C5E7 + [Y]] = FFFFh: go to BRANCH_RETURN
$A7:C2E5 F0 37       BEQ $37    [$C31E]     ;/
$A7:C2E7 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A7:C2EA D9 E7 C5    CMP $C5E7,y[$A7:C5E7]  ;} If [Kraid Y position] < [$C5E7 + [Y]]: go to BRANCH_RETURN
$A7:C2ED 30 2F       BMI $2F    [$C31E]     ;/
$A7:C2EF A9 40 00    LDA #$0040             ;\
$A7:C2F2 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C2F4 A9 C0 2F    LDA #$2FC0             ;|
$A7:C2F7 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C2F9 A9 7E 00    LDA #$007E             ;|
$A7:C2FC 95 D4       STA $D4,x  [$7E:00D4]  ;|
$A7:C2FE A5 59       LDA $59    [$7E:0059]  ;|
$A7:C300 29 FC 00    AND #$00FC             ;|
$A7:C303 EB          XBA                    ;} Queue transfer of $7E:2FC0..FF to VRAM BG2 tilemap base + [$C5E7 + [Y] + 2] (clear a row of Kraid)
$A7:C304 18          CLC                    ;|
$A7:C305 79 E9 C5    ADC $C5E9,y[$A7:C5E9]  ;|
$A7:C308 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C30A 8A          TXA                    ;|
$A7:C30B 18          CLC                    ;|
$A7:C30C 69 07 00    ADC #$0007             ;|
$A7:C30F 8D 30 03    STA $0330  [$7E:0330]  ;/
$A7:C312 22 38 83 80 JSL $808338[$80:8338]  ; Wait for NMI
$A7:C316 98          TYA                    ;\
$A7:C317 18          CLC                    ;|
$A7:C318 69 06 00    ADC #$0006             ;} Y += 6 (next sinking Kraid table entry)
$A7:C31B A8          TAY                    ;/
$A7:C31C 80 BF       BRA $BF    [$C2DD]     ; Go to LOOP

; BRANCH_RETURN
$A7:C31E AB          PLB
$A7:C31F 22 6F 83 80 JSL $80836F[$80:836F]  ; Set force blank and wait for NMI (very pointless)
$A7:C323 28          PLP
$A7:C324 6B          RTL
}


;;; $C325: Pause hook - Kraid ;;;
{
; $5D is being masked as if its a tilemap register (completely wrong), so this code only works because BG1/2 tiles base address = $0000
$A7:C325 08          PHP
$A7:C326 C2 30       REP #$30
$A7:C328 AE 60 03    LDX $0360  [$7E:0360]  ;\
$A7:C32B A5 5D       LDA $5D    [$7E:005D]  ;|
$A7:C32D 29 FC 00    AND #$00FC             ;|
$A7:C330 EB          XBA                    ;|
$A7:C331 18          CLC                    ;|
$A7:C332 69 00 3E    ADC #$3E00             ;|
$A7:C335 9D 40 03    STA $0340,x[$7E:0340]  ;|
$A7:C338 A9 81 00    LDA #$0081             ;|
$A7:C33B 9D 42 03    STA $0342,x[$7E:0342]  ;|
$A7:C33E A9 39 00    LDA #$0039             ;|
$A7:C341 9D 43 03    STA $0343,x[$7E:0343]  ;} Transfer 400h bytes from VRAM BG2 tiles base + $3E00 to $7E:5000
$A7:C344 A9 00 50    LDA #$5000             ;|
$A7:C347 9D 44 03    STA $0344,x[$7E:0344]  ;|
$A7:C34A A9 7E 00    LDA #$007E             ;|
$A7:C34D 9D 46 03    STA $0346,x[$7E:0346]  ;|
$A7:C350 A9 00 04    LDA #$0400             ;|
$A7:C353 9D 47 03    STA $0347,x[$7E:0347]  ;|
$A7:C356 8A          TXA                    ;|
$A7:C357 18          CLC                    ;|
$A7:C358 69 09 00    ADC #$0009             ;|
$A7:C35B 8D 60 03    STA $0360  [$7E:0360]  ;/
$A7:C35E 28          PLP
$A7:C35F 6B          RTL
}


;;; $C360: Kraid death - initialise death ;;;
{
$A7:C360 AF 2A 78 7E LDA $7E782A[$7E:782A]  ;\
$A7:C364 F0 01       BEQ $01    [$C367]     ;} If [Kraid hurt frame] != 0:
$A7:C366 6B          RTL                    ; Return

$A7:C367 A2 C0 00    LDX #$00C0             ;\
$A7:C36A A9 00 00    LDA #$0000             ;|
                                            ;|
$A7:C36D 9F 00 C2 7E STA $7EC200,x[$7E:C2C0];|
$A7:C371 E8          INX                    ;} Target BG1/2 palette 6 = 0
$A7:C372 E8          INX                    ;|
$A7:C373 E0 E0 00    CPX #$00E0             ;|
$A7:C376 30 F5       BMI $F5    [$C36D]     ;/
$A7:C378 A2 1E 00    LDX #$001E             ;\
                                            ;|
$A7:C37B BD F3 B4    LDA $B4F3,x[$A7:B511]  ;|
$A7:C37E 9F E0 C0 7E STA $7EC0E0,x[$7E:C0FE];} BG1/2 palette 7 = [$B4F3..$B512] (Kraid death palette)
$A7:C382 CA          DEX                    ;|
$A7:C383 CA          DEX                    ;|
$A7:C384 10 F5       BPL $F5    [$C37B]     ;/
$A7:C386 A9 F0 8A    LDA #$8AF0             ;\
$A7:C389 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Kraid arm instruction list pointer = $8AF0 (dying / preparing to lunge forward)
$A7:C38C A9 01 00    LDA #$0001             ;\
$A7:C38F 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Kraid arm instruction timer = 1
$A7:C392 A9 F9 C3    LDA #$C3F9             ;\
$A7:C395 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = fade out background
$A7:C398 A9 6C 97    LDA #$976C             ;\
$A7:C39B 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Kraid instruction list pointer = $9764 + 8 (dying)
$A7:C39E AD 64 97    LDA $9764  [$A7:9764]  ;\
$A7:C3A1 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Kraid instruction timer = 25
$A7:C3A4 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A7:C3A7 DA          PHX                    ;} Save enemy index
$A7:C3A8 AD 06 11    LDA $1106  [$7E:1106]  ;\
$A7:C3AB 29 FF BF    AND #$BFFF             ;} Set Kraid good fingernail to not respawn or be solid to Samus
$A7:C3AE 8D 06 11    STA $1106  [$7E:1106]  ;/
$A7:C3B1 A9 80 01    LDA #$0180             ;\
$A7:C3B4 8D 54 0E    STA $0E54  [$7E:0E54]  ;} Enemy death on Kraid good fingernail
$A7:C3B7 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ;/
$A7:C3BB AD 46 11    LDA $1146  [$7E:1146]  ;\
$A7:C3BE 29 FF BF    AND #$BFFF             ;} Set Kraid bad fingernail to not respawn or be solid to Samus
$A7:C3C1 8D 46 11    STA $1146  [$7E:1146]  ;/
$A7:C3C4 A9 C0 01    LDA #$01C0             ;\
$A7:C3C7 8D 54 0E    STA $0E54  [$7E:0E54]  ;} Enemy death on Kraid bad fingernail
$A7:C3CA 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ;/
$A7:C3CE A9 80 00    LDA #$0080             ;\
$A7:C3D1 8D 54 0E    STA $0E54  [$7E:0E54]  ;} Enemy death on Kraid top lint
$A7:C3D4 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ;/
$A7:C3D8 A9 C0 00    LDA #$00C0             ;\
$A7:C3DB 8D 54 0E    STA $0E54  [$7E:0E54]  ;} Enemy death on Kraid middle lint
$A7:C3DE 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ;/
$A7:C3E2 A9 00 01    LDA #$0100             ;\
$A7:C3E5 8D 54 0E    STA $0E54  [$7E:0E54]  ;} Enemy death on Kraid bottom lint
$A7:C3E8 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ;/
$A7:C3EC 68          PLA                    ;\
$A7:C3ED 8D 54 0E    STA $0E54  [$7E:0E54]  ;} Restore enemy index
$A7:C3F0 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A7:C3F4             dx 05, 1B, B7BF        ;} Spawn PLM to crumble spike floor
$A7:C3F8 6B          RTL
}


;;; $C3F9: Kraid death - fade out background ;;;
{
; Note that BG1 tiles base address = ([$5D] & Fh) * 1000h, whereas this routine is using ([$5D] & Fh) * 100h,
; i.e. this routine only works because BG1 tiles base address = $0000

$A7:C3F9 20 32 AF    JSR $AF32  [$A7:AF32]  ; Kraid instruction list handling
$A7:C3FC 22 6C D9 82 JSL $82D96C[$82:D96C]  ; Advance gradual colour change of BG palette 6
$A7:C400 90 54       BCC $54    [$C456]     ; If not reached target colour: return
$A7:C402 A9 A4 C4    LDA #$C4A4             ;\
$A7:C405 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = update BG2 tilemap top half
$A7:C408 A9 01 00    LDA #$0001             ;\
$A7:C40B 8F 2C 78 7E STA $7E782C[$7E:782C]  ;} Kraid hurt frame timer = 1
$A7:C40F 8F 2A 78 7E STA $7E782A[$7E:782A]  ; Kraid hurt frame = 1
$A7:C413 20 37 B3    JSR $B337  [$A7:B337]  ; Kraid palette handling
$A7:C416 A2 00 00    LDX #$0000             ;\
$A7:C419 A9 00 00    LDA #$0000             ;|
                                            ;|
$A7:C41C 9F 00 40 7E STA $7E4000,x[$7E:4000];|
$A7:C420 9F 02 40 7E STA $7E4002,x[$7E:4002];|
$A7:C424 E8          INX                    ;|
$A7:C425 E8          INX                    ;|
$A7:C426 E8          INX                    ;|
$A7:C427 E8          INX                    ;|
$A7:C428 E0 00 02    CPX #$0200             ;|
$A7:C42B 30 EF       BMI $EF    [$C41C]     ;|
$A7:C42D AE 30 03    LDX $0330  [$7E:0330]  ;|
$A7:C430 A9 00 02    LDA #$0200             ;|
$A7:C433 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C435 A9 00 40    LDA #$4000             ;|
$A7:C438 95 D2       STA $D2,x  [$7E:00D2]  ;} Queue transfer of 200h bytes of 0 to VRAM $3F00 (room background)
$A7:C43A E2 20       SEP #$20               ;|
$A7:C43C A9 7E       LDA #$7E               ;|
$A7:C43E 95 D4       STA $D4,x  [$7E:00D4]  ;|
$A7:C440 C2 20       REP #$20               ;|
$A7:C442 A5 5D       LDA $5D    [$7E:005D]  ;|
$A7:C444 29 0F 00    AND #$000F             ;|
$A7:C447 EB          XBA                    ;|
$A7:C448 18          CLC                    ;|
$A7:C449 69 00 3F    ADC #$3F00             ;|
$A7:C44C 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C44E 8A          TXA                    ;|
$A7:C44F 18          CLC                    ;|
$A7:C450 69 07 00    ADC #$0007             ;|
$A7:C453 8D 30 03    STA $0330  [$7E:0330]  ;/

$A7:C456 6B          RTL
}


;;; $C457: Unused. Process Kraid instruction, except there's no ASM instructions ;;;
{
$A7:C457 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ; A = [Kraid instruction timer]
$A7:C45A F0 47       BEQ $47    [$C4A3]     ; If [Kraid instruction timer] = 0: return
$A7:C45C CE AC 0F    DEC $0FAC  [$7E:0FAC]  ; Decrement Kraid instruction timer
$A7:C45F D0 42       BNE $42    [$C4A3]     ; If [Kraid instruction timer] != 0: return
$A7:C461 AE AA 0F    LDX $0FAA  [$7E:0FAA]  ;\
$A7:C464 BD 00 00    LDA $0000,x            ;} If [[Kraid instruction list pointer]] & 8000h:
$A7:C467 10 07       BPL $07    [$C470]     ;/
$A7:C469 A9 00 00    LDA #$0000             ;\
$A7:C46C 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Kraid instruction timer = 0
$A7:C46F 60          RTS                    ; Return

$A7:C470 8D AC 0F    STA $0FAC  [$7E:0FAC]  ; Kraid instruction timer = [[Kraid instruction list pointer]]
$A7:C473 8A          TXA                    ;\
$A7:C474 18          CLC                    ;|
$A7:C475 69 08 00    ADC #$0008             ;} Kraid instruction list pointer += 8
$A7:C478 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A7:C47B BD 02 00    LDA $0002,x            ;\
$A7:C47E A8          TAY                    ;|
$A7:C47F AE 30 03    LDX $0330  [$7E:0330]  ;|
$A7:C482 A9 C0 02    LDA #$02C0             ;|
$A7:C485 95 D0       STA $D0,x              ;|
$A7:C487 E8          INX                    ;|
$A7:C488 E8          INX                    ;|
$A7:C489 94 D0       STY $D0,x              ;|
$A7:C48B E8          INX                    ;|
$A7:C48C E8          INX                    ;|
$A7:C48D E2 20       SEP #$20               ;|
$A7:C48F A9 A7       LDA #$A7               ;} Queue transfer of 2C0h bytes from $A7:0000 + [[Kraid instruction list pointer] - 6] to VRAM BG2 tilemap base
$A7:C491 95 D0       STA $D0,x              ;|
$A7:C493 C2 20       REP #$20               ;|
$A7:C495 E8          INX                    ;|
$A7:C496 A5 59       LDA $59    [$7E:0059]  ;|
$A7:C498 29 FC 00    AND #$00FC             ;|
$A7:C49B EB          XBA                    ;|
$A7:C49C 95 D0       STA $D0,x              ;|
$A7:C49E E8          INX                    ;|
$A7:C49F E8          INX                    ;|
$A7:C4A0 8E 30 03    STX $0330  [$7E:0330]  ;/

$A7:C4A3 60          RTS
}


;;; $C4A4: Kraid death - update BG2 tilemap top half ;;;
{
$A7:C4A4 20 32 AF    JSR $AF32  [$A7:AF32]  ; Kraid instruction list handling
$A7:C4A7 A9 C8 C4    LDA #$C4C8             ;\
$A7:C4AA 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = update BG2 tilemap bottom half
$A7:C4AD A9 23 B9    LDA #$B923             ;\
$A7:C4B0 8D 28 10    STA $1028  [$7E:1028]  ;|
$A7:C4B3 8D 68 10    STA $1068  [$7E:1068]  ;} Kraid lint functions = horizontally align enemy to Kraid
$A7:C4B6 8D A8 10    STA $10A8  [$7E:10A8]  ;/
$A7:C4B9 A9 FF 7F    LDA #$7FFF             ;\
$A7:C4BC 8D 32 10    STA $1032  [$7E:1032]  ;|
$A7:C4BF 8D 72 10    STA $1072  [$7E:1072]  ;} Kraid lint function timers = 7FFFh
$A7:C4C2 8D B2 10    STA $10B2  [$7E:10B2]  ;/
$A7:C4C5 4C 74 C8    JMP $C874  [$A7:C874]  ; Update BG2 tilemap top half
}


;;; $C4C8: Kraid death - update BG2 tilemap bottom half ;;;
{
$A7:C4C8 20 32 AF    JSR $AF32  [$A7:AF32]  ; Kraid instruction list handling
$A7:C4CB E2 20       SEP #$20               ;\
$A7:C4CD A9 A7       LDA #$A7               ;|
$A7:C4CF 8D 06 06    STA $0606  [$7E:0606]  ;|
$A7:C4D2 C2 20       REP #$20               ;} Unpause hook = unpause hook - Kraid is sinking
$A7:C4D4 A9 A0 C2    LDA #$C2A0             ;|
$A7:C4D7 8D 04 06    STA $0604  [$7E:0604]  ;/
$A7:C4DA A9 37 C5    LDA #$C537             ;\
$A7:C4DD 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = Kraid sinks through floor
$A7:C4E0 A9 2B 00    LDA #$002B             ;\
$A7:C4E3 8F 00 90 7E STA $7E9000[$7E:9000]  ;} Kraid death sequence quake sound timer = 2Bh
$A7:C4E7 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:C4EA 09 00 80    ORA #$8000             ;} Set Kraid to not hitbox solid to Samus
$A7:C4ED 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:C4F0 A9 01 00    LDA #$0001             ;\
$A7:C4F3 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 1 pixel displacement, vertical
$A7:C4F6 A9 00 01    LDA #$0100             ;\
$A7:C4F9 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 100h
$A7:C4FC A9 A4 8A    LDA #$8AA4             ;\
$A7:C4FF 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Kraid arm instruction list pointer = $8AA4 (rising/sinking)
$A7:C502 A9 01 00    LDA #$0001             ;\
$A7:C505 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Kraid arm instruction timer = 1
$A7:C508 A9 E7 86    LDA #$86E7             ;\
$A7:C50B 8D D2 10    STA $10D2  [$7E:10D2]  ;} Kraid foot instruction list pointer = $86E7 (initial)
$A7:C50E A9 01 00    LDA #$0001             ;\
$A7:C511 8D D4 10    STA $10D4  [$7E:10D4]  ;} Kraid foot instruction timer = 1
$A7:C514 A9 2D BA    LDA #$BA2D             ;\
$A7:C517 8D E8 10    STA $10E8  [$7E:10E8]  ;} Kraid foot function = RTL
$A7:C51A 4C B6 C8    JMP $C8B6  [$A7:C8B6]  ; Update BG2 tilemap bottom half
}


;;; $C51D: Play sound every half second ;;;
{
$A7:C51D AF 00 90 7E LDA $7E9000[$7E:9000]  ;\
$A7:C521 3A          DEC A                  ;} Decrement Kraid death sequence quake sound timer
$A7:C522 8F 00 90 7E STA $7E9000[$7E:9000]  ;/
$A7:C526 D0 0E       BNE $0E    [$C536]     ; If [Kraid death sequence quake sound timer] = 0:
$A7:C528 A9 1E 00    LDA #$001E             ;\
$A7:C52B 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1Eh, sound library 3, max queued sounds allowed = 6 (Kraid's earthquake)
$A7:C52F A9 1E 00    LDA #$001E             ;\
$A7:C532 8F 00 90 7E STA $7E9000[$7E:9000]  ;} Kraid death sequence quake sound timer = 30

$A7:C536 60          RTS
}


;;; $C537: Kraid death - Kraid sinks through floor ;;;
{
$A7:C537 20 32 AF    JSR $AF32  [$A7:AF32]  ; Kraid instruction list handling
$A7:C53A 20 1D C5    JSR $C51D  [$A7:C51D]  ; Play sound every half second
$A7:C53D 20 9F C5    JSR $C59F  [$A7:C59F]  ; Handle Kraid sinking
$A7:C540 EE 7E 0F    INC $0F7E  [$7E:0F7E]  ; Increment Kraid Y position
$A7:C543 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A7:C546 C9 60 02    CMP #$0260             ;} If [Kraid Y position] < 260h: return
$A7:C549 30 53       BMI $53    [$C59E]     ;/
$A7:C54B AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:C54E 29 FF FB    AND #$FBFF             ;} Set Kraid as tangible
$A7:C551 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:C554 A9 02 00    LDA #$0002             ;\
$A7:C557 8D 9A 17    STA $179A  [$7E:179A]  ;} Enemy BG2 tilemap size = 2 (why?)
$A7:C55A AC 54 0E    LDY $0E54  [$7E:0E54]  ;\
$A7:C55D BE 78 0F    LDX $0F78,y[$7E:0F78]  ;|
$A7:C560 A9 4C 80    LDA #$804C             ;} Uhhh >_<; (enemy shot "=" RTL)
$A7:C563 9F 32 00 A0 STA $A00032,x[$A0:E2F1];/
$A7:C567 AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A7:C56A 09 00 02    ORA #$0200             ;|
$A7:C56D 09 00 04    ORA #$0400             ;} Set Kraid's arm as intangible and flagged for deletion
$A7:C570 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A7:C573 09 00 02    ORA #$0200             ;\
$A7:C576 09 00 04    ORA #$0400             ;} >_<
$A7:C579 29 FF F7    AND #$F7FF             ;\
$A7:C57C 29 FF DF    AND #$DFFF             ;|
$A7:C57F 29 FF 7F    AND #$7FFF             ;|
$A7:C582 8D 06 10    STA $1006  [$7E:1006]  ;} Set Kraid's foot and lints as intangible, flagged for deletion, not processed off screen, not processing instructions and non-solid hitbox
$A7:C585 8D 46 10    STA $1046  [$7E:1046]  ;|
$A7:C588 8D 86 10    STA $1086  [$7E:1086]  ;|
$A7:C58B 8D C6 10    STA $10C6  [$7E:10C6]  ;/
$A7:C58E A9 15 C7    LDA #$C715             ;\
$A7:C591 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = fade in regular background
$A7:C594 9C 41 09    STZ $0941  [$7E:0941]  ; Camera distance index = 0 (normal)
$A7:C597 22 71 BA A0 JSL $A0BA71[$A0:BA71]  ; Kraid death item drop routine
$A7:C59B 4C 9A AD    JMP $AD9A  [$A7:AD9A]  ; Go to draw Kraid's room background

$A7:C59E 6B          RTL
}


;;; $C59F: Handle Kraid sinking ;;;
{
; Note that Kraid *does* need to be cleared as he's sinking, otherwise he will wrap around from the ceiling
$A7:C59F A0 00 00    LDY #$0000             ; Y = 0

; LOOP
$A7:C5A2 B9 E7 C5    LDA $C5E7,y[$A7:C5E7]  ;\
$A7:C5A5 30 3F       BMI $3F    [$C5E6]     ;} If [$C5E7 + [Y]] & 8000h != 0: return
$A7:C5A7 CD 7E 0F    CMP $0F7E  [$7E:0F7E]  ;\
$A7:C5AA F0 08       BEQ $08    [$C5B4]     ;} If [$C5E7 + [Y]] != [Kraid Y position]:
$A7:C5AC 98          TYA                    ;\
$A7:C5AD 18          CLC                    ;|
$A7:C5AE 69 06 00    ADC #$0006             ;} Y += 6
$A7:C5B1 A8          TAY                    ;/
$A7:C5B2 80 EE       BRA $EE    [$C5A2]     ; Go to LOOP

$A7:C5B4 B9 E9 C5    LDA $C5E9,y[$A7:C65B]  ;\
$A7:C5B7 30 29       BMI $29    [$C5E2]     ;} If [$C5E7 + [Y] + 2] & 8000h = 0: (redundant check)
$A7:C5B9 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A7:C5BC A9 40 00    LDA #$0040             ;|
$A7:C5BF 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C5C1 A9 C0 2F    LDA #$2FC0             ;|
$A7:C5C4 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C5C6 E2 20       SEP #$20               ;|
$A7:C5C8 A9 7E       LDA #$7E               ;|
$A7:C5CA 95 D4       STA $D4,x  [$7E:00D4]  ;|
$A7:C5CC C2 20       REP #$20               ;|
$A7:C5CE A5 59       LDA $59    [$7E:0059]  ;} Queue transfer of $7E:2FC0..FF to VRAM BG2 tilemap base + [$C5E7 + [Y] + 2] (clear a row of Kraid)
$A7:C5D0 29 FC 00    AND #$00FC             ;|
$A7:C5D3 EB          XBA                    ;|
$A7:C5D4 18          CLC                    ;|
$A7:C5D5 79 E9 C5    ADC $C5E9,y[$A7:C65B]  ;|
$A7:C5D8 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C5DA 8A          TXA                    ;|
$A7:C5DB 18          CLC                    ;|
$A7:C5DC 69 07 00    ADC #$0007             ;|
$A7:C5DF 8D 30 03    STA $0330  [$7E:0330]  ;/

$A7:C5E2 BB          TYX                    ;\
$A7:C5E3 FC EB C5    JSR ($C5EB,x)[$A7:C6A6];} Execute [$C5E7 + [Y] + 4]

$A7:C5E6 60          RTS
}


;;; $C5E7: Sinking Kraid table ;;;
{
;                        _____________ Kraid Y position
;                       |     ________ VRAM BG2 tilemap offset (from which to clear 20h words)
;                       |    |     ___ Function ($C6A6 is RTS)
;                       |    |    |
$A7:C5E7             dw 0130,08A0,C691, ; Crumble left platform - left
                        0138,0880,C6A6,
                        0140,0860,C6A6,
                        0148,0840,C6A7, ; Crumble right platform - middle
                        0150,0820,C6A6,
                        0158,0800,C6A6,
                        0160,03E0,C6BD, ; Crumble right platform - left
                        0168,03C0,C6A6,
                        0170,03A0,C6A6,
                        0178,0380,C6A6,
                        0180,0360,C6D3, ; Crumble left platform - right
                        0188,0340,C6A6,
                        0190,0320,C6A6,
                        0198,0300,C6E9, ; Crumble left platform - middle
                        01A0,02E0,C6A6,
                        01A8,02C0,C6A6,
                        01B0,02A0,C6FF, ; Crumble right platform - right
                        01B8,0280,C6A6,
                        01C0,0260,C6A6,
                        01C8,0240,C6A6,
                        01D0,0220,C6A6,
                        01D8,0200,C6A6,
                        01E0,01E0,C6A6,
                        01E8,01C0,C6A6,
                        01F0,01A0,C6A6,
                        01F8,0180,C6A6,
                        0200,0160,C6A6,
                        0208,0140,C6A6,
                        FFFF
}


;;; $C691: Crumble left platform - left ;;;
{
$A7:C691 A9 70 00    LDA #$0070             ;\
$A7:C694 A0 53 9C    LDY #$9C53             ;|
$A7:C697 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn falling rocks enemy projectile at X position 70h
$A7:C69A 22 27 80 86 JSL $868027[$86:8027]  ;/
$A7:C69E 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A7:C6A2             dx 07, 12, B7A7        ;} Destroy ceiling platform block at block (7, 12h)
$A7:C6A6 60          RTS
}


;;; $C6A7: Crumble right platform - middle ;;;
{
$A7:C6A7 A9 F0 00    LDA #$00F0             ;\
$A7:C6AA A0 53 9C    LDY #$9C53             ;|
$A7:C6AD AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn falling rocks enemy projectile at X position F0h
$A7:C6B0 22 27 80 86 JSL $868027[$86:8027]  ;/
$A7:C6B4 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A7:C6B8             dx 0F, 12, B7A7        ;} Destroy ceiling platform block at X block (Fh, 12h)
$A7:C6BC 60          RTS
}


;;; $C6BD: Crumble right platform - left ;;;
{
$A7:C6BD A9 E0 00    LDA #$00E0             ;\
$A7:C6C0 A0 53 9C    LDY #$9C53             ;|
$A7:C6C3 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn falling rocks enemy projectile at X position E0h
$A7:C6C6 22 27 80 86 JSL $868027[$86:8027]  ;/
$A7:C6CA 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A7:C6CE             dx 0E, 12, B7AF        ;} Destroy ceiling platform block at X block (Eh, 12h)
$A7:C6D2 60          RTS
}


;;; $C6D3: Crumble left platform - right ;;;
{
$A7:C6D3 A9 90 00    LDA #$0090             ;\
$A7:C6D6 A0 53 9C    LDY #$9C53             ;|
$A7:C6D9 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn falling rocks enemy projectile at X position 90h
$A7:C6DC 22 27 80 86 JSL $868027[$86:8027]  ;/
$A7:C6E0 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A7:C6E4             dx 09, 12, B7A7        ;} Destroy ceiling platform block at X block (9, 12h)
$A7:C6E8 60          RTS
}


;;; $C6E9: Crumble left platform - middle ;;;
{
$A7:C6E9 A9 80 00    LDA #$0080             ;\
$A7:C6EC A0 53 9C    LDY #$9C53             ;|
$A7:C6EF AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn falling rocks enemy projectile at X position 80h
$A7:C6F2 22 27 80 86 JSL $868027[$86:8027]  ;/
$A7:C6F6 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A7:C6FA             dx 08, 12, B7AF        ;} Destroy ceiling platform block at X block (8, 12h)
$A7:C6FE 60          RTS
}


;;; $C6FF: Crumble right platform - right ;;;
{
$A7:C6FF A9 00 01    LDA #$0100             ;\
$A7:C702 A0 53 9C    LDY #$9C53             ;|
$A7:C705 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn falling rocks enemy projectile at X position 100h
$A7:C708 22 27 80 86 JSL $868027[$86:8027]  ;/
$A7:C70C 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A7:C710             dx 10, 12, B7AF        ;} Destroy ceiling platform block at X block (10h, 12h)
$A7:C714 60          RTS
}


;;; $C715: Kraid function - fade in regular background - clear BG2 tilemap top half ;;;
{
$A7:C715 E2 20       SEP #$20
$A7:C717 A9 48       LDA #$48               ;\
$A7:C719 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4800, BG2 size = 32x32
$A7:C71B C2 20       REP #$20
$A7:C71D A2 FE 07    LDX #$07FE             ;\
$A7:C720 A9 38 03    LDA #$0338             ;|
                                            ;|
$A7:C723 9F 00 20 7E STA $7E2000,x[$7E:27FE];} $7E:2000..27FF = 338h
$A7:C727 CA          DEX                    ;|
$A7:C728 CA          DEX                    ;|
$A7:C729 10 F8       BPL $F8    [$C723]     ;/
$A7:C72B AE 30 03    LDX $0330  [$7E:0330]  ;\
$A7:C72E A9 00 04    LDA #$0400             ;|
$A7:C731 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C733 A9 00 20    LDA #$2000             ;|
$A7:C736 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C738 A9 7E 00    LDA #$007E             ;|
$A7:C73B 95 D4       STA $D4,x  [$7E:00D4]  ;} Queue transfer of 400h bytes from $7E:2000 to VRAM BG2 tilemap base
$A7:C73D A9 00 48    LDA #$4800             ;|
$A7:C740 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C742 8A          TXA                    ;|
$A7:C743 18          CLC                    ;|
$A7:C744 69 07 00    ADC #$0007             ;|
$A7:C747 8D 30 03    STA $0330  [$7E:0330]  ;/
$A7:C74A A9 51 C7    LDA #$C751             ;\
$A7:C74D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = clear BG2 tilemap bottom half
$A7:C750 6B          RTL
}


;;; $C751: Kraid function - fade in regular background - clear BG2 tilemap bottom half ;;;
{
$A7:C751 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A7:C754 A9 00 04    LDA #$0400             ;|
$A7:C757 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C759 A9 00 20    LDA #$2000             ;|
$A7:C75C 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C75E A9 7E 00    LDA #$007E             ;|
$A7:C761 95 D4       STA $D4,x  [$7E:00D4]  ;} Queue transfer of 400h bytes from $7E:2000 to VRAM BG2 tilemap base + 200h
$A7:C763 A9 00 4A    LDA #$4A00             ;|
$A7:C766 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C768 8A          TXA                    ;|
$A7:C769 18          CLC                    ;|
$A7:C76A 69 07 00    ADC #$0007             ;|
$A7:C76D 8D 30 03    STA $0330  [$7E:0330]  ;/
$A7:C770 A9 77 C7    LDA #$C777             ;\
$A7:C773 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = load standard BG3 tiles 1/4
$A7:C776 6B          RTL
}


;;; $C777: Kraid function - fade in regular background - load standard BG3 tiles 1/4 ;;;
{
$A7:C777 A9 FB C1    LDA #$C1FB             ;\
$A7:C77A 8D 04 06    STA $0604  [$7E:0604]  ;} Unpause hook = unpause hook - Kraid is dead
$A7:C77D A9 A3 C7    LDA #$C7A3             ;\
$A7:C780 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = load standard BG3 tiles 2/4
$A7:C783 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A7:C786 A9 00 04    LDA #$0400             ;|
$A7:C789 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C78B A9 00 B2    LDA #$B200             ;|
$A7:C78E 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C790 A9 9A 00    LDA #$009A             ;|
$A7:C793 95 D4       STA $D4,x  [$7E:00D4]  ;} Queue transfer of 400h bytes from standard BG3 tiles to VRAM $4000
$A7:C795 A9 00 40    LDA #$4000             ;|
$A7:C798 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C79A 8A          TXA                    ;|
$A7:C79B 18          CLC                    ;|
$A7:C79C 69 07 00    ADC #$0007             ;|
$A7:C79F 8D 30 03    STA $0330  [$7E:0330]  ;/
$A7:C7A2 6B          RTL
}


;;; $C7A3: Kraid function - fade in regular background - load standard BG3 tiles 2/4 ;;;
{
$A7:C7A3 A9 C9 C7    LDA #$C7C9             ;\
$A7:C7A6 8D A8 0F    STA $0FA8  [$80:0FA8]  ;} Kraid function = load standard BG3 tiles 3/4
$A7:C7A9 AE 30 03    LDX $0330  [$80:0330]  ;\
$A7:C7AC A9 00 04    LDA #$0400             ;|
$A7:C7AF 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C7B1 A9 00 B6    LDA #$B600             ;|
$A7:C7B4 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C7B6 A9 9A 00    LDA #$009A             ;|
$A7:C7B9 95 D4       STA $D4,x  [$7E:00D4]  ;} Queue transfer of 400h bytes from standard BG3 tiles + 400h to VRAM $4200
$A7:C7BB A9 00 42    LDA #$4200             ;|
$A7:C7BE 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C7C0 8A          TXA                    ;|
$A7:C7C1 18          CLC                    ;|
$A7:C7C2 69 07 00    ADC #$0007             ;|
$A7:C7C5 8D 30 03    STA $0330  [$80:0330]  ;/
$A7:C7C8 6B          RTL
}


;;; $C7C9: Kraid function - fade in regular background - load standard BG3 tiles 3/4 ;;;
{
$A7:C7C9 A9 EF C7    LDA #$C7EF             ;\
$A7:C7CC 8D A8 0F    STA $0FA8  [$80:0FA8]  ;} Kraid function = load standard BG3 tiles 4/4
$A7:C7CF AE 30 03    LDX $0330  [$80:0330]  ;\
$A7:C7D2 A9 00 04    LDA #$0400             ;|
$A7:C7D5 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C7D7 A9 00 BA    LDA #$BA00             ;|
$A7:C7DA 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C7DC A9 9A 00    LDA #$009A             ;|
$A7:C7DF 95 D4       STA $D4,x  [$7E:00D4]  ;} Queue transfer of 400h bytes from standard BG3 tiles + 800h to VRAM $4400
$A7:C7E1 A9 00 44    LDA #$4400             ;|
$A7:C7E4 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C7E6 8A          TXA                    ;|
$A7:C7E7 18          CLC                    ;|
$A7:C7E8 69 07 00    ADC #$0007             ;|
$A7:C7EB 8D 30 03    STA $0330  [$80:0330]  ;/
$A7:C7EE 6B          RTL
}


;;; $C7EF: Kraid function - fade in regular background - load standard BG3 tiles 4/4 ;;;
{
$A7:C7EF A9 15 C8    LDA #$C815             ;\
$A7:C7F2 8D A8 0F    STA $0FA8  [$80:0FA8]  ;} Kraid function = fade in BG palette 6
$A7:C7F5 AE 30 03    LDX $0330  [$80:0330]  ;\
$A7:C7F8 A9 00 04    LDA #$0400             ;|
$A7:C7FB 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C7FD A9 00 BE    LDA #$BE00             ;|
$A7:C800 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C802 A9 9A 00    LDA #$009A             ;|
$A7:C805 95 D4       STA $D4,x  [$7E:00D4]  ;} Queue transfer of 400h bytes from standard BG3 tiles + C00h to VRAM $4600
$A7:C807 A9 00 46    LDA #$4600             ;|
$A7:C80A 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C80C 8A          TXA                    ;|
$A7:C80D 18          CLC                    ;|
$A7:C80E 69 07 00    ADC #$0007             ;|
$A7:C811 8D 30 03    STA $0330  [$80:0330]  ;/
$A7:C814 6B          RTL
}


;;; $C815: Kraid function - fade in regular background - fade in BG palette 6 ;;;
{
$A7:C815 22 6C D9 82 JSL $82D96C[$82:D96C]  ; Advance gradual colour change of BG palette 6
$A7:C819 90 20       BCC $20    [$C83B]     ; If not reached target colour: return
$A7:C81B A9 03 00    LDA #$0003             ;\
$A7:C81E 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue elevator music track
$A7:C822 AE 9F 07    LDX $079F  [$80:079F]  ;\
$A7:C825 BF 28 D8 7E LDA $7ED828,x[$7E:D828];|
$A7:C829 89 01 00    BIT #$0001             ;} If Kraid is dead: go to BRANCH_KRAID_IS_DEAD
$A7:C82C D0 0E       BNE $0E    [$C83C]     ;/
$A7:C82E 09 01 00    ORA #$0001             ;\
$A7:C831 9F 28 D8 7E STA $7ED828,x[$7E:D828];} Set Kraid as dead
$A7:C835 A9 43 C8    LDA #$C843             ;\
$A7:C838 8D A8 0F    STA $0FA8  [$80:0FA8]  ;} Kraid function = set enemy properties to dead - Kraid was alive

$A7:C83B 6B          RTL                    ; Return

; BRANCH_KRAID_IS_DEAD
$A7:C83C A9 51 C8    LDA #$C851             ;\ Else (Kraid is dead):
$A7:C83F 8D A8 0F    STA $0FA8  [$80:0FA8]  ;} Kraid function = set enemy properties to dead - Kraid was dead
$A7:C842 6B          RTL
}


;;; $C843: Kraid function - fade in regular background - set enemy properties to dead - Kraid was alive ;;;
{
; Not entirely sure why this function exists
$A7:C843 20 2C A9    JSR $A92C  [$A7:A92C]  ;\
$A7:C846 F0 05       BEQ $05    [$C84D]     ;} If Kraid is dead:
$A7:C848 AD 11 09    LDA $0911  [$80:0911]  ;\
$A7:C84B F0 03       BEQ $03    [$C850]     ;} If [layer 1 X position] = 0: return

$A7:C84D 20 43 A9    JSR $A943  [$A7:A943]  ; Set enemy properties to dead

$A7:C850 6B          RTL
}


;;; $C851: Kraid function - fade in regular background - set enemy properties to dead - Kraid was dead ;;;
{
; Not entirely sure why this function exists
$A7:C851 20 2C A9    JSR $A92C  [$A7:A92C]  ;\
$A7:C854 F0 05       BEQ $05    [$C85B]     ;} If Kraid is dead:
$A7:C856 AD 11 09    LDA $0911  [$80:0911]  ;\
$A7:C859 F0 03       BEQ $03    [$C85E]     ;} If [layer 1 X position] = 0: go to BRANCH_RETURN

$A7:C85B 20 43 A9    JSR $A943  [$A7:A943]  ; Set enemy properties to dead

; BRANCH_RETURN
$A7:C85E A9 FF FF    LDA #$FFFF             ;\
$A7:C861 8D FF 08    STA $08FF  [$80:08FF]  ;} Previous layer 1 X block = -1
$A7:C864 6B          RTL
}


;;; $C865: Kraid function - restrict Samus X position to first screen ;;;
{
$A7:C865 20 EE C9    JSR $C9EE  [$A7:C9EE]  ; Restrict Samus X position to first screen
$A7:C868 4C 2D B9    JMP $B92D  [$A7:B92D]  ; Handle Kraid enemy function timer
}


;;; $C86B: Kraid function - raise Kraid through floor - load tilemap top half ;;;
{
$A7:C86B 20 EE C9    JSR $C9EE  [$A7:C9EE]  ; Restrict Samus X position to first screen
$A7:C86E A9 9A C8    LDA #$C89A             ;\
$A7:C871 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = load tilemap bottom half and shake screen
}


;;; $C874: Update BG2 tilemap top half ;;;
{
$A7:C874 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A7:C877 A9 00 08    LDA #$0800             ;|
$A7:C87A 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C87C A9 00 20    LDA #$2000             ;|
$A7:C87F 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C881 E2 20       SEP #$20               ;|
$A7:C883 A9 7E       LDA #$7E               ;|
$A7:C885 95 D4       STA $D4,x  [$7E:00D4]  ;|
$A7:C887 C2 20       REP #$20               ;} Queue transfer of $7E:2000..27FF to VRAM BG2 tilemap base
$A7:C889 A5 59       LDA $59    [$7E:0059]  ;|
$A7:C88B 29 FC 00    AND #$00FC             ;|
$A7:C88E EB          XBA                    ;|
$A7:C88F 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C891 8A          TXA                    ;|
$A7:C892 18          CLC                    ;|
$A7:C893 69 07 00    ADC #$0007             ;|
$A7:C896 8D 30 03    STA $0330  [$7E:0330]  ;/
$A7:C899 6B          RTL
}


;;; $C89A: Kraid function - raise Kraid through floor - load tilemap bottom half and shake screen ;;;
{
$A7:C89A 20 EE C9    JSR $C9EE  [$A7:C9EE]  ; Restrict Samus X position to first screen
$A7:C89D A9 E0 C8    LDA #$C8E0             ;\
$A7:C8A0 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = spawn random earthquake projectiles every 10h frames
$A7:C8A3 A9 78 00    LDA #$0078             ;\
$A7:C8A6 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Kraid function timer = 120
$A7:C8A9 A9 F0 01    LDA #$01F0             ;\
$A7:C8AC 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake shaking timer = 1F0h
$A7:C8AF A9 05 00    LDA #$0005             ;\
$A7:C8B2 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track
}


;;; $C8B6: Update BG2 tilemap bottom half ;;;
{
$A7:C8B6 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A7:C8B9 A9 00 08    LDA #$0800             ;|
$A7:C8BC 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:C8BE A9 00 28    LDA #$2800             ;|
$A7:C8C1 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A7:C8C3 E2 20       SEP #$20               ;|
$A7:C8C5 A9 7E       LDA #$7E               ;|
$A7:C8C7 95 D4       STA $D4,x  [$7E:00D4]  ;|
$A7:C8C9 C2 20       REP #$20               ;|
$A7:C8CB A5 59       LDA $59    [$7E:0059]  ;} Queue transfer of $7E:2800..2FFF to VRAM BG2 tilemap base + 400h
$A7:C8CD 29 FC 00    AND #$00FC             ;|
$A7:C8D0 EB          XBA                    ;|
$A7:C8D1 18          CLC                    ;|
$A7:C8D2 69 00 08    ADC #$0800             ;|
$A7:C8D5 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A7:C8D7 8A          TXA                    ;|
$A7:C8D8 18          CLC                    ;|
$A7:C8D9 69 07 00    ADC #$0007             ;|
$A7:C8DC 8D 30 03    STA $0330  [$7E:0330]  ;/
$A7:C8DF 6B          RTL
}


;;; $C8E0: Kraid function - raise Kraid through floor - spawn random earthquake projectiles every 10h frames ;;;
{
$A7:C8E0 20 EE C9    JSR $C9EE  [$A7:C9EE]  ; Restrict Samus X position to first screen
$A7:C8E3 AD B2 0F    LDA $0FB2  [$7E:0FB2]  ;\
$A7:C8E6 3A          DEC A                  ;} Decrement Kraid function timer
$A7:C8E7 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;/
$A7:C8EA D0 0D       BNE $0D    [$C8F9]     ; If [Kraid function timer] = 0:
$A7:C8EC A9 02 C9    LDA #$C902             ;\
$A7:C8EF 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Kraid function = spawn random earthquake projectiles every 8 frames
$A7:C8F2 A9 60 00    LDA #$0060             ;\
$A7:C8F5 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Kraid function timer = 60h
$A7:C8F8 6B          RTL                    ; Return

$A7:C8F9 29 0F 00    AND #$000F             ;\ Else ([Kraid function timer] != 0):
$A7:C8FC D0 03       BNE $03    [$C901]     ;} If [Kraid function timer] is a multiple of 10h:
$A7:C8FE 20 95 C9    JSR $C995  [$A7:C995]  ; Spawn random earthquake projectile

$A7:C901 6B          RTL
}


;;; $C902: Kraid function - raise Kraid through floor - spawn random earthquake projectiles every 8 frames ;;;
{
$A7:C902 20 EE C9    JSR $C9EE  [$A7:C9EE]  ; Restrict Samus X position to first screen
$A7:C905 AD B2 0F    LDA $0FB2  [$82:0FB2]  ;\
$A7:C908 3A          DEC A                  ;} Decrement Kraid function timer
$A7:C909 8D B2 0F    STA $0FB2  [$82:0FB2]  ;/
$A7:C90C D0 0D       BNE $0D    [$C91B]     ; If [Kraid function timer] = 0:
$A7:C90E A9 24 C9    LDA #$C924             ;\
$A7:C911 8D A8 0F    STA $0FA8  [$82:0FA8]  ;} Kraid function = raise Kraid
$A7:C914 A9 20 01    LDA #$0120             ;\
$A7:C917 8D B2 0F    STA $0FB2  [$82:0FB2]  ;} Kraid function timer = 120h
$A7:C91A 6B          RTL                    ; Return

$A7:C91B 29 07 00    AND #$0007             ;\ Else ([Kraid function timer] != 0):
$A7:C91E D0 03       BNE $03    [$C923]     ;} If [Kraid function timer] is a multiple of 8
$A7:C920 20 95 C9    JSR $C995  [$A7:C995]  ; Spawn random earthquake projectile

$A7:C923 6B          RTL
}


;;; $C924: Kraid function - raise Kraid through floor - raise Kraid ;;;
{
$A7:C924 20 EE C9    JSR $C9EE  [$A7:C9EE]  ; Restrict Samus X position to first screen
$A7:C927 AD 40 18    LDA $1840  [$82:1840]  ;\
$A7:C92A 89 05 00    BIT #$0005             ;} If [screen shaking timer] % 8 = 0 or 2:
$A7:C92D D0 03       BNE $03    [$C932]     ;/
$A7:C92F 20 95 C9    JSR $C995  [$A7:C995]  ; Spawn random earthquake projectile

$A7:C932 A0 01 00    LDY #$0001             ; Y = 1
$A7:C935 AD 7E 0F    LDA $0F7E  [$82:0F7E]  ;\
$A7:C938 89 02 00    BIT #$0002             ;} If [Kraid Y position] % 4 < 2:
$A7:C93B D0 03       BNE $03    [$C940]     ;/
$A7:C93D A0 FF FF    LDY #$FFFF             ; Y = -1

$A7:C940 84 12       STY $12    [$7E:0012]  ;\
$A7:C942 AD 7A 0F    LDA $0F7A  [$82:0F7A]  ;|
$A7:C945 18          CLC                    ;} Kraid X position += [Y]
$A7:C946 65 12       ADC $12    [$7E:0012]  ;|
$A7:C948 8D 7A 0F    STA $0F7A  [$82:0F7A]  ;/
$A7:C94B AD 80 0F    LDA $0F80  [$82:0F80]  ;\
$A7:C94E 38          SEC                    ;|
$A7:C94F E9 00 80    SBC #$8000             ;|
$A7:C952 8D 80 0F    STA $0F80  [$82:0F80]  ;} Kraid Y position -= 0.8000h
$A7:C955 AD 7E 0F    LDA $0F7E  [$82:0F7E]  ;|
$A7:C958 E9 00 00    SBC #$0000             ;|
$A7:C95B 8D 7E 0F    STA $0F7E  [$82:0F7E]  ;/
$A7:C95E AD 7E 0F    LDA $0F7E  [$82:0F7E]  ;\
$A7:C961 C9 C9 01    CMP #$01C9             ;} If [Kraid Y position] >= 1C9h: return
$A7:C964 10 2E       BPL $2E    [$C994]     ;/
$A7:C966 A9 B0 00    LDA #$00B0             ;\
$A7:C969 8D 7A 0F    STA $0F7A  [$82:0F7A]  ;} Kraid X position = B0h
$A7:C96C A9 60 B9    LDA #$B960             ;\
$A7:C96F 8D E8 10    STA $10E8  [$82:10E8]  ;} Kraid foot function = first phase - thinking
$A7:C972 A9 2C 01    LDA #$012C             ;\
$A7:C975 8D F2 10    STA $10F2  [$82:10F2]  ;} Kraid foot function timer = 300
$A7:C978 A9 2D BF    LDA #$BF2D             ;\
$A7:C97B 8F 40 79 7E STA $7E7940[$7E:7940]  ;} Kraid foot next function = first phase - prepare to lunge forward
$A7:C97F A9 DA 96    LDA #$96DA             ;\
$A7:C982 8D AA 0F    STA $0FAA  [$82:0FAA]  ;} Kraid instruction list pointer = $96D2 + 8 (roar)
$A7:C985 20 E9 AD    JSR $ADE9  [$A7:ADE9]  ; Set up Kraid main loop - thinking
$A7:C988 A9 F3 89    LDA #$89F3             ;\
$A7:C98B 8D D2 0F    STA $0FD2  [$82:0FD2]  ;} Kraid arm instruction list pointer = $89F3 (normal)
$A7:C98E A9 01 00    LDA #$0001             ;\
$A7:C991 8D D4 0F    STA $0FD4  [$82:0FD4]  ;} Kraid arm instruction timer = 1

$A7:C994 6B          RTL
}


;;; $C995: Spawn random earthquake projectile ;;;
{
; This first part is dreadful, here's my optimisation:
; LDA $05E5 : AND #$003F : BIT #$0002 : BNE $03 : EOR #$FFFF
; CLC : ADC $0F7A : STA $12
; This generates a random number from:
; 3F, 3E, -3E, -3D, 3B, 3A, -3A, -39, 37, 36, -36, -35, 33, 32, -32, -31, 2F, 2E, -2E, -2D, 2B, 2A, -2A, -29, 27, 26, -26, -25, 23, 22, -22, -21, 1F, 1E, -1E, -1D, 1B, 1A, -1A, -19, 17, 16, -16, -15, 13, 12, -12, -11, 0F, 0E, -0E, -0D, 0B, 0A, -0A, -09, 07, 06, -06, -05, 03, 02, -02, -01
$A7:C995 AD B5 05    LDA $05B5  [$7E:05B5]
$A7:C998 89 02 00    BIT #$0002
$A7:C99B AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A7:C99E 29 3F 00    AND #$003F             ;|
$A7:C9A1 AA          TAX                    ;|
$A7:C9A2 AD E5 05    LDA $05E5  [$7E:05E5]  ;|
$A7:C9A5 89 02 00    BIT #$0002             ;|
$A7:C9A8 D0 05       BNE $05    [$C9AF]     ;|
$A7:C9AA 8A          TXA                    ;|
$A7:C9AB 49 FF FF    EOR #$FFFF             ;} $12 = random number -3Eh..3Fh
$A7:C9AE AA          TAX                    ;|
                                            ;|
$A7:C9AF 8A          TXA                    ;|
$A7:C9B0 18          CLC                    ;|
$A7:C9B1 6D 7A 0F    ADC $0F7A  [$82:0F7A]  ;|
$A7:C9B4 85 12       STA $12    [$7E:0012]  ;/
$A7:C9B6 AD E5 05    LDA $05E5  [$82:05E5]  ;\
$A7:C9B9 29 00 3F    AND #$3F00             ;|
$A7:C9BC EB          XBA                    ;|
$A7:C9BD 85 14       STA $14    [$7E:0014]  ;|
$A7:C9BF A9 C0 01    LDA #$01C0             ;} $14 = random number 81h..1C0h
$A7:C9C2 38          SEC                    ;|
$A7:C9C3 E5 14       SBC $14    [$7E:0014]  ;|
$A7:C9C5 85 14       STA $14    [$7E:0014]  ;/
$A7:C9C7 A9 15 00    LDA #$0015             ;\
$A7:C9CA 85 16       STA $16    [$7E:0016]  ;} $16 = 15h (big dust cloud)
$A7:C9CC 64 18       STZ $18    [$7E:0018]  ; $18 = 0
$A7:C9CE 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ; Create sprite object
$A7:C9D2 A0 61 9C    LDY #$9C61             ;\
$A7:C9D5 AD E5 05    LDA $05E5  [$82:05E5]  ;|
$A7:C9D8 89 10 00    BIT #$0010             ;|
$A7:C9DB F0 03       BEQ $03    [$C9E0]     ;|
$A7:C9DD A0 6F 9C    LDY #$9C6F             ;|
                                            ;} Spawn Kraid rocks enemy projectile randomly left or right with random number parameter
$A7:C9E0 AE 54 0E    LDX $0E54  [$82:0E54]  ;|
$A7:C9E3 AD E5 05    LDA $05E5  [$82:05E5]  ;|
$A7:C9E6 29 F0 03    AND #$03F0             ;|
$A7:C9E9 22 27 80 86 JSL $868027[$86:8027]  ;/
$A7:C9ED 60          RTS
}


;;; $C9EE: Restrict Samus X position to first screen ;;;
{
$A7:C9EE AD F6 0A    LDA $0AF6  [$82:0AF6]  ;\
$A7:C9F1 38          SEC                    ;|
$A7:C9F2 E9 00 01    SBC #$0100             ;} If [Samus X position] >= 100h:
$A7:C9F5 30 09       BMI $09    [$CA00]     ;/
$A7:C9F7 A9 00 01    LDA #$0100             ;\
$A7:C9FA 8D F6 0A    STA $0AF6  [$82:0AF6]  ;} Samus X position = previous Samus X position = 100h
$A7:C9FD 8D 10 0B    STA $0B10  [$82:0B10]  ;/

$A7:CA00 60          RTS
}
}


;;; $CA01..E7FD: Phantoon ;;;
{
;;; $CA01..CDF2: Phantoon data ;;;
{
;;; $CA01: Palette - enemy $E4BF/$E4FF/$E53F/$E57F (Phantoon) ;;;
{
$A7:CA01             dw 3800, 7FFF, 7EC0, 6DE0, 54E0, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $CA21: Palettes ;;;
{
; Unused. Clone of $CC21
$A7:CA21             dw 0000,477B,2E52,00C6,0063,3AB5,2210,116B,0508,7FFF,36B5,19AD,0929,381D,1814,000A

; Fade out target palette
$A7:CA41             dw 0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000

; Wrecked Ship powered on BG1/2 target palettes 0..6 (same as SCE)
$A7:CA61             dw 0000,02DF,01D7,00AC,5EBB,3DB3,292E,1486,0BB1,48FB,7FFF,0000,7FFF,44E5,7FFF,0000
                        2003,0BB1,1EA9,0145,5EBB,3DB3,292E,1486,6318,1CE7,1084,0000,7FFF,02DF,001F,0000
                        2003,72BC,48FB,1816,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,7FFF,0000
                        0000,72B2,71C7,4D03,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,7FFF,0000
                        0000,3EF4,262E,0D68,3E94,25CE,0D08,1484,6E94,55CE,3D08,2C84,1EA9,0BB1,7FFF,0000
                        0000,1246,0145,00C0,3652,1D8C,04C6,0484,6231,496B,30A5,2021,0015,025B,7FFF,0000
                        0000,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,6318,7FFF,0000

; Health based palettes
$A7:CB41             dw 000E,25DC,1538,0071,0030,1D79,1117,08B4,0092,421F,1D79,0CF5,0493,1C1D,0C19,0013 ; Health <= 312
$A7:CB61             dw 000C,2A1C,1957,0070,002E,2199,1136,08D3,0091,4A5F,1D99,0CF4,04B1,201D,0C18,0012 ; Health > 312
$A7:CB81             dw 000A,2E5C,1D96,008E,004C,25D8,1555,08F1,00AF,529F,21D8,1113,04D0,241D,1017,0011 ; Health > 624
$A7:CBA1             dw 0008,327C,21B5,008C,004A,29F7,1574,0D10,00AE,5ADF,25F7,1131,04CE,281D,1016,000F ; Health > 936
$A7:CBC1             dw 0006,36BB,21D4,008B,0048,2E17,1993,0D0F,00CC,631F,2A17,1150,04ED,2C1D,1016,000E ; Health > 1248
$A7:CBE1             dw 0004,3AFB,25F3,00A9,0046,3256,1DB2,0D2D,00EB,6B5F,2E56,156F,04EB,301D,1415,000C ; Health > 1560
$A7:CC01             dw 0002,3F3B,2A12,00A7,0044,3675,1DF1,0D4C,04E9,77BF,3275,158E,050A,341D,1414,000B ; Health > 1872
$A7:CC21             dw 0000,477B,2E52,00C6,0063,3AB5,2210,116B,0508,7FFF,36B5,19AD,0929,381D,1814,000A ; Health > 2184
}


;;; $CC41..FC: Instruction lists - Phantoon ;;;
{
;;; $CC41: Instruction list - body - invulnerable ;;;
{
$A7:CC41             dx 0001,DEDD,
                        812F        ; Sleep
}


;;; $CC47: Instruction list - body - full hitbox ;;;
{
$A7:CC47             dx 0001,DEE7,
                        812F        ; Sleep
}


;;; $CC4D: Instruction list - body - eye hitbox only ;;;
{
$A7:CC4D             dx 0001,DEF1,
                        812F        ; Sleep
}


;;; $CC53: Instruction list - eye - open ;;;
{
$A7:CC53             dx 000A,DF05,
                        000A,DF0F,
                        0001,DF19,
                        808A,CEED,  ; Play Phantoon materialisation sound effect
                        808A,D03F,  ; Set up eye open Phantoon state
                        812F        ; Sleep
}


;;; $CC69: Unused. Instruction list - open (ignoring Samus) ;;;
{
$A7:CC69             dx 000A,DF05,
                        000A,DF0F,
                        0001,DF19,
                        808A,CEED,  ; Play Phantoon materialisation sound effect
                        812F        ; Sleep
}


;;; $CC7B: Instruction list - eye - closed ;;;
{
$A7:CC7B             dx 0001,DEFB,
                        812F        ; Sleep
}


;;; $CC81: Instruction list - eye - close and pick new pattern ;;;
{
$A7:CC81             dx 0001,DF19,
                        000A,DF0F,
                        808A,D076,  ; Pick new Phantoon pattern
                        80ED,CC7B   ; Go to $CC7B (eye - closed)
}


;;; $CC91: Instruction list - eye - close ;;;
{
$A7:CC91             dx 0001,DF19,
                        000A,DF0F,
                        80ED,CC7B   ; Go to $CC7B (eye - closed)
}


;;; $CC9D: Instruction list - eyeball - centred ;;;
{
$A7:CC9D             dx 0001,DF23,
                        808A,CEED,  ; Play Phantoon materialisation sound effect
                        812F        ; Sleep
}


;;; $CCA7: Instruction list - eyeball - looking up ;;;
{
$A7:CCA7             dx 0001,DF2D,
                        812F        ; Sleep
}


;;; $CCAD: Instruction list - eyeball - looking up-right ;;;
{
$A7:CCAD             dx 0001,DF73,
                        812F        ; Sleep
}


;;; $CCB3: Instruction list - eyeball - looking right ;;;
{
$A7:CCB3             dx 0001,DF4B,
                        812F        ; Sleep
}


;;; $CCB9: Instruction list - eyeball - looking down-right ;;;
{
$A7:CCB9             dx 0001,DF5F,
                        812F        ; Sleep
}


;;; $CCBF: Instruction list - eyeball - looking down ;;;
{
$A7:CCBF             dx 0001,DF37,
                        812F        ; Sleep
}


;;; $CCC5: Instruction list - eyeball - looking down-left ;;;
{
$A7:CCC5             dx 0001,DF55,
                        812F        ; Sleep
}


;;; $CCCB: Instruction list - eyeball - looking left ;;;
{
$A7:CCCB             dx 0001,DF41,
                        812F        ; Sleep
}


;;; $CCD1: Instruction list - eyeball - looking up-left ;;;
{
$A7:CCD1             dx 0001,DF69,
                        812F        ; Sleep
}


;;; $CCD7: Instruction list - tentacles ;;;
{
$A7:CCD7             dx 0008,DFB3,
                        0008,DFC5,
                        0008,DFD7,
                        0008,DFC5,
                        80ED,CCD7   ; Go to $CCD7
}


;;; $CCEB: Instruction list - mouth - spawn flame ;;;
{
$A7:CCEB             dx 0005,DFFD,
                        0005,DFF3,
                        808A,CF5E   ; Spawn casual flame
}


;;; $CCF7: Instruction list - mouth - initial ;;;
{
$A7:CCF7             dx 0001,DFE9,
                        812F        ; Sleep
}
}


;;; $CCFD: Casual flame timers ;;;
{
; List of pattern pointers
$A7:CCFD             dw CD05, CD13, CD1D, CD2F

;                        _______ Number of flames (length of pattern)
;                       |      _ Timers. List is read backwards
;                       |     |
$A7:CD05             dw 0005, 00B4,0020,0020,0020,0020,0020
$A7:CD13             dw 0003, 00B4,0010,0010,0010
$A7:CD1D             dw 0007, 00B4,0030,0030,0030,0030,0030,0030,0030
$A7:CD2F             dw 0007, 00B4,0010,0040,0020,0040,0020,0010,0020
}


;;; $CD41: Phantoon figure-8 vulnerable window timers ;;;
{
$A7:CD41             dw 003C, 001E, 000F, 001E, 003C, 001E, 000F, 003C
}


;;; $CD51: Empty HDMA table ;;;
{
$A7:CD51             db 00,00
}


;;; $CD53: Phantoon eye closed timers ;;;
{
$A7:CD53             dw 02D0, 003C, 0168, 02D0, 0168, 003C, 0168, 02D0
}


;;; $CD63: Flame rain Phantoon hiding timers ;;;
{
$A7:CD63             dw 003C, 0078, 001E, 003C, 001E, 003C, 001E, 001E
}


;;; $CD73: Figure-8 Phantoon acceleration ;;;
{
;                        _________ Subacceleration
;                       |      ___ Acceleration
;                       |     |
$A7:CD73             dw 0600, 0000 ; Slow stage
$A7:CD77             dw 1000, 0000 ; Fast stages
}


;;; $CD7B: Figure-8 speed caps ;;;
{
$A7:CD7B             dw 0002 ; Movement stage 0 max speed
$A7:CD7D             dw 0007 ; Movement stage 1 max speed
$A7:CD7F             dw 0000 ; Movement stage 2 min speed
}


;;; $CD81: Reverse figure-8 Phantoon acceleration ;;;
{
; Clone of $CD73

;                        _________ Subacceleration
;                       |      ___ Acceleration
;                       |     |
$A7:CD81             dw 0600, 0000 ; Slow stage
$A7:CD85             dw 1000, 0000 ; Fast stages
}


;;; $CD89: Reverse figure-8 speed caps ;;;
{
$A7:CD89             dw FFFE ; Movement stage 0 max speed
$A7:CD8B             dw FFF9 ; Movement stage 1 max speed
$A7:CD8D             dw 0000 ; Movement stage 2 min speed
}


;;; $CD8F: Unused ;;;
{
$A7:CD8F             dw 8000, 0000, 000B,
                        8000, 0000, FFF5
}


;;; $CD9B: Wavy Phantoon constants ;;;
{
$A7:CD9B             dw 0040 ; Amplitude delta - intro wavy Phantoon
$A7:CD9D             dw 0C00 ; Max amplitude - intro wavy Phantoon
$A7:CD9F             dw 0100 ; Amplitude delta - dying wavy Phantoon
$A7:CDA1             dw F000 ; Max amplitude - dying wavy Phantoon
$A7:CDA3             dw 0008 ; Wavy Phantoon phase delta
}


;;; $CDA5: Values for $0FEA ;;;
{
; Unknown purpose, $0FEA is never read, written by Phantoon enemy shot
$A7:CDA5             db 06, 06, 08, 08, 06, 08, 06, 08
}


;;; $CDAD: Phantoon position table for flame rain ;;;
{
;                        _____________________ Phantoon figure-8 movement index
;                       |      _______________ X position
;                       |     |      _________ Y position
;                       |     |     |
$A7:CDAD             dw 0001, 0080, 0060, 0000,
                        0047, 00A8, 0040, 0000,
                        0088, 00D0, 0060, 0000,
                        00C9, 00A8, 0080, 0000,
                        0001, 0080, 0060, 0000,
                        014E, 0058, 0040, 0000,
                        018F, 0030, 0060, 0000,
                        01D1, 0058, 0080, 0000
}


;;; $CDED: Materialisation sound effects ;;;
{
; Sound library 2
; Indexed by [$7E:9032] * 2
$A7:CDED             dw 0079, 007A, 007B
}
}


;;; $CDF3: Initialisation AI - enemy $E4BF (Phantoon body) ;;;
{
$A7:CDF3 A2 FE 0F    LDX #$0FFE             ;\
$A7:CDF6 A9 38 03    LDA #$0338             ;|
                                            ;|
$A7:CDF9 9F 00 20 7E STA $7E2000,x[$7E:2FFE];} $7E:2000..2FFF = 0338h (BG2 tilemap)
$A7:CDFD CA          DEX                    ;|
$A7:CDFE CA          DEX                    ;|
$A7:CDFF 10 F8       BPL $F8    [$CDF9]     ;/
$A7:CE01 A2 FE 07    LDX #$07FE             ;\
$A7:CE04 A9 00 00    LDA #$0000             ;|
                                            ;|
$A7:CE07 9F 00 90 7E STA $7E9000,x[$7E:97FE];} $7E:9000..97FF = 0
$A7:CE0B CA          DEX                    ;|
$A7:CE0C CA          DEX                    ;|
$A7:CE0D 10 F8       BPL $F8    [$CE07]     ;/
$A7:CE0F A2 1E 00    LDX #$001E             ;\
$A7:CE12 A9 00 00    LDA #$0000             ;|
                                            ;|
$A7:CE15 9F E0 C2 7E STA $7EC2E0,x[$7E:C2FE];} Target BG1/2 palette 7 = 0
$A7:CE19 CA          DEX                    ;|
$A7:CE1A CA          DEX                    ;|
$A7:CE1B 10 F8       BPL $F8    [$CE15]     ;/
$A7:CE1D A9 60 03    LDA #$0360             ;\
$A7:CE20 8F 9A 17 00 STA $00179A[$7E:179A]  ;} Enemy BG2 tilemap size = 360h
$A7:CE24 22 E2 A7 90 JSL $90A7E2[$90:A7E2]  ; Disable mini-map and mark boss room map tiles as explored
$A7:CE28 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A7:CE2B A9 78 00    LDA #$0078             ;\
$A7:CE2E 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy function timer = 78h
$A7:CE31 9E A8 0F    STZ $0FA8,x[$7E:0FA8]  ; Phantoon flame counter = 0
$A7:CE34 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Phantoon starting flames activation flag = 0
$A7:CE37 A9 00 00    LDA #$0000             ;\
$A7:CE3A 8F 32 90 7E STA $7E9032[$7E:9032]  ;} >_<;
$A7:CE3E 9C F4 0F    STZ $0FF4  [$7E:0FF4]  ;\
$A7:CE41 9C F6 0F    STZ $0FF6  [$7E:0FF6]  ;} >_<;
$A7:CE44 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:CE47 09 00 04    ORA #$0400             ;} Set Phantoon body as intangible
$A7:CE4A 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:CE4D 22 35 84 88 JSL $888435[$88:8435]  ;\
$A7:CE51             dx 01, 14, CE96        ;} Spawn HDMA object with instruction list $CE96 (control and target are irrelevant)
}


;;; $CE55: Initialisation AI - enemy $E4FF/$E53F/$E57F (Phantoon eye / tentacles / mouth) ;;;
{
; Phantoon body also executes this as part of initialisation AI, so all Phantoon parts are doing this
$A7:CE55 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:CE58 A9 4D 80    LDA #$804D             ;\
$A7:CE5B 9D 8E 0F    STA $0F8E,x[$7E:0F8E]  ;} Enemy spritemap pointer = $804D (nothing)
$A7:CE5E A9 01 00    LDA #$0001             ;\
$A7:CE61 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A7:CE64 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A7:CE67 AD 96 0F    LDA $0F96  [$7E:0F96]  ;\
$A7:CE6A 9D 96 0F    STA $0F96,x[$7E:0F96]  ;} Enemy palette index = [enemy 0 palette index]
$A7:CE6D AD 98 0F    LDA $0F98  [$7E:0F98]  ;\
$A7:CE70 9D 98 0F    STA $0F98,x[$7E:0F98]  ;} Enemy VRAM tiles index = [enemy 0 VRAM tiles index]
$A7:CE73 BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$A7:CE76 0A          ASL A                  ;|
$A7:CE77 A8          TAY                    ;} Enemy instruction list pointer = [$CE8E + [enemy parameter 2] * 2]
$A7:CE78 B9 8E CE    LDA $CE8E,y[$A7:CE8E]  ;|
$A7:CE7B 9D 92 0F    STA $0F92,x[$7E:0F92]  ;/
$A7:CE7E A9 A9 D4    LDA #$D4A9             ;\
$A7:CE81 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D4A9 (presumably only matters for enemy 0)
$A7:CE84 9C 74 10    STZ $1074  [$7E:1074]  ; Phantoon semi-transparency HDMA object control = 0 (BG2 disabled)
$A7:CE87 A9 FF FF    LDA #$FFFF             ;\
$A7:CE8A 8D 6C 10    STA $106C  [$7E:106C]  ;} Phantoon casual flame pattern index = -1
$A7:CE8D 6B          RTL

; Instruction list pointers
$A7:CE8E             dw CC41, ; Body
                        CC7B, ; Eye
                        CCD7, ; Tentacles
                        CCF7  ; Mouth
}


;;; $CE96: HDMA object instruction list - Phantoon semi-transparency ;;;
{
$A7:CE96             dx 8655,A7,    ; HDMA table bank = $A7
                        0001,CD51,
                        8570,88E449,; Pre-instruction = $88:E449
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $CEA6: Main AI - enemy $E4BF (Phantoon) ;;;
{
; Phantoon code is making a trend of returning if the current enemy index is not 0, then using indexed addressing anyway,
; and these routines are only called for enemy 0 in the first place >_<;

$A7:CEA6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:CEA9 20 0C CF    JSR $CF0C  [$A7:CF0C]  ; Broken nothingness
$A7:CEAC F4 B1 CE    PEA $CEB1              ;\
$A7:CEAF 7C B2 0F    JMP ($0FB2,x)[$A7:D4A9];} Execute [Phantoon function]

$A7:CEB2 8A          TXA                    ;\
$A7:CEB3 D0 37       BNE $37    [$CEEC]     ;} >_<;
$A7:CEB5 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A7:CEB8 9D BA 0F    STA $0FBA,x[$7E:0FBA]  ;|
$A7:CEBB 9D FA 0F    STA $0FFA,x[$7E:0FFA]  ;} Phantoon X positions = [Phantoon body X position]
$A7:CEBE 9D 3A 10    STA $103A,x[$7E:103A]  ;/
$A7:CEC1 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A7:CEC4 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;|
$A7:CEC7 9D FE 0F    STA $0FFE,x[$7E:0FFE]  ;} Phantoon Y positions = [Phantoon body Y position]
$A7:CECA 9D 3E 10    STA $103E,x[$7E:103E]  ;/
$A7:CECD AD F4 0F    LDA $0FF4  [$7E:0FF4]  ;\
$A7:CED0 D0 1A       BNE $1A    [$CEEC]     ;} If wavy Phantoon is disabled:
$A7:CED2 AD 11 09    LDA $0911  [$7E:0911]  ;\
$A7:CED5 38          SEC                    ;|
$A7:CED6 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$A7:CED9 38          SEC                    ;} BG2 X scroll = [layer 1 X position] - [Phantoon X position] + 28h
$A7:CEDA E9 D8 FF    SBC #$FFD8             ;|
$A7:CEDD 85 B5       STA $B5    [$7E:00B5]  ;/
$A7:CEDF AD 15 09    LDA $0915  [$7E:0915]  ;\
$A7:CEE2 38          SEC                    ;|
$A7:CEE3 FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;} BG2 Y scroll = [layer 1 Y position] - [Phantoon Y position] + 28h
$A7:CEE6 38          SEC                    ;|
$A7:CEE7 E9 D8 FF    SBC #$FFD8             ;|
$A7:CEEA 85 B7       STA $B7    [$7E:00B7]  ;/

$A7:CEEC 6B          RTL
}


;;; $CEED: Play Phantoon materialisation sound effect ;;;
{
$A7:CEED AF 32 90 7E LDA $7E9032[$7E:9032]  ;\
$A7:CEF1 0A          ASL A                  ;|
$A7:CEF2 A8          TAY                    ;} Queue sound [$CDED + [Phantoon materialisation sound effect index] * 2], sound library 2, max queued sounds allowed = 6
$A7:CEF3 B9 ED CD    LDA $CDED,y[$A7:CDED]  ;|
$A7:CEF6 22 CB 90 80 JSL $8090CB[$80:90CB]  ;/
$A7:CEFA AF 32 90 7E LDA $7E9032[$7E:9032]  ;\
$A7:CEFE 1A          INC A                  ;|
$A7:CEFF C9 03 00    CMP #$0003             ;|
$A7:CF02 30 03       BMI $03    [$CF07]     ;} Phantoon materialisation sound effect index = ([Phantoon materialisation sound effect index] + 1) % 3
$A7:CF04 A9 00 00    LDA #$0000             ;|
                                            ;|
$A7:CF07 8F 32 90 7E STA $7E9032[$7E:9032]  ;/
$A7:CF0B 60          RTS
}


;;; $CF0C: Broken nothingness ;;;
{
; This code doesn't do anything, it tries to modify $7E:9030 and forgot the $7E bit... and $7E:9030 is never read anywhere anyway
$A7:CF0C 8A          TXA                    ;\
$A7:CF0D D0 17       BNE $17    [$CF26]     ;} >_<;
$A7:CF0F A5 8F       LDA $8F    [$7E:008F]  ;\
$A7:CF11 89 00 40    BIT #$4000             ;} If not newly pressing Y: return
$A7:CF14 F0 10       BEQ $10    [$CF26]     ;/
$A7:CF16 BD 30 90    LDA $9030,x[$A7:9030]  ;\
$A7:CF19 D0 08       BNE $08    [$CF23]     ;} If [$9030] = 0:
$A7:CF1B A9 01 00    LDA #$0001             ;\
$A7:CF1E 9D 30 90    STA $9030,x            ;} $9030 = 1
$A7:CF21 80 03       BRA $03    [$CF26]
                                            ; Else ([$9030] != 0):
$A7:CF23 9E 30 90    STZ $9030,x[$A7:9030]  ; $9030 = 0

$A7:CF26 60          RTS
}


;;; $CF27: Grow/shrink Phantoon wave amplitude ;;;
{
;; Parameters:
;;     $12: Amplitude delta
;;     $14: Max amplitude
;; Returns:
;;     Carry: Set if completed wave cycle (amplitude has decreased below 0)
$A7:CF27 AD 70 10    LDA $1070  [$7E:1070]  ;\
$A7:CF2A D0 20       BNE $20    [$CF4C]     ;} If [wavy Phantoon phase delta direction] = growing:
$A7:CF2C A5 14       LDA $14    [$7E:0014]
$A7:CF2E 29 00 FF    AND #$FF00
$A7:CF31 EB          XBA
$A7:CF32 85 16       STA $16    [$7E:0016]
$A7:CF34 AD 6E 10    LDA $106E  [$7E:106E]  ;\
$A7:CF37 18          CLC                    ;|
$A7:CF38 65 12       ADC $12    [$7E:0012]  ;} Wavy Phantoon amplitude += [$12]
$A7:CF3A 8D 6E 10    STA $106E  [$7E:106E]  ;/
$A7:CF3D 29 00 FF    AND #$FF00             ;\
$A7:CF40 EB          XBA                    ;|
$A7:CF41 C5 16       CMP $16    [$7E:0016]  ;} If [wavy Phantoon amplitude] / 100h < [$14] / 100h: return carry clear
$A7:CF43 30 17       BMI $17    [$CF5C]     ;/
$A7:CF45 A5 14       LDA $14    [$7E:0014]  ;\
$A7:CF47 8D 6E 10    STA $106E  [$7E:106E]  ;} Wavy Phantoon amplitude = [$14]
$A7:CF4A 80 10       BRA $10    [$CF5C]     ; Return carry clear

$A7:CF4C AD 6E 10    LDA $106E  [$7E:106E]  ;\
$A7:CF4F 38          SEC                    ;|
$A7:CF50 E5 12       SBC $12    [$7E:0012]  ;} Wavy Phantoon amplitude -= [$12]
$A7:CF52 8D 6E 10    STA $106E  [$7E:106E]  ;/
$A7:CF55 B0 05       BCS $05    [$CF5C]     ; If [wavy Phantoon amplitude] >= 0: return carry clear
$A7:CF57 9C 6E 10    STZ $106E  [$7E:106E]  ; Wavy Phantoon amplitude = 0
$A7:CF5A 38          SEC                    ;\
$A7:CF5B 60          RTS                    ;} Return carry set

$A7:CF5C 18          CLC
$A7:CF5D 60          RTS
}


;;; $CF5E: Spawn casual flame ;;;
{
$A7:CF5E A9 00 00    LDA #$0000             ; A = 0
$A7:CF61 A0 29 9C    LDY #$9C29             ;\
$A7:CF64 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Phantoon destroyable flames enemy projectile
$A7:CF68 A9 1D 00    LDA #$001D             ;\
$A7:CF6B 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1Dh, sound library 3, max queued sounds allowed = 6 (Phantoon's flame)
$A7:CF6F 60          RTS
}


;;; $CF70: Phantoon materialisation flame spiral ;;;
{
$A7:CF70 A0 07 00    LDY #$0007             ; Y = 8

; LOOP
$A7:CF73 5A          PHY                    ;\
$A7:CF74 98          TYA                    ;|
$A7:CF75 09 00 06    ORA #$0600             ;|
$A7:CF78 A0 29 9C    LDY #$9C29             ;} Spawn Phantoon destroyable flames enemy projectile with parameter 600h | [Y]
$A7:CF7B 22 27 80 86 JSL $868027[$86:8027]  ;|
$A7:CF7F 7A          PLY                    ;/
$A7:CF80 88          DEY                    ; Decrement Y
$A7:CF81 10 F0       BPL $F0    [$CF73]     ; If [Y] >= 0: go to LOOP

$A7:CF83 A9 28 00    LDA #$0028             ;\
$A7:CF86 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 28h, sound library 3, max queued sounds allowed = 6 (Phantoon materialises attack)
$A7:CF8A 60          RTS
}


;;; $CF8B: Spawn flame rain enemy projectiles ;;;
{
;; Parameter:
;;     A: Pattern index. Range 0..7. Decides the placement of the first flame

; Uses a lookup table ($CFC2) to determine where to leave a gap.
;
; When called from $D7F7, the following patterns result:
;
; [A] | Value | Fireball pattern
; ----+-------+-----------------
; 0   | 5     | @@@@@@.@@
; 1   | 7     | @@@@@@@@.
; 2   | 0     | .@@@@@@@@
; 3   | 7     | @@@@@@@@.
; 4   | 5     | @@@@@@.@@
; 5   | 3     | @@@@.@@@@
; 6   | 1     | @@.@@@@@@
; 7   | 3     | @@@@.@@@@
;
$A7:CF8B A8          TAY                    ;\
$A7:CF8C B9 C2 CF    LDA $CFC2,y[$A7:CFC4]  ;|
$A7:CF8F 29 FF 00    AND #$00FF             ;} Y = [$CFC2 + [A]] (position)
$A7:CF92 A8          TAY                    ;/
$A7:CF93 A9 07 00    LDA #$0007             ;\
$A7:CF96 85 12       STA $12    [$7E:0012]  ;} $12 = 7 (loop counter)
$A7:CF98 A9 10 00    LDA #$0010             ;\
$A7:CF9B 85 14       STA $14    [$7E:0014]  ;} $14 = 10h (fall time / 8 << 4)

; LOOP
$A7:CF9D 98          TYA                    ;\
$A7:CF9E 09 00 04    ORA #$0400             ;|
$A7:CFA1 05 14       ORA $14    [$7E:0014]  ;} A = 400h | [$14] | [Y]
$A7:CFA3 5A          PHY                    ;\
$A7:CFA4 A0 29 9C    LDY #$9C29             ;|
$A7:CFA7 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Phantoon destroyable flames enemy projectile
$A7:CFAB 7A          PLY                    ;/
$A7:CFAC C8          INY                    ;\
$A7:CFAD C0 09 00    CPY #$0009             ;|
$A7:CFB0 30 03       BMI $03    [$CFB5]     ;} Y = ([Y] + 1) % 9:
$A7:CFB2 A0 00 00    LDY #$0000             ;/

$A7:CFB5 A5 14       LDA $14    [$7E:0014]  ;\
$A7:CFB7 18          CLC                    ;|
$A7:CFB8 69 10 00    ADC #$0010             ;} $14 += 10h
$A7:CFBB 85 14       STA $14    [$7E:0014]  ;/
$A7:CFBD C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$A7:CFBF 10 DC       BPL $DC    [$CF9D]     ; If [$12] > 0: go to LOOP
$A7:CFC1 60          RTS

; Position of first flame
$A7:CFC2             db 05, 07, 00, 07, 05, 03, 01, 03
}


;;; $CFCA: Handle casual flames ;;;
{
$A7:CFCA DE 6A 10    DEC $106A,x[$7E:106A]  ; Decrement Phantoon casual flame timer
$A7:CFCD F0 02       BEQ $02    [$CFD1]     ;\
$A7:CFCF 10 6D       BPL $6D    [$D03E]     ;} If [Phantoon casual flame timer] > 0: return

$A7:CFD1 BD 6C 10    LDA $106C,x[$7E:106C]  ;\
$A7:CFD4 10 26       BPL $26    [$CFFC]     ;} If [Phantoon casual flame pattern index] < 0:
$A7:CFD6 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A7:CFDA 29 03 00    AND #$0003             ;\
$A7:CFDD 9D 68 10    STA $1068,x[$7E:1068]  ;} Phantoon casual flame pattern = [random number] % 4
$A7:CFE0 0A          ASL A                  ;\
$A7:CFE1 A8          TAY                    ;|
$A7:CFE2 B9 FD CC    LDA $CCFD,y[$A7:CD03]  ;|
$A7:CFE5 A8          TAY                    ;} Phantoon casual flame pattern index = [[$CCFD + [Phantoon casual flame pattern] * 2]]
$A7:CFE6 B9 00 00    LDA $0000,y[$A7:CD2F]  ;|
$A7:CFE9 9D 6C 10    STA $106C,x[$7E:106C]  ;/
$A7:CFEC 0A          ASL A                  ;\
$A7:CFED 85 12       STA $12    [$7E:0012]  ;|
$A7:CFEF 98          TYA                    ;|
$A7:CFF0 18          CLC                    ;|
$A7:CFF1 65 12       ADC $12    [$7E:0012]  ;} Phantoon casual flame timer = [[$CCFD + [Phantoon casual flame pattern] * 2] + 2 + [Phantoon casual flame pattern index] * 2]
$A7:CFF3 A8          TAY                    ;|
$A7:CFF4 B9 02 00    LDA $0002,y[$A7:CD3F]  ;|
$A7:CFF7 9D 6A 10    STA $106A,x[$7E:106A]  ;/
$A7:CFFA 80 42       BRA $42    [$D03E]     ; Return

$A7:CFFC DE 6C 10    DEC $106C,x[$7E:106C]  ; Decrement Phantoon casual flame pattern index
$A7:CFFF F0 02       BEQ $02    [$D003]     ;\
$A7:D001 10 17       BPL $17    [$D01A]     ;} If [Phantoon casual flame pattern index] <= 0:
$A7:D003 A9 FF FF    LDA #$FFFF             ;\
$A7:D006 9D 6C 10    STA $106C,x[$7E:106C]  ;} Phantoon casual flame pattern index = FFFFh
$A7:D009 BD 68 10    LDA $1068,x[$7E:1068]  ;\
$A7:D00C 0A          ASL A                  ;|
$A7:D00D A8          TAY                    ;|
$A7:D00E B9 FD CC    LDA $CCFD,y[$A7:CD03]  ;} Phantoon casual flame timer = [[$CCFD + [Phantoon casual flame pattern] * 2] + 2]
$A7:D011 A8          TAY                    ;|
$A7:D012 B9 02 00    LDA $0002,y[$A7:CD31]  ;|
$A7:D015 9D 6A 10    STA $106A,x[$7E:106A]  ;/
$A7:D018 80 18       BRA $18    [$D032]

$A7:D01A BD 6C 10    LDA $106C,x[$7E:106C]  ;\ Else ([Phantoon casual flame pattern index] > 0):
$A7:D01D 0A          ASL A                  ;|
$A7:D01E 85 12       STA $12    [$7E:0012]  ;|
$A7:D020 BD 68 10    LDA $1068,x[$7E:1068]  ;|
$A7:D023 0A          ASL A                  ;|
$A7:D024 A8          TAY                    ;|
$A7:D025 B9 FD CC    LDA $CCFD,y[$A7:CD03]  ;} Phantoon casual flame timer = [[$CCFD + [Phantoon casual flame pattern] * 2] + 2 + [Phantoon casual flame pattern index] * 2]
$A7:D028 18          CLC                    ;|
$A7:D029 65 12       ADC $12    [$7E:0012]  ;|
$A7:D02B A8          TAY                    ;|
$A7:D02C B9 02 00    LDA $0002,y[$A7:CD3D]  ;|
$A7:D02F 9D 6A 10    STA $106A,x[$7E:106A]  ;/

$A7:D032 A9 01 00    LDA #$0001             ;\
$A7:D035 9D 54 10    STA $1054,x[$7E:1054]  ;} Phantoon mouth instruction timer = 1
$A7:D038 A9 EB CC    LDA #$CCEB             ;\
$A7:D03B 9D 52 10    STA $1052,x[$7E:1052]  ;} Phantoon mouth instruction list pointer = $CCEB (spawn flame)

$A7:D03E 60          RTS
}


;;; $D03F: Set up eye open Phantoon state ;;;
{
$A7:D03F 9C 28 10    STZ $1028  [$7E:1028]  ; Clear swooping flag
$A7:D042 A9 01 00    LDA #$0001             ;\
$A7:D045 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Phantoon body instruction timer = 1
$A7:D048 8D D4 0F    STA $0FD4  [$7E:0FD4]  ; Phantoon eye instruction timer = 1
$A7:D04B A9 4D CC    LDA #$CC4D             ;\
$A7:D04E 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Phantoon body instruction list pointer = $CC4D (eye hitbox only)
$A7:D051 A9 9D CC    LDA #$CC9D             ;\
$A7:D054 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Phantoon eye instruction list pointer = $CC9D (eyeball - centred)
$A7:D057 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:D05A 29 FF FB    AND #$FBFF             ;} Set Phantoon body as tangible
$A7:D05D 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:D060 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A7:D064 29 07 00    AND #$0007             ;\
$A7:D067 0A          ASL A                  ;|
$A7:D068 A8          TAY                    ;} Phantoon function timer = [$CD41 + [random number] % 8 * 2]
$A7:D069 B9 41 CD    LDA $CD41,y[$A7:CD4F]  ;|
$A7:D06C 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;/
$A7:D06F A9 0D D6    LDA #$D60D             ;\
$A7:D072 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Phantoon function = $D60D (figure-8 - vulnerable window)
$A7:D075 60          RTS
}


;;; $D076: Pick new Phantoon pattern ;;;
{
; When called by $D6E2 (hiding before figure-8 - place Phantoon), the Phantoon function set here is ignored,
; it is only used by the call from the Phantoon eye instruction list $CC81 (close and pick new pattern)
$A7:D076 A9 3C 00    LDA #$003C             ;\
$A7:D079 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} Phantoon function timer = 60
$A7:D07C 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A7:D080 29 07 00    AND #$0007             ;\
$A7:D083 0A          ASL A                  ;|
$A7:D084 A8          TAY                    ;} Phantoon eye timer = [$CD53 + [random number] % 8 * 2]
$A7:D085 B9 53 CD    LDA $CD53,y[$A7:CD5B]  ;|
$A7:D088 8D E8 0F    STA $0FE8  [$7E:0FE8]  ;/ 
$A7:D08B AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A7:D08E 89 01 00    BIT #$0001             ;} If [frame counter] % 2 != 0: go to BRANCH_REVERSED
$A7:D091 D0 25       BNE $25    [$D0B8]     ;/
$A7:D093 AD EC 0F    LDA $0FEC  [$7E:0FEC]  ;\
$A7:D096 F0 0F       BEQ $0F    [$D0A7]     ;} If Phantoon movement is reversed:
$A7:D098 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:D09B 1A          INC A                  ;|
$A7:D09C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;|
$A7:D09F C9 16 02    CMP #$0216             ;} Phantoon movement index = ([Phantoon movement index] + 1) % 216h
$A7:D0A2 30 03       BMI $03    [$D0A7]     ;|
$A7:D0A4 9C A8 0F    STZ $0FA8  [$7E:0FA8]  ;/

$A7:D0A7 A9 01 00    LDA #$0001             ;\
$A7:D0AA 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Phantoon speed = 1.0
$A7:D0AD 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;/
$A7:D0B0 9C AE 0F    STZ $0FAE  [$7E:0FAE]  ; Phantoon movement stage = 0
$A7:D0B3 9C EC 0F    STZ $0FEC  [$7E:0FEC]  ; Phantoon reversed movement flag = 0
$A7:D0B6 80 23       BRA $23    [$D0DB]     ; Go to BRANCH_MERGE

; BRANCH_REVERSED
$A7:D0B8 AD EC 0F    LDA $0FEC  [$7E:0FEC]  ;\
$A7:D0BB D0 0F       BNE $0F    [$D0CC]     ;} If Phantoon movement is not reversed:
$A7:D0BD AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:D0C0 3A          DEC A                  ;|
$A7:D0C1 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;|
$A7:D0C4 10 06       BPL $06    [$D0CC]     ;} Phantoon movement index = ([Phantoon movement index] - 1) % 216h
$A7:D0C6 A9 15 02    LDA #$0215             ;|
$A7:D0C9 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;/

$A7:D0CC 9C AC 0F    STZ $0FAC  [$7E:0FAC]  ;\
$A7:D0CF 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;} Phantoon speed = 0.0
$A7:D0D2 9C AE 0F    STZ $0FAE  [$7E:0FAE]  ; Phantoon movement stage = 0
$A7:D0D5 A9 01 00    LDA #$0001             ;\
$A7:D0D8 8D EC 0F    STA $0FEC  [$7E:0FEC]  ;} Phantoon reversed movement flag = 1

; BRANCH_MERGE
$A7:D0DB AD B6 0F    LDA $0FB6  [$7E:0FB6]  ;\
$A7:D0DE D0 07       BNE $07    [$D0E7]     ;} If flame rain now triggered:
$A7:D0E0 A9 E7 D5    LDA #$D5E7             ;\
$A7:D0E3 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Phantoon function = $D5E7 (figure-8)
$A7:D0E6 60          RTS                    ; Return

$A7:D0E7 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:D0EA A9 2A D8    LDA #$D82A             ;\
$A7:D0ED 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Phantoon function = $D82A (flame rain)
$A7:D0F0 60          RTS
}


;;; $D0F1: Adjust speed and move Phantoon in figure-8 ;;;
{
$A7:D0F1 AD EC 0F    LDA $0FEC  [$7E:0FEC]  ;\
$A7:D0F4 D0 0F       BNE $0F    [$D105]     ;} If Phantoon movement is not reversed:
$A7:D0F6 20 14 D1    JSR $D114  [$A7:D114]  ; Update figure-8 Phantoon speed
$A7:D0F9 A0 D2 E3    LDY #$E3D2             ;\
$A7:D0FC A9 16 02    LDA #$0216             ;|
$A7:D0FF 85 14       STA $14    [$7E:0014]  ;} Move Phantoon in figure-8
$A7:D101 20 15 D2    JSR $D215  [$A7:D215]  ;/
$A7:D104 60          RTS                    ; Return

$A7:D105 20 93 D1    JSR $D193  [$A7:D193]  ; Update reversed figure-8 Phantoon speed
$A7:D108 A0 D2 E3    LDY #$E3D2             ;\
$A7:D10B A9 15 02    LDA #$0215             ;|
$A7:D10E 85 14       STA $14    [$7E:0014]  ;} Move Phantoon in reverse figure-8
$A7:D110 20 71 D2    JSR $D271  [$A7:D271]  ;/
$A7:D113 60          RTS
}


;;; $D114: Update figure-8 Phantoon speed ;;;
{
$A7:D114 AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A7:D117 F0 07       BEQ $07    [$D120]     ;} If [Phantoon movement stage] = 0: go to BRANCH_0
$A7:D119 89 01 00    BIT #$0001             ;\
$A7:D11C D0 28       BNE $28    [$D146]     ;} If [Phantoon movement stage] & 1 != 0: go to BRANCH_1
$A7:D11E 80 4B       BRA $4B    [$D16B]     ; Go to BRANCH_2

; BRANCH_0
$A7:D120 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:D123 18          CLC                    ;|
$A7:D124 6D 73 CD    ADC $CD73  [$A7:CD73]  ;|
$A7:D127 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Phantoon speed += 0.0600h
$A7:D12A AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;|
$A7:D12D 6D 75 CD    ADC $CD75  [$A7:CD75]  ;|
$A7:D130 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;/
$A7:D133 CD 7B CD    CMP $CD7B  [$A7:CD7B]  ;\
$A7:D136 30 0D       BMI $0D    [$D145]     ;} If [Phantoon speed] >= 2:
$A7:D138 AD 7B CD    LDA $CD7B  [$A7:CD7B]  ;\
$A7:D13B 3A          DEC A                  ;|
$A7:D13C 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Phantoon speed = 1.0
$A7:D13F 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;/
$A7:D142 EE AE 0F    INC $0FAE  [$7E:0FAE]  ; Increment Phantoon movement stage

$A7:D145 60          RTS                    ; Return

; BRANCH_1
$A7:D146 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:D149 18          CLC                    ;|
$A7:D14A 6D 77 CD    ADC $CD77  [$A7:CD77]  ;|
$A7:D14D 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Phantoon speed += 0.1000h
$A7:D150 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;|
$A7:D153 6D 79 CD    ADC $CD79  [$A7:CD79]  ;|
$A7:D156 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;/
$A7:D159 CD 7D CD    CMP $CD7D  [$A7:CD7D]  ;\
$A7:D15C 30 0C       BMI $0C    [$D16A]     ;} If [Phantoon speed] >= 7:
$A7:D15E AD 7D CD    LDA $CD7D  [$A7:CD7D]  ;\
$A7:D161 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Phantoon speed = 7.0
$A7:D164 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;/
$A7:D167 EE AE 0F    INC $0FAE  [$7E:0FAE]  ; Increment Phantoon movement stage

$A7:D16A 60          RTS                    ; Return

; BRANCH_2
$A7:D16B AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:D16E 38          SEC                    ;|
$A7:D16F ED 77 CD    SBC $CD77  [$A7:CD77]  ;|
$A7:D172 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Phantoon speed -= 0.1000h
$A7:D175 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;|
$A7:D178 ED 79 CD    SBC $CD79  [$A7:CD79]  ;|
$A7:D17B 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;/
$A7:D17E CD 7F CD    CMP $CD7F  [$A7:CD7F]  ;\
$A7:D181 F0 02       BEQ $02    [$D185]     ;} If [Phantoon speed] > 0: return
$A7:D183 10 0D       BPL $0D    [$D192]     ;/

$A7:D185 AD 7F CD    LDA $CD7F  [$A7:CD7F]  ;\
$A7:D188 1A          INC A                  ;|
$A7:D189 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Phantoon speed = 1.0
$A7:D18C 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;/
$A7:D18F 9C AE 0F    STZ $0FAE  [$7E:0FAE]  ; Phantoon movement stage = 0

$A7:D192 60          RTS
}


;;; $D193: Update reversed figure-8 Phantoon speed ;;;
{
$A7:D193 AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A7:D196 F0 07       BEQ $07    [$D19F]     ;} If [Phantoon movement stage] = 0: go to BRANCH_0
$A7:D198 89 01 00    BIT #$0001             ;\
$A7:D19B D0 2B       BNE $2B    [$D1C8]     ;} If [Phantoon movement stage] & 1 != 0: go to BRANCH_1
$A7:D19D 80 51       BRA $51    [$D1F0]     ; Go to BRANCH_2

; BRANCH_0
$A7:D19F AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:D1A2 38          SEC                    ;|
$A7:D1A3 ED 81 CD    SBC $CD81  [$A7:CD81]  ;|
$A7:D1A6 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Phantoon speed -= 0.0600h
$A7:D1A9 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;|
$A7:D1AC ED 83 CD    SBC $CD83  [$A7:CD83]  ;|
$A7:D1AF 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;/
$A7:D1B2 CD 89 CD    CMP $CD89  [$A7:CD89]  ;\
$A7:D1B5 F0 02       BEQ $02    [$D1B9]     ;} If [Phantoon speed] > -2: return
$A7:D1B7 10 0E       BPL $0E    [$D1C7]     ;/

$A7:D1B9 AD 89 CD    LDA $CD89  [$A7:CD89]  ;\
$A7:D1BC 1A          INC A                  ;|
$A7:D1BD 1A          INC A                  ;} Phantoon speed = 0.0
$A7:D1BE 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;|
$A7:D1C1 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;/
$A7:D1C4 EE AE 0F    INC $0FAE  [$7E:0FAE]  ; Increment Phantoon movement stage
                                            
$A7:D1C7 60          RTS                    ; Return

; BRANCH_1
$A7:D1C8 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:D1CB 38          SEC                    ;|
$A7:D1CC ED 85 CD    SBC $CD85  [$A7:CD85]  ;|
$A7:D1CF 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Phantoon speed -= 0.1000h
$A7:D1D2 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;|
$A7:D1D5 ED 87 CD    SBC $CD87  [$A7:CD87]  ;|
$A7:D1D8 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;/
$A7:D1DB CD 8B CD    CMP $CD8B  [$A7:CD8B]  ;\
$A7:D1DE F0 02       BEQ $02    [$D1E2]     ;} If [Phantoon speed] > -7: return
$A7:D1E0 10 0D       BPL $0D    [$D1EF]     ;/

$A7:D1E2 AD 8B CD    LDA $CD8B  [$A7:CD8B]  ;\
$A7:D1E5 1A          INC A                  ;|
$A7:D1E6 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Phantoon speed = -6.0
$A7:D1E9 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;/
$A7:D1EC EE AE 0F    INC $0FAE  [$7E:0FAE]  ; Increment Phantoon movement stage

$A7:D1EF 60          RTS                    ; Return

; BRANCH_2
$A7:D1F0 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A7:D1F3 18          CLC                    ;|
$A7:D1F4 6D 85 CD    ADC $CD85  [$A7:CD85]  ;|
$A7:D1F7 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Phantoon speed += 0.1000h
$A7:D1FA AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;|
$A7:D1FD 6D 87 CD    ADC $CD87  [$A7:CD87]  ;|
$A7:D200 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;/
$A7:D203 CD 8D CD    CMP $CD8D  [$A7:CD8D]  ;\
$A7:D206 30 0C       BMI $0C    [$D214]     ;} If [Phantoon speed] >= 0:
$A7:D208 AD 8D CD    LDA $CD8D  [$A7:CD8D]  ;\
$A7:D20B 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Phantoon speed = 0.0
$A7:D20E 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;/
$A7:D211 9C AE 0F    STZ $0FAE  [$7E:0FAE]  ; Phantoon movement stage = 0

$A7:D214 60          RTS
}


;;; $D215: Move Phantoon in figure-8 ;;;
{
;; Parameters:
;;     Y: $E3D2 (Phantoon movement data)
;;     $14: 216h (size of Phantoon movement data)
$A7:D215 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A7:D218 85 16       STA $16    [$7E:0016]  ;} $16 = [Phantoon speed]
$A7:D21A D0 01       BNE $01    [$D21D]     ; If [Phantoon speed] = 0:
$A7:D21C 60          RTS                    ; Return

; LOOP
$A7:D21D 5A          PHY
$A7:D21E AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:D221 0A          ASL A                  ;|
$A7:D222 85 12       STA $12    [$7E:0012]  ;|
$A7:D224 98          TYA                    ;|
$A7:D225 18          CLC                    ;|
$A7:D226 65 12       ADC $12    [$7E:0012]  ;|
$A7:D228 A8          TAY                    ;|
$A7:D229 B9 00 00    LDA $0000,y[$A7:E4BE]  ;|
$A7:D22C 29 FF 00    AND #$00FF             ;|
$A7:D22F 89 80 00    BIT #$0080             ;} Phantoon body X position += ±[[Y] + [Phantoon movement data index] * 2]
$A7:D232 F0 03       BEQ $03    [$D237]     ;|
$A7:D234 09 00 FF    ORA #$FF00             ;|
                                            ;|
$A7:D237 85 12       STA $12    [$7E:0012]  ;|
$A7:D239 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A7:D23C 18          CLC                    ;|
$A7:D23D 65 12       ADC $12    [$7E:0012]  ;|
$A7:D23F 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A7:D242 B9 01 00    LDA $0001,y[$A7:E4BF]  ;\
$A7:D245 29 FF 00    AND #$00FF             ;|
$A7:D248 89 80 00    BIT #$0080             ;|
$A7:D24B F0 03       BEQ $03    [$D250]     ;|
$A7:D24D 09 00 FF    ORA #$FF00             ;|
                                            ;} Phantoon body Y position += ±[[Y] + [Phantoon movement data index] * 2 + 1]
$A7:D250 85 12       STA $12    [$7E:0012]  ;|
$A7:D252 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;|
$A7:D255 18          CLC                    ;|
$A7:D256 65 12       ADC $12    [$7E:0012]  ;|
$A7:D258 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A7:D25B AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:D25E 1A          INC A                  ;} Increment Phantoon movement data index
$A7:D25F 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;/
$A7:D262 C5 14       CMP $14    [$7E:0014]  ;\
$A7:D264 30 03       BMI $03    [$D269]     ;} If [Phantoon movement data index] >= [$14]:
$A7:D266 9C A8 0F    STZ $0FA8  [$7E:0FA8]  ; Phantoon movement data index = 0

$A7:D269 7A          PLY
$A7:D26A C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$A7:D26C F0 02       BEQ $02    [$D270]     ; If [$16] != 0:
$A7:D26E 80 AD       BRA $AD    [$D21D]     ; Go to LOOP

$A7:D270 60          RTS
}


;;; $D271: Move Phantoon in reverse figure-8 ;;;
{
;; Parameters:
;;     Y: $E3D2 (Phantoon movement data)
;;     $14: 215h (last index of Phantoon movement data)
$A7:D271 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A7:D274 49 FF FF    EOR #$FFFF             ;|
$A7:D277 1A          INC A                  ;} $16 = -[Phantoon speed]
$A7:D278 85 16       STA $16    [$7E:0016]  ;/
$A7:D27A D0 01       BNE $01    [$D27D]     ; If [Phantoon speed] = 0:
$A7:D27C 60          RTS                    ; Return

; LOOP
$A7:D27D 5A          PHY
$A7:D27E AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:D281 0A          ASL A                  ;|
$A7:D282 85 12       STA $12    [$7E:0012]  ;|
$A7:D284 98          TYA                    ;|
$A7:D285 18          CLC                    ;|
$A7:D286 65 12       ADC $12    [$7E:0012]  ;|
$A7:D288 A8          TAY                    ;|
$A7:D289 B9 00 00    LDA $0000,y[$A7:E7FC]  ;|
$A7:D28C 29 FF 00    AND #$00FF             ;|
$A7:D28F 89 80 00    BIT #$0080             ;} Phantoon body X position -= ±[[Y] + [Phantoon movement data index] * 2]
$A7:D292 F0 03       BEQ $03    [$D297]     ;|
$A7:D294 09 00 FF    ORA #$FF00             ;|
                                            ;|
$A7:D297 85 12       STA $12    [$7E:0012]  ;|
$A7:D299 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A7:D29C 38          SEC                    ;|
$A7:D29D E5 12       SBC $12    [$7E:0012]  ;|
$A7:D29F 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A7:D2A2 B9 01 00    LDA $0001,y[$A7:E7FD]  ;\
$A7:D2A5 29 FF 00    AND #$00FF             ;|
$A7:D2A8 89 80 00    BIT #$0080             ;|
$A7:D2AB F0 03       BEQ $03    [$D2B0]     ;|
$A7:D2AD 09 00 FF    ORA #$FF00             ;|
                                            ;} Phantoon body Y position -= ±[[Y] + [Phantoon movement data index] * 2 + 1]
$A7:D2B0 85 12       STA $12    [$7E:0012]  ;|
$A7:D2B2 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;|
$A7:D2B5 38          SEC                    ;|
$A7:D2B6 E5 12       SBC $12    [$7E:0012]  ;|
$A7:D2B8 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A7:D2BB AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:D2BE 3A          DEC A                  ;} Decrement Phantoon movement data index
$A7:D2BF 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;/
$A7:D2C2 10 05       BPL $05    [$D2C9]     ; If [Phantoon movement data index] >= 0:
$A7:D2C4 A5 14       LDA $14    [$7E:0014]  ;\
$A7:D2C6 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Phantoon movement data index = [$14]

$A7:D2C9 7A          PLY
$A7:D2CA C6 16       DEC $16    [$7E:0016]  ; Decrement $16
$A7:D2CC F0 02       BEQ $02    [$D2D0]     ; If [$16] != 0:
$A7:D2CE 80 AD       BRA $AD    [$D27D]     ; Go to LOOP

$A7:D2D0 60          RTS
}


;;; $D2D1: Move Phantoon in swooping pattern ;;;
{
$A7:D2D1 AD 30 10    LDA $1030  [$7E:1030]  ;\
$A7:D2D4 30 17       BMI $17    [$D2ED]     ;} If [Phantoon target X position] & 8000h = 0:
$A7:D2D6 18          CLC                    ;\
$A7:D2D7 69 02 00    ADC #$0002             ;} Phantoon target X position += 2
$A7:D2DA 8D 30 10    STA $1030  [$7E:1030]  ;/
$A7:D2DD C9 00 01    CMP #$0100             ;\
$A7:D2E0 30 1F       BMI $1F    [$D301]     ;} If [Phantoon target X position] < 100h: go to BRANCH_TARGET_CALCULATED
$A7:D2E2 09 00 80    ORA #$8000             ;\
$A7:D2E5 8D 30 10    STA $1030  [$7E:1030]  ;} Phantoon target X position |= 8000h
$A7:D2E8 29 FF 7F    AND #$7FFF             ; A = [Phantoon target X position] & ~8000h
$A7:D2EB 80 14       BRA $14    [$D301]     ; Go to BRANCH_TARGET_CALCULATED

$A7:D2ED 38          SEC                    ;\
$A7:D2EE E9 02 00    SBC #$0002             ;} Phantoon target X position -= 2
$A7:D2F1 8D 30 10    STA $1030  [$7E:1030]  ;/
$A7:D2F4 29 FF 7F    AND #$7FFF             ; A = [Phantoon target X position] & ~8000h
$A7:D2F7 F0 02       BEQ $02    [$D2FB]     ;\
$A7:D2F9 10 06       BPL $06    [$D301]     ;} If [A] > 0: go to BRANCH_TARGET_CALCULATED

$A7:D2FB A9 00 00    LDA #$0000             ; A = 0
$A7:D2FE 8D 30 10    STA $1030  [$7E:1030]  ; Phantoon target X position = 0

; BRANCH_TARGET_CALCULATED
$A7:D301 CD 7A 0F    CMP $0F7A  [$7E:0F7A]  ;\
$A7:D304 30 11       BMI $11    [$D317]     ;} If [A] >= [Phantoon X position]:
$A7:D306 AD 2C 10    LDA $102C  [$7E:102C]  ;\
$A7:D309 C9 00 08    CMP #$0800             ;} If [Phantoon X velocity] < 800h:
$A7:D30C 10 18       BPL $18    [$D326]     ;/
$A7:D30E 18          CLC                    ;\
$A7:D30F 69 20 00    ADC #$0020             ;} Phantoon X velocity += 20h
$A7:D312 8D 2C 10    STA $102C  [$7E:102C]  ;/
$A7:D315 80 0F       BRA $0F    [$D326]

$A7:D317 AD 2C 10    LDA $102C  [$7E:102C]  ;\ Else ([A] < [Phantoon X position]):
$A7:D31A C9 01 F8    CMP #$F801             ;} If [Phantoon X velocity] > -800h:
$A7:D31D 30 07       BMI $07    [$D326]     ;/
$A7:D31F 38          SEC                    ;\
$A7:D320 E9 20 00    SBC #$0020             ;} Phantoon X velocity -= 20h
$A7:D323 8D 2C 10    STA $102C  [$7E:102C]  ;/

$A7:D326 AD 2C 10    LDA $102C  [$7E:102C]  ; >_<;
$A7:D329 EB          XBA                    ;\
$A7:D32A 48          PHA                    ;|
$A7:D32B 29 00 FF    AND #$FF00             ;|
$A7:D32E 85 14       STA $14    [$7E:0014]  ;|
$A7:D330 68          PLA                    ;|
$A7:D331 29 FF 00    AND #$00FF             ;|
$A7:D334 89 80 00    BIT #$0080             ;|
$A7:D337 F0 03       BEQ $03    [$D33C]     ;|
$A7:D339 09 00 FF    ORA #$FF00             ;|
                                            ;} Phantoon X position += ±[Phantoon X velocity] / 100h
$A7:D33C 85 12       STA $12    [$7E:0012]  ;|
$A7:D33E AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;|
$A7:D341 18          CLC                    ;|
$A7:D342 65 14       ADC $14    [$7E:0014]  ;|
$A7:D344 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;|
$A7:D347 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A7:D34A 65 12       ADC $12    [$7E:0012]  ;|
$A7:D34C 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A7:D34F C9 C0 FF    CMP #$FFC0             ;\
$A7:D352 10 08       BPL $08    [$D35C]     ;|
$A7:D354 A9 C0 FF    LDA #$FFC0             ;|
$A7:D357 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;|
$A7:D35A 80 0B       BRA $0B    [$D367]     ;|
                                            ;} Phantoon X position = clamp([Phantoon X position], -1C0h, 1C0h)
$A7:D35C C9 C0 01    CMP #$01C0             ;|
$A7:D35F 30 06       BMI $06    [$D367]     ;|
$A7:D361 A9 C0 01    LDA #$01C0             ;|
$A7:D364 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/

$A7:D367 BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$A7:D36A C9 2E D9    CMP #$D92E             ;} If [Phantoon function] = $D92E:
$A7:D36D D0 05       BNE $05    [$D374]     ;/
$A7:D36F A9 70 00    LDA #$0070             ; A = 70h
$A7:D372 80 07       BRA $07    [$D37B]

$A7:D374 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\ Else ([Phantoon function] != $D92E):
$A7:D377 38          SEC                    ;} A = [Samus Y position] - 30h
$A7:D378 E9 30 00    SBC #$0030             ;/

$A7:D37B CD 7E 0F    CMP $0F7E  [$7E:0F7E]  ;\
$A7:D37E 30 11       BMI $11    [$D391]     ;} If [A] >= [Phantoon Y position]:
$A7:D380 AD 2E 10    LDA $102E  [$7E:102E]  ;\
$A7:D383 C9 00 06    CMP #$0600             ;} If [Phantoon Y velocity] < 600h:
$A7:D386 10 18       BPL $18    [$D3A0]     ;/
$A7:D388 18          CLC                    ;\
$A7:D389 69 40 00    ADC #$0040             ;} Phantoon Y velocity += 40h
$A7:D38C 8D 2E 10    STA $102E  [$7E:102E]  ;/
$A7:D38F 80 0F       BRA $0F    [$D3A0]

$A7:D391 AD 2E 10    LDA $102E  [$7E:102E]  ;\ Else ([A] < [Phantoon Y position]):
$A7:D394 C9 01 FA    CMP #$FA01             ;} If [Phantoon Y velocity] > -600h:
$A7:D397 30 07       BMI $07    [$D3A0]     ;/
$A7:D399 38          SEC                    ;\
$A7:D39A E9 40 00    SBC #$0040             ;} Phantoon Y velocity -= 40h
$A7:D39D 8D 2E 10    STA $102E  [$7E:102E]  ;/

$A7:D3A0 AD 2E 10    LDA $102E  [$7E:102E]  ; >_<;
$A7:D3A3 EB          XBA                    ;\
$A7:D3A4 48          PHA                    ;|
$A7:D3A5 29 00 FF    AND #$FF00             ;|
$A7:D3A8 85 14       STA $14    [$7E:0014]  ;|
$A7:D3AA 68          PLA                    ;|
$A7:D3AB 29 FF 00    AND #$00FF             ;|
$A7:D3AE 89 80 00    BIT #$0080             ;|
$A7:D3B1 F0 03       BEQ $03    [$D3B6]     ;|
$A7:D3B3 09 00 FF    ORA #$FF00             ;|
                                            ;} Phantoon Y position += ±[Phantoon Y velocity] / 100h
$A7:D3B6 85 12       STA $12    [$7E:0012]  ;|
$A7:D3B8 AD 80 0F    LDA $0F80  [$7E:0F80]  ;|
$A7:D3BB 18          CLC                    ;|
$A7:D3BC 65 14       ADC $14    [$7E:0014]  ;|
$A7:D3BE 8D 80 0F    STA $0F80  [$7E:0F80]  ;|
$A7:D3C1 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;|
$A7:D3C4 65 12       ADC $12    [$7E:0012]  ;|
$A7:D3C6 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A7:D3C9 C9 40 00    CMP #$0040             ;\
$A7:D3CC 10 07       BPL $07    [$D3D5]     ;|
$A7:D3CE A9 40 00    LDA #$0040             ;|
$A7:D3D1 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;|
$A7:D3D4 60          RTS                    ;|
                                            ;} Phantoon Y position = clamp([Phantoon Y position], 40h, D8h)
$A7:D3D5 C9 D8 00    CMP #$00D8             ;|
$A7:D3D8 30 06       BMI $06    [$D3E0]     ;|
$A7:D3DA A9 D8 00    LDA #$00D8             ;|
$A7:D3DD 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/

$A7:D3E0 60          RTS
}


;;; $D3E1: Start Phantoon swooping pattern ;;;
{
$A7:D3E1 A9 00 04    LDA #$0400             ;\
$A7:D3E4 8D 2C 10    STA $102C  [$7E:102C]  ;} Phantoon X velocity = 400h
$A7:D3E7 8D 2E 10    STA $102E  [$7E:102E]  ; Phantoon Y velocity = 400h
$A7:D3EA 9C 30 10    STZ $1030  [$7E:1030]  ; Phantoon target X position = 0
$A7:D3ED A9 78 D6    LDA #$D678             ;\
$A7:D3F0 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D678
$A7:D3F3 A9 68 01    LDA #$0168             ;\
$A7:D3F6 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 360
$A7:D3F9 60          RTS
}


;;; $D3FA: Make Phantoon look towards Samus ;;;
{
$A7:D3FA 22 29 AE A0 JSL $A0AE29[$A0:AE29]  ; Determine direction of Samus from enemy
$A7:D3FE 0A          ASL A                  ;\
$A7:D3FF A8          TAY                    ;} Y = [A] * 2
$A7:D400 A9 01 00    LDA #$0001             ;\
$A7:D403 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Phantoon eye instruction timer = 1
$A7:D406 B9 0D D4    LDA $D40D,y[$A7:D413]  ;\
$A7:D409 8D D2 0F    STA $0FD2  [$7E:0FD2]  ; Phantoon eye instruction list pointer = [$D40D + [Y]]
$A7:D40C 60          RTS

$A7:D40D             dw CCA7, ; Up
                        CCAD, ; Up-right
                        CCB3, ; Right
                        CCB9, ; Down-right
                        CCBF, ; Down
                        CCBF,
                        CCC5, ; Down-left
                        CCCB, ; Left
                        CCD1, ; Up-left
                        CCA7
}


;;; $D421: Start Phantoon death sequence ;;;
{
$A7:D421 DA          PHX
$A7:D422 BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$A7:D425 C9 78 D6    CMP #$D678             ;} If [Phantoon function] != $D678 (swooping - opaque):
$A7:D428 F0 0D       BEQ $0D    [$D437]     ;/
$A7:D42A C9 B9 D6    CMP #$D6B9             ;\
$A7:D42D F0 08       BEQ $08    [$D437]     ;} If [Phantoon function] != $D6B9 (swooping - fading out):
$A7:D42F A9 48 D9    LDA #$D948             ;\
$A7:D432 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D948 (death sequence)
$A7:D435 80 06       BRA $06    [$D43D]

$A7:D437 A9 2E D9    LDA #$D92E             ;\ Else ([Phantoon function] = $D678/$D6B9):
$A7:D43A 9D B2 0F    STA $0FB2,x            ;} Phantoon function = $D92E (swooping - fatal damage)

$A7:D43D 9C EC 0F    STZ $0FEC  [$7E:0FEC]  ; Phantoon fade counter = 0
$A7:D440 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:D443 20 FA D3    JSR $D3FA  [$A7:D3FA]  ; Make Phantoon look towards Samus
$A7:D446 A2 FE 01    LDX #$01FE             ;\
$A7:D449 A5 B5       LDA $B5    [$7E:00B5]  ;|
$A7:D44B 9F 00 91 7E STA $7E9100,x[$7E:92FE];|
$A7:D44F CA          DEX                    ;} $9100..92FF = [BG2 X scroll]
$A7:D450 CA          DEX                    ;|
$A7:D451 10 F8       BPL $F8    [$D44B]     ;/
$A7:D453 AD 88 19    LDA $1988  [$7E:1988]  ;\
$A7:D456 09 00 40    ORA #$4000             ;} Make Phantoon semi-transparent
$A7:D459 8D 88 19    STA $1988  [$7E:1988]  ;/
$A7:D45C A9 01 00    LDA #$0001             ;\
$A7:D45F 8D 76 10    STA $1076  [$7E:1076]  ;} $1076 = 1
$A7:D462 FA          PLX
$A7:D463 60          RTS
}


;;; $D464: Advance Phantoon fade out ;;;
{
;; Parameters:
;;     A: Palette change denominator
$A7:D464 DA          PHX
$A7:D465 85 12       STA $12    [$7E:0012]
$A7:D467 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A7:D46A 89 01 00    BIT #$0001             ;|
$A7:D46D D0 15       BNE $15    [$D484]     ;} If [frame counter] % 2 != 0: return
$A7:D46F AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D472 D0 10       BNE $10    [$D484]     ;} If [Phantoon fade complete flag] != 0: return
$A7:D474 A5 12       LDA $12    [$7E:0012]  ;\
$A7:D476 8D EE 0F    STA $0FEE  [$7E:0FEE]  ;} Palette change denominator = [A]
$A7:D479 20 9A DB    JSR $DB9A  [$A7:DB9A]  ; Advance Phantoon fade out
$A7:D47C 90 06       BCC $06    [$D484]     ; If reached target palette:
$A7:D47E A9 01 00    LDA #$0001             ;\
$A7:D481 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Phantoon fade complete flag = 1

$A7:D484 FA          PLX
$A7:D485 60          RTS
}


;;; $D486: Advance Phantoon fade in ;;;
{
;; Parameters:
;;     A: Palette change denominator
$A7:D486 DA          PHX
$A7:D487 85 12       STA $12    [$7E:0012]
$A7:D489 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A7:D48C 89 01 00    BIT #$0001             ;} If [frame counter] % 2 != 0: return
$A7:D48F D0 15       BNE $15    [$D4A6]     ;/
$A7:D491 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D494 D0 10       BNE $10    [$D4A6]     ;} If [Phantoon fade complete flag] != 0: return
$A7:D496 A5 12       LDA $12    [$7E:0012]
$A7:D498 8D EE 0F    STA $0FEE  [$7E:0FEE]  ; Palette change denominator = [A]
$A7:D49B 20 D5 DB    JSR $DBD5  [$A7:DBD5]  ; Advance Phantoon fade in
$A7:D49E 90 06       BCC $06    [$D4A6]     ; If carry set:
$A7:D4A0 A9 01 00    LDA #$0001             ;\
$A7:D4A3 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;} Phantoon fade complete flag = 1

$A7:D4A6 FA          PLX
$A7:D4A7 60          RTS
}


;;; $D4A8: RTS ;;;
{
$A7:D4A8 60          RTS
}


;;; $D4A9..D5E6: Phantoon function - fight intro ;;;
{
;;; $D4A9: Phantoon function - fight intro - spawn circle of flames ;;;
{
$A7:D4A9 DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D4AC F0 02       BEQ $02    [$D4B0]     ;\
$A7:D4AE 10 3D       BPL $3D    [$D4ED]     ;} If [Phantoon function timer] > 0: return

$A7:D4B0 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ; A = [Phantoon flame counter]
$A7:D4B3 A0 37 9C    LDY #$9C37             ;\
$A7:D4B6 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Phantoon starting flames enemy projectile
$A7:D4BA A9 1D 00    LDA #$001D             ;\
$A7:D4BD 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1Dh, sound library 3, max queued sounds allowed = 6 (Phantoon's flame)
$A7:D4C1 A9 1E 00    LDA #$001E             ;\
$A7:D4C4 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 1Eh
$A7:D4C7 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:D4CA 1A          INC A                  ;} Increment Phantoon flame counter
$A7:D4CB 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;/
$A7:D4CE C9 08 00    CMP #$0008             ;\
$A7:D4D1 30 1A       BMI $1A    [$D4ED]     ;} If [Phantoon flame counter] < 8: return
$A7:D4D3 9C A8 0F    STZ $0FA8  [$7E:0FA8]  ; Phantoon flame counter = 0
$A7:D4D6 9E 2A 10    STZ $102A,x[$7E:102A]  ; Phantoon round damage = 0
$A7:D4D9 A9 EE D4    LDA #$D4EE             ;\
$A7:D4DC 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D4EE
$A7:D4DF A9 1E 00    LDA #$001E             ;\
$A7:D4E2 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 1Eh
$A7:D4E5 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A7:D4E9             dx 00, 06, B781        ;} Spawn PLM to draw Phantoon's door during boss fight

$A7:D4ED 60          RTS
}


;;; $D4EE: Phantoon function - fight intro - spin circle of flames ;;;
{
$A7:D4EE DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D4F1 F0 02       BEQ $02    [$D4F5]     ;\
$A7:D4F3 10 12       BPL $12    [$D507]     ;} If [Phantoon function timer] > 0: return

$A7:D4F5 A9 F0 00    LDA #$00F0             ;\
$A7:D4F8 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = F0h
$A7:D4FB A9 01 00    LDA #$0001             ;\
$A7:D4FE 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Phantoon starting flames activation flag = 1
$A7:D501 A9 08 D5    LDA #$D508             ;\
$A7:D504 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D508

$A7:D507 60          RTS
}


;;; $D508: Phantoon function - fight intro - start wavy fade in ;;;
{
$A7:D508 DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D50B F0 02       BEQ $02    [$D50F]     ;\
$A7:D50D 10 3A       BPL $3A    [$D549]     ;} If [Phantoon function timer] > 0: return

$A7:D50F 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ; Phantoon starting flames activation flag = 0
$A7:D512 AD 88 19    LDA $1988  [$7E:1988]  ;\
$A7:D515 09 00 40    ORA #$4000             ;} Make Phantoon semi-transparent
$A7:D518 8D 88 19    STA $1988  [$7E:1988]  ;/
$A7:D51B A9 4A D5    LDA #$D54A             ;\
$A7:D51E 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D54A
$A7:D521 A9 01 80    LDA #$8001             ;\
$A7:D524 8D 74 10    STA $1074  [$7E:1074]  ;} Phantoon semi-transparency HDMA object control = 8001h (normal)
$A7:D527 A9 78 00    LDA #$0078             ;\
$A7:D52A 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 78h
$A7:D52D AD A3 CD    LDA $CDA3  [$A7:CDA3]  ;\
$A7:D530 85 16       STA $16    [$7E:0016]  ;} Wavy Phantoon phase delta = 8
$A7:D532 A9 02 00    LDA #$0002             ; Next wavy Phantoon mode = 2 (normal)
$A7:D535 22 87 E4 88 JSL $88E487[$88:E487]  ; Spawn wavy Phantoon HDMA object
$A7:D539 AD 9D CD    LDA $CD9D  [$A7:CD9D]  ;\
$A7:D53C 8D 6E 10    STA $106E  [$7E:106E]  ;} Wavy Phantoon amplitude = C00h
$A7:D53F 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:D542 A9 05 00    LDA #$0005             ;\
$A7:D545 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track

$A7:D549 60          RTS
}


;;; $D54A: Phantoon function - fight intro - wavy fade-in ;;;
{
$A7:D54A A9 0C 00    LDA #$000C             ;\
$A7:D54D 20 86 D4    JSR $D486  [$A7:D486]  ;} Advance Phantoon fade in
$A7:D550 AD 9B CD    LDA $CD9B  [$A7:CD9B]  ;\
$A7:D553 85 12       STA $12    [$7E:0012]  ;} $12 = 40h (amplitude delta)
$A7:D555 AD 9D CD    LDA $CD9D  [$A7:CD9D]  ;\
$A7:D558 85 14       STA $14    [$7E:0014]  ;} $14 = C00h (max amplitude)
$A7:D55A 20 27 CF    JSR $CF27  [$A7:CF27]  ; Grow/shrink Phantoon wave amplitude
$A7:D55D B0 0F       BCS $0F    [$D56E]     ; If completed wave cycle: go to BRANCH_DONE
$A7:D55F DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D562 F0 02       BEQ $02    [$D566]     ;\
$A7:D564 10 1A       BPL $1A    [$D580]     ;} If [Phantoon function timer] > 0: return

$A7:D566 A9 01 00    LDA #$0001             ;\
$A7:D569 8D 70 10    STA $1070  [$7E:1070]  ;} Wavy Phantoon phase delta direction = shrinking
$A7:D56C 80 12       BRA $12    [$D580]     ; Return

; BRANCH_DONE
$A7:D56E A9 96 D5    LDA #$D596             ;\
$A7:D571 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D596
$A7:D574 A9 01 00    LDA #$0001             ;\
$A7:D577 8D 74 10    STA $1074  [$7E:1074]  ;} Phantoon semi-transparency HDMA object control = 1 (normal)
$A7:D57A A9 1E 00    LDA #$001E             ;\
$A7:D57D 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 1Eh

$A7:D580 60          RTS
}


;;; $D581: Unused ;;;
{
$A7:D581 A2 FE 01    LDX #$01FE         ;\
$A7:D584 A9 00 00    LDA #$0000         ;|
                                        ;|
$A7:D587 9F 00 91 7E STA $7E9100,x      ;} $7E:9100..92FF = 0
$A7:D58B CA          DEX                ;|
$A7:D58C CA          DEX                ;|
$A7:D58D 10 F8       BPL $F8    [$D587] ;/
$A7:D58F A9 96 D5    LDA #$D596         ;\
$A7:D592 9D B2 0F    STA $0FB2,x        ;} Phantoon function = $D596
$A7:D595 60          RTS
}


;;; $D596: Phantoon function - fight intro - pick first pattern ;;;
{
$A7:D596 DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D599 F0 02       BEQ $02    [$D59D]     ;\
$A7:D59B 10 49       BPL $49    [$D5E6]     ;} If [Phantoon function timer] > 0: return

$A7:D59D 9C F4 0F    STZ $0FF4  [$7E:0FF4]  ; Disable wavy Phantoon
$A7:D5A0 A9 E7 D5    LDA #$D5E7             ;\
$A7:D5A3 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D5E7
$A7:D5A6 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A7:D5A9 4A          LSR A                  ;|
$A7:D5AA 29 03 00    AND #$0003             ;|
$A7:D5AD 0A          ASL A                  ;} Phantoon eye timer = [$CD53 + [frame counter] / 2 % 4 * 2]
$A7:D5AE A8          TAY                    ;|
$A7:D5AF B9 53 CD    LDA $CD53,y[$A7:CD59]  ;|
$A7:D5B2 8D E8 0F    STA $0FE8  [$7E:0FE8]  ;/
$A7:D5B5 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A7:D5B9 89 01 00    BIT #$0001             ;\
$A7:D5BC D0 13       BNE $13    [$D5D1]     ;} If [random number] % 2 = 0:
$A7:D5BE A9 01 00    LDA #$0001             ;\
$A7:D5C1 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Phantoon speed = 1.0
$A7:D5C4 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;/
$A7:D5C7 9C AE 0F    STZ $0FAE  [$7E:0FAE]  ; Phantoon movement stage = 0
$A7:D5CA 9C EC 0F    STZ $0FEC  [$7E:0FEC]  ; Phantoon reversed movement flag = 0
$A7:D5CD 9C A8 0F    STZ $0FA8  [$7E:0FA8]  ; Phantoon movement index = 0
$A7:D5D0 60          RTS                    ; Return

$A7:D5D1 9C AC 0F    STZ $0FAC  [$7E:0FAC]  ;\
$A7:D5D4 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;} Phantoon speed = 0.0
$A7:D5D7 9C AE 0F    STZ $0FAE  [$7E:0FAE]  ; Phantoon movement stage = 0
$A7:D5DA A9 01 00    LDA #$0001             ;\
$A7:D5DD 8D EC 0F    STA $0FEC  [$7E:0FEC]  ;} Phantoon reversed movement flag = 1
$A7:D5E0 A9 15 02    LDA #$0215             ;\
$A7:D5E3 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Phantoon movement index = 215h

$A7:D5E6 60          RTS
}
}


;;; $D5E7..D677: Phantoon function - figure-8 ;;;
{
;;; $D5E7: Phantoon function - figure-8 - moving ;;;
{
$A7:D5E7 20 F1 D0    JSR $D0F1  [$A7:D0F1]  ; Adjust speed and move Phantoon in figure-8
$A7:D5EA 20 CA CF    JSR $CFCA  [$A7:CFCA]  ; Handle casual flames
$A7:D5ED CE E8 0F    DEC $0FE8  [$7E:0FE8]  ; Decrement Phantoon eye timer
$A7:D5F0 F0 02       BEQ $02    [$D5F4]     ;\
$A7:D5F2 10 18       BPL $18    [$D60C]     ;} If [Phantoon eye timer] >= 0: return

$A7:D5F4 A9 A8 D4    LDA #$D4A8             ;\
$A7:D5F7 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = RTS
$A7:D5FA A9 01 00    LDA #$0001             ;\
$A7:D5FD 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Phantoon eye instruction timer = 1
$A7:D600 A9 53 CC    LDA #$CC53             ;\
$A7:D603 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Phantoon eye instruction list pointer = $CC53 (open)
$A7:D606 9C B6 0F    STZ $0FB6  [$7E:0FB6]  ; Phantoon flame rain flag triggered flag = 0
$A7:D609 20 70 CF    JSR $CF70  [$A7:CF70]  ; Phantoon materialisation flame spiral

$A7:D60C 60          RTS
}


;;; $D60D: Phantoon function - figure-8 - vulnerable window ;;;
{
$A7:D60D DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D610 F0 02       BEQ $02    [$D614]     ;\
$A7:D612 10 44       BPL $44    [$D658]     ;} If [Phantoon function timer] > 0: go to BRANCH_WAITING

$A7:D614 9E 2A 10    STZ $102A,x[$7E:102A]  ; Phantoon round damage = 0
$A7:D617 AD 28 10    LDA $1028  [$7E:1028]  ;\
$A7:D61A F0 11       BEQ $11    [$D62D]     ;} If swooping triggered:
$A7:D61C 9C 28 10    STZ $1028  [$7E:1028]  ; Clear Phantoon swooping triggered flag
$A7:D61F A9 3C 00    LDA #$003C             ;\
$A7:D622 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 60
$A7:D625 A9 5C D6    LDA #$D65C             ;\
$A7:D628 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D65C
$A7:D62B 80 2B       BRA $2B    [$D658]     ; Go to BRANCH_WAITING

$A7:D62D A9 A8 D4    LDA #$D4A8             ;\
$A7:D630 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = RTS
$A7:D633 A9 01 00    LDA #$0001             ;\
$A7:D636 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Phantoon body instruction timer = 1
$A7:D639 8D D4 0F    STA $0FD4  [$7E:0FD4]  ; Phantoon eye instruction timer = 1
$A7:D63C A9 41 CC    LDA #$CC41             ;\
$A7:D63F 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Phantoon body instruction list pointer = $CC41 (invulnerable)
$A7:D642 A9 81 CC    LDA #$CC81             ;\
$A7:D645 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Phantoon eye instruction list pointer = $CC81 (close and pick new pattern)
$A7:D648 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:D64B 09 00 04    ORA #$0400             ;} Set Phantoon body as intangible
$A7:D64E 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:D651 A9 01 00    LDA #$0001             ;\
$A7:D654 8D B6 0F    STA $0FB6  [$7E:0FB6]  ;} Phantoon flame rain flag triggered flag = 1
$A7:D657 60          RTS                    ; Return

; BRANCH_WAITING
$A7:D658 20 FA D3    JSR $D3FA  [$A7:D3FA]  ; Make Phantoon look towards Samus
$A7:D65B 60          RTS
}


;;; $D65C: Phantoon function - figure-8 - swooping triggered ;;;
{
$A7:D65C 20 FA D3    JSR $D3FA  [$A7:D3FA]  ; Make Phantoon look towards Samus
$A7:D65F AD 88 19    LDA $1988  [$7E:1988]  ;\
$A7:D662 29 FF BF    AND #$BFFF             ;} Make Phantoon opaque
$A7:D665 8D 88 19    STA $1988  [$7E:1988]  ;/
$A7:D668 20 E1 D3    JSR $D3E1  [$A7:D3E1]  ; Start Phantoon swooping pattern
$A7:D66B A9 01 00    LDA #$0001             ;\
$A7:D66E 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Phantoon body instruction timer = 1
$A7:D671 A9 47 CC    LDA #$CC47             ;\
$A7:D674 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Phantoon body instruction list pointer = $CC47 (full hitbox)
$A7:D677 60          RTS
}
}


;;; $D678..D3: Phantoon function - swooping ;;;
{
;;; $D678: Phantoon function - swooping - opaque ;;;
{
$A7:D678 20 FA D3    JSR $D3FA  [$A7:D3FA]  ; Make Phantoon look towards Samus
$A7:D67B 20 D1 D2    JSR $D2D1  [$A7:D2D1]  ; Move Phantoon in swooping pattern
$A7:D67E DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D681 F0 02       BEQ $02    [$D685]     ;\
$A7:D683 10 33       BPL $33    [$D6B8]     ;} If [Phantoon function timer] > 0: return

$A7:D685 A9 B9 D6    LDA #$D6B9             ;\
$A7:D688 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D6B9
$A7:D68B AD 88 19    LDA $1988  [$7E:1988]  ;\
$A7:D68E 09 00 40    ORA #$4000             ;} Make Phantoon semi-transparent
$A7:D691 8D 88 19    STA $1988  [$7E:1988]  ;/
$A7:D694 A9 01 00    LDA #$0001             ;\
$A7:D697 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Phantoon body instruction timer = 1
$A7:D69A 8D D4 0F    STA $0FD4  [$7E:0FD4]  ; Phantoon eye instruction timer = 1
$A7:D69D A9 41 CC    LDA #$CC41             ;\
$A7:D6A0 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Phantoon body instruction list pointer = $CC41 (invulnerable)
$A7:D6A3 A9 91 CC    LDA #$CC91             ;\
$A7:D6A6 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Phantoon eye instruction list pointer = $CC91 (close)
$A7:D6A9 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:D6AC 09 00 04    ORA #$0400             ;} Set Phantoon body as intangible
$A7:D6AF 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:D6B2 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:D6B5 9E 2A 10    STZ $102A,x[$7E:102A]  ; Phantoon round damage = 0

$A7:D6B8 60          RTS
}


;;; $D6B9: Phantoon function - swooping - fading out ;;;
{
$A7:D6B9 20 D1 D2    JSR $D2D1  [$A7:D2D1]  ; Move Phantoon in swooping pattern
$A7:D6BC A9 0C 00    LDA #$000C             ;\
$A7:D6BF 20 64 D4    JSR $D464  [$A7:D464]  ;} Advance Phantoon fade out

$A7:D6C2 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D6C5 F0 0C       BEQ $0C    [$D6D3]     ;} If fade complete:
$A7:D6C7 A9 D4 D6    LDA #$D6D4             ;\
$A7:D6CA 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D6D4
$A7:D6CD A9 78 00    LDA #$0078             ;\
$A7:D6D0 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 120

$A7:D6D3 60          RTS
}
}


;;; $D6D4..D73E: Phantoon function - hiding before figure-8 ;;;
{
;;; $D6D4: Phantoon function - hiding before figure-8 - hiding ;;;
{
$A7:D6D4 DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D6D7 F0 02       BEQ $02    [$D6DB]     ;\
$A7:D6D9 10 06       BPL $06    [$D6E1]     ;} If [Phantoon function timer] > 0: return

$A7:D6DB A9 E2 D6    LDA #$D6E2             ;\
$A7:D6DE 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D6E2

$A7:D6E1 60          RTS
}


;;; $D6E2: Phantoon function - hiding before figure-8 - place Phantoon ;;;
{
$A7:D6E2 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A7:D6E6 89 01 00    BIT #$0001             ;\
$A7:D6E9 F0 14       BEQ $14    [$D6FF]     ;} If [random number] % 2 != 0:
$A7:D6EB A9 88 00    LDA #$0088             ;\
$A7:D6EE 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Phantoon movement index = 88h
$A7:D6F1 A9 D0 00    LDA #$00D0             ;\
$A7:D6F4 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Phantoon X position = D0h
$A7:D6F7 A9 60 00    LDA #$0060             ;\
$A7:D6FA 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Phantoon Y position = 60h
$A7:D6FD 80 12       BRA $12    [$D711]

$A7:D6FF A9 8F 01    LDA #$018F             ;\ Else ([random number] % 2 = 0):
$A7:D702 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Phantoon movement index = 18Fh
$A7:D705 A9 30 00    LDA #$0030             ;\
$A7:D708 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Phantoon X position = 30h
$A7:D70B A9 60 00    LDA #$0060             ;\
$A7:D70E 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Phantoon Y position = 60h

$A7:D711 9C EC 0F    STZ $0FEC  [$7E:0FEC]  ; Phantoon reversed movement flag = 0
$A7:D714 A9 01 00    LDA #$0001             ;\
$A7:D717 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Phantoon speed = 1.0
$A7:D71A 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ;/
$A7:D71D 9C B6 0F    STZ $0FB6  [$7E:0FB6]  ; Phantoon flame rain flag triggered flag = 0
$A7:D720 20 76 D0    JSR $D076  [$A7:D076]  ; Pick new Phantoon pattern
$A7:D723 A9 2D D7    LDA #$D72D             ;\
$A7:D726 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D72D
$A7:D729 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:D72C 60          RTS
}


;;; $D72D: Phantoon function - hiding before figure-8 - fading in ;;;
{
$A7:D72D A9 0C 00    LDA #$000C             ;\
$A7:D730 20 86 D4    JSR $D486  [$A7:D486]  ;} Advance Phantoon fade in
$A7:D733 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D736 F0 06       BEQ $06    [$D73E]     ;} If fade complete:
$A7:D738 A9 E7 D5    LDA #$D5E7             ;\
$A7:D73B 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Phantoon function = $D5E7 (figure-8)

$A7:D73E 60          RTS
}
}


;;; $D73F..D85B: Phantoon function - flame rain ;;;
{
;;; $D73F: Phantoon function - flame rain - show Phantoon ;;;
{
$A7:D73F 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:D742 AD 88 19    LDA $1988  [$7E:1988]  ;\
$A7:D745 29 FF BF    AND #$BFFF             ;} Make Phantoon opaque
$A7:D748 8D 88 19    STA $1988  [$7E:1988]  ;/
$A7:D74B A9 01 00    LDA #$0001             ;\
$A7:D74E 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Phantoon body instruction timer = 1
$A7:D751 8D D4 0F    STA $0FD4  [$7E:0FD4]  ; Phantoon eye instruction timer = 1
$A7:D754 A9 47 CC    LDA #$CC47             ;\
$A7:D757 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Phantoon body instruction list pointer = $CC47 (full hitbox)
$A7:D75A A9 9D CC    LDA #$CC9D             ;\
$A7:D75D 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Phantoon eye instruction list pointer = $CC9D (eyeball - centred)
$A7:D760 A9 67 D7    LDA #$D767             ;\
$A7:D763 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D767
$A7:D766 60          RTS
}


;;; $D767: Phantoon function - flame rain - make Phantoon vulnerable ;;;
{
$A7:D767 A9 01 00    LDA #$0001             ;\
$A7:D76A 20 86 D4    JSR $D486  [$A7:D486]  ;| Advance Phantoon fade in
$A7:D76D AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D770 F0 15       BEQ $15    [$D787]     ;} If fade complete:
$A7:D772 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:D775 29 FF FB    AND #$FBFF             ;} Set Phantoon body as tangible
$A7:D778 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:D77B A9 88 D7    LDA #$D788             ;\
$A7:D77E 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D788
$A7:D781 A9 5A 00    LDA #$005A             ;\
$A7:D784 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} Phantoon function timer = 90

; BRANCH_WAITING
$A7:D787 60          RTS
}


;;; $D788: Phantoon function - flame rain - vulnerable window ;;;
{
$A7:D788 DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D78B F0 02       BEQ $02    [$D78F]     ;\
$A7:D78D 10 45       BPL $45    [$D7D4]     ;} If [Phantoon function timer] > 0: return

$A7:D78F 9E 2A 10    STZ $102A,x[$7E:102A]  ; Phantoon round damage = 0
$A7:D792 AD 28 10    LDA $1028  [$7E:1028]  ;\
$A7:D795 F0 0D       BEQ $0D    [$D7A4]     ;} If swooping triggered:
$A7:D797 9C 28 10    STZ $1028  [$7E:1028]  ; Phantoon swooping triggered flag = 0
$A7:D79A A9 01 00    LDA #$0001             ;\
$A7:D79D 8D B6 0F    STA $0FB6  [$7E:0FB6]  ;} Phantoon flame rain flag triggered flag = 1
$A7:D7A0 20 E1 D3    JSR $D3E1  [$A7:D3E1]  ; Start Phantoon swooping pattern
$A7:D7A3 60          RTS                    ; Return

$A7:D7A4 A9 D5 D7    LDA #$D7D5             ;\
$A7:D7A7 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D7D5
$A7:D7AA 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:D7AD A9 01 00    LDA #$0001             ;\
$A7:D7B0 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Phantoon body instruction timer = 1
$A7:D7B3 8D D4 0F    STA $0FD4  [$7E:0FD4]  ; Phantoon eye instruction timer = 1
$A7:D7B6 A9 41 CC    LDA #$CC41             ;\
$A7:D7B9 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Phantoon body instruction list pointer = $CC41 (invulnerable)
$A7:D7BC A9 91 CC    LDA #$CC91             ;\
$A7:D7BF 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Phantoon eye instruction list pointer = $CC91 (close)
$A7:D7C2 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:D7C5 09 00 04    ORA #$0400             ;} Set Phantoon body as intangible
$A7:D7C8 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:D7CB AD 88 19    LDA $1988  [$7E:1988]  ;\
$A7:D7CE 09 00 40    ORA #$4000             ;} Make Phantoon semi-transparent
$A7:D7D1 8D 88 19    STA $1988  [$7E:1988]  ;/

$A7:D7D4 60          RTS
}


;;; $D7D5: Phantoon function - flame rain - fading out ;;;
{
$A7:D7D5 A9 0C 00    LDA #$000C             ;\
$A7:D7D8 20 64 D4    JSR $D464  [$A7:D464]  ;} Advance Phantoon fade out
$A7:D7DB AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D7DE D0 01       BNE $01    [$D7E1]     ;} If fade complete not complete:
$A7:D7E0 60          RTS                    ; Return

$A7:D7E1 A9 F7 D7    LDA #$D7F7             ;\
$A7:D7E4 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D7F7
$A7:D7E7 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A7:D7EB 29 07 00    AND #$0007             ;\
$A7:D7EE 0A          ASL A                  ;|
$A7:D7EF A8          TAY                    ;} Phantoon function timer = [$CD63 + [random number] % 8 * 2]
$A7:D7F0 B9 63 CD    LDA $CD63,y[$A7:CD6B]  ;|
$A7:D7F3 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;/
$A7:D7F6 60          RTS
}


;;; $D7F7: Phantoon function - flame rain - subsequent flame rain ;;;
{
$A7:D7F7 DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D7FA F0 02       BEQ $02    [$D7FE]     ;\
$A7:D7FC 10 2B       BPL $2B    [$D829]     ;} If [Phantoon function timer] > 0: return

$A7:D7FE 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A7:D802 29 07 00    AND #$0007             ;\
$A7:D805 48          PHA                    ;|
$A7:D806 0A          ASL A                  ;} Y = [random number] % 8 * 8
$A7:D807 0A          ASL A                  ;|
$A7:D808 0A          ASL A                  ;|
$A7:D809 A8          TAY                    ;/
$A7:D80A B9 AD CD    LDA $CDAD,y[$A7:CDE5]  ;\
$A7:D80D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Phantoon movement index = [$CDAD + [Y]]
$A7:D810 B9 AF CD    LDA $CDAF,y[$A7:CDE7]  ;\
$A7:D813 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Phantoon X position = [$CDAD + [Y] + 2]
$A7:D816 B9 B1 CD    LDA $CDB1,y[$A7:CDE9]  ;\
$A7:D819 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Phantoon Y position = [$CDAD + [Y] + 4]
$A7:D81C 9C EC 0F    STZ $0FEC  [$7E:0FEC]  ; Phantoon reversed movement flag = 0
$A7:D81F A9 3F D7    LDA #$D73F             ;\
$A7:D822 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D73F
$A7:D825 68          PLA                    ;\
$A7:D826 20 8B CF    JSR $CF8B  [$A7:CF8B]  ;} Spawn flame rain enemy projectiles with pattern [random number] % 8

$A7:D829 60          RTS
}


;;; $D82A: Phantoon function - flame rain - initial flame rain ;;;
{
$A7:D82A A9 0C 00    LDA #$000C             ;\
$A7:D82D 20 64 D4    JSR $D464  [$A7:D464]  ;} Advance Phantoon fade out
$A7:D830 20 F1 D0    JSR $D0F1  [$A7:D0F1]  ; Adjust Phantoon speed and move Phantoon in figure-8
$A7:D833 20 CA CF    JSR $CFCA  [$A7:CFCA]  ; Handle casual flames
$A7:D836 CE E8 0F    DEC $0FE8  [$7E:0FE8]  ; Decrement Phantoon eye timer
$A7:D839 F0 02       BEQ $02    [$D83D]     ;\
$A7:D83B 10 1E       BPL $1E    [$D85B]     ;} If [Phantoon eye timer] >= 0: return

$A7:D83D 9C 28 10    STZ $1028  [$7E:1028]  ; Phantoon swooping triggered flag = 0
$A7:D840 A9 3F D7    LDA #$D73F             ;\
$A7:D843 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D73F
$A7:D846 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:D849 C9 80 00    CMP #$0080             ;} If [Phantoon X position] >= 80h:
$A7:D84C 30 07       BMI $07    [$D855]     ;/
$A7:D84E A9 02 00    LDA #$0002             ;\
$A7:D851 20 8B CF    JSR $CF8B  [$A7:CF8B]  ;} Spawn flame rain enemy projectiles with pattern 2
$A7:D854 60          RTS

$A7:D855 A9 00 00    LDA #$0000             ;\ Else ([Phantoon X position] < 80h):
$A7:D858 20 8B CF    JSR $CF8B  [$A7:CF8B]  ;} Spawn flame rain enemy projectiles with pattern 0

$A7:D85B 60          RTS
}
}


;;; $D85C..D92D: Phantoon function - enraged ;;;
{
;;; $D85C: Phantoon function - enraged - fading out before rage ;;;
{
$A7:D85C A9 0C 00    LDA #$000C             ;\
$A7:D85F 20 64 D4    JSR $D464  [$A7:D464]  ;} Advance Phantoon fade out
$A7:D862 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D865 F0 0C       BEQ $0C    [$D873]     ;} If fade complete:
$A7:D867 A9 74 D8    LDA #$D874             ;\
$A7:D86A 9D B2 0F    STA $0FB2,x            ;} Phantoon function = $D874
$A7:D86D A9 78 00    LDA #$0078             ;\
$A7:D870 9D B0 0F    STA $0FB0,x            ;} Phantoon function timer = 120

$A7:D873 60          RTS
}


;;; $D874: Phantoon function - enraged - hiding ;;;
{
$A7:D874 DE B0 0F    DEC $0FB0,x           ; Decrement Phantoon function timer
$A7:D877 F0 02       BEQ $02    [$D87B]    ;\
$A7:D879 10 15       BPL $15    [$D890]    ;} If [Phantoon function timer] > 0: return

$A7:D87B A9 91 D8    LDA #$D891            ;\
$A7:D87E 9D B2 0F    STA $0FB2,x           ;} Phantoon function = $D891
$A7:D881 A9 80 00    LDA #$0080            ;\
$A7:D884 8D 7A 0F    STA $0F7A  [$7E:0F7A] ;} Phantoon X position = 80h
$A7:D887 A9 20 00    LDA #$0020            ;\
$A7:D88A 8D 7E 0F    STA $0F7E  [$7E:0F7E] ;} Phantoon Y position = 20h
$A7:D88D 9C F2 0F    STZ $0FF2  [$7E:0FF2] ; Phantoon fade complete flag = 0

$A7:D890 60          RTS
}


;;; $D891: Phantoon function - enraged - fading in ;;;
{
$A7:D891 A9 0C 00    LDA #$000C             ;\
$A7:D894 20 86 D4    JSR $D486  [$A7:D486]  ;} Advance Phantoon fade in
$A7:D897 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D89A F0 0F       BEQ $0F    [$D8AB]     ;} If fade complete:
$A7:D89C A9 AC D8    LDA #$D8AC             ;\
$A7:D89F 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} Phantoon function = $D8AC
$A7:D8A2 A9 04 00    LDA #$0004             ;\
$A7:D8A5 9D B0 0F    STA $0FB0,x            ; Phantoon function timer = 4
$A7:D8A8 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon rage round counter = 0

$A7:D8AB 60          RTS
}


;;; $D8AC: Phantoon function - enraged - rage ;;;
{
$A7:D8AC DE B0 0F    DEC $0FB0,x            ; Decrement Phantoon function timer
$A7:D8AF F0 02       BEQ $02    [$D8B3]     ;\
$A7:D8B1 10 62       BPL $62    [$D915]     ;} If [Phantoon function timer] > 0: return

$A7:D8B3 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D8B6 89 01 00    BIT #$0001             ;} If [Phantoon rage round counter] & 1 != 0: go to BRANCH_ODD_WAVE
$A7:D8B9 D0 15       BNE $15    [$D8D0]     ;/
$A7:D8BB A0 06 00    LDY #$0006             ; Y = 6

; LOOP_EVEN_WAVE
$A7:D8BE 5A          PHY                    ;\
$A7:D8BF 98          TYA                    ;|
$A7:D8C0 09 00 02    ORA #$0200             ;|
$A7:D8C3 A0 29 9C    LDY #$9C29             ;} Spawn Phantoon destroyable flames enemy projectile with parameter 200h | [Y]
$A7:D8C6 22 27 80 86 JSL $868027[$86:8027]  ;|
$A7:D8CA 7A          PLY                    ;/
$A7:D8CB 88          DEY                    ; Decrement Y
$A7:D8CC 10 F0       BPL $F0    [$D8BE]     ; If [Y] >= 0: go to LOOP_EVEN_WAVE
$A7:D8CE 80 16       BRA $16    [$D8E6]     ; Go to BRANCH_MERGE

; BRANCH_ODD_WAVE
$A7:D8D0 A0 0F 00    LDY #$000F             ; Y = Fh

; LOOP_ODD_WAVE
$A7:D8D3 5A          PHY                    ;\
$A7:D8D4 98          TYA                    ;|
$A7:D8D5 09 00 02    ORA #$0200             ;|
$A7:D8D8 A0 29 9C    LDY #$9C29             ;|
$A7:D8DB 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Phantoon destroyable flames enemy projectile with parameter 200h | [Y]
$A7:D8DF 7A          PLY                    ;/
$A7:D8E0 88          DEY                    ; Decrement Y
$A7:D8E1 C0 08 00    CPY #$0008             ;\
$A7:D8E4 10 ED       BPL $ED    [$D8D3]     ;} If [Y] >= 8: go to LOOP_ODD_WAVE

; BRANCH_MERGE
$A7:D8E6 A9 29 00    LDA #$0029             ;\
$A7:D8E9 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 29h, sound library 3, max queued sounds allowed = 6 (Phantoon's super missiled attack)
$A7:D8ED AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D8F0 1A          INC A                  ;} Increment Phantoon rage round counter
$A7:D8F1 8D F2 0F    STA $0FF2  [$7E:0FF2]  ;/
$A7:D8F4 C9 08 00    CMP #$0008             ;\
$A7:D8F7 10 07       BPL $07    [$D900]     ;} If [Phantoon rage round counter] < 8:
$A7:D8F9 A9 80 00    LDA #$0080             ;\
$A7:D8FC 9D B0 0F    STA $0FB0,x            ;} Phantoon function timer = 80h
$A7:D8FF 60          RTS                    ; Return

$A7:D900 A9 01 00    LDA #$0001             ;\
$A7:D903 8D D4 0F    STA $0FD4  [$7E:0FD4]  ;} Phantoon eye instruction timer = 1
$A7:D906 A9 91 CC    LDA #$CC91             ;\
$A7:D909 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Phantoon eye instruction list pointer = $CC91 (close)
$A7:D90C 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:D90F A9 16 D9    LDA #$D916             ;\
$A7:D912 9D B2 0F    STA $0FB2,x            ;} Phantoon function = $D916

$A7:D915 60          RTS
}


;;; $D916: Phantoon function - enraged - fading out after rage ;;;
{
$A7:D916 A9 0C 00    LDA #$000C             ;\
$A7:D919 20 64 D4    JSR $D464  [$A7:D464]  ;} Advance Phantoon fade out
$A7:D91C AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D91F F0 0C       BEQ $0C    [$D92D]     ;} If fade complete:
$A7:D921 A9 D4 D6    LDA #$D6D4             ;\
$A7:D924 9D B2 0F    STA $0FB2,x            ;} Phantoon function = $D6D4 (hiding before figure-8)
$A7:D927 A9 78 00    LDA #$0078             ;\
$A7:D92A 9D B0 0F    STA $0FB0,x            ;} Phantoon function timer = 120

$A7:D92D 60          RTS
}
}


;;; $D92E: Phantoon function - swooping - fatal damage ;;;
{
$A7:D92E 20 FA D3    JSR $D3FA  [$A7:D3FA]  ; Make Phantoon look towards Samus
$A7:D931 20 D1 D2    JSR $D2D1  [$A7:D2D1]  ; Move Phantoon in swooping pattern
$A7:D934 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A7:D937 C9 60 00    CMP #$0060             ;|
$A7:D93A 30 0B       BMI $0B    [$D947]     ;} If 60h <= [Phantoon X position] < A0h:
$A7:D93C C9 A0 00    CMP #$00A0             ;|
$A7:D93F 10 06       BPL $06    [$D947]     ;/
$A7:D941 A9 48 D9    LDA #$D948             ;\
$A7:D944 9D B2 0F    STA $0FB2,x            ;} Phantoon function = $D948 (death sequence)

$A7:D947 60          RTS
}


;;; $D948..DB99: Phantoon function - death sequence - fading in and out ;;;
{
;;; $D948: Phantoon function - death sequence - fading in and out ;;;
{
$A7:D948 EA          NOP                    ; Woah, wild NOP appeared!
$A7:D949 AD EC 0F    LDA $0FEC  [$7E:0FEC]  ;\
$A7:D94C 89 01 00    BIT #$0001             ;} If [Phantoon fade counter] % 2 = 0:
$A7:D94F D0 0D       BNE $0D    [$D95E]     ;/
$A7:D951 A9 0C 00    LDA #$000C             ;\
$A7:D954 20 64 D4    JSR $D464  [$A7:D464]  ;} Advance Phantoon fade out
$A7:D957 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D95A D0 0D       BNE $0D    [$D969]     ;} If fade not complete:
$A7:D95C 80 2C       BRA $2C    [$D98A]     ; Return

$A7:D95E A9 0C 00    LDA #$000C             ;\ Else ([Phantoon fade counter] % 2 != 0):
$A7:D961 20 86 D4    JSR $D486  [$A7:D486]  ;} Advance Phantoon fade in
$A7:D964 AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:D967 F0 21       BEQ $21    [$D98A]     ;} If fade not complete: return

$A7:D969 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:D96C AD EC 0F    LDA $0FEC  [$7E:0FEC]  ;\
$A7:D96F 1A          INC A                  ;} Increment Phantoon fade counter
$A7:D970 8D EC 0F    STA $0FEC  [$7E:0FEC]  ;/
$A7:D973 C9 0A 00    CMP #$000A             ;\
$A7:D976 30 12       BMI $12    [$D98A]     ; If [Phantoon fade counter] >= Ah:
$A7:D978 A9 8B D9    LDA #$D98B             ;\
$A7:D97B 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D98B
$A7:D97E A9 0F 00    LDA #$000F             ;\
$A7:D981 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 15
$A7:D984 9C 32 10    STZ $1032  [$7E:1032]  ; Phantoon explosion index = 0
$A7:D987 9C A8 0F    STZ $0FA8  [$7E:0FA8]  ; Phantoon explosion loop counter = 0

$A7:D98A 60          RTS
}


;;; $D98B: Phantoon function - death sequence - exploding ;;;
{
$A7:D98B DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:D98E F0 03       BEQ $03    [$D993]     ;\
$A7:D990 30 01       BMI $01    [$D993]     ;} If [Phantoon function timer] > 0:
$A7:D992 60          RTS                    ; Return

$A7:D993 AD 32 10    LDA $1032  [$7E:1032]  ;\
$A7:D996 0A          ASL A                  ;|
$A7:D997 0A          ASL A                  ;} Y = [Phantoon explosion index] * 4
$A7:D998 A8          TAY                    ;/
$A7:D999 B9 1D DA    LDA $DA1D,y[$A7:DA1D]  ;\
$A7:D99C 29 FF 00    AND #$00FF             ;|
$A7:D99F 89 80 00    BIT #$0080             ;|
$A7:D9A2 F0 03       BEQ $03    [$D9A7]     ;|
$A7:D9A4 09 00 FF    ORA #$FF00             ;|
                                            ;} $12 = [Phantoon X position] + ±[$DA1D + [Y]]
$A7:D9A7 85 12       STA $12    [$7E:0012]  ;|
$A7:D9A9 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A7:D9AC 18          CLC                    ;|
$A7:D9AD 65 12       ADC $12    [$7E:0012]  ;|
$A7:D9AF 85 12       STA $12    [$7E:0012]  ;/
$A7:D9B1 B9 1E DA    LDA $DA1E,y[$A7:DA1E]  ;\
$A7:D9B4 29 FF 00    AND #$00FF             ;|
$A7:D9B7 89 80 00    BIT #$0080             ;|
$A7:D9BA F0 03       BEQ $03    [$D9BF]     ;|
$A7:D9BC 09 00 FF    ORA #$FF00             ;|
                                            ;} $14 = [Phantoon Y position] + ±[$DA1D + 1 + [Y]]
$A7:D9BF 85 14       STA $14    [$7E:0014]  ;|
$A7:D9C1 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;|
$A7:D9C4 18          CLC                    ;|
$A7:D9C5 65 14       ADC $14    [$7E:0014]  ;|
$A7:D9C7 85 14       STA $14    [$7E:0014]  ;/
$A7:D9C9 5A          PHY
$A7:D9CA B9 1F DA    LDA $DA1F,y[$A7:DA1F]  ;\
$A7:D9CD 29 FF 00    AND #$00FF             ;} A = [$DA1D + 2 + [Y]]
$A7:D9D0 48          PHA
$A7:D9D1 A0 09 E5    LDY #$E509             ;\
$A7:D9D4 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A7:D9D8 68          PLA
$A7:D9D9 C9 1D 00    CMP #$001D             ;\
$A7:D9DC D0 09       BNE $09    [$D9E7]     ;} If [A] = 1Dh:
$A7:D9DE A9 24 00    LDA #$0024             ;\
$A7:D9E1 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
$A7:D9E5 80 07       BRA $07    [$D9EE]

$A7:D9E7 A9 2B 00    LDA #$002B             ;\ Else ([A] != 1Dh):
$A7:D9EA 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 2Bh, sound library 2, max queued sounds allowed = 6 (Phantoon exploding)

$A7:D9EE 7A          PLY
$A7:D9EF B9 20 DA    LDA $DA20,y[$A7:DA20]  ;\
$A7:D9F2 29 FF 00    AND #$00FF             ;|
$A7:D9F5 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = [$DA1D + 3 + [Y]]
$A7:D9F8 AD 32 10    LDA $1032  [$7E:1032]  ;\
$A7:D9FB 1A          INC A                  ;} Increment Phantoon explosion index
$A7:D9FC 8D 32 10    STA $1032  [$7E:1032]  ;/
$A7:D9FF C9 0D 00    CMP #$000D             ;\
$A7:DA02 30 18       BMI $18    [$DA1C]     ;} If [Phantoon explosion index] >= Dh:
$A7:DA04 A9 05 00    LDA #$0005             ;\
$A7:DA07 8D 32 10    STA $1032  [$7E:1032]  ;} Phantoon explosion index = 5
$A7:DA0A AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A7:DA0D 1A          INC A                  ;} Increment Phantoon explosion loop counter
$A7:DA0E 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;/
$A7:DA11 C9 03 00    CMP #$0003             ;\
$A7:DA14 30 06       BMI $06    [$DA1C]     ;} If [Phantoon explosion loop counter] >= 3:
$A7:DA16 A9 51 DA    LDA #$DA51             ;\
$A7:DA19 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $DA51

$A7:DA1C 60          RTS

;                        ____________ X offset
;                       |   _________ Y offset
;                       |  |  _______ Explosion type. 3 = small, 1Dh = big
;                       |  |  |   ___ Timer
;                       |  |  |  |
$A7:DA1D             db 00,00,1D,10, ;\
                        20,E0,1D,10, ;|
                        E0,20,1D,10, ;} Once
                        E0,E0,1D,10, ;|
                        20,20,1D,20, ;/
                        E0,F8,1D,08, ;\
                        00,00,03,08, ;|
                        20,F8,1D,08, ;|
                        00,00,03,08, ;|
                        00,18,03,08, ;} 3 times
                        00,30,1D,08, ;|
                        E8,18,03,08, ;|
                        18,18,03,08  ;/
}


;;; $DA51: Phantoon function - death sequence - set up wavy mosaic Phantoon ;;;
{
$A7:DA51 AD A3 CD    LDA $CDA3  [$A7:CDA3]  ;\
$A7:DA54 85 16       STA $16    [$7E:0016]  ;} Wavy Phantoon phase delta = 8
$A7:DA56 A9 01 00    LDA #$0001             ; Next wavy Phantoon mode = 1 (doubled wavelength)
$A7:DA59 22 87 E4 88 JSL $88E487[$88:E487]  ; Spawn wavy Phantoon HDMA object
$A7:DA5D 9C 6E 10    STZ $106E  [$7E:106E]  ; Wavy Phantoon amplitude = 0
$A7:DA60 A9 86 DA    LDA #$DA86             ;\
$A7:DA63 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $DA86
$A7:DA66 A9 02 00    LDA #$0002             ;\
$A7:DA69 8D EC 0F    STA $0FEC  [$7E:0FEC]  ;} Phantoon mosaic options = 2 (BG2 enabled, block size 1x1)
$A7:DA6C AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:DA6F 29 FF DF    AND #$DFFF             ;|
$A7:DA72 09 00 05    ORA #$0500             ;|
$A7:DA75 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;} Set Phantoon eye/tentacles/mouth to not process instructions, be intangible and invisible
$A7:DA78 8D 06 10    STA $1006  [$7E:1006]  ;|
$A7:DA7B 8D 46 10    STA $1046  [$7E:1046]  ;/
$A7:DA7E A9 7E 00    LDA #$007E             ;\
$A7:DA81 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 7Eh, sound library 2, max queued sounds allowed = 6 (Phantoon's dying cry)
$A7:DA85 60          RTS
}


;;; $DA86: Phantoon function - death sequence - wavy mosaic Phantoon ;;;
{
$A7:DA86 AD 9F CD    LDA $CD9F  [$A7:CD9F]  ;\
$A7:DA89 85 12       STA $12    [$7E:0012]  ;} $12 = 100h (amplitude delta)
$A7:DA8B AD A1 CD    LDA $CDA1  [$A7:CDA1]  ;\
$A7:DA8E 85 14       STA $14    [$7E:0014]  ;} $14 = F000h (max amplitude)
$A7:DA90 20 27 CF    JSR $CF27  [$A7:CF27]  ; Grow/shrink Phantoon wave amplitude
$A7:DA93 AD EC 0F    LDA $0FEC  [$7E:0FEC]  ;\
$A7:DA96 C9 FF FF    CMP #$FFFF             ;} If [Phantoon mosaic options] = FFFFh: go to BRANCH_DONE_MOSAIC
$A7:DA99 F0 2A       BEQ $2A    [$DAC5]     ;/
$A7:DA9B AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A7:DA9E 89 0F 00    BIT #$000F             ;} If [frame counter] % 10h != 0: return
$A7:DAA1 D0 33       BNE $33    [$DAD6]     ;/
$A7:DAA3 E2 20       SEP #$20
$A7:DAA5 AD EC 0F    LDA $0FEC  [$7E:0FEC]  ;\
$A7:DAA8 C9 F2       CMP #$F2               ;} If [Phantoon mosaic options] & FFh != F2h:
$A7:DAAA F0 0C       BEQ $0C    [$DAB8]     ;/
$A7:DAAC 18          CLC                    ;\
$A7:DAAD 69 10       ADC #$10               ;} Phantoon mosaic options += 1 << 4
$A7:DAAF 8D EC 0F    STA $0FEC  [$7E:0FEC]  ;/
$A7:DAB2 85 57       STA $57    [$7E:0057]  ; Mosaic size and enable = [Phantoon mosaic options]
$A7:DAB4 C2 20       REP #$20
$A7:DAB6 80 1E       BRA $1E    [$DAD6]

$A7:DAB8 C2 20       REP #$20
$A7:DABA A9 FF FF    LDA #$FFFF             ;\ Else ([Phantoon mosaic options] & FFh = F2h):
$A7:DABD 8D EC 0F    STA $0FEC  [$7E:0FEC]  ;} Phantoon mosaic options = FFFFh
$A7:DAC0 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:DAC3 80 11       BRA $11    [$DAD6]     ; Return

; BRANCH_DONE_MOSAIC
$A7:DAC5 A9 0C 00    LDA #$000C             ;\
$A7:DAC8 20 64 D4    JSR $D464  [$A7:D464]  ;} Advance Phantoon fade out
$A7:DACB AD F2 0F    LDA $0FF2  [$7E:0FF2]  ;\
$A7:DACE F0 06       BEQ $06    [$DAD6]     ;} If fade complete:
$A7:DAD0 A9 D7 DA    LDA #$DAD7             ;\
$A7:DAD3 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $DAD7

$A7:DAD6 60          RTS
}


;;; $DAD7: Phantoon function - death sequence - clear graphics ;;;
{
$A7:DAD7 E2 20       SEP #$20               ;\
$A7:DAD9 64 57       STZ $57    [$7E:0057]  ;} Disable mosaic
$A7:DADB C2 20       REP #$20               ;/
$A7:DADD 9C F4 0F    STZ $0FF4  [$7E:0FF4]  ; Disable wavy Phantoon
$A7:DAE0 AD 88 19    LDA $1988  [$7E:1988]  ;\
$A7:DAE3 29 FF BF    AND #$BFFF             ;} Make Phantoon opaque
$A7:DAE6 8D 88 19    STA $1988  [$7E:1988]  ;/
$A7:DAE9 A9 FF FF    LDA #$FFFF             ;\
$A7:DAEC 8D 74 10    STA $1074  [$7E:1074]  ;} Phantoon semi-transparency HDMA object control = FFFFh (delete Phantoon semi-transparency HDMA object)
$A7:DAEF A9 3D DB    LDA #$DB3D             ;\
$A7:DAF2 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $DB3D
$A7:DAF5 A9 3C 00    LDA #$003C             ;\
$A7:DAF8 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 60
$A7:DAFB 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:DAFE A9 80 01    LDA #$0180             ;\
$A7:DB01 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Phantoon X position = 180h (not sure why position matters here)
$A7:DB04 A9 80 00    LDA #$0080             ;\
$A7:DB07 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Phantoon Y position = 80h
$A7:DB0A A2 FE 03    LDX #$03FE             ;\
$A7:DB0D A9 38 03    LDA #$0338             ;|
                                            ;|
$A7:DB10 9F 00 20 7E STA $7E2000,x[$7E:23FE];} $7E:2000..23FF = 0338h
$A7:DB14 CA          DEX                    ;|
$A7:DB15 CA          DEX                    ;|
$A7:DB16 10 F8       BPL $F8    [$DB10]     ;/
$A7:DB18 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A7:DB1B A9 00 04    LDA #$0400             ;|
$A7:DB1E 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A7:DB20 E8          INX                    ;|
$A7:DB21 E8          INX                    ;|
$A7:DB22 A9 00 20    LDA #$2000             ;|
$A7:DB25 95 D0       STA $D0,x  [$7E:00D2]  ;|
$A7:DB27 E8          INX                    ;|
$A7:DB28 E8          INX                    ;|
$A7:DB29 E2 20       SEP #$20               ;} Queue transfer of 400h bytes from $7E:2000 to VRAM $4800 (BG2 tilemap)
$A7:DB2B A9 7E       LDA #$7E               ;|
$A7:DB2D 95 D0       STA $D0,x  [$7E:00D4]  ;|
$A7:DB2F C2 20       REP #$20               ;|
$A7:DB31 E8          INX                    ;|
$A7:DB32 A9 00 48    LDA #$4800             ;|
$A7:DB35 95 D0       STA $D0,x  [$7E:00D5]  ;|
$A7:DB37 E8          INX                    ;|
$A7:DB38 E8          INX                    ;|
$A7:DB39 8E 30 03    STX $0330  [$7E:0330]  ;/
$A7:DB3C 60          RTS
}


;;; $DB3D: Phantoon function - death sequence - activate Wrecked Ship ;;;
{
$A7:DB3D DA          PHX
$A7:DB3E BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A7:DB41 F0 05       BEQ $05    [$DB48]     ;} If [Phantoon function timer] != 0:
$A7:DB43 DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement Phantoon function timer
$A7:DB46 FA          PLX
$A7:DB47 60          RTS                    ; Return

$A7:DB48 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A7:DB4B 89 03 00    BIT #$0003             ;} If [frame counter] % 4 != 0: return
$A7:DB4E D0 48       BNE $48    [$DB98]     ;/
$A7:DB50 A9 0C 00    LDA #$000C             ;\
$A7:DB53 8D EE 0F    STA $0FEE  [$7E:0FEE]  ;} Palette change denominator = Ch
$A7:DB56 20 5A DC    JSR $DC5A  [$A7:DC5A]  ; Advance Wrecked Ship power on palette transition
$A7:DB59 90 3D       BCC $3D    [$DB98]     ; If fade not complete: return
$A7:DB5B E2 20       SEP #$20               ;\
$A7:DB5D A5 69       LDA $69    [$7E:0069]  ;|
$A7:DB5F 09 02       ORA #$02               ;} Enable main screen BG2
$A7:DB61 85 69       STA $69    [$7E:0069]  ;|
$A7:DB63 C2 20       REP #$20               ;/
$A7:DB65 22 0B BA A0 JSL $A0BA0B[$A0:BA0B]  ; Phantoon death item drop routine
$A7:DB69 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:DB6C 09 00 02    ORA #$0200             ;} Flag Phantoon body for deletion
$A7:DB6F 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:DB72 8D C6 0F    STA $0FC6  [$7E:0FC6]  ; Flag Phantoon eye for deletion
$A7:DB75 8D 06 10    STA $1006  [$7E:1006]  ; Flag Phantoon tentacles for deletion
$A7:DB78 8D 46 10    STA $1046  [$7E:1046]  ; Flag Phantoon mouth for deletion
$A7:DB7B AE 9F 07    LDX $079F  [$7E:079F]  ;\
$A7:DB7E BF 28 D8 7E LDA $7ED828,x[$7E:D82B];|
$A7:DB82 09 01 00    ORA #$0001             ;} Set area boss as dead
$A7:DB85 9F 28 D8 7E STA $7ED828,x[$7E:D82B];/
$A7:DB89 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A7:DB8D             dx 00, 06, B78B        ;} Spawn PLM to restore Phantoon's door after boss fight
$A7:DB91 A9 03 00    LDA #$0003             ;\
$A7:DB94 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue elevator music track

$A7:DB98 FA          PLX
$A7:DB99 60          RTS
}
}


;;; $DB9A: Advance Phantoon fade out ;;;
{
;; Returns:
;;     Carry: Set if reached target colour, clear otherwise
$A7:DB9A C2 30       REP #$30
$A7:DB9C AD EE 0F    LDA $0FEE  [$7E:0FEE]  ;\
$A7:DB9F 1A          INC A                  ;|
$A7:DBA0 CD F0 0F    CMP $0FF0  [$7E:0FF0]  ;} If [Phantoon palette change numerator] > [Phantoon palette change denominator] + 1:
$A7:DBA3 B0 08       BCS $08    [$DBAD]     ;/
$A7:DBA5 A9 00 00    LDA #$0000             ;\
$A7:DBA8 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Phantoon palette change numerator = 0
$A7:DBAB 38          SEC                    ;\
$A7:DBAC 60          RTS                    ;} Return carry set
                                            
$A7:DBAD A2 00 00    LDX #$0000             ; X = 0

; LOOP
$A7:DBB0 DA          PHX
$A7:DBB1 BD 41 CA    LDA $CA41,x[$A7:CA41]  ;\
$A7:DBB4 A8          TAY                    ;|
$A7:DBB5 BF E0 C0 7E LDA $7EC0E0,x[$7E:C0E0];|
$A7:DBB9 AA          TAX                    ;|
$A7:DBBA AD F0 0F    LDA $0FF0  [$7E:0FF0]  ;} $7E:C0E0 + [X] = the [Phantoon palette change numerator]th transitional colour from [$7E:C0E0 + [X]] to 0
$A7:DBBD 20 95 DC    JSR $DC95  [$A7:DC95]  ;|
$A7:DBC0 FA          PLX                    ;|
$A7:DBC1 9F E0 C0 7E STA $7EC0E0,x[$7E:C0E0];/
$A7:DBC5 E8          INX                    ;\
$A7:DBC6 E8          INX                    ;} X += 2
$A7:DBC7 E0 20 00    CPX #$0020             ;\
$A7:DBCA 90 E4       BCC $E4    [$DBB0]     ;} If [X] < 20h: go to LOOP
$A7:DBCC AD F0 0F    LDA $0FF0  [$7E:0FF0]  ;\
$A7:DBCF 1A          INC A                  ;} Increment Phantoon palette change numerator
$A7:DBD0 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;/
$A7:DBD3 18          CLC                    ;\
$A7:DBD4 60          RTS                    ;} Return carry clear
}


;;; $DBD5: Advance Phantoon fade in ;;;
{
;; Returns:
;;     Carry: Set if reached target colour, clear otherwise
$A7:DBD5 C2 30       REP #$30
$A7:DBD7 AD EE 0F    LDA $0FEE  [$7E:0FEE]  ;\
$A7:DBDA 1A          INC A                  ;|
$A7:DBDB CD F0 0F    CMP $0FF0  [$7E:0FF0]  ;} If [Phantoon palette change numerator] > [Phantoon palette change denominator] + 1:
$A7:DBDE B0 08       BCS $08    [$DBE8]     ;/
$A7:DBE0 A9 00 00    LDA #$0000             ;\
$A7:DBE3 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Phantoon palette change numerator = 0
$A7:DBE6 38          SEC                    ;\
$A7:DBE7 60          RTS                    ;} Return carry set

$A7:DBE8 A2 00 00    LDX #$0000             ; X = 0

; LOOP
$A7:DBEB DA          PHX
$A7:DBEC 20 0F DC    JSR $DC0F  [$A7:DC0F]  ; Y = Phantoon health-based palette colour [X] / 2
$A7:DBEF BF E0 C0 7E LDA $7EC0E0,x[$7E:C0E0];\
$A7:DBF3 AA          TAX                    ;|
$A7:DBF4 AD F0 0F    LDA $0FF0  [$7E:0FF0]  ;|
$A7:DBF7 20 95 DC    JSR $DC95  [$A7:DC95]  ;} $7E:C0E0 + [X] = the [Phantoon palette change numerator]th transitional colour from [$7E:C0E0 + [X]] to [Y]
$A7:DBFA FA          PLX                    ;|
$A7:DBFB 9F E0 C0 7E STA $7EC0E0,x[$7E:C0E0];/
$A7:DBFF E8          INX                    ;\
$A7:DC00 E8          INX                    ;} X += 2
$A7:DC01 E0 20 00    CPX #$0020             ;\
$A7:DC04 90 E5       BCC $E5    [$DBEB]     ;} If [X] < 20h: go to LOOP
$A7:DC06 AD F0 0F    LDA $0FF0  [$7E:0FF0]  ;\
$A7:DC09 1A          INC A                  ;} Increment Phantoon palette change numerator
$A7:DC0A 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;/
$A7:DC0D 18          CLC                    ;\
$A7:DC0E 60          RTS                    ;} Return carry clear
}


;;; $DC0F: Get Phantoon health-based palette colour [X] / 2 ;;;
{
;; Returns:
;;     Y: [$CB41 + clamp(([enemy health] - 1) / 312, 0, 7) * 20h + [X]]

$A7:DC0F 86 18       STX $18    [$7E:0018]  ; $18 = [X]
$A7:DC11 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:DC14 A9 C4 09    LDA #$09C4             ;\
$A7:DC17 4A          LSR A                  ;|
$A7:DC18 4A          LSR A                  ;} $12 = 312
$A7:DC19 4A          LSR A                  ;|
$A7:DC1A 85 12       STA $12    [$7E:0012]  ;/
$A7:DC1C 85 14       STA $14    [$7E:0014]  ; $14 = [$12]
$A7:DC1E 64 16       STZ $16    [$7E:0016]  ; $16 = 0

; LOOP
$A7:DC20 A5 14       LDA $14    [$7E:0014]  ;\
$A7:DC22 DD 8C 0F    CMP $0F8C,x[$7E:0F8C]  ;} If [$14] < [enemy health]:
$A7:DC25 10 11       BPL $11    [$DC38]     ;/
$A7:DC27 A5 14       LDA $14    [$7E:0014]  ;\
$A7:DC29 18          CLC                    ;|
$A7:DC2A 65 12       ADC $12    [$7E:0012]  ;} $14 += [$12]
$A7:DC2C 85 14       STA $14    [$7E:0014]  ;/
$A7:DC2E A5 16       LDA $16    [$7E:0016]  ;\
$A7:DC30 1A          INC A                  ;} Increment $16
$A7:DC31 85 16       STA $16    [$7E:0016]  ;/
$A7:DC33 C9 07 00    CMP #$0007             ;\
$A7:DC36 30 E8       BMI $E8    [$DC20]     ;} If [$16] < 7: go to LOOP

$A7:DC38 A5 16       LDA $16    [$7E:0016]  ;\
$A7:DC3A 0A          ASL A                  ;|
$A7:DC3B A8          TAY                    ;|
$A7:DC3C B9 4A DC    LDA $DC4A,y[$A7:DC58]  ;|
$A7:DC3F 18          CLC                    ;} Y = [[$DC4A + [$16] * 2] + [$18]]
$A7:DC40 65 18       ADC $18    [$7E:0018]  ;|
$A7:DC42 A8          TAY                    ;|
$A7:DC43 B9 00 00    LDA $0000,y[$A7:CC21]  ;|
$A7:DC46 A8          TAY                    ;/
$A7:DC47 A6 18       LDX $18    [$7E:0018]  ; X = [$18]
$A7:DC49 60          RTS

$A7:DC4A             dw CB41, CB61, CB81, CBA1, CBC1, CBE1, CC01, CC21
}


;;; $DC5A: Advance Wrecked Ship power on palette transition ;;;
{
;; Returns:
;;     Carry: Set if reached target colour, clear otherwise
$A7:DC5A C2 30       REP #$30
$A7:DC5C AD EE 0F    LDA $0FEE  [$7E:0FEE]  ;\
$A7:DC5F 1A          INC A                  ;|
$A7:DC60 CD F0 0F    CMP $0FF0  [$7E:0FF0]  ;} If [Phantoon palette change numerator] > [Phantoon palette change denominator] + 1:
$A7:DC63 B0 08       BCS $08    [$DC6D]     ;/
$A7:DC65 A9 00 00    LDA #$0000             ;\
$A7:DC68 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;} Phantoon palette change numerator = 0
$A7:DC6B 38          SEC                    ;\
$A7:DC6C 60          RTS                    ;} Return carry set
                                            
$A7:DC6D A2 00 00    LDX #$0000             ; X = 0

; LOOP
$A7:DC70 DA          PHX
$A7:DC71 BD 61 CA    LDA $CA61,x[$A7:CA61]  ;\
$A7:DC74 A8          TAY                    ;} Y = [$CA61 + [X]]
$A7:DC75 BF 00 C0 7E LDA $7EC000,x[$7E:C000];\
$A7:DC79 AA          TAX                    ;|
$A7:DC7A AD F0 0F    LDA $0FF0  [$7E:0FF0]  ;|
$A7:DC7D 20 95 DC    JSR $DC95  [$A7:DC95]  ;} $7E:C000 + [X] = the [Phantoon palette change numerator]th transitional colour from [$7E:C000 + [X]] to [Y]
$A7:DC80 FA          PLX                    ;|
$A7:DC81 9F 00 C0 7E STA $7EC000,x[$7E:C000];/
$A7:DC85 E8          INX                    ;\
$A7:DC86 E8          INX                    ;} X += 2
$A7:DC87 E0 E0 00    CPX #$00E0             ;\
$A7:DC8A 90 E4       BCC $E4    [$DC70]     ;} If [X] < E0h: go to LOOP
$A7:DC8C AD F0 0F    LDA $0FF0  [$7E:0FF0]  ;\
$A7:DC8F 1A          INC A                  ;} Increment Phantoon palette change numerator
$A7:DC90 8D F0 0F    STA $0FF0  [$7E:0FF0]  ;/
$A7:DC93 18          CLC                    ;\
$A7:DC94 60          RTS                    ;} Return carry clear
}


;;; $DC95: Calculate the [A]th transitional colour from [X] to [Y] ;;;
{
;; Returns:
;;     A: Result colour

; Same as $82:DAA6, except palette change denominator is $0FEE instead of $C402
$A7:DC95 48          PHA
$A7:DC96 48          PHA
$A7:DC97 DA          PHX
$A7:DC98 5A          PHY
$A7:DC99 A3 01       LDA $01,s  [$7E:1FE0]
$A7:DC9B 29 1F 00    AND #$001F
$A7:DC9E A8          TAY
$A7:DC9F A3 03       LDA $03,s  [$7E:1FE2]
$A7:DCA1 29 1F 00    AND #$001F
$A7:DCA4 AA          TAX
$A7:DCA5 A3 05       LDA $05,s  [$7E:1FE4]
$A7:DCA7 20 F1 DC    JSR $DCF1  [$A7:DCF1]
$A7:DCAA 83 07       STA $07,s  [$7E:1FE6]
$A7:DCAC A3 01       LDA $01,s  [$7E:1FE0]
$A7:DCAE 0A          ASL A
$A7:DCAF 0A          ASL A
$A7:DCB0 0A          ASL A
$A7:DCB1 EB          XBA
$A7:DCB2 29 1F 00    AND #$001F
$A7:DCB5 A8          TAY
$A7:DCB6 A3 03       LDA $03,s  [$7E:1FE2]
$A7:DCB8 0A          ASL A
$A7:DCB9 0A          ASL A
$A7:DCBA 0A          ASL A
$A7:DCBB EB          XBA
$A7:DCBC 29 1F 00    AND #$001F
$A7:DCBF AA          TAX
$A7:DCC0 A3 05       LDA $05,s  [$7E:1FE4]
$A7:DCC2 20 F1 DC    JSR $DCF1  [$A7:DCF1]
$A7:DCC5 0A          ASL A
$A7:DCC6 0A          ASL A
$A7:DCC7 0A          ASL A
$A7:DCC8 0A          ASL A
$A7:DCC9 0A          ASL A
$A7:DCCA 03 07       ORA $07,s  [$7E:1FE6]
$A7:DCCC 83 07       STA $07,s  [$7E:1FE6]
$A7:DCCE A3 01       LDA $01,s  [$7E:1FE0]
$A7:DCD0 4A          LSR A
$A7:DCD1 4A          LSR A
$A7:DCD2 EB          XBA
$A7:DCD3 29 1F 00    AND #$001F
$A7:DCD6 A8          TAY
$A7:DCD7 A3 03       LDA $03,s  [$7E:1FE2]
$A7:DCD9 4A          LSR A
$A7:DCDA 4A          LSR A
$A7:DCDB EB          XBA
$A7:DCDC 29 1F 00    AND #$001F
$A7:DCDF AA          TAX
$A7:DCE0 A3 05       LDA $05,s  [$7E:1FE4]
$A7:DCE2 20 F1 DC    JSR $DCF1  [$A7:DCF1]
$A7:DCE5 0A          ASL A
$A7:DCE6 0A          ASL A
$A7:DCE7 EB          XBA
$A7:DCE8 03 07       ORA $07,s  [$7E:1FE6]
$A7:DCEA 83 07       STA $07,s  [$7E:1FE6]
$A7:DCEC 7A          PLY
$A7:DCED FA          PLX
$A7:DCEE 68          PLA
$A7:DCEF 68          PLA
$A7:DCF0 60          RTS
}


;;; $DCF1: Calculate the [A]th transitional colour component from [X] to [Y] ;;;
{
;; Returns:
;;     If [A] = 0:
;;         A = [X]
;;     If [A] = [Phantoon palette change denominator] + 1:
;;         A = [Y]
;;     Otherwise:
;;         A = [X] + ([Y] - [X]) / ([Phantoon palette change denominator] + 1 - [A])

; Same as $82:DAA6, except palette change denominator is $0FEE instead of $C402
$A7:DCF1 C9 00 00    CMP #$0000
$A7:DCF4 D0 02       BNE $02    [$DCF8]
$A7:DCF6 8A          TXA
$A7:DCF7 60          RTS

$A7:DCF8 3A          DEC A
$A7:DCF9 CD EE 0F    CMP $0FEE  [$7E:0FEE]
$A7:DCFC D0 02       BNE $02    [$DD00]
$A7:DCFE 98          TYA
$A7:DCFF 60          RTS

$A7:DD00 DA          PHX
$A7:DD01 1A          INC A
$A7:DD02 85 14       STA $14    [$7E:0014]
$A7:DD04 98          TYA
$A7:DD05 38          SEC
$A7:DD06 E3 01       SBC $01,s  [$7E:1FDC]
$A7:DD08 85 12       STA $12    [$7E:0012]
$A7:DD0A 10 04       BPL $04    [$DD10]
$A7:DD0C 49 FF FF    EOR #$FFFF
$A7:DD0F 1A          INC A

$A7:DD10 E2 21       SEP #$21
$A7:DD12 9C 04 42    STZ $4204  [$7E:4204]
$A7:DD15 8D 05 42    STA $4205  [$7E:4205]
$A7:DD18 AD EE 0F    LDA $0FEE  [$7E:0FEE]
$A7:DD1B E5 14       SBC $14    [$7E:0014]
$A7:DD1D 1A          INC A
$A7:DD1E 8D 06 42    STA $4206  [$7E:4206]
$A7:DD21 C2 20       REP #$20
$A7:DD23 EA          NOP
$A7:DD24 EA          NOP
$A7:DD25 EA          NOP
$A7:DD26 EA          NOP
$A7:DD27 EA          NOP
$A7:DD28 AD 14 42    LDA $4214  [$7E:4214]
$A7:DD2B 24 12       BIT $12    [$7E:0012]
$A7:DD2D 10 04       BPL $04    [$DD33]
$A7:DD2F 49 FF FF    EOR #$FFFF
$A7:DD32 1A          INC A

$A7:DD33 85 12       STA $12    [$7E:0012]
$A7:DD35 68          PLA
$A7:DD36 EB          XBA
$A7:DD37 18          CLC
$A7:DD38 65 12       ADC $12    [$7E:0012]
$A7:DD3A EB          XBA
$A7:DD3B 29 FF 00    AND #$00FF
$A7:DD3E 60          RTS
}


;;; $DD3F: Hurt AI - enemy $E4BF (Phantoon) ;;;
{
$A7:DD3F 08          PHP
$A7:DD40 C2 30       REP #$30
$A7:DD42 AD 9C 0F    LDA $0F9C  [$7E:0F9C]  ;\
$A7:DD45 C9 08 00    CMP #$0008             ;} If [Phantoon flash timer] != 8:
$A7:DD48 F0 10       BEQ $10    [$DD5A]     ;/
$A7:DD4A AD A4 0F    LDA $0FA4  [$7E:0FA4]  ;\
$A7:DD4D 89 02 00    BIT #$0002             ;} If [Phantoon frame counter] / 2 % 2 != 0: go to BRANCH_WHITE
$A7:DD50 D0 22       BNE $22    [$DD74]     ;/
$A7:DD52 AD 36 10    LDA $1036  [$7E:1036]  ;\
$A7:DD55 89 00 FF    BIT #$FF00             ;} If [Phantoon hurt flash palette loaded flag] = 0: return
$A7:DD58 F0 39       BEQ $39    [$DD93]     ;/

$A7:DD5A A2 1E 00    LDX #$001E             ;\
                                            ;|
$A7:DD5D 20 0F DC    JSR $DC0F  [$A7:DC0F]  ;|
$A7:DD60 98          TYA                    ;|
$A7:DD61 9F E0 C0 7E STA $7EC0E0,x[$7E:C0FE];} BG1/2 palette 7 = (Phantoon health-based palette)
$A7:DD65 CA          DEX                    ;|
$A7:DD66 CA          DEX                    ;|
$A7:DD67 10 F4       BPL $F4    [$DD5D]     ;/
$A7:DD69 AD 36 10    LDA $1036  [$7E:1036]  ;\
$A7:DD6C 29 FF 00    AND #$00FF             ;} Phantoon hurt flash palette loaded flag = 0
$A7:DD6F 8D 36 10    STA $1036  [$7E:1036]  ;/
$A7:DD72 80 1F       BRA $1F    [$DD93]     ; Return

; BRANCH_WHITE
$A7:DD74 AD 36 10    LDA $1036  [$7E:1036]  ;\
$A7:DD77 89 00 FF    BIT #$FF00             ;} If [Phantoon hurt flash palette loaded flag] != 0: return
$A7:DD7A D0 17       BNE $17    [$DD93]     ;/
$A7:DD7C A2 1E 00    LDX #$001E             ;\
                                            ;|
$A7:DD7F A9 FF 7F    LDA #$7FFF             ;|
$A7:DD82 9F E0 C0 7E STA $7EC0E0,x[$7E:C0FE];} BG1/2 palette 7 = 7FFFh
$A7:DD86 CA          DEX                    ;|
$A7:DD87 CA          DEX                    ;|
$A7:DD88 10 F5       BPL $F5    [$DD7F]     ;/
$A7:DD8A AD 36 10    LDA $1036  [$7E:1036]  ;\
$A7:DD8D 09 00 01    ORA #$0100             ;} Phantoon hurt flash palette loaded flag = 1
$A7:DD90 8D 36 10    STA $1036  [$7E:1036]  ;/

$A7:DD93 28          PLP
$A7:DD94 6B          RTL
}


;;; $DD95: Enemy touch - enemy $E4BF (Phantoon) ;;;
{
$A7:DD95 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal enemy touch AI - no death check
$A7:DD99 6B          RTL
}


;;; $DD9A: RTL. Power bomb reaction - enemy $E4BF (Phantoon) ;;;
{
$A7:DD9A 6B          RTL
}


;;; $DD9B: Enemy shot - enemy $E4BF (Phantoon) ;;;
{
$A7:DD9B 8B          PHB
$A7:DD9C AD B2 0F    LDA $0FB2  [$7E:0FB2]  ;\
$A7:DD9F C9 48 D9    CMP #$D948             ;} If [Phantoon function] >= $D948 (death sequence):
$A7:DDA2 30 02       BMI $02    [$DDA6]     ;/
$A7:DDA4 AB          PLB
$A7:DDA5 6B          RTL                    ; Return

$A7:DDA6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:DDA9 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ; A = [enemy health]
$A7:DDAC 48          PHA                    ;\
$A7:DDAD 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ;} Normal enemy shot AI - no death check, no enemy shot graphic
$A7:DDB1 68          PLA                    ;/
$A7:DDB2 85 12       STA $12    [$7E:0012]  ; $12 = [A] (old enemy health)
$A7:DDB4 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ;\
$A7:DDB7 D0 1B       BNE $1B    [$DDD4]     ;} If [enemy health] != 0: go to BRANCH_ALIVE
$A7:DDB9 A9 73 00    LDA #$0073             ;\
$A7:DDBC 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 73h, sound library 2, max queued sounds allowed = 6 (Phantoon's cry)
$A7:DDC0 A9 01 00    LDA #$0001             ;\
$A7:DDC3 8D 36 10    STA $1036  [$7E:1036]  ;} $1036 = 1, Phantoon hurt flash palette loaded flag = 0
$A7:DDC6 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:DDC9 09 00 04    ORA #$0400             ;} Set Phantoon body as intangible
$A7:DDCC 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:DDCF 20 21 D4    JSR $D421  [$A7:D421]  ; Start Phantoon death sequence

$A7:DDD2 AB          PLB
$A7:DDD3 6B          RTL                    ; Return

; BRANCH_ALIVE
$A7:DDD4 BD 8A 0F    LDA $0F8A,x[$7E:0F8A]  ;\
$A7:DDD7 89 02 00    BIT #$0002             ;} If enemy hurt AI is not enabled: return
$A7:DDDA F0 F6       BEQ $F6    [$DDD2]     ;/
$A7:DDDC A9 73 00    LDA #$0073             ;\
$A7:DDDF 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 73h, sound library 2, max queued sounds allowed = 6 (Phantoon's cry)
$A7:DDE3 BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$A7:DDE6 C9 0D D6    CMP #$D60D             ;} If [Phantoon function] = $D60D (figure-8 - vulnerable window): go to BRANCH_VULNERABLE_WINDOW
$A7:DDE9 F0 43       BEQ $43    [$DE2E]     ;/
$A7:DDEB C9 88 D7    CMP #$D788             ;\
$A7:DDEE F0 3E       BEQ $3E    [$DE2E]     ;} If [Phantoon function] = $D788 (flame rain - vulnerable window): go to BRANCH_VULNERABLE_WINDOW
$A7:DDF0 C9 78 D6    CMP #$D678             ;\
$A7:DDF3 F0 03       BEQ $03    [$DDF8]     ;} If [Phantoon function] = $D678 (swooping - opaque): go to BRANCH_SWOOPING
$A7:DDF5 4C 92 DE    JMP $DE92  [$A7:DE92]  ; Go to BRANCH_RETURN

; BRANCH_SWOOPING
$A7:DDF8 A5 12       LDA $12    [$7E:0012]  ;\
$A7:DDFA 38          SEC                    ;|
$A7:DDFB FD 8C 0F    SBC $0F8C,x[$7E:0F8C]  ;} $12 (shot damage) = (old enemy health) - [enemy health]
$A7:DDFE 85 12       STA $12    [$7E:0012]  ;/
$A7:DE00 C9 2C 01    CMP #$012C             ;\
$A7:DE03 30 13       BMI $13    [$DE18]     ;} If (shot damage) >= 300: (just in case a super does less than 300 damage? >_<;)
$A7:DE05 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A7:DE08 0A          ASL A                  ;|
$A7:DE09 A8          TAY                    ;|
$A7:DE0A B9 18 0C    LDA $0C18,y            ;} If projectile is super missile:
$A7:DE0D 29 00 0F    AND #$0F00             ;|
$A7:DE10 C9 00 02    CMP #$0200             ;|
$A7:DE13 D0 03       BNE $03    [$DE18]     ;/
$A7:DE15 4C D5 DE    JMP $DED5  [$A7:DED5]  ; Go to BRANCH_ENRAGED

$A7:DE18 BD 2A 10    LDA $102A,x[$7E:102A]  ;\
$A7:DE1B 18          CLC                    ;|
$A7:DE1C 65 12       ADC $12    [$7E:0012]  ;} Phantoon round damage += (shot damage)
$A7:DE1E 9D 2A 10    STA $102A,x[$7E:102A]  ;/
$A7:DE21 C9 2C 01    CMP #$012C             ;\
$A7:DE24 30 6C       BMI $6C    [$DE92]     ;} If [Phantoon round damage] < 300: go to BRANCH_RETURN
$A7:DE26 A9 01 00    LDA #$0001             ;\
$A7:DE29 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Phantoon function timer = 1
$A7:DE2C 80 64       BRA $64    [$DE92]     ; Go to BRANCH_RETURN

; BRANCH_VULNERABLE_WINDOW
$A7:DE2E A5 12       LDA $12    [$7E:0012]  ;\
$A7:DE30 38          SEC                    ;|
$A7:DE31 FD 8C 0F    SBC $0F8C,x[$7E:0F8C]  ;} $12 (shot damage) = (old enemy health) - [enemy health]
$A7:DE34 85 12       STA $12    [$7E:0012]  ;/
$A7:DE36 C9 2C 01    CMP #$012C             ;\
$A7:DE39 30 13       BMI $13    [$DE4E]     ;} If (shot damage) >= 300: (just in case a super does less than 300 damage? >_<;)
$A7:DE3B AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A7:DE3E 0A          ASL A                  ;|
$A7:DE3F A8          TAY                    ;|
$A7:DE40 B9 18 0C    LDA $0C18,y            ;} If projectile is super missile:
$A7:DE43 29 00 0F    AND #$0F00             ;|
$A7:DE46 C9 00 02    CMP #$0200             ;|
$A7:DE49 D0 03       BNE $03    [$DE4E]     ;/
$A7:DE4B 4C D5 DE    JMP $DED5  [$A7:DED5]  ; Go to BRANCH_ENRAGED

$A7:DE4E BD 2A 10    LDA $102A,x[$7E:102A]  ;\
$A7:DE51 18          CLC                    ;|
$A7:DE52 65 12       ADC $12    [$7E:0012]  ;} Phantoon round damage += (shot damage)
$A7:DE54 9D 2A 10    STA $102A,x[$7E:102A]  ;/
$A7:DE57 C9 2C 01    CMP #$012C             ;\
$A7:DE5A 10 3E       BPL $3E    [$DE9A]     ;} If [Phantoon round damage] >= 300: go to BRANCH_NEXT_ROUND
$A7:DE5C 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A7:DE60 29 07 00    AND #$0007             ;\
$A7:DE63 A8          TAY                    ;} Y = [random number] % 8
$A7:DE64 B9 A5 CD    LDA $CDA5,y[$A7:CDA5]  ;\
$A7:DE67 29 FF 00    AND #$00FF             ;} $0FEA = [$CDA5 + [Y]]
$A7:DE6A 8D EA 0F    STA $0FEA  [$7E:0FEA]  ;/
$A7:DE6D 98          TYA                    ;\
$A7:DE6E 8D 76 10    STA $1076  [$7E:1076]  ;} $1076 = [Y]
$A7:DE71 A9 01 00    LDA #$0001             ;\
$A7:DE74 8D 36 10    STA $1036  [$7E:1036]  ;} $1036 = 1, Phantoon hurt flash palette loaded flag = 0
$A7:DE77 AD 28 10    LDA $1028  [$7E:1028]  ;\
$A7:DE7A D0 14       BNE $14    [$DE90]     ;} If swooping flag is not set:
$A7:DE7C A9 01 00    LDA #$0001             ;\
$A7:DE7F 8D 28 10    STA $1028  [$7E:1028]  ;} Set swooping flag
$A7:DE82 BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A7:DE85 C9 10 00    CMP #$0010             ;|
$A7:DE88 30 06       BMI $06    [$DE90]     ;} Phantoon function timer = min(10h, [Phantoon function timer])
$A7:DE8A A9 10 00    LDA #$0010             ;|
$A7:DE8D 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;/

$A7:DE90 AB          PLB
$A7:DE91 6B          RTL                    ; Return

; BRANCH_RETURN
$A7:DE92 A9 02 00    LDA #$0002             ;\
$A7:DE95 8D 36 10    STA $1036  [$7E:1036]  ;} $1036 = 2, Phantoon hurt flash palette loaded flag = 0
$A7:DE98 AB          PLB
$A7:DE99 6B          RTL

; BRANCH_NEXT_ROUND
$A7:DE9A A9 B9 D6    LDA #$D6B9             ;\
$A7:DE9D 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Phantoon function = $D6B9 (swooping - fading out)

; BRANCH_NEXT_ROUND_OR_ENRAGED
$A7:DEA0 9E B0 0F    STZ $0FB0,x[$7E:0FB0]  ; Phantoon function timer = 0
$A7:DEA3 9C 28 10    STZ $1028  [$7E:1028]  ; Clear swooping flag
$A7:DEA6 9E 2A 10    STZ $102A,x[$7E:102A]  ; Phantoon round damage = 0
$A7:DEA9 AD 88 19    LDA $1988  [$7E:1988]  ;\
$A7:DEAC 09 00 40    ORA #$4000             ;} Make Phantoon semi-transparent
$A7:DEAF 8D 88 19    STA $1988  [$7E:1988]  ;/
$A7:DEB2 A9 01 00    LDA #$0001             ;\
$A7:DEB5 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Phantoon body instruction timer = 1
$A7:DEB8 8D D4 0F    STA $0FD4  [$7E:0FD4]  ; Phantoon eye instruction timer = 1
$A7:DEBB A9 41 CC    LDA #$CC41             ;\
$A7:DEBE 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Phantoon body instruction list pointer = $CC41 (invulnerable)
$A7:DEC1 A9 91 CC    LDA #$CC91             ;\
$A7:DEC4 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Phantoon eye instruction list pointer = $CC91 (close)
$A7:DEC7 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A7:DECA 09 00 04    ORA #$0400             ;} Set Phantoon body as intangible
$A7:DECD 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A7:DED0 9C F2 0F    STZ $0FF2  [$7E:0FF2]  ; Phantoon fade complete flag = 0
$A7:DED3 80 BD       BRA $BD    [$DE92]     ; Go to BRANCH_RETURN

; BRANCH_ENRAGED
$A7:DED5 A9 5C D8    LDA #$D85C             ;\
$A7:DED8 9D B2 0F    STA $0FB2,x            ;} Phantoon function = $D85C (enraged)
$A7:DEDB 80 C3       BRA $C3    [$DEA0]     ; Go to BRANCH_NEXT_ROUND_OR_ENRAGED
}


;;; $DEDD: Extended spritemaps ;;;
{
; Body
$A7:DEDD             dx 0001, 0000,0000,E0AA,E020 ; Invulnerable
$A7:DEE7             dx 0001, 0000,0000,E0AA,E02E ; Full hitbox
$A7:DEF1             dx 0001, 0000,0000,E0AA,E06C ; Eye hitbox only

; Eye
$A7:DEFB             dx 0001, 0000,0000,E236,E020 ; Closed
$A7:DF05             dx 0001, 0000,0000,E236,E020 ; Opening
$A7:DF0F             dx 0001, 0000,0000,E202,E020 ; Opening / closing
$A7:DF19             dx 0001, 0000,0000,E1CE,E020 ; Open

; Eyeball
$A7:DF23             dx 0001, 0000,0000,E26A,E020 ; Centred
$A7:DF2D             dx 0001, 0000,0000,E27E,E020 ; Looking up
$A7:DF37             dx 0001, 0000,0000,E292,E020 ; Looking up-right
$A7:DF41             dx 0001, 0000,0000,E2A6,E020 ; Looking left
$A7:DF4B             dx 0001, 0000,0000,E2BA,E020 ; Looking right
$A7:DF55             dx 0001, 0000,0000,E2CE,E020 ; Looking down-left
$A7:DF5F             dx 0001, 0000,0000,E2E2,E020 ; Looking down-right
$A7:DF69             dx 0001, 0000,0000,E2F6,E020 ; Looking up-left
$A7:DF73             dx 0001, 0000,0000,E30A,E020 ; Looking up-right

; Tentacles
$A7:DF7D             dx 0002, 0000,0000,E31E,E020, 0000,0000,E34E,E020 ;\
$A7:DF8F             dx 0002, 0000,0000,E32E,E020, 0000,0000,E35E,E020 ;} Unused clone of below
$A7:DFA1             dx 0002, 0000,0000,E33E,E020, 0000,0000,E36E,E020 ;/
$A7:DFB3             dx 0002, 0000,0000,E31E,E020, 0000,0000,E34E,E020 ;\
$A7:DFC5             dx 0002, 0000,0000,E32E,E020, 0000,0000,E35E,E020 ;} Normal
$A7:DFD7             dx 0002, 0000,0000,E33E,E020, 0000,0000,E36E,E020 ;/

; Mouth
$A7:DFE9             dx 0001, 0000,0000,E37E,E020 ; Normal
$A7:DFF3             dx 0001, 0000,0000,E39A,E020 ;\
$A7:DFFD             dx 0001, 0000,0000,E3B6,E020 ;} Spawning flame
$A7:E007             dx 0001, 0000,0000,E37E,E020 ; Unused
}


;;; $E011: RTL. Initialisation AI - enemy $E53F/$E57F (Phantoon) ;;;
{
$A7:E011 6B          RTL
}


;;; $E012: Hitboxes ;;;
{
$A7:E012             dx 0001, FFF7,FFF0,0008,0010,DD95,DD9B ; Unused
$A7:E020             dx 0001, 0000,0000,0000,0000,804C,804C
$A7:E02E             dx 0005, FFDF,FFD8,0020,0038,DD95,DD9B, FFF7,0016,0008,0027,DD95,DD9B, FFE9,0034,FFF0,0047,DD95,DD9B, 000F,0035,0016,0046,DD95,DD9B, FFF4,0035,000B,0045,DD95,DD9B
$A7:E06C             dx 0001, FFF7,0016,0008,0027,DD95,DD9B
}


;;; $E07A: Spritemaps / extended tilemaps ;;;
{
; Unused flame spritemaps
$A7:E07A             dx 0002, 81F8,00,2106, 81F8,F0,2100
$A7:E086             dx 0002, 81F8,00,2108, 81F8,F0,2102
$A7:E092             dx 0002, 81F8,00,210A, 81F8,F0,2104
$A7:E09E             dx 0002, 8000,F8,610C, 81F0,F8,210C

; Body
$A7:E0AA             dx FFFE,
                        2000,000A, 2338,2338,2338,3D32,3D33,7D33,7D32,2338,2338,2338,
                        2040,000A, 2338,3D40,3D41,3D42,3D43,7D43,7D42,7D41,7D40,2338,
                        2080,000A, 2338,3D50,3D51,3D52,3D53,7D53,7D52,7D51,7D50,2338,
                        20C0,000A, 3D78,3D60,3D61,3D62,3D63,7D63,7D62,7D61,7D60,7D78,
                        2100,000A, 3D79,3D70,3D71,3D72,3D73,7D73,7D72,7D71,7D70,7D79,
                        2140,000A, BD78,3D34,3D35,3D36,3D37,7D37,7D36,7D35,7D34,FD78,
                        2180,000A, 2338,3D44,3D45,3D46,3D47,7D47,7D46,7D45,7D44,2338,
                        21C0,000A, 2338,3D54,3D55,3D56,3D57,7D57,7D56,7D55,7D54,2338,
                        2200,000A, 2338,3D64,3D65,3D66,2338,2338,7D66,7D65,7D64,2338,
                        2240,000A, 2338,3D74,3D75,3D76,2338,2338,7D76,7D75,7D74,2338,
                        2280,000A, 2338,2338,3D38,3D39,3D3A,7D3A,7D39,7D38,2338,2338,
                        22C0,000A, 2338,2338,3D48,3D49,3D4A,7D4A,7D49,7D48,2338,2338,
                        FFFF

; Eye
$A7:E1CE             dx FFFE,
                        21C6,0004, 3D56,3D57,7D57,7D56,
                        2206,0004, 3D66,3D67,3D3F,7D66,
                        2246,0004, 3D76,3D77,3D4F,7D76,
                        2286,0004, 3D39,3D3A,7D3A,7D39,
                        FFFF

$A7:E202             dx FFFE,
                        21C6,0004, 3D3D,3D3E,7D3E,7D3D,
                        2206,0004, 3D4D,3D4E,3D5F,7D4D,
                        2246,0004, 3D5D,3D5E,3D6F,7D5D,
                        2286,0004, 3D6D,3D6E,7D6E,7D6D,
                        FFFF

$A7:E236             dx FFFE,
                        21C6,0004, 3D3B,3D3C,7D3C,7D3B,
                        2206,0004, 3D4B,3D4C,7D4C,7D4B,
                        2246,0004, 3D5B,3D5C,7D5C,7D5B,
                        2286,0004, 3D6B,3D6C,7D6C,7D6B,
                        FFFF

; Eyeball
$A7:E26A             dx FFFE,
                        2208,0002, 3D67,3D3F,
                        2248,0002, 3D77,3D4F,
                        FFFF

$A7:E27E             dx FFFE,
                        2208,0002, 3D10,3D11,
                        2248,0002, 3D20,3D21,
                        FFFF

$A7:E292             dx FFFE,
                        2208,0002, 3D12,3D13,
                        2248,0002, 3D22,3D23,
                        FFFF

$A7:E2A6             dx FFFE,
                        2208,0002, 3D14,3D15,
                        2248,0002, 3D24,3D25,
                        FFFF

$A7:E2BA             dx FFFE,
                        2208,0002, 3D16,3D17,
                        2248,0002, 3D26,3D27,
                        FFFF

$A7:E2CE             dx FFFE,
                        2208,0002, 3D18,3D19,
                        2248,0002, 3D28,3D29,
                        FFFF

$A7:E2E2             dx FFFE,
                        2208,0002, 3D1A,3D1B,
                        2248,0002, 3D2A,3D2B,
                        FFFF

$A7:E2F6             dx FFFE,
                        2208,0002, 3D1C,3D1D,
                        2248,0002, 3D2C,3D2D,
                        FFFF

$A7:E30A             dx FFFE,
                        2208,0002, 3D1E,3D1F,
                        2248,0002, 3D2E,3D2F,
                        FFFF

; Left tentacle
$A7:E31E             dx FFFE,
                        2304,0001, 3D58,
                        2344,0001, 3D68,
                        FFFF

$A7:E32E             dx FFFE,
                        2304,0001, 3D81,
                        2344,0001, 3D83,
                        FFFF

$A7:E33E             dx FFFE,
                        2304,0001, 3D80,
                        2344,0001, 3D82,
                        FFFF

; Right tentacle
$A7:E34E             dx FFFE,
                        230E,0001, 7D58,
                        234E,0001, 7D68,
                        FFFF

$A7:E35E             dx FFFE,
                        230E,0001, 7D81,
                        234E,0001, 7D83,
                        FFFF

$A7:E36E             dx FFFE,
                        230E,0001, 7D80,
                        234E,0001, 7D82,
                        FFFF

; Mouth
$A7:E37E             dx FFFE,
                        2306,0004, 3D59,3D5A,7D5A,7D59,
                        2346,0004, 3D69,3D6A,7D6A,7D69,
                        FFFF

$A7:E39A             dx FFFE,
                        2306,0004, 3D7A,3D7B,7D7B,7D7A,
                        2346,0004, 3D7C,3D7D,7D7D,7D7C,
                        FFFF

$A7:E3B6             dx FFFE,
                        2306,0004, 3D7E,3D7F,7D7F,7D7E,
                        2346,0004, 3D30,3D31,7D31,7D30,
                        FFFF
}


;;; $E3D2: Phantoon movement data ;;;
{
; List of (signed) X/Y offset pairs, 216h total
; Indexed by $0FA8
$A7:E3D2             db 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,FF, 00,FF, 01,00,
                        00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF,
                        01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00,
                        00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF,
                        01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF,
                        01,00, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00,
                        00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00,
                        01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 01,00,
                        01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 01,00,
                        01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00,
                        00,01, 01,00, 01,00, 01,01, 01,00, 01,01, 01,00, 00,01,
                        01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01,
                        01,00, 00,01, 01,00, 00,01, 01,00, 01,01, 01,01, 01,01,
                        01,01, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01,
                        00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01, 01,00,
                        00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, FF,00, 00,01, 00,01, 00,01,
                        FF,00, 00,01, 00,01, FF,01, 00,01, FF,00, 00,01, 00,01,
                        FF,00, 00,01, FF,00, 00,01, FF,00, 00,01, FF,01, 00,01,
                        FF,00, FF,01, FF,01, FF,00, 00,01, FF,00, 00,01, FF,00,
                        00,01, FF,00, FF,00, 00,01, FF,00, 00,01, FF,00, FF,00,
                        00,01, FF,00, FF,01, FF,00, FF,01, FF,00, FF,00, 00,01,
                        FF,00, FF,00, 00,01, FF,00, FF,00, FF,00, 00,01, FF,00,
                        FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00,
                        FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, 00,FF, FF,00,
                        FF,00, FF,00, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00,
                        FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,FF, FF,00,
                        00,FF, FF,00, 00,FF, FF,00, FF,FF, FF,FF, FF,00, 00,FF,
                        FF,00, 00,FF, FF,00, 00,FF, FF,FF, FF,FF, 00,FF, FF,00,
                        00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF,
                        00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF,
                        FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00,
                        00,FF, FF,00, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF,
                        FF,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF, 00,FF, FF,00,
                        00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF, 00,FF, FF,00,
                        00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,FF,
                        00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00,
                        00,FF, FF,00, FF,FF, FF,00, 00,FF, FF,00, 00,FF, FF,00,
                        FF,FF, FF,00, 00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00,
                        00,FF, FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00,
                        00,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00,
                        FF,00, FF,00, FF,00, FF,01, FF,00, FF,00, FF,00, FF,00,
                        00,01, FF,00, FF,00, FF,00, 00,01, FF,00, FF,00, 00,01,
                        FF,00, FF,00, FF,01, FF,00, FF,01, FF,00, 00,01, FF,00,
                        FF,00, 00,01, FF,00, 00,01, FF,00, FF,00, 00,01, FF,00,
                        00,01, FF,00, 00,01, FF,00, 00,01, FF,00, FF,01, FF,01,
                        FF,01, 00,01, FF,00, 00,01, FF,00, 00,01, FF,00, 00,01,
                        00,01, FF,00, 00,01, FF,01, 00,01, 00,01, FF,00, 00,01,
                        00,01, 00,01, FF,00, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 01,00, 00,01, 00,01, 00,01, 01,00,
                        00,01, 00,01, 01,00, 00,01, 00,01, 01,00, 00,01, 00,01,
                        01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,01, 01,01,
                        00,01, 01,00, 01,01, 01,00, 00,01, 01,00, 00,01, 01,00,
                        00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 01,00,
                        00,01, 01,00, 01,01, 01,00, 01,01, 01,00, 01,00, 00,01,
                        01,00, 01,00, 00,01, 01,00, 01,00, 01,00, 00,01, 01,00,
                        01,00, 01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 00,FF, 01,00,
                        01,00, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00,
                        01,00, 00,FF, 01,00, 01,00, 00,FF, 01,00, 01,00, 00,FF,
                        01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 01,FF,
                        01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00, 00,FF,
                        01,00, 00,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF, 01,00,
                        00,FF, 01,00, 00,FF, 01,00, 00,FF, 00,FF, 01,00, 00,FF,
                        01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF,
                        01,FF, 00,FF, 01,00, 00,FF, 01,00, 00,FF
}
}


;;; $E7FE..F224: Etecoon ;;;
{
;;; $E7FE: Palette - enemy $E5BF (etecoon) ;;;
{
$A7:E7FE             dw 3800, 5F97, 56F2, 2987, 00A0, 6355, 4AB0, 3A0B, 31C9, 57FF, 42F7, 2610, 158C, 03FF, 0279, 0029
}


;;; $E81E..FF: Instruction lists ;;;
{
;;; $E81E: Instruction list - look right at Samus and run left ;;;
{
$A7:E81E             dw 0005,EFFF,
                        812F,       ; Sleep
                        0001,F024
}


;;; $E828: Instruction list - running left ;;;
{
$A7:E828             dw 0005,EEED,
                        0005,EEFE,
                        0005,EF0A,
                        0005,EEFE,
                        80ED,E828   ; Go to $E828
}


;;; $E83C: Instruction list - wall jump left ;;;
{
$A7:E83C             dx 0008,EF5A
$A7:E840             dx 0003,EF16,
                        0003,EF27,
                        0003,EF38,
                        0003,EF49,
                        80ED,E840   ; Go to $E840
}


;;; $E854: Instruction list - hopping - facing left ;;;
{
$A7:E854             dw 0001,EF6B,
                        812F,       ; Sleep
                        000C,EF90,
                        000C,EFB5
}


;;; $E862: Instruction list - hit ceiling ;;;
{
$A7:E862             dw 0006,EFDA,
                        000C,EFB5,
                        000C,EF90,
                        812F        ; Sleep
}


;;; $E870: Instruction list - wall-jump left eligible ;;;
{
$A7:E870             dx 0001,F06E,
                        812F        ; Sleep
}


;;; $E876: Instruction list - look left at Samus and run right ;;;
{
$A7:E876             dw 0005,F1E5,
                        812F,       ; Sleep
                        0001,F1C0
}


;;; $E880: Instruction list - running right ;;;
{
$A7:E880             dw 0005,F089,
                        0005,F09A,
                        0005,F0A6,
                        0005,F09A,
                        80ED,E880   ; Go to $E880
}


;;; $E894: Instruction list - wall jump right ;;;
{
$A7:E894             dx 0008,F0F6
}


;;; $E898: Instruction list - jumping right ;;;
{
$A7:E898             dx 0003,F0B2,
                        0003,F0C3,
                        0003,F0D4,
                        0003,F0E5,
                        80ED,E898   ; Go to $E898
}


;;; $E8AC: Instruction list - hopping - facing right ;;;
{
$A7:E8AC             dw 0001,F107,
                        812F,       ; Sleep
                        000C,F12C,
                        000C,F151,
                        0006,F176,
                        000C,F151,
                        000C,F12C,
                        812F        ; Sleep
}


;;; $E8C8: Instruction list - wall-jump right eligible ;;;
{
$A7:E8C8             dx 0001,F20A,
                        812F        ; Sleep
}


;;; $E8CE: Instruction list - initial ;;;
{
$A7:E8CE             dx 0008,F107,
                        80ED,E8CE   ; Go to $E8CE
}


;;; $E8D6: Instruction list - flexing ;;;
{
$A7:E8D6             dx 8123,0004   ; Timer = 4
$A7:E8DA             dx 0008,F107,
                        0008,F12C,
                        0008,F151,
                        0008,F176,
                        0008,F151,
                        0008,F12C,
                        8110,E8DA,  ; Decrement timer and go to $E8DA if non-zero
                        0020,F19B,
                        0020,F1E5,
                        812F        ; Sleep
}
}


;;; $E900: Etecoon constants ;;;
{
$A7:E900             dw FFFD,0000 ; Initial Y velocity of hops and failed jump
$A7:E904             dw FFFC,0000 ; Initial Y velocity of successful jump

$A7:E908             dw 0002,0000 ; X velocity - right
$A7:E90C             dw FFFE,0000 ; X velocity - left

$A7:E910             dw 0040 ; Samus X proximity threshold at bottom of room
}


;;; $E912: Initialisation AI - enemy $E5BF (etecoon) ;;;
{
$A7:E912 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:E915 BD 86 0F    LDA $0F86,x[$7E:1186]  ;\
$A7:E918 09 00 20    ORA #$2000             ;} Set enemy to process instructions
$A7:E91B 9D 86 0F    STA $0F86,x[$7E:1186]  ;/
$A7:E91E A9 4D 80    LDA #$804D             ;\
$A7:E921 9D 8E 0F    STA $0F8E,x[$7E:118E]  ;} Enemy spritemap pointer = $804D
$A7:E924 A9 01 00    LDA #$0001             ;\
$A7:E927 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:E92A 9E 90 0F    STZ $0F90,x[$7E:1190]  ; Enemy timer = 0
$A7:E92D A9 CE E8    LDA #$E8CE             ;\
$A7:E930 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $E8CE (initial)
$A7:E933 A9 AF E9    LDA #$E9AF             ;\
$A7:E936 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $E9AF (initial)
$A7:E939 A9 FF FF    LDA #$FFFF             ;\
$A7:E93C 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;} Enemy function timer = -1
$A7:E93F 6B          RTL
}


;;; $E940: Main AI - enemy $E5BF (etecoon) ;;;
{
$A7:E940 AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:E943 BD B6 0F    LDA $0FB6,x[$7E:11B6]  ;\
$A7:E946 89 00 FF    BIT #$FF00             ;} If [enemy freeze timer] != 0:
$A7:E949 F0 09       BEQ $09    [$E954]     ;/
$A7:E94B 38          SEC                    ;\
$A7:E94C E9 00 01    SBC #$0100             ;} Decrement enemy freeze timer
$A7:E94F 9D B6 0F    STA $0FB6,x            ;/
$A7:E952 80 03       BRA $03    [$E957]     ; Return

$A7:E954 7C B2 0F    JMP ($0FB2,x)[$A7:E9AF]; Go to [enemy function]

$A7:E957 6B          RTL
}


;;; $E958: Freeze etecoon if quake active ;;;
{
$A7:E958 AD 40 18    LDA $1840  [$7E:1840]  ;\
$A7:E95B F0 16       BEQ $16    [$E973]     ;} If [earthquake timer] != 0:
$A7:E95D BD B6 0F    LDA $0FB6,x            ;\
$A7:E960 29 FF 00    AND #$00FF             ;|
$A7:E963 09 00 80    ORA #$8000             ;} Enemy freeze timer = 80h
$A7:E966 9D B6 0F    STA $0FB6,x            ;/
$A7:E969 BD 94 0F    LDA $0F94,x            ;\
$A7:E96C 18          CLC                    ;|
$A7:E96D 69 80 00    ADC #$0080             ;} Enemy instruction timer += 80h
$A7:E970 9D 94 0F    STA $0F94,x            ;/

$A7:E973 60          RTS
}


;;; $E974: Etecoon horizontal movement ;;;
{
;; Returns:
;;     Carry: Set if collision, clear otherwise
$A7:E974 BD AC 0F    LDA $0FAC,x            ;\
$A7:E977 85 14       STA $14    [$7E:0014]  ;|
$A7:E979 BD AE 0F    LDA $0FAE,x            ;} Move enemy right by [enemy X velocity]
$A7:E97C 85 12       STA $12    [$7E:0012]  ;|
$A7:E97E 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A7:E982 60          RTS
}


;;; $E983: Etecoon vertical movement ;;;
{
;; Returns:
;;     Carry: Set if collision, clear otherwise
$A7:E983 BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;\
$A7:E986 85 14       STA $14    [$7E:0014]  ;|
$A7:E988 BD AA 0F    LDA $0FAA,x[$7E:11AA]  ;} $14.$12 = [enemy Y velocity]
$A7:E98B 85 12       STA $12    [$7E:0012]  ;/
$A7:E98D BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;\
$A7:E990 C9 05 00    CMP #$0005             ;} If [enemy Y velocity] < 5:
$A7:E993 10 15       BPL $15    [$E9AA]     ;/
$A7:E995 BD AA 0F    LDA $0FAA,x[$7E:11AA]  ;\
$A7:E998 18          CLC                    ;|
$A7:E999 6F 32 0B 00 ADC $000B32[$7E:0B32]  ;|
$A7:E99D 9D AA 0F    STA $0FAA,x[$7E:11AA]  ;} Enemy Y velocity += [Samus Y acceleration]
$A7:E9A0 BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;|
$A7:E9A3 6F 34 0B 00 ADC $000B34[$7E:0B34]  ;|
$A7:E9A7 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;/

$A7:E9AA 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A7:E9AE 60          RTS
}


;;; $E9AF: Etecoon function - initial ;;;
{
$A7:E9AF AD 97 07    LDA $0797  [$7E:0797]  ;\
$A7:E9B2 F0 01       BEQ $01    [$E9B5]     ;} If [door transition flag] != 0:
$A7:E9B4 6B          RTL                    ; Return

$A7:E9B5 BD B0 0F    LDA $0FB0,x[$7E:11B0]  ;\
$A7:E9B8 10 2C       BPL $2C    [$E9E6]     ;} If [enemy function timer] >= 0: go to BRANCH_POSITIVE
$A7:E9BA A9 80 00    LDA #$0080             ;\
$A7:E9BD 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;|
$A7:E9C1 A8          TAY                    ;} If Samus is not within 80h pixels rows of enemy: return
$A7:E9C2 F0 3B       BEQ $3B    [$E9FF]     ;/
$A7:E9C4 BD B6 0F    LDA $0FB6,x[$7E:11B6]  ;\
$A7:E9C7 89 03 00    BIT #$0003             ;} If [enemy etecoon ID] & 3 = 0:
$A7:E9CA D0 07       BNE $07    [$E9D3]     ;/
$A7:E9CC A9 35 00    LDA #$0035             ;\
$A7:E9CF 22 A3 90 80 JSL $8090A3[$80:90A3]  ;} Queue sound 35h, sound library 2, max queued sounds allowed = 15 (etecoon's theme)

$A7:E9D3 A9 01 00    LDA #$0001             ;\
$A7:E9D6 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:E9D9 A9 D6 E8    LDA #$E8D6             ;\
$A7:E9DC 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $E8D6 (flexing)
$A7:E9DF A9 00 01    LDA #$0100             ;\
$A7:E9E2 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;} Enemy function timer = 100h
$A7:E9E5 6B          RTL                    ; Return

; BRANCH_POSITIVE
$A7:E9E6 DE B0 0F    DEC $0FB0,x[$7E:11B0]  ; Decrement enemy function timer
$A7:E9E9 F0 02       BEQ $02    [$E9ED]     ;\
$A7:E9EB 10 12       BPL $12    [$E9FF]     ;} If [enemy function timer] > 0: return

$A7:E9ED A9 54 E8    LDA #$E854             ;\
$A7:E9F0 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $E854 (hopping - facing left)
$A7:E9F3 A9 00 EA    LDA #$EA00             ;\
$A7:E9F6 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $EA00 (start hop - bottom of room)
$A7:E9F9 A9 0B 00    LDA #$000B             ;\
$A7:E9FC 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;} Enemy function timer = Bh (initial hop delay)

$A7:E9FF 6B          RTL
}


;;; $EA00: Etecoon function - start hop - bottom of room ;;;
{
$A7:EA00 DE B0 0F    DEC $0FB0,x[$7E:11B0]  ; Decrement enemy function timer
$A7:EA03 F0 02       BEQ $02    [$EA07]     ;\
$A7:EA05 10 2F       BPL $2F    [$EA36]     ;} If [enemy function timer] > 0: return

$A7:EA07 AD 00 E9    LDA $E900  [$A7:E900]  ;\
$A7:EA0A 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;|
$A7:EA0D AD 02 E9    LDA $E902  [$A7:E902]  ;} Enemy Y velocity = -3.0
$A7:EA10 9D AA 0F    STA $0FAA,x[$7E:11AA]  ;/
$A7:EA13 BD 92 0F    LDA $0F92,x[$7E:1192]  ;\
$A7:EA16 1A          INC A                  ;|
$A7:EA17 1A          INC A                  ;} Enemy instruction list pointer += 2 (wake up)
$A7:EA18 9D 92 0F    STA $0F92,x[$7E:1192]  ;/
$A7:EA1B A9 01 00    LDA #$0001             ;\
$A7:EA1E 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:EA21 A9 37 EA    LDA #$EA37             ;\
$A7:EA24 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $EA37 (hopping - bottom of room)
$A7:EA27 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A7:EA2A C9 00 01    CMP #$0100             ;} If [Samus X position] >= 100h:
$A7:EA2D 30 07       BMI $07    [$EA36]     ;/
$A7:EA2F A9 33 00    LDA #$0033             ;\
$A7:EA32 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 33h, sound library 2, max queued sounds allowed = 6 (etecoon cry)

$A7:EA36 6B          RTL
}


;;; $EA37: Etecoon function - hopping - bottom of room ;;;
{
$A7:EA37 20 83 E9    JSR $E983  [$A7:E983]  ; Etecoon vertical movement
$A7:EA3A B0 01       BCS $01    [$EA3D]     ; If no collision:
$A7:EA3C 6B          RTL                    ; Return

$A7:EA3D BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;\
$A7:EA40 10 13       BPL $13    [$EA55]     ;} If [enemy Y velocity] < 0:
$A7:EA42 9E A8 0F    STZ $0FA8,x            ;\
$A7:EA45 9E AA 0F    STZ $0FAA,x            ;} Enemy Y velocity = 0.0
$A7:EA48 A9 03 00    LDA #$0003             ;\
$A7:EA4B 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 3
$A7:EA4E A9 62 E8    LDA #$E862             ;\
$A7:EA51 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E862 (hit ceiling)
$A7:EA54 6B          RTL                    ; Return

$A7:EA55 A9 40 00    LDA #$0040             ;\
$A7:EA58 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;|
$A7:EA5C A8          TAY                    ;} If Samus is not within 40h pixels rows of enemy: go to BRANCH_HOP_MORE
$A7:EA5D F0 3D       BEQ $3D    [$EA9C]     ;/
$A7:EA5F AD 10 E9    LDA $E910  [$A7:E910]  ;\
$A7:EA62 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;|
$A7:EA66 A8          TAY                    ;} If Samus is not within 40h pixel columns of enemy: go to BRANCH_HOP_MORE
$A7:EA67 F0 33       BEQ $33    [$EA9C]     ;/
$A7:EA69 22 29 AE A0 JSL $A0AE29[$A0:AE29]  ; Determine direction of Samus from enemy
$A7:EA6D C9 05 00    CMP #$0005             ;\
$A7:EA70 10 0B       BPL $0B    [$EA7D]     ;} If direction is not (down/up) left:
$A7:EA72 A9 1E E8    LDA #$E81E             ;\
$A7:EA75 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E81E (look right at Samus and run left)
$A7:EA78 9E B4 0F    STZ $0FB4,x            ; Enemy direction = left
$A7:EA7B 80 0C       BRA $0C    [$EA89]

$A7:EA7D A9 76 E8    LDA #$E876             ;\ Else (direction is (down/up) left):
$A7:EA80 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E876 (look left at Samus and run right)
$A7:EA83 A9 01 00    LDA #$0001             ;\
$A7:EA86 9D B4 0F    STA $0FB4,x            ;} Enemy direction = right

$A7:EA89 A9 20 00    LDA #$0020             ;\
$A7:EA8C 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = 20h
$A7:EA8F A9 01 00    LDA #$0001             ;\
$A7:EA92 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EA95 A9 B5 EA    LDA #$EAB5             ;\
$A7:EA98 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EAB5 (look at Samus)
$A7:EA9B 6B          RTL                    ; Return

; BRANCH_HOP_MORE
$A7:EA9C A9 0B 00    LDA #$000B             ;\
$A7:EA9F 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;} Enemy function timer = Bh (hop cooldown)
$A7:EAA2 A9 00 EA    LDA #$EA00             ;\
$A7:EAA5 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $EA00 (start hop - bottom of room)
$A7:EAA8 A9 01 00    LDA #$0001             ;\
$A7:EAAB 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:EAAE A9 54 E8    LDA #$E854             ;\
$A7:EAB1 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $E854 (hopping - facing left)
$A7:EAB4 6B          RTL
}


;;; $EAB5: Etecoon function - look at Samus ;;;
{
$A7:EAB5 DE B0 0F    DEC $0FB0,x            ; Decrement enemy function timer
$A7:EAB8 F0 02       BEQ $02    [$EABC]     ;\
$A7:EABA 10 45       BPL $45    [$EB01]     ;} If [enemy function timer] > 0: return

$A7:EABC BD 92 0F    LDA $0F92,x            ;\
$A7:EABF 1A          INC A                  ;|
$A7:EAC0 1A          INC A                  ;} Enemy instruction list pointer += 2 (wake up)
$A7:EAC1 9D 92 0F    STA $0F92,x            ;/
$A7:EAC4 A9 01 00    LDA #$0001             ;\
$A7:EAC7 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EACA BD B4 0F    LDA $0FB4,x            ;\
$A7:EACD F0 14       BEQ $14    [$EAE3]     ;} If [enemy direction] != left:
$A7:EACF AD 08 E9    LDA $E908  [$A7:E908]  ;\
$A7:EAD2 9D AC 0F    STA $0FAC,x            ;|
$A7:EAD5 AD 0A E9    LDA $E90A  [$A7:E90A]  ;} Enemy X velocity = 2.0
$A7:EAD8 9D AE 0F    STA $0FAE,x            ;/
$A7:EADB A9 2C EB    LDA #$EB2C             ;\
$A7:EADE 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EB2C (running right)
$A7:EAE1 80 12       BRA $12    [$EAF5]

$A7:EAE3 AD 0C E9    LDA $E90C  [$A7:E90C]  ;\ Else ([enemy direction] = left):
$A7:EAE6 9D AC 0F    STA $0FAC,x            ;|
$A7:EAE9 AD 0E E9    LDA $E90E  [$A7:E90E]  ;} Enemy X velocity = -2.0
$A7:EAEC 9D AE 0F    STA $0FAE,x            ;/
$A7:EAEF A9 02 EB    LDA #$EB02             ;\
$A7:EAF2 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EB02 (running left)

$A7:EAF5 AD 00 E9    LDA $E900  [$A7:E900]  ;\
$A7:EAF8 9D A8 0F    STA $0FA8,x            ;|
$A7:EAFB AD 02 E9    LDA $E902  [$A7:E902]  ;} Enemy Y velocity = -3.0
$A7:EAFE 9D AA 0F    STA $0FAA,x            ;/

$A7:EB01 6B          RTL
}


;;; $EB02: Etecoon function - running left ;;;
{
$A7:EB02 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:EB05 90 24       BCC $24    [$EB2B]     ; If collision:
$A7:EB07 AD 08 E9    LDA $E908  [$A7:E908]  ;\
$A7:EB0A 9D AC 0F    STA $0FAC,x            ;|
$A7:EB0D AD 0A E9    LDA $E90A  [$A7:E90A]  ;} Enemy X velocity = 2.0
$A7:EB10 9D AE 0F    STA $0FAE,x            ;/
$A7:EB13 A9 2C EB    LDA #$EB2C             ;\
$A7:EB16 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EB2C (running right)
$A7:EB19 A9 01 00    LDA #$0001             ;\
$A7:EB1C 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EB1F A9 80 E8    LDA #$E880             ;\
$A7:EB22 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E880 (running right)
$A7:EB25 A9 01 00    LDA #$0001             ;\
$A7:EB28 9D B4 0F    STA $0FB4,x            ;} Enemy direction = right

$A7:EB2B 6B          RTL
}


;;; $EB2C: Etecoon function - running right ;;;
{
$A7:EB2C A9 20 00    LDA #$0020             ;\
$A7:EB2F 85 14       STA $14    [$7E:0014]  ;} $14.$12 = 20h.0
$A7:EB31 64 12       STZ $12    [$7E:0012]  ;/
$A7:EB33 22 BF BB A0 JSL $A0BBBF[$A0:BBBF]  ; Check for horizontal "solid" block collision
$A7:EB37 90 13       BCC $13    [$EB4C]     ; If collision:
$A7:EB39 A9 01 00    LDA #$0001             ;\
$A7:EB3C 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EB3F A9 98 E8    LDA #$E898             ;\
$A7:EB42 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E898 (jumping right)
$A7:EB45 A9 50 EB    LDA #$EB50             ;\
$A7:EB48 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EB50 (jumping)
$A7:EB4B 6B          RTL                    ; Return

$A7:EB4C 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:EB4F 6B          RTL
}


;;; $EB50: Etecoon function - jumping ;;;
{
$A7:EB50 20 58 E9    JSR $E958  [$A7:E958]  ; Freeze etecoon if quake active
$A7:EB53 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:EB56 90 3E       BCC $3E    [$EB96]     ; If no collision: go to BRANCH_NO_WALL
$A7:EB58 BD B4 0F    LDA $0FB4,x            ;\
$A7:EB5B D0 0E       BNE $0E    [$EB6B]     ;} If [enemy direction] = left:
$A7:EB5D A9 C8 E8    LDA #$E8C8             ;\
$A7:EB60 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E8C8 (wall-jump right eligible)
$A7:EB63 A9 01 00    LDA #$0001             ;\
$A7:EB66 9D B4 0F    STA $0FB4,x            ;} Enemy direction = right
$A7:EB69 80 09       BRA $09    [$EB74]

$A7:EB6B A9 70 E8    LDA #$E870             ;\ Else ([enemy direction] != left):
$A7:EB6E 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E870 (wall-jump left eligible)
$A7:EB71 9E B4 0F    STZ $0FB4,x            ; Enemy direction = left

$A7:EB74 A9 01 00    LDA #$0001             ;\
$A7:EB77 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EB7A A9 CD EB    LDA #$EBCD             ;\
$A7:EB7D 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EBCD (wall jump)
$A7:EB80 A9 08 00    LDA #$0008             ;\
$A7:EB83 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = 8
$A7:EB86 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A7:EB89 C9 00 01    CMP #$0100             ;} If [Samus X position] >= 100h:
$A7:EB8C 30 07       BMI $07    [$EB95]     ;/
$A7:EB8E A9 32 00    LDA #$0032             ;\
$A7:EB91 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 32h, sound library 2, max queued sounds allowed = 6 (etecoon wall-jump)

$A7:EB95 6B          RTL                    ; Return

; BRANCH_NO_WALL
$A7:EB96 20 83 E9    JSR $E983  [$A7:E983]  ; Etecoon vertical movement
$A7:EB99 90 31       BCC $31    [$EBCC]     ; If no collision: return
$A7:EB9B BD B4 0F    LDA $0FB4,x            ;\
$A7:EB9E D0 08       BNE $08    [$EBA8]     ;} If [enemy direction] = left:
$A7:EBA0 A9 AC E8    LDA #$E8AC             ;\
$A7:EBA3 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E8AC (hopping - facing right)
$A7:EBA6 80 06       BRA $06    [$EBAE]

$A7:EBA8 A9 54 E8    LDA #$E854             ;\ Else ([enemy direction] != left):
$A7:EBAB 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E854 (hopping - facing left)

$A7:EBAE A9 01 00    LDA #$0001             ;\
$A7:EBB1 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EBB4 A9 0B 00    LDA #$000B             ;\
$A7:EBB7 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = Bh
$A7:EBBA A9 1B EC    LDA #$EC1B             ;\
$A7:EBBD 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EC1B (landed from jump)
$A7:EBC0 AD 00 E9    LDA $E900  [$A7:E900]  ;\
$A7:EBC3 9D A8 0F    STA $0FA8,x            ;|
$A7:EBC6 AD 02 E9    LDA $E902  [$A7:E902]  ;} Enemy Y velocity = -3.0
$A7:EBC9 9D AA 0F    STA $0FAA,x            ;/

$A7:EBCC 6B          RTL
}


;;; $EBCD: Etecoon function - wall jump ;;;
{
$A7:EBCD 20 58 E9    JSR $E958  [$A7:E958]  ; Freeze etecoon if quake active
$A7:EBD0 DE B0 0F    DEC $0FB0,x            ; Decrement enemy function timer
$A7:EBD3 F0 02       BEQ $02    [$EBD7]     ;\
$A7:EBD5 10 43       BPL $43    [$EC1A]     ;} If [enemy function timer] > 0: return

$A7:EBD7 BD B4 0F    LDA $0FB4,x            ;\
$A7:EBDA F0 14       BEQ $14    [$EBF0]     ;} If [enemy direction] != left:
$A7:EBDC A9 94 E8    LDA #$E894             ;\
$A7:EBDF 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E894 (wall jump right)
$A7:EBE2 AD 08 E9    LDA $E908  [$A7:E908]  ;\
$A7:EBE5 9D AC 0F    STA $0FAC,x            ;|
$A7:EBE8 AD 0A E9    LDA $E90A  [$A7:E90A]  ;} Enemy X velocity = 2.0
$A7:EBEB 9D AE 0F    STA $0FAE,x            ;/
$A7:EBEE 80 12       BRA $12    [$EC02]

$A7:EBF0 A9 3C E8    LDA #$E83C             ;\ Else ([enemy direction] = left):
$A7:EBF3 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E83C (wall jump left)
$A7:EBF6 AD 0C E9    LDA $E90C  [$A7:E90C]  ;\
$A7:EBF9 9D AC 0F    STA $0FAC,x            ;|
$A7:EBFC AD 0E E9    LDA $E90E  [$A7:E90E]  ;} Enemy X velocity = -2.0
$A7:EBFF 9D AE 0F    STA $0FAE,x            ;/

$A7:EC02 A9 01 00    LDA #$0001             ;\
$A7:EC05 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EC08 A9 50 EB    LDA #$EB50             ;\
$A7:EC0B 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EB50 (jumping)
$A7:EC0E AD 00 E9    LDA $E900  [$A7:E900]  ;\
$A7:EC11 9D A8 0F    STA $0FA8,x            ;|
$A7:EC14 AD 02 E9    LDA $E902  [$A7:E902]  ;} Enemy Y velocity = -3.0
$A7:EC17 9D AA 0F    STA $0FAA,x            ;/

$A7:EC1A 6B          RTL
}


;;; $EC1B: Etecoon function - landed from jump ;;;
{
$A7:EC1B DE B0 0F    DEC $0FB0,x            ; Decrement enemy function timer
$A7:EC1E F0 02       BEQ $02    [$EC22]     ;\
$A7:EC20 10 1E       BPL $1E    [$EC40]     ;} If [enemy function timer] > 0: return

$A7:EC22 AD 00 E9    LDA $E900  [$A7:E900]  ;\
$A7:EC25 9D A8 0F    STA $0FA8,x            ;|
$A7:EC28 AD 02 E9    LDA $E902  [$A7:E902]  ;} Enemy Y velocity = -3.0
$A7:EC2B 9D AA 0F    STA $0FAA,x            ;/
$A7:EC2E 9B          TXY                    ; Y = [enemy index]
$A7:EC2F BD B6 0F    LDA $0FB6,x            ;\
$A7:EC32 29 FF 00    AND #$00FF             ;|
$A7:EC35 0A          ASL A                  ;} Execute [$EC41 + [enemy etecoon ID] * 2]
$A7:EC36 AA          TAX                    ;|
$A7:EC37 FC 41 EC    JSR ($EC41,x)          ;/
$A7:EC3A A9 01 00    LDA #$0001             ;\
$A7:EC3D 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1

$A7:EC40 6B          RTL

$A7:EC41             dw EC47, EC61, EC7B
}


;;; $EC47: Run to left run-up point ;;;
{
$A7:EC47 BB          TYX
$A7:EC48 A9 97 EC    LDA #$EC97             ;\
$A7:EC4B 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EC97 (run to left run-up point)
$A7:EC4E A9 28 E8    LDA #$E828             ;\
$A7:EC51 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E828 (running left)
$A7:EC54 AD 0C E9    LDA $E90C  [$A7:E90C]  ;\
$A7:EC57 9D AC 0F    STA $0FAC,x            ;|
$A7:EC5A AD 0E E9    LDA $E90E  [$A7:E90E]  ;} Enemy X velocity = -2.0
$A7:EC5D 9D AE 0F    STA $0FAE,x            ;/
$A7:EC60 60          RTS
}


;;; $EC61: Run to right run-up point ;;;
{
$A7:EC61 BB          TYX
$A7:EC62 A9 BB EC    LDA #$ECBB             ;\
$A7:EC65 9D B2 0F    STA $0FB2,x            ;} Enemy function = $ECBB (run to right run-up point)
$A7:EC68 A9 80 E8    LDA #$E880             ;\
$A7:EC6B 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E880 (running right)
$A7:EC6E AD 08 E9    LDA $E908  [$A7:E908]  ;\
$A7:EC71 9D AC 0F    STA $0FAC,x            ;|
$A7:EC74 AD 0A E9    LDA $E90A  [$A7:E90A]  ;} Enemy X velocity = 2.0
$A7:EC77 9D AE 0F    STA $0FAE,x            ;/
$A7:EC7A 60          RTS
}


;;; $EC7B: Hop at centre run-up point ;;;
{
$A7:EC7B BB          TYX
$A7:EC7C A9 75 ED    LDA #$ED75             ;\
$A7:EC7F 9D B2 0F    STA $0FB2,x            ;} Enemy function = $ED75 (hopping - top of room)
$A7:EC82 BD 92 0F    LDA $0F92,x            ;\
$A7:EC85 1A          INC A                  ;|
$A7:EC86 1A          INC A                  ;} Enemy instruction list pointer += 2 (wake up)
$A7:EC87 9D 92 0F    STA $0F92,x            ;/
$A7:EC8A AD 08 E9    LDA $E908  [$A7:E908]  ;\
$A7:EC8D 9D AC 0F    STA $0FAC,x            ;|
$A7:EC90 AD 0A E9    LDA $E90A  [$A7:E90A]  ;} Enemy X velocity = 2.0
$A7:EC93 9D AE 0F    STA $0FAE,x            ;/
$A7:EC96 60          RTS
}


;;; $EC97: Etecoon function - run to left run-up point ;;;
{
$A7:EC97 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:EC9A BD 7A 0F    LDA $0F7A,x            ;\
$A7:EC9D C9 19 02    CMP #$0219             ;} If [enemy X position] <= 218h:
$A7:ECA0 10 18       BPL $18    [$ECBA]     ;/
$A7:ECA2 A9 0B 00    LDA #$000B             ;\
$A7:ECA5 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = Bh
$A7:ECA8 A9 C7 ED    LDA #$EDC7             ;\
$A7:ECAB 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EDC7 (start hop - top of room)
$A7:ECAE A9 01 00    LDA #$0001             ;\
$A7:ECB1 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:ECB4 A9 54 E8    LDA #$E854             ;\
$A7:ECB7 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E854 (hopping - facing left)

$A7:ECBA 6B          RTL
}


;;; $ECBB: Etecoon function - run to right run-up point ;;;
{
$A7:ECBB 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:ECBE BD 7A 0F    LDA $0F7A,x            ;\
$A7:ECC1 C9 58 02    CMP #$0258             ;} If [enemy X position] >= 258h:
$A7:ECC4 30 18       BMI $18    [$ECDE]     ;/
$A7:ECC6 A9 0B 00    LDA #$000B             ;\
$A7:ECC9 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = Bh
$A7:ECCC A9 C7 ED    LDA #$EDC7             ;\
$A7:ECCF 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EDC7 (start hop - top of room)
$A7:ECD2 A9 01 00    LDA #$0001             ;\
$A7:ECD5 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:ECD8 A9 54 E8    LDA #$E854             ;\
$A7:ECDB 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E854 (hopping - facing left)

$A7:ECDE 6B          RTL
}


;;; $ECDF: Etecoon function - running for successful morph tunnel jump ;;;
{
$A7:ECDF 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:ECE2 BD 7A 0F    LDA $0F7A,x            ;\
$A7:ECE5 C9 58 02    CMP #$0258             ;} If [enemy X position] >= 258h:
$A7:ECE8 30 1E       BMI $1E    [$ED08]     ;/
$A7:ECEA A9 09 ED    LDA #$ED09             ;\
$A7:ECED 9D B2 0F    STA $0FB2,x            ;} Enemy function = $ED09 (successful morph tunnel jump)
$A7:ECF0 AD 04 E9    LDA $E904  [$A7:E904]  ;\
$A7:ECF3 9D A8 0F    STA $0FA8,x            ;|
$A7:ECF6 AD 06 E9    LDA $E906  [$A7:E906]  ;} Enemy Y velocity = -4.0
$A7:ECF9 9D AA 0F    STA $0FAA,x            ;/
$A7:ECFC A9 01 00    LDA #$0001             ;\
$A7:ECFF 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:ED02 A9 98 E8    LDA #$E898             ;\
$A7:ED05 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E898 (jumping right)

$A7:ED08 6B          RTL
}


;;; $ED09: Etecoon function - successful morph tunnel jump ;;;
{
$A7:ED09 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:ED0C 20 83 E9    JSR $E983  [$A7:E983]  ; Etecoon vertical movement
$A7:ED0F BD 7A 0F    LDA $0F7A,x            ;\
$A7:ED12 C9 A8 02    CMP #$02A8             ;} If [enemy X position] >= 2A8h:
$A7:ED15 30 12       BMI $12    [$ED29]     ;/
$A7:ED17 A9 01 00    LDA #$0001             ;\
$A7:ED1A 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:ED1D A9 80 E8    LDA #$E880             ;\
$A7:ED20 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E880 (running right)
$A7:ED23 A9 2A ED    LDA #$ED2A             ;\
$A7:ED26 9D B2 0F    STA $0FB2,x            ;} Enemy function = $ED2A (running through morph tunnel)

$A7:ED29 6B          RTL
}


;;; $ED2A: Etecoon function - running through morph tunnel ;;;
{
$A7:ED2A 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:ED2D BD 7A 0F    LDA $0F7A,x            ;\
$A7:ED30 C9 48 03    CMP #$0348             ;} If [enemy X position] >= 348h:
$A7:ED33 30 1E       BMI $1E    [$ED53]     ;/
$A7:ED35 A9 01 00    LDA #$0001             ;\
$A7:ED38 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:ED3B A9 98 E8    LDA #$E898             ;\
$A7:ED3E 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E898 (jumping right)
$A7:ED41 A9 54 ED    LDA #$ED54             ;\
$A7:ED44 9D B2 0F    STA $0FB2,x            ;} Enemy function = $ED54 (falling from morph tunnel ledge)
$A7:ED47 A9 FF FF    LDA #$FFFF             ;\
$A7:ED4A 9D A8 0F    STA $0FA8,x            ;|
$A7:ED4D AD 06 E9    LDA $E906  [$A7:E906]  ;} Enemy Y velocity = -1.0
$A7:ED50 9D AA 0F    STA $0FAA,x            ;/

$A7:ED53 6B          RTL
}


;;; $ED54: Etecoon function - falling from morph tunnel ledge ;;;
{
$A7:ED54 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:ED57 20 83 E9    JSR $E983  [$A7:E983]  ; Etecoon vertical movement
$A7:ED5A 90 18       BCC $18    [$ED74]     ; If collision:
$A7:ED5C A9 0B 00    LDA #$000B             ;\
$A7:ED5F 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = Bh
$A7:ED62 A9 01 00    LDA #$0001             ;\
$A7:ED65 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:ED68 A9 54 E8    LDA #$E854             ;\
$A7:ED6B 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E854 (hopping - facing left)
$A7:ED6E A9 C7 ED    LDA #$EDC7             ;\
$A7:ED71 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EDC7 (start hop - top of room)

$A7:ED74 6B          RTL
}


;;; $ED75: Etecoon function - hopping - top of room ;;;
{
$A7:ED75 20 58 E9    JSR $E958  [$A7:E958]  ; Freeze etecoon if quake active
$A7:ED78 20 83 E9    JSR $E983  [$A7:E983]  ; Etecoon vertical movement
$A7:ED7B B0 01       BCS $01    [$ED7E]     ; If no collision:
$A7:ED7D 6B          RTL                    ; Return

$A7:ED7E BD A8 0F    LDA $0FA8,x            ;\
$A7:ED81 10 13       BPL $13    [$ED96]     ;} If [enemy Y velocity] < 0:
$A7:ED83 9E A8 0F    STZ $0FA8,x            ;\
$A7:ED86 9E AA 0F    STZ $0FAA,x            ;} Enemy Y velocity = 0.0
$A7:ED89 A9 03 00    LDA #$0003             ;\
$A7:ED8C 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 3
$A7:ED8F A9 62 E8    LDA #$E862             ;\
$A7:ED92 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E862 (hit ceiling)
$A7:ED95 6B          RTL                    ; Return

$A7:ED96 A9 0B 00    LDA #$000B             ;\
$A7:ED99 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = Bh
$A7:ED9C A9 01 00    LDA #$0001             ;\
$A7:ED9F 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EDA2 A9 54 E8    LDA #$E854             ;\
$A7:EDA5 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E854 (hopping - facing left)
$A7:EDA8 BD B6 0F    LDA $0FB6,x            ;\
$A7:EDAB 89 02 00    BIT #$0002             ;} If [enemy etecoon ID] & 2 != 0: go to BRANCH_SUCCESS_ETECOON
$A7:EDAE D0 08       BNE $08    [$EDB8]     ;/

; BRANCH_HOP
$A7:EDB0 A9 C7 ED    LDA #$EDC7             ;\
$A7:EDB3 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EDC7 (start hop - top of room)
$A7:EDB6 80 0E       BRA $0E    [$EDC6]     ; Return

; BRANCH_SUCCESS_ETECOON
$A7:EDB8 BD 7A 0F    LDA $0F7A,x            ;\
$A7:EDBB C9 40 03    CMP #$0340             ;} If [enemy X position] >= 340h: go to BRANCH_HOP
$A7:EDBE 10 F0       BPL $F0    [$EDB0]     ;/
$A7:EDC0 A9 3E EE    LDA #$EE3E             ;\
$A7:EDC3 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EE3E (hop until Samus is near)

$A7:EDC6 6B          RTL
}


;;; $EDC7: Etecoon function - start hop - top of room ;;;
{
$A7:EDC7 20 58 E9    JSR $E958  [$A7:E958]  ; Freeze etecoon if quake active
$A7:EDCA DE B0 0F    DEC $0FB0,x            ; Decrement enemy function timer
$A7:EDCD F0 02       BEQ $02    [$EDD1]     ;\
$A7:EDCF 10 6C       BPL $6C    [$EE3D]     ;} If [enemy function timer] > 0: return

$A7:EDD1 BD B4 0F    LDA $0FB4,x            ;\
$A7:EDD4 18          CLC                    ;|
$A7:EDD5 69 00 01    ADC #$0100             ;} Increment enemy hop counter
$A7:EDD8 9D B4 0F    STA $0FB4,x            ;/
$A7:EDDB 29 00 FF    AND #$FF00             ;\
$A7:EDDE C9 00 04    CMP #$0400             ;} If [enemy hop counter] >= 4:
$A7:EDE1 30 2B       BMI $2B    [$EE0E]     ;/
$A7:EDE3 BD B4 0F    LDA $0FB4,x            ;\
$A7:EDE6 29 FF 00    AND #$00FF             ;} Enemy hop counter = 0
$A7:EDE9 9D B4 0F    STA $0FB4,x            ;/
$A7:EDEC BD B6 0F    LDA $0FB6,x            ;\
$A7:EDEF 89 02 00    BIT #$0002             ;} If [enemy etecoon ID] & 2 = 0:
$A7:EDF2 D0 1A       BNE $1A    [$EE0E]     ;/
$A7:EDF4 A9 9A EE    LDA #$EE9A             ;\
$A7:EDF7 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EE9A (running for failed morph tunnel jump)
$A7:EDFA A9 80 E8    LDA #$E880             ;\
$A7:EDFD 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E880 (running right)
$A7:EE00 AD 08 E9    LDA $E908  [$A7:E908]  ;\
$A7:EE03 9D AC 0F    STA $0FAC,x            ;|
$A7:EE06 AD 0A E9    LDA $E90A  [$A7:E90A]  ;} Enemy X velocity = 2.0
$A7:EE09 9D AE 0F    STA $0FAE,x            ;/
$A7:EE0C 80 0E       BRA $0E    [$EE1C]     ; Go to BRANCH_MERGE

$A7:EE0E A9 75 ED    LDA #$ED75             ;\
$A7:EE11 9D B2 0F    STA $0FB2,x            ;} Enemy function = $ED75 (hopping - top of room)
$A7:EE14 BD 92 0F    LDA $0F92,x            ;\
$A7:EE17 1A          INC A                  ;|
$A7:EE18 1A          INC A                  ;} Enemy instruction list pointer += 2 (wake up)
$A7:EE19 9D 92 0F    STA $0F92,x            ;/

; BRANCH_MERGE
$A7:EE1C AD 00 E9    LDA $E900  [$A7:E900]  ;\
$A7:EE1F 9D A8 0F    STA $0FA8,x            ;|
$A7:EE22 AD 02 E9    LDA $E902  [$A7:E902]  ;} Enemy Y velocity = -3.0
$A7:EE25 9D AA 0F    STA $0FAA,x            ;/
$A7:EE28 A9 01 00    LDA #$0001             ;\
$A7:EE2B 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EE2E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A7:EE31 C9 00 01    CMP #$0100             ;} If [Samus X position] >= 100h:
$A7:EE34 30 07       BMI $07    [$EE3D]     ;/
$A7:EE36 A9 33 00    LDA #$0033             ;\
$A7:EE39 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 33h, sound library 2, max queued sounds allowed = 6 (etecoon cry)

$A7:EE3D 6B          RTL
}


;;; $EE3E: Etecoon function - hop until Samus is near ;;;
{
$A7:EE3E 20 58 E9    JSR $E958  [$A7:E958]  ; Freeze etecoon if quake active
$A7:EE41 DE B0 0F    DEC $0FB0,x            ; Decrement enemy function timer
$A7:EE44 F0 02       BEQ $02    [$EE48]     ;\
$A7:EE46 10 51       BPL $51    [$EE99]     ;} If [enemy function timer] > 0: return

$A7:EE48 A9 40 00    LDA #$0040             ;\
$A7:EE4B 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;|
$A7:EE4F A8          TAY                    ;} If Samus is within 40h pixels rows of enemy:
$A7:EE50 F0 18       BEQ $18    [$EE6A]     ;/
$A7:EE52 A9 30 00    LDA #$0030             ;\
$A7:EE55 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;|
$A7:EE59 A8          TAY                    ;} If Samus is within 30h pixel columns of enemy:
$A7:EE5A F0 0E       BEQ $0E    [$EE6A]     ;/
$A7:EE5C A9 80 E8    LDA #$E880             ;\
$A7:EE5F 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E880 (running right)
$A7:EE62 A9 DF EC    LDA #$ECDF             ;\
$A7:EE65 9D B2 0F    STA $0FB2,x            ;} Enemy function = $ECDF (running for successful morph tunnel jump)
$A7:EE68 80 29       BRA $29    [$EE93]

$A7:EE6A AD 00 E9    LDA $E900  [$A7:E900]  ;\ Else (Samus is not within 30h x 40h pixels of enemy):
$A7:EE6D 9D A8 0F    STA $0FA8,x            ;|
$A7:EE70 AD 02 E9    LDA $E902  [$A7:E902]  ;} Enemy Y velocity = -3.0
$A7:EE73 9D AA 0F    STA $0FAA,x            ;/
$A7:EE76 BD 92 0F    LDA $0F92,x            ;\
$A7:EE79 1A          INC A                  ;|
$A7:EE7A 1A          INC A                  ;} Enemy instruction list pointer += 2
$A7:EE7B 9D 92 0F    STA $0F92,x            ;/
$A7:EE7E A9 75 ED    LDA #$ED75             ;\
$A7:EE81 9D B2 0F    STA $0FB2,x            ;} Enemy function = $ED75 (hopping - top of room)
$A7:EE84 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A7:EE87 C9 00 01    CMP #$0100             ;} If [Samus X position] >= 100h:
$A7:EE8A 30 07       BMI $07    [$EE93]     ;/
$A7:EE8C A9 33 00    LDA #$0033             ;\
$A7:EE8F 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 33h, sound library 2, max queued sounds allowed = 6 (etecoon cry)

$A7:EE93 A9 01 00    LDA #$0001             ;\
$A7:EE96 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1

$A7:EE99 6B          RTL
}


;;; $EE9A: Etecoon function - running for failed morph tunnel jump ;;;
{
$A7:EE9A 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:EE9D BD 7A 0F    LDA $0F7A,x            ;\
$A7:EEA0 C9 58 02    CMP #$0258             ;} If [enemy X position] >= 258h:
$A7:EEA3 30 12       BMI $12    [$EEB7]     ;/
$A7:EEA5 A9 B8 EE    LDA #$EEB8             ;\
$A7:EEA8 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EEB8 (failed tunnel jump)
$A7:EEAB A9 01 00    LDA #$0001             ;\
$A7:EEAE 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EEB1 A9 98 E8    LDA #$E898             ;\
$A7:EEB4 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E898 (jumping right)

$A7:EEB7 6B          RTL
}


;;; $EEB8: Etecoon function - failed tunnel jump ;;;
{
$A7:EEB8 20 74 E9    JSR $E974  [$A7:E974]  ; Etecoon horizontal movement
$A7:EEBB 20 83 E9    JSR $E983  [$A7:E983]  ; Etecoon vertical movement
$A7:EEBE 90 2A       BCC $2A    [$EEEA]     ; If collision:
$A7:EEC0 AD 0C E9    LDA $E90C  [$A7:E90C]  ;\
$A7:EEC3 9D AC 0F    STA $0FAC,x            ;|
$A7:EEC6 AD 0E E9    LDA $E90E  [$A7:E90E]  ;} Enemy X velocity = -2.0
$A7:EEC9 9D AE 0F    STA $0FAE,x            ;/
$A7:EECC A9 02 EB    LDA #$EB02             ;\
$A7:EECF 9D B2 0F    STA $0FB2,x            ;} Enemy function = $EB02 (running left)
$A7:EED2 AD 00 E9    LDA $E900  [$A7:E900]  ;\
$A7:EED5 9D A8 0F    STA $0FA8,x            ;|
$A7:EED8 AD 02 E9    LDA $E902  [$A7:E902]  ;} Enemy Y velocity = -3.0
$A7:EEDB 9D AA 0F    STA $0FAA,x            ;/
$A7:EEDE A9 01 00    LDA #$0001             ;\
$A7:EEE1 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A7:EEE4 A9 28 E8    LDA #$E828             ;\
$A7:EEE7 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $E828 (running left)

$A7:EEEA 6B          RTL
}


;;; $EEEB: RTL ;;;
{
$A7:EEEB 6B          RTL
}


;;; $EEEC: RTL ;;;
{
$A7:EEEC 6B          RTL
}


;;; $EEED: Spritemaps ;;;
{
$A7:EEED             dx 0003, 01F2,FF,3329, C3F5,EF,3300, C3FA,F7,3302
$A7:EEFE             dx 0002, C3F5,F0,3300, C3FA,F8,3304
$A7:EF0A             dx 0002, C3F5,F1,3300, C3FA,F9,3306
$A7:EF16             dx 0003, 0000,06,3326, 01F8,06,3325, C3F8,F6,3308
$A7:EF27             dx 0003, 0006,F8,3327, 0006,00,3328, C3F6,F8,330A
$A7:EF38             dx 0003, 0000,F2,B326, 01F8,F2,B325, C3F8,FA,F308
$A7:EF49             dx 0003, 01F2,F8,7327, 01F2,00,7328, C3FA,F8,F30A
$A7:EF5A             dx 0003, 0008,02,332E, C3F3,F3,3300, C3F8,FA,330E
$A7:EF6B             dx 0007, 0001,FE,7322, 01F8,FE,3322, C3F8,F2,730C, 01F9,01,3324, 0000,01,7324, 01F9,FA,3320, 0000,FA,7320
$A7:EF90             dx 0007, 01F7,FC,3322, 0002,FC,7322, C3F8,F1,730C, 01F9,01,3323, 0000,01,7323, 01F9,FA,3320, 0000,FA,7320
$A7:EFB5             dx 0007, 01F9,01,3323, 0000,01,7323, C3F8,EF,730C, 01F9,F9,3320, 0000,F9,7320, 01F5,F9,3321, 0004,F9,7321
$A7:EFDA             dx 0007, 01F9,01,3323, 0000,01,7323, C3F8,EF,730C, 01F9,F9,3320, 0000,F9,7320, 01F5,F7,3321, 0004,F7,7321
$A7:EFFF             dx 0007, C3F8,F0,3300, 0002,FC,7322, 01F7,FC,3322, 01F9,02,3324, 0000,02,7324, 01F9,FA,3320, 0000,FA,7320
$A7:F024             dx 0007, 0002,FC,7322, 01F7,FC,3322, C3F8,F0,730C, 01F9,02,3324, 0000,02,7324, 01F9,FA,3320, 0000,FA,7320
$A7:F049             dx 0007, C3F8,F0,7300, 0002,FC,7322, 01F7,FC,3322, 01F9,02,3324, 0000,02,7324, 01F9,FA,3320, 0000,FA,7320
$A7:F06E             dx 0005, C3F6,F2,3300, 0000,00,332D, 01F8,00,332C, 0000,F8,332B, 01F8,F8,332A
$A7:F089             dx 0003, 0006,FF,7329, C3FB,EF,7300, C3F6,F7,7302
$A7:F09A             dx 0002, C3FB,F0,7300, C3F6,F8,7304
$A7:F0A6             dx 0002, C3FB,F1,7300, C3F6,F9,7306
$A7:F0B2             dx 0003, 01F8,06,7326, 0000,06,7325, C3F8,F6,7308
$A7:F0C3             dx 0003, 01F2,F8,7327, 01F2,00,7328, C3FA,F8,730A
$A7:F0D4             dx 0003, 01F8,F2,F326, 0000,F2,F325, C3F8,FA,B308
$A7:F0E5             dx 0003, 0006,F8,3327, 0006,00,3328, C3F6,F8,B30A
$A7:F0F6             dx 0003, 01F0,02,732E, C3FD,F3,7300, C3F8,FA,730E
$A7:F107             dx 0007, 01F7,FE,3322, 0000,FE,7322, C3F8,F2,330C, 01FF,01,7324, 01F8,01,3324, 01FF,FA,7320, 01F8,FA,3320
$A7:F12C             dx 0007, 0001,FC,7322, 01F6,FC,3322, C3F8,F1,330C, 01FF,01,7323, 01F8,01,3323, 01FF,FA,7320, 01F8,FA,3320
$A7:F151             dx 0007, 01FF,01,7323, 01F8,01,3323, C3F8,EF,330C, 01FF,F9,7320, 01F8,F9,3320, 0003,F9,7321, 01F4,F9,3321
$A7:F176             dx 0007, 01FF,01,7323, 01F8,01,3323, C3F8,EF,330C, 01FF,F9,7320, 01F8,F9,3320, 0003,F7,7321, 01F4,F7,3321
$A7:F19B             dx 0007, C3F8,F0,7300, 01F6,FC,3322, 0001,FC,7322, 01FF,02,7324, 01F8,02,3324, 01FF,FA,7320, 01F8,FA,3320
$A7:F1C0             dx 0007, 01F6,FC,3322, 0001,FC,7322, C3F8,F0,330C, 01FF,02,7324, 01F8,02,3324, 01FF,FA,7320, 01F8,FA,3320
$A7:F1E5             dx 0007, C3F8,F0,3300, 01F6,FC,3322, 0001,FC,7322, 01FF,02,7324, 01F8,02,3324, 01FF,FA,7320, 01F8,FA,3320
$A7:F20A             dx 0005, C3FA,F2,7300, 01F8,00,732D, 0000,00,732C, 01F8,F8,732B, 0000,F8,732A
}
}


;;; $F225..FF81: Dachora ;;;
{
;;; $F225: Palettes ;;;
{
; Default
$A7:F225             dw 3800,3F57,2E4D,00E2,0060,3AB0,220B,1166,0924,57FF,42F7,2610,158C,7C1F,6018,300A

; Speed boosting
$A7:F245             dw 1580,3F57,2E4D,00E2,0060,3AB0,220B,1166,0924,57FF,42F7,2610,158C,7C1F,6018,300A
$A7:F265             dw 3800,5357,424D,14E2,1460,4EB0,360B,2566,1D24,63FF,56F7,3A10,298C,7C1F,6818,440A
$A7:F285             dw 3800,6B57,5A4D,2CE2,2C60,66B0,4E0B,3D66,3524,73FF,6AF7,5210,418C,7C1F,7418,5C0A
$A7:F2A5             dw 3800,7F57,6E4D,40E2,4060,7AB0,620B,5166,4924,7FFF,7EF7,6610,558C,7C1F,7C18,700A

; Shine (both stored and shinespark)
$A7:F2C5             dw 3800,3F57,2E4D,00E2,0060,3AB0,220B,1166,0924,57FF,42F7,2610,158C,7C1F,6018,300A
$A7:F2E5             dw 3800,4B78,3E90,1967,1906,46F3,326F,25EB,1DA9,5FFF,4F18,3673,29EF,7CDF,64D9,3CCE
$A7:F305             dw 3800,579A,4EF4,320D,31CC,5336,46D3,3A70,362E,67FF,5B5A,46D6,3E73,7D9F,699A,4D92
$A7:F325             dw 3800,63BB,5F37,4AB3,4A72,6379,5737,52F5,4ED4,6FFF,677B,5B39,52F7,7E5F,725C,5E56
}


;;; $F345..F4C8: Instruction lists ;;;
{
;;; $F345: Instruction list - running left ;;;
{
$A7:F345             dw 0005,F9C4,
                        0005,F9F3,
                        0005,FA22,
                        0005,FA5B,
                        0005,FA8A,
                        0005,FAB9,
                        80ED,F345   ; Go to $F345

; Fast animation
$A7:F361             dw 0003,F9C4,
                        0003,F9F3,
                        0003,FA22,
                        0003,FA5B,
                        0003,FA8A,
                        0003,FAB9,
                        80ED,F361   ; Go to $F361

; Very fast animation
$A7:F37D             dw 0001,F9C4,
                        0001,F9F3,
                        0001,FA22,
                        0001,FA5B,
                        0001,FA8A,
                        0001,FAB9,
                        80ED,F37D   ; Go to $F37D
}


;;; $F399: Instruction list - idling - facing left ;;;
{
$A7:F399             dx 0030,FB50,
                        000A,FBE7,
                        0007,FC16,
                        0007,FC45,
                        0007,FC74,
                        0007,FC45,
                        0007,FC16,
                        0007,FC45,
                        0007,FC74,
                        0007,FC45,
                        000A,FBE7,
                        80ED,F399   ; Go to $F399
}


;;; $F3C9: Instruction list - blinking - facing left ;;;
{
$A7:F3C9             dx 000B,FB50,
                        0008,FB7F,
                        0008,FBB3,
                        0004,FB50,
                        0004,FB7F,
                        0004,FBB3,
                        000A,FB50,
                        0005,FB7F,
                        000B,FBB3,
                        80ED,F3C9   ; Go to $F3C9
}


;;; $F3F1: Unused. Instruction list - charge shinespark - facing left ;;;
{
$A7:F3F1             dx 0001,FAF2,
                        812F        ; Sleep
}


;;; $F3F7: Instruction list - echo - facing left ;;;
{
$A7:F3F7             dx 000A,FB1C,
                        80ED,F3F7   ; Go to $F3F7
}


;;; $F3FF: Instruction list - falling - facing left ;;;
{
$A7:F3FF             dx 0005,FA8A,
                        80ED,F3FF   ; Go to $F3FF
}


;;; $F407: Instruction list - running right ;;;
{
$A7:F407             dx 0005,FCA3,
                        0005,FCD2,
                        0005,FD01,
                        0005,FD3A,
                        0005,FD69,
                        0005,FD98,
                        80ED,F407   ; Go to $F407

; Fast animation
$A7:F423             dx 0003,FCA3,
                        0003,FCD2,
                        0003,FD01,
                        0003,FD3A,
                        0003,FD69,
                        0003,FD98,
                        80ED,F423   ; Go to $F423

; Very fast animation
$A7:F43F             dx 0001,FCA3,
                        0001,FCD2,
                        0001,FD01,
                        0001,FD3A,
                        0001,FD69,
                        0001,FD98,
                        80ED,F43F   ; Go to $F43F
}


;;; $F45B: Instruction list - idling - facing right ;;;
{
$A7:F45B             dx 0030,FE2F,
                        000A,FEC6,
                        0007,FEF5,
                        0007,FF24,
                        0007,FF53,
                        0007,FF24,
                        0007,FEF5,
                        0007,FF24,
                        0007,FF53,
                        0007,FF24,
                        000A,FEC6,
                        80ED,F45B   ; Go to $F45B
}


;;; $F48B: Instruction list - blinking - facing right ;;;
{
$A7:F48B             dx 000B,FE2F,
                        0008,FE5E,
                        0008,FE92,
                        0004,FE2F,
                        0004,FE5E,
                        0004,FE92,
                        000A,FE2F,
                        0005,FE5E,
                        000B,FE92,
                        80ED,F48B   ; Go to $F48B
}


;;; $F4B3: Instruction list - charge shinespark - facing right ;;;
{
$A7:F4B3             dx 0001,FDD1,
                        812F        ; Sleep
}


;;; $F4B9: Instruction list - echo - facing right ;;;
{
$A7:F4B9             dx 000A,FDFB,
                        80ED,F4B9   ; Go to $F4B9
}


;;; $F4C1: Instruction list - falling - facing right ;;;
{
$A7:F4C1             dx 0005,FD69,
                        80ED,F4C1   ; Go to $F4C1
}
}


;;; $F4C9: Dachora constants ;;;
{
; Max X distance between dachora and Samus before dachora starts running
$A7:F4C9             dw 0060 ; X threshold

; Unused max X distance between dachora and Samus before dachora stops running
$A7:F4CB             dw 0060

; Blinking duration, between dachora seeing Samus and starting to run
$A7:F4CD             dw 0078

; Delay before activating shinespark
$A7:F4CF             dw 003C

; Echo position update interval
$A7:F4D1             dw 0001

; Echo lifetime
$A7:F4D3             dw 0008

; Max X speed
$A7:F4D5             dw 0008, 0000

; X acceleration
$A7:F4D9             dw 0000, 1000
}


;;; $F4DD: Initialisation AI - enemy $E5FF (dachora) ;;;
{
$A7:F4DD AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:F4E0 BD 86 0F    LDA $0F86,x[$7E:1186]  ;\
$A7:F4E3 09 00 20    ORA #$2000             ;} Set enemy to process instructions
$A7:F4E6 9D 86 0F    STA $0F86,x[$7E:1186]  ;/
$A7:F4E9 A9 4D 80    LDA #$804D             ;\
$A7:F4EC 9D 8E 0F    STA $0F8E,x[$7E:118E]  ;} Enemy spritemap pointer = $804D
$A7:F4EF A9 01 00    LDA #$0001             ;\
$A7:F4F2 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:F4F5 9E 90 0F    STZ $0F90,x[$7E:1190]  ; Enemy timer = 0
$A7:F4F8 BD B4 0F    LDA $0FB4,x[$7E:11B4]  ;\
$A7:F4FB 30 17       BMI $17    [$F514]     ;} If [enemy parameter 1] & 8000h != 0: go to BRANCH_ECHO
$A7:F4FD F0 08       BEQ $08    [$F507]     ; If [enemy direction] != left:
$A7:F4FF A9 5B F4    LDA #$F45B             ;\
$A7:F502 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $F45B (idling - facing right)
$A7:F505 80 06       BRA $06    [$F50D]

$A7:F507 A9 99 F3    LDA #$F399             ;\ Else ([enemy direction] = left):
$A7:F50A 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $F399 (idling - facing left)

$A7:F50D A9 70 F5    LDA #$F570             ;\
$A7:F510 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $F570 (wait for Samus to be near)
$A7:F513 6B          RTL                    ; Return

; BRANCH_ECHO
$A7:F514 89 01 00    BIT #$0001             ;\
$A7:F517 F0 08       BEQ $08    [$F521]     ;} If (enemy direction) != left:
$A7:F519 A9 B9 F4    LDA #$F4B9             ;\
$A7:F51C 9D 92 0F    STA $0F92,x[$7E:11D2]  ;} Enemy instruction list pointer = $F4B9 (echo - facing right)
$A7:F51F 80 06       BRA $06    [$F527]

$A7:F521 A9 F7 F3    LDA #$F3F7             ;\ Else ((enemy direction) = left):
$A7:F524 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $F3F7 (echo - facing left)

$A7:F527 A9 8C F9    LDA #$F98C             ;\
$A7:F52A 9D B2 0F    STA $0FB2,x[$7E:11F2]  ;} Enemy function = $F98C (echo)
$A7:F52D 6B          RTL
}


;;; $F52E: Main AI - enemy $E5FF (dachora) ;;;
{
$A7:F52E AE 54 0E    LDX $0E54  [$7E:0E54]
$A7:F531 7C B2 0F    JMP ($0FB2,x)[$A7:F570]; Go to [enemy function]
}


;;; $F534: Unused. RTL ;;;
{
$A7:F534 6B          RTL
}


;;; $F535: Load dachora palette ;;;
{
;; Parameters:
;;     Y: Palette source address
$A7:F535 08          PHP
$A7:F536 C2 30       REP #$30
$A7:F538 DA          PHX
$A7:F539 A9 00 7E    LDA #$7E00             ;\
$A7:F53C 85 01       STA $01    [$7E:0001]  ;|
$A7:F53E BD 96 0F    LDA $0F96,x[$7E:1196]  ;|
$A7:F541 EB          XBA                    ;|
$A7:F542 4A          LSR A                  ;} $00 = $7E:C100 + [enemy palette index] / 200h * 20h
$A7:F543 0A          ASL A                  ;|
$A7:F544 AA          TAX                    ;|
$A7:F545 BD 5F F5    LDA $F55F,x[$A7:F56D]  ;|
$A7:F548 85 00       STA $00    [$7E:0000]  ;/
$A7:F54A BB          TYX                    ;\
$A7:F54B A0 00 00    LDY #$0000             ;|
                                            ;|
$A7:F54E BD 00 00    LDA $0000,x[$A7:F245]  ;|
$A7:F551 97 00       STA [$00],y[$7E:C1E0]  ;|
$A7:F553 E8          INX                    ;} Copy 20h bytes from [Y] to [$00]
$A7:F554 E8          INX                    ;|
$A7:F555 C8          INY                    ;|
$A7:F556 C8          INY                    ;|
$A7:F557 C0 20 00    CPY #$0020             ;|
$A7:F55A 30 F2       BMI $F2    [$F54E]     ;/
$A7:F55C FA          PLX
$A7:F55D 28          PLP
$A7:F55E 60          RTS

$A7:F55F             dw C100, C120, C140, C160, C180, C1A0, C1C0, C1E0
}


;;; $F56F: Unused. RTL ;;;
{
$A7:F56F 6B          RTL
}


;;; $F570: Dachora function - wait for Samus to be near ;;;
{
$A7:F570 A9 01 00    LDA #$0001             ;\
$A7:F573 85 14       STA $14    [$7E:0014]  ;|
$A7:F575 64 12       STZ $12    [$7E:0012]  ;} Move enemy down by 1.0
$A7:F577 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A7:F57B A9 40 00    LDA #$0040             ;\
$A7:F57E 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;|
$A7:F582 A8          TAY                    ;} If Samus is not within 40h pixels rows of enemy: return
$A7:F583 F0 36       BEQ $36    [$F5BB]     ;/
$A7:F585 AD C9 F4    LDA $F4C9  [$A7:F4C9]  ;\
$A7:F588 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;|
$A7:F58C A8          TAY                    ;} If Samus is not within 60h pixel columns of enemy: return
$A7:F58D F0 2C       BEQ $2C    [$F5BB]     ;/
$A7:F58F BD B4 0F    LDA $0FB4,x[$7E:11B4]  ;\
$A7:F592 F0 08       BEQ $08    [$F59C]     ;} If [enemy direction] != left:
$A7:F594 A9 8B F4    LDA #$F48B             ;\
$A7:F597 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $F48B (blinking - facing right)
$A7:F59A 80 06       BRA $06    [$F5A2]

$A7:F59C A9 C9 F3    LDA #$F3C9             ;\ Else ([enemy direction] = left):
$A7:F59F 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $F3C9 (blinking - facing left)

$A7:F5A2 A9 01 00    LDA #$0001             ;\
$A7:F5A5 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:F5A8 A9 BC F5    LDA #$F5BC             ;\
$A7:F5AB 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $F5BC (start running)
$A7:F5AE AD CD F4    LDA $F4CD  [$A7:F4CD]  ;\
$A7:F5B1 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;} Enemy function timer = 120
$A7:F5B4 A9 1D 00    LDA #$001D             ;\
$A7:F5B7 22 A3 90 80 JSL $8090A3[$80:90A3]  ;} Queue sound 1Dh, sound library 2, max queued sounds allowed = 15 (dachora cry)

$A7:F5BB 6B          RTL
}


;;; $F5BC: Dachora function - start running ;;;
{
$A7:F5BC DE A8 0F    DEC $0FA8,x[$7E:11A8]  ; Decrement enemy function timer
$A7:F5BF D0 2B       BNE $2B    [$F5EC]     ; If [enemy function timer] != 0: return
$A7:F5C1 BD B4 0F    LDA $0FB4,x[$7E:11B4]  ;\
$A7:F5C4 F0 0E       BEQ $0E    [$F5D4]     ;} If [enemy direction] != left:
$A7:F5C6 A9 07 F4    LDA #$F407             ;\
$A7:F5C9 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $F407 (running right)
$A7:F5CC A9 5E F6    LDA #$F65E             ;\
$A7:F5CF 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $F65E (running right)
$A7:F5D2 80 0C       BRA $0C    [$F5E0]

$A7:F5D4 A9 45 F3    LDA #$F345             ;\ Else ([enemy direction] = left):
$A7:F5D7 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $F345 (running left)
$A7:F5DA A9 ED F5    LDA #$F5ED             ;\
$A7:F5DD 9D B2 0F    STA $0FB2,x            ;} Enemy function = $F5ED (running left)

$A7:F5E0 A9 01 00    LDA #$0001             ;\
$A7:F5E3 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:F5E6 A9 01 00    LDA #$0001             ;\
$A7:F5E9 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;} Enemy palette index = 0, enemy palette timer = 1

$A7:F5EC 6B          RTL
}


;;; $F5ED: Dachora function - running left ;;;
{
$A7:F5ED 20 D5 F6    JSR $F6D5  [$A7:F6D5]  ; Accelerate running dachora
$A7:F5F0 A5 14       LDA $14    [$7E:0014]  ;\
$A7:F5F2 49 FF FF    EOR #$FFFF             ;|
$A7:F5F5 85 14       STA $14    [$7E:0014]  ;|
$A7:F5F7 A5 12       LDA $12    [$7E:0012]  ;|
$A7:F5F9 49 FF FF    EOR #$FFFF             ;|
$A7:F5FC 1A          INC A                  ;} Move enemy right by -[$14].[$12]
$A7:F5FD 85 12       STA $12    [$7E:0012]  ;|
$A7:F5FF D0 02       BNE $02    [$F603]     ;|
$A7:F601 E6 14       INC $14    [$7E:0014]  ;|
                                            ;|
$A7:F603 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A7:F607 B0 06       BCS $06    [$F60F]     ; If not collided with wall:
$A7:F609 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]  ; Align enemy Y position with non-square slope
$A7:F60D 80 2B       BRA $2B    [$F63A]     ; Go to BRANCH_NO_WALL

; BRANCH_STOP
$A7:F60F A9 07 F4    LDA #$F407             ;\
$A7:F612 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $F407 (running right)
$A7:F615 A9 5E F6    LDA #$F65E             ;\
$A7:F618 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $F65E (running right)
$A7:F61B A9 01 00    LDA #$0001             ;\
$A7:F61E 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;} Enemy palette index = 0, enemy palette timer = 1

; BRANCH_MERGE
$A7:F621 A9 01 00    LDA #$0001             ;\
$A7:F624 9D B4 0F    STA $0FB4,x[$7E:11B4]  ;} Enemy direction = right
$A7:F627 A9 01 00    LDA #$0001             ;\
$A7:F62A 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:F62D 9E A8 0F    STZ $0FA8,x[$7E:11A8]  ;\
$A7:F630 9E AA 0F    STZ $0FAA,x[$7E:11AA]  ;} Enemy speed = 0.0
$A7:F633 A0 25 F2    LDY #$F225             ;\
$A7:F636 20 35 F5    JSR $F535  [$A7:F535]  ;} Load default palette
$A7:F639 6B          RTL                    ; Return

; BRANCH_NO_WALL
$A7:F63A BD 7A 0F    LDA $0F7A,x[$7E:117A]  ;\
$A7:F63D C9 60 00    CMP #$0060             ;} If [enemy X position] < 60h: go to BRANCH_STOP
$A7:F640 30 CD       BMI $CD    [$F60F]     ;/
$A7:F642 6B          RTL                    ; Return

; Unused branch
$A7:F643 AD CB F4    LDA $F4CB  [$A7:F4CB]  ;\
$A7:F646 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;|
$A7:F64A A8          TAY                    ;} If Samus is within 60h pixel columns of enemy: go to BRANCH_STOP
$A7:F64B D0 C2       BNE $C2    [$F60F]     ;/
$A7:F64D A9 5B F4    LDA #$F45B             ;\
$A7:F650 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $F45B (idling - facing right)
$A7:F653 A9 70 F5    LDA #$F570             ;\
$A7:F656 9D B2 0F    STA $0FB2,x            ;} Enemy function = $F570 (wait for Samus to be near)
$A7:F659 9E B0 0F    STZ $0FB0,x            ; Enemy palette index = enemy palette timer = 0
$A7:F65C 80 C3       BRA $C3    [$F621]     ; Go to BRANCH_MERGE
}


;;; $F65E: Dachora function - running right ;;;
{
$A7:F65E 20 D5 F6    JSR $F6D5  [$A7:F6D5]  ; Accelerate running dachora
$A7:F661 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [$14].[$12]
$A7:F665 B0 06       BCS $06    [$F66D]     ; If not collided with wall:
$A7:F667 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]  ; Align enemy Y position with non-square slope
$A7:F66B 80 2C       BRA $2C    [$F699]     ; Go to BRANCH_NO_WALL

$A7:F66D A9 71 00    LDA #$0071             ;\
$A7:F670 22 A3 90 80 JSL $8090A3[$80:90A3]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 15 (silence)
$A7:F674 A9 45 F3    LDA #$F345             ;\
$A7:F677 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $F345 (running left)
$A7:F67A A9 ED F5    LDA #$F5ED             ;\
$A7:F67D 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $F5ED (running left)

; BRANCH_MERGE
$A7:F680 9E B4 0F    STZ $0FB4,x[$7E:11B4]  ; Enemy direction = left
$A7:F683 9E A8 0F    STZ $0FA8,x[$7E:11A8]  ; Enemy speed = 0
$A7:F686 A0 25 F2    LDY #$F225             ;\
$A7:F689 20 35 F5    JSR $F535  [$A7:F535]  ;} Load default palette

; BRANCH_NEW_ANIMATION
$A7:F68C 9E B0 0F    STZ $0FB0,x[$7E:11B0]  ; Enemy palette index = enemy palette timer = 0
$A7:F68F 9E AA 0F    STZ $0FAA,x[$7E:11AA]  ; Enemy subspeed = 0
$A7:F692 A9 01 00    LDA #$0001             ;\
$A7:F695 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:F698 6B          RTL                    ; Return

; BRANCH_NO_WALL
$A7:F699 BD 7A 0F    LDA $0F7A,x[$7E:117A]  ;\
$A7:F69C C9 80 04    CMP #$0480             ;} If [enemy X position] < 480h:
$A7:F69F 10 01       BPL $01    [$F6A2]     ;/
$A7:F6A1 6B          RTL                    ; Return

$A7:F6A2 A9 B3 F4    LDA #$F4B3             ;\
$A7:F6A5 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $F4B3 (charge shinespark - facing right)
$A7:F6A8 A9 8F F7    LDA #$F78F             ;\
$A7:F6AB 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $F78F (activate shinespark)
$A7:F6AE AD CF F4    LDA $F4CF  [$A7:F4CF]  ;\
$A7:F6B1 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;} Enemy function timer = 60
$A7:F6B4 BD 7E 0F    LDA $0F7E,x[$7E:117E]  ;\
$A7:F6B7 18          CLC                    ;|
$A7:F6B8 69 08 00    ADC #$0008             ;} Enemy Y position += 8
$A7:F6BB 9D 7E 0F    STA $0F7E,x[$7E:117E]  ;/
$A7:F6BE A9 3D 00    LDA #$003D             ;\
$A7:F6C1 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 3Dh, sound library 2, max queued sounds allowed = 6 (dachora stored shinespark)
$A7:F6C5 80 C5       BRA $C5    [$F68C]     ; Go to BRANCH_NEW_ANIMATION

; Unused branch
$A7:F6C7 A9 99 F3    LDA #$F399             ;\
$A7:F6CA 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $F399 (idling - facing left)
$A7:F6CD A9 70 F5    LDA #$F570             ;\
$A7:F6D0 9D B2 0F    STA $0FB2,x            ;} Enemy function = $F570 (wait for Samus to be near)
$A7:F6D3 80 AB       BRA $AB    [$F680]     ; Go to BRANCH_MERGE
}


;;; $F6D5: Accelerate running dachora ;;;
{
;; Returns:
;;     $14.$12: X speed
$A7:F6D5 BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;\
$A7:F6D8 CD D5 F4    CMP $F4D5  [$A7:F4D5]  ;} If [enemy speed] < 8: go to BRANCH_NO_PALETTE_CHANGE
$A7:F6DB 30 42       BMI $42    [$F71F]     ;/
$A7:F6DD BD B0 0F    LDA $0FB0,x[$7E:11B0]  ;\
$A7:F6E0 C9 01 00    CMP #$0001             ;} If [enemy animation index] = 0 and [enemy animation timer] = 1:
$A7:F6E3 D0 07       BNE $07    [$F6EC]     ;/
$A7:F6E5 A9 39 00    LDA #$0039             ;\
$A7:F6E8 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 39h, sound library 2, max queued sounds allowed = 6 (dachora speed booster)

$A7:F6EC BD B0 0F    LDA $0FB0,x[$7E:11B0]  ;\
$A7:F6EF 3A          DEC A                  ;} Decrement enemy animation timer
$A7:F6F0 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;/
$A7:F6F3 29 FF 00    AND #$00FF             ;\
$A7:F6F6 F0 02       BEQ $02    [$F6FA]     ;} If [enemy animation timer] % 100h != 0: go to BRANCH_NO_PALETTE_CHANGE
$A7:F6F8 10 25       BPL $25    [$F71F]     ;/

$A7:F6FA BD B0 0F    LDA $0FB0,x[$7E:11B0]  ;\
$A7:F6FD EB          XBA                    ;|
$A7:F6FE 29 FF 00    AND #$00FF             ;|
$A7:F701 0A          ASL A                  ;|
$A7:F702 A8          TAY                    ;} Load palette $F245 + [enemy animation index] * 20h (speed boosting palette)
$A7:F703 B9 87 F7    LDA $F787,y[$A7:F787]  ;|
$A7:F706 A8          TAY                    ;|
$A7:F707 20 35 F5    JSR $F535  [$A7:F535]  ;/
$A7:F70A BD B0 0F    LDA $0FB0,x[$7E:11B0]  ;\
$A7:F70D 18          CLC                    ;|
$A7:F70E 69 10 01    ADC #$0110             ;|
$A7:F711 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;} Enemy animation frame = max([enemy animation frame] + 1, 3)
$A7:F714 C9 10 04    CMP #$0410             ;} Enemy animation timer = 10h
$A7:F717 30 06       BMI $06    [$F71F]     ;|
$A7:F719 A9 10 03    LDA #$0310             ;|
$A7:F71C 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;/

; BRANCH_NO_PALETTE_CHANGE
$A7:F71F A9 01 00    LDA #$0001             ;\
$A7:F722 85 14       STA $14    [$7E:0014]  ;|
$A7:F724 64 12       STZ $12    [$7E:0012]  ;} Move enemy down by 1.0
$A7:F726 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A7:F72A BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;\
$A7:F72D CD D5 F4    CMP $F4D5  [$A7:F4D5]  ;|
$A7:F730 30 1A       BMI $1A    [$F74C]     ;|
$A7:F732 BD AA 0F    LDA $0FAA,x[$7E:11AA]  ;} If [enemy speed] >= 8.0:
$A7:F735 CD D7 F4    CMP $F4D7  [$A7:F4D7]  ;|
$A7:F738 30 12       BMI $12    [$F74C]     ;/
$A7:F73A AD D5 F4    LDA $F4D5  [$A7:F4D5]  ;\
$A7:F73D 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;|
$A7:F740 85 14       STA $14    [$7E:0014]  ;|
$A7:F742 AD D7 F4    LDA $F4D7  [$A7:F4D7]  ;} $14.$12 = enemy speed = 8.0
$A7:F745 9D AA 0F    STA $0FAA,x[$7E:11AA]  ;|
$A7:F748 85 12       STA $12    [$7E:0012]  ;/
$A7:F74A 80 3A       BRA $3A    [$F786]     ; Return

$A7:F74C BD AA 0F    LDA $0FAA,x[$7E:11AA]  ;\
$A7:F74F 18          CLC                    ;|
$A7:F750 6D DB F4    ADC $F4DB  [$A7:F4DB]  ;|
$A7:F753 9D AA 0F    STA $0FAA,x[$7E:11AA]  ;|
$A7:F756 85 12       STA $12    [$7E:0012]  ;} Enemy speed += 0.1000h
$A7:F758 BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;} $14.$12 = [enemy speed]
$A7:F75B 6D D9 F4    ADC $F4D9  [$A7:F4D9]  ;|
$A7:F75E 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;|
$A7:F761 85 14       STA $14    [$7E:0014]  ;/
$A7:F763 C9 04 00    CMP #$0004             ;\
$A7:F766 D0 12       BNE $12    [$F77A]     ;} If [enemy speed] != 4: go to BRANCH_CHECK_MAX_SPEED
$A7:F768 A5 12       LDA $12    [$7E:0012]  ;\
$A7:F76A C9 00 00    CMP #$0000             ;} If [enemy speed] != 4.0: return
$A7:F76D D0 17       BNE $17    [$F786]     ;/

; BRANCH_MAX_SPEED
$A7:F76F BD 92 0F    LDA $0F92,x[$7E:1192]  ;\
$A7:F772 18          CLC                    ;|
$A7:F773 69 1C 00    ADC #$001C             ;} Enemy instruction list pointer += 1Ch
$A7:F776 9D 92 0F    STA $0F92,x[$7E:1192]  ;/
$A7:F779 60          RTS                    ; Return

; BRANCH_CHECK_MAX_SPEED
$A7:F77A C9 08 00    CMP #$0008             ;\
$A7:F77D D0 07       BNE $07    [$F786]     ;|
$A7:F77F A5 12       LDA $12    [$7E:0012]  ;} If [enemy speed] = 8.0: go to BRANCH_MAX_SPEED
$A7:F781 C9 00 00    CMP #$0000             ;|
$A7:F784 F0 E9       BEQ $E9    [$F76F]     ;/

$A7:F786 60          RTS

$A7:F787             dw F245, F265, F285, F2A5
}


;;; $F78F: Dachora function - activate shinespark ;;;
{
$A7:F78F 20 0A F9    JSR $F90A  [$A7:F90A]  ; Load dachora shine palette
$A7:F792 DE A8 0F    DEC $0FA8,x[$7E:11A8]  ; Decrement enemy function timer
$A7:F795 D0 6E       BNE $6E    [$F805]     ; If [enemy function timer] != 0: return
$A7:F797 BD 92 0F    LDA $0F92,x[$7E:1192]  ;\
$A7:F79A 1A          INC A                  ;|
$A7:F79B 1A          INC A                  ;} Enemy instruction list pointer += 2
$A7:F79C 9D 92 0F    STA $0F92,x[$7E:1192]  ;/
$A7:F79F A9 01 00    LDA #$0001             ;\
$A7:F7A2 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:F7A5 A9 06 F8    LDA #$F806             ;\
$A7:F7A8 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $F806 (shinesparking)
$A7:F7AB 9E E8 0F    STZ $0FE8,x[$7E:11E8]  ; Enemy ([X] + 1) position update timer = 0
$A7:F7AE 9E EE 0F    STZ $0FEE,x[$7E:11EE]  ; Enemy ([X] + 1) visibility timer = 0
$A7:F7B1 9E 2E 10    STZ $102E,x[$7E:122E]  ; Enemy ([X] + 2) visibility timer = 0
$A7:F7B4 9E 6E 10    STZ $106E,x[$7E:126E]  ; Enemy ([X] + 3) visibility timer = 0 
$A7:F7B7 9E AE 10    STZ $10AE,x[$7E:12AE]  ; Enemy ([X] + 4) visibility timer = 0
$A7:F7BA 9E AC 0F    STZ $0FAC,x[$7E:11AC]  ;\
$A7:F7BD 9E AE 0F    STZ $0FAE,x[$7E:11AE]  ;} Enemy Y acceleration = 0.0
$A7:F7C0 BD 7E 0F    LDA $0F7E,x[$7E:117E]  ;\
$A7:F7C3 38          SEC                    ;|
$A7:F7C4 E9 08 00    SBC #$0008             ;} Enemy Y position -= 8
$A7:F7C7 9D 7E 0F    STA $0F7E,x[$7E:117E]  ;/
$A7:F7CA A9 3B 00    LDA #$003B             ;\
$A7:F7CD 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 3Bh, sound library 2, max queued sounds allowed = 6 (dachora shinespark)
$A7:F7D1 BD B4 0F    LDA $0FB4,x[$7E:11B4]  ;\
$A7:F7D4 F0 11       BEQ $11    [$F7E7]     ;} If [enemy direction] != left:
$A7:F7D6 A9 B9 F4    LDA #$F4B9             ;\
$A7:F7D9 9D D2 0F    STA $0FD2,x[$7E:11D2]  ;} Enemy ([X] + 1) instruction list pointer = $F4B9 (echo - facing right)
$A7:F7DC 9D 12 10    STA $1012,x[$7E:1212]  ; Enemy ([X] + 2) instruction list pointer = $F4B9 (echo - facing right)
$A7:F7DF 9D 52 10    STA $1052,x[$7E:1252]  ; Enemy ([X] + 3) instruction list pointer = $F4B9 (echo - facing right)
$A7:F7E2 9D 92 10    STA $1092,x[$7E:1292]  ; Enemy ([X] + 4) instruction list pointer = $F4B9 (echo - facing right)
$A7:F7E5 80 0F       BRA $0F    [$F7F6]

$A7:F7E7 A9 F7 F3    LDA #$F3F7             ;\ Else ([enemy direction] = left):
$A7:F7EA 9D D2 0F    STA $0FD2,x            ;} Enemy ([X] + 1) instruction list pointer = $F3F7 (echo - facing left)
$A7:F7ED 9D 12 10    STA $1012,x            ; Enemy ([X] + 2) instruction list pointer = $F3F7 (echo - facing left)
$A7:F7F0 9D 52 10    STA $1052,x            ; Enemy ([X] + 3) instruction list pointer = $F3F7 (echo - facing left)
$A7:F7F3 9D 92 10    STA $1092,x            ; Enemy ([X] + 4) instruction list pointer = $F3F7 (echo - facing left)

$A7:F7F6 A9 01 00    LDA #$0001             ;\
$A7:F7F9 9D D4 0F    STA $0FD4,x[$7E:11D4]  ;} Enemy ([X] + 1) instruction timer = 1
$A7:F7FC 9D 14 10    STA $1014,x[$7E:1214]  ; Enemy ([X] + 2) instruction timer = 1
$A7:F7FF 9D 54 10    STA $1054,x[$7E:1254]  ; Enemy ([X] + 3) instruction timer = 1
$A7:F802 9D 94 10    STA $1094,x[$7E:1294]  ; Enemy ([X] + 4) instruction timer = 1

$A7:F805 6B          RTL
}


;;; $F806: Dachora function - shinesparking ;;;
{
$A7:F806 20 0A F9    JSR $F90A  [$A7:F90A]  ; Load dachora shine palette
$A7:F809 20 9A F8    JSR $F89A  [$A7:F89A]  ; Update echo positions
$A7:F80C BD AE 0F    LDA $0FAE,x[$7E:11AE]  ;\
$A7:F80F 18          CLC                    ;|
$A7:F810 6F 32 0B 00 ADC $000B32[$7E:0B32]  ;|
$A7:F814 9D AE 0F    STA $0FAE,x[$7E:11AE]  ;} Enemy Y acceleration += [Samus Y acceleration]
$A7:F817 BD AC 0F    LDA $0FAC,x[$7E:11AC]  ;|
$A7:F81A 6F 34 0B 00 ADC $000B34[$7E:0B34]  ;|
$A7:F81E 9D AC 0F    STA $0FAC,x[$7E:11AC]  ;/
$A7:F821 BD AA 0F    LDA $0FAA,x[$7E:11AA]  ;\
$A7:F824 18          CLC                    ;|
$A7:F825 7D AE 0F    ADC $0FAE,x[$7E:11AE]  ;|
$A7:F828 9D AA 0F    STA $0FAA,x[$7E:11AA]  ;|
$A7:F82B 85 12       STA $12    [$7E:0012]  ;} Enemy speed += [enemy Y acceleration]
$A7:F82D BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;|
$A7:F830 7D AC 0F    ADC $0FAC,x[$7E:11AC]  ;|
$A7:F833 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;/
$A7:F836 85 14       STA $14    [$7E:0014]  ; $14.$12 = [enemy speed]
$A7:F838 C9 0F 00    CMP #$000F             ;\
$A7:F83B 30 05       BMI $05    [$F842]     ;|
$A7:F83D A9 0F 00    LDA #$000F             ;} $14 = min(Fh, [$14])
$A7:F840 85 14       STA $14    [$7E:0014]  ;/

$A7:F842 A5 14       LDA $14    [$7E:0014]  ;\
$A7:F844 49 FF FF    EOR #$FFFF             ;|
$A7:F847 85 14       STA $14    [$7E:0014]  ;|
$A7:F849 A5 12       LDA $12    [$7E:0012]  ;|
$A7:F84B 49 FF FF    EOR #$FFFF             ;|
$A7:F84E 1A          INC A                  ;} Move enemy down by -[$14].[$12]
$A7:F84F 85 12       STA $12    [$7E:0012]  ;|
$A7:F851 D0 02       BNE $02    [$F855]     ;|
$A7:F853 E6 14       INC $14    [$7E:0014]  ;|
                                            ;|
$A7:F855 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A7:F859 90 3E       BCC $3E    [$F899]     ; If not collided with block: return
$A7:F85B BD B4 0F    LDA $0FB4,x[$7E:11B4]  ;\
$A7:F85E D0 0E       BNE $0E    [$F86E]     ;} If [enemy direction] = left:
$A7:F860 A9 C1 F4    LDA #$F4C1             ;\
$A7:F863 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $F4C1 (falling - facing right)
$A7:F866 A9 01 00    LDA #$0001             ;\
$A7:F869 9D B4 0F    STA $0FB4,x            ;} Enemy direction = right
$A7:F86C 80 09       BRA $09    [$F877]

$A7:F86E A9 FF F3    LDA #$F3FF             ;\ Else ([enemy direction] != left):
$A7:F871 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $F3FF (falling - facing left)
$A7:F874 9E B4 0F    STZ $0FB4,x[$7E:11B4]  ; Enemy direction = left

$A7:F877 A9 35 F9    LDA #$F935             ;\
$A7:F87A 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $F935 (falling)
$A7:F87D A9 01 00    LDA #$0001             ;\
$A7:F880 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:F883 9E A8 0F    STZ $0FA8,x[$7E:11A8]  ;\
$A7:F886 9E AA 0F    STZ $0FAA,x[$7E:11AA]  ;} Enemy speed = 0.0
$A7:F889 9E B0 0F    STZ $0FB0,x[$7E:11B0]  ; Enemy palette index = enemy palette timer = 0
$A7:F88C A0 25 F2    LDY #$F225             ;\
$A7:F88F 20 35 F5    JSR $F535  [$A7:F535]  ;} Load default palette
$A7:F892 A9 3C 00    LDA #$003C             ;\
$A7:F895 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 3Ch, sound library 2, max queued sounds allowed = 6 (dachora shinespark ended)

$A7:F899 6B          RTL
}


;;; $F89A: Update echo positions ;;;
{
$A7:F89A BD E8 0F    LDA $0FE8,x[$7E:11E8]  ;\
$A7:F89D F0 05       BEQ $05    [$F8A4]     ;} If [enemy ([X] + 1) position update timer] != 0:
$A7:F89F 3A          DEC A                  ;\
$A7:F8A0 9D E8 0F    STA $0FE8,x[$7E:11E8]  ;} Decrement enemy ([X] + 1) position update timer
$A7:F8A3 60          RTS                    ; Return

$A7:F8A4 AD D1 F4    LDA $F4D1  [$A7:F4D1]  ;\
$A7:F8A7 9D E8 0F    STA $0FE8,x[$7E:11E8]  ;} Enemy ([X] + 1) position update timer = 1
$A7:F8AA BD EE 0F    LDA $0FEE,x[$7E:11EE]  ;\
$A7:F8AD D0 13       BNE $13    [$F8C2]     ;} If [enemy ([X] + 1) visibility timer] = 0:
$A7:F8AF BD 7A 0F    LDA $0F7A,x[$7E:117A]  ;\
$A7:F8B2 9D BA 0F    STA $0FBA,x[$7E:11BA]  ;} Enemy ([X] + 1) X position = [enemy X position]
$A7:F8B5 BD 7E 0F    LDA $0F7E,x[$7E:117E]  ;\
$A7:F8B8 9D BE 0F    STA $0FBE,x[$7E:11BE]  ;} Enemy ([X] + 1) Y position = [enemy Y position]
$A7:F8BB AD D3 F4    LDA $F4D3  [$A7:F4D3]  ;\
$A7:F8BE 9D EE 0F    STA $0FEE,x[$7E:11EE]  ;} Enemy ([X] + 1) visibility timer = 8
$A7:F8C1 60          RTS                    ; Return

$A7:F8C2 BD 2E 10    LDA $102E,x[$7E:122E]  ;\
$A7:F8C5 D0 13       BNE $13    [$F8DA]     ;} If [enemy ([X] + 2) visibility timer] = 0:
$A7:F8C7 BD 7A 0F    LDA $0F7A,x[$7E:117A]  ;\
$A7:F8CA 9D FA 0F    STA $0FFA,x[$7E:11FA]  ;} Enemy ([X] + 2) X position = [enemy X position]
$A7:F8CD BD 7E 0F    LDA $0F7E,x[$7E:117E]  ;\
$A7:F8D0 9D FE 0F    STA $0FFE,x[$7E:11FE]  ;} Enemy ([X] + 2) Y position = [enemy Y position]
$A7:F8D3 AD D3 F4    LDA $F4D3  [$A7:F4D3]  ;\
$A7:F8D6 9D 2E 10    STA $102E,x[$7E:122E]  ;} Enemy ([X] + 2) visibility timer = 8
$A7:F8D9 60          RTS                    ; Return

$A7:F8DA BD 6E 10    LDA $106E,x[$7E:126E]  ;\
$A7:F8DD D0 13       BNE $13    [$F8F2]     ;} If [enemy ([X] + 3) visibility timer] = 0:
$A7:F8DF BD 7A 0F    LDA $0F7A,x[$7E:117A]  ;\
$A7:F8E2 9D 3A 10    STA $103A,x[$7E:123A]  ;} Enemy ([X] + 3) X position = [enemy X position]
$A7:F8E5 BD 7E 0F    LDA $0F7E,x[$7E:117E]  ;\
$A7:F8E8 9D 3E 10    STA $103E,x[$7E:123E]  ;} Enemy ([X] + 3) Y position = [enemy Y position]
$A7:F8EB AD D3 F4    LDA $F4D3  [$A7:F4D3]  ;\
$A7:F8EE 9D 6E 10    STA $106E,x[$7E:126E]  ;} Enemy ([X] + 3) visibility timer = 8
$A7:F8F1 60          RTS                    ; Return

$A7:F8F2 BD AE 10    LDA $10AE,x[$7E:12AE]  ;\
$A7:F8F5 D0 12       BNE $12    [$F909]     ;} If [enemy ([X] + 4) visibility timer] = 0:
$A7:F8F7 BD 7A 0F    LDA $0F7A,x[$7E:117A]  ;\
$A7:F8FA 9D 7A 10    STA $107A,x[$7E:127A]  ;} Enemy ([X] + 4) X position = [enemy X position]
$A7:F8FD BD 7E 0F    LDA $0F7E,x[$7E:117E]  ;\
$A7:F900 9D 7E 10    STA $107E,x[$7E:127E]  ;} Enemy ([X] + 4) Y position = [enemy Y position]
$A7:F903 AD D3 F4    LDA $F4D3  [$A7:F4D3]  ;\
$A7:F906 9D AE 10    STA $10AE,x[$7E:12AE]  ;} Enemy ([X] + 4) visibility timer = 8

$A7:F909 60          RTS
}


;;; $F90A: Load dachora shine palette ;;;
{
$A7:F90A BD B0 0F    LDA $0FB0,x[$7E:11B0]  ;\
$A7:F90D EB          XBA                    ;|
$A7:F90E 29 FF 00    AND #$00FF             ;|
$A7:F911 0A          ASL A                  ;|
$A7:F912 A8          TAY                    ;} Load palette $F2C5 + [enemy palette animation index] * 20h
$A7:F913 B9 2D F9    LDA $F92D,y[$A7:F92D]  ;|
$A7:F916 A8          TAY                    ;|
$A7:F917 20 35 F5    JSR $F535  [$A7:F535]  ;/
$A7:F91A BD B0 0F    LDA $0FB0,x[$7E:11B0]  ;\
$A7:F91D 18          CLC                    ;|
$A7:F91E 69 00 01    ADC #$0100             ;} Increment enemy palette animation index
$A7:F921 9D B0 0F    STA $0FB0,x[$7E:11B0]  ;/
$A7:F924 C9 00 04    CMP #$0400             ;\
$A7:F927 30 03       BMI $03    [$F92C]     ;} If [enemy palette animation index] >= 4:
$A7:F929 9E B0 0F    STZ $0FB0,x[$7E:11B0]  ; Enemy palette index = enemy palette timer = 0

$A7:F92C 60          RTS

$A7:F92D             dw F2C5, F2E5, F305, F325
}


;;; $F935: Dachora function - falling ;;;
{
$A7:F935 BD AA 0F    LDA $0FAA,x[$7E:11AA]  ;\
$A7:F938 18          CLC                    ;|
$A7:F939 6F 32 0B 00 ADC $000B32[$7E:0B32]  ;|
$A7:F93D 9D AA 0F    STA $0FAA,x[$7E:11AA]  ;|
$A7:F940 85 12       STA $12    [$7E:0012]  ;} Enemy speed += [Samus Y acceleration]
$A7:F942 BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;|
$A7:F945 6F 34 0B 00 ADC $000B34[$7E:0B34]  ;|
$A7:F949 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;/
$A7:F94C 85 14       STA $14    [$7E:0014]  ;\
$A7:F94E C9 0A 00    CMP #$000A             ;|
$A7:F951 30 07       BMI $07    [$F95A]     ;|
$A7:F953 A9 0A 00    LDA #$000A             ;} $14.$12 = min([enemy speed], A.0h)
$A7:F956 85 14       STA $14    [$7E:0014]  ;|
$A7:F958 64 12       STZ $12    [$7E:0012]  ;/

$A7:F95A 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A7:F95E 90 2B       BCC $2B    [$F98B]     ; If not collided with block: return
$A7:F960 BD B4 0F    LDA $0FB4,x[$7E:11B4]  ;\
$A7:F963 F0 0E       BEQ $0E    [$F973]     ;} If [enemy direction] != left:
$A7:F965 A9 07 F4    LDA #$F407             ;\
$A7:F968 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $F407 (running right)
$A7:F96B A9 5E F6    LDA #$F65E             ;\
$A7:F96E 9D B2 0F    STA $0FB2,x            ;} Enemy function = $F65E (running right)
$A7:F971 80 0C       BRA $0C    [$F97F]

$A7:F973 A9 45 F3    LDA #$F345             ;\ Else ([enemy direction] = left):
$A7:F976 9D 92 0F    STA $0F92,x[$7E:1192]  ;} Enemy instruction list pointer = $F345 (running left)
$A7:F979 A9 ED F5    LDA #$F5ED             ;\
$A7:F97C 9D B2 0F    STA $0FB2,x[$7E:11B2]  ;} Enemy function = $F5ED (running left)

$A7:F97F A9 01 00    LDA #$0001             ;\
$A7:F982 9D 94 0F    STA $0F94,x[$7E:1194]  ;} Enemy instruction timer = 1
$A7:F985 9E A8 0F    STZ $0FA8,x[$7E:11A8]  ;\
$A7:F988 9E AA 0F    STZ $0FAA,x[$7E:11AA]  ;} Enemy speed = 0.0

$A7:F98B 6B          RTL
}


;;; $F98C: Dachora function - echo ;;;
{
$A7:F98C BD AE 0F    LDA $0FAE,x[$7E:11EE]  ;\
$A7:F98F F0 1C       BEQ $1C    [$F9AD]     ;} If [enemy visibility timer] = 0: go to BRANCH_INVISIBLE
$A7:F991 3A          DEC A                  ;\
$A7:F992 9D AE 0F    STA $0FAE,x[$7E:11EE]  ;} Decrement enemy visibility timer
$A7:F995 8A          TXA                    ;\
$A7:F996 89 40 00    BIT #$0040             ;} If [enemy index] % 40h != 0:
$A7:F999 F0 0A       BEQ $0A    [$F9A5]     ;/
$A7:F99B AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A7:F99E 89 01 00    BIT #$0001             ;} If [frame counter] % 2 != 0: go to BRANCH_VISIBLE
$A7:F9A1 D0 15       BNE $15    [$F9B8]     ;/
$A7:F9A3 80 08       BRA $08    [$F9AD]     ; Go to BRANCH_INVISIBLE

$A7:F9A5 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A7:F9A8 89 01 00    BIT #$0001             ;} If [frame counter] % 2 = 0: go to BRANCH_VISIBLE
$A7:F9AB F0 0B       BEQ $0B    [$F9B8]     ;/

; BRANCH_INVISIBLE
$A7:F9AD BD 86 0F    LDA $0F86,x[$7E:11C6]  ;\
$A7:F9B0 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A7:F9B3 9D 86 0F    STA $0F86,x[$7E:11C6]  ;/
$A7:F9B6 80 09       BRA $09    [$F9C1]     ; Return

; BRANCH_VISIBLE
$A7:F9B8 BD 86 0F    LDA $0F86,x[$7E:11C6]  ;\
$A7:F9BB 29 FF FE    AND #$FEFF             ;} Set enemy as visible
$A7:F9BE 9D 86 0F    STA $0F86,x[$7E:11C6]  ;/

$A7:F9C1 6B          RTL
}


;;; $F9C2: RTL ;;;
{
$A7:F9C2 6B          RTL
}


;;; $F9C3: RTL ;;;
{
$A7:F9C3 6B          RTL
}


;;; $F9C4: Spritemaps ;;;
{
$A7:F9C4             dx 0009, 01F0,F2,3310, C3F8,EA,3301, 0002,F7,331E, 01FA,F7,330E, 01F2,03,331F, 01F2,FB,330F, 01F2,0F,3322, C3FA,07,3313, C3FA,FF,3303
$A7:F9F3             dx 0009, 01EF,F3,3310, C3F7,EB,3301, 0002,F8,335F, 01FA,F8,335E, 01F2,04,331F, 01F2,FC,330F, C3FA,08,3316, 01F2,08,3315, C3FA,00,3306
$A7:FA22             dx 000B, 01EE,F1,3310, C3F6,E9,3301, 01EA,0E,332D, 0002,F6,331E, 01FA,F6,330E, 01F2,FA,330F, C3FA,FE,3309, C3F2,FE,3308, 000A,0E,332B, 000A,06,331B, C3F2,06,3318
$A7:FA5B             dx 0009, 01F0,F2,3310, C3F8,EA,3301, 0002,F7,335F, 01FA,F7,335E, 01F2,0F,3352, 01F2,03,331F, 01F2,FB,330F, C3FA,07,3343, C3FA,FF,3333
$A7:FA8A             dx 0009, 01EF,F3,3310, C3F7,EB,3301, 01F4,10,3352, 01F2,04,331F, 01F2,FC,330F, 0002,F8,331E, 01FA,F8,330E, C3FA,08,3346, C3FA,00,3336
$A7:FAB9             dx 000B, 01EE,F1,3310, C3F6,E9,3301, 0002,F6,335F, 01FA,F6,335E, 01EA,0E,335A, 01F2,FA,330F, C3FA,FE,3339, C3F2,06,3348, 000A,06,334B, 000A,0E,335B, C3F2,FE,3338
$A7:FAF2             dx 0008, 01F6,FD,3305, 01ED,FD,3310, C3F5,F5,3301, 01F3,08,331F, 01F3,00,330F, 0003,FD,331E, 01FB,FD,330E, C3FB,05,330C
$A7:FB1C             dx 000A, 0003,F1,331E, 01FB,F1,330E, 01F3,FD,331F, 01F3,F5,330F, C3FB,F9,333C, 01FE,DF,F341, C3FE,E7,F320, 0003,09,335D, 01FB,09,3350, 01FB,11,3325
$A7:FB50             dx 0009, 01F0,F3,3310, C3F8,EB,3301, 01F3,10,3351, 0003,F8,331E, 01FB,F8,330E, 01F3,04,331F, 01F3,FC,330F, C3FB,08,334C, C3FB,00,333C
$A7:FB7F             dx 000A, 01F9,F3,3340, 01F0,F3,3310, C3F8,EB,3301, 01F3,10,3351, 0003,F8,331E, 01FB,F8,330E, 01F3,04,331F, 01F3,FC,330F, C3FB,08,334C, C3FB,00,333C
$A7:FBB3             dx 000A, 01F9,F3,3305, 01F0,F3,3310, C3F8,EB,3301, 01F3,10,3351, 0003,F8,331E, 01FB,F8,330E, 01F3,04,331F, 01F3,FC,330F, C3FB,08,334C, C3FB,00,333C
$A7:FBE7             dx 0009, 01E5,09,332A, C3E3,F9,333E, 0003,F8,332F, 01FB,F8,332E, 01F3,08,3345, 01F3,00,3335, 01F3,10,3351, C3FB,08,334C, C3FB,00,333C
$A7:FC16             dx 0009, 0003,F8,332F, 01FB,F8,332E, 01EB,11,3341, C3E3,01,3320, 01F3,08,3342, 01F3,00,3332, 01F3,10,3351, C3FB,08,334C, C3FB,00,333C
$A7:FC45             dx 0009, 0003,F8,332F, 01FB,F8,332E, 01EB,12,3341, C3E3,02,3320, 01F3,08,3342, 01F3,00,3332, 01F3,10,3351, C3FB,08,334C, C3FB,00,333C
$A7:FC74             dx 0009, 0003,F8,332F, 01FB,F8,332E, 01EB,13,3341, C3E3,03,3320, 01F3,08,3342, 01F3,00,3332, 01F3,10,3351, C3FB,08,334C, C3FB,00,333C
$A7:FCA3             dx 0009, 0008,F2,7310, C3F8,EA,7301, 01F6,F7,731E, 01FE,F7,730E, 0006,03,731F, 0006,FB,730F, 0006,0F,7322, C3F6,07,7313, C3F6,FF,7303
$A7:FCD2             dx 0009, 0009,F3,7310, C3F9,EB,7301, 01F6,F8,735F, 01FE,F8,735E, 0006,04,731F, 0006,FC,730F, C3F6,08,7316, 0006,08,7315, C3F6,00,7306
$A7:FD01             dx 000B, 000A,F1,7310, C3FA,E9,7301, 000E,0E,732D, 01F6,F6,731E, 01FE,F6,730E, 0006,FA,730F, C3F6,FE,7309, C3FE,FE,7308, 01EE,0E,732B, 01EE,06,731B, C3FE,06,7318
$A7:FD3A             dx 0009, 0008,F2,7310, C3F8,EA,7301, 01F6,F7,735F, 01FE,F7,735E, 0006,0F,7352, 0006,03,731F, 0006,FB,730F, C3F6,07,7343, C3F6,FF,7333
$A7:FD69             dx 0009, 0009,F3,7310, C3F9,EB,7301, 0004,10,7352, 0006,04,731F, 0006,FC,730F, 01F6,F8,731E, 01FE,F8,730E, C3F6,08,7346, C3F6,00,7336
$A7:FD98             dx 000B, 000A,F1,7310, C3FA,E9,7301, 01F6,F6,735F, 01FE,F6,735E, 000E,0E,735A, 0006,FA,730F, C3F6,FE,7339, C3FE,06,7348, 01EE,06,734B, 01EE,0E,735B, C3FE,FE,7338
$A7:FDD1             dx 0008, 0002,FD,7305, 000B,FD,7310, C3FB,F5,7301, 0005,08,731F, 0005,00,730F, 01F5,FD,731E, 01FD,FD,730E, C3F5,05,730C
$A7:FDFB             dx 000A, 01F5,F1,731E, 01FD,F1,730E, 0005,FD,731F, 0005,F5,730F, C3F5,F9,733C, 01FA,DF,B341, C3F2,E7,B320, 01F5,09,735D, 01FD,09,7350, 01FD,11,7325
$A7:FE2F             dx 0009, 0008,F3,7310, C3F8,EB,7301, 0005,10,7351, 01F5,F8,731E, 01FD,F8,730E, 0005,04,731F, 0005,FC,730F, C3F5,08,734C, C3F5,00,733C
$A7:FE5E             dx 000A, 01FF,F3,7340, 0008,F3,7310, C3F8,EB,7301, 0005,10,7351, 01F5,F8,731E, 01FD,F8,730E, 0005,04,731F, 0005,FC,730F, C3F5,08,734C, C3F5,00,733C
$A7:FE92             dx 000A, 01FF,F3,7305, 0008,F3,7310, C3F8,EB,7301, 0005,10,7351, 01F5,F8,731E, 01FD,F8,730E, 0005,04,731F, 0005,FC,730F, C3F5,08,734C, C3F5,00,733C
$A7:FEC6             dx 0009, 0013,09,732A, C20D,F9,733E, 01F5,F8,732F, 01FD,F8,732E, 0005,08,7345, 0005,00,7335, 0005,10,7351, C3F5,08,734C, C3F5,00,733C
$A7:FEF5             dx 0009, 01F5,F8,732F, 01FD,F8,732E, 000D,11,7341, C20D,01,7320, 0005,08,7342, 0005,00,7332, 0005,10,7351, C3F5,08,734C, C3F5,00,733C
$A7:FF24             dx 0009, 01F5,F8,732F, 01FD,F8,732E, 000D,12,7341, C20D,02,7320, 0005,08,7342, 0005,00,7332, 0005,10,7351, C3F5,08,734C, C3F5,00,733C
$A7:FF53             dx 0009, 01F5,F8,732F, 01FD,F8,732E, 000D,13,7341, C20D,03,7320, 0005,08,7342, 0005,00,7332, 0005,10,7351, C3F5,08,734C, C3F5,00,733C
}
}


;;; $FF82: Free space ;;;
{
$A7:FF82             fillto $A88000, $FF
}
